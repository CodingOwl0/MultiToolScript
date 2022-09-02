@echo off

set default_User=User 
set default_Password=Password
rem ***************************************************************
set version=0.3
set bezeichnung=Flyaway
set firma=CodingOwl0

rem ***************************************************************
rem Made by: Luca Franziskowski 28.07.2018
rem ***************************************************************



 


:start
title %Firma% Toolbox fuer Informatiker und Administratoren 
color 1f
cls
type %~dp0\graphic.ascii
echo Das Tool muss als Admin ausgefuehrt werden!
echo ---------------------------------------------------------
echo SEITE 1 - SEITE 1 - SEITE 1 - SEITE 1 - SEITE 1 - SEITE 1
echo ---------------------------------------------------------
echo ### IP und Subnetze ###
echo 1: IP-Adressbereich anpingen
echo 2: Weg zu einer bestimmten Adresse bestimmen
echo 3: IP dieses PCs aendern
echo 4: Derzeitige IP-Konfiguration
echo.
echo ### Anwendungen     ###
echo 5: Remoteverbindung starten
echo.
echo.
echo ---------------------------------------------------------
echo 9: Naechste Seite aufrufen (2)
echo.
choice/c 123456789 >nul
if errorlevel 9 goto seite2
if errorlevel 5 goto vierzehn
if errorlevel 4 goto four
if errorlevel 3 goto fife
if errorlevel 2 goto tracert
if errorlevel 1 goto one
goto start


:seite2
cls
type %~dp0\graphic.ascii
echo Das Tool muss als Admin ausgefuehrt werden!
echo ---------------------------------------------------------
echo SEITE 2 - SEITE 2 - SEITE 2 - SEITE 2 - SEITE 2 - SEITE 2
echo ---------------------------------------------------------
echo ### DNS           ###
echo 1: DNS-Cache loeschen und neu anordnen
echo.
echo ### Informationen ###
echo 2: Allgemeine Informationen
echo ### Allgemein     ###
echo 3: Update von MTool    (I)
echo 4: Bedienungsanleitung (I)
echo 5: Log Datei anzeigen
echo 6: Backup-Routine
echo ---------------------------------------------------------
echo 9: Naechste Seite aufrufen (3)
echo.
choice/c 123456789 >nul
if errorlevel 9 goto seite3
if errorlevel 6 goto neunzehn
if errorlevel 5 goto log
if errorlevel 4 goto manual
if errorlevel 3 goto update
if errorlevel 2 goto ten
if errorlevel 1 goto two
goto seite2

:seite3
cls
type %~dp0\graphic.ascii
echo Das Tool muss als Admin ausgefuehrt werden!
echo ---------------------------------------------------------
echo SEITE 3 - SEITE 3 - SEITE 3 - SEITE 3 - SEITE 3 - SEITE 3
echo ---------------------------------------------------------
echo ### Windows Verwaltung ###
echo 1: Benutzer anlegen mit Passwort
echo 2: PC-Informationen in Datei speichern
echo 3: PC bereinigen
echo 4: Backup erstellen
echo 5: Backup wiederherstellen
echo 6: Daten sicher loeschen
echo 7: Datei ver-/entschluesseln
echo 8: Ordner zippen
echo.
echo ---------------------------------------------------------
echo 9: Naechste Seite aufrufen (1)
echo.
choice/c 123456789 >nul
if errorlevel 9 goto start
if errorlevel 8 goto achtzehn
if errorlevel 7 goto siebzehn
if errorlevel 6 goto eleven
if errorlevel 5 goto nine
if errorlevel 4 goto eight
if errorlevel 3 goto seven
if errorlevel 2 goto six
if errorlevel 1 goto three
goto seite3


