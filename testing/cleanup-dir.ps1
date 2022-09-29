$files = Get-ChildItem 'E:\Scripts\New folder\' -Recurse  -Exclude 'E:\Scripts\New folder'
foreach ($f in $files){
$lastmodifiedtime = $f.LastWriteTime
if ($lastmodifiedtime -lt (Get-Date).AddHours(-24*7)) {Remove-Item $f -recurse -force}
}
