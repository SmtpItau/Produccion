VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacTm_mnttasas 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Ingreso de Tasas por Plazo"
   ClientHeight    =   5250
   ClientLeft      =   2535
   ClientTop       =   2850
   ClientWidth     =   11055
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   5250
   ScaleWidth      =   11055
   Begin BACControles.TXTNumero text1 
      Height          =   345
      Left            =   3360
      TabIndex        =   2
      Top             =   1950
      Visible         =   0   'False
      Width           =   930
      _ExtentX        =   1640
      _ExtentY        =   609
      BackColor       =   -2147483646
      ForeColor       =   -2147483643
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BorderStyle     =   0
      Text            =   "0"
      Text            =   "0"
      Max             =   "99"
      SelStart        =   1
   End
   Begin VB.Frame Frame1 
      Caption         =   "Escenario"
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   735
      Left            =   120
      TabIndex        =   3
      Top             =   600
      Width           =   3855
      Begin VB.ComboBox CmbEscenario 
         Height          =   315
         ItemData        =   "BacTm_mnttasas.frx":0000
         Left            =   120
         List            =   "BacTm_mnttasas.frx":0010
         Style           =   2  'Dropdown List
         TabIndex        =   4
         Top             =   240
         Width           =   3615
      End
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   2880
      Top             =   0
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   25
      ImageHeight     =   25
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   7
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacTm_mnttasas.frx":0044
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacTm_mnttasas.frx":0496
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacTm_mnttasas.frx":07B0
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacTm_mnttasas.frx":0ACA
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacTm_mnttasas.frx":0DE4
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacTm_mnttasas.frx":1236
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacTm_mnttasas.frx":1550
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Tool 
      Height          =   465
      Left            =   0
      TabIndex        =   1
      Top             =   0
      Width           =   11100
      _ExtentX        =   19579
      _ExtentY        =   820
      ButtonWidth     =   847
      ButtonHeight    =   820
      AllowCustomize  =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   6
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdRangos"
            Description     =   "BtnRng"
            Object.ToolTipText     =   "M.Rangos"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdGrabar"
            Description     =   "BtnGrb"
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdBuscar"
            Description     =   "BtnFnd"
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdLimpiar"
            Description     =   "BtnLmp"
            Object.ToolTipText     =   "Limpiar Pantalla"
            ImageIndex      =   6
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdCerrar"
            Description     =   "BtnSlr"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   7
         EndProperty
      EndProperty
   End
   Begin MSFlexGridLib.MSFlexGrid Grilla1 
      Height          =   3720
      Left            =   120
      TabIndex        =   0
      Top             =   1440
      Width           =   10845
      _ExtentX        =   19129
      _ExtentY        =   6562
      _Version        =   393216
      Cols            =   3
      FixedCols       =   2
      BackColor       =   12632256
      ForeColor       =   -2147483635
      BackColorFixed  =   8421376
      ForeColorFixed  =   -2147483628
      BackColorSel    =   8388608
      ForeColorSel    =   -2147483628
      GridColor       =   4210752
      FocusRect       =   0
   End
End
Attribute VB_Name = "BacTm_mnttasas"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'declaro variables locales
Dim glCol As Long
Dim glrow As Long

'variables de posicion para toolbar
Const BtnRng = 2
Const BtnGrb = 3
Const BtnFnd = 4
Const BtnLmp = 5
Const BtnSlr = 6

Private Sub HabilitarBotones()
    
    'pregunto por los tag para habilitar/deshabilitar btn
    If Tool.Buttons(BtnFnd).Tag = "" Then
    
        Tool.Buttons(BtnGrb).Enabled = False
        Tool.Buttons(BtnRng).Enabled = False
        Tool.Buttons(BtnFnd).Enabled = True
        
    ElseIf Tool.Buttons(BtnFnd).Tag = "1" Then
    
        Tool.Buttons(BtnGrb).Enabled = True
        Tool.Buttons(BtnRng).Enabled = True
        Tool.Buttons(BtnFnd).Enabled = False
    End If
    
End Sub
Private Sub Buscar()

    'recuepro los datos segun escenario
    Call Llena_Grilla1
    
End Sub
Private Sub Limpiar()
    
    'limpio la grilla
    Call titulos_Grilla1
    
    'limpio tag del buscar
    Tool.Buttons(BtnFnd).Tag = ""
    
    'habilito botones
    Call HabilitarBotones

    'activo el combo
    CmbEscenario.Enabled = True
    
End Sub



Private Sub Form_Load()
        
    'personalizo ventana
    Me.Left = 0
    Me.Top = 0
    
    Me.Icon = BacTrader.Icon
    
    'posiciono combo de escenarios
    CmbEscenario.ListIndex = 0
            
    'define cabeceras
    Call titulos_Grilla1
    
    'habilito botones
    Call HabilitarBotones
    
End Sub

