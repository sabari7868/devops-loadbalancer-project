# auto_scaler.ps1
# Monitors app1 CPU; if ≥70%, spins up app3

# Configuration
$ContainerName = "app1"
$NewService    = "app3"
$Threshold     = 70



while ($true) {
    # Get CPU% (strip the % sign and convert to int)
    $stats = docker stats $ContainerName --no-stream --format "{{.CPUPerc}}"
    $cpu   = [int]($stats.TrimEnd('%'))

    Write-Host "[$(Get-Date -Format T)] CPU Usage: $cpu%"

    if ($cpu -ge $Threshold) {
        print 'ENTRY POINT '
        Write-Host "⚠️  CPU ≥ $Threshold% — starting service $NewService..."
        docker compose up -d $NewService
        break
    }
    Start-Sleep -Seconds 10
}

