VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form FRM_MNT_CLAVES 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Ingreso de claves para el DCV."
   ClientHeight    =   4425
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   7005
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4425
   ScaleWidth      =   7005
   StartUpPosition =   2  'CenterScreen
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   7005
      _ExtentX        =   12356
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.Visible         =   0   'False
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Cerrar"
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   5355
         Top             =   60
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   22
         ImageHeight     =   22
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   3
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_CLAVES.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_CLAVES.frx":0EDA
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_CLAVES.frx":1DB4
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame Frame1 
      Height          =   3990
      Left            =   0
      TabIndex        =   1
      Top             =   435
      Width           =   7005
      Begin VB.TextBox txtIngreso 
         BackColor       =   &H80000002&
         BorderStyle     =   0  'None
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000009&
         Height          =   225
         Left            =   3990
         TabIndex        =   3
         Top             =   540
         Width           =   855
      End
      Begin MSFlexGridLib.MSFlexGrid Grid 
         Height          =   3810
         Left            =   45
         TabIndex        =   2
         Top             =   135
         Width           =   6915
         _ExtentX        =   12197
         _ExtentY        =   6720
         _Version        =   393216
         Cols            =   7
         FixedCols       =   0
         RowHeightMin    =   300
         BackColor       =   -2147483644
         BackColorFixed  =   -2147483646
         ForeColorFixed  =   -2147483639
         FocusRect       =   0
         GridLines       =   2
         GridLinesFixed  =   0
         FormatString    =   ""
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Verdana"
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
Attribute VB_Name = "FRM_MNT_CLAVES"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Public Operacion     As Variant
Public Sistema       As Variant

Private Sub Form_Activate()
   Call BuscarDatos
   Grid.SetFocus
End Sub

Private Sub Form_Load()
   Me.Icon = BACSwapParametros.Icon
   
   Grid.Cols = 7
   Grid.Rows = 2
   Grid.TextMatrix(0, 0) = "Operacion"
   Grid.TextMatrix(0, 1) = "Documento"
   Grid.TextMatrix(0, 2) = "Correlativo"
   Grid.TextMatrix(0, 3) = "Serie Bursatil"
   Grid.TextMatrix(0, 4) = "Monto Nominal"
   Grid.TextMatrix(0, 5) = "Custodia"
   Grid.TextMatrix(0, 6) = "Clave Instrumento"
   
   Grid.AllowUserResizing = flexResizeColumns
   Grid.ColWidth(0) = 0
   Grid.ColWidth(1) = 0
   Grid.ColWidth(2) = 0
   
   Grid.ColWidth(3) = 1500
   Grid.ColWidth(4) = 2000
   Grid.ColWidth(5) = 1000
   Grid.ColWidth(6) = 2000

   Grid.ColAlignment(6) = flexAlignLeftCenter
   
   txtIngreso.Visible = False
   txtIngreso.MaxLength = 10
End Sub

Private Sub BuscarDatos()
   On Error GoTo ErrorCarga
   Dim Datos()
   
   If Operacion = Empty Then
      MsgBox "Debe seleccionar una operación para asignar claves", vbExclamation, TITSISTEMA
      Exit Sub
   End If
   
   Envia = Array()
   AddParam Envia, "C"
   AddParam Envia, CDbl(Operacion)
   If Not Bac_Sql_Execute("SP_CARGA_CLAVES_DCV", Envia) Then
      GoTo ErrorCarga
   End If
   Grid.Rows = 1
   Do While Bac_SQL_Fetch(Datos())
      Grid.Rows = Grid.Rows + 1
      Grid.TextMatrix(Grid.Rows - 1, 0) = Datos(1)                      ' Operacion
      Grid.TextMatrix(Grid.Rows - 1, 1) = Datos(2)                      ' Documento
      Grid.TextMatrix(Grid.Rows - 1, 2) = Datos(3)                      ' Correlativo
      Grid.TextMatrix(Grid.Rows - 1, 3) = Datos(4)                      ' Serie
      Grid.TextMatrix(Grid.Rows - 1, 4) = Format(Datos(5), FDecimal)    ' Nominal
      Grid.TextMatrix(Grid.Rows - 1, 5) = "D"                           ' Custodia
      Grid.TextMatrix(Grid.Rows - 1, 6) = Datos(7)                      ' Clave
   Loop
Exit Sub
ErrorCarga:
   MsgBox Err.Description, vbExclamation, TITSISTEMA
   Resume
End Sub

Private Sub Grid_KeyDown(KeyCode As Integer, Shift As Integer)
   If Grid.ColSel = 6 Then
      If KeyCode = vbKeyReturn Then
         Call PROC_POSI_TEXTO(Grid, txtIngreso)
         Grid.Enabled = False
         Toolbar1.Buttons(2).Enabled = False
         Toolbar1.Buttons(3).Enabled = False
         txtIngreso.Text = Grid.TextMatrix(Grid.RowSel, Grid.ColSel)
         txtIngreso.Visible = True
         txtIngreso.SetFocus
      End If
   End If
End Sub

Private Sub lstDCV_DblClick()
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 2
         Call GrabarDatos
      Case 3
         Unload Me
   End Select
End Sub

Private Sub GrabarDatos()
   Dim Contador   As Long
   
   Call Bac_Sql_Execute("BEGIN TRANSACTION")
   
   For Contador = 1 To Grid.Rows - 1
      Envia = Array()
      AddParam Envia, "A"
      AddParam Envia, CDbl(Grid.TextMatrix(Contador, 0))
      AddParam Envia, CDbl(Grid.TextMatrix(Contador, 1))
      AddParam Envia, CDbl(Grid.TextMatrix(Contador, 2))
      AddParam Envia, CStr(Grid.TextMatrix(Contador, 6))
      If Not Bac_Sql_Execute("SP_CARGA_CLAVES_DCV", Envia) Then
         Call Bac_Sql_Execute("ROLLBACK TRANSACTION")
      End If
   Next Contador
   
   Call Bac_Sql_Execute("COMMIT TRANSACTION")
   
   MsgBox "Actualización de claves a finalizado en forma correcta", vbInformation, TITSISTEMA
   
   Unload Me
End Sub

Private Sub txtIngreso_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyReturn Then
      Grid.TextMatrix(Grid.RowSel, Grid.ColSel) = txtIngreso.Text
      txtIngreso.Visible = False
      Toolbar1.Buttons(2).Enabled = True
      Toolbar1.Buttons(3).Enabled = True
      Grid.Enabled = True
      Grid.SetFocus
   End If
End Sub

Private Sub txtIngreso_KeyPress(KeyAscii As Integer)
   KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub
