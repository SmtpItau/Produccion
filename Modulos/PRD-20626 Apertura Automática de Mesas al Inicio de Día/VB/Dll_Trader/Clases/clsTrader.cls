VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsTrader"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit

Public Type Valores_Monedas
        vmcodigo            As Integer
        vmdescripcion       As String
        vmvalorproceso      As Double
        vmvalorproximo      As Double
        vmcodbcch           As Integer
End Type
Public Type nValores_Monedas
        dValoresMonedas()   As Valores_Monedas
End Type

Private Type DatosGenerales
        gsBac_Fecp                          As Date
        gsBac_Fecx                          As Date
        gsBac_Feca                          As Date
        gsBac_Clien                         As String
        gsBac_RutC                          As String
        gsBac_DigC                          As String
        gsBac_RutComi                       As Double
        gsBac_PrComi                        As Double
        gsBac_Iva                           As Double
        gsBac_CartRUT                       As Double
        gsBac_CartDV                        As String
        gsBac_CartNOM                       As String
        gsBAC_FecConFin                     As Date
        gsBac_TCambio                       As Double
        gsBac_RutBCCH                       As String
        gsBac_FPagoBCCH                     As String
        gsBac_NomBCCH                       As String
        gsBac_NomFPagoBCCH                  As String
        DIAS_PACTO_PAPEL_NO_CENTRAL         As Integer
        DIAS_PACTO_PAPEL_NO_CENTRAL_90      As Integer
        MONTO_PATRIMONIO_EFECTIVO           As Double
End Type
Private cDatosgenerales     As DatosGenerales


Private Type xChqFechasDevengamiento
        Fecha_Proceso           As String
        Fecha_Proximo_Proceso   As String
        Fecha_Cierre_Mes        As String
        valPCDUSD               As Double
        valPCDUF                As Double
        valPTF                  As Double
        swDevengo               As String
        Fecha_Anterior          As String
        gsBac_FM                As Date
        Fecha_Proceso_Dev       As String
        Fecha_Proximo_Dev       As String
End Type
Private CHKFECHASDEVENGAMIENTO  As xChqFechasDevengamiento

Private dFechaProceso           As String
Private dFechaProxima           As String
Private gsBac_User              As String
Private gsBac_IP                As String

Private gsBac_DIRPAE            As String
Private devolver                As String
Private cPathFileLog            As String

Public DllParametros    As New Obj_Parametros.clsParametros

Private Function BAC_Conection(ByVal iMode As Integer, ByVal cServerName As String, ByVal cDataBaseName As String, ByVal cUserName As String, ByVal cPassword As String, ByVal nLoginTimeOut As Integer, ByVal nQueryTimeOut As Integer, ByVal cBaseLineas As String) As Boolean
    Let BAC_Conection = False

    Let miSQL.HostName = "dllInicioBacTrader"
    Let miSQL.Application = "Bac Trader"
'-  Let gsBac_LineasDb = cBaseLineas

    Let miSQL.ConnectionMode = iMode
    Let miSQL.ServerName = cServerName
    Let miSQL.DatabaseName = cDataBaseName
    Let miSQL.Login = cUserName
    Let miSQL.PassWord = Encript(Trim(cPassword), False)
    Let miSQL.LoginTimeOut = nLoginTimeOut
    Let miSQL.QueryTimeOut = nQueryTimeOut

    If miSQL.SQL_Coneccion() = False Then
        Exit Function
    End If

    Let BacCalculoRec.gsSQL_Server = cServerName
    Let BacCalculoRec.gsBac_LineasDb = cBaseLineas
    Let BacCalculoRec.gsSQL_Login = cUserName
    Let BacCalculoRec.gsSQL_Password = Encript(Trim(cPassword), False)
    Let BacCalculoRec.gsUsuario = "LGUERRA"
    Let BacCalculoRec.gsPathFileLog = cPathFileLog

    Dim Ip As New clsWinIp
    Let gsBac_User = "ADMINISTRA"
    Let gsBac_IP = Ip.DirWinIp
    Set Ip = Nothing

    Let BAC_Conection = True
End Function

