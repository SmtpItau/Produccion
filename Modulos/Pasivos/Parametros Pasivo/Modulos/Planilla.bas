Attribute VB_Name = "modPlanillas"
Option Explicit

Private xLine As String
Private xStr As String
Private xVal As Double
Private xFecha As String

Private Datos()

'******************************************************************
'*  Retorna Glosas de Tabla_AyudaPlanillas
Public Function Glosa_AyudaPlanilla(xTabla$, xCodigo_Numerico$, xCodigo_Caracter$) As String
Dim Datos()          '--- Local para que no afecte otras capturas
Dim Codigo_Tabla%
    Glosa_AyudaPlanilla = ""

    If xCodigo_Numerico = "" And xCodigo_Caracter = "" Then
        Exit Function
    End If

    xTabla = UCase(Trim(xTabla))
    If Right(xTabla, 1) = "S" Then
        xTabla = Left(xTabla, Len(xTabla) - 1)
    End If
    
    Select Case xTabla
    '-------------------------------------------- tbAyudaPlanilla
    Case "TBDOCUMENTO"
        Codigo_Tabla = 1
        
    Case "TBAUTORIZACIONBCCH", "TBAUTBCHH"
        Codigo_Tabla = 2
        
    Case "TBAFECTODERIVADO"
        Codigo_Tabla = 3
    
    Case "PAGOEXTERIOR"
        Codigo_Tabla = 4
    
    Case "TBINSTRUMENTODERIVADO", "TBINSTRUMENTOSDERIVADO", "TBDERIVADO"
        Codigo_Tabla = 5
    
    Case "TBAREACONTABLE"
        Codigo_Tabla = 6
    
    Case "TBBASETASA", "TBBASESTASA"
        Codigo_Tabla = 7
    
    Case "TBCONCEPTOCAPITAL"
        Codigo_Tabla = 8
    
    Case "TBINTERESE"
        Codigo_Tabla = 9
    
    Case "TBPLANILLASCOMPLEMENTARIA", "TBPLANILLACOMPLEMENTARIA"
        Codigo_Tabla = 10
    
  '  Case "TBPAISE", "TBPAIS", "TBPAI"     '--- CAMBIO
  '      Codigo_Tabla = 11
  '      Codigo_Tabla = 0
  '      Sql = "SELECT CONVERT(NUMERIC(8),codigo_caracter),glosa,glosa,codigo_numerico "
  '      Sql = Sql & "  FROM tbPaises"
  '      Sql = Sql & " WHERE codigo_numerico = " & xCodigo_Numerico
    
    Case "TBADUANA"
        Codigo_Tabla = 12
    
    Case "TBPLAZA"
        Codigo_Tabla = 13
    
    Case "TBOPERACIONESCAMBIO", "TBOPERACIONCAMBIO", "TBCODIGOSOMA"
        Codigo_Tabla = 14
    
    Case "TBTIPOSMERCADO", "TBTIPOMERCADO"
        Codigo_Tabla = 15
    
    '-------------------------------------------- Otras Tablas
    Case "TBCIUDAD", "CIUDAD"
        Codigo_Tabla = 0
        Sql = "SELECT codigo_numerico,codigo_caracter,glosa "
        Sql = Sql & "  FROM ciudad_Comuna"
        Sql = Sql & " WHERE codigo_numerico = " & xCodigo_Numerico
    
    Case "TBCODIGOSCOMERCIO"
        Codigo_Tabla = 0
        Sql = "SELECT comercio,concepto,glosa "
        Sql = Sql & "  FROM Codigo_Comercio"
        Sql = Sql & " WHERE comercio = '" & xCodigo_Numerico & "'"
        Sql = Sql & "   AND concepto = '" & xCodigo_Caracter & "'"
    
    Case "TBMONEDA"
        Codigo_Tabla = 0
        Sql = "SELECT mncodmon,mnsimbol,mnglosa"
        Sql = Sql & "  FROM moneda"
        Sql = Sql & " WHERE mncodbanco = " & xCodigo_Numerico
    
    Case "TBINSTITUCIONE", "TBINSTITUCION"
        Codigo_Tabla = 0
        Sql = "SELECT clcodban,clgeneric,clnombre"
        Sql = Sql & "  FROM Cliente"
        Sql = Sql & " WHERE clcodban = " & xCodigo_Numerico
    
    Case "TBFPAGO", "TBFORMAPAGO", "TBFORMASPAGO"
        Codigo_Tabla = 0
        Sql = "SELECT codigo,glosa2,glosa"
        Sql = Sql & "  FROM Forma_de_Pago"
        Sql = Sql & " WHERE codigo = " & xCodigo_Numerico
    
    Case Else
        Glosa_AyudaPlanilla = "Tabla no definida"
        Exit Function
    
    End Select
    
    Glosa_AyudaPlanilla = "Tabla no accesible"
    
    If Codigo_Tabla > 0 Then
        Sql = "SELECT codigo_numerico,codigo_caracter,glosa"
        Sql = Sql & "  FROM Codigo_Planilla_Automatica"
        Sql = Sql & " WHERE codigo_tabla = " & Codigo_Tabla
        If Val(xCodigo_Numerico) >= 0 Then
            Sql = Sql & " AND codigo_numerico = " & xCodigo_Numerico
        Else
            Sql = Sql & " AND codigo_caracter = '" & xCodigo_Caracter & "'"
        End If
    Else
        
    End If
    
    If BAC_SQL_EXECUTE(Sql) Then
        If BAC_SQL_FETCH(Datos()) Then
            Glosa_AyudaPlanilla = Datos(3)
        Else
            Glosa_AyudaPlanilla = "Código NO Existe"
        End If
    End If

