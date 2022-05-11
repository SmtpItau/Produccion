VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{316A9483-A459-11D4-9073-005004A524B9}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacRelacionCliente 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Relación Clientes"
   ClientHeight    =   4695
   ClientLeft      =   2865
   ClientTop       =   2640
   ClientWidth     =   8505
   Icon            =   "Bacrelcl.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4695
   ScaleWidth      =   8505
   ShowInTaskbar   =   0   'False
   Begin VB.Frame Frame2 
      Height          =   1950
      Left            =   30
      TabIndex        =   16
      Top             =   2505
      Width           =   8400
      Begin MSFlexGridLib.MSFlexGrid Grilla 
         Height          =   1575
         Left            =   120
         TabIndex        =   11
         Top             =   240
         Width           =   8175
         _ExtentX        =   14420
         _ExtentY        =   2778
         _Version        =   393216
         Cols            =   4
         FixedCols       =   0
         BackColor       =   12632256
         ForeColor       =   8388608
         BackColorFixed  =   8421376
         ForeColorFixed  =   16777215
         BackColorSel    =   8388608
         ForeColorSel    =   8388608
         GridColor       =   255
         GridColorFixed  =   8421504
         GridLines       =   2
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
   End
   Begin VB.Data DataFox 
      Caption         =   "Data1"
      Connect         =   "FoxPro 2.6;"
      DatabaseName    =   ""
      DefaultCursorType=   0  'DefaultCursor
      DefaultType     =   2  'UseODBC
      Exclusive       =   0   'False
      Height          =   300
      Left            =   5730
      Options         =   0
      ReadOnly        =   0   'False
      RecordsetType   =   0  'Table
      RecordSource    =   ""
      Top             =   330
      Visible         =   0   'False
      Width           =   1905
   End
   Begin VB.TextBox txtCodigo1 
      Height          =   315
      Left            =   2415
      MaxLength       =   3
      TabIndex        =   5
      Top             =   825
      Width           =   435
   End
   Begin VB.TextBox txtrut 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFFFFF&
      Height          =   315
      Left            =   1365
      MaxLength       =   9
      MouseIcon       =   "Bacrelcl.frx":030A
      MousePointer    =   99  'Custom
      MultiLine       =   -1  'True
      TabIndex        =   4
      Top             =   825
      Width           =   1035
   End
   Begin VB.Frame Frame1 
      Height          =   1245
      Left            =   30
      TabIndex        =   13
      Top             =   1260
      Width           =   8370
      Begin BacControles.txtNumero Txtporc 
         Height          =   255
         Left            =   1320
         TabIndex        =   10
         Top             =   840
         Width           =   975
         _ExtentX        =   1720
         _ExtentY        =   450
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0.00"
         CantidadDecimales=   "2"
         Max             =   "100.00"
      End
      Begin VB.TextBox txtCodigo2 
         Height          =   300
         Left            =   2400
         MaxLength       =   3
         TabIndex        =   8
         Top             =   285
         Width           =   405
      End
      Begin VB.TextBox Txtrut2 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00FFFFFF&
         Height          =   300
         Left            =   1335
         MaxLength       =   9
         MouseIcon       =   "Bacrelcl.frx":0614
         MousePointer    =   99  'Custom
         MultiLine       =   -1  'True
         TabIndex        =   7
         Top             =   285
         Width           =   1035
      End
      Begin VB.Label lblHijo 
         BackColor       =   &H00C0C0C0&
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
         Height          =   330
         Left            =   2835
         TabIndex        =   9
         Top             =   270
         Width           =   4875
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "RUT Cliente"
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
         Left            =   195
         TabIndex        =   15
         Top             =   330
         Width           =   1050
      End
      Begin VB.Label Label3 
         AutoSize        =   -1  'True
         Caption         =   "Porcentaje"
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
         Left            =   315
         TabIndex        =   14
         Top             =   840
         Width           =   930
      End
   End
   Begin Threed.SSCommand cmdEliminar 
      Height          =   450
      Left            =   1215
      TabIndex        =   1
      Top             =   15
      Width           =   1200
      _Version        =   65536
      _ExtentX        =   2117
      _ExtentY        =   794
      _StockProps     =   78
      Caption         =   "&Eliminar"
      ForeColor       =   8388608
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Font3D          =   3
   End
   Begin Threed.SSCommand cmdLimpiar 
      Height          =   450
      Left            =   2415
      TabIndex        =   2
      Tag             =   "C"
      Top             =   15
      Width           =   1200
      _Version        =   65536
      _ExtentX        =   2117
      _ExtentY        =   794
      _StockProps     =   78
      Caption         =   "&Limpiar"
      ForeColor       =   8388608
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Font3D          =   3
   End
   Begin Threed.SSCommand cmdSalir 
      Height          =   450
      Left            =   3615
      TabIndex        =   3
      Top             =   15
      Width           =   1200
      _Version        =   65536
      _ExtentX        =   2117
      _ExtentY        =   794
      _StockProps     =   78
      Caption         =   "&Salir"
      ForeColor       =   8388608
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Font3D          =   3
   End
   Begin Threed.SSCommand cmdGrabar 
      Height          =   450
      Left            =   15
      TabIndex        =   0
      Top             =   15
      Width           =   1200
      _Version        =   65536
      _ExtentX        =   2117
      _ExtentY        =   794
      _StockProps     =   78
      Caption         =   "&Grabar"
      ForeColor       =   8388608
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Font3D          =   3
   End
   Begin VB.Label lblPadre 
      BackColor       =   &H00C0C0C0&
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
      Height          =   330
      Left            =   2880
      TabIndex        =   6
      Top             =   825
      Width           =   4890
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      Caption         =   "Cliente Grupo"
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
      Left            =   105
      TabIndex        =   12
      Top             =   855
      Width           =   1170
   End
