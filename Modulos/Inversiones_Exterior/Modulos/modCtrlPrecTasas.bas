Attribute VB_Name = "modCtrlPrecTasas"
Public Ctrlpt_Excede As String
Public Ctrlpt_Diferencia As Double
Public Ctrlpt_Mensaje As String
Public Ctrlpt_codProducto As String
Public Ctrlpt_NumOp As String
Public Ctrlpt_NumDocu As String
Public Ctrlpt_TipoOp As String
Public Ctrlpt_Correlativo As Integer
Public Ctrlpt_Moneda As String
Public Ctrlpt_Plazo As Integer
Public Ctrlpt_Tasa As Double
Public Ctrlpt_ModoOperacion As String
Public Ctrlpt_BandaInferior As String
Public Ctrlpt_BandaSuperior As String
Public Ctrlpt_AplicarControl As Boolean
Public Ctrlpt_RutCliente As String      'Nuevo, 30-03-2011
Public Ctrlpt_CodCliente As String      'Nuevo, 30-03-2011

Public Function ControlPreciosTasas(ByVal codProducto As String, ByVal Instrumento As String, ByVal Plazo As Integer, ByVal Tasa As Double, Optional ByVal agregamsg As Boolean = True) As String
Dim sp As String
Dim dif As Double
Dim Msg As String
Dim codFamilia As String
Dim indicador As String
Dim DATOS()
codFamilia = ""
Ctrlpt_codProducto = codProducto
Ctrlpt_Plazo = Plazo
Ctrlpt_Tasa = Tasa
If codProducto = "CPX" Then
    Ctrlpt_TipoOp = "C"
ElseIf codProducto = "VPX" Then
    Ctrlpt_TipoOp = "V"
End If
indicador = "F"
codFamilia = Instrumento
ControlPreciosTasas = "N"

EnviarCF = "S"  'Por defecto, enviar a Control Financiero si no está en modo silencioso

'
'Revisar primero si corresponde aplicar el Control o no
'según el Módulo y el sistema
'
If Not AplicaControlPT("BEX", codProducto) Then
    Ctrlpt_AplicarControl = False
    ControlPreciosTasas = "N"
    Ctrlpt_Mensaje = ""
    Ctrlpt_Excede = ControlPreciosTasas
    Exit Function
End If
'
'Si llegó aquí es porque si corresponde aplicar el control
Ctrlpt_AplicarControl = True

envia = Array()
sp = "Bacparamsuda..SP_CONTROLES_PRECIOTASAS"
AddParam envia, "BEX"
AddParam envia, codProducto
AddParam envia, codFamilia     'Código de la familia del instrumento
AddParam envia, indicador       'flag, M/F
AddParam envia, Ctrlpt_TipoOp
AddParam envia, Plazo
AddParam envia, Tasa
AddParam envia, 0#
AddParam envia, dif
AddParam envia, Msg
If Bac_Sql_Execute(sp, envia) Then
    Ctrlpt_Mensaje = ""
    Ctrlpt_Diferencia = 0
    Do While Bac_SQL_Fetch(DATOS())
        If DATOS(2) = "OK" Then
            Ctrlpt_Diferencia = CDbl(DATOS(1))
            Ctrlpt_Mensaje = DATOS(2)
            Ctrlpt_BandaInferior = IIf(IsNull(datos(3)), "0", datos(3))
            Ctrlpt_BandaSuperior = IIf(IsNull(datos(4)), "0", datos(4))
            ControlPreciosTasas = "N"
        Else
            Ctrlpt_Diferencia = CDbl(DATOS(1))
            Ctrlpt_Mensaje = DATOS(2)
            Ctrlpt_BandaInferior = IIf(IsNull(datos(3)), "0", datos(3))
            Ctrlpt_BandaSuperior = IIf(IsNull(datos(4)), "0", datos(4))
            ControlPreciosTasas = "S"
        End If
        
        If UBound(datos()) = 5 Then
            EnviarCF = IIf(UCase(datos(5)) = "N", "N", "S")
        End If
        
    Exit Do
    Loop
End If
Ctrlpt_Excede = ControlPreciosTasas
End Function
Public Function GrabaLineaPendPrecios() As String
Dim sp As String
Dim nCorrela As Integer
Dim DATOS()
envia = Array()
If Ctrlpt_Correlativo = 0 Then
    nCorrela = 1
Else
    nCorrela = Ctrlpt_Correlativo