End Function

'******************************************************************
'*  Verifica la existencia de una Operación ...
Public Function Existe_Operacion(xentidad As Integer, xNumOpe As Long) As Boolean
    
    Existe_Operacion = False
    
'''''''''''    Sql = "sp_planilla_verifica_operacion " & xNumOpe & "," & xentidad

    Envia = Array()

    AddParam Envia, CDbl(xNumOpe)
    AddParam Envia, CDbl(xentidad)

    If BAC_SQL_EXECUTE("sp_planilla_verifica_operacion", Envia) Then
        
        MsgBox "Validación no fue posible realizar", vbInformation + vbOKOnly
        Exit Function
    
    End If
    
    Do While BAC_SQL_FETCH(Datos())
    
        Existe_Operacion = (InStr("MEMOH", Datos(1)) > 0)
    
    Loop

End Function

'**********************************************************************
'*    Carga objetos ComboBox o ListBox con tabla segun strSP
Sub Carga_Cliente(rutcli As Long, codcli As Long, objPlanilla As Object)
    
    Sql = "SELECT clrut,cldv,clcodigo,clnombre,cldirecc,"
    Sql = Sql & "b.glosa,b.codigo_numerico, "
    Sql = Sql & "c.glosa,c.codigo_numerico  "
    Sql = Sql & "FROM Cliente, Ciudad_Comuna b, tbPaises c "
    Sql = Sql & "WHERE clrut = " & rutcli & " AND clcodigo = " & codcli
    Sql = Sql & " AND clciudad *= b.codigo_numerico"
    Sql = Sql & " AND clpais   *= CONVERT(NUMERIC(8),c.codigo_caracter)"

    If BAC_SQL_EXECUTE(Sql) Then
        If BAC_SQL_FETCH(Datos()) Then
            objPlanilla.interesado_rut = Datos(1)
            objPlanilla.interesado_dv = Datos(2)
            objPlanilla.interesado_codigo = Datos(3)
            objPlanilla.interesado_nombre = Datos(4)
            objPlanilla.interesado_direccion = Datos(5)
            objPlanilla.interesado_ciudad = Datos(6)
            'objPlanilla.Pais_Operacion = Datos(9)
            'objPlanilla.Pais_Operacion_Glosa = Glosa_AyudaPlanilla("tbPais", Str(objPlanilla.Pais_Operacion), "")
        End If
    End If

End Sub
'**********************************************************************
'*    Carga objetos ComboBox o ListBox con tabla segun strSP
Sub Carga_Listas(strSP As String, obj As Object)
Dim Mouse%
Dim aStr()
ReDim aStr(2)

    aStr(1) = "XX"
    aStr(2) = 100

    Mouse = Screen.MousePointer
    Screen.MousePointer = 11
    
Select Case UCase(strSP)
    Case "TIPODOCUMENTO"
            Sql = Sql & 1
            aStr(1) = "0"
    
    Case "TIPOAUTORIZACIONBCCH"
            Sql = Sql & 2
    
    Case "AFECTODERIVADO"
            Sql = Sql & 3
    
    Case "PAGOEXTERIOR"
            Sql = Sql & 4
            aStr(1) = "XX"
    
    Case "TIPODERIVADO"
            Sql = Sql & 5
            aStr(1) = "00"

    Case "AREACONTABLE"
            Sql = Sql & 6
            aStr(1) = "00"

    Case "BASETASA"
            Sql = Sql & 7
            aStr(1) = "0"

    Case "CONCEPTOCAPITAL"
            Sql = Sql & 8
            aStr(1) = "XXX"

    Case "TIPOINTERES"
            Sql = Sql & 9
            
    Case "TIPOPLANILLAS"
            Sql = Sql & 10
            aStr(1) = ""
            
    Case "PAISES"
    ''Aqui se hizo un cambio
            'Sql = Sql & 11
            '---- cuando Paises de Trader esten Ok , habilitar
            'Sql = "SELECT 0,codigo_numerico,codigo_caracter,glosa,Memo "
            
            Sql = "SELECT 0,codigo_numerico,codigo_caracter,glosa "
            Sql = Sql & "FROM tbPaises "
            Sql = Sql & "ORDER BY codigo_caracter"
            aStr(1) = "000"
                
    Case "ADUANAS"
            
            Sql = Sql & 12
            aStr(1) = "000"
                
    Case "PLAZAS"
            Sql = Sql & 13
            aStr(1) = "000"
                
    Case "TIPOOPERACION", "CODIGOOMA", "CODIGOSOMA"
            Sql = Sql & 14
            aStr(1) = "000"
            
    Case "MERCADOS"
            Sql = Sql & 15
            aStr(1) = "XXXX"
                
    Case "RESPONSABLES"
            Sql = Sql & 16
            aStr(1) = ""
                
    Case "FORMASPAGO"
            
            Sql = "SELECT 0,codigo,glosa2,glosa "
            Sql = Sql & "FROM Formas_de_Pago "
            Sql = Sql & "ORDER BY glosa"
            aStr(1) = "000"
            
    Case "MONEDAS"
            
            Sql = "SELECT 0,mncodsuper,mnsimbol,mnglosa "
            Sql = Sql & "FROM Moneda "
            Sql = Sql & "WHERE mncodsuper<141 ORDER BY mncodmon"
            aStr(1) = "000"
                
    Case "PRODUCTOS"
            
            Sql = "SELECT 0,codigo,producto,glosa "
            Sql = Sql & "FROM mepp"
            aStr(1) = "00"
                
    Case "COMERCIOCONCEPTO"
            
            Sql = "SELECT comercio,concepto,glosa "
            Sql = Sql & "FROM Codigo_Comercio"
                
    Case "INSTITUCIONES"
            
            Sql = "SELECT 0,ISNULL(clcodban,0),clgeneric,clnombre "
            Sql = Sql & "FROM tbInstitucionesFinancieras"
            aStr(1) = "000"
                
    Case Else                '----- Sin tabla de ayuda
            
            If InStr(UCase(strSP), "OPERACIONESXDOCUMENTO") > 0 Then
                Sql = "SELECT 15,* FROM CODIGO_OMA "
                Sql = Sql & "WHERE RTRIM(LTRIM(SUBSTRING(codigo_caracter,1,2))) = '" & Left(strSP, 1) & "'"
                aStr(1) = "000"
            Else
                Sql = "No"
                Screen.MousePointer = Mouse
                Exit Sub
            End If
            
End Select
    
'    If Val(Right(Sql, 2)) > 0 Then
'        Sql = Sql & " and codigo_numerico >= 0 and codigo_caracter <> '0'"
'        Sql = Sql & " ORDER BY codigo_" & IIf(Left(aStr(1), 1) = "0", "numerico", "caracter")
'    End If
    
    Sql = "Sp_Tbcodigo_Oma"
    
    If Not BAC_SQL_EXECUTE(Sql) Then
        Sql = "No"
        'MsgBox "Carga de Ayuda no es posible ... reintente con < Refresh Help >", vbCritical + vbOKOnly, "BacCambio Planilla"
        Screen.MousePointer = Mouse
        Exit Sub
    End If
    
    '------ Cargando ayuda
    obj.Clear
    Do While BAC_SQL_FETCH(Datos())
        If strSP = "COMERCIOCONCEPTO" Then
            xStr = Datos(1) & " / " & Datos(2)
            xLine = xStr & "" & Datos(3)
            Datos(2) = 0
        Else
            If aStr(1) = "" Then
                xStr = ""
            ElseIf Left(aStr(1), 1) = "0" Then '------ Tabla
                xStr = Format(Datos(1), aStr(1))
            Else
                xStr = Datos(3)
                xStr = Left(Format(Datos(3), aStr(1)), Len(aStr(1)))
            End If
            xLine = xStr & IIf(aStr(1) = "", "", " - ") & Trim(Datos(3))
            xLine = xLine & Space(aStr(2) - Len(xLine))
            xLine = xLine & Datos(3)
        End If
        obj.AddItem xLine
        obj.ItemData(obj.NewIndex) = Val(Datos(1))
    Loop
    
    If obj.ListCount - 1 < 0 Then
        obj.AddItem "(Sin Datos)"
        obj.ItemData(obj.NewIndex) = -1
    Else
        obj.ListIndex = 0
    End If
    
    Screen.MousePointer = Mouse
    
End Sub

'Public Sub Imprimir_Planilla(xentidad%, xFecPla$, xNumPla&)
'
'
'    'Call ClearStoredProcParam
'
'    With BacCambio
'        .Crystal.WindowTitle = "Planilla Numero " & xNumPla & " del " & Right(xFecPla, 2) & "/" & Mid(xFecPla, 5, 2) & "/" & Left(xFecPla, 2)
'        .Crystal.ReportFileName = gsRPT_Path + "Planilla.RPT"
'        .Crystal.StoredProcParam(0) = xentidad
'        .Crystal.StoredProcParam(1) = xFecPla
'        .Crystal.StoredProcParam(2) = xNumPla
'        .Crystal.Destination = crptToWindow
'        .Crystal.Connect = swConeccion
'        .Crystal.Action = 1
'    End With
'
' End Sub

'**********************************************************************
'*  retorna DV segun modulo 11 para codigo string (Declaracion de Importaciones)

Public Function Valida_Mod11(Rut As String) As String

Dim I%, D%, Divi&, Suma&, Digito$, Multi#

    Valida_Mod11 = "X"
    
    If Trim$(Rut) = "" Then Exit Function
    
    For I = 1 To Len(Rut)
        Digito = Digito & "0"
    Next
    
    D = 2
    Rut = Format(Rut, Digito)
    For I = Len(Digito) To 1 Step -1
        Multi = Val(Mid$(Rut, I, 1)) * D
        Suma = Suma + Multi
        D = D + 1
        If D = 8 Then
            D = 2
        End If
    Next I
    
    Divi = (Suma \ 11)
    Multi = Divi * 11
    Digito = Trim$(Str$(11 - (Suma - Multi)))
    
    If Digito = "10" Then Digito = "K"
    If Digito = "11" Then Digito = "0"
      
    Valida_Mod11 = Trim$(UCase$(Digito))

End Function
'**********************************************************************
'*    Busca Codigo de Comercio segun concepto
Public Function Existe_Comercio(strComercio As String, strConcepto As String) As String
Dim Datos()

    Existe_Comercio = "No se encontro ..."
    strComercio = Trim(strComercio)
    strConcepto = Trim(strConcepto)
    
    strComercio = Format(Val(Left(strComercio, Len(strComercio) - 1)), "00000") & Right(strComercio, 1)
    strConcepto = Format(Val(Left(strConcepto, Len(strConcepto) - 1)), "00") & Right(strConcepto, 1)
    
''''''''''''''    Sql = "sp_leer_codigos_comercio '" & Trim(strComercio) & "', '" & Trim(strConcepto) & "'"
    
    Envia = Array()
    
    AddParam Envia, Trim(strComercio)
    AddParam Envia, Trim(strConcepto)
    
    If BAC_SQL_EXECUTE("sp_leer_codigos_comercio", Envia) Then
        
        Sql = "No"
        MsgBox "No se puede validar Codigo de Comercio y Concepto", vbCritical
        Exit Function
    
    End If
    
    If BAC_SQL_FETCH(Datos()) Then
        
        Existe_Comercio = Trim(Datos(4))
    
    End If

End Function
'**********************************************************************
'*    Busca Codigo de Comercio y concepto relacionados
Public Function Datos_Automaticos(strTipOpe As String, strTipCli As String, strTipMer As String) As String
Dim Datos()

    Datos_Automaticos = "000000/000"
    
'''''''''''''''' Sql = "sp_buscar_codigos_automaticos '" & strTipOpe & strTipCli & strTipMer & "'"
    
    Envia = Array()
    
    AddParam Envia, CDbl(strTipOpe)
    AddParam Envia, CDbl(strTipCli)
    AddParam Envia, CDbl(strTipMer)
    