End
Attribute VB_Name = "BacRelacionCliente"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Dim CodigoPadreFox As String
Dim CodigoHijoFox As String
Dim datos()
Dim Sql As String

Private Sub cmdeliminar_Click()

Dim Sql$

On Error GoTo ErrEli

Screen.MousePointer = 11
    
    Sql = ""
    'Sql = "SELECT * FROM mdcl_relacion WHERE  clrut_padre =" & Val(txtrut.Text) & "AND clcodigo_padre = " & Val(txtCodigo1.Text) & "AND clrut_hijo = " & Val(Txtrut2.Text) & "AND clcodigo_hijo = " & Val(txtCodigo2.Text)
    
    Sql = "SP_MDCLRELACION "
    Sql = Sql + Val(txtrut.Text) & ","
    Sql = Sql + Val(txtCodigo1.Text) & ","
    Sql = Sql + Val(Txtrut2.Text) & "'"
    Sql = Sql + Val(txtCodigo2.Text)
    
    If miSQL.SQL_Execute(Sql) <> 0 Then
        Screen.MousePointer = 0
        MsgBox "Consulta en Bactrader Ha Fallado. Servidor SQL No Responde", vbCritical, gsBac_Version
        Exit Sub
    End If
       
        
If miSQL.SQL_Fetch(datos()) = 0 Then
  If ValidaDatos() Then
   ' If EliminaFoxRel() Then
        If Elimina_Relacion_SQL() Then
            Screen.MousePointer = 0
            MsgBox "Eliminación se realizó correctamente", vbInformation, gsBac_Version
            Call BuscarHijos
        Else
           Screen.MousePointer = 0
           MsgBox "Eliminación no se realizó correctamente", vbCritical, gsBac_Version
        End If
   ' Else
     '      MsgBox "Eliminación no se realizó correctamente", vbCritical, gsBac_Version
   ' End If
  End If
Else
       Screen.MousePointer = 0
       MsgBox "Datos no han sido grabados", vbCritical, "Bac-Trader"
End If

        Call Limpiar
        Call F_BacLimpiaGrilla(Grilla)
        Call BacAgrandaGrilla(Grilla, 40)
        HabilitarControles (False)
        txtrut.SetFocus

ErrEli:

End Sub
Function Elimina_Relacion_SQL() As Boolean
    
