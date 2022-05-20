VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsParametros"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Public Enum nEstados
    [En Espera] = 0
    [En Ejecucion] = 1
    [Finalizado Ok] = 2
    [Finalizado c / Warning] = 3
    [No Finalizado] = 4
End Enum
Public Enum cModulos
    [Forward] = 1
    [Swap] = 2
    [Bonex] = 3
    [Opciones] = 4
    [Spot] = 5
    [RentaFija] = 6
End Enum

Private Type oControl
    Estado      As Boolean
    Nemo        As String
    Mensaje     As String
End Type
Private xMensajeControl As oControl
Private cPathFileLog    As String

Property Let PathFileLog(ByVal nValor As String)
    Let cPathFileLog = nValor
End Property

Private Sub Class_Initialize()
   'Let cPathFileLog = ""
End Sub


Public Function BAC_Conection(ByVal iMode As Integer, ByVal cServerName As String, ByVal cDataBaseName As String, ByVal cUserName As String, ByVal cPassword As String, ByVal nLoginTimeOut As Integer, ByVal nQueryTimeOut As Integer) As Boolean
    Let BAC_Conection = False

                                                                    'Call WriteLogFile(" 6. Parametros : (BAC_Conection) -  1 -")
    Let miSQL.HostName = "dllInicioParametros":                     'Call WriteLogFile(" 7. Parametros : (BAC_Conection) -  2 -")
    Let miSQL.Application = "Bac-Parametros":                       'Call WriteLogFile(" 8. Parametros : (BAC_Conection) -  3 -")
    Let gsBac_LineasDB = cBaseLineas:                               'Call WriteLogFile(" 9. Parametros : (BAC_Conection) -  4 -")
    Let miSQL.ConnectionMode = 1:                                   'Call WriteLogFile("10. Parametros : (BAC_Conection) -  5 -")
    Let miSQL.ServerName = cServerName:                             'Call WriteLogFile("11. Parametros : (BAC_Conection) -  6 -")
    Let miSQL.DatabaseName = cDataBaseName:                         'Call WriteLogFile("12. Parametros : (BAC_Conection) -  7 -")
    Let miSQL.Login = cUserName:                                    'Call WriteLogFile("13. Parametros : (BAC_Conection) -  8 -")
    Let miSQL.Password = Encript(Trim(cPassword), False):           'Call WriteLogFile("14. Parametros : (BAC_Conection) -  9 -")
    Let miSQL.LoginTimeOut = nLoginTimeOut:                         'Call WriteLogFile("15. Parametros : (BAC_Conection) - 10 -")
    Let miSQL.QueryTimeOut = nQueryTimeOut:                         'Call WriteLogFile("16. Parametros : (BAC_Conection) - 11 -")
        
    If miSQL.SQL_Coneccion() = False Then
        Let BAC_Conection = False
        Exit Function
    End If

    Let BAC_Conection = True
End Function

Public Function DesConectar()
    Call miSQL.SQL_Close
End Function

Public Function Conectar(ByVal iMode As Integer, ByVal cServerName As String, ByVal cDataBaseName As String, ByVal cUserName As String, ByVal cPassword As String, ByVal nLoginTimeOut As Integer, ByVal nQueryTimeOut As Integer) As Boolean
    Conectar = False
    
    If BAC_Conection(1, cServerName, cDataBaseName, cUserName, cPassword, nLoginTimeOut, nQueryTimeOut) = False Then
        Call WriteLogFile("Clase Parámetros : Conexion ha fallado.")
        Exit Function
    End If

    Conectar = True
End Function

Property Get oEstadoControl() As Boolean
    oEstadoControl = xMensajeControl.Estado
End Property
Property Get oNemoControl() As String
    oNemoControl = xMensajeControl.Nemo
End Property
Property Get oMensajeControl() As String
    oMensajeControl = xMensajeControl.Mensaje
End Property

Public Function ControlDeProceso() As Boolean
    Dim Datos()
    
    Let ControlDeProceso = False
    
    If Not Bac_Sql_Execute("dbo.Sp_MID_Control_Inicio ") Then
        Call WriteLogFile("Clase Parámetros : Error en control de Inicio.")
        Exit Function
    End If
    
   
    If Bac_SQL_Fetch(Datos()) Then
        Let ControlDeProceso = Datos(1)
        Let xMensajeControl.Estado = Datos(1)
        Let xMensajeControl.Nemo = Datos(2)
        Let xMensajeControl.Mensaje = Datos(3)
        
        Call WriteLogFile("Clase Parámetros : Control de Inicio, Mensaje : " & Trim(Datos(3)))
    Else
        Call WriteLogFile("Clase Parámetros : Control de Inicio, Mensaje : Sin Retorno de Datos.")
    End If
    
End Function

Public Function Inicializa_Datos() As Boolean
    
    If Not Bac_Sql_Execute("dbo.SP_MID_Inicializa_Estado_Control") Then
        Call WriteLogFile("Clase Parámetros : Control de Estados de Inicio, Mensaje : Error inesperado. (SP_MID_Inicializa_Estado_Control)")
    End If
    
End Function

Public Function Time(ByVal nestado As nEstados) As Boolean
    ENVIA = Array()
    AddParam ENVIA, nestado
    If Not Bac_Sql_Execute("BacParamSuda.dbo.SP_MID_InicioProceso ", ENVIA) Then
        Call WriteLogFile("Clase Parámetros : Control de Tiempo de Inicio, Mensaje : Error inesperado. (SP_MID_InicioProceso )")
        Exit Function
    End If
End Function

Public Function Time_Express(ByVal nestado As nEstados) As Boolean
    Dim cSql    As String
    
    Let Time_Express = False
    
    Let cSql = "UPDATE BacParamSuda.dbo.MID_Control_Inicio SET Estado = " & nestado
    
    If Not Bac_Sql_Execute(cSql) Then
        Call WriteLogFile("Clase Parámetros : Finalización Express de Proceso, ha fallado.")
        Exit Function
    End If
    
    Let Time_Express = True
    
End Function


Public Function Func_MoveEventControls(ByVal IdModulo As cModulos, ByVal IdEvento As Integer, ByVal IdEstado As nEstados) As Boolean
    On Error Resume Next
    Dim cSql    As String
    
    Let cSql = ""
    Let cSql = cSql & "BacParamSuda.dbo.SP_MID_MoveEventControls " & IdModulo & ", " & IdEvento & ", " & IdEstado
    If Not Bac_Sql_Execute(cSql) Then
        Call WriteLogFile("Clase Parámetros : Error en Control de Eventos (SP_MID_MoveEventControls).... Parametros : " & IdModulo & ", " & IdEvento & ", " & IdEstado)
    End If
    On Error GoTo 0
End Function

Private Function Func_WriteMesaje(ByVal IdProducto As Integer, ByVal IdEvento As Integer, ByVal IdEstado As nEstados, ByVal Mensaje As String)
    On Error Resume Next
    Dim cSql    As String
    
    Let cSql = ""
    Let cSql = cSql & "BacParamSuda.dbo.SP_MID_WriteMesaje "
    Let cSql = cSql & IdProducto & ", "
    Let cSql = cSql & IdEvento & ", "
    Let cSql = cSql & IdEstado & ", "
    Let cSql = cSql & "'" & Mensaje & "'"
    If Not Bac_Sql_Execute(cSql) Then
        Call WriteLogFile("Parametros : Error en Func_WriteMesaje, [SP_MID_WriteMesaje] Sql = " & cSql)
    End If
    On Error GoTo 0
End Function

Public Function GenerarLogEventos(ByVal oMensaje As String)

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