Public Function ProcesoInicioDia(ByVal iMode As Integer, ByVal cServerName As String, ByVal cDataBaseName As String, ByVal cUserName As String, ByVal cPassword As String, ByVal nLoginTimeOut As Integer, ByVal nQueryTimeOut As Integer, ByVal cBaseLineas As String, ByVal PathFilePae As String, ByVal FileMatrizConv As String, ByVal cPathLog As String) As Boolean
    Dim ValorMonedaProceso  As nValores_Monedas
    Dim objValoresMoneda    As New clsValoresMoneda
    Dim Proceso             As String
    Dim Prox_Proc           As String
    Dim Anterior            As String
    Dim cFecpro             As String
    Dim cFecprox            As String
    Dim cSW_PD              As String
    Dim nContador           As Integer
    Dim ok                  As Boolean
    Dim Datos()
    
    Let ProcesoInicioDia = False
    
    Let cPathFileLog = cPathLog
    
    gsBac_DIRPAE = PathFilePae
    Let BacCalculoRec.gsBac_RECAL = FileMatrizConv
        
    '-> Activa la coneccion
    If BAC_Conection(iMode, cServerName, cDataBaseName, cUserName, cPassword, nLoginTimeOut, nQueryTimeOut, cBaseLineas) = False Then
        Call WriteLogFile("Clase Renta Fija : Conexion ha fallado.")
        Exit Function
    End If
    
    Let DllParametros.PathFileLog = cPathFileLog
    Call DllParametros.Conectar(iMode, cServerName, "BacParamSuda", cUserName, cPassword, nLoginTimeOut, nQueryTimeOut)
    
    If Proc_Carga_Parametros = False Then
        Call WriteLogFile("Clase Renta Fija : Error en proceso de Aperura, Error en carga de Parametros, proceso no finalizado")
        Exit Function
    End If

    Proceso = cDatosgenerales.gsBac_Fecp
    Prox_Proc = cDatosgenerales.gsBac_Fecx
    Anterior = cDatosgenerales.gsBac_Feca

    Call DllParametros.Func_MoveEventControls(RentaFija, 1, [En Ejecucion])
    If BacLeerParamAc(cFecpro, cFecprox, cSW_PD) = False Then
        Call DllParametros.Func_MoveEventControls(RentaFija, 1, [No Finalizado])
        Call WriteLogFile("Clase Renta Fija : Error en proceso de Aperura, Error en carga de Parametros, proceso no finalizado")
        Exit Function
    End If
    Call DllParametros.Func_MoveEventControls(RentaFija, 1, [Finalizado Ok])


    dFechaProceso = cFecpro
    dFechaProxima = cFecprox

    If Func_Buscar_Datos(cFecpro, cFecprox, ValorMonedaProceso) = False Then
        Call WriteLogFile("Clase Renta Fija : Error en proceso de Aperura, Error en carga de parametros, proceso no finalizado.")
        Exit Function
    End If


    If BacChkFechas() = False Then
        Call WriteLogFile("Clase Renta Fija : Error en proceso de Aperura, Error en chequeo de fechas.")
        Exit Function
    End If


    On Error Resume Next
    For nContador = 0 To UBound(ValorMonedaProceso.dValoresMonedas)
        Call objValoresMoneda.Agregar(ValorMonedaProceso.dValoresMonedas(nContador).vmcodigo, cFecpro, ValorMonedaProceso.dValoresMonedas(nContador).vmvalorproceso)
        Call objValoresMoneda.Agregar(ValorMonedaProceso.dValoresMonedas(nContador).vmcodigo, cFecprox, ValorMonedaProceso.dValoresMonedas(nContador).vmvalorproceso)
    Next nContador
    On Error GoTo 0


    Call Bac_Sql_Execute("Begin Transaction")

    Call DllParametros.Func_MoveEventControls(RentaFija, 2, [En Ejecucion])
    If objValoresMoneda.Grabar() = False Then
        Call Bac_Sql_Execute("Rollback Transaction")
        Call DllParametros.Func_MoveEventControls(RentaFija, 2, [No Finalizado])

        Call WriteLogFile("Clase Renta Fija : Error en proceso de Aperura, Error en grabación de Monedas, proceso no finalizado")
        Exit Function
    End If
    Call DllParametros.Func_MoveEventControls(RentaFija, 2, [Finalizado Ok])


    Call DllParametros.Func_MoveEventControls(RentaFija, 3, [En Ejecucion])
    If BacGrabarParamAc(cFecpro, cFecprox) = False Then
        Call Bac_Sql_Execute("Rollback Transaction")
        Call DllParametros.Func_MoveEventControls(RentaFija, 3, [No Finalizado])

        Call WriteLogFile("Clase Renta Fija : Error en proceso de Aperura, Error en grabación de Pparametros, proceso no finalizado")
        Exit Function
    End If
    Call DllParametros.Func_MoveEventControls(RentaFija, 3, [Finalizado Ok])


    Call DllParametros.Func_MoveEventControls(RentaFija, 4, [En Ejecucion])
    If Bac_Sql_Execute("SP_TRASPASOOPERVENCIDASMIDDLE") = False Then
        Call Bac_Sql_Execute("Rollback Transaction")
        Call DllParametros.Func_MoveEventControls(RentaFija, 4, [No Finalizado])

        Call WriteLogFile("Clase Renta Fija : Error en proceso de Aperura, Error Traspaso de Operaciones Vencidas, proceso no finalizado.")
        Exit Function
    End If
    Call DllParametros.Func_MoveEventControls(RentaFija, 4, [Finalizado Ok])


    Call DllParametros.Func_MoveEventControls(RentaFija, 5, [En Ejecucion])
    If Bac_Sql_Execute("SP_CHKFECHASDEVENGAMIENTO") Then
        If Bac_SQL_Fetch(Datos()) Then
            Let CHKFECHASDEVENGAMIENTO.Fecha_Proceso = Datos(1)
            Let CHKFECHASDEVENGAMIENTO.Fecha_Proximo_Proceso = Datos(2)
            Let CHKFECHASDEVENGAMIENTO.Fecha_Cierre_Mes = Datos(3)
            Let CHKFECHASDEVENGAMIENTO.valPCDUSD = Datos(4)
            Let CHKFECHASDEVENGAMIENTO.valPCDUF = Datos(5)
            Let CHKFECHASDEVENGAMIENTO.valPTF = Datos(6)
            Let CHKFECHASDEVENGAMIENTO.swDevengo = Datos(7)
            Let CHKFECHASDEVENGAMIENTO.Fecha_Anterior = Datos(11)
        End If
    Else
        Call Bac_Sql_Execute("Rollback Transaction")
        Call DllParametros.Func_MoveEventControls(RentaFija, 5, [No Finalizado])

        Call WriteLogFile("Clase Renta Fija : Error en proceso de Aperura, Error chequeo de fechas para el Devengamiento, proceso no finalizado")
        Exit Function
    End If
    Call DllParametros.Func_MoveEventControls(RentaFija, 5, [Finalizado Ok])

    Let CHKFECHASDEVENGAMIENTO.Fecha_Proceso_Dev = CHKFECHASDEVENGAMIENTO.Fecha_Proceso
    Let CHKFECHASDEVENGAMIENTO.Fecha_Proximo_Dev = CHKFECHASDEVENGAMIENTO.Fecha_Cierre_Mes

    Let CHKFECHASDEVENGAMIENTO.gsBac_FM = CDate("01/" + Str(Month(CHKFECHASDEVENGAMIENTO.Fecha_Anterior)) + "/" + Str(Year(CHKFECHASDEVENGAMIENTO.Fecha_Anterior)))
    Let CHKFECHASDEVENGAMIENTO.gsBac_FM = DateAdd("m", 1, CHKFECHASDEVENGAMIENTO.gsBac_FM)
    Let CHKFECHASDEVENGAMIENTO.gsBac_FM = DateAdd("d", -1, CHKFECHASDEVENGAMIENTO.gsBac_FM)

    'El Evento 6 al 9  de Renta Fija Esta Dentro
    If Func_Devengar_Dolares = False Then
        Call Bac_Sql_Execute("Rollback Transaction")
        Call WriteLogFile("Clase Renta Fija : Error en proceso de Aperura, Error en proceso de Devengamiento en Dólares, proceso no finalizado")
        Exit Function
    End If



    Call DllParametros.Func_MoveEventControls(RentaFija, 10, [En Ejecucion])
    If Bac_Sql_Execute("SP_ACTUALIZA_CARTERA") Then
        Do While Bac_SQL_Fetch(Datos())
            If Datos(1) = "SI" Then
            Else
                Call Bac_Sql_Execute("Rollback Transaction")
                Call DllParametros.Func_MoveEventControls(RentaFija, 10, [No Finalizado])
                Call WriteLogFile("Clase Renta Fija : Error en proceso de Aperura, Error en proceso de actualización de Cartera, proceso no finalizado")
                Exit Function
            End If
        Loop
    Else
        Call Bac_Sql_Execute("Rollback Transaction")
        Call DllParametros.Func_MoveEventControls(RentaFija, 10, [No Finalizado])

        Call WriteLogFile("Clase Renta Fija : Error en proceso de Aperura, Error en proceso de actualización de Cartera, proceso no finalizado")
        Exit Function
    End If
    Call DllParametros.Func_MoveEventControls(RentaFija, 10, [Finalizado Ok])


    Call DllParametros.Func_MoveEventControls(RentaFija, 11, [En Ejecucion])
    Envia = Array()
    AddParam Envia, "BTR"
    If Not Bac_Sql_Execute("SP_ACT_CARTERA_LIBRE_TRADING", Envia) Then
        Call DllParametros.Func_MoveEventControls(RentaFija, 11, [Finalizado c / Warning])
        Call WriteLogFile("Clase Renta Fija : Error en proceso de Aperura, Error en proceso de actualización de Cartera Libre Trading, proceso finalizo con Warning.")
    Else
        Call DllParametros.Func_MoveEventControls(RentaFija, 11, [Finalizado Ok])
    End If


    Call DllParametros.Func_MoveEventControls(RentaFija, 12, [En Ejecucion])
    If funcProcesaRecompras = False Then
        Call DllParametros.Func_MoveEventControls(RentaFija, 12, [Finalizado c / Warning])
        Call WriteLogFile("Clase Renta Fija : Error en proceso de Aperura, Error en proceso de Recompras Automaticas, Proceso Finalizo con Warning.")
    Else
        Call DllParametros.Func_MoveEventControls(RentaFija, 12, [Finalizado Ok])
    End If


    Call DllParametros.Func_MoveEventControls(RentaFija, 13, [En Ejecucion])
    If funcProcesaReventas = False Then
        Call DllParametros.Func_MoveEventControls(RentaFija, 13, [Finalizado c / Warning])
        Call WriteLogFile("Clase Renta Fija : Error en proceso de Aperura, Error en proceso de Reventas Automaticas, Proceso Finalizo con Warning.")
    Else
        Call DllParametros.Func_MoveEventControls(RentaFija, 13, [Finalizado Ok])
    End If


    Call DllParametros.Func_MoveEventControls(RentaFija, 14, [En Ejecucion])
    If Bac_Sql_Execute("TRASPASOSORTEOLCHR") = False Then
        Call DllParametros.Func_MoveEventControls(RentaFija, 14, [Finalizado c / Warning])
        Call WriteLogFile("Clase Renta Fija : Error en proceso de Aperura, Error en proceso de Traspaso y Sorteo de Letras, Proceso finalizo con Warning.")
    Else
        Call DllParametros.Func_MoveEventControls(RentaFija, 14, [Finalizado Ok])
    End If

    If Proc_Carga_Parametros = False Then
        Call WriteLogFile("Clase Renta Fija : Error en proceso de Aperura, Error en proceso de Carga de parametros.")
    End If


    Call DllParametros.Func_MoveEventControls(RentaFija, 15, [En Ejecucion])
    If ProcesosDeCobertura = False Then
        Call DllParametros.Func_MoveEventControls(RentaFija, 15, [Finalizado c / Warning])
        Call WriteLogFile("Clase Renta Fija : Error en proceso de Aperura, Error en proceso de Coberturas.")
    Else
        Call DllParametros.Func_MoveEventControls(RentaFija, 15, [Finalizado Ok])
    End If


    If Bac_Sql_Execute("Commit Transaction") = False Then
        Call WriteLogFile("Clase Renta Fija : Error en proceso de Aperura, Error en Confirmar la Transaccion")
        Exit Function
    End If
    
    '-> Marca como proceso generado, una vez que los procesos claves han finalizado.
    If DllParametros.Time_Express([Finalizado Ok]) = False Then
        Call DllParametros.Time([Finalizado Ok])
    End If
    '-> Marca como proceso generado, una vez que los procesos claves han finalizado.

    Call DllParametros.Func_MoveEventControls(RentaFija, 17, [En Ejecucion])
    If CargaArchivo_PrestamosIBS = False Then
        Call DllParametros.Func_MoveEventControls(RentaFija, 17, [Finalizado c / Warning])
        Call WriteLogFile("Clase Renta Fija : Error en proceso de Aperura, Error en Proceso carga de prestamos IBS, proceso finalizo con Warning.")
    Else
        Call DllParametros.Func_MoveEventControls(RentaFija, 17, [Finalizado Ok])
    End If
    
    Call DllParametros.Func_MoveEventControls(RentaFija, 18, [En Ejecucion])
    If CargaArchivo_AnticipoIBS = False Then
        Call DllParametros.Func_MoveEventControls(RentaFija, 18, [Finalizado c / Warning])
        Call WriteLogFile("Clase Renta Fija : Error en proceso de Aperura, Error en Proceso carga de anticipos IBS, proceso finalizo con Warning.")
    Else
        Call DllParametros.Func_MoveEventControls(RentaFija, 18, [Finalizado Ok])
        Call Mensajes_Relacion_PAE
    End If
    
    
    Call DllParametros.Func_MoveEventControls(RentaFija, 16, [En Ejecucion])
    If FuncReabajaLineas = False Then
        Call DllParametros.Func_MoveEventControls(RentaFija, 16, [Finalizado c / Warning])
        Call WriteLogFile("Clase Renta Fija : Error en proceso de Aperura, Error en Proceso de Rebaja de Lineas, Proceso Finalizo con Warning.")
    Else
        Call DllParametros.Func_MoveEventControls(RentaFija, 16, [Finalizado Ok])
    End If


    Call DllParametros.Func_MoveEventControls(RentaFija, 19, [En Ejecucion])
        
        Let BacCalculoRec.gsBac_Fecp = cDatosgenerales.gsBac_Fecp
        Call BacCalculoRec.Proc_Recalculo_Lineas_DRV
    
    Call DllParametros.Func_MoveEventControls(RentaFija, 19, [Finalizado Ok])


    Call DllParametros.Func_MoveEventControls(RentaFija, 20, [En Ejecucion])
    If Bac_Sql_Execute("BacParamSuda.DBO.SP_GAR_GRABA_GARANTIAS_FALTANTES") = False Then
        Call DllParametros.Func_MoveEventControls(RentaFija, 20, [Finalizado c / Warning])
        Call WriteLogFile("Clase Renta Fija : Error en proceso de Aperura, Error en Proceso de Garantias.")
    Else
        Call DllParametros.Func_MoveEventControls(RentaFija, 20, [Finalizado Ok])
    End If

    
    If HayMensajesEmail() Then
        ok = EnviaMailGtias
        If ok Then
            Call MarcaEmailsEnviados(False)
        End If
    End If
    
    
    Let ProcesoInicioDia = True
    'Apertura Mesas y envio de correo
    Call FuncAperturaMesa_BacCambio_RentaFija_Opciones
    Call EnvioMailInicioDia

    '->  Cierra la Conexion
    Call miSQL.SQL_Close

