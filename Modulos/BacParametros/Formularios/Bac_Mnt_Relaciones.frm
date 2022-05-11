VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MsComCtl.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{BDC217C8-ED16-11CD-956C-0000C04E4C0A}#1.1#0"; "tabctl32.ocx"
Begin VB.Form Frm_Mnt_Relaciones 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantencion de Carteras Por Sistemas"
   ClientHeight    =   7155
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   7680
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   7155
   ScaleWidth      =   7680
   Begin MSComctlLib.Toolbar Tlb_Herramientas 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   7680
      _ExtentX        =   13547
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
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Cerrar"
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   5160
         Top             =   75
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
               Picture         =   "Bac_Mnt_Relaciones.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bac_Mnt_Relaciones.frx":0EDA
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bac_Mnt_Relaciones.frx":1DB4
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin Threed.SSFrame SSFrame1 
      Height          =   6690
      Left            =   0
      TabIndex        =   2
      Top             =   435
      Width           =   7650
      _Version        =   65536
      _ExtentX        =   13494
      _ExtentY        =   11800
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
      Begin TabDlg.SSTab Tab_Carteras 
         Height          =   5610
         Left            =   90
         TabIndex        =   3
         Top             =   975
         Width           =   7470
         _ExtentX        =   13176
         _ExtentY        =   9895
         _Version        =   393216
         Tabs            =   5
         Tab             =   1
         TabHeight       =   520
         ForeColor       =   8388608
         TabCaption(0)   =   "Carteras Normativas"
         TabPicture(0)   =   "Bac_Mnt_Relaciones.frx":20CE
         Tab(0).ControlEnabled=   0   'False
         Tab(0).Control(0)=   "Fr_Cartera_Normativa"
         Tab(0).ControlCount=   1
         TabCaption(1)   =   "Cartera Financiera"
         TabPicture(1)   =   "Bac_Mnt_Relaciones.frx":20EA
         Tab(1).ControlEnabled=   -1  'True
         Tab(1).Control(0)=   "SSFrame2"
         Tab(1).Control(0).Enabled=   0   'False
         Tab(1).ControlCount=   1
         TabCaption(2)   =   "Libro"
         TabPicture(2)   =   "Bac_Mnt_Relaciones.frx":2106
         Tab(2).ControlEnabled=   0   'False
         Tab(2).Control(0)=   "SSFrame3"
         Tab(2).ControlCount=   1
         TabCaption(3)   =   "Area Responsable"
         TabPicture(3)   =   "Bac_Mnt_Relaciones.frx":2122
         Tab(3).ControlEnabled=   0   'False
         Tab(3).Control(0)=   "SSFrame4"
         Tab(3).ControlCount=   1
         TabCaption(4)   =   "Sub Cartera Normativa"
         TabPicture(4)   =   "Bac_Mnt_Relaciones.frx":213E
         Tab(4).ControlEnabled=   0   'False
         Tab(4).Control(0)=   "SSFrame5"
         Tab(4).ControlCount=   1
         Begin Threed.SSFrame Fr_Cartera_Normativa 
            Height          =   4560
            Left            =   -74910
            TabIndex        =   5
            Top             =   825
            Width           =   7140
            _Version        =   65536
            _ExtentX        =   12594
            _ExtentY        =   8043
            _StockProps     =   14
            Caption         =   "Cartera Normativa"
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   9.75
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   -1  'True
               Strikethrough   =   0   'False
            EndProperty
            Begin MSComctlLib.ListView Lst_Libre 
               Height          =   3915
               Index           =   0
               Left            =   90
               TabIndex        =   6
               Top             =   540
               Width           =   3165
               _ExtentX        =   5583
               _ExtentY        =   6906
               View            =   3
               LabelEdit       =   1
               LabelWrap       =   0   'False
               HideSelection   =   -1  'True
               AllowReorder    =   -1  'True
               FullRowSelect   =   -1  'True
               _Version        =   393217
               ForeColor       =   -2147483640
               BackColor       =   -2147483643
               BorderStyle     =   1
               Appearance      =   1
               NumItems        =   0
            End
            Begin MSComctlLib.Toolbar Tlb_AgregaQuita 
               Height          =   450
               Left            =   3315
               TabIndex        =   7
               Top             =   1875
               Width           =   450
               _ExtentX        =   794
               _ExtentY        =   794
               ButtonWidth     =   767
               ButtonHeight    =   741
               AllowCustomize  =   0   'False
               Appearance      =   1
               Style           =   1
               ImageList       =   "ImageList2"
               _Version        =   393216
               BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
                  NumButtons      =   2
                  BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
                     Description     =   "Agregar"
                     ImageIndex      =   1
                  EndProperty
                  BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
                     Description     =   "Quitar"
                     ImageIndex      =   2
                  EndProperty
               EndProperty
               BorderStyle     =   1
            End
            Begin MSComctlLib.ListView Lst_Sel 
               Height          =   3915
               Index           =   0
               Left            =   3840
               TabIndex        =   8
               Top             =   540
               Width           =   3165
               _ExtentX        =   5583
               _ExtentY        =   6906
               View            =   3
               LabelEdit       =   1
               LabelWrap       =   0   'False
               HideSelection   =   -1  'True
               AllowReorder    =   -1  'True
               FullRowSelect   =   -1  'True
               _Version        =   393217
               ForeColor       =   -2147483640
               BackColor       =   -2147483643
               BorderStyle     =   1
               Appearance      =   1
               NumItems        =   0
            End
            Begin VB.Label Label1 
               Alignment       =   2  'Center
               Caption         =   "Relacionadas"
               BeginProperty Font 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00FF0000&
               Height          =   240
               Left            =   3870
               TabIndex        =   9
               Top             =   285
               Width           =   3120
            End
         End
         Begin Threed.SSFrame SSFrame2 
            Height          =   4560
            Left            =   90
            TabIndex        =   10
            Top             =   825
            Width           =   7140
            _Version        =   65536
            _ExtentX        =   12594
            _ExtentY        =   8043
            _StockProps     =   14
            Caption         =   "Cartera Financiera"
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   9.75
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   -1  'True
               Strikethrough   =   0   'False
            EndProperty
            Begin MSComctlLib.ListView Lst_Libre 
               Height          =   3915
               Index           =   1
               Left            =   90
               TabIndex        =   11
               Top             =   540
               Width           =   3165
               _ExtentX        =   5583
               _ExtentY        =   6906
               View            =   3
               LabelEdit       =   1
               LabelWrap       =   0   'False
               HideSelection   =   -1  'True
               AllowReorder    =   -1  'True
               _Version        =   393217
               ForeColor       =   -2147483640
               BackColor       =   -2147483643
               BorderStyle     =   1
               Appearance      =   1
               NumItems        =   0
            End
            Begin MSComctlLib.Toolbar Tlb_AgregaQuita2 
               Height          =   450
               Left            =   3315
               TabIndex        =   12
               Top             =   1875
               Width           =   450
               _ExtentX        =   794
               _ExtentY        =   794
               ButtonWidth     =   767
               ButtonHeight    =   741
               AllowCustomize  =   0   'False
               Appearance      =   1
               Style           =   1
               ImageList       =   "ImageList2"
               _Version        =   393216
               BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
                  NumButtons      =   2
                  BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
                     Description     =   "Agregar"
                     ImageIndex      =   1
                  EndProperty
                  BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
                     Description     =   "Quitar"
                     ImageIndex      =   2
                  EndProperty
               EndProperty
               BorderStyle     =   1
            End
            Begin MSComctlLib.ListView Lst_Sel 
               Height          =   3915
               Index           =   1
               Left            =   3840
               TabIndex        =   13
               Top             =   540
               Width           =   3165
               _ExtentX        =   5583
               _ExtentY        =   6906
               View            =   3
               LabelEdit       =   1
               LabelWrap       =   0   'False
               HideSelection   =   -1  'True
               AllowReorder    =   -1  'True
               _Version        =   393217
               ForeColor       =   -2147483640
               BackColor       =   -2147483643
               BorderStyle     =   1
               Appearance      =   1
               NumItems        =   0
            End
            Begin VB.Label Label2 
               Alignment       =   2  'Center
               Caption         =   "Relacionadas"
               BeginProperty Font 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00FF0000&
               Height          =   240
               Left            =   3870
               TabIndex        =   14
               Top             =   285
               Width           =   3120
            End
         End
         Begin Threed.SSFrame SSFrame3 
            Height          =   4530
            Left            =   -74910
            TabIndex        =   15
            Top             =   825
            Width           =   7140
            _Version        =   65536
            _ExtentX        =   12594
            _ExtentY        =   7990
            _StockProps     =   14
            Caption         =   "Libro"
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   9.75
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   -1  'True
               Strikethrough   =   0   'False
            EndProperty
            Begin MSComctlLib.Toolbar Tlb_AgregaQuita3 
               Height          =   450
               Left            =   3315
               TabIndex        =   17
               Top             =   1875
               Width           =   450
               _ExtentX        =   794
               _ExtentY        =   794
               ButtonWidth     =   767
               ButtonHeight    =   741
               AllowCustomize  =   0   'False
               Appearance      =   1
               Style           =   1
               ImageList       =   "ImageList2"
               _Version        =   393216
               BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
                  NumButtons      =   2
                  BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
                     Description     =   "Agregar"
                     ImageIndex      =   1
                  EndProperty
                  BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
                     Description     =   "Quitar"
                     ImageIndex      =   2
                  EndProperty
               EndProperty
               BorderStyle     =   1
            End
            Begin MSComctlLib.ListView Lst_Libre 
               Height          =   3915
               Index           =   2
               Left            =   90
               TabIndex        =   16
               Top             =   540
               Width           =   3165
               _ExtentX        =   5583
               _ExtentY        =   6906
               View            =   3
               LabelEdit       =   1
               LabelWrap       =   0   'False
               HideSelection   =   -1  'True
               AllowReorder    =   -1  'True
               _Version        =   393217
               ForeColor       =   -2147483640
               BackColor       =   -2147483643
               BorderStyle     =   1
               Appearance      =   1
               NumItems        =   0
            End
            Begin MSComctlLib.ListView Lst_Sel 
               Height          =   3915
               Index           =   2
               Left            =   3840
               TabIndex        =   18
               Top             =   540
               Width           =   3165
               _ExtentX        =   5583
               _ExtentY        =   6906
               View            =   3
               LabelEdit       =   1
               LabelWrap       =   0   'False
               HideSelection   =   -1  'True
               AllowReorder    =   -1  'True
               _Version        =   393217
               ForeColor       =   -2147483640
               BackColor       =   -2147483643
               BorderStyle     =   1
               Appearance      =   1
               NumItems        =   0
            End
            Begin VB.Label Label3 
               Alignment       =   2  'Center
               Caption         =   "Relacionadas"
               BeginProperty Font 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00FF0000&
               Height          =   240
               Left            =   3870
               TabIndex        =   19
               Top             =   285
               Width           =   3120
            End
         End
         Begin Threed.SSFrame SSFrame4 
            Height          =   4560
            Left            =   -74910
            TabIndex        =   20
            Top             =   825
            Width           =   7140
            _Version        =   65536
            _ExtentX        =   12594
            _ExtentY        =   8043
            _StockProps     =   14
            Caption         =   "Area Responsable"
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   9.75
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   -1  'True
               Strikethrough   =   0   'False
            EndProperty
            Begin MSComctlLib.Toolbar Tlb_AgregaQuita4 
               Height          =   450
               Left            =   3315
               TabIndex        =   22
               Top             =   1875
               Width           =   450
               _ExtentX        =   794
               _ExtentY        =   794
               ButtonWidth     =   767
               ButtonHeight    =   741
               AllowCustomize  =   0   'False
               Appearance      =   1
               Style           =   1
               ImageList       =   "ImageList2"
               _Version        =   393216
               BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
                  NumButtons      =   2
                  BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
                     Description     =   "Agregar"
                     ImageIndex      =   1
                  EndProperty
                  BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
                     Description     =   "Quitar"
                     ImageIndex      =   2
                  EndProperty
               EndProperty
               BorderStyle     =   1
            End
            Begin MSComctlLib.ListView Lst_Libre 
               Height          =   3915
               Index           =   3
               Left            =   90
               TabIndex        =   21
               Top             =   540
               Width           =   3165
               _ExtentX        =   5583
               _ExtentY        =   6906
               View            =   3
               LabelEdit       =   1
               LabelWrap       =   0   'False
               HideSelection   =   -1  'True
               AllowReorder    =   -1  'True
               _Version        =   393217
               ForeColor       =   -2147483640
               BackColor       =   -2147483643
               BorderStyle     =   1
               Appearance      =   1
               NumItems        =   0
            End
            Begin MSComctlLib.ListView Lst_Sel 
               Height          =   3915
               Index           =   3
               Left            =   3840
               TabIndex        =   23
               Top             =   540
               Width           =   3165
               _ExtentX        =   5583
               _ExtentY        =   6906
               View            =   3
               LabelEdit       =   1
               LabelWrap       =   0   'False
               HideSelection   =   -1  'True
               AllowReorder    =   -1  'True
               _Version        =   393217
               ForeColor       =   -2147483640
               BackColor       =   -2147483643
               BorderStyle     =   1
               Appearance      =   1
               NumItems        =   0
            End
            Begin VB.Label Label4 
               Alignment       =   2  'Center
               Caption         =   "Relacionadas"
               BeginProperty Font 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00FF0000&
               Height          =   240
               Left            =   3870
               TabIndex        =   24
               Top             =   285
               Width           =   3120
            End
         End
         Begin Threed.SSFrame SSFrame5 
            Height          =   4560
            Left            =   -74910
            TabIndex        =   25
            Top             =   825
            Width           =   7140
            _Version        =   65536
            _ExtentX        =   12594
            _ExtentY        =   8043
            _StockProps     =   14
            Caption         =   "Sub Cartera Normativa"
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   9.75
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   -1  'True
               Strikethrough   =   0   'False
            EndProperty
            Begin MSComctlLib.Toolbar Tlb_AgregaQuita5 
               Height          =   450
               Left            =   3315
               TabIndex        =   26
               Top             =   1875
               Width           =   450
               _ExtentX        =   794
               _ExtentY        =   794
               ButtonWidth     =   767
               ButtonHeight    =   741
               AllowCustomize  =   0   'False
               Appearance      =   1
               Style           =   1
               ImageList       =   "ImageList2"
               _Version        =   393216
               BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
                  NumButtons      =   2
                  BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
                     Description     =   "Agregar"
                     ImageIndex      =   1
                  EndProperty
                  BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
                     Description     =   "Quitar"
                     ImageIndex      =   2
                  EndProperty
               EndProperty
               BorderStyle     =   1
            End
            Begin MSComctlLib.ListView Lst_Libre 
               Height          =   3915
               Index           =   4
               Left            =   90
               TabIndex        =   27
               Top             =   540
               Width           =   3165
               _ExtentX        =   5583
               _ExtentY        =   6906
               View            =   3
               LabelEdit       =   1
               LabelWrap       =   0   'False
               HideSelection   =   -1  'True
               AllowReorder    =   -1  'True
               _Version        =   393217
               ForeColor       =   -2147483640
               BackColor       =   -2147483643
               BorderStyle     =   1
               Appearance      =   1
               NumItems        =   0
            End
            Begin MSComctlLib.ListView Lst_Sel 
               Height          =   3915
               Index           =   4
               Left            =   3840
               TabIndex        =   28
               Top             =   540
               Width           =   3165
               _ExtentX        =   5583
               _ExtentY        =   6906
               View            =   3
               LabelEdit       =   1
               LabelWrap       =   0   'False
               HideSelection   =   -1  'True
               AllowReorder    =   -1  'True
               _Version        =   393217
               ForeColor       =   -2147483640
               BackColor       =   -2147483643
               BorderStyle     =   1
               Appearance      =   1
               NumItems        =   0
            End
            Begin VB.Label Label5 
               Alignment       =   2  'Center
               Caption         =   "Relacionadas"
               BeginProperty Font 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00FF0000&
               Height          =   240
               Left            =   3870
               TabIndex        =   29
               Top             =   285
               Width           =   3120
            End
         End
      End
      Begin Threed.SSFrame Fr_Combo 
         Height          =   735
         Left            =   75
         TabIndex        =   4
         Top             =   165
         Width           =   7500
         _Version        =   65536
         _ExtentX        =   13229
         _ExtentY        =   1296
         _StockProps     =   14
         Caption         =   "Sistema"
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Begin VB.ComboBox Cmb_Cartera 
            Height          =   315
            Left            =   1725
            Style           =   2  'Dropdown List
            TabIndex        =   30
            Top             =   240
            Width           =   3900
         End
         Begin VB.ComboBox Cmb_Sistema 
            Height          =   315
            Left            =   1725
            Style           =   2  'Dropdown List
            TabIndex        =   1
            Top             =   240
            Width           =   3900
         End
      End
   End
   Begin MSComctlLib.ImageList ImageList2 
      Left            =   9810
      Top             =   645
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   2
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bac_Mnt_Relaciones.frx":215A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bac_Mnt_Relaciones.frx":25AC
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "Frm_Mnt_Relaciones"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

