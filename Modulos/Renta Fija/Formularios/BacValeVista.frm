VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form BacValeVista 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Vale Vistas"
   ClientHeight    =   4035
   ClientLeft      =   2130
   ClientTop       =   1845
   ClientWidth     =   9045
   FillStyle       =   0  'Solid
   Icon            =   "BacValeVista.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4035
   ScaleWidth      =   9045
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   4
      Top             =   0
      Width           =   9045
      _ExtentX        =   15954
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Documento"
            Object.Tag             =   "1"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            Object.Tag             =   "2"
            ImageIndex      =   3
         EndProperty
      EndProperty
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   5265
         Top             =   120
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   22
         ImageHeight     =   22
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   3
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacValeVista.frx":030A
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacValeVista.frx":0624
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacValeVista.frx":093E
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin MSFlexGridLib.MSFlexGrid Grilla2 
      Height          =   1200
      Left            =   120
      TabIndex        =   2
      Top             =   2640
      Visible         =   0   'False
      Width           =   4275
      _ExtentX        =   7541
      _ExtentY        =   2117
      _Version        =   393216
   End
   Begin VB.ComboBox Cmbdiv 
      BackColor       =   &H80000002&
      ForeColor       =   &H80000005&
      Height          =   315
      ItemData        =   "BacValeVista.frx":0C58
      Left            =   2640
      List            =   "BacValeVista.frx":0C62
      TabIndex        =   1
      Text            =   "SI"
      Top             =   1515
      Visible         =   0   'False
      Width           =   1275
   End
   Begin MSFlexGridLib.MSFlexGrid Grilla 
      Height          =   3300
      Left            =   15
      TabIndex        =   3
      Top             =   675
      Width           =   8925
      _ExtentX        =   15743
      _ExtentY        =   5821
      _Version        =   393216
      Rows            =   3
      FixedRows       =   2
      RowHeightMin    =   315
      BackColor       =   -2147483633
      ForeColor       =   -2147483635
      BackColorFixed  =   8421376
      ForeColorFixed  =   -2147483643
      BackColorSel    =   8388608
      ForeColorSel    =   -2147483643
      BackColorBkg    =   12632256
      FocusRect       =   0
      GridLines       =   2
      GridLinesFixed  =   0
      PictureType     =   1
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin Threed.SSPanel SSPanel1 
      Height          =   3525
      Left            =   -45
      TabIndex        =   0
      Top             =   525
      Width           =   9105
      _Version        =   65536
      _ExtentX        =   16060
      _ExtentY        =   6218
      _StockProps     =   15
      Caption         =   "SSPanel1"
      BackColor       =   12632256
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      FloodColor      =   -2147483635
   End
End
Attribute VB_Name = "BacValeVista"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public estado As String
Public Valor_Documento As Long
Public Rut_Documento As Long
Public Dv_Documento As String
Public Rut As Long
Public Dv As String
Public NOMBRE As String
Public Numero_Escrito As String
Dim Codigo_Aux As String
Dim Divide As String
Dim Arreglo()
Dim Arreglo1()
Dim Arreglo2()
Dim Arreglo3()
Dim Sw As Integer


Const Blanco = &H80000005
Const Azul = &H800000
Const Negro = &H0&
Const Gris = &HC0C0C0

Sub Grilla_Datos()

Dim Datos()
Dim AuxEstado As String
Dim Protege As String


Grilla.Enabled = True
If Bac_Sql_Execute("Sp_Datos_Vale_vista") Then
        I = 2

