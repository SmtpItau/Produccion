VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "DLL_Centraliza"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Private DLLForward          As New Obj_Inicio_Forward.clsForward
Private DLLSwap             As New Obj_Inicio_Swap.clsSwap
Private DLLBonex            As New Obj_Inicio_Bonex.clsBonex
Private DLLSpot             As New Obj_Inicio_Spot.clsSpot
Private DLLTrader           As New Obj_Inicio_RentaFija.clsTrader
Private DLLSao              As New Obj_Inicio_Opciones.clsOpciones
Private DllParametros       As New Obj_Parametros.clsParametros

Private cPathIniFile        As String
Private nStatusSecuencia    As Boolean
Private BacLineasDB         As String

Private ServerName          As String
Private ConnectionMode      As Integer
Private Login               As String
Private Password            As String

Private LoginTimeOut        As Integer
Private QueryTimeOut        As Integer

Private BaseParametros      As String
Private BaseForward         As String
Private BaseSwap            As String
Private BaseBonex           As String
Private BaseSpot            As String
Private BaseTrader          As String
Private BaseOpciones        As String

Private UsuarioSao          As String
Private PasswordSao         As String
Private gsBac_RECAL         As String
Private gsBac_DIRPAE        As String

Private xError              As Boolean
Private xNemo               As String
Private xMensaje            As String

Private xPathIni            As String
Private cPathFileLog        As String


Public Function Procesar_Aperturas() As Boolean

    Call WriteLogFile("Clase Centralización : Entrando al proceso de Aperturas.")

    Let Procesar_Aperturas = FuncProcesar

    Call WriteLogFile("Clase Centralización : Finalizando al proceso de Aperturas.")

End Function

Property Get oEstado() As Boolean
    oEstado = xError
End Property
Property Get oNemo() As String
    oNemo = xNemo
End Property
Property Get oMensaje() As String
    oMensaje = xMensaje
End Property

Private Function FuncProcesar() As Boolean

    Let FuncProcesar = False

    Let nStatusSecuencia = False

    Let DllParametros.PathFileLog = cPathFileLog

    Let nStatusSecuencia = DllParametros.Conectar(1, ServerName, BaseParametros, Login, Password, LoginTimeOut, QueryTimeOut)

    If nStatusSecuencia = True Then
        
        If DllParametros.ControlDeProceso = False Then
              Let xError = DllParametros.oEstadoControl
               Let xNemo = DllParametros.oNemoControl
            Let xMensaje = DllParametros.oMensajeControl
            
            Call DllParametros.DesConectar

            Call WriteLogFile("Clase Centralización : Control de Aperturas, Mensaje : " & xMensaje)
            Exit Function
        End If

        Call DllParametros.Inicializa_Datos
        Call DllParametros.Time([En Ejecucion])
        Call DllParametros.DesConectar
    End If


        '-> ACTIVAR AL FINALIZAR (Proceso de Forward esta OK 100%)
    Let nStatusSecuencia = DLLForward.ProcesoInicioDia(ConnectionMode, ServerName, BaseForward, Login, Password, LoginTimeOut, QueryTimeOut, BacLineasDB, cPathFileLog)
    If nStatusSecuencia = False Then
        Call WriteLogFile("Clase Centralización : Proceso de Aperturas de Forward, ha fallado.")
        GoTo Abort
        Exit Function
    End If


        '-> ACTIVAR AL FINALIZAR (Proceso de Swap esta OK 100%)
    Let nStatusSecuencia = DLLSwap.ProcesoInicioDia(ConnectionMode, ServerName, BaseSwap, Login, Password, LoginTimeOut, QueryTimeOut, BacLineasDB, cPathFileLog)
    If nStatusSecuencia = False Then
        Call WriteLogFile("Clase Centralización : Proceso de Aperturas de Swap, ha fallado.")
        GoTo Abort
        Exit Function
    End If


        '-> ACTIVAR AL FINALIZAR (Proceso de Bonex esta OK 100%)
    Let nStatusSecuencia = DLLBonex.ProcesoInicioDia(ConnectionMode, ServerName, BaseBonex, Login, Password, LoginTimeOut, QueryTimeOut, BacLineasDB, cPathFileLog)
    If nStatusSecuencia = False Then
        Call WriteLogFile("Clase Centralización : Proceso de Aperturas de Bonex, ha fallado.")
        GoTo Abort
        Exit Function
    End If


        '-> ACTIVAR AL FINALIZAR ((Proceso de AdminOpciones esta OK 100%)
    Let DLLSao.BaseParam = BaseParametros:  Let DLLSao.PasswordParam = Password:    Let DLLSao.UsuarioParam = Login
    Let nStatusSecuencia = DLLSao.ProcesoInicioDia(ConnectionMode, ServerName, BaseOpciones, UsuarioSao, PasswordSao, LoginTimeOut, QueryTimeOut, BacLineasDB, cPathFileLog)
    If nStatusSecuencia = False Then
        Call WriteLogFile("Clase Centralización : Proceso de Aperturas de SAO, ha fallado.")
        GoTo Abort
        Exit Function
    End If


        '-> ACTIVAR AL FINALIZAR (Proceso de Spot esta OK 100%)
    Let nStatusSecuencia = DLLSpot.ProcesoInicioDia(ConnectionMode, ServerName, BaseSpot, Login, Password, LoginTimeOut, QueryTimeOut, BacLineasDB, cPathFileLog)
    If nStatusSecuencia = False Then
        Call WriteLogFile("Clase Centralización : Proceso de Aperturas de Spot, ha fallado.")
        GoTo Abort
        Exit Function
    End If


        '-> ACTIVAR AL FINALIZAR (Proceso de Trader esta OK 100%)
    Let nStatusSecuencia = DLLTrader.ProcesoInicioDia(ConnectionMode, ServerName, BaseTrader, Login, Password, LoginTimeOut, QueryTimeOut, BacLineasDB, gsBac_DIRPAE, gsBac_RECAL, cPathFileLog)
    If nStatusSecuencia = False Then
        Call WriteLogFile("Clase Centralización : Proceso de Aperturas de Trader, ha fallado.")
        GoTo Abort
        Exit Function
    End If

    
    Call DllParametros.DesConectar

        Let DllParametros.PathFileLog = cPathFileLog
        Let nStatusSecuencia = DllParametros.Conectar(ConnectionMode, ServerName, BaseParametros, Login, Password, LoginTimeOut, QueryTimeOut)
        If nStatusSecuencia = True Then
            Call WriteLogFile("Clase Centralización : Proceso de Aperturas Ha finalizado")
            Call DllParametros.Time([Finalizado Ok])
        End If

    Call DllParametros.DesConectar
    
    Let FuncProcesar = True

