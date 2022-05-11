VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "Msflxgrd.ocx"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form Inf_Vencimiento_Garantias 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Informes de Vencimiento de Garantías"
   ClientHeight    =   8055
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   12330
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   8055
   ScaleWidth      =   12330
   Begin VB.CommandButton cmdBuscar 
      Caption         =   "Buscar"
      Height          =   375
      Left            =   4320
      TabIndex        =   12
      Top             =   1380
      Visible         =   0   'False
      Width           =   1335
   End
   Begin VB.Frame Frame2 
      Height          =   5655
      Left            =   0
      TabIndex        =   10
      Top             =   1920
      Width           =   12255
      Begin VB.Frame Frame4 
         Caption         =   "Total Valor Presente"
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
         Height          =   615
         Left            =   8880
         TabIndex        =   14
         Top             =   4920
         Width           =   3255
         Begin VB.TextBox txtTotPresente 
            Alignment       =   1  'Right Justify
            BackColor       =   &H00FFFFFF&
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
            Height          =   285
            Left            =   120
            TabIndex        =   16
            Top             =   240
            Width           =   3015
         End
      End
      Begin VB.Frame Frame3 
         Caption         =   "Total Valor Nominal"
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
         Height          =   615
         Left            =   5280
         TabIndex        =   13
         Top             =   4920
         Width           =   3255
         Begin VB.TextBox txtTotNominal 
            Alignment       =   1  'Right Justify
            BackColor       =   &H00FFFFFF&
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
            Height          =   285
            Left            =   120
            TabIndex        =   15
            Top             =   240
            Width           =   3015
         End
      End
      Begin MSFlexGridLib.MSFlexGrid grilla 
         Height          =   4695
         Left            =   120
         TabIndex        =   11
         Top             =   240
         Width           =   12015
         _ExtentX        =   21193
         _ExtentY        =   8281
         _Version        =   393216
         Cols            =   8
         FixedCols       =   0
         ForeColor       =   8388608
         BackColorFixed  =   8421376
         ForeColorFixed  =   16777215
         BackColorSel    =   -2147483643
         ForeColorSel    =   -2147483635
         AllowBigSelection=   0   'False
         SelectionMode   =   1
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
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   9
      Top             =   0
      Width           =   12330
      _ExtentX        =   21749
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
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "A pantalla"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "A impresora"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   4
         EndProperty
      EndProperty
   End
   Begin VB.Frame Frame1 
      Caption         =   "Fecha de vencimiento"
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
      Height          =   615
      Left            =   1920
      TabIndex        =   7
      Top             =   1200
      Width           =   2175
      Begin BACControles.TXTFecha txtFechaVcto 
         Height          =   255
         Left            =   480
         TabIndex        =   8
         Top             =   240
         Width           =   1335
         _ExtentX        =   2355
         _ExtentY        =   450
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
         Text            =   "26-07-2010"
      End
   End
   Begin VB.Frame frmUsuario 
      Caption         =   "Seleccione Cliente"
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
      Height          =   615
      Left            =   1920
      TabIndex        =   5
      Top             =   600
      Width           =   8895
      Begin VB.TextBox txtNomCliente 
         BackColor       =   &H00FFFFFF&
         Enabled         =   0   'False
         Height          =   285
         Left            =   2520
         TabIndex        =   6
         Top             =   240
         Width           =   6255
      End
      Begin VB.TextBox txtRutCliente 
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
         Height          =   285
         Left            =   120
         MaxLength       =   9
         MousePointer    =   14  'Arrow and Question
         TabIndex        =   0
         Top             =   240
         Width           =   1575
      End
      Begin VB.TextBox txtCodCliente 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00FFFFFF&
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
         Height          =   285
         Left            =   1800
         MaxLength       =   3
         TabIndex        =   1
         Top             =   240
         Width           =   615
      End
   End
   Begin VB.Frame fraTipoGar 
      Caption         =   "Tipo de Garantías"
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
      Height          =   1215
      Left            =   0
      TabIndex        =   2
      Top             =   600
      Width           =   1815
      Begin VB.OptionButton optConstituida 
         Caption         =   "Constituídas"
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
         Left            =   120
         TabIndex        =   4
         Top             =   720
         Value           =   -1  'True
         Width           =   1455
      End
      Begin VB.OptionButton optOtorgada 
         Caption         =   "Otorgadas"
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
         Left            =   120
         TabIndex        =   3
         Top             =   360
         Width           =   1455
      End
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   10080
      Top             =   240
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
            Picture         =   "Inf_Vencimiento_Garantias.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Inf_Vencimiento_Garantias.frx":0324
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Inf_Vencimiento_Garantias.frx":11FE
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Inf_Vencimiento_Garantias.frx":20D8
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "Inf_Vencimiento_Garantias"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private objCliente As Object
Private Sub FormateaGrilla()
With grilla
    .FixedRows = 1
    .ColWidth(0) = 1000
    .ColWidth(1) = 1200
    .ColWidth(2) = 1500
    .ColWidth(3) = 1500
    .ColWidth(4) = 1000
    .ColWidth(5) = 1800
    .ColWidth(6) = 1300
    .ColWidth(7) = 2200
    
       
    .FixedAlignment(0) = flexAlignRight
    .FixedAlignment(1) = flexAlignLeft
    .FixedAlignment(2) = flexAlignLeft
    .FixedAlignment(3) = flexAlignLeft
    .FixedAlignment(4) = flexAlignCenter
    .FixedAlignment(5) = flexAlignRight
    .FixedAlignment(6) = flexAlignRight
    .FixedAlignment(7) = flexAlignRight
    
    
    .TextMatrix(0, 0) = "N° de Gtía."
    .TextMatrix(0, 1) = "N° Docto."
    .TextMatrix(0, 2) = "Nemotécnico"
    .TextMatrix(0, 3) = "Fecha Vigencia"
    .TextMatrix(0, 4) = "Moneda"
    .TextMatrix(0, 5) = "Valor Nominal"
    .TextMatrix(0, 6) = "TIR"
    .TextMatrix(0, 7) = "Valor Presente"
