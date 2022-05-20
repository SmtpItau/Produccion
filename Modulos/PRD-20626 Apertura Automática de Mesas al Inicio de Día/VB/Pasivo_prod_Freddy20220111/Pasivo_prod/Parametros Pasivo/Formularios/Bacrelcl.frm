VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "Mscomctl.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "threed32.ocx"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{989C9190-EDF5-45A8-AB6C-98E6EF0384D7}#1.0#0"; "Bac_Controles_Pas.ocx"
Begin VB.Form BacRelacionCliente 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Relación Clientes"
   ClientHeight    =   4380
   ClientLeft      =   2865
   ClientTop       =   2640
   ClientWidth     =   8550
   Icon            =   "Bacrelcl.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4380
   ScaleWidth      =   8550
   ShowInTaskbar   =   0   'False
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   7065
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
            Picture         =   "Bacrelcl.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacrelcl.frx":075E
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacrelcl.frx":0BB2
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacrelcl.frx":0ED6
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   14
      Top             =   0
      Width           =   8550
      _ExtentX        =   15081
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
   End
   Begin Threed.SSPanel SSPanel1 
      Height          =   3840
      Left            =   0
      TabIndex        =   0
      Top             =   540
      Width           =   8565
      _Version        =   65536
      _ExtentX        =   15108
      _ExtentY        =   6773
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
      Begin VB.Frame Frame1 
         Height          =   1245
         Left            =   90
         TabIndex        =   5
         Top             =   525
         Width           =   8370
         Begin VB.TextBox Txtrut2 
            Alignment       =   1  'Right Justify
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   300
            Left            =   1335
            MaxLength       =   9
            MouseIcon       =   "Bacrelcl.frx":11FA
            MousePointer    =   99  'Custom
            MultiLine       =   -1  'True
            TabIndex        =   8
            Top             =   285
            Width           =   1035
         End
         Begin VB.TextBox txtCodigo2 
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   300
            Left            =   2400
            MaxLength       =   3
            TabIndex        =   7
            Top             =   285
            Width           =   405
         End
         Begin BACControles.TXTNumero Txtporc 
            Height          =   285
            Left            =   1320
            TabIndex        =   6
            Top             =   825
            Width           =   1050
            _ExtentX        =   1852
            _ExtentY        =   503
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
            Text            =   "0.0000"
            Text            =   "0.0000"
            Max             =   "100.00"
            CantidadDecimales=   "4"
            Separator       =   -1  'True
         End
         Begin VB.Label Label3 
            AutoSize        =   -1  'True
            Caption         =   "Porcentaje"
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
            Left            =   315
            TabIndex        =   11
            Top             =   840
            Width           =   885
         End
         Begin VB.Label Label2 
            AutoSize        =   -1  'True
            Caption         =   "RUT Cliente"
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
            Left            =   195
            TabIndex        =   10
            Top             =   330
            Width           =   945
         End
         Begin VB.Label lblHijo 
            BackColor       =   &H80000005&
            BorderStyle     =   1  'Fixed Single
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000008&
            Height          =   330
            Left            =   2835
            TabIndex        =   9
            Top             =   270
            Width           =   4875
         End
      End
      Begin VB.TextBox txtrut 
         Alignment       =   1  'Right Justify
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   1425
         MaxLength       =   9
         MouseIcon       =   "Bacrelcl.frx":1504
         MousePointer    =   99  'Custom
         MultiLine       =   -1  'True
         TabIndex        =   4
         Top             =   90
         Width           =   1035
      End
      Begin VB.TextBox txtCodigo1 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   2475
         MaxLength       =   3
         TabIndex        =   3
         Top             =   90
         Width           =   435
      End
      Begin VB.Frame Frame2 
         Height          =   1950
         Left            =   90
         TabIndex        =   1
         Top             =   1770
         Width           =   8400
         Begin MSFlexGridLib.MSFlexGrid Grilla 
            Height          =   1575
            Left            =   120
            TabIndex        =   2
            Top             =   240
            Width           =   8175
            _ExtentX        =   14420
            _ExtentY        =   2778
            _Version        =   393216
            Cols            =   4
            FixedCols       =   0
            BackColor       =   -2147483644
            ForeColor       =   8388608
            BackColorFixed  =   8421376
            ForeColorFixed  =   16777215
            BackColorSel    =   8388608
            ForeColorSel    =   8388608
            BackColorBkg    =   -2147483636
            GridColor       =   255
            GridColorFixed  =   8421504
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
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Cliente Grupo"
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
         Left            =   165
         TabIndex        =   13
         Top             =   120
         Width           =   1140
      End
      Begin VB.Label lblPadre 
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   330
         Left            =   2940
         TabIndex        =   12
         Top             =   90
         Width           =   4890
      End
   End
   Begin VB.Data DataFox 
      Caption         =   "Data1"
      Connect         =   "FoxPro 2.6;"
      DatabaseName    =   ""
      DefaultCursorType=   0  'DefaultCursor
      DefaultType     =   2  'UseODBC
      Exclusive       =   0   'False
      Height          =   345
      Left            =   5445
      Options         =   0
      ReadOnly        =   0   'False
      RecordsetType   =   0  'Table
      RecordSource    =   ""
      Top             =   45
      Visible         =   0   'False
      Width           =   1905
   End
