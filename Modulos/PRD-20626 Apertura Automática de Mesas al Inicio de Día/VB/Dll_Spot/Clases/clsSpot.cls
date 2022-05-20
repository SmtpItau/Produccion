VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsSpot"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
Public Type Valores_Monedas
        vmcodigo                As Integer
        vmdescripcion           As String
        vmValor                 As Double
        vmvalorcompra           As Double
        vmvalorventa            As Double
End Type
Public Type nValores_Monedas
        dValoresMonedas()       As Valores_Monedas
End Type

Private Type DatosGenerales
        Fecha_Anterior          As Date
        Fecha_Proceso           As Date
        Fecha_Proximo           As Date
        Entidad_Rut             As Long
        Entidad_DV              As String
        Entidad_Codigo          As Integer
        Entidad_Nombre          As String
        Entidad_BCCH            As Integer
        Entidad_SBIF            As Integer
        Entidad_Bolsa           As String
        Entidad_Datatec         As String
        Valor_UF                As Double
        Valor_Observado         As Double
        Valor_Acuerdo           As Double
        Inicio_Dia              As Boolean
        DatosFinancieros        As Boolean
        Paridad_Diaria          As Boolean
        Paridad_Mensual         As Boolean
        Posicion_Inicial        As Boolean
        Cierre_Mesa             As Boolean
        Aprobaciones            As Boolean
        Contabilizacion         As Boolean
        Fin_Dia                 As Boolean
        Rentabilidad            As Boolean
        Tasa_Camara             As Double
        Dias_Camara             As Integer
        Tasa_Overnight          As Double
        Dias_Overnight          As Integer
        Banda_Minimo            As Double
        Banda_Maximo            As Double

        Pais_Feriado_Local      As String
        Pais_Feriado_Externo    As String
        
        Impuesto_Timbre         As Double
        PosicionInicial         As Double
        PrecioMeComp            As Double
        PrecioMeVent            As Double
        
        gsBAC_Fecp              As Date
        gsBAC_DolarOBs          As String
        gsBAC_ValmonUF          As String
        gsBAC_Fecpx             As String
        gsBAC_DolarAcuer        As String
        gsBAC_CodCliente        As Integer
        gsBAC_LogDig            As String
        gsBac_Version           As String
        giBAC_RutEntidad        As Long
        giBAC_DvEntidad         As String
        gsBAC_Clien             As String
        giBAC_Entidad           As Integer
End Type
Private cDatosgenerales         As DatosGenerales

Private dFechaProceso           As String
Private dFechaProxima           As String
Private cPathFileLog            As String

Private Const gsc_FechaDMA = "DD/MM/YYYY"
Private Const gsc_FechaSeparador = "/"

Private Type oDatosIniciales
        TxtObser                As Double
        TxtValorUF              As Double
        TxtAcuer                As Double
        IntText1                As Double
    
        TxtTCamara              As Double
        TxtTOver                As Double
        TxtDCamara              As Double
        TxtDOver                As Double
        TxtPosini               As Double
    
        HedgeiniSpot            As Double
        HedgeiniForward         As Double
        PrecioHedgeInicial      As Double
        Txt_PrecioCierre        As Double
End Type
Private nDatosIniciales         As oDatosIniciales
Public DllParametros            As New Obj_Parametros.clsParametros

Private Function BAC_Conection(ByVal iMode As Integer, ByVal cServerName As String, ByVal cDataBaseName As String, ByVal cUserName As String, ByVal cPassword As String, ByVal nLoginTimeOut As Integer, ByVal nQueryTimeOut As Integer, ByVal cBaseLineas As String) As Boolean
    Let BAC_Conection = False

    Let miSQL.HostName = "dllInicioSpot"
    Let miSQL.Application = "Bac Spot"
    Let gsBac_LineasDB = cBaseLineas

    Let miSQL.ConnectionMode = iMode
    Let miSQL.ServerName = cServerName
    Let miSQL.DatabaseName = cDataBaseName
    Let miSQL.Login = cUserName
    Let miSQL.Password = Encript(Trim(cPassword), False)
    Let miSQL.LoginTimeOut = nLoginTimeOut
    Let miSQL.QueryTimeOut = nQueryTimeOut

    If miSQL.SQL_Coneccion() = False Then
        Exit Function
    End If

    Let BAC_Conection = True
