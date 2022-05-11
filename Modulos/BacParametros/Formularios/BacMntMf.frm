VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form BacMntMF 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Mantenedor de Formas de Pago por Monedas"
   ClientHeight    =   4455
   ClientLeft      =   3120
   ClientTop       =   3480
   ClientWidth     =   6315
   Icon            =   "BacMntMf.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4455
   ScaleWidth      =   6315
   ShowInTaskbar   =   0   'False
   Begin VB.PictureBox ConCheck 
      BorderStyle     =   0  'None
      Height          =   345
      Index           =   0
      Left            =   975
      Picture         =   "BacMntMf.frx":030A
      ScaleHeight     =   345
      ScaleWidth      =   405
      TabIndex        =   12
      Top             =   4515
      Visible         =   0   'False
      Width           =   405
   End
   Begin VB.PictureBox SinCheck 
      BorderStyle     =   0  'None
      Height          =   330
      Index           =   0
      Left            =   150
      Picture         =   "BacMntMf.frx":0464
      ScaleHeight     =   330
      ScaleWidth      =   375
      TabIndex        =   11
      Top             =   4500
      Visible         =   0   'False
      Width           =   375
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   5400
      Top             =   0
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
            Picture         =   "BacMntMf.frx":05BE
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMntMf.frx":0A10
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMntMf.frx":0D2A
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMntMf.frx":117C
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   10
      Top             =   0
      Width           =   6315
      _ExtentX        =   11139
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
            ImageIndex      =   3
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin Threed.SSPanel SSPanel1 
      Height          =   3885
      Left            =   0
      TabIndex        =   3
      Top             =   540
      Width           =   6285
      _Version        =   65536
      _ExtentX        =   11086
      _ExtentY        =   6853
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
      Begin VB.Frame Frame2 
         Height          =   660
         Left            =   60
         TabIndex        =   5
         Top             =   15
         Width           =   6165
         Begin VB.TextBox TxtCodigo 
            Alignment       =   1  'Right Justify
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
            Left            =   915
            MaxLength       =   5
            MouseIcon       =   "BacMntMf.frx":1496
            MousePointer    =   99  'Custom
            TabIndex        =   1
            Top             =   210
            Width           =   855
         End
         Begin VB.Label txtDescrip 
            BackColor       =   &H80000009&
            BorderStyle     =   1  'Fixed Single
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
            Left            =   1860
            TabIndex        =   2
            Top             =   210
            Width           =   4080
         End
         Begin VB.Label Label3 
            Caption         =   "Moneda"
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
            Height          =   255
            Left            =   105
            TabIndex        =   6
            Top             =   240
            Width           =   855
         End
      End
      Begin Threed.SSFrame Frame 
         Height          =   2580
         Index           =   1
         Left            =   45
         TabIndex        =   9
         Top             =   1245
         Width           =   6165
         _Version        =   65536
         _ExtentX        =   10874
         _ExtentY        =   4551
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
            Height          =   2355
            Left            =   75
            TabIndex        =   4
            Top             =   150
            Width           =   6015
            _ExtentX        =   10610
            _ExtentY        =   4154
            _Version        =   393216
            Cols            =   3
            RowHeightMin    =   315
            BackColor       =   -2147483644
            ForeColor       =   8388608
            BackColorFixed  =   8421376
            ForeColorFixed  =   16777215
            BackColorSel    =   8388608
            ForeColorSel    =   16777215
            BackColorBkg    =   -2147483645
            GridColor       =   16777215
            GridColorFixed  =   16777215
            FocusRect       =   0
            GridLines       =   2
            GridLinesFixed  =   0
            ScrollBars      =   2
            SelectionMode   =   1
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
      Begin VB.Frame Frame1 
         Height          =   630
         Left            =   45
         TabIndex        =   7
         Top             =   615
         Width           =   6180
         Begin VB.ComboBox CmbMoneda_Pago 
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
            Left            =   1875
            Style           =   2  'Dropdown List
            TabIndex        =   0
            Top             =   180
            Width           =   4095
         End
         Begin VB.Label Label1 
            Caption         =   "Moneda De Pago"
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
            Height          =   255
            Left            =   105
            TabIndex        =   8
            Top             =   195
            Width           =   2175
         End
      End
   End
