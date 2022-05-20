VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "Mscomctl.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "threed32.ocx"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form ProdxCamposLogicos 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Productos por Campos Lógicos"
   ClientHeight    =   5040
   ClientLeft      =   2820
   ClientTop       =   2385
   ClientWidth     =   6855
   Icon            =   "ProdxCamposLogicos.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form2"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   5040
   ScaleWidth      =   6855
   Begin VB.PictureBox ConCheck 
      BorderStyle     =   0  'None
      Height          =   345
      Index           =   0
      Left            =   1155
      Picture         =   "ProdxCamposLogicos.frx":030A
      ScaleHeight     =   345
      ScaleWidth      =   405
      TabIndex        =   3
      Top             =   3735
      Visible         =   0   'False
      Width           =   405
   End
   Begin VB.PictureBox SinCheck 
      BorderStyle     =   0  'None
      Height          =   330
      Index           =   0
      Left            =   330
      Picture         =   "ProdxCamposLogicos.frx":0464
      ScaleHeight     =   330
      ScaleWidth      =   375
      TabIndex        =   2
      Top             =   3720
      Visible         =   0   'False
      Width           =   375
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   5385
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
            Picture         =   "ProdxCamposLogicos.frx":05BE
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "ProdxCamposLogicos.frx":1498
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "ProdxCamposLogicos.frx":2372
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "ProdxCamposLogicos.frx":268C
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   480
      Left            =   0
      TabIndex        =   1
      Top             =   0
      Width           =   6855
      _ExtentX        =   12091
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
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Grabar"
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Buscar"
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin MSFlexGridLib.MSFlexGrid grilla 
      Height          =   3495
      Left            =   30
      TabIndex        =   4
      Top             =   1500
      Width           =   6765
      _ExtentX        =   11933
      _ExtentY        =   6165
      _Version        =   393216
      Cols            =   3
      RowHeightMin    =   280
      BackColor       =   -2147483644
      ForeColor       =   8388608
      BackColorFixed  =   8421376
      ForeColorFixed  =   16777215
      BackColorSel    =   8388608
      ForeColorSel    =   16777215
      BackColorBkg    =   -2147483636
      GridColor       =   0
      FocusRect       =   0
      GridLines       =   2
      GridLinesFixed  =   0
      ScrollBars      =   2
      SelectionMode   =   1
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
   Begin Threed.SSFrame SSFrame1 
      Height          =   990
      Left            =   30
      TabIndex        =   5
      Top             =   450
      Width           =   6765
      _Version        =   65536
      _ExtentX        =   11933
      _ExtentY        =   1746
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
      Begin VB.TextBox txtcodigo 
         Alignment       =   1  'Right Justify
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
         TabIndex        =   0
         Top             =   135
         Width           =   765
      End
      Begin VB.ComboBox cmbCondiciones 
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
         Left            =   75
         Style           =   2  'Dropdown List
         TabIndex        =   7
         Top             =   525
         Width           =   6570
      End
      Begin VB.Label Label3 
         Caption         =   "Campo"
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
         Height          =   255
         Left            =   90
         TabIndex        =   6
         Top             =   195
         Width           =   735
      End
   End
End
Attribute VB_Name = "ProdxCamposLogicos"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim OptLocal As String
Dim Datos()

Private Function Carga_combo()
   Envia = Array()
   AddParam Envia, txtCodigo.Text
   Me.cmbCondiciones.Clear
   If BAC_SQL_EXECUTE("Sp_ProdxCamposLogicos_LeeCampos", Envia) Then
   
      While BAC_SQL_FETCH(Datos())
      
         Me.cmbCondiciones.AddItem Datos(3) + Space(150 - Len(Datos(3))) + Datos(2)
         Me.cmbCondiciones.Enabled = True
      Wend
         
   End If
  If Me.cmbCondiciones.ListCount > 0 Then
   Me.cmbCondiciones.ListIndex = 0
  End If

End Function

Private Sub cmbCondiciones_KeyPress(KeyAscii As Integer)
If KeyAscii = vbKeyReturn And Val(txtCodigo.Text) <> 0 Then
     Carga_Productos
     Toolbar1.Buttons(2).Enabled = True
     Toolbar1.Buttons(3).Enabled = False
     SSFrame1.Enabled = False
     Me.Grilla.Row = 1
     Me.Grilla.Col = 0
     Me.Grilla.SetFocus
      
