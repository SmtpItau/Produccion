VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "estVentasFli"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'Marca del Papel
Dim mvarMarca                    As String * 1
Dim mvarVentana                  As Long

'Datos de la operación original
Dim mvarRutCliente               As Long
Dim mvarCodCliente               As Long
Dim mvarRutCartera               As Long
Dim mvarTipoCartera              As Integer
Dim mvarNumeroDocumento          As Long
Dim mvarCorrelativo              As Integer
Dim mvarTipoOperacion            As String
Dim mvarFechaCompra              As String

'No se para que lo estan utilizando
Dim mvarPVPMcdo                  As Double
Dim mvarTirMcdo                  As Double
Dim mvarMTMcdo                   As Double
Dim mvarMTMcdo100                As Double
Dim mvarMTValorizador            As Double

Dim mvarFechaSalida              As String * 10
Dim mvarNumUltCup                As Integer

'Datos del Papel
Dim mvarCodigoInstrumento        As Long
Dim mvarSerie                    As String
Dim mvarInstser                  As String
Dim mvarMascara                  As String
Dim mvarRutEmisor                As Long
Dim mvarFechaEmision             As String
Dim mvarFechaVencimiento         As String
Dim mvarTasaEmision              As Double
Dim mvarBaseEmision              As Double
Dim mvarMonedaEmision            As Integer
Dim mvarNemoMoneda               As String
Dim mvarNemoEmisor               As String
Dim mvarTasaEstimada             As Double
Dim mvarFecProxCupon             As String * 10
Dim mvarDiasDisponibles          As Long
Dim mvarSeriado                  As String * 1

'Datos Originales de la Compra
Dim mvarNominalCompra            As Double
Dim mvarTirCompra                As Double
Dim mvarPVPCompra                As Double
Dim mvarVParCompra               As Double
Dim mvarValorCompra              As Double

'Datos de la Venta
Dim mvarNominalVenta             As Double
Dim mvarTirVenta                 As Double
Dim mvarPVPVenta                 As Double
Dim mvarVParVenta                As Double
Dim mvarValorVenta               As Double
Dim mvarValorVenta100            As Double

'Datos adicionales
Dim mvarCodCustodia              As Integer
Dim mvarcustodia                 As String * 15
Dim mvarCodCustodiaOrig          As Integer
Dim mvarCustodiaOrig             As String * 15
Dim mvarClaveDCV                 As String * 10
Dim mvarDurationMacaulay         As Double
Dim mvarDurationModificado       As Double
Dim mvarConvexidad               As Double
Dim mvarLimite                   As Integer     'Código de error del limite (0: Sin error)
Dim mvarCodClasifCartSuper       As Integer
Dim mvarClasifCarteraSuper       As String * 12
Dim mvarUtilidad                 As Double
Dim mvarModificado               As String

'Datos Valores del Pacto
Dim mVarValorInicioPactoUM       As Double
Dim mVarValorInicioPactoCLP      As Double
Dim mVarValorFinalPactoUM        As Double
Dim mExtranj                     As Integer

Dim mVarCarteraSuper             As String

'++GRC Req007
Dim mVarMargen                  As Double
Dim mVarValorInicial            As Double
Dim mCorr_SOMA           As String
Dim mNumOper_SOMA               As String
'--GRC Req007
Dim Sql                          As String
Dim Datos()

'Cortes Papel
Public oColCortes                As New Collection

Dim mvarVALVENC                  As Double
Public Property Let NumOper_SOMA(nNumOper_SOMA As String)
   mNumOper_SOMA = nNumOper_SOMA
End Property

Public Property Get NumOper_SOMA() As String
   NumOper_SOMA = mNumOper_SOMA
End Property
Public Property Let Corr_SOMA(nCorr_SOMA As String)
   mCorr_SOMA = nCorr_SOMA
End Property

Public Property Get Corr_SOMA() As String
   Corr_SOMA = mCorr_SOMA
End Property

Public Property Let VALVENC(nVALVENC As Double)
   mvarVALVENC = nVALVENC
End Property

Public Property Get VALVENC() As Double
   VALVENC = mvarVALVENC
