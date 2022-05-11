VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Begin VB.Form FRM_MNT_TASAS_MONEDA 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantenedor de Tasas por Moneda."
   ClientHeight    =   4335
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   6750
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   4335
   ScaleWidth      =   6750
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   6750
      _ExtentX        =   11906
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
            Enabled         =   0   'False
            Object.Visible         =   0   'False
            Object.ToolTipText     =   "Buscar ..."
            ImageIndex      =   4
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar Asignación de Tasas  ..."
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Eliminar Tasas Asignadas para la Moneda Seleccionada..."
            ImageIndex      =   5
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Cerrar ventana..."
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   2985
         Top             =   90
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
               Picture         =   "FRM_MNT_TASAS_MONEDA.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_TASAS_MONEDA.frx":0EDA
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_TASAS_MONEDA.frx":1DB4
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_TASAS_MONEDA.frx":20CE
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_TASAS_MONEDA.frx":2FA8
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame FraCuadro 
      Height          =   3885
      Left            =   15
      TabIndex        =   1
      Top             =   435
      Width           =   6735
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
         Left            =   3120
         TabIndex        =   7
         Top             =   2250
         Width           =   495
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
         Left            =   3120
         TabIndex        =   6
         Top             =   1650
         Width           =   495
      End
      Begin VB.ListBox LstTasasIn 
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
         Left            =   3840
         MultiSelect     =   2  'Extended
         TabIndex        =   5
         Top             =   720
         Width           =   2805
      End
      Begin VB.ListBox LstTasas 
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
         Left            =   90
         MultiSelect     =   2  'Extended
         TabIndex        =   4
         Top             =   720
         Width           =   2805
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
         Left            =   90
         Style           =   2  'Dropdown List
         TabIndex        =   3
         ToolTipText     =   "Moneda Seleccionada para la Asignación de Tasas."
         Top             =   375
         Width           =   6570
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Moneda"
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
         Left            =   75
         TabIndex        =   2
         Top             =   165
         Width           =   675
      End
   End
End
Attribute VB_Name = "FRM_MNT_TASAS_MONEDA"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private Enum oEvento
   [Monedas mnt] = 0
   [Tasas   mnt] = 1
   [Delete] = 2
   [Insert] = 3
   [Consulta] = 4
End Enum
Private Sub Eliminar()
   Dim iContador  As Long
   Dim Datos()
   Dim iMoneda    As Integer
   Dim iTasa      As Integer

   If cmbMoneda.ListIndex = -1 Then
      Exit Sub
   End If

   If MsgBox("¿ Esta seguro que desea eliminar las tasas asociadas a la moneda " & cmbMoneda.Text & " ?", vbQuestion + vbYesNo, TITSISTEMA) = vbNo Then
      Exit Sub
   End If

   iMoneda = cmbMoneda.ItemData(cmbMoneda.ListIndex)
   
   Envia = Array()
   AddParam Envia, CDbl(2) 'Eliminar
   AddParam Envia, CDbl(iMoneda)
   If Not Bac_Sql_Execute("SP_MNT_TASAS_MONEDA", Envia) Then
      Exit Sub
   End If

   LstTasasIn.Clear
   Call CargaTasas(LstTasas, 0, [Tasas   mnt])

End Sub

Private Sub GrabarTasasMoneda()
   Dim iContador  As Long
   Dim Datos()
   Dim iMoneda    As Integer
   Dim iTasa      As Integer
   
   If cmbMoneda.ListIndex = -1 And LstTasasIn.ListIndex = -1 Then
      Exit Sub
   End If
   
   iMoneda = cmbMoneda.ItemData(cmbMoneda.ListIndex)
   
   Envia = Array()
   AddParam Envia, CDbl(2) 'Eliminar
   AddParam Envia, CDbl(iMoneda)
   If Not Bac_Sql_Execute("SP_MNT_TASAS_MONEDA", Envia) Then
      Exit Sub
   End If
   
   For iContador = 0 To LstTasasIn.ListCount - 1
      iTasa = LstTasasIn.ItemData(iContador)
      
      Envia = Array()
      AddParam Envia, CDbl(3) 'Grabar
      AddParam Envia, CDbl(iMoneda)
      AddParam Envia, CDbl(iTasa)
      If Not Bac_Sql_Execute("SP_MNT_TASAS_MONEDA", Envia) Then
         Exit Sub
      End If
   Next iContador
   
   cmbMoneda.ListIndex = -1
   
End Sub

Private Sub cmbMoneda_Click()
   Dim iMoneda As Integer
   
   LstTasasIn.Clear
   Call CargaTasas(LstTasas, 0, [Tasas   mnt])
   
   If cmbMoneda.ListIndex = -1 Then
      cmdIn.Enabled = False
      cmdOut.Enabled = False
      Exit Sub
   End If
   
   iMoneda = cmbMoneda.ItemData(cmbMoneda.ListIndex)
   
   Call CargaTasas(LstTasasIn, iMoneda, Consulta)
   
   cmdIn.Enabled = True
   cmdOut.Enabled = True

End Sub