End If
'sp = "Bacparamsuda..sp_Graba_OpPendientePrecios"
sp = "Bacparamsuda..SP_GRABA_OPERACIONPENDIENTEPRECIOS"
AddParam envia, "BEX"
AddParam envia, Ctrlpt_codProducto
AddParam envia, Ctrlpt_NumOp
AddParam envia, Val(Ctrlpt_NumDocu)
AddParam envia, Ctrlpt_TipoOp
AddParam envia, Ctrlpt_Diferencia
AddParam envia, Ctrlpt_Mensaje
If Not Bac_Sql_Execute(sp, envia) Then
    GrabaLineaPendPrecios = "ERRORSQL"
    Exit Function
End If
Do While Bac_SQL_Fetch(DATOS())
    If DATOS(1) = "OK" Then
        GrabaLineaPendPrecios = "OK"
        'Limpiar variables públicas
'        Ctrlpt_Tasa = 0#       '---> PRD-10494 Incidencia 1
'        Ctrlpt_Diferencia = 0#
'        Ctrlpt_Mensaje = ""
'        Ctrlpt_BandaInferior = "0"
'        Ctrlpt_BandaSuperior = "0"
    Else
        GrabaLineaPendPrecios = "ERROR"
    End If
    Exit Do
Loop
End Function
Public Function LeeModoControlPT() As String
Dim nomSp As String
Dim DATOS()
envia = Array()
Ctrlpt_ModoOperacion = "N"  'Valor por defecto
AddParam envia, "BEX"
nomSp = "Bacparamsuda..SP_RETMODOCONTROLPRECIOSTASAS"
If Not Bac_Sql_Execute(nomSp, envia) Then
    Exit Function
End If
Do While Bac_SQL_Fetch(DATOS())
    If UCase(DATOS(1)) = "S" Then
        Ctrlpt_ModoOperacion = "S"  'Modo Silencioso
    Else
        Ctrlpt_ModoOperacion = "N"  'Modo Normal
    End If
    Exit Do
Loop
End Function
Public Function GrabaModoSilencioso() As String
Dim sp As String
Dim DATOS()
envia = Array()
sp = "Bacparamsuda..SP_GRABA_CONTROL_SILENCIOSO"
AddParam envia, "BEX"
AddParam envia, Ctrlpt_NumOp
AddParam envia, Ctrlpt_codProducto
AddParam envia, Ctrlpt_TipoOp
AddParam envia, Ctrlpt_Plazo
AddParam envia, Ctrlpt_Tasa
AddParam envia, Ctrlpt_Diferencia
AddParam envia, Ctrlpt_Mensaje
AddParam envia, CDbl(Ctrlpt_BandaSuperior)
AddParam envia, CDbl(Ctrlpt_BandaInferior)
AddParam envia, gsBac_Fecp
AddParam envia, Ctrlpt_Correlativo
If Not Bac_Sql_Execute(sp, envia) Then
    GrabaModoSilencioso = "ERRORSQL"
    Exit Function
End If
GrabaModoSilencioso = "OK"
'Limpiar variables públicas
Ctrlpt_Tasa = 0#
Ctrlpt_Diferencia = 0#
Ctrlpt_Mensaje = ""
Ctrlpt_BandaInferior = "0"
Ctrlpt_BandaSuperior = "0"
End Function

Public Function AplicaControlPT(ByVal codSistema As String, ByVal codProducto As String) As Boolean
Dim nProducto As String
Dim nomSp As String
Dim Salida1 As String
Dim Salida2 As String
Dim rutClie As String
Dim codClie As String

rutClie = Ctrlpt_RutCliente
codClie = Ctrlpt_CodCliente
If Trim(rutClie) = "" Then
    rutClie = "0"
End If
If Trim(codClie) = "" Then
    codClie = "0"
End If
nProducto = Trim(codProducto)
Salida1 = "N"
Salida2 = "N"
Dim datos()
envia = Array()
nomSp = "BacParamsuda..SP_DET_APLICA_CONTROL_PRECIOSTASAS1"
AddParam envia, "BEX"
AddParam envia, nProducto
If Trim(rutClie) <> "0" Then
    AddParam envia, CLng(rutClie)
    AddParam envia, CLng(codClie)
Else
    AddParam envia, -1
    AddParam envia, -1
End If
If Not Bac_Sql_Execute(nomSp, envia) Then
    AplicaControlPT = False
    Exit Function
End If
If Bac_SQL_Fetch(datos()) Then
    Salida1 = UCase(datos(1))
    Salida2 = UCase(datos(2))
End If
AplicaControlPT = True
If Salida1 = "N" Or Salida2 = "N" Then
    AplicaControlPT = False
ElseIf (Salida1 = "S" And Salida2 = "S") Then
    AplicaControlPT = True
End If
End Function

