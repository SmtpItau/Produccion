VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "threed32.ocx"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form BacMntMP 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Monedas por Productos"
   ClientHeight    =   5160
   ClientLeft      =   3690
   ClientTop       =   2970
   ClientWidth     =   5955
   Icon            =   "BacMntMp.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5160
   ScaleWidth      =   5955
   ShowInTaskbar   =   0   'False
   Begin VB.PictureBox SinCheck 
      BorderStyle     =   0  'None
      Height          =   345
      Index           =   0
      Left            =   1050
      Picture         =   "BacMntMp.frx":2EFA
      ScaleHeight     =   345
      ScaleWidth      =   375
      TabIndex        =   9
      Top             =   5580
      Visible         =   0   'False
      Width           =   375
   End
   Begin VB.PictureBox ConCheck 
      BorderStyle     =   0  'None
      Height          =   360
      Index           =   0
      Left            =   1875
      Picture         =   "BacMntMp.frx":3054
      ScaleHeight     =   360
      ScaleWidth      =   405
      TabIndex        =   8
      Top             =   5595
      Visible         =   0   'False
      Width           =   405
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   3
      Top             =   0
      Width           =   5955
      _ExtentX        =   10504
      _ExtentY        =   794
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Style           =   1
      ImageList       =   "Img_opciones"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
      Begin MSComctlLib.ImageList Img_opciones 
         Left            =   4860
         Top             =   -30
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   24
         ImageHeight     =   24
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   12
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntMp.frx":31AE
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntMp.frx":3615
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntMp.frx":3B0B
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntMp.frx":3F9E
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntMp.frx":4486
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntMp.frx":4999
               Key             =   ""
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntMp.frx":4E6C
               Key             =   ""
            EndProperty
            BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntMp.frx":5332
               Key             =   ""
            EndProperty
            BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntMp.frx":5829
               Key             =   ""
            EndProperty
            BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntMp.frx":5C22
               Key             =   ""
            EndProperty
            BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntMp.frx":6018
               Key             =   ""
            EndProperty
            BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntMp.frx":6555
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin Threed.SSFrame Frame 
      Height          =   2055
      Index           =   3
      Left            =   6990
      TabIndex        =   4
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
         TabIndex        =   7
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
         TabIndex        =   6
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
         TabIndex        =   5
         Top             =   1590
         Width           =   1860
      End
   End
   Begin Threed.SSFrame Frame 
      Height          =   1005
      Index           =   0
      Left            =   0
      TabIndex        =   10
      Top             =   450
      Width           =   5955
      _Version        =   65536
      _ExtentX        =   10504
      _ExtentY        =   1773
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
      Begin VB.ComboBox cmbSistema 
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   1200
         Style           =   2  'Dropdown List
         TabIndex        =   0
         Top             =   240
         Width           =   4650
      End
      Begin VB.ComboBox cmbProducto 
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   1200
         Style           =   2  'Dropdown List
         TabIndex        =   1
         Top             =   600
         Width           =   4650
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Sistema"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   210
         Index           =   3
         Left            =   240
         TabIndex        =   12
         Top             =   300
         Width           =   675
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Productos"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   210
         Index           =   2
         Left            =   240
         TabIndex        =   11
         Top             =   645
         Width           =   855
      End
   End
   Begin Threed.SSFrame Frame 
      Height          =   3585
      Index           =   1
      Left            =   0
      TabIndex        =   13
      Top             =   1560
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
         TabIndex        =   2
         Top             =   120
         Width           =   5865
         _ExtentX        =   10345
         _ExtentY        =   6006
         _Version        =   393216
         Cols            =   3
         RowHeightMin    =   280
         BackColor       =   -2147483644
         ForeColor       =   8388608
         BackColorFixed  =   8421376
         ForeColorFixed  =   16777215
         BackColorSel    =   8388608
         ForeColorSel    =   16777215
         BackColorBkg    =   -2147483644
         GridColor       =   0
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
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
   End
   Begin VB.Image ImgChk 
      Height          =   615
      Left            =   0
      Picture         =   "BacMntMp.frx":6A16
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

