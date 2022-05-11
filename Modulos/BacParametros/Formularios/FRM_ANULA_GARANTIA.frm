VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form FRM_ANULA_GARANTIA 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Anulación de Garantías"
   ClientHeight    =   6990
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   12690
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   6990
   ScaleWidth      =   12690
   Begin VB.Frame frmGarantias 
      Caption         =   "Seleccione Garantía"
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
      Height          =   2895
      Left            =   120
      TabIndex        =   20
      Top             =   4080
      Width           =   12495
      Begin MSFlexGridLib.MSFlexGrid grillaSel 
         Height          =   2535
         Left            =   120
         TabIndex        =   21
         Top             =   240
         Width           =   12255
         _ExtentX        =   21616
         _ExtentY        =   4471
         _Version        =   393216
         Cols            =   8
         FixedCols       =   0
         ForeColor       =   8388608
         BackColorFixed  =   8421376
         AllowBigSelection=   0   'False
         HighLight       =   2
         SelectionMode   =   1
         AllowUserResizing=   1
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
   Begin VB.Frame frmGlobal 
      Height          =   3495
      Left            =   0
      TabIndex        =   1
      Top             =   600
      Width           =   6375
      Begin BACControles.TXTNumero txtNumGtia 
         Height          =   255
         Left            =   3720
         TabIndex        =   22
         Top             =   480
         Width           =   1575
         _ExtentX        =   2778
         _ExtentY        =   450
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
         Min             =   "0"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin VB.Frame frmDetalle 
         Caption         =   "Detalle Garantía"
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
         Height          =   2415
         Left            =   120
         TabIndex        =   6
         Top             =   960
         Width           =   6135
         Begin BACControles.TXTFecha txtFechaVigencia 
            Height          =   255
            Left            =   4320
            TabIndex        =   18
            Top             =   1920
            Width           =   1455
            _ExtentX        =   2566
            _ExtentY        =   450
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   8388608
            MaxDate         =   2958465
            MinDate         =   -328716
            Text            =   "18-10-2010"
         End
         Begin BACControles.TXTFecha txtFechaGarantia 
            Height          =   255
            Left            =   2520
            TabIndex        =   17
            Top             =   1920
            Width           =   1335
            _ExtentX        =   2355
            _ExtentY        =   450
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   8388608
            MaxDate         =   2958465
            MinDate         =   -328716
            Text            =   "18-10-2010"
         End
         Begin BACControles.TXTNumero txtValorPresente 
            Height          =   255
            Left            =   120
            TabIndex        =   14
            Top             =   1920
            Width           =   2295
            _ExtentX        =   4048
            _ExtentY        =   450
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
            Text            =   "0"
            Text            =   "0"
            Separator       =   -1  'True
            MarcaTexto      =   -1  'True
         End
         Begin VB.TextBox txtNomCliente 
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
            Locked          =   -1  'True
            TabIndex        =   12
            Top             =   1200
            Width           =   5895
         End
         Begin VB.TextBox txtCodCliente 
            Alignment       =   2  'Center
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
            Left            =   1800
            Locked          =   -1  'True
            TabIndex        =   11
            Top             =   600
            Width           =   735
         End
         Begin VB.TextBox txtRutCliente 
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
            Locked          =   -1  'True
            TabIndex        =   10
            Top             =   600
            Width           =   1455
         End
         Begin VB.Label lblAsociada 
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
            Height          =   675
            Left            =   3480
            TabIndex        =   19
            Top             =   240
            Width           =   2415
            WordWrap        =   -1  'True
         End
         Begin VB.Label Label7 
            AutoSize        =   -1  'True
            Caption         =   "Fecha Vigencia"
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
            Left            =   4320
            TabIndex        =   16
            Top             =   1680
            Width           =   1335
         End
         Begin VB.Label Label6 
            AutoSize        =   -1  'True
            Caption         =   "Fecha Garantía"
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
            Left            =   2520
            TabIndex        =   15
            Top             =   1680
            Width           =   1350
         End
         Begin VB.Label Label5 
            AutoSize        =   -1  'True
            Caption         =   "Valor Presente"
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
            Left            =   120
            TabIndex        =   13
            Top             =   1680
            Width           =   1260
         End
         Begin VB.Label Label4 
            AutoSize        =   -1  'True
            Caption         =   "Nombre Cliente"
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
            Left            =   120
            TabIndex        =   9
            Top             =   960
            Width           =   1305
         End
         Begin VB.Label Label3 
            AutoSize        =   -1  'True
            Caption         =   "Cód. Clte."
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
            Left            =   1800
            TabIndex        =   8
            Top             =   360
            Width           =   855
         End
         Begin VB.Label Label2 
            AutoSize        =   -1  'True
            Caption         =   "Rut Cliente"
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
            Left            =   120
            TabIndex        =   7
            Top             =   360
            Width           =   960
         End
      End
      Begin VB.Frame frmTipoGar 
         Caption         =   "Tipo de Garantía"
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
         Height          =   855
         Left            =   120
         TabIndex        =   3
         Top             =   120
         Width           =   3255
         Begin VB.OptionButton optConstituida 
            Caption         =   "Constituída"
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
            Left            =   1800
            TabIndex        =   5
            Top             =   360
            Width           =   1335
         End
         Begin VB.OptionButton optOtorgada 
            Caption         =   "Otorgada"
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
            Top             =   360
            Width           =   1455
         End
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "N° de la Garantía"
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
         Left            =   3720
         TabIndex        =   2
         Top             =   240
         Width           =   1515
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   12690
      _ExtentX        =   22384
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      DisabledImageList=   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar Anulación"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   8
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   5640
      Top             =   0
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   8
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_ANULA_GARANTIA.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_ANULA_GARANTIA.frx":0EDA
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_ANULA_GARANTIA.frx":11F4
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_ANULA_GARANTIA.frx":20CE
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_ANULA_GARANTIA.frx":2FA8
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_ANULA_GARANTIA.frx":3E82
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_ANULA_GARANTIA.frx":4D5C
            Key             =   ""
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_ANULA_GARANTIA.frx":5C36
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "FRM_ANULA_GARANTIA"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim Asociado_a_que As String
Dim origen As String
Private Sub Form_Load()
Me.Top = 0
Me.Left = 0
Call Limpiar
End Sub
Private Sub FormateaGrillaSel()
With grillaSel
    .FixedRows = 1
    .ColWidth(0) = 800
    .ColWidth(1) = 1300
    .ColWidth(2) = 1000
    .ColWidth(3) = 3000
    .ColWidth(4) = 1300
    .ColWidth(5) = 1300
    .ColWidth(6) = 2000
    .ColWidth(7) = 600
    
    .FixedAlignment(0) = flexAlignRight
    .FixedAlignment(1) = flexAlignLeft
    .FixedAlignment(2) = flexAlignLeft
    .FixedAlignment(3) = flexAlignLeft
    .FixedAlignment(4) = flexAlignLeft
    .FixedAlignment(5) = flexAlignLeft
    .FixedAlignment(6) = flexAlignRight
    .FixedAlignment(7) = flexAlignCenter

    .TextMatrix(0, 0) = "N° Gtía."
    .TextMatrix(0, 1) = "N° Rut Cliente"
    .TextMatrix(0, 2) = "Cód. Clte."
    .TextMatrix(0, 3) = "Nombre Cliente"
    .TextMatrix(0, 4) = "Fecha Gtía."
    .TextMatrix(0, 5) = "Fecha Vigencia"
    .TextMatrix(0, 6) = "Valor Presente"
    .TextMatrix(0, 7) = "Asoc."
    
