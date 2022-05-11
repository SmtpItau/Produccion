VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{05BDEB52-1755-11D5-9109-000102BF881D}#1.0#0"; "BacControles.ocx"
Begin VB.Form FlujoContableInstrumento 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Flujo Contable Instrumento"
   ClientHeight    =   5475
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   6990
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   5475
   ScaleWidth      =   6990
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   4
      Top             =   0
      Width           =   6990
      _ExtentX        =   12330
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
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
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Procesar"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   5
         EndProperty
      EndProperty
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   4485
         Top             =   0
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
               Picture         =   "FlujoContableInstrumento.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FlujoContableInstrumento.frx":0452
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FlujoContableInstrumento.frx":08A4
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FlujoContableInstrumento.frx":0BBE
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FlujoContableInstrumento.frx":1010
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin Threed.SSPanel SSPanel1 
      Height          =   5025
      Left            =   0
      TabIndex        =   0
      Top             =   465
      Width           =   7020
      _Version        =   65536
      _ExtentX        =   12382
      _ExtentY        =   8864
      _StockProps     =   15
      BackColor       =   11639171
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BevelOuter      =   0
      BevelInner      =   1
      Begin Threed.SSFrame SSFrame1 
         Height          =   4845
         Left            =   105
         TabIndex        =   5
         Top             =   60
         Width           =   6795
         _Version        =   65536
         _ExtentX        =   11986
         _ExtentY        =   8546
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
         ShadowStyle     =   1
         Begin Threed.SSFrame SSFrame2 
            Height          =   840
            Left            =   30
            TabIndex        =   6
            Top             =   105
            Width           =   6705
            _Version        =   65536
            _ExtentX        =   11827
            _ExtentY        =   1482
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
            Begin VB.TextBox TxtMoneda 
               BeginProperty Font 
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
               Left            =   5370
               MouseIcon       =   "FlujoContableInstrumento.frx":132A
               MousePointer    =   99  'Custom
               TabIndex        =   2
               Top             =   150
               Width           =   1050
            End
            Begin VB.TextBox TxtInstrumento 
               BeginProperty Font 
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
               Left            =   1455
               MouseIcon       =   "FlujoContableInstrumento.frx":1634
               MousePointer    =   99  'Custom
               TabIndex        =   1
               Top             =   150
               Width           =   1455
            End
            Begin BacControles.txtFecha txtFecha 
               Height          =   315
               Left            =   1455
               TabIndex        =   3
               Top             =   450
               Width           =   1470
               _ExtentX        =   2593
               _ExtentY        =   556
               Text            =   "09/05/2001"
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
               MinDate         =   -328716
               MaxDate         =   2958465
               BackColor       =   16777215
            End
            Begin VB.Label Label3 
               Caption         =   "Codigo Producto"
               BeginProperty Font 
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
               Left            =   3720
               TabIndex        =   12
               Top             =   165
               Width           =   1590
            End
            Begin VB.Label Label2 
               BackColor       =   &H00FFFFFF&
               BackStyle       =   0  'Transparent
               Caption         =   "Fecha"
               BeginProperty Font 
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
               Left            =   450
               TabIndex        =   11
               Top             =   495
               Width           =   1155
            End
            Begin VB.Label Label1 
               BackColor       =   &H00FFFFFF&
               BackStyle       =   0  'Transparent
               Caption         =   "Instrumento"
               BeginProperty Font 
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
               Left            =   75
               TabIndex        =   10
               Top             =   165
               Width           =   1530
            End
         End
         Begin Threed.SSFrame SSFrame3 
            Height          =   3885
            Left            =   45
            TabIndex        =   7
            Top             =   885
            Width           =   6705
            _Version        =   65536
            _ExtentX        =   11827
            _ExtentY        =   6853
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
            Begin MSFlexGridLib.MSFlexGrid Grilla2 
               Height          =   2610
               Left            =   180
               TabIndex        =   13
               Top             =   975
               Visible         =   0   'False
               Width           =   1185
               _ExtentX        =   2090
               _ExtentY        =   4604
               _Version        =   393216
            End
            Begin Threed.SSPanel SSProgreso 
               Height          =   1020
               Left            =   1500
               TabIndex        =   26
               Top             =   2595
               Visible         =   0   'False
               Width           =   4005
               _Version        =   65536
               _ExtentX        =   7064
               _ExtentY        =   1799
               _StockProps     =   15
               BackColor       =   11639171
               BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Begin Threed.SSFrame SSFrame5 
                  Height          =   945
                  Left            =   60
                  TabIndex        =   27
                  Top             =   15
                  Width           =   3870
                  _Version        =   65536
                  _ExtentX        =   6826
                  _ExtentY        =   1667
                  _StockProps     =   14
                  Caption         =   "Estado de Proceso"
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
                  Begin MSComctlLib.ProgressBar BarProgreso 
                     Height          =   510
                     Left            =   60
                     TabIndex        =   28
                     Top             =   285
                     Width           =   3765
                     _ExtentX        =   6641
                     _ExtentY        =   900
                     _Version        =   393216
                     Appearance      =   1
                  End
               End
            End
            Begin Threed.SSPanel SSProceso 
               Height          =   1770
               Left            =   1500
               TabIndex        =   14
               Top             =   840
               Width           =   4005
               _Version        =   65536
               _ExtentX        =   7064
               _ExtentY        =   3122
               _StockProps     =   15
               BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               BevelWidth      =   2
               BorderWidth     =   2
               Begin Threed.SSPanel SSPanel4 
                  Height          =   885
                  Left            =   45
                  TabIndex        =   18
                  Top             =   825
                  Width           =   3915
                  _Version        =   65536
                  _ExtentX        =   6906
                  _ExtentY        =   1561
                  _StockProps     =   15
                  BackColor       =   11639171
                  BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
                     Name            =   "MS Sans Serif"
                     Size            =   8.25
                     Charset         =   0
                     Weight          =   400
                     Underline       =   0   'False
                     Italic          =   0   'False
                     Strikethrough   =   0   'False
                  EndProperty
                  BevelOuter      =   1
                  Begin Threed.SSFrame SSFrame4 
                     Height          =   810
                     Left            =   30
                     TabIndex        =   19
                     Top             =   15
                     Width           =   3840
                     _Version        =   65536
                     _ExtentX        =   6773
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
                     Begin BacControles.txtFecha txtFechaHasta 
                        Height          =   315
                        Left            =   2190
                        TabIndex        =   23
                        Top             =   375
                        Width           =   1365
                        _ExtentX        =   2408
                        _ExtentY        =   556
                        Text            =   "09/05/2001"
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
                        MinDate         =   -328716
                        MaxDate         =   2958465
                     End
                     Begin BacControles.txtFecha txtFechaDesde 
                        Height          =   315
                        Left            =   180
                        TabIndex        =   22
                        Top             =   390
                        Width           =   1380
                        _ExtentX        =   2434
                        _ExtentY        =   556
                        Text            =   "09/05/2001"
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
                        MinDate         =   -328716
                        MaxDate         =   2958465
                     End
                     Begin VB.Label Label6 
                        Caption         =   "Fecha Hasta"
                        BeginProperty Font 
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
                        Left            =   2205
                        TabIndex        =   21
                        Top             =   135
                        Width           =   1215
                     End
                     Begin VB.Label Label5 
                        Caption         =   "Fecha Desde"
                        BeginProperty Font 
                           Name            =   "MS Sans Serif"
                           Size            =   8.25
                           Charset         =   0
                           Weight          =   700
                           Underline       =   0   'False
                           Italic          =   0   'False
                           Strikethrough   =   0   'False
                        EndProperty
                        ForeColor       =   &H00800000&
                        Height          =   345
                        Left            =   180
                        TabIndex        =   20
                        Top             =   150
                        Width           =   1380
                     End
                  End
               End
               Begin MSComctlLib.Toolbar Toolbar2 
                  Height          =   480
                  Left            =   60
                  TabIndex        =   17
                  Top             =   345
                  Width           =   3150
                  _ExtentX        =   5556
                  _ExtentY        =   847
                  ButtonWidth     =   767
                  ButtonHeight    =   741
                  ImageList       =   "ImageList1"
                  _Version        =   393216
                  BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
                     NumButtons      =   1
                     BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
                        Key             =   "Procesar"
                        ImageIndex      =   4
                     EndProperty
                  EndProperty
               End
               Begin Threed.SSPanel SSPanel3 
                  Height          =   300
                  Left            =   45
                  TabIndex        =   15
                  Top             =   45
                  Width           =   3915
                  _Version        =   65536
                  _ExtentX        =   6906
                  _ExtentY        =   529
                  _StockProps     =   15
                  BackColor       =   -2147483646
                  BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
                     Name            =   "MS Sans Serif"
                     Size            =   8.25
                     Charset         =   0
                     Weight          =   400
                     Underline       =   0   'False
                     Italic          =   0   'False
                     Strikethrough   =   0   'False
                  EndProperty
                  BevelOuter      =   0
                  Begin VB.CommandButton CmdCerrar 
                     Caption         =   "r"
                     BeginProperty Font 
                        Name            =   "Webdings"
                        Size            =   9
                        Charset         =   2
                        Weight          =   700
                        Underline       =   0   'False
                        Italic          =   0   'False
                        Strikethrough   =   0   'False
                     EndProperty
                     Height          =   270
                     Left            =   3645
                     TabIndex        =   24
                     Top             =   15
                     Width           =   270
                  End
                  Begin VB.Line Line1 
                     X1              =   3690
                     X2              =   3840
                     Y1              =   60
                     Y2              =   180
                  End
                  Begin VB.Label Label4 
                     BackStyle       =   0  'Transparent
                     Caption         =   "Generar Proceso por Rango de Fecha"
                     BeginProperty Font 
                        Name            =   "MS Sans Serif"
                        Size            =   8.25
                        Charset         =   0
                        Weight          =   700
                        Underline       =   0   'False
                        Italic          =   0   'False
                        Strikethrough   =   0   'False
                     EndProperty
                     ForeColor       =   &H00FFFFFF&
                     Height          =   270
                     Left            =   60
                     TabIndex        =   16
                     Top             =   45
                     Width           =   3930
                  End
               End
            End
            Begin MSFlexGridLib.MSFlexGrid Grilla3 
               Height          =   1365
               Left            =   900
               TabIndex        =   25
               Top             =   825
               Visible         =   0   'False
               Width           =   4830
               _ExtentX        =   8520
               _ExtentY        =   2408
               _Version        =   393216
            End
            Begin BacControles.txtNumero TxtValor 
               Height          =   315
               Left            =   4710
               TabIndex        =   9
               Top             =   2610
               Visible         =   0   'False
               Width           =   1905
               _ExtentX        =   3360
               _ExtentY        =   556
               BackColor       =   8388608
               BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   16777215
               Text            =   "0"
               CantidadDecimales=   "0"
            End
            Begin MSFlexGridLib.MSFlexGrid Grilla 
               Height          =   3735
               Left            =   30
               TabIndex        =   8
               Top             =   105
               Width           =   6645
               _ExtentX        =   11721
               _ExtentY        =   6588
               _Version        =   393216
               Cols            =   5
               FixedCols       =   0
               RowHeightMin    =   315
               BackColor       =   -2147483644
               ForeColor       =   8388608
               BackColorFixed  =   8421376
               ForeColorFixed  =   16777215
               BackColorSel    =   8388608
               ForeColorSel    =   16777215
               BackColorBkg    =   -2147483644
               GridColor       =   0
               FocusRect       =   0
               GridLines       =   2
               GridLinesFixed  =   0
            End
         End
      End
   End
