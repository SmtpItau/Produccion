VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form BacMntMP 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Monedas por Productos"
   ClientHeight    =   5175
   ClientLeft      =   2925
   ClientTop       =   2370
   ClientWidth     =   6105
   Icon            =   "BacMntMp.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5175
   ScaleWidth      =   6105
   ShowInTaskbar   =   0   'False
   Begin VB.PictureBox SinCheck 
      BorderStyle     =   0  'None
      Height          =   345
      Index           =   0
      Left            =   1050
      Picture         =   "BacMntMp.frx":030A
      ScaleHeight     =   345
      ScaleWidth      =   375
      TabIndex        =   14
      Top             =   5580
      Visible         =   0   'False
      Width           =   375
   End
   Begin VB.PictureBox ConCheck 
      BorderStyle     =   0  'None
      Height          =   360
      Index           =   0
      Left            =   1875
      Picture         =   "BacMntMp.frx":0464
      ScaleHeight     =   360
      ScaleWidth      =   405
      TabIndex        =   13
      Top             =   5595
      Visible         =   0   'False
      Width           =   405
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   4770
      Top             =   90
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   4
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMntMp.frx":05BE
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMntMp.frx":0A10
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMntMp.frx":0E62
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMntMp.frx":117C
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   12
      Top             =   0
      Width           =   6105
      _ExtentX        =   10769
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Eliminar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   4
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin Threed.SSPanel SSPanel1 
      Height          =   4755
      Left            =   0
      TabIndex        =   7
      Top             =   540
      Width           =   6075
      _Version        =   65536
      _ExtentX        =   10716
      _ExtentY        =   8387
      _StockProps     =   15
      BackColor       =   -2147483644
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin Threed.SSFrame Frame 
         Height          =   1125
         Index           =   0
         Left            =   60
         TabIndex        =   8
         Top             =   15
         Width           =   5955
         _Version        =   65536
         _ExtentX        =   10504
         _ExtentY        =   1984
         _StockProps     =   14
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Begin VB.ComboBox cmbProducto 
            Enabled         =   0   'False
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   315
            Left            =   1200
            Style           =   2  'Dropdown List
            TabIndex        =   2
            Top             =   660
            Width           =   4650
         End
         Begin VB.ComboBox cmbSistema 
            Enabled         =   0   'False
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   315
            Left            =   1200
            Style           =   2  'Dropdown List
            TabIndex        =   1
            Top             =   240
            Width           =   4650
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            Caption         =   "Productos"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   195
            Index           =   2
            Left            =   240
            TabIndex        =   10
            Top             =   720
            Width           =   870
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            Caption         =   "Sistema"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   195
            Index           =   3
            Left            =   240
            TabIndex        =   9
            Top             =   240
            Width           =   675
         End
      End
      Begin Threed.SSFrame Frame 
         Height          =   3585
         Index           =   1
         Left            =   75
         TabIndex        =   11
         Top             =   1080
         Width           =   5955
         _Version        =   65536
         _ExtentX        =   10504
         _ExtentY        =   6324
         _StockProps     =   14
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Begin MSFlexGridLib.MSFlexGrid grilla 
            Height          =   3405
            Left            =   45
            TabIndex        =   3
            Top             =   120
            Width           =   5865
            _ExtentX        =   10345
            _ExtentY        =   6006
            _Version        =   393216
            Cols            =   3
            RowHeightMin    =   315
            BackColor       =   -2147483644
            ForeColor       =   8388608
            BackColorFixed  =   8421376
            ForeColorFixed  =   16777215
            BackColorSel    =   8388608
            ForeColorSel    =   16777215
            BackColorBkg    =   -2147483644
            GridColor       =   16777215
            GridColorFixed  =   16777215
            WordWrap        =   -1  'True
            AllowBigSelection=   0   'False
            FocusRect       =   0
            FillStyle       =   1
            GridLines       =   2
            GridLinesFixed  =   0
            ScrollBars      =   2
            SelectionMode   =   1
            AllowUserResizing=   2
            PictureType     =   1
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
         End
      End
   End
   Begin Threed.SSFrame Frame 
      Height          =   2055
      Index           =   3
      Left            =   6990
      TabIndex        =   0
      Top             =   930
      Visible         =   0   'False
      Width           =   2715
      _Version        =   65536
      _ExtentX        =   4789
      _ExtentY        =   3625
      _StockProps     =   14
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ShadowStyle     =   1
      Begin VB.PictureBox Grid1 
         BackColor       =   &H00FFFFFF&
         Height          =   780
         Left            =   255
         ScaleHeight     =   720
         ScaleWidth      =   2100
         TabIndex        =   6
         Top             =   300
         Width           =   2160
      End
      Begin VB.Label Label 
         BackColor       =   &H00800000&
         Caption         =   "Label(0)"
         ForeColor       =   &H00FFFFFF&
         Height          =   285
         Index           =   0
         Left            =   255
         TabIndex        =   5
         Top             =   1245
         Width           =   1860
      End
      Begin VB.Label Label 
         BackColor       =   &H00FFFFFF&
         Caption         =   "Label(1)"
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   1
         Left            =   255
         TabIndex        =   4
         Top             =   1590
         Width           =   1860
      End
   End
   Begin VB.Image ImgChk 
      Height          =   615
      Left            =   0
      Picture         =   "BacMntMp.frx":1496
      Stretch         =   -1  'True
      Top             =   0
      Width           =   630
   End
