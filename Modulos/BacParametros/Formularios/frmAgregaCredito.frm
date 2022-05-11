VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form frmAgregaCredito 
   BorderStyle     =   4  'Fixed ToolWindow
   Caption         =   "Adición de Creditos"
   ClientHeight    =   5325
   ClientLeft      =   45
   ClientTop       =   315
   ClientWidth     =   10815
   LinkTopic       =   "Form2"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   5325
   ScaleWidth      =   10815
   ShowInTaskbar   =   0   'False
   StartUpPosition =   1  'CenterOwner
   Begin VB.Frame Frame2 
      Caption         =   "Asignación de creditos"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   3165
      Left            =   60
      TabIndex        =   16
      Top             =   2100
      Width           =   10695
      Begin MSFlexGridLib.MSFlexGrid Grilla 
         Height          =   2775
         Left            =   90
         TabIndex        =   9
         Top             =   240
         Width           =   10545
         _ExtentX        =   18600
         _ExtentY        =   4895
         _Version        =   393216
         FixedCols       =   0
         AllowBigSelection=   0   'False
         FocusRect       =   0
         GridLinesFixed  =   1
         SelectionMode   =   1
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "Credito"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1575
      Left            =   60
      TabIndex        =   0
      Top             =   480
      Width           =   10695
      Begin VB.ComboBox cmbMonedas 
         Height          =   315
         Left            =   240
         Style           =   2  'Dropdown List
         TabIndex        =   5
         Top             =   1050
         Width           =   3855
      End
      Begin VB.TextBox txtNroCredito 
         Height          =   285
         Left            =   210
         TabIndex        =   1
         Text            =   "Text1"
         Top             =   480
         Width           =   1575
      End
      Begin VB.TextBox txtRut 
         Height          =   285
         Left            =   1920
         MaxLength       =   9
         TabIndex        =   2
         Text            =   "Text1"
         Top             =   480
         Width           =   1395
      End
      Begin VB.TextBox txtDv 
         Height          =   285
         Left            =   3360
         MaxLength       =   1
         TabIndex        =   3
         Text            =   "Text1"
         Top             =   480
         Width           =   375
      End
      Begin VB.TextBox txtNombre 
         Height          =   285
         Left            =   3870
         MousePointer    =   14  'Arrow and Question
         TabIndex        =   4
         Text            =   "Text4"
         Top             =   480
         Width           =   6525
      End
      Begin VB.CommandButton cmbAgregar 
         Caption         =   "Agregar"
         Height          =   315
         Left            =   7410
         TabIndex        =   8
         Top             =   1020
         Width           =   1095
      End
      Begin BACControles.TXTNumero txtCapital 
         Height          =   285
         Left            =   4260
         TabIndex        =   6
         Top             =   1050
         Width           =   1605
         _ExtentX        =   2831
         _ExtentY        =   503
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0"
         Text            =   "0"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin BACControles.TXTFecha txtVcto 
         Height          =   285
         Left            =   5940
         TabIndex        =   7
         Top             =   1050
         Width           =   1335
         _ExtentX        =   2355
         _ExtentY        =   503
         Enabled         =   -1  'True
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "13-04-2010"
      End
      Begin VB.Label Label1 
         Caption         =   "Num. Crédito"
         Height          =   255
         Left            =   210
         TabIndex        =   15
         Top             =   240
         Width           =   1575
      End
      Begin VB.Label Label2 
         Caption         =   "Nombre Cliente"
         Height          =   255
         Left            =   3870
         TabIndex        =   14
         Top             =   240
         Width           =   4215
      End
      Begin VB.Label Label3 
         Caption         =   "Rut Cliente"
         Height          =   255
         Left            =   1920
         TabIndex        =   13
         Top             =   240
         Width           =   1785
      End
      Begin VB.Label Label4 
         Caption         =   "Moneda"
         Height          =   255
         Left            =   210
         TabIndex        =   12
         Top             =   810
         Width           =   1305
      End
      Begin VB.Label Label5 
         Caption         =   "Capital"
         Height          =   255
         Left            =   4260
         TabIndex        =   11
         Top             =   780
         Width           =   1575
      End
      Begin VB.Label Label6 
         Caption         =   "Fec. Vcto"
         Height          =   255
         Left            =   5940
         TabIndex        =   10
         Top             =   780
         Width           =   1335
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   17
      Top             =   0
      Width           =   10815
      _ExtentX        =   19076
      _ExtentY        =   794
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Save"
            Object.ToolTipText     =   "Grabar / Actualizar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Key             =   "Delete"
            Object.ToolTipText     =   "Eliminar Creditos"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Close"
            Object.ToolTipText     =   "Cerrar"
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   5010
         Top             =   0
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   22
         ImageHeight     =   22
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   5
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmAgregaCredito.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmAgregaCredito.frx":0EDA
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmAgregaCredito.frx":1DB4
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmAgregaCredito.frx":20CE
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmAgregaCredito.frx":2FA8
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
End
Attribute VB_Name = "frmAgregaCredito"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public lActualizaCreditos As Boolean
Private lGrabados As Boolean
Private sMoneda As String
Private nMoneda As Integer
Private nCodCli As Integer

