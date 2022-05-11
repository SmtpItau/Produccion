VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{05BDEB52-1755-11D5-9109-000102BF881D}#1.0#0"; "BACCONTROLES.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form BacsaldoCtas 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Saldos Cuentas"
   ClientHeight    =   4845
   ClientLeft      =   1125
   ClientTop       =   2850
   ClientWidth     =   7695
   Icon            =   "BacsaldoCtas.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   4845
   ScaleWidth      =   7695
   Begin BacControles.txtNumero txtNumCodCorres 
      Height          =   255
      Left            =   3600
      TabIndex        =   8
      Top             =   4200
      Width           =   1575
      _ExtentX        =   2778
      _ExtentY        =   450
      BackColor       =   -2147483646
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   -2147483639
      Text            =   "0"
      CantidadDecimales=   "0"
   End
   Begin VB.TextBox txtgrilla2 
      BackColor       =   &H00800000&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000E&
      Height          =   315
      Left            =   3630
      MaxLength       =   50
      TabIndex        =   7
      TabStop         =   0   'False
      Top             =   2865
      Visible         =   0   'False
      Width           =   1500
   End
   Begin VB.TextBox TXTGRILLA 
      BackColor       =   &H00800000&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   315
      Left            =   2700
      MaxLength       =   11
      TabIndex        =   6
      TabStop         =   0   'False
      Top             =   1770
      Width           =   1500
   End
   Begin VB.ComboBox cmbBANCE 
      BackColor       =   &H80000009&
      Height          =   315
      ItemData        =   "BacsaldoCtas.frx":030A
      Left            =   2355
      List            =   "BacsaldoCtas.frx":0314
      Style           =   2  'Dropdown List
      TabIndex        =   2
      TabStop         =   0   'False
      Top             =   3495
      Visible         =   0   'False
      Width           =   1305
   End
   Begin VB.TextBox txtgrilla3 
      BackColor       =   &H00800000&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000E&
      Height          =   315
      Left            =   3630
      MaxLength       =   30
      TabIndex        =   0
      TabStop         =   0   'False
      Top             =   2565
      Visible         =   0   'False
      Width           =   1500
   End
   Begin VB.TextBox txtgrilla4 
      BackColor       =   &H00800000&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000E&
      Height          =   315
      Left            =   3630
      MaxLength       =   11
      TabIndex        =   1
      TabStop         =   0   'False
      Top             =   3195
      Visible         =   0   'False
      Width           =   1500
   End
   Begin VB.TextBox Text1 
      Height          =   315
      Left            =   3630
      TabIndex        =   5
      TabStop         =   0   'False
      Top             =   3510
      Visible         =   0   'False
      Width           =   1500
   End
   Begin VB.Frame Frame2 
      Height          =   4215
      Left            =   -60
      TabIndex        =   3
      Top             =   570
      Width           =   7725
      Begin MSFlexGridLib.MSFlexGrid Grid 
         Height          =   4740
         Left            =   -30
         TabIndex        =   9
         Top             =   15
         Width           =   7680
         _ExtentX        =   13547
         _ExtentY        =   8361
         _Version        =   393216
         Cols            =   4
         FixedCols       =   0
         RowHeightMin    =   280
         BackColor       =   -2147483644
         ForeColor       =   8388608
         BackColorFixed  =   8421376
         ForeColorFixed  =   16777215
         BackColorSel    =   8388608
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
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   4
      Top             =   0
      Width           =   7695
      _ExtentX        =   13573
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   5
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.ToolTipText     =   "Grabar"
            Object.Tag             =   "2"
            ImageIndex      =   1
            BeginProperty ButtonMenus {66833FEC-8583-11D1-B16A-00C0F0283628} 
               NumButtonMenus  =   1
               BeginProperty ButtonMenu1 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
            EndProperty
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   2
            BeginProperty ButtonMenus {66833FEC-8583-11D1-B16A-00C0F0283628} 
               NumButtonMenus  =   1
               BeginProperty ButtonMenu1 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
            EndProperty
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.ToolTipText     =   "Eliminar"
            Object.Tag             =   "3"
            ImageIndex      =   3
            BeginProperty ButtonMenus {66833FEC-8583-11D1-B16A-00C0F0283628} 
               NumButtonMenus  =   1
               BeginProperty ButtonMenu1 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
            EndProperty
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.ToolTipText     =   "Limpia"
            Object.Tag             =   "4"
            ImageIndex      =   4
            BeginProperty ButtonMenus {66833FEC-8583-11D1-B16A-00C0F0283628} 
               NumButtonMenus  =   1
               BeginProperty ButtonMenu1 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
            EndProperty
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            Object.Tag             =   "5"
            ImageIndex      =   5
            BeginProperty ButtonMenus {66833FEC-8583-11D1-B16A-00C0F0283628} 
               NumButtonMenus  =   8
               BeginProperty ButtonMenu1 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
               BeginProperty ButtonMenu2 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
               BeginProperty ButtonMenu3 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
               BeginProperty ButtonMenu4 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
               BeginProperty ButtonMenu5 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
               BeginProperty ButtonMenu6 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
               BeginProperty ButtonMenu7 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
               BeginProperty ButtonMenu8 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
            EndProperty
         EndProperty
      EndProperty
      BorderStyle     =   1
      MouseIcon       =   "BacsaldoCtas.frx":0320
      OLEDropMode     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   3600
         Top             =   -45
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   22
         ImageHeight     =   22
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   6
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacsaldoCtas.frx":063A
               Key             =   "Guardar"
               Object.Tag             =   "1"
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacsaldoCtas.frx":0A8C
               Key             =   "Buscar"
               Object.Tag             =   "2"
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacsaldoCtas.frx":0EDE
               Key             =   "Eliminar"
               Object.Tag             =   "3"
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacsaldoCtas.frx":1330
               Key             =   "Limpiar"
               Object.Tag             =   "4"
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacsaldoCtas.frx":164A
               Key             =   "Ayuda"
               Object.Tag             =   "6"
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacsaldoCtas.frx":1964
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
End
Attribute VB_Name = "BacsaldoCtas"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public BUS
Public pais
Public Escape
Public paisactivo
Public SWGRA
Dim colpress As Long
Dim rowpress, Cont As Long
Dim inicio, I, SW2, CmbKey As Integer
Dim Digito As String

Sub cargar_grilla()

On Error GoTo Errores

Dim Datos()

Grid.Redraw = False

If Not Bac_Sql_Execute("SP_TRAER_SALDO_CUENTA") Then
   
   MsgBox "Problemas al leer ", vbCritical, "MENSAJE"
   Exit Sub
End If
With Grid
   
   Grid.Rows = 1
   
   Do While Bac_SQL_Fetch(Datos())
  
      BacControlWindows 100
      
      Grid.Rows = Grid.Rows + 1
      Grid.Row = Grid.Rows - 1
      
      Grid.Col = 1: Grid.Text = Datos(1)
      Grid.Col = 2: Grid.Text = Datos(2)
      Grid.Col = 3: Grid.Text = IIf(Datos(3) = 0, "NO", "SI")
      Grid.Col = 4: Grid.Text = Datos(4)
      
   Loop
   
   Grid.Row = 1
   Grid.Col = 1
End With
'End If
If Grid.Rows < 2 Then
   Call Limpiar
   MsgBox "No existen Saldos", vbCritical, "MENSAJE"
Else
   'Frame3.Enabled = True
End If

Grid.Redraw = True
Exit Sub

Errores:

   MsgBox Err.Description

End Sub

Public Function Valida_Ingreso_graba(obj As Object) As Boolean

Dim Fila%
Valida_Ingreso_graba = True

Grilla.Enabled = True
With obj
  
    For Fila = 1 To .Rows - 1
      
      .Row = Fila
       
      If Trim$(.TextMatrix(.Row, 0)) <> "" And Trim$(.TextMatrix(.Row, 1)) = "" Then
           Screen.MousePointer = 0
           MsgBox "Falta Ingresar el Nombre de Un Corresponsal ", 16, TITSISTEMA
           Valida_Ingreso_graba = False
           
            .Col = 1
           .SetFocus
           Exit Function
       End If
         
   Next Fila
              
End With
        