Private Sub titulos_Grilla1()

    'defino el numero de filas y columnas
    Grilla1.Clear
    Grilla1.Rows = 2
    Grilla1.Cols = 14
    
    'defino caracteristicas de las celdas
    Grilla1.ColWidth(0) = 0
    Grilla1.ColWidth(1) = 800
    Grilla1.ColWidth(2) = 0
    Grilla1.ColWidth(3) = 800
    Grilla1.ColWidth(4) = 900
    Grilla1.ColWidth(5) = 900
    Grilla1.ColWidth(6) = 900
    Grilla1.ColWidth(7) = 900
    Grilla1.ColWidth(8) = 900
    Grilla1.ColWidth(9) = 900
    Grilla1.ColWidth(10) = 900
    Grilla1.ColWidth(11) = 900
    Grilla1.ColWidth(12) = 900
    Grilla1.ColWidth(13) = 900
    
    'defino titulos de las columnas
    Grilla1.TextMatrix(0, 1) = "Familia"
    Grilla1.TextMatrix(0, 3) = "Emisor"
    Grilla1.TextMatrix(0, 4) = "Plazo 1"
    Grilla1.TextMatrix(0, 5) = "Plazo 2"
    Grilla1.TextMatrix(0, 6) = "Plazo 3"
    Grilla1.TextMatrix(0, 7) = "Plazo 4"
    Grilla1.TextMatrix(0, 8) = "Plazo 5"
    Grilla1.TextMatrix(0, 9) = "Plazo 6"
    Grilla1.TextMatrix(0, 10) = "Plazo 7"
    Grilla1.TextMatrix(0, 11) = "Plazo 8"
    Grilla1.TextMatrix(0, 12) = "Plazo 9"
    Grilla1.TextMatrix(0, 13) = "Plazo 10"
    
    Grilla1.RowHeight(0) = 270
    
    Grilla1.FixedCols = 4

End Sub

Private Sub Llena_Grilla1()
    
    'defino variables locales
    Dim lsenvia     As String
    Dim I           As Long
    Dim Datos()     As Variant
    Dim lbFindEmis  As Boolean
        
    'limpio la grilla
    'Call titulos_Grilla1
    lbFindEmis = False
    
    With Grilla1
    
        'recuepro instrumentos de la tabla tpra inm
        If Bac_Sql_Execute("SP_TASAMERCADO_LEE_INM") Then
    
            Do While Bac_SQL_Fetch(Datos())
                       
                'inserto valores en la grilla
                            
                .TextMatrix(.Rows - 1, 0) = Datos(1)
                .TextMatrix(.Rows - 1, 1) = Datos(2)
                .TextMatrix(.Rows - 1, 2) = Datos(3)
                .TextMatrix(.Rows - 1, 3) = Datos(4)
                
                Grilla1.RowHeight(.Rows - 1) = 270
                    
                'agrego fila a la grilla
                .Rows = .Rows + 1

            Loop
            
            'valido si se encontraron datos
            If Grilla1.Rows = 2 Then
            
                'aviso al usuario
                MsgBox "No se encontraron datos", vbInformation, gsBac_Version
                
            Else
                
                'marca registros
                lbFindEmis = True
                
                'elimino la colita de la grilla
                Grilla1.Rows = Grilla1.Rows - 1
                
            End If
            
        End If
        
        'limpiar pantalla
        Call Limpia_grilla
        
        If lbFindEmis Then
    
            For I = 1 To (.Rows - 1)
            
                'recupero las tasas
                Envia = Array()
                AddParam Envia, CDbl(CmbEscenario.ItemData(CmbEscenario.ListIndex))
                AddParam Envia, CDbl(.TextMatrix(I, 0))
                AddParam Envia, .TextMatrix(I, 2)
                
                'llamo al sp
                If Not Bac_Sql_Execute("SP_TASAMERCADO_LEE_TASA", Envia) Then
                      
                    'aviso al usuario
                    MsgBox ("Error al recuperar los datos.")
            
                    Exit Sub
                    
                End If
                
                'recorro los datos del sp
                Do While Bac_SQL_Fetch(Datos())
                    
                    'muestro la tasa en la grilla
                    .TextMatrix(I, (Datos(1) + 3)) = Format(Datos(2), "#0.0000")
                    
                Loop
                
            Next
            
            'limpio tag del buscar
            Tool.Buttons(BtnFnd).Tag = "1"
    
            'habilito botones
            Call HabilitarBotones
            
            'desactivo combo
            CmbEscenario.Enabled = False
            
        End If
    End With
    
End Sub

Private Sub Limpia_grilla()

'defino variables locales
Dim I As Long
Dim J As Integer

For I = 1 To (Grilla1.Rows - 1)

    For J = 4 To (Grilla1.Cols - 1)
    
        Grilla1.TextMatrix(I, J) = "0,0000"
        
    Next
    
Next

End Sub

