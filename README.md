

# mathsathomeapp
App for UCL IOE mathematical development research - mobile application available in both IOS and Android, coded using Flutter and Dart

To run export PATH=~/Downloads/flutter/bin:$PATH
(Temporary here to run for Ege)

For ODBC Driver
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
brew tap microsoft/mssql-release https://github.com/Microsoft/homebrew-mssql-release
brew update
HOMEBREW_ACCEPT_EULA=Y brew install msodbcsql18 mssql-tools18

Instructions:
brew install unixodbc
pip uninstall pyodbc
pip install --no-binary :all: pyodbc

Driver: https://learn.microsoft.com/en-us/sql/connect/odbc/download-odbc-driver-for-sql-server?view=sql-server-ver16&redirectedfrom=MSDN
