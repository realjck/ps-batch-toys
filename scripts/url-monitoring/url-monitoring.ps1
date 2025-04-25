$urlFile = "urls.txt"

if (-not (Test-Path -Path $urlFile)) {
    "www.google.com" | Out-File -FilePath $urlFile -Encoding UTF8
    Write-Host "File $urlFile created with default URLs."
}

$urls = Get-Content -Path $urlFile

foreach ($url in $urls) {
    if (-not $url.StartsWith("http")) {
        $url = "https://" + $url
    }
    
    try {
        $response = Invoke-WebRequest -Uri $url -Method Get -ErrorAction Stop -UseBasicParsing -MaximumRedirection 5
        
        if ($response.StatusCode -ge 200 -and $response.StatusCode -lt 400) {
            Write-Host "$url " -NoNewline
            Write-Host "[OK] (HTTP $($response.StatusCode))" -ForegroundColor Green
        } else {
            Write-Host "$url " -NoNewline
            Write-Host "[WARNING] (HTTP $($response.StatusCode))" -ForegroundColor Yellow
        }
    } catch {
        Write-Host "$url " -NoNewline
        if ($_.Exception.Response) {
            $statusCode = $_.Exception.Response.StatusCode.value__
            Write-Host "[FAILED] (HTTP $statusCode)" -ForegroundColor Red
            Write-Host "  Détails : $($_.Exception.Message)" -ForegroundColor DarkGray
        } else {
            Write-Host "[FAILED] (Erreur: $($_.Exception.Message))" -ForegroundColor Red
        }
    }
}

Write-Host "`nTests completed" -ForegroundColor Yellow
Write-Host "Press any key to close..."
[Console]::ReadKey($true) | Out-Null