End Function

 Private Sub Buscar()
  
  Dim Datos(), datos1()
  Dim I As Integer
  Dim Sw As Integer
  Dim Sql As String
     
   Sql = "SP_TRAER_SALDO_CUENTA " & var1 & "," & VAR2
   Sw = 0
     
     Toolbar1.Buttons(2).Enabled = False
     TxtCodigo.BackColor = &H8000000E
     TxtCodigo.ForeColor = &H80000008
     'txtRut.Enabled = True
     'txtRut.SetFocus
     TxtRut.Enabled = False
     TxtCodigo.Enabled = False
     txtDigito.Enabled = False
     TxtNombre.Enabled = False

     Call cargar_grilla
   
   Grid.Enabled = True
   Grid.AddItem ("")
   Grid.TextMatrix(Grid.Row, 8) = "NO"
   Grid.TextMatrix(Grid.Row, 9) = gsBAC_Fecp
   Grid.RowHeight(2) = 315
   Grid.Row = 2
    
   Envia = Array(CDbl(var1), CDbl(VAR2))
      
   If Bac_Sql_Execute("sp_corresponsales_buscar ", Envia) And Sw = 0 Then
     
     I = 2
     Grid.Enabled = True
     
     Do While Bac_SQL_Fetch(Datos())
        
        Sw = 1
        
         Grid.Rows = I + 1
         Grid.RowHeight(Grid.Rows - 1) = 315
         Grid.RowHeight(I) = 315
         TxtNombre.Text = Datos(13)
         Grid.TextMatrix(I, 1) = Datos(10) + Space(50) + Datos(1)
         Grid.TextMatrix(I, 2) = Datos(11) + Space(50) + Datos(2)
         Grid.TextMatrix(I, 3) = Datos(12) + Space(50) + Datos(3)
         Grid.TextMatrix(I, 4) = Datos(4)
         Grid.TextMatrix(I, 5) = Datos(5)
         Grid.TextMatrix(I, 6) = Datos(6)
         Grid.TextMatrix(I, 7) = Datos(7)
         Grid.TextMatrix(I, 8) = Datos(8)
         Grid.TextMatrix(I, 9) = Datos(9)
         Grid.TextMatrix(I, 10) = Datos(14)
         
         I = I + 1
        
         Toolbar1.Buttons(3).Enabled = True
         
      Loop
                 
  End If
  
 
 If Sw = 0 Then
     
     If BUS = 1 Then
      SWGRA = 1
      TxtRut.Enabled = False
      TxtCodigo.Enabled = False
      TxtNombre.Enabled = False
      'Grid.AddItem ("")
      Grid.Row = Grid.FixedRows
      Grid.Row = 2
      Grid.RowHeight(2) = 315
      Grid.Enabled = True
      Grid.Col = 1
      Grid.SetFocus
     
     Else
      
     
        Dim f As Integer
        f = MsgBox("Cliente No Registrado,¿Desea Consultar Ayuda? ", vbOKCancel, TITSISTEMA)
      

        If f = 1 Then
         
         Call llamarayuda
         SWGRA = 1
        Else
          
          Call Limpiar
          TxtRut.Enabled = True
          TxtRut.SetFocus
          TxtCodigo.Enabled = False
                  
        End If
        
    End If
           
     
  Else
    SWGRA = 2
   '  Grid.AddItem ("")
    '  Grid.Row = Grid.FixedRows
     ' Grid.Row = 2
     ' Grid.RowHeight(2) = 315
     
      Grid.Col = 1
      Grid.Row = Grid.FixedRows
      Grid.SetFocus
      Toolbar1.Buttons(4).Enabled = True
      
      
  End If
  
If KeyCode = 46 Then
  Toolbar1.Buttons(2).Enabled = True
  Call Eliminar
End If

End Sub
Sub dibujar_grilla()

 Grid.Clear
 Grid.Cols = 5
' Grid.FixedRows = 2
' Grid.FixedCols = 0
    
  Grid.TextMatrix(0, 1) = "Cuenta"
  Grid.TextMatrix(0, 2) = "Glosa"
  Grid.TextMatrix(0, 3) = "Imprime "
  Grid.TextMatrix(0, 4) = "Brecha"
      
  Grid.RowHeight(0) = 500
  
  Grid.ColWidth(0) = 0
    
  Grid.ColWidth(1) = 1000
  Grid.ColWidth(2) = 2200
  Grid.ColWidth(3) = 1300
  Grid.ColWidth(4) = 1300
    
  'For m = 0 To Grid.Rows - 2
  '    Grid.RowHeight(m) = 227
  'Next m
  
  '  For m = 0 To Grid.Rows - 1
  '      For mm = 0 To Grid.Cols - 1
  '          Grid.Col = mm
  '          Grid.Row = m
  '          Grid.CellFontBold = True
  '          Grid.GridLinesFixed = flexGridNone
  '      Next mm
  ' Next m
  '  Grid.CellFontBold = False
  '  Grid.Rows = Grid.Rows - 1
  ' If Grid.Rows > 2 Then
  '    Grid.Col = 0
  '    Grid.ColSel = Grid.Cols - 1
  ' Else
  '    Grid.Col = 0
  '    Grid.ColSel = 0
  ' End If
 'Grid.Enabled = False
 
 
 'End If
 
 
End Sub

Private Sub Cmb_Moneda_Click()
   
    cmb_Moneda_KeyPress (CmbKey)
    CmbKey = 0

End Sub

Private Sub cmb_Moneda_GotFocus()

    'If Grid.Text <> "" Then
        
    '   cmb_Moneda = Grid.Text
    
    'End If
    
    cmb_pais.Visible = False
    cmb_plaza.Visible = False
    cmbBANCE.Visible = False
    txtFecha1.Visible = False
    TXTGRILLA.Visible = False
    txtgrilla2.Visible = False
    txtgrilla3.Visible = False
    txtgrilla4.Visible = False

End Sub

Private Sub cmb_Moneda_KeyDown(KeyCode As Integer, Shift As Integer)

   CmbKey = KeyCode

End Sub

Private Sub cmb_Moneda_KeyPress(KeyAscii As Integer)

If KeyAscii = 13 And cmb_Moneda <> "" Then
   
   Dim Ind, Sub_ind As Integer
   Dim Busq As String
     
   Text1.Text = ""
   Text1.Text = cmb_Moneda
   Busq = Text1.Text
      
  
   If Grid.Rows > 3 Then
          
          Grid.Text = Busq
          
          If Verifica_Existencia(Mid(Grid.TextMatrix(Grid.Row, 1), 1, 50), Mid(Grid.TextMatrix(Grid.Row, 2), 1, 50), Mid(Grid.TextMatrix(Grid.Row, 3), 1, 50), Mid(Grid.TextMatrix(Grid.Row, 4), 1, 50)) Then
                
                MsgBox "Moneda No se Puede Repetir", vbCritical, TITSISTEMA
                cmb_Moneda_KeyPress (27)
                
                Exit Sub
          Else
            
                cmb_Moneda.Tag = cmb_Moneda.Text
          
          End If
          
'''''          Cont = 0
'''''
'''''          For Sub_ind1 = 1 To Grid.Rows - 1
'''''               'If Ind1 <> Sub_ind1 Then
'''''                    If Trim(Mid(Grid.TextMatrix(Sub_ind1, 1), 1, 50)) = Trim(Mid(Busq, 1, 50)) Then
'''''                        Cont = Cont + 1
'''''                    End If
'''''                    If Grid.TextMatrix(Grid.Row, Grid.Col) = Busq Then
'''''
'''''                        Cont = Cont - 1
'''''
'''''                    End If
'''''               'End If
'''''          Next Sub_ind1
'''''
'''''        'Next Ind1
'''''
'''''        If Cont > 0 Then MsgBox "Moneda No se Puede Repetir ": Exit Sub

   End If
  
    'cmb_Moneda.Visible = False
    'Grid.Text = cmb_Moneda
    'Grid.Col = 2
    'Grid.SetFocus
  
End If


    If KeyAscii = 27 Then
         
         cmb_Moneda.Visible = False
         Grid.Text = cmb_Moneda.Tag
         'Grid.Col = 2
         Grid.SetFocus
    
    End If
    
    If KeyAscii = 13 Then
    On Error GoTo fin
        'cmb_Moneda.Tag = Grid.Text
        Grid.Text = cmb_Moneda.Text
        cmb_Moneda.Visible = False
        Grid.SetFocus
    
    End If
    
fin:
End Sub