'CONSTANTES PARA LIST
Const nDescripcion = 1
Const nCodigo = 2
Const nSistema = 3

'CONSTANTES PARA TOOLBAR DE AGRAGAR O QUITAR ELEMENTOS
Const Btn_Agregar = 1
Const Btn_Quitar = 2

'CONSTANTES DE LA TOOLBAR
Const Btn_Buscar = 1
Const Btn_Grabar = 2
Const Btn_Salir = 3

'CONSTANTES DE OBJETO TAB
Const Tab_Cart_Norm = 0
Const Tab_Cart_Fina = 1
Const Tab_Libro = 2
Const Tab_Area_Responsable = 3
Const Tab_Sub_Cartera_Normativa = 4

'COSNTANTES DE OPCION PARA PROCEDIMIENTO SP_ACT_RELACIONES
Const OPC_BORRAR = 1
Const OPC_GRABAR = 2

Sub Proc_Agregar_Quitar_Datos(nOpcion As Integer)
Dim nIndice As Integer
            
    If nOpcion = 1 Then
        If ActiveControl.Name = Lst_Libre(Tab_Carteras.Tab).Name Then
            If Lst_Libre(Tab_Carteras.Tab).ListItems.Count > 0 Then
                If Lst_Libre(Tab_Carteras.Tab).SelectedItem.Checked = True Then
                    Lst_Sel(Tab_Carteras.Tab).ListItems.Add , , Lst_Libre(Tab_Carteras.Tab).SelectedItem
                    Lst_Sel(Tab_Carteras.Tab).ListItems(Lst_Sel(Tab_Carteras.Tab).ListItems.Count).SubItems(1) = Lst_Libre(Tab_Carteras.Tab).ListItems.Item(Lst_Libre(Tab_Carteras.Tab).SelectedItem.Index).SubItems(1)
                    nIndice = Lst_Libre(Tab_Carteras.Tab).SelectedItem.Index
                    Lst_Libre(Tab_Carteras.Tab).ListItems.Remove (Lst_Libre(Tab_Carteras.Tab).SelectedItem.Index)
                    
                    If Lst_Libre(Tab_Carteras.Tab).ListItems.Count > 0 Then
                        Lst_Libre(Tab_Carteras.Tab).ListItems(Lst_Libre(Tab_Carteras.Tab).SelectedItem.Index).Selected = True
                    End If
                    
                End If
            End If
        End If
        
    ElseIf nOpcion = 2 Then
        If ActiveControl.Name = Lst_Sel(Tab_Carteras.Tab).Name Then
    
            If Lst_Sel(Tab_Carteras.Tab).ListItems.Count > 0 Then
                If Lst_Sel(Tab_Carteras.Tab).SelectedItem.Checked = True Then
                    Lst_Libre(Tab_Carteras.Tab).ListItems.Add , , Lst_Sel(Tab_Carteras.Tab).SelectedItem
                    Lst_Libre(Tab_Carteras.Tab).ListItems(Lst_Libre(Tab_Carteras.Tab).ListItems.Count).SubItems(1) = Lst_Sel(Tab_Carteras.Tab).ListItems.Item(Lst_Sel(Tab_Carteras.Tab).SelectedItem.Index).SubItems(1)
                    nIndice = Lst_Sel(Tab_Carteras.Tab).SelectedItem.Index
                    Lst_Sel(Tab_Carteras.Tab).ListItems.Remove (Lst_Sel(Tab_Carteras.Tab).SelectedItem.Index)
                    
                    If Lst_Sel(Tab_Carteras.Tab).ListItems.Count > 0 Then
                        Lst_Sel(Tab_Carteras.Tab).ListItems(Lst_Sel(Tab_Carteras.Tab).SelectedItem.Index).Selected = True
                    End If
                    
                End If
            End If
        End If
    End If
