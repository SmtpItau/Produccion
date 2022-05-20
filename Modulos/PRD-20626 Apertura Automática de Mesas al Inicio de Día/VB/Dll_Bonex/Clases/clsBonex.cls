VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsBonex"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Public Type Valores_Monedas
        vmcodigo            As Integer
        vmdescripcion       As String
        vmvalor             As Double
        vmvalorcompra       As Double
        vmvalorventa        As Double
        vmValorProceso      As Double
        vmValorProximo      As Double
End Type
Public Type nValores_Monedas
        dValoresMonedas()   As Valores_Monedas
End Type

Private Type DatosGenerales
        FechaAnterior       As String
        FechaProceso        As String
        FechaProxima        As String
        InicioDia           As Integer
End Type
Private cDatosgenerales     As DatosGenerales

Private dFechaProceso       As String
Private dFechaProxima       As String
Private cPathFileLog        As String

Public DllParametros        As New Obj_Parametros.clsParametros

Private Function BAC_Conection(ByVal iMode As Integer, ByVal cServerName As String, ByVal cDataBaseName As String, ByVal cUserName As String, ByVal cPassword As String, ByVal nLoginTimeOut As Integer, ByVal nQueryTimeOut As Integer, ByVal cBaseLineas As String) As Boolean
    Let BAC_Conection = False

    Let miSQL.HostName = "dllInicioBonex"
    Let miSQL.Application = "Inversiones al Exterior"
    Let gsBac_LineasDB = cBaseLineas

    Let miSQL.ConnectionMode = iMode
    Let miSQL.ServerName = cServerName
    Let miSQL.DatabaseName = cDataBaseName
    Let miSQL.Login = cUserName
    Let miSQL.Password = Encript(Trim(cPassword), False)
    Let miSQL.LoginTimeOut = nLoginTimeOut
    Let miSQL.QueryTimeOut = nQueryTimeOut

    If miSQL.SQL_Coneccion() = False Then
        Let BAC_Conection = False
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
        Call WriteLogFile("Clase Bonex : Conexion ha fallado.")
        Exit Function
    End If

     Let DllParametros.PathFileLog = cPathFileLog
    Call DllParametros.Conectar(iMode, cServerName, "BacParamSuda", cUserName, cPassword, nLoginTimeOut, nQueryTimeOut)

    '-> Datos Generales
    If DatosGenerales = False Then
        Call WriteLogFile("Clase Bonex : Error en la Carga de Datos Generales")
        Exit Function
    End If

    dFechaProceso = cDatosgenerales.FechaProceso
    dFechaProxima = cDatosgenerales.FechaProxima
    
   ' '-> Leer Valores de Monedas
   ' If GenerarValoresMonedas(ValorMonedaProceso) = False Then
   '     Exit Function
   ' End If
    
    '-> Genera Inicio de Día
    Call DllParametros.Func_MoveEventControls(Bonex, 1, [En Ejecucion])
    If FuncInicioDia(ValorMonedaProceso) = False Then
        Call DllParametros.Func_MoveEventControls(Bonex, 1, [No Finalizado])
        Exit Function
    End If
    Call DllParametros.Func_MoveEventControls(Bonex, 1, [Finalizado Ok])
    
    Let ProcesoInicioDia = True

    '->  Cierra la Conexion
    Call miSQL.SQL_Close

    Call DllParametros.DesConectar

End Function

