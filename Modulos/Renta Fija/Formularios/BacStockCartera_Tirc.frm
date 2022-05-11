VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BACControles.ocx"
Begin VB.Form BacStockCarteraTirc 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Informe Stock de cartera aTir de Compra"
   ClientHeight    =   3315
   ClientLeft      =   45
   ClientTop       =   345
   ClientWidth     =   4215
   Icon            =   "BacStockCartera_Tirc.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   3315
   ScaleWidth      =   4215
   Begin Threed.SSFrame SSFrame1 
      Height          =   1785
      Left            =   60
      TabIndex        =   4
      Top             =   1470
      Width           =   4095
      _Version        =   65536
      _ExtentX        =   7223
      _ExtentY        =   3149
      _StockProps     =   14
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin Threed.SSCheck SSCheck3 
         Height          =   195
         Left            =   240
         TabIndex        =   7
         Top             =   1230
         Width           =   3315
         _Version        =   65536
         _ExtentX        =   5847
         _ExtentY        =   344
         _StockProps     =   78
         Caption         =   "   Saldos Contables"
         ForeColor       =   -2147483635
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin Threed.SSCheck SSCheck2 
         Height          =   255
         Left            =   240
         TabIndex        =   6
         Top             =   750
         Width           =   3435
         _Version        =   65536
         _ExtentX        =   6059
         _ExtentY        =   450
         _StockProps     =   78
         Caption         =   "   Stock Compras/Ventas con Pacto"
         ForeColor       =   -2147483635
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin Threed.SSCheck SSCheck1 
         Height          =   255
         Left            =   240
         TabIndex        =   5
         Top             =   330
         Width           =   2985
         _Version        =   65536
         _ExtentX        =   5265
         _ExtentY        =   450
         _StockProps     =   78
         Caption         =   "   Stock/Disponibilidad Cartera "
         ForeColor       =   -2147483635
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   3
      Top             =   0
      Width           =   4215
      _ExtentX        =   7435
      _ExtentY        =   794
      ButtonWidth     =   767
      ButtonHeight    =   741
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Description     =   "imprimir"
            Object.ToolTipText     =   "Impresión Directa"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Pantalla"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin VB.Frame Frame1 
      Height          =   1050
      Left            =   45
      TabIndex        =   0
      Top             =   405
      Width           =   4110
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   3330
         Top             =   180
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
               Picture         =   "BacStockCartera_Tirc.frx":030A
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacStockCartera_Tirc.frx":0626
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacStockCartera_Tirc.frx":0A78
               Key             =   ""
            EndProperty
         EndProperty
      End
      Begin BACControles.TXTFecha txtFecha 
         Height          =   285
         Left            =   1890
         TabIndex        =   1
         Top             =   405
         Width           =   1410
         _ExtentX        =   2487
         _ExtentY        =   503
         Enabled         =   -1  'True
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   8388608
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "07/09/2001"
      End
      Begin VB.Label Label1 
         Caption         =   "Fecha Proceso"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   285
         Left            =   270
         TabIndex        =   2
         Top             =   405
         Width           =   1365
      End
   End
End
Attribute VB_Name = "BacStockCarteraTirc"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Form_Load()
Me.txtFecha.text = gsBac_Fecp
Me.SSCheck1.Value = True
Me.SSCheck2.Value = True
Me.SSCheck3.Value = True
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

    Select Case Button.Index
        Case 1: Call Imprime_RPT("Impresora")
        Case 2: Call Imprime_RPT("Pantalla")
        Case 3: Unload Me
    End Select

End Sub

Sub Imprime_RPT(cDestino As String)
On Error GoTo ERR_Imprime_RPT_Stock_Tirc
 If Me.txtFecha.text < gsBac_Fecp Then
    MsgBox "Fecha debe ser mayor o Igual a Fecha de Proceso", vbCritical
    Me.txtFecha.text = gsBac_Fecp
    Exit Sub
 End If
    Screen.MousePointer = vbHourglass
    If SSCheck1.Value Then
      ' Stock/Disponibilidad
      Call Limpiar_Cristal
      BacTrader.bacrpt.Destination = IIf(cDestino = "Pantalla", crptToWindow, crptToPrinter)
      BacTrader.bacrpt.ReportFileName = RptList_Path & "stockcartircprop.rpt"
      BacTrader.bacrpt.StoredProcParam(0) = Format(Me.txtFecha.text, "yyyymmdd")
      BacTrader.bacrpt.WindowTitle = "STOCK/DIPONIBILIDAD CARTERA A TIR DE COMPRA "
      BacTrader.bacrpt.Connect = CONECCION
      BacTrader.bacrpt.WindowState = crptMinimized
      BacTrader.bacrpt.Action = 1

    End If

    If SSCheck2.Value Then
       ' Ventas Con pacto
       Call Limpiar_Cristal
       BacTrader.bacrpt.Destination = IIf(cDestino = "Pantalla", crptToWindow, crptToPrinter)
       BacTrader.bacrpt.ReportFileName = RptList_Path & "stockcartircpactVi.rpt"
       BacTrader.bacrpt.StoredProcParam(0) = Format(Me.txtFecha.text, "yyyymmdd")
       BacTrader.bacrpt.WindowTitle = "STOCK VENTAS CON PACTO CARTERA A TIR DE COMPRA"
       BacTrader.bacrpt.Connect = CONECCION
       BacTrader.bacrpt.WindowState = crptMinimized
       BacTrader.bacrpt.Action = 1
       
       ' Compras Con pacto
       Call Limpiar_Cristal
       BacTrader.bacrpt.Destination = IIf(cDestino = "Pantalla", crptToWindow, crptToPrinter)
       BacTrader.bacrpt.ReportFileName = RptList_Path & "stockcartircpactCi.rpt"
       BacTrader.bacrpt.StoredProcParam(0) = Format(Me.txtFecha.text, "yyyymmdd")
       BacTrader.bacrpt.WindowTitle = "STOCK COMPRAS CON PACTO CARTERA A TIR DE COMPRA"
       BacTrader.bacrpt.Connect = CONECCION
       BacTrader.bacrpt.WindowState = crptMinimized
       BacTrader.bacrpt.Action = 1
       
    End If

    If SSCheck3.Value Then
       Envia = Array(Format(Me.txtFecha.text, "yyyymmdd"))
       If Not Bac_Sql_Execute("SP_STOCK_CARTERA_Tirc", Envia) Then
           MsgBox "No se puede Ejecutar SP_STOCK_CARTERA_Tirc", vbCritical, gsBac_Version
           Exit Sub
       End If
      
       '-----------Resumen
       Call Limpiar_Cristal
       BacTrader.bacrpt.Destination = IIf(cDestino = "Pantalla", crptToWindow, crptToPrinter)
       BacTrader.bacrpt.ReportFileName = RptList_Path & "saldos_cartera_Tirc.rpt"
       BacTrader.bacrpt.WindowTitle = "RESUMEN STOCK CARTERA TIR DE COMPRA"
       BacTrader.bacrpt.Connect = CONECCION
       BacTrader.bacrpt.WindowState = crptMinimized
       BacTrader.bacrpt.Action = 1

    End If
    Screen.MousePointer = vbDefault
    Exit Sub
       
Exit Sub
ERR_Imprime_RPT_Stock_Tirc:
    MsgBox err.Description, vbCritical, TITSISTEMA
    Screen.MousePointer = vbDefault
    Exit Sub
End Sub