End
Attribute VB_Name = "BacMntMF"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim Nada As Integer
Dim I As Integer
Private objProducto As New clsCodigo
Private objMoneda       As New clsMoneda
Private objcoigo        As New clsCodigo
Private objForPago      As New clsForPago
Sub Habilitacontroles(Valor As Boolean)
    
    TxtCodigo.Enabled = Not Valor
    'txtDescrip.Enabled = Not Valor
    txtDescrip.Enabled = True
    CmbMoneda_Pago.Enabled = Valor
    Toolbar1.Buttons(2).Enabled = Valor
    Toolbar1.Buttons(1).Enabled = Valor
    Toolbar1.Buttons(3).Enabled = Valor
    Screen.MousePointer = 0
    
End Sub


Private Sub CmbMoneda_Pago_Click()

    If Not CmbMoneda_Pago.Enabled Then
       Exit Sub
    End If
    
    CmbMoneda_Pago.Tag = CmbMoneda_Pago.ItemData(CmbMoneda_Pago.ListIndex)
 
    objForPago.CargaObjectos grilla, 1
    objForPago.CargaxMoneda CDbl(TxtCodigo.Text), CDbl(CmbMoneda_Pago.Tag), grilla, 1
    grilla.Redraw = False
    grilla.Enabled = True
    grilla.Row = 1
'    grilla.Col = 0
      
End Sub

Private Sub cmdEliminar_Click()
Dim a
a = MsgBox("¿Seguro que desea eliminar todos los campos marcados?", vbQuestion + vbYesNo, TITSISTEMA)
If a = 6 Then
    Dim iError%
    
        Screen.MousePointer = 11
        
        iError = False
        grilla.Row = 0
        For I = 1 To grilla.Rows - 1
             CODI = Len(CmbMoneda_Pago.Text)
             codipag = CDbl(Mid(CmbMoneda_Pago.Text, (CODI - 3), CODI))
             CODI = CDbl(TxtCodigo.Text)
             iError = Not objMoneda.BorrarxProductos(CDbl(grilla.TextMatrix(I, 0)), objProducto.codigo)
             If iError Then
                Exit For
             End If
        Next I
        If iError Then
             a = MsgBox("Error al eliminar", vbInformation, TITSISTEMA)
        Else
            MsgBox "Eliminación se realizó con exito", 64, TITSISTEMA
            cmdlimpiar_Click
        End If
            
        Screen.MousePointer = 0
    
    
    'Call BacLimpiaGrilla(grilla)
    
    'Dim iok     As Integer
    '
    'iok = MsgBox("¿Esta seguro?", vbExclamation + vbYesNo, gsPARAMS_Version)
    '
    '  Select Case iok
    '
    '    Case vbYes:
    '
    '    Screen.MousePointer = 11
    '
    '    If Elimina_FpMoneda(TxtCodigo.Text) = False Then
    '            MsgBox "ERROR : DE ELIMINACION  ", 16, gsPARAMS_Version
    '            Screen.MousePointer = 0
    '            Exit Sub
    '      Else
    '        MsgBox "Eliminación se realizó con exito ", 64, gsPARAMS_Version
    '         grilla.SetFocus
    '
    '    End If
    '
    '   End Select
    '
    '   Screen.MousePointer = 0
Else
    Exit Sub
End If
End Sub