End Function

Public Function ProcesoInicioDia(ByVal iMode As Integer, ByVal cServerName As String, ByVal cDataBaseName As String, ByVal cUserName As String, ByVal cPassword As String, ByVal nLoginTimeOut As Integer, ByVal nQueryTimeOut As Integer, ByVal cBaseLineas As String, ByVal cPathLog As String) As Boolean
    Dim ValorMonedaProceso As nValores_Monedas

    Let ProcesoInicioDia = False

    Let cPathFileLog = cPathLog

    '-> Activa la coneccion
    If BAC_Conection(iMode, cServerName, cDataBaseName, cUserName, cPassword, nLoginTimeOut, nQueryTimeOut, cBaseLineas) = False Then
        Call WriteLogFile("Clase Spot : Conexion ha fallado.")
        Exit Function
    End If

    Let DllParametros.PathFileLog = cPathFileLog
    Call DllParametros.Conectar(iMode, cServerName, "BacParamSuda", cUserName, cPassword, nLoginTimeOut, nQueryTimeOut)

    '-> Datos Generales
    If DatosGenerales = False Then
        Call WriteLogFile("Clase Spot : Error en la recuperacion de datos generales.")
        Exit Function
    End If

    dFechaProceso = cDatosgenerales.Fecha_Proximo
    dFechaProxima = BacProxHabil(Format(cDatosgenerales.Fecha_Proximo, "DD-MM-YYYY"), "00006")

    gsBAC_Fecp = dFechaProceso

    Call DllParametros.Func_MoveEventControls(Spot, 1, [En Ejecucion])
    If GenerarInicio = False Then
        Call DllParametros.Func_MoveEventControls(Spot, 1, [No Finalizado])
        Call WriteLogFile("Clase Spot : Error en proceso de Apertura.")
        Exit Function
    End If
    Call DllParametros.Func_MoveEventControls(Spot, 1, [Finalizado Ok])

    Call DllParametros.Func_MoveEventControls(Spot, 2, [En Ejecucion])
    If LiberacionLineas = False Then
        Call DllParametros.Func_MoveEventControls(Spot, 2, [Finalizado c / Warning])
        Call WriteLogFile("Clase Spot : Error en la liberacion de Lineas. Finalizo con Warning")
    Else
        Call DllParametros.Func_MoveEventControls(Spot, 2, [Finalizado Ok])
    End If

    '-> Datos Generales
    If DatosGenerales = False Then
        Call WriteLogFile("Clase Spot : Error en la recuperacion de datos generales.")
        Exit Function
    End If

    Call DllParametros.Func_MoveEventControls(Spot, 3, [En Ejecucion])
    If TraspasoTxOnlineTarde = False Then
        Call DllParametros.Func_MoveEventControls(Spot, 3, [Finalizado c / Warning])
        Call WriteLogFile("Clase Spot : Error en Traspaso de Tx Online Tarde. Finalizo con Warning")
    Else
        Call DllParametros.Func_MoveEventControls(Spot, 3, [Finalizado Ok])
    End If
    
    Call DllParametros.Func_MoveEventControls(Spot, 4, [En Ejecucion])
    If CapturaVencimientoFwd = False Then
        Call DllParametros.Func_MoveEventControls(Spot, 4, [Finalizado c / Warning])
        Call WriteLogFile("Clase Spot : Error en Proceso de Traspaso de Vencimientos Forward. Finalizo con Warning")
    Else
        Call DllParametros.Func_MoveEventControls(Spot, 4, [Finalizado Ok])
    End If


    Let ProcesoInicioDia = True

    '->  Cierra la Conexion
    Call miSQL.SQL_Close

    Call DllParametros.DesConectar
