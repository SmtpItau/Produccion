VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "threed32.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{989C9190-EDF5-45A8-AB6C-98E6EF0384D7}#1.0#0"; "Bac_Controles_Pas.ocx"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{BDC217C8-ED16-11CD-956C-0000C04E4C0A}#1.1#0"; "TABCTL32.OCX"
Begin VB.Form FRM_FORMULAS 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantenedor de Formulas"
   ClientHeight    =   6630
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   10080
   Icon            =   "FRM_FORMULAS.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   6630
   ScaleWidth      =   10080
   Begin TabDlg.SSTab Tab_Formula 
      Height          =   6075
      Left            =   30
      TabIndex        =   0
      Top             =   570
      Width           =   10035
      _ExtentX        =   17701
      _ExtentY        =   10716
      _Version        =   393216
      Style           =   1
      Tabs            =   4
      TabsPerRow      =   4
      TabHeight       =   529
      BackColor       =   -2147483644
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      TabCaption(0)   =   " 1.- Instrumento"
      TabPicture(0)   =   "FRM_FORMULAS.frx":2EFA
      Tab(0).ControlEnabled=   -1  'True
      Tab(0).Control(0)=   "Tab_Instrumentos"
      Tab(0).Control(0).Enabled=   0   'False
      Tab(0).ControlCount=   1
      TabCaption(1)   =   "2.- Opciones"
      Tab(1).ControlEnabled=   0   'False
      Tab(1).Control(0)=   "Tab_Opciones"
      Tab(1).ControlCount=   1
      TabCaption(2)   =   "3.- Formula"
      Tab(2).ControlEnabled=   0   'False
      Tab(2).Control(0)=   "Tab_Formulas"
      Tab(2).ControlCount=   1
      TabCaption(3)   =   "4.- Copia Formulas"
      Tab(3).ControlEnabled=   0   'False
      Tab(3).Control(0)=   "Fr_Copias"
      Tab(3).ControlCount=   1
      Begin Threed.SSFrame Tab_Instrumentos 
         Height          =   5685
         Left            =   60
         TabIndex        =   37
         Top             =   330
         Width           =   9915
         _Version        =   65536
         _ExtentX        =   17489
         _ExtentY        =   10028
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
         Begin Threed.SSFrame Frm_Detalle 
            Height          =   4395
            Left            =   60
            TabIndex        =   42
            Top             =   1230
            Width           =   9795
            _Version        =   65536
            _ExtentX        =   17277
            _ExtentY        =   7752
            _StockProps     =   14
            Caption         =   "Descripcion Instrumento"
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Begin Threed.SSFrame Fr_Valorizacion 
               Height          =   2385
               Left            =   120
               TabIndex        =   53
               Top             =   1950
               Width           =   9555
               _Version        =   65536
               _ExtentX        =   16854
               _ExtentY        =   4207
               _StockProps     =   14
               Caption         =   "Valorizacion"
               BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Begin Threed.SSFrame Fr_Datos_Valorizar 
                  Height          =   1875
                  Left            =   210
                  TabIndex        =   68
                  Top             =   330
                  Width           =   9135
                  _Version        =   65536
                  _ExtentX        =   16113
                  _ExtentY        =   3307
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
                  Enabled         =   0   'False
                  Begin BACControles.TXTNumero Txt_Tir 
                     Height          =   315
                     Left            =   2130
                     TabIndex        =   12
                     Top             =   750
                     Width           =   2025
                     _ExtentX        =   3572
                     _ExtentY        =   556
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
                     Text            =   "0,0000"
                     Text            =   "0,0000"
                     Min             =   "-99"
                     Max             =   "99"
                     CantidadDecimales=   "4"
                     Separator       =   -1  'True
                     MarcaTexto      =   -1  'True
                  End
                  Begin BACControles.TXTFecha Txt_Fecha_Valorizacion 
                     Height          =   315
                     Left            =   2160
                     TabIndex        =   11
                     Top             =   300
                     Width           =   1275
                     _ExtentX        =   2249
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
                     Text            =   "03/04/2003"
                  End
                  Begin BACControles.TXTNumero Txt_Nominal 
                     Height          =   315
                     Left            =   2130
                     TabIndex        =   13
                     Top             =   1170
                     Width           =   2025
                     _ExtentX        =   3572
                     _ExtentY        =   556
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
                     Text            =   "0,0000"
                     Text            =   "0,0000"
                     Min             =   "1"
                     Max             =   "999999999999"
                     CantidadDecimales=   "4"
                     Separator       =   -1  'True
                     MarcaTexto      =   -1  'True
                  End
                  Begin BACControles.TXTNumero Txt_Vpar 
                     Height          =   315
                     Left            =   6930
                     TabIndex        =   14
                     Top             =   300
                     Width           =   2025
                     _ExtentX        =   3572
                     _ExtentY        =   556
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
                     Text            =   "0,0000"
                     Text            =   "0,0000"
                     Min             =   "1"
                     Max             =   "999"
                     CantidadDecimales=   "4"
                     Separator       =   -1  'True
                     MarcaTexto      =   -1  'True
                  End
                  Begin BACControles.TXTNumero Txt_Valor_Presente 
                     Height          =   315
                     Left            =   6930
                     TabIndex        =   15
                     Top             =   720
                     Width           =   2025
                     _ExtentX        =   3572
                     _ExtentY        =   556
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
                     Text            =   "0"
                     Text            =   "0"
                     Min             =   "-999999999999"
                     Max             =   "999999999999"
                     Separator       =   -1  'True
                     MarcaTexto      =   -1  'True
                  End
                  Begin BACControles.TXTNumero Txt_Valor_Presente_UM 
                     Height          =   315
                     Left            =   6930
                     TabIndex        =   16
                     Top             =   1140
                     Width           =   2025
                     _ExtentX        =   3572
                     _ExtentY        =   556
                     BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
                        Name            =   "Arial"
                        Size            =   8.25
                        Charset         =   0
                        Weight          =   700
                        Underline       =   0   'False
                        Italic          =   0   'False
                        Strikethrough   =   0   'False
                     EndProperty
                     Text            =   "0,0000"
                     Text            =   "0,0000"
                     Min             =   "-999999999999"
                     Max             =   "999999999999"
                     CantidadDecimales=   "4"
                     Separator       =   -1  'True
                     MarcaTexto      =   -1  'True
                  End
                  Begin VB.Label Label11 
                     Caption         =   "Valor Presente en $"
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
                     Left            =   4860
                     TabIndex        =   74
                     Top             =   810
                     Width           =   1935
                  End
                  Begin VB.Label Label8 
                     Caption         =   "Valor Presente en UM"
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
                     Left            =   4860
                     TabIndex        =   73
                     Top             =   1260
                     Width           =   1935
                  End
                  Begin VB.Label Label7 
                     Caption         =   "Fecha Valorizacion"
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
                     Left            =   150
                     TabIndex        =   72
                     Top             =   390
                     Width           =   1815
                  End
                  Begin VB.Label Label6 
                     Caption         =   "% Valor Par"
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
                     Left            =   4860
                     TabIndex        =   71
                     Top             =   345
                     Width           =   1335
                  End
                  Begin VB.Label Label4 
                     Caption         =   "TIR"
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
                     Left            =   150
                     TabIndex        =   70
                     Top             =   840
                     Width           =   1935
                  End
                  Begin VB.Label Label3 
                     Caption         =   "Nominal"
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
                     Left            =   150
                     TabIndex        =   69
                     Top             =   1290
                     Width           =   1185
                  End
               End
            End
            Begin Threed.SSFrame Fr_Descripcion 
               Height          =   1695
               Left            =   120
               TabIndex        =   43
               Top             =   210
               Width           =   9555
               _Version        =   65536
               _ExtentX        =   16854
               _ExtentY        =   2990
               _StockProps     =   14
               BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Enabled         =   0   'False
               Begin VB.TextBox Txt_Moneda 
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
                  Left            =   5490
                  TabIndex        =   9
                  Top             =   960
                  Width           =   1275
               End
               Begin VB.TextBox Txt_Nombre 
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
                  Left            =   5490
                  TabIndex        =   7
                  Top             =   240
                  Width           =   3975
               End
               Begin BACControles.TXTNumero Txt_Base 
                  Height          =   315
                  Left            =   2160
                  TabIndex        =   5
                  Top             =   960
                  Width           =   1275
                  _ExtentX        =   2249
                  _ExtentY        =   556
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
                  Text            =   "0"
                  Text            =   "0"
                  Separator       =   -1  'True
                  MarcaTexto      =   -1  'True
               End
               Begin BACControles.TXTFecha Txt_Fecha_Emsion 
                  Height          =   315
                  Left            =   2160
                  TabIndex        =   3
                  Top             =   240
                  Width           =   1275
                  _ExtentX        =   2249
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
                  Text            =   "03/04/2003"
               End
               Begin BACControles.TXTFecha Txt_Fecha_Vcto 
                  Height          =   315
                  Left            =   2160
                  TabIndex        =   4
                  Top             =   600
                  Width           =   1275
                  _ExtentX        =   2249
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
                  Text            =   "03/04/2003"
               End
               Begin BACControles.TXTNumero Txt_Tasa 
                  Height          =   315
                  Left            =   2160
                  TabIndex        =   6
                  Top             =   1290
                  Width           =   1275
                  _ExtentX        =   2249
                  _ExtentY        =   556
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
                  Text            =   "0,0000"
                  Text            =   "0,0000"
                  CantidadDecimales=   "4"
                  Separator       =   -1  'True
                  MarcaTexto      =   -1  'True
               End
               Begin BACControles.TXTNumero Txt_Pago 
                  Height          =   315
                  Left            =   5490
                  TabIndex        =   8
                  Top             =   600
                  Width           =   1275
                  _ExtentX        =   2249
                  _ExtentY        =   556
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
                  Text            =   "0"
                  Text            =   "0"
                  Separator       =   -1  'True
                  MarcaTexto      =   -1  'True
               End
               Begin BACControles.TXTNumero Txt_Cupones 
                  Height          =   315
                  Left            =   5490
                  TabIndex        =   10
                  Top             =   1290
                  Width           =   1275
                  _ExtentX        =   2249
                  _ExtentY        =   556
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
                  Text            =   "0"
                  Text            =   "0"
                  Separator       =   -1  'True
                  MarcaTexto      =   -1  'True
               End
               Begin VB.Label Label1 
                  Caption         =   "Nombre Emisor"
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
                  Left            =   3750
                  TabIndex        =   51
                  Top             =   360
                  Width           =   2055
               End
               Begin VB.Label Label2 
                  Caption         =   "Fecha de Emisión"
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
                  Left            =   120
                  TabIndex        =   50
                  Top             =   360
                  Width           =   1815
               End
               Begin VB.Label Label9 
                  Caption         =   "Período Pago"
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
                  Left            =   3750
                  TabIndex        =   49
                  Top             =   720
                  Width           =   2055
               End
               Begin VB.Label Label12 
                  Caption         =   "Tasa Emision"
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
                  Left            =   120
                  TabIndex        =   48
                  Top             =   1365
                  Width           =   1335
               End
               Begin VB.Label Label13 
                  Caption         =   "Moneda Emision"
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
                  Left            =   3750
                  TabIndex        =   47
                  Top             =   1050
                  Width           =   1425
               End
               Begin VB.Label Label10 
                  Caption         =   "Nº de Cupones"
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
                  Left            =   3750
                  TabIndex        =   46
                  Top             =   1380
                  Width           =   1455
               End
               Begin VB.Label Label5 
                  Caption         =   "Fecha de Vencimiento"
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
                  Left            =   120
                  TabIndex        =   45
                  Top             =   720
                  Width           =   1935
               End
               Begin VB.Label Label23 
                  Caption         =   "Base Emision"
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
                  Left            =   120
                  TabIndex        =   44
                  Top             =   1050
                  Width           =   1185
               End
            End
         End
         Begin Threed.SSFrame Fr_Encabezado 
            Height          =   1095
            Left            =   60
            TabIndex        =   39
            Top             =   120
            Width           =   9765
            _Version        =   65536
            _ExtentX        =   17224
            _ExtentY        =   1931
            _StockProps     =   14
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Begin Threed.SSFrame Fr_Serie 
               Height          =   855
               Left            =   5070
               TabIndex        =   40
               Top             =   150
               Width           =   4515
               _Version        =   65536
               _ExtentX        =   7964
               _ExtentY        =   1508
               _StockProps     =   14
               Caption         =   " Serie "
               BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Begin VB.TextBox Txt_Serie 
                  Enabled         =   0   'False
                  BeginProperty Font 
                     Name            =   "Arial"
                     Size            =   8.25
                     Charset         =   0
                     Weight          =   700
                     Underline       =   0   'False
                     Italic          =   0   'False
                     Strikethrough   =   0   'False
                  EndProperty
                  Height          =   375
                  Left            =   600
                  MaxLength       =   12
                  TabIndex        =   2
                  Top             =   300
                  Width           =   3375
               End
            End
            Begin Threed.SSFrame Fr_Instrumento 
               Height          =   855
               Left            =   180
               TabIndex        =   41
               Top             =   150
               Width           =   4515
               _Version        =   65536
               _ExtentX        =   7964
               _ExtentY        =   1508
               _StockProps     =   14
               Caption         =   " Instrumento "
               BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Begin VB.TextBox Txt_Instrumento 
                  BeginProperty Font 
                     Name            =   "Arial"
                     Size            =   8.25
                     Charset         =   0
                     Weight          =   700
                     Underline       =   0   'False
                     Italic          =   0   'False
                     Strikethrough   =   0   'False
                  EndProperty
                  Height          =   375
                  Left            =   570
                  MaxLength       =   8
                  TabIndex        =   1
                  Top             =   300
                  Width           =   3375
               End
            End
         End
      End
      Begin Threed.SSFrame Tab_Opciones 
         Height          =   5685
         Left            =   -74970
         TabIndex        =   38
         Top             =   330
         Width           =   9915
         _Version        =   65536
         _ExtentX        =   17489
         _ExtentY        =   10028
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
         Begin VB.Frame Fr_Formula 
            Caption         =   "Seleccione Modo de Calculo para Bonos"
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
            Height          =   2970
            Left            =   90
            TabIndex        =   54
            Top             =   930
            Width           =   9735
            Begin Threed.SSFrame Fr_Opciones 
               Height          =   1845
               Left            =   765
               TabIndex        =   55
               Top             =   555
               Width           =   8025
               _Version        =   65536
               _ExtentX        =   14155
               _ExtentY        =   3254
               _StockProps     =   14
               Caption         =   "Opciones"
               BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Begin VB.OptionButton tip_opt_tasa 
                  Caption         =   "Tasa de Interés y Monto Tranzado"
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
                  Left            =   2550
                  TabIndex        =   17
                  Top             =   420
                  Value           =   -1  'True
                  Width           =   3285
               End
               Begin VB.OptionButton tip_opt_valor 
                  Caption         =   "% Valor de Compra y Monto Tranzado"
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
                  Height          =   375
                  Left            =   2550
                  TabIndex        =   18
                  Top             =   780
                  Width           =   3435
               End
               Begin VB.OptionButton tip_opt_tir 
                  Caption         =   "TIR y Valor de Compra"
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
                  Height          =   375
                  Left            =   2550
                  TabIndex        =   19
                  Top             =   1260
                  Width           =   2475
               End
            End
         End
      End
      Begin Threed.SSFrame Tab_Formulas 
         Height          =   5685
         Left            =   -74940
         TabIndex        =   52
         Top             =   330
         Width           =   9915
         _Version        =   65536
         _ExtentX        =   17489
         _ExtentY        =   10028
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
         Begin VB.Frame Fr_Crea_Formula 
            Caption         =   "Esta es la Fórmula que Ud. Está Creando"
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
            Height          =   1410
            Left            =   90
            TabIndex        =   61
            Top             =   4140
            Width           =   9765
            Begin VB.TextBox Text_Formula 
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   375
               Left            =   75
               TabIndex        =   28
               Top             =   210
               Width           =   8490
            End
            Begin VB.CommandButton Cmd_Aceptar 
               Caption         =   "Aceptar"
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   255
               Left            =   8640
               TabIndex        =   32
               Top             =   180
               Width           =   1065
            End
            Begin VB.CommandButton Cmd_Deshacer 
               Caption         =   "Deshacer"
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   270
               Left            =   8640
               TabIndex        =   34
               Top             =   750
               Width           =   1065
            End
            Begin VB.CommandButton Cmd_Cancelar 
               Caption         =   "Cancelar"
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   270
               Left            =   8640
               TabIndex        =   33
               Top             =   450
               Width           =   1065
            End
            Begin VB.Frame Frm_ParFormula 
               Height          =   825
               Left            =   75
               TabIndex        =   65
               Top             =   540
               Width           =   4125
               Begin VB.TextBox Txt_Param2 
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
                  Left            =   2085
                  TabIndex        =   29
                  Top             =   450
                  Width           =   1965
               End
               Begin VB.TextBox Txt_Param1 
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
                  Left            =   2100
                  TabIndex        =   27
                  Top             =   135
                  Width           =   1965
               End
               Begin VB.Label For_Lbl_Par2 
                  Caption         =   "Parámetro Fórmula 2"
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
                  Left            =   75
                  TabIndex        =   67
                  Top             =   495
                  Width           =   1965
               End
               Begin VB.Label For_Lbl_Par1 
                  Caption         =   "Parámetro Fórmula 1"
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
                  Left            =   75
                  TabIndex        =   66
                  Top             =   150
                  Width           =   1965
               End
            End
            Begin VB.Frame Frm_Cupones 
               Height          =   825
               Left            =   4440
               TabIndex        =   62
               Top             =   540
               Width           =   4125
               Begin VB.TextBox Txt_Param3 
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
                  Left            =   2070
                  TabIndex        =   30
                  Top             =   150
                  Width           =   1965
               End
               Begin VB.TextBox Txt_Param4 
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
                  Left            =   2070
                  TabIndex        =   31
                  Top             =   465
                  Width           =   1965
               End
               Begin VB.Label For_Lbl_Par3 
                  Caption         =   "Desde Cupón"
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
                  Left            =   90
                  TabIndex        =   64
                  Top             =   180
                  Width           =   1965
               End
               Begin VB.Label For_Lbl_Par4 
                  Caption         =   "Hasta Cupón"
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
                  Left            =   90
                  TabIndex        =   63
                  Top             =   525
                  Width           =   1965
               End
            End
            Begin VB.CommandButton Cmd_Limpiar 
               Caption         =   "Limpiar"
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   270
               Left            =   8640
               TabIndex        =   35
               Top             =   1020
               Width           =   1065
            End
         End
         Begin Threed.SSFrame Fr_Variables 
            Height          =   1605
            Left            =   30
            TabIndex        =   57
            Top             =   2520
            Width           =   9825
            _Version        =   65536
            _ExtentX        =   17330
            _ExtentY        =   2831
            _StockProps     =   14
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Begin VB.Frame Frm_Funciones 
               Caption         =   "Funciones"
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
               Height          =   1380
               Left            =   6510
               TabIndex        =   60
               Top             =   150
               Width           =   3300
               Begin VB.ListBox Lst_Funciones 
                  Enabled         =   0   'False
                  BeginProperty Font 
                     Name            =   "Arial"
                     Size            =   8.25
                     Charset         =   0
                     Weight          =   700
                     Underline       =   0   'False
                     Italic          =   0   'False
                     Strikethrough   =   0   'False
                  EndProperty
                  Height          =   1110
                  Left            =   90
                  TabIndex        =   26
                  Top             =   195
                  Width           =   3105
               End
            End
            Begin VB.Frame Frm_Variables 
               Caption         =   "Variables"
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
               Height          =   1380
               Left            =   60
               TabIndex        =   59
               Top             =   150
               Width           =   3495
               Begin VB.ListBox Lst_Variables 
                  BeginProperty Font 
                     Name            =   "Arial"
                     Size            =   8.25
                     Charset         =   0
                     Weight          =   700
                     Underline       =   0   'False
                     Italic          =   0   'False
                     Strikethrough   =   0   'False
                  EndProperty
                  Height          =   1110
                  Left            =   105
                  TabIndex        =   24
                  Top             =   195
                  Width           =   3285
               End
            End
            Begin VB.Frame Frm_Operaciones 
               Caption         =   "Operadores"
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
               Height          =   1380
               Left            =   3570
               TabIndex        =   58
               Top             =   150
               Width           =   2910
               Begin VB.ListBox Lst_Operadores 
                  BeginProperty Font 
                     Name            =   "Arial"
                     Size            =   8.25
                     Charset         =   0
                     Weight          =   700
                     Underline       =   0   'False
                     Italic          =   0   'False
                     Strikethrough   =   0   'False
                  EndProperty
                  Height          =   1110
                  Left            =   90
                  TabIndex        =   25
                  Top             =   195
                  Width           =   2715
               End
            End
         End
         Begin Threed.SSFrame Fr_Grilla 
            Height          =   2385
            Left            =   30
            TabIndex        =   56
            Top             =   120
            Width           =   9825
            _Version        =   65536
            _ExtentX        =   17330
            _ExtentY        =   4207
            _StockProps     =   14
            Caption         =   "Formula Creada"
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Begin VB.CommandButton Cmd_Editar 
               Caption         =   "Editar Fórmula"
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   300
               Left            =   7830
               TabIndex        =   23
               Top             =   2010
               Width           =   1530
            End
            Begin VB.CommandButton Cmd_Agrega 
               Caption         =   "Agregar Línea"
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   300
               Left            =   6150
               TabIndex        =   22
               Top             =   2010
               Width           =   1530
            End
            Begin VB.CommandButton Cmd_Remover 
               Caption         =   " Remover Línea"
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   300
               Left            =   270
               TabIndex        =   21
               Top             =   2010
               Width           =   1530
            End
            Begin MSFlexGridLib.MSFlexGrid Grd_Formula 
               Height          =   1725
               Left            =   30
               TabIndex        =   20
               Top             =   240
               Width           =   9765
               _ExtentX        =   17224
               _ExtentY        =   3043
               _Version        =   393216
               Rows            =   1
               Cols            =   9
               BackColor       =   -2147483644
               ForeColor       =   16711680
               BackColorFixed  =   8421376
               ForeColorFixed  =   16777215
               BackColorSel    =   16711680
               BackColorBkg    =   -2147483636
               GridColor       =   64
               HighLight       =   2
               GridLines       =   2
               GridLinesFixed  =   0
               BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
            End
         End
      End
      Begin Threed.SSFrame Fr_Copias 
         Height          =   1890
         Left            =   -74850
         TabIndex        =   75
         Top             =   465
         Width           =   9705
         _Version        =   65536
         _ExtentX        =   17119
         _ExtentY        =   3334
         _StockProps     =   14
         Caption         =   "Formula a Copiar "
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Begin Threed.SSCommand CMD_Copiar 
            Height          =   375
            Left            =   7335
            TabIndex        =   80
            Top             =   1305
            Width           =   1830
            _Version        =   65536
            _ExtentX        =   3228
            _ExtentY        =   661
            _StockProps     =   78
            Caption         =   "Generar Copia"
         End
         Begin Threed.SSFrame Fr_Origen 
            Height          =   855
            Left            =   630
            TabIndex        =   76
            Top             =   240
            Width           =   3855
            _Version        =   65536
            _ExtentX        =   6800
            _ExtentY        =   1508
            _StockProps     =   14
            Caption         =   "Origen"
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Begin VB.TextBox Txt_Origen 
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   375
               Left            =   390
               MaxLength       =   12
               TabIndex        =   77
               Top             =   300
               Width           =   3165
            End
         End
         Begin Threed.SSFrame Fr_Destino 
            Height          =   855
            Left            =   5340
            TabIndex        =   78
            Top             =   240
            Width           =   3855
            _Version        =   65536
            _ExtentX        =   6800
            _ExtentY        =   1508
            _StockProps     =   14
            Caption         =   "Destino"
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Begin VB.TextBox Txt_Destino 
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   375
               Left            =   360
               MaxLength       =   12
               TabIndex        =   79
               Top             =   270
               Width           =   3165
            End
         End
      End
   End
   Begin MSComctlLib.Toolbar Tlb_Formulas 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   36
      Top             =   0
      Width           =   10080
      _ExtentX        =   17780
      _ExtentY        =   794
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Style           =   1
      ImageList       =   "Img_opciones"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   6
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Limpiar"
            Description     =   "Limpiar"
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Key             =   "Grabar"
            Description     =   "Grabar"
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Key             =   "Buscar"
            Description     =   "Buscar"
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Key             =   "Copiar"
            Description     =   "Copiar"
            Object.ToolTipText     =   "Copiar Formula"
            ImageIndex      =   12
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Valorizar"
            Description     =   "Valorizar"
            Object.ToolTipText     =   "Valorizar"
            ImageIndex      =   24
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Description     =   "Salir"
            Object.ToolTipText     =   "Salir De La Ventana"
            ImageIndex      =   2
         EndProperty
      EndProperty
      Begin MSComctlLib.ImageList Img_opciones 
         Left            =   4560
         Top             =   0
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   24
         ImageHeight     =   24
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   25
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_FORMULAS.frx":2F16
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_FORMULAS.frx":337D
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_FORMULAS.frx":3873
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_FORMULAS.frx":3D06
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_FORMULAS.frx":41EE
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_FORMULAS.frx":4701
               Key             =   ""
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_FORMULAS.frx":4C3E
               Key             =   ""
            EndProperty
            BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_FORMULAS.frx":5080
               Key             =   ""
            EndProperty
            BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_FORMULAS.frx":553A
               Key             =   ""
            EndProperty
            BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_FORMULAS.frx":5A0D
               Key             =   ""
            EndProperty
            BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_FORMULAS.frx":5E51
               Key             =   ""
            EndProperty
            BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_FORMULAS.frx":63B8
               Key             =   ""
            EndProperty
            BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_FORMULAS.frx":6887
               Key             =   ""
            EndProperty
            BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_FORMULAS.frx":6CA6
               Key             =   ""
            EndProperty
            BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_FORMULAS.frx":719E
               Key             =   ""
            EndProperty
            BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_FORMULAS.frx":7597
               Key             =   ""
            EndProperty
            BeginProperty ListImage17 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_FORMULAS.frx":7A1A
               Key             =   ""
            EndProperty
            BeginProperty ListImage18 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_FORMULAS.frx":7EE0
               Key             =   ""
            EndProperty
            BeginProperty ListImage19 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_FORMULAS.frx":83D7
               Key             =   ""
            EndProperty
            BeginProperty ListImage20 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_FORMULAS.frx":888D
               Key             =   ""
            EndProperty
            BeginProperty ListImage21 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_FORMULAS.frx":8C52
               Key             =   ""
            EndProperty
            BeginProperty ListImage22 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_FORMULAS.frx":9048
               Key             =   ""
            EndProperty
            BeginProperty ListImage23 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_FORMULAS.frx":943F
               Key             =   ""
            EndProperty
            BeginProperty ListImage24 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_FORMULAS.frx":9848
               Key             =   ""
            EndProperty
            BeginProperty ListImage25 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_FORMULAS.frx":9D06
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
End
Attribute VB_Name = "FRM_FORMULAS"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim cOptLocal                    As String
Dim cHay_Datos                   As String
Dim nCodigo_Instrumento          As Integer
Dim nCodigo_Serie_O              As String
Dim nCodigo_Serie_D              As String
Dim cGlosa_Instrumento           As String
Public cFormula                  As String
Dim nRut_Emisor                  As Double
Dim nModo_Calculo                As Integer
Dim nOpcion_Formula              As Integer
Dim Arreglo_Variables(100, 6)
Dim Arreglo_Operadores(100, 6)
Dim Arreglo_Funciones(100, 6)
Dim Arreglo_Formulas(100, 10)
Dim nLinea_Formula               As Integer
Dim nPos_Formula                 As Integer
Dim nPos_Texto                   As Integer
Dim nFila_Seleccionada           As Integer
Dim nMoneda_Emision              As Double

