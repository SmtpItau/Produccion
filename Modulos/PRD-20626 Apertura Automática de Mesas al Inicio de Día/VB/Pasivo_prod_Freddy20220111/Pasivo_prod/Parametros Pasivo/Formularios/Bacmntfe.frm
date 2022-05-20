VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "Mscomctl.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "threed32.ocx"
Begin VB.Form BacMntFe 
   BorderStyle     =   1  'Fixed Single
   Caption         =   " Mantención de Feriados"
   ClientHeight    =   3765
   ClientLeft      =   2985
   ClientTop       =   2715
   ClientWidth     =   5565
   ClipControls    =   0   'False
   ForeColor       =   &H00C0C0C0&
   Icon            =   "Bacmntfe.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   3765
   ScaleWidth      =   5565
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   4050
      Top             =   0
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   24
      ImageHeight     =   24
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   2
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmntfe.frx":000C
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmntfe.frx":0EE6
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   480
      Left            =   0
      TabIndex        =   45
      Top             =   0
      Width           =   5565
      _ExtentX        =   9816
      _ExtentY        =   847
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Cerrar Ventana"
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin Threed.SSFrame SSFrame2 
      Height          =   810
      Left            =   15
      TabIndex        =   46
      Top             =   450
      Width           =   1935
      _Version        =   65536
      _ExtentX        =   3413
      _ExtentY        =   1429
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
      Begin VB.ComboBox cmbMeses 
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
         IntegralHeight  =   0   'False
         Left            =   60
         Style           =   2  'Dropdown List
         TabIndex        =   0
         Top             =   405
         Width           =   1815
      End
      Begin VB.Label Label 
         Caption         =   "Mes"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   255
         Index           =   2
         Left            =   120
         TabIndex        =   47
         Top             =   180
         Width           =   1335
      End
   End
   Begin Threed.SSFrame SSFrame3 
      Height          =   825
      Left            =   15
      TabIndex        =   48
      Top             =   1215
      Width           =   1935
      _Version        =   65536
      _ExtentX        =   3413
      _ExtentY        =   1455
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
      Begin VB.ComboBox cmbano 
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
         Left            =   90
         Style           =   2  'Dropdown List
         TabIndex        =   1
         Top             =   390
         Width           =   1425
      End
      Begin VB.Label Label 
         Caption         =   "Año"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   210
         Index           =   0
         Left            =   135
         TabIndex        =   49
         Top             =   180
         Width           =   615
      End
   End
   Begin Threed.SSFrame SSFrame4 
      Height          =   825
      Left            =   15
      TabIndex        =   50
      Top             =   1995
      Width           =   1935
      _Version        =   65536
      _ExtentX        =   3413
      _ExtentY        =   1455
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
      Begin VB.ComboBox cmbPlaza 
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
         Left            =   60
         Style           =   2  'Dropdown List
         TabIndex        =   2
         Top             =   420
         Width           =   1815
      End
      Begin VB.Label Label 
         Caption         =   "País"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   255
         Index           =   1
         Left            =   105
         TabIndex        =   51
         Top             =   195
         Width           =   1335
      End
   End
   Begin Threed.SSFrame SSFrame5 
      Height          =   3255
      Left            =   1965
      TabIndex        =   52
      Top             =   450
      Width           =   3570
      _Version        =   65536
      _ExtentX        =   6297
      _ExtentY        =   5741
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
      Begin VB.TextBox Text1 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   405
         Index           =   19
         Left            =   2505
         Locked          =   -1  'True
         TabIndex        =   22
         TabStop         =   0   'False
         Top             =   1380
         Width           =   495
      End
      Begin VB.TextBox Text1 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Index           =   41
         Left            =   2985
         Locked          =   -1  'True
         TabIndex        =   44
         TabStop         =   0   'False
         Top             =   2640
         Width           =   495
      End
      Begin VB.TextBox Text1 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Index           =   40
         Left            =   2505
         Locked          =   -1  'True
         TabIndex        =   43
         TabStop         =   0   'False
         Top             =   2640
         Width           =   495
      End
      Begin VB.TextBox Text1 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Index           =   39
         Left            =   2025
         Locked          =   -1  'True
         TabIndex        =   42
         TabStop         =   0   'False
         Top             =   2640
         Width           =   495
      End
      Begin VB.TextBox Text1 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Index           =   38
         Left            =   1545
         Locked          =   -1  'True
         TabIndex        =   41
         TabStop         =   0   'False
         Top             =   2640
         Width           =   495
      End
      Begin VB.TextBox Text1 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Index           =   37
         Left            =   1065
         Locked          =   -1  'True
         TabIndex        =   40
         TabStop         =   0   'False
         Top             =   2640
         Width           =   495
      End
      Begin VB.TextBox Text1 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Index           =   36
         Left            =   585
         Locked          =   -1  'True
         TabIndex        =   39
         TabStop         =   0   'False
         Top             =   2640
         Width           =   495
      End
      Begin VB.TextBox Text1 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Index           =   35
         Left            =   105
         Locked          =   -1  'True
         TabIndex        =   38
         TabStop         =   0   'False
         Top             =   2640
         Width           =   495
      End
      Begin VB.TextBox Text1 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Index           =   34
         Left            =   2985
         Locked          =   -1  'True
         TabIndex        =   37
         TabStop         =   0   'False
         Top             =   2205
         Width           =   495
      End
      Begin VB.TextBox Text1 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Index           =   33
         Left            =   2505
         Locked          =   -1  'True
         TabIndex        =   36
         TabStop         =   0   'False
         Top             =   2205
         Width           =   495
      End
      Begin VB.TextBox Text1 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Index           =   32
         Left            =   2025
         Locked          =   -1  'True
         TabIndex        =   35
         TabStop         =   0   'False
         Top             =   2205
         Width           =   495
      End
      Begin VB.TextBox Text1 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Index           =   31
         Left            =   1545
         Locked          =   -1  'True
         TabIndex        =   34
         TabStop         =   0   'False
         Top             =   2205
         Width           =   495
      End
      Begin VB.TextBox Text1 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Index           =   30
         Left            =   1065
         Locked          =   -1  'True
         TabIndex        =   33
         TabStop         =   0   'False
         Top             =   2205
         Width           =   495
      End
      Begin VB.TextBox Text1 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Index           =   29
         Left            =   585
         Locked          =   -1  'True
         TabIndex        =   32
         TabStop         =   0   'False
         Top             =   2205
         Width           =   495
      End
      Begin VB.TextBox Text1 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Index           =   28
         Left            =   105
         Locked          =   -1  'True
         TabIndex        =   31
         TabStop         =   0   'False
         Top             =   2205
         Width           =   495
      End
      Begin VB.TextBox Text1 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Index           =   27
         Left            =   2985
         Locked          =   -1  'True
         TabIndex        =   30
         TabStop         =   0   'False
         Top             =   1785
         Width           =   495
      End
      Begin VB.TextBox Text1 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Index           =   26
         Left            =   2505
         Locked          =   -1  'True
         TabIndex        =   29
         TabStop         =   0   'False
         Top             =   1785
         Width           =   495
      End
      Begin VB.TextBox Text1 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Index           =   25
         Left            =   2025
         Locked          =   -1  'True
         TabIndex        =   28
         TabStop         =   0   'False
         Top             =   1785
         Width           =   495
      End
      Begin VB.TextBox Text1 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Index           =   24
         Left            =   1545
         Locked          =   -1  'True
         TabIndex        =   27
         TabStop         =   0   'False
         Top             =   1785
         Width           =   495
      End
      Begin VB.TextBox Text1 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Index           =   23
         Left            =   1065
         Locked          =   -1  'True
         TabIndex        =   26
         TabStop         =   0   'False
         Top             =   1785
         Width           =   495
      End
      Begin VB.TextBox Text1 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Index           =   22
         Left            =   585
         Locked          =   -1  'True
         TabIndex        =   25
         TabStop         =   0   'False
         Top             =   1785
         Width           =   495
      End
      Begin VB.TextBox Text1 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Index           =   21
         Left            =   105
         Locked          =   -1  'True
         TabIndex        =   24
         TabStop         =   0   'False
         Top             =   1785
         Width           =   495
      End
      Begin VB.TextBox Text1 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Index           =   20
         Left            =   2985
         Locked          =   -1  'True
         TabIndex        =   23
         TabStop         =   0   'False
         Top             =   1380
         Width           =   495
      End
      Begin VB.TextBox Text1 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Index           =   18
         Left            =   2025
         Locked          =   -1  'True
         TabIndex        =   21
         TabStop         =   0   'False
         Top             =   1380
         Width           =   495
      End
      Begin VB.TextBox Text1 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Index           =   17
         Left            =   1545
         Locked          =   -1  'True
         TabIndex        =   20
         TabStop         =   0   'False
         Top             =   1380
         Width           =   495
      End
      Begin VB.TextBox Text1 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Index           =   16
         Left            =   1065
         Locked          =   -1  'True
         TabIndex        =   19
         TabStop         =   0   'False
         Top             =   1380
         Width           =   495
      End
      Begin VB.TextBox Text1 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Index           =   15
         Left            =   585
         Locked          =   -1  'True
         TabIndex        =   18
         TabStop         =   0   'False
         Top             =   1380
         Width           =   495
      End
      Begin VB.TextBox Text1 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Index           =   14
         Left            =   105
         Locked          =   -1  'True
         TabIndex        =   17
         TabStop         =   0   'False
         Top             =   1380
         Width           =   495
      End
      Begin VB.TextBox Text1 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Index           =   13
         Left            =   2985
         Locked          =   -1  'True
         TabIndex        =   16
         TabStop         =   0   'False
         Top             =   960
         Width           =   495
      End
      Begin VB.TextBox Text1 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Index           =   12
         Left            =   2505
         Locked          =   -1  'True
         TabIndex        =   15
         TabStop         =   0   'False
         Top             =   960
         Width           =   495
      End
      Begin VB.TextBox Text1 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Index           =   11
         Left            =   2025
         Locked          =   -1  'True
         TabIndex        =   14
         TabStop         =   0   'False
         Top             =   960
         Width           =   495
      End
      Begin VB.TextBox Text1 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Index           =   10
         Left            =   1545
         Locked          =   -1  'True
         TabIndex        =   13
         TabStop         =   0   'False
         Top             =   960
         Width           =   495
      End
      Begin VB.TextBox Text1 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Index           =   9
         Left            =   1065
         Locked          =   -1  'True
         TabIndex        =   12
         TabStop         =   0   'False
         Top             =   960
         Width           =   495
      End
      Begin VB.TextBox Text1 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Index           =   8
         Left            =   585
         Locked          =   -1  'True
         TabIndex        =   11
         TabStop         =   0   'False
         Top             =   960
         Width           =   495
      End
      Begin VB.TextBox Text1 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Index           =   7
         Left            =   105
         Locked          =   -1  'True
         TabIndex        =   10
         TabStop         =   0   'False
         Top             =   960
         Width           =   495
      End
      Begin VB.TextBox Text1 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Index           =   6
         Left            =   2985
         Locked          =   -1  'True
         TabIndex        =   9
         TabStop         =   0   'False
         Top             =   540
         Width           =   495
      End
      Begin VB.TextBox Text1 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Index           =   5
         Left            =   2505
         Locked          =   -1  'True
         TabIndex        =   8
         TabStop         =   0   'False
         Top             =   540
         Width           =   495
      End
      Begin VB.TextBox Text1 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Index           =   4
         Left            =   2025
         Locked          =   -1  'True
         TabIndex        =   7
         TabStop         =   0   'False
         Top             =   540
         Width           =   495
      End
      Begin VB.TextBox Text1 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Index           =   3
         Left            =   1545
         Locked          =   -1  'True
         TabIndex        =   6
         TabStop         =   0   'False
         Top             =   540
         Width           =   495
      End
      Begin VB.TextBox Text1 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Index           =   2
         Left            =   1065
         Locked          =   -1  'True
         TabIndex        =   5
         TabStop         =   0   'False
         Top             =   540
         Width           =   495
      End
      Begin VB.TextBox Text1 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Index           =   1
         Left            =   585
         Locked          =   -1  'True
         TabIndex        =   4
         TabStop         =   0   'False
         Top             =   540
         Width           =   495
      End
      Begin VB.TextBox Text1 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Index           =   0
         Left            =   105
         Locked          =   -1  'True
         TabIndex        =   3
         TabStop         =   0   'False
         Top             =   540
         Width           =   495
      End
      Begin VB.Label Label 
         Alignment       =   2  'Center
         Caption         =   "LUN"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   195
         Index           =   16
         Left            =   105
         TabIndex        =   59
         Top             =   240
         Width           =   495
      End
      Begin VB.Label Label 
         Alignment       =   2  'Center
         Caption         =   "MAR"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   195
         Index           =   15
         Left            =   585
         TabIndex        =   58
         Top             =   240
         Width           =   495
      End
      Begin VB.Label Label 
         Alignment       =   2  'Center
         Caption         =   "MIE"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   195
         Index           =   14
         Left            =   1065
         TabIndex        =   57
         Top             =   240
         Width           =   495
      End
      Begin VB.Label Label 
         Alignment       =   2  'Center
         Caption         =   "JUE"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   195
         Index           =   13
         Left            =   1545
         TabIndex        =   56
         Top             =   240
         Width           =   495
      End
      Begin VB.Label Label 
         Alignment       =   2  'Center
         Caption         =   "VIE"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   195
         Index           =   12
         Left            =   2025
         TabIndex        =   55
         Top             =   240
         Width           =   495
      End
      Begin VB.Label Label 
         Alignment       =   2  'Center
         Caption         =   "SAB"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   195
         Index           =   11
         Left            =   2505
         TabIndex        =   54
         Top             =   240
         Width           =   495
      End
      Begin VB.Label Label 
         Alignment       =   2  'Center
         Caption         =   "DOM"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   195
         Index           =   10
         Left            =   2985
         TabIndex        =   53
         Top             =   240
         Width           =   495
      End
   End
