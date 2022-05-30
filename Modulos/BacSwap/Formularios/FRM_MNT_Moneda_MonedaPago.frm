VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Begin VB.Form FRM_MNT_Moneda_MonedaPago 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantenedor de Monedas de Pago por Moneda."
   ClientHeight    =   4440
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   6690
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   4440
   ScaleWidth      =   6690
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   5535
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
            Picture         =   "FRM_MNT_Moneda_MonedaPago.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MNT_Moneda_MonedaPago.frx":0EDA
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MNT_Moneda_MonedaPago.frx":1DB4
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MNT_Moneda_MonedaPago.frx":2C8E
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MNT_Moneda_MonedaPago.frx":3B68
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   6690
      _ExtentX        =   11800
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   5
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.Visible         =   0   'False
            Key             =   "Limpiar"
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.Visible         =   0   'False
            Key             =   "Buscar"
            Object.ToolTipText     =   "Buscar Información"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Grabar"
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Eliminar"
            Object.ToolTipText     =   "Eliminar"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Cerrar"
            Object.ToolTipText     =   "Cerrar"
            ImageIndex      =   5
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin VB.Frame fraMoneda 
      Height          =   705
      Left            =   0
      TabIndex        =   1
      Top             =   435
      Width           =   6690
      Begin VB.ComboBox cmbSistema 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   45
         Style           =   2  'Dropdown List
         TabIndex        =   10
         ToolTipText     =   "Moneda Seleccionada para la Asignación de Tasas."
         Top             =   330
         Width           =   2250
      End
      Begin VB.ComboBox cmbMoneda 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   2430
         Style           =   2  'Dropdown List
         TabIndex        =   7
         ToolTipText     =   "Moneda Seleccionada para la Asignación de Tasas."
         Top             =   330
         Width           =   4140
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "Sistema"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Left            =   60
         TabIndex        =   9
         Top             =   120
         Width           =   690
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Moneda de la Operación"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Left            =   2445
         TabIndex        =   8
         Top             =   120
         Width           =   2025
      End
   End
   Begin VB.Frame FraDetalle 
      Height          =   3375
      Left            =   0
      TabIndex        =   2
      Top             =   1065
      Width           =   6690
      Begin VB.ListBox LstMonedasOut 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   2985
         Left            =   45
         MultiSelect     =   2  'Extended
         TabIndex        =   6
         Top             =   330
         Width           =   2805
      End
      Begin VB.ListBox LstMonedaIn 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00008000&
         Height          =   2985
         Left            =   3795
         MultiSelect     =   2  'Extended
         TabIndex        =   5
         Top             =   330
         Width           =   2805
      End
      Begin VB.CommandButton cmdIn 
         Caption         =   ">>"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Left            =   3075
         TabIndex        =   4
         Top             =   1260
         Width           =   495
      End
      Begin VB.CommandButton cmdOut 
         Caption         =   "<<"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Left            =   3075
         TabIndex        =   3
         Top             =   1860
         Width           =   495
      End
      Begin VB.Label Label4 
         AutoSize        =   -1  'True
         Caption         =   "Monedas Asignadas para Pago"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Left            =   3825
         TabIndex        =   12
         Top             =   120
         Width           =   2580
      End
      Begin VB.Label Label3 
         AutoSize        =   -1  'True
         Caption         =   "Monedas Disponibles"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Left            =   60
         TabIndex        =   11
         Top             =   135
         Width           =   1770
      End
   End
End
Attribute VB_Name = "FRM_MNT_Moneda_MonedaPago"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private Sub CargaSistema(ObjCarga As Object)
   Dim Datos()
   
   Envia = Array()
   AddParam Envia, "S"
   If Not Bac_Sql_Execute("SP_MNT_MONEDA_PAGO_POR_MONEDA", Envia) Then
      Exit Sub
   End If
   ObjCarga.Clear
   Do While Bac_SQL_Fetch(Datos())
      ObjCarga.AddItem Datos(2) & Space(50) & Datos(1)
   Loop
End Sub

Private Sub CargaMonedas(ObjCarga As Object)
   Dim Datos()
   
   Envia = Array()
   AddParam Envia, "M"
   If Not Bac_Sql_Execute("SP_MNT_MONEDA_PAGO_POR_MONEDA", Envia) Then
      Exit Sub
   End If
   ObjCarga.Clear
   Do While Bac_SQL_Fetch(Datos())
      ObjCarga.AddItem Datos(3)
      ObjCarga.ItemData(ObjCarga.NewIndex) = Datos(1)
   Loop
