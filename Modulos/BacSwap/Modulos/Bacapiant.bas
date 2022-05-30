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
     x As Integer
     Y As Integer
End Type

' Windows API Functions
Declare Function SetMenu Lib "User" (ByVal hWnd As Integer, ByVal hMenu As Integer) As Integer
Declare Function CreateMenu Lib "User" () As Integer
Declare Function CreatePopupMenu Lib "User" () As Integer
Declare Function AppendMenu Lib "User" (ByVal hMenu As Integer, ByVal wFlags As Integer, ByVal wIDNewItem As Integer, ByVal lpNewItem As Any) As Integer
Declare Function DestroyMenu Lib "User" (ByVal hMenu As Integer) As Integer
Declare Function GetSubMenu Lib "User" (ByVal hMenu As Integer, ByVal nPos As Integer) As Integer
Declare Function GetMenu Lib "User" (ByVal hWnd As Integer) As Integer
Declare Function CheckMenuItem Lib "User" (ByVal hMenu As Integer, ByVal wIDCheckItem As Integer, ByVal wCheck As Integer) As Integer
Declare Function GetMenuState Lib "User" (ByVal hMenu As Integer, ByVal wIDCheckItem As Integer, ByVal wFlags As Integer) As Integer
Declare Sub DrawMenuBar Lib "User" (ByVal hWnd As Integer)
Declare Function InsertMenu Lib "User" (ByVal hMenu As Integer, ByVal nPosition As Integer, ByVal wFlags As Integer, ByVal wIDNewItem As Integer, ByVal lpNewItem As Any) As Integer

Declare Sub GetCursorPos Lib "User" (lpPoint As POINTAPI)
Declare Function GetActiveWindow Lib "User" () As Integer
Declare Function WindowFromPoint Lib "User" (ByVal lpPointY As Integer, ByVal lpPointX As Integer) As Integer
Declare Function ChildWindowFromPoint Lib "User" (ByVal hWnd As Integer, ByVal lpPointY As Integer, ByVal lpPointX As Integer) As Integer
Declare Function ShowWindow Lib "User" (ByVal hWnd As Integer, ByVal nCmdShow As Integer) As Integer
Declare Sub ScreenToClient Lib "User" (ByVal hWnd As Integer, lpPoint As POINTAPI)
Declare Sub SetWindowPos Lib "User" (ByVal hWnd As Integer, ByVal hWndInsertAfter As Integer, ByVal x As Integer, ByVal Y As Integer, ByVal cx As Integer, ByVal cy As Integer, ByVal wFlags As Integer)
Declare Function SetParent Lib "User" (ByVal hWndChild As Integer, ByVal hWndNewParent As Integer) As Integer

Declare Function SendMessage Lib "User" (ByVal hWnd As Integer, ByVal wMsg As Integer, ByVal wParam As Integer, lParam As Any) As Long
Declare Function SendMessageByNum Lib "User" Alias "SendMessage" (ByVal hWnd%, ByVal wMsg%, ByVal wParam%, ByVal lParam&) As Long
Declare Function SendMessageByString Lib "User" Alias "SendMessage" (ByVal hWnd%, ByVal wMsg%, ByVal wParam%, ByVal lParam$) As Long

Declare Function GetPrivateProfileString Lib "Kernel" (ByVal lpApplicationName As String, lpKeyName As Any, ByVal lpDefault As String, ByVal lpReturnedString As String, ByVal nSize As Integer, ByVal lpFileName As String) As Integer
Declare Function WritePrivateProfileString Lib "Kernel" (ByVal lpApplicationName As String, lpKeyName As Any, lpString As Any, ByVal lplFileName As String) As Integer

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
   
   nRet% = SetParent(child.hWnd%, MDI.hWnd%)

End Sub

'---------------------------------------------------
'ReadINI
'
'Lee archivos .INI
'---------------------------------------------------
Function ReadINI(cSection$, cKeyName$, sFilename As String) As String
   
   Dim sRet As String
   
   sRet = String(255, Chr(0))
   
   ReadINI = Left(sRet, GetPrivateProfileString(cSection$, ByVal cKeyName$, "", sRet, Len(sRet), sFilename))

End Function

'---------------------------------------------------
'WriteINI
'
'Escribe en archivos .INI
'---------------------------------------------------
Function WriteINI(cSection$, cKeyName$, cNewString$, sFilename As String) As Integer
   
   WriteINI = WritePrivateProfileString(cSection$, cKeyName$, cNewString$, sFilename)

End Function