End Property

Public Property Let Ventana(nVentana As Long)
   mvarVentana = nVentana
End Property

Public Property Get Ventana() As Long
   Ventana = mvarVentana
End Property

Public Property Let Marca(sMarca As String)

   Dim iCortes       As Integer

   gsControlCortes = True

   If mvarMarca = sMarca Then
      mvarNominalVenta = mvarNominalCompra
      mvarTirVenta = mvarTirCompra
      mvarPVPVenta = mvarPVPCompra
      mvarVParVenta = mvarVParCompra
      mvarValorVenta = mvarValorCompra
     
      Exit Property

   End If

   If mvarMarca = "C" Then
      mvarMarca = sMarca
      
      If sMarca = " " And EstadoFli = False Then
         If Not DesBloquearPapel() Then
            sMarca = "*"
            mvarMarca = "*"
         End If
      End If

      
      Exit Property

   End If

   If sMarca = "." Then
      mvarMarca = " "

   End If

   If (sMarca = "V" Or sMarca = "C") And mvarMarca = " " And EstadoFli = False Then
      If Not BloquearPapel(mvarNominalCompra) Then
         sMarca = "*"
         mvarMarca = "*"

      End If

   End If

   
   Select Case sMarca
   Case "V"
      If CheckCortes(mvarNominalCompra) Then
      
         mvarMarca = sMarca
              mvarNominalVenta = mvarNominalCompra

         If Trim(custodia) = "DCV" Then
            ClaveDCV = FUNC_GENERA_CLAVE_DCV
         Else
            ClaveDCV = ""
         End If
         
         If EstadoFli = True Then
         
         End If
         
         For iCortes = 1 To oColCortes.Count
            oColCortes(iCortes).CantCortV = oColCortes(iCortes).CantCortD
         Next iCortes
         
         
          mVarCortes = "S"
      Else
         MsgBox "Cortes no Cuadran con el Nominal, Favor ajustar Custodia", vbCritical, "Selección de Cortes"
         gsControlCortes = False
         If EstadoFli = False Then
            Call DesBloquearPapel
         End If
         mVarCortes = "N"
      End If
   Case "C"
      If mvarMarca = "P" Or mvarMarca = "V" Then
         mvarMarca = sMarca
      Else
         If CheckCortes(mvarNominalCompra) Then
            mvarMarca = sMarca

            mvarNominalVenta = mvarNominalCompra
            mvarTirVenta = mvarTirCompra
            mvarPVPVenta = mvarPVPCompra
            mvarVParVenta = mvarVParCompra
            mvarValorVenta = mvarValorCompra

          If Tipo_Pago_total = True Or Tipo_Pago_parcial = True Then
            For iCortes = 1 To oColCortes.Count
               oColCortes(iCortes).CantCortV = oColCortes(iCortes).CantCortD
            Next iCortes
       
          Else
            For iCortes = 1 To oColCortes.Count
               oColCortes(iCortes).CantCortV = 0
            Next iCortes
         End If
           If Trim(custodia) = "DCV" Then
              ClaveDCV = FUNC_GENERA_CLAVE_DCV
           Else
              ClaveDCV = ""
           End If

         Else
            MsgBox "Cortes no Cuadran con el Nominal, Favor ajustar Custodia", vbCritical, "Selección de Cortes"
            gsControlCortes = False

         If EstadoFli = False Then
            Call DesBloquearPapel
         End If

         End If

      End If

   Case "P"
      If CheckCortes(mvarNominalCompra) Then
      
         mvarMarca = sMarca
         mvarNominalVenta = mvarNominalCompra

         If Trim(custodia) = "DCV" Then
            ClaveDCV = FUNC_GENERA_CLAVE_DCV
         Else
            ClaveDCV = ""
         End If
         
         mVarCortes = "S"
      Else
         MsgBox "Cortes no Cuadran con el Nominal, Favor ajustar Custodia", vbCritical, "Selección de Cortes"
         gsControlCortes = False
         If EstadoFli = False Then
            Call DesBloquearPapel
         End If
         mVarCortes = "N"
      End If

   Case " ", ""
   
   
      If mvarMarca <> "*" And EstadoFli = False Then
          If DesBloquearPapel() Then
             mvarMarca = sMarca
             mvarNominalVenta = mvarNominalCompra
             mvarTirVenta = mvarTirCompra
             mvarPVPVenta = mvarPVPCompra
             mvarVParVenta = mvarVParCompra
             mvarValorVenta = mvarValorCompra
             ClaveDCV = ""
    
             For iCortes = 1 To oColCortes.Count
                oColCortes(iCortes).CantCortV = 0
    
             Next iCortes
          End If
      Else
      
         mvarMarca = sMarca
         mvarNominalVenta = mvarNominalCompra
         mvarTirVenta = mvarTirCompra
         mvarPVPVenta = mvarPVPCompra
         mvarVParVenta = mvarVParCompra
         mvarValorVenta = mvarValorCompra
         ClaveDCV = mvarClaveDCV
         

         For iCortes = 1 To oColCortes.Count
            oColCortes(iCortes).CantCortV = 0

         Next iCortes

      End If

   Case "*"
      mvarMarca = sMarca

   End Select
   'mvarmodificado =
   mvarClaveDCV = ClaveDCV
