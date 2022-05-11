VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Begin VB.Form BacAyuda_DRV 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Ayuda de Control Financiero"
   ClientHeight    =   7620
   ClientLeft      =   3225
   ClientTop       =   2925
   ClientWidth     =   7785
   ClipControls    =   0   'False
   ControlBox      =   0   'False
   FillStyle       =   0  'Solid
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   7620
   ScaleWidth      =   7785
   Begin Threed.SSPanel SSPanel2 
      Height          =   7005
      Left            =   0
      TabIndex        =   0
      Top             =   540
      Width           =   7725
      _Version        =   65536
      _ExtentX        =   13626
      _ExtentY        =   12356
      _StockProps     =   15
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin VB.ComboBox CmbProducto 
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   1275
         Style           =   2  'Dropdown List
         TabIndex        =   8
         Top             =   1200
         Width           =   4335
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
         Left            =   1275
         LinkTimeout     =   0
         MaxLength       =   250
         MousePointer    =   14  'Arrow and Question
         TabIndex        =   7
         Top             =   120
         Width           =   6210
      End
      Begin MSComctlLib.ListView LstOperacion 
         Height          =   5040
         Left            =   120
         TabIndex        =   6
         Top             =   1800
         Width           =   7425
         _ExtentX        =   13097
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
         Left            =   1275
         TabIndex        =   1
         Top             =   585
         Width           =   6210
      End
      Begin VB.Label LblProducto 
         Caption         =   "Producto"
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
         Height          =   315
         Left            =   120
         TabIndex        =   4
         Top             =   1245
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
         Left            =   90
         TabIndex        =   3
         Top             =   195
         Width           =   1065
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
         Left            =   105
         TabIndex        =   2
         Top             =   675
         Width           =   1125
      End
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   7470
      Top             =   855
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
            Picture         =   "Bacayuda_DRV.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacayuda_DRV.frx":0EDA
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacayuda_DRV.frx":11F4
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacayuda_DRV.frx":20CE
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Botones 
      Height          =   480
      Left            =   0
      TabIndex        =   5
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
End
Attribute VB_Name = "BacAyuda_DRV"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim SW
Public Sistema As String
Public TipoCliente   As Long