End Sub

Private Sub cmbMoneda_Change()
   Call CargaMonedas(LstMonedasOut)
   Call CargaMonedaPagoExistentes
End Sub

Private Sub cmbMoneda_Click()
   
   Call CargaMonedas(LstMonedasOut)
   
   LstMonedasOut.Enabled = True
   LstMonedaIn.Enabled = True
   cmdIn.Enabled = True
   cmdOut.Enabled = True
   
   Call CargaMonedaPagoExistentes
End Sub

Private Sub cmbSistema_Click()
   Call CargaMonedaPagoExistentes
End Sub

Private Sub cmdIn_Click()
   Dim iContador  As Integer
   Dim iCont2     As Integer
   
   
   For iContador = 0 To LstMonedasOut.ListCount - 1
      If LstMonedasOut.Selected(iContador) = True Then
         LstMonedaIn.AddItem LstMonedasOut.List(iContador)
         LstMonedaIn.ItemData(LstMonedaIn.NewIndex) = LstMonedasOut.ItemData(iContador)
      End If
   Next iContador
   
   For iContador = 0 To LstMonedaIn.ListCount - 1
      For iCont2 = 0 To LstMonedasOut.ListCount - 1
         If LstMonedaIn.ItemData(iContador) = LstMonedasOut.ItemData(iCont2) Then
            LstMonedasOut.RemoveItem iCont2
            Exit For
         End If
      Next iCont2
   Next iContador
End Sub

Private Sub cmdOut_Click()
   Dim iContador  As Integer
   Dim iCont2     As Integer
   
   For iContador = 0 To LstMonedaIn.ListCount - 1
      If LstMonedaIn.Selected(iContador) = True Then
         LstMonedasOut.AddItem LstMonedaIn.List(iContador)
         LstMonedasOut.ItemData(LstMonedasOut.NewIndex) = LstMonedaIn.ItemData(iContador)
      End If
   Next iContador
   
   For iContador = 0 To LstMonedasOut.ListCount - 1
      For iCont2 = 0 To LstMonedaIn.ListCount - 1
         If LstMonedasOut.ItemData(iContador) = LstMonedaIn.ItemData(iCont2) Then
            LstMonedaIn.RemoveItem iCont2
            Exit For
         End If
      Next iCont2
   Next iContador
End Sub

Private Sub Limpiar()
   LstMonedaIn.Enabled = False
   LstMonedasOut.Enabled = False
   cmdIn.Enabled = False
   cmdOut.Enabled = False
End Sub

Private Sub Form_Activate()
   If cmbSistema.Enabled = True Then
      cmbSistema.SetFocus
   End If
End Sub

Private Sub Form_Load()
   Me.Icon = BACSwap.Icon
   Me.Top = 0: Me.Left = 0
   
   Call CargaSistema(cmbSistema)
   Call CargaMonedas(cmbMoneda)
   
   Call Limpiar
End Sub

Private Sub CargaMonedaPagoExistentes()
   Dim Datos()
   Dim cSistema   As String
   Dim iMoneda    As Integer
   Dim iContador  As Integer
   
   If cmbMoneda.ListIndex = -1 Or Me.cmbMoneda.ListIndex = -1 Then
      Exit Sub
   End If
   
   cSistema = Right(cmbSistema.Text, 3)
   iMoneda = cmbMoneda.ItemData(cmbMoneda.ListIndex)
   
   Call CargaMonedas(LstMonedasOut)
   
   Envia = Array()
   AddParam Envia, "C"
   AddParam Envia, CStr(cSistema)
   AddParam Envia, CDbl(iMoneda)
   If Not Bac_Sql_Execute("SP_MNT_MONEDA_PAGO_POR_MONEDA", Envia) Then
      Exit Sub
   End If
   LstMonedaIn.Clear
   Do While Bac_SQL_Fetch(Datos())
      LstMonedaIn.AddItem Datos(5)
      LstMonedaIn.ItemData(LstMonedaIn.NewIndex) = Val(Datos(4))
      
      For iContador = 0 To LstMonedasOut.ListCount - 1
         If LstMonedasOut.ItemData(iContador) = Datos(4) Then
            LstMonedasOut.RemoveItem (iContador)
            Exit For
         End If
      Next iContador
   Loop
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 1 'Limpiar
      Case 2 'Buscar
      Case 3 'Grabar
         Call Grabar
      Case 4 'Eliminar
         Call Eliminar
      Case 5 'Cerrar
         Unload Me
   End Select
