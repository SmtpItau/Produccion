VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "ClsOperacionTicket"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Public dFecha_operacion              As Date
Public nNumero_Operacion             As Double
Public nCantidad_flujo               As Integer
Public sTicker                       As String
Public sModalidad                    As String
Public sUsuario                    As String
Public nMoneda_Compra                As Integer
Public nValor_Nominal_Compra         As Double
Public nFrecuencia_Pago_Compra       As Integer
Public nFrecuencia_Capital_Compra    As Integer
Public nIndicador_Compra             As Integer
Public nTasa_Compra                  As Double
Public nConteo_Dias_Compra           As Integer
Public dFecha_Efectiva_Compra        As Date
Public dFecha_Inicio_Compra          As Date
Public dFecha_Penultimo_Pago_Compra  As Date
Public dFecha_Madurez_Compra         As Date
Public nMoneda_Pago_Compra           As Integer
Public nMedio_Pago_Compra            As Integer
Public nMoneda_Venta                 As Integer
Public nValor_Nominal_Venta          As Double
Public nFrecuencia_Pago_Venta        As Integer
Public nFrecuencia_Capital_Venta     As Integer
Public nIndicador_Venta              As Integer
Public nTasa_Venta                   As Double
Public nConteo_Dias_Venta            As Integer
Public dFecha_Efectiva_Venta         As Date
Public dFecha_Inicio_Venta           As Date
Public dFecha_Penultimo_Venta        As Date
Public dFecha_Madurez_Venta          As Date
Public nMoneda_Pago_Venta            As Integer
Public nMedio_Pago_Venta             As Integer
Public sEstado                       As String
Public nCodCarteraOrigen             As Integer
Public nCodMesaOrigen                As Integer
Public nCodCarteraDestino            As Integer
Public nCodMesaDestino               As Integer
Public nMontoPagoCLP                 As Double
Public nMontoPagoUSD                 As Double
Public nMontoVtaCLP                  As Double
Public nMontoVtaUSD                  As Double

Public A01_NumeroOperacion       As Double
Public A02_NumeroFlujo           As Integer
Public A03_TipoFlujo             As Integer
Public A04_TipoSwap              As Integer
Public A06_TipoOperacion         As String
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
Public A55_FxRate                As Double
Public A56_PrcAmortiza           As Double
Public A57_FechaValuta           As Date
Public A58_FlujoAdicional        As Double

Public A99_Estado                As String


Private Sub Class_Initialize()
'    dFecha_operacion = "99/99/9999"
    nNumero_Operacion = 0
    nCantidad_flujo = 0
    sTicker = ""
    sModalidad = ""
    nMoneda_Compra = 0
    nValor_Nominal_Compra = 0
    nFrecuencia_Pago_Compra = 0
    nFrecuencia_Capital_Compra = 0
    nIndicador_Compra = 0
    nTasa_Compra = 0
    nConteo_Dias_Compra = 0
'    dFecha_Efectiva_Compra = ""
'    dFecha_Inicio_Compra = ""
'    dFecha_Penultimo_Pago_Compra = ""
'    dFecha_Madurez_Compra = ""
    nMoneda_Pago_Compra = 0
    nMedio_Pago_Compra = 0
    nMoneda_Venta = 0
    nValor_Nominal_Venta = 0
    nFrecuencia_Pago_Venta = 0
    nFrecuencia_Capital_Venta = 0
    nIndicador_Venta = 0
    nTasa_Venta = 0
    nConteo_Dias_Venta = 0
'    dFecha_Efectiva_Venta = ""
'    dFecha_Inicio_Venta = ""
'    dFecha_Penultimo_Venta = ""
'    dFecha_Madurez_Venta = ""
    nMoneda_Pago_Venta = 0
    nMedio_Pago_Venta = 0
    sEstado = ""
    nCodCarteraOrigen = 0
    nCodMesaOrigen = 0
    nCodCarteraDestino = 0
    nCodMesaDestino = 0
    nMontoPagoCLP = 0
    nMontoPagoUSD = 0
    nMontoVtaCLP = 0
    nMontoVtaUSD = 0
End Sub

