VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.2#0"; "mscomctl.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{BDC217C8-ED16-11CD-956C-0000C04E4C0A}#1.1#0"; "TABCTL32.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacMntClie 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantención de Clientes "
   ClientHeight    =   7395
   ClientLeft      =   2865
   ClientTop       =   945
   ClientWidth     =   8760
   Icon            =   "BacMntClie.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   7395
   ScaleWidth      =   8760
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   104
      Top             =   0
      Width           =   8760
      _ExtentX        =   15452
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   5
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Eliminar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Object.ToolTipText     =   "Relación"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   5
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Cód. Contable"
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
         Height          =   195
         Index           =   1
         Left            =   7095
         TabIndex        =   105
         Top             =   630
         Width           =   1215
      End
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   4200
      Top             =   90
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   5
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMntClie.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMntClie.frx":075C
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMntClie.frx":0BAE
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMntClie.frx":0EC8
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMntClie.frx":11E2
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin VB.Frame Fr_Avales 
      ForeColor       =   &H8000000D&
      Height          =   6090
      Left            =   7485
      TabIndex        =   180
      Top             =   5955
      Visible         =   0   'False
      Width           =   8685
      Begin VB.ComboBox cmbCantAvales 
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
         Height          =   315
         Left            =   7410
         Style           =   2  'Dropdown List
         TabIndex        =   182
         Top             =   675
         Width           =   990
      End
      Begin VB.CommandButton Cmd_VolverAval 
         Caption         =   "Volver"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   570
         Left            =   7485
         Picture         =   "BacMntClie.frx":14FC
         TabIndex        =   181
         ToolTipText     =   "Volver"
         Top             =   5445
         Width           =   1110
      End
      Begin TabDlg.SSTab SSTab2 
         Height          =   5805
         Left            =   60
         TabIndex        =   189
         Top             =   240
         Visible         =   0   'False
         Width           =   7005
         _ExtentX        =   12356
         _ExtentY        =   10239
         _Version        =   393216
         Tabs            =   5
         TabsPerRow      =   5
         TabHeight       =   520
         ForeColor       =   8388608
         TabCaption(0)   =   "Aval 1"
         TabPicture(0)   =   "BacMntClie.frx":1E3E
         Tab(0).ControlEnabled=   -1  'True
         Tab(0).Control(0)=   "Frame7(0)"
         Tab(0).Control(0).Enabled=   0   'False
         Tab(0).ControlCount=   1
         TabCaption(1)   =   "Aval 2"
         TabPicture(1)   =   "BacMntClie.frx":1E5A
         Tab(1).ControlEnabled=   0   'False
         Tab(1).Control(0)=   "Frame7(1)"
         Tab(1).ControlCount=   1
         TabCaption(2)   =   "Aval 3"
         TabPicture(2)   =   "BacMntClie.frx":1E76
         Tab(2).ControlEnabled=   0   'False
         Tab(2).Control(0)=   "Frame7(2)"
         Tab(2).ControlCount=   1
         TabCaption(3)   =   "Aval 4"
         TabPicture(3)   =   "BacMntClie.frx":1E92
         Tab(3).ControlEnabled=   0   'False
         Tab(3).Control(0)=   "Frame7(3)"
         Tab(3).ControlCount=   1
         TabCaption(4)   =   "Aval 5"
         TabPicture(4)   =   "BacMntClie.frx":1EAE
         Tab(4).ControlEnabled=   0   'False
         Tab(4).Control(0)=   "Frame7(4)"
         Tab(4).ControlCount=   1
         Begin VB.Frame Frame7 
            Height          =   5385
            Index           =   4
            Left            =   -74940
            TabIndex        =   254
            Top             =   330
            Width           =   6885
            Begin VB.ComboBox Cmb_RegimenConyugal 
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
               Height          =   315
               Index           =   4
               Left            =   2520
               Style           =   2  'Dropdown List
               TabIndex        =   76
               Top             =   780
               Width           =   4260
            End
            Begin VB.CheckBox chkEliminaAval 
               Caption         =   "Elimina Aval"
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
               Index           =   4
               Left            =   5415
               TabIndex        =   255
               Top             =   195
               Width           =   1380
            End
            Begin VB.TextBox txtProfConyuge 
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
               Index           =   4
               Left            =   2520
               MaxLength       =   50
               TabIndex        =   90
               Top             =   5040
               Width           =   4275
            End
            Begin VB.TextBox txtNomConyAval 
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
               Index           =   4
               Left            =   2520
               MaxLength       =   70
               TabIndex        =   89
               Top             =   4740
               Width           =   4260
            End
            Begin VB.TextBox txtDvConyAval 
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
               Index           =   4
               Left            =   3735
               MaxLength       =   1
               TabIndex        =   88
               Top             =   4440
               Width           =   255
            End
            Begin VB.TextBox txtRutConyAval 
               Alignment       =   1  'Right Justify
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
               Index           =   4
               Left            =   2520
               MaxLength       =   9
               MouseIcon       =   "BacMntClie.frx":1ECA
               MultiLine       =   -1  'True
               TabIndex        =   87
               Top             =   4440
               Width           =   1125
            End
            Begin VB.TextBox txtNomApode2 
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
               Index           =   4
               Left            =   2520
               MaxLength       =   70
               TabIndex        =   86
               Top             =   3690
               Width           =   4260
            End
            Begin VB.TextBox txtDvApode2 
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
               Index           =   4
               Left            =   3735
               MaxLength       =   1
               TabIndex        =   85
               Top             =   3390
               Width           =   255
            End
            Begin VB.TextBox txtRutApode2 
               Alignment       =   1  'Right Justify
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
               Index           =   4
               Left            =   2520
               MaxLength       =   9
               MouseIcon       =   "BacMntClie.frx":21D4
               MultiLine       =   -1  'True
               TabIndex        =   84
               Top             =   3390
               Width           =   1125
            End
            Begin VB.TextBox txtNomApode1 
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
               Index           =   4
               Left            =   2520
               MaxLength       =   70
               TabIndex        =   83
               Top             =   3090
               Width           =   4260
            End
            Begin VB.TextBox txtDvApode1 
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
               Index           =   4
               Left            =   3735
               MaxLength       =   1
               TabIndex        =   82
               Top             =   2790
               Width           =   255
            End
            Begin VB.TextBox txtRutApode1 
               Alignment       =   1  'Right Justify
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
               Index           =   4
               Left            =   2520
               MaxLength       =   9
               MouseIcon       =   "BacMntClie.frx":24DE
               MultiLine       =   -1  'True
               TabIndex        =   81
               Top             =   2790
               Width           =   1125
            End
            Begin VB.ComboBox CmbCiudadAval 
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
               Height          =   315
               Index           =   4
               Left            =   2520
               Style           =   2  'Dropdown List
               TabIndex        =   79
               Top             =   1710
               Width           =   2385
            End
            Begin VB.ComboBox cmbComunaAval 
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
               Height          =   315
               Index           =   4
               Left            =   2520
               Style           =   2  'Dropdown List
               TabIndex        =   80
               Top             =   2040
               Width           =   2385
            End
            Begin VB.TextBox txtDirenAval 
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
               Index           =   4
               Left            =   2520
               MaxLength       =   40
               TabIndex        =   78
               Top             =   1410
               Width           =   4260
            End
            Begin VB.TextBox txtProfeAval 
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
               Index           =   4
               Left            =   2520
               MaxLength       =   50
               TabIndex        =   77
               Top             =   1110
               Width           =   4260
            End
            Begin VB.TextBox txtNombreAval 
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
               Index           =   4
               Left            =   2520
               MaxLength       =   70
               TabIndex        =   75
               Top             =   480
               Width           =   4260
            End
            Begin VB.TextBox txtDvAval 
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
               Index           =   4
               Left            =   3705
               MaxLength       =   1
               TabIndex        =   74
               Top             =   180
               Width           =   255
            End
            Begin VB.TextBox txtRutAval 
               Alignment       =   1  'Right Justify
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
               Index           =   4
               Left            =   2520
               MaxLength       =   9
               MouseIcon       =   "BacMntClie.frx":27E8
               MultiLine       =   -1  'True
               TabIndex        =   73
               Top             =   180
               Width           =   1125
            End
            Begin VB.Label Label11 
               Caption         =   "Apoderados del Aval (sólo personas jurídicas)"
               BeginProperty Font 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   -1  'True
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00800000&
               Height          =   225
               Left            =   120
               TabIndex        =   322
               Top             =   2490
               Width           =   6690
            End
            Begin VB.Label Label10 
               Caption         =   "Cónyuge del Aval (sólo personas naturales)"
               BeginProperty Font 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   -1  'True
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00800000&
               Height          =   225
               Left            =   120
               TabIndex        =   321
               Top             =   4140
               Width           =   6690
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Profesión Conyuge"
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
               Height          =   195
               Index           =   112
               Left            =   120
               TabIndex        =   269
               Top             =   5085
               Width           =   1605
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Estado Civil"
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
               Height          =   195
               Index           =   111
               Left            =   120
               TabIndex        =   268
               Top             =   840
               Width           =   1020
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Nombre Conyuge"
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
               Height          =   195
               Index           =   110
               Left            =   120
               TabIndex        =   267
               Top             =   4815
               Width           =   1455
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "R.U.T. Conyuge"
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
               Height          =   195
               Index           =   109
               Left            =   120
               TabIndex        =   266
               Top             =   4500
               Width           =   1380
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Nombre Apoderado 2"
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
               Height          =   195
               Index           =   107
               Left            =   120
               TabIndex        =   265
               Top             =   3750
               Width           =   1800
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "R.U.T. Apoderado 2"
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
               Height          =   195
               Index           =   106
               Left            =   120
               TabIndex        =   264
               Top             =   3450
               Width           =   1725
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Nombre Apoderado 1"
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
               Height          =   195
               Index           =   105
               Left            =   120
               TabIndex        =   263
               Top             =   3150
               Width           =   1800
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "R.U.T. Apoderado 1"
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
               Height          =   195
               Index           =   104
               Left            =   120
               TabIndex        =   262
               Top             =   2850
               Width           =   1725
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Ciudad"
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
               Height          =   195
               Index           =   103
               Left            =   120
               TabIndex        =   261
               Top             =   1785
               Width           =   600
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Comuna"
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
               Height          =   195
               Index           =   102
               Left            =   120
               TabIndex        =   260
               Top             =   2085
               Width           =   690
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Dirección"
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
               Height          =   195
               Index           =   101
               Left            =   120
               TabIndex        =   259
               Top             =   1455
               Width           =   825
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Profesión"
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
               Height          =   195
               Index           =   100
               Left            =   120
               TabIndex        =   258
               Top             =   1155
               Width           =   810
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Razon Social / Nombre"
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
               Height          =   195
               Index           =   98
               Left            =   120
               TabIndex        =   257
               Top             =   555
               Width           =   1995
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "R.U.T."
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
               Height          =   195
               Index           =   97
               Left            =   120
               TabIndex        =   256
               Top             =   240
               Width           =   585
            End
         End
         Begin VB.Frame Frame7 
            Height          =   5385
            Index           =   3
            Left            =   -74940
            TabIndex        =   238
            Top             =   330
            Width           =   6885
            Begin VB.ComboBox Cmb_RegimenConyugal 
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
               Height          =   315
               Index           =   3
               Left            =   2520
               Style           =   2  'Dropdown List
               TabIndex        =   58
               Top             =   780
               Width           =   4260
            End
            Begin VB.CheckBox chkEliminaAval 
               Caption         =   "Elimina Aval"
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
               Index           =   3
               Left            =   5415
               TabIndex        =   239
               Top             =   195
               Width           =   1380
            End
            Begin VB.TextBox txtProfConyuge 
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
               Index           =   3
               Left            =   2520
               MaxLength       =   50
               TabIndex        =   72
               Top             =   5040
               Width           =   4275
            End
            Begin VB.TextBox txtNomConyAval 
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
               Index           =   3
               Left            =   2520
               MaxLength       =   70
               TabIndex        =   71
               Top             =   4740
               Width           =   4260
            End
            Begin VB.TextBox txtDvConyAval 
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
               Index           =   3
               Left            =   3735
               MaxLength       =   1
               TabIndex        =   70
               Top             =   4440
               Width           =   255
            End
            Begin VB.TextBox txtRutConyAval 
               Alignment       =   1  'Right Justify
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
               Index           =   3
               Left            =   2520
               MaxLength       =   9
               MouseIcon       =   "BacMntClie.frx":2AF2
               MultiLine       =   -1  'True
               TabIndex        =   69
               Top             =   4440
               Width           =   1125
            End
            Begin VB.TextBox txtNomApode2 
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
               Index           =   3
               Left            =   2520
               MaxLength       =   70
               TabIndex        =   68
               Top             =   3690
               Width           =   4260
            End
            Begin VB.TextBox txtDvApode2 
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
               Index           =   3
               Left            =   3735
               MaxLength       =   1
               TabIndex        =   67
               Top             =   3390
               Width           =   255
            End
            Begin VB.TextBox txtRutApode2 
               Alignment       =   1  'Right Justify
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
               Index           =   3
               Left            =   2520
               MaxLength       =   9
               MouseIcon       =   "BacMntClie.frx":2DFC
               MultiLine       =   -1  'True
               TabIndex        =   66
               Top             =   3390
               Width           =   1125
            End
            Begin VB.TextBox txtNomApode1 
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
               Index           =   3
               Left            =   2520
               MaxLength       =   70
               TabIndex        =   65
               Top             =   3090
               Width           =   4260
            End
            Begin VB.TextBox txtDvApode1 
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
               Index           =   3
               Left            =   3735
               MaxLength       =   1
               TabIndex        =   64
               Top             =   2790
               Width           =   255
            End
            Begin VB.TextBox txtRutApode1 
               Alignment       =   1  'Right Justify
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
               Index           =   3
               Left            =   2505
               MaxLength       =   9
               MouseIcon       =   "BacMntClie.frx":3106
               MultiLine       =   -1  'True
               TabIndex        =   63
               Top             =   2775
               Width           =   1125
            End
            Begin VB.ComboBox CmbCiudadAval 
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
               Height          =   315
               Index           =   3
               Left            =   2520
               Style           =   2  'Dropdown List
               TabIndex        =   61
               Top             =   1710
               Width           =   2385
            End
            Begin VB.ComboBox cmbComunaAval 
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
               Height          =   315
               Index           =   3
               Left            =   2520
               Style           =   2  'Dropdown List
               TabIndex        =   62
               Top             =   2040
               Width           =   2385
            End
            Begin VB.TextBox txtDirenAval 
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
               Index           =   3
               Left            =   2490
               MaxLength       =   40
               TabIndex        =   60
               Top             =   1410
               Width           =   4260
            End
            Begin VB.TextBox txtProfeAval 
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
               Index           =   3
               Left            =   2520
               MaxLength       =   50
               TabIndex        =   59
               Top             =   1110
               Width           =   4260
            End
            Begin VB.TextBox txtNombreAval 
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
               Index           =   3
               Left            =   2520
               MaxLength       =   70
               TabIndex        =   57
               Top             =   480
               Width           =   4260
            End
            Begin VB.TextBox txtDvAval 
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
               Index           =   3
               Left            =   3705
               MaxLength       =   1
               TabIndex        =   56
               Top             =   180
               Width           =   255
            End
            Begin VB.TextBox txtRutAval 
               Alignment       =   1  'Right Justify
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
               Index           =   3
               Left            =   2520
               MaxLength       =   9
               MouseIcon       =   "BacMntClie.frx":3410
               MultiLine       =   -1  'True
               TabIndex        =   55
               Top             =   180
               Width           =   1125
            End
            Begin VB.Label Label13 
               Caption         =   "Apoderados del Aval (sólo personas jurídicas)"
               BeginProperty Font 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   -1  'True
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00800000&
               Height          =   225
               Left            =   120
               TabIndex        =   320
               Top             =   2490
               Width           =   6690
            End
            Begin VB.Label Label12 
               Caption         =   "Cónyuge del Aval (sólo personas naturales)"
               BeginProperty Font 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   -1  'True
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00800000&
               Height          =   225
               Left            =   120
               TabIndex        =   319
               Top             =   4140
               Width           =   6690
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Profesión Conyuge"
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
               Height          =   195
               Index           =   96
               Left            =   120
               TabIndex        =   253
               Top             =   5085
               Width           =   1605
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Estado Civil"
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
               Height          =   195
               Index           =   95
               Left            =   120
               TabIndex        =   252
               Top             =   840
               Width           =   1020
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Nombre Conyuge"
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
               Height          =   195
               Index           =   94
               Left            =   120
               TabIndex        =   251
               Top             =   4815
               Width           =   1455
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "R.U.T. Conyuge"
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
               Height          =   195
               Index           =   93
               Left            =   120
               TabIndex        =   250
               Top             =   4500
               Width           =   1380
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Nombre Apoderado 2"
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
               Height          =   195
               Index           =   92
               Left            =   120
               TabIndex        =   249
               Top             =   3750
               Width           =   1800
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "R.U.T. Apoderado 2"
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
               Height          =   195
               Index           =   91
               Left            =   120
               TabIndex        =   248
               Top             =   3450
               Width           =   1725
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Nombre Apoderado 1"
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
               Height          =   195
               Index           =   90
               Left            =   120
               TabIndex        =   247
               Top             =   3150
               Width           =   1800
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "R.U.T. Apoderado 1"
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
               Height          =   195
               Index           =   89
               Left            =   120
               TabIndex        =   246
               Top             =   2850
               Width           =   1725
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Ciudad"
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
               Height          =   195
               Index           =   88
               Left            =   120
               TabIndex        =   245
               Top             =   1785
               Width           =   600
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Comuna"
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
               Height          =   195
               Index           =   87
               Left            =   120
               TabIndex        =   244
               Top             =   2085
               Width           =   690
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Dirección"
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
               Height          =   195
               Index           =   86
               Left            =   120
               TabIndex        =   243
               Top             =   1455
               Width           =   825
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Profesión"
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
               Height          =   195
               Index           =   85
               Left            =   120
               TabIndex        =   242
               Top             =   1155
               Width           =   810
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Razon Social / Nombre"
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
               Height          =   195
               Index           =   83
               Left            =   120
               TabIndex        =   241
               Top             =   555
               Width           =   1995
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "R.U.T."
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
               Height          =   195
               Index           =   82
               Left            =   120
               TabIndex        =   240
               Top             =   240
               Width           =   585
            End
         End
         Begin VB.Frame Frame7 
            Height          =   5385
            Index           =   2
            Left            =   -74940
            TabIndex        =   222
            Top             =   330
            Width           =   6885
            Begin VB.ComboBox Cmb_RegimenConyugal 
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
               Height          =   315
               Index           =   2
               Left            =   2520
               Style           =   2  'Dropdown List
               TabIndex        =   39
               Top             =   780
               Width           =   4260
            End
            Begin VB.CheckBox chkEliminaAval 
               Caption         =   "Elimina Aval"
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
               Index           =   2
               Left            =   5415
               TabIndex        =   223
               Top             =   195
               Width           =   1380
            End
            Begin VB.TextBox txtProfConyuge 
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
               Index           =   2
               Left            =   2520
               MaxLength       =   50
               TabIndex        =   53
               Top             =   5040
               Width           =   4275
            End
            Begin VB.TextBox txtNomConyAval 
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
               Index           =   2
               Left            =   2520
               MaxLength       =   70
               TabIndex        =   52
               Top             =   4740
               Width           =   4260
            End
            Begin VB.TextBox txtDvConyAval 
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
               Index           =   2
               Left            =   3735
               MaxLength       =   1
               TabIndex        =   51
               Top             =   4440
               Width           =   255
            End
            Begin VB.TextBox txtRutConyAval 
               Alignment       =   1  'Right Justify
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
               Index           =   2
               Left            =   2520
               MaxLength       =   9
               MouseIcon       =   "BacMntClie.frx":371A
               MultiLine       =   -1  'True
               TabIndex        =   50
               Top             =   4440
               Width           =   1125
            End
            Begin VB.TextBox txtNomApode2 
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
               Index           =   2
               Left            =   2520
               MaxLength       =   70
               TabIndex        =   49
               Top             =   3690
               Width           =   4260
            End
            Begin VB.TextBox txtDvApode2 
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
               Index           =   2
               Left            =   3735
               MaxLength       =   1
               TabIndex        =   48
               Top             =   3390
               Width           =   255
            End
            Begin VB.TextBox txtRutApode2 
               Alignment       =   1  'Right Justify
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
               Index           =   2
               Left            =   2520
               MaxLength       =   9
               MouseIcon       =   "BacMntClie.frx":3A24
               MultiLine       =   -1  'True
               TabIndex        =   99
               Top             =   3390
               Width           =   1125
            End
            Begin VB.TextBox txtNomApode1 
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
               Index           =   2
               Left            =   2520
               MaxLength       =   70
               TabIndex        =   46
               Top             =   3090
               Width           =   4260
            End
            Begin VB.TextBox txtDvApode1 
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
               Index           =   2
               Left            =   3735
               MaxLength       =   1
               TabIndex        =   45
               Top             =   2790
               Width           =   255
            End
            Begin VB.TextBox txtRutApode1 
               Alignment       =   1  'Right Justify
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
               Index           =   2
               Left            =   2520
               MaxLength       =   9
               MouseIcon       =   "BacMntClie.frx":3D2E
               MultiLine       =   -1  'True
               TabIndex        =   44
               Top             =   2790
               Width           =   1125
            End
            Begin VB.ComboBox CmbCiudadAval 
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
               Height          =   315
               Index           =   2
               Left            =   2520
               Style           =   2  'Dropdown List
               TabIndex        =   42
               Top             =   1710
               Width           =   2385
            End
            Begin VB.ComboBox cmbComunaAval 
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
               Height          =   315
               Index           =   2
               Left            =   2520
               Style           =   2  'Dropdown List
               TabIndex        =   43
               Top             =   2040
               Width           =   2385
            End
            Begin VB.TextBox txtDirenAval 
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
               Index           =   2
               Left            =   2520
               MaxLength       =   40
               TabIndex        =   41
               Top             =   1410
               Width           =   4260
            End
            Begin VB.TextBox txtProfeAval 
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
               Index           =   2
               Left            =   2520
               MaxLength       =   50
               TabIndex        =   40
               Top             =   1110
               Width           =   4260
            End
            Begin VB.TextBox txtNombreAval 
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
               Index           =   2
               Left            =   2520
               MaxLength       =   70
               TabIndex        =   38
               Top             =   480
               Width           =   4260
            End
            Begin VB.TextBox txtDvAval 
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
               Index           =   2
               Left            =   3705
               MaxLength       =   1
               TabIndex        =   37
               Top             =   180
               Width           =   255
            End
            Begin VB.TextBox txtRutAval 
               Alignment       =   1  'Right Justify
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
               Index           =   2
               Left            =   2520
               MaxLength       =   9
               MouseIcon       =   "BacMntClie.frx":4038
               MultiLine       =   -1  'True
               TabIndex        =   36
               Top             =   180
               Width           =   1125
            End
            Begin VB.Label Label9 
               Caption         =   "Apoderados del Aval (sólo personas jurídicas)"
               BeginProperty Font 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   -1  'True
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00800000&
               Height          =   225
               Left            =   120
               TabIndex        =   318
               Top             =   2490
               Width           =   6690
            End
            Begin VB.Label Label8 
               Caption         =   "Cónyuge del Aval (sólo personas naturales)"
               BeginProperty Font 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   -1  'True
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00800000&
               Height          =   225
               Left            =   120
               TabIndex        =   317
               Top             =   4140
               Width           =   6690
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Profesión Conyuge"
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
               Height          =   195
               Index           =   81
               Left            =   120
               TabIndex        =   237
               Top             =   5085
               Width           =   1605
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Estado Civil"
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
               Height          =   195
               Index           =   80
               Left            =   120
               TabIndex        =   236
               Top             =   840
               Width           =   1020
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Nombre Conyuge"
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
               Height          =   195
               Index           =   79
               Left            =   120
               TabIndex        =   235
               Top             =   4815
               Width           =   1455
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "R.U.T. Conyuge"
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
               Height          =   195
               Index           =   78
               Left            =   120
               TabIndex        =   234
               Top             =   4500
               Width           =   1380
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Nombre Apoderado 2"
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
               Height          =   195
               Index           =   77
               Left            =   120
               TabIndex        =   233
               Top             =   3750
               Width           =   1800
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "R.U.T. Apoderado 2"
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
               Height          =   195
               Index           =   76
               Left            =   120
               TabIndex        =   232
               Top             =   3450
               Width           =   1725
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Nombre Apoderado 1"
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
               Height          =   195
               Index           =   75
               Left            =   120
               TabIndex        =   231
               Top             =   3150
               Width           =   1800
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "R.U.T. Apoderado 1"
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
               Height          =   195
               Index           =   74
               Left            =   120
               TabIndex        =   230
               Top             =   2850
               Width           =   1725
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Ciudad"
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
               Height          =   195
               Index           =   73
               Left            =   120
               TabIndex        =   229
               Top             =   1785
               Width           =   600
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Comuna"
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
               Height          =   195
               Index           =   72
               Left            =   120
               TabIndex        =   228
               Top             =   2085
               Width           =   690
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Dirección"
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
               Height          =   195
               Index           =   71
               Left            =   120
               TabIndex        =   227
               Top             =   1455
               Width           =   825
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Profesión"
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
               Height          =   195
               Index           =   70
               Left            =   120
               TabIndex        =   226
               Top             =   1155
               Width           =   810
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Razon Social / Nombre"
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
               Height          =   195
               Index           =   68
               Left            =   120
               TabIndex        =   225
               Top             =   555
               Width           =   1995
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "R.U.T."
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
               Height          =   195
               Index           =   67
               Left            =   120
               TabIndex        =   224
               Top             =   240
               Width           =   585
            End
         End
         Begin VB.Frame Frame7 
            Height          =   5385
            Index           =   1
            Left            =   -74940
            TabIndex        =   206
            Top             =   330
            Width           =   6885
            Begin VB.ComboBox Cmb_RegimenConyugal 
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
               Height          =   315
               Index           =   1
               Left            =   2520
               Style           =   2  'Dropdown List
               TabIndex        =   21
               Top             =   780
               Width           =   4260
            End
            Begin VB.CheckBox chkEliminaAval 
               Caption         =   "Elimina Aval"
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
               Index           =   1
               Left            =   5415
               TabIndex        =   207
               Top             =   195
               Width           =   1365
            End
            Begin VB.TextBox txtProfConyuge 
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
               Index           =   1
               Left            =   2520
               MaxLength       =   50
               TabIndex        =   35
               Top             =   5040
               Width           =   4275
            End
            Begin VB.TextBox txtNomConyAval 
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
               Index           =   1
               Left            =   2520
               MaxLength       =   70
               TabIndex        =   34
               Top             =   4740
               Width           =   4260
            End
            Begin VB.TextBox txtDvConyAval 
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
               Index           =   1
               Left            =   3735
               MaxLength       =   1
               TabIndex        =   33
               Top             =   4440
               Width           =   255
            End
            Begin VB.TextBox txtRutConyAval 
               Alignment       =   1  'Right Justify
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
               Index           =   1
               Left            =   2520
               MaxLength       =   9
               MouseIcon       =   "BacMntClie.frx":4342
               MultiLine       =   -1  'True
               TabIndex        =   32
               Top             =   4440
               Width           =   1125
            End
            Begin VB.TextBox txtNomApode2 
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
               Index           =   1
               Left            =   2520
               MaxLength       =   70
               TabIndex        =   31
               Top             =   3690
               Width           =   4260
            End
            Begin VB.TextBox txtDvApode2 
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
               Index           =   1
               Left            =   3735
               MaxLength       =   1
               TabIndex        =   30
               Top             =   3390
               Width           =   255
            End
            Begin VB.TextBox txtRutApode2 
               Alignment       =   1  'Right Justify
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
               Index           =   1
               Left            =   2520
               MaxLength       =   9
               MouseIcon       =   "BacMntClie.frx":464C
               MultiLine       =   -1  'True
               TabIndex        =   29
               Top             =   3390
               Width           =   1125
            End
            Begin VB.TextBox txtNomApode1 
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
               Index           =   1
               Left            =   2520
               MaxLength       =   70
               TabIndex        =   28
               Top             =   3090
               Width           =   4260
            End
            Begin VB.TextBox txtDvApode1 
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
               Index           =   1
               Left            =   3735
               MaxLength       =   1
               TabIndex        =   27
               Top             =   2790
               Width           =   255
            End
            Begin VB.TextBox txtRutApode1 
               Alignment       =   1  'Right Justify
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
               Index           =   1
               Left            =   2520
               MaxLength       =   9
               MouseIcon       =   "BacMntClie.frx":4956
               MultiLine       =   -1  'True
               TabIndex        =   26
               Top             =   2790
               Width           =   1125
            End
            Begin VB.ComboBox CmbCiudadAval 
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
               Height          =   315
               Index           =   1
               Left            =   2520
               Style           =   2  'Dropdown List
               TabIndex        =   24
               Top             =   1710
               Width           =   2385
            End
            Begin VB.ComboBox cmbComunaAval 
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
               Height          =   315
               Index           =   1
               Left            =   2520
               Style           =   2  'Dropdown List
               TabIndex        =   25
               Top             =   2040
               Width           =   2385
            End
            Begin VB.TextBox txtDirenAval 
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
               Index           =   1
               Left            =   2520
               MaxLength       =   40
               TabIndex        =   23
               Top             =   1410
               Width           =   4260
            End
            Begin VB.TextBox txtProfeAval 
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
               Index           =   1
               Left            =   2520
               MaxLength       =   50
               TabIndex        =   22
               Top             =   1110
               Width           =   4260
            End
            Begin VB.TextBox txtNombreAval 
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
               Index           =   1
               Left            =   2520
               MaxLength       =   70
               TabIndex        =   20
               Top             =   480
               Width           =   4260
            End
            Begin VB.TextBox txtDvAval 
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
               Index           =   1
               Left            =   3705
               MaxLength       =   1
               TabIndex        =   19
               Top             =   180
               Width           =   255
            End
            Begin VB.TextBox txtRutAval 
               Alignment       =   1  'Right Justify
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
               Index           =   1
               Left            =   2520
               MaxLength       =   9
               MouseIcon       =   "BacMntClie.frx":4C60
               MultiLine       =   -1  'True
               TabIndex        =   18
               Top             =   180
               Width           =   1125
            End
            Begin VB.Label Label7 
               Caption         =   "Apoderados del Aval (sólo personas jurídicas)"
               BeginProperty Font 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   -1  'True
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00800000&
               Height          =   225
               Left            =   120
               TabIndex        =   316
               Top             =   2490
               Width           =   6690
            End
            Begin VB.Label Label5 
               Caption         =   "Cónyuge del Aval (sólo personas naturales)"
               BeginProperty Font 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   -1  'True
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00800000&
               Height          =   225
               Left            =   120
               TabIndex        =   315
               Top             =   4140
               Width           =   6690
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Profesión Conyuge"
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
               Height          =   195
               Index           =   66
               Left            =   120
               TabIndex        =   221
               Top             =   5085
               Width           =   1605
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Estado Civil"
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
               Height          =   195
               Index           =   65
               Left            =   120
               TabIndex        =   220
               Top             =   840
               Width           =   1020
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Nombre Conyuge"
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
               Height          =   195
               Index           =   64
               Left            =   120
               TabIndex        =   219
               Top             =   4815
               Width           =   1455
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "R.U.T. Conyuge"
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
               Height          =   195
               Index           =   63
               Left            =   120
               TabIndex        =   218
               Top             =   4500
               Width           =   1380
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Nombre Apoderado 2"
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
               Height          =   195
               Index           =   62
               Left            =   120
               TabIndex        =   217
               Top             =   3750
               Width           =   1800
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "R.U.T. Apoderado 2"
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
               Height          =   195
               Index           =   61
               Left            =   120
               TabIndex        =   216
               Top             =   3450
               Width           =   1725
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Nombre Apoderado 1"
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
               Height          =   195
               Index           =   60
               Left            =   120
               TabIndex        =   215
               Top             =   3150
               Width           =   1800
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "R.U.T. Apoderado 1"
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
               Height          =   195
               Index           =   59
               Left            =   120
               TabIndex        =   214
               Top             =   2850
               Width           =   1725
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Ciudad"
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
               Height          =   195
               Index           =   58
               Left            =   120
               TabIndex        =   213
               Top             =   1785
               Width           =   600
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Comuna"
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
               Height          =   195
               Index           =   57
               Left            =   120
               TabIndex        =   212
               Top             =   2085
               Width           =   690
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Dirección"
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
               Height          =   195
               Index           =   56
               Left            =   120
               TabIndex        =   211
               Top             =   1455
               Width           =   825
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Profesión"
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
               Height          =   195
               Index           =   55
               Left            =   120
               TabIndex        =   210
               Top             =   1155
               Width           =   810
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Razon Social / Nombre"
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
               Height          =   195
               Index           =   53
               Left            =   120
               TabIndex        =   209
               Top             =   555
               Width           =   1995
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "R.U.T."
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
               Height          =   195
               Index           =   52
               Left            =   120
               TabIndex        =   208
               Top             =   240
               Width           =   585
            End
         End
         Begin VB.Frame Frame7 
            Height          =   5385
            Index           =   0
            Left            =   60
            TabIndex        =   190
            Top             =   330
            Width           =   6885
            Begin VB.ComboBox Cmb_RegimenConyugal 
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
               Height          =   315
               Index           =   0
               Left            =   2520
               Style           =   2  'Dropdown List
               TabIndex        =   3
               Top             =   780
               Width           =   4260
            End
            Begin VB.TextBox txtRutAval 
               Alignment       =   1  'Right Justify
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
               Index           =   0
               Left            =   2520
               MaxLength       =   9
               MouseIcon       =   "BacMntClie.frx":4F6A
               MultiLine       =   -1  'True
               TabIndex        =   0
               Top             =   180
               Width           =   1125
            End
            Begin VB.TextBox txtDvAval 
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
               Index           =   0
               Left            =   3705
               MaxLength       =   1
               TabIndex        =   1
               Top             =   180
               Width           =   255
            End
            Begin VB.TextBox txtNombreAval 
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
               Index           =   0
               Left            =   2520
               MaxLength       =   70
               TabIndex        =   2
               Top             =   480
               Width           =   4260
            End
            Begin VB.TextBox txtProfeAval 
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
               Index           =   0
               Left            =   2520
               MaxLength       =   50
               TabIndex        =   4
               Top             =   1110
               Width           =   4260
            End
            Begin VB.TextBox txtDirenAval 
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
               Index           =   0
               Left            =   2520
               MaxLength       =   40
               TabIndex        =   5
               Top             =   1410
               Width           =   4260
            End
            Begin VB.ComboBox cmbComunaAval 
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
               Height          =   315
               Index           =   0
               Left            =   2520
               Style           =   2  'Dropdown List
               TabIndex        =   7
               Top             =   2040
               Width           =   2385
            End
            Begin VB.ComboBox CmbCiudadAval 
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
               Height          =   315
               Index           =   0
               Left            =   2520
               Style           =   2  'Dropdown List
               TabIndex        =   6
               Top             =   1710
               Width           =   2385
            End
            Begin VB.TextBox txtRutApode1 
               Alignment       =   1  'Right Justify
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
               Index           =   0
               Left            =   2520
               MaxLength       =   9
               MouseIcon       =   "BacMntClie.frx":5274
               MultiLine       =   -1  'True
               TabIndex        =   8
               Top             =   2790
               Width           =   1125
            End
            Begin VB.TextBox txtDvApode1 
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
               Index           =   0
               Left            =   3735
               MaxLength       =   1
               TabIndex        =   9
               Top             =   2790
               Width           =   255
            End
            Begin VB.TextBox txtNomApode1 
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
               Index           =   0
               Left            =   2520
               MaxLength       =   70
               TabIndex        =   10
               Top             =   3090
               Width           =   4260
            End
            Begin VB.TextBox txtRutApode2 
               Alignment       =   1  'Right Justify
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
               Index           =   0
               Left            =   2520
               MaxLength       =   9
               MouseIcon       =   "BacMntClie.frx":557E
               MultiLine       =   -1  'True
               TabIndex        =   11
               Top             =   3390
               Width           =   1125
            End
            Begin VB.TextBox txtDvApode2 
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
               Index           =   0
               Left            =   3735
               MaxLength       =   1
               TabIndex        =   12
               Top             =   3390
               Width           =   255
            End
            Begin VB.TextBox txtNomApode2 
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
               Index           =   0
               Left            =   2520
               MaxLength       =   70
               TabIndex        =   13
               Top             =   3690
               Width           =   4260
            End
            Begin VB.TextBox txtRutConyAval 
               Alignment       =   1  'Right Justify
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
               Index           =   0
               Left            =   2520
               MaxLength       =   9
               MouseIcon       =   "BacMntClie.frx":5888
               MultiLine       =   -1  'True
               TabIndex        =   14
               Top             =   4440
               Width           =   1125
            End
            Begin VB.TextBox txtDvConyAval 
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
               Index           =   0
               Left            =   3735
               MaxLength       =   1
               TabIndex        =   15
               Top             =   4440
               Width           =   255
            End
            Begin VB.TextBox txtNomConyAval 
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
               Index           =   0
               Left            =   2520
               MaxLength       =   70
               TabIndex        =   16
               Top             =   4740
               Width           =   4260
            End
            Begin VB.TextBox txtProfConyuge 
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
               Index           =   0
               Left            =   2520
               MaxLength       =   50
               TabIndex        =   17
               Top             =   5040
               Width           =   4260
            End
            Begin VB.CheckBox chkEliminaAval 
               Caption         =   "Elimina Aval"
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
               Index           =   0
               Left            =   5415
               TabIndex        =   191
               Top             =   195
               Width           =   1365
            End
            Begin VB.Label Label4 
               Caption         =   "Apoderados del Aval (sólo personas jurídicas)"
               BeginProperty Font 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   -1  'True
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00800000&
               Height          =   225
               Left            =   120
               TabIndex        =   314
               Top             =   2490
               Width           =   6690
            End
            Begin VB.Label Label2 
               Caption         =   "Cónyuge del Aval (sólo personas naturales)"
               BeginProperty Font 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   -1  'True
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00800000&
               Height          =   225
               Left            =   120
               TabIndex        =   313
               Top             =   4140
               Width           =   6690
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "R.U.T."
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
               Height          =   195
               Index           =   36
               Left            =   120
               TabIndex        =   205
               Top             =   240
               Width           =   585
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Razon Social / Nombre"
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
               Height          =   195
               Index           =   37
               Left            =   120
               TabIndex        =   204
               Top             =   555
               Width           =   1995
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Profesión"
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
               Height          =   195
               Index           =   39
               Left            =   120
               TabIndex        =   203
               Top             =   1155
               Width           =   810
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Dirección"
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
               Height          =   195
               Index           =   40
               Left            =   120
               TabIndex        =   202
               Top             =   1455
               Width           =   825
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Comuna"
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
               Height          =   195
               Index           =   43
               Left            =   120
               TabIndex        =   201
               Top             =   2085
               Width           =   690
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Ciudad"
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
               Height          =   195
               Index           =   44
               Left            =   120
               TabIndex        =   200
               Top             =   1785
               Width           =   600
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "R.U.T. Apoderado 1"
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
               Height          =   195
               Index           =   45
               Left            =   120
               TabIndex        =   199
               Top             =   2850
               Width           =   1725
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Nombre Apoderado 1"
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
               Height          =   195
               Index           =   46
               Left            =   120
               TabIndex        =   198
               Top             =   3150
               Width           =   1800
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "R.U.T. Apoderado 2"
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
               Height          =   195
               Index           =   50
               Left            =   120
               TabIndex        =   197
               Top             =   3450
               Width           =   1725
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Nombre Apoderado 2"
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
               Height          =   195
               Index           =   51
               Left            =   120
               TabIndex        =   196
               Top             =   3750
               Width           =   1800
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "R.U.T. Conyuge"
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
               Height          =   195
               Index           =   48
               Left            =   120
               TabIndex        =   195
               Top             =   4500
               Width           =   1380
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Nombre Conyuge"
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
               Height          =   195
               Index           =   49
               Left            =   120
               TabIndex        =   194
               Top             =   4815
               Width           =   1455
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Estado Civil"
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
               Height          =   195
               Index           =   47
               Left            =   120
               TabIndex        =   193
               Top             =   840
               Width           =   1020
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Profesión Conyuge"
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
               Height          =   195
               Index           =   108
               Left            =   120
               TabIndex        =   192
               Top             =   5085
               Width           =   1605
            End
         End
      End
      Begin VB.Label Label6 
         Caption         =   "Cantidad de Avales"
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
         Height          =   375
         Left            =   7380
         TabIndex        =   183
         Top             =   240
         Width           =   1080
      End
   End
   Begin TabDlg.SSTab SSTab1 
      Height          =   6600
      Left            =   90
      TabIndex        =   106
      Top             =   660
      Width           =   8625
      _ExtentX        =   15214
      _ExtentY        =   11642
      _Version        =   393216
      Tabs            =   5
      Tab             =   4
      TabsPerRow      =   5
      TabHeight       =   811
      TabCaption(0)   =   "Identificacion Cliente"
      TabPicture(0)   =   "BacMntClie.frx":5B92
      Tab(0).ControlEnabled=   0   'False
      Tab(0).Control(0)=   "Label(18)"
      Tab(0).Control(1)=   "SSFrame7"
      Tab(0).Control(2)=   "SSFrame1"
      Tab(0).Control(3)=   "SSFrame2"
      Tab(0).Control(4)=   "SSOption1"
      Tab(0).Control(5)=   "SSOption2"
      Tab(0).Control(6)=   "TxtCodigo"
      Tab(0).Control(7)=   "txtDigito"
      Tab(0).Control(8)=   "txtrut"
      Tab(0).Control(9)=   "txtgeneric"
      Tab(0).Control(10)=   "FraDatosDeFusión"
      Tab(0).ControlCount=   11
      TabCaption(1)   =   "Domicilio"
      TabPicture(1)   =   "BacMntClie.frx":5BAE
      Tab(1).ControlEnabled=   0   'False
      Tab(1).Control(0)=   "TxtDireccion"
      Tab(1).Control(1)=   "SSFrame3"
      Tab(1).Control(2)=   "SSFrame4"
      Tab(1).Control(3)=   "SSFrame6"
      Tab(1).Control(4)=   "SSFrame5"
      Tab(1).ControlCount=   5
      TabCaption(2)   =   "Detalles"
      TabPicture(2)   =   "BacMntClie.frx":5BCA
      Tab(2).ControlEnabled=   0   'False
      Tab(2).Control(0)=   "SSFrame10"
      Tab(2).Control(1)=   "SSFrame9"
      Tab(2).Control(2)=   "SSFrame8"
      Tab(2).ControlCount=   3
      TabCaption(3)   =   "Mesa Empresa"
      TabPicture(3)   =   "BacMntClie.frx":5BE6
      Tab(3).ControlEnabled=   0   'False
      Tab(3).Control(0)=   "Frame10"
      Tab(3).Control(1)=   "Frame2"
      Tab(3).Control(2)=   "Frame1"
      Tab(3).Control(3)=   "frame85"
      Tab(3).Control(4)=   "SSFrame11"
      Tab(3).Control(5)=   "SSFrame12"
      Tab(3).Control(6)=   "SSFrame13"
      Tab(3).Control(7)=   "SSFrame14"
      Tab(3).Control(8)=   "SSFrame17"
      Tab(3).Control(9)=   "SSFrame15"
      Tab(3).ControlCount=   10
      TabCaption(4)   =   "Derivados"
      TabPicture(4)   =   "BacMntClie.frx":5C02
      Tab(4).ControlEnabled=   -1  'True
      Tab(4).Control(0)=   "Frame3"
      Tab(4).Control(0).Enabled=   0   'False
      Tab(4).ControlCount=   1
      Begin VB.Frame FraDatosDeFusión 
         Caption         =   "Datos de Fusión"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   1450
         Left            =   -74880
         TabIndex        =   356
         Top             =   5000
         Width           =   8415
         Begin VB.ComboBox Cmb_cod_emp_cen 
            BeginProperty Font 
               Name            =   "Courier New"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   330
            Left            =   3840
            Style           =   2  'Dropdown List
            TabIndex        =   368
            Top             =   1000
            Width           =   3000
         End
         Begin VB.ComboBox Cmb_cod_contra 
            BeginProperty Font 
               Name            =   "Courier New"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   330
            ItemData        =   "BacMntClie.frx":5C1E
            Left            =   300
            List            =   "BacMntClie.frx":5C20
            Style           =   2  'Dropdown List
            TabIndex        =   367
            Top             =   1000
            Width           =   3000
         End
         Begin VB.TextBox txtCodCGI 
            Height          =   285
            Left            =   6120
            TabIndex        =   362
            Top             =   350
            Width           =   735
         End
         Begin VB.TextBox txtcodAS400 
            Height          =   285
            Left            =   3840
            TabIndex        =   361
            Top             =   350
            Width           =   735
         End
         Begin VB.TextBox txtSecuencia 
            Height          =   285
            Left            =   1320
            TabIndex        =   360
            Top             =   350
            Width           =   735
         End
         Begin VB.Label Lbl_cod_emp_cen 
            AutoSize        =   -1  'True
            BackStyle       =   0  'Transparent
            Caption         =   "Código Emp. Centra. Contrap."
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
            Height          =   195
            Index           =   2
            Left            =   3840
            TabIndex        =   369
            Top             =   750
            Width           =   2520
         End
         Begin VB.Label Lbl_cod_contra 
            AutoSize        =   -1  'True
            BackStyle       =   0  'Transparent
            Caption         =   "Código Contraparte"
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
            Height          =   195
            Index           =   1
            Left            =   300
            TabIndex        =   300
            Top             =   750
            Width           =   1635
         End
         Begin VB.Label lblCódigoCGI 
            AutoSize        =   -1  'True
            BackStyle       =   0  'Transparent
            Caption         =   "Código CGI"
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
            Height          =   195
            Index           =   0
            Left            =   4920
            TabIndex        =   359
            Top             =   350
            Width           =   960
         End
         Begin VB.Label lblCódigoAS400 
            AutoSize        =   -1  'True
            BackStyle       =   0  'Transparent
            Caption         =   "Código AS400"
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
            Height          =   195
            Index           =   0
            Left            =   2520
            TabIndex        =   358
            Top             =   350
            Width           =   1200
         End
         Begin VB.Label lblSecuencia 
            AutoSize        =   -1  'True
            BackStyle       =   0  'Transparent
            Caption         =   "Secuencia"
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
            Height          =   195
            Index           =   0
            Left            =   360
            TabIndex        =   357
            Top             =   350
            Width           =   915
         End
      End
      Begin VB.Frame Frame10 
         Caption         =   "Motivo del Bloqueo"
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
         Height          =   1335
         Left            =   -74910
         TabIndex        =   332
         Top             =   4320
         Width           =   8400
         Begin VB.TextBox txtMotivoBloqueo 
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
            Height          =   975
            Left            =   120
            MaxLength       =   400
            MultiLine       =   -1  'True
            ScrollBars      =   2  'Vertical
            TabIndex        =   333
            Top             =   240
            Width           =   8175
         End
      End
      Begin VB.Frame Frame3 
         Caption         =   "Contratos Derivados"
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
         Height          =   5730
         Left            =   135
         TabIndex        =   298
         Top             =   495
         Width           =   8400
         Begin VB.Frame Frame12 
            Caption         =   "Firmo Contrato ComDer"
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
            Height          =   615
            Left            =   3000
            TabIndex        =   346
            Top             =   240
            Width           =   2295
            Begin VB.OptionButton OptComDer_Si 
               Caption         =   "SI"
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
               Height          =   255
               Left            =   480
               TabIndex        =   348
               Top             =   240
               Width           =   615
            End
            Begin VB.OptionButton OptComDer_No 
               Caption         =   "NO"
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
               Height          =   255
               Left            =   1320
               TabIndex        =   347
               Top             =   240
               Width           =   615
            End
         End
         Begin VB.Frame Frame6 
            Height          =   2370
            Left            =   120
            TabIndex        =   323
            Top             =   3240
            Width           =   8250
            Begin VB.ComboBox cmbMetodologiaREC 
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
               Height          =   315
               Left            =   2220
               Style           =   2  'Dropdown List
               TabIndex        =   336
               Top             =   1890
               Width           =   4365
            End
            Begin BACControles.TXTNumero txtGarantiaEfectiva 
               Height          =   255
               Left            =   2220
               TabIndex        =   335
               Top             =   1560
               Width           =   2460
               _ExtentX        =   4339
               _ExtentY        =   450
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
               Text            =   "0"
               Text            =   "0"
               Min             =   "0"
               Separator       =   -1  'True
               MarcaTexto      =   -1  'True
            End
            Begin VB.ComboBox cmbEjecutivoCom 
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
               Height          =   315
               Left            =   2220
               Style           =   2  'Dropdown List
               TabIndex        =   326
               Top             =   540
               Width           =   4350
            End
            Begin VB.ComboBox cmbSegComercial 
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
               Height          =   315
               Left            =   2220
               Style           =   2  'Dropdown List
               TabIndex        =   325
               Top             =   210
               Width           =   4350
            End
            Begin VB.ComboBox cmbClasificacion 
               BeginProperty Font 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00800000&
               Height          =   315
               ItemData        =   "BacMntClie.frx":5C22
               Left            =   2220
               List            =   "BacMntClie.frx":5C24
               Style           =   2  'Dropdown List
               TabIndex        =   324
               Top             =   885
               Width           =   2460
            End
            Begin BACControles.TXTNumero txtGarantiaTotal 
               Height          =   285
               Left            =   2220
               TabIndex        =   327
               Top             =   1215
               Width           =   2460
               _ExtentX        =   4339
               _ExtentY        =   503
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
               Text            =   "0"
               Text            =   "0"
               Min             =   "0"
               Max             =   "1E+14"
               Separator       =   -1  'True
               MarcaTexto      =   -1  'True
            End
            Begin VB.Label Label20 
               Caption         =   "Metodologia REC"
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
               Height          =   225
               Left            =   90
               TabIndex        =   337
               Top             =   1920
               Width           =   1650
            End
            Begin VB.Label Label19 
               AutoSize        =   -1  'True
               Caption         =   "Garantía en Efec. USD"
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
               Height          =   195
               Left            =   60
               TabIndex        =   334
               Top             =   1560
               Width           =   1530
            End
            Begin VB.Label Label14 
               AutoSize        =   -1  'True
               Caption         =   "Garantía Total"
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
               Height          =   195
               Left            =   60
               TabIndex        =   331
               Top             =   1245
               Width           =   1260
            End
            Begin VB.Label Label15 
               AutoSize        =   -1  'True
               Caption         =   "Clasificación de Riesgo"
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
               Height          =   195
               Left            =   60
               TabIndex        =   330
               Top             =   930
               Width           =   2010
            End
            Begin VB.Label Label16 
               AutoSize        =   -1  'True
               Caption         =   "Ejecutivo Comercial"
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
               Height          =   195
               Left            =   60
               TabIndex        =   329
               Top             =   615
               Width           =   1695
            End
            Begin VB.Label Label17 
               AutoSize        =   -1  'True
               Caption         =   "Segmento Comercial"
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
               Height          =   195
               Left            =   60
               TabIndex        =   328
               Top             =   300
               Width           =   1740
            End
         End
         Begin VB.Frame Frame9 
            Caption         =   "Version Antigua"
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
            Height          =   900
            Left            =   90
            TabIndex        =   310
            Top             =   2280
            Width           =   8250
            Begin VB.ComboBox CmbVerContratos 
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
               Height          =   315
               Left            =   1710
               Style           =   2  'Dropdown List
               TabIndex        =   311
               Top             =   435
               Width           =   5190
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Versión Contrato"
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
               Height          =   195
               Index           =   42
               Left            =   135
               TabIndex        =   312
               Top             =   480
               Width           =   1425
            End
         End
         Begin VB.Frame Frame8 
            Caption         =   "Version Nueva"
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
            Height          =   1365
            Left            =   75
            TabIndex        =   303
            Top             =   855
            Width           =   8265
            Begin VB.ComboBox CmbColateral 
               Height          =   315
               Left            =   7080
               TabIndex        =   370
               Text            =   "CmbColateral"
               Top             =   600
               Width           =   975
            End
            Begin VB.Frame Frame5 
               Caption         =   "Claúsula Retroactiva Firmada"
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
               Height          =   615
               Left            =   4080
               TabIndex        =   305
               Top             =   465
               Width           =   2805
               Begin VB.OptionButton OptRetro_No 
                  Caption         =   "NO"
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
                  Height          =   255
                  Left            =   1410
                  TabIndex        =   307
                  Top             =   255
                  Width           =   615
               End
               Begin VB.OptionButton OptRetro_Si 
                  Caption         =   "SI"
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
                  Height          =   255
                  Left            =   780
                  TabIndex        =   306
                  Top             =   255
                  Width           =   615
               End
            End
            Begin VB.CommandButton BtnAval 
               Caption         =   "Datos Aval"
               BeginProperty Font 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   495
               Left            =   2655
               TabIndex        =   304
               Top             =   570
               Width           =   1215
            End
            Begin BACControles.TXTFecha fecha_firma_nuevo 
               Height          =   315
               Left            =   570
               TabIndex        =   308
               Top             =   750
               Width           =   1260
               _ExtentX        =   2223
               _ExtentY        =   556
               Enabled         =   -1  'True
               Enabled         =   -1  'True
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
               Text            =   "01/01/1900"
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Colateral"
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
               Height          =   195
               Index           =   38
               Left            =   7080
               TabIndex        =   371
               Top             =   240
               Width           =   765
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Fecha Firma Nuevo Contrato"
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
               Height          =   195
               Index           =   41
               Left            =   75
               TabIndex        =   309
               Top             =   405
               Width           =   2445
            End
         End
         Begin VB.Frame Frame4 
            Caption         =   "Utiliza Contratos Nuevos"
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
            Height          =   600
            Left            =   150
            TabIndex        =   299
            Top             =   240
            Width           =   2430
            Begin VB.OptionButton OptFirm_No 
               Caption         =   "NO"
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
               Height          =   255
               Left            =   1170
               TabIndex        =   302
               Top             =   255
               Width           =   615
            End
            Begin VB.OptionButton OptFirm_Si 
               Caption         =   "SI"
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
               Height          =   255
               Left            =   510
               TabIndex        =   301
               Top             =   255
               Width           =   615
            End
         End
         Begin BACControles.TXTFecha Fecha_Contrato_Comder 
            Height          =   300
            Left            =   6165
            TabIndex        =   349
            Top             =   465
            Width           =   1560
            _ExtentX        =   2752
            _ExtentY        =   529
            Enabled         =   -1  'True
            Enabled         =   -1  'True
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
            Text            =   "09/12/2013"
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            Caption         =   "Fecha Firma Contrato ComDer"
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
            Height          =   195
            Index           =   34
            Left            =   5640
            TabIndex        =   350
            Top             =   240
            Width           =   2550
         End
      End
      Begin VB.Frame Frame2 
         Height          =   930
         Left            =   -65190
         TabIndex        =   136
         Top             =   3150
         Width           =   2235
      End
      Begin VB.TextBox txtgeneric 
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
         Left            =   -70200
         MaxLength       =   5
         TabIndex        =   92
         Top             =   1020
         Width           =   1185
      End
      Begin VB.TextBox txtrut 
         Alignment       =   1  'Right Justify
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
         Left            =   -74100
         MaxLength       =   9
         MouseIcon       =   "BacMntClie.frx":5C26
         MousePointer    =   99  'Custom
         MultiLine       =   -1  'True
         TabIndex        =   47
         Top             =   1020
         Width           =   1125
      End
      Begin VB.TextBox txtDigito 
         Enabled         =   0   'False
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
         Left            =   -72950
         MaxLength       =   1
         TabIndex        =   54
         Top             =   1020
         Width           =   255
      End
      Begin VB.TextBox TxtCodigo 
         Alignment       =   2  'Center
         Enabled         =   0   'False
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
         Left            =   -71800
         MaxLength       =   5
         TabIndex        =   91
         Text            =   "1"
         Top             =   1020
         Width           =   645
      End
      Begin VB.TextBox TxtDireccion 
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
         Left            =   -74760
         MaxLength       =   40
         TabIndex        =   93
         Top             =   1095
         Width           =   8175
      End
      Begin VB.Frame Frame1 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   795
         Left            =   -72780
         TabIndex        =   108
         Top             =   2895
         Width           =   3780
         Begin VB.TextBox TxtCod 
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
            Left            =   2130
            MaxLength       =   11
            TabIndex        =   102
            Top             =   270
            Width           =   1560
         End
         Begin Threed.SSOption OpImplic 
            Height          =   255
            Index           =   2
            Left            =   1425
            TabIndex        =   101
            Top             =   285
            Width           =   735
            _Version        =   65536
            _ExtentX        =   1296
            _ExtentY        =   450
            _StockProps     =   78
            Caption         =   "Swift"
            ForeColor       =   8388608
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
         End
         Begin Threed.SSOption OpImplic 
            Height          =   255
            Index           =   1
            Left            =   735
            TabIndex        =   100
            Top             =   285
            Width           =   660
            _Version        =   65536
            _ExtentX        =   1164
            _ExtentY        =   450
            _StockProps     =   78
            Caption         =   "Chips"
            ForeColor       =   8388608
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
         End
         Begin Threed.SSOption OpImplic 
            Height          =   255
            Index           =   0
            Left            =   90
            TabIndex        =   98
            Top             =   285
            Width           =   660
            _Version        =   65536
            _ExtentX        =   1164
            _ExtentY        =   450
            _StockProps     =   78
            Caption         =   " Aba"
            ForeColor       =   8388608
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Value           =   -1  'True
         End
      End
      Begin Threed.SSOption SSOption2 
         Height          =   195
         Left            =   -74760
         TabIndex        =   107
         Top             =   2340
         Width           =   1005
         _Version        =   65536
         _ExtentX        =   1773
         _ExtentY        =   344
         _StockProps     =   78
         Caption         =   "Juridico"
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
      End
      Begin Threed.SSOption SSOption1 
         Height          =   195
         Left            =   -74760
         TabIndex        =   109
         Top             =   1980
         Width           =   915
         _Version        =   65536
         _ExtentX        =   1614
         _ExtentY        =   344
         _StockProps     =   78
         Caption         =   "Natural"
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
         Value           =   -1  'True
         Font3D          =   3
      End
      Begin Threed.SSFrame frame85 
         Height          =   780
         Left            =   -74895
         TabIndex        =   103
         Top             =   2895
         Width           =   2070
         _Version        =   65536
         _ExtentX        =   3651
         _ExtentY        =   1376
         _StockProps     =   14
         Caption         =   "Articulo 85"
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
         Enabled         =   0   'False
         Begin Threed.SSOption opCliente 
            Height          =   255
            Left            =   135
            TabIndex        =   110
            Top             =   300
            Width           =   810
            _Version        =   65536
            _ExtentX        =   1429
            _ExtentY        =   450
            _StockProps     =   78
            Caption         =   "Cliente"
            ForeColor       =   8388608
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
            Value           =   -1  'True
         End
         Begin Threed.SSOption opBanco 
            Height          =   255
            Left            =   1050
            TabIndex        =   111
            Top             =   300
            Width           =   780
            _Version        =   65536
            _ExtentX        =   1376
            _ExtentY        =   450
            _StockProps     =   78
            Caption         =   "Banco"
            ForeColor       =   8388608
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
         End
      End
      Begin Threed.SSFrame SSFrame3 
         Height          =   4260
         Left            =   -74895
         TabIndex        =   112
         Top             =   1485
         Width           =   8400
         _Version        =   65536
         _ExtentX        =   14817
         _ExtentY        =   7514
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
         Begin VB.TextBox TxtFax 
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
            Height          =   315
            Left            =   4500
            MaxLength       =   20
            TabIndex        =   284
            Top             =   1200
            Width           =   2415
         End
         Begin VB.TextBox TxtTelefono 
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
            Height          =   300
            Left            =   4485
            MaxLength       =   20
            TabIndex        =   283
            Top             =   450
            Width           =   2445
         End
         Begin VB.ComboBox cmbPais 
            BeginProperty Font 
               Name            =   "Courier New"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   330
            Left            =   120
            Style           =   2  'Dropdown List
            TabIndex        =   281
            Top             =   450
            Width           =   4000
         End
         Begin VB.ComboBox CmbComuna 
            BeginProperty Font 
               Name            =   "Courier New"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   330
            Left            =   120
            Style           =   2  'Dropdown List
            TabIndex        =   279
            Top             =   1905
            Width           =   4000
         End
         Begin VB.ComboBox CmbCiudad 
            BeginProperty Font 
               Name            =   "Courier New"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   330
            Left            =   120
            Style           =   2  'Dropdown List
            TabIndex        =   94
            Top             =   1200
            Width           =   4000
         End
         Begin VB.Label Label 
            Caption         =   "Fax"
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
            Height          =   255
            Index           =   16
            Left            =   4500
            TabIndex        =   285
            Top             =   960
            Width           =   375
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            Caption         =   "Teléfono"
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
            Height          =   195
            Index           =   15
            Left            =   4500
            TabIndex        =   282
            Top             =   225
            Width           =   765
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            Caption         =   "Comuna"
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
            Height          =   195
            Index           =   10
            Left            =   120
            TabIndex        =   280
            Top             =   1665
            Width           =   690
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            Caption         =   "País"
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
            Height          =   240
            Index           =   9
            Left            =   120
            TabIndex        =   114
            Top             =   225
            Width           =   405
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            Caption         =   "Ciudad"
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
            Height          =   195
            Index           =   11
            Left            =   120
            TabIndex        =   113
            Top             =   960
            Width           =   600
         End
      End
      Begin Threed.SSFrame SSFrame4 
         Height          =   1620
         Left            =   -65025
         TabIndex        =   115
         Top             =   1680
         Width           =   8415
         _Version        =   65536
         _ExtentX        =   14843
         _ExtentY        =   2857
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
      End
      Begin Threed.SSFrame SSFrame6 
         Height          =   810
         Left            =   -74895
         TabIndex        =   116
         Top             =   690
         Width           =   8400
         _Version        =   65536
         _ExtentX        =   14817
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
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            Caption         =   "Dirección"
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
            Height          =   195
            Index           =   5
            Left            =   90
            TabIndex        =   117
            Top             =   150
            Width           =   825
         End
      End
      Begin Threed.SSFrame SSFrame2 
         Height          =   945
         Left            =   -74880
         TabIndex        =   118
         Top             =   1800
         Width           =   8400
         _Version        =   65536
         _ExtentX        =   14817
         _ExtentY        =   1667
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
         Begin VB.CheckBox CheckFM 
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
            Height          =   195
            Left            =   6510
            TabIndex        =   175
            Top             =   270
            Width           =   255
         End
         Begin VB.Frame Fr_Cond_gene 
            Height          =   615
            Left            =   3240
            TabIndex        =   168
            Top             =   180
            Width           =   3015
            Begin BACControles.TXTFecha Txt_Fecha_Firma 
               Height          =   300
               Left            =   705
               TabIndex        =   170
               Top             =   270
               Width           =   1680
               _ExtentX        =   2963
               _ExtentY        =   529
               BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               MaxDate         =   2958465
               MinDate         =   -328716
               Text            =   "01/01/1900"
            End
            Begin VB.CheckBox chk_Condiciones 
               Caption         =   "Firma Condiciones Generales"
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
               Height          =   195
               Left            =   120
               TabIndex        =   169
               Top             =   0
               Width           =   2835
            End
         End
         Begin VB.Frame fra_brokers 
            Height          =   615
            Left            =   1440
            TabIndex        =   159
            Top             =   180
            Width           =   1755
            Begin VB.OptionButton opt_NBroker 
               Caption         =   "NO"
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
               Height          =   195
               Left            =   1020
               TabIndex        =   162
               Top             =   300
               Width           =   615
            End
            Begin VB.OptionButton opt_SBroker 
               Caption         =   "SI"
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
               Height          =   195
               Left            =   120
               TabIndex        =   161
               Top             =   300
               Width           =   675
            End
            Begin VB.CheckBox chk_brokers 
               Caption         =   "Brokers"
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
               Height          =   195
               Left            =   120
               TabIndex        =   160
               Top             =   0
               Width           =   975
            End
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            Caption         =   "Fondo Mutuo"
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
            Height          =   195
            Index           =   35
            Left            =   6495
            TabIndex        =   176
            Top             =   510
            Width           =   1125
         End
      End
      Begin Threed.SSFrame SSFrame1 
         Height          =   2085
         Left            =   -74895
         TabIndex        =   119
         Top             =   2850
         Width           =   8415
         _Version        =   65536
         _ExtentX        =   14843
         _ExtentY        =   3678
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
         Begin VB.TextBox txtEmail 
            ForeColor       =   &H00800000&
            Height          =   315
            Left            =   2985
            MaxLength       =   250
            TabIndex        =   344
            Top             =   1650
            Width           =   4995
         End
         Begin VB.Frame Frame11 
            Caption         =   "Estado del Cliente"
            BeginProperty Font 
               Name            =   "Tahoma"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   585
            Left            =   30
            TabIndex        =   341
            Top             =   900
            Width           =   3915
            Begin VB.OptionButton opt_vigente 
               Caption         =   "Vigente"
               Enabled         =   0   'False
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
               Height          =   315
               Index           =   0
               Left            =   135
               TabIndex        =   343
               Top             =   210
               Value           =   -1  'True
               Width           =   1725
            End
            Begin VB.OptionButton opt_vigente 
               Caption         =   "No Vigente"
               Enabled         =   0   'False
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
               Index           =   1
               Left            =   2295
               TabIndex        =   342
               Top             =   240
               Width           =   1515
            End
         End
         Begin VB.Frame FraCondPacto 
            Height          =   585
            Left            =   3945
            TabIndex        =   338
            Top             =   900
            Width           =   4440
            Begin VB.CheckBox ChkCondPacto 
               Caption         =   "Firma Condiciones Generales de Pacto"
               BeginProperty Font 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H80000007&
               Height          =   195
               Left            =   165
               TabIndex        =   339
               Top             =   0
               Width           =   3720
            End
            Begin BACControles.TXTFecha TxtFechaPacto 
               Height          =   300
               Left            =   1095
               TabIndex        =   340
               Top             =   240
               Width           =   1680
               _ExtentX        =   2963
               _ExtentY        =   529
               BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               MaxDate         =   2958465
               MinDate         =   -328716
               Text            =   "01/01/1900"
            End
         End
         Begin VB.TextBox Txt2Apellido 
            Enabled         =   0   'False
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
            Left            =   2295
            MaxLength       =   15
            TabIndex        =   188
            Top             =   420
            Width           =   1905
         End
         Begin VB.TextBox Txt1Apellido 
            Enabled         =   0   'False
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
            Left            =   420
            MaxLength       =   15
            TabIndex        =   187
            Top             =   420
            Width           =   1890
         End
         Begin VB.TextBox Txt2Nombre 
            Enabled         =   0   'False
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
            Left            =   6120
            MaxLength       =   15
            TabIndex        =   186
            Top             =   420
            Width           =   1845
         End
         Begin VB.TextBox Txt1Nombre 
            Enabled         =   0   'False
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
            Left            =   4200
            MaxLength       =   15
            TabIndex        =   185
            Top             =   420
            Width           =   1920
         End
         Begin VB.TextBox TxtNombre 
            Enabled         =   0   'False
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
            Left            =   405
            MaxLength       =   70
            TabIndex        =   184
            TabStop         =   0   'False
            Top             =   420
            Width           =   7575
         End
         Begin VB.Label Label18 
            AutoSize        =   -1  'True
            Caption         =   "Dirección de Correo Electrónico"
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
            Height          =   195
            Left            =   135
            TabIndex        =   345
            Top             =   1695
            Width           =   2730
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            Caption         =   "Nombres"
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
            Height          =   195
            Index           =   21
            Left            =   4290
            TabIndex        =   122
            Top             =   150
            Width           =   750
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            Caption         =   "Materno"
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
            Height          =   195
            Index           =   20
            Left            =   2400
            TabIndex        =   121
            Top             =   135
            Width           =   705
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            Caption         =   "Paterno"
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
            Height          =   195
            Index           =   2
            Left            =   480
            TabIndex        =   120
            Top             =   120
            Width           =   675
         End
      End
      Begin Threed.SSFrame SSFrame8 
         Height          =   1755
         Left            =   -74910
         TabIndex        =   123
         Top             =   630
         Width           =   8430
         _Version        =   65536
         _ExtentX        =   14870
         _ExtentY        =   3096
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
         Begin VB.ComboBox cmbTipoCliente 
            BeginProperty Font 
               Name            =   "Courier New"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   330
            ItemData        =   "BacMntClie.frx":5F30
            Left            =   120
            List            =   "BacMntClie.frx":5F32
            Style           =   2  'Dropdown List
            TabIndex        =   277
            Top             =   375
            Width           =   4005
         End
         Begin VB.ComboBox CmbCalidadJuridica 
            BeginProperty Font 
               Name            =   "Courier New"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   330
            Left            =   120
            Style           =   2  'Dropdown List
            TabIndex        =   276
            Top             =   900
            Width           =   4005
         End
         Begin VB.ComboBox CmbMercado 
            BeginProperty Font 
               Name            =   "Courier New"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   330
            Left            =   4290
            Style           =   2  'Dropdown List
            TabIndex        =   275
            Top             =   375
            Width           =   4005
         End
         Begin VB.ComboBox cmbRelBanco 
            BeginProperty Font 
               Name            =   "Courier New"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   330
            Left            =   4290
            Style           =   2  'Dropdown List
            TabIndex        =   274
            Top             =   900
            Width           =   4005
         End
         Begin VB.TextBox nombre_notaria 
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
            Left            =   4290
            MaxLength       =   50
            TabIndex        =   171
            Text            =   " "
            Top             =   1425
            Width           =   4005
         End
         Begin VB.TextBox Txt_Swift 
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000002&
            Height          =   285
            Left            =   105
            TabIndex        =   158
            Text            =   " "
            Top             =   1425
            Width           =   4005
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            Caption         =   "Clasificación Cliente"
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
            Height          =   195
            Index           =   7
            Left            =   120
            TabIndex        =   278
            Top             =   135
            Width           =   1740
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            Caption         =   "Nombre Notaria"
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
            Height          =   195
            Index           =   29
            Left            =   4290
            TabIndex        =   172
            Top             =   1230
            Width           =   1335
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            Caption         =   "Swift"
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
            Height          =   195
            Index           =   22
            Left            =   120
            TabIndex        =   153
            Top             =   1230
            Width           =   480
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            Caption         =   "Calidad Jurídica"
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
            Height          =   195
            Index           =   13
            Left            =   120
            TabIndex        =   126
            Top             =   690
            Width           =   1395
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            Caption         =   "Mercado"
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
            Height          =   195
            Index           =   8
            Left            =   4290
            TabIndex        =   125
            Top             =   135
            Width           =   750
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            Caption         =   "Relación Banco"
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
            Height          =   195
            Index           =   26
            Left            =   4290
            TabIndex        =   124
            Top             =   690
            Width           =   1365
         End
      End
      Begin Threed.SSFrame SSFrame11 
         Height          =   1470
         Left            =   -74925
         TabIndex        =   133
         Top             =   645
         Width           =   8400
         _Version        =   65536
         _ExtentX        =   14817
         _ExtentY        =   2593
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
         Begin VB.ComboBox cmbComInstitucional 
            BeginProperty Font 
               Name            =   "Courier New"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   330
            Left            =   90
            Style           =   2  'Dropdown List
            TabIndex        =   297
            Top             =   420
            Width           =   5640
         End
         Begin VB.ComboBox cmbActividadEconomica 
            BeginProperty Font 
               Name            =   "Courier New"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   330
            Left            =   90
            Style           =   2  'Dropdown List
            TabIndex        =   296
            Top             =   1050
            Width           =   5640
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            Caption         =   "Actividad Económica"
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
            Height          =   195
            Index           =   32
            Left            =   90
            TabIndex        =   295
            Top             =   810
            Width           =   1800
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            Caption         =   "Composición Institucional"
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
            Height          =   195
            Index           =   28
            Left            =   90
            TabIndex        =   134
            Top             =   180
            Width           =   2175
         End
      End
      Begin Threed.SSFrame SSFrame12 
         Height          =   915
         Left            =   -66345
         TabIndex        =   135
         Top             =   1950
         Width           =   3840
         _Version        =   65536
         _ExtentX        =   6773
         _ExtentY        =   1614
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
      End
      Begin Threed.SSFrame SSFrame13 
         Height          =   795
         Left            =   -74910
         TabIndex        =   137
         Top             =   2100
         Width           =   8385
         _Version        =   65536
         _ExtentX        =   14790
         _ExtentY        =   1402
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
         Begin VB.TextBox txtCRiesgo 
            Enabled         =   0   'False
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
            Left            =   2745
            MaxLength       =   10
            TabIndex        =   294
            Top             =   360
            Width           =   1470
         End
         Begin VB.TextBox txtCodigoBCCH 
            Enabled         =   0   'False
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
            Left            =   1395
            MaxLength       =   3
            TabIndex        =   293
            Text            =   "0"
            Top             =   360
            Width           =   720
         End
         Begin VB.TextBox txtCodigoSuper 
            Enabled         =   0   'False
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
            MaxLength       =   3
            TabIndex        =   292
            Text            =   "0"
            Top             =   345
            Width           =   675
         End
         Begin VB.Frame CuadroBcoReceptor 
            Enabled         =   0   'False
            Height          =   810
            Left            =   4950
            TabIndex        =   163
            Top             =   -15
            Width           =   3435
            Begin BACControles.TXTNumero txtReceptorRutBco 
               Height          =   315
               Left            =   1470
               TabIndex        =   164
               Top             =   135
               Width           =   1440
               _ExtentX        =   2540
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
            Begin BACControles.TXTNumero txtReceptorCodBco 
               Height          =   315
               Left            =   2970
               TabIndex        =   165
               Top             =   135
               Width           =   375
               _ExtentX        =   661
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
            Begin VB.Label lblReceptorNomBco 
               Alignment       =   2  'Center
               BorderStyle     =   1  'Fixed Single
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   -1  'True
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   300
               Left            =   45
               TabIndex        =   167
               Top             =   450
               Width           =   3345
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Banco Receptor"
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   9
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   -1  'True
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00800000&
               Height          =   225
               Index           =   27
               Left            =   60
               TabIndex        =   166
               Top             =   180
               Width           =   1320
            End
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            Caption         =   "Clasificador Riesgo"
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
            Height          =   195
            Index           =   19
            Left            =   2760
            TabIndex        =   140
            Top             =   120
            Width           =   1650
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            Caption         =   "Cód.BCCH"
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
            Height          =   195
            Index           =   6
            Left            =   1410
            TabIndex        =   139
            Top             =   135
            Width           =   900
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            Caption         =   "Cód.Sbif"
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
            Height          =   195
            Index           =   4
            Left            =   45
            TabIndex        =   138
            Top             =   135
            Width           =   735
         End
      End
      Begin Threed.SSFrame SSFrame14 
         Height          =   780
         Left            =   -68970
         TabIndex        =   141
         Top             =   2910
         Width           =   2445
         _Version        =   65536
         _ExtentX        =   4313
         _ExtentY        =   1376
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
         Begin VB.CheckBox chkOficinas 
            Caption         =   "Oficinas en Chile"
            Enabled         =   0   'False
            ForeColor       =   &H00800000&
            Height          =   255
            Left            =   30
            TabIndex        =   291
            Top             =   405
            Width           =   1530
         End
         Begin VB.CheckBox chkInformeSocial 
            Caption         =   "Informe Social"
            ForeColor       =   &H00800000&
            Height          =   255
            Left            =   30
            TabIndex        =   290
            Top             =   120
            Width           =   1350
         End
         Begin VB.CheckBox chkPoder 
            Caption         =   "Poder"
            ForeColor       =   &H00800000&
            Height          =   255
            Left            =   1620
            TabIndex        =   289
            Top             =   120
            Width           =   735
         End
         Begin VB.CheckBox chkFirma 
            Caption         =   "Firma"
            ForeColor       =   &H00800000&
            Height          =   255
            Left            =   1620
            TabIndex        =   288
            Top             =   405
            Width           =   690
         End
      End
      Begin Threed.SSFrame SSFrame17 
         Height          =   600
         Left            =   -74910
         TabIndex        =   142
         Top             =   3675
         Width           =   5910
         _Version        =   65536
         _ExtentX        =   10425
         _ExtentY        =   1058
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
         Begin VB.TextBox TxtCodigoOtc 
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
            Height          =   315
            Left            =   1200
            TabIndex        =   286
            Top             =   165
            Width           =   2130
         End
         Begin VB.Label Label3 
            Caption         =   "Codigo Otc"
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
            Left            =   120
            TabIndex        =   143
            Top             =   210
            Width           =   1905
         End
      End
      Begin Threed.SSFrame SSFrame15 
         Height          =   600
         Left            =   -68970
         TabIndex        =   144
         Top             =   3675
         Width           =   2445
         _Version        =   65536
         _ExtentX        =   4313
         _ExtentY        =   1058
         _StockProps     =   14
         Caption         =   "Estado"
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
         Begin VB.CheckBox ChkBloqueado 
            Caption         =   "Bloqueado"
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
            Height          =   300
            Left            =   645
            TabIndex        =   287
            Top             =   225
            Width           =   1380
         End
      End
      Begin Threed.SSFrame SSFrame5 
         Height          =   1560
         Left            =   -66150
         TabIndex        =   145
         Top             =   2175
         Width           =   8415
         _Version        =   65536
         _ExtentX        =   14843
         _ExtentY        =   2752
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
      End
      Begin Threed.SSFrame SSFrame7 
         Height          =   690
         Left            =   -74880
         TabIndex        =   149
         Top             =   750
         Width           =   8385
         _Version        =   65536
         _ExtentX        =   14790
         _ExtentY        =   1217
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
         Begin VB.TextBox TxtCodigoCPNJ 
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
            Left            =   7000
            MaxLength       =   9
            TabIndex        =   364
            Top             =   270
            Width           =   1300
         End
         Begin VB.Label lblCPNJ 
            AutoSize        =   -1  'True
            Caption         =   "Cód. CPNJ"
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
            Height          =   195
            Index           =   38
            Left            =   6000
            TabIndex        =   363
            Top             =   300
            Width           =   915
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            Caption         =   "Generico"
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
            Height          =   195
            Index           =   3
            Left            =   3850
            TabIndex        =   152
            Top             =   300
            Width           =   780
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            Caption         =   "R.U.T."
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
            Height          =   195
            Index           =   0
            Left            =   75
            TabIndex        =   151
            Top             =   300
            Width           =   585
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            Caption         =   "Código"
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
            Height          =   195
            Index           =   31
            Left            =   2400
            TabIndex        =   150
            Top             =   315
            Width           =   600
         End
      End
      Begin Threed.SSFrame SSFrame9 
         Height          =   1275
         Left            =   -74910
         TabIndex        =   127
         Top             =   2340
         Width           =   8430
         _Version        =   65536
         _ExtentX        =   14870
         _ExtentY        =   2249
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
         Begin VB.TextBox txtctacte 
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
            Height          =   330
            Left            =   105
            MaxLength       =   15
            TabIndex        =   273
            Top             =   330
            Width           =   3975
         End
         Begin VB.ComboBox cmbCategoriaDeudor 
            BeginProperty Font 
               Name            =   "Courier New"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   330
            Left            =   120
            Style           =   2  'Dropdown List
            TabIndex        =   272
            Top             =   870
            Width           =   4005
         End
         Begin BACControles.TXTNumero txtmxcontab 
            Height          =   285
            Left            =   4260
            TabIndex        =   154
            Top             =   915
            Width           =   1845
            _ExtentX        =   3254
            _ExtentY        =   503
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
            Text            =   "0"
            Text            =   "0"
            Separator       =   -1  'True
            MarcaTexto      =   -1  'True
         End
         Begin VB.ComboBox CmbGrupo 
            BeginProperty Font 
               Name            =   "Courier New"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   330
            ItemData        =   "BacMntClie.frx":5F34
            Left            =   4260
            List            =   "BacMntClie.frx":5F36
            Style           =   2  'Dropdown List
            TabIndex        =   95
            Top             =   330
            Width           =   4035
         End
         Begin BACControles.TXTFecha fecha_escritura 
            Height          =   285
            Left            =   6585
            TabIndex        =   173
            Top             =   915
            Width           =   1710
            _ExtentX        =   3016
            _ExtentY        =   503
            Enabled         =   -1  'True
            Enabled         =   -1  'True
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
            Text            =   "01/01/1900"
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            Caption         =   "Fecha  de Escritura"
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
            Height          =   195
            Index           =   30
            Left            =   6585
            TabIndex        =   174
            Top             =   720
            Width           =   1680
         End
         Begin VB.Label Label1 
            Caption         =   "Codigo Contable"
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
            Height          =   180
            Left            =   4260
            TabIndex        =   97
            Top             =   720
            Width           =   1575
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            Caption         =   "Grupo"
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
            Height          =   195
            Index           =   12
            Left            =   4275
            TabIndex        =   147
            Top             =   135
            Width           =   525
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            Caption         =   " Numero Cta Corriente $"
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
            Height          =   195
            Index           =   17
            Left            =   120
            TabIndex        =   129
            Top             =   135
            Width           =   2055
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            Caption         =   "Categoría Deudor"
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
            Height          =   195
            Index           =   33
            Left            =   120
            TabIndex        =   128
            Top             =   660
            Width           =   1530
         End
      End
      Begin Threed.SSFrame SSFrame10 
         Height          =   1995
         Left            =   -74910
         TabIndex        =   130
         Top             =   3585
         Width           =   8430
         _Version        =   65536
         _ExtentX        =   14870
         _ExtentY        =   3519
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
         Begin VB.TextBox Txt_codEmpRelacionada 
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
            Left            =   6000
            MaxLength       =   9
            TabIndex        =   365
            Top             =   870
            Width           =   2300
         End
         Begin VB.Frame A 
            Caption         =   "Clasificación ICP Nominal"
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
            Height          =   615
            Left            =   3120
            TabIndex        =   351
            Top             =   1200
            Width           =   5175
            Begin VB.TextBox TXT_Decimales 
               Enabled         =   0   'False
               Height          =   285
               Left            =   4560
               MaxLength       =   1
               TabIndex        =   354
               Top             =   240
               Width           =   375
            End
            Begin VB.OptionButton OptNO 
               Caption         =   "NO"
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
               Height          =   195
               Left            =   360
               TabIndex        =   353
               Top             =   360
               Value           =   -1  'True
               Width           =   615
            End
            Begin VB.OptionButton OptSI 
               Caption         =   "SI"
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
               Height          =   195
               Left            =   1320
               TabIndex        =   352
               Top             =   360
               Width           =   615
            End
            Begin VB.Label Label21 
               Caption         =   "Cantidad Decimales"
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
               Height          =   255
               Left            =   2760
               TabIndex        =   355
               Top             =   240
               Width           =   1695
            End
         End
         Begin VB.TextBox TxtCtaUSD 
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
            Left            =   150
            MaxLength       =   12
            TabIndex        =   271
            Top             =   300
            Width           =   2385
         End
         Begin VB.ComboBox cmbRGBanco 
            BeginProperty Font 
               Name            =   "Courier New"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   330
            Left            =   3300
            Style           =   2  'Dropdown List
            TabIndex        =   270
            Top             =   330
            Width           =   5000
         End
         Begin VB.Frame AcuCompBilateral 
            Caption         =   "Acuerdo de Comp. Bilateral"
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
            Height          =   495
            Left            =   180
            TabIndex        =   177
            Top             =   1095
            Width           =   2535
            Begin VB.OptionButton Opt_Si 
               Caption         =   "SI"
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
               Left            =   1320
               TabIndex        =   179
               Top             =   180
               Width           =   855
            End
            Begin VB.OptionButton Opt_No 
               Caption         =   "NO"
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
               Left            =   360
               TabIndex        =   178
               Top             =   180
               Value           =   -1  'True
               Width           =   615
            End
         End
         Begin VB.TextBox Txt_DigitoSinacofi 
            Enabled         =   0   'False
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
            Left            =   5200
            MaxLength       =   9
            TabIndex        =   157
            Top             =   870
            Width           =   300
         End
         Begin VB.TextBox TxtRutSinacofi 
            Enabled         =   0   'False
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
            Left            =   3300
            MaxLength       =   9
            TabIndex        =   156
            Top             =   870
            Width           =   1815
         End
         Begin VB.TextBox txtCosto 
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
            Height          =   300
            Left            =   165
            MaxLength       =   5
            TabIndex        =   96
            Top             =   780
            Width           =   2385
         End
         Begin VB.Label lblCodEmpRel 
            AutoSize        =   -1  'True
            Caption         =   "Cód.Empresa Relacionada"
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
            Height          =   195
            Index           =   38
            Left            =   6000
            TabIndex        =   366
            Top             =   660
            Width           =   2235
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            Caption         =   "Código Sinacofi"
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
            Height          =   195
            Index           =   25
            Left            =   3300
            TabIndex        =   155
            Top             =   660
            Width           =   1350
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            Caption         =   "Centro de costo"
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
            Height          =   195
            Index           =   14
            Left            =   150
            TabIndex        =   148
            Top             =   585
            Width           =   1365
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            Caption         =   " Numero Cta Corriente USD"
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
            Height          =   195
            Index           =   23
            Left            =   90
            TabIndex        =   132
            Top             =   105
            Width           =   2340
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            Caption         =   "Relación Gestión Banco"
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
            Height          =   195
            Index           =   24
            Left            =   4245
            TabIndex        =   131
            Top             =   135
            Width           =   2070
         End
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Razón Social"
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
         Height          =   195
         Index           =   18
         Left            =   -74880
         TabIndex        =   146
         Top             =   1500
         Width           =   1500
      End
   End