Dim Sql$

 Elimina_Relacion_SQL = True
    
    Sql = ""
    Sql = " EXECUTE  Sp_Elimina_Relacion_Cliente "
    Sql = Sql & txtrut.Text & ","
    Sql = Sql & txtCodigo1.Text & ","
    Sql = Sql & Txtrut2.Text & ","
    Sql = Sql & txtCodigo2.Text
    

     If miSQL.SQL_Execute(Sql) <> 0 Then
        MsgBox "Grabación de relación no se realizó correctamente", vbCritical, "Bac-Trader"
        Elimina_Relacion_SQL = False
        Exit Function
    End If
    
 End Function

Function Graba_Relacion_SQL() As Boolean

Dim Sql As String

Graba_Relacion_SQL = True
    
    Sql = ""
    Sql = " EXECUTE  Sp_Graba_Relacion_Cliente "
    Sql = Sql & txtrut.Text & ","
    Sql = Sql & txtCodigo1.Text & ","
    Sql = Sql & Txtrut2.Text & ","
    Sql = Sql & txtCodigo2.Text & ","
   '' Sql = Sql & F_FomateaValor(Txtporc.Text, ",", ".")
    Sql = Sql & Txtporc.Text

    If miSQL.SQL_Execute(Sql) <> 0 Then
        MsgBox "Grabación de relación no se realizó correctamente", vbCritical, "Bac-Trader"
        Graba_Relacion_SQL = False
        Exit Function
    End If
 
 
End Function

Private Sub cmdgrabar_Click()
On Error GoTo ErrGrb

Screen.MousePointer = 11
Me.MousePointer = 0


 If ValidaDatos() Then
    ''If GrabaFoxRel() Then
        If Graba_Relacion_SQL() Then
            Screen.MousePointer = 0
            MsgBox "Grabación se realizó correctamente", vbInformation, gsBac_Version
            Call BuscarHijos
        Else
           Screen.MousePointer = 0
           MsgBox "Grabacion no se realizó correctamente", vbCritical, gsBac_Version
           Exit Sub
        End If
    ''Else
     ''      MsgBox "Grabacion no se realizó correctamente", vbCritical, gsBac_Version
     ''      Exit Sub
    ''End If
 End If
 
    Call Limpiar
    Call F_BacLimpiaGrilla(Grilla)
    Call BacAgrandaGrilla(Grilla, 40)
    HabilitarControles (False)
    Screen.MousePointer = 0
    Me.MousePointer = 0

Exit Sub

ErrGrb:
    
End Sub

Function GrabaFoxRel() As Boolean
GrabaFoxRel = False
On Error GoTo GrabaError

 If Not Buscar_Relacion_Fox(Val(CodigoPadreFox)) Then
     DataFox.Recordset.AddNew
Else
     DataFox.Recordset.Edit
End If

Mover_FoxRel
DataFox.Recordset.Update

GrabaFoxRel = True

Exit Function

GrabaError:

MsgBox Error(Err), 16

Exit Function

End Function

Sub Mover_FoxRel()
     DataFox.Recordset.Fields!X = ""
     DataFox.Recordset.Fields!y = ""
     DataFox.Recordset.Fields!hijo = CodigoHijoFox
     DataFox.Recordset.Fields!padre = CodigoPadreFox
     DataFox.Recordset.Fields!porpar = Txtporc.Text
     DataFox.Recordset.Fields!coefic = 0
End Sub

Function EliminaFoxRel() As Boolean
On Error GoTo EliminaError

 If Buscar_Relacion_Fox(Val(CodigoPadreFox)) Then
     DataFox.Recordset.Delete
     EliminaFoxRel = True
Else
     EliminaFoxRel = False
End If
DataFox.Refresh

Exit Function
EliminaError:
MsgBox Error(Err), 16
Exit Function
End Function

Sub Limpiar()
        txtrut.Text = ""
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
    Call BacAgrandaGrilla(Grilla, 40)
    Call Limpiar
    HabilitarControles (False)
    Me.MousePointer = 0
    Screen.MousePointer = 0
    txtrut.SetFocus
    
End Sub
Private Sub cmdSalir_Click()
Unload Me
End Sub

Private Sub Form_Activate()
 
 Call CargarParam(Grilla)
 Call BacAgrandaGrilla(Grilla, 40)
 
End Sub

Private Sub Form_Load()
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
   