Do While Bac_SQL_Fetch(Datos())
      Sw = 1 'existe cliente
      With Grilla
            .AddItem ("")
            .RowHeight(2) = 315
            .Row = 2
            .Col = 1

            .Rows = I + 1
            .RowHeight(I) = 315
            AuxEstado = Datos(13)
            Call DocuEstado(AuxEstado)
            .TextMatrix(I, 1) = estado                                'Estado Documento
            .TextMatrix(I, 2) = Datos(3)                              'Forma pago
            .TextMatrix(I, 3) = Datos(4)                              'Id Sistema
            .TextMatrix(I, 4) = IIf(IsNull(Datos(5)), " ", Datos(5))  'Codigo Producto
            .TextMatrix(I, 5) = Datos(6)                              'Número Operación
            Rut_Documento = Datos(7)
            Dv_Documento = IIf(IsNull(Datos(9)), " ", Datos(9))
            .TextMatrix(I, 6) = Datos(10)                             'Nombre Cliente
            .TextMatrix(I, 7) = Format(Datos(11), FEntero)            'Valor Documento
            .TextMatrix(I, 8) = Datos(12)                             'Número Documento
            Divide = Datos(14)
            Call DocuEstado1(Divide)
            .TextMatrix(I, 9) = estado                                'Divide Documento
            Protege = Datos(15)
            Call DocuEstado1(Protege)
            .TextMatrix(I, 10) = estado                               'Protege Documentoo
            .TextMatrix(I, 11) = Datos(1)                             'Fecha Generación
            .TextMatrix(I, 12) = Datos(2)                             'Fecha Emisión
            .TextMatrix(I, 13) = Datos(16)                            'Código Transacción
            .TextMatrix(I, 14) = Datos(17)                            'NºCta.Cte.
            
            If AuxEstado = "A" Then
            
                ColorFuente I, .Col
            
            End If
            
'            i = i + 1
      End With

      With Grilla2
            .AddItem ("")
            
            I = I + 1
      End With

Loop
End If
    

'''    If sw = 0 Then
'''        Grilla.Enabled = False
'''        MsgBox "No Existe Información", vbCritical, "ERROR en Búsqueda"
'''
'''    Else
'''        Grilla.Enabled = True
'''
'''    End If
    
End Sub

Function DocuEstado1(Datos)
If Datos = "S" Then
    estado = "SI"
Else
    estado = "NO"
    
End If
   
End Function

Function DocuEstado(Datos)
If Datos = "A" Then
    estado = "ANULADO"
Else
    If Datos = "E" Then
        estado = "EMITIDO"
    Else
        estado = "GENERADO"
    End If
End If
   
End Function

Sub Insertar_Datos_grilla(num_row As Integer)
Dim estado, formapago, Sistema, divdocum, prodocum, codprod As String
Dim numope, numdocum, I As Integer
Dim fecha_gen, fecha_emi As Date

With Grilla
    estado = .TextMatrix(num_row, 1)
    formapago = .TextMatrix(num_row, 2)
    Sistema = .TextMatrix(num_row, 3)
    codprod = .TextMatrix(num_row, 4)
    numope = .TextMatrix(num_row, 5)
          
    numdocum = .TextMatrix(num_row, 8)
    divdocum = .TextMatrix(num_row, 9)
    prodocum = .TextMatrix(num_row, 10)
    fecha_gen = .TextMatrix(num_row, 11)
    fecha_emi = .TextMatrix(num_row, 12)
    
    '.Row = .Rows - 1
