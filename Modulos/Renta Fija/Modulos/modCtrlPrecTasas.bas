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
Public Ctrlpt_Plazo As Long
Public Ctrlpt_Tasa As Double
Public Ctrlpt_ModoOperacion As String
Public Ctrlpt_BandaInferior As String
Public Ctrlpt_BandaSuperior As String
Public Ctrlpt_AplicarControl As Boolean
Public Ctrlpt_RutCliente As String          'Nuevo, 30-03-2011
Public Ctrlpt_CodCliente As String          'Nuevo, 30-03-2011
Public Function ControlPreciosTasas(ByVal codProducto As String, ByVal Instrumento As String, ByVal Plazo As Long, ByVal Tasa As Double, Optional ByVal agregamsg As Boolean = True) As String
Dim sp As String
Dim dif As Double
Dim Msg As String
Dim codFamilia As String
Dim indicador As String
Dim Datos()
codFamilia = ""
Ctrlpt_codProducto = codProducto
                                                                                'ld1-cor-035 control captaciones
If codProducto = "CP" Or codProducto = "CI" Or codProducto = "RC" Or codProducto = "ICAP" Or codProducto = "IC" Then
    Ctrlpt_TipoOp = "C"
ElseIf codProducto = "VP" Or codProducto = "VI" Or codProducto = "RV" Or codProducto = "ICOL" Then
    Ctrlpt_TipoOp = "V"
End If
                                                                                'ld1-cor-035 control captaciones
If codProducto = "CI" Or codProducto = "VI" Or codProducto = "RC" Or codProducto = "RV" Or codProducto = "IC" Then
    indicador = "M"
Else
    indicador = "F"
End If
Ctrlpt_Plazo = Plazo
Ctrlpt_Tasa = Tasa
codFamilia = Instrumento
ControlPreciosTasas = "N"

EnviarCF = "S"  'Por defecto, enviar a Control Financiero si no está en modo silencioso

'
'Revisar primero si corresponde aplicar el Control o no
'según el Módulo y el sistema
'
If Not AplicaControlPT("BTR", codProducto) Then
    Ctrlpt_AplicarControl = False
    ControlPreciosTasas = "N"
    Ctrlpt_Mensaje = ""
    Ctrlpt_Excede = ControlPreciosTasas
    Exit Function
End If
'
'Si llegó aquí es porque si corresponde aplicar el control
Ctrlpt_AplicarControl = True

Envia = Array()
sp = "Bacparamsuda..SP_CONTROLES_PRECIOTASAS"
AddParam Envia, "BTR"
AddParam Envia, codProducto
AddParam Envia, codFamilia     'Código de la familia del instrumento
AddParam Envia, indicador       'flag, M/F
AddParam Envia, Ctrlpt_TipoOp
AddParam Envia, Plazo
AddParam Envia, Tasa
AddParam Envia, 0#
AddParam Envia, dif
AddParam Envia, Msg
If Bac_Sql_Execute(sp, Envia) Then
    Ctrlpt_Mensaje = ""
    Ctrlpt_Diferencia = 0
    Do While Bac_SQL_Fetch(Datos())
        If Datos(2) = "OK" Then
            Ctrlpt_Diferencia = CDbl(Datos(1))
            Ctrlpt_Mensaje = Datos(2)
            Ctrlpt_BandaInferior = IIf(IsNull(Datos(3)), "0", Datos(3))
            Ctrlpt_BandaSuperior = IIf(IsNull(Datos(4)), "0", Datos(4))
            ControlPreciosTasas = "N"
        Else
            Ctrlpt_Diferencia = CDbl(Datos(1))
            Ctrlpt_Mensaje = Datos(2)
            Ctrlpt_BandaInferior = IIf(IsNull(Datos(3)), "0", Datos(3))
            Ctrlpt_BandaSuperior = IIf(IsNull(Datos(4)), "0", Datos(4))
            ControlPreciosTasas = "S"
        End If
        
        If UBound(Datos()) = 5 Then
            EnviarCF = IIf(UCase(Datos(5)) = "N", "N", "S")
        End If
        
    Exit Do
    Loop
End If
Ctrlpt_Excede = ControlPreciosTasas
End Function
Public Function GrabaLineaPendPrecios() As String
Dim sp As String
Dim nCorrela As Integer
Dim Datos()
Envia = Array()
If Ctrlpt_Correlativo = 0 Then
    nCorrela = 1
Else
    nCorrela = Ctrlpt_Correlativo