' Variables de Valorizacion

Dim TR      As Double
Dim TE      As Double
Dim TV      As Double
Dim TT      As Double
Dim BA      As Double
Dim BF      As Double
Dim Nom     As Double
Dim MT      As Double
Dim VV      As Double
Dim VP      As Double
Dim PVP     As Double
Dim VAN     As Double
Dim FP      As Date
Dim FE      As Date
Dim FV      As Date
Dim FU      As Date
Dim FX      As Date
Dim FC      As Date
Dim CI      As Double
Dim CT      As Double
Dim INDEV   As Double
Dim PRINC   As Double
Dim INCTR   As Double
Dim FIP     As Date
Dim CAP     As Double


Private Function FUNC_BUSCAR_SERIE_DESTINO()
Dim cNomProc As String
Dim cCodigo_Instrumento As String
Dim Datos()

        GLB_Envia = Array()
         
        cCodigo_Instrumento = Txt_Destino.Text
                
        cNomProc = "SP_CON_GLOSA_INSTRUMENTO"
        PROC_AGREGA_PARAMETRO GLB_Envia, cCodigo_Instrumento
                
        If Not FUNC_EXECUTA_COMANDO_SQL(cNomProc, GLB_Envia) Then
            MsgBox "Error al buscar Instrumento", vbInformation
            Exit Function
        End If

        If FUNC_LEE_RETORNO_SQL(Datos()) Then
            If Datos(1) <> 0 Then
                GLB_codigo$ = Datos(1)       'codigo_instrumento
                nCodigo_Serie_D = Datos(1)
            Else
                MsgBox "Instrumento no encontrado", vbInformation
                Txt_Destino.Text = ""
                Txt_Destino.SetFocus
            End If
        Else
            MsgBox "Instrumento no encontrado", vbInformation
            Txt_Destino.Text = ""
            Txt_Destino.SetFocus
        End If