End Sub

Sub Proc_Buscar_Datos(oCombo As Object)
Dim cCodCategoria   As String
Dim nOpcion         As Integer

    If Cmb_Sistema.ListIndex <> -1 Then
    
    
        Select Case Tab_Carteras.Tab
        
            Case Tab_Cart_Norm
                cCodCategoria = GLB_CAT_CARTERA_NORMATIVA
                nOpcion = 1
            
            Case Tab_Cart_Fina
                cCodCategoria = GLB_CAT_CARTERA_FINANCIERA
                nOpcion = 2
                
            Case Tab_Libro
                cCodCategoria = GLB_CAT_LIBRO
                nOpcion = 1
                
            Case Tab_Area_Responsable
                cCodCategoria = GLB_CAT_AREA_RESPONSABLE
                nOpcion = 1
                
            Case Tab_Sub_Cartera_Normativa
                cCodCategoria = GLB_CAT_SUBCARTERA_NORMATIVA
                nOpcion = 1
                
        End Select
        
        Envia = Array()
        AddParam Envia, nOpcion
        AddParam Envia, Trim(Right(oCombo.Text, 10))
        AddParam Envia, cCodCategoria
    
        If Not Bac_Sql_Execute("SP_CON_RELACIONES", Envia) Then
            MsgBox "Problemas al Intentar llanar el combo", vbExclamation + vbOKOnly
            Exit Sub
        End If
      
        Lst_Libre(Tab_Carteras.Tab).FullRowSelect = True
        Lst_Libre(Tab_Carteras.Tab).ListItems.Clear
        Lst_Libre(Tab_Carteras.Tab).ColumnHeaders.Clear
        Lst_Libre(Tab_Carteras.Tab).ColumnHeaders.Add nDescripcion, , "Nombre", 3100
        Lst_Libre(Tab_Carteras.Tab).ColumnHeaders.Add nCodigo, , "Codigo", 0
        
        Lst_Sel(Tab_Carteras.Tab).FullRowSelect = True
        Lst_Sel(Tab_Carteras.Tab).ListItems.Clear
        Lst_Sel(Tab_Carteras.Tab).ColumnHeaders.Clear
        Lst_Sel(Tab_Carteras.Tab).ColumnHeaders.Add nDescripcion, , "Nombre", 3100
        Lst_Sel(Tab_Carteras.Tab).ColumnHeaders.Add nCodigo, , "Codigo", 0
        
        
                     
        Do While Bac_SQL_Fetch(Datos())
            If Datos(nSistema) = "" Then
                With Lst_Libre(Tab_Carteras.Tab)
                    .ListItems.Add , , Trim(Datos(nDescripcion))
                    .ListItems(.ListItems.Count).SubItems(1) = Datos(nCodigo)
                End With
            Else
                With Lst_Sel(Tab_Carteras.Tab)
                    .ListItems.Add , , Trim(Datos(nDescripcion))
                    .ListItems(.ListItems.Count).SubItems(1) = Datos(nCodigo)
                End With
            End If
        Loop

        Tlb_Herramientas.Buttons(Btn_Grabar).Enabled = True
    
    End If