Private Sub Grilla1_KeyPress(KeyAscii As Integer)

    'valido que la columna sea una tasa y que la grilla tenga registros
    If Grilla1.Col > 3 And Grilla1.TextMatrix(1, 0) <> "" Then
    
        'valido que el caracter digitado sea numerico
        If KeyAscii <> 27 And IsNumeric(Chr(KeyAscii)) Then
            
            'lleno variables de posicion
            glCol = Grilla1.Col
            glrow = Grilla1.Row
            
            'activo texto
            pos_texto (KeyAscii)
        
        End If
        
    End If

End Sub

Private Sub Text1_KeyPress(KeyAscii As Integer)
    
    'si la tecla es enter...
    If KeyAscii = 13 Then
        
        'limpio el tag
        Text1.Tag = ""
        
        'mando el foco a la grilla
        Grilla1.SetFocus
    
    ElseIf KeyAscii = 27 Then
        
        'marco el tag
        Text1.Tag = "ESC"
        
        'mando el foco a l agrilla
        Grilla1.SetFocus
        
        Text1.Visible = False
        
    End If
    
End Sub

Private Sub pos_texto(Key As Integer)

    'con el control text1
    With Text1
    
        'establezco propiedades de alto, ancho y posicion
        .Width = Grilla1.CellWidth - 20
        .Height = Grilla1.CellHeight
        .Top = Grilla1.CellTop + Grilla1.Top + 20
        .Left = Grilla1.CellLeft + Grilla1.Left + 20
        
        'paso la tecla presionada al control
        If IsNumeric(Chr(Key)) Then
        
            .Text = Chr(Key)
        End If
        
        'preparo texto
        Text1.SelStart = Len(Text1)
        
        'muestro control
        .Visible = True
        
        'envio el foco al control
        .SetFocus
        
    End With

End Sub

Private Sub Text1_LostFocus()

    'consulto el tag del objeto
    If Text1.Tag <> "ESC" Then
        
        'muevo el valor del control a la grilla
        Grilla1.TextMatrix(glrow, glCol) = Text1.Text
        
        'valido que el usuario no se haya movido del texto
        If Grilla1.Col = glCol And Grilla1.Row = glrow Then
        
            'valido los rangos de posicion en la grilla
            If Grilla1.Col < Grilla1.Cols - 1 Then
            
                'mando el foco a la siguiente columna de la grilla
                Grilla1.Col = glCol + 1
                Grilla1.Row = glrow
            
            ElseIf Grilla1.Row < Grilla1.Rows - 1 Then
            
                'mando el foco a la siguiente fila de la grilla
                Grilla1.Col = 4
                Grilla1.Row = glrow + 1
            
            End If
        End If
    End If
    
    'desactivo el control
    Text1.Tag = ""
    Text1.Text = ""
    Text1.Visible = False

End Sub

Private Sub Tool_ButtonClick(ByVal Button As MSComctlLib.Button)
        
    'defino seleccion del usuario
    Select Case Button.Key
    
          Case Is = "cmdRangos": BacTm_mntrangos.Show: Me.Enabled = False
    
          Case Is = "cmdGrabar": Call Grabar
          Case Is = "cmdBuscar": Call Buscar
          Case Is = "cmdLimpiar": Call Limpiar
          Case Is = "cmdCerrar": Unload Me
          
    End Select

End Sub

Private Sub Grabar()

    'defino variables locales
    Dim I           As Long
    Dim J           As Integer
    Dim llCodigoInm As Long
    Dim llCodigoEmi As Integer
    Dim lsGenericoEmi As String
    Dim liIdPlazo   As Integer
    Dim ldCodigoEsc As Double
    Dim lvTasa      As Variant
    Dim Datos()
    
    With Grilla1
        
        'tomo el codigo de escenario
        ldCodigoEsc = CDbl(CmbEscenario.ItemData(CmbEscenario.ListIndex))
                
        'preparo paramtros para sp
        Envia = Array(ldCodigoEsc)
        
        'elimino las tasas anteriores del escenario
        If Not Bac_Sql_Execute("SP_TASAMERCADO_ELIMINATASASMDTR ", Envia()) Then
        
            MsgBox "Se ha producido un error al grabar tasas."
            Exit Sub
        
        End If
        
        'recooro grilla
        For I = 1 To (.Rows - 1)
            
            'tomo el codigo de inm
            llCodigoInm = .TextMatrix(I, 0)
            lsGenericoEmi = .TextMatrix(I, 2)
            
            For J = 4 To (.Cols - 1)
                
                Envia = Array()
                AddParam Envia, ldCodigoEsc
                AddParam Envia, llCodigoInm
                AddParam Envia, lsGenericoEmi
                AddParam Envia, (J - 3)
                AddParam Envia, CDbl(.TextMatrix(I, J))
                
                If Not Bac_Sql_Execute("SP_TASAMERCADO_GRABA_TASA ", Envia) Then
                    MsgBox "Se ha producido un error al grabar tasas."
                    Exit Sub
                End If
                
            Next
            
        Next
        
    End With
    
    MsgBox "Información Grabada Correctamente", vbInformation, Me.Caption
    
    'limpio controles
    Call Limpiar
    
End Sub