Private Sub Proc_Carga_Operaciones(Sistema As String)
    Dim DATOS()
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
    
    RutDrv = IIf(Trim(Mid(txtNombre.Text, 36, 15)) = "", 0, Trim((Mid(txtNombre.Text, 36, 15))))
    CodigoDrv = IIf(Trim(Mid$(txtNombre.Text, 73, 9)) = "", 0, Trim(Mid$(txtNombre.Text, 73, 9)))
    ProductoDrv = IIf(Trim(Right(CmbProducto.Text, 20)) = "", "", Trim(Right(CmbProducto.Text, 20)))
     
    Envia = Array()
    AddParam Envia, Sistema
    AddParam Envia, CDbl(RutDrv)  'Rut
    AddParam Envia, CDbl(CodigoDrv) 'Codigo
    AddParam Envia, ProductoDrv 'Producto
    NomProc = "SP_RIEFIN_OPERACION_DERIVADOS"
    
    If Not Bac_Sql_Execute(NomProc, Envia) Then
       Exit Sub
    End If
    Dim X As ListItem
    Do While Bac_SQL_Fetch(DATOS())
        LstOperacion.Visible = True
        
        If Sistema = "BFW" Then
            Let NomCliente = DATOS(5)
            Set X = LstOperacion.ListItems.Add(, , Trim(DATOS(1))) 'Operación
            X.Tag = Trim(DATOS(1))
            X.SubItems(1) = Trim(DATOS(2)) 'Fecha Vencimiento
            X.SubItems(2) = Trim(DATOS(3)) 'Rut
            X.SubItems(3) = Trim(DATOS(7)) 'Monto
            X.SubItems(4) = Trim(DATOS(8)) 'Precio
            X.SubItems(5) = Trim(DATOS(9)) 'Monto Noc
            X.SubItems(6) = Trim(DATOS(10)) 'Monto Sec
            X.SubItems(7) = NomCliente 'Cliente
            X.SubItems(8) = DATOS(4) 'Codigo


        End If
        
        If Sistema = "PCS" Then
            Let NomCliente = DATOS(5)
            Set X = LstOperacion.ListItems.Add(, , Trim(DATOS(1))) 'Operación
            X.Tag = Trim(DATOS(1))
            X.SubItems(1) = Trim(DATOS(2)) 'Fecha Vencimiento
            X.SubItems(2) = Trim(DATOS(3)) 'Rut
            X.SubItems(3) = Trim(DATOS(7)) 'Monto
            X.SubItems(4) = Trim(DATOS(8)) 'Precio
            X.SubItems(5) = NomCliente 'Cliente
            X.SubItems(6) = DATOS(4) 'Codigo
        End If
        
        If Sistema = "OPT" Then
            Let NomCliente = DATOS(6)
            Set X = LstOperacion.ListItems.Add(, , Trim(DATOS(1))) 'Operación
            X.Tag = Trim(DATOS(1))
            X.SubItems(1) = Trim(DATOS(2)) 'Operación + Estructura
            X.SubItems(2) = Trim(DATOS(3)) 'Fecha Vencimiento
            X.SubItems(3) = Trim(DATOS(4)) 'Rut
            X.SubItems(4) = Trim(DATOS(9)) 'Monto
            X.SubItems(5) = Trim(DATOS(7)) 'Compra Venta Moneda
            X.SubItems(6) = Trim(DATOS(8)) 'Compra Venta derecho
            X.SubItems(7) = Trim(DATOS(10)) 'Moneda Nocional
            X.SubItems(8) = Trim(DATOS(11)) 'Moneda Secundaria
            X.SubItems(9) = Trim(DATOS(12)) 'Estructura
            X.SubItems(10) = NomCliente 'Cliente
            X.SubItems(11) = DATOS(5) 'Codigo
        End If
        
        If Sistema = "BTR" Then
            'Dim X As ListItem
            Set X = LstOperacion.ListItems.Add(, , Trim(DATOS(1))) 'Operación
            X.Tag = Trim(DATOS(1))
            X.SubItems(1) = Trim(DATOS(2)) 'Rut
            X.SubItems(2) = Trim(DATOS(4)) 'Cliente
            X.SubItems(3) = Trim(DATOS(5)) 'Compra Venta Moneda
            X.SubItems(4) = Trim(DATOS(6)) 'Compra Venta derecho
            X.SubItems(5) = Trim(DATOS(7)) 'Moneda Nocional
        End If
        
        
        If Sistema = "BEX" Then
            'Dim X As ListItem
            Set X = LstOperacion.ListItems.Add(, , Trim(DATOS(2))) 'Operación
            X.Tag = Trim(DATOS(1))
            X.SubItems(1) = Trim(DATOS(1)) 'Fecha Vencimiento
            X.SubItems(2) = Trim(DATOS(3)) 'Nemo
            X.SubItems(3) = Trim(DATOS(4)) 'Nominal
            X.SubItems(4) = Trim(DATOS(5)) 'Fecha Cup.
        End If
    Loop
      
End Sub

