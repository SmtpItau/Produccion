VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "Mscomctl.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "threed32.ocx"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{989C9190-EDF5-45A8-AB6C-98E6EF0384D7}#1.0#0"; "Bac_Controles_Pas.ocx"
Begin VB.Form BacMntVe 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Mantención Valores De Monedas Extranjeras"
   ClientHeight    =   4245
   ClientLeft      =   2235
   ClientTop       =   4080
   ClientWidth     =   7320
   Icon            =   "Bacmntve.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4245
   ScaleWidth      =   7320
   ShowInTaskbar   =   0   'False
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   4020
      Top             =   0
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   24
      ImageHeight     =   24
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   4
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmntve.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmntve.frx":11E4
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmntve.frx":20BE
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmntve.frx":2F98
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   480
      Left            =   0
      TabIndex        =   5
      Top             =   0
      Width           =   7320
      _ExtentX        =   12912
      _ExtentY        =   847
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Limpiar"
            Description     =   "Buscar"
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Grabar"
            Description     =   "Grabar"
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Buscar"
            Description     =   "Limpiar"
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Description     =   "Salir"
            Object.ToolTipText     =   "Cerrar Ventana"
            ImageIndex      =   4
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin Threed.SSFrame Frame 
      Height          =   2925
      Index           =   0
      Left            =   105
      TabIndex        =   6
      Top             =   1110
      Width           =   2175
      _Version        =   65536
      _ExtentX        =   3836
      _ExtentY        =   5159
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
      Begin VB.ComboBox cmbMes 
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
         Left            =   105
         Style           =   2  'Dropdown List
         TabIndex        =   2
         Top             =   555
         Width           =   1890
      End
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
         Left            =   105
         Style           =   2  'Dropdown List
         TabIndex        =   3
         Top             =   1320
         Width           =   1275
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
         Height          =   315
         Index           =   92
         Left            =   135
         TabIndex        =   8
         Top             =   270
         Width           =   795
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
         Height          =   315
         Index           =   93
         Left            =   135
         TabIndex        =   7
         Top             =   1020
         Width           =   795
      End
   End
   Begin Threed.SSFrame Frame 
      Height          =   3570
      Index           =   1
      Left            =   60
      TabIndex        =   9
      Top             =   600
      Width           =   7170
      _Version        =   65536
      _ExtentX        =   12647
      _ExtentY        =   6297
      _StockProps     =   14
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
      Begin VB.TextBox txtCodigo 
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
         Left            =   840
         MaxLength       =   3
         MouseIcon       =   "Bacmntve.frx":32B2
         MousePointer    =   99  'Custom
         TabIndex        =   0
         Top             =   150
         Width           =   795
      End
      Begin VB.TextBox TxtGlosa 
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
         Height          =   330
         Left            =   1950
         TabIndex        =   1
         Top             =   150
         Width           =   5145
      End
      Begin BACControles.TXTNumero Txt_Ingreso 
         Height          =   420
         Left            =   2880
         TabIndex        =   10
         Top             =   1725
         Visible         =   0   'False
         Width           =   2190
         _ExtentX        =   3863
         _ExtentY        =   741
         BackColor       =   -2147483635
         ForeColor       =   -2147483634
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
         Text            =   "0.0000"
         Text            =   "0.0000"
         Min             =   "-999999"
         Max             =   "999999"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
      End
      Begin MSFlexGridLib.MSFlexGrid Table1 
         Height          =   2895
         Left            =   2250
         TabIndex        =   4
         Top             =   570
         Width           =   4860
         _ExtentX        =   8573
         _ExtentY        =   5106
         _Version        =   393216
         Cols            =   4
         FixedCols       =   0
         RowHeightMin    =   315
         BackColor       =   -2147483644
         ForeColor       =   8388608
         BackColorFixed  =   8421376
         ForeColorFixed  =   16777215
         BackColorBkg    =   -2147483636
         FocusRect       =   0
         GridLines       =   2
         GridLinesFixed  =   0
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin VB.Label Label 
         Caption         =   "Moneda"
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
         Height          =   315
         Index           =   90
         Left            =   120
         TabIndex        =   11
         Top             =   165
         Width           =   795
      End
   End
   Begin Threed.SSFrame SSFrame1 
      Height          =   2145
      Left            =   8055
      TabIndex        =   12
      Top             =   5415
      Visible         =   0   'False
      Width           =   1455
      _Version        =   65536
      _ExtentX        =   2566
      _ExtentY        =   3784
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
      Begin VB.PictureBox Grid1 
         BackColor       =   &H00FFFFFF&
         Height          =   705
         Left            =   90
         ScaleHeight     =   645
         ScaleWidth      =   1170
         TabIndex        =   13
         Top             =   240
         Width           =   1230
      End
      Begin VB.Label Label 
         BackColor       =   &H00800000&
         Caption         =   "Label(0)"
         ForeColor       =   &H00FFFFFF&
         Height          =   405
         Index           =   0
         Left            =   120
         TabIndex        =   15
         Top             =   1215
         Width           =   855
      End
      Begin VB.Label Label 
         BackColor       =   &H00800000&
         Caption         =   "Label(1)"
         ForeColor       =   &H00FFFFFF&
         Height          =   405
         Index           =   1
         Left            =   120
         TabIndex        =   14
         Top             =   1650
         Width           =   855
      End
   End
