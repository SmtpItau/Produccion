VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form BacRepExcepciones 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Reporte de Excepciones"
   ClientHeight    =   1485
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   3840
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   1485
   ScaleWidth      =   3840
   Begin VB.Frame Frame1 
      Caption         =   "Seleccione Módulo"
      Height          =   735
      Left            =   0
      TabIndex        =   1
      Top             =   600
      Width           =   3735
      Begin VB.ComboBox cmbModulo 
         Height          =   315
         Left            =   120
         Style           =   2  'Dropdown List
         TabIndex        =   2
         Top             =   240
         Width           =   3495
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   3840
      _ExtentX        =   6773
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Pantalla"
            Object.ToolTipText     =   "A Pantalla"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Impresora"
            Object.ToolTipText     =   "Imprimir"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Limpiar"
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   3
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   4200
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
            Picture         =   "BacRepExcepciones.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacRepExcepciones.frx":0EDA
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacRepExcepciones.frx":1DB4
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacRepExcepciones.frx":20CE
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "BacRepExcepciones"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub cmbModulo_Click()
    If cmbModulo.ListIndex <> -1 Then
        Toolbar1.Buttons(1).Enabled = True
        Toolbar1.Buttons(2).Enabled = True
    End If

End Sub

Private Sub Form_Load()
    Me.Top = 0: Me.Left = 0
    Me.Icon = BacControlFinanciero.Icon
    Me.Caption = "Reporte de Excepciones"
    Call Limpiar
    Call carga_combo
  
    
    
End Sub
Private Function Limpiar()
    cmbModulo.Clear
    cmbModulo.ListIndex = -1
    Toolbar1.Buttons(1).Enabled = False
    Toolbar1.Buttons(2).Enabled = False
    Toolbar1.Buttons(3).Enabled = True
    Toolbar1.Buttons(4).Enabled = True
End Function
Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Key
    Case Is = "Pantalla"
        Call Imprimir("Pantalla")
    Case Is = "Impresora"
        Call Imprimir("Impresora")
    Case Is = "Limpiar"
        Call Limpiar
    Case Is = "Salir"
        Unload Me

End Select

End Sub
Private Function Imprimir(ByVal destino As String)
Dim idModulo As String
idModulo = Trim(Mid$(cmbModulo.Text, 80))
On Error GoTo ErrorImpresion
With BacControlFinanciero.CryFinanciero
    Call Limpiar_Cristal
    If destino = "Pantalla" Then
        .Destination = 0
    End If
    If destino = "Impresora" Then
       .Destination = 1
    End If
    .ReportFileName = gsRPT_Path & "rpt_Excepciones.rpt"
    .StoredProcParam(0) = idModulo
    .Connect = swConeccion
    .Action = 1
End With
Exit Function
ErrorImpresion:
    MsgBox Err.Description, vbExclamation, TITSISTEMA
End Function
Private Function carga_combo()
    Dim datos()
    Dim sp As String
    sp = "Bacparamsuda.dbo.SP_LEER_SISTEMAS_CONTROLPT"
    If Bac_Sql_Execute(sp) Then
        Do While Bac_SQL_Fetch(datos())
            cmbModulo.AddItem (datos(2) & Space(80) & datos(1))
        Loop
    End If
End Function