:one  
rem ******************     IP-Adressen Verfuegbarkeit messen ********************
title IP-Adressen Verfuegbarkeit messen
cls
rem Ordner anlegen, fals nicht vorhanden, und hereinspringen:::
cd/d "C:\Users\%Username%\Documents"
if not exist MTool mkdir MTool
cd/d MTool
if exist ips.txt del ips.txt
if exist ips2.txt del ips2.txt
echo . >>ips.txt
echo . >>ips2.txt
rem Benutzereingaben und Variablen:::
set bereich=1
set ip=192.168.001.000
set start=192.168.001.000
echo *************************
echo Einen IP Bereich anpingen
echo *************************
set/p start=Start-Adresse: 
if "%start%"=="z" goto start 
set aim=30
set/p aim=Anzahl       : 
rem Breche mir aus den Variablen andere Variablen:::
set vip=%ip:~13,15%
set ips=%ip:~12,13%
set ipx=%ip:~0,12%
if not %vip%==0 set anzahl=%vip%
if %vip%==0 set anzahl=0
rem Teile aim durch vier um Statusbalken erstellen zu koennen:::
set/a teil=%aim%/4
set/a haelfte=%teil%+%teil%
set/a dviertel=%teil%*3

rem Ueberpruefen, ob Angaben korrekt sind:::
echo Der IP-Bereich startend von %start% bis %ipx%%aim% wird nun ueberprueft...
cd/d "%appdata%\MTool"
echo %Date%::%Time%:Starting IP-Lookup [  ] >>log.txt
if exist ips.txt del ips.txt /s /q
if exist ips2.txt del ips2.txt /s /q
timeout/t 2 >nul

rem EIGENTLICHE PING SCHLEIFE:::
:loop
cls
set ipn=%ipx%%anzahl%
echo *****************************************************
if %anzahl% LSS %teil% echo Pinge an: %ipn% Fortschritt: [=    ]
if %anzahl% EQU %teil% echo Pinge an: %ipn% Fortschritt: [=    ]
if %anzahl% GTR %teil% if %anzahl% LSS %haelfte% echo Pinge an: %ipn% Fortschritt: [==   ]
if %anzahl% GTR %teil% if %anzahl% EQU %haelfte% echo Pinge an: %ipn% Fortschritt: [==   ]
if %anzahl% GTR %haelfte% if %anzahl% LSS %dviertel% echo Pinge an: %ipn% Fortschritt: [===  ]
if %anzahl% EQU %dviertel% echo Pinge an: %ipn% Fortschritt: [==== ]
if %anzahl% GTR %dviertel% echo Pinge an: %ipn% Fortschritt: [==== ]
echo *****************************************************
ping -n 1 -w 1 %ipn%
if %errorlevel%==0 echo OK IP: %ipn% >>ips2.txt
if %errorlevel%==0 title IP: %ipn% ERFOLGREICH
if %errorlevel%==1 echo IP: %ipn% >>ips.txt
if %errorlevel%==1 title IP: %ipn% FEHLERHAFT
set/a ips=%ips%+1
set/a anzahl=%anzahl%+1
if %anzahl%==%aim% goto endloop
goto loop



:endloop
cd/d %appdata%\MTool
echo %Date%::%Time%: IP-Lookup was successfully[OK] >>log.txt

title Auswertung von IP-Bereich ab %start%
cls
echo * EREICHBARE IP-ADRESSEN:
if exist ips2.txt type ips2.txt
if not exist ips2.txt echo Keine Adresse wurde erreicht.
echo.
echo * NICHT EREICHBARE IP-ADRESSEN:
if exist ips.txt type ips.txt
if not exist ips.txt echo Keine Adresse wurde erreicht.
echo.
echo -------------------- INFO ---------------------------------
echo Alle erreichbaren IP Adressen wurden in der Datei
echo "ips2.txt" unter %appdata%\MTool gespeichert.
echo -----------------------------------------------------------
echo.
echo [Druecken Sie eine beliebige Taste]
pause >nul
goto start

rem *************** DNS Zeug *********************************
:two
cls
title DNS-Cache wird geloescht...
echo Auftrag wurde gestartet...
if exist OLD_DNSCache.txt del OLD_DNSCache.txt
ipconfig /displaydns >>OLD_DNSCache.txt
ipconfig /flushdns >nul
title DNS wird neu angeordnet...
ipconfig /renew >nul
title Aktion fertig.
echo *********************************************
echo Auftrag wurde erfolgreich ausgefuehrt.
echo Der DNS-Cache wurde als Backup abgespeichert.
echo *********************************************
echo.
echo [Druecken Sie eine beliebige Taste]
pause >nul
goto start