End Function

Private Function CapturaVencimientoFwd() As Boolean
    Dim nValor  As Long
    Dim cMsg    As String
    Dim Datos()
    
    CapturaVencimientoFwd = False

    If Not Bac_Sql_Execute("SP_CAPTURAFORWARD") Then
        Call WriteLogFile("Clase Spot : Error en Ejecución de Traspaso de Vencimientos Forward.")
        Exit Function
    End If
    nValor = 0
    cMsg = ""
    Do While Bac_SQL_Fetch(Datos())
        nValor = Datos(1)
        If UBound(Datos) > 1 Then       '-- en caso que retorne solo uno o nulo
            cMsg = Datos(2)
        End If
    Loop

    CapturaVencimientoFwd = True
End Function


Private Function TraspasoTxOnlineTarde() As Boolean
    On Error GoTo ErrorTxOnline
    Dim TXonline    As New Collection
    Dim Operacion   As New ClsOperacion
    Dim SQL         As String
    Dim nValor      As Double
    Dim Datos()
    Dim cMsg$
    Dim MiObjeto
    Dim hWndWin     As Double

    Let hWndWin = CDbl((Int((1000000 * Rnd()) + 1)))

    TraspasoTxOnlineTarde = False

    '-> Datos Generales
    If DatosGenerales = False Then
        Call WriteLogFile("Clase Spot : Error en la recuperacion de datos generales.")
        Let TraspasoTxOnlineTarde = True
        On Error GoTo 0
        Exit Function
    End If
    
    If BacBeginTransaction() Then
        If Bac_Sql_Execute("SP_TRASP_TXTARDE_TXONLINE") Then
            If Bac_SQL_Fetch(Datos) Then
                If Datos(1) = 0 Then
                    Call BacCommitTransaction
                    Let TraspasoTxOnlineTarde = True

                    Call WriteLogFile("Clase Spot : Error en Traspaso de Tx Online Tarde. (if : SP_TRASP_TXTARDE_TXONLINE)")
                    On Error GoTo 0
                    Exit Function
                End If
            End If
        Else
            Call BacRollBackTransaction
            Set Operacion = Nothing

            Call WriteLogFile("Clase Spot : Error en Ejecución de Traspaso de Tx Online Tarde. (Else : SP_TRASP_TXTARDE_TXONLINE)")

            Let TraspasoTxOnlineTarde = True
            On Error GoTo 0
            Exit Function
        End If
        
        
        If Operacion.BacTX_OnLine(Format(cDatosgenerales.Fecha_Anterior, "yyyymmdd"), TXonline, 1) Then
            
            For Each MiObjeto In TXonline
                Call Operacion.Limpiar

                Operacion.Fecha = MiObjeto.Fecha
                Operacion.hora = MiObjeto.hora
                Operacion.Operador = MiObjeto.Operador
                Operacion.Correlativo = MiObjeto.Correlativo
                Operacion.Mercado = MiObjeto.Mercado
                Operacion.Operacion = MiObjeto.Operacion
                Operacion.Moneda = MiObjeto.Moneda
                Operacion.MonedaCnv = MiObjeto.MonedaCnv
                Operacion.MontoOrigen = MiObjeto.MontoOrigen
                Operacion.Precio = MiObjeto.Precio
                Operacion.MontoPesos = MiObjeto.MontoPesos
                Operacion.Rut = MiObjeto.Rut
                Operacion.dv = MiObjeto.dv
                Operacion.Codigo = MiObjeto.Codigo
                Operacion.Nombre = MiObjeto.Nombre
                Operacion.Nula = MiObjeto.Nula
                Operacion.Nula = "A"   '-- aprobada
                Operacion.Fecha = cDatosgenerales.Fecha_Proceso
                Operacion.Usuario_OtcDatatec = MiObjeto.Usuario_OtcDatatec

                Call Operacion.PreGrabado_TxOnLine(cDatosgenerales.Fecha_Proceso, CLng(cDatosgenerales.Entidad_Codigo))

                If Not Operacion.Grabar_NextDay(hWndWin, "", cDatosgenerales.Fecha_Proceso) Then
                    Operacion.Nula = "P"
                End If
            Next MiObjeto
            
        End If
        
        Call BacCommitTransaction
    End If

    Set Operacion = Nothing

    TraspasoTxOnlineTarde = True
    
    On Error GoTo 0
    