End
Attribute VB_Name = "BacMntMP"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim sql$, Datos(), I&

Private objMoneda   As New clsMoneda
Private objProducto As New clsCodigo
Private Function HabilitarControles(Valor As Boolean)

   cmbSistema.Enabled = Not Valor
   cmbProducto.Enabled = Not Valor
   Toolbar1.Buttons(1).Enabled = Valor
   Toolbar1.Buttons(2).Enabled = Valor
   Toolbar1.Buttons(3).Enabled = Valor

End Function

Private Sub Limpiar()

  Call ParamGrilla(2, 3, 1, 1, False, grilla) ' leo estuvo aqui

End Sub


Private Sub cmbProducto_Click()
Dim codigo As Integer
    If cmbProducto.ListIndex < 0 Then
        Exit Sub
    End If
    
    objProducto.codigo = cmbProducto.ItemData(cmbProducto.ListIndex)
    objProducto.glosa = cmbProducto.List(cmbProducto.ListIndex)
        
    grilla.Redraw = False
    Call objMoneda.CargaObjectos(grilla, "", 1)
    
    
    'Call objMoneda.CargaxProducto(Right(cmbSistema, 3), objProducto.codigo, grilla, 1)
    Call objMoneda.CargaxProducto(Right(cmbSistema, 3), Trim(Right(cmbProducto, 5)), grilla, 1)
    
    Call Carga_Options
    grilla.Redraw = True
    
    Call HabilitarControles(True)
    'Call BacAgrandaGrilla(Grilla, 40)
    
    grilla.Row = 0
    grilla.Col = 1
    grilla.CellFontBold = True
    grilla.Text = "Marca"
    grilla.Col = 2
    grilla.CellFontBold = True
    grilla.Text = "Moneda"
    grilla.Row = grilla.FixedRows
    SendKeys "{Left}"

    With grilla
        .TopRow = 1
        .LeftCol = 1
        .Row = 1
        .Col = 1
        .Enabled = True
        .SetFocus
    End With
 
End Sub

Private Sub cmbProducto_DblClick()

   cmbProducto_Click

End Sub

Private Sub cmbProducto_GotFocus()
            
      'Call objProducto.CargaObjetos(cmbSistema, MDTC_SISTEMA)
      
      Envia = Array()
      AddParam Envia, Right(cmbSistema.Text, 3)
      cmbProducto.Clear
      
      If Bac_Sql_Execute("SP_BACMNTMP_PRODUCTO ", Envia) Then
        
        Do While Bac_SQL_Fetch(Datos())
       
               If Datos(1) <> "ERROR" Then
                  cmbProducto.AddItem (Datos(2) & Space(150) & Datos(1))
               End If
        Loop
      Else
        MsgBox "ERROR EN SQL", vbCritical, TITSISTEMA
      End If
      
      'Call objProducto.CargaObjetos(cmbProducto, MDTC_SISTEMA)
      
