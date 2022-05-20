VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form Informe_Valor_Moneda 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Informe Valores de Moneda"
   ClientHeight    =   1680
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   4275
   BeginProperty Font 
      Name            =   "Arial"
      Size            =   8.25
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   1680
   ScaleWidth      =   4275
   ShowInTaskbar   =   0   'False
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   480
      Left            =   0
      TabIndex        =   5
      Top             =   0
      Width           =   4275
      _ExtentX        =   7541
      _ExtentY        =   847
      ButtonWidth     =   820
      ButtonHeight    =   794
      Appearance      =   1
      Style           =   1
      ImageList       =   "Img_opciones"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Imprimir"
            ImageIndex      =   7
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Vista Previa"
            ImageIndex      =   8
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
   End
   Begin VB.Frame Frame1 
      Height          =   1155
      Left            =   -15
      TabIndex        =   0
      Top             =   510
      Width           =   4305
      Begin VB.ComboBox Cmbmoneda 
         Height          =   330
         Left            =   1185
         Style           =   2  'Dropdown List
         TabIndex        =   4
         Top             =   705
         Width           =   3030
      End
      Begin VB.ComboBox CmbAno 
         Height          =   330
         Left            =   1200
         Style           =   2  'Dropdown List
         TabIndex        =   3
         Top             =   240
         Width           =   2145
      End
      Begin VB.Label Label2 
         Caption         =   "Moneda"
         Height          =   165
         Left            =   180
         TabIndex        =   2
         Top             =   735
         Width           =   2040
      End
      Begin VB.Label Label1 
         Caption         =   "Año"
         Height          =   225
         Left            =   180
         TabIndex        =   1
         Top             =   330
         Width           =   1740
      End
   End
   Begin MSComctlLib.ImageList Img_opciones 
      Left            =   3660
      Top             =   -120
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   24
      ImageHeight     =   24
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   8
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Valor_moneda.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Valor_moneda.frx":0467
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Valor_moneda.frx":095D
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Valor_moneda.frx":0DF0
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Valor_moneda.frx":12D8
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Valor_moneda.frx":17EB
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Valor_moneda.frx":1CBE
            Key             =   ""
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Valor_moneda.frx":2184
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "Informe_Valor_Moneda"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim OptLocal As String

Private Function Cargar_Combos()
Dim i As Integer
For i = Year(gsbac_fecp) To 1990 Step -1
     Me.cmbano.AddItem i
Next i

Me.CmbMoneda.Clear

 If Not BAC_SQL_EXECUTE("sp_mnleetodo") Then
       
       Exit Function
    
 End If
 
    Do While BAC_SQL_FETCH(Datos())
        
              
        Me.CmbMoneda.AddItem Datos(4)
        Me.CmbMoneda.ItemData(Me.CmbMoneda.NewIndex) = Datos(1)
        
    Loop
Me.cmbano.ListIndex = 0
Me.CmbMoneda.ListIndex = 0
End Function

Private Function Imprimir(Tipo_Impresion As Integer)
 On Error GoTo Elpt
   Dim OptLocal As String
   Dim TitRpt As String

   Opt = "opc_870"
   OptLocal = Opt

   With BAC_Parametros.BacParam

   If Tipo_Impresion = 0 Then
        .Destination = crptToWindow
   Else
        .Destination = crptToPrinter
   End If

      '.Destination = crptToWindow
      .ReportFileName = gsRPT_Path & "ListMdvm.rpt"
      Call PROC_ESTABLECE_UBICACION(BAC_Parametros.BacParam.RetrieveDataFiles, BAC_Parametros.BacParam)
      .WindowTitle = "Reporte de Valores de Moneda"
      .StoredProcParam(0) = Me.cmbano.Text
      .StoredProcParam(1) = Me.CmbMoneda.ItemData(Me.CmbMoneda.ListIndex)
      .StoredProcParam(2) = gsBAC_User
      .Formulas(0) = "xUsuario='" & gsBAC_User & "'"
      .Connect = SwConeccion
      .Action = 1
   End With

   Screen.MousePointer = vbDefault
   
   Call LogAuditoria("10", OptLocal, "Informe de Familias de Instrumentos", "", "")
   Exit Function

Elpt:
   Screen.MousePointer = vbDefault
   MsgBox "Problemas Al Emitir Informe", vbExclamation
   Call LogAuditoria("10", OptLocal, "Informe de Familias de Instrumentos- Error al emitir informe", "", "")

End Function

Private Sub Form_Activate()
   PROC_CARGA_AYUDA Me, " "
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
On Error GoTo err
Dim opcion As Integer

   opcion = 0

  
   If KeyCode <> vbKeyControl And (Shift = 2 Or (Shift = 0 And (KeyCode = vbKeyReturn Or KeyCode = vbKeyEscape Or (KeyCode >= vbKeyF1 And KeyCode <= vbKeyF12)))) Then
     
        Select Case KeyCode

         
           Case vbKeyImprimir:
                              opcion = 1

            Case vbKeyVistaPrevia:
                              opcion = 2
            Case vbKeySalir:
                              opcion = 3
                      
      End Select

      If opcion <> 0 Then
            If Toolbar1.Buttons(opcion).Enabled Then
               Call Toolbar1_ButtonClick(Toolbar1.Buttons(opcion))
            End If
   
            KeyCode = 0
      End If
    
      
   End If
Exit Sub
err:
  Resume Next
End Sub

Private Sub Form_Load()
   Cargar_Combos
   Me.Icon = BAC_Parametros.Icon
   Me.top = 0
   Me.left = 0
   
   OptLocal = Opt
   
   Call LogAuditoria("07", OptLocal, Me.Caption, "", "")
End Sub

Private Sub Form_Unload(Cancel As Integer)
   Call LogAuditoria("08", OptLocal, Me.Caption, "", "")
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Index
   Case 1
      Imprimir (1)
   Case 2
      Imprimir (0)
   Case 3
      Unload Me
End Select

End Sub