Private Sub cmdGrabar_Click()
'Dim i%
'Dim iError%
'
'    Screen.MousePointer = 11
'
'    iError = False
'
'   For i = 1 To grilla.Rows - 1
'
'    If Trim$(grilla.TextMatrix(i, 1)) <> "" Then
'        iError = Not objForPago.GrabarxMoneda(CDBL(TxtCodigo), CDBL(CmbMoneda_Pago.Tag), grilla.TextMatrix(i, 0), IIf(grilla.TextMatrix(i, 1) = "X", "1", "0"))
'        If iError Then
'            Screen.MousePointer = 0
'            MsgBox "No se puede seguir Actualizando", vbExclamation, gsPARAMS_Version
'            Exit For
'        End If
'    End If
'   Next i
'
'     If Not iError Then
'
'        Screen.MousePointer = 0
'        MsgBox "Grabación fue exitosa", 64, gsPARAMS_Version
'        CmbMoneda_Pago.SetFocus
'
'     End If
'
'    'Graba_FpMoneda(TxtCodigo.Text)  PENDIENTE borrar esta funcion
'
'   Screen.MousePointer = 0
 Dim iError%

    Screen.MousePointer = 11
    
Retry_Save:
    iError = False
    grilla.Row = 0
    For I = 1 To grilla.Rows - 1
        If grilla.TextMatrix(I, 1) = "X" Then
            CODI = Len(CmbMoneda_Pago.Text)
            codipag = CDbl(Mid(CmbMoneda_Pago.Text, (CODI - 3), CODI))
            CODI = CDbl(TxtCodigo.Text)
            iError = Not objMoneda.GrabarxProductos("PCS", CDbl(grilla.TextMatrix(I, 0)), objProducto.codigo, "1")
        Else
            If Trim$(grilla.TextMatrix(I, 0)) <> "" Then
                 CODI = Len(CmbMoneda_Pago.Text)
                 codipag = CDbl(Mid(CmbMoneda_Pago.Text, (CODI - 3), CODI))
                 CODI = CDbl(TxtCodigo.Text)
                iError = Not objMoneda.BorrarxProductos(CDbl(grilla.TextMatrix(I, 0)), objProducto.codigo)
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
   
   Screen.MousePointer = 11
   
    Call Habilitacontroles(False)
    grilla.Enabled = False
    
    objForPago.CargaObjectos grilla, 1
    Call BacLimpiaGrilla(grilla)
    TxtCodigo = ""
    txtDescrip.Caption = ""
    CmbMoneda_Pago.Enabled = False
    CmbMoneda_Pago.ListIndex = -1
    TxtCodigo.SetFocus

  Screen.MousePointer = 0
  
End Sub

Private Sub cmdSalir_Click()

   Unload Me

End Sub

Private Sub Form_Activate()

  'Call ParamGrilla(8, 3, 1, 1, False, grilla)
  
'    If Not objMoneda.CargaObjectos(CmbMoneda_Pago, "PAGADORA") Then
'        MsgBox "No hay Moneda Pagadoras Disponibles, verifique ...", vbInformation, Msj
'        Unload Me
'        Exit Sub
'    End If
 
'    If Not objForPago.CargaObjectos(grilla, 1) Then
'        MsgBox "No hay Formas de Pago Disponibles, verifique ...", vbInformation, Msj
'        Unload Me
'        Exit Sub
'    End If
   
   If Nada = 1 Then
      Me.MousePointer = 0
      Unload Me
   End If
  
  
End Sub

Private Sub Form_Load()
    
    Me.Top = 0
    Me.Left = 0
    mon = 1000
 Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                          , gsbac_fecp _
                          , gsBac_IP _
                          , gsBAC_User _
                          , "PCA" _
                          , "OPC_42" _
                          , "07" _
                          , "INGRESO A OPCION MENU" _
                          , " " _
                          , " " _
                          , " ")
