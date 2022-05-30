VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form FRM_INFORME_BASILEA 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Informe BASILEA"
   ClientHeight    =   1365
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   5010
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   1365
   ScaleWidth      =   5010
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   5010
      _ExtentX        =   8837
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
            ImageIndex      =   1
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   2
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   4305
         Top             =   15
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
               Picture         =   "FRM_INFORME_BASILEA.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_INFORME_BASILEA.frx":0EDA
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_INFORME_BASILEA.frx":1DB4
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame Frame1 
      Height          =   975
      Left            =   45
      TabIndex        =   1
      Top             =   375
      Width           =   4995
      Begin BACControles.TXTFecha Fecha 
         Height          =   300
         Left            =   1425
         TabIndex        =   2
         Top             =   195
         Width           =   1410
         _ExtentX        =   2487
         _ExtentY        =   529
         Enabled         =   -1  'True
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "29/08/2008"
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Fecha"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Left            =   930
         TabIndex        =   4
         Top             =   255
         Width           =   435
      End
      Begin VB.Label FechaLarga 
         Alignment       =   2  'Center
         BorderStyle     =   1  'Fixed Single
         Caption         =   "Miercoles, 25 de Septiembre del 2008."
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
         TabIndex        =   3
         Top             =   525
         Width           =   4785
      End
   End
End
Attribute VB_Name = "FRM_INFORME_BASILEA"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Fecha_Change()
   If CDate(Fecha.Text) > CDate(gsBAC_Fecp) Then
      MsgBox "Control de Fecha." & vbCrLf & vbCrLf & "Fecha de selección no debe ser superior a la fecha de proceso.-", vbExclamation, App.Title
      Let Fecha.Text = Format(gsBAC_Fecp, "dd-mm-yyyy")
   End If
   
   Let FechaLarga.Caption = Format(Fecha.Text, "dddd, dd mmmm. yyyy")
   On Error Resume Next
   Call Fecha.SetFocus
   On Error GoTo 0
End Sub

Private Sub Fecha_Click()
   Call Fecha_Change
End Sub

Private Sub Form_Load()
   Let Me.Icon = BACSwap.Icon
   Let Me.Top = 0: Let Me.Left = 0

   Let Fecha.Text = Format(gsBAC_Fecp, "DD-MM-YYYY")
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Dim dFecha  As Date
   Let dFecha = Fecha.Text
   
   Select Case Button.Index
      Case 2
         Call Bac_Informe_Basilea(dFecha, crptToPrinter)
      Case 3
         Call Bac_Informe_Basilea(dFecha, crptToWindow)
      Case 4
         Call Unload(Me)
   End Select
End Sub

Function Bac_Informe_Basilea(ByVal dFecha As Date, xDestino As DestinationConstants)
   On Error GoTo ErrorInforme

   Call BacLimpiaParamCrw

   BACSwap.Crystal.WindowTitle = "Informe Basiles Swap"
   BACSwap.Crystal.ReportFileName = gsRPT_Path & "InformeBasileaSwap.rpt"
                  '--> Store Procedure : dbo.GENERA_INFORME_BASILEA_PCS_HISTORICO
   BACSwap.Crystal.Destination = xDestino
   BACSwap.Crystal.StoredProcParam(0) = Format(dFecha, "yyyy-mm-dd 00:00:00.000")
   BACSwap.Crystal.StoredProcParam(1) = gsBAC_User
   BACSwap.Crystal.Connect = swConeccion
   BACSwap.Crystal.Action = 1
   
Exit Function
ErrorInforme:
   MsgBox "Error Impresión" & vbCrLf & vbCrLf & BACSwap.Crystal.LastErrorString, vbExclamation, App.Title
End Function

