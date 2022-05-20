VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CLS_Wallpaper"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Private mstrExeName          As String
Private mfrmMDI              As MDIForm
Private mblnRunningIDE       As Boolean
Private mlnghModule          As Long
Private mlngForegroundBmpID  As Long
Private mlngBackgroundBmpID  As Long
Private mlngTransparentColor As Long

Public Enum Tipo_Error
    BT_Tran_Exitosa = 0
    BT_Info_Conexion = 10
    BT_Falla_Conexion = 20
    BT_Data_Incorrecta = 30
    BT_falla_transaccion = 40
End Enum
Private Function fCenterForegroundOnBackground(ByVal hWndTarget As Long, _
        ByVal lngForgroundResID As Long, _
        ByVal lngBackgroundResID As Long, _
        ByVal lngTransparentColor As Long, _
        ByRef stdPicture As stdPicture, _
        ByRef strError As String) As Boolean

Dim hOwnerDC           As Long
Dim hForgroundDC       As Long
Dim hBackgroundDC      As Long
Dim hStretchDC         As Long
Dim hBmpObj            As Long
Dim nClientWidth       As Long
Dim nClientHeight      As Long
Dim hBackgroundBmp     As Long
Dim hPrevBackgroundBmp As Long
Dim hForegroundBmp     As Long
Dim hPrevForegroundBmp As Long
Dim hPrevStretchBmp    As Long
Dim hShrinkDC          As Long
Dim hPrevBitmap        As Long
Dim nShrinkWidth       As Long
Dim nShrinkHeight      As Long
Dim rectStretch        As RECT
Dim rectForeground     As RECT
Dim ptForegroundSize   As POINTL
Dim ptBkgroundSize     As POINTL
Dim Bmp                As BITMAP
    
    
    On Error GoTo ErrorHandler
    fCenterForegroundOnBackground = False
    strError = ""
    
    hOwnerDC = GetDC(hWndTarget)
    hForgroundDC = CreateCompatibleDC(hOwnerDC)
    hBackgroundDC = CreateCompatibleDC(hOwnerDC)
    hStretchDC = CreateCompatibleDC(hOwnerDC)
    Call ReleaseDC(hWndTarget, hOwnerDC)
    Call SaveDC(hForgroundDC)
    Call SaveDC(hBackgroundDC)
    Call SaveDC(hStretchDC)
   
 
    FRM_MDI_PASIVO.ILST_ImagenesMDI.ListImages.Remove 1
    FRM_MDI_PASIVO.ILST_ImagenesMDI.ListImages.Add 1, "", LoadPicture(App.Path & "\wallpaper.jpg")
    hForegroundBmp = FRM_MDI_PASIVO.ILST_ImagenesMDI.ListImages(1).Picture
    
    If GetObjectAPI(hForegroundBmp, Len(Bmp), Bmp) Then
        With ptForegroundSize
            .X = Bmp.bmWidth
            .Y = Bmp.bmHeight
        End With
    Else
        strError = "Unable to retrieve foreground bitmap info."
        GoTo ErrorHandler
    End If

    hPrevForegroundBmp = SelectObject(hForgroundDC, hForegroundBmp)
    
    FRM_MDI_PASIVO.ILST_ImagenesMDI.ListImages.Remove 1
    FRM_MDI_PASIVO.ILST_ImagenesMDI.ListImages.Add 1, "", LoadPicture(App.Path & "\wallpaper.jpg")
    hBackgroundBmp = FRM_MDI_PASIVO.ILST_ImagenesMDI.ListImages(1).Picture

    If GetObjectAPI(hBackgroundBmp, Len(Bmp), Bmp) Then
        With ptBkgroundSize
            .X = Bmp.bmWidth
            .Y = Bmp.bmHeight
        End With
    Else
        strError = "Unable to retrieve background bitmap info."
        GoTo ErrorHandler
    End If
    
    hPrevBackgroundBmp = SelectObject(hBackgroundDC, hBackgroundBmp)
  
       
    Call GetClientRect(hWndTarget, rectStretch)
  

    With rectStretch
        If GetWindowLong(hWndTarget, GWL_STYLE) And WS_VSCROLL Then .right = .right + GetSystemMetrics(SM_CXVSCROLL)
        If GetWindowLong(hWndTarget, GWL_STYLE) And WS_HSCROLL Then .bottom = .bottom + GetSystemMetrics(SM_CYHSCROLL)
        
        nClientWidth = .right
        nClientHeight = .bottom
        
        hPrevStretchBmp = SelectObject(hStretchDC, CreateCompatibleBitmap(hBackgroundDC, .right, .bottom))
    
        Call StretchBlt(hStretchDC, 0&, 0&, .right, .bottom, hBackgroundDC, 0&, 0&, ptBkgroundSize.X, ptBkgroundSize.Y, SRCCOPY)
    
        If (.right < (ptForegroundSize.X + 20)) Or (.bottom < (ptForegroundSize.Y + 20)) Then
            Select Case True
                Case ((ptForegroundSize.X + 20) - .right) > ((ptForegroundSize.Y + 20) - .bottom)
                    nShrinkWidth = .right - 20
                    nShrinkHeight = nShrinkWidth * (ptForegroundSize.Y / ptForegroundSize.X)
                
                Case Else
                    nShrinkHeight = .bottom - 20
                    nShrinkWidth = nShrinkHeight * (ptForegroundSize.X / ptForegroundSize.Y)
            End Select

            hShrinkDC = CreateCompatibleDC(hForgroundDC)
            SaveDC hShrinkDC
            
            hPrevBitmap = SelectObject(hShrinkDC, CreateCompatibleBitmap(hForgroundDC, nShrinkWidth, nShrinkHeight))

            Call StretchBlt(hShrinkDC, 0&, 0&, nShrinkWidth, nShrinkHeight, hForgroundDC, 0&, 0&, ptForegroundSize.X, ptForegroundSize.Y, SRCCOPY)

            With rectForeground
                .right = nShrinkWidth
                .bottom = nShrinkHeight
            End With

            .left = (.right \ 2) - (nShrinkWidth \ 2)
            .right = .left + nShrinkWidth
            .top = (.bottom \ 2) - (nShrinkHeight \ 2)
            .bottom = .top + nShrinkHeight

            pTransparentBlt hStretchDC, rectStretch, hShrinkDC, rectForeground, lngTransparentColor

            Call DeleteObject(SelectObject(hShrinkDC, hPrevBitmap))
            Call RestoreDC(hShrinkDC, (-1&))
            Call DeleteDC(hShrinkDC)
        Else
            With rectForeground
                .right = ptForegroundSize.X
                .bottom = ptForegroundSize.Y
            End With
            
            .left = (.right \ 2) - (ptForegroundSize.X \ 2)
            .right = .left + ptForegroundSize.X
            .top = (.bottom \ 2) - (ptForegroundSize.Y \ 2)
            .bottom = .top + ptForegroundSize.Y
            
            pTransparentBlt hStretchDC, rectStretch, hForgroundDC, rectForeground, lngTransparentColor
        End If
    End With
    
    Set stdPicture = fPictureFromDC(hStretchDC, 0, 0, nClientWidth, nClientHeight)
    
    
    fCenterForegroundOnBackground = True
    GoTo NormalExit
    
