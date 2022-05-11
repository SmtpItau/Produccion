VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacTraspasoInstru 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Traspaso de Instrumentos de Cartera Transable a Permanente"
   ClientHeight    =   4995
   ClientLeft      =   90
   ClientTop       =   1485
   ClientWidth     =   8010
   ForeColor       =   &H80000007&
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   MousePointer    =   99  'Custom
   Moveable        =   0   'False
   ScaleHeight     =   4995
   ScaleWidth      =   8010
   Begin VB.Frame Frame2 
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000D&
      Height          =   1455
      Left            =   0
      TabIndex        =   2
      Top             =   480
      Width           =   7935
      Begin VB.Frame Frame3 
         Height          =   1215
         Left            =   120
         TabIndex        =   3
         Top             =   120
         Width           =   7695
         Begin VB.TextBox txtnumero 
            Height          =   285
            Left            =   6360
            TabIndex        =   14
            Top             =   600
            Width           =   1095
         End
         Begin VB.TextBox txtSerie 
            Height          =   285
            Left            =   4680
            MousePointer    =   1  'Arrow
            TabIndex        =   12
            Top             =   600
            Width           =   1455
         End
         Begin VB.TextBox txtTipo 
            DragIcon        =   "BacTraspasoInstru.frx":0000
            Height          =   285
            Left            =   3360
            MouseIcon       =   "BacTraspasoInstru.frx":030A
            MousePointer    =   99  'Custom
            TabIndex        =   10
            Top             =   600
            Width           =   1095
         End
         Begin BACControles.TXTFecha txtFecha1 
            Height          =   255
            Left            =   240
            TabIndex        =   6
            Top             =   600
            Width           =   1335
            _ExtentX        =   2355
            _ExtentY        =   450
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            MaxDate         =   2958465
            MinDate         =   -328716
            Text            =   "13/03/2001"
         End
         Begin BACControles.TXTFecha txtFecha2 
            Height          =   255
            Left            =   1800
            TabIndex        =   8
            Top             =   600
            Width           =   1335
            _ExtentX        =   2355
            _ExtentY        =   450
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            MaxDate         =   2958465
            MinDate         =   -328716
            Text            =   "09/03/2001"
         End
         Begin VB.Label Label5 
            Caption         =   "Número  Operación"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   495
            Left            =   6360
            TabIndex        =   13
            Top             =   120
            Width           =   975
         End
         Begin VB.Label Label4 
            Caption         =   "Serie  Instrumento"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   375
            Left            =   4680
            TabIndex        =   11
            Top             =   120
            Width           =   1335
         End
         Begin VB.Label Label3 
            Caption         =   "Tipo  Instrumento"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   495
            Left            =   3360
            TabIndex        =   9
            Top             =   120
            Width           =   1335
         End
         Begin VB.Label Label2 
            Caption         =   "Fecha Final"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   375
            Left            =   1800
            TabIndex        =   7
            Top             =   240
            Width           =   1335
         End
         Begin VB.Label Label1 
            Caption         =   "Fecha Inicio"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   375
            Left            =   240
            TabIndex        =   5
            Top             =   240
            Width           =   1335
         End
      End
   End
   Begin VB.Frame Frame1 
      Height          =   2895
      Left            =   0
      TabIndex        =   0
      Top             =   1920
      Width           =   7935
      Begin MSFlexGridLib.MSFlexGrid grilla 
         Height          =   2535
         Left            =   120
         TabIndex        =   1
         Top             =   240
         Width           =   7695
         _ExtentX        =   13573
         _ExtentY        =   4471
         _Version        =   393216
         BackColor       =   12632256
         ForeColor       =   4194304
         BackColorFixed  =   8421376
         ForeColorFixed  =   16777215
         ForeColorSel    =   16777215
         BackColorBkg    =   12632256
         GridColor       =   0
         GridColorFixed  =   16777215
         FocusRect       =   0
         GridLines       =   2
         GridLinesFixed  =   0
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Height          =   480
      Left            =   0
      TabIndex        =   4
      Top             =   0
      Width           =   10020
      _ExtentX        =   17674
      _ExtentY        =   847
      ButtonWidth     =   767
      ButtonHeight    =   741
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.ToolTipText     =   "Liberar Datos"
            Object.Tag             =   "1"
            ImageIndex      =   7
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.ToolTipText     =   "Buscar"
            Object.Tag             =   "2"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.ToolTipText     =   "Limpiar"
            Object.Tag             =   "3"
            ImageIndex      =   4
            BeginProperty ButtonMenus {66833FEC-8583-11D1-B16A-00C0F0283628} 
               NumButtonMenus  =   1
               BeginProperty ButtonMenu1 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
            EndProperty
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
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
      OLEDropMode     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   3480
         Top             =   -45
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   22
         ImageHeight     =   22
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   8
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacTraspasoInstru.frx":0614
               Key             =   "Guardar"
               Object.Tag             =   "1"
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacTraspasoInstru.frx":0A66
               Key             =   "Buscar"
               Object.Tag             =   "2"
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacTraspasoInstru.frx":0EB8
               Key             =   "Eliminar"
               Object.Tag             =   "3"
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacTraspasoInstru.frx":130A
               Key             =   "Limpiar"
               Object.Tag             =   "4"
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacTraspasoInstru.frx":1624
               Key             =   "Ayuda"
               Object.Tag             =   "6"
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacTraspasoInstru.frx":193E
               Key             =   ""
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacTraspasoInstru.frx":1C58
               Key             =   ""
            EndProperty
            BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacTraspasoInstru.frx":20AA
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
End
Attribute VB_Name = "BacTraspasoInstru"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim serie_aux, tipo_aux, fec1, fec2, aux_codigo, tipo1, serie1, flag_cartera, glosa_aux, codigo_serie As String
Dim Arreglo() 'arreglo que guardar los indices
Dim Arreglo1()
Dim S1, S2, NroOpe, ok, Fux, SW As Integer