End
Attribute VB_Name = "BacMntFe"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim OptLocal          As String
Dim TemDB As Database
Dim TemWS As Workspace
Dim Sql As String
Dim Categoria As Integer
Dim Fecha_Feriado As String
Dim fene As String
Dim ffeb As String
Dim fmar As String
Dim fabr As String
Dim fmay As String
Dim fjun As String
Dim fjul As String
Dim fago As String
Dim fsep As String
Dim foct As String
Dim fnov As String
Dim fdic As String
Dim sdfin As String
Dim i As Integer

Private Sub FechaDefault()
Dim f As Long

On Error GoTo Label1

    cmbMeses.Tag = "MESES"
    cmbano.Tag = "AÑO"
    cmbPlaza.Tag = "PLAZA"
    
    'Mostramos el año por default del sistema operativo
    '--------------------------------------------------
    cmbano.Text = Year(gsbac_fecp)
   
    'Mostramos el mes por default del sistema operativo
    '--------------------------------------------------
    For f = 0 To cmbMeses.ListCount - 1
        If cmbMeses.ItemData(f) = Month(gsbac_fecp) Then
           cmbMeses.ListIndex = f
           Exit For
        End If
    Next f

    cmbMeses.Tag = ""
    cmbano.Tag = ""
    cmbPlaza.Tag = ""
    
    Exit Sub