End
Attribute VB_Name = "BacMntClie"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim CodigoFox       As Double
Dim LimpiaYN        As Boolean
Dim Digito          As String
Public Generico     As String
Dim ValorUlt        As String
Dim ValorAnt        As String
Dim pasa            As String
Dim nDigAval        As String

Dim SQL$, Datos(), Sw%, Norepi%, VarPais%
Dim i%
Dim swauxiliar

Dim mAval()
Dim nContador2 As Integer
Dim nValida     As Boolean
Dim oldRiesgo   As String   'PRD-3826, 08-02-2010
Dim newRiesgo   As String   'PRD-3826
Dim dFechaComDer   As String 'PRD-19121
Dim sExisteCli As String    'PRD-5896


Private Sub Proc_CargaCmbMetRec(Combo As Control)
   Dim Datos()

   If Not Bac_Sql_Execute("SP_CONMETODOLOGIAREC") Then
      Exit Sub
   End If
   Call Combo.Clear
   Do While Bac_SQL_Fetch(Datos())
     'Call cmbMetodologiaREC.AddItem(Trim(Datos(3)) & String(80 - Len(Trim(Datos(3))), " ") & Datos(1) & String(80 - Len(Trim(Datos(1))), " ") & Datos(3))
      Call Combo.AddItem(Trim(Datos(3)) & Space(80) & Datos(1))
   Loop