Private Function FuncInicioDia(ValorMonedaProceso As nValores_Monedas) As Boolean
    Dim objValoresMoneda    As Object

    FuncInicioDia = False
    
    If BacChkFechas() = False Then
        Call WriteLogFile("Clase Bonex : Error en proceso de Apertura, Error en Quequeo de las fechas ")
        Exit Function
    End If

    If Not Bac_Sql_Execute("BEGIN TRANSACTION") Then
        Call WriteLogFile("Clase Bonex : Error en proceso de Apertura, Error en inicio de la transaccion.")
        Exit Function
    End If

    '-> genera los Inicios (Cambio de Fechas)
    If Not GeneraInicioAC(dFechaProceso, dFechaProxima) Then
        Call Bac_Sql_Execute("ROLLBACK TRANSACTION")
        Exit Function
    End If

    '-> Actualiza la cartera con el devengo de anoche
    If FuncActualizaCartera = False Then
        Call Bac_Sql_Execute("ROLLBACK TRANSACTION")
        Exit Function
    End If

    '-> Genera Movimientos que inician en el día
    If FuncProcesaValutas = False Then
        Call Bac_Sql_Execute("ROLLBACK TRANSACTION")
        Exit Function
    End If

    '-> Genera el Dolar Contable en Tabla de Control
    If FuncActualizaDolarFinMes = False Then
        Call Bac_Sql_Execute("ROLLBACK TRANSACTION")
        Exit Function
    End If

    If Not Bac_Sql_Execute("COMMIT TRANSACTION") Then
        Call WriteLogFile("Bonex : Error en Commit Transaction")
        Exit Function
    End If

    FuncInicioDia = True

End Function


Private Function GeneraInicioAC(cFecpro As String, cFecprox As String)
    GeneraInicioAC = False
    
    Envia = Array(Format(cFecpro, "YYYYMMDD"), Format(cFecprox, "YYYYMMDD"))
    
    If Not Bac_Sql_Execute("EXECUTE SVA_IND_GRB_PAT", Envia) Then
        Call WriteLogFile("Clase Bonex : Error en proceso de Apertura, Error en ejecucion del proceso de apetura")
        Exit Function
    End If

    GeneraInicioAC = True
End Function

Private Function FuncActualizaCartera() As Boolean
    FuncActualizaCartera = False
    
    Envia = Array()
    AddParam Envia, Format(cDatosgenerales.FechaAnterior, "yyyymmdd")
    If Not Bac_Sql_Execute("SVA_IND_ACT_CAR", Envia) Then
        Call WriteLogFile("Clase Bonex : Error en proceso de Apertura, Error actualizacion de carteras")
        Exit Function
    End If
    
    Envia = Array()
    AddParam Envia, "BEX"
    If Not Bac_Sql_Execute("BacTraderSuda.dbo.SP_ACT_CARTERA_LIBRE_TRADING", Envia) Then
        Call WriteLogFile("Clase Bonex : Error en proceso de Apertura, Error actualizacion de carteras Libre de Trading")
        Let FuncActualizaCartera = True
    End If

    FuncActualizaCartera = True
End Function

Private Function FuncProcesaValutas() As Boolean
    FuncProcesaValutas = False

    If Not Bac_Sql_Execute("SVA_IND_ACT_VLU") Then
        Call WriteLogFile("Clase Bonex : Error en proceso de Apertura, Error actualizacion de valuetas.")
        Let FuncProcesaValutas = True
        Exit Function
    End If

    FuncProcesaValutas = True
End Function

Private Function FuncActualizaDolarFinMes() As Boolean
    Dim datos()

    FuncActualizaDolarFinMes = False

    If Month(cDatosgenerales.FechaProceso) <> Month(cDatosgenerales.FechaAnterior) Then

        Envia = Array()
        AddParam Envia, Format(cDatosgenerales.FechaAnterior, "yyyymmdd")
        If Bac_Sql_Execute("sp_ActDolarFinMes", Envia) Then
            If Bac_SQL_Fetch(datos()) <> 0 Then
                If datos(1) = 0 Then
                    Call WriteLogFile("Clase Bonex : Error en proceso de Apertura, Error en actualizacion de Dólar Fin de Mes.")
                    Exit Function
                End If
            End If
        End If

    End If
    
    FuncActualizaDolarFinMes = True

End Function