ErrorHandler:
    If strError = "" Then strError = Err.Description

NormalExit:
    On Error Resume Next
    Call DeleteObject(SelectObject(hForgroundDC, hPrevForegroundBmp))
    Call RestoreDC(hForgroundDC, (-1&))
    Call DeleteDC(hForgroundDC)
    
    Call DeleteObject(SelectObject(hBackgroundDC, hPrevBackgroundBmp))
    Call RestoreDC(hBackgroundDC, (-1&))
    Call DeleteDC(hBackgroundDC)
    
    Call DeleteObject(SelectObject(hStretchDC, hPrevStretchBmp))
    Call RestoreDC(hStretchDC, (-1&))
    Call DeleteDC(hStretchDC)
End Function
Public Function fCenterForeground(ByVal hWndTarget As Long, _
        ByVal nForgroundResID As Long, _
        ByVal nTransparentColor As Long, _
        ByRef stdPicture As stdPicture, _
        ByRef strError As String) As Boolean
  
Dim hOwnerDC           As Long
Dim hForgroundDC       As Long
Dim hBackgroundDC      As Long
Dim hStretchDC         As Long
Dim hBmpObj            As Long
Dim nClientWidth       As Long
Dim nClientHeight      As Long
Dim hBackgroundBmp     As Long
Dim hPrevBackgroundBmp As Long
Dim hForegroundBmp     As Long
Dim hPrevForegroundBmp As Long
Dim hPrevStretchBmp    As Long
Dim hShrinkDC          As Long
Dim hPrevBitmap        As Long
Dim nShrinkWidth       As Long
Dim nShrinkHeight      As Long
Dim blnUseBackground   As Boolean
Dim rectStretch        As RECT
Dim rectForeground     As RECT
Dim ptForegroundSize   As POINTL
Dim ptBkgroundSize     As POINTL
Dim Bmp                As BITMAP

    
    On Error GoTo ErrorHandler
    fCenterForeground = False
    strError = ""
    
    
    hOwnerDC = GetDC(hWndTarget)
    hForgroundDC = CreateCompatibleDC(hOwnerDC)
    hBackgroundDC = CreateCompatibleDC(hOwnerDC)
    hStretchDC = CreateCompatibleDC(hOwnerDC)
    Call SaveDC(hForgroundDC)
    Call SaveDC(hBackgroundDC)
    Call SaveDC(hStretchDC)
    
    
    FRM_MDI_PASIVO.ILST_ImagenesMDI.ListImages.Remove 1
    FRM_MDI_PASIVO.ILST_ImagenesMDI.ListImages.Add 1, "", LoadPicture(App.Path & "\wallpaper.jpg")
    hForegroundBmp = FRM_MDI_PASIVO.ILST_ImagenesMDI.ListImages(1).Picture
    
    If GetObjectAPI(hForegroundBmp, Len(Bmp), Bmp) Then
        With ptForegroundSize
            .X = Bmp.bmWidth
            .Y = Bmp.bmHeight
        End With
    Else
        strError = "Unable to retrieve bitmap information."
        GoTo ErrorHandler
    End If
    
    hPrevForegroundBmp = SelectObject(hForgroundDC, hForegroundBmp)
   
    
    Call GetClientRect(hWndTarget, rectStretch)
    
    With rectStretch
        If GetWindowLong(hWndTarget, GWL_STYLE) And WS_VSCROLL Then .right = .right + GetSystemMetrics(SM_CXVSCROLL)
        If GetWindowLong(hWndTarget, GWL_STYLE) And WS_HSCROLL Then .bottom = .bottom + GetSystemMetrics(SM_CYHSCROLL)
        
        nClientWidth = .right
        nClientHeight = .bottom
        
        hPrevBackgroundBmp = SelectObject(hBackgroundDC, CreateCompatibleBitmap(hOwnerDC, .right, .bottom))
    
        Call BitBlt(hBackgroundDC, 0, 0, .right, .bottom, hOwnerDC, .left, .top, SRCCOPY)
        
        Call ReleaseDC(hWndTarget, hOwnerDC)
        
        If (.right < (ptForegroundSize.X + 20)) Or (.bottom < (ptForegroundSize.Y + 20)) Then
            Select Case True
                Case ((ptForegroundSize.X + 20) - .right) > ((ptForegroundSize.Y + 20) - .bottom)
                    nShrinkWidth = .right - 20
                    nShrinkHeight = nShrinkWidth * (ptForegroundSize.Y / ptForegroundSize.X)
                
                Case Else
                    nShrinkHeight = .bottom - 20
                    nShrinkWidth = nShrinkHeight * (ptForegroundSize.X / ptForegroundSize.Y)
            End Select
    
            hShrinkDC = CreateCompatibleDC(hForgroundDC)
            Call SaveDC(hShrinkDC)
            
            hPrevBitmap = SelectObject(hShrinkDC, CreateCompatibleBitmap(hForgroundDC, nShrinkWidth, nShrinkHeight))
            
            Call StretchBlt(hShrinkDC, 0&, 0&, nShrinkWidth, nShrinkHeight, hForgroundDC, 0&, 0&, ptForegroundSize.X, ptForegroundSize.Y, SRCCOPY)
            
            With rectForeground
                .right = nShrinkWidth
                .bottom = nShrinkHeight
            End With
            
            .left = (.right \ 2) - (nShrinkWidth \ 2)
            .right = .left + nShrinkWidth
            .top = (.bottom \ 2) - (nShrinkHeight \ 2)
            .bottom = .top + nShrinkHeight
            
            pTransparentBlt hBackgroundDC, rectStretch, hShrinkDC, rectForeground, nTransparentColor
    
            Call DeleteObject(SelectObject(hShrinkDC, hPrevBitmap))
            Call RestoreDC(hShrinkDC, (-1&))
            Call DeleteDC(hShrinkDC)
        Else
            With rectForeground
                .right = ptForegroundSize.X
                .bottom = ptForegroundSize.Y
            End With
            
            .left = (.right \ 2) - (ptForegroundSize.X \ 2)
            .right = .left + ptForegroundSize.X
            .top = (.bottom \ 2) - (ptForegroundSize.Y \ 2)
            .bottom = .top + ptForegroundSize.Y
            
            pTransparentBlt hBackgroundDC, rectStretch, hForgroundDC, rectForeground, nTransparentColor
        End If
    End With
    
    Set stdPicture = fPictureFromDC(hBackgroundDC, 0, 0, nClientWidth, nClientHeight)

    fCenterForeground = True
    GoTo NormalExit
    
