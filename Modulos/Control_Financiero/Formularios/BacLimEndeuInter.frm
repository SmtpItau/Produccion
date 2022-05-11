VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "Msflxgrd.ocx"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacLimEndeuInter 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Consulta de Limite Endeudamiento"
   ClientHeight    =   6240
   ClientLeft      =   45
   ClientTop       =   375
   ClientWidth     =   11175
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   6240
   ScaleWidth      =   11175
   StartUpPosition =   3  'Windows Default
   Begin VB.Frame Frame 
      Height          =   1035
      Left            =   30
      TabIndex        =   20
      Top             =   480
      Width           =   11055
      Begin VB.Frame Frame1 
         Enabled         =   0   'False
         Height          =   855
         Left            =   60
         TabIndex        =   21
         Top             =   120
         Width           =   10875
         Begin VB.Frame Frame3 
            Caption         =   "0%"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   585
            Left            =   5280
            TabIndex        =   26
            Top             =   180
            Width           =   2505
            Begin BACControles.TXTNumero txtDiez 
               Height          =   285
               Left            =   60
               TabIndex        =   27
               Top             =   210
               Width           =   2355
               _ExtentX        =   4154
               _ExtentY        =   503
               ForeColor       =   -2147483635
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
               Text            =   "0"
               Text            =   "0"
               Separator       =   -1  'True
               MarcaTexto      =   -1  'True
            End
         End
         Begin VB.Frame Frame2 
            Caption         =   "0%"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   585
            Left            =   2640
            TabIndex        =   24
            Top             =   180
            Width           =   2565
            Begin BACControles.TXTNumero txtTres 
               Height          =   285
               Left            =   60
               TabIndex        =   25
               Top             =   210
               Width           =   2415
               _ExtentX        =   4260
               _ExtentY        =   503
               ForeColor       =   -2147483635
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
               Text            =   "0"
               Text            =   "0"
               Separator       =   -1  'True
               MarcaTexto      =   -1  'True
            End
         End
         Begin VB.Frame Frame5 
            Caption         =   "0%"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   585
            Left            =   7860
            TabIndex        =   22
            Top             =   180
            Width           =   2715
            Begin BACControles.TXTNumero txtBFW 
               Height          =   285
               Left            =   120
               TabIndex        =   23
               Top             =   210
               Width           =   2475
               _ExtentX        =   4366
               _ExtentY        =   503
               ForeColor       =   -2147483635
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
               Text            =   "0,00"
               Text            =   "0,00"
               CantidadDecimales=   "2"
               Separator       =   -1  'True
               MarcaTexto      =   -1  'True
            End
         End
         Begin BACControles.TXTNumero txtActivo 
            Height          =   285
            Left            =   180
            TabIndex        =   28
            Top             =   420
            Width           =   2205
            _ExtentX        =   3889
            _ExtentY        =   503
            ForeColor       =   -2147483635
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
            Text            =   "0"
            Text            =   "0"
            Min             =   "0"
            Max             =   "999999999999999"
            Separator       =   -1  'True
            MarcaTexto      =   -1  'True
         End
         Begin VB.Label Label6 
            Caption         =   "Activo Circulante"
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
            Left            =   210
            TabIndex        =   29
            Top             =   180
            Width           =   1515
         End
      End
   End
   Begin VB.Frame Frame4 
      Enabled         =   0   'False
      Height          =   2295
      Left            =   0
      TabIndex        =   0
      Top             =   3930
      Width           =   11085
      Begin VB.Frame Frame6 
         Caption         =   "Totales"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000080&
         Height          =   2085
         Left            =   90
         TabIndex        =   1
         Top             =   120
         Width           =   10935
         Begin BACControles.TXTNumero TxtCapInter 
            Height          =   285
            Left            =   210
            TabIndex        =   2
            Top             =   750
            Width           =   1995
            _ExtentX        =   3519
            _ExtentY        =   503
            ForeColor       =   -2147483635
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
            Text            =   "0"
            Text            =   "0"
            Min             =   "0"
            Max             =   "999999999999999"
            Separator       =   -1  'True
            MarcaTexto      =   -1  'True
         End
         Begin BACControles.TXTNumero TxtForPerDif 
            Height          =   285
            Left            =   2340
            TabIndex        =   3
            Top             =   750
            Width           =   1995
            _ExtentX        =   3519
            _ExtentY        =   503
            ForeColor       =   -2147483635
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
            Text            =   "0"
            Text            =   "0"
            Min             =   "0"
            Max             =   "999999999999999"
            Separator       =   -1  'True
            MarcaTexto      =   -1  'True
         End
         Begin BACControles.TXTNumero TxtForPerDif2 
            Height          =   285
            Left            =   4440
            TabIndex        =   4
            Top             =   750
            Width           =   1995
            _ExtentX        =   3519
            _ExtentY        =   503
            ForeColor       =   -2147483635
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
            Text            =   "0"
            Text            =   "0"
            Min             =   "0"
            Max             =   "999999999999999"
            Separator       =   -1  'True
            MarcaTexto      =   -1  'True
         End
         Begin BACControles.TXTNumero TxtObligaciones 
            Height          =   285
            Left            =   6570
            TabIndex        =   5
            Top             =   750
            Width           =   1995
            _ExtentX        =   3519
            _ExtentY        =   503
            ForeColor       =   -2147483635
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
            Text            =   "0"
            Text            =   "0"
            Min             =   "0"
            Max             =   "999999999999999"
            Separator       =   -1  'True
            MarcaTexto      =   -1  'True
         End
         Begin BACControles.TXTNumero TxtGarantiasOtor 
            Height          =   285
            Left            =   2340
            TabIndex        =   6
            Top             =   1710
            Width           =   1995
            _ExtentX        =   3519
            _ExtentY        =   503
            ForeColor       =   -2147483635
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
            Text            =   "0"
            Text            =   "0"
            Min             =   "0"
            Max             =   "999999999999999"
            Separator       =   -1  'True
            MarcaTexto      =   -1  'True
         End
         Begin BACControles.TXTNumero TxtGarantiasDispo 
            Height          =   285
            Left            =   4440
            TabIndex        =   7
            Top             =   1710
            Width           =   1995
            _ExtentX        =   3519
            _ExtentY        =   503
            ForeColor       =   -2147483635
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
            Text            =   "0"
            Text            =   "0"
            Min             =   "0"
            Max             =   "999999999999999"
            Separator       =   -1  'True
            MarcaTexto      =   -1  'True
         End
         Begin BACControles.TXTNumero txtAfecto 
            Height          =   285
            Left            =   6570
            TabIndex        =   8
            Top             =   1710
            Width           =   1995
            _ExtentX        =   3519
            _ExtentY        =   503
            ForeColor       =   -2147483635
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
            Text            =   "0"
            Text            =   "0"
            Min             =   "0"
            Max             =   "999999999999999"
            Separator       =   -1  'True
            MarcaTexto      =   -1  'True
         End
         Begin BACControles.TXTNumero TxtTotGarantias 
            Height          =   285
            Left            =   210
            TabIndex        =   9
            Top             =   1710
            Width           =   1995
            _ExtentX        =   3519
            _ExtentY        =   503
            ForeColor       =   -2147483635
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
            Text            =   "0"
            Text            =   "0"
            Min             =   "0"
            Max             =   "999999999999999"
            Separator       =   -1  'True
            MarcaTexto      =   -1  'True
         End
         Begin BACControles.TXTNumero txtAfectoRC 
            Height          =   285
            Left            =   8760
            TabIndex        =   10
            Top             =   735
            Width           =   1995
            _ExtentX        =   3519
            _ExtentY        =   503
            ForeColor       =   -2147483635
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
            Text            =   "0"
            Text            =   "0"
            Min             =   "0"
            Max             =   "999999999999999"
            Separator       =   -1  'True
            MarcaTexto      =   -1  'True
         End
         Begin VB.Label Label9 
            Alignment       =   2  'Center
            BorderStyle     =   1  'Fixed Single
            Caption         =   "     Afecto III.B. 2      T/C SBIF"
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
            Height          =   480
            Left            =   6570
            TabIndex        =   19
            Top             =   1200
            Width           =   1995
         End
         Begin VB.Label Label8 
            Alignment       =   2  'Center
            BorderStyle     =   1  'Fixed Single
            Caption         =   "Garantías Disponibles"
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
            Height          =   480
            Left            =   4440
            TabIndex        =   18
            Top             =   1200
            Width           =   1995
         End
         Begin VB.Label Label7 
            Alignment       =   2  'Center
            BorderStyle     =   1  'Fixed Single
            Caption         =   "Garantías Otorgadas"
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
            Height          =   480
            Left            =   2340
            TabIndex        =   17
            Top             =   1200
            Width           =   1995
         End
         Begin VB.Label Label5 
            Alignment       =   2  'Center
            BorderStyle     =   1  'Fixed Single
            Caption         =   "Total Garantías"
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
            Height          =   480
            Left            =   210
            TabIndex        =   16
            Top             =   1200
            Width           =   1995
         End
         Begin VB.Label Label4 
            Alignment       =   2  'Center
            BorderStyle     =   1  'Fixed Single
            Caption         =   "Obligaciones <= 1 Año"
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
            Height          =   480
            Left            =   6570
            TabIndex        =   15
            Top             =   255
            Width           =   1995
         End
         Begin VB.Label Label3 
            Alignment       =   2  'Center
            BorderStyle     =   1  'Fixed Single
            Caption         =   "% Forward con Perd. Diferida"
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
            Height          =   480
            Left            =   4440
            TabIndex        =   14
            Top             =   255
            Width           =   1995
         End
         Begin VB.Label Label2 
            Alignment       =   2  'Center
            BorderStyle     =   1  'Fixed Single
            Caption         =   "Forward con Perd. Diferida"
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
            Height          =   480
            Left            =   2340
            TabIndex        =   13
            Top             =   255
            Width           =   1995
         End
         Begin VB.Label Label1 
            Alignment       =   2  'Center
            BorderStyle     =   1  'Fixed Single
            Caption         =   "Captaciones Interbancarias"
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
            Height          =   480
            Left            =   210
            TabIndex        =   12
            Top             =   255
            Width           =   1995
         End
         Begin VB.Label Label11 
            Alignment       =   2  'Center
            BorderStyle     =   1  'Fixed Single
            Caption         =   "     Afecto III.B. 2    T/C Contable"
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
            Height          =   480
            Left            =   8760
            TabIndex        =   11
            Top             =   225
            Width           =   1995
         End
      End
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   5640
      Top             =   510
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   6
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacLimEndeuInter.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacLimEndeuInter.frx":0452
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacLimEndeuInter.frx":076C
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacLimEndeuInter.frx":0A86
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacLimEndeuInter.frx":0ED8
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacLimEndeuInter.frx":11F2
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSFlexGridLib.MSFlexGrid Grilla 
      Height          =   2415
      Left            =   0
      TabIndex        =   30
      Top             =   1530
      Width           =   11055
      _ExtentX        =   19500
      _ExtentY        =   4260
      _Version        =   393216
      Cols            =   4
      FixedCols       =   0
      RowHeightMin    =   315
      BackColor       =   -2147483644
      ForeColor       =   8388608
      BackColorFixed  =   8421376
      ForeColorFixed  =   16777215
      BackColorSel    =   8388608
      ForeColorSel    =   16777215
      BackColorBkg    =   -2147483644
      GridColor       =   16777215
      GridColorFixed  =   16777215
      FocusRect       =   0
      GridLines       =   2
      GridLinesFixed  =   0
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   31
      Top             =   0
      Width           =   11175
      _ExtentX        =   19711
      _ExtentY        =   794
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Actualización de % de Límite"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Pantalla"
            ImageIndex      =   6
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
End
Attribute VB_Name = "BacLimEndeuInter"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim Datos()
Dim CapInter, ForPerDif, ForPerDif2, Obligaciones, TotGarantias, GarantiasOtor, GarantiasDispo, Afecto, AfectoRC  As Double
Dim A, i
Dim Porcetanje_Actual As String
Dim Existe, ValidaDato As Boolean