End If

End Sub

Private Sub Form_Activate()
   Limpiar
   PROC_CARGA_AYUDA Me, " "
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
On Error GoTo err
Dim opcion As Integer

   opcion = 0


   If KeyCode <> vbKeyControl And (Shift = 2 Or (Shift = 0 And (KeyCode = vbKeyReturn Or KeyCode = vbKeyEscape Or (KeyCode >= vbKeyF1 And KeyCode <= vbKeyF12)))) Then
     
        Select Case KeyCode

           Case vbKeyLimpiar:
                              opcion = 1
   
            Case vbKeyGrabar:
                              opcion = 2
   
            Case vbKeyBuscar:
                              opcion = 3
            Case vbKeySalir:
                              opcion = 4
                      
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
   Me.Icon = BAC_Parametros.Icon
   CARGAPAR_GRILLA Grilla

   Call LogAuditoria("07", OptLocal, Me.Caption, "", "")
End Sub

Private Sub Form_Unload(Cancel As Integer)
    Call LogAuditoria("08", OptLocal, Me.Caption, "", "")
End Sub

Private Sub Grilla_Click()
     With Grilla
      
      .CellPictureAlignment = 4
          
      .Col = 1
         
      If .CellPicture = ConCheck(0).Picture Then
          
          .Col = 1
          Set .CellPicture = SinCheck(0).Picture
          .ColSel = .Cols - 1
      
      Else
         
         .Col = 1
         Set .CellPicture = ConCheck(0).Picture
         .ColSel = .Cols - 1
                          
      End If
               
    End With
     

End Sub


Public Function CARGAPAR_GRILLA(Grillas As MSFlexGrid)

  With Grillas
      
        .Cols = 4
        
        .Enabled = True
        .FixedCols = 1
        .FixedRows = 1
        .RowHeight(0) = 320
        .CellFontWidth = 3         ' TAMAÑO
        
        .ColWidth(0) = 0
        .ColWidth(1) = 1800
        .ColWidth(2) = 4500
        .ColWidth(3) = 0
        
        .Rows = 2
        .Row = 0
        .Col = 1
        
        .FixedAlignment(1) = 4
        .CellFontBold = True       'RESALSE
        .Text = "Marca"
        .ColAlignment(1) = 4
        
        .Col = 2
        .FixedAlignment(2) = 4
        .CellFontBold = True       'RESALSE
        .Text = "Descripción "
        
        .Row = 1
        .Col = 0
        .Rows = 1
        
  End With

End Function

Private Sub Grilla_KeyPress(KeyAscii As Integer)

   Grilla_Click

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

   Select Case UCase(Button.Key)

      Case "GRABAR"
            Call Grabar

      Case "LIMPIAR"
            Call Limpiar
      
      Case "SALIR"
            Unload Me
      Case "BUSCAR"
           Call cmbCondiciones_KeyPress(13)

   End Select

End Sub

Private Sub Carga_Productos()
Dim Productos As String

   Envia = Array()
   AddParam Envia, txtCodigo.Text
   AddParam Envia, Trim(right(Me.cmbCondiciones.Text, 50))
   
   If Not BAC_SQL_EXECUTE("Sp_ProdxCamposLogicos_LeeCampos", Envia) Then
   
      Exit Sub
   
   End If

   If BAC_SQL_FETCH(Datos()) Then
   
      Productos = Datos(4)
   
   End If

   If Not BAC_SQL_EXECUTE("Sp_BacMntCampos_Leer_Producto") Then
   
      MsgBox "Problemas al Buscar Producto", vbExclamation
      Exit Sub
   
   End If

   With Grilla
         
      .Enabled = True
      .Redraw = False
      .Rows = 1
      .Col = 1
      While BAC_SQL_FETCH(Datos())
   
            .Rows = .Rows + 1
            .Row = .Rows - 1
            .TextMatrix(.Rows - 1, 2) = Datos(2)
            .TextMatrix(.Rows - 1, 3) = Datos(1)
            .CellPictureAlignment = 4
            Datos(1) = Datos(1) + "/"
            
            If InStr(1, Productos, Datos(1)) <> 0 Then
            
               Set .CellPicture = ConCheck(0).Picture
            
            Else
            
               Set .CellPicture = SinCheck(0).Picture
               
            End If
         
      Wend
   
      .Row = 1
      .Col = 0
      .Redraw = True
   
   End With
   