End If
'sp = "Bacparamsuda..sp_Graba_OpPendientePrecios"
sp = "Bacparamsuda..SP_GRABA_OPERACIONPENDIENTEPRECIOS"
AddParam Envia, "BTR"
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
Do While Bac_SQL_Fetch(Datos())
    If Datos(1) = "OK" Then
        GrabaLineaPendPrecios = "OK"
        'Limpiar variables públicas
'        Ctrlpt_Tasa = 0#       '---> PRD-10494 Incidencia 1
'        Ctrlpt_Diferencia = 0#
'        Ctrlpt_Mensaje = ""
'        Ctrlpt_BandaSuperior = "0"
'        Ctrlpt_BandaInferior = "0"
    Else
        GrabaLineaPendPrecios = "ERROR"
    End If
    Exit Do
Loop
End Function
Public Function LeeModoControlPT() As String
Dim nomSp As String
Dim Datos()
Envia = Array()
Ctrlpt_ModoOperacion = "N"  'Valor por defecto
AddParam Envia, "BTR"
nomSp = "Bacparamsuda..SP_RETMODOCONTROLPRECIOSTASAS"
If Not Bac_Sql_Execute(nomSp, Envia) Then
    Exit Function
End If
Do While Bac_SQL_Fetch(Datos())
    If UCase(Datos(1)) = "S" Then
        Ctrlpt_ModoOperacion = "S"  'Modo Silencioso
    Else
        Ctrlpt_ModoOperacion = "N"  'Modo Normal
    End If
    Exit Do
Loop
End Function
Public Function GrabaModoSilencioso() As String
Dim sp As String
Dim Datos()
Envia = Array()
sp = "Bacparamsuda..SP_GRABA_CONTROL_SILENCIOSO"
AddParam Envia, "BTR"
AddParam Envia, Ctrlpt_NumOp
AddParam Envia, Ctrlpt_codProducto
AddParam Envia, Ctrlpt_TipoOp
AddParam Envia, Ctrlpt_Plazo
AddParam Envia, Ctrlpt_Tasa
AddParam Envia, Ctrlpt_Diferencia
AddParam Envia, Ctrlpt_Mensaje
AddParam Envia, CDbl(Ctrlpt_BandaSuperior)
AddParam Envia, CDbl(Ctrlpt_BandaInferior)
AddParam Envia, gsBac_Fecp
AddParam Envia, Ctrlpt_Correlativo
If Not Bac_Sql_Execute(sp, Envia) Then
    GrabaModoSilencioso = "ERRORSQL"
    Exit Function
End If
GrabaModoSilencioso = "OK"
'Limpiar variables públicas
Ctrlpt_Tasa = 0#
Ctrlpt_Diferencia = 0#
Ctrlpt_Mensaje = ""
Ctrlpt_BandaSuperior = "0"
Ctrlpt_BandaInferior = "0"
End Function

Public Function AplicaControlPT(ByVal codSistema As String, ByVal codProducto As String) As Boolean
    On Error GoTo ErrAplicaControlPT
    Dim nProducto   As String
    Dim nomSp       As String
    Dim Salida1     As String
    Dim Salida2     As String
    Dim rutClie     As String
    Dim codClie     As String
    Dim Datos()
    
    rutClie = Ctrlpt_RutCliente
    codClie = Ctrlpt_CodCliente
    
    nProducto = Trim(codProducto)
    Salida1 = "N"
    Salida2 = "N"

    Envia = Array()
    nomSp = "BacParamsuda..SP_DET_APLICA_CONTROL_PRECIOSTASAS1"
    AddParam Envia, "BTR"
    AddParam Envia, nProducto
    If Trim(rutClie) <> "0" And (Len(rutClie) > 0 And Len(codClie) > 0) Then
        AddParam Envia, CLng(rutClie)
        AddParam Envia, CLng(codClie)
    Else
        AddParam Envia, -1
        AddParam Envia, -1
    End If
    
    If Not Bac_Sql_Execute(nomSp, Envia) Then
        AplicaControlPT = False
        On Error GoTo 0
        Exit Function
    End If
    
    If Bac_SQL_Fetch(Datos()) Then
        Salida1 = UCase(Datos(1))
        Salida2 = UCase(Datos(2))
    End If
    
    AplicaControlPT = True
    
    If Salida1 = "N" Or Salida2 = "N" Then
        AplicaControlPT = False
    ElseIf (Salida1 = "S" And Salida2 = "S") Then
        AplicaControlPT = True
    End If

On Error GoTo 0
Exit Function
ErrAplicaControlPT:
    On Error GoTo 0
End Function
