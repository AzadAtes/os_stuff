@echo off
setlocal

set SRC=D:\Data
set DEST=E:\Backup

robocopy %SRC% %DEST% /MIR
set EXITCODE=%ERRORLEVEL%

set MSG=
if %EXITCODE%==0 set MSG=Keine Dateien kopiert. Alles aktuell.
if %EXITCODE%==1 set MSG=Alle Dateien erfolgreich kopiert.
if %EXITCODE%==2 set MSG=Zusätzliche Dateien im Zielverzeichnis.
if %EXITCODE%==3 set MSG=Einige Dateien kopiert, zusätzliche vorhanden.
if %EXITCODE%==5 set MSG=Einige Dateien kopiert mit Dateikonflikten.
if %EXITCODE%==6 set MSG=Zusätzliche und nicht übereinstimmende Dateien vorhanden.
if %EXITCODE%==7 set MSG=Dateien kopiert, mit Konflikten und zusätzlichen Dateien.
if %EXITCODE%==8 set MSG=Fehler: Mehrere Dateien wurden nicht kopiert.

if not defined MSG set MSG=Unbekannter Robocopy-EXITCODE: %EXITCODE%

REM --- Send notification ---
powershell -Command "[Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] > $null; $template = [Windows.UI.Notifications.ToastNotificationManager]::GetTemplateContent([Windows.UI.Notifications.ToastTemplateType]::ToastText02); $textNodes = $template.GetElementsByTagName('text'); $textNodes.Item(0).AppendChild($template.CreateTextNode('Robocopy abgeschlossen')) > $null; $textNodes.Item(1).AppendChild($template.CreateTextNode('%MSG%')) > $null; $notifier = [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier('BackupScript'); $notification = [Windows.UI.Notifications.ToastNotification]::new($template); $notifier.Show($notification)"

endlocal
