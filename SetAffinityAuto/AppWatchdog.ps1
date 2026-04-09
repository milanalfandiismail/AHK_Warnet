# App Affinity Watchdog
$ScriptRoot = $PSScriptRoot
$ConfigFile = Join-Path $ScriptRoot "config.ini"
$AppListFile = Join-Path $ScriptRoot "app.ini"

# Default values
$AffinityMask = 30
$SleepSeconds = 10
$AppNames = @()

# Baca config.ini (affinity & sleep)
if (Test-Path $ConfigFile) {
    $lines = Get-Content $ConfigFile
    foreach ($line in $lines) {
        if ($line -match "^affinity\s*=\s*(\d+)") {
            $AffinityMask = [int]$matches[1]
        }
        elseif ($line -match "^sleep\s*=\s*(\d+)") {
            $SleepSeconds = [int]$matches[1]
        }
    }
}

# Baca app.ini (daftar aplikasi, satu per baris)
if (Test-Path $AppListFile) {
    $AppNames = Get-Content $AppListFile | Where-Object { $_ -notmatch "^#" -and $_ -ne "" } | ForEach-Object { $_.Trim() }
}

# Fallback kalau app.ini kosong
if ($AppNames.Count -eq 0) {
    $AppNames = @("brave", "Discord")
}

# Loop utama
while ($true) {
    foreach ($AppName in $AppNames) {
        $processes = Get-Process -Name $AppName -ErrorAction SilentlyContinue
        
        foreach ($proc in $processes) {
            if ($proc.ProcessorAffinity -ne $AffinityMask) {
                try {
                    $proc.ProcessorAffinity = $AffinityMask
                } catch {
                    # Ignore
                }
            }
        }
    }
    
    Start-Sleep -Seconds $SleepSeconds
}