Const Blanco = &H80000005
Const Azul = &H800000
Const Negro = &H0&
Const Gris = &HC0C0C0

Function HabilitarControles(Valor)
'habilita los controles para filtrar informacion
    TXTFecha1.Enabled = Valor
    TXTFecha2.Enabled = Valor
    txtTipo.Enabled = Valor
    TxtSerie.Enabled = Valor
    TxtNumero.Enabled = Valor
End Function

Sub Limpiar_Aux()
'limpia las variables auxiliares que se ocupan
    fec1 = ""
    fec2 = ""
    tipo1 = ""
    serie1 = ""
    NroOpe = 0
    tipo_aux = ""
    serie_aux = ""
    codigo_serie = ""
    flag_cartera = ""
    SW = 1
    ok = 0
    Fux = 0
    S1 = 0
    S2 = 0

End Sub


Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
'muestra los eventos que provocan la barra
Select Case Button.Index
    Case 1
        'libera Información
        Call liberar_informacion
        Call grilla_datosclientes
    
    Case 2
        'Busca a los clientes dependiendo de las condiciones
        Toolbar1.Buttons(1).Enabled = True
        grilla.Enabled = True
        Call datos_filtrar
        Call grilla_datosclientes
        If Fux = 0 Then
            Toolbar1.Buttons(2).Enabled = False
            Call HabilitarControles(False)
        End If
                
    Case 3
        'limpiar todos los datos del formulario
        Call Limpiar
        Call Limpiar_Aux
        Call Cargar_Grilla
        Call desactivar_botones_barra
        Call datos_filtrar
        Call HabilitarControles(True)
        grilla.Enabled = False
        TXTFecha1.TabIndex = 1
        Me.Top = 1155
        Me.Left = 45
        TXTFecha1.SetFocus
    
    Case 4
        Unload Me
        
End Select
     
End Sub

Sub desactivar_botones_barra()
'desactiva los botones de la barra
    Toolbar1.Buttons(1).Enabled = False
    Toolbar1.Buttons(2).Enabled = True
    Toolbar1.Buttons(3).Enabled = True
    Toolbar1.Buttons(4).Enabled = True
