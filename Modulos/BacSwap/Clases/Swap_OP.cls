VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "Swap_OP"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Public A01_NumeroOperacion       As Double
Public A02_NumeroFlujo           As Integer
Public A03_TipoFlujo             As Integer
Public A04_TipoSwap              As Integer
Public A05_CarteraInversiones    As Integer
Public A06_TipoOperacion         As String
Public A07_RutCliente            As Long
Public A08_CodCliente            As Integer
Public A09_Moneda                As Integer
Public A10_Nocionales            As Double
Public A11_Amortizacion          As Double
Public A12_Saldo                 As Double
Public A13_Interes               As Double
Public A14_Spread                As Double
Public A15_Indicador             As Integer
Public A16_UltimoIndice          As Double
Public A17_ConteoDias            As Integer
Public A18_FrecuenciaPago        As Integer
Public A19_FrecuenciaCapital     As Integer
Public A20_MonedaPago            As Integer
Public A21_MedioPago             As Integer
Public A22_MontoPago             As Double
Public A23_MontoPagoCLP          As Double
Public A24_MontoPagoUSD          As Double
Public A25_ModalidadPago         As String
Public A26_FechaCierre           As Date
Public A27_FechaEfectiva         As Date
Public A28_FechaPrimerPago       As Date
Public A29_FechaPenultimoPago    As Date
Public A30_FechaMadurez          As Date
Public A31_FechaInicioFlujo      As Date
Public A32_FechaTerminoFlujo     As Date
Public A33_Usuario               As String
Public A34_Observaciones         As String
Public A35_Lineas                As String
Public A36_Limites               As String
Public A37_AreaResponsable       As Variant
Public A38_CarteraNormativa      As Variant
Public A39_SubCarteraNormativa   As Variant
Public A40_LibroNegociacion      As Variant
Public A41_DiasReset             As Integer
Public A42_FechaFijaTasa         As Date
Public A43_FeriadoFlujoChile     As Integer
Public A44_FeriadoFlujoEEUU      As Integer
Public A45_FeriadoFlujoEnglan    As Integer
Public A46_FeriadoLiquiChile     As Integer
Public A47_FeriadoLiquiEEUU      As Integer
Public A48_FeriadoLiquiEnglan    As Integer
Public A49_Convencion            As String
Public A50_Note                  As String
Public A51_IntercambioPrincipal  As Boolean
Public A52_Tikker                As String
Public A53_FechaLiquidacion      As Date
Public A53_FechaReset            As Date
'//CER 05/05/2008   Variables - Req. Pantalla Ingreso Op. Swap
Public A55_FxRate                As Double
Public A56_PrcAmortiza           As Double
Public A57_FechaValuta           As Date
Public A58_FlujoAdicional        As Double

Public A59_Tasa_Transfer         As Double
Public A60_Spread_Transfer       As Double
Public A61_Res_Mesa_Dist_CLP     As Double
Public A62_Res_Mesa_Dist_USD     As Double

Public A65_Operador              As String  'JBH, 22-12-2009

Public A99_Estado                As String

        '-- PRD 12712
Public A104_bEarlyTermination  As Integer
Public A105_FechaInicio  As Date
Public A106_Periodicidad  As Integer
          '-- PRD 12712



'***************************PRD21657
'********Izquierda
Public A100_ReferenciaUSDCLP        As Integer
Public A101_ReferenciaMEXUSD        As Integer
Public A102_FechaUSDCLP             As Date
Public A103_FechaMEXUSD             As Date
'********Derecha
Public A104_ReferenciaUSDCLP        As Integer
Public A105_ReferenciaMEXUSD        As Integer
Public A106_FechaUSDCLP             As Date
Public A107_FechaMEXUSD             As Date

Public A100_dias        As Integer
Public A101_dias        As Integer
Public A104_dias        As Integer
Public A105_dias        As Integer


'***************************PRD21657

'Public Plaza                        As String
'***************************PRD21657



Public Function NuevoNumeroSwapSim() As Double
   NuevoNumeroSwapSim = 0
   
   Envia = Array()
   AddParam Envia, Sistema
   AddParam Envia, Entidad
   If Not Bac_Sql_Execute("SP_ULTIMAOPERACION_SIM", Envia) Then
      MsgBox "Error" & vbCrLf & "No se ha podido establecer el N° de Operación.", vbExclamation, TITSISTEMA
      Exit Function
   End If
   If Bac_SQL_Fetch(Datos()) Then
      NuevoNumeroSwapSim = Val(Datos(1))
   Else
      NuevoNumeroSwapSim = 1
   End If

End Function
Public Function NuevoNumeroSwap() As Double
   NuevoNumeroSwap = 0
   
   Envia = Array()
   AddParam Envia, Sistema
   AddParam Envia, Entidad
   If Not Bac_Sql_Execute("SP_ULTIMAOPERACION", Envia) Then
      MsgBox "Error" & vbCrLf & "No se ha podido establecer el N° de Operación.", vbExclamation, TITSISTEMA
      Exit Function
   End If
   If Bac_SQL_Fetch(Datos()) Then
      NuevoNumeroSwap = Val(Datos(1))
   Else
      NuevoNumeroSwap = 1
   End If
End Function

Private Sub Class_Initialize()
   A01_NumeroOperacion = 0#
   A02_NumeroFlujo = 0
   A03_TipoFlujo = 0
   A04_TipoSwap = 0
   A05_CarteraInversiones = 0
   A06_TipoOperacion = ""
   A07_RutCliente = 0
   A08_CodCliente = 0
   A09_Moneda = 0
   A10_Nocionales = 0#
   A11_Amortizacion = 0#
   A12_Saldo = 0#
   A13_Interes = 0#
   A14_Spread = 0#
   A15_Indicador = 0
   A16_UltimoIndice = 0#
   A17_ConteoDias = 0
   A18_FrecuenciaPago = 0
   A19_FrecuenciaCapital = 0
   A20_MonedaPago = 0
   A21_MedioPago = 0
   A22_MontoPago = 0#
   A23_MontoPagoCLP = 0#
   A24_MontoPagoUSD = 0#
   A25_ModalidadPago = ""
   A26_FechaCierre = "1900/01/01"
   A27_FechaEfectiva = "1900/01/01"
   A28_FechaPrimerPago = "1900/01/01"
   A29_FechaPenultimoPago = "1900/01/01"
   A30_FechaMadurez = "1900/01/01"
   A31_FechaInicioFlujo = "1900/01/01"
   A32_FechaTerminoFlujo = "1900/01/01"
   A33_Usuario = ""
   A34_Observaciones = ""
   A35_Lineas = ""
   A36_Limites = ""
   A37_AreaResponsable = Empty
   A38_CarteraNormativa = Empty
   A39_SubCarteraNormativa = Empty
   A40_LibroNegociacion = Empty
   A41_DiasReset = 0
   A42_FechaFijaTasa = "1900/01/01"
   
   A43_FeriadoFlujoChile = 0
   A44_FeriadoFlujoEEUU = 0
   A45_FeriadoFlujoEnglan = 0
   A46_FeriadoLiquiChile = 0
   A47_FeriadoLiquiEEUU = 0
   A48_FeriadoLiquiEnglan = 0
   A49_Convencion = ""
   
   A50_Note = ""
   A51_IntercambioPrincipal = False
   A52_Tikker = ""
   A53_FechaLiquidacion = "1900/01/01"
   A53_FechaReset = "1900/01/01"
   
   A65_Operador = ""    'JBH, 22-12-2009
      
   A99_Estado = "P"
'-- PRD 12712
A104_bEarlyTermination = 0
A105_FechaInicio = "1900/01/01"
A106_Periodicidad = 0
   '-- PRD 12712
   
   
   
   '***************************PRD21657
A100_ReferenciaUSDCLP = 0
A101_ReferenciaMEXUSD = 0
A102_FechaUSDCLP = "1999/01/01"
A103_FechaMEXUSD = "1999/01/01"
A104_ReferenciaUSDCLP = 0
A105_ReferenciaMEXUSD = 0
Plaza = ""
A100_dias = 0
A101_dias = 0
A104_dias = 0
A105_dias = 0
'***************************PRD21657
   
   
   
   grabaThr = False
End Sub
Public Function GrabaciónSim() As Boolean
   Dim Mensaje     As String
   Dim cCheque     As String
   Dim nRutCheque  As Double
   Dim Mensaje_Con As String
   Dim SwResp      As Integer
   Dim CodMonOp    As Double
   Dim MercadoLc   As String
   Dim Monto_Usd   As Double
   Dim Mensaje_Lin As String
   Dim Mensaje_Lim As String
   Dim dFechaVcto  As Date
   Dim iDatos()
   GrabaciónSim = False
   
   Envia = Array()
   AddParam Envia, IIf(A99_Estado = "P", CDbl(1), CDbl(2))
   AddParam Envia, Me.A01_NumeroOperacion
   AddParam Envia, Me.A02_NumeroFlujo
   AddParam Envia, Me.A03_TipoFlujo
   AddParam Envia, Me.A04_TipoSwap
   AddParam Envia, Me.A05_CarteraInversiones
   AddParam Envia, Me.A06_TipoOperacion
   AddParam Envia, Me.A07_RutCliente
   AddParam Envia, Me.A08_CodCliente
   AddParam Envia, Me.A09_Moneda
   AddParam Envia, Me.A10_Nocionales
   AddParam Envia, Me.A11_Amortizacion
   AddParam Envia, Me.A12_Saldo
   AddParam Envia, Me.A13_Interes
   AddParam Envia, Me.A14_Spread
   AddParam Envia, Me.A15_Indicador
   AddParam Envia, Me.A16_UltimoIndice
   AddParam Envia, Me.A17_ConteoDias
   AddParam Envia, Me.A18_FrecuenciaPago
   AddParam Envia, Me.A19_FrecuenciaCapital
   AddParam Envia, Me.A20_MonedaPago
   AddParam Envia, Me.A21_MedioPago
   AddParam Envia, Me.A22_MontoPago
   AddParam Envia, Me.A23_MontoPagoCLP
   AddParam Envia, Me.A24_MontoPagoUSD
   AddParam Envia, Me.A25_ModalidadPago
   AddParam Envia, Me.A26_FechaCierre
   AddParam Envia, Me.A27_FechaEfectiva
   AddParam Envia, Me.A28_FechaPrimerPago
   AddParam Envia, Me.A29_FechaPenultimoPago
   AddParam Envia, Me.A30_FechaMadurez
   AddParam Envia, Me.A31_FechaInicioFlujo
   AddParam Envia, Me.A32_FechaTerminoFlujo
   
   'JBH, 22-12-2009
   grabaOperador = False
   If Trim(Me.A65_Operador) <> "" Then
        grabaOperador = True
   End If
   If grabaOperador = True Then
        AddParam Envia, Me.A65_Operador
   Else
   AddParam Envia, Me.A33_Usuario
   End If
   'fin JBH

   'AddParam Envia, Me.A33_Usuario
   
   AddParam Envia, Me.A34_Observaciones
   AddParam Envia, Me.A35_Lineas
   AddParam Envia, Me.A36_Limites
   AddParam Envia, Me.A37_AreaResponsable
   AddParam Envia, Me.A38_CarteraNormativa
   AddParam Envia, Me.A39_SubCarteraNormativa
   AddParam Envia, Me.A40_LibroNegociacion
   AddParam Envia, Me.A41_DiasReset
   AddParam Envia, Me.A42_FechaFijaTasa
   AddParam Envia, Me.A43_FeriadoFlujoChile
   AddParam Envia, Me.A44_FeriadoFlujoEEUU
   AddParam Envia, Me.A45_FeriadoFlujoEnglan
   AddParam Envia, Me.A46_FeriadoLiquiChile
   AddParam Envia, Me.A47_FeriadoLiquiEEUU
   AddParam Envia, Me.A48_FeriadoLiquiEnglan
   AddParam Envia, Me.A49_Convencion
   AddParam Envia, Me.A50_Note
   '//CER 05/05/2008   Variables - Req. Pantalla Ingreso Op. Swap
   AddParam Envia, IIf(Me.A51_IntercambioPrincipal = True, 1, 0)
   AddParam Envia, Me.A52_Tikker
   AddParam Envia, Me.A53_FechaLiquidacion
   AddParam Envia, Me.A53_FechaReset
   '//CER 05/05/2008   Variables - Req. Pantalla Ingreso Op. Swap
   AddParam Envia, Me.A55_FxRate
   AddParam Envia, Me.A56_PrcAmortiza
   AddParam Envia, Me.A57_FechaValuta
   
   'MAP Hospitales
   'AddParam Envia, IIf(Me.A04_TipoSwap = 2, Me.A58_FlujoAdicional, 0)
   AddParam Envia, Me.A58_FlujoAdicional
      
   AddParam Envia, Me.A33_Usuario   'JBH, 22-12-2009

   AddParam Envia, Me.A99_Estado

   AddParam Envia, Me.A59_Tasa_Transfer
   AddParam Envia, Me.A60_Spread_Transfer
   AddParam Envia, Me.A61_Res_Mesa_Dist_CLP
   AddParam Envia, Me.A62_Res_Mesa_Dist_USD
   
   If Not Bac_Sql_Execute("SP_GRABACION_OPERACIONES_SIM", Envia) Then
      Exit Function
   End If
   If Bac_SQL_Fetch(iDatos()) Then
      If iDatos(1) < 0 Then
         MsgBox iDatos(2), vbExclamation, TITSISTEMA
         Exit Function
      End If
   End If
   GrabaciónSim = True
End Function
Public Function Grabación() As Boolean
   Dim Mensaje     As String
   Dim cCheque     As String
   Dim nRutCheque  As Double
   Dim Mensaje_Con As String
   Dim SwResp      As Integer
   Dim CodMonOp    As Double
   Dim MercadoLc   As String
   Dim Monto_Usd   As Double
   Dim Mensaje_Lin As String
   Dim Mensaje_Lim As String
   Dim dFechaVcto  As Date
   Dim iDatos()
   Grabación = False
   
   ' --> PRD 12712
    Dim ET_Aceptar As Boolean
    Dim ET_Marca As Integer
    Dim ET_Periodicidad As Integer
    Dim ET_FechaInicio As Date
  
    If giAceptar_EarlyTermination = True Then
        Let ET_Aceptar = giAceptar_EarlyTermination
'        Let ET_Marca = giMarca_EarlyTermination
'        Let ET_Periodicidad = giPeriodicidad_EarlyTermination
'        Let ET_FechaInicio = giFechaInicio_EarlyTermination
   
        A104_bEarlyTermination = giMarca_EarlyTermination
        A105_FechaInicio = giFechaInicio_EarlyTermination
        A106_Periodicidad = giPeriodicidad_EarlyTermination
    Else
        A104_bEarlyTermination = 0
        A105_FechaInicio = "1900/01/01"
        A106_Periodicidad = 0
    End If
    
    ' --> Fin PRD 12712
   
  
