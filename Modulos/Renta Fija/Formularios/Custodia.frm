VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form Custodia 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Custodia Captaciones"
   ClientHeight    =   6000
   ClientLeft      =   480
   ClientTop       =   1725
   ClientWidth     =   11655
   Icon            =   "Custodia.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   6000
   ScaleWidth      =   11655
   Begin VB.Data Data1 
      Caption         =   "Data1"
      Connect         =   "Access"
      DatabaseName    =   ""
      DefaultCursorType=   0  'DefaultCursor
      DefaultType     =   2  'UseODBC
      Exclusive       =   0   'False
      Height          =   300
      Left            =   615
      Options         =   0
      ReadOnly        =   0   'False
      RecordsetType   =   1  'Dynaset
      RecordSource    =   ""
      Top             =   7005
      Width           =   1155
   End
   Begin Threed.SSFrame SSFrame1 
      Height          =   1020
      Left            =   0
      TabIndex        =   0
      Top             =   495
      Width           =   11625
      _Version        =   65536
      _ExtentX        =   20505
      _ExtentY        =   1799
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
      Begin VB.TextBox txtNumeroOperacion 
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
         Height          =   300
         Left            =   1830
         MaxLength       =   5
         TabIndex        =   3
         Top             =   570
         Width           =   1260
      End
      Begin VB.TextBox txtCodigoCliente 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   300
         Left            =   3120
         TabIndex        =   2
         Top             =   180
         Width           =   570
      End
      Begin VB.TextBox txtRutCliente 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   300
         Left            =   1845
         MaxLength       =   9
         MouseIcon       =   "Custodia.frx":030A
         MousePointer    =   99  'Custom
         TabIndex        =   1
         Top             =   180
         Width           =   1245
      End
      Begin VB.Label lblCliente 
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
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
         Left            =   3735
         TabIndex        =   6
         Top             =   180
         Width           =   7500
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "Nro. Operaci?n"
         BeginProperty Font 
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
         Left            =   150
         TabIndex        =   5
         Top             =   585
         Width           =   1590
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Cliente"
         BeginProperty Font 
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
         Left            =   135
         TabIndex        =   4
         Top             =   225
         Width           =   735
      End
   End
   Begin Threed.SSFrame SSFrame2 
      Height          =   4545
      Left            =   0
      TabIndex        =   7
      Top             =   1470
      Width           =   11625
      _Version        =   65536
      _ExtentX        =   20505
      _ExtentY        =   8017
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
      Begin MSFlexGridLib.MSFlexGrid TabCustodia 
         Height          =   4290
         Left            =   15
         TabIndex        =   8
         Top             =   165
         Width           =   11520
         _ExtentX        =   20320
         _ExtentY        =   7567
         _Version        =   393216
         Cols            =   10
         FixedCols       =   0
         BackColor       =   12632256
         ForeColor       =   12582912
         BackColorFixed  =   8421376
         ForeColorFixed  =   16777215
         BackColorSel    =   8388608
         FocusRect       =   0
         GridLines       =   2
         SelectionMode   =   1
         BorderStyle     =   0
      End
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   9510
      Top             =   -15
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   25
      ImageHeight     =   25
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   3
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Custodia.frx":0614
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Custodia.frx":0A66
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Custodia.frx":0EB8
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Height          =   495
      Left            =   45
      TabIndex        =   9
      Top             =   0
      Width           =   11565
      _ExtentX        =   20399
      _ExtentY        =   873
      ButtonWidth     =   847
      ButtonHeight    =   820
      AllowCustomize  =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdActualizar"
            Description     =   "Actualizar"
            Object.ToolTipText     =   "Actualizar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdBuscar"
            Description     =   "Buscar"
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdCancelar"
            Description     =   "Cancelar"
            Object.ToolTipText     =   "Cancelar"
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
End
Attribute VB_Name = "Custodia"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False


Function Limpiar()
   db.Execute "Delete * from Custodia"
   Data1.Refresh
   txtRutCliente.Text = ""
   txtCodigoCliente.Text = ""
   lblCliente.Caption = ""
   txtNumeroOperacion.Text = ""
   txtRutCliente.SetFocus
   TabCustodia.Enabled = False
   
End Function
Function llenarGR()

    

End Function


Private Sub BtnActualizar_Click()
   
End Sub

Private Sub BtnBuscar_Click()
 
End Sub

Private Sub BtnCancelar_Click()
   
End Sub


Private Sub Form_Load()
   'Me.Left = 0
   Me.Top = 0
   
   db.Execute "Delete * from custodia"
   Data1.DatabaseName = gsMDB_Path + gsMDB_Database
   Data1.RecordSource = "CUSTODIA"
   Data1.Refresh
   TitulosGrilla
