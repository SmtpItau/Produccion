VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form BacContrato 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Impresión de Contrato.-"
   ClientHeight    =   4635
   ClientLeft      =   -15
   ClientTop       =   2430
   ClientWidth     =   10725
   ForeColor       =   &H00C0C0C0&
   Icon            =   "Baccontr.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4635
   ScaleWidth      =   10725
   Begin VB.TextBox Txt_Apoderado1 
      Height          =   495
      Left            =   2640
      TabIndex        =   19
      Top             =   5760
      Width           =   4185
   End
   Begin VB.TextBox Txt_Apoderado2 
      Height          =   495
      Left            =   2640
      TabIndex        =   18
      Top             =   6225
      Width           =   4185
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   3720
      Top             =   120
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
            Picture         =   "Baccontr.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Baccontr.frx":0624
            Key             =   ""
         EndProperty
      EndProperty
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
      Left            =   1815
      Style           =   2  'Dropdown List
      TabIndex        =   3
      Top             =   585
      Width           =   2025
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   6
      Top             =   0
      Width           =   10725
      _ExtentX        =   18918
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
            Description     =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin Threed.SSFrame Fra_Apoderado 
      Height          =   1725
      Left            =   1080
      TabIndex        =   7
      Top             =   1920
      Visible         =   0   'False
      Width           =   6030
      _Version        =   65536
      _ExtentX        =   10636
      _ExtentY        =   3043
      _StockProps     =   14
      ForeColor       =   -2147483630
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin Threed.SSCommand cmdCancelar 
         Height          =   375
         Left            =   4800
         TabIndex        =   16
         Top             =   1320
         Width           =   975
         _Version        =   65536
         _ExtentX        =   1720
         _ExtentY        =   661
         _StockProps     =   78
         Caption         =   "&Cancelar"
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
      End
      Begin VB.TextBox Txt_Rut1 
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
         Height          =   285
         Left            =   165
         TabIndex        =   13
         Top             =   315
         Width           =   900
      End
      Begin VB.TextBox Txt_Digito1 
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
         Height          =   315
         Left            =   1245
         TabIndex        =   12
         Top             =   315
         Width           =   285
      End
      Begin VB.TextBox Txt_Digito2 
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
         Height          =   315
         Left            =   1245
         TabIndex        =   11
         Top             =   855
         Width           =   285
      End
      Begin VB.TextBox Txt_Rut2 
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
         Height          =   285
         Left            =   180
         TabIndex        =   10
         Top             =   855
         Width           =   900
      End
      Begin VB.ComboBox Cmb_Apoderado1 
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
         ItemData        =   "Baccontr.frx":093E
         Left            =   1800
         List            =   "Baccontr.frx":0940
         Style           =   2  'Dropdown List
         TabIndex        =   9
         Top             =   285
         Width           =   3990
      End
      Begin VB.ComboBox Cmb_Apoderado2 
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
         Left            =   1785
         Style           =   2  'Dropdown List
         TabIndex        =   8
         Top             =   855
         Width           =   3990
      End
      Begin Threed.SSCommand cmdAceptar 
         Height          =   375
         Left            =   3840
         TabIndex        =   17
         Top             =   1320
         Width           =   975
         _Version        =   65536
         _ExtentX        =   1720
         _ExtentY        =   661
         _StockProps     =   78
         Caption         =   "&Aceptar"
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
      End
      Begin VB.Label Lbl_Guion2 
         Alignment       =   2  'Center
         AutoSize        =   -1  'True
         Caption         =   "-"
         Height          =   360
         Left            =   1125
         TabIndex        =   15
         Top             =   825
         Width           =   90
      End
      Begin VB.Label Lbl_Guion1 
         Alignment       =   2  'Center
         AutoSize        =   -1  'True
         Caption         =   "-"
         Height          =   360
         Left            =   1125
         TabIndex        =   14
         Top             =   285
         Width           =   90
      End
   End
   Begin MSFlexGridLib.MSFlexGrid Grd 
      Height          =   3660
      Left            =   120
      TabIndex        =   5
      Top             =   930
      Width           =   10560
      _ExtentX        =   18627
      _ExtentY        =   6456
      _Version        =   393216
      FixedCols       =   0
      BackColor       =   12632256
      ForeColor       =   12582912
      BackColorFixed  =   8421376
      ForeColorFixed  =   8421376
      BackColorSel    =   8388608
      ForeColorSel    =   -2147483629
      BackColorBkg    =   12632256
      FocusRect       =   2
      GridLines       =   2
      SelectionMode   =   1
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
      ForeColor       =   &H00800000&
      Height          =   240
      Left            =   180
      TabIndex        =   4
      Top             =   645
      Width           =   1590
   End
   Begin VB.Label LblColor3 
      Appearance      =   0  'Flat
      BackColor       =   &H00808000&
      BorderStyle     =   1  'Fixed Single
      Caption         =   "AAA"
      ForeColor       =   &H00FFFF80&
      Height          =   375
      Left            =   3360
      TabIndex        =   2
      Top             =   5400
      Width           =   1335
   End
   Begin VB.Label LblColor2 
      Appearance      =   0  'Flat
      BackColor       =   &H000000FF&
      BorderStyle     =   1  'Fixed Single
      Caption         =   "AAA"
      ForeColor       =   &H00FFFF80&
      Height          =   375
      Left            =   1800
      TabIndex        =   1
      Top             =   5400
      Width           =   1335
   End
   Begin VB.Label LblColor 
      Appearance      =   0  'Flat
      BackColor       =   &H00FF0000&
      BorderStyle     =   1  'Fixed Single
      Caption         =   "AAA"
      ForeColor       =   &H00FFFF80&
      Height          =   375
      Left            =   240
      TabIndex        =   0
      Top             =   5400
      Width           =   1335
   End