Public Function NuevoNumTicket() As Double
   NuevoNumeroSwap = 0
   
   If Not Bac_Sql_Execute("SP_ULTIMAOPERACION_TICKET") Then
      MsgBox "Error" & vbCrLf & "No se ha pidido establecer el N° de Operación.", vbExclamation, TITSISTEMA
      Exit Function
   End If
   If Bac_SQL_Fetch(DATOS()) Then
      NuevoNumTicket = Val(DATOS(1))
   Else
      NuevoNumTicket = 1
   End If
End Function

Public Function GrabaTicket(meform As Form) As Boolean
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
   GrabaTicket = False
   
   Envia = Array()
   AddParam Envia, nNumOpeTicket
   AddParam Envia, Me.A02_NumeroFlujo
   AddParam Envia, Me.A03_TipoFlujo
   AddParam Envia, Me.A04_TipoSwap
   AddParam Envia, Me.A06_TipoOperacion
   AddParam Envia, Me.A09_Moneda
   If A03_TipoFlujo = 1 Then AddParam Envia, CDec(meform.I_Nocionales.Text)
   If A03_TipoFlujo = 2 Then AddParam Envia, CDec(meform.D_Nocionales.Text)

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
   AddParam Envia, Me.A33_Usuario
   AddParam Envia, Me.A34_Observaciones
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
   AddParam Envia, IIf(Me.A51_IntercambioPrincipal = True, 1, 0)
   AddParam Envia, Me.A52_Tikker
   AddParam Envia, Me.A53_FechaLiquidacion
   AddParam Envia, Me.A53_FechaReset
   AddParam Envia, Me.A55_FxRate
   AddParam Envia, Me.A56_PrcAmortiza
   AddParam Envia, Me.A57_FechaValuta
   AddParam Envia, IIf(Me.A04_TipoSwap = 2, Me.A58_FlujoAdicional, 0)
      
   AddParam Envia, Me.A99_Estado
   
    If Not Bac_Sql_Execute("SP_GRABACION_TICKET_FLUJOS", Envia) Then
        Exit Function
    Else
        GrabaTicket = True
    End If
   GrabaTicket = True
   If Bac_SQL_Fetch(iDatos()) Then
'      If iDatos(1) < 0 Then
'         MsgBox iDatos(2), vbExclamation, TITSISTEMA
'         Exit Function
'      End If
   End If
End Function

Public Function GrabaOpTicket(miForm As FRM_SWAP_OP) As Boolean
    Dim iDatos()
    Dim Mensaje     As String
    Dim nRow       As Long