Private Sub cmb_Moneda_LostFocus()

    If cmb_Moneda.Visible = True Then
        
        'Grid.Text = cmb_Moneda.Tag
        cmb_Moneda.Visible = False
    
    End If
    
End Sub


Private Sub cmb_pais_Click()

    cmb_pais_KeyPress (CmbKey)
    CmbKey = 0

End Sub

Private Sub cmb_pais_GotFocus()

    paisactivo = 1
    
'    If Grid.Col = 2 And Grid.Text <> "" Then
    
'        cmb_pais = Grid.Text
    
'    End If
    
    pais = 0
    Escape = 0
    cmb_Moneda.Visible = False
    cmb_plaza.Visible = False
    cmbBANCE.Visible = False
    txtFecha1.Visible = False
    TXTGRILLA.Visible = False
    txtgrilla2.Visible = False
    txtgrilla3.Visible = False
    txtgrilla4.Visible = False

End Sub


Private Sub cmb_pais_KeyDown(KeyCode As Integer, Shift As Integer)

   CmbKey = KeyCode

End Sub


Private Sub cmb_plaza_Click()

    cmb_plaza_KeyPress (CmbKey)
    
    CmbKey = 0

End Sub

Private Sub cmb_plaza_GotFocus()
  
   'If Grid.Text <> "" And cmb_plaza.ListCount > 0 Then
      
   '   cmb_plaza = Grid.Text
   
   'End If
   
   
    If Grid.Col = 2 And Grid.Text = "" And cmb_plaza.ListCount = 0 Then
         
       MsgBox "Se Requiere de un Pais ", vbInformation, TITSISTEMA
       Grid.SetFocus
       cmb_plaza.Visible = False
       ' cmb_pais.Visible = True
    'Else
       ' cmb_plaza.ListIndex = 0
    End If
    
    cmb_pais.Visible = False
    cmb_Moneda.Visible = False
    cmbBANCE.Visible = False
    txtFecha1.Visible = False
    TXTGRILLA.Visible = False
    txtgrilla2.Visible = False
    txtgrilla3.Visible = False
    txtgrilla4.Visible = False

End Sub

Private Sub cmb_plaza_KeyDown(KeyCode As Integer, Shift As Integer)

   CmbKey = KeyCode
   CmbKey = 0

End Sub

