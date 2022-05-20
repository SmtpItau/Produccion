VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsForward"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Private VerSql          As String
Private Envia()         As Variant

Public Type Valores_Monedas
        vmcodigo        As Integer
        vmdescripcion   As String
        vmValor         As Double
        vmvalorcompra   As Double
        vmvalorventa    As Double
End Type
Public Type nValores_Monedas
    dValoresMonedas() As Valores_Monedas
End Type

Private Type DatosGenerales
    ACrutprop           As Long
    ACdigprop           As String
    ACnomprop           As String
    ACCodClie           As Integer
    ACfecante           As String
    ACfecproc           As String
    ACfecprox           As String
    ACsucmesa           As Integer
    ACofimesa           As Integer
    ACcodmonloc         As Integer
    ACcodmondol         As Integer
    ACcodmonuf          As Integer
    ACcodmonobs         As Integer
    ACnumdecimales      As Integer
    ACpais              As Integer
    ACplaza             As Integer
    ACcodempresa        As Integer
    ACsw_pd             As String
    ACsw_fd             As String
    ACsw_ciemefwd       As String
    ACsw_devenfwd       As String
    ACsw_contafwd       As String
    ACvaloruf           As Double
    AcValDolObs         As Double
    ACDirProp           As String
    ACFono              As String
    ACFax               As String
    ACnombre_notaria    As String
    ACcomuna            As String
    ACciudad            As String
End Type
Private cDatosgenerales As DatosGenerales

Private dFechaProceso   As String
Private dFechaProxima   As String
Private SebService      As Boolean

Private cPathFileLog    As String

Public DllParametros    As New Obj_Parametros.clsParametros

Private Sub Class_Initialize()
    Let PathIniFile = ""
    Let txtfecpro = ""
    Let txtfecprox = ""
End Sub

