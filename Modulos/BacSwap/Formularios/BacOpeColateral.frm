VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "Msflxgrd.ocx"
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.3#0"; "COMCTL32.OCX"
Begin VB.Form BacOpeColateral 
   Appearance      =   0  'Flat
   BackColor       =   &H80000004&
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Mantención de Operaciones"
   ClientHeight    =   5715
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   15135
   BeginProperty Font 
      Name            =   "Times New Roman"
      Size            =   8.25
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   Icon            =   "BacOpeColateral.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   5715
   ScaleWidth      =   15135
   ShowInTaskbar   =   0   'False
   Begin ComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   3
      Top             =   0
      Width           =   15135
      _ExtentX        =   26696
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   327682
      BeginProperty Buttons {0713E452-850A-101B-AFC0-4210102A8DA7} 
         NumButtons      =   3
         BeginProperty Button1 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Caption         =   ""
            Key             =   ""
            Description     =   ""
            Object.ToolTipText     =   "Filtrar"
            Object.Tag             =   ""
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Caption         =   ""
            Key             =   ""
            Description     =   ""
            Object.ToolTipText     =   "Coletarilizar"
            Object.Tag             =   ""
            ImageIndex      =   3
         EndProperty
         BeginProperty Button3 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Key             =   ""
            Object.ToolTipText     =   "Salir"
            Object.Tag             =   ""
            ImageIndex      =   6
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin VB.Frame Frame1 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   5220
      Index           =   0
      Left            =   15
      TabIndex        =   0
      Top             =   450
      Width           =   14925
      Begin MSFlexGridLib.MSFlexGrid grdConsulta 
         Height          =   4650
         Left            =   0
         TabIndex        =   1
         Top             =   495
         Width           =   14820
         _ExtentX        =   26141
         _ExtentY        =   8202
         _Version        =   393216
         Rows            =   15
         FixedCols       =   0
         BackColor       =   12632256
         BackColorFixed  =   8421440
         ForeColorFixed  =   16777215
         BackColorSel    =   8388608
         ForeColorSel    =   16777215
         GridColor       =   16777215
         FocusRect       =   0
         GridLines       =   2
         GridLinesFixed  =   0
      End
      Begin VB.Label Label1 
         Alignment       =   2  'Center
         BackColor       =   &H00800000&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "Operaciones Colaterales"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   11.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H0000FFFF&
         Height          =   345
         Left            =   60
         TabIndex        =   2
         Top             =   135
         Width           =   14685
      End
   End
   Begin ComctlLib.ImageList ImageList1 
      Left            =   9390
      Top             =   210
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   327682
      BeginProperty Images {0713E8C2-850A-101B-AFC0-4210102A8DA7} 
         NumListImages   =   8
         BeginProperty ListImage1 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "BacOpeColateral.frx":0442
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "BacOpeColateral.frx":075C
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "BacOpeColateral.frx":0A76
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "BacOpeColateral.frx":0D90
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "BacOpeColateral.frx":10AA
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "BacOpeColateral.frx":13C4
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "BacOpeColateral.frx":16DE
            Key             =   ""
         EndProperty
         BeginProperty ListImage8 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "BacOpeColateral.frx":1EF8
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "BacOpeColateral"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim NoEntrar   As Boolean
Dim FilaAnt    As Integer
Dim ColAct     As Integer

