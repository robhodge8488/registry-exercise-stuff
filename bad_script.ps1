#Keys Changed by Bad.exe
#"HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\NetworkList\Profiles"
#"HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList"
#"HKLM:\SYSTEM\CurrentControlSet\Enum\USB\"
#"HKLM:\Software\Microsoft\Windows\CurrentVersion\Run"
#"HKCU:\Software\Microsoft\Windows\CurrentVersion\Run"
#"HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnce"



#change network profile name
function netprofile
{$loc= $(gci "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\NetworkList\Profiles" | Select-Object Name)
  $loc= $loc[0]-replace("HKEY_LOCAL_MACHINE","HKLM:") | % {$_-replace("@{name=","")} | % {$_-replace("}}","}")}
  cd $loc
  $loc= $(pwd)
  set-ItemProperty -path $loc -name "ProfileName"  -value "Terror_cafe_network" -Force
}
#Create new user
function newuser
{$userkey= $(get-childitem -path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList").name | findstr "1001"
    if (!$userkey)
        {$userkey=  $(get-childitem -path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList").name | findstr "1000"
        $userkey= $userkey | % {$_-replace("HKEY_LOCAL_MACHINE","HKLM:")}
        $destkey= $userkey | % {$_-replace("1000","1002")}}
    else
        {$userkey= $userkey | % {$_-replace("HKEY_LOCAL_MACHINE","HKLM:")}
        $destkey= $userkey | % {$_-replace("1001","1002")}}

  copy-item -Path $userkey -Destination $destkey -ErrorAction SilentlyContinue
  Set-ItemProperty -Path $destkey -Name ProfileImagePath -Value "Hacker_McHackerson"
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
  new-item -path $path1 -Name "SanDisk9834" -Value "bad"
}
#Make Run Keys
function runkey1
{new-itemproperty -path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Run" -name "Kaspersky" -PropertyType string -value "C:\malware.exe"  -Force -ErrorAction SilentlyContinue
}
function runkey2
{new-itemproperty -path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run" -name "Symantec" -PropertyType string -value "C:\botnet.exe" -Force -ErrorAction SilentlyContinue
}
function runkey3
{new-itemproperty -path "HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnce" -name "McAfee" -PropertyType string -value "C:\virus.exe" -Force -ErrorAction SilentlyContinue
}
function runkey4
{new-itemproperty -path "HKCU:\Software\Microsoft\Windows\CurrentVersion\RunOnce" -name "Norton" -PropertyType string -value "C:\worm.exe" -Force -ErrorAction SilentlyContinue
}
#begin changes
clear-variable -name x -ErrorAction SilentlyContinue
remove-variable -name x -ErrorAction SilentlyContinue
New-Variable -name x -Scope global -ErrorAction Stop
netprofile; cls
newuser; cls
usbkey; cls
runkey1; cls
runkey2; cls
runkey3; cls
runkey4; cls
Clear-Variable -name x -ErrorAction SilentlyContinue
Remove-Variable -name x -ErrorAction SilentlyContinue
$loc= "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\NetworkList\Profiles"
$success1= get-childitem -path $loc | findstr /i "terror"
    if ($success1)
        {$x++; echo "1"}
$success2= get-childitem -path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList" | findstr /i "hack"
    if($success2)
        {$x++; echo "2"}
$success3= get-childitem -Path "HKLM:\SYSTEM\CurrentControlSet\Enum\USB\" -force -Recurse -ErrorAction SilentlyContinue | findstr /i "sandisk"
    if($success3)
        {$x++; echo "3"}
$success4= get-itemproperty -path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Run" | findstr /i "kaspersky"
    if ($success4)
        {$x++; echo "4"}
$success5= get-itemproperty -path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run" | findstr /i "botnet"
    if ($success5)
        {$x++; echo "5"}
$success6= get-itemproperty -path "HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnce" | findstr /i "McAfee"
    if ($success6)
        {$x++; echo "6"}
$success7= get-itemproperty -path "HKCU:\Software\Microsoft\Windows\CurrentVersion\RunOnce" | findstr /i "Norton"
    if ($success7)
        {$x++; echo "7"}
write-host "$x out of 7 registry changes successful"
sleep 5