Private Sub Form_Activate()
    Call BUSCA_ENDEUDAMIENTO
    Call carga_grilla
    Call Carga_Sumatorias

End Sub

Private Sub Form_Load()
    
    Me.top = 0
    Me.Left = 0
    
    Existe = False
    
    Toolbar1.Buttons(2).Enabled = False
    
    Call NombresGrilla

End Sub


Sub NombresGrilla()

    With Grilla
        .Clear
        .Rows = 2
        .Cols = 11
        .Row = 0

        .Col = 0: .Text = "Rut":
        .CellAlignment = 4
        .Col = 1: .Text = "Codigo":
        .CellAlignment = 4
        .Col = 2: .Text = "Institución Financiera":
        .CellAlignment = 4
        .Col = 3: .Text = "Captaciones":
        .CellAlignment = 4
        .Col = 4: .Text = "Forward Perd. Diferida":
        .CellAlignment = 4
        .Col = 5: .Text = "% Forward Perd. Diferida":
        .CellAlignment = 4
        .Col = 6: .Text = "Obligaciones <= 1 Año":
        .CellAlignment = 4
        .Col = 7: .Text = "Garantias Otorgadas":
        .CellAlignment = 4
        .Col = 8: .Text = "Afecto III.B.2. T/C SBIF": .CellAlignment = 4
        .CellAlignment = 4
        .Col = 9: .Text = "Afecto III.B.2. T/C R.C.": .CellAlignment = 4
        .CellAlignment = 4
        .Col = 10: .Text = "Status": .CellAlignment = 4
        .CellAlignment = 4

        .ColWidth(0) = 0
        .ColWidth(1) = 0
        .ColWidth(2) = 4000
        .ColWidth(3) = 2000
        .ColWidth(4) = 2000
        .ColWidth(5) = 2000
        .ColWidth(6) = 2000
        .ColWidth(7) = 2000
        .ColWidth(8) = 2000
        .ColWidth(9) = 2000
        .ColWidth(10) = 1000
        
    End With

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
    Select Case Button.Index
        Case 1
            Existe = False
    
            Call BUSCA_ENDEUDAMIENTO
            Call carga_grilla
            Call Carga_Sumatorias
        
        Case 2
            If Not Existe Then
               MsgBox "No se puede Imprimir, los Datos no Estan Guardados", 16, Me.Caption
               Call Limpiar
            Else
                Proc_Imprimir (1)
            End If
        Case 3
            If Not Existe Then
               MsgBox "No se puede Imprimir, los Datos no Estan Guardados", 16, Me.Caption
               Call Limpiar
            Else
                Proc_Imprimir (0)
            End If

    
        Case 4
            Unload Me
    
    End Select

