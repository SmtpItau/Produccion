VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsPlanillas"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit
Dim i&, X&, Y&
Dim xStr$
Dim DATOS()

Public objPlanilla  As Object
Public coleccion    As New Collection

Private Sub Class_Initialize()
   Set objPlanilla = New clsPlanilla
End Sub
Private Sub Class_Terminate()
   Set objPlanilla = Nothing
End Sub
'******************************************************************
'*   Cantidad de filas en Coleccion de Planillas
Public Function Cantidad() As Long
   Cantidad = coleccion.Count
End Function
'******************************************************************
'*   Cantidad de filas en Coleccion de Planillas
Public Sub Cargar(objLista As Object, Optional objOriginal)
Dim i&, xLine$, xStr$

    objLista.Clear
    
    For i = 1 To coleccion.Count
        With coleccion(i)
            xLine = .planilla_fecha
            xStr = Format(.planilla_numero, "######0"): xLine = xLine & Space(8 - Len(xStr)) & xStr
            xStr = .Operacion_Moneda: xLine = xLine & Space(4 - Len(xStr)) & xStr
            xStr = Format(.monto_origen, "###,###,###,##0.00"): xLine = xLine & Space(18 - Len(xStr)) & xStr
            xStr = .Tipo_Operacion_Cambio: xLine = xLine & Space(5 - Len(xStr)) & xStr & Space(2)
            xStr = .interesado_nombre: xLine = xLine & " " & xStr
            If VarType(objOriginal) = vbObject Then
                .Planilla_Original_Numero = objOriginal.planilla_numero
                .Planilla_Original_Fecha = objOriginal.planilla_fecha
            End If
        End With
        If VarType(objOriginal) = vbObject Then
            If objOriginal.Operacion_Moneda <> coleccion(i).Operacion_Moneda Then
                xLine = ""
            End If
        End If
        If xLine <> "" Then
            objLista.AddItem xLine
            objLista.ItemData(objLista.NewIndex) = coleccion(i).operacion_numero
        End If
    Next i
    
End Sub
'******************************************************************
'*   Carga solo Planillas que contienen moneda (Planillas Vigentes)
Public Sub CargaxMoneda(nMoneda%)

    For i = coleccion.Count To 1 Step -1
        If nMoneda <> coleccion(i).Operacion_Moneda Then
            coleccion.Remove i
        End If
    Next i
    
End Sub
'******************************************************************
'*   Cantidad de filas en Coleccion de Planillas
Public Sub Carga_Planilla(intPos&, objPlanilla As Object)
Dim xentidad%, xNumOpe&, xNumPla&, xFecPla$

    If intPos > 0 Then
        xentidad = coleccion(intPos).Entidad
        xNumOpe = coleccion(intPos).operacion_numero
        xNumPla = coleccion(intPos).planilla_numero
        xFecPla = Format(coleccion(intPos).planilla_fecha, "yyyymmdd")
        objPlanilla.Leer xentidad, xNumOpe, xNumPla, xFecPla
    Else
        objPlanilla.Limpiar
    End If
        
End Sub
'******************************************************************
'*  Llena una colección con planilla o planillas de una operacion u operaciones de fecha o todas
Public Function Leer(xentidad%, xNumOpe&, xNumPla&, xFecPla$) As Boolean
Dim objBuffer     As Object
Dim Sql$, DATOS()
    
    Leer = False
    