End With

End Sub

Private Sub Form_Unload(Cancel As Integer)
Exit Sub
End Sub

Private Sub grillaSel_DblClick()
Dim numOp As String
'Dim folioAsociado As Double
Dim Fila As Long
Dim asociado As String
numOp = ""
With grillaSel
    Fila = .Row
    txtNumGtia.Text = .TextMatrix(Fila, 0)
    txtRutCliente.Text = .TextMatrix(Fila, 1)
    txtCodCliente.Text = .TextMatrix(Fila, 2)
    txtNomCliente.Text = .TextMatrix(Fila, 3)
    txtValorPresente.Text = Format(.TextMatrix(Fila, 6), FEntero)
    txtFechaGarantia.Text = .TextMatrix(Fila, 4)
    txtFechaVigencia.Text = .TextMatrix(Fila, 5)
    asociado = .TextMatrix(Fila, 7)
    
    
    If IsNull(asociado) Then
        asociado = ""
        Asociado_a_que = ""
        lblAsociada.Caption = ""
    End If
    If asociado = "" Then
        Asociado_a_que = ""
        lblAsociada.Caption = ""
    Else
        If asociado = "S" Then
            If Me.optConstituida.Value Then
                lblAsociada.Caption = "Garantía Asociada a Operaciones"
                Asociado_a_que = "Operaciones"
            Else
                lblAsociada.Caption = "Garantía Asociada a Ventas Cortas"
                Asociado_a_que = "Ventas Cortas"
            End If
        End If
        If asociado = "N" Then
            lblAsociada.Caption = ""
            Asociado_a_que = ""
        End If
    End If

