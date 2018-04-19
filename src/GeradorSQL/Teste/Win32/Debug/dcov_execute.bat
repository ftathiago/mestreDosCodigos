echo off
CodeCoverage.exe -e "GeradorSQLTeste.exe" -m "GeradorSQLTeste.map" -ife -uf dcov_units.lst -spf dcov_paths.lst -od "emma\" -lt -emma -meta -xml -html
emma\CodeCoverage_summary.html
pause