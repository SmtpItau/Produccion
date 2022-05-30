VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form Informe_Oper_Dia 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Informe Operaciones del Día.-"
   ClientHeight    =   1590
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   4680
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   1590
   ScaleWidth      =   4680
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   4680
      _ExtentX        =   8255
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   2745
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
               Picture         =   "Informe_Oper_Dia.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Informe_Oper_Dia.frx":0EDA
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Informe_Oper_Dia.frx":1DB4
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame Frame1 
      Height          =   1140
      Left            =   15
      TabIndex        =   1
      Top             =   450
      Width           =   4665
      Begin BACControles.TXTFecha txtFecha 
         Height          =   330
         Left            =   1860
         TabIndex        =   3
         Top             =   270
         Width           =   1365
         _ExtentX        =   2408
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
         Text            =   "30/11/2005"
      End
      Begin VB.Label LblFecha 
         Alignment       =   2  'Center
         BorderStyle     =   1  'Fixed Single
         Caption         =   "Miercoles 30 de Septiembre de 2005"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   75
         TabIndex        =   4
         Top             =   675
         Width           =   4455
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
         Left            =   1200
         TabIndex        =   2
         Top             =   345
         Width           =   480
      End
   End
End
Attribute VB_Name = "Informe_Oper_Dia"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private Enum MiImpresion
   [Vista Previa] = crptToWindow
   [Impresora] = crptToPrinter
End Enum

Private Sub Limpiar()
   txtFecha.Text = Format(gsBAC_Fecp, "dd/mm/yyyy")
End Sub

Private Sub Form_Load()
   Me.Icon = BACSwap.Icon
   
   'PRD-5149, jbh, 12-01-2010, para evitar "paseo" del formulario en la pantalla
   Me.Top = 0
   Me.Left = 0
   
   Call Limpiar
End Sub

Private Function MiFechaLarga(miFecha As String) As String
   Dim RetornoFecha As String
   
   RetornoFecha = DiaSemana(miFecha, Me.LblFecha) & " " & Format(CDate(miFecha), "D") & " de " & Format(CDate(miFecha), "MMMM") & " del " & Format(CDate(miFecha), "yyyy")
   MiFechaLarga = RetornoFecha
End Function

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 1
         Call Imprimir([Vista Previa], txtFecha.Text)
      Case 2
         Call Imprimir(Impresora, txtFecha.Text)
      Case 3
         Unload Me
   End Select
End Sub

Private Sub txtFecha_Change()
   LblFecha.Caption = MiFechaLarga(txtFecha.Text)
End Sub

Private Sub Imprimir(MiDestino As MiImpresion, miFecha As Date)
   On Error GoTo ErrPrint
   
   Call BacLimpiaParamCrw
   BACSwap.Crystal.ReportFileName = gsRPT_Path & "Informe_Resume_Mov_Swap.rpt"
   BACSwap.Crystal.WindowTitle = "Resumen Moviminetos Swap"
   BACSwap.Crystal.StoredProcParam(0) = Format(miFecha, "yyyy-mm-dd 00:00:00.000")
   BACSwap.Crystal.StoredProcParam(1) = gsBAC_User
   BACSwap.Crystal.Destination = MiDestino
   BACSwap.Crystal.Connect = swConeccion
   BACSwap.Crystal.Action = 1

Exit Sub
ErrPrint:
   MsgBox "Error al imprimir." & vbCrLf & vbCrLf & err.Description, vbExclamation, TITSISTEMA
End Sub
