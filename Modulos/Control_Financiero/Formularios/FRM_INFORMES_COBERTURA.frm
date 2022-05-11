VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form FRM_INFORMES_COBERTURA 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Informe de Coberturas."
   ClientHeight    =   1485
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   5025
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   1485
   ScaleWidth      =   5025
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   5025
      _ExtentX        =   8864
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
            Key             =   "Vista"
            Object.ToolTipText     =   "Vista Previa"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Impresora"
            Object.ToolTipText     =   "Imprimir"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Cerrar"
            Object.ToolTipText     =   "Cerrar"
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   2160
         Top             =   105
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
               Picture         =   "FRM_INFORMES_COBERTURA.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_INFORMES_COBERTURA.frx":0EDA
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_INFORMES_COBERTURA.frx":1DB4
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame Frame1 
      Height          =   1050
      Left            =   15
      TabIndex        =   1
      Top             =   435
      Width           =   5010
      Begin VB.ComboBox cmbCoberturas 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   1590
         Style           =   2  'Dropdown List
         TabIndex        =   5
         Top             =   585
         Width           =   3330
      End
      Begin BACControles.TXTFecha FechaCobertura 
         Height          =   330
         Left            =   1590
         TabIndex        =   3
         Top             =   180
         Width           =   1800
         _ExtentX        =   3175
         _ExtentY        =   582
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "30/05/2006"
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "N° de cobertura"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   210
         Index           =   1
         Left            =   195
         TabIndex        =   4
         Top             =   660
         Width           =   1275
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Fecha"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   210
         Index           =   0
         Left            =   195
         TabIndex        =   2
         Top             =   300
         Width           =   480
      End
   End
End
Attribute VB_Name = "FRM_INFORMES_COBERTURA"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub FechaCobertura_Change()
   Dim SQL  As String
   Dim Datos()
   
   If Not Bac_Sql_Execute("BacTraderSuda..SP_LEER_COBERTURAS") Then
      Exit Sub
   End If
   cmbCoberturas.Clear
   cmbCoberturas.AddItem "<< TODAS >>"
   Do While Bac_SQL_Fetch(Datos())
      cmbCoberturas.AddItem Datos(1) & "  " & Datos(2) & " / " & Datos(3)
   Loop
End Sub

Private Sub Form_Load()
   Me.Icon = BacControlFinanciero.Icon
   Me.Top = 0: Me.Left = 0
   
   FechaCobertura.Text = Format(gsBAC_Fecp, "dd/mm/yyyy")
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Dim MiCobertura As Double
   If (cmbCoberturas.ListIndex <= 0) Then
      MiCobertura = 0
   Else
      MiCobertura = CDbl(Left(cmbCoberturas.Text, 8))
   End If
   
   Select Case Button.Index
      Case 1
         Call Informe_Coberturas(crptToWindow, MiCobertura)
      Case 2
         Call Informe_Coberturas(crptToPrinter, MiCobertura)
      Case 3
         Unload Me
   End Select
End Sub

Private Sub Informe_Coberturas(MiDestion As DestinationConstants, MiCobertura As Double)
   On Error GoTo ErrorImpresion
   
   BacControlFinanciero.CryFinanciero.ReportFileName = gsRPT_Path & "Informe_Coberturas.rpt"
              '--> Procedimiento Almacenado : BacTraderSuda..dbo.SP_INFORME_COBERTURAS
   BacControlFinanciero.CryFinanciero.WindowTitle = "Informe de Coberturas."
   BacControlFinanciero.CryFinanciero.StoredProcParam(0) = MiCobertura
   BacControlFinanciero.CryFinanciero.StoredProcParam(1) = gsBAC_User
   BacControlFinanciero.CryFinanciero.Connect = swConeccion
   BacControlFinanciero.CryFinanciero.WindowState = crptMaximized
   BacControlFinanciero.CryFinanciero.Destination = MiDestion
   BacControlFinanciero.CryFinanciero.Action = 1

   On Error GoTo 0
Exit Sub
ErrorImpresion:
   MsgBox "Error Impresión" & vbCrLf & vbCrLf & "Error N° : " & Err.Number & "  - " & Err.Description, vbExclamation, TITSISTEMA
End Sub