End With
frmGlobal.Enabled = False
origen = "G"
Toolbar1.Buttons(3).Enabled = True
End Sub

Private Sub optConstituida_Click()
lblAsociada.Visible = True
txtNumGtia.Enabled = True
Toolbar1.Buttons(2).Enabled = True
frmTipoGar.Enabled = False
txtNumGtia.SetFocus
End Sub
Private Sub optOtorgada_Click()
lblAsociada.Visible = True
lblAsociada.Caption = ""
txtNumGtia.Enabled = True
Toolbar1.Buttons(2).Enabled = True
frmTipoGar.Enabled = False
txtNumGtia.SetFocus
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Index
    Case 1
        Call Limpiar
    Case 2
        Call Buscar
    Case 3
        Call Anular
    Case 4
        Unload Me
End Select
End Sub
Private Sub Buscar()
Dim nomSp As String
Dim det As String
Dim Datos()
Dim I As Long
Dim leidas As Long
Envia = Array()
Dim Tipo As String

If optConstituida.Value = False And optOtorgada.Value = False Then
    MsgBox "No ha seleccionado el Tipo de Garantía!", vbExclamation, TITSISTEMA
    Exit Sub
End If

If optConstituida.Value Then
    Tipo = "C"
    det = "Constituídas"
Else
    Tipo = "O"
    det = "Otorgadas"
End If
If txtNumGtia.Text <> "0" Then
    Me.Width = 6510
    Me.Height = 4485
    Call txtNumGtia_KeyPress(13)
    Exit Sub
End If

grillaSel.Clear
Call FormateaGrillaSel
grillaSel.Rows = 2
nomSp = "BacParamSuda.dbo.SP_RET_INFO_GARANTIAS_DETALLE"
AddParam Envia, Tipo
If Not Bac_Sql_Execute(nomSp, Envia) Then
    MsgBox "No es posible obtener el detalle de las Garantías " & det & " !", vbExclamation, titisistema
    Me.Width = 6510
    Me.Height = 4485
    Exit Sub
End If
Me.Width = 12780
Me.Height = 7365
I = 1
leidas = 0

Do While Bac_SQL_Fetch(Datos())
    With grillaSel
        .TextMatrix(I, 0) = Format(Datos(2), FEntero)
        .TextMatrix(I, 1) = Datos(3)
        .TextMatrix(I, 2) = Datos(4)
        .TextMatrix(I, 3) = Datos(5)
        .TextMatrix(I, 4) = Datos(6)
        .TextMatrix(I, 5) = Datos(7)
        .TextMatrix(I, 6) = Format(Datos(8), FEntero)
        If IsNull(Datos(9)) Then
            .TextMatrix(I, 7) = ""
        Else
            .TextMatrix(I, 7) = Datos(9)
        End If
        .Rows = .Rows + 1
    End With
    I = I + 1
    leidas = leidas + 1
Loop
'Borrar la última fila de la grilla
If leidas > 0 Then
    grillaSel.Rows = grillaSel.Rows - 1
End If



    If leidas = 0 Then
        MsgBox "No hay registros de garantias " & det & " para anular ", vbExclamation, "Anulacion de Garantias"
        Exit Sub
    End If