End
Attribute VB_Name = "FlujoContableInstrumento"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim Datos()

Private Sub CmdSalir_Click()

End Sub

Private Sub CmdCerrar_Click()

   Control_Toolbar 1, 1, 1, 1, 1
   SSProceso.Visible = False
   SSProgreso.Visible = False
   Grilla.Enabled = True

End Sub

Private Sub Form_Load()

   Me.Top = 0
   Me.Left = 0
   Me.Icon = BacTrader.Icon
   txtFecha.Text = gsBac_Fecp
   Control_Toolbar 0, 0, 0, 0, 1
   SSProceso.Visible = False
   
   Call Carga_Grilla

End Sub

Private Sub Grilla_DblClick()

   TextoGrilla 13

End Sub

Private Sub Grilla_KeyPress(KeyAscii As Integer)

   TextoGrilla KeyAscii

End Sub

Private Sub Grilla_Scroll()

   TxtValor.Visible = False

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

   Select Case Button.Index
   
      Case 1
            If Grabar Then
            
               MsgBox "La Grabación fue realizada con Exito", vbInformation, TITSISTEMA
            
            Else
            
               MsgBox "No pudo completarse la Grabación", vbExclamation, TITSISTEMA
            
            End If
            
            Grilla.SetFocus
   
      Case 2
            
            Grilla.Redraw = False
            Call BUSCA
            Grilla.Redraw = True
            Control_Toolbar 1, 1, 1, 1, 1
   
      Case 3
            Call Limpiar
   
      Case 4
            txtFechaDesde.Text = gsBac_Fecp
            txtFechaHasta.Text = gsBac_Fecp
            Grilla.Enabled = False
            SSProceso.Visible = True
            SSProgreso.Visible = True
            Control_Toolbar 0, 0, 0, 0, 1
   
      Case 5
            Unload Me
   
   End Select