End
Attribute VB_Name = "BacMntVe"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit
Dim OptLocal As String
Dim objMoneda As Object
Dim Aux As String
Dim ArregloDias(31, 3) As String
Dim i As Double
Sub Dibuja_Grilla()

Table1.TextMatrix(0, 0) = ""
Table1.TextMatrix(0, 1) = "Fecha"
Table1.TextMatrix(0, 2) = "Compra"
Table1.TextMatrix(0, 3) = "Venta"

Table1.RowHeight(0) = 500

Table1.ColAlignment(0) = 1
Table1.ColAlignment(1) = 4
Table1.ColAlignment(2) = 7
Table1.ColAlignment(3) = 7

Table1.ColWidth(0) = 0
Table1.ColWidth(1) = 1450
Table1.ColWidth(2) = 1500
Table1.ColWidth(3) = 1500

End Sub


Private Sub FechaDefault()

   Dim f As Long

   cmbMes.Tag = "MESES"
   cmbano.Tag = "AÑO"

   'Mostramos el año por default del sistema operativo
   '--------------------------------------------------
   cmbano.Text = Year(gsbac_fecp)
   
   'Mostramos el mes por default del sistema operativo
   '--------------------------------------------------
   For f = 0 To cmbMes.ListCount - 1

      If cmbMes.ItemData(f) = Month(gsbac_fecp) Then
         cmbMes.ListIndex = f
         Exit For

      End If

   Next f

   cmbMes.Tag = ""
   cmbano.Tag = ""

End Sub

Function Habilitacontroles(Valor As Boolean)

   txtCodigo.Enabled = Not Valor
   Toolbar1.Buttons(1).Enabled = True
   Toolbar1.Buttons(2).Enabled = Valor
   Toolbar1.Buttons(3).Enabled = True
   
   Table1.Enabled = Valor
   cmbMes.Enabled = Valor
   cmbano.Enabled = Valor

End Function

Sub Limpiar()

    Table1.Clear
    Table1.Rows = 2
    txtCodigo.Text = ""
    Txt_Ingreso.Text = ""
    Dibuja_Grilla
    Table1.Col = 1
    Me.cmbMes.ListIndex = DatePart("m", gsbac_fecp) - 1
    cmbano.Text = DatePart("yyyy", gsbac_fecp)
    Table1.Enabled = False
    Me.TxtGlosa.Text = ""
    Me.Frame(0).Enabled = False
    
    
End Sub

