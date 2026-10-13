Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$root = Split-Path -Parent $PSScriptRoot
Push-Location $root
try {
    $failures = [System.Collections.Generic.List[string]]::new()
    foreach ($line in Get-Content 'SHA256SUMS.txt') {
        if ($line -notmatch '^(?<hash>[0-9A-F]{64})  (?<path>.+)$') { continue }
        $path = $Matches.path
        if (-not (Test-Path -LiteralPath $path)) {
            $failures.Add("Missing manifest artifact: $path")
            continue
        }
        $actual = (Get-FileHash -Algorithm SHA256 -LiteralPath $path).Hash
        if ($actual -ne $Matches.hash) {
            $failures.Add("Checksum mismatch: $path")
        }
    }

    if (Select-String -Path 'docs/FLASHING.md' -Pattern 'Monitor-Upper-v0\.8\.0\.15' -Quiet) {
        $failures.Add('Flashing guide refers to obsolete UB4 V0.8.0.15.')
    }

    Get-ChildItem 'firmware-control/configs' -Filter '*.json' | ForEach-Object {
        $config = Get-Content -Raw $_ | ConvertFrom-Json
        foreach ($set in $config.rom_sets) {
            foreach ($rom in $set.roms) {
                if ($rom.file -match '^https?://') {
                    $failures.Add("Remote ROM input in $($_.Name): $($rom.file)")
                }
            }
        }
    }

    if ($failures.Count) { throw ($failures -join [Environment]::NewLine) }
    Write-Host 'Release verification passed.'
}
finally {
    Pop-Location
}
