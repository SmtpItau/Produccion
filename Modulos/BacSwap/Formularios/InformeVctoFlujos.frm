VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form InformeVctoFlujos 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Informe de Pago de Flujos.-"
   ClientHeight    =   1590
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   6855
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   1590
   ScaleWidth      =   6855
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   6855
      _ExtentX        =   12091
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
               Picture         =   "InformeVctoFlujos.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "InformeVctoFlujos.frx":0EDA
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "InformeVctoFlujos.frx":1DB4
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame Frame1 
      Height          =   1125
      Left            =   15
      TabIndex        =   1
      Top             =   450
      Width           =   6825
      Begin BACControles.TXTFecha TXTFechaDesde 
         Height          =   315
         Left            =   1320
         TabIndex        =   3
         Top             =   150
         Width           =   1365
         _ExtentX        =   2408
         _ExtentY        =   556
         Enabled         =   -1  'True
         Enabled         =   -1  'True
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
      Begin BACControles.TXTFecha TXTFechaHasta 
         Height          =   315
         Left            =   1320
         TabIndex        =   5
         Top             =   510
         Width           =   1365
         _ExtentX        =   2408
         _ExtentY        =   556
         Enabled         =   -1  'True
         Enabled         =   -1  'True
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
      Begin VB.Label LblFechaHasta 
         Alignment       =   2  'Center
         BorderStyle     =   1  'Fixed Single
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
         Left            =   2715
         TabIndex        =   7
         Top             =   480
         Width           =   3975
      End
      Begin VB.Label EtiquetasHasta 
         AutoSize        =   -1  'True
         Caption         =   "Fecha Hasta"
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
         Left            =   120
         TabIndex        =   6
         Top             =   480
         Width           =   975
      End
      Begin VB.Label LblFechaDesde 
         Alignment       =   2  'Center
         BorderStyle     =   1  'Fixed Single
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
         Left            =   2715
         TabIndex        =   4
         Top             =   195
         Width           =   3975
      End
      Begin VB.Label EtiquetasDesde 
         AutoSize        =   -1  'True
         Caption         =   "Fecha Desde"
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
         Left            =   120
         TabIndex        =   2
         Top             =   225
         Width           =   1050
      End
   End
End
Attribute VB_Name = "InformeVctoFlujos"
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
   TXTFechaDesde.Text = Format(gsBAC_Fecp, "dd/mm/yyyy")
   TXTFechaHasta.Text = Format(gsBAC_Fecp, "dd/mm/yyyy")
End Sub

Private Sub Form_Load()
   Me.Icon = BACSwap.Icon
   'PRD-5149, jbh, 12-01-2010, para evitar "paseo" del form por la pantalla
   Me.Top = 0
   Me.Left = 0
   
   Call Limpiar
   LblFechaDesde.Caption = Format(TXTFechaDesde.Text, "dddd, dd") & " de " & Format(TXTFechaDesde.Text, "mmmm") & " del " & Format(TXTFechaDesde.Text, "yyyy")
   LblFechaHasta.Caption = Format(TXTFechaHasta.Text, "dddd, dd") & " de " & Format(TXTFechaHasta.Text, "mmmm") & " del " & Format(TXTFechaHasta.Text, "yyyy")
   
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 1
         Call Imprimir([Vista Previa])
      Case 2
         Call Imprimir(Impresora)
      Case 3
         Unload Me
   End Select
End Sub


Private Sub Imprimir(MiDestino As MiImpresion)
   On Error GoTo ErrPrint
   
 If Valida_Fechas = True Then
   Call BacLimpiaParamCrw
   
   'CER 18/04/2008  - Req. Pantalla Ingreso Op. Swap
   
   'Se reemplaza reporte InformeVctoFlujoSwapProm.rpt por InformePagosDeFlujoSwap.rpt
''   BACSwap.Crystal.ReportFileName = gsRPT_Path & "InformePagosDeFlujoSwap.rpt"
                        '  Store Procedure : dbo.Sp_Informe_Flujos_Swap.sql
'CER 05/11/2008 - Se cambia reporte.
   BACSwap.Crystal.ReportFileName = gsRPT_Path & "Carta_Liquidacion_Swap_Flujos_Multiples.rpt"
   BACSwap.Crystal.WindowTitle = "Informe de Vencimiento de Flujos"
   BACSwap.Crystal.StoredProcParam(0) = 0
   BACSwap.Crystal.StoredProcParam(1) = Format(TXTFechaDesde.Text, "yyyy-mm-dd 00:00:00.000")
   BACSwap.Crystal.StoredProcParam(2) = Format(TXTFechaHasta.Text, "yyyy-mm-dd 00:00:00.000")
''   BACSwap.Crystal.StoredProcParam(0) = Format(miFecha, "yyyy-mm-dd 00:00:00.000")
''   BACSwap.Crystal.StoredProcParam(1) = gsBAC_User
   BACSwap.Crystal.Destination = MiDestino
   BACSwap.Crystal.Connect = swConeccion
   BACSwap.Crystal.Action = 1
 Else
    MsgBox "Fechas ingresadas no son validas. "
 End If

Exit Sub
ErrPrint:
   MsgBox "Error al imprimir." & vbCrLf & vbCrLf & err.Description, vbExclamation, TITSISTEMA
End Sub

Function Valida_Fechas()

 Valida_Fechas = False
 If TXTFechaDesde.Text = TXTFechaHasta.Text Then
    If TXTFechaDesde.Text > gsBAC_Fecp Then
        Valida_Fechas = True
    End If
    
 Else
    If TXTFechaDesde.Text < gsBAC_Fecp And TXTFechaHasta.Text > gsBAC_Fecp Then
            Valida_Fechas = False
            Exit Function
    End If
 End If
 
  Valida_Fechas = True
   
End Function

Private Sub txtFechaDesde_Change()
   LblFechaDesde.Caption = Format(TXTFechaDesde.Text, "dddd, dd") & " de " & Format(TXTFechaDesde.Text, "mmmm") & " del " & Format(TXTFechaDesde.Text, "yyyy")
   
End Sub

Private Sub TXTFechaHasta_Change()
  LblFechaHasta.Caption = Format(TXTFechaHasta.Text, "dddd, dd") & " de " & Format(TXTFechaHasta.Text, "mmmm") & " del " & Format(TXTFechaHasta.Text, "yyyy")

End Sub

