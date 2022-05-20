VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsOperacion"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
Public Fecha                    As String
Public hora                     As String
Public Operador                 As String
Public Correlativo              As Integer
Public Mercado                  As String
Public Operacion                As String
Public Moneda                   As String
Public MonedaCnv                As String
Public MontoOrigen              As Double
Public Precio                   As Double
Public MontoPesos               As Double
Public Rut                      As Long
Public dv                       As String
Public Codigo                   As Long
Public Nombre                   As String
Public Nula                     As String       '-- S=Sí de anula, N=es vigente
Public Usuario_OtcDatatec       As String

Public CodigoOMA                As Integer
Public codigo_area              As String
Public Codigo_Comercio          As String
Public codigo_concepto          As String

Public Linea                    As Integer
Public CostoFondo               As Double
Public TipoCambio               As Double
Public Paridad                  As Double
Public MontoUSD                 As Double
Public CostoParidad             As Double
Public CostoPrecio              As Double
Public CostoMontoUSD            As Double
Public CostoTipoCambio          As Double

Public RecibimosCodigo          As Integer
Public RecibimosValuta          As String
Public EntregamosCodigo         As Integer
Public EntregamosValuta         As String

Public gsUsuario                As String
Public gsBAC_User               As String

Public gs_dias_compra_mn        As Integer
Public gs_dias_compra_mx        As Integer
Public gs_dias_venta_mn         As Integer
Public gs_dias_venta_mx         As Integer

Public Numero&
Public Girador_Rut&
Public Girador_Codigo&
Public Girador_Nombre$
Public gsBac_Lineas             As String

Public ESTADO$
Public Rentabilidad%
Public Terminal$
Public Entidad&
Public OWCorresponsal#
Public MontoFinal#
Public Dias%
Public Arb_Utilidad_Peso#
Public Arb_Tipo_Cambio_MX#
Public FechaVcto$
Public Vamos%
Public Numero_O                 As Double

Private Type ArbiSW_Pl
    SW_corr_Desde               As String
    SW_corr_Donde               As String
    SW_corr_quien               As String
    PL_corr_Desde               As Integer
    PL_corr_Donde               As Integer
    PL_corr_Quien               As Integer
    Cod_Corresponsal            As Double
End Type
Private Arbitrajes              As ArbiSW_Pl

Private Type Canjes
    FechaMnCl                   As String
    FechaMxCl                   As String
    FpagoMnCl                   As Integer
    FpagoMxCl                   As Integer
End Type
Private ObjCanjes               As Canjes

Private Type oValore_Por_Defecto
    gs_ID_Sistema               As String
    gs_Codigo_Producto          As String
    gs_Codigo_Area              As String
    gs_Compra_Forma_Entregamos  As Integer
    gs_Compra_Forma_Recibimos   As Integer
    gs_Compra_Codigo_OMA        As Integer
    gs_Compra_Codigo_Comercio   As String
    gs_Compra_Codigo_Concepto   As String
    gs_Venta_Forma_Entregamos   As Integer
    gs_Venta_Forma_Recibimos    As Integer
    gs_Venta_Codigo_OMA         As Integer
    gs_Venta_Codigo_Comercio    As String
    gs_Venta_Codigo_Concepto    As String
    gs_Contabiliza              As String
    gs_Monto_Operacion          As String
    gs_Codigo_Moneda            As Integer
    gs_UserDatatec              As String
    gs_UserBolsa                As String
    gs_CostoCom                 As Integer
    gs_CostoVen                 As Integer
    gs_Corresponsal_Compra      As Integer
    gs_Corresponsal_Venta       As Integer
End Type
Private Valore_Por_Defecto      As oValore_Por_Defecto

Private sgBacFechaProceso       As String

Private Const gsc_FechaDMA = "DD/MM/YYYY"
Private Const gsSQL_DatabaseLineas = "BacLineas"


Public Function Limpiar()
    Let Fecha = ""
    Let hora = ""
    Let Operador = ""
    Let Correlativo = 0
    Let Mercado = ""
    Let Operacion = ""
    Let Moneda = ""
    Let MonedaCnv = ""
    Let MontoOrigen = 0#
    Let Precio = 0#
    Let MontoPesos = 0#
    Let Rut = 0
    Let dv = ""
    Let Codigo = 0
    Let Nombre = ""
    Let Nula = ""
    Let Usuario_OtcDatatec = ""

    Let CodigoOMA = 0

   ' Let codigo_area = ""
   ' Let Codigo_Comercio = ""
   ' Let codigo_concepto = ""

    Let Linea = 0
    Let CostoFondo = 0
    Let TipoCambio = 0
    Let Paridad = 0
    Let MontoUSD = 0
    Let CostoParidad = 0
    Let CostoPrecio = 0
    Let CostoMontoUSD = 0
    Let CostoTipoCambio = 0

    Let RecibimosCodigo = 0
    Let RecibimosValuta = ""
    Let EntregamosCodigo = 0
    Let EntregamosValuta = ""

    Let gsUsuario = ""
    Let gsBAC_User = ""

 '  Let gs_dias_compra_mn = 0
 '  Let gs_dias_compra_mx = 0
 '  Let gs_dias_venta_mn = 0
 '  Let gs_dias_venta_mx = 0

    Let Numero = 0

    Let Girador_Rut = 0
    Let Girador_Codigo = 0
    Let Girador_Nombre = ""

    Let gsBac_Lineas = "S"

    Let Rentabilidad = 0
    Let Terminal = ""
    Let Entidad = 0
    Let OWCorresponsal = 0
    Let MontoFinal = 0
    Let Dias = 0
    Let Arb_Utilidad_Peso = 0
    Let Arb_Tipo_Cambio_MX = 0
  ' let FechaVcto$
    Let Vamos = 0
    Let Numero_O = 0
