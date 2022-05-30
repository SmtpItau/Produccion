Attribute VB_Name = "modCtrlPrecTasasPCS"
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
Public Ctrlpt_UltimoVAC As Double
Public Ctrlpt_ModoOperacion As String
Public Ctrlpt_BandaInferior As String
Public Ctrlpt_BandaSuperior As String
Public Ctrlpt_ValorRazonable As Double
Public Ctrlpt_AplicarControl As Boolean
Public Ctrlpt_RutCliente As String      'Nuevo, 30-03-2011
Public Ctrlpt_CodCliente As String      'Nuevo, 30-03-2011
Public Function ControlPreciosTasas(ByVal codProducto As String, ByVal Plazo As Integer, ByVal Tasa As Double, Optional ByVal agregamsg As Boolean = True) As String
Dim sp As String
Dim dif As Double
Dim Msg As String
Dim codFamilia As String
Dim Indicador As String
Dim DATOS()
codFamilia = ""
Ctrlpt_codProducto = codProducto
Ctrlpt_Plazo = Plazo
Ctrlpt_UltimoVAC = Tasa
Ctrlpt_TipoOp = ""
Indicador = ""
codFamilia = ""
ControlPreciosTasas = "N"

EnviarCF = "S"  'Por defecto, enviar a Control Financiero si no está en modo silencioso

'
'Revisar primero si corresponde aplicar el Control o no
'según el Módulo y el sistema
'
If Not AplicaControlPT("PCS", codProducto) Then
    Ctrlpt_AplicarControl = False
    ControlPreciosTasas = "N"
    Ctrlpt_Mensaje = ""
    Ctrlpt_UltimoVAC = 0
    Ctrlpt_Diferencia = 0
    Ctrlpt_BandaInferior = 0
    Ctrlpt_BandaSuperior = 0
    Ctrlpt_Excede = ControlPreciosTasas
    Exit Function
End If
'
'Si llegó aquí es porque si corresponde aplicar el control
Ctrlpt_AplicarControl = True

Envia = Array()
sp = "BACPARAMSUDA..SP_CONTROLES_PRECIOTASAS"
AddParam Envia, "PCS"
AddParam Envia, codProducto
AddParam Envia, codFamilia     'Código de la familia del instrumento
AddParam Envia, Indicador       'flag, M/F
AddParam Envia, Ctrlpt_TipoOp
AddParam Envia, Ctrlpt_Plazo
AddParam Envia, Ctrlpt_UltimoVAC
AddParam Envia, 0#
AddParam Envia, dif
AddParam Envia, Msg
If Bac_Sql_Execute(sp, Envia) Then
    Ctrlpt_Mensaje = ""
    Ctrlpt_Diferencia = 0
    Do While Bac_SQL_Fetch(DATOS())
        If DATOS(2) = "OK" Then
            Ctrlpt_Diferencia = CDbl(DATOS(1))
            Ctrlpt_Mensaje = DATOS(2)
            Ctrlpt_BandaInferior = IIf(IsNull(DATOS(3)), "0", DATOS(3))
            Ctrlpt_BandaSuperior = IIf(IsNull(DATOS(4)), "0", DATOS(4))
            ControlPreciosTasas = "N"
        Else
            Ctrlpt_Diferencia = CDbl(DATOS(1))
            Ctrlpt_Mensaje = DATOS(2)
            Ctrlpt_BandaInferior = IIf(IsNull(DATOS(3)), "0", DATOS(3))
            Ctrlpt_BandaSuperior = IIf(IsNull(DATOS(4)), "0", DATOS(4))
            ControlPreciosTasas = "S"
        End If
        
        If UBound(DATOS()) = 5 Then
            EnviarCF = IIf(UCase(DATOS(5)) = "N", "N", "S")
        End If
    
    Exit Do
    Loop