End Sub

Sub FUNC_CARGA_CIUDADES()

    Envia = Array()
    If Not Bac_Sql_Execute("SP_MNTCLIENTE_LEER_CIUDADES") Then Exit Sub
    CmbCiudad.Clear
    Do While Bac_SQL_Fetch(Datos())
        CmbCiudad.AddItem Trim(Datos(2))
        CmbCiudad.ItemData(CmbCiudad.NewIndex) = Datos(1)
    Loop
End Sub

Function HabilitarControles(Valor As Boolean)
   
   Dim Nuevo_CCG
   
   CuadroBcoReceptor.Enabled = Valor
   
   txtrut.Enabled = Not Valor
   txtDigito.Enabled = Not Valor
   TxtCodigo.Enabled = Not Valor
   Txt1Nombre.Enabled = Valor
   Txt2Nombre.Enabled = Valor
   Txt1Apellido.Enabled = Valor
   Txt2Apellido.Enabled = Valor
   TxtCtaUSD.Enabled = Valor
   TxtCod.Enabled = Valor
   txtmxcontab.Enabled = Valor
   
   For i = 0 To 2
        OpImplic(i).Enabled = Valor
   Next i
   
   txtctacte.Enabled = Valor
   TxtDireccion.Enabled = Valor
   TxtNombre.Enabled = Valor
   TxtFax.Enabled = Valor
   TxtTelefono.Enabled = Valor
   txtCRiesgo.Enabled = Valor

   CmbCiudad.Enabled = Valor
   CmbCalidadJuridica.Enabled = Valor
   CmbMercado.Enabled = Valor
   cmbPais.Enabled = Valor

        
   Toolbar1.Buttons(1).Enabled = Valor
   Toolbar1.Buttons(2).Enabled = Valor
   Toolbar1.Buttons(3).Enabled = Valor
   SSOption1.Enabled = Valor
   SSOption2.Enabled = Valor
   txtCodigoSuper.Enabled = Valor
   txtCodigoBCCH.Enabled = Valor
   txtCosto.Enabled = Valor

   cmbRGBanco.Enabled = Valor
   cmbTipoCliente.Enabled = Valor
   cmbComInstitucional.Enabled = Valor
   cmbRelBanco.Enabled = Valor
   cmbActividadEconomica.Enabled = Valor
   cmbCategoriaDeudor.Enabled = Valor
   cmbClasificacion.Enabled = Valor
   chkInformeSocial.Enabled = Valor
   chkPoder.Enabled = Valor
   chkFirma.Enabled = Valor
   chkOficinas.Enabled = Valor
   TxtCodigoOtc.Enabled = Valor
   ChkBloqueado.Enabled = Valor

   CmbGrupo.Enabled = Valor
   txtCosto.Enabled = Valor

   chk_brokers.Enabled = Valor
   opt_SBroker.Enabled = chk_brokers.Value
   opt_NBroker.Enabled = chk_brokers.Value
   
   chk_Condiciones.Enabled = Valor
   
   fecha_escritura.Enabled = Valor
   nombre_notaria.Enabled = Valor
   
  
   Fr_Avales.Visible = False
            
  'Frame6.Visible = False
    
   SSTab1.TabEnabled(0) = True
   SSTab1.TabEnabled(1) = Valor
   SSTab1.TabEnabled(2) = Valor
   SSTab1.TabEnabled(3) = Valor
   SSTab1.TabEnabled(4) = Valor
    
   SSFrame1.Enabled = Valor
      Me.TxtFechaPacto.Enabled = Valor
      opt_vigente.Item(0).Enabled = Valor
      opt_vigente.Item(1).Enabled = Valor
      ChkCondPacto.Enabled = Valor
      ChkCondPacto.Value = 0
    
    'fecha_firma_nuevo.Text = "01/01/1900"
   fecha_firma_nuevo.Enabled = True
   If Not fecha_firma_nuevo.text = "01/01/1900" Then
      fecha_firma_nuevo.Enabled = False
   End If
   
   Let txtEmail.Enabled = Valor
   