End Property

Public Property Get custodia() As String
custodia = mvarcustodia
End Property

Public Property Get Marca() As String
   Marca = mvarMarca
End Property

Public Property Let RutCliente(nRutCliente As Long)
   mvarRutCliente = nRutCliente
End Property

Public Property Get RutCliente() As Long
   RutCliente = mvarRutCliente
End Property

Public Property Let RutCartera(nRutCartera As Long)
   mvarRutCartera = nRutCartera
End Property

Public Property Get RutCartera() As Long
   RutCartera = mvarRutCartera
End Property

Public Property Let TipoCartera(nTipoCartera As Integer)
   mvarTipoCartera = nTipoCartera
End Property

Public Property Get TipoCartera() As Integer
   TipoCartera = mvarTipoCartera
End Property

Public Property Let CodCliente(nCodCliente As Long)
   mvarCodCliente = nCodCliente
End Property

Public Property Get CodCliente() As Long
   CodCliente = mvarCodCliente
End Property

Public Property Let NumeroDocumento(nNumeroDocumento As Long)
   mvarNumeroDocumento = nNumeroDocumento
End Property

Public Property Get NumeroDocumento() As Long
   NumeroDocumento = mvarNumeroDocumento
End Property

Public Property Let Correlativo(nCorrelativo As Integer)
   mvarCorrelativo = nCorrelativo
End Property

Public Property Get Correlativo() As Integer
   Correlativo = mvarCorrelativo
End Property

Public Property Let TipoOperacion(sTipoOperacion As String)
   mvarTipoOperacion = sTipoOperacion
End Property

Public Property Get TipoOperacion() As String
   TipoOperacion = mvarTipoOperacion
End Property

Public Property Let PVPMcdo(nPVPMcdo As Double)
   mvarPVPMcdo = nPVPMcdo
End Property

Public Property Get PVPMcdo() As Double
   PVPMcdo = mvarPVPMcdo
End Property

Public Property Let TirMcdo(nTirMcdo As Double)
   mvarTirMcdo = nTirMcdo
End Property

Public Property Get TirMcdo() As Double
   TirMcdo = mvarTirMcdo
End Property

Public Property Let MTMcdo(nMTMcdo As Double)
   mvarMTMcdo = nMTMcdo
End Property

Public Property Let MTMcdo100(nMTMcdo100 As Double)

   mvarMTMcdo100 = nMTMcdo100

End Property

Public Property Get MTMcdo100() As Double

   MTMcdo100 = mvarMTMcdo100

End Property

Public Property Get MTMcdo() As Double
   MTMcdo = mvarMTMcdo
End Property

Public Property Let FechaSalida(sFechaSalida As String)
   mvarFechaSalida = sFechaSalida
End Property

Public Property Get FechaSalida() As String
   FechaSalida = mvarFechaSalida
End Property

Public Property Let FechaCompra(sFechaCompra As String)
   mvarFechaCompra = sFechaCompra
End Property