ErrorHandler:
    If strError = "" Then strError = Err.Description

NormalExit:
    On Error Resume Next
    Call DeleteObject(SelectObject(hForgroundDC, hPrevForegroundBmp))
    Call RestoreDC(hForgroundDC, (-1&))
    Call DeleteDC(hForgroundDC)
    
    Call DeleteObject(SelectObject(hBackgroundDC, hPrevBackgroundBmp))
    Call RestoreDC(hBackgroundDC, (-1&))
    Call DeleteDC(hBackgroundDC)
    
    Call DeleteObject(SelectObject(hStretchDC, hPrevStretchBmp))
    Call RestoreDC(hStretchDC, (-1&))
    Call DeleteDC(hStretchDC)
End Function
Private Function fTileForeground(ByVal hWndTarget As Long, _
        ByVal lngForgroundResID As Long, _
        ByVal lngTransparentColor As Long, _
        ByRef stdPicture As stdPicture, _
        ByRef strError As String) As Boolean


Dim hOwnerDC           As Long
Dim hForgroundDC       As Long
Dim hBackgroundDC      As Long
Dim hBmpObj            As Long
Dim nClientWidth       As Long
Dim nClientHeight      As Long
Dim rectStretch        As RECT
Dim hBackgroundBmp     As Long
Dim hPrevBackgroundBmp As Long
Dim hForegroundBmp     As Long
Dim hPrevForegroundBmp As Long
Dim hPrevStretchBmp    As Long
Dim hShrinkDC          As Long
Dim hPrevBitmap        As Long
Dim nShrinkWidth       As Long
Dim nShrinkHeight      As Long
Dim ptForegroundSize   As POINTL
Dim ptBkgroundSize     As POINTL
Dim Bmp                As BITMAP
Dim rectTile           As RECT
Dim rectForeground     As RECT

    On Error GoTo ErrorHandler
    fTileForeground = False
    strError = ""
    
    
    hOwnerDC = GetDC(hWndTarget)
    hForgroundDC = CreateCompatibleDC(hOwnerDC)
    hBackgroundDC = CreateCompatibleDC(hOwnerDC)
    Call SaveDC(hForgroundDC)
    Call SaveDC(hBackgroundDC)
    
    FRM_MDI_PASIVO.ILST_ImagenesMDI.ListImages.Remove 1
    FRM_MDI_PASIVO.ILST_ImagenesMDI.ListImages.Add 1, "", LoadPicture(App.Path & "\wallpaper.jpg")
    hForegroundBmp = FRM_MDI_PASIVO.ILST_ImagenesMDI.ListImages(1).Picture
    
    If GetObjectAPI(hForegroundBmp, Len(Bmp), Bmp) Then
        With ptForegroundSize
        .X = Bmp.bmWidth
        .Y = Bmp.bmHeight
        End With
    Else
        strError = "Unable to retrieve foreground bitmap info."
        GoTo ErrorHandler
    End If
    
    hPrevForegroundBmp = SelectObject(hForgroundDC, hForegroundBmp)
      
    Call GetClientRect(hWndTarget, rectStretch)
  

    With rectStretch
        If GetWindowLong(hWndTarget, GWL_STYLE) And WS_VSCROLL Then .right = .right + GetSystemMetrics(SM_CXVSCROLL)
        If GetWindowLong(hWndTarget, GWL_STYLE) And WS_HSCROLL Then .bottom = .bottom + GetSystemMetrics(SM_CYHSCROLL)
        
        nClientWidth = .right
        nClientHeight = .bottom
        
        Set mfrmMDI.Picture = Nothing
    
        hPrevBackgroundBmp = SelectObject(hBackgroundDC, CreateCompatibleBitmap(hOwnerDC, .right, .bottom))
        
        Call BitBlt(hBackgroundDC, 0, 0, .right, .bottom, hOwnerDC, .left, .top, SRCCOPY)
        Call ReleaseDC(hWndTarget, hOwnerDC)
        
        If (.right < (ptForegroundSize.X + 20)) Or (.bottom < (ptForegroundSize.Y + 20)) Then
            Select Case True
                Case ((ptForegroundSize.X + 20) - .right) > ((ptForegroundSize.Y + 20) - .bottom)
                    nShrinkWidth = .right - 20
                    nShrinkHeight = nShrinkWidth * (ptForegroundSize.Y / ptForegroundSize.X)
                
                Case Else
                    nShrinkHeight = .bottom - 20
                    nShrinkWidth = nShrinkHeight * (ptForegroundSize.X / ptForegroundSize.Y)
            End Select
            
            hShrinkDC = CreateCompatibleDC(hForgroundDC)
            Call SaveDC(hShrinkDC)
            
            hPrevBitmap = SelectObject(hShrinkDC, CreateCompatibleBitmap(hForgroundDC, nShrinkWidth, nShrinkHeight))
            
            Call StretchBlt(hShrinkDC, 0&, 0&, nShrinkWidth, nShrinkHeight, hForgroundDC, 0&, 0&, ptForegroundSize.X, ptForegroundSize.Y, SRCCOPY)
            
            With rectForeground
                .right = nShrinkWidth
                .bottom = nShrinkHeight
            End With
    
            .left = (.right \ 2) - (nShrinkWidth \ 2)
            .right = .left + nShrinkWidth
            .top = (.bottom \ 2) - (nShrinkHeight \ 2)
            .bottom = .top + nShrinkHeight
    
            Call pTransparentBlt(hBackgroundDC, rectStretch, hShrinkDC, rectForeground, lngTransparentColor)
            
            Call DeleteObject(SelectObject(hShrinkDC, hPrevBitmap))
            Call RestoreDC(hShrinkDC, (-1&))
            Call DeleteDC(hShrinkDC)
        Else
            With rectForeground
                .right = ptForegroundSize.X
                .bottom = ptForegroundSize.Y
            End With
        
            pTransparentBlt hBackgroundDC, rectForeground, hForgroundDC, rectForeground, lngTransparentColor
    
            With rectTile
                Do Until .top >= nClientHeight
                    .bottom = .top + ptForegroundSize.Y
                
                    Do Until .left >= nClientWidth
                        .right = .left + ptForegroundSize.X
                        Call BitBlt(hBackgroundDC, .left, .top, .right, .bottom, hBackgroundDC, 0&, 0&, SRCCOPY)
                        .left = .right
                    Loop
                
                .left = 0
                .top = .bottom
                Loop
            End With
        End If
    End With
  
    Set stdPicture = fPictureFromDC(hBackgroundDC, 0, 0, nClientWidth, nClientHeight)

    fTileForeground = True
    GoTo NormalExit
    