End Function

Public Function FuncAperturaMesa_BacCambio_RentaFija_Opciones() As Boolean

    Dim cSql As String
    'Realiza Inicio día de BacCambio
    Envia = Array()
    AddParam Envia, 6
    AddParam Envia, 0
    AddParam Envia, 1
    If Not Bac_Sql_Execute("BacCamSuda.dbo.SP_GRABA_SWITCH ", Envia) Then
        Call WriteLogFile("Clase Parámetros : Apertura mesa BacCamSuda, Mensaje : Error inesperado. (SP_GRABA_SWITCH )")
        Exit Function
    End If
    'Realiza Inicio día de Renta Fija
    Envia = Array()
    AddParam Envia, 0
    If Not Bac_Sql_Execute("BacTraderSuda.dbo.SP_ACUTALIZAMESA ", Envia) Then
        Call WriteLogFile("Clase Parámetros : Apertura mesa BacTraderSuda, Mensaje : Error inesperado. (SP_ACUTALIZAMESA )")
        Exit Function
    End If
    
   'realiza Inicio día Opciones
   Let cSql = ""
   Let cSql = cSql & " UPDATE lnkopc.CbMdbOpc.dbo.OPCIONESGENERAL "
   Let cSql = cSql & " SET  cierreMesa      = 0 "
   Let cSql = cSql & " ,    findia          = 0"
   Let cSql = cSql & " ,    devengo         = 0"
   Let cSql = cSql & " ,    contabilidad    = 0"
   Let cSql = cSql & " ,    iniciodia       = 1"
   
   If Not Bac_Sql_Execute(cSql) Then
      Exit Function
   End If
       
      
End Function

Private Function BacGrabarParamAc(cFecpro As String, cFecprox As String) As Boolean

    BacGrabarParamAc = False

    Envia = Array(Format(cFecpro, "YYYYMMDD"), Format(cFecprox, "YYYYMMDD"))
    If Not Bac_Sql_Execute("SP_GRABARPARAMAC", Envia) Then
        Call WriteLogFile("Clase Renta Fija : Error en proceso de Aperura, Error en Grabacion de Parametros.")
        Exit Function
    End If
    
    BacGrabarParamAc = True

End Function



Private Function Func_Buscar_Datos(cFecpro As String, cFecprox As String, ValorMonedaProceso As nValores_Monedas) As Boolean
    Dim Fila        As Long

    Func_Buscar_Datos = False

    If BacChkFechas() = False Then
        Call WriteLogFile("Clase Renta Fija : Error en proceso de Aperura, Error en chequeo de fechas.")
        Exit Function
    End If
    
    If BacLeeParamPd(cFecpro, cFecprox, ValorMonedaProceso) = False Then
        Call WriteLogFile("Clase Renta Fija : Error en proceso de Aperura, Error en lectura de Parametros.")
        Exit Function
    End If
    
    Func_Buscar_Datos = True
    
End Function


Private Function BacLeeParamPd(Fechapro As String, Fechaprox As String, ValorMonedaProceso As nValores_Monedas) As Boolean
    Dim nIndice  As Long
    Dim Datos()
    

    BacLeeParamPd = False

    Envia = Array(Fechapro, Fechaprox)
    If Not Bac_Sql_Execute("SP_LEERPD", Envia) Then
        Call WriteLogFile("Clase Renta Fija : Error en proceso de Aperura, Error en lectura de Parametros.")
        Exit Function
    End If
    Do While Bac_SQL_Fetch(Datos())
        ReDim Preserve ValorMonedaProceso.dValoresMonedas(nIndice)
        Let ValorMonedaProceso.dValoresMonedas(nIndice).vmcodigo = Datos(1)
        Let ValorMonedaProceso.dValoresMonedas(nIndice).vmdescripcion = Datos(2)
        Let ValorMonedaProceso.dValoresMonedas(nIndice).vmvalorproceso = Datos(3)
        Let ValorMonedaProceso.dValoresMonedas(nIndice).vmvalorproximo = Datos(4)
        Let ValorMonedaProceso.dValoresMonedas(nIndice).vmcodbcch = Datos(5)
        
        Let nIndice = nIndice + 1
    Loop

    BacLeeParamPd = True
End Function