Label1:

End Sub

Private Sub GeneraMes()

On Error GoTo Label1
Dim IdPlaza As String

Dim i        As Integer
Dim iDia     As Integer
Dim iUltDia  As Integer
Dim iDiaMes  As Integer
Dim D        As Integer

Dim sDate    As String
Dim sMes     As String
Dim sAno     As String
Dim sString  As String
Dim sFeriado As String
    
Dim fAno As Integer
Dim fPlaza As Integer
    Screen.MousePointer = 11
    
    sMes = Format(cmbMeses.ListIndex + 1, "00") + "/"
    sAno = Format(cmbano.Text, "0000")
    sDate = "01/" + sMes + sAno
    
    If Not IsDate(sDate) Then
       Screen.MousePointer = 0
       Exit Sub
    End If
    
    If cmbPlaza.ListIndex = -1 Then
       MsgBox "No ha seleccionado plaza", vbCritical, TITSISTEMA
       Screen.MousePointer = 0
       Exit Sub
    End If
    iDia = Weekday(sDate)
    iDia = IIf(iDia = 1, 7, iDia - 1)
    
    If UCase(Trim(Left(cmbPlaza, 20))) Like "*CHILE*" Then
         Categoria = 151
    ElseIf UCase(Trim(Left(cmbPlaza, 20))) Like "*ESTADOS UNIDOS*" Or UCase(Trim(Left(cmbPlaza, 20))) Like "*USA*" Then
         Categoria = 188
    Else
        Categoria = 0
    End If
    
    IdPlaza = Trim(Right(cmbPlaza.Text, 6))
    Envia = Array()
    AddParam Envia, cmbano.Text
    AddParam Envia, IdPlaza
     
    If Not BAC_SQL_EXECUTE("SP_FELEER ", Envia) Then
        Exit Sub
    End If
    
  '  Call Limpiar
    
    ReDim Datos(14)
        

        iUltDia = DiasDelMes(Val(sMes), CDbl(sAno))
        sFeriado = ""
    If BAC_SQL_FETCH(Datos()) Then
        fAno = Datos(1)
        fPlaza = Datos(2)
         Select Case Trim(Left(sMes, 2))
           Case 1: sFeriado = Datos(3)
           Case 2: sFeriado = Datos(4)
           Case 3: sFeriado = Datos(5)
           Case 4: sFeriado = Datos(6)
           Case 5: sFeriado = Datos(7)
           Case 6: sFeriado = Datos(8)
           Case 7: sFeriado = Datos(9)
           Case 8: sFeriado = Datos(10)
           Case 9: sFeriado = Datos(11)
           Case 10: sFeriado = Datos(12)
           Case 11: sFeriado = Datos(13)
           Case 12: sFeriado = Datos(14)
           
        End Select
        Dim fene As String
    fene = Datos(3)
    ffeb = Datos(4)
    fmar = Datos(5)
    fabr = Datos(6)
    fmay = Datos(7)
    fjun = Datos(8)
    fjul = Datos(9)
    fago = Datos(10)
    fsep = Datos(11)
    foct = Datos(12)
    fnov = Datos(13)
    fdic = Datos(14)

    End If
       iDiaMes = 1
       D = iDia
        For i = 1 To 42
