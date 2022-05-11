VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "Msflxgrd.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.2#0"; "mscomctl.ocx"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacIniDia 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Parámetros Diarios"
   ClientHeight    =   5775
   ClientLeft      =   495
   ClientTop       =   2745
   ClientWidth     =   9795
   ForeColor       =   &H00C0C0C0&
   Icon            =   "Bacinidi.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5775
   ScaleWidth      =   9795
   Begin Threed.SSCheck ChkALCO 
      Height          =   255
      Left            =   45
      TabIndex        =   26
      Top             =   2640
      Width           =   2685
      _Version        =   65536
      _ExtentX        =   4736
      _ExtentY        =   450
      _StockProps     =   78
      Caption         =   "Actualiza Limites Alco"
      ForeColor       =   8388608
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Font3D          =   1
   End
   Begin Threed.SSFrame SSF_Status 
      Height          =   5220
      Left            =   0
      TabIndex        =   9
      Top             =   525
      Width           =   3330
      _Version        =   65536
      _ExtentX        =   5874
      _ExtentY        =   9208
      _StockProps     =   14
      Caption         =   "Status"
      ForeColor       =   8388608
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Font3D          =   3
      Begin Threed.SSCheck ChkLineasDRV 
         Height          =   255
         Left            =   3045
         TabIndex        =   24
         Top             =   2820
         Visible         =   0   'False
         Width           =   2820
         _Version        =   65536
         _ExtentX        =   4974
         _ExtentY        =   450
         _StockProps     =   78
         Caption         =   "Actualización de Lineas DRV"
         ForeColor       =   8388608
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
      Begin Threed.SSCheck ChkRc 
         Height          =   315
         Left            =   45
         TabIndex        =   10
         Top             =   990
         Width           =   2835
         _Version        =   65536
         _ExtentX        =   5001
         _ExtentY        =   556
         _StockProps     =   78
         Caption         =   "Recompras Automáticas"
         ForeColor       =   8388608
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.26
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Font3D          =   1
      End
      Begin Threed.SSCheck ChkLineas 
         Height          =   315
         Left            =   3045
         TabIndex        =   11
         Top             =   2400
         Visible         =   0   'False
         Width           =   2835
         _Version        =   65536
         _ExtentX        =   5001
         _ExtentY        =   556
         _StockProps     =   78
         Caption         =   "Actualización de Lineas"
         ForeColor       =   8388608
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.26
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Font3D          =   1
      End
      Begin Threed.SSCheck Chkrv 
         Height          =   315
         Left            =   45
         TabIndex        =   12
         Top             =   1230
         Width           =   2835
         _Version        =   65536
         _ExtentX        =   5001
         _ExtentY        =   556
         _StockProps     =   78
         Caption         =   "Reventas Automáticas"
         ForeColor       =   8388608
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.26
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Font3D          =   1
      End
      Begin Threed.SSCheck ChKact 
         Height          =   315
         Left            =   45
         TabIndex        =   13
         Top             =   495
         Width           =   2835
         _Version        =   65536
         _ExtentX        =   5001
         _ExtentY        =   556
         _StockProps     =   78
         Caption         =   "Actualiza Cartera"
         ForeColor       =   8388608
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.26
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Font3D          =   1
      End
      Begin Threed.SSCheck chkDevengamientoDolares 
         Height          =   315
         Left            =   45
         TabIndex        =   14
         Top             =   240
         Width           =   2835
         _Version        =   65536
         _ExtentX        =   5001
         _ExtentY        =   556
         _StockProps     =   78
         Caption         =   "Devengamiento Dolares"
         ForeColor       =   8388608
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.26
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Font3D          =   1
      End
      Begin Threed.SSCheck ChkSorteo 
         Height          =   315
         Left            =   45
         TabIndex        =   15
         Top             =   1485
         Width           =   2835
         _Version        =   65536
         _ExtentX        =   5001
         _ExtentY        =   556
         _StockProps     =   78
         Caption         =   "Sorteo de Letras"
         ForeColor       =   8388608
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.26
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Font3D          =   1
      End
      Begin Threed.SSCheck ChkCoberturas 
         Height          =   315
         Left            =   45
         TabIndex        =   16
         Top             =   1740
         Width           =   2835
         _Version        =   65536
         _ExtentX        =   5001
         _ExtentY        =   556
         _StockProps     =   78
         Caption         =   "Actualización de Coberturas"
         ForeColor       =   8388608
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.26
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Font3D          =   1
      End
      Begin Threed.SSCheck ChkCarteraLibreTrading 
         Height          =   315
         Left            =   45
         TabIndex        =   23
         Top             =   735
         Width           =   2835
         _Version        =   65536
         _ExtentX        =   5001
         _ExtentY        =   556
         _StockProps     =   78
         Caption         =   "Cartera Libre Trading"
         ForeColor       =   8388608
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.26
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Font3D          =   1
      End
      Begin Threed.SSCheck ChkPCargaPAEIBS 
         Height          =   315
         Left            =   3045
         TabIndex        =   25
         Top             =   2040
         Visible         =   0   'False
         Width           =   2715
         _Version        =   65536
         _ExtentX        =   4789
         _ExtentY        =   556
         _StockProps     =   78
         Caption         =   "Carga Préstamos IBS"
         ForeColor       =   8388608
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.26
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Font3D          =   1
      End
      Begin Threed.SSCheck SSCheckNDRV 
         Height          =   255
         Left            =   3045
         TabIndex        =   27
         Top             =   3120
         Visible         =   0   'False
         Width           =   3180
         _Version        =   65536
         _ExtentX        =   5609
         _ExtentY        =   450
         _StockProps     =   78
         Caption         =   "Nva Actualización de Líneas DRV"
         ForeColor       =   8388608
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
      Begin VB.Label Label6 
         Caption         =   "RECOMPRAS"
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
         Height          =   210
         Left            =   45
         TabIndex        =   20
         Top             =   3480
         Width           =   2835
      End
      Begin VB.Label Label1 
         BorderStyle     =   1  'Fixed Single
         Caption         =   " "
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
         Height          =   270
         Left            =   45
         TabIndex        =   19
         Top             =   3720
         Width           =   2865
      End
      Begin VB.Label Label2 
         BorderStyle     =   1  'Fixed Single
         Caption         =   " "
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
         Left            =   45
         TabIndex        =   18
         Top             =   4200
         Width           =   2835
      End
      Begin VB.Label Label3 
         BorderStyle     =   1  'Fixed Single
         Caption         =   " "
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
         Left            =   45
         TabIndex        =   17
         Top             =   4800
         Width           =   2835
      End
      Begin VB.Label Label4 
         Caption         =   "VENCIMIENTOS"
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
         Height          =   270
         Left            =   45
         TabIndex        =   22
         Top             =   4560
         Width           =   2865
      End
      Begin VB.Label Label5 
         Caption         =   "REVENTAS"
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
         Height          =   270
         Left            =   45
         TabIndex        =   21
         Top             =   3960
         Width           =   2835
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   8
      Top             =   0
      Width           =   9795
      _ExtentX        =   17277
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
            Key             =   "cmdBuscar"
            Description     =   "Buscar"
            Object.ToolTipText     =   "Buscar Datos"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdGrabar"
            Description     =   "Grabar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdLimpiar"
            Description     =   "Limpiar"
            Object.ToolTipText     =   "Limpiar Pantalla"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdSalir"
            Description     =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   4
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   2490
      Top             =   105
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
            Picture         =   "Bacinidi.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacinidi.frx":075C
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacinidi.frx":0BAE
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacinidi.frx":0EC8
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin Threed.SSFrame FrmMonedas 
      Height          =   4425
      Left            =   3360
      TabIndex        =   4
      Top             =   1320
      Width           =   6360
      _Version        =   65536
      _ExtentX        =   11218
      _ExtentY        =   7805
      _StockProps     =   14
      Caption         =   " Valores de Monedas "
      ForeColor       =   8388608
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Font3D          =   3
      Begin BACControles.TXTNumero text1 
         Height          =   225
         Left            =   105
         TabIndex        =   3
         Top             =   495
         Visible         =   0   'False
         Width           =   960
         _ExtentX        =   1693
         _ExtentY        =   397
         BackColor       =   12632256
         ForeColor       =   8388608
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
         BorderStyle     =   0
         Text            =   "0.0000"
         Text            =   "0.0000"
         Max             =   "99999999999999999.9999"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
         SelStart        =   2
      End
      Begin MSFlexGridLib.MSFlexGrid Grilla 
         Height          =   3990
         Left            =   30
         TabIndex        =   2
         Top             =   195
         Width           =   6285
         _ExtentX        =   11086
         _ExtentY        =   7038
         _Version        =   393216
         Cols            =   6
         FixedCols       =   0
         BackColor       =   12632256
         ForeColor       =   8388608
         BackColorFixed  =   8421376
         ForeColorFixed  =   16777215
         BackColorSel    =   8388608
         ForeColorSel    =   8388608
         GridColor       =   255
         GridColorFixed  =   8421504
         FillStyle       =   1
         GridLines       =   2
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
   Begin Threed.SSFrame FrmFechas 
      Height          =   705
      Left            =   3360
      TabIndex        =   5
      Top             =   600
      Width           =   6360
      _Version        =   65536
      _ExtentX        =   11218
      _ExtentY        =   1244
      _StockProps     =   14
      Caption         =   " Fechas de Proceso "
      ForeColor       =   8388608
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Font3D          =   3
      Begin BACControles.TXTFecha TxtFecProx 
         Height          =   315
         Left            =   3780
         TabIndex        =   1
         Top             =   300
         Width           =   1245
         _ExtentX        =   2196
         _ExtentY        =   556
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "07/11/2000"
      End
      Begin BACControles.TXTFecha TxtFecPro 
         Height          =   315
         Left            =   120
         TabIndex        =   0
         Top             =   300
         Width           =   1245
         _ExtentX        =   2196
         _ExtentY        =   556
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "07/11/2000"
      End
      Begin VB.Label Lbl_FecPrx 
         Alignment       =   2  'Center
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   300
         Left            =   5025
         TabIndex        =   7
         Top             =   300
         Width           =   1245
      End
      Begin VB.Label Lbl_FecPro 
         Alignment       =   2  'Center
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   300
         Left            =   1350
         TabIndex        =   6
         Top             =   300
         Width           =   1245
      End
   End
End
Attribute VB_Name = "BacIniDia"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim Status_Dev             As String         'Estado del devengamiento
                                             '  0: Proceso OK
                                             '  1: Problemas en la ejecución y
                                             '  2:Problema en el devengamiento
Dim Mensaje_Dev            As String         'Mensaje devengamiento
Dim Retorno_Dev            As String         'Retorno del procedimiento del devengamiento
Dim swDevengo              As String         'Flag que identifica si esta devengado
Dim Fecha_Proceso_Dev      As String         'Fecha Proceso del devengo
Dim Fecha_Proximo_Dev      As String         'Fecha Proximo Proceso del devengo
Dim Fecha_Cierre_Mes       As String         'Cierre de Mes
Dim Fecha_Proceso          As String         'Fecha Proceso
Dim Fecha_Anterior         As String         'Fecha Proceso
Dim Fecha_Proximo_Proceso  As String         'Fecha Proximo Proceso
Dim valPCDUSD              As Double
Dim valPCDUF               As Double
Dim valPTF                 As Double
Dim gsBac_FM               As Date

