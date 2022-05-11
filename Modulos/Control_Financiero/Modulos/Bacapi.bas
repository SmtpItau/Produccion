Attribute VB_Name = "BacAPI"
'-------------------------------------------------
'Este módulo debe contener todas las declaraciones
'de funciones Windows API usadas en el proyecto.-
'JM
'-------------------------------------------------

Option Explicit

'Windows Messages

Global Const WM_MENUSELECT = &H11F
Global Const WM_COMMAND = &H111
Global Const WM_USER = &H400
Global Const CB_FINDSTRINGEXACT = (WM_USER + 24)
Global Const LB_FINDSTRING = (WM_USER + 16)

'Windows Pos Flags
Global Const SWP_NOACTIVATE = &H10
Global Const SWP_NOMOVE = &H2
Global Const SWP_NOSIZE = &H1
Global Const SWP_SHOWWINDOW = &H40
Global Const HWND_TOPMOST = -1

'Show Window Flags.-
Global Const SW_SHOWNOACTIVATE = 4

'Menu Flags
Global Const MF_BYCOMMAND = &H0
Global Const MF_ENABLED = &H0
Global Const MF_STRING = &H0
Global Const MF_POPUP = &H10
Global Const MF_SEPARATOR = &H800
Global Const MF_CHECKED = &H8
Global Const MF_UNCHECKED = &H0

'Types Windows
Type POINTAPI
     x As Integer
     Y As Integer
End Type

' Windows API Functions
Declare Function SendMessageByString Lib "User" Alias "SendMessage" (ByVal hWnd%, ByVal wMsg%, ByVal wParam%, ByVal lParam$) As Long
Declare Function GetPrivateProfileString Lib "kernel32" Alias "GetPrivateProfileStringA" (ByVal lpApplicationName As String, ByVal lpKeyName As Any, ByVal lpDefault As String, ByVal lpReturnedString As String, ByVal nSize As Long, ByVal lpFileName As String) As Long
Declare Function WritePrivateProfileString Lib "kernel32" Alias "WritePrivateProfileStringA" (ByVal lpApplicationName As String, ByVal lpKeyName As Any, ByVal lpString As Any, ByVal lpFileName As String) As Long
Declare Function GetUserName Lib "advapi32.dll" Alias "GetUserNameA" (ByVal lpBuffer As String, nSize As Long) As Long

'---------------------------------------------------
'ReadINI
'
'Lee archivos .INI
'---------------------------------------------------

Function Func_Read_INI(cSection$, cKeyName$, sFilename As String) As String

Dim sret As String

sret = String(255, Chr(0))
Func_Read_INI = Left(sret, GetPrivateProfileString(cSection$, ByVal cKeyName$, "", sret, Len(sret), sFilename))

End Function


'Function ClearStoredProcParam()
 '   Dim i As Integer
    
   ' For i = 0 To 20
  '      BacCambio.crystal.StoredProcParam(i) = ""
  '  Next i
    
'End Function

Public Sub Sendkeys(text$, Optional wait As Boolean = False)
Dim WshShell As Object
Set WshShell = CreateObject("wscript.shell")
WshShell.Sendkeys text, wait
    Set WshShell = Nothing
End Sub