End
Attribute VB_Name = "BacRelacionCliente"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim OptLocal As String
Dim CodigoPadreFox As String
Dim CodigoHijoFox As String
Dim Datos()
Dim Sql As String

Private Sub cmdEliminar_Click()

Dim Sql$

On Error GoTo ErrEli

Screen.MousePointer = 11
    Envia = Array()
    AddParam Envia, CDbl(txtRut.Text)
    AddParam Envia, CDbl(txtCodigo1.Text)
    AddParam Envia, CDbl(Txtrut2.Text)
    AddParam Envia, CDbl(txtCodigo2.Text)
    
          
    If Not BAC_SQL_EXECUTE("sp_clienterela", Envia) Then
        Screen.MousePointer = 0
        MsgBox "Consulta en Bactrader Ha Fallado. Servidor SQL No Responde", vbCritical
        Exit Sub
    End If
       
        
If BAC_SQL_FETCH(Datos()) Then
  If ValidaDatos() Then
   ' If EliminaFoxRel() Then
        If Elimina_Relacion_SQL() Then
            Screen.MousePointer = 0
            MsgBox "Eliminación se realizó correctamente", vbInformation
            Call BuscarHijos
        Else
           Screen.MousePointer = 0
           MsgBox "Eliminación no se realizó correctamente", vbCritical
        End If
   ' Else
     '      MsgBox "Eliminación no se realizó correctamente", vbCritical
   ' End If
  End If
Else
       Screen.MousePointer = 0
       MsgBox "Datos no han sido grabados", vbCritical
End If

        Call Limpiar
        Call F_BacLimpiaGrilla(Grilla)
        'Call BacAgrandaGrilla(Grilla, 40)
        HabilitarControles (False)
        txtRut.SetFocus

ErrEli:

End Sub
Function Elimina_Relacion_SQL() As Boolean
    
Dim Sql$

 Elimina_Relacion_SQL = True
    
    Envia = Array()
    AddParam Envia, txtRut.Text
    AddParam Envia, txtCodigo1.Text
    AddParam Envia, Txtrut2.Text
    AddParam Envia, txtCodigo2.Text
    

     If Not BAC_SQL_EXECUTE("Sp_Elimina_Relacion_Cliente ", Envia) Then
        MsgBox "Grabación de relación no se realizó correctamente", vbCritical
        Elimina_Relacion_SQL = False
        Exit Function
    End If
    
 End Function

Function Graba_Relacion_SQL() As Boolean

Dim Sql As String

Graba_Relacion_SQL = True
    
    Envia = Array()
    AddParam Envia, txtRut.Text
    AddParam Envia, txtCodigo1.Text
    AddParam Envia, Txtrut2.Text
    AddParam Envia, txtCodigo2.Text
    AddParam Envia, Txtporc.Text

    If Not BAC_SQL_EXECUTE("Sp_Graba_Relacion_Cliente ", Envia) Then
        MsgBox "Grabación de relación no se realizó correctamente", vbCritical
        Graba_Relacion_SQL = False
        Exit Function
    End If
 
 