Dim cCategoria             As Single
Dim cTasa                  As Single
Dim cFecpro                As String
Dim cFecprox               As String
Dim cSW_PD                 As String
Private objMensajesPD      As Object
Dim bFlagEdit              As Boolean
Dim bParidadesBCCH         As Boolean

Dim Vcol%
Dim i%
Dim mens1$
Dim j%
Dim a1%
Dim nPos%
Dim ContOp$
Dim VCodigo$
Dim VGlosa$
Dim KeyAscii%

'Variables utilizadas en Sql Server
Dim SQL                    As String
Dim Datos()
Dim Proceso As String
Dim Prox_Proc As String
Dim Anterior As String

Private Function Func_Devengar_Dolares() As Boolean

    Func_Devengar_Dolares = False

    If Not Func_Cartera_Inversiones Then
        Exit Function
    End If
    
    If Status_Dev <> "0" Then
        Exit Function
    End If
    
    If Not Func_Compras_Con_Pacto Then
        Exit Function
    End If
   
    If Status_Dev <> "0" Then
       Exit Function
    End If
    
    If Not Func_Ventas_Con_PactoDolar Then
        Exit Function
    End If
   
    If Status_Dev <> "0" Then
        Exit Function
    End If
    
    If Not Func_Interbancario Then
        Exit Function
    End If
    
    If Status_Dev <> "0" Then
        Exit Function
    End If
    
    Func_Devengar_Dolares = True
    
End Function

Private Function Func_Cartera_Inversiones() As Boolean
   
   Dim Sw_Devengo_Ok    As String
   Dim Msg_Devengo      As String
   
   Func_Cartera_Inversiones = False
    
   If gsBac_Fecp <> gsBac_FM And Fecha_Proceso_Dev > gsBac_FM Then
      Fecha_Anterior = gsBac_FM
   End If

   Status_Dev = "0"
   Mensaje_Dev = ""

   Envia = Array()
   AddParam Envia, Format(Fecha_Anterior, "yyyymmdd")
   AddParam Envia, Format(Fecha_Proceso_Dev, "yyyymmdd")
   AddParam Envia, valPCDUSD
   AddParam Envia, valPCDUF
   AddParam Envia, valPTF
   AddParam Envia, "S"
   
   If Bac_Sql_Execute("SP_DEVPROPIAINTER", Envia) Then
      Do While Bac_SQL_Fetch(Datos())
         If Datos(1) <> "SI" Then
            Status_Dev = "2"
         End If
         Retorno_Dev = Datos(2)
      Loop
      
      If Status_Dev <> "0" Then
         Mensaje_Dev = "El Proceso de Devengamiento de la CARTERA DE INVERSIONES Ha Fallado" + vbCrLf + Trim(Datos(2))
      End If
   Else
     'Problema en la ejecución del procedimiento
      Status_Dev = "1"

      Retorno_Dev = ""
      Mensaje_Dev = "Ha ocurrido un error en el proceso de devengamiento de la cartera de inversiones, SP_DEVPROPIAINTER "
      Exit Function
   End If
   
   Valor_antiguo = " "
   Valor_antiguo = "Fecha anterior = " & Fecha_Anterior & ";Fecha Proceso Devengo=" & Fecha_Proceso_Dev & ";Mensaje=" & Mensaje_Dev
   Call GRABA_LOG_AUDITORIA(1, gsBac_Fecp, gsBac_IP, gsBac_User, "BTR", "Opc_10100", "01", "Devengo en Dólares Cart Inv.", "mdrs", Valor_antiguo, " ")
   
   Func_Cartera_Inversiones = True
   
End Function

Private Function Func_Compras_Con_Pacto() As Boolean
   Dim Sw_Devengo_Ok    As String
   Dim Msg_Devengo      As String
   
   Func_Compras_Con_Pacto = False

   If gsBac_Fecp <> gsBac_FM And Fecha_Proceso_Dev > gsBac_FM Then
      Fecha_Anterior = gsBac_FM
   End If

   Status_Dev = "0"
   Mensaje_Dev = ""
   
   Envia = Array(Format(Fecha_Anterior, "yyyymmdd"), _
                 Format(Fecha_Proceso_Dev, "yyyymmdd"), _
                 CDbl(valPCDUSD), _
                 CDbl(valPCDUF), _
                 CDbl(valPTF), _
                 "S")
   If Bac_Sql_Execute("SP_DEVENGO_COMPRAS_CON_PACTO", Envia) Then
      Do While Bac_SQL_Fetch(Datos())
         If Datos(1) <> "OK" Then
            Status_Dev = "2"
         End If
         Retorno_Dev = Datos(2)
      Loop
      If Status_Dev <> "0" Then
         Mensaje_Dev = "El Proceso de Devengamiento de las COMPRAS CON PACTO Ha Fallado" + vbCrLf + Trim(Datos(2))
      End If
   Else
     'Problema en la ejecución del procedimiento
      Status_Dev = "1"
      Retorno_Dev = ""
      Mensaje_Dev = "Ha ocurrido un error en el devengamiento de compras con pacto, SP_DEVENGO_COMPRAS_CON_PACTO"
      Exit Function
   End If

   Valor_antiguo = " "
   Valor_antiguo = "Fecha anterior = " & Fecha_Anterior & ";Fecha Proceso Devengo=" & Fecha_Proceso_Dev & ";Mensaje=" & Mensaje_Dev
   Call GRABA_LOG_AUDITORIA(1, gsBac_Fecp, gsBac_IP, gsBac_User, "BTR", "Opc_10100", "01", "Devengo en Dólares Compras con Pacto", "mdrs", Valor_antiguo, " ")
   
   Func_Compras_Con_Pacto = True
   
End Function

Private Function Func_Interbancario() As Boolean
   Dim Sw_Devengo_Ok    As String
   Dim Msg_Devengo      As String
   
   Func_Interbancario = False

   If gsBac_Fecp <> gsBac_FM And Fecha_Proceso_Dev > gsBac_FM Then
      Fecha_Anterior = gsBac_FM
   End If

   Status_Dev = "0"
   Mensaje_Dev = ""
   
   Envia = Array(Format(Fecha_Anterior, "yyyymmdd"), _
                 Format(Fecha_Proceso_Dev, "yyyymmdd"), _
                 "S")
   If Bac_Sql_Execute("SP_DEVENGO_INTERBANCARIOS", Envia) Then
      Do While Bac_SQL_Fetch(Datos())
         If Datos(1) <> "OK" Then
            Status_Dev = "2"
''''            MsgBox datos(2), vbCritical, Me.Caption
         End If
         Retorno_Dev = Datos(2)
      Loop
      If Status_Dev <> "0" Then
''''         Mensaje_Dev = "El Proceso de Devengamiento de INTERBANCARIOS Termino OK"
''''      Else
         Mensaje_Dev = "El Proceso de Devengamiento de INTERBANCARIOS Ha Fallado" + vbCrLf + Trim(Datos(2))
      End If
   Else
     'Problema en la ejecución del procedimiento
      Status_Dev = "1"
''''      Mensaje_Dev = "El Proceso de Devengamiento INTERBANCARIOS Ha Fallado"
      Retorno_Dev = ""
      Mensaje_Dev = "Ha ocurrido un error al devengar los interbancarios, SP_DEVENGO_INTERBANCARIOS"
      Exit Function
   End If

   Valor_antiguo = " "
   Valor_antiguo = "Fecha anterior = " & Fecha_Anterior & ";Fecha Proceso Devengo=" & Fecha_Proceso_Dev & ";Mensaje=" & Mensaje_Dev

   Call GRABA_LOG_AUDITORIA(1, gsBac_Fecp, gsBac_IP, gsBac_User, "BTR", "Opc_10100", "01", "Devengo Interbancarios en Dólares.", "mdrs", Valor_antiguo, " ")
   
   Func_Interbancario = True
   
End Function


' ==================================================================
'   Función     :   funcProcesaRecompras
'   Objetivo    :   Realiza el proceso de recompras automaticas
' ==================================================================

Function funcProcesaRecompras() As Boolean
   funcProcesaRecompras = False