Dim Sql$, Datos(), i&
Dim OptLocal As String
Private objMoneda   As New clsMoneda
Private objProducto As New clsCodigo
Dim sSistema    As String
Private Function HabilitarControles(Valor As Boolean)

   CmbSistema.Enabled = Not Valor
   CmbProducto.Enabled = Not Valor
   Toolbar1.Buttons(3).Enabled = Not Valor
   'Toolbar1.Buttons(1).Enabled = Valor
   Toolbar1.Buttons(2).Enabled = Valor
   
End Function

Private Sub Limpiar()

  Call ParamGrilla(2, 3, 1, 1, False, grilla) ' leo estuvo aqui

End Sub

Private Sub PROC_BUSCA_DATOS()
Dim codigo As Integer
    
    If CmbProducto.ListIndex < 0 Then
        Exit Sub
    End If
    
    objProducto.codigo = CmbProducto.ItemData(CmbProducto.ListIndex)
    objProducto.glosa = CmbProducto.List(CmbProducto.ListIndex)
        
    grilla.Redraw = False
    Call objMoneda.CargaObjectos(grilla, "", 1)
    
    
    grilla.Redraw = False
    Call objMoneda.CargaxProducto(right(CmbSistema, 3), Trim(right(CmbProducto, 5)), grilla, 1)
    
    grilla.Redraw = False
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
    grilla.Col = 0

    With grilla
        .TopRow = 1
        .LeftCol = 1
        .Row = 1
        .Col = 1
        .Enabled = True
        .SetFocus
    End With

    grilla.ColSel = 2


End Sub

Private Sub cmbProducto_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = 13 Then
       Bac_SendKey (vbKeyTab)
    End If
End Sub

Private Sub cmdEliminar_Click()
   
    objProducto.codigo = CmbProducto.ItemData(CmbProducto.ListIndex)
    objProducto.glosa = CmbProducto.List(CmbProducto.ListIndex)

    If MsgBox("¿Está seguro?", vbExclamation + vbYesNo) <> vbYes Then
        Exit Sub
    End If
        
    For i = 1 To grilla.Rows - 1
        grilla.TextMatrix(i, 1) = " "
    Next i
    
    cmdGrabar_Click

End Sub
Private Sub cmdGrabar_Click()
Dim iError%

    Screen.MousePointer = 11
    
Retry_Save:
    iError = False
    grilla.Row = 0
    For i = 1 To grilla.Rows - 1
        If grilla.TextMatrix(i, 1) = "X" Then
            iError = Not objMoneda.GrabarxProducto(left(CmbSistema, 3), CDbl(grilla.TextMatrix(i, 0)), objProducto.codigo, "1")
        Else
            If Trim$(grilla.TextMatrix(i, 0)) <> "" Then
               iError = Not objMoneda.BorrarxProducto(left(CmbSistema, 3), CDbl(grilla.TextMatrix(i, 0)), objProducto.codigo)
               iError = Not objMoneda.GrabarxProducto(left(CmbSistema, 3), CDbl(grilla.TextMatrix(i, 0)), objProducto.codigo, "0")
            End If
        End If
        If iError Then
            Exit For
        End If
    Next i
    
    If iError Then
        If MsgBox("No se puede continúar Actualizando", vbRetryCancel + vbQuestion) = vbRetry Then
            GoTo Retry_Save
        End If
    Else
        MsgBox "Grabación se realizó con exito", 64
        cmdlimpiar_Click
    End If
        
    Screen.MousePointer = 0

End Sub