End
Attribute VB_Name = "BacContrato"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim ObjApoderado1       As Object
Dim ObjApoderado2       As Object
Dim ObjParametros       As Object
Dim FilaSeleccionada    As Integer
Dim Sql                 As String
Dim Datos()

Private Sub Cmb_Apoderado1_Click()
   
   If Cmb_Apoderado1.ItemData(Cmb_Apoderado1.ListIndex) = Val(Txt_Rut2.Text) And Val(Txt_Rut2.Text) <> 0 Then
      MsgBox "Apoderados iguales", vbExclamation, "ERROR"
   Else
      Txt_Rut1.Text = Cmb_Apoderado1.ItemData(Cmb_Apoderado1.ListIndex)
      Txt_Digito1.Text = BacCheckRut(Txt_Rut1.Text)
   End If

   Txt_Apoderado1.Text = Cmb_Apoderado1.Text
End Sub

Private Sub Cmb_Apoderado1_KeyPress(KeyAscii As Integer)
   If KeyAscii% = vbKeyReturn Then
      KeyAscii% = 0
      SendKeys$ "{TAB}"
   End If
End Sub

Private Sub Cmb_Apoderado1_LostFocus()
   Call bacBuscarCombo(Cmb_Apoderado1, Val(Txt_Rut1.Text))
End Sub

Private Sub Cmb_Apoderado2_Click()
   If Cmb_Apoderado2.ItemData(Cmb_Apoderado2.ListIndex) = Val(Txt_Rut1.Text) And Val(Txt_Rut1.Text) <> 0 Then
      MsgBox "Apoderados iguales", vbExclamation, "ERROR"
      Cmb_Apoderado2.Text = Txt_Apoderado2.Text
   Else
      Txt_Rut2.Text = Cmb_Apoderado2.ItemData(Cmb_Apoderado2.ListIndex)
      Txt_Digito2.Text = BacCheckRut(Txt_Rut2.Text)
   End If

   Txt_Apoderado2.Text = Cmb_Apoderado2.Text