'''''''''''    Call CARGAPAR_GRILLA(grilla)
'''''''''''    Nada = 0
'''''''''''
'''''''''''    If Not objMoneda.CargaObjectos(CmbMoneda_Pago, "PAGADORA") Then
'''''''''''
'''''''''''        MsgBox "No hay Moneda Pagadoras Disponibles, verifique ...", vbInformation, Msj
'''''''''''        Me.MousePointer = 0
'''''''''''        Nada = 1
'''''''''''
'''''''''''        Exit Sub
'''''''''''
'''''''''''    End If
''''''''''''
''''''''''''    If Not objForPago.CargaObjectos(grilla, 1) Then
''''''''''''        MsgBox "No hay Formas de Pago Disponibles, verifique ...", vbInformation, Msj
''''''''''''
''''''''''''       Unload Me
''''''''''''        Exit Sub
''''''''''''    End If
'''''''''''
'''''''''''    Call Habilitacontroles(False)
'''''''''''
'''''''''''    grilla.ColWidth(0) = 0
    
    Call Limpiar2
        
End Sub

Private Sub Form_Unload(Cancel As Integer)

   Me.MousePointer = 0

End Sub

Private Sub grilla_Click()

  With grilla
   
   .CellPictureAlignment = 4

   If .Col = 1 Then
        
        .Col = 2
           
           If Trim$(.Text) <> "" Then
               
               .Col = 1
              
              If Trim(.Text) = "X" Then
                  
                  .Text = ""
                  .Col = 1
                  Set .CellPicture = SinCheck(0).Picture
                  .ColSel = .Cols - 1
              
              Else
                 
                 .Text = Space(100) + "X"
                 .Col = 1
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
                 .Col = 1
                  Set .CellPicture = SinCheck(0).Picture
                 .ColSel = .Cols - 1
              
              Else
                 
                 .Text = Space(100) + "X"
                 .Col = 1
                 Set .CellPicture = ConCheck(0).Picture
                 .ColSel = .Cols - 1
              
              End If
            
            End If
   
   End If
            
 End With
  
End Sub

Private Sub grilla_KeyPress(KeyAscii As Integer)

Call grilla_Click


End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Dim Texto As String
Dim Evento As String

Select Case Button.Index
   Case 1
   
        Dim iError%
        
        Screen.MousePointer = 11
        
Retry_Save:
        iError = False
        'Grilla.Row = 1
        
        
        For I = 1 To grilla.Rows - 1
         
         If Trim(grilla.TextMatrix(I, 1)) = "X" Then
             
             CODI = Len(CmbMoneda_Pago.Text)
             codipag = CDbl(Mid(CmbMoneda_Pago.Text, (CODI - 3), CODI))
             CODI = CDbl(TxtCodigo.Text)
             iError = Not objMoneda.GrabarxProductos("PCS", CDbl(grilla.TextMatrix(I, 0)), objProducto.codigo, "1")
              Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                                     , gsbac_fecp _
                                     , gsBac_IP _
                                     , gsBAC_User _
                                     , "PCA" _
                                     , "OPC_42 " _
                                     , "01" _
                                     , "Producto Grabado." _
                                     , " " _
                                     , " " _
                                     , "GRABADO : " & " " & Mid(CmbMoneda_Pago.Text, 1, 20) & " " & grilla.TextMatrix(I, 2))
             
                     
         Else
             
             If Trim$(grilla.TextMatrix(I, 0)) <> "" Then
                  
                  CODI = Len(CmbMoneda_Pago.Text)
                  codipag = CDbl(Mid(CmbMoneda_Pago.Text, (CODI - 3), CODI))
                  CODI = CDbl(TxtCodigo.Text)
                  iError = Not objMoneda.BorrarxProductos(CDbl(grilla.TextMatrix(I, 0)), objProducto.codigo)
                         
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
        
        End If
         
        Screen.MousePointer = 0

