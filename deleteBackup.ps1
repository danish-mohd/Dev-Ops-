Get-ChildItem 'D:\Backup' -Recurse -Include *.trn, *.bak -File |
Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-7) } |
Remove-Item