Private Sub cmbAgregar_Click()
Dim i As Integer
    
    If txtNroCredito.Text = "" Then
        MsgBox "Debe ingresar un número de credito valido!!!"
        txtNroCredito.SetFocus
        Exit Sub
    End If
    If Not ValidaCredito(CDbl(txtNroCredito.Text)) Then
        MsgBox "Credito existente!!!"
        Exit Sub
    End If
    For i = 1 To grilla.Rows - 1
        If grilla.TextMatrix(i, 0) = "" Then
            nRow = i
            Exit For
        End If
    Next
    If i = grilla.Rows Then
        grilla.AddItem Me.txtNroCredito.Text & vbTab & _
                       Me.txtNombre.Text & vbTab & _
                       Me.txtRut.Text & "-" & Me.txtDv.Text & vbTab & _
                       sMoneda & vbTab & _
                       Me.txtCapital.Text & vbTab & _
                       Me.txtVcto.Text & vbTab & _
                       nMoneda & vbTab & _
                       Me.txtRut.Tag
    Else
        grilla.TextMatrix(nRow, 0) = Me.txtNroCredito.Text
        grilla.TextMatrix(nRow, 1) = Me.txtNombre.Text
        grilla.TextMatrix(nRow, 2) = Format(Me.txtRut.Text, "#,##0") & "-" & Me.txtDv.Text
        grilla.TextMatrix(nRow, 3) = sMoneda
        grilla.TextMatrix(nRow, 4) = Me.txtCapital.Text
        grilla.TextMatrix(nRow, 5) = Me.txtVcto.Text
        grilla.TextMatrix(nRow, 6) = nMoneda
        grilla.TextMatrix(nRow, 7) = Me.txtRut.Tag
    End If
    Call LimpiaForm
End Sub

Function ValidaCredito(sNroCredito As Long) As Boolean
    Dim nRet As Integer
    Dim sSQL As String
    Dim Datos()
    
    ValidaCredito = False
    
    Envia = Array()
    AddParam Envia, sNroCredito
    sSQL = "sp_validaNumeroCredito"
    If Not Bac_Sql_Execute(sSQL, Envia) Then
       Exit Function
    End If
    
    nRet = 0
    If Bac_SQL_Fetch(Datos()) Then
       nRet = Val(Datos(1))
    End If
    If nRet = 0 Then
        ValidaCredito = True
    End If
End Function

Private Sub LimpiaForm()

    
    nMoneda = 0
    sMoneda = ""
    Me.txtNroCredito = ""
    Me.txtRut = ""
    Me.txtDv = ""
    Me.txtNombre = ""
    Me.cmbMonedas.ListIndex = -1
    Me.txtCapital.Text = ""
    Me.txtVcto.Text = ""

    
End Sub