'//CER 06/08/2008   Se comenta ya que cuando los flujos son
'  bac-starting(fecha inicio de flujo anterior a fecha proceso)
'  no se graba el flujo 1 que es para la fecha efectiva,
'  por lo que operación no imputa LCR
''''   If A03_TipoFlujo = 1 And A02_NumeroFlujo = 1 Then
''''      If gsBac_Lineas = "S" Then
''''         Monto_Usd = CDbl(A10_Nocionales)
''''         CodMonOp = A09_Moneda
''''         dFechaVcto = A30_FechaMadurez
''''         cCheque = "N"
''''         nRutCheque = 0
''''         Mensaje = ""
''''
''''         If Not Lineas_ChequearGrabar("PCS", CDbl(A04_TipoSwap), A01_NumeroOperacion, 0, 0, Me.A07_RutCliente, Me.A08_CodCliente, Monto_Usd, 0#, dFechaVcto, 0, 0, CDate(gsBAC_Fecp), 0, "N", Val(CodMonOp), "C", 0, cCheque, nRutCheque, CDate(gsBAC_Fecp), 0, Val(A21_MedioPago)) Then
''''            Exit Function
''''         End If
''''
''''         MercadoLc = "N"
''''         If nPaisOrigen = 6 Then
''''            MercadoLc = "S"
''''         End If
''''
''''         Mensaje_Con = Lineas_ConsultaOperacion("PCS", CDbl(A04_TipoSwap), A01_NumeroOperacion, " ", cCheque, MercadoLc)
''''         If Trim(Mensaje_Con) <> "" Then
''''            If MsgBox("ATENCION" & vbCrLf & "LA OPERACION GENERARA LOS SIGUIENTES ERRORES" & Mensaje_Con & vbCrLf & vbCrLf & "¿Desea Grabar la Operación ?", vbYesNo + vbExclamation, TITSISTEMA) = vbNo Then
''''               Call Lineas_BorraConsultaOperacion("PCS", A01_NumeroOperacion)
''''               Exit Function
''''            End If
''''         End If
''''
''''         'Si Acepta y Tiene Errores Sigue Normal
''''         Mensaje = Mensaje & Lineas_Chequear("PCS", CDbl(A04_TipoSwap), A01_NumeroOperacion, " ", cCheque, MercadoLc)
''''         If Mensaje <> "" Then
''''            MsgBox "Error al Chequear Lineas : " + Chr(10) + Chr(13) + Chr(10) + Chr(13) + Mensaje, vbCritical, Msj
''''         End If
''''      End If '--> gsBac_Lineas = "S"
''''   End If
   
   Envia = Array()
   AddParam Envia, IIf(A99_Estado = "P", CDbl(1), CDbl(2))
   AddParam Envia, Me.A01_NumeroOperacion
   AddParam Envia, Me.A02_NumeroFlujo
   AddParam Envia, Me.A03_TipoFlujo
   AddParam Envia, Me.A04_TipoSwap
   AddParam Envia, Me.A05_CarteraInversiones
   AddParam Envia, Me.A06_TipoOperacion
   AddParam Envia, Me.A07_RutCliente
   AddParam Envia, Me.A08_CodCliente
   AddParam Envia, Me.A09_Moneda
   AddParam Envia, Me.A10_Nocionales
   AddParam Envia, Me.A11_Amortizacion
   AddParam Envia, Me.A12_Saldo
   AddParam Envia, Me.A13_Interes
   AddParam Envia, Me.A14_Spread
   AddParam Envia, Me.A15_Indicador
   AddParam Envia, Me.A16_UltimoIndice
   AddParam Envia, Me.A17_ConteoDias
   AddParam Envia, Me.A18_FrecuenciaPago
   AddParam Envia, Me.A19_FrecuenciaCapital
   AddParam Envia, Me.A20_MonedaPago
   AddParam Envia, Me.A21_MedioPago
   AddParam Envia, Me.A22_MontoPago
   AddParam Envia, Me.A23_MontoPagoCLP
   AddParam Envia, Me.A24_MontoPagoUSD
   AddParam Envia, Me.A25_ModalidadPago
   AddParam Envia, Me.A26_FechaCierre
   AddParam Envia, Me.A27_FechaEfectiva
   AddParam Envia, Me.A28_FechaPrimerPago
   AddParam Envia, Me.A29_FechaPenultimoPago
   AddParam Envia, Me.A30_FechaMadurez
   AddParam Envia, Me.A31_FechaInicioFlujo
   AddParam Envia, Me.A32_FechaTerminoFlujo
   
   'JBH, 22-12-2009
   grabaOperador = False
   If Trim(Me.A65_Operador) <> "" Then
        grabaOperador = True
   End If
   If grabaOperador = True Then
        AddParam Envia, Me.A65_Operador
   Else
   AddParam Envia, Me.A33_Usuario
   End If
   'fin JBH
   
   'AddParam Envia, Me.A33_Usuario
   
   AddParam Envia, Me.A34_Observaciones
   AddParam Envia, Me.A35_Lineas
   AddParam Envia, Me.A36_Limites
   AddParam Envia, Me.A37_AreaResponsable
   AddParam Envia, Me.A38_CarteraNormativa
   AddParam Envia, Me.A39_SubCarteraNormativa
   AddParam Envia, Me.A40_LibroNegociacion
   AddParam Envia, Me.A41_DiasReset
   AddParam Envia, Me.A42_FechaFijaTasa
   AddParam Envia, Me.A43_FeriadoFlujoChile
   AddParam Envia, Me.A44_FeriadoFlujoEEUU
   AddParam Envia, Me.A45_FeriadoFlujoEnglan
   AddParam Envia, Me.A46_FeriadoLiquiChile
   AddParam Envia, Me.A47_FeriadoLiquiEEUU
   AddParam Envia, Me.A48_FeriadoLiquiEnglan
   AddParam Envia, Me.A49_Convencion
   AddParam Envia, Me.A50_Note
   '//CER 05/05/2008   Variables - Req. Pantalla Ingreso Op. Swap
   AddParam Envia, IIf(Me.A51_IntercambioPrincipal = True, 1, 0)
   AddParam Envia, Me.A52_Tikker
   AddParam Envia, Me.A53_FechaLiquidacion
   AddParam Envia, Me.A53_FechaReset
   '//CER 05/05/2008   Variables - Req. Pantalla Ingreso Op. Swap
   AddParam Envia, Me.A55_FxRate
   AddParam Envia, Me.A56_PrcAmortiza
   AddParam Envia, Me.A57_FechaValuta
   
   ' MAP Hospitales
   'AddParam Envia, IIf(Me.A04_TipoSwap = 2, Me.A58_FlujoAdicional, 0)
   AddParam Envia, Me.A58_FlujoAdicional
      
   AddParam Envia, Me.A33_Usuario   'JBH, 22-12-2009

   AddParam Envia, Me.A99_Estado
   
   AddParam Envia, Me.A59_Tasa_Transfer
   AddParam Envia, Me.A60_Spread_Transfer
   AddParam Envia, Me.A61_Res_Mesa_Dist_CLP
   AddParam Envia, Me.A62_Res_Mesa_Dist_USD
   
   ' --> PRD 12712
   'If ET_Aceptar = True Then
   
AddParam Envia, Me.A104_bEarlyTermination
AddParam Envia, Me.A105_FechaInicio
AddParam Envia, Me.A106_Periodicidad
      
   'End If
   ' --> Fin PRD 12712
      
      '***************************PRD21657


      
If Me.A03_TipoFlujo = 1 Then
    AddParam Envia, Me.A100_ReferenciaUSDCLP
    AddParam Envia, Me.A101_ReferenciaMEXUSD
    AddParam Envia, Me.A100_dias
    AddParam Envia, Me.A101_dias
End If
If Me.A03_TipoFlujo = 2 Then
    AddParam Envia, Me.A104_ReferenciaUSDCLP
    AddParam Envia, Me.A105_ReferenciaMEXUSD
    AddParam Envia, Me.A104_dias
    AddParam Envia, Me.A105_dias
End If


    AddParam Envia, Me.A102_FechaUSDCLP
    AddParam Envia, Me.A103_FechaMEXUSD
'End If
Call Habil
AddParam Envia, Plaza

    AddParam Envia, giInterNocIni
    AddParam Envia, giInterNocFin




'***************************PRD21657
   
   If Not Bac_Sql_Execute("SP_GRABACION_OPERACIONES", Envia) Then
      Exit Function
   End If
   If Bac_SQL_Fetch(iDatos()) Then
      If iDatos(1) < 0 Then
         MsgBox iDatos(2), vbExclamation, TITSISTEMA
         Exit Function
      End If
   End If
   Grabación = True
End Function

Public Function PreGrabadoFRA(xxForm As Form) As Boolean
   Dim iNumeroFlujos    As Integer
   Dim iTipoFlujo       As Integer
   Dim MiGrilla         As MSFlexGrid

    'PROD-10967
    Dim Error_LCR        As String
    Dim MsgError_LCR As String
    Dim Metodologia_LCR As Integer
    Dim MercadoLc        As String
    'PROD-10967

   PreGrabadoFRA = False
    
    '--+++CONTROL IDD, jcamposd solo existe metodologia 1 bajo concepto IDD
    Metodologia_LCR = 1
    '-----CONTROL IDD, jcamposd solo existe metodologia 1 bajo concepto IDD
    
    'PROD-10967
      If Metodologia_LCR <> 1 And _
         Metodologia_LCR <> 4 Then
      
        
        If Not Bac_Sql_Execute("BEGIN TRANSACTION") Then
           MsgBox "No se Pudo Asegurar Transaccion para imputar cliente" & vbCrLf & "Comunique este problema al Supervisor", vbCritical, "Grabar Operaciones"
           Exit Function
        End If

        'Busca e inserta si no está
        If Inserta_Cliente_Imputacion(FRM_SWAP_OP_FRA.RutCliente, FRM_SWAP_OP_FRA.CodCliente) = False Then
           MsgBox "Cliente está siendo imputado en Derivados. " & vbCrLf & "Favor reintentar en segundos más.", vbCritical, "Grabar Operaciones"
            If Not Bac_Sql_Execute("COMMIT TRANSACTION") Then
                Exit Function
            End If 'MAP
            Exit Function
        End If
        
        If Not Bac_Sql_Execute("COMMIT TRANSACTION") Then
           Exit Function
        End If
     End If
    'PROD-10967
    
    
    
   If Not Bac_Sql_Execute("BEGIN TRANSACTION") Then
      MsgBox "Error en la grabación" & vbCrLf & "Imposible generar transacciones.", vbExclamation, TITSISTEMA
      Exit Function
   End If
   
   If xxForm.Tag <> "" Then
      Me.A01_NumeroOperacion = Val(xxForm.Tag)
      Call Lineas_Anular("PCS", CDbl(Me.A01_NumeroOperacion))
      
        Dim oParametrosLineaAnula As New clsControlLineaIDD
            '+++CONTROL IDD, jcamposd anula toma de linea
            With oParametrosLineaAnula
                .Modulo = "PCS"
                .Producto = 3 '--> jcamposd, según flujo mas adelante le asigna 3 por defecto
                .Operacion = CDbl(Me.A01_NumeroOperacion)
                .Documento = CDbl(Me.A01_NumeroOperacion)
                .Correlativo = 0
                .Accion = "R"
            
                .RecuperaDatosLineaIDD
                If .numeroiddAnula <> 0 Then
                    .EjecutaProcesoWsLineaIDD
                End If
                
            End With
            
            Set oParametrosLineaAnula = Nothing
            On Error GoTo seguirAnulacion 'debe seguir con la transaccion BAC
            '---CONTROL IDD, jcamposd anula toma de linea
   Else
      Me.A01_NumeroOperacion = Me.NuevoNumeroSwap
   End If

seguirAnulacion:
   
    'Genera Mapeo en curso de Fra y Activa Calculo PROD-10967
    Dim ResultadoREC As Double
    
    ResultadoREC = Calculorec_Fra(0, xxForm, FRM_SWAP_OP_FRA.RutCliente, FRM_SWAP_OP_FRA.CodCliente, MsgError_LCR, Metodologia_LCR)
    Error_LCR = MsgError_LCR
   
   Me.A04_TipoSwap = 3 'EntregaTipoSwap(MiForm)
   Me.A99_Estado = "P"
   If xxForm.Tag <> "" Then
      Me.A99_Estado = ""
   End If
   For iTipoFlujo = 1 To 2 '--->>>> 1:Compra; 2:Venta
      If xxForm.cmbTipo.ItemData(xxForm.cmbTipo.ListIndex) = 1 Then
         Set MiGrilla = IIf(iTipoFlujo = 1, xxForm.I_Grid, xxForm.D_Grid)
      Else
         Set MiGrilla = IIf(iTipoFlujo = 1, xxForm.D_Grid, xxForm.I_Grid)
      End If
      
      For iNumeroFlujos = 1 To MiGrilla.Rows - 1
         
         Me.A02_NumeroFlujo = iNumeroFlujos
         Me.A05_CarteraInversiones = FRM_SWAP_OP_FRA.CarteraFinanciera
         Me.A06_TipoOperacion = Mid(xxForm.cmbTipo.Text, 1, 1)
         
         If Me.A06_TipoOperacion = "T" Then
            If iTipoFlujo = 1 Then
               Me.A03_TipoFlujo = 2
            Else
               Me.A03_TipoFlujo = 1
            End If
         Else
            Me.A03_TipoFlujo = iTipoFlujo
         End If
         
         
         Me.A07_RutCliente = FRM_SWAP_OP_FRA.RutCliente
         Me.A08_CodCliente = FRM_SWAP_OP_FRA.CodCliente
         Me.A09_Moneda = xxForm.Moneda.ItemData(xxForm.Moneda.ListIndex)
         Me.A10_Nocionales = CDbl(xxForm.Nocionales.Text)
         Me.A11_Amortizacion = CDbl(MiGrilla.TextMatrix(iNumeroFlujos, 2))
         Me.A12_Saldo = CDbl(MiGrilla.TextMatrix(iNumeroFlujos, 8))
         Me.A13_Interes = CDbl(MiGrilla.TextMatrix(iNumeroFlujos, 4))
         Me.A14_Spread = CDbl(0#)
         If xxForm.cmbTipo.ItemData(xxForm.cmbTipo.ListIndex) = 1 Then
            Me.A15_Indicador = IIf(iTipoFlujo = 1, xxForm.C_Indicador.ItemData(xxForm.C_Indicador.ListIndex), xxForm.Indicador.ItemData(xxForm.Indicador.ListIndex))
            Me.A16_UltimoIndice = IIf(iTipoFlujo = 1, xxForm.C_Tasa.Text, xxForm.Tasa.Text)
         Else
            Me.A15_Indicador = IIf(iTipoFlujo = 1, xxForm.C_Indicador.ItemData(xxForm.C_Indicador.ListIndex), xxForm.Indicador.ItemData(xxForm.Indicador.ListIndex))
            Me.A16_UltimoIndice = IIf(iTipoFlujo = 1, xxForm.C_Tasa.Text, xxForm.Tasa.Text)
         End If
         Me.A17_ConteoDias = xxForm.ConteoDias.ItemData(xxForm.ConteoDias.ListIndex)
         If xxForm.Dias.Text < 90 Then
            Me.A18_FrecuenciaPago = 4 '--> 1:  Mensual
         ElseIf xxForm.Dias.Text >= 90 And xxForm.Dias.Text < 180 Then
            Me.A18_FrecuenciaPago = 3 '--> 3:  Trimestral
         ElseIf xxForm.Dias.Text >= 180 And xxForm.Dias.Text < 365 Then
            Me.A18_FrecuenciaPago = 2 '--> 6:  Semestral
         ElseIf xxForm.Dias.Text >= 365 Then
            Me.A18_FrecuenciaPago = 1 '--> 12: Anual
         End If
         Me.A19_FrecuenciaCapital = 6 '--> 0 : Bullet
         Me.A20_MonedaPago = xxForm.MonPago.ItemData(xxForm.MonPago.ListIndex)
         Me.A21_MedioPago = xxForm.MedioPago.ItemData(xxForm.MedioPago.ListIndex)
         Me.A22_MontoPago = CDbl(MiGrilla.TextMatrix(iNumeroFlujos, 10))
         Me.A23_MontoPagoCLP = CDbl(MiGrilla.TextMatrix(iNumeroFlujos, 12))
         Me.A24_MontoPagoUSD = CDbl(MiGrilla.TextMatrix(iNumeroFlujos, 11))
         Me.A25_ModalidadPago = Left(xxForm.Modalidad, 1)
         Me.A26_FechaCierre = gsBAC_Fecp
         Me.A27_FechaEfectiva = xxForm.FechaEfectiva.Text
         Me.A28_FechaPrimerPago = xxForm.FechaEfectiva.Text
         Me.A29_FechaPenultimoPago = xxForm.Madurez.Text
         Me.A30_FechaMadurez = xxForm.Madurez.Text
         If iNumeroFlujos = 1 Then
            Me.A31_FechaInicioFlujo = Me.A27_FechaEfectiva
         Else
            Me.A31_FechaInicioFlujo = Format(MiGrilla.TextMatrix(iNumeroFlujos - 1, 1), "dd/mm/yyyy")
         End If
         Me.A32_FechaTerminoFlujo = Format(MiGrilla.TextMatrix(iNumeroFlujos, 1), "dd/mm/yyyy")
         Me.A33_Usuario = gsBAC_User
         Me.A34_Observaciones = FRM_SWAP_OP_FRA.Observaciones
         Me.A37_AreaResponsable = FRM_SWAP_OP_FRA.AreaResponsable
         Me.A38_CarteraNormativa = FRM_SWAP_OP_FRA.CarteraNormativa
         Me.A39_SubCarteraNormativa = FRM_SWAP_OP_FRA.SubCarteraNormativa
         Me.A40_LibroNegociacion = FRM_SWAP_OP_FRA.LibroNegociacion
         If xxForm.cmbTipo.ItemData(xxForm.cmbTipo.ListIndex) = 1 Then
            Me.A41_DiasReset = IIf(iTipoFlujo = 1, xxForm.I_DiasReset.Text, xxForm.D_DiasReset.Text)
            Me.A49_Convencion = IIf(iTipoFlujo = 1, xxForm.I_Convencion.Text, xxForm.D_Convencion.Text)
            Me.A43_FeriadoFlujoChile = IIf(iTipoFlujo = 1, xxForm.I_FERIADOCHK(0).Value, xxForm.D_FERIADOCHK(0).Value)
            Me.A44_FeriadoFlujoEEUU = IIf(iTipoFlujo = 1, xxForm.I_FERIADOCHK(1).Value, xxForm.D_FERIADOCHK(1).Value)
            Me.A45_FeriadoFlujoEnglan = IIf(iTipoFlujo = 1, xxForm.I_FERIADOCHK(2).Value, xxForm.D_FERIADOCHK(2).Value)
            Me.A46_FeriadoLiquiChile = IIf(iTipoFlujo = 1, xxForm.I_FERIADOCHK(3).Value, xxForm.D_FERIADOCHK(3).Value)
            Me.A47_FeriadoLiquiEEUU = IIf(iTipoFlujo = 1, xxForm.I_FERIADOCHK(4).Value, xxForm.D_FERIADOCHK(4).Value)
            Me.A48_FeriadoLiquiEnglan = IIf(iTipoFlujo = 1, xxForm.I_FERIADOCHK(5).Value, xxForm.D_FERIADOCHK(5).Value)
            Me.A50_Note = ""
         Else
            Me.A41_DiasReset = IIf(iTipoFlujo = 2, xxForm.I_DiasReset.Text, xxForm.D_DiasReset.Text)
            Me.A49_Convencion = IIf(iTipoFlujo = 2, xxForm.I_Convencion.Text, xxForm.D_Convencion.Text)
            Me.A43_FeriadoFlujoChile = IIf(iTipoFlujo = 2, xxForm.I_FERIADOCHK(0).Value, xxForm.D_FERIADOCHK(0).Value)
            Me.A44_FeriadoFlujoEEUU = IIf(iTipoFlujo = 2, xxForm.I_FERIADOCHK(1).Value, xxForm.D_FERIADOCHK(1).Value)
            Me.A45_FeriadoFlujoEnglan = IIf(iTipoFlujo = 2, xxForm.I_FERIADOCHK(2).Value, xxForm.D_FERIADOCHK(2).Value)
            Me.A46_FeriadoLiquiChile = IIf(iTipoFlujo = 2, xxForm.I_FERIADOCHK(3).Value, xxForm.D_FERIADOCHK(3).Value)
            Me.A47_FeriadoLiquiEEUU = IIf(iTipoFlujo = 2, xxForm.I_FERIADOCHK(4).Value, xxForm.D_FERIADOCHK(4).Value)
            Me.A48_FeriadoLiquiEnglan = IIf(iTipoFlujo = 2, xxForm.I_FERIADOCHK(5).Value, xxForm.D_FERIADOCHK(5).Value)
            Me.A50_Note = ""
         End If
         Me.A42_FechaFijaTasa = Format(MiGrilla.TextMatrix(iNumeroFlujos, 16), "dd/mm/yyyy")
         Me.A51_IntercambioPrincipal = 0 'MiForm.Intercambio(0).Value
         Me.A52_Tikker = "" 'MiForm.TIKKER.Text
         Me.A53_FechaLiquidacion = Format(MiGrilla.TextMatrix(iNumeroFlujos, 14), "dd/mm/yyyy")
         Me.A53_FechaReset = Format(MiGrilla.TextMatrix(iNumeroFlujos, 16), "dd/mm/yyyy")
         
         '//CER 05/05/2008   Variables - Req. Pantalla Ingreso Op. Swap
         
         Me.A65_Operador = FRM_SWAP_OP_FRA.lblOperador.Caption   'JBH, 22-12-2009

         Me.A55_FxRate = CDbl(MiGrilla.TextMatrix(iNumeroFlujos, 0))
         Me.A56_PrcAmortiza = CDbl(MiGrilla.TextMatrix(iNumeroFlujos, 2))
         Me.A57_FechaValuta = Format(MiGrilla.TextMatrix(iNumeroFlujos, 9), "dd/mm/yyyy")
         Me.A58_FlujoAdicional = 0 'CDbl(MiGrilla.TextMatrix(iNumeroFlujos, 21))
         AddParam Envia, 0
         AddParam Envia, 0
         AddParam Envia, 0
         AddParam Envia, 0
         

         If Grabación = False Then
            If Not Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
               MsgBox "Error en la grabación" & vbCrLf & "Imposible generar transacciones.", vbExclamation, TITSISTEMA
               Exit Function
            End If
            MsgBox "Error en la Grabación" & vbCrLf & vbCrLf & err.Description, vbCritical, TITSISTEMA
            Exit Function
         End If
      Next iNumeroFlujos
   Next iTipoFlujo

    'PROD-10967
    If gsBac_Lineas = "S" Then
        Mensaje = ""
        
        If Not Lineas_ChequearGrabar("PCS", CDbl(A04_TipoSwap), A01_NumeroOperacion _
                                    , 0, 0, Me.A07_RutCliente, Me.A08_CodCliente _
                                    , CDbl(A10_Nocionales), 0#, A30_FechaMadurez, 0 _
                                    , 0, CDate(gsBAC_Fecp), 0, "N", Val(A09_Moneda) _
                                    , "C", 0, "N", 0, CDate(gsBAC_Fecp), 0 _
                                    , Val(A21_MedioPago), ResultadoREC, Metodologia_LCR) Then
            Exit Function
        End If
              
        MercadoLc = "N"
        If nPaisOrigen = 6 Then
            MercadoLc = "S"
        End If
        
        Mensaje_Con = Lineas_ConsultaOperacion("PCS", CDbl(A04_TipoSwap), A01_NumeroOperacion, " ", "N", MercadoLc)
        
        '       Agregar el mensaje del Control de Precios y Tasas ssi modo no silencioso
        '       If Ctrlpt_ModoOperacion <> "S" Then
        '       If Trim(Ctrlpt_Mensaje) <> "" Then
        '          Mensaje_Con = Mensaje_Con & vbCrLf & Ctrlpt_Mensaje
        '       End If
        '       End If
        
        If Trim(Mensaje_Con) <> "" Then
            If MsgBox("ATENCION" & vbCrLf & "LA OPERACION GENERARA LOS SIGUIENTES ERRORES" & Mensaje_Con & vbCrLf & vbCrLf & "¿Desea Grabar la Operación ?", vbYesNo + vbExclamation, TITSISTEMA) = vbNo Then
               'Call Lineas_BorraConsultaOperacion("PCS", A01_NumeroOperacion)
               Screen.MousePointer = vbDefault
               Call BacRollBackTransaction
                'PROD-10967
                If Metodologia_LCR <> 1 And Metodologia_LCR <> 4 Then
                   'Se incluye esto dentro de la transaccion
                   'a proposito ya que el cliente se bloquea antes
                   'de la TRN de grabación, por tanto se sabrá de
                   'caidas por llamar para sacar al cliente de
                   'imputación.
                       Call Elimina_Cliente_Imputacion(Me.A07_RutCliente, Me.A08_CodCliente)
                End If
                'PROD-10967
               Exit Function
            End If
        End If
        
        'Si Acepta y Tiene Errores Sigue Normal
        Mensaje = Mensaje & Lineas_Chequear("PCS", CDbl(A04_TipoSwap), A01_NumeroOperacion, " ", "N", MercadoLc)
        If Mensaje <> "" Then
            MsgBox "Error al Chequear Lineas : " + Chr(10) + Chr(13) + Chr(10) + Chr(13) + Mensaje, vbCritical, Msj
        End If
    End If '--> gsBac_Lineas = "S"
    'PROD-10967
   
   If Not Lineas_GrbOperacion("PCS", CDbl(A04_TipoSwap), CDbl(A01_NumeroOperacion), CDbl(A01_NumeroOperacion), " ", "N", "L") Then
      If Not Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
         MsgBox "Error en la grabación" & vbCrLf & "Imposible generar transacciones.", vbExclamation, TITSISTEMA
         Exit Function
      End If
   Else
   
    If MarcaAplicaLinea = 1 Then
       '+++CONTROL IDD, jcamposd llamada a nuevo control IDD para las líneas
        Dim oParametrosLinea As New clsControlLineaIDD

            With oParametrosLinea
                .Modulo = "PCS"
                .Producto = CDbl(A04_TipoSwap)
                .Operacion = CDbl(A01_NumeroOperacion)
                .Documento = CDbl(A01_NumeroOperacion)
                .Correlativo = 0
                .Accion = "Y"

                .RecuperaDatosLineaIDD
                
                .MontoArticulo84 = 0 'Para los FRA envia cero el ART84
                
                .EjecutaProcesoWsLineaIDD
            End With
            Set oParametrosLinea = Nothing
            On Error GoTo seguirprocesoGbr
    '---CONTROL IDD, jcamposd llamada a nuevo control IDD para las líneas
    End If
      
   End If
seguirprocesoGbr:

   '********** Linea -- Mkilo
   Mensaje_Lin = ""
   Mensaje_Lim = ""
   If gsBac_Lineas = "S" Then
      Mensaje_Lin = Lineas_Error("PCS", CDbl(A01_NumeroOperacion))
      Mensaje_Lim = Limites_Error("PCS", CDbl(A01_NumeroOperacion))
   End If

   Envia = Array()
   AddParam Envia, CDbl(A01_NumeroOperacion)
   AddParam Envia, Trim(Mensaje_Lin)
   AddParam Envia, Trim(Mensaje_Lim)
   AddParam Envia, Trim(Error_LCR) 'PROD-10967
   If Not Bac_Sql_Execute("SP_GRABAOBSERVACIONLINEAS", Envia) Then
      If Not Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
         MsgBox "Error en la grabación" & vbCrLf & "Imposible generar transacciones.", vbExclamation, TITSISTEMA
         Exit Function
      End If
      MsgBox "Problemas al Grabar Observacion Lineas", vbExclamation, TITSISTEMA
   End If
    
    
    'PROD-10967
    If Metodologia_LCR <> 1 And Metodologia_LCR <> 4 Then
       'Se incluye esto dentro de la transaccion
       'a proposito ya que el cliente se bloquea antes
       'de la TRN de grabación, por tanto se sabrá de
       'caidas por llamar para sacar al cliente de
       'imputación.
       Call Elimina_Cliente_Imputacion(miForm.RutCliente, miForm.CodCliente)
    End If
    'PROD-10967
    
   If Not Bac_Sql_Execute("COMMIT TRANSACTION") Then
      MsgBox "Error en la grabación" & vbCrLf & "Imposible generar transacciones.", vbExclamation, TITSISTEMA
      Exit Function
   End If

    'PROD-10967
    Envia = Array()
    AddParam Envia, CDbl(A01_NumeroOperacion)
    AddParam Envia, IIf(Cotizacion, "C", " ")
    AddParam Envia, CDbl(ResultadoREC)
    AddParam Envia, CDbl(Metodologia_LCR)
    AddParam Envia, 0
    If Not Bac_Sql_Execute("SP_GUARDARCOMO", Envia) Then
        If Not Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
            MsgBox "Error en Guardar como " & TipoGrab & vbCrLf & "Imposible generar transacciones.", vbExclamation, TITSISTEMA
            Exit Function
        End If
        MsgBox "Problemas al Guardar como " & TipoGrab, vbExclamation, TITSISTEMA
    End If
    'PROD-10967

   Screen.MousePointer = vbDefault
   
   'PRD-4858, 15-02-2010 Aquí llamar al form del Threshold ssi Thr_AplicaThreshold = True
   If Thr_Cotizacion = False Then
      If Thr_AplicaThreshold = True Then
         Thr_GrabaThreshold = False
         Thr_NumeroOperacion = A01_NumeroOperacion
         BacThreshold.Caption = "Threshold en Operación FRA"
         BacThreshold.Show 1
       
         If Thr_GrabaThreshold = False Then
            PreGrabadoFRA = False
            Exit Function
         End If
         Call ActualizaThresholdMovtos("S")
         Call ActualizaAplicThreshold
      Else
         Call ActualizaThresholdMovtos("N")
      End If
   End If
   
   'Control de Garantías, PRD-5521
   'control de Garantía no se hará aquí sino en inicio día
'   If ControlGarantias(Me.A07_RutCliente, Me.A08_CodCliente, Me.A01_NumeroOperacion) Then
'        Gar_FvctoOper = Me.A32_FechaTerminoFlujo
'        FRM_ASOCIA_GARANTIAS.Show vbModal
'   End If
   'Fin Control de Garantías PRD-5521
  
  
   MsgBox "Grabación Ok." & vbCrLf & vbCrLf & "Operación N° : " & Format(A01_NumeroOperacion, TipoFormato("CLP")) & " Se ha grabado en forma correcta.", vbInformation, TITSISTEMA
   PreGrabadoFRA = True

   If A38_CarteraNormativa = "C" Then
      If MsgBox("Proceso Coberturas." & vbCrLf & vbCrLf & "¿ Desea Generar Cobertura para este Derivado. ?", vbQuestion + vbYesNo, TITSISTEMA) = vbYes Then
         FRM_MNT_COBERTURA.Derivado = A01_NumeroOperacion
         FRM_MNT_COBERTURA.Correlativo = 1
         FRM_MNT_COBERTURA.Modulo = "PCS"
         FRM_MNT_COBERTURA.Show 1
      End If
   End If
End Function

Private Function Calculorec_Fra(Num As Integer, miForm As Form, Rut As Long _
                                         , codcli As Long _
                                         , ByRef Det_MsgError As String _
                                         , Det_Metodologia_LCR As Integer)
    

    'PROD-10967
    Screen.MousePointer = vbDefault
  
    Dim miClase         As New Swap_OP
    Dim iNumeroFlujos   As Integer
    Dim iTipoFlujo      As Integer
    Dim MiGrilla        As MSFlexGrid
    Dim MonedaBac       As Integer
    Dim Convencion      As Integer
    Dim Base            As Integer
    Dim PlazoFwd        As Integer
    Dim CodigoTasa      As Long
    Dim TipoSwap        As Integer
    Dim FechaInicioFlujo As Date
    'Dim Det_MsgError        As String
    Dim FechaMadurez        As Date
    Dim Det_Threshold_LCR   As Double
    'Dim Det_Metodologia_LCR As Integer
    Dim Det_Cliente_LCR     As String
    Screen.MousePointer = vbHourglass
   
    Dim SwapCarteraREC As Negociacion
    
    Det_Metodologia_LCR = miForm.Fra_Metodologia_LCR
    Det_Threshold_LCR = miForm.Fra_Threshold_LCR
    Det_Cliente_LCR = miForm.Fra_Cliente_LCR
       
    'PROD-10967
    If Det_Metodologia_LCR <> 1 And Det_Metodologia_LCR <> 4 Then
        
        Dim Indicador As Long
        Let Indicador = 0
        
        For iTipoFlujo = 1 To 2
        
            If miForm.CmbTipoFra = 1 Then
                Set MiGrillaaux = IIf(iTipoFlujo = 1, miForm.I_Grid, miForm.D_Grid)
            Else
                Set MiGrillaaux = IIf(iTipoFlujo = 1, FRM_SWAP_OP_FRA.D_Grid, FRM_SWAP_OP_FRA.I_Grid)
            End If
             'Set MiGrillaAux = IIf(iTipoFlujo = 1, miForm.I_Grid, miForm.D_Grid)
            For iNumeroFlujos = 1 To MiGrillaaux.Rows - 1
                 'POR HACER: donde esta el tipo de dato en comentario
                 ' se debe llamar a una funcion para que obtenga
                 ' los valores
                 ReDim Preserve SwapCarteraREC.Cartera_Swap(Indicador)
                 SwapCarteraREC.Cartera_Swap(Indicador).Rut = Rut
                 SwapCarteraREC.Cartera_Swap(Indicador).Codigo = codcli
                 SwapCarteraREC.Cartera_Swap(Indicador).Numero_Operacion = 0 'miClase.A01_NumeroOperacion
                 SwapCarteraREC.Cartera_Swap(Indicador).Numero_flujo = iNumeroFlujos
                 SwapCarteraREC.Cartera_Swap(Indicador).Tipo_flujo = iTipoFlujo
                 SwapCarteraREC.Cartera_Swap(Indicador).Tipo_swap = 3 'EntregaTipoSwap(Miform)Modificar
                
                 
                 SwapCarteraREC.Cartera_Swap(Indicador).Modalidad_pago = Left(miForm.Modalidad, 1)
                 SwapCarteraREC.Cartera_Swap(Indicador).Cartera = 0 'As Long para siempre
                 
                 MonedaBac = miForm.Moneda.ItemData(miForm.Moneda.ListIndex)
            '              MonedaBac = IIf(iTipoFlujo = 1 _
            '                        , Miform.I_Moneda.ItemData(Miform.I_Moneda.ListIndex) _
            '                        , Miform.D_Moneda.ItemData(Miform.D_Moneda.ListIndex))
                 
                 SwapCarteraREC.Cartera_Swap(Indicador).Moneda = Func_Riesgo_Financiero(MonedaBac)
'                 If ParamMoneda_LCR = True Then
'                     ParamMoneda_LCR = False
'                     Exit Function
'                 End If
                 SwapCarteraREC.Cartera_Swap(Indicador).Codigo_tasa = IIf(iTipoFlujo = 1, _
                             miForm.Indicador.ItemData(miForm.Indicador.ListIndex), _
                             miForm.Indicador.ItemData(miForm.Indicador.ListIndex))
                             
                             
                 Convencion = miForm.ConteoDias.ItemData(miForm.ConteoDias.ListIndex)
            '              Convencion = IIf(iTipoFlujo = 1 _
            '                         , Miform.I_ConteoDias.ItemData(Miform.I_ConteoDias.ListIndex) _
            '                         , Miform.D_ConteoDias.ItemData(Miform.D_ConteoDias.ListIndex))
                 
                 SwapCarteraREC.Cartera_Swap(Indicador).Convencion = Func_TipoConvencio(Convencion)     '"P"  ' As String
                 Base = miForm.ConteoDias.ItemData(miForm.ConteoDias.ListIndex)
                 
            '              Base = IIf(iTipoFlujo = 1 _
            '                      , Miform.I_ConteoDias.ItemData(Miform.I_ConteoDias.ListIndex) _
            '                      , Miform.D_ConteoDias.ItemData(Miform.D_ConteoDias.ListIndex))
                 
                 SwapCarteraREC.Cartera_Swap(Indicador).Base = Func_BaseSwap(Base)   ' 360 'As Long
                 
                 PlazoFwd = miForm.Indicador.ItemData(miForm.Indicador.ListIndex)
            '              PlazoFwd = IIf(iTipoFlujo = 1 _
            '                      , Miform.I_Indicador.ItemData(Miform.I_Indicador.ListIndex) _
            '                      , Miform.D_Indicador.ItemData(Miform.D_Indicador.ListIndex))
                 
                 SwapCarteraREC.Cartera_Swap(Indicador).PlazoFwd = Func_BaseForward(PlazoFwd)   '180 'As Long
                 
                 SwapCarteraREC.Cartera_Swap(Indicador).IndexLag = IIf(iTipoFlujo = 1 _
                                         , miForm.I_DiasReset.Text, miForm.D_DiasReset.Text)
                 
                 If iTipoFlujo = 1 Then
                   SwapCarteraREC.Cartera_Swap(Indicador).Fecha_ini = IIf(iNumeroFlujos = 1, miForm.FechaEfectiva.Text _
                                                       , Format(MiGrillaaux.TextMatrix(iNumeroFlujos - 1, 1), "dd/mm/yyyy"))
                 Else
                   SwapCarteraREC.Cartera_Swap(Indicador).Fecha_ini = IIf(iNumeroFlujos = 1, miForm.FechaEfectiva.Text _
                                                       , Format(MiGrillaaux.TextMatrix(iNumeroFlujos - 1, 1), "dd/mm/yyyy"))
                 End If
                 
                 
                 SwapCarteraREC.Cartera_Swap(Indicador).Fecha_fin = Format(MiGrillaaux.TextMatrix(iNumeroFlujos, 1), "dd/mm/yyyy")
                 SwapCarteraREC.Cartera_Swap(Indicador).Fecha_fija = Format(MiGrillaaux.TextMatrix(iNumeroFlujos, 16), "dd/mm/yyyy")
                 SwapCarteraREC.Cartera_Swap(Indicador).Fecha_liq = Format(MiGrillaaux.TextMatrix(iNumeroFlujos, 14), "dd/mm/yyyy") ' As Date
                 
                 CodigoTasa = SwapCarteraREC.Cartera_Swap(Indicador).Codigo_tasa
                 TipoSwap = 1 ''SwapCarteraREC(Indicador).Tipo_swap
                 SwapCarteraREC.Cartera_Swap(Indicador).Codigo_descuento = Func_CodigoDescuento(MonedaBac, CodigoTasa, TipoSwap, 1) '0 'As Long
'                 If ParamMoneda_LCR = True Then
'                     ParamMoneda_LCR = False
'                     Exit Function
'                 End If
                 SwapCarteraREC.Cartera_Swap(Indicador).Codigo_forward = Func_CodigoDescuento(MonedaBac, CodigoTasa, TipoSwap, 2) '1 'As Long
'                 If ParamMoneda_LCR = True Then
'                     ParamMoneda_LCR = False
'                     Exit Function
'                 End If
                 
                 'SwapCarteraREC(Indicador).Tasa_flujo = CDbl(MiGrillaaux.TextMatrix(iNumeroFlujos, 23))
                 
                 SwapCarteraREC.Cartera_Swap(Indicador).Tasa_flujo = IIf(iTipoFlujo = 1, miForm.C_Tasa.Text, miForm.Tasa.Text) / 100#
                 SwapCarteraREC.Cartera_Swap(Indicador).Spread = CDbl(0#) 'CDbl(MiGrillaaux.TextMatrix(iNumeroFlujos, 24))
                 SwapCarteraREC.Cartera_Swap(Indicador).Saldo = CDbl(MiGrillaaux.TextMatrix(iNumeroFlujos, 8)) + CDbl(MiGrillaaux.TextMatrix(iNumeroFlujos, 2))
                 SwapCarteraREC.Cartera_Swap(Indicador).Amortizacion = CDbl(MiGrillaaux.TextMatrix(iNumeroFlujos, 2))
                 SwapCarteraREC.Cartera_Swap(Indicador).Flujo_adicional = CDbl(0#) 'CDbl(MiGrillaaux.TextMatrix(iNumeroFlujos, 21))
                 SwapCarteraREC.Cartera_Swap(Indicador).Valor_Mercado_BAC = 0
                 SwapCarteraREC.Cartera_Swap(Indicador).Moneda_Bac = MonedaBac
                 FechaMadurez = IIf(iTipoFlujo = 1, miForm.Madurez.Text, miForm.Madurez.Text)
                 SwapCarteraREC.Cartera_Swap(Indicador).Plazo = DateDiff("D", gsBAC_Fecp, FechaMadurez)
                 
                 'Datos calculados
                 SwapCarteraREC.Cartera_Swap(Indicador).Plazo_ini = 0
                 SwapCarteraREC.Cartera_Swap(Indicador).Plazo_fin = 0
                 SwapCarteraREC.Cartera_Swap(Indicador).Plazo_liq = 0
                 SwapCarteraREC.Cartera_Swap(Indicador).Dias = 0
                 SwapCarteraREC.Cartera_Swap(Indicador).Valor_Mercado = 0
                 'Valor_Simulacion() As Double
                 
                 If SwapCarteraREC.Cartera_Swap(Indicador).Codigo_tasa = 13 Then
                     SwapCarteraREC.Cartera_Swap(Indicador).PlazoFwd = CuentaDias(SwapCarteraREC.Cartera_Swap(Indicador).Fecha_ini _
                     , SwapCarteraREC.Cartera_Swap(Indicador).Fecha_fin _
                     , SwapCarteraREC.Cartera_Swap(Indicador).Convencion _
                     , SwapCarteraREC.Cartera_Swap(Indicador).Base)
                 End If
               
                 Let Indicador = Indicador + 1
            Next
        Next

        Dim ResultadoREC As Double
        Let ResultadoREC = ProcesoCalculoREC(Rut, codcli, Det_Cliente_LCR _
                                                   , SwapCarteraREC _
                                                   , "Swap" _
                                                   , Det_Threshold_LCR _
                                                   , Det_Metodologia_LCR _
                                                   , Det_MsgError, 0)
                                                   
        Calculorec_Fra = ResultadoREC
    End If
End Function
Public Function PreGrabadoSim(miForm As Form) As Boolean
   Dim iNumeroFlujos    As Integer
   Dim iTipoFlujo       As Integer
   Dim MiGrilla         As MSFlexGrid
   Dim Msg$
   Dim TipoGrab         As String
   
   Dim Mensaje          As String
   Dim Mensaje_Con      As String
   Dim MercadoLc        As String

   Dim resControlPT     As String   'PRD-3860
   Dim Mensaje_CPT      As String
   Dim ValorBuscado As Double
   
   PreGrabadoSim = False
   
   ValorBuscado = -1
   
   If Not Bac_Sql_Execute("BEGIN TRANSACTION") Then
      MsgBox "Error en la grabación" & vbCrLf & "Imposible generar transacciones.", vbExclamation, TITSISTEMA
      Exit Function
   End If
   If miForm.Tag <> "" Then
      Me.A01_NumeroOperacion = Val(miForm.Tag)
      'Call Lineas_Anular("PCS", CDbl(Me.A01_NumeroOperacion))
   Else
      'Me.A01_NumeroOperacion = Me.NuevoNumeroSwap
      Me.A01_NumeroOperacion = Me.NuevoNumeroSwapSim
   End If
   
   Me.A04_TipoSwap = EntregaTipoSwap(miForm)
   Me.A99_Estado = "P"
   If miForm.Tag <> "" Then
      Me.A99_Estado = ""
   End If

   For iTipoFlujo = 1 To 2
      Set MiGrilla = IIf(iTipoFlujo = 1, miForm.I_Grid, miForm.D_Grid)
      For iNumeroFlujos = 1 To MiGrilla.Rows - 1
         Me.A02_NumeroFlujo = iNumeroFlujos
         Me.A03_TipoFlujo = iTipoFlujo
         Me.A05_CarteraInversiones = miForm.CarteraFinanciera
         Me.A06_TipoOperacion = "C"
         Me.A07_RutCliente = "0"   'miForm.RutCliente
         Me.A08_CodCliente = "0"          'miForm.CodCliente
         Me.A09_Moneda = IIf(iTipoFlujo = 1, miForm.I_Moneda.ItemData(miForm.I_Moneda.ListIndex), miForm.D_Moneda.ItemData(miForm.D_Moneda.ListIndex))
         Me.A10_Nocionales = CDbl(IIf(iTipoFlujo = 1, miForm.I_Nocionales.Text, miForm.D_Nocionales.Text))
         Me.A11_Amortizacion = CDbl(MiGrilla.TextMatrix(iNumeroFlujos, 2))
         Me.A12_Saldo = CDbl(MiGrilla.TextMatrix(iNumeroFlujos, 8))
         Me.A13_Interes = CDbl(MiGrilla.TextMatrix(iNumeroFlujos, 4))
         Me.A14_Spread = CDbl(MiGrilla.TextMatrix(iNumeroFlujos, 24)) ''CDbl(IIf(iTipoFlujo = 1, MiForm.I_Spread.Text, MiForm.D_Spread.Text))
         Me.A15_Indicador = IIf(iTipoFlujo = 1, miForm.I_Indicador.ItemData(miForm.I_Indicador.ListIndex), miForm.D_Indicador.ItemData(miForm.D_Indicador.ListIndex))
         Me.A16_UltimoIndice = CDbl(MiGrilla.TextMatrix(iNumeroFlujos, 23)) ''CDbl(IIf(iTipoFlujo = 1, MiForm.I_UltimoIndice.Text, MiForm.D_UltimoIndice.Text))
         Me.A17_ConteoDias = IIf(iTipoFlujo = 1, miForm.I_ConteoDias.ItemData(miForm.I_ConteoDias.ListIndex), miForm.D_ConteoDias.ItemData(miForm.D_ConteoDias.ListIndex))
         Me.A18_FrecuenciaPago = Right(IIf(iTipoFlujo = 1, miForm.I_FrecuenciaPago, miForm.D_FrecuenciaPago), 10)
         Me.A19_FrecuenciaCapital = Right(IIf(iTipoFlujo = 1, miForm.I_FrecuenciaCapital, miForm.D_FrecuenciaCapital), 10)
         Me.A20_MonedaPago = IIf(iTipoFlujo = 1, miForm.I_MonPago.ItemData(miForm.I_MonPago.ListIndex), miForm.D_MonPago.ItemData(miForm.D_MonPago.ListIndex))
         Me.A21_MedioPago = IIf(iTipoFlujo = 1, miForm.I_MedioPago.ItemData(miForm.I_MedioPago.ListIndex), miForm.D_MedioPago.ItemData(miForm.D_MedioPago.ListIndex))
         Me.A22_MontoPago = CDbl(MiGrilla.TextMatrix(iNumeroFlujos, 10))
         Me.A23_MontoPagoCLP = CDbl(MiGrilla.TextMatrix(iNumeroFlujos, 12))
         Me.A24_MontoPagoUSD = CDbl(MiGrilla.TextMatrix(iNumeroFlujos, 11))
         Me.A25_ModalidadPago = Left(miForm.Modalidad, 1)
         Me.A26_FechaCierre = gsBAC_Fecp
         Me.A27_FechaEfectiva = IIf(iTipoFlujo = 1, miForm.I_FechaEfectiva.Text, miForm.D_FechaEfectiva.Text)
         Me.A28_FechaPrimerPago = IIf(iTipoFlujo = 1, miForm.I_PrimerPago.Text, miForm.D_PrimerPago.Text)
         Me.A29_FechaPenultimoPago = IIf(iTipoFlujo = 1, miForm.I_PenultimoPago.Text, miForm.D_PenultimoPago.Text)
         Me.A30_FechaMadurez = IIf(iTipoFlujo = 1, miForm.I_Madurez.Text, miForm.D_Madurez.Text)

         If iNumeroFlujos = 1 Then
            Me.A31_FechaInicioFlujo = Me.A27_FechaEfectiva
         Else
            Me.A31_FechaInicioFlujo = Format(MiGrilla.TextMatrix(iNumeroFlujos - 1, 1), "dd/mm/yyyy")
         End If
         
         Me.A32_FechaTerminoFlujo = Format(MiGrilla.TextMatrix(iNumeroFlujos, 1), "dd/mm/yyyy")
         Me.A33_Usuario = gsBAC_User
         Me.A34_Observaciones = ""
         Me.A37_AreaResponsable = 0 '6             'miForm.AreaResponsable
         Me.A38_CarteraNormativa = "T"          'miForm.CarteraNormativa
         Me.A39_SubCarteraNormativa = 0 '4         'miForm.SubCarteraNormativa
         Me.A40_LibroNegociacion = 0  '1            'miForm.LibroNegociacion
         Me.A41_DiasReset = IIf(iTipoFlujo = 1, miForm.I_DiasReset.Text, miForm.D_DiasReset.Text)
         Me.A42_FechaFijaTasa = Format(MiGrilla.TextMatrix(iNumeroFlujos, 16), "dd/mm/yyyy")
         Me.A43_FeriadoFlujoChile = IIf(iTipoFlujo = 1, miForm.I_FERIADOCHK(0).Value, miForm.D_FERIADOCHK(0).Value)
         Me.A44_FeriadoFlujoEEUU = IIf(iTipoFlujo = 1, miForm.I_FERIADOCHK(1).Value, miForm.D_FERIADOCHK(1).Value)
         Me.A45_FeriadoFlujoEnglan = IIf(iTipoFlujo = 1, miForm.I_FERIADOCHK(2).Value, miForm.D_FERIADOCHK(2).Value)
         Me.A46_FeriadoLiquiChile = IIf(iTipoFlujo = 1, miForm.I_FERIADOCHK(3).Value, miForm.D_FERIADOCHK(3).Value)
         Me.A47_FeriadoLiquiEEUU = IIf(iTipoFlujo = 1, miForm.I_FERIADOCHK(4).Value, miForm.D_FERIADOCHK(4).Value)
         Me.A48_FeriadoLiquiEnglan = IIf(iTipoFlujo = 1, miForm.I_FERIADOCHK(5).Value, miForm.D_FERIADOCHK(5).Value)
         Me.A49_Convencion = IIf(iTipoFlujo = 1, miForm.I_Convencion.Text, miForm.D_Convencion.Text)
         Me.A50_Note = IIf(iTipoFlujo = 1, miForm.I_Note.Text, miForm.D_Note.Text)
         '//CER 05/05/2008   Variables - Req. Pantalla Ingreso Op. Swap
         Me.A51_IntercambioPrincipal = IIf(MiGrilla.TextMatrix(iNumeroFlujos, 19) = "No", 0, 1) ''MiForm.Intercambio(0).Value
         Me.A52_Tikker = miForm.TIKKER.Text
         Me.A53_FechaLiquidacion = Format(MiGrilla.TextMatrix(iNumeroFlujos, 14), "dd/mm/yyyy")
         Me.A53_FechaReset = Format(MiGrilla.TextMatrix(iNumeroFlujos, 16), "dd/mm/yyyy")
         '//CER 05/05/2008   Variables - Req. Pantalla Ingreso Op. Swap
         Me.A55_FxRate = CDbl(MiGrilla.TextMatrix(iNumeroFlujos, 22))
         Me.A56_PrcAmortiza = CDbl(MiGrilla.TextMatrix(iNumeroFlujos, 18))
         Me.A57_FechaValuta = Format(MiGrilla.TextMatrix(iNumeroFlujos, 20), "dd/mm/yyyy")
         Me.A58_FlujoAdicional = CDbl(MiGrilla.TextMatrix(iNumeroFlujos, 21))
         
         Me.A59_Tasa_Transfer = IIf(iTipoFlujo = 1, miForm.I_Indice_Tran.Text, miForm.D_Indice_Tran.Text)
         Me.A60_Spread_Transfer = IIf(iTipoFlujo = 1, miForm.I_Spread_Tran.Text, miForm.D_Spread_Tran.Text)
         'Me.A61_Res_Mesa_Dist_CLP = miForm.ssp_Res_Mesa_Dist.Caption
         'Me.A62_Res_Mesa_Dist_USD = miForm.ssp_Res_Mesa_Dist_USD.Caption
         Me.A61_Res_Mesa_Dist_CLP = miForm.txt_Res_Mesa_Dist.Text
         Me.A62_Res_Mesa_Dist_USD = miForm.txt_Res_Mesa_Dist_USD.Text
         
         Me.A65_Operador = ""            'miForm.lblOperador.Caption   'JBH, 22-12-2009
         
         '-- MAP 20080425 Solo se graba si es mayor
         '-- o igual a la fecha de proceso
         '-- If DateDiff("D", gsBAC_Fecp, Me.A32_FechaTerminoFlujo) >= 0 Then
         '-- CER 20081014 Se cambia Me.A32_FechaTerminoFlujo por Me.A53_FechaLiquidacion,
         '--             tema pagos multiples.
            If DateDiff("D", gsBAC_Fecp, Me.A53_FechaLiquidacion) >= 0 Then
            If GrabaciónSim = False Then
                If Not Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
                    MsgBox "Error en la grabación" & vbCrLf & "Imposible generar transacciones.", vbExclamation, TITSISTEMA
                    Exit Function
                End If
                MsgBox "Error en la Grabación" & vbCrLf & vbCrLf & err.Description, vbCritical, TITSISTEMA
                Exit Function
            End If
         End If  '<-- MAP
      Next iNumeroFlujos
   Next iTipoFlujo
   
   'Valorización Swap x Curva '0'

  '''FrmAvisoValorizacion.Show
  'FrmAvisoValorizacion.ListProblemasValoriza.Clear
  
  Dim numborrar As Double
   numborrar = A01_NumeroOperacion
  
  If Not Bac_Sql_Execute("COMMIT TRANSACTION") Then
      Screen.MousePointer = vbDefault
      MsgBox "Error en la grabación" & vbCrLf & "Imposible generar transacciones.", vbExclamation, TITSISTEMA
         Exit Function
  End If
      
  Msg = ""

   Envia = Array()
   AddParam Envia, gsBAC_Fecp
   AddParam Envia, CDbl(numborrar)
   
   If Not Bac_Sql_Execute("SP_CALCVAR_SIM", Envia) Then
      If Not Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
         MsgBox "Error en la Valorización" & vbCrLf & "Imposible generar transacciones.", vbExclamation, TITSISTEMA
         Exit Function
      End If
      MsgBox "Problemas al Valorizar Operación ", vbExclamation, TITSISTEMA
   Else
        Do While Bac_SQL_Fetch(Datos())
    
         If Datos(1) <> 1 Then
              Msg = "Problemas en Valorización con Operación # " & Datos(2)
              Msg = Msg & Space(1) & Datos(5)
         End If
         
        Loop
    
    End If
   
   'si todo Ok, tomar la valorizacion y borrar todos los movimientos generados
   'en las tablas:
   If ValorBuscado = -1 Then
        'Dim Datos()
        Envia = Array()
        AddParam Envia, CDbl(numborrar)
        If Bac_Sql_Execute("SP_OBTAVR_SIM", Envia) Then
            Do While Bac_SQL_Fetch(Datos())
                ValorBuscado = CDbl(Datos(1))
                Exit Do
            Loop
        End If
   End If
   
   
   'Cambios Art 84
    
    
   gblSW_Valor_MTM = ValorBuscado
    
    'Fin Cambios Art 84
    
   Envia = Array()
   AddParam Envia, numborrar
   If Not Bac_Sql_Execute("SP_BORRAMOV_SIM", Envia) Then
   End If
   
   If ValorBuscado <> -1 Then
        Ctrlpt_ValorRazonable = ValorBuscado
   Else
        Ctrlpt_ValorRazonable = 0
   End If
   
   Screen.MousePointer = vbDefault

   PreGrabadoSim = True
   
   