End Function

Private Sub CmdGrabar_Click()
On Error GoTo ErrGrb

Screen.MousePointer = 11
Me.MousePointer = 0


 If ValidaDatos() Then
    ''If GrabaFoxRel() Then
        If Graba_Relacion_SQL() Then
            Screen.MousePointer = 0
            MsgBox "Grabación se realizó correctamente", vbInformation
            Call BuscarHijos
        Else
           Screen.MousePointer = 0
           MsgBox "Grabacion no se realizó correctamente", vbCritical
           Exit Sub
        End If
    ''Else
     ''      MsgBox "Grabacion no se realizó correctamente", vbCritical
     ''      Exit Sub
    ''End If
 End If
 
    Call Limpiar
    Call F_BacLimpiaGrilla(Grilla)
    'Call BacAgrandaGrilla(Grilla, 40)
    HabilitarControles (False)
    Screen.MousePointer = 0
    Me.MousePointer = 0

Exit Sub

ErrGrb:
    
End Sub

Function GrabaFoxRel() As Boolean
GrabaFoxRel = False
On Error GoTo GrabaError

 If Not Buscar_Relacion_Fox(CDbl(CodigoPadreFox)) Then
     DataFox.Recordset.AddNew
Else
     DataFox.Recordset.Edit
End If

Mover_FoxRel
DataFox.Recordset.Update

GrabaFoxRel = True

Exit Function

GrabaError:

MsgBox Error(err), 16

Exit Function

End Function

Sub Mover_FoxRel()
     DataFox.Recordset.Fields!X = ""
     DataFox.Recordset.Fields!Y = ""
     DataFox.Recordset.Fields!hijo = CodigoHijoFox
     DataFox.Recordset.Fields!padre = CodigoPadreFox
     DataFox.Recordset.Fields!porpar = Txtporc.Text
     DataFox.Recordset.Fields!coefic = 0
End Sub

Function EliminaFoxRel() As Boolean
On Error GoTo EliminaError

 If Buscar_Relacion_Fox(CDbl(CodigoPadreFox)) Then
     DataFox.Recordset.Delete
     EliminaFoxRel = True
Else
     EliminaFoxRel = False
End If
DataFox.Refresh

Exit Function
EliminaError:
MsgBox Error(err), 16
Exit Function
End Function

Sub Limpiar()
        txtRut.Text = ""
        Txtrut2.Text = ""
        txtCodigo1.Text = ""
        txtCodigo2.Text = ""
        Txtporc.Text = 0
        lblPadre.Caption = ""
        lblHijo.Caption = ""
        ''Call LimpiaGrid

End Sub


Private Sub cmdlimpiar_Click()

    Call F_BacLimpiaGrilla(Grilla)
    'Call BacAgrandaGrilla(Grilla, 40)
    Call Limpiar
    HabilitarControles (False)
    Me.MousePointer = 0
    Screen.MousePointer = 0
    txtRut.SetFocus
    
End Sub
Private Sub cmdSalir_Click()
Unload Me
End Sub

Private Sub Form_Activate()
   PROC_CARGA_AYUDA Me, " "
   Call CargarParam(Grilla)
   'Call BacAgrandaGrilla(Grilla, 40)
End Sub

Private Sub Form_Load()
    OptLocal = Opt
    Me.top = 0
    Me.left = 0
'On Error GoTo ErrDbf

  ' DataFox.Connect = "FoxPro 2.6"
  ' DataFox.DatabaseName = gsFox_Comun
  ' DataFox.RecordSource = "CLDEUCOM"
  ' DataFox.Refresh
 '  Exit Sub
   
'ErrDbf:
'If Err.Number = 3051 Then
  '    MsgBox "No se pudo conectar a tabla de clientes", vbOKOnly + vbExclamation
  ' Else
  '    MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical
  ' End If
   'Unload Me
   
 '  Exit Sub
 
    Call LogAuditoria("07", OptLocal, Me.Caption, "", "")

