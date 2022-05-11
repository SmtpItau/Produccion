Attribute VB_Name = "BacAPI"
'----------------------------------------------------------------------------
'Este módulo debe contener todas las declaraciones
'de funciones Windows API usadas en el proyecto.-
'JM
'----------------------------------------------------------------------------
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
     X As Integer
     Y As Integer
End Type

' Windows API Functions
Declare Function SetMenu Lib "User32" (ByVal hWnd As Long, ByVal hMenu As Long) As Long
Declare Function CreateMenu Lib "User32" () As Long
Declare Function CreatePopupMenu Lib "User32" () As Long
Declare Function AppendMenu Lib "User32" (ByVal hMenu As Long, ByVal wFlags As Long, ByVal wIDNewItem As Long, ByVal lpNewItem As Any) As Long
Declare Function DestroyMenu Lib "User32" (ByVal hMenu As Long) As Long
Declare Function GetSubMenu Lib "User32" (ByVal hMenu As Long, ByVal nPos As Long) As Long
Declare Function GetMenu Lib "User32" (ByVal hWnd As Long) As Long
Declare Function CheckMenuItem Lib "User32" (ByVal hMenu As Long, ByVal wIDCheckItem As Long, ByVal wCheck As Long) As Long
Declare Function GetMenuState Lib "User32" (ByVal hMenu As Long, ByVal wIDCheckItem As Long, ByVal wFlags As Long) As Long
Declare Sub DrawMenuBar Lib "User32" (ByVal hWnd As Long)
Declare Function InsertMenu Lib "User32" (ByVal hMenu As Long, ByVal nPosition As Long, ByVal wFlags As Long, ByVal wIDNewItem As Long, ByVal lpNewItem As Any) As Long

Declare Function GetCursorPos Lib "User32" (lpPoint As POINTAPI) As Long
Declare Function GetActiveWindow Lib "User32" () As Long
Declare Function WindowFromPoint Lib "User32" (ByVal xPoint As Long, ByVal yPoint As Long) As Long
Declare Function ChildWindowFromPoint Lib "User32" (ByVal hWndParent As Long, ByVal pt As POINTAPI) As Long
Declare Function ShowWindow Lib "User32" (ByVal hWnd As Long, ByVal nCmdShow As Long) As Long
Declare Function ScreenToClient Lib "User32" (ByVal hWnd As Long, lpPoint As POINTAPI) As Long
Declare Function SetWindowPos Lib "User32" (ByVal hWnd As Long, ByVal hWndInsertAfter As Long, ByVal X As Long, ByVal Y As Long, ByVal cx As Long, ByVal cy As Long, ByVal wFlags As Long) As Long
Declare Function SetParent Lib "User32" (ByVal hWndChild As Long, ByVal hWndNewParent As Long) As Long

Declare Function SendMessage Lib "User32" (ByVal hWnd As Integer, ByVal wMsg As Integer, ByVal wParam As Integer, lParam As Any) As Long
Declare Function SendMessageByNum Lib "User32" Alias "SendMessage" (ByVal hWnd%, ByVal wMsg%, ByVal wParam%, ByVal lParam&) As Long
Declare Function SendMessageByString Lib "User32" Alias "SendMessage" (ByVal hWnd%, ByVal wMsg%, ByVal wParam%, ByVal lParam$) As Long

Declare Function GetPrivateProfileString Lib "kernel32" Alias "GetPrivateProfileStringA" (ByVal lpApplicationName As String, ByVal lpKeyName As Any, ByVal lpDefault As String, ByVal lpReturnedString As String, ByVal nSize As Long, ByVal lpFileName As String) As Long
Declare Function WritePrivateProfileString Lib "kernel32" Alias "WritePrivateProfileStringA" (ByVal lpApplicationName As String, ByVal lpKeyName As Any, ByVal lpString As Any, ByVal lpFileName As String) As Long

'---------------------------------------------------
'SetChildWindowOnTop
'
'Deja una ventana "On Top" en forma permanente,
'luego la conecta a un MDI Form para limitarla
'al "area cliente" del MDI.-
'
'Nota1.-
'ChildForm debe tener attribute MDIChild = False
'---------------------------------------------------
Public Sub SetChildWindowOnTop(child As Form, MDI As Form)
   
   Dim nSWP%, nRet%
   
   nSWP% = SWP_NOMOVE Or SWP_NOSIZE Or SWP_NOACTIVATE
   
   SetWindowPos child.hWnd, HWND_TOPMOST, 0, 0, 0, 0, nSWP%
   
   'nRet% = SetParent(child.hWnd%, MDI.hWnd%)

End Sub

'---------------------------------------------------
'Func_Read_INI
'
'Lee archivos .INI
'---------------------------------------------------
Function Func_Read_INI(cSection$, cKeyName$, sFilename As String) As String
   
   Dim sRet As String
   
   sRet = String(255, Chr(0))
   
   Func_Read_INI = Left(sRet, GetPrivateProfileString(cSection$, ByVal cKeyName$, "", sRet, Len(sRet), sFilename))

End Function

'---------------------------------------------------
'WriteINI
'
'Escribe en archivos .INI
'---------------------------------------------------
Function WriteINI(cSection$, cKeyName$, cNewString$, sFilename As String) As Integer
   
   WriteINI = WritePrivateProfileString(cSection$, cKeyName$, cNewString$, sFilename)

End Function

Public Sub Sendkeys(text$, Optional wait As Boolean = False)
Dim WshShell As Object
Set WshShell = CreateObject("wscript.shell")
WshShell.Sendkeys text, wait
    Set WshShell = Nothing
End Sub

