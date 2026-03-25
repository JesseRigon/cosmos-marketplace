#!/usr/bin/env pwsh
# Download missing icon.png files from manhtuong.net marketplace

$missingApps = @{
    'Changedetection' = 'https://cosmos.manhtuong.net/servapps/Changedetection/logo/channels4_profile.jpg'
    'Chatwoot' = 'https://cosmos.manhtuong.net/servapps/Chatwoot/logo/1233.webp'
    'Crawlab' = 'https://cosmos.manhtuong.net/servapps/Crawlab/logo/cover.jpg'
    'Doku' = 'https://cosmos.manhtuong.net/servapps/Doku/logo/doku7384.jpg'
    'Factorio' = 'https://cosmos.manhtuong.net/servapps/Factorio/logo/nhlwaif0sfa11.webp'
    'Fastapi' = 'https://cosmos.manhtuong.net/servapps/Fastapi/logo/fastapi.svg'
    'Hasty-Paste' = 'https://cosmos.manhtuong.net/servapps/Hasty-Paste/logo/icon.svg'
    'Hoppscotch' = 'https://cosmos.manhtuong.net/servapps/Hoppscotch/logo/logo.svg'
    'Invidious' = 'https://cosmos.manhtuong.net/servapps/Invidious/logo/invidious-colored-vector.svg'
    'Mattermost' = 'https://cosmos.manhtuong.net/servapps/Mattermost/logo/numix-circle-for-windows-mattermost.jpg'
    'MinIO' = 'https://cosmos.manhtuong.net/servapps/MinIO/logo/minio-logo.jpg'
    'NetAlertX' = 'https://cosmos.manhtuong.net/servapps/NetAlertX/logo/doku7384.jpg'
    'Onedev' = 'https://cosmos.manhtuong.net/servapps/Onedev/logo/logo.svg'
    'Openobserve' = 'https://cosmos.manhtuong.net/servapps/Openobserve/logo/Wp6HKCpz_400x400.jpg'
    'Plane' = 'https://cosmos.manhtuong.net/servapps/Plane/logo/plane-logo-with-text.webp'
    'Social-Analyzer' = 'https://cosmos.manhtuong.net/servapps/Social-Analyzer/logo/logo.jpg'
    'Umami' = 'https://cosmos.manhtuong.net/servapps/Umami/logo/_u-7zTZM_400x400.jpg'
    'WebGoat' = 'https://cosmos.manhtuong.net/servapps/WebGoat/logo/OWASP-300x298.webp'
}

Write-Host "=== Downloading Missing Icons ===" -ForegroundColor Cyan
Write-Host "Total apps to fix: $($missingApps.Count)" -ForegroundColor Cyan
Write-Host ""

$successCount = 0
$errorCount = 0

foreach ($app in $missingApps.Keys) {
    $url = $missingApps[$app]
    $iconPath = "servapps\$app\icon.png"
    
    Write-Host "[$app]" -NoNewline -ForegroundColor Yellow
    
    try {
        # Download the icon
        Invoke-WebRequest -Uri $url -OutFile $iconPath -ErrorAction Stop
        Write-Host " [OK] Downloaded" -ForegroundColor Green
        $successCount++
    }
    catch {
        Write-Host " [FAIL] $($_.Exception.Message)" -ForegroundColor Red
        $errorCount++
    }
}

Write-Host ""
Write-Host "=== Summary ===" -ForegroundColor Cyan
Write-Host "Success: $successCount" -ForegroundColor Green
Write-Host "Errors: $errorCount" -ForegroundColor Red
