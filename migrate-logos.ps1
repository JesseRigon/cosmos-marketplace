#!/usr/bin/env pwsh
# Migrate logo files from logo/ subdirectories to icon.png in app root

$servappsPath = "servapps"
$apps = Get-ChildItem -Path $servappsPath -Directory
$successCount = 0
$skipCount = 0
$errorCount = 0

Write-Host "=== Logo Migration Script ===" -ForegroundColor Cyan
Write-Host "Processing $($apps.Count) apps..." -ForegroundColor Cyan
Write-Host ""

foreach ($app in $apps) {
    $appName = $app.Name
    $logoDir = Join-Path $app.FullName "logo"
    $iconPath = Join-Path $app.FullName "icon.png"
    
    # Skip if icon.png already exists
    if (Test-Path $iconPath) {
        Write-Host "[SKIP] $appName - icon.png already exists" -ForegroundColor Yellow
        $skipCount++
        continue
    }
    
    # Skip if no logo directory
    if (-not (Test-Path $logoDir)) {
        Write-Host "[SKIP] $appName - no logo directory" -ForegroundColor Yellow
        $skipCount++
        continue
    }
    
    # Find PNG files in logo directory
    $logoFiles = Get-ChildItem -Path $logoDir -Filter "*.png" -File
    
    if ($logoFiles.Count -eq 0) {
        Write-Host "[WARN] $appName - no PNG files in logo directory" -ForegroundColor Magenta
        $errorCount++
        continue
    }
    
    # Use the first PNG file found (or icon.png if it exists in logo dir)
    $sourceFile = $logoFiles | Where-Object { $_.Name -eq "icon.png" } | Select-Object -First 1
    if (-not $sourceFile) {
        $sourceFile = $logoFiles | Select-Object -First 1
    }
    
    try {
        # Copy the logo file to icon.png in app root
        Copy-Item -Path $sourceFile.FullName -Destination $iconPath -Force
        Write-Host "[OK] $appName - copied $($sourceFile.Name) -> icon.png" -ForegroundColor Green
        $successCount++
    }
    catch {
        Write-Host "[ERROR] $appName - $_" -ForegroundColor Red
        $errorCount++
    }
}

Write-Host ""
Write-Host "=== Migration Summary ===" -ForegroundColor Cyan
Write-Host "Success: $successCount" -ForegroundColor Green
Write-Host "Skipped: $skipCount" -ForegroundColor Yellow
Write-Host "Errors:  $errorCount" -ForegroundColor Red
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Cyan
Write-Host "1. Review the changes" -ForegroundColor White
Write-Host "2. Run 'node index.js' to regenerate JSON files" -ForegroundColor White
Write-Host "3. Optionally remove logo/ directories: Remove-Item servapps/*/logo -Recurse -Force" -ForegroundColor White