End Sub

Sub TitulosGrilla()
   With TabCustodia
      .Clear
      .Rows = 2
      .Cols = 9
      .FixedCols = 0
      .RowHeight(0) = 400
        For X = 0 To .Cols - 1
            .FixedAlignment(X) = 4
        Next X
      '.ScrollBars = flexScrollBarVertical
      .TextMatrix(0, 0) = "N?m. Operaci?n"
      .TextMatrix(0, 1) = "Correlativo"
      .TextMatrix(0, 2) = "Valor Inicial"
      .TextMatrix(0, 3) = "Valor Final"
      .TextMatrix(0, 4) = "Tasa"
      .TextMatrix(0, 5) = "UM"
      .TextMatrix(0, 6) = "Fecha Inicio"
      .TextMatrix(0, 7) = "Fecha Venc."
      .TextMatrix(0, 8) = "Custodia"
   
      .ColWidth(0) = 1400
      .ColWidth(1) = 1400
      .ColWidth(2) = 1400
      .ColWidth(3) = 1400
      .ColWidth(4) = 1400
      .ColWidth(5) = 520
      .ColWidth(6) = 1300
      .ColWidth(7) = 1300
      .ColWidth(8) = 1300
   End With
End Sub

Private Sub TabCustodia_FetchAttributes(Status As Integer, Split As Integer, Row As Long, Col As Integer, FgColor As Long, BgColor As Long, FontStyle As Integer)
'    If Row = TabCustodia.RowIndex Then
'       FgColor = BacToolTip.Color_Dest.ForeColor
'       BgColor = BacToolTip.Color_Dest.BackColor
'    Else
'       FgColor = BacToolTip.Color_Normal.ForeColor
'       BgColor = BacToolTip.Color_Normal.BackColor
'    End If
End Sub


Private Sub TabCustodia_KeyPress(KeyAscii As Integer)
   KeyAscii = 0
End Sub
Sub Buscar()
Dim DATOS()
Dim p As Integer
   
   Screen.MousePointer = vbHourglass
   
'   Sql = "sp_clleerrut1 " & Val(txtRutCliente) & "," & Val(txtCodigoCliente)

    Envia = Array(CDbl(txtRutCliente.Text), CDbl(txtCodigoCliente))
   
    If Bac_Sql_Execute("sp_clleerrut1", Envia) Then
        If Bac_SQL_Fetch(DATOS()) Then
            lblCliente.Caption = DATOS(4)
        Else
            MsgBox "Cliente no Existe", vbOKOnly + vbCritical
            Screen.MousePointer = vbDefault
            Call Limpiar
            Call TitulosGrilla
            Exit Sub
        End If
    End If
   
    db.Execute "Delete * from Custodia"
    Data1.Refresh
    Call TitulosGrilla
    p = 0
   
'    Sql = "Sp_Trae_Custodia " & Val(txtRutCliente)
    Envia = Array(CDbl(txtRutCliente))
    
    If Bac_Sql_Execute("Sp_Trae_Custodia", Envia) Then
        TabCustodia.Rows = 2
        
        Do While Bac_SQL_Fetch(DATOS())
            p = p + 1
            TabCustodia.Row = TabCustodia.Rows - 1
            txtNumeroOperacion.Text = Val(DATOS(2)) 'ACA
            TabCustodia.TextMatrix(TabCustodia.Row, 0) = Val(DATOS(2))
            TabCustodia.TextMatrix(TabCustodia.Row, 1) = Val(DATOS(10))
            TabCustodia.TextMatrix(TabCustodia.Row, 2) = Format(DATOS(3), "#,##0.0000")
            TabCustodia.TextMatrix(TabCustodia.Row, 3) = Format(DATOS(4), "#,##0.0000")
            TabCustodia.TextMatrix(TabCustodia.Row, 4) = Format(DATOS(5), "#,##0.0000")
            TabCustodia.TextMatrix(TabCustodia.Row, 5) = DATOS(6)
            TabCustodia.TextMatrix(TabCustodia.Row, 6) = Format(DATOS(7), "dd/mm/yyyy")
            TabCustodia.TextMatrix(TabCustodia.Row, 7) = Format(DATOS(8), "dd/mm/yyyy")
            TabCustodia.TextMatrix(TabCustodia.Row, 8) = DATOS(9)
        
            TabCustodia.Rows = TabCustodia.Rows + 1
        Loop
        
        TabCustodia.Row = 1
        TabCustodia.Rows = TabCustodia.Rows '- 1
        TabCustodia.Col = 0
        TabCustodia.ColSel = TabCustodia.Cols - 1
        TabCustodia.Enabled = True
        TabCustodia.SetFocus
    End If
    
    If p = 0 Then
        MsgBox "No existen datos para el criterio seleccionado", vbOKOnly + vbExclamation
        Call Limpiar
        Toolbar1.Buttons(1).Enabled = False  'Actualizar
        'BtnActualizar.Enabled = False
        txtNumeroOperacion.Enabled = False
        Screen.MousePointer = vbDefault
        Exit Sub
    End If
    Toolbar1.Buttons(1).Enabled = True  'Actualizar
   
    txtNumeroOperacion.Enabled = True
    Data1.Refresh
    Screen.MousePointer = vbDefault