'           lblMes(i - 1).Tag = "0"
'           lblMes(i - 1).ForeColor = &H0&
'           lblMes(i - 1).Caption = ""
'           If iDia <= i Then
'              If iDiaMes <= iUltDia Then
'                 lblMes(i - 1).Caption = Format(iDiaMes, "00")
'                 If InStr(1, sFeriado, Format(iDiaMes, "00")) > 0 Then ' D > 5 Or
'                    lblMes(i - 1).Tag = "1" '"0"
'                    lblMes(i - 1).ForeColor = &HFF& '&H0&
'                 End If
'                 D = IIf(D = 7, 1, D + 1)
'               End If
'               iDiaMes = iDiaMes + 1
'           End If
           Text1(i - 1).Tag = "0"
           Text1(i - 1).ForeColor = &H0&
           Text1(i - 1).Text = ""
           Text1(i - 1).TabStop = False
           If iDia <= i Then
              If iDiaMes <= iUltDia Then
                 Text1(i - 1).Text = Format(iDiaMes, "00")
                 Text1(i - 1).TabStop = True
                 If InStr(1, sFeriado, Format(iDiaMes, "00")) > 0 Then ' D > 5 Or
                    Text1(i - 1).Tag = "1" '"0"
                    Text1(i - 1).ForeColor = &HFF& '&H0&
                 End If
                 D = IIf(D = 7, 1, D + 1)
               End If
               iDiaMes = iDiaMes + 1
           End If
        Next i
   
       
    Screen.MousePointer = 0
    Exit Sub
 
    
