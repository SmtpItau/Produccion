VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsOpciones"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Private Type DatosGenerales
    ACEstado            As String
    ACFechaProceso      As Date
    ACFechaAnterior     As Date
    ACFechaProxima      As Date
    ACInicioDia         As Integer
    ACCierreMesa        As Integer
    ACFinDia            As Integer
End Type
Private cDatosgenerales As DatosGenerales
Public DllParametros    As New Obj_Parametros.clsParametros

Public BaseParam        As String
Public UsuarioParam     As String
Public PasswordParam    As String
Private cPathFileLog    As String

Private Function BAC_Conection(ByVal iMode As Integer, ByVal cServerName As String, ByVal cDataBaseName As String, ByVal cUserName As String, ByVal cPassword As String, ByVal nLoginTimeOut As Integer, ByVal nQueryTimeOut As Integer, ByVal cBaseLineas As String) As Boolean
    On Error Resume Next
    Let BAC_Conection = False

          Let miSQL.HostName = "dllInicioOpciones"
       Let miSQL.Application = "Opciones"
          Let gsBac_LineasDb = cBaseLineas

    Let miSQL.ConnectionMode = iMode
        Let miSQL.ServerName = cServerName
      Let miSQL.DatabaseName = cDataBaseName
             Let miSQL.Login = cUserName
          Let miSQL.Password = Encript(Trim(cPassword), False)
      Let miSQL.LoginTimeOut = nLoginTimeOut
      Let miSQL.QueryTimeOut = nQueryTimeOut

    On Error GoTo 0

    If miSQL.SQL_Coneccion() = False Then
        Let BAC_Conection = False
        Exit Function
    End If

    Let BAC_Conection = True
End Function


Public Function ProcesoInicioDia(ByVal iMode As Integer, ByVal cServerName As String, ByVal cDataBaseName As String, ByVal cUserName As String, ByVal cPassword As String, ByVal nLoginTimeOut As Integer, ByVal nQueryTimeOut As Integer, ByVal cBaseLineas As String, ByVal cPathLog As String) As Boolean
    
    Let ProcesoInicioDia = False

    Let cPathFileLog = cPathLog

    '-> Activa la coneccion
    If BAC_Conection(iMode, cServerName, cDataBaseName, cUserName, cPassword, nLoginTimeOut, nQueryTimeOut, cBaseLineas) = False Then
        Call WriteLogFile("Clase Opciones : Conexion ha fallado.")
        Exit Function
    End If
    
    Let DllParametros.PathFileLog = cPathFileLog
    Call DllParametros.Conectar(iMode, cServerName, BaseParam, UsuarioParam, PasswordParam, nLoginTimeOut, nQueryTimeOut)
    
    Call Inicializa
    
    If FuncLeerFechas = False Then
        Call WriteLogFile("Clase Opciones : Error en proceso de Carga de Fechas, Proceso no finalizado.")
        Exit Function
    End If


    If cDatosgenerales.ACEstado <> "OK" Then
        Call WriteLogFile("Clase Opciones : Control de Swith, Estado :" & Trim(cDatosgenerales.ACEstado) & " , Proceso no Finalizado.")
        Exit Function
    End If
    
    
    Call DllParametros.Func_MoveEventControls(Opciones, 1, [En Ejecucion])
    If FuncCambiaFechas = False Then
        Call DllParametros.Func_MoveEventControls(Opciones, 1, [No Finalizado])
        Call WriteLogFile("Clase Opciones : Error en proceso de cambio de Fechas, Proceso no Finalizado.")
        Exit Function
    End If
    Call DllParametros.Func_MoveEventControls(Opciones, 1, [Finalizado Ok])


    Call DllParametros.Func_MoveEventControls(Opciones, 2, [En Ejecucion])
    If FuncGrabaInicioDia = False Then
        Call DllParametros.Func_MoveEventControls(Opciones, 2, [No Finalizado])
        Call WriteLogFile("Clase Opciones : Error en proceso de Apertura, Proceso no Finalizado.")
        Exit Function
    End If
    Call DllParametros.Func_MoveEventControls(Opciones, 2, [Finalizado Ok])


    Call DllParametros.Func_MoveEventControls(Opciones, 3, [En Ejecucion])
    If FuncPreparaAccionSDA = False Then
        Call DllParametros.Func_MoveEventControls(Opciones, 3, [Finalizado c / Warning])
        Call WriteLogFile("Clase Opciones : Error en proceso de preparacion SDA, Proceso finalizo con Warning.")
    Else
        Call DllParametros.Func_MoveEventControls(Opciones, 3, [Finalizado Ok])
    End If
    
    
    Let ProcesoInicioDia = True

    '->  Cierra la Conexion
    Call miSQL.SQL_Close

    Call DllParametros.DesConectar
End Function