End Function

Sub Inicializa_Pais()
Dim i%

    For i% = 0 To cmbPais.ListCount - 1
         If UCase(Mid(cmbPais.List(i%), 1, 5)) = "CHILE" Then
            cmbPais.ListIndex = i%
            Exit For
         End If
    Next i%
    


    For i% = 0 To CmbCiudad.ListCount - 1
         If UCase(Mid(CmbCiudad.List(i%), 1, 8)) = "SANTIAGO" Or UCase(Mid(CmbCiudad.List(i%), 1, 4)) = "STGO" Then
            CmbCiudad.ListIndex = i%
            Exit For
         End If
    Next i%
    



    For i% = 0 To CmbComuna.ListCount - 1
        If UCase(Mid(CmbComuna.List(i%), 1, 8)) = "SANTIAGO" Or UCase(Mid(CmbComuna.List(i%), 1, 4)) = "STGO" Then
           CmbComuna.ListIndex = i%
           Exit For
        End If
    Next i%
    


End Sub

'Limpiar Pantalla
Sub Limpiar()
   LimpiaYN = True
   
   txtReceptorRutBco.text = 0
   txtReceptorCodBco.text = 0
   lblReceptorNomBco.Caption = ""

   
   Txt1Nombre.text = " "
   Txt2Nombre.text = " "
   Txt1Apellido.text = " "
   Txt2Apellido.text = " "
   Txt1Nombre.Tag = " "
   Txt2Nombre.Tag = " "
   Txt1Apellido.Tag = " "
   Txt2Apellido.Tag = " "
   TxtCod.text = ""
   TxtCtaUSD.text = " "
   txtrut.text = ""
   txtDigito.text = ""
   TxtCodigo.text = 1
   txtgeneric.text = ""
   TxtDireccion.text = ""
   TxtFax.text = ""
   TxtNombre.text = ""
   TxtNombre.Tag = ""
   TxtTelefono.text = ""
   txtctacte.text = ""
   TxtCtaUSD.text = ""
   txtCodigoSuper.text = ""
   txtCodigoBCCH.text = ""
   txtCRiesgo.text = ""
   CmbCalidadJuridica.ListIndex = -1
   CmbComuna.Clear
   CmbCiudad.Clear
   CmbMercado.ListIndex = -1
   cmbPais.ListIndex = -1
   cmbRGBanco.ListIndex = -1
   cmbRelBanco.ListIndex = -1
   cmbCategoriaDeudor.ListIndex = -1
   cmbTipoCliente.ListIndex = -1
   cmbComInstitucional.ListIndex = -1
   cmbActividadEconomica.ListIndex = -1
   cmbClasificacion.ListIndex = -1
   
   chkInformeSocial.Value = 0
   chkPoder.Value = 0
   chkFirma.Value = 0
   chkOficinas.Value = 0
   TxtCodigoOtc.text = ""
   ChkBloqueado.Value = 0
   
   txtCosto.text = ""
   CmbGrupo.ListIndex = -1
   cmbMetodologiaREC.ListIndex = -1
   cmbSegComercial.ListIndex = -1
   
   txtmxcontab.text = 0
   Txt_DigitoSinacofi.text = 0
   TxtRutSinacofi.text = ""
   TxtRutSinacofi.Enabled = False
   chk_brokers.Value = 0
   chk_brokers.Enabled = chk_brokers.Value
   
   chk_Condiciones.Value = 0
   Txt_Fecha_Firma.Enabled = False
   Txt_Fecha_Firma.text = "01/01/1900"
   nombre_notaria.text = ""
   fecha_escritura.text = Format(gsbac_fecp, gsc_FechaDMA)
   
   opt_vigente(0).Value = True 'PRD-5896
   opt_vigente(1).Value = False 'PRD-5896
      
   ' Datos Fusión
   txtSecuencia.text = ""
   txtcodAS400.text = ""
   txtCodCGI.text = ""
      
   SSTab1.Tab = 0
   
   LimpiaYN = False
 
   If SSTab1.Visible = False Then
        SSTab1.Visible = True
   End If
   SSTab1.Tab = 0

   Let ChkCondPacto.Value = 0
   Let TxtFechaPacto.text = "01-01-1900":    Let TxtFechaPacto.Tag = "01-01-1900"
   Let TxtFechaPacto.Enabled = False

    Let txtEmail.text = ""
    
   'INICIO PRD - 21841'''''''''''''''''''''''''''''''
   Me.OptNO.Value = True
   Me.OptSI.Value = False
   Me.TXT_Decimales.Enabled = False
   'FIN PRD - 21841''''''''''''''''''''''''''''''''''
   
'---------------------------------------------------------------------------------
'-------------------------------INICIO FUSÍON-------------------------------------
'-----------------NUEVAS INTERFACES BACEN NORMATIVAS A BRASIL---------------------
'---------------------------------------------------------------------------------
   Cmb_cod_contra.ListIndex = -1
   Cmb_cod_emp_cen.ListIndex = -1
   TxtCodigoCPNJ.text = ""
'---------------------------------------------------------------------------------
'-------------------------------FIN FUSÍON----------------------------------------
'-----------------NUEVAS INTERFACES BACEN NORMATIVAS A BRASIL---------------------
'---------------------------------------------------------------------------------
   
   
 End Sub

Private Function LlenaDatosAval()
   Dim nContador     As Integer
   Dim nContador3    As Integer
   Dim nIndexAval    As Integer
   Dim nDelAv        As Integer
   
   nIndexAval = -1
   
   For nContador = 1 To nContador2
      nIndexAval = nIndexAval + 1
      txtRutAval(nIndexAval).text = mAval(1, nContador)
      txtDvAval(nIndexAval).text = mAval(2, nContador)
      txtNombreAval(nIndexAval).text = mAval(3, nContador)
''''      txtRazonSocial(nIndexAval).Text = mAval(4, nContador)
      txtProfeAval(nIndexAval).text = mAval(5, nContador)
      txtDirenAval(nIndexAval).text = mAval(6, nContador)
      
      For nContador3 = 0 To CmbCiudadAval(nIndexAval).ListCount - 1
         If CmbCiudadAval(nIndexAval).ItemData(nContador3) = mAval(7, nContador) Then
            CmbCiudadAval(nIndexAval).ListIndex = nContador3
            Exit For
         End If
      Next nContador3
      
      For nContador3 = 0 To cmbComunaAval(nIndexAval).ListCount - 1
         If cmbComunaAval(nIndexAval).ItemData(nContador3) = mAval(8, nContador) Then
            cmbComunaAval(nIndexAval).ListIndex = nContador3
            Exit For
         End If
      Next nContador3
      
      txtRutApode1(nIndexAval).text = IIf(mAval(9, nContador) = 0, "", mAval(9, nContador))
      txtDvApode1(nIndexAval).text = mAval(10, nContador)
      txtNomApode1(nIndexAval).text = mAval(11, nContador)
      txtRutApode2(nIndexAval).text = IIf(mAval(12, nContador) = 0, "", mAval(12, nContador))
      txtDvApode2(nIndexAval).text = mAval(13, nContador)
      txtNomApode2(nIndexAval).text = mAval(14, nContador)
      
      For nContador3 = 0 To 4
         If Trim(Right(Cmb_RegimenConyugal(nIndexAval).List(nContador3), 10)) = mAval(15, nContador) Then
            Cmb_RegimenConyugal(nIndexAval).ListIndex = nContador3
            Exit For
         End If
      Next nContador3
            
      ''''txtRegimenConyugal(nIndexAval).Text = mAval(15, nContador)
      txtRutConyAval(nIndexAval).text = IIf(mAval(16, nContador) = 0, "", mAval(16, nContador))
      txtDvConyAval(nIndexAval).text = mAval(17, nContador)
      txtNomConyAval(nIndexAval).text = mAval(18, nContador)
      txtProfConyuge(nIndexAval).text = mAval(19, nContador)
      
      If txtRutAval(nIndexAval).text > 49999999 Then
          Cmb_RegimenConyugal(nIndexAval).ListIndex = Cmb_RegimenConyugal(nIndexAval).ListCount - 1
          Call HabilitaDatoAval(True, nIndexAval)
      Else
          Call HabilitaDatoAval(False, nIndexAval)
      End If
      
   Next nContador
End Function

Private Sub Proc_cmbSegComercial(Combo As Control)
   Dim Datos()

   If Not Bac_Sql_Execute("SP_CON_SEGMENTOSCOMERCIALES") Then
      Exit Sub
   End If
   Call Combo.Clear
   Do While Bac_SQL_Fetch(Datos())
      
      'Call cmbMetodologiaREC.AddItem(Trim(Datos(3)) & String(80 - Len(Trim(Datos(3))), " ") & Datos(1) & String(80 - Len(Trim(Datos(1))), " ") & Datos(3))
      Call Combo.AddItem(Trim(Datos(3)) & Space(80) & Datos(1))
   Loop
End Sub

Function ValidarDatos() As Boolean
   Dim cMensajeError    As String
   Let cMensajeError = ""

   ValidarDatos = False

   If Trim$(TxtCodigo) = "" Then
      Let cMensajeError = cMensajeError & "- Código asociado al Rut en Blanco." & vbCrLf
   End If
   If SSOption1.Value = True Then
      If Trim$(Txt1Nombre) = "" Or Trim$(Txt1Apellido) = "" Or Trim$(Txt2Apellido) = "" Then
         Let cMensajeError = cMensajeError & "- No ha inresado nombres." & vbCrLf
      End If
   Else
      If Trim$(TxtNombre) = "" Then
         Let cMensajeError = cMensajeError & "- Razón social no se ha especificado." & vbCrLf
      End If
   End If
   If cmbTipoCliente.Enabled <> False And cmbTipoCliente.ListIndex = -1 Then
      Let cMensajeError = cMensajeError & "- Debe asignar clasificacion de cliente." & vbCrLf
   End If
   If CmbGrupo.Enabled <> False And CmbGrupo.ListIndex = -1 Then
      Let cMensajeError = cMensajeError & "- Debe asignar grupom de cliente." & vbCrLf
   End If
   If CmbCiudad.Enabled <> False And CmbCiudad.ListIndex = -1 Then
      Let cMensajeError = cMensajeError & "- Debe especificar una Ciudad." & vbCrLf
   End If
   
   If CmbMercado.text = "" Then
      Let cMensajeError = cMensajeError & "- Debe ingresar el mercado." & vbCrLf
   ElseIf CmbCalidadJuridica.text = "" Then
      Let cMensajeError = cMensajeError & "- Debe ingresar el calidad jurídica." & vbCrLf
   ElseIf cmbRelBanco.text = "" Then
      Let cMensajeError = cMensajeError & "- Debe ingresar relación banco." & vbCrLf
   ElseIf cmbCategoriaDeudor.text = "" Then
      Let cMensajeError = cMensajeError & "- Debe ingresar categoria deudor." & vbCrLf
   ElseIf cmbRGBanco.text = "" Then
      Let cMensajeError = cMensajeError & "- Debe ingresar relación gestión banco." & vbCrLf
   End If
   
   If OptFirm_Si.Value = True Then
      If cmbSegComercial.ListIndex = -1 Then
         Let cMensajeError = cMensajeError & "- Debe ingresar segemnto comercial." & vbCrLf
      End If
      If cmbEjecutivoCom.ListIndex = -1 Then
         Let cMensajeError = cMensajeError & "- Debe ingresar ejecutivo comercial." & vbCrLf
      End If
   End If
   If cmbClasificacion.ListIndex = -1 Then
      Let cMensajeError = cMensajeError & "- Debe ingresar clasificación de riesgo." & vbCrLf
   End If
   If ChkBloqueado.Value = 1 Then
      If Len(Trim(txtMotivoBloqueo.text)) = 0 Then
         Let cMensajeError = cMensajeError & "- Debe ingresar un motivo de bloqueo." & vbCrLf
      End If
   End If
   If txtCosto.text = "" Then
      Let cMensajeError = cMensajeError & "- Debe asignar un centro de costo." & vbCrLf
   End If
   
   If Len(cMensajeError) > 0 Then
      Call MsgBox("ERRORES : " & vbCrLf & vbCrLf & cMensajeError, vbCritical, App.Title)
   Else
      ValidarDatos = True
   End If
End Function



Private Sub AcuCompBilateral_Click()
' 14/12/2008 Acuerdo de Compensación Bilateral, no aplica para clientes Empresa y Personas Naturales
  If cmbTipoCliente.ListIndex = 5 Or cmbTipoCliente.ListIndex = 11 Then
          Opt_No.Enabled = False
          Opt_Si.Enabled = False
          MsgBox "Acuerdo Compensación Bilateral no aplica, " & vbCrLf & vbCrLf & "para Empresas y Personas Naturales.", vbInformation, TITSISTEMA
  Else
          Opt_No.Enabled = True
          Opt_Si.Enabled = True
  End If
  
End Sub

Private Sub BtnAval_Click()
   Dim nContador     As Integer
   Dim nIndexAval    As Integer
   Dim nDelAv        As Integer
   
   nIndexAval = -1
   
   If txtrut.text <> "" Then
      Fr_Avales.Visible = True
      Fr_Avales.Left = 45
      Fr_Avales.Top = 450
      
      If SSTab2.Visible = True Then
         SSTab2.Tab = 0
      End If
   
      FUNC_CARGA_CIUDADES_Aval
      CargaComboCantAvales
      
      For nContador = 0 To 4
         Cmb_RegimenConyugal(nContador).Clear
      
         Cmb_RegimenConyugal(nContador).AddItem "soltero" & Space(80) & "STRO"
         Cmb_RegimenConyugal(nContador).AddItem "casado(a) y separado(a) totalmente de bienes" & Space(80) & "CSDOSB"
         Cmb_RegimenConyugal(nContador).AddItem "casado(a) bajo el régimen de sociedad conyugal" & Space(80) & "CSDOSC"
         Cmb_RegimenConyugal(nContador).AddItem "casado(a) bajo el régimen de participación en los gananciales" & Space(80) & "CSDOPG"
         Cmb_RegimenConyugal(nContador).AddItem "no aplica" & Space(80) & "NA"
      Next nContador
      
      For nDelAv = 0 To 4
         chkEliminaAval(nDelAv).Value = 0
      Next nDelAv

      If mAval(1, 1) = "*" Then
         If BuscaAval Then
            Exit Sub
         End If
      Else
         nContador2 = UBound(mAval, 2)
         Call LlenaDatosAval

         SSTab2.Visible = True
      
         For nContador = 0 To SSTab2.Tabs - 1
            If nContador > nContador2 - 1 Then
               SSTab2.TabVisible(nContador) = False
               SSTab2.TabEnabled(nContador) = False
            Else
               SSTab2.TabVisible(nContador) = True
               SSTab2.TabEnabled(nContador) = True
               SSTab2.Visible = True
            End If
         
         Next nContador

      cmbCantAvales.ListIndex = nContador2

      End If
   Else
      MsgBox "Debe Ingresar o Seleccionar Cliente antes de Ingresar AVAL", vbExclamation, TITSISTEMA
      Exit Sub
   End If
End Sub

Private Sub chk_brokers_Click()
 
  If chk_brokers.Value = False Then
     opt_SBroker.Enabled = False
     opt_NBroker.Enabled = False
     opt_SBroker.Value = False
     opt_NBroker.Value = False
  Else
     opt_SBroker.Enabled = True
     opt_NBroker.Enabled = True
     opt_NBroker.Value = True
  End If
End Sub

Private Sub chk_Condiciones_Click()
    If chk_Condiciones.Value = 1 Then
        Txt_Fecha_Firma.Enabled = True
        Txt_Fecha_Firma.SetFocus
    Else
        Txt_Fecha_Firma.Enabled = False
        Txt_Fecha_Firma.text = "01/01/1900"
    End If
End Sub

Private Sub ChkBloqueado_Click()
    If ChkBloqueado.Value = 1 Then
        Frame10.Enabled = True
    Else
        Frame10.Enabled = False
    End If
End Sub

Private Sub ChkCondPacto_Click()
   Let TxtFechaPacto.Enabled = ChkCondPacto.Value
   
   If TxtFechaPacto.Enabled = False Then
      TxtFechaPacto.Tag = TxtFechaPacto.text
      TxtFechaPacto.text = "01-01-1900"
   Else
      If TxtFechaPacto.Tag <> "" Then
         Let TxtFechaPacto.text = TxtFechaPacto.Tag
      End If
   End If
   
End Sub

Private Sub Cmb_RegimenConyugal_Click(Index As Integer)
   
   If SSTab2.TabVisible(Index) = True And Fr_Avales.Visible = True Then
      If Val(txtRutAval(Index).text) < 50000000 Then
         If Cmb_RegimenConyugal(Index).ListIndex = Cmb_RegimenConyugal(Index).ListCount - 1 Then
         Screen.MousePointer = vbDefault
         MsgBox "Para personas naturales debe seleccionar una de las primeras 3 opciones", vbExclamation + vbOKOnly
         Cmb_RegimenConyugal(Index).ListIndex = -1
         Cmb_RegimenConyugal(Index).SetFocus
         
         Else
            If Cmb_RegimenConyugal(Index).text = "SOLTERO" Then
               txtRutConyAval(Index).Enabled = False
               txtRutConyAval(Index).text = ""
               txtDvConyAval(Index).Enabled = False
               txtDvConyAval(Index).text = ""
               txtNomConyAval(Index).Enabled = False
               txtNomConyAval(Index).text = ""
               txtProfConyuge(Index).Enabled = False
               txtProfConyuge(Index).text = ""
            Else
               txtRutConyAval(Index).Enabled = True
               txtDvConyAval(Index).Enabled = True
               txtNomConyAval(Index).Enabled = True
               txtProfConyuge(Index).Enabled = True
            End If
         End If
      End If
   End If

End Sub

Private Sub cmbActividadEconomica_KeyPress(KeyAscii As Integer)
    If KeyAscii% = vbKeyReturn Then
        KeyAscii% = 0
        Sendkeys$ "{TAB}"
    End If
End Sub

Private Sub CmbCalidadJuridica_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then Sendkeys "{TAB}"
End Sub

Private Sub cmbCantAvales_Click()
Dim nContador As Integer

    If cmbCantAvales.text = 0 Then
        SSTab2.Visible = False
        Exit Sub
    End If
    SSTab2.Visible = True
    
    For nContador = 0 To SSTab2.Tabs - 1
        If nContador > cmbCantAvales.text - 1 Then
            SSTab2.TabVisible(nContador) = False
            SSTab2.TabEnabled(nContador) = False
        Else
            SSTab2.TabVisible(nContador) = True
            SSTab2.TabEnabled(nContador) = True
            SSTab2.Visible = True
        End If
    Next nContador
    SSTab2.Tab = 0
End Sub

Private Sub cmbCategoriaDeudor_KeyPress(KeyAscii As Integer)
    If KeyAscii% = vbKeyReturn Then
        KeyAscii% = 0
        Sendkeys$ "{TAB}"
    End If
End Sub

Private Sub CmbCiudad_Click()
Dim SQL As String
Dim Hay As Boolean
Dim Datos()

    Hay = False
    If Not LimpiaYN Then
        Envia = Array()
    
        If cmbPais.ListIndex > -1 And CmbCiudad.ListIndex > -1 Then
            AddParam Envia, cmbPais.ItemData(cmbPais.ListIndex)
            AddParam Envia, CmbCiudad.ItemData(CmbCiudad.ListIndex)
            If Not Bac_Sql_Execute("SP_LEERCOM ", Envia) Then Exit Sub
                CmbComuna.Clear
                Do While Bac_SQL_Fetch(Datos())
                    Hay = True
                    CmbComuna.AddItem Trim(Datos(2))
                    CmbComuna.ItemData(CmbComuna.NewIndex) = Datos(1)
             
                Loop
                If Hay Then
                    CmbComuna.ListIndex = 0
                End If
            End If
    
    End If
End Sub

Private Sub CmbCiudad_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then Sendkeys "{TAB}"
End Sub

Private Sub CmbCiudadAval_Click(Index As Integer)
Dim SQL     As String
Dim Hay     As Boolean
Dim nIndex  As Long

Dim Datos()
    nIndex = Index
    

    Hay = False
    If Not LimpiaYN Then
        Envia = Array()
    
        If CmbCiudadAval(nIndex).ListIndex > -1 Then
            AddParam Envia, 6
            AddParam Envia, CmbCiudadAval(nIndex).ItemData(CmbCiudadAval(nIndex).ListIndex)
            If Not Bac_Sql_Execute("SP_LEERCOM ", Envia) Then Exit Sub
                cmbComunaAval(nIndex).Clear
                Do While Bac_SQL_Fetch(Datos())
                    Hay = True
                    cmbComunaAval(nIndex).AddItem Trim(Datos(2))
                    cmbComunaAval(nIndex).ItemData(cmbComunaAval(nIndex).NewIndex) = Datos(1)
             
                Loop
                If Hay Then
                    cmbComunaAval(nIndex).ListIndex = 0
                End If
            End If
    
    End If
End Sub

Private Sub CmbCiudadAval_KeyPress(Index As Integer, KeyAscii As Integer)
    If KeyAscii% = vbKeyReturn Then
        KeyAscii% = 0
        Sendkeys$ "{TAB}"
    End If
End Sub

Private Sub cmbclasificacion_KeyPress(KeyAscii As Integer)
    If KeyAscii% = vbKeyReturn Then
        KeyAscii% = 0
        Sendkeys$ "{TAB}"
    End If
End Sub

Private Sub cmbComInstitucional_KeyPress(KeyAscii As Integer)
    If KeyAscii% = vbKeyReturn Then
        KeyAscii% = 0
        Sendkeys$ "{TAB}"
    End If
End Sub

Private Sub cmbComuna_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then Sendkeys "{TAB}"
End Sub

Private Sub cmbComunaAval_KeyPress(Index As Integer, KeyAscii As Integer)
    If KeyAscii% = vbKeyReturn Then
        KeyAscii% = 0
        Sendkeys$ "{TAB}"
    End If
End Sub

Private Sub CmbMercado_KeyPress(KeyAscii As Integer)
  If KeyAscii = 13 Then Sendkeys "{TAB}"
End Sub

Private Sub cmbPais_Click()

Dim SQL As String
Dim Hay As Boolean
Dim largo
Dim entero
Dim aux
'LLena combo con ciudad
Hay = False

If Not LimpiaYN Then

    If cmbPais.text <> "" Then
       Envia = Array()
        
      If cmbPais.text = "CHILE" Then
        Label(11).Caption = "Ciudad"
        CmbComuna.Enabled = True
                
        AddParam Envia, cmbPais.ItemData(cmbPais.ListIndex)
        
        If Not Bac_Sql_Execute("SP_LEERCIUAUX ", Envia) Then
          Exit Sub
        End If
        
        CmbCiudad.Clear
        Do While Bac_SQL_Fetch(Datos())
          CmbCiudad.AddItem Trim(Datos(2))
          CmbCiudad.ItemData(CmbCiudad.NewIndex) = Datos(1)
        Loop
        
      Else
        CmbComuna.ListIndex = -1
        Label(11).Caption = "Plaza"
        CmbComuna.Enabled = False
        AddParam Envia, cmbPais.ItemData(cmbPais.ListIndex)
        
        If Not Bac_Sql_Execute("SP_MOSTRAR_PLAZA ", Envia) Then
           Exit Sub
        End If
        
        CmbCiudad.Clear
        Do While Bac_SQL_Fetch(Datos())
           Hay = True
           CmbCiudad.AddItem Trim(Datos(3))
           CmbCiudad.ItemData(CmbCiudad.NewIndex) = Datos(1)
        Loop
        
        If Hay Then
           CmbCiudad.ListIndex = 0
        End If
      End If
  End If
End If
End Sub

Private Sub cmbPais_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then Sendkeys "{TAB}"
End Sub

Private Sub cmbRelBanco_KeyPress(KeyAscii As Integer)
If KeyAscii% = vbKeyReturn Then
      KeyAscii% = 0
      Sendkeys$ "{TAB}"
End If
End Sub


Private Sub cmbRGBanco_KeyPress(KeyAscii As Integer)
If KeyAscii% = vbKeyReturn Then
      KeyAscii% = 0
      Sendkeys$ "{TAB}"
End If
End Sub

Private Sub cmbSegComercial_Click()
   Dim iSegmento  As Integer

   If cmbSegComercial.ListIndex = -1 Then
      Exit Sub
   End If

   Let iSegmento = Trim(Right(cmbSegComercial.text, 10)) 'PRD-8800 cmbSegComercial.ItemData(cmbSegComercial.ListIndex)

   Let cmbClasificacion.Enabled = True
   If iSegmento = 1 Or iSegmento = 2 Then
      Let cmbClasificacion.ListIndex = Busca_Codigo_Combo(cmbClasificacion, " ")
      Let cmbClasificacion.Enabled = False
   End If
End Sub

Private Sub cmbTipoCliente_Click()
    If cmbTipoCliente.ListIndex = 5 Or cmbTipoCliente.ListIndex = 11 Then
        Opt_No.Enabled = False
        Opt_Si.Enabled = False
    Else
        Opt_No.Enabled = True
        Opt_Si.Enabled = True
    End If
End Sub

Private Sub cmbTipoCliente_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then Sendkeys "{TAB}"
End Sub
Private Sub CmbGrupo_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then Sendkeys "{TAB}"
End Sub

Private Sub Cmd_VolverAval_Click()
   Dim nContador  As Integer
   Dim nIndex     As Integer
   Dim nIndice1  As Integer
   
   nIndice1 = SSTab2.Tab
   
   If Not ExisteAval(nIndice1) Then
     MsgBox "Aval Ya Existe " & "(" & SSTab2.Caption & ")", vbExclamation, TITSISTEMA
     Call HabilitaDatoAvalEx(False, nIndice1)
     nValida = False
     Screen.MousePointer = vbDefault
     Exit Sub
   End If

   If Not ValidaDatosAval Then
     nValida = False
      Exit Sub
   End If

   nContador = 0
   
   If cmbCantAvales.text > 0 Then
      ReDim mAval(20, 1)
      For nIndex = 0 To cmbCantAvales.text - 1
         'If SSTab2.TabVisible(nContador) = True And chkEliminaAval(nContador).Value = 0 Then
         If SSTab2.TabVisible(nIndex) = True And chkEliminaAval(nIndex).Value = 0 Then
            nContador = nContador + 1
            ReDim Preserve mAval(20, nContador)
            mAval(1, nContador) = txtRutAval(nIndex).text
            mAval(2, nContador) = txtDvAval(nIndex).text
            mAval(3, nContador) = txtNombreAval(nIndex).text
            mAval(4, nContador) = txtNombreAval(nIndex).text ''''txtRazonSocial(nIndex).Text
            mAval(5, nContador) = txtProfeAval(nIndex).text
            mAval(6, nContador) = txtDirenAval(nIndex).text
            mAval(7, nContador) = CmbCiudadAval(nIndex).ItemData(CmbCiudadAval(nIndex).ListIndex)
            mAval(8, nContador) = cmbComunaAval(nIndex).ItemData(cmbComunaAval(nIndex).ListIndex)
            mAval(9, nContador) = txtRutApode1(nIndex).text
            mAval(10, nContador) = txtDvApode1(nIndex).text
            mAval(11, nContador) = txtNomApode1(nIndex).text
            mAval(12, nContador) = txtRutApode2(nIndex).text
            mAval(13, nContador) = txtDvApode2(nIndex).text
            mAval(14, nContador) = txtNomApode2(nIndex).text
            mAval(15, nContador) = Trim(Right(Cmb_RegimenConyugal(nIndex).text, 10))
            mAval(16, nContador) = txtRutConyAval(nIndex).text
            mAval(17, nContador) = txtDvConyAval(nIndex).text
            mAval(18, nContador) = txtNomConyAval(nIndex).text
            mAval(19, nContador) = txtProfConyuge(nIndex).text
            mAval(20, nContador) = IIf(chkEliminaAval(nIndex).Value = 1, "S", "N")
         End If
      Next nIndex
   End If
   
   Fr_Avales.Visible = False
   Fr_Avales.Top = 1000
   SSTab2.Visible = False
