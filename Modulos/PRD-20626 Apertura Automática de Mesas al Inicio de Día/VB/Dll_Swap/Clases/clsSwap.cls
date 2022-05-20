VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsSwap"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Public Type Valores_Monedas
        vmcodigo            As Integer
        vmdescripcion       As String
        vmValor             As Double
        vmvalorcompra       As Double
        vmvalorventa        As Double
End Type
Public Type nValores_Monedas
        dValoresMonedas()   As Valores_Monedas
End Type

Private Type DatosGenerales
    Entidad                 As String
    Codigo                  As String
    Nombre                  As String
    Rut                     As Long
    direccion               As String
    comuna                  As String
    Ciudad                  As String
    telefono                As String
    fax                     As String
    FechaAnt                As String
    Fechaproc               As String
    fechaprox               As String
    Numero_Operacion        As Long
    rutbcch                 As String
    iniciodia               As Integer
    libor                   As Integer
    Paridad                 As Integer
    tasamtm                 As Integer
    tasas                   As Integer
    findia                  As Integer
    cierreMesa              As String
    gsBAC_Codigo            As String
    Devengo                 As Integer
    Contabilidad            As Integer
    CantidadReg             As Integer
    fecha_escritura_bco     As String
    notaria                 As String
    digrut                  As String
    DolarObs                As Double
    ValorUF                 As Double
End Type
Private cDatosgenerales     As DatosGenerales

Private dFechaProceso       As String
Private dFechaProxima       As String
Private cPathFileLog        As String
Public DllParametros        As New Obj_Parametros.clsParametros


Private Function BAC_Conection(ByVal iMode As Integer, ByVal cServerName As String, ByVal cDataBaseName As String, ByVal cUserName As String, ByVal cPassword As String, ByVal nLoginTimeOut As Integer, ByVal nQueryTimeOut As Integer, ByVal cBaseLineas As String) As Boolean
    Let BAC_Conection = False

    Let miSQL.HostName = "dllInicioSwap"
    Let miSQL.Application = "Bac-Swap"
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
        Call WriteLogFile("Clase Swap : Conexion ha fallado.")
        Exit Function
    End If


    Let DllParametros.PathFileLog = cPathFileLog
    Call DllParametros.Conectar(iMode, cServerName, "BacParamSuda", cUserName, cPassword, nLoginTimeOut, nQueryTimeOut)


    '-> Datos Generales
    If DatosGenerales = False Then
        Call WriteLogFile("Clase Swap : Error en la recuperacion de datos generales (1).")
        Exit Function
    End If
    
    dFechaProceso = BacProxHabil(cDatosgenerales.Fechaproc)
    dFechaProxima = BacProxHabil(dFechaProceso)
    
    '-> Genera Valores de Monedas
    Call DllParametros.Func_MoveEventControls(Swap, 1, [En Ejecucion])
    If GenerarValoresMonedas(ValorMonedaProceso) = False Then
        Call DllParametros.Func_MoveEventControls(Swap, 1, [No Finalizado])
    Else
        Call DllParametros.Func_MoveEventControls(Swap, 1, [Finalizado Ok])
    End If


    '-> Generacion de Inicio de Día
    Call DllParametros.Func_MoveEventControls(Swap, 2, [En Ejecucion])
    If FuncGenerarInicioDia = False Then
        Call DllParametros.Func_MoveEventControls(Swap, 2, [No Finalizado])
        Exit Function
    End If
    Call DllParametros.Func_MoveEventControls(Swap, 2, [Finalizado Ok])
    
    
    '-> Grabacion de Valores de Monedas
    If GrabarValoresMonedas(ValorMonedaProceso) = False Then
        Call WriteLogFile("Clase Swap : Error en el proceso de grabación de Valores de Monedas... Proceso Cancelado.")
       'Exit Function
    End If

    '-> Datos Generales
    If DatosGenerales = False Then
        Call WriteLogFile("Clase Swap : Error en la recuperacion de datos generales.")
       'Exit Function
    End If
    
    '-> Generador Automatico de ICP
    Call DllParametros.Func_MoveEventControls(Swap, 3, [En Ejecucion])
    If FuncGeneradorICP = False Then
        Call DllParametros.Func_MoveEventControls(Swap, 3, [Finalizado c / Warning])
        Call WriteLogFile("Clase Swap : Error en la generacion automatica de ICP.")
    Else
        Call DllParametros.Func_MoveEventControls(Swap, 3, [Finalizado Ok])
    End If

    '-> Limpia Tabla de Simulaciones
    Call DllParametros.Func_MoveEventControls(Swap, 4, [En Ejecucion])
    If FuncLimpiaTablaSim = False Then
        Call DllParametros.Func_MoveEventControls(Swap, 4, [Finalizado c / Warning])
    Else
        Call DllParametros.Func_MoveEventControls(Swap, 4, [Finalizado Ok])
    End If

    Let ProcesoInicioDia = True

    '->  Cierra la Conexion
    Call miSQL.SQL_Close

    Call DllParametros.DesConectar