End Sub



Sub Proc_Grabar_Datos(oCombo As Object)
    Dim nContador As Integer
    Dim bRespuesta As Boolean
  
    With Lst_Sel(Tab_Carteras.Tab)
    
        Screen.MousePointer = vbHourglass
    
        If Not Bac_Sql_Execute("BEGIN TRANSACTION") Then
            Screen.MousePointer = vbDefault
            MsgBox "Ha ocurrido un error al intentar grabar las relaciones", vbCritical, "BacParametros"
            Exit Sub
        End If
        
        Envia = Array()
        AddParam Envia, OPC_BORRAR
        AddParam Envia, Trim(Right(oCombo.Text, 10))
        
        Select Case Tab_Carteras.Tab
      
            Case Tab_Cart_Norm
                AddParam Envia, GLB_CAT_CARTERA_NORMATIVA
                           
            Case Tab_Cart_Fina
                AddParam Envia, GLB_CAT_CARTERA_FINANCIERA
                                
            Case Tab_Libro
                AddParam Envia, GLB_CAT_LIBRO
                                
            Case Tab_Area_Responsable
                AddParam Envia, GLB_CAT_AREA_RESPONSABLE
                                
            Case Tab_Sub_Cartera_Normativa
                AddParam Envia, GLB_CAT_SUBCARTERA_NORMATIVA
                               
        End Select
        
        AddParam Envia, ""
        
        If Not Bac_Sql_Execute("SP_ACT_RELACIONES", Envia) Then
            bRespuesta = Bac_Sql_Execute("ROLLBACK TRANSACTION")
            
            Screen.MousePointer = vbDefault
            MsgBox "Ha ocurrido un error al intentar grabar las relaciones", vbCritical, "BacParametros"
            Screen.MousePointer = vbDefault
            Exit Sub
        End If

        If .ListItems.Count > 0 Then
            
            For nContador = 1 To .ListItems.Count
                Envia = Array()
                AddParam Envia, OPC_GRABAR
                AddParam Envia, Trim(Right(oCombo.Text, 10))
                              
                Select Case Tab_Carteras.Tab
                
                    Case Tab_Cart_Norm
                        AddParam Envia, GLB_CAT_CARTERA_NORMATIVA
                                    
                    Case Tab_Cart_Fina
                        AddParam Envia, GLB_CAT_CARTERA_FINANCIERA
                                         
                    Case Tab_Libro
                        AddParam Envia, GLB_CAT_LIBRO
                                         
                    Case Tab_Area_Responsable
                        AddParam Envia, GLB_CAT_AREA_RESPONSABLE
                                         
                    Case Tab_Sub_Cartera_Normativa
                        AddParam Envia, GLB_CAT_SUBCARTERA_NORMATIVA
                                        
                End Select
                
                AddParam Envia, .ListItems(nContador).SubItems(1)
                
                If Not Bac_Sql_Execute("SP_ACT_RELACIONES", Envia) Then
                    bRespuesta = Bac_Sql_Execute("ROLLBACK TRANSACTION")
                    
                    Screen.MousePointer = vbDefault
                    MsgBox "Ha ocurrido un error al intentar grabar las relaciones", vbCritical, "BacParametros"
                    Screen.MousePointer = vbDefault
                    Exit Sub
                End If
                
            Next nContador
    
        End If
        
        If Not Bac_Sql_Execute("COMMIT TRANSACTION") Then
            Screen.MousePointer = vbDefault
            MsgBox "Ha ocurrido un error al intentar grabar las relaciones", vbCritical, "BacParametros"
            Exit Sub
        End If
        
        Screen.MousePointer = vbDefault
        MsgBox "La informacion informacion ha sido grabada con exito", vbOKOnly + vbInformation
        Lst_Libre(Tab_Carteras.Tab).ListItems.Clear
        Lst_Sel(Tab_Carteras.Tab).ListItems.Clear
        Tlb_Herramientas.Buttons(Btn_Grabar).Enabled = False
        
    End With
    