Private Sub cmbMonedas_Click()
    Dim nCodigoMon As Integer
    
        If cmbMonedas.ListIndex >= 0 Then
            nMoneda = cmbMonedas.ItemData(cmbMonedas.ListIndex)
            sMoneda = TraeNemoMoneda(nMoneda)
            SendKeys "{tab}"
        End If
        
End Sub
Private Function TraeNemoMoneda(nCodigo As Integer) As String
    Dim nRet As Integer
    Dim sSQL As String
    Dim Datos()
    
        Envia = Array()
        AddParam Envia, nCodigo
        AddParam Envia, 0
        
        sSQL = "sp_lee_datos_moneda"
        If Not Bac_Sql_Execute(sSQL, Envia) Then
           Exit Function
        End If

        If Bac_SQL_Fetch(Datos()) Then
            TraeNemoMoneda = (Datos(2))
        End If
        
End Function

Private Sub Form_Load()
        
    lActualizaCreditos = False
    lGrabados = False
    
    Call LimpiaForm
    Call CargaMonedas

    '
    '   Limpia grilla
    '
    Me.grilla.Rows = 1
    Me.grilla.Rows = 21
    
    grilla.Cols = 9
    grilla.TextMatrix(0, 0) = "Num. Crédito":     Let grilla.ColWidth(0) = 1050: Let grilla.ColAlignment(0) = flexAlignLeftCenter
    grilla.TextMatrix(0, 1) = "Nombre Cliente":   Let grilla.ColWidth(1) = 3000: Let grilla.ColAlignment(1) = flexAlignLeftCenter
    grilla.TextMatrix(0, 2) = "Rut Cliente":      Let grilla.ColWidth(2) = 1200: Let grilla.ColAlignment(2) = flexAlignLeftCenter
    grilla.TextMatrix(0, 3) = "Moneda":           Let grilla.ColWidth(3) = 1200: Let grilla.ColAlignment(3) = flexAlignLeftCenter
    grilla.TextMatrix(0, 4) = "Capital":          Let grilla.ColWidth(4) = 1500: Let grilla.ColAlignment(4) = flexAlignRightCenter
    grilla.TextMatrix(0, 5) = "Fec. Vcto":        Let grilla.ColWidth(5) = 1200: Let grilla.ColAlignment(5) = flexAlignLeftCenter
    grilla.TextMatrix(0, 6) = "Cod. Moneda":      Let grilla.ColWidth(6) = 1280: Let grilla.ColAlignment(6) = flexAlignLeftCenter
    grilla.TextMatrix(0, 7) = "Cod. cliente":     Let grilla.ColWidth(7) = 1280: Let grilla.ColAlignment(7) = flexAlignLeftCenter
      
End Sub


Private Sub Form_Unload(Cancel As Integer)

    If lGrabados Then
        'If lActualizaCreditos Then
        
    
    End If
    
End Sub

Private Sub grilla_Click()
    With grilla
        idx = .Row

        If .Row = 0 Then
            .AddItem ""
            .Row = 1
        End If
        
        If .TextMatrix(.Row, .Cols - 1) = "*" Then
            Color1 = &H80&
            Color2 = &HFF0000    ' &HFFFFFF
        Else
            Color1 = &H8000000D
            Color2 = &H8000000E
        End If
        .FillStyle = flexFillRepeat
        .Col = 0
        .ColSel = .Cols - 1
        .RowSel = .Row
        .BackColorSel = Color1
        .ForeColorSel = Color2

    End With
End Sub