End Function

Private Function FuncLimpiaTablaSim() As Boolean

    FuncLimpiaTablaSim = False

    If Not Bac_Sql_Execute("SP_RESET_TABLAS_SIM") Then
        Call WriteLogFile("Clase Swap : Error en la Reseteo de tablas sim.")
    End If

    FuncLimpiaTablaSim = True
    
End Function

Private Function GrabarValoresMonedas(ValorMonedaProceso As nValores_Monedas) As Boolean
    Dim iIndice       As Long
    
    GrabarValoresMonedas = False
    
    For iIndice = 0 To UBound(ValorMonedaProceso.dValoresMonedas)
        If CDbl(ValorMonedaProceso.dValoresMonedas(iIndice).vmcodigo) > 0 Then
            Envia = Array()
            AddParam Envia, CDbl(ValorMonedaProceso.dValoresMonedas(iIndice).vmcodigo)
            AddParam Envia, Format(dFechaProceso, "yyyymmdd")
            AddParam Envia, CDbl(ValorMonedaProceso.dValoresMonedas(iIndice).vmValor)
            If Not Bac_Sql_Execute("SP_GRABA_VALORESMONEDA", Envia) Then
                Screen.MousePointer = vbDefault
                Call WriteLogFile("Clase Swap : Error en el proceso de grabación de Valores de Monedas")
            End If
        End If
    Next iIndice
    
    GrabarValoresMonedas = True
End Function

Private Function GenerarValoresMonedas(ValorMonedaProceso As nValores_Monedas) As Boolean
    Dim SQL         As String
    Dim nRows       As Integer
    Dim AuxFecha    As Date
    Dim nIndice
    Dim Datos()

    GenerarValoresMonedas = False
    
    Envia = Array()
    AddParam Envia, "PCS"
    AddParam Envia, Format(dFechaProceso, "yyyymmdd")
    If Not Bac_Sql_Execute("SP_BUSCA_VALORES_MERCADO", Envia) Then
        Call WriteLogFile("Clase Swap : Error al determinar valores de monedas.")
        Exit Function
    End If
    
    Let nIndice = 0
    
    Do While Bac_SQL_Fetch(Datos())
        ReDim Preserve ValorMonedaProceso.dValoresMonedas(nIndice)
        Let ValorMonedaProceso.dValoresMonedas(nIndice).vmcodigo = Datos(3)
        Let ValorMonedaProceso.dValoresMonedas(nIndice).vmdescripcion = Datos(1)
        Let ValorMonedaProceso.dValoresMonedas(nIndice).vmValor = Datos(2)
        
        Let nIndice = nIndice + 1
    Loop

    GenerarValoresMonedas = True
End Function

Private Function FuncGeneradorICP() As Boolean
    Dim Datos()
    
    FuncGeneradorICP = False

    Envia = Array()
    If Not Bac_Sql_Execute("BacParamSuda..SP_GENERACION_AUTOMATICA_ICP") Then
        Call WriteLogFile("Clase Swap : Error en la generacion automatica de ICP.")
        Exit Function
    End If
    If Bac_SQL_Fetch(Datos()) Then
        If Datos(1) < 0 Then
            Call WriteLogFile("Clase Swap : Error en la generacion automatica de ICP.")
            Exit Function
        End If
    End If

    FuncGeneradorICP = True
End Function