'If Not BacBeginTransaction Then x


    GrabaOpTicket = True
    Envia = Array()
    nRow = miForm.D_Grid.Rows - 1
    
    Me.dFecha_operacion = gsBAC_Fecp
    Me.nNumero_Operacion = CDbl(nNumOpeTicket)
    Me.nCantidad_flujo = Val(miForm.D_Grid.Cols - 1)  '
    Me.sTicker = miForm.TIKKER
    Me.sUsuario = gsBAC_User
    Me.sModalidad = Left(miForm.Modalidad, 1)
    Me.nMoneda_Compra = miForm.I_Moneda.ItemData(miForm.I_Moneda.ListIndex)
    Me.nValor_Nominal_Compra = CDec(miForm.I_Nocionales.Text)
    Me.nFrecuencia_Pago_Compra = Val(Right(miForm.I_FrecuenciaPago, 10)) 'CDbl(miForm.I_FrecuenciaPago.ItemData(miForm.I_FrecuenciaPago.ListIndex))
    Me.nFrecuencia_Capital_Compra = Val(Right(miForm.I_FrecuenciaCapital, 10)) 'CDbl(miForm.I_FrecuenciaCapital.Text)
    Me.nIndicador_Compra = miForm.I_Indicador.ItemData(miForm.I_Indicador.ListIndex)
    Me.nTasa_Compra = CDbl(miForm.I_UltimoIndice.Text)
    Me.nConteo_Dias_Compra = miForm.I_ConteoDias.ItemData(miForm.I_ConteoDias.ListIndex) 'miForm.I_ConteoDias.Text
    Me.dFecha_Efectiva_Compra = miForm.I_FechaEfectiva.Text
    Me.dFecha_Inicio_Compra = miForm.I_PrimerPago.Text
    Me.dFecha_Penultimo_Pago_Compra = miForm.I_PenultimoPago.Text
    Me.dFecha_Madurez_Compra = miForm.I_Madurez.Text
    Me.nMoneda_Pago_Compra = miForm.I_MonPago.ItemData(miForm.I_MonPago.ListIndex)
    Me.nMedio_Pago_Compra = miForm.I_MedioPago.ItemData(miForm.I_MedioPago.ListIndex)
    
    Me.nMoneda_Venta = miForm.D_Moneda.ItemData(miForm.D_Moneda.ListIndex)
    Me.nValor_Nominal_Venta = CDbl(miForm.D_Nocionales.Text)
    Me.nFrecuencia_Pago_Venta = Val(Right(miForm.D_FrecuenciaPago, 10)) 'miForm.D_FrecuenciaPago.Text
    Me.nFrecuencia_Capital_Venta = Val(Right(miForm.D_FrecuenciaCapital, 10)) 'miForm.D_FrecuenciaCapital.Text
    Me.nIndicador_Venta = miForm.D_Indicador.ItemData(miForm.D_Indicador.ListIndex) 'miForm.D_Indicador.Text
    Me.nTasa_Venta = CDbl(miForm.D_UltimoIndice.Text)
    Me.nConteo_Dias_Venta = miForm.D_ConteoDias.ItemData(miForm.D_ConteoDias.ListIndex) 'miForm.D_ConteoDias.Text
    Me.dFecha_Efectiva_Venta = miForm.D_FechaEfectiva.Text
    Me.dFecha_Inicio_Venta = miForm.D_PrimerPago.Text
    Me.dFecha_Penultimo_Venta = miForm.D_PenultimoPago.Text
    Me.dFecha_Madurez_Venta = miForm.D_Madurez.Text
    Me.nMoneda_Pago_Venta = miForm.D_MonPago.ItemData(miForm.D_MonPago.ListIndex)
    Me.nMedio_Pago_Venta = miForm.D_MedioPago.ItemData(miForm.D_MedioPago.ListIndex)
    Me.sEstado = "P"
    Me.nCodCarteraOrigen = gnCodCarteraOrigen
    Me.nCodMesaOrigen = gnCodMesaOrigen
    Me.nCodCarteraDestino = gnCodCarteraDestino
    Me.nCodMesaDestino = gnCodMesaDestino
    'Me.A32_FechaTerminoFlujo = Format(miForm.D_Grid.TextMatrix(Rows - 1, 1), "dd/mm/yyyy")
    
     Me.A32_FechaTerminoFlujo = Format(miForm.I_Grid.Rows - 1, "dd/mm/yyyy")

    AddParam Envia, gsBAC_Fecp
    AddParam Envia, Me.nNumero_Operacion
    AddParam Envia, Me.nCantidad_flujo
    AddParam Envia, Me.sTicker
    AddParam Envia, Me.sUsuario
    AddParam Envia, Me.sModalidad
    AddParam Envia, Me.nMoneda_Compra
    AddParam Envia, CDec(miForm.I_Nocionales.Text) 'Me.nValor_Nominal_Compra
    AddParam Envia, Me.nFrecuencia_Pago_Compra
    AddParam Envia, Me.nFrecuencia_Capital_Compra
    AddParam Envia, Me.nIndicador_Compra
    AddParam Envia, Me.nTasa_Compra
    AddParam Envia, Me.nConteo_Dias_Compra
    AddParam Envia, Me.dFecha_Efectiva_Compra
    AddParam Envia, Me.dFecha_Inicio_Compra
    AddParam Envia, Me.dFecha_Penultimo_Pago_Compra
    AddParam Envia, Me.dFecha_Madurez_Compra
    AddParam Envia, Me.nMoneda_Pago_Compra
    AddParam Envia, Me.nMedio_Pago_Compra
    AddParam Envia, Me.nMoneda_Venta
    AddParam Envia, CDec(miForm.D_Nocionales.Text) 'Me.nValor_Nominal_Venta
    AddParam Envia, Me.nFrecuencia_Pago_Venta
    AddParam Envia, Me.nFrecuencia_Capital_Venta
    AddParam Envia, Me.nIndicador_Venta
    AddParam Envia, Me.nTasa_Venta
    AddParam Envia, Me.nConteo_Dias_Venta
    AddParam Envia, Me.dFecha_Efectiva_Venta
    AddParam Envia, Me.dFecha_Inicio_Venta
    AddParam Envia, Me.dFecha_Penultimo_Venta
    AddParam Envia, Me.dFecha_Madurez_Venta
    AddParam Envia, Me.nMoneda_Pago_Venta
    AddParam Envia, Me.nMedio_Pago_Venta
    AddParam Envia, Me.sEstado
    AddParam Envia, Me.nCodCarteraOrigen
    AddParam Envia, Me.nCodMesaOrigen
    AddParam Envia, Me.nCodCarteraDestino
    AddParam Envia, Me.nCodMesaDestino
    AddParam Envia, Me.A32_FechaTerminoFlujo
    
        
    If Not Bac_Sql_Execute("SP_GRABACION_OPERACIONES_TICKET", Envia) Then
        GrabaOpTicket = False
        Exit Function
    End If
    
    If Bac_SQL_Fetch(iDatos()) Then
        If iDatos(1) < 0 Then
            MsgBox iDatos(2), vbExclamation, TITSISTEMA
            Exit Function
        End If
    End If
