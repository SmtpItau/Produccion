VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BACCONTROLES.OCX"
Begin VB.Form BacMntVe 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Paridades Monedas"
   ClientHeight    =   3780
   ClientLeft      =   2130
   ClientTop       =   2160
   ClientWidth     =   7620
   Icon            =   "Bacmntve.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   3780
   ScaleWidth      =   7620
   ShowInTaskbar   =   0   'False
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   4020
      Top             =   -15
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   4
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmntve.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmntve.frx":075C
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmntve.frx":0BAE
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmntve.frx":0EC8
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   9
      Top             =   0
      Width           =   7620
      _ExtentX        =   13441
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Buscar"
            Description     =   "Buscar"
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Grabar"
            Description     =   "Grabar"
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Limpiar"
            Description     =   "Limpiar"
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Description     =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   4
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin Threed.SSFrame Frame 
      Height          =   3075
      Index           =   0
      Left            =   120
      TabIndex        =   0
      Top             =   585
      Width           =   2415
      _Version        =   65536
      _ExtentX        =   4260
      _ExtentY        =   5424
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
      Begin VB.TextBox txtCodigo 
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
         Left            =   1455
         MaxLength       =   3
         MouseIcon       =   "Bacmntve.frx":11E2
         MousePointer    =   99  'Custom
         TabIndex        =   2
         Top             =   285
         Width           =   795
      End
      Begin VB.ComboBox cmbMes 
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
         Left            =   840
         Style           =   2  'Dropdown List
         TabIndex        =   1
         Top             =   870
         Width           =   1395
      End
      Begin Threed.SSFrame SSFrame3 
         Height          =   615
         Left            =   90
         TabIndex        =   12
         Top             =   105
         Width           =   2235
         _Version        =   65536
         _ExtentX        =   3942
         _ExtentY        =   1085
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
         Begin VB.Label Label 
            BackStyle       =   0  'Transparent
            Caption         =   "Moneda"
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
            Index           =   90
            Left            =   90
            TabIndex        =   13
            Top             =   210
            Width           =   795
         End
      End
      Begin Threed.SSFrame SSFrame4 
         Height          =   630
         Left            =   75
         TabIndex        =   14
         Top             =   690
         Width           =   2235
         _Version        =   65536
         _ExtentX        =   3942
         _ExtentY        =   1111
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
         Begin VB.Label Label 
            Caption         =   "Mes"
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
            Index           =   92
            Left            =   120
            TabIndex        =   15
            Top             =   195
            Width           =   795
         End
      End
      Begin Threed.SSFrame SSFrame5 
         Height          =   600
         Left            =   75
         TabIndex        =   16
         Top             =   1305
         Width           =   2235
         _Version        =   65536
         _ExtentX        =   3942
         _ExtentY        =   1058
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
         Begin VB.Label itbano 
            Alignment       =   2  'Center
            BackColor       =   &H80000005&
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
            Height          =   315
            Left            =   990
            TabIndex        =   10
            ToolTipText     =   "Cambio de Año ->"
            Top             =   180
            Width           =   615
         End
         Begin VB.Label Label 
            Caption         =   "Año"
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
            Index           =   93
            Left            =   120
            TabIndex        =   17
            Top             =   195
            Width           =   795
         End
      End
   End
   Begin Threed.SSFrame Frame 
      Height          =   3075
      Index           =   1
      Left            =   2565
      TabIndex        =   3
      Top             =   585
      Width           =   4935
      _Version        =   65536
      _ExtentX        =   8705
      _ExtentY        =   5424
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
      Begin BACControles.TXTNumero Txt_Ingreso 
         Height          =   255
         Left            =   2160
         TabIndex        =   18
         Top             =   1440
         Visible         =   0   'False
         Width           =   1455
         _ExtentX        =   2566
         _ExtentY        =   450
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0,000000"
         Text            =   "0,000000"
         Min             =   "0"
         Max             =   "999999.999999"
         CantidadDecimales=   "6"
         Separator       =   -1  'True
      End
      Begin MSFlexGridLib.MSFlexGrid Table1 
         Height          =   2730
         Left            =   30
         TabIndex        =   8
         Top             =   285
         Width           =   4860
         _ExtentX        =   8573
         _ExtentY        =   4815
         _Version        =   393216
         Cols            =   4
         FixedCols       =   0
         RowHeightMin    =   315
         BackColor       =   -2147483644
         ForeColor       =   12582912
         BackColorFixed  =   8421376
         ForeColorFixed  =   16777215
         BackColorBkg    =   -2147483645
         FocusRect       =   0
         GridLines       =   2
         GridLinesFixed  =   0
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
   End
   Begin Threed.SSFrame SSFrame2 
      Height          =   3270
      Left            =   45
      TabIndex        =   11
      Top             =   480
      Width           =   7545
      _Version        =   65536
      _ExtentX        =   13309
      _ExtentY        =   5768
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
   End
   Begin Threed.SSFrame SSFrame1 
      Height          =   2145
      Left            =   8055
      TabIndex        =   4
      Top             =   5400
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
         TabIndex        =   7
         Top             =   240
         Width           =   1230
      End
      Begin VB.Label Label 
         BackColor       =   &H00800000&
         Caption         =   "Label(1)"
         ForeColor       =   &H00FFFFFF&
         Height          =   405
         Index           =   1
         Left            =   120
         TabIndex        =   6
         Top             =   1650
         Width           =   855
      End
      Begin VB.Label Label 
         BackColor       =   &H00800000&
         Caption         =   "Label(0)"
         ForeColor       =   &H00FFFFFF&
         Height          =   405
         Index           =   0
         Left            =   120
         TabIndex        =   5
         Top             =   1215
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

 Dim objMoneda As Object