Public Property Get FechaCompra() As String
   FechaCompra = mvarFechaCompra
End Property

Public Property Let NumUltCup(nNumUltCup As Integer)
   mvarNumUltCup = nNumUltCup
End Property

Public Property Get NumUltCup() As Integer
   NumUltCup = mvarNumUltCup
End Property

Public Property Let CodigoInstrumento(nCodigoInstrumento As Integer)
   mvarCodigoInstrumento = nCodigoInstrumento
End Property

Public Property Get CodigoInstrumento() As Integer
   CodigoInstrumento = mvarCodigoInstrumento
End Property

Public Property Let Serie(sSerie As String)
  mvarSerie = sSerie
End Property

Public Property Get Serie() As String
   Serie = mvarSerie
End Property

Public Property Let InstSer(sInstSer As String)
   mvarInstser = sInstSer
End Property

Public Property Get InstSer() As String
   InstSer = mvarInstser
End Property

Public Property Let Mascara(sMascara As String)
   mvarMascara = sMascara
End Property

Public Property Get Mascara() As String
   Mascara = mvarMascara
End Property

Public Property Let RutEmisor(nRutEmisor As Long)
   mvarRutEmisor = nRutEmisor
End Property

Public Property Get RutEmisor() As Long
   RutEmisor = mvarRutEmisor
End Property

Public Property Let FechaEmision(sFechaEmision As String)
   mvarFechaEmision = sFechaEmision
End Property

Public Property Get FechaEmision() As String
   FechaEmision = mvarFechaEmision
End Property

Public Property Let FechaVencimiento(sFechaVencimiento As String)
   mvarFechaVencimiento = sFechaVencimiento
End Property

Public Property Get FechaVencimiento() As String
   FechaVencimiento = mvarFechaVencimiento
End Property

Public Property Let TasaEmision(nTasaEmision As Double)
   mvarTasaEmision = nTasaEmision
End Property

Public Property Get TasaEmision() As Double
   TasaEmision = mvarTasaEmision
End Property

Public Property Let BaseEmision(nBaseEmision As Integer)
   mvarBaseEmision = nBaseEmision
End Property

Public Property Get BaseEmision() As Integer
   BaseEmision = mvarBaseEmision
End Property

Public Property Let MonedaEmision(nMonedaEmision As Integer)
   mvarMonedaEmision = nMonedaEmision
End Property

Public Property Get MonedaEmision() As Integer
   MonedaEmision = mvarMonedaEmision
End Property

Public Property Let NemoMoneda(sNemoMoneda As String)
   mvarNemoMoneda = sNemoMoneda
End Property

Public Property Get NemoMoneda() As String
   NemoMoneda = mvarNemoMoneda
End Property

Public Property Let NemoEmisor(sNemoEmisor As String)
   mvarNemoEmisor = sNemoEmisor
End Property

Public Property Get NemoEmisor() As String
   NemoEmisor = mvarNemoEmisor
End Property

Public Property Let TasaEstimada(nTasaEstimada As Double)
   mvarTasaEstimada = nTasaEstimada
End Property

Public Property Get TasaEstimada() As Double
   TasaEstimada = mvarTasaEstimada
End Property

Public Property Let FecProxCupon(sFecProxCupon As String)
   mvarFecProxCupon = sFecProxCupon
End Property

Public Property Get FecProxCupon() As String
   FecProxCupon = mvarFecProxCupon
End Property

Public Property Let DiasDisponibles(nDiasDisponibles As Long)
   mvarDiasDisponibles = nDiasDisponibles
End Property

Public Property Get DiasDisponibles() As Long
   DiasDisponibles = mvarDiasDisponibles
End Property

Public Property Let seriado(sSeriado As String)
   mvarSeriado = sSeriado
End Property

Public Property Get seriado() As String
   seriado = mvarSeriado
End Property

Public Property Let NominalCompra(nNominalCompra As Double)
   mvarNominalCompra = nNominalCompra
   mvarNominalVenta = nNominalCompra
End Property

Public Property Get NominalCompra() As Double
   NominalCompra = mvarNominalCompra
End Property

