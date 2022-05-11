VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "COMDLG32.OCX"
Begin VB.Form FMUT_Venc_Cuo 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Vencimientos Cuotas Fondos Mutuos"
   ClientHeight    =   5610
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   13245
   DrawWidth       =   2
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   NegotiateMenus  =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5610
   ScaleWidth      =   13245
   Visible         =   0   'False
   Begin VB.TextBox Text1 
      BackColor       =   &H00800000&
      BorderStyle     =   0  'None
      ForeColor       =   &H00FFFFFF&
      Height          =   315
      Left            =   240
      TabIndex        =   3
      TabStop         =   0   'False
      Top             =   1920
      Visible         =   0   'False
      Width           =   980
   End
   Begin BACControles.TXTNumero TEXT2 
      Height          =   315
      Left            =   1080
      TabIndex        =   2
      TabStop         =   0   'False
      Top             =   2880
      Visible         =   0   'False
      Width           =   1095
      _ExtentX        =   1931
      _ExtentY        =   556
      BackColor       =   8388608
      ForeColor       =   16777215
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
      BorderStyle     =   0
      Text            =   "0.0000"
      Text            =   "0.0000"
      Min             =   "-99"
      Max             =   "999999999999,9999"
      CantidadDecimales=   "4"
      Separator       =   -1  'True
   End
   Begin MSComDlg.CommonDialog Cdd_Dialogo 
      Left            =   7200
      Top             =   0
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Height          =   510
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   2805
      _ExtentX        =   4948
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      DisabledImageList=   "ImageList1"
      HotImageList    =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Description     =   "Refresca"
            Object.ToolTipText     =   "Refresh"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdGrabar"
            Description     =   "Grabar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdSalir"
            Description     =   "Salir"
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin MSFlexGridLib.MSFlexGrid Table1 
      Height          =   3975
      Left            =   0
      TabIndex        =   1
      Top             =   960
      Width           =   12855
      _ExtentX        =   22675
      _ExtentY        =   7011
      _Version        =   393216
      Cols            =   13
      FixedCols       =   0
      RowHeightMin    =   315
      BackColor       =   -2147483633
      ForeColor       =   8388608
      BackColorFixed  =   8421376
      ForeColorFixed  =   16777215
      BackColorSel    =   8388608
      ForeColorSel    =   -2147483643
      BackColorBkg    =   -2147483635
      GridColor       =   -2147483635
      GridColorFixed  =   -2147483635
      Enabled         =   0   'False
      FocusRect       =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   6000
      Top             =   0
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
            Picture         =   "FMUT_Venc_Cuo.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FMUT_Venc_Cuo.frx":0452
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FMUT_Venc_Cuo.frx":08A4
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "FMUT_Venc_Cuo"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

'Constantes para Grilla

Dim Monto               As Double
Dim Antes               As Double

Const Col_NroOpe = 0
Const Col_Corre = 1
Const Col_RutAdm = 2
Const Col_CodAdm = 3
Const Col_NomAdm = 4
Const Col_Instru = 5
Const Col_CntCuo = 6
Const Col_PreCuo = 7
Const Col_ValVen = 8

Private Sub Form_Load()
   
   Me.Top = 0: Me.Left = 0
   Screen.MousePointer = vbHourglass
   
   Toolbar1.Buttons(1).Visible = True
    
    Call Func_Grilla
    
    Call Proc_Carga_Grilla
    