Case 2
        Dim a
        a = MsgBox("¿Seguro que desea eliminar todos los campos marcados?", vbQuestion + vbYesNo, TITSISTEMA)
        
        If a = 6 Then
        'Dim iError%
        
        Screen.MousePointer = 11
        
        iError = False
        grilla.Row = 1
        
        For I = 1 To grilla.Rows - 1
            
            CODI = Len(CmbMoneda_Pago.Text)
            codipag = CDbl(Mid(CmbMoneda_Pago.Text, (CODI - 3), CODI))
            CODI = CDbl(TxtCodigo.Text)
            iError = Not objMoneda.BorrarxProductos(CDbl(grilla.TextMatrix(I, 0)), objProducto.codigo)
            
            If iError Then
               
               Exit For
            
            End If
            If Trim(grilla.TextMatrix(I, 1)) = "X" Then
             Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                                   , gsbac_fecp _
                                   , gsBac_IP _
                                   , gsBAC_User _
                                   , "PCA" _
                                   , "OPC_42 " _
                                   , "03" _
                                   , "Eliminado" _
                                   , " " _
                                   , " " _
                                   , "Eliminado Producto : " & " " & Mid(CmbMoneda_Pago.Text, 1, 20) & " " & grilla.TextMatrix(I, 2))
            End If
        
        Next I
        
        If iError Then
            
            a = MsgBox("Error al eliminar", vbInformation, TITSISTEMA)
        
        Else
           
           MsgBox "Eliminación se realizó con exito", 64, TITSISTEMA
           Call Limpiar2
        
        End If
           
        Screen.MousePointer = 0
        
        
Else
    
    Exit Sub

End If
Case 3
''''''    Screen.MousePointer = 11
''''''
''''''    Call Habilitacontroles(False)
''''''    grilla.Enabled = False
''''''
''''''    objForPago.CargaObjectos grilla, 1
''''''    Call BacLimpiaGrilla(grilla)
''''''    TxtCodigo = ""
''''''    txtDescrip.Caption = ""
''''''    CmbMoneda_Pago.Enabled = False
''''''    CmbMoneda_Pago.ListIndex = -1
''''''    TxtCodigo.SetFocus
''''''
''''''   Screen.MousePointer = 0

   Call Limpiar2

Case 4
  Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                                   , gsbac_fecp _
                                   , gsBac_IP _
                                   , gsBAC_User _
                                   , "PCA" _
                                   , "OPC_42 " _
                                   , "08" _
                                   , "SALIDA DE OPCION" _
                                   , " " _
                                   , " " _
                                   , "")
   Unload Me

End Select
   
End Sub

Private Sub txtCodigo_DblClick()

    BacControlWindows 100

    BacAyuda.Tag = "MDMN_U"
    BacAyuda.Show 1

    If giAceptar% = True Then
       
       'Call mfHabilitaControles(True)
       TxtCodigo.Text = gsCodigo
       txtDescrip.Caption = gsGlosa
'       TxtCodigo.SetFocus
'       SendKeys "{TAB}"
       TxtCodigo_LostFocus
    
    End If
    
    MousePointer = 0
    
End Sub

Private Sub txtCodigo_KeyDown(KeyCode As Integer, Shift As Integer)

If KeyCode = vbKeyF3 Then Call txtCodigo_DblClick

'If KeyCode = 13 Then
'    TxtCodigo_LostFocus
'End If
End Sub

Private Sub txtCodigo_KeyPress(KeyAscii As Integer)
       
    BacSoloNumeros KeyAscii

    If KeyAscii = 13 Then
        If CDbl(TxtCodigo.Text) > 0 Then
           TxtCodigo_LostFocus
            SendKeys "{TAB}"
        End If
    End If
    
End Sub

Private Sub TxtCodigo_LostFocus()
   
   If TxtCodigo.Text <> "" And Len(TxtCodigo.Text) <> "5" Then
   
    If CDbl(TxtCodigo.Text) > 0 Then
       BacControlWindows 100
        
        grilla.Redraw = False
        
        If Not objMoneda.LeerxCodigo(CDbl(TxtCodigo.Text)) Then
            
            MsgBox "No existe Codigo", vbInformation, TITSISTEMA
            Exit Sub
        
        End If
        
        txtDescrip.Caption = objMoneda.mnglosa
        'CmbMoneda_Pago.Clear


        Call objMoneda.CargaObjectos(CmbMoneda_Pago, "PAGADORA", 0)

        

        'CmbMoneda_Pago.AddItem Left(objMoneda.mncodigo & Space(5), 5) & "  " & objMoneda.mnglosa
        'CmbMoneda_Pago.AddItem Left(objMoneda.mncodigo & Space(5), 5) & "  " & objMoneda.mnglosa
        
        CmbMoneda_Pago.AddItem Left(objMoneda.mnglosa & Space(80), 80) & "  " & objMoneda.mncodigo
        CmbMoneda_Pago.ItemData(CmbMoneda_Pago.NewIndex) = objMoneda.mncodigo
        CmbMoneda_Pago.ListIndex = 0
        
        Call Habilitacontroles(True)
        CmbMoneda_Pago_Click

        Call Carga_Options