Private Sub Valores2Grilla()

   On Error GoTo Label1
   
   Dim dias      As Integer
   Dim Mes       As Integer
   Dim Ann       As Integer
   Dim iPeriodo  As Integer
   Dim iRedondeo As Integer
   Dim lsMask    As String
   Dim f         As Integer
   Dim Max       As Integer
  
  
   MousePointer = 11
   Table1.Redraw = False
   If CDbl(txtCodigo.Text) = 0 Then
      MousePointer = 0
      Exit Sub

   End If
  
   If cmbMes.Enabled = True Then
      If cmbMes.ListIndex = -1 Then
         MousePointer = 0
         Exit Sub

      End If
     
   End If
     
   Mes = 0
   
   If cmbMes.ListIndex <> -1 Then
      Mes = cmbMes.ItemData(cmbMes.ListIndex)
     
   End If
  
   Ann = CDbl(cmbano.Text)
   
   Call BACLeerValoresMoneda(CDbl(txtCodigo.Text), Mes, Ann, Table1, "ME")

   If Table1.Rows < 2 Then
      
      Call BacGeneraMes(Mes, Ann, Table1)
      Call Rellena_Grilla
   
   End If

   Toolbar1.Buttons(2).Enabled = True

   If Table1.Rows > 0 Then
      Table1.Row = 1

   End If
   Table1.Redraw = True
   MousePointer = 0

   Exit Sub

Label1:
   MousePointer = 0

End Sub

Private Function cmdBuscar()
   
   If txtCodigo.Text <> "" Then
      Call Valores2Grilla
      Call Habilitacontroles(True)
      Frame(0).Enabled = True
      BacControlWindows 1000
      Me.Toolbar1.Buttons(3).Enabled = False
      Table1.Col = 2
   
      'If Table1.Enabled Then Table1.SetFocus
   End If
   
   
End Function

Private Sub cmdGrabar()

   If Not BACGrabarValoresMoneda(CDbl(txtCodigo.Text), Table1.Object, "ME") Then
      MsgBox "No se pueden grabar datos en tabla valores de moneda", 16
      Call LogAuditoria("01", OptLocal, Me.Caption & " Error al grabar- Codigo: " & txtCodigo.Text & " Mes: " & cmbMes.Text & " Año: " & cmbano.Text, "", "")

   Else
      Call Habilitacontroles(False)
      MsgBox "Grabación Realizada con Exito", vbInformation
      Call LogAuditoria("01", OptLocal, Me.Caption, "", "Codigo: " & txtCodigo.Text & " Mes: " & cmbMes.Text & " Año: " & cmbano.Text)
      Call Limpiar
   End If

End Sub
Private Sub cmdLimpiar()

   Call Limpiar
   Call Habilitacontroles(False)
   Frame(0).Enabled = False
   txtCodigo.SetFocus
   
End Sub

Private Sub cmbano_Click()
Call cmdBuscar
'If Aux = "S" Then cmbano.SetFocus
End Sub

Private Sub cmbano_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = 13 Then
   Bac_SendKey (vbKeyTab)
End If
End Sub

Private Sub cmbMes_Click()
If cmbMes.ListIndex <> -1 Then
   Call cmdBuscar
   'If Aux = "S" Then cmbMes.SetFocus
End If
End Sub

Private Sub cmbMes_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = 13 Then
   Bac_SendKey (vbKeyTab)
End If
End Sub