''''   Screen.MousePointer = vbHourglass
   
   Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Inicio de proceso de recompras automaticas")
    
   Envia = Array(gsBac_User, gsBac_IP)
   If Not Bac_Sql_Execute("SP_RECOMPRA_AUTOMATICA", Envia) Then
      Label1.Caption = "ERROR"
      Exit Function
   End If
   If Bac_SQL_Fetch(Datos()) Then
      If Datos(1) = "NO" Then
         Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Proceso de recompras automaticas falló ")
         Label1.Caption = "ERROR"
         Mensaje_Dev = Trim(Datos(2))
         Exit Function
      Else
         Valor_antiguo = " "
         Valor_antiguo = "Fecha Proceso = " & TxtFecPro.text & ";Nº RC =" & Datos(2)
         Label1.Caption = Datos(2)
      End If
   End If
    
   Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, (Datos(2)))
   
   Call GRABA_LOG_AUDITORIA(1, gsBac_Fecp, gsBac_IP, gsBac_User, "BTR", "Opc_10100", "01", "Recompras", "mdmo", Valor_antiguo, " ")
   
   funcProcesaRecompras = True

End Function

Function funcProcesaReventas() As Boolean
   
   funcProcesaReventas = False

    
   Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Inicio de proceso de reventas automaticas")

   Envia = Array(gsBac_User, gsBac_IP)
   If Not Bac_Sql_Execute("SP_REVENTA_AUTOMATICA", Envia) Then
      Label2.Caption = "ERROR "
      Exit Function
   End If
   If Bac_SQL_Fetch(Datos()) Then
      If Datos(1) = "NO" Then
         Mensaje_Dev = Trim(Datos(2))
         Label2.Caption = "ERROR "
         Exit Function
      Else
         Valor_antiguo = " "
         Valor_antiguo = "Fecha Proceso = " & TxtFecPro.text & ";Nº RV =" & Datos(2)
         Label2.Caption = Datos(2)
      End If
   End If
    
   Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, (Datos(2)))
        
   funcProcesaReventas = True
    
   Valor_antiguo = " "
   Valor_antiguo = "Fecha Proceso = " & TxtFecPro.text & ";" & Label2.Caption

   Call GRABA_LOG_AUDITORIA(1, gsBac_Fecp, gsBac_IP, gsBac_User, "BTR", "Opc_10100", "01", "Reventas", "mdmo", Valor_antiguo, " ")
End Function

Function FuncReabajaLineas() As Boolean
   FuncReabajaLineas = False

   Envia = Array()
   AddParam Envia, CDate(cFecpro)
   AddParam Envia, "BTR"
   
   If Not Bac_Sql_Execute("SP_LINEAS_ACTUALIZARMONTOS", Envia) Then
      Exit Function
   End If
   
   FuncReabajaLineas = True

End Function

Function funcProcesaVencCaptaciones() As Boolean
   Label3.Caption = "TOTAL 0"
        
   funcProcesaVencCaptaciones = True
   Screen.MousePointer = vbDefault
End Function

Private Sub Func_Grabar_Datos()
   On Error GoTo Label1
   Dim nContador        As Long
   Dim iRow             As Long
   Dim cCodigo          As Integer
   Dim nValor           As Double
   Dim nCodBcch         As Integer
   Dim objValoresMoneda As Object
   Dim bOk              As Boolean
   Dim i                As Integer
   Dim cGtiasVencidas   As Long
   Dim msgGtias         As String
   
   Let Screen.MousePointer = vbHourglass
    cGtiasVencidas = 0
    'Revisar si hay garantías constituídas vencidas
    cGtiasVencidas = CantidadGtiasVencidas("C")
    If cGtiasVencidas = -1 Then
        MsgBox "Error! No es posible obtener la cantidad de Garantías Vencidas.", vbExclamation, TITSISTEMA
        Exit Sub
    End If
    If cGtiasVencidas > 0 Then
         'Hay Gtías Vencidas, eliminarlas.  Mostrar mensaje recordatorio
         msgGtias = "Hay " & Trim(CStr(cGtiasVencidas)) & " Garantías Constituídas vencidas."
         MsgBox msgGtias & vbCrLf & vbCrLf & "Recuerde que debe eliminar estas Garantías.", vbInformation, TITSISTEMA
    End If

   '--> Se debe haber ingresado la Tasa Estimada para los Bonos Flotantes
   For nContador = 1 To GRILLA.Rows - 1
      If GRILLA.TextMatrix(nContador, 3) = 302 Then
         If CDbl(GRILLA.TextMatrix(nContador, 1)) = 0 Then
            Let Screen.MousePointer = vbDefault
            Call MsgBox(" ¡ Debe ingresar la Tasa Estimada para los Bonos Flotantes !", vbExclamation, TITSISTEMA)
            On Error GoTo 0
            Exit Sub
         End If
      End If
   Next nContador

   '-->  Valida las Fechas de Proceso
   If BacChkFechas() = False Then
      Let Screen.MousePointer = vbDefault
      Call MsgBox(" ¡ Error en la fecha de proceso o próximo proceso !", vbCritical, TITSISTEMA)
      On Error GoTo 0
      Exit Sub
   End If

   '-->  Graba los valores para las Monedas
   Set objValoresMoneda = New clsValoresMoneda

   For nContador = 1 To GRILLA.Rows - 1
      Call objValoresMoneda.Agregar(CDbl(GRILLA.TextMatrix(nContador, 3)), TxtFecPro.text, CDbl(GRILLA.TextMatrix(nContador, 1)))
      Call objValoresMoneda.Agregar(CDbl(GRILLA.TextMatrix(nContador, 3)), TxtFecProx.text, CDbl(GRILLA.TextMatrix(nContador, 2)))
   Next nContador
    
   Call GRABA_LOG_AUDITORIA(1, gsBac_Fecp, gsBac_IP, gsBac_User, "BTR", "Opc_10100", "01", "Comienza proceso de inicio de dia", "", "", " ")

   '*******************************************************************************
   Call Bac_Sql_Execute("Begin Transaction")
   '*******************************************************************************

   '-->  Grabamos Valores de Monedas
   If objValoresMoneda.Grabar() = True Then

      '-->  Se realiza proceso de devengamiento de dolares
      bOk = False

      'SE CAMBIO PARA REALIZAR LOS VENCIMIENTOS 'Primero se debe cambiar la fecha
      cFecpro = CStr(TxtFecPro.text)
      cFecprox = CStr(TxtFecProx.text)
        
      If Not BacGrabarParamAc(cFecpro, cFecprox) Then
         Let Screen.MousePointer = vbDefault
         Call Bac_Sql_Execute("Rollback Transaction")
         Call GRABA_LOG_AUDITORIA(1, gsBac_Fecp, gsBac_IP, gsBac_User, "BTR", "Opc_10100", "01", "Error en: Grabación de Fechas y actualización de Swith Diarios", "", "", " ")
         Call MsgBox("Ha ocurrido un error al intentar actualizar la fecha de proceso", vbCritical, TITSISTEMA)
         Call Proc_Limpia_Check
         Exit Sub
      End If

      'PROD-10967
      If Not Bac_Sql_Execute("SP_TRASPASOOPERVENCIDASMIDDLE") Then
         Let Screen.MousePointer = vbDefault
         Call Bac_Sql_Execute("Rollback Transaction")
         Call MsgBox("Ha ocurrido un error al intentar transferir vencimientos a tablas históricas", vbCritical, TITSISTEMA)
         Call Proc_Limpia_Check
         Exit Sub
      End If
      'PROD-10967

      '-->  Devengar
      If Bac_Sql_Execute("SP_CHKFECHASDEVENGAMIENTO") Then
         If Bac_SQL_Fetch(Datos()) Then
            Let Fecha_Proceso = Datos(1)
            Let Fecha_Proximo_Proceso = Datos(2)
            Let Fecha_Cierre_Mes = Datos(3)
            Let valPCDUSD = Datos(4)
            Let valPCDUF = Datos(5)
            Let valPTF = Datos(6)
            Let swDevengo = Datos(7)
            Let Fecha_Anterior = Datos(11)
         End If
      Else
         Call Bac_Sql_Execute("Rollback Transaction")
         Call GRABA_LOG_AUDITORIA(1, gsBac_Fecp, gsBac_IP, gsBac_User, "BTR", "Opc_10100", "01", "Error en: SP_CHKFECHASDEVENGAMIENTO", "", "", " ")
         Let Screen.MousePointer = vbDefault
         Call MsgBox("Ha ocurrido un error al intentar verificar las fechas de devengamiento", vbCritical, TITSISTEMA)
         Call Proc_Limpia_Check
         Exit Sub
      End If

      Let Fecha_Proceso_Dev = Fecha_Proceso
      Let Fecha_Proximo_Dev = Fecha_Cierre_Mes

      Let gsBac_FM = CDate("01/" + Str(Month(Fecha_Anterior)) + "/" + Str(Year(Fecha_Anterior)))
      Let gsBac_FM = DateAdd("m", 1, gsBac_FM)
      Let gsBac_FM = DateAdd("d", -1, gsBac_FM)

      '--> Cambia el Color del Flag del Devengamiento
      Let chkDevengamientoDolares.ForeColor = vbRed
      Call BacControlWindows(1)

      Let Mensaje_Dev = ""
        
      If Not Func_Devengar_Dolares Then
         Let Screen.MousePointer = vbDefault
         Call Bac_Sql_Execute("Rollback Transaction")
         Call GRABA_LOG_AUDITORIA(1, gsBac_Fecp, gsBac_IP, gsBac_User, "BTR", "Opc_10100", "01", Mensaje_Dev, "", "", " ")

         If Mensaje_Dev <> "" Then
            Call MsgBox(Mensaje_Dev, vbExclamation, TITSISTEMA)
         Else
            Call MsgBox("Ha ocurrido un error al intentar ejecutar el devengo de dolares", vbCritical, TITSISTEMA)
         End If
         
         Call Proc_Limpia_Check
         Exit Sub
      End If
      

      '--> Cambia el Estado y el Color del Flag del Devengamiento
      Let chkDevengamientoDolares.Value = True
      Let chkDevengamientoDolares.ForeColor = &H800000
      Call BacControlWindows(1)
      
      '--> Cambia el Color del Flag de la Actualización de Cartera
      Let ChKact.ForeColor = vbRed
      Call BacControlWindows(1)

      If Bac_Sql_Execute("SP_ACTUALIZA_CARTERA") Then
         Do While Bac_SQL_Fetch(Datos())
            If Datos(1) = "SI" Then
               '--> Cambia el Estado y el Color del Flag de la Actualización de Cartera
               Let ChKact.Value = True
               Let ChKact.ForeColor = &H800000
            Else
               Let Screen.MousePointer = vbDefault
               Call Bac_Sql_Execute("Rollback Transaction")
               Call GRABA_LOG_AUDITORIA(1, gsBac_Fecp, gsBac_IP, gsBac_User, "BTR", "Opc_10100", "01", "Error en: SP_ACTUALIZA_CARTERA - " + Trim(Datos(2)), "", "", " ")
               Call MsgBox(Datos(2), vbCritical, TITSISTEMA)
               Call Proc_Limpia_Check
               Exit Sub
            End If
         Loop
      Else
         Let Screen.MousePointer = vbDefault
         Call Bac_Sql_Execute("Rollback Transaction")
         Call GRABA_LOG_AUDITORIA(1, gsBac_Fecp, gsBac_IP, gsBac_User, "BTR", "Opc_10100", "01", "Error en: SP_ACTUALIZA_CARTERA", "", "", " ")
         Call MsgBox("Ha ocurrido un error al intentar actualizar cartera", vbCritical, TITSISTEMA)
         Call Proc_Limpia_Check
         Exit Sub
      End If

      '--> Cambia el Color del Flag de la Cartera Libre de Trading
      Let ChkCarteraLibreTrading.ForeColor = vbRed
      Call BacControlWindows(1)

      Envia = Array()
      AddParam Envia, GLB_ID_SISTEMA
      If Not Bac_Sql_Execute("SP_ACT_CARTERA_LIBRE_TRADING", Envia) Then
         Let Screen.MousePointer = vbDefault
         Call Bac_Sql_Execute("Rollback Transaction")
         Call GRABA_LOG_AUDITORIA(1, gsBac_Fecp, gsBac_IP, gsBac_User, "BTR", "Opc_10100", "01", "Error en: SP_ACT_CARTERA_LIBRE_TRADING", "", "", " ")
         Call MsgBox("Ha ocurrido un error al intentar respaldar la cartera libre de trading", vbCritical, TITSISTEMA)
         Call Proc_Limpia_Check
         Exit Sub
      Else
         '--> Cambia el Estado y el Color del Flag de la Cartera Libre de Trading
         Let ChkCarteraLibreTrading.Value = True
         Let ChkCarteraLibreTrading.ForeColor = &H800000
      End If

      Let Valor_antiguo = " "
      Let Valor_antiguo = "Fecha Proceso = " & TxtFecPro.text

      Call GRABA_LOG_AUDITORIA(1, gsBac_Fecp, gsBac_IP, gsBac_User, "BTR", "Opc_10100", "01", "Actualización de Cartera", "mdrs", Valor_antiguo, " ")


      '--> Cambia el Color del Flag de las Recompras
      Let ChkRc.ForeColor = vbRed
      Call BacControlWindows(1)

      ' PROCESO DE RECOMPRA
      Let Mensaje_Dev = ""
      If Not ChkRc.Value Then
         If Not funcProcesaRecompras Then
            Let Screen.MousePointer = vbDefault
            Call Bac_Sql_Execute("Rollback Transaction")
            
            If Mensaje_Dev <> "" Then
               Call MsgBox(Mensaje_Dev, vbExclamation, TITSISTEMA)
               Call GRABA_LOG_AUDITORIA(1, gsBac_Fecp, gsBac_IP, gsBac_User, "BTR", "Opc_10100", "01", "Recompras: Mensaje_Dev", "", "", " ")
            Else
               Call MsgBox("Ha ocurrido un error al intentar ejecutar el proceso de recompras automaticas", vbCritical, TITSISTEMA)
               Call GRABA_LOG_AUDITORIA(1, gsBac_Fecp, gsBac_IP, gsBac_User, "BTR", "Opc_10100", "01", "Error en : SP_RECOMPRA_AUTOMATICA", "", "", " ")
            End If
            
            Call Proc_Limpia_Check
            Exit Sub
         End If
         
         '--> Cambia el Estado y el Color del Flag de las Recompras
         Let ChkRc.Value = True
         Let ChkRc.ForeColor = &H800000
      End If
      
      '--> Cambia el Color del Flag de las Reventas
      Let Chkrv.ForeColor = vbRed
      Call BacControlWindows(1)
      
      
    '=============================================================================================================
    ' LD1-COR-035-Configuración BAC Corpbanca, Tema: Carga de Cartera FINDUR Forward por limite Endeudamiento
    ' INICIO
    '=============================================================================================================

        Dim varFechaProcesoEnduda, varRutaInterfazEndeuda

        varFechaProcesoEnduda = ""
'        varRutaInterfazEndeuda = ""
'        If Not Bac_Sql_Execute("BacParamSuda..sp_Busca_InterfazEndudamiento") Then
'           MsgBox "Problemas al leer ruta para interfaz de carga cartera Endeudamiento FWD.", vbCritical, TITSISTEMA
'           Exit Sub
'        End If
'
'        If Bac_SQL_Fetch(DATOS()) Then
'           varFechaProcesoEnduda = DATOS(1)
'           varRutaInterfazEndeuda = DATOS(2)
'        End If
'
'           ' Procesar Interfaz
'        If Not funCargaInterfaz(varFechaProcesoEnduda, varRutaInterfazEndeuda) Then
'           MsgBox "Problemas cargar Interfaz de Limites de Endeudamiento", vbExclamation, gsBac_Version
'           GoTo Label1
'        End If

    '=============================================================================================================
    ' LD1-COR-035-Configuración BAC Corpbanca, Tema: Carga de Cartera FINDUR Forward por limite Endeudamiento
    ' FIN
    '=============================================================================================================

      ' PROCESO DE REVENTA
      Let Mensaje_Dev = ""
      If Not Chkrv.Value Then
         If Not funcProcesaReventas Then
            Let Screen.MousePointer = vbDefault
            Call Bac_Sql_Execute("Rollback Transaction")
                
            If Mensaje_Dev <> "" Then
               Call MsgBox(Mensaje_Dev, vbExclamation, TITSISTEMA)
               Call GRABA_LOG_AUDITORIA(1, gsBac_Fecp, gsBac_IP, gsBac_User, "BTR", "Opc_10100", "01", "Reventas : Mensaje_Dev", "", "", " ")
            Else
               Call MsgBox("Ha ocurrido un error al intentar ejecutar el proceso de reventas automaticas", vbCritical, TITSISTEMA)
               Call GRABA_LOG_AUDITORIA(1, gsBac_Fecp, gsBac_IP, gsBac_User, "BTR", "Opc_10100", "01", "Error en: SP_REVENTA_AUTOMATICA", "", "", " ")
            End If
                
            Call Proc_Limpia_Check
            Exit Sub
         Else
            '--> Cambia el Estado y el Color del Flag de las Reventas
            Let Chkrv.Value = True
            Let Chkrv.ForeColor = &H800000
         End If
      End If

'''    '+++jcamposd 20160606, no se utiliza en el nuevo banco
'''      'LD1-COR-035 VALIDACION ALCO
'''      '---------- 10-11-2015 ----------
'''      'Proceso de Recalculo de Limites ALCO
'''      '************************************
'''      If Not Proc_Recalcula_Limites_ALCO Then
'''         MsgBox "Problemas al Actualizar Lineas de Límites ALCO.", vbAbortRetryIgnore, Me.Caption
'''      Else
'''         ChkALCO.Value = True
'''      End If
'''        '************************************
'''        'LD1-COR-035 VALIDACION ALCO
'''    '---jcamposd 20160606, no se utiliza en el nuevo banco

      '--> Cambia el Color del Flag del Sorteo de Letras
      Let ChkSorteo.ForeColor = vbRed
      Call BacControlWindows(1)

      If Not ChkSorteo.Value Then
         If Not Bac_Sql_Execute("TRASPASOSORTEOLCHR") Then
            Let Screen.MousePointer = vbDefault
            Call Bac_Sql_Execute("Rollback Transaction")
            Call GRABA_LOG_AUDITORIA(1, gsBac_Fecp, gsBac_IP, gsBac_User, "BTR", "Opc_10100", "01", "Error en: TRASPASOSORTEOLCHR", "", "", " ")
            Call MsgBox("Ha ocurrido un error al ejecutar el proceso de generación del sorteo de letras ", vbCritical, TITSISTEMA)
            Call Proc_Limpia_Check
            Exit Sub
         Else
            '--> Cambia el Estado y el Color del Flag del Sorteo de Letras
            Let ChkSorteo.Value = True
            Let ChkSorteo.ForeColor = &H800000
         End If
      End If


      Let gsBac_Fecp = cFecpro
      Let gsBac_Fecx = cFecprox
      Let BacTrader.Pnl_Fecha.Caption = Format(gsBac_Fecp, "dd/mm/yyyy")

      If Not GRILLA.Rows > 1 Then
         On Error GoTo 0
         Exit Sub
      End If

      With GRILLA
         For iRow = 1 To GRILLA.Rows - 1
            GRILLA.Row = iRow
            If Trim$(GRILLA.TextMatrix(GRILLA.Row, 0)) <> "" Then
               GRILLA.Col = 3: cCodigo = GRILLA.text
               nValor = F_FomateaValor(GRILLA.TextMatrix(GRILLA.Row, 1), ",", ".")
                    
               GRILLA.Col = 4: nCodBcch = Val(GRILLA.text)
               TxtFecPro.text = Format(TxtFecPro.text, "dd/mm/yyyy")
                    
               Call objValoresMoneda.Agregar(cCodigo, CStr(TxtFecPro.text), nValor)
               nValor = F_FomateaValor(GRILLA.TextMatrix(GRILLA.Row, 2), ",", ".")
                    
               TxtFecProx.text = Format(TxtFecProx.text, "dd/mm/yyyy")
               Call objValoresMoneda.Agregar(cCodigo, CStr(TxtFecProx.text), nValor)
            End If
         Next iRow
      End With
      
        
      ' ========================================================================
      ' Ejecuto Proceso que se encarga de cambiar datos por el cambio de Fechas
      ' ========================================================================
      If Not Proc_Carga_Parametros Then
         Let Screen.MousePointer = vbDefault
         Call Bac_Sql_Execute("Rollback Transaction")
         Call GRABA_LOG_AUDITORIA(1, gsBac_Fecp, gsBac_IP, gsBac_User, "BTR", "Opc_10100", "01", "Error en: SP_PARAMETROS_SISTEMA", "", "", " ")

         Call MsgBox("Ha ocurrido un errror al intentar cargar los parametros diarios", vbCritical, TITSISTEMA)
         Call Proc_Limpia_Check
         Exit Sub
      End If
      
      ' ========================================================================
      Let Toolbar1.Buttons(2).Enabled = False
   
   Else
      
      Let Screen.MousePointer = vbDefault
      Call Bac_Sql_Execute("Rollback Transaction")
      Call GRABA_LOG_AUDITORIA(1, gsBac_Fecp, gsBac_IP, gsBac_User, "BTR", "Opc_10100", "01", "Error al grabar los parametros diarios", "", "", " ")
      Call MsgBox("Ha ocurrido un errror al intentar grabar los parametros diarios", vbCritical, TITSISTEMA)
      Call Proc_Limpia_Check
      Exit Sub
   End If

   Set objValoresMoneda = Nothing
    
   '--> Cambia el Color del Flag del Proceso de Líneas de Crédito
   Let ChkLineas.ForeColor = vbRed
   Call BacControlWindows(1)


   
   '--> Se Marca el Control para que NO realice la actualización de las Líneas de Crédito
      Let ChkLineas.Value = True
      Let ChkLineas.ForeColor = &H800000
   '--> Se Marca el Control para que NO realice la actualización de las Líneas de Crédito


   If Not ChkLineas.Value Then
      '-->  Proceso de Actualizacion de Lineas
      If Not FuncReabajaLineas Then
         Let Screen.MousePointer = vbDefault
         Call Bac_Sql_Execute("Rollback Transaction")
         Call GRABA_LOG_AUDITORIA(1, gsBac_Fecp, gsBac_IP, gsBac_User, "BTR", "Opc_10100", "01", "Error en: SP_LINEAS_ACTUALIZARMONTOS", "", "", " ")
         Call MsgBox("Ha ocurrido un error al intentar actualizar las lineas", vbExclamation, TITSISTEMA)
         Call Proc_Limpia_Check
         Exit Sub
      End If
      '-->  Proceso de Carga de Líneas Retenidas
      If Not FuncCargarGenerarLineasRetenidas Then
        Let Screen.MousePointer = vbDefault
        Call Bac_Sql_Execute("Rollback Transaction")
        Call GRABA_LOG_AUDITORIA(1, gsBac_Fecp, gsBac_IP, gsBac_User, "BTR", "Opc_10100", "01", "Error en: baclineas..SP_CARGA_LINEAS_RETENIDAS", "", "", " ")
        Call Func_Limpiar_Pantalla
        Call Proc_Limpia_Check
        Exit Sub
      End If

      '--> Cambia el Estado y el Color del Flag del Proceso de Líneas de Crédito
      Let ChkLineas.Value = True
      Let ChkLineas.ForeColor = &H800000
   End If


   '--> Cambia el Color del Flag del Proceso de Coberturas
   Let ChkCoberturas.ForeColor = vbRed
   Call BacControlWindows(1)
   
   
   '-->  Rebaja las Coberturas de los Vencimientos y Actualiza las Coberturas
   Let Mensaje_Dev = ""
   If Not ChkCoberturas.Value Then
      If Not ProcesosDeCobertura Then
         Let Screen.MousePointer = vbDefault
         Call Bac_Sql_Execute("Rollback Transaction")
         Call GRABA_LOG_AUDITORIA(1, gsBac_Fecp, gsBac_IP, gsBac_User, "BTR", "Opc_10100", "01", "Error en: " + Mensaje_Dev, "", "", " ")
         Call Proc_Limpia_Check
         Exit Sub
      End If
      
      '--> Cambia el Estado y el Color del Flag del Proceso de Coberturas
      Let ChkCoberturas.Value = True
      Let ChkCoberturas.ForeColor = &H800000
      Call BacControlWindows(1)
   End If

   
   '--> Se genera el termino correcto del proceso de Inicio de Día
   If Not Bac_Sql_Execute("Commit Transaction") Then
      Call MsgBox("Se ha generado un error inesperado al finalizar el proceso.", vbExclamation, TITSISTEMA)
      Exit Sub
   End If
    
   Let Screen.MousePointer = vbDefault

  'Call MsgBox("Parámetros Diarios Grabados Satisfactoriamente.", vbInformation, TITSISTEMA)

   Call GRABA_LOG_AUDITORIA(1, gsBac_Fecp, gsBac_IP, gsBac_User, "BTR", "Opc_10100", "01", "Finaliza procesod e inicio de dia", "", "", " ")
   

   '--> ******************************************************************************************* <--'
   '-->      S E    A C T I V A     L A     A C T U A L I Z A C I O N    D E    L I N E A S         <--'
   '--> ******************************************************************************************* <--'
   '--> ******************************************************************************************* <--'

   Let Screen.MousePointer = vbHourglass

