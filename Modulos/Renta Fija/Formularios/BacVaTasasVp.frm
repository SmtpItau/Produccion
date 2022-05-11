VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form BacVaTasasVp 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Valorización de Tasas"
   ClientHeight    =   2835
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   5985
   LinkTopic       =   "Form2"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2835
   ScaleWidth      =   5985
   StartUpPosition =   2  'CenterScreen
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   5985
      _ExtentX        =   10557
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   1
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   1
         EndProperty
      EndProperty
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   3450
         Top             =   -45
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   22
         ImageHeight     =   22
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   1
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacVaTasasVp.frx":0000
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin Threed.SSPanel SSPanel1 
      Height          =   2400
      Left            =   0
      TabIndex        =   1
      Top             =   465
      Width           =   5955
      _Version        =   65536
      _ExtentX        =   10504
      _ExtentY        =   4233
      _StockProps     =   15
      BackColor       =   12632256
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
         Height          =   2220
         Left            =   105
         TabIndex        =   2
         Top             =   60
         Width           =   5730
         _Version        =   65536
         _ExtentX        =   10107
         _ExtentY        =   3916
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
         Begin MSFlexGridLib.MSFlexGrid Grilla 
            Height          =   2085
            Left            =   30
            TabIndex        =   3
            Top             =   105
            Width           =   5655
            _ExtentX        =   9975
            _ExtentY        =   3678
            _Version        =   393216
            Rows            =   8
            Cols            =   3
            FixedCols       =   0
            BackColor       =   -2147483644
            ForeColor       =   8388608
            BackColorFixed  =   8421376
            ForeColorFixed  =   16777215
            BackColorSel    =   8388608
            ForeColorSel    =   16777215
            BackColorBkg    =   -2147483644
            FocusRect       =   0
            GridLines       =   2
            GridLinesFixed  =   0
            SelectionMode   =   1
         End
      End
   End
End
Attribute VB_Name = "BacVaTasasVp"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim objBacVaTasasVp As Object

Private Sub Form_Load()
   
   Me.Icon = BacTrader.Icon
   
   Call Carga_Grilla
   Call Calculo

End Sub

Private Sub Form_Unload(Cancel As Integer)

   Set objBacVaTasasVp = Nothing
   RangoTir = 0.01

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   
   Select Case Button.Index
   
      Case 1:
               Unload Me
   
   End Select
   
End Sub

Sub Carga_Grilla()
Dim i As Integer

   With grilla
   
      .Cols = 5
      .Rows = 8
      .ColWidth(0) = 0
      .ColWidth(1) = 1000
      .ColWidth(2) = 3000
      .ColWidth(3) = 0
      .ColWidth(4) = 1500
            
      .TextMatrix(0, 1) = "%Tir"
      .TextMatrix(0, 2) = "Valor Valorización"
      .TextMatrix(0, 4) = "Diferencia"
      
      For i = 0 To 4
      
         .Row = 4
         .Col = i
         .CellBackColor = &H808000
         .CellForeColor = &HFFFFFF
      
      Next i
      
      .TextMatrix(4, 1) = Format(tir, FDecimal)
      .TextMatrix(4, 2) = Format(ValorTir, FDecimal)
      .TextMatrix(4, 4) = Format(0, FDecimal)
      .Col = 0
            
   End With

End Sub

Sub Calculo()

    RangoTir = 0.01
    With grilla
   
        For i = 3 To 1 Step -1
            .TextMatrix(i, 1) = Format(.TextMatrix(i + 1, 1) - RangoTir, FDecimal)
            .TextMatrix(i, 3) = Format(.TextMatrix(i, 1) - .TextMatrix(4, 1), FDecimal)
            .TextMatrix(i, 2) = Format(Round(.TextMatrix(4, 2) * (1 + (Durmodori * -1) * .TextMatrix(i, 3)), 0), FDecimal)
            .TextMatrix(i, 4) = Format(.TextMatrix(4, 2) - .TextMatrix(i, 2), FDecimal)
        Next i
      
        For i = 5 To .Rows - 1
            .TextMatrix(i, 1) = Format(.TextMatrix(i - 1, 1) + RangoTir, FDecimal)
            .TextMatrix(i, 3) = Format(.TextMatrix(i, 1) - .TextMatrix(4, 1), FDecimal)
            .TextMatrix(i, 2) = Format(Round(.TextMatrix(4, 2) * (1 + (Durmodori * -1) * .TextMatrix(i, 3)), 0), FDecimal)
            .TextMatrix(i, 4) = Format(.TextMatrix(4, 2) - .TextMatrix(i, 2), FDecimal)
        Next i

    End With

End Sub