Private Sub cmb_plaza_KeyPress(KeyAscii As Integer)
 
    If KeyAscii = 27 Then
       
       cmb_plaza.Visible = False
       'Grid.Text = cmb_plaza
       'Grid.Col = 2
       Grid.Text = ""
       Grid.SetFocus
    
    End If

   If KeyAscii = 13 Then
        
        Grid.Text = cmb_plaza.Text
        
        If Verifica_Existencia(Mid(Grid.TextMatrix(Grid.Row, 1), 1, 50), Mid(Grid.TextMatrix(Grid.Row, 2), 1, 50), Mid(Grid.TextMatrix(Grid.Row, 3), 1, 50), Mid(Grid.TextMatrix(Grid.Row, 4), 1, 50)) Then

            MsgBox "No se puede repetir la plaza", vbExclamation, TITSISTEMA
            cmb_plaza_KeyPress (27)
            
        Else
            
            cmb_plaza.Tag = Grid.Text
            cmb_plaza.Visible = False
            Grid.Text = cmb_plaza + Space(50) + Trim(Right(cmb_plaza.Text, 50))
    ''''        'Grid.Col = 4
            Grid.SetFocus
        
        End If

        Grid.SetFocus
    
    End If
 
End Sub


Private Sub cmb_plaza_LostFocus()

    If cmb_plaza.Visible = True Then
    
       ' Grid.Text = cmb_plaza.Tag
        cmb_plaza.Visible = False
    
    End If

End Sub

Private Sub cmbBANCE_Click()

    cmbBANCE_KeyPress (CmbKey)
    CmbKey = 0

End Sub

Private Sub cmbBANCE_GotFocus()

If Grid.Text <> "" Then

'    cmbBANCE = Grid.Text

End If

'cmb_pais.Visible = False
'cmb_plaza.Visible = False
'cmb_Moneda.Visible = False
'txtFecha1.Visible = False
TXTGRILLA.Visible = False
txtgrilla2.Visible = False
txtgrilla3.Visible = False
txtgrilla4.Visible = False

End Sub

Private Sub cmbBANCE_KeyDown(KeyCode As Integer, Shift As Integer)

   CmbKey = KeyCode

End Sub

Private Sub cmbBANCE_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 And cmbBANCE <> "" Then
       
       Grid.Col = 3
       cmbBANCE.Tag = Grid.Text
       cmbBANCE.Visible = False
       Grid.Text = cmbBANCE
       Grid.SetFocus
    
    End If

   If KeyAscii = 27 And Grid.Col = 3 Then
        
        Grid.Col = 3
        Grid.Text = cmbBANCE.Tag
        cmbBANCE.Visible = False
        Grid.Text = cmbBANCE
        'Grid.Col = 7
        Grid.SetFocus
 
   End If
End Sub


Private Sub cmbBANCE_LostFocus()

    If cmbBANCE.Visible = True Then

        'Grid.Col = 8
        'Grid.Text = cmbBANCE.Tag
        cmbBANCE.Visible = False
        Grid.SetFocus
    
    End If


End Sub


Private Sub Grid_EnterCell()
 
 
'If Grid.Col = 3 Then
 
'  cmb_plaza.Clear
  'If KeyCode <> 13 Then
 
     'If Bac_Sql_Execute("Sp_corresponsales_cmbplaza") Then
        
     '   Do While Bac_SQL_Fetch(Datos())
         
      '   If Trim(Right(Grid.TextMatrix(Grid.Row, Grid.Col - 1), 50)) = Datos(3) Then 'cmb_pais.ItemData(cmb_pais.ListIndex) = datos(3)
            
       '     cmb_plaza.AddItem Datos(2) + Space(50) + Datos(1)
        '    cmb_plaza.ItemData(cmb_plaza.NewIndex) = Datos(1)
            'Grid.Col = 3
            'Grid.Text = ""
            
         'End If
        
        'Loop
      
     ' End If
    
      'Grid.Col = 3
      'Grid.SetFocus
 'End If
 
'End If
 
End Sub

Private Sub Grid_Click()

    Toolbar1.Buttons(1).Enabled = True

      
  ' If Grid.Col = 1 Then
  '      TXTGRILLA.Height = Grid.CellHeight
  '      TXTGRILLA.Top = Grid.CellTop + Grid.Top
  '      TXTGRILLA.Left = Grid.CellLeft + Grid.Left + 20
  '      TXTGRILLA.Width = Grid.CellWidth - 20
  '      TXTGRILLA.Visible = True
  '      TXTGRILLA.SetFocus
  ' End If
   'If Grid.Col = 2 Then
   '      txtgrilla2.Height = Grid.CellHeight
   '      txtgrilla2.Top = Grid.CellTop + Grid.Top
   '      txtgrilla2.Left = Grid.CellLeft + Grid.Left + 20
   '      txtgrilla2.Width = Grid.CellWidth - 20
   '      txtgrilla2.Visible = True
   '      txtgrilla2.SetFocus

   'End If
     ' If Grid.Col = 3 Then
     '    txtgrilla3.Height = Grid.CellHeight
     '    txtgrilla3.Top = Grid.CellTop + Grid.Top
     '    txtgrilla3.Left = Grid.CellLeft + Grid.Left + 20
     '    txtgrilla3.Width = Grid.CellWidth - 20
     '    txtgrilla3.Visible = True
     '    txtgrilla3.SetFocus

    'End If
  
   
   If Grid.Col = 3 Then
      cmbBANCE.Top = Grid.CellTop + 580
      cmbBANCE.Left = Grid.CellLeft - 60
      cmbBANCE.Width = Grid.CellWidth
      Var = Grid.Text
      If Var = "NO" Then
        cmbBANCE = "NO"
        Grid.Col = 3: Grid.Text = "NO"
      ElseIf Var = "SI" Then
        cmbBANCE = "SI"
        Grid.Col = 3: Grid.Text = "SI"
       End If
      cmbBANCE.Visible = True
      cmbBANCE.SetFocus

   End If
   
   If Grid.Col = 4 Then
        TXTGRILLA.Text = Grid.Text
        TXTGRILLA.Height = Grid.CellHeight
        TXTGRILLA.Top = Grid.CellTop + 580
        TXTGRILLA.Left = Grid.CellLeft - 65
        TXTGRILLA.Width = Grid.CellWidth - 10
        TXTGRILLA.Visible = True
        TXTGRILLA.SetFocus
        Grid.Col = 4: Grid.Text = TXTGRILLA.Text
        
   End If

 ' If Grid.Col = 10 Then
 '    txtNumCodCorres.Height = Grid.CellHeight
 '    txtNumCodCorres.Top = Grid.CellTop + Grid.Top
 '    txtNumCodCorres.Left = Grid.CellLeft + Grid.Left + 20
 '    txtNumCodCorres.Width = Grid.CellWidth - 20
 '    txtNumCodCorres.Visible = True
 '    txtNumCodCorres.SetFocus
 ' End If
  
End Sub


Private Sub Grid_GotFocus()
    
    Toolbar1.Buttons(4).Enabled = True
    Toolbar1.Buttons(2).Enabled = False
    
End Sub

Private Sub Grid_KeyUp(KeyCode As Integer, Shift As Integer)
On Error GoTo ErrorF:
    If inicio = 1 Then
    
        Grid.Col = colpress
        Grid.Row = rowpress
        Grid.ColSel = colpress

    End If

    inicio = 1
ErrorF:
End Sub

Private Sub Grid_MouseDown(Button As Integer, Shift As Integer, x As Single, Y As Single)

    If inicio = 1 Then
    
        colpress = Grid.Col
        rowpress = Grid.Row
        Grid.ColSel = colpress
    
    End If

End Sub

Private Sub Grid_MouseUp(Button As Integer, Shift As Integer, x As Single, Y As Single)
On Error GoTo fin:
    If inicio = 1 Then
    
        Grid.Col = colpress
        Grid.Row = rowpress
        Grid.ColSel = colpress
    
    End If
    
    inicio = 1
    
fin:
End Sub

Private Sub Grid_Scroll()
    
'    cmb_Moneda.Visible = False
'    cmb_pais.Visible = False
'    cmb_plaza.Visible = False
    cmbBANCE.Visible = False
'    txtFecha1.Visible = False
    TXTGRILLA.Visible = False
    txtgrilla2.Visible = False
    txtgrilla3.Visible = False
    txtgrilla4.Visible = False

End Sub



Private Sub txtcodigo_GotFocus()

    TxtCodigo.BackColor = &H8000000D
    TxtCodigo.ForeColor = &H8000000E

End Sub

Private Sub txtCodigo_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = 13 And TxtCodigo <> "" Then
    
   Call Buscar
   TxtNombre.Enabled = False
  
End If
End Sub

Private Sub TxtCodigo_LostFocus()

    TxtCodigo.BackColor = &H8000000E
    TxtCodigo.ForeColor = &H80000008

End Sub


Private Sub txtDigito_KeyPress(KeyAscii As Integer)

   If KeyAscii% = vbKeyReturn Then
      KeyAscii% = 0
      SendKeys$ "{TAB}"
      'txtCodigo.SetFocus
   ElseIf Not ((KeyAscii > 47 And KeyAscii < 58) Or KeyAscii = 75 Or KeyAscii = 107 Or KeyAscii = 8) Then
      KeyAscii = 0

   End If

   BacToUCase KeyAscii

End Sub

Private Sub txtDigito_LostFocus()

If TxtRut.Text <> "" Then
    If Digito <> txtDigito.Text Then
        MsgBox "Digito No corresponde al RUT.", vbOKOnly + vbExclamation, TITSISTEMA
        txtDigito.Text = ""
        txtDigito.SetFocus
    Else
       ' txtCodigo.SetFocus
    End If
End If

End Sub

Private Sub txtFecha1_Change()

          On Error GoTo fin:
          Grid.Col = 9
          txtFecha1.Tag = Grid.Text
          'txtFecha1.Visible = False
          Grid.Text = txtFecha1.Text
          'Grid.SetFocus
            
          Cont = 0

          If Format(Grid.Text, "yyyy") > Format(Date, "yyyy") Then Cont = 1
          If Format(Grid.Text, "yyyy") = Format(Date, "yyyy") And Format(Grid.Text, "mm") = Format(Date, "mm") And Format(Grid.Text, "dd") >= Format(Date, "dd") Then Cont = 1
          If Format(Grid.Text, "yyyy") = Format(Date, "yyyy") And Format(Grid.Text, "mm") > Format(Date, "mm") Then Cont = 1
          
          If Cont = 0 Then
                
                Grid.Text = txtFecha1.Tag
                txtFecha1.Text = txtFecha1.Tag
                
          End If
 

 
fin:


End Sub

Private Sub txtFecha1_GotFocus()

    If Grid.Text <> "" Then
    
        txtFecha1.Text = Grid.Text
    
    End If
    
    
    txtFecha1.BackColor = &H8000000D
    txtFecha1.ForeColor = &H8000000E
    
    cmb_pais.Visible = False
    cmb_plaza.Visible = False
    cmbBANCE.Visible = False
    cmb_Moneda.Visible = False
    TXTGRILLA.Visible = False
    txtgrilla2.Visible = False
    txtgrilla3.Visible = False
    txtgrilla4.Visible = False
    txtNumCodCorres.Visible = False

End Sub

Private Sub txtFecha1_KeyPress(KeyAscii As Integer)

If KeyAscii = 45 Then
      If CAMPOS_BLANCOS = 0 Then
        Grid.Col = 1
        Grid.SetFocus
        Grid.AddItem ("")
        Grid.RowHeight(Grid.Rows - 1) = 315 'Grid.Rows - 1
        Grid.SetFocus
      Else
        MsgBox "Debe Insertar Datos Antes de Insertar una Nueva Fila", vbOKOnly, TITSISTEMA
        Grid.SetFocus
      End If
Else
  
      If KeyAscii = 27 And Grid.Col = 9 Then
           Grid.Col = 9
             txtFecha1.Visible = False
'            If Grid.Text >= Date Then
'               Grid.Col = 8
'            Else
'               Grid.Col = 9
'           End If
           Grid.SetFocus
           
                          
      End If
      If KeyAscii = 13 Then
      On Error GoTo fin:
          Grid.Col = 9
          txtFecha1.Tag = Grid.Text
          txtFecha1.Visible = False
          Grid.Text = txtFecha1.Text
          Grid.SetFocus
            
          Cont = 0

          If Format(Grid.Text, "yyyy") > Format(Date, "yyyy") Then Cont = 1
          If Format(Grid.Text, "yyyy") = Format(Date, "yyyy") And Format(Grid.Text, "mm") = Format(Date, "mm") And Format(Grid.Text, "dd") >= Format(Date, "dd") Then Cont = 1
          If Format(Grid.Text, "yyyy") = Format(Date, "yyyy") And Format(Grid.Text, "mm") > Format(Date, "mm") Then Cont = 1
          
            
            
'''          If Format(Grid.Text, "yyyy") >= Format(Date, "yyyy") Then 'Format(Grid.Text, "dd") >= Format(Date, "dd") And Format(Grid.Text, "mm") >= Format(Date, "mm") And Format(Grid.Text, "yyyy") >= Format(Date, "yyyy") Then
'''
'''                If Format(Grid.Text, "mm") >= Format(Date, "mm") Then
'''
'''                    If Format(Grid.Text, "dd") >= Format(Date, "dd") Then
'''
'''                        Cont = 1
'''                        'Grid.Col = 1
'''                        Grid.SetFocus
'''
'''                    End If
'''
'''                End If
'''
'''          End If
            
          If Cont <> 1 Then
              MsgBox "Error Fecha de Vencimiento Debe ser Mayor o Igual a la Fecha Actual", vbInformation, TITSISTEMA
              txtFecha1.Visible = True
              Grid.Text = txtFecha1.Tag
              txtFecha1.SetFocus
            
          End If
          
       End If
  
 End If

 
fin:
End Sub

Private Sub txtFecha1_LostFocus()

        txtFecha1.BackColor = &H8000000E
        txtFecha1.ForeColor = &H80000008
    
    txtFecha1.Text = Grid.TextMatrix(Grid.Row, 9)
    
    If txtFecha1.Visible = True Then
    
        'Grid.Col = 9
        'Grid.Text = txtFecha1.Tag
        txtFecha1.Visible = False
        Grid.SetFocus
        
    End If
    

End Sub

