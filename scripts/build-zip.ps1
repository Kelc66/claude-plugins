<#
.SYNOPSIS
  Rebuilds dist/<skill>.zip for every skill in plugins/*/skills/*.

.DESCRIPTION
  Each zip has the skill folder as its root (e.g. lecture-to-notes/SKILL.md),
  which is what claude.ai expects for Customize > Skills > Upload a skill.
  Uses .NET ZipFile with forward-slash entry names (Compress-Archive in
  Windows PowerShell 5.1 writes backslashes, which breaks some unzippers).

.EXAMPLE
  powershell -ExecutionPolicy Bypass -File scripts\build-zip.ps1
#>
$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.IO.Compression
Add-Type -AssemblyName System.IO.Compression.FileSystem

$repoRoot = Split-Path -Parent $PSScriptRoot
$dist = Join-Path $repoRoot 'dist'
New-Item -ItemType Directory -Force -Path $dist | Out-Null

$skipNames = @('.DS_Store', 'Thumbs.db', 'desktop.ini')
$skillDirs = Get-ChildItem -Path (Join-Path $repoRoot 'plugins') -Directory |
    ForEach-Object { Join-Path $_.FullName 'skills' } |
    Where-Object { Test-Path $_ } |
    ForEach-Object { Get-ChildItem -Path $_ -Directory } |
    Where-Object { Test-Path (Join-Path $_.FullName 'SKILL.md') }

if (-not $skillDirs) { throw 'No skills found under plugins/*/skills/*/SKILL.md' }

foreach ($skill in $skillDirs) {
    $zipPath = Join-Path $dist ($skill.Name + '.zip')
    if (Test-Path $zipPath) { Remove-Item $zipPath -Force }

    $zip = [System.IO.Compression.ZipFile]::Open($zipPath, [System.IO.Compression.ZipArchiveMode]::Create)
    try {
        $files = Get-ChildItem -Path $skill.FullName -Recurse -File |
            Where-Object { $skipNames -notcontains $_.Name } |
            Sort-Object FullName
        foreach ($file in $files) {
            $relative = $file.FullName.Substring($skill.FullName.Length).TrimStart('\', '/')
            $entryName = ($skill.Name + '/' + $relative) -replace '\\', '/'
            [System.IO.Compression.ZipFileExtensions]::CreateEntryFromFile(
                $zip, $file.FullName, $entryName, [System.IO.Compression.CompressionLevel]::Optimal) | Out-Null
        }
    }
    finally {
        $zip.Dispose()
    }
    Write-Host ("Built {0} ({1} files)" -f (Resolve-Path $zipPath), $files.Count)
}
