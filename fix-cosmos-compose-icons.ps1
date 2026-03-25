# Fix cosmos-icon URLs in cosmos-compose.json files
# Replace old /logo/ subdirectory paths with new /icon.png structure

$servappsPath = ".\servapps"
$baseURL = "https://jesserigon.github.io/cosmos-marketplace/servapps"

Write-Host "Fixing cosmos-icon URLs in cosmos-compose.json files..." -ForegroundColor Cyan
Write-Host ""

$totalFixed = 0
$filesFixed = 0

# Get all cosmos-compose.json files
$composeFiles = Get-ChildItem -Path $servappsPath -Filter "cosmos-compose.json" -Recurse

foreach ($file in $composeFiles) {
    $appName = $file.Directory.Name
    $content = Get-Content $file.FullName -Raw
    
    # Check if file contains old logo path
    if ($content -match '/logo/') {
        # Create the new icon URL
        $newIconURL = "$baseURL/$appName/icon.png"
        
        # Replace any cosmos-icon URL that contains /logo/ with the new structure
        $pattern = "$baseURL/$appName/logo/[^`"]+`""
        $replacement = "$newIconURL`""
        
        $newContent = $content -replace $pattern, $replacement
        
        # Count how many replacements were made
        if ($newContent -ne $content) {
            $oldMatches = [regex]::Matches($content, $pattern)
            $count = $oldMatches.Count
            
            Set-Content -Path $file.FullName -Value $newContent -NoNewline
            
            Write-Host "Fixed $count icon reference(s) in: $appName" -ForegroundColor Green
            $totalFixed += $count
            $filesFixed++
        }
    }
}

Write-Host ""
Write-Host "Summary:" -ForegroundColor Yellow
Write-Host "  Files fixed: $filesFixed" -ForegroundColor White
Write-Host "  Total icon URLs updated: $totalFixed" -ForegroundColor White