Private Sub TXTGRILLA_GotFocus()

    If Grid.Text <> "" Then
    
        TXTGRILLA.Text = Grid.Text
    
    End If
    
    
    
    'cmb_pais.Visible = False
   ' cmb_plaza.Visible = False
    cmbBANCE.Visible = False
   ' txtFecha1.Visible = False
   ' cmb_Moneda.Visible = False
    'txtgrilla2.Visible = False
    'txtgrilla3.Visible = False
    'txtgrilla4.Visible = False

End Sub

Private Sub TXTGRILLA_LostFocus()
       
If TXTGRILLA.Visible = True Then

       TXTGRILLA.Visible = False
       TXTGRILLA.Tag = TXTGRILLA.Text
  
      'Grid.Col = 5
      Grid.SetFocus

End If

End Sub

Private Sub txtgrilla2_GotFocus()

    If Grid.Text <> "" Then
        
        txtgrilla2.Text = Grid.Text
    
    End If
    
    cmbBANCE.Visible = False

    TXTGRILLA.Visible = False

    txtgrilla3.Visible = False
    txtgrilla4.Visible = False

End Sub

Private Sub txtgrilla2_LostFocus()
 
  If txtgrilla2.Visible = True Then
        
        txtgrilla2.Visible = False
        'Grid.Col = 6
        Grid.SetFocus
        
  End If

End Sub

Private Sub txtgrilla3_GotFocus()

    If Grid.Text <> "" Then
    
        txtgrilla3.Text = Grid.Text
    
    End If
    
'    cmb_pais.Visible = False
'    cmb_plaza.Visible = False
    cmbBANCE.Visible = False
 '   txtFecha1.Visible = False
 '   TXTGRILLA.Visible = False
 '   txtgrilla2.Visible = False
 '   cmb_Moneda.Visible = False
 '   txtgrilla4.Visible = False

End Sub

Private Sub txtgrilla3_KeyPress(KeyAscii As Integer)
Dim Char As String
Dim SW2 As Integer

KeyAscii = Asc(UCase(Chr(KeyAscii)))

Char = "'/&()?¿%·*+=$<>""@!¡{}¨Ç"
SW2 = 0

For I = 1 To Len(Char)

    If Mid(Char, I, 1) = UCase(Chr(KeyAscii)) Then

        SW2 = 1
        Exit For

    End If

Next I

If SW2 = 1 Then

    KeyAscii = 0

End If


  If KeyCode = 45 Then
      
      If CAMPOS_BLANCOS = 0 Then
          
          Grid.Col = 1
          Grid.SetFocus
          Grid.AddItem ("")
          Grid.RowHeight(Grid.Rows - 1) = 313 'Grid.Rows - 1
          Grid.SetFocus
     
     Else
        
        MsgBox "Debe Insertar Datos Antes de Insertar una Nueva Fila", vbOKOnly, TITSISTEMA
        Grid.SetFocus
     
     End If
 
 End If
 
        If KeyAscii = 27 Then
             
             txtgrilla3.Visible = False
             txtgrilla3.Text = ""
             txtgrilla3.Text = Grid.Text
             Grid.Text = txtgrilla3.Text
             'Grid.Col = 7
             Grid.SetFocus
         
        End If
            
  
 

        If KeyAscii = 13 And Grid.Col = 6 Then
            
            txtgrilla3.Visible = False
            txtgrilla3.Tag = Grid.Text
            Grid.Text = txtgrilla3.Text
           
            'Grid.Col = 7
            Grid.SetFocus
          
        End If

End Sub


Private Sub txtgrilla3_LostFocus()
    
    If txtgrilla3.Visible = True Then
                
        'Grid.Col = 6
        txtgrilla3.Visible = False
        'Grid.Text = txtgrilla3.Tag
        
        'Grid.Col = 7
        Grid.SetFocus
    
    End If

End Sub

Private Sub txtgrilla4_GotFocus()

    If Grid.Text <> "" Then
        
        txtgrilla4.Text = Grid.Text
    
    End If
    
    
    cmb_pais.Visible = False
    cmb_plaza.Visible = False
    cmbBANCE.Visible = False
    txtFecha1.Visible = False
    TXTGRILLA.Visible = False
    txtgrilla2.Visible = False
    txtgrilla3.Visible = False
    cmb_Moneda.Visible = False

End Sub

Private Sub txtgrilla4_KeyPress(KeyAscii As Integer)
Dim Char As String
Dim SW2 As Integer

KeyAscii = Asc(UCase(Chr(KeyAscii)))
Char = "'/&()?¿%·*+=$<>""@!¡{}¨Ç-"
SW2 = 0

For I = 1 To Len(Char)

    If Mid(Char, I, 1) = UCase(Chr(KeyAscii)) Then

        SW2 = 1
        Exit For

    End If

Next I



If KeyAscii = 13 Then
If Len(Trim(txtgrilla4.Text)) = 8 Or Len(Trim(txtgrilla4.Text)) = 11 Then
    Grid.TextMatrix(Grid.Row, 7) = Trim(txtgrilla4.Text)
    txtgrilla4.Visible = False
    Grid.SetFocus
    Exit Sub
Else
    
    MsgBox " El código debe ser de largo de 8 o 11", 16
    Grid.TextMatrix(Grid.Row, 7) = ""
    txtgrilla4.Text = ""
    txtgrilla4.SetFocus
    Exit Sub
End If
End If






If SW2 = 1 Then

    KeyAscii = 0

End If

    If KeyAscii = 45 Then
         
         If CAMPOS_BLANCOS = 0 Then
              
              Grid.Col = 1
              Grid.SetFocus
              Grid.AddItem ("")
              Grid.RowHeight(Grid.Rows - 1) = 313 'Grid.Rows - 1
              Grid.SetFocus
         
         Else
            
            MsgBox "Debe Insertar Datos Antes de Insertar una Nueva Fila", vbOKOnly, TITSISTEMA
            Grid.SetFocus
         
         End If
     Else
     
        If KeyAscii = 27 Then
             
             txtgrilla4.Visible = False
             txtgrilla4.Text = ""
             txtgrilla4.Text = Grid.Text
             Grid.Text = txtgrilla4.Text
             Grid.SetFocus
        
        End If
            
        If KeyAscii = 13 And Grid.Col = 7 Then
            
             txtgrilla4.Visible = False
             Grid.Text = txtgrilla4.Text
             Grid.SetFocus
        
        End If
      
     
    End If

End Sub


Private Sub txtgrilla4_LostFocus()
 
If txtgrilla4.Visible = True Then
    txtgrilla4.Visible = False
    'Grid.Col = 8
    Grid.SetFocus
End If

End Sub

Private Sub txtNombre_GotFocus()

    TxtNombre.BackColor = &H8000000D
    TxtNombre.ForeColor = &H8000000E

End Sub

Private Sub txtNombre_LostFocus()

    TxtNombre.BackColor = &H8000000E
    TxtNombre.ForeColor = &H80000008

End Sub

Private Sub c_DblClick()
       
    BUS = 1
    Call llamarayuda
    Grid.Col = 1
    
End Sub

Private Sub txtNumCodCorres_GotFocus()
 txtNumCodCorres.BackColor = &H8000000D
 txtNumCodCorres.ForeColor = &H8000000E
 'If Grid.Text <> "" Then
 '   txtNumCodCorres.Text = Grid.Text
 'End If
End Sub


Private Sub txtNumCodCorres_KeyPress(KeyAscii As Integer)
Dim Char As String
Dim SW2 As Integer

KeyAscii = Asc(UCase(Chr(KeyAscii)))

Char = "'/&()?¿%·*+=$<>""@!¡{}¨Ç"
SW2 = 0

For I = 1 To Len(Char)

    If Mid(Char, I, 1) = UCase(Chr(KeyAscii)) Then

        SW2 = 1
        Exit For

    End If

Next I

If SW2 = 1 Then

    KeyAscii = 0

End If


  If KeyCode = 45 Then
      
      If CAMPOS_BLANCOS = 0 Then
          
          Grid.Col = 1
          Grid.SetFocus
          Grid.AddItem ("")
          Grid.RowHeight(Grid.Rows - 1) = 313 'Grid.Rows - 1
          Grid.SetFocus
     
     Else
        
        MsgBox "Debe Insertar Datos Antes de Insertar una Nueva Fila", vbOKOnly, TITSISTEMA
        Grid.SetFocus
     
     End If
 
 End If
 
        If KeyAscii = 27 Then
             
             txtNumCodCorres.Visible = False
             txtNumCodCorres.Text = ""
             txtNumCodCorres.Text = Grid.Text
             Grid.Text = txtNumCodCorres
             'Grid.Col = 7
             Grid.SetFocus
         
        End If
            
  
        If KeyAscii = 13 And Grid.Col = 10 Then
        txtNumCodCorres.Visible = False
        txtNumCodCorres.Tag = Grid.Text
        Grid.Text = txtNumCodCorres.Text
        
        End If
        
