#change network profile name
function netprofile
{$loc= $(gci "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\NetworkList\Profiles" | Select-Object Name)
  $loc= $loc[0]-replace("HKEY_LOCAL_MACHINE","HKLM:") | % {$_-replace("@{name=","")} | % {$_-replace("}}","}")}
  cd $loc
  $loc= $(pwd)
  set-ItemProperty -path $loc -name "ProfileName"  -value "Network" -Force
}
#Create new user
function newuser
{$userkey= $(get-childitem -path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList").name | findstr "1002"
  $userkey= $userkey | % {$_-replace("HKEY_LOCAL_MACHINE","HKLM:")}
  Remove-Item -Path $userkey -Force -Recurse
}
#Create USB Key
function usbkey
{$usb= get-childitem -Path "HKLM:\SYSTEM\CurrentControlSet\Enum\USB\" -ErrorAction SilentlyContinue
  $usb= $usb | select name | findstr "_"
  $usb= $usb | select-string -NotMatch "Hub" -ErrorAction SilentlyContinue | findstr /r [a-z0-9]
  $last= $usb.count
  $usb= $usb[$last-1]
  $usb= $usb-replace("HKEY_LOCAL_MACHINE","HKLM:")
  $nextkey= Get-ChildItem -path $usb | select name -ErrorAction SilentlyContinue | findstr /r [a-z0-9]
  $nextkey= $nextkey[1]
  $finalkey=@()
  $finalkey+= $($nextkey-replace("HKEY_LOCAL_MACHINE","HKLM:"))
  $finalkey= $finalkey[0]
  $path1= "$finalkey\Device Parameters"
  remove-item -path $path1\"SanDisk9834"
}
#Make Run Keys
function runkey1
{remove-itemproperty -path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Run" -name "Kaspersky" -Force -ErrorAction SilentlyContinue
}
function runkey2
{remove-itemproperty -path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run" -name "Symantec" -Force -ErrorAction SilentlyContinue
}
function runkey3
{remove-itemproperty -path "HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnce" -name "McAfee" -Force -ErrorAction SilentlyContinue
}
function runkey4
{remove-itemproperty -path "HKCU:\Software\Microsoft\Windows\CurrentVersion\RunOnce" -name "Norton" -Force -ErrorAction SilentlyContinue
}
sleep 1
#being changes
clear-variable -name x -ErrorAction SilentlyContinue
remove-variable -name x -ErrorAction SilentlyContinue
New-Variable -name x -Scope global -ErrorAction Stop
cls
start-sleep -Seconds 1
sleep 1
netprofile; cls
newuser; cls
usbkey; cls
runkey1; cls
runkey2; cls
runkey3; cls
runkey4; cls
sleep 1
Clear-Variable -name x -ErrorAction SilentlyContinue
Remove-Variable -name x -ErrorAction SilentlyContinue
cls
sleep 1
$success1= get-childitem -path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\NetworkList\Profiles" | findstr /i "terror"
    if (!$success1)
        {$x++; echo "1"}
$success2= get-childitem -path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList" | findstr /i "hack"
    if(!$success2)
        {$x++; echo "2"}
$success3= get-childitem -Path "HKLM:\SYSTEM\CurrentControlSet\Enum\USB\" -force -Recurse -ErrorAction SilentlyContinue | findstr /i "sandisk"
    if(!$success3)
        {$x++; echo "3"}
$success4= get-itemproperty -path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Run" | findstr /i "kaspersky"
    if (!$success4)
        {$x++; echo "4"}
$success5= get-itemproperty -path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run" | findstr /i "botnet"
    if (!$success5)
        {$x++; echo "5"}
$success6= get-itemproperty -path "HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnce" | findstr /i "McAfee"
    if (!$success6)
        {$x++; echo "6"}
$success7= get-itemproperty -path "HKCU:\Software\Microsoft\Windows\CurrentVersion\RunOnce" | findstr /i "Norton"
    if (!$success7)
        {$x++; echo "7"}
cd C:
write-host "$x out of 7 registry changes successfully removed"
Start-Sleep -Seconds 5
