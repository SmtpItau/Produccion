VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "threed32.ocx"
Begin VB.Form Frm_Man_Feriados 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantenedor de Feriados"
   ClientHeight    =   6555
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   9045
   Icon            =   "Frm_Man_Feriados.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   6555
   ScaleWidth      =   9045
   Begin VB.Frame Frame1 
      Height          =   6075
      Left            =   0
      TabIndex        =   0
      Top             =   480
      Width           =   9045
      Begin VB.Frame Frame2 
         Height          =   5865
         Left            =   60
         TabIndex        =   59
         Top             =   120
         Width           =   3915
         Begin MSComctlLib.TreeView Tree_Plaza 
            Height          =   5535
            Left            =   90
            TabIndex        =   60
            ToolTipText     =   "Plazas existentes"
            Top             =   210
            Width           =   3735
            _ExtentX        =   6588
            _ExtentY        =   9763
            _Version        =   393217
            LabelEdit       =   1
            LineStyle       =   1
            Style           =   7
            FullRowSelect   =   -1  'True
            Appearance      =   1
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            OLEDragMode     =   1
         End
      End
      Begin VB.Frame Frame3 
         Height          =   5865
         Left            =   4020
         OLEDropMode     =   1  'Manual
         TabIndex        =   1
         Top             =   120
         Width           =   4935
         Begin Threed.SSFrame SSFrame1 
            Height          =   4125
            Left            =   90
            TabIndex        =   2
            Top             =   1590
            Width           =   4725
            _Version        =   65536
            _ExtentX        =   8334
            _ExtentY        =   7276
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
               Left            =   3180
               Locked          =   -1  'True
               OLEDropMode     =   1  'Manual
               TabIndex        =   44
               ToolTipText     =   "Dias del mes seleccionado"
               Top             =   1740
               Width           =   465
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
               Left            =   3660
               Locked          =   -1  'True
               OLEDropMode     =   1  'Manual
               TabIndex        =   43
               ToolTipText     =   "Dias del mes seleccionado"
               Top             =   3000
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
               Left            =   3180
               Locked          =   -1  'True
               OLEDropMode     =   1  'Manual
               TabIndex        =   42
               ToolTipText     =   "Dias del mes seleccionado"
               Top             =   3000
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
               Left            =   2700
               Locked          =   -1  'True
               OLEDropMode     =   1  'Manual
               TabIndex        =   41
               ToolTipText     =   "Dias del mes seleccionado"
               Top             =   3000
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
               Left            =   2220
               Locked          =   -1  'True
               OLEDropMode     =   1  'Manual
               TabIndex        =   40
               ToolTipText     =   "Dias del mes seleccionado"
               Top             =   3000
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
               Left            =   1740
               Locked          =   -1  'True
               OLEDropMode     =   1  'Manual
               TabIndex        =   39
               ToolTipText     =   "Dias del mes seleccionado"
               Top             =   3000
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
               Left            =   1260
               Locked          =   -1  'True
               OLEDropMode     =   1  'Manual
               TabIndex        =   38
               ToolTipText     =   "Dias del mes seleccionado"
               Top             =   3000
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
               Left            =   780
               Locked          =   -1  'True
               OLEDropMode     =   1  'Manual
               TabIndex        =   37
               ToolTipText     =   "Dias del mes seleccionado"
               Top             =   3000
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
               Left            =   3660
               Locked          =   -1  'True
               OLEDropMode     =   1  'Manual
               TabIndex        =   36
               ToolTipText     =   "Dias del mes seleccionado"
               Top             =   2565
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
               Left            =   3180
               Locked          =   -1  'True
               OLEDropMode     =   1  'Manual
               TabIndex        =   35
               ToolTipText     =   "Dias del mes seleccionado"
               Top             =   2565
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
               Left            =   2700
               Locked          =   -1  'True
               OLEDropMode     =   1  'Manual
               TabIndex        =   34
               ToolTipText     =   "Dias del mes seleccionado"
               Top             =   2565
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
               Left            =   2220
               Locked          =   -1  'True
               OLEDropMode     =   1  'Manual
               TabIndex        =   33
               ToolTipText     =   "Dias del mes seleccionado"
               Top             =   2565
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
               Left            =   1740
               Locked          =   -1  'True
               OLEDropMode     =   1  'Manual
               TabIndex        =   32
               ToolTipText     =   "Dias del mes seleccionado"
               Top             =   2565
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
               Left            =   1260
               Locked          =   -1  'True
               OLEDropMode     =   1  'Manual
               TabIndex        =   31
               ToolTipText     =   "Dias del mes seleccionado"
               Top             =   2565
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
               Left            =   780
               Locked          =   -1  'True
               OLEDropMode     =   1  'Manual
               TabIndex        =   30
               ToolTipText     =   "Dias del mes seleccionado"
               Top             =   2565
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
               Left            =   3660
               Locked          =   -1  'True
               OLEDropMode     =   1  'Manual
               TabIndex        =   29
               ToolTipText     =   "Dias del mes seleccionado"
               Top             =   2145
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
               Left            =   3180
               Locked          =   -1  'True
               OLEDropMode     =   1  'Manual
               TabIndex        =   28
               ToolTipText     =   "Dias del mes seleccionado"
               Top             =   2145
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
               Left            =   2700
               Locked          =   -1  'True
               OLEDropMode     =   1  'Manual
               TabIndex        =   27
               ToolTipText     =   "Dias del mes seleccionado"
               Top             =   2145
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
               Left            =   2220
               Locked          =   -1  'True
               OLEDropMode     =   1  'Manual
               TabIndex        =   26
               ToolTipText     =   "Dias del mes seleccionado"
               Top             =   2145
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
               Left            =   1740
               Locked          =   -1  'True
               OLEDropMode     =   1  'Manual
               TabIndex        =   25
               ToolTipText     =   "Dias del mes seleccionado"
               Top             =   2145
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
               Left            =   1260
               Locked          =   -1  'True
               OLEDropMode     =   1  'Manual
               TabIndex        =   24
               ToolTipText     =   "Dias del mes seleccionado"
               Top             =   2145
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
               Left            =   780
               Locked          =   -1  'True
               OLEDropMode     =   1  'Manual
               TabIndex        =   23
               ToolTipText     =   "Dias del mes seleccionado"
               Top             =   2145
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
               Left            =   3660
               Locked          =   -1  'True
               OLEDropMode     =   1  'Manual
               TabIndex        =   22
               ToolTipText     =   "Dias del mes seleccionado"
               Top             =   1740
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
               Left            =   2700
               Locked          =   -1  'True
               OLEDropMode     =   1  'Manual
               TabIndex        =   21
               ToolTipText     =   "Dias del mes seleccionado"
               Top             =   1740
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
               Left            =   2220
               Locked          =   -1  'True
               OLEDropMode     =   1  'Manual
               TabIndex        =   20
               ToolTipText     =   "Dias del mes seleccionado"
               Top             =   1740
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
               Left            =   1740
               Locked          =   -1  'True
               OLEDropMode     =   1  'Manual
               TabIndex        =   19
               ToolTipText     =   "Dias del mes seleccionado"
               Top             =   1740
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
               Left            =   1260
               Locked          =   -1  'True
               OLEDropMode     =   1  'Manual
               TabIndex        =   18
               ToolTipText     =   "Dias del mes seleccionado"
               Top             =   1740
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
               Left            =   780
               Locked          =   -1  'True
               OLEDropMode     =   1  'Manual
               TabIndex        =   17
               ToolTipText     =   "Dias del mes seleccionado"
               Top             =   1740
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
               Left            =   3660
               Locked          =   -1  'True
               OLEDropMode     =   1  'Manual
               TabIndex        =   16
               ToolTipText     =   "Dias del mes seleccionado"
               Top             =   1320
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
               Left            =   3180
               Locked          =   -1  'True
               OLEDropMode     =   1  'Manual
               TabIndex        =   15
               ToolTipText     =   "Dias del mes seleccionado"
               Top             =   1320
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
               Left            =   2700
               Locked          =   -1  'True
               OLEDropMode     =   1  'Manual
               TabIndex        =   14
               ToolTipText     =   "Dias del mes seleccionado"
               Top             =   1320
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
               Left            =   2220
               Locked          =   -1  'True
               OLEDropMode     =   1  'Manual
               TabIndex        =   13
               ToolTipText     =   "Dias del mes seleccionado"
               Top             =   1320
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
               Left            =   1740
               Locked          =   -1  'True
               OLEDropMode     =   1  'Manual
               TabIndex        =   12
               ToolTipText     =   "Dias del mes seleccionado"
               Top             =   1320
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
               Left            =   1260
               Locked          =   -1  'True
               OLEDropMode     =   1  'Manual
               TabIndex        =   11
               ToolTipText     =   "Dias del mes seleccionado"
               Top             =   1320
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
               Left            =   780
               Locked          =   -1  'True
               OLEDropMode     =   1  'Manual
               TabIndex        =   10
               ToolTipText     =   "Dias del mes seleccionado"
               Top             =   1320
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
               Left            =   3660
               Locked          =   -1  'True
               OLEDropMode     =   1  'Manual
               TabIndex        =   9
               ToolTipText     =   "Dias del mes seleccionado"
               Top             =   900
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
               Left            =   3180
               Locked          =   -1  'True
               OLEDropMode     =   1  'Manual
               TabIndex        =   8
               ToolTipText     =   "Dias del mes seleccionado"
               Top             =   900
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
               Left            =   2700
               Locked          =   -1  'True
               OLEDropMode     =   1  'Manual
               TabIndex        =   7
               ToolTipText     =   "Dias del mes seleccionado"
               Top             =   900
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
               Left            =   2220
               Locked          =   -1  'True
               OLEDropMode     =   1  'Manual
               TabIndex        =   6
               ToolTipText     =   "Dias del mes seleccionado"
               Top             =   900
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
               Left            =   1740
               Locked          =   -1  'True
               OLEDropMode     =   1  'Manual
               TabIndex        =   5
               ToolTipText     =   "Dias del mes seleccionado"
               Top             =   900
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
               Left            =   1260
               Locked          =   -1  'True
               OLEDropMode     =   1  'Manual
               TabIndex        =   4
               ToolTipText     =   "Dias del mes seleccionado"
               Top             =   900
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
               Left            =   780
               Locked          =   -1  'True
               OLEDropMode     =   1  'Manual
               TabIndex        =   3
               ToolTipText     =   "Dias del mes seleccionado"
               Top             =   900
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
               Left            =   780
               TabIndex        =   51
               Top             =   600
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
               Left            =   1260
               TabIndex        =   50
               Top             =   600
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
               Left            =   1740
               TabIndex        =   49
               Top             =   600
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
               Left            =   2220
               TabIndex        =   48
               Top             =   600
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
               Left            =   2700
               TabIndex        =   47
               Top             =   600
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
               Left            =   3180
               TabIndex        =   46
               Top             =   600
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
               Left            =   3660
               TabIndex        =   45
               Top             =   600
               Width           =   495
            End
         End
         Begin Threed.SSFrame SSFrame2 
            Height          =   960
            Left            =   90
            TabIndex        =   52
            Top             =   630
            Width           =   2340
            _Version        =   65536
            _ExtentX        =   4128
            _ExtentY        =   1693
            _StockProps     =   14
            ForeColor       =   12632256
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
               Left            =   120
               Style           =   2  'Dropdown List
               TabIndex        =   53
               ToolTipText     =   "Seleccionar mes"
               Top             =   435
               Width           =   1995
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
               Left            =   150
               TabIndex        =   54
               Top             =   180
               Width           =   1335
            End
         End
         Begin Threed.SSFrame SSFrame3 
            Height          =   960
            Left            =   2490
            TabIndex        =   55
            Top             =   615
            Width           =   2340
            _Version        =   65536
            _ExtentX        =   4128
            _ExtentY        =   1693
            _StockProps     =   14
            ForeColor       =   12632256
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
               TabIndex        =   56
               ToolTipText     =   "Seleccinar año"
               Top             =   450
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
               TabIndex        =   57
               Top             =   180
               Width           =   615
            End
         End
         Begin VB.Label lbl_Buscar 
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
            Height          =   330
            Left            =   150
            TabIndex        =   58
            Top             =   240
            Width           =   4635
         End
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Height          =   450
      Left            =   0
      TabIndex        =   61
      Top             =   0
      Width           =   9030
      _ExtentX        =   15928
      _ExtentY        =   794
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Style           =   1
      ImageList       =   "Img_opciones"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
      Begin MSComctlLib.ImageList Img_opciones 
         Left            =   6630
         Top             =   -30
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   24
         ImageHeight     =   24
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   12
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Man_Feriados.frx":2EFA
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Man_Feriados.frx":3361
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Man_Feriados.frx":3857
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Man_Feriados.frx":3CEA
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Man_Feriados.frx":41D2
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Man_Feriados.frx":46E5
               Key             =   ""
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Man_Feriados.frx":4BB8
               Key             =   ""
            EndProperty
            BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Man_Feriados.frx":507E
               Key             =   ""
            EndProperty
            BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Man_Feriados.frx":5575
               Key             =   ""
            EndProperty
            BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Man_Feriados.frx":596E
               Key             =   ""
            EndProperty
            BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Man_Feriados.frx":5D64
               Key             =   ""
            EndProperty
            BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Man_Feriados.frx":62A1
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
End
Attribute VB_Name = "Frm_Man_Feriados"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'  Autor          : Douglas Lefin
'  Descripción    : Mantención de feriados
'  Fecha Creación : 28/11/2002
'  Fecha Modificación   : DD/MM/YYYY
'  Modificado Por       : Nombre de la persona que modifica la forma
'  Cambios Realizados   : Explicación de la modificación FORMULARIOS
 