Private Sub Proc_Formatea_Grilla(Sistema As String)
        
    If Sistema = "BFW" Then
        'Propiedades de la lista
        With Me.LstOperacion
            .ColumnHeaders.Clear
            .ListItems.Clear
            .View = lvwReport
            .Gridlines = True
            .FullRowSelect = True
            .HideSelection = True
            .SortOrder = lvwAscending
            .ColumnHeaders.Add , , "Operación", 1440, lvwColumnLeft
            .ColumnHeaders.Add , , "Fecha Venc.", 1440, lvwColumnLeft
            .ColumnHeaders.Add , , "Rut", 1440, lvwColumnLeft
            .ColumnHeaders.Add , , "Monto", 1440, lvwColumnLeft
            .ColumnHeaders.Add , , "Precio", 1440, lvwColumnLeft
            .ColumnHeaders.Add , , "Mon.Nocional", 1440, lvwColumnLeft
            .ColumnHeaders.Add , , "Mon.Sec", 1440, lvwColumnLeft
            .ColumnHeaders.Add , , "Cliente", 1440, lvwColumnLeft
            .ColumnHeaders.Add , , "Codigo", 1440, lvwColumnLeft
        End With
    End If
    
    If Sistema = "PCS" Then
        'Propiedades de la lista
        With Me.LstOperacion
            .ColumnHeaders.Clear
            .ListItems.Clear
            .View = lvwReport
            .Gridlines = True
            .FullRowSelect = True
            .HideSelection = True
            .SortOrder = lvwAscending
            .ColumnHeaders.Add , , "Operación", 1440, lvwColumnLeft
            .ColumnHeaders.Add , , "Fecha Venc.", 1440, lvwColumnLeft
            .ColumnHeaders.Add , , "Rut", 1440, lvwColumnLeft
            .ColumnHeaders.Add , , "Monto", 1440, lvwColumnLeft
            .ColumnHeaders.Add , , "Moneda", 1440, lvwColumnLeft
            .ColumnHeaders.Add , , "Cliente", 1440, lvwColumnLeft
            .ColumnHeaders.Add , , "Codigo", 1440, lvwColumnLeft
        End With
    End If
    
    If Sistema = "OPT" Then
        'Propiedades de la lista
        With Me.LstOperacion
            .ColumnHeaders.Clear
            .ListItems.Clear
            .View = lvwReport
            .Gridlines = True
            .FullRowSelect = True
            .HideSelection = True
            .SortOrder = lvwAscending
            .ColumnHeaders.Add , , "Operación", 1440, lvwColumnLeft
            .ColumnHeaders.Add , , "OpeEstructura", 1440, lvwColumnLeft
            .ColumnHeaders.Add , , "Fecha Venc.", 1440, lvwColumnLeft
            .ColumnHeaders.Add , , "Rut", 1440, lvwColumnLeft
            .ColumnHeaders.Add , , "Monto", 1440, lvwColumnLeft
            .ColumnHeaders.Add , , "Compra Ven.Moneda", 1440, lvwColumnLeft
            .ColumnHeaders.Add , , "Compra Ven.Derecho", 1440, lvwColumnLeft
            .ColumnHeaders.Add , , "Mon.Nocional", 1440, lvwColumnLeft
            .ColumnHeaders.Add , , "Mon.Sec", 1440, lvwColumnLeft
            .ColumnHeaders.Add , , "Estructura", 1440, lvwColumnLeft
            .ColumnHeaders.Add , , "Cliente", 1440, lvwColumnLeft
            .ColumnHeaders.Add , , "Codigo", 1440, lvwColumnLeft
        End With
    End If
    
    If Sistema = "BTR" Then
       'Propiedades de la lista
       With Me.LstOperacion
           .ColumnHeaders.Clear
           .ListItems.Clear
           .View = lvwReport
           .Gridlines = True
           .FullRowSelect = True
           .HideSelection = True
           .SortOrder = lvwAscending
           .ColumnHeaders.Add , , "Operación", 1440, lvwColumnLeft
           .ColumnHeaders.Add , , "Rut", 1440, lvwColumnLeft
           .ColumnHeaders.Add , , "Cliente", 1440, lvwColumnLeft
           .ColumnHeaders.Add , , "Serie", 1440, lvwColumnLeft
           .ColumnHeaders.Add , , "Instrumento", 1440, lvwColumnLeft
           .ColumnHeaders.Add , , "Emisor", 1440, lvwColumnLeft
       End With
    End If
    
    
    If Sistema = "BEX" Then
       'Propiedades de la lista
       With Me.LstOperacion
           .ColumnHeaders.Clear
           .ListItems.Clear
           .View = lvwReport
           .Gridlines = True
           .FullRowSelect = True
           .HideSelection = True
           .SortOrder = lvwAscending
           .ColumnHeaders.Add , , "Operación", 1440, lvwColumnLeft
           .ColumnHeaders.Add , , "Fecha Venc.", 1440, lvwColumnLeft
           .ColumnHeaders.Add , , "Nemo", 1440, lvwColumnLeft
           .ColumnHeaders.Add , , "Nominal", 1440, lvwColumnLeft
           .ColumnHeaders.Add , , "Fecha Cup.", 1440, lvwColumnLeft
       End With
    End If

End Sub

Private Sub Proc_Selecciona_Datos()
 Dim NomClie As String
    If LstOperacion.ListItems.Count <> 0 Then
        
        TxtOperacion.Text = LstOperacion.SelectedItem & Space(10) & _
                            LstOperacion.SelectedItem.ListSubItems(1)
                            
        
        
        If Sistema = "BFW" Then
           txtNombre.Text = LstOperacion.SelectedItem.ListSubItems(7) & Space(2) & _
                            LstOperacion.SelectedItem.ListSubItems(2) & Space(20) & _
                            LstOperacion.SelectedItem.ListSubItems(8)
        End If
        
        If Sistema = "PCS" Then
           txtNombre.Text = LstOperacion.SelectedItem.ListSubItems(5) & Space(2) & _
                            LstOperacion.SelectedItem.ListSubItems(2) & Space(20) & _
                            LstOperacion.SelectedItem.ListSubItems(6)
        End If
        
        If Sistema = "OPT" Then
           txtNombre.Text = LstOperacion.SelectedItem.ListSubItems(10) & Space(2) & _
                            LstOperacion.SelectedItem.ListSubItems(3) & Space(20) & _
                            LstOperacion.SelectedItem.ListSubItems(11)
                            
             
        TxtOperacion.Text = LstOperacion.SelectedItem & Space(10) & _
                            LstOperacion.SelectedItem.ListSubItems(2)
           
        
        End If
    End If