'   If Not Bac_Sql_Execute("Begin Transaction") Then
'      Let Screen.MousePointer = vbDefault
'      Exit Sub
'   End If


   '--> Proceso de Actualización de Líneas de Crédito
   '--> Cambia el Estadlo y el Color del Flag del Proceso de Líneas de Crédito
   Let ChkLineas.ForeColor = vbRed
   Let ChkLineas.Value = False
   Call BacControlWindows(1)

   If Not ChkLineas.Value Then
      '--> Proceso de Actualización de Líneas de Crédito (Líneas Retenidas)
      If Not FuncReabajaLineas Then
         Let Screen.MousePointer = vbDefault
       'Call Bac_Sql_Execute("Rollback Transaction")
         Call MsgBox("Se ha generado un error inesperado durante la actualización de Líneas.", vbCritical, TITSISTEMA)
         Exit Sub
      End If
      
      '--> Proceso de Actualización de Líneas de Crédito (Líneas Retenidas)
      'If Not FuncCargarGenerarLineasRetenidas Then
      '   Let Screen.MousePointer = vbDefault
      '   Call Bac_Sql_Execute("Rollback Transaction")
      '   Exit Sub
      'End If

   End If

   
   Call GRABA_LOG_AUDITORIA(1, gsBac_Fecp, gsBac_IP, gsBac_User, "BTR", "Opc_10100", "01", "Finaliza proceso REC tradicional", "", "", " ")

   '--> Cambia el Estadlo y el Color del Flag del Proceso de Líneas de Crédito
   Let ChkLineas.Value = True
   Let ChkLineas.ForeColor = &H800000

    '-- PRD-10449
 
   Let ChkPCargaPAEIBS.ForeColor = vbRed
   Let ChkPCargaPAEIBS.Value = False
   Call BacControlWindows(1)