End Sub

Private Sub Cmb_Apoderado2_KeyPress(KeyAscii As Integer)
   If KeyAscii% = vbKeyReturn Then
      KeyAscii% = 0
      SendKeys$ "{TAB}"
   End If
End Sub

Private Sub Cmb_Apoderado2_LostFocus()
   Call bacBuscarCombo(Cmb_Apoderado2, Val(Txt_Rut2.Text))
End Sub

Private Sub cmdBuscar_Click()
   Unload Bac_Apoderados
End Sub

Private Function BacCheckRut(Rut As String) As String
   Dim I       As Integer
   Dim D       As Integer
   Dim Divi    As Long
   Dim Suma    As Long
   Dim Digito  As String
   Dim multi   As Double
   
   If Trim$(Rut) = "" Then
      Exit Function
   End If
    
   Rut = Format(Rut, "00000000")
   D = 2

   For I = 8 To 1 Step -1
      multi = Val(Mid$(Rut, I, 1)) * D
      Suma = Suma + multi
      D = D + 1

      If D = 8 Then
         D = 2
      End If
   Next I
    
   Divi = (Suma \ 11)
   multi = Divi * 11
   Digito = Trim$(Str$(11 - (Suma - multi)))
    
   If Digito = "10" Then
      Digito = "K"
   End If
    
   If Digito = "11" Then
      Digito = "0"
   End If
    
   BacCheckRut = Trim$(UCase$(Digito))
   
End Function

Private Sub Func_Apoderados()

   Fra_Apoderado.Visible = True
   Grd.Enabled = False
   Toolbar1.Enabled = False

   Set ObjApoderado1 = New clsApoderado
   Set ObjApoderado2 = New clsApoderado
   Set ObjParametros = New clsParametros

   If ObjParametros.DatosGenerales() = False Then
      MsgBox "No se puede conectar a la tabla de parámetros", vbExclamation
      Exit Sub
   End If
  'codigo es cero porque es rut del propietario
   If ObjApoderado1.LeeTabApo(ObjParametros.ACrutprop, 1) = False Then
      MsgBox "No se puede conectar a la tabla de apoderados", vbExclamation
      Exit Sub
   End If
   
   If ObjApoderado2.LeeTabApo(ObjParametros.ACrutprop, 1) = False Then
      MsgBox "No se puede conectar a la tabla de apoderados", vbExclamation
      Exit Sub
   End If

   If ObjApoderado1.Coleccion.Count >= 1 Then
      Txt_Rut1.Text = ObjApoderado1.Coleccion(1).aprutapo
      Txt_Digito1.Text = ObjApoderado1.Coleccion(1).apdvapo
      
      Call ObjApoderado1.Control2Combo(Cmb_Apoderado1)
      
      Cmb_Apoderado1.AddItem " "
      Cmb_Apoderado1.ItemData(Cmb_Apoderado1.NewIndex) = 0
      
      Call bacBuscarCombo(Cmb_Apoderado1, Val(Txt_Rut1.Text))
      
      Txt_Apoderado1.Text = Cmb_Apoderado1.Text
      
      If ObjApoderado2.Coleccion.Count >= 2 Then
         Txt_Rut2.Text = ObjApoderado2.Coleccion(2).aprutapo
         Txt_Digito2.Text = ObjApoderado2.Coleccion(2).apdvapo
         
         Call ObjApoderado2.Control2Combo(Cmb_Apoderado2)
                  
         Cmb_Apoderado2.AddItem " "
         Cmb_Apoderado2.ItemData(Cmb_Apoderado2.NewIndex) = 0
         
         Call bacBuscarCombo(Cmb_Apoderado2, Val(Txt_Rut2.Text))
         
         Txt_Apoderado2.Text = Cmb_Apoderado2.Text
      Else
         Txt_Rut2.Enabled = False
         Txt_Digito2.Enabled = False
         Cmb_Apoderado2.Enabled = False
      End If

   Else
      Txt_Rut1.Enabled = False
      Txt_Digito1.Enabled = False
      Cmb_Apoderado1.Enabled = False
      Txt_Rut2.Enabled = False
      Txt_Digito2.Enabled = False
      Cmb_Apoderado2.Enabled = False
   End If
   
