VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "threed32.ocx"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{989C9190-EDF5-45A8-AB6C-98E6EF0384D7}#1.0#0"; "Bac_Controles_Pas.ocx"
Begin VB.Form BacMnSe2 
   Appearance      =   0  'Flat
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Tabla de Premios"
   ClientHeight    =   4635
   ClientLeft      =   3960
   ClientTop       =   2805
   ClientWidth     =   4095
   ClipControls    =   0   'False
   ControlBox      =   0   'False
   FillColor       =   &H00C0C0C0&
   BeginProperty Font 
      Name            =   "MS Sans Serif"
      Size            =   8.25
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   ForeColor       =   &H00C0C0C0&
   Icon            =   "Bacmnse2.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "fManPre"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4635
   ScaleWidth      =   4095
   ShowInTaskbar   =   0   'False
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   480
      Left            =   0
      TabIndex        =   4
      Top             =   0
      Width           =   4095
      _ExtentX        =   7223
      _ExtentY        =   847
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "Img_opciones"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Generar"
            ImageIndex      =   9
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Cerrar Ventana"
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin Threed.SSPanel SSPanel1 
      Height          =   4110
      Left            =   45
      TabIndex        =   0
      Top             =   540
      Width           =   4065
      _Version        =   65536
      _ExtentX        =   7170
      _ExtentY        =   7250
      _StockProps     =   15
      Caption         =   "SSPanel1"
      BackColor       =   -2147483644
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin VB.TextBox txtSubSerie 
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
         Height          =   285
         Left            =   1260
         TabIndex        =   3
         Top             =   165
         Width           =   1425
      End
      Begin VB.Data Data1 
         Caption         =   "Data1"
         Connect         =   "Access"
         DatabaseName    =   ""
         DefaultCursorType=   0  'DefaultCursor
         DefaultType     =   2  'UseODBC
         Exclusive       =   0   'False
         Height          =   345
         Left            =   135
         Options         =   0
         ReadOnly        =   0   'False
         RecordsetType   =   1  'Dynaset
         RecordSource    =   ""
         Top             =   4380
         Width           =   1140
      End
      Begin BACControles.TXTNumero txtNumerico 
         Height          =   255
         Left            =   1365
         TabIndex        =   1
         Top             =   2130
         Visible         =   0   'False
         Width           =   1215
         _ExtentX        =   2143
         _ExtentY        =   450
         BackColor       =   -2147483634
         ForeColor       =   -2147483635
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BorderStyle     =   0
         Text            =   "0.0000"
         Text            =   "0.0000"
         Min             =   "-99999.9999"
         Max             =   "99999.9999"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
      End
      Begin MSFlexGridLib.MSFlexGrid grilla 
         Height          =   3255
         Left            =   165
         TabIndex        =   2
         Top             =   690
         Width           =   3735
         _ExtentX        =   6588
         _ExtentY        =   5741
         _Version        =   393216
         Cols            =   4
         FixedCols       =   0
         BackColor       =   -2147483644
         ForeColor       =   8388608
         BackColorFixed  =   8421376
         ForeColorFixed  =   16777215
         BackColorBkg    =   12632256
         GridColor       =   255
         FocusRect       =   0
         GridLines       =   2
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
      Begin Threed.SSFrame SSFrame1 
         Height          =   525
         Left            =   75
         TabIndex        =   5
         Top             =   15
         Width           =   3945
         _Version        =   65536
         _ExtentX        =   6959
         _ExtentY        =   926
         _StockProps     =   14
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ShadowStyle     =   1
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            Caption         =   "Sub Serie"
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
            Left            =   150
            TabIndex        =   6
            Top             =   195
            Width           =   795
         End
      End
      Begin Threed.SSFrame SSFrame2 
         Height          =   3540
         Left            =   60
         TabIndex        =   7
         Top             =   495
         Width           =   3945
         _Version        =   65536
         _ExtentX        =   6959
         _ExtentY        =   6244
         _StockProps     =   14
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ShadowStyle     =   1
      End
   End
   Begin MSComctlLib.ImageList Img_opciones 
      Left            =   5250
      Top             =   0
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   24
      ImageHeight     =   24
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   9
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmnse2.frx":2EFA
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmnse2.frx":3361
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmnse2.frx":3857
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmnse2.frx":3CEA
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmnse2.frx":41D2
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmnse2.frx":46E5
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmnse2.frx":4BB8
            Key             =   ""
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmnse2.frx":507E
            Key             =   ""
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmnse2.frx":5575
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "BacMnSe2"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim OptLocal         As String
Dim ParamCodi        As String
Dim ParamSerie       As String
Dim ParamCupones     As String
Dim ParamNumDec      As String
Dim ParamMascara     As String
Dim Existe           As Boolean
Dim Sql              As String
Dim Datos()