End Sub


Sub CodigoCampo()
On Error GoTo Label1
    
    txtCodigo.Text = ""
    MiTag = "PROD_CAMPOSLOGICOS"
    BacAyuda.Show 1
    
    If giAceptar% = True Then
       txtCodigo.Text = left(gsCodigo$, 3)
       Me.cmbCondiciones.AddItem Trim(left(gsGlosa, Len(gsGlosa) - 15)) & Space(130) & Trim(right(gsGlosa, 20))
       Me.cmbCondiciones.ListIndex = 0
       BacControlWindows 10000
       Carga_Productos
       BacControlWindows 10000
       Me.Toolbar1.Buttons(2).Enabled = True
       Me.Toolbar1.Buttons(3).Enabled = False
       Me.cmbCondiciones.Enabled = True
       SSFrame1.Enabled = False
          
       If Grilla.Enabled Then
       
          If Grilla.Rows > 1 Then
            Grilla.Row = 1
            Grilla.Col = 0
            Grilla.ColSel = Grilla.Cols - 1
            Me.Grilla.SetFocus
              
          End If
      
       End If
      
      
    End If
    
    Exit Sub

Label1:
    
    MousePointer = 0
    MsgBox "Error : " & err.Description, vbOKOnly + vbCritical

End Sub


Private Sub TxtCodigo_DblClick()

   CodigoCampo

End Sub

Sub Limpiar()

   txtCodigo.Text = ""
   txtCodigo.Enabled = True
   cmbCondiciones.Clear
   Grilla.Rows = 1
   Grilla.Enabled = False
   Grilla.Col = 0
   Me.SSFrame1.Enabled = True
   Me.cmbCondiciones.Enabled = False
   Me.Toolbar1.Buttons(2).Enabled = False
   Me.Toolbar1.Buttons(3).Enabled = False
   Me.txtCodigo.SetFocus
End Sub


Sub Grabar()
Dim i          As Integer
Dim Row        As Integer
Dim Productos  As String

Dim AUX1         As String

   With Grilla
   
      Row = .Row
      .Redraw = False
      Productos = ""
   
      
      For i = 1 To .Rows - 1
      
         .Row = i
         .Col = 1
         If .CellPicture = ConCheck(0).Picture Then
      
            Productos = Productos + .TextMatrix(i, 3) + "/"
      
         End If
      
      Next i
   
      .Row = Row
      .ColSel = .Cols - 1
      .Redraw = True
   
      AUX1 = Trim(right(Me.cmbCondiciones.Text, 50))
   
      Envia = Array()
      AddParam Envia, CDbl(txtCodigo.Text)
      AddParam Envia, CStr(AUX1)
      AddParam Envia, Productos
      
   
      If Not BAC_SQL_EXECUTE("Sp_ProdxCamposLogicos_Grabar", Envia) Then
      
         MsgBox "Problemas al Grabar Productos por Campos", vbExclamation
         Call LogAuditoria("01", OptLocal, Me.Caption & " Error al Grabar- Codigo: " & txtCodigo.Text, "", "")
         Exit Sub
      
      End If
   
      MsgBox "Grabación Realizada con Exito", vbInformation
      Call LogAuditoria("01", OptLocal, Me.Caption, "", "Codigo: " & txtCodigo.Text)
      Call Limpiar
   
   End With

End Sub

Private Sub TxtCodigo_KeyDown(KeyCode As Integer, Shift As Integer)

If KeyCode = vbKeyF3 Then
      CodigoCampo
End If
If KeyCode = 13 And txtCodigo.Text <> "" Then
      Carga_combo
      
      If Me.cmbCondiciones.Enabled = True Then
         Me.Toolbar1.Buttons(3).Enabled = True
         cmbCondiciones.SetFocus
      End If



End If


End Sub


Private Sub txtCodigo_KeyPress(KeyAscii As Integer)
   If Not IsNumeric(Chr(KeyAscii)) And Not (KeyAscii = 8 Or KeyAscii = vbKeyReturn Or KeyAscii = vbKeyEscape) Then
         KeyAscii = 0
   End If

End Sub


Private Sub txtcodigo_KeyUp(KeyCode As Integer, Shift As Integer)
   If Len(txtCodigo.Text) > 0 Then
      Toolbar1.Buttons(3).Enabled = True
   Else
      Toolbar1.Buttons(3).Enabled = False
   End If

End Sub