Exit Function
ErrorTxOnline:

    Call WriteLogFile("Clase Spot : Error en Ejecución de Traspaso de Tx Online Tarde. : " & Err.Description)

End Function

Private Function Datos_Iniciales() As Boolean
    Dim Datos()
    Dim dTipCam     As Double
    Datos_Iniciales = False

    Envia = Array("ME")
    If Not Bac_Sql_Execute("SP_CARGAPARAMETROS", Envia) Then
        Call WriteLogFile("Spot : Error en proceso Datos_Iniciales, [1. SP_CARGAPARAMETROS]")
        Exit Function
    End If
    If Not Bac_SQL_Fetch(Datos()) Then
        Call WriteLogFile("Spot : Error en proceso Datos_Iniciales, [2. SP_CARGAPARAMETROS]")
        Exit Function
    End If

    dTipCam = Format(BacDiv(CDbl(Datos(24)) + CDbl(Datos(23)), 2), "#,##0.0000")

    nDatosIniciales.TxtObser = BacCtrlTransMonto(Datos(2))                                                      '-> Dolar Observado
    nDatosIniciales.TxtValorUF = BacCtrlTransMonto(Datos(3))                                                    '-> Unidad Fomento
    nDatosIniciales.TxtAcuer = BacCtrlTransMonto(Datos(7))                                                      '-> Dolar Acuerdo
    nDatosIniciales.IntText1 = BacCtrlTransMonto(Round(BacDiv(dTipCam - CDbl(Datos(23)), dTipCam) * 100, 6))    '-> % T. Cambio

    nDatosIniciales.TxtTCamara = BacCtrlTransMonto(Datos(8))
    nDatosIniciales.TxtTOver = BacCtrlTransMonto(Datos(9))
    nDatosIniciales.TxtDCamara = CDbl(Datos(10))
    nDatosIniciales.TxtDOver = CDbl(Datos(11))
    nDatosIniciales.TxtPosini = Round(CDbl(Datos(32)), 4)

    nDatosIniciales.HedgeiniSpot = CDbl(Datos(36))
    nDatosIniciales.HedgeiniForward = CDbl(Datos(37))
    nDatosIniciales.PrecioHedgeInicial = CDbl(Datos(38))
    nDatosIniciales.Txt_PrecioCierre = Datos(44)

    Datos_Iniciales = True

End Function


Private Function LiberacionLineas() As Boolean

    LiberacionLineas = False

    Envia = Array(Format(dFechaProceso, "yyyymmdd"))
    If Not Bac_Sql_Execute("SP_LIBERA_LINEAS", Envia) Then
        Call WriteLogFile("Clase Spot : Error en la liberacion de Lineas (Sp_Libera_Lineas)")
    End If

    LiberacionLineas = True

End Function

Private Function GenerarInicio() As Boolean
    Dim Datos()
    Dim ddHabil     As Integer
    Dim nEstado     As Long
    Dim cEstado     As String
    
    GenerarInicio = False
    
    ddHabil = 0

    If BacFirstHabil(dFechaProceso) = cDatosgenerales.Fecha_Proceso Then
        ddHabil = 1
    End If

    Envia = Array()
    AddParam Envia, "ME"
    AddParam Envia, Format(dFechaProceso, "yyyymmdd")
    AddParam Envia, Format(dFechaProxima, "yyyymmdd")
    AddParam Envia, ddHabil
    If Bac_Sql_Execute("SP_ACTINICIODIA", Envia) Then
        If Bac_SQL_Fetch(Datos()) Then
            nEstado = Datos(1)
            cEstado = Datos(2)
        End If
    End If

    If nEstado <> 0 Then
        Call WriteLogFile("Clase Spot : Error en proceso de Apertura, cEstado = " & cEstado)
        Exit Function
    End If

    Call ProcesaBloqueo(" ")
    Call ActuaIni(8, "0")
    Call ActuaIni(9, "0")
    Call ActuaIni(10, "0")
    Call ActuaIni(0, "0")
    Call ActuaIni(1, "1")

    GenerarInicio = True

