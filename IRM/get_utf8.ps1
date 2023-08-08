$ErrorActionPreference = "Stop"
# Enable TLSv1.2 for compatibility with older clients
[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12

$DownloadURL1CN = '' # 'https://gitlab.com/massgrave/microsoft-activation-scripts/-/raw/master/MAS/All-In-One-Version/MAS_AIO.cmd'
$DownloadURL2CN = 'https://cdn.jsdelivr.net/gh/Myitian/Microsoft-Activation-Scripts-CNTranslated@master/MAS/All-In-One-Version/MAS_AIO_UTF8.cmd'
$DownloadURL3CN = 'https://raw.githubusercontent.com/Myitian/Microsoft-Activation-Scripts-CNTranslated/master/MAS/All-In-One-Version/MAS_AIO_UTF8.cmd'
$DownloadURL1EN = 'https://gitlab.com/massgrave/microsoft-activation-scripts/-/raw/master/MAS/All-In-One-Version/MAS_AIO.cmd'
$DownloadURL2EN = 'https://raw.githubusercontent.com/massgravel/Microsoft-Activation-Scripts/master/MAS/All-In-One-Version/MAS_AIO.cmd'

$rand = Get-Random -Maximum 1000
$isAdmin = [bool]([Security.Principal.WindowsIdentity]::GetCurrent().Groups -match 'S-1-5-32-544')
$FilePath = if ($isAdmin) { "$env:SystemRoot\Temp\MAS_$rand.cmd" } else { "$env:TEMP\MAS_$rand.cmd" }

try {
    $response = Invoke-WebRequest -Uri $DownloadURL1CN -UseBasicParsing
}
catch {
    "`u{83b7}`u{53d6}`u{4e2d}`u{6587}`u{811a}`u{672c}`u{5931}`u{8d25}`u{ff0c}`u{4f7f}`u{7528}`u{5907}`u{7528}`u{5730}`u{5740}"
    try {
        $response = Invoke-WebRequest -Uri $DownloadURL2CN -UseBasicParsing
    }
    catch {
        "`u{83b7}`u{53d6}`u{4e2d}`u{6587}`u{811a}`u{672c}`u{5931}`u{8d25}`u{ff0c}`u{4f7f}`u{7528}`u{5907}`u{7528}`u{5730}`u{5740}"
        try {
            $response = Invoke-WebRequest -Uri $DownloadURL3CN -UseBasicParsing
        }
        catch {
            "`u{83b7}`u{53d6}`u{4e2d}`u{6587}`u{811a}`u{672c}`u{5931}`u{8d25}`u{ff0c}`u{4f7f}`u{7528}`u{5907}`u{7528}`u{82f1}`u{6587}`u{811a}`u{672c}"
            try {
                $response = Invoke-WebRequest -Uri $DownloadURL1EN -UseBasicParsing
            }
            catch {
                try {
                    "`u{83b7}`u{53d6}`u{82f1}`u{6587}`u{811a}`u{672c}`u{5931}`u{8d25}`u{ff0c}`u{4f7f}`u{7528}`u{5907}`u{7528}`u{5730}`u{5740}"
                    $response = Invoke-WebRequest -Uri $DownloadURL2EN -UseBasicParsing
                }
                catch {
                    "`u{83b7}`u{53d6}`u{811a}`u{672c}`u{5931}`u{8d25}"
                }
            }
        }
    }
}

$ScriptArgs = "$args "
$prefix = "@REM $rand `r`n"
$content = $prefix + $response.Content

[System.IO.File]::WriteAllText($FilePath, $content, [System.Text.Encoding]::GetEncoding(0))

Start-Process $FilePath $ScriptArgs -Wait

$FilePaths = @("$env:TEMP\MAS*.cmd", "$env:SystemRoot\Temp\MAS*.cmd")
foreach ($FilePath in $FilePaths) { Get-Item $FilePath | Remove-Item }