End Sub

Sub Cargar_Grilla()
'carga la grilla con los titulos correspondientes
Dim m, mm As Integer
With grilla
   .Enabled = True
   .Clear
   .Rows = 3
   .Cols = 12
   .FixedRows = 2
   .FixedCols = 0
   .TextMatrix(0, 1) = "Número"
   .TextMatrix(1, 1) = "Documento"
   .TextMatrix(0, 2) = "Número"
   .TextMatrix(1, 2) = "Operación"
   .TextMatrix(0, 3) = "Correlativo"
   .TextMatrix(0, 4) = "Tipo de"
   .TextMatrix(1, 4) = "Operación"
   .TextMatrix(0, 5) = "Nemotécnico"
   .TextMatrix(0, 6) = "Nominal"
   .TextMatrix(0, 7) = "Fecha"
   .TextMatrix(1, 7) = "Compra"
   .TextMatrix(0, 8) = "Tir Compra"
   .TextMatrix(0, 9) = "Porcentaje"
   .TextMatrix(1, 9) = "Valor Par"
   .TextMatrix(0, 10) = "Valor"
   .TextMatrix(1, 10) = "Compra"
   .TextMatrix(0, 11) = "Valor"
   .TextMatrix(1, 11) = "Presente"
   
   .ColWidth(0) = 0
    
   .ColWidth(1) = 1200
   .ColWidth(2) = 1000
   .ColWidth(3) = 1000
   .ColWidth(4) = 1200
   .ColWidth(5) = 1200
   .ColWidth(6) = 2000
   .ColWidth(7) = 1000
   .ColWidth(8) = 1200
   .ColWidth(9) = 1200
   .ColWidth(10) = 2000
   .ColWidth(11) = 2000
   
    For m = 0 To .Rows - 2
        .RowHeight(m) = 227
    Next m
    For m = 0 To .Rows - 1
        For mm = 0 To .Cols - 1
            .Col = mm
            .Row = m
            .CellFontBold = True
            .GridLinesFixed = flexGridNone
        Next mm
    Next m
    .CellFontBold = False
    .Rows = .Rows - 1
   If .Rows > 2 Then
      .Col = 0
      .ColSel = .Cols - 1
   Else
      .Col = 0
      .ColSel = 0
   End If
     .Enabled = False
      
End With
End Sub

Sub datos_filtrar()
'limpia variables
fec1 = ""
fec2 = ""
tipo1 = ""
serie1 = ""
NroOpe = 0

'datos por filtrar
fec1 = TXTFecha1.Text
fec2 = TXTFecha2.Text
tipo1 = txtTipo.Text
serie1 = UCase(TxtSerie.Text)
NroOpe = Val(TxtNumero.Text)

End Sub

Sub grilla_datosclientes()
Dim I, sw, J, h, F As Integer
Dim id_sis As String
Dim Datos()

    Call datos_filtrar
    id_sis = ""
    F = 0
    J = 0

