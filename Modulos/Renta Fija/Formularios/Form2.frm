VERSION 5.00
Begin VB.Form Form2 
   Caption         =   "Form2"
   ClientHeight    =   3195
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   4680
   LinkTopic       =   "Form2"
   ScaleHeight     =   3195
   ScaleWidth      =   4680
   StartUpPosition =   3  'Windows Default
End
Attribute VB_Name = "Form2"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'''Dim serie_aux, tipo_aux, fec1, fec2, aux_codigo, tipo1, serie1, flag_cartera, glosa_aux, codigo_serie As String
'''Dim Arreglo() 'arreglo que guardar los indices
'''Dim Arreglo1()
'''Dim S1, S2, NroOpe, ok, Fux, Sw As Integer
'''
'''
'''Const Blanco = &H80000005
'''Const Azul = &H800000
'''Const Negro = &H0&
'''Const Gris = &HC0C0C0
'''
'''Function HabilitarControles(Valor)
''''habilita los controles para filtrar informacion
'''    txtFecha1.Enabled = Valor
'''    txtFecha2.Enabled = Valor
'''    txtTipo.Enabled = Valor
'''    txtSerie.Enabled = Valor
'''    txtnumero.Enabled = Valor
'''End Function
'''
'''Sub Limpiar_Aux()
''''limpia las variables auxiliares que se ocupan
'''    fec1 = ""
'''    fec2 = ""
'''    tipo1 = ""
'''    serie1 = ""
'''    NroOpe = 0
'''    tipo_aux = ""
'''    serie_aux = ""
'''    codigo_serie = ""
'''    flag_cartera = ""
'''    Sw = 1
'''    ok = 0
'''    Fux = 0
'''    S1 = 0
'''    S2 = 0
'''
'''End Sub
'''
'''
'''Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
''''muestra los eventos que provocan la barra
'''Select Case Button.Index
'''    Case 1
'''        'libera Información
'''        Call liberar_informacion
'''        Call grilla_datosclientes
'''
'''    Case 2
'''        'Busca a los clientes dependiendo de las condiciones
'''        Toolbar1.Buttons(1).Enabled = True
'''        grilla.Enabled = True
'''        Call datos_filtrar
'''        Call grilla_datosclientes
'''        If Fux = 0 Then
'''            Toolbar1.Buttons(2).Enabled = False
'''            Call HabilitarControles(False)
'''        End If
'''
'''    Case 3
'''        'limpiar todos los datos del formulario
'''        Call Limpiar
'''        Call Limpiar_Aux
'''        Call Cargar_Grilla
'''        Call desactivar_botones_barra
'''        Call datos_filtrar
'''        Call HabilitarControles(True)
'''        grilla.Enabled = False
'''        txtFecha1.TabIndex = 1
'''        Me.Top = 1155
'''        Me.Left = 45
'''        txtFecha1.SetFocus
'''
'''    Case 4
'''        Unload Me
'''
'''End Select
'''
'''End Sub
'''
'''Sub desactivar_botones_barra()
''''desactiva los botones de la barra
'''    Toolbar1.Buttons(1).Enabled = False
'''    Toolbar1.Buttons(2).Enabled = True
'''    Toolbar1.Buttons(3).Enabled = True
'''    Toolbar1.Buttons(4).Enabled = True
'''End Sub
'''
'''Sub Cargar_Grilla()
''''carga la grilla con los titulos correspondientes
'''Dim m, mm As Integer
'''With grilla
'''   .Enabled = True
'''   .Clear
'''   .Rows = 3
'''   .Cols = 12
'''   .FixedRows = 2
'''   .FixedCols = 0
'''   .TextMatrix(0, 1) = "Número"
'''   .TextMatrix(1, 1) = "Documento"
'''   .TextMatrix(0, 2) = "Número"
'''   .TextMatrix(1, 2) = "Operación"
'''   .TextMatrix(0, 3) = "Correlativo"
'''   .TextMatrix(0, 4) = "Tipo de"
'''   .TextMatrix(1, 4) = "Operación"
'''   .TextMatrix(0, 5) = "Nemotécnico"
'''   .TextMatrix(0, 6) = "Nominal"
'''   .TextMatrix(0, 7) = "Fecha"
'''   .TextMatrix(1, 7) = "Compra"
'''   .TextMatrix(0, 8) = "Tir Compra"
'''   .TextMatrix(0, 9) = "Porcentaje"
'''   .TextMatrix(1, 9) = "Valor Par"
'''   .TextMatrix(0, 10) = "Valor"
'''   .TextMatrix(1, 10) = "Compra"
'''   .TextMatrix(0, 11) = "Valor"
'''   .TextMatrix(1, 11) = "Presente"
'''
'''   .ColWidth(0) = 0
'''
'''   .ColWidth(1) = 1200
'''   .ColWidth(2) = 1000
'''   .ColWidth(3) = 1000
'''   .ColWidth(4) = 1200
'''   .ColWidth(5) = 1200
'''   .ColWidth(6) = 2000
'''   .ColWidth(7) = 1000
'''   .ColWidth(8) = 1200
'''   .ColWidth(9) = 1200
'''   .ColWidth(10) = 2000
'''   .ColWidth(11) = 2000
'''
'''    For m = 0 To .Rows - 2
'''        .RowHeight(m) = 227
'''    Next m
'''    For m = 0 To .Rows - 1
'''        For mm = 0 To .Cols - 1
'''            .Col = mm
'''            .Row = m
'''            .CellFontBold = True
'''            .GridLinesFixed = flexGridNone
'''        Next mm
'''    Next m
'''    .CellFontBold = False
'''    .Rows = .Rows - 1
'''   If .Rows > 2 Then
'''      .Col = 0
'''      .ColSel = .Cols - 1
'''   Else
'''      .Col = 0
'''      .ColSel = 0
'''   End If
'''     .Enabled = False
'''
'''End With
'''End Sub

Sub grilla_datos()
    If Bac_Sql_Execute("Sp_Documentacion_Bancaria") Then
        I = 1
        Do While Bac_SQL_Fetch(Datos())
            Sw = 0 'cliente no esta
            With grilla
                .Enabled = True
                .AddItem ("")
                .RowHeight(2) = 315
                .Row = 2
                .Col = 1
                .SetFocus
                If Bac_Sql_Execute("Sp_Documentacion_Bancaria") Then
                    I = 2
                    .Enabled = True
                    Do While Bac_SQL_Fetch(Datos())
                        Sw = 1 'existe cliente
                        .Rows = I + 1
                        .RowHeight(I) = 315
                        .TextMatrix(I, 1) = Datos(1)    'Tipo Operación
                        .TextMatrix(I, 2) = Datos(2)    'Número Operación
                        .TextMatrix(I, 3) = Datos(3)    'Rut Cliente
                        .TextMatrix(I, 4) = Datos(5)    'Dv Cliente
                        .TextMatrix(I, 5) = Datos(6)    'Nombre Cliente
                        .TextMatrix(I, 6) = Datos(7)    'Valor
                        I = I + 1
                    Loop
                    k = I
                End If
            End With
        Loop
    End If
    
    If Sw = 0 Then
        grilla.Enabled = False
        MsgBox "No Existe Información", vbCritical, "ERROR en Búsqueda"
        Toolbar1.Buttons(1).Enabled = False
        txtFecha1.SetFocus
        Fux = 1
    Else
        grilla.Enabled = True
        grilla.SetFocus
    End If
    
End Sub




Private Sub Form_Load()
    
    Me.Icon = BacTrader.Icon
    Me.Top = 0
    Me.Left = 0
    
'''    Call Limpiar
'''    Call Limpiar_Aux
    Call limpiar_grilla
'''    Call desactivar_botones_barra
'''    Call HabilitarControles(True)
    Call Cargar_Grilla
    grilla.Enabled = False
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

Private Sub grilla_RowColChange()
If grilla.CellBackColor = Azul Then
    grilla.BackColorSel = Gris
Else
    grilla.BackColorSel = Azul
End If
End Sub