End Sub

Private Sub Eliminar()
   On Error GoTo ErrorGuardar
   Dim iContador  As Long
   Dim Datos()
   Dim cSistema   As String
   Dim iMoneda    As Integer
   Dim cNemoMon   As String
   Dim cNemoSist  As String
   Dim iMonedaPag As Integer
   
   If cmbSistema.ListIndex = -1 Or cmbMoneda.ListIndex = -1 Then
      Exit Sub
   End If
   
   cSistema = Right(cmbSistema.Text, 3)
   iMoneda = cmbMoneda.ItemData(cmbMoneda.ListIndex)
   
   cNemoSist = Trim(Left(cmbSistema.Text, (Len(cmbSistema.Text) - 3)))
   cNemoMon = Trim(cmbMoneda.Text)
  
   If MsgBox("¿ Se Encuentra Segúro de Eliminar Permanentemente las Monedas de Pago para el Sistema " & vbCrLf & cNemoSist & " y la Moneda " & cNemoMon & " ?", vbQuestion + vbYesNo, TITSISTEMA) = vbNo Then
      Exit Sub
   End If
  
   Envia = Array()
   AddParam Envia, CStr("E") 'Eliminar
   AddParam Envia, CStr(cSistema)
   AddParam Envia, CDbl(iMoneda)
   If Not Bac_Sql_Execute("SP_MNT_MONEDA_PAGO_POR_MONEDA", Envia) Then
      GoTo ErrorGuardar
   End If
   
   MsgBox "¡ La información ha sido borrada correctamente. !", vbInformation, TITSISTEMA
   On Error GoTo 0
   
Exit Sub
ErrorGuardar:
   On Error GoTo 0
   MsgBox "¡ Se ha producido un error al borrar la información.!", vbExclamation, TITSISTEMA
End Sub

Private Sub Grabar()
   On Error GoTo ErrorGuardar
   
   Dim iContador  As Long
   Dim Datos()
   Dim cSistema   As String
   Dim iMoneda    As Integer
   Dim iMonedaPag As Integer
   
   If cmbMoneda.ListIndex = -1 Or Me.cmbMoneda.ListIndex = -1 Then
      Exit Sub
   End If
   
   cSistema = Right(cmbSistema.Text, 3)
   iMoneda = cmbMoneda.ItemData(cmbMoneda.ListIndex)
   
   Call Bac_Sql_Execute("Begin Transaction")
  
   Envia = Array()
   AddParam Envia, CStr("E") 'Eliminar
   AddParam Envia, CStr(cSistema)
   AddParam Envia, CDbl(iMoneda)
   If Not Bac_Sql_Execute("SP_MNT_MONEDA_PAGO_POR_MONEDA", Envia) Then
      GoTo ErrorGuardar
   End If
   
   For iContador = 0 To LstMonedaIn.ListCount - 1
      iMonedaPag = LstMonedaIn.ItemData(iContador)
      
      Envia = Array()
      AddParam Envia, CStr("G") 'Grabar
      AddParam Envia, CStr(cSistema)
      AddParam Envia, CDbl(iMoneda)
      AddParam Envia, CDbl(iMonedaPag)
      If Not Bac_Sql_Execute("SP_MNT_MONEDA_PAGO_POR_MONEDA", Envia) Then
         GoTo ErrorGuardar
      End If
   Next iContador
   
   MsgBox "¡ La información ha sido grabada correctamente. !", vbInformation, TITSISTEMA
   On Error GoTo 0
   
   cmbSistema.ListIndex = -1
   cmbMoneda.ListIndex = -1
   
Exit Sub
ErrorGuardar:
   Call Bac_Sql_Execute("Rollback Transaction")
   On Error GoTo 0
   MsgBox "¡ Se ha producido un error al grabar la información.!", vbExclamation, TITSISTEMA
End Sub