Private Function Proc_Carga_Parametros() As Boolean
    Dim Datos()
    Dim cSql    As String

    Proc_Carga_Parametros = False
   
    If Bac_Sql_Execute("SP_PARAMETROS_SISTEMA") Then
        If Bac_SQL_Fetch(Datos()) Then
            cDatosgenerales.gsBac_Fecp = Datos(1)
            cDatosgenerales.gsBac_Clien = Datos(2)
            cDatosgenerales.gsBac_Fecx = Datos(3)
            cDatosgenerales.gsBac_RutC = Datos(4)
            cDatosgenerales.gsBac_DigC = Datos(5)
            cDatosgenerales.gsBac_RutComi = Datos(6)
            cDatosgenerales.gsBac_PrComi = Datos(7)
            cDatosgenerales.gsBac_Iva = Datos(8)

            cDatosgenerales.gsBac_CartRUT = Datos(9)
            cDatosgenerales.gsBac_CartDV = Datos(10)
            cDatosgenerales.gsBac_CartNOM = Datos(11)

            cDatosgenerales.gsBac_Feca = Datos(16)
            cDatosgenerales.gsBAC_FecConFin = cDatosgenerales.gsBac_Feca
            cDatosgenerales.gsBac_TCambio = Datos(13)

            cDatosgenerales.gsBac_RutBCCH = Datos(18)
            cDatosgenerales.gsBac_FPagoBCCH = Datos(19)
            cDatosgenerales.gsBac_NomBCCH = Datos(20)
            cDatosgenerales.gsBac_NomFPagoBCCH = Trim(Datos(21))

            cDatosgenerales.DIAS_PACTO_PAPEL_NO_CENTRAL = Datos(14)
            cDatosgenerales.MONTO_PATRIMONIO_EFECTIVO = Datos(15)
            cDatosgenerales.DIAS_PACTO_PAPEL_NO_CENTRAL_90 = 1
            
            
            BacCalculoRec.gsBAC_FecConFin = cDatosgenerales.gsBac_Feca
        End If
    Else
        Exit Function
    End If

    Proc_Carga_Parametros = True

End Function

Private Function BacLeerParamAc(ByRef cFecpro As String, ByRef cFecprox As String, ByRef cSW_PD As String) As Boolean
    Dim Datos()
    
    BacLeerParamAc = False

    If Not Bac_Sql_Execute("SP_LEERPARAMAC") Then
        Call WriteLogFile("Clase Renta Fija : Error en proceso de Aperura, Error sobre ejecución Sp_LeerParaMac")
        Exit Function
    End If
    If Bac_SQL_Fetch(Datos()) Then
        cFecpro = Format(Datos(2), "DD/MM/YYYY")
        cFecprox = Format(Datos(2), "DD/MM/YYYY")
        cSW_PD = Datos(3)
        cFecprox = Format(DateAdd("d", 1, cFecprox), "DD/MM/YYYY")
        
        BacLeerParamAc = True
    End If
    
    While Weekday(cFecprox) = vbSunday Or Weekday(cFecprox) = vbSaturday Or Not BacEsHabil(cFecprox)
        cFecprox = DateAdd("d", 1, cFecprox)
    Wend

    BacLeerParamAc = True
End Function

Private Function BacEsHabil(cFecha As String) As Boolean
    Dim objFeriado  As New clsFeriado
    Dim iAno        As Integer
    Dim iMes        As Integer
    Dim cDia        As String
    Dim gcPlaza     As String
    Dim n           As Integer
    Dim sDia        As String

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
    Dim x           As Single
    Dim xPsw        As String
    Dim Letras      As String
    Dim Codigos     As String

    Letras = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890abcdefghijklmnopqrstuvwxyzÑñ#$%&()*+/=[\]_{}"
    Codigos = "RaMbKCgTrZHYFIPAuSiQVONmLfJWzGXEDqBUx_kpjcys{dn}ve]htwl[\`@?><Ññ1234567890;:.'~¿"
    xPsw = ""
    Encript = ""

    For x = 1 To Len(xClave)
        If xEncriptar Then
            xPsw = xPsw + Chr((Asc(Mid(Codigos, InStr(1, Letras, Mid(xClave, x, 1)), 1)) - x))
        Else
            xPsw = xPsw + Mid(Letras, InStr(1, Codigos, Chr(Asc(Mid(xClave, x, 1)) + x)), 1)
        End If
    Next

    Encript = xPsw
End Function


Private Function CantidadGtiasVencidas(ByVal tipo As String) As Long
    Dim nomSp       As String
    Dim cant        As Long
    Dim Datos()
    
    cant = 0
    CantidadGtiasVencidas = -1
        
    Envia = Array()
    AddParam Envia, tipo
    AddParam Envia, cDatosgenerales.gsBac_Fecp
    If Not Bac_Sql_Execute("BacParamSuda.DBO.SP_CANTGARANTIASVENCIDAS", Envia) Then
        Call WriteLogFile("Trader : Error en proceso [SP_CANTGARANTIASVENCIDAS]")
        Exit Function
    End If
    If Bac_SQL_Fetch(Datos()) Then
        cant = CLng(Datos(1))
    End If
    CantidadGtiasVencidas = cant

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
    BacChkFecpro = False
    
    If BacEsHabil(dFechaProceso) = True Then
        BacChkFecpro = True
    Else
        If Month(dFechaProceso) = Month(DateAdd("d", 1, dFechaProceso)) Then
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

Private Function Func_Devengar_Dolares() As Boolean
    Func_Devengar_Dolares = False

    Call DllParametros.Func_MoveEventControls(RentaFija, 6, [En Ejecucion])
    If Not Func_Cartera_Inversiones Then
        Call DllParametros.Func_MoveEventControls(RentaFija, 6, [No Finalizado])
        Call WriteLogFile("Clase Renta Fija : Error en proceso de Aperura, Error en Devengamiento de Cartera de Inversiones.")
        Exit Function
    End If
    Call DllParametros.Func_MoveEventControls(RentaFija, 6, [Finalizado Ok])
    
    
    Call DllParametros.Func_MoveEventControls(RentaFija, 7, [En Ejecucion])
    If Not Func_Compras_Con_Pacto Then
        Call DllParametros.Func_MoveEventControls(RentaFija, 7, [No Finalizado])
        Call WriteLogFile("Clase Renta Fija : Error en proceso de Aperura, Error en Devengamiento de Cartera de Compras con Pacto.")
        Exit Function
    End If
    Call DllParametros.Func_MoveEventControls(RentaFija, 7, [Finalizado Ok])
    
    
    
    Call DllParametros.Func_MoveEventControls(RentaFija, 8, [En Ejecucion])
    If Not Func_Ventas_Con_PactoDolar Then
        Call DllParametros.Func_MoveEventControls(RentaFija, 8, [No Finalizado])
        Call WriteLogFile("Clase Renta Fija : Error en proceso de Aperura, Error en Devengamiento de Cartera de Ventas con Pacto.")
        Exit Function
    End If
    Call DllParametros.Func_MoveEventControls(RentaFija, 8, [Finalizado Ok])
    
    
    
    Call DllParametros.Func_MoveEventControls(RentaFija, 9, [En Ejecucion])
    If Not Func_Interbancario Then
        Call DllParametros.Func_MoveEventControls(RentaFija, 9, [No Finalizado])
        Call WriteLogFile("Clase Renta Fija : Error en proceso de Aperura, Error en Devengamiento de Interbancarios.")
        Exit Function
    End If
    Call DllParametros.Func_MoveEventControls(RentaFija, 9, [Finalizado Ok])
    
    
    Func_Devengar_Dolares = True
End Function

Private Function Func_Cartera_Inversiones() As Boolean
    Dim Sw_Devengo_OK    As String
    Dim Msg_Devengo      As String
    Dim Datos()
    
    Func_Cartera_Inversiones = False

    If cDatosgenerales.gsBac_Fecp <> CHKFECHASDEVENGAMIENTO.gsBac_FM And CHKFECHASDEVENGAMIENTO.Fecha_Proceso_Dev > CHKFECHASDEVENGAMIENTO.gsBac_FM Then
        CHKFECHASDEVENGAMIENTO.Fecha_Anterior = CHKFECHASDEVENGAMIENTO.gsBac_FM
    End If

    Envia = Array()
    AddParam Envia, Format(CHKFECHASDEVENGAMIENTO.Fecha_Anterior, "yyyymmdd")
    AddParam Envia, Format(CHKFECHASDEVENGAMIENTO.Fecha_Proceso_Dev, "yyyymmdd")
    AddParam Envia, CHKFECHASDEVENGAMIENTO.valPCDUSD
    AddParam Envia, CHKFECHASDEVENGAMIENTO.valPCDUF
    AddParam Envia, CHKFECHASDEVENGAMIENTO.valPTF
    AddParam Envia, "S"
    If Bac_Sql_Execute("SP_DEVPROPIAINTER", Envia) Then
        Do While Bac_SQL_Fetch(Datos())
            If Datos(1) <> "SI" Then
                Exit Function
            End If
        Loop
    Else
        Exit Function
    End If
   
   Func_Cartera_Inversiones = True
   