Dim ArregloDias(31, 3) As String
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
   itbano.Tag = "AÑO"

   'Mostramos el año por default del sistema operativo
   '--------------------------------------------------
   itbano.Caption = Trim(Year(gsbac_fecp))
   'itbano.Text = Str(Year(CDate(gsbac_fecp)))   'Year(gsbac_fecp)
   
   'Mostramos el mes por default del sistema operativo
   '--------------------------------------------------
   For f = 0 To cmbMes.ListCount - 1

      If cmbMes.ItemData(f) = Month(gsbac_fecp) Then
         cmbMes.ListIndex = f
         Exit For

      End If

   Next f

   cmbMes.Tag = ""
   itbano.Tag = ""

End Sub

Function Habilitacontroles(Valor As Boolean)

   txtCodigo.Enabled = Not Valor
   cmbMes.Enabled = Not Valor
   itbano.Enabled = Not Valor
   Toolbar1.Buttons(1).Enabled = Not Valor
   Toolbar1.Buttons(2).Enabled = Valor
   Toolbar1.Buttons(3).Enabled = Valor
   Table1.Enabled = Valor

End Function

Sub Limpiar()

   Table1.Clear
   Table1.Rows = 2
   txtCodigo.Text = ""
   Txt_Ingreso.Text = 0
   Dibuja_Grilla
   Table1.Col = 0
   Table1.Enabled = False

End Sub

Private Sub Valores2Grilla()

   On Error GoTo Label1
   
   Dim Dias      As Integer
   Dim Mes       As Integer
   Dim Ann       As Integer
   Dim iPeriodo  As Integer
   Dim iRedondeo As Integer
   Dim lsMask    As String
   Dim f         As Integer
   Dim Max       As Integer
  
  
   MousePointer = 11
  
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
  
   Ann = CDbl(itbano.Caption)
   
   Call BACLeerValoresMoneda(CDbl(txtCodigo.Text), Mes, Ann, Table1, "ME")

   If Table1.Rows < 2 Then
      
      Call BacGeneraMes(Mes, Ann, Table1)
      Call Rellena_Grilla
   
   End If

   Toolbar1.Buttons(2).Enabled = True

   If Table1.Rows > 0 Then
      Table1.Row = 1

   End If

   MousePointer = 0

   Exit Sub

Label1:
   MousePointer = 0

End Sub

Private Sub cmdBuscar()

   If txtCodigo.Text <> "" Then
      Call Valores2Grilla
      Call Habilitacontroles(True)
      Table1.SetFocus
      
   End If
   
End Sub

Private Sub cmdGrabar()

   If Not BACGrabarValoresMoneda(CDbl(txtCodigo.Text), Table1.Object, "ME") Then
      MsgBox "No se pueden grabar datos en tabla valores de moneda", 16, TITSISTEMA

   Else
      Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                          , gsbac_fecp _
                          , gsBac_IP _
                          , gsBAC_User _
                          , "PCA" _
                          , "OPC_690 " _
                          , "01" _
                          , "Grabar, valores de moneda " _
                          , "VALOR_MONEDA  " _
                          , " " _
                          , "Grabar, valores de moneda " & " " & objMoneda.mnglosa & " Mes " & Trim(Mid(cmbMes.Text, 1, 10)) & " Año " & itbano.Caption)
                          
      Call Limpiar
      Call Habilitacontroles(False)
      MsgBox "Grabacion Realizada con Exito", vbInformation, TITSISTEMA
   End If

End Sub
Private Sub CmdLimpiar()

   Call Limpiar
   Call Habilitacontroles(False)

End Sub

Private Sub Form_Load()
    Me.Top = 0
    Me.Left = 0
    Dim iCol       As Integer
    Set objMoneda = New clsMoneda
    
    Dibuja_Grilla
    Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                          , gsbac_fecp _
                          , gsBac_IP _
                          , gsBAC_User _
                          , "PCA" _
                          , "OPC_690 " _
                          , "07" _
                          , "INGRESO A OPCION MENU" _
                          , " " _
                          , " " _
                          , " ")
                          
    Call BacLLenaComboMes(cmbMes)

   Call FechaDefault
   Toolbar1.Buttons(2).Enabled = False
   Table1.Enabled = False

End Sub

Private Sub Table1_Click()
    Call PintaCelda(Table1)
End Sub

Private Sub Table1_GotFocus()
    Call PintaCelda(Table1)
    Txt_Ingreso.SelStart = 1