'    .RemoveItem (num_row)
    
    Call Buscar_Codigo_Producto(codprod)
    
    For I = 2 To BacValores.Grilla_Valores.Rows - 1
        .AddItem " "
        .RowHeight(.Rows - 1) = 315
        .TextMatrix(.Row, 1) = estado
        .TextMatrix(.Row, 2) = formapago
        .TextMatrix(.Row, 3) = Sistema
        .TextMatrix(.Row, 4) = codprod
        .TextMatrix(.Row, 5) = numope
        .TextMatrix(.Row, 6) = BacValores.Grilla_Valores.TextMatrix(I, 3)
        .TextMatrix(.Row, 7) = BacValores.Grilla_Valores.TextMatrix(I, 4)
        .TextMatrix(.Row, 8) = numdocum
        .TextMatrix(.Row, 9) = divdocum
        .TextMatrix(.Row, 10) = prodocum
        .TextMatrix(.Row, 11) = fecha_gen
        .TextMatrix(.Row, 12) = fecha_emi
        
        
        
        Envia = Array()
 
        AddParam Envia, fecha_gen
        AddParam Envia, fecha_emi
        If formapago = "VALE VISTA" Then
            AddParam Envia, 2
        Else
            AddParam Envia, 11
        End If
        If Sistema = "FORWARD" Then
            AddParam Envia, "BFW"
        Else
            If Sistema = "RENTA FIJA" Then
                AddParam Envia, "BTR"
            Else
                AddParam Envia, "BCC"
            End If
        End If
        
        
        AddParam Envia, Codigo_Aux
        AddParam Envia, CDbl(numope)
        AddParam Envia, CDbl(BacValores.Grilla_Valores.TextMatrix(I, 1))
        AddParam Envia, 1 'BacValores.Grilla_Valores.TextMatrix(i, 2)
        AddParam Envia, CDbl(BacValores.Grilla_Valores.TextMatrix(I, 4))
        AddParam Envia, I - 1 'CDbl(numdocum)
        AddParam Envia, "G"
        If divdocum = "SI" Then
            AddParam Envia, "S"
        Else
            AddParam Envia, "N"
        End If
        If prodocum = "SI" Then
            AddParam Envia, "S"
        Else
            AddParam Envia, "N"
        End If
               
        AddParam Envia, BacValores.Grilla_Valores.TextMatrix(I, 3)
        
         
        If Not Bac_Sql_Execute("Sp_Graba_Vale_Vista", Envia) Then
            Exit Sub
        End If

            
    Next I

End With
    
End Sub

Sub Borrar_Datos(numopera As Long, Valor As Long)
Dim Datos()
Envia = Array()
AddParam Envia, CDbl(numopera)
AddParam Envia, Valor

If Bac_Sql_Execute("Sp_Borrar_Datos", Envia) Then
    If Not Bac_SQL_Fetch(Datos()) Then
        Exit Sub
       
    End If
End If

End Sub

Sub Buscar_Codigo_Producto(cod As String)
Dim Datos()
Envia = Array()
AddParam Envia, cod

If Bac_Sql_Execute("Sp_Codigo_Producto", Envia) Then
    If Bac_SQL_Fetch(Datos()) Then
        Codigo_Aux = Datos(1)
    End If
End If
End Sub


Private Sub Cmbdiv_KeyPress(KeyAscii As Integer)
Dim numero_fila As Integer
Dim Datos1()

If Grilla.TextMatrix(Grilla.Row, 9) = "NO" Then
Select Case KeyAscii
    Case 13
        Me.Cmbdiv.Visible = False
        Me.Grilla.SetFocus
        Grilla.Text = Cmbdiv.Text
        If Grilla.Col = 9 Then
            If Cmbdiv = "SI" Then
                
                Rut = Rut_Documento
                Dv = Dv_Documento
                NOMBRE = Grilla.TextMatrix(Grilla.Row, 6)
                Valor_Documento = Grilla.TextMatrix(Grilla.Row, 7)
                BacValores.Show 1
                If BacValores.Aceptar = True And BacValores.Grilla_Valores.Rows <> 3 Then
                    numero_fila = Grilla.Row
                    Call Borrar_Datos(CDbl(Grilla.TextMatrix(numero_fila, 5)), CDbl(Grilla.TextMatrix(Grilla.Row, 7)))
                    Call Insertar_Datos_grilla(numero_fila)
                    Unload BacValores
                Else
                    Grilla.TextMatrix(Grilla.Row, 9) = "NO"
                    
                End If
                
                
            End If
        Else
                            
            Envia = Array()
            If Cmbdiv = "SI" Then
                AddParam Envia, "S"
            Else
                AddParam Envia, "N"
            End If
                AddParam Envia, CDbl(Grilla.TextMatrix(Grilla.Row, 5))
                
                
                If Bac_Sql_Execute("Sp_Cambio_Dato", Envia) Then
                    If Not Bac_SQL_Fetch(Datos1()) Then
                        Exit Sub
                       
                    End If
                Sw = 1
                End If
            
        End If
End Select
End If

If Grilla.Col = 10 Then
Select Case KeyAscii
    Case 13
        Me.Cmbdiv.Visible = False
        Me.Grilla.SetFocus
        Grilla.Text = Cmbdiv.Text