End Sub

Private Sub CmbProducto_Click()
    If CmbProducto.ListIndex <> -1 Then
       Proc_Carga_Operaciones (Sistema)
    End If
End Sub
Private Sub Form_Activate()

'        Me.CmbProducto.Visible = True
'        Me.LstOperacion.Visible = True
'        Dim Sistema As String
'        Let Sistema = Me.Tag
'
'        Call Proc_Formatea_Grilla(Sistema)
'        Call Proc_Carga_Operaciones(Sistema)
'        Call Proc_Carga_Productos(Sistema)
'        Me.CmbProducto.Visible = True
'        Me.LstOperacion.Visible = True
    
End Sub
Private Sub Proc_Carga_Productos(Sistema As String)
   Dim DATOS()
   
   Envia = Array()
   AddParam Envia, Sistema
   If Not Bac_Sql_Execute("SP_RIEFIN_PRODUCTOS_DERIVADOS", Envia) Then
      Call MsgBox("Error de Lectura." & vbCrLf & vbCrLf & "Se ha generado un error en la lecturea de Monedas.", vbExclamation, App.Title)
      Exit Sub
   End If
   Call CmbProducto.Clear
   Do While Bac_SQL_Fetch(DATOS())
      Call CmbProducto.AddItem(DATOS(2) & Space(70) & DATOS(1))
   Loop
End Sub

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
                    FechaVenc_DRV = Trim(Mid$(Me.TxtOperacion.Text, 11, 15)) 'Fecha Vencimiento
                    Clie_Operacion_Midd = Trim(Left(Me.txtNombre.Text, 35)) ' Cliente
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
        CmbProducto.ListIndex = -1
    
    Case 5
        giAceptar = False
        Unload Me
    End Select
End Sub
Private Sub lstNombre_Click()

End Sub

Private Sub Form_Load()
        CmbProducto.Visible = True
        LstOperacion.Visible = True
        'Dim Sistema As String
        'Let Sistema = Me.Tag

        Call Proc_Formatea_Grilla(Sistema)
        Call Proc_Carga_Operaciones(Sistema)
        Call Proc_Carga_Productos(Sistema)
        CmbProducto.Visible = True
        LstOperacion.Visible = True
   
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
        If Sistema <> "BTR" And Sistema <> "BEX" Then
            Operacion_DRV = Trim(Left(Me.TxtOperacion.Text, 10)) 'N° Operacion
            FechaVenc_DRV = Trim(Mid$(Me.TxtOperacion.Text, 11, 15)) 'Fecha Vencimiento
            Clie_Operacion_Midd = Left(Me.txtNombre.Text, 35) ' Cliente
        Else
            Operacion_DRV = Trim(Left(Me.TxtOperacion.Text, 10)) 'N° Operacion
            
        End If
        
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
                Operacion_DRV = Trim(Left(Me.TxtOperacion.Text, 10)) 'N° Operacion
                FechaVenc_DRV = Trim(Mid$(Me.TxtOperacion.Text, 11, 15)) 'Fecha Vencimiento
                Clie_Operacion_Midd = Left(Me.txtNombre.Text, 35) ' Cliente
            Else
                giAceptar = True
                Operacion_DRV = Trim(Left(Me.TxtOperacion.Text, 10)) 'N° Operacion
        
            End If
        
        End If
        Unload Me
    End If
    
End Sub

Private Sub LstOperacion_KeyUp(KeyCode As Integer, Shift As Integer)
     Call Proc_Selecciona_Datos
End Sub

Private Sub txtNombre_Change()
'    On Error GoTo ErrorChange
'    Dim nPos    As Long
'    Dim sText   As String
'    Dim n       As Long
'
'    For n = 0 To LstOperacion.ListItems.Count = 0
'        If Mid(LstOperacion.ListItems(n), Len(txtNombre.Text), 1) <> "" Then
'            If Mid$(LstOperacion.ListItems(n), 1, Len(txtNombre.Text)) = txtNombre.Text Then '_
'                nPos = n
'                LstOperacion.ListItems.Count = nPos
'                Exit For
'            End If
'        End If
'    Next n
'ErrorChange:
    
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

Private Sub TXTNombre_KeyPress(KeyAscii As Integer)
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

Private Sub TxtNombre2_Change()

End Sub


Private Sub TxtOperacion_KeyDown(KeyCode As Integer, Shift As Integer)
    'Proc_Carga_Operaciones
End Sub