Toolbar1.Buttons(2).Enabled = False
End Sub
Private Sub Limpiar()
Me.Width = 6510
Me.Height = 4485
optConstituida.Value = False
optOtorgada.Value = False
txtNumGtia.Text = "0"
txtRutCliente.Text = ""
txtCodCliente.Text = ""
txtNomCliente.Text = ""
txtValorPresente.Text = 0
txtFechaGarantia.Text = gsbac_fecp
txtFechaVigencia.Text = gsBAC_Fecpx
lblAsociada.Caption = ""
lblAsociada.Visible = False
txtNumGtia.Enabled = False
Toolbar1.Buttons(3).Enabled = False
Asociado_a_que = ""
frmGlobal.Enabled = True
frmTipoGar.Enabled = True
End Sub
Private Sub txtNumGtia_KeyPress(KeyAscii As Integer)
Dim estadoAnula As String
    If KeyAscii = 13 Then
        If optConstituida.Value = False And optOtorgada.Value = False Then
            MsgBox "No ha seleccionado el Tipo de Garantía!", vbExclamation, TITSISTEMA
            Exit Sub
        End If
        txtNumGtia.Enabled = False
        origen = "T"
        Toolbar1.Buttons(3).Enabled = True
        Call InfoGarantia
        If Not frmTipoGar.Enabled Then
            frmGlobal.Enabled = False
        End If
    End If

End Sub
Private Function EstadoAnulacionGtia(Optional ByRef FolioAsoc As Double = 0) As String
Dim nomSp As String
Dim Datos()
Envia = Array()
Dim Numero As Double
If optConstituida.Value Then
    nomSp = "Bacparamsuda.dbo.SP_ESTADO_ANULACION_GARANTIA_CONSTITUIDA"
Else
    nomSp = "Bacparamsuda.dbo.SP_ESTADO_ANULACION_GARANTIA_OTORGADA"
End If
Numero = CDbl(txtNumGtia.Text)
AddParam Envia, Numero
If Not Bac_Sql_Execute(nomSp, Envia) Then
    MsgBox "Ha ocurrido un error y no es posible ejecutar sp " & nomSp, vbCritical, TITSISTEMA
    EstadoAnulacionGtia = "ERROR"
    Exit Function
End If
Do While Bac_SQL_Fetch(Datos())
    If UBound(Datos()) = 2 Then
        EstadoAnulacionGtia = Datos(1)
        FolioAsoc = Datos(2)
    Else
        EstadoAnulacionGtia = Datos(1)
    End If
    Exit Do
Loop
End Function
Private Function InfoGarantia() As Boolean
Dim estadoAnula As String
Dim Existe As Boolean
Dim nomSp As String
Dim folioAsociado As Double
Dim asociado As String
Dim Datos()
Envia = Array()
Existe = False
nomSp = "BacParamsuda.dbo.SP_RET_INFO_GARANTIAS"
If optConstituida.Value Then
    AddParam Envia, "C"
Else
    AddParam Envia, "O"
End If
AddParam Envia, CDbl(txtNumGtia.Text)
If Not Bac_Sql_Execute(nomSp, Envia) Then
    MsgBox "Ha ocurrido un error al ejecutar el sp " & nomSp, vbCritical, TITSISTEMA
    InfoGarantia = False
    Exit Function
End If
InfoGarantia = True
Do While Bac_SQL_Fetch(Datos())
    Existe = True
    txtRutCliente.Text = Datos(3)
    txtCodCliente.Text = Datos(4)
    txtNomCliente.Text = Datos(5)
    txtFechaGarantia.Text = Datos(6)
    txtFechaVigencia.Text = Datos(7)
    txtValorPresente.Text = Datos(8)
    asociado = Datos(9)
    Exit Do
Loop
If Not Existe Then
    MsgBox "La garantía buscada no existe!", vbInformation, TITSISTEMA
    Call Limpiar
    frmTipoGar.Enabled = True
    Exit Function
End If
If IsNull(asociado) Then
    asociado = ""
    Asociado_a_que = ""
    lblAsociada.Caption = ""
End If
If asociado = "" Then
    Asociado_a_que = ""
    lblAsociada.Caption = ""
Else
    If asociado = "S" Then
        If Me.optConstituida.Value Then
            lblAsociada.Caption = "Garantía Asociada a Operaciones"
            Asociado_a_que = "Operaciones"
        Else
            lblAsociada.Caption = "Garantía Asociada a Ventas Cortas"
            Asociado_a_que = "Ventas Cortas"
        End If
    End If
    If asociado = "N" Then
        lblAsociada.Caption = ""
        Asociado_a_que = ""
    End If