End Sub

Private Sub Cmb_Cartera_Click()
    Lst_Libre(Tab_Carteras.Tab).ListItems.Clear
    Lst_Sel(Tab_Carteras.Tab).ListItems.Clear
    Tlb_Herramientas.Buttons(Btn_Grabar).Enabled = False

End Sub

Private Sub Cmb_Sistema_Click()
    Lst_Libre(Tab_Carteras.Tab).ListItems.Clear
    Lst_Sel(Tab_Carteras.Tab).ListItems.Clear
    Tlb_Herramientas.Buttons(Btn_Grabar).Enabled = False
End Sub

Private Sub Form_Load()

    Tlb_Herramientas.Buttons(Btn_Grabar).Enabled = False
    Tab_Carteras.Tab = 0
    
    Call PROC_LLENA_COMBOS("Sp_CmbSistema", Array(), Cmb_Sistema, False, 1, 2)
    
    Envia = Array()
    AddParam Envia, 1
    AddParam Envia, GLB_CAT_CARTERA_NORMATIVA
    
    Call PROC_LLENA_COMBOS("Sp_Con_Info_Combo", Envia, Cmb_Cartera, False, 2, 6)
              
    Tab_Carteras.Tab = Tab_Cart_Norm
    
    Tab_Carteras.TabVisible(Tab_Cart_Fina) = False
    Tab_Carteras.TabVisible(Tab_Libro) = False
    Tab_Carteras.TabVisible(Tab_Cart_Norm) = False
    Cmb_Sistema.Visible = True
    Cmb_Cartera.Visible = False

     