Public Property Let TirCompra(nTirCompra As Double)
   mvarTirCompra = nTirCompra
   mvarTirVenta = nTirCompra
End Property

Public Property Get TirCompra() As Double
   TirCompra = mvarTirCompra
End Property

Public Property Let PVPCompra(nPVPCompra As Double)
   mvarPVPCompra = nPVPCompra
   mvarPVPVenta = nPVPCompra
End Property

Public Property Get PVPCompra() As Double
   PVPCompra = mvarPVPCompra
End Property

Public Property Let VParCompra(nVParCompra As Double)
   mvarVParCompra = nVParCompra
End Property

Public Property Get VParCompra() As Double
   VParCompra = mvarVParCompra
End Property

Public Property Let ValorCompra(nValorCompra As Double)
   mvarValorCompra = nValorCompra
   mvarValorVenta = nValorCompra
End Property

Public Property Get ValorCompra() As Double

   If mvarNominalCompra > 0 Then
      ValorCompra = Round(mvarValorCompra * (mvarNominalVenta / mvarNominalCompra), 0)

   Else
      ValorCompra = mvarValorCompra

   End If

End Property

Public Property Let NominalVenta(nNominalVenta As Double)

   If nNominalVenta > mvarNominalCompra Then
     ' MsgBox "El nominal ingresado es mayor al nominal original", vbExclamation, "Bloqueo del papel"
      Marca = " "
      mvarNominalVenta = mvarNominalCompra

   ElseIf mvarNominalVenta = nNominalVenta Then
      If mvarMarca = "C" Then
         Marca = IIf(mvarNominalCompra = nNominalVenta, "V", "P")
         mvarNominalVenta = nNominalVenta

      End If

      Exit Property

   ElseIf nNominalVenta <= mvarNominalCompra Then
      If mvarMarca = "C" Then
         If ValidarCortes(nNominalVenta) Then
            Marca = IIf(nNominalVenta < mvarNominalCompra, "P", "V")
            mvarNominalVenta = nNominalVenta

         Else
           ' MsgBox "Nominal no corresponde a los cortes ingresados para este papel", vbExclamation, "Validación de Cortes"
            Marca = " "

         End If

      Else
         If CheckCortes(nNominalVenta) Then
            'Asignar Cortes
            If BloquearPapel(mvarNominalVenta) Then
               Marca = "P"
               mvarNominalVenta = nNominalVenta

            Else
               Marca = "*"

            End If

         Else
            MsgBox "Nominal ingresado no cuadra con la cantidad de cortes", vbExclamation, "NOMINAL"

         End If

      End If

   End If
End Property

Public Property Get NominalVenta() As Double
   NominalVenta = mvarNominalVenta
End Property

Public Property Let TirVenta(nTirVenta As Double)
   mvarTirVenta = nTirVenta
End Property

Public Property Get TirVenta() As Double
   TirVenta = mvarTirVenta
End Property

Public Property Let PVPVenta(nPVPVenta As Double)
   mvarPVPVenta = nPVPVenta
End Property

Public Property Get PVPVenta() As Double
   PVPVenta = mvarPVPVenta
End Property

Public Property Let VParVenta(nVParVenta As Double)
   mvarVParVenta = nVParVenta
End Property

Public Property Get VParVenta() As Double
   VParVenta = mvarVParVenta
End Property

Public Property Let ValorVenta(nValorVenta As Double)
   mvarValorVenta = nValorVenta
   ''++GRC Req007
   mVarValorInicial = Round((mvarValorVenta * mVarMargen), 0)
   ''--GRC Req007
End Property

Public Property Get ValorVenta() As Double
   ValorVenta = mvarValorVenta
End Property

Public Property Let ValorVenta100(nValorVenta100 As Double)
  mvarValorVenta100 = nValorVenta100
End Property
''++GRC Req007
Public Property Let Margen(nVarMargen As Double)
    mVarMargen = nVarMargen
End Property
Public Property Get Margen() As Double
    Margen = mVarMargen
End Property
Public Property Let ValorInicial(nVarValorInicial As Double)
    mVarValorInicial = nVarValorInicial