'Sql = "SP_FILTRO_GENERAL" & "'" & fec1 & "','" & fec2 & "'"
'Sql = Sql & "," & "'" & tipo1 & "'"
'Sql = Sql & "," & "'" & serie1 & "'"
'Sql = Sql & "," & NroOpe

    Envia = Array(fec1, _
            fec2, _
            tipo1, _
            serie1, _
            NroOpe)

    If Bac_Sql_Execute("SP_FILTRO_GENERAL", Envia) Then
        I = 1
        Do While Bac_SQL_Fetch(Datos())
            sw = 0 'cliente no esta
            With grilla
                .Enabled = True
                .AddItem ("")
                .RowHeight(2) = 315
                .Row = 2
                .Col = 1
                .SetFocus
                If Bac_Sql_Execute("SP_FILTRO_GENERAL", Envia) Then
                    I = 2
                    .Enabled = True
                    Do While Bac_SQL_Fetch(Datos())
                        sw = 1 'existe cliente
                        .Rows = I + 1
                        .RowHeight(I) = 315
                        .TextMatrix(I, 1) = Datos(1)                                 'Numero de documento
                        .TextMatrix(I, 2) = Datos(2)                                 'numero de documento
                        .TextMatrix(I, 3) = Datos(3)                                 'correlativo de operacion
                        .TextMatrix(I, 4) = Datos(11)                                'TIPO DE OPERACION
                        .TextMatrix(I, 5) = Datos(4)                                 'mascara de la serie
                        .TextMatrix(I, 6) = Format(Datos(5), "###,###,###,###.0000") 'nominal
                        .TextMatrix(I, 7) = Format(Datos(6), "dd/mm/yyyy")           'fecha de compra
                        .TextMatrix(I, 8) = Format(Datos(7), "###,###,###,###.0000") 'tir de compra
                        .TextMatrix(I, 9) = Format(Datos(8), "###,###,###,###.0000") 'porcentaje valor par de compra
                        .TextMatrix(I, 10) = Format(Datos(9), "###,###,###,###")     'valor compra
                        .TextMatrix(I, 11) = Format(Datos(10), "###,###,###,###0")   'valor presente a tir de compra
                        I = I + 1
                    Loop
                    k = I
                End If
            End With
        Loop
    End If
    
    If sw = 0 Then
        grilla.Enabled = False
        MsgBox "No Existe Información", vbCritical, "ERROR en Búsqueda"
        Toolbar1.Buttons(1).Enabled = False
        TXTFecha1.SetFocus
        Fux = 1
    Else
        Call HabilitarControles(False)
        Toolbar1.Buttons(1).Enabled = True
        grilla.Enabled = True
        grilla.SetFocus
    End If
    
End Sub

Sub liberar_informacion()
Dim x, var1, var2, q As Integer
ReDim Arreglo(grilla.Rows - 1)
ReDim Arreglo1(grilla.Rows - 1)

    For x = 1 To grilla.Rows - 1
        grilla.Row = x
        grilla.Col = 0
        
        If grilla.CellBackColor = Azul Then
            Arreglo(x) = grilla.TextMatrix(grilla.RowSel, 1)
            Arreglo1(x) = grilla.TextMatrix(grilla.RowSel, 3)
            var1 = CInt(Arreglo(x))
            var2 = CInt(Arreglo1(x))
            
            'libera información seleccionada cambiando el flag codigo_carterasuper
            'a "P" permanente de tabla MDCP
            
'            Sql = "SP_CAMBIODEESTADOMDCP" & " " & var1 & "," & var2
            Envia = Array(CDbl(var1), CDbl(var2))
            
            If Not Bac_Sql_Execute("SP_CAMBIODEESTADOMDCP", Envia) Then
                grilla.Enabled = False
                Call pintar_Grilla(grilla, grilla.RowSel, False, 0)
            End If
            
            'libera informacion seleccionada cambiando el flag codigo_carterasuper
            'a "P" en tabla MDDI
'            Sql = "SP_CAMBIODEESTADOMDDI" & " " & var1 & "," & var2
            Envia = Array(CDbl(var1), CDbl(var2))
            
            If Not Bac_Sql_Execute("SP_CAMBIODEESTADOMDDI", Envia) Then
                grilla.Enabled = False
            End If
            
            'libera informacion seleccionada cambiando el flag codigo_carterasuper
            'a "P" en tabla MDVI
'            Sql = "SP_CAMBIODEESTADOMDVI" & " " & var1 & "," & var2
            Envia = Array(CDbl(var1), CDbl(var2))
            
            If Not Bac_Sql_Execute("SP_CAMBIODEESTADOMDVI", Envia) Then
                grilla.Enabled = False
            End If
            
        End If
    Next x
End Sub

Private Sub txtTipo_DblClick()

    BacAyuda.Tag = "MDIN"
    BacAyuda.Show 1
   
    If giAceptar% = True Then
        txtTipo.Text = gsSerie$
        SendKeys "{ENTER}"
    End If
    
    Screen.MousePointer = 0

End Sub