End With
End Sub
Private Sub cmdBuscar_Click()
Dim Fila As Long
Dim acumNominal As Double
Dim acumPresente As Double
Dim Datos()
Envia = Array()
AddParam Envia, CLng(txtRutCliente.Text)
AddParam Envia, CInt(txtCodCliente.Text)
AddParam Envia, txtFechaVcto.Text
If optConstituida.Value Then
    AddParam Envia, "C"     'Constituidas
Else
    AddParam Envia, "O"     'Otorgadas
End If
If Not Bac_Sql_Execute("Bacparamsuda.dbo.SP_INFORME_GARANTIASPORTIPO", Envia) Then
    MsgBox "Error al buscar las Garantías por Tipo!", vbExclamation, TITSISTEMA
    Exit Sub
End If
Fila = 1
acumNominal = 0#
acumPresente = 0#
grilla.Rows = 2
Do While Bac_SQL_Fetch(Datos())
    With grilla
        .TextMatrix(Fila, 0) = Format(Datos(5), FEntero)
        .TextMatrix(Fila, 1) = Datos(6)
        .TextMatrix(Fila, 2) = Datos(9)
        .TextMatrix(Fila, 3) = Datos(7)
        .TextMatrix(Fila, 4) = Datos(8)
        .TextMatrix(Fila, 5) = Format(Datos(10), FDecimal)
        .TextMatrix(Fila, 6) = Format(Datos(11), FDecimal)
        .TextMatrix(Fila, 7) = Format(Datos(12), FDecimal)
        acumNominal = acumNominal + CDbl(Datos(10))
        txtTotNominal.Text = Format(acumNominal, FDecimal)
        acumPresente = acumPresente + CDbl(Datos(12))
        txtTotPresente.Text = Format(acumPresente, FDecimal)
    End With
    Fila = Fila + 1
    grilla.Rows = grilla.Rows + 1
Loop
'If grilla.Rows > 2 Then
'    grilla.Rows = grilla.Rows - 1
'End If
End Sub
Private Sub Form_Load()
Me.Top = 0
Me.Left = 0
Set objCliente = New clsCliente
Call FormateaGrilla
txtFechaVcto.Text = gsbac_fecp
End Sub

Private Sub Form_Unload(Cancel As Integer)
Set objCliente = Nothing
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Index
    Case 1  'Limpiar
        Call Limpiar
    Case 2  'Pantalla Crystal
        Call Imprime(0)
    Case 3  'Impresora
        Call Imprime(1)
    Case 4  'Salir
        Unload Me
End Select
End Sub
Private Function FilaVacia(ByVal nFila As Long) As Boolean
Dim i As Long
Dim v As Long
v = 0
For i = 0 To grilla.Cols - 1
    If Trim(grilla.TextMatrix(nFila, i)) = "" Then
        v = v + 1
    End If
Next i
If v = grilla.Cols Then
    FilaVacia = True
Else
    FilaVacia = False