Private Sub cmdlimpiar_Click()
   'cmbSistema.Clear
   CmbProducto.Clear
   'Call objProducto.CargaObjetos(cmbSistema, MDTC_SISTEMA)
   CmbSistema.Enabled = (CmbSistema.ListCount > -1)
   CmbSistema.ListIndex = -1
   Call BacLimpiaGrilla(grilla)
      
   Call HabilitarControles(False)
   Call Limpiar
'   Call HabilitarControles(False)
'   Call BacLimpiaGrilla(Grilla)
   Call ParamGrilla(8, 3, 1, 1, False, grilla)
   CmbProducto.SetFocus

End Sub

Private Sub cmdSalir_Click()

   Unload Me

End Sub

Private Sub CmbSistema_Click()

            sSistema = right(CmbSistema.Text, 3)
            
            CmbProducto.Clear
            BacControlWindows 1000

            Envia = Array()
            AddParam Envia, right(CmbSistema.Text, 3)
           
            If BAC_SQL_EXECUTE("SP_BACMNTMP_Producto ", Envia) Then
              
              Do While BAC_SQL_FETCH(Datos())
             
                     If Datos(1) <> "ERROR" Then
                        CmbProducto.AddItem (Datos(2) & Space(150) & Datos(1))
                     End If
              Loop
              CmbProducto.Refresh
              BacControlWindows 10000
              
            Else
              MsgBox "ERROR EN SQL", vbCritical
            End If

End Sub

Private Sub cmbSistema_KeyDown(KeyCode As Integer, Shift As Integer)

    If KeyCode = 13 Then
        Bac_SendKey (vbKeyTab)
    End If
    
End Sub

Private Sub Form_Activate()
   PROC_CARGA_AYUDA Me, " "
  'Call ParamGrilla(8, 3, 1, 1, False, grilla)
End Sub


Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
On Error GoTo err
Dim opcion As Integer

   opcion = 0

   If KeyCode = vbKeyReturn Then
      KeyCode = 0
      Bac_SendKey vbKeyTab
      Exit Sub
   End If

   If KeyCode <> vbKeyControl And (Shift = 2 Or (Shift = 0 And (KeyCode = vbKeyReturn Or KeyCode = vbKeyEscape Or (KeyCode >= vbKeyF1 And KeyCode <= vbKeyF12)))) Then
     
        Select Case KeyCode

           Case vbKeyLimpiar:
                              opcion = 1
   
            Case vbKeyGrabar:
                              opcion = 2
   
            Case vbKeyBuscar:
                              opcion = 3
                              
            Case vbKeySalir:
                              opcion = 4
                      
      End Select

      If opcion <> 0 Then
            If Toolbar1.Buttons(opcion).Enabled Then
               Call Toolbar1_ButtonClick(Toolbar1.Buttons(opcion))
            End If
   
            KeyCode = 0
      End If
    
      
   End If
Exit Sub
err:
  Resume Next

End Sub

Private Sub Form_Load()
   OptLocal = Opt
    Me.top = 0
    Me.left = 0
    Call LogAuditoria("07", OptLocal, Me.Caption, "", "")
  
    Call Limpiar2
    
    sSistema = ""

End Sub

Private Sub Form_Unload(Cancel As Integer)
    Call LogAuditoria("08", OptLocal, Me.Caption, "", "")
End Sub

Private Sub Frame_Click(Index As Integer)
    Bac_SendKey (vbKeyTab)
End Sub

Private Sub Grilla_Click()

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

Private Sub Grilla_KeyPress(KeyAscii As Integer)
   Call Grilla_Click

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
        .Row = 1
        
        .Rows = 1
        
  End With



End Function





Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Index
   Case 3
      Call PROC_BUSCA_DATOS
   
   Case 2
    Dim iError%

    Screen.MousePointer = 11
    