End If
Ctrlpt_Excede = ControlPreciosTasas
End Function
Public Function LeeModoControlPT() As String
Dim nomSp As String
Dim DATOS()
Envia = Array()
Ctrlpt_ModoOperacion = "N"  'Valor por defecto
AddParam Envia, "PCS"
nomSp = "BACPARAMSUDA..SP_RETMODOCONTROLPRECIOSTASAS"
If Not Bac_Sql_Execute(nomSp, Envia) Then
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
Envia = Array()
sp = "BACPARAMSUDA..SP_GRABA_CONTROL_SILENCIOSO"
AddParam Envia, "PCS"
AddParam Envia, Ctrlpt_NumOp
AddParam Envia, Ctrlpt_codProducto
AddParam Envia, Ctrlpt_TipoOp
AddParam Envia, Ctrlpt_Plazo
AddParam Envia, Ctrlpt_UltimoVAC
AddParam Envia, Ctrlpt_Diferencia
AddParam Envia, Ctrlpt_Mensaje
AddParam Envia, CDbl(Ctrlpt_BandaSuperior)
AddParam Envia, CDbl(Ctrlpt_BandaInferior)
AddParam Envia, gsBAC_Fecp
AddParam Envia, Ctrlpt_Correlativo
If Not Bac_Sql_Execute(sp, Envia) Then
    GrabaModoSilencioso = "ERRORSQL"
    Exit Function
End If
GrabaModoSilencioso = "OK"
'Limpiar variables públicas
Ctrlpt_UltimoVAC = 0#
Ctrlpt_Diferencia = 0#
Ctrlpt_Mensaje = ""
Ctrlpt_BandaInferior = ""
Ctrlpt_BandaSuperior = ""
Ctrlpt_Correlativo = 1
End Function
Public Function GrabaLineaPendPrecios() As String
Dim sp As String
Dim nCorrela As Integer
Dim DATOS()
Envia = Array()
If Ctrlpt_Correlativo = 0 Then
    nCorrela = 1
Else
    nCorrela = Ctrlpt_Correlativo
End If
sp = "BACPARAMSUDA..SP_GRABA_OPERACIONPENDIENTEPRECIOS"
AddParam Envia, "PCS"
AddParam Envia, Ctrlpt_codProducto
AddParam Envia, Ctrlpt_NumOp
AddParam Envia, Val(Ctrlpt_NumDocu)
AddParam Envia, Ctrlpt_TipoOp
AddParam Envia, Ctrlpt_Diferencia
AddParam Envia, Ctrlpt_Mensaje
If Not Bac_Sql_Execute(sp, Envia) Then
    GrabaLineaPendPrecios = "ERRORSQL"
    Exit Function
End If
Do While Bac_SQL_Fetch(DATOS())
    If DATOS(1) = "OK" Then
        GrabaLineaPendPrecios = "OK"
        'Limpiar variables públicas
'        Ctrlpt_UltimoVAC = 0#      '---> Incidencia 1
'        Ctrlpt_Diferencia = 0#
'        Ctrlpt_Mensaje = ""
'        Ctrlpt_BandaInferior = ""
'        Ctrlpt_BandaSuperior = ""
'        Ctrlpt_Correlativo = 1
    Else
        GrabaLineaPendPrecios = "ERROR"
    End If
    Exit Do
Loop
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
Dim DATOS()
Envia = Array()
nomSp = "BacParamsuda..SP_DET_APLICA_CONTROL_PRECIOSTASAS1"
AddParam Envia, "PCS"
AddParam Envia, nProducto
If Trim(rutClie) <> "0" Then
    AddParam Envia, CLng(rutClie)
    AddParam Envia, CLng(codClie)
Else
    AddParam Envia, -1
    AddParam Envia, -1
End If
If Not Bac_Sql_Execute(nomSp, Envia) Then
    AplicaControlPT = False
    Exit Function
End If
If Bac_SQL_Fetch(DATOS()) Then
    Salida1 = UCase(DATOS(1))
    Salida2 = UCase(DATOS(2))
End If
AplicaControlPT = True
If Salida1 = "N" Or Salida2 = "N" Then
    AplicaControlPT = False
ElseIf (Salida1 = "S" And Salida2 = "S") Then
    AplicaControlPT = True
End If
End Function