Private Sub Form_Activate()
   PROC_CARGA_AYUDA Me, " "
   Aux = "S"
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
On Error GoTo err
Dim opcion As Integer

   opcion = 0

   If KeyCode = vbKeyReturn And UCase(Me.ActiveControl.Name) <> "TXT_INGRESO" And UCase(Me.ActiveControl.Name) <> "TABLE1" And UCase(Me.ActiveControl.Name) <> "CMBANO" Then
      KeyCode = 0
      Bac_SendKey vbKeyTab
      Exit Sub
   End If

   If KeyCode <> vbKeyControl And (Shift = 2 Or (Shift = 0 And (KeyCode = vbKeyReturn Or KeyCode = vbKeyEscape Or (KeyCode >= vbKeyF1 And KeyCode <= vbKeyF12)))) Then

        Select Case KeyCode

           Case vbKeyLimpiar:
                              opcion = 1

            Case vbKeyGrabar:
                              opcion = 2

            Case vbKeyBuscar:
                              opcion = 3

            Case vbKeySalir:
                        If UCase(Me.ActiveControl.Name) <> "TXT_INGRESO" Then
                                opcion = 4
                        End If

      End Select

      If opcion <> 0 Then
            If Toolbar1.Buttons(opcion).Enabled Then
               Call Toolbar1_ButtonClick(Toolbar1.Buttons(opcion))
            End If

            KeyCode = 0
      End If


   End If
Exit Sub
err:
  Resume Next
End Sub

Private Sub Form_Load()
    OptLocal = Opt
    Me.top = 0
    Me.left = 0
    Dim iCol       As Integer
    Set objMoneda = New clsMoneda
    Aux = "N"
    Dibuja_Grilla
    
    Call BacLLenaComboMes(cmbMes)
    For i = 1900 To 2054
      Me.cmbano.AddItem i
    Next i
    
   Call FechaDefault
   Toolbar1.Buttons(2).Enabled = False
   Table1.Enabled = False
   cmbMes.Enabled = False
   'ITBANO.Enabled = False
   cmbano.Enabled = False
   Call LogAuditoria("07", OptLocal, Me.Caption, "", "")
   
End Sub

Private Sub Form_Unload(Cancel As Integer)
    Call LogAuditoria("08", OptLocal, Me.Caption, "", "")
End Sub

Private Sub SSFrame3_Click()

End Sub

Private Sub SSFrame4_Click()

End Sub

Private Sub SSFrame5_Click()

End Sub

Private Sub Table1_SelChange()
  '  Call PintaCelda(Table1)
End Sub
Private Sub Table1_KeyPress(KeyAscii As Integer)
If Table1.Col = 1 Then
KeyAscii = 0
 Exit Sub
End If

If Not IsNumeric(Chr(KeyAscii)) And KeyAscii = 8 Then
  
  KeyAscii = 0

End If

If (Table1.Col = 2 Or Table1.Col = 3) And IsNumeric(Chr(KeyAscii)) Or KeyAscii = 13 Then

      Txt_Ingreso.Text = ""
      
      PROC_POSICIONA_TEXTO Table1, Txt_Ingreso
      If KeyAscii = 13 Then
         Txt_Ingreso.Text = Table1.TextMatrix(Table1.Row, Table1.Col)
      Else
         Txt_Ingreso.Text = Chr(KeyAscii)
      End If
      Txt_Ingreso.Visible = True
      Txt_Ingreso.SetFocus
      
      'SendKeys "{END}"

End If

If (Table1.Col = 2 Or Table1.Col = 3) And KeyAscii = 13 Then
 
      PROC_POSICIONA_TEXTO Table1, Txt_Ingreso
      
      Txt_Ingreso.Text = BacCtrlTransMonto(Table1.Text)
      Txt_Ingreso.Visible = True
      Txt_Ingreso.SetFocus
      
      'SendKeys "{END}"

End If

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Index

    Case 1          '"Limpiar"
        Call cmdLimpiar
        

    Case 3          '"Buscar"
        Call cmdBuscar
   
       
        

    Case 2          '"Grabar"
        Call cmdGrabar
        Table1.Enabled = False
      Me.txtCodigo.SetFocus
         
    
    Case 4          '"Salir"
        Unload Me
    End Select
End Sub

Private Sub Txt_Ingreso_GotFocus()
Me.Txt_Ingreso.SelStart = Len(Me.Txt_Ingreso.Text) - 5
End Sub

Private Sub Txt_Ingreso_KeyPress(KeyAscii As Integer)
If KeyAscii = 27 Then
    
    Txt_Ingreso.Visible = False
    
    Txt_Ingreso.Text = ""
    
    Table1.SetFocus
     