Option Explicit
Dim Datos()
Dim i As Integer
Dim cPlaza As String
Dim cPais  As String
Dim bCarga As Boolean
Dim OptLocal As String
Dim cPaisSeleccion As String

Private Sub cmbano_Click()
   If Not bCarga Then Exit Sub
   Call FUNC_CARGA_MES
End Sub

Private Sub cmbMeses_Click()
   If Not bCarga Then Exit Sub
   Call FUNC_CARGA_MES
End Sub


Private Sub Form_Activate()
   PROC_CARGA_AYUDA Me, " "
   DoEvents
   Screen.MousePointer = 11
   Call FUNC_CARGA_TREE
   PROC_BUSCA_SELECCION cPaisSeleccion
   Screen.MousePointer = 0
   
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)

If KeyCode <> vbKeyControl And (Shift = 2 Or (Shift = 0 And (KeyCode = vbKeyReturn Or KeyCode = vbKeyEscape Or (KeyCode >= vbKeyF1 And KeyCode <= vbKeyF12)))) Then

   Select Case KeyCode

         Case vbKeyGrabar
               
               Call FUNC_GRABAR_MES
         
         Case vbKeySalir
              
              Unload Me
   End Select


End If


End Sub

Private Sub Form_Load()
Me.top = 0
Me.left = 0
bCarga = False
OptLocal = Opt

   Call LogAuditoria("08", OptLocal, Me.Caption, "", "")
   
   Call BacLLenaComboMes(cmbMeses)

    For i = 1900 To 2054
      Me.cmbano.AddItem i
    Next
    cmbano.Text = CDbl(Year(gsbac_fecp))
    For i = 0 To cmbMeses.ListCount - 1
        If cmbMeses.ItemData(i) = Month(gsbac_fecp) Then
           cmbMeses.ListIndex = i
           Exit For
        End If
    Next

   bCarga = True
   Call FUNC_CARGA_MES
   Call FUNC_CARGA_TREE
   PROC_BUSCA_SELECCION , 1, 22