End Function

Private Function Func_Compras_Con_Pacto() As Boolean
    Dim Sw_Devengo_OK    As String
    Dim Msg_Devengo      As String
    Dim Datos()
    
    Func_Compras_Con_Pacto = False

    If cDatosgenerales.gsBac_Fecp <> CHKFECHASDEVENGAMIENTO.gsBac_FM And CHKFECHASDEVENGAMIENTO.Fecha_Proceso_Dev > CHKFECHASDEVENGAMIENTO.gsBac_FM Then
       CHKFECHASDEVENGAMIENTO.Fecha_Anterior = CHKFECHASDEVENGAMIENTO.gsBac_FM
    End If
                 
    Envia = Array()
    AddParam Envia, Format(CHKFECHASDEVENGAMIENTO.Fecha_Anterior, "yyyymmdd")
    AddParam Envia, Format(CHKFECHASDEVENGAMIENTO.Fecha_Proceso_Dev, "yyyymmdd")
    AddParam Envia, CDbl(CHKFECHASDEVENGAMIENTO.valPCDUSD)
    AddParam Envia, CDbl(CHKFECHASDEVENGAMIENTO.valPCDUF)
    AddParam Envia, CDbl(CHKFECHASDEVENGAMIENTO.valPTF)
    AddParam Envia, "S"
    If Bac_Sql_Execute("SP_DEVENGO_COMPRAS_CON_PACTO", Envia) Then
        Do While Bac_SQL_Fetch(Datos())
            If Datos(1) <> "OK" Then
                Exit Function
            End If
        Loop
    Else
        Exit Function
    End If
    
    Func_Compras_Con_Pacto = True
End Function

Private Function Func_Ventas_Con_PactoDolar() As Boolean
    Dim Sw_Devengo_OK    As String
    Dim Msg_Devengo      As String
    Dim Datos()
    
    Func_Ventas_Con_PactoDolar = False
    
    Envia = Array()
    AddParam Envia, Format(CHKFECHASDEVENGAMIENTO.Fecha_Anterior, "yyyymmdd")
    AddParam Envia, Format(CHKFECHASDEVENGAMIENTO.Fecha_Proceso_Dev, "yyyymmdd")
    AddParam Envia, "S"
    If Bac_Sql_Execute("SP_DEVENGO_VENTAS_CON_PACTO", Envia) Then
        Do While Bac_SQL_Fetch(Datos())
            If Datos(1) <> "OK" Then
                Exit Function
            End If
        Loop
    Else
        Exit Function
    End If

    Func_Ventas_Con_PactoDolar = True
End Function


Private Function Func_Interbancario() As Boolean
    Dim Sw_Devengo_OK    As String
    Dim Msg_Devengo      As String
    Dim Datos()
    
    Func_Interbancario = False

    If cDatosgenerales.gsBac_Fecp <> CHKFECHASDEVENGAMIENTO.gsBac_FM And CHKFECHASDEVENGAMIENTO.Fecha_Proceso_Dev > CHKFECHASDEVENGAMIENTO.gsBac_FM Then
        CHKFECHASDEVENGAMIENTO.Fecha_Anterior = CHKFECHASDEVENGAMIENTO.gsBac_FM
    End If
    
    Envia = Array()
    AddParam Envia, Format(CHKFECHASDEVENGAMIENTO.Fecha_Anterior, "yyyymmdd")
    AddParam Envia, Format(CHKFECHASDEVENGAMIENTO.Fecha_Proceso_Dev, "yyyymmdd")
    AddParam Envia, "S"
    If Bac_Sql_Execute("SP_DEVENGO_INTERBANCARIOS", Envia) Then
        Do While Bac_SQL_Fetch(Datos())
            If Datos(1) <> "OK" Then
                Exit Function
            End If
        Loop
    Else
        Exit Function
    End If

   Func_Interbancario = True
End Function




Private Function funcProcesaRecompras() As Boolean
    Dim Datos()
    
    funcProcesaRecompras = False
    
    Envia = Array(gsBac_User, gsBac_IP)
    If Not Bac_Sql_Execute("SP_RECOMPRA_AUTOMATICA", Envia) Then
        Call WriteLogFile("Clase Renta Fija : Error en proceso de Aperura, Error en proceso de Recompras Automaticas, Error en la Ejecucion")
        Exit Function
    End If
    If Bac_SQL_Fetch(Datos()) Then
        If Datos(1) = "NO" Then
            Call WriteLogFile("Clase Renta Fija : Error en proceso de Aperura, Error en proceso de Recompras Automaticas, Error en Sql")
            Exit Function
        End If
    End If
    
    funcProcesaRecompras = True
End Function

Private Function funcProcesaReventas() As Boolean
    Dim Datos()

    funcProcesaReventas = False

    Envia = Array(gsBac_User, gsBac_IP)
    If Not Bac_Sql_Execute("SP_REVENTA_AUTOMATICA", Envia) Then
        Call WriteLogFile("Clase Renta Fija : Error en proceso de Aperura, Error en proceso de Reventas Automaticas, Error en ejecucion.")
        Exit Function
    End If
    If Bac_SQL_Fetch(Datos()) Then
        If Datos(1) = "NO" Then
            Call WriteLogFile("Clase Renta Fija : Error en proceso de Aperura, Error en proceso de Reventas Automaticas, Error en Sql.")
            Exit Function
        End If
    End If

    funcProcesaReventas = True
End Function

Private Function ProcesosDeCobertura() As Boolean
    Dim Datos()
    
    ProcesosDeCobertura = False
   
    Envia = Array()
    If Not Bac_Sql_Execute("BacTraderSuda..SP_VENCIMIENTOS_COBERTURAS") Then
        Call WriteLogFile("Clase Renta Fija : Error en proceso de Aperura, Error en proceso de Coberturas, Error en Ejecucion de Vencimientos")
    End If
   
    Envia = Array()
    If Not Bac_Sql_Execute("BacTraderSuda..SP_ACTUALIZACION_COBERTURAS") Then
        Call WriteLogFile("Clase Renta Fija : Error en proceso de Aperura, Error en proceso de Coberturas, Error en Ejecucion de Actualizacion")
    End If

    ProcesosDeCobertura = True

End Function

Private Function FuncReabajaLineas() As Boolean
   FuncReabajaLineas = False

   Envia = Array()
   AddParam Envia, CDate(dFechaProceso)
   AddParam Envia, "BTR"
   If Not Bac_Sql_Execute("SP_LINEAS_ACTUALIZARMONTOS", Envia) Then
        Call WriteLogFile("Clase Renta Fija : Error en proceso de Aperura, Error en Proceso de Rebaja de Lineas, Error en la Ejecucion.")
        FuncReabajaLineas = True
        Exit Function
   End If

   FuncReabajaLineas = True
End Function