End Sub
Function Func_Grilla()
    On Error GoTo Sale
    Table1.Cols = 9
    Table1.Rows = 1
    Table1.Rows = 2
    Table1.FixedRows = 1
    
    Table1.ColWidth(Col_NroOpe) = 860
    Table1.ColWidth(Col_Corre) = 800
    Table1.ColWidth(Col_RutAdm) = 950
    Table1.ColWidth(Col_CodAdm) = 800
    Table1.ColWidth(Col_NomAdm) = 2500
    Table1.ColWidth(Col_Instru) = 1300
    Table1.ColWidth(Col_CntCuo) = 2000
    Table1.ColWidth(Col_PreCuo) = 2000
    Table1.ColWidth(Col_ValVen) = 2000
    
    Table1.TextMatrix(0, Col_NroOpe) = "N.Operacion"
    Table1.TextMatrix(0, Col_Corre) = "Correlativo"
    Table1.TextMatrix(0, Col_RutAdm) = "Rut Administradora"
    Table1.TextMatrix(0, Col_CodAdm) = "Cod. Admin."
    Table1.TextMatrix(0, Col_NomAdm) = "Nombre Administradora"
    Table1.TextMatrix(0, Col_Instru) = "Instrumento"
    Table1.TextMatrix(0, Col_CntCuo) = "Cantidad Cuotas"
    Table1.TextMatrix(0, Col_PreCuo) = "Precio Vcto. Cuota"
    Table1.TextMatrix(0, Col_ValVen) = "Valor Vencimiento"
    
    Exit Function
Sale:
    MsgBox error, 64, Me.Caption
End Function
Private Sub Table1_GotFocus()
   
   Table1.CellBackColor = &H808000: TEXT2.Font.bold = True

End Sub

Private Sub Table1_KeyPress(KeyAscii As Integer)
   Dim x

'   Call FUNC_Decimales_de_Moneda(Table1.TextMatrix(Table1.Row, 1))
    
    If Table1.Col = Col_PreCuo Then
        TEXT2.Enabled = True
        TEXT2.Text = BacCtrlTransMonto(CDbl(Table1.TextMatrix(Table1.Row, Table1.Col)))
        
        If Mid(Table1.TextMatrix(Table1.Row, Col_Instru), 7, 3) = "CLP" Then
           TEXT2.CantidadDecimales = 4
        Else
            TEXT2.CantidadDecimales = 4
        End If
        
        
        TEXT2.Visible = True
        If KeyAscii > 47 And KeyAscii < 58 Then TEXT2.Text = Chr(KeyAscii)
            TEXT2.SetFocus
     Else
        TEXT2.Enabled = False
     End If

End Sub

Private Sub Table1_LeaveCell()
   Table1.CellBackColor = &H8000000F
End Sub

Private Sub Table1_Scroll()
    Me.Text1.Visible = False
    Me.TEXT2.Visible = False
End Sub

Private Sub Table1_SelChange()
   Table1.CellBackColor = &H808000
   Text1.Font.bold = True
End Sub

Private Sub Text2_GotFocus()

   Call PROC_POSI_TEXTO(Table1, TEXT2)
   
'   If Mid(Table1.TextMatrix(Table1.Row, Col_Instru), 7, 3) = "CLP" Then
'      TEXT2.SelStart = Len(TEXT2.Text)
'   Else
'      TEXT2.SelStart = Len(TEXT2.Text) - 5
'   End If

      
End Sub
Private Sub Text2_KeyDown(KeyCode As Integer, Shift As Integer)
Dim cant_cuot As Double
Dim precio_cuo As Double
Dim valor_vto As Double

   If KeyCode = vbKeyEscape Then
      TEXT2.Text = ""
      TEXT2.Visible = False

   End If


   If KeyCode = vbKeyReturn Then
      
      Antes = Table1.TextMatrix(Table1.RowSel, Table1.ColSel)
      cant_cuot = CDbl(Table1.TextMatrix(Table1.RowSel, Col_CntCuo))
      precio_cuo = CDbl(TEXT2.Text)
      valor_vto = cant_cuot * precio_cuo
      
      If Mid(Table1.TextMatrix(Table1.Row, Col_Instru), 7, 3) = "CLP" Then
        Table1.TextMatrix(Table1.RowSel, Table1.ColSel) = Format(CDbl(TEXT2.Text), "###,###,###,##0.0000") '--> "###,###,###,##0")
        Table1.TextMatrix(Table1.RowSel, Col_ValVen) = Format(valor_vto, "###,###,###,##0.0000")     '--> "###,###,###,##0")
      Else
        Table1.TextMatrix(Table1.RowSel, Table1.ColSel) = Format(CDbl(TEXT2.Text), "###,###,###,##0.0000")
        Table1.TextMatrix(Table1.RowSel, Col_ValVen) = Format(valor_vto, "###,###,###,##0.0000")
      End If
      
      TEXT2.Visible = False
      
      Call Text2_LostFocus
   End If