End Function
Public Function PreGrabado(miForm As Form) As Boolean
   Dim iNumeroFlujos    As Integer
   Dim iTipoFlujo       As Integer
   Dim MiGrilla         As MSFlexGrid
   Dim Msg$
   Dim TipoGrab         As String
   
   Dim Mensaje          As String
   Dim Mensaje_Con      As String
   Dim MercadoLc        As String

   Dim resControlPT     As String   'PRD-3860
   Dim Mensaje_CPT      As String
   
   Dim nTipRela         As Integer
   Dim motBloqueoClt    As String    'PRD-6066
    Dim codBloqueoClt   As Double    'PRD-6066
   Dim mensajeGrabacion As String    'PRD-6066
   
    'PROD-10967
    Dim MonedaBac        As Integer
    Dim Convencion       As Integer
    Dim Base             As Integer
    Dim PlazoFwd         As Integer
    Dim CodigoTasa       As Long
    Dim TipoSwap         As Integer
    Dim Threshold_LCR    As Double
    Dim Metodologia_LCR  As Integer
    Dim Cliente_LCR      As String
    Dim MsgError_LCR     As String
    Dim Error_LCR        As String
    Dim FechaMadurez As Date
    'PROD-10967

   PreGrabado = False

    
       
    'PROD-10967
      If FRM_SWAP_OP.Swap_Op_Metodologia_LCR <> 1 And _
         FRM_SWAP_OP.Swap_Op_Metodologia_LCR <> 4 Then
      
        'MAP
        If Not Bac_Sql_Execute("BEGIN TRANSACTION") Then
           MsgBox "No se Pudo Asegurar Transaccion para imputar cliente" & vbCrLf & "Comunique este problema al Supervisor", vbCritical, "Grabar Operaciones"
           Exit Function
        End If 'MAP

        'Busca e inserta si no está
        If Inserta_Cliente_Imputacion(miForm.RutCliente, miForm.CodCliente) = False Then
           MsgBox "Cliente está siendo imputado en Derivados. " & vbCrLf & "Favor reintentar en segundos más.", vbCritical, "Grabar Operaciones"
            'MAP
            If Not Bac_Sql_Execute("COMMIT TRANSACTION") Then
                Exit Function
            End If 'MAP
            Exit Function
        End If
        
        'MAP
        If Not Bac_Sql_Execute("COMMIT TRANSACTION") Then
           Exit Function
        End If 'MAP
     End If
    'PROD-10967
    

   If Not Bac_Sql_Execute("BEGIN TRANSACTION") Then
      MsgBox "Error en la grabación" & vbCrLf & "Imposible generar transacciones.", vbExclamation, TITSISTEMA
      Exit Function
   End If
   If miForm.Tag <> "" Then
      Me.A01_NumeroOperacion = Val(miForm.Tag)
      Call Lineas_Anular("PCS", CDbl(Me.A01_NumeroOperacion))
      
        Dim oParametrosLineaAnulaPCS As New clsControlLineaIDD
            '+++CONTROL IDD, jcamposd anula toma de linea
            With oParametrosLineaAnulaPCS
                .Modulo = "PCS"
                .Producto = CDbl(A04_TipoSwap) '--> jcamposd, según flujo mas adelante le asigna 3 por defecto
                .Operacion = CDbl(Me.A01_NumeroOperacion)
                .Documento = CDbl(Me.A01_NumeroOperacion)
                .Correlativo = 0
                .Accion = "R"
            
                .RecuperaDatosLineaIDD
                If .numeroiddAnula <> 0 Then
                    .EjecutaProcesoWsLineaIDD
                End If
                
            End With
            
            Set oParametrosLineaAnulaPCS = Nothing
            On Error GoTo seguirAnulacionPCS 'debe seguir con la transaccion BAC
        '---CONTROL IDD, jcamposd anula toma de linea
      
   Else
      Me.A01_NumeroOperacion = Me.NuevoNumeroSwap
   End If
   