End Sub

Private Sub Toolbar2_ButtonClick(ByVal Button As MSComctlLib.Button)
Dim I As Integer

   Select Case Button.Index
   
      Case 1
      
            BarProgreso.Min = 0
            BarProgreso.Max = 100
            txtFechaDesde.Enabled = False
            txtFechaHasta.Enabled = False
            
            If GenerarProceso Then
            
               Grilla.Redraw = False
               BarProgreso.Value = 90
               BUSCA
               BarProgreso.Value = 100
               MsgBox "Proceso Completado con Exito", vbInformation, TITSISTEMA
               
               Grilla.Redraw = True
               Grilla.Enabled = False
            
            End If
   
            BarProgreso.Value = 100
            txtFechaDesde.Enabled = True
            txtFechaHasta.Enabled = True
   
   
   End Select
   
End Sub

Private Sub TxtInstrumento_DblClick()

   Me.Tag = ""
   BacAyuda.Tag = "INSTRU2"
   BacAyuda.Show 1
   
   If giAceptar = True Then
   
      TxtInstrumento.Text = gsrut$  ' + "-" + ltDigito
      TxtInstrumento.Tag = gscodigo

   End If

   If TxtInstrumento.Text <> "" And TxtMoneda.Text <> "" Then
   
      Control_Toolbar 0, 1, 1, 0, 1
   
   End If