ErrorHandler:
    If strError = "" Then strError = Err.Description

NormalExit:
    On Error Resume Next
    Call DeleteObject(SelectObject(hForgroundDC, hPrevForegroundBmp))
    Call RestoreDC(hForgroundDC, (-1&))
    Call DeleteDC(hForgroundDC)
    
    Call DeleteObject(SelectObject(hBackgroundDC, hPrevBackgroundBmp))
    Call RestoreDC(hBackgroundDC, (-1&))
    Call DeleteDC(hBackgroundDC)
End Function
Public Function CreateFormPicture(ByRef frm As MDIForm, _
        ByVal lngAction As Long, _
        ByRef strError As String) As Boolean

Dim lnghClientArea As Long
Dim rc             As RECT
Dim stdPicture     As stdPicture

    On Error GoTo ErrorHandler
    CreateFormPicture = False
    strError = ""


'    If mblnRunningIDE Then
'        mlnghModule = LoadLibrary(mstrExeName)
'    Else
'        mlnghModule = App.hInstance
'    End If
'    If mlnghModule = 0 Then
'        strError = "Unable to find bitmap resources."
'        GoTo ErrorHandler
'    End If

    lnghClientArea = FindWindowEx(frm.hwnd, 0&, "MDIClient", vbNullChar)
    
    Call GetClientRect(lnghClientArea, rc)
    
    Call InvalidateRect(lnghClientArea, rc, API_TRUE)
    
    
    Select Case lngAction
        Case 0
            If Not fStretchToBackground(lnghClientArea, mlngBackgroundBmpID, stdPicture, strError) Then
                GoTo ErrorHandler
            End If
        
        Case 1
            mfrmMDI.Picture = Nothing
            If Not fCenterForeground(lnghClientArea, mlngForegroundBmpID, _
                        mlngTransparentColor, stdPicture, strError) Then
                GoTo ErrorHandler
            End If
        
        Case 2
            If Not fCenterForegroundOnBackground(lnghClientArea, mlngForegroundBmpID, _
                        mlngBackgroundBmpID, mlngTransparentColor, stdPicture, strError) Then
                GoTo ErrorHandler
            End If
        
        Case 3
            If Not fTileForeground(lnghClientArea, mlngForegroundBmpID, _
                        mlngTransparentColor, stdPicture, strError) Then
                GoTo ErrorHandler
            End If
        
        Case 4
            If Not fTileForegroundOnBackground(lnghClientArea, mlngForegroundBmpID, _
                        mlngBackgroundBmpID, mlngTransparentColor, stdPicture, strError) Then
                GoTo ErrorHandler
            End If
    End Select
    
    mfrmMDI.Picture = stdPicture
    
    Call InvalidateRect(lnghClientArea, rc, API_TRUE)

    CreateFormPicture = True
    GoTo NormalExit