End Sub
Private Sub Proc_Imprimir(nWinPri As Integer)
On Error GoTo Print_d

    Call LimpiarCristal

    BacControlFinanciero.CryFinanciero.WindowTitle = "Informe de Limite de Endeudamiento"
    BacControlFinanciero.CryFinanciero.ReportFileName = gsRPT_Path & "inf_limite_endeudamiento.rpt"
    BacControlFinanciero.CryFinanciero.Connect = swConeccion
    BacControlFinanciero.CryFinanciero.Destination = nWinPri
    BacControlFinanciero.CryFinanciero.WindowState = crptMaximized
    BacControlFinanciero.CryFinanciero.Action = 1
    
    
       'BacTrader.bacrpt.ReportFileName = RptList_Path & "PACAPTA1.RPT"
        '    BacTrader.bacrpt.StoredProcParam(0) = Trim(sNumoper$)
        '    BacTrader.bacrpt.StoredProcParam(1) = Format(gsBAC_Fecp, "YYYY-MM-DD 00:00:00.000")
        '    BacTrader.bacrpt.Connect = CONECCION
         '   BacTrader.bacrpt.Action = 1

Exit Sub

Print_d:
    MsgBox Err.Description, vbCritical, Me.Caption
End Sub

Function HabilitarControles(Valor As Boolean)
   
   Toolbar1.Buttons(1).Enabled = Valor
   Existe = Valor
   Frame.Enabled = Valor

