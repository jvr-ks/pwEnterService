<a name="pwEnterService">&nbsp;</a>  
# pwEnterService  
Status: BETA test

#### <a name="description">pwEnterService description</a><a href="#overview"> &uarr;</a>
"pwEnterService.exe" stays in memory after once started (i.e. like a service).  
If it detects one of the defined apps it looks for an open password request.  
If a request window is found, it enters the defined password automatically, which is very comfortable!    
  
Currently supported apps:  
* "Firefox"  
* "Crypditor"
* more to come 
  
All files are licensed under the **GNU GENERAL PUBLIC LICENSE**  
A copy is included of the file "license.txt" is included in each download.  
  
### <a name="overview">Table of contents</a>  
  
<a href="#description">pwEnterService description</a>  
<a href="#latestchanges">Latest changes</a>  
<a href="#setup">Setup</a>  
<a href="#modifier">Start modifier keys</a>  
<a href="#start">Start with Windows</a>  
<a href="#move">Move the "pwEnterService.exe" to a harddisk</a>  
<a href="#hints">Hints</a>  
<a href="#tray">Tray menu</a>  
<a href="#configuration">Configuration file</a>  
<a href="#bugs">Known issues / bugs</a>  
<a href="#download">Download from Github</a>  
  
#### <a name="latestchanges">Latest changes</a><a href="#overview"> &uarr;</a>  
  
Version (&gt;=)| Change  
------------ | -------------  
0.023 | Mouseposition is saved and restored, VncViewer id now is "UltraVNC Viewer - Authentication"
0.018 | Vncviewer support, add Vncviewer_Password= to the passwords file "pwEnterServicePasswords.ini" (USB stick!)  
0.015 | Move to a project of its own! [pwEnterService](https://github.com/jvr-ks/pwEnterService). 
0.014 | Bugfixes
0.012 | Status: BETA test
0.009 | Configuration splitted up into two files: "pwEnterServicePasswords.ini" and "pwEnterServiceConfig.ini"
0.007 | Testmode added
0.003 | If the app is started while a password request is already open, the password is entered also, pwEnterServiceSettings changed 
  
#### <a name="setup">Setup</a><a href="#overview"> &uarr;</a>
* Copy to an USB stick (or a directory on an USB stick) the files:
* * "pwEnterService.exe",  
* * "pwEnterServiceRemove.exe" (recommended, but a start modifier key can be used instead, look at the section below),  
* * "pwEnterServiceSettings.exe" (recommended, but a start modifier key can be used instead, look at the section below),  
  
* Start "pwEnterService.exe" **while holding down the "Shift key"** to open the settings window \*1),  
  The configuration files are created, if the settings window is closed.  
  "pwEnterServicePasswords.ini" contains the passwords and the name of the crypditor exe-file,  
  "pwEnterServiceConfig.ini" contains all other app configuration parameters.  
* Enter your password(s) into the Box(es):  
* * "Firefox": enter your password in the field "Firefox_Password"=&lt;PASSWORD&gt;  
* * "Crypditor": 
* * * enter your password in the field "Crypditor_Password"=&lt;PASSWORD&gt; 
* * * enter the name of the Crypditor executable file in the field "Crypditor_ExeName"=&lt;EXENAME&gt;
* Close the window, the file "pwEnterServicePasswords.ini" is created.  
If no password is entered, the corresponding app will be ignored!  

\*1) Start "pwEnterServiceSettings.exe" opens the settings window also,  
but passwords are hidden then (if the Shift key is not pressed ...).  
  
The file "pwEnterServicePasswords.ini" and can be manually edited with windows notepad also.  
The passwords are NOT encrypted!  
  
* **If you leave your desk, shutdown your computer or close all running apps which require a password!** 
* **Do not forget to take the stick with you!**
  
Start "pwEnterServiceRemove.exe" to remove "pwEnterService.exe" from memory  
in case of: 
* Any manually configuration (password) change,  
* To allow an update of a running "pwEnterService.exe"
  
#### <a name="modifier">Start modifier keys</a><a href="#overview"> &uarr;</a>  
  
key(s) | Operation | Remarks  
------------ | ------------- | -------------  
Shift | Open the Settings Window | Alternative to running "pwEnterServiceSettings.exe"  
Alt | Remove pwEnterService | Alternative "pwEnterServiceRemove.exe" but "pwEnterServiceRemove.exe" is more reliable!  
Shift + Alt | Start in Test mode | The app window stays viewable with some additional information  
  