End Property
Public Property Get ValorInicial() As Double
    ValorInicial = mVarValorInicial
End Property
''--GRC Req007
Public Property Get ValorVenta100() As Double
   ValorVenta100 = mvarValorVenta100
End Property

Public Property Let CodCustodia(ncustodia As Integer)

   If ncustodia > 2 Then
      Exit Property

   End If

   If mvarCodCustodia = ncustodia Then
      Exit Property

   End If

   mvarCodCustodia = ncustodia

   Select Case ncustodia
   Case 0
      mvarcustodia = "CLIENTE"
      mvarClaveDCV = ""

   Case 1
      mvarcustodia = "DCV"
      mvarClaveDCV = FUNC_GENERA_CLAVE_DCV

   Case 2
      mvarcustodia = "PROPIA"
      mvarClaveDCV = ""

   End Select

End Property

Public Property Get CodCustodia() As Integer

   CodCustodia = mvarCodCustodia

End Property

'Public Property Get custodia() As String

 '  custodia = mvarcustodia

'End Property

Public Property Let ClaveDCV(sClaveDCV As String)

   mvarClaveDCV = sClaveDCV

End Property

Public Property Get ClaveDCV() As String

   ClaveDCV = mvarClaveDCV

End Property
Public Property Let FliModificado(sModificado As String)

   mvarModificado = sModificado

End Property

Public Property Get FliModificado() As String

   FliModificado = mvarModificado

End Property


Public Property Let CarteraSuper(sCarteraSuper As String)

   mVarCarteraSuper = sCarteraSuper

   Select Case sCarteraSuper
   Case "N"
      mvarClasifCarteraSuper = "NORMAL"

   Case "P"
      mvarClasifCarteraSuper = "PERMANENTE"

   End Select


End Property

Public Property Get CarteraSuper() As String

   CarteraSuper = mVarCarteraSuper

End Property



Public Property Let CustodiaOrig(sCustodia As String)

   Select Case Mid$(sCustodia, 1, 1)
   Case "C"
      mvarCodCustodiaOrig = 0
      mvarCustodiaOrig = "CLIENTE"

   Case "F"
      mvarCodCustodiaOrig = 2
      mvarCustodiaOrig = "FISICA"

   Case "D"
      mvarCodCustodiaOrig = 1
      mvarCustodiaOrig = "DCV"

   End Select

   mvarCodCustodia = mvarCodCustodiaOrig
   mvarcustodia = mvarCustodiaOrig

End Property

Public Property Get CustodiaOrig() As String

   CustodiaOrig = mvarCustodiaOrig

End Property

Public Property Get CodCustodiaOrig() As Integer

   CodCustodiaOrig = mvarCodCustodiaOrig

End Property

Public Property Let DurationMacaulay(nDurationMacaulay As Double)

   mvarDurationMacaulay = nDurationMacaulay

End Property

Public Property Get DurationMacaulay() As Double

   DurationMacaulay = mvarDurationMacaulay

End Property

Public Property Let DurationModificado(nDurationModificado As Double)

   mvarDurationModificado = nDurationModificado

End Property

Public Property Get DurationModificado() As Double

   DurationModificado = mvarDurationModificado

End Property

Public Property Let Convexidad(nConvexidad As Double)

   mvarConvexidad = nConvexidad

End Property


Public Property Let MtValorizador(nMTValorizador As Double)

   mvarMTValorizador = nMTValorizador

End Property

Public Property Get MtValorizador() As Double

   MtValorizador = mvarMTValorizador
  

End Property

Public Property Get Convexidad() As Double

   Convexidad = mvarConvexidad

End Property

Public Property Let Limite(nLimite As Integer)
   mvarLimite = nLimite
End Property

Public Property Get Limite() As Integer
   Limite = mvarLimite
End Property

Public Property Let CodClasifCarteraSuper(nClasifCarteraSuper As Integer)
   mvarCodClasifCartSuper = nClasifCarteraSuper

   Select Case nClasifCarteraSuper
   Case 0
      mvarClasifCarteraSuper = "TRANSFERIBLE"

   Case 1
      mvarClasifCarteraSuper = "PERMANENTE"

   End Select