'   If Not ChkPCargaPAEIBS.Value Then
'
'      If CargaArchivo_PrestamosIBS And CargaArchivo_AnticipoIBS Then
'            Call Mensajes_Relacion_PAE
'        Let ChkPCargaPAEIBS.Value = True
'        Let ChkPCargaPAEIBS.ForeColor = &H800000
'     End If
'
'   End If
'
'   Call GRABA_LOG_AUDITORIA(1, gsBac_Fecp, gsBac_IP, gsBac_User, "BTR", "Opc_10100", "01", "Finaliza Carga Prestamos IBS", "", "", " ")
        
'-- PRD-10449
   Let ChkLineasDRV.ForeColor = vbRed
   Let ChkLineasDRV.Value = False
   Call BacControlWindows(1)

   
   If Not ChkLineasDRV.Value Then

        '+++CONTROL IDD, jcamposd, no debe llamar a lineas DRV, todo calculo de líneas lo realiza IDD
        '''Call BacCalculoRec.Proc_Recalculo_Lineas_DRV
        '---CONTROL IDD, jcamposd, no debe llamar a lineas DRV, todo calculo de líneas lo realiza IDD
        Let ChkLineasDRV.Value = True
        Let ChkLineasDRV.ForeColor = &H800000

   End If
   
   'Check Nueva para nuevo Calculo DRV
    If Not SSCheckNDRV.Value Then
                  
         ''''''''''Se agrega llamada al nuevo proceso de recalculo para derivados a partir de archivo ODS (dwt)
        'Modificado para LD1 ------> S.V
        'Call BacCalculoRec.Proc_Recalculo_Lineas_DRV_DWT
        
        '+++CONTROL IDD, jcamposd, no debe llamar a lineas DRV, todo calculo de líneas lo realiza IDD
        '''Call BacCalculoRec.NuevoCalculoLineasDRV(0)
        '---CONTROL IDD, jcamposd, no debe llamar a lineas DRV, todo calculo de líneas lo realiza IDD
        
        'Call GRABA_LOG_AUDITORIA(1, gsBac_Fecp, gsBac_IP, gsBac_User, "BTR", "Opc_10100", "01", "Finaliza Proceso REC Drv", "", "", " ")
        Let SSCheckNDRV.Value = True
        Let SSCheckNDRV.ForeColor = &H800000
    End If



'
'   If Not Bac_Sql_Execute("Commit Transaction") Then
'      Call MsgBox("Se ha generado un problema inesperado en el recalculo de las líneas de crédito.", vbExclamation, TITSISTEMA)
'      Let Screen.MousePointer = vbDefault
'      Exit Sub
'   End If
   
   Call GRABA_LOG_AUDITORIA(1, gsBac_Fecp, gsBac_IP, gsBac_User, "BTR", "Opc_10100", "01", "Finaliza Proceso REC Drv", "", "", " ")
   
   'Grabar las Garantías Faltantes, si corresponde, PRD-5521
   Bac_Sql_Execute ("BacParamSuda.DBO.SP_GAR_GRABA_GARANTIAS_FALTANTES")
      
   'Enviar los e-mails, si corresponde, PRD-5521
   Dim ok As Boolean
    If HayMensajesEmail() Then
        ok = EnviaMailGtias
        If ok Then
            Call MarcaEmailsEnviados(False)
        End If
    End If
   'Fin PRD-5521
   
   Call GRABA_LOG_AUDITORIA(1, gsBac_Fecp, gsBac_IP, gsBac_User, "BTR", "Opc_10100", "01", "Finaliza Proceso Garantias Faltantes", "", "", " ")

   Let Screen.MousePointer = vbDefault

   Call MsgBox("Parámetros Diarios Grabados Satisfactoriamente." & vbCrLf & vbCrLf & "Actualización de líneas de crédito ha finalizado correctamente.", vbInformation, TITSISTEMA)
   
   '--> ******************************************************************************************* <--'
   '-->      F I N    D E   L A     A C T U A L I Z A C I O N    D E    L I N E A S                 <--'
   '--> ******************************************************************************************* <--'
   '--> ******************************************************************************************* <--'

   On Error GoTo 0

Exit Sub
Label1:
   On Error GoTo 0
   Screen.MousePointer = vbDefault
   Call objMensajesPD.BacMsgError
End Sub

'=============================================================================================================
' LD1-COR-035-Configuración BAC Corpbanca, Tema: Carga de Cartera FINDUR Forward por limite Endeudamiento
' INICIO
'=============================================================================================================
Private Function funCargaInterfaz(varFechaProceso, varRutaInterface)

    Dim varFile, varLineaLeida
    Dim sistema, Producto, Numero_de_operacion, Monto, Rut_Contraparte, Codigo_Cliente, Monto_Garantias
    Dim Tipo_de_operacion, Tipo_negocio, Tipo_porcentaje, Fecha_vencimiento, MTM_proyectado
    varFile = FreeFile
    Open varRutaInterface For Input As #varFile
    Do While Not EOF(varFile)
        
        Line Input #varFile, varLineaLeida
        
        sistema = Mid(varLineaLeida, 1, 3)
        Producto = Mid(varLineaLeida, 4, 4)
        Numero_de_operacion = Mid(varLineaLeida, 8, 10)
        Monto = Mid(varLineaLeida, 18, 13) & "." & Mid(varLineaLeida, 31, 4)
        Rut_Contraparte = Left(Trim(Mid(varLineaLeida, 35, 15)), 8)
        Codigo_Cliente = Mid(varLineaLeida, 50, 5)
        Monto_Garantias = Mid(varLineaLeida, 55, 13) & "." & Mid(varLineaLeida, 68, 4)
        Tipo_de_operacion = Mid(varLineaLeida, 72, 3)
        Tipo_negocio = Mid(varLineaLeida, 75, 5)
        Tipo_porcentaje = Mid(varLineaLeida, 80, 5)
        Fecha_vencimiento = DateSerial(Mid(varLineaLeida, 91, 4), Mid(varLineaLeida, 88, 2), Mid(varLineaLeida, 85, 2))
        
        MTM_proyectado = EliminaCerosIzquierda(Mid(varLineaLeida, 95, 13))
        MTM_proyectado = MTM_proyectado & "." & Mid(varLineaLeida, 108, 4)
        MTM_proyectado = Replace(MTM_proyectado, ",", ".")

        Envia = Array()
        AddParam Envia, Format(varFechaProceso, "yyyy/mm/dd")
        AddParam Envia, CStr(sistema)
        AddParam Envia, CStr(Producto)
        AddParam Envia, CStr(Numero_de_operacion)
        AddParam Envia, CDbl(Replace(Monto, ",", ".")) ', "#,##0.###0")
        AddParam Envia, CStr(Rut_Contraparte)
        AddParam Envia, CStr(Codigo_Cliente)
        AddParam Envia, CDbl(Replace(Monto_Garantias, ",", "."))
        AddParam Envia, CStr(Tipo_de_operacion)
        AddParam Envia, CStr(Tipo_negocio)
        AddParam Envia, CStr(Tipo_porcentaje)
        AddParam Envia, Format(Fecha_vencimiento, "yyyy/mm/dd")
        AddParam Envia, MTM_proyectado
        
        
        If Bac_Sql_Execute("BacParamSuda..Sp_Grbmfca_findur", Envia) Then
            funCargaInterfaz = True
        Else
            funCargaInterfaz = False
        End If
            
        
    Loop
    Close
    funCargaInterfaz = True
End Function


Private Function EliminaCerosIzquierda(ByVal strValor As String)

    Dim Con, Campo
    Con = 0
    Campo = "0"
    
    Do While Campo = "0"
        Con = Con + 1
        Campo = Mid(strValor, Con, 1)
    Loop
    
    EliminaCerosIzquierda = Mid(strValor, Con, Len(strValor) - Con + 1)
    
End Function
'=============================================================================================================
' LD1-COR-035-Configuración BAC Corpbanca, Tema: Carga de Cartera FINDUR Forward por limite Endeudamiento
' FIN
'=============================================================================================================

Private Sub Func_Limpiar_Pantalla()
   On Error GoTo Label1

   GRILLA.Rows = 2
   Call F_BacLimpiaGrilla(GRILLA)

   GRILLA.Enabled = False
   Toolbar1.Buttons(3).Enabled = True
   Toolbar1.Buttons(2).Enabled = False
   TxtFecPro.Enabled = False
   TxtFecProx.Enabled = False
   TxtFecPro.text = cFecpro
   TxtFecProx.text = cFecprox
   Lbl_FecPrx.Caption = ""
   Lbl_FecPro.Caption = ""
   ChKact.Value = 0
   ChkRc.Value = 0
   Chkrv.Value = 0
   ChkLineas.Value = 0
   FrmMonedas.Enabled = False
   
   Proc_Limpia_Check

   On Error GoTo 0
Exit Sub
Label1:
   On Error GoTo 0
   Call objMensajesPD.BacMsgError
End Sub

Private Sub Func_Buscar_Datos()
   On Error GoTo Label1
   Dim Fila             As Long

   cFecpro = TxtFecPro.text
   cFecprox = TxtFecProx.text

   With GRILLA
      GRILLA.Rows = 1
      If BacChkFechas() = False Then
         GRILLA.Enabled = False
         Toolbar1.Buttons(2).Enabled = False
         Exit Sub
      End If
    
      If BacLeeParamPd(TxtFecPro.text, TxtFecProx.text, GRILLA) = True Then
         GRILLA.Enabled = True
         Toolbar1.Buttons(2).Enabled = IIf(cSW_PD = "1", False, True)
      Else
         GRILLA.Enabled = False
         Toolbar1.Buttons(2).Enabled = False
      End If
      If Toolbar1.Buttons(2).Enabled = False Then
         MsgBox "Valores no se pueden modificar, Fin de Día no realizado ", vbInformation
      End If
      TxtFecPro.Enabled = False
      TxtFecProx.Enabled = False
   End With
   FrmMonedas.Enabled = IIf(cSW_PD = "1", False, True)
   On Error GoTo 0

Exit Sub
Label1:
   On Error GoTo 0
   Call objMensajesPD.BacMsgError
End Sub

Private Function BacChkFechas() As Boolean
   On Error GoTo Label1

   BacChkFechas = True
   If Not BacChkFecpro() Then
      BacChkFechas = False
      Exit Function
   End If

   If Not BacChkFecprx() Then
      BacChkFechas = False
   End If

   On Error GoTo 0
Exit Function
Label1:
   On Error GoTo 0
   Call objMensajesPD.BacMsgError
End Function

Public Function BacGrabarParamAc(cFecpro As String, cFecprox As String) As Boolean
''''   On Error GoTo Label1
   
   BacGrabarParamAc = False
   

   Envia = Array(Format(cFecpro, "YYYYMMDD"), Format(cFecprox, "YYYYMMDD"))
   
   If Not Bac_Sql_Execute("SP_GRABARPARAMAC", Envia) Then
       Exit Function
   End If

   Valor_antiguo = " "
   Valor_antiguo = "Fecha Proceso=" & cFecpro & ";Fecha Prox Proceso= " & cFecprox
   
   Call GRABA_LOG_AUDITORIA(1, gsBac_Fecp, gsBac_IP, gsBac_User, "BTR", "Opc_10100", "01", "Grabación de Fechas y actualización de Swith Diarios", "mdac", Valor_antiguo, " ")