End Sub

Private Sub Table1_Fetch(Row As Long, Col As Integer, Value As String)
With Grid1
    .Col = Col
    .Row = Row
    Value = .Text
 End With
End Sub

Private Sub Table1_Click()

End Sub

Private Sub Form_Unload(Cancel As Integer)
    Call LogAuditoria("08", OptLocal, Me.Caption, "", "")
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Index
    Case 1
                On Error GoTo ErrGrb

Screen.MousePointer = 11
Me.MousePointer = 0


 If ValidaDatos() Then
    ''If GrabaFoxRel() Then
        If Graba_Relacion_SQL() Then
            Screen.MousePointer = 0
            MsgBox "Grabación se realizó correctamente", vbInformation
            Call BuscarHijos
        Else
           Screen.MousePointer = 0
           MsgBox "Grabacion no se realizó correctamente", vbCritical
           Exit Sub
        End If
    ''Else
     ''      MsgBox "Grabacion no se realizó correctamente", vbCritical
     ''      Exit Sub
    ''End If
 End If
 
    Call Limpiar
    Call F_BacLimpiaGrilla(Grilla)
    'Call BacAgrandaGrilla(Grilla, 40)
    HabilitarControles (False)
    Screen.MousePointer = 0
    Me.MousePointer = 0

Exit Sub

ErrGrb:
    Case 2
        Dim Sql$
        Dim dd
dd = MsgBox("Seguro de Eliminar", vbQuestion + vbYesNo)
If dd = 6 Then
On Error GoTo ErrEli

Screen.MousePointer = 11
    
    Envia = Array()
    AddParam Envia, CDbl(txtRut.Text)
    AddParam Envia, CDbl(txtCodigo1.Text)
    AddParam Envia, CDbl(Txtrut2.Text)
    AddParam Envia, CDbl(txtCodigo2.Text)
    
    If Not BAC_SQL_EXECUTE("sp_clienterela", Envia) Then
        
        Screen.MousePointer = 0
        MsgBox "Consulta en Bactrader Ha Fallado. Servidor SQL No Responde", vbCritical
        Exit Sub
    
    End If
       
        
If BAC_SQL_FETCH(Datos()) Then
  If ValidaDatos() Then
   ' If EliminaFoxRel() Then
        If Elimina_Relacion_SQL() Then
            Screen.MousePointer = 0
            MsgBox "Eliminación se realizó correctamente", vbInformation
            Call BuscarHijos
        Else
           Screen.MousePointer = 0
           MsgBox "Eliminación no se realizó correctamente", vbCritical
        End If
   ' Else
     '      MsgBox "Eliminación no se realizó correctamente", vbCritical
   ' End If
  End If
Else
       Screen.MousePointer = 0
       MsgBox "Datos no han sido grabados", vbCritical
End If

        Call Limpiar
        Call F_BacLimpiaGrilla(Grilla)
        'Call BacAgrandaGrilla(Grilla, 40)
        HabilitarControles (False)
        txtRut.SetFocus

ErrEli:
End If
    Case 3
            Call F_BacLimpiaGrilla(Grilla)
    'Call BacAgrandaGrilla(Grilla, 40)
    Call Limpiar
    HabilitarControles (False)
    Me.MousePointer = 0
    Screen.MousePointer = 0
    txtRut.SetFocus
    Case 4
        Unload Me
End Select
End Sub

Private Sub txtCodigo1_KeyPress(KeyAscii As Integer)
 If KeyAscii% = vbKeyReturn Then
      KeyAscii% = 0
      SendKeys "{TAB}"

   ElseIf Not ((KeyAscii > 47 And KeyAscii < 58) Or KeyAscii = 8) Then
      KeyAscii = 0
      BacCaracterNumerico KeyAscii
   End If
End Sub

Private Sub txtCodigo1_LostFocus()
   