Private Sub txtTipo_GotFocus()
    txtTipo.BackColor = Azul
    txtTipo.ForeColor = Blanco
End Sub

Private Sub txtTipo_KeyPress(KeyAscii As Integer)
KeyAscii = Asc(UCase(Chr(KeyAscii)))
If KeyAscii = 13 Then
    TxtSerie.SetFocus
End If
End Sub

Private Sub txtTipo_LostFocus()
    txtTipo.BackColor = Blanco
    txtTipo.ForeColor = Negro
End Sub

Private Sub txtserie_GotFocus()
    TxtSerie.BackColor = Azul
    TxtSerie.ForeColor = Blanco
End Sub

Private Sub TxtSerie_KeyPress(KeyAscii As Integer)
KeyAscii = Asc(UCase(Chr(KeyAscii))) 'transforman el texto en mayuscula
If KeyAscii = 13 Then
    If UCase(TxtSerie.Text) <> "" Then
        Call buscar_codigo
    End If
    TxtNumero.SetFocus
End If
End Sub

Sub buscar_codigo()
Dim Mascara As String
Dim Datos()

    Mascara = txtSerie.Text
'    Sql = "SP_BUSCACODIGOSERIE" & " " & "'" & Mascara & "'"
    Envia = Array(" ", Mascara)
    
    If Bac_Sql_Execute("SP_BUSCACODIGOSERIE", Envia) Then
        I = 1
        Do While Bac_SQL_Fetch(Datos())
            aux_codigo = Datos(1)
        Loop
    End If

End Sub

Private Sub TxtSerie_LostFocus()
    TxtSerie.BackColor = Blanco
    TxtSerie.ForeColor = Negro
End Sub

Private Sub Form_Load()
    
    Me.Icon = BacTrader.Icon
    Me.Top = 0
    Me.Left = 0
    
    Call Limpiar
    Call Limpiar_Aux
    Call limpiar_grilla
    Call desactivar_botones_barra
    Call HabilitarControles(True)
    Call Cargar_Grilla
    grilla.Enabled = False
    TXTFecha1.TabIndex = 1
    Me.Top = 1150
    Me.Left = 50
  
End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)
  
   If KeyAscii = 13 Then
      SendKeys "{TAB}"

   End If

End Sub

Sub Limpiar()
'Limpiar Pantalla
    TXTFecha1.Text = Format(Date, "dd/mm/yyyy")
    TXTFecha2.Text = Format(Date, "dd/mm/yyyy")
    txtTipo.Text = ""
    TxtSerie.Text = ""
    TxtNumero.Text = ""
     
End Sub

Sub limpiar_grilla()
'permite inicializar la grilla
Dim x As Integer
With grilla
    .Enabled = True
    .Clear
    .Rows = 3
    .Cols = 10
    .FixedRows = 2
    .FixedCols = 1
    .CellFontBold = False
    .GridLinesFixed = flexGridRaised
    .Enabled = False
        
End With
End Sub

Sub verificar_fecha(fech As Date)
Dim dateaux As String
'procedimiento que comprueba las fechas, tomando en cuenta la fecha actual
   dateaux = Date
   If (fech > dateaux) Then
      'error
      MsgBox "Fecha fuera de rango ", vbOKCancel, "Error de Fecha"
      ok = 0
   Else
      ok = 1
   End If
End Sub

Sub verificar_fecha1(fech As Date, fech1 As Date)
Dim dateaux As String
'procedimiento que comprueba las fechas, tomando en cuenta la fecha actual
   dateaux = Date
If (fech > dateaux) Then
   'error
    MsgBox "Fecha fuera de rango ", vbOKCancel, "Error de Fecha"
    ok = 0
Else
    If (fech < fech1) Then
        MsgBox "Fecha Inferior a la Fecha de Inicioo ", vbOKCancel, "Error de Fecha"
        ok = 0
    Else
        ok = 1
    End If
End If
End Sub