End Sub

Private Sub txtRut_DblClick()

Call llamarayuda

End Sub

Private Sub txtrut_GotFocus()

    Toolbar1.Buttons(2).Enabled = True
    Toolbar1.Buttons(4).Enabled = False
    'txtRut.BackColor = &H8000000D
    'txtRut.ForeColor = &H8000000E

End Sub


Private Sub txtRut_KeyDown(KeyCode As Integer, Shift As Integer)

    If KeyCode = 13 And TxtRut <> "0" Then
    
         TxtCodigo.Enabled = True
         txtDigito.SetFocus
    
       
    End If
    
    If KeyCode = vbKeyF3 Then Call txtRut_DblClick
    
    If KeyCode = 27 Then
     
     Unload Baccorrespon
    
    End If



End Sub

Private Sub Form_Load()
    
    Me.Top = 0
    Me.Left = 0
      
    Call Limpiar
    Call cargar_grilla
     
    Toolbar1.Buttons(2).Visible = False
  
     
     
End Sub

Sub Limpiar()
        
      CmbKey = 0
     Toolbar1.Buttons(1).Enabled = False
     cmbBANCE.Visible = False
     TXTGRILLA.Visible = False
     txtgrilla2.Visible = False
     txtgrilla3.Visible = False
     txtgrilla4.Visible = False
     txtNumCodCorres.Visible = False

     TXTGRILLA.Text = ""
     txtgrilla2.Text = ""
     txtgrilla3.Text = ""
     txtgrilla4.Text = ""
     txtNumCodCorres.Text = 0
       
   Grid.Clear
   Grid.Rows = 2
   
   dibujar_grilla
        
        
End Sub
Sub Correspon_Carga_Datos()


   
End Sub
Private Sub Grid_KeyDown(KeyCode As Integer, Shift As Integer)
Dim SW3 As Integer
Dim Y As Integer
Dim g As Integer
Dim k As Integer
Dim I As Integer
    
    Toolbar1.Buttons(1).Enabled = True
    
    If KeyCode = 45 Then
       
       SWGRA = 1
       TXTGRILLA.Text = ""
       txtgrilla2.Text = ""
       txtgrilla3.Text = ""
       txtgrilla4.Text = ""
     
     If CAMPOS_BLANCOS = 1 Then
          
          MsgBox "Deben haber datos antes de Insertar Otra fila", vbOKOnly, TITSISTEMA
          Grid.SetFocus
        
     Else
         
         Grid.Col = 1
         Grid.SetFocus
         Grid.AddItem ("")
         Grid.TextMatrix(Grid.Row + 1, 8) = "NO"
         Grid.TextMatrix(Grid.Row + 1, 9) = Date
         Grid.RowHeight(Grid.Rows - 1) = 315 'Grid.Rows - 1
         Grid.SetFocus
     
     End If
    
    End If
    
    If KeyCode = 46 Then
        On Error GoTo Fin2:
        Cont = 0
        
        'For I = 1 To Grid.Cols - 1
            
       '     If Grid.TextMatrix(Grid.Row, I) = "" Then
       '         Cont = Cont + 1
       '
       '     End If
       '
       ' Next I
    If MsgBox("¿Seguro de eliminar este Corresponsal?", vbYesNo, TITSISTEMA) = vbYes Then
        If Grid.Rows > 2 Then
          
           ' Call Eliminar
            Grid.RemoveItem (Grid.Row)

            Limpia
        Else
            
           'Call Eliminar
            Limpia
            Exit Sub
                   
        End If
        
    End If
  End If

    If inicio = 1 Then
    
        colpress = Grid.Col
        rowpress = Grid.Row
        Grid.ColSel = colpress
    
    End If

    Grid.SetFocus


    Exit Sub

Fin2:

    'Colpress = 1
    'Rowpress = 2
    'Grid.ColSel = Colpress
    
    For I = 1 To Grid.Cols - 1
    
        Grid.TextMatrix(Grid.Row, I) = ""
        
    Next I
    
    If Grid.Rows > 3 Then
    
        Grid.Col = 1
        Grid.Row = 2
        Grid.SetFocus
        
    Else
        
        Grid.Col = 0
        Grid.Row = 0
            
    End If
    Limpia
    
End Sub
Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Dim I As Integer
   Dim var1 As String
   Dim Sw As Integer
   Dim VAR2 As Integer
   Dim Datos()
   
   If TXTGRILLA.Visible = True Then
   
        txtgrilla_KeyPress (13)
   
   End If
   If txtgrilla2.Visible = True Then
   
        txtgrilla2_KeyPress (13)
   
   End If
   If txtgrilla3.Visible = True Then
   
        txtgrilla3_KeyPress (13)
   
   End If
   If txtgrilla4.Visible = True Then
   
        txtgrilla4_KeyPress (13)
   
   End If
   
'   If cmb_Moneda.Visible = True Then
   
'        cmb_Moneda_KeyPress (13)
   
'   End If
'   If cmb_plaza.Visible = True Then
   
'        cmb_plaza_KeyPress (13)
   
'   End If
 '  If cmb_pais.Visible = True Then
   
  '      cmb_pais_KeyPress (13)
   
  ' End If
   'If cmbBANCE.Visible = True Then
  '
  '      cmb_pais_KeyPress (13)
   
  ' End If
  ' If txtFecha1.Visible = True Then
   
  '      txtFecha1_KeyPress (13)
   
 '  End If
 '  If txtNumCodCorres.Visible = True Then
 '     txtNumCodCorres_KeyPress (13)
 '  End If
   
   
   Select Case Button.Index
       Case 1
       
  '           If CAMPOS_BLANCOS = 0 Then
  '
  '             Call guardar
  '             Call Limpiar
  '             TxtRut.Enabled = True
  '             cmb_Moneda.Enabled = True
  '             TxtRut.SetFocus
  '
  '           Else
  '              MsgBox "Campos en Blanco  ", vbCritical, TITSISTEMA
  '              Grid.SetFocus
  '           End If
       
       Case 2
   '             If TxtRut.Text <> "0" And TxtCodigo.Text <> "0" Then
   '
   '                 Call Buscar
   '                 Grid.Row = 2
   '                 Grid.ColSel = 0
   '
   '             Else
                  
                  'MsgBox "Se Requiere un Cliente ", vbInformation, "Información"
   '                 Call llamarayuda
                
   '             End If
      
      Case 3
          
                'Call Eliminar
                 'On Error GoTo fin2:
                 'Toolbar1.Buttons(2).Enabled = True
                 'Grid.RemoveItem (Grid.Row)
   '              Call Eliminar
                 'Toolbar1.Buttons(1).Enabled = True

          
      Case 4
         
         
                
                Call Limpiar
    '            TxtRut.Enabled = True
    '            TxtRut.SetFocus
    '            Toolbar1.Buttons(3).Enabled = False
      
         
      Case 5
           
           Unload Me
      
   End Select
 
    Exit Sub
 