If CDbl(txtRut.Text) = 0 Or Trim(txtCodigo1.Text) = "" Then Exit Sub
   
   If Trim(txtCodigo1) = "" Or Trim(txtRut) = "" Then
      
      If CDbl(txtCodigo1) = 0 Then
         MsgBox "Error : El código no puede ser 0 ", 16
      Else
         MsgBox "Error : Datos en Blanco ", 16
      End If
      
      Call Limpiar
      Call HabilitarControles(False)
      txtRut.SetFocus
      Exit Sub
 End If

  Screen.MousePointer = 11
   
    Envia = Array()
    AddParam Envia, txtRut.Text
    AddParam Envia, txtCodigo1.Text

    If Not BAC_SQL_EXECUTE("sp_clienterela2", Envia) Then
        Screen.MousePointer = 0
        MsgBox "Consulta en Bactrader Ha Fallado. Servidor SQL No Responde", vbCritical
        Exit Sub
    End If
       
        
    If BAC_SQL_FETCH(Datos()) Then
        lblPadre.Caption = Datos(1)
        HabilitarControles (True)
        Call BuscarHijos
        Txtrut2.SetFocus
    Else
        Screen.MousePointer = 0
        MsgBox "Rut no existe ", vbCritical
        Call Limpiar
        Call HabilitarControles(False)
        txtRut.SetFocus
        Exit Sub
    End If
    
    
    
End Sub

Function BuscarHijos()
    
Dim Sql$
Dim Fila%

 
    '---- Llenar la grilla
    
    Envia = Array()
    AddParam Envia, CDbl(txtRut.Text)
    AddParam Envia, CDbl(txtCodigo1.Text)
    
    
        If Not BAC_SQL_EXECUTE("sp_consulhijos ", Envia) Then
            Exit Function
        End If
        
With Grilla

     .Rows = 2
      Call F_BacLimpiaGrilla(Grilla)
    Do While BAC_SQL_FETCH(Datos())
        
           .Row = .Rows - 1
           .TextMatrix(.Row, 0) = CDbl(Datos(1))
           .TextMatrix(.Row, 1) = CDbl(Datos(2))
           .TextMatrix(.Row, 2) = Trim$(Datos(4))
           .TextMatrix(.Row, 3) = Datos(3)
           .Rows = .Rows + 1
    Loop
    
        .Rows = .Rows - 1

End With
    
'Call BacAgrandaGrilla(Grilla, 40)
Me.MousePointer = 0
Screen.MousePointer = 0



    
    
''    c1 = "0"
''    For i = 1 To Grid1.Cols - 1
''        Table1.ColumnCellAttrs(i) = True
''    Next i
''
''    '---- Llenar la grilla
''    Sql = "sp_consulhijos " & CDBL(txtrut.Text) & "," & CDBL(txtCodigo1.Text)
''    If SQL_Execute(Sql) <> 0 Then
''        Exit Function
''    End If
''    Grid1.Rows = 1
''
''    Do While SQL_Fetch(Datos()) = 0
''        c1 = "1"
''        With Grid1
''           .Rows = .Rows + 1
''           .Row = .Rows - 1
''           .Col = 1: .Text = CDBL(Datos(1))
''           .Col = 2: .Text = CDBL(Datos(2))
''           .Col = 3: .Text = Trim(Datos(4))
''           .Col = 4: .Text = Datos(3)
''        End With
''    Loop
''
''    Table1.Rows = Grid1.Rows - 1
''    Table1.Refresh
End Function

Private Sub txtCodigo2_KeyPress(KeyAscii As Integer)
 If KeyAscii% = vbKeyReturn Then
      KeyAscii% = 0
      SendKeys "{TAB}"

   ElseIf Not ((KeyAscii > 47 And KeyAscii < 58) Or KeyAscii = 8) Then
      KeyAscii = 0
      BacCaracterNumerico KeyAscii
   End If
End Sub