Function InicializaGrilla()
   Dim i As Integer

   grdConsulta.Cols = 9
   grdConsulta.Rows = 2
        
   grdConsulta.RowHeight(0) = 500
   grdConsulta.TextMatrix(0, 0) = "Tipo Producto"
   grdConsulta.TextMatrix(0, 1) = "N° Operación"
   grdConsulta.TextMatrix(0, 2) = "Tip.Operación"
   grdConsulta.TextMatrix(0, 3) = "Cliente"
   grdConsulta.TextMatrix(0, 4) = "Fecha Inicio"
   grdConsulta.TextMatrix(0, 5) = "Fecha Venc."
   grdConsulta.TextMatrix(0, 6) = "Moneda Operación"
   grdConsulta.TextMatrix(0, 7) = "Monto Operación"
   grdConsulta.TextMatrix(0, 8) = "Colateral"
   
   grdConsulta.ColWidth(0) = 1200
   grdConsulta.ColWidth(1) = 1200
   grdConsulta.ColWidth(2) = 1200
   grdConsulta.ColWidth(3) = 3500
   grdConsulta.ColWidth(4) = 1000
   grdConsulta.ColWidth(5) = 1000
   grdConsulta.ColWidth(6) = 2500
   grdConsulta.ColWidth(7) = 1500
   grdConsulta.ColWidth(8) = 1000
  
   grdConsulta.Row = 0
   
   For i = 0 To grdConsulta.Cols - 1
      grdConsulta.Col = i
      grdConsulta.CellAlignment = 4
   Next i
   grdConsulta.Tag = "NO"  'Grilla no tiene datos
End Function

Private Sub btnFiltrar_Click()
   Call BacFiltrarConsulta.Show
End Sub

Private Sub btnModificar_Click()
   Dim nOperacion As Long
   Dim cColateral As String
   Dim nCont      As Integer
   
   On Error GoTo ErrorModif
   
   Me.MousePointer = vbHourglass

   With grdConsulta
         For nCont = 1 To grdConsulta.Rows - 1
            grdConsulta.Row = grdConsulta.Row
            nOperacion = grdConsulta.TextMatrix(nCont, 1)
            cColateral = grdConsulta.TextMatrix(nCont, 8)
            Call Marcar_Ope_Colateral(nOperacion, cColateral)
         Next nCont
  End With
  
  Me.MousePointer = vbDefault
  MsgBox "Actualizacion Colateral OK." & vbCrLf & BACSwap.Crystal.LastErrorString, vbOKOnly, TITSISTEMA
  Exit Sub
  
ErrorModif:
    Me.MousePointer = vbDefault
    MsgBox "Problemas al actualizar Colateral." & vbCrLf & BACSwap.Crystal.LastErrorString, vbExclamation, TITSISTEMA
    Exit Sub
End Sub

Private Sub btnSalir_Click()
    Unload Me
End Sub
Function EstadoToolBar(estado)
   Toolbar1.Buttons.Item(2).Enabled = estado
   Toolbar1.Buttons.Item(3).Enabled = estado
   Toolbar1.Buttons.Item(4).Enabled = estado
   Toolbar1.Buttons.Item(5).Enabled = estado
End Function

Function EstadoBtns()
   Select Case swModTipoOpe 'TipoOperacion
      Case 0
         Call EstadoBtn(False)
      Case 1
         Call EstadoBtn(True)
      Case 2
         Toolbar1.Buttons.Item(2).Enabled = False
         Toolbar1.Buttons.Item(3).Enabled = False
         Toolbar1.Buttons.Item(5).Enabled = False
      Case 3
         Toolbar1.Buttons.Item(2).Enabled = False
         Toolbar1.Buttons.Item(3).Enabled = True
         Toolbar1.Buttons.Item(5).Enabled = True
      Case 4
         Toolbar1.Buttons.Item(2).Enabled = False
         Toolbar1.Buttons.Item(3).Enabled = False
         Toolbar1.Buttons.Item(5).Enabled = False
   End Select
End Function