''''''''''''''''''''    Sql = "EXECUTE SP_LEER_PLANILLAS " & xentidad
''''''''''''''''''''    Sql = Sql & ",'" & xFecPla & "'"
''''''''''''''''''''    Sql = Sql & ", " & xNumPla
''''''''''''''''''''    Sql = Sql & ", " & xNumOpe
   
    Envia = Array()
   
    AddParam Envia, xentidad
    AddParam Envia, xFecPla
    AddParam Envia, xNumPla
    AddParam Envia, xNumOpe
   
    If Not Bac_Sql_Execute("SP_LEER_PLANILLAS", Envia) Then
        
        Exit Function
    
    End If

    Call Vaciar

    Do While Bac_SQL_Fetch(DATOS())

        Set objBuffer = New clsPlanilla

        With objBuffer
        
            .fecha = DATOS(1)
            .Entidad = Val(DATOS(2))
            
            '---- Planilla
            .planilla_fecha = DATOS(3)
            .planilla_numero = Val(DATOS(4))
            
            '---- Interesado
            .interesado_rut = Val(DATOS(5))
            .interesado_dv = Valida_Mod11(Str(.interesado_rut))
            .interesado_codigo = Val(DATOS(6))
            .interesado_nombre = DATOS(7)
            .interesado_direccion = DATOS(8)
            .interesado_ciudad = DATOS(9)
            
            '---- Operacion (MEMO)
            .operacion_numero = Val(DATOS(10))
            .operacion_fecha = DATOS(11)
            .Planilla_Original_Numero = .planilla_numero
            .Planilla_Original_Fecha = .planilla_fecha
            
            '---- Datos de Planilla
            .Tipo_Documento = Val(DATOS(12))
            '.Tipo_Documento_Glosa = Glosa_AyudaPlanilla("tbDocumento", Str(.Tipo_Documento), "")
            .Tipo_Operacion_Cambio = Val(DATOS(13))
            '.Tipo_Operacion_Cambio_Glosa = Glosa_AyudaPlanilla("tbOperacionCambio", Str(.Tipo_Operacion_Cambio), "")
            .Codigo_Comercio = DATOS(14)
            .Concepto = DATOS(15)
            '.Glosa_Comercio = Glosa_AyudaPlanilla("tbCodigosComercio", .Codigo_Comercio, .Concepto)
            .Pais_Operacion = Val(DATOS(16))
            '.Pais_Operacion_Glosa = Glosa_AyudaPlanilla("tbPais", Str(.Pais_Operacion), "")
            .Operacion_Moneda = Val(DATOS(17))
            '.Operacion_Moneda_Glosa = Glosa_AyudaPlanilla("tbMoneda", Str(.Operacion_Moneda), "")
            '.Operacion_Moneda_RRDA = bacMonedaRRDA(.Operacion_Moneda)
            
            .monto_origen = CDbl(Val(DATOS(18)))
            .Paridad = CDbl(Val(DATOS(19)))
            .monto_dolares = CDbl(Val(DATOS(20)))
            .tipo_cambio = CDbl(Val(DATOS(21)))
            .monto_pesos = CDbl(Val(DATOS(22)))
            
            .afecto_derivados = Val(DATOS(23))
            .cantidad_acuerdos = Val(DATOS(24))
            
            '---- Autorización BCCH
            .autBCCH_tipo = DATOS(25)
            '.autBCCH_tipo_Glosa = Glosa_AyudaPlanilla("tbAutorizacionBCCH", .autBCCH_tipo, "")
            .autBCCH_numero = Val(DATOS(26))
            .autBCCH_fecha = IIf(Format(DATOS(27), "yyyymmdd") <> "19000101", DATOS(27), gsbac_fecp)
            
            '---- Relación con Planillas
            .rel_institucion = Val(DATOS(28))
            '.rel_institucion_Glosa = Glosa_AyudaPlanilla("tbInstitucion", Str(.rel_institucion), "")
            .rel_fecha = IIf(Format(DATOS(29), "yyyymmdd") <> "19000101", DATOS(29), gsbac_fecp)
            .rel_numero = Val(DATOS(30))
            .rel_arbitraje = (DATOS(31) = "A")
            .rel_arbitraje_Glosa = IIf(.rel_arbitraje, "Arbitraje", "Anulación ó Reemplazo")
            
            '---- Operaciones con Financieras Internacionales (Créditos Externos)
            .ofi_numero_inscripcion = Val(DATOS(32))
            .ofi_fecha_inscripcion = IIf(Format(DATOS(33), "yyyymmdd") <> "19000101", DATOS(33), gsbac_fecp)
            .ofi_fecha_vencimiento = IIf(Format(DATOS(34), "yyyymmdd") <> "19000101", DATOS(34), gsbac_fecp)
            .ofi_nombre_financista = DATOS(35)
            .ofi_fecha_desembolso = IIf(Format(DATOS(36), "yyyymmdd") <> "19000101", DATOS(36), gsbac_fecp)
            .ofi_moneda_desembolso = Val(DATOS(37))
            '.ofi_moneda_desembolso_Glosa = Glosa_AyudaPlanilla("tbMoneda", Str(.ofi_moneda_desembolso), "")
            .ofi_monto_desembolso = CDbl(Val(DATOS(38)))
            .ofi_impuesto_adicional = CDbl(Val(DATOS(39)))
            
            '---- Exportaciones
            .exp_codigo_aduana = Val(DATOS(40))
            '.exp_codigo_aduana_Glosa = Glosa_AyudaPlanilla("tbAduana", Str(.exp_codigo_aduana), "")
            .exp_declaracion_fecha = IIf(Format(DATOS(41), "yyyymmdd") <> "19000101", DATOS(41), gsbac_fecp)
            .exp_declaracion_numero = DATOS(42)
            .exp_informe_fecha = IIf(Format(DATOS(43), "yyyymmdd") <> "19000101", DATOS(43), gsbac_fecp)
            .exp_informe_numero = Val(DATOS(44))
            .exp_fecha_vence_retorno = IIf(Format(DATOS(45), "yyyymmdd") <> "19000101", DATOS(45), gsbac_fecp)
            .exp_valor_bruto = CDbl(Val(DATOS(46)))
            .exp_comisiones = CDbl(Val(DATOS(47)))
            .exp_otros_gastos = CDbl(Val(DATOS(48)))
            .exp_valor_total = CDbl(Val(DATOS(49)))
            .exp_plazo_financia = Val(DATOS(50))
            .exp_nombre_comprador = DATOS(51)
            
            '---- Cobertura de Importaciones
            .imp_informe_fecha = IIf(Format(DATOS(52), "yyyymmdd") <> "19000101", DATOS(52), gsbac_fecp)
            .imp_informe_numero = Val(DATOS(53))
            .imp_declaracion_numero = DATOS(54)
            .imp_forma_pago = Val(DATOS(55))
            '.imp_forma_pago_Glosa = Glosa_AyudaPlanilla("tbFormaPago", Str(.imp_forma_pago), "")
            .imp_embarque_numero = Val(DATOS(56))
            .imp_embarque_fecha = IIf(Format(DATOS(57), "yyyymmdd") <> "19000101", DATOS(57), gsbac_fecp)
            .imp_fecha_vence = IIf(Format(DATOS(58), "yyyymmdd") <> "19000101", DATOS(58), gsbac_fecp)
            .imp_valor_mercaderia = CDbl(Val(DATOS(59)))
            .imp_gastos_fob = CDbl(Val(DATOS(60)))
            .imp_valor_fob = CDbl(Val(DATOS(61)))
            .imp_flete = CDbl(Val(DATOS(62)))
            .imp_seguro = CDbl(Val(DATOS(63)))
            .imp_valor_cif = CDbl(Val(DATOS(64)))
            .imp_intereses = CDbl(Val(DATOS(65)))
            .imp_gastos_bancarios = CDbl(Val(DATOS(66)))
            
            '---- Derivados (Forwards)
            .der_numero_contrato = Val(DATOS(67))
            .der_fecha_inicio = IIf(Format(DATOS(68), "yyyymmdd") <> "19000101", DATOS(68), gsbac_fecp)
            .der_fecha_vence = IIf(Format(DATOS(69), "yyyymmdd") <> "19000101", DATOS(69), gsbac_fecp)
            .der_instrumento = Val(DATOS(70))
            '.der_instrumento_Glosa = Glosa_AyudaPlanilla("tbDerivado", .der_instrumento, "")
            .der_precio_contrato = CDbl(Val(DATOS(71)))
            .der_area_contable = Val(DATOS(72))
            '.der_area_contable_Glosa = Glosa_AyudaPlanilla("tbAreaContable", .der_area_contable, "")
            
            '---- Acuerdos
            .acuerdo_codigo_1 = DATOS(73)
            .acuerdo_numero_1 = DATOS(74)
            .acuerdo_codigo_2 = DATOS(75)
            .acuerdo_numero_2 = DATOS(76)
            .acuerdo_codigo_3 = DATOS(77)
            .acuerdo_numero_3 = DATOS(78)
            .acuerdo_codigo_4 = DATOS(79)
            .acuerdo_numero_4 = DATOS(80)
            .acuerdo_codigo_5 = DATOS(81)
            .acuerdo_numero_5 = DATOS(82)
            
            '---- Observados
            .obs_1 = DATOS(83)
            .obs_2 = DATOS(84)
            .obs_3 = DATOS(85)
            
            .IsEstadistica = False
            
      End With

      coleccion.Add objBuffer

      Set objBuffer = Nothing

   Loop
   
   Leer = True