ErrorHandler:

NormalExit:
    If mblnRunningIDE Then Call FreeLibrary(mlnghModule)

End Function
Private Function fPictureFromBitmap(ByVal hBmp As Long, ByVal hPal As Long) As stdPicture
Dim IPictureIID As GUID
Dim IPic        As IPicture
Dim tagPic      As PICTDESC_BMP
Dim lpGUID      As Long

    With IPictureIID
        .Data1 = &H7BF80980
        .Data2 = &HBF32
        .Data3 = &H101A
        .Data4(0) = &H8B
        .Data4(1) = &HBB
        .Data4(2) = &H0
        .Data4(3) = &HAA
        .Data4(4) = &H0
        .Data4(5) = &H30
        .Data4(6) = &HC
        .Data4(7) = &HAB
    End With

    With tagPic
        .Size = Len(tagPic)
        .Type = vbPicTypeBitmap
        .hBmp = hBmp
        .hPal = hPal
    End With

    Call OleCreatePictureIndirect(tagPic, IPictureIID, API_TRUE, IPic)

    Set fPictureFromBitmap = IPic
    
End Function
Private Sub pTransparentBlt(hDestDC As Long, lpDestRect As RECT, hSrcDC As Long, lpSrcRect As RECT, ByVal TransColor As Long)
Dim hInvDC         As Long
Dim hMaskDC        As Long
Dim hResultDC      As Long
Dim hInvBmp        As Long
Dim hMaskBmp       As Long
Dim hResultBmp     As Long
Dim hInvPrevBmp    As Long
Dim hMaskPrevBmp   As Long
Dim hDestPrevBmp   As Long
Dim nSrcWidth      As Long
Dim nSrcHeight     As Long
Dim nOriginalColor As Long

    With lpSrcRect
        nSrcWidth = .right - .left
        nSrcHeight = .bottom - .top
    End With
    
    hInvDC = CreateCompatibleDC(hDestDC)
    hMaskDC = CreateCompatibleDC(hDestDC)
    
    hInvBmp = CreateBitmap(nSrcWidth, nSrcHeight, 1, 1, ByVal 0&)
    hMaskBmp = CreateBitmap(nSrcWidth, nSrcHeight, 1, 1, ByVal 0&)
    hInvPrevBmp = SelectObject(hInvDC, hInvBmp)
    hMaskPrevBmp = SelectObject(hMaskDC, hMaskBmp)
    
    hResultDC = CreateCompatibleDC(hDestDC)
    
    hResultBmp = CreateCompatibleBitmap(hDestDC, nSrcWidth, nSrcHeight)
    hDestPrevBmp = SelectObject(hResultDC, hResultBmp)
    
    nOriginalColor = SetBkColor(hSrcDC, TransColor)
    With lpSrcRect
        Call BitBlt(hMaskDC, 0, 0, nSrcWidth, nSrcHeight, hSrcDC, .left, .top, SRCCOPY)
    End With
    TransColor = SetBkColor(hSrcDC, nOriginalColor)
    
    Call BitBlt(hInvDC, 0, 0, nSrcWidth, nSrcHeight, hMaskDC, 0, 0, NOTSRCCOPY)
    
    With lpDestRect
        Call BitBlt(hResultDC, 0, 0, nSrcWidth, nSrcHeight, hDestDC, .left, .top, SRCCOPY)
        
        Call BitBlt(hResultDC, 0, 0, nSrcWidth, nSrcHeight, hMaskDC, 0, 0, SRCAND)
        
        Call BitBlt(hSrcDC, 0, 0, nSrcWidth, nSrcHeight, hInvDC, 0, 0, SRCAND)
        
        Call BitBlt(hResultDC, 0, 0, nSrcWidth, nSrcHeight, hSrcDC, 0, 0, SRCPAINT)
        
        Call BitBlt(hDestDC, .left, .top, nSrcWidth, nSrcHeight, hResultDC, 0, 0, SRCCOPY)
    End With
    
    Call DeleteObject(SelectObject(hMaskDC, hMaskPrevBmp))
    Call DeleteObject(SelectObject(hInvDC, hInvPrevBmp))
    Call DeleteObject(SelectObject(hResultDC, hDestPrevBmp))
    
    Call DeleteDC(hMaskDC)
    Call DeleteDC(hInvDC)
    Call DeleteDC(hResultDC)
