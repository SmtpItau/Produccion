VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form BacHisContr 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "ReImpresión Historica de Contrato.-"
   ClientHeight    =   2895
   ClientLeft      =   1245
   ClientTop       =   8790
   ClientWidth     =   10260
   ForeColor       =   &H00C0C0C0&
   Icon            =   "Bachcont.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   Moveable        =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   2895
   ScaleWidth      =   10260
   Begin MSFlexGridLib.MSFlexGrid Grd 
      Height          =   1815
      Left            =   120
      TabIndex        =   4
      Top             =   960
      Width           =   10050
      _ExtentX        =   17727
      _ExtentY        =   3201
      _Version        =   393216
      FixedCols       =   0
      BackColor       =   14737632
      BackColorFixed  =   12632256
   End
   Begin VB.ComboBox cmbopcion 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   315
      Left            =   1725
      Style           =   2  'Dropdown List
      TabIndex        =   2
      Top             =   600
      Width           =   1770
   End
   Begin Threed.SSCommand cmdsalir 
      Height          =   450
      Left            =   1545
      TabIndex        =   1
      Top             =   4350
      Width           =   1200
      _Version        =   65536
      _ExtentX        =   2117
      _ExtentY        =   794
      _StockProps     =   78
      Caption         =   "&Salir"
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
   Begin Threed.SSCommand cmdimprimir 
      Height          =   450
      Left            =   345
      TabIndex        =   0
      Top             =   4350
      Width           =   1200
      _Version        =   65536
      _ExtentX        =   2117
      _ExtentY        =   794
      _StockProps     =   78
      Caption         =   "&Imprimir"
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
   Begin MSComctlLib.Toolbar Toolbar1 
      Height          =   510
      Left            =   0
      TabIndex        =   5
      Top             =   0
      Width           =   10260
      _ExtentX        =   18098
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
            Object.Visible         =   0   'False
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdImprimir"
            Description     =   "Imprimir"
            Object.ToolTipText     =   "Imprimir Contrato"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdSalir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   0
      Top             =   0
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
            Picture         =   "Bachcont.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bachcont.frx":0624
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin VB.Label Label1 
      Caption         =   "Ver ordenado por:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   105
      TabIndex        =   3
      Top             =   660
      Width           =   1590
   End
End
Attribute VB_Name = "BacHisContr"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim dFecProcesar        As Date
Dim cTipOper            As String * 3
Dim Sql                 As String
Dim datos()

Private Sub BacCargaGrilla(nOpcion As Long)
Dim cOpcion          As String

    Screen.MousePointer = 11

    cOpcion = Mid$("NTC", nOpcion + 1, 1)

'    Sql = "SP_QUERYHISPAPEL '" & cOpcion & "',"
'    Sql = Sql & "'" & Format(dFecProcesar, "mm/dd/yyyy") & "',"
'    Sql = Sql & "'" & cTipOper & "',1"
    Envia = Array(cOpcion, _
            Format(dFecProcesar, "mm/dd/yyyy"), _
            cTipOper)

    If Not Bac_Sql_Execute("SP_QUERYHISPAPEL", Envia) Then
        Screen.MousePointer = 0
        MsgBox "Servidor Sql-Server No Responde", 64
        Exit Sub
    End If

    With Grd
        .Rows = 1
        .Row = 0

        Do While Bac_SQL_Fetch(datos())
            If UBound(datos()) = 2 Then
                If datos(1) = "NO" Then
                MsgBox CStr(datos(2)), 64
                End If
            Else
                .Rows = .Rows + 1
                .Row = .Rows - 1
                .Col = 1: .Text = Val(datos(1))
                .Col = 2: .Text = datos(2)
                .Col = 3: .Text = Val(datos(3))
                .Col = 4: .Text = datos(4)
                .Col = 5: .Text = Val(datos(5))
                .Col = 6: .Text = datos(6)
                .Col = 7: .Text = datos(7)
                .Col = 8: .Text = datos(9)
            End If
        Loop

    End With

    Screen.MousePointer = 0

End Sub

Private Sub cmbopcion_Click()

   If cmbopcion.ListIndex <> -1 Then
      Call BacCargaGrilla(cmbopcion.ListIndex)

   End If

End Sub

Private Sub Func_Imprimir()

   Dim RutCartera       As String
   Dim NumOper          As String
   Dim cTipOper         As String

   Screen.MousePointer = 11
   gsTipoPapeleta = "C"
   Grd.Row = 1

   If Grd.Rows <= 2 And Grd.Text = "" Then
      Screen.MousePointer = 0
      MsgBox "No ha seleccionado elemento", 32
      Exit Sub

   End If

   If Validar_Papeletas_Historicas(Str(NumOper), "C") = False Then
      Screen.MousePointer = 0
      MsgBox "Operación sin cupo Disponible para Imprimir Contrato", 16
      Exit Sub

   End If

End Sub

Sub Nombres()

   With Grd
      .Cols = 6:   .Rows = 2
      .Row = 0: .Col = 0: .Text = "Numero Operación"
      .Row = 0: .Col = 1: .Text = "Tipo Operación"
      .Row = 0: .Col = 2: .Text = "Nombre Cliente"
      .Row = 0: .Col = 3: .Text = "Total Operación"
      .Row = 0: .Col = 4: .Text = "Hora Trans."
      .Row = 0: .Col = 5: .Text = "Usuario"
      .RowHeight(0) = 350
      .ColWidth(0) = 1500
      .ColWidth(1) = 1300
      .ColWidth(2) = 2000
      .ColWidth(3) = 1300
      .ColWidth(4) = 1000
      .ColWidth(5) = 1600
      .BackColorFixed = &H808000
      .ForeColorFixed = &HFFFFFF

   End With

End Sub

Private Sub Form_Load()

   Me.Left = 0
   Me.Top = 0

   Call Nombres

   cmbopcion.AddItem "Operación"
   cmbopcion.AddItem "Tipo"
   cmbopcion.AddItem "Cliente"
   cmbopcion.ListIndex = 0

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

   Select Case UCase(Button.Description)
   Case "IMPRIMIR"
      Call Func_Imprimir

   Case "SALIR"
      Unload Me

   End Select

End Sub