End Sub

Private Sub Func_Imprimir()
   Dim TitRpt           As String
   Dim RutCartera       As String
   Dim Numoper          As String
   Dim cTipOper         As String
   Dim nMoneda          As Integer
   Dim nTopRow          As Integer

   nTopRow = Grd.TopRow
   Grd.Row = FilaSeleccionada

   On Error GoTo ErrorImpresion

   gsTipoPapeleta = "C"

   If Grd.RowSel = 0 Then
      On Error GoTo 0
      Screen.MousePointer = 0
      MsgBox "No ha seleccionado elemento", 32, "Impresión de Contratos"
      Exit Sub
   End If

   Grd.Col = 0: Numoper = Grd.Text
   Grd.Col = 1: cTipOper = Grd.Text
   Grd.Col = 2: RutCartera = Grd.Text
   Grd.Col = 8: nMoneda = Grd.Text

   If cTipOper = "CAP" Then
      cTipOper = "IB"
   End If

   Screen.MousePointer = 11

   BacTrader.bacrpt.Destination = gsBac_Papeleta
   
   Call Limpiar_Cristal

   Select Case Trim$(UCase$(cTipOper))
   Case "CI"
   
      Call FUNC_GENERA_ANEXO_PACTOS
      Exit Sub

      TitRpt = "COMPRA CON PACTO "
      BacTrader.bacrpt.ReportFileName = RptList_Path & "PAPCNTCI.RPT"
      BacTrader.bacrpt.StoredProcParam(0) = RutCartera
      BacTrader.bacrpt.StoredProcParam(1) = Numoper
      BacTrader.bacrpt.StoredProcParam(2) = "C"
      BacTrader.bacrpt.StoredProcParam(3) = GLB_CARTERA_NORMATIVA
      BacTrader.bacrpt.StoredProcParam(4) = GLB_LIBRO

      BacTrader.bacrpt.Formulas(0) = "TIT='" & TitRpt & "'"
      BacTrader.bacrpt.Connect = CONECCION
      BacTrader.bacrpt.Action = 1
      BacTrader.bacrpt.Action = 1
      BacTrader.bacrpt.ReportFileName = RptList_Path & "PAPCNTCIV.RPT" 'Promesa de Venta
      BacTrader.bacrpt.StoredProcParam(0) = RutCartera
      BacTrader.bacrpt.StoredProcParam(1) = Numoper
      BacTrader.bacrpt.StoredProcParam(2) = "C"
      BacTrader.bacrpt.Formulas(0) = "TIT='" & TitRpt & "'"
      BacTrader.bacrpt.Connect = CONECCION
      BacTrader.bacrpt.Action = 1
      BacTrader.bacrpt.Action = 1
      Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Impresión " & TitRpt)

   Case "VI"
      TitRpt = "VENTA CON PACTO "
      
      Call FUNC_GENERA_ANEXO_PACTOS
      Exit Sub
      
        If CDbl(Grd.TextMatrix(Grd.Row, 9)) = 97029000 Then
            BacTrader.bacrpt.ReportFileName = RptList_Path & "PAPCNTVIBCOCENTRAL.RPT"
            BacTrader.bacrpt.StoredProcParam(0) = "97029000"
            BacTrader.bacrpt.StoredProcParam(1) = Numoper
            BacTrader.bacrpt.StoredProcParam(2) = "C"
        Else
            BacTrader.bacrpt.ReportFileName = RptList_Path & "PAPCNTVI.RPT"
            BacTrader.bacrpt.StoredProcParam(0) = RutCartera
            BacTrader.bacrpt.StoredProcParam(1) = Numoper
            BacTrader.bacrpt.Formulas(0) = "TIT='" & TitRpt & "'"
        End If
      
      BacTrader.bacrpt.Connect = CONECCION
      BacTrader.bacrpt.Action = 1
      BacTrader.bacrpt.Action = 1
      
      Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Impresión " & TitRpt)

   Case "CP"
      TitRpt = "COMPRA DEFINITIVA "
      BacTrader.bacrpt.ReportFileName = RptList_Path & "PAP_CP.RPT"
      Call PROC_ESTABLECE_UBICACION(BacTrader.bacrpt.RetrieveDataFiles, BacTrader.bacrpt)
      BacTrader.bacrpt.StoredProcParam(0) = RutCartera
      BacTrader.bacrpt.StoredProcParam(1) = Numoper
      BacTrader.bacrpt.StoredProcParam(2) = "P"
      BacTrader.bacrpt.StoredProcParam(3) = Space(1)
      BacTrader.bacrpt.StoredProcParam(4) = Space(1)
      BacTrader.bacrpt.StoredProcParam(5) = Space(1)
      
      
      BacTrader.bacrpt.Formulas(0) = "TIT='" & TitRpt & "'"
      BacTrader.bacrpt.Connect = CONECCION
      BacTrader.bacrpt.Action = 1
      BacTrader.bacrpt.Action = 1
      Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Impresión " & TitRpt)

   Case "VP"
      'Adrian Listo
      TitRpt = "VENTA DEFINITIVA "
      BacTrader.bacrpt.ReportFileName = RptList_Path & "PAP_VP.RPT"
      Call PROC_ESTABLECE_UBICACION(BacTrader.bacrpt.RetrieveDataFiles, BacTrader.bacrpt)
      BacTrader.bacrpt.StoredProcParam(0) = RutCartera
      BacTrader.bacrpt.StoredProcParam(1) = Numoper
      BacTrader.bacrpt.StoredProcParam(2) = "P"
      BacTrader.bacrpt.Formulas(0) = "TIT='" & TitRpt & "'"
      BacTrader.bacrpt.Connect = CONECCION
      BacTrader.bacrpt.Action = 1
      BacTrader.bacrpt.Action = 1
      Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Impresión " & TitRpt)

   Case "IB"

      BacTrader.bacrpt.CopiesToPrinter = 0

      TitRpt = "PAGARE INTERBANCARIO EN  "
      
      If nMoneda = 999 Then
         If CDbl(Grd.TextMatrix(Grd.Row, 9)) = 97029000 Then                                    '    Rut banco central
               BacTrader.bacrpt.ReportFileName = RptList_Path & "CONINTER125.RPT"   '   mensaje 125 banco central
          Else
               BacTrader.bacrpt.ReportFileName = RptList_Path & "CONINTER.RPT"
         End If
                  
      ElseIf nMoneda = 998 Then
          BacTrader.bacrpt.ReportFileName = RptList_Path & "CONINTER2.RPT"
      Else
          BacTrader.bacrpt.ReportFileName = RptList_Path & "CONINTER3.RPT"
      End If
      
      BacTrader.bacrpt.StoredProcParam(0) = RutCartera
      BacTrader.bacrpt.StoredProcParam(1) = Numoper
      BacTrader.bacrpt.StoredProcParam(2) = "C"
      BacTrader.bacrpt.StoredProcParam(3) = Trim$(TitRpt)
      BacTrader.bacrpt.StoredProcParam(4) = Apoderado1
      BacTrader.bacrpt.StoredProcParam(5) = Apoderado2
      BacTrader.bacrpt.StoredProcParam(6) = RutApoderado1
      BacTrader.bacrpt.StoredProcParam(7) = RutApoderado2
      BacTrader.bacrpt.StoredProcParam(8) = GLB_LIBRO
      BacTrader.bacrpt.Connect = CONECCION
      BacTrader.bacrpt.Action = 1

      Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Impresión " & TitRpt)

   Case "COL"
      MsgBox "Colocación Interbancaria no Genera Contrato", 64

   Case "ST"
      MsgBox "Sorteo de Letras no Genera Contrato", 64

   End Select