Sub pintar_Grilla(Grid As MSFlexGrid, Fila As Integer, pintado As Boolean, Y As Integer)
'permite pintar la grilla si se selecciona
With Grid
    Dim x%
    For x = 0 To .Cols - 1
        .Col = x
        If Y = 0 Then
            If pintado = True Then
                .CellBackColor = Gris
                .CellForeColor = Negro
                SW = 1
                                
            Else
                
                .CellBackColor = Azul
                .CellForeColor = Blanco
                SW = 0
                
            End If
       Else
            .CellBackColor = Gris
            .CellForeColor = Negro
            
            
       End If
    Next x
End With
grilla.Col = 1

End Sub

Private Sub grilla_DblClick()
With grilla
    
    If grilla.CellBackColor = Azul Then
        
        Call pintar_Grilla(grilla, grilla.RowSel, True, 0)
        grilla.BackColorSel = Azul
        
    Else
         
         Call pintar_Grilla(grilla, grilla.RowSel, False, 0)
         grilla.BackColorSel = Gris
        
    End If
    
End With

End Sub

Private Sub Grilla_KeyDown(KeyCode As Integer, Shift As Integer)

If KeyCode = vbKeyM Then
    'Marca las celda seleccionada
    Call pintar_Grilla(grilla, grilla.RowSel, False, 0)
    
Else
    If KeyCode = vbKeyD Then
        'desmarca las celda seleccionada
        Call pintar_Grilla(grilla, grilla.RowSel, True, 0)
            
    End If
End If
    
End Sub

Private Sub txtFecha1_GotFocus()
    TXTFecha1.BackColor = Azul
    TXTFecha1.ForeColor = Blanco
End Sub

Private Sub txtFecha1_LostFocus()
    TXTFecha1.BackColor = Blanco
    TXTFecha1.ForeColor = Negro
End Sub

Private Sub txtFecha1_KeyDown(KeyCode As Integer, Shift As Integer)
Dim fechaux1 As Date
Dim fechaux2 As Date
    If KeyCode = 13 Then
      fechaux1 = TXTFecha1.Text
      Call verificar_fecha(fechaux1)
      If ok = 1 Then
        TXTFecha2.SetFocus
      Else
        TXTFecha1.Text = Format(Date, "dd/mm/yyyy")
        TXTFecha1.SetFocus
      End If
   End If
End Sub

Private Sub txtFecha2_GotFocus()
    TXTFecha2.BackColor = Azul
    TXTFecha2.ForeColor = Blanco
End Sub

Private Sub txtFecha2_LostFocus()
    TXTFecha2.BackColor = Blanco
    TXTFecha2.ForeColor = Negro
End Sub

Private Sub txtFecha2_Keydown(KeyCode As Integer, Shift As Integer)
Dim fechaux1 As Date
Dim fechaux2 As Date
Dim fechaux
   If KeyCode = 13 Then
      fechaux1 = TXTFecha1.Text
      fechaux2 = TXTFecha2.Text
      Call verificar_fecha1(fechaux2, fechaux1)
      If ok = 1 Then
        txtTipo.SetFocus
      Else
        TXTFecha2.Text = Format(Date, "dd/mm/yyyy")
        TXTFecha2.SetFocus
      End If
   End If

End Sub

Private Sub txtnumero_GotFocus()
    TxtNumero.BackColor = Azul
    TxtNumero.ForeColor = Blanco
End Sub

Private Sub TxtNumero_LostFocus()
    TxtNumero.BackColor = Blanco
    TxtNumero.ForeColor = Negro
End Sub

Private Sub txtnumero_KeyPress(KeyAscii As Integer)

If KeyAscii = 13 Then
      Toolbar1.Buttons(2).Enabled = True
      grilla.Enabled = True
      grilla.SetFocus
           
ElseIf Not ((KeyAscii > 47 And KeyAscii < 58) Or KeyAscii = 8) Then
      KeyAscii = 0
             
   End If
     
   BacCaracterNumerico KeyAscii

End Sub

Private Sub grilla_RowColChange()
If grilla.CellBackColor = Azul Then
    grilla.BackColorSel = Gris
Else
    grilla.BackColorSel = Azul
End If
End Sub