Private Sub Grilla_DblClick()
    Dim BackColor, ForeColor As Long
    Dim ForeColorSel, BackColorSel As Long
    
    With grilla
        If .TextMatrix(.Row, 0) = "" Then Exit Sub
    
        If .TextMatrix(.Row, .Cols - 1) = "*" Then
        
            .TextMatrix(.Row, .Cols - 1) = ""
            BackColor = &H8000000E                  ' Fondo Blanco
            ForeColor = &H80000008                  ' Letras Negras
            
            BackColorSel = &H8000000D               ' Fondo azul
            ForeColorSel = &H8000000E               ' Letras Blancas
        Else
            
            .TextMatrix(.Row, .Cols - 1) = "*"
            BackColor = &H80&                       ' Fondo Rojo
            ForeColor = &H8000000E                  ' Letras Blancas
            
            BackColorSel = &H80&                    ' Fondo Rojo
            ForeColorSel = &H8000000E               ' Letras Blancas
        End If
        
        .FillStyle = flexFillRepeat
        .ColSel = .Cols - 1
        .RowSel = .Row
         
        .CellBackColor = BackColor
        .CellForeColor = ForeColor
        
        .BackColorSel = BackColorSel
        .ForeColorSel = ForeColorSel
        
        '
        '   Habilita Toolbar
        '
        Toolbar1.Buttons(3).Enabled = False
        For i = 1 To .Rows - 1
            If .TextMatrix(i, .Cols - 1) = "*" Then
                Toolbar1.Buttons(3).Enabled = True
            End If
        Next
        
    End With
           
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
    Select Case Button.Key
    
    Case "Save"
        GrabarCreditos
    
    Case "Delete"
        EliminarCredito
    
    Case "Close"
        Unload Me
    
    End Select

End Sub

Private Sub GrabarCreditos()
    Dim lflag As Boolean
    
    lflag = False
    For i = 1 To grilla.Rows - 1
        If grilla.TextMatrix(i, 0) <> "" Then
            lflag = True
        End If
    Next
    
    If Not lflag Then
        MsgBox "No hay creditos que grabar", vbInformation + vbOKOnly, "Dialogo"
        Exit Sub
    End If
    
    If GrabaCreditos Then
        MsgBox "Los creditos se han grabado correctamente.", vbInformation + vbOKOnly, "Dialogo"
    End If
    lActualizaCreditos = True
    
    Call LimpiaForm
    '
    '   Limpia grilla
    '
    Me.grilla.Rows = 1
    Me.grilla.Rows = 21
    Unload Me

End Sub

Private Function GrabaCreditos() As Boolean
    Dim nRet As Integer
    Dim sSQL As String
    Dim Datos()
    
        GrabaCreditos = True
        For i = 1 To grilla.Rows - 1
            If grilla.TextMatrix(i, 0) <> "" Then
            
                Envia = Array()
                AddParam Envia, CDbl(grilla.TextMatrix(i, 0)) ' Nro credito
                AddParam Envia, CDbl(IIf(Format(grilla.TextMatrix(i, 2), "#0") = "-", "0", Mid(Format(grilla.TextMatrix(i, 2), "#0"), 1, InStr(Format(grilla.TextMatrix(i, 2), "#0"), "-") - 1))) ' Rut
                AddParam Envia, IIf(Format(grilla.TextMatrix(i, 2), "#0") = "-", "", Right(Format(grilla.TextMatrix(i, 2), "#0"), 1)) ' dv
                AddParam Envia, grilla.TextMatrix(i, 7) ' Codigo cliente
                AddParam Envia, grilla.TextMatrix(i, 1) ' Nombre cliente
                AddParam Envia, grilla.TextMatrix(i, 6) ' Moneda
                AddParam Envia, CDbl(grilla.TextMatrix(i, 4)) ' Capital
                AddParam Envia, Format(grilla.TextMatrix(i, 5), "yyyymmdd") ' Fec.Vencimiento
                AddParam Envia, 0
                
                sSQL = "sp_Graba_CREDITOS_IBS"
                If Not Bac_Sql_Execute(sSQL, Envia) Then
                    GrabaCreditos = False
                    MsgBox "Error al grabar registro de creditos", vbCritical + vbOKOnly, "Error"
                    Exit For
                End If
  
            End If
            
        Next
        
End Function

Private Sub EliminarCredito()
    
    For i = 1 To grilla.Rows - 1
        If grilla.TextMatrix(i, grilla.Cols - 1) = "*" Then
            grilla.RemoveItem i
            grilla.AddItem ""
        End If
    Next
    Toolbar1.Buttons(3).Enabled = False
    
End Sub