Exit Sub
Label1:
    MsgBox "Error cargando días feriados: " & err.Description, vbCritical, TITSISTEMA
    Screen.MousePointer = 0
    
End Sub


Private Function DiasDelMes(Mes As Integer, Ann As Integer) As Integer

Dim dias    As String
Dim Residuo As Currency

On Error GoTo Label1

    dias = "312831303130313130313031"
    
    If Mes = 2 Then
        Residuo = Ann Mod 4
        If Residuo = 0 Then
            DiasDelMes = 29
        Else
            DiasDelMes = 28
        End If
    Else
        DiasDelMes = CDbl(Mid$(dias, ((Mes * 2) - 1), 2))
    End If
    Exit Function

Label1:
   ' Call objMensajesFE.BacMsgError

End Function



Private Function ValidaDatos() As Integer

On Error GoTo Label1

    ValidaDatos = False
    
    If Trim$(cmbMeses.Text) = "" Then
        Me.MousePointer = 0
       MsgBox "No ha seleccionado mes", vbCritical, TITSISTEMA
       Exit Function
    End If
    
    If Trim$(cmbPlaza.Text) = "" Then
        Me.MousePointer = 0
       MsgBox "No ha seleccionado plaza", vbCritical, TITSISTEMA
       Exit Function
    End If
     
    If CDbl(cmbano.Text) = 0 Then
       Me.MousePointer = 0
       MsgBox "No ha ingresado año", vbCritical, TITSISTEMA
       Exit Function
    End If
    
    ValidaDatos = True
   