Private Sub txtCodigo2_LostFocus()
   Dim Bandera   As Integer
   Dim i As Long
   
   If CDbl(Txtrut2.Text) = 0 Or Trim(txtCodigo2.Text) = "" Then Exit Sub
   
  Bandera = True
  
  If Trim(txtCodigo2) = "" Or Trim(Txtrut2) = "" Then
      
      If CDbl(txtCodigo2) = 0 Then
         MsgBox "Error : El código no puede ser 0 ", 16
      Else
         MsgBox "Error : Datos en Blanco ", 16
      End If
      Txtrut2.SetFocus
      Exit Sub
 End If
 
 Call Busca_Relacion_Cliente(txtRut.Text, txtCodigo1.Text, Txtrut2.Text, txtCodigo2.Text)
    Me.MousePointer = 0
    Screen.MousePointer = 0
 
End Sub

Function HabilitarControles(Valor As Boolean)
     txtRut.Enabled = Not Valor
     txtCodigo1.Enabled = Not Valor
     Txtrut2.Enabled = Valor
     txtCodigo2.Enabled = Valor
     
     Txtporc.Enabled = Valor
End Function


Private Sub txtRut_DblClick()

MiTag = "MDCL"
BacAyuda.Show 1

If giAceptar% = True Then
    txtRut.Text = CDbl(gsrut$)
    txtCodigo1.Text = CDbl(gsValor$)
    lblPadre.Caption = Trim(gsDescripcion$)
End If
    txtCodigo1_LostFocus
End Sub


Private Sub txtRut_KeyDown(KeyCode As Integer, Shift As Integer)
 If KeyCode = vbKeyF3 Then Call txtRut_DblClick
End Sub

Private Sub txtRut_KeyPress(KeyAscii As Integer)
  If KeyAscii% = vbKeyReturn Then
      KeyAscii% = 0
      SendKeys$ "{TAB}"

   ElseIf Not ((KeyAscii > 47 And KeyAscii < 58) Or KeyAscii = 8) Then
      KeyAscii = 0
     
   End If
     
   BacCaracterNumerico KeyAscii
End Sub

Private Sub Txtrut2_DblClick()

MiTag = "MDCL"
BacAyuda.Show 1

If giAceptar% = True Then
    Txtrut2.Text = CDbl(gsrut$)
    txtCodigo2.Text = CDbl(gsValor$)
    lblHijo.Caption = Trim(gsDescripcion$)
End If
    txtCodigo2_LostFocus
End Sub

Function Buscar_Relacion_Fox(codigo As Double) As Boolean
    DataFox.Recordset.Index = "CLDEUCOM"
    DataFox.Recordset.Seek "=", CDbl(CodigoHijoFox), CDbl(CodigoPadreFox)
        If DataFox.Recordset.NoMatch Then
            Buscar_Relacion_Fox = False
        Else
            Buscar_Relacion_Fox = True
        End If
    End Function


Function Busca_Relacion_Cliente(nRut1 As Double, nCodigo1 As Double, nRut2 As Double, nCodigo2 As Long) As Boolean

Dim Sql$
Dim Datos()
Dim datosSTR As String

    
    Busca_Relacion_Cliente = False
    
        Envia = Array()
        AddParam Envia, CDbl(txtRut.Text)
        AddParam Envia, CDbl(txtCodigo1.Text)
        AddParam Envia, CDbl(Txtrut2.Text)
        AddParam Envia, CDbl(txtCodigo2.Text)
          
    If Not BAC_SQL_EXECUTE("sp_bdatosrel ", Envia) Then
        MsgBox "Consulta en Bactrader Ha Fallado. Servidor SQL No Responde", vbCritical
        Exit Function
    End If
       
        
    If BAC_SQL_FETCH(Datos()) Then
        If Datos(1) <> "NO" Then
            'TEXTOS
            
            If Trim(Datos(1)) = "" Then
               Txtporc.Text = 0
            Else
                Txtporc.Text = CDbl(Datos(1))
            End If
            
            lblHijo.Caption = Datos(2)
            ''CodigoPadreFox = CDBL(Datos(3))
            ''CodigoHijoFox = CDBL(Datos(4))
            Txtrut2.Enabled = False
            txtCodigo2.Enabled = False
            Txtporc.SetFocus
        Else
            MsgBox "No existe relación", vbCritical
            Txtrut2.Text = ""
            txtCodigo2.Text = ""
            lblHijo.Caption = ""
            Txtrut2.SetFocus
        End If
    Else
      'TEXTOS
       Txtporc.Text = ""
       lblPadre.Caption = ""
       lblHijo.Caption = ""
    End If
      