Private Sub txtDv_KeyPress(KeyAscii As Integer)
   If KeyAscii = vbKeyReturn And Trim(txtDv.Text) <> "" Then
            SendKeys "{TAB}"
            Exit Sub
    End If

  If InStr("0123456789K", UCase(Chr(KeyAscii))) = 0 Then
       KeyAscii = 0
  End If
End Sub

Private Sub txtDv_LostFocus()

    If Not Controla_RUT(txtRut, txtDv) Then
        MsgBox "Rut ingresado no es correcto.", vbExclamation + vbOKOnly, "Dialogo"
        'txtRut.SetFocus
        Exit Sub
       
    End If
'  SendKeys "{tab}"
End Sub

Private Sub txtNombre_DblClick()
   BacAyuda.Tag = "MDCL"
   BacAyuda.Show 1

    If giAceptar% = True Then
        txtRut.Text = gsrut$
        txtDv.Text = gsDigito$
        txtNombre.Text = gsNombre$
        txtRut.Tag = gsValor
        SendKeys "{ENTER}"
        
    End If

End Sub

Private Sub txtNroCredito_GotFocus()
    txtNroCredito.SelStart = 0
    txtNroCredito.SelLength = Len(txtNroCredito.Text)
End Sub

Private Sub txtNroCredito_KeyPress(KeyAscii As Integer)
BacSoloNumeros KeyAscii
 
   If KeyAscii = vbKeyReturn And Trim(txtNroCredito.Text) <> "" Then
      KeyAscii = 0
      SendKeys "{TAB}"

   End If
   
End Sub

Private Sub txtrut_GotFocus()
    txtRut.SelStart = 0
    txtRut.SelLength = Len(txtRut.Text)
End Sub

Private Sub txtRut_KeyPress(KeyAscii As Integer)
BacSoloNumeros KeyAscii
 
    If KeyAscii = vbKeyReturn And Trim(txtRut.Text) <> "" Then
         BuscarCliente CDbl(txtRut.Text)
         KeyAscii = 0
         SendKeys "{TAB}{TAB}{TAB}"
    
    End If
End Sub

Public Function Controla_RUT(tex As Control, tex1 As Control) As Boolean

   Dim Valida As Integer
   Dim idRut$, IdDig$

   idRut$ = tex1
   IdDig$ = tex1

   Valida = True

   If Trim$(idRut$) = "" Or Trim$(IdDig$) = "" Or (Trim$(idRut$) = "0" And Trim$(IdDig$) = "") Then
      Valida = False
   
   End If
    
   If BacValidaRut(tex.Text, tex1.Text) = False Then
      Valida = False

   End If

   Controla_RUT = Valida

End Function

Sub CargaMonedas()
    Dim nRet As Integer
    Dim sSQL As String
    Dim Datos()
    
    sSQL = "Sp_Leer_Moneda"
    If Not Bac_Sql_Execute(sSQL) Then
       Exit Sub
    End If
    Me.cmbMonedas.Clear
    Do While Bac_SQL_Fetch(Datos())
        Me.cmbMonedas.AddItem (Datos(4))
        Me.cmbMonedas.ItemData(cmbMonedas.ListCount - 1) = Datos(1)
    Loop

End Sub

Private Sub BuscarCliente(nRut As Double)
    Dim nRet As Integer
    Dim sSQL As String
    Dim Datos()
    
        Envia = Array()
        AddParam Envia, nRut
        AddParam Envia, 0
        AddParam Envia, 1
        
        sSQL = "SP_MDCLLEERRUT"
        If Not Bac_Sql_Execute(sSQL, Envia) Then
           Exit Sub
        End If

        If Bac_SQL_Fetch(Datos()) Then
            txtRut.Text = Datos(1)
            txtDv.Text = Datos(2)
            txtNombre.Text = Datos(4)
        End If

End Sub

Private Sub txtrut_LostFocus()
    If Not Controla_RUT(txtRut, txtDv) Then
        MsgBox "Rut ingresado no es correcto.", vbExclamation + vbOKOnly, "Dialogo"
        'txtRut.SetFocus
        Exit Sub
       
    End If
End Sub