Private Function CargaArchivo_PrestamosIBS()
    Dim oPath                   As String
    Dim cNombreArchivo          As String
    Dim ruta                    As String
    Dim SeparadorCampo          As String
    Dim xLine$
    Dim Prueba                  As String
    Dim IBS_FecProc             As String
    Dim IBS_NumPrestamo         As Long
    Dim IBS_CodProd             As String
    Dim IBS_CodFam              As String
    Dim IBS_NumDerivado         As Long
    Dim IBS_cTipo               As String
    Dim IBS_Fecini              As String
    Dim IBS_FecVenc             As String
    Dim IBS_Monto               As Double
    Dim IBS_CodTasa             As String
    Dim IBS_TipoTasa            As String
    Dim IBS_TasaCli             As Double
    Dim IBS_Spread              As Double
    Dim IBS_Moneda              As String
    Dim IBS_RuCli               As String
    Dim IBS_cTipoPlazo          As String
    Dim IBS_Plazo               As Long
    Dim IBS_cEstadoOper         As String
    Dim LargoRegistro           As Long
    Dim total_registro          As Long
 
    CargaArchivo_PrestamosIBS = False
 
    If Right(gsBac_DIRPAE, 1) <> "\" Then
        Let gsBac_DIRPAE = gsBac_DIRPAE & "\"
    End If
    
    Envia = Array()
    AddParam Envia, 1
    If Not Bac_Sql_Execute("BacTraderSuda.dbo.SP_ELIMINA_PRESTAMOS_IBS", Envia) Then
        Call WriteLogFile("Clase Renta Fija : Error en proceso de Aperura, Error en Proceso de eliminacion de Prestamos. Error en Sql.")
        Exit Function
    End If

    Let cNombreArchivo = "Derelpae_" & Format(dFechaProceso, "YYYY") & Format(dFechaProceso, "MM") & Format(dFechaProceso, "DD") & ".Dat"
    Let oPath = gsBac_DIRPAE & cNombreArchivo

    If Dir(oPath) = "" Then
        Let CargaArchivo_PrestamosIBS = True
        Call WriteLogFile("Clase Renta Fija : Error en proceso de Aperura, Error en directorio.")
        Exit Function
    End If
   
    total_registro = 0

    '-- carga operaciones
    On Error GoTo errOpen
    Open oPath For Input As #1

    Do While Not EOF(1)
        Line Input #1, xLine
            
        IBS_FecProc = (Mid$(xLine, 1, 8))
        IBS_NumPrestamo = Val(Mid$(xLine, 10, 12))
        IBS_CodProd = (Mid$(xLine, 23, 4))
        IBS_CodFam = (Mid$(xLine, 28, 4))
        IBS_NumDerivado = Val(Mid$(xLine, 33, 12))
        IBS_cTipo = (Mid$(xLine, 46, 1))
        IBS_Fecini = Mid$(xLine, 48, 8)
        IBS_FecVenc = Mid$(xLine, 57, 8)
        IBS_Monto = Val(Mid$(xLine, 66, 17))
        IBS_CodTasa = (Mid$(xLine, 84, 2))
        IBS_TipoTasa = (Mid$(xLine, 87, 35))
        IBS_TasaCli = Val(Mid$(xLine, 123, 10))
        IBS_Spread = Val(Mid$(xLine, 134, 10))
        IBS_Moneda = Mid$(xLine, 145, 3)
        IBS_RuCli = Val(IIf(BacValidaRut(Mid$(xLine, 149, Len(Trim(Mid$(xLine, 149, 15))) - 1), Right(Trim(Mid$(xLine, 149, 15)), 1)) = True, Mid$(xLine, 149, Len(Trim(Mid$(xLine, 149, 15))) - 1), 0))
        IBS_cTipoPlazo = Mid$(xLine, 165, 1)
        IBS_Plazo = Val(Mid$(xLine, 167, 4))
        IBS_cEstadoOper = Mid$(xLine, 172, 30)
        
        LargoRegistro = Len(xLine)
        If LargoRegistro <> 202 Then
            Close #1
            Call WriteLogFile("Clase Renta Fija : Error en proceso de Aperura, Error en Carga Prestamos IBS, Largo del registro distinto a 202.")
            Exit Function
        End If
        
        Envia = Array()
        AddParam Envia, IBS_FecProc
        AddParam Envia, IBS_NumPrestamo
        AddParam Envia, IBS_CodProd
        AddParam Envia, IBS_CodFam
        AddParam Envia, IBS_NumDerivado
        AddParam Envia, IBS_cTipo
        AddParam Envia, IBS_Fecini
        AddParam Envia, IBS_FecVenc
        AddParam Envia, CDbl(IBS_Monto)
        AddParam Envia, IBS_CodTasa
        AddParam Envia, IBS_TipoTasa
        AddParam Envia, CDbl(IBS_TasaCli)
        AddParam Envia, CDbl(IBS_Spread)
        AddParam Envia, IBS_Moneda
        AddParam Envia, IBS_RuCli
        AddParam Envia, IBS_cTipoPlazo
        AddParam Envia, IBS_Plazo
        AddParam Envia, IBS_cEstadoOper
        If Not Bac_Sql_Execute("BacTraderSuda.dbo.SP_GRABA_PRESTAMOS_IBS", Envia) Then
            Close #1
            Call WriteLogFile("Clase Renta Fija : Error en proceso de Aperura, Error en Grabación Prestamos IBS, Largo del registro distinto a 202.")
            Exit Function
        End If
        total_registro = total_registro + 1
    Loop

    Close #1

    CargaArchivo_PrestamosIBS = True

errOpen:

End Function



Private Function CargaArchivo_AnticipoIBS()
    Dim oPath                   As String
    Dim cNombreArchivo          As String
    Dim ruta                    As String
    Dim SeparadorCampo          As String
    Dim xLine$
    Dim Prueba                  As String
    Dim IBS_FecProc             As String
    Dim IBS_NumPrestamo         As Long
    Dim IBS_CodProd             As String
    Dim IBS_CodFam              As String
    Dim IBS_NumDerivado         As Long
    Dim IBS_cTipo               As String
    Dim IBS_cTipoAnti           As String
    Dim IBS_Monto               As Double
    Dim IBS_FecAnti             As String
    Dim IBS_RuCli               As String
    Dim LargoRegistro           As Long
    Dim total_registro          As Long

    CargaArchivo_AnticipoIBS = False

    If Right(gsBac_DIRPAE, 1) <> "\" Then
        Let gsBac_DIRPAE = gsBac_DIRPAE & "\"
    End If

    Let cNombreArchivo = "Derelant_" & Format(dFechaProceso, "YYYY") & Format(dFechaProceso, "MM") & Format(dFechaProceso, "DD") & ".Dat"
    Let oPath = gsBac_DIRPAE & cNombreArchivo

    If Dir(oPath) = "" Then
        Call WriteLogFile("Clase Renta Fija : Error en proceso de Aperura, Error en Proceso carga de anticipos IBS, Error en Directorio.")
        Exit Function
    End If
   
    Envia = Array()
    AddParam Envia, 2
    If Not Bac_Sql_Execute("BacTraderSuda.dbo.SP_ELIMINA_PRESTAMOS_IBS", Envia) Then
        Let Screen.MousePointer = vbDefault
        Call WriteLogFile("Clase Renta Fija : Error en proceso de Aperura, Error en Proceso carga de anticipos IBS, Error en Eliminacion.")
        Exit Function
    End If

    total_registro = 0

    '-- carga operaciones
    On Error GoTo errOpen
    Open oPath For Input As #1
    
    Do While Not EOF(1)
        Line Input #1, xLine
        IBS_NumPrestamo = Val(Mid$(xLine, 1, 12))
        IBS_CodProd = (Mid$(xLine, 14, 4))
        IBS_CodFam = (Mid$(xLine, 19, 4))
        IBS_NumDerivado = Val(Mid$(xLine, 24, 12))
        IBS_cTipo = (Mid$(xLine, 37, 1))
        IBS_cTipoAnti = Mid$(xLine, 39, 30)
        IBS_Monto = Val(Mid$(xLine, 70, 17))
        IBS_FecAnti = Mid$(xLine, 88, 8)
        IBS_RuCli = Val(IIf(BacValidaRut(Mid$(xLine, 97, Len(Trim(Mid$(xLine, 97, 15))) - 1), Right(Trim(Mid$(xLine, 97, 15)), 1)) = True, Mid$(xLine, 97, Len(Trim(Mid$(xLine, 97, 15))) - 1), 0))

        LargoRegistro = Len(xLine)
        If LargoRegistro <> 112 Then
            Close #1
            Call WriteLogFile("Clase Renta Fija : Error en proceso de Aperura, Error en Proceso carga de anticipos IBS, Largo del Registro no es 112.")
            Exit Function
        End If
        
        Envia = Array()
        AddParam Envia, Format(dFechaProceso, "YYYY") & Format(dFechaProceso, "MM") & Format(dFechaProceso, "DD")
        AddParam Envia, IBS_NumPrestamo
        AddParam Envia, IBS_CodProd
        AddParam Envia, IBS_CodFam
        AddParam Envia, IBS_NumDerivado
        AddParam Envia, IBS_cTipo
        AddParam Envia, IBS_cTipoAnti
        AddParam Envia, CDbl(IBS_Monto)
        AddParam Envia, IBS_FecAnti
        AddParam Envia, IBS_RuCli
        If Not Bac_Sql_Execute("BacTraderSuda.dbo.SP_GRABA_ANTICIPOS_IBS", Envia) Then
            Close #1
            Call WriteLogFile("Clase Renta Fija : Error en proceso de Aperura, Error en Proceso Grabacion de anticipos IBS.")
            Exit Function
        End If
        
        total_registro = total_registro + 1
    Loop

    Close #1

    CargaArchivo_AnticipoIBS = True

