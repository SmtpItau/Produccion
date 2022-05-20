Attribute VB_Name = "BACWallpaper"
'Wallpaper
Declare Function GetClassName Lib "user32" Alias "GetClassNameA" (ByVal hwnd&, ByVal lpClassName$, ByVal nMaxCount&) As Long
Declare Function RegCloseKey Lib "advapi32.dll" (ByVal Hkey As Long) As Long
Declare Function RegCreateKey Lib "advapi32.dll" Alias "RegCreateKeyA" (ByVal Hkey As Long, ByVal lpSubKey As String, phkResult As Long) As Long
Declare Function RegDeleteKey Lib "advapi32.dll" Alias "RegDeleteKeyA" (ByVal Hkey As Long, ByVal lpSubKey As String) As Long
Declare Function RegDeleteValue Lib "advapi32.dll" Alias "RegDeleteValueA" (ByVal Hkey As Long, ByVal lpValueName As String) As Long
Declare Function RegOpenKey Lib "advapi32.dll" Alias "RegOpenKeyA" (ByVal Hkey As Long, ByVal lpSubKey As String, phkResult As Long) As Long
Declare Function RegQueryValueEx Lib "advapi32.dll" Alias "RegQueryValueExA" (ByVal Hkey As Long, ByVal lpValueName As String, ByVal lpReserved As Long, lpType As Long, lpData As Any, lpcbData As Long) As Long
Declare Function RegSetValueEx Lib "advapi32.dll" Alias "RegSetValueExA" (ByVal Hkey As Long, ByVal lpValueName As String, ByVal Reserved As Long, ByVal dwType As Long, lpData As Any, ByVal cbData As Long) As Long
Declare Function SetParent Lib "user32" (ByVal hWndChild As Long, ByVal hWndNewParent As Long) As Long
Declare Sub SHChangeNotify Lib "shell32" (ByVal wEventId As Long, ByVal uFlags As Long, ByVal dwItem1 As Long, ByVal dwItem2 As Long)
Declare Function GetWindowTextLength Lib "user32" Alias "GetWindowTextLengthA" (ByVal hwnd As Long) As Long
Declare Function GetWindowText Lib "user32" Alias "GetWindowTextA" (ByVal hwnd As Long, ByVal lpString As String, ByVal cch As Long) As Long
Declare Function GetForegroundWindow Lib "user32" () As Long
Declare Function GetWindowsDirectory Lib "kernel32" Alias "GetWindowsDirectoryA" (ByVal lpBuffer As String, ByVal nSize As Long) As Long
Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)
Declare Function GetSystemMetrics Lib "user32" (ByVal nIndex As Long) As Long
Declare Sub KeyBD_Event Lib "user32" Alias "keybd_event" (ByVal bVk As Byte, ByVal bScan As Byte, ByVal dwFlags As Long, ByVal dwExtraInfo As Long)
Declare Function GetComputerName Lib "kernel32" Alias "GetComputerNameA" (ByVal lpBuffer As String, nSize As Long) As Long

Declare Function CreateMailslotNoSecurity Lib "kernel32" Alias "CreateMailslotA" (ByVal lpName As String, ByVal nMaxMessageSize As Long, ByVal lReadTimeout As Long, ByVal Zero As Long) As Long
Declare Function GetMailslotInfo Lib "kernel32" (ByVal hMailslot As Long, lpMaxMessageSize As Long, lpNextSize As Long, lpMessageCount As Long, lpReadTimeout As Long) As Long
Declare Function ReadFileSimple Lib "kernel32" Alias "ReadFile" (ByVal hFile As Long, ByVal lpBuffer As String, ByVal nNumberOfBytesToRead As Long, lpNumberOfBytesRead As Long, ByVal Zero As Long) As Long
Declare Function CloseHandle Lib "kernel32" (ByVal hObject As Long) As Long
Declare Function FindWindowEx Lib "user32" Alias "FindWindowExA" (ByVal hWndParent&, ByVal hWndChildAfter&, ByVal lpClassName$, ByVal lpWindowName$) As Long
Declare Function GetDC Lib "user32" (ByVal hwnd&) As Long
Declare Function CreateCompatibleDC Lib "gdi32" (ByVal hDC&) As Long
Declare Function CreateCompatibleBitmap Lib "gdi32" (ByVal hDC&, ByVal nWidth&, ByVal nHeight&) As Long
Declare Function ReleaseDC Lib "user32" (ByVal hwnd&, ByVal hDC&) As Long
Declare Function SaveDC Lib "gdi32" (ByVal hDC&) As Long
Declare Function GetObjectAPI Lib "gdi32" Alias "GetObjectA" (ByVal hObject&, ByVal nCount&, lpObject As Any) As Long
Declare Function SelectObject Lib "gdi32" (ByVal hDC&, ByVal hObject&) As Long
Declare Function GetClientRect Lib "user32" (ByVal hwnd&, lpRect As RECT) As Long
Declare Function GetWindowLong Lib "user32" Alias "GetWindowLongA" (ByVal hwnd&, ByVal nIndex&) As Long
Declare Function StretchBlt Lib "gdi32" (ByVal hDC&, ByVal X&, ByVal Y&, ByVal nWidth&, ByVal nHeight&, ByVal hSrcDC&, ByVal xSrc&, ByVal ySrc&, ByVal nSrcWidth&, ByVal nSrcHeight&, ByVal dwRop&) As Long
Declare Function DeleteObject Lib "gdi32" (ByVal hObject&) As Long
Declare Function RestoreDC Lib "gdi32" (ByVal hDC&, ByVal nSavedDC&) As Long
Declare Function DeleteDC Lib "gdi32" (ByVal hDC&) As Long
Declare Function BitBlt Lib "gdi32" (ByVal hDestDC&, ByVal X&, ByVal Y&, ByVal nWidth&, ByVal nHeight&, ByVal hSrcDC&, ByVal xSrc&, ByVal ySrc&, ByVal dwRop&) As Long
Declare Function InvalidateRect Lib "user32" (ByVal hwnd&, lpRect As RECT, ByVal bErase&) As Long
Declare Function FreeLibrary Lib "kernel32" (ByVal hLibModule&) As Long
Declare Function OleCreatePictureIndirect Lib "olepro32.dll" (PicDesc As PICTDESC_BMP, RefIID As GUID, ByVal fPictureOwnsHandle&, IPic As IPicture) As Long
Declare Function CreateBitmap Lib "gdi32" (ByVal nWidth&, ByVal nHeight&, ByVal nPlanes&, ByVal nBitCount&, lpBits As Any) As Long
Declare Function SetBkColor Lib "gdi32" (ByVal hDC&, ByVal crColor&) As Long
Declare Function GetDeviceCaps Lib "gdi32" (ByVal hDC&, ByVal iCapabilitiy&) As Long
Declare Function GetSystemPaletteEntries Lib "gdi32" (ByVal hDC&, ByVal wStartIndex&, ByVal wNumEntries&, lpPaletteEntries As PALETTEENTRY) As Long
Declare Function CreatePalette Lib "gdi32" (lpLogPalette As LOGPALETTE256) As Long
Declare Function SelectPalette Lib "gdi32" (ByVal hDC&, ByVal hPalette&, ByVal bForceBackground&) As Long
Declare Function RealizePalette Lib "gdi32" (ByVal hDC&) As Long