End Sub
Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Key
   Case Is = "cmdActualizar"
      Call Actualiza
   Case Is = "cmdBuscar"
      Call Buscar
   Case Is = "cmdCancelar"
      Unload Me
End Select
End Sub
Sub Actualiza()
Dim X As Integer
Dim xCustodia As String
Dim DATOS()
On Error GoTo Error_Custodia
   
    Screen.MousePointer = vbHourglass
    TabCustodia.Refresh
       
    For X = 1 To TabCustodia.Rows - 1
        xCustodia = IIf(TabCustodia.TextMatrix(X, 8) = "PROPIA", "P", "C")
'        Sql = "Sp_Actualiza_Custodia " & Val(TabCustodia.TextMatrix(X, 0)) & "," & Chr(10)
'        Sql = Sql & Val(TabCustodia.TextMatrix(X, 1)) & "," & Chr(10)
'        Sql = Sql & "'" & xCustodia & "'"

        Envia = Array(CDbl(TabCustodia.TextMatrix(X, 0)), _
                CDbl(TabCustodia.TextMatrix(X, 1)), _
                xCustodia)
        If Bac_Sql_Execute("Sp_Actualiza_Custodia", Envia) Then
        End If
        
    Next X
    
    MsgBox "Datos grabados en forma correcta", vbOKOnly + vbInformation
    TabCustodia.Refresh
    Call Limpiar
    Call TitulosGrilla
       
    Screen.MousePointer = vbDefault
   
    Exit Sub
    
    
Error_Custodia:
    MsgBox "Problemas al grabar custodia : " & Err.Description, vbOKOnly + vbCritical
    Exit Sub
    
End Sub
Private Sub txtCodigoCliente_KeyPress(KeyAscii As Integer)
   If Not IsNumeric(Chr(KeyAscii)) And KeyAscii <> 8 And KeyAscii <> 13 Then
      KeyAscii = 0
   End If
   If KeyAscii = 13 Then
      BtnBuscar.SetFocus
   End If
End Sub

Private Sub txtCodigoCliente_LostFocus()
Dim DATOS()

    'Sql = "sp_clleerrut1 " & Val(txtRutCliente) & "," & Val(txtCodigoCliente)
    Envia = Array(CDbl(txtRutCliente), CDbl(txtCodigoCliente))
    
    If Bac_Sql_Execute("sp_clleerrut1", Envia) Then
        If Bac_SQL_Fetch(DATOS()) Then
            lblCliente.Caption = DATOS(4)
        Else
            MsgBox "Cliente no Existe", vbOKOnly + vbCritical
        End If
    End If
    
End Sub


Private Sub txtNumeroOperacion_KeyPress(KeyAscii As Integer)
   If Not IsNumeric(Chr(KeyAscii)) And KeyAscii <> 13 And KeyAscii <> 8 Then
      KeyAscii = 0
   End If
   If KeyAscii = 13 Then
      Data1.Refresh
      Do While Not Data1.Recordset.EOF
         If Data1.Recordset("NumeroOperacion") = txtNumeroOperacion.Text Then
            Exit Sub
          End If
          Data1.Recordset.MoveNext
      Loop
      If Data1.Recordset.EOF Then
         MsgBox "No existe Numero de Operacion"
      End If
   End If
End Sub


Private Sub txtRutCliente_DblClick()
   BacAyuda.Tag = "MDCL"
   BacAyuda.Show 1
   If giAceptar = True Then
      txtRutCliente.Text = Val(gsrut$)
      lblCliente.Caption = gsDescripcion$
      txtCodigoCliente.Text = gsvalor$
      SendKeys "{ENTER}"
   End If
End Sub


Private Sub txtRutCliente_KeyPress(KeyAscii As Integer)
   If Not IsNumeric(Chr(KeyAscii)) And KeyAscii <> 8 And KeyAscii <> 13 Then
      KeyAscii = 0
   End If
   If KeyAscii = 13 Then
      txtCodigoCliente.SetFocus
   End If
End Sub


