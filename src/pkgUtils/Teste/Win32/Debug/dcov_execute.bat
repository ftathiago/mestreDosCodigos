CodeCoverage.exe -e "pkgUtilsTeste.exe" -m "pkgUtilsTeste.map" -uf dcov_units.lst -spf dcov_paths.lst -od "emma" -lt -emma -meta -xml -html 
cd emma
CodeCoverage_summary.html