Private Function FuncPreparaAccionSDA() As Boolean
    Dim Datos()

    Let FuncPreparaAccionSDA = False

    Envia = Array()
    AddParam Envia, Format(cDatosgenerales.ACFechaProceso, "yyyymmdd")
    AddParam Envia, " " '--> Usuario, el procedimiento no lo utiliza
    If Not Bac_Sql_Execute("SP_PREPARA_ACCION_CON_SDA", Envia) Then
        Call WriteLogFile("Clase Opciones : Error en proceso de preparacion SDA, Error sobre la ejecución Sp_Prepara_Accion_Con_Sda")
        Exit Function
    End If
    If Bac_SQL_Fetch(Datos()) Then
        If Datos(1) = "SI" Then
            Let FuncPreparaAccionSDA = True
        Else
            Call WriteLogFile("Clase Opciones : Error en proceso de preparacion SDA, Retorno con Errores.")
            Let FuncPreparaAccionSDA = True
        End If
    End If

End Function


Private Function FuncGrabaInicioDia() As Boolean
    Dim Datos()
    
    Let FuncGrabaInicioDia = False

    Envia = Array()
    AddParam Envia, Format(cDatosgenerales.ACFechaProceso, "yyyymmdd")
    AddParam Envia, Format(cDatosgenerales.ACFechaProxima, "yyyymmdd")
    AddParam Envia, " " '--> Usuario, el procedimiento no lo utiliza
    If Not Bac_Sql_Execute("SP_INI_DIA_OPC", Envia) Then
        Call WriteLogFile("Clase Opciones : Error en proceso de Apertura, Error en la ejecución Sp_Ini_Dia_Opc")
        Exit Function
    End If
    If Bac_SQL_Fetch(Datos()) Then
        If UCase(Datos(1)) = UCase("Dia Abierto OK") Then
            Let FuncGrabaInicioDia = True
        End If
    End If

End Function

Private Function FuncCambiaFechas() As Boolean
    On Error GoTo Error_Lee_monedas
    Dim Datos()
    Dim dFechaProxima   As Date
    
    Let FuncCambiaFechas = False
    
    Let dFechaProxima = cDatosgenerales.ACFechaProxima
    
    Envia = Array()
    AddParam Envia, Format(cDatosgenerales.ACFechaProxima, "yyyymmdd")
    AddParam Envia, Format(dFechaProxima, "yyyymmdd")
    If Not Bac_Sql_Execute("SP_FECHA_PROXIMA_HABIL", Envia) Then
        Call WriteLogFile("Clase Opciones : Error en proceso de Cambio de Fechas, Error en la ejecución Sp_Fecha_Proxima_Habil")
        On Error GoTo 0
        Exit Function
    End If
    If Bac_SQL_Fetch(Datos()) Then
        Let cDatosgenerales.ACFechaAnterior = cDatosgenerales.ACFechaProceso
        Let cDatosgenerales.ACFechaProceso = cDatosgenerales.ACFechaProxima
        Let cDatosgenerales.ACFechaProxima = Datos(4)

        Let FuncCambiaFechas = True
    End If

    On Error GoTo 0
    
Exit Function
Error_Lee_monedas:

    Call WriteLogFile("Clase Opciones : Error en proceso de Cambio de Fechas, Error inesperado" & Err.Description)
    On Error GoTo 0

End Function

Private Sub Inicializa()
    cDatosgenerales.ACEstado = ""
    cDatosgenerales.ACFechaProceso = "01-01-1900"
    cDatosgenerales.ACFechaAnterior = "01-01-1900"
    cDatosgenerales.ACFechaProxima = "01-01-1900"
    cDatosgenerales.ACInicioDia = 0
    cDatosgenerales.ACCierreMesa = 0
    cDatosgenerales.ACFinDia = 0
End Sub

Private Function FuncLeerFechas() As Boolean
    Dim Datos()
    
    FuncLeerFechas = False
    
    Envia = Array()
    AddParam Envia, Format(cDatosgenerales.ACFechaProceso, "yyyymmdd")
    AddParam Envia, Format(cDatosgenerales.ACFechaAnterior, "yyyymmdd")
    AddParam Envia, Format(cDatosgenerales.ACFechaProxima, "yyyymmdd")
    AddParam Envia, cDatosgenerales.ACInicioDia
    If Not Bac_Sql_Execute("Sp_OpcionesGeneral_Fechas", Envia) Then
        Call WriteLogFile("Clase Opciones : Error en proceso de Carga de Fechas, Error en Ejecución de Sp_OpcionesGeneral_Fechas")
        Exit Function
    End If
    If Bac_SQL_Fetch(Datos()) Then
        cDatosgenerales.ACEstado = Datos(1)
        cDatosgenerales.ACFechaProceso = Datos(2)
        cDatosgenerales.ACFechaAnterior = Datos(3)
        cDatosgenerales.ACFechaProxima = Datos(4)
        cDatosgenerales.ACInicioDia = Datos(5)
        cDatosgenerales.ACCierreMesa = Datos(6)
        cDatosgenerales.ACFinDia = Datos(7)

        FuncLeerFechas = True
    Else
        Call WriteLogFile("Clase Opciones : Error en proceso de Carga de Fechas, Error en Ejecución de Sp_OpcionesGeneral_Fechas, Sin Retorno.")
    End If

End Function


Private Function Encript(xClave As String, xEncriptar As Boolean) As String
    On Error GoTo ErrorEncript
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
Exit Function
ErrorEncript:
    Call WriteLogFile("Opciones : En la encriptacion : " & xClave)
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