End Sub




Private Sub ListView2_BeforeLabelEdit(Cancel As Integer)

End Sub

Private Sub Tab_Carteras_Click(PreviousTab As Integer)
    If Tab_Carteras.Tab <> Tab_Sub_Cartera_Normativa Then
        Fr_Combo.Caption = "Sistema"
        Cmb_Sistema.Visible = True
        Cmb_Cartera.Visible = False
    Else
        Fr_Combo.Caption = "Cartera Normativa"
        Cmb_Sistema.Visible = False
        Cmb_Cartera.Visible = True
    End If
    
End Sub

Private Sub Tlb_AgregaQuita_ButtonClick(ByVal Button As MSComctlLib.Button)

    Select Case Button.Index
    
        Case Btn_Agregar
            Proc_Agregar_Quitar_Datos (Btn_Agregar)
        
        Case Btn_Quitar
            Proc_Agregar_Quitar_Datos (Btn_Quitar)
            
    End Select


End Sub



Private Sub Toolbar2_ButtonClick(ByVal Button As MSComctlLib.Button)

End Sub


Private Sub Tlb_AgregaQuita2_ButtonClick(ByVal Button As MSComctlLib.Button)

    Select Case Button.Index
    
        Case Btn_Agregar
            Proc_Agregar_Quitar_Datos (Btn_Agregar)
        
        Case Btn_Quitar
            Proc_Agregar_Quitar_Datos (Btn_Quitar)
            
    End Select