End Function

Private Function ProcesaBloqueo(Var As String) As Boolean
    Dim sMsg As String
    Dim Datos()
    
    ProcesaBloqueo = False
     
    Envia = Array(Var)
    If Not Bac_Sql_Execute("SP_PRECIERRE", Envia) Then
        ProcesaBloqueo = True
    End If
    If Bac_SQL_Fetch(Datos()) Then
        ProcesaBloqueo = (Datos(1) = 1)
    End If

End Function

Private Function ActuaIni(Pos%, ValPos$)

    If Not Graba_Switch(Pos, ValPos = "1") Then
        Call WriteLogFile("Clase Spot : Error al mover Switch. ( Pos = " & Pos% & " Valor = " & ValPos$ & " ).")
        Exit Function
    End If

End Function

Private Function Graba_Switch(Pos%, bEstado As Boolean) As Boolean
    Dim SQL     As String
    Dim Datos()
    
    SQL = "SP_GRABA_SWITCH  " & Pos
    SQL = SQL & ",'" & IIf(bEstado, "1", "0") & "'"
    SQL = SQL & ", " & cDatosgenerales.Entidad_Codigo
    
    Graba_Switch = True
    
    If miSQL.SQL_Execute(SQL) = 0 Then
        If miSQL.SQL_Fetch(Datos) = 0 Then
            If Datos(1) <> 0 Then
                Graba_Switch = False
            End If
        End If
    End If
    
End Function