End Function
Private Sub Cmd_Aceptar_Click()

    Dim vDatos_Retorno()
    
    If Txt_Param1.Enabled = True And Trim(Txt_Param1.Text) = "" Then
    
        MsgBox "Falta Ingresar Parametro 1 en Funcion", vbCritical
        Txt_Param1.SetFocus
        Exit Sub
        
    End If
    
    If Txt_Param2.Enabled = True And Trim(Txt_Param2.Text) = "" Then
    
        MsgBox "Falta Ingresar Parametro 2 en Funcion", vbCritical
        Txt_Param2.SetFocus
        Exit Sub
        
    End If
    
    If Txt_Param3.Enabled = True And Trim(Txt_Param3.Text) = "" Then
    
        MsgBox "Falta Ingresar Perido Inicio Tabla de Desarrollo", vbCritical
        Txt_Param3.SetFocus
        Exit Sub
        
    End If

    If Txt_Param4.Enabled = True And Trim(Txt_Param4.Text) = "" Then
    
        MsgBox "Falta Ingresar Perido Final Tabla de Desarrollo", vbCritical
        Txt_Param4.SetFocus
        Exit Sub
        
    End If


    
'    GLB_Envia = Array()
'    PROC_AGREGA_PARAMETRO GLB_Envia, Grd_Formula.TextMatrix(Grd_Formula.Row, 2)
'    PROC_AGREGA_PARAMETRO GLB_Envia, Grd_Formula.TextMatrix(Grd_Formula.Row, 0)
'    PROC_AGREGA_PARAMETRO GLB_Envia, Text_Formula.Text
'    PROC_AGREGA_PARAMETRO GLB_Envia, Txt_Param1.Text
'    PROC_AGREGA_PARAMETRO GLB_Envia, Txt_Param2.Text
'    PROC_AGREGA_PARAMETRO GLB_Envia, Txt_Param3.Text
'    PROC_AGREGA_PARAMETRO GLB_Envia, Txt_Param4.Text


'    If FUNC_EXECUTA_COMANDO_SQL("SP_PRO_VERIFICA_FOMULA", GLB_Envia) Then
    
     
        Arreglo_Formulas(Grd_Formula.TextMatrix(Grd_Formula.Row, 4), 5) = Text_Formula.Text
        Arreglo_Formulas(Grd_Formula.TextMatrix(Grd_Formula.Row, 4), 7) = Txt_Param1.Text
        Arreglo_Formulas(Grd_Formula.TextMatrix(Grd_Formula.Row, 4), 8) = Txt_Param2.Text
        Arreglo_Formulas(Grd_Formula.TextMatrix(Grd_Formula.Row, 4), 9) = Txt_Param3.Text
        Arreglo_Formulas(Grd_Formula.TextMatrix(Grd_Formula.Row, 4), 10) = Txt_Param4.Text
        
        Grd_Formula.TextMatrix(Grd_Formula.Row, 3) = Trim(Text_Formula.Text)
        
        If Trim(Txt_Param1.Text) = "" Then
            
            Grd_Formula.TextMatrix(Grd_Formula.Row, 5) = " "
        
        Else
            
            Grd_Formula.TextMatrix(Grd_Formula.Row, 5) = Trim(Txt_Param1.Text)
        
        End If
        
        If Trim(Txt_Param2.Text) = "" Then
            
            Grd_Formula.TextMatrix(Grd_Formula.Row, 6) = " "
        
        Else
            
            Grd_Formula.TextMatrix(Grd_Formula.Row, 6) = Trim(Txt_Param2.Text)
        
        End If
        
        
        If Trim(Txt_Param3.Text) = "" Then
            
            Grd_Formula.TextMatrix(Grd_Formula.Row, 7) = " "
        
        Else
            
            Grd_Formula.TextMatrix(Grd_Formula.Row, 7) = Trim(Txt_Param3.Text)
        
        End If

        If Trim(Txt_Param4.Text) = "" Then
            
            Grd_Formula.TextMatrix(Grd_Formula.Row, 8) = " "
        
        Else
            
            Grd_Formula.TextMatrix(Grd_Formula.Row, 8) = Trim(Txt_Param4.Text)
        
        End If

        
        Frm_Funciones.Enabled = False
        Fr_Crea_Formula.Enabled = False
        Frm_Variables.Enabled = False
        Frm_Operaciones.Enabled = False
        Frm_Funciones.Enabled = False
        Frm_Variables.Enabled = False
        Frm_Operaciones.Enabled = False
        Cmd_Aceptar.Enabled = False
        Cmd_Cancelar.Enabled = False
        Cmd_Deshacer.Enabled = False
        Cmd_Limpiar.Enabled = False
        Cmd_Editar.Enabled = True
        Cmd_Remover.Enabled = True
        Cmd_Agrega.Enabled = True
        Text_Formula.Enabled = False
        Text_Formula.Text = ""
        Txt_Param1.Text = ""
        Txt_Param2.Text = ""
        Txt_Param3.Text = ""
        Txt_Param4.Text = ""
        Txt_Param1.Enabled = False
        Txt_Param2.Enabled = False
        Txt_Param3.Enabled = False
        Txt_Param4.Enabled = False
        Grd_Formula.Enabled = True
      
        Frm_ParFormula.Visible = False
        Frm_Cupones.Visible = False
    
'    Else
'
'        MsgBox "Error de Sintaxis en la formula", vbExclamation
'
'        If Text_Formula.Enabled = True Then
'
'            Text_Formula.SetFocus
'
'        Else
'
'            If Txt_Param1.Enabled = True Then
'
'                Txt_Param1.SetFocus
'
'            End If
'
'        End If

'    End If

End Sub

Private Sub Cmd_Agrega_Click()

    Dim nContador As Integer
    
    nLinea_Formula = nLinea_Formula + 1
    Arreglo_Formulas(nLinea_Formula, 1) = nLinea_Formula
    
    Grd_Formula.Rows = Grd_Formula.Rows + 1
    
    For nContador = 2 To Grd_Formula.Rows
        Grd_Formula.TextMatrix(nContador - 1, 1) = nContador - 1
        If nContador < Grd_Formula.Rows Then
            Arreglo_Formulas(Grd_Formula.TextMatrix(nContador - 1, 4), 3) = nContador - 1
        End If
    Next

    Arreglo_Formulas(nLinea_Formula, 2) = nOpcion_Formula
    Arreglo_Formulas(nLinea_Formula, 3) = Grd_Formula.TextMatrix(Grd_Formula.Rows - 1, 1)

    Grd_Formula.TextMatrix(Grd_Formula.Rows - 1, 4) = nLinea_Formula

End Sub