End Function

Public Function BacTX_OnLine(sFecha As String, colOperacion As Collection, Optional Tarde As Integer) As Boolean
    Dim ClsOperacion    As Object
    Dim sIndica         As String
    Dim Fecha           As String
    Dim Msg$
    Dim SQL$
    Dim Datos()

    BacTX_OnLine = False

    sIndica = IIf(Tarde, "T", "D")
    Do While colOperacion.Count > 0
        colOperacion.Remove 1
    Loop
    
    Fecha = sFecha
    
    SQL = "sp_Leer_TXonline '" & Fecha & "','', 0, '" & sIndica & "'"
    If miSQL.SQL_Execute(SQL) <> 0 Then
        Exit Function
    End If

    Do While miSQL.SQL_Fetch(Datos) = 0
        If (Datos(20) = "P" Or Datos(20) = "A") And Val(Datos(22)) = 0 Then
            If True Or Datos(3) = "BOLSA" Then
                Set ClsOperacion = New ClsOperacion

                Call ClsOperacion.Limpiar
                
                ClsOperacion.Fecha = Datos(1)
                ClsOperacion.hora = Datos(2)
                ClsOperacion.Operador = Datos(3)
                ClsOperacion.Correlativo = Val(Datos(4))
                ClsOperacion.Mercado = Datos(6)
                ClsOperacion.Operacion = Datos(7)
                ClsOperacion.Moneda = Datos(8)
                ClsOperacion.MonedaCnv = Datos(9)
                ClsOperacion.MontoOrigen = CDbl(Datos(10))
                ClsOperacion.Precio = CDbl(Datos(11))
                ClsOperacion.MontoPesos = Val(Datos(12))
                ClsOperacion.Rut = Val(Datos(13))
                ClsOperacion.dv = Datos(14)
                ClsOperacion.Codigo = Val(Datos(15))
                ClsOperacion.Nombre = Datos(16)
                ClsOperacion.Nula = Datos(20)
                ClsOperacion.Usuario_OtcDatatec = Datos(19)

                colOperacion.Add ClsOperacion

                Set ClsOperacion = Nothing
                BacTX_OnLine = True
            End If
        End If
    Loop
                
End Function

Public Function PreGrabado_TxOnLine(Fecha_Proceso As Date, iEntidad As Long) As Boolean
    Dim nTipCli     As Integer
    Dim nMoneda     As Integer
    Dim nMonedaCnv  As Integer
    Dim Datos()
    
    PreGrabado_TxOnLine = False

    Entidad = iEntidad
    
    sgBacFechaProceso = Fecha_Proceso
    nMoneda = 13
    nMonedaCnv = 999

    Envia = Array()
    AddParam Envia, CDbl(Rut)
    AddParam Envia, CDbl(Codigo)
    If Not Bac_Sql_Execute("sp_BuscaTipCli", Envia) Then
       Exit Function
    End If
    If Bac_SQL_Fetch(Datos()) Then
        nTipCli = Datos(1)
    Else
        Exit Function
    End If

    Mercado = IIf(nTipCli = 1, "PTAS", "EMPR")
    
    Call Valor_Defecto_Nuevo(Mercado, Mercado)
    
    If Rut <> 1 And Rut <> 2 And Rut <> 3 And Rut <> 4 And Rut <> 5 And Rut <> 70 Then
        If nTipCli = 1 Then
            If Rut = 97029000 Then
                CodigoOMA = IIf(Operacion = "C", 5, 11)
                Codigo_Comercio = IIf(Operacion = "C", "10051", "20051")
            Else
                CodigoOMA = IIf(Operacion = "C", 2, 7)
                Codigo_Comercio = IIf(Operacion = "C", "10052", "20052")
            End If
        
        Else
            CodigoOMA = IIf(Operacion = "C", Valore_Por_Defecto.gs_Compra_Codigo_OMA, Valore_Por_Defecto.gs_Venta_Codigo_OMA)
            Codigo_Comercio = IIf(Operacion = "C", "10050", "20050")
        End If
    Else
        CodigoOMA = IIf(Operacion = "C", 6, 12)
    End If
    
    Linea = 0
    CostoFondo = IIf(Operacion = "C", Valore_Por_Defecto.gs_CostoCom, Valore_Por_Defecto.gs_CostoVen)
    
    TipoCambio = Precio
    Paridad = 1
    MontoUSD = MontoOrigen * Paridad
    MontoPesos = MontoUSD * TipoCambio
    CostoParidad = Paridad
    CostoPrecio = CostoFondo
    CostoMontoUSD = MontoUSD
    CostoTipoCambio = CostoFondo
    Operador = IIf(Operador = "BOLSA", Valore_Por_Defecto.gs_UserBolsa, Valore_Por_Defecto.gs_UserDatatec)
    gsUsuario = IIf(Operador = "BOLSA", Valore_Por_Defecto.gs_UserBolsa, Valore_Por_Defecto.gs_UserDatatec)
    gsBAC_User = Usuario_OtcDatatec
    
    If Operacion = "C" Then
        RecibimosCodigo = Valore_Por_Defecto.gs_Compra_Forma_Recibimos
        gs_dias_compra_mx = AyudaFPagoDia(RecibimosCodigo, nMoneda)
        RecibimosValuta = Format(CalculaFeriado(Format(Fecha_Proceso, "DD-MM-YYYY"), gs_dias_compra_mx, 0, "USD"), "yyyymmdd")
                   
        EntregamosCodigo = Valore_Por_Defecto.gs_Compra_Forma_Entregamos
        gs_dias_compra_mn = AyudaFPagoDia(EntregamosCodigo, nMonedaCnv)
        
        EntregamosValuta = Format(CalculaFeriado(Format(Fecha_Proceso, "DD-MM-YYYY"), gs_dias_compra_mn, 0), "yyyymmdd")
    Else
        RecibimosCodigo = Valore_Por_Defecto.gs_Venta_Forma_Recibimos
        gs_dias_venta_mn = AyudaFPagoDia(RecibimosCodigo, nMonedaCnv)
        RecibimosValuta = Format(CalculaFeriado(Format(Fecha_Proceso, "DD-MM-YYYY"), gs_dias_venta_mn, 0), "yyyymmdd")
        
        EntregamosCodigo = Valore_Por_Defecto.gs_Venta_Forma_Entregamos
        gs_dias_venta_mx = AyudaFPagoDia(EntregamosCodigo, nMoneda)
        EntregamosValuta = Format(CalculaFeriado(Format(Fecha_Proceso, "DD-MM-YYYY"), gs_dias_venta_mx, 0, "USD"), "yyyymmdd")
    End If