Exit Function
Abort:
    
    Call DllParametros.DesConectar

        Let DllParametros.PathFileLog = cPathFileLog
        Let nStatusSecuencia = DllParametros.Conectar(ConnectionMode, ServerName, BaseParametros, Login, Password, LoginTimeOut, QueryTimeOut)
    
        Call WriteLogFile("Clase Centralización : Proceso Cancelado... Se ha Marcado como Finalizado.")
        
        Call DllParametros.Time([Finalizado Ok])

    Call DllParametros.DesConectar
    
    Let FuncProcesar = True
    
End Function

Private Function Func_Read_INI(cSection$, cKeyName$, sFilename As String) As String
    Dim sret As String

    sret = String(255, Chr(0))
    Func_Read_INI = Left(sret, GetPrivateProfileString(cSection$, ByVal cKeyName$, "", sret, Len(sret), sFilename))
End Function


Property Get PathFileLog() As String
    Let PathFileLog = cPathFileLog
End Property
Property Let PathFileLog(ByVal nValor As String)
    If Not Mid(nValor, Len(nValor), 1) = "\" Then
        Let nValor = nValor & "\"
    End If
    Let cPathFileLog = nValor
End Property

   
Property Get QueryTime() As Integer
    Let QueryTime = QueryTimeOut
End Property
Property Let QueryTime(ByVal nValor As Integer)
    Let QueryTimeOut = nValor
End Property
   
Property Get LoginTime() As Integer
    Let LoginTime = LoginTimeOut
End Property
Property Let LoginTime(ByVal nValor As Integer)
    Let LoginTimeOut = nValor
End Property

Property Get Clave() As String
    Let Clave = Password
End Property
Property Let Clave(ByVal nValor As String)
    Let Password = Encript(nValor, True)
End Property
   
Property Get Usuario() As String
    Let Usuario = Login
End Property
Property Let Usuario(ByVal nValor As String)
    Let Login = nValor
End Property
   
Property Get Servidor() As String
    Let Servidor = ServerName
End Property
Property Let Servidor(ByVal nValor As String)
    Let ServerName = nValor
    Let ConnectionMode = 1
End Property

Property Get DirRECAL() As String
    Let DirRECAL = gsBac_RECAL
End Property
Property Let DirRECAL(ByVal nValor As String)
    Let gsBac_RECAL = nValor
End Property
   
Property Get DirPAE() As String
    Let DirPAE = gsBac_DIRPAE
End Property
Property Let DirPAE(ByVal nValor As String)
    Let gsBac_DIRPAE = nValor
End Property
   
Property Get pwd_Opciones() As String
    Let pwd_Opciones = PasswordSao
End Property
Property Let pwd_Opciones(ByVal nValor As String)
    Let PasswordSao = nValor
End Property
   
Property Get usr_Opciones() As String
    Let usr_Opciones = UsuarioSao
End Property
Property Let usr_Opciones(ByVal nValor As String)
    Let UsuarioSao = nValor
End Property
   
Property Get db_Opciones() As String
    Let db_Opciones = BaseOpciones
End Property
Property Let db_Opciones(ByVal nValor As String)
    Let BaseOpciones = nValor
End Property
      
Property Get db_Lineas() As String
    Let db_Lineas = BacLineasDB
End Property
Property Let db_Lineas(ByVal nValor As String)
    Let BacLineasDB = nValor
End Property
   
Property Get db_Trader() As String
    Let db_Trader = BaseTrader
End Property
Property Let db_Trader(ByVal nValor As String)
    Let BaseTrader = nValor
End Property
   
Property Get db_Spot() As String
    Let db_Spot = BaseSpot
End Property
Property Let db_Spot(ByVal nValor As String)
    Let BaseSpot = nValor
End Property
   
Property Get db_Bonex() As String
    Let db_Bonex = BaseBonex
End Property
Property Let db_Bonex(ByVal nValor As String)
    Let BaseBonex = nValor
End Property
   
Property Get db_Swap() As String
    Let db_Swap = BaseSwap
End Property
Property Let db_Swap(ByVal nValor As String)
    Let BaseSwap = nValor
End Property

Property Get db_Forward() As String
    Let db_Forward = BaseForward
End Property
Property Let db_Forward(ByVal nValor As String)
    Let BaseForward = nValor
End Property

Property Get db_Parametros() As String
    Let db_Parametros = BaseParametros
End Property
Property Let db_Parametros(ByVal nValor As String)
    Let BaseParametros = nValor
End Property


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