rem *************** Benutzer hinzufuegen *********************
:three
title Benutzer hinzufuegen
cls
set benutzer=%default_User%
set passw=%default_Password%
echo --------------------------------------------
echo Voreingestellter Nutzer:   %benutzer%
echo Voreingestelltes Passwort: %passw%
echo --------------------------------------------
set/p benutzer=Neuer Nutzer:   
if %benutzer%==z goto start rem Das Zurueckkehren ermoeglichen
set/p passw=Neues Passwort: 
net user /add %benutzer% %passw%
echo %benutzer%::%passw% |clip
rem if errorlevel 1 echo Nutzer %benutzer% wurde hinzugefuegt.
rem if errorlevel 0 echo !! Nutzer nicht hinzugefuegt !!
echo Daten wurden in Zwischenablage kopiert.
echo.
echo [Druecken Sie eine beliebige Taste]
pause >nul
goto start

rem *************** IP Informationen *************************
:four
title IP-Informationen
cls
echo Informationen zur aktuellen IP:
echo ____________________________________
ipconfig /all
echo.
echo [Druecken Sie eine beliebige Taste]
pause >nul
goto start

rem *************** IP Adresse aendern ***********************
:fife
title IP-Adresse dieses PCs aendern
cls
echo Adresse dynamisch oder statisch vergeben?
echo -----------------------------------------
echo         1 = dynamisch (DHCP)
echo         2 = statisch
echo         9 = Zurueck
choice/c 129 >nul
if errorlevel 9 goto start
if errorlevel 2 goto statisch
if errorlevel 1 goto dynamisch
goto start

:dynamisch
set inp=ipv4
cls
echo       Dynamische IP-Adresse
echo ---------------------------------
echo             1 = IPv4
echo             2 = IPv6
choice/c 12 >nul
if errorlevel 2 netsh interface ipv4 set address name="Ethernet" source=dhcp
if errorlevel 1 netsh interface ipv6 set address name="Ethernet" source=dhcp

cls
echo Wurde angewendet. Konfiguration: DHCP, %inp%, Ethernet
echo.
echo [Druecken Sie eine beliebige Taste]
pause >nul
goto start

:statisch
cls
echo       Statische IP-Adresse
echo ---------------------------------
set ran=%random%
if %ran% GTR 254 echo Zufaellige IP wird generiert...
if %ran% GTR 254 goto statisch
set ip=192.168.1.%ran%
set sub=255.255.255.0
set gateway=192.168.1.1

echo [Automatisch generierte IP: %ip%]
set/p ip=Neue IP-Adresse:  
echo [Voreingestellte Subnetz-Maske: %sub%]
set/p sub=Subnetz-Maske:    
echo [Voreingestellter Gateway: %gateway%]
set/p gateway=Standard-Gateway: 
cls
echo Wird nun angewendet...

ipconfig /all >OLD_IPConfig.txt
netsh interface ipv4 set address name="Ethernet" static %ip% %sub% %gateway%
netsh interface ip set dns "Ethernet" static %gateway%
ipconfig /all >New_IPConfig.txt

echo Wurde angewendet.
echo Informationen wurden abgespeichert.
echo.
echo Ein Selbsttest wurde nun veranlasst... 
ping -n 1 -w 1 %ip%
cd/d %appdata%\MTool
if %errorlevel%==0 echo Selbsttest war ERFOLGREICH!
if %errorlevel%==0 echo %Date%::%Time%:IP changed to %ip% [OK] >>log.txt
if %errorlevel%==1 echo Selbsttest war NICHT erfolgreich!
if %errorlevel%==1 echo %Date%::%Time%:IP NOT changed to %ip% [ ! ] >>log.txt
echo.
echo [Druecken Sie eine beliebige Taste]
pause >nul
goto start