End If
End Function
Private Function Imprime(ByVal destino As Integer) As Boolean
'destino = 0  --> Pantalla
'destino = 1 ---> Impresora
Dim tipoGar As String
On Error GoTo Control:
   If grilla.Rows = 2 Then
        If FilaVacia(1) Then
            Exit Function
        End If
   End If
   If Trim(txtNomCliente.Text) = "" Then
        Exit Function
   End If
   Call limpiar_cristal
   Screen.MousePointer = vbHourglass
   If destino = 0 Then
        BACSwapParametros.BACParam.Destination = crptToWindow
   Else
        BACSwapParametros.BACParam.Destination = crptToPrinter
   End If
   If optConstituida.Value Then
        tipoGar = "C"
   Else
        tipoGar = "O"
   End If

   BACSwapParametros.BACParam.ReportFileName = gsRPT_Path & "BacInformeVctoGtias.rpt"
   BACSwapParametros.BACParam.WindowTitle = "INFORME DE VENCIMIENTO DE GARANTIAS"
   BACSwapParametros.BACParam.StoredProcParam(0) = CLng(txtRutCliente.Text)
   BACSwapParametros.BACParam.StoredProcParam(1) = CInt(txtCodCliente.Text)
   BACSwapParametros.BACParam.StoredProcParam(2) = Format(txtFechaVcto.Text, "yyyy-mm-dd 00:00:00.000")
   BACSwapParametros.BACParam.StoredProcParam(3) = tipoGar
   BACSwapParametros.BACParam.Connect = SwConeccion
   BACSwapParametros.BACParam.WindowState = crptMaximized
   BACSwapParametros.BACParam.Action = 1
   Screen.MousePointer = vbDefault

Exit Function

Control:

    MsgBox "Se ha producido un error al generar Listado. " & Err.Description & ", " & Err.Number, vbCritical, "BACPARAMETROS"
    Screen.MousePointer = 0

End Function
Private Sub Limpiar()
    optConstituida.Value = True
    txtRutCliente.Text = ""
    txtCodCliente.Text = ""
    txtNomCliente.Text = ""
    grilla.Clear
    grilla.Rows = 2
    Call FormateaGrilla
    txtTotNominal.Text = ""
    txtTotPresente.Text = ""
    txtFechaVcto.Text = gsbac_fecp
    cmdBuscar.Value = False
End Sub

Private Sub txtCodCliente_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        SendKeys "{TAB}"
    End If
    If Not (KeyAscii > 47 And KeyAscii < 58 Or KeyAscii = 8) Then
        KeyAscii = 0
        BacCaracterNumerico KeyAscii
    End If
End Sub

Private Sub txtCodCliente_LostFocus()
    If Trim(txtRutCliente.Text) = "" Then
        Exit Sub
    End If
    If Trim(Me.txtCodCliente.Text) = "" Then
        Exit Sub
    End If
    objCliente.clrut = txtRutCliente.Text
    objCliente.clcodigo = txtCodCliente.Text
    If objCliente.LeerPorRut(objCliente.clrut, objCliente.clcodigo) Then
        txtRutCliente.Text = objCliente.clrut
        txtCodCliente.Text = objCliente.clcodigo
        txtNomCliente.Text = objCliente.clnombre
    Else
        Call Limpiar
        MsgBox "Atención!, el cliente buscado no existe.", vbExclamation, TITSISTEMA
        txtRutCliente.Text = ""
        txtCodCliente.Text = ""
        txtNomCliente.Text = ""
        txtRutCliente.SetFocus
        Exit Sub
    End If
    cmdBuscar.Visible = True
End Sub

Private Sub txtRutCliente_DblClick()
    'BacAyuda.Tag = "MDCL"
    'BacAyuda.Show 1
    'ARM se implementa nuevo formulario de ayuda
    BacAyudaCliente.Tag = "MDL"
    BacAyudaCliente.Show 1
    
    If giAceptar% = True Then
        txtRutCliente.Text = Val(gsrut$)
        txtCodCliente.Text = gsValor$
        txtNomCliente.Text = gsDescripcion$
        cmdBuscar.Visible = True
    End If
End Sub

Private Sub txtRutCliente_KeyPress(KeyAscii As Integer)
 If KeyAscii = 13 Then
        If Trim(txtRutCliente.Text) = "" Then
            Exit Sub
        End If
        SendKeys "{TAB}"
    End If
    If Not (KeyAscii > 47 And KeyAscii < 58 Or KeyAscii = 8) Then
        KeyAscii = 0
        BacCaracterNumerico KeyAscii
    End If
End Sub