End Sub

Private Sub Text2_LostFocus()
   On Error Resume Next
   
   'Text2.Text = 0
   TEXT2.Visible = False
   If Table1.Enabled = True Then: Table1.SetFocus

End Sub


Private Function Proc_Carga_Grilla()
   Dim x As Integer
   Dim Datos()

    'Recorre Lista para Generar Archivo
    Envia = Array(gsBac_Fecp)

    If Not Bac_Sql_Execute("SP_CON_CUOTASFM_PRECIO", Envia) Then
        Exit Function
    End If
    
   'Table1.Redraw = False
   Table1.Rows = 1
    
   Do While Bac_SQL_Fetch(Datos())
      x = Table1.Rows
      Table1.Rows = Table1.Rows + 1
        
      With Table1
         .TextMatrix(x, Col_NroOpe) = Datos(1)
         .TextMatrix(x, Col_Corre) = Datos(2)
         .TextMatrix(x, Col_RutAdm) = Datos(3)
         .TextMatrix(x, Col_CodAdm) = Datos(4)
         .TextMatrix(x, Col_NomAdm) = Datos(5)
         .TextMatrix(x, Col_Instru) = Datos(6)
          
         .TextMatrix(x, Col_CntCuo) = Format(Datos(7), "###,###,###,##0.0000")
         .TextMatrix(x, Col_PreCuo) = Format(Datos(8), "###,###,###,##0.0000")
         .TextMatrix(x, Col_ValVen) = Format(Datos(9), "###,###,###,##0.0000")
          
          
'          If Mid(.TextMatrix(x, Col_Instru), 7, 3) = "CLP" Then
'            .TextMatrix(x, Col_CntCuo) = Format(Datos(7), "###,###,###,##0")
'            .TextMatrix(x, Col_PreCuo) = Format(Datos(8), "###,###,###,##0")
'            .TextMatrix(x, Col_ValVen) = Format(Datos(9), "###,###,###,##0")
'          Else
'            .TextMatrix(x, Col_CntCuo) = Format(Datos(7), "###,###,###,##0.0000")
'            .TextMatrix(x, Col_PreCuo) = Format(Datos(8), "###,###,###,##0.0000")
'            .TextMatrix(x, Col_ValVen) = Format(Datos(9), "###,###,###,##0.0000")
'          End If
         
         
      End With
    Loop

    Table1.Enabled = True
    
    Screen.MousePointer = 0
    Exit Function

End Function

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

   Select Case UCase(Button.Description)
   Case "GRABAR"
      Call Func_Grabar
      Call Proc_Carga_Grilla

   Case "REFRESCA"
    Call Proc_Carga_Grilla

   Case "SALIR"
      Unload Me

   End Select

End Sub


Private Function Func_Grabar()
Dim T_int_linea_gri As Integer

    For T_int_linea_gri = 1 To Table1.Rows - 1
        If Table1.TextMatrix(T_int_linea_gri, Col_PreCuo) > 0 Then
            Envia = Array()
            AddParam Envia, Val(Table1.TextMatrix(T_int_linea_gri, Col_NroOpe))
            AddParam Envia, Val(Table1.TextMatrix(T_int_linea_gri, Col_Corre))
            AddParam Envia, Table1.TextMatrix(T_int_linea_gri, Col_Instru)
            AddParam Envia, CDbl(Table1.TextMatrix(T_int_linea_gri, Col_PreCuo))
            AddParam Envia, CDbl(Table1.TextMatrix(T_int_linea_gri, Col_ValVen))
            AddParam Envia, CDate(gsBac_Fecp)
            If Not Bac_Sql_Execute("SP_GRABAR_VENCIMIENTOS", Envia) Then
                 Exit Function
            End If
        End If
    Next
   
   Screen.MousePointer = vbDefault
   MsgBox "Vencimientos de Cuotas Fondos Mutuos." & vbCrLf & vbCrLf & "La actualización de precios a finalizado con exito.", vbInformation, TITSISTEMA


End Function