End Sub

Private Sub Fecha_Contrato_Comder_Change()
'PRD 19121
    If dFechaComDer <> Fecha_Contrato_Comder.text Then
        dFechaComDer = Fecha_Contrato_Comder.text
        If (CDate(Fecha_Contrato_Comder.text) > Format(gsbac_fecp, "dd-mm-yyyy")) Then
            Call MsgBox("La Fecha de Contrato ComDer Excede la Fecha Actual!", vbExclamation, App.Title)
        End If
    End If
End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)

    Top = 1
    Left = 15
    Norepi = 0
    CodigoFox = 0
    
    Me.Icon = BACSwapParametros.Icon
    
    If KeyAscii = 13 Then Sendkeys "{TAB}"

End Sub

Private Sub Form_Load()
   On Error GoTo ErrMDB

   Me.Top = 0
   Me.Left = 0
   LimpiaYN = False
   
   swauxiliar = 0
       
   oldRiesgo = ""
   newRiesgo = ""
       
   Call Carga
       
   Call Grabar_Log_AUDITORIA(gsEntidad _
                                 , gsbac_fecp _
                                 , gsBac_IP _
                                 , gsUsuario _
                                 , "PCA" _
                                 , "opc_21" _
                                 , "07" _
                                 , "Usuario entra en Mantención de Cliente" _
                                 , " " _
                                 , " " _
                                 , " ")
   
   OpImplic(2).Value = True
   
   Call HabilitarControles(False)
   TxtNombre.Enabled = False
   Toolbar1.Buttons(3).Enabled = True
   
   SSTab1.Tab = 0
   Txt_Fecha_Firma.text = "01/01/1900"
   Txt_Fecha_Firma.Enabled = False
   chk_Condiciones.Value = 0
   CheckFM.Value = 0
   'Frame6.Visible = False
   
   Fr_Avales.Visible = False

   SSTab1.TabEnabled(0) = True
   SSTab1.TabEnabled(1) = False
   SSTab1.TabEnabled(2) = False
   SSTab1.TabEnabled(3) = False
   SSTab1.TabEnabled(4) = False
   
   Call CargaContrato
   Call LimpiaAvales
   
   dFechaComDer = "01-01-1900"  'PRD 19121
   
   Me.CmbColateral.AddItem "CLP"
   Me.CmbColateral.AddItem "USD"
   Me.CmbColateral.ListIndex = 1
   Me.CmbColateral.text = "CLP"
   
Exit Sub

ErrMDB:
   MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical, TITSISTEMA
   Unload Me
   Exit Sub
End Sub

Sub CargaContrato()
   Dim SQL As String
   Dim Datos()
     
   If Not Bac_Sql_Execute("SP_CARGAVERCONTRATO") Then Exit Sub
   CmbVerContratos.AddItem ""
   
   Do While Bac_SQL_Fetch(Datos())
      CmbVerContratos.AddItem Trim(Datos(6))
      CmbVerContratos.ItemData(CmbVerContratos.NewIndex) = Datos(2)
   Loop

End Sub

Private Sub Form_Unload(Cancel As Integer)
   
   Call Grabar_Log_AUDITORIA(gsEntidad _
                                 , gsbac_fecp _
                                 , gsBac_IP _
                                 , gsUsuario _
                                 , "PCA" _
                                 , "opc_21" _
                                 , "08" _
                                 , "Usuario Cierra Mantención de Cliente" _
                                 , " " _
                                 , " " _
                                 , " ")

End Sub

Private Sub nombre_notaria_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = 13 Then
        Sendkeys "{tab}"
    End If
End Sub

Private Sub nombre_notaria_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        Sendkeys "{tab}"
    End If
End Sub

Private Sub Opt_No_Click()
' 14/12/2008 Acuerdo de Compensación Bilateral, no aplica para clientes Empresa y Personas Naturales
  If cmbTipoCliente.ListIndex = 5 Or cmbTipoCliente.ListIndex = 11 Then
          Opt_No.Enabled = False
          Opt_Si.Enabled = False
  Else
          Opt_No.Enabled = True
          Opt_Si.Enabled = True
  End If

End Sub

Private Sub Opt_Si_Click()
' 14/12/2008 Acuerdo de Compensación Bilateral, no aplica para clientes Empresa y Personas Naturales
  If cmbTipoCliente.ListIndex = 5 Or cmbTipoCliente.ListIndex = 11 Then
          Opt_No.Enabled = False
          Opt_Si.Enabled = False
  Else
          Opt_No.Enabled = True
          Opt_Si.Enabled = True
  End If

End Sub

Private Sub OptComDer_No_Click()
    Fecha_Contrato_Comder.Enabled = False
End Sub

Private Sub OptComDer_Si_Click()
  Fecha_Contrato_Comder.Enabled = True
End Sub

Private Sub OptFirm_No_Click()
'    btnMtnContratos.Enabled = False
    BtnAval.Enabled = False
    CmbVerContratos.Enabled = True
    fecha_firma_nuevo.Enabled = False

' Deshabilita Firma Contrato - PRD 19121
    OptComDer_No.Enabled = False
    OptComDer_Si.Enabled = False
    
    Fecha_Contrato_Comder.Enabled = False
    OptComDer_No.Value = True

End Sub

Private Sub OptFirm_Si_Click()
'    btnMtnContratos.Enabled = True
    BtnAval.Enabled = True
    CmbVerContratos.Enabled = False
    fecha_firma_nuevo.Enabled = True
    
  ' Habilita Firma Contrato - PRD 19121
    OptComDer_No.Enabled = True
    OptComDer_Si.Enabled = True
    
    OptComDer_Si.Value = False
    OptComDer_No.Value = True
    
  
End Sub

Private Function FuncSeekIndex(ByVal iCodigo As Integer)
   Dim nContador  As Integer
   
   For nContador = 0 To cmbTipoCliente.ListCount - 1
      If cmbTipoCliente.ItemData(nContador) = iCodigo Then
         cmbTipoCliente.ListIndex = nContador
         Exit For
      End If
   Next nContador
   
End Function


Private Sub OptNO_Click()
If OptNO.Value = True Then
    Me.TXT_Decimales.Enabled = False
    Me.TXT_Decimales.text = ""
End If
End Sub

Private Sub OptSI_Click()
'PRD - 21841
If OptSI.Value = True Then
    Me.TXT_Decimales.Enabled = True
End If

End Sub


Private Sub SSOption1_Click(Value As Integer)
    TipoNombre True
    
'   If Value = -1 Then
'       Call FuncSeekIndex(8)
'       cmbTipoCliente.Enabled = False
'   Else
'      cmbTipoCliente.Enabled = True
'   End If
    
    SSOption1.Tag = txtgeneric.text

 ' Txt1Nombre.Text = Txt1Nombre.Tag
 ' Txt2Nombre.Text = Txt2Nombre.Tag
 ' Txt1Apellido.Text = Txt1Apellido.Tag
 ' Txt2Apellido.Text = Txt2Apellido.Tag

   Txt1Nombre.Enabled = True
   Txt2Nombre.Enabled = True
   Txt1Apellido.Enabled = True
   Txt2Apellido.Enabled = True

 ' TxtNombre.Tag = TxtNombre.Text
 ' TxtNombre = ""

    TxtNombre.Enabled = False
   
   If Len(TxtNombre.text) > 0 Then
      Let SSOption2.Value = 1
      If TxtNombre.Enabled = True Then
         Call TxtNombre.SetFocus
      End If
   Else
      If Txt1Apellido.Enabled = True Then
    Txt1Apellido.SetFocus
      End If
   End If

End Sub

Private Sub SSOption2_Click(Value As Integer)
    TipoNombre False

    If SSOption1.Tag <> "" Then
      txtgeneric.text = SSOption1.Tag
    End If

    txtgeneric.Enabled = True

 ' Txt1Nombre.Tag = Txt1Nombre.Text
 ' Txt2Nombre.Tag = Txt2Nombre.Text
 ' Txt1Apellido.Tag = Txt1Apellido.Text
 ' Txt2Apellido.Tag = Txt2Apellido.Text
    
    Txt1Nombre.Enabled = False
    Txt2Nombre.Enabled = False
    Txt1Apellido.Enabled = False
    Txt2Apellido.Enabled = False

'    TxtNombre.Text = TxtNombre.Tag
    TxtNombre.Enabled = True
End Sub

Private Sub SSTab1_Click(PreviousTab As Integer)
   
   '--> Valida si es un ingreso
   
   If sExisteCli = "N" Then
   '--> Juridico ; Natural
    If SSOption1.Value = True And txtrut.text <> "" Then 'si se agrega un valor en el mantenedor de tablas generales para la
        If SSTab1.Tab = 2 Then                           'categoria de clasificacion cliente(categoria 72) se debe tener en cuenta
            cmbTipoCliente.ListIndex = 11                'estas lineas, el listindex 11 es persona natural
            CmbCalidadJuridica.ListIndex = 2
            cmbCategoriaDeudor.ListIndex = 1
        End If
    End If
   End If
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Dim CODI          As Variant
   Dim Codigo        As Integer
   Dim Nombre        As String * 70
   Dim Implic        As String
   Dim opcion        As String
   Dim Aba           As String
   Dim Chips         As String
   Dim Swift         As String
   Dim tipocliente   As String
   Dim grupo         As String
   Dim InformeSocial As String
   Dim Articulo85    As String
   Dim FechaArt85    As Date
   Dim DecArticulo85 As String
   Dim Poder         As String
   Dim Firma         As String
   Dim fecingr       As Date
   Dim Oficina       As String
   Dim Rut_Grupo     As Double
   Dim SQL           As String
   Dim Datos()       As String
   Dim Valor         As Integer
   Dim ejecutivo     As Integer
   Dim sBroker       As String
   Dim sFirma_Condic As String
   Dim sFirma_Fecha  As String
  'PRD-3826, 05-02-2010
   Dim segComercial  As String
   Dim ejeComercial  As String
   Dim motivoBloq    As String
   Dim gtiaTotal     As Double
      
   Select Case Button.Index 'Graba Registro
      Case 1

         Call FuncSaveData

      Case 2 'Elimina Registro

         Envia = Array()
         AddParam Envia, CDbl(txtrut.text)
         AddParam Envia, Trim(txtDigito)
         AddParam Envia, CDbl(TxtCodigo.text)
         If Not Bac_Sql_Execute("SP_MDCLLEERRUT", Envia) Then
            MsgBox "Consulta en Bactrader Ha Fallado. Servidor SQL No Responde", vbCritical, TITSISTEMA
            Exit Sub
         End If

         If Bac_SQL_Fetch(Datos()) Then
            Envia = Array()
            AddParam Envia, CDbl(txtrut.text)
            If Bac_Sql_Execute("SP_BUSCAR_CLIENTES", Envia) Then
               If Bac_SQL_Fetch(Datos()) Then
                  Valor = Datos(1)
               End If
               If Valor <> 0 Then
                  MsgBox "Cliente Tiene Operaciones Pendientes", vbCritical, TITSISTEMA
                  If MsgBox("Esta Seguro de Eliminar el Cliente", 36, TITSISTEMA) <> 6 Then
                     Exit Sub
                  End If
               End If
            End If

            Envia = Array()
            AddParam Envia, CDbl(txtrut.text)
            AddParam Envia, CDbl(TxtCodigo.text)
            If Bac_Sql_Execute("SP_CLELIMINAR1", Envia) Then
              If Bac_SQL_Fetch(Datos()) Then
                  MsgBox Datos(1), vbInformation, TITSISTEMA
              End If
            End If

            Call Limpiar
            Call LimpiaAvales
            Call HabilitarControles(False)

            Toolbar1.Buttons(3).Enabled = True
            txtrut.SetFocus
         Else
            MsgBox "Los datos no han sido grabados", vbCritical, TITSISTEMA
         End If

      Case 3 ' Limpia los campos
         Call Limpiar
         Call LimpiaAvales
         Call HabilitarControles(False)
         Toolbar1.Buttons(3).Enabled = True
         SSTab1.Tab = 0
         txtrut.SetFocus

      Case 4 'Salir de la aplicacion
         On Error Resume Next
         BacRelacionCliente.Show 1
         On Error GoTo 0
      Case 5
         Call Unload(Me)
   End Select
End Sub

Private Sub Txt1Apellido_KeyPress(KeyAscii As Integer)
    Txt1Apellido.MaxLength = 15
    BacToUCase KeyAscii
    
    If KeyAscii = 13 Then
        Sendkeys "{tab}"
    End If
End Sub

Private Sub Txt1Nombre_KeyPress(KeyAscii As Integer)
    Txt1Nombre.MaxLength = 15
    BacToUCase KeyAscii
    
    If KeyAscii = 13 Then
        Txt2Nombre.SetFocus
    End If
End Sub

Private Sub Txt2Apellido_KeyPress(KeyAscii As Integer)
    Txt2Apellido.MaxLength = 15
    BacToUCase KeyAscii
    
    If KeyAscii = 13 Then
        Txt1Nombre.SetFocus
    End If
End Sub

Private Sub Txt2Nombre_KeyPress(KeyAscii As Integer)
    Txt2Nombre.MaxLength = 15
    BacToUCase KeyAscii

    If KeyAscii = 13 Then
        Sendkeys "{tab}"
    End If
End Sub
Private Sub txtCodigo_KeyPress(KeyAscii As Integer)
    If KeyAscii% = vbKeyReturn Then
        KeyAscii% = 0
        Sendkeys "{TAB}"
    ElseIf Not ((KeyAscii > 47 And KeyAscii < 58) Or KeyAscii = 8) Then
        KeyAscii = 0
        BacCaracterNumerico KeyAscii
    End If
End Sub
Function Totaliza_Garantias_Cliente(ByVal nroRut As Long, ByVal xCodigo As Long) As Boolean
Dim Datos()
Envia = Array()
AddParam Envia, CDbl(nroRut)
AddParam Envia, CDbl(xCodigo)
If Not Bac_Sql_Execute("Bacparamsuda.dbo.SP_TOTALGARANTIASCLIENTE", Envia) Then
    MsgBox "Error en consulta de Total de Garantías del Cliente!", vbExclamation, TITSISTEMA
    Totaliza_Garantias_Cliente = False
    Exit Function
End If
If Bac_SQL_Fetch(Datos()) Then
    txtGarantiaTotal.text = Format(Datos(1), FEntero)
End If

End Function
Function Busca_Cliente(nRut As Long, nDigito As String, nCodigo As Long) As Boolean
   Dim SQL As String
   Dim datosSTR As String
   Dim nCont As Integer
   Dim Texto1
   Dim Texto2
   Dim DA
   Dim DA2
   Dim X
   Dim x2
   Dim Datos()

   Screen.MousePointer = vbHourglass
    Busca_Cliente = False
    sExisteCli = "N"
    
    Envia = Array()
    
    AddParam Envia, CDbl(nRut)
    AddParam Envia, nDigito
    AddParam Envia, CDbl(nCodigo)
          
                If Not Bac_Sql_Execute("SP_MDCLLEERRUT", Envia) Then
        
        MsgBox "Consulta en BacParametros Ha Fallado. Servidor SQL No Responde", vbCritical, TITSISTEMA
        Exit Function
    
    End If

    If Bac_SQL_Fetch(Datos()) Then
        'TEXTOS
        txtrut.text = Val(Datos(1))
        txtDigito.text = Datos(2)
        TxtCodigo.text = Val(Datos(3))
        TxtNombre.text = Datos(4)
        TxtNombre.Tag = TxtNombre.text
        TxtDireccion.text = Datos(6)
        txtctacte.text = Datos(11)
        TxtTelefono.text = Datos(12)
        TxtFax.text = Datos(13)
        Txt1Nombre.text = Datos(22)
        Txt1Nombre.Tag = Txt1Nombre.text
        Txt2Nombre.text = Datos(23)
        Txt2Nombre.Tag = Txt2Nombre.text
        Txt1Apellido.text = Datos(24)
        Txt1Apellido.Tag = Txt1Apellido.text
        Txt2Apellido.text = Datos(25)
        Txt2Apellido.Tag = Txt2Apellido.text
        TxtCtaUSD.text = Datos(27)
        txtCodigoSuper.text = Val(Datos(49))
        txtCodigoBCCH.text = Val(Datos(50))
        txtCRiesgo.text = Datos(55)
        txtmxcontab.text = Datos(60)
        fecha_escritura.text = Datos(69)
        nombre_notaria.text = Datos(70)
        Select Case Datos(63)
            Case "S"
                chk_brokers.Value = 1
                opt_SBroker.Value = True
            Case "N"
                 chk_brokers.Value = 1
                 opt_NBroker.Value = True
        End Select
        'FM ini 19-05-2008
        Select Case Datos(71)
            Case "S"
                CheckFM.Value = 1
            Case "N"
                CheckFM.Value = 0
            Case ""
                CheckFM.Value = 0
            End Select
        'FM ini 19-05-2008
        SSOption2 = IIf(Datos(32) = "J", True, False)
        SSOption1 = IIf(Datos(32) = "N", True, False)
        SSOption1.Tag = Datos(5)
        txtgeneric.text = IIf(Datos(32) = "J", Datos(5), "")
        If Datos(21) <> 6 Then 'Cliente Externo
            TxtRutSinacofi.Enabled = True
            TxtRutSinacofi.text = IIf(IsNull(Datos(61)), 0, Datos(61))
            Txt_DigitoSinacofi.text = IIf(IsNull(Datos(62)), "", Datos(62))
        End If
      
        If cmbPais.ListIndex > -1 Then
            For nCont = 0 To cmbPais.ListCount - 1
                If cmbPais.ItemData(nCont) = Val(Datos(21)) Then
                    cmbPais.ListIndex = nCont
                    Exit For
                End If
         Next nCont
        End If
        If CmbCiudad.ListIndex > -1 Then
            For nCont = 0 To CmbCiudad.ListCount - 1
                If CmbCiudad.ItemData(nCont) = Val(Datos(16)) Then
                    CmbCiudad.ListIndex = nCont
                    If cmbPais.text = "CHILE" Then
                        CmbComuna.Enabled = True
                    Else
                        CmbComuna.Enabled = False
                    End If
                    Exit For
                End If
         Next nCont
        End If
        If CmbComuna.ListIndex > -1 Then
            For nCont = 0 To CmbComuna.ListCount - 1
                If CmbComuna.ItemData(nCont) = Val(Datos(7)) Then
                    CmbComuna.ListIndex = nCont
                    Exit For
                End If
         Next nCont
        End If
        If CmbCalidadJuridica.ListCount > 0 Then
            CmbCalidadJuridica.ListIndex = Busca_Codigo_Combo(CmbCalidadJuridica, Str(Datos(15)))
        End If
        If CmbMercado.ListCount > 0 Then
            CmbMercado.ListIndex = Busca_Codigo_Combo(CmbMercado, Str(Datos(18)))
        End If
        If cmbRGBanco.ListCount > 0 Then
            cmbRGBanco.ListIndex = Busca_Codigo_Combo(cmbRGBanco, Str(Datos(33)))
        End If
      
        If cmbCategoriaDeudor.ListCount > 0 Then
            cmbCategoriaDeudor.ListIndex = Busca_Codigo_Combo(cmbCategoriaDeudor, Str(Datos(34)))
        End If
        
        If cmbComInstitucional.ListCount > 0 Then
            cmbComInstitucional.ListIndex = Busca_Codigo_Combo(cmbComInstitucional, Str(Datos(35)))
        End If
        
        If cmbClasificacion.ListCount > 0 Then
            datosSTR = Datos(36)
            cmbClasificacion.ListIndex = Busca_Codigo_Combo(cmbClasificacion, datosSTR)
        End If
        
        If cmbActividadEconomica.ListCount > 0 Then
            cmbActividadEconomica.ListIndex = Busca_Codigo_Combo(cmbActividadEconomica, Str(Datos(37)))
        End If
  
        ' 14/12/2008 Acuerdo de Compensación Bilateral, no aplica para clientes Empresa y Personas Naturales
        If (Datos(14) = 7 Or Datos(14) = 8) Then
            Opt_No.Enabled = False
            Opt_Si.Enabled = False
        Else
            Opt_No.Enabled = True
            Opt_Si.Enabled = True
        End If


        If cmbTipoCliente.ListCount > 0 Then
            For X = 0 To cmbTipoCliente.ListCount - 1
                Texto1 = FUNC_ENTREGA_CODIGO_CLIENTE(Str(Datos(14)))
                cmbTipoCliente.ListIndex = X
                DA = Trim(Mid(cmbTipoCliente.text, 1, (Val(Len(cmbTipoCliente.text) - 5))))
                If DA = Texto1 Then
                    Exit For
                End If
            Next X
        End If
      
        If cmbTipoCliente.ListCount >= 0 Then
            For nCont = 0 To cmbTipoCliente.ListCount - 1
                If cmbTipoCliente.ItemData(nCont) = Datos(14) Then
                    cmbTipoCliente.ListIndex = nCont
                    Exit For
                End If
         Next nCont
        End If
