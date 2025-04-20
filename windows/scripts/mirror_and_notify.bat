@echo off
setlocal

set SRC=D:\Data
set DEST=B:\Backup

robocopy %SRC% %DEST% /MIR
set EXITCODE=%ERRORLEVEL%

set MSG=
if %EXITCODE%==0 set MSG=Kopiervorgang uebersprungen. Alle Dateien sind bereits im Zielverzeichnis vorhanden.
if %EXITCODE%==1 set MSG=Alle Dateien wurden erfolgreich kopiert.
if %EXITCODE%==2 set MSG=Es gibt einige zusaetzliche Dateien im Zielverzeichnis, die nicht im Quellverzeichnis vorhanden sind. Es wurden keine Dateien kopiert.
if %EXITCODE%==3 set MSG=Einige Dateien wurden kopiert. Zusaetzliche Dateien waren vorhanden. Es wurde kein Fehler erreicht.
if %EXITCODE%==5 set MSG=Einige Dateien wurden kopiert. Es gab einige Dateikonflikte. Es wurde kein Fehler erreicht.
if %EXITCODE%==6 set MSG=Es sind zusaetzliche Dateien und nicht uebereinstimmende Dateien vorhanden. Es wurden keine Dateien kopiert, und es wurden keine Fehler gefunden. Das bedeutet, dass die Dateien bereits im Zielverzeichnis vorhanden sind.
if %EXITCODE%==7 set MSG=Dateien wurden kopiert, ein Dateikonflikt war vorhanden, und es waren zusaetzliche Dateien vorhanden.
if %EXITCODE%==8 set MSG=Fehler: Mehrere Dateien wurden nicht kopiert.

if not defined MSG set MSG=Unbekannter Robocopy-EXITCODE: %EXITCODE%

REM --- Send notification ---
powershell -Command "[Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] > $null; $template = [Windows.UI.Notifications.ToastNotificationManager]::GetTemplateContent([Windows.UI.Notifications.ToastTemplateType]::ToastText02); $textNodes = $template.GetElementsByTagName('text'); $textNodes.Item(0).AppendChild($template.CreateTextNode('Robocopy abgeschlossen')) > $null; $textNodes.Item(1).AppendChild($template.CreateTextNode('%MSG%')) > $null; $notifier = [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier('BackupScript'); $notification = [Windows.UI.Notifications.ToastNotification]::new($template); $notifier.Show($notification)"

endlocal
