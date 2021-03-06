#    This file is part of Invoke-Obfuscation.
#
#   Copyright 2016 Daniel Bohannon <@danielhbohannon>
#         while at Mandiant <http://www.mandiant.com>
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.



Function Out-SecureStringCommand
{
<#
.SYNOPSIS

Generates AES-encrypted SecureString object out of three possible syntaxes for a PowerShell command or script. Optionally it adds command line output to final command.

Invoke-Obfuscation Function: Out-SecureStringCommand
Author: Daniel Bohannon (@danielhbohannon)
License: Apache License, Version 2.0
Required Dependencies: None
Optional Dependencies: None
 
.DESCRIPTION

Out-SecureStringCommand encrypts an input PowerShell scriptblock or path as a SecureString object. It randomly selects between three different syntaxes for accomplishing this. The purpose is to highlight to the Blue Team that there are more novel ways to encode/encrypt a PowerShell command other than the most common Base64 approach.

.PARAMETER ScriptBlock

Specifies a scriptblock containing your payload.

.PARAMETER Path

Specifies the path to your payload.

.PARAMETER NoExit

Outputs the option to not exit after running startup commands.

.PARAMETER NoProfile

Outputs the option to not load the Windows PowerShell profile.

.PARAMETER NonInteractive

Outputs the option to not present an interactive prompt to the user.

.PARAMETER NoLogo

Outputs the option to not present the logo to the user.

.PARAMETER Wow64

Calls the x86 (Wow64) version of PowerShell on x86_64 Windows installations.

.PARAMETER Command

Outputs the option to execute the specified commands (and any parameters) as though they were typed at the Windows PowerShell command prompt.

.PARAMETER WindowStyle

Outputs the option to set the window style to Normal, Minimized, Maximized or Hidden.

.PARAMETER ExecutionPolicy

Outputs the option to set the default execution policy for the current session.

.PARAMETER PassThru

(Optional) Avoids applying final command line syntax if you want to apply more obfuscation functions (or a different launcher function) to the final output.

.EXAMPLE

C:\PS> Out-SecureStringCommand -ScriptBlock {Write-Host 'Hello World!' -ForegroundColor Green; Write-Host 'Obfuscation Rocks!' -ForegroundColor Green} -NoProfile -NonInteractive

powershell  -NoProfi -NonIn     " IEX( ([Runtime.InteropServices.Marshal]::PtrToStringUni( [Runtime.InteropServices.Marshal]::SecureStringToGlobalAllocUnicode( $('76492d1116743f0423413b16050a5345MgB8AG0AOQBKAEcAZgBHAEwAaQBBADkAbABoAFQASgBGAGEATgBBAFUAOABIAGcAPQA9AHwAYwBmADEAZgA4ADQAYgAyADkAZgBjADcAOABiAGYAYgBkADAAZAA5AGMAMgBlADgAZQBjADIAOAAxADYAOQBhADYANQBkADYANQA3ADEAMAAwADQAMwBjADgAMAA1AGMAZAAwADYAOQAxAGIAMQA5ADYAYwAwADQAMAA1AGEAOAA5ADEANwA1ADgANgA5ADEANABhAGQAMABhAGEANwAxAGUAZgBjADcAZABiADMAYgBlADgAYQBhAGIAMAAyADIANwA2AGYAYwBhAGQANwA0ADkAOAA2ADEAMAA0ADIAYQBkAGYAMAA5ADgAMwAzAGEAYwBmADYANQA5ADAANQA0ADcAYgAwADEANAAyADgAMwBmADUAMQAzADAAMQBmADAAZABkAGIAOQAxAGIAZQAxADIAZQA2ADIAMgAxADgAOAA5ADEANgA1AGEANgA2AGEAZABjADcAZQAwAGIANgBmADEANgA2ADAAMwBjADEANQAzAGUAZgBkADUAYQAwADYAMgBmAGMAOAAxAGUANgBmADgAYwA5ADUAZgBlADMANAA1ADQANQA3ADIANgA2ADYAOQBlAGUANwBkAGUAYQAyAGIAZAA2AGUAZgBiADUANwA4AGQANQA5ADIANgBjADMAZgBlADUANQA4AGMAOQBjADcANQA2ADEAYwA3ADQAYwAzAGUAZAA4ADkAOABlAGYANAA5AGUAZQAwADYAMgAxAGEAZgA2ADIAOABkAGYANwA4AGIAOAA1ADQANgA2ADIAYgBkAGQANAA4AGYANwA4AGYAYQBmAGIAZAAyAGMAYgBiADkANQBlADIAYwAyADYANABkADgAMgA2AGIAZQBlADIAZQBlAGUAOQA0AGIANgAxADIAZgA0ADIAOQBmADAAYwBmADIAOQBmAGYANgBlAGUAZAA3ADMAMAA0ADMAYwBjADQAMgBhAGIAZgA4ADAAMQA1ADYAOQA5AGYAZQA4AGIAMwBhAGMAOQAyADcAYwA2AGQAMgBmAGYANwA4AGQAOABiADAAZQBmADcANgBlAGIAMwBiADgAMwAxADcAZQBlAGQAYQBmAGYAYgBmAGIAYQA5AGEAYQBhAGQAOAA5AGQAZgAwAGMAMgAwAGUANQBlADcAOQA5ADAAZgBkADkAZAAwADMAYQBhADIAZAA0ADcAOQBkADAANgA1ADUAOAA=' |ConvertTo-SecureString -Key  241,131,91,52,14,165,71,51,19,86,1,104,87,220,235,62) ))) )"

C:\PS> Out-SecureStringCommand -ScriptBlock {Write-Host 'Hello World!' -ForegroundColor Green; Write-Host 'Obfuscation Rocks!' -ForegroundColor Green} -NoProfile -NonInteractive -PassThru

(New-Object  Management.Automation.PSCredential ' ', ( '76492d1116743f0423413b16050a5345MgB8AEUAcQBKAHkAegBqAHUAQwBNAC8AeABPAHUAbgBlADAAUABMAHQARQAyAGcAPQA9AHwAMgBlAGEANQBiADMAMAA0ADMANQBkAGIAMQA2AGUAYwA2ADIANwAyADEANAA5ADUAYwAyADkAOAAzADUAZAAwADcANAAwADQAOQA0AGQAZQAwADUAYwBjADUAZgAwADYAYgA0AGIAYQA0AGYANwAxADUAMwA1AGUANQAxAGMANwBiADAANgA3ADgAOABmAGQAYwBjADYAMAA4AGYAZQAyADEAZAAyADQAMgBkAGYAYwBmADkAZQA5ADkAMwBmAGMAZAAzADgAOQAwADEANQBhADcANAA5AGUANQBiAGMAOAA2ADYAOAAxAGYAMwAxAGYAMwA4AGQANAA0ADAAYgA3ADUAMwBkADcAMQAwADAANABlAGIAOQAxAGIAOQAxADcAZgBjAGEANAA4ADUAOQBlADUAOAA1AGEANwBjADUAYQAwADgAOAAyAGEAMAAzADQAMQA3ADYAMwA0AGUAMwBiADUAZgA3AGMAMwA5AGQAZQAyADkAMgAxADAAMgA5ADUAMwBmADMAOAA5ADQAYwAyAGUANwA5AGMAMgA5ADEAMAAwAGEAMgAyAGQANQA4ADAAZQBiAGMAZAA1ADkAMgBlAGQAOAAyADIAZAA3ADQAYQBmADIANwAwADQAMQAzADQANgAxADQAMwA5ADgANQBlADIANQA2ADEAMwBiAGUAMwBhAGMAMQAwADIAYQBjAGMAYgA5AGUAYQBjAGQAZQAyADYAYgAyADkAZABjAGEAMAA4ADIANAA1AGMAOAAzADgAZgAyAGEAMABlAGYANAAwAGEAMgAyADgANQBlADkAMgAyAGEANgA0ADQANwBlADAAYgA0ADkAMgBkAGMANgAwAGMANwA3ADUAZABhADkAMgA1ADAAYgA0ADgAYQBmAGIAMQBjADEAMgA2ADEAZgA0ADkANgA4AGYAMQA0ADkAMAA0AGYANwBjAGMAYQBiAGQAZQA4ADIAMAA1AGUAZgA4ADMAZQAwAGMAYQBlADQAMgBkAGIAOQBkADUANwAzADQANwAyAGIAYwAxADQAYwBiAGEAZAA2AGYAZQAzADUAYgAxADgAYgBhADcANQAyADkAMAAwADcAMAA0ADQANgBlAGMAYQA1ADQAMQBhAGYAYgAzADYANwBjAGIAZgAyAGEAYgBkADgAZAAwAGEAZgBmADYAMQA2AGIAMAA1AGIANQA=' |ConvertTo-SecureString  -Key  205,39,9,9,104,139,104,94,252,20,93,132,29,171,56,2 )).GetNetworkCredential().Password | Invoke-Expression

.NOTES

The size limit for a single SecureString object input is 65,536 characters. However, this will consume significant resources on the target system when decoding a SecureString object of this size (50% CPU and ~30 seconds on several test VMs). For larger payloads I would recommend chunking your payload and encoding/encrypting each piece separately and then reassembling each decoded/decrypted piece during runtime. I have a POC that does this and will be releasing a STAGING set of functions soon to accomplish this very task.
This is a personal project developed by Daniel Bohannon while an employee at MANDIANT, A FireEye Company.

.LINK

http://www.danielbohannon.com
#>

    [CmdletBinding(DefaultParameterSetName = 'FilePath')] Param (
        [Parameter(Position = 0, ValueFromPipeline = $True, ParameterSetName = 'ScriptBlock')]
        [ValidateNotNullOrEmpty()]
        [ScriptBlock]
        $ScriptBlock,

        [Parameter(Position = 0, ParameterSetName = 'FilePath')]
        [ValidateNotNullOrEmpty()]
        [String]
        $Path,

        [Switch]
        $NoExit,

        [Switch]
        $NoProfile,

        [Switch]
        $NonInteractive,

        [Switch]
        $NoLogo,

        [Switch]
        $Wow64,

        [Switch]
        $Command,

        [ValidateSet('Normal', 'Minimized', 'Maximized', 'Hidden')]
        [String]
        $WindowStyle,

        [ValidateSet('Bypass', 'Unrestricted', 'RemoteSigned','AllSigned','Restricted')]
        [String]
        $ExecutionPolicy,
        
        [Switch]
        $PassThru
    )

    # Either convert ScriptBlock to a String or convert script at $Path to a String.
    If($PSBoundParameters['Path'])
    {
        Get-ChildItem $Path -ErrorAction Stop | Out-Null
        $ScriptString = [IO.File]::ReadAllText((Resolve-Path $Path))
    }
    Else
    {
        $ScriptString = [String]$ScriptBlock
    }

    # Convert $ScriptString to a SecureString object.
    $SecureString = ConvertTo-SecureString $ScriptString -AsPlainText -Force
    
    # Randomly select the key length. Supported key lengths for SecureString (AES) are 16, 24 and 32.
    $KeyLength = Get-Random @(16,24,32)
    
    # Randomly select the key value and how it will be formatted.
    Switch(Get-Random -Minimum 1 -Maximum 3)
    { 
        1 {
            # Generate random key of length $KeyLength.
            $SecureStringKey = @()
            For($i=0; $i -lt $KeyLength; $i++) {
                $SecureStringKey += Get-Random -Minimum 0 -Maximum 256
            }
            $SecureStringKeyStr = $SecureStringKey -Join ','
          }
        2 {
            # Generate sequential key of length $KeyLength with random array bounds.
            # To save space use shorthand array notation in final command with $SecureStringKeyStr.
            $LowerBound = (Get-Random -Minimum 0 -Maximum (256-$KeyLength))
            $UpperBound = $LowerBound + ($KeyLength - 1)
            Switch(Get-Random @('Ascending','Descending'))
            {
                'Ascending'  {$SecureStringKey = ($LowerBound..$UpperBound); $SecureStringKeyStr = "($LowerBound..$UpperBound)"}
                'Descending' {$SecureStringKey = ($UpperBound..$LowerBound); $SecureStringKeyStr = "($UpperBound..$LowerBound)"}
                default {Write-Error "An invalid array ordering option was generated for switch block."; Exit;}
            }
          }
        default {Write-Error "An invalid random number was generated for switch block."; Exit;}
    }
    
    # Convert SecureString object to text that we can load on target system.
    $SecureStringText = $SecureString | ConvertFrom-SecureString -Key $SecureStringKey

    # Generate the code that will decrypt and execute the payload and randomly select one.
    $NewScriptArray = @()
    $NewScriptArray += '(' + ' '*(Get-Random -Input @(0,1)) + '[Runtime.InteropServices.Marshal]::PtrToStringAuto(' + ' '*(Get-Random -Input @(0,1)) + '[Runtime.InteropServices.Marshal]::SecureStringToBSTR(' + ' '*(Get-Random -Input @(0,1)) + '$(' + "'$SecureStringText'" + ' '*(Get-Random -Input @(0,1)) + '|' + ' '*(Get-Random -Input @(0,1)) + 'ConvertTo-SecureString' + ' '*(Get-Random -Input @(0,1)) + ' -Key ' + ' '*(Get-Random -Input @(0,1)) + $SecureStringKeyStr + ')' + ' '*(Get-Random -Input @(0,1)) + ')' + ' '*(Get-Random -Input @(0,1)) + ')' + ' '*(Get-Random -Input @(0,1)) + ')'
    $NewScriptArray += '(' + ' '*(Get-Random -Input @(0,1)) + '[Runtime.InteropServices.Marshal]::PtrToStringUni('  + ' '*(Get-Random -Input @(0,1)) + '[Runtime.InteropServices.Marshal]::SecureStringToGlobalAllocUnicode(' + ' '*(Get-Random -Input @(0,1)) + '$(' + "'$SecureStringText'" + ' '*(Get-Random -Input @(0,1)) + '|' + ' '*(Get-Random -Input @(0,1)) + 'ConvertTo-SecureString' + ' '*(Get-Random -Input @(0,1)) + ' -Key ' + ' '*(Get-Random -Input @(0,1)) + $SecureStringKeyStr + ')' + ' '*(Get-Random -Input @(0,1)) + ')' + ' '*(Get-Random -Input @(0,1)) + ')' + ' '*(Get-Random -Input @(0,1)) + ')'
    $NewScriptArray += '(' + ' '*(Get-Random -Input @(0,1)) + 'New-Object ' + ' '*(Get-Random -Input @(0,1)) + 'Management.Automation.PSCredential ' + ' '*(Get-Random -Input @(0,1)) + "' '" + ',' + ' '*(Get-Random -Input @(0,1)) + '(' + ' '*(Get-Random -Input @(0,1)) + "'$SecureStringText'" + ' '*(Get-Random -Input @(0,1)) + '|' + ' '*(Get-Random -Input @(0,1)) + 'ConvertTo-SecureString' + ' '*(Get-Random -Input @(0,1)) + ' -Key ' + ' '*(Get-Random -Input @(0,1)) + $SecureStringKeyStr + ' '*(Get-Random -Input @(0,1)) + ')' + ' '*(Get-Random -Input @(0,1)) + ').GetNetworkCredential().Password'
    # Select random option from above.
    $NewScript = (Get-Random -Input $NewScriptArray)

    # Add random invoke operation.
    $InvokeExpression = @('IEX','Invoke-Expression')
    
    # Generate random Invoke-Expression/IEX syntax and ordering: IEX ($ScriptString) or ($ScriptString | IEX)
    $InvokeOptions  = @()
    $InvokeOptions += ' '*(Get-Random -Input @(0,1)) + (Get-Random -Input $InvokeExpression) + ' '*(Get-Random -Input @(0,1)) + '(' + ' '*(Get-Random -Input @(0,1)) + $NewScript + ' '*(Get-Random -Input @(0,1)) + ')' + ' '*(Get-Random -Input @(0,1))
    $InvokeOptions += ' '*(Get-Random -Input @(0,1)) + $NewScript + ' '*(Get-Random -Input @(0,1)) + '|' + ' '*(Get-Random -Input @(0,1)) + (Get-Random -Input $InvokeExpression)
    # Select random option from above.
    $NewScript = (Get-Random -Input $InvokeOptions)

    # If user did not include -PassThru flag then continue with adding execution flgs and powershell.exe to $NewScript.
    If(!$PSBoundParameters['PassThru'])
    {
        # Build the PowerShell execution flags by randomly selecting execution flags substrings and randomizing the order.
        # This is to prevent Blue Team from placing false hope in simple signatures for common substrings of these execution flags.
        $CommandlineOptions = New-Object String[](0)
        If($PSBoundParameters['NoExit'])
        {
          $FullArgument = "-NoExit";
          $CommandlineOptions += $FullArgument.SubString(0,(Get-Random -Minimum 4 -Maximum ($FullArgument.Length+1)))
        }
        If($PSBoundParameters['NoProfile'])
        {
          $FullArgument = "-NoProfile";
          $CommandlineOptions += $FullArgument.SubString(0,(Get-Random -Minimum 4 -Maximum ($FullArgument.Length+1)))
        }
        If($PSBoundParameters['NonInteractive'])
        {
          $FullArgument = "-NonInteractive";
          $CommandlineOptions += $FullArgument.SubString(0,(Get-Random -Minimum 5 -Maximum ($FullArgument.Length+1)))
        }
        If($PSBoundParameters['NoLogo'])
        {
          $FullArgument = "-NoLogo";
          $CommandlineOptions += $FullArgument.SubString(0,(Get-Random -Minimum 4 -Maximum ($FullArgument.Length+1)))
        }
        If($PSBoundParameters['WindowStyle'])
        {
          $FullArgument = "-WindowStyle";
          $CommandlineOptions += $FullArgument.SubString(0,(Get-Random -Minimum 2 -Maximum ($FullArgument.Length+1))) + " $($PSBoundParameters['WindowStyle'])"
        }
        If($PSBoundParameters['ExecutionPolicy'])
        {
            $FullArgument = "-ExecutionPolicy"
            $CommandlineOptions += $FullArgument.SubString(0,(Get-Random -Minimum 2 -Maximum ($FullArgument.Length+1))) + " $($PSBoundParameters['ExecutionPolicy'])"
        }
        
        # Randomize the order of the execution flags.
        # This is to prevent the Blue Team from placing false hope in simple signatures for ordering of these flags.
        If($CommandlineOptions.Count -gt 1)
        {
            $CommandlineOptions = Get-Random -InputObject $CommandlineOptions -Count $CommandlineOptions.Count
        }

        # If selected then the -Command flag needs to be added last.
        If($PSBoundParameters['Command'])
        {
            $FullArgument = "-Command"
            $CommandlineOptions += $FullArgument.SubString(0,(Get-Random -Minimum 2 -Maximum ($FullArgument.Length+1)))
        }

        # Random-sized whitespace between all execution flags and encapsulating final string of execution flags.
        $CommandlineOptions = ($CommandlineOptions | ForEach-Object {$_ + " "*(Get-Random -Minimum 1 -Maximum 3)}) -Join ''
        $CommandlineOptions = " "*(Get-Random -Minimum 0 -Maximum 3) + $CommandlineOptions + " "*(Get-Random -Minimum 0 -Maximum 3)

        # Build up the full command-line string.
        If($PSBoundParameters['Wow64'])
        {
            $CommandLineOutput = "$($Env:windir)\SysWOW64\WindowsPowerShell\v1.0\powershell.exe $($CommandlineOptions) `"$NewScript`""
        }
        Else
        {
            # Obfuscation isn't about saving space, and there are reasons you'd potentially want to fully path powershell.exe (more info on this soon).
            #$CommandLineOutput = "$($Env:windir)\System32\WindowsPowerShell\v1.0\powershell.exe $($CommandlineOptions) `"$NewScript`""
            $CommandLineOutput = "powershell $($CommandlineOptions) `"$NewScript`""
        }

        # Make sure final command doesn't exceed cmd.exe's character limit.
        $CmdMaxLength = 8190
        If($CommandLineOutput.Length -gt $CmdMaxLength)
        {
                Write-Warning "This command exceeds the cmd.exe maximum allowed length of $CmdMaxLength characters! Its length is $($CmdLineOutput.Length) characters."
        }
        
        $NewScript = $CommandLineOutput
    }

    Return $NewScript
}