End Sub

Sub Control_Toolbar(B1, B2, B3, B4, B5 As Integer)

   With Toolbar1

      .Buttons(1).Enabled = IIf(B1 = 0, False, True)
      .Buttons(2).Enabled = IIf(B2 = 0, False, True)
      .Buttons(3).Enabled = IIf(B3 = 0, False, True)
      .Buttons(4).Enabled = IIf(B4 = 0, False, True)
      .Buttons(5).Enabled = IIf(B5 = 0, False, True)

   End With

End Sub

Sub Carga_Grilla()

   With Grilla
   
      .Cols = 7
      .Rows = 1
      .Row = 0
      .Col = 1
      .CellFontBold = True
      .Col = 2
      .CellFontBold = True
      .Col = 3
      .CellFontBold = True
      .Col = 4
      .CellFontBold = True
      .Col = 5
      .CellFontBold = True
      .Col = 6
      .CellFontBold = True
      .TextMatrix(0, 1) = "Fecha"
      .TextMatrix(0, 2) = "Monto"
      .TextMatrix(0, 3) = "Tasa"
      .TextMatrix(0, 4) = "Fecha"
      .TextMatrix(0, 5) = "Monto"
      .TextMatrix(0, 6) = "Tasa"
      .ColWidth(0) = 0
      .ColWidth(1) = 1100
      .ColWidth(2) = 1800
      .ColWidth(3) = 1800
      .ColWidth(4) = 1100
      .ColWidth(5) = 1800
      .ColWidth(6) = 1800
      
      .Enabled = False
      .Col = 0
          
   End With
      
End Sub