Retry_Load:
    
    If Not BAC_SQL_EXECUTE("sp_buscar_codigos_automaticos", Envia) Then
        
        Sql = "No"
        
        If MsgBox("No se puede capturar Codigo de Comercio y Concepto", vbCritical + vbRetryCancel) = vbRetry Then
            
            GoTo Retry_Load
        
        End If
        
        Exit Function
    
    End If
    
    If BAC_SQL_FETCH(Datos()) Then
        
        '---- Tipo de Documento
        Datos_Automaticos = BacPad("" & Datos(1), 1)
        '---- Tipo Operacion de Cambio
        Datos_Automaticos = Datos_Automaticos & Datos(2)
        '---- Código de Comercio
        Datos_Automaticos = Datos_Automaticos & BacStrTran(BacPad("" & Datos(1), 6, "L"), Space(1), "0")
        '---- Concepto
        Datos_Automaticos = Datos_Automaticos & "/" & BacStrTran(BacPad("" & Datos(2), 3, "L"), Space(1), "0")
    
    End If

End Function
'**********************************************************************
'*    busca codigos en listas de ComboBox o ListBox
Public Function Busca_Chr_Lista(strChr As String, objLista As Object, intPos As Integer) As Integer
Dim I%

    For I = 0 To objLista.ListCount - 1
        If Mid(objLista.List(I), IIf(1 > intPos, 1, intPos), Len(strChr)) = strChr Then
            Busca_Chr_Lista = I
            Exit For
        End If
    Next I

