# App Affinity Watchdog (Brave + Discord)
$AffinityMask = 30
$LockFile = Join-Path $PSScriptRoot "app_watchdog.lock"

# LOCKFILE CHECK
if (Test-Path $LockFile) {
    exit
}

# Buat lockfile
"ACTIVE" | Out-File -FilePath $LockFile

# Daftar aplikasi yang dipantau
$AppNames = @("brave", "Discord")

# Loop utama
while ($true) {
    foreach ($AppName in $AppNames) {
        $processes = Get-Process -Name $AppName -ErrorAction SilentlyContinue
        
        foreach ($proc in $processes) {
            if ($proc.ProcessorAffinity -ne $AffinityMask) {
                try {
                    $proc.ProcessorAffinity = $AffinityMask
                } catch {
                    # Proses mungkin mati mendadak, ignore
                }
            }
        }
    }
    
    Start-Sleep -Seconds 10
}