'   If cmbopcion.ListCount > 0 Then
'      Call BacCargaGrilla(cmbopcion.ListIndex)
'   Else
'      Call BacCargaGrilla(0)
'   End If
   
'  BacTrader.bacrpt.CopiesToPrinter = 1
   

   Grd.TopRow = nTopRow
   
   BacTrader.bacrpt.Destination = crptToWindow

   Screen.MousePointer = 0

   On Error GoTo 0
   Exit Sub

ErrorImpresion:
   On Error GoTo 0

   MsgBox "Error al Imprimir Contratos: " & err.Number & " " & err.Description, 64

End Sub

Private Sub BacCargaGrilla(nOpcion As Long)
Dim cOpcion          As String

    Screen.MousePointer = 11
    
    Call Nombres

    ' Ordenado por Numero de Operación
    '---------------------------------
    If nOpcion = 0 Then
        cOpcion = "N"

    ' Ordenado por Tipo de operación"
    '---------------------------------
    ElseIf nOpcion = 1 Then
        cOpcion = "T"

    ' Ordenado por Cliente
    '---------------------------------
    ElseIf nOpcion = 2 Then
        cOpcion = "C"

    End If

'   Sql = "SP_CONSULTAOPERPAPEL '" & cOpcion & "'"

    Envia = Array(cOpcion, "C")

    If Not Bac_Sql_Execute("SP_CONSULTAOPERPAPEL", Envia) Then
        Screen.MousePointer = 0
        MsgBox "No se puede conectar a tabla de movimientos"
        Exit Sub
    End If

    With Grd
        Grd.Rows = 2
        Grd.Row = 1
        Grd.cols = 11 '9


        Do While Bac_SQL_Fetch(Datos())
            If Mid$(Datos(2), 1, 1) <> "A" Then
                .Row = .Rows - 1
                .Col = 0: .Text = Val(Datos(1))
                .Col = 1: .Text = Datos(2)
                .Col = 2: .Text = Val(Datos(3))
                .Col = 3: .Text = Datos(4)
                .Col = 4: .Text = Format(Val(Datos(5)), "###,###0.0000")
                .Col = 5: .Text = Datos(6)
                .Col = 6: .Text = Datos(9)
                .Col = 7: .Text = Datos(7)
                .Col = 8: .Text = Datos(11)
                .Col = 9: .Text = Datos(12)
                .Col = 10: .Text = Datos(14)

                .Rows = .Rows + 1
                .RowHeight(.Row) = 350
            End If
        Loop

        .Rows = .Rows - 1

    End With

    Screen.MousePointer = 0