End Sub

Function FUNC_CARGA_TREE()
On Error GoTo Err_Tree
   
   With Tree_Plaza
      
      .Nodes.Clear
      If BAC_SQL_EXECUTE("SP_CON_PAIS_PLAZAS ") Then
         Do While BAC_SQL_FETCH(Datos())
            .Nodes.Add , , "'" & Trim(Datos(1)) & "'", Datos(2)
         Loop
      End If
         
      If BAC_SQL_EXECUTE("Sp_Mostrar_Plaza ") Then '
         Do While BAC_SQL_FETCH(Datos())
            .Nodes.Add "'" & Trim(Datos(2)) & "'", 4, "'" & Trim(Datos(1)) & "x'", Datos(4)
         Loop
      End If
   
'      For I = 1 To .Nodes.Count - 1
'            If .Nodes.Item(I).Key = "'1'" And .Nodes.Item(I).child.Key = "'22x'" Then
'               .Nodes.Item(I).child.Selected = True
'               .SelectedItem.Selected = True
'               Exit For
'            End If
'      Next
      
      'Call Tree_Plaza_NodeClick(.Nodes.Item(I).child)
      
   End With
   
Exit Function
Err_Tree:
MsgBox err.Description, 16

End Function

Private Sub Form_Unload(Cancel As Integer)
   Call LogAuditoria("08", OptLocal, Me.Caption, "", "")