End Sub

Private Sub cmbProducto_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = 13 Then
        If cmbProducto.ListIndex <> -1 Then
            grilla.SetFocus
        End If
    End If
End Sub

Private Sub cmbSistema_Click()

   '-- Deshabilita Productos
    'cmbProducto.Clear
   ' cmbProducto.Enabled = False
   '
   ' If cmbSistema.ListIndex < 0 Then
   '     Exit Sub
   ' End If
   '
    '-- Habilita Productos, si existen
   ' cmbProducto.Enabled = True
   '
   ' Select Case cmbSistema.ItemData(cmbSistema.ListIndex)
   ' Case 2  '-- FORWARD
   '     Call objProducto.CargaObjetos(cmbProducto, MDTC_PRODUCTOFWD)
   '
   ' Case 1  '-- SWAP
   '     Call objProducto.CargaObjetos(cmbProducto, MDTC_PRODUCTOSWP)
   '
   ' Case Else
   '     '-- Deshabilita Productos, no existen para sistema solicitado (MDTC = 49)
   '     cmbProducto.Enabled = False
   '     MsgBox "Sistema no tiene definido productos para asignar Monedas", vbInformation
    
   ' End Select
   



End Sub

Private Sub cmdEliminar_Click()
   
    objProducto.codigo = cmbProducto.ItemData(cmbProducto.ListIndex)
    objProducto.glosa = cmbProducto.List(cmbProducto.ListIndex)

    If MsgBox("¿Está seguro?", vbExclamation + vbYesNo, TITSISTEMA) <> vbYes Then
        Exit Sub
    End If
        
    For I = 1 To grilla.Rows - 1
        grilla.TextMatrix(I, 1) = " "
    Next I
    
    cmdGrabar_Click

End Sub
Private Sub cmdGrabar_Click()
Dim iError%

    Screen.MousePointer = 11
    
Retry_Save:
    iError = False
    grilla.Row = 0
    For I = 1 To grilla.Rows - 1
        If grilla.TextMatrix(I, 1) = "X" Then
            iError = Not objMoneda.GrabarxProducto(Left(cmbSistema, 3), CDbl(grilla.TextMatrix(I, 0)), objProducto.codigo, "1")
        Else
            If Trim$(grilla.TextMatrix(I, 0)) <> "" Then
               iError = Not objMoneda.BorrarxProducto(Left(cmbSistema, 3), CDbl(grilla.TextMatrix(I, 0)), objProducto.codigo)
               iError = Not objMoneda.GrabarxProducto(Left(cmbSistema, 3), CDbl(grilla.TextMatrix(I, 0)), objProducto.codigo, "0")
            End If
        End If
        If iError Then
            Exit For
        End If
    Next I
    
    If iError Then
        If MsgBox("No se puede continúar Actualizando", vbRetryCancel + vbQuestion, TITSISTEMA) = vbRetry Then
            GoTo Retry_Save
        End If
    Else
        MsgBox "Grabación se realizó con exito", 64, TITSISTEMA
        cmdlimpiar_Click
    End If
        
    Screen.MousePointer = 0

End Sub

Private Sub cmdlimpiar_Click()
   'cmbSistema.Clear
   cmbProducto.Clear
   'Call objProducto.CargaObjetos(cmbSistema, MDTC_SISTEMA)
   cmbSistema.Enabled = (cmbSistema.ListCount > -1)
   cmbSistema.ListIndex = -1
   Call BacLimpiaGrilla(grilla)
      
   Call HabilitarControles(False)
   Call Limpiar
'   Call HabilitarControles(False)
'   Call BacLimpiaGrilla(Grilla)
   Call ParamGrilla(8, 3, 1, 1, False, grilla)
   cmbProducto.SetFocus

End Sub

Private Sub cmdSalir_Click()

   Unload Me

End Sub