rem ********** PC Informationen erhalten und in Datei schreiben ********************
:six
title Daten ueber diesen PC sammeln
cls
echo Daten ueber diesen PC sammeln und in Datei speichern
echo --------------------------------------------------------------
echo Speicherort festlegen: (Ordner per Drag and Drop hineinziehen)
echo.
set pfad=C:\Users\%Username%\Documents
set/p pfad=:::
if %pfad%==z goto start rem Das Zurueckkehren ermoeglichen
cls
echo Daten werden nun gesammelt...
echo Dies wird eine weile dauern...
cd/d %pfad%
systeminfo >>PCInfo.txt
echo ____________________________________ >>PCInfo.txt
net user >>PCInfo.txt
echo ____________________________________ >>PCInfo.txt
ipconfig /all >>PCInfo.txt
echo ____________________________________ >>PCInfo.txt
echo %Date%::%Time% >>PCInfo.txt
echo Datei wurde als "PCInfo.txt" abgespeichert.
echo.
echo [Druecken Sie eine beliebige Taste]
pause >nul
goto start

rem ***************** PC bereinigen ***************************************
:seven
cls
echo Loescht folgendes: Browserverlauf, Cookies, Zwischenablage, Papierkorb, Downloads
echo 1: Auf eigene Gefahr fortfahren
echo 2: Zurueck
choice/c 12 >nul
if errorlevel 2 goto start
cls
echo PC wird bereinigt...
cd/d %appdata%\MTool
echo %Date%::%Time%:Starting PC Cleanup [  ] >>log.txt
rundll32.exe  InetCpl.cpl,ClearMyTracksByProcess 8
rundll32.exe  InetCpl.cpl,ClearMyTracksByProcess 255
echo off | clip
rd /s /q c:\$Recycle.Bin 
del C:\Users\%username%\Downloads\*.* /s /q
cls
echo PC wurde bereinigt!
echo.
echo [Druecken Sie eine beliebige Taste]
cd/d %appdata%\MTool
echo %Date%::%Time%:PC Cleanup successfull [OK] >>log.txt
pause >nul
goto start

rem **************** Backup erstellen *********************************
:eight
cls
cd/d %appdata%\MTool
echo %Date%::%Time%:Creating Backup [  ] >>log.txt

title Backup wird gerade erstellt...
cd/d %appdata%
if not exist MTool mkdir MTool
cd/d MTool
if not exist Backups mkdir Backups
cd/d C:\Users\%Username%\Desktop
if not exist Files_for_Backup mkdir Files_for_Backup
cd/d Files_for_Backup
if not exist *.* echo Bitte ziehen Sie zuerst die zu sichernden Dateien in den Ordner
if not exist *.* echo "Files_for_Backup" auf Ihrem Desktop.
if not exist *.* echo pause
if not exist *.* goto start
echo Erstelle ein Backup...
xcopy /e C:\Users\%Username%\Desktop\Files_for_Backup %appdata%\MTool\Backups
title Backup wurde erfolgreich erstellt!
echo Backup erstellt. Daten wurden in den Ordner 
echo %appdata%\MTool\Backups kopiert.
echo.
echo [Druecken Sie eine beliebige Taste]
pause >nul
cd/d %appdata%\MTool
echo %Date%::%Time%: Backup created [OK] >>log.txt
goto start

rem *************** Backup wiederherstellen *****************************
:nine
cls
title Backup wird wiederhergestellt...
cd/d %appdata%
if not exist MTool set error=0x001
if not exist MTool goto error
cd/d %appdata%\MTool
echo %Date%::%Time%:Restoring Backup [  ] >>log.txt
cd/d C:\Users\%Username%\Documents
if not exist MTool mkdir MTool
xcopy /e %appdata%\MTool\Backups C:\Users\%Username%\Documents\MTool
title Backup wurde wiederhergestellt!
echo Backup wurde wiederhergestellt, und befindet sich in dem Ordner:
echo C:\Users\%Username%\Documents\MTool.
echo.
echo [Druecken Sie eine beliebige Taste]
pause >nul
cd/d %appdata%\MTool
echo %Date%::%Time%: Backup restored [OK] >>log.txt
goto start