'        grilla.Col = 0
        
        grilla.Row = 1
        grilla.ColSel = grilla.Cols - 1
         
        grilla.Redraw = True
    
    End If
      
   End If
      
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

Public Function BuscarMoneda(CodMon As String) As Boolean

   Dim sql As String
   Dim Datos()
   
   BuscarMoneda = False
   
    'Sql = giSQL_DatabaseCommon
    Envia = Array()
    AddParam Envia, CodMon
   
        If Not Bac_Sql_Execute("SP_BUSCARCODMONTMMN ", Envia) > 0 Then
           MsgBox "ERROR : Error de Lectura de Datos ", 16, TITSISTEMA
           Exit Function
        End If
       
    
       If Bac_SQL_Fetch(Datos()) Then
               
            BuscarMoneda = True     ' existe
            txtDescrip.Caption = Datos(1)
            Exit Function
       
       Else
           BuscarMoneda = False
       End If
            
            
 End Function

Public Function Llena_Combo_Moneda(OBJCOMBO As Control) As Boolean

   Dim sql As String
   Dim Datos()
   
   Llena_Combo_Moneda = False
   
   OBJCOMBO.Clear
   
    
    'Sql = giSQL_DatabaseCommon
    
    
 
        If Not Bac_Sql_Execute("SP_MONEDA_COMBO ") Then
            Exit Function
        End If


 With OBJCOMBO
 
         Do While Bac_SQL_Fetch(Datos())
            .AddItem UCase(RTrim$(Datos(2)))                    '-Glosa
            .ItemData(.NewIndex) = CDbl(CDbl(Datos(1)))         '-Codigo

        Loop
        
 End With

  Llena_Combo_Moneda = True
   
End Function

Public Function Pasa_Grilla_fp(mfcodmon As String, mfmonpag As String) As Boolean

Dim sql As String
Dim Datos() As Variant
Dim Fila As Long

  Pasa_Grilla_fp = False
 ' Existe = False
  
        
        'Sql = giSQL_DatabaseCommon
        Envia = Array()
        AddParam Envia, CDbl(mfcodmon)
        AddParam Envia, CDbl(mfmonpag)
   
  
                If Not Bac_Sql_Execute("SP_MDMFLEER  ", Envia) Then
                    Exit Function
                End If
            
      Fila = 1
    
With grilla
    
        .Rows = 2
        .Redraw = False
         
        Do While Bac_SQL_Fetch(Datos())
            
             'Existe = True
             .Row = Fila
             .RowHeight(.Row) = 245
             .Enabled = True
             
             .TextMatrix(.Row, 0) = CDbl(Datos(1))                ' codfor
             .TextMatrix(.Row, 1) = IIf(Datos(3) = "1", "X", " ") 'Estado
             .TextMatrix(.Row, 2) = UCase(Datos(2))               'Glosa
               
        .Rows = .Rows + 1
         Fila = Fila + 1
        .Row = Fila
     
   Loop

    .Redraw = True
    
    
End With
      
    
      'Call BacAgrandaGrilla(Grilla, 40)
      Pasa_Grilla_fp = True
          
End Function