Sub BUSCA()
   
   Dim I, J        As Integer
   Dim Cdias       As String
   Dim Fila        As Integer
   Dim Fecha       As Date
   Dim iblano      As String
   Dim Dia         As String
   Dim Datos()
   Dim X           As Integer
    
      Toolbar1.Buttons(1).Enabled = True
      Cdias = Mid(txtFecha.Text, 4, 2)
      iblano = Mid(txtFecha.Text, 7, 4)
      Fila = 1
       
      With Grilla
           
         .Rows = 1
         .Col = 0
         .Row = 0
         J = 0
         Cdias = IIf(Len(Trim(Str(Cdias))) < 2, "0" + Trim(Str(Cdias)), Str(I))
         
         For I = 1 To Int(DiasDelMes(Val(Cdias), Val(iblano))) / 2 + 1
          
            Dia = IIf(Len(Trim(Str(I))) < 2, "0" + Trim(Str(I)), Str(I))
            .Rows = .Rows + 1
            .TextMatrix(.Rows - 1, 1) = Trim(Dia + "/" + Cdias + "/" + Trim(Str(iblano)))
            .TextMatrix(.Rows - 1, 2) = 0
            .TextMatrix(.Rows - 1, 3) = Format(0, FDecimal)
            .RowHeight(.Rows - 1) = 270
            J = J + 1
            
         Next I
           
         For I = I To DiasDelMes(Val(Cdias), Val(iblano))
            
            Dia = IIf(Len(Trim(Str(I))) < 2, "0" + Trim(Str(I)), Str(I))
            .TextMatrix(Fila, 4) = Trim(Dia + "/" + Cdias + "/" + Trim(Str(iblano)))
            .TextMatrix(Fila, 5) = 0
            .TextMatrix(Fila, 6) = Format(0, FDecimal)
            Fila = Fila + 1
            .RowHeight(.Rows - 1) = 320
            J = J + 1
         
         Next I
           
         .Enabled = True
       
         TxtInstrumento.Enabled = False
         txtFecha.Enabled = False
         TxtMoneda.Enabled = False
       
     
         Envia = Array()
         AddParam Envia, TxtInstrumento.Tag
         AddParam Envia, txtFecha.Text
         AddParam Envia, TxtMoneda.Tag
         
            If Bac_Sql_Execute("Sp_FlujoInterbancario_BuscaInstrumento", Envia) Then
         
            While Bac_SQL_Fetch(Datos)
         
               If Datos(1) = "NO EXISTE" Then Exit Sub
               
               X = 0
               
               For I = 1 To .Rows - 1
               
                  X = X + 1
                  .TextMatrix(I, 2) = Format(Datos(X), "###,##0")
         
               Next I
               
               For I = 1 To .Rows - 1
                  
                  X = X + 1
               
                  If .TextMatrix(I, 4) = "" Then Exit For
               
                  .TextMatrix(I, 5) = Format(Datos(X), "###,##0")
               
               Next I
               
               X = 31
               
               For I = 1 To .Rows - 1
               
                  X = X + 1
                  .TextMatrix(I, 3) = Format(Datos(X), FDecimal)
         
               Next I
               
               For I = 1 To .Rows - 1
                  
                  X = X + 1
               
                  If .TextMatrix(I, 6) = "" Then Exit For
               
                  .TextMatrix(I, 6) = Format(Datos(X), FDecimal)
               
               Next I
            
            Wend
      
         End If
            
      End With

End Sub


Private Function DiasDelMes(Mes As Integer, Ann As Integer) As Integer

Dim Dias    As String
Dim Residuo As Currency

On Error GoTo Label1

    Dias = "312831303130313130313031"
    
    If Mes = 2 Then
        
        Residuo = Ann Mod 4
        
        If Residuo = 0 Then
            
            DiasDelMes = 29
        
        Else
            
            DiasDelMes = 28
        
        End If
    
    Else
        
        DiasDelMes = Val(Mid$(Dias, ((Mes * 2) - 1), 2))
    
    End If
    
    Exit Function

Label1:
End Function


Sub Limpiar()

   TxtInstrumento.Text = ""
   TxtInstrumento.Enabled = True
   txtFecha.Enabled = True
   txtFecha.Text = gsBac_Fecp
   Control_Toolbar 0, 0, 0, 0, 1
   Grilla.Rows = 1
   Grilla.Col = 0
   Grilla.Enabled = False
   TxtMoneda.Enabled = True
   TxtMoneda.Text = ""
         
