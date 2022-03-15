<## 			Remove McAfee - > Deploy CrowdStrike - > Deploy ITS Platform					#
Date: 			March-2022
Author: 		Nikolay Kolev
Email:  		nick@cyberpeak.net
Version:		2022.03
About:			Script facilitates McAfee to Crowdstrike Falcon migration and checks if ITS Platform is installed.
#>

### Setup  ###
$crdservice = Get-Service -Name "CSFalconService" -ErrorAction SilentlyContinue;	# Checks if ITS Platform is installed. Do not edit.
$itsservice = Get-Service -Name "ITSPlatform" -ErrorAction SilentlyContinue;		# Checks if ITS Platform is installed. Do not edit.
$mfetp = Get-Process -Name "mfetp" -ErrorAction SilentlyContinue;					# Checks if McAfee TP is installed. Do not edit.
$download = "https://www.dropbox.com/s/ygnf3kvv77hd5wr/McAfeeRemoval.exe?dl=1", "https://www.dropbox.com/s/04z6rfn8bkno1x2/WindowsSensor.MaverickGyr.exe?dl=1", "https://www.dropbox.com/s/1ls9sp1stg4h6m6/BankerLopez_MSMA_ITSPlatform.msi?dl=1"; # DO NOT EDIT
$dPath = "C:\tmp";
$blspace = "######################################";
$current = Get-Location;
$items = "$dPath\McAfeeRemoval.exe", "$dPath\WindowsSensor.MaverickGyr.exe", "$dPath\BankerLopez_MSMA_ITSPlatform.msi"; # DO NOT EDIT
### END SETUP ###

### Run removal tool without restarting the box if McAfee Threat Prevention is installed. ###

### Give users time to login ###
Start-Sleep -Seconds 180;
### END ###

if (Test-Path -Path $dPath) {
    Write-Output "$dPath exist, continuing.";
} else {
	Write-Output 'Creating $dPath folder...';
    mkdir -Path $dPath -Force;
    Push-Location -Path 'C:\tmp' -StackName "tmp";
}
Set-Location -StackName "tmp" -ErrorAction SilentlyContinue;
if($null -ne $mfetp)
{
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12;
Write-Output "Downloading McAfee Removal Tool.";
(New-Object System.Net.WebClient).DownloadFile($download[0],$items[0]);
Do {
    $remSize = (Get-Item $items[0] -ErrorAction SilentlyContinue).Length;
    Start-Sleep -Seconds 3
    } while ($remSize -lt 59653784)

Write-Output "Download of McAfee Removal tool suceeded"; Start-Sleep 1;
Write-Output "Removing McAfee Endpoint Security...";
Start-Process -FilePath $items[0] -NoNewWindow -ArgumentList "--accepteula --ENS --NOREBOOT --NOTELEMETRY";
Do { $mfemms = Get-Process -name "mfemms" -ErrorAction SilentlyContinue;
    Start-Sleep -Seconds 15
} while ($null -ne $mfemms)
	Write-Output "McAfee has been uninstalled."
} else {
    Write-Output "McAfee is not installed or was already removed.";
    Write-Output $blspace;
}
if ($null -eq $crdservice) {
    Write-Output "Downloading Crowdstrike Falcon Agent";
    (New-Object System.Net.WebClient).DownloadFile($download[1],$items[1]);
    Do { $remSize = (Get-Item $dPath\WindowsSensor.MaverickGyr.exe -ErrorAction SilentlyContinue).Length;
        Start-Sleep -Seconds 3
    } while ($remSize -lt 49159343)

    Write-Output "Download of Crowdstrike Falcon Agent suceeded"; Start-Sleep -Seconds 5;
    Write-Output "Installing...";
    Start-Process -FilePath $items[1] -NoNewWindow -ArgumentList "/install /quiet /norestart CID=59871111E1B94534B4868C3C8CF4F8D5-9C";
    Do { $crdservice = Get-Service -Name "CSFalconService" -ErrorAction SilentlyContinue;
        Start-Sleep -Seconds 10
    } while ($null -eq $crdservice)
    Write-Output "CrowdStrike Falcon has been installed.";
    }
    else {
        Write-Output "CrowdStrike Falcon has been already installed.";
        Write-Output $blspace;
    }
    if ($null -eq $itsservice) {
        Write-Output "Downloading ITS Platform Agent";
    (New-Object System.Net.WebClient).DownloadFile($download[2],$items[2]);
    Do { $remSize = (Get-Item $items[2] -ErrorAction SilentlyContinue).Length;
        Start-Sleep -Seconds 10
    } while ($remSize -lt 172048832)

    Write-Output "Download of ITS Platform Agent suceeded"; Start-Sleep -Seconds 5;
    Write-Output "Installing...";
    Start-Process -FilePath $items[2] -NoNewWindow -ArgumentList "/q";
    Do { $itsplatform = Get-Service -name "ITSPlatform" -ErrorAction SilentlyContinue;
        Start-Sleep -Seconds 15
    } while ($null -eq $itsplatform)
    Write-Output "ITS Platform has been installed.";
    }
    else {
        Write-Output "ITS Platform has been already installed.";
        Write-Output $blspace;
        Write-Output "You are all set and ready to go.";
    }
    Start-Sleep -Seconds 20; Set-Location -LiteralPath $current -ErrorAction SilentlyContinue;
    Remove-Item $items -ErrorAction SilentlyContinue -Force; $crdservice = $null;$itsservice = $null;$mfetp = $null;$download = $null; $dPath = $null;$current = $null;