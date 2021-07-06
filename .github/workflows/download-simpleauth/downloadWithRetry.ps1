function Retry-Command {
    [CmdletBinding()]
    Param(
        [Parameter(Position=0, Mandatory=$true)]
        [scriptblock]$ScriptBlock,

        [Parameter(Position=1, Mandatory=$false)]
        [int]$Maximum = 5,

        [Parameter(Position=2, Mandatory=$false)]
        [int]$Delay = 100
    )

    Begin {
        $cnt = 0
    }

    Process {
        do {
            $cnt++
            try {
                $ScriptBlock.Invoke()
                return
            } catch {
                Write-Error $_.Exception.InnerException.Message -ErrorAction Continue
                Start-Sleep -Milliseconds $Delay
            }
        } while ($cnt -lt $Maximum)

        # Throw an error after $Maximum unsuccessful invocations. Doesn't need
        # a condition, since the function returns upon successful invocation.
        throw 'Execution failed.'
    }
}

Retry-Command -ScriptBlock {
    $tag = "simpleauth@0.1.0"
    $fileName="Microsoft.TeamsFx.SimpleAuth_0.1.0.zip"
    $url = "https://github.com/OfficeDev/TeamsFx/releases/download/1"+$tag+"/"+$fileName
    Invoke-WebRequest $url -OutFile ./SimpleAuth.zip
} -Maximum 10