Private Function DatosGenerales() As Boolean
    Dim Datos()

    DatosGenerales = False

    Envia = Array("ME")
    If Not Bac_Sql_Execute("SP_CARGAPARAMETROS", Envia) <> 0 Then
        Call WriteLogFile("Clase Spot : Error en proceso, Sp_CargaParametros.")
        Exit Function
    End If
    If Not Bac_SQL_Fetch(Datos()) Then
        Call WriteLogFile("Clase Spot : Error en proceso, Sp_CargaParametros... sin información")
        Exit Function
    End If

    cDatosgenerales.Fecha_Anterior = Format(Datos(4), gsc_FechaDMA)
    cDatosgenerales.Fecha_Proceso = Format(Datos(1), gsc_FechaDMA)
    cDatosgenerales.Fecha_Proximo = Format(Datos(5), gsc_FechaDMA)
    cDatosgenerales.Entidad_Rut = Val(Datos(33))
    cDatosgenerales.Entidad_DV = Datos(34)
    cDatosgenerales.Entidad_Codigo = Val(Datos(35))
    cDatosgenerales.Entidad_Nombre = Datos(6)
    cDatosgenerales.Entidad_BCCH = Val(Datos(42))
    cDatosgenerales.Entidad_SBIF = Val(Datos(43))
    cDatosgenerales.Entidad_Bolsa = "SUDA"
    cDatosgenerales.Entidad_Datatec = "BSUDA"
    cDatosgenerales.Valor_UF = CDbl(Datos(3))
    cDatosgenerales.Valor_Observado = CDbl(Datos(2))
    cDatosgenerales.Valor_Acuerdo = CDbl(Datos(7))
    
    cDatosgenerales.Inicio_Dia = (Mid(Datos(12), 1, 1) = 1)
    cDatosgenerales.DatosFinancieros = (Mid(Datos(12), 2, 1) = 1)
    cDatosgenerales.Paridad_Diaria = (Mid(Datos(12), 3, 1) = 1)
    cDatosgenerales.Paridad_Mensual = (Mid(Datos(12), 4, 1) = 1)
    cDatosgenerales.Posicion_Inicial = (Mid(Datos(12), 5, 1) = 1)
    cDatosgenerales.Cierre_Mesa = (Mid(Datos(12), 6, 1) = 1)
    cDatosgenerales.Aprobaciones = (Mid(Datos(12), 7, 1) = 1)
    cDatosgenerales.Contabilizacion = (Mid(Datos(12), 8, 1) = 1)
    cDatosgenerales.Fin_Dia = (Mid(Datos(12), 9, 1) = 1)
    cDatosgenerales.Rentabilidad = (Mid(Datos(12), 10, 1) = 1)
    cDatosgenerales.Tasa_Camara = CDbl(Datos(8))
    cDatosgenerales.Dias_Camara = Val(Datos(10))
    cDatosgenerales.Tasa_Overnight = CDbl(Datos(9))
    cDatosgenerales.Dias_Overnight = Val(Datos(11))

    cDatosgenerales.Banda_Minimo = CDbl(Datos(23))
    cDatosgenerales.Banda_Maximo = CDbl(Datos(24))

    cDatosgenerales.Pais_Feriado_Local = Right("00000" & Val(Datos(39)), 5)
    cDatosgenerales.Pais_Feriado_Externo = Right("00000" & Val(Datos(40)), 5)

    cDatosgenerales.Impuesto_Timbre = CDbl(Datos(41))

    cDatosgenerales.PosicionInicial = CDbl(Datos(32))
    cDatosgenerales.PrecioMeComp = CDbl(Datos(45))
    cDatosgenerales.PrecioMeVent = CDbl(Datos(46))

    cDatosgenerales.gsBAC_Fecp = cDatosgenerales.Fecha_Proceso
    cDatosgenerales.gsBAC_DolarOBs = cDatosgenerales.Valor_Observado
    cDatosgenerales.gsBAC_ValmonUF = cDatosgenerales.Valor_UF
    cDatosgenerales.gsBAC_Fecpx = cDatosgenerales.Fecha_Proximo
    cDatosgenerales.gsBAC_DolarAcuer = cDatosgenerales.Valor_Acuerdo
    cDatosgenerales.gsBAC_CodCliente = cDatosgenerales.Entidad_BCCH
    cDatosgenerales.gsBAC_LogDig = Datos(11)
    cDatosgenerales.gsBac_Version = Trim("BacCambio " & cDatosgenerales.gsBAC_Clien)
    cDatosgenerales.giBAC_RutEntidad = cDatosgenerales.Entidad_Rut
    cDatosgenerales.giBAC_DvEntidad = cDatosgenerales.Entidad_DV
    cDatosgenerales.gsBAC_Clien = cDatosgenerales.Entidad_Nombre
    cDatosgenerales.giBAC_Entidad = cDatosgenerales.Entidad_Codigo

    giBAC_RutEntidad = cDatosgenerales.Entidad_Rut

    DatosGenerales = True

End Function


Private Function Encript(xClave As String, xEncriptar As Boolean) As String
    Dim X           As Single
    Dim xPsw        As String
    Dim Letras      As String
    Dim Codigos     As String

    Letras = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890abcdefghijklmnopqrstuvwxyzÑñ#$%&()*+/=[\]_{}"
    Codigos = "RaMbKCgTrZHYFIPAuSiQVONmLfJWzGXEDqBUx_kpjcys{dn}ve]htwl[\`@?><Ññ1234567890;:.'~¿"
    xPsw = ""
    Encript = ""

    For X = 1 To Len(xClave)
        If xEncriptar Then
            xPsw = xPsw + Chr((Asc(Mid(Codigos, InStr(1, Letras, Mid(xClave, X, 1)), 1)) - X))
        Else
            xPsw = xPsw + Mid(Letras, InStr(1, Codigos, Chr(Asc(Mid(xClave, X, 1)) + X)), 1)
        End If
    Next

    Encript = xPsw
End Function