Private Function FuncGenerarInicioDia() As Boolean
    FuncGenerarInicioDia = False

    Envia = Array()
    AddParam Envia, Format(dFechaProceso, "yyyymmdd")
    AddParam Envia, Format(dFechaProxima, "yyyymmdd")
    If Not Bac_Sql_Execute("SP_INICIODIA", Envia) Then
        lRet = True
        Select Case nRetorno
               Case -100: cTexto$ = "NO pudo actualizar estado de flujos"
               Case -101: cTexto$ = "NO pudo cargar registros en Cartera Historica"
               Case -102: cTexto$ = "NO pudo cargar registros en Archivo de Log"
               Case -103: cTexto$ = "NO pudo rebajar los Flujos Vencidos"
               Case -104: cTexto$ = "NO pudo Limpiar archivo de Movimientos del Día"
               Case -105: cTexto$ = "NO pudo Actualizar archivo de Parámetros"
               Case -110: cTexto$ = "NO pudo Liberar las operaciones con Garantías"
               Case Else: lRet = False
        End Select
        
        Call WriteLogFile("Clase Swap : Error en el proceso de apertura. ... " & cTexto$)
        
        If lRet Then
            Screen.MousePointer = vbDefault
            nProblemas = nProblemas + 1
            Call WriteLogFile("Clase Swap : Error en el proceso de apertura")
        End If
    End If
    
    FuncGenerarInicioDia = True
End Function


Private Function DatosGenerales() As Boolean
   Dim SQL        As String
   Dim Datos()

    Let DatosGenerales = False
   
    If Bac_Sql_Execute("SP_DATOSGENERALES") Then
        If Bac_SQL_Fetch(Datos()) Then
            cDatosgenerales.Entidad = Datos(1)
            cDatosgenerales.Codigo = Datos(2)
            cDatosgenerales.Nombre = Datos(3)
            cDatosgenerales.Rut = Val(Datos(4))
            cDatosgenerales.direccion = Datos(5)
            cDatosgenerales.comuna = Datos(6)
            cDatosgenerales.Ciudad = Datos(7)
            cDatosgenerales.telefono = Datos(8)
            cDatosgenerales.fax = Datos(9)
            cDatosgenerales.FechaAnt = Datos(10)
            cDatosgenerales.Fechaproc = Datos(11)
            cDatosgenerales.fechaprox = Datos(12)
            cDatosgenerales.Numero_Operacion = Datos(13)
            cDatosgenerales.rutbcch = Datos(14)
            cDatosgenerales.iniciodia = Val(Datos(15))
            cDatosgenerales.libor = Datos(16)
            cDatosgenerales.Paridad = Datos(17)
            cDatosgenerales.tasamtm = Datos(18)
            cDatosgenerales.tasas = Datos(19)
            cDatosgenerales.findia = Val(Datos(20))
            cDatosgenerales.cierreMesa = Val(Datos(21))
            cDatosgenerales.gsBAC_Codigo = Datos(22)
            cDatosgenerales.Devengo = Datos(23)
            cDatosgenerales.Contabilidad = Datos(24)
            cDatosgenerales.CantidadReg = Datos(25)
            cDatosgenerales.fecha_escritura_bco = Datos(26)
            cDatosgenerales.notaria = Datos(27)
            cDatosgenerales.digrut = Datos(28)
        End If
    End If
        
    cDatosgenerales.DolarObs = ValorMoneda(994, cDatosgenerales.Fechaproc)
    cDatosgenerales.ValorUF = ValorMoneda(998, cDatosgenerales.Fechaproc)
    
    Let DatosGenerales = True

End Function

Private Function ValorMoneda(CodMon As Integer, fechaMon) As Double
    Dim ValorMon As New clsMoneda

    ValorMoneda = ValorMon.ValorMoneda(CodMon, CStr(fechaMon))

    Set ValorMon = Nothing
End Function

Private Function BacProxHabil(xFecha As String) As String
    Dim dFecha As String
    
    dFecha = xFecha
    dFecha = Format(DateAdd("d", 1, dFecha), gsc_FechaDMA)
    Do While Not BacEsHabil(dFecha)
        dFecha = Format(DateAdd("d", 1, dFecha), gsc_FechaDMA)
    Loop

    BacProxHabil = dFecha
End Function

Private Function BacEsHabil(cFecha As String) As Boolean
    Dim objFeriado As New clsFeriado
    Dim iAno       As Integer
    Dim iMes       As Integer
    Dim sDia       As String
    Dim gcPlaza    As String
    Dim n          As Integer
   
    gcPlaza = "00006"
   
    sDia = BacDiaSem(cFecha)
    If sDia = "Sábado" Or sDia = "Domingo" Then
        BacEsHabil = False
        Exit Function
    End If
   
    iAno = DatePart("yyyy", cFecha)
    iMes = DatePart("m", cFecha)
    sDia = Format(DatePart("d", cFecha), "00")
   
    objFeriado.Leer iAno, gcPlaza
   
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

