VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form BacAyuda_Novaciones 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Ayuda de Control Financiero"
   ClientHeight    =   6675
   ClientLeft      =   3225
   ClientTop       =   2925
   ClientWidth     =   11805
   ClipControls    =   0   'False
   ControlBox      =   0   'False
   FillStyle       =   0  'Solid
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   6675
   ScaleWidth      =   11805
   Begin VB.TextBox TxtOperacion 
      BeginProperty Font 
         Name            =   "Courier New"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   390
      Left            =   1185
      TabIndex        =   3
      Top             =   1065
      Width           =   6210
   End
   Begin VB.TextBox txtNombre 
      BeginProperty Font 
         Name            =   "Courier New"
         Size            =   9
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00400000&
      Height          =   390
      Left            =   1185
      LinkTimeout     =   0
      MaxLength       =   250
      MousePointer    =   14  'Arrow and Question
      TabIndex        =   2
      Top             =   600
      Width           =   6210
   End
   Begin MSComctlLib.ListView LstOperacion 
      Height          =   5040
      Left            =   0
      TabIndex        =   0
      Top             =   1560
      Width           =   11745
      _ExtentX        =   20717
      _ExtentY        =   8890
      View            =   3
      LabelEdit       =   1
      LabelWrap       =   -1  'True
      HideSelection   =   -1  'True
      FullRowSelect   =   -1  'True
      GridLines       =   -1  'True
      _Version        =   393217
      ForeColor       =   -2147483640
      BackColor       =   -2147483643
      BorderStyle     =   1
      Appearance      =   1
      NumItems        =   0
   End
   Begin MSComctlLib.Toolbar Botones 
      Height          =   480
      Left            =   0
      TabIndex        =   1
      Top             =   0
      Width           =   10665
      _ExtentX        =   18812
      _ExtentY        =   847
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   5
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "ACEPTAR"
            Description     =   "ACEPTAR"
            Object.ToolTipText     =   "Aceptar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Buscar"
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Limpiar"
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdSalir"
            Description     =   "Salir"
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
      ImageWidth      =   24
      ImageHeight     =   24
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   4
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacAyuda_Novaciones.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacAyuda_Novaciones.frx":0EDA
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacAyuda_Novaciones.frx":11F4
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacAyuda_Novaciones.frx":20CE
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin VB.Label LblOperacion 
      Caption         =   "Operación"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00C00000&
      Height          =   240
      Left            =   15
      TabIndex        =   5
      Top             =   1155
      Width           =   1125
   End
   Begin VB.Label LblCliente 
      Caption         =   "Cliente"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00C00000&
      Height          =   270
      Left            =   0
      TabIndex        =   4
      Top             =   675
      Width           =   1065
   End
End
Attribute VB_Name = "BacAyuda_Novaciones"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim SW
Public Sistema As String
Public TipoCliente   As Long

Private Sub Botones_ButtonClick(ByVal Button As MSComctlLib.Button)
    RetornoAyuda = ""
    Select Case Button.Index
    Case 2
        If LstOperacion.ListItems.Count = 0 Then
            giAceptar = False
            Exit Sub
        End If
        
        If TxtOperacion.Text = "" Then
          Call MsgBox("Debe Seleccionar N° de Operación.", vbInformation)
        Else
            If LstOperacion.ListItems.Count <> 0 Then
                
                If Sistema <> "BTR" And Sistema <> "BEX" Then
                    Let giAceptar = True
                    Operacion_DRV = Trim(Left(Me.TxtOperacion.Text, 10)) 'N° Operacion
                    'FechaVenc_DRV = Trim(Mid$(Me.TxtOperacion.Text, 11, 15)) 'Fecha Vencimiento
                    Clie_Operacion_Midd = Trim(Mid$(Me.txtNombre.Text, 14, 35)) ' Cliente
                Else
                    Operacion_DRV = Trim(Left(Me.TxtOperacion.Text, 10)) 'N° Operacion
                
                End If
            
            End If
            Unload Me
        End If
    Case 3
        Call Proc_Carga_Operaciones(Sistema)
         
    Case 4
        LstOperacion.ListItems.Clear
        txtNombre.Text = ""
        TxtOperacion.Text = ""
       
    
    Case 5
        giAceptar = False
        Unload Me
    End Select
End Sub


Private Sub Form_Load()
    LstOperacion.Visible = True
        
    Call Proc_Formatea_Grilla(Sistema)
    Call Proc_Carga_Operaciones(Sistema)
    'Call Proc_Carga_Productos(Sistema)
    LstOperacion.Visible = True
End Sub