rem ************** Informationen ****************************
:ten
cls
echo          Informationen 
echo.
echo Made by Luca Franziskowski (CodingOwl0) 2018
echo     Version %version% %bezeichnung%
echo.
echo.
echo  (I): Internet muss vorhanden sein
echo   Geben Sie "z" ein, um immer zum 
echo   Men zu gelangen.
echo.
echo [Druecken Sie eine beliebige Taste]
pause >nul
goto start
rem ************** Sicheres Loeschen von Dateien *************************************+++++
:eleven
cls
set zu=0
title Datei sicher loeschen
echo *** Dateien sicher loeschen 
set ein=zero
set/p ein=Datei hier hineinziehen: 
if %ein%==z goto start
if %ein%==zero set error=0x002
if %ein%==zero goto error
echo.
echo ACHTUNG! Diese Datei wird 70x ueberschrieben und geloescht.
echo          Diese Aktion kann nicht mehr rueckgaengig gemacht werden!!!
echo          1 = Weiter, ich verstehe das Risiko.
echo          2 = Nein, zurueck
choice/c 12 >nul
if errorlevel 2 goto start
if errorlevel 1 goto runit
goto eleven
:runit
cd/d %appdata%\MTool
echo %Date%::%Time%:Starting to delete %ein% [  ] >>log.txt

set proz=70
set zahl=0
:looper
set/a zahl=%zahl%+1
if %zahl%==%proz% goto looperexit
echo %random%%random%%random%%random%ox%random% >%ein%
del %ein% /s /q >nul
cls
title Prozedur Nummer %zahl% von %proz% 
echo Prozedur Nummer %zahl% von %proz%
goto looper
:looperexit
rd /s /q c:\$Recycle.Bin
cls
echo Die Datei wurde %proz% Mal ueberschrieben und geloescht.
echo.
echo [Druecken Sie eine beliebige Taste]
pause >nul
cd/d %appdata%\MTool
echo %Date%::%Time%:File deleted successfull [OK] >>log.txt
goto start


rem IP-Route bestimmen:::
:tracert
cls
echo Den Weg zu einer bestimmten IP-Adresse/Website anzeigen
echo.
set/p ip=Adresse: 
cd/d %appdata%\MTool
echo %Date%::%Time%:Route: %ip% >>log.txt
cls
tracert %ip%
echo.
echo [Druecken Sie eine beliebige Taste]
pause >nul
goto start



:update
cls
echo Not implemented yet.
:: echo Update Installer. V1
:: echo This Version %version% will be replaced!
:: pause
:: cd/d %appdata%\MTool
:: echo %Date%::%Time%:Update wurde gestartet [  ]>>log.txt
:: cd %~dp0/data
:: if not exist download.exe set error=0x003
:: if not exist download.exe goto error
:: cls
:: echo Benenne alte Version um...
:: ren MTools.exe Old_MTools.exe
:: echo Downloading new Version...
:: download.exe http://batchsoftware.de/data/documents/MTools.exe MTools.exe
:: if not exist MTools.exe set error=0x004
:: if not exist MTools.exe goto error
:: echo Starte neue Version...
:: start MTools.exe 
:: echo Loesche alte Version...
:: del Old_MTools.exe
:: cd/d %appdata%\MTool
:: echo %Date%::%Time%:Update successfull [OK] >>log.txt
:: echo ----------------------------------
:: echo       Update erfolgreich!
:: echo ----------------------------------
:: echo Das Programm schliesst sich nun...
timeout/t 5 >nul
goto start

:vierzehn
cls
echo Remoteverbindung starten
set ip=192.168.10.1
set/p ip=IP-Adresse: 
echo Programm startet nun im Vollbild.
mstsc /v:%ip% /f
echo.
echo [Druecken Sie eine beliebige Taste]
pause >nul
goto start

:siebzehn
cls
echo Datei ver-/entschluesseln
echo 1: Datei verschluesseln
echo 2: Datei entschluesseln
echo 9: Zurueck
choice/c 129 >nul
if errorlevel 9 goto start
if errorlevel 2 goto sechszehn
if errorlevel 1 goto funfzehn