End Function
'**********************************************************************
'*    retorna de Fecha string "dd/mm/yyyy" formato "ddd dd de mmm de yyyy"
Public Function Fecha_DDMA(strFecha As String) As String
Dim dia$, Mes$
    dia = Format(strFecha, "ddd")
    dia = UCase(Left(dia, 1)) & Mid(dia, 2)
    Mes = Format(strFecha, "mmm")
    Mes = UCase(Left(Mes, 1)) & Mid(Mes, 2)
    Fecha_DDMA = dia & " " & Format(strFecha, "dd")
    Fecha_DDMA = Fecha_DDMA & " de " & Mes
    Fecha_DDMA = Fecha_DDMA & " de " & Format(strFecha, "yyyy")
End Function

Public Function Corta_Texto(strText As String, intLen As Integer, strChr As String) As String
Dim I%
    Corta_Texto = strText
    If Len(strText) <= intLen And strChr <> "" Then Exit Function
    
    Corta_Texto = Left(strText, IIf(Len(strText) < intLen + 1, Len(strText), intLen + 1))
    
    If strChr <> "" Then
        For I = Len(Corta_Texto) To 1 Step -1
            If Mid(Corta_Texto, I, 1) = strChr Then
                Corta_Texto = Left(Corta_Texto, I)
                Exit For
            End If
        Next I
    End If
    
    If Len(Corta_Texto) > intLen Then
        strChr = Space(1) & Chr(10) & Chr(13) & ",.;"
        For I = intLen To 1 Step -1
            If InStr(strChr, Mid(Corta_Texto, intLen, 1)) > 0 Then
                Corta_Texto = Left(Corta_Texto, I)
                Exit For
            End If
        Next I
    End If
    
    If Len(Corta_Texto) > intLen Then
        Corta_Texto = Left(Corta_Texto, intLen)
    End If

End Function