End Sub
Private Sub guardar()
Dim Sw As Integer
Dim I As Long
Dim Datos()
Dim Y As Integer
Dim Mensaje, Estilo, Título, Respuesta
Dim rut As Double
  
  SWGRA = 1
  If SWGRA = 1 Then
  

    rut = TxtRut.Text
    Sql = "SP_corresponsales_ELIMINAR " & rut
    Sql = Sql & "," & Val(TxtCodigo.Text)
     
    Envia = Array(rut, CDbl(TxtCodigo.Text))
   
    If Bac_Sql_Execute("SP_corresponsales_ELIMINAR ", Envia) Then
    
    End If
    
    For I = 2 To Grid.Rows - 1
        
        Grid.Row = I

        Sql = "SP_corresponsales_grabar" & " " & Val(TxtRut.Text) & " "
        Sql = Sql & "," & Val(TxtCodigo.Text)
        Sql = Sql & "," & Val(Trim(Right(Grid.TextMatrix(I, 1), 50))) 'cmb_Moneda.ItemData(cmb_Moneda.ListIndex)
        Sql = Sql & "," & Val(Trim(Right(Grid.TextMatrix(I, 2), 50))) 'cmb_pais.ItemData(cmb_pais.ListIndex)
        
            
        'If cmb_plaza.ListIndex >= 0 Then
            
        Sql = Sql & "," & Val(Trim(Right(Grid.TextMatrix(I, 3), 50))) '& cmb_plaza.ItemData(cmb_plaza.ListIndex) '
        
        'End If
        
        var1 = Grid.TextMatrix(I, 4) 'codigo swift
        VAR2 = Grid.TextMatrix(I, 5) 'nombre
        var3 = Grid.TextMatrix(I, 6) 'cuenta corriente
        var4 = Grid.TextMatrix(I, 7) 'swift santiago
        var5 = Mid(Grid.TextMatrix(I, 8), 1, 1) 'banco central
        VAR6 = Grid.TextMatrix(I, 9) 'fecha venci.
        VAR7 = Grid.TextMatrix(I, 10) 'codigo del corresponsal
        Sql = Sql & ",'" & var1 & "'"
        Sql = Sql & ",'" & VAR2 & "'"
        Sql = Sql & ",'" & var3 & "'"
        Sql = Sql & ",'" & var4 & "'"
        Sql = Sql & ",'" & var5 & "'"
        Sql = Sql & ",'" & VAR6 & "'"
        Sql = Sql & ",'" & VAR7 & "'"
       
        Envia = Array(Val(TxtRut.Text), _
                     Val(TxtCodigo.Text), _
                     Val(Trim(Right(Grid.TextMatrix(I, 1), 50))), _
                     Val(Trim(Right(Grid.TextMatrix(I, 2), 50))), _
                     Val(Trim(Right(Grid.TextMatrix(I, 3), 50))), _
                     var1, _
                     VAR2, _
                     var3, _
                     var4, _
                     var5, _
                     VAR6, _
                     Val(VAR7))
                     
                     
                     
         
         If Bac_Sql_Execute("SP_corresponsales_grabar", Envia) Then
            
            If Bac_SQL_Fetch(Datos()) Then
                
                Select Case Datos(1)
                   
                   Case Is = "ok": Sw = 1
                   
                End Select
             
             End If
          
          Else
            
             MsgBox "Problemas en Sql", vbCritical, TITSISTEMA
             Grid.SetFocus
          
          End If
        
      Next I
 
 End If
 
 
 
 
    If Sw = 1 Then
       Toolbar1.Buttons(1).Enabled = True
       MsgBox "La información ha sido Grabada", vbInformation + vbOKOnly, TITSISTEMA
       Grid.SetFocus
     End If
 
   If Sw = 2 Then
      MsgBox "La información ha sido Modificada", vbInformation + vbOKOnly, TITSISTEMA
      Grid.SetFocus
   End If
   
       Toolbar1.Buttons(3).Enabled = False
       Toolbar1.Buttons(2).Enabled = False
       Toolbar1.Buttons(4).Enabled = True

'Toolbar1.Buttons(1).Enabled = False
 
  If KeyCode = 46 Then
   Toolbar1.Buttons(2).Enabled = True
  Call Eliminar
 End If

End Sub
Private Sub txtgrilla_KeyPress(KeyAscii As Integer)

Dim Char As String
Dim SW2 As Integer

KeyAscii = Asc(UCase(Chr(KeyAscii)))
Char = "'/&()?¿%·*+=$<>""@!¡{}¨Ç-"
SW2 = 0

For I = 1 To Len(Char)

    If Mid(Char, I, 1) = UCase(Chr(KeyAscii)) Then

        SW2 = 1
        Exit For

    End If

Next I


If KeyAscii = 13 Then
If Len(Trim(TXTGRILLA.Text)) = 8 Or Len(Trim(TXTGRILLA.Text)) = 11 Then
    Grid.TextMatrix(Grid.Row, 4) = Trim(TXTGRILLA.Text)
    TXTGRILLA.Visible = False
    Grid.SetFocus
    Exit Sub
Else
    
    MsgBox " El código debe ser de largo de 8 o 11", 16
    Grid.TextMatrix(Grid.Row, 4) = ""
    TXTGRILLA.Text = ""
    TXTGRILLA.SetFocus
    Exit Sub
End If
End If

If SW2 = 1 Then

    KeyAscii = 0

End If

