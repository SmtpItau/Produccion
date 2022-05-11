VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form FRM_INFORME_BACKTEST 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Informe Back-Test"
   ClientHeight    =   1935
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   4755
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   1935
   ScaleWidth      =   4755
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   4755
      _ExtentX        =   8387
      _ExtentY        =   794
      ButtonWidth     =   767
      ButtonHeight    =   741
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
            Object.ToolTipText     =   "Imprime Directo Impresora"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Vista Previa del Informe"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Cerrar"
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   4560
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
               Picture         =   "FRM_INFORME_BACKTEST.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_INFORME_BACKTEST.frx":0EDA
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_INFORME_BACKTEST.frx":1DB4
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame Frame1 
      Height          =   1500
      Left            =   45
      TabIndex        =   1
      Top             =   390
      Width           =   4665
      Begin VB.ComboBox cmbModulo 
         Height          =   315
         Left            =   120
         Style           =   2  'Dropdown List
         TabIndex        =   6
         Top             =   1035
         Width           =   4350
      End
      Begin BACControles.TXTFecha Fecha 
         Height          =   315
         Left            =   90
         TabIndex        =   3
         Top             =   420
         Width           =   1410
         _ExtentX        =   2487
         _ExtentY        =   556
         Enabled         =   -1  'True
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "12/02/2008"
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Modulo - Sistema Origen"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   210
         Index           =   1
         Left            =   120
         TabIndex        =   5
         Top             =   795
         Width           =   1755
      End
      Begin VB.Label EtiquetaFecha 
         Alignment       =   2  'Center
         Caption         =   "Miercoles, 21 de Septiembre del 2008"
         ForeColor       =   &H8000000D&
         Height          =   240
         Left            =   1515
         TabIndex        =   4
         Top             =   480
         Width           =   3030
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Fecha de los Datros"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   210
         Index           =   0
         Left            =   90
         TabIndex        =   2
         Top             =   180
         Width           =   1455
      End
   End
End
Attribute VB_Name = "FRM_INFORME_BACKTEST"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub LeerSistemas()
   Dim DATOS()

   If Not Bac_Sql_Execute("SP_LEER_SISTAMA_CNT") Then
      MsgBox "E - Error de lectura." & vbCrLf & vbCrLf & "Se ha producido un error de lectura al tratar de leer modulos.", vbExclamation, App.Title
      Exit Sub
   End If
   Call cmbModulo.AddItem("<< TODOS >>" & Space(100))
   Do While Bac_SQL_Fetch(DATOS())
      If DATOS(1) <> "BCC" Then
         Call cmbModulo.AddItem(DATOS(2) & Space(100) & DATOS(1))
      End If
   Loop
   Let cmbModulo.ListIndex = 0
End Sub

Private Sub miValidacion()
   If Fecha.Text >= gsBAC_Fecp Then
      Let Fecha.Text = Anteriorhabil(gsBAC_Fecp)
      Call MsgBox("V - Validación." & vbCrLf & vbCrLf & "No se puede seleccionar la fecha de proceso." & vbCrLf & "( no se ha generado el respaldo de fin de día)", vbExclamation, App.Title)
      Call Fecha.SetFocus
      Exit Sub
   End If
End Sub

Private Sub Fecha_Change()
   Call miValidacion
End Sub

Private Sub Fecha_LostFocus()
   Call miValidacion
End Sub

Private Sub Form_Load()
   Let Me.Icon = BacControlFinanciero.Icon
   Let Me.Top = 0: Me.Left = 0

   Call LeerSistemas

   Let Fecha.Text = Anteriorhabil(gsBAC_Fecp)
   Let EtiquetaFecha.Caption = FechaLarga(Fecha.Text)
End Sub

Private Function Anteriorhabil(xDate As Date) As Date
   Dim oFecha As Date
   
   Anteriorhabil = DateAdd("D", -1, xDate)
   Do While BacEsHabilDos(Str(Anteriorhabil), 1) = False
      Anteriorhabil = DateAdd("D", -1, Anteriorhabil)
   Loop
End Function

Private Function FechaLarga(xFecha As Date) As String
   Let FechaLarga = Format(xFecha, "dddd, dd") & " de " & Format(xFecha, "mmmm") & " del " & Format(xFecha, "yyyy.")
End Function

Private Sub GeneraInforme(xDestino As DestinationConstants)
   On Error GoTo ErrorImpresion
   
   Call Limpiar_Cristal
   
   Let Screen.MousePointer = vbHourglass
   
   Let BacControlFinanciero.CryFinanciero.Destination = xDestino
   Let BacControlFinanciero.CryFinanciero.ReportFileName = gsRPT_Path & "INFORME_BACK_TEST.rpt"
                                                   '--> pProdecimiento : dbo.SP_INFORME_BACK_TEST.sql
   Let BacControlFinanciero.CryFinanciero.StoredProcParam(0) = Format(Fecha.Text, "yyyy-mm-dd 00:00:00.000")
   Let BacControlFinanciero.CryFinanciero.StoredProcParam(1) = gsBAC_User
   Let BacControlFinanciero.CryFinanciero.StoredProcParam(2) = IIf(Trim(Right(cmbModulo.List(cmbModulo.ListIndex), 5)) = "", "-", Trim(Right(cmbModulo.List(cmbModulo.ListIndex), 5)))
   Let BacControlFinanciero.CryFinanciero.Connect = swConeccion
   Let BacControlFinanciero.CryFinanciero.Action = 1
   
   Let Screen.MousePointer = vbDefault
Exit Sub
ErrorImpresion:
   MsgBox "E - Error Impresión." & vbCrLf & vbCrLf & BacControlFinanciero.CryFinanciero.LastErrorString, vbExclamation, App.Title
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 2: Call GeneraInforme(crptToPrinter)
      Case 3: Call GeneraInforme(crptToWindow)
      Case 4: Call Unload(Me)
   End Select
End Sub