#### <a name="start">Start with Windows</a><a href="#overview"> &uarr;</a>  
Windows randomly mixes the driveletters of removable storage devices.  
To assign a fixed driveletter to the USB stick containing the file "pwEnterServicePasswords.ini"  
I use [USBDLM - USB Drive Letter Manager for Windows] (https://www.uwe-sieber.de/usbdlm_e.html) 
which is Freeware for private and educational use.  
  
#### <a name="move">Move the "pwEnterService.exe" to a harddisk  </a><a href="#overview"> &uarr;</a>  
If "Start with Windows" is used, the USB stick must already be pluged in if Windows is booted,  
otherwise "pwEnterService.exe" must be manually started once, if the password is requested.  
  
To just keep the "pwEnterServicePasswords.ini" file on the USB stick create a directory of your choice \*2) (example: "C:\jvrde\keypass") on your harddisk and copy (or move) the files:    
* * "pwEnterService.exe",  
* * "pwEnterServiceSettings.exe" \*3),  
* * "pwEnterServiceRemove.exe \*3),  
to the just created directory.  
Use [startDelayed](https://github.com/jvr-ks/startDelayed) or  
create a link of "pwEnterService.exe" inside an Windows Autostart Folder (run "shell:startup")  
to start pwEnterService with Windows.  
  
\*2) NOT inside a protected directory like "C:\Program Files" or "C:\Program Files (x86)".  
\*3) recommended, but a start modifier key can be used instead, look at the section below,  
     the tray menu has an "Exit" entry also!   

Start "pwEnterServiceSettings.exe" and enter the path to file "pwEnterServicePasswords.ini" on the USB stick,  
example (if the location of the file is "H:\keypass\pwEnterServicePasswords.ini"):  
remotePasswordsPath=H:\keypass  
  
#### <a name="hints">Hints</a><a href="#overview"> &uarr;</a>  
* Calling "pwEnterService.exe remove" is possible but not very reliable, use "pwEnterServiceRemove.exe" instead.  
* "pwEnterService.exe settings" opens the password edit window too.  
* While running in the background, the app  has an invisible window (transparency: 100%, height: 1px)  
  positioned at the top/center of the screen.  
* **You may pin the app to the taskbar, if the settings dialog is currently shown!**  
* Activate "Testmode": Hold down "Shift" and "Alt" key while starting the app or change in the Configuration file "Testmode=1".  
* If you started multiple apps concurrently, you have to manually refocus the password request boxes!  
* **If the password suddenly is very long, you started "pwEnterService.exe" multible times!**  
  
#### <a name="tray">Tray menu</a><a href="#overview"> &uarr;</a>  
The tray menu has a few default entries i.e. "Suspend Hotkeys", "Pause Script" and "Exit".  
Additional entries are:  
* "Open Github webpage",  
* More to come ...
    
#### <a name="configuration">Configuration file</a><a href="#overview"> &uarr;</a>  
(**Changed from version >= 0.018**)  

The default Configuration file is "pwenterservice.ini".  
  
If a file "_pwenterservice.ini" is found in the app directory,  
it is used instead of "pwenterservice.ini". 
  
If neither file is found, default values are used and the default Configuration file is created.  
  
#### <a name="bugs">Known issues / bugs</a><a href="#overview"> &uarr;</a>  
Issue / Bug | Type | fixed in version  
------------ | ------------- | -------------  
Sometimes pwEnterService fails | issue | 0.06  
  
#### <a name="download">Download</a><a href="#overview"> &uarr;</a>  
Via "Updater" is the preferred method!  
Portable, run from any directory, but running from a subdirectory of the windows programm-directories   
(C:\Program Files, C:\Program Files (x86) etc.)  
requires admin-rights and is not recommended!  
**Installation-directory (is created by the Updater) must be writable by the app!**  
  
To download **pwEnterService.exe** 64 bit Windows from Github please use:  
  
[updater.exe 64bit](https://github.com/jvr-ks/pwEnterService/raw/main/updater.exe)  
  
(Updater viruscheck please look at the [Updater repository](https://github.com/jvr-ks/updater)) 
  
* From time to time there are some false positiv virus detections  
[Virusscan](#virusscan) at Virustotal see below. 
  
**More to come ...**  
  
Copyright (c) 2022/23/24 J. v. Roos  

Virustotal virusscan results, please use [CTRL] + Click to open in a new window! 

<a name="virusscan">



##### Virusscan at Virustotal 
[Virusscan at Virustotal, pwEnterService.exe 64bit-exe, Check here](https://www.virustotal.com/gui/url/8a2db7ace16a4fb3bb5d0b02beb69965f9e7a38d6db25244f1b317b6749998b3/detection/u-8a2db7ace16a4fb3bb5d0b02beb69965f9e7a38d6db25244f1b317b6749998b3-1749830882
)  
