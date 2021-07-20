Attribute VB_Name = "General"
Option Explicit
Option Private Module

Function FolderExists(ByVal sFolderPath) As Boolean
'Requires reference to Microsoft Scripting runtime
'An alternative solution exists using the DIR function but this seems to result in memory leak and folder is
'not released by VBA

    Dim fso As Scripting.FileSystemObject
    Dim FolderPath As String

    Set fso = New Scripting.FileSystemObject

    If Right(sFolderPath, 1) <> Application.PathSeparator Then
        FolderPath = FolderPath & Application.PathSeparator
    End If

    FolderExists = fso.FolderExists(sFolderPath)
    Set fso = Nothing

End Function



Sub CreateFolder(ByVal sFolderPath As String)
'   Requires reference to Microsoft Scripting runtime

    Dim fso As FileSystemObject

    If FolderExists(sFolderPath) Then
        MsgBox ("Folder already exists, new folder not created")
    Else
        Set fso = New FileSystemObject
        fso.CreateFolder sFolderPath
    End If

    Set fso = Nothing

End Sub


Sub DeleteFirstLineOfTextFile(ByVal sFilePathAndName As String)

    Dim sInput As String
    Dim sOutput() As String
    Dim i As Long
    Dim j As Long
    Dim lSizeOfOutput As Long
    Dim iFileNo As Integer
    
    iFileNo = FreeFile
    
    'Import file lines to array excluding firt line
    Open sFilePathAndName For Input As iFileNo
    i = 0
    j = 0
    Do Until EOF(iFileNo)
        j = j + 1
        Line Input #iFileNo, sInput
        If j > 1 Then
            i = i + 1
            ReDim Preserve sOutput(1 To i)
            sOutput(i) = sInput
        End If
    Loop
    Close #iFileNo
    lSizeOfOutput = i
    
    'Write array to file
    Open sFilePathAndName For Output As 1
    For i = 1 To lSizeOfOutput
        Print #iFileNo, sOutput(i)
    Next i
    Close #iFileNo
    
    
End Sub


Function WorkbookIsOpen(ByVal sWbkName As String) As Boolean
'Checks if workbook is open based on filename including extension

    WorkbookIsOpen = False
    On Error Resume Next
    WorkbookIsOpen = Len(Workbooks(sWbkName).Name) <> 0
    On Error GoTo 0

End Function