Retry_Save:
    
    iError = False
    grilla.Redraw = False
    grilla.Row = grilla.FixedRows - 1
    
    For i = 1 To grilla.Rows - 1
        
        If Trim(grilla.TextMatrix(i, 1)) = "X" Then
            
              iError = Not objMoneda.GrabarxProducto(right(CmbSistema, 3), Trim(right(CmbProducto, 5)), CDbl(grilla.TextMatrix(i, 0)), "1")
        
        Else
            
            If Trim$(grilla.TextMatrix(i, 0)) <> "" Then
              
               iError = Not objMoneda.BorrarxProducto(right(CmbSistema, 3), CDbl(grilla.TextMatrix(i, 0)), Trim(right(CmbProducto, 5)))
            
            End If
        
        End If
        
        If iError Then
            
            Exit For
        
        End If
    
    Next i
    grilla.ColSel = grilla.Cols - 1
    grilla.Redraw = True
    
    If iError Then
        If MsgBox("No se puede continúar Actualizando", vbRetryCancel + vbQuestion) = vbRetry Then
            Call LogAuditoria("01", OptLocal, Me.Caption + " Error al grabar- Sistema: " & CmbSistema.Text & " Producto: " & CmbProducto.Text, "", "")
            GoTo Retry_Save
        End If
    Else
        MsgBox "Grabación se realizó con exito", 64
        Call LogAuditoria("01", OptLocal, Me.Caption, "", "Sistema: " & CmbSistema.Text & " Producto: " & CmbProducto.Text)
        Call Limpiar2
        CmbSistema.SetFocus
    End If
        
    Screen.MousePointer = 0

Case 5
    objProducto.codigo = CmbProducto.ItemData(CmbProducto.ListIndex)
    objProducto.glosa = CmbProducto.List(CmbProducto.ListIndex)

    If MsgBox("¿Está seguro?", vbExclamation + vbYesNo) <> vbYes Then
        Exit Sub
    End If
        
    For i = 1 To grilla.Rows - 1
        grilla.TextMatrix(i, 1) = " "
        Set grilla.CellPicture = SinCheck(0).Picture
    Next i

    Call LogAuditoria("03", OptLocal, Me.Caption, "Sistema: " & CmbSistema.Text & " Producto: " & CmbProducto.Text, "")

   

Case 1
    grilla.Clear
    Call Limpiar2
    CmbSistema.SetFocus

Case 4
    Unload Me

End Select
    
End Sub


Sub Carga_Options()

Dim i As Integer

   With grilla
   
      For i = 1 To .Rows - 1
         
         .Row = i
         .Col = 1
         
         .CellPictureAlignment = 4
         
         If Trim(.TextMatrix(i, 1)) = "X" Then
   
            .Col = 1
            Set .CellPicture = ConCheck(0).Picture
            .Text = Space(100) + "X"
   
         Else
            
            Set .CellPicture = SinCheck(0).Picture
   
          End If
         
      Next i
   
   End With

End Sub


Sub Limpiar2()
   
   With grilla

        .Row = 0

        .Col = 1
        .CellFontBold = True
        .FixedAlignment(1) = 4
        .Text = "Marca"
        .ColAlignment(1) = 4
        
        .Col = 2
        .CellFontBold = True
        .FixedAlignment(2) = 4
        .Text = "Moneda"
   
        .Rows = 2

   End With
   
   CmbSistema.Clear
   CmbSistema.Enabled = False

   CmbProducto.Clear
   CmbProducto.Enabled = False

   Call CARGAPAR_GRILLA(grilla)

   CmbSistema.Enabled = (CmbSistema.ListCount > -1)

   
      If BAC_SQL_EXECUTE("SP_BACMNTMP_SISTEMA") Then
        
        Do While BAC_SQL_FETCH(Datos())
       
               CmbSistema.AddItem (Datos(2) & Space(150) & Datos(1))
        
        Loop
      
      End If
    
    grilla.Row = 0
    grilla.Col = 0
    grilla.Rows = 1
    grilla.Enabled = False

      
   Call HabilitarControles(False)

   
End Sub