Public Function Interfaz_Posicion_BCCH(tipo$, xentidad%, fecha$, Archivo$) As Boolean
Dim I&, Total&, Record&, largo&
Dim Planilla As Object
Dim Planillas As Object
Dim Detalle As Object
Dim Intereses As Object
Dim Cantidad(1 To 8)
Dim CorPla%
Dim tipdoc$
Dim TipPlanilla$

    Interfaz_Posicion_BCCH = False
   
    '---- Tipo de Interfaz & Planillas a Informar
    tipo = UCase(Trim(tipo$))
    Select Case tipo$
    Case "POS"
        '-- Posicion de Cambio (Comercio Visible e Invisible, Coberturas de Importación & Exportaciones)
        tipdoc = "1234"
    Case "PEE"
        '-- Exportaciones Estadisticas
        tipdoc = "67"
    Case "PEI"
        '-- Coberturas de Importación Estadisticas
        tipdoc = "245"
    Case Else
        MsgBox "Interfaz para informar al BCCH no definida para Tipo : " & tipo, vbCritical
        Exit Function
    End Select
    
    '---- Definicion de Variables
    Set Planilla = New clsPlanilla
    Set Planillas = New clsPlanillas

    'Set Detalle = New clsDetalleIntereses
    'Set Intereses = New clsTotalDetalleIntereses
        
    largo = 250
    
    For I = LBound(Cantidad) To UBound(Cantidad)
        Cantidad(I) = 0
    Next I
    
    '---- Carga planillas
    Planillas.Leer xentidad, 0, 0, fecha
    Intereses.Leer 0, fecha, 0
   
    On Error GoTo HError
    
    If Dir(Archivo) <> "" Then
        If MsgBox("Ya existe archivo Interfaz de Posición" & Chr(13) & Archivo & Chr(13) & Chr(13) & "¿ Sobreescribir ?", vbQuestion + vbYesNo) <> vbYes Then
            Exit Function
        End If
        Kill Archivo
    End If
    
    Open Archivo For Binary Access Write As #1
    Record = 0
    
    '-- Encabezado
    xLine = "00"
    xLine = xLine & fecha
    xLine = xLine & Format("", "000") '-- IMPORTANTE este codigo es el segun BCCH
    'xLine = xLine & gsBAC_Clien                     '-- Nombre del Cliente
    Select Case UCase(Trim(tipo$))
    Case "POS"
        xLine = xLine & "POSICION DE CAMBIOS"
    Case "PEE"
        xLine = xLine & "PEE ESTADISTICAS EXPORTACION"
    Case "PEI"
        xLine = xLine & "PEI ESTADISTICAS IMPORTACION"
    Case Else
        xLine = xLine & gsBAC_Clien                     '-- No Definido
    End Select
    
    xLine = BacPad(xLine, largo) & Chr(13) & Chr(10)
    Record = Record + 1
    Put #1, , xLine
    
    '-- Detalle
    For I = 1 To Planillas.Cantidad
    
        Planillas.Carga_Planilla I, Planilla
        
        With Planilla
        
            If Len(Trim(.exp_informe_numero)) > 0 Then
                TipPlanilla = "EXP"    '-- Exportacion (Tipo de Documento : 1-3 + Estadisticas : 6-7)
            ElseIf .imp_informe_numero > 0 Then
                TipPlanilla = "IMP"    '-- Cobertura de Importacion (Tipo de Documento : 2-4-5)
            Else
                TipPlanilla = "COM"    '-- Comercio Visible o Invisible (Tipo de Documento : 1-2-3-4)
            End If
        
            If InStr(tipdoc, Trim(Str(.Tipo_Documento))) = 0 Then
            '---- Tipo de Documento No se informa
            
            ElseIf .planilla_numero > 0 And Format(.planilla_fecha, "yyyymmdd") = fecha Then
                xStr = ""
                xLine = "10"
                xLine = xLine & Format(.planilla_numero, "000000")
                xLine = xLine & BacPad(Format(.interesado_rut, "########0") & Valida_Mod11(.interesado_rut), 10)
                xLine = xLine & BacPad(Trim(.interesado_nombre), 30)
                xLine = xLine & BacPad(Trim(.interesado_direccion), 30)
                xLine = xLine & BacPad(Trim(.interesado_ciudad), 20)
                xLine = xLine & Format(.planilla_fecha, "yyyymmdd")
                xLine = xLine & Format(.Tipo_Documento, "0")
                xLine = xLine & Format(.Tipo_Operacion_Cambio, "000")
                '-- Exportación Estadistica no informa Codigos de Comercio ni Concepto
                If tipo = "PEE" Then
                    xLine = xLine & Space(6 + 3)
                Else
                    xLine = xLine & BacPad(Trim(.Codigo_Comercio), 6)
                    xLine = xLine & BacPad(Trim(.Concepto), 3)
                End If
                '-- Exportación no informa País
                xVal = .Pais_Operacion
                '-- No es exigible para letra a) anexo 2 - ver circular de bancos 343
                If tipo = "POS" And TipPlanilla = "EXP" Then
                    xVal = 0
                End If
                xLine = xLine & Format(xVal, "000")
                xLine = xLine & Format(.Operacion_Moneda, "000")
                xLine = xLine & BacStrTran(Format(.monto_origen, "000000000000.00"), ".", "")
                '-- Planillas Estadisticas no informan Paridad
                xVal = .Paridad
                If Not tipo = "POS" Then
                    xVal = 0
                End If
                xLine = xLine & BacStrTran(Format(xVal, "000000.0000"), ".", "")
                xLine = xLine & BacStrTran(Format(.monto_dolares, "000000000000.00"), ".", "")
                '-- Planillas Estadisticas ni Anulación de Exportacion informan T/C
                xVal = .tipo_cambio
                If Not tipo = "POS" Or (TipPlanilla = "EXP" And .Tipo_Documento = 4) Then
                    xVal = 0
                End If
                xLine = xLine & BacStrTran(Format(xVal, "000000.00"), ".", "")
                '-- informan Monto en Pesos solo Comercio Invisible
                xVal = .monto_pesos
                If Not tipo = "POS" Or Not TipPlanilla = "COM" Then
                    xVal = 0
                End If
                xLine = xLine & BacStrTran(Format(xVal, "00000000000000.00"), ".", "")
                '-- Derivados & Acuerdos
                If Not tipo = "POS" Then
                    xLine = xLine & "00"
                Else
                    xLine = xLine & Format(.afecto_derivados, "0")
                    xLine = xLine & Format(.cantidad_acuerdos, "0")
                End If
                
                '---- Autorización del BCCH
                If .autBCCH_numero > 0 And tipo = "POS" Then
                    xStr = BacPad(Trim(.autBCCH_tipo), 2)
                    xStr = xStr & Format(.autBCCH_numero, "000000")
                    xStr = xStr & Format(.autBCCH_fecha, "yyyymmdd")
                Else
                    xStr = Space(2) & String(6 + 8, "0")
                End If
                xLine = xLine & xStr
                
                '---- Relación de Planillas por Anulación o Arbitraje
                '-- para Estadisticas solo informan Anulaciones, reeemplazos o Ex-Financiamientos de Exportacion
                If .rel_numero > 0 And (tipo = "POS" Or InStr("2457", CStr(.Tipo_Documento)) > 0) Then
                    xStr = Format(.rel_institucion, "000")
                    xStr = xStr & Format(.rel_numero, "000000")
                    xStr = xStr & Format(.rel_fecha, "yyyymmdd")
                Else
                    xStr = String(3 + 6 + 8, "0")
                End If
                xLine = xLine & xStr
                
                xLine = BacPad(xLine, largo) & Chr(13) & Chr(10)
                Record = Record + 1
                Put #1, , xLine
                Cantidad(Val(Left(xLine, 1))) = Cantidad(Val(Left(xLine, 1))) + 1
                
                '---- Operacion Financiera Internacional - Crédito Externo
                If .ofi_numero_inscripcion > 0 Then
                    xLine = "20"
                    xLine = xLine & Format(.ofi_numero_inscripcion, "00000000")
                    xLine = xLine & Format(.ofi_fecha_inscripcion, "yyyymmdd")
                    xLine = xLine & Format(.ofi_fecha_vencimiento, "yyyymmdd")
                    xLine = xLine & BacPad(.ofi_nombre_financista, 30)
                    xLine = xLine & Format(.ofi_fecha_desembolso, "yyyymmdd")
                    xLine = xLine & Format(.ofi_moneda_desembolso, "000")
                    xLine = xLine & BacStrTran(Format(.ofi_monto_desembolso, "000000000000.00"), ".", "")
                    xLine = xLine & BacStrTran(Format(.ofi_impuesto_adicional, "0000000000.00"), ".", "")
                    
                    xLine = BacPad(xLine, largo) & Chr(13) & Chr(10)
                    Record = Record + 1
                    Put #1, , xLine
                    Cantidad(Val(Left(xLine, 1))) = Cantidad(Val(Left(xLine, 1))) + 1
                End If
                
                '---- Exportaciones
                If Len(Trim(.exp_informe_numero)) > 0 Then
                    xLine = "30"
                    xLine = xLine & Format(.exp_codigo_aduana, "000")
                    xLine = xLine & Format(.exp_declaracion_fecha, "yyyymmdd")
                    xLine = xLine & BacPad(.exp_declaracion_numero, 7)
                    '-- Estadisticas ni Anulaciones informan datos de informe
                    If .Tipo_Documento = 4 Then
                        xLine = xLine & String(8, "0") & Space(7)
                    Else
                        xLine = xLine & Format(.exp_informe_fecha, "yyyymmdd")
                        xLine = xLine & BacPad(.exp_informe_numero, 7)
                    End If
                    xLine = xLine & Format(.exp_fecha_vence_retorno, "yyyymmdd")
                    '-- Anulaciones no se informan
                    If .Tipo_Documento = 4 Then
                        xLine = xLine & String(14 + 12 + 12 + 4, "0")
                    Else
                        xLine = xLine & BacStrTran(Format(.exp_valor_bruto, "000000000000.00"), ".", "")
                        xLine = xLine & BacStrTran(Format(.exp_comisiones, "0000000000.00"), ".", "")
                        xLine = xLine & BacStrTran(Format(.exp_otros_gastos, "0000000000.00"), ".", "")
                        xLine = xLine & Format(.exp_plazo_financia, "0000")
                    End If
                    '-- solo Anticipo Comprador
                    xStr = ""
                    If InStr("401,501,502", Format(.Tipo_Operacion_Cambio, "000")) > 0 Then
                        xStr = .exp_nombre_comprador
                    End If
                    If .Tipo_Documento = 4 Then
                        xStr = ""
                    End If
                    xLine = xLine & BacPad(xStr, 30)
                    
                    xLine = BacPad(xLine, largo) & Chr(13) & Chr(10)
                    Record = Record + 1
                    Put #1, , xLine
                    Cantidad(Val(Left(xLine, 1))) = Cantidad(Val(Left(xLine, 1))) + 1
                End If
                
                '---- Importaciones
                If .imp_informe_numero > 0 Then
                    xLine = "40"
                    xLine = xLine & Format(.imp_informe_fecha, "yyyymmdd")
                    xLine = xLine & Format(.imp_informe_numero, "000000")
                    xLine = xLine & BacStrTran(BacPad(Trim(.imp_declaracion_numero), 18, "R"), " ", "0")
                    xLine = xLine & Format(.imp_forma_pago, "00")
                    xLine = xLine & Format(.imp_embarque_numero, "00000000")
                    xLine = xLine & Format(.imp_embarque_fecha, "yyyymmdd")
                    xLine = xLine & Format(.imp_fecha_vence, "yyyymmdd")
                    xLine = xLine & BacStrTran(Format(.imp_valor_mercaderia, "00000000000.00"), ".", "")
                    xLine = xLine & BacStrTran(Format(.imp_gastos_fob, "0000000000.00"), ".", "")
                    xLine = xLine & BacStrTran(Format(.imp_valor_fob, "00000000000.00"), ".", "")
                    xLine = xLine & BacStrTran(Format(.imp_flete, "0000000000.00"), ".", "")
                    xLine = xLine & BacStrTran(Format(.imp_seguro, "0000000000.00"), ".", "")
                    xLine = xLine & BacStrTran(Format(.imp_valor_cif, "00000000000.00"), ".", "")
                    xLine = xLine & BacStrTran(Format(.imp_intereses, "00000000000.00"), ".", "")
                    xLine = xLine & BacStrTran(Format(.imp_gastos_bancarios, "0000000000.00"), ".", "")
                    
                    xLine = BacPad(xLine, largo) & Chr(13) & Chr(10)
                    Record = Record + 1
                    Put #1, , xLine
                    Cantidad(Val(Left(xLine, 1))) = Cantidad(Val(Left(xLine, 1))) + 1
                    
                    '---- Detalle de Intereses
                    Intereses.Leer .planilla_numero, Format(.planilla_fecha, "yyyymmdd"), 0
                    If .imp_intereses > 0 And Intereses.Cantidad > 0 Then
                        For CorPla = 1 To Intereses.Cantidad
                            Detalle.Leer .planilla_numero, CorPla, Format(.planilla_fecha, "yyyymmdd")
                            xLine = "50"
                            xLine = xLine & BacPad(Detalle.concepto_capital, 3)
                            xLine = xLine & BacStrTran(Format(Detalle.capital, "000000000000.00"), ".", "")
                            xLine = xLine & BacPad(Detalle.tipo_interes, 2)
                            xLine = xLine & Format(Detalle.codigo_base_tasa, "0")
                            xLine = xLine & Format(Detalle.tasa_interes_anual, "00.000000")
                            xLine = xLine & Format(Detalle.fecha_inicial, "yyyymmdd")
                            xLine = xLine & Format(Detalle.fecha_final, "yyyymmdd")
                            '-- Estadisticas no informan interes ni donde se paga
                            If tipo = "PEI" Then
                                xLine = xLine & String(12 + 1, "0")
                            Else
                                xLine = xLine & BacStrTran(Format(Detalle.monto_interes, "0000000000.00"), ".", "")
                                xLine = xLine & Format(Detalle.indica_pago_exterior, "0")
                            End If
                            
                            xLine = BacPad(xLine, largo) & Chr(13) & Chr(10)
                            Record = Record + 1
                            Put #1, , xLine
                            Cantidad(Val(Left(xLine, 1))) = Cantidad(Val(Left(xLine, 1))) + 1
                        Next CorPla
                    End If
                End If
                
                '---- Derivados
                If .afecto_derivados > 0 Then
                    xLine = "60"
                    xLine = xLine & Format(.der_numero_contrato, "00000000")
                    xLine = xLine & Format(.der_fecha_inicio, "yyyymmdd")
                    xLine = xLine & Format(.der_fecha_vence, "yyyymmdd")
                    xLine = xLine & Format(.der_instrumento, "00")
                    xLine = xLine & BacStrTran(Format(.der_precio_contrato, "000000.0000"), ".", "")
                    xLine = xLine & Format(.der_area_contable, "00")
                    
                    xLine = BacPad(xLine, largo) & Chr(13) & Chr(10)
                    Record = Record + 1
                    Put #1, , xLine
                    Cantidad(Val(Left(xLine, 1))) = Cantidad(Val(Left(xLine, 1))) + 1
                End If
                
                '---- Acuerdos
                '-- Siembre se envian 17 ceros, porque se informan cuando son
                '-- creditos reciprocos, y ya no sucede eso
                If .cantidad_acuerdos >= 1 Then
                    xLine = "70"
                    xLine = xLine & BacPad(Trim(.acuerdo_codigo_1), 7)
                    If True Then
                        xLine = xLine & String(17, "0")
                    Else
                        xLine = xLine & BacStrTran(BacPad(Trim(.acuerdo_numero_1), 17, "L"), " ", "0")
                    End If
                    xLine = BacPad(xLine, largo) & Chr(13) & Chr(10)
                    Record = Record + 1
                    Put #1, , xLine
                    Cantidad(Val(Left(xLine, 1))) = Cantidad(Val(Left(xLine, 1))) + 1
                End If
                If .cantidad_acuerdos >= 2 Then
                    xLine = "70"
                    xLine = xLine & BacPad(Trim(.acuerdo_codigo_2), 7)
                    If True Then
                        xLine = xLine & String(17, "0")
                    Else
                        xLine = xLine & BacStrTran(BacPad(Trim(.acuerdo_numero_2), 17, "L"), " ", "0")
                    End If
                    xLine = BacPad(xLine, largo) & Chr(13) & Chr(10)
                    Record = Record + 1
                    Put #1, , xLine
                    Cantidad(Val(Left(xLine, 1))) = Cantidad(Val(Left(xLine, 1))) + 1
                End If
                If .cantidad_acuerdos >= 3 Then
                    xLine = "70"
                    xLine = xLine & BacPad(Trim(.acuerdo_codigo_3), 7)
                    If True Then
                        xLine = xLine & String(17, "0")
                    Else
                        xLine = xLine & BacStrTran(BacPad(Trim(.acuerdo_numero_3), 17, "L"), " ", "0")
                    End If
                    xLine = BacPad(xLine, largo) & Chr(13) & Chr(10)
                    Record = Record + 1
                    Put #1, , xLine
                    Cantidad(Val(Left(xLine, 1))) = Cantidad(Val(Left(xLine, 1))) + 1
                End If
                If .cantidad_acuerdos >= 4 Then
                    xLine = "70"
                    xLine = xLine & BacPad(Trim(.acuerdo_codigo_4), 7)
                    If True Then
                        xLine = xLine & String(17, "0")
                    Else
                        xLine = xLine & BacStrTran(BacPad(Trim(.acuerdo_numero_4), 17, "L"), " ", "0")
                    End If
                    xLine = BacPad(xLine, largo) & Chr(13) & Chr(10)
                    Record = Record + 1
                    Put #1, , xLine
                    Cantidad(Val(Left(xLine, 1))) = Cantidad(Val(Left(xLine, 1))) + 1
                End If
                If .cantidad_acuerdos >= 5 Then
                    xLine = "70"
                    xLine = xLine & BacPad(Trim(.acuerdo_codigo_5), 7)
                    If True Then
                        xLine = xLine & String(17, "0")
                    Else
                        xLine = xLine & BacStrTran(BacPad(Trim(.acuerdo_numero_5), 17, "L"), " ", "0")
                    End If
                    xLine = BacPad(xLine, largo) & Chr(13) & Chr(10)
                    Record = Record + 1
                    Put #1, , xLine
                    Cantidad(Val(Left(xLine, 1))) = Cantidad(Val(Left(xLine, 1))) + 1
                End If
                
                '---- Observaciones
                xVal = Len(Linea_Obs(.obs_1)) + Len(Linea_Obs(.obs_2)) + Len(Linea_Obs(.obs_3))
                If xVal > 0 And Not TipPlanilla = "EXP" Then
                    xLine = ""
                    xStr = .obs_1
                    If Len(Trim(xStr)) > 0 Then
                        xLine = xLine & " " & Linea_Obs(xStr)
                    End If
                    xStr = .obs_2
                    If Len(Trim(xStr)) > 0 Then
                        xLine = xLine & " " & Linea_Obs(xStr)
                    End If
                    xStr = .obs_3
                    If Len(Trim(xStr)) > 0 Then
                        xLine = xLine & " " & Linea_Obs(xStr)
                    End If
                    xLine = Trim(xLine)
                    Do While Len(xLine) > 240
                        xStr = "80" & Corta_Texto(xLine, 240, "")
                        xStr = BacPad(xStr, largo) & Chr(13) & Chr(10)
                        Record = Record + 1
                        Put #1, Record, xStr
                        Cantidad(Val(Left(xStr, 1))) = Cantidad(Val(Left(xStr, 1))) + 1
                        xLine = Trim(Mid(xLine, Len(xStr) + 1))
                    Loop
                    If Len(xLine) > 0 Then
                        xLine = "80" & xLine
                        xLine = BacPad(xLine, largo) & Chr(13) & Chr(10)
                        Record = Record + 1
                        Put #1, , xLine
                        Cantidad(Val(Left(xLine, 1))) = Cantidad(Val(Left(xLine, 1))) + 1
                    End If
                End If
                
            End If
        
        End With
            
    Next I
    
    '-- Fin de archivo - Totales
    xLine = "99"
    For I = LBound(Cantidad, 1) To UBound(Cantidad, 1)
        xLine = xLine & Format(Cantidad(I), "000000")
        Total = Total + Cantidad(I)
    Next I
    xLine = xLine & Format(Total, "000000")
    xLine = BacPad(xLine, largo) & Chr(13) & Chr(10)
    Record = Record + 1
    Put #1, , xLine
    
    Close #1
    
    Interfaz_Posicion_BCCH = True
    
    Exit Function
   
HError:
    MsgBox err.Description, vbCritical
    On Error Resume Next
    Close #1
    On Error GoTo 0
    Exit Function

End Function


Public Function BacPad(strLine As String, intLen As Long, Optional Position As Variant) As String

    If VarType(Position) <> vbString Then
        Position = ""
    End If
    Position = Left(Position & "R", 1)

    If InStr("LCR", Position) = 0 Then
        Position = "R"
    End If

    If InStr("LC", Position) > 0 Then
        If Position = "C" Then
            strLine = Space(Int(intLen / 2)) & strLine
        Else
            strLine = Space(intLen) & strLine
        End If
        strLine = Right(strLine, intLen)
    End If

    BacPad = Left(strLine & Space(intLen), intLen)

End Function

Public Function Linea_Obs(strObs As String) As String

    strObs = BacStrTran(strObs, Chr(10), Chr(13))
    strObs = BacStrTran(strObs, Chr(13), Space(1))
    Do While InStr(strObs, Space(2)) > 0
        strObs = BacStrTran(strObs, Space(2), Space(1))
    Loop
    Linea_Obs = Trim(strObs)
    
End Function