End Sub

Private Sub Frame3_OLEDragDrop(Data As DataObject, Effect As Long, Button As Integer, Shift As Integer, X As Single, Y As Single)

   Call FUNC_CARGA_MES

End Sub

Private Sub Text1_Click(Index As Integer)
      
      If Index = 5 Or Index = 6 Or Index = 12 Or Index = 13 Or Index = 19 Or Index = 20 Or Index = 26 Or Index = 27 Or Index = 33 Or Index = 34 Or Index = 40 Or Index = 41 Then
         Exit Sub
      End If
      
      If Text1.Item(Index).ForeColor = vbRed Then
         Text1.Item(Index).ForeColor = &H80000012
      Else
         Text1.Item(Index).ForeColor = vbRed
      End If

End Sub

Private Sub Text1_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)
   
      If Index = 5 Or Index = 6 Or Index = 12 Or Index = 13 Or Index = 19 Or Index = 20 Or Index = 26 Or Index = 27 Or Index = 33 Or Index = 34 Or Index = 40 Or Index = 41 Then
         Exit Sub
      End If
   
   If KeyCode = 13 Or KeyCode = 32 Then
      If Text1.Item(Index).ForeColor = vbRed Then
         Text1.Item(Index).ForeColor = &H80000012
      Else
         Text1.Item(Index).ForeColor = vbRed
      End If
   End If
   
