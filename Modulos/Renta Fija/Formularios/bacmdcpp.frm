VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacCPP 
   BackColor       =   &H80000004&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Compras Propias"
   ClientHeight    =   4620
   ClientLeft      =   450
   ClientTop       =   2055
   ClientWidth     =   11025
   DrawWidth       =   2
   BeginProperty Font 
      Name            =   "MS Sans Serif"
      Size            =   8.25
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   ForeColor       =   &H00C0C0C0&
   Icon            =   "bacmdcpp.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form3"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   NegotiateMenus  =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4620
   ScaleWidth      =   11025
   Visible         =   0   'False
   Begin VB.Data Data1 
      Caption         =   "Data1"
      Connect         =   "Access"
      DatabaseName    =   "C:\BTRADER\Mdb\BACTRD.mdb"
      DefaultCursorType=   0  'DefaultCursor
      DefaultType     =   2  'UseODBC
      Exclusive       =   0   'False
      Height          =   345
      Left            =   5760
      Options         =   0
      ReadOnly        =   0   'False
      RecordsetType   =   1  'Dynaset
      RecordSource    =   "MDCP"
      Top             =   4680
      Visible         =   0   'False
      Width           =   2910
   End
   Begin VB.TextBox Text1 
      BackColor       =   &H00800000&
      BorderStyle     =   0  'None
      ForeColor       =   &H00FFFFFF&
      Height          =   315
      Left            =   165
      TabIndex        =   4
      TabStop         =   0   'False
      Top             =   1875
      Visible         =   0   'False
      Width           =   980
   End
   Begin VB.ComboBox cboCarteraSuper 
      BackColor       =   &H00FFFFFF&
      ForeColor       =   &H00800000&
      Height          =   315
      ItemData        =   "bacmdcpp.frx":030A
      Left            =   8415
      List            =   "bacmdcpp.frx":030C
      Sorted          =   -1  'True
      Style           =   2  'Dropdown List
      TabIndex        =   7
      Top             =   660
      Visible         =   0   'False
      Width           =   1815
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   11025
      _ExtentX        =   19447
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
         NumButtons      =   6
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdGrabar"
            Description     =   "Grabar"
            Object.ToolTipText     =   "Grabar Datos"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdEmision"
            Description     =   "Emision"
            Object.ToolTipText     =   "Datos de Emisi?n"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdCortes"
            Description     =   "Cortes"
            Object.ToolTipText     =   "Cortes"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdLimpiar"
            Description     =   "Limpiar"
            Object.ToolTipText     =   "Limpiar Pantalla"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdSalir"
            Description     =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   5
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin BACControles.TXTNumero TEXT2 
      Height          =   315
      Left            =   1830
      TabIndex        =   6
      TabStop         =   0   'False
      Top             =   1875
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
      Text            =   "0"
      Text            =   "0"
      Min             =   "-99"
      Max             =   "999999999999,9999"
      Separator       =   -1  'True
   End
   Begin VB.ComboBox Combo1 
      BackColor       =   &H00FFFFFF&
      ForeColor       =   &H00800000&
      Height          =   315
      ItemData        =   "bacmdcpp.frx":030E
      Left            =   6510
      List            =   "bacmdcpp.frx":031B
      Sorted          =   -1  'True
      Style           =   2  'Dropdown List
      TabIndex        =   5
      Top             =   660
      Visible         =   0   'False
      Width           =   1815
   End
   Begin MSFlexGridLib.MSFlexGrid Table1 
      Height          =   3495
      Left            =   0
      TabIndex        =   3
      Top             =   1125
      Width           =   10935
      _ExtentX        =   19288
      _ExtentY        =   6165
      _Version        =   393216
      Cols            =   13
      FixedCols       =   0
      RowHeightMin    =   315
      BackColor       =   -2147483644
      ForeColor       =   8388608
      BackColorFixed  =   8421376
      ForeColorFixed  =   16777215
      BackColorSel    =   8388608
      ForeColorSel    =   -2147483643
      GridColor       =   4210752
      FocusRect       =   0
   End
   Begin BACControles.TXTNumero TxtTotal 
      Height          =   255
      Left            =   1995
      TabIndex        =   2
      Top             =   660
      Width           =   1575
      _ExtentX        =   2778
      _ExtentY        =   450
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
      Max             =   "99999999999999.99999999999"
      Separator       =   -1  'True
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   2640
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
            Picture         =   "bacmdcpp.frx":0335
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bacmdcpp.frx":0787
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bacmdcpp.frx":0AA1
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bacmdcpp.frx":0DBB
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bacmdcpp.frx":10D5
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin VB.Label Label 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Total Operaci?n"
      ForeColor       =   &H00800000&
      Height          =   240
      Left            =   90
      TabIndex        =   1
      Top             =   645
      Width           =   1695
   End
End
Attribute VB_Name = "BacCPP"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Public bFlagDpx         As Boolean      'Permite solo el ingreso de los dpx
Public bFlagPas         As Boolean      'Permite solo el ingreso de los dpx
Dim SwEmision           As Boolean
Dim FormHandle          As Long
Dim tblTabla            As Recordset
Dim objMonLiq           As New clsCodigos
Dim bufNominal          As Double
Public bajoOk           As Boolean
Dim REGISTRO            As Integer
Dim Tecla               As String
Dim iFlagKeyDown
Dim Monto As Double
Private Function Colocardata1()
   
'   Dim i                As Integer
'   Data1.Recordset.MoveFirst
'   For i = 1 To Table1.Row - 1
'      Data1.Recordset.MoveNext
'   Next i
'      Data1.Recordset.Move Table1.Row
'      If Data1.Recordset.EOF = False Then
'         Data1.Recordset.Move Table1.Row - 1
'      End If
 Dim I As Integer
  Monto = CDbl(Table1.TextMatrix(Table1.Row, 3))
  
  Data1.Recordset.MoveFirst
  For I = 1 To Table1.Row - 1
        Data1.Recordset.MoveNext
  Next I
  
  
End Function

Private Sub Grabar_Pasivo()
Dim NumDocu As Double
NumDocu = CPP_GrabarTx(Me, gsBac_RutC)
If NumDocu <> 0 Then
    MsgBox "Operaci?n N? " & NumDocu & " Grabada con Exito", vbExclamation
    Screen.MousePointer = 0
    Unload BacTrader.ActiveForm
    
End If
End Sub

Private Sub Limpia_grilla()
   Combo1.ListIndex = 2
   cboCarteraSuper.ListIndex = 1
'   Table1.Row = Table1.RowSel
'   Table1.Col = 0
'   If Table1.Text <> "" Then
'      For X = 0 To 12
'         Table1.Col = X
'         Table1.Text = ""
'      Next X
'   End If
   
