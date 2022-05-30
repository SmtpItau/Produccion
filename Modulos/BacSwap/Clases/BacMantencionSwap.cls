VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsMantencionSwap"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Public NumOperacion As Long
Public TipoOperacion As Long
Public coleccion As New Collection
Public MetodologiaLCRCliente As Integer 'PROD-10967


Function AnularDatos() As Boolean

Dim SQL           As String
Dim Datos()
 
   AnularDatos = False
    
   If Not Bac_Sql_Execute("BEGIN TRANSACTION") Then
      Exit Function

   End If

'   Sql = "EXECUTE  sp_anulaoperswaps " & NumOperacion
    Envia = Array()
    AddParam Envia, CDbl(NumOperacion)
    AddParam Envia, Format(Time, "HH:MM:SS")
          
'   If MISQL.SQL_Execute(Sql) <> 0 Then
   If Not Bac_Sql_Execute("SP_ANULAOPERSWAPS", Envia) Then
      If Not Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
         Exit Function
   
      End If

      Exit Function

   End If

   'PROD-10967
   If MetodologiaLCRCliente = 1 Or MetodologiaLCRCliente = 4 Then
       If Not Lineas_Anular(Sistema, CDbl(NumOperacion)) Then   'Primero Anula Monto Anterior
          If Not Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
             Exit Function
          End If
        End If
        
   End If  'PROD-10967
   
   If Not Bac_Sql_Execute("COMMIT TRANSACTION") Then
      Exit Function
   End If
   
    '+++CONTROL IDD, jcamposd llamada a nuevo control IDD para las líneas
    Dim oParametrosLinea As New clsControlLineaIDD
    
    With oParametrosLinea
            .Modulo = Sistema
            .Producto = TipoOperacion
            .Operacion = CDbl(NumOperacion)
            .Documento = CDbl(NumOperacion)
            .Correlativo = 0
            .Accion = "R"
    
            .RecuperaDatosLineaIDD
            If .numeroiddAnula <> 0 Then
                .EjecutaProcesoWsLineaIDD
            End If
    End With
    Set oParametrosLinea = Nothing
    On Error GoTo seguirProcesoAnula
    '---CONTROL IDD, jcamposd llamada a nuevo control IDD para las líneas
seguirProcesoAnula:
 
   AnularDatos = True
   
End Function

Function LeerDatos() As Boolean

Dim SQL           As String
Dim Datos()
Dim objBuffer     As Object

   LeerDatos = False
          
   Envia = Array()
   AddParam Envia, CDbl(NumOperacion)
   AddParam Envia, CDbl(TipoOperacion)

   If Not Bac_Sql_Execute("SP_LEEROPERACION", Envia) Then
      Exit Function

   End If

   Do While Bac_SQL_Fetch(Datos())
        
        Set objBuffer = New ClsMovimSwaps

        With objBuffer
            .swNumOperacion = Val(Datos(1))
            .swNumFlujo = Val(Datos(2))
            .swTipoSwap = Val(Datos(3))
            .swCarteraInversion = Val(Datos(4))
            .swTipoOperacion = Datos(5)
            .swCodCliente = Val(Datos(6))
            
            .swNomCliente = Datos(7)
            .swFechaCierre = Datos(8)
            .swFechaInicio = Datos(9)
            .swFechaTermino = Datos(10)
            .swFechaInicioFlujo = Datos(11)
            .swFechaVenceFlujo = Datos(12)
            .swCMoneda = Val(Datos(13))
            .swCCapital = BacStrTran((Datos(14)), ".", gsc_PuntoDecim)
            .swCAmortiza = BacStrTran((Datos(15)), ".", gsc_PuntoDecim)
            .swCSaldo = BacStrTran((Datos(16)), ".", gsc_PuntoDecim)
            .swCInteres = BacStrTran((Datos(17)), ".", gsc_PuntoDecim)
            .swCSpread = BacStrTran((Datos(18)), ".", gsc_PuntoDecim)
            .swCCodigoTasa = Val(Datos(19))
            .swCValorTasa = BacStrTran((Datos(20)), ".", gsc_PuntoDecim)
            .swCValorTasaHoy = BacStrTran((Datos(21)), ".", gsc_PuntoDecim)
            .swCCodAmoCapital = Val(Datos(22))
            .swCMesAmoCapital = Val(Datos(23))
            .swCCodAmoInteres = Val(Datos(24))
            .swCMesAmoInteres = Val(Datos(25))
            .swCBase = Val(Datos(26))
            .swVMoneda = Val(Datos(27))
            .swVCapital = BacStrTran((Datos(28)), ".", gsc_PuntoDecim)
            .swVAmortiza = BacStrTran((Datos(29)), ".", gsc_PuntoDecim)
            .swVSaldo = BacStrTran((Datos(30)), ".", gsc_PuntoDecim)
            .swVInteres = BacStrTran((Datos(31)), ".", gsc_PuntoDecim)
            .swVSpread = BacStrTran((Datos(32)), ".", gsc_PuntoDecim)
            .swVCodigoTasa = Val(Datos(33))
            .swVValorTasa = BacStrTran((Datos(34)), ".", gsc_PuntoDecim)
            .swVValorTasaHoy = BacStrTran((Datos(35)), ".", gsc_PuntoDecim)
            .swVCodAmoCapital = Val(Datos(36))
            .swVMesAmoCapital = Val(Datos(37))
            .swVCodAmoInteres = Val(Datos(38))
            .swVMesAmoInteres = Val(Datos(39))
            .swVBase = Val(Datos(40))
            .swOperador = Datos(41)
            .swOperadorCliente = Val(Datos(42))
            .swEstadoFlujo = Val(Datos(43))
            .swModalidadPago = Datos(44)
            .swPagMoneda = Val(Datos(45))
            .swPagDocumento = Val(Datos(46))
            .swPagMonto = BacStrTran((Datos(47)), ".", gsc_PuntoDecim)
            .swPagMontoUSD = BacStrTran((Datos(48)), ".", gsc_PuntoDecim)
            .swPagMontoCLP = BacStrTran((Datos(49)), ".", gsc_PuntoDecim)
            .swRecMoneda = Val(Datos(50))
            .swRecDocumento = Val(Datos(51))
            .swRecMonto = BacStrTran((Datos(52)), ".", gsc_PuntoDecim)
            .swRecMontoUSD = BacStrTran((Datos(53)), ".", gsc_PuntoDecim)
            .swRecMontoCLP = BacStrTran((Datos(54)), ".", gsc_PuntoDecim)
            .swObservaciones = Datos(55)
            .swFechaModifica = Datos(56)
            .swRutCliente = Datos(57)
            .swTipoFlujo = BacStrTran((Datos(58)), ".", gsc_PuntoDecim)
            .swEspecial = Datos(59)
            .swFechaFijacionTasa = Datos(60)
            
            .swAreaResp = IIf(IsNull(Datos(61)), "", Trim(Datos(61)))
            .swCartNorm = IIf(IsNull(Datos(62)), "", Trim(Datos(62)))
            .swSubCartNorm = IIf(IsNull(Datos(63)), "", Trim(Datos(63)))
            .swLibro = IIf(IsNull(Datos(64)), "", Trim(Datos(64)))
            
        End With
    
        coleccion.Add objBuffer
        Set objBuffer = Nothing

   Loop
       
   LeerDatos = True
   
End Function