Private Sub cmbSistema_KeyDown(KeyCode As Integer, Shift As Integer)

    If KeyCode = 13 Then
        If cmbSistema.ListIndex <> -1 Then
            cmbProducto.SetFocus
        End If
    End If
    
End Sub

Private Sub Form_Activate()

  'Call ParamGrilla(8, 3, 1, 1, False, grilla)

End Sub


Private Sub Form_Load()
    Me.Top = 0
    Me.Left = 0
    Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                          , gsbac_fecp _
                          , gsBac_IP _
                          , gsBAC_User _
                          , "PCA" _
                          , "OPC_32" _
                          , "07" _
                          , "INGRESO A OPCION MENU" _
                          , " " _
                          , " " _
                          , " ")
''''''''   cmbSistema.Clear
''''''''   cmbSistema.Enabled = False
''''''''
''''''''   cmbProducto.Clear
''''''''   cmbProducto.Enabled = False
''''''''
''''''''   Call CARGAPAR_GRILLA(grilla)
''''''''
'''''''''   Sql = ""
'''''''''    Sql = "SP_BUSCAR_SISTEMAS"
'''''''''    If MISQL.SQL_Execute(Sql) = 0 Then
'''''''''        Do While MISQL.SQL_Fetch(Datos()) = 0
'''''''''            cmbSistema.AddItem Mid$(Datos(2), 1, 15) & Space(50) & Space(50) & Datos(1)
'''''''''        Loop
'''''''''    Else
'''''''''        MsgBox "No se pudo obtener información del servidor", vbCritical, Me.Caption
'''''''''        Exit Sub
'''''''''    End If
'''''''''    If cmbSistema.ListCount > 0 Then
'''''''''        cmbSistema.ListIndex = 0
'''''''''    End If
'''''''''   Call objProducto.CargaObjetos(cmbSistema, MDTC_SISTEMA)
'''''''''   Call objProducto.CargaObjetos(cmbProducto, MDTC_SISTEMA)
''''''''   cmbSistema.Enabled = (cmbSistema.ListCount > -1)
''''''''
'''''''''   Call BacLimpiaGrilla(grilla)
''''''''
''''''''
''''''''
''''''''      If Bac_Sql_Execute("SP_BACMNTMP_SISTEMA") Then
''''''''
''''''''        Do While Bac_SQL_Fetch(DATOS())
''''''''
''''''''               cmbSistema.AddItem (DATOS(2) & Space(150) & DATOS(1))
''''''''
''''''''        Loop
''''''''
''''''''      End If
''''''''
''''''''    grilla.Row = grilla.FixedRows
''''''''    grilla.Col = 0
''''''''    grilla.CellFontBold = True
''''''''    grilla.TextMatrix(0, 1) = "Marca"
''''''''    grilla.Col = 1
''''''''    grilla.CellFontBold = True
''''''''    grilla.TextMatrix(0, 1) = "Moneda"
''''''''
''''''''
''''''''   Call HabilitarControles(False)

   Call Limpiar2

End Sub





Private Sub grilla_Click()

With grilla

   
   .CellPictureAlignment = 4

   If .Col = 1 Then
        
        .Col = 2
           
           If Trim$(.Text) <> "" Then
              .Col = 1
              
              If Trim(.Text) = "X" Then
                 
                 .Text = " "
                 Set .CellPicture = SinCheck(0).Picture
                 .ColSel = .Cols - 1
                 
              Else
                 
                 .Text = Space(100) + "X"
                 Set .CellPicture = ConCheck(0).Picture
                 .ColSel = .Cols - 1
              
              End If
            
            End If
   
   End If
            
   If .Col = 2 Then
           
           If Trim$(.Text) <> "" Then
               
              .Col = 1
              If Trim(.Text) = "X" Then
                 
                 .Text = " "
                 Set .CellPicture = SinCheck(0).Picture
                 .ColSel = .Cols - 1
              
              Else
                 
                 .Text = Space(100) + "X"
                  Set .CellPicture = ConCheck(0).Picture
                 .ColSel = .Cols - 1
              
              End If
            
            End If
   
   End If
            
 End With
    