End Select
End If

End Sub

Private Sub Form_Load()
    
    Me.Icon = BacTrader.Icon
    Me.Top = 0
    Me.Left = 0
    Sw = 0
    Call limpiar_grilla
    Call Cargar_Grilla
    Call Grilla_Datos
    
    Me.Top = 1150
    Me.Left = 50
  
End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)
  
If KeyAscii = 13 Then
   SendKeys "{TAB}"

End If

End Sub


Sub limpiar_grilla()
'permite inicializar la grilla
Dim X As Integer
With Grilla
    .Enabled = True
    .Clear
    .Rows = 3
    .Cols = 13
    .FixedRows = 2
    .FixedCols = 1
    .CellFontBold = False
    .GridLinesFixed = flexGridRaised
    .Enabled = False
        
End With
End Sub

Sub Cargar_Grilla()
'carga la grilla con los titulos correspondientes
Dim m, mm As Integer

With Grilla2
   .Enabled = True
   .Clear
   .Rows = 3
   .Cols = 15
End With

With Grilla
   .Enabled = True
   .Clear
   .Rows = 3
   .Cols = 15
   .FixedRows = 2
   .FixedCols = 1
   
   .TextMatrix(0, 1) = "Estado"
   .TextMatrix(1, 1) = "Documento"
   .TextMatrix(0, 2) = "Forma De"
   .TextMatrix(1, 2) = "Pago"
   .TextMatrix(0, 3) = "Sistema"
   .TextMatrix(0, 4) = "Tipo "
   .TextMatrix(1, 4) = "Operación "
   .TextMatrix(0, 5) = "Numero "
   .TextMatrix(1, 5) = "Operación "
   .TextMatrix(0, 6) = "Nombre"
   .TextMatrix(1, 6) = "Cliente"
   .TextMatrix(0, 7) = "Valor"
   .TextMatrix(1, 7) = "Documento"
   .TextMatrix(0, 8) = "Número"
   .TextMatrix(1, 8) = "Documento"
   .TextMatrix(0, 9) = "División "
   .TextMatrix(1, 9) = "Documento"
   .TextMatrix(0, 10) = "Protege"
   .TextMatrix(1, 10) = "Documento"
   .TextMatrix(0, 11) = "Fecha"
   .TextMatrix(1, 11) = "Generación"
   .TextMatrix(0, 12) = "Fecha"
   .TextMatrix(1, 12) = "Emisión"
   .TextMatrix(0, 13) = "Código"
   .TextMatrix(1, 13) = "Transacción"
   .TextMatrix(0, 14) = "Nº Cta.Cte."
   
   
   
   .ColWidth(0) = 0
    
   .ColWidth(1) = 1500
   .ColWidth(2) = 2000
   .ColWidth(3) = 1500
   .ColWidth(4) = 3000
   .ColWidth(5) = 1000
   .ColWidth(6) = 3000
   .ColWidth(7) = 2000
   .ColWidth(8) = 1200
   .ColWidth(9) = 1200
   .ColWidth(10) = 1200
   .ColWidth(11) = 1200
   .ColWidth(12) = 1200
   .ColWidth(13) = 1200
   .ColWidth(14) = 2000
   
     
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

Private Sub Grilla_KeyPress(KeyAscii As Integer)
    
Select Case KeyAscii
    Case 13
        If (Grilla.Col = 9 And Grilla.TextMatrix(Grilla.Row, 9) <> "SI") Or Grilla.Col = 10 Then
            Cmbdiv.ListIndex = 0
            Call PROC_POSI_TEXTO(Grilla, Cmbdiv)
            Cmbdiv.Visible = True
            Cmbdiv.SetFocus
        End If
End Select

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Index
    Case 1
        'Emite Documento
        Call Emitir_Vales_Vista
        
    
    Case 2
        'Salir
        Unload Me
    
        
        
End Select

End Sub



Sub Refresca_Datos()
    'Me.Refresh
    Call Grilla_Datos2
    'MsgBox "Estoy Refrescando la Grilla"