Private Function BAC_Conection(ByVal iMode As Integer, ByVal cServerName As String, ByVal cDataBaseName As String, ByVal cUserName As String, ByVal cPassword As String, ByVal nLoginTimeOut As Integer, ByVal nQueryTimeOut As Integer, ByVal cBaseLineas As String) As Boolean
    Let BAC_Conection = False

    Let miSQL.HostName = "dllInicioForward"
    Let miSQL.Application = "Bac-Forward"
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
        Call WriteLogFile("Clase Forward : Conexion ha fallado.")
        Exit Function
    End If

    '-> Carga Clase con Datos Generales
    If DatosGenerales = False Then
        Call WriteLogFile("Clase Forward : Error en la recuperacion de Datos Generales.")
        Exit Function
    End If
    
    Let DllParametros.PathFileLog = cPathFileLog
    Call DllParametros.Conectar(iMode, cServerName, "BacParamSuda", cUserName, cPassword, nLoginTimeOut, nQueryTimeOut)
    
    '-> Lee los valores de moneda que presentaba en Pantalla

    Call DllParametros.Func_MoveEventControls(Forward, 1, [En Ejecucion])
    If CargarInicioDia(ValorMonedaProceso) = False Then
        Call DllParametros.Func_MoveEventControls(Forward, 1, [Finalizado c / Warning])
        Call WriteLogFile("Clase Forward : Error en la carga de valores para inicio de día, Proceso finalizo con Warning")
    Else
        Call DllParametros.Func_MoveEventControls(Forward, 1, [Finalizado Ok])
    End If
    
    If cDatosgenerales.ACsw_fd = "1" Then
        Let dFechaProceso = Format(cDatosgenerales.ACfecprox, "DD-MM-YYYY")
    Else
        Let dFechaProceso = Format(cDatosgenerales.ACfecproc, "DD-MM-YYYY")
    End If

    Let dFechaProxima = Format(BacProxHabil(dFechaProceso), "DD-MM-YYYY")


    '-> Genera Inicio de Día y Graba Valores de Monedas
    Call DllParametros.Func_MoveEventControls(Forward, 2, [En Ejecucion])
    If FuncGrabarInicioDia(ValorMonedaProceso) = False Then
        Call WriteLogFile("Clase Forward : Error en el proceso de Apertura, Proceso no Finalizado.")
        Call DllParametros.Func_MoveEventControls(Forward, 2, [No Finalizado])
        Exit Function
    End If
    Call DllParametros.Func_MoveEventControls(Forward, 2, [Finalizado Ok])


    '-> Actualiza la Tabla de Datos generales despues de haber grabado el Inicio y los Valores de Monedas
    If DatosGenerales = False Then
        Call WriteLogFile("Clase Forward : Error en el proceso de recuperacion de Datos Generales,  Proceso no Finalizado.")
        Exit Function
    End If


    '-> Devengo y generacion de Compensaciones
    Call DllParametros.Func_MoveEventControls(Forward, 3, [En Ejecucion])
    If Devengamiento(1) = False Then
        Call DllParametros.Func_MoveEventControls(Forward, 3, [No Finalizado])
        Call WriteLogFile("Clase Forward : Error en el proceso de Devengamiento, Proceso finalizo con Warning.")
    Else
        Call DllParametros.Func_MoveEventControls(Forward, 3, [Finalizado Ok])
    End If


    '-> Traspaso de Vencimientos
    Call DllParametros.Func_MoveEventControls(Forward, 4, [En Ejecucion])
    If FuncTraspasoOperaciones = False Then
        Call DllParametros.Func_MoveEventControls(Forward, 4, [Finalizado c / Warning])
        Call WriteLogFile("Clase Forward : Error en el proceso de Traspaso de Operaciones, Proceso finalizo con Warning.")
    Else
        Call DllParametros.Func_MoveEventControls(Forward, 4, [Finalizado Ok])
    End If

    
    '-> Carga Vencimientos
    Call DllParametros.Func_MoveEventControls(Forward, 5, [En Ejecucion])
    If FuncCargaVencimientos = False Then
        Call DllParametros.Func_MoveEventControls(Forward, 5, [Finalizado c / Warning])
        Call WriteLogFile("Clase Forward : Error en el proceso Carga de Vencimientos, Proceso finalizado con Warning.")
    Else
        Call DllParametros.Func_MoveEventControls(Forward, 5, [Finalizado Ok])
    End If


    '-> Vencimientos Ticket Intra Mesa
    Call DllParametros.Func_MoveEventControls(Forward, 6, [En Ejecucion])
    If VenceOPTicket = False Then
        Call DllParametros.Func_MoveEventControls(Forward, 6, [Finalizado c / Warning])
        Call WriteLogFile("Clase Forward : Error en el proceso Carga de Vencimientos Ticket, Proceso ha finalizado con Warning.")
    Else
        Call DllParametros.Func_MoveEventControls(Forward, 6, [Finalizado Ok])
    End If

    Let ProcesoInicioDia = True

    '->  Cierra la Conexion
    Call miSQL.SQL_Close

    Call DllParametros.DesConectar
End Function


Private Function VenceOPTicket() As Boolean
    Dim Datos()

    VenceOPTicket = False

    If Not Bac_Sql_Execute("SP_VENCEOPETKINMESA", Array(Format(dFechaProceso, "yyyymmdd"))) Then
        Call WriteLogFile("Clase Forward : Error en el proceso Carga de Vencimientos Ticket, Error en Ejecución VenceOpeTkinMesa.")
        VenceOPTicket = True
        Exit Function
    End If

    VenceOPTicket = True
End Function


Private Function FuncCargaVencimientos() As Boolean
    On Error GoTo Error_Carga_Vctos
    Dim Datos()
    Dim Datos1()
    
    FuncCargaVencimientos = False
   
    'Elimina las Operaciones que vencen HOY
    '----------------------------------------------

    Envia = Array()
    AddParam Envia, Format(dFechaProceso, "yyyymmdd")
    If Bac_Sql_Execute("SP_CARGAVENCIMIENTOS", Envia) Then
        Liberar = True
        Do While miSQL.SQL_Fetch(Datos) = 0
            Conta = Conta + 1
            ReDim Preserve Datos1(Conta)
            Datos1(Conta) = Val(Datos(2))
        Loop
        For i = 1 To Conta
            Call Lineas_Anular("BFW", Val(Datos1(i)))
            Call LiberaOpeGarantias("BFW", Val(Datos1(i)))
        Next
    Else
        Call WriteLogFile("Clase Forward : Error en el proceso Carga de Vencimientos, Error sobre la ejecución de Sp_CargaVencimientos.")
        Liberar = True
    End If

    On Error GoTo 0
    FuncCargaVencimientos = True
    