Const Prcodigo = 0
Const prserie = 1
Const prcupon = 2     '-N° CUPON
Const prpremio = 3    '-PREMIO

Function GrabarTablaPremios() As Boolean

Dim f%
On Error GoTo ErrGrabarPR

GrabarTablaPremios = False

    If BAC_SQL_EXECUTE("BEGIN TRANSACTION") Then
    End If

With grilla
    
    For f% = 1 To .Rows - 1
                
        .Row = f%
     If Trim$(.TextMatrix(.Row, Prcodigo)) <> "" Then
    
''''         Sql = ""
''''         Sql = "SP_TPGRABAR  " & Chr(10)
''''         Sql = Sql & Val(.TextMatrix(.Row, Prcodigo)) & ","
''''         Sql = Sql & "'" & .TextMatrix(.Row, prserie) & "',"
''''         Sql = Sql & .TextMatrix(.Row, prcupon) & ","
''''         Sql = Sql & F_FomateaValor(.TextMatrix(.Row, prpremio), ",", ".")
''''         Sql = Sql & BacStrTran(Trim$(CStr(Data1.Recordset("prpremio"))), ",", ".")
    
         Envia = Array()
         
         AddParam Envia, CDbl(.TextMatrix(.Row, Prcodigo))
         AddParam Envia, .TextMatrix(.Row, prserie)
         AddParam Envia, .TextMatrix(.Row, prcupon)
         AddParam Envia, CDbl(.TextMatrix(.Row, prpremio))
    
         If BAC_SQL_EXECUTE("SP_TPGRABAR", Envia) Then
              
              If BAC_SQL_FETCH(Datos()) Then
                 
                 If Datos(1) = "NO" Then
                    
                    If BAC_SQL_EXECUTE("ROLLBACK TRANSACTION") Then
                    
                    End If
                
                Exit Function
               
               End If
            
            End If
         
         End If
      
      End If
 
  Next f%
 
End With


    If BAC_SQL_EXECUTE("COMMIT TRANSACTION") Then
    End If

GrabarTablaPremios = True

Exit Function

ErrGrabarPR:
    
    MsgBox "Error : " & err.Description, vbOKOnly + vbCritical
    
    If BAC_SQL_EXECUTE("ROLLBACK TRANSACTION") Then
    
    End If
    
Exit Function
    
''On Error GoTo ErrGrabarPR
''
''GrabarTablaPremios = False
''
''If SQL_Execute("BEGIN TRANSACTION") = 0 Then
''End If
''
''Data1.Refresh
''Do While Not Data1.Recordset.EOF
''
''   Sql = "SP_TPGRABAR  " & Chr(10)
''   Sql = Sql & Data1.Recordset("prcodigo") & ","
''   Sql = Sql & "'" & Data1.Recordset("prserie") & "',"
''   Sql = Sql & Data1.Recordset("prcupon") & ","
''   Sql = Sql & BacStrTran(Trim$(CStr(Data1.Recordset("prpremio"))), ",", ".")
''
''    If SQL_Execute(Sql) = 0 Then
''       If SQL_Fetch(Datos()) = 0 Then
''          If Datos(1) = "NO" Then
''             If SQL_Execute("ROLLBACK TRANSACTION") = 0 Then
''             End If
''             Exit Function
''           End If
''        End If
''    End If
''
''Data1.Recordset.MoveNext
''Loop
''
''
''If SQL_Execute("COMMIT TRANSACTION") = 0 Then
''End If
''GrabarTablaPremios = True
''Exit Function
''
''ErrGrabarPR:
''    MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical
''    If SQL_Execute("ROLLBACK TRANSACTION") = 0 Then
''    End If
''    Exit Function

End Function

Function LlenarVacia(Idcodi As Integer, Idserie As String, IdCupon As Long) As Boolean

On Error GoTo ErrVacia
Dim Filas As Long

LlenarVacia = False
    
    For Filas = 1 To IdCupon
        Data1.Recordset.AddNew
        Data1.Recordset("prcodigo") = Idcodi
        Data1.Recordset("prserie") = Idserie
        Data1.Recordset("prcupon") = Filas
        Data1.Recordset("prpremio") = 0
        Data1.Recordset.Update
    Next Filas
    
LlenarVacia = True
Exit Function

ErrVacia:
    MsgBox "Error : " & err.Description, vbOKOnly + vbCritical
    Exit Function

End Function

Public Function LeerPR(Idcodi As Integer, Idserie As String) As Boolean

On Error GoTo ErrLeer

 LeerPR = False
 Existe = False
    
'''''''''''''''''''''''''''''''''    Sql = ""
'''''''''''''''''''''''''''''''''    Sql = "SP_TPLEER " & Idcodi & ",'" & Idserie & "'"
     
    Envia = Array()
    
    AddParam Envia, CDbl(Idcodi)
    AddParam Envia, Idserie
     
    If Not BAC_SQL_EXECUTE("SP_TPLEER ", Envia) Then
       
       'Call BacAgrandaGrilla(Grilla, 40)
       
       Exit Function
    
    End If
    
 With grilla
    
      .Rows = 2
      Call F_BacLimpiaGrilla(grilla)
    
     Do While BAC_SQL_FETCH(Datos())
        
        .Row = .Rows - 1
        
        .TextMatrix(.Row, Prcodigo) = Val(Datos(1))
        .TextMatrix(.Row, prserie) = Datos(2)
        .TextMatrix(.Row, prcupon) = Val(Datos(3))
        .TextMatrix(.Row, prpremio) = Format(Val(Datos(4)), FDecimal)
        .Rows = .Rows + 1
        Existe = True
     
     Loop
    
 End With
 
    LeerPR = True
    
    'Call BacAgrandaGrilla(Grilla, 40)
    
    Exit Function
    
ErrLeer:
   
   MsgBox "Error : " & err.Description, vbOKOnly + vbCritical
   Exit Function


End Function

Private Sub CmdGenerar_Click()

On Error GoTo Label1

    Screen.MousePointer = 11
  
    If GrabarTablaPremios Then
        MsgBox "La grabación fue éxitosa", vbOKOnly + vbInformation
    Else
        MsgBox "No se completo la grabación", vbOKOnly + vbExclamation
    End If

    Screen.MousePointer = 0
    
    Exit Sub

Label1:
    MousePointer = 0
    MsgBox "Error : " & err.Description, vbOKOnly + vbCritical
    Exit Sub
End Sub

Private Sub cmdOK_Click()
       Unload Me
End Sub

Private Sub Form_Activate()

On Error GoTo Label1

Dim f As Long

   PROC_CARGA_AYUDA Me, " "
   
    MousePointer = 11
    BacControlWindows 60
    Call CargarParam(grilla)
   ' Call BacAgrandaGrilla(Grilla, 40)
    Existe = False
    'Lee los parámetros del form de series y los asigna a variables del form
    If Trim$(Me.Tag) <> "" Then
        ParamCodi = ""
        ParamSerie = ""
        ParamCupones = ""
        ParamNumDec = ""
        ParamMascara = ""
                      
        'campo incodigo de la tabla mdin
        f = InStr(1, Me.Tag, "@", 1)
        ParamCodi = Mid$(Me.Tag, 1, f - 1)
        Me.Tag = Mid$(Me.Tag, f + 1, Len(Me.Tag))
        
        'sub Serie Campo nuevo aun no difinido
        f = InStr(1, Me.Tag, "@", 1)
        ParamSerie = Mid$(Me.Tag, 1, f - 1)
        Me.Tag = Mid$(Me.Tag, f + 1, Len(Me.Tag))
        
        'cupones
        f = InStr(1, Me.Tag, "@", 1)
        ParamCupones = Mid$(Me.Tag, 1, f - 1)
        Me.Tag = Mid$(Me.Tag, f + 1, Len(Me.Tag))
        
        'num decimales
        f = InStr(1, Me.Tag, "@", 1)
        ParamNumDec = Mid$(Me.Tag, 1, f - 1)
        Me.Tag = Mid$(Me.Tag, f + 1, Len(Me.Tag))
             
        'Mascara
        ParamMascara = Mid$(Me.Tag, 1, Len(Me.Tag))

        txtSubSerie.Text = mascarita
        
        If Not LeerPR(Val(ParamCodi), mascarita) Then
          '!!!!!!!!!! If Not LlenarVacia(Val(ParamCodi), ParamSerie, Val(ParamCupones)) Then
          '!!!!!!!!!!    MsgBox "No se puede generar tabla de premios", vbOKOnly + vbExclamation
          '!!!!!!!!!! End If
        End If
        
        If Existe = False Then
           Toolbar1.Buttons(1).Enabled = False
        End If
        
    End If
    MousePointer = 0
    Exit Sub

Label1:
    MousePointer = 0
    MsgBox "Error : " & err.Description, vbOKOnly + vbCritical
    Exit Sub


End Sub


Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
Dim opcion As Integer

If KeyCode = vbKeyReturn And UCase(Me.ActiveControl.Name) <> "TXTNUMERICO" And UCase(Me.ActiveControl.Name) <> "GRILLA" Then
      KeyCode = 0
      Exit Sub
End If



If KeyCode <> vbKeyControl And (Shift = 2 Or (Shift = 0 And (KeyCode = vbKeyReturn Or KeyCode = vbKeyEscape Or (KeyCode >= vbKeyF1 And KeyCode <= vbKeyF12)))) Then

opcion = 0
   Select Case KeyCode

         Case vbKeyCalcular
               opcion = 1
         
         Case vbKeySalir
               opcion = 2
   End Select

   If opcion <> 0 Then
      If Toolbar1.Buttons(opcion).Enabled Then
         Call Toolbar1_ButtonClick(Toolbar1.Buttons(opcion))
      End If

   End If

End If

End Sub


Private Sub Form_Load()
Me.top = 1150
Me.left = 0
On Error GoTo ErrBase
OptLocal = Opt

    Call LogAuditoria("07", OptLocal, Me.Caption, "", "")
  
  Exit Sub
  
ErrBase:
    If err.Number = 3051 Then
       MsgBox "No se pudo conectar a tabla de premios", vbOKOnly + vbExclamation
    Else
       MsgBox "Error : " & err.Description, vbOKOnly + vbCritical
    End If
    Exit Sub

End Sub

Private Sub Form_Unload(Cancel As Integer)
 ''       db.Execute "Delete * from mdpr"
       
        BacMntSe.Enabled = True
        
        Call LogAuditoria("08", OptLocal, Me.Caption, "", "")
End Sub

Private Sub grdPr_KeyPress(KeyAscii As Integer)
    If Chr(KeyAscii) = "." Or Chr(KeyAscii) = "," Then
        KeyAscii = Asc(gsc_PuntoDecim)
    End If
    
        
    KeyAscii = BACValIngNumGrid(KeyAscii)
    
End Sub

Private Sub Grilla_DblClick()
Call Grilla_KeyPress(vbKeyReturn)
End Sub

Private Sub Grilla_KeyPress(KeyAscii As Integer)

On Error GoTo ErrGrabaValores

With grilla
            
    If .Col = prpremio Then
           
        If Trim$(.TextMatrix(.Row, Prcodigo)) <> "" And (KeyAscii = 13 Or KeyAscii = 8 Or IsNumeric(Chr(KeyAscii))) Then
           
           .Enabled = False
           txtNumerico.Visible = True
           txtNumerico.Text = .TextMatrix(.Row, .Col)
            PROC_POSICIONA_TEXTOX grilla, txtNumerico
           If IsNumeric(Chr(KeyAscii)) Then
              txtNumerico.Text = Chr(KeyAscii)
              SendKeys "{RIGHT 1}"
           
           Else
               txtNumerico.Text = CDbl(.TextMatrix(.Row, prpremio))
           End If
            
            txtNumerico.SetFocus
     End If
   
   End If
 
 End With

Exit Sub

ErrGrabaValores:
  
 ' MsgBox "Error : " & Err.descripton, vbOKOnly + vbCritical
   grilla.Enabled = True
   txtNumerico.Visible = False
  Exit Sub
  
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
On Error GoTo Label11

Select Case Button.Index
    Case 1
       
       Screen.MousePointer = 11
       If GrabarTablaPremios Then
           MsgBox "La grabación fue éxitosa", vbOKOnly + vbInformation
       Else
           MsgBox "No se completo la grabación", vbOKOnly + vbExclamation
       End If
       
       Call LogAuditoria("20", OptLocal, Me.Caption, "", "")
       
       Screen.MousePointer = 0
       Exit Sub
    
    
    Case 2
       Unload Me
End Select

Exit Sub
Label11:
      MousePointer = 0
      MsgBox "Error : " & err.Description, vbOKOnly + vbCritical
      Exit Sub

End Sub

Private Sub TXTNumerico_KeyPress(KeyAscii As Integer)

With grilla
 
    Select Case KeyAscii
    
       Case vbKeyReturn
           .TextMatrix(.Row, .Col) = Format(txtNumerico.Text, "#,##0.0000")
           .Enabled = True
           .SetFocus
   
       Case vbKeyEscape
           .Enabled = True
           .SetFocus
    
    End Select
    
End With

End Sub

Public Function CargarParam(Grillas As Object)

With Grillas
    .RowHeight(0) = 340
    .CellFontWidth = 4
    .Row = 0
   
   .ColWidth(0) = 1
   .ColWidth(1) = 1
   
   .Col = 2: .FixedAlignment(2) = 4
   .CellFontBold = True
   .TextMatrix(.Row, 2) = "  N°- Cupon  "
   .ColWidth(2) = TextWidth(.TextMatrix(.Row, 2)) + 300
   .ColAlignment(2) = 8

   .Col = 3: .FixedAlignment(3) = 4
   .CellFontBold = True
   .TextMatrix(.Row, 3) = "       Premio      "
   .ColWidth(3) = TextWidth(.TextMatrix(.Row, 3)) + 600
   .ColAlignment(3) = 8
End With

End Function

Private Sub TXTNumerico_LostFocus()

   txtNumerico.Text = ""
   txtNumerico.Visible = False
   grilla.Enabled = True
   
End Sub