Exit Function

Label1:
    MsgBox "Error de sistema ", vbCritical, TITSISTEMA

End Function


Private Sub cmbano_Click()
Call GeneraMes
End Sub

Private Sub cmbMeses_Click()
        
    If Trim$(cmbMeses.Tag) = "" Then
         If cmbMeses.ListIndex <> -1 And cmbPlaza.ListIndex <> -1 Then
               Call GeneraMes
         End If
    End If
    
End Sub


Private Sub cmbPlaza_Click()

    If Trim$(cmbPlaza.Tag) = "" Then
       If cmbPlaza.ListIndex <> -1 And cmbMeses.ListIndex <> -1 Then
                Call GeneraMes
       End If
    End If
    
End Sub



Private Sub CmdGrabar_Click()

On Error GoTo Label1
Dim sFecha As String
Dim sString As String
Dim i       As Integer
Dim iDia    As Integer
Dim sMes    As Integer

Screen.MousePointer = 11
    If ValidaDatos() = False Then
       Exit Sub
    End If
    
    sString = ""
    
    iDia = 1
    
    For i = 1 To 42
        If Text1(i - 1).Tag = "1" Then
            If iDia <= 5 Then
                sString = sString + Text1(i - 1).Text + ","
                sFecha = sFecha & Text1(i - 1).Text + "/" & Format(cmbMeses.ListIndex + 1, "00") & "/" & cmbano.Text

            Else
                sString = sString + Text1(i - 1).Text + ","
                sFecha = sFecha & Text1(i - 1).Text + "/" & Format(cmbMeses.ListIndex + 1, "00") & "/" & cmbano.Text

            End If
        End If
        iDia = IIf(iDia = 7, 1, iDia + 1)
    Next i
                    
    For i = Len(Trim$(sString)) To 11
        sString = sString + "00,"
    Next i
    
    
    sMes = Format(cmbMeses.ListIndex + 1, "00")
    
    Select Case sMes
        Case 1: fene = sString
        Case 2: ffeb = sString
        Case 3: fmar = sString
        Case 4: fabr = sString
        Case 5: fmay = sString
        Case 6: fjun = sString
        Case 7: fjul = sString
        Case 8: fago = sString
        Case 9: fsep = sString
        Case 10: foct = sString
        Case 11: fnov = sString
        Case 12: fdic = sString
    End Select
    
    
    Envia = Array()
    AddParam Envia, cmbano.Text
    AddParam Envia, Trim(Right(cmbPlaza.Text, 6))
    AddParam Envia, fene
    AddParam Envia, ffeb
    AddParam Envia, fmar
    AddParam Envia, fabr
    AddParam Envia, fmay
    AddParam Envia, fjun
    AddParam Envia, fjul
    AddParam Envia, fago
    AddParam Envia, fsep
    AddParam Envia, foct
    AddParam Envia, fnov
    AddParam Envia, fdic
    
    If Not BAC_SQL_EXECUTE("SP_FEGRABAR ", Envia) Then
       MsgBox "La Grabación no se realizó correctamente", vbCritical, TITSISTEMA
       Exit Sub
    End If
               
        
       MsgBox "La Grabación  se realizó correctamente", vbInformation, TITSISTEMA
       Screen.MousePointer = 0
       Exit Sub