If Val(txtrut.Text) = 0 Or Trim(txtCodigo1.Text) = "" Then Exit Sub
   
   If Trim(txtCodigo1) = "" Or Trim(txtrut) = "" Then
      
      If Val(txtCodigo1) = 0 Then
         MsgBox "Error : El código no puede ser 0 ", 16, gsBac_Version
      Else
         MsgBox "Error : Datos en Blanco ", 16, gsBac_Version
      End If
      
      Call Limpiar
      Call HabilitarControles(False)
      txtrut.SetFocus
      Exit Sub
 End If

  Screen.MousePointer = 11

    Sql = ""
    'Sql = "SELECT clnombre FROM mdcl WHERE clrut = " & txtrut.Text & "AND clcodigo = " & txtCodigo1.Text
    
    Sql = "SP_CODCLIENTE "
    Sql = Sql + "'" & txtrut.Text & ","
    Sql = Sql + "'" & txtCodigo1.Text

    If miSQL.SQL_Execute(Sql) <> 0 Then
        Screen.MousePointer = 0
        MsgBox "Consulta en Bactrader Ha Fallado. Servidor SQL No Responde", vbCritical, gsBac_Version
        Exit Sub
    End If
       
        
    If miSQL.SQL_Fetch(datos()) = 0 Then
        lblPadre.Caption = datos(1)
        HabilitarControles (True)
        Call BuscarHijos
        Txtrut2.SetFocus
    Else
        Screen.MousePointer = 0
        MsgBox "Rut no existe ", vbCritical, gsBac_Version
        Call Limpiar
        Call HabilitarControles(False)
        txtrut.SetFocus
        Exit Sub
    End If
    
    
    
End Sub

Function BuscarHijos()
    
Dim Sql$
Dim Fila%

 
    '---- Llenar la grilla
    Sql = ""
    Sql = " sp_consulhijos "
    Sql = Sql & Val(txtrut.Text)
    Sql = Sql & "," & Val(txtCodigo1.Text)
    
    
        If miSQL.SQL_Execute(Sql) <> 0 Then
            Exit Function
        End If
        
With Grilla

     .Rows = 2
      Call F_BacLimpiaGrilla(Grilla)
    Do While miSQL.SQL_Fetch(datos()) = 0
        
           .Row = .Rows - 1
           .TextMatrix(.Row, 0) = Val(datos(1))
           .TextMatrix(.Row, 1) = Val(datos(2))
           .TextMatrix(.Row, 2) = Trim$(datos(4))
           .TextMatrix(.Row, 3) = datos(3)
           .Rows = .Rows + 1
    Loop
    
        .Rows = .Rows - 1

End With
    
Call BacAgrandaGrilla(Grilla, 40)
Me.MousePointer = 0
Screen.MousePointer = 0



    
    
''    c1 = "0"
''    For i = 1 To Grid1.Cols - 1
''        Table1.ColumnCellAttrs(i) = True
''    Next i
''
''    '---- Llenar la grilla
''    Sql = "sp_consulhijos " & Val(txtrut.Text) & "," & Val(txtCodigo1.Text)
''    If misql.SQL_Execute(Sql) <> 0 Then
''        Exit Function
''    End If
''    Grid1.Rows = 1
''
''    Do While misql.SQL_Fetch(Datos()) = 0
''        c1 = "1"
''        With Grid1
''           .Rows = .Rows + 1
''           .Row = .Rows - 1
''           .Col = 1: .Text = Val(Datos(1))
''           .Col = 2: .Text = Val(Datos(2))
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
   
   If Val(Txtrut2.Text) = 0 Or Trim(txtCodigo2.Text) = "" Then Exit Sub
   
  Bandera = True
  
  If Trim(txtCodigo2) = "" Or Trim(Txtrut2) = "" Then
      
      If Val(txtCodigo2) = 0 Then
         MsgBox "Error : El código no puede ser 0 ", 16, gsBac_Version
      Else
         MsgBox "Error : Datos en Blanco ", 16, gsBac_Version
      End If
      Txtrut2.SetFocus
      Exit Sub
 End If
 
 Call Busca_Relacion_Cliente(txtrut.Text, txtCodigo1.Text, Txtrut2.Text, txtCodigo2.Text)
    Me.MousePointer = 0
    Screen.MousePointer = 0
 