If Chr(KeyAscii) = "-" Then GoTo fin:
    


    If KeyAscii = 45 Then
          
          If CAMPOS_BLANCOS = 0 Then
              
              Grid.Col = 1
              Grid.SetFocus
              Grid.AddItem ("")
              Grid.RowHeight(Grid.Rows - 1) = 313 'Grid.Rows - 1
              Grid.SetFocus
         
         Else
            
            MsgBox "Debe Insertar Datos Antes de Insertar una Nueva Fila", vbOKOnly, TITSISTEMA
            Grid.SetFocus
         
         End If
    Else
      If KeyAscii = 27 Then
          
          TXTGRILLA.Visible = False
          TXTGRILLA.Text = ""
          'TXTGRILLA.Text = Grid.Text
          Grid.Text = TXTGRILLA.Tag
          'Grid.Col = 5
          Grid.SetFocus
       
       End If
       
       If KeyAscii = 13 Then
       
            Dim Ind2, Sub_ind2 As Integer
            Dim Busq2 As String
            Text1.Text = ""
            Text1.Text = TXTGRILLA.Text
            Busq2 = Text1.Text
          
      
    
    '''''        'For Ind2 = 1 To Grid.Rows - 1
    '''''
    '''''          For Sub_ind2 = 1 To Grid.Rows - 1
    '''''
    '''''               If Ind2 <> Sub_ind2 Then
    '''''
    '''''                    If Trim(Grid.TextMatrix(Sub_ind2, 4)) = Trim(Busq2) Then MsgBox "Codigo Swift No se Puede Repetir ": Exit Sub
    '''''
    '''''               End If
    '''''
    '''''          Next Sub_ind2
    '''''
    '''''        'Next Ind2
'''''              Cont = 0
'''''
'''''              For Sub_ind1 = 1 To Grid.Rows - 1
'''''                   'If Ind1 <> Sub_ind1 Then
'''''                        If Trim(Grid.TextMatrix(Sub_ind1, 4)) = Trim(Busq2) Then
'''''                            Cont = Cont + 1
'''''                        End If
'''''                        If Grid.TextMatrix(Grid.Row, Grid.Col) = Busq2 Then
'''''
'''''                            Cont = Cont - 1
'''''
'''''                        End If
'''''                   'End If
'''''              Next Sub_ind1
'''''
'''''            'Next Ind1
'''''
'''''            If Cont > 0 Then MsgBox "Codigo Swift No se Puede Repetir ": Exit Sub
            
            Grid.Text = Busq2
            
            If Verifica_Existencia(Mid(Grid.TextMatrix(Grid.Row, 1), 1, 50), Mid(Grid.TextMatrix(Grid.Row, 2), 1, 50), Mid(Grid.TextMatrix(Grid.Row, 3), 1, 50), Mid(Grid.TextMatrix(Grid.Row, 4), 1, 50)) Then
            
                MsgBox "Codigo Swift No se Puede Repetir ", vbInformation, TITSISTEMA
                TXTGRILLA.Text = ""
                txtgrilla_KeyPress (27)
                Exit Sub
            
            End If
            
            TXTGRILLA.Tag = TXTGRILLA.Text
            Grid.Text = TXTGRILLA.Text
            TXTGRILLA.Text = ""
            TXTGRILLA.Visible = False
         
          
         
            'Grid.Col = 5
            Grid.SetFocus
    
       End If
       
     
       If KeyAscii = 13 And Grid.Col = 9 Then
          
          TXTGRILLA.Visible = False
          Grid.Text = TXTGRILLA.Text
          TXTGRILLA.Text = ""
       
       End If
     
     End If
     
     If KeyCode = 46 Then
      
        Toolbar1.Buttons(2).Enabled = True
        Call Eliminar
     
     End If
 
fin:
 
End Sub
Private Sub Grid_KeyPress(KeyAscii As Integer)

Toolbar1.Buttons(1).Enabled = True
'Toolbar1.Buttons(3).Enabled = False
'Toolbar1.Buttons(4).Enabled = True
'Toolbar1.Buttons(5).Enabled = True

'If KeyAscii = 45 Then
'
'   SWGRA = 1
'   TXTGRILLA.Text = ""
'   txtgrilla2.Text = ""
'   txtgrilla3.Text = ""
'   txtgrilla4.Text = ""
'
'   If CAMPOS_BLANCOS = 0 Then
'
'     Grid.Col = 1
'     Grid.SetFocus
'     Grid.AddItem ("")
'
'     Grid.RowHeight(Grid.Rows - 1) = 313 'Grid.Rows - 1
'     Limpia
'     Grid.SetFocus
'    Else
 '     MsgBox "Debe Existir datos antes de Insertar una Nueva Fila", vbOKOnly, TITSISTEMA
'      Grid.SetFocus
''  End If
'Else
' If KeyAscii = 27 Then
'   MsgBox "Operacion Invalida ", vbOKOnly, TITSISTEMA
'   Grid.SetFocus
'  Else
    
If Grid.Col = 3 Then
      cmbBANCE.Top = Grid.CellTop + 580
      cmbBANCE.Left = Grid.CellLeft - 60
      cmbBANCE.Width = Grid.CellWidth
      Var = Grid.Text
      If Var = "NO" Then
        cmbBANCE = "NO"
        Grid.Col = 3: Grid.Text = "NO"
      ElseIf Var = "SI" Then
        cmbBANCE = "SI"
        Grid.Col = 3: Grid.Text = "SI"
       End If
      cmbBANCE.Visible = True
      cmbBANCE.SetFocus

   End If
   
   If Grid.Col = 4 Then
        TXTGRILLA.Text = Grid.Text
        TXTGRILLA.Height = Grid.CellHeight
        TXTGRILLA.Top = Grid.CellTop + 580
        TXTGRILLA.Left = Grid.CellLeft - 65
        TXTGRILLA.Width = Grid.CellWidth - 10
        TXTGRILLA.Visible = True
        TXTGRILLA.SetFocus
        Grid.Col = 4: Grid.Text = TXTGRILLA.Text
        
   End If
  
  
  
          
  End If
   If KeyCode = 46 Then
       'Call Eliminar
       Toolbar1.Buttons(2).Enabled = True
   End If

End If
End Sub
Private Sub txtgrilla2_KeyPress(KeyAscii As Integer)
Dim Char As String
Dim SW2 As Integer

KeyAscii = Asc(UCase(Chr(KeyAscii)))
Char = "'/&()?¿%·*+=$<>""@!¡{}¨Ç-"
SW2 = 0

For I = 1 To Len(Char)

    If Mid(Char, I, 1) = UCase(Chr(KeyAscii)) Then

        SW2 = 1
        Exit For

    End If

Next I

If SW2 = 1 Then

    KeyAscii = 0

End If

If KeyAscii = 45 Then
   
   If CAMPOS_BLANCOS = 0 Then
     
       Grid.Col = 1
       Grid.SetFocus
       Grid.AddItem ("")
       Grid.RowHeight(Grid.Rows - 1) = 315 'Grid.Rows - 1
       Grid.SetFocus
    
    Else
      
       MsgBox "Debe Insertar Datos Antes de Insertar una Nueva Fila", vbOKOnly, TITSISTEMA
       Grid.SetFocus
  
  End If

Else
  
    If KeyAscii = 27 Then
        
        txtgrilla2.Visible = False
        txtgrilla2.Text = ""
        txtgrilla2.Text = Grid.Text
        Grid.Text = txtgrilla2.Text
        'Grid.Col = 6
        Grid.SetFocus
     
     End If
     
     If KeyAscii = 13 Then
        
        txtgrilla2.Visible = False
        Grid.Text = txtgrilla2.Text
        txtgrilla2.Text = ""
        'Grid.Col = 6
        Grid.SetFocus

     End If


End If

If KeyCode = 46 Then
 
    Toolbar1.Buttons(2).Enabled = True
    Call Eliminar

End If

End Sub

Sub Eliminar()
On Error GoTo fin:
Dim Datos()
Dim Y As Integer
Dim Sw As Integer
Dim I As Long
       Grid.SetFocus
 
     If Grid.RowSel >= 2 Then
       If MsgBox("¿Seguro de eliminar Todos los Corresponsal?", vbYesNo, TITSISTEMA) = vbYes Then
            
          Dim rut As Double
         
               If Grid.Rows > 3 Then
         
                  Grid.RemoveItem (Grid.Row)
                  Grid.Row = 2
                  Grid.Col = 1
                           
               Else
               
                  Grid.Rows = 2
                  Grid.AddItem ("")
                  Grid.Row = 1
                  Grid.Col = 0
                  
                  If Grid.Rows > 1 Then
                     
                     'Grid.RowHeight = 315
                  
                  End If
               End If
               
               rut = TxtRut.Text
''             Sql = "SP_corresponsales_ELIMINAR " & rut
''             Sql = Sql & "," & Val(txtCODIGO.Text)
     
               a = Grid.Rows - 1
            
               Envia = Array(rut, CDbl(TxtCodigo.Text))
            
            If Not Bac_Sql_Execute("SP_corresponsales_ELIMINAR ", Envia) Then
               
               MsgBox "PROBLEMAS EN sql", vbCritical, TITSISTEMA
            
            Else
              
              Do While Bac_SQL_Fetch(Datos())
                    
                    Select Case Datos(1)
                          
                        Case "OK"
                             MsgBox "Corresponsal Eliminado", vbInformation, TITSISTEMA
                             Toolbar1.Buttons(3).Enabled = False
                             Grid.Rows = 2
'                             If Grid.Rows = 3 Then
'                              Call Me.Cargar_Grilla
'                             Else
'                              Grid.RemoveItem (Grid.RowSel)
'                              Grid.SetFocus
'                             End If
'
                              'Call Correspon_Limpia
                              'Call Correspon_Carga_Datos
                              'Call Cargar_Grilla
                              Call Limpiar
                              TxtRut.Enabled = True
                              cmb_Moneda.Enabled = True
                              TxtRut.SetFocus

                        Case "NO EXISTE"
                             'MsgBox "No Existe Corresponsal  "
                             Grid.SetFocus
                    End Select
                 
                     '    MsgBox "Error", vbCritical, "Bac-Parametros"
                 Loop
             End If
            
          End If
      

    
    End If
    
    Grid.SetFocus
 
fin:
End Sub

Function CAMPOS_BLANCOS() As Integer
Dim Y As Integer
Dim g As Integer
    Y = Grid.Rows - 1
        CAMPOS_BLANCOS = 0
      For k = 1 To 10
      If Grid.TextMatrix(Y, k) = "" Or Grid.TextMatrix(Y, k) = "." Then
        CAMPOS_BLANCOS = 1
      End If
    Next k
  
End Function



Private Sub txtrut_LostFocus()


TxtRut.BackColor = &H8000000E
TxtRut.ForeColor = &H80000008

If Len(TxtRut.Text) > 5 Then
   Digito = BacDevuelveDig(TxtRut.Text)
   txtDigito.Enabled = True
End If


End Sub



Sub Limpia()

     txtFecha1.Text = Date
     TXTGRILLA.Text = ""
     txtgrilla2.Text = ""
     txtgrilla3.Text = ""
     txtgrilla4.Text = ""
        
     txtFecha1.Tag = Date
     TXTGRILLA.Tag = ""
     txtgrilla2.Tag = ""
     txtgrilla3.Tag = ""
     txtgrilla4.Tag = ""

End Sub


Function Verifica_Existencia(Moneda, pais, plaza, CodSwif As String) As Boolean
Dim I As Long
Dim ContV As Integer

    Verifica_Existencia = False
    
    ContV = 0
    
    For I = 1 To Grid.Rows - 1
    
        If Mid(Grid.TextMatrix(I, 1), 1, 50) = Mid(Moneda, 1, 50) And Mid(Grid.TextMatrix(I, 2), 1, 50) = Mid(pais, 1, 50) _
           And Mid(Grid.TextMatrix(I, 3), 1, 50) = Mid(plaza, 1, 50) And Mid(Grid.TextMatrix(I, 4), 1, 50) = Mid(CodSwif, 1, 50) Then
            
            ContV = ContV + 1
            If ContV > 1 Then
                
                Verifica_Existencia = True
                Exit Function
                
            End If
           
        
        End If
    
    Next I

End Function