errOpen:

End Function



Private Function Mensajes_Relacion_PAE()
    Dim MensjDRV  As String
    Dim MensjOPC  As String
    Dim MensjBFW  As String
    Dim MensjPCS  As String
    Dim MensjANT  As String
    Dim Asunto    As String
    Dim Usuario   As String
    Dim Mail      As String
    Dim Cont      As Long
    Dim Firma     As String
    Dim reg       As Long
    Dim Datos()
    
    Let MensjBFW = ""
    Let MensjPCS = ""

    Mensajes_Relacion_PAE = False
 
    Let reg = 1
 
    On Error GoTo errOpen
 
    Envia = Array()
    AddParam Envia, dFechaProceso
    If Not Bac_Sql_Execute("BacTraderSuda.dbo.SP_COMPARA_RELACION_IBS_DRV", Envia) Then
        Call WriteLogFile("Clase Renta Fija : Error en proceso de Aperura, Error Relacion PAE, compra la relacion.")
        Exit Function
    End If
                
    Envia = Array()
    AddParam Envia, dFechaProceso
    If Not Bac_Sql_Execute("BacTraderSuda.dbo.SP_RESCATA_ERRORES_RELACION_IBS_DRV", Envia) Then
        Call WriteLogFile("Clase Renta Fija : Error en proceso de Aperura, Error Relacion PAE, recuperacion de errores.")
        Exit Function
    End If
    Do While Bac_SQL_Fetch(Datos())
        If Datos(1) = -1 Then
            Let reg = 0
            Call WriteLogFile("Clase Renta Fija : Error en proceso de Aperura, Error Relacion PAE, recuperacion de errores. Error en Sql")
            Exit Do
        End If
   
        If Datos(1) = "OPC" Then
            Let MensjOPC = MensjOPC & "" & Datos(4) & vbCrLf & vbTab
        End If
        
''''    If DATOS(1) = "BFW" Then
''''        Let MensjBFW = MensjBFW & "" & DATOS(4) & vbCrLf & vbTab
''''    End If
''''    If DATOS(1) = "PCS" Then
''''        Let MensjPCS = MensjPCS & "" & DATOS(4) & vbCrLf & vbTab
''''    End If
''''    If DATOS(1) = "ANT" Then
''''        Let MensjANT = MensjANT & "" & DATOS(4) & vbCrLf & vbTab
''''    End If
        Let Firma = Datos(6)
    Loop
    
    If MensjOPC <> "" Then
        Let MensjOPC = " Para préstamos relacionados con Opciones se obtiene la siguiente información :" & vbCrLf & vbCrLf & vbTab & MensjOPC & vbCrLf & vbTab
    End If
                     
''''    If MensjBFW <> "" Then
''''        Let MensjBFW = " Para préstamos relacionados con Forward se obtiene la siguiente información :" & vbCrLf & vbCrLf & vbTab & MensjBFW & vbCrLf & vbTab
''''    End If
''''
''''    If MensjPCS <> "" Then
''''        Let MensjPCS = " Para préstamos relacionados con Swap se obtiene la siguiente información :" & vbCrLf & vbCrLf & vbTab & MensjPCS & vbCrLf & vbTab
''''    End If
''''
''''    If MensjANT <> "" Then
''''        Let MensjANT = " Los siguientes préstamos son antiguos :" & vbCrLf & vbCrLf & vbTab & MensjANT & vbCrLf & vbTab
''''    End If
      
    If reg = 0 Then
        Let MensjDRV = MensjDRV & " No existe información de carga de archivo. "
    Else
        Let MensjDRV = MensjDRV & MensjOPC & vbCrLf & vbTab & MensjBFW & vbCrLf & vbTab & MensjPCS & vbCrLf & vbTab & MensjANT
    End If
        
    If Not Bac_Sql_Execute("BacTraderSuda.dbo.SP_ENVIOMAILPAE") Then
        Call WriteLogFile("Clase Renta Fija : Error en proceso de Aperura, Error Relacion PAE, Error en envio de mail")
        Exit Function
    Else
        Let Cont = 0
        Do While Bac_SQL_Fetch(Datos())
            Usuario = Usuario & (Datos(1)) & ";"
            Mail = Mail & (Datos(2)) & ";"
            Cont = Cont + 1
        Loop
    End If

    If Cont > 1 Then
        Let Usuario = "Estimados  "
    Else
        Let Usuario = "Estimado  " & Usuario
    End If
        
    If MensjDRV <> "" Then
         Let Asunto = "Información de Carga Archivo PAE"
        Call SendMail_BacIni(Usuario, Mail, MensjDRV, Firma, Asunto)
    End If

    Mensajes_Relacion_PAE = True

errOpen:
    Exit Function
End Function

Private Function SendMail_BacIni(ByVal Contacto As String, ByVal Email As String, ByVal Mensaje As String, ByVal Firma As String, ByVal Subjt As String)
    On Error Resume Next
    
        Dim cBody    As String
        Dim cError   As String
        
        Let cBody = Contacto & "," & vbCrLf & vbCrLf & vbTab & Mensaje & vbCrLf & vbCrLf & "Atte." & vbCrLf & Firma
   
        If ModGeneralTrader.Global_Send_Mail("Luis.Guerra.d@Corpbanca.cl", Email, Subjt, cBody, cError) = False Then
            Call WriteLogFile("Mensaje de : Error en Envio de Mail, Mensaje : " & cError)
        End If

   
    '   Dim Enviar      As Object
    '   Dim ObjCorreo   As Object

    '   Set ObjCorreo = CreateObject("Outlook.Application")
    '   Set Enviar = ObjCorreo.CreateItem(0)

    '   Enviar.To = Email
    '   Enviar.cc = ""
    '   Enviar.Subject = Subjt
    '   Enviar.Body = Contacto & "," & vbCrLf & vbCrLf & vbTab & Mensaje & vbCrLf & vbCrLf & "Atte." & vbCrLf & Firma     '' "Estimado " &
    '   Enviar.Importance = 1
    '   Enviar.Send

    '   Set ObjCorreo = Nothing
    '   Set Enviar = Nothing
   
   On Error GoTo 0
End Function

Private Function SendMail_ModGarantias(ByVal Para As String, ByVal Asunto As String, ByVal Cuerpo As String) As Boolean
    On Error Resume Next

        Dim cError   As String
   
        If ModGeneralTrader.Global_Send_Mail("Luis.Guerra.d@Corpbanca.cl", Para, Asunto, Cuerpo, cError) = False Then
            Call WriteLogFile("Mensaje de : Error en Envio de Mail, Mensaje : " & cError)
        End If

        '   Dim Enviar      As Object
        '   Dim ObjCorreo   As Object
        
        '   Set ObjCorreo = CreateObject("Outlook.Application")
        '   Set Enviar = ObjCorreo.CreateItem(0)

        '   Enviar.To = Para
        '   Enviar.cc = ""
        '   Enviar.Subject = Asunto
        '   Enviar.Body = Cuerpo
        '   Enviar.Importance = 1
        '   Enviar.Send

        '   Set ObjCorreo = Nothing
        '   Set Enviar = Nothing
        '   SendMail_ModGarantias = True

   On Error GoTo 0
End Function