End Sub

Private Sub cmbopcion_Click()

   If cmbopcion.ListIndex <> -1 Then
      Call BacCargaGrilla(cmbopcion.ListIndex)

   End If

   Grd.Row = 0: Grd.Col = 0
   Grd.SelectionMode = flexSelectionFree

End Sub

Private Sub cmdAceptar_Click()
   Apoderado1 = BacContrato.Cmb_Apoderado1.Text
   Apoderado2 = BacContrato.Cmb_Apoderado2.Text
   RutApoderado1 = BacContrato.Txt_Rut1 & "-" & BacContrato.Txt_Digito1
   RutApoderado2 = BacContrato.Txt_Rut2 & "-" & BacContrato.Txt_Digito2

   Call Func_Imprimir
   Call Func_Imprimir

   Fra_Apoderado.Visible = False
   Grd.Enabled = True
   Toolbar1.Enabled = True

End Sub

Private Sub cmdCancelar_Click()

   Fra_Apoderado.Visible = False
   Grd.Enabled = True
   Toolbar1.Enabled = True

End Sub

Private Sub Form_Load()

   Me.Top = 0
   Me.Left = 0
   cmbopcion.AddItem "Operación"
   cmbopcion.AddItem "Tipo"
   cmbopcion.AddItem "Cliente"
   cmbopcion.ListIndex = 0

   Call Nombres

   Call BacCargaGrilla(0)

   Grd.Row = 0: Grd.Col = 0