Function EstadoToolBars()
   Toolbar1.Buttons.Item(5).Enabled = True
   Select Case swModTipoOpe
      Case 0
         Call EstadoToolBar(False)
      Case 1
         Call EstadoToolBar(True)
      Case 2
         Toolbar1.Buttons.Item(2).Enabled = False
         Toolbar1.Buttons.Item(3).Enabled = False
         Toolbar1.Buttons.Item(5).Enabled = False
      Case 3
         Toolbar1.Buttons.Item(2).Enabled = False
         Toolbar1.Buttons.Item(3).Enabled = True
         Toolbar1.Buttons.Item(4).Enabled = True
         Toolbar1.Buttons.Item(5).Enabled = True
      Case 4
         Toolbar1.Buttons.Item(2).Enabled = False
         Toolbar1.Buttons.Item(3).Enabled = False
         Toolbar1.Buttons.Item(5).Enabled = False
   End Select
End Function

Private Sub Form_Load()
   Me.Icon = BACSwap.Icon
   
   Me.Top = 0
   Me.Left = 0
   
   Call InicializaGrilla
End Sub

Private Sub grdConsulta_DblClick()
If grdConsulta.Col = 8 Then
    Select Case grdConsulta.TextMatrix(grdConsulta.Row, grdConsulta.Col)
        Case "": grdConsulta.TextMatrix(grdConsulta.Row, grdConsulta.Col) = "CLP"
        Case "CLP": grdConsulta.TextMatrix(grdConsulta.Row, grdConsulta.Col) = "USD"
        Case "USD": grdConsulta.TextMatrix(grdConsulta.Row, grdConsulta.Col) = ""
    End Select
End If

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As ComctlLib.Button)
   Select Case Button.Index
      Case 1
         Call FiltrarConsulta
      Case 2
         Call btnModificar_Click
      Case 3
         Call btnSalir_Click
   End Select
End Sub

Sub FiltrarConsulta()

    Envia = Array()
    AddParam Envia, 3
    AddParam Envia, 0
    AddParam Envia, 0
    AddParam Envia, 0
    AddParam Envia, 0
    AddParam Envia, 0
    AddParam Envia, 0
    AddParam Envia, 0
    AddParam Envia, CDate(gsBAC_Fecp)
    AddParam Envia, CDate(gsBAC_Fecp)
    If Not Bac_Sql_Execute("SP_LEER_OPE_COLATERAL_SWP", Envia) Then
        MsgBox ("Error busca estado operacion")
    End If
   
   Me.MousePointer = vbHourglass
    
   With Me.grdConsulta
       .Rows = 1
      Do While Bac_SQL_Fetch(Datos())
         .Rows = .Rows + 1
         .TextMatrix(.Rows - 1, 0) = Datos(1)
         .TextMatrix(.Rows - 1, 1) = Datos(2)
         .TextMatrix(.Rows - 1, 2) = Datos(6)
         .TextMatrix(.Rows - 1, 3) = Datos(4)
         .TextMatrix(.Rows - 1, 4) = Datos(7)
         .TextMatrix(.Rows - 1, 5) = Datos(8)
         .TextMatrix(.Rows - 1, 6) = Datos(10)
         .TextMatrix(.Rows - 1, 7) = Format(Datos(11), "###,###,###,##0.#0")
         .TextMatrix(.Rows - 1, 8) = Datos(16)
      Loop
   End With
   Me.MousePointer = vbDefault


End Sub
Sub Marcar_Ope_Colateral(nOperacion As Long, cColateral As String)
    
    Dim sSql As String
    Dim Envia()
    Dim Datos()
    On Error GoTo ErrorColateral
        
        Envia = Array()
        AddParam Envia, nOperacion
        AddParam Envia, cColateral
        sSql = "Sp_Marca_Ope_Colateral_Swap"
        
        If Not Bac_Sql_Execute(sSql, Envia) Then
            MsgBox "Problema al actualizar Colateral ", vbExclamation, "MENSAJE"
            Exit Sub
        End If
    
    Exit Sub
    
ErrorColateral:
    MsgBox "Acción Abortada." & vbCrLf & BACSwap.Crystal.LastErrorString, vbExclamation, TITSISTEMA
    Exit Sub
End Sub

Function EstadoBtn(estado)
End Function