End If

If Table1.Col = 2 Or Table1.Col = 3 Then
  ' KeyAscii = BacPunto(Txt_Ingreso, KeyAscii, 6, 4)
   Table1.Redraw = False
   If KeyAscii = 13 Then
   
       If Trim(Txt_Ingreso.Text) = "" Then Exit Sub
      
       Table1.Text = Txt_Ingreso.Text
       Table1.Text = Format(Table1.Text, FDecimal)
       Txt_Ingreso.Text = ""
       Txt_Ingreso.Visible = False
    

       If Table1.Col = 2 Then
         Table1.Col = 3
 
       Else

         Table1.Col = 2
         If Table1.Row = Table1.Rows - 1 Then
            Table1.TopRow = 1
            Table1.Row = 1
         Else
            Table1.Row = Table1.Row + 1
         End If
 
      End If
       Table1.Redraw = True
       Table1.SetFocus
       
   End If
End If

End Sub



Private Sub Txt_Ingreso_LostFocus()
Txt_Ingreso.Visible = False

End Sub

Private Sub TxtCodigo_DblClick()
    auxilio = 200
    On Error GoTo Label1

   txtCodigo.Text = 0

   MiTag = "MFMNME"
 '  MiTag = "MFMNME"
   BacAyuda.Show 1

   If giAceptar% = True Then
      txtCodigo.Text = gsCodigo$
      cmbMes.Enabled = True
      cmbano.Enabled = True
      Call TxtCodigo_LostFocus
      
   End If

   Exit Sub

Label1:
   MousePointer = 0

End Sub


Private Sub TxtCodigo_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyF3 Then Call TxtCodigo_DblClick

    If KeyCode = 13 Then
       Bac_SendKey (vbKeyTab)
    End If

End Sub


Private Sub txtCodigo_KeyPress(KeyAscii As Integer)

   If KeyAscii% = vbKeyReturn Then
         KeyAscii% = 0
      If txtCodigo.Text <> "" Then
        cmbMes.Enabled = True
        cmbano.Enabled = True
      End If
      Call TxtCodigo_LostFocus
   ElseIf Not ((KeyAscii > 47 And KeyAscii < 58) Or KeyAscii = 8) Then
      KeyAscii = 0

   End If

   BacCaracterNumerico KeyAscii

End Sub


Private Sub TxtCodigo_LostFocus()
   
   If txtCodigo.Text = "" Then
      Exit Sub
   End If
   
   If CDbl(txtCodigo.Text) = 0 Then
      MousePointer = 0
      Exit Sub

   End If
      If Trim$(txtCodigo.Text) <> "" Then
      
        If Trim$(txtCodigo.Text) <> "" Then
         If objMoneda.LeerPorCodigo(CDbl(txtCodigo.Text), Str(gsbac_fecp)) = True Then
   
            If objMoneda.mncodigo <> 0 Then
              'Encontró la moneda
              '-------------------------------------
               TxtGlosa.Text = objMoneda.mnglosa
               Call cmdBuscar
   
            Else
              'Moneda no existe en tabla de monedas
              '-------------------------------------
               txtCodigo.Text = ""
   
            End If
               Frame(0).Enabled = True
               cmbMes.Enabled = True
               cmbano.Enabled = True
               Table1.Enabled = True
'               Table1.SetFocus
               DoEvents
         Else
            Call cmdLimpiar
            MsgBox "Moneda no existe", vbInformation
            Table1.Enabled = False
            Frame(0).Enabled = False
            txtCodigo.Text = ""
            txtCodigo.Enabled = True
            txtCodigo.SetFocus
   
        End If
     End If
   End If

End Sub


Sub Rellena_Grilla()
Dim i As Integer

   With Table1
   
      For i = 1 To .Rows - 1
   
         .TextMatrix(i, 2) = Format("0.0000", FDecimal)
         .TextMatrix(i, 3) = Format("0.0000", FDecimal)
   
   
      Next i

   End With
End Sub

