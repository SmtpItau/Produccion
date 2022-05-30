Attribute VB_Name = "BacGarantias"
'--- Valor para Control de Garantías
Global Gar_ValorRec     As Double
Global Gar_RutCliente   As Long
Global Gar_CodCliente   As Integer
Global Gar_NumOper      As Long
Global Gar_FvctoOper    As Date
Global Const FDecimal = "#,##0.0000"
Global Const Fentero = "#,##0"
Function MontoFaltaGarantia(ByVal rutClte As Long, ByVal codClte As Integer, ByVal NumOperacion As Long, ByRef valorRec As Double) As Double
''primero, determinar el valor del rec de la operación
'Dim DATOS()
'MontoFaltaGarantia = 0#
'Envia = Array()
'AddParam Envia, Sistema
'AddParam Envia, NumOperacion
'If Not Bac_Sql_Execute("Bacparamsuda..sp_RetValorRecOperacion", Envia) Then
'    MsgBox "Error al recuperar el valor Rec de la operación!", vbExclamation, TITSISTEMA
'    MontoFaltaGarantia = 0#
'    Exit Function
'End If
'valorRec = 0#
'If Bac_SQL_Fetch(DATOS()) <> 0 Then
'    valorRec = CDbl(DATOS(1))
'End If
''luego, determinar si falta o no para la operacion
'Envia = Array()
'AddParam Envia, rutClte
'AddParam Envia, codClte
'AddParam Envia, valorRec
'If Not Bac_Sql_Execute("Bacparamsuda..sp_VerificaSiFaltaGarantia", Envia) Then
'    MsgBox "Error al verificar falta de Garantía", vbExclamation, TITSISTEMA
'    MontoFaltaGarantia = 0#
'    Exit Function
'End If
'If Bac_SQL_Fetch(DATOS()) <> 0 Then
'    If DATOS(1) = "SI" Then
'        MontoFaltaGarantia = CDbl(DATOS(2))
'    Else
'        MontoFaltaGarantia = 0#
'    End If
'End If
End Function
Function CantidadGarantias(ByVal rutClte As Long, ByVal codClte As Integer) As Integer
'Dim DATOS()
'Envia = Array()
'AddParam Envia, rutClte
'AddParam Envia, codClte
'If Not Bac_Sql_Execute("Bacparamsuda..sp_CantGarantiasDisponibles", Envia) Then
'    MsgBox "Error al buscar la cantidad de Garantías disponibles del cliente!", vbExclamation, TITSISTEMA
'    CantidadGarantias = -1
'    Exit Function
'End If
'If Bac_SQL_Fetch(DATOS()) <> 0 Then
'    CantidadGarantias = CInt(DATOS(1))
'End If
End Function
Function ControlGarantias(ByVal rutClte As Long, ByVal codClte As Integer, ByVal NumOperacion As Long) As Boolean
'    Dim valorRec As Double
'    Dim faltanteGarantia As Double
'    Dim cantGtias As Integer
'
'    Gar_RutCliente = rutClte
'    Gar_CodCliente = codClte
'    Gar_NumOper = NumOperacion
'
'    If ProcesarConRecCero() = False Then
'        ControlGarantias = False
'        Exit Function
'    End If
'    'comparar el valor del REC de la operación contra el total de garantías disponibles del cliente
'    valorRec = 0#
'    faltanteGarantia = MontoFaltaGarantia(rutClte, codClte, NumOperacion, valorRec)
'    If faltanteGarantia > 0# Then
'        'Marcar la operación en Líneas agregándole mensaje que cliente no tiene garantías constituídas
'        MsgBox "Atención! El cliente no tiene garantías constituídas para esta operación", vbExclamation, TITSISTEMA
'        'Call MarcarOperacion
'        ControlGarantias = False
'        Exit Function
'    Else  'No faltan, pero hay que asociar la operación a garantías disponibles
'        Gar_ValorRec = valorRec
'        'Por ver si entra aun cuando el rec sea cero...
'        cantGtias = CantidadGarantias(rutClte, codClte)
'        If cantGtias = -1 Then
'            ControlGarantias = False
'            Exit Function
'        End If
'        If cantGtias = 0 Then
'            MsgBox "El cliente no tiene garantías constituídas disponibles para esta operación!", vbExclamation, TITSISTEMA
'            ControlGarantias = False
'            Exit Function
'        ElseIf cantGtias > 0 Then
'            ControlGarantias = True
'        End If
'    End If
End Function
Function ProcesarConRecCero() As Boolean
'Dim Salida As String
'Dim DATOS()
'Envia = Array()
'If Not Bac_Sql_Execute("Bacparamsuda..sp_RetParametrosGarantias") Then
'    MsgBox "Error al buscar Parámetros de Garantías!", vbExclamation, TITSISTEMA
'    Exit Function
'End If
'If Bac_SQL_Fetch(DATOS()) <> 0 Then
'    Salida = DATOS(1)
'End If
'Salida = UCase(Salida)
'If Salida = "S" Then
'    ProcesarConRecCero = True
'Else
'    ProcesarConRecCero = False
'End If
End Function
