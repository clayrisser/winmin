param([string]$url, [string]$name, [string]$cwd, [string]$tools)

function Main {
    Download-File $url $name
}

function Download-File {
    param([string]$url, [string]$fileName)
    $downloadPath = "$cwd\$fileName"
    $start_time = Get-Date
    Write-Output "Downloading $url"
    $proxyUri = [Uri]$null
    $proxy = [System.Net.WebRequest]::GetSystemWebProxy()
    if ($proxy) {
        $proxy.Credentials = [System.Net.CredentialCache]::DefaultCredentials

        $proxyUri = $proxy.GetProxy("$url")
    }
    if ("$proxyUri" -ne "$server$url") {
        Write-Host "Using proxy: $proxyUri"
        Invoke-WebRequest -Uri $url -OutFile $downloadPath -Proxy $proxyUri -ProxyUseDefaultCredentials
    } else {
        Invoke-WebRequest -Uri $url -OutFile $downloadPath
    }
    Write-Output "Writing to $output"
    Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"
}

Main