End Function

Private Sub carga_grilla()
    
    Dim j As Integer
    On Error GoTo busca
    CapInter = 0
    ForPerDif = 0
    ForPerDif2 = 0
    Obligaciones = 0
    TotGarantias = 0
    GarantiasOtor = 0
    GarantiasDispo = 0
    Afecto = 0
    AfectoRC = 0
    
    With Grilla
        .Rows = 1
        .Rows = 2
        
         If Not Bac_Sql_Execute(gsBac_Parametros + ".dbo.Sp_Llena_Grilla") Then
            MsgBox " Error al Cargar la Información", 16, Me.Caption
            Exit Sub
         End If
         
         Do While Bac_SQL_Fetch(Datos())
             .Row = .Rows - 1
             .TextMatrix(.Row, 0) = Datos(1)
             .TextMatrix(.Row, 1) = Datos(2)
             .TextMatrix(.Row, 2) = Datos(3)
             .TextMatrix(.Row, 3) = Format(Datos(4), FEntero)     'Captaciones
             .TextMatrix(.Row, 4) = Format(Datos(5), FEntero)     'Forward Perdida
             .TextMatrix(.Row, 5) = Format(Datos(6), FEntero)     '%Forward Perdida Format((Datos(6) * gsBAC_DolarOBs), FEntero)
             .TextMatrix(.Row, 6) = Format(Datos(7), FEntero)     'Obligaciones < 1 año Format((Val(CDbl(.TextMatrix(.Row, 3)) + Val(CDbl(.TextMatrix(.Row, 5))))), FEntero)
             .TextMatrix(.Row, 7) = Format(Datos(8), FEntero)     'Garantias Otorgadas
             .TextMatrix(.Row, 8) = Format(Datos(9), FEntero)     'Afecto III .B2 T/C SBIF
             .TextMatrix(.Row, 9) = Format(Datos(23), FEntero)     'Afecto III .B2 T/C R.C
             
             'If CDbl(txtTres.text) - CDbl(Datos(9)) < 0 Then
             
              If CDbl(Datos(9)) > CDbl(txtTres.Text) Then
              
                    If CDbl(Datos(7)) < CDbl(Datos(8)) Then
                    
                         .TextMatrix(.Row, 10) = "OK"
                          For j = 0 To .Cols - 1
                         .Col = j
                         .CellForeColor = vbYellow
                          Next
                         .TextMatrix(.Row, 8) = "0"
                    
                    Else

                        If CDbl(Datos(18)) - CDbl(Datos(7)) - CDbl(Datos(8)) >= 0 Then

                               .TextMatrix(.Row, 10) = "OK"      '   CHA  2009-09-10
                                 For j = 0 To .Cols - 1
                                .Col = j
                                .CellForeColor = vbYellow
                                 Next
                              '  .TextMatrix(.Row, 8) = "0"

                         Else
                                .TextMatrix(.Row, 10) = "(" & Format(CDbl(Datos(18)) - CDbl(Datos(9)), FEntero) & ")" & "(*)"
                        End If
                    End If
                    '.TextMatrix(.Row, 9) = "(" & Format(CDbl(txtTres.text) - CDbl(Datos(9)), FEntero) & ")" & "(*)"
              Else
                .TextMatrix(.Row, 10) = "OK"   ' CHA 20090910
              End If
              
              CapInter = Val(CapInter) + Val(Datos(4))
              ForPerDif = Val(ForPerDif) + Val(Datos(5))
              ForPerDif2 = Val(ForPerDif2) + Val(CDbl(.TextMatrix(.Row, 5)))
              Obligaciones = Val(Obligaciones) + Val(CDbl(.TextMatrix(.Row, 6)))
              Afecto = Val(Afecto) + Val(CDbl(.TextMatrix(.Row, 8)))
              AfectoRC = Val(AfectoRC) + Val(CDbl(.TextMatrix(.Row, 9)))
              TotGarantias = Format(Datos(11), FEntero)
              GarantiasOtor = (CDbl(GarantiasOtor) + CDbl(Datos(8)))
              GarantiasDispo = (CDbl(Datos(11)) + CDbl(GarantiasOtor))

              .Rows = .Rows + 1
             Existe = True
         Loop
         
         If Existe = True Then
            .Rows = .Rows - 1
            Toolbar1.Buttons(2).Enabled = True
         End If

    End With
    