End Sub

Sub PosTexto(Control, Grid As Control)
On Error Resume Next

   Control.Left = Grid.CellLeft + 50
   Control.Top = Grid.CellTop + 120
   Control.Width = Grid.CellWidth
   Control.Height = Grid.CellHeight
   Control.Visible = True
   Control.SetFocus

End Sub


Sub TextoGrilla(key As Integer)

   With Grilla
   
      Select Case .Col

         Case 2, 5
      
               If .TextMatrix(.Row, .Col - 1) <> "" Then
               
                  TxtValor.CantidadDecimales = 0
                  TxtValor.Max = 1000000000000#
                  TxtValor.Min = 0
               
                  Select Case key
                  
                     Case 13
                           TxtValor.Text = BacCtrlTransMonto(Grilla.Text)
                           PosTexto TxtValor, Grilla
                     
                  End Select
               
                  If IsNumeric(Chr(key)) Then
                  
                        TxtValor.Text = Chr(key)
                        PosTexto TxtValor, Grilla
                  
                  End If
               
               End If

         Case 3, 6
      
               If .TextMatrix(.Row, .Col - 1) <> "" Then
                              
                  TxtValor.CantidadDecimales = 4
                  TxtValor.Max = 9999.9999
               
                  Select Case key
                  
                     Case 13
                           TxtValor.Text = BacCtrlTransMonto(Grilla.Text)
                           PosTexto TxtValor, Grilla
                     
                  End Select
               
                  If IsNumeric(Chr(key)) Then
                  
                        TxtValor.Text = Chr(key)
                        PosTexto TxtValor, Grilla
                  
                  End If
               
               End If


      End Select
      
   End With

End Sub

Private Sub TxtMoneda_DblClick()
   
   Me.Tag = ""
   BacAyuda.Tag = "MDMN"
   BacAyuda.Show 1
   
   If giAceptar = True Then
   
      TxtMoneda.Text = gsSerie    ' + "-" + ltDigito
      TxtMoneda.Tag = gscodigo$

   End If

   If TxtInstrumento.Text <> "" And TxtMoneda.Text <> "" Then
   
      Control_Toolbar 0, 1, 1, 0, 1
   
   End If

End Sub

Private Sub TxtValor_KeyPress(KeyAscii As Integer)
   
   Select Case KeyAscii
   
      Case 13
            
         Select Case Grilla.Col
         
            Case 2, 5
                  Grilla.Text = Format(TxtValor.Text, "###,##0")
                  TxtValor.Visible = False
            
            Case 3, 6
                  Grilla.Text = Format(TxtValor.Text, FDecimal)
                  TxtValor.Visible = False
      
         End Select
      
      Case 27
            TxtValor.Visible = False
   
   End Select

End Sub

Private Sub TxtValor_LostFocus()

   TxtValor.Visible = False

End Sub

Function Grabar() As Boolean
Dim I As Integer
   
   Grabar = False
   
   With Grilla
   
         Envia = Array()
         AddParam Envia, CDbl(TxtInstrumento.Tag)
         AddParam Envia, CDbl(TxtMoneda.Tag)
         AddParam Envia, txtFecha.Text
         AddParam Envia, "" ''''''' VERIFICAR
               
         For I = 1 To .Rows - 1
         
            AddParam Envia, CDbl(.TextMatrix(I, 2))
         
         Next I
      
         For I = 1 To .Rows - 1
         
            If .TextMatrix(I, 4) <> "" Then
                  
               AddParam Envia, CDbl(.TextMatrix(I, 5))
            
            End If
         
         Next I
         
         Grabar = Bac_Sql_Execute("Sp_FlujoContableInerbancario_GrabaMonto", Envia)
         
         If Not Grabar Then Exit Function
         
         Envia = Array()
         AddParam Envia, CDbl(TxtInstrumento.Tag)
         AddParam Envia, CDbl(TxtMoneda.Tag)
         AddParam Envia, txtFecha.Text
         AddParam Envia, "" ''''''' VERIFICAR
         
         For I = 1 To .Rows - 1
         
            AddParam Envia, CDbl(.TextMatrix(I, 3))
         
         Next I
      
         For I = 1 To .Rows - 1
         
            If .TextMatrix(I, 4) <> "" Then
                  
               AddParam Envia, CDbl(.TextMatrix(I, 6))
            
            End If
         
         Next I
         
         Grabar = Bac_Sql_Execute("Sp_FlujoContableInerbancario_GrabaTasa", Envia)
         
         If Not Grabar Then Exit Function

   End With