End Sub
Private Function fPictureFromDC(ByVal hDCSrc As Long, ByVal nLeft As Long, ByVal nTop As Long, ByVal nWidth As Long, ByVal nHeight As Long) As stdPicture
Dim hDCMemory       As Long
Dim hBmp            As Long
Dim hBmpPrev        As Long
Dim hPal            As Long
Dim hPalPrev        As Long
Dim fHasPalette     As Long
Dim nPaletteEntries As Long
Dim LogPal          As LOGPALETTE256

    hDCMemory = CreateCompatibleDC(hDCSrc)
    hBmp = CreateCompatibleBitmap(hDCSrc, nWidth, nHeight)
    hBmpPrev = SelectObject(hDCMemory, hBmp)

    nPaletteEntries = GetDeviceCaps(hDCSrc, SIZEPALETTE)
    fHasPalette = GetDeviceCaps(hDCSrc, RASTERCAPS) And RC_PALETTE

    If fHasPalette And (nPaletteEntries = 256) Then
        LogPal.palVersion = &H300
        LogPal.palNumEntries = 256
        Call GetSystemPaletteEntries(hDCSrc, 0, 256, LogPal.palPalEntry(0))
        hPal = CreatePalette(LogPal)
        hPalPrev = SelectPalette(hDCMemory, hPal, 0)
        Call RealizePalette(hDCMemory)
    End If

    Call BitBlt(hDCMemory, 0, 0, nWidth, nHeight, hDCSrc, nLeft, nTop, vbSrcCopy)

    hBmp = SelectObject(hDCMemory, hBmpPrev)

    If fHasPalette And (nPaletteEntries = 256) Then
        hPal = SelectPalette(hDCMemory, hPalPrev, 0)
    End If

    Call DeleteDC(hDCMemory)

    Set fPictureFromDC = fPictureFromBitmap(hBmp, hPal)
    
End Function
Private Function fStretchToBackground(ByVal hWndTarget As Long, _
        ByVal nBackgroundResID As Long, _
        ByRef stdPicture As stdPicture, _
        ByRef strError As String) As Boolean