Exit Sub

busca:
    MsgBox "Se Detectó Problemas al Buscar la Información: " & Err.Description & ". Comunique al Administrador.", vbCritical, TITSISTEMA

End Sub

Private Sub BUSCA_ENDEUDAMIENTO()

On Error GoTo busca

    If Not Bac_Sql_Execute(gsBac_Parametros + ".dbo.Sp_Carga_Endeudamiento") Then
        MsgBox " Error al Cargar la Información", 16, Me.Caption
        Exit Sub
    End If
         
    If Bac_SQL_Fetch(Datos()) Then
        txtActivo.Text = Format(Datos(1), FDecimal)
        txtTres.Text = Format((CDbl(Datos(1)) * CDbl(Datos(2))) / 100, FDecimal)
        txtDiez.Text = Format((CDbl(Datos(1)) * CDbl(Datos(3))) / 100, FDecimal)
        txtBFW.Text = Format((CDbl(Datos(1)) * CDbl(Datos(4))) / 100, FDecimal)
        Frame2.Caption = Datos(2) & "%"
        Frame3.Caption = Datos(3) & "%"
        Frame5.Caption = Datos(4) & "%"
    End If

Exit Sub

busca:
    MsgBox "Se Detectó Problemas al Buscar la Información: " & Err.Description & ". Comunique al Administrador.", vbCritical, TITSISTEMA