Private Function GenerarValoresMonedas(ValorMonedaProceso As nValores_Monedas) As Boolean
    Dim datos()
    Dim iIndice     As Integer

    GenerarValoresMonedas = False

    If BacChkFechas() = False Then
        Exit Function
    End If

    Envia = Array(Format(dFechaProceso, "yyyymmdd"), Format(dFechaProxima, "yyyymmdd"))
    If Not Bac_Sql_Execute("SVC_IND_LEE_MON", Envia) Then
        Call WriteLogFile("Bonex : Error en la lectura de monedas [SVC_IND_LEE_MON]")
        Exit Function
    End If
    Let iIndice = 0
    Do While Bac_SQL_Fetch(datos())
        ReDim Preserve ValorMonedaProceso.dValoresMonedas(iIndice)
        Let ValorMonedaProceso.dValoresMonedas(iIndice).vmcodigo = datos(1)
        Let ValorMonedaProceso.dValoresMonedas(iIndice).vmdescripcion = datos(2)
        Let ValorMonedaProceso.dValoresMonedas(iIndice).vmvalor = datos(3)
        Let ValorMonedaProceso.dValoresMonedas(iIndice).vmValorProceso = datos(3)
        Let ValorMonedaProceso.dValoresMonedas(iIndice).vmValorProximo = datos(4)

        Let iIndice = iIndice + 1
    Loop

    GenerarValoresMonedas = True

End Function


Private Function DatosGenerales() As Boolean
   Dim datos()
   
   DatosGenerales = False
   
   If Not Bac_Sql_Execute("SVC_IND_LEE_PAR") Then
        Call WriteLogFile("Clase Bonex : Error en Ejecucion de la Carga de Datos Generales")
        Exit Function
   End If
   If Bac_SQL_Fetch(datos()) Then
        cDatosgenerales.FechaAnterior = datos(1)
        cDatosgenerales.FechaProceso = datos(2)
        cDatosgenerales.FechaProxima = datos(2)
        cDatosgenerales.InicioDia = datos(3)

        cDatosgenerales.FechaProxima = Format(DateAdd("d", 1, cDatosgenerales.FechaProxima), "DD/MM/YYYY")
    End If

    While Weekday(cDatosgenerales.FechaProxima) = vbSunday Or Weekday(cDatosgenerales.FechaProxima) = vbSaturday Or Not BacEsHabil(cDatosgenerales.FechaProxima)
        cDatosgenerales.FechaProxima = DateAdd("d", 1, cDatosgenerales.FechaProxima)
    Wend
    
    DatosGenerales = True
    
End Function

Private Function BacEsHabil(cFecha As String) As Boolean
    Dim objFeriado As New clsFeriado
    Dim iAno       As Integer
    Dim iMes       As Integer
    Dim cDia       As String
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
    cDia = Format(DatePart("d", cFecha), "00")

    objFeriado.Leer iAno, gcPlaza

    Select Case iMes
        Case 1:  n = InStr(objFeriado.feene, cDia)
        Case 2:  n = InStr(objFeriado.fefeb, cDia)
        Case 3:  n = InStr(objFeriado.femar, cDia)
        Case 4:  n = InStr(objFeriado.feabr, cDia)
        Case 5:  n = InStr(objFeriado.femay, cDia)
        Case 6:  n = InStr(objFeriado.fejun, cDia)
        Case 7:  n = InStr(objFeriado.fejul, cDia)
        Case 8:  n = InStr(objFeriado.feago, cDia)
        Case 9:  n = InStr(objFeriado.fesep, cDia)
        Case 10: n = InStr(objFeriado.feoct, cDia)
        Case 11: n = InStr(objFeriado.fenov, cDia)
        Case 12: n = InStr(objFeriado.fedic, cDia)
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

Private Function BacChkFechas() As Boolean
   
   BacChkFechas = True

   If Not BacChkFecpro() Then
      BacChkFechas = False
      Exit Function
   End If

   If Not BacChkFecprx() Then
      BacChkFechas = False
   End If

End Function

Private Function BacChkFecpro() As Boolean

    If BacEsHabil(dFechaProceso) = True Then
        BacChkFecpro = True
    Else
        If Month(dFechaProceso) = Month(DateAdd("d", 1, dFechaProceso)) Then
            BacChkFecpro = False
        Else
            BacChkFecpro = True
        End If
    End If
End Function

Private Function BacChkFecprx() As Boolean
    
    If DateDiff("d", CDate(dFechaProceso), CDate(dFechaProxima)) <= 0 Then
        BacChkFecprx = False
        Exit Function
    End If

    If BacEsHabil(dFechaProxima) = True Then
        BacChkFecprx = True
    Else
        If Month(dFechaProxima) = Month(DateAdd("d", 1, dFechaProxima)) Then
            BacChkFecprx = False
        Else
            BacChkFecprx = True
        End If
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