''''   On Error GoTo 0

''''Exit Function
''''Label1:
''''   On Error GoTo 0
''''   Call objMensajesPD.BacMsgError
    
    BacGrabarParamAc = True

End Function

Public Function BacLeeParamPd(Fechapro As String, Fechaprox As String, Grd As MSFlexGrid)
   On Error GoTo Label1
   BacLeeParamPd = False

   Envia = Array(Fechapro, Fechaprox)
   If Not Bac_Sql_Execute("SP_LEERPD", Envia) Then
      Exit Function
   End If

   With Grd
      Grd.Rows = 1
      Do While Bac_SQL_Fetch(Datos())
         Grd.Rows = Grd.Rows + 1
         Grd.TextMatrix(Grd.Rows - 1, 0) = Datos(2)
         Grd.TextMatrix(Grd.Rows - 1, 1) = Format(Datos(3), FDecimal)
         Grd.TextMatrix(Grd.Rows - 1, 2) = Format(Datos(4), FDecimal)
         Grd.TextMatrix(Grd.Rows - 1, 3) = Datos(1)
         Grd.TextMatrix(Grd.Rows - 1, 4) = Datos(5)
      Loop
      If Grd.Rows > 1 Then
         Grd.Enabled = True
         Grd.RowSel = 1
         Grd.Col = 0
         Grd.ColSel = 0
      End If
   End With
   BacLeeParamPd = True
   On Error GoTo 0

Exit Function
Label1:
   On Error GoTo 0
   Call objMensajesPD.BacMsgError
End Function

Public Function BacLeerParamAc(ByRef cFecpro As String, ByRef cFecprox As String, ByRef cSW_PD As String) As Boolean
   On Error GoTo Label1

   BacLeerParamAc = False
   If Not Bac_Sql_Execute("SP_LEERPARAMAC") Then
      Exit Function
   End If
   If Bac_SQL_Fetch(Datos()) Then
      cFecpro = Format(Datos(2), "DD/MM/YYYY")
      cFecprox = Format(Datos(2), "DD/MM/YYYY")
      cSW_PD = Datos(3)
      cFecprox = Format(DateAdd("d", 1, cFecprox), "DD/MM/YYYY")
      BacLeerParamAc = True
   End If

   While Weekday(cFecprox) = vbSunday Or Weekday(cFecprox) = vbSaturday Or Not BacEsHabil(cFecprox)
      cFecprox = DateAdd("d", 1, cFecprox)
   Wend

   BacLeerParamAc = True

   On Error GoTo 0

   Exit Function

Label1:
   On Error GoTo 0
   Call objMensajesPD.BacMsgError

End Function

Private Function BacChkFecpro() As Boolean

   On Error GoTo Label1

   If BacEsHabil(TxtFecPro.text) = True Then
      Lbl_FecPro.ForeColor = &H0&
      Lbl_FecPro.Caption = BacDiaSem(TxtFecPro.text)
      BacChkFecpro = True
    
   Else
      If Month(TxtFecPro.text) = Month(DateAdd("d", 1, TxtFecPro.text)) Then
         Lbl_FecPro.ForeColor = &HFF&
         Lbl_FecPro.Caption = BacDiaSem(TxtFecPro.text)
         MsgBox "Fecha proceso ingresada no es Día Hábil", vbOKOnly, "Parámetros Diarios"

      Else
         BacChkFecpro = True

      End If

   End If

   On Error GoTo 0
   Exit Function

Label1:
   On Error GoTo 0
   Call objMensajesPD.BacMsgError

End Function
Private Function BacChkFecprx() As Boolean

   On Error GoTo Label1

   If DateDiff("d", CDate(TxtFecPro.text), CDate(TxtFecProx.text)) <= 0 Then
      MsgBox "Fecha próximo proceso menor o igual a la de proceso?", vbOKOnly, "Parámetros diarios"
      BacChkFecprx = False
      Exit Function

   End If

   If BacEsHabil(TxtFecProx.text) = True Then
      Lbl_FecPrx.ForeColor = &H0&
      Lbl_FecPrx.Caption = BacDiaSem(TxtFecProx.text)
      BacChkFecprx = True
   Else
      If Month(TxtFecProx.text) = Month(DateAdd("d", 1, TxtFecProx.text)) Then
         Lbl_FecPrx.ForeColor = &HFF&
         Lbl_FecPrx.Caption = BacDiaSem(TxtFecProx.text)
         MsgBox "Fecha próximo proceso ingresada no es Día Hábil", vbOKOnly, "Parámetros Diarios"
         BacChkFecprx = False

      Else
         BacChkFecprx = True

      End If

   End If

   On Error GoTo 0
   Exit Function

Label1:
   On Error GoTo 0
   Call objMensajesPD.BacMsgError

End Function




Private Sub Proc_Limpia_Check()

    ChKact.Value = False
    chkDevengamientoDolares.Value = False
    ChkLineas.Value = False
    ChkRc.Value = False
    Chkrv.Value = False
    ChkSorteo.Value = False
    ChkCoberturas.Value = False
    ChkCarteraLibreTrading.Value = False
    
    ChKact.ForeColor = &H800000
    chkDevengamientoDolares.ForeColor = &H800000
    ChkLineas.ForeColor = &H800000
    ChkRc.ForeColor = &H800000
    Chkrv.ForeColor = &H800000
    ChkSorteo.ForeColor = &H800000
    ChkCoberturas.ForeColor = &H800000
    ChkCarteraLibreTrading.ForeColor = &H800000

End Sub
Private Sub Form_Activate()

   On Error GoTo Label1

   Screen.MousePointer = vbDefault

   Call CargarParam_Grilla(GRILLA)

  ' Me.Height = 2070
   FrmMonedas.Enabled = False

   On Error GoTo 0

   Exit Sub


Label1:
   On Error GoTo 0
   Call objMensajesPD.BacMsgError

End Sub

Private Sub Form_Load()

   Set objMensajesPD = New ClsMsg

   On Error GoTo Label1
   
   'Lee Parametros.-
   Me.Tag = ""

   cCategoria = 21
   cTasa = 0
   
   
   Proceso = gsBac_Fecp
   Prox_Proc = gsBac_Fecx
   Anterior = gsBac_Feca

   If BacLeerParamAc(cFecpro, cFecprox, cSW_PD) = False Then
      Me.Tag = "S"
   
   Exit Sub

   End If

   Me.Tag = ""
   TxtFecPro.text = cFecpro
   TxtFecProx.text = cFecprox

   TxtFecPro.Enabled = False
   TxtFecProx.Enabled = False

   GRILLA.Enabled = False
   Toolbar1.Buttons(2).Enabled = False

   On Error GoTo 0
   Exit Sub

Label1:
   On Error GoTo 0
   Call objMensajesPD.BacMsgError

End Sub

Private Sub Form_Unload(Cancel As Integer)

   Set objMensajesPD = Nothing

End Sub

Private Sub Frame1_DragDrop(Source As Control, X As Single, y As Single)

End Sub

Private Sub Grilla_GotFocus()

   j = 1

End Sub

Private Sub Grilla_KeyPress(KeyAscii As Integer)

   If GRILLA.Enabled = True Then
   
      If Trim(GRILLA.TextMatrix(GRILLA.Row, 0)) <> "" Then
      
         If (KeyAscii = 13 Or IsNumeric(Chr(KeyAscii))) And GRILLA.Col = 1 Or GRILLA.Col = 2 Then
         
            Text1.Visible = True

            If KeyAscii = 13 Then
            
               Text1.text = GRILLA.TextMatrix(GRILLA.RowSel, GRILLA.Col)

            ElseIf IsNumeric(Chr(KeyAscii)) Then
            
               Text1.text = Chr(KeyAscii)

            End If

            Call PROC_POSI_TEXTO(GRILLA, Text1)
            Text1.SetFocus

         End If

      End If

   End If

End Sub

Private Sub Grilla_LostFocus()

   j = 1

End Sub

Private Sub SSCheck1_Click(Value As Integer)

End Sub

Private Sub Text1_GotFocus()

   j = 1
   Text1.SelStart = Len(Text1.text) - 5

End Sub

Private Sub Text1_KeyPress(KeyAscii As Integer)

   If KeyAscii = 13 Then
      GRILLA.TextMatrix(GRILLA.RowSel, GRILLA.Col) = Format(Text1.text, "###,###,###0.###0")
      Text1.Visible = False
      GRILLA.SetFocus

   ElseIf KeyAscii = 27 Then
      Text1.Visible = False
      GRILLA.SetFocus

   End If

End Sub

Private Sub Text1_LostFocus()

   j = 1
   Text1.Visible = False

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   
   Select Case Button.Index
      Case 1
         Call Func_Buscar_Datos
         
      Case 2
         Call Func_Grabar_Datos
         
      Case 3
         Call Func_Limpiar_Pantalla
         
      Case 4
         Unload Me
         
   End Select
   
End Sub

Private Function FuncCargarGenerarLineasRetenidas() As Boolean
        
    Dim Datos()
    
    FuncCargarGenerarLineasRetenidas = False
   
    Envia = Array()
    AddParam Envia, Format(gsBac_Fecp, "yyyymmdd")
   
    If Not Bac_Sql_Execute("baclineas..SP_CARGA_LINEAS_RETENIDAS", Envia) Then
        Screen.MousePointer = vbDefault
        MsgBox "Ha ocurrid un error al intentar ejecutar la carga de Retención de Lineas.", vbCritical, TITSISTEMA
        Exit Function
    End If
   
''''   If Not Bac_Sql_Execute("baclineas..SP_GENERA_LINEAS_RETENIDAS") Then
''''      MsgBox "Problemas en la generación de Lineas Retenidas.", vbExclamation, TITSISTEMA
''''      Exit Sub
''''   End If

    FuncCargarGenerarLineasRetenidas = True

End Function


Private Function Volver_Sw()
Envia = Array()
Envia = Array(Proceso, Prox_Proc, Anterior)
If Not Bac_Sql_Execute("SP_VOLVER_SW", Envia) Then
    MsgBox ("Problemas al cambiar SW")
    Screen.MousePointer = 0
    Exit Function
End If

End Function
Private Sub TxtFecPro_KeyPress(KeyAscii As Integer)

   If Format$(TxtFecPro.text, "yyyymmdd") < Format$(gsBac_Fecp, "yyyymmdd") Then
      MsgBox "Fecha de proceso debe ser igual o mayor a la del proceso en curso ", vbExclamation, gsBac_Version
      Exit Sub

   End If

End Sub

Private Sub TxtFecPro_LostFocus()

   Lbl_FecPrx.ForeColor = &H0&

   If Trim$(TxtFecPro.Tag) = "" Then
      TxtFecPro.Tag = TxtFecPro.text

   End If

   Lbl_FecPro.Caption = BacDiaSem(TxtFecPro.text)

End Sub

Private Sub TxtFecProx_LostFocus()

   Lbl_FecPrx.ForeColor = &H0&
   Lbl_FecPrx.Caption = BacDiaSem(TxtFecProx.text)

End Sub

Private Sub CargarParam_Grilla(Grillas As Object)

   With GRILLA
      .ColWidth(0) = 2730
      .ColWidth(1) = 1700
      .ColWidth(2) = 1700
      .ColWidth(3) = 0
      .ColWidth(4) = 0
      .ColWidth(5) = 0

      .RowHeight(0) = 350
      .CellFontWidth = 4
      .Row = 0

      .Col = 0
      .FixedAlignment(0) = 4
      .CellFontBold = True
      .text = " Moneda/Tasa "
      .ColAlignment(0) = 2

      .Col = 1
      .FixedAlignment(1) = 4
      .CellFontBold = True
      .text = " Proceso "
      .ColAlignment(1) = 8

      .Col = 2
      .FixedAlignment(2) = 4
      .CellFontBold = True
      .text = " Proximo Proceso "
      .ColAlignment(2) = 8

     
    
   End With

End Sub

Private Function Func_Ventas_Con_PactoDolar() As Boolean

    Dim Sw_Devengo_Ok    As String
    Dim Msg_Devengo      As String
    
    Func_Ventas_Con_PactoDolar = False

    Envia = Array(Format(Fecha_Anterior, "yyyymmdd"), _
            Format(Fecha_Proceso_Dev, "yyyymmdd"), _
            "S")
    
    Status_Dev = "0"
    Mensaje_Dev = ""

    If Bac_Sql_Execute("SP_DEVENGO_VENTAS_CON_PACTO", Envia) Then
        Do While Bac_SQL_Fetch(Datos())
            If Datos(1) <> "OK" Then
                Status_Dev = "2"
            End If
            Retorno_Dev = Datos(2)
        Loop
        If Status_Dev <> "0" Then
''''            Mensaje_Dev = "Devengamiento de las VENTAS CON PACTO DOLAR termino OK"
''''        Else
            Mensaje_Dev = "Devengamiento de las VENTAS CON PACTO DOLAR ha fallado" + vbCrLf + Trim(Datos(2))
        End If
    Else
        Status_Dev = "1"
''''        Mensaje_Dev = "Devengamiento de las VENTAS CON PACTO DOLAR ha fallado"
        Retorno_Dev = ""
        Mensaje_Dev = "Ha ocurrido un error al devengar las ventas con pacto dolar, SP_DEVENGO_VENTAS_CON_PACTO "
        Exit Function
    End If
     
    Valor_antiguo = " "
    Valor_antiguo = "Fecha Proceso = " & Fecha_Proceso_Dev & ";Fecha Proximo Devengo=" & Fecha_Proximo_Dev & ";Mensaje=" & Mensaje_Dev

    Call GRABA_LOG_AUDITORIA(1, gsBac_Fecp, gsBac_IP, gsBac_User, _
    "BTR", "Opc_40200", "01", "Devengo Ventas con Pacto Dolar", "mdrs", Valor_antiguo, " ")
     
    Func_Ventas_Con_PactoDolar = True