End Sub

Private Sub Text1_OLEDragDrop(Index As Integer, Data As DataObject, Effect As Long, Button As Integer, Shift As Integer, X As Single, Y As Single)

   Call FUNC_CARGA_MES

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

   Select Case Button.Index
      Case 1
         Call FUNC_GRABAR_MES
      Case 2
         Unload Me

   End Select

End Sub

Function FUNC_LIMPIAR_MES()
   For i = 0 To 41
            Text1(i).Text = ""
            Text1(i).ForeColor = &H80000012
   Next
End Function

Function FUNC_GRABAR_MES() As Boolean
On Error GoTo Errores
Dim cAnio_mes As String
      
      If cPais = "" Or cPais = "X" Or cPlaza = "" Then
            MsgBox "Debe seleccionar una plaza para ese pais", vbOKOnly
            Exit Function
      End If
      
      
      cAnio_mes = Format(cmbano.Text, "0000") & Format(cmbMeses.ListIndex + 1, "00")
      
      If Not BAC_SQL_EXECUTE("BEGIN TRANSACTION") Then GoTo Errores
      
         For i = 0 To 39
             If i = 5 Or i = 12 Or i = 19 Or i = 26 Or i = 33 Then
                i = i + 2
             End If
             
            Envia = Array()
            AddParam Envia, cPais
            AddParam Envia, cPlaza
            AddParam Envia, cAnio_mes & Text1(i).Text
            If Text1(i).ForeColor = vbRed Then
               AddParam Envia, "S"
            Else
               AddParam Envia, "N"
            End If
             
            If Not BAC_SQL_EXECUTE("SP_ACT_FERIADO ", Envia) Then GoTo Errores
   
         Next

  
      If Not BAC_SQL_EXECUTE("COMMIT TRANSACTION") Then GoTo Errores
 
         MsgBox "Información Grabada Correctamente.", vbOKOnly + vbInformation
         Call LogAuditoria("08", OptLocal, Me.Caption, "Información Grabada Correctamente.", "")
  