Public Type RECT
    left   As Long
    top    As Long
    right  As Long
    bottom As Long
End Type

Public Type POINTL
    X As Long
    Y As Long
End Type

Public Type PALETTEENTRY
    peRed   As Byte
    peGreen As Byte
    peBlue  As Byte
    peFlags As Byte
End Type

Public Type LOGPALETTE256
    palVersion       As Integer
    palNumEntries    As Integer
    palPalEntry(255) As PALETTEENTRY
End Type

Public Type BITMAP
    bmType       As Long
    bmWidth      As Long
    bmHeight     As Long
    bmWidthBytes As Long
    bmPlanes     As Integer
    bmBitsPixel  As Integer
    bmBits       As Long
End Type

Public Type GUID
    Data1    As Long
    Data2    As Integer
    Data3    As Integer
    Data4(7) As Byte
End Type

Public Type PICTDESC_BMP
    Size     As Long
    Type     As Long
    hBmp     As Long
    hPal     As Long
    Reserved As Long
End Type

Public Const API_FALSE As Long = 0&
Public Const API_TRUE As Long = 1&
Public Const GW_HWNDNEXT As Long = 2&
Public Const GW_CHILD As Long = 5&
'Public Const GWL_STYLE As Long = (-16&)
Public Const RASTERCAPS As Long = 38&
Public Const SIZEPALETTE As Long = 104&
Public Const RC_PALETTE As Long = &H100&
Public Const WS_VSCROLL As Long = &H200000
Public Const WS_HSCROLL As Long = &H100000
Public Const SM_CXVSCROLL As Long = 2&
Public Const SM_CYHSCROLL As Long = 3&
Public Const SRCCOPY As Long = &HCC0020
Public Const SRCPAINT As Long = &HEE0086
Public Const SRCAND As Long = &H8800C6
Public Const NOTSRCCOPY As Long = &H330008








Public Sub PROC_ImagenFondo(ByRef aForm As Form)
    Dim screenSize As Integer ' Tamaño de la pantalla
    
    On Error GoTo ControlError
    
    screenSize = FUNC_Resolucion
    Select Case screenSize
        
        Case 640: '640 x 480
            aForm.Picture = aForm.ILST_ImagenesMDI.ListImages(1).Picture
        Case 720: '720 x 480
            aForm.Picture = aForm.ILST_ImagenesMDI.ListImages(1).Picture
        Case 800: '800 x 600
            aForm.Picture = aForm.ILST_ImagenesMDI.ListImages(1).Picture
        Case 1024: '1024 x 768
            aForm.Picture = aForm.ILST_ImagenesMDI.ListImages(2).Picture
        Case 1152: '1152 x 864
            aForm.Picture = aForm.ILST_ImagenesMDI.ListImages(2).Picture
        Case 1280: '1280 x 1024
            aForm.Picture = aForm.ILST_ImagenesMDI.ListImages(2).Picture

    End Select
    
FinRutina:
    Exit Sub
ControlError:
    Resume FinRutina
End Sub


Public Function FUNC_Resolucion() As Long
    Dim SM_CXSCREEN As Integer
    
    On Error GoTo ControlError
    
    SM_CXSCREEN = 0
    FUNC_Resolucion = GetSystemMetrics(SM_CXSCREEN)
    
FinRutina:
    Exit Function
ControlError:
    Resume FinRutina
End Function


