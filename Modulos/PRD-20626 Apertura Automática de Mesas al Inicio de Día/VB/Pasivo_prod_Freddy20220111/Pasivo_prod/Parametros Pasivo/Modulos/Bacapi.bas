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
Declare Function SetMenu Lib "user32" (ByVal hWnd As Long, ByVal hMenu As Long) As Long
Declare Function CreateMenu Lib "user32" () As Long
Declare Function CreatePopupMenu Lib "user32" () As Long
Declare Function AppendMenu Lib "user32" (ByVal hMenu As Long, ByVal wFlags As Long, ByVal wIDNewItem As Long, ByVal lpNewItem As Any) As Long
Declare Function DestroyMenu Lib "user32" (ByVal hMenu As Long) As Long
Declare Function GetSubMenu Lib "user32" (ByVal hMenu As Long, ByVal nPos As Long) As Long
Declare Function GetMenu Lib "user32" (ByVal hWnd As Long) As Long
Declare Function CheckMenuItem Lib "user32" (ByVal hMenu As Long, ByVal wIDCheckItem As Long, ByVal wCheck As Long) As Long
Declare Function GetMenuState Lib "user32" (ByVal hMenu As Long, ByVal wIDCheckItem As Long, ByVal wFlags As Long) As Long
Declare Sub DrawMenuBar Lib "user32" (ByVal hWnd As Long)
Declare Function InsertMenu Lib "user32" (ByVal hMenu As Long, ByVal nPosition As Long, ByVal wFlags As Long, ByVal wIDNewItem As Long, ByVal lpNewItem As Any) As Long

Declare Function GetCursorPos Lib "user32" (lpPoint As POINTAPI) As Long
Declare Function GetActiveWindow Lib "user32" () As Long
Declare Function WindowFromPoint Lib "user32" (ByVal xPoint As Long, ByVal yPoint As Long) As Long
Declare Function ChildWindowFromPoint Lib "user32" (ByVal hWndParent As Long, ByVal pt As POINTAPI) As Long
Declare Function ShowWindow Lib "user32" (ByVal hWnd As Long, ByVal nCmdShow As Long) As Long
Declare Function ScreenToClient Lib "user32" (ByVal hWnd As Long, lpPoint As POINTAPI) As Long
Declare Function SetWindowPos Lib "user32" (ByVal hWnd As Long, ByVal hWndInsertAfter As Long, ByVal X As Long, ByVal Y As Long, ByVal cx As Long, ByVal cy As Long, ByVal wFlags As Long) As Long
Declare Function SetParent Lib "user32" (ByVal hWndChild As Long, ByVal hWndNewParent As Long) As Long

Declare Function SendMessage Lib "user32" (ByVal hWnd As Integer, ByVal wMsg As Integer, ByVal wParam As Integer, lParam As Any) As Long
Declare Function SendMessageByNum Lib "user32" Alias "SendMessage" (ByVal hWnd%, ByVal wMsg%, ByVal wParam%, ByVal lParam&) As Long
Declare Function SendMessageByString Lib "user32" Alias "SendMessage" (ByVal hWnd%, ByVal wMsg%, ByVal wParam%, ByVal lParam$) As Long

Declare Function GetPrivateProfileString Lib "kernel32" Alias "GetPrivateProfileStringA" (ByVal lpApplicationName As String, ByVal lpKeyName As Any, ByVal lpDefault As String, ByVal lpReturnedString As String, ByVal nSize As Long, ByVal lpFileName As String) As Long
Declare Function WritePrivateProfileString Lib "kernel32" Alias "WritePrivateProfileStringA" (ByVal lpApplicationName As String, ByVal lpKeyName As Any, ByVal lpString As Any, ByVal lpFileName As String) As Long
Declare Sub KeyBD_Event Lib "user32" Alias "keybd_event" (ByVal bVk As Byte, ByVal bScan As Byte, ByVal dwFlags As Long, ByVal dwExtraInfo As Long)


'============================================================================================
'Usada para seleccionar la ruta de la interfaz
Declare Function SHGetPathFromIDList Lib "shell32.dll" Alias "SHGetPathFromIDListA" (ByVal pidl As Long, ByVal pszPath As String) As Long
Declare Function SHBrowseForFolder Lib "Shell32" Alias "SHBrowseForFolderA" (lpbi As BROWSEINFO) As Long
Global Const BIF_RETURNONLYFSDIRS   As Integer = 1    'Devolver sólo directorios del Sistema de Ficheros

'DECLARACIONES
' Este es el tipo que se pasa a la función del API SHBroseForFolder
Type BROWSEINFO

    hWndOwner As Long         'ventana propietaria del dialogo de buscar carpetas
    pidlRoot As Long          'puntero al ItemID de la carpeta raíz
    pszDisplayName As String  'el nombre mostrado del objeto
    lpszTitle As String       'el titulo de la ventana de dialogo
    uFlags As Integer         'modificadores - ver abajo
    lpfn As Long              'direccion de una funcion "callback" (opcional)
    lParam As Long            'para el "callback", no utilizado
    iImage As Long            'para el "callback", no utilizado
    
End Type
'===========================================================================================

Public Function Bac_SendKey(ByVal nKey As Integer)
 
   KeyBD_Event nKey, 0, 0, 0
 
End Function

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