Label1:
    MsgBox "Error en la Grabación :" & err.Description, vbCritical, TITSISTEMA
    
End Sub


Private Sub cmdSalir_Click()

    Unload Me
        
End Sub


Private Sub DataFox_Error(DataErr As Integer, Response As Integer)
Select Case DataErr
           Case 3051
                   MsgBox "                mbtablas no fue abierta :     " & DataErr & Chr(10) & _
                               " posiblemente se esta utilizando de modo exclusivo ", vbCritical, TITSISTEMA
                   Unload Me
End Select
End Sub

Private Sub Combo1_Change()

End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
Dim opcion As Integer

If KeyCode <> vbKeyControl And (Shift = 2 Or (Shift = 0 And (KeyCode = vbKeyReturn Or KeyCode = vbKeyEscape Or (KeyCode >= vbKeyF1 And KeyCode <= vbKeyF12)))) Then

   opcion = 0

   Select Case KeyCode

         Case vbKeyGrabar
               opcion = 1
         

         Case vbKeySalir
               opcion = 2
   End Select

   If opcion <> 0 Then
      
      KeyCode = 0
      If Toolbar1.Buttons(opcion).Enabled Then
         Call Toolbar1_ButtonClick(Toolbar1.Buttons(opcion))
      End If
      KeyCode = 0

   End If

End If

End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)
        
    If KeyAscii = 13 Then
       SendKeys "{TAB}"
    End If
        
End Sub

Private Sub Form_Load()
Const Chile = 1
Dim Defecto As Integer

Me.Icon = BAC_Parametros.Icon

OptLocal = Opt
Me.Top = 0
Me.Left = 0
On Error GoTo Label1


  
    Call BacLLenaComboMes(cmbMeses)
    For i = 1900 To 2054
      Me.cmbano.AddItem i
    Next
    cmbano.Text = CDbl(Year(gsbac_fecp))
   Defecto = -1
   
   
   If BAC_SQL_EXECUTE("SP_Selecciona_Pais") Then
      
      Do While BAC_SQL_FETCH(Datos())
      
         cmbPlaza.AddItem (Datos(2)) + Space(40 + Len(Datos(2))) + Str(Datos(1))
      
         If Datos(1) = Chile Then
            Defecto = cmbPlaza.ListCount - 1
            cmbPlaza.Tag = ""
         End If
      
      Loop
      
   End If
    
   ' If Not Llenar_Combos(cmbPlaza, 180) Then 'Categoría 180
   '     Unload Me
   '     Exit Sub
   ' End If
    
    Call FechaDefault
    
    
    cmbPlaza.ListIndex = Defecto
    
    cmbPlaza_Click
    
    
    
    Call LogAuditoria("07", OptLocal, Me.Caption, "", "")
       
    Exit Sub

Label1:
    
    MsgBox "Error cargando formulario", vbCritical, TITSISTEMA
    Unload Me
    Exit Sub
    
End Sub


Private Sub Form_Unload(Cancel As Integer)
    Call LogAuditoria("08", OptLocal, Me.Caption, "", "")
End Sub


Private Sub Text1_Click(Index As Integer)
On Error GoTo Label1

Dim f As Integer
    If Text1(Index) = "" Then
         Bac_SendKey vbKeyTab
         Exit Sub
    End If
  
    If Text1(Index).Tag = "0" Then
        Text1(Index).ForeColor = &HFF&
        Text1(Index).Tag = "1"
    Else
        Text1(Index).ForeColor = &H0&
        Text1(Index).Tag = "0"
    End If
    
      
    Exit Sub
    