Exit Function
Error_Carga_Vctos:

    Call WriteLogFile("Clase Forward : Error en el proceso Carga de Vencimientos, Error inesperado : " & Err.Description)

    On Error GoTo 0

End Function


Private Function CargarInicioDia(ValorMonedaProceso As nValores_Monedas) As Boolean
    On Error GoTo Error_Proceso
    Dim Datos()
    Dim nIndice
    
    CargarInicioDia = False
    
    If Not Bac_Sql_Execute("SP_MDVMLEER", Array(Format(cDatosgenerales.ACfecprox, "yyyymmdd"))) Then
        Call WriteLogFile("Clase Forward : Error en la carga de valores para inicio de día")
        Exit Function
    End If
    
    Let nIndice = 0
    
    Do While Bac_SQL_Fetch(Datos())
        ReDim Preserve ValorMonedaProceso.dValoresMonedas(indice)
        Let ValorMonedaProceso.dValoresMonedas(indice).vmcodigo = Datos(1)
        Let ValorMonedaProceso.dValoresMonedas(indice).vmdescripcion = Datos(2)
        Let ValorMonedaProceso.dValoresMonedas(indice).vmValor = Datos(3)
        Let ValorMonedaProceso.dValoresMonedas(indice).vmvalorcompra = Datos(4)
        Let ValorMonedaProceso.dValoresMonedas(indice).vmvalorventa = Datos(5)

        Let indice = indice + 1
    Loop
    
    CargarInicioDia = True
Exit Function
Error_Proceso:
    
    Call WriteLogFile("Clase Forward : Error en la carga de valores para inicio de día... " & Err.Description)
    
End Function


Private Function FuncGrabarInicioDia(ValorMonedaProceso As nValores_Monedas) As Boolean
    On Error GoTo Errr_Grabacion_Inicio
    Dim iRow                As Long
    Dim cCodigo             As Integer
    Dim nValor              As Double
    Dim actualizacion       As Boolean
    Dim objValoresMoneda    As Object
    Dim IdOpcion            As Integer
    Dim Conta               As Integer
    Dim Liberar             As Boolean
    Dim i                   As Integer
    Dim Msg                 As String
    Dim Hora_Inicia
    Dim Hora_Termina
    Dim Datos()
    Dim Datos1()

    Let FuncGrabarInicioDia = False

    If BacChkFechas() = False Then
        Call WriteLogFile("Clase Forward : Error en el proceso de Apertura, Error en el chequeo de fechas")
        On Error GoTo 0
        Exit Function
    End If

    If Not BacBeginTransaction() Then
        Call WriteLogFile("Clase Forward : Error en el proceso de Apertura, Error al iniciar la transacción")
        On Error GoTo 0
        Exit Function
    End If

    Envia = Array()
    AddParam Envia, Format(dFechaProceso, "yyyymmdd")
    AddParam Envia, Format(dFechaProxima, "yyyymmdd")
    If Not Bac_Sql_Execute("SP_MDACINICIODIA", Envia) Then
        If Not BacRollBackTransaction() Then
            Call WriteLogFile("Clase Forward : Error en el proceso de Apertura, Error en proceso Rollback Transaction")
        End If
        Call WriteLogFile("Clase Forward : Error en el proceso de Apertura, Error al Ejecutar inicio de día")
        On Error GoTo 0
        Exit Function
    End If

    For iRow = 0 To UBound(ValorMonedaProceso.dValoresMonedas)
        Envia = Array()
        AddParam Envia, CDbl(ValorMonedaProceso.dValoresMonedas(iRow).vmcodigo)
        AddParam Envia, CDbl(ValorMonedaProceso.dValoresMonedas(iRow).vmValor)
        AddParam Envia, 0
        AddParam Envia, 0
        AddParam Envia, Format(dFechaProceso, "yyyymmdd")
        If Not Bac_Sql_Execute("SP_MDVMGRABAR", Envia) Then
            If Not BacRollBackTransaction() Then
                Call WriteLogFile("Clase Forward : Error en el proceso de Grabación de Monedas, Error en proceso Rollback Transaction.")
            End If
            Call WriteLogFile("Clase Forward : Error en el proceso de Grabación de Monedas, Valor : " & Trim(ValorMonedaProceso.dValoresMonedas(iRow).vmcodigo) & " : " & Trim(ValorMonedaProceso.dValoresMonedas(iRow).vmValor))
            On Error GoTo 0
            Exit Function
        End If
    Next iRow

    If Not BacCommitTransaction() Then
        Call WriteLogFile("Clase Forward : Error en el proceso de Aperturas, Error en proceso Commit Transaction. ")
        Exit Function
    End If

    Let FuncGrabarInicioDia = True