End Sub

Sub Grilla_Datos2()

Dim Datos()
Dim AuxEstado As String
Dim Divide As String
Dim Protege As String

Grilla2.Rows = 2

Grilla.Enabled = True
If Bac_Sql_Execute("Sp_Datos_Vale_vista") Then
        I = 2

    Do While Bac_SQL_Fetch(Datos())
          Sw = 1 'existe cliente
          With Grilla2
                .AddItem ("")
                
                I = I + 1
          End With
            
          
    
    Loop
End If
    
If Grilla.Rows <> Grilla2.Rows And Sw = 1 Then

    Call Grilla_Datos

End If
    
End Sub

Sub pintar_Grilla(Grid As MSFlexGrid, Fila As Integer, pintado As Boolean, Y As Integer)
'permite pintar la grilla si se selecciona
With Grid
    Dim X%
    For X = 0 To .Cols - 1
        .Col = X
        If Y = 0 Then
            If pintado = True Then
                .CellBackColor = Gris
                .CellForeColor = Negro
                Sw = 1
                                
            Else
                
                .CellBackColor = Azul
                .CellForeColor = Blanco
                Sw = 0
                
            End If
       Else
            .CellBackColor = Gris
            .CellForeColor = Negro
            
            
       End If
    Next X
End With
Grilla.Col = 1

End Sub

Private Sub Grilla_DblClick()
With Grilla
If .TextMatrix(.Row, 1) = "GENERADO" Then
    
    If Grilla.CellBackColor = Azul Then
        
        Call pintar_Grilla(Grilla, Grilla.RowSel, True, 0)
        Grilla.BackColorSel = Azul
        
        
    Else
         
         Call pintar_Grilla(Grilla, Grilla.RowSel, False, 0)
         Grilla.BackColorSel = Gris
        
    End If
End If
End With

End Sub

Private Sub grilla_RowColChange()
If Grilla.CellBackColor = Azul Then
    Grilla.BackColorSel = Gris
Else
    Grilla.BackColorSel = Azul
End If
End Sub

Sub Emitir_Vales_Vista()
Dim X, var2, var3, var4 As Integer
Dim var1 As String

ReDim Arreglo(Grilla.Rows - 1)
ReDim Arreglo1(Grilla.Rows - 1)
ReDim Arreglo2(Grilla.Rows - 1)
ReDim Arreglo3(Grilla.Rows - 1)

For X = 1 To Grilla.Rows - 1
    Grilla.Row = X
    Grilla.Col = 0
    var1 = ""
    var2 = 0
    var3 = 0
    var4 = 0
    If Grilla.CellBackColor = Azul Then
        Arreglo(X) = Grilla.TextMatrix(Grilla.RowSel, 2)
        Arreglo1(X) = Grilla.TextMatrix(Grilla.RowSel, 5)
        Arreglo2(X) = Grilla.TextMatrix(Grilla.RowSel, 7)
        Arreglo3(X) = Grilla.TextMatrix(Grilla.RowSel, 8)
        Numero_Escrito = MONTO_ESCRITO(CDbl(Grilla.TextMatrix(Grilla.RowSel, 7)))
        var1 = Arreglo(X)                    'documento
        var2 = CDbl(Arreglo1(X))             'numero operacion
        var3 = CDbl(Arreglo2(X))             'monto
        var4 = CDbl(Arreglo3(X))             'Nro Documento
                    
        Call Imprime_Documento(var1, Val(var2), Val(var3), Val(var4))
        
        
    End If
Next X
End Sub

Sub Imprime_Documento(Docu As String, Nro, Valor, NroDocu As Integer)
Dim nFila     As Long
Dim nTab      As Integer
Dim aString()
Dim nCont     As Integer
Dim sTexto    As String
Dim nCont2    As Integer
Dim cCaracter As String
Dim objBuf As Word.Document
Dim Datos()