'******************** trae grupo **************

        If CmbGrupo.ListCount > 0 Then
            For x2 = 0 To CmbGrupo.ListCount - 1
                Texto2 = FUNC_ENTREGA_CODIGO_CLIENTE(Str(Datos(19)))
                CmbGrupo.ListIndex = x2
                DA2 = Trim(Mid(CmbGrupo.text, 1, (Val(Len(CmbGrupo.text) - 5))))
                If DA2 = Texto2 Then
                    Exit For
                End If
            Next x2
        End If
        If CmbGrupo.ListIndex >= 0 Then
            For nCont = 0 To CmbGrupo.ListCount - 1
                If CmbGrupo.ItemData(nCont) = Datos(19) Then
                    CmbGrupo.ListIndex = nCont
                    Exit For
                End If
         Next nCont
        End If
        
        If cmbRelBanco.ListCount > 0 Then
            cmbRelBanco.ListIndex = Busca_Codigo_Combo(cmbRelBanco, Str(Datos(39)))
        End If
        
        If cmbRelBanco.ListCount > 0 Then
            cmbRelBanco.ListIndex = Busca_Codigo_Combo(cmbRelBanco, Str(Datos(39)))
        End If
      

        'CHECK Y OPTIONS
        If Datos(28) = "A" Then
            OpImplic(0).Value = True                           'Si es código ABA
            TxtCod.text = Datos(29)
        ElseIf Datos(28) = "C" Then
            OpImplic(1).Value = True                           'Si es código CHIPS
            TxtCod.text = Datos(30)
        Else
            OpImplic(2).Value = True                          'Si es código SWIFF
            TxtCod.text = Datos(31)
        End If
        
        If Datos(32) = "J" Then
            SSOption2.Value = True
        Else
            SSOption1.Value = True
        End If
      
        TxtCodigoOtc.text = Datos(56)
        ChkBloqueado.Value = IIf(Datos(57) = "S", 1, 0)
        
        txtCosto.text = Datos(58)
        
        chkPoder.Value = IIf(Datos(40) = "N", 0, 1)                     'Check Poder: Toma valores 1 ó 0
        chkFirma.Value = IIf(Datos(41) = "N", 0, 1)                      'Check Firma: Toma valores 1 ó 0
        chkInformeSocial.Value = IIf(Datos(44) = "N", 0, 1)         'Check Inf.Social: Toma valores 1 ó 0
        chkOficinas.Value = IIf(Datos(54) = "N", 0, 1)
      
        If Datos(45) = "N" Then                                                  'check Art. 85 :Toma valores 1 ó 0
        
        Else
            If Datos(46) = "C" Then                                               'Si la dec 85 es cliente o banco
                opCliente.Value = True
            Else
                opBanco.Value = True
            End If
        End If
            
        txtReceptorRutBco.text = Datos(64)
        txtReceptorCodBco.text = Datos(65)
        Me.lblReceptorNomBco.Caption = Datos(66)
        chk_Condiciones.Value = IIf(Datos(67) = "N", 0, 1)
        
        Txt_Fecha_Firma.text = IIf(Datos(67) = "N", "01/01/1900", Datos(68))
        Txt_Fecha_Firma.Enabled = IIf(Datos(67) = "N", False, True)
        Opt_No.Value = IIf(Datos(72) = "N", True, False)
        Opt_Si.Value = IIf(Datos(72) = "S", True, False)
        

        'RQ3827
        OptFirm_Si.Value = False
        OptFirm_No.Value = False
        BtnAval.Enabled = False
        CmbVerContratos.Enabled = False
        If Datos(73) = "S" Then
            OptFirm_Si.Value = True
            CmbVerContratos.Enabled = False
            BtnAval.Enabled = True
        ElseIf Datos(73) = "N" Then
            OptFirm_No.Value = True
            CmbVerContratos.Enabled = True
        End If
        
        If CmbVerContratos.ListCount > 0 And CmbVerContratos.Enabled = True Then
            CmbVerContratos.ListIndex = Busca_Codigo_Combo(CmbVerContratos, Str(Datos(74)))
        End If
        
        fecha_firma_nuevo.Enabled = True
        fecha_firma_nuevo.text = Datos(75)
        
        OptRetro_Si.Value = False
        OptRetro_No.Value = False
        If Datos(76) = "S" Then
            OptRetro_Si.Value = True
        ElseIf Datos(76) = "N" Then
            OptRetro_No.Value = True
        End If

      If cmbSegComercial.ListCount > 0 Then
         Let cmbSegComercial.ListIndex = -1

         If Trim(Datos(77)) <> "" Then
            cmbSegComercial.ListIndex = Busca_Codigo_Combo(cmbSegComercial, Str(Datos(77)))
         End If
      End If

      
      'PROD-10967
      
      If Rescata_Familia_FM = True Then
          Call Carga_Combo_Cliente_FM
       
       Else
          Call Proc_CargaCmbMetRec(cmbMetodologiaREC)
        
       End If
      'PRD-8800
      If cmbMetodologiaREC.ListCount > 0 Then
         Let cmbMetodologiaREC.ListIndex = -1

         If Trim(Datos(83)) <> "" Then
            cmbMetodologiaREC.ListIndex = Busca_Codigo_Combo(cmbMetodologiaREC, Str(Datos(83)))
         End If
      End If

      'txtGarantiaTotal.Text = Datos(78)   'Ahora este valor se obtiene del total de garantías constituídas del cliente

      If ChkBloqueado.Value = 1 Then
         txtMotivoBloqueo.text = Datos(79)
      Else
         txtMotivoBloqueo.text = ""
      End If

      If cmbEjecutivoCom.ListCount > 0 Then
         If Trim(Datos(80)) <> "" Then
            Call SeekDataCombo(cmbEjecutivoCom, Trim(Datos(80)))
         Else
            cmbEjecutivoCom.ListIndex = -1
         End If
      End If
      'PRD-3826, fin
   
      txtGarantiaEfectiva.text = Format(Datos(82), FEntero)
   
     'PRD-5896
     sExisteCli = "S"
     
     If (Datos(81) = "S") Then
           opt_vigente(0).Value = True
     Else: opt_vigente(1).Value = True
     End If
      
      HabilitarControles True
      
      Let cmbClasificacion.Enabled = True
      If cmbSegComercial.ListIndex >= 0 Then
        'If cmbSegComercial.ItemData(cmbSegComercial.ListIndex) = 1 Or cmbSegComercial.ItemData(cmbSegComercial.ListIndex) = 2 Then
         If Trim(Right(cmbSegComercial.text, 10)) = 1 Or Trim(Right(cmbSegComercial.text, 10)) = 2 Then
            Let cmbClasificacion.ListIndex = Busca_Codigo_Combo(cmbClasificacion, " ")
            Let cmbClasificacion.Enabled = False
         End If
      End If
   
      '-> Fecha Condiciones de Pacto
      Let ChkCondPacto.Value = 0:   Let TxtFechaPacto.text = "01-01-1900": Let TxtFechaPacto.Enabled = False
      
      If Format(Datos(84), "dd-mm-yyyy") <> "01-01-1900" Then
         Let ChkCondPacto.Value = 1
         Let TxtFechaPacto.text = Format(Datos(84), "dd-mm-yyyy")
         Let TxtFechaPacto.Enabled = True
      End If
      '-> Fecha Condiciones de Pacto

      txtEmail.text = Datos(85)

      '-> Opción ComDer -- PRD 19121
        '--> Inicializo la variable.
        dFechaComDer = Format(Datos(87), "dd-mm-yyyy")
        
        If Datos(86) = "S" Then
            OptComDer_Si.Value = True
            dFechaComDer = Format(Datos(87), "dd-mm-yyyy")     'PRD-19121
            Let Fecha_Contrato_Comder.text = Format(Datos(87), "dd-mm-yyyy")
            Let Fecha_Contrato_Comder.Enabled = True
        ElseIf Datos(86) = "N" Then
             OptComDer_No.Value = True
             Let Fecha_Contrato_Comder.text = Format(Datos(87), "dd-mm-yyyy")
             Let Fecha_Contrato_Comder.Enabled = False
        End If
      '-> Opción ComDer -- PRD 19121
        
        'INICIO PRD - 21841''''''''''''''''''''''''''''''''''''''''
        
        If (Datos(88) = "S") Then
           Me.OptSI.Value = True
           Me.TXT_Decimales.text = Datos(89)
        Else: Me.OptNO.Value = True
        End If
        
        
        'FIN PRD - 21841''''''''''''''''''''''''''''''''''''''''
          ' Datos Fusióm
         
          
           txtSecuencia.text = Datos(90)
       txtcodAS400.text = Datos(91)
       txtCodCGI.text = Datos(92)
       
'---------------------------------------------------------------------------------
'-------------------------------INICIO FUSÍON-------------------------------------
'-----------------NUEVAS INTERFACES BACEN NORMATIVAS A BRASIL---------------------
'---------------------------------------------------------------------------------
       
        Txt_codEmpRelacionada.text = Trim(Datos(93))
        
        If Cmb_cod_contra.ListCount > 0 Then
            Cmb_cod_contra.ListIndex = Busca_Codigo_Combo(Cmb_cod_contra, Str(Datos(94)))
            If Cmb_cod_contra.ListIndex = -1 Then
                 Cmb_cod_contra.ListIndex = 2 '  Mercado
              
            End If
            
        End If
        
       If Cmb_cod_emp_cen.ListCount > 0 Then
            Cmb_cod_emp_cen.ListIndex = Busca_Codigo_Combo(Cmb_cod_emp_cen, Str(Datos(95)))
            
            If Cmb_cod_emp_cen.ListIndex = -1 Then
                 Cmb_cod_emp_cen.ListIndex = 3 '  Chile
            End If
            
            
            
            
       End If
       
       TxtCodigoCPNJ.text = Datos(96)
       
Me.CmbColateral.text = IIf(Datos(97) = "", "CLP", Datos(97))
       
'---------------------------------------------------------------------------------
'-------------------------------FIN FUSÍON----------------------------------------
'-----------------NUEVAS INTERFACES BACEN NORMATIVAS A BRASIL---------------------
'---------------------------------------------------------------------------------
        
        
    Else
        'TEXTOS
        TxtNombre.text = ""
        TxtNombre.Tag = ""
        txtgeneric.text = ""
        TxtDireccion.text = ""
        txtctacte.text = ""
        TxtTelefono.text = ""
        TxtFax.text = ""
        Txt1Nombre.text = ""
        Txt1Nombre.Tag = ""
        Txt2Nombre.text = ""
        Txt2Nombre.Tag = ""
        Txt1Apellido.text = ""
        Txt1Apellido.Tag = ""
        Txt2Apellido.text = ""
        Txt2Apellido.Tag = ""
        TxtCtaUSD.text = ""
        txtCRiesgo.text = ""
        
        OpImplic(0).Value = True                           'Si es código ABA
        TxtCod.text = ""
        chkPoder.Value = 0
        chkFirma.Value = 0
        chkInformeSocial.Value = 0
        
        txtGarantiaEfectiva.text = 0
        
        opCliente.Value = True
        Generar_Codigo_Fox
        OptFirm_Si.Value = True
        OptFirm_No.Value = False
        CmbVerContratos.Enabled = False
        fecha_firma_nuevo.Enabled = True
        OptRetro_Si.Value = False
        OptRetro_No.Value = True
        
        '-> Fecha Condiciones de Pacto
        Let ChkCondPacto.Value = 0:   Let TxtFechaPacto.text = "01-01-1900": Let TxtFechaPacto.Enabled = False
        '-> Fecha Condiciones de Pacto
        
        Let txtEmail.text = ""
        
        HabilitarControles True
        
        'INICIO PRD - 21841''''''''''''''''''''''''''''''''''''''''
        Me.OptNO.Value = True
        Me.OptSI.Value = False
        Me.TXT_Decimales.text = ""
        'FIN PRD - 21841''''''''''''''''''''''''''''''''''''''''
        
        'Datos Fusión
        txtSecuencia.text = ""
        txtcodAS400.text = ""
        txtCodCGI.text = ""
        

 
            If Cmb_cod_contra.ListIndex = -1 Then
                 Cmb_cod_contra.ListIndex = 2 '  Mercado
            End If

            If Cmb_cod_emp_cen.ListIndex = -1 Then
                Cmb_cod_emp_cen.ListIndex = 3 '  Chile
            End If

        Me.CmbColateral.ListIndex = 0
        
   End If
      
   Screen.MousePointer = vbDefault

End Function

'---------------------------------------------------------------------------------
'-------------------------------INICIO FUSÍON-------------------------------------
'-----------------NUEVAS INTERFACES BACEN NORMATIVAS A BRASIL---------------------
'---------------------------------------------------------------------------------
Private Sub Txt_codEmpRelacionada_KeyPress(KeyAscii As Integer)

    If Not IsNumeric(Chr(KeyAscii)) And KeyAscii <> 13 And KeyAscii <> 8 Then KeyAscii = 0

End Sub
'---------------------------------------------------------------------------------
'-------------------------------FIN FUSÍON----------------------------------------
'-----------------NUEVAS INTERFACES BACEN NORMATIVAS A BRASIL---------------------
'---------------------------------------------------------------------------------



Private Function SeekDataCombo(ByRef MiCombo As ComboBox, ByVal MiValor As String)
   Dim nContador  As Long

   Let MiCombo.ListIndex = -1

   For nContador = 0 To MiCombo.ListCount - 1
      If MiCombo.List(nContador) = MiValor Then
         Let MiCombo.ListIndex = nContador
      End If
   Next nContador
     
End Function

Function Generar_Codigo_Fox()
Dim SQL As String
Dim Datos()
    SQL = "SELECT ISNULL(MAX(clcodfox),1) FROM Cliente"
    If MISQL.SQL_Execute(SQL) <> 0 Then
        MsgBox "Consulta en Bactrader Ha Fallado. Servidor SQL No Responde", vbCritical, TITSISTEMA
        Exit Function
    End If
            
    If MISQL.SQL_Fetch(Datos()) = 0 Then
'         txtCodContable.Text = Val(DATOS(1)) + 1
    End If
End Function

Private Sub TxtCodigo_LostFocus()
Dim IdRut       As Long
Dim IdDig       As String
Dim IdCod       As Long
Dim Bandera     As Integer
Dim i           As Long
Dim tecla       As Integer

    If Val(txtrut.text) = 0 Or Trim(txtDigito.text) = "" Then Exit Sub
   
    Bandera = True
  
    If Trim(TxtCodigo) = "" Or Trim(txtrut) = "" Then
        If Val(TxtCodigo) = 0 Then
            MsgBox "Error : El código no puede ser cero ", 16, TITSISTEMA
        Else
            MsgBox "Error : Datos en Blanco ", 16, TITSISTEMA
        End If
        
        Call Limpiar
        Call HabilitarControles(False)
        txtrut.SetFocus
        Exit Sub
    End If
 
    IdRut = txtrut.text
    IdDig = txtDigito.text
    IdCod = TxtCodigo.text

    Inicializa_Pais

    
    Call Busca_Cliente(IdRut, IdDig, IdCod)
    Call Totaliza_Garantias_Cliente(IdRut, IdCod)
End Sub

Private Sub txtCodigoBCCH_KeyPress(KeyAscii As Integer)
    txtCodigoBCCH.MaxLength = 3
    If KeyAscii = 13 Then
        Sendkeys "{TAB}"
        Exit Sub
    End If
    If Not IsNumeric(Chr(KeyAscii)) And KeyAscii <> 13 And KeyAscii <> 8 Then KeyAscii = 0
End Sub

Private Sub txtCodigoSuper_KeyPress(KeyAscii As Integer)
    txtCodigoSuper.MaxLength = 3

    If KeyAscii = 13 Then
        Sendkeys "{TAB}"
        Exit Sub
    End If
    If Not IsNumeric(Chr(KeyAscii)) And KeyAscii <> 13 And KeyAscii <> 8 Then KeyAscii = 0
End Sub

Private Sub txtCRF_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        Sendkeys "{TAB}"
        Exit Sub
    End If
    BacToUCase KeyAscii
End Sub

Private Sub txtCosto_KeyPress(KeyAscii As Integer)
    If KeyAscii% = vbKeyReturn Then
        KeyAscii% = 0
        Sendkeys "{TAB}"
    ElseIf Not ((KeyAscii > 47 And KeyAscii < 58) Or KeyAscii = 8) Then
        KeyAscii = 0
    End If
    BacCaracterNumerico KeyAscii
End Sub

Private Sub txtCRiesgo_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        Sendkeys "{TAB}"
        Exit Sub
    End If
    BacToUCase KeyAscii
End Sub

Private Sub txtctacte_KeyPress(KeyAscii As Integer)
    BacToUCase KeyAscii
    If KeyAscii% = 39 Or KeyAscii% = 34 Then
        KeyAscii% = 0
    Else
        If KeyAscii% = vbKeyReturn Then
            KeyAscii% = 0
            Sendkeys$ "{TAB}"
        End If
    End If
End Sub

Private Sub TxtCtaUSD_KeyPress(KeyAscii As Integer)

    BacToUCase KeyAscii
    If KeyAscii% = 39 Or KeyAscii% = 34 Then
        KeyAscii% = 0
    Else
        If KeyAscii% = vbKeyReturn Then
            KeyAscii% = 0
            Sendkeys$ "{TAB}"
        End If
    End If
End Sub

Private Sub txtDigito_KeyPress(KeyAscii As Integer)
    txtDigito.text = UCase(txtDigito.text)

    If KeyAscii% = vbKeyReturn Then
        BacToUCase KeyAscii
        txtDigito_LostFocus
        KeyAscii% = 0
    End If
End Sub

Private Sub txtDigito_LostFocus()

    If txtrut.text <> "" And txtDigito.text <> "" Then
        If BacValidaRut(txtrut.text, txtDigito.text) = False Then
            MsgBox "RUT Ingresado es Invalido", vbOKOnly + vbExclamation, TITSISTEMA
            txtDigito.text = ""
            txtrut.Enabled = True
        Else
            TxtCodigo.Enabled = True
            TxtCodigo.SetFocus
        End If
    End If
End Sub

Private Sub TxtDireccion_KeyPress(KeyAscii As Integer)
   BacToUCase KeyAscii
   If KeyAscii% = 39 Or KeyAscii% = 34 Then
      KeyAscii% = 0
   Else
    If KeyAscii% = vbKeyReturn Then
      KeyAscii% = 0
      Sendkeys$ "{TAB}"
    End If
   End If
End Sub

Private Sub txtERF_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
    Sendkeys "{TAB}"
    Exit Sub
End If
   BacToUCase KeyAscii
End Sub

Private Sub txtDirenAval_KeyPress(Index As Integer, KeyAscii As Integer)
    If KeyAscii% = vbKeyReturn Then
        KeyAscii% = 0
        Sendkeys$ "{TAB}"
    End If
End Sub

Private Sub txtDvApode1_KeyPress(Index As Integer, KeyAscii As Integer)
   If KeyAscii = 107 Then
      KeyAscii = vbKeyK
   End If
    
    If KeyAscii% = vbKeyReturn Then
        KeyAscii% = 0
        Sendkeys$ "{TAB}"
    End If
    
    If (KeyAscii < vbKey0 Or KeyAscii > vbKey9) And KeyAscii <> vbKeyBack And KeyAscii <> vbKeyK Then
      KeyAscii = 0
    End If
End Sub

Private Sub txtDvApode1_LostFocus(Index As Integer)
Dim nIndex As Long

    nIndex = SSTab2.Tab
    
    If txtRutApode1(nIndex).text <> "" And txtDvApode1(nIndex).text <> "" Then
        If BacValidaRut(txtRutApode1(nIndex).text, txtDvApode1(nIndex).text) = False Then
              MsgBox "RUT Ingresado NO es Invalido", vbOKOnly + vbExclamation, TITSISTEMA
              txtDvApode1(nIndex).text = ""
              txtDvApode1(Index).SetFocus
        End If
    End If
End Sub

Private Sub txtDvApode2_KeyPress(Index As Integer, KeyAscii As Integer)
   
   If KeyAscii = 107 Then
      KeyAscii = vbKeyK
   End If
    
    If KeyAscii% = vbKeyReturn Then
        KeyAscii% = 0
        Sendkeys$ "{TAB}"
    End If
    
    If (KeyAscii < vbKey0 Or KeyAscii > vbKey9) And KeyAscii <> vbKeyBack And KeyAscii <> vbKeyK Then
      KeyAscii = 0
    End If
End Sub

Private Sub txtDvApode2_LostFocus(Index As Integer)
Dim nIndex As Long

    nIndex = SSTab2.Tab
    
    If txtRutApode2(nIndex).text <> "" And txtDvApode2(nIndex).text <> "" Then
        If BacValidaRut(txtRutApode2(nIndex).text, txtDvApode2(nIndex).text) = False Then
              MsgBox "RUT Ingresado NO es Invalido", vbOKOnly + vbExclamation, TITSISTEMA
              txtDvApode2(nIndex).text = ""
              txtDvApode2(Index).SetFocus
        End If
    End If
End Sub

Private Sub txtDvAval_KeyPress(Index As Integer, KeyAscii As Integer)
    
   If KeyAscii = 107 Then
      KeyAscii = vbKeyK
   End If
    
   If KeyAscii% = vbKeyReturn Then
      KeyAscii% = 0
      Sendkeys$ "{TAB}"
   End If
    
   If (KeyAscii < vbKey0 Or KeyAscii > vbKey9) And KeyAscii <> vbKeyBack And KeyAscii <> vbKeyK Then
      KeyAscii = 0
   End If
    
End Sub

Private Sub txtDvAval_LostFocus(Index As Integer)
   Dim nIndex As Long

   nIndex = SSTab2.Tab
   
   If txtRutAval(nIndex).text <> "" And txtDvAval(nIndex).text <> "" Then
      If BacValidaRut(txtRutAval(nIndex).text, txtDvAval(nIndex).text) = False Then
         MsgBox "RUT Ingresado NO es Invalido", vbOKOnly + vbExclamation, TITSISTEMA
         txtDvAval(nIndex).text = ""
         txtDvAval(nIndex).SetFocus
      Else
         If ExisteAval(Index) Then
            Call HabilitaDatoAvalEx(True, Index)
            
            If txtRutAval(Index).text > 49999999 Then
                Cmb_RegimenConyugal(Index).ListIndex = Cmb_RegimenConyugal(Index).ListCount - 1
                Call HabilitaDatoAval(True, Index)
            Else
                Call HabilitaDatoAval(False, Index)
            End If

            txtNombreAval(Index).SetFocus
         Else
            MsgBox "Aval ya Existe", vbInformation, TITSISTEMA
            Call HabilitaDatoAvalEx(False, Index)
            txtRutAval(nIndex).SetFocus
            Exit Sub
         End If
      End If
   End If
End Sub

Private Sub txtDvConyAval_KeyPress(Index As Integer, KeyAscii As Integer)
    
   If KeyAscii = 107 Then
      KeyAscii = vbKeyK
   End If
    
    If KeyAscii% = vbKeyReturn Then
        KeyAscii% = 0
        Sendkeys$ "{TAB}"
    End If
    
    If (KeyAscii < vbKey0 Or KeyAscii > vbKey9) And KeyAscii <> vbKeyBack And KeyAscii <> vbKeyK Then
      KeyAscii = 0
    End If
End Sub

Private Sub txtDvConyAval_LostFocus(Index As Integer)
Dim nIndex As Long

    nIndex = SSTab2.Tab
    
    If txtRutConyAval(nIndex).text <> "" And txtDvConyAval(nIndex).text <> "" Then
        If BacValidaRut(txtRutConyAval(nIndex).text, txtDvConyAval(nIndex).text) = False Then
              MsgBox "RUT Ingresado NO es Valido", vbOKOnly + vbExclamation, TITSISTEMA
              txtDvConyAval(nIndex).text = ""
        End If
    End If
End Sub

Private Sub txtFax_KeyPress(KeyAscii As Integer)

   BacToUCase KeyAscii

   If KeyAscii% = 39 Or KeyAscii% = 34 Then
      KeyAscii% = 0
   Else
      If KeyAscii% = vbKeyReturn Then
         KeyAscii% = 0
         Sendkeys$ "{TAB}"
      End If
   End If

End Sub

Private Sub txtgeneric_KeyPress(KeyAscii As Integer)

   BacToUCase KeyAscii

    If KeyAscii% = 39 Or KeyAscii% = 34 Then
      KeyAscii% = 0
   Else
    If KeyAscii% = vbKeyReturn Then
      KeyAscii% = 0
      If SSOption1.Value = True Then
          Sendkeys "{Tab}"
      Else
          TxtNombre.SetFocus
      End If
     
     
    End If
   End If

End Sub

Private Sub txtgeneric_LostFocus()
         
    If Not SSOption1.Value Then
    If TxtNombre.Visible = True Then
       TxtNombre.Enabled = True
       On Error Resume Next
       TxtNombre.SetFocus
       On Error GoTo 0
      End If
     End If
     Screen.MousePointer = Default
End Sub

Private Sub txtmxcontab_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  Sendkeys "{tab}"
End If
End Sub

Private Sub txtNomApode1_KeyPress(Index As Integer, KeyAscii As Integer)
    If KeyAscii% = vbKeyReturn Then
        KeyAscii% = 0
        Sendkeys$ "{TAB}"
    End If
End Sub

Private Sub txtNomApode2_KeyPress(Index As Integer, KeyAscii As Integer)
    If KeyAscii% = vbKeyReturn Then
        KeyAscii% = 0
        Sendkeys$ "{TAB}"
    End If
End Sub

Private Sub txtNombre_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = 13 Then
  Sendkeys "{tab}"
End If
End Sub

Private Sub txtNombre_KeyPress(KeyAscii As Integer)

    BacToUCase KeyAscii
    
   'txtNombre.MaxLength = 70
End Sub

Private Sub txtNombreAval_KeyPress(Index As Integer, KeyAscii As Integer)
    If KeyAscii% = vbKeyReturn Then
        KeyAscii% = 0
        Sendkeys$ "{TAB}"
    End If
End Sub

Private Sub txtNomConyAval_KeyPress(Index As Integer, KeyAscii As Integer)
    If KeyAscii% = vbKeyReturn Then
        KeyAscii% = 0
        Sendkeys$ "{TAB}"
    End If
End Sub

Private Sub txtProfConyuge_KeyPress(Index As Integer, KeyAscii As Integer)
    If KeyAscii% = vbKeyReturn Then
        KeyAscii% = 0
        Sendkeys$ "{TAB}"
    End If
End Sub

Private Sub txtProfeAval_KeyPress(Index As Integer, KeyAscii As Integer)
    If KeyAscii% = vbKeyReturn Then
        KeyAscii% = 0
        Sendkeys$ "{TAB}"
    End If
End Sub

Private Sub txtReceptorRutBco_DblClick()
   BacAyuda.Tag = "MDCL_b"
   BacAyuda.Show 1
   If giAceptar = True Then
      txtReceptorRutBco.text = Val(gsrut)
      txtReceptorCodBco.text = Val(gsCodigo)
      Me.lblReceptorNomBco.Caption = Trim(gsDescripcion$)
   End If
End Sub

Private Function Cargar_Ayuda_Clientes()
   
   Call BacControlWindows(1)
   Let BacAyuda.Tag = "MDCL_CLIENTES"
   Call BacAyuda.Show(vbModal)

   If giAceptar = True Then
       
   End If
End Function


Private Sub TxtRut_DblClick()
Dim xx
On Error GoTo Error
    
    BacControlWindows 100
    'BacAyuda.Tag = "MDCL" original
    'BacAyuda.Show 1
    BacAyudaCliente.Tag = "MDCL"
    BacAyudaCliente.Show 1
       
    If giAceptar = True Then
        
        txtrut.text = Val(gsrut$)
        txtDigito.text = gsDigito$
        TxtCodigo.text = gsValor$
        txtmxcontab.text = Val(gsmxcontab)
        
        opt_vigente(0).Value = IIf(Trim(gsEstado) = "S", True, False)
        opt_vigente(1).Value = IIf(Trim(gsEstado) = "N", True, False)
        
        xx = gsPais
        Call HabilitarControles(True)
        
        txtrut.Enabled = True
        txtDigito.Enabled = True
        TxtCodigo.Enabled = True
        txtDigito.SetFocus
        
        Call HabilitarControles(True)
        Sendkeys "{TAB}"
    End If