End If

End Function
Private Function Anular() As Boolean
Dim estadoAnula As String
Dim msgError As String




    If Me.grillaSel.TextMatrix(grillaSel.RowSel, 0) = "" Then
        Exit Function
    End If
    
    If Asociado_a_que <> "" Then
    
        MsgBox "La Garantía no se puede anular por estar asociada a " & Asociado_a_que & "!", vbExclamation, TITSISTEMA
        Anular = False
        
        If origen = "G" Then
            grillaSel.SetFocus
        ElseIf txtNumGtia.Enabled Then
            txtNumGtia.SetFocus
        End If
        
        Exit Function
        
    End If

    
    
    Anular = True
    
    If MsgBox("¿Confirma la Anulación de la Garantía?", vbYesNo) = vbYes Then
        'ANULAR LA GARANTIA
        If AnulaGarantia(msgError) Then
            MsgBox "La garantía se ha anulado en forma exitosa!", vbInformation, TITSISTEMA
            Call Limpiar
            Anular = True
            Exit Function
        Else
            MsgBox "Ha ocurrido un error al anular la garantía:" & vbCrLf & vbCrLf & msgError, vbExclamation, TITSISTEMA
            Call Limpiar
            Anular = False
            Exit Function
        End If
    ElseIf origen = "G" Then
        grillaSel.SetFocus
    Else
        Call Limpiar
    End If


End Function
Private Function AnulaGarantia(ByRef salidaError As String) As Boolean
Dim numAnular As Double
Dim resultado As String
Dim nomSp As String
Dim nomspO As String
Dim nomSpC As String
nomspO = "Bacparamsuda.dbo.SP_ELIMINA_GARANTIA_OTORGADA"
nomSpC = "Bacparamsuda.dbo.SP_ELIMINA_GARANTIA_CONSTITUIDA"
Dim Datos()
Envia = Array()
numAnular = CDbl(txtNumGtia.Text)
If optOtorgada.Value Then
    nomSp = nomspO
Else
    nomSp = nomSpC
End If

AnulaGarantia = True
AddParam Envia, numAnular
If Not BacBeginTransaction Then
   AnulaGarantia = False
   salidaError = "Error de acceso al servidor."
   Exit Function
End If

'Antes de anular, se debe devolver los montos usados al tomar las líneas!
'Solo para las garantías constituídas
If optConstituida.Value Then
    If Not DevolverLineasGarantia(numAnular, salidaError) Then
        AnulaGarantia = False
        If Not BacRollBackTransaction Then
            salidaError = "Error de acceso al servidor."
        End If
        Exit Function
    End If
End If
If Not Bac_Sql_Execute(nomSp, Envia) Then
    If Not Bac_Sql_Execute("ROLLBACK") Then
        AnulaGarantia = False
        salidaError = "Error de acceso al servidor."
    End If
    AnulaGarantia = False
    salidaError = "Error de acceso al servidor."
Else
    If Not BacCommitTransaction Then
        AnulaGarantia = False
        salidaError = "Error de acceso al servidor."
    End If
End If
End Function
Private Function DevolverLineasGarantia(ByVal Numero As Double, ByRef msgFalla As String) As Boolean
Dim nomSp As String
Dim txtSal As String
nomSp = "BacLineas.dbo.SP_DEVOLVER_LINEAS_POR_NUMGARANTIA"
Dim Datos()
Envia = Array()
AddParam Envia, Numero
If Not Bac_Sql_Execute(nomSp, Envia) Then
    msgFalla = "Error de acceso al servidor con sp: " & nomSp
    DevolverLineasGarantia = False
    Exit Function
End If
Do While Bac_SQL_Fetch(Datos())
    txtSal = IIf(IsNull(Datos(1)), "OK", Datos(1))
    Exit Do
Loop
If Trim(txtSal) = "" Then
    txtSal = "OK"
End If
If Trim(txtSal) = "OK" Then
    DevolverLineasGarantia = True
    msgFalla = ""
Else
    DevolverLineasGarantia = False
    msgFalla = Mid$(txtSal, 4)
End If
End Function