End Sub

Function HabilitarControles(Valor As Boolean)
     txtrut.Enabled = Not Valor
     txtCodigo1.Enabled = Not Valor
     Txtrut2.Enabled = Valor
     txtCodigo2.Enabled = Valor
     
     Txtporc.Enabled = Valor
End Function


Private Sub txtRut_DblClick()

BacAyuda.Tag = "MDCL"
BacAyuda.Show 1

If giAceptar% = True Then
    txtrut.Text = Val(gsrut$)
    txtCodigo1.Text = Val(gsvalor$)
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

BacAyuda.Tag = "MDCL"
BacAyuda.Show 1

If giAceptar% = True Then
    Txtrut2.Text = Val(gsrut$)
    txtCodigo2.Text = Val(gsvalor$)
    lblHijo.Caption = Trim(gsDescripcion$)
End If
    txtCodigo2_LostFocus
End Sub

Function Buscar_Relacion_Fox(Codigo As Double) As Boolean
    DataFox.Recordset.Index = "CLDEUCOM"
    DataFox.Recordset.Seek "=", Val(CodigoHijoFox), Val(CodigoPadreFox)
        If DataFox.Recordset.NoMatch Then
            Buscar_Relacion_Fox = False
        Else
            Buscar_Relacion_Fox = True
        End If
    End Function


Function Busca_Relacion_Cliente(nRut1 As Double, nCodigo1 As Double, nRut2 As Double, nCodigo2 As Long) As Boolean

Dim Sql$
Dim datos()
Dim datosSTR As String

    
    Busca_Relacion_Cliente = False
    
        Sql = ""
        Sql = "EXECUTE  sp_bdatosrel "
        Sql = Sql & Val(txtrut.Text)
        Sql = Sql & "," & Val(txtCodigo1.Text)
        Sql = Sql & "," & Val(Txtrut2.Text)
        Sql = Sql & "," & Val(txtCodigo2.Text)
          
    If miSQL.SQL_Execute(Sql) <> 0 Then
        MsgBox "Consulta en Bactrader Ha Fallado. Servidor SQL No Responde", vbCritical, gsBac_Version
        Exit Function
    End If
       
        
    If miSQL.SQL_Fetch(datos()) = 0 Then
        If datos(1) <> "NO" Then
            'TEXTOS
            
            If Trim(datos(1)) = "" Then
               Txtporc.Text = 0
            Else
                Txtporc.Text = CDbl(datos(1))
            End If
            
            lblHijo.Caption = datos(2)
            ''CodigoPadreFox = Val(Datos(3))
            ''CodigoHijoFox = Val(Datos(4))
            Txtrut2.Enabled = False
            txtCodigo2.Enabled = False
            Txtporc.SetFocus
        Else
            MsgBox "Cliente no existe", vbCritical, gsBac_Version
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
  
  If Trim$(txtrut) = "" Then
      Screen.MousePointer = 0
      MsgBox "ERROR : Número Rut  grupo  vacio", 16, gsBac_Version
      ValidaDatos = False
      Exit Function
   End If

  
   If Trim$(txtCodigo1) = "" Then
      Screen.MousePointer = 0
      MsgBox "ERROR : Código asociado al Rut  grupo en Blanco", 16, gsBac_Version
      ValidaDatos = False
      Exit Function
   End If
 
   If Trim$(Txtrut2) = "" Then
      Screen.MousePointer = 0
      MsgBox "ERROR : Número de rut cliente  vacio", 16, gsBac_Version
      ValidaDatos = False
      Exit Function
   End If
       
   If Trim$(txtCodigo2) = "" Then
      Screen.MousePointer = 0
      MsgBox "ERROR : Código asociado al Rut cliente en Blanco", 16, gsBac_Version
      ValidaDatos = False
      Exit Function
  End If
    
    If Trim$(txtrut) = Trim$(Txtrut2) And Trim$(txtCodigo1) = Trim$(txtCodigo2) Then
      Screen.MousePointer = 0
      MsgBox "ERROR : Rut  grupo y Rut cliente son igueles : No Grabara ", 16, gsBac_Version
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