Exit Function
Errr_Grabacion_Inicio:

    Call WriteLogFile("Clase Forward : Error en el proceso de Aperturas, Error inesperado : " & Err.Description)

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
        BacChkFecpro = False
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
        BacChkFecprx = False
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

'------------------------------------------------------------------------------------------------

Private Function DatosGenerales() As Boolean
    Dim Datos()
    
    Let DatosGenerales = False
    
    If Bac_Sql_Execute("DBO.SP_DATOSGENERALES") Then
        If Bac_SQL_Fetch(Datos()) Then
        
            Let cDatosgenerales.ACrutprop = Datos(1)
            Let cDatosgenerales.ACdigprop = Datos(2)
            Let cDatosgenerales.ACnomprop = Datos(3)
            Let cDatosgenerales.ACfecante = Datos(4)
            Let cDatosgenerales.ACfecproc = Datos(5)
            Let cDatosgenerales.ACfecprox = Datos(6)
            Let cDatosgenerales.ACsucmesa = Datos(7)
            Let cDatosgenerales.ACofimesa = Datos(8)
            Let cDatosgenerales.ACcodmonloc = Datos(9)
            Let cDatosgenerales.ACcodmondol = Datos(10)
            Let cDatosgenerales.ACcodmonuf = Datos(11)
            Let cDatosgenerales.ACcodmonobs = Datos(12)
            Let cDatosgenerales.ACnumdecimales = Datos(13)
            Let cDatosgenerales.ACpais = Datos(14)
            Let cDatosgenerales.ACplaza = Datos(15)
            Let cDatosgenerales.ACcodempresa = Datos(16)
            Let cDatosgenerales.ACsw_pd = Datos(17)
            Let cDatosgenerales.ACsw_fd = Datos(18)
            Let cDatosgenerales.ACsw_ciemefwd = Datos(19)
            Let cDatosgenerales.ACsw_devenfwd = Datos(20)
            Let cDatosgenerales.ACsw_contafwd = Datos(21)
            Let cDatosgenerales.ACvaloruf = Datos(22)
            Let cDatosgenerales.AcValDolObs = Datos(23)
            Let cDatosgenerales.ACCodClie = Datos(24)
            Let cDatosgenerales.ACDirProp = Datos(25)
            Let cDatosgenerales.ACFono = Datos(26)
            Let cDatosgenerales.ACFax = Datos(27)
            Let cDatosgenerales.ACnombre_notaria = Datos(28)
            Let cDatosgenerales.ACcomuna = Datos(29)
            Let cDatosgenerales.ACciudad = Datos(30)

            Let DatosGenerales = True
        End If
    Else
        Call WriteLogFile("Forward : Error en procedimiento [DBO.SP_DATOSGENERALES]")
    End If
    
End Function


Private Function BacProxHabil(xFecha As String) As String
   Dim dFecha As String

   dFecha = xFecha
   dFecha = DateAdd("d", 1, dFecha)

   Do While Not BacEsHabil(dFecha)
      dFecha = Format(DateAdd("d", 1, dFecha), gsc_FechaDMA)
   Loop

   BacProxHabil = dFecha
End Function

Private Function BacEsHabil(cFecha As String, Optional gsPlaza As String) As Boolean
    Dim objFeriado As New clsFeriado
    Dim iAno       As Integer
    Dim iMes       As Integer
    Dim sDia       As String
    Dim gcPlaza    As String
    Dim n          As Integer
    
    ' Temporalmente solo CHILE.-
    '-----------------
    
    If gsPlaza = "" Then
       gcPlaza = Format(cDatosgenerales.ACpais, "00000")
    Else
       gcPlaza = Format(gsPlaza, "00000")
    End If
   
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
'------------------------------------------------------------------------------------------------