End Function

Private Function ProcesosDeCobertura() As Boolean
    ProcesosDeCobertura = False

   On Error GoTo ErrorActualizacion
   
   Envia = Array()
   If Not Bac_Sql_Execute("BacTraderSuda..SP_VENCIMIENTOS_COBERTURAS") Then
      Mensaje_Dev = "SP_VENCIMIENTOS_COBERTURAS"
      GoTo ErrorActualizacion
   End If
   
   Envia = Array()
   If Not Bac_Sql_Execute("BacTraderSuda..SP_ACTUALIZACION_COBERTURAS") Then
      Mensaje_Dev = "SP_ACTUALIZACION_COBERTURAS"
      GoTo ErrorActualizacion
   End If
   
   ProcesosDeCobertura = True
   
Exit Function

ErrorActualizacion:
    Screen.MousePointer = vbDefault
    MsgBox "Error . " & vbCrLf & vbCrLf & "Problemas en la Actualizacion de Coberturas.", vbExclamation, TITSISTEMA
    
End Function


Public Function CargaArchivo_PrestamosIBS()

 Dim oPath                  As String
 Dim cNombreArchivo         As String
 Dim Ruta                   As String
 Dim SeparadorCampo         As String
 Dim xLine$
 Dim Prueba    As String
    
 Dim IBS_FecProc      As String
 Dim IBS_NumPrestamo  As Long
 Dim IBS_CodProd      As String
 Dim IBS_CodFam       As String
 Dim IBS_NumDerivado  As Long
 Dim IBS_cTipo        As String
 Dim IBS_Fecini       As String
 Dim IBS_FecVenc      As String
 Dim IBS_Monto        As Double
 Dim IBS_CodTasa      As String
 Dim IBS_TipoTasa     As String
 Dim IBS_TasaCli      As Double
 Dim IBS_Spread       As Double
 Dim IBS_Moneda       As String
 Dim IBS_RuCli        As String
 Dim IBS_cTipoPlazo   As String
 Dim IBS_Plazo        As Long
 Dim IBS_cEstadoOper  As String
 Dim LargoRegistro    As Long
 Dim total_registro   As Long
 
 CargaArchivo_PrestamosIBS = False
 
   If Right(gsBac_DIRPAE, 1) <> "\" Then
      Let gsBac_DIRPAE = gsBac_DIRPAE & "\"
   End If
   
   Envia = Array()
   AddParam Envia, 1
   If Not Bac_Sql_Execute("BacTraderSuda.dbo.SP_ELIMINA_PRESTAMOS_IBS", Envia) Then
      Let Screen.MousePointer = vbDefault
      Call MsgBox("Se ha generado un error al comparar relación entre el Créditos y el Derivados.", vbExclamation, App.Title)
      Exit Function
   End If

   
   Let cNombreArchivo = "Derelpae_" & Format(gsBac_Fecp, "YYYY") & Format(gsBac_Fecp, "MM") & Format(gsBac_Fecp, "DD") & ".dat"
   Let oPath = gsBac_DIRPAE & cNombreArchivo

   If Dir(oPath) = "" Then
      Call MsgBox("El archivo requerido para la carga. [" & cNombreArchivo & "]. no se encuentra... Favor Revisar.", vbExclamation, App.Title)
      Exit Function
   End If
   
   
   total_registro = 0
    
   
 '-- carga operaciones
 On Error GoTo errOpen
 Open oPath For Input As #1
  
    
 Do While Not EOF(1)
        
        Line Input #1, xLine
        IBS_FecProc = (Mid$(xLine, 1, 8))
        IBS_NumPrestamo = Val(Mid$(xLine, 10, 12))
        IBS_CodProd = (Mid$(xLine, 23, 4))
        IBS_CodFam = (Mid$(xLine, 28, 4))
        IBS_NumDerivado = Val(Mid$(xLine, 33, 12))
        IBS_cTipo = (Mid$(xLine, 46, 1))
        IBS_Fecini = Mid$(xLine, 48, 8)
        IBS_FecVenc = Mid$(xLine, 57, 8)
        IBS_Monto = Val(Mid$(xLine, 66, 17))
        IBS_CodTasa = (Mid$(xLine, 84, 2))
        IBS_TipoTasa = (Mid$(xLine, 87, 35))
        IBS_TasaCli = Val(Mid$(xLine, 123, 10))
        IBS_Spread = Val(Mid$(xLine, 134, 10))
        IBS_Moneda = Mid$(xLine, 145, 3)
        IBS_RuCli = Val(IIf(BacValidaRut(Mid$(xLine, 149, Len(Trim(Mid$(xLine, 149, 15))) - 1), Right(Trim(Mid$(xLine, 149, 15)), 1)) = True, Mid$(xLine, 149, Len(Trim(Mid$(xLine, 149, 15))) - 1), 0))
        IBS_cTipoPlazo = Mid$(xLine, 165, 1)
        IBS_Plazo = Val(Mid$(xLine, 167, 4))
        IBS_cEstadoOper = Mid$(xLine, 172, 30)
        
        LargoRegistro = Len(xLine)
        If LargoRegistro <> 202 Then
             MsgBox "Revisar archivo Préstamos IBS. Largo de registro " & total_registro + 1 & " no corresponde a 202 caracteres.", vbCritical, TITSISTEMA
             Close #1
             Exit Function
        End If
        
        Envia = Array()
            AddParam Envia, IBS_FecProc
            AddParam Envia, IBS_NumPrestamo
            AddParam Envia, IBS_CodProd
            AddParam Envia, IBS_CodFam
            AddParam Envia, IBS_NumDerivado
            AddParam Envia, IBS_cTipo
            AddParam Envia, IBS_Fecini
            AddParam Envia, IBS_FecVenc
            AddParam Envia, CDbl(IBS_Monto)
            AddParam Envia, IBS_CodTasa
            AddParam Envia, IBS_TipoTasa
            AddParam Envia, CDbl(IBS_TasaCli)
            AddParam Envia, CDbl(IBS_Spread)
            AddParam Envia, IBS_Moneda
            AddParam Envia, IBS_RuCli
            AddParam Envia, IBS_cTipoPlazo
            AddParam Envia, IBS_Plazo
            AddParam Envia, IBS_cEstadoOper
            
        If Not Bac_Sql_Execute("BacTraderSuda.dbo.SP_GRABA_PRESTAMOS_IBS", Envia) Then
             MsgBox "No se pudo realizar transferencia de datos Préstamos IBS. Favor Revisar Archivo. ", vbCritical, TITSISTEMA
             Close #1
             Exit Function
        End If
 
     
         total_registro = total_registro + 1
        
 Loop

  
    Close #1
    
 CargaArchivo_PrestamosIBS = True
 
