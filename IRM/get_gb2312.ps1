$ErrorActionPreference = "Stop"
# Enable TLSv1.2 for compatibility with older clients
[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12

$DownloadURL1CN = 'https://cdn.jsdelivr.net/gh/Myitian/Microsoft-Activation-Scripts-CNTranslated@master/MAS/All-In-One-Version/MAS_AIO_GB2312.cmd'
$DownloadURL2CN = 'https://raw.githubusercontent.com/Myitian/Microsoft-Activation-Scripts-CNTranslated/master/MAS/All-In-One-Version/MAS_AIO_GB2312.cmd'
$DownloadURL1EN = 'https://gitlab.com/massgrave/microsoft-activation-scripts/-/raw/master/MAS/All-In-One-Version/MAS_AIO.cmd'
$DownloadURL2EN = 'https://raw.githubusercontent.com/massgravel/Microsoft-Activation-Scripts/master/MAS/All-In-One-Version/MAS_AIO.cmd'

$rand = Get-Random -Maximum 1000
$isAdmin = [bool]([Security.Principal.WindowsIdentity]::GetCurrent().Groups -match 'S-1-5-32-544')
$FilePath = if ($isAdmin) { "$env:SystemRoot\Temp\MAS_$rand.cmd" } else { "$env:TEMP\MAS_$rand.cmd" }

try {
    $response = Invoke-WebRequest -Uri $DownloadURL1CN -UseBasicParsing
}
catch {
    "获取中文脚本失败，使用备用地址"
    try {
        $response = Invoke-WebRequest -Uri $DownloadURL2CN -UseBasicParsing
    }
    catch {
        "获取中文脚本失败，使用备用英文脚本"
        try {
            $response = Invoke-WebRequest -Uri $DownloadURL1EN -UseBasicParsing
        }
        catch {
            try {
                "获取英文脚本失败，使用备用地址"
                $response = Invoke-WebRequest -Uri $DownloadURL2EN -UseBasicParsing
            }
            catch {
                "获取脚本失败"
            }
        }
    }
}

$ScriptArgs = "$args "
$prefix = "@REM $rand `r`n"
$content = $prefix + $response.Content

[System.IO.File]::WriteAllText($FilePath, $content, [System.Text.Encoding]::Default)

Start-Process $FilePath $ScriptArgs -Wait

$FilePaths = @("$env:TEMP\MAS*.cmd", "$env:SystemRoot\Temp\MAS*.cmd")
foreach ($FilePath in $FilePaths) { Get-Item $FilePath | Remove-Item }