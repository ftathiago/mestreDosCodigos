echo off
CodeCoverage.exe -e "OMestreDosCodigosTeste.exe" -m "OMestreDosCodigosTeste.map" -ife -uf dcov_units.lst -spf dcov_paths.lst -od "emma\" -lt -emma -meta -xml -html
emma\CodeCoverage_summary.html
pause