End Function



Function GenerarProceso() As Boolean
Dim I, X, X2  As Integer
Dim Sw        As Integer
Dim Monto     As Double
Dim Domingo   As Integer
Dim LastDay   As Integer
Dim J         As Integer

   Envia = Array()
   AddParam Envia, txtFechaDesde.Text
   AddParam Envia, txtFechaHasta.Text
   
   If Not Bac_Sql_Execute("Sp_FlujoInterbancarios_ClientesProceso", Envia) Then
   
      Exit Function
   
   End If

   With Grilla3

      .Cols = 5
      .Rows = 1
      .Clear
   
      While Bac_SQL_Fetch(Datos())
   
         .TextMatrix(.Rows - 1, 1) = Datos(1)
         .TextMatrix(.Rows - 1, 2) = Datos(2)
         .TextMatrix(.Rows - 1, 3) = Datos(3)
         .TextMatrix(.Rows - 1, 4) = Datos(4)
         .Rows = .Rows + 1
   
      Wend

   End With
   
   BarProgreso.Value = 5
   
   For X = 0 To Grilla3.Rows - 2

      For X2 = 2 To 3
          
         Envia = Array()
         AddParam Envia, CDbl(Grilla3.TextMatrix(X, 1))
         AddParam Envia, Grilla3.TextMatrix(X, 4)
         AddParam Envia, Grilla3.TextMatrix(X, X2)
         AddParam Envia, txtFechaDesde.Text
         AddParam Envia, txtFechaHasta.Text
         
         GenerarProceso = False
         
         If Not Bac_Sql_Execute("Sp_FlujoInterbancarios_Proceso", Envia) Then
         
            GenerarProceso = True
            Exit Function
         
         End If
      
         I = 1
         
         With Grilla2
            .Clear
            .Rows = 1
            .Cols = 3
            
            While Bac_SQL_Fetch(Datos())
               
               If .Rows > 1 Then
               
                  If .TextMatrix(.Rows - 2, 1) = Datos(1) Then
               
                     .TextMatrix(.Rows - 2, 2) = CDbl(.TextMatrix(.Rows - 2, 2)) + CDbl(Datos(2))
                     .TextMatrix(.Rows - 2, 0) = Datos(3)
                              
                     If Datos(3) = .TextMatrix(.Rows - 2, 1) Then
                     
                        .TextMatrix(.Rows - 3, 2) = .TextMatrix(.Rows - 2, 2)
                     
                     End If
      
                  Else
                  
                     If Datos(1) = Datos(3) Then
                     
                        .TextMatrix(.Rows - 1, 1) = Trim(Right(Str(Val(Datos(1)) - 1), 2) + "/" + Mid(Datos(1), 4, 2) + "/" + Right(Datos(1), 4))
                        .TextMatrix(.Rows - 1, 2) = Datos(2)
                        .TextMatrix(.Rows - 1, 0) = Datos(3)
                        .Rows = .Rows + 1
                     
                     End If
                     
                     .TextMatrix(.Rows - 1, 1) = Datos(1)
                     .TextMatrix(.Rows - 1, 2) = Datos(2)
                     .TextMatrix(.Rows - 1, 0) = Datos(3)
                     .Rows = .Rows + 1
               
                  End If
               
               Else
               
                  .TextMatrix(.Rows - 1, 1) = Datos(1)
                  .TextMatrix(.Rows - 1, 2) = Datos(2)
                  .TextMatrix(.Rows - 1, 0) = Datos(3)
                  .Rows = .Rows + 1
               
               End If
               
            Wend
            
            .Rows = .Rows - 1
            
            Monto = 0
            Sw = 0
            Domingo = 0
            LastDay = 0
            
            BarProgreso.Value = 20
            
            For I = 0 To .Rows - 1
               
               If Feriado(Right(.TextMatrix(I, 1), 4), Mid(.TextMatrix(I, 1), 4, 2), Str(Val(Left(.TextMatrix(I, 1), 2)) + 1)) And _
                  Feriado(Right(.TextMatrix(I, 1), 4), Mid(.TextMatrix(I, 1), 4, 2), Str(Val(Left(.TextMatrix(I, 1), 2)) + 2)) Then
               
                  For J = Val(Left(.TextMatrix(I, 1), 2)) To Val(Left(.TextMatrix(I, 1), 2)) + 2
               
                     Envia = Array()
                     AddParam Envia, CDbl(Grilla3.TextMatrix(X, 1))
                     AddParam Envia, CDbl(Grilla3.TextMatrix(X, 4))
                     AddParam Envia, Trim(Str(J) + "/" + Mid(.TextMatrix(I, 1), 4, 2) + "/" + Right(.TextMatrix(I, 1), 4))
                     AddParam Envia, Grilla3.TextMatrix(X, X2)
                     AddParam Envia, CDbl(.TextMatrix(I, 2))
                     
                     If Not Bac_Sql_Execute("Sp_FlujoInterbancario_GrabaProceso", Envia) Then
                     
                        Exit Function
                     
                     End If
               
                  Next J
               
               Else
               
                  If Feriado(Right(.TextMatrix(I, 1), 4), Mid(.TextMatrix(I, 1), 4, 2), Str(Val(Left(.TextMatrix(I, 1), 2)) + 1)) Then
                  
                     For J = Val(Left(.TextMatrix(I, 1), 2)) To Val(Left(.TextMatrix(I, 1), 2)) + 2
                  
                        Envia = Array()
                        AddParam Envia, CDbl(Grilla3.TextMatrix(X, 1))
                        AddParam Envia, CDbl(Grilla3.TextMatrix(X, 4))
                        AddParam Envia, Trim(Str(J) + "/" + Mid(.TextMatrix(I, 1), 4, 2) + "/" + Right(.TextMatrix(I, 1), 4))
                        AddParam Envia, Grilla3.TextMatrix(X, X2)
                        AddParam Envia, CDbl(.TextMatrix(I, 2))
                        
                        If Not Bac_Sql_Execute("Sp_FlujoInterbancario_GrabaProceso", Envia) Then
                        
                           Exit Function
                        
                        End If
                  
                     Next J
                  
                  Else
               
                     Envia = Array()
                     AddParam Envia, CDbl(Grilla3.TextMatrix(X, 1))
                     AddParam Envia, CDbl(Grilla3.TextMatrix(X, 4))
                     AddParam Envia, .TextMatrix(I, 1)
                     AddParam Envia, Grilla3.TextMatrix(X, X2)
                     
                     If .TextMatrix(I, 1) = .TextMatrix(I, 0) Then
                     
                        AddParam Envia, .TextMatrix(I - 1, 2)
                     
                     Else
                     
                        AddParam Envia, IIf(Sw > 0, Monto, CDbl(.TextMatrix(I, 2)))
                     
                     End If
                  
                     If Not Bac_Sql_Execute("Sp_FlujoInterbancario_GrabaProceso", Envia) Then
                     
                        Exit Function
                     
                     End If
               
                  End If
               
               End If
         
         
            Next I
            
         End With
         
         GenerarProceso = True
   
      Next X2
   
   Next X
   
   BarProgreso.Value = 80
   
End Function


Function Feriado(xYear, xMes, xDia As String) As Boolean
Dim I As Integer

   Envia = Array()
   AddParam Envia, xYear
   Feriado = Bac_Sql_Execute("Sp_Devuelve_Feriado", Envia)
   
   If Not Feriado Then Exit Function
   
   If Bac_SQL_Fetch(Datos()) Then
      
         For I = 1 To Len(Datos(Val(xMes))) Step 3
         
            If Val(Mid(Datos(Val(xMes)), I, 2)) = Val(xDia) Then
         
                Feriado = True
                Exit Function
         
            End If
         
         Next I

   End If

   Feriado = False
   
End Function




