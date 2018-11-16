param([string]$uri, [string]$name = '', [string]$cwd = '.', [string]$tools)
if ($name -eq '') {
    $regex = [regex]'[^/]*$'
    $name = $regex.Match($uri)[0].value
}
function Sanitize {
    param([string]$str)
    $str = $str -replace '` ', ' '
    $str = $str -replace ' ', '` '
    return $str
}
$uri = Sanitize $uri
$name = Sanitize $name
$tools = Sanitize $tools

function Main {
    Download-File $uri $name
}

function Download-File {
    param([string]$uri, [string]$fileName)
    "Downloading $uri"
    $downloadPath = "$cwd\$fileName"
    $startTime = Get-Date
    $proxyUri = [Uri]$null
    if ($IsWindows) {
        $proxy = [System.Net.WebRequest]::GetSystemWebProxy()
        if ($proxy) {
            $proxy.Credentials = [System.Net.CredentialCache]::DefaultCredentials
            $proxyUri = $proxy.GetProxy($uri)
        }
    }
    if ($proxyUri) {
        "Using proxy: $proxyUri"
        Invoke-WebRequest -Uri $uri -OutFile $downloadPath -Proxy $proxyUri -ProxyUseDefaultCredentials
    } else {
        Invoke-WebRequest -Uri $uri -OutFile $downloadPath
    }
    "Writing to $downloadPath"
    "Time taken: $((Get-Date).Subtract($startTime).Seconds) second(s)"
}

Main