Private Function BacProxHabil(dFecha As String, plaza As String) As String
    dFecha = Format(DateAdd("d", 1, dFecha), gsc_FechaDMA)
    Do While Not BacEsHabil(dFecha, plaza)
        dFecha = Format(DateAdd("d", 1, dFecha), gsc_FechaDMA)
    Loop
    BacProxHabil = dFecha
End Function

Private Function BacEsHabil(cFecha As String, plaza As String) As Boolean
    Dim objFeriado As New clsFeriado
    Dim iAno       As Integer
    Dim iMes       As Integer
    Dim sDia       As String
    Dim n          As Integer

    sDia = BacDiaSem(cFecha)
    If sDia = "Sábado" Or sDia = "Domingo" Then
        BacEsHabil = False
        Exit Function
    End If

    iAno = DatePart("yyyy", cFecha)
    iMes = DatePart("m", cFecha)
    sDia = Format(DatePart("d", cFecha), "00")

    objFeriado.Leer iAno, plaza

    Select Case iMes
        Case 1:  n = InStr(objFeriado.feene, sDia)
        Case 2:  n = InStr(objFeriado.fefeb, sDia)
        Case 3:  n = InStr(objFeriado.femar, sDia)
        Case 4:  n = InStr(objFeriado.feabr, sDia)
        Case 5:  n = InStr(objFeriado.femay, sDia)
        Case 6:  n = InStr(objFeriado.fejun, sDia)
        Case 7:  n = InStr(objFeriado.fejul, sDia)
        Case 8:  n = InStr(objFeriado.feago, sDia)
        Case 9:  n = InStr(objFeriado.fesep, sDia)
        Case 10: n = InStr(objFeriado.feoct, sDia)
        Case 11: n = InStr(objFeriado.fenov, sDia)
        Case 12: n = InStr(objFeriado.fedic, sDia)
    End Select

    Set objFeriado = Nothing

    If n > 0 Then
        BacEsHabil = False
    Else
        BacEsHabil = True
    End If

End Function

Private Function BacDiaSem(sfec$) As String

    BacDiaSem = ""

    If IsDate(sfec$) Then
        Select Case Weekday(sfec$)
            Case 1: BacDiaSem = "Domingo"
            Case 2: BacDiaSem = "Lunes"
            Case 3: BacDiaSem = "Martes"
            Case 4: BacDiaSem = "Miércoles"
            Case 5: BacDiaSem = "Jueves"
            Case 6: BacDiaSem = "Viernes"
            Case 7: BacDiaSem = "Sábado"
        End Select

    End If
    
End Function

Private Function BacFirstHabil(dFecha$) As String
    BacFirstHabil = Format("01/" + Str(DatePart("m", dFecha)) + gsc_FechaSeparador + Str(DatePart("yyyy", dFecha)), gsc_FechaDMA)

    Do While Not BacEsHabil(BacFirstHabil, "00997")
        BacFirstHabil = Format(DateAdd("d", 1, BacFirstHabil), gsc_FechaDMA)
    Loop
End Function

Private Function BacCtrlTransMonto(xMonto As Variant) As String
   BacCtrlTransMonto = xMonto
End Function

Private Function BacDiv(n1 As Double, n2 As Double) As Double
    If n2 = 0 Then
        BacDiv = 0
    Else
        BacDiv = n1 / n2
    End If
End Function

Private Function WriteLogFile(ByVal sLogEvento As String)
    On Error GoTo ErrWrite
    Dim dFecha  As String
    Dim hFile%

    If Len(cPathFileLog) = 0 Then
        Exit Function
    End If

    Let dFecha = Format(Date, "dd.mm.yyyy")
    
    hFile% = FreeFile

    Open cPathFileLog & dFecha & "_LogInicios.log" For Append Access Write Shared As #hFile%
    
    Write #hFile%, Format$(Now, "dd/mm/yyyy hh:mm:ss") & ": " & sLogEvento
    
    Close #hFile%

Exit Function
ErrWrite:
    
End Function