Public Function CARGAPAR_GRILLA(Grillas As Object)

  With Grillas

        .Enabled = True
        .FixedCols = 1
        .FixedRows = 1
        .RowHeight(0) = 320
        .CellFontWidth = 3         ' TAMAÑO
        
        .ColWidth(0) = 75
        .ColWidth(1) = 1500
        .ColWidth(2) = 4300
        
        .Rows = 2
        .Row = 0

        .Col = 1
        .FixedAlignment(1) = 4
        .CellFontBold = True       'RESALSE
        .Text = "Marca"
        .ColAlignment(1) = 4
        
        .Col = 2
        .FixedAlignment(2) = 4
        .CellFontBold = True       'RESALSE
        .Text = "Descripción "
        
        .Row = 1
        .Col = 1
        
  End With

End Function

Public Function Graba_FpMoneda(codigo As String) As Boolean

Dim Datos()
Dim sql As String
Dim Fila As Integer
Dim Fecha As String
Dim Monpag As Long
Dim Estado As String

   Graba_FpMoneda = True
                  
With grilla
         
    For Fila = 1 To grilla.Rows - 1
        If Not objForPago.GrabarxMoneda(CDbl(TxtCodigo), CDbl(CmbMoneda_Pago.Tag), grilla.TextMatrix(Fila, 0), grilla.TextMatrix(Fila, 1)) Then
            MsgBox "No se puede seguir Actualizar", vbExclamation, TITSISTEMA
            Exit For
        End If
     Next Fila
     
  End With
    
        Graba_FpMoneda = True


End Function

Public Function Elimina_FpMoneda(CodMon As String) As Boolean

Dim Datos()
Dim sql As String
Dim Fila As Integer
Dim Fecha As String
Dim Monpag As Long
Dim Estado As String

   Elimina_FpMoneda = True
                  
With grilla
         
    For Fila = 1 To .Rows - 1
              
        .Row = Fila
       
         If Trim(.TextMatrix(.Row, 0)) = "" Then
            Else
        
      
      'Sql = giSQL_DatabaseCommon
      AddParam Envia, Sistema
      AddParam Envia, CDbl(CodMon)
        
      If CmbMoneda_Pago.ListIndex = -1 Then
            Monpag = 0
      Else
            Monpag = CmbMoneda_Pago.ItemData(CmbMoneda_Pago.ListIndex)
      End If
    
      AddParam Envia, Monpag
      AddParam Envia, CDbl(.TextMatrix(.Row, 0)) 'CODFOR
               
                If Not Bac_Sql_Execute("SP_BORRAR_FORMAPAGOMONEDA ", Envia) Then
                    Elimina_FpMoneda = False
                    Exit Function
                End If
         
         End If
         
     Next Fila
       
    Elimina_FpMoneda = True
    
    If Elimina_FpMoneda Then
        For Fila = 1 To .Rows - 1
            .Row = Fila
            If Trim(.TextMatrix(.Row, 0)) = "" Then
                Else
            If .TextMatrix(.Row, 1) = "X" Then .TextMatrix(.Row, 1) = " "
            End If
        Next Fila
    End If
  
 End With

End Function


Sub Carga_Options()

Dim I As Integer

   With grilla
   
      .Redraw = False
         
      .Enabled = True
   
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
   
      If .TextMatrix(.Rows - 1, 2) = "" Then
      
         .Rows = .Rows - 1
      
      End If
   
      .Redraw = True
   
   End With
   
   
End Sub

Sub Limpiar2()

   grilla.Clear

    mon = 1000
 
    Call CARGAPAR_GRILLA(grilla)
    Nada = 0
    
    If Not objMoneda.CargaObjectos(CmbMoneda_Pago, "PAGADORA") Then
        
        MsgBox "No hay Moneda Pagadoras Disponibles, verifique ...", vbInformation, TITSISTEMA
        Me.MousePointer = 0
        Nada = 1
        
        Exit Sub
    
    End If
    
    TxtCodigo.Text = ""
    txtDescrip.Caption = ""
    
    Call Habilitacontroles(False)
    
    grilla.ColWidth(0) = 0

    grilla.Enabled = False
   
End Sub

