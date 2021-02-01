[CmdletBinding()] 
param(
    [string]
    [ValidateNotNullOrEmpty()]
    $Location,
    [string]
    [ValidateNotNullOrEmpty()]
    $Library,
    [string]
    [ValidateNotNullOrEmpty()]
    $Version)
    
    $localpath = Join-Path $Location $Library
    $URL = ("https://github.com/microsoft/ApplicationInsights-Java/releases/download/{0}/{1}" -f $Version, $Library)
    (New-Object System.Net.WebClient).DownloadFile($URL, $localpath)

return @{'library' = $Library} | ConvertTo-Json