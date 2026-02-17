# dbt Helper Script
# This script adds dbt to PATH for the current PowerShell session

$dbtPath = "C:\Users\mvp\AppData\Local\Programs\Python\Python312\Scripts"
$env:PATH = "$dbtPath;" + $env:PATH

Write-Host "✅ dbt is now available in this session!" -ForegroundColor Green
Write-Host ""
Write-Host "Available commands:" -ForegroundColor Cyan
Write-Host "  dbt debug              - Test your connection"
Write-Host "  dbt run                - Run all models"
Write-Host "  dbt run --select model - Run specific model"
Write-Host "  dbt test               - Run tests"
Write-Host "  dbt docs generate      - Generate documentation"
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "1. Edit C:\Users\mvp\.dbt\profiles.yml with your SQL Server details"
Write-Host "2. Edit models\sources.yml with your table names"
Write-Host "3. Run: dbt debug"
Write-Host ""