Dim hOwnerDC           As Long
Dim hBackgroundDC      As Long
Dim hStretchDC         As Long
Dim hBackgroundBmp     As Long
Dim hPrevBackgroundBmp As Long
Dim hPrevStretchBmp    As Long
Dim hBmpObj            As Long
Dim ptBkgroundSize     As POINTL
Dim Bmp                As BITMAP
Dim rectStretch        As RECT

    On Error GoTo ErrorHandler
    fStretchToBackground = False
    strError = ""

    hOwnerDC = GetDC(hWndTarget)
    hBackgroundDC = CreateCompatibleDC(hOwnerDC)
    hStretchDC = CreateCompatibleDC(hOwnerDC)
    Call ReleaseDC(hWndTarget, hOwnerDC)
    Call SaveDC(hBackgroundDC)
    Call SaveDC(hStretchDC)
    

    FRM_MDI_PASIVO.ILST_ImagenesMDI.ListImages.Remove 1
    FRM_MDI_PASIVO.ILST_ImagenesMDI.ListImages.Add 1, "", LoadPicture(App.Path & "\wallpaper.jpg")
    hBackgroundBmp = FRM_MDI_PASIVO.ILST_ImagenesMDI.ListImages(1).Picture
    If GetObjectAPI(hBackgroundBmp, Len(Bmp), Bmp) Then
        With ptBkgroundSize
            .X = Bmp.bmWidth
            .Y = Bmp.bmHeight
        End With
    Else
        Call MsgBox("Unable to retrieve bitmap info.", vbExclamation, "Cannot Format Background")
    End If

    hPrevBackgroundBmp = SelectObject(hBackgroundDC, hBackgroundBmp)
    
    Call GetClientRect(hWndTarget, rectStretch)


    With rectStretch
        If GetWindowLong(hWndTarget, GWL_STYLE) And WS_VSCROLL Then .right = .right + GetSystemMetrics(SM_CXVSCROLL)
        If GetWindowLong(hWndTarget, GWL_STYLE) And WS_HSCROLL Then .bottom = .bottom + GetSystemMetrics(SM_CYHSCROLL)
        
        hPrevStretchBmp = SelectObject(hStretchDC, CreateCompatibleBitmap(hBackgroundDC, .right, .bottom))
        
        Call StretchBlt(hStretchDC, 0&, 0&, .right, .bottom, hBackgroundDC, 0&, 0&, ptBkgroundSize.X, ptBkgroundSize.Y, SRCCOPY)
        
        Set stdPicture = fPictureFromDC(hStretchDC, 0, 0, .right, .bottom)
    End With
    
    fStretchToBackground = True
    GoTo NormalExit
    
ErrorHandler:
    If strError = "" Then strError = Err.Description

NormalExit:
    On Error Resume Next
    Call DeleteObject(SelectObject(hBackgroundDC, hPrevBackgroundBmp))
    Call RestoreDC(hBackgroundDC, (-1&))
    Call DeleteDC(hBackgroundDC)
    
    Call DeleteObject(SelectObject(hStretchDC, hPrevStretchBmp))
    Call RestoreDC(hStretchDC, (-1&))
    Call DeleteDC(hStretchDC)
End Function
Private Function fTileForegroundOnBackground(ByVal hWndTarget As Long, _
        ByVal lngForgroundResID As Long, _
        ByVal lngBackgroundResID As Long, _
        ByVal lngTransparentColor As Long, _
        ByRef stdPicture As stdPicture, _
        ByRef strError As String) As Boolean
  