Private Sub Cmd_Cancelar_Click()

    Frm_Variables.Enabled = False
    Frm_Operaciones.Enabled = False
    Frm_Funciones.Enabled = False
    
    Cmd_Aceptar.Enabled = False
    Cmd_Cancelar.Enabled = False
    Cmd_Deshacer.Enabled = False
    Cmd_Limpiar.Enabled = False
    Cmd_Editar.Enabled = True
    Cmd_Remover.Enabled = True
    Cmd_Agrega.Enabled = True
    Text_Formula.Enabled = False
    Text_Formula.Text = ""
    Txt_Param1.Text = ""
    Txt_Param2.Text = ""
    Txt_Param1.Enabled = False
    Txt_Param2.Enabled = False
    Txt_Param3.Text = ""
    Txt_Param4.Text = ""
    Txt_Param3.Enabled = False
    Txt_Param4.Enabled = False
    Grd_Formula.Enabled = True
    Fr_Crea_Formula.Enabled = False
    
    Frm_ParFormula.Visible = False
    Frm_Cupones.Visible = False

End Sub

Private Sub CMD_Copiar_Click()

    PROC_VALIDA_COPIA
               
End Sub

Private Sub Cmd_Deshacer_Click()

    Dim nLargo_Formula As Integer
    Dim nLargo_Text_Formula As Integer
    Dim nLargo_Total
    
    nLargo_Formula = Len(cFormula) + 1
    nLargo_Text_Formula = Len(Text_Formula.Text)
    nLargo_Total = nLargo_Text_Formula - nLargo_Formula
    
    If nLargo_Total < 1 Then
        
        nLargo_Total = 0
    
    End If
    
    If Text_Formula.Text <> "" Then
        
        Text_Formula.Text = Mid(Text_Formula.Text, 1, nLargo_Total)
        cFormula = ""
    
    End If
    
    Text_Formula.Enabled = True
    
    
    Txt_Param1.Text = ""
    Txt_Param2.Text = ""
    Txt_Param1.Enabled = False
    Txt_Param2.Enabled = False
    Txt_Param3.Text = ""
    Txt_Param4.Text = ""
    Txt_Param3.Enabled = False
    Txt_Param4.Enabled = False
    Frm_ParFormula.Visible = False
    Frm_Cupones.Visible = False

End Sub

Private Sub Cmd_Editar_Click()

    Dim I As Integer

    If Grd_Formula.Rows < 2 Then Exit Sub
    
    If Grd_Formula.TextMatrix(Grd_Formula.Row, 0) = "F" Then
        MsgBox "No puede editar una función", vbCritical
    Else
    
        Frm_Variables.Enabled = True
        Frm_Operaciones.Enabled = True
        Lst_Funciones.Enabled = True
        Fr_Crea_Formula.Enabled = True
        
        If Grd_Formula.RowSel = 0 Then
            MsgBox "No ha Seleccionado Linea", vbExclamation
            Exit Sub
        End If
        
        If Grd_Formula.TextMatrix(Grd_Formula.Row, 0) = "F" Then
            MsgBox "Formula Corresponde a Función NO puede Modificar", vbExclamation
            Exit Sub
        End If
        
        If Grd_Formula.TextMatrix(Grd_Formula.Row, 2) = "" Then
            MsgBox "No Ha Ingresado Nombre de Campo", vbExclamation
            Exit Sub
        End If
    
    
        Text_Formula.Enabled = True
    
        Text_Formula.Text = Grd_Formula.TextMatrix(Grd_Formula.Row, 3)
        Txt_Param1.Text = Grd_Formula.TextMatrix(Grd_Formula.Row, 5)
        Txt_Param2.Text = Grd_Formula.TextMatrix(Grd_Formula.Row, 6)
        Txt_Param3.Text = Grd_Formula.TextMatrix(Grd_Formula.Row, 7)
        Txt_Param4.Text = Grd_Formula.TextMatrix(Grd_Formula.Row, 8)
    
        If Trim(Txt_Param1.Text) <> "" Or Trim(Txt_Param2.Text) <> "" Then
            Frm_ParFormula.Visible = True
        Else
            Frm_ParFormula.Visible = False
        End If
        
        
        If Trim(Txt_Param1.Text) <> "" Then
              Txt_Param1.Enabled = True
        Else
              Txt_Param1.Enabled = False
        End If
        
        
        If Trim(Txt_Param2.Text) <> "" Then
            Txt_Param2.Enabled = True
        Else
            Txt_Param2.Enabled = False
        End If
        
        
        If Grd_Formula.TextMatrix(Grd_Formula.Row, 0) = "D" Then
            Frm_Cupones.Visible = True
            Txt_Param3.Enabled = True
            Txt_Param4.Enabled = True
        Else
            Frm_Cupones.Visible = False
            Txt_Param3.Enabled = False
            Txt_Param4.Enabled = False
        End If
    
        
        Frm_Variables.Enabled = True
        Frm_Operaciones.Enabled = True
        Frm_Funciones.Enabled = True
        
        
        Cmd_Aceptar.Enabled = True
        Cmd_Cancelar.Enabled = True
        Cmd_Deshacer.Enabled = True
        Cmd_Limpiar.Enabled = True
        Cmd_Editar.Enabled = False
        Cmd_Remover.Enabled = False
        Cmd_Agrega.Enabled = False
        nPos_Texto = 0
        
        Text_Formula.SetFocus
        
        For I = 1 To Lst_Funciones.ListCount
            If Trim(Text_Formula.Text) = Arreglo_Funciones(I - 1, 3) Then
                Text_Formula.Enabled = False
            End If
        
        Next
        
        Grd_Formula.Enabled = False
        
    End If

End Sub

Private Sub Cmd_Limpiar_Click()

    Text_Formula.Text = ""
    Text_Formula.Enabled = True
    Txt_Param1.Text = ""
    Txt_Param2.Text = ""
    Txt_Param1.Enabled = False
    Txt_Param2.Enabled = False
    Txt_Param3.Text = ""
    Txt_Param4.Text = ""
    Txt_Param3.Enabled = False
    Txt_Param4.Enabled = False
    Frm_ParFormula.Visible = False
    Frm_Cupones.Visible = False
    
    Text_Formula.SetFocus

End Sub

Private Sub Cmd_Remover_Click()
    
    Dim nContador As Integer
    
    
    If MsgBox("Esta Seguro de Remover Linea", vbQuestion + vbYesNo) <> vbYes Then
        Exit Sub
    End If
    

    If Grd_Formula.RowSel > 0 Then
        Arreglo_Formulas(Grd_Formula.TextMatrix(Grd_Formula.Row, 4), 2) = ""
        Arreglo_Formulas(Grd_Formula.TextMatrix(Grd_Formula.Row, 4), 3) = ""
        Arreglo_Formulas(Grd_Formula.TextMatrix(Grd_Formula.Row, 4), 4) = ""
        Arreglo_Formulas(Grd_Formula.TextMatrix(Grd_Formula.Row, 4), 5) = ""
        Arreglo_Formulas(Grd_Formula.TextMatrix(Grd_Formula.Row, 4), 6) = ""
        Arreglo_Formulas(Grd_Formula.TextMatrix(Grd_Formula.Row, 4), 7) = ""
        Arreglo_Formulas(Grd_Formula.TextMatrix(Grd_Formula.Row, 4), 8) = ""
    
        If Grd_Formula.Rows > 2 Then
            Grd_Formula.RemoveItem Grd_Formula.Row
        Else
            Grd_Formula.Rows = 1
        End If
        
    Else
        MsgBox "No ha Seleccionado Linea", vbExclamation
    End If

    For nContador = 2 To Grd_Formula.Rows
        Grd_Formula.TextMatrix(nContador - 1, 1) = nContador - 1
        
        If nContador < Grd_Formula.Rows Then
            Arreglo_Formulas(Grd_Formula.TextMatrix(nContador - 1, 4), 3) = nContador - 1
        End If
    Next

    Arreglo_Formulas(nLinea_Formula, 3) = Grd_Formula.TextMatrix(Grd_Formula.Rows - 1, 1)

End Sub

Private Sub Form_Activate()
   
   PROC_CARGA_AYUDA Me

End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)

Dim nOpcion As Integer

    If KeyCode <> vbKeyControl And (Shift = 2 Or (Shift = 0 And (KeyCode = vbKeyReturn Or KeyCode = vbKeyEscape Or (KeyCode >= vbKeyF1 And KeyCode <= vbKeyF12)))) Then

        Select Case KeyCode
            
            Case vbKeyLimpiar 'Nuevo
                
                nOpcion = 1
            
            Case vbKeyGrabar 'Grabar
                
                nOpcion = 2
            
            Case vbKeyBuscar 'buscar
                
                nOpcion = 3
            
            Case VbkeyAceptar 'Copiar
                
                nOpcion = 4
            
            Case vbKeyValorizar 'Valorizar
                
                nOpcion = 5
            
            Case vbKeySalir 'Salir
                
                nOpcion = 6
        
      End Select
        
        If nOpcion > 0 Then
            
            If Tlb_Formulas.Buttons(nOpcion).Enabled Then
                
                Tlb_Formulas_ButtonClick Tlb_Formulas.Buttons(nOpcion)
            
            End If
        
        End If
    
    End If

End Sub

Private Sub Form_Load()

   Me.Icon = FRM_MDI_PASIVO.Icon

   cOptLocal = GLB_Opcion_Menu

   Call PROC_LOG_AUDITORIA("07", cOptLocal, Me.Caption, "", "")

    On Error GoTo BacErrorHandler

   Me.top = 0
   Me.left = 0
   
   Call FUNC_FORMATO_GRILLA(Grd_Formula)
   
   PROC_LIMPIAR_PANTALLA
   
   Tab_Formula.TabEnabled(1) = False
   Tab_Formula.TabEnabled(2) = False
   Tab_Formula.Tab = 0
   nModo_Calculo = 1
   nOpcion_Formula = 1
   Tab_Instrumentos.Enabled = True
   Tab_Opciones.Enabled = False
   Tab_Formulas.Enabled = False
   Tab_Formula.TabEnabled(0) = True
   Tab_Formula.TabEnabled(1) = False
   Tab_Formula.TabEnabled(2) = False
   Tab_Formula.TabEnabled(3) = False
   
   Tlb_Formulas.Buttons(4).Enabled = True
   Tlb_Formulas.Buttons(5).Enabled = False

BacErrorHandler:
   
End Sub

Private Sub Form_Unload(Cancel As Integer)

   Call PROC_LOG_AUDITORIA("08", cOptLocal, Me.Caption, "", "")

End Sub

Private Sub Grd_Formula_Click()

    Dim nColumna As Integer
    
    nColumna = Grd_Formula.Col

    Call PROC_MARCAR

    Grd_Formula.Col = nColumna

End Sub

Private Sub Grd_Formula_DblClick()

    If Grd_Formula.Col = 2 Then
    
        GLB_Instrumento = ""
        Frm_Variables.Enabled = False
        Frm_Operaciones.Enabled = False
        Load FRM_AYUDA_VARIABLES
        FRM_AYUDA_VARIABLES.Show vbModal
       
        If GLB_Instrumento <> "" Then
        
            Arreglo_Formulas(Grd_Formula.TextMatrix(Grd_Formula.Row, 4), 6) = Grd_Formula.TextMatrix(Grd_Formula.Row, 0)
            Arreglo_Formulas(Grd_Formula.TextMatrix(Grd_Formula.Row, 4), 4) = Grd_Formula.TextMatrix(Grd_Formula.Row, 2)
            
        End If
        
    End If

End Sub

Private Sub Grd_Formula_KeyDown(KeyCode As Integer, Shift As Integer)

    If KeyCode = vbKeyDelete Then
            
        Grd_Formula.TextMatrix(Grd_Formula.Row, 0) = ""
        Grd_Formula.TextMatrix(Grd_Formula.Row, 2) = ""
        Grd_Formula.TextMatrix(Grd_Formula.Row, 3) = ""
        
        Arreglo_Formulas(Grd_Formula.TextMatrix(Grd_Formula.Row, 4), 4) = ""
        Arreglo_Formulas(Grd_Formula.TextMatrix(Grd_Formula.Row, 4), 5) = ""
        Arreglo_Formulas(Grd_Formula.TextMatrix(Grd_Formula.Row, 4), 6) = ""
        Arreglo_Formulas(Grd_Formula.TextMatrix(Grd_Formula.Row, 4), 7) = ""
        Arreglo_Formulas(Grd_Formula.TextMatrix(Grd_Formula.Row, 4), 8) = ""
    
    End If

End Sub