Private Sub Proc_Carga_Operaciones(Sistema As String)
    Dim Datos()
    Dim NomProc      As String
    Dim NomCliente   As String * 35
    Dim RutDrv       As Long
    Dim CodigoDrv    As Long
    Dim ProductoDrv  As String
    
    
    LstOperacion.ListItems.Clear
    LstOperacion.Visible = True
    
    Let RutDrv = 0
    Let CodigoDrv = 0
    Let ProductoDrv = 0
    
    RutDrv = IIf(Trim(Mid(txtNombre.Text, 1, 9)) = "", 0, Trim((Mid(txtNombre.Text, 1, 9))))
    
    Dim Vi As Integer
    Dim NNN, LLL, LL As String
 
    LL = RutDrv
 
    For Vi = 1 To Len(LL)
        LLL = Mid$(LL, Vi, 1)
        If LLL = "1" Then NNN = NNN & LLL
        If LLL = "2" Then NNN = NNN & LLL
        If LLL = "3" Then NNN = NNN & LLL
        If LLL = "4" Then NNN = NNN & LLL
        If LLL = "5" Then NNN = NNN & LLL
        If LLL = "6" Then NNN = NNN & LLL
        If LLL = "7" Then NNN = NNN & LLL
        If LLL = "8" Then NNN = NNN & LLL
        If LLL = "9" Then NNN = NNN & LLL
        If LLL = "0" Then NNN = NNN & LLL
    Next
    RutDrv = NNN
    
    CodigoDrv = IIf(Me.TxtOperacion.Text = "", 0, Me.TxtOperacion.Text)
    
    Envia = Array()
    AddParam Envia, Sistema
    AddParam Envia, CDbl(RutDrv)  'Rut
    AddParam Envia, CDbl(CodigoDrv) 'Codigo
    'AddParam Envia, Sistema
    NomProc = "SP_BUSCA_NOVACIONES"
    
    If Not Bac_Sql_Execute(NomProc, Envia) Then
       Exit Sub
    End If
    Dim x As ListItem
    Do While Bac_SQL_Fetch(Datos())
        LstOperacion.Visible = True
        
            Let NomCliente = Datos(3)
            Set x = LstOperacion.ListItems.Add(, , Trim(Datos(1))) 'Operación
            x.Tag = Trim(Datos(1))
            'X.SubItems(1) = Trim(Datos(1)) 'Fecha Vencimiento
            x.SubItems(1) = Trim(Datos(2))
            x.SubItems(2) = Trim(Datos(3))
            x.SubItems(3) = Trim(Datos(4))
            x.SubItems(4) = Trim(Datos(5))
            x.SubItems(5) = Trim(Datos(6))
            x.SubItems(6) = Trim(Datos(7))
            x.SubItems(7) = Trim(Datos(8))
    Loop
      
End Sub

Private Sub Proc_Formatea_Grilla(Sistema As String)
        
        With Me.LstOperacion
            .ColumnHeaders.Clear
            .ListItems.Clear
            .View = lvwReport
            .Gridlines = True
            .FullRowSelect = True
            .HideSelection = True
            .SortOrder = lvwAscending
            .ColumnHeaders.Add , , "Fecha Mod.", 1240, lvwColumnLeft
            .ColumnHeaders.Add , , "N° Contrato", 1140, lvwColumnLeft
            .ColumnHeaders.Add , , "Nombre Cliente Origen", 2040, lvwColumnLeft
            .ColumnHeaders.Add , , "Rut Origen", 1240, lvwColumnLeft
            .ColumnHeaders.Add , , "Cod. Origen", 1140, lvwColumnLeft
            .ColumnHeaders.Add , , "Nombre Cliente Destino", 2040, lvwColumnLeft
            .ColumnHeaders.Add , , "Rut Destino", 1240, lvwColumnLeft
            .ColumnHeaders.Add , , "Cod. Destino", 1140, lvwColumnLeft
        End With
   
End Sub

Private Sub Proc_Carga_Productos(Sistema As String)
   Dim Datos()
   
   Envia = Array()
   AddParam Envia, Sistema
   If Not Bac_Sql_Execute("dbo.SP_BUSCA_NOVACIONES 'FWD',0,0 ", Envia) Then
      Call MsgBox("Error de Lectura." & vbCrLf & vbCrLf & "Se ha generado un error en la lecturea de Monedas.", vbExclamation, App.Title)
      Exit Sub
   End If
   'Call CmbProducto.Clear
   Do While Bac_SQL_Fetch(Datos())
      'Call CmbProducto.AddItem(Datos(2) & Space(70) & Datos(1))
   Loop
End Sub