Error:
  If Err.Number <> 0 Then MsgBox Err.Description
  
End Sub


Private Sub TxtRut_KeyDown(KeyCode As Integer, Shift As Integer)
    
    If KeyCode = vbKeyF3 Then Call TxtRut_DblClick
    
End Sub

Private Sub txtRut_KeyPress(KeyAscii As Integer)

   If KeyAscii% = vbKeyReturn Then
      KeyAscii% = 0
      txtDigito.Enabled = True
      Sendkeys$ "{TAB}"

   ElseIf Not ((KeyAscii > 47 And KeyAscii < 58) Or KeyAscii = 8) Then
        KeyAscii = 0
   End If

   
End Sub

Private Sub txtrut_LostFocus()

If Len(txtrut.text) <> 0 Then
   Digito = BacDevuelveDig(txtrut.text)
   txtDigito.Enabled = True

End If
End Sub

Private Sub txtRutApode1_KeyPress(Index As Integer, KeyAscii As Integer)
    If KeyAscii% = vbKeyReturn Then
        KeyAscii% = 0
        Sendkeys$ "{TAB}"
   ElseIf Not ((KeyAscii > 47 And KeyAscii < 58) Or KeyAscii = 8) Then
        KeyAscii = 0
   End If
End Sub

Private Sub txtRutApode1_LostFocus(Index As Integer)
'
End Sub

Private Sub txtRutApode2_KeyPress(Index As Integer, KeyAscii As Integer)
    If KeyAscii% = vbKeyReturn Then
        KeyAscii% = 0
        Sendkeys$ "{TAB}"
    ElseIf Not ((KeyAscii > 47 And KeyAscii < 58) Or KeyAscii = 8) Then
        KeyAscii = 0
    End If
End Sub

Private Sub txtRutAval_KeyPress(Index As Integer, KeyAscii As Integer)
    
    If KeyAscii% = vbKeyReturn Then
        KeyAscii% = 0
        Sendkeys$ "{TAB}"
    End If
    
    If (KeyAscii < vbKey0 Or KeyAscii > vbKey9) And KeyAscii <> vbKeyBack And KeyAscii <> vbKeyDelete Then
      KeyAscii = 0
    End If
    
End Sub

Private Sub txtRutAval_LostFocus(Index As Integer)
   txtNombreAval(Index).Enabled = True
   ''''txtRazonSocial(Index).Enabled = True
   txtProfeAval(Index).Enabled = True
   txtDirenAval(Index).Enabled = True
   CmbCiudadAval(Index).Enabled = True
   cmbComunaAval(Index).Enabled = True
   txtRutConyAval(Index).Enabled = True
   txtDvConyAval(Index).Enabled = True
   txtNomConyAval(Index).Enabled = True
   Cmb_RegimenConyugal(Index).Enabled = True
   txtProfConyuge(Index).Enabled = True
   
   If txtRutAval(Index).text > "49999999" Then
      Call HabilitaDatoAval(True, Index)
   Else
      Call HabilitaDatoAval(False, Index)
   End If
      
End Sub

Private Sub txtRutConyAval_KeyPress(Index As Integer, KeyAscii As Integer)
    If KeyAscii% = vbKeyReturn Then
        KeyAscii% = 0
        Sendkeys$ "{TAB}"
    ElseIf Not ((KeyAscii > 47 And KeyAscii < 58) Or KeyAscii = 8) Then
        KeyAscii = 0
    End If
End Sub

Private Sub TxtRutSinacofi_KeyPress(KeyAscii As Integer)

    If KeyAscii = vbKeyReturn Then
       KeyAscii = 0
       
       Sendkeys$ "{TAB}"
       If Len(txtrut.text) <> 0 Then
           Txt_DigitoSinacofi.text = BacDevuelveDig(TxtRutSinacofi.text)
                   
        End If


   ElseIf Not ((KeyAscii > 47 And KeyAscii < 58) Or KeyAscii = 8) Then
        KeyAscii = 0
        
    End If

End Sub

Private Sub TxtRutSinacofi_LostFocus()
   If Len(txtrut.text) <> 0 Then
      Txt_DigitoSinacofi.text = BacDevuelveDig(TxtRutSinacofi.text)
   End If
End Sub

Private Sub TxtTelefono_KeyPress(KeyAscii As Integer)
   BacToUCase KeyAscii

   If KeyAscii% = 39 Or KeyAscii% = 34 Then
         KeyAscii% = 0
      Else
      If KeyAscii% = vbKeyReturn Then
         KeyAscii% = 0
         Sendkeys$ "{TAB}"
      End If
   End If

End Sub

Private Sub TipoNombre(Valor As Boolean)
    Txt1Nombre.Visible = Valor
    Txt2Nombre.Visible = Valor
    Txt1Apellido.Visible = Valor
    Txt2Apellido.Visible = Valor
    Label(2).Visible = Valor
    Label(20).Visible = Valor
    Label(21).Visible = Valor
    Label(18).Visible = Not Valor
    TxtNombre.Visible = Not Valor
End Sub

Function FUNC_ENTREGA_TIPO_CLIENTE(Combo As Control) As Integer
   Dim SQL As String
   Dim Datos()

   FUNC_ENTREGA_TIPO_CLIENTE = 1
   SQL = "SELECT CTCATEG FROM TABLA_GENERAL_GLOBAL  WHERE CTCATEG =" + Trim(Right(Combo.text, 4)) + ""


   If MISQL.SQL_Execute(SQL) <> 0 Then Exit Function

   If MISQL.SQL_Fetch(Datos()) = 0 Then FUNC_ENTREGA_TIPO_CLIENTE = Val(Datos(1))

End Function

Function FUNC_ENTREGA_CODIGO_CLIENTE(ftipocliente As Integer) As String
   Dim SQL As String
   Dim Datos()

    FUNC_ENTREGA_CODIGO_CLIENTE = 1

    SQL = "SELECT CTDESCRIP FROM TABLA_GENERAL_GLOBAL WHERE CTCATEG = " & ftipocliente

    If MISQL.SQL_Execute(SQL) <> 0 Then Exit Function

    If MISQL.SQL_Fetch(Datos()) = 0 Then FUNC_ENTREGA_CODIGO_CLIENTE = Datos(1)

End Function

Function FUNC_CONTRATO_CCG()
   Dim SQL As String
   Dim Datos()

   SQL = "SELECT NUEVO_CCG_FIRMADO from cliente where clrut = '" & txtrut.text & "' and NUEVO_CCG_FIRMADO = 'n' "
   
   If MISQL.SQL_Execute(SQL) <> 0 Then Exit Function
   
   If MISQL.SQL_Fetch(Datos()) = 0 Then FUNC_CONTRATO_CCG = Datos(1)

End Function

Sub FUNC_BUSCA_CODIGOS_MDTC(Codigo_Mdtc As Long, Combo As Control)
   Dim SQL As String
   
   If swauxiliar = 0 Then
      Envia = Array()
      AddParam Envia, Codigo_Mdtc
      If Not Bac_Sql_Execute("SP_LEERCODIGOS", Envia) Then Exit Sub
         Do While Bac_SQL_Fetch(Datos())
            If Codigo_Mdtc = MDTC_CLASIFICACION Then
               Combo.AddItem Trim(Datos(1)) & Space((10 - Len(Datos(1)))) & Trim(Datos(2))
            Else
               Combo.AddItem Trim(Datos(6)) & Space(60) & Trim(Datos(1)) & Space(10) & Trim(Datos(2))
               Combo.ItemData(Combo.NewIndex) = Datos(2)
            End If
         Loop
      Else
         SQL = "SP_TRAECATEGORIA"
         If Not Bac_Sql_Execute("SP_TRAECATEGORIA") Then Exit Sub
         Do While Bac_SQL_Fetch(Datos())
           Combo.AddItem Trim(Datos(2)) & Space(50) & Trim(Datos(1))
         Loop
     End If
End Sub

Function Busca_Codigo_Combo(Combo2 As Control, Codigo As String) As Integer
   Dim i As Integer
   Dim nContador  As Long
   
   Let Busca_Codigo_Combo = -1
   
   If Combo2.ListCount = 0 Then
      Busca_Codigo_Combo = -1
     'MsgBox "Objeto se encuentra sin información.", vbCritical, TITSISTEMA
   End If

   For nContador = 0 To Combo2.ListCount - 1
      If Trim(Right(Combo2.List(nContador), 10)) = Trim(Codigo) Then
         Busca_Codigo_Combo = nContador
            Exit For
         End If
   Next nContador

   If nContador > (Combo2.ListCount - 1) Then
      i = 1
   End If
End Function

Private Sub txtVctoLinea_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then Sendkeys "{TAB}"
End Sub

Private Function TraeValor(xValor As Variant) As Double

   If xValor = "" Then
   
      TraeValor = 0
      
   Else
      
      TraeValor = xValor

   End If

End Function

Sub Carga()
   Dim SQL As String
   Dim Datos()
     
   If Not Bac_Sql_Execute("SP_SELECCIONA_PAIS") Then Exit Sub
   
   Do While Bac_SQL_Fetch(Datos())
      cmbPais.AddItem Trim(Datos(2))
      cmbPais.ItemData(cmbPais.NewIndex) = Datos(1)
   Loop

   FUNC_BUSCA_CODIGOS_MDTC MDTC_MERCADO, CmbMercado
   FUNC_BUSCA_CODIGOS_MDTC MDTC_CALIDADJURIDICA, CmbCalidadJuridica
   FUNC_BUSCA_CODIGOS_MDTC MDTC_RGBANCO, cmbRGBanco
   FUNC_BUSCA_CODIGOS_MDTC MDTC_RELACION, cmbRelBanco
   FUNC_BUSCA_CODIGOS_MDTC MDTC_CATEGORIADEUDOR, cmbCategoriaDeudor
   'swauxiliar = 100
   FUNC_BUSCA_CODIGOS_MDTC MDTC_TIPOCLIENTE, cmbTipoCliente
   FUNC_BUSCA_CODIGOS_MDTC MDTC_GRUPOS, CmbGrupo
   'swauxiliar = 0
   FUNC_BUSCA_CODIGOS_MDTC MDTC_COMINSTITUCIONAL, cmbComInstitucional
   FUNC_BUSCA_CODIGOS_MDTC MDTC_ACTIVIDADECONOMICA, cmbActividadEconomica
   FUNC_BUSCA_CODIGOS_MDTC MDTC_CLASIFICACION, cmbClasificacion
'  FUNC_BUSCA_CODIGOS_MDTC MDTC_CIUDAD, CmbCiudad
   FUNC_CARGA_CIUDADES

   'FUNC_BUSCA_CODIGOS_MDTC 8020, cmbSegComercial
   'PRD-8800
   
   
'---------------------------------------------------------------------------------
'-------------------------------INICIO FUSÍON-------------------------------------
'-----------------NUEVAS INTERFACES BACEN NORMATIVAS A BRASIL---------------------
'---------------------------------------------------------------------------------
   
    FUNC_BUSCA_CODIGOS_MDTC MDTC_COD_CONTRAPARTE, Cmb_cod_contra
    FUNC_BUSCA_CODIGOS_MDTC MDTC_COD_EMPR_CONTRA, Cmb_cod_emp_cen
    
'---------------------------------------------------------------------------------
'-------------------------------FIN FUSÍON----------------------------------------
'-----------------NUEVAS INTERFACES BACEN NORMATIVAS A BRASIL---------------------
'---------------------------------------------------------------------------------
   
   
   Call Proc_CargaCmbMetRec(cmbMetodologiaREC)
   Call Proc_cmbSegComercial(cmbSegComercial)
   Call FuncLoadEjecutivos
   
End Sub

Private Function FuncLoadEjecutivos()
   Dim Sqldatos()
   Envia = Array()

   cmbEjecutivoCom.Clear

   If Not Bac_Sql_Execute("dbo.SP_LEE_EJECUTIVOS") Then
      Call cmbEjecutivoCom.AddItem("NO EXISTEN EJECUTIVOS")
       Let cmbEjecutivoCom.ItemData(cmbEjecutivoCom.NewIndex) = -1
      Exit Function
   End If
   Do While Bac_SQL_Fetch(Sqldatos())
      Call cmbEjecutivoCom.AddItem(Sqldatos(2))
       Let cmbEjecutivoCom.ItemData(cmbEjecutivoCom.NewIndex) = Sqldatos(1)
   Loop
End Function

Public Function BacDevuelveDig(Rut As String) As String

   Dim i       As Integer
   Dim D       As Integer
   Dim Divi    As Long
   Dim Suma    As Long
   Dim Digito  As String
   Dim Multi   As Double

   BacDevuelveDig = ""

   Rut = Format(Rut, "000000000")
   D = 2
   Suma = 0
   For i = 9 To 1 Step -1
      Multi = Val(Mid$(Rut, i, 1)) * D
     Suma = Suma + Multi
      D = D + 1
      
      If D = 8 Then
         D = 2
      
      End If
   Next i
    
   Divi = (Suma \ 11)
   Multi = Divi * 11
   Digito = Trim$(Str$(11 - (Suma - Multi)))
    
   If Digito = "10" Then
      Digito = "K"
   
   End If
    
   If Digito = "11" Then
      Digito = "0"
   
   End If
    
   BacDevuelveDig = UCase(Digito)

End Function

Sub CargaComboCantAvales()
    cmbCantAvales.Clear
    cmbCantAvales.AddItem 0
    cmbCantAvales.AddItem 1
    cmbCantAvales.AddItem 2
    cmbCantAvales.AddItem 3
    cmbCantAvales.AddItem 4
    cmbCantAvales.AddItem 5
End Sub

Sub GuardaAvales()
    Dim nIndexAval As Integer
    Envia = Array()

''''    Call Bac_Sql_Execute("BEGIN TRANSACTION")
    
    Envia = Array()
    AddParam Envia, Val(txtrut.text)
    AddParam Envia, -999
    AddParam Envia, -999
    
    If Not Bac_Sql_Execute("SP_DEL_AVALES_CLIENTES_DERIVADOS", Envia) Then
       Call Bac_Sql_Execute("ROLLBACK TRAN")
       MsgBox "Ha ocurrido un error al intentar actualizar los datos de los avales", vbCritical, TITSISTEMA
       Screen.MousePointer = Default
       Exit Sub
    End If

    If Val(cmbCantAvales.text) > 0 Then
      For nIndexAval = 1 To UBound(mAval, 2)
          If mAval(1, 1) = "*" Then
            Exit For
          End If
      
        Envia = Array()
            AddParam Envia, "I"
        AddParam Envia, Val(txtrut.text)
        AddParam Envia, TxtCodigo.text
        AddParam Envia, Val(mAval(1, nIndexAval))  'Val(txtRutAval(nIndexAval).Text)
        AddParam Envia, mAval(2, nIndexAval)       'txtDvAval(nIndexAval).Text
        AddParam Envia, mAval(3, nIndexAval)       'txtNombreAval(nIndexAval).Text
        AddParam Envia, mAval(4, nIndexAval)       'txtRazonSocial(nIndexAval).Text
        AddParam Envia, mAval(5, nIndexAval)       'txtProfeAval(nIndexAval).Text
        AddParam Envia, mAval(6, nIndexAval)       'txtDirenAval(nIndexAval).Text
        AddParam Envia, mAval(8, nIndexAval)       'cmbComunaAval(nIndexAval).ListIndex
        AddParam Envia, mAval(7, nIndexAval)       'CmbCiudadAval(nIndexAval).ListIndex
        AddParam Envia, Val(mAval(9, nIndexAval))  'Val(txtRutApode1(nIndexAval).Text)
        AddParam Envia, mAval(10, nIndexAval)      'txtDvApode1(nIndexAval).Text
        AddParam Envia, mAval(11, nIndexAval)      'txtNomApode1(nIndexAval).Text
        AddParam Envia, Val(mAval(12, nIndexAval)) 'Val(txtRutApode2(nIndexAval).Text)
        AddParam Envia, mAval(13, nIndexAval)      'txtDvApode2(nIndexAval).Text
        AddParam Envia, mAval(14, nIndexAval)      'txtNomApode2(nIndexAval).Text
        AddParam Envia, mAval(15, nIndexAval)      'txtRegimenConyugal(nIndexAval).Text
        AddParam Envia, Val(mAval(16, nIndexAval)) 'Val(txtRutConyAval(nIndexAval).Text)
        AddParam Envia, mAval(17, nIndexAval)      'txtDvConyAval(nIndexAval).Text
        AddParam Envia, mAval(18, nIndexAval)      'txtNomConyAval(nIndexAval).Text
        AddParam Envia, mAval(19, nIndexAval)      'txtProfConyuge(nIndexAval).Text
        
        If Not Bac_Sql_Execute("SP_ACT_AVAL_CONT_DERIVADOS", Envia) Then
              Call Bac_Sql_Execute("ROLLBACK TRANSACTION")
            MsgBox "Error al Grabar el Aval", vbCritical, TITSISTEMA
            Screen.MousePointer = Default
            Exit Sub
        End If
    Next nIndexAval
    
''''      Call Bac_Sql_Execute("COMMIT TRANSACTION")
   End If
    
End Sub

Sub FUNC_CARGA_CIUDADES_Aval()
    Dim nIndex  As Integer

    Envia = Array()

    If Not Bac_Sql_Execute("SP_MNTCLIENTE_LEER_CIUDADES") Then Exit Sub

    CmbCiudadAval(nIndex).Clear

    Do While Bac_SQL_Fetch(Datos())
        For nIndex = 0 To 4
            CmbCiudadAval(nIndex).AddItem Trim(Datos(2))
            CmbCiudadAval(nIndex).ItemData(CmbCiudadAval(nIndex).NewIndex) = Datos(1)
        Next nIndex
    Loop
End Sub

Private Function BuscaAval() As Boolean
   Dim nIndexAval  As Integer
   Dim nContador   As Integer
   'Dim nContador2  As Integer
   Dim nContador3  As Integer
   
   Envia = Array()
   AddParam Envia, Val(txtrut.text)
   AddParam Envia, Val(TxtCodigo.text)
   
   If Not Bac_Sql_Execute("SP_CON_AVAL_CLIENTE_DERIVADOS", Envia) Then
      Exit Function
   End If
   
   BuscaAval = False
   nIndexAval = -1
   nContador2 = 0
   nContador3 = 0

   If mAval(1, 1) = "*" Then
      Do While Bac_SQL_Fetch(Datos())
        nContador2 = nContador2 + 1
         ReDim Preserve mAval(20, nContador2)
         mAval(1, nContador2) = Datos(3)     ' Rut Aval
         mAval(2, nContador2) = Datos(4)     ' DV Aval
         mAval(3, nContador2) = Datos(5)     ' Nombre Aval
         mAval(4, nContador2) = Datos(6)     ' Razon Social
         mAval(5, nContador2) = Datos(7)     ' Profesion AVAL
         mAval(6, nContador2) = Datos(8)     ' DIRECCION
         mAval(7, nContador2) = Datos(10)    ' CIUDAD
         mAval(8, nContador2) = Datos(9)     ' COMUNA
         mAval(9, nContador2) = Datos(11)    ' RUT APO1
         mAval(10, nContador2) = Datos(12)   ' DV APO1
         mAval(11, nContador2) = Datos(13)   ' NOMBRE APO1
         mAval(12, nContador2) = Datos(14)   ' RUT APO2
         mAval(13, nContador2) = Datos(15)   ' DV APO2
         mAval(14, nContador2) = Datos(16)   ' NOMBRE APO2
         mAval(15, nContador2) = Datos(17)   ' REGIMEN
         mAval(16, nContador2) = Datos(18)   ' RUT CONYU
         mAval(17, nContador2) = Datos(19)   ' DV CONY
         mAval(18, nContador2) = Datos(20)   ' NOM CONY
         mAval(19, nContador2) = Datos(21)   ' PROF CONY
         mAval(20, nContador2) = "N"         ' Elimina
         BuscaAval = True
      Loop
   End If

   Call LlenaDatosAval

   SSTab2.Visible = True

   For nContador = 0 To SSTab2.Tabs - 1
      If nContador > nContador2 - 1 Then
         SSTab2.TabVisible(nContador) = False
         SSTab2.TabEnabled(nContador) = False
      Else
         SSTab2.TabVisible(nContador) = True
         SSTab2.TabEnabled(nContador) = True
         SSTab2.Visible = True
      End If
   Next nContador

   cmbCantAvales.ListIndex = nContador2
End Function

Sub ValidaRut(nRut As String)
    nDigAval = BacDevuelveDig(nRut)
End Sub

Private Function ValidaDatosAval() As Boolean
   Dim nContador As Integer
   Dim nIndice   As Integer
   
   nIndice = -1
   
   ValidaDatosAval = True
    
   If cmbCantAvales.text > 0 Then
      For nContador = 0 To SSTab2.Tabs - 1
         nIndice = nIndice + 1
         
         If SSTab2.TabVisible(nIndice) = True Then
            SSTab2.Tab = nIndice

            If chkEliminaAval(nIndice).Value = 0 Then
               If txtRutAval(nIndice).text = "" Then
                  MsgBox "No ha ingresado el rut del aval", vbExclamation, TITSISTEMA
                  ValidaDatosAval = False
                  txtRutAval(nIndice).SetFocus
                  Exit Function
               End If
   
               If txtDvAval(nIndice).text = "" Then
                  MsgBox "Deve ingresar el digito verificador del Rut.", vbExclamation, TITSISTEMA
                  ValidaDatosAval = False
                  txtDvAval(nIndice).SetFocus
                  Exit Function
               End If
   
               If txtNombreAval(nIndice).text = "" Then
                  MsgBox "No se ha ingresado el nombre del aval", vbExclamation, TITSISTEMA
                  ValidaDatosAval = False
                  txtNombreAval(nIndice).SetFocus
                  Exit Function
               End If
               
   
               If txtDirenAval(nIndice).text = "" Then
                  MsgBox "No ha ingresado la direccion del aval", vbExclamation, TITSISTEMA
                  ValidaDatosAval = False
                  txtDirenAval(nIndice).SetFocus
                  Exit Function
               End If
   
               If CmbCiudadAval(nIndice).text = "" Then
                  MsgBox "No ha seleccionado la ciudad del aval", vbExclamation, TITSISTEMA
                  ValidaDatosAval = False
                  CmbCiudadAval(nIndice).SetFocus
                  Exit Function
               End If
   
               If cmbComunaAval(nIndice).text = "" Then
                  MsgBox "No ha seleccionado la comuna del aval", vbExclamation, TITSISTEMA
                  ValidaDatosAval = False
                  cmbComunaAval(nIndice).SetFocus
                  Exit Function
               End If
   
               If txtRutAval(nIndice).text > 49999999 Then 'ES UNA EMPRESA
                  If txtRutApode1(nIndice).text = "" Then
                     MsgBox "No ha ingresado el rut del apoderado N° 1", vbExclamation, TITSISTEMA
                     ValidaDatosAval = False
                     txtRutApode1(nIndice).SetFocus
                     Exit Function
                  End If
      
                  If txtDvApode1(nIndice).text = "" Then
                     MsgBox "Deve ingresar el digito verificador del rut del apoderado N° 1", vbExclamation, TITSISTEMA
                     ValidaDatosAval = False
                     txtDvApode1(nIndice).SetFocus
                     Exit Function
                  End If
      
                  If txtNomApode1(nIndice).text = "" Then
                     MsgBox "ERROR : Mombre Apoderado 1 (" & SSTab2.Caption & ") en Blanco", vbExclamation, TITSISTEMA
                     ValidaDatosAval = False
                     txtNomApode1(nIndice).SetFocus
                     Exit Function
                  End If
                  
                  If txtRutApode2(nIndice).text <> "" And txtDvApode2(nIndice).text = "" Then
                     MsgBox "Deve ingresar el digito verificador del rut del apoderado N° 2", vbExclamation, TITSISTEMA
                     ValidaDatosAval = False
                     txtDvApode2(nIndice).SetFocus
                     Exit Function
                  End If
                  
                  
                  If txtNomApode2(nIndice).text <> "" And txtRutApode2(nIndice).text = "" Then
                     MsgBox "No ha ingresado el rut del apoderado N° 2", vbExclamation, TITSISTEMA
                     ValidaDatosAval = False
                     txtRutApode2(nIndice).SetFocus
                     Exit Function
                  End If
                  
                  If txtRutApode2(nIndice).text <> "" And txtNomApode2(nIndice).text = "" Then
                     MsgBox "ERROR : Mombre Apoderado 2 (" & SSTab2.Caption & ") en Blanco", vbExclamation, TITSISTEMA
                     ValidaDatosAval = False
                     txtNomApode2(nIndice).SetFocus
                     Exit Function
                  End If
                  
                  
               
               Else 'PERSONA NATURAL
            
                  If Cmb_RegimenConyugal(nIndice).ListIndex = -1 Then
                     MsgBox "Debe seleccionar una opcion para Regimen Conyugal Aval", vbExclamation, TITSISTEMA
                     ValidaDatosAval = False
                     Cmb_RegimenConyugal(nIndice).SetFocus
                     Exit Function
                  End If
                
                  If Cmb_RegimenConyugal(nIndice).text = "CASADO(A) EN SOCIEDAD CONYUGAL" _
                     Or Cmb_RegimenConyugal(nIndice).text = "CASADO(A) CON PART. EN LOS GANANCIALES" Then
                     If txtRutConyAval(nIndice).text = "" Then
                        MsgBox "Debe ingresar rut del conyuge", vbExclamation, TITSISTEMA
                        ValidaDatosAval = False
                        Me.txtRutConyAval(nIndice).SetFocus
                        Exit Function
                     End If
                     
                     If txtDvConyAval(nIndice).text = "" Then
                        MsgBox "Debe ingresar el digito verificador para el rut del conyuge", vbExclamation, TITSISTEMA
                        ValidaDatosAval = False
                        txtDvConyAval(nIndice).SetFocus
                        Exit Function
                     Else
                        If BacValidaRut(txtRutConyAval(nIndice).text, txtDvConyAval(nIndice).text) = False Then
                           MsgBox "RUT Ingresado no es Invalido", vbOKOnly + vbExclamation, TITSISTEMA
                           txtDvConyAval(nIndice).text = ""
                        End If
                     End If
         
                     If txtNomConyAval(nIndice).text = "" Then
                        MsgBox "Debe ingresar el nombre del conyuge", vbExclamation, TITSISTEMA
                        ValidaDatosAval = False
                        txtNomConyAval(nIndice).SetFocus
                        Exit Function
                     End If
                  End If
               End If
            End If
         End If
      Next nContador
   End If
End Function

Sub LimpiaAvales()
   Dim nContador As Integer
   ReDim mAval(20, 1)
   
   mAval(1, 1) = "*"
   
   For nContador = 0 To SSTab2.Tabs - 1
      txtRutAval(nContador).text = ""
      txtDvAval(nContador).text = ""
      txtNombreAval(nContador).text = ""
      ''''txtRazonSocial(nContador).Text = ""
      txtProfeAval(nContador).text = ""
      txtDirenAval(nContador).text = ""
      CmbCiudadAval(nContador).ListIndex = -1
      cmbComunaAval(nContador).ListIndex = -1
      txtRutApode1(nContador).text = ""
      txtDvApode1(nContador).text = ""
      txtNomApode1(nContador).text = ""
      txtRutApode2(nContador).text = ""
      txtDvApode2(nContador).text = ""
      txtNomApode2(nContador).text = ""
      txtRutConyAval(nContador).text = ""
      txtDvConyAval(nContador).text = ""
      txtNomConyAval(nContador).text = ""
      Cmb_RegimenConyugal(nContador).ListIndex = -1
      txtProfConyuge(nContador).text = ""
   Next nContador
End Sub