End Sub

Sub Nombres()

   With Grd
      .cols = 11 '9
      .Rows = 2
      .Row = 0: .Col = 0: .Text = "Numero"
      .Row = 0: .Col = 1: .Text = "Tipo"
      .Row = 0: .Col = 2: .Text = "Rut Cartera"
      .Row = 0: .Col = 3: .Text = "Nombre Cliente"
      .Row = 0: .Col = 4: .Text = "Total Operación"
      .Row = 0: .Col = 5: .Text = "Hora"
      .Row = 0: .Col = 6: .Text = "Usuario"
      .Row = 0: .Col = 7: .Text = "Usuario"
      .Row = 0: .Col = 8: .Text = "Moneda"
      
      .RowHeight(0) = 400

      .ColWidth(0) = 800
      .ColWidth(1) = 500
      .ColWidth(2) = 1000
      .ColWidth(3) = 3050
      .ColWidth(4) = 1800
      .ColWidth(5) = 1000
      .ColWidth(6) = 0
      .ColWidth(7) = 1600
      .ColWidth(8) = 0
      .ColWidth(9) = 0
      .ColWidth(10) = 0
      
      .BackColorFixed = &H808000
      .ForeColorFixed = &HFFFFFF
   End With

End Sub

Private Sub Grd_Click()
   Call Marcar
   Grd.Col = 1
End Sub
Sub Marcar()
   Dim F, c, R, v As Integer
   
   FilaSeleccionada = Grd.RowSel
   
   With Grd
      F = .RowSel
      .FocusRect = flexFocusHeavy
      .Redraw = False
      For R = 1 To .Rows - 1
         For c = 0 To .cols - 1
            .Row = R
            .Col = c
            If R <> F Then
               .BackColorSel = &HC0C0C0
               .BackColorFixed = &H808000
               .ForeColorFixed = &H80000005
               .CellBackColor = &HC0C0C0
               .CellForeColor = vbBlue
               
            Else
               .BackColorSel = &H800000
               .BackColorFixed = &H808000
               .ForeColorFixed = &H80000005
               .CellBackColor = vbBlue
               .CellForeColor = vbWhite
               
            End If
         Next c
      Next R
      .Row = F
      .Col = 0
      .FocusRect = flexFocusLight
      .Redraw = True
   End With
   
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case UCase(Button.Description)
      Case "IMPRIMIR"
         If Grd.TextMatrix(Grd.Row, 1) = "CAP" Then
            Call Func_Apoderados
         Else
            Call Func_Imprimir
         End If
      Case "SALIR"
         Unload Me
   End Select
End Sub

Private Function FUNC_GENERA_ANEXO_PACTOS()
   Let FRM_MNT_APODERADOS.RutBanco = 97023000
   Let FRM_MNT_APODERADOS.CodBanco = 1

   Let FRM_MNT_APODERADOS.RutCliente = Grd.TextMatrix(Grd.RowSel, 9)
   Let FRM_MNT_APODERADOS.CodCliente = Grd.TextMatrix(Grd.RowSel, 10)

   Let FRM_MNT_APODERADOS.NumeroOperacion = Grd.TextMatrix(Grd.RowSel, 0)
   Let FRM_MNT_APODERADOS.TipoOperacion = Grd.TextMatrix(Grd.RowSel, 1)

   Call FRM_MNT_APODERADOS.Show(vbModal)
End Function