Private Function Devengamiento(Optional iDesdeIniDia As Integer) As Boolean
    Dim cRes                    As String
    Dim cMsg                    As String
    Dim SQL                     As String
    Dim dFecPro                 As String
    Dim dFecProAnt              As String
    Dim dFecProxPro             As String
    Dim cFirstHabil             As String
    Dim cLastHabil              As String
    Dim dUltDMesPro             As String
    Dim dUltDMesAnt             As String
    Dim dUltHabMesAnt           As String
    Dim nValUF_Ant              As Double
    Dim nValUF_Pro              As Double
    Dim nValUsd_Pro             As Double
    Dim nValUsd_Ant             As Double
    Dim nValUF_UDM              As Double
    Dim nValUsd_UDMA            As Double
    Dim nOk                     As Integer
    Dim sNameProcDevengo        As String
    Dim Datos()

    Set clsValorMoneda = New clsValorMoneda

    Let Devengamiento = False                        'Por Defecto Rechazado
    
    Let nOk = 0                                      'Por defecto Rechazado
   
    Let dFecPro = Format$(cDatosgenerales.ACfecproc, "dd-mm-yyyy")    'Fecha de Proceso
    
    Let cFirstHabil = "NO"
    Let cLastHabil = "NO"

    If BacFirstHabil(dFecPro) Then
        cFirstHabil = "SI"
    End If

    If BacLastHabil(dFecPro) Then
        cLastHabil = "SI"
    End If
   
    dUltDMesPro = BacUltimoDia(dFecPro, "SI")    'Ultimo Día Mes de Proceso
    dUltDMesAnt = BacUltimoDia(dFecPro, "NO")    'Ultimo Día Mes de Proceso Anterior
    dUltHabMesAnt = dUltDMesAnt                  'Ultimo Día Hábil Mes Anterior
    dFecProxPro = BacProxHabil(dFecPro)          'Siguiente Día Hábil
    dFecProAnt = BacPrevHabil(dFecPro)           'Día Hábil Anterior

    If Not BacEsHabil(dUltHabMesAnt) Then
        dUltHabMesAnt = BacPrevHabil(dUltHabMesAnt)
    End If
   
    Call clsValorMoneda.Leer(cDatosgenerales.ACcodmonobs, dFecPro)                               'Dólar Observado del Día de Proceso
    nValUsd_Pro = clsValorMoneda.vmValor
    
    Call clsValorMoneda.Leer(cDatosgenerales.ACcodmonobs, dFecProAnt)                            'Dólar Observado del Día Anterior
    nValUsd_Ant = clsValorMoneda.vmValor
    
    Call clsValorMoneda.Leer(cDatosgenerales.ACcodmonobs, dUltHabMesAnt)                         'Dólar Observado Ultimo Día Habil Mes Anterior
    nValUsd_UDMA = clsValorMoneda.vmValor
    
    Call clsValorMoneda.Leer(cDatosgenerales.ACcodmonuf, dFecPro)         'Valor UF del Día
    nValUF_Pro = clsValorMoneda.vmValor
    
    Call clsValorMoneda.Leer(cDatosgenerales.ACcodmonuf, dFecProAnt)
    nValUF_Ant = clsValorMoneda.vmValor                                  'Valor UF Día Anterior
    
    If cFirstHabil = "SI" Then
        Call clsValorMoneda.Leer(cDatosgenerales.ACcodmonuf, dUltDMesAnt)
        nValUF_Ant = clsValorMoneda.vmValor                               'Para el Ajuste al Inicio del Mes
    End If
    
    Call clsValorMoneda.Leer(cDatosgenerales.ACcodmonuf, dUltDMesPro)
    nValUF_UDM = clsValorMoneda.vmValor                                  'UF del Ultimo Día del Mes
                                                                        'Sólo se Ocupa el último día hábil del Mes
    Screen.MousePointer = vbHourglass
   
   'Llamar proceso de Devengamiento
   '----------------------------------------------

    Envia = Array()
    AddParam Envia, Format(dFecPro, "yyyymmdd")
    AddParam Envia, Format(dFecProAnt, "yyyymmdd")
    AddParam Envia, Format(dFecProxPro, "yyyymmdd")
    AddParam Envia, Format(dUltDMesPro, "yyyymmdd")
    AddParam Envia, Format(dUltDMesAnt, "yyyymmdd")
    AddParam Envia, cLastHabil
    AddParam Envia, cFirstHabil
    AddParam Envia, nValUF_Ant
    AddParam Envia, nValUF_Pro
    AddParam Envia, nValUF_UDM
    AddParam Envia, nValUsd_Pro
    AddParam Envia, nValUsd_Ant
    AddParam Envia, nValUsd_UDMA
    AddParam Envia, CDbl(iDesdeIniDia)
    If Bac_Sql_Execute("SP_DEVENGAMIENTO", Envia) Then
        If miSQL.SQL_Fetch(Datos()) = 0 Then
            If Datos(1) = -1 Then
                Call WriteLogFile("Clase Forward : Error en el proceso de Devengamiento, Error Sql : " & Trim(Datos(2)))
                Exit Function
            End If
            If Datos(1) = "OK" Then
                nOk = 1
                Devengamiento = True
            End If
        End If
    Else
        Call WriteLogFile("Clase Forward : Error en el proceso de Devengamiento, Error en la ejecución")
        nOk = 0
        Devengamiento = False
    End If

    '--------------------------------------------------------------------------------------------------
    '----------- DEVENGAMIENTO CARTERA DIA ANTERIOR CON TASAS DEL DIA (RESULTADO BACK TEST) -----------
    '--------------------------------------------------------------------------------------------------
    
    Envia = Array()
    AddParam Envia, Format(dFecProAnt, "yyyymmdd") ' fecha de proceso
    AddParam Envia, Format(dFecProAnt, "yyyymmdd") ' fecha anterior se genera en el procedimiento
    AddParam Envia, Format(dFecPro, "yyyymmdd")    ' fecha proxima de proceso
    AddParam Envia, Format(dUltDMesPro, "yyyymmdd")
    AddParam Envia, Format(dUltDMesAnt, "yyyymmdd")
    AddParam Envia, cLastHabil
    AddParam Envia, cFirstHabil
    AddParam Envia, nValUF_Ant
    AddParam Envia, nValUF_Pro
    AddParam Envia, nValUF_UDM
    AddParam Envia, nValUsd_Pro
    AddParam Envia, nValUsd_Ant
    AddParam Envia, nValUsd_UDMA
    AddParam Envia, 0
    If Bac_Sql_Execute("SP_DEVENGAMIENTO_BACK_TEST", Envia) Then
        If miSQL.SQL_Fetch(Datos()) = 0 Then
            If Datos(1) = -1 Then
                Call WriteLogFile("Clase Forward : Error en el proceso de Devengamiento Back Test, Error Sql : " & Trim(Datos(2)))
                Devengamiento = True
            End If
            If Datos(1) = "OK" Then
                nOk = 1
                Devengamiento = True
            End If
        End If
    Else
        Call WriteLogFile("Clase Forward : Error en el proceso de Devengamiento Back Test, Error en la Ejecución")
        nOk = 0
        Devengamiento = True
    End If


    If LEEWEBSERVICES Then
        If Bac_Sql_Execute("SP_UDP_CARTERA_VS_TURING") Then
            If miSQL.SQL_Fetch(Datos()) = 0 Then
                If Datos(1) = -1 Then
                    Call WriteLogFile("Clase Forward : Error en el proceso de Actualizacion Turing, Error en Sql : (Sp_UDP_Cartera_vs_Turing)")
                    Let Devengamiento = True
                End If
                If Datos(1) = "OK" Then
                    nOk = 1
                    Let Devengamiento = True
                End If
            End If
        Else
            nOk = 0
            Call WriteLogFile("Clase Forward : Error en el proceso de Actualizacion Turing ... (Sp_UDP_Cartera_vs_Turing)")
            Let Devengamiento = True
        End If
    End If
    
    Screen.MousePointer = vbDefault
   