'   Table1.TextMatrix(Table1.RowSel, 0) = ""
'   Table1.TextMatrix(Table1.RowSel, 1) = ""
   Table1.TextMatrix(Table1.RowSel, 2) = "0.0000"
   Table1.TextMatrix(Table1.RowSel, 3) = "0.0000"
   Table1.TextMatrix(Table1.RowSel, 4) = "0.0000"
   Table1.TextMatrix(Table1.RowSel, 5) = "0.0000"
   Table1.TextMatrix(Table1.RowSel, 6) = Combo1.Text
'   Table1.TextMatrix(Table1.RowSel, 7) = ""
   Table1.TextMatrix(Table1.RowSel, 8) = "0.0000"
   Table1.TextMatrix(Table1.RowSel, 9) = "0"
   Table1.TextMatrix(Table1.RowSel, 10) = "0"
   Table1.TextMatrix(Table1.RowSel, 11) = "0"
   Table1.TextMatrix(Table1.RowSel, 12) = cboCarteraSuper.Text
   
   'Table1.RemoveItem (Table1.RowSel)
End Sub

Private Sub Llena_Grilla()
            
   Table1.TextMatrix(Table1.Row, 1) = Data1.Recordset!TM_NEMMON
   Table1.TextMatrix(Table1.Row, 2) = Format(Data1.Recordset!tm_nominal, "#,###0.0000")
   Table1.TextMatrix(Table1.Row, 3) = Format(Data1.Recordset!TM_TIR, "#,##0.0000")
   Table1.TextMatrix(Table1.Row, 4) = Format(Data1.Recordset!TM_Pvp, "#,##0.0000")
   Table1.TextMatrix(Table1.Row, 5) = Format(Data1.Recordset!TM_MT, "#,###,###,##0" + IIf(bFlagDpx, ".0000", ""))
   Table1.TextMatrix(Table1.Row, 6) = IIf(IsNull(Data1.Recordset!tm_custodia) = True, Data1.Recordset!tm_custodia, "PROPIA")
   Table1.TextMatrix(Table1.Row, 7) = IIf(IsNull(Data1.Recordset!tm_clave_dcv) = True, " ", Data1.Recordset!tm_clave_dcv)
   Table1.TextMatrix(Table1.Row, 8) = Format(Data1.Recordset!tm_tirmcd, "#,##0.0000")
   Table1.TextMatrix(Table1.Row, 9) = Format(Data1.Recordset!tm_pvpmcd, "#,##0.0000")
   Table1.TextMatrix(Table1.Row, 10) = Format(Data1.Recordset!tm_mtmcd, "#,###,###,##0")
   Table1.TextMatrix(Table1.Row, 11) = Format(Val(Data1.Recordset!TM_MT) - Val(Data1.Recordset!tm_mtmcd), "#,###,###,##0")
   If IIf(IsNull(Data1.Recordset!tm_carterasuper) = True, "T", Data1.Recordset!tm_carterasuper) = "T" Then 'INSERTADO29/01/2001
      Table1.TextMatrix(Table1.Row, 12) = "TRANSABLE"
   Else
      Table1.TextMatrix(Table1.Row, 12) = "PERMANENTE"
   End If

End Sub

Private Sub Genera_Grilla()

   Table1.ColWidth(0) = 1400
   Table1.ColWidth(1) = 500
   Table1.ColWidth(2) = 2200
   Table1.ColWidth(3) = 900
   Table1.ColWidth(4) = 900
   Table1.ColWidth(5) = 2200
   Table1.ColWidth(6) = 1200
   Table1.ColWidth(7) = 1200
   Table1.ColWidth(8) = 900
   Table1.ColWidth(9) = 900
   Table1.ColWidth(10) = 2000
   Table1.ColWidth(11) = 0 '1500
   Table1.ColWidth(12) = 2500 'insertado
   cboCarteraSuper.ListIndex = 1
   Table1.TextMatrix(0, 0) = "Serie"
   Table1.TextMatrix(0, 1) = "UM"
   Table1.TextMatrix(0, 2) = "Nominal"
   Table1.TextMatrix(0, 3) = "% Tir"
   Table1.TextMatrix(0, 4) = "% Var"
   Table1.TextMatrix(0, 5) = "Valor Presente"
   Table1.TextMatrix(0, 6) = "Custodia"
   Table1.TextMatrix(0, 7) = "Clave DCV"
   Table1.TextMatrix(0, 8) = "Tir Mer."
   Table1.TextMatrix(0, 9) = "% Vpar M."
   Table1.TextMatrix(0, 10) = "Valor Tasa Presente"
   Table1.TextMatrix(0, 11) = "Utilidad"
   Table1.TextMatrix(0, 12) = "Categor?a Cartera Super" 'insertdo

   Table1.TextMatrix(1, 2) = "0.0000"
   Table1.TextMatrix(1, 3) = "0.0000"
   Table1.TextMatrix(1, 4) = "0.0000"
   Table1.TextMatrix(1, 5) = "0"
   Table1.TextMatrix(1, 8) = "0.0000"
   Table1.TextMatrix(1, 9) = "0.0000"
   Table1.TextMatrix(1, 10) = "0"
   Table1.TextMatrix(1, 11) = "0"
   Table1.TextMatrix(1, 12) = cboCarteraSuper.Text
  
        
    Table1.ColWidth(0) = 1800
    Table1.ColWidth(1) = 0
    Table1.ColWidth(2) = 2400
    Table1.ColWidth(3) = 1000
    Table1.ColWidth(4) = 1000
    Table1.ColWidth(5) = 2400
    Table1.ColWidth(6) = 0
    Table1.ColWidth(7) = 0
    Table1.ColWidth(8) = 0
    Table1.ColWidth(9) = 0
    Table1.ColWidth(10) = 0
    Table1.ColWidth(11) = 0
    Table1.ColWidth(12) = 0 'insertado
    Me.Table1.Width = 9000
    Me.Width = 9010
    Me.Caption = "PASIVOS"
End Sub