End Sub

Private Sub Tlb_AgregaQuita3_ButtonClick(ByVal Button As MSComctlLib.Button)

    Select Case Button.Index
    
        Case Btn_Agregar
            Proc_Agregar_Quitar_Datos (Btn_Agregar)
        
        Case Btn_Quitar
            Proc_Agregar_Quitar_Datos (Btn_Quitar)
            
    End Select

End Sub


Private Sub Tlb_AgregaQuita4_ButtonClick(ByVal Button As MSComctlLib.Button)

    Select Case Button.Index
    
        Case Btn_Agregar
            Proc_Agregar_Quitar_Datos (Btn_Agregar)
        
        Case Btn_Quitar
            Proc_Agregar_Quitar_Datos (Btn_Quitar)
            
    End Select

End Sub

Private Sub Tlb_AgregaQuita5_ButtonClick(ByVal Button As MSComctlLib.Button)

    Select Case Button.Index
    
        Case Btn_Agregar
            Proc_Agregar_Quitar_Datos (Btn_Agregar)
        
        Case Btn_Quitar
            Proc_Agregar_Quitar_Datos (Btn_Quitar)
            
    End Select

End Sub


Private Sub Tlb_Herramientas_ButtonClick(ByVal Button As MSComctlLib.Button)

    Select Case Button.Index
        Case Btn_Buscar
            Call Proc_Buscar_Datos(IIf(Tab_Carteras.Tab <> Tab_Sub_Cartera_Normativa, Cmb_Sistema, Cmb_Cartera))
        
        Case Btn_Grabar
            Call Proc_Grabar_Datos(IIf(Tab_Carteras.Tab <> Tab_Sub_Cartera_Normativa, Cmb_Sistema, Cmb_Cartera))
        
        Case Btn_Salir
            Unload Me

    End Select

End Sub