Sw = 0
If Docu = "VALE VISTA" Then
   
   
   On Error GoTo HError
   
   Envia = Array()
   AddParam Envia, Nro
   AddParam Envia, Valor
   AddParam Envia, NroDocu
   

   If Not Bac_Sql_Execute("Sp_Documento_Vale_Vista", Envia) Then
      MsgBox "Problemas al leer datos de ...", vbCritical, "MENSAJE"
      Exit Sub
   End If

   If Bac_SQL_Fetch(Datos()) Then
         
      Set objBuf = Nothing
      Set objBuf = IniciaWordListadoLog("Vale Vista")
      With objBuf
      
         .Application.Selection.Font.Size = 12
                  
         'Monto del Vale Vista
         .Bookmarks("Monto1").Select
         .Application.Selection.Text = Format(Datos(7), FEntero) + ".------------"

         'Dia
         .Bookmarks("Dia1").Select
         .Application.Selection.Text = Format(Datos(8), "D")
         
         'Mes
         .Bookmarks("Mes1").Select
         .Application.Selection.Text = UCase(Format(Datos(8), "MMMM"))
         
         'Año
         .Bookmarks("Ano1").Select
         .Application.Selection.Text = Format(Datos(8), "YYYY")
         
         'Nombre del cliente
         .Bookmarks("Nombre1").Select
         .Application.Selection.Text = Datos(1)
         
         'Monto Escrito
         .Bookmarks("MontoEscrito1").Select
         .Application.Selection.Text = Numero_Escrito + "---------------------"
         
      
      End With
      
   End If
   
   objBuf.Activate
   objBuf.Application.Visible = True
   objBuf.Protect wdAllowOnlyFormFields, , "administra"
   Set objBuf = Nothing
   
   Envia = Array()
   AddParam Envia, Nro
   AddParam Envia, Valor
   AddParam Envia, NroDocu
   

   If Not Bac_Sql_Execute("Sp_Emitido", Envia) Then
      MsgBox "Problemas al leer datos de ...", vbCritical, "MENSAJE"
      Exit Sub
   End If
   Sw = 1
   
       
   
Else
    BacTrader.bacrpt.ReportFileName = RptList_Path & "CAR_ABO_CTA_CTE.RPT"
    BacTrader.bacrpt.StoredProcParam(0) = Nro
    BacTrader.bacrpt.StoredProcParam(1) = Valor
    BacTrader.bacrpt.StoredProcParam(2) = Val(NroDocu)
    BacTrader.bacrpt.Formulas(0) = "Monto='" & Numero_Escrito & "'"
    BacTrader.bacrpt.Connect = CONECCION
    BacTrader.bacrpt.Action = 1
    
    Envia = Array()
    AddParam Envia, Nro
    AddParam Envia, Valor
    AddParam Envia, NroDocu
   

    If Not Bac_Sql_Execute("Sp_Emitido", Envia) Then
       MsgBox "Problemas al leer datos de ...", vbCritical, "MENSAJE"
       Exit Sub
    End If
    Sw = 1
End If

Exit Sub

HError:
    
    MsgBox "error" & err.Description
            
End Sub

Function IniciaWordListadoLog(Titulo As String) As Word.Document
   Dim UbicacionDeDocumentos As String
   On Error Resume Next
   Dim Wrd As Object
   Set Wrd = GetObject(, "Word.Application")
   If err.Number <> 0 Then
       Set Wrd = New Word.Application
   End If
   err.Clear
   
   On Error GoTo 0
   
   UbicacionDeDocumentos = IIf(Right(gsDOC_Path, 1) <> "\", gsDOC_Path & "\", gsDOC_Path)
   
   If Titulo = "Vale Vista" Then
      Set IniciaWordListadoLog = Wrd.Documents.Add(UbicacionDeDocumentos & "VALE A LA VISTA 1.doc")
   End If
   DoEvents

End Function


Sub ColorFuente(Row, Col As Integer)

    With Grilla
    
        .Row = Row
        .Redraw = False
        
        For I = 0 To .Cols - 1
            
            Grilla.Col = I
            Grilla.CellForeColor = &HC0&
        
        Next I
        
        .Col = Col
    
        .Redraw = True
    
    End With

End Sub
