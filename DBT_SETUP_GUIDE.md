# dbt SQL Server Connection Guide

## ✅ Installation Complete
- Python 3.12: Installed
- dbt-core 1.11.5: Installed
- dbt-sqlserver 1.9.0: Installed

## 📝 Next Steps

### 1. Configure Your Database Connection
Edit the profile at: `C:\Users\mvp\.dbt\profiles.yml`

Replace these placeholders:
- `YOUR_SERVER_NAME_OR_IP` - Your SQL Server address (e.g., "10.0.0.10" or "MYSERVER\\INSTANCE")
- `YOUR_DATABASE_NAME` - Target database name
- `YOUR_SQL_USERNAME` - SQL Server login username
- `YOUR_SQL_PASSWORD` - SQL Server login password

**For Windows Authentication instead of SQL login:**
```yaml
authentication: windows
# Remove user and password lines
```

### 2. Update Your Source Configuration
Edit: `models/sources.yml`

Replace:
- `your_table_name` with the actual table(s) you want to query
- Schema name if different from `dbo`

### 3. Update Your Model
Edit: `models/my_first_model.sql`

Update the source reference to match your table name.

### 4. Test Your Connection
```powershell
C:\Users\mvp\AppData\Local\Programs\Python\Python312\Scripts\dbt.exe debug
```

### 5. Run Your First Model
```powershell
C:\Users\mvp\AppData\Local\Programs\Python\Python312\Scripts\dbt.exe run --select my_first_model
```

## 🔧 Useful Commands

```powershell
# Set up environment (run once per terminal session)
$env:PATH = "C:\Users\mvp\AppData\Local\Programs\Python\Python312\Scripts;" + $env:PATH

# Then you can use shorter commands:
dbt debug              # Test connection
dbt run                # Run all models
dbt run --select my_first_model  # Run specific model
dbt test               # Run tests
dbt docs generate      # Generate documentation
dbt docs serve         # View documentation
```

## 📚 File Structure
```
models/
  ├── sources.yml          # Define your source databases/tables
  ├── my_first_model.sql   # Example model querying on-prem data
  └── customers.sql        # Original example model
```

## 🔍 ODBC Driver
Make sure you have "ODBC Driver 18 for SQL Server" installed. If not, download from:
https://learn.microsoft.com/en-us/sql/connect/odbc/download-odbc-driver-for-sql-server

To check installed drivers:
```powershell
Get-OdbcDriver | Where-Object {$_.Name -like "*SQL Server*"}
```