Private Function ExisteAval(nIndice As Integer) As Boolean
   Dim nContador As Integer
   ExisteAval = True
   
   For nContador = 0 To cmbCantAvales.text - 1
      If chkEliminaAval(nContador).Value = 0 Then
         If nContador <= UBound(mAval, 2) Then
            If mAval(1, nContador) = txtRutAval(nIndice).text And mAval(2, nContador) = txtDvAval(nIndice).text Then
               If nContador <> nIndice + 1 Then
                  ExisteAval = False
                  Exit Function
               End If
            End If
         End If
      End If
   Next nContador

End Function

Function HabilitaDatoAval(bEnabled As Boolean, nIndex As Integer)
      txtRutApode1(nIndex).Enabled = bEnabled
      txtRutApode1(nIndex).text = IIf(bEnabled = True, txtRutApode1(nIndex).text, "")
      
      txtDvApode1(nIndex).Enabled = bEnabled
      txtDvApode1(nIndex).text = IIf(bEnabled = True, txtDvApode1(nIndex).text, "")
      
      txtNomApode1(nIndex).Enabled = bEnabled
      txtNomApode1(nIndex).text = IIf(bEnabled = True, txtNomApode1(nIndex).text, "")
      
      txtRutApode2(nIndex).Enabled = bEnabled
      txtRutApode2(nIndex).text = IIf(bEnabled = True, txtRutApode2(nIndex).text, "")
      
      txtDvApode2(nIndex).Enabled = bEnabled
      txtDvApode2(nIndex).text = IIf(bEnabled = True, txtDvApode2(nIndex).text, "")
      
      txtNomApode2(nIndex).Enabled = bEnabled
      txtNomApode2(nIndex).text = IIf(bEnabled = True, txtNomApode2(nIndex).text, "")
      
   
   txtProfeAval(nIndex).Enabled = (Not bEnabled)
   txtProfeAval(nIndex).text = IIf((Not bEnabled) = True, txtProfeAval(nIndex).text, "")
      txtRutConyAval(nIndex).Enabled = (Not bEnabled)
      txtRutConyAval(nIndex).text = IIf((Not bEnabled) = True, txtRutConyAval(nIndex).text, "")
      txtDvConyAval(nIndex).Enabled = (Not bEnabled)
      txtDvConyAval(nIndex).text = IIf((Not bEnabled) = True, txtDvConyAval(nIndex).text, "")
      txtNomConyAval(nIndex).Enabled = (Not bEnabled)
      txtNomConyAval(nIndex).text = IIf((Not bEnabled) = True, txtNomConyAval(nIndex).text, "")
      Cmb_RegimenConyugal(nIndex).Enabled = (Not bEnabled)
      txtProfConyuge(nIndex).Enabled = (Not bEnabled)
      txtProfConyuge(nIndex).text = IIf((Not bEnabled) = True, txtProfConyuge(nIndex).text, "")
End Function

Function HabilitaDatoAvalEx(bEnabled As Boolean, nIndex As Integer)
    txtNombreAval(nIndex).Enabled = bEnabled
    ''''txtRazonSocial(nIndex).Enabled = bEnabled
    txtProfeAval(nIndex).Enabled = bEnabled
    txtDirenAval(nIndex).Enabled = bEnabled
    CmbCiudadAval(nIndex).Enabled = bEnabled
    cmbComunaAval(nIndex).Enabled = bEnabled
    txtRutApode1(nIndex).Enabled = bEnabled
    txtDvApode1(nIndex).Enabled = bEnabled
    txtNomApode1(nIndex).Enabled = bEnabled
    txtRutApode2(nIndex).Enabled = bEnabled
    txtDvApode2(nIndex).Enabled = bEnabled
    txtNomApode2(nIndex).Enabled = bEnabled
    txtRutConyAval(nIndex).Enabled = bEnabled
    txtDvConyAval(nIndex).Enabled = bEnabled
    txtNomConyAval(nIndex).Enabled = bEnabled
    Cmb_RegimenConyugal(nIndex).Enabled = bEnabled
    txtProfConyuge(nIndex).Enabled = bEnabled
End Function


            
Private Function FuncSaveData()
   Dim CODI          As Variant
   Dim Codigo        As Integer
   Dim Nombre        As String * 70
   Dim Implic        As String
   Dim opcion        As String
   Dim Aba           As String
   Dim Chips         As String
   Dim Swift         As String
   Dim tipocliente   As String
   Dim grupo         As String
   Dim InformeSocial As String
   Dim Articulo85    As String
   Dim FechaArt85    As Date
   Dim DecArticulo85 As String
   Dim Poder         As String
   Dim Firma         As String
   Dim fecingr       As Date
   Dim Oficina       As String
   Dim Rut_Grupo     As Double
   Dim SQL           As String
   Dim Datos()       As String
   Dim Valor         As Integer
   Dim ejecutivo     As Integer
   Dim sBroker       As String
   Dim sFirma_Condic As String
   Dim sFirma_Fecha  As String
   Dim segComercial  As String
   Dim ejeComercial  As String
   Dim motivoBloq    As String
   Dim gtiaTotal     As Double
   
   Sw = 0
   fecingr = Date
   nValida = True
         
   Screen.MousePointer = vbHourglass
      
   If Fr_Avales.Visible = True Then
      Call Cmd_VolverAval_Click
      If Not nValida Then
         Screen.MousePointer = vbDefault
         Exit Function
      End If
   End If
   If Not ValidarDatos() Then   'Valdiaci¢n de los datos del cliente.
      Screen.MousePointer = Default
      Exit Function
   End If

   Screen.MousePointer = vbHourglass

   newRiesgo = Trim(Left(cmbClasificacion.text, 6))
   'PRD-8800
   segComercial = 0
   If cmbSegComercial.ListIndex >= 0 Then
      segComercial = Trim(Right(cmbSegComercial.text, 10)) 'cmbSegComercial.ItemData(cmbSegComercial.ListIndex)
   End If

   ejeComercial = ""
   If cmbEjecutivoCom.ListIndex >= 0 Then
      ejeComercial = cmbEjecutivoCom.text
   End If

   motivoBloq = ""
   If ChkBloqueado.Value = 1 Then
      motivoBloq = txtMotivoBloqueo.text
   End If
         
   gtiaTotal = CDbl(txtGarantiaTotal.text)

   sBroker = "N"
   If chk_brokers.Value = 1 Then
      sBroker = IIf(opt_SBroker.Value = False, "N", "S")
   End If

   sFirma_Condic = "N"
   sFirma_Fecha = "19000101"
   If chk_Condiciones.Value = 1 Then
      sFirma_Condic = "S"
      sFirma_Fecha = Format(Txt_Fecha_Firma.text, "YYYYMMDD")
   End If
         
   OPTI = "J"
   Nombre = Trim(TxtNombre.text)
   If SSOption2.Value = False Then
      OPTI = "N"
      Nombre = Trim(Txt1Apellido.text) & " " & Trim(Txt2Apellido.text) & " " & Trim(Txt1Nombre.text) & " " & Trim(Txt2Nombre.text)
   End If

   tipocliente = 0
   If cmbTipoCliente.ListIndex >= 0 Then
      tipocliente = cmbTipoCliente.ItemData(cmbTipoCliente.ListIndex) ' FUNC_ENTREGA_TIPO_CLIENTE(cmbTipoCliente)
   End If
         
   grupo = 0
   If CmbGrupo.ListIndex >= 0 Then
      grupo = CmbGrupo.ItemData(CmbGrupo.ListIndex) ' FUNC_ENTREGA_TIPO_CLIENTE(cmbTipoCliente)
   End If

   ejecutivo = 0
   
   InformeSocial = IIf(chkInformeSocial.Value = 0, "N", "S")
   Oficina = IIf(chkOficinas.Value = 0, "N", "S")
   Poder = IIf(chkPoder.Value = 0, "N", "S")
   Firma = IIf(chkFirma.Value = 0, "N", "S")

   If OpImplic(0).Value = True Then
      Implic = "A"
      Aba = TxtCod.text
   ElseIf OpImplic(1).Value = True Then
      Implic = "C"
      Chips = TxtCod.text
   Else
      Implic = "S"
      Swift = TxtCod.text
   End If

   opcion = IIf(SSOption1.Value = True, "N", "J")


   Envia = Array()
   AddParam Envia, CDbl(Trim(txtrut.text))                          'Rut
   AddParam Envia, Trim(txtDigito.text)                             'Dig. Verificador
   AddParam Envia, CDbl(Trim(TxtCodigo.text))                       'Código
   AddParam Envia, Trim(Nombre)                                     'Nombre
   AddParam Envia, IIf(SSOption1.Value = True, SSOption1.Tag, Trim(txtgeneric.text))
   AddParam Envia, Trim(TxtDireccion.text)                          'Dirección

   If CmbComuna.ListIndex = -1 Then
      AddParam Envia, 0
   Else
      AddParam Envia, CmbComuna.ItemData(CmbComuna.ListIndex)      'Comuna
   End If

   AddParam Envia, CDbl(0)                                          'Región
   AddParam Envia, CDbl(tipocliente)                                'Tipo Cliente

   If Len(Trim$(fecingr)) < 8 Then
      AddParam Envia, Format(gsbac_fecp, "yyyymmdd")               'Fecha Ingreso
   Else
      AddParam Envia, Format(gsbac_fecp, "yyyymmdd")
   End If

   AddParam Envia, Trim(txtctacte.text)                             'Cuenta Corriente
   AddParam Envia, Trim(TxtTelefono.text)                           'Telefóno
   AddParam Envia, Trim(TxtFax.text)                                'Fax
   AddParam Envia, Trim(Txt1Apellido.text)                          'Primer Apellido
   AddParam Envia, Trim(Txt2Apellido.text)                          'Segundo Apellido
   AddParam Envia, Trim(Txt1Nombre.text)                            'Primer Nombre
   AddParam Envia, Trim(Txt2Nombre.text)                            'Segundo nombre
   AddParam Envia, ""                                               'Apoderado
   AddParam Envia, CmbCiudad.ItemData(CmbCiudad.ListIndex)          'Ciudad
   AddParam Envia, CDbl(Trim(Right(CmbMercado.text, 6)))            'Mercado
   AddParam Envia, grupo                                            ' dato agregado                             'Grupo
   AddParam Envia, cmbPais.ItemData(cmbPais.ListIndex)              'pais
   AddParam Envia, CDbl(Trim(Right(CmbCalidadJuridica.text, 6)))    'Calidad Juridica
   AddParam Envia, 0                                                'tipo ml
   AddParam Envia, 0                                                'tipo mx
   AddParam Envia, 0                                                'Banca
   AddParam Envia, ""                                               'Relación
   AddParam Envia, 0                                                'Número
   AddParam Envia, ""                                               'Comex
   AddParam Envia, Trim(Chips)                                      'Código Chips
   AddParam Envia, Trim(Aba)                                        'Código Aba
   AddParam Envia, Trim(Swift)                                      'Código Swift
   AddParam Envia, 0                                                'nfm
   AddParam Envia, IIf(CheckFM.Value, "S", "N")                     'Fondo Mutuo
   AddParam Envia, "20001231"                                       'Fecha Ultimo
   AddParam Envia, ejecutivo                                        'Ejecutivo
   AddParam Envia, 0                                                'Entidad"
   AddParam Envia, ""                                               'graba
   AddParam Envia, 0                                                'Campint
   AddParam Envia, ""                                               'calle
   AddParam Envia, TxtCtaUSD.text                                   'Cuenta USD
   AddParam Envia, ""                                               'Calidad Juridica
   AddParam Envia, ""                                               'nemo
   AddParam Envia, Trim(Implic)                                     'Implic
   AddParam Envia, Trim(opcion)                                     'Opción
   AddParam Envia, CDbl(Trim(Right(cmbRGBanco.text, 6)))            'Relación Gestión Banco
   AddParam Envia, CDbl(Trim(Right(cmbCategoriaDeudor.text, 6)))    'Categoría Deudor
   AddParam Envia, TraeValor(Trim(Right(cmbComInstitucional.text, 6))) 'Composición Institucional(Sector)
   AddParam Envia, Trim(Left(cmbClasificacion.text, 6))             'Clasificación
   AddParam Envia, TraeValor(Trim(Right(cmbActividadEconomica.text, 6))) 'Actividad económica
   AddParam Envia, tipocliente                                      'Tipo Empresa
   AddParam Envia, CDbl(Trim(Right(cmbRelBanco.text, 6)))           'Relación Banco
   AddParam Envia, Trim(Poder)                                      'Poder
   AddParam Envia, Trim(Firma)                                      'Firma
   AddParam Envia, Format(CDate(FechaArt85), "yyyymmdd")            'Fecha Articulo 85
   AddParam Envia, 0                                                'Relación compañia
   AddParam Envia, 0                                                'Relación corredora
   AddParam Envia, Trim(InformeSocial)                              'Informe Social
   AddParam Envia, Trim(DecArticulo85)                              'Decl. Art.85
   AddParam Envia, CDbl(Rut_Grupo)                                  'Rut grupo Economico
   AddParam Envia, TraeValor(txtCodigoSuper.text)                        ' Codigo Super
   AddParam Envia, TraeValor(txtCodigoBCCH.text)                         ' Codigo BCCH
   AddParam Envia, Trim(Oficina)                                    'Oficina S/N
   AddParam Envia, Trim(txtCRiesgo.text)                            'Clasificación de riesgo
   AddParam Envia, TxtCodigoOtc.text
   AddParam Envia, IIf(ChkBloqueado.Value, "S", "N")
   AddParam Envia, CDbl(txtCosto.text)           ' dato agregado
   AddParam Envia, Me.txtmxcontab.text
   AddParam Envia, Val(TxtRutSinacofi.text)
   AddParam Envia, Txt_DigitoSinacofi
   AddParam Envia, Trim(sBroker)                  ' Contiene Brokers S=Si; N=No
   AddParam Envia, CDbl(txtReceptorRutBco.text)
   AddParam Envia, CDbl(txtReceptorCodBco.text)
   AddParam Envia, sFirma_Condic
   AddParam Envia, sFirma_Fecha
   AddParam Envia, nombre_notaria.text
   AddParam Envia, fecha_escritura.text

   
   If Opt_No.Value = True Or Opt_Si.Value = True Then
      AddParam Envia, IIf(Opt_No.Value, "N", "S")
   Else
      AddParam Envia, "N"
   End If

   'RQ  3827 Contratos Dinamicos de Derivados
   '******************************************************************************
   AddParam Envia, IIf(OptFirm_Si.Value = True, "S", "N")                             'Utiliza Contratos Nuevos
   AddParam Envia, IIf(CmbVerContratos.ListIndex = -1, 0, CmbVerContratos.ListIndex)  'Version Contratos
   AddParam Envia, Format(CDate(fecha_firma_nuevo.text), "yyyymmdd")                  'Fecha de Firma del nuevo Contrato
   AddParam Envia, IIf(OptRetro_Si.Value = True, "S", "N")
   'PRD-3826, 05-02-2010, nuevo parámetros obligatorios
   AddParam Envia, motivoBloq                                                          'Motivo de Bloqueo
   AddParam Envia, segComercial                                                        'Segmento Comercial
   AddParam Envia, ejeComercial                                                        'Ejecutivo Comercial
   AddParam Envia, gtiaTotal                                                           'Monto de la Garantía Total del Cliente
   AddParam Envia, IIf(opt_vigente(0).Value = True, "S", "N")                 'PRD-5896 Estado del Cliente

   AddParam Envia, CDbl(Me.txtGarantiaEfectiva.text)    'PRD-5521, Valor de la Garantía Efectiva
   AddParam Envia, IIf(Trim(Right(cmbMetodologiaREC.text, 10)) = "", 0, Trim(Right(cmbMetodologiaREC.text, 10))) 'PRD-8800
   
   AddParam Envia, Format(TxtFechaPacto.text, "yyyymmdd")   '-> Fecha de Firma de Condiciones Generales para Pactos

    'RQ  19121   Para Contratos ComDer
   '******************************************************************************
   AddParam Envia, IIf(OptComDer_Si.Value = True, "S", "N")
   
   'RQ 19121 V1 Fecha Contrato Comder
   AddParam Envia, Format(CDate(Fecha_Contrato_Comder.text), "yyyymmdd")
   
   
   AddParam Envia, LTrim(RTrim(txtEmail.text))
   
   'INICIO PRD - 21841''''''''''''''''''''''''''''''''''''''''
   If OptNO.Value = True Or OptSI.Value = True Then
      AddParam Envia, IIf(OptNO.Value, "N", "S")
   Else
      AddParam Envia, "N"
   End If
   If LTrim(RTrim(Me.TXT_Decimales.text)) = "" Then
   AddParam Envia, 0
   Else
   AddParam Envia, LTrim(RTrim(Me.TXT_Decimales.text))
   End If
    
   
   'FIN PRD - 21841'''''''''''''''''''''''''''''''''''''''''''
   
   ' Datos fusión'**************************
   AddParam Envia, IIf(Trim(Right(txtSecuencia.text, 10)) = "", 0, Trim(Right(txtSecuencia.text, 10))) 'txtSecuencia.Text
   AddParam Envia, IIf(Trim(Right(txtcodAS400.text, 10)) = "", 0, Trim(Right(txtcodAS400.text, 10)))   'txtcodAS400.Text
   AddParam Envia, IIf(Trim(Right(txtCodCGI.text, 10)) = "", 0, Trim(Right(txtCodCGI.text, 10)))       'txtCodCGI.Text
   '****************************************
   
'---------------------------------------------------------------------------------
'-------------------------------INICIO FUSÍON-------------------------------------
'-----------------NUEVAS INTERFACES BACEN NORMATIVAS A BRASIL---------------------
'---------------------------------------------------------------------------------
        AddParam Envia, IIf(Trim(Right(Txt_codEmpRelacionada.text, 10)) = "", 0, Trim(Right(Txt_codEmpRelacionada.text, 10))) 'Txt_codEmpRelacionada.Text
        AddParam Envia, IIf(Cmb_cod_contra.ListIndex = -1, 0, Cmb_cod_contra.ItemData(Cmb_cod_contra.ListIndex)) 'Cmb_cod_contra.ItemData(Cmb_cod_contra.ListIndex)
        AddParam Envia, IIf(Cmb_cod_emp_cen.ListIndex = -1, 0, Cmb_cod_emp_cen.ItemData(Cmb_cod_emp_cen.ListIndex)) 'Cmb_cod_emp_cen.ItemData(Cmb_cod_emp_cen.ListIndex)
        AddParam Envia, TxtCodigoCPNJ.text
'---------------------------------------------------------------------------------
'-------------------------------FIN FUSÍON----------------------------------------
'-----------------NUEVAS INTERFACES BACEN NORMATIVAS A BRASIL---------------------
'---------------------------------------------------------------------------------
   
   
    AddParam Envia, Me.CmbColateral.text
   
   If Bac_Sql_Execute("BEGIN TRANSACTION") Then
      If Not Bac_Sql_Execute("SP_CLGRABAR1", Envia) Then
         Screen.MousePointer = Default
         Call Bac_Sql_Execute("ROLLBACK TRANSACTION")
         MsgBox "Se ha originado un error al grabar el cliente.", vbCritical, TITSISTEMA
         Exit Function
      End If

      'PRD-5896 Estado del Cliente, queda registrado el cambio de Estado del Cliente
      If (gsEstado$ = "S" And opt_vigente(1).Value = True) Or (gsEstado$ = "N" And opt_vigente(0).Value = True) Then
              Call Grabar_Log_AUDITORIA(giBAC_Entidad, gsbac_fecp, gsBAC_Term, gsBAC_User, "PCA", " ", "11", "Cambia Estado Cliente de " & IIf(gsEstado$ = "S", "No Vigente", "Vigente") & " a " & IIf(gsEstado$ = "S", "Vigente", "No Vigente"), "TABLA CLIENTE", " ", "Modificación Cliente : " & Trim(Nombre))
      End If
      
      If cmbCantAvales.ListIndex > -1 Then
         Call GuardaAvales
      End If

      Call Grabar_Log_AUDITORIA(giBAC_Entidad, gsbac_fecp, gsBac_IP, gsBAC_User, "PCA", "OPC_21 ", "02", "Grabacion De Cliente Correcta ", "TABLA CLIENTE", " ", "Modificación Cliente : " & Trim(Nombre))

      'ASIGNACION DE CONTRATOS POR DEFECTO
      Envia = Array()
      AddParam Envia, CDbl(Trim(txtrut.text))                          'Rut
      AddParam Envia, CDbl(Trim(TxtCodigo.text))                       'Código
      If Not Bac_Sql_Execute("SP_ACT_DEFECTO_CLIENTE_CONTRATO_DERIVADOS", Envia) Then
         Call Bac_Sql_Execute("ROLLBACK TRANSACTION")
         Screen.MousePointer = Default
         MsgBox "Error al Grabar el Cliente. No es posible asignarle contratos por defecto", vbCritical, TITSISTEMA
         Exit Function
      End If

      Call Grabar_Log_AUDITORIA(giBAC_Entidad, gsbac_fecp, gsBac_IP, gsBAC_User, "PCA", "OPC_21 ", "02", "Asignacion de Contratos por defecto correcta ", "TBL_CLIENTE_CONTRATO_DERIVADOS", " ", " ")

   End If
         
   Call Bac_Sql_Execute("COMMIT TRANSACTION")
   
   Screen.MousePointer = vbDefault
   MsgBox "Grabación se realizó correctamente", vbInformation, TITSISTEMA

   Call Limpiar
   Call LimpiaAvales

   HabilitarControles False
   Toolbar1.Buttons(3).Enabled = True
End Function

'PROD-10967
Private Function Rescata_Familia_FM()

Dim Datos()
      
      
   Rescata_Familia_FM = True
   
   Envia = Array()
   AddParam Envia, CDbl(IIf(Trim(txtrut.text) = "", 0, Trim(txtrut.text)))
   AddParam Envia, CDbl(IIf(TxtCodigo.text = "", 0, Trim(TxtCodigo.text)))
   If Not Bac_Sql_Execute("BacLineas.dbo.SP_RIEFIN_FAMILIAS", Envia) Then
      Exit Function
   End If
   
   Do While Bac_SQL_Fetch(Datos())
      If Datos(4) = 1 Then
          Exit Function
      End If

   Loop
   
   Rescata_Familia_FM = False
     
End Function

Private Sub Carga_Combo_Cliente_FM()
     
Dim Datos()

   If Not Bac_Sql_Execute("SP_CONMETODOLOGIAREC_FM") Then
      Exit Sub
   End If
   Call cmbMetodologiaREC.Clear
   Do While Bac_SQL_Fetch(Datos())
      Call cmbMetodologiaREC.AddItem(Trim(Datos(3)) & Space(80) & Datos(1))
   Loop
End Sub



Private Sub Txtemail_KeyPress(KeyAscii As Integer)
    Let KeyAscii = Asc(LCase(Chr(KeyAscii)))
    If KeyAscii = vbKeyReturn Or KeyAscii = vbKeyTab Then
        Call Validar_Email(txtEmail.text)
    End If
End Sub

Public Function Validar_Email(ByVal Email As String) As Boolean
    Dim strTmp          As String
    Dim n               As Long
    Dim sEXT            As String
    Dim Pos             As Integer
    Dim MensajeError    As String
        
    Let MensajeError = ""
    
    Let Validar_Email = False

    sEXT = Email
    Do While InStr(1, sEXT, ".") <> 0
        sEXT = Right(sEXT, Len(sEXT) - InStr(1, sEXT, "."))
    Loop

    If Email <> "" Then
        If InStr(1, Email, "@") = 0 Then
            Let MensajeError = MensajeError & "- No contiene @ " & vbNewLine
        End If
        If InStr(1, Email, "@") = 1 Then
            Let MensajeError = MensajeError & "- ( @ ), no puede estar el principio." & vbNewLine
        End If
        If InStr(1, Email, "@") = Len(Email) Then
            Let MensajeError = MensajeError & "- ( @ ), no puede estar al final." & vbNewLine
        End If
        If InStr(1, Email, ".") = Len(Email) Then
            Let MensajeError = MensajeError & "- ( . ), no puede estar al final." & vbNewLine
        End If
        If EXTisOK(sEXT) = False Then
            Let MensajeError = MensajeError & "- La dirección de correo, no tiene un Dominio válido. " & vbNewLine
        End If
        If Len(Email) < 6 Then
            MensajeError = MensajeError & "- La dirección de correo, no puede ser menor a 6 caracteres." & vbNewLine
        End If
        
        strTmp = Email
        Do While InStr(1, strTmp, "@") <> 0
            n = n + 1
            strTmp = Right(strTmp, Len(strTmp) - InStr(1, strTmp, "@"))
        Loop

        If n > 1 Then
            Let MensajeError = MensajeError & "- La direccion de Correo debe contener solo un caracter ( @ ). " & vbNewLine
        End If
    
        Pos = InStr(1, Email, "@")

        If InStr(1, Email, ".@") > 0 Then
            Let MensajeError = MensajeError & "- La dirección de correo, no puede contener un ( . ), segido de un caracter ( @ ). " & vbNewLine
        End If
        
        If Len(MensajeError) > 0 Then
            Call MsgBox(" Dirección de Correo no valida" & vbCrLf & vbCrLf & MensajeError, vbExclamation, App.Title)
            Exit Function
        Else
            Let Validar_Email = True
        End If
    End If

End Function


Public Function EXTisOK(ByVal sEXT As String) As Boolean
    Dim EXT     As String
    Dim X       As Long
    
    EXTisOK = False

    If Left(sEXT, 1) <> "." Then
        sEXT = "." & sEXT
    End If
    
    sEXT = UCase(sEXT) 'just to avoid errors
    EXT = EXT & ".COM.EDU.GOV.NET.BIZ.ORG.TV"
    EXT = EXT & ".AF.AL.DZ.As.AD.AO.AI.AQ.AG.AP.AR.AM.AW.AU.AT.AZ.BS.BH.BD.BB.BY"
    EXT = EXT & ".BE.BZ.BJ.BM.BT.BO.BA.BW.BV.BR.IO.BN.BG.BF.MM.BI.KH.CM.CA.CV.KY"
    EXT = EXT & ".CF.TD.CL.CN.CX.CC.CO.KM.CG.CD.CK.CR.CI.HR.CU.CY.CZ.DK.DJ.DM.DO"
    EXT = EXT & ".TP.EC.EG.SV.GQ.ER.EE.ET.FK.FO.FJ.FI.CS.SU.FR.FX.GF.PF.TF.GA.GM.GE.DE"
    EXT = EXT & ".GH.GI.GB.GR.GL.GD.GP.GU.GT.GN.GW.GY.HT.HM.HN.HK.HU.IS.IN.ID.IR.IQ"
    EXT = EXT & ".IE.IL.IT.JM.JP.JO.KZ.KE.KI.KW.KG.LA.LV.LB.LS.LR.LY.LI.LT.LU.MO.MK.MG"
    EXT = EXT & ".MW.MY.MV.ML.MT.MH.MQ.MR.MU.YT.MX.FM.MD.MC.MN.MS.MA.MZ.NA"
    EXT = EXT & ".NR.NP.NL.AN.NT.NC.NZ.NI.NE.NG.NU.NF.KP.MP.NO.OM.PK.PW.PA.PG.PY"
    EXT = EXT & ".PE.PH.PN.PL.PT.PR.QA.RE.RO.RU.RW.GS.SH.KN.LC.PM.ST.VC.SM.SA.SN.SC"
    EXT = EXT & ".SL.SG.SK.SI.SB.SO.ZA.KR.ES.LK.SD.SR.SJ.SZ.SE.CH.SY.TJ.TW.TZ.TH.TG.TK"
    EXT = EXT & ".TO.TT.TN.TR.TM.TC.TV.UG.UA.AE.UK.US.UY.UM.UZ.VU.VA.VE.VN.VG.VI"
    EXT = EXT & ".WF.WS.EH.YE.YU.ZR.ZM.ZW"
    EXT = UCase(EXT) 'just to avoid errors
    If InStr(1, EXT, sEXT, 0) <> 0 Then
        EXTisOK = True
    End If
End Function