End Function

Private Function FuncTraspasoOperaciones() As Boolean
   Dim Datos()
   Dim sCadena As String

    FuncTraspasoOperaciones = False

    If Not Bac_Sql_Execute("SP_TRASPASOOPERACIONES") Then
        Call WriteLogFile("Clase Forward : Error en el proceso de Traspaso de Operaciones, Error en la Ejecución")
        Exit Function
    End If
    If Bac_SQL_Fetch(Datos()) Then
        If Datos(1) < 0 Then
            Call WriteLogFile("Clase Forward : Error en el proceso de Traspaso de Operaciones, Error en Sql.")
            Exit Function
        End If
    End If
    sCadena = "Parametros Grabados en Forma Correcta."
    
    FuncTraspasoOperaciones = True
End Function


Private Function BacFirstHabil(xFecha As String) As Boolean
    Dim iMesFecha      As Integer
    Dim iMesFecha1     As Integer
    Dim cFecha         As String
    
    cFecha = xFecha
    iMesFecha = DatePart("m", cFecha)
    iMesFecha1 = iMesFecha
    cFecha = Format(DateAdd("d", -1, cFecha), gsc_FechaDMA)
    
    Do While Not BacEsHabil(cFecha)
        cFecha = Format(DateAdd("d", -1, cFecha), gsc_FechaDMA)
        iMesFecha1 = DatePart("m", cFecha)
    Loop
    
    If iMesFecha = iMesFecha1 Then
        BacFirstHabil = False
    Else
        BacFirstHabil = True
    End If
   