:neunzehn
cls
echo Automatisches Backup einrichten
set pfad1=0
set pfad2=0
set pfad3=0
set pfad4=0
set pfad5=0
set/p pfad1=Dateipfad1: 
set/p pfad2=Dateipfad2: 
set/p pfad3=Dateipfad3: 
set/p pfad4=Dateipfad4: 
set/p pfad5=Dateipfad5: 
set/p ziel=Zielpfad: 
echo Soll ein Backup alle X Minuten erstellt werden?
echo 0 = Nein, 1 = Ja
set loop=0
set/p loop=: 
if %loop%==0 goto neunzehn2
echo Wie lange soll nach einem Backup gewartet werden?
echo (in Sekunden)
set sek=30
set/p sek=:
:neunzehn2
cd/d %~dp0
echo Soll ein Backup automatisch erstellt werden?
echo 0 = Nein, 1 = Ja
set eing=1
set/p eing=: 
if %eing%==0 goto neunzehn3
cd data
if exist astart.exe start astart.exe
if not exist astart.exe if exist astart.bat start astart.bat
:neunzehn3
echo.
echo [Druecken Sie eine beliebige Taste]
pause >nul
goto start



:funfzehn
cls
echo Datei verschluesseln 
echo (.txt Dateien sind bevorzugt!)
echo Ziehe die .txt Datei per Drag and Drop in das Fenster hinein.
echo Druecke dann Enter.
set pfad=%appdata%\MTool\log.txt
set pass=%Firma%_admin

set/p pfad=Dateipfad: 
set/p pass=Passwort:  
cls
echo Datei wird nun verschluesselt...
cd/d %~dp0/data
if not exist rc4.exe set error=0x005
if not exist rc4.exe goto error
rc4.exe %pass% %pfad% encrypted%Date%_%random%.rc4
echo Datei wurde verschluesselt!
echo.
echo [Druecken Sie eine beliebige Taste]
pause >nul
goto start

:sechszehn
cls
echo Datei entschluesseln
echo Ziehe die .rc4 Datei per Drag and Drop in das Fenster hinein.
echo Druecke dann Enter.
set/p pfad=Dateipfad: 
set/p pass=Passwort:  
cls
echo Datei wird nun entschluesselt...
cd/d %~dp0/data
if not exist rc4.exe set error=0x005
if not exist rc4.exe goto error
rc4.exe %pass% %pfad% entschluesselt%Date%_%random%.txt
echo Datei wurde verschluesselt!
echo.
echo.
echo [Druecken Sie eine beliebige Taste]
pause >nul
goto start

:achtzehn
cls
cd/d %~dp0/data
if not exist 7za.exe set error=0x007
if not exist 7za.exe goto error
echo Ordner zippen
set/p pfad=Ordner hineinziehen: 
if %pfad%==z goto start
if not exist %pfad% set error=0x008
if not exist %pfad% goto error
7za.exe a -r Zipped%Date%.zip %pfad%\*
copy Zipped%Date%.zip %pfad%
start Zipped%Date%.zip
echo.
echo [Druecken Sie eine beliebige Taste]
pause >nul
goto start




:manual
cls
echo Die Bedienungsanleitung wird aus dem Internet heruntergeladen...
cd/d %~dp0/data
if not exist download.exe set error=0x006
if not exist download.exe goto error
if exist MManual*.txt del MManual*.txt
download.exe http://batchsoftware.de/data/documents/MManual.txt MManual%Date%.txt
if not exist MManual%Date%.txt echo Sie mssen mit dem Internet verbunden sein, um die aktuelle Anleitung anzusehen.
if not exist MManual%Date%.txt pause
if not exist MManual%Date%.txt goto start
timeout/t 1 >nul
cls
type MManual%Date%.txt
echo.
echo.
echo [Druecken Sie eine beliebige Taste]
pause >nul
goto start

:log
cls
cd/d %appdata%\MTool
echo **********  Log Datei ****************
echo * Datum: *  Uhrzeit:  *   Ereignis:
if exist log.txt type log.txt
if not exist log.txt echo Log Datei exestiert (noch) nicht!
echo.
echo [Druecken Sie eine beliebige Taste]
pause >nul
goto start


:error
color c0
cls
echo ERROR ERROR ERROR ERROR ERROR
echo -----------------------------
echo Ein Fehler ist aufgetreten!
echo Fehlercode: %error%
echo -----------------------------
echo.
echo [Druecken Sie eine beliebige Taste]
pause >nul
cd/d %appdata%\MTool
echo %Date%::%Time%:Error: %error% [ ! ] >>log.txt
goto start