errOpen:
    Exit Function
    
'--PRD-10449
    
End Function

Private Function SendMail(ByVal Contacto As String, ByVal Email As String, ByVal Mensaje As String, ByVal Firma As String, ByVal Subjt As String)
   On Error Resume Next
   Dim Enviar      As Object
   Dim ObjCorreo   As Object

   Set ObjCorreo = CreateObject("Outlook.Application")
   Set Enviar = ObjCorreo.CreateItem(0)

   Enviar.To = Email
   Enviar.cc = ""
   Enviar.Subject = Subjt
   Enviar.Body = Contacto & "," & vbCrLf & vbCrLf & vbTab & Mensaje & vbCrLf & vbCrLf & "Atte." & vbCrLf & Firma     '' "Estimado " &
   Enviar.Importance = 1
   ''Enviar.Display
   Enviar.send

   Set ObjCorreo = Nothing
   Set Enviar = Nothing

   On Error GoTo 0
End Function


Public Function Mensajes_Relacion_PAE()
 Dim MensjDRV  As String
 Dim MensjOPC  As String
 Dim MensjBFW  As String
 Dim MensjPCS  As String
 Dim MensjANT  As String
 Dim Asunto    As String
 Dim Usuario   As String
 Dim Mail      As String
 Dim Cont      As Long
 Dim Firma     As String
 Dim reg       As Long
 
 Let MensjBFW = ""
 Let MensjPCS = ""
 
 Mensajes_Relacion_PAE = False
 
 Let reg = 1
 
 On Error GoTo errOpen
 
   Envia = Array()
   AddParam Envia, gsBac_Fecp
   If Not Bac_Sql_Execute("BacTraderSuda.dbo.SP_COMPARA_RELACION_IBS_DRV", Envia) Then
      Let Screen.MousePointer = vbDefault
      Call MsgBox("Se ha generado un error al comparar relación entre el Créditos y el Derivados.", vbExclamation, App.Title)
      Exit Function
   End If
                
   Envia = Array()
   AddParam Envia, gsBac_Fecp
   If Not Bac_Sql_Execute("BacTraderSuda.dbo.SP_RESCATA_ERRORES_RELACION_IBS_DRV", Envia) Then
      Let Screen.MousePointer = vbDefault
      Call MsgBox("Se ha generado un error al comparar relación entre el Créditos y el Derivados.", vbExclamation, App.Title)
      Exit Function
   End If
   Do While Bac_SQL_Fetch(Datos())
      If Datos(1) = -1 Then
          Let reg = 0
          Exit Do
      End If
   
       If Datos(1) = "OPC" Then
         Let MensjOPC = MensjOPC & "" & Datos(4) & vbCrLf & vbTab
       End If
''''       If DATOS(1) = "BFW" Then
''''         Let MensjBFW = MensjBFW & "" & DATOS(4) & vbCrLf & vbTab
''''       End If
''''       If DATOS(1) = "PCS" Then
''''               Let MensjPCS = MensjPCS & "" & DATOS(4) & vbCrLf & vbTab
''''       End If
''''       If DATOS(1) = "ANT" Then
''''            Let MensjANT = MensjANT & "" & DATOS(4) & vbCrLf & vbTab
''''       End If
       
       Let Firma = Datos(6)
   Loop
   
       If MensjOPC <> "" Then
           Let MensjOPC = " Para préstamos relacionados con Opciones se obtiene la siguiente información :" & vbCrLf & vbCrLf & vbTab & MensjOPC & vbCrLf & vbTab
       End If
                     
''''       If MensjBFW <> "" Then
''''           Let MensjBFW = " Para préstamos relacionados con Forward se obtiene la siguiente información :" & vbCrLf & vbCrLf & vbTab & MensjBFW & vbCrLf & vbTab
''''       End If
''''
''''       If MensjPCS <> "" Then
''''           Let MensjPCS = " Para préstamos relacionados con Swap se obtiene la siguiente información :" & vbCrLf & vbCrLf & vbTab & MensjPCS & vbCrLf & vbTab
''''       End If
''''
''''       If MensjANT <> "" Then
''''           Let MensjANT = " Los siguientes préstamos son antiguos :" & vbCrLf & vbCrLf & vbTab & MensjANT & vbCrLf & vbTab
''''       End If

       
        If reg = 0 Then
           Let MensjDRV = MensjDRV & " No existe información de carga de archivo. "
        Else
        Let MensjDRV = MensjDRV & MensjOPC & vbCrLf & vbTab & MensjBFW & vbCrLf & vbTab & MensjPCS & vbCrLf & vbTab & MensjANT
        End If
        

         If Not Bac_Sql_Execute("BacTraderSuda.dbo.SP_ENVIOMAILPAE") Then
             Call MsgBox("Problemas al Leer Procedimiento. ", vbCritical, App.Title)
             
         Else
             
             Let Cont = 0
             Do While Bac_SQL_Fetch(Datos())
               Usuario = Usuario & (Datos(1)) & ";"
               Mail = Mail & (Datos(2)) & ";"
               Cont = Cont + 1
                
             Loop
         End If
         
         If Cont > 1 Then
              Let Usuario = "Estimados  "
         Else
              Let Usuario = "Estimado  " & Usuario
         End If
        
        If MensjDRV <> "" Then
          Let Asunto = "Información de Carga Archivo PAE"
          Call SendMail(Usuario, Mail, MensjDRV, Firma, Asunto)
        End If
        
      
 Mensajes_Relacion_PAE = True
 
errOpen:
    Exit Function
   

End Function

Public Function CargaArchivo_AnticipoIBS()

Dim oPath                  As String
 Dim cNombreArchivo         As String
 Dim Ruta                   As String
 Dim SeparadorCampo         As String
 Dim xLine$
 Dim Prueba    As String
    
 Dim IBS_FecProc      As String
 Dim IBS_NumPrestamo  As Long
 Dim IBS_CodProd      As String
 Dim IBS_CodFam       As String
 Dim IBS_NumDerivado  As Long
 Dim IBS_cTipo        As String
 Dim IBS_cTipoAnti    As String
 Dim IBS_Monto        As Double
 Dim IBS_FecAnti      As String
 Dim IBS_RuCli        As String
 Dim LargoRegistro    As Long
 Dim total_registro   As Long
 
 CargaArchivo_AnticipoIBS = False
  
   If Right(gsBac_DIRPAE, 1) <> "\" Then
      Let gsBac_DIRPAE = gsBac_DIRPAE & "\"
   End If
   
   
   Let cNombreArchivo = "Derelant_" & Format(gsBac_Fecp, "YYYY") & Format(gsBac_Fecp, "MM") & Format(gsBac_Fecp, "DD") & ".dat"
   Let oPath = gsBac_DIRPAE & cNombreArchivo

   If Dir(oPath) = "" Then
      Call MsgBox("El archivo requerido para la carga. [" & cNombreArchivo & "]. no se encuentra... Favor Revisar.", vbExclamation, App.Title)
      Exit Function
   End If
   
   
   Envia = Array()
   AddParam Envia, 2
   If Not Bac_Sql_Execute("BacTraderSuda.dbo.SP_ELIMINA_PRESTAMOS_IBS", Envia) Then
      Let Screen.MousePointer = vbDefault
      Call MsgBox("Se ha generado un error al comparar relación entre el Créditos y el Derivados.", vbExclamation, App.Title)
      Exit Function
   End If
   
    total_registro = 0
   
 '-- carga operaciones
 On Error GoTo errOpen
 Open oPath For Input As #1
    
 Do While Not EOF(1)
 
        Line Input #1, xLine
        IBS_NumPrestamo = Val(Mid$(xLine, 1, 12))
        IBS_CodProd = (Mid$(xLine, 14, 4))
        IBS_CodFam = (Mid$(xLine, 19, 4))
        IBS_NumDerivado = Val(Mid$(xLine, 24, 12))
        IBS_cTipo = (Mid$(xLine, 37, 1))
        IBS_cTipoAnti = Mid$(xLine, 39, 30)
        IBS_Monto = Val(Mid$(xLine, 70, 17))
        IBS_FecAnti = Mid$(xLine, 88, 8)
        IBS_RuCli = Val(IIf(BacValidaRut(Mid$(xLine, 97, Len(Trim(Mid$(xLine, 97, 15))) - 1), Right(Trim(Mid$(xLine, 97, 15)), 1)) = True, Mid$(xLine, 97, Len(Trim(Mid$(xLine, 97, 15))) - 1), 0))
        
        LargoRegistro = Len(xLine)
        If LargoRegistro <> 112 Then
             MsgBox "Revisar archivo Anticipos IBS. Largo de registro " & total_registro + 1 & " no corresponde a 202 caracteres.", vbCritical, TITSISTEMA
             Close #1
             Exit Function
        End If
        
        Envia = Array()
            AddParam Envia, Format(gsBac_Fecp, "YYYY") & Format(gsBac_Fecp, "MM") & Format(gsBac_Fecp, "DD")
            AddParam Envia, IBS_NumPrestamo
            AddParam Envia, IBS_CodProd
            AddParam Envia, IBS_CodFam
            AddParam Envia, IBS_NumDerivado
            AddParam Envia, IBS_cTipo
            AddParam Envia, IBS_cTipoAnti
            AddParam Envia, CDbl(IBS_Monto)
            AddParam Envia, IBS_FecAnti
            AddParam Envia, IBS_RuCli
            
        If Not Bac_Sql_Execute("BacTraderSuda.dbo.SP_GRABA_ANTICIPOS_IBS", Envia) Then
             MsgBox "No se pudo realizar transferencia de datos Anticipos IBS. Favor Revisar Archivo. ", vbCritical, TITSISTEMA
             Close #1
             Exit Function
        End If
        
            total_registro = total_registro + 1
 
        
 Loop
 
           
    Close #1
    
    
    CargaArchivo_AnticipoIBS = True


errOpen:
    Exit Function
    
'--PRD-10449
End Function