Private Sub Lst_Funciones_DblClick()

    If nPos_Texto = 0 Then
        nPos_Texto = Len(Text_Formula.Text)
    End If


    Text_Formula.Text = Arreglo_Funciones(Lst_Funciones.ListIndex, 3)
    cFormula = Arreglo_Funciones(Lst_Funciones.ListIndex, 3)
    
    If Trim(Arreglo_Funciones(Lst_Funciones.ListIndex, 5)) <> "" Or Trim(Arreglo_Funciones(Lst_Funciones.ListIndex, 6)) <> "" Then
        Frm_ParFormula.Visible = True
    Else
        Frm_ParFormula.Visible = False
    End If
   
    
    If Trim(Arreglo_Funciones(Lst_Funciones.ListIndex, 5)) <> "" Then
        Txt_Param1.Enabled = True
        Txt_Param1.SetFocus
    Else
        
        Txt_Param1.Enabled = False
        Txt_Param1.Text = ""
    End If
    
    If Trim(Arreglo_Funciones(Lst_Funciones.ListIndex, 6)) <> "" Then
        Txt_Param2.Enabled = True
    Else
        Txt_Param2.Enabled = False
        Txt_Param2.Text = ""
    End If
    
   
    Text_Formula.Enabled = False

End Sub

Private Sub Lst_Operadores_DblClick()
    
    If nPos_Formula = 1 Then
    
        If nPos_Texto = 0 Then
            
            nPos_Texto = Len(Text_Formula.Text)
        
        End If
    
        If Text_Formula.Text = "" Then
            
            Text_Formula.Text = Arreglo_Operadores(Lst_Operadores.ListIndex, 3)
            cFormula = Arreglo_Operadores(Lst_Operadores.ListIndex, 3)
        
        Else
        
            Text_Formula.Text = Mid$(Text_Formula.Text, 1, nPos_Texto) & " " & Trim(Arreglo_Operadores(Lst_Operadores.ListIndex, 3)) & " " & Mid$(Text_Formula.Text, nPos_Texto + 1, Len(Text_Formula.Text))
            cFormula = Arreglo_Operadores(Lst_Operadores.ListIndex, 3)
        
        End If
        
        If Text_Formula.Enabled = True Then
            
            Text_Formula.SetFocus
        
        End If
    
    ElseIf nPos_Formula = 4 And Txt_Param3.Enabled = True Then
        
        If nPos_Texto = 0 Then
            nPos_Texto = Len(Txt_Param3.Text)
        End If
    
        If Txt_Param3.Text = "" Then
            Txt_Param3.Text = Arreglo_Operadores(Lst_Operadores.ListIndex, 3)
        Else
            Txt_Param3.Text = Mid$(Txt_Param3.Text, 1, nPos_Texto) & " " & Trim(Arreglo_Operadores(Lst_Operadores.ListIndex, 3)) & " " & Mid$(Txt_Param3.Text, nPos_Texto + 1, Len(Txt_Param3.Text))
        End If

        Txt_Param3.SetFocus
        
    ElseIf nPos_Formula = 5 And Txt_Param4.Enabled = True Then
        
        If nPos_Texto = 0 Then
            nPos_Texto = Len(Txt_Param4.Text)
        End If
    
        If Txt_Param4.Text = "" Then
            Txt_Param4.Text = Arreglo_Operadores(Lst_Operadores.ListIndex, 3)
        Else
            Txt_Param4.Text = Mid$(Txt_Param4.Text, 1, nPos_Texto) & " " & Trim(Arreglo_Operadores(Lst_Operadores.ListIndex, 3)) & " " & Mid$(Txt_Param4.Text, nPos_Texto + 1, Len(Txt_Param4.Text))
        End If
        
        Txt_Param4.SetFocus
       
    End If

End Sub

Private Sub Lst_Variables_DblClick()

    If nPos_Formula = 1 Then
        
        If nPos_Texto = 0 Then
            nPos_Texto = Len(Text_Formula.Text)
        End If
    
        If Text_Formula.Text = "" Then
            Text_Formula.Text = Arreglo_Variables(Lst_Variables.ListIndex, 3)
            cFormula = Arreglo_Variables(Lst_Variables.ListIndex, 3)
        Else
            Text_Formula.Text = Mid$(Text_Formula.Text, 1, nPos_Texto) & " " & Trim(Arreglo_Variables(Lst_Variables.ListIndex, 3)) & " " & Mid$(Text_Formula.Text, nPos_Texto + 1, Len(Text_Formula.Text))
            cFormula = Arreglo_Variables(Lst_Variables.ListIndex, 3)
        End If
        If Text_Formula.Enabled = True Then
            Text_Formula.SetFocus
        End If
        
    ElseIf nPos_Formula = 2 And Txt_Param1.Enabled = True Then
        
        Txt_Param1.Text = Arreglo_Variables(Lst_Variables.ListIndex, 3)
        
        Txt_Param1.SetFocus
        
    ElseIf nPos_Formula = 3 And Txt_Param2.Enabled = True Then
        
        Txt_Param2.Text = Arreglo_Variables(Lst_Variables.ListIndex, 3)
       
        Txt_Param2.SetFocus
       
    ElseIf nPos_Formula = 4 And Txt_Param3.Enabled = True Then
        
        If nPos_Texto = 0 Then
            nPos_Texto = Len(Txt_Param3.Text)
        End If
    
        If Txt_Param3.Text = "" Then
            Txt_Param3.Text = Arreglo_Variables(Lst_Variables.ListIndex, 3)
        Else
            Txt_Param3.Text = Mid$(Txt_Param3.Text, 1, nPos_Texto) & " " & Trim(Arreglo_Variables(Lst_Variables.ListIndex, 3)) & " " & Mid$(Txt_Param3.Text, nPos_Texto + 1, Len(Txt_Param3.Text))
        End If
        
        Txt_Param3.SetFocus
       
    ElseIf nPos_Formula = 5 And Txt_Param4.Enabled = True Then
        
        If nPos_Texto = 0 Then
            nPos_Texto = Len(Txt_Param4.Text)
        End If
    
        If Txt_Param4.Text = "" Then
            Txt_Param4.Text = Arreglo_Variables(Lst_Variables.ListIndex, 3)
        Else
            Txt_Param4.Text = Mid$(Txt_Param4.Text, 1, nPos_Texto) & " " & Trim(Arreglo_Variables(Lst_Variables.ListIndex, 3)) & " " & Mid$(Txt_Param4.Text, nPos_Texto + 1, Len(Txt_Param4.Text))
        End If

        Txt_Param4.SetFocus
       
    End If

End Sub

Private Sub Tab_Formula_Click(PreviousTab As Integer)

   If Tab_Formula.Tab = 0 Then
      
      Tab_Instrumentos.Enabled = True
      Tab_Opciones.Enabled = False
      Tab_Formulas.Enabled = False
      
      If TXT_Instrumento.Text = "" Then
        Tlb_Formulas.Buttons(4).Enabled = True
      Else
        Tlb_Formulas.Buttons(4).Enabled = False
      End If
      
'     Tlb_Formulas.Buttons(5).Enabled = True
      
   ElseIf Tab_Formula.Tab = 1 Then
      
      Tab_Instrumentos.Enabled = False
      Tab_Opciones.Enabled = True
      Tab_Formulas.Enabled = False
'     Tlb_Formulas.Buttons(5).Enabled = False
      
   ElseIf Tab_Formula.Tab = 2 Then
      
      Tab_Instrumentos.Enabled = True
      Tab_Opciones.Enabled = True
      Tab_Formulas.Enabled = True
'     Tlb_Formulas.Buttons(4).Enabled = False
'     Tlb_Formulas.Buttons(5).Enabled = False
      PROC_ENCABEZADOS_GRILLA
      FUN_LLENA_LISTA_VARIABLES
      FUN_LLENA_LISTA_OPERADORES
      FUN_LLENA_LISTA_FUNCIONES
      DoEvents
      FUNC_LLENA_GRILLA_FORMULA
      Call Cmd_Cancelar_Click
   End If

End Sub

Private Sub Tab_Formula_KeyPress(KeyAscii As Integer)
    
    If KeyAscii = 13 Then
    
        FUNC_ENVIA_TECLA vbKeyTab
        
    End If

End Sub

Private Sub Text_Formula_Change()

    If Text_Formula.Text <> "" Then
    
        Cmd_Deshacer.Enabled = True
        
    Else
    
        Cmd_Deshacer.Enabled = False
        
    End If

End Sub

Private Sub Text_Formula_GotFocus()

    nPos_Texto = 0
    Text_Formula.SelStart = Len(Text_Formula.Text)

End Sub

Private Sub Text_Formula_LostFocus()

    nPos_Texto = Text_Formula.SelStart
    nPos_Formula = 1

End Sub

Private Sub tip_opt_tasa_Click()

   nOpcion_Formula = 1

End Sub

Private Sub tip_opt_tir_Click()

   nOpcion_Formula = 3
   
End Sub

Private Sub tip_opt_valor_Click()

   nOpcion_Formula = 2

End Sub

Private Sub Tlb_Formulas_ButtonClick(ByVal Button As MSComctlLib.Button)

      Select Case Button.Index
      
         Case 1
         
               PROC_LIMPIAR_PANTALLA
         
         Case 2
                     
               FUNC_GRABAR_DATOS
                     
         Case 3
            
               PROC_BUSCAR_SERIES
            
         Case 4
         
               PROC_HABILITAR_COPIA

         
         Case 5

               PROC_VALORIZACION (nModo_Calculo)
         
         Case 6
         
               Unload Me
   
      End Select

End Sub

Private Sub Txt_Destino_DblClick()

   Call PROC_CON_SERIES_DESTINO

End Sub