Dim hOwnerDC           As Long
Dim hForgroundDC       As Long
Dim hBackgroundDC      As Long
Dim hStretchDC         As Long
Dim hBmpObj            As Long
Dim nClientWidth       As Long
Dim nClientHeight      As Long
Dim hBackgroundBmp     As Long
Dim hPrevBackgroundBmp As Long
Dim hForegroundBmp     As Long
Dim hPrevForegroundBmp As Long
Dim hPrevStretchBmp    As Long
Dim Bmp                As BITMAP
Dim rectStretch        As RECT
Dim rectForeground     As RECT
Dim rectTile           As RECT
Dim ptForegroundSize   As POINTL
Dim ptBkgroundSize     As POINTL
  
    On Error GoTo ErrorHandler
    fTileForegroundOnBackground = False
    strError = ""
  
    
    hOwnerDC = GetDC(hWndTarget)
    hForgroundDC = CreateCompatibleDC(hOwnerDC)
    hBackgroundDC = CreateCompatibleDC(hOwnerDC)
    hStretchDC = CreateCompatibleDC(hOwnerDC)
    Call ReleaseDC(hWndTarget, hOwnerDC)
    Call SaveDC(hForgroundDC)
    Call SaveDC(hBackgroundDC)
    Call SaveDC(hStretchDC)


    FRM_MDI_PASIVO.ILST_ImagenesMDI.ListImages.Remove 1
    FRM_MDI_PASIVO.ILST_ImagenesMDI.ListImages.Add 1, "", LoadPicture(App.Path & "\wallpaper.jpg")
    hForegroundBmp = FRM_MDI_PASIVO.ILST_ImagenesMDI.ListImages(1).Picture
    If GetObjectAPI(hForegroundBmp, Len(Bmp), Bmp) Then
        With ptForegroundSize
            .X = Bmp.bmWidth
            .Y = Bmp.bmHeight
        End With
    Else
        Call MsgBox("Unable to retrieve foreground bitmap info.", vbExclamation, "Cannot Format Background")
    End If
  
    hPrevForegroundBmp = SelectObject(hForgroundDC, hForegroundBmp)
    
    FRM_MDI_PASIVO.ILST_ImagenesMDI.ListImages.Remove 1
    FRM_MDI_PASIVO.ILST_ImagenesMDI.ListImages.Add 1, "", LoadPicture(App.Path & "\wallpaper.jpg")
    hBackgroundBmp = FRM_MDI_PASIVO.ILST_ImagenesMDI.ListImages(1).Picture
    
    If GetObjectAPI(hBackgroundBmp, Len(Bmp), Bmp) Then
        With ptBkgroundSize
            .X = Bmp.bmWidth
            .Y = Bmp.bmHeight
        End With
    Else
        Call MsgBox("Unable to retrieve background bitmap info.", vbExclamation, "Cannot Format Background")
    End If

    hPrevBackgroundBmp = SelectObject(hBackgroundDC, hBackgroundBmp)
  
        
    Call GetClientRect(hWndTarget, rectStretch)
  

    With rectStretch
        If GetWindowLong(hWndTarget, GWL_STYLE) And WS_VSCROLL Then .right = .right + GetSystemMetrics(SM_CXVSCROLL)
        If GetWindowLong(hWndTarget, GWL_STYLE) And WS_HSCROLL Then .bottom = .bottom + GetSystemMetrics(SM_CYHSCROLL)
        
        nClientWidth = .right
        nClientHeight = .bottom
        
        hPrevStretchBmp = SelectObject(hStretchDC, CreateCompatibleBitmap(hBackgroundDC, .right, .bottom))
        
        Call StretchBlt(hStretchDC, 0&, 0&, .right, .bottom, hBackgroundDC, 0&, 0&, ptBkgroundSize.X, ptBkgroundSize.Y, SRCCOPY)
        
        DeleteObject SelectObject(hBackgroundDC, hPrevBackgroundBmp)
        
        hPrevBackgroundBmp = SelectObject(hBackgroundDC, CreateCompatibleBitmap(hStretchDC, .right, .bottom))

        With rectForeground
            .right = ptForegroundSize.X
            .bottom = ptForegroundSize.Y
        End With
        
        With rectTile
            Do Until .top >= nClientHeight
                .bottom = .top + ptForegroundSize.Y
                
                Do Until .left >= nClientWidth
                    .right = .left + ptForegroundSize.X
                    Call BitBlt(hBackgroundDC, .left, .top, .right, .bottom, hForgroundDC, 0&, 0&, SRCCOPY)
                    .left = .right
                Loop
        
                .left = 0
                .top = .bottom
            Loop
        End With
    End With
    
    Call pTransparentBlt(hStretchDC, rectStretch, hBackgroundDC, rectStretch, lngTransparentColor)
    
    Set stdPicture = fPictureFromDC(hStretchDC, 0, 0, nClientWidth, nClientHeight)
    
    fTileForegroundOnBackground = True
    GoTo NormalExit
    
ErrorHandler:
    If strError = "" Then strError = Err.Description

NormalExit:
    On Error Resume Next
    Call DeleteObject(SelectObject(hForgroundDC, hPrevForegroundBmp))
    Call RestoreDC(hForgroundDC, (-1&))
    Call DeleteDC(hForgroundDC)
    
    Call DeleteObject(SelectObject(hBackgroundDC, hPrevBackgroundBmp))
    Call RestoreDC(hBackgroundDC, (-1&))
    Call DeleteDC(hBackgroundDC)
    
    Call DeleteObject(SelectObject(hStretchDC, hPrevStretchBmp))
    Call RestoreDC(hStretchDC, (-1&))
    Call DeleteDC(hStretchDC)
End Function
Public Property Let MDIForm(ByVal frm As MDIForm)

    Set mfrmMDI = frm

End Property
Public Property Let ExeName(ByVal strValue As String)

    mstrExeName = strValue

End Property

Public Property Let ForegroundBitmapID(ByVal lngValue As Long)

    mlngForegroundBmpID = lngValue

End Property

Public Property Let BackgroundBitmapID(ByVal lngValue As Long)

    mlngBackgroundBmpID = lngValue

End Property


Public Property Let TransparentColor(ByVal lngValue As Long)

    mlngTransparentColor = lngValue

End Property



Public Property Let RunningInIDE(ByVal blnValue As Boolean)

    mblnRunningIDE = blnValue

End Property