Private Sub cmdIn_Click()
   Dim iContador  As Integer
   Dim iCont2     As Integer
   
   For iContador = 0 To LstTasas.ListCount - 1
      If LstTasas.Selected(iContador) = True Then
         LstTasasIn.AddItem LstTasas.List(iContador)
         LstTasasIn.ItemData(LstTasasIn.NewIndex) = LstTasas.ItemData(iContador)
      End If
   Next iContador
   
   For iContador = 0 To LstTasasIn.ListCount - 1
      For iCont2 = 0 To LstTasas.ListCount - 1
         If LstTasasIn.ItemData(iContador) = LstTasas.ItemData(iCont2) Then
            LstTasas.RemoveItem iCont2
            Exit For
         End If
      Next iCont2
   Next iContador
   
End Sub

Private Sub cmdIn_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
   cmdIn.ToolTipText = "Asignación de Tasas Seleccionadas para la Moneda : " & cmbMoneda.Text
End Sub
Private Sub cmdOut_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
   cmdOut.ToolTipText = "Retira Tasas Asignadas a la Moneda : " & cmbMoneda.Text
End Sub

Private Sub cmdOut_Click()
   Dim iContador  As Integer
   Dim iCont2     As Integer
   
   For iContador = 0 To LstTasasIn.ListCount - 1
      If LstTasasIn.Selected(iContador) = True Then
         LstTasas.AddItem LstTasasIn.List(iContador)
         LstTasas.ItemData(LstTasas.NewIndex) = LstTasasIn.ItemData(iContador)
      End If
   Next iContador
   
   For iContador = 0 To LstTasas.ListCount - 1
      For iCont2 = 0 To LstTasasIn.ListCount - 1
         If LstTasas.ItemData(iContador) = LstTasasIn.ItemData(iCont2) Then
            LstTasasIn.RemoveItem iCont2
            Exit For
         End If
      Next iCont2
   Next iContador
   
End Sub


Private Sub Form_Load()
   Me.Top = 0: Me.Left = 0
   Me.Icon = BACSwapParametros.Icon
   
   Call CargarMonedas(cmbMoneda)
   
   Call CargaTasas(LstTasas, 0, [Tasas   mnt])
   
   cmdIn.Enabled = False
   cmdOut.Enabled = False
End Sub

Private Sub CargarMonedas(ByRef objCarga As ComboBox)
   On Error GoTo ErrorCargaMonedas
   Dim Datos()
   
   Envia = Array()
   AddParam Envia, CDbl(0)  '--> Carga Monedas
   If Not Bac_Sql_Execute("SP_MNT_TASAS_MONEDA", Envia) Then
      Exit Sub
   End If
   objCarga.Clear
   Do While Bac_SQL_Fetch(Datos())
      objCarga.AddItem Datos(3)                       '--> MnGlosa   (Glosa de la Moneda)
      objCarga.ItemData(objCarga.NewIndex) = Datos(1) '--> MnCodMon  (Codigo de la Moneda)
   Loop
   
   On Error GoTo 0
Exit Sub
ErrorCargaMonedas:
   MsgBox "Problemas en la carga de monedas" & vbCrLf & Err.Description, vbExclamation, TITSISTEMA
End Sub

Private Sub CargaTasas(ByRef objCarga As ListBox, ByVal Moneda As Integer, ByVal Codigo As oEvento)
   On Error GoTo ErrorCargaMonedas
   Dim Datos()
   Dim iContador  As Integer
   
   Envia = Array()
   AddParam Envia, CDbl(Codigo)       '--> Carga Tasas
   AddParam Envia, CDbl(Moneda)
   If Not Bac_Sql_Execute("SP_MNT_TASAS_MONEDA", Envia) Then
      Exit Sub
   End If
   objCarga.Clear
   Do While Bac_SQL_Fetch(Datos())
      If Codigo = Consulta Then
         objCarga.AddItem Datos(4)                       '--> Codigo_Tasa (Glosa de la Tasa)
         objCarga.ItemData(objCarga.NewIndex) = Datos(3) '--> tbGlosa     (Codigo de la Tasa)
         
         For iContador = 0 To LstTasas.ListCount - 1
            If LstTasas.ItemData(iContador) = Datos(3) Then
               LstTasas.RemoveItem (iContador)
               Exit For
            End If
         Next iContador
      Else
         objCarga.AddItem Datos(2)                       '--> tbglosa     (Glosa de la Tasa)
         objCarga.ItemData(objCarga.NewIndex) = Datos(1) '--> tbcodigo1   (Codigo de la Tasa)
      End If
   Loop
   
   On Error GoTo 0
Exit Sub
ErrorCargaMonedas:
   MsgBox "Problemas en la carga de monedas" & vbCrLf & Err.Description, vbExclamation, TITSISTEMA
End Sub

Private Sub LstTasas_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
   LstTasas.ToolTipText = "Tasas No Asignadas a la Moneda :" & cmbMoneda.Text
End Sub

Private Sub LstTasasIn_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
   LstTasasIn.ToolTipText = "Tasas Asignadas a la Moneda :" & cmbMoneda.Text
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 2
         Call GrabarTasasMoneda
      Case 3
         Call Eliminar
      Case 4
         Unload Me
   End Select
End Sub