End Property

Public Property Get CodClasifCarteraSuper() As Integer
   CodClasifCarteraSuper = mvarCodClasifCartSuper
End Property

Public Property Get ClasifCarteraSuper() As String
   ClasifCarteraSuper = mvarClasifCarteraSuper
End Property

Public Property Get Utilidad() As Double
   If mvarNominalCompra > 0 Then
      Utilidad = mvarValorVenta - Round((mvarValorCompra * (mvarNominalVenta / mvarNominalCompra)), 0)
   Else
      Utilidad = 0
   End If
End Property

Public Property Let ValorInicioPactoUM(nValorInicioPactoUM As Double)
   mVarValorInicioPactoUM = nValorInicioPactoUM
End Property

Public Property Get ValorInicioPactoUM() As Double
   ValorInicioPactoUM = mVarValorInicioPactoUM
End Property

Public Property Let ValorInicioPactoCLP(nValorInicioPactoCLP As Double)
   mVarValorInicioPactoCLP = nValorInicioPactoCLP
End Property

Public Property Get ValorInicioPactoCLP() As Double
   ValorInicioPactoCLP = mVarValorInicioPactoCLP
End Property

Public Property Let ValorFinalPactoUM(nValorFinalPactoUM As Double)
   mVarValorFinalPactoUM = nValorFinalPactoUM
End Property

Public Property Get ValorFinalPactoUM() As Double
   ValorFinalPactoUM = mVarValorFinalPactoUM
End Property

Public Property Let Extranj(nExtranj As Integer)
   mExtranj = nExtranj
End Property

Public Property Get Extranj() As Integer
   Extranj = mExtranj
End Property

Private Function BloquearPapel(nNominal As Double) As Boolean

   BloquearPapel = False
   
   Envia = Array()
   AddParam Envia, mvarRutCartera
   AddParam Envia, mvarNumeroDocumento
   AddParam Envia, mvarCorrelativo
   AddParam Envia, nNominal
   AddParam Envia, mvarVentana
   AddParam Envia, gsBac_User

   If Not Bac_Sql_Execute("SP_BLOQUEARVP", Envia) Then
      Exit Function
   End If

   Do While Bac_SQL_Fetch(Datos())
      Select Case Datos(1)
      Case "SI"
         BloquearPapel = True

      Case "OK"
         MsgBox "Instrumento está seleccionado por otro usuario", vbInformation, "Bloqueo de Papeles"

      Case Else
         MsgBox "Instrumento está seleccionado en otra ventana", vbInformation, "Bloqueo de Papeles"

      End Select
                     
   Loop
               
End Function

Private Function VerBloquoPapel() As Boolean

'  BloquearPapel = False
   
   Envia = Array()
   AddParam Envia, mvarRutCartera
   AddParam Envia, mvarNumeroDocumento
   AddParam Envia, mvarCorrelativo
   AddParam Envia, 0
   AddParam Envia, mvarVentana
   AddParam Envia, gsBac_User

   If Not Bac_Sql_Execute("SP_VERBLOQUEO", Envia) Then
      Exit Function
   End If

   Do While Bac_SQL_Fetch(Datos())
      Select Case Datos(1)
      Case "SI"
         MsgBox "Instrumento está seleccionado en otra ventana", vbInformation, "Bloqueo de Papeles"
      End Select
                     
   Loop
               
End Function


Private Function DesBloquearPapel() As Boolean

   DesBloquearPapel = False


'  Sql = "EXECUTE SP_DESBLOQUEARINST "

   Envia = Array()
   AddParam Envia, mvarRutCartera
   AddParam Envia, mvarNumeroDocumento
   AddParam Envia, mvarCorrelativo
   AddParam Envia, mvarVentana
   AddParam Envia, gsBac_User

   If Not Bac_Sql_Execute("SP_DESBLOQUEARINST", Envia) Then
      Exit Function
   End If

   Do While Bac_SQL_Fetch(Datos())
      Select Case Datos(1)
      Case "SI"
         DesBloquearPapel = True

      Case -1
         DesBloquearPapel = True

      Case 1
         MsgBox "Instrumento no pudo desbloquearse", vbCritical, "Desbloqueo de Papel"

      Case Else
         MsgBox "Instrumento no pudo desbloquearse", vbCritical, "Desbloqueo de Papel"

      End Select
                     
   Loop