Exit Function
Errores:
 
If Not BAC_SQL_EXECUTE("ROLLBACK TRANSACTION") Then
   MsgBox "Error al Reversar la Acción", vbOKOnly + vbCritical
   Call LogAuditoria("08", OptLocal, Me.Caption, "Error al Reversar la Acción.", "")
   Exit Function
End If
 
   MsgBox "Información No fue Grabada.", vbOKOnly + vbCritical
   Call LogAuditoria("08", OptLocal, Me.Caption, "Información No fue Grabada.", "")
End Function

Function FUNC_CARGA_MES()
On Error GoTo Err_Tree
Dim nDia As Integer
   
   If cPais = "" Or cPlaza = "" Then Exit Function
   If cPais = "X" Then Exit Function


   Call FUNC_LIMPIAR_MES
   
    Envia = Array()
    AddParam Envia, cPais
    AddParam Envia, cPlaza
    AddParam Envia, Format(cmbano.Text, "0000") & Format(cmbMeses.ListIndex + 1, "00") + "01"
     
    If Not BAC_SQL_EXECUTE("SP_CON_FERIADO ", Envia) Then
        MsgBox "Error al traer las fecha", 16
         Call LogAuditoria("08", OptLocal, Me.Caption, "Error al traer las fecha.", "")
        Exit Function
    End If
    
    Do While BAC_SQL_FETCH(Datos())

            If Datos(2) = 1 Then
               nDia = Datos(1) - 1
            Else
               nDia = nDia + 1
            End If

            Text1(nDia).Text = Format(Datos(2), "00")
            If Datos(3) = "S" Then
               Text1(nDia).ForeColor = vbRed
            End If
     Loop
Exit Function
Err_Tree:
MsgBox err.Description, 16
Call LogAuditoria("08", OptLocal, Me.Caption, err.Description, "")
End Function


Private Sub Toolbar1_OLEDragDrop(Data As MSComctlLib.DataObject, Effect As Long, Button As Integer, Shift As Integer, X As Single, Y As Single)

      Call FUNC_CARGA_MES

End Sub

Private Sub Tree_Plaza_NodeClick(ByVal Node As MSComctlLib.Node)

   With Tree_Plaza
   
      If Mid(Replace(Node.Key, "'", ""), Len(Replace(Node.Key, "'", "")), 1) <> "x" Then
            lbl_Buscar.Caption = "PAIS " & Node.Text
            Exit Sub
      Else
            lbl_Buscar.Caption = "PLAZA " & Node.Text & " DE " & Node.Parent
      End If
      
      cPlaza = Replace(Replace(Node.Key, "'", ""), "x", "")
      cPais = Replace(Node.Parent.Key, "'", "")
      
  End With
  
  Call FUNC_CARGA_MES
  
  cPaisSeleccion = Node.Text
  
End Sub

Private Sub PROC_BUSCA_SELECCION(Optional cPaisSeleccion As String, Optional cPais As Integer, Optional cPlaza As Integer)
Dim i As Long

   If (IsMissing(cPais) And IsMissing(cPlaza)) Or Not (cPais = 0 And cPlaza = 0) Then

      With Tree_Plaza
      
         For i = 1 To .Nodes.Count
      
            If .Nodes.Item(i).Key = "'" & CStr(cPlaza) & "x'" Then
               .Nodes.Item(i).Selected = True
               Tree_Plaza_NodeClick .Nodes.Item(i)
               Exit Sub
            
            End If
      
         Next
      
      End With


   ElseIf IsMissing(cPaisSeleccion) Or Not cPaisSeleccion = "" Then

      With Tree_Plaza
      
         For i = 1 To .Nodes.Count
      
            If .Nodes(i).Text = cPaisSeleccion Then
               .Nodes.Item(i).Selected = True
               Tree_Plaza_NodeClick .Nodes.Item(i)
               Exit Sub
            
            End If
      
         Next
      
      End With
   
   End If

End Sub