Label1:
   MsgBox "Error seleccionando mes", vbCritical, TITSISTEMA
End Sub


Private Sub Text1_KeyPress(Index As Integer, KeyAscii As Integer)
If KeyAscii <> 13 And KeyAscii <> vbKeyGrabar Then
 Call Text1_Click(Index)
End If
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Index
   Case 1
         On Error GoTo Label11
Dim sFecha As String
Dim sString As String
Dim i       As Integer
Dim iDia    As Integer
Dim sMes    As Integer
Dim TodosF  As String
TodosF = " Dias Feriados: "

Screen.MousePointer = 11
    If ValidaDatos() = False Then
       Exit Sub
    End If
    
    sString = ""
    
    iDia = 1
    
    For i = 1 To 42
        If Text1(i - 1).Tag = "1" Then
            If iDia <= 5 Then
                sString = sString + Text1(i - 1).Text + ","
                sFecha = sFecha & Text1(i - 1).Text + "/" & Format(cmbMeses.ListIndex + 1, "00") & "/" & cmbano.Text

            Else
                sString = sString + Text1(i - 1).Text + ","
                sFecha = sFecha & Text1(i - 1).Text + "/" & Format(cmbMeses.ListIndex + 1, "00") & "/" & cmbano.Text

            End If

        End If
        iDia = IIf(iDia = 7, 1, iDia + 1)
    Next i

' -----
    For i = 1 To 42
        If Text1(i - 1).ForeColor = &HFF& Then
          TodosF = TodosF & Text1(i - 1) & ","
        End If
    Next i

    TodosF = Mid(TodosF, 1, Len(TodosF) - 1)
' -----
                    
    For i = Len(Trim$(sString)) To 11
        sString = sString + "00,"
    Next i
    
    sMes = Format(cmbMeses.ListIndex + 1, "00")

    Select Case sMes
        Case 1: fene = sString
        Case 2: ffeb = sString
        Case 3: fmar = sString
        Case 4: fabr = sString
        Case 5: fmay = sString
        Case 6: fjun = sString
        Case 7: fjul = sString
        Case 8: fago = sString
        Case 9: fsep = sString
        Case 10: foct = sString
        Case 11: fnov = sString
        Case 12: fdic = sString
    End Select
    
    Envia = Array()
    AddParam Envia, cmbano.Text
    AddParam Envia, Trim(Right(cmbPlaza.Text, 6))
    AddParam Envia, fene
    AddParam Envia, ffeb
    AddParam Envia, fmar
    AddParam Envia, fabr
    AddParam Envia, fmay
    AddParam Envia, fjun
    AddParam Envia, fjul
    AddParam Envia, fago
    AddParam Envia, fsep
    AddParam Envia, foct
    AddParam Envia, fnov
    AddParam Envia, fdic
    
    
    If Not BAC_SQL_EXECUTE("SP_FEGRABAR ", Envia) Then
       MsgBox "La Grabación no se realizó correctamente", vbCritical, TITSISTEMA
       Call LogAuditoria("01", OptLocal, Me.Caption & " Error al grabar- Año: " & cmbano.Text & " Mes: " & cmbMeses.Text & TodosF & " Pais: " & cmbPlaza.Text, "", "")
       Exit Sub
    End If
       i = cmbPlaza.ListIndex
       
       MsgBox "La Grabación  se realizó correctamente", vbInformation, TITSISTEMA
       cmbPlaza.ListIndex = i
        
       Call LogAuditoria("01", OptLocal, Me.Caption, "", "Año: " & cmbano.Text & " Mes: " & cmbMeses.Text & TodosF & " Pais: " & cmbPlaza.Text)
       Screen.MousePointer = 0
       Exit Sub

Label11:
   MsgBox "Error en la Grabación :" & err.Description, vbCritical, TITSISTEMA
   Call LogAuditoria("01", OptLocal, Me.Caption & " Error al grabar- Año: " & cmbano.Text & " Mes: " & cmbMeses.Text & TodosF & " Pais: " & cmbPlaza.Text, "", "")
   Case 2
      Unload Me
End Select
End Sub