Private Function HayMensajesEmail() As Boolean
    Dim Datos()

    HayMensajesEmail = False

    Envia = Array()
    If Not Bac_Sql_Execute("Bacparamsuda.DBO.SP_CANT_GARANTIAS_FALTANTES") Then
        Call WriteLogFile("Trader : Error en proceso HayMensajesEmail [SP_CANT_GARANTIAS_FALTANTES]")
        Exit Function
    End If
    If Bac_SQL_Fetch(Datos()) <> 0 Then
        If Val(Datos(1)) > 0 Then
            HayMensajesEmail = True
        Else
            Call WriteLogFile("Trader : Error en proceso HayMensajesEmail [HayMensajesEmail = False]")
            HayMensajesEmail = False
        End If
    End If

End Function

Private Function EnviaMailGtias() As Boolean
    Dim Asunto      As String
    Dim Cuerpo      As String
    Dim destinos    As String
    Dim header      As String
    Dim falla       As Integer
    Dim i           As Integer
    Dim p           As Integer
    Dim n           As Integer
    Dim Correos

    Correos = Array()
    Asunto = "Informe de Clientes con Garantías Faltantes"
   'header = EncabezadoEmail()
    destinos = DestinatariosGtias()
    Cuerpo = ContenidoEmail()
    
    If Cuerpo = "" Then
        EnviaMailGtias = False
        Call WriteLogFile("Trader : Error en proceso EnviaMailGtias [cuerpo = '']")
        Exit Function
    End If
    i = 0
    Do While Len(destinos) > 0
        p = InStr(1, destinos, ";")
        If p > 0 Then
            AddParam Correos, Mid(destinos, 1, p - 1)
            destinos = Mid(destinos, p + 1)
            i = i + 1
        Else
            AddParam Correos, destinos
            i = i + 1
            destinos = ""
        End If
    Loop
    
    n = i
    For i = 0 To n - 1
        If Not SendMail_ModGarantias(Correos(i), Asunto, Cuerpo) Then
            falla = falla + 1
        End If
    Next i
    
    If falla = 0 Then
        EnviaMailGtias = True
    Else
        EnviaMailGtias = False
    End If

End Function

Private Function MarcaEmailsEnviados(Optional ByVal Borrar As Boolean = False) As Boolean
    Dim Datos()

    MarcaEmailsEnviados = False

    Envia = Array()
    AddParam Envia, IIf(Borrar = True, "S", "N")
    If Not Bac_Sql_Execute("Bacparamsuda.DBO.SP_GRABA_ENVIOS_EMAILGTIAS", Envia) Then
        Call WriteLogFile("Trader : Error en proceso MarcaEmailsEnviados [SP_GRABA_ENVIOS_EMAILGTIAS]")
        Exit Function
    End If

    MarcaEmailsEnviados = True
End Function

Private Function BacValidaRut(Rut As String, dig As String) As Integer
    Dim i       As Integer
    Dim D       As Integer
    Dim Divi    As Long
    Dim Suma    As Long
    Dim Digito  As String
    Dim multi   As Double

    BacValidaRut = False
    
    If Trim$(Rut) = "" Or Trim$(dig) = "" Then
       Exit Function
    End If
    
    Rut = Format(Rut, "00000000")
    D = 2
    For i = 8 To 1 Step -1
        multi = Val(Mid$(Rut, i, 1)) * D
        Suma = Suma + multi
        D = D + 1
        If D = 8 Then
           D = 2
        End If
    Next i
    
    Divi = (Suma \ 11)
    multi = Divi * 11
    Digito = Trim$(Str$(11 - (Suma - multi)))
    
    If Digito = "10" Then
       Digito = "K"
    End If
    
    If Digito = "11" Then
       Digito = "0"
    End If
    
    devolver = Digito
    
    If Trim$(UCase$(Digito)) = UCase$(Trim$(dig)) Then
       BacValidaRut = True
    End If
    
End Function

Private Function DestinatariosGtias() As String
    Dim Lista As String
    Dim Datos()
    
    Envia = Array()
    AddParam Envia, 1
    If Not Bac_Sql_Execute("Bacparamsuda.DBO.SP_RETDESTINATARIOSEMAILGTIAS", Envia) Then
        Call WriteLogFile("Trader : Error en proceso DestinatariosGtias [SP_RETDESTINATARIOSEMAILGTIAS]")
        Exit Function
    End If
    Do While Bac_SQL_Fetch(Datos())
        Lista = Lista & Datos(2) & ";"
    Loop
    Lista = Mid(Lista, 1, Len(Lista) - 1)

    DestinatariosGtias = Lista
End Function

Private Function EncabezadoEmail() As String
    Dim Datos()
    
    EncabezadoEmail = ""
    
    If Not Bac_Sql_Execute("Bacparamsuda.DBO.SP_RETMENSAJEEMAILGTIAS") Then
        Call WriteLogFile("Trader : Error en proceso EncabezadoEmail [SP_RETMENSAJEEMAILGTIAS]")
        Exit Function
    End If
    If Bac_SQL_Fetch(Datos()) <> 0 Then
        EncabezadoEmail = Datos(1)
    End If

End Function


Private Function ContenidoEmail() As String
    Dim Cuerpo As String
    Dim enc As String
    Dim Datos()
    
    enc = EncabezadoEmail()
    Cuerpo = ""
    Cuerpo = enc & vbCrLf & vbCrLf & "N° de Garantía  Rut Cliente    Cód. Cliente   Nombre del Cliente                        Monto Faltante             Monto Requerido" & vbCrLf
    Cuerpo = Cuerpo & "-------------------------------------------------------------------------------------------------------------------------------------------------" & vbCrLf
    
    Envia = Array()
    If Not Bac_Sql_Execute("Bacparamsuda.DBO.SP_RET_GARANTIAS_FALTANTES") Then
        ContenidoEmail = ""
        Call WriteLogFile("Trader : Error en proceso ContenidoEmail [SP_RET_GARANTIAS_FALTANTES]")
        Exit Function
    End If
    Do While Bac_SQL_Fetch(Datos())
        Cuerpo = Cuerpo & Space(10) & Format(Datos(5), "###,###,##0") & Space(13) & Format(Datos(2), FEntero) & Space(9) & Datos(3) & Space(15) & Datos(4) & Space(10) & Format(Datos(6), FEntero) & Space(5) & Format(Datos(7), FEntero) & vbCrLf
    Loop
    ContenidoEmail = Cuerpo
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

Public Function EnvioMailInicioDia()
    On Error Resume Next
    
        Dim cCuerpo     As String
        Dim cError      As String
        Dim cPara       As String
        Dim cAsunto       As String
        Dim Mensaje     As String
        Dim cCategoria As Integer
        Dim cAsuntoCuerpo As Integer
        Dim Datos()
        Let cCategoria = 8608
                      
        If gsSQL_Server <> "CORPSQL05" Then
            Exit Function
        End If

        Envia = Array()
        AddParam Envia, cCategoria '   Indicador accion
        If Not Bac_Sql_Execute("Execute BacParamSuda.dbo.SP_LEERENVIOMAIL", Envia) Then
            Call WriteLogFile("Mensaje de : Destinatarios Mail, Error en Envio de Mail, Mensaje : " & "Error Inesperado" & ", " & ("BacParamSuda.dbo.SP_LEERENVIOMAIL"))
        Else
            Do While Bac_SQL_Fetch(Datos())
                    
                If Trim(Datos(6)) = "DESTINO" Then
                
                    Let cPara = cPara + (Datos(5)) & ";"
                    
                ElseIf Trim(Datos(6)) = "ASUNTO" Then
                
                    Let cAsunto = cAsunto + (Datos(5))
                
                ElseIf Trim(Datos(6)) = "CUERPO" Then
                
                    Let Mensaje = Mensaje + (Datos(5))
                
                End If
                                  
            Loop
        End If
                        
        Let cCuerpo = Mensaje & vbCrLf & vbCrLf & "Atte."   '& vbCrLf & Firma
   
        If ModGeneralTrader.Global_Send_Mail("Patricio.Angulo@Corpbanca.cl", cPara, cAsunto, cCuerpo, cError) = False Then
            Call WriteLogFile("Mensaje de : Error en Envio de Mail Inicio Dia, Mensaje : " & cError)
        End If
   
   On Error GoTo 0
End Function