seguirAnulacionPCS:
   
   Me.A04_TipoSwap = EntregaTipoSwap(miForm)
   Me.A99_Estado = "P"
   If miForm.Tag <> "" Then
      Me.A99_Estado = ""
   End If

   Ctrlpt_RutCliente = miForm.RutCliente
   Ctrlpt_CodCliente = miForm.CodCliente


    'PROD-10967
    Metodologia_LCR = FRM_SWAP_OP.Swap_Op_Metodologia_LCR
  
    If Metodologia_LCR <> 1 And Metodologia_LCR <> 4 Then
     

        Dim SwapCarteraREC As Negociacion
        Dim Cliente As String
        
      
        Dim Indicador As Long
        Let Indicador = 0
        For iTipoFlujo = 1 To 2
            Set MiGrillaaux = IIf(iTipoFlujo = 1, miForm.I_Grid, miForm.D_Grid)
            For iNumeroFlujos = 1 To MiGrillaaux.Rows - 1
                'POR HACER: donde esta el tipo de dato en comentario
                ' se debe llamar a una funcion para que obtenga
                ' los valores
                ReDim Preserve SwapCarteraREC.Cartera_Swap(Indicador)
                SwapCarteraREC.Cartera_Swap(Indicador).Rut = miForm.RutCliente
                SwapCarteraREC.Cartera_Swap(Indicador).Codigo = miForm.CodCliente
                SwapCarteraREC.Cartera_Swap(Indicador).Numero_Operacion = Me.A01_NumeroOperacion
                SwapCarteraREC.Cartera_Swap(Indicador).Numero_flujo = iNumeroFlujos
                SwapCarteraREC.Cartera_Swap(Indicador).Tipo_flujo = iTipoFlujo
                SwapCarteraREC.Cartera_Swap(Indicador).Tipo_swap = EntregaTipoSwap(miForm)
                SwapCarteraREC.Cartera_Swap(Indicador).Modalidad_pago = Left(miForm.Modalidad, 1)
                SwapCarteraREC.Cartera_Swap(Indicador).Cartera = 0
                
                MonedaBac = IIf(iTipoFlujo = 1 _
                          , miForm.I_Moneda.ItemData(miForm.I_Moneda.ListIndex) _
                          , miForm.D_Moneda.ItemData(miForm.D_Moneda.ListIndex))
                         
                SwapCarteraREC.Cartera_Swap(Indicador).Moneda = Func_Riesgo_Financiero(MonedaBac) '3   'As Long
                'If ParamMoneda_LCR = True Then
                '    ParamMoneda_LCR = False 'Mapita
                '    Exit Function
                'End If
                SwapCarteraREC.Cartera_Swap(Indicador).Codigo_tasa = IIf(iTipoFlujo = 1, _
                                                        miForm.I_Indicador.ItemData(miForm.I_Indicador.ListIndex), _
                                                        miForm.D_Indicador.ItemData(miForm.D_Indicador.ListIndex))
                                
                Convencion = IIf(iTipoFlujo = 1 _
                           , miForm.I_ConteoDias.ItemData(miForm.I_ConteoDias.ListIndex) _
                           , miForm.D_ConteoDias.ItemData(miForm.D_ConteoDias.ListIndex))
                
                SwapCarteraREC.Cartera_Swap(Indicador).Convencion = Func_TipoConvencio(Convencion) '"P"  ' As String
                
                Base = IIf(iTipoFlujo = 1 _
                        , miForm.I_ConteoDias.ItemData(miForm.I_ConteoDias.ListIndex) _
                        , miForm.D_ConteoDias.ItemData(miForm.D_ConteoDias.ListIndex))
                
                SwapCarteraREC.Cartera_Swap(Indicador).Base = Func_BaseSwap(Base) '360         'As Long
                
                PlazoFwd = IIf(iTipoFlujo = 1 _
                        , miForm.I_Indicador.ItemData(miForm.I_Indicador.ListIndex) _
                        , miForm.D_Indicador.ItemData(miForm.D_Indicador.ListIndex))
                
                
                SwapCarteraREC.Cartera_Swap(Indicador).PlazoFwd = Func_BaseForward(PlazoFwd)    '180 'As Long
                
                
                SwapCarteraREC.Cartera_Swap(Indicador).IndexLag = IIf(iTipoFlujo = 1, miForm.I_DiasReset.Text, miForm.D_DiasReset.Text)
                
                'Mapita
                If iTipoFlujo = 1 Then
                  SwapCarteraREC.Cartera_Swap(Indicador).Fecha_ini = IIf(iNumeroFlujos = 1, miForm.I_FechaEfectiva.Text _
                                                      , Format(MiGrillaaux.TextMatrix(iNumeroFlujos - 1, 1), "dd/mm/yyyy"))
                Else
                  SwapCarteraREC.Cartera_Swap(Indicador).Fecha_ini = IIf(iNumeroFlujos = 1, miForm.D_FechaEfectiva.Text _
                                                      , Format(MiGrillaaux.TextMatrix(iNumeroFlujos - 1, 1), "dd/mm/yyyy"))
                End If
                              
                SwapCarteraREC.Cartera_Swap(Indicador).Fecha_fin = Format(MiGrillaaux.TextMatrix(iNumeroFlujos, 1), "dd/mm/yyyy")
                SwapCarteraREC.Cartera_Swap(Indicador).Fecha_fija = Format(MiGrillaaux.TextMatrix(iNumeroFlujos, 16), "dd/mm/yyyy")
                SwapCarteraREC.Cartera_Swap(Indicador).Fecha_liq = Format(MiGrillaaux.TextMatrix(iNumeroFlujos, 14), "dd/mm/yyyy") ' As Date
                
                CodigoTasa = SwapCarteraREC.Cartera_Swap(Indicador).Codigo_tasa
                TipoSwap = SwapCarteraREC.Cartera_Swap(Indicador).Tipo_swap
                
                SwapCarteraREC.Cartera_Swap(Indicador).Codigo_descuento = Func_CodigoDescuento(MonedaBac, CodigoTasa, TipoSwap, 1)  '0 'As Long
                'If ParamMoneda_LCR = True Then
                '    ParamMoneda_LCR = False 'Mapita
                '    Exit Function
                'End If
                
                SwapCarteraREC.Cartera_Swap(Indicador).Codigo_forward = Func_CodigoDescuento(MonedaBac, CodigoTasa, TipoSwap, 2) '1 'As Long
                'If ParamMoneda_LCR = True Then
                '    ParamMoneda_LCR = False 'Mapita
                '    Exit Function
                'End If
                SwapCarteraREC.Cartera_Swap(Indicador).Tasa_flujo = CDbl(MiGrillaaux.TextMatrix(iNumeroFlujos, 23)) / 100#
                SwapCarteraREC.Cartera_Swap(Indicador).Spread = CDbl(MiGrillaaux.TextMatrix(iNumeroFlujos, 24)) / 100#
                SwapCarteraREC.Cartera_Swap(Indicador).Saldo = CDbl(MiGrillaaux.TextMatrix(iNumeroFlujos, 8)) + CDbl(MiGrillaaux.TextMatrix(iNumeroFlujos, 2))
                SwapCarteraREC.Cartera_Swap(Indicador).Amortizacion = CDbl(MiGrillaaux.TextMatrix(iNumeroFlujos, 2)) * IIf(MiGrillaaux.TextMatrix(iNumeroFlujos, 19) = "No", 0, 1)
                SwapCarteraREC.Cartera_Swap(Indicador).Flujo_adicional = CDbl(MiGrillaaux.TextMatrix(iNumeroFlujos, 21))
                SwapCarteraREC.Cartera_Swap(Indicador).Valor_Mercado_BAC = 0
                SwapCarteraREC.Cartera_Swap(Indicador).Moneda_Bac = MonedaBac
                FechaMadurez = IIf(iTipoFlujo = 1, miForm.I_Madurez.Text, miForm.D_Madurez.Text)
                
                If SwapCarteraREC.Cartera_Swap(Indicador).Tipo_swap <> 2 Then
                SwapCarteraREC.Cartera_Swap(Indicador).Plazo = DateDiff("D", gsBAC_Fecp, FechaMadurez)
                Else
                    SwapCarteraREC.Cartera_Swap(Indicador).Plazo = DateDiff("D", gsBAC_Fecp, SwapCarteraREC.Cartera_Swap(Indicador).Fecha_fin)
                End If
                
                'Datos calculados
                SwapCarteraREC.Cartera_Swap(Indicador).Plazo_ini = 0
                SwapCarteraREC.Cartera_Swap(Indicador).Plazo_fin = 0
                SwapCarteraREC.Cartera_Swap(Indicador).Plazo_liq = 0
                SwapCarteraREC.Cartera_Swap(Indicador).Dias = 0
                SwapCarteraREC.Cartera_Swap(Indicador).Valor_Mercado = 0
                'Valor_Simulacion() As Double
                
                If SwapCarteraREC.Cartera_Swap(Indicador).Codigo_tasa = 13 Then
                    SwapCarteraREC.Cartera_Swap(Indicador).PlazoFwd = CuentaDias(SwapCarteraREC.Cartera_Swap(Indicador).Fecha_ini _
                    , SwapCarteraREC.Cartera_Swap(Indicador).Fecha_fin _
                    , SwapCarteraREC.Cartera_Swap(Indicador).Convencion _
                    , SwapCarteraREC.Cartera_Swap(Indicador).Base)
                End If
                Let Indicador = Indicador + 1
            Next
        Next
      
        Threshold_LCR = FRM_SWAP_OP.Swap_Op_Threshold_LCR
        Cliente_LCR = FRM_SWAP_OP.Swap_Op_Cliente_LCR
        
        Dim ResultadoREC As Double
        Let ResultadoREC = ProcesoCalculoREC(miForm.RutCliente _
                                            , miForm.CodCliente _
                                            , Cliente_LCR _
                                            , SwapCarteraREC _
                                            , "Swap" _
                                            , Threshold_LCR _
                                            , Metodologia_LCR _
                                            , MsgError_LCR, 0)
                                                 
        Error_LCR = MsgError_LCR
        
        'PROD-10967
      
    End If
  
   For iTipoFlujo = 1 To 2
      Set MiGrilla = IIf(iTipoFlujo = 1, miForm.I_Grid, miForm.D_Grid)
      For iNumeroFlujos = 1 To MiGrilla.Rows - 1
         Me.A02_NumeroFlujo = iNumeroFlujos
         Me.A03_TipoFlujo = iTipoFlujo
         Me.A05_CarteraInversiones = miForm.CarteraFinanciera
         Me.A06_TipoOperacion = "C" 'Left(MiForm.Modalidad, 1)
         Me.A07_RutCliente = miForm.RutCliente
         Me.A08_CodCliente = miForm.CodCliente
         Me.A09_Moneda = IIf(iTipoFlujo = 1, miForm.I_Moneda.ItemData(miForm.I_Moneda.ListIndex), miForm.D_Moneda.ItemData(miForm.D_Moneda.ListIndex))
         Me.A10_Nocionales = CDbl(IIf(iTipoFlujo = 1, miForm.I_Nocionales.Text, miForm.D_Nocionales.Text))
         Me.A11_Amortizacion = CDbl(MiGrilla.TextMatrix(iNumeroFlujos, 2))
         Me.A12_Saldo = CDbl(MiGrilla.TextMatrix(iNumeroFlujos, 8))
         Me.A13_Interes = CDbl(MiGrilla.TextMatrix(iNumeroFlujos, 4))
         Me.A14_Spread = CDbl(MiGrilla.TextMatrix(iNumeroFlujos, 24)) ''CDbl(IIf(iTipoFlujo = 1, MiForm.I_Spread.Text, MiForm.D_Spread.Text))
         Me.A15_Indicador = IIf(iTipoFlujo = 1, miForm.I_Indicador.ItemData(miForm.I_Indicador.ListIndex), miForm.D_Indicador.ItemData(miForm.D_Indicador.ListIndex))
         Me.A16_UltimoIndice = CDbl(MiGrilla.TextMatrix(iNumeroFlujos, 23)) ''CDbl(IIf(iTipoFlujo = 1, MiForm.I_UltimoIndice.Text, MiForm.D_UltimoIndice.Text))
         Me.A17_ConteoDias = IIf(iTipoFlujo = 1, miForm.I_ConteoDias.ItemData(miForm.I_ConteoDias.ListIndex), miForm.D_ConteoDias.ItemData(miForm.D_ConteoDias.ListIndex))
         Me.A18_FrecuenciaPago = Right(IIf(iTipoFlujo = 1, miForm.I_FrecuenciaPago, miForm.D_FrecuenciaPago), 10)
         Me.A19_FrecuenciaCapital = Right(IIf(iTipoFlujo = 1, miForm.I_FrecuenciaCapital, miForm.D_FrecuenciaCapital), 10)
         Me.A20_MonedaPago = IIf(iTipoFlujo = 1, miForm.I_MonPago.ItemData(miForm.I_MonPago.ListIndex), miForm.D_MonPago.ItemData(miForm.D_MonPago.ListIndex))
         Me.A21_MedioPago = IIf(iTipoFlujo = 1, miForm.I_MedioPago.ItemData(miForm.I_MedioPago.ListIndex), miForm.D_MedioPago.ItemData(miForm.D_MedioPago.ListIndex))
         Me.A22_MontoPago = CDbl(MiGrilla.TextMatrix(iNumeroFlujos, 10))
         Me.A23_MontoPagoCLP = CDbl(MiGrilla.TextMatrix(iNumeroFlujos, 12))
         Me.A24_MontoPagoUSD = CDbl(MiGrilla.TextMatrix(iNumeroFlujos, 11))
         Me.A25_ModalidadPago = Left(miForm.Modalidad, 1)
         Me.A26_FechaCierre = gsBAC_Fecp
         Me.A27_FechaEfectiva = IIf(iTipoFlujo = 1, miForm.I_FechaEfectiva.Text, miForm.D_FechaEfectiva.Text)
         Me.A28_FechaPrimerPago = IIf(iTipoFlujo = 1, miForm.I_PrimerPago.Text, miForm.D_PrimerPago.Text)
         Me.A29_FechaPenultimoPago = IIf(iTipoFlujo = 1, miForm.I_PenultimoPago.Text, miForm.D_PenultimoPago.Text)
         Me.A30_FechaMadurez = IIf(iTipoFlujo = 1, miForm.I_Madurez.Text, miForm.D_Madurez.Text)
         
         If iNumeroFlujos = 1 Then
            Me.A31_FechaInicioFlujo = Me.A27_FechaEfectiva
         Else
            Me.A31_FechaInicioFlujo = Format(MiGrilla.TextMatrix(iNumeroFlujos - 1, 1), "dd/mm/yyyy")
         End If
         
         Me.A32_FechaTerminoFlujo = Format(MiGrilla.TextMatrix(iNumeroFlujos, 1), "dd/mm/yyyy")
         Me.A33_Usuario = gsBAC_User
         Me.A34_Observaciones = miForm.Observaciones
         Me.A37_AreaResponsable = miForm.AreaResponsable
         Me.A38_CarteraNormativa = miForm.CarteraNormativa
         Me.A39_SubCarteraNormativa = miForm.SubCarteraNormativa
         Me.A40_LibroNegociacion = miForm.LibroNegociacion
         Me.A41_DiasReset = IIf(iTipoFlujo = 1, miForm.I_DiasReset.Text, miForm.D_DiasReset.Text)
         Me.A42_FechaFijaTasa = Format(MiGrilla.TextMatrix(iNumeroFlujos, 16), "dd/mm/yyyy")
         Me.A43_FeriadoFlujoChile = IIf(iTipoFlujo = 1, miForm.I_FERIADOCHK(0).Value, miForm.D_FERIADOCHK(0).Value)
         Me.A44_FeriadoFlujoEEUU = IIf(iTipoFlujo = 1, miForm.I_FERIADOCHK(1).Value, miForm.D_FERIADOCHK(1).Value)
         Me.A45_FeriadoFlujoEnglan = IIf(iTipoFlujo = 1, miForm.I_FERIADOCHK(2).Value, miForm.D_FERIADOCHK(2).Value)
         Me.A46_FeriadoLiquiChile = IIf(iTipoFlujo = 1, miForm.I_FERIADOCHK(3).Value, miForm.D_FERIADOCHK(3).Value)
         Me.A47_FeriadoLiquiEEUU = IIf(iTipoFlujo = 1, miForm.I_FERIADOCHK(4).Value, miForm.D_FERIADOCHK(4).Value)
         Me.A48_FeriadoLiquiEnglan = IIf(iTipoFlujo = 1, miForm.I_FERIADOCHK(5).Value, miForm.D_FERIADOCHK(5).Value)
         Me.A49_Convencion = IIf(iTipoFlujo = 1, miForm.I_Convencion.Text, miForm.D_Convencion.Text)
         Me.A50_Note = IIf(iTipoFlujo = 1, miForm.I_Note.Text, miForm.D_Note.Text)
         '//CER 05/05/2008   Variables - Req. Pantalla Ingreso Op. Swap
         Me.A51_IntercambioPrincipal = IIf(MiGrilla.TextMatrix(iNumeroFlujos, 19) = "No", 0, 1) ''MiForm.Intercambio(0).Value
         'PRD 12712 ET
         'Me.A51_IntercambioPrincipal = IIf(giMarca_Inter_Nocionales, 1, 0) 'IIf(MiGrilla.TextMatrix(iNumeroFlujos, 19) = "No", 0, 1) ''MiForm.Intercambio(0).Value
         'PRD 12712 ET
         Me.A52_Tikker = miForm.TIKKER.Text
         Me.A53_FechaLiquidacion = Format(MiGrilla.TextMatrix(iNumeroFlujos, 14), "dd/mm/yyyy")
         Me.A53_FechaReset = Format(MiGrilla.TextMatrix(iNumeroFlujos, 16), "dd/mm/yyyy")
         '//CER 05/05/2008   Variables - Req. Pantalla Ingreso Op. Swap
         Me.A55_FxRate = CDbl(MiGrilla.TextMatrix(iNumeroFlujos, 22))
         Me.A56_PrcAmortiza = CDbl(MiGrilla.TextMatrix(iNumeroFlujos, 18))
         Me.A57_FechaValuta = Format(MiGrilla.TextMatrix(iNumeroFlujos, 20), "dd/mm/yyyy")
         Me.A58_FlujoAdicional = CDbl(MiGrilla.TextMatrix(iNumeroFlujos, 21))
         
         Me.A59_Tasa_Transfer = IIf(iTipoFlujo = 1, miForm.I_Indice_Tran.Text, miForm.D_Indice_Tran.Text)
         Me.A60_Spread_Transfer = IIf(iTipoFlujo = 1, miForm.I_Spread_Tran.Text, miForm.D_Spread_Tran.Text)
         'Me.A61_Res_Mesa_Dist_CLP = miForm.ssp_Res_Mesa_Dist.Caption
         'Me.A62_Res_Mesa_Dist_USD = miForm.ssp_Res_Mesa_Dist_USD.Caption
         Me.A61_Res_Mesa_Dist_CLP = miForm.txt_Res_Mesa_Dist.Text
         Me.A62_Res_Mesa_Dist_USD = miForm.txt_Res_Mesa_Dist_USD.Text
         
         Me.A65_Operador = miForm.lblOperador.Caption   'JBH, 22-12-2009
         
        '***************************PRD21657


        If Me.A03_TipoFlujo = 1 Then
            Me.A100_ReferenciaUSDCLP = A100_ReferenciaUSDCLP
            Me.A101_ReferenciaMEXUSD = A101_ReferenciaMEXUSD
            Me.A100_dias = A100_dias
            Me.A101_dias = A101_dias
        End If
        If Me.A03_TipoFlujo = 2 Then
            Me.A104_ReferenciaUSDCLP = A104_ReferenciaUSDCLP
            Me.A105_ReferenciaMEXUSD = A105_ReferenciaMEXUSD
            Me.A104_dias = A104_dias
            Me.A105_dias = A105_dias
        End If
       '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
     
        Me.A102_FechaUSDCLP = Format(MiGrilla.TextMatrix(iNumeroFlujos, 20), "dd/mm/yyyy")
        Me.A103_FechaMEXUSD = Format(MiGrilla.TextMatrix(iNumeroFlujos, 20), "dd/mm/yyyy")
        'Me.plaza = Habil
        '***************************PRD21657
        
         '-- MAP 20080425 Solo se graba si es mayor
         '-- o igual a la fecha de proceso
         '-- If DateDiff("D", gsBAC_Fecp, Me.A32_FechaTerminoFlujo) >= 0 Then
         '-- CER 20081014 Se cambia Me.A32_FechaTerminoFlujo por Me.A53_FechaLiquidacion,
         '--             tema pagos multiples.
            If DateDiff("D", gsBAC_Fecp, Me.A53_FechaLiquidacion) >= 0 Then
            If Grabación = False Then
                If Not Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
                    MsgBox "Error en la grabación" & vbCrLf & "Imposible generar transacciones.", vbExclamation, TITSISTEMA
                    Exit Function
                End If
                MsgBox "Error en la Grabación" & vbCrLf & vbCrLf & err.Description, vbCritical, TITSISTEMA
                Exit Function
            End If
         End If  '<-- MAP
      Next iNumeroFlujos
   Next iTipoFlujo
   
   'Valorización Swap x Curva '0'

  '''FrmAvisoValorizacion.Show
  FrmAvisoValorizacion.ListProblemasValoriza.Clear
  Msg = ""

   Envia = Array()
   AddParam Envia, gsBAC_Fecp
   AddParam Envia, CDbl(A01_NumeroOperacion)
   
   If Not Bac_Sql_Execute("SP_CALCULO_ACTPAS_C08", Envia) Then
      If Not Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
         MsgBox "Error en la Valorización" & vbCrLf & "Imposible generar transacciones.", vbExclamation, TITSISTEMA
         Exit Function
      End If
      MsgBox "Problemas al Valorizar Operación ", vbExclamation, TITSISTEMA
   Else
    Do While Bac_SQL_Fetch(Datos())
     If Datos(1) <> 1 Then
          Msg = "Problemas en Valorización con Operación # " & Datos(2)
          Msg = Msg & Space(1) & Datos(5)
     End If

      If Len(Msg) > 0 Then
          FrmAvisoValorizacion.ListProblemasValoriza.AddItem Msg
      End If

    Loop
    
        If Len(Trim(Msg)) > 0 Then
              FrmAvisoValorizacion.Show
              Call GRABA_LOG_AUDITORIA("Opc_20302", "01", "Se graba Operacion con tasa sin parametrizar", "", "", "Número Operación:" & Format(A01_NumeroOperacion))
        Else
              FRM_SWAP_OP.I_Moneda.SetFocus
              FrmAvisoValorizacion.Hide
        End If
    End If

    

'Valorización Swap x Curva '0'

Let Cotizacion = FRM_SWAP_OP.Option1(0) '-- MAP 20080411

   '-- MAP 20080411
   '-- Grabar Estado = "C"otizacion o " " que es Cartera
   '-- Llamar Sp que calcula la imputacion LCR y grabar junto con estado
   TipoGrab = IIf(Cotizacion, "Cotización", "Cartera")
   
If Not Cotizacion Then   '-- MAP 20080411 Grabar Cartera, sigue ciclo normal
      If gsBac_Lineas = "S" Then
         Mensaje = ""
         
            'PROD-10967
            If Not Lineas_ChequearGrabar("PCS", CDbl(A04_TipoSwap), A01_NumeroOperacion _
                                     , 0, 0, Me.A07_RutCliente, Me.A08_CodCliente _
                                     , CDbl(A10_Nocionales), 0#, A30_FechaMadurez, 0 _
                                     , 0, CDate(gsBAC_Fecp), 0, "N", Val(A09_Moneda) _
                                     , "C", 0, "N", 0, CDate(gsBAC_Fecp), 0 _
                                     , Val(A21_MedioPago), ResultadoREC, Metodologia_LCR) Then
            Exit Function
         End If
               
         MercadoLc = "N"
         If nPaisOrigen = 6 Then
            MercadoLc = "S"
         End If
      
      
'/************/
       Envia = Array()
      AddParam Envia, CDbl(Me.A07_RutCliente)
      AddParam Envia, CDbl(Me.A08_CodCliente)
      
      If Not Bac_Sql_Execute("BACLINEAS..SP_BUSCA_RELACION", Envia) Then
         MsgBox "Problemas en la Busqueda del tipo de Relacion.", vbCritical, TITSISTEMA
      End If

      If Bac_SQL_Fetch(Datos()) Then
         nTipRela = Datos(1)
      End If
 '/************/
   If nTipRela <> 12 Then
         Mensaje_Con = Lineas_ConsultaOperacion("PCS", CDbl(A04_TipoSwap), A01_NumeroOperacion, " ", "N", MercadoLc)
         
         'Agregar el mensaje del Control de Precios y Tasas ssi modo no silencioso
         If Ctrlpt_ModoOperacion <> "S" Then
         If Trim(Ctrlpt_Mensaje) <> "" And Trim(Ctrlpt_Mensaje) <> "OK" Then '10967 Problemas de convivencia con Control de Precios
            Mensaje_Con = Mensaje_Con & vbCrLf & Ctrlpt_Mensaje
         End If
         End If
         
         If Trim(Mensaje_Con) <> "" And Replace(Mensaje_Con, vbCrLf, "") <> "OK" Then
            'If MsgBox("ATENCION" & vbCrLf & "LA OPERACION GENERARA LOS SIGUIENTES ERRORES" & Mensaje_Con & vbCrLf & vbCrLf & "¿Desea Grabar la Operación ?", vbYesNo + vbExclamation, TITSISTEMA) = vbNo Then
             If Not UsuarioConfirma(0, 0, _
                                       "Confirmar Grabación", _
                                       "ATENCION" & vbCrLf & "LA OPERACION GENERARA LOS SIGUIENTES ERRORES" & Mensaje_Con & vbCrLf & vbCrLf & "¿Desea Grabar la Operación ?", _
                                        0.5) Then
            
               'Call Lineas_BorraConsultaOperacion("PCS", A01_NumeroOperacion) 'PROD-10967
               Screen.MousePointer = vbDefault
                      'PROD-10967
                      Call BacRollBackTransaction
                      If Metodologia_LCR <> 1 And Metodologia_LCR <> 4 Then
                         'Se incluye esto dentro de la transaccion
                         'a proposito ya que el cliente se bloquea antes
                         'de la TRN de grabación, por tanto se sabrá de
                         'caidas por llamar para sacar al cliente de
                         'imputación.
                         Call Elimina_Cliente_Imputacion(miForm.RutCliente, miForm.CodCliente)
                      End If
                      'PROD-10967
               Exit Function
            End If
         End If
         
         'Si Acepta y Tiene Errores Sigue Normal
         Mensaje = Mensaje & Lineas_Chequear("PCS", CDbl(A04_TipoSwap), A01_NumeroOperacion, " ", "N", MercadoLc)
         If Mensaje <> "" Then
            MsgBox "Error al Chequear Lineas : " + Chr(10) + Chr(13) + Chr(10) + Chr(13) + Mensaje, vbCritical, Msj
         End If
      End If '--> gsBac_Lineas = "S"
End If
'*******************************************Imputacion LCR*******************************************
  'prd19111 ini
   
   Dim sw_Valida_Comder As String
   
    

 sw_Valida_Comder = Limites_Valida_Comder()
 
  
   
   If sw_Valida_Comder = "S" Then
     If FRM_SWAP_OP.Lblcheck = 1 Then
       
       If Not RelacionMarcaComder("PCS", CDbl(A01_NumeroOperacion), Me.A08_CodCliente, Me.A07_RutCliente) Then
          If Not Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
             MsgBox "Error en la grabación" & vbCrLf & "Imposible generar transacciones.", vbExclamation, TITSISTEMA
             Exit Function
          End If
       End If
   End If
End If

   If Not Lineas_GrbOperacion("PCS", CDbl(A04_TipoSwap), CDbl(A01_NumeroOperacion), CDbl(A01_NumeroOperacion), " ", "N", "L") Then
      If Not Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
         MsgBox "Error en la grabación" & vbCrLf & "Imposible generar transacciones.", vbExclamation, TITSISTEMA
         Exit Function
      End If
    Else
        If MarcaAplicaLinea = 1 Then '--jcamposd solo aplica si la marca de líneas es activa
            '+++CONTROL IDD, jcamposd llamada a nuevo control IDD para las líneas
            Dim oParametrosLinea As New clsControlLineaIDD
    
                With oParametrosLinea
                    .Modulo = "PCS"
                    .Producto = CDbl(A04_TipoSwap)
                    .Operacion = CDbl(A01_NumeroOperacion)
                    .Documento = CDbl(A01_NumeroOperacion)
                    .Correlativo = 0
                    .Accion = "Y"
    
                    .RecuperaDatosLineaIDD
                    
                    .MontoArticulo84 = gblSW_MontoReserva 'monto asignado art84 según funcion
                    .EjecutaProcesoWsLineaIDD
                End With
                Set oParametrosLinea = Nothing
                On Error GoTo seguirprocesoGbrPre 'si se cae debe seguir con la transacción en BAC
            '---CONTROL IDD, jcamposd llamada a nuevo control IDD para las líneas

        End If
   End If
seguirprocesoGbrPre:

   'prd19111 fin

   'Control de Precios y Tasas
    resControlPT = ControlPreciosTasas(Ctrlpt_codProducto, Ctrlpt_Plazo, Ctrlpt_UltimoVAC, False)
    
    If Ctrlpt_AplicarControl Then
    If Ctrlpt_ModoOperacion = "S" Then
        'Modo silencioso
        Ctrlpt_NumOp = A01_NumeroOperacion
        Ctrlpt_NumDocu = ""
        Ctrlpt_TipoOp = "C"
        Ctrlpt_Correlativo = 1
        Mensaje_CPT = ""
        Call GrabaModoSilencioso
    Else
            'grabar el instrumento ssi EnviarCF = "S"
            If EnviarCF = "S" Then
        Ctrlpt_NumOp = A01_NumeroOperacion
        Ctrlpt_NumDocu = ""
        Ctrlpt_TipoOp = "C"
        Ctrlpt_Correlativo = 1
            Mensaje_CPT = Ctrlpt_Mensaje
        Call GrabaLineaPendPrecios
                Call GrabaModoSilencioso    '---> Incidencia 1
   End If
    End If
    End If

   '********** Linea -- Mkilo
   Mensaje_Lin = ""
   Mensaje_Lim = ""
   If gsBac_Lineas = "S" Then
      Mensaje_Lin = Lineas_Error("PCS", CDbl(A01_NumeroOperacion))
      Mensaje_Lim = Limites_Error("PCS", CDbl(A01_NumeroOperacion))
   End If

   Envia = Array()
   AddParam Envia, CDbl(A01_NumeroOperacion)
   AddParam Envia, Trim(Mensaje_Lin)
   AddParam Envia, Trim(Mensaje_Lim)
   AddParam Envia, Trim(Error_LCR) 'PROD-10967
   If Not Bac_Sql_Execute("SP_GRABAOBSERVACIONLINEAS", Envia) Then
      If Not Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
         MsgBox "Error en la grabación" & vbCrLf & "Imposible generar transacciones.", vbExclamation, TITSISTEMA
         Exit Function
      End If
      MsgBox "Problemas al Grabar Observacion Lineas", vbExclamation, TITSISTEMA
   End If
End If '-- MAP 20080411 Grabar Cartera, sigue ciclo normal

   '-- MAP 20080411 Grabar Estado = "C"otizacion e imputacin de LCR
    Envia = Array()
    AddParam Envia, CDbl(A01_NumeroOperacion)
    AddParam Envia, IIf(Cotizacion, "C", " ")
    AddParam Envia, CDbl(ResultadoREC) 'PROD-10967
    AddParam Envia, CDbl(Metodologia_LCR) 'PROD-10967
    AddParam Envia, 0
    If Not Bac_Sql_Execute("SP_GUARDARCOMO", Envia) Then
       If Not Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
          MsgBox "Error en Guardar como " & TipoGrab & vbCrLf & "Imposible generar transacciones.", vbExclamation, TITSISTEMA
      Exit Function
   End If
       MsgBox "Problemas al Guardar como " & TipoGrab, vbExclamation, TITSISTEMA
    End If
    'Reposicionando código

   
If Not Cotizacion Then  '-- MAP 20080411 Grabar Cartera, sigue ciclo normal
   If A38_CarteraNormativa = "C" Then
      If MsgBox("Proceso Coberturas." & vbCrLf & vbCrLf & "¿ Desea Generar Cobertura para este Derivado. ?", vbQuestion + vbYesNo, TITSISTEMA) = vbYes Then
         FRM_MNT_COBERTURA.Derivado = A01_NumeroOperacion
         FRM_MNT_COBERTURA.Correlativo = 1
         FRM_MNT_COBERTURA.Modulo = "PCS"
         FRM_MNT_COBERTURA.Show 1
      End If
   End If
   End If
  
    'PROD-10967
    If Metodologia_LCR <> 1 And Metodologia_LCR <> 4 Then
       'Se incluye esto dentro de la transaccion
       'a proposito ya que el cliente se bloquea antes
       'de la TRN de grabación, por tanto se sabrá de
       'caidas por llamar para sacar al cliente de
       'imputación.
       Call Elimina_Cliente_Imputacion(miForm.RutCliente, miForm.CodCliente)
    End If
    'PROD-10967
   
   
   'Cambiado al final de la función
   If Not Bac_Sql_Execute("COMMIT TRANSACTION") Then
      Screen.MousePointer = vbDefault
      MsgBox "Error en la grabación" & vbCrLf & "Imposible generar transacciones.", vbExclamation, TITSISTEMA
         Exit Function
      End If

   Screen.MousePointer = vbDefault

   'PRD-4858, 15-02-2010 Aquí llamar al form del Threshold ssi Thr_AplicaThreshold = True
   If Thr_Cotizacion = False Then
      If Thr_AplicaThreshold = True Then
         Thr_GrabaThreshold = False
         Thr_NumeroOperacion = A01_NumeroOperacion
         BacThreshold.Caption = "Threshold en Operación Swap"
         BacThreshold.Show 1

         If Thr_GrabaThreshold = False Then
            PreGrabado = False
            Exit Function
         End If
         Call ActualizaThresholdMovtos("S")
         Call ActualizaAplicThreshold
      Else
         Call ActualizaThresholdMovtos("N")
      End If
   End If
      
    'Aplicación del Control de Bloqueos - PRD-6066
    codBloqueoClt = -1
    motBloqueoClt = ""
    If ClienteBloqueado("PCS", Me.A07_RutCliente, Me.A08_CodCliente, codBloqueoClt, motBloqueoClt) Then
        Call GrabaBloqueoCliente("PCS", Me.A04_TipoSwap, CDbl(A01_NumeroOperacion), Me.A06_TipoOperacion, codBloqueoClt, motBloqueoClt)
    End If
    'Fin PRD-6066
      
      'PRD-3860 (modo silencioso)
   If Ctrlpt_ModoOperacion = "S" Then
        Mensaje_CPT = ""
   ElseIf Trim(Mensaje_CPT) <> "" Then
        Mensaje_CPT = vbCrLf & vbCrLf & Mensaje_CPT
   End If

   'PRD-6066 Control de Bloqueos
   
   'Revisar primero si el contenido de Mensaje_CPT ya no está dentro de Mensaje_Lin
    If Not Contiene(Mensaje_Lin, Mensaje_CPT) Then
   mensajeGrabacion = Mensaje_Lin & Mensaje_Lim & Mensaje_CPT
    Else
        mensajeGrabacion = Mensaje_Lin & Mensaje_Lim
    End If
    
    '   If Trim(Mensaje_Lin) = "" Then
    '        'El mensaje del bloqueo no está incluido en Mensaje_Lin
    '        If Trim(motBloqueoClt) <> "" Then
    '            mensajeGrabacion = mensajeGrabacion & vbCrLf & motBloqueoClt
    '        End If
    '   End If
    
        If Trim(motBloqueoClt) <> "" Then
        mensajeGrabacion = mensajeGrabacion & vbCrLf & motBloqueoClt
   End If

'Control de Garantías PRD-5521
'   If ControlGarantias(Me.A07_RutCliente, Me.A08_CodCliente, Me.A01_NumeroOperacion) Then
'        Gar_FvctoOper = Me.A32_FechaTerminoFlujo
'        FRM_ASOCIA_GARANTIAS.Show vbModal
'   End If
   'Fin Control de Garantías PRD-5521
      
   'MsgBox "Grabación Ok." & vbCrLf & vbCrLf & "Operación N° : " & Format(A01_NumeroOperacion, TipoFormato("CLP")) & " Se ha grabado en forma correcta." & Mensaje_CPT, vbInformation, TITSISTEMA
   MsgBox "Grabación Ok." & vbCrLf & vbCrLf & "Operación N° : " & Format(A01_NumeroOperacion, TipoFormato("CLP")) & " Se ha grabado en forma correcta." & mensajeGrabacion, vbInformation, TITSISTEMA
   PreGrabado = True
   
   
End Function
Private Function Contiene(ByVal Todo As String, ByVal Parte As String) As Boolean
    'Si Parte está contenida en Todo, retorna True, en caso contrario, retorna False
    Dim lRet As Boolean
    lRet = False
    If InStr(Todo, Parte) Then
        lRet = True
    End If
    Contiene = lRet
End Function
Public Function ActualizaThresholdMovtos(ByVal Respuesta As String) As Boolean
   Dim Datos()

   ActualizaThresholdMovtos = False

   Envia = Array()
   AddParam Envia, "PCS"
   AddParam Envia, Thr_CodProducto
   AddParam Envia, Thr_NumeroOperacion
   AddParam Envia, IIf(Thr_OptAplicaThreshold = True, "S", "N") '--> respuesta
   If Not Bac_Sql_Execute("BACPARAMSUDA.dbo.SP_ACTUALIZA_THRESHOLD_MOVIMIENTOS", Envia) Then
      ActualizaThresholdMovtos = False
      Exit Function
   End If
   If Bac_SQL_Fetch(Datos()) Then
      If Datos(1) = 0 Then
         ActualizaThresholdMovtos = True
         Exit Function
      End If
      ActualizaThresholdMovtos = False
   End If
End Function
Public Function ActualizaAplicThreshold() As Boolean
   Dim Datos()
   
   ActualizaAplicThreshold = False

   Envia = Array()
   AddParam Envia, "PCS"
   AddParam Envia, CStr(Thr_CodProducto)
   AddParam Envia, Thr_NumeroOperacion
   AddParam Envia, Thr_ValorAplicado
   AddParam Envia, Thr_MensajeLineas
   If Not Bac_Sql_Execute("BACPARAMSUDA.dbo.SP_ACTUALIZA_THRESHOLD_OPERACION", Envia) Then
      ActualizaAplicThreshold = False
      Exit Function
   End If
   If Bac_SQL_Fetch(Datos()) Then
      If Datos(1) = 0 Then
         ActualizaAplicThreshold = True
         Exit Function
      End If
      ActualizaAplicThreshold = False
   End If
End Function

Public Function EntregaTipoSwap(miForm As Form) As Integer
   If miForm.I_Moneda.ListIndex = -1 Or miForm.D_Moneda.ListIndex = -1 Then
      MsgBox "Debe seleccionar ambas monedas antes de prosegir.", vbInformation, TITSISTEMA
      EntregaTipoSwap = -1
   End If
   If miForm.I_Moneda.ItemData(miForm.I_Moneda.ListIndex) <> miForm.D_Moneda.ItemData(miForm.D_Moneda.ListIndex) Then
      EntregaTipoSwap = 2    '--> Swap de Monedas      CCS
   Else
      If miForm.I_Indicador.ItemData(miForm.I_Indicador.ListIndex) = 13 Or miForm.D_Indicador.ItemData(miForm.D_Indicador.ListIndex) = 13 Then
         EntregaTipoSwap = 4 '--> Swap Promedio Camara ICP
      Else
         EntregaTipoSwap = 1 '--> Swap de Tasas        IRF
      End If
   End If
End Function

Public Function FormIsLoaded(ByVal nForm As String) As Boolean
    Dim iContador As Integer
    For iContador = 0 To Forms.Count - 1
        If UCase(Forms(iContador).Name) = UCase(nForm) Then
            FormIsLoaded = True
            Exit Function
        End If
    Next iContador
    FormIsLoaded = False
End Function

'PROD-10967
'sacar al cliente de los clientes
'que están imputando para que
'pueda ser utilizado por otras
'operaciones
Public Function Elimina_Cliente_Imputacion(nRut As Double, nCodigo As Integer)

   Dim Datos()

   Elimina_Cliente_Imputacion = False

   Envia = Array()
   AddParam Envia, CDbl(nRut)
   AddParam Envia, CDbl(nCodigo)

   If Not Bac_Sql_Execute(gsBac_LineasDb & "..SP_ELIMINA_CLIENTE_IMPUTACION", Envia) Then
   
       MsgBox "Problemas al buscar cliente.", vbCritical, "MENSAJE"
   Else
       If Bac_SQL_Fetch(Datos()) Then
            If Datos(1) = "NO EXISTE" Then
                Exit Function
            End If
       End If
   End If

   Elimina_Cliente_Imputacion = True


End Function

'PROD-10967
'Coloca al cliente en los clientes
'que están imputando para que NO
'pueda ser utilizado por otras
'operaciones
Public Function Inserta_Cliente_Imputacion(nRut As Double, nCodigo As Integer)

   Dim Datos()

   Inserta_Cliente_Imputacion = False
  
   Envia = Array()
   AddParam Envia, CDbl(nRut)
   AddParam Envia, CDbl(nCodigo)

   If Not Bac_Sql_Execute(gsBac_LineasDb & "..SP_INSERTA_CLIENTE_IMPUTACION", Envia) Then
      
      MsgBox "Problemas al Insertar cliente.", vbCritical, "MENSAJE"
      Exit Function
   Else
      
      If Bac_SQL_Fetch(Datos()) Then
            If Datos(1) = "NO" Then
                Exit Function
            Else
               If Datos(1) = "FFMM" Then
                     MsgBox ("Error: Cliente no puede Imputar por " + Datos(1))
                     Exit Function
               End If
            End If
      End If


   End If
    
   Inserta_Cliente_Imputacion = True

End Function

' 17/12/2008 - Se comenta y se cambia a Función PreGrabado por no administración de caida en imputación de lineas
'            - Se comenta y se cambia a Función PreGrabado por no adminstrar respuesta negativa de usuario

''''Private Sub Imputacion_LCR()
''''   Dim Mensaje     As String
''''   Dim cCheque     As String
''''   Dim nRutCheque  As Double
''''   Dim Mensaje_Con As String
''''   Dim CodMonOp    As Double
''''   Dim dFechaVcto  As Date
''''   Dim MercadoLc   As String
''''   Dim Monto_Usd   As Double
''''
''''      If gsBac_Lineas = "S" Then
''''         Monto_Usd = CDbl(A10_Nocionales)
''''         CodMonOp = A09_Moneda
''''         dFechaVcto = A30_FechaMadurez
''''         cCheque = "N"
''''         nRutCheque = 0
''''         Mensaje = ""
''''
''''         If Not Lineas_ChequearGrabar("PCS", CDbl(A04_TipoSwap), A01_NumeroOperacion, 0, 0, Me.A07_RutCliente, Me.A08_CodCliente, Monto_Usd, 0#, dFechaVcto, 0, 0, CDate(gsBAC_Fecp), 0, "N", Val(CodMonOp), "C", 0, cCheque, nRutCheque, CDate(gsBAC_Fecp), 0, Val(A21_MedioPago)) Then
''''            Exit Sub
''''         End If
''''
''''         MercadoLc = "N"
''''         If nPaisOrigen = 6 Then
''''            MercadoLc = "S"
''''         End If
''''
''''         Mensaje_Con = Lineas_ConsultaOperacion("PCS", CDbl(A04_TipoSwap), A01_NumeroOperacion, " ", cCheque, MercadoLc)
''''         If Trim(Mensaje_Con) <> "" Then
''''            If MsgBox("ATENCION" & vbCrLf & "LA OPERACION GENERARA LOS SIGUIENTES ERRORES" & Mensaje_Con & vbCrLf & vbCrLf & "¿Desea Grabar la Operación ?", vbYesNo + vbExclamation, TITSISTEMA) = vbNo Then
''''               Call Lineas_BorraConsultaOperacion("PCS", A01_NumeroOperacion)
''''               Exit Sub
''''            End If
''''         End If
''''
''''         'Si Acepta y Tiene Errores Sigue Normal
''''         Mensaje = Mensaje & Lineas_Chequear("PCS", CDbl(A04_TipoSwap), A01_NumeroOperacion, " ", cCheque, MercadoLc)
''''         If Mensaje <> "" Then
''''            MsgBox "Error al Chequear Lineas : " + Chr(10) + Chr(13) + Chr(10) + Chr(13) + Mensaje, vbCritical, Msj
''''         End If
''''      End If '--> gsBac_Lineas = "S"
''''
''''
''''
''''End Sub

Public Sub Habil()
  
 
        Select Case FRM_SWAP_OP.I_FERIADOCHK(4).Value
                Case 0: Plaza = IIf(FRM_SWAP_OP.I_FERIADOCHK(5).Value = 0, ";6;", ";6;510;")
                Case 1: Plaza = IIf(FRM_SWAP_OP.I_FERIADOCHK(5).Value = 0, ";6;255;", ";6;255;510;")
        End Select


End Sub