End Sub

Private Sub Table1_LeaveCell()
    Call CellPintaCelda(Table1)
End Sub

Private Sub Table1_SelChange()
    Call PintaCelda(Table1)
End Sub
Private Sub Table1_KeyPress(KeyAscii As Integer)

'If Not IsNumeric(Chr(KeyAscii)) And KeyAscii = 13 And KeyAscii = 8 Then
'
'  KeyAscii = 0
'
'End If
'
If (Table1.Col = 2 Or Table1.Col = 3) Then 'And IsNumeric(Chr(KeyAscii)) Then

      Txt_Ingreso.Text = 0
      
      PROC_POSICIONA_TEXTO Table1, Txt_Ingreso
      
      Txt_Ingreso.Visible = True
      Txt_Ingreso.SetFocus
      Txt_Ingreso.Text = Chr(KeyAscii)
      Txt_Ingreso.SelStart = 1


End If

If (Table1.Col = 2 Or Table1.Col = 3) And KeyAscii = 13 Then
 
      PROC_POSICIONA_TEXTO Table1, Txt_Ingreso
      
      Txt_Ingreso.Text = Table1.Text
      Txt_Ingreso.Visible = True
      Txt_Ingreso.SetFocus
      Txt_Ingreso.SelStart = 1


End If

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Index
    Case 1          '"Buscar"
        Call cmdBuscar
        
    Case 2          '"Grabar"
        Call cmdGrabar
        Table1.Enabled = False
    Case 3          '"Limpiar"
        Call CmdLimpiar
        Table1.Enabled = False
    Case 4          '"Salir"
        Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                          , gsbac_fecp _
                          , gsBac_IP _
                          , gsBAC_User _
                          , "PCA" _
                          , "OPC_690 " _
                          , "08" _
                          , "SALIR DE OPCION MENU" _
                          , "VALOR_MONEDA  " _
                          , " " _
                          , " ")
        Unload Me
    End Select
End Sub

Private Sub Txt_Ingreso_KeyPress(KeyAscii As Integer)

If KeyAscii = 27 Then
    Txt_Ingreso.Visible = False
    Txt_Ingreso.Text = ""
    Table1.SetFocus
     
End If

If Table1.Col = 2 Or Table1.Col = 3 Then
   KeyAscii = BacPunto(Txt_Ingreso, KeyAscii, 6, 6)
   
   If KeyAscii = 13 Then
   
       If Txt_Ingreso.Text = 0 Then Exit Sub
      
       Table1.Text = Txt_Ingreso.Text
       Table1.Text = Format(Table1.Text, "#,##0.000000")
       Txt_Ingreso.Text = ""
       Txt_Ingreso.Visible = False
       Table1.SetFocus
       
   End If
End If

End Sub



Private Sub txtCodigo_DblClick()
    auxilio = 200
    On Error GoTo Label1

   txtCodigo.Text = 0

   BacAyuda.Tag = "MFMNME"
   BacAyuda.Show 1

   If giAceptar% = True Then
      txtCodigo.Text = gsCodigo$
      cmbMes.SetFocus
      SendKeys "{ENTER}"

   End If

   Exit Sub

Label1:
   MousePointer = 0

End Sub


Private Sub txtCodigo_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyF3 Then Call txtCodigo_DblClick
End Sub


Private Sub txtCodigo_KeyPress(KeyAscii As Integer)

   If KeyAscii% = vbKeyReturn Then
      KeyAscii% = 0
      SendKeys$ "{TAB}"

   ElseIf Not ((KeyAscii > 47 And KeyAscii < 58) Or KeyAscii = 8) Then
      KeyAscii = 0

   End If

   BacCaracterNumerico KeyAscii

End Sub


Private Sub TxtCodigo_LostFocus()
   
   If txtCodigo.Text = "" Then
      MousePointer = 0
      Exit Sub
   
   End If
   
   If CDbl(txtCodigo.Text) = 0 Then
      MousePointer = 0
      Exit Sub

   End If

   If Trim$(txtCodigo.Text) <> "" Then

      'Call Limpiar
    
      If objMoneda.LeerPorCodigo(CDbl(txtCodigo.Text), Str(gsbac_fecp)) = True Then

         If objMoneda.mncodigo <> 0 Then
           'Encontró la moneda
           '-------------------------------------
            Frame(1).Caption = objMoneda.mnglosa

         Else
           'Moneda no existe en tabla de monedas
           '-------------------------------------
            txtCodigo.Text = ""

         End If

      Else
         MsgBox "Error : En Carga de Datos o Moneda no existe", 16, TITSISTEMA
         txtCodigo.Text = ""
         
         txtCodigo.SetFocus

     End If

   End If

End Sub


Sub Rellena_Grilla()
Dim I As Integer

   With Table1
   
      For I = 1 To .Rows - 1
   
         .TextMatrix(I, 2) = Format("0.000000", "#,##0.000000")
         .TextMatrix(I, 3) = Format("0.000000", "#,##0.000000")
   
   
      Next I

   End With
End Sub