End Function
'******************************************************************
'*  Verifica la existencia de una Operación ...
Public Function Leer_Operacion(xentidad As Integer, xNumOpe As Long, objPla As Object) As Boolean
    
    Leer_Operacion = False
    
    '---- Limpiar Planilla Activa
    objPla.Limpiar
    
    '---- Verifica que exista Operacion
    If Not Existe_Operacion(xentidad, xNumOpe) Then
        MsgBox "Operación Nro." & Str(xNumOpe) & " No existe en archivos", vbCritical, TITSISTEMA
        Exit Function
    End If
    
    '---- Leer Operacion
    '''Sql = "EXECUTE SP_OPERACIONES_DIA " & xentidad & ",' ',' ', 0," & xNumOpe
    
    Envia = Array()
    
    AddParam Envia, xentidad
    AddParam Envia, ""
    AddParam Envia, ""
    AddParam Envia, 0
    AddParam Envia, xNumOpe
    
    
    If Not Bac_Sql_Execute("SP_OPERACIONES_DIA", Envia) Then
        
        MsgBox "Operación Nro." & Str(xNumOpe) & " No puede ser cargada" & vbCrLf & vbCrLf & "Posiblemente No pertenece al movimiento diario", vbCritical, TITSISTEMA
        Exit Function
    
    End If
    
    If Bac_SQL_Fetch(DATOS()) Then
        
        If DATOS(8) <> "A" Then
            
            objPla.Entidad = Val(DATOS(1))
            
            objPla.operacion_numero = Val(DATOS(3))
            objPla.operacion_fecha = DATOS(27)
            objPla.Operacion_Moneda = Val(DATOS(41))
            
            objPla.interesado_rut = Val(DATOS(4))
            objPla.interesado_dv = DATOS(5)
            objPla.interesado_codigo = Val(DATOS(6))
            objPla.interesado_nombre = DATOS(7)
            
            objPla.monto_origen = CDbl(Val(DATOS(11)))
            objPla.Paridad = CDbl(Val(DATOS(14)))
            objPla.monto_dolares = CDbl(Val(DATOS(18)))
            objPla.tipo_cambio = CDbl(Val(DATOS(12)))
            objPla.monto_pesos = CDbl(Val(DATOS(19)))
            
            objPla.der_instrumento = Val(DATOS(37))
            objPla.der_numero_contrato = Val(DATOS(38))
            objPla.der_fecha_inicio = DATOS(39)
            
            objPla.Tipo_Operacion_Cambio = DATOS(33)
            
            Leer_Operacion = True
        
        Else
            
            MsgBox "Operación Nro." & Str(xNumOpe) & " No puede ser cargada" & vbCrLf & "debido a que se encuentra Eliminada", vbCritical, TITSISTEMA
        
        End If
    
    End If

End Function
'************************************************************
'*    Suma los montos originales de las planillas asociadas a la
'*    operación según fecha de emisión para la xEntidad indicada
Public Function Suma_Planillas(xentidad$, xNumOpe&, xNumPla&, xFecha$, xMoneda%) As Double
Dim Mouse%

    Mouse = Screen.MousePointer
    Screen.MousePointer = 11
    
    Suma_Planillas = 0

    For i = 1 To coleccion.Count
    
        If coleccion(i).Entidad <> xentidad Then
        '----- Entidad no corresponde
        
        ElseIf Format(coleccion(i).planilla_fecha, "yyyymmdd") <> xFecha Then
        '----- Planilla no corresponde al dia solicitado
        
        ElseIf coleccion(i).operacion_numero <> xNumOpe Then
        '----- Operacion no correspode a la solicitada
        
        ElseIf coleccion(i).planilla_numero = xNumPla Or coleccion(i).Planilla_Original_Numero = xNumPla Or coleccion(i).rel_numero = xNumPla Or xNumPla = 0 Then
            If coleccion(i).Operacion_Moneda = xMoneda Then
                If coleccion(i).Tipo_Documento < 3 Then
                    Suma_Planillas = Suma_Planillas + coleccion(i).monto_origen
                Else
                    Suma_Planillas = Suma_Planillas - coleccion(i).monto_origen
                End If
            End If
            
        End If
        
    Next i
    
    Screen.MousePointer = Mouse

End Function
'******************************************************************
'*   Vacia la Coleccion de Planillas
Public Sub Vaciar()
Dim Filas&, Max&

   Max& = coleccion.Count
   For Filas& = 1 To Max&
      coleccion.Remove 1
   Next Filas&

End Sub