End Sub

Private Sub Limpiar()
    
    txtActivo.Text = 0
    txtTres.Text = 0
    txtDiez.Text = 0

    TxtCapInter.Text = 0
    TxtForPerDif.Text = 0
    TxtForPerDif2.Text = 0
    TxtObligaciones.Text = 0
    TxtTotGarantias.Text = 0
    TxtGarantiasOtor.Text = 0
    TxtGarantiasDispo.Text = 0
    txtAfecto.Text = 0

    HabilitarControles True
    Grilla.Clear
    Toolbar1.Buttons(1).Enabled = False
    Toolbar1.Buttons(3).Enabled = False
    Toolbar1.Buttons(2).Enabled = True
    
    Call NombresGrilla

End Sub

Private Sub txtActivo_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 And txtActivo.Text <> 0 And txtActivo.Text <> "" Then
        txtTres.Text = (CDbl(txtActivo.Text) * 3) / 100
        txtDiez.Text = (CDbl(txtActivo.Text) * 10) / 100
    End If

    With Grilla
    
        If .Rows = 2 Then Exit Sub
    
        For i = 1 To .Rows - 1
            .Row = i
        
            If CDbl(.TextMatrix(.Row, 6)) < CDbl(txtTres.Text) Then
                .TextMatrix(.Row, 9) = "OK"
            Else
                .TextMatrix(.Row, 9) = "EXCEDIDO"
            End If
        Next
    End With
    
End Sub

Private Sub Carga_Sumatorias()

    TxtCapInter.Text = CapInter
    TxtForPerDif.Text = Format(ForPerDif, FDecimal)
    TxtForPerDif2.Text = ForPerDif2
    TxtObligaciones.Text = Obligaciones
    txtAfecto.Text = Afecto
    txtAfectoRC.Text = AfectoRC
    
    
    TxtGarantiasOtor.Text = Format(GarantiasOtor, FEntero)
    TxtTotGarantias.Text = Format(TotGarantias, FEntero)
    
    'If (CDbl(TxtTotGarantias.text) - CDbl(TxtGarantiasOtor.text)) > 0 Then
        'CBG
        'TxtGarantiasDispo.text = (CDbl(TxtTotGarantias.text) - CDbl(TxtGarantiasOtor.text))
        TxtGarantiasDispo.Text = CDbl(TxtTotGarantias.Text)
   ' Else
    
   '      TxtGarantiasDispo.text = 0
   ' End If
              
End Sub