Private Sub Proc_Selecciona_Datos()
 Dim NomClie As String
    If LstOperacion.ListItems.Count <> 0 Then
        
        TxtOperacion.Text = LstOperacion.SelectedItem & Space(10) & _
                            LstOperacion.SelectedItem.ListSubItems(1)
        
        If Sistema = "BFW" Or Sistema = "OPT" Then
           txtNombre.Text = LstOperacion.SelectedItem.ListSubItems(6) & " // " & LstOperacion.SelectedItem.ListSubItems(5)
           TxtOperacion.Text = LstOperacion.SelectedItem.ListSubItems(1)
            
            N_Contrato = LstOperacion.SelectedItem.ListSubItems(1)
            
            'Datos Origen
            Nombre_Origen = LstOperacion.SelectedItem.ListSubItems(2)
            Rut_Origen = LstOperacion.SelectedItem.ListSubItems(3)
            Codigo_Origen = LstOperacion.SelectedItem.ListSubItems(4)
            
            'Datos Destino
            Nombre_Destino = LstOperacion.SelectedItem.ListSubItems(5)
            Rut_Destino = LstOperacion.SelectedItem.ListSubItems(6)
            Codigo_Destino = LstOperacion.SelectedItem.ListSubItems(7)
           
        End If
        
    End If
End Sub

Private Sub LstOperacion_Click()
    Call Proc_Selecciona_Datos
End Sub

Private Sub LstOperacion_DblClick()
    If LstOperacion.ListItems.Count = 0 Then
      giAceptar = False
      Exit Sub
    End If
   
    If LstOperacion.ListItems.Count <> 0 Then
        giAceptar = True
        Operacion_Novacion = Trim(Left(Me.TxtOperacion.Text, 10))
        Nombre_Cliente_Destino = LstOperacion.SelectedItem.ListSubItems(5)
        Nombre_Cliente_Origen = LstOperacion.SelectedItem.ListSubItems(2)
        Rut_Origen = LstOperacion.SelectedItem.ListSubItems(3)
        Rut_Destino = LstOperacion.SelectedItem.ListSubItems(6)
        'Fecha_Novacion = LstOperacion.SelectedItem.ListSubItems(0)
    End If
    Unload Me
End Sub

Private Sub LstOperacion_KeyPress(KeyAscii As Integer)
    
    If KeyAscii = vbKeyReturn Then
        If LstOperacion.ListItems.Count = 0 Then
          giAceptar = False
          Exit Sub
        End If
           
        If LstOperacion.ListItems.Count <> 0 Then
            giAceptar = True
            If Sistema <> "BTR" And Sistema <> "BEX" Then
                Operacion_Novacion = Trim(Left(Me.TxtOperacion.Text, 10)) 'N° Operacion
                FechaVenc_Novacion = Trim(Mid$(Me.TxtOperacion.Text, 11, 15)) 'Fecha Vencimiento
                Clie_Operacion_Midd = Left(Me.txtNombre.Text, 35) ' Cliente
                Rut_Origen = LstOperacion.SelectedItem.ListSubItems(6)
                Rut_Destino = LstOperacion.SelectedItem.ListSubItems(8)
                
            Else
                giAceptar = True
                Operacion_Novacion = Trim(Left(Me.TxtOperacion.Text, 10)) 'N° Operacion
        
            End If
        
        End If
        Unload Me
    End If
    
End Sub

Private Sub LstOperacion_KeyUp(KeyCode As Integer, Shift As Integer)
     Call Proc_Selecciona_Datos
End Sub

Private Sub txtNombre_Click()
    If Len(txtNombre.Text) > 45 Then
        txtNombre.Text = ""
    End If
End Sub

Private Sub Txtnombre_DblClick()

   BacAyuda.Tag = "Clientes"
   BacAyuda.Show 1
   If giAceptar Then
        txtNombre.Text = RetornoAyuda3 & Space(2) & RetornoAyuda4 & Space(20) & RetornoAyuda2
   End If

End Sub
Private Sub txtNombre_GotFocus()
'    SW = 1
'    If Len(TxtNombre.Text) > 45 Then
'        TxtNombre.Text = ""
'    End If
'    TxtNombre.SelStart = Len(TxtNombre.Text)
     Proc_Carga_Operaciones (Sistema)
End Sub

Private Sub txtNombre_KeyPress(KeyAscii As Integer)
    If KeyAscii = 27 Then
        Call Botones_ButtonClick(Botones.Buttons(2))
    End If
    If KeyAscii% = vbKeyReturn Then
        Call Botones_ButtonClick(Botones.Buttons(1))
    Else
        KeyAscii% = Asc(UCase$(Chr$(KeyAscii%)))
    End If
   
    If KeyAscii = 8 Then
        If Len(txtNombre.Text) = 1 Then
            LstOperacion.ListItems.Clear
        End If
    End If
End Sub

Private Sub TxtNombre_KeyUp(KeyCode As Integer, Shift As Integer)
    If KeyCode = vbKeyDown Or KeyCode = vbKeyUp Then
        lstNombre.SetFocus
    End If
End Sub
Private Sub txtNombre_LostFocus()
    SW = 0
    
End Sub

Private Function Aceptar() As Boolean
    Unload Me
End Function