End Function

Private Function BacLastHabil(xFecha As String) As Boolean
    Dim iMesFecha      As Integer
    Dim iMesFecha1     As Integer
    Dim cFecha         As String

    cFecha = xFecha
    cFecha = BacProxHabil(cFecha)

    iMesFecha = DatePart("m", xFecha)
    iMesFecha1 = DatePart("m", cFecha)

    If iMesFecha = iMesFecha1 Then
        BacLastHabil = False
    Else
        BacLastHabil = True
    End If
End Function

Private Function BacUltimoDia(cFecha As String, cAdelante As String) As String
    Dim nDia      As Integer
    Dim nMes      As Integer
    Dim nYear     As Integer
    Dim dFecha1   As String
    
    nMes = DatePart("m", cFecha)
    nDia = 1
    nYear = DatePart("yyyy", cFecha)
    
    If cAdelante = "SI" Then
        nMes = nMes + 1
        If nMes > 12 Then
            nMes = 1
            nYear = nYear + 1
        End If
    End If
    
    dFecha1 = Str(nDia) + "/" + Str(nMes) + "/" + Str(nYear)
    dFecha1 = Format$(dFecha1, gsc_FechaDMA)
    dFecha1 = Format(DateAdd("d", -1, dFecha1), gsc_FechaDMA)
    
    BacUltimoDia = dFecha1
End Function

Private Function BacPrevHabil(xFecha As String) As String
    Dim cFecha As String

    cFecha = xFecha
    cFecha = Format(DateAdd("d", -1, cFecha), gsc_FechaDMA)

    Do While Not BacEsHabil(cFecha)
        cFecha = Format(DateAdd("d", -1, cFecha), gsc_FechaDMA)
    Loop

    BacPrevHabil = cFecha
End Function

Private Function Lineas_Anular(cSist As String, nNumoper As Long)
    Dim Datos()
    
    Lineas_Anular = False

    Envia = Array()
    AddParam Envia, Format(dFechaProceso, "yyyymmdd")   '-> gsBAC_Fecp
    AddParam Envia, cSist
    AddParam Envia, nNumoper
    If Not Bac_Sql_Execute(gsBac_LineasDB & "..SP_LINEAS_ANULA", Envia) Then
        Lineas_Anular = True
        Call WriteLogFile("Clase Forward : Error en el proceso Carga de Vencimientos, Error en Proceso de anulación de Lineas.")
        Exit Function
    End If
    Lineas_Anular = True

End Function

Private Function LiberaOpeGarantias(ByVal xSist As String, xNumOpe As Double) As Boolean
    Dim Datos()

    LiberaOpeGarantias = False

    Envia = Array()
    AddParam Envia, xSist
    AddParam Envia, xNumOpe
    If Not Bac_Sql_Execute("BacParamSuda.dbo.SP_LIBERAOPERACIONGTIA", Envia) Then
        LiberaOpeGarantias = True
        Call WriteLogFile("Clase Forward : Error en el proceso Carga de Vencimientos, Error en Proceso de Liberación de Garantias.")
        Exit Function
    End If

    LiberaOpeGarantias = True
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