End Sub

Public Function ParamGrilla(Rows As Integer, Cols As Integer, Rowsf As Integer, Colsf As Integer, Valor As Boolean, Grillas As Object)

  With Grillas

        .Cols = Cols
        .Rows = Rows
        .FixedCols = Colsf
        .FixedRows = Rowsf
        .Enabled = Valor
        
  End With

End Function

Private Sub grilla_KeyPress(KeyAscii As Integer)
   Call grilla_Click

End Sub

Public Function CARGAPAR_GRILLA(Grillas As Object)

 With Grillas

        .Enabled = True
        .FixedCols = 1
        .FixedRows = 1
        .RowHeight(0) = 320
        
        .ColWidth(0) = 0
        .ColWidth(1) = 1500
        .ColWidth(2) = 4280
        
        '.ScrollBars = 0
        
        .Rows = 2
        
        .Row = 0
        .Col = 0
        .Text = ""
        
        .Col = 1
        .CellFontBold = True
        .CellFontWidth = 3
        .FixedAlignment(1) = 4
        .Text = "Marca"
        .ColAlignment(1) = 4
        
        .Col = 2
        .CellFontBold = True
        .CellFontWidth = 3
        .FixedAlignment(2) = 4
        .Text = "Moneda"
        
        .Col = 1
        .Row = 1
        
        
  End With

End Function





Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Dim Texto As String
Select Case Button.Index
   Case 1
    Dim iError%

    Screen.MousePointer = 11
    
Retry_Save:
    
    iError = False
    grilla.Row = grilla.FixedRows
    
    For I = 1 To grilla.Rows - 1
     
    
        
        If Trim(grilla.TextMatrix(I, 1)) = "X" Then
            
            'iError = Not objMoneda.GrabarxProducto(Right(cmbSistema, 3), CDbl(grilla.TextMatrix(i, 0)), objProducto.codigo, "1")
             Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                                    , gsbac_fecp _
                                    , gsBac_IP _
                                    , gsBAC_User _
                                    , "PCA" _
                                    , "OPC_32 " _
                                    , "01" _
                                    , "Grabación De " & " " & grilla.TextMatrix(I, 2) & " " & "Sistema " & " " & Mid(cmbSistema.Text, 1, 10) & " " & "Producto" & " " & Trim(cmbProducto.Text) _
                                    , "Producto_Moneda " _
                                    , " " _
                                    , " ")
                                    
            iError = Not objMoneda.GrabarxProducto(Right(cmbSistema, 3), Trim(Right(cmbProducto, 5)), CDbl(grilla.TextMatrix(I, 0)), "1")
        
        Else
            
            If Trim$(grilla.TextMatrix(I, 0)) <> "" Then
              
              'iError = Not objMoneda.BorrarxProducto(Right(cmbSistema, 3), CDbl(grilla.TextMatrix(i, 0)), objProducto.codigo)
               iError = Not objMoneda.BorrarxProducto(Right(cmbSistema, 3), CDbl(grilla.TextMatrix(I, 0)), Trim(Right(cmbProducto, 5)))
            
            End If
        
        End If
        
        If iError Then
            
            Exit For
        
        End If
    
    Next I
    
    If iError Then
        If MsgBox("No se puede continúar Actualizando", vbRetryCancel + vbQuestion, TITSISTEMA) = vbRetry Then
           GoTo Retry_Save
        End If
    Else
        MsgBox "Grabación se realizó con exito", 64, TITSISTEMA
        Call Limpiar2
        cmbSistema.SetFocus
    End If
    '******************************************************************************************
   
      
    
    Screen.MousePointer = 0