Private Sub ChkMoneda(Columna%)

   Dim MonLiq           As Integer
   Dim Mt#
   Dim MtMl#
   Dim TcMl#

   Exit Sub

   Mt# = Data1.Recordset("tm_mt")
   MtMl# = Data1.Recordset("tm_mtml")
   TcMl# = Data1.Recordset("tm_tcml")

   '''    MonLiq = cmbMonLiq.ItemData(cmbMonLiq.ListIndex)
   'Si Moneda de Liquidacion igual a Moneda Local (?Es Soles?)--> Multiplico
   If MonLiq = giMonLoc Then
      If Data1.Recordset("tm_monemi") = MonLiq Then
         TcMl# = 1
         MtMl# = Mt#

      Else
         If Columna = com_VPS Then
            MtMl# = Mt# * TcMl#

         ElseIf Columna = 8 Then
            MtMl# = Mt# * TcMl#

         ElseIf Columna = 9 Then
            Mt# = MtMl# * TcMl#

         Else
            MtMl# = Mt# * TcMl#

         End If

      End If

   Else
      'Divido por el tipo de cambio
      If Data1.Recordset("tm_monemi") = MonLiq Then
         TcMl# = 1
         MtMl# = Mt#

      Else
         If TcMl# = 0 Then
            MtMl# = 0

         Else
            If Columna = 7 Then
               MtMl# = Mt# / TcMl#

            ElseIf Columna = 8 Then
               MtMl# = Mt# / TcMl#

            ElseIf Columna = 9 Then
               Mt# = MtMl# / TcMl#

            Else
               MtMl# = Mt# / TcMl#

            End If

         End If

      End If

   End If

   BacControlWindows 30

   Data1.Recordset.Edit
   Data1.Recordset("tm_mt") = Mt#
   Data1.Recordset("tm_mtml") = MtMl#
   Data1.Recordset("tm_tcml") = TcMl#
   Data1.Recordset.Update

End Sub

Private Sub Func_Cortes()

   Dim Nominal#

   If IsNull(Table1.TextMatrix(Table1.Row, com_NOMINAL)) Then Exit Sub

   Nominal# = CDbl(Table1.TextMatrix(Table1.Row, com_NOMINAL))

   If Nominal# = 0 Then
      Exit Sub

   End If

   If Not Data1.Recordset.RecordCount = 1 Then
      Call Colocardata1

   Else
      Data1.Recordset.MoveFirst

   End If

   Set BacFrmIRF = Me
   BacControlWindows 100
   BacIrfCo.Show 1
   BacControlWindows 100

   If Nominal# <> CDbl(Table1.TextMatrix(Table1.Row, com_NOMINAL)) Then
   Else
      Data1.Recordset.Edit
      Data1.Recordset.Update

   End If

   Table1.SetFocus

End Sub

Private Sub Func_Emision()

   Dim bufFecVen$

   If Not Table1.Rows - 1 = 1 Then
      Call Colocardata1

   Else
      Data1.Recordset.MoveFirst

   End If

   If Trim$(Data1.Recordset("tm_instser")) = "" Then
      Beep
      Exit Sub

   End If

   'Guarda datos en variable global
   With BacDatEmi
      .sInstSer = Data1.Recordset("tm_instser")
      .lRutemi = Data1.Recordset("tm_rutemi")
      .iMonemi = Data1.Recordset("tm_monemi")
      .sFecEmi = Data1.Recordset("tm_fecemi")
      .sFecvct = Data1.Recordset("tm_fecven")
      .dTasEmi = Data1.Recordset("tm_tasemi")
      .iBasemi = Data1.Recordset("tm_basemi")
      .sRefNomi = Data1.Recordset("tm_refnomi")
      .sGeneri = Data1.Recordset("tm_genemi")

   End With


   bufFecVen = BacDatEmi.sFecvct

   BacIrfEm.varPsSeriado = Data1.Recordset("tm_mdse")

   BacIrfEm.Tag = "CP"

   'Pantalla de Datos de Emision
   BacIrfEm.Show 1

   If giAceptar% = True Then
      With BacDatEmi
         Data1.Recordset.Edit
         Data1.Recordset("tm_instser") = .sInstSer
         Data1.Recordset("tm_rutemi") = .lRutemi
         Data1.Recordset("tm_monemi") = .iMonemi
         Data1.Recordset("tm_nemmon") = .sNemo
         Data1.Recordset("tm_fecemi") = .sFecEmi
         Data1.Recordset("tm_fecven") = .sFecvct
         Data1.Recordset("tm_tasemi") = .dTasEmi
         Data1.Recordset("tm_basemi") = .iBasemi
         Data1.Recordset("tm_genemi") = .sGeneri

         If bufFecVen <> BacDatEmi.sFecvct Then
            Data1.Recordset("tm_valmcd") = "N"

         End If

         Data1.Recordset.Update

      End With

   End If

   BacControlWindows 12
   Table1.SetFocus

End Sub

Function valida_custodia() As Boolean

   Dim t As Integer

   valida_custodia = True

   For t = 1 To Table1.Rows - 1
      If Trim(Table1.TextMatrix(t, 6)) = "" Then
         MsgBox "Debe Definir Custodia en Registro " & t
         valida_custodia = False
         Exit Function

       Else
       '  If Trim(Table1.TextMatrix(t, 6)) = "DCV" And Trim(Table1.TextMatrix(t, 7)) = "" Then
      '      MsgBox "Debe Definir Clave DCV en Registro " & t
     '      valida_custodia = False
     '       Exit Function

 '        End If

      End If

   Next t

End Function

Private Sub Func_Limpiar_Pantalla()

   On Error GoTo ErrLimpiar


   Data1.Refresh

   If Data1.Recordset.RecordCount < 1 Then Exit Sub

   With Data1.Recordset
      .MoveFirst

      Do While Not .EOF
         .Delete
         .MoveNext

      Loop

   End With

   Data1.Refresh

   Call CP_Agregar(Hwnd, Data1)

   Table1.Refresh

   TxtTotal.Text = 0

   TxtTotal.Enabled = False
   Toolbar1.Buttons(2).Enabled = False
   Toolbar1.Buttons(3).Enabled = False
   Toolbar1.Buttons(4).Enabled = False

   Table1.SetFocus

   On Error GoTo 0

   Exit Sub

ErrLimpiar:
   On Error GoTo 0

   MsgBox "No se pudo realizar limpieza de pantalla de compras propias", vbExclamation, gsBac_Version
   Exit Sub

End Sub


Private Sub cboCarteraSuper_GotFocus()

    Call PROC_POSI_TEXTO(Table1, cboCarteraSuper)
    
End Sub


Private Sub cboCarteraSuper_KeyDown(KeyCode As Integer, Shift As Integer)

Dim letra1 As String
Dim Indice1 As Integer

If KeyCode <> 13 Then
   letra1 = UCase(Chr(KeyCode))
   
   For Indice1 = 0 To cboCarteraSuper.ListCount - 1
      cboCarteraSuper.ListIndex = Indice1
      If Trim(letra1) = Mid(Trim(cboCarteraSuper.Text), 1, 1) Then
         Exit For
      End If
   Next Indice1
End If

   If KeyCode = 27 Then
      
      cboCarteraSuper.Visible = False
      Table1.SetFocus

   End If

   If KeyCode = 13 Then
   
      If Not Data1.Recordset.RecordCount = 1 Then
         
         Call Colocardata1

      Else
         
         Data1.Recordset.MoveFirst

      End If

      If Table1.Col = com_TCSP Then
         
         Data1.Recordset.Edit

         Select Case cboCarteraSuper.ListIndex 'UCase$(Left(Combo1.Text, 1)) 'Chr(KeyCode))
         Case 0:
            Data1.Recordset("tm_carterasuper") = "P"
            Table1.TextMatrix(Table1.Row, 12) = "PERMANENTE"
            KeyCode = 13

         Case 1:
            Data1.Recordset("tm_carterasuper") = "T"
            Table1.TextMatrix(Table1.Row, 12) = "TRANSABLE"
            KeyCode = 13

         Case Else
            KeyCode = 0

         End Select

         Data1.Recordset.Update
         cboCarteraSuper.Visible = False
      End If
   End If
End Sub
Private Sub cboCarteraSuper_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
       Table1.Col = 12
       Table1.ColSel = 12
    End If
End Sub
Private Sub cboCarteraSuper_LostFocus()
   cboCarteraSuper.Visible = False
   Table1.TextMatrix(Table1.Row, 12) = cboCarteraSuper.Text
   'Table1.SetFocus
End Sub

Private Sub Combo1_Click()
   Table1.Col = 6
   Table1.Text = Combo1.Text
   'Combo1.Visible = False
   If Table1.Col = com_CUST Then
      If Mid(Table1.TextMatrix(Table1.Row, com_CUST), 1, 3) = "DCV" Then
         'Table1.TextMatrix(Table1.Row, com_CDCV) = FUNC_GENERA_CLAVE_DCV
         'Table1.Col = com_CDCV
      Else
         Table1.TextMatrix(Table1.Row, com_CDCV) = " "
      End If
   End If


End Sub

Private Sub Combo1_GotFocus()

   Call PROC_POSI_TEXTO(Table1, Combo1)

End Sub

Private Sub Combo1_KeyDown(KeyCode As Integer, Shift As Integer)
Dim Letra As String
Dim INDICE As Integer
If KeyCode = 37 Or KeyCode = 38 Or KeyCode = 39 Or KeyCode = 40 Then
   Exit Sub
End If

If KeyCode = 13 Then
   
      '''''''''''''''''''

      If Not Data1.Recordset.RecordCount = 1 Then
         Call Colocardata1

      Else
         Data1.Recordset.MoveFirst

      End If

      If Table1.Col = com_CUST Then
         If Data1.Recordset.EOF = False Then
            Data1.Recordset.Edit
         Else
            Data1.Recordset.MoveFirst
            Data1.Recordset.Edit
         End If
         Select Case Combo1.ListIndex 'UCase$(Left(Combo1.Text, 1)) 'Chr(KeyCode))
         Case 0:
            Data1.Recordset("tm_custodia") = "CLIENTE"
            Data1.Recordset("tm_clave_dcv") = " "
            Table1.TextMatrix(Table1.Row, 6) = "CLIENTE"
            Table1.TextMatrix(Table1.Row, 7) = ""
            KeyCode = 13

         Case "1":
            Data1.Recordset("tm_custodia") = "DCV"
            'Data1.Recordset("tm_clave_dcv") = FUNC_GENERA_CLAVE_DCV
            Table1.TextMatrix(Table1.Row, 6) = "DCV"
            'Table1.TextMatrix(Table1.Row, 7) = Data1.Recordset("tm_clave_dcv")
            KeyCode = 13

         Case "2":
            Data1.Recordset("tm_custodia") = "PROPIA"
            Data1.Recordset("tm_clave_dcv") = " "
            Table1.TextMatrix(Table1.Row, 6) = "PROPIA"
            Table1.TextMatrix(Table1.Row, 7) = ""
            KeyCode = 13

         Case Else
            KeyCode = 0

         End Select

         Data1.Recordset.Update
         Combo1.Visible = False

      End If
         Combo1.Visible = False
   End If

   If KeyCode = 27 Then
      Combo1.Visible = False
      Table1.SetFocus
   End If


If KeyCode <> 13 Then
   Letra = UCase(Chr(KeyCode))
   For INDICE = 0 To Combo1.ListCount - 1
      Combo1.ListIndex = INDICE
      If Trim(Letra) = Mid(Trim(Combo1.Text), 1, 1) Then
         Exit For
      End If
   Next INDICE
End If

   
End Sub

Private Sub Combo1_KeyPress(KeyAscii As Integer)
    
    If KeyAscii = 13 Then
        If Table1.ColSel + 1 < Table1.cols Then
            Table1.Col = Table1.Col + 1
            Table1.ColSel = Table1.Col
        End If
    End If
    
End Sub

Private Sub Combo1_LostFocus()
   On Error Resume Next
   Combo1.Visible = False
   Table1.TextMatrix(Table1.Row, 6) = Combo1.Text
   Table1.SetFocus

End Sub


Private Sub data1_Error(DataErr As Integer, Response As Integer)

   MsgBox "ERROR POR DATA CONTROL : " & DataErr, vbExclamation, "Mensaje"

End Sub

Private Sub Form_Activate()
   
   Me.Tag = "CP"

   'Refresca Data Control
   'Setear mouse pointer como reloj.-
   Screen.MousePointer = vbHourglass

   'Recuperar mouse pointer.
   Screen.MousePointer = vbDefault
   Table1.SetFocus

End Sub

Private Sub Form_Deactivate()

   Screen.MousePointer = vbHourglass
   Screen.MousePointer = vbDefault

End Sub

Private Sub Form_Load()
   
   Dim Datos()
   Dim I       As Integer
   
   On Error GoTo BacErrHnd

   Me.Top = 0
   Me.Left = 0
   
   Screen.MousePointer = vbHourglass
    
   FormHandle = Me.Hwnd

   Call CP_IniciarTx(FormHandle, Data1)
    
   If Not Bac_Sql_Execute("SP_CATEGORIA_CARTERASUPER") Then
      
      Exit Sub
      
   End If
    
    cboCarteraSuper.Visible = False
    cboCarteraSuper.Clear
    
    Do While Bac_SQL_Fetch(Datos())
        cboCarteraSuper.AddItem Datos(1)
    Loop
   
    iFlagKeyDown = True
    gsBac_Valmon = 1

    Call objMonLiq.LeerCodigos(22)

    Screen.MousePointer = vbDefault
   
    TxtTotal.Enabled = False
    Toolbar1.Buttons(3).Enabled = False
    Toolbar1.Buttons(4).Enabled = False
    Toolbar1.Buttons(2).Enabled = False
    Data1.Refresh

    Call Genera_Grilla
    Call Limpia_grilla
    Table1.Col = 0
    On Error GoTo 0

    Exit Sub

BacErrHnd:
    On Error GoTo 0
    Resume

End Sub

Private Sub Form_Resize()

   On Error GoTo BacErrHnd

   Dim x!, Y!, J%
   Dim lScaleWidth&, lScaleHeight&, lPosIni&

   ' Cuando la ventana es minimizada, se ignora la rutina.-
   If Me.WindowState = 1 Then
      ' Pinta borde del icono.-
      x = Me.Width
      Y = Me.Height

      For J% = 1 To 15
         Line (0, 0)-(x, 0), QBColor(Int(Rnd * 15))
         Line (x, 0)-(x, Y), QBColor(Int(Rnd * 15))
         Line (x, Y)-(0, Y), QBColor(Int(Rnd * 15))
         Line (0, Y)-(0, 0), QBColor(Int(Rnd * 15))
         DoEvents

      Next

      On Error GoTo 0
      Exit Sub

   End If

   ' Escalas de medida de la ventana.-
   lScaleWidth& = Me.ScaleWidth
   lScaleHeight& = Me.ScaleHeight

   ' Resize la ventana customizado.-
   If Me.WindowState <> 1 And Me.Width > 400 And Me.Height > 1600 Then
      Table1.Width = Me.Width - 300
      Table1.Height = Me.Height - 1500

   End If

   On Error GoTo 0
   Exit Sub

BacErrHnd:
   On Error GoTo 0
   Resume

End Sub

Private Sub Form_Unload(Cancel As Integer)

   ' Elimna registros asociados a la CP.-
   Call CP_BorrarTx(Me.Hwnd)
 
   ' Desactivar botones asociados a la operaci?n.-
   BacHabilitaBotones ""

   Set objMonLiq = Nothing

End Sub

Private Sub SSRibbon1_Click(Value As Integer)

    Table1.ColWidth(1) = IIf(Value = True, 0, 500)

End Sub

Private Sub Table1_DblClick()
   
   Dim x  As Integer
   
   If Table1.Col = 6 Then
      For x = 0 To Combo1.ListCount - 1
         Combo1.ListIndex = x
         If Combo1 = Table1.TextMatrix(Table1.RowSel, Table1.ColSel) Then
            Exit For
         End If
      Next
      Combo1.Visible = True
      Combo1.SetFocus

   End If
   
   If Table1.Col = 12 Then
      cboCarteraSuper.Visible = True
      cboCarteraSuper.SetFocus
   End If

End Sub

Private Sub Table1_GotFocus()

   Table1.CellBackColor = &H808000: Text1.Font.bold = True

End Sub

Private Sub Table1_KeyDown(KeyCode As Integer, Shift As Integer)

   On Error GoTo KeyDownError

   Dim aux&
   Dim letra1 As String
   Dim Indice1 As Integer
   
   If KeyCode = vbKeyInsert Then

   Else
      If Table1.Col = 12 Then
            letra1 = UCase(Chr(KeyCode))
            For Indice1 = 0 To cboCarteraSuper.ListCount - 1
               cboCarteraSuper.ListIndex = Indice1
               If Trim(letra1) = Mid(Trim(cboCarteraSuper.Text), 1, 1) Then
                  'cboCarteraSuper.SetFocus
                  Exit For
               End If
            Next Indice1
          Exit Sub
      End If
   End If
   If iFlagKeyDown = False Then
      On Error GoTo 0
      Exit Sub

   End If

   If KeyCode = vbKeyInsert Then
   
      aux& = Table1.Row
      
      Table1.SetFocus 'probando1
      BacControlWindows 60
       
      Bac_SendKey vbKeyHome
      
      'ACAMODIF
      If Trim$(Table1.TextMatrix(Table1.Row, 0)) = "" Then
         MsgBox "Ingrese serie antes de insertar otra Fila", vbInformation, TITSISTEMA
         Table1.SetFocus
         Exit Sub
      End If
      'ACAMODIF

      ' VB+- 09/06/2000  se valida que no se pueda agregar otro registro si no tiene definido custodia
      If Trim$(Table1.TextMatrix(Table1.Row, com_CUST)) = "" Then
         MsgBox "Antes de agregar otro instrumento" & vbCrLf & vbCrLf & "debe definir custodia para instrumento", vbExclamation, TITSISTEMA
         Table1.SetFocus
         On Error GoTo 0
         Exit Sub

      Else
         Data1.Refresh

         If Data1.Recordset("tm_monemi") = 13 Then
            MsgBox "No se puede ingresar mas de un papel en moneda <<Dolar/Dolar>>", vbExclamation, TITSISTEMA
            On Error GoTo 0
            Exit Sub

         End If

         BacControlWindows 60

         If Trim$(Table1.TextMatrix(Table1.Row, 1) <> "" And Table1.TextMatrix(Table1.Row, com_TIR) <> 0 And Val(Table1.TextMatrix(Table1.Row, com_VPS))) <> 0 Then
            BacControlWindows 60
            Call CP_Agregar(Hwnd, Data1)
            TxtTotal.Enabled = False
            Toolbar1.Buttons(2).Enabled = False
            Table1.Col = com_SERIE

         Else
            Table1.Row = aux&

         End If

      End If

      Table1.Rows = Table1.Rows + 1
      Table1.Row = Table1.Rows - 1
      
      Call Limpia_grilla
      
      Table1.Col = 0
      Table1.ColSel = 0
   
   ElseIf KeyCode = vbKeyUp Then
      If Trim$(Table1.TextMatrix(Table1.Row, com_SERIE)) = "" Then
         BacControlWindows 60

         If Data1.Recordset.RecordCount > 1 Then
            Call CP_Eliminar(Data1)
            Data1.Refresh
            TxtTotal.Text = CP_SumarTotal(FormHandle)

            ' VB+ 02/03/2000 es para habilitar o desabilitar botones
            ' ===========================================================
            If Len(Data1.Recordset("tm_instser")) <> 0 And Toolbar1.Buttons(3).Enabled = False Then
               Toolbar1.Buttons(3).Enabled = True

            End If

            If Data1.Recordset("tm_nominal") <> 0 And Toolbar1.Buttons(4).Enabled = False Then
               Toolbar1.Buttons(4).Enabled = True

            End If

            If Data1.Recordset("tm_mt") <> 0 Then
               TxtTotal.Enabled = True
               Toolbar1.Buttons(2).Enabled = True

            Else
               TxtTotal.Enabled = False
               Toolbar1.Buttons(2).Enabled = False

            End If
            ' ===========================================================
            ' VB- 02/03/2000

         End If

      End If

   ElseIf KeyCode = vbKeyDelete Then
      If Not Data1.Recordset.RecordCount = 1 Then
         Call Colocardata1

      Else
         Data1.Recordset.MoveFirst

      End If

      Call CP_Eliminar(Data1)

      If Not Table1.Rows = 2 Then
         Table1.RemoveItem Table1.Row
         Table1.Col = 0
         Table1.ColSel = 0

      Else
         Table1.TextMatrix(1, 0) = ""
         Table1.TextMatrix(1, 1) = ""
         Limpia_grilla

      End If

      
      Table1.Refresh
      Data1.Refresh
      TxtTotal.Text = CP_SumarTotal(FormHandle)

      ' VB+ 02/03/2000 es para habilitar o desabilitar botones
      ' ===========================================================
      If Len(Data1.Recordset("tm_instser")) <> 0 And Toolbar1.Buttons(3).Enabled = False Then
         Toolbar1.Buttons(3).Enabled = True

      End If

      If Data1.Recordset("tm_nominal") <> 0 And Toolbar1.Buttons(4).Enabled = False Then
         Toolbar1.Buttons(4).Enabled = True

      End If

      If Data1.Recordset("tm_mt") <> 0 Then
         TxtTotal.Enabled = True
         Toolbar1.Buttons(2).Enabled = True

      Else
         TxtTotal.Enabled = False
         Toolbar1.Buttons(2).Enabled = False

      End If
      ' ===========================================================
      ' VB- 02/03/2000

   End If

   On Error GoTo 0
   Exit Sub

KeyDownError:
   On Error GoTo 0
   MsgBox "Problemas en tabla de ingreso de datos: " & err.Description, vbExclamation, gsBac_Version
   Data1.Refresh
   Exit Sub

End Sub

Private Sub Table1_KeyPress(KeyAscii As Integer)
   Dim x
   Dim INDICE, Indice1 As Integer
   Dim Letra, letra1 As String
      
   If Table1.Col = 0 Then
      BacControlWindows 100
      Text1.Visible = True

      If KeyAscii <> 13 Then
         Text1.Text = UCase(Chr(KeyAscii))

      Else
         Text1.Text = Table1.TextMatrix(Table1.Row, Table1.Col)

      End If

      Text1.MaxLength = 12
      Text1.SetFocus
      BacControlWindows 100
      Exit Sub

   End If

   If Table1.Col = 7 And Trim(Table1.TextMatrix(Table1.Row, 6)) = "DCV" Then 'Or Table1.Col = 0 Then
      BacControlWindows 100
      Text1.Text = Table1.TextMatrix(Table1.Row, Table1.Col)
      Text1.Visible = True
      Text1.MaxLength = 9

      If KeyAscii <> 13 Then
         Text1.Text = UCase(Chr(KeyAscii))

      Else
         Text1.Text = Table1.TextMatrix(Table1.Row, Table1.Col)

      End If

      Text1.SetFocus
      BacControlWindows 100
      Exit Sub

   End If

   If Table1.Col = 6 Then
         If KeyAscii = 80 Or KeyAscii = 112 Then
         Combo1.ListIndex = 2

      ElseIf KeyAscii = 68 Or KeyAscii = 100 Then
         Combo1.ListIndex = 1

      ElseIf KeyAscii = 67 Or KeyAscii = 99 Then
         Combo1.ListIndex = 0
      End If

      If UCase(Chr(KeyAscii)) = "C" Or UCase(Chr(KeyAscii)) = "D" Or UCase(Chr(KeyAscii)) = "P" Or KeyAscii = 13 Then
         Table1.Col = 6
         Call PROC_POSI_TEXTO(Table1, Combo1)
         Combo1.Visible = True
         Combo1.SetFocus
      End If
      
      BacControlWindows 100

      Exit Sub
   End If
   
   
   If Table1.Col = 12 Then
   letra1 = UCase(Chr(KeyAscii))
   
   For Indice1 = 0 To cboCarteraSuper.ListCount - 1
      cboCarteraSuper.ListIndex = Indice1
      If Trim(letra1) = Mid(Trim(cboCarteraSuper.Text), 1, 1) Then
         Exit For
      End If
   Next Indice1

      
'      For X = 0 To cboCarteraSuper.ListCount - 1
'        cboCarteraSuper.ListIndex = X
'        If Table1.TextMatrix(Table1.RowSel, 12) = cboCarteraSuper Then
'            Exit For
'        End If
'      Next
      cboCarteraSuper.Visible = True
      cboCarteraSuper.SetFocus
      Exit Sub
   End If
   
   
   If Table1.Col < 6 And Table1.Col <> 1 And Table1.Col <> 0 Then
      TEXT2.Text = BacCtrlTransMonto(CDbl(Table1.TextMatrix(Table1.Row, Table1.Col)))
       TEXT2.CantidadDecimales = 4
       TEXT2.Visible = True
      

      If KeyAscii > 47 And KeyAscii < 58 Then TEXT2.Text = Chr(KeyAscii)

      
      TEXT2.SetFocus

      Exit Sub

   End If

   BacToUCase KeyAscii

   If Table1.Col = com_CDCV Then
      If IsNull(Table1.TextMatrix(Table1.Row, com_CUST)) Or Trim$(Table1.TextMatrix(Table1.Row, com_CUST)) <> "DCV" Then
         KeyAscii = 0

      End If

   End If

   If Table1.Col = com_CUST Then
      If Not Data1.Recordset.RecordCount = 1 Then
         Call Colocardata1

      Else
         Data1.Recordset.MoveFirst

      End If

      Data1.Recordset.Edit

      Select Case UCase$(Chr(KeyAscii))
      Case "C":
         Data1.Recordset("tm_custodia") = "CLIENTE"
         Data1.Recordset("tm_clave_dcv") = " "
         KeyAscii = 13

      Case "D":
         If Not IsNull(Data1.Recordset("tm_custodia")) Then
            If Trim$(Data1.Recordset("tm_custodia")) <> "DCV" Then
               Data1.Recordset("tm_custodia") = "DCV"
               'Data1.Recordset("tm_clave_dcv") = FUNC_GENERA_CLAVE_DCV
               KeyAscii = 13

            Else
               KeyAscii = 0

            End If

         Else
            Data1.Recordset("tm_custodia") = "DCV"
            'Data1.Recordset("tm_clave_dcv") = FUNC_GENERA_CLAVE_DCV
            KeyAscii = 13

         End If

      Case "P":
         Data1.Recordset("tm_custodia") = "PROPIA"
         Data1.Recordset("tm_clave_dcv") = " "
         KeyAscii = 13

      Case Else
         KeyAscii = 0

      End Select

      Data1.Recordset.Update

   End If

   If Table1.Col > com_SERIE Then
      If Len(Trim$(Table1.TextMatrix(Table1.Row, com_SERIE))) = 0 Then
         KeyAscii = 0

      End If

   End If

   
   If KeyAscii = 27 Then iFlagKeyDown = True

   Select Case Table1.Col
   Case com_NOMINAL, com_VPS
      If KeyAscii <> 27 Then
         If Not iFlagKeyDown Then
            KeyAscii = BacPunto(Table1, KeyAscii, 12, 4)

         End If

         KeyAscii = BACValIngNumGrid(KeyAscii)

      End If

   Case com_TIR, com_VPAR
      If KeyAscii <> 27 Then
         If Not iFlagKeyDown Then
            KeyAscii = BacPunto(Table1, KeyAscii, 3, 4)

         End If

         KeyAscii = BACValIngNumGrid(KeyAscii)

      End If

   End Select

End Sub

Private Sub Table1_LeaveCell()

   Table1.CellBackColor = &HC0C0C0

End Sub

Private Sub Table1_Scroll()

   Text1_LostFocus
   Text2_LostFocus
'   Combo1_LostFocus
'   cboCarteraSuper_LostFocus

End Sub

Private Sub Table1_SelChange()

   Table1.CellBackColor = &H808000
   Text1.Font.bold = True

End Sub

Private Sub Text1_GotFocus()

   Call PROC_POSI_TEXTO(Table1, Text1)
   Text1.SelStart = Len(Text1)

End Sub
Private Sub Text1_KeyDown(KeyCode As Integer, Shift As Integer)

   On Error GoTo ExitEditError

   Dim Cota_SUP         As Double
   Dim Cota_INF         As Double
   Dim Porcentaje       As Double
   Dim Nominal          As Double
   Dim Col              As Integer
   Dim Value            As String
   Dim CorteMin#
   Dim iOK%
   Dim Columna%
   Dim LeeEmi$
   If KeyCode = 27 Then
      Text1.Text = ""
      Text1.Visible = False

   End If
   tipo = "CPP"
   If Table1.Col = com_NOMINAL Then
      bufNominal = Table1.TextMatrix(Table1.Row, 4)

   End If
    
   If KeyCode = 13 Then
      If Table1.Col = 0 Then
        
        If Not bFlagDpx Then
             Table1.ColWidth(3) = 900
             If Text1.Text = "FMUTUO" Then
                Table1.ColWidth(3) = 1800
             ElseIf Mid$(Text1.Text, 1, 3) = "DPX" Then
                MsgBox "PAPEL NO VALIDO", vbExclamation, Me.Caption
                Text1.SetFocus
                Exit Sub
             End If
        Else
             If Mid$(Text1.Text, 1, 3) <> "DPX" Then
                MsgBox "PAPEL NO VALIDO", vbExclamation, Me.Caption
                Text1.SetFocus
                Exit Sub
             End If
      
        End If
      End If
      If Not Data1.Recordset.RecordCount = 1 Then
         Call Colocardata1
      Else
         Data1.Recordset.MoveFirst
      End If
      If Table1.Col = 7 Or Table1.Col = 0 Then
         Value = Text1.Text
      Else
         Value = Text2.Text
      End If
      If Table1.Col = 7 Then
         Data1.Recordset.Edit
         Data1.Recordset!tm_clave_dcv = Text1.Text
         Data1.Recordset.Update
      End If
      Col% = Table1.Col
      If (Col% > com_UM And Col% < com_CUST) And (Col% > com_CDCV And Col% < com_UTIL) Then
         If IsNumeric(Value) = False Then
            iFlagKeyDown = False
            Text1.Visible = False
            Table1.SetFocus
            Exit Sub

         End If

      End If

      Select Case Col%
      Case com_SERIE:
         iOK = CP_ChkSerie(Value, Data1)
         If iOK = False Then
            Exit Sub
            iFlagKeyDown = False

         Else
                If Not Data1.Recordset!tm_codigo = 15 Then
                    MsgBox "Ingreso Pasivos solo Bonos", vbCritical
                    Table1.TextMatrix(Table1.Row, Table1.Col) = ""
                    Limpia_grilla
                    Exit Sub
                    iFlagKeyDown = False
                    
                Else
                    Data1.Recordset.Edit
                    Data1.Recordset!TM_INSTSER = Text1.Text
                    Data1.Recordset!tm_custodia = "PROPIA"
                    Table1.TextMatrix(Table1.Row, 7) = "PROPIA"
                    Data1.Recordset.Update
                    Limpia_grilla
                End If
         End If
      Case com_NOMINAL:
         If CDbl(Value) < 0 Or Len(Value) > 16 Then
            MsgBox "Nominal ingresado NO es valido.", 16, gsBac_Version
            Value = 0
            Exit Sub
         End If
         CorteMin# = Data1.Recordset("tm_cortemin")

         If Not IsNumeric(Value) Then Value = 0

         Nominal# = CDbl(Value)

         If CO_ChkCortes((Nominal#), CorteMin#) = False Then
            TEXT2.Text = CorteMin#
            Table1.SetFocus
         End If

      Case com_VPS:
         If CDbl(Value) < 0 Or Len(Value) > 16 Then
            MsgBox "Valor presente ingresado NO es valido.", 16, gsBac_Version
            Value = 0
            Table1.SetFocus
            Exit Sub

         End If

      End Select

      If Table1.Col = 0 Or Table1.Col = 7 Then
         Table1.TextMatrix(Table1.Row, Table1.Col) = Text1.Text

      Else
         Table1.TextMatrix(Table1.Row, Table1.Col) = Format(TEXT2.Text, "#,##0.0000")

      End If

      Columna = Table1.Col
      Data1.Recordset.Edit

      If Columna = com_SERIE Then
         LeeEmi$ = Data1.Recordset("tm_leeemi")
         SwEmision = True

         If InStr("S", LeeEmi$) Then
            SwEmision = False
            Call Func_Emision

         End If

         Table1.Col = com_NOMINAL

      ElseIf Columna = com_NOMINAL Then
          Data1.Recordset("tm_nominal") = Text2.Text
          
         If Trim(Data1.Recordset!TM_INSTSER) = "FMUTUO" Then
            Data1.Recordset!TM_MT = Data1.Recordset!TM_TIR * CDbl(Text2)
            Data1.Recordset.Update
         Else
             Data1.Recordset.Update
             If Val(Table1.TextMatrix(Table1.Row, com_TIR)) <> 0 Then
                Call CPCI_Valorizar(2, Data1, gsBac_Fecp)
    
             ElseIf Val(Table1.TextMatrix(Table1.Row, com_VPAR)) <> 0 Then
                Call CPCI_Valorizar(1, Data1, gsBac_Fecp)
    
             ElseIf Val(Table1.TextMatrix(Table1.Row, com_VPS)) <> 0 Then
                Call CPCI_Valorizar(3, Data1, gsBac_Fecp)
    
             End If
    
             'Si cambia el nominal Elimino los cortes y valorizo a mercado
             If BacFormatoSQL(bufNominal) <> BacFormatoSQL(Table1.TextMatrix(Table1.Row, com_NOMINAL)) Then
                Call CO_EliminarCortesMDB(FormHandle, Data1.Recordset("tm_correlativo"))
            
             End If
        End If
      ElseIf Columna = com_TIR Then
      
        If Trim(Data1.Recordset!TM_INSTSER) = "FMUTUO" Then
               Data1.Recordset!TM_TIR = Text2.Text
              If Data1.Recordset!TM_MT <> 0 Then
               Data1.Recordset!tm_nominal = Data1.Recordset!TM_MT / CDbl(Text2.Text)
              End If
              If Data1.Recordset!tm_nominal <> 0 Then
               Data1.Recordset!TM_MT = Data1.Recordset!tm_nominal * CDbl(Text2.Text)
              End If
   
            Data1.Recordset.Update
        Else
         Data1.Recordset!TM_TIR = Text2.Text
         Data1.Recordset.Update
         Call CPCI_Valorizar(2, Data1, gsBac_Fecp)
        End If
        
      ElseIf Columna = com_VPAR Then
        If Trim(Data1.Recordset!TM_INSTSER) = "FMUTUO" Then
            Data1.Recordset!TM_Pvp = 0
            Data1.Recordset.Update
        Else
            Data1.Recordset!TM_Pvp = Text2.Text
             Data1.Recordset.Update
            Call CPCI_Valorizar(1, Data1, gsBac_Fecp)
        End If
         
      ElseIf Columna = com_VPS Then
       If Trim(Data1.Recordset!TM_INSTSER) = "FMUTUO" Then
            'If Data1.Recordset!TM_nominal = 0 Then
 '              Data1.Recordset!tm_tir = Val(TEXT2.Text) / Data1.Recordset!TM_nominal
               Data1.Recordset!tm_nominal = Val(Text2.Text) / Data1.Recordset!TM_TIR
            'Else
             
            'End If
       
            'Data1.Recordset!TM_TIR = Val(Text2.Text) / Data1.Recordset!TM_nominal
            
            Data1.Recordset!TM_MT = Val(Text2.Text)
            Data1.Recordset.Update
       Else
        
         Data1.Recordset!TM_MT = Text2.Text
         Data1.Recordset.Update
         Call CPCI_Valorizar(3, Data1, gsBac_Fecp)
       End If
      End If

      'If Columna = com_TIR Or Columna = com_VPAR Or Columna = com_VPS Then
      '
      'End If

      BacControlWindows 20

      If Columna > com_UM And Columna < com_CUST Then
         Call ChkMoneda(Columna%)
         BacControlWindows 12
         TxtTotal.Text = BacCtrlTransMonto(CP_SumarTotal(FormHandle))

      End If

      iFlagKeyDown = True

      If Columna = com_SERIE Then
         Table1.Col = Columna + 2

      ElseIf Columna = com_NOMINAL Then
         Table1.Col = Columna + 1

      ElseIf Columna = com_TIR Or Columna = com_VPAR Or Columna = com_VPS Then
         Table1.Col = com_CUST
        'Toolbar1.Buttons(1).Enabled = True
      End If


      If Len(Data1.Recordset("tm_instser")) <> 0 And Toolbar1.Buttons(3).Enabled = False Then
         Toolbar1.Buttons(3).Enabled = True

      End If

      If Data1.Recordset("tm_nominal") <> 0 And Toolbar1.Buttons(4).Enabled = False Then
         Toolbar1.Buttons(4).Enabled = True

      End If

      If Data1.Recordset("tm_mt") <> 0 Then
         TxtTotal.Enabled = True
         Toolbar1.Buttons(2).Enabled = True

      Else
         TxtTotal.Enabled = False
         Toolbar1.Buttons(2).Enabled = False

      End If

      Text1.Text = ""
      Text1.Visible = False
      TEXT2.Text = 0
      TEXT2.Visible = False

      If Table1.Col <> 2 Then
         Llena_Grilla

      Else
         Table1.TextMatrix(Table1.Row, 1) = Data1.Recordset!TM_NEMMON
         Limpia_grilla

      End If

   End If

   On Error GoTo 0

   Exit Sub

ExitEditError:
   On Error GoTo 0
   iFlagKeyDown = True
    Table1.Row = Table1.Rows - 1
    Table1.TextMatrix(Table1.Row, 3) = Format(Monto, "###,###,###,##0.0000")
    Text1.Visible = False
   Exit Sub
End Sub
Private Sub Text1_KeyPress(KeyAscii As Integer)

   KeyAscii = Asc(UCase(Chr(KeyAscii)))
   SwEmision = True

End Sub

Private Sub Text1_LostFocus()

   Text1.Text = ""
   Text1.Visible = False

   If SwEmision Then
      Table1.SetFocus

   End If

End Sub

Private Sub Text2_GotFocus()

   Call PROC_POSI_TEXTO(Table1, TEXT2)
    
   If Table1.Col = 5 Then
        TEXT2.SelStart = Len(TEXT2.Text)
   Else
   
        Text2.SelStart = Len(Text2.Text) - 5
   End If

End Sub

Private Sub Text2_KeyDown(KeyCode As Integer, Shift As Integer)

   If KeyCode = 27 Then
      Text2.Text = ""
      Text2.Visible = False

   End If

   If KeyCode = 13 Then
   
      Table1.TextMatrix(Table1.RowSel, Table1.ColSel) = TEXT2.Text
      
      Text2.Visible = False
      
      Call Text2_LostFocus
      Call Text1_KeyDown(13, 1)

   End If

End Sub

Private Sub Text2_LostFocus()
   On Error Resume Next
   
   'Text2.Text = 0
   TEXT2.Visible = False
   Table1.SetFocus

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

   Select Case UCase(Button.Description)
   Case "GRABAR"
   
      Screen.MousePointer = vbHourglass

      Table1.Row = 1
      BacIrfGr.proMoneda = IIf(Trim$(Table1.TextMatrix(Table1.Row, 2)) = gsBac_Dolar, gsBac_Dolar, "$$")
      BacIrfGr.proMtoOper = TxtTotal.Text
      BacIrfGr.proHwnd = Hwnd
     
            Call Grabar_Pasivo

          Table1.SetFocus
     
          
   Case "EMISION"
      Call Func_Emision

   Case "CORTES"
      Call Func_Cortes

   Case "LIMPIAR"
      
      Call Func_Limpiar_Pantalla
      Call Limpia_grilla
      
'      Table1.TextMatrix(1, 0) = ""
'      Table1.TextMatrix(1, 1) = ""
'      Table1.Col = 0
      
      If Table1.Rows > 2 Then
         Table1.RemoveItem Table1.Row
      Else
         Table1.TextMatrix(1, 0) = ""
         Table1.TextMatrix(1, 1) = ""
      End If
      
      

   Case "SALIR"
      Unload Me

   End Select

End Sub

Private Sub TxtTotal_GotFocus()

   TxtTotal.Tag = TxtTotal.Text

End Sub

Private Sub TxtTotal_KeyDown(KeyCode As Integer, Shift As Integer)

   If KeyCode = 13 Then
      Tecla = "13"

   Else
      Tecla = ""

   End If

End Sub

Private Sub TxtTotal_KeyPress(KeyAscii As Integer)

   If KeyAscii = 27 Then
      TxtTotal.Text = TxtTotal.Tag
      KeyAscii = 13

   End If

   If KeyAscii% = vbKeyReturn Then
      Bac_SendKey vbKeyTab

   End If
   

End Sub

Private Sub TxtTotal_LostFocus()

   Dim I                As Integer
   Dim dTotalNuevo#
   Dim dTotalActual#

   If TxtTotal.Tag <> TxtTotal.Text Then
      dTotalActual# = Val(TxtTotal.Tag)
      dTotalNuevo# = Val(TxtTotal.Text)

      Call CPCI_ValorizarTotal(Data1, dTotalNuevo#, dTotalActual#)

      Data1.Refresh

      For I = 1 To Table1.Rows - 1
         Table1.Row = I

         Call Llena_Grilla

         If Not Data1.Recordset.EOF Then
            Data1.Recordset.MoveNext

         End If

      Next I

      Table1.Refresh

   End If

'   If Tecla = "13" Then
'      TxtTotal.SetFocus
'
'   End If

End Sub