End Function


Private Sub Txtrut2_KeyDown(KeyCode As Integer, Shift As Integer)
 If KeyCode = vbKeyF3 Then Call Txtrut2_DblClick
End Sub


Private Sub Txtrut2_KeyPress(KeyAscii As Integer)
  If KeyAscii% = vbKeyReturn Then
      KeyAscii% = 0
      SendKeys$ "{TAB}"

   ElseIf Not ((KeyAscii > 47 And KeyAscii < 58) Or KeyAscii = 8) Then
      KeyAscii = 0
     
   End If
     
   BacCaracterNumerico KeyAscii
End Sub

Function ValidaDatos() As Boolean

  ValidaDatos = True
  
  If Trim$(txtRut) = "" Then
      Screen.MousePointer = 0
      MsgBox "ERROR : Número Rut  grupo  vacio", 16
      ValidaDatos = False
      Exit Function
   End If

  
   If Trim$(txtCodigo1) = "" Then
      Screen.MousePointer = 0
      MsgBox "ERROR : Código asociado al Rut  grupo en Blanco", 16
      ValidaDatos = False
      Exit Function
   End If
 
   If Trim$(Txtrut2) = "" Then
      Screen.MousePointer = 0
      MsgBox "ERROR : Número de rut cliente  vacio", 16
      ValidaDatos = False
      Exit Function
   End If
       
   If Trim$(txtCodigo2) = "" Then
      Screen.MousePointer = 0
      MsgBox "ERROR : Código asociado al Rut cliente en Blanco", 16
      ValidaDatos = False
      Exit Function
  End If
    
    If Trim$(txtRut) = Trim$(Txtrut2) And Trim$(txtCodigo1) = Trim$(txtCodigo2) Then
      Screen.MousePointer = 0
      MsgBox "ERROR : Rut  grupo y Rut cliente son igueles : No Grabara ", 16
      ValidaDatos = False
      Exit Function
    End If
    
End Function
   
Sub LimpiaGrid()
  For nPos = 1 To Grid1.Rows - 1
      With Grid1
            If (.Rows - 1) = 1 Then
                For i = 1 To Grid1.Cols - 1
                    .Col = i: .Text = " "
                Next i
                Exit For
            End If
   .RemoveItem (nPos)
  nPos = 0
  End With
  Next nPos
    Table1.Rows = Grid1.Rows - 1
    Table1.Refresh

  
'  Table1.Rows = Grid1.Rows - 2
'  Table1.Refresh
End Sub

Public Function CargarParam(Grillas As Object)

With Grillas
          
          .RowHeight(0) = 350
          .CellFontWidth = 4
          .Row = 0
         
         .Col = 0: .FixedAlignment(0) = 4
         .CellFontBold = True
         .TextMatrix(.Row, 0) = "  Rut Cliente "
         .ColWidth(0) = TextWidth(.TextMatrix(.Row, 0)) + 700
         .ColAlignment(0) = 8     ' derecha abajo

         .Col = 1: .FixedAlignment(1) = 4
         .CellFontBold = True
         .TextMatrix(.Row, 1) = "    Codigo     "
         .ColWidth(1) = TextWidth(.TextMatrix(.Row, 1)) + 700
         .ColAlignment(1) = 8

         .Col = 2: .FixedAlignment(2) = 4
         .CellFontBold = True
         .TextMatrix(.Row, 2) = "          Nombre del Cliente           "
         .ColWidth(2) = TextWidth(.TextMatrix(.Row, 2)) + 1000
         .ColAlignment(2) = 2

         .Col = 3: .FixedAlignment(3) = 4
         .CellFontBold = True
         .TextMatrix(.Row, 3) = "     Por %     "
         .ColWidth(3) = TextWidth(.TextMatrix(.Row, 3)) + 400
         .ColAlignment(3) = 4

         
   End With

End Function