End Function

Public Function Grabar_NextDay(nVentana As Double, CualOpcion As String, FechaProceso As Date) As Boolean
    Dim OperLimite          As String
    Dim RutLineas           As Double
    Dim CodigoCliLineas     As Double
    Dim FecVcto             As Date
    Dim Mensaje_Con         As String
    Dim SwResp              As Integer
    Dim FlagTx              As Boolean
    Dim sCanal              As String
    Dim cCheque             As String
    Dim nRutCheque          As Double
    Dim Mensaje             As String
    Dim gsBAC_Fecp          As Date
    Dim ControlaLinea       As String
    Dim Observacion         As String
    Dim nNumOper            As Double
    Dim cMensaje            As String
    Dim NumOpe
    Dim Mensaje_Lin         As String
    Dim Mensaje_Lim         As String
    Dim Mens_Lin_Graba      As String
    Dim Mens_Lim_Graba      As String
    
    ReDim Datos(1 To 1)

    Grabar_NextDay = False

    gsBAC_Fecp = FechaProceso
    Observacion = ""

    If Moneda = "USD" Then
        OperLimite = Operacion & "S"
        If Mercado = "EMPR" Then
            OperLimite = OperLimite & "E"
        Else
            OperLimite = OperLimite & "B"
        End If
    ElseIf ((RecibimosCodigo = 15 Or RecibimosCodigo = 16) And Mercado = "EMPR") Then
        OperLimite = "AM" & Operacion
        RutLineas = Girador_Rut
        CodigoCliLineas = Girador_Codigo
    End If

    If ((RecibimosCodigo = 15 Or RecibimosCodigo = 16) And Mercado = "EMPR") Or ((EntregamosCodigo = 15 Or EntregamosCodigo = 16) And Mercado = "CANJ") Then
        RutLineas = Girador_Rut
        CodigoCliLineas = Girador_Codigo
    End If

    If Operacion = "V" Then
        FecVcto = Mid$(EntregamosValuta, 7, 2) & "/" & Mid$(EntregamosValuta, 5, 2) & "/" & Mid$(EntregamosValuta, 1, 4)
    Else
        FecVcto = Mid$(RecibimosValuta, 7, 2) & "/" & Mid$(RecibimosValuta, 5, 2) & "/" & Mid$(RecibimosValuta, 1, 4)
    End If

    gsBac_Lineas = "S"
    
    If gsBac_Lineas = "S" And (Mercado = "WEEK" Or Mercado = "OVER" Or Mercado = "PTAS" Or Mercado = "ARBI" Or Mercado = "EMPR" Or Mercado = "CANJ") Then
        cCheque = "N"
        nRutCheque = 0
        
        If Operacion = "V" Then
            FecVcto = Mid$(EntregamosValuta, 7, 2) & "/" & Mid$(EntregamosValuta, 5, 2) & "/" & Mid$(EntregamosValuta, 1, 4)
        Else
            FecVcto = Mid$(RecibimosValuta, 7, 2) & "/" & Mid$(RecibimosValuta, 5, 2) & "/" & Mid$(RecibimosValuta, 1, 4)
            If ((RecibimosCodigo = 15 Or RecibimosCodigo = 16) And Mercado = "EMPR") Or ((EntregamosCodigo = 15 Or EntregamosCodigo = 16) And Mercado = "CANJ") Then
                cCheque = "S"
                nRutCheque = RutLineas
            End If
        End If

        Mensaje = ""
        If Not Lineas_ChequearGrabar("BCC", Mercado, nVentana, 0, 0, CDbl(RutLineas), CDbl(CodigoCliLineas), CDbl(MontoUSD), 0, FecVcto, 0, 0, gsBAC_Fecp, 0, "N", 0, "C", 0, cCheque, nRutCheque, FecVcto, 0, CDbl(RecibimosCodigo)) Then
            GoTo Fin
        End If
        
        ControlaLinea = IIf(Format(gsBAC_Fecp, "yyyymmdd") <> Format(FecVcto, "yyyymmdd") And Rut <> giBAC_RutEntidad, " ", "N")
        Mensaje = Mensaje & Lineas_Chequear("BCC", Mercado, nVentana, Operacion, cCheque, ControlaLinea)
      
        If Mensaje <> "" Then
            MsgBox "Error al Chequear Lineas : " & Chr(10) & Chr(13) & Chr(10) & Chr(13) & Mensaje, vbCritical
            GoTo Fin
        End If

        Numero = 0  '-> No se ocupa
        Mensaje_Con = Lineas_ConsultaOperacion("BCC", Mercado, nVentana, Operacion, cCheque, ControlaLinea, CDbl(Numero))
        
        If Trim(Mensaje_Con) <> "" Then
            SwResp = vbYes '->  MsgBox("ATENCION" & vbCrLf & "LA OPERACION GENERARA LOS SIGUIENTES ERRORES" & Mensaje_Con & vbCrLf & vbCrLf & "¿Desea Grabar la Operación ?", vbYesNo + vbExclamation, " ")
            If SwResp <> vbYes Then
                Call Lineas_BorraConsultaOperacion("BCC", nVentana)
                If FlagTx = True Then
                    If Not Bac_Sql_Execute("ROLLBACK TRANSACTION") Then

                    End If
                End If
                GoTo Fin
            End If
        End If
        If ESTADO = "M" Then
            Call Lineas_Anular("BCC", CDbl(Numero))
        End If
    End If



    Envia = Array()
    AddParam Envia, CDbl(Numero)                                ' 01 (N)
    AddParam Envia, Mercado                                     ' 02 (C)
    AddParam Envia, Operacion                                   ' 03 (C)
    AddParam Envia, CDbl(Rut)                                   ' 04 (N)
    AddParam Envia, CDbl(Codigo)                                ' 05 (N)
    AddParam Envia, Nombre                                      ' 06 (C)
    AddParam Envia, Moneda                                      ' 07 (C)
    AddParam Envia, MonedaCnv                                   ' 08 (C)
    AddParam Envia, CDbl(MontoOrigen)                           ' 09 (N)
    AddParam Envia, CDbl(TipoCambio)                            ' 10 (N)
    AddParam Envia, CDbl(CostoTipoCambio)                       ' 11 (N)
    AddParam Envia, CDbl(Paridad)                               ' 12 (N)
    AddParam Envia, CDbl(CostoParidad)                          ' 13 (N)
    AddParam Envia, CDbl(MontoUSD)                              ' 14 (N)
    AddParam Envia, CDbl(CostoMontoUSD)                         ' 15 (N)
    AddParam Envia, CDbl(MontoPesos)                            ' 16 (N)
    AddParam Envia, CDbl(EntregamosCodigo)                      ' 17 (N)
    AddParam Envia, CDbl(RecibimosCodigo)                       ' 18 (N)
    AddParam Envia, gsBAC_User                                  ' 19 (C)
    AddParam Envia, Terminal                                    ' 20 (C)
    AddParam Envia, Fecha                                       ' 21
    AddParam Envia, CodigoOMA%                                  ' 22 (N)
    AddParam Envia, ESTADO                                      ' 23 (C)
    AddParam Envia, CDbl(0)                                     ' 24 (N) codeject
    AddParam Envia, EntregamosValuta                            ' 25
    AddParam Envia, RecibimosValuta                             ' 26
    AddParam Envia, CDbl(Rentabilidad)                          ' 27 (N)
    AddParam Envia, Linea                                       ' 28 (C)
    AddParam Envia, CDbl(Entidad)                               ' 29 (N)
    AddParam Envia, CDbl(Precio)                                ' 30 (N)
    AddParam Envia, CDbl(CostoPrecio)                           ' 31 (N)
    AddParam Envia, 0                                           ' 32 (N) estado para la captura de fbw
    AddParam Envia, "BCC"                                       ' 33
    AddParam Envia, "N"                                         ' 34
    AddParam Envia, IIf(Observacion = "", "_", Observacion)     ' 35 (V)
    AddParam Envia, IIf(Mercado = "WEEK" Or Mercado = "OVER", OWCorresponsal#, Arbitrajes.SW_corr_Donde)                   ' 36 (V)
    AddParam Envia, Arbitrajes.SW_corr_quien                    ' 37 (V)
    AddParam Envia, Arbitrajes.SW_corr_Desde                    ' 38 (V)
    AddParam Envia, CDbl(Arbitrajes.PL_corr_Donde)              ' 39 (N)
    AddParam Envia, CDbl(Arbitrajes.PL_corr_Quien)              ' 40 (N)
    AddParam Envia, CDbl(Arbitrajes.PL_corr_Desde)              ' 41 (N)
    AddParam Envia, CDbl(ObjCanjes.FpagoMxCl)                   ' 42 (N)
    AddParam Envia, CDbl(ObjCanjes.FpagoMnCl)                   ' 43 (N)
    AddParam Envia, ObjCanjes.FechaMnCl                         ' 44 (N)
    AddParam Envia, ObjCanjes.FechaMxCl                         ' 45 (N)
    AddParam Envia, codigo_area$                                ' 46
    AddParam Envia, Codigo_Comercio$                            ' 47
    AddParam Envia, codigo_concepto$                            ' 48
    AddParam Envia, CDbl(0)                                     ' 49 Casa Matriz
    AddParam Envia, CDbl(MontoFinal)                            ' 50 Monto Final
    AddParam Envia, CDbl(Dias)                                  ' 51 Dias
    AddParam Envia, CDbl(Girador_Rut)                           ' 52 Rut Girador
    AddParam Envia, CDbl(Girador_Codigo)                        ' 53 Codigo Cliente Girador
    AddParam Envia, CDbl(CostoFondo)                            ' 54
    AddParam Envia, CDbl(Arb_Utilidad_Peso)                     ' 55
    AddParam Envia, CDbl(Arb_Tipo_Cambio_MX)                    ' 56
    AddParam Envia, FechaVcto                                   ' 57
    AddParam Envia, Vamos                                       ' 58
    AddParam Envia, CDbl(Arbitrajes.Cod_Corresponsal)           ' 59
    AddParam Envia, "N"                                         ' 60
    AddParam Envia, 0                                           ' 61
    AddParam Envia, ""                                          ' 62
    AddParam Envia, ""                                          ' 63
    AddParam Envia, 0                                           ' 64
    AddParam Envia, 0                                           ' 65
    AddParam Envia, 0                                           ' 66
    AddParam Envia, Correlativo                                 ' 67
    AddParam Envia, "S"                                         ' 68
    AddParam Envia, IIf(Operacion = "C", Valore_Por_Defecto.gs_Corresponsal_Compra, Valore_Por_Defecto.gs_Corresponsal_Venta) ' 69
    If Not Bac_Sql_Execute("SP_GMOVTO", Envia) Then
        GoTo Fin
    End If
    If Not Bac_SQL_Fetch(Datos()) Then
        GoTo Fin
    Else
        If Datos(1) = -1 Then
            GoTo Fin
        End If
        nNumOper = Datos(1)
        cMensaje = Datos(2)
        NumOpe = Datos(1)

        If Mercado = "PTAS" Or Mercado = "EMPR" Or Mercado = "CANJ" Or Mercado = "ARBI" Or Mercado = "WEEK" Or Mercado = "OVER" Then
            If Not Lineas_GrbOperacion("BCC", Mercado, nVentana, nNumOper, Operacion, cCheque, ControlaLinea) Then
                GoTo Fin
            End If

            Mensaje_Lin = ""
            Mensaje_Lim = ""
            Mens_Lin_Graba = ""
            Mens_Lim_Graba = ""

            If gsBac_Lineas = "S" Then
                Mensaje_Lin = Lineas_Error("BCC", nNumOper)
                Mensaje_Lim = Limites_Error("BCC", nNumOper)
                
                Mens_Lin_Graba = Mensaje_Lin
                Mens_Lim_Graba = Mensaje_Lim
                
                Mens_Lin_Graba = Replace(Mens_Lin_Graba, vbCrLf, "")
                Mens_Lin_Graba = Replace(Mens_Lin_Graba, Chr(10), "")
                Mens_Lin_Graba = Replace(Mens_Lin_Graba, "Problemas Lineas: ", "")
                
                Mens_Lim_Graba = Replace(Mens_Lim_Graba, vbCrLf, "")
                Mens_Lim_Graba = Replace(Mens_Lim_Graba, Chr(10), "")
                Mens_Lim_Graba = Replace(Mens_Lim_Graba, "Problemas Limites ", "")
            End If
            If Not Datos(1) <> "Error" Or Datos(1) <> -1 Then
                Grabar_NextDay = True
                
                Envia = Array()
                AddParam Envia, Mens_Lin_Graba
                AddParam Envia, Mens_Lim_Graba
                AddParam Envia, nNumOper
                If Not Bac_Sql_Execute("sp_GMensajes", Envia) Then

                End If
            Else
                Grabar_NextDay = False
            End If
            
            Numero_O = nNumOper
        Else
            Grabar_NextDay = True
        End If
    End If

    Grabar_NextDay = True

Exit Function
Fin:
    Grabar_NextDay = False
End Function



Private Function AyudaFPagoDia(iFPago As Integer, iMoneda As Integer) As Integer
    Dim Datos()

    AyudaFPagoDia = 0

    Envia = Array()
    AddParam Envia, iFPago
    AddParam Envia, iMoneda
    If Bac_Sql_Execute("sp_Leer_FPago ", Envia) Then
        Do While Bac_SQL_Fetch(Datos())
            AyudaFPagoDia = Val(Datos(4))
        Loop
    End If

End Function

Public Function CalculaFeriado(sFecha$, iDias%, iPlaza%, Optional sMoneda) As String
    Dim sValuta$, SQL$, Datos()
    Dim fecha_valuta    As Date
    Dim cant_dias       As Integer
    Dim sDia            As String
       
    If iPlaza = 0 Then
        iPlaza = 6
    End If
   
    If Not IsMissing(sMoneda) Then
        SQL = "BacParamSuda.dbo.sp_Leer_Moneda 0,'', '" & sMoneda & "'"
        If miSQL.SQL_Execute(SQL) = 0 Then
            If miSQL.SQL_Fetch(Datos) = 0 Then
                iPlaza = Datos(12)  '-- Codigo pais
            End If
        End If
    End If
   
    SQL = Right("00000" & CStr(iPlaza), 5)
    sValuta = sFecha

    sDia = BacDiaSem(sgBacFechaProceso)
    If sDia = "Viernes" And iDias > 1 Then
        iDias = 1
    End If

    sValuta = DateAdd("d", iDias, sValuta)
    Do While Not BacEsHabil(sValuta, SQL)
        sValuta = BacProxHabil(sValuta, SQL)
    Loop

    CalculaFeriado = Format(sValuta, gsc_FechaDMA)
End Function


Private Function Valor_Defecto_Nuevo(Cod_Prod As String, Cod_Area As String) As Boolean
    Dim Datos()

    Valore_Por_Defecto.gs_ID_Sistema = ""
    Valore_Por_Defecto.gs_Codigo_Producto = ""
    Valore_Por_Defecto.gs_Codigo_Area = ""
    Valore_Por_Defecto.gs_Compra_Forma_Entregamos = 0
    Valore_Por_Defecto.gs_Compra_Forma_Recibimos = 0
    Valore_Por_Defecto.gs_Compra_Codigo_OMA = 0
    Valore_Por_Defecto.gs_Compra_Codigo_Comercio = ""
    Valore_Por_Defecto.gs_Compra_Codigo_Concepto = ""
    Valore_Por_Defecto.gs_Venta_Forma_Entregamos = 0
    Valore_Por_Defecto.gs_Venta_Forma_Recibimos = 0
    Valore_Por_Defecto.gs_Venta_Codigo_OMA = 0
    Valore_Por_Defecto.gs_Venta_Codigo_Comercio = ""
    Valore_Por_Defecto.gs_Venta_Codigo_Concepto = ""
    Valore_Por_Defecto.gs_Contabiliza = ""
    Valore_Por_Defecto.gs_Monto_Operacion = 0
    Valore_Por_Defecto.gs_Codigo_Moneda = 0
    Valore_Por_Defecto.gs_UserDatatec = ""
    Valore_Por_Defecto.gs_UserBolsa = ""
    Valore_Por_Defecto.gs_CostoCom = 0
    Valore_Por_Defecto.gs_CostoVen = 0
    Valore_Por_Defecto.gs_Corresponsal_Compra = 0
    Valore_Por_Defecto.gs_Corresponsal_Venta = 0
    
    Envia = Array(Cod_Prod, Cod_Area)
    If Not Bac_Sql_Execute("SP_TRAE_VALOR_DEFECTO_SPT", Envia) Then
        Exit Function
    End If

    If Bac_SQL_Fetch(Datos()) Then
        Valore_Por_Defecto.gs_ID_Sistema = Datos(1)
        Valore_Por_Defecto.gs_Codigo_Producto = Datos(2)
        Valore_Por_Defecto.gs_Codigo_Area = Datos(3)
        Valore_Por_Defecto.gs_Compra_Forma_Entregamos = CDbl(Datos(4))
        Valore_Por_Defecto.gs_Compra_Forma_Recibimos = CDbl(Datos(5))
        Valore_Por_Defecto.gs_Compra_Codigo_OMA = CDbl(Datos(6))
        Valore_Por_Defecto.gs_Compra_Codigo_Comercio = Datos(7)
        Valore_Por_Defecto.gs_Compra_Codigo_Concepto = Datos(8)
        Valore_Por_Defecto.gs_Venta_Forma_Entregamos = CDbl(Datos(10))
        Valore_Por_Defecto.gs_Venta_Forma_Recibimos = CDbl(Datos(9))
        Valore_Por_Defecto.gs_Venta_Codigo_OMA = CDbl(Datos(11))
        Valore_Por_Defecto.gs_Venta_Codigo_Comercio = Datos(12)
        Valore_Por_Defecto.gs_Venta_Codigo_Concepto = Datos(13)
        Valore_Por_Defecto.gs_Contabiliza = Datos(14)
        Valore_Por_Defecto.gs_Monto_Operacion = CDbl(Datos(15))
        Valore_Por_Defecto.gs_Codigo_Moneda = CDbl(Datos(16))
        Valore_Por_Defecto.gs_UserDatatec = Datos(17)
        Valore_Por_Defecto.gs_UserBolsa = Datos(18)
        Valore_Por_Defecto.gs_CostoCom = Datos(19)
        Valore_Por_Defecto.gs_CostoVen = Datos(20)
        Valore_Por_Defecto.gs_Corresponsal_Compra = Val(Trim(Datos(21)))
        Valore_Por_Defecto.gs_Corresponsal_Venta = Val(Trim(Datos(22)))
        
        Valor_Defecto_Nuevo = True
    End If

End Function

Private Sub Class_Initialize()
    Let gsUsuario = ""
    Let gsBAC_User = ""
End Sub

Public Function BacDiaSem(sfec$) As String
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

Function BacEsHabil(cFecha As String, plaza As String) As Boolean
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

Private Function BacProxHabil(dFecha As String, plaza As String) As String
   dFecha = Format(DateAdd("d", 1, dFecha), gsc_FechaDMA)
   Do While Not BacEsHabil(dFecha, plaza)
      dFecha = Format(DateAdd("d", 1, dFecha), gsc_FechaDMA)
   Loop
   BacProxHabil = dFecha
End Function

Private Function Lineas_ChequearGrabar(cSist As String, cTipOper As String, nNumPantalla As Double, nNumdocu As Double, ncorrela As Double, nRut As Double, nCodigo As Double, nMonto As Double, nTipCambio As Double, dFecven As Date, nRut_emisor As Double, nMonedaEmision As Integer, dFecvenInst As Date, nIncodigo As Integer, cSeriado As String, nMonedaPago As Integer, cGarantia As String, nCodigo_pais As Integer, cPagoCheque As String, nRutCheque As Double, dFecvenCheque As Date, nFactorVenta As Double, nFormaPago As Double)
    Dim Datos()

    Envia = Array()
    AddParam Envia, gsBAC_Fecp                          'Fecha de Proceso
    AddParam Envia, cSist                               'Sistema
    AddParam Envia, cTipOper                            'Producto
    AddParam Envia, nNumPantalla                        'Numero Operacion
    AddParam Envia, nNumdocu                            'Numero Documento
    AddParam Envia, ncorrela                            'Numero Correlativo
    AddParam Envia, nRut                                'Rut a Chequear
    AddParam Envia, nCodigo                             'Codigo a Chequear
    AddParam Envia, nMonto                              'Monto
    AddParam Envia, nTipCambio                          'Tipo Cambio
    AddParam Envia, Format(dFecven, feFECHA)            'Fecha Vencimiento
    AddParam Envia, gsUsuario                           'Usuario
    AddParam Envia, nRut_emisor                         'Emisor Instrumento (BTR)
    AddParam Envia, nMonedaEmision                      'Moneda Emision (BTR)
    AddParam Envia, dFecvenInst                         'Fecha Vencimiento Istrumento
    AddParam Envia, nIncodigo                           'Codigo Familia (BTR)
    AddParam Envia, cSeriado                            'Seriado S/N (BTR)
    AddParam Envia, nMonedaPago                         'Moneda Forward
    AddParam Envia, cGarantia                           '(C)Con Garantia   (S)Sin Garantia (BTR)
    AddParam Envia, nCodigo_pais                        'Codigo Pais (FWD-SPO)
    AddParam Envia, cPagoCheque                         'Pago con Cheque S/N
    AddParam Envia, nRutCheque                          'Rut a chequear en pago Chueque
    AddParam Envia, dFecvenCheque                       'Fecha Vcto linea Cheque
    AddParam Envia, nFactorVenta                        'Factor en Venta Definitiva
    AddParam Envia, nFormaPago                          'Forma Pago de la Operación
    AddParam Envia, 0                                   'Tasa Instrumentos
    AddParam Envia, 0                                   'Tasa Pactos
    AddParam Envia, ""                                  'Instrumento
    Lineas_ChequearGrabar = True
    If Not Bac_Sql_Execute(gsSQL_DatabaseLineas + "..SP_LINEAS_CHEQUEARGRABAR", Envia) Then
        Lineas_ChequearGrabar = False
    End If
End Function

Private Function Lineas_Chequear(cSist As String, cTipOper As String, nNumPantalla As Double, cTipoOpBCC As String, cValCheque As String, cMercado As String)
    Dim Datos()

    Lineas_Chequear = ""
    
    Envia = Array()
    AddParam Envia, cSist                               'Sistema
    AddParam Envia, cTipOper                            'Producto
    AddParam Envia, nNumPantalla                        'Numero Pantalla
    AddParam Envia, cTipoOpBCC                          'Tipo Operacion BCC
    AddParam Envia, cValCheque                          'Valida Cheque - BCC
    AddParam Envia, cMercado                            'Mercado Local/externo - FWD
    If Bac_Sql_Execute(gsSQL_DatabaseLineas + "..SP_LINEAS_CHEQUEAR", Envia) Then
        Do While Bac_SQL_Fetch(Datos())
            Lineas_Chequear = Lineas_Chequear & Datos(1) & vbCrLf
        Loop
    End If
End Function

Private Function Lineas_ConsultaOperacion(cSist As String, cTipOper As String, nNumPantalla As Double, cTipoOpBCC As String, cValCheque As String, cMercado As String, nNumeroOpe As Double)
    Dim Mensaje_Lin1    As String
    Dim Mensaje_Lin     As String
    Dim Mensaje_Lim1    As String
    Dim Mensaje_Lim     As String
    Dim Datos()

    Lineas_ConsultaOperacion = ""
    
    Mensaje_Lin1 = ""
    Mensaje_Lin = ""
    Mensaje_Lim1 = ""
    Mensaje_Lim = ""

    Envia = Array()
    AddParam Envia, cSist                               'Sistema
    AddParam Envia, cTipOper                            'Producto
    AddParam Envia, nNumPantalla                        'Numero Pantalla
    AddParam Envia, cTipoOpBCC                          'Tipo Operacion BCC
    AddParam Envia, cValCheque                          'Valida Cheque - BCC
    AddParam Envia, cMercado                            'Mercado Local/externo - FWD
   'AddParam Envia, nNumeroOpe                          'Numero de Operacion (Solo Modificacion)
    If Bac_Sql_Execute(gsSQL_DatabaseLineas + "..SP_LINEAS_CONSULTAROPERACION", Envia) Then
        Do While Bac_SQL_Fetch(Datos())
            If Datos(1) = "LIN" Then
                Mensaje_Lin = Mensaje_Lin & Datos(3)
                If CDbl(Datos(4)) > 0 Then
                    Mensaje_Lin = Mensaje_Lin & " En " & Trim(CDbl(Datos(4)))
                End If
                Mensaje_Lin = Mensaje_Lin & Chr(10) & Chr(13)
                Mensaje_Lin1 = vbCrLf & vbCrLf & "Problemas Lineas: " & vbCrLf & vbCrLf
            End If
            If Datos(1) = "LIM" Then
                Mensaje_Lim = Mensaje_Lim & Datos(3)
                If CDbl(Datos(4)) > 0 Then
                    Mensaje_Lim = Mensaje_Lim & " En " & Trim(CDbl(Datos(4)))
                End If
                Mensaje_Lim = Mensaje_Lim & Chr(10) & Chr(13)
                Mensaje_Lim1 = vbCrLf & vbCrLf & "Problemas Limites: " & vbCrLf & vbCrLf
            End If
        Loop

        Lineas_ConsultaOperacion = Mensaje_Lin1 & Mensaje_Lin & Mensaje_Lim1 & Mensaje_Lim
    End If

End Function

Private Function Lineas_BorraConsultaOperacion(cSist As String, nNumPantalla As Double)
    Envia = Array()
    AddParam Envia, cSist                               'Sistema
    AddParam Envia, nNumPantalla                        'Numero Pantalla
    If Not Bac_Sql_Execute("SP_LINEAS_BORRARCONSULTAROPERACION", Envia) Then
        MsgBox "'Sp_Lineas_BorrarConsultarOperacion' , Error al Eliminar Registro Temporal", vbCritical, "LINEAS"
    End If
End Function
Private Function Lineas_Anular(cSist As String, nNumOper As Double)
    Dim Datos()

    Lineas_Anular = True

    Envia = Array()
    AddParam Envia, gsBAC_Fecp
    AddParam Envia, cSist
    AddParam Envia, nNumOper
    If Not Bac_Sql_Execute(gsSQL_DatabaseLineas + "..SP_LINEAS_ANULA", Envia) Then
        Lineas_Anular = False
    End If

End Function


Function Lineas_GrbOperacion(cSist As String, cTipOper As String, nNumPantalla As Double, nNumOper As Double, cTipoOpBCC As String, cValCheque As String, cMercado As String, Optional sCanal As String)
    Dim Datos()
    
    If IsMissing(sCanal) Then
        sCanal = ""
    End If
    
    Lineas_GrbOperacion = True
    
    If cTipoOpBCC = "C" And sCanal <> "CORREDORA" Then
        Envia = Array()
        AddParam Envia, cSist                               'Sistema
        AddParam Envia, cTipOper                            'Producto
        AddParam Envia, nNumPantalla                        'Numero Pantalla
        AddParam Envia, nNumOper                            'Numero Operacion
        AddParam Envia, cTipoOpBCC                          'Tipo Operacion BCC
        AddParam Envia, cValCheque                          'Valida Cheque - BCC
        AddParam Envia, cMercado                            'Mercado Local/externo - FWD
        If Not Bac_Sql_Execute(gsSQL_DatabaseLineas + "..SP_LINEAS_GRBOPERACION", Envia) Then
            Lineas_GrbOperacion = False
        End If
    End If

    If cTipoOpBCC = "V" And sCanal <> "CORREDORA" Then

        Envia = Array()
        AddParam Envia, cSist                               'Sistema
        AddParam Envia, cTipOper                            'Producto
        AddParam Envia, nNumPantalla                        'Numero Pantalla
        AddParam Envia, nNumOper                            'Numero Operacion
        AddParam Envia, cTipoOpBCC                          'Tipo Operacion BCC
        AddParam Envia, cValCheque                          'Valida Cheque - BCC
        AddParam Envia, cMercado                            'Mercado Local/externo - FWD
        AddParam Envia, ""                                  'Canal
        If Not Bac_Sql_Execute(gsSQL_DatabaseLineas + "..SP_GRABA_LIMITES_VENTAS", Envia) Then
            Lineas_GrbOperacion = False
        End If
    End If
        
    If sCanal = "CORREDORA" Then
        Envia = Array()
        AddParam Envia, cSist                               'Sistema
        AddParam Envia, cTipOper                            'Producto
        AddParam Envia, nNumPantalla                        'Numero Pantalla
        AddParam Envia, nNumOper                            'Numero Operacion
        AddParam Envia, cTipoOpBCC                          'Tipo Operacion BCC
        AddParam Envia, cValCheque                          'Valida Cheque - BCC
        AddParam Envia, cMercado                            'Mercado Local/externo - FWD
        AddParam Envia, sCanal                              'Canal
        If Not Bac_Sql_Execute(gsSQL_DatabaseLineas + "..SP_GRABA_LIMITES_VENTAS", Envia) Then
            Lineas_GrbOperacion = False
        End If
    End If

End Function

Function Lineas_Error(cSist As String, nNumOper As Double)
    Dim Mensaje1    As String
    Dim Mensaje     As String
    Dim Datos()

    Mensaje = ""

    Envia = Array()
    AddParam Envia, cSist
    AddParam Envia, nNumOper
    If Bac_Sql_Execute(gsSQL_DatabaseLineas + "..Sp_Lineas_GrabarError", Envia) Then
        Do While Bac_SQL_Fetch(Datos())
            Mensaje = Mensaje & Datos(1)
            If CDbl(Datos(2)) > 0 Then
                Mensaje = Mensaje & " " & Trim(CDbl(Datos(2)))
            End If
            Mensaje = Mensaje & Chr(10) & Chr(13)
            Mensaje1 = vbCrLf & vbCrLf & vbCrLf & "Problemas Lineas: " & vbCrLf & vbCrLf
        Loop
    End If

    Lineas_Error = Mensaje1 & Mensaje
End Function

Function Limites_Error(cSist As String, nNumOper As Double)
    Dim Mensaje1    As String
    Dim Mensaje     As String
    Dim Datos()
    
    Mensaje = ""
            
    Envia = Array()
    AddParam Envia, cSist
    AddParam Envia, nNumOper
    If Bac_Sql_Execute(gsSQL_DatabaseLineas + "..Sp_Limites_ChequearError", Envia) Then
    
    End If
    
    Limites_Error = Mensaje1 & Mensaje

End Function