End Function

Public Function PreGrabaTicket(miForm As Form) As Boolean
   Dim iNumeroFlujos    As Integer
   Dim iTipoFlujo       As Integer
   Dim MiGrilla         As MSFlexGrid
   Dim Msg$
   Dim TipoGrab         As String
   
   Dim Mensaje          As String
   Dim Mensaje_Con      As String
   Dim MercadoLc        As String

   PreGrabaTicket = True

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
         Me.A06_TipoOperacion = "C" 'Left(MiForm.Modalidad, 1)
         Me.A09_Moneda = IIf(iTipoFlujo = 1, miForm.I_Moneda.ItemData(miForm.I_Moneda.ListIndex), miForm.D_Moneda.ItemData(miForm.D_Moneda.ListIndex))
         If iTipoFlujo = 1 Then Me.A10_Nocionales = CDec(miForm.I_Nocionales.Text)
         If iTipoFlujo = 2 Then Me.A10_Nocionales = CDec(miForm.D_Nocionales.Text)
         Me.A11_Amortizacion = CDec(MiGrilla.TextMatrix(iNumeroFlujos, 2))
         Me.A12_Saldo = CDec(MiGrilla.TextMatrix(iNumeroFlujos, 8))
         Me.A13_Interes = CDec(MiGrilla.TextMatrix(iNumeroFlujos, 4))
         Me.A14_Spread = CDec(MiGrilla.TextMatrix(iNumeroFlujos, 24)) ''CDbl(IIf(iTipoFlujo = 1, MiForm.I_Spread.Text, MiForm.D_Spread.Text))
         Me.A15_Indicador = IIf(iTipoFlujo = 1, miForm.I_Indicador.ItemData(miForm.I_Indicador.ListIndex), miForm.D_Indicador.ItemData(miForm.D_Indicador.ListIndex))
         Me.A16_UltimoIndice = CDec(MiGrilla.TextMatrix(iNumeroFlujos, 23)) ''CDbl(IIf(iTipoFlujo = 1, MiForm.I_UltimoIndice.Text, MiForm.D_UltimoIndice.Text))
         Me.A17_ConteoDias = IIf(iTipoFlujo = 1, miForm.I_ConteoDias.ItemData(miForm.I_ConteoDias.ListIndex), miForm.D_ConteoDias.ItemData(miForm.D_ConteoDias.ListIndex))
         Me.A18_FrecuenciaPago = Right(IIf(iTipoFlujo = 1, miForm.I_FrecuenciaPago, miForm.D_FrecuenciaPago), 10)
         Me.A19_FrecuenciaCapital = Right(IIf(iTipoFlujo = 1, miForm.I_FrecuenciaCapital, miForm.D_FrecuenciaCapital), 10)
         Me.A20_MonedaPago = IIf(iTipoFlujo = 1, miForm.I_MonPago.ItemData(miForm.I_MonPago.ListIndex), miForm.D_MonPago.ItemData(miForm.D_MonPago.ListIndex))
         Me.A21_MedioPago = IIf(iTipoFlujo = 1, miForm.I_MedioPago.ItemData(miForm.I_MedioPago.ListIndex), miForm.D_MedioPago.ItemData(miForm.D_MedioPago.ListIndex))
         Me.A22_MontoPago = CDec(MiGrilla.TextMatrix(iNumeroFlujos, 10))
         Me.A23_MontoPagoCLP = CDec(MiGrilla.TextMatrix(iNumeroFlujos, 12))
         Me.A24_MontoPagoUSD = CDec(MiGrilla.TextMatrix(iNumeroFlujos, 11))
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
         
         Me.A51_IntercambioPrincipal = IIf(MiGrilla.TextMatrix(iNumeroFlujos, 19) = "No", 0, 1) ''MiForm.Intercambio(0).Value
         Me.A52_Tikker = miForm.TIKKER.Text
         Me.A53_FechaLiquidacion = Format(MiGrilla.TextMatrix(iNumeroFlujos, 14), "dd/mm/yyyy")
         Me.A53_FechaReset = Format(MiGrilla.TextMatrix(iNumeroFlujos, 16), "dd/mm/yyyy")
         
         Me.A55_FxRate = CDbl(MiGrilla.TextMatrix(iNumeroFlujos, 22))
         Me.A56_PrcAmortiza = CDbl(MiGrilla.TextMatrix(iNumeroFlujos, 18))
         Me.A57_FechaValuta = Format(MiGrilla.TextMatrix(iNumeroFlujos, 20), "dd/mm/yyyy")
         Me.A58_FlujoAdicional = CDbl(MiGrilla.TextMatrix(iNumeroFlujos, 21))
         If DateDiff("D", gsBAC_Fecp, Me.A53_FechaLiquidacion) >= 0 Then
        
        
        'graba
        Envia = Array()
        AddParam Envia, nNumOpeTicket
        AddParam Envia, Me.A02_NumeroFlujo
        AddParam Envia, Me.A03_TipoFlujo
        AddParam Envia, Me.A04_TipoSwap
        AddParam Envia, Me.A06_TipoOperacion
        AddParam Envia, Me.A09_Moneda
        If A03_TipoFlujo = 1 Then AddParam Envia, CDec(miForm.I_Nocionales.Text)
        If A03_TipoFlujo = 2 Then AddParam Envia, CDec(miForm.D_Nocionales.Text)
        
        AddParam Envia, CDec(MiGrilla.TextMatrix(iNumeroFlujos, 2))
        AddParam Envia, CDec(MiGrilla.TextMatrix(iNumeroFlujos, 8))
        AddParam Envia, CDec(MiGrilla.TextMatrix(iNumeroFlujos, 4))
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
        AddParam Envia, Me.A33_Usuario
        AddParam Envia, Me.A34_Observaciones
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
        AddParam Envia, IIf(Me.A51_IntercambioPrincipal = True, 1, 0)
        AddParam Envia, Me.A52_Tikker
        AddParam Envia, Me.A53_FechaLiquidacion
        AddParam Envia, Me.A53_FechaReset
        AddParam Envia, Me.A55_FxRate
        AddParam Envia, Me.A56_PrcAmortiza
        AddParam Envia, Me.A57_FechaValuta
        AddParam Envia, IIf(Me.A04_TipoSwap = 2, Me.A58_FlujoAdicional, 0)
        AddParam Envia, Me.A99_Estado
   
        If Not Bac_Sql_Execute("SP_GRABACION_TICKET_FLUJOS", Envia) Then
            PreGrabaTicket = False
            Exit Function
        End If
        End If
      Next iNumeroFlujos
   Next iTipoFlujo
   If PreGrabaTicket Then
      MsgBox "Grabación Ok." & vbCrLf & vbCrLf & "Operación N° : " & Format(nNumOpeTicket, TipoFormato("CLP")) & " Se ha grabado en forma correcta.", vbInformation, TITSISTEMA
   End If
'  PreGrabaTicket = True
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