End Function

Public Function CheckCortes(nNominalVenta As Double) As Boolean

    Dim iCortes       As Integer
    Dim objBuffer     As New estCortes
    Dim oSQLCon       As New BTPADODB.CADODB
    Dim Sql           As String
   
    Set oSQLCon = Nothing
 
    oSQLCon.ServerName = gsSQL_Server$
    oSQLCon.HostName = gsBac_Term
    oSQLCon.Application = "RENTA FIJA"
    oSQLCon.ConnectionMode = 2
    oSQLCon.DatabaseName = gsSQL_Database
    oSQLCon.Login = gsSQL_Login
    oSQLCon.Password = gsSQL_Password
    oSQLCon.LoginTimeout = giSQL_LoginTimeOut
    oSQLCon.QueryTimeout = giSQL_QueryTimeOut

    If oSQLCon.SQL_Coneccion() = False Then
       Call miSQL.SQL_Close
       Exit Function
    End If
    
    CheckCortes = False
    If Modificacion = True Then
    Sql = "EXECUTE SVC_BCA_COR " & mvarRutCartera & "," & mvarNumeroDocumento & "," & mvarCorrelativo & "," & Replace(nNominalVenta, ",", ".") & "," & gsNmoper_Fli
    Else
    Sql = "EXECUTE SP_VALCORT " & mvarRutCartera & "," & mvarNumeroDocumento & "," & mvarCorrelativo & "," & Replace(nNominalVenta, ",", ".")
    End If
    
    
    If oSQLCon.SQL_Execute(Sql) <> 0 Then
       MsgBox "NO SE PUDO EJECUTAR LA RUTINA DE SELECCION DE CORTES", vbExclamation, gsBac_Version
       Exit Function
    End If

    For iCortes = oColCortes.Count To 1 Step -1

       oColCortes.Remove iCortes

    Next iCortes

   Do While oSQLCon.SQL_Fetch(Datos()) = 0
      Set objBuffer = New estCortes

      objBuffer.MtoCort = CDbl(Datos(1))
      objBuffer.CantCortD = CDbl(Datos(2))
      objBuffer.CantCortV = CDbl(Datos(3))

      oColCortes.Add objBuffer

      Set objBuffer = Nothing

   Loop

   If oColCortes.Count > 0 Then
      CheckCortes = True
   Else
      CheckCortes = False
   End If

End Function

Function ValidarCortes(nNominal As Double) As Boolean
'reparte cortes jlc
   Dim iCortes       As Integer
   Dim iCantCortes   As Double
   Dim objCortes     As New Collection
   Dim objBuffer     As New estCortes
   Dim xNominal      As Double

'   Set objCortes = New estCortes

   xNominal = nNominal

   For iCortes = 1 To oColCortes.Count
      
      Set objBuffer = New estCortes

      objBuffer.MtoCort = oColCortes(iCortes).MtoCort
      objBuffer.CantCortD = oColCortes(iCortes).CantCortD
      objBuffer.CantCortV = oColCortes(iCortes).CantCortV

      objCortes.Add objBuffer

      Set objBuffer = Nothing

   Next

   ValidarCortes = False

   For iCortes = 1 To objCortes.Count
      iCantCortes = 0
      iCantCortes = Round(xNominal / objCortes(iCortes).MtoCort, 0)

      If iCantCortes > 0 Then
         If iCantCortes > objCortes(iCortes).CantCortD Then
            iCantCortes = objCortes(iCortes).CantCortD
         End If
         
      End If
      objCortes(iCortes).CantCortV = iCantCortes
      xNominal = Round(xNominal - (objCortes(iCortes).MtoCort * iCantCortes), 4)


   Next iCortes

   If xNominal = 0 Then
      ValidarCortes = True

      For iCortes = 1 To objCortes.Count
         oColCortes(iCortes).CantCortV = objCortes(iCortes).CantCortV

      Next

   End If

End Function