Private Sub Txt_Destino_KeyDown(KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyF3 Then Call PROC_CON_SERIES_DESTINO

End Sub

Private Sub Txt_Destino_KeyPress(KeyAscii As Integer)

   PROC_TO_CASE KeyAscii
    
   If KeyAscii = 13 Then
        Call FUNC_BUSCAR_SERIE_DESTINO
   
      FUNC_ENVIA_TECLA (vbKeyTab)
      
   End If

End Sub
Private Sub Txt_Fecha_Valorizacion_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then
    
        FUNC_ENVIA_TECLA vbKeyTab
        
    End If

End Sub

Private Sub Txt_Instrumento_DblClick()

   Call PROC_CON_INSTRUMENTO

End Sub

Sub PROC_CON_INSTRUMENTO()

On Error GoTo Error_Con_Familia

   cHay_Datos = "N"
   Pbl_cTipo_Instrumento = ""
   cMiTag = "MDIN"
   FRM_AYUDA.Show 1

   If GLB_Aceptar = True Then

      TXT_Instrumento.Enabled = True
      TXT_Instrumento.Text = GLB_nombre
      nCodigo_Instrumento = GLB_codigo
      cGlosa_Instrumento = GLB_nombre
      TXT_Instrumento.SetFocus
      FUNC_ENVIA_TECLA vbKeyReturn
      
      cHay_Datos = "S"

   End If

   Exit Sub

Error_Con_Familia:
    
    MousePointer = 0
    MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical
    
    Exit Sub

End Sub

Private Sub Txt_Instrumento_KeyDown(KeyCode As Integer, Shift As Integer)
   
   If KeyCode = vbKeyF3 Then Call PROC_CON_INSTRUMENTO

End Sub

Private Sub Txt_Instrumento_KeyPress(KeyAscii As Integer)

   PROC_TO_CASE KeyAscii
    
   If KeyAscii = 13 Then
   
     If Trim(TXT_Instrumento.Text) = "BONOS" Or Trim(TXT_Instrumento.Text) = "LETRAS" Then
  
         Fr_Datos_Valorizar.Enabled = True
         Txt_Serie.Enabled = True
         Txt_Serie.SetFocus
      
      Else
         
         Call FUNC_LLENA_ARREGLO_FORMULA
            
         Tab_Formula.TabEnabled(1) = True
         tip_opt_tasa.Value = 1
         Fr_Opciones.Enabled = False
         tip_opt_tasa.Enabled = False
         tip_opt_tir.Enabled = False
         tip_opt_valor.Enabled = False
         
         Tab_Formula.TabEnabled(2) = True

         Fr_Datos_Valorizar.Enabled = False
         
         If Trim(TXT_Instrumento.Text) <> "" Then
         
            Fr_Instrumento.Enabled = False
         
         End If
         
         FUNC_ENVIA_TECLA (vbKeyTab)
      
      End If
      
   End If
    
End Sub

Private Sub Txt_Instrumento_LostFocus()
On Error GoTo Error_Familia

    If Trim(TXT_Instrumento.Text) = "" Then Exit Sub
    
    If Not FUNC_CON_INSTRUMENTO(TXT_Instrumento.Text) Then
        MsgBox "Instrumento no existe", vbOKOnly + vbExclamation
        TXT_Instrumento.Text = ""
        Fr_Instrumento.Enabled = True
        TXT_Instrumento.Enabled = True
        TXT_Instrumento.SetFocus
        Exit Sub
    Else
        Tlb_Formulas.Buttons(4).Enabled = False
    End If
    
Exit Sub

Error_Familia:
    MousePointer = 0
    MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical
    Exit Sub

End Sub
Function FUNC_CON_INSTRUMENTO(cInstrumento As String) As Boolean

Dim vDatos_Retorno()

    FUNC_CON_INSTRUMENTO = False

    GLB_Envia = Array()
    PROC_AGREGA_PARAMETRO GLB_Envia, ""
    PROC_AGREGA_PARAMETRO GLB_Envia, 0
    PROC_AGREGA_PARAMETRO GLB_Envia, cInstrumento
    
    If FUNC_EXECUTA_COMANDO_SQL("SP_CON_INST_BONOS", GLB_Envia) Then
        
        If FUNC_LEE_RETORNO_SQL(vDatos_Retorno()) Then
            
            nCodigo_Instrumento = vDatos_Retorno(1)
            cGlosa_Instrumento = vDatos_Retorno(4)
            FUNC_CON_INSTRUMENTO = True
        
        End If
    
    Else
        
        Exit Function
    
    End If
    
End Function

Private Sub Txt_Nominal_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then
    
        FUNC_ENVIA_TECLA vbKeyTab
        
    End If

End Sub

Private Sub Txt_Nominal_LostFocus()

   nModo_Calculo = 1

End Sub

Private Sub Txt_Origen_DblClick()

   Call PROC_CON_SERIES_ORIGEN

End Sub

Private Sub Txt_Origen_KeyDown(KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyF3 Then Call PROC_CON_SERIES_ORIGEN

End Sub

Private Sub Txt_Origen_KeyPress(KeyAscii As Integer)

   PROC_TO_CASE KeyAscii
    
   If KeyAscii = 13 Then
   
      FUNC_ENVIA_TECLA (vbKeyTab)
      
   End If

End Sub


Private Sub Txt_Param1_LostFocus()
   
   nPos_Formula = 2
   
End Sub

Private Sub Txt_Param2_LostFocus()
   
   nPos_Formula = 3
   
End Sub

Private Sub Txt_Param3_LostFocus()
   
   nPos_Formula = 4
   
End Sub

Private Sub Txt_Param4_LostFocus()
   
   nPos_Formula = 5
   
End Sub

Private Sub Txt_Serie_DblClick()

   Call PROC_CON_SERIES
   
End Sub

Private Sub Txt_Serie_KeyDown(KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyF3 Then Call PROC_CON_SERIES

End Sub

Private Sub Txt_Serie_KeyPress(KeyAscii As Integer)

   PROC_TO_CASE KeyAscii
    
   If KeyAscii = 13 Then
   
      FUNC_ENVIA_TECLA (vbKeyTab)
      
   End If

End Sub

Sub PROC_CON_SERIES()
On Error GoTo Error_series

      If TXT_Instrumento.Text = "" Or cHay_Datos = "N" Then Exit Sub
      
         Pbl_cCodigo_Producto = TXT_Instrumento.Text
         Pbl_cCodigo_Serie = TXT_Instrumento.Text
         cMiTag = "MDSE"
         FRM_AYUDA.Show 1
         
      If GLB_Aceptar = True Then
         Tlb_Formulas.Buttons(3).Enabled = True
         Txt_Serie.Enabled = True
         Txt_Serie.Text = GLB_codigo
         Fr_Serie.Enabled = False
         Fr_Instrumento.Enabled = False
      
      End If
      
      'Call PROC_BUSCAR_SERIES
      
      Exit Sub
      
      
      
Error_series:
      MousePointer = 0
      MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical
      Exit Sub
      
End Sub

Private Sub Txt_Serie_LostFocus()
On Error GoTo Error_Familia

   If Trim(Txt_Serie.Text) = "" Then Exit Sub
    
   Call PROC_BUSCAR_SERIES

Exit Sub

Error_Familia:
    MousePointer = 0
    MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical
    Exit Sub

End Sub

Private Sub PROC_BUSCAR_SERIES()
On Error GoTo Error_buscar_serie

Dim cSql   As String
Dim vDatos_Retorno()
Dim nMoneda As Integer
Dim nAmortiza As Integer

If Txt_Serie.Text = "" Or TXT_Instrumento.Text = "" Then
    MsgBox ("Debe ingresar Instrumento y Máscara para realizar búsqueda"), vbInformation
    Exit Sub
End If

    GLB_Envia = Array()
    PROC_AGREGA_PARAMETRO GLB_Envia, nCodigo_Instrumento
    PROC_AGREGA_PARAMETRO GLB_Envia, Txt_Serie.Text
    PROC_AGREGA_PARAMETRO GLB_Envia, TXT_Instrumento.Text
    If Not FUNC_EXECUTA_COMANDO_SQL("SP_CON_SERIES", GLB_Envia) Then
         Screen.MousePointer = 0
         MsgBox ("Problemas al realizar búsqueda"), vbCritical
         Call PROC_LIMPIAR_PANTALLA
         Exit Sub
    Else
    
        If FUNC_LEE_RETORNO_SQL(vDatos_Retorno()) Then
               
            nRut_Emisor = CDbl(vDatos_Retorno(3))
            Txt_Tasa.Text = CDbl(vDatos_Retorno(4))
            Txt_Base.Text = vDatos_Retorno(5)
            FUNC_LLENA_MONEDA (CDbl(vDatos_Retorno(6)))
            nMoneda_Emision = (CDbl(vDatos_Retorno(6)))
            Txt_Fecha_Vcto.Text = vDatos_Retorno(13)
            Txt_Fecha_Emsion.Text = vDatos_Retorno(14)
            Txt_Pago.Text = vDatos_Retorno(11)
            Txt_Cupones.Text = vDatos_Retorno(12)
          
            Call FUNC_CON_EMISOR(nRut_Emisor)
            Call FUNC_LLENA_ARREGLO_FORMULA
             
            Tab_Formula.TabEnabled(1) = True
            Tab_Formula.TabEnabled(2) = False
            tip_opt_tasa.Value = 1
            Fr_Opciones.Enabled = True
            tip_opt_tasa.Enabled = True
            tip_opt_tir.Enabled = True
            tip_opt_valor.Enabled = True
            Tlb_Formulas.Buttons(5).Enabled = True
            
        
        Else
        
            MsgBox ("Serie no encontrada"), vbInformation
            Call PROC_LIMPIAR_PANTALLA

        End If
    End If
    Exit Sub
    
Error_buscar_serie:
        MsgBox ("Problemas en búsqueda"), vbInformation
End Sub


Private Sub PROC_LIMPIAR_PANTALLA()

Dim nContador As Integer

   Fr_Instrumento.Enabled = True
   Fr_Serie.Enabled = True
   Txt_Serie.Enabled = False
   TXT_Instrumento.Text = ""
   Txt_Serie.Text = ""
   Txt_Fecha_Emsion.Text = GLB_Fecha_Proceso
   Txt_Fecha_Vcto.Text = GLB_Fecha_Proxima
   Txt_Base.Text = 0
   Txt_Tasa.Text = 0
   Txt_Cupones.Text = 0
   Txt_Pago.Text = 0
   Txt_Moneda.Text = ""
   Txt_Nombre.Text = ""
   Text_Formula.Text = ""
   Txt_Param1.Text = ""
   Txt_Param2.Text = ""
   Txt_Param3.Text = ""
   Txt_Param4.Text = ""
   Txt_Origen.Text = ""
   Txt_Destino.Text = ""
   Fr_Datos_Valorizar.Enabled = False
   Txt_Fecha_Valorizacion.Text = GLB_Fecha_Proceso
   Txt_Tir.Text = 0
   Txt_Nominal.Text = 0
   Txt_Vpar.Text = 0
   Txt_Valor_Presente.Text = 0
   Txt_Valor_Presente_UM.Text = 0
   
   For nContador = 1 To 100
   
       Arreglo_Formulas(nContador, 1) = ""
       Arreglo_Formulas(nContador, 2) = ""
       Arreglo_Formulas(nContador, 3) = ""
       Arreglo_Formulas(nContador, 4) = ""
       Arreglo_Formulas(nContador, 5) = ""
       Arreglo_Formulas(nContador, 6) = ""
       Arreglo_Formulas(nContador, 7) = ""
       Arreglo_Formulas(nContador, 8) = ""
       Arreglo_Formulas(nContador, 9) = ""
       Arreglo_Formulas(nContador, 10) = ""
       
       Arreglo_Variables(nContador, 1) = ""
       Arreglo_Variables(nContador, 2) = ""
       Arreglo_Variables(nContador, 3) = ""
       Arreglo_Variables(nContador, 4) = ""
       Arreglo_Variables(nContador, 5) = ""
       Arreglo_Variables(nContador, 6) = ""
       
       Arreglo_Operadores(nContador, 1) = ""
       Arreglo_Operadores(nContador, 2) = ""
       Arreglo_Operadores(nContador, 3) = ""
       Arreglo_Operadores(nContador, 4) = ""
       Arreglo_Operadores(nContador, 5) = ""
       Arreglo_Operadores(nContador, 6) = ""
       
       Arreglo_Funciones(nContador, 1) = ""
       Arreglo_Funciones(nContador, 2) = ""
       Arreglo_Funciones(nContador, 3) = ""
       Arreglo_Funciones(nContador, 4) = ""
       Arreglo_Funciones(nContador, 5) = ""
       Arreglo_Funciones(nContador, 6) = ""

   Next
   
   DoEvents
   
   If Tab_Formula.Tab = 0 Then
   
      If Me.Visible = True Then
        TXT_Instrumento.SetFocus
      End If
   
   End If
   
   Tab_Formula.TabEnabled(0) = True
   Tab_Formula.TabEnabled(1) = False
   Tab_Formula.TabEnabled(2) = False
   Tab_Formula.TabEnabled(3) = False

   Tlb_Formulas.Buttons(2).Enabled = False
   Tlb_Formulas.Buttons(3).Enabled = False
   Tlb_Formulas.Buttons(4).Enabled = True
   Tlb_Formulas.Buttons(5).Enabled = False
   
   Tab_Formula.Tab = 0
   
   
End Sub
Private Function FUNC_CON_EMISOR(Rut_Emisor As Double)

Dim vDatos_Retorno()

    GLB_Envia = Array()
    PROC_AGREGA_PARAMETRO GLB_Envia, nRut_Emisor
        
        
    If Not FUNC_EXECUTA_COMANDO_SQL("SP_CON_EMISORES", GLB_Envia) Then
        Screen.MousePointer = 0
        MsgBox ("Problemas al buscar Emisor"), vbCritical
        Call PROC_LIMPIAR_PANTALLA
        Exit Function
        
    Else
    
        If FUNC_LEE_RETORNO_SQL(vDatos_Retorno()) Then
        
            Txt_Nombre.Text = vDatos_Retorno(4)
            
        End If
    End If

End Function

Public Function FUNC_LLENA_MONEDA(nCodigo_Moneda As Double) As Boolean

Dim vDatos_Retorno()

On Error GoTo ErrMon

    FUNC_LLENA_MONEDA = False
        
   GLB_Envia = Array()
   PROC_AGREGA_PARAMETRO GLB_Envia, nCodigo_Moneda

    
    If FUNC_EXECUTA_COMANDO_SQL("SP_CON_MONEDA_INST", GLB_Envia) Then
        Do While FUNC_LEE_RETORNO_SQL(vDatos_Retorno())
            
           Txt_Moneda = vDatos_Retorno(2)
        
        Loop
    
    End If
    
    FUNC_LLENA_MONEDA = True
    
    Exit Function
    
ErrMon:
    MsgBox "Problemas en consulta de monedas: " & Err.Description & ". Comunique al Administrador. ", vbCritical
    Exit Function
    
End Function

Private Sub Txt_Tir_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then
    
        FUNC_ENVIA_TECLA vbKeyTab
        
    End If

End Sub

Private Sub Txt_Tir_LostFocus()
   
   nModo_Calculo = 2

End Sub

Private Sub Txt_Valor_Presente_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then
    
        FUNC_ENVIA_TECLA vbKeyTab
        
    End If

End Sub

Private Sub Txt_Valor_Presente_LostFocus()

   nModo_Calculo = 3

End Sub

Private Sub Txt_Vpar_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then
    
        FUNC_ENVIA_TECLA vbKeyTab
        
    End If

End Sub

Private Sub Txt_Vpar_LostFocus()

   nModo_Calculo = 1

End Sub

Sub PROC_CON_SERIES_ORIGEN()
On Error GoTo Error_series

      If cHay_Datos = "N" Then Exit Sub
      
         Pbl_cTipo_Instrumento = "NBYL"
         cMiTag = "MDIN"
         FRM_AYUDA.Show 1
         
      If GLB_Aceptar = True Then
         
         Txt_Origen.Enabled = True
         Txt_Origen.Text = GLB_nombre
         nCodigo_Serie_O = GLB_codigo
      
      End If
      
      Exit Sub
      
Error_series:
      MousePointer = 0
      MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical
      Exit Sub
      
End Sub

Sub PROC_CON_SERIES_DESTINO()
On Error GoTo Error_series

      If cHay_Datos = "N" Then Exit Sub
      
         Pbl_cTipo_Instrumento = "NBYL"
         cMiTag = "MDIN"
         FRM_AYUDA.Show 1
         
      If GLB_Aceptar = True Then
         
         Txt_Destino.Enabled = True
         Txt_Destino.Text = GLB_nombre
         nCodigo_Serie_D = GLB_codigo
         
      End If
      
      Exit Sub
      
Error_series:
      MousePointer = 0
      MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical
      Exit Sub
      
End Sub

Sub PROC_VALIDA_COPIA()


   If Trim(Txt_Origen.Text) = "" Then
   
      MsgBox "Debe ingresar Serie Origen", vbInformation
      Txt_Origen.SetFocus
      
   ElseIf Trim(Txt_Destino.Text) = "" Then
            
      MsgBox "Debe ingresar Serie Destino", vbInformation
      Txt_Destino.SetFocus

   ElseIf Trim(Txt_Destino.Text) = Trim(Txt_Origen.Text) Then
            
      MsgBox "Series Deben ser distintas", vbInformation
      Txt_Destino.SetFocus
      
   ElseIf Trim(Txt_Origen.Text) <> "" And Trim(Txt_Destino.Text) <> "" Then
   
      PROC_COPIAR_FORMULAS
      Txt_Origen.Text = ""
      Txt_Destino.Text = ""
      PROC_LIMPIAR_PANTALLA
      
   End If
   
End Sub

Sub PROC_HABILITAR_COPIA()
   
   Tab_Formula.TabEnabled(0) = False
   Tab_Formula.TabEnabled(1) = False
   Tab_Formula.TabEnabled(2) = False
   Tab_Formula.TabEnabled(3) = True
   Tab_Formula.Tab = 3
   
   
End Sub

Sub PROC_COPIAR_FORMULAS()

    Dim vDatos_Retorno()
    GLB_Envia = Array()
    
   PROC_AGREGA_PARAMETRO GLB_Envia, CDbl(nCodigo_Serie_O)
   PROC_AGREGA_PARAMETRO GLB_Envia, Trim(Txt_Origen.Text)
   PROC_AGREGA_PARAMETRO GLB_Envia, CDbl(nCodigo_Serie_D)
   PROC_AGREGA_PARAMETRO GLB_Envia, Trim(Txt_Destino.Text)
   
    If FUNC_EXECUTA_COMANDO_SQL("SP_PRO_COPIA_FORMULAS", GLB_Envia) Then
    
        MsgBox "Copia realizada con éxito", vbInformation
        Txt_Origen.SetFocus
        
    End If

End Sub
    
Sub PROC_ENCABEZADOS_GRILLA()

   With Grd_Formula
   
      .TextMatrix(0, 1) = "Nº"
      .TextMatrix(0, 2) = "Campo"
      .TextMatrix(0, 3) = "Formula"
      .TextMatrix(0, 5) = "Param.1"
      .TextMatrix(0, 6) = "Param.2"
      .TextMatrix(0, 7) = "TD Desde"
      .TextMatrix(0, 8) = "TD Hasta"
      
      .ColWidth(0) = 0
      .ColWidth(1) = 300
      .ColWidth(2) = 700
      .ColWidth(3) = 6000
      .ColWidth(4) = 0
      .ColWidth(5) = 700
      .ColWidth(6) = 700
      .ColWidth(7) = 1150
      .ColWidth(8) = 1150
      
      .ColAlignment(3) = 0
      .ColAlignment(4) = 0
      .ColAlignment(5) = 0
      .ColAlignment(6) = 0
      .ColAlignment(7) = 0
      .ColAlignment(8) = 0
   End With
   
End Sub

Function FUN_LLENA_LISTA_VARIABLES()

   Dim vDatos_Retorno()
   Dim nContador As Integer
    
   Lst_Variables.Clear
   
   GLB_Envia = Array()
   
   PROC_AGREGA_PARAMETRO GLB_Envia, 1
    
    If FUNC_EXECUTA_COMANDO_SQL("SP_PRO_CAPTURA_DATOS_CALCULO", GLB_Envia) Then
        nContador = 0
        Do While FUNC_LEE_RETORNO_SQL(vDatos_Retorno)
            Lst_Variables.AddItem Trim(vDatos_Retorno(2)) & " - " & vDatos_Retorno(4)
            Lst_Variables.ItemData(Lst_Variables.NewIndex) = Val(vDatos_Retorno(5))
            Arreglo_Variables(nContador, 1) = Trim(vDatos_Retorno(2))
            Arreglo_Variables(nContador, 2) = Trim(vDatos_Retorno(4))
            Arreglo_Variables(nContador, 3) = Trim(vDatos_Retorno(3))
            Arreglo_Variables(nContador, 4) = Val(vDatos_Retorno(5))
            Arreglo_Variables(nContador, 5) = Trim(vDatos_Retorno(7))
            Arreglo_Variables(nContador, 6) = Trim(vDatos_Retorno(8))

            nContador = nContador + 1
        Loop
    End If
    
End Function
Function FUN_LLENA_LISTA_OPERADORES()

   Dim vDatos_Retorno()
   Dim nContador As Integer
    
   Lst_Operadores.Clear
   
   GLB_Envia = Array()
   
   PROC_AGREGA_PARAMETRO GLB_Envia, 2
    
    If FUNC_EXECUTA_COMANDO_SQL("SP_PRO_CAPTURA_DATOS_CALCULO", GLB_Envia) Then
        nContador = 0
        Do While FUNC_LEE_RETORNO_SQL(vDatos_Retorno)
            Lst_Operadores.AddItem Trim(vDatos_Retorno(2)) & " - " & vDatos_Retorno(4)
            Lst_Operadores.ItemData(Lst_Operadores.NewIndex) = Val(vDatos_Retorno(5))
            Arreglo_Operadores(nContador, 1) = Trim(vDatos_Retorno(2))
            Arreglo_Operadores(nContador, 2) = Trim(vDatos_Retorno(4))
            Arreglo_Operadores(nContador, 3) = Trim(vDatos_Retorno(3))
            Arreglo_Operadores(nContador, 4) = Val(vDatos_Retorno(5))
            Arreglo_Operadores(nContador, 5) = Trim(vDatos_Retorno(7))
            Arreglo_Operadores(nContador, 6) = Trim(vDatos_Retorno(8))

            nContador = nContador + 1
        Loop
    End If

End Function

Function FUN_LLENA_LISTA_FUNCIONES()
    
   Dim vDatos_Retorno()
   Dim nContador As Integer
    
   Lst_Funciones.Clear
   
   GLB_Envia = Array()
   
   PROC_AGREGA_PARAMETRO GLB_Envia, 3
    
    If FUNC_EXECUTA_COMANDO_SQL("SP_PRO_CAPTURA_DATOS_CALCULO", GLB_Envia) Then
        nContador = 0
        Do While FUNC_LEE_RETORNO_SQL(vDatos_Retorno)
            Lst_Funciones.AddItem Trim(vDatos_Retorno(2)) & " - " & vDatos_Retorno(4)
            Lst_Funciones.ItemData(Lst_Funciones.NewIndex) = Val(vDatos_Retorno(5))
            Arreglo_Funciones(nContador, 1) = Trim(vDatos_Retorno(2))
            Arreglo_Funciones(nContador, 2) = Trim(vDatos_Retorno(4))
            Arreglo_Funciones(nContador, 3) = Trim(vDatos_Retorno(3))
            Arreglo_Funciones(nContador, 4) = Val(vDatos_Retorno(5))
            Arreglo_Funciones(nContador, 5) = Trim(vDatos_Retorno(7))
            Arreglo_Funciones(nContador, 6) = Trim(vDatos_Retorno(8))

            nContador = nContador + 1
        Loop
    End If

End Function

Sub PROC_MARCAR()
   
   Dim nFila, nColumna, nContador, v As Integer
   
   Dim nLargo_Fila As Integer
   
   nFila_Seleccionada = Grd_Formula.RowSel
   
   nLargo_Fila = Grd_Formula.TopRow
   
   With Grd_Formula
   
      nFila = .RowSel
      
      .FocusRect = flexFocusHeavy
      .Redraw = False

    For nContador = 1 To .Rows - 1
         
        For nColumna = 0 To .Cols - 1
        
               .Row = nContador
               .Col = nColumna
               

                  If nContador <> nFila Then
                  
                     .BackColorSel = &HC0C0C0
                     .BackColorFixed = &H808000
                     .ForeColorFixed = &H80000005
                     .CellBackColor = &HC0C0C0
                     .CellForeColor = vbBlue
                     
                  End If
                  
               If nFila = nContador Then
               
                    .BackColorSel = &H800000
                    .BackColorFixed = &H808000
                    .ForeColorFixed = &H80000005
                    .CellBackColor = vbBlue    ''vbRed
                    .CellForeColor = vbWhite
                    
               End If
               
        Next nColumna
        
    Next nContador
    
      .Row = nFila
      .Col = 0
      .FocusRect = flexFocusLight
      .Redraw = True
      
   End With
   
    If nLargo_Fila > 1 Then
    
        Grd_Formula.TopRow = nLargo_Fila
        
    End If
   
End Sub
Function FUNC_LLENA_GRILLA_FORMULA()

     Dim Datos()
     Dim pru
     Dim nContador_1 As Integer
     Dim nContador_2 As Integer
     
     nContador_1 = 0
     nContador_2 = 1
             
     Grd_Formula.Rows = 1
     
     For nContador_1 = 1 To 100
     
        If Arreglo_Formulas(nContador_1, 2) = nOpcion_Formula Then
     
            Grd_Formula.Rows = nContador_2 + 1
            
             Grd_Formula.TextMatrix(nContador_2, 1) = Arreglo_Formulas(nContador_1, 3) 'Numero Linea
             Grd_Formula.TextMatrix(nContador_2, 2) = Arreglo_Formulas(nContador_1, 4) 'Varaible
             Grd_Formula.TextMatrix(nContador_2, 3) = Arreglo_Formulas(nContador_1, 5) 'Formula
             Grd_Formula.TextMatrix(nContador_2, 0) = Arreglo_Formulas(nContador_1, 6) 'Tipo Formula
             Grd_Formula.TextMatrix(nContador_2, 4) = Arreglo_Formulas(nContador_1, 1) 'Linea en Arreglo
             Grd_Formula.TextMatrix(nContador_2, 5) = Arreglo_Formulas(nContador_1, 7) 'Parametro 1
             Grd_Formula.TextMatrix(nContador_2, 6) = Arreglo_Formulas(nContador_1, 8) 'Parametro 2
             Grd_Formula.TextMatrix(nContador_2, 7) = Arreglo_Formulas(nContador_1, 9) 'Parametro 3
             Grd_Formula.TextMatrix(nContador_2, 8) = Arreglo_Formulas(nContador_1, 10) 'Parametro 4
             
             nContador_2 = nContador_2 + 1
             
         End If
             
    Next
        

End Function

Function FUNC_LLENA_ARREGLO_FORMULA()

     Dim vDatos_Retorno()
     Dim pru
     
     nLinea_Formula = 0
             
      GLB_Envia = Array()
      PROC_AGREGA_PARAMETRO GLB_Envia, nCodigo_Instrumento
      PROC_AGREGA_PARAMETRO GLB_Envia, IIf(nCodigo_Instrumento <> 1, (TXT_Instrumento.Text), Trim(Txt_Serie.Text))
                
    If FUNC_EXECUTA_COMANDO_SQL("SP_CON_DATOS_FORMULAS", GLB_Envia) Then
     
            Do While FUNC_LEE_RETORNO_SQL(vDatos_Retorno)
         
               nLinea_Formula = nLinea_Formula + 1
               Arreglo_Formulas(nLinea_Formula, 1) = nLinea_Formula
               Arreglo_Formulas(nLinea_Formula, 2) = vDatos_Retorno(3)      'Tipo Calculo
               Arreglo_Formulas(nLinea_Formula, 3) = vDatos_Retorno(4)      'Numero Linea
               Arreglo_Formulas(nLinea_Formula, 4) = vDatos_Retorno(5)      'Varaible
               Arreglo_Formulas(nLinea_Formula, 5) = vDatos_Retorno(6)      'Formula
               Arreglo_Formulas(nLinea_Formula, 6) = vDatos_Retorno(7)      'Tipo Formula
               Arreglo_Formulas(nLinea_Formula, 7) = vDatos_Retorno(8)      'Parametro1
               Arreglo_Formulas(nLinea_Formula, 8) = vDatos_Retorno(9)     'Parametro2
               Arreglo_Formulas(nLinea_Formula, 9) = vDatos_Retorno(10)     'Parametro3
               Arreglo_Formulas(nLinea_Formula, 10) = vDatos_Retorno(11)     'Parametro4

            Loop
        
    End If

      Tlb_Formulas.Buttons(2).Enabled = True
   
End Function

Function FUNC_LLENA_GRILLA()

    Dim nContador_1 As Integer
    Dim nContador_2 As Integer
    
    Grd_Formula.Rows = 1
    Grd_Formula.Clear
    
    If TXT_Instrumento.Text <> "" Then
    
        nContador_1 = 0
        
        For nContador_1 = 1 To 100
            
            If Arreglo_Formulas(nContador_1, 1) <> "" And nOpcion_Formula = Arreglo_Formulas(nContador_1, 3) And Arreglo_Formulas(nContador_1, 2) = TXT_Instrumento.Text Then
                
                nContador_2 = nContador_2 + 1
            
            End If
        
        Next
        nContador_1 = 0
        
        Grd_Formula.Rows = nContador_2 + 1
        
        For nContador_1 = 1 To 100
            
            If Arreglo_Formulas(nContador_1, 1) <> "" And nOpcion_Formula = Arreglo_Formulas(nContador_1, 3) And Arreglo_Formulas(nContador_1, 2) = TXT_Instrumento.Text And Txt_Serie.Text = Arreglo_Formulas(nContador_1, 1) Then
                
                Grd_Formula.TextMatrix(nContador_1, 1) = Arreglo_Formulas(nContador_1, 4)
                Grd_Formula.TextMatrix(nContador_1, 2) = Arreglo_Formulas(nContador_1, 5)
                Grd_Formula.TextMatrix(nContador_1, 3) = Arreglo_Formulas(nContador_1, 6)
            
            End If
        
        Next
    
    End If

End Function

Function FUNC_GRABAR_DATOS()

Dim nContador_1
Dim nContador_2
Dim vDatos_Retorno()

    GLB_Envia = Array()

    PROC_AGREGA_PARAMETRO GLB_Envia, nCodigo_Instrumento
    PROC_AGREGA_PARAMETRO GLB_Envia, IIf(nCodigo_Instrumento <> 1, (TXT_Instrumento.Text), Trim(Txt_Serie.Text))
    
    If FUNC_EXECUTA_COMANDO_SQL("SP_ELI_FORMULAS", GLB_Envia) Then
        
        
    End If
    
    nContador_1 = 0
    
    For nContador_2 = 1 To 100
    
        If Arreglo_Formulas(nContador_2, 2) <> "" Then
        
            GLB_Envia = Array()
            PROC_AGREGA_PARAMETRO GLB_Envia, nCodigo_Instrumento
            PROC_AGREGA_PARAMETRO GLB_Envia, IIf(nCodigo_Instrumento <> 1, (TXT_Instrumento.Text), Trim(Txt_Serie.Text))
            PROC_AGREGA_PARAMETRO GLB_Envia, Val(Arreglo_Formulas(nContador_2, 2))
            PROC_AGREGA_PARAMETRO GLB_Envia, Val(Arreglo_Formulas(nContador_2, 3))
            PROC_AGREGA_PARAMETRO GLB_Envia, Arreglo_Formulas(nContador_2, 4)
            PROC_AGREGA_PARAMETRO GLB_Envia, Arreglo_Formulas(nContador_2, 5)
            PROC_AGREGA_PARAMETRO GLB_Envia, Arreglo_Formulas(nContador_2, 6)
            
            If Trim(Arreglo_Formulas(nContador_2, 7)) = "" Then
            
                PROC_AGREGA_PARAMETRO GLB_Envia, " "
            
            Else
                
                PROC_AGREGA_PARAMETRO GLB_Envia, Arreglo_Formulas(nContador_2, 7)
            
            End If
            
            If Trim(Arreglo_Formulas(nContador_2, 8)) = "" Then
                
                PROC_AGREGA_PARAMETRO GLB_Envia, " "
            
            Else
                
                PROC_AGREGA_PARAMETRO GLB_Envia, Arreglo_Formulas(nContador_2, 8)
            
            End If
            
            If Trim(Arreglo_Formulas(nContador_2, 9)) = "" Then
                
                PROC_AGREGA_PARAMETRO GLB_Envia, " "
            
            Else
                
                PROC_AGREGA_PARAMETRO GLB_Envia, Arreglo_Formulas(nContador_2, 9)
            
            End If
            
            If Trim(Arreglo_Formulas(nContador_2, 10)) = "" Then
                
                PROC_AGREGA_PARAMETRO GLB_Envia, " "
            
            Else
                
                PROC_AGREGA_PARAMETRO GLB_Envia, Arreglo_Formulas(nContador_2, 10)
            
            End If
    
    
            If Not FUNC_EXECUTA_COMANDO_SQL("SP_ACT_FORMULAS", GLB_Envia) Then
               
               MsgBox "Problemas en grabacion", vbInformation
               Exit Function
            
            End If
        

        
        End If
        
    Next
    
    MsgBox "Grabación realizada con éxito", vbInformation
    
End Function

Sub PROC_VALORIZACION(nModCal As Integer)

    Dim vDatos_Retorno()
    
    If Not IsDate(Txt_Fecha_Valorizacion.Text) Then
        Exit Sub
    End If
    
    If CDbl(Txt_Nominal.Text) = 0 Then

        Exit Sub

    End If

    If CDbl(Txt_Vpar.Text) = 0 Or CDbl(Txt_Valor_Presente.Text) = 0 Or CDbl(Txt_Tir.Text) = 0 Then

        If CDbl(Txt_Vpar.Text) = 0 And CDbl(Txt_Valor_Presente.Text) = 0 And CDbl(Txt_Nominal.Text) <> 0 And CDbl(Txt_Tir.Text) <> 0 Then

            nModCal = 2

        End If

        If CDbl(Txt_Vpar.Text) <> 0 And CDbl(Txt_Valor_Presente.Text) = 0 And CDbl(Txt_Nominal.Text) <> 0 And CDbl(Txt_Tir.Text) = 0 Then

            nModCal = 1

        End If

        If CDbl(Txt_Vpar.Text) = 0 And CDbl(Txt_Valor_Presente.Text) <> 0 And CDbl(Txt_Nominal.Text) <> 0 And CDbl(Txt_Tir.Text) = 0 Then

            nModCal = 3

        End If

    End If
     
    If Not IsDate(Txt_Fecha_Emsion.Text) Then

        Exit Sub

    End If
   
    If Not IsDate(Txt_Fecha_Vcto.Text) Then
    
        Exit Sub
        
    End If
    
    If CDbl(Txt_Tasa.Text) = 0 Then
        Exit Sub
    End If
    
    If CDate(Txt_Fecha_Vcto.Text) <= CDate(Txt_Fecha_Emsion.Text) Then
    
        MsgBox "Falta Ingresar fecha de Vencimiento..", vbCritical
        Exit Sub
        
    End If
    
    If CDate(Txt_Fecha_Vcto.Text) <= CDate(Txt_Fecha_Valorizacion.Text) Then
    
        MsgBox "El Instrumento esta vencido a esta fecha de calculo...", vbCritical
        Exit Sub
        
    End If
  
    Screen.MousePointer = 11
    
    Nom = CDbl(Txt_Nominal.Text)
    MT = CDbl(Txt_Valor_Presente.Text)
    TR = CDbl(Txt_Tir.Text)
    PVP = CDbl(Txt_Vpar.Text)
    TE = CDbl(Txt_Tasa.Text)
    TV = CDbl(Txt_Tasa.Text)
    TT = 0
    BF = 0
    VV = 0
    VP = 0
    VAN = 0
    FP = Txt_Fecha_Valorizacion.Text
    FE = Txt_Fecha_Emsion.Text
    FV = Txt_Fecha_Vcto.Text
    FC = Txt_Fecha_Valorizacion.Text
    FP = Format(FP, "DD/MM/YYYY")
    FE = Format(FE, "DD/MM/YYYY")
    FV = Format(FV, "DD/MM/YYYY")
    FC = Format(FC, "DD/MM/YYYY")
    INDEV = 0
    PRINC = 0
    FIP = Format(FIP, "DD/MM/YYYY")
    INCTR = 0
    CAP = 0
    BA = CDbl(Txt_Base.Text)
    
      GLB_Envia = Array()
    
      PROC_AGREGA_PARAMETRO GLB_Envia, nModCal
      PROC_AGREGA_PARAMETRO GLB_Envia, Txt_Fecha_Valorizacion.Text
      PROC_AGREGA_PARAMETRO GLB_Envia, nCodigo_Instrumento
      PROC_AGREGA_PARAMETRO GLB_Envia, Trim(Txt_Serie.Text)
      PROC_AGREGA_PARAMETRO GLB_Envia, nMoneda_Emision
      PROC_AGREGA_PARAMETRO GLB_Envia, Format(FE, "YYYYMMDD")
      PROC_AGREGA_PARAMETRO GLB_Envia, Format(FV, "YYYYMMDD")
      PROC_AGREGA_PARAMETRO GLB_Envia, TE
      PROC_AGREGA_PARAMETRO GLB_Envia, BA
      PROC_AGREGA_PARAMETRO GLB_Envia, TE
      PROC_AGREGA_PARAMETRO GLB_Envia, Nom
      PROC_AGREGA_PARAMETRO GLB_Envia, TR
      PROC_AGREGA_PARAMETRO GLB_Envia, PVP
      PROC_AGREGA_PARAMETRO GLB_Envia, MT

   If Not FUNC_EXECUTA_COMANDO_SQL("SP_PRO_VALORIZA_USUARIO", GLB_Envia) Then
        
        Screen.MousePointer = 0
        Exit Sub
   
   Else
   
        Do While FUNC_LEE_RETORNO_SQL(vDatos_Retorno)
            
            If vDatos_Retorno(1) <> "NO" Then
            
               Txt_Tir.Text = Format(CDbl(vDatos_Retorno(3)), GLB_Formato_Decimal)
               Txt_Valor_Presente.Text = Format(CDbl(vDatos_Retorno(5)), GLB_Formato_Entero)
               Txt_Vpar.Text = Format(CDbl(vDatos_Retorno(4)), GLB_Formato_Decimal)
               Txt_Valor_Presente_UM.Text = Format(CDbl(vDatos_Retorno(6)), GLB_Formato_Decimal)
            
            Else
            
               Screen.MousePointer = 0
               MsgBox vDatos_Retorno(2), vbExclamation
               Exit Sub
            
            End If
   
        Loop
   
   End If

   Screen.MousePointer = 0

End Sub