Case 2
    objProducto.codigo = cmbProducto.ItemData(cmbProducto.ListIndex)
    objProducto.glosa = cmbProducto.List(cmbProducto.ListIndex)

    If MsgBox("¿Está seguro?", vbExclamation + vbYesNo, TITSISTEMA) <> vbYes Then
        Exit Sub
    End If
        
    For I = 1 To grilla.Rows - 1
     Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                                    , gsbac_fecp _
                                    , gsBac_IP _
                                    , gsBAC_User _
                                    , "PCA" _
                                    , "OPC_32 " _
                                    , "03" _
                                    , "Eliminacion de monedas por productos" _
                                    , " " _
                                    , grilla.TextMatrix(I, 2) _
                                    , " ")
    
        
        grilla.TextMatrix(I, 2) = " "
        Set grilla.CellPicture = SinCheck(0).Picture
    
    Next I
    

''    grilla.Row = grilla.FixedRows
''    For i = 1 To grilla.Rows - 1
''        If grilla.TextMatrix(i, 1) = "X" Then
''            'iError = Not objMoneda.GrabarxProducto(Right(cmbSistema, 3), CDBL(grilla.TextMatrix(i, 0)), objProducto.codigo, "1")
''            iError = Not objMoneda.GrabarxProducto(Right(cmbSistema, 3), CDbl(grilla.TextMatrix(i, 0)), Trim(Right(cmbProducto, 5)), "1")
''        Else
''            If Trim$(grilla.TextMatrix(i, 0)) <> "" Then
''              'iError = Not objMoneda.BorrarxProducto(Right(cmbSistema, 3), CDBL(grilla.TextMatrix(i, 0)), objProducto.codigo)
''               iError = Not objMoneda.BorrarxProducto(Right(cmbSistema, 3), CDbl(grilla.TextMatrix(i, 0)), Trim(Right(cmbProducto, 5)))
''            End If
''        End If
''        If iError Then
''            Exit For
''        End If
''    Next i
''
''    grilla.Row = 1
''
    

Case 3
      grilla.Clear
      'Form_Load
      Call Limpiar2
     
'   cmbSistema.Clear
'   cmbProducto.Clear
'   Call objProducto.CargaObjetos(cmbSistema, MDTC_SISTEMA)
'   cmbSistema.Enabled = (cmbSistema.ListCount > -1)
'
'   Call BacLimpiaGrilla(grilla)
'
'   Call HabilitarControles(False)
'   Call Limpiar
'   Call HabilitarControles(False)
'   Call BacLimpiaGrilla(Grilla)
'   Call ParamGrilla(8, 3, 1, 1, False, grilla)
    cmbSistema.SetFocus

Case 4
Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                                    , gsbac_fecp _
                                    , gsBac_IP _
                                    , gsBAC_User _
                                    , "PCA" _
                                    , "OPC_32 " _
                                    , "08" _
                                    , "Salir Opcion De Menu" _
                                    , " " _
                                    , " " _
                                    , " ")
    
    Unload Me

End Select
    
End Sub


Sub Carga_Options()

Dim I As Integer

   With grilla
   
      For I = 1 To .Rows - 1
         
         .Row = I
         
         .CellPictureAlignment = 4
         
         If Trim(.TextMatrix(I, 1)) = "X" Then
   
            .Col = 1
            Set .CellPicture = ConCheck(0).Picture
            .Text = Space(100) + "X"
   
         Else
            
            Set .CellPicture = SinCheck(0).Picture
   
         End If
         
      Next I
   
   End With

End Sub


Sub Limpiar2()

   grilla.Clear

   cmbSistema.Clear
   cmbSistema.Enabled = False

   cmbProducto.Clear
   cmbProducto.Enabled = False

   Call CARGAPAR_GRILLA(grilla)

   cmbSistema.Enabled = (cmbSistema.ListCount > -1)

   
      If Bac_Sql_Execute("SP_BACMNTMP_SISTEMA") Then
        
        Do While Bac_SQL_Fetch(Datos())
       
               cmbSistema.AddItem (Datos(2) & Space(150) & Datos(1))
        
        Loop
      
      End If
    
    grilla.Row = grilla.FixedRows
    grilla.Col = 0
    grilla.CellFontBold = True
    grilla.TextMatrix(0, 1) = "Marca"
    grilla.Col = 1
    grilla.CellFontBold = True
    grilla.TextMatrix(0, 1) = "Moneda"

      
   Call HabilitarControles(False)

   
End Sub
