Attribute VB_Name = "BACContratos"

   Global vFechasEscrituras() As Variant
   Global nCuentaAvales       As Integer

   Global MatrizAvales()
   Global MatrizDctosFisicos()
   Global MatrizSeleccionados()
   Global MatrizClausulas()
      
   Global Const cConceptoCG = "Cond_Gral"
   Global Const cConceptoCE = "Espec_Prod"
   
   Global ArregloDatosBasicos(20)
         
   Enum ColsDatosBasicos
      ApoderadoBco1 = 1
      RutApoderadoBco1 = 2
      ApoderadoBco2 = 3
      RutApoderadoBco2 = 4
      NombreCli = 5
      RutCli = 6
      ApoderadoCli1 = 7
      RutApoderadoCli1 = 8
      ApoderadoCli2 = 9
      RutApoderadoCli2 = 10
      DireccionCli = 11
      ComunaCli = 12
      CiudadCli = 13
      FechaEscritura = 14
      NotariaCli = 15
      FonoCli = 16
      FaxCli = 17
      TipoCli = 18
      FechaAntiguoCcg = 19
      FechaNuevoCcg = 20
   End Enum
   
   Enum ColsArrayContrato
      TipoOperacion = 1
      MontoOperacion = 2
      TasaConversion = 3
      Modalidad = 4
      FechaInicioFlujo = 5
      FechaVenceFlujo = 6
      Dias = 7
      ValorTasaRecibo = 8
      ValorTasaEntrego = 9
      ReciboTasaDesc = 10
      EntregoTasaDesc = 11
      PagamosDoc = 12
      RecibimosDoc = 13
      NumeroFlujo = 14
      ReciboCapital = 15
      ReciboArmotiza = 16
      ReciboSaldo = 17
      ReciboInteres = 18
      ReciboSpread = 19
      EntregoCapital = 20
      EntregoArmotiza = 21
      EntregoSaldo = 22
      EntregoInteres = 23
      EntregoSpread = 24
      EntregoCodMonedaPago = 25
      ReciboCodMonedaPago = 26
      TipoFlujo = 27
      ReciboCodMoneda = 28
      EntregoCodMoneda = 29
      ReciboCapital2 = 30
      EntregoCapital2 = 31
      EntregoNemoMon = 32
      ReciboNemoMon = 33
      Valuta = 34
      EstadoFlujo = 35
      Amortiza = 36
      FechaFijacionTasa = 37
      FechaLiquidacion = 38
      EntregoNemoMonPago = 39
      ReciboNemoMonPago = 40
      TituloModCompensa = 41
      TituloModEntFis = 42
      TituloModEntFis2 = 43
      TipoSwap = 44
      NumeroOperacion = 45
      IntercambioNocional = 46
      RecibeGlosaBase = 47 ''REQ.7904
      EntregaGlosaBase = 48 ''REQ.7904
   End Enum
      
   Global ArregloParametrosBanco(22)
   
   Enum ColsArrayParametrosBanco
      CodigoEntidad = 1
      CodigoSistema = 2
      NombreEntidad = 3
      RutEntidad = 4
      DireccionEntidad = 5
      ComunaEntidad = 6
      CiudadEntidad = 7
      TelefonoEntidad = 8
      FaxEntidad = 9
      FechaAnt = 10
      FechaProceso = 11
      FechaProxima = 12
      NumeroOperacion = 13
      RutBancoCentral = 14
      EstadoInicioDia = 15
      libor = 16
      Paridad = 17
      tasamtm = 18
      tasas = 19
      EstadoFinDia = 20
      EstadoCierreMesa = 21
      CodigoRutEntidad = 22
   End Enum
   
   Global MatrizEstadoCivil(5, 2)
   
   Enum EstadoCivil
      Soltero = 1
      CasadoSB = 2
      CasadoSC = 3
      CasadoPG = 4
      NoAplica = 5
   End Enum
   
Dim nUltimoFlujoActivo  As Long
Dim nUltimoFlujoPasivo  As Long

  
      
Function BacContratoSwapTasaBancaria(DatosCond(), NumOper, Donde) As Boolean
   On Error GoTo Control:
   Dim Doc2             As Word.Document
   Dim SQL              As String
   Dim NemoMon          As String
   Dim Paso             As String
   Dim Glosa            As String
   Dim Okk              As Boolean
   Dim nombre_archivo   As String
   Dim i                As Integer
   Dim total            As Integer
   Dim contadorlineas
   Dim A, m
   Dim Datos()
   Dim Contrato()

   SQL = giSQL_DatabaseCommon
   SQL = SQL & "..SP_LEER_MONEDA "
   SQL = SQL & DatosCond(29)

   If MISQL.SQL_Execute(SQL) = 0 Then
      If MISQL.SQL_Fetch(Datos()) = 0 Then
         NemoMon = UCase(Datos(2))
      End If
   End If

   Set Doc2 = IniciaWordListadoLog("ContratoTasasBancaria", Okk)

   If Not Okk Then
      MsgBox "No podra ser Generado el contrato!", vbCritical, Msj
      BacContratoSwapTasaBancaria = False
      Exit Function
   End If
    
   Dim NombreCliente       As String
   Dim FechaCondiciones    As String
   
   Let NombreCliente = Trim(BacContratoSwap.grdLista.TextMatrix(BacContratoSwap.grdLista.Row, 2))
   Let FechaCondiciones = BacContratoSwap.grdLista.TextMatrix(BacContratoSwap.grdLista.Row, 12)
   
   If Year(CDate(FechaCondiciones)) = "1900" Or Len(FechaCondiciones) = 0 Then
      MsgBox "No se han emitido condiciones generales para el cliente " & vbCrLf & NombreCliente
     ' Exit Function
   End If

Imprimir:
    Doc2.Activate
    Doc2.Application.Visible = True
    
    Doc2.Bookmarks("folio").Select
    Doc2.Application.Selection.Text = NumOper
    
    
    Doc2.Bookmarks("Fecha_Proceso_6").Select
    Doc2.Application.Selection.Text = BacFormatoFecha("DDMMAA", gsBAC_Fecp)
    
    Doc2.Bookmarks("Nombre_Banco_11").Select
    Doc2.Application.Selection.Text = DatosCond(1)
    
    Doc2.Bookmarks("Rut_Banco_9").Select
    Doc2.Application.Selection.Text = DatosCond(2)
    
    Doc2.Bookmarks("Fecha_Proceso_7").Select 'fecha_condiciones generales
    Doc2.Application.Selection.Text = BacFormatoFecha("DDMMAA", BacContratoSwap.grdLista.TextMatrix(BacContratoSwap.grdLista.Row, 12))
    
    Doc2.Bookmarks("banco6").Select
    Doc2.Application.Selection.Text = DatosCond(1)
    
    Doc2.Bookmarks("Apoderado1_Banco_9").Select
    Doc2.Application.Selection.Text = Trim(Mid(BacContratoSwap.cmbRepBco1.Text, 1, 30))
    
    Doc2.Bookmarks("apo_bco").Select
    Doc2.Application.Selection.Text = Trim(Mid(BacContratoSwap.cmbRepBco2.Text, 1, 30))
    
    
    Doc2.Bookmarks("Direccion_Banco_10").Select
    Doc2.Application.Selection.Text = gsc_Parametros.direccion
    
    Doc2.Bookmarks("COMUNA3").Select
    Doc2.Application.Selection.Text = gsc_Parametros.comuna
    
    Doc2.Bookmarks("CIUDAD3").Select
    Doc2.Application.Selection.Text = gsc_Parametros.Ciudad
     
    Doc2.Bookmarks("Nombre_Cliente_11").Select
    Doc2.Application.Selection.Text = BacContratoSwap.txtCliente.Caption
    
    Doc2.Bookmarks("Direccion_Cliente_10").Select
    Doc2.Application.Selection.Text = BacContratoSwap.txtDirecCli
    
    With BacContratoSwap
      Call FIRMAS(Doc2, "Nombre_Banco_12", .txtRutRepBco1, Trim(Mid(BacContratoSwap.cmbRepBco1.Text, 1, 60)), gsc_Parametros.direccion, gsc_Parametros.telefono, gsc_Parametros.fax, (BacFormatoRut(gsc_Parametros.Rut & "-" & gsc_Parametros.digrut)), .txtEntidad.Caption)
      Call FIRMAS(Doc2, "Nombre_Cliente_14", .txtRutRepBco2, Trim(Mid(BacContratoSwap.cmbRepBco2.Text, 1, 60)), gsc_Parametros.direccion, gsc_Parametros.telefono, gsc_Parametros.fax, (BacFormatoRut(gsc_Parametros.Rut & "-" & gsc_Parametros.digrut)), .txtEntidad.Caption)
    End With
    
    Dim telefonocli  As String
    Dim FaxCli       As String
    Dim RutCli       As String
    
    telefonocli = DatosCond(17)
    FaxCli = DatosCond(18)
    RutCli = DatosCond(7)
    
   If Len(BacContratoSwap.cmbRepCliente1.Text) <> 0 And Len(BacContratoSwap.cmbRepCliente2.Text) = 0 Or Len(BacContratoSwap.cmbRepCliente1.Text) <> 0 And Len(BacContratoSwap.cmbRepCliente2.Text) <> 0 Then
      With BacContratoSwap
         FIRMAS Doc2, "pp_cli", .txtRutRepCli1, Trim(Left(BacContratoSwap.cmbRepCliente1, Len(BacContratoSwap.cmbRepCliente1) - 15)), .txtDirecCli, telefonocli, FaxCli, RutCli, .txtCliente.Caption

         Doc2.Bookmarks("Apoderado1_Cliente_8").Select
         Doc2.Application.Selection.Text = "Don " & Trim(Left(BacContratoSwap.cmbRepCliente1, Len(BacContratoSwap.cmbRepCliente1) - 15))
      End With
                                                                            
      If Len(BacContratoSwap.cmbRepCliente2.Text) <> 0 Then
         With BacContratoSwap
            FIRMAS Doc2, "pp_cli1", .txtRutRepCli2, Trim(Left(BacContratoSwap.cmbRepCliente2, Len(BacContratoSwap.cmbRepCliente2) - 15)), .txtDirecCli, telefonocli, FaxCli, RutCli, .txtCliente.Caption '(BacFormatoRut(.Txt_RutCli2.Text & "-" & .Txt_Digcli2.Text)), .Cmb_ApoCli2.Text, gsDireccion, telefonocli, faxcli, (BacFormatoRut(gsCodigo & "-" & gsDigito)), cliente.clnombre
            
            Doc2.Bookmarks("apod_cli").Select
            Doc2.Application.Selection.Text = "y don " & Trim(Left(BacContratoSwap.cmbRepCliente2, Len(BacContratoSwap.cmbRepCliente2) - 15))
         End With
      End If
   ElseIf Len(BacContratoSwap.cmbRepCliente2.Text) = 0 And Len(BacContratoSwap.cmbRepCliente2.Text) <> 0 Then
      With BacContratoSwap
         FIRMAS Doc2, "pp_cli1", .txtRutRepCli2, Trim(Left(BacContratoSwap.cmbRepCliente2, Len(BacContratoSwap.cmbRepCliente2) - 15)), .txtDirecCli, telefonocli, FaxCli, RutCli, .txtCliente.Caption
          
         Doc2.Bookmarks("apod_cli").Select
         Doc2.Application.Selection.Text = "Don " & Trim(Left(BacContratoSwap.cmbRepCliente2, Len(BacContratoSwap.cmbRepCliente2) - 15))
      End With
   End If
    
'    Doc2.Bookmarks("Dia").Select
'    Doc2.Application.Selection.Text = DatosCond(12)
'    Doc2.Bookmarks("Mes").Select
'    Doc2.Application.Selection.Text = DatosCond(13)
'    Doc2.Bookmarks("Año").Select
'    Doc2.Application.Selection.Text = DatosCond(14)
'
'    Doc2.Bookmarks("NomBco").Select
'    Doc2.Application.Selection.Text = DatosCond(1)
'    Doc2.Bookmarks("RutBco").Select
'    Doc2.Application.Selection.Text = DatosCond(2)
'    Doc2.Bookmarks("RepBco").Select
'    Doc2.Application.Selection.Text = DatosCond(3)
'
'   If Len(Trim(DatosCond(21))) > 0 Then
'    Doc2.Bookmarks("RutRepBco").Select
'    Doc2.Application.Selection.Text = DatosCond(4) & " y don " & DatosCond(21) & " cédula de identidad N° " & DatosCond(22)
'
'   Else
'    Doc2.Bookmarks("RutRepBco").Select
'    Doc2.Application.Selection.Text = DatosCond(4)
'
'   End If
'
'    Doc2.Bookmarks("DireccBco").Select
'    Doc2.Application.Selection.Text = DatosCond(5)
'    Doc2.Bookmarks("NomBco1").Select
'    Doc2.Application.Selection.Text = DatosCond(1)
'    Doc2.Bookmarks("NomCli").Select
'    Doc2.Application.Selection.Text = DatosCond(6)
'    Doc2.Bookmarks("RutCli").Select
'    Doc2.Application.Selection.Text = DatosCond(7)
'    Doc2.Bookmarks("RepCli").Select
'    Doc2.Application.Selection.Text = DatosCond(8)
'
'   If Len(Trim(DatosCond(23))) > 0 Then
'    Doc2.Bookmarks("RutRepCli").Select
'    Doc2.Application.Selection.Text = DatosCond(9) & " y don " & DatosCond(23) & " cédula de identidad N° " & DatosCond(24)
'   Else
'    Doc2.Bookmarks("RutRepCli").Select
'    Doc2.Application.Selection.Text = DatosCond(9)
'   End If
'    Doc2.Bookmarks("DireccCli").Select
'    Doc2.Application.Selection.Text = DatosCond(10)
'    Doc2.Bookmarks("NomCli1").Select
'    Doc2.Application.Selection.Text = DatosCond(6)
'
'    Doc2.Bookmarks("DiaCond").Select
'    Doc2.Application.Selection.Text = DatosCond(31)
'    Doc2.Bookmarks("MesCond").Select
'    Doc2.Application.Selection.Text = DatosCond(32)
'    Doc2.Bookmarks("AñoCond").Select
'    Doc2.Application.Selection.Text = DatosCond(33)
'
    
    Doc2.Bookmarks("NomBco3").Select
    Doc2.Application.Selection.Text = DatosCond(1)
    Doc2.Bookmarks("NomCli3").Select
    Doc2.Application.Selection.Text = DatosCond(6)

    Doc2.Bookmarks("CambioRef").Select
    Doc2.Application.Selection.Text = "N/A"
    Doc2.Bookmarks("ParidadRef").Select
    Doc2.Application.Selection.Text = "N/A"

    Doc2.Bookmarks("Lugar").Select
    Doc2.Application.Selection.Text = "SANTIAGO"
    
    Doc2.Bookmarks("FechaIni").Select
    Doc2.Application.Selection.Text = DatosCond(27)

'    Doc2.Bookmarks("NomBco4").Select
'    Doc2.Application.Selection.Text = DatosCond(1)
'    Doc2.Bookmarks("NomCli4").Select
'    Doc2.Application.Selection.Text = DatosCond(6)
'
    contadorlineas = 1
    A = 1
ReDim Preserve Contrato(43, 1)
    For i = 1 To 43
        Contrato(i, 1) = "**"
    Next

   'SQL = "EXECUTE SP_DATOSCONTRATO " & NumOper
   SQL = "EXECUTE SP_DATOSCONTRATO_TODOSFLUJOS " & NumOper
   If MISQL.SQL_Execute(SQL$) = 0 Then
       i = 1
       While MISQL.SQL_Fetch(Datos()) = 0
            ReDim Preserve Contrato(43, i)
            Contrato(1, i) = Datos(1)   'Tipo_operacion
            Contrato(2, i) = Datos(2)   'MontoOperacion
            Contrato(3, i) = Datos(3)   'TasaConversion
            Contrato(4, i) = Datos(4)   'Modalidad
            Contrato(5, i) = Datos(5)   'fechainicioflujo
            Contrato(6, i) = Datos(6)   'fechavenceflujo
            Contrato(7, i) = Datos(7)   'dias
            Contrato(8, i) = BacStrTran((Datos(8)), ".", gsc_PuntoDecim)    'compra_valor_tasa
            Contrato(9, i) = BacStrTran((Datos(9)), ".", gsc_PuntoDecim)    'venta_valor_tasa
            Contrato(10, i) = Datos(10) 'nombretasacompra
            Contrato(11, i) = Datos(11) 'nombretasaventa
            Contrato(12, i) = Datos(12) 'pagamosdoc
            Contrato(13, i) = Datos(13) 'recibimosdoc
            Contrato(14, i) = Datos(14) 'numero_flujo
            Contrato(15, i) = BacStrTran((Datos(15)), ".", gsc_PuntoDecim)  'compra_capital
            Contrato(16, i) = BacStrTran((Datos(16)), ".", gsc_PuntoDecim)  'compra_amortiza
            Contrato(17, i) = BacStrTran((Datos(17)), ".", gsc_PuntoDecim)  'compra_saldo
            Contrato(17, i) = CDbl(Contrato(16, i)) + CDbl(Contrato(17, i))
            Contrato(18, i) = Datos(18) 'compra_interes
            Contrato(19, i) = Datos(19) 'compra_spread
            Contrato(20, i) = Datos(20) 'venta_capital
            Contrato(21, i) = BacStrTran((Datos(21)), ".", gsc_PuntoDecim)  'venta_amortiza
            Contrato(22, i) = BacStrTran((Datos(22)), ".", gsc_PuntoDecim)  'venta_saldo
            Contrato(22, i) = CDbl(Contrato(21, i)) + CDbl(Contrato(22, i))
            Contrato(23, i) = Datos(23) 'venta_interes
            Contrato(24, i) = Datos(24) 'venta_spread
            Contrato(25, i) = Datos(25) 'pagamos_moneda
            Contrato(26, i) = Datos(26) 'recibimos_moneda
            Contrato(27, i) = Datos(27) 'tipo_flujo
            Contrato(28, i) = Datos(28) 'Compra_Moneda
            Contrato(29, i) = Datos(29) 'Venta_Moneda
            Contrato(30, i) = Datos(30) 'Compra_Capital
            Contrato(31, i) = Datos(31) 'Venta_Capital
            Contrato(32, i) = Datos(32) 'nemo_compra_moneda
            Contrato(33, i) = Datos(33) 'nemo_venta_moneda
            Contrato(34, i) = Datos(34) 'valuta
            Contrato(35, i) = Datos(35) 'Estado_Flujo
            Contrato(36, i) = Datos(36) 'Amortiza
            Contrato(37, i) = Datos(37) 'Fecha Fijación Tasa
            Contrato(38, i) = Datos(38) 'Fecha Liquidación
            Contrato(39, i) = Datos(39) 'nemo_Pagamos_moneda
            Contrato(40, i) = Datos(40) 'nemo_Recibimos_moneda
            Contrato(41, i) = Datos(41) 'TituloModComp, para cuando la modalidad es Compensación
            Contrato(42, i) = Datos(42) 'TituloModEF_1, para cuando la modalidad es Entrega Física
            Contrato(43, i) = Datos(43) 'TituloModEF_2, para cuando la modalidad es Entrega Física continuación
            
            

            
''              If i = 1 Then
            If Contrato(35, i) = 1 Then
                If Contrato(27, i) = 1 Then
                    Doc2.Bookmarks("NomBco2").Select
                    Doc2.Application.Selection.Text = DatosCond(1) & ":   " & NemoMon & " " & Format(Datos(15), "###,###,###,##0.###0") ' Format(DatosCond(30), "###,###,###,##0.###0")
                Else
                    Doc2.Bookmarks("NomCli2").Select
                    Doc2.Application.Selection.Text = DatosCond(6) & ":   " & NemoMon & " " & Format(Datos(20), "###,###,###,##0.###0") ' Format(DatosCond(30), "###,###,###,##0.###0")
                End If
                

            End If
''              End If
            i = i + 1
       Wend
       i = i - 1
    Else
        MsgBox "Datos necesarios para generar Contrato no han sido encontrados !!", vbCritical, Msj
        Set Doc2 = Nothing
        Exit Function
    
    End If
    total = i
    '******
    
    Doc2.Bookmarks("ValutaPago").Select
    Doc2.Application.Selection.Text = "T + " & Datos(34) '"N/A"
                
    If Contrato(36, i) <> "" Then
        Doc2.Bookmarks("InterNoc").Select
        Doc2.Application.Selection.Text = Contrato(36, i)
    End If

    Doc2.Bookmarks("FechaVenc").Select
    Doc2.Application.Selection.Text = Contrato(6, i)

    Doc2.Bookmarks("FormaPago").Select
    Doc2.Application.Selection.Text = "MONEDA NACIONAL: " & IIf((Contrato(12, i) <> ""), (Contrato(12, i)), "N/A")
    
    Doc2.Bookmarks("FormaPago2").Select
    Doc2.Application.Selection.Text = "MONEDA EXTRANJERA: " & IIf((Contrato(13, i) <> ""), (Contrato(13, i)), "N/A")

    If Contrato(1, 1) = "C" Then
        Glosa = Contrato(11, 1)
    Else
        Glosa = Contrato(10, 1)
    End If

    If Datos(7) >= 30 And Datos(7) < 41 Then
        Glosa = Glosa & " 30 DIAS"
    ElseIf Datos(7) >= 90 And Datos(7) < 101 Then
        Glosa = Glosa & " 90 DIAS"
    ElseIf Datos(7) >= 180 And Datos(7) < 191 Then
        Glosa = Glosa & " 180 DIAS"
    ElseIf Datos(7) >= 360 Then
        Glosa = Glosa & " 360 DIAS"
    End If
    Doc2.Application.Visible = True
    For m = 1 To total
'
        If Contrato(27, m) = 2 And Contrato(14, m) = 1 Then
            Doc2.Bookmarks("TasaBco").Select

            If Contrato(11, m) = "FIJA" Then
                Doc2.Application.Selection.Text = Format(Contrato(9, m), "###0.###0") & " % "
                Doc2.Bookmarks("FijaVarBco").Select
                Doc2.Application.Selection.Text = Contrato(11, m)

            Else
                Doc2.Application.Selection.Text = Contrato(11, m) & " + " & Format(Contrato(24, m), "###0.###0") & " %"
                Doc2.Bookmarks("FijaVarBco").Select
                Doc2.Application.Selection.Text = Contrato(11, m) & " + SPREAD"

            End If

        End If

        If Contrato(27, m) = 1 And Contrato(14, m) = 1 Then
            Doc2.Bookmarks("TasaCli").Select

            If Contrato(10, m) = "FIJA" Then
                Doc2.Application.Selection.Text = Format(Contrato(8, m), "###0.###0") & " % "
                Doc2.Bookmarks("FijaVarCli").Select
                Doc2.Application.Selection.Text = Contrato(10, m)

            Else
                Doc2.Application.Selection.Text = Contrato(10, m) & " + " & Format(Contrato(19, m), "###0.###0") & " %"
                Doc2.Bookmarks("FijaVarCli").Select
                Doc2.Application.Selection.Text = Contrato(10, m) & " + SPREAD"

            End If

        End If


    Next

    Doc2.Application.Visible = True

    'Grilla Recibimos
   For m = 1 To total
      Doc2.Bookmarks("GrillaCli").Select
      If contadorlineas >= 1 And Contrato(27, m) = 1 Then
         Doc2.Application.Selection.MoveDown Unit:=wdLine, Count:=(A - 1)
         Doc2.Bookmarks.Add Name:="Prueba", Range:=Doc2.Application.Selection.Range
         Doc2.Bookmarks("Prueba").Select
         A = A + 1
      End If
      If Contrato(27, m) = 1 Then
         Doc2.Application.Selection.Text = Contrato(37, m)
         Doc2.Application.Selection.MoveRight Unit:=wdCell
         Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
         
         Doc2.Application.Selection.Text = Contrato(5, m)
         Doc2.Application.Selection.MoveRight Unit:=wdCell
         Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
   
         Doc2.Application.Selection.Text = Contrato(38, m)
         Doc2.Application.Selection.MoveRight Unit:=wdCell
         Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
   
         Doc2.Application.Selection.Text = Contrato(7, m)
         Doc2.Application.Selection.MoveRight Unit:=wdCell
         Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphCenter
   
         Doc2.Application.Selection.Text = NemoMon & " " & Format((Contrato(17, m)), "###,###,###,##0.###0")
         Doc2.Application.Selection.MoveRight Unit:=wdCell
         Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphCenter
   
         Doc2.Application.Selection.Text = NemoMon & " " & Format((Contrato(16, m)), "###,###,###,##0.###0")
         Doc2.Application.Selection.MoveRight Unit:=wdCell
         Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft

         If Contrato(10, m) = "FIJA" Or Contrato(14, m) = 1 Then
            Doc2.Application.Selection.Text = Contrato(8, m) & " % "
            Doc2.Application.Selection.MoveRight Unit:=wdCell
            Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
         Else
            Doc2.Application.Selection.Text = Contrato(10, m) & " + " & Format(Contrato(19, m), "###0.###0") & " %"
            Doc2.Application.Selection.MoveRight Unit:=wdCell
            Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
         End If
         contadorlineas = contadorlineas + 1
      End If
   Next
   
    '*****
'    Doc2.Bookmarks("NomBco5").Select
'    Doc2.Application.Selection.Text = DatosCond(1)
'    Doc2.Bookmarks("NomCli5").Select
'    Doc2.Application.Selection.Text = DatosCond(6)

    contadorlineas = 1
    A = 1

    'Grilla Pagamos
    For m = 1 To total
        Doc2.Bookmarks("Grilla").Select

        If contadorlineas >= 1 And Contrato(27, m) = 2 Then
            Doc2.Application.Selection.MoveDown Unit:=wdLine, Count:=(A - 1)
            Doc2.Bookmarks.Add Name:="Prueba", Range:=Doc2.Application.Selection.Range
            Doc2.Bookmarks("Prueba").Select
            A = A + 1
        End If

        If Contrato(27, m) = 2 Then
           Doc2.Application.Selection.Text = Contrato(37, m)
           Doc2.Application.Selection.MoveRight Unit:=wdCell
           Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
           
           Doc2.Application.Selection.Text = Contrato(5, m)
           Doc2.Application.Selection.MoveRight Unit:=wdCell
           Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
           
           Doc2.Application.Selection.Text = Contrato(38, m)
           Doc2.Application.Selection.MoveRight Unit:=wdCell
           Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft

           Doc2.Application.Selection.Text = Contrato(7, m)
           Doc2.Application.Selection.MoveRight Unit:=wdCell
           Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphCenter

           Doc2.Application.Selection.Text = NemoMon & " " & Format((Contrato(22, m)), "###,###,###,##0.###0")
           Doc2.Application.Selection.MoveRight Unit:=wdCell
           Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphCenter

           Doc2.Application.Selection.Text = NemoMon & " " & Format((Contrato(21, m)), "###,###,###,##0.###0")
           Doc2.Application.Selection.MoveRight Unit:=wdCell
           Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft

           If Contrato(11, m) = "FIJA" Or Contrato(14, m) = 1 Then
                Doc2.Application.Selection.Text = Contrato(9, m) & " % "
                Doc2.Application.Selection.MoveRight Unit:=wdCell
                Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft

           Else
                Doc2.Application.Selection.Text = Contrato(11, m) & " + " & Format(Contrato(24, m), "###0.###0") & " %"
                Doc2.Application.Selection.MoveRight Unit:=wdCell
                Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft

           End If

            contadorlineas = contadorlineas + 1

        End If

    Next

    Doc2.Bookmarks("ModalidadPago").Select
    Doc2.Application.Selection.Text = Contrato(4, 1)
    
    If Contrato(4, i) <> "COMPENSACION" Then
        Doc2.Bookmarks("FraseNemoMonMod").Select
        Doc2.Application.Selection.Text = Datos(42) & " " & Datos(39) & Datos(43) & " " & Datos(40)
    Else
        Doc2.Bookmarks("FraseNemoMonMod").Select
        Doc2.Application.Selection.Text = Datos(41) & " " & Datos(39)
    End If
    
    
'
'    Doc2.Bookmarks("NomBco6").Select
'    Doc2.Application.Selection.Text = DatosCond(3)
'    Doc2.Bookmarks("RutRep6").Select
'    Doc2.Application.Selection.Text = DatosCond(4)
'
'    Doc2.Bookmarks("RepCli6").Select
'    Doc2.Application.Selection.Text = DatosCond(8)
'    Doc2.Bookmarks("RutCli6").Select
'    Doc2.Application.Selection.Text = DatosCond(9)
'
'    Doc2.Bookmarks("RepBco7").Select
'    Doc2.Application.Selection.Text = DatosCond(21)
'    Doc2.Bookmarks("RutRep7").Select
'    Doc2.Application.Selection.Text = DatosCond(22)
'
'    Doc2.Bookmarks("RepCli7").Select
'    Doc2.Application.Selection.Text = DatosCond(23)
'    Doc2.Bookmarks("RutCli7").Select
'    Doc2.Application.Selection.Text = DatosCond(24)
'
'    Doc2.Bookmarks("NomBcoFir1").Select
'    Doc2.Application.Selection.Text = DatosCond(1)
'    Doc2.Bookmarks("NomBcoFir2").Select
'    Doc2.Application.Selection.Text = DatosCond(1)
'    Doc2.Bookmarks("NomCliFir1").Select
'    Doc2.Application.Selection.Text = DatosCond(6)
'    Doc2.Bookmarks("NomCliFir2").Select
'    Doc2.Application.Selection.Text = DatosCond(6)
'
'
'    ActiveDocument.SaveAs FileName:=DatosCond(20) & "\Contrato Swap de Tasas " & DatosCond(6) & ".doc"
'
    If Donde = "Impresora" Then
        ActiveDocument.PrintOut
    Else
        Doc2.Application.Visible = True
         Doc2.Application.WindowState = wdWindowStateMaximize
    End If
    
 Set Doc2 = Nothing

Exit Function

Control:
    Resume
    MsgBox "Problemas para crear Contrato!!. " & err.Description, vbInformation, Msj
    Set Doc2 = Nothing
End Function

Public Function FuentesImpresora()
Printer.PaperSize = 1
Printer.FontName = "Courier New"
Printer.FontSize = 10
Printer.Font = "Courier New"
End Function

Public Function Func_Busca_Valores_Avales(nPocisionMatriz As Long, cCodigo_Concepto As String, MatrizAvales()) As String
   Dim nContador  As Integer
   
   Func_Busca_Valores_Avales = cCodigo_Concepto
  
   Select Case cCodigo_Concepto
      Case "NMC017"  'CI Aval
         Func_Busca_Valores_Avales = Format$(Trim(CStr(MatrizAvales(3, nPocisionMatriz))), "#,##0") + "-" + Trim(CStr(MatrizAvales(4, nPocisionMatriz)))
      Case "NMC018"  'Nombre Aval
         Func_Busca_Valores_Avales = Trim(CStr(MatrizAvales(5, nPocisionMatriz)))
      Case "NMC019"  'Regimen Conyugal
         For nContador = 1 To UBound(MatrizEstadoCivil, 1)
            If MatrizEstadoCivil(nContador, 1) = Trim(CStr(MatrizAvales(17, nPocisionMatriz))) Then
               Func_Busca_Valores_Avales = MatrizEstadoCivil(nContador, 2)
            End If
         Next nContador
      Case "NMC020"  'Profesion Aval
         Func_Busca_Valores_Avales = Trim(CStr(MatrizAvales(7, nPocisionMatriz)))
      Case "NMC021"  'Direccion Aval
         Func_Busca_Valores_Avales = Trim(CStr(MatrizAvales(8, nPocisionMatriz)))
      Case "NMC022"  'Comuna Aval
         Func_Busca_Valores_Avales = Trim(CStr(MatrizAvales(9, nPocisionMatriz)))
      Case "NMC023"  'Ciudad Aval
         Func_Busca_Valores_Avales = Trim(CStr(MatrizAvales(10, nPocisionMatriz)))
      Case "NMC024"  'Razon Social
         Func_Busca_Valores_Avales = Trim(CStr(MatrizAvales(6, nPocisionMatriz)))
      Case "NMC025"  'Nombre apoderado Aval 1
         Func_Busca_Valores_Avales = Trim(CStr(MatrizAvales(13, nPocisionMatriz)))
      Case "NMC026"  'CI apoderado aval 1
         Func_Busca_Valores_Avales = Format$(Trim(CStr(MatrizAvales(11, nPocisionMatriz))), "#,##0") + "-" + Trim(CStr(MatrizAvales(12, nPocisionMatriz)))
      Case "NMC027"  'Nombre apoderado aval 2
         Func_Busca_Valores_Avales = Trim(CStr(MatrizAvales(16, nPocisionMatriz)))
      Case "NMC028"  'CI apoderado aval 2
         Func_Busca_Valores_Avales = Format$(Trim(CStr(MatrizAvales(14, nPocisionMatriz))), "#,##0") + "-" + Trim(CStr(MatrizAvales(15, nPocisionMatriz)))
      Case "NMC029"  'Nombre Conyuge Aval
         Func_Busca_Valores_Avales = Trim(CStr(MatrizAvales(20, nPocisionMatriz)))
      Case "NMC030"  'Profesion conyuge aval
         Func_Busca_Valores_Avales = Trim(CStr(MatrizAvales(21, nPocisionMatriz)))
      Case "NMC031"  'Ci Conyuge Aval
         Func_Busca_Valores_Avales = Format$(Trim(CStr(MatrizAvales(18, nPocisionMatriz))), "#,##0") + "-" + Trim(CStr(MatrizAvales(19, nPocisionMatriz)))
   End Select
   
End Function

Function Func_Busca_Valores_Contrato(cCodigo_Concepto As String, cConceptoImpresion As String) As Variant

   Func_Busca_Valores_Contrato = cCodigo_Concepto

   Select Case cCodigo_Concepto
      Case "NMC001" ' Día de Proceso
         Func_Busca_Valores_Contrato = Day(gsBAC_Fecp)
      Case "NMC002" ' Mes de Proceso
         Func_Busca_Valores_Contrato = UCase(BacMesStr(Month(gsBAC_Fecp)))
      Case "NMC003" ' Año de Proceso
         Func_Busca_Valores_Contrato = Year(gsBAC_Fecp)
         
      Case "NMC004" ' Nombre Corp. Apoderado1
         Func_Busca_Valores_Contrato = ArregloDatosBasicos(ColsDatosBasicos.ApoderadoBco1)
      Case "NMC005" ' C.I. Corp. Apoderado1
         Func_Busca_Valores_Contrato = Format$(Mid(ArregloDatosBasicos(ColsDatosBasicos.RutApoderadoBco1), 1, Len(ArregloDatosBasicos(ColsDatosBasicos.RutApoderadoBco1)) - 2), "#,##0") & Right(ArregloDatosBasicos(ColsDatosBasicos.RutApoderadoBco1), 2)
      Case "NMC006" ' Nombre Corp. Apoderado2
         Func_Busca_Valores_Contrato = ArregloDatosBasicos(ColsDatosBasicos.ApoderadoBco2)
      Case "NMC007" ' C.I. Corp.  Apoderado2
         Func_Busca_Valores_Contrato = Format$(Mid(ArregloDatosBasicos(ColsDatosBasicos.RutApoderadoBco2), 1, Len(ArregloDatosBasicos(ColsDatosBasicos.RutApoderadoBco2)) - 2), "#,##0") & Right(ArregloDatosBasicos(ColsDatosBasicos.RutApoderadoBco2), 2)
      Case "NMC008" ' Razon Social Cliente
         Func_Busca_Valores_Contrato = ArregloDatosBasicos(ColsDatosBasicos.NombreCli)
      Case "NMC009" ' R.U.T. Cliente
         ''''Func_Busca_Valores_Contrato = Format$(Mid(ArregloDatosBasicos(ColsDatosBasicos.RutCli), 1, Len(ArregloDatosBasicos(ColsDatosBasicos.RutCli)) - 2), "#,##0") & Right(ArregloDatosBasicos(ColsDatosBasicos.RutCli), 2)
         Func_Busca_Valores_Contrato = Format$(ArregloDatosBasicos(ColsDatosBasicos.RutCli), "#,##0") & "-" & BacCheckRut(Str(ArregloDatosBasicos(ColsDatosBasicos.RutCli)))
      Case "NMC010" ' Nombre Apoderado Cliente 1
         Func_Busca_Valores_Contrato = ArregloDatosBasicos(ColsDatosBasicos.ApoderadoCli1)
      Case "NMC011" ' C.I. Apoderado Cliente 1
         Func_Busca_Valores_Contrato = Format$(Mid(ArregloDatosBasicos(ColsDatosBasicos.RutApoderadoCli1), 1, Len(ArregloDatosBasicos(ColsDatosBasicos.RutApoderadoCli1)) - 2), "#,##0") & Right(ArregloDatosBasicos(ColsDatosBasicos.RutApoderadoCli1), 2)
      Case "NMC012" ' Nombre Apoderado Cliente 2
         Func_Busca_Valores_Contrato = ArregloDatosBasicos(ColsDatosBasicos.ApoderadoCli2)
      Case "NMC013" ' C.I. Apoderado Cliente 2
         Func_Busca_Valores_Contrato = Format$(Mid(ArregloDatosBasicos(ColsDatosBasicos.RutApoderadoCli2), 1, Len(ArregloDatosBasicos(ColsDatosBasicos.RutApoderadoCli2)) - 2), "#,##0") & Right(ArregloDatosBasicos(ColsDatosBasicos.RutApoderadoCli2), 2)
      Case "NMC014" ' Dirección Cliente
         Func_Busca_Valores_Contrato = ArregloDatosBasicos(ColsDatosBasicos.DireccionCli)
      Case "NMC015" ' Comuna  Cliente
         Func_Busca_Valores_Contrato = ArregloDatosBasicos(ColsDatosBasicos.ComunaCli)
      Case "NMC016" ' Ciudad Cliente
         Func_Busca_Valores_Contrato = ArregloDatosBasicos(ColsDatosBasicos.CiudadCli)
      Case "NMC017" ' Fecha Antiguo Ccg
         Func_Busca_Valores_Contrato = Trim(Strings.Split(Format(ArregloDatosBasicos(ColsDatosBasicos.FechaAntiguoCcg), "Long Date"), ",")(1))
      Case "NMC018" ' Fecha Antiguo Ccg
         Func_Busca_Valores_Contrato = Trim(Strings.Split(Format(ArregloDatosBasicos(ColsDatosBasicos.FechaNuevoCcg), "Long Date"), ",")(1))
         
      Case "NMC032" ' Fecha Escritura
         Func_Busca_Valores_Contrato = ArregloDatosBasicos(ColsDatosBasicos.FechaEscritura)
      Case "NMC033" ' Notaria Cliente
         Func_Busca_Valores_Contrato = ArregloDatosBasicos(ColsDatosBasicos.NotariaCli)
      Case "NMC034" ' Fono Cliente
         Func_Busca_Valores_Contrato = ArregloDatosBasicos(ColsDatosBasicos.FonoCli)
      Case "NMC035" ' Fax Cliente
         Func_Busca_Valores_Contrato = ArregloDatosBasicos(ColsDatosBasicos.FaxCli)

   End Select
   
   If Func_Busca_Valores_Contrato = "" Then
      Func_Busca_Valores_Contrato = "VALOR NO ENCONTRADO"
   End If
   
   
End Function

Function Func_Completa_Glosa(cTipo_Contrato As String, cCod_Clausula As String, ByVal oContratoWord As Word.Document, MatrizAvales(), MatrizSeleccionados(), cConceptoImpresion As String) As Boolean
   On Error GoTo Control_Error
   
   Func_Completa_Glosa = False

   Dim Envia()
   Dim Datos()
   Dim ArregloGlosas()
   Dim cGlosa           As String
   Dim cGlosa2          As String
   Dim bLlevaAvales     As Boolean
   Dim nLargo_Glosa     As Long
   Dim nContador        As Long
   Dim ncontador2       As Long
   Dim nContador3       As Long
   Dim nCantidad        As Long
   Dim nCantidad2       As Long
   Dim cCodigo_Concepto As String
   Dim nValor_Retorno   As String
   Dim cMarcador        As String
   Dim cGlosaOriginal   As String
   Dim nUltimaPocision  As Long
   Dim nPocisionMatriz  As Long
   Dim bAvalPrimerParrafo  As Boolean
   Dim bLleva_Avales_Pie   As Boolean
    
   Envia = Array()
   AddParam Envia, "PCS"
   AddParam Envia, cTipo_Contrato
   AddParam Envia, cCod_Clausula
   
   If Not Bac_Sql_Execute("BACPARAMSUDA..SP_CON_CLAUSULA_CONTRATO_DINAMICO", Envia) Then
      Screen.MousePointer = vbDefault
      Exit Function
   End If
   
   Erase ArregloGlosas
   
   nCantidad = 0
   nCantidad2 = UBound(MatrizSeleccionados, 2)
   
   Do While Bac_SQL_Fetch(Datos())
      For nContador = 1 To nCantidad2
         If Trim(Datos(3)) = MatrizSeleccionados(5, nContador) Then 'compara codigos, si existe en la matriz es porque tiene permiso

            nCantidad = nCantidad + 1
            ReDim Preserve ArregloGlosas(4, nCantidad)
      
            ArregloGlosas(1, nCantidad) = Trim(Datos(5)) 'Glosa
            ArregloGlosas(2, nCantidad) = Trim(Datos(6)) 'Marcador
            ArregloGlosas(3, nCantidad) = Trim(Datos(3)) 'Codigo Clausula
            ArregloGlosas(4, nCantidad) = Trim(Datos(9)) 'Tiene Avales
            Exit For
         End If
      Next nContador
   Loop
 
   cMarcador = ""
   cGlosa = ""
   cGlosa2 = ""
   bLlevaAvales = False
   bAvalPrimerParrafo = False
   bLleva_Avales_Pie = False
      
   For nContador = 1 To nCantidad
      If cMarcador <> ArregloGlosas(2, nContador) And cMarcador <> "" Then
      
         oContratoWord.Bookmarks.Item(cMarcador).Range.Text = cGlosa
         cGlosa = ""
         
         cGlosa2 = ArregloGlosas(1, nContador)    'Glosas
         cMarcador = ArregloGlosas(2, nContador) 'Marcador
         bLlevaAvales = IIf(ArregloGlosas(4, nContador) = "S", True, False)
         
         GoSub Llena_Valores_Glosa
         
         If bLlevaAvales = True Then  'Glosa Avales
               bLleva_Avales_Pie = True
               ''''GoSub Llena_Valores_Avales
               cGlosa2 = Func_Llena_Valores_Avales(cGlosa2, "DINAMICO")
               If bAvalPrimerParrafo = False Then
                  oContratoWord.Bookmarks.Item("GlosaAvalPrimera").Range.Text = Func_Llena_Valores_Avales("@AVALES", "FIJA")
                  bAvalPrimerParrafo = True
               End If
               bLlevaAvales = False
         End If
         
         cGlosa = cGlosa2
         
         If nContador = nCantidad Then
            oContratoWord.Bookmarks.Item(cMarcador).Range.Text = cGlosa
         End If
      Else
         
         cGlosa2 = ArregloGlosas(1, nContador) 'Glosas
         cMarcador = ArregloGlosas(2, nContador)                          'Marcador
         bLlevaAvales = IIf(ArregloGlosas(4, nContador) = "S", True, bLlevaAvales)
         
         GoSub Llena_Valores_Glosa
         
         If bLlevaAvales = True Then  'Glosa Avales
            ''''GoSub Llena_Valores_Avales
            bLleva_Avales_Pie = True
            cGlosa2 = Func_Llena_Valores_Avales(cGlosa2, "DINAMICO")
            If bAvalPrimerParrafo = False Then
               oContratoWord.Bookmarks.Item("GlosaAvalPrimera").Range.Text = Func_Llena_Valores_Avales("@AVALES", "FIJA")
               bAvalPrimerParrafo = True
            End If
            
            bLlevaAvales = False
         End If
         
         cGlosa = cGlosa + IIf(cGlosa = "", "", vbCrLf + vbCrLf) + cGlosa2
         
         If nContador = nCantidad Then
            oContratoWord.Bookmarks.Item(cMarcador).Range.Text = cGlosa
         End If
      End If
   Next nContador
   
   ''''GoSub Agrega_avales_Primera_Glosa
   
   
      Call Proc_Inserta_Pie_Avales(cConceptoImpresion, nCuentaAvales, oContratoWord, bLleva_Avales_Pie)
   
   Func_Completa_Glosa = True
   
   Exit Function
      
'*******************************************************************************************************************************
'*******************************************************************************************************************************
'*******************************************************************************************************************************
   
Llena_Valores_Glosa:

   ncontador2 = 1
   nLargo_Glosa = Len(cGlosa2)
   
   Do While ncontador2 <= nLargo_Glosa
      If Mid(cGlosa2, ncontador2, 3) = "NMC" Then
         cCodigo_Concepto = Mid(cGlosa2, ncontador2, 6)
         nValor_Retorno = Func_Busca_Valores_Contrato(cCodigo_Concepto, cConceptoImpresion)
         cGlosa2 = Replace(cGlosa2, cCodigo_Concepto, nValor_Retorno)
         
         nLargo_Glosa = Len(cGlosa2)
         ncontador2 = ncontador2 + 1
      Else
         ncontador2 = ncontador2 + 1
      End If
   Loop
Return
         
'******************************************************************************************************************************
Control_Error:
      
   If err.Number = 5941 Then
      Resume Next
   Else
      Screen.MousePointer = vbDefault
      MsgBox "ERROR N°" & Str(err.Number) & " - " & err.Description, vbCritical + vbOKOnly
   End If

End Function

Function Func_Llena_Valores_Avales(cGlosa As String, cTipoGlosa As String) As String

   Dim cGlosaOriginal      As String
   Dim nUltimaPocision     As Long
   Dim nContador           As Long
   Dim ncontador2          As Long
   Dim nContador3          As Long
   Dim nLargo_Glosa        As Long
   Dim cAvalesJuntos       As String
   Dim bSociedadMarital    As Boolean
   Dim cConyugesJuntos     As String
   Dim cNombreCiudad As String
   Dim cNombreComuna As String
   
   Dim nPosIni             As Long
   Dim nPosFin             As Long
   Dim nCantidadCaracteres As Long
   
   cGlosaOriginal = cGlosa
   nUltimaPocision = 1
   bSociedadMarital = False
   cConyugesJuntos = ""
   cAvalesJuntos = ""
   
   If InStr(1, cGlosa, "@AVALES", vbTextCompare) <> 0 Or InStr(1, cGlosa, "@avales", vbTextCompare) Or UCase(cGlosa) = "@AVALES" Then
      For nContador = 1 To nCuentaAvales
         cAvalesJuntos = cAvalesJuntos & IIf(nContador > 1, ", ", "")
      
         If MatrizAvales(17, nContador) = MatrizEstadoCivil(EstadoCivil.Soltero, 1) Then
            cAvalesJuntos = cAvalesJuntos & "don(ña) " & Trim(MatrizAvales(5, nContador))
            cAvalesJuntos = cAvalesJuntos & ", chileno(a), " & MatrizEstadoCivil(EstadoCivil.Soltero, 2) & ", cédula nacional de identidad N° "
            cAvalesJuntos = cAvalesJuntos & Trim(Format$(MatrizAvales(3, nContador), "#,##0")) & "-" & Trim(MatrizAvales(4, nContador))
         
         ElseIf MatrizAvales(17, nContador) = MatrizEstadoCivil(EstadoCivil.CasadoSB, 1) Then
            cAvalesJuntos = cAvalesJuntos & "don(ña) " & Trim(MatrizAvales(5, nContador)) & ", chileno(a)"
            cAvalesJuntos = cAvalesJuntos & ", " & MatrizEstadoCivil(EstadoCivil.CasadoSB, 2) & ", cédula nacional de identidad N° "
            cAvalesJuntos = cAvalesJuntos & Trim(Format$(MatrizAvales(3, nContador), "#,##0")) & "-" & Trim(MatrizAvales(4, nContador))
            
         ElseIf MatrizAvales(17, nContador) = MatrizEstadoCivil(EstadoCivil.CasadoSC, 1) _
            Or MatrizAvales(17, nContador) = MatrizEstadoCivil(EstadoCivil.CasadoPG, 1) Then
            
            cAvalesJuntos = cAvalesJuntos & "don(ña) " & Trim(MatrizAvales(5, nContador)) & ", chileno(a)"
            
            If MatrizAvales(17, nContador) = MatrizEstadoCivil(EstadoCivil.CasadoSC, 1) Then
               cAvalesJuntos = cAvalesJuntos & ", " & MatrizEstadoCivil(EstadoCivil.CasadoSC, 2) & ", cédula nacional de identidad N° "
            Else
               cAvalesJuntos = cAvalesJuntos & ", " & MatrizEstadoCivil(EstadoCivil.CasadoPG, 2) & ", cédula nacional de identidad N° "
            End If
            
            cAvalesJuntos = cAvalesJuntos & Trim(Format$(MatrizAvales(3, nContador), "#,##0")) & "-" & Trim(MatrizAvales(4, nContador))
            
            cConyugesJuntos = cConyugesJuntos & IIf(cConyugesJuntos <> "", ", ", "") & "don(ña) "
            cConyugesJuntos = cConyugesJuntos & Trim(MatrizAvales(20, nContador))
            cConyugesJuntos = cConyugesJuntos & ", chileno(a), Cédula Nacional de Identidad Nº "
            cConyugesJuntos = cConyugesJuntos & Trim(Format$(MatrizAvales(18, nContador), "#,##0")) + "-" & Trim(MatrizAvales(19, nContador))
            
            If MatrizAvales(17, nContador) = MatrizEstadoCivil(EstadoCivil.CasadoSC, 1) Then
               cConyugesJuntos = cConyugesJuntos & ", " & MatrizEstadoCivil(EstadoCivil.CasadoSC, 2) & " con don(ña) "
            Else
               cConyugesJuntos = cConyugesJuntos & ", " & MatrizEstadoCivil(EstadoCivil.CasadoPG, 2) & " con don(ña) "
            End If
            
            cConyugesJuntos = cConyugesJuntos & Trim(MatrizAvales(5, nContador))
            cConyugesJuntos = cConyugesJuntos & ", precedentemente individualizado, domiciliada en "
            cConyugesJuntos = cConyugesJuntos & Trim(MatrizAvales(8, nContador)) & ", "
            
            bSociedadMarital = True
         
         ElseIf MatrizAvales(17, nContador) = MatrizEstadoCivil(EstadoCivil.NoAplica, 1) Then 'EMPRESAS Y OTROS
            cAvalesJuntos = cAvalesJuntos & IIf(nContador > 1, "y ", "")
            cAvalesJuntos = cAvalesJuntos & Trim(MatrizAvales(6, nContador))
            cAvalesJuntos = cAvalesJuntos & ", Rol Único Tributario N° "
            cAvalesJuntos = cAvalesJuntos & Trim(Format$(MatrizAvales(3, nContador), "#,##0")) + "-" & Trim(MatrizAvales(4, nContador))
            cAvalesJuntos = cAvalesJuntos & ", representada por don(ña) "
            cAvalesJuntos = cAvalesJuntos & Trim(MatrizAvales(13, nContador))
            cAvalesJuntos = cAvalesJuntos & ", cédula nacional de identidad N° "
            cAvalesJuntos = cAvalesJuntos & Trim(Format$(MatrizAvales(11, nContador), "#,##0")) & "-" & Trim(MatrizAvales(12, nContador))
            
            If Trim(MatrizAvales(13, nContador)) <> Trim(MatrizAvales(16, nContador)) And Trim(MatrizAvales(16, nContador)) <> "" Then
               cAvalesJuntos = cAvalesJuntos & ", y don(ña) "
               cAvalesJuntos = cAvalesJuntos & Trim(MatrizAvales(16, nContador))
               cAvalesJuntos = cAvalesJuntos & ", cédula nacional de identidad N° "
               cAvalesJuntos = cAvalesJuntos & Trim(Format$(MatrizAvales(14, nContador), "#,##0")) & "-" & Trim(MatrizAvales(15, nContador)) & ","
            End If
         End If
         
         If UCase(cGlosa) = "@AVALES" Then
         
            cNombreCiudad = "-999"
            cNombreComuna = ""
   
            Call Proc_Busca_Ciudad_Comuna(Trim(MatrizAvales(10, nContador)), Trim(MatrizAvales(9, nContador)), cNombreCiudad, cNombreComuna)
         
            If MatrizAvales(17, nContador) = MatrizEstadoCivil(EstadoCivil.NoAplica, 1) Then 'EMPRESA
               cAvalesJuntos = cAvalesJuntos & " ambos domiciliados en "
            Else
               cAvalesJuntos = cAvalesJuntos & " domiciliado en "
            End If
            
            cAvalesJuntos = cAvalesJuntos & Trim(MatrizAvales(8, nContador))
            cAvalesJuntos = cAvalesJuntos & " , comuna de "
            cAvalesJuntos = cAvalesJuntos & cNombreComuna
            cAvalesJuntos = cAvalesJuntos & " , ciudad de "
            cAvalesJuntos = cAvalesJuntos & cNombreCiudad
         End If
      Next nContador
      
      If cGlosa <> "@AVALES" Then
         If InStr(1, cGlosa, "@AVALES", vbTextCompare) <> 0 Then
            cGlosa = Replace(cGlosa, "@AVALES", cAvalesJuntos, , , vbTextCompare)
         Else
            cGlosa = "      ERROR, VARIABLE @AVALES MAL DEFINIDA EN EL MANTENEDOR DE CLAUSULAS DINAMICAS EN SISTEMA DE PARAMETROS      "
            Exit Function
         End If
         
         nPosIni = 1
         nPosFin = 1
         
         If bSociedadMarital = False Then
            Do While nPosIni <> 0
               nPosIni = InStr(1, cGlosa, "[[")
               nPosFin = InStr(1, cGlosa, "]]")
               
               If (nPosIni > 0 And nPosFin = 0) Or (nPosIni = 0 And nPosFin > 0) Then
                  Screen.MousePointer = vbDefault
                  MsgBox "La omision de la glosa de conyuges para los avales esta mal configurada debido a que no se encontro una de las dos llaves, ejemplo '[[ texto ' , falta la llave ']]' "
                  Exit Do
               End If
               
               If (nPosIni > nPosFin) Then
                  Screen.MousePointer = vbDefault
                  MsgBox "La omision de la glosa de conyuges para los avales esta mal configurada debido a que las llaves se encuentran al revés, ejemplo ']] texto [[' ", vbExclamation + vbOKOnly
                  Exit Do
               End If
                                                               
               If (nPosIni <> 0 And nPosFin <> 0) Then
                  cGlosa = Mid(cGlosa, 1, nPosIni - 1) & Mid(cGlosa, nPosFin + 2)
               End If
            Loop
         ElseIf bSociedadMarital = True Then
            If InStr(1, cGlosa, "@CONYUGE", vbTextCompare) <> 0 Then
               cGlosa = Replace(cGlosa, "@CONYUGE", cConyugesJuntos, , , vbTextCompare)
               cGlosa = Replace(cGlosa, "[[", "", , , vbTextCompare)
               cGlosa = Replace(cGlosa, "]]", "", , , vbTextCompare)
            End If
         End If
      Else
            ''''cAvalesJuntos = cAvalesJuntos & " en adelante el(los) Fiador(es), Codeudor(es) Solidario(s) y Avalista(s), "
            cAvalesJuntos = cAvalesJuntos & " en adelante " & """Garante(s)""" & ", "

         cGlosa = cAvalesJuntos
      End If
   End If
   
   Func_Llena_Valores_Avales = cGlosa

End Function

Public Function IniciaWordListadoLog(Cual, ByRef OK As Boolean) As Word.Document
   Dim wrd
   Dim newRuta
   Dim UbicacionDeDocumentos
    
   On Error GoTo Control:
    
   'PRD-3166.  Determinar si la ruta termina en un slash (\) para sacarlo.
   newRuta = Trim(gsDOC_Path)
   If Right(newRuta, 1) = "\" Then
        newRuta = Mid(newRuta, 1, Len(newRuta) - 1)
   End If
   
   OK = False
   Set wrd = New Word.Application
   
   err.Clear
   
   On Error GoTo 0
    
   If Cual = "Condiciones" Then
      'Set IniciaWordListadoLog = wrd.Documents.Add(gsDOC_Path & "\CGD_2007_Bancos.doc") 'Condiciones Generales.doc
      Set IniciaWordListadoLog = wrd.Documents.Add(newRuta & "\CGD_2007_Bancos.doc") 'Condiciones Generales.doc
      DoEvents
   ElseIf Cual = "Anexo A" Then
      Set IniciaWordListadoLog = wrd.Documents.Add(newRuta & "\Anexo A.doc")
      DoEvents
   ElseIf Cual = "CondicionesNoBanco" Then
      Set IniciaWordListadoLog = wrd.Documents.Add(newRuta & "\CGD_2007_Clientes.doc") 'Condiciones Generales No Banco.doc
      DoEvents
   ElseIf Cual = "ContratoTasasBanco" Then
      Set IniciaWordListadoLog = wrd.Documents.Add(newRuta & "\Swap_Tasa.doc") 'Anexo No 3.doc
      DoEvents
   ElseIf Cual = "ContratoMonedasBanco" Then
      Set IniciaWordListadoLog = wrd.Documents.Add(newRuta & "\swap_moneda.rtf") 'Swap de Monedas.doc
      DoEvents
   ElseIf Cual = "ContratoFRABanco" Then
      Set IniciaWordListadoLog = wrd.Documents.Add(newRuta & "\Contrato FRA.doc ")
      DoEvents
   ElseIf Cual = "ContratoTasasBancoICP" Then
      Set IniciaWordListadoLog = wrd.Documents.Add(newRuta & "\CONTRATO SWAP XCAM ANEXO N 3.rtf") 'ANEXO N°3 ICP.doc
      DoEvents
    ElseIf Cual = "ContratoTasasBancoICP2" Then
      Set IniciaWordListadoLog = wrd.Documents.Add(newRuta & "\CONTRATO SWAP XCAM ANEXO N 8.rtf") 'ANEXO N°3 ICP.doc
      DoEvents
    ElseIf Cual = "ContratoTasasBancaria" Then
      Set IniciaWordListadoLog = wrd.Documents.Add(newRuta & "\swap_tasa_banco.doc") 'ANEXO N°3 ICP.doc
      DoEvents
   End If
    
   OK = True
Exit Function
Control:
   Select Case err
      Case 1
         'MsgBox "Aplicacion WORD no esta Instalada en Pc", vbCritical, Msj
      Case Else
         MsgBox "Ocurrio un evento numero " & err.Number & ". " & err.Description, vbCritical, Msj
   End Select
    Set wrd = Nothing   'PRD-3166
End Function

Function BacContratoSwapTasaBanco(DatosCond(), NumOper, Donde) As Boolean
   On Error GoTo Control:

   Dim Doc2             As Word.Document
   Dim SQL              As String
   Dim contadorlineas
   Dim A, m
   Dim Datos()
   Dim i                As Integer
   Dim total            As Integer
   Dim Contrato()
   Dim NemoMon          As String
   Dim Paso             As String
   Dim Glosa            As String
   Dim Okk              As Boolean
   Dim nombre_archivo   As String

   SQL = giSQL_DatabaseCommon
   SQL = SQL & "..SP_LEER_MONEDA "
   SQL = SQL & DatosCond(29)

   If MISQL.SQL_Execute(SQL) = 0 Then
      If MISQL.SQL_Fetch(Datos()) = 0 Then
         NemoMon = UCase(Datos(2))
      End If
   End If

   Set Doc2 = IniciaWordListadoLog("ContratoTasasBanco", Okk)

   If Not Okk Then
      MsgBox "No podra ser Generado el contrato!", vbCritical, Msj
      BacContratoSwapTasaBanco = False
      Exit Function
   End If

   Dim NombreCliente       As String
   Dim FechaCondiciones    As String

   Let NombreCliente = Trim(BacContratoSwap.grdLista.TextMatrix(BacContratoSwap.grdLista.Row, 2))
   Let FechaCondiciones = BacContratoSwap.grdLista.TextMatrix(BacContratoSwap.grdLista.Row, 12)

   If Year(CDate(FechaCondiciones)) = "1900" Or Len(FechaCondiciones) = 0 Then
      'MsgBox "No se han emitido condiciones generales para el cliente " & vbCrLf & NombreCliente
      'Exit Function
   End If

Imprimir:
    Doc2.Activate
    
    Doc2.Bookmarks("folio").Select
    Doc2.Application.Selection.Text = NumOper
    
    Doc2.Bookmarks("Fecha_Proceso_6").Select
   'Doc2.Application.Selection.Text = BacFormatoFecha("DDMMAA", gsBAC_Fecp)
    Doc2.Application.Selection.Text = DatosCond(12) & " de " & DatosCond(13) & " de " & DatosCond(14)
    
    Let Doc2.ActiveWindow.View.Type = wdPrintView
    
    Doc2.Bookmarks("Nombre_Banco_11").Select
    Doc2.Application.Selection.Text = DatosCond(1)
    
    Doc2.Bookmarks("Rut_Banco_9").Select
    Doc2.Application.Selection.Text = DatosCond(2)
    
    Doc2.Bookmarks("Fecha_Proceso_7").Select 'fecha_condiciones generales
    Doc2.Application.Selection.Text = BacFormatoFecha("DDMMAA", BacContratoSwap.grdLista.TextMatrix(BacContratoSwap.grdLista.Row, 12))
    
    Doc2.Bookmarks("banco6").Select
    Doc2.Application.Selection.Text = DatosCond(1)
    
    With BacContratoSwap
         Call FIRMAS(Doc2, "Nombre_Banco_12", .txtRutRepBco1, Trim(Mid(BacContratoSwap.cmbRepBco1.Text, 1, 60)), gsc_Parametros.direccion, gsc_Parametros.telefono, gsc_Parametros.fax, (BacFormatoRut(gsc_Parametros.Rut & "-" & gsc_Parametros.digrut)), .txtEntidad.Caption)
         Call FIRMAS(Doc2, "Nombre_Cliente_14", .txtRutRepBco2, Trim(Mid(BacContratoSwap.cmbRepBco2.Text, 1, 60)), gsc_Parametros.direccion, gsc_Parametros.telefono, gsc_Parametros.fax, (BacFormatoRut(gsc_Parametros.Rut & "-" & gsc_Parametros.digrut)), .txtEntidad.Caption)
    End With
    
    Dim telefonocli As String
    Dim FaxCli As String
    Dim RutCli As String
    
    telefonocli = DatosCond(17)
    FaxCli = DatosCond(18)
    RutCli = DatosCond(7)
    
    If Len(BacContratoSwap.cmbRepCliente1.Text) <> 0 And Len(BacContratoSwap.cmbRepCliente2.Text) = 0 Or Len(BacContratoSwap.cmbRepCliente1.Text) <> 0 And Len(BacContratoSwap.cmbRepCliente2.Text) <> 0 Then
        With BacContratoSwap
     
         FIRMAS Doc2, "pp_cli", .txtRutRepCli1, Trim(Left(BacContratoSwap.cmbRepCliente1, Len(BacContratoSwap.cmbRepCliente1) - 15)), .txtDirecCli, telefonocli, FaxCli, RutCli, .txtCliente.Caption
         
        End With
                                                                            
           If Len(BacContratoSwap.cmbRepCliente2.Text) <> 0 Then

            With BacContratoSwap
            
            FIRMAS Doc2, "pp_cli1", .txtRutRepCli2, Trim(Left(BacContratoSwap.cmbRepCliente2, Len(BacContratoSwap.cmbRepCliente2) - 15)), .txtDirecCli, telefonocli, FaxCli, RutCli, .txtCliente.Caption '(BacFormatoRut(.Txt_RutCli2.Text & "-" & .Txt_Digcli2.Text)), .Cmb_ApoCli2.Text, gsDireccion, telefonocli, faxcli, (BacFormatoRut(gsCodigo & "-" & gsDigito)), cliente.clnombre
            
            End With
        
            End If
            
          ElseIf Len(BacContratoSwap.cmbRepCliente2.Text) = 0 And Len(BacContratoSwap.cmbRepCliente2.Text) <> 0 Then

        With BacContratoSwap
          FIRMAS Doc2, "pp_cli1", .txtRutRepCli2, Trim(Left(BacContratoSwap.cmbRepCliente2, Len(BacContratoSwap.cmbRepCliente2) - 15)), .txtDirecCli, telefonocli, FaxCli, RutCli, .txtCliente.Caption
          
        End With
          End If
    
    Doc2.Bookmarks("NomBco3").Select
    Doc2.Application.Selection.Text = DatosCond(1)
    Doc2.Bookmarks("NomCli3").Select
    Doc2.Application.Selection.Text = DatosCond(6)

    Doc2.Bookmarks("CambioRef").Select 'ESTA
    Doc2.Application.Selection.Text = "N/A"
    
    Doc2.Bookmarks("ParidadRef").Select 'ESTA
    Doc2.Application.Selection.Text = "N/A"

    Doc2.Bookmarks("Lugar").Select
    Doc2.Application.Selection.Text = "SANTIAGO"

    contadorlineas = 1
    A = 1
     
    'ReDim Preserve Contrato(43, 1) 'PRD-7904
    ReDim Preserve Contrato(45, 1)
    
    'For i = 1 To 43 'PRD-7904
    For i = 1 To 45
        Contrato(i, 1) = "**"
    Next

   'SQL = "EXECUTE SP_DATOSCONTRATO " & NumOper
   SQL = "EXECUTE SP_DATOSCONTRATO_TODOSFLUJOS " & NumOper
   If MISQL.SQL_Execute(SQL$) = 0 Then
       i = 1
       While MISQL.SQL_Fetch(Datos()) = 0
            'ReDim Preserve Contrato(43, i)
            ReDim Preserve Contrato(45, i) 'PRD-7904
            Contrato(1, i) = Datos(1)   'Tipo_operacion
            Contrato(2, i) = Datos(2)   'MontoOperacion
            Contrato(3, i) = Datos(3)   'TasaConversion
            Contrato(4, i) = Datos(4)   'Modalidad
            Contrato(5, i) = Datos(5)   'fechainicioflujo
            Contrato(6, i) = Datos(6)   'fechavenceflujo
            Contrato(7, i) = Datos(7)   'dias
            Contrato(8, i) = BacStrTran((Datos(8)), ".", gsc_PuntoDecim)    'compra_valor_tasa
            Contrato(9, i) = BacStrTran((Datos(9)), ".", gsc_PuntoDecim)    'venta_valor_tasa
            Contrato(10, i) = Datos(10) 'nombretasacompra
            Contrato(11, i) = Datos(11) 'nombretasaventa
            Contrato(12, i) = Datos(12) 'pagamosdoc
            Contrato(13, i) = Datos(13) 'recibimosdoc
            Contrato(14, i) = Datos(14) 'numero_flujo
            Contrato(15, i) = BacStrTran((Datos(15)), ".", gsc_PuntoDecim)  'compra_capital
            Contrato(16, i) = BacStrTran((Datos(16)), ".", gsc_PuntoDecim)  'compra_amortiza
            Contrato(17, i) = BacStrTran((Datos(17)), ".", gsc_PuntoDecim)  'compra_saldo
            Contrato(17, i) = CDbl(Contrato(16, i)) + CDbl(Contrato(17, i))
            Contrato(18, i) = Datos(18) 'compra_interes
            Contrato(19, i) = Datos(19) 'compra_spread
            Contrato(20, i) = Datos(20) 'venta_capital
            Contrato(21, i) = BacStrTran((Datos(21)), ".", gsc_PuntoDecim)  'venta_amortiza
            Contrato(22, i) = BacStrTran((Datos(22)), ".", gsc_PuntoDecim)  'venta_saldo
            Contrato(22, i) = CDbl(Contrato(21, i)) + CDbl(Contrato(22, i))
            Contrato(23, i) = Datos(23) 'venta_interes
            Contrato(24, i) = Datos(24) 'venta_spread
            Contrato(25, i) = Datos(25) 'pagamos_moneda
            Contrato(26, i) = Datos(26) 'recibimos_moneda
            Contrato(27, i) = Datos(27) 'tipo_flujo
            Contrato(28, i) = Datos(28) 'Compra_Moneda
            Contrato(29, i) = Datos(29) 'Venta_Moneda
            Contrato(30, i) = Datos(30) 'Compra_Capital
            Contrato(31, i) = Datos(31) 'Venta_Capital
            Contrato(32, i) = Datos(32) 'nemo_compra_moneda
            Contrato(33, i) = Datos(33) 'nemo_venta_moneda
            Contrato(34, i) = Datos(34) 'valuta
            Contrato(35, i) = Datos(35) 'Estado_Flujo
            Contrato(36, i) = Datos(36) 'Amortiza
            Contrato(37, i) = Datos(37) 'Fecha Fijación Tasa
            Contrato(38, i) = Datos(38) 'Fecha Liquidación
            Contrato(39, i) = Datos(39) 'nemo_Pagamos_moneda
            Contrato(40, i) = Datos(40) 'nemo_Recibimos_moneda
            Contrato(41, i) = Datos(41) 'TituloModComp, para cuando la modalidad es Compensación
            Contrato(42, i) = Datos(42) 'TituloModEF_1, para cuando la modalidad es Entrega Física
            Contrato(43, i) = Datos(43) 'TituloModEF_2, para cuando la modalidad es Entrega Física continuación
           
            Contrato(44, i) = Datos(46) 'CompraGlosaBase PRD-7904
            Contrato(45, i) = Datos(47) 'VentaGlosaBase PRD-7904
           
            If Contrato(35, i) = 1 Then
                If Contrato(27, i) = 1 Then
                    Doc2.Bookmarks("NomBco2").Select
                    Doc2.Application.Selection.Text = DatosCond(1) & ":   " & NemoMon & " " & Format(Datos(15), "###,###,###,##0.###0") ' Format(DatosCond(30), "###,###,###,##0.###0")
                 Else
                    Doc2.Bookmarks("NomCli2").Select
                    Doc2.Application.Selection.Text = DatosCond(6) & ":   " & NemoMon & " " & Format(Datos(20), "###,###,###,##0.###0") 'Format(DatosCond(30), "###,###,###,##0.###0")
                 End If
                 
            End If
            i = i + 1
       Wend
       i = i - 1
    Else
        MsgBox "Datos necesarios para generar Contrato no han sido encontrados !!", vbCritical, Msj
        Set Doc2 = Nothing
        Exit Function
    
    End If
    total = i
    '******
    Doc2.Bookmarks("FechaVenc").Select
    Doc2.Application.Selection.Text = Contrato(6, i)

    
    Doc2.Bookmarks("FormaPago").Select
    Doc2.Application.Selection.Text = "MONEDA NACIONAL: " & IIf((Contrato(12, i) <> ""), (Contrato(12, i)), "N/A")
    
    Doc2.Bookmarks("FormaPago2").Select
    Doc2.Application.Selection.Text = "MONEDA EXTRANJERA: " & IIf((Contrato(13, i) <> ""), (Contrato(13, i)), "N/A")
    
    Doc2.Bookmarks("FechaIni").Select
    Doc2.Application.Selection.Text = DatosCond(27)
    
    Doc2.Bookmarks("ValutaPago").Select 'REVISAR
    Doc2.Application.Selection.Text = "T + " & Datos(34) '"N/A"

    If Datos(36) <> "" Then
        Doc2.Bookmarks("InterNoc").Select
        Doc2.Application.Selection.Text = Datos(36)
    End If
    
    

    If Contrato(1, 1) = "C" Then
        Glosa = Contrato(11, 1)
    Else
        Glosa = Contrato(10, 1)
    End If

    If Datos(7) >= 30 And Datos(7) < 41 Then
        Glosa = Glosa & " 30 DIAS"
    ElseIf Datos(7) >= 90 And Datos(7) < 101 Then
        Glosa = Glosa & " 90 DIAS"
    ElseIf Datos(7) >= 180 And Datos(7) < 191 Then
        Glosa = Glosa & " 180 DIAS"
    ElseIf Datos(7) >= 360 Then
        Glosa = Glosa & " 360 DIAS"
    End If
    Doc2.Application.Visible = True

    For m = 1 To total
        If Contrato(27, m) = 2 And Contrato(35, m) = 1 Then
            Doc2.Bookmarks("TasaBco").Select

            If Contrato(11, m) = "FIJA" Then
                Doc2.Application.Selection.Text = Format(Contrato(9, m), "###0.###0") & " % "
                Doc2.Bookmarks("FijaVarBco").Select
                Doc2.Application.Selection.Text = Contrato(11, m)

                ''PRD-7904
                Doc2.Bookmarks("BaseBco").Select
                Doc2.Application.Selection.Text = "Base Cálculo " & Contrato(45, m)


            Else
                Doc2.Application.Selection.Text = Contrato(11, m) & " + " & Format(Contrato(24, m), "###0.###0") & " %"
                Doc2.Bookmarks("FijaVarBco").Select
                Doc2.Application.Selection.Text = Contrato(11, m) & " + SPREAD"

                ''PRD-7904
                Doc2.Bookmarks("BaseBco").Select
                Doc2.Application.Selection.Text = "Base Cálculo " & Contrato(45, m)

            End If

        End If

        If Contrato(27, m) = 1 And Contrato(35, m) = 1 Then
            Doc2.Bookmarks("TasaCli").Select

            If Contrato(10, m) = "FIJA" Then
                Doc2.Application.Selection.Text = Format(Contrato(8, m), "###0.###0") & " % "
                Doc2.Bookmarks("FijaVarCli").Select
                Doc2.Application.Selection.Text = Contrato(10, m)

                ''PRD-7904
                Doc2.Bookmarks("BaseCli").Select
                Doc2.Application.Selection.Text = "Base Cálculo " & Contrato(44, m)


            Else
                Doc2.Application.Selection.Text = Contrato(10, m) & " + " & Format(Contrato(19, m), "###0.###0") & " %"
                Doc2.Bookmarks("FijaVarCli").Select
                Doc2.Application.Selection.Text = Contrato(10, m) & " + SPREAD"

                ''PRD-7904
                Doc2.Bookmarks("BaseCli").Select
                Doc2.Application.Selection.Text = "Base Cálculo " & Contrato(44, m)

            End If

        End If


    Next

    'Grilla Recibimos
    For m = 1 To total
        Doc2.Bookmarks("GrillaCli").Select

        If contadorlineas >= 1 And Contrato(27, m) = 1 Then
            Doc2.Application.Selection.MoveDown Unit:=wdLine, Count:=A
            Doc2.Bookmarks.Add Name:="Prueba", Range:=Doc2.Application.Selection.Range
            Doc2.Bookmarks("Prueba").Select
            A = A + 1
        End If

        If Contrato(27, m) = 1 Then
           Doc2.Application.Selection.Text = Contrato(37, m)
           Doc2.Application.Selection.MoveRight Unit:=wdCell
           Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft

           Doc2.Application.Selection.Text = Contrato(5, m)
           Doc2.Application.Selection.MoveRight Unit:=wdCell
           Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft

           Doc2.Application.Selection.Text = Contrato(38, m)
           Doc2.Application.Selection.MoveRight Unit:=wdCell
           Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft

           Doc2.Application.Selection.Text = Contrato(7, m)
           Doc2.Application.Selection.MoveRight Unit:=wdCell
           Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphCenter

           Doc2.Application.Selection.Text = NemoMon & " " & Format((Contrato(17, m)), "###,###,###,##0.###0")
           Doc2.Application.Selection.MoveRight Unit:=wdCell
           Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphCenter

           Doc2.Application.Selection.Text = NemoMon & " " & Format((Contrato(16, m)), "###,###,###,##0.###0")
           Doc2.Application.Selection.MoveRight Unit:=wdCell
           Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft

           If Contrato(10, m) = "FIJA" Or Contrato(14, m) = 1 Then
                If Contrato(10, m) = "FIJA" Then
                  Doc2.Application.Selection.Text = Format(Contrato(18, m), "###,###,###,##0.###0")
                Else
                  Doc2.Application.Selection.Text = Contrato(10, m) & " + " & Format(Contrato(8, m), "###0.###0") & " %"
                 'Doc2.Application.Selection.Text = Contrato(8, m) & " % "
                End If
                Doc2.Application.Selection.MoveRight Unit:=wdCell
                Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
           Else
                Doc2.Application.Selection.Text = Contrato(10, m) & " + " & Format(Contrato(19, m), "###0.###0") & " %"
                Doc2.Application.Selection.MoveRight Unit:=wdCell
                Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft

           End If

           contadorlineas = contadorlineas + 1
      End If

    Next

    contadorlineas = 1
    A = 1

    'Grilla Pagamos
    For m = 1 To total
        Doc2.Bookmarks("Grilla").Select

        If contadorlineas >= 1 And Contrato(27, m) = 2 Then
            Doc2.Application.Selection.MoveDown Unit:=wdLine, Count:=A
            Doc2.Bookmarks.Add Name:="Prueba", Range:=Doc2.Application.Selection.Range
            Doc2.Bookmarks("Prueba").Select
            A = A + 1
        End If

        If Contrato(27, m) = 2 Then
           Doc2.Application.Selection.Text = Contrato(37, m)
           Doc2.Application.Selection.MoveRight Unit:=wdCell
           Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
           
           Doc2.Application.Selection.Text = Contrato(5, m)
           Doc2.Application.Selection.MoveRight Unit:=wdCell
           Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
           

           Doc2.Application.Selection.Text = Contrato(38, m)
           Doc2.Application.Selection.MoveRight Unit:=wdCell
           Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft

           Doc2.Application.Selection.Text = Contrato(7, m)
           Doc2.Application.Selection.MoveRight Unit:=wdCell
           Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphCenter

           Doc2.Application.Selection.Text = NemoMon & " " & Format((Contrato(22, m)), "###,###,###,##0.###0")
           Doc2.Application.Selection.MoveRight Unit:=wdCell
           Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphCenter

           Doc2.Application.Selection.Text = NemoMon & " " & Format((Contrato(21, m)), "###,###,###,##0.###0")
           Doc2.Application.Selection.MoveRight Unit:=wdCell
           Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft

           If Contrato(11, m) = "FIJA" Or Contrato(14, m) = 1 Then
                If Contrato(11, m) = "FIJA" Then
                  Doc2.Application.Selection.Text = Format(Contrato(23, m), "###,###,###,##0.###0")
                Else
                  Doc2.Application.Selection.Text = Contrato(11, m) & " + " & Format(Contrato(24, m), "###0.###0") & " %"
                End If
                
                Doc2.Application.Selection.MoveRight Unit:=wdCell
                Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
           Else
                Doc2.Application.Selection.Text = Contrato(11, m) & " + " & Format(Contrato(24, m), "###0.###0") & " %"
                Doc2.Application.Selection.MoveRight Unit:=wdCell
                Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft

           End If

            contadorlineas = contadorlineas + 1

        End If

    Next

    Doc2.Bookmarks("ModalidadPago").Select
    Doc2.Application.Selection.Text = Contrato(4, 1)
    
    If Contrato(4, i) <> "COMPENSACION" Then
        Doc2.Bookmarks("FraseNemoMonMod").Select
        Doc2.Application.Selection.Text = Datos(42) & " " & Datos(39) & Datos(43) & " " & Datos(40)
    Else
        Doc2.Bookmarks("FraseNemoMonMod").Select
        Doc2.Application.Selection.Text = Datos(41) & " " & Datos(39)
    End If
   
    Doc2.Application.Visible = True
    If Donde = "Impresora" Then
        ActiveDocument.PrintOut
    Else
        Doc2.Application.Visible = True
         Doc2.Application.WindowState = wdWindowStateMaximize
    End If
    
 Set Doc2 = Nothing

Exit Function

Control:

    MsgBox "Problemas para crear Contrato!!. " & err.Description, vbInformation, Msj
    Set Doc2 = Nothing

End Function

Public Function BacDOCCondicionesGeneralesNoBanco(DatosCond(), Donde) As Boolean

On erro GoTo Control:

    Dim Doc2           As Word.Document
    Dim SQL As String
    Dim Paso As String
    Dim Okk As Boolean
    Dim nombre_archivo As String
    
    Set Doc2 = IniciaWordListadoLog("CondicionesNoBanco", Okk)
    
    If Not Okk Then
        MsgBox "Condiciones Generales no pueden ser Generadas", vbCritical, Msj
        Exit Function
    End If
   
    Doc2.Activate

    '1 Nombre del Banco
         Doc2.Bookmarks("Nombre_Banco_1").Select
         Doc2.Application.Selection.Text = DatosCond(1)
         
         '1 Nombre del Cliente
         Doc2.Bookmarks("Nombre_Cliente_1").Select
         Doc2.Application.Selection.Text = DatosCond(6)

         '1 Fecha de Proceso
         Doc2.Bookmarks("Fecha_Proceso_1").Select
         Doc2.Application.Selection.Text = BacFormatoFecha("DDMMAA", BacCondicionesGenerales.TXTFecha.Text)
         
         '1 Nombre del Banco
         Doc2.Bookmarks("Nombre_Banco_2").Select
         Doc2.Application.Selection.Text = DatosCond(1)
         
         '1 Rut del Banco
         Doc2.Bookmarks("Rut_Banco_1").Select
         Doc2.Application.Selection.Text = DatosCond(2)
         
         Doc2.Bookmarks("banco").Select
         Doc2.Application.Selection.Text = DatosCond(1)
         
         Doc2.Bookmarks("banco1").Select
         Doc2.Application.Selection.Text = DatosCond(1)
         
         Doc2.Bookmarks("banco2").Select
         Doc2.Application.Selection.Text = DatosCond(1)
         
         Doc2.Bookmarks("banco3").Select
         Doc2.Application.Selection.Text = DatosCond(1)
         
         Doc2.Bookmarks("banco4").Select
         Doc2.Application.Selection.Text = DatosCond(1)
         
         Doc2.Bookmarks("banco5").Select
         Doc2.Application.Selection.Text = DatosCond(1)
         
         Doc2.Bookmarks("banco6").Select
         Doc2.Application.Selection.Text = DatosCond(1)
         
         Doc2.Bookmarks("banco7").Select
         Doc2.Application.Selection.Text = DatosCond(1)
         
         Doc2.Bookmarks("banco8").Select
         Doc2.Application.Selection.Text = DatosCond(1)
         
         Doc2.Bookmarks("banco9").Select
         Doc2.Application.Selection.Text = DatosCond(1)
  
         'nombre_banco
         
         With BacCondicionesGenerales
         FIRMAS Doc2, "Nombre_Banco_3", .txtRutRepBco1.Text, Trim(Left(BacCondicionesGenerales.cmbRepBco1, Len(BacCondicionesGenerales.cmbRepBco1) - 15)), gsc_Parametros.direccion, gsc_Parametros.telefono, gsc_Parametros.fax, BacFormatoRut(Val(gsc_Parametros.Rut) & "-" & gsc_Parametros.digrut), .txtEntidad.Text
         FIRMAS Doc2, "Nombre_Banco_4", .txtRutRepBco2.Text, Trim(Left(BacCondicionesGenerales.cmbRepBco2, Len(BacCondicionesGenerales.cmbRepBco2) - 15)), gsc_Parametros.direccion, gsc_Parametros.telefono, gsc_Parametros.fax, BacFormatoRut(Val(gsc_Parametros.Rut) & "-" & gsc_Parametros.digrut), .txtEntidad.Text
         End With
       
         '************************************
         '***** Aqui empieza el anexo 1 ******
         '************************************

         '1 Fecha de Proceso
         Doc2.Bookmarks("Fecha_Proceso_2").Select
         Doc2.Application.Selection.Text = BacFormatoFecha("DDMMAA", BacCondicionesGenerales.TXTFecha.Text)

         '1 Nombre Banco
         Doc2.Bookmarks("Nombre_Banco_5").Select
         Doc2.Application.Selection.Text = DatosCond(1)

         'rut_bco10
         Doc2.Bookmarks("rut_bco10").Select
         Doc2.Application.Selection.Text = DatosCond(2)


         Doc2.Bookmarks("Fecha_Proceso_3").Select
         Doc2.Application.Selection.Text = BacFormatoFecha("DDMMAA", BacCondicionesGenerales.TXTFecha.Text)

         '*************************************
         '*************FIRMAS******************
         '*************************************
         
         With BacCondicionesGenerales
         FIRMAS Doc2, "Nombre_Banco_6", .txtRutRepBco1.Text, Trim(Left(BacCondicionesGenerales.cmbRepBco1, Len(BacCondicionesGenerales.cmbRepBco1) - 15)), gsc_Parametros.direccion, gsc_Parametros.telefono, gsc_Parametros.fax, BacFormatoRut(Val(gsc_Parametros.Rut) & "-" & gsc_Parametros.digrut), .txtEntidad.Text
         FIRMAS Doc2, "Nombre_Banco_7", .txtRutRepBco2.Text, Trim(Left(BacCondicionesGenerales.cmbRepBco2, Len(BacCondicionesGenerales.cmbRepBco2) - 15)), gsc_Parametros.direccion, gsc_Parametros.telefono, gsc_Parametros.fax, BacFormatoRut(Val(gsc_Parametros.Rut) & "-" & gsc_Parametros.digrut), .txtEntidad.Text
         End With


         '***********************************
         '***** Aqui empieza el anexo 2 *****
         '***********************************

         '1 Fecha de Proceso
         Doc2.Bookmarks("Fecha_Proceso_4").Select
         Doc2.Application.Selection.Text = BacFormatoFecha("DDMMAA", BacCondicionesGenerales.TXTFecha.Text)

         '1 Nombre Banco
         Doc2.Bookmarks("Nombre_Banco_8").Select
         Doc2.Application.Selection.Text = DatosCond(1)

         Doc2.Bookmarks("Rut_Banco_6").Select
         Doc2.Application.Selection.Text = DatosCond(2)

       
         Doc2.Bookmarks("Fecha_Proceso_5").Select
         Doc2.Application.Selection.Text = BacFormatoFecha("DDMMAA", BacCondicionesGenerales.TXTFecha.Text) '
         '**************************************
         '************FIRMAS*****************
         '**************************************
         
         With BacCondicionesGenerales
         FIRMAS Doc2, "Nombre_Banco_9", .txtRutRepBco1.Text, Trim(Left(BacCondicionesGenerales.cmbRepBco1, Len(BacCondicionesGenerales.cmbRepBco1) - 15)), gsc_Parametros.direccion, gsc_Parametros.telefono, gsc_Parametros.fax, BacFormatoRut(Val(gsc_Parametros.Rut) & "-" & gsc_Parametros.digrut), .txtEntidad.Text
         FIRMAS Doc2, "Nombre_Banco_10", .txtRutRepBco2.Text, Trim(Left(BacCondicionesGenerales.cmbRepBco2, Len(BacCondicionesGenerales.cmbRepBco2) - 15)), gsc_Parametros.direccion, gsc_Parametros.telefono, gsc_Parametros.fax, BacFormatoRut(Val(gsc_Parametros.Rut) & "-" & gsc_Parametros.digrut), .txtEntidad.Text
         End With

         '**************************************
         '***** Aqui empieza el anexo 3 ********
         '**************************************

         '1 Fecha de Proceso
         Doc2.Bookmarks("Fecha_Proceso_6").Select
         Doc2.Application.Selection.Text = BacFormatoFecha("DDMMAA", BacCondicionesGenerales.TXTFecha.Text) '

         '1 Nombre Banco
         Doc2.Bookmarks("Nombre_Banco_11").Select
         Doc2.Application.Selection.Text = DatosCond(1)

         Doc2.Bookmarks("Rut_Banco_9").Select
         Doc2.Application.Selection.Text = DatosCond(2)

         Doc2.Bookmarks("Fecha_Proceso_7").Select
         Doc2.Application.Selection.Text = BacFormatoFecha("DDMMAA", BacCondicionesGenerales.TXTFecha.Text) '
         '***************************************
         '************FIRMAS*********************
         '***************************************
         
          With BacCondicionesGenerales
         FIRMAS Doc2, "Nombre_Banco_12", .txtRutRepBco1.Text, Trim(Left(BacCondicionesGenerales.cmbRepBco1, Len(BacCondicionesGenerales.cmbRepBco1) - 15)), gsc_Parametros.direccion, gsc_Parametros.telefono, gsc_Parametros.fax, BacFormatoRut(Val(gsc_Parametros.Rut) & "-" & gsc_Parametros.digrut), .txtEntidad.Text
         FIRMAS Doc2, "Nombre_Cliente_14", .txtRutRepBco2.Text, Trim(Left(BacCondicionesGenerales.cmbRepBco2, Len(BacCondicionesGenerales.cmbRepBco2) - 15)), gsc_Parametros.direccion, gsc_Parametros.telefono, gsc_Parametros.fax, BacFormatoRut(Val(gsc_Parametros.Rut) & "-" & gsc_Parametros.digrut), .txtEntidad.Text
         End With

         '*********************************
         '***** Aqui empieza el anexo 4 ***
         '*********************************

         '1 Fecha de Proceso
         Doc2.Bookmarks("Fecha_Proceso_8").Select
         Doc2.Application.Selection.Text = BacFormatoFecha("DDMMAA", BacCondicionesGenerales.TXTFecha.Text)

         '1 Nombre Banco
         Doc2.Bookmarks("Nombre_Banco_14").Select
         Doc2.Application.Selection.Text = DatosCond(1)


         'rut_bco_prin
         Doc2.Bookmarks("rut_bco_prin").Select
         Doc2.Application.Selection.Text = DatosCond(2)

         'fecha
         Doc2.Bookmarks("fecha").Select
         Doc2.Application.Selection.Text = BacFormatoFecha("DDMMAA", BacCondicionesGenerales.TXTFecha.Text)
         '*************************************
         '*************************************
         '*************************************
         
         With BacCondicionesGenerales
            FIRMAS Doc2, "Nombre_Banco_13", .txtRutRepBco1.Text, Trim(Left(BacCondicionesGenerales.cmbRepBco1, Len(BacCondicionesGenerales.cmbRepBco1) - 15)), gsc_Parametros.direccion, gsc_Parametros.telefono, gsc_Parametros.fax, BacFormatoRut(Val(gsc_Parametros.Rut) & "-" & gsc_Parametros.digrut), .txtEntidad.Text
            FIRMAS Doc2, "pp_bco", .txtRutRepBco2.Text, Trim(Left(BacCondicionesGenerales.cmbRepBco2, Len(BacCondicionesGenerales.cmbRepBco2) - 15)), gsc_Parametros.direccion, gsc_Parametros.telefono, gsc_Parametros.fax, BacFormatoRut(Val(gsc_Parametros.Rut) & "-" & gsc_Parametros.digrut), .txtEntidad.Text
         End With


         '*************************************
         '***** Aqui empieza el anexo 5 *******
         '*************************************
         '1 Fecha de Proceso
         Doc2.Bookmarks("Fecha_Proceso_9").Select
         Doc2.Application.Selection.Text = BacFormatoFecha("DDMMAA", BacCondicionesGenerales.TXTFecha.Text)

         '1 Nombre Banco
         Doc2.Bookmarks("Nombre_Banco_17").Select
         Doc2.Application.Selection.Text = DatosCond(1)

         'rut_bco2
         Doc2.Bookmarks("rut_bco2").Select
         Doc2.Application.Selection.Text = DatosCond(2)

          Doc2.Bookmarks("fecha1").Select
          Doc2.Application.Selection.Text = BacFormatoFecha("DDMMAA", BacCondicionesGenerales.TXTFecha.Text)
         '**********************************
         '***************Firmas _ordenadas**
         '**********************************
         With BacCondicionesGenerales
            FIRMAS Doc2, "Nombre_Banco_15", .txtRutRepBco1.Text, Trim(Left(BacCondicionesGenerales.cmbRepBco1, Len(BacCondicionesGenerales.cmbRepBco1) - 15)), gsc_Parametros.direccion, gsc_Parametros.telefono, gsc_Parametros.fax, BacFormatoRut(Val(gsc_Parametros.Rut) & "-" & gsc_Parametros.digrut), .txtEntidad.Text
            FIRMAS Doc2, "pp_bco1", .txtRutRepBco2.Text, Trim(Left(BacCondicionesGenerales.cmbRepBco2, Len(BacCondicionesGenerales.cmbRepBco2) - 15)), gsc_Parametros.direccion, gsc_Parametros.telefono, gsc_Parametros.fax, BacFormatoRut(Val(gsc_Parametros.Rut) & "-" & gsc_Parametros.digrut), .txtEntidad.Text
         End With

         '****************************************
         '***** Aqui empieza el anexo 6 **********
         '****************************************
         '1 Fecha de Proceso
         Doc2.Bookmarks("Fecha_Proceso_10").Select
         Doc2.Application.Selection.Text = BacFormatoFecha("DDMMAA", BacCondicionesGenerales.TXTFecha.Text)

         '1 Nombre Banco
         Doc2.Bookmarks("Nombre_Banco_18").Select
         Doc2.Application.Selection.Text = DatosCond(1)


         'rut_bco4
         Doc2.Bookmarks("rut_bco4").Select
         Doc2.Application.Selection.Text = DatosCond(2)

         'fecha2
         Doc2.Bookmarks("fecha2").Select
         Doc2.Application.Selection.Text = BacFormatoFecha("DDMMAA", BacCondicionesGenerales.TXTFecha.Text)
         '**************************************
         '*************firmas*******************
         '**************************************
         
         With BacCondicionesGenerales
            FIRMAS Doc2, "Nombre_Banco_16", .txtRutRepBco1.Text, Trim(Left(BacCondicionesGenerales.cmbRepBco1, Len(BacCondicionesGenerales.cmbRepBco1) - 15)), gsc_Parametros.direccion, gsc_Parametros.telefono, gsc_Parametros.fax, BacFormatoRut(Val(gsc_Parametros.Rut) & "-" & gsc_Parametros.digrut), .txtEntidad.Text
            FIRMAS Doc2, "pp_bco2", .txtRutRepBco2.Text, Trim(Left(BacCondicionesGenerales.cmbRepBco2, Len(BacCondicionesGenerales.cmbRepBco2) - 15)), gsc_Parametros.direccion, gsc_Parametros.telefono, gsc_Parametros.fax, BacFormatoRut(Val(gsc_Parametros.Rut) & "-" & gsc_Parametros.digrut), .txtEntidad.Text
         End With

         Dim RutRepresentante1 As String
         Dim NomRepresentante1 As String
         Dim DirCliente1       As String
         Dim FonCliente1       As String
         Dim FaxCliente1       As String
         Dim RutCliente1       As String
         Dim NomCliente1       As String
         
         Dim RutRepresentante2 As String
         Dim NomRepresentante2 As String
         Dim DirCliente2       As String
         Dim FonCliente2       As String
         Dim FaxCliente2       As String
         Dim RutCliente2       As String
         Dim NomCliente2       As String
         
         RutRepresentante1 = BacCondicionesGenerales.txtRutRepCli1
         NomRepresentante1 = Trim(Left(BacCondicionesGenerales.cmbRepCliente1, Len(BacCondicionesGenerales.cmbRepCliente1) - 15))
         DirCliente1 = BacCondicionesGenerales.txtDirecCli
         FonCliente1 = gsFono
         FaxCliente1 = gsFax
         RutCliente1 = BacFormatoRut(gsCodigo & "-" & gsDigito)
         NomCliente1 = gsNombre
         
         RutRepresentante2 = BacCondicionesGenerales.txtRutRepCli2
         NomRepresentante2 = IIf(BacCondicionesGenerales.cmbRepCliente2 = "", "", Trim(Left(BacCondicionesGenerales.cmbRepCliente2, Len(BacCondicionesGenerales.cmbRepCliente2) - 15)))
         DirCliente2 = BacCondicionesGenerales.txtDirecCli
         FonCliente2 = gsFono
         FaxCliente2 = gsFax
         RutCliente2 = BacFormatoRut(gsCodigo & "-" & gsDigito)
         NomCliente2 = gsNombre
         
         With BacCondicionesGenerales
            Call FIRMAS(Doc2, "Nombre_Cliente_3", RutRepresentante1, NomRepresentante1, DirCliente1, FonCliente1, FaxCliente1, RutCliente1, NomCliente1)
            Call FIRMAS(Doc2, "Nombre_Cliente_4", RutRepresentante2, NomRepresentante2, DirCliente2, FonCliente2, FaxCliente2, RutCliente2, NomCliente2)
            
            Call FIRMAS(Doc2, "Nombre_Cliente_6", RutRepresentante1, NomRepresentante1, DirCliente1, FonCliente1, FaxCliente1, RutCliente1, NomCliente1)
            Call FIRMAS(Doc2, "Nombre_Cliente_7", RutRepresentante2, NomRepresentante2, DirCliente2, FonCliente2, FaxCliente2, RutCliente2, NomCliente2)
            
            Call FIRMAS(Doc2, "Nombre_Cliente_9", RutRepresentante1, NomRepresentante1, DirCliente1, FonCliente1, FaxCliente1, RutCliente1, NomCliente1)
            Call FIRMAS(Doc2, "Nombre_Cliente_10", RutRepresentante2, NomRepresentante2, DirCliente2, FonCliente2, FaxCliente2, RutCliente2, NomCliente2)
            
            Call FIRMAS(Doc2, "pp_cli", RutRepresentante1, NomRepresentante1, DirCliente1, FonCliente1, FaxCliente1, RutCliente1, NomCliente1)
            Call FIRMAS(Doc2, "pp_cli1", RutRepresentante2, NomRepresentante2, DirCliente2, FonCliente2, FaxCliente2, RutCliente2, NomCliente2)
            
            Call FIRMAS(Doc2, "Nombre_Cliente_15", RutRepresentante1, NomRepresentante1, DirCliente1, FonCliente1, FaxCliente1, RutCliente1, NomCliente1)
            Call FIRMAS(Doc2, "pp_cli2", RutRepresentante2, NomRepresentante2, DirCliente2, FonCliente2, FaxCliente2, RutCliente2, NomCliente2)
            
            Call FIRMAS(Doc2, "Nombre_Cliente_16", RutRepresentante1, NomRepresentante1, DirCliente1, FonCliente1, FaxCliente1, RutCliente1, NomCliente1)
            Call FIRMAS(Doc2, "pp_cli3", RutRepresentante2, NomRepresentante2, DirCliente2, FonCliente2, FaxCliente2, RutCliente2, NomCliente2)
            
            Call FIRMAS(Doc2, "Nombre_Cliente_18", RutRepresentante1, NomRepresentante1, DirCliente1, FonCliente1, FaxCliente1, RutCliente1, NomCliente1)
            Call FIRMAS(Doc2, "pp_cli4", RutRepresentante2, NomRepresentante2, DirCliente2, FonCliente2, FaxCliente2, RutCliente2, NomCliente2)
         End With
      
'         With BacCondicionesGenerales
'            FIRMAS Doc2, "Nombre_Cliente_4", Val(.txtRutRepCli2), Trim(Left(BacCondicionesGenerales.cmbRepCliente2, Len(BacCondicionesGenerales.cmbRepCliente2) - 15)), .txtDirecCli, gsFono, gsFax, (BacFormatoRut(gsCodigo & "-" & gsDigito)), gsNombre
'            FIRMAS Doc2, "Nombre_Cliente_7", Val(.txtRutRepCli2), Trim(Left(BacCondicionesGenerales.cmbRepCliente2, Len(BacCondicionesGenerales.cmbRepCliente2) - 15)), .txtDirecCli, gsFono, gsFax, (BacFormatoRut(gsCodigo & "-" & gsDigito)), gsNombre
'            FIRMAS Doc2, "Nombre_Cliente_10", Val(.txtRutRepCli2), Trim(Left(BacCondicionesGenerales.cmbRepCliente2, Len(BacCondicionesGenerales.cmbRepCliente2) - 15)), .txtDirecCli, gsFono, gsFax, (BacFormatoRut(gsCodigo & "-" & gsDigito)), gsNombre
'
'            FIRMAS Doc2, "pp_cli1", .txtRutRepCli2, Trim(Left(BacCondicionesGenerales.cmbRepCliente2, Len(BacCondicionesGenerales.cmbRepCliente2) - 15)), .txtDirecCli, gsFono, gsFax, (BacFormatoRut(gsCodigo & "-" & gsDigito)), gsNombre
'            FIRMAS Doc2, "pp_cli2", .txtRutRepCli2, Trim(Left(BacCondicionesGenerales.cmbRepCliente2, Len(BacCondicionesGenerales.cmbRepCliente2) - 15)), .txtDirecCli, gsFono, gsFax, (BacFormatoRut(gsCodigo & "-" & gsDigito)), gsNombre
'            FIRMAS Doc2, "pp_cli3", .txtRutRepCli2, Trim(Left(BacCondicionesGenerales.cmbRepCliente2, Len(BacCondicionesGenerales.cmbRepCliente2) - 15)), .txtDirecCli, gsFono, gsFax, (BacFormatoRut(gsCodigo & "-" & gsDigito)), gsNombre
'            FIRMAS Doc2, "pp_cli4", .txtRutRepCli2, Trim(Left(BacCondicionesGenerales.cmbRepCliente2, Len(BacCondicionesGenerales.cmbRepCliente2) - 15)), .txtDirecCli, gsFono, gsFax, (BacFormatoRut(gsCodigo & "-" & gsDigito)), gsNombre
'         End With
      
      
   '1 Nombre de Apoderado del Cliente
''''''If Len(BacCondicionesGenerales.cmbRepCliente1.Text) <> 0 And Len(BacCondicionesGenerales.cmbRepCliente2.Text) = 0 Or Len(BacCondicionesGenerales.cmbRepCliente1.Text) <> 0 And Len(BacCondicionesGenerales.cmbRepCliente2.Text) <> 0 Then
''''''   With BacCondicionesGenerales
''''''      FIRMAS Doc2, "Nombre_Cliente_3", .txtRutRepCli1, Trim(Left(BacCondicionesGenerales.cmbRepCliente1, Len(BacCondicionesGenerales.cmbRepCliente1) - 15)), .txtDirecCli, gsFono, gsFax, (BacFormatoRut(gsCodigo & "-" & gsDigito)), gsNombre
''''''      FIRMAS Doc2, "Nombre_Cliente_6", .txtRutRepCli1, Trim(Left(BacCondicionesGenerales.cmbRepCliente1, Len(BacCondicionesGenerales.cmbRepCliente1) - 15)), .txtDirecCli, gsFono, gsFax, (BacFormatoRut(gsCodigo & "-" & gsDigito)), gsNombre
''''''      FIRMAS Doc2, "Nombre_Cliente_9", .txtRutRepCli1, Trim(Left(BacCondicionesGenerales.cmbRepCliente1, Len(BacCondicionesGenerales.cmbRepCliente1) - 15)), .txtDirecCli, gsFono, gsFax, (BacFormatoRut(gsCodigo & "-" & gsDigito)), gsNombre
''''''      FIRMAS Doc2, "pp_cli", .txtRutRepCli1, Trim(Left(BacCondicionesGenerales.cmbRepCliente1, Len(BacCondicionesGenerales.cmbRepCliente1) - 15)), .txtDirecCli, gsFono, gsFax, (BacFormatoRut(gsCodigo & "-" & gsDigito)), gsNombre
''''''      FIRMAS Doc2, "Nombre_Cliente_15", .txtRutRepCli1, Trim(Left(BacCondicionesGenerales.cmbRepCliente1, Len(BacCondicionesGenerales.cmbRepCliente1) - 15)), .txtDirecCli, gsFono, gsFax, (BacFormatoRut(gsCodigo & "-" & gsDigito)), gsNombre
''''''      FIRMAS Doc2, "Nombre_Cliente_16", .txtRutRepCli1, Trim(Left(BacCondicionesGenerales.cmbRepCliente1, Len(BacCondicionesGenerales.cmbRepCliente1) - 15)), .txtDirecCli, gsFono, gsFax, (BacFormatoRut(gsCodigo & "-" & gsDigito)), gsNombre
''''''      FIRMAS Doc2, "Nombre_Cliente_18", .txtRutRepCli1, Trim(Left(BacCondicionesGenerales.cmbRepCliente1, Len(BacCondicionesGenerales.cmbRepCliente1) - 15)), .txtDirecCli, gsFono, gsFax, (BacFormatoRut(gsCodigo & "-" & gsDigito)), gsNombre
''''''   End With
''''''   If Len(BacCondicionesGenerales.cmbRepCliente2.Text) <> 0 Then
''''''      With BacCondicionesGenerales
''''''         FIRMAS Doc2, "Nombre_Cliente_4", .txtRutRepCli2, Trim(Left(BacCondicionesGenerales.cmbRepCliente2, Len(BacCondicionesGenerales.cmbRepCliente2) - 15)), .txtDirecCli, gsFono, gsFax, (BacFormatoRut(gsCodigo & "-" & gsDigito)), gsNombre
''''''         FIRMAS Doc2, "Nombre_Cliente_7", .txtRutRepCli2, Trim(Left(BacCondicionesGenerales.cmbRepCliente2, Len(BacCondicionesGenerales.cmbRepCliente2) - 15)), .txtDirecCli, gsFono, gsFax, (BacFormatoRut(gsCodigo & "-" & gsDigito)), gsNombre
''''''         FIRMAS Doc2, "Nombre_Cliente_10", .txtRutRepCli2, Trim(Left(BacCondicionesGenerales.cmbRepCliente2, Len(BacCondicionesGenerales.cmbRepCliente2) - 15)), .txtDirecCli, gsFono, gsFax, (BacFormatoRut(gsCodigo & "-" & gsDigito)), gsNombre
''''''         FIRMAS Doc2, "pp_cli1", .txtRutRepCli2, Trim(Left(BacCondicionesGenerales.cmbRepCliente2, Len(BacCondicionesGenerales.cmbRepCliente2) - 15)), .txtDirecCli, gsFono, gsFax, (BacFormatoRut(gsCodigo & "-" & gsDigito)), gsNombre
''''''         FIRMAS Doc2, "pp_cli2", .txtRutRepCli2, Trim(Left(BacCondicionesGenerales.cmbRepCliente2, Len(BacCondicionesGenerales.cmbRepCliente2) - 15)), .txtDirecCli, gsFono, gsFax, (BacFormatoRut(gsCodigo & "-" & gsDigito)), gsNombre
''''''         FIRMAS Doc2, "pp_cli3", .txtRutRepCli2, Trim(Left(BacCondicionesGenerales.cmbRepCliente2, Len(BacCondicionesGenerales.cmbRepCliente2) - 15)), .txtDirecCli, gsFono, gsFax, (BacFormatoRut(gsCodigo & "-" & gsDigito)), gsNombre
''''''         FIRMAS Doc2, "pp_cli4", .txtRutRepCli2, Trim(Left(BacCondicionesGenerales.cmbRepCliente2, Len(BacCondicionesGenerales.cmbRepCliente2) - 15)), .txtDirecCli, gsFono, gsFax, (BacFormatoRut(gsCodigo & "-" & gsDigito)), gsNombre
''''''      End With
''''''   End If
''''''ElseIf Len(BacCondicionesGenerales.cmbRepCliente1.Text) = 0 And Len(BacCondicionesGenerales.cmbRepCliente2.Text) <> 0 Then
''''''   With BacCondicionesGenerales
''''''      FIRMAS Doc2, "Nombre_Cliente_4", .txtRutRepCli2, Trim(Left(BacCondicionesGenerales.cmbRepCliente2, Len(BacCondicionesGenerales.cmbRepCliente2) - 15)), .txtDirecCli, gsFono, gsFax, (BacFormatoRut(gsCodigo & "-" & gsDigito)), gsNombre
''''''      FIRMAS Doc2, "Nombre_Cliente_7", .txtRutRepCli2, Trim(Left(BacCondicionesGenerales.cmbRepCliente2, Len(BacCondicionesGenerales.cmbRepCliente2) - 15)), .txtDirecCli, gsFono, gsFax, (BacFormatoRut(gsCodigo & "-" & gsDigito)), gsNombre
''''''      FIRMAS Doc2, "Nombre_Cliente_10", .txtRutRepCli2, Trim(Left(BacCondicionesGenerales.cmbRepCliente2, Len(BacCondicionesGenerales.cmbRepCliente2) - 15)), .txtDirecCli, gsFono, gsFax, (BacFormatoRut(gsCodigo & "-" & gsDigito)), gsNombre
''''''      FIRMAS Doc2, "pp_cli1", .txtRutRepCli2, Trim(Left(BacCondicionesGenerales.cmbRepCliente2, Len(BacCondicionesGenerales.cmbRepCliente2) - 15)), .txtDirecCli, gsFono, gsFax, (BacFormatoRut(gsCodigo & "-" & gsDigito)), gsNombre
''''''      FIRMAS Doc2, "pp_cli2", .txtRutRepCli2, Trim(Left(BacCondicionesGenerales.cmbRepCliente2, Len(BacCondicionesGenerales.cmbRepCliente2) - 15)), .txtDirecCli, gsFono, gsFax, (BacFormatoRut(gsCodigo & "-" & gsDigito)), gsNombre
''''''      FIRMAS Doc2, "pp_cli3", .txtRutRepCli2, Trim(Left(BacCondicionesGenerales.cmbRepCliente2, Len(BacCondicionesGenerales.cmbRepCliente2) - 15)), .txtDirecCli, gsFono, gsFax, (BacFormatoRut(gsCodigo & "-" & gsDigito)), gsNombre
''''''      FIRMAS Doc2, "pp_cli4", .txtRutRepCli2, Trim(Left(BacCondicionesGenerales.cmbRepCliente2, Len(BacCondicionesGenerales.cmbRepCliente2) - 15)), .txtDirecCli, gsFono, gsFax, (BacFormatoRut(gsCodigo & "-" & gsDigito)), gsNombre
''''''   End With
''''''End If
    
   If Donde = "Impresora" Then
      ActiveDocument.PrintOut
   Else
      Doc2.Application.Visible = True
   End If
    
   'Actualizacion Fecha de Condiciones de Generales en Tabla Cliente
   SQL = "Update View_Cliente Set clFechaFirma_cond = '" & Format(BacCondicionesGenerales.TXTFecha.Text, "yyyymmdd") _
          & "' Where clrut = " & gsCodigo & " and clcodigo  = " & gsCodCli
    If MISQL.SQL_Execute(SQL) <> 0 Then
        MsgBox "Problemas al actualizar fecha de Condiciones Generales en archivo de Clientes", vbCritical, Msj
    End If

    Set Doc2 = Nothing

Exit Function

Control:
    Set Doc2 = Nothing

    MsgBox "Problemas para crear Condiciones Generales con Empresas. " & err.Description, vbInformation, Msj
      
End Function

Public Function BacContratoInterbancario(nNumOpe As Long) As Boolean
   Dim SQL       As String
   Dim Datos()
   Dim Lin(80)
   Dim nPosicion As Integer
   Dim nFila     As Integer
   Dim nTab      As Integer
   Dim aString()
   Dim nCont     As Integer
   Dim sTexto    As String
   Dim nCont2    As Integer
   Dim cCaracter As String

   'Recuperación de los datos de la operación
   SQL = "EXECUTE SP_CONTRATOINTERBANCARIO " & nNumOpe & ","
   SQL = SQL & Bac_Apoderados.Txt_Rut1 & ","
   SQL = SQL & Bac_Apoderados.Txt_Rut2

   If MISQL.SQL_Execute(SQL) <> 0 Then
      MsgBox "Problemas al leer datos del contrato interbancario", vbCritical, "MENSAJE"
      Exit Function
   End If
   Call FuentesImpresora
   Lin(1) = "@BANCO"
   Lin(2) = "Casa Matriz"
   Lin(3) = "Morande 226 Santiago"
   Lin(4) = "RUT : @RUTBANCO"
   Lin(5) = " "
   Lin(6) = "CONTRATO DE FORWARDS Y/O SWAP DE MONEDAS EN EL MERCADO LOCAL"
   Lin(7) = "(Institucional)"
   Lin(8) = "Folio : @NUMOPE"
   Lin(9) = " "
   
   Lin(10) = "En Santiago de Chile, a^@FECHAINICIO^, entre^@BANCO, RUT @RUTBANCO^"
   Lin(10) = Lin(10) + "debidamente representado por la(s) persona(s) que suscribe(n) al final, todos domiciliados "
   Lin(10) = Lin(10) + "en esta ciudad calle^@DIRBANCO^, teléfono^@TELBANCO^, fax^@FAXBANCO^, por una parte, y por la "
   Lin(10) = Lin(10) + "otra^@CONTRAPARTE^, RUT^@RUTCONTRAPARTE^, debidamente representado "
   Lin(10) = Lin(10) + "por la(s) persona(s) que suscribe(n) al final, todos domiciliados en esta ciudad, "
   Lin(10) = Lin(10) + "calle^@DIRCONTRAPARTE^, telefono^@TELCONTRAPARTE^, fax^@FAXCONTRAPARTE^, se ha convenido y cerrado a "
   Lin(10) = Lin(10) + "firme una transacción forward y/o swap de las monedas que más adelante se indican y en los términos que a "
   Lin(10) = Lin(10) + "continuación se expresan, amparada y regida por las normas del Capitulo VII del Titulo I del Compendio de Normas de "
   Lin(10) = Lin(10) + "Cambios Internacionales del Banco Central de Chile y del Capitulo 13-2 de la Recopilación actualizada de Normas de la "
   Lin(10) = Lin(10) + "Superintendencia de Bancos e Instituciones Financieras, y por el Protocolo de Definiciones Utilizadas en Contrato de "
   Lin(10) = Lin(10) + "Forwards y/o Swaps de Monedas en el Mercado Local de la Asociación de Bancos, vigente a la fecha de cierre del contrato, "
   Lin(10) = Lin(10) + "que las partes declaran conocer :"
      
   Lin(11) = " "
   Lin(12) = "1.  Vendedor                                              : @VENDEDOR"
   Lin(13) = "2.  Comprador                                             : @COMPRADOR"
   Lin(14) = "3.  Tipo de Transacción                                   : FORWARD"
   Lin(15) = "4.  Fecha de Cierre (dd/mm/aa)                            : @FECINI"
   Lin(16) = "5.  Hora de Cierre                                        : 12:00"
   Lin(17) = "6.  Fecha de Vencimiento                                  : @FECVEN"
   Lin(18) = "7.  Mecanismo de Cumplimiento                             : @MODALIDAD"
   Lin(19) = "8.  Cantidad de Moneda Vendida                            : @CODMON @MTOMEX"
   Lin(20) = "      @MONESCMTOMEX"
   Lin(21) = "9.  Tipo de cambio Forward Pactado                        : @TIPCAM"
   Lin(22) = "10. Paridad Forward Pactada                               : @PARFWD"
   Lin(23) = "11. Valor Forward Pactado                                 : @CODCNV @MTOFIN"
   Lin(24) = "      @MONESCMTOFIN"
   Lin(25) = "12. Tipo de Cambio de Referencia                          : @TCREFERENCIA"
   Lin(26) = "13. Paridad de Referencia                                 : N/A"
   Lin(27) = "14. Lugar de Cumplimiento                                 : Santiago"
   Lin(28) = "15. Otras Condiciones                                     : "
   Lin(29) = " "
   
   Lin(30) = "En el caso de cumplimiento por compensación, a la fecha de vencimiento pactada se establecer la cuantía de las "
   Lin(30) = Lin(30) + "obligaciones contraídas por ambas partes, compensándose dichas obligaciones, y extinguiendose‚ éstas hasta por el monto de "
   Lin(30) = Lin(30) + "la menor de ellas. La diferencia que resulte de esta compensación y liquidación deber  ser pagada por la parte deudora a la "
   Lin(30) = Lin(30) + "parte acreedora, en pesos moneda nacional, al contado, en el domicilio de esta última. Para el caso en que ambas monedas "
   Lin(30) = Lin(30) + "sean monedas extranjeras esta diferencia deber  pagarse en dólares de los Estados Unidos de América. "
   Lin(30) = Lin(30) + "Las partes de común acuerdo podr n anticipar la fecha de liquidación del contrato. Ni el presente contrato, ni los "
   Lin(30) = Lin(30) + "derechos que de él emanan podrán endosarse o transferirse, sin  consentimiento escrito  de  ambas  partes, del que deber  "
   Lin(30) = Lin(30) + "dejarse constancia en los dos ejemplares que se firman en el mismo."
   Lin(30) = Lin(30) + "Si cualquiera de las partes no cumple las obligaciones contraídas en este contrato, operar  automática  y obligatoriamente "
   Lin(30) = Lin(30) + "el mecanismo de compensación estipulado anteriormente. Si la parte deudora no pagare a la parte acreedora la diferencia que "
   Lin(30) = Lin(30) + "arrojare a favor de esta última la aludida compensación, el monto adeudado devengar , a partir de la mora y hasta la fecha de "
   Lin(30) = Lin(30) + "pago efectivo, la tasa de interés máximo convencional que la ley permite estipular para la moneda adecuada, sin perjuicio del "
   Lin(30) = Lin(30) + "derecho de la parte acreedora para exigir el cumplimiento forzado de la obligación."
   
   Lin(31) = " "
   Lin(32) = " "
   Lin(33) = " "
   Lin(34) = " "
   Lin(35) = "           ------------------------------                    ------------------------------"
   Lin(36) = "                     P. Vendedor                                       P. Comprador"
   Lin(37) = " "
   Lin(38) = "Nombre: @APOVEN1              RUT: @RUTAPOVEN1      Nombre: @APOCOM1              RUT: @RUTAPOCOM1  "
   Lin(39) = "Nombre: @APOVEN2              RUT: @RUTAPOVEN2      Nombre: @APOCOM2              RUT: @RUTAPOCOM2  "
   
   Do While MISQL.SQL_Fetch(Datos()) = 0
      Lin(1) = BacRemplazar(Lin(1), "@BANCO", Datos(1))
      Lin(4) = BacRemplazar(Lin(4), "@RUTBANCO", BacFormatoRut(Datos(4)))
      Lin(8) = BacRemplazar(Lin(8), "@NUMOPE", BacFormatoMonto(Val(Datos(2)), 0))

      Lin(10) = BacRemplazar(Lin(10), "@FECHAINICIO", BacFormatoFecha("DDMMAA", Datos(3)))
      Lin(10) = BacRemplazar(Lin(10), "@BANCO", Datos(1))
      Lin(10) = BacRemplazar(Lin(10), "@RUTBANCO", BacFormatoRut(Datos(4)))
      Lin(10) = BacRemplazar(Lin(10), "@DIRBANCO", Datos(5))
      Lin(10) = BacRemplazar(Lin(10), "@TELBANCO", Datos(6))
      Lin(10) = BacRemplazar(Lin(10), "@FAXBANCO", Datos(7))
      Lin(10) = BacRemplazar(Lin(10), "@CONTRAPARTE", Datos(8))
      Lin(10) = BacRemplazar(Lin(10), "@RUTCONTRAPARTE", BacFormatoRut(Datos(9)))
      Lin(10) = BacRemplazar(Lin(10), "@DIRCONTRAPARTE", Datos(10))
      Lin(10) = BacRemplazar(Lin(10), "@TELCONTRAPARTE", Datos(11))
      Lin(10) = BacRemplazar(Lin(10), "@FAXCONTRAPARTE", Datos(12))
      
      Lin(12) = BacRemplazar(Lin(12), "@VENDEDOR", IIf(Datos(13) = "C", Datos(8), Datos(1)))
      Lin(13) = BacRemplazar(Lin(13), "@COMPRADOR", IIf(Datos(13) = "V", Datos(8), Datos(1)))
      Lin(15) = BacRemplazar(Lin(15), "@FECINI", Datos(3))
      Lin(17) = BacRemplazar(Lin(17), "@FECVEN", Datos(14))
      Lin(18) = BacRemplazar(Lin(18), "@MODALIDAD", Datos(15))
      Lin(19) = BacRemplazar(Lin(19), "@CODMON", Datos(16))
      Lin(19) = BacRemplazar(Lin(19), "@MTOMEX", BacFormatoMonto(Val(Datos(17)), 2))
      Lin(20) = BacRemplazar(Lin(20), "@MONESCMTOMEX", BacMonto_Escrito(Val(Datos(17))) & " " & BacGlosaMon(Datos(16), True, Datos(29), Datos(30)))
      Lin(21) = BacRemplazar(Lin(21), "@TIPCAM", IIf(Val(Datos(19)) = 1, BacGlosaPrecioFuturo(Datos(20), Datos(16), Datos(21), Datos(31)), "N/A"))
      Lin(22) = BacRemplazar(Lin(22), "@PARFWD", IIf(Val(Datos(19)) = 2, BacGlosaPrecioFuturo(Datos(20), Datos(16), Datos(21), Datos(31)), "N/A"))
      Lin(23) = BacRemplazar(Lin(23), "@CODCNV", IIf(Datos(21) = "CLP", "$", Datos(21)))
      Lin(23) = BacRemplazar(Lin(23), "@MTOFIN", BacFormatoMonto(Val(Datos(22)), IIf(Datos(21) = "CLP", 0, IIf(Datos(21) = "UF", 4, 2))))
      Lin(24) = BacRemplazar(Lin(24), "@MONESCMTOFIN", BacMonto_Escrito(Val(Datos(22))) & " " & BacGlosaMon(Datos(21), False, Datos(29), Datos(30)))
      Lin(25) = BacRemplazar(Lin(25), "@TCREFERENCIA", Datos(24))
      
      Lin(38) = BacRemplazarII(Lin(38), "RUT:", "@APOVEN1", IIf(Datos(13) = "V" And Datos(25) <> "", Trim(Datos(25)), String(20, ".")))
      Lin(38) = BacRemplazarII(Lin(38), "Nombre:", "@RUTAPOVEN1", IIf(Datos(13) = "V" And Mid(Trim(Datos(26)), 1, 1) <> "0", BacFormatoRut(Trim(Datos(26))), String(13, ".")))
      Lin(38) = BacRemplazarII(Lin(38), "RUT:", "@APOCOM1", IIf(Datos(13) = "C" And Datos(25) <> "", Trim(Datos(25)), String(20, ".")))
      Lin(38) = BacRemplazar(Lin(38), "@RUTAPOCOM1", IIf(Datos(13) = "C" And Mid(Trim(Datos(26)), 1, 1) <> "0", BacFormatoRut(Trim(Datos(26))), String(13, ".")))
      
      Lin(39) = BacRemplazarII(Lin(39), "RUT:", "@APOVEN2", IIf(Datos(13) = "V" And Datos(27) <> "", Trim(Datos(27)), String(20, ".")))
      Lin(39) = BacRemplazarII(Lin(39), "Nombre:", "@RUTAPOVEN2", IIf(Datos(13) = "V" And Mid(Trim(Datos(28)), 1, 1) <> "0", BacFormatoRut(Trim(Datos(28))), String(13, ".")))
      Lin(39) = BacRemplazarII(Lin(39), "RUT:", "@APOCOM2", IIf(Datos(13) = "C" And Datos(27) <> "", Trim(Datos(27)), String(20, ".")))
      Lin(39) = BacRemplazar(Lin(39), "@RUTAPOCOM2", IIf(Datos(13) = "C" And Mid(Trim(Datos(28)), 1, 1) <> "0", BacFormatoRut(Trim(Datos(28))), String(13, ".")))
      
   Loop
  
   nTab = 8
   nFila = 3
   
   BacGlbSetPrinter 65, 120, 1, 1
   'BacGlbSetFont CourierNew, 8, True
   Printer.FontBold = True
   BacGlbPrinter nFila, 1, nTab, 1, Lin(1), 0, 1
   
   nFila = nFila + 1
   BacGlbPrinter nFila, 1, nTab, 1, Lin(2), 0, 1
   
   nFila = nFila + 1
   BacGlbPrinter nFila, 1, nTab, 1, Lin(3), 0, 1
   
   nFila = nFila + 1
   BacGlbPrinter nFila, 1, nTab, 1, Lin(4), 0, 1
   
'   BacGlbSetFont CourierNew, 8, False
   Printer.FontBold = False
   nFila = nFila + 1
   BacGlbPrinter nFila, 1, nTab, 1, Lin(5), 0, 1
   
   Lin(6) = BacFormatearTexto(Lin(6), 3, 0, 0, 0, 110)
   nFila = nFila + 1
   BacGlbPrinter nFila, 1, nTab, 1, Lin(6), 0, 1
   
   Lin(7) = BacFormatearTexto(Lin(7), 3, 0, 0, 0, 110)
   nFila = nFila + 1
   BacGlbPrinter nFila, 1, nTab, 1, Lin(7), 0, 1
   
   Lin(8) = BacFormatearTexto(Lin(8), 2, 0, 0, 0, 110)
   nFila = nFila + 1
   BacGlbPrinter nFila, 1, nTab, 1, Lin(8), 0, 1

   nFila = nFila + 1
   BacGlbPrinter nFila, 1, nTab, 1, Lin(9), 0, 1
   
   BacCentraTexto aString(), Lin(10), 110
   
   For nCont = 1 To UBound(aString())
      nFila = nFila + 1
      sTexto = aString(nCont)

      For nCont2 = 1 To Len(sTexto)
         cCaracter = Mid(sTexto, nCont2, 1)

         If cCaracter = "^" Then
            Printer.FontBold = IIf(Printer.FontBold = False, True, False)
            cCaracter = " "
         End If

         BacGlbPrinter nFila, 1, nTab - 1 + nCont2, 1, cCaracter, 0, 1
      Next

   Next
   
   nFila = nFila + 1
   BacGlbPrinter nFila, 1, nTab, 1, Lin(11), 0, 1
   
   nFila = nFila + 1
   BacGlbPrinter nFila, 1, nTab, 1, Lin(12), 0, 1
   
   nFila = nFila + 1
   BacGlbPrinter nFila, 1, nTab, 1, Lin(13), 0, 1
   
   nFila = nFila + 1
   BacGlbPrinter nFila, 1, nTab, 1, Lin(14), 0, 1
   
   nFila = nFila + 1
   BacGlbPrinter nFila, 1, nTab, 1, Lin(15), 0, 1
   
   nFila = nFila + 1
   BacGlbPrinter nFila, 1, nTab, 1, Lin(16), 0, 1
   
   nFila = nFila + 1
   BacGlbPrinter nFila, 1, nTab, 1, Lin(17), 0, 1
   
   nFila = nFila + 1
   BacGlbPrinter nFila, 1, nTab, 1, Lin(18), 0, 1
   
   nFila = nFila + 1
   BacGlbPrinter nFila, 1, nTab, 1, Lin(19), 0, 1
   
   nFila = nFila + 1
   BacGlbPrinter nFila, 1, nTab, 1, Lin(20), 0, 1
   
   nFila = nFila + 1
   BacGlbPrinter nFila, 1, nTab, 1, Lin(21), 0, 1
   
   nFila = nFila + 1
   BacGlbPrinter nFila, 1, nTab, 1, Lin(22), 0, 1
   
   nFila = nFila + 1
   BacGlbPrinter nFila, 1, nTab, 1, Lin(23), 0, 1
   
   nFila = nFila + 1
   BacGlbPrinter nFila, 1, nTab, 1, Lin(24), 0, 1
   
   nFila = nFila + 1
   BacGlbPrinter nFila, 1, nTab, 1, Lin(25), 0, 1
   
   nFila = nFila + 1
   BacGlbPrinter nFila, 1, nTab, 1, Lin(26), 0, 1
   
   nFila = nFila + 1
   BacGlbPrinter nFila, 1, nTab, 1, Lin(27), 0, 1
   
   nFila = nFila + 1
   BacGlbPrinter nFila, 1, nTab, 1, Lin(28), 0, 1
   
   nFila = nFila + 1
   BacGlbPrinter nFila, 1, nTab, 1, Lin(29), 0, 1
   
   BacCentraTexto aString(), Lin(30), 110
   
   For nCont = 1 To UBound(aString())
      nFila = nFila + 1
      sTexto = aString(nCont)

      For nCont2 = 1 To Len(sTexto)
         cCaracter = Mid(sTexto, nCont2, 1)

         If cCaracter = "^" Then
            Printer.FontBold = IIf(Printer.FontBold = False, True, False)
            cCaracter = " "
         End If

         BacGlbPrinter nFila, 1, nTab - 1 + nCont2, 1, cCaracter, 0, 1
      Next

   Next
   
   nFila = nFila + 1
   BacGlbPrinter nFila, 1, nTab, 1, Lin(31), 0, 1
   
   nFila = nFila + 1
   BacGlbPrinter nFila, 1, nTab, 1, Lin(32), 0, 1
   
   nFila = nFila + 1
   BacGlbPrinter nFila, 1, nTab, 1, Lin(33), 0, 1
   
   nFila = nFila + 1
   BacGlbPrinter nFila, 1, nTab, 1, Lin(34), 0, 1
   
   nFila = nFila + 1
   BacGlbPrinter nFila, 1, nTab, 1, Lin(35), 0, 1
   
   nFila = nFila + 1
   BacGlbPrinter nFila, 1, nTab, 1, Lin(36), 0, 1
   
   nFila = nFila + 1
   BacGlbPrinter nFila, 1, nTab, 1, Lin(37), 0, 1
   
   nFila = nFila + 1
   BacGlbPrinter nFila, 1, nTab, 1, Lin(38), 0, 1
   
   nFila = nFila + 1
   BacGlbPrinter nFila, 1, nTab, 1, Lin(39), 0, 1

   BacGlbPrinterEnd

End Function

Public Function BacDOCCondicionesGenerales(DatosCond(), Donde) As Boolean
   On erro GoTo Control:
   Dim Doc2       As Word.Document
   Dim SQL        As String
   Dim Okk        As Boolean
    
   Set Doc2 = IniciaWordListadoLog("Condiciones", Okk)
   Doc2.Activate
    
   If Not Okk Then
      MsgBox "Condiciones Generales no pueden ser Generada", vbCritical, Msj
      Exit Function
   End If
  ' If Year(gsfecha_escritura) = 1900 Then
  '    Call MsgBox("No se ha ingresado fecha de escritura de  " + BacCondicionesGenerales.TxtCliente, vbCritical, App.Title)
  '    Exit Function
  ' End If
   If BacCondicionesGenerales.lblEscrituraApo1.Caption = "01-01-1900" Then
      Call MsgBox("No se ha ingresado fecha de escritura de los representantes de " + Trim(Left(BacCondicionesGenerales.cmbRepBco1, Len(BacCondicionesGenerales.cmbRepBco1) - 15)), vbCritical, App.Title)
      Exit Function
   End If
   If BacCondicionesGenerales.lblEscrituraApo2.Caption = "01-01-1900" Then
      Call MsgBox("No se ha ingresado fecha de escritura de los representantes de " + Trim(Left(BacCondicionesGenerales.cmbRepBco2, Len(BacCondicionesGenerales.cmbRepBco2) - 15)), vbCritical, App.Title)
      Exit Function
   End If
    
   Doc2.Application.Visible = True
   
   '1 Nombre del Banco
   Doc2.Bookmarks("Nombre_Banco_1").Select
   Doc2.Application.Selection.Text = DatosCond(1)
   '1 Nombre del Cliente
   Doc2.Bookmarks("Nombre_Cliente_1").Select
   Doc2.Application.Selection.Text = DatosCond(6)
   '1 Fecha de Proceso
   Doc2.Bookmarks("Fecha_Proceso_1").Select
   Doc2.Application.Selection.Text = BacFormatoFecha("DDMMAA", BacCondicionesGenerales.TXTFecha.Text)
   '1 Nombre del Banco
   Doc2.Bookmarks("Nombre_Banco_2").Select
   Doc2.Application.Selection.Text = DatosCond(1)
   '1 Rut del Banco
   Doc2.Bookmarks("Rut_Banco_1").Select
   Doc2.Application.Selection.Text = DatosCond(2)
   '1 Nombre de Combo
   Doc2.Bookmarks("Apoderado1_Banco_1").Select
   Doc2.Application.Selection.Text = Trim(Left(BacCondicionesGenerales.cmbRepBco1, Len(BacCondicionesGenerales.cmbRepBco1) - 15))
   '1 ID de Combo
   Doc2.Bookmarks("Apoderado_Rut1_Banco_1").Select
   Doc2.Application.Selection.Text = Trim(BacCondicionesGenerales.txtRutRepBco1.Text)
   '2 Nombre de Combo
   Doc2.Bookmarks("Apoderado2_Banco_1").Select
   Doc2.Application.Selection.Text = Trim(Left(BacCondicionesGenerales.cmbRepBco2, Len(BacCondicionesGenerales.cmbRepBco2) - 15))
   '2 ID de Combo
   Doc2.Bookmarks("Apoderado_Rut2_Banco_1").Select
   Doc2.Application.Selection.Text = Trim(BacCondicionesGenerales.txtRutRepBco2.Text)
   '1 Dirección del Banco
   Doc2.Bookmarks("Direccion_Banco_1").Select
   Doc2.Application.Selection.Text = gsc_Parametros.direccion
   'COMUNA
   Doc2.Bookmarks("COMUNA").Select
   Doc2.Application.Selection.Text = Trim(gsc_Parametros.comuna)
   'CIUDAD
   Doc2.Bookmarks("CIUDAD").Select
   Doc2.Application.Selection.Text = gsc_Parametros.Ciudad
   '1 Nombre del Cliente
   Doc2.Bookmarks("Nombre_Cliente_2").Select
   Doc2.Application.Selection.Text = DatosCond(6)
   '1 Dirección del Cliente
   Doc2.Bookmarks("Direccion_Cliente_1").Select
   Doc2.Application.Selection.Text = DatosCond(10)
         
   If Len(BacCondicionesGenerales.cmbRepCliente1.Text) <> 0 And Len(BacCondicionesGenerales.cmbRepCliente2.Text) = 0 Or Len(BacCondicionesGenerales.cmbRepCliente1.Text) <> 0 And Len(BacCondicionesGenerales.cmbRepCliente2.Text) <> 0 Then
      Doc2.Bookmarks("Apoderado1_Cliente_1").Select
      Doc2.Application.Selection.Text = " representada por don " & Trim(Mid(BacCondicionesGenerales.cmbRepCliente1.Text, 1, 30)) & "," & _
                                        " cédula nacional de identidad N° " & BacCondicionesGenerales.txtRutRepCli1
      If Len(BacCondicionesGenerales.cmbRepCliente2.Text) <> 0 Then
         Doc2.Bookmarks("Apoderado2_Cliente_1").Select
         Doc2.Application.Selection.Text = "y don " & Trim(Mid(BacCondicionesGenerales.cmbRepCliente2.Text, 1, 30)) & "," & _
                                           " cédula nacional de identidad N° " & BacCondicionesGenerales.txtRutRepCli2
      End If
   ElseIf Len(BacCondicionesGenerales.cmbRepCliente1.Text) = 0 And Len(BacCondicionesGenerales.cmbRepCliente2.Text) <> 0 Then
      Doc2.Bookmarks("Apoderado2_Cliente_1").Select
      Doc2.Application.Selection.Text = "representada por don " & Trim(Mid(BacCondicionesGenerales.cmbRepCliente2.Text, 1, 30)) & "," & _
                                        " cédula nacional de identidad N° " & BacCondicionesGenerales.cmbRepCliente2
   End If

   'fecha_esc_bco
   Doc2.Bookmarks("FECHA_ESC_BANCO1").Select
   Doc2.Application.Selection.Text = BacFormatoFecha("DDMMAA", BacCondicionesGenerales.lblEscrituraApo1.Caption)
   'fecha_esc_bco
   Doc2.Bookmarks("FECHA_ESC_BANCO2").Select
   Doc2.Application.Selection.Text = BacFormatoFecha("DDMMAA", BacCondicionesGenerales.lblEscrituraApo2.Caption)
   'FECHA_ESCRITURA
   Doc2.Bookmarks("FECHA_ESC_CLIENTE").Select
   Doc2.Application.Selection.Text = BacFormatoFecha("DDMMAA", gsfecha_escritura)
   'NOTARIA
   Doc2.Bookmarks("NOTARIA").Select
   Doc2.Application.Selection.Text = gsnotaria
   'NOTARIA_bco
   Doc2.Bookmarks("notaria_bco").Select
   Doc2.Application.Selection.Text = gsc_Parametros.notaria
   'nombre_banco
   With BacCondicionesGenerales
      Call FIRMAS(Doc2, "Nombre_Banco_3", .txtRutRepBco1.Text, Trim(Left(BacCondicionesGenerales.cmbRepBco1, Len(BacCondicionesGenerales.cmbRepBco1) - 15)), gsc_Parametros.direccion, gsc_Parametros.telefono, gsc_Parametros.fax, BacFormatoRut(Val(gsc_Parametros.Rut) & "-" & gsc_Parametros.digrut), .txtEntidad.Text)
      Call FIRMAS(Doc2, "Nombre_Banco_4", .txtRutRepBco2.Text, Trim(Left(BacCondicionesGenerales.cmbRepBco2, Len(BacCondicionesGenerales.cmbRepBco2) - 15)), gsc_Parametros.direccion, gsc_Parametros.telefono, gsc_Parametros.fax, BacFormatoRut(Val(gsc_Parametros.Rut) & "-" & gsc_Parametros.digrut), .txtEntidad.Text)
   End With
       
   '************************************
   '***** Aqui empieza el anexo 1 ******
   '************************************
   '1 Fecha de Proceso
   Doc2.Bookmarks("Fecha_Proceso_2").Select
   Doc2.Application.Selection.Text = BacFormatoFecha("DDMMAA", BacCondicionesGenerales.TXTFecha.Text)
   '1 Nombre Banco
   Doc2.Bookmarks("Nombre_Banco_5").Select
   Doc2.Application.Selection.Text = DatosCond(1)
   'rut_bco10
   Doc2.Bookmarks("rut_bco10").Select
   Doc2.Application.Selection.Text = DatosCond(2) 'Replace(Format(gsc_Parametros.ACrutprop, "###,###"), ",", ".") + "-" + Format(gsc_Parametros.ACdigprop)
   '1 Nombre de Apoderado del Banco
   Doc2.Bookmarks("Apoderado1_Banco_4").Select
   Doc2.Application.Selection.Text = Trim(Left(BacCondicionesGenerales.cmbRepBco1, Len(BacCondicionesGenerales.cmbRepBco1) - 15))
   'rep_2_bco
   Doc2.Bookmarks("rep_2_bco").Select
   Doc2.Application.Selection.Text = Trim(Left(BacCondicionesGenerales.cmbRepBco2, Len(BacCondicionesGenerales.cmbRepBco2) - 15))
   Doc2.Bookmarks("Direccion_Banco_4").Select
   Doc2.Application.Selection.Text = gsc_Parametros.direccion
   'COMUNA1
   Doc2.Bookmarks("COMUNA1").Select
   Doc2.Application.Selection.Text = Trim(gsc_Parametros.comuna)
   'CIUDAD1
   Doc2.Bookmarks("CIUDAD1").Select
   Doc2.Application.Selection.Text = gsc_Parametros.Ciudad
   Doc2.Bookmarks("Nombre_Cliente_5").Select
   Doc2.Application.Selection.Text = DatosCond(6)
   '1 Dirección del Cliente
   Doc2.Bookmarks("Direccion_Cliente_4").Select
   Doc2.Application.Selection.Text = DatosCond(10)

   If Len(BacCondicionesGenerales.cmbRepCliente1.Text) <> 0 And Len(BacCondicionesGenerales.cmbRepCliente2.Text) = 0 Or Len(BacCondicionesGenerales.cmbRepCliente1.Text) <> 0 And Len(BacCondicionesGenerales.cmbRepCliente2.Text) <> 0 Then
      Doc2.Bookmarks("Apoderado1_Cliente_3").Select
      Doc2.Application.Selection.Text = " representada por don " & Trim(Mid(BacCondicionesGenerales.cmbRepCliente1.Text, 1, 30)) & "," & _
                                        " cédula nacional de identidad N° " & BacCondicionesGenerales.txtRutRepCli1
      If Len(BacCondicionesGenerales.cmbRepCliente2.Text) <> 0 Then
         Doc2.Bookmarks("Apoderado1_Cliente_34").Select
         Doc2.Application.Selection.Text = "y don " & Trim(Mid(BacCondicionesGenerales.cmbRepCliente2.Text, 1, 30)) & "," & _
                                           " cédula nacional de identidad N° " & BacCondicionesGenerales.txtRutRepCli2
      End If
   ElseIf Len(BacCondicionesGenerales.cmbRepCliente1.Text) = 0 And Len(BacCondicionesGenerales.cmbRepCliente2.Text) <> 0 Then
      Doc2.Bookmarks("Apoderado1_Cliente_34").Select
      Doc2.Application.Selection.Text = "representada por don " & Trim(Mid(BacCondicionesGenerales.cmbRepCliente2.Text, 1, 30)) & "," & _
                                        " cédula nacional de identidad N° " & BacCondicionesGenerales.txtRutRepCli2
   End If
   Doc2.Bookmarks("Fecha_Proceso_3").Select
   Doc2.Application.Selection.Text = BacFormatoFecha("DDMMAA", BacCondicionesGenerales.TXTFecha.Text)

   '*************************************
   '*************FIRMAS******************
   '*************************************
   With BacCondicionesGenerales
      Call FIRMAS(Doc2, "Nombre_Banco_6", .txtRutRepBco1.Text, Trim(Left(BacCondicionesGenerales.cmbRepBco1, Len(BacCondicionesGenerales.cmbRepBco1) - 15)), gsc_Parametros.direccion, gsc_Parametros.telefono, gsc_Parametros.fax, BacFormatoRut(Val(gsc_Parametros.Rut) & "-" & gsc_Parametros.digrut), .txtEntidad.Text)
      Call FIRMAS(Doc2, "Nombre_Banco_7", .txtRutRepBco2.Text, Trim(Left(BacCondicionesGenerales.cmbRepBco2, Len(BacCondicionesGenerales.cmbRepBco1) - 15)), gsc_Parametros.direccion, gsc_Parametros.telefono, gsc_Parametros.fax, BacFormatoRut(Val(gsc_Parametros.Rut) & "-" & gsc_Parametros.digrut), .txtEntidad.Text)
   End With
   
   '***********************************
   '***** Aqui empieza el anexo 2 *****
   '***********************************
   '1 Fecha de Proceso
   Doc2.Bookmarks("Fecha_Proceso_4").Select
   Doc2.Application.Selection.Text = BacFormatoFecha("DDMMAA", BacCondicionesGenerales.TXTFecha.Text)
   '1 Nombre Banco
   Doc2.Bookmarks("Nombre_Banco_8").Select
   Doc2.Application.Selection.Text = DatosCond(1)
   Doc2.Bookmarks("Rut_Banco_6").Select
   Doc2.Application.Selection.Text = DatosCond(2) 'Replace(Format(gsc_Parametros.ACrutprop, "###,###"), ",", ".") + "-" + Format(gsc_Parametros.ACdigprop)
   '1 Nombre de Apoderado del Banco
   Doc2.Bookmarks("Apoderado1_Banco_6").Select
   Doc2.Application.Selection.Text = Trim(Left(BacCondicionesGenerales.cmbRepBco1, Len(BacCondicionesGenerales.cmbRepBco1) - 15))
   'rep_3_bco
   Doc2.Bookmarks("rep_3_bco").Select
   Doc2.Application.Selection.Text = Trim(Left(BacCondicionesGenerales.cmbRepBco2, Len(BacCondicionesGenerales.cmbRepBco2) - 15))
   'Direccion_Banco_7
   Doc2.Bookmarks("Direccion_Banco_7").Select
   Doc2.Application.Selection.Text = gsc_Parametros.direccion
   ''COMUNA2
   Doc2.Bookmarks("COMUNA2").Select
   Doc2.Application.Selection.Text = Trim(gsc_Parametros.comuna)
   'CIUDAD2
   Doc2.Bookmarks("CIUDAD2").Select
   Doc2.Application.Selection.Text = gsc_Parametros.Ciudad
   Doc2.Bookmarks("Nombre_Cliente_8").Select
   Doc2.Application.Selection.Text = DatosCond(6)
   '1 Dirección del Cliente
   Doc2.Bookmarks("Direccion_Cliente_7").Select
   Doc2.Application.Selection.Text = DatosCond(10)

   If Len(BacCondicionesGenerales.cmbRepCliente1.Text) <> 0 And Len(BacCondicionesGenerales.cmbRepCliente2.Text) = 0 Or Len(BacCondicionesGenerales.cmbRepCliente1.Text) <> 0 And Len(BacCondicionesGenerales.cmbRepCliente2.Text) <> 0 Then
      Doc2.Bookmarks("Apoderado1_Cliente_5").Select
      Doc2.Application.Selection.Text = " representada por don " & Trim(Mid(BacCondicionesGenerales.cmbRepCliente1.Text, 1, 30)) & "," & _
                                        " cédula nacional de identidad N° " & BacCondicionesGenerales.txtRutRepCli1
      If Len(BacCondicionesGenerales.cmbRepCliente2.Text) <> 0 Then
         Doc2.Bookmarks("rep_cli").Select
         Doc2.Application.Selection.Text = "y don " & Trim(Mid(BacCondicionesGenerales.cmbRepCliente2.Text, 1, 30)) & "," & _
                                           " cédula nacional de identidad N° " & BacCondicionesGenerales.txtRutRepCli2
      End If
   ElseIf Len(BacCondicionesGenerales.cmbRepCliente1.Text) = 0 And Len(BacCondicionesGenerales.cmbRepCliente2.Text) <> 0 Then
      Doc2.Bookmarks("rep_cli").Select
      Doc2.Application.Selection.Text = "representada por don " & Trim(Mid(BacCondicionesGenerales.cmbRepCliente2.Text, 1, 30)) & "," & _
                                        " cédula nacional de identidad N° " & BacCondicionesGenerales.txtRutRepCli2
   End If
   Doc2.Bookmarks("Fecha_Proceso_5").Select
   Doc2.Application.Selection.Text = BacFormatoFecha("DDMMAA", BacCondicionesGenerales.TXTFecha.Text) '
   
   '**************************************
   '************FIRMAS*****************
   '**************************************

   With BacCondicionesGenerales
      Call FIRMAS(Doc2, "Nombre_Banco_9", .txtRutRepBco1.Text, Trim(Left(BacCondicionesGenerales.cmbRepBco1, Len(BacCondicionesGenerales.cmbRepBco1) - 15)), gsc_Parametros.direccion, gsc_Parametros.telefono, gsc_Parametros.fax, BacFormatoRut(Val(gsc_Parametros.Rut) & "-" & gsc_Parametros.digrut), .txtEntidad.Text)
      Call FIRMAS(Doc2, "Nombre_Banco_10", .txtRutRepBco2.Text, Trim(Left(BacCondicionesGenerales.cmbRepBco2, Len(BacCondicionesGenerales.cmbRepBco1) - 15)), gsc_Parametros.direccion, gsc_Parametros.telefono, gsc_Parametros.fax, BacFormatoRut(Val(gsc_Parametros.Rut) & "-" & gsc_Parametros.digrut), .txtEntidad.Text)
   End With
   
   '**************************************
   '***** Aqui empieza el anexo 3 ********
   '**************************************
   '1 Fecha de Proceso
   Doc2.Bookmarks("Fecha_Proceso_6").Select
   Doc2.Application.Selection.Text = BacFormatoFecha("DDMMAA", BacCondicionesGenerales.TXTFecha.Text) '
   '1 Nombre Banco
   Doc2.Bookmarks("Nombre_Banco_11").Select
   Doc2.Application.Selection.Text = DatosCond(1)
   Doc2.Bookmarks("Rut_Banco_9").Select
   Doc2.Application.Selection.Text = DatosCond(2) 'Replace(Format(gsc_Parametros.ACrutprop, "###,###"), ",", ".") + "-" + Format(gsc_Parametros.ACdigprop)
   '1 Nombre de Apoderado del Banco
   Doc2.Bookmarks("Apoderado1_Banco_9").Select
   Doc2.Application.Selection.Text = Trim(Left(BacCondicionesGenerales.cmbRepBco1, Len(BacCondicionesGenerales.cmbRepBco1) - 15))
   'apo_bco
   Doc2.Bookmarks("apo_bco").Select
   Doc2.Application.Selection.Text = Trim(Left(BacCondicionesGenerales.cmbRepBco2, Len(BacCondicionesGenerales.cmbRepBco2) - 15))
   Doc2.Bookmarks("Direccion_Banco_10").Select
   Doc2.Application.Selection.Text = gsc_Parametros.direccion
   'COMUNA3
   Doc2.Bookmarks("COMUNA3").Select
   Doc2.Application.Selection.Text = Trim(gsc_Parametros.comuna)
   'CIUDAD3
   Doc2.Bookmarks("CIUDAD3").Select
   Doc2.Application.Selection.Text = gsc_Parametros.Ciudad
   Doc2.Bookmarks("Nombre_Cliente_11").Select
   Doc2.Application.Selection.Text = DatosCond(6)
   '1 Dirección del Cliente
   Doc2.Bookmarks("Direccion_Cliente_10").Select
   Doc2.Application.Selection.Text = DatosCond(10)
   
   If Len(BacCondicionesGenerales.cmbRepCliente1.Text) <> 0 And Len(BacCondicionesGenerales.cmbRepCliente2.Text) = 0 Or Len(BacCondicionesGenerales.cmbRepCliente1.Text) <> 0 And Len(BacCondicionesGenerales.cmbRepCliente2.Text) <> 0 Then
      Doc2.Bookmarks("Apoderado1_Cliente_8").Select
      Doc2.Application.Selection.Text = " representada por don " & Trim(Mid(BacCondicionesGenerales.cmbRepCliente1.Text, 1, 30)) & "," & _
                                        " cédula nacional de identidad N° " & BacCondicionesGenerales.txtRutRepCli1 'BacFormatoRut(Val(BacCondGeneral.Txt_RutCli1.Text) & "-" & BacCondGeneral.Txt_Digcli1.Text)
      If Len(BacCondicionesGenerales.cmbRepCliente2.Text) <> 0 Then
         Doc2.Bookmarks("apod_cli").Select
         Doc2.Application.Selection.Text = "y don " & Trim(Mid(BacCondicionesGenerales.cmbRepCliente2.Text, 1, 30)) & "," & _
                                           " cédula nacional de identidad N° " & BacCondicionesGenerales.txtRutRepCli2 'BacFormatoRut(Val(BacCondGeneral.Txt_RutCli2.Text) & "-" & BacCondGeneral.Txt_Digcli2.Text)
      End If
   ElseIf Len(BacCondicionesGenerales.cmbRepCliente1.Text) = 0 And Len(BacCondicionesGenerales.cmbRepCliente2.Text) <> 0 Then
      Doc2.Bookmarks("apod_cli").Select
      Doc2.Application.Selection.Text = "representada por don " & Trim(Mid(BacCondicionesGenerales.cmbRepCliente2.Text, 1, 30)) & "," & _
                                        " cédula nacional de identidad N° " & BacCondicionesGenerales.txtRutRepCli2 'BacFormatoRut(Val(BacCondGeneral.Txt_RutCli2.Text) & "-" & BacCondGeneral.Txt_Digcli2.Text)
   End If
      
   Doc2.Bookmarks("Fecha_Proceso_7").Select
   Doc2.Application.Selection.Text = BacFormatoFecha("DDMMAA", BacCondicionesGenerales.TXTFecha.Text) '
   
   '***************************************
   '************FIRMAS*********************
   '***************************************
   With BacCondicionesGenerales
      Call FIRMAS(Doc2, "Nombre_Banco_12", .txtRutRepBco1.Text, Trim(Left(BacCondicionesGenerales.cmbRepBco1, Len(BacCondicionesGenerales.cmbRepBco1) - 15)), gsc_Parametros.direccion, gsc_Parametros.telefono, gsc_Parametros.fax, BacFormatoRut(Val(gsc_Parametros.Rut) & "-" & gsc_Parametros.digrut), .txtEntidad.Text)
      Call FIRMAS(Doc2, "Nombre_Cliente_14", .txtRutRepBco2.Text, Trim(Left(BacCondicionesGenerales.cmbRepBco2, Len(BacCondicionesGenerales.cmbRepBco1) - 15)), gsc_Parametros.direccion, gsc_Parametros.telefono, gsc_Parametros.fax, BacFormatoRut(Val(gsc_Parametros.Rut) & "-" & gsc_Parametros.digrut), .txtEntidad.Text)
   End With

   '*********************************
   '***** Aqui empieza el anexo 4 ***
   '*********************************
   '1 Fecha de Proceso
   Doc2.Bookmarks("Fecha_Proceso_8").Select
   Doc2.Application.Selection.Text = BacFormatoFecha("DDMMAA", BacCondicionesGenerales.TXTFecha.Text)
   '1 Nombre Banco
   Doc2.Bookmarks("Nombre_Banco_14").Select
   Doc2.Application.Selection.Text = DatosCond(1)
   'rut_bco_prin
   Doc2.Bookmarks("rut_bco_prin").Select
   Doc2.Application.Selection.Text = DatosCond(2) 'Replace(Format(gsc_Parametros.ACrutprop, "###,###"), ",", ".") + "-" + Format(gsc_Parametros.ACdigprop)
   '1 Nombre de Apoderado del Banco
   Doc2.Bookmarks("Apoderado1_Banco_12").Select
   Doc2.Application.Selection.Text = Trim(Left(BacCondicionesGenerales.cmbRepBco1, Len(BacCondicionesGenerales.cmbRepBco1) - 15))
   'apod_bco
   Doc2.Bookmarks("apod_bco").Select
   Doc2.Application.Selection.Text = Trim(Left(BacCondicionesGenerales.cmbRepBco2, Len(BacCondicionesGenerales.cmbRepBco2) - 15))
   Doc2.Bookmarks("Direccion_Banco_13").Select
   Doc2.Application.Selection.Text = gsc_Parametros.direccion
   'COMUNA4
   Doc2.Bookmarks("COMUNA4").Select
   Doc2.Application.Selection.Text = Trim(gsc_Parametros.comuna)
   'CIUDAD4
   Doc2.Bookmarks("CIUDAD4").Select
   Doc2.Application.Selection.Text = gsc_Parametros.Ciudad
   Doc2.Bookmarks("Nombre_Cliente_12").Select
   Doc2.Application.Selection.Text = DatosCond(6)

   If Len(BacCondicionesGenerales.cmbRepCliente1.Text) <> 0 And Len(BacCondicionesGenerales.cmbRepCliente2.Text) = 0 Or Len(BacCondicionesGenerales.cmbRepCliente1.Text) <> 0 And Len(BacCondicionesGenerales.cmbRepCliente2.Text) <> 0 Then
      Doc2.Bookmarks("Apoderado1_Cliente_9").Select
      Doc2.Application.Selection.Text = " representada por don " & Trim(Mid(BacCondicionesGenerales.cmbRepCliente1.Text, 1, 30)) & "," & _
                                        " cédula nacional de identidad N° " & BacCondicionesGenerales.txtRutRepCli1 'BacFormatoRut(Val(BacCondGeneral.Txt_RutCli1.Text) & "-" & BacCondGeneral.Txt_Digcli1.Text)
      If Len(BacCondicionesGenerales.cmbRepCliente2.Text) <> 0 Then
         Doc2.Bookmarks("rep_cli_1").Select
         Doc2.Application.Selection.Text = "y don " & Trim(Mid(BacCondicionesGenerales.cmbRepCliente2.Text, 1, 30)) & "," & _
                                           " cédula nacional de identidad N° " & BacCondicionesGenerales.txtRutRepCli2 'BacFormatoRut(Val(BacCondGeneral.Txt_RutCli2.Text) & "-" & BacCondGeneral.Txt_Digcli2.Text)
      End If
   ElseIf Len(BacCondicionesGenerales.cmbRepCliente1.Text) = 0 And Len(BacCondicionesGenerales.cmbRepCliente2.Text) <> 0 Then
      Doc2.Bookmarks("rep_cli_1").Select
      Doc2.Application.Selection.Text = "representada por don " & Trim(Mid(BacCondicionesGenerales.cmbRepCliente2.Text, 1, 30)) & "," & _
                                        " cédula nacional de identidad N° " & BacCondicionesGenerales.txtRutRepCli2 'BacFormatoRut(Val(BacCondGeneral.Txt_RutCli2.Text) & "-" & BacCondGeneral.Txt_Digcli2.Text)
   End If
   
   '1 Dirección del Cliente
   Doc2.Bookmarks("Direccion_Cliente_11").Select
   Doc2.Application.Selection.Text = DatosCond(10)
   'fecha
   Doc2.Bookmarks("fecha").Select
   Doc2.Application.Selection.Text = BacFormatoFecha("DDMMAA", BacCondicionesGenerales.TXTFecha.Text)
   '*************************************
   '*************************************
   '*************************************
   With BacCondicionesGenerales
      FIRMAS Doc2, "Nombre_Banco_13", .txtRutRepBco1.Text, Trim(Left(BacCondicionesGenerales.cmbRepBco1, Len(BacCondicionesGenerales.cmbRepBco1) - 15)), gsc_Parametros.direccion, gsc_Parametros.telefono, gsc_Parametros.fax, BacFormatoRut(Val(gsc_Parametros.Rut) & "-" & gsc_Parametros.digrut), .txtEntidad.Text
      FIRMAS Doc2, "pp_bco", .txtRutRepBco2.Text, Trim(Left(BacCondicionesGenerales.cmbRepBco2, Len(BacCondicionesGenerales.cmbRepBco2) - 15)), gsc_Parametros.direccion, gsc_Parametros.telefono, gsc_Parametros.fax, BacFormatoRut(Val(gsc_Parametros.Rut) & "-" & gsc_Parametros.digrut), .txtEntidad.Text
   End With
   '*************************************
   '***** Aqui empieza el anexo 5 *******
   '*************************************
   '1 Fecha de Proceso
   Doc2.Bookmarks("Fecha_Proceso_9").Select
   Doc2.Application.Selection.Text = BacFormatoFecha("DDMMAA", BacCondicionesGenerales.TXTFecha.Text)
   '1 Nombre Banco
   Doc2.Bookmarks("Nombre_Banco_17").Select
   Doc2.Application.Selection.Text = DatosCond(1)
   'rut_bco2
   Doc2.Bookmarks("rut_bco2").Select
   Doc2.Application.Selection.Text = DatosCond(1) 'Replace(Format(gsc_Parametros.ACrutprop, "###,###"), ",", ".") + "-" + Format(gsc_Parametros.ACdigprop)
   '1 Nombre de Apoderado del Banco
   Doc2.Bookmarks("Apoderado1_Banco_15").Select
   Doc2.Application.Selection.Text = Trim(Left(BacCondicionesGenerales.cmbRepBco1, Len(BacCondicionesGenerales.cmbRepBco1) - 15))
   'rep_bco
   Doc2.Bookmarks("rep_bco").Select
   Doc2.Application.Selection.Text = Trim(Left(BacCondicionesGenerales.cmbRepBco2, Len(BacCondicionesGenerales.cmbRepBco2) - 15))
   Doc2.Bookmarks("Direccion_Banco_16").Select
   Doc2.Application.Selection.Text = gsc_Parametros.direccion
   'COMUNA5
   Doc2.Bookmarks("COMUNA5").Select
   Doc2.Application.Selection.Text = Trim(gsc_Parametros.comuna)
   'CIUDAD5
   Doc2.Bookmarks("CIUDAD5").Select
   Doc2.Application.Selection.Text = gsc_Parametros.Ciudad
   Doc2.Bookmarks("Nombre_Cliente_13").Select
   Doc2.Application.Selection.Text = DatosCond(6)
         
   If Len(BacCondicionesGenerales.cmbRepCliente1.Text) <> 0 And Len(BacCondicionesGenerales.cmbRepCliente2.Text) = 0 Or Len(BacCondicionesGenerales.cmbRepCliente1.Text) <> 0 And Len(BacCondicionesGenerales.cmbRepCliente2.Text) <> 0 Then
      Doc2.Bookmarks("Apoderado1_Cliente_10").Select
      Doc2.Application.Selection.Text = " representada por don " & Trim(Mid(BacCondicionesGenerales.cmbRepCliente1.Text, 1, 30)) & "," & _
                                        " cédula nacional de identidad N° " & BacCondicionesGenerales.txtRutRepCli1 'BacFormatoRut(Val(BacCondGeneral.Txt_RutCli1.Text) & "-" & BacCondGeneral.Txt_Digcli1.Text)
      If Len(BacCondicionesGenerales.cmbRepCliente2.Text) <> 0 Then
         Doc2.Bookmarks("rep_cli1").Select
         Doc2.Application.Selection.Text = "y don " & Trim(Mid(BacCondicionesGenerales.cmbRepCliente2.Text, 1, 30)) & "," & _
                                           " cédula nacional de identidad N° " & BacCondicionesGenerales.txtRutRepCli2 'BacFormatoRut(Val(BacCondGeneral.Txt_RutCli2.Text) & "-" & BacCondGeneral.Txt_Digcli2.Text)
      End If
   ElseIf Len(BacCondicionesGenerales.cmbRepCliente1.Text) = 0 And Len(BacCondicionesGenerales.cmbRepCliente2.Text) <> 0 Then
      Doc2.Bookmarks("rep_cli1").Select
      Doc2.Application.Selection.Text = "representada por don " & Trim(Mid(BacCondicionesGenerales.cmbRepCliente2.Text, 1, 30)) & "," & _
                                        " cédula nacional de identidad N° " & BacCondicionesGenerales.txtRutRepCli2 'BacFormatoRut(Val(BacCondGeneral.Txt_RutCli2.Text) & "-" & BacCondGeneral.Txt_Digcli2.Text)
   End If

         '1 Dirección del Cliente
          Doc2.Bookmarks("Direccion_Cliente_12").Select
          Doc2.Application.Selection.Text = DatosCond(10)

          Doc2.Bookmarks("fecha1").Select
          Doc2.Application.Selection.Text = BacFormatoFecha("DDMMAA", BacCondicionesGenerales.TXTFecha.Text)
   '         '**********************************
   '         '***************Firmas _ordenadas**
   '         '**********************************
         With BacCondicionesGenerales
            FIRMAS Doc2, "Nombre_Banco_15", .txtRutRepBco1.Text, Trim(Left(BacCondicionesGenerales.cmbRepBco1, Len(BacCondicionesGenerales.cmbRepBco1) - 15)), gsc_Parametros.direccion, gsc_Parametros.telefono, gsc_Parametros.fax, BacFormatoRut(Val(gsc_Parametros.Rut) & "-" & gsc_Parametros.digrut), .txtEntidad.Text
            FIRMAS Doc2, "pp_bco1", .txtRutRepBco2.Text, Trim(Left(BacCondicionesGenerales.cmbRepBco2, Len(BacCondicionesGenerales.cmbRepBco2) - 15)), gsc_Parametros.direccion, gsc_Parametros.telefono, gsc_Parametros.fax, BacFormatoRut(Val(gsc_Parametros.Rut) & "-" & gsc_Parametros.digrut), .txtEntidad.Text
         End With

   '****************************************
   '***** Aqui empieza el anexo 6 **********
   '****************************************
   '1 Fecha de Proceso
   Doc2.Bookmarks("Fecha_Proceso_10").Select
   Doc2.Application.Selection.Text = BacFormatoFecha("DDMMAA", BacCondicionesGenerales.TXTFecha.Text)

   '1 Nombre Banco
   Doc2.Bookmarks("Nombre_Banco_18").Select
   Doc2.Application.Selection.Text = DatosCond(1)

   'rut_bco4
   Doc2.Bookmarks("rut_bco4").Select
   Doc2.Application.Selection.Text = DatosCond(2)

   '1 Nombre de Apoderado del Banco
   Doc2.Bookmarks("Apoderado1_Banco_16").Select
   Doc2.Application.Selection.Text = Trim(Left(BacCondicionesGenerales.cmbRepBco1, Len(BacCondicionesGenerales.cmbRepBco1) - 15))

   'rep_bco1
   Doc2.Bookmarks("rep_bco1").Select
   Doc2.Application.Selection.Text = Trim(Left(BacCondicionesGenerales.cmbRepBco2, Len(BacCondicionesGenerales.cmbRepBco2) - 15))

   Doc2.Bookmarks("Direccion_Banco_17").Select
   Doc2.Application.Selection.Text = gsc_Parametros.direccion

   'COMUNA6
   Doc2.Bookmarks("COMUNA6").Select
   Doc2.Application.Selection.Text = Trim(gsc_Parametros.comuna)

   'CIUDAD6
   Doc2.Bookmarks("CIUDAD6").Select
   Doc2.Application.Selection.Text = gsc_Parametros.Ciudad

   Doc2.Bookmarks("Nombre_Cliente_17").Select
   Doc2.Application.Selection.Text = DatosCond(6)
         
   If Len(BacCondicionesGenerales.cmbRepCliente1.Text) <> 0 And Len(BacCondicionesGenerales.cmbRepCliente2.Text) = 0 Or Len(BacCondicionesGenerales.cmbRepCliente1.Text) <> 0 And Len(BacCondicionesGenerales.cmbRepCliente2.Text) <> 0 Then
      Doc2.Bookmarks("Apoderado1_Cliente_14").Select
      Doc2.Application.Selection.Text = " representada por don " & Trim(Mid(BacCondicionesGenerales.cmbRepCliente1.Text, 1, 30)) & "," & _
      " cédula nacional de identidad N° " & BacCondicionesGenerales.txtRutRepCli1 'BacFormatoRut(Val(BacCondGeneral.Txt_RutCli1.Text) & "-" & BacCondGeneral.Txt_Digcli1.Text)

      If Len(BacCondicionesGenerales.cmbRepCliente2.Text) <> 0 Then
         Doc2.Bookmarks("rep_cli2").Select
         Doc2.Application.Selection.Text = "y don " & Trim(Mid(BacCondicionesGenerales.cmbRepCliente2.Text, 1, 30)) & "," & _
         " cédula nacional de identidad N° " & BacCondicionesGenerales.txtRutRepCli2 'BacFormatoRut(Val(BacCondGeneral.Txt_RutCli2.Text) & "-" & BacCondGeneral.Txt_Digcli2.Text)
      End If
   ElseIf Len(BacCondicionesGenerales.cmbRepCliente1.Text) = 0 And Len(BacCondicionesGenerales.cmbRepCliente2.Text) <> 0 Then

      Doc2.Bookmarks("rep_cli2").Select
      Doc2.Application.Selection.Text = "representada por don " & Trim(Mid(BacCondicionesGenerales.cmbRepCliente2.Text, 1, 30)) & "," & _
      " cédula nacional de identidad N° " & BacCondicionesGenerales.txtRutRepCli2 'BacFormatoRut(Val(BacCondGeneral.Txt_RutCli2.Text) & "-" & BacCondGeneral.Txt_Digcli2.Text)
   End If
         
   '1 Dirección del Cliente
   Doc2.Bookmarks("Direccion_Cliente_16").Select
   Doc2.Application.Selection.Text = DatosCond(10)

   'fecha2
   Doc2.Bookmarks("fecha2").Select
   Doc2.Application.Selection.Text = BacFormatoFecha("DDMMAA", BacCondicionesGenerales.TXTFecha.Text)
   
   '**************************************
   '*************firmas*******************
   '**************************************
         
   With BacCondicionesGenerales
      FIRMAS Doc2, "Nombre_Banco_16", .txtRutRepBco1.Text, Trim(Left(BacCondicionesGenerales.cmbRepBco1, Len(BacCondicionesGenerales.cmbRepBco1) - 15)), gsc_Parametros.direccion, gsc_Parametros.telefono, gsc_Parametros.fax, BacFormatoRut(Val(gsc_Parametros.Rut) & "-" & gsc_Parametros.digrut), .txtEntidad.Text
      FIRMAS Doc2, "pp_bco2", .txtRutRepBco1.Text, Trim(Left(BacCondicionesGenerales.cmbRepBco2, Len(BacCondicionesGenerales.cmbRepBco2) - 15)), gsc_Parametros.direccion, gsc_Parametros.telefono, gsc_Parametros.fax, BacFormatoRut(Val(gsc_Parametros.Rut) & "-" & gsc_Parametros.digrut), .txtEntidad.Text
   End With

   '*************************************
   '***** Aqui empieza el anexo 7 *******
   '*************************************
   '1 Fecha de Proceso
   Doc2.Bookmarks("Fecha_Proceso_11").Select
   Doc2.Application.Selection.Text = BacFormatoFecha("DDMMAA", BacCondicionesGenerales.TXTFecha.Text)

   '1 Nombre Banco
   Doc2.Bookmarks("Nombre_Banco_19").Select
   Doc2.Application.Selection.Text = DatosCond(1)

   'rut_bco6
   Doc2.Bookmarks("rut_bco6").Select
   Doc2.Application.Selection.Text = DatosCond(2) 'Replace(Format(gsc_Parametros.ACrutprop, "###,###"), ",", ".") + "-" + Format(gsc_Parametros.ACdigprop)

   '1 Nombre de Apoderado del Banco
   Doc2.Bookmarks("Apoderado1_Banco_17").Select
   Doc2.Application.Selection.Text = Trim(Left(BacCondicionesGenerales.cmbRepBco1, Len(BacCondicionesGenerales.cmbRepBco1) - 15))

   'apod_bco4
   Doc2.Bookmarks("apod_bco4").Select
   Doc2.Application.Selection.Text = Trim(Left(BacCondicionesGenerales.cmbRepBco2, Len(BacCondicionesGenerales.cmbRepBco2) - 15))

   Doc2.Bookmarks("Direccion_Banco_18").Select
   Doc2.Application.Selection.Text = gsc_Parametros.direccion

   'COMUNA7
   Doc2.Bookmarks("COMUNA7").Select
   Doc2.Application.Selection.Text = Trim(gsc_Parametros.comuna)

   'CIUDAD7
   Doc2.Bookmarks("CIUDAD7").Select
   Doc2.Application.Selection.Text = gsc_Parametros.Ciudad

   Doc2.Bookmarks("Nombre_Cliente_19").Select
   Doc2.Application.Selection.Text = DatosCond(6)
         
   If Len(BacCondicionesGenerales.cmbRepCliente1.Text) <> 0 And Len(BacCondicionesGenerales.cmbRepCliente2.Text) = 0 Or Len(BacCondicionesGenerales.cmbRepCliente1.Text) <> 0 And Len(BacCondicionesGenerales.cmbRepCliente2.Text) <> 0 Then
      Doc2.Bookmarks("Apoderado1_Cliente_16").Select
      Doc2.Application.Selection.Text = " representada por don " & Trim(Mid(BacCondicionesGenerales.cmbRepCliente1.Text, 1, 30)) & "," & _
      " cédula nacional de identidad N° " & BacCondicionesGenerales.txtRutRepCli1 'BacFormatoRut(Val(BacCondGeneral.Txt_RutCli2.Text) & "-" & BacCondGeneral.Txt_Digcli2.Text)
      If Len(BacCondicionesGenerales.cmbRepCliente2.Text) <> 0 Then
         Doc2.Bookmarks("apod_bco5").Select
         Doc2.Application.Selection.Text = "y don " & Trim(Mid(BacCondicionesGenerales.cmbRepCliente2.Text, 1, 30)) & "," & _
         " cédula nacional de identidad N° " & BacCondicionesGenerales.txtRutRepCli2 'BacFormatoRut(Val(BacCondGeneral.Txt_RutCli2.Text) & "-" & BacCondGeneral.Txt_Digcli2.Text)
      End If
   ElseIf Len(BacCondicionesGenerales.cmbRepCliente1.Text) = 0 And Len(BacCondicionesGenerales.cmbRepCliente2.Text) <> 0 Then
      Doc2.Bookmarks("apod_bco5").Select
      Doc2.Application.Selection.Text = "representada por don " & Trim(Mid(BacCondicionesGenerales.cmbRepCliente2.Text, 1, 30)) & "," & _
      " cédula nacional de identidad N° " & BacCondicionesGenerales.txtRutRepCli2 'BacFormatoRut(Val(BacCondGeneral.Txt_RutCli2.Text) & "-" & BacCondGeneral.Txt_Digcli2.Text)
   End If

   '1 Dirección del Cliente
   Doc2.Bookmarks("Direccion_Cliente_18").Select
   Doc2.Application.Selection.Text = DatosCond(10)

   'fecha3
   Doc2.Bookmarks("fecha3").Select
   Doc2.Application.Selection.Text = BacFormatoFecha("DDMMAA", BacCondicionesGenerales.TXTFecha.Text)
   
   '**************************************
   '*************firmas*******************
   '**************************************
   With BacCondicionesGenerales
      FIRMAS Doc2, "Nombre_Banco_20", .txtRutRepBco1, Trim(Left(BacCondicionesGenerales.cmbRepBco1, Len(BacCondicionesGenerales.cmbRepBco1) - 15)), gsc_Parametros.direccion, gsc_Parametros.telefono, gsc_Parametros.fax, BacFormatoRut(Val(gsc_Parametros.Rut) & "-" & gsc_Parametros.digrut), .txtEntidad.Text
      FIRMAS Doc2, "pp_bco3", .txtRutRepBco2.Text, Trim(Left(BacCondicionesGenerales.cmbRepBco2, Len(BacCondicionesGenerales.cmbRepBco2) - 15)), gsc_Parametros.direccion, gsc_Parametros.telefono, gsc_Parametros.fax, BacFormatoRut(Val(gsc_Parametros.Rut) & "-" & gsc_Parametros.digrut), .txtEntidad.Text
   End With

   ' *************************************
   '  ************Anexo 8******************
   
   'Fecha_Proceso_12
   Doc2.Bookmarks("Fecha_Proceso_12").Select
   Doc2.Application.Selection.Text = BacFormatoFecha("DDMMAA", BacCondicionesGenerales.TXTFecha.Text)

   'Nombre_Banco_21
   Doc2.Bookmarks("Nombre_Banco_21").Select
   Doc2.Application.Selection.Text = DatosCond(1)

   'rut_bco8
   Doc2.Bookmarks("rut_bco8").Select
   Doc2.Application.Selection.Text = DatosCond(2) 'Replace(Format(gsc_Parametros.ACrutprop, "###,###"), ",", ".") + "-" + Format(gsc_Parametros.ACdigprop)

   'Apoderado1_Banco_19
   Doc2.Bookmarks("Apoderado1_Banco_19").Select
   Doc2.Application.Selection.Text = Trim(Left(BacCondicionesGenerales.cmbRepBco1, Len(BacCondicionesGenerales.cmbRepBco1) - 15))

   'apod_bco7
   Doc2.Bookmarks("apod_bco7").Select
   Doc2.Application.Selection.Text = Trim(Left(BacCondicionesGenerales.cmbRepBco2, Len(BacCondicionesGenerales.cmbRepBco2) - 15))

   Doc2.Bookmarks("Direccion_Banco_20").Select
   Doc2.Application.Selection.Text = gsc_Parametros.direccion

   'COMUNA8
   Doc2.Bookmarks("COMUNA8").Select
   Doc2.Application.Selection.Text = Trim(gsc_Parametros.comuna)

   'CIUDAD8
   Doc2.Bookmarks("CIUDAD8").Select
   Doc2.Application.Selection.Text = gsc_Parametros.Ciudad

   Doc2.Bookmarks("Nombre_Cliente_21").Select
   Doc2.Application.Selection.Text = DatosCond(6)

   If Len(BacCondicionesGenerales.cmbRepCliente1.Text) <> 0 And Len(BacCondicionesGenerales.cmbRepCliente2.Text) = 0 Or Len(BacCondicionesGenerales.cmbRepCliente1.Text) <> 0 And Len(BacCondicionesGenerales.cmbRepCliente2.Text) <> 0 Then
      Doc2.Bookmarks("Apoderado1_Cliente_18").Select
      Doc2.Application.Selection.Text = " representada por don " & Trim(Mid(BacCondicionesGenerales.cmbRepCliente1.Text, 1, 30)) & "," & _
      " cédula nacional de identidad N° " & BacCondicionesGenerales.txtRutRepCli1 'BacFormatoRut(Val(BacCondGeneral.Txt_RutCli2.Text) & "-" & BacCondGeneral.Txt_Digcli2.Text)

      If Len(BacCondicionesGenerales.cmbRepCliente2.Text) <> 0 Then
         Doc2.Bookmarks("apod_bco8").Select
         Doc2.Application.Selection.Text = "y don " & Trim(Mid(BacCondicionesGenerales.cmbRepCliente2.Text, 1, 30)) & "," & _
         " cédula nacional de identidad N° " & BacCondicionesGenerales.txtRutRepCli2 'BacFormatoRut(Val(BacCondGeneral.Txt_RutCli2.Text) & "-" & BacCondGeneral.Txt_Digcli2.Text)
      End If
   ElseIf Len(BacCondicionesGenerales.cmbRepCliente1.Text) = 0 And Len(BacCondicionesGenerales.cmbRepCliente2.Text) <> 0 Then
      Doc2.Bookmarks("apod_bco8").Select
      Doc2.Application.Selection.Text = "representada por don " & Trim(Mid(BacCondicionesGenerales.cmbRepCliente2.Text, 1, 30)) & "," & _
      " cédula nacional de identidad N° " & BacCondicionesGenerales.txtRutRepCli2 'BacFormatoRut(Val(BacCondGeneral.Txt_RutCli2.Text) & "-" & BacCondGeneral.Txt_Digcli2.Text)
   End If
        
   'Direccion_Cliente_20
   Doc2.Bookmarks("Direccion_Cliente_20").Select
   Doc2.Application.Selection.Text = DatosCond(10)
   
   'fecha4
   Doc2.Bookmarks("fecha4").Select
   Doc2.Application.Selection.Text = BacFormatoFecha("DDMMAA", BacCondicionesGenerales.TXTFecha.Text)

      ' '**************************************
      ' '*************firmas*******************
      ' '**************************************
   With BacCondicionesGenerales
      Call FIRMAS(Doc2, "Nombre_Banco_22", .txtRutRepBco1.Text, Trim(Left(BacCondicionesGenerales.cmbRepBco1, Len(BacCondicionesGenerales.cmbRepBco1) - 15)), gsc_Parametros.direccion, gsc_Parametros.telefono, gsc_Parametros.fax, BacFormatoRut(Val(gsc_Parametros.Rut) & "-" & gsc_Parametros.digrut), .txtEntidad.Text)
      Call FIRMAS(Doc2, "pp_bco4", .txtRutRepBco2.Text, Trim(Left(BacCondicionesGenerales.cmbRepBco2, Len(BacCondicionesGenerales.cmbRepBco2) - 15)), gsc_Parametros.direccion, gsc_Parametros.telefono, gsc_Parametros.fax, BacFormatoRut(Val(gsc_Parametros.Rut) & "-" & gsc_Parametros.digrut), .txtEntidad.Text)
   End With

   With BacCondicionesGenerales
      Call FIRMAS(Doc2, "Nombre_Cliente_3", .txtRutRepCli1, Trim(Left(BacCondicionesGenerales.cmbRepCliente1, Len(BacCondicionesGenerales.cmbRepCliente1) - 15)), .txtDirecCli, gsFono, gsFax, BacFormatoRut(gsCodigo & "-" & gsDigito), gsNombre)
      Call FIRMAS(Doc2, "Nombre_Cliente_4", .txtRutRepCli2, Trim(Left(BacCondicionesGenerales.cmbRepCliente2, Len(BacCondicionesGenerales.cmbRepCliente2) - 15)), .txtDirecCli, gsFono, gsFax, BacFormatoRut(gsCodigo & "-" & gsDigito), gsNombre)

      Call FIRMAS(Doc2, "Nombre_Cliente_6", .txtRutRepCli1, Trim(Left(BacCondicionesGenerales.cmbRepCliente1, Len(BacCondicionesGenerales.cmbRepCliente1) - 15)), .txtDirecCli, gsFono, gsFax, BacFormatoRut(gsCodigo & "-" & gsDigito), gsNombre)
      Call FIRMAS(Doc2, "Nombre_Cliente_7", .txtRutRepCli2, Trim(Left(BacCondicionesGenerales.cmbRepCliente2, Len(BacCondicionesGenerales.cmbRepCliente2) - 15)), .txtDirecCli, gsFono, gsFax, BacFormatoRut(gsCodigo & "-" & gsDigito), gsNombre)
      
      Call FIRMAS(Doc2, "Nombre_Cliente_9", .txtRutRepCli1, Trim(Left(BacCondicionesGenerales.cmbRepCliente1, Len(BacCondicionesGenerales.cmbRepCliente1) - 15)), .txtDirecCli, gsFono, gsFax, BacFormatoRut(gsCodigo & "-" & gsDigito), gsNombre)
      Call FIRMAS(Doc2, "Nombre_Cliente_10", .txtRutRepCli2, Trim(Left(BacCondicionesGenerales.cmbRepCliente2, Len(BacCondicionesGenerales.cmbRepCliente2) - 15)), .txtDirecCli, gsFono, gsFax, BacFormatoRut(gsCodigo & "-" & gsDigito), gsNombre)
      
      Call FIRMAS(Doc2, "pp_cli", .txtRutRepCli1, Trim(Left(BacCondicionesGenerales.cmbRepCliente1, Len(BacCondicionesGenerales.cmbRepCliente1) - 15)), .txtDirecCli, gsFono, gsFax, BacFormatoRut(gsCodigo & "-" & gsDigito), gsNombre)
      Call FIRMAS(Doc2, "pp_cli1", .txtRutRepCli2, Trim(Left(BacCondicionesGenerales.cmbRepCliente2, Len(BacCondicionesGenerales.cmbRepCliente2) - 15)), .txtDirecCli, gsFono, gsFax, BacFormatoRut(gsCodigo & "-" & gsDigito), gsNombre)
      
      Call FIRMAS(Doc2, "Nombre_Cliente_15", .txtRutRepCli1, Trim(Left(BacCondicionesGenerales.cmbRepCliente1, Len(BacCondicionesGenerales.cmbRepCliente1) - 15)), .txtDirecCli, gsFono, gsFax, BacFormatoRut(gsCodigo & "-" & gsDigito), gsNombre)
      Call FIRMAS(Doc2, "pp_cli2", .txtRutRepCli2, Trim(Left(BacCondicionesGenerales.cmbRepCliente2, Len(BacCondicionesGenerales.cmbRepCliente2) - 15)), .txtDirecCli, gsFono, gsFax, BacFormatoRut(gsCodigo & "-" & gsDigito), gsNombre)
      
      Call FIRMAS(Doc2, "Nombre_Cliente_16", .txtRutRepCli1, Trim(Left(BacCondicionesGenerales.cmbRepCliente1, Len(BacCondicionesGenerales.cmbRepCliente1) - 15)), .txtDirecCli, gsFono, gsFax, BacFormatoRut(gsCodigo & "-" & gsDigito), gsNombre)
      Call FIRMAS(Doc2, "pp_cli3", .txtRutRepCli2, Trim(Left(BacCondicionesGenerales.cmbRepCliente2, Len(BacCondicionesGenerales.cmbRepCliente2) - 15)), .txtDirecCli, gsFono, gsFax, BacFormatoRut(gsCodigo & "-" & gsDigito), gsNombre)
      
      Call FIRMAS(Doc2, "Nombre_Cliente_18", .txtRutRepCli1, Trim(Left(BacCondicionesGenerales.cmbRepCliente1, Len(BacCondicionesGenerales.cmbRepCliente1) - 15)), .txtDirecCli, gsFono, gsFax, BacFormatoRut(gsCodigo & "-" & gsDigito), gsNombre)
      Call FIRMAS(Doc2, "pp_cli4", .txtRutRepCli2, Trim(Left(BacCondicionesGenerales.cmbRepCliente2, Len(BacCondicionesGenerales.cmbRepCliente2) - 15)), .txtDirecCli, gsFono, gsFax, BacFormatoRut(gsCodigo & "-" & gsDigito), gsNombre)
      
      Call FIRMAS(Doc2, "Nombre_Cliente_20", .txtRutRepCli1, Trim(Left(BacCondicionesGenerales.cmbRepCliente1, Len(BacCondicionesGenerales.cmbRepCliente1) - 15)), .txtDirecCli, gsFono, gsFax, BacFormatoRut(gsCodigo & "-" & gsDigito), gsNombre)
      Call FIRMAS(Doc2, "pp_cli5", .txtRutRepCli2, Trim(Left(BacCondicionesGenerales.cmbRepCliente2, Len(BacCondicionesGenerales.cmbRepCliente2) - 15)), .txtDirecCli, gsFono, gsFax, BacFormatoRut(gsCodigo & "-" & gsDigito), gsNombre)
      
      Call FIRMAS(Doc2, "Nombre_Cliente_22", .txtRutRepCli1, Trim(Left(BacCondicionesGenerales.cmbRepCliente1, Len(BacCondicionesGenerales.cmbRepCliente1) - 15)), .txtDirecCli, gsFono, gsFax, BacFormatoRut(gsCodigo & "-" & gsDigito), gsNombre)
      Call FIRMAS(Doc2, "pp_cli6", .txtRutRepCli2, Trim(Left(BacCondicionesGenerales.cmbRepCliente2, Len(BacCondicionesGenerales.cmbRepCliente2) - 15)), .txtDirecCli, gsFono, gsFax, BacFormatoRut(gsCodigo & "-" & gsDigito), gsNombre)
   End With

   'ActiveDocument.SaveAs FileName:=DatosCond(20) & "\Condiciones Generales " & DatosCond(6) & ".doc"
   If Donde = "Impresora" Then
      ActiveDocument.PrintOut
   Else
      Doc2.Application.Visible = True
   End If
    
   'Actualizacion Fecha de Condiciones de Generales en Tabla Cliente
   SQL = ""
   SQL = SQL & " UPDATE VIEW_CLIENTE SET clFechaFirma_cond = '" & Format(BacCondicionesGenerales.TXTFecha.Text, "yyyymmdd") & "'"
   SQL = SQL & " WHERE  clrut = " & gsCodigo & " and clcodigo  = " & gsCodCli

   If MISQL.SQL_Execute(SQL) <> 0 Then
      MsgBox "Problemas al actualizar fecha de Condiciones Generales en archivo de Clientes", vbCritical, Msj
   End If
   
   Set Doc2 = Nothing
Exit Function
Control:
   MsgBox "Problemas para crear Condiciones Generales. " & err.Description, vbInformation, Msj
   Set Doc2 = Nothing
End Function


Function Func_Revisa_Tipo_Contrato_Nuevo(cRut_Cliente As Long, nCodigo As Integer) As String

   Func_Revisa_Tipo_Contrato_Nuevo = "NO"
   
   Envia = Array()
    
   AddParam Envia, cRut_Cliente
   AddParam Envia, 0
   AddParam Envia, nCodigo
          
   If Not Bac_Sql_Execute("BACPARAMSUDA..SP_MDCLLEERRUT", Envia) Then
      Func_Revisa_Tipo_Contrato_Nuevo = "XX"
      Screen.MousePointer = vbDefault
      MsgBox "Ha ocurrido un error al intentar validar si el contrato es nuevo o antiguo", vbCritical, TITSISTEMA
      Exit Function
   End If
       
   If Bac_SQL_Fetch(Datos()) Then
      If Trim(Datos(73)) = "S" Then
         Func_Revisa_Tipo_Contrato_Nuevo = "SI"
      ElseIf Trim(Datos(73)) = "N" Then
         Func_Revisa_Tipo_Contrato_Nuevo = "NO"
      ElseIf Trim(Datos(73)) = "" Then
         Func_Revisa_Tipo_Contrato_Nuevo = "SA" ' Sin Actualizar
      End If
   End If

End Function


Function Func_Genera_Contrato_Dinamico(nRutCliente As Long, nCodCliente As Integer, nNumoper As Long, DatosContrato(), sTipoSwap As String, cConceptoImpresion As String, bPreliminar As Boolean, Optional oArbol As MSComctlLib.TreeView, Optional bReimpresion As Boolean) As Boolean
    
   Dim Contrato()
   Dim nCuenta                As Integer
   Dim nCuenta2               As Integer
   Dim nCuenta3               As Integer
   Dim nContador              As Long
   Dim ncontador2             As Long
   Dim nContador3             As Long
   Dim bImprime               As Boolean
   Dim oDctoWord              As Word.Document
   Dim cPath_Dcto             As String
   Dim cPathDirTemp           As String
   Dim bDctoEnMemoria         As Boolean
   
   On Error GoTo Control_Error

   Func_Genera_Contrato_Dinamico = False
   
   If Not Func_Busca_Parametros_Bco Then
      Exit Function
   End If
   
   MatrizEstadoCivil(1, 1) = "STRO"
   MatrizEstadoCivil(1, 2) = "soltero"

   MatrizEstadoCivil(2, 1) = "CSDOSB"
   MatrizEstadoCivil(2, 2) = "casado(a) y separado(a) totalmente de bienes"

   MatrizEstadoCivil(3, 1) = "CSDOSC"
   MatrizEstadoCivil(3, 2) = "casado(a) bajo el régimen de sociedad conyugal"

   MatrizEstadoCivil(4, 1) = "CSDOPG"
   MatrizEstadoCivil(4, 2) = "casado(a) bajo el régimen de participación en los gananciales"

   MatrizEstadoCivil(5, 1) = "NA"
   MatrizEstadoCivil(5, 2) = "no aplica"
  
  
   Let nUltimoFlujoActivo = 0
   Let nUltimoFlujoPasivo = 0
  
  'ReDim Preserve Contrato(46, 1) ''REQ.7904
   ReDim Preserve Contrato(51, 1)

  'For nContador = 1 To 46   ''REQ.7904
   For nContador = 1 To 51
      Contrato(nContador, 1) = "**"
   Next

   Envia = Array()
   AddParam Envia, nNumoper

  'If Bac_Sql_Execute("BACSWAPSUDA..SP_DATOSCONTRATO", Envia) Then
   If Bac_Sql_Execute("BACSWAPSUDA..SP_DATOSCONTRATO_TODOSFLUJOS", Envia) Then
      nContador = 1
      Do While Bac_SQL_Fetch(Datos())
         
         If Datos(27) = 1 Then
            Let nUltimoFlujoActivo = nUltimoFlujoActivo + 1
         End If
         If Datos(27) = 2 Then
            Let nUltimoFlujoPasivo = nUltimoFlujoPasivo + 1
         End If
         
         
         'ReDim Preserve Contrato(46, nContador) ''REQ.7904
         ReDim Preserve Contrato(51, nContador)

         Contrato(1, nContador) = Datos(1)  'Tipo_operacion
         Contrato(2, nContador) = Datos(2)  'MontoOperacion
         Contrato(3, nContador) = Datos(3)  'TasaConversion
         Contrato(4, nContador) = Datos(4)  'Modalidad
         Contrato(5, nContador) = Datos(5)  'fechainicioflujo
         Contrato(6, nContador) = Datos(6)  'fechavenceflujo
         Contrato(7, nContador) = Datos(7)  'dias
         Contrato(8, nContador) = BacStrTran((Datos(8)), ".", gsc_PuntoDecim)   'compra_valor_tasa
         Contrato(9, nContador) = BacStrTran((Datos(9)), ".", gsc_PuntoDecim)   'venta_valor_tasa
         Contrato(10, nContador) = Datos(10) 'nombretasacompra
         Contrato(11, nContador) = Datos(11) 'nombretasaventa
         Contrato(12, nContador) = Datos(12) 'pagamosdoc
         Contrato(13, nContador) = Datos(13) 'recibimosdoc
         Contrato(14, nContador) = Datos(14) 'numero_flujo
         Contrato(15, nContador) = BacStrTran((Datos(15)), ".", gsc_PuntoDecim) 'compra_capital
         Contrato(16, nContador) = BacStrTran((Datos(16)), ".", gsc_PuntoDecim) 'compra_amortiza
         Contrato(17, nContador) = BacStrTran((Datos(17)), ".", gsc_PuntoDecim) 'compra_saldo
         Contrato(17, nContador) = CDbl(Contrato(16, nContador)) + CDbl(Contrato(17, nContador))
         Contrato(18, nContador) = Datos(18) 'compra_interes
         Contrato(19, nContador) = Datos(19) 'compra_spread
         Contrato(20, nContador) = Datos(20) 'venta_capital
         Contrato(21, nContador) = BacStrTran((Datos(21)), ".", gsc_PuntoDecim) 'venta_amortiza
         Contrato(22, nContador) = BacStrTran((Datos(22)), ".", gsc_PuntoDecim) 'venta_saldo
         Contrato(22, nContador) = CDbl(Contrato(21, nContador)) + CDbl(Contrato(22, nContador))
         Contrato(23, nContador) = Datos(23) 'venta_interes
         Contrato(24, nContador) = Datos(24) 'venta_spread
         Contrato(25, nContador) = Datos(25) 'pagamos_moneda
         Contrato(26, nContador) = Datos(26) 'recibimos_moneda
         Contrato(27, nContador) = Datos(27) 'tipo_flujo
         Contrato(28, nContador) = Datos(28) 'Compra_Moneda
         Contrato(29, nContador) = Datos(29) 'Venta_Moneda
         Contrato(30, nContador) = Datos(30) 'Compra_Capital
         Contrato(31, nContador) = Datos(31) 'Venta_Capital
         Contrato(32, nContador) = Datos(32) 'nemo_compra_moneda
         Contrato(33, nContador) = Datos(33) 'nemo_venta_moneda
         Contrato(34, nContador) = Datos(34) 'valuta
         Contrato(35, nContador) = Datos(35) 'Estado_Flujo
         Contrato(36, nContador) = Datos(36) 'Amortiza
         Contrato(37, nContador) = Datos(37) 'Fecha Fijación Tasa
         Contrato(38, nContador) = Datos(38) 'Fecha Liquidación
         Contrato(39, nContador) = Datos(39) 'nemo_Pagamos_moneda
         Contrato(40, nContador) = Datos(40) 'nemo_Recibimos_moneda
         Contrato(41, nContador) = Datos(41) 'TituloModComp, para cuando la modalidad es Compensación
         Contrato(42, nContador) = Datos(42) 'TituloModEF_1, para cuando la modalidad es Entrega Física
         Contrato(43, nContador) = Datos(43) 'TituloModEF_2, para cuando la modalidad es Entrega Física continuación
         Contrato(44, nContador) = Datos(44) 'Tipo_Swap
         sTipoSwap = Datos(44)
         Contrato(45, nContador) = nNumoper  'Numero operacion
         Contrato(46, nContador) = Datos(45) 'Intercambio Nocional
         Contrato(47, nContador) = Datos(46) 'Base Compra ''REQ.7904
         Contrato(48, nContador) = Datos(47) 'Base Venta  ''REQ.7904
         Contrato(49, nContador) = Datos(48) 'Termino anticipado 'PRD 12712
         Contrato(50, nContador) = Datos(49) 'Intercambio Noc. Inicial 'PRD 12712
         Contrato(51, nContador) = Datos(50) 'Intercambio Noc. Final 'PRD 12712
         nContador = nContador + 1
      Loop
   Else
      Screen.MousePointer = vbDefault
      MsgBox "Ha ocurrido un error al intenter recuperar los datos de la informacion.", vbCritical + vbOKOnly
      Exit Function
   End If
   
   '************************************************************************************************************
   nCuenta = UBound(MatrizDctosFisicos, 2)
   Dim wrd
   
   For nContador = 1 To nCuenta
               
      bImprime = False
      nCuenta2 = UBound(MatrizSeleccionados, 2)
      
      If MatrizDctosFisicos(ColContratoFisico.colCodigoDcto, nContador) <> "CE" Then
         For ncontador2 = 1 To nCuenta2
            If MatrizSeleccionados(colContratoSelec.colCodigoDctoPrinc, ncontador2) = MatrizDctosFisicos(ColContratoFisico.colCodigoDcto, nContador) Then
                        
               bDctoEnMemoria = False
                        
               Set wrd = New Word.Application
               bDctoEnMemoria = True
                              
               cPath_Dcto = ""
               cPath_Dcto = MatrizDctosFisicos(ColContratoFisico.colUbicacion, nContador) & IIf(Right(Trim(MatrizDctosFisicos(ColContratoFisico.colUbicacion, nContador)), 1) = "\", "", "\")
               
               
               cPath_Dcto = cPath_Dcto & MatrizDctosFisicos(ColContratoFisico.colNombreDcto, nContador)
                     
               Set oDctoWord = wrd.Documents.Add(cPath_Dcto, True)
               DoEvents
               
               If Not Func_Completa_Campos_Fijos(oDctoWord, Trim(CStr(MatrizDctosFisicos(ColContratoFisico.colCodigoDcto, nContador))), cConceptoImpresion, sTipoSwap, nNumoper, Contrato()) Then
                  Screen.MousePointer = vbDefault
                  Exit Function
               End If
               
               If Not Func_Completa_Glosa(Trim(CStr(MatrizDctosFisicos(ColContratoFisico.colCodigoDcto, nContador))), "", oDctoWord, MatrizAvales(), MatrizSeleccionados(), cConceptoImpresion) Then
                  Screen.MousePointer = vbDefault
                  Exit Function
               End If
               
               If nNumoper <> 0 Then
                  If Not Func_Completa_Datos_Operacion(oDctoWord, Contrato(), DatosContrato(), Trim(sTipoSwap)) Then
                     Screen.MousePointer = vbDefault
                     Exit Function
                  End If
               End If
               
               If bPreliminar = True Then
                  Call Proc_Agrega_Preliminar(oDctoWord)
               End If
                                             
               If Dir("C:\WINDOWS\TMP\") <> "" Then
                  cPathDirTemp = "C:\WINDOWS\TMP\"
               ElseIf Dir("C:\WINDOWS\TEMP\") <> "" Then
                  cPathDirTemp = "C:\WINDOWS\TEMP\"
               Else
                  cPathDirTemp = "c:\"
               End If
               
               oDctoWord.SaveAs cPathDirTemp & CStr(nNumoper) & " - " & MatrizDctosFisicos(ColContratoFisico.colNombreDcto, nContador)
               
               oDctoWord.Application.Visible = True
               Set oDctoWord = Nothing
               Set wrd = Nothing
                  
               Exit For
            End If
         Next ncontador2
      Else
         For ncontador2 = 1 To nCuenta2
            If MatrizSeleccionados(colContratoSelec.colCodigoDctoPrinc, ncontador2) = MatrizDctosFisicos(ColContratoFisico.colCodigoDcto, nContador) Then

               bDctoEnMemoria = False
               cPath_Dcto = ""
               cPath_Dcto = MatrizDctosFisicos(ColContratoFisico.colUbicacion, nContador) & IIf(Right(Trim(MatrizDctosFisicos(ColContratoFisico.colUbicacion, nContador)), 1) = "\", "", "\")
               
               'MEJORAR ESTO...
               If Trim(sTipoSwap) = "TASA" Then
                  cNombreAnexo = "Anexo3.doc"
               ElseIf Trim(sTipoSwap) = "MONEDA" Then
                  cNombreAnexo = "Anexo7.doc"
               ElseIf Trim(sTipoSwap) = "CAMARA" Then
                  cNombreAnexo = "Anexo6.doc"         '--> Según, Ricardo Aldunate G. Miércoles 13/10/2010 18:36 se cambia el Anexo 6 por e 3. para Promedio Camara
                  cNombreAnexo = "Anexo3.doc"         '-->  <--'
               Else
                  Screen.MousePointer = vbDefault
                  MsgBox "Producto no parametrizado", vbExclamation + vbOKOnly
                  Exit Function
               End If

               Set wrd = New Word.Application

               bDctoEnMemoria = True

               Set oDctoWord = wrd.Documents.Add(cPath_Dcto & cNombreAnexo)
               DoEvents

               If Not Func_Completa_Campos_Fijos(oDctoWord, Trim(CStr(MatrizDctosFisicos(ColContratoFisico.colCodigoDcto, nContador))), cConceptoImpresion, sTipoSwap, nNumoper, Contrato()) Then
                  Screen.MousePointer = vbDefault
                  Exit Function
               End If

               If Not Func_Completa_Datos_Operacion(oDctoWord, Contrato(), DatosContrato(), Trim(sTipoSwap)) Then
                  Screen.MousePointer = vbDefault
                  Exit Function
               End If

               Call Proc_Inserta_Pie_Avales(cConceptoImpresion, 0, oDctoWord, False)

               If bPreliminar = True Then
                  Call Proc_Agrega_Preliminar(oDctoWord)
               End If

               If Dir("C:\WINDOWS\TMP\") <> "" Then
                  cPathDirTemp = "C:\WINDOWS\TMP\"
               ElseIf Dir("C:\WINDOWS\TEMP\") <> "" Then
                  cPathDirTemp = "C:\WINDOWS\TEMP\"
               Else
                  cPathDirTemp = "c:\"
               End If

               oDctoWord.SaveAs cPathDirTemp & CStr(nNumoper) & " - " & cNombreAnexo

               oDctoWord.Application.Visible = True
               Set oDctoWord = Nothing
               Set wrd = Nothing
            End If
         Next ncontador2
      End If
   Next nContador
   
   If bReimpresion <> True Then
      If bPreliminar = False Then
         Call Proc_Graba_Contrato_Emitido(nRutCliente, nCodCliente, nNumoper, MatrizSeleccionados(), oArbol, cConceptoImpresion)
      End If
   End If
   
   Func_Genera_Contrato_Dinamico = True
   
   Exit Function
   
Control_Error:

   Screen.MousePointer = vbDefault
   MsgBox Str(err.Number) + " - " + err.Description, vbCritical + vbOKOnly

   If bDctoEnMemoria = True Then
      wrd.Application.Quit wdDoNotSaveChanges
      Set oDctoWord = Nothing
      Set wrd = Nothing
   End If
   Resume
   Exit Function

End Function




Sub Proc_Agrega_Preliminar(oDctoWord As Word.Document)
   
   With oDctoWord
    
      .Application.Documents(.Name).Sections(1).Range.Select
      .Application.Documents(.Name).Sections(1).PageSetup.DifferentFirstPageHeaderFooter = False
      .Application.ActiveDocument.ActiveWindow.ActivePane.View.SeekView = wdSeekCurrentPageHeader
      .Application.Selection.HeaderFooter.Shapes.AddTextEffect(msoTextEffect10, "PRELIMINAR", "COURIER NEW", 50, False, False, 0, 0).Select
      '.Application.Selection.ShapeRange("msoTextEffect20").Select 'no entiendo porque esto no funciona
      .Application.Selection.ShapeRange.TextEffect.NormalizedHeight = False
      .Application.Selection.ShapeRange.Line.Visible = True
      .Application.Selection.ShapeRange.Fill.Visible = True
      .Application.Selection.ShapeRange.Fill.Solid
      .Application.Selection.ShapeRange.Fill.ForeColor.RGB = RGB(148, 138, 84)
      .Application.Selection.ShapeRange.Fill.Transparency = 0
      .Application.Selection.ShapeRange.Rotation = 315
      .Application.Selection.ShapeRange.LockAspectRatio = True
      .Application.Selection.ShapeRange.Height = 67
      .Application.Selection.ShapeRange.Width = 400
      .Application.Selection.ShapeRange.WrapFormat.AllowOverlap = True
      .Application.Selection.ShapeRange.WrapFormat.Side = wdWrapNone
      .Application.Selection.ShapeRange.WrapFormat.Type = 3
      .Application.Selection.ShapeRange.RelativeHorizontalPosition = wdRelativeVerticalPositionMargin
      .Application.Selection.ShapeRange.RelativeVerticalPosition = wdRelativeVerticalPositionMargin
      .Application.Selection.ShapeRange.Left = wdShapeCenter
      .Application.Selection.ShapeRange.Top = wdShapeCenter
      .Application.ActiveDocument.ActiveWindow.ActivePane.View.SeekView = wdSeekMainDocument
   
   End With

End Sub


Sub Proc_Busca_Ciudad_Comuna(nCodigoCuidad As String, nCodigoComuna As String, ByRef cNombreCiudad As String, ByRef cNombreComuna As String)

   If nCodigoCuidad <> "-999" Then
      Envia = Array()
       
      AddParam Envia, "-999"
      AddParam Envia, nCodigoCuidad
            
      If Not Bac_Sql_Execute("BACPARAMSUDA..SP_MOSTRAR_CIUDAD", Envia) Then
         Screen.MousePointer = vbDefault
         MsgBox "Ha ocurrido un error al intentar recuperar el nombre de la cuidad", vbCritical, TITSISTEMA
         Exit Sub
      End If
          
      If Bac_SQL_Fetch(Datos()) Then
         cNombreCiudad = Trim(Datos(3))
      End If
   End If
   
   '*************************************************************************************
   
   If nCodigoComuna <> "-999" Then
      If nCodigoCuidad = "-999" Then
         nCodigoCuidad = ""
      End If
   
      Envia = Array()
       
      AddParam Envia, nCodigoCuidad
      AddParam Envia, nCodigoComuna
            
      If Not Bac_Sql_Execute("BACPARAMSUDA..SP_MOSTRAR_COMUNA", Envia) Then
         Screen.MousePointer = vbDefault
         MsgBox "Ha ocurrido un error al intentar recuperar el nombre de la comuna", vbCritical, TITSISTEMA
         Exit Sub
      End If
          
      If Bac_SQL_Fetch(Datos()) Then
         cNombreComuna = Trim(Datos(3))
      End If
   End If

End Sub

Function Func_Genera_Arbol_Nuevo_Contrato(cConceptoImrpresion As String, iOperacion As Long, ClienteOp As Long, ClienteCod As Integer _
                                     , iRutBco1 As Long, iRutBco2 As Long _
                                     , iRutCli1 As Long, iRutCli2 As Long _
                                     , Trw_Seleccion As MSComctlLib.TreeView _
                                     , Cbm_CantidadAvales As ComboBox _
                                     , bAbilitaAvales As Boolean) As Boolean

   Dim cCodigoFisico    As String
   Dim cCodigoClausula  As String
   Dim nContador1       As Long
   Dim ncontador2       As Long
   Dim nContador3       As Long
   Dim nContador4       As Long
   Dim nContador5       As Long
   
   Func_Genera_Arbol_Nuevo_Contrato = False
   
   Screen.MousePointer = vbHourglass

   If Not Func_Busca_Dctos_Fisicos(MatrizDctosFisicos(), cConceptoImrpresion) Then
      Screen.MousePointer = vbDefault
      MsgBox "Ha ocurrido un error al intentar generar los contratos", vbCritical + vbOKOnly
      Exit Function
   End If
   
   If Not Func_Lee_Clausulas_Arbol(MatrizClausulas(), "PCS") Then
      Screen.MousePointer = vbDefault
      MsgBox "Ha ocurrido un error al intentar generar los contratos", vbCritical + vbOKOnly
      Exit Function
   End If
      
   If Not Func_Busca_Contratos_Seleccionados(ClienteOp, ClienteCod, MatrizSeleccionados()) Then
      Screen.MousePointer = vbDefault
      Exit Function
   End If
   
   Erase MatrizAvales
            
   If Not Func_Busca_Avales_Cliente_Derivados(ClienteOp, ClienteCod, MatrizAvales()) Then
      Exit Function
   End If
   
      Cbm_CantidadAvales.Clear
      
   If nCuentaAvales > 0 Then
      
      For nContador1 = 1 To nCuentaAvales
         Cbm_CantidadAvales.AddItem Trim(CStr(nContador1))
      Next nContador1
      
      Cbm_CantidadAvales.ListIndex = 0
   End If
   
   '***********************************************************************************************************************
      
   Trw_Seleccion.Nodes.Clear
      
   With Trw_Seleccion
      For nContador1 = 1 To UBound(MatrizDctosFisicos, 2)
         ' SE ARMA CADENA QUE CONTIENE: CODIGO DEL DCTO + 50 ESPACIOS + FISICO/DINAMICO + CODIGO DCTO + 1 ESPACIO + SELECCIONADO S/N
         cCodigoFisico = "FISICO    "
         cCodigoFisico = cCodigoFisico & Space(10 - Len(Trim(MatrizDctosFisicos(1, nContador1))))
         cCodigoFisico = cCodigoFisico & Trim(MatrizDctosFisicos(1, nContador1))
         cCodigoFisico = cCodigoFisico & Space(10 - Len(Trim(MatrizDctosFisicos(1, nContador1))))
         cCodigoFisico = cCodigoFisico & Trim(MatrizDctosFisicos(1, nContador1))
         
         .Nodes.Add , , cCodigoFisico, MatrizDctosFisicos(2, nContador1)
         GoSub Busca_Marcado
         
         .Nodes.Item(.Nodes.Count).Expanded = True
            
         For ncontador2 = 1 To UBound(MatrizClausulas, 2)
            If Trim(MatrizDctosFisicos(1, nContador1)) = MatrizClausulas(1, ncontador2) Then 'Codigo Documento Fisico
               
               cCodigoClausula = "DINAMICO  "
               cCodigoClausula = cCodigoClausula & Space(10 - Len(Trim(MatrizDctosFisicos(1, nContador1))))
               cCodigoClausula = cCodigoClausula & Trim(MatrizDctosFisicos(1, nContador1))
               cCodigoClausula = cCodigoClausula & Space(10 - Len(Trim(MatrizClausulas(2, ncontador2))))
               cCodigoClausula = cCodigoClausula & Trim(MatrizClausulas(2, ncontador2)) 'Codigo Clausula
               
               .Nodes.Add cCodigoFisico, tvwChild, cCodigoClausula, Trim(MatrizClausulas(3, ncontador2))   'Glosa Corta
               
               GoSub Busca_Marcado
            End If
         Next ncontador2
      Next nContador1
      
      For nContador4 = 1 To .Nodes.Count
         If Trim(Mid(.Nodes(nContador4).Key, 1, 10)) = "DINAMICO" Then
            For nContador3 = 1 To UBound(MatrizClausulas, 2)
               If Trim(Mid(.Nodes(nContador4).Key, 11, 10)) = MatrizClausulas(1, nContador3) _
                  And Trim(Mid(.Nodes(nContador4).Key, 21, 10)) = MatrizClausulas(2, nContador3) _
                  And .Nodes(nContador4).Checked = True And MatrizClausulas(4, nContador3) = "S" Then
                  bAbilitaAvales = True
                  Exit For
               End If
            Next nContador3
         End If
            
         If bAbilitaAvales = True Then
            Exit For
         End If
      Next nContador4
         
      Screen.MousePointer = vbDefault
      
      Func_Genera_Arbol_Nuevo_Contrato = True
      
            
      Exit Function
      
      
Busca_Marcado:

   For nContador3 = 1 To UBound(MatrizSeleccionados, 2)
      If Trim(Mid(.Nodes.Item(.Nodes.Count).Key, 11, 10)) = Trim(MatrizSeleccionados(4, nContador3)) Then 'codigo Dcto Principal
         If Trim(Mid(.Nodes.Item(.Nodes.Count).Key, 21, 10)) = Trim(MatrizSeleccionados(5, nContador3)) Then 'Codigo clausula o dcto Principal
            
            For nContador5 = .Nodes.Count To 1 Step -1
               If Trim(Mid(.Nodes(.Nodes.Count).Key, 1, 10)) = "DINAMICO" Then
                  If Trim(Mid(.Nodes(nContador5).Key, 21, 10)) = Trim(Mid(.Nodes.Item(.Nodes.Count).Key, 11, 10)) And Trim(Mid(.Nodes(nContador5).Key, 1, 10)) = "FISICO" Then 'pregunta si los codigos padres son iguales para saber si el documento fisico esta marcado
                     If .Nodes(nContador5).Checked = True Then
                        .Nodes.Item(.Nodes.Count).Checked = True
                     End If
                  End If
               Else
                  .Nodes.Item(.Nodes.Count).Checked = True
                  Exit For
               End If
            Next nContador5
         End If
      End If
   Next nContador3
   Return
   
   End With
   
End Function



Function Func_Busca_Avales_Cliente_Derivados(RutCliente As Long, CodCliente As Integer, Matriz()) As Boolean
   
   Func_Busca_Avales_Cliente_Derivados = False
      
   Envia = Array()
   AddParam Envia, CDbl(RutCliente)
   AddParam Envia, CDbl(CodCliente)
          
   If Not Bac_Sql_Execute("BACPARAMSUDA..SP_CON_AVAL_CLIENTE_DERIVADOS", Envia) Then
      Screen.MousePointer = vbDefault
      MsgBox "Ha ocurrido un error al intentar consultar por los avales del usuario", vbCritical, TITSISTEMA
      Exit Function
   End If
   
   nCuentaAvales = 0
       
   Do While Bac_SQL_Fetch(Datos())
      nCuentaAvales = nCuentaAvales + 1
      ReDim Preserve Matriz(21, nCuentaAvales)
               
      Matriz(1, nCuentaAvales) = Trim(Datos(1))   ' Rut_Cliente
      Matriz(2, nCuentaAvales) = Trim(Datos(2))   ' Cod_Cliente
      Matriz(3, nCuentaAvales) = Trim(Datos(3))   ' Rut_Aval
      Matriz(4, nCuentaAvales) = Trim(Datos(4))   ' DV_Aval
      Matriz(5, nCuentaAvales) = Trim(Datos(5))   ' Nombre_Aval
      Matriz(6, nCuentaAvales) = Trim(Datos(6))   ' Razon_Social_Aval
      Matriz(7, nCuentaAvales) = Trim(Datos(7))   ' Profesion_Aval
      Matriz(8, nCuentaAvales) = Trim(Datos(8))   ' Direccion_Aval
      Matriz(9, nCuentaAvales) = Trim(Datos(9))   ' Comuna_Aval
      Matriz(10, nCuentaAvales) = Trim(Datos(10)) ' Ciudad_Aval
      Matriz(11, nCuentaAvales) = Trim(Datos(11)) ' Rut_Apod_Aval_1
      Matriz(12, nCuentaAvales) = Trim(Datos(12)) ' Dv_RAA_1
      Matriz(13, nCuentaAvales) = Trim(Datos(13)) ' Nom_Apod_Aval_1
      Matriz(14, nCuentaAvales) = Trim(Datos(14)) ' Rut_Apod_Aval_2
      Matriz(15, nCuentaAvales) = Trim(Datos(15)) ' Dv_RAA_2
      Matriz(16, nCuentaAvales) = Trim(Datos(16)) ' Nom_Apod_Aval_2
      Matriz(17, nCuentaAvales) = Trim(Datos(17)) ' Regimen_Conyuga_Aval
      Matriz(18, nCuentaAvales) = Trim(Datos(18)) ' Rut_Conyuge_Aval
      Matriz(19, nCuentaAvales) = Trim(Datos(19)) ' Dv_RCA
      Matriz(20, nCuentaAvales) = Trim(Datos(20)) ' Nom_Conyuge_Aval
      Matriz(21, nCuentaAvales) = Trim(Datos(21)) ' Profesion_Conyuge_Aval
   Loop
   
   Func_Busca_Avales_Cliente_Derivados = True
   
   Exit Function

errorcuenta:
   
   nCuentaAvales = 1
   Resume Next
   
End Function

Function Func_Busca_Contratos_Seleccionados(nRutCliente As Long, nCodCliente As Integer, Matriz()) As Boolean

   Dim cuenta As Integer
   
   
   Func_Busca_Contratos_Seleccionados = False

   Erase Matriz
   
   Envia = Array()
   AddParam Envia, "PCS"
   AddParam Envia, nRutCliente
   AddParam Envia, nCodCliente

   If Not Bac_Sql_Execute("BACPARAMSUDA..SP_CON_CLIENTE_CONTRATO_DERIVADOS", Envia) Then
      Screen.MousePointer = vbDefault
      MsgBox "Ha ocurrido un error al intentar rescatar los contratos seleccionados", vbCritical + vbOKOnly
      Exit Function
   End If
          
   cuenta = 0
          
   Do While Bac_SQL_Fetch(Datos())
      cuenta = cuenta + 1
      ReDim Preserve Matriz(5, cuenta)
      
      Matriz(1, cuenta) = Datos(1)        ' RUT CLIENTE
      Matriz(2, cuenta) = Datos(2)        ' CODIGO CLIENTE
      Matriz(3, cuenta) = Trim(Datos(3))  ' CODIGO SISTEMA
      Matriz(4, cuenta) = Trim(Datos(4))  ' CODIGO DCTO PRINCIPAL
      Matriz(5, cuenta) = Trim(Datos(5))  ' CODIGO DCTO
   Loop
   
   If cuenta = 0 Then
      Screen.MousePointer = vbDefault
      MsgBox "Cliente no registra asignacion de opciones para contratos nuevos, por favor revisar", vbOKOnly + vbExclamation
      Exit Function
   End If
   
   Func_Busca_Contratos_Seleccionados = True
   
End Function
Function Func_Lee_Clausulas_Arbol(MatrizClausulasArbol(), cSistema As String, Optional bReimpresion As Boolean) As Boolean

   Dim nContador As Long

   Func_Lee_Clausulas_Arbol = False

   Envia = Array()
   AddParam Envia, Trim(cSistema)
   AddParam Envia, ""
   AddParam Envia, ""
   AddParam Envia, ""
   AddParam Envia, IIf(bReimpresion = True, "", "S") 'SE ENVIA S PARA TRAER SOLO LOS ACTIVOS
   
   If Not Bac_Sql_Execute("BACPARAMSUDA..SP_CON_CLAUSULA_CONTRATO_DINAMICO", Envia) Then
      Screen.MousePointer = vbDefault
      Exit Function
   End If
   
   ReDim Preserve MatrizClausulasArbol(4, 1)
   
   For nContador = 1 To 4
      MatrizClausulasArbol(nContador, 1) = "*"
   Next nContador
   
   nContador = 0
  
   Do While Bac_SQL_Fetch(Datos())
      nContador = nContador + 1
      ReDim Preserve MatrizClausulasArbol(4, nContador)
                
      MatrizClausulasArbol(1, nContador) = Trim(Datos(2)) 'Codigo Contrato Fisico
      MatrizClausulasArbol(2, nContador) = Trim(Datos(3)) 'Codigo Clausula
      MatrizClausulasArbol(3, nContador) = Trim(Datos(4)) 'Glosa
      MatrizClausulasArbol(4, nContador) = Trim(Datos(9)) 'Tiene Avales
   Loop
   
   Func_Lee_Clausulas_Arbol = True

End Function



Function Func_Busca_Dctos_Fisicos(Matriz(), cConceptoImrpresion As String, Optional bReimpresion As Boolean) As Boolean

   Dim cuenta As Integer
   
   Func_Busca_Dctos_Fisicos = False

   Erase Matriz
   
   Envia = Array()
   AddParam Envia, "PCS"
   AddParam Envia, ""
   AddParam Envia, cConceptoImrpresion
   AddParam Envia, IIf(bReimpresion = True, "", "S") 'SE ENVIA S PARA TODOS LOS QUE ESTEN ACTIVOS

   If Not Bac_Sql_Execute("BACPARAMSUDA..SP_CON_CONTRATOS_FISICOS_DERIVADOS", Envia) Then
      Screen.MousePointer = vbDefault
      Exit Function
   End If
   
   cuenta = 0
       
   Do While Bac_SQL_Fetch(Datos())
      cuenta = cuenta + 1
      ReDim Preserve Matriz(5, cuenta)
      
      Matriz(1, cuenta) = Trim(Datos(1)) ' CODIGO DCTO
      Matriz(2, cuenta) = Trim(Datos(2)) ' DESCRIPCION DCTO
      Matriz(3, cuenta) = Trim(Datos(3)) ' UBICACION DCTO
      Matriz(4, cuenta) = Trim(Datos(4)) ' NOMBRE DCTO
      Matriz(5, cuenta) = Datos(5)       ' INDICE ORDEN
   Loop
   
   If cuenta = 0 Then
      Screen.MousePointer = vbDefault
      MsgBox "No se han encontrado los documentos fisicos para su impresion, por favor revisar", vbOKOnly + vbExclamation
      Exit Function
   End If
   
   Func_Busca_Dctos_Fisicos = True
   
   Exit Function

errorcuenta:
   
   cuenta = 1
   Resume Next
End Function

Function Func_Completa_Datos_Operacion(oDctoWord As Word.Document, Contrato(), DatosContrato(), cTipoSwap As String) As Boolean
   
   Dim nRecorreFlujos      As Integer
   Dim cNemoMonE           As String
   Dim cNemoMonR           As String
   Dim nContadorLineas     As Integer
   Dim nContador           As Integer
   Dim ClsMoneda           As Object
   Dim nNumFlujoVigR       As Integer
   Dim nNumFlujoVigE       As Integer
   
   Dim cFechaInterNocIniR  As String
   Dim cFechaInterNocIniE  As String
   Dim cFechaInterNocFinR  As String
   Dim cFechaInterNocFinE  As String
   
   Dim nMontoInterNocIniR  As Double
   Dim nMontoInterNocIniE  As Double
   Dim nMontoInterNocFinR  As Double
   Dim nMontoInterNocFinE  As Double
   Dim xFechaCierre        As Date
   
   On Error GoTo Control_Error
   
   Func_Completa_Datos_Operacion = False
   
   Let xFechaCierre = BacContratoSwap.txtFechaOperacion.Text
   
   Set ClsMoneda = New ClsMoneda
   
   oDctoWord.Bookmarks.Item("NomBco").Range.Text = DatosContrato(1)
   oDctoWord.Bookmarks.Item("NomBco2").Range.Text = DatosContrato(1)
   oDctoWord.Bookmarks.Item("NomBco3").Range.Text = DatosContrato(1)
   oDctoWord.Bookmarks.Item("NomBco4").Range.Text = DatosContrato(1)
   oDctoWord.Bookmarks.Item("NomBco5").Range.Text = DatosContrato(1)
   
   oDctoWord.Bookmarks.Item("NomCli").Range.Text = DatosContrato(6)
   oDctoWord.Bookmarks.Item("NomCli2").Range.Text = DatosContrato(6)
   oDctoWord.Bookmarks.Item("NomCli3").Range.Text = DatosContrato(6)
   oDctoWord.Bookmarks.Item("NomCli4").Range.Text = DatosContrato(6)
   oDctoWord.Bookmarks.Item("NomCli5").Range.Text = DatosContrato(6)
   oDctoWord.Bookmarks.Item("NomCli6").Range.Text = DatosContrato(6)
   
   oDctoWord.Bookmarks.Item("FechaIni").Range.Text = Format(DatosContrato(27), "dd/mm/yyyy")
   oDctoWord.Bookmarks.Item("FechaIni2").Range.Text = Format(DatosContrato(27), "dd/mm/yyyy")
   oDctoWord.Bookmarks.Item("FechaIni3").Range.Text = Format(DatosContrato(27), "dd/mm/yyyy")
   oDctoWord.Bookmarks.Item("FechaIni4").Range.Text = Format(DatosContrato(27), "dd/mm/yyyy")
   oDctoWord.Bookmarks.Item("FechaIni5").Range.Text = Format(DatosContrato(27), "dd/mm/yyyy")
   
   oDctoWord.Bookmarks.Item("FechaVenc").Range.Text = Format(Contrato(6, UBound(Contrato, 2)), "dd/mm/yyyy")
   oDctoWord.Bookmarks.Item("FechaVenc2").Range.Text = Contrato(6, UBound(Contrato, 2))
   oDctoWord.Bookmarks.Item("FechaVenc3").Range.Text = Contrato(6, UBound(Contrato, 2))
   oDctoWord.Bookmarks.Item("FechaVenc4").Range.Text = Contrato(6, UBound(Contrato, 2))
   oDctoWord.Bookmarks.Item("FechaVenc5").Range.Text = Contrato(6, UBound(Contrato, 2))
 
   oDctoWord.Bookmarks.Item("FechaOperacion2").Range.Font.Bold = True: oDctoWord.Bookmarks.Item("FechaOperacion").Range.Text = Day(xFechaCierre) & " de " & UCase(BacMesStr(Month(xFechaCierre))) & " de " & Year(xFechaCierre)
  'oDctoWord.Bookmarks.Item("FechaOperacion2").Range.Font.Bold = True: oDctoWord.Bookmarks.Item("FechaOperacion").Range.Text = Day(Contrato(37, 1)) & " de " & UCase(BacMesStr(Month(Contrato(37, 1)))) & " de " & Year(Contrato(37, 1))    'FECHA OPERACION PALABRAS
   oDctoWord.Bookmarks.Item("FechaOperacion2").Range.Text = Day(Contrato(37, 1)) & " de " & UCase(BacMesStr(Month(Contrato(37, 1)))) & " de " & Year(Contrato(37, 1))   'FECHA OPERACION PALABRAS
   oDctoWord.Bookmarks.Item("FechaOperacion3").Range.Text = Day(Contrato(37, 1)) & " de " & UCase(BacMesStr(Month(Contrato(37, 1)))) & " de " & Year(Contrato(37, 1))   'FECHA OPERACION PALABRAS
   oDctoWord.Bookmarks.Item("FechaOperacion4").Range.Text = Day(Contrato(37, 1)) & " de " & UCase(BacMesStr(Month(Contrato(37, 1)))) & " de " & Year(Contrato(37, 1))   'FECHA OPERACION PALABRAS
   oDctoWord.Bookmarks.Item("FechaOperacion5").Range.Text = Day(Contrato(37, 1)) & " de " & UCase(BacMesStr(Month(Contrato(37, 1)))) & " de " & Year(Contrato(37, 1))   'FECHA OPERACION PALABRAS
 
   oDctoWord.Bookmarks.Item("Fecha_Operacion").Range.Text = Contrato(37, 1)  'Fecha Fijacion
   oDctoWord.Bookmarks.Item("Fecha_Operacion2").Range.Text = Contrato(37, 1) 'Fecha Fijacion
   oDctoWord.Bookmarks.Item("Fecha_Operacion3").Range.Text = Contrato(37, 1) 'Fecha Fijacion
   oDctoWord.Bookmarks.Item("Fecha_Operacion4").Range.Text = Contrato(37, 1) 'Fecha Fijacion
   oDctoWord.Bookmarks.Item("Fecha_Operacion5").Range.Text = Contrato(37, 1) 'Fecha Fijacion
   
   oDctoWord.Bookmarks.Item("FolioOperacion").Range.Text = Format(Contrato(45, 1), "#,##0")
   oDctoWord.Bookmarks.Item("FolioOperacion2").Range.Text = Format(Contrato(45, 1), "#,##0")
   oDctoWord.Bookmarks.Item("FolioOperacion3").Range.Text = Format(Contrato(45, 1), "#,##0")
   oDctoWord.Bookmarks.Item("FolioOperacion4").Range.Text = Format(Contrato(45, 1), "#,##0")
   oDctoWord.Bookmarks.Item("FolioOperacion5").Range.Text = Format(Contrato(45, 1), "#,##0")
   
   oDctoWord.Bookmarks.Item("Termino_Anticipado").Range.Text = Contrato(49, 1)
   'oDctoWord.Bookmarks.Item("Intercambio_Inicial").Range.Text = Contrato(50, 1)
   
   
   
   If sTipoSwap = "TASA" Then
      nMontoOperacion = Contrato(31, 1) ' Venta Capital
   ElseIf sTipoSwap = "MONEDA" Then
      nMontoOperacion = Contrato(31, 1) ' Venta Capital
   ElseIf sTipoSwap = "CAMARA" Then
      nMontoOperacion = Contrato(31, 1) ' Venta Capital
   Else
      nMontoOperacion = Contrato(31, 1) ' Venta Capital
   End If
   
   nMontoInterNocIniR = -999
   nMontoInterNocIniE = -999
   nMontoInterNocFinR = -999
   nMontoInterNocFinE = -999
   
   cFechaInterNocIniR = "01/01/1900"
   cFechaInterNocIniE = "01/01/1900"
   cFechaInterNocFinR = "01/01/1900"
   cFechaInterNocFinE = "01/01/1900"
   
   For nRecorreFlujos = 1 To UBound(Contrato, 2)
      If Contrato(ColsArrayContrato.TipoFlujo, nRecorreFlujos) = 1 And Contrato(ColsArrayContrato.EstadoFlujo, nRecorreFlujos) = 1 Then   'tipo Flujo = 2 y Estado Flujo Vigente
         nNumFlujoVigR = nRecorreFlujos
      End If
      If Contrato(ColsArrayContrato.TipoFlujo, nRecorreFlujos) = 2 And Contrato(ColsArrayContrato.EstadoFlujo, nRecorreFlujos) = 1 Then   'tipo Flujo = 1 y Estado Flujo Vigente
         nNumFlujoVigE = nRecorreFlujos
      End If
      
      If Contrato(ColsArrayContrato.TipoFlujo, nRecorreFlujos) = 1 And Contrato(ColsArrayContrato.IntercambioNocional, nRecorreFlujos) = 1 And nMontoInterNocIniR = -999 Then
         nMontoInterNocIniR = Contrato(ColsArrayContrato.ReciboArmotiza, nRecorreFlujos)
         cFechaInterNocIniR = Contrato(ColsArrayContrato.FechaInicioFlujo, nRecorreFlujos)
      End If
      
      ' si el flujo es tipo Recibimos y tiene intercambio de nocional y (el proximo tipo de flujo es Entregamos
      ' o (el proximo tipo flujo es Recibimos pero ya no tiene intercambio de nocional ))
      If nMontoInterNocFinR = -999 And Contrato(ColsArrayContrato.TipoFlujo, nRecorreFlujos) = 1 Then
         If Contrato(ColsArrayContrato.IntercambioNocional, nRecorreFlujos) = 1 _
            And ((Contrato(ColsArrayContrato.TipoFlujo, nRecorreFlujos + 1) = 2 _
            Or ((Contrato(ColsArrayContrato.TipoFlujo, nRecorreFlujos) = 1 And Contrato(ColsArrayContrato.IntercambioNocional, nRecorreFlujos) = 0)))) Then
            nMontoInterNocFinR = Contrato(ColsArrayContrato.ReciboArmotiza, nRecorreFlujos)
            cFechaInterNocFinR = Contrato(ColsArrayContrato.FechaInicioFlujo, nRecorreFlujos)
         End If
      End If
      
      If Contrato(ColsArrayContrato.TipoFlujo, nRecorreFlujos) = 2 Then
        If Contrato(ColsArrayContrato.IntercambioNocional, nRecorreFlujos) = 0 And Contrato(NumeroFlujo, nRecorreFlujos) = 1 Then
        nMontoInterNocIniE = Contrato(ColsArrayContrato.EntregoArmotiza, nRecorreFlujos)
        End If
      End If
           
      If Contrato(ColsArrayContrato.TipoFlujo, nRecorreFlujos) = 2 And Contrato(ColsArrayContrato.IntercambioNocional, nRecorreFlujos) = 1 And nMontoInterNocIniE = -999 Then
         nMontoInterNocIniE = Contrato(ColsArrayContrato.EntregoArmotiza, nRecorreFlujos)
         cFechaInterNocIniE = Contrato(ColsArrayContrato.FechaInicioFlujo, nRecorreFlujos)
      End If
      
      If nRecorreFlujos = UBound(Contrato, 2) - 1 And Contrato(ColsArrayContrato.TipoFlujo, nRecorreFlujos) = 2 Then
         If Contrato(ColsArrayContrato.IntercambioNocional, nRecorreFlujos) = 1 And nMontoInterNocFinE = -999 Then
            nMontoInterNocFinE = Contrato(ColsArrayContrato.EntregoArmotiza, nRecorreFlujos)
            cFechaInterNocFinE = Contrato(ColsArrayContrato.FechaInicioFlujo, nRecorreFlujos)
            
            If nRecorreFlujos = UBound(Contrato, 2) + 1 And Contrato(ColsArrayContrato.IntercambioNocional, nRecorreFlujos + 1) = 1 Then
               nMontoInterNocFinE = Contrato(ColsArrayContrato.EntregoArmotiza, nRecorreFlujos)
               cFechaInterNocFinE = Contrato(ColsArrayContrato.FechaInicioFlujo, nRecorreFlujos)
            End If
         End If
      End If
      
   Next nRecorreFlujos
            

   cFechaInterNocIniR = Contrato(ColsArrayContrato.FechaInicioFlujo, 1)
   nMontoInterNocIniR = Contrato(ColsArrayContrato.ReciboArmotiza, 1)
   'nMontoInterNocIniE = Contrato(ColsArrayContrato.ReciboArmotiza, 1)
   
   cFechaInterNocFinR = Contrato(ColsArrayContrato.FechaVenceFlujo, nUltimoFlujoActivo + nUltimoFlujoPasivo)
   nMontoInterNocFinR = Contrato(ColsArrayContrato.ReciboArmotiza, nUltimoFlujoActivo)
   nMontoInterNocFinE = Contrato(ColsArrayContrato.EntregoArmotiza, nUltimoFlujoActivo + nUltimoFlujoPasivo)

   
   oDctoWord.Bookmarks.Item("BcoReferencial").Range.Text = FuncEntregaBacoRef(Contrato(45, 1))
   
   
            
   cNemoMonR = ""
   Call ClsMoneda.LeerxCodigo(CInt(Contrato(ColsArrayContrato.ReciboCodMoneda, nNumFlujoVigR)))
   cNemoMonR = ClsMoneda.mnnemo
   
   cNemoMonE = ""
   Call ClsMoneda.LeerxCodigo(CInt(Contrato(ColsArrayContrato.EntregoCodMoneda, nNumFlujoVigE)))
   cNemoMonE = ClsMoneda.mnnemo
    
   oDctoWord.Bookmarks.Item("NomBco_NemoMnda_Monto").Range.Text = DatosContrato(1) & ": " & cNemoMonE & " " & Format(Contrato(ColsArrayContrato.EntregoCapital2, nNumFlujoVigE), "#,##0.0000")
   oDctoWord.Bookmarks.Item("NomCli_NemoMnda_Monto").Range.Text = DatosContrato(6) & ": " & cNemoMonR & " " & Format(Contrato(ColsArrayContrato.ReciboCapital2, nNumFlujoVigR), "#,##0.0000")

    oDctoWord.Bookmarks.Item("FormaPago").Range.Text = "MONEDA NACIONAL    : " & IIf((Contrato(ColsArrayContrato.PagamosDoc, nRecorreFlujos - 1) <> ""), (Contrato(ColsArrayContrato.PagamosDoc, nRecorreFlujos - 1)), "N/A")
   oDctoWord.Bookmarks.Item("FormaPago2").Range.Text = "MONEDA EXTRANJERA  : " & IIf((Contrato(ColsArrayContrato.RecibimosDoc, nUltimoFlujoActivo) <> ""), (Contrato(ColsArrayContrato.RecibimosDoc, nUltimoFlujoActivo)), "N/A")
   
   
   oDctoWord.Bookmarks.Item("ValutaPago").Range.Text = "T + " & Contrato(ColsArrayContrato.Valuta, nRecorreFlujos - 1)


   If Contrato(ColsArrayContrato.EntregoTasaDesc, nNumFlujoVigE) = "FIJA" Then
      oDctoWord.Bookmarks.Item("BaseBco").Range.Text = "Base Cálculo " & Contrato(ColsArrayContrato.EntregaGlosaBase, nNumFlujoVigE) ''REQ.7904
      oDctoWord.Bookmarks.Item("TasaBco").Range.Text = Format(Contrato(ColsArrayContrato.ValorTasaEntrego, nNumFlujoVigE), "#,##0.0000") & " % "
      oDctoWord.Bookmarks.Item("TasaBco2").Range.Text = Format(Contrato(ColsArrayContrato.ValorTasaEntrego, nNumFlujoVigE), "#,##0.0000") & " % "
      oDctoWord.Bookmarks.Item("TasaBco3").Range.Text = Format(Contrato(ColsArrayContrato.ValorTasaEntrego, nNumFlujoVigE), "#,##0.0000") & " % "
      oDctoWord.Bookmarks.Item("TasaBco4").Range.Text = Format(Contrato(ColsArrayContrato.ValorTasaEntrego, nNumFlujoVigE), "#,##0.0000") & " % "
      oDctoWord.Bookmarks.Item("TasaBco5").Range.Text = Format(Contrato(ColsArrayContrato.ValorTasaEntrego, nNumFlujoVigE), "#,##0.0000") & " % "
      oDctoWord.Bookmarks.Item("FijaVarBco").Range.Text = Contrato(ColsArrayContrato.EntregoTasaDesc, nNumFlujoVigE)
      oDctoWord.Bookmarks.Item("FijaVarBco2").Range.Text = Contrato(ColsArrayContrato.EntregoTasaDesc, nNumFlujoVigE)
      oDctoWord.Bookmarks.Item("FijaVarBco3").Range.Text = Contrato(ColsArrayContrato.EntregoTasaDesc, nNumFlujoVigE)
      oDctoWord.Bookmarks.Item("FijaVarBco4").Range.Text = Contrato(ColsArrayContrato.EntregoTasaDesc, nNumFlujoVigE)
      oDctoWord.Bookmarks.Item("FijaVarBco5").Range.Text = Contrato(ColsArrayContrato.EntregoTasaDesc, nNumFlujoVigE)
   Else
      oDctoWord.Bookmarks.Item("BaseBco").Range.Text = "Base Cálculo " & Contrato(ColsArrayContrato.EntregaGlosaBase, nNumFlujoVigE) ''REQ.7904
      oDctoWord.Bookmarks.Item("TasaBco").Range.Text = Contrato(ColsArrayContrato.EntregoTasaDesc, nNumFlujoVigE) & " + " & Format(Contrato(ColsArrayContrato.EntregoSpread, nNumFlujoVigE), "#,##0.0000") & "%"
      oDctoWord.Bookmarks.Item("TasaBco2").Range.Text = Contrato(ColsArrayContrato.EntregoTasaDesc, nNumFlujoVigE) & " + " & Format(Contrato(ColsArrayContrato.EntregoSpread, nNumFlujoVigE), "#,##0.0000") & "%"
      oDctoWord.Bookmarks.Item("TasaBco3").Range.Text = Contrato(ColsArrayContrato.EntregoTasaDesc, nNumFlujoVigE) & " + " & Format(Contrato(ColsArrayContrato.EntregoSpread, nNumFlujoVigE), "#,##0.0000") & "%"
      oDctoWord.Bookmarks.Item("TasaBco4").Range.Text = Contrato(ColsArrayContrato.EntregoTasaDesc, nNumFlujoVigE) & " + " & Format(Contrato(ColsArrayContrato.EntregoSpread, nNumFlujoVigE), "#,##0.0000") & "%"
      oDctoWord.Bookmarks.Item("TasaBco5").Range.Text = Contrato(ColsArrayContrato.EntregoTasaDesc, nNumFlujoVigE) & " + " & Format(Contrato(ColsArrayContrato.EntregoSpread, nNumFlujoVigE), "#,##0.0000") & "%"
      oDctoWord.Bookmarks.Item("FijaVarBco").Range.Text = Contrato(ColsArrayContrato.EntregoTasaDesc, nNumFlujoVigE) & " + SPREAD"
      oDctoWord.Bookmarks.Item("FijaVarBco2").Range.Text = Contrato(ColsArrayContrato.EntregoTasaDesc, nNumFlujoVigE) & " + SPREAD"
      oDctoWord.Bookmarks.Item("FijaVarBco3").Range.Text = Contrato(ColsArrayContrato.EntregoTasaDesc, nNumFlujoVigE) & " + SPREAD"
      oDctoWord.Bookmarks.Item("FijaVarBco4").Range.Text = Contrato(ColsArrayContrato.EntregoTasaDesc, nNumFlujoVigE) & " + SPREAD"
      oDctoWord.Bookmarks.Item("FijaVarBco5").Range.Text = Contrato(ColsArrayContrato.EntregoTasaDesc, nNumFlujoVigE) & " + SPREAD"
   End If
   
''''   oDctoWord.Bookmarks.Item("ValutaPago2").Range.Text = DatosContrato(6) & ": T + " & Contrato(ColsArrayContrato.Valuta, nNumFlujoVigE)
''''   oDctoWord.Bookmarks.Item("FormaPago2").Range.Text = DatosContrato(6) & ": " & IIf((Contrato(ColsArrayContrato.PagamosDoc, nNumFlujoVigE) <> ""), (Contrato(ColsArrayContrato.PagamosDoc, nNumFlujoVigE)), "N/A")
            
   If Contrato(ColsArrayContrato.ReciboTasaDesc, nNumFlujoVigR) = "FIJA" Then
      oDctoWord.Bookmarks.Item("BaseCli").Range.Text = "Base Cálculo " & Contrato(ColsArrayContrato.RecibeGlosaBase, nNumFlujoVigR) ''REQ.7904
      oDctoWord.Bookmarks.Item("TasaCli").Range.Text = Format(Contrato(ColsArrayContrato.ValorTasaRecibo, nNumFlujoVigR), "###0.0000") & " % "
      oDctoWord.Bookmarks.Item("TasaCli2").Range.Text = Format(Contrato(ColsArrayContrato.ValorTasaRecibo, nNumFlujoVigR), "###0.0000") & " % "
      oDctoWord.Bookmarks.Item("TasaCli3").Range.Text = Format(Contrato(ColsArrayContrato.ValorTasaRecibo, nNumFlujoVigR), "###0.0000") & " % "
      oDctoWord.Bookmarks.Item("TasaCli4").Range.Text = Format(Contrato(ColsArrayContrato.ValorTasaRecibo, nNumFlujoVigR), "###0.0000") & " % "
      oDctoWord.Bookmarks.Item("TasaCli5").Range.Text = Format(Contrato(ColsArrayContrato.ValorTasaRecibo, nNumFlujoVigR), "###0.0000") & " % "
      oDctoWord.Bookmarks.Item("FijaVarCli").Range.Text = Contrato(ColsArrayContrato.ReciboTasaDesc, nNumFlujoVigR)
      oDctoWord.Bookmarks.Item("FijaVarCli2").Range.Text = Contrato(ColsArrayContrato.ReciboTasaDesc, nNumFlujoVigR)
      oDctoWord.Bookmarks.Item("FijaVarCli3").Range.Text = Contrato(ColsArrayContrato.ReciboTasaDesc, nNumFlujoVigR)
      oDctoWord.Bookmarks.Item("FijaVarCli4").Range.Text = Contrato(ColsArrayContrato.ReciboTasaDesc, nNumFlujoVigR)
      oDctoWord.Bookmarks.Item("FijaVarCli5").Range.Text = Contrato(ColsArrayContrato.ReciboTasaDesc, nNumFlujoVigR)
      
   Else
      oDctoWord.Bookmarks.Item("BaseCli").Range.Text = "Base Cálculo " & Contrato(ColsArrayContrato.RecibeGlosaBase, nNumFlujoVigR) ''REQ.7904
      oDctoWord.Bookmarks.Item("TasaCli").Range.Text = Contrato(ColsArrayContrato.ReciboTasaDesc, nNumFlujoVigR) & " + " & Format(Contrato(ColsArrayContrato.ReciboSpread, nNumFlujoVigR), "###0.0000") & "%"
      oDctoWord.Bookmarks.Item("TasaCli2").Range.Text = Contrato(ColsArrayContrato.ReciboTasaDesc, nNumFlujoVigR) & " + " & Format(Contrato(ColsArrayContrato.ReciboSpread, nNumFlujoVigR), "###0.0000") & "%"
      oDctoWord.Bookmarks.Item("TasaCli3").Range.Text = Contrato(ColsArrayContrato.ReciboTasaDesc, nNumFlujoVigR) & " + " & Format(Contrato(ColsArrayContrato.ReciboSpread, nNumFlujoVigR), "###0.0000") & "%"
      oDctoWord.Bookmarks.Item("TasaCli4").Range.Text = Contrato(ColsArrayContrato.ReciboTasaDesc, nNumFlujoVigR) & " + " & Format(Contrato(ColsArrayContrato.ReciboSpread, nNumFlujoVigR), "###0.0000") & "%"
      oDctoWord.Bookmarks.Item("TasaCli5").Range.Text = Contrato(ColsArrayContrato.ReciboTasaDesc, nNumFlujoVigR) & " + " & Format(Contrato(ColsArrayContrato.ReciboSpread, nNumFlujoVigR), "###0.0000") & "%"
      oDctoWord.Bookmarks.Item("FijaVarCli").Range.Text = Contrato(ColsArrayContrato.ReciboTasaDesc, nNumFlujoVigR) & " + SPREAD"
      oDctoWord.Bookmarks.Item("FijaVarCli2").Range.Text = Contrato(ColsArrayContrato.ReciboTasaDesc, nNumFlujoVigR) & " + SPREAD"
      oDctoWord.Bookmarks.Item("FijaVarCli3").Range.Text = Contrato(ColsArrayContrato.ReciboTasaDesc, nNumFlujoVigR) & " + SPREAD"
      oDctoWord.Bookmarks.Item("FijaVarCli4").Range.Text = Contrato(ColsArrayContrato.ReciboTasaDesc, nNumFlujoVigR) & " + SPREAD"
      oDctoWord.Bookmarks.Item("FijaVarCli5").Range.Text = Contrato(ColsArrayContrato.ReciboTasaDesc, nNumFlujoVigR) & " + SPREAD"
   End If
   ''''   End If
      
   ''''Next nRecorreFlujos
   
   oDctoWord.Bookmarks.Item("CambioRef").Range.Text = FuncEntregaTCRef(Contrato(45, 1))
   oDctoWord.Bookmarks.Item("TIPO_CAMBIO_REF").Range.Text = FuncEntregaTCRef(Contrato(45, 1))
   
   oDctoWord.Bookmarks.Item("ParidadRef").Range.Text = "N/A"
   oDctoWord.Bookmarks.Item("Lugar").Range.Text = "SANTIAGO"
   oDctoWord.Bookmarks.Item("ModalidadPago").Range.Text = IIf(Contrato(ColsArrayContrato.Modalidad, 1) = "ENTREGA", "ENTREGA FISICA", "COMPENSACION")
   
   If Contrato(ColsArrayContrato.Modalidad, 1) <> "COMPENSACION" Then
      oDctoWord.Bookmarks.Item("FraseNemoMonMod").Range.Text = Contrato(ColsArrayContrato.TituloModEntFis, UBound(Contrato, 2)) & " " & Contrato(ColsArrayContrato.EntregoNemoMonPago, UBound(Contrato, 2)) & " " & Contrato(ColsArrayContrato.TituloModEntFis2, UBound(Contrato, 2)) & " " & Contrato(ColsArrayContrato.ReciboNemoMonPago, UBound(Contrato, 2))
   Else
      oDctoWord.Bookmarks.Item("FraseNemoMonMod").Range.Text = Contrato(ColsArrayContrato.TituloModCompensa, UBound(Contrato, 2)) & " " & Contrato(ColsArrayContrato.EntregoNemoMonPago, UBound(Contrato, 2))
   End If
      
   oDctoWord.Bookmarks.Item("MontoInterNocIniR").Range.Text = IIf(nMontoInterNocIniR <> -999, cNemoMonR & " " & Format(nMontoInterNocIniR, "#,##0.0000"), "N/A")
   oDctoWord.Bookmarks.Item("FechaInterNocIniR").Range.Text = IIf(cFechaInterNocIniR <> "01/01/1900", Trim(Strings.Split(Format(cFechaInterNocIniR, "Long Date"), ",")(1)), "N/A")
   oDctoWord.Bookmarks.Item("MontoInterNocIniE").Range.Text = IIf(nMontoInterNocIniE <> -999, cNemoMonE & " " & Format(nMontoInterNocIniE, "#,##0.0000"), "N/A")
   oDctoWord.Bookmarks.Item("FechaInterNocIniE").Range.Text = IIf(cFechaInterNocIniE <> "01/01/1900", Trim(Strings.Split(Format(cFechaInterNocIniE, "Long Date"), ",")(1)), "N/A")
   
   oDctoWord.Bookmarks.Item("MontoInterNocFinR").Range.Text = IIf(nMontoInterNocFinR <> -999, cNemoMonR & " " & Format(nMontoInterNocFinR, "#,##0.0000"), "N/A")
   oDctoWord.Bookmarks.Item("FechaInterNocFinR").Range.Text = IIf(cFechaInterNocFinR <> "01/01/1900", Trim(Strings.Split(Format(cFechaInterNocFinR, "Long Date"), ",")(1)), "N/A")
   oDctoWord.Bookmarks.Item("MontoInterNocFinE").Range.Text = IIf(nMontoInterNocFinE <> -999, cNemoMonE & " " & Format(nMontoInterNocFinE, "#,##0.0000"), "N/A")
   oDctoWord.Bookmarks.Item("FechaInterNocFinE").Range.Text = IIf(cFechaInterNocFinE <> "01/01/1900", Trim(Strings.Split(Format(cFechaInterNocFinE, "Long Date"), ",")(1)), "N/A")
     
   oDctoWord.Bookmarks.Item("MonRecibe").Range.Text = cNemoMonR
   oDctoWord.Bookmarks.Item("MonRecibe2").Range.Text = cNemoMonR
   oDctoWord.Bookmarks.Item("MonRecibe3").Range.Text = cNemoMonR
   
   oDctoWord.Bookmarks.Item("MonPaga").Range.Text = cNemoMonE
   oDctoWord.Bookmarks.Item("MonPaga2").Range.Text = cNemoMonE
   oDctoWord.Bookmarks.Item("MonPaga3").Range.Text = cNemoMonE
   
   'oDctoWord.Bookmarks.Item("Intercambio_Inicial").Range.Text = Contrato(50, 1)
   If Contrato(50, 1) = 0 Then
        oDctoWord.Bookmarks.Item("Intercambio_Inicial").Range.Text = "Sin Intercambio"
        oDctoWord.Bookmarks.Item("Intercambio_Inicial2").Range.Text = ""
        oDctoWord.Bookmarks.Item("Intercambio_Inicial3").Range.Text = ""
   ElseIf Contrato(50, 1) = 1 Then
        oDctoWord.Bookmarks.Item("Intercambio_Inicial").Range.Text = "-  Fecha Intercambio Inicial: " & IIf(cFechaInterNocIniR <> "01/01/1900", Trim(Strings.Split(Format(cFechaInterNocIniR, "Long Date"), ",")(1)), "N/A")
        oDctoWord.Bookmarks.Item("Intercambio_Inicial2").Range.Text = "-  Monto Intercambio Inicial para " & DatosContrato(1) & ": " & IIf(nMontoInterNocIniR <> -999, cNemoMonR & " " & Format(nMontoInterNocIniR, "#,##0.0000"), "N/A")
        oDctoWord.Bookmarks.Item("Intercambio_Inicial3").Range.Text = "-  Monto Intercambio Inicial para " & DatosContrato(6) & ": " & IIf(nMontoInterNocIniE <> -999, cNemoMonE & " " & Format(nMontoInterNocIniE, "#,##0.0000"), "N/A")
   End If

   If Contrato(51, 1) = 0 Then
        oDctoWord.Bookmarks.Item("Intercambio_Final").Range.Text = "Sin Intercambio"
        oDctoWord.Bookmarks.Item("Intercambio_Final2").Range.Text = ""
        oDctoWord.Bookmarks.Item("Intercambio_Final3").Range.Text = ""
   ElseIf Contrato(51, 1) = 1 Then
        oDctoWord.Bookmarks.Item("Intercambio_Final").Range.Text = "-  Fecha Intercambio Final: " & IIf(cFechaInterNocFinR <> "01/01/1900", Trim(Strings.Split(Format(cFechaInterNocFinR, "Long Date"), ",")(1)), "N/A")
        oDctoWord.Bookmarks.Item("Intercambio_Final2").Range.Text = "-  Monto Intercambio Final para " & DatosContrato(1) & ": " & IIf(nMontoInterNocFinR <> -999, cNemoMonR & " " & Format(nMontoInterNocFinR, "#,##0.0000"), "N/A")
        oDctoWord.Bookmarks.Item("Intercambio_Final3").Range.Text = "-  Monto Intercambio Final para " & DatosContrato(6) & ": " & IIf(nMontoInterNocFinE <> -999, cNemoMonE & " " & Format(nMontoInterNocFinE, "#,##0.0000"), "N/A")
   End If
   
   nContadorLineas = 1
   nContador = 1
   
   On Error GoTo Control_Error_Grilla
  
   If cTipoSwap = "TASA" Then '///////////////// SWAP DE TASA \\\\\\\\\\\\\\\\\
   
      ' ********************************************************************************************************
      ' ***************************************** Llena Grilla Pagamos *****************************************
      ' ********************************************************************************************************
   
      oDctoWord.Bookmarks("GrillaEntrego").Select
       'Grilla Recibimos
       For nRecorreFlujos = 1 To UBound(Contrato, 2)
   
           If nContadorLineas > 1 And Contrato(ColsArrayContrato.TipoFlujo, nRecorreFlujos) = 1 Then
               oDctoWord.Application.Selection.MoveRight Unit:=wdCell
               oDctoWord.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphCenter
           End If
   
           If Contrato(ColsArrayContrato.TipoFlujo, nRecorreFlujos) = 1 And Contrato(ColsArrayContrato.NumeroFlujo, nRecorreFlujos) > 1 Then
              oDctoWord.Application.Selection.Text = Contrato(ColsArrayContrato.FechaFijacionTasa, nRecorreFlujos)
              oDctoWord.Application.Selection.MoveRight Unit:=wdCell
              oDctoWord.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphCenter
              
              oDctoWord.Application.Selection.Text = Contrato(ColsArrayContrato.FechaInicioFlujo, nRecorreFlujos)
              oDctoWord.Application.Selection.MoveRight Unit:=wdCell
              oDctoWord.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphCenter
              
              oDctoWord.Application.Selection.Text = Contrato(ColsArrayContrato.FechaLiquidacion, nRecorreFlujos)
              oDctoWord.Application.Selection.MoveRight Unit:=wdCell
              oDctoWord.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphCenter
   
              oDctoWord.Application.Selection.Text = Contrato(ColsArrayContrato.Dias, nRecorreFlujos)
              oDctoWord.Application.Selection.MoveRight Unit:=wdCell
              oDctoWord.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphCenter
   
              oDctoWord.Application.Selection.Text = cNemoMonR & " " & Format((Contrato(ColsArrayContrato.ReciboSaldo, nRecorreFlujos)), "#,##0.0000")
              oDctoWord.Application.Selection.MoveRight Unit:=wdCell
              oDctoWord.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphCenter
   
              oDctoWord.Application.Selection.Text = cNemoMonR & " " & Format((Contrato(ColsArrayContrato.ReciboArmotiza, nRecorreFlujos)), "#,##0.0000")
              oDctoWord.Application.Selection.MoveRight Unit:=wdCell
              oDctoWord.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
   
              If Contrato(ColsArrayContrato.ReciboTasaDesc, nRecorreFlujos) = "FIJA" Or Contrato(ColsArrayContrato.NumeroFlujo, nRecorreFlujos) = 1 Then
                   oDctoWord.Application.Selection.Text = Format(Contrato(ColsArrayContrato.ReciboInteres, nRecorreFlujos), "#,##0.0000") & " "
                  'oDctoWord.Application.Selection.Text = Format(Contrato(ColsArrayContrato.ValorTasaRecibo, nRecorreFlujos), "#,##0.0000") & "%"
              Else
                   oDctoWord.Application.Selection.Text = Contrato(ColsArrayContrato.ReciboTasaDesc, nRecorreFlujos) & " + " & Format(Contrato(ColsArrayContrato.ReciboSpread, nRecorreFlujos), "###0.0000") & "%"
              End If
              oDctoWord.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphCenter
              
              nContadorLineas = nContadorLineas + 1
         End If
       Next nRecorreFlujos
   
      ' ********************************************************************************************************
      ' **************************************** Llena Grilla Recibimos ****************************************
      ' ********************************************************************************************************
     
      nContadorLineas = 1
      nContador = 1
      
      oDctoWord.Bookmarks("GrillaRecibo").Select
   
       For nRecorreFlujos = 1 To UBound(Contrato, 2)
   
           If nContadorLineas > 1 And Contrato(ColsArrayContrato.TipoFlujo, nRecorreFlujos) = 2 Then
              oDctoWord.Application.Selection.MoveRight Unit:=wdCell
              oDctoWord.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphCenter
           End If
   
           If Contrato(ColsArrayContrato.TipoFlujo, nRecorreFlujos) = 2 And Contrato(ColsArrayContrato.NumeroFlujo, nRecorreFlujos) > 1 Then  'Tipo de flujo
              oDctoWord.Application.Selection.Text = Contrato(ColsArrayContrato.FechaFijacionTasa, nRecorreFlujos)   'Fecha Fijacion Tasa
              oDctoWord.Application.Selection.MoveRight Unit:=wdCell
              oDctoWord.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphCenter
              
              oDctoWord.Application.Selection.Text = Contrato(ColsArrayContrato.FechaInicioFlujo, nRecorreFlujos)    'Fecha Fijacion Tasa
              oDctoWord.Application.Selection.MoveRight Unit:=wdCell
              oDctoWord.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphCenter
              
              oDctoWord.Application.Selection.Text = Contrato(ColsArrayContrato.FechaLiquidacion, nRecorreFlujos)   'Fecha Liquidación
              oDctoWord.Application.Selection.MoveRight Unit:=wdCell
              oDctoWord.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphCenter
   
              oDctoWord.Application.Selection.Text = Contrato(ColsArrayContrato.Dias, nRecorreFlujos)    'Cantidad de Dias
              oDctoWord.Application.Selection.MoveRight Unit:=wdCell
              oDctoWord.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphCenter
   
              oDctoWord.Application.Selection.Text = cNemoMonE & " " & Format((Contrato(ColsArrayContrato.EntregoSaldo, nRecorreFlujos)), "#,##0.0000")    'Monto Saldo + Amortiza
              oDctoWord.Application.Selection.MoveRight Unit:=wdCell
              oDctoWord.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphCenter
   
              oDctoWord.Application.Selection.Text = cNemoMonE & " " & Format((Contrato(ColsArrayContrato.EntregoArmotiza, nRecorreFlujos)), "#,##0.0000")    'Monto de Amortizacion
              oDctoWord.Application.Selection.MoveRight Unit:=wdCell
              oDctoWord.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
   
              If Contrato(ColsArrayContrato.EntregoTasaDesc, nRecorreFlujos) = "FIJA" Or Contrato(ColsArrayContrato.NumeroFlujo, nRecorreFlujos) = 1 Then
                 oDctoWord.Application.Selection.Text = Format(Contrato(ColsArrayContrato.EntregoInteres, nRecorreFlujos), "#,##0.0000") & " "
                'oDctoWord.Application.Selection.Text = Format(Contrato(ColsArrayContrato.ValorTasaEntrego, nRecorreFlujos), "#,##0.0000") & "%"
              Else
                 oDctoWord.Application.Selection.Text = Contrato(ColsArrayContrato.EntregoTasaDesc, nRecorreFlujos) & " + " & Format(Contrato(ColsArrayContrato.EntregoSpread, nRecorreFlujos), "#,##0.0000") & "%"
              End If
              oDctoWord.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphCenter
              nContadorLineas = nContadorLineas + 1
           End If
       Next nRecorreFlujos
    End If
    
    
    If cTipoSwap = "CAMARA" Then '///////////////// SWAP PROMEDIO CAMARA \\\\\\\\\\\\\\\\\
    
      ' ********************************************************************************************************
      ' ***************************************** Llena Grilla Pagamos *****************************************
      ' ********************************************************************************************************
      oDctoWord.Bookmarks("Grilla").Select
      
      If Contrato(ColsArrayContrato.ReciboTasaDesc, 1) = "ICP" Then
       'Grilla Recibimos
         For nRecorreFlujos = 1 To UBound(Contrato, 2)
         
             If nContadorLineas > 1 And Contrato(ColsArrayContrato.TipoFlujo, nRecorreFlujos) = 1 Then
                 oDctoWord.Application.Selection.MoveRight Unit:=wdCell
                 
             End If
         
             If Contrato(ColsArrayContrato.TipoFlujo, nRecorreFlujos) = 1 Then
                oDctoWord.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphCenter
                oDctoWord.Application.Selection.Text = Contrato(ColsArrayContrato.FechaLiquidacion, nRecorreFlujos)
                oDctoWord.Application.Selection.MoveRight Unit:=wdCell
                
                oDctoWord.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphRight
                oDctoWord.Application.Selection.Text = Format(Contrato(ColsArrayContrato.MontoOperacion, nRecorreFlujos), "#,##0.####")
                oDctoWord.Application.Selection.MoveRight Unit:=wdCell
                         
                oDctoWord.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphRight
                
                If Contrato(ColsArrayContrato.ReciboTasaDesc, nRecorreFlujos) = "FIJA" Or Contrato(ColsArrayContrato.NumeroFlujo, nRecorreFlujos) = 1 Then
                     oDctoWord.Application.Selection.Text = Format(Contrato(ColsArrayContrato.ReciboInteres, nRecorreFlujos), "#,##0.0000") & " "
                    'oDctoWord.Application.Selection.Text = Format(Contrato(ColsArrayContrato.ValorTasaRecibo, nRecorreFlujos), "#,##0.0000") & "%"
                Else
                     oDctoWord.Application.Selection.Text = Contrato(ColsArrayContrato.ReciboTasaDesc, nRecorreFlujos) & " + " & Format(Contrato(ColsArrayContrato.ReciboSpread, nRecorreFlujos), "###0.0000") & "%"
                End If
                
                nContadorLineas = nContadorLineas + 1
           End If
         Next nRecorreFlujos
       
      ElseIf Contrato(ColsArrayContrato.ReciboTasaDesc, UBound(Contrato, 2)) = "ICP" Then
         
         nContadorLineas = 1
         nContador = 1
         
         oDctoWord.Bookmarks("Grilla").Select
         
         For nRecorreFlujos = 1 To UBound(Contrato, 2)
         
             If nContadorLineas > 1 And Contrato(ColsArrayContrato.TipoFlujo, nRecorreFlujos) = 2 Then
                oDctoWord.Application.Selection.MoveRight Unit:=wdCell
             End If
         
             If Contrato(ColsArrayContrato.TipoFlujo, nRecorreFlujos) = 2 Then 'Tipo de flujo
                oDctoWord.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphCenter
                oDctoWord.Application.Selection.Text = Contrato(ColsArrayContrato.FechaLiquidacion, nRecorreFlujos)     'Fecha Fijacion Tasa
                oDctoWord.Application.Selection.MoveRight Unit:=wdCell
                                
                oDctoWord.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphRight
                oDctoWord.Application.Selection.Text = Format(Contrato(ColsArrayContrato.MontoOperacion, nRecorreFlujos), "#,##0.####")
                oDctoWord.Application.Selection.MoveRight Unit:=wdCell
                
                oDctoWord.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphRight
            
                If Contrato(ColsArrayContrato.EntregoTasaDesc, nRecorreFlujos) = "FIJA" Or Contrato(ColsArrayContrato.NumeroFlujo, nRecorreFlujos) = 1 Then
                   oDctoWord.Application.Selection.Text = Format(Contrato(ColsArrayContrato.EntregoInteres, nRecorreFlujos), "#,##0.0000") & " "
                  'oDctoWord.Application.Selection.Text = Format(Contrato(ColsArrayContrato.ValorTasaEntrego, nRecorreFlujos), "#,##0.0000") & "%"
                Else
                   oDctoWord.Application.Selection.Text = Contrato(ColsArrayContrato.EntregoTasaDesc, nRecorreFlujos) & " + " & Format(Contrato(ColsArrayContrato.EntregoSpread, nRecorreFlujos), "#,##0.0000") & "%"
                End If
                
                nContadorLineas = nContadorLineas + 1
             End If
         Next nRecorreFlujos
      End If
        
    End If
    
    If cTipoSwap = "MONEDA" Then '///////////////// SWAP DE MONEDA \\\\\\\\\\\\\\\\\
    
       ' ********************************************************************************************************
       ' ***************************************** Llena Grilla Recibimos ***************************************
       ' ********************************************************************************************************
           
       nContadorLineas = 1
       oDctoWord.Bookmarks("GrillaRecibo").Select
       'Grilla Recibimos
       
       For nRecorreFlujos = 1 To UBound(Contrato, 2)
           If nContadorLineas > 1 And Contrato(ColsArrayContrato.TipoFlujo, nRecorreFlujos) = 1 Then
               oDctoWord.Application.Selection.MoveRight Unit:=wdCell
               oDctoWord.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphCenter
           End If
           
           If Contrato(ColsArrayContrato.TipoFlujo, nRecorreFlujos) = 1 And Contrato(ColsArrayContrato.NumeroFlujo, nRecorreFlujos) > 1 Then
              oDctoWord.Application.Selection.Text = Contrato(ColsArrayContrato.FechaFijacionTasa, nRecorreFlujos)
              oDctoWord.Application.Selection.MoveRight Unit:=wdCell
              oDctoWord.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphCenter
               
              oDctoWord.Application.Selection.Text = Contrato(ColsArrayContrato.FechaInicioFlujo, nRecorreFlujos)
              oDctoWord.Application.Selection.MoveRight Unit:=wdCell
              oDctoWord.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphCenter
              
              oDctoWord.Application.Selection.Text = Contrato(ColsArrayContrato.FechaLiquidacion, nRecorreFlujos)
              oDctoWord.Application.Selection.MoveRight Unit:=wdCell
              oDctoWord.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
              
              oDctoWord.Application.Selection.Text = Contrato(ColsArrayContrato.Dias, nRecorreFlujos)
              oDctoWord.Application.Selection.MoveRight Unit:=wdCell
              oDctoWord.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphRight
              
              oDctoWord.Application.Selection.Text = cNemoMonR & " " & Format(Contrato(ColsArrayContrato.ReciboSaldo, nRecorreFlujos), "#,##0.0000")
              oDctoWord.Application.Selection.MoveRight Unit:=wdCell
              oDctoWord.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphRight
              
              oDctoWord.Application.Selection.Text = cNemoMonR & " " & Format(Contrato(ColsArrayContrato.ReciboArmotiza, nRecorreFlujos), "#,##0.0000")
              oDctoWord.Application.Selection.MoveRight Unit:=wdCell
              oDctoWord.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphRight
              
              If Contrato(ColsArrayContrato.ReciboTasaDesc, nRecorreFlujos) = "FIJA" Or Contrato(ColsArrayContrato.NumeroFlujo, nRecorreFlujos) = 1 Then
                   oDctoWord.Application.Selection.Text = Format(Contrato(ColsArrayContrato.ReciboInteres, nRecorreFlujos), "#,##0.0000") & " "
                  'oDctoWord.Application.Selection.Text = Format(Contrato(ColsArrayContrato.ValorTasaRecibo, nRecorreFlujos), "#,##0.0000") & "%"
              Else
                   oDctoWord.Application.Selection.Text = Contrato(ColsArrayContrato.ReciboTasaDesc, nRecorreFlujos) & " + " & Format(Contrato(ColsArrayContrato.ReciboSpread, nRecorreFlujos), "###0.0000") & "%"
              End If
              nContadorLineas = nContadorLineas + 1
           End If
       Next nRecorreFlujos
       
       ' ********************************************************************************************************
       ' **************************************** Llena Grilla Entregamos ***************************************
       ' ********************************************************************************************************
      
       nContadorLineas = 1
       oDctoWord.Bookmarks("GrillaEntrego").Select
       'Grilla Entregamos
       
       For nRecorreFlujos = 1 To UBound(Contrato, 2)
           If nContadorLineas > 1 And Contrato(ColsArrayContrato.TipoFlujo, nRecorreFlujos) = 2 Then
               oDctoWord.Application.Selection.MoveRight Unit:=wdCell
               oDctoWord.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphCenter
           End If
           
           If Contrato(ColsArrayContrato.TipoFlujo, nRecorreFlujos) = 2 And Contrato(ColsArrayContrato.NumeroFlujo, nRecorreFlujos) > 1 Then
              oDctoWord.Application.Selection.Text = Contrato(ColsArrayContrato.FechaFijacionTasa, nRecorreFlujos)
              oDctoWord.Application.Selection.MoveRight Unit:=wdCell
              oDctoWord.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphCenter
                            
              oDctoWord.Application.Selection.Text = Contrato(ColsArrayContrato.FechaInicioFlujo, nRecorreFlujos)
              oDctoWord.Application.Selection.MoveRight Unit:=wdCell
              oDctoWord.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphCenter
              
              oDctoWord.Application.Selection.Text = Contrato(ColsArrayContrato.FechaLiquidacion, nRecorreFlujos)
              oDctoWord.Application.Selection.MoveRight Unit:=wdCell
              oDctoWord.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphCenter
              
              oDctoWord.Application.Selection.Text = Contrato(ColsArrayContrato.Dias, nRecorreFlujos)
              oDctoWord.Application.Selection.MoveRight Unit:=wdCell
              oDctoWord.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphRight
              
              oDctoWord.Application.Selection.Text = cNemoMonE & " " & Format(Contrato(ColsArrayContrato.EntregoSaldo, nRecorreFlujos), "#,##0.0000")
              oDctoWord.Application.Selection.MoveRight Unit:=wdCell
              oDctoWord.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphRight
              
              oDctoWord.Application.Selection.Text = cNemoMonE & " " & Format(Contrato(ColsArrayContrato.EntregoArmotiza, nRecorreFlujos), "#,##0.0000")
              oDctoWord.Application.Selection.MoveRight Unit:=wdCell
              oDctoWord.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphRight
              
              If Contrato(ColsArrayContrato.EntregoTasaDesc, nRecorreFlujos) = "FIJA" Or Contrato(ColsArrayContrato.NumeroFlujo, nRecorreFlujos) = 1 Then
                   oDctoWord.Application.Selection.Text = Format(Contrato(ColsArrayContrato.EntregoInteres, nRecorreFlujos), "#,##0.0000") & " "
                  'oDctoWord.Application.Selection.Text = Format(Contrato(ColsArrayContrato.ValorTasaEntrego, nRecorreFlujos), "#,##0.0000") & "%"
              Else
                   oDctoWord.Application.Selection.Text = Contrato(ColsArrayContrato.EntregoTasaDesc, nRecorreFlujos) & " + " & Format(Contrato(ColsArrayContrato.EntregoSpread, nRecorreFlujos), "#,##0.0000") & "%"
              End If
              
              nContadorLineas = nContadorLineas + 1
           End If
       Next nRecorreFlujos
    
    End If
    
    Set ClsMoneda = Nothing
    
    Func_Completa_Datos_Operacion = True
Exit Function

Control_Error:

    If err.Number = 5941 Then
        Resume Next
    Else
        Screen.MousePointer = vbDefault
        MsgBox err.Description, vbCritical + vbOKOnly
        Exit Function
    End If
    
Control_Error_Grilla:

    If err.Number = 5941 Then
        Func_Completa_Datos_Operacion = True
        Exit Function
    Else
        Screen.MousePointer = vbDefault
        MsgBox err.Description, vbCritical + vbOKOnly
        Exit Function
    End If
    
End Function

Private Function Func_Completa_Campos_Fijos(ByVal oDctoWord As Word.Document, cCodDctoPrinc As String, cConceptoImpresion As String, sTipoSwap As String, nNumoper As Long, Contrato()) As Boolean

   On Error GoTo Control_Error

   Dim nMontoOperacion  As Double
   Dim cNombreCiudad    As String
   Dim cNombreComuna    As String
   Dim sTexto           As String
   Dim sTipoContrato    As String

   Func_Completa_Campos_Fijos = False
   
   oDctoWord.Activate
  'oDctoWord.Application.Visible = True

   oDctoWord.Bookmarks.Item("Dia").Range.Text = Func_Busca_Valores_Contrato("NMC001", cConceptoImpresion)
   oDctoWord.Bookmarks.Item("Dia2").Range.Text = Func_Busca_Valores_Contrato("NMC001", cConceptoImpresion)
   oDctoWord.Bookmarks.Item("Dia3").Range.Text = Func_Busca_Valores_Contrato("NMC001", cConceptoImpresion)
   oDctoWord.Bookmarks.Item("Dia4").Range.Text = Func_Busca_Valores_Contrato("NMC001", cConceptoImpresion)
   oDctoWord.Bookmarks.Item("Dia5").Range.Text = Func_Busca_Valores_Contrato("NMC001", cConceptoImpresion)

   oDctoWord.Bookmarks.Item("Mes").Range.Text = Func_Busca_Valores_Contrato("NMC002", cConceptoImpresion)
   oDctoWord.Bookmarks.Item("Mes2").Range.Text = Func_Busca_Valores_Contrato("NMC002", cConceptoImpresion)
   oDctoWord.Bookmarks.Item("Mes3").Range.Text = Func_Busca_Valores_Contrato("NMC002", cConceptoImpresion)
   oDctoWord.Bookmarks.Item("Mes4").Range.Text = Func_Busca_Valores_Contrato("NMC002", cConceptoImpresion)
   oDctoWord.Bookmarks.Item("Mes5").Range.Text = Func_Busca_Valores_Contrato("NMC002", cConceptoImpresion)

   oDctoWord.Bookmarks.Item("Año").Range.Text = Func_Busca_Valores_Contrato("NMC003", cConceptoImpresion)
   oDctoWord.Bookmarks.Item("Año2").Range.Text = Func_Busca_Valores_Contrato("NMC003", cConceptoImpresion)
   oDctoWord.Bookmarks.Item("Año3").Range.Text = Func_Busca_Valores_Contrato("NMC003", cConceptoImpresion)
   oDctoWord.Bookmarks.Item("Año4").Range.Text = Func_Busca_Valores_Contrato("NMC003", cConceptoImpresion)
   oDctoWord.Bookmarks.Item("Año5").Range.Text = Func_Busca_Valores_Contrato("NMC003", cConceptoImpresion)
      
   oDctoWord.Bookmarks.Item("Nom_Apo_Corp_1").Range.Text = Func_Busca_Valores_Contrato("NMC004", cConceptoImpresion)
   oDctoWord.Bookmarks.Item("Nom_Apo_Corp_12").Range.Text = Func_Busca_Valores_Contrato("NMC004", cConceptoImpresion)
   oDctoWord.Bookmarks.Item("Nom_Apo_Corp_13").Range.Text = Func_Busca_Valores_Contrato("NMC004", cConceptoImpresion)
   oDctoWord.Bookmarks.Item("Nom_Apo_Corp_14").Range.Text = Func_Busca_Valores_Contrato("NMC004", cConceptoImpresion)
   oDctoWord.Bookmarks.Item("Nom_Apo_Corp_15").Range.Text = Func_Busca_Valores_Contrato("NMC004", cConceptoImpresion)

   oDctoWord.Bookmarks.Item("CI_Apo_Corp_1").Range.Text = Func_Busca_Valores_Contrato("NMC005", cConceptoImpresion)
   oDctoWord.Bookmarks.Item("CI_Apo_Corp_12").Range.Text = Func_Busca_Valores_Contrato("NMC005", cConceptoImpresion)
   oDctoWord.Bookmarks.Item("CI_Apo_Corp_13").Range.Text = Func_Busca_Valores_Contrato("NMC005", cConceptoImpresion)
   oDctoWord.Bookmarks.Item("CI_Apo_Corp_14").Range.Text = Func_Busca_Valores_Contrato("NMC005", cConceptoImpresion)
   oDctoWord.Bookmarks.Item("CI_Apo_Corp_15").Range.Text = Func_Busca_Valores_Contrato("NMC005", cConceptoImpresion)

   oDctoWord.Bookmarks.Item("Nom_Apo_Corp_2").Range.Text = Func_Busca_Valores_Contrato("NMC006", cConceptoImpresion)
   oDctoWord.Bookmarks.Item("Nom_Apo_Corp_22").Range.Text = Func_Busca_Valores_Contrato("NMC006", cConceptoImpresion)
   oDctoWord.Bookmarks.Item("Nom_Apo_Corp_23").Range.Text = Func_Busca_Valores_Contrato("NMC006", cConceptoImpresion)
   oDctoWord.Bookmarks.Item("Nom_Apo_Corp_24").Range.Text = Func_Busca_Valores_Contrato("NMC006", cConceptoImpresion)
   oDctoWord.Bookmarks.Item("Nom_Apo_Corp_25").Range.Text = Func_Busca_Valores_Contrato("NMC006", cConceptoImpresion)
   
   oDctoWord.Bookmarks.Item("Direccion_Corp").Range.Text = UCase(ArregloParametrosBanco(ColsArrayParametrosBanco.DireccionEntidad))
   oDctoWord.Bookmarks.Item("Direccion_Corp2").Range.Text = UCase(ArregloParametrosBanco(ColsArrayParametrosBanco.DireccionEntidad))
   oDctoWord.Bookmarks.Item("Direccion_Corp3").Range.Text = UCase(ArregloParametrosBanco(ColsArrayParametrosBanco.DireccionEntidad))
   oDctoWord.Bookmarks.Item("Direccion_Corp4").Range.Text = UCase(ArregloParametrosBanco(ColsArrayParametrosBanco.DireccionEntidad))
   oDctoWord.Bookmarks.Item("Direccion_Corp5").Range.Text = UCase(ArregloParametrosBanco(ColsArrayParametrosBanco.DireccionEntidad))
   
   oDctoWord.Bookmarks.Item("DireccionBanco").Range.Text = ArregloParametrosBanco(ColsArrayParametrosBanco.DireccionEntidad) & ", comuna de " & ArregloParametrosBanco(6)
   oDctoWord.Bookmarks.Item("DireccionBancoEnt").Range.Text = ArregloParametrosBanco(ColsArrayParametrosBanco.DireccionEntidad) & ", comuna de " & ArregloParametrosBanco(6)

   oDctoWord.Bookmarks.Item("CI_Apo_Corp_2").Range.Text = Func_Busca_Valores_Contrato("NMC007", cConceptoImpresion)
   oDctoWord.Bookmarks.Item("CI_Apo_Corp_22").Range.Text = Func_Busca_Valores_Contrato("NMC007", cConceptoImpresion)
   oDctoWord.Bookmarks.Item("CI_Apo_Corp_23").Range.Text = Func_Busca_Valores_Contrato("NMC007", cConceptoImpresion)
   oDctoWord.Bookmarks.Item("CI_Apo_Corp_24").Range.Text = Func_Busca_Valores_Contrato("NMC007", cConceptoImpresion)
   oDctoWord.Bookmarks.Item("CI_Apo_Corp_25").Range.Text = Func_Busca_Valores_Contrato("NMC007", cConceptoImpresion)
   
   oDctoWord.Bookmarks.Item("Razon_Social_Cliente").Range.Text = Func_Busca_Valores_Contrato("NMC008", cConceptoImpresion)
   oDctoWord.Bookmarks.Item("Razon_Social_Cliente2").Range.Text = Func_Busca_Valores_Contrato("NMC008", cConceptoImpresion)
   oDctoWord.Bookmarks.Item("Razon_Social_Cliente3").Range.Text = Func_Busca_Valores_Contrato("NMC008", cConceptoImpresion)
   oDctoWord.Bookmarks.Item("Razon_Social_Cliente4").Range.Text = Func_Busca_Valores_Contrato("NMC008", cConceptoImpresion)
   oDctoWord.Bookmarks.Item("Razon_Social_Cliente5").Range.Text = Func_Busca_Valores_Contrato("NMC008", cConceptoImpresion)
      
   oDctoWord.Bookmarks.Item("Ci_Cliente").Range.Text = Func_Busca_Valores_Contrato("NMC009", cConceptoImpresion)
   oDctoWord.Bookmarks.Item("Ci_Cliente2").Range.Text = Func_Busca_Valores_Contrato("NMC009", cConceptoImpresion)
   oDctoWord.Bookmarks.Item("Ci_Cliente3").Range.Text = Func_Busca_Valores_Contrato("NMC009", cConceptoImpresion)
   oDctoWord.Bookmarks.Item("Ci_Cliente4").Range.Text = Func_Busca_Valores_Contrato("NMC009", cConceptoImpresion)
   oDctoWord.Bookmarks.Item("Ci_Cliente5").Range.Text = Func_Busca_Valores_Contrato("NMC009", cConceptoImpresion)

   oDctoWord.Bookmarks.Item("Nom_Apod_Cliente_1").Range.Text = Func_Busca_Valores_Contrato("NMC010", cConceptoImpresion)
   oDctoWord.Bookmarks.Item("Nom_Apod_Cliente_12").Range.Text = Func_Busca_Valores_Contrato("NMC010", cConceptoImpresion)
   oDctoWord.Bookmarks.Item("Nom_Apod_Cliente_13").Range.Text = Func_Busca_Valores_Contrato("NMC010", cConceptoImpresion)
   oDctoWord.Bookmarks.Item("Nom_Apod_Cliente_14").Range.Text = Func_Busca_Valores_Contrato("NMC010", cConceptoImpresion)
   oDctoWord.Bookmarks.Item("Nom_Apod_Cliente_15").Range.Text = Func_Busca_Valores_Contrato("NMC010", cConceptoImpresion)

   oDctoWord.Bookmarks.Item("CI_Apod_Cliente_1").Range.Text = Func_Busca_Valores_Contrato("NMC011", cConceptoImpresion)
   oDctoWord.Bookmarks.Item("CI_Apod_Cliente_12").Range.Text = Func_Busca_Valores_Contrato("NMC011", cConceptoImpresion)
   oDctoWord.Bookmarks.Item("CI_Apod_Cliente_13").Range.Text = Func_Busca_Valores_Contrato("NMC011", cConceptoImpresion)
   oDctoWord.Bookmarks.Item("CI_Apod_Cliente_14").Range.Text = Func_Busca_Valores_Contrato("NMC011", cConceptoImpresion)
   oDctoWord.Bookmarks.Item("CI_Apod_Cliente_15").Range.Text = Func_Busca_Valores_Contrato("NMC011", cConceptoImpresion)

   If Func_Busca_Valores_Contrato("NMC012", cConceptoImpresion) = "VALOR NO ENCONTRADO" Then
      oDctoWord.Bookmarks.Item("SIN_APODERADO_DOS").Range.Text = ""
      oDctoWord.Bookmarks.Item("SIN_APODERADO_TRES").Range.Text = ""
   Else
      oDctoWord.Bookmarks.Item("Nom_Apod_Cliente_2").Range.Text = Func_Busca_Valores_Contrato("NMC012", cConceptoImpresion)
      oDctoWord.Bookmarks.Item("Nom_Apod_Cliente_22").Range.Text = Func_Busca_Valores_Contrato("NMC012", cConceptoImpresion)
      oDctoWord.Bookmarks.Item("Nom_Apod_Cliente_23").Range.Text = Func_Busca_Valores_Contrato("NMC012", cConceptoImpresion)
      oDctoWord.Bookmarks.Item("Nom_Apod_Cliente_24").Range.Text = Func_Busca_Valores_Contrato("NMC012", cConceptoImpresion)
      oDctoWord.Bookmarks.Item("Nom_Apod_Cliente_25").Range.Text = Func_Busca_Valores_Contrato("NMC012", cConceptoImpresion)
   End If

'   If Func_Busca_Valores_Contrato("NMC012", cConceptoImpresion) = "VALOR NO ENCONTRADO" Then
'      oDctoWord.Bookmarks.Item("SIN_APODERADO_TRES").Range.Text = ""
'   Else
'      oDctoWord.Bookmarks.Item("Nom_Apod_Cliente_2").Range.Text = Func_Busca_Valores_Contrato("NMC012", cConceptoImpresion)
'      oDctoWord.Bookmarks.Item("Nom_Apod_Cliente_22").Range.Text = Func_Busca_Valores_Contrato("NMC012", cConceptoImpresion)
'      oDctoWord.Bookmarks.Item("Nom_Apod_Cliente_23").Range.Text = Func_Busca_Valores_Contrato("NMC012", cConceptoImpresion)
'      oDctoWord.Bookmarks.Item("Nom_Apod_Cliente_24").Range.Text = Func_Busca_Valores_Contrato("NMC012", cConceptoImpresion)
'      oDctoWord.Bookmarks.Item("Nom_Apod_Cliente_25").Range.Text = Func_Busca_Valores_Contrato("NMC012", cConceptoImpresion)
'   End If
   
   oDctoWord.Bookmarks.Item("CI_Apod_Cliente_2").Range.Text = Func_Busca_Valores_Contrato("NMC013", cConceptoImpresion)
   oDctoWord.Bookmarks.Item("CI_Apod_Cliente_22").Range.Text = Func_Busca_Valores_Contrato("NMC013", cConceptoImpresion)
   oDctoWord.Bookmarks.Item("CI_Apod_Cliente_23").Range.Text = Func_Busca_Valores_Contrato("NMC013", cConceptoImpresion)
   oDctoWord.Bookmarks.Item("CI_Apod_Cliente_24").Range.Text = Func_Busca_Valores_Contrato("NMC013", cConceptoImpresion)
   oDctoWord.Bookmarks.Item("CI_Apod_Cliente_25").Range.Text = Func_Busca_Valores_Contrato("NMC013", cConceptoImpresion)

   oDctoWord.Bookmarks.Item("Direccion_Cliente").Range.Text = Func_Busca_Valores_Contrato("NMC014", cConceptoImpresion)
   oDctoWord.Bookmarks.Item("Direccion_Cliente2").Range.Text = Func_Busca_Valores_Contrato("NMC014", cConceptoImpresion)
   oDctoWord.Bookmarks.Item("Direccion_Cliente3").Range.Text = Func_Busca_Valores_Contrato("NMC014", cConceptoImpresion)
   oDctoWord.Bookmarks.Item("Direccion_Cliente4").Range.Text = Func_Busca_Valores_Contrato("NMC014", cConceptoImpresion)
   oDctoWord.Bookmarks.Item("Direccion_Cliente5").Range.Text = Func_Busca_Valores_Contrato("NMC014", cConceptoImpresion)
   
   oDctoWord.Bookmarks.Item("Comuna_Cliente").Range.Text = Func_Busca_Valores_Contrato("NMC015", cConceptoImpresion)
   oDctoWord.Bookmarks.Item("Comuna_Cliente2").Range.Text = Func_Busca_Valores_Contrato("NMC015", cConceptoImpresion)
   oDctoWord.Bookmarks.Item("Comuna_Cliente3").Range.Text = Func_Busca_Valores_Contrato("NMC015", cConceptoImpresion)
   oDctoWord.Bookmarks.Item("Comuna_Cliente4").Range.Text = Func_Busca_Valores_Contrato("NMC015", cConceptoImpresion)
   oDctoWord.Bookmarks.Item("Comuna_Cliente5").Range.Text = Func_Busca_Valores_Contrato("NMC015", cConceptoImpresion)

   oDctoWord.Bookmarks.Item("Ciudad_Cliente").Range.Text = Func_Busca_Valores_Contrato("NMC016", cConceptoImpresion)
   oDctoWord.Bookmarks.Item("Ciudad_Cliente2").Range.Text = Func_Busca_Valores_Contrato("NMC016", cConceptoImpresion)
   oDctoWord.Bookmarks.Item("Ciudad_Cliente3").Range.Text = Func_Busca_Valores_Contrato("NMC016", cConceptoImpresion)
   oDctoWord.Bookmarks.Item("Ciudad_Cliente4").Range.Text = Func_Busca_Valores_Contrato("NMC016", cConceptoImpresion)
   oDctoWord.Bookmarks.Item("Ciudad_Cliente5").Range.Text = Func_Busca_Valores_Contrato("NMC016", cConceptoImpresion)
   
   
   If sTipoSwap = "TASA" Or sTipoSwap = "CAMARA" Then
       sTipoContrato = "SWAP DE TASA DE INTERES"
   ElseIf sTipoSwap = "MONEDA" Then
      sTipoContrato = "PERMUTA FINANCIERA(CROSS CURRENCY SWAP) SOBRE UNIDADES DE INTERES Y DIVISAS"
   End If
   
   oDctoWord.Bookmarks.Item("Tipo_Contrato_Swap").Range.Text = sTipoContrato
   oDctoWord.Bookmarks.Item("Tipo_Contrato_Swap2").Range.Text = sTipoContrato
   oDctoWord.Bookmarks.Item("Tipo_Contrato_Swap3").Range.Text = sTipoContrato
   oDctoWord.Bookmarks.Item("Tipo_Contrato_Swap4").Range.Text = sTipoContrato
   oDctoWord.Bookmarks.Item("Tipo_Contrato_Swap5").Range.Text = sTipoContrato
   
   oDctoWord.Bookmarks.Item("Numero_Operacion").Range.Text = nNumoper
   oDctoWord.Bookmarks.Item("Numero_Operacion2").Range.Text = nNumoper
   oDctoWord.Bookmarks.Item("Numero_Operacion3").Range.Text = nNumoper
   oDctoWord.Bookmarks.Item("Numero_Operacion4").Range.Text = nNumoper
   oDctoWord.Bookmarks.Item("Numero_Operacion5").Range.Text = nNumoper
   
   oDctoWord.Bookmarks.Item("Notaria_Cliente").Range.Text = Func_Busca_Valores_Contrato("NMC033", cConceptoImpresion)
   oDctoWord.Bookmarks.Item("Notaria_Cliente2").Range.Text = Func_Busca_Valores_Contrato("NMC033", cConceptoImpresion)
   oDctoWord.Bookmarks.Item("Notaria_Cliente3").Range.Text = Func_Busca_Valores_Contrato("NMC033", cConceptoImpresion)
   oDctoWord.Bookmarks.Item("Notaria_Cliente4").Range.Text = Func_Busca_Valores_Contrato("NMC033", cConceptoImpresion)
   oDctoWord.Bookmarks.Item("Notaria_Cliente5").Range.Text = Func_Busca_Valores_Contrato("NMC033", cConceptoImpresion)
   
   oDctoWord.Bookmarks.Item("Fecha_Escritura").Range.Text = Func_Busca_Valores_Contrato("NMC032", cConceptoImpresion)
   oDctoWord.Bookmarks.Item("Fecha_Escritura2").Range.Text = Func_Busca_Valores_Contrato("NMC032", cConceptoImpresion)
   oDctoWord.Bookmarks.Item("Fecha_Escritura3").Range.Text = Func_Busca_Valores_Contrato("NMC032", cConceptoImpresion)
   oDctoWord.Bookmarks.Item("Fecha_Escritura4").Range.Text = Func_Busca_Valores_Contrato("NMC032", cConceptoImpresion)
   oDctoWord.Bookmarks.Item("Fecha_Escritura5").Range.Text = Func_Busca_Valores_Contrato("NMC032", cConceptoImpresion)
   
   oDctoWord.Bookmarks.Item("Monto_Operacion").Range.Text = Monto_Operacion
   oDctoWord.Bookmarks.Item("Monto_Operacion2").Range.Text = Monto_Operacion
   oDctoWord.Bookmarks.Item("Monto_Operacion3").Range.Text = Monto_Operacion
   oDctoWord.Bookmarks.Item("Monto_Operacion4").Range.Text = Monto_Operacion
   oDctoWord.Bookmarks.Item("Monto_Operacion5").Range.Text = Monto_Operacion
   
   oDctoWord.Bookmarks.Item("FechaNuevoCCG").Range.Text = Func_Busca_Valores_Contrato("NMC018", cConceptoImpresion)
   oDctoWord.Bookmarks.Item("FechaNuevoCCG2").Range.Text = Func_Busca_Valores_Contrato("NMC018", cConceptoImpresion)
   oDctoWord.Bookmarks.Item("FechaNuevoCCG3").Range.Text = Func_Busca_Valores_Contrato("NMC018", cConceptoImpresion)
   oDctoWord.Bookmarks.Item("FechaNuevoCCG4").Range.Text = Func_Busca_Valores_Contrato("NMC018", cConceptoImpresion)
   oDctoWord.Bookmarks.Item("FechaNuevoCCG5").Range.Text = Func_Busca_Valores_Contrato("NMC018", cConceptoImpresion)
   
   
   'Esto es solo para el contrato de condiciones generales.
   
   If ArregloDatosBasicos(ColsDatosBasicos.TipoCli) < 4 Then
      sTexto = "las partes deberán acordar la parte que"
   Else
      sTexto = "el Banco"
   End If
   
   oDctoWord.Bookmarks.Item("Banco_Otro1").Range.Text = sTexto
   
   If ArregloDatosBasicos(ColsDatosBasicos.TipoCli) < 4 Then
      sTexto = "La parte que asuma dicho deber"
   Else
      sTexto = "El Banco"
   End If
   
   oDctoWord.Bookmarks.Item("Banco_Otro2").Range.Text = sTexto
   '*******************************************************
  
   Func_Completa_Campos_Fijos = True

   Exit Function
   
Control_Error:
   If err.Number = 5941 Then
      Resume Next
   Else
      Exit Function
   End If

End Function

Public Function FIRMAS(Doc As Word.Document, MARCADOR As String, rut_apoderado As String, nombre_apoderado As String, direccion As String, telefono As String, fax As String, rut_cliente As String, nombre_cliente As String)
   On Error Resume Next
   Static iColumna    As Integer
   Static oMarcador   As String
   Static cPP         As String
   Static cNombre     As String
   Static cCNIN       As String
   Static cDireccion  As String
   Static oDireccion  As String
   Static cTelefono   As String
   Static cFax        As String
   Static cRut        As String
   Dim cCadena        As String
   
   If iColumna = 0 Then
      iColumna = 1
      
      cPP = "": cNombre = "": cCNIN = "": cDireccion = "": cTelefono = "": cFax = "": cRut = "": oMarcador = ""
      
      oMarcador = MARCADOR
      cPP = "pp.:" & nombre_cliente
      cNombre = "Nombre: " & Trim(nombre_apoderado)
      cCNIN = "C.N.I.N°: " & IIf(rut_apoderado = "0-", "", rut_apoderado)
      cDireccion = "Domicilio:" & Mid(direccion, 1, 28)
      oDireccion = "          " & Mid(direccion, 29, 28)
      cTelefono = "Teléfono: " & telefono
      cFax = "Fax:      " & fax
      cRut = "RUT:      " & rut_cliente
   Else
      iColumna = 0
      cCadena = ""
      cCadena = cCadena & cPP & String(40 - Len(cPP), " ") & " pp.:" & nombre_cliente & Chr(13)
      cCadena = cCadena & cNombre & String(40 - Len(cNombre), " ") & " Nombre: " & Trim(nombre_apoderado) & Chr(13)
      cCadena = cCadena & cCNIN & String(40 - Len(cCNIN), " ") & " C.N.I.N°: " & IIf(rut_apoderado = "0-", "", rut_apoderado) & Chr(13)
      cCadena = cCadena & cDireccion & String(40 - Len(cDireccion), " ") & " Domicilio:" & Mid(direccion, 1, 28) & Chr(13)
      
      If Len(Trim(oDireccion)) > 0 Then
         cCadena = cCadena & oDireccion & String(40 - Len(oDireccion), " ") & "          " & Mid(direccion, 29, 28) & Chr(13)
      End If
      
      cCadena = cCadena & cTelefono & String(40 - Len(cTelefono), " ") & " Teléfono: " & telefono & Chr(13)
      cCadena = cCadena & cFax & String(40 - Len(cFax), " ") & " Fax:      " & fax & Chr(13)
      cCadena = cCadena & cRut & String(40 - Len(cRut), " ") & " RUT:      " & rut_cliente & Chr(13)
      
      Doc.Bookmarks(oMarcador).Select
      Doc.Application.Selection.Font.Name = "Courier New"
      Doc.Application.Selection.Text = ""
      Doc.Application.Selection.Text = cCadena
   End If
    
'    With DOC
'         .Bookmarks(MARCADOR).Select
'         .Application.Selection.Text = "pp.                " & nombre_cliente & Chr(13) & _
'         "Nombre:        " & Trim(nombre_apoderado) & Chr(13) & _
'         "C.N.I.N°:      " & rut_apoderado & Chr(13) & _
'         "Domicilio:     " & direccion & Chr(13) & _
'         "Teléfono:      " & telefono & Chr(13) & _
'         "Fax:              " & fax & Chr(13) & _
'         "RUT:            " & rut_cliente & Chr(13) & Chr(13)
'    End With
On Error GoTo 0

End Function


Function Func_Busca_Parametros_Bco() As Boolean

   Func_Busca_Parametros_Bco = False

   If Bac_Sql_Execute("SP_LEERDATOSGENERALES") Then
      Do While Bac_SQL_Fetch(Datos())
         ArregloParametrosBanco(ColsArrayParametrosBanco.CodigoEntidad) = Datos(1)
         ArregloParametrosBanco(ColsArrayParametrosBanco.CodigoSistema) = Datos(2)
         ArregloParametrosBanco(ColsArrayParametrosBanco.NombreEntidad) = Datos(3)
         ArregloParametrosBanco(ColsArrayParametrosBanco.RutEntidad) = Datos(4)
         ArregloParametrosBanco(ColsArrayParametrosBanco.DireccionEntidad) = Datos(5)
         ArregloParametrosBanco(ColsArrayParametrosBanco.ComunaEntidad) = Datos(6)
         ArregloParametrosBanco(ColsArrayParametrosBanco.CiudadEntidad) = Datos(7)
         ArregloParametrosBanco(ColsArrayParametrosBanco.TelefonoEntidad) = Datos(8)
         ArregloParametrosBanco(ColsArrayParametrosBanco.FaxEntidad) = Datos(9)
         ArregloParametrosBanco(ColsArrayParametrosBanco.FechaAnt) = Datos(10)
         ArregloParametrosBanco(ColsArrayParametrosBanco.FechaProceso) = Datos(11)
         ArregloParametrosBanco(ColsArrayParametrosBanco.FechaProxima) = Datos(12)
         ArregloParametrosBanco(ColsArrayParametrosBanco.NumeroOperacion) = Datos(13)
         ArregloParametrosBanco(ColsArrayParametrosBanco.RutBancoCentral) = Datos(14)
         ArregloParametrosBanco(ColsArrayParametrosBanco.EstadoInicioDia) = Datos(15)
         ArregloParametrosBanco(ColsArrayParametrosBanco.libor) = Datos(16)
         ArregloParametrosBanco(ColsArrayParametrosBanco.Paridad) = Datos(17)
         ArregloParametrosBanco(ColsArrayParametrosBanco.tasamtm) = Datos(18)
         ArregloParametrosBanco(ColsArrayParametrosBanco.tasas) = Datos(19)
         ArregloParametrosBanco(ColsArrayParametrosBanco.EstadoFinDia) = Datos(20)
         ArregloParametrosBanco(ColsArrayParametrosBanco.EstadoCierreMesa) = Datos(21)
         ArregloParametrosBanco(ColsArrayParametrosBanco.CodigoRutEntidad) = Datos(22)
         
      Loop
   Else
      Screen.MousePointer = vbDefault
      MsgBox "Ha ocurrido un error al obtener los datos basicos del banco", vbCritical + vbOKOnly
      Exit Function
   End If
   
   Func_Busca_Parametros_Bco = True
   
End Function

Sub Proc_Graba_Contrato_Emitido(nRutCliente As Long, nCodCliente As Integer, nNumoper As Long, MatrizSeleccionados(), oArbol As MSComctlLib.TreeView, cConcepto As String)

   Dim nContador As Integer
   Dim nRutApoBco1   As Long
   Dim nRutApoBco2   As Long
   Dim nRutApoCli1   As Long
   Dim nRutApoCli2   As Long
   
   nRutApoBco1 = Func_Quita_Formato_Rut(ArregloDatosBasicos(ColsDatosBasicos.RutApoderadoBco1))
   nRutApoBco2 = Func_Quita_Formato_Rut(ArregloDatosBasicos(ColsDatosBasicos.RutApoderadoBco2))
   nRutApoCli1 = Func_Quita_Formato_Rut(ArregloDatosBasicos(ColsDatosBasicos.RutApoderadoCli1))
   nRutApoCli2 = Func_Quita_Formato_Rut(ArregloDatosBasicos(ColsDatosBasicos.RutApoderadoCli2))

   With oArbol
      For nContador = 1 To .Nodes.Count
         If .Nodes.Item(nContador).Checked = True Then
            Envia = Array()
            AddParam Envia, nRutCliente
            AddParam Envia, nCodCliente
            AddParam Envia, nNumoper
            AddParam Envia, Trim(Mid(.Nodes.Item(nContador).Key, 11, 10))  'codigo dcto fisico
            AddParam Envia, Trim(Mid(.Nodes.Item(nContador).Key, 21, 10))  'codigo dcto
            AddParam Envia, nRutApoBco1
            AddParam Envia, nRutApoBco2
            AddParam Envia, nRutApoCli1
            AddParam Envia, nRutApoCli2
            AddParam Envia, nCuentaAvales
            AddParam Envia, cConcepto
                   
            If Not Bac_Sql_Execute("BACSWAPSUDA..SP_ACT_CONTRATO_IMPRESO", Envia) Then
               Screen.MousePointer = vbDefault
               MsgBox "Ha ocurrido un problema al intentar guardar el contrato emitido", vbCritical + vbOKOnly
               Exit Sub
            End If
         End If
      Next nContador
      
   End With

End Sub

Function Func_Quita_Formato_Rut(ByVal cRut As String) As Long

     cRut = Mid(cRut, 1, Len(cRut) - 2)
     cRut = Replace(cRut, ",", "")
     Func_Quita_Formato_Rut = CLng(Replace(cRut, ".", ""))

End Function



Sub Proc_Inserta_Pie_Avales(cConceptoImpresion As String, nCuentaAvales As Integer, oDctoWord As Word.Document, bLleva_Avales_Pie As Boolean)

   On Error GoTo Control_Error:

   Dim nContador  As Integer
   Dim ncontador2 As Long
   Dim cCadena    As String
   Dim cNombreCiudad As String
   Dim cNombreComuna As String

   oDctoWord.Bookmarks("GrillaPie").Select
   ''''oDctoWord.Application.Selection.Font = "tahoma"
      
   '****************************************** APODERADOS BANCO ******************************************
   
   cCadena = "pp." & Chr(9) & ": " & ArregloParametrosBanco(ColsArrayParametrosBanco.NombreEntidad) & Chr(10)
   cCadena = cCadena & "Nombre" & Chr(9) & ": " & ArregloDatosBasicos(ColsDatosBasicos.ApoderadoBco1) & Chr(10)
   cCadena = cCadena & "C.N.I.N°" & Chr(9) & ": " & Format$(Mid(ArregloDatosBasicos(ColsDatosBasicos.RutApoderadoBco1), 1, Len(ArregloDatosBasicos(ColsDatosBasicos.RutApoderadoBco1)) - 2), "#,##0") & Right(ArregloDatosBasicos(ColsDatosBasicos.RutApoderadoBco1), 2) & Chr(10)
   cCadena = cCadena & "Domicilio" & Chr(9) & ": " & ArregloParametrosBanco(ColsArrayParametrosBanco.DireccionEntidad) & Chr(10)
   cCadena = cCadena & "Teléfono" & Chr(9) & ": " & ArregloParametrosBanco(ColsArrayParametrosBanco.TelefonoEntidad) & Chr(10)
   cCadena = cCadena & "Fax" & Chr(9) & ": " & ArregloParametrosBanco(ColsArrayParametrosBanco.FaxEntidad) & Chr(10)
   cCadena = cCadena & "RUT" & Chr(9) & ": " & Format$(ArregloParametrosBanco(ColsArrayParametrosBanco.RutEntidad), "#,##0") & "-" & BacCheckRut(Str(ArregloParametrosBanco(ColsArrayParametrosBanco.RutEntidad))) & Chr(10)
   
   oDctoWord.Application.Selection.Text = cCadena

   If ArregloDatosBasicos(ColsDatosBasicos.ApoderadoBco1) <> ArregloDatosBasicos(ColsDatosBasicos.ApoderadoBco2) Then
   
      oDctoWord.Application.Selection.MoveRight Unit:=wdCell
      oDctoWord.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    
      cCadena = "pp." & Chr(9) & ": " & ArregloParametrosBanco(ColsArrayParametrosBanco.NombreEntidad) & Chr(10)
      cCadena = cCadena & "Nombre" & Chr(9) & ": " & ArregloDatosBasicos(ColsDatosBasicos.ApoderadoBco2) & Chr(10)
      cCadena = cCadena & "C.N.I.N°" & Chr(9) & ": " & Format(Mid(ArregloDatosBasicos(ColsDatosBasicos.RutApoderadoBco2), 1, Len(ArregloDatosBasicos(ColsDatosBasicos.RutApoderadoBco2)) - 2), "#,##0") & Right(ArregloDatosBasicos(ColsDatosBasicos.RutApoderadoBco2), 2) & Chr(10)
      cCadena = cCadena & "Domicilio" & Chr(9) & ": " & ArregloParametrosBanco(ColsArrayParametrosBanco.DireccionEntidad) & Chr(10)
      cCadena = cCadena & "Teléfono" & Chr(9) & ": " & ArregloParametrosBanco(ColsArrayParametrosBanco.TelefonoEntidad) & Chr(10)
      cCadena = cCadena & "Fax" & Chr(9) & ": " & ArregloParametrosBanco(ColsArrayParametrosBanco.FaxEntidad) & Chr(10)
      cCadena = cCadena & "RUT" & Chr(9) & ": " & Format$(ArregloParametrosBanco(ColsArrayParametrosBanco.RutEntidad), "#,##0") & "-" & BacCheckRut(Str(ArregloParametrosBanco(ColsArrayParametrosBanco.RutEntidad))) & Chr(10)
      
      oDctoWord.Application.Selection.Text = cCadena
   End If
     
   '****************************************** APODERADOS CLIENTE ******************************************
     
   oDctoWord.Application.Selection.MoveRight Unit:=wdCell
   oDctoWord.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
     
   cCadena = "pp." & Chr(9) & ": " & ArregloDatosBasicos(ColsDatosBasicos.NombreCli) & Chr(10)
   cCadena = cCadena & "Nombre" & Chr(9) & ": " & ArregloDatosBasicos(ColsDatosBasicos.ApoderadoCli1) & Chr(10)
   cCadena = cCadena & "C.N.I.N°" & Chr(9) & ": " & Format(Mid(ArregloDatosBasicos(ColsDatosBasicos.RutApoderadoCli1), 1, Len(ArregloDatosBasicos(ColsDatosBasicos.RutApoderadoCli1)) - 2), "#,##0") & Right(ArregloDatosBasicos(ColsDatosBasicos.RutApoderadoCli1), 2) & Chr(10)
   cCadena = cCadena & "Domicilio" & Chr(9) & ": " & ArregloDatosBasicos(ColsDatosBasicos.DireccionCli) & ", " & ArregloDatosBasicos(ColsDatosBasicos.CiudadCli) & Chr(10)
   cCadena = cCadena & "Teléfono" & Chr(9) & ": " & ArregloDatosBasicos(ColsDatosBasicos.FonoCli) & Chr(10)
   cCadena = cCadena & "Fax" & Chr(9) & ": " & ArregloDatosBasicos(ColsDatosBasicos.FaxCli) & Chr(10)
   cCadena = cCadena & "RUT" & Chr(9) & ": " & Format$(ArregloDatosBasicos(ColsDatosBasicos.RutCli), "#,##0") & "-" & BacCheckRut(Str(ArregloDatosBasicos(ColsDatosBasicos.RutCli))) & Chr(10)
   
   oDctoWord.Application.Selection.Text = cCadena

   If (ArregloDatosBasicos(ColsDatosBasicos.ApoderadoCli1) <> ArregloDatosBasicos(ColsDatosBasicos.ApoderadoCli2)) And Trim(ArregloDatosBasicos(ColsDatosBasicos.ApoderadoCli2)) <> "" Then
      oDctoWord.Application.Selection.MoveRight Unit:=wdCell
      oDctoWord.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    
      cCadena = "pp." & Chr(9) & ": " & ArregloDatosBasicos(ColsDatosBasicos.NombreCli) & Chr(10)
      cCadena = cCadena & "Nombre" & Chr(9) & ": " & ArregloDatosBasicos(ColsDatosBasicos.ApoderadoCli2) & Chr(10)
      cCadena = cCadena & "C.N.I.N°" & Chr(9) & ": " & Format$(Mid(ArregloDatosBasicos(ColsDatosBasicos.RutApoderadoCli2), 1, Len(ArregloDatosBasicos(ColsDatosBasicos.RutApoderadoCli2)) - 2), "#,##0") & Right(ArregloDatosBasicos(ColsDatosBasicos.RutApoderadoCli2), 2) & Chr(10)
      cCadena = cCadena & "Domicilio" & Chr(9) & ": " & ArregloDatosBasicos(ColsDatosBasicos.DireccionCli) & ", " & ArregloDatosBasicos(ColsDatosBasicos.CiudadCli) & Chr(10)
      cCadena = cCadena & "Teléfono" & Chr(9) & ": " & ArregloDatosBasicos(ColsDatosBasicos.FonoCli) & Chr(10)
      cCadena = cCadena & "Fax" & Chr(9) & ": " & ArregloDatosBasicos(ColsDatosBasicos.FaxCli) & Chr(10)
      cCadena = cCadena & "RUT" & Chr(9) & ": " & Format(ArregloDatosBasicos(ColsDatosBasicos.RutCli), "#,##0") & "-" & BacCheckRut(Str(ArregloDatosBasicos(ColsDatosBasicos.RutCli))) & Chr(10)
      
      oDctoWord.Application.Selection.Text = cCadena
   End If
  
   If bLleva_Avales_Pie = True Then
   ''''If nCuentaAvales > 0 Then
      For ncontador2 = 1 To nCuentaAvales
      
         oDctoWord.Application.Selection.MoveRight Unit:=wdCell
         oDctoWord.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
      
         If MatrizAvales(17, ncontador2) = MatrizEstadoCivil(EstadoCivil.Soltero, 1) Or MatrizAvales(17, ncontador2) = MatrizEstadoCivil(EstadoCivil.CasadoSB, 1) Then
''''         If MatrizAvales(17, ncontador2) = "SOLTERO" Or MatrizAvales(17, ncontador2) = "CASADO(A) C/SEPARACION DE BIENES" Then
                        
            cNombreCiudad = "-999"
            cNombreComuna = ""
      
            Call Proc_Busca_Ciudad_Comuna(Func_Busca_Valores_Avales(ncontador2, "NMC023", MatrizAvales()), Func_Busca_Valores_Avales(ncontador2, "NMC022", MatrizAvales()), cNombreCiudad, cNombreComuna)
         
            cCadena = "FIADOR, CODEUDOR SOLIDARIO Y AVALISTA" & Chr(10)
            cCadena = cCadena & "Nombre" & Chr(9) & ": " & Func_Busca_Valores_Avales(ncontador2, "NMC018", MatrizAvales()) & Chr(10)
            cCadena = cCadena & "C.N.I.N°" & Chr(9) & ": " & Func_Busca_Valores_Avales(ncontador2, "NMC017", MatrizAvales()) & Chr(10)
            cCadena = cCadena & "Domicilio" & Chr(9) & ": " & Func_Busca_Valores_Avales(ncontador2, "NMC021", MatrizAvales()) & ", " & cNombreComuna & Chr(10)
            cCadena = cCadena & "Teléfono" & Chr(9) & ": " & Chr(10)
            cCadena = cCadena & "Fax" & Chr(9) & ": " & Chr(10)
            cCadena = cCadena & "RUT" & Chr(9) & ": " & Func_Busca_Valores_Avales(ncontador2, "NMC017", MatrizAvales()) & Chr(10)
            
            oDctoWord.Application.Selection.Text = cCadena
         
''''         ElseIf MatrizAvales(17, ncontador2) = "CASADO(A) EN SOCIEDAD CONYUGAL" _
''''            Or MatrizAvales(17, ncontador2) = "CASADO(A) CON PART. EN LOS GANANCIALES" Then
         ElseIf MatrizAvales(17, ncontador2) = MatrizEstadoCivil(EstadoCivil.CasadoSC, 1) _
            Or MatrizAvales(17, ncontador2) = MatrizEstadoCivil(EstadoCivil.CasadoPG, 1) Then
            
            
            cNombreCiudad = "-999"
            cNombreComuna = ""
      
            Call Proc_Busca_Ciudad_Comuna(Func_Busca_Valores_Avales(ncontador2, "NMC023", MatrizAvales()), Func_Busca_Valores_Avales(ncontador2, "NMC022", MatrizAvales()), cNombreCiudad, cNombreComuna)
         
            cCadena = "FIADOR, CODEUDOR SOLIDARIO Y AVALISTA" & Chr(10)
            cCadena = cCadena & "Nombre" & Chr(9) & ": " & Func_Busca_Valores_Avales(ncontador2, "NMC018", MatrizAvales()) & Chr(10)
            cCadena = cCadena & "C.N.I.N°" & Chr(9) & ": " & Func_Busca_Valores_Avales(ncontador2, "NMC017", MatrizAvales()) & Chr(10)
            cCadena = cCadena & "Domicilio" & Chr(9) & ": " & Func_Busca_Valores_Avales(ncontador2, "NMC021", MatrizAvales()) & ", " & cNombreComuna & Chr(10)
            cCadena = cCadena & "Teléfono" & Chr(9) & ": " & Chr(10)
            cCadena = cCadena & "Fax" & Chr(9) & ": " & Chr(10)
            cCadena = cCadena & "RUT" & Chr(9) & ": " & Func_Busca_Valores_Avales(ncontador2, "NMC017", MatrizAvales()) & Chr(10)
            
            oDctoWord.Application.Selection.Text = cCadena
         
            oDctoWord.Application.Selection.MoveRight Unit:=wdCell
            oDctoWord.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
            
            cNombreCiudad = "-999"
            cNombreComuna = ""
      
            Call Proc_Busca_Ciudad_Comuna(Func_Busca_Valores_Avales(ncontador2, "NMC023", MatrizAvales()), Func_Busca_Valores_Avales(ncontador2, "NMC022", MatrizAvales()), cNombreCiudad, cNombreComuna)
            
            cCadena = Chr(10)
            cCadena = cCadena & "Nombre" & Chr(9) & ": " & Func_Busca_Valores_Avales(ncontador2, "NMC029", MatrizAvales()) & Chr(10)
            cCadena = cCadena & "C.N.I.N°" & Chr(9) & ": " & Func_Busca_Valores_Avales(ncontador2, "NMC031", MatrizAvales()) & Chr(10)
            cCadena = cCadena & "Domicilio" & Chr(9) & ": " & Func_Busca_Valores_Avales(ncontador2, "NMC021", MatrizAvales()) & ", " & cNombreComuna & Chr(10)
            cCadena = cCadena & "Teléfono" & Chr(9) & ": " & Chr(10)
            cCadena = cCadena & "Fax" & Chr(9) & ": " & Chr(10)
            cCadena = cCadena & "RUT" & Chr(9) & ": " & Func_Busca_Valores_Avales(ncontador2, "NMC031", MatrizAvales()) & Chr(10)
            
            oDctoWord.Application.Selection.Text = cCadena
         
         ElseIf MatrizAvales(17, ncontador2) = MatrizEstadoCivil(EstadoCivil.NoAplica, 1) Then 'EMPRESAS Y OTROS
''''            oDctoWord.Application.Selection.MoveRight Unit:=wdCell
''''            oDctoWord.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
                     
            cNombreCiudad = "-999"
            cNombreComuna = ""
      
            Call Proc_Busca_Ciudad_Comuna(Func_Busca_Valores_Avales(ncontador2, "NMC023", MatrizAvales()), Func_Busca_Valores_Avales(ncontador2, "NMC022", MatrizAvales()), cNombreCiudad, cNombreComuna)
            
            cCadena = "FIADOR, CODEUDOR SOLIDARIO Y AVALISTA" & Chr(10)
            cCadena = cCadena & "pp." & Chr(9) & ": " & Func_Busca_Valores_Avales(ncontador2, "NMC018", MatrizAvales()) & Chr(10)
            cCadena = cCadena & "Nombre" & Chr(9) & ": " & Func_Busca_Valores_Avales(ncontador2, "NMC025", MatrizAvales()) & Chr(10)
            cCadena = cCadena & "C.N.I.N°" & Chr(9) & ": " & Func_Busca_Valores_Avales(ncontador2, "NMC026", MatrizAvales()) & Chr(10)
            cCadena = cCadena & "Domicilio" & Chr(9) & ": " & Func_Busca_Valores_Avales(ncontador2, "NMC021", MatrizAvales()) & ", " & cNombreComuna & Chr(10)
            cCadena = cCadena & "Teléfono" & Chr(9) & ": " & Chr(10)
            cCadena = cCadena & "Fax" & Chr(9) & ": " & Chr(10)
            cCadena = cCadena & "RUT" & Chr(9) & ": " & Func_Busca_Valores_Avales(ncontador2, "NMC017", MatrizAvales()) & Chr(10)
            
            oDctoWord.Application.Selection.Text = cCadena
            
            If Func_Busca_Valores_Avales(ncontador2, "NMC027", MatrizAvales()) <> "" _
               And Func_Busca_Valores_Avales(ncontador2, "NMC025", MatrizAvales()) <> Func_Busca_Valores_Avales(ncontador2, "NMC027", MatrizAvales()) Then  'Persona Natural (nombre apoderado aval 2)
               
               oDctoWord.Application.Selection.MoveRight Unit:=wdCell
               oDctoWord.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
               
               cNombreCiudad = "-999"
               cNombreComuna = ""
      
               Call Proc_Busca_Ciudad_Comuna(Func_Busca_Valores_Avales(ncontador2, "NMC023", MatrizAvales()), Func_Busca_Valores_Avales(ncontador2, "NMC022", MatrizAvales()), cNombreCiudad, cNombreComuna)
              
               cCadena = "FIADOR, CODEUDOR SOLIDARIO Y AVALISTA" & Chr(10)
               cCadena = cCadena & "pp." & Chr(9) & ": " & Func_Busca_Valores_Avales(ncontador2, "NMC018", MatrizAvales()) & Chr(10)
               cCadena = cCadena & "Nombre" & Chr(9) & ": " & Func_Busca_Valores_Avales(ncontador2, "NMC027", MatrizAvales()) & Chr(10)
               cCadena = cCadena & "C.N.I.N°" & Chr(9) & ": " & Func_Busca_Valores_Avales(ncontador2, "NMC028", MatrizAvales()) & Chr(10)
               cCadena = cCadena & "Domicilio" & Chr(9) & ": " & Func_Busca_Valores_Avales(ncontador2, "NMC021", MatrizAvales()) & ", " & cNombreComuna & Chr(10)
               cCadena = cCadena & "Teléfono" & Chr(9) & ": " & Chr(10)
               cCadena = cCadena & "Fax" & Chr(9) & ": " & Chr(10)
               cCadena = cCadena & "RUT" & Chr(9) & ": " & Func_Busca_Valores_Avales(ncontador2, "NMC017", MatrizAvales()) & Chr(10)
               
               oDctoWord.Application.Selection.Text = cCadena
            End If
         End If
         nContador = nContador + 1
         
      Next ncontador2
   End If
   
   Exit Sub

Control_Error:
   If err.Number = 5941 Then
      Exit Sub
   Else
      Screen.MousePointer = vbDefault
      MsgBox err.Description, vbCritical + vbOKOnly
      Exit Sub
   End If
   
End Sub

Function ProtocoloContrato() As Boolean
On Error GoTo Control

ProtocoloContrato = False


With BACSwap.Crystal
    'envia informe a impresora
    .Destination = crptToPrinter
    .ReportFileName = gsRPT_Path & "protocolo.rpt"
    .Action = 1 'Envio
End With

ProtocoloContrato = True

Exit Function

Control:
Screen.MousePointer = 0
MsgBox Error(err), vbExclamation
Exit Function
End Function

Function ProtocoloContratoANt() As Boolean

On Error GoTo Control:

Dim Lin(30)
Dim nPosicion As Integer
Dim nFila     As Integer
Dim nTab      As Integer
Dim aString()
Dim nCont     As Integer
Dim sTexto    As String
Dim nCont2    As Integer
Dim cCaracter As String
Dim FechaHoy As String
Dim i As Integer

ProtocoloContratoANt = False
Call FuentesImpresora
Lin(0) = " "
Lin(1) = "PROTOCOLO DE DEFINICIONES UTILIZADAS EN CONTRATO DE FORWARD Y/O SWAP DE MONEDAS"
Lin(2) = "EN EL MERCADO LOCAL"

Lin(3) = "El presente documento contiene las definiciones de los términos empleados en el  Contrato de Forward y/o Swap de "
Lin(3) = Lin(3) & "de Monedas en el Mercado Local, en adelante 'el contrato'. "

Lin(4) = "^1.       Vendedor:^ En el caso de transacciones forward o swap de dólares de los  Estados  Unidos  de  América  ( en "
Lin(4) = Lin(4) & "adelante, EEUU )  versus  moneda  nacional,  ya sea  pesos moneda nacional o Unidades de Fomento pagaderas en pesos "
Lin(4) = Lin(4) & "moneda nacional, el vendedor es la parte que se obliga a vender o entregar los dólares de los EEUU.   En el caso de "
Lin(4) = Lin(4) & "transacciones forward o swap de dólares de los  EEUU  versus una moneda extranjera distinta del dólar  de los EEUU, "
Lin(4) = Lin(4) & "el vendedor es la parte que se obliga a vender o entregar la moneda extranjera distinta del dólar de los EEUU. "

Lin(5) = "^2.       Comprador:^ En el caso de transacciones forward o swap de dólares de los EEUU versus moneda nacional, ya sea "
Lin(5) = Lin(5) & "pesos moneda nacional  o  Unidades de Fomento pagaderas  en pesos moneda nacional,  el comprador es la parte que se "
Lin(5) = Lin(5) & "obliga a comprar o recibir los dólares de los EEUU.    En el caso de transacciones forward o swap de dólares de los "
Lin(5) = Lin(5) & "EEUU versus una moneda extranjera distinta de dólar de los EEUU, el comprador es la parte que se obliga  a  comprar "
Lin(5) = Lin(5) & "o recibir la moneda extranjera distinta del dólar de los EEUU. "

Lin(6) = "^3.       Tipo de Transacción:^ Los tipos de transacción amparados por el contrato son los Forward de Monedas  y  los "
Lin(6) = Lin(6) & "Swap de Monedas, según lo definido en el N° 2 del Capitulo VII  del  Compendio de Normas de  Cambios Internacionales "
Lin(6) = Lin(6) & "del Banco Central de Chile, en adelante, el Capitulo VII. "

Lin(7) = "^4.       Fecha de Cierre:^ Es la fecha en que las partes convienen y cierran a firme una transacción  de  forward  o "
Lin(7) = Lin(7) & "swap, fijando las condiciones de la misma. "

Lin(8) = "^5.       Hora de Cierre:^ Es la hora que las partes convienen los términos de la transacción. "

Lin(9) = "^6.       Fecha de Vencimiento:^ Se llama Fecha de Vencimiento o Fecha de Liquidación y Compensación,  aquella  fecha "
Lin(9) = Lin(9) & "única para cada contrato, en que se debe producir la entrega de la moneda extranjera  o  en que se debe producir la "
Lin(9) = Lin(9) & "compensación entre ambas obligaciones, según la forma de cumplimiento estipulada en el contrato.   En el evento que "
Lin(9) = Lin(9) & "la citada fecha correspondiera a un día que no es día hábil  bancario  en  la  ciudad  de  Santiago,  la  Fecha  de "
Lin(9) = Lin(9) & "Vencimiento o Fecha de Liquidación y Compensación se postergara hasta el siguiente día hábil bancario. "

Lin(10) = "^7.       Mecanismo de Cumplimiento:^ El mecanismo de cumplimiento  del  contrato podrá ser la  entrega física  o  la "
Lin(10) = Lin(10) & "compensación según se define en el N° 3 del Capitulo VII.  En caso que el mecanismo sea la  compensación,  para los "
Lin(10) = Lin(10) & "forward  o  swap de dólares de los  EEUU  versus moneda nacional se entiende  por  Precio Referencial de Mercado la "
Lin(10) = Lin(10) & "cantidad de pesos resultante de multiplicar el Tipo de Cambio de Referencia estipulado en el contrato, vigente a la "
Lin(10) = Lin(10) & "fecha de vencimiento de este, por el monto de dólares de los EEUU objeto del contrato. Para los forward  o  swap de "
Lin(10) = Lin(10) & "dólares de los EEUU versus una moneda extranjera distinta de dólar de los EEUU, se entiende por  Precio Referencial "
Lin(10) = Lin(10) & "de Mercado la cantidad de dólares de los EEUU, según la Paridad de Referencia estipulada en el contrato, vigente  a "
Lin(10) = Lin(10) & "la fecha de vencimiento de este. "

Lin(11) = "^8.       Cantidad de moneda Vendida:^ Es el monto de moneda que se compromete a vender o entregar el vendedor en  la "
Lin(11) = Lin(11) & "fecha de vencimiento. "

Lin(12) = "^9.       Tipo de Cambio Forward Pactado:^ Es la cantidad de pesos moneda nacional o unidades de fomento,  estipulada "
Lin(12) = Lin(12) & "por las partes en el contrato, necesaria para comprar una unidad de moneda extranjera en la Fecha de Vencimiento. "
Lin(12) = Lin(12) & "El tipo de cambio en pesos moneda nacional por dólar de los EEUU se expresara con 2 decimales. El tipo de cambio en "
Lin(12) = Lin(12) & "Unidades de Fomento por dólar de los EEUU se expresara con 10 decimales. "

Lin(13) = "^10.      Paridad de Forward Pactada:^ Es la cantidad de moneda extranjera distinta del dólar de los EEUU, estipulada "
Lin(13) = Lin(13) & "por las partes en el contrato, necesaria para comprar un dólar de los EEUU en la Fecha de Vencimiento.   La paridad "
Lin(13) = Lin(13) & "en unidades de moneda extranjera por dólar de los EEUU se expresara con 4 decimales. "

Lin(14) = "^11.      Valor Forward Pactado:^ Es el monto de moneda que se compromete a pagar o entregar el comprador en la fecha "
Lin(14) = Lin(14) & "de vencimiento. Para los Forward o swap de dólares de los  EEUU  versus moneda nacional el Valor Forward Pactado se "
Lin(14) = Lin(14) & "expresara en pesos moneda nacional o en Unidades de Fomento, según corresponda.  Para los Forward o Swap de Dólares "
Lin(14) = Lin(14) & "de los EEUU  versus una moneda extranjera distinta del dólar de los EEUU,  el Valor Forward Pactado se expresara en "
Lin(14) = Lin(14) & "dólares de los EEUU. "

Lin(15) = "^12.      Tipo de Cambio de Referencia:^ Se entiende el Tipo de Cambio Observado, o el Tipo de Cambio Acuerdo,  o  el "
Lin(15) = Lin(15) & "Tipo de Cambio REUTERS, o cualquier otra referencia, estipulada por las partes en el contrato. "

Lin(16) = "^13.      Paridad de Referencia:^ Se entiende la Paridad Banco Central de Chile,  o la Paridad REUTERS,  o  cualquier "
Lin(16) = Lin(16) & "otra referencia, estipulada por las partes en el contrato. "

Lin(17) = "^14.      Otras Condiciones:^ Espacio reservado en el contrato para precisar o definir condiciones no establecidas en "
Lin(17) = Lin(17) & " el mismo. "

Lin(18) = "^15.      Otras Definiciones:^ Para todos los efectos, se aplicaran las siguientes definiciones: "

Lin(19) = "^a)^ Por Unidad de Fomento se entiende aquella unidad de reajustabilidad que determine  el  Banco Central de "
Lin(19) = Lin(19) & "Chile de acuerdo a lo previsto en el articulo 35, numero 9 de la Ley N° 18.840, y que publique en el Diario Oficial "
Lin(19) = Lin(19) & "conforme al Capitulo II.B.3 del Compendio de Normas Financieras, por el valor vigente en la correspondiente   Fecha "
Lin(19) = Lin(19) & "de Vencimiento o de exigibilidad en caso de liquidación anticipada. "

Lin(20) = "^b)^ Por Tipo de Cambio Observado del dólar de los  EEUU  se entiende el valor en pesos moneda nacional  del "
Lin(20) = Lin(20) & "dólar  de  los  EEUU,  según lo publique el  Banco Central de Chile  y  que rija en la  Fecha de Vencimiento  o  de "
Lin(20) = Lin(20) & "exigibilidad en caso de liquidación anticipada,  conforme al numero 6  del Capitulo I del Titulo I del Compendio de "
Lin(20) = Lin(20) & "Normas de Cambios Internacionales. "

Lin(21) = "^c)^ Por Tipo de Cambio Acuerdo del dólar de los  EEUU  se entiende  el  valor en pesos moneda nacional  del "
Lin(21) = Lin(21) & "dólar  de los  EEUU,  según fijación que haya hecho el Consejo  del  Banco Central de Chile,  conforme al N° 7  del "
Lin(21) = Lin(21) & " Capitulo I  del  Titulo I  del  Compendio de Normas  de  Cambios Internacionales,  en la  Fecha de Vencimiento o de "
Lin(21) = Lin(21) & "exigibilidad en caso de liquidación anticipada. "

Lin(22) = "^d)^ Por Tipo de Cambio Reuters,  se entiende el valor en pesos moneda nacional  de una  unidad de la moneda "
Lin(22) = Lin(22) & "extranjera de que se trate, según el valor comprador,  vendedor o promedio simple,  según se pacte en el  contrato, "
Lin(22) = Lin(22) & "informado por REUTERS en pantalla 'CHLJ' para el mercado interbancario, a la hora estipulada en el contrato,  en la "
Lin(22) = Lin(22) & " Fecha de Vencimiento o de exigibilidad en caso de liquidación anticipada. "

Lin(23) = "^e)^ Por Paridad Banco Central de Chile,  se entiende la cantidad de moneda extranjera  distinta  del  dólar "
Lin(23) = Lin(23) & " EEUU, necesaria para comprar un dólar EEUU, informada por el Banco Central de Chile conforme al N° 6 del Capitulo I "
Lin(23) = Lin(23) & "del Titulo I del Comprendió de Normas de Cambios Internacionales, en la Fecha de Vencimiento  o  de exigibilidad en "
Lin(23) = Lin(23) & " caso de liquidación anticipada. "

Lin(24) = "^f)^ Por paridad REUTERS,  se entiende la cantidad de moneda extranjera distinta del dólar  EEUU,  necesaria "
Lin(24) = Lin(24) & "para comprar un dólar EEUU,  según el valor comprador,  vendedor o promedio simple,  según se pacte en el contrato, "
Lin(24) = Lin(24) & "informado por REUTERS en pantalla 'EFX=',  a la hora estipulada en el contrato,  en la  Fecha de Vencimiento  o  de "
Lin(24) = Lin(24) & " exigibilidad en caso de liquidación anticipada. "

Lin(25) = "En caso que  deje de existir o se modifique alguno de los  factores  definidos,  todas las referencias a 'Unidad de "
Lin(25) = Lin(25) & "Fomento', 'Tipo de Cambio Observado', 'Tipo de Cambio Acuerdo', 'Tipo de Cambio REUTERS', 'Paridad Banco Central de "
Lin(25) = Lin(25) & "Chile', o 'Paridad REUTERS', se entenderán como referidas a aquel factor que los reemplace y que sea aplicable a la "
Lin(25) = Lin(25) & "operación. "

Lin(26) = "@FECHA"

FechaHoy = "Santiago, " & Day(Date) & " de " & BacMesStr(Month(Date)) & " del " & Year(Date)

Lin(26) = BacRemplazar(Lin(26), "@FECHA", FechaHoy)


Lin(1) = BacFormatearTexto(Lin(1), 3, 0, 0, 0, 88)
Lin(2) = BacFormatearTexto(Lin(2), 3, 0, 0, 0, 88)

 nTab = 8
 nFila = 2
 BacGlbSetPrinter 65, 80, 1, 1
' BacGlbSetFont CourierNew, 10, True
 Printer.FontBold = True
nFila = nFila + 1
BacGlbPrinter nFila, 1, nTab, 1, Lin(1), 0, 1
nFila = nFila + 1
BacGlbPrinter nFila, 1, nTab, 1, Lin(2), 0, 1
nFila = nFila + 1
BacGlbPrinter nFila, 1, nTab, 1, Lin(0), 0, 1

nTab = 12

nFila = nFila + 1
BacGlbPrinter nFila, 1, nTab, 1, Lin(0), 0, 1
Printer.FontBold = False
'BacGlbSetFont CourierNew, 10, False
    
For i = 3 To 25
    nFila = nFila + 1
    BacGlbPrinter nFila, 1, nTab, 1, Lin(0), 0, 1

    BacCentraTexto aString(), Lin(i), 80

    For nCont = 1 To UBound(aString())
        
        nFila = nFila + 1
       
        If nFila = 65 Then
            nFila = 4
            Printer.NewPage
        End If
        sTexto = aString(nCont)
        For nCont2 = 1 To Len(sTexto)
            cCaracter = Mid(sTexto, nCont2, 1)
            
            If cCaracter = "^" Then
                Printer.FontBold = IIf(Printer.FontBold = False, True, False)
                cCaracter = " "
            End If
            
            BacGlbPrinter nFila, 1, nTab - 1 + nCont2, 1, cCaracter, 0, 1
        Next
    Next
Next

nFila = nFila + 1
BacGlbPrinter nFila, 1, nTab, 1, Lin(0), 0, 1
nFila = nFila + 1
BacGlbPrinter nFila, 1, nTab, 1, Lin(0), 0, 1
nFila = nFila + 1
BacGlbPrinter nFila, 1, nTab, 1, Lin(0), 0, 1
nFila = nFila + 1
BacGlbPrinter nFila, 1, nTab, 1, Lin(0), 0, 1

Lin(26) = BacFormatearTexto(Lin(26), 2, 0, 0, 0, 88)    'alinear a la derecha
nFila = nFila + 1
BacGlbPrinter nFila, 1, nTab, 1, Lin(26), 0, 1

Printer.NewPage

BacGlbPrinterEnd

ProtocoloContratoANt = True

Exit Function

Control:

    MsgBox "Problemas para Imprimir Informe de Protocolo de Contrato", vbCritical, Msj
    Exit Function

End Function
Function SumaFila(Fila, MaxFil)

    Fila = Fila + 1
    
    If Fila = MaxFil Then
        Fila = 4
        Printer.NewPage
    End If
        
End Function
Public Function BacContratoSwaps(NumOper As Double, Tabla As Double, DatCont()) As Boolean

On Error GoTo Control:

Dim SQL As String
Dim Datos()
Dim TipOperacion As String
Dim FechaAnt As Date
Dim FechaVstr As String
Dim Dias As Integer
Dim Lin(50)
Dim LinCli(50)
Dim LinBco(50)
Dim LinDir(50)
Dim m, j
Dim nPosicion As Integer
Dim nFila     As Integer

Dim nTab      As Integer
Dim aString()
Dim nCont     As Integer
Dim sTexto    As String
Dim nCont2    As Integer
Dim cCaracter As String
Dim Dat As String

BacContratoSwaps = False

SQL = "EXECUTE SP_DATOSCONTRATO " & NumOper & ", " & Tabla & ", '" & giSQL_DatabaseCommon & "'"

If MISQL.SQL_Execute(SQL) <> 0 Then
   MsgBox "Problemas al leer datos para generar contrato", vbCritical, "MENSAJE"
   Exit Function

End If

Call FuentesImpresora
Lin(0) = " "
Lin(1) = "@BANCO"
Lin(2) = "CONTRATO A FUTURO"
Lin(3) = "Número Operación : @NUMERO"
                  
Lin(4) = "Entre ^@BANCO^, Sucursal  en  Chile, en  adelante denominada  'el Banco', "
Lin(4) = Lin(4) & "representada  por  Don ^@REPBANCO1^,  RUT  N°   ^@RUTREPBCO1^ "
If DatCont(5) <> "" Then
    Lin(4) = Lin(4) & "y Don ^@REPBANCO2^,  RUT  N°   ^@RUTREPBCO2^ "
End If

Lin(4) = Lin(4) & "y  ^@CLIENTE^, representado por Don "
Lin(4) = Lin(4) & "^@REPCLIENTE1^,  Rut  N° ^@RUTREPCLI1^ "
If DatCont(12) <> "" Then
    Lin(4) = Lin(4) & "y Don ^@REPCLIENTE2^,  Rut  N° ^@RUTREPCLI2^ "
End If
Lin(4) = Lin(4) & ", en adelante denominado el 'cliente', todo con los "
Lin(4) = Lin(4) & "domicilios que en este instrumento mas adelante se señalan, se conviene el siguiente Contrato de Futuros: "

Lin(5) = "^PRIMERO : Objeto.^ "

Lin(6) = "Las  partes,  conscientes  que por el dinamismo propio del mercado en que se desarrollan las actividades de su giro, "
Lin(6) = Lin(6) & "cualquier  fluctuación  importante  que se produzca en las principales variables económicas se traduce en efectos de "
Lin(6) = Lin(6) & "significación  en  sus  estados  financieros y situación patrimonial, y con el objetivo básico de evitar o minimizar "
Lin(6) = Lin(6) & "tales  efectos,  en  sus resultados y lograr una adecuada compatibilidad y calce en las estructuras de sus activos y "
Lin(6) = Lin(6) & "pasivos,  han convenido en la celebración del presente contrato. "

Lin(7) = "^SEGUNDO : Definiciones.^"

Lin(8) = "Para  todos  los  efectos  del  presente contrato, los términos que a continuación se indican, cuando en el presente "
Lin(8) = Lin(8) & "instrumento se escriban con mayúscula, tendrán el significado que a continuación de cada uno de ellos se expresa: "

Lin(9) = "^(a)  U.F.:^  Es  la  Unidad de Fomento a que se refiere el Art. 35 N° 9 de la Ley 18.840, por su valor vigente en las "
Lin(9) = Lin(9) & "correspondientes  Fechas  de  Liquidación.  En  el  caso que se modificare o suprimiere el sistema de reajuste de la "
Lin(9) = Lin(9) & "Unidad  de  Fomento,  las  partes  continuarán  rigiéndose por ella como si no se hubiese modificado o suprimido, de "
Lin(9) = Lin(9) & "acuerdo  a  las  publicaciones e informes que deber  hacer el Banco Central de Chile según lo dispone el artículo 35 "
Lin(9) = Lin(9) & "N° 9, inciso 2  y siguientes, de la Ley N° 18.840 Orgánica constitucional del Banco Central de Chile. "

Lin(10) = "^(b) Dólar o US$:^ Es la moneda legal de los Estados Unidos de América. "

Lin(11) = "^(c) Pesos o  $:^ Es la moneda legal de Chile. "

Lin(12) = "^(d)  Fecha  de  Liquidación:^  Son aquellas fechas establecidas en el artículo tercero que sigue, en las cuales deben "
Lin(12) = Lin(12) & "determinarse  las  obligaciones  recíprocas de las partes, efectuarse la compensación entre ambas hasta por el monto "
Lin(12) = Lin(12) & "de la  menor de ellas, y solucionarse la obligación por la que resulte deudora. "

Lin(13) = "^(d.1)^  Sin  embargo,  si  cualquiera  Fecha de Liquidación correspondiente a un día que no es un Día Hábil Bancario, "
Lin(13) = Lin(13) & "dicha Fecha de Liquidación se postergar  hasta el Día Hábil Bancario siguiente. "

Lin(14) = "^(d.2)^  Si  el  cliente  incurriere,  en  cualquier  tiempo, en mora o simple retardo en el cumplimiento de cualquier "
Lin(14) = Lin(14) & "obligación  con 'el Banco', provenga de este contrato o de cualquier otro, o si cayere en cesación de pagos o insolvencia "
Lin(14) = Lin(14) & "o  se solicitare o declarare su quiebra, 'el Banco' tendrá  el derecho a anticipar la Fecha de Liquidación correspondiente "
Lin(14) = Lin(14) & "previo   aviso  por carta certificada enviada al Cliente con 24 horas de anticipación, a su domicilio señalado en la "
Lin(14) = Lin(14) & "cláusula  sexta del presente contrato. "

Lin(15) = "^(d.3)^  Si  el  Cliente  incurriere,  en  cualquier  tiempo, en mora o simple retardo en el cumplimiento de cualquier "
Lin(15) = Lin(15) & "obligación  contraida  con 'el Banco' en virtud de este contrato, en especial, en el cumplimiento de cualquier obligación "
Lin(15) = Lin(15) & "de  pago  de  una suma de dinero, así como en el caso que 'el Banco' anticipare cualquier Fecha de liquidación conforme a "
Lin(15) = Lin(15) & "lo  señalado  en  (d.2),  'el Banco' podrá  poner término a este contrato de inmediato, previo aviso por carta certificada "
Lin(15) = Lin(15) & "enviada al Cliente con 24 horas de anticipación, a su domicilio señalado en la cláusula sexta del presente contrato. "

Lin(16) = "^(e)  Día  Hábil  Bancario:^  Es aquel en que los bancos comerciales establecidos en Santiago, están obligados a abrir "
Lin(16) = Lin(16) & "para la atención de público. "

Lin(17) = "^(f)  Tipo  de Cambio:^ Es la cantidad de Pesos necesaria para comprar un Dólar, según el valor que publicite el Banco "
Lin(17) = Lin(17) & "Central  de  Chile  o  el  organismo  que  lo  sustituya o reemplace, en conformidad con lo dispuesto en el N° 6 del "
Lin(17) = Lin(17) & "Capítulo  I,  Título  I,  del Compendio De Normas de Cambios Internacionales del Banco Central de Chile, que rija en "
Lin(17) = Lin(17) & "las correspondientes Fechas de Liquidación (Dólar Observado). "

Lin(18) = "Si  el  tipo  de  cambio  del Dólar Observado no fuera publicado por el Banco Central de Chile o el organismo que lo "
Lin(18) = Lin(18) & "reemplace  o  sustituya,  se  aplicará   a este contrato el tipo de cambio promedio informado en las correspondientes "
Lin(18) = Lin(18) & "Fecha  de  Liquidación  por el Banco Central de Chile como aplicables a las operaciones de compra o venta realizadas "
Lin(18) = Lin(18) & "por  las  empresas  bancarias.  Si  se  informasen  cotizaciones distintas de compra y venta se aplicará  el promedio "
Lin(18) = Lin(18) & "aritmético  de  ambas. En caso de que el Banco Central de Chile dejase de informar dicho tipo de cambio promedio, se "
Lin(18) = Lin(18) & "aplicara  el  tipo   de cambio promedio informado por Inversiones Citicorp Chile S.A. y publicado en algún diario de "
Lin(18) = Lin(18) & "la  ciudad  de  Santiago  de  Chile,  en  las  correspondientes Fechas de Liquidación y que corresponda al Día Hábil "
Lin(18) = Lin(18) & "Bancario  inmediatamente  anterior.  A  falta  de  todos los anteriores, se aplicará  el promedio aritmético entre el "
Lin(18) = Lin(18) & "precio  del  Dólar  comprador  y  del  Dólar vendedor ofrecido en las correspondientes Fechas de Liquidación por las "
Lin(18) = Lin(18) & "oficinas principales de @BANCO, Sucursal en Chile. "

Lin(19) = "^(g)  Libo  o  Libor:^  Es  la  tasa  de  interés  a  180  días  certificada como tal en la información del 'Estado de "
Lin(19) = Lin(19) & "Equivalencias  en  Moneda  Extranjera'  proporcionada  por  el  Banco  Central de Chile, y publicada en el diario El "
Lin(19) = Lin(19) & "Mercurio  de  Santiago, Estrategia o en el Diario Financiero en las correspondientes Fechas de Liquidación indicadas "
Lin(19) = Lin(19) & "en  la  cláusula  tercera.  No  obstante  para  el  cálculo  de la tasa que regirá  entre la fecha de suscripción del "
Lin(19) = Lin(19) & "presente  contrato  y  la  primera  Fecha  de  Liquidación,  esto  es, el @FECHVCT1, se considerar  la tasa Libo de "
Lin(19) = Lin(19) & "@VALORLIB % corresponde al día @FECHCIERRE. "

'Lin(20) = *****"En  caso  que  por  cualquiera  causa  o  motivo  el  Banco Central de Chile no hubiere informado la tasa Libo antes"
'Lin(20) = Lin(20) & "indicada,  se  aplicará  en  su  reemplazo  la tasa Libo para 180 días que informe @BANCO, en su oficina"
'Lin(20) = Lin(20) & "principal de  la ciudad de Londres, Inglaterra, como vigente durante el respectivo período."

Lin(21) = "^(h) Tasa Activa Bancario o TAB:^ Es la tasa de interés ponderada que, para operaciones de ciento ochenta días informa "
Lin(21) = Lin(21) & "y  determina  para  cada  día  hábil  bancario la Asociación de Bancos e Instituciones Financieras de Chile A.G., en "
Lin(21) = Lin(21) & "adelante  la  'Asociación',  sobre  la  base de los datos que le proporcionan cada día las instituciones financieras "
Lin(21) = Lin(21) & "participantes,  a  más  tardar  a  las  once  horas  ante  meridiano,  acerca  de sus tasas marginales de captación, "
Lin(21) = Lin(21) & "agregándoles  el  costo  que  representan  aquellos factores objetivos cuantificables y comunes para todo el sistema "
Lin(21) = Lin(21) & "financiero  que,  a  juicio  de  la  Asociación, encarecen la captación de fondos del público, todo ello conforme al "
Lin(21) = Lin(21) & "reglamento  de  Tasa  Activa  Bancaria  (TAB)  publicado en extracto por la Asociación en el Diario Oficial de fecha "
Lin(21) = Lin(21) & "veintidós de Agosto de mil novecientos noventa y dos."

Lin(22) = "^TERCERO:^  Por  el  presente  instrumento,  el  Cliente  se  obliga  a pagar a 'el Banco' en la Fecha de Liquidación las "
Lin(22) = Lin(22) & "siguientes cantidades equivalentes en Pesos al tipo de cambio de las respectivas Fechas de Liquidación. "
          '12345678901234567890123456789012345678901234567890123456789012345678901234567890
Lin(23) = "^Fecha de Liquidación       Monto @MONEDA^ "
Lin(24) = "_________________________________________________________________________________________"

Lin(26) = "Por  su  parte,  'el Banco'  se  obliga  a  pagar al Cliente en las correspondientes Fechas de liquidación las siguientes "
Lin(26) = Lin(26) & "cantidades equivalentes en Pesos al valor de la Unidad de Fomento de las respectivas Fechas de Liquidación: "

Lin(27) = "^Fecha de Liquidación    Monto @MONEDA^"

Lin(29) = "Para todos los cálculos a efectuar en cada una de las Fechas de Liquidación señaladas en los párrafos anteriores, se "
Lin(29) = Lin(29) & "utilizará  según  corresponda,  la  tasa  Libo  y  la  tasa  TAB  vigente  en  el mercado, a la Fecha de liquidación "
Lin(29) = Lin(29) & "inmediatamente anterior. "

Lin(30) = "^QUINTO:^  Las  partes  acuerdan  que  ni  el  presente  contrato  ni los derechos que en él constan, son libremente "
Lin(30) = Lin(30) & "transferibles  ni  pueden  cederse  por  endoso. En consecuencia, ninguna de las partes podrá  ceder o transferir los "
Lin(30) = Lin(30) & "derechos  del   presente contrato sin el previo consentimiento de la otra parte. Para este efecto, el consentimiento "
Lin(30) = Lin(30) & "de  ambas  partes deber  manifestarse en cada uno de los dos ejemplares del presentes contratos, indicándose bajo la "
Lin(30) = Lin(30) & "firma  de  cada  una de ellas el nombre de la persona a quien se venden los derechos, así como la aceptación de ésta "
Lin(30) = Lin(30) & "última para contraer todas las obligaciones que tenía anteriormente la parte cesionaria. "

Lin(31) = "^SEXTO:^  Durante  la  vigencia del presente contrato, 'el Banco' estará  facultado para que a su sola discreción, efectúe "
Lin(31) = Lin(31) & "colocaciones  interbancarias  en  @CLIENTE  por  un  monto equivalente a la cantidad señalada en la fecha de "
Lin(31) = Lin(31) & "Liquidación  inmediatamente  posterior  a la Fecha de Liquidación en que se realiza la respectiva colocación y @CLIENTE "
Lin(31) = Lin(31) & "se  obliga a captar dichas colocaciones. Tales colocaciones se realizarán en cualquier período comprendido "
Lin(31) = Lin(31) & "entre  dos  Fechas  de  Liquidación  sucesivas  y @CLIENTE pagará  a 'el Banco' la tasa   @VALORTASCLI % vigente en el "
Lin(31) = Lin(31) & "mercado en la fecha  en que se efectúe la colocación referida. "

Lin(32) = "^SEPTIMO:^ Para todos los efectos derivados del presente contrato, las partes fijan domicilio especial y único en la "
Lin(32) = Lin(32) & "Ciudad  y  Comuna  de Santiago. Para los efectos de los avisos, requerimientos y notificaciones a que haya lugar las "
Lin(32) = Lin(32) & "partes fijan los siguientes domicilios: "

LinDir(1) = "@BANCO"
LinDir(2) = "@DIRBANCO"
LinDir(3) = "Atn. : @REPBANCO1"
LinDir(4) = "       @REPBANCO2"

LinDir(5) = "@CLIENTE"
LinDir(6) = "@DIRCLIENTE"
LinDir(7) = "Atn. : @REPCLIENTE1"
LinDir(8) = "       @REPCLIENTE2"

Lin(41) = "Cualquiera  de  las  partes  podrá   modificar  el  domicilio  antes  indicado,  comunicándoselo  a la otra por carta "
Lin(41) = Lin(41) & "certificada  dirigida al domicilio señalado precedentemente en esta cláusula, como una anticipación no inferior a 10 "
Lin(41) = Lin(41) & "días  de la fecha en que dicho cambio de domicilio producirá  sus efectos. En todo caso, todos los domicilios que las "
Lin(41) = Lin(41) & "partes fijen deberán encontrarse en la ciudad de Santiago de Chile. "

Lin(42) = "^SEPTIMO:^ Todos los gastos, impuestos, derechos y desembolsos de cualquier naturaleza que se causaren con motivo del "
Lin(42) = Lin(42) & "otorgamiento del presente contrato, de su aplicación y/o de su cumplimiento, serán de cargo exclusivo del Cliente. "

Lin(43) = "^OCTAVO:^ Todas las obligaciones de las partes derivadas del presente contrato serán individuales, en los términos de "
Lin(43) = Lin(43) & "los artículos 1526 # 4 y 1528 del Código Civil de la República de Chile. "

Lin(44) = "^NOVENO:^  Cualquier  dificultad o controversia que se suscite entre las partes por cualquier motivo o circunstancia, "
Lin(44) = Lin(44) & "que se relacione directa o indirectamente con este contrato, será  resuelta en arbitraje ante un  árbitro arbitrador o "
Lin(44) = Lin(44) & "amigable  componedor  quien  resolverá  sin forma de juicio y sin ulterior recurso. El  árbitro será  nombrado de común "
Lin(44) = Lin(44) & "acuerdo  por las partes. A falta de acuerdo la designación de  árbitro la hará  la justicia ordinaria, a requerimiento "
Lin(44) = Lin(44) & "de   cualquiera  de  las  partes,  pero  en este caso el  árbitro será de derecho, el procedimiento se sujetará a las "
Lin(44) = Lin(44) & "normas de  juicio sumario, y las resoluciones que dicte el  árbitro serán susceptibles de todo los recursos legales. "

Lin(45) = "El presente contrato se suscribe en dos ejemplares del mismo temor y fecha, quedando uno en poder de cada parte. "
          '12345678901234567890123456789012345678901234567890123456789012345678901234567890
Lin(46) = "Firma  :______________________________  Firma  : ______________________________"
Lin(47) = "pp.    :@BANCO pp.    : @CLIENTE "
Lin(48) = "Nombre :@REPBANCO Nombre : @REPCLIENTE "
Lin(49) = "Rut    :@RUTREPBCO Rut    : @RUTREPCLI "

' Reemplazo de datos

Lin(1) = BacRemplazar(Lin(1), "@BANCO", DatCont(1))
Lin(3) = BacRemplazar(Lin(3), "@NUMERO", NumOper)
Lin(4) = BacRemplazar(Lin(4), "@BANCO", DatCont(1))
Lin(4) = BacRemplazar(Lin(4), "@REPBANCO1", DatCont(3))
Lin(4) = BacRemplazar(Lin(4), "@RUTREPBCO1", DatCont(4))
If DatCont(5) <> "" Then
    Lin(4) = BacRemplazar(Lin(4), "@REPBANCO2", DatCont(5))
    Lin(4) = BacRemplazar(Lin(4), "@RUTREPBCO2", DatCont(6))
End If
Lin(4) = BacRemplazar(Lin(4), "@CLIENTE", DatCont(8))
Lin(4) = BacRemplazar(Lin(4), "@REPCLIENTE1", DatCont(10))
Lin(4) = BacRemplazar(Lin(4), "@RUTREPCLI1", DatCont(11))
If DatCont(12) <> "" Then
    Lin(4) = BacRemplazar(Lin(4), "@REPCLIENTE2", DatCont(12))
    Lin(4) = BacRemplazar(Lin(4), "@RUTREPCLI2", DatCont(13))
End If

Lin(18) = BacRemplazar(Lin(18), "@BANCO", DatCont(1))

Lin(19) = BacRemplazar(Lin(19), "@FECHVCT1", DatCont(1))
Lin(19) = BacRemplazar(Lin(19), "@VALORLIB", DatCont(1))
Lin(19) = BacRemplazar(Lin(19), "@FECHCIERRE", DatCont(1))

Lin(31) = BacRemplazar(Lin(31), "@CLIENTE", DatCont(8))
Lin(31) = BacRemplazar(Lin(31), "@CLIENTE", DatCont(8))
Lin(31) = BacRemplazar(Lin(31), "@CLIENTE", DatCont(8))

LinDir(1) = BacRemplazar(LinDir(1), "@BANCO", DatCont(1))
LinDir(2) = BacRemplazar(LinDir(2), "@DIRBANCO", DatCont(7))
LinDir(3) = BacRemplazar(LinDir(3), "@REPBANCO1", DatCont(3))
If DatCont(5) <> "" Then
    LinDir(4) = BacRemplazar(LinDir(4), "@REPBANCO2", DatCont(5))
End If

LinDir(5) = BacRemplazar(LinDir(5), "@CLIENTE", DatCont(8))
LinDir(6) = BacRemplazar(LinDir(6), "@DIRCLIENTE", DatCont(14))
LinDir(7) = BacRemplazar(LinDir(7), "@REPCLIENTE1", DatCont(3))
If DatCont(12) <> "" Then
    LinDir(8) = BacRemplazar(LinDir(8), "@REPCLIENTE2", DatCont(12))
End If

Lin(47) = BacRemplazar(Lin(47), "@BANCO", DatCont(1) & Space(31 - Len(DatCont(1))))
Lin(47) = BacRemplazar(Lin(47), "@CLIENTE", DatCont(8) & Space(30 - Len(DatCont(8))))
DatCont(3) = Left(DatCont(3), 25)
Lin(48) = BacRemplazar(Lin(48), "@REPBANCO", DatCont(3) & Space(31 - Len(DatCont(3))))
Lin(48) = BacRemplazar(Lin(48), "@REPCLIENTE", DatCont(10) & Space(30 - Len(DatCont(10))))
Lin(49) = BacRemplazar(Lin(49), "@RUTREPBCO", DatCont(4) & Space(31 - Len(DatCont(4))))
Lin(49) = BacRemplazar(Lin(49), "@RUTREPCLI", DatCont(11) & Space(30 - Len(DatCont(11))))

Lin(25) = ""
Lin(28) = ""

m = 0
Do While MISQL.SQL_Fetch(Datos()) = 0
    FechaAnt = Datos(6)
    m = m + 1
    
    TipOperacion = Datos(4)
    
    FechaVstr = Format(Day(Datos(20)), "00") & " de " & BacMesStr(Month(Datos(20))) & " del " & Year(Datos(20))
    
    LinCli(m) = "@FECHAVENCFLUJ @MONTOCLI @NOMTASA @VALORTASA% @DIASBASE @MONTOAMORT "
    LinBco(m) = "@FECHAVENCFLUJ @MONTOBCO @NOMTASA @VALORTASA% @DIASBASE @MONTOAMORT "
                        '12345678901234567890123456789012345678901234567890123456789012345678901234567890
    Dias = DateDiff("d", FechaAnt, Datos(20))
    
    If TipOperacion = "C" Then
        
        LinCli(m) = BacRemplazar(LinCli(m), "@FECHAVENCFLUJ", FechaVstr & Space(25 - Len(FechaVstr)))
        Dat = Format(Datos(53), "###,###,###,##0.00")
        LinCli(m) = BacRemplazar(LinCli(m), "@MONTOCLI", Space(18 - Len(Dat)) & Dat)
        LinCli(m) = BacRemplazar(LinCli(m), "@NOMTASA", Space(5 - Len(Datos(27))) & Datos(27))
        Dat = Format(Datos(57), "###0.00000")
        LinCli(m) = BacRemplazar(LinCli(m), "@VALORTASA", Space(10 - Len(Dat)) & Dat)
        Dat = Dias & "/" & Val(Datos(22))
        LinCli(m) = BacRemplazar(LinCli(m), "@DIASBASE", Space(7 - Len(Dat)) & Dat)
        Dat = Format(Datos(52), "###,###,###,##0.00")
        LinCli(m) = BacRemplazar(LinCli(m), "@MONTOAMORT", Space(18 - Len(Dat)) & Dat)

        LinBco(m) = BacRemplazar(LinBco(m), "@FECHAVENCFLUJ", FechaVstr & Space(25 - Len(FechaVstr)))
        Dat = Format(Datos(34), "###,###,###,##0.00")
        LinBco(m) = BacRemplazar(LinBco(m), "@MONTOBCO", Space(18 - Len(Dat)) & Dat)
        LinBco(m) = BacRemplazar(LinBco(m), "@NOMTASA", Space(5 - Len(Datos(26))) & Datos(26))
        Dat = Format(Datos(38), "###0.00000")
        LinBco(m) = BacRemplazar(LinBco(m), "@VALORTASA", Space(10 - Len(Dat)) & Dat)
        Dat = Dias & "/" & Val(Datos(23))
        LinBco(m) = BacRemplazar(LinBco(m), "@DIASBASE", Space(7 - Len(Dat)) & Dat)
        Dat = Format(Datos(33), "###,###,###,##0.00")
        LinBco(m) = BacRemplazar(LinBco(m), "@MONTOAMORT", Space(18 - Len(Dat)) & Dat)

    Else
        
        LinBco(m) = BacRemplazar(LinBco(m), "@FECHAVENCFLUJ", FechaVstr & Space(25 - Len(FechaVstr)))
        Dat = Format(Datos(53), "###,###,###,##0.00")
        LinBco(m) = BacRemplazar(LinBco(m), "@MONTOCLI", Space(18 - Len(Dat)) & Dat)
        LinBco(m) = BacRemplazar(LinBco(m), "@NOMTASA", Space(5 - Len(Datos(27))) & Datos(27))
        Dat = Format(Datos(57), "###0.00000")
        LinBco(m) = BacRemplazar(LinBco(m), "@VALORTASA", Space(10 - Len(Dat)) & Dat)
        Dat = Dias & "/" & Val(Datos(22))
        LinBco(m) = BacRemplazar(LinBco(m), "@DIASBASE", Space(7 - Len(Dat)) & Dat)
        Dat = Format(Datos(52), "###,###,###,##0.00")
        LinBco(m) = BacRemplazar(LinBco(m), "@MONTOAMORT", Space(18 - Len(Dat)) & Dat)

        LinCli(m) = BacRemplazar(LinCli(m), "@FECHAVENCFLUJ", FechaVstr & Space(25 - Len(FechaVstr)))
        Dat = Format(Datos(34), "###,###,###,##0.00")
        LinCli(m) = BacRemplazar(LinCli(m), "@MONTOBCO", Space(18 - Len(Dat)) & Dat)
        LinCli(m) = BacRemplazar(LinCli(m), "@NOMTASA", Space(5 - Len(Datos(26))) & Datos(26))
        Dat = Format(Datos(38), "###0.00000")
        LinCli(m) = BacRemplazar(LinCli(m), "@VALORTASA", Space(10 - Len(Dat)) & Dat)
        Dat = Dias & "/" & Val(Datos(23))
        LinCli(m) = BacRemplazar(LinCli(m), "@DIASBASE", Space(7 - Len(Dat)) & Dat)
        Dat = Format(Datos(33), "###,###,###,##0.00")
        LinCli(m) = BacRemplazar(LinCli(m), "@MONTOAMORT", Space(18 - Len(Dat)) & Dat)

    End If

Loop

Lin(23) = BacRemplazar(Lin(23), "@MONEDA", Datos(10))
Lin(27) = BacRemplazar(Lin(27), "@MONEDA", Datos(10))
If TipOperacion = "C" Then
    Lin(31) = BacRemplazar(Lin(31), "@VALORTASCLI", Datos(24))
Else
    Lin(31) = BacRemplazar(Lin(31), "@VALORTASCLI", Datos(23))
End If


Lin(1) = BacFormatearTexto(Lin(1), 3, 0, 0, 0, 88)
Lin(2) = BacFormatearTexto(Lin(2), 3, 0, 0, 0, 88)

 nTab = 8
 nFila = 2
 BacGlbSetPrinter 65, 80, 1, 1
 'BacGlbSetFont CourierNew, 10, True
  Printer.FontBold = True
Call SumaFila(nFila, 65)
BacGlbPrinter nFila, 1, nTab, 1, Lin(1), 0, 1

Call SumaFila(nFila, 65)
BacGlbPrinter nFila, 1, nTab, 1, Lin(2), 0, 1

Call SumaFila(nFila, 65)
BacGlbPrinter nFila, 1, nTab, 1, Lin(0), 0, 1

nTab = 12

Call SumaFila(nFila, 65)
BacGlbPrinter nFila, 1, nTab, 1, Lin(3), 0, 1

Call SumaFila(nFila, 65)
BacGlbPrinter nFila, 1, nTab, 1, Lin(0), 0, 1
Printer.FontBold = False
'BacGlbSetFont CourierNew, 10, False
    
For i = 4 To 45

    Call SumaFila(nFila, 65)
    BacGlbPrinter nFila, 1, nTab, 1, Lin(0), 0, 1
    
    If i = 24 Then
        'BacGlbSetFont CourierNew, 8, False
        Printer.FontBold = False
        nTab = 18
        
        Call SumaFila(nFila, 65)
        BacGlbPrinter nFila, 1, nTab, 1, Lin(24), 0, 1
        For j = 1 To m
            Call SumaFila(nFila, 65)
            BacGlbPrinter nFila, 1, nTab, 1, LinCli(j), 0, 1
        Next

        Call SumaFila(nFila, 65)
        BacGlbPrinter nFila, 1, nTab, 1, Lin(24), 0, 1
        Printer.FontBold = False
        'BacGlbSetFont CourierNew, 10, False
        nTab = 12
    
    ElseIf i = 28 Then
        Printer.FontBold = False
        'BacGlbSetFont CourierNew, 8, False
        nTab = 18

        Call SumaFila(nFila, 65)
        BacGlbPrinter nFila, 1, nTab, 1, Lin(24), 0, 1
        
        For j = 1 To m
            Call SumaFila(nFila, 65)
            BacGlbPrinter nFila, 1, nTab, 1, LinBco(j), 0, 1
        Next

        Call SumaFila(nFila, 65)
        BacGlbPrinter nFila, 1, nTab, 1, Lin(24), 0, 1
        Printer.FontBold = False
        'BacGlbSetFont CourierNew, 10, False
        nTab = 12
        
    ElseIf i = 33 Then

        Call SumaFila(nFila, 65)
        BacGlbPrinter nFila, 1, nTab, 1, Lin(i), 0, 1
        
        For j = 1 To 8
            
            Call SumaFila(nFila, 65)
            Select Case j
            Case 4
                If DatCont(5) <> "" Then
                    BacGlbPrinter nFila, 1, nTab, 1, LinDir(j), 0, 1
                    Call SumaFila(nFila, 65)
                End If
                BacGlbPrinter nFila, 1, nTab, 1, LinDir(0), 0, 1
                
            Case 8
                If DatCont(12) <> "" Then
                    BacGlbPrinter nFila, 1, nTab, 1, LinDir(j), 0, 1
                    Call SumaFila(nFila, 65)
                End If
                BacGlbPrinter nFila, 1, nTab, 1, LinDir(0), 0, 1
            
            Case Else
                BacGlbPrinter nFila, 1, nTab, 1, LinDir(j), 0, 1
            
            End Select
            
        Next
    
        i = 41
    
    Else
    
        BacCentraTexto aString(), Lin(i), 80
    
        For nCont = 1 To UBound(aString())
            
            Call SumaFila(nFila, 65)
            
            sTexto = aString(nCont)
            For nCont2 = 1 To Len(sTexto)
                cCaracter = Mid(sTexto, nCont2, 1)
                
                If cCaracter = "^" Then
                    Printer.FontBold = IIf(Printer.FontBold = False, True, False)
                    cCaracter = " "
                End If
                
                BacGlbPrinter nFila, 1, nTab - 1 + nCont2, 1, cCaracter, 0, 1
            Next
        Next
        
    End If
Next

For i = 1 To 4
    Call SumaFila(nFila, 65)
    BacGlbPrinter nFila, 1, nTab, 1, Lin(0), 0, 1
Next
For i = 46 To 49
    Call SumaFila(nFila, 65)
    BacGlbPrinter nFila, 1, nTab, 1, Lin(i), 0, 1
Next

Printer.NewPage

BacGlbPrinterEnd

BacContratoSwaps = True

Exit Function

Control:

    MsgBox "Problemas al generar Contrato!", vbInformation, Msj
    Exit Function

End Function
Public Function BacCondicionesGeneralesold(DatCont()) As Boolean

Dim SQL       As String
Dim Lin(72)
Dim nPosicion As Integer
Dim nFila     As Integer
Dim nTab      As Integer
Dim aString()
Dim nCont     As Integer
Dim sTexto    As String
Dim nCont2    As Integer
Dim cCaracter As String
Dim i As Integer

Call FuentesImpresora

Lin(0) = " "
Lin(1) = "CONDICIONES GENERALES PARA"
Lin(1) = BacFormatearTexto(Lin(1), 3, 0, 0, 0, 88)
Lin(2) = "LA CELEBRACION DE TRANSACCIONES"
Lin(2) = BacFormatearTexto(Lin(2), 3, 0, 0, 0, 88)
Lin(3) = "DE MERCADO A FUTURO DE MONEDA EXTRANJERA"
Lin(3) = BacFormatearTexto(Lin(3), 3, 0, 0, 0, 88)
Lin(4) = "@BANCO, SUCURSAL EN CHILE"
Lin(5) = "Y"
Lin(5) = BacFormatearTexto(Lin(5), 3, 0, 0, 0, 88)
Lin(6) = "@CLIENTE"

Lin(7) = "En @CIUDAD de Chile, a  @FECHACIERRE, comparecen por una parte,^@BANCO, @SUCURSAL^, "
Lin(7) = Lin(7) & "del giro de su denominación, representada por don(a) ^@REPBANCO1^  RUT  Nø ^@RUTREPBCO1^ "
Lin(7) = Lin(7) & "y   ^@REPBANCO2^  RUT  Nø ^@RUTREPBCO2^  los anteriores  con domicilio, para estos efectos, en calle "
Lin(7) = Lin(7) & "@DIRBANCO de esta ciudad en adelante también indistintamente  'El  Banco' y  por  la otra "
Lin(7) = Lin(7) & "^@NOMBRECLIENTE^ representada por don(a) ^@REPCLIENTE1^ RUT  Nø ^@RUTREPCLI1^ "
Lin(7) = Lin(7) & "y  don(a) ^@REPCLIENTE2^ RUT  Nø ^@RUTREPCLI2^ ambos domiciliados, para estos efectos, "
Lin(7) = Lin(7) & "en ^@DIRCLIENTE^ de esta ciudad, en adelante también el 'Cliente', quienes exponen:"

Lin(8) = "^PRIMERO:^ Por el presente instrumento,  las partes  mas arriba  individualizadas vienen en convenir los "
Lin(8) = Lin(8) & "términos y condiciones generales que regirán y se aplicaran a todas y cada una de las transacciones  de "
Lin(8) = Lin(8) & "CompraVenta a futuro de moneda extranjera,  de Arbitrajes a futuro de moneda extranjera  (Forwards) y "
Lin(8) = Lin(8) & "Permutas a futuro de moneda extranjera (Swaps),  que se acuerden  o  celebren entre ellas,  a contar de "
Lin(8) = Lin(8) & "esta fecha. "

Lin(9) = "En consecuencia,  todas y cada una de las  transacciones recién  indicadas celebrada  o  acordada entre "
Lin(9) = Lin(9) & "ambas,  quedara sujeta a las presentes  condiciones generales,  salvo en cuanto  en el documento  de la "
Lin(9) = Lin(9) & "respectiva operación, acordaren expresamente algo distinto. "

Lin(10) = "Las presentes  Condiciones Generales se rigen y han sido elaboradas en conformidad a las  disposiciones "
Lin(10) = Lin(10) & "del Capitulo VII del Titulo I  del  Compendio de Normas sobre Cambios Internacionales Del Banco Central "
Lin(10) = Lin(10) & "de Chile, vigentes a esta fecha y que las partes declaran conocer y entender plenamente. "

Lin(11) = "^SEGUNDO:^ El Cliente declara y acepta que las transacciones de CompraVenta, de Arbitrajes (Forwards)  y "
Lin(11) = Lin(11) & "de Permuta (Swaps), de moneda extranjera a futuro, implica el riesgo propio de la variación del tipo de "
Lin(11) = Lin(11) & "cambio y/o de la paridad de la divisa objeto del contrato, entre la Fecha de Celebración  y la Fecha de "
Lin(11) = Lin(11) & "Vencimiento del mismo, ambas definidas mas adelante. "

Lin(12) = "En consecuencia,  declara y acepta asimismo  que el carácter aleatorio  de las referidas transacciones, "
Lin(12) = Lin(12) & "implica el riesgo de que la diferencia entre el precio pactado en pesos moneda corriente nacional  y el "
Lin(12) = Lin(12) & "precio referencial de mercado,  que más adelante se define,  a la Fecha de Vencimiento de la respectiva "
Lin(12) = Lin(12) & "transacción,  podrá resultarle  adversa o favorable,  lo que ha  considerado  al convenir las presentes "
Lin(12) = Lin(12) & "Condiciones Generales así como al celebrar cada transacción regida por las mismas. "

Lin(13) = "^TERCERO:^ Definiciones:  Para todos  los  efectos de  aplicación  e  interpretación  de  las  presentes "
Lin(13) = Lin(13) & "Condiciones Generales,  así como de los términos y condiciones de cada Formulario de Confirmación,  los "
Lin(13) = Lin(13) & "términos  que  a continuación se indican,  cuando  se  expresen  con  mayúscula  tendrán  el  siguiente "
Lin(13) = Lin(13) & "significado: "

Lin(14) = "^a) Formulario de Confirmación o Confirmación:^ El documento  mediante  el cual las partes convienen  en "
Lin(14) = Lin(14) & "celebrar una o varias transacciones especificadas de CompraVenta o de Arbitraje (Forward) o de  Permuta "
Lin(14) = Lin(14) & " (Swap) de Moneda Extranjera a futuro, fijando los términos y condiciones de la o las mismas.       Cada "
Lin(14) = Lin(14) & "documento de  Confirmación  que las partes  suscriban, se entenderá  formar  parte  integrante  de  las "
Lin(14) = Lin(14) & "presentes Condiciones Generales. "

Lin(15) = "Cada  Confirmación  de  una  o  más  transacciones  especificas  acordadas  entre  las  partes,  deberá "
Lin(15) = Lin(15) & "documentarse  en un  'Formulario  de  Confirmación'  similar  al que contiene en el  'Anexo  A'  de las "
Lin(15) = Lin(15) & "presentes Condiciones Generales el cual se inserta al final y que forma parte integrante de las mismas. "

Lin(16) = "^b) Contradicción:^ En caso  de  contradicción  entre  un documento  de  Confirmación  y  las  presentes "
Lin(16) = Lin(16) & "Condiciones Generales, primaran los términos de la respectiva Confirmación. "

Lin(17) = "^c) Tipo de Transacción:^ CompraVenta, Arbitraje(Forward) y Permuta(Swap) de Moneda Extranjera a futuro: "

Lin(18) = "^c.1) CompraVenta:^ Aquella transacción en que el Vendedor se compromete a entregar la  Moneda Extranjera "
Lin(18) = Lin(18) & "vendida y el Comprador se obliga a pagar el precio convenido en pesos, moneda corriente nacional, o  en "
Lin(18) = Lin(18) & "Unidades de Fomento pagaderas por su equivalente en pesos,  moneda corriente nacional,  en la  Fecha de "
Lin(18) = Lin(18) & "Vencimiento acordada en la respectiva Confirmación. "

Lin(19) = "^c.2) Arbitraje o Forward:^ Aquella transacción  en que el Vendedor se compromete  a  entregar la Moneda "
Lin(19) = Lin(19) & "Extranjera vendida y el Comprador se obliga a  pagar el precio convenido  en  Dólares,  en la  Fecha de "
Lin(19) = Lin(19) & "Vencimiento estipulada en la respectiva Confirmación. "

Lin(20) = "^c.3) Permuta o Swap:^ Aquella transacción  en que las partes  intercambian  flujos  financieros  en dos "
Lin(20) = Lin(20) & "monedas diferentes, comprometiéndose una de ellas a entregar pesos, moneda corriente nacional, Unidades "
Lin(20) = Lin(20) & "de Fomento pagaderas por su equivalente en pesos,  moneda corriente nacional,  o Dólares  y  la otra  a "
Lin(20) = Lin(20) & "entregar la Moneda Extranjera, en la Fecha de Vencimiento especificadas en la respectiva  Confirmación. "

Lin(21) = "^d) Parte Vendedora o Vendedor y parte Compradora o Comprador:^"

Lin(22) = "^d.1) Vendedor:^ Aquella parte que se obliga a entregar a la otra, la Moneda Extranjera,  en la Fecha de "
Lin(22) = Lin(22) & "Vencimiento de la respectiva Confirmación."

Lin(23) = "El Vendedor deberá cumplir con las obligaciones  que le impone  el contrato  a la  Fecha de Vencimiento "
Lin(23) = Lin(23) & "pactada, de acuerdo al mecanismo que se haya convenido en la respectiva Confirmación, el que deberá ser "
Lin(23) = Lin(23) & "alguno de los que se indican a continuación : "

Lin(24) = "^i) Entrega:^ El Vendedor entregara la Moneda Extranjera en la Fecha de Vencimiento estipulada. "

Lin(25) = "En esta modalidad y para el caso que el Vendedor o Comprador fuere persona natural o jurídica residente "
Lin(25) = Lin(25) & "en Chile, la entrega de Moneda Extranjera quedara condicionada a que este demuestre a satisfacción  del "
Lin(25) = Lin(25) & "banco contraparte,  a  mas  tardar  el día hábil bancario  anterior  a la  Fecha de Vencimiento  de  la "
Lin(25) = Lin(25) & "transacción, que con dichas divisas realizara a través de dicho banco una operación de cambio expresada "
Lin(25) = Lin(25) & "en la misma Moneda Extranjera objeto del contrato,  por un monto igual  o  superior al estipulado en él "
Lin(25) = Lin(25) & "mismo."

Lin(26) = "En tal evento,  la entrega de Moneda Extranjera se efectuara  por el  Vendedor mediante  la  entrega de "
Lin(26) = Lin(26) & "cheque bancario girado sobre la ciudad de Nueva York, Estados Unidos de América  o mediante abono en la "
Lin(26) = Lin(26) & "cuenta corriente en esa misma moneda y que el Comprador hubiere indicado en la respectiva Confirmación. "

Lin(27) = "En esta modalidad,  si no se cumplieren  o  demostraren las condiciones antes referidas,  o si el monto "
Lin(27) = Lin(27) & "pactado  de la divisa  objeto  del  contrato fuere  superior  al  involucrado en la operación de cambio "
Lin(27) = Lin(27) & "demostrada  a  satisfacción de  'El Banco',  respecto del total en el primer caso  o  por el excedente en él "
Lin(27) = Lin(27) & "segundo,  el contrato  se cumplirá  mediante  el  mecanismo de  compensación  descrito en el  punto ii) "
Lin(27) = Lin(27) & "siguiente."

Lin(28) = "^ii) Compensación:^ En esta modalidad, el contrato se cumplirá pagando el Comprador al Vendedor, el monto "
Lin(28) = Lin(28) & "de la diferencia resultante entre el valor del Precio Referencial de mercado  acordado en la respectiva "
Lin(28) = Lin(28) & "Confirmación  vigente a la Fecha de Vencimiento  del  Contrato y el valor del precio pactado por las "
Lin(28) = Lin(28) & "partes ambos multiplicados por el monto de Moneda Extranjera objeto de la respectiva transacción, cuando "
Lin(28) = Lin(28) & "este sea superior a aquel."

Lin(29) = "En el caso contrario, el Vendedor pagara dicha diferencia al Comprador."

Lin(30) = "La compensación se efectuara siempre en pesos,  moneda corriente nacional,  mediante la entrega de vale "
Lin(30) = Lin(30) & "vista bancario de la plaza,  o  deposito en la cuenta corriente en pesos,  que la parte correspondiente "
Lin(30) = Lin(30) & "hubiere designado para tal efecto en la respectiva Confirmación."

Lin(31) = "^d.2) Comprador:^ Aquella parte  que se obliga  a  pagar a la otra el precio convenido en pesos,  moneda "
Lin(31) = Lin(31) & "corriente nacional, o en Unidades de Fomento por su equivalente en pesos, moneda corriente nacional, en "
Lin(31) = Lin(31) & "la Fecha de Vencimiento del contrato."

Lin(32) = "Para la aplicación de las disposiciones de la presente letra,  en las transacciones de  Permuta (Swaps) "
Lin(32) = Lin(32) & "de Moneda Extranjera  a  futuro,  se entenderá por Vendedor a aquella parte que se obliga a entregar la "
Lin(32) = Lin(32) & "Moneda Extranjera, y por Comprador,  a  aquella parte que se obliga a entregar pesos,  moneda corriente "
Lin(32) = Lin(32) & "nacional, o Unidades de Fomento. "

Lin(33) = "^e) Fecha de Vencimiento de la Transacción:^ La  fecha   que  las  partes  convienen  en  la  respectiva "
Lin(33) = Lin(33) & "Confirmación y en la cual deben cumplir sus respectivas obligaciones de Entrega o de Compensación de la "
Lin(33) = Lin(33) & "Moneda Extranjera vendida y pago del precio correspondiente. "

Lin(34) = "^f) Dólar:^ Es la moneda de curso legal en los Estados Unidos de América."

Lin(35) = "^g) Moneda Extranjera:^ Es la divisa cuya CompraVenta, Arbitraje (Forward)  o  Permuta (Swaps) es objeto "
Lin(35) = Lin(35) & "de la respectiva transacción pactada en cada Confirmación, distinta del Dólar. "

Lin(36) = "^h) Precio Referencial de Mercado:^ Es aquel que las partes convienen en cada Confirmación,  vigente a la "
Lin(36) = Lin(36) & "Fecha de Vencimiento de la respectiva transacción, que se aplicara al monto de Moneda Extranjera objeto "
Lin(36) = Lin(36) & "de dicha transacción, con el fin de expresar su valor en pesos moneda corriente nacional  y definir así "
Lin(36) = Lin(36) & "el precio final pactado. Este Precio Referencial podrá corresponder al Dólar Acuerdo, Dólar Observado o "
Lin(36) = Lin(36) & "o  al Dólar Interbancario,  todos los cuales se definen mas adelante,  según estipulen las partes en la "
Lin(36) = Lin(36) & "respectiva Confirmación."

Lin(37) = "^i) Cierre de Transacción:^ Instante  en el cual  ambas partes manifiestan su consentimiento y cierran a "
Lin(37) = Lin(37) & "firme una determinada transacción de  CompraVenta,  Arbitraje o Permuta  de Moneda Extranjera a futuro, "
Lin(37) = Lin(37) & "fijando las condiciones de la misma."

Lin(38) = "El cierre de transacción podrá verificarse en una cualquiera de las siguientes formas: verbalmente; por "
Lin(38) = Lin(38) & "vía  telefónica;  mediante  telex testeado;  o fax.  Sin  embargo,  cualquiera  sea  el  medio  de  los "
Lin(38) = Lin(38) & "anteriormente  indicados  que se  utilice,  las  partes  deberán  firmar el original del 'Formulario de "
Lin(38) = Lin(38) & "Confirmación ' correspondiente,  a mas tardar dentro de las 24 horas hábiles bancarias siguientes  a  la "
Lin(38) = Lin(38) & "Fecha de Celebración de dicha transacción. "

Lin(39) = "Para los efectos de la presente letra,  las partes aceptan y autorizan expresamente desde ya,  que  sus "
Lin(39) = Lin(39) & "conversaciones y comunicaciones telefónicas,  sean grabadas por la contraparte,  grabaciones que podrán "
Lin(39) = Lin(39) & "ser utilizadas como medio probatorio  en caso de controversia  a fin  de establecer la existencia de un "
Lin(39) = Lin(39) & "cierre de Transacciones y/o las condiciones precisas de dicho cierre. "

Lin(40) = "^j) Fecha de Celebración:^ Es la fecha en que las partes cierran una transacción determinada."

Lin(41) = "^k) Dólar Acuerdo:^ Es la cantidad de pesos, moneda corriente nacional, necesarios para comprar un Dólar "
Lin(41) = Lin(41) & "y  que fija  y determina  el Banco Central de Chile,  conforme al N° 7 del Capitulo I del Titulo I  del "
Lin(41) = Lin(41) & "Compendio de Normas de Cambios Internacionales.     Si por cualquier causa el referido Dólar acuerdo no "
Lin(41) = Lin(41) & "existiere en la Fecha de Vencimiento respectiva,  se aplicara en su defecto el Tipo de Cambio que a esa "
Lin(41) = Lin(41) & "fecha se aplique  a  los Pagares emitidos en conformidad al Capitulo XIX  del  Titulo I  del  Compendio "
Lin(41) = Lin(41) & "recién aludido,  de las series  PCDUS$A  o  PCDUS$B.    Si tampoco pudiere determinarse este ultimo por "
Lin(41) = Lin(41) & "cualquier causa, se aplicara el Tipo de Cambio promedio informado en la Fecha de Vencimiento respectiva, "
Lin(41) = Lin(41) & "por el Banco Central de Chile como aplicable a sus propias operaciones.      Si se informaren distintas "
Lin(41) = Lin(41) & "cotizaciones para compra y venta, se aplicara el promedio aritmético entre ambas.  A falta de todos los "
Lin(41) = Lin(41) & "anteriores,  se aplicara el  Tipo de Cambio  Dólar  Observado  existente  a  la  fecha  del  respectivo "
Lin(41) = Lin(41) & "vencimiento."

Lin(42) = "^l) Dólar Interbancario:^ Es la cantidad de pesos, moneda corriente nacional,  necesaria para comprar un "
Lin(42) = Lin(42) & "Dólar,  según se informe en la pagina  CHLE  del  REUTERS, a las o alrededor de las 11:00 horas A.M. de "
Lin(42) = Lin(42) & "Santiago de Chile, y que corresponde a aquel que utilizan los bancos comerciales autorizados para operar "
Lin(42) = Lin(42) & "en Chile, para las compras y ventas de dólares que celebran entre ellos. "

Lin(43) = "^m) Dólar Observado:^ Es la cantidad de  pesos,  moneda corriente nacional,  necesaria para  comprar  un "
Lin(43) = Lin(43) & "Dólar, publicado por el Banco Central de Chile, en conformidad a lo dispuesto en el N° 6 del Capitulo I "
Lin(43) = Lin(43) & "del Titulo I del Compendio de normas de Cambios Internacionales, en la Fecha de Vencimiento respectiva. "
Lin(43) = Lin(43) & "Si por cualquier causa dejare de publicarse el  Dólar Observado en la Fecha de Vencimiento  respectiva, "
Lin(43) = Lin(43) & "se  aplicara  el  Tipo de Cambio  promedio  informado en dicha  fecha por el  Banco  Central  de  Chile "
Lin(43) = Lin(43) & "como aplicable  a las operaciones bancarias  de compra y venta de  Dólares,  realizadas por los  bancos "
Lin(43) = Lin(43) & "autorizados para operar en el mercado chileno. Si se informaren distintas cotizaciones para la compra y "
Lin(43) = Lin(43) & "venta, se aplicara el promedio aritmético entre ambas.    Si tampoco se informare el tipo Cambio recién "
Lin(43) = Lin(43) & "referido,  se aplicara en su defecto el  Tipo de Cambio promedio  informado por Citicorp-Chile y que se "
Lin(43) = Lin(43) & "publique en el diario El Mercurio de Santiago en la fecha inmediatamente anterior a la respectiva Fecha "
Lin(43) = Lin(43) & "de Vencimiento. "

Lin(44) = "A falta de todos los anteriores, se aplicara el promedio aritmético entre el precio del Dólar comprador "
Lin(44) = Lin(44) & "y  vendedor ofrecidos a publico en la respectiva Fecha de Vencimiento,  por las oficinas principales de "
Lin(44) = Lin(44) & "los bancos y @BANCO y sus sucursales en Chile "

Lin(45) = "^n) Tipo de Cambio:^ Es la cantidad de pesos, moneda corriente nacional, necesaria para adquirir un Dólar "
Lin(45) = Lin(45) & "de los Estados Unidos de América. "

Lin(46) = "^ñ) Paridad de la moneda extranjera o Paridad:^ Es la  cantidad  de  Moneda  Extranjera  necesaria  para "
Lin(46) = Lin(46) & "comprar un Dólar. "

Lin(47) = "^o) Precio Referencial de Paridad:^ Es aquel que en la respectiva  Fecha de Vencimiento  corresponda  al "
Lin(47) = Lin(47) & "precio Spot de la Moneda Extranjera de que se trate, por un Dólar o viceversa,  según la cotización que "
Lin(47) = Lin(47) & "se informe en la pagina WRLD de REUTERS a las o alrededor de las 11:00 horas A.M. de Santiago de Chile. "

Lin(48) = "Precio Spot: Se entiende por tal el  precio contado  de mercado que tiene una Moneda Extranjera  o  el "
Lin(48) = Lin(48) & "Dólar en la respectiva Fecha de Vencimiento, a la Paridad o Tipo de Cambio, según corresponda."

Lin(49) = "^CUARTO:^ Causales de Terminación Anticipada : La verificación  en cualquier tiempo durante  la vigencia "
Lin(49) = Lin(49) & "de este contrato,  de uno cualquiera de los hechos que se indican a continuación,  facultara a la parte "
Lin(49) = Lin(49) & "afectada para exigir la terminación anticipada de una, varias o todas las transacciones de Compraventa, "
Lin(49) = Lin(49) & "Arbitraje (Forward) y/o Permuta(Swap), de Moneda Extranjera a futuro, vigentes entre ellas y pendientes "
Lin(49) = Lin(49) & "de vencimiento:"

Lin(50) = "^a)^ La falta de cumplimiento integro y oportuno de una cualquiera de las obligaciones que le impongan  y "
Lin(50) = Lin(50) & "a que resulte obligada sea por estas Condiciones Generales y/o por la o las respectivas Confirmaciones; "

Lin(51) = "^b)^ Si se declarare la quiebra o liquidación  y/o  se decretare por autoridad competente la intervención "
Lin(51) = Lin(51) & "de una de las partes contratantes; si se presentaren proposiciones de convenio extrajudicial o judicial "
Lin(51) = Lin(51) & "preventivo a sus o por sus acreedores;  si cayere en cesación de pagos u ocurriese cualquier otro hecho "
Lin(51) = Lin(51) & "que comprometa seriamente su solvencia; "

Lin(52) = "^c)^ Si una de las partes se disuelve y/o entra en proceso de liquidación;"

Lin(53) = "^d)^ Si una de las partes transfiere la totalidad  o  parte importante de sus  bienes necesarios  para el "
Lin(53) = Lin(53) & "desarrollo de su giro, sin previo consentimiento escrito de la contraparte; "

Lin(54) = "^e)^ Si una de las partes dejare de cumplir el tiempo  y forma una cualquiera de sus obligaciones de pago "
Lin(54) = Lin(54) & "para con la otra y/o se produjere la exigibilidad anticipada de la misma sea de acuerdo a la ley y/o de "
Lin(54) = Lin(54) & "acuerdo a las estipulaciones de los documentos en que estuviere expresada. "

Lin(55) = "Respecto de 'El Banco',  esta causal se  verificara  también cuando dicho  incumplimiento  y/o  exigibilidad "
Lin(55) = Lin(55) & "anticipada se produzca en relación a cualquiera "
Lin(55) = Lin(55) & "de sus subsidiarias con domicilio en Chile o el extranjero,  especialmente cualquier agencia o sucursal "
Lin(55) = Lin(55) & "de @BANCO"

Lin(56) = "En el evento de que proceda la terminación anticipada de acuerdo a lo estipulado en esta cláusula,  las "
Lin(56) = Lin(56) & "transacciones pendientes se liquidaran de inmediato anticipando en consecuencia  la Fecha de Vencimiento "
Lin(56) = Lin(56) & "originalmente pactada, en base a los precios, Paridades o  Tipos de Cambio Referenciales  acordados  en "
Lin(56) = Lin(56) & "las respectivas Confirmaciones y que estén vigentes a la fecha de dicha liquidación."

Lin(57) = "Siempre y en todo caso,  la parte afectada, tendrá y mantendrá el derecho de ser plenamente indemnizada "
Lin(57) = Lin(57) & "por  la  contratare  de toda perdida  o  perjuicio  que  sufriere  a  consecuencia  de la  terminación "
Lin(57) = Lin(57) & "anticipada,  lo que se determinara una vez  que se verifique  la  Fecha  de  Vencimiento  originalmente "
Lin(57) = Lin(57) & "pactada para la respectiva Confirmación. "

Lin(58) = "En el evento de que a la  Fecha de Vencimiento  originalmente  pactada  en la  respectiva  Confirmación "
Lin(58) = Lin(58) & "resultaren diferencias en contra de la parte afectada, esta no será obligada a pago ni devolución alguna "
Lin(58) = Lin(58) & "a la  contraparte,  reteniendo  íntegramente  dicho beneficio para si a  titulo de pena,  la  que  será "
Lin(58) = Lin(58) & "compatible y exigible conjuntamente con cualquiera otra indemnización que fuere procedente,  de acuerdo "
Lin(58) = Lin(58) & "al presente contrato o la ley, en conformidad al articulo 1.537 del Código Civil."

Lin(59) = "Se deja expresa constancia que la aplicación de la  terminación anticipada de que se  trata esta letra, "
Lin(59) = Lin(59) & "son  facultativas  para  la  parte  afectada  y  establecidas  en su  exclusivo beneficio,  pudiendo en "
Lin(59) = Lin(59) & "consecuencia a su absoluto y exclusivo arbitrio,  ejercerlas  o  perseverar en la  o  las transacciones "
Lin(59) = Lin(59) & "pendientes,  sin perjuicio  de su  derecho  de ser plenamente  indemnizada  de todo  daño,  menoscabo o "
Lin(59) = Lin(59) & "perjuicio que sufriere."

Lin(60) = "^QUINTO:^ Mora o simple retardo : En caso de mora o simple retardo por unas de las partes en cumplir con "
Lin(60) = Lin(60) & "las  obligaciones  de  pago que le  imponen las  presentes  Condiciones  Generales  y  las  respectivas "
Lin(60) = Lin(60) & "Confirmaciones, la parte incumplidora se obliga a pagar a la contraparte,  intereses penales calculados "
Lin(60) = Lin(60) & "sobre el monto de la respectiva obligación,  en razón  de la tasa máxima permitida estipular por la ley "
Lin(60) = Lin(60) & "para operaciones de crédito de dinero reajustables en moneda extranjera,  vigente durante el tiempo  de "
Lin(60) = Lin(60) & "la mora o simple retardo y hasta el día de pago efectivo. "

Lin(61) = "^SEXTO:^ Vigencia: El presente contrato sobre Condiciones Generales de Compraventa  a  futuro de Moneda "
Lin(61) = Lin(61) & "Extranjera regirá a contar de esta fecha y tendrá duración indefinida."

Lin(62) = "En consecuencia,  estas  Condiciones Generales  se aplicaran a todas las transacciones de  Compraventa, "
Lin(62) = Lin(62) & "Arbitraje (Forwards) y/o Permuta (Swaps) de moneda Extranjera  a Futuro que celebren las partes,  salvo "
Lin(62) = Lin(62) & "que en la respectiva transacción las partes dispongan expresamente otra cosa."

Lin(63) = "Sin perjuicio de lo anterior,  cualquiera de las partes podrá poner termino a este contrato avisando  a "
Lin(63) = Lin(63) & "la otra por escrito con a lo menos 30 días hábiles bancarios de anticipación. En todo caso, dicho aviso "
Lin(63) = Lin(63) & "no afectara a las transacciones ya efectuadas  y  pendientes de vencimiento,  a  las  cuales  le  serán "
Lin(63) = Lin(63) & "plenamente aplicables estas Condiciones Generales,  en cuanto las partes no hubieren dispuesto de común "
Lin(63) = Lin(63) & "acuerdo otra cosa."

Lin(64) = "^SEPTIMO:^ Transferibilidad: Los derechos  y  obligaciones que emanan para las partes de las  presentes "
Lin(64) = Lin(64) & "Condiciones Generales,  así como de las Confirmaciones que celebren a su amparo,  no  son  cesibles  ni "
Lin(64) = Lin(64) & "transferibles a terceros, ni por endoso ni en ninguna otra forma. "

Lin(65) = "No obstante lo anterior,  una o ambas partes podrán ceder sus derechos  y  obligaciones emanados de las "
Lin(65) = Lin(65) & "presentes Condiciones Generales y respecto de una o más de las Confirmaciones vigentes entre ellas,  de "
Lin(65) = Lin(65) & "común acuerdo manifestado en forma expresa por escrito en los dos ejemplares de la o las Confirmaciones "
Lin(65) = Lin(65) & "respectivas y en dos copias de estas Condiciones Generales, debidamente firmada."

Lin(66) = "^OCTAVO:^ Pago Con Documentos: Se deja  expresa constancia que los pagos efectuados con documentos,  no "
Lin(66) = Lin(66) & "causaran novación de las obligaciones, si dichos documentos no fueren pagados al presentarlos a cobro."

Lin(67) = "^NOVENO:^ Arbitraje: Cualquier duda, controversia o disputa que surgiere entre las partes con motivo de "
Lin(67) = Lin(67) & "la vigencia,  validez,  aplicación  o  interpretación del  presente contrato  y/o  de  las  respectivas "
Lin(67) = Lin(67) & "Confirmaciones amparadas bajo el mismo, serán conocidas y resueltas sin ulterior recurso por un arbitro "
Lin(67) = Lin(67) & "arbitrador, el cual conocerá de acuerdo al procedimiento que dicho arbitro establezca y fallara conforme "
Lin(67) = Lin(67) & "a lo que su prudencia y equidad determinen."

Lin(68) = "Para tal efecto,  las partes designan en este acto a don @ARBITRO1  y  si este no pudiese por "
Lin(68) = Lin(68) & "cualquier causa o no quisiese desempeñar el cargo o se imposibilitase durante su cometido,  las  partes "
Lin(68) = Lin(68) & "designan en su reemplazo a don @ARBITRO2. "
Lin(68) = Lin(68) & "Si este ultimo por cualquier causa no pudiese o no aceptare desempeñar el encargo  o  se imposibilitare "
Lin(68) = Lin(68) & "durante su cometido, el arbitro será designado de común acuerdo por las partes. "

Lin(69) = "A falta  de  dicho  acuerdo,  el arbitro será designado por los tribunales ordinarios de justicia de la "
Lin(69) = Lin(69) & "ciudad y comuna de Santiago, debiendo conocer y fallar conforme a Derecho.    Dicho nombramiento deberá "
Lin(69) = Lin(69) & "recaer en un  ex ministro  de  Corte de Apelaciones,  Corte Suprema,  o actual ex abogado integrante de "
Lin(69) = Lin(69) & "alguno de dichos tribunales. "

Lin(70) = "El presente documento se firma en dos ejemplares de idéntico tenor  y  data,  quedando uno en poder  de "
Lin(70) = Lin(70) & "cada parte."

Lin(71) = "                     ---------------------------                 ----------------------------- "
Lin(72) = "                                @BANCO                                      @CLIENTE"


    
Lin(4) = BacRemplazar(Lin(4), "@BANCO", DatCont(1))
Lin(6) = BacRemplazar(Lin(6), "@CLIENTE", DatCont(8))

Lin(7) = BacRemplazar(Lin(7), "@CIUDAD", DatCont(16))
Lin(7) = BacRemplazar(Lin(7), "@FECHACIERRE", DatCont(15))
Lin(7) = BacRemplazar(Lin(7), "@BANCO", DatCont(1))
Lin(7) = BacRemplazar(Lin(7), "@SUCURSAL", "Sucursal en Chile")
Lin(7) = BacRemplazar(Lin(7), "@REPBANCO1", DatCont(3))
Lin(7) = BacRemplazar(Lin(7), "@RUTREPBCO1", DatCont(4))
Lin(7) = BacRemplazar(Lin(7), "@REPBANCO2", DatCont(5))
Lin(7) = BacRemplazar(Lin(7), "@RUTREPBCO2", DatCont(6))
Lin(7) = BacRemplazar(Lin(7), "@DIRBANCO", DatCont(7))
Lin(7) = BacRemplazar(Lin(7), "@NOMBRECLIENTE", DatCont(8))
Lin(7) = BacRemplazar(Lin(7), "@REPCLIENTE1", DatCont(10))
Lin(7) = BacRemplazar(Lin(7), "@RUTREPCLI1", DatCont(11))
Lin(7) = BacRemplazar(Lin(7), "@REPCLIENTE2", DatCont(12))
Lin(7) = BacRemplazar(Lin(7), "@RUTREPCLI2", DatCont(13))
Lin(7) = BacRemplazar(Lin(7), "@DIRCLIENTE", DatCont(14))
Lin(55) = BacRemplazar(Lin(55), "@BANCO", DatCont(1))
Lin(68) = BacRemplazar(Lin(68), "@ARBITRO1", DatCont(3))
Lin(68) = BacRemplazar(Lin(68), "@ARBITRO2", DatCont(10))
Lin(72) = BacRemplazar(Lin(72), "@BANCO", DatCont(1))
Lin(72) = BacRemplazar(Lin(72), "@CLIENTE", DatCont(8))


Lin(4) = BacFormatearTexto(Lin(4), 3, 0, 0, 0, 88)
Lin(6) = BacFormatearTexto(Lin(6), 3, 0, 0, 0, 88)

 nTab = 8
 nFila = 2
 BacGlbSetPrinter 65, 80, 1, 1
 'BacGlbSetFont CourierNew, 10, True
Printer.FontBold = True
 For i = 1 To 6
    nFila = nFila + 1
    BacGlbPrinter nFila, 1, nTab, 1, Lin(i), 0, 1
    
 Next

nTab = 12

nFila = nFila + 1
BacGlbPrinter nFila, 1, nTab, 1, Lin(0), 0, 1
Printer.FontBold = False
'BacGlbSetFont CourierNew, 10, False
    
For i = 7 To 70
    nFila = nFila + 1
    BacGlbPrinter nFila, 1, nTab, 1, Lin(0), 0, 1

    BacCentraTexto aString(), Lin(i), 80

    For nCont = 1 To UBound(aString())
        
        nFila = nFila + 1
       
        If nFila = 65 Then
            nFila = 4
            Printer.NewPage
        End If
        sTexto = aString(nCont)
        For nCont2 = 1 To Len(sTexto)
            cCaracter = Mid(sTexto, nCont2, 1)
            
            If cCaracter = "^" Then
                Printer.FontBold = IIf(Printer.FontBold = False, True, False)
                cCaracter = " "
            End If
            
            BacGlbPrinter nFila, 1, nTab - 1 + nCont2, 1, cCaracter, 0, 1
        Next
    Next
Next

nFila = nFila + 1
BacGlbPrinter nFila, 1, nTab, 1, Lin(0), 0, 1
nFila = nFila + 1
BacGlbPrinter nFila, 1, nTab, 1, Lin(0), 0, 1
nFila = nFila + 1
BacGlbPrinter nFila, 1, nTab, 1, Lin(0), 0, 1
nFila = nFila + 1
BacGlbPrinter nFila, 1, nTab, 1, Lin(0), 0, 1
nFila = nFila + 1
BacGlbPrinter nFila, 1, nTab, 1, Lin(71), 0, 1
nFila = nFila + 1
BacGlbPrinter nFila, 1, nTab, 1, Lin(72), 0, 1

Printer.NewPage
BacGlbPrinterEnd

End Function

Function BacContratoSwapMonedaBanco(DatosCond(), NumOper, Donde) As Boolean
   On Error GoTo Control:
   Dim Doc2             As Word.Document
   Dim SQL              As String
   Dim i                As Integer
   Dim total            As Integer
   Dim NemoMon          As String
   Dim NemoMon1         As String
   Dim Paso             As String
   Dim Glosa            As String
   Dim Okk              As Boolean
   Dim ClsMoneda        As Object
   Dim contadorlineas
   Dim A, m
   Dim Datos()
   Dim Contrato()

   Set ClsMoneda = New ClsMoneda

   Dim NombreCliente    As String
   Dim FechaCondiciones As String
   
   Let NombreCliente = Trim(BacContratoSwap.grdLista.TextMatrix(BacContratoSwap.grdLista.Row, 2))
   Let FechaCondiciones = BacContratoSwap.grdLista.TextMatrix(BacContratoSwap.grdLista.Row, 12)

   If Year(CDate(FechaCondiciones)) = "1900" Or Len(FechaCondiciones) = 0 Then
      MsgBox "No se han emitido condiciones generales para el cliente " & vbCrLf & NombreCliente
      Exit Function
   End If
    
Imprimir:
    Set Doc2 = IniciaWordListadoLog("ContratoMonedasBanco", Okk)
    
    If Not Okk Then
        MsgBox "No podra ser Generado el contrato!", vbCritical, Msj
        BacContratoMonedasTasaBanco = False
        Set ClsMoneda = Nothing
        Exit Function
    End If
  
    Doc2.Activate
    
     Doc2.Bookmarks("Folio").Select
     Doc2.Application.Selection.Text = NumOper
    
    Doc2.Bookmarks("Dia").Select
    Doc2.Application.Selection.Text = DatosCond(12)
    Doc2.Bookmarks("Mes").Select
    Doc2.Application.Selection.Text = DatosCond(13)
    Doc2.Bookmarks("Año").Select
    Doc2.Application.Selection.Text = DatosCond(14)

    Doc2.Bookmarks("NomBco").Select
    Doc2.Application.Selection.Text = DatosCond(1)
     Doc2.Bookmarks("banco").Select
    Doc2.Application.Selection.Text = DatosCond(1)
    
    Doc2.Bookmarks("fecha_cond_gnrales").Select
    Doc2.Application.Selection.Text = BacFormatoFecha("DDMMAA", BacContratoSwap.grdLista.TextMatrix(BacContratoSwap.grdLista.Row, 12))
    
     Doc2.Bookmarks("banco1").Select
    Doc2.Application.Selection.Text = DatosCond(1)
    
   
    
'    Doc2.Bookmarks("RutBco").Select
'    Doc2.Application.Selection.Text = DatosCond(2)
    Doc2.Bookmarks("RepBco").Select
    Doc2.Application.Selection.Text = DatosCond(3)

   If Len(Trim(DatosCond(21))) > 0 Then
    Doc2.Bookmarks("RutRepBco").Select
    Doc2.Application.Selection.Text = DatosCond(4) & " y don " & DatosCond(21) & " cédula de identidad N° " & DatosCond(22)

   Else
    Doc2.Bookmarks("RutRepBco").Select
    Doc2.Application.Selection.Text = DatosCond(4)

   End If

    Doc2.Bookmarks("DireccBco").Select
    Doc2.Application.Selection.Text = gsc_Parametros.direccion
'    Doc2.Bookmarks("NomBco1").Select
'    Doc2.Application.Selection.Text = DatosCond(1)
    Doc2.Bookmarks("NomCli").Select
    Doc2.Application.Selection.Text = DatosCond(6)
    
    Doc2.Bookmarks("cliente").Select
    Doc2.Application.Selection.Text = DatosCond(6)
    
    Doc2.Bookmarks("cliente1").Select
    Doc2.Application.Selection.Text = DatosCond(6)
'    Doc2.Bookmarks("RutCli").Select
'    Doc2.Application.Selection.Text = DatosCond(7)
    Doc2.Bookmarks("RepCli").Select
    Doc2.Application.Selection.Text = DatosCond(8)

   If Len(Trim(DatosCond(23))) > 0 Then
    Doc2.Bookmarks("RutRepCli").Select
    Doc2.Application.Selection.Text = DatosCond(9) & " y don " & DatosCond(23) & " cédula de identidad N° " & DatosCond(24)
   Else
    Doc2.Bookmarks("RutRepCli").Select
    Doc2.Application.Selection.Text = DatosCond(9)
   End If
    Doc2.Bookmarks("DireccCli").Select
    Doc2.Application.Selection.Text = DatosCond(10)
'    Doc2.Bookmarks("NomCli1").Select
'    Doc2.Application.Selection.Text = DatosCond(6)

'    Doc2.Bookmarks("DiaCond").Select
'    Doc2.Application.Selection.Text = DatosCond(31)
'    Doc2.Bookmarks("MesCond").Select
'    Doc2.Application.Selection.Text = DatosCond(32)
'    Doc2.Bookmarks("AñoCond").Select
'    Doc2.Application.Selection.Text = DatosCond(33)


    Doc2.Bookmarks("NomBco3").Select
    Doc2.Application.Selection.Text = DatosCond(1)
    Doc2.Bookmarks("NomCli3").Select
    Doc2.Application.Selection.Text = DatosCond(6)

    Doc2.Bookmarks("CambioRef").Select
    Doc2.Application.Selection.Text = "Dolar Observado"
    
    Doc2.Bookmarks("Lugar").Select
    Doc2.Application.Selection.Text = "SANTIAGO"

   

    Doc2.Bookmarks("NomBco4").Select
    Doc2.Application.Selection.Text = DatosCond(1)
    Doc2.Bookmarks("NomCli4").Select
    Doc2.Application.Selection.Text = DatosCond(6)
    
    contadorlineas = 1
    A = 1

'// 12/05/2008 - Se agrega datos al sp_DatosContrato
    'ReDim Preserve Contrato(43, 1) ''REQ.7904
    ReDim Preserve Contrato(45, 1)
    For i = 1 To 45
        Contrato(i, 1) = "**"
    Next

   'SQL = "EXECUTE SP_DATOSCONTRATO " & NumOper
   SQL = "EXECUTE SP_DATOSCONTRATO_TODOSFLUJOS " & NumOper
   If MISQL.SQL_Execute(SQL$) = 0 Then
       i = 1
       While MISQL.SQL_Fetch(Datos()) = 0
            ReDim Preserve Contrato(45, i)
            
            Contrato(1, i) = Datos(1)   'Tipo_operacion
            Contrato(2, i) = Datos(2)   'MontoOperacion
            Contrato(3, i) = Datos(3)   'TasaConversion
            Contrato(4, i) = Datos(4)   'Modalidad
            Contrato(5, i) = Datos(5)   'fechainicioflujo
            Contrato(6, i) = Datos(6)   'fechavenceflujo
            Contrato(7, i) = Datos(7)   'dias
            Contrato(8, i) = BacStrTran((Datos(8)), ".", gsc_PuntoDecim)    'compra_valor_tasa
            Contrato(9, i) = BacStrTran((Datos(9)), ".", gsc_PuntoDecim)    'venta_valor_tasa
            Contrato(10, i) = Datos(10) 'nombretasacompra
            Contrato(11, i) = Datos(11) 'nombretasaventa
            Contrato(12, i) = Datos(12) 'pagamosdoc
            Contrato(13, i) = Datos(13) 'recibimosdoc
            Contrato(14, i) = Datos(14) 'numero_flujo
            Contrato(15, i) = BacStrTran((Datos(15)), ".", gsc_PuntoDecim)  'compra_capital
            Contrato(16, i) = BacStrTran((Datos(16)), ".", gsc_PuntoDecim)  'compra_amortiza
            Contrato(17, i) = BacStrTran((Datos(17)), ".", gsc_PuntoDecim)  'compra_saldo
            Contrato(17, i) = CDbl(Contrato(16, i)) + CDbl(Contrato(17, i))
            Contrato(18, i) = Datos(18) 'compra_interes
            Contrato(19, i) = Datos(19) 'compra_spread
            Contrato(20, i) = Datos(20) 'venta_capital
            Contrato(21, i) = BacStrTran((Datos(21)), ".", gsc_PuntoDecim)  'venta_amortiza
            Contrato(22, i) = BacStrTran((Datos(22)), ".", gsc_PuntoDecim)  'venta_saldo
            Contrato(22, i) = CDbl(Contrato(21, i)) + CDbl(Contrato(22, i))
            Contrato(23, i) = Datos(23) 'venta_interes
            Contrato(24, i) = Datos(24) 'venta_spread
            Contrato(25, i) = Datos(25) 'pagamos_moneda
            Contrato(26, i) = Datos(26) 'recibimos_moneda
            Contrato(27, i) = Datos(27) 'tipo_flujo
            Contrato(28, i) = Datos(28) 'Compra_Moneda
            Contrato(29, i) = Datos(29) 'Venta_Moneda
            Contrato(30, i) = Datos(30) 'Compra_Capital
            Contrato(31, i) = Datos(31) 'Venta_Capital
            Contrato(32, i) = Datos(32) 'nemo_compra_moneda
            Contrato(33, i) = Datos(33) 'nemo_venta_moneda
            Contrato(34, i) = Datos(34) 'valuta
            Contrato(35, i) = Datos(35) 'Estado_Flujo
            Contrato(36, i) = Datos(36) 'Amortiza
            Contrato(37, i) = Datos(37) 'Fecha Fijación Tasa
            Contrato(38, i) = Datos(38) 'Fecha Liquidación
            Contrato(39, i) = Datos(39) 'nemo_Pagamos_moneda
            Contrato(40, i) = Datos(40) 'nemo_Recibimos_moneda
            Contrato(41, i) = Datos(41) 'TituloModComp, para cuando la modalidad es Compensación
            Contrato(42, i) = Datos(42) 'TituloModEF_1, para cuando la modalidad es Entrega Física
            Contrato(43, i) = Datos(43) 'TituloModEF_2, para cuando la modalidad es Entrega Física continuación
            Contrato(44, i) = Datos(46) 'CompraGlosaBase ''REQ.7904
            Contrato(45, i) = Datos(47) 'VentaGlosaBase ''REQ.7904
            i = i + 1
       Wend
       i = i - 1
    Else
        MsgBox "Datos necesarios para generar Contrato no han sido encontrados !!", vbCritical, Msj
        Set Doc2 = Nothing
        Set ClsMoneda = Nothing
        Exit Function
    
    End If
    total = i
    '******
    
     Doc2.Bookmarks("ValutaPago").Select
     Doc2.Application.Selection.Text = "T + " & Contrato(34, i)
                
     If Contrato(36, i) <> "" Then
        Doc2.Bookmarks("InterNoc").Select
        Doc2.Application.Selection.Text = Contrato(36, i)
     End If

    Doc2.Bookmarks("FechaVenc").Select
    Doc2.Application.Selection.Text = Contrato(6, i)
    
    Doc2.Bookmarks("ParidadRef").Select
    Doc2.Application.Selection.Text = IIf(UCase(Datos(1)) = "C" And Datos(32) = 998, "UNIDAD DE FOMENTO DEL DIA DEL VCTO.", "N/A") '"N/A"

    
    Doc2.Bookmarks("FechaIni").Select
    Doc2.Application.Selection.Text = DatosCond(27)

    Doc2.Bookmarks("FormaPago").Select
    Doc2.Application.Selection.Text = "MONEDA NACIONAL: " & IIf((Contrato(12, i) <> ""), (Contrato(12, i)), "N/A")
    
    Doc2.Bookmarks("FormaPago2").Select
    Doc2.Application.Selection.Text = "MONEDA EXTRANJERA: " & IIf((Contrato(13, i) <> ""), (Contrato(13, i)), "N/A")
    
    
    

    If Contrato(1, 1) = "C" Then
        Glosa = Contrato(11, 1)
    Else
        Glosa = Contrato(10, 1)
    End If

    If Datos(7) >= 30 And Datos(7) < 41 Then
        Glosa = Glosa & " 30 DIAS"
    ElseIf Datos(7) >= 90 And Datos(7) < 101 Then
        Glosa = Glosa & " 90 DIAS"
    ElseIf Datos(7) >= 180 And Datos(7) < 191 Then
        Glosa = Glosa & " 180 DIAS"
    ElseIf Datos(7) >= 360 Then
        Glosa = Glosa & " 360 DIAS"
    End If

    For m = 1 To total

''        If contrato(27, m) = 2 And contrato(14, m) = 1 Then
'// 12/05/2008 - Se cambia el numero de flujo =1 por flujo vigente, ya que no siempre existirá el flujo N°1
        If Contrato(27, m) = 2 And Contrato(35, m) = 1 Then
            Call ClsMoneda.LeerxCodigo(CInt(Contrato(29, m)))
            NemoMon1 = ClsMoneda.mnnemo
            Doc2.Bookmarks("NomBco2").Select
            Doc2.Application.Selection.Text = DatosCond(1) & ":   " & NemoMon1 & " " & Format(Contrato(31, m), "###,###,###,##0.###0")
            Doc2.Bookmarks("TasaBco").Select

            If Contrato(11, m) = "FIJA" Then
                Doc2.Application.Selection.Text = Format(Contrato(9, m), "###0.###0") & " % "
                Doc2.Bookmarks("FijaVarBco").Select
                Doc2.Application.Selection.Text = Contrato(11, m)

                ''REQ.7904
                Doc2.Bookmarks("BaseBco").Select
                Doc2.Application.Selection.Text = "Base Cálculo " & Contrato(45, m)

            Else
                Doc2.Application.Selection.Text = Contrato(11, m) & " + " & Format(Contrato(24, m), "###0.###0") & " %"
                Doc2.Bookmarks("FijaVarBco").Select
                Doc2.Application.Selection.Text = Contrato(11, m) & " + SPREAD"

                ''REQ.7904
                Doc2.Bookmarks("BaseBco").Select
                Doc2.Application.Selection.Text = "Base Cálculo " & Contrato(45, m)

            End If

        End If
   

''        If contrato(27, m) = 1 And contrato(14, m) = 1 Then
'// 12/05/2008 - Se cambia el numero de flujo =1 por flujo vigente, ya que no siempre existirá el flujo N°1
        If Contrato(27, m) = 1 And Contrato(35, m) = 1 Then
            Call ClsMoneda.LeerxCodigo(CInt(Contrato(28, m)))
            NemoMon = ClsMoneda.mnnemo
            Doc2.Bookmarks("NomCli2").Select
            Doc2.Application.Selection.Text = DatosCond(6) & ":   " & NemoMon & " " & Format(Contrato(30, m), "###,###,###,##0.###0")
            Doc2.Bookmarks("TasaCli").Select

            If Contrato(10, m) = "FIJA" Then
                Doc2.Application.Selection.Text = Format(Contrato(8, m), "###0.###0") & " % "
                Doc2.Bookmarks("FijaVarCli").Select
                Doc2.Application.Selection.Text = Contrato(10, m)
                
                ''REQ.7904
                Doc2.Bookmarks("BaseCli").Select
                Doc2.Application.Selection.Text = "Base Cálculo " & Contrato(44, m)
            Else
                Doc2.Application.Selection.Text = Contrato(10, m) & " + " & Format(Contrato(19, m), "###0.###0") & " %"
                Doc2.Bookmarks("FijaVarCli").Select
                Doc2.Application.Selection.Text = Contrato(10, m) & " + SPREAD"
             
                ''REQ.7904
                Doc2.Bookmarks("BaseCli").Select
                Doc2.Application.Selection.Text = "Base Cálculo " & Contrato(44, m)
            End If

        End If


    Next
    
    Doc2.Application.Visible = True

    'Grilla Recibimos
    For m = 1 To total
        Doc2.Bookmarks("GrillaCli").Select

        If contadorlineas >= 1 And Contrato(27, m) = 1 Then
            Doc2.Application.Selection.MoveDown Unit:=wdLine, Count:=A
            Doc2.Bookmarks.Add Name:="Prueba", Range:=Doc2.Application.Selection.Range
            Doc2.Bookmarks("Prueba").Select
            A = A + 1
        End If

        If Contrato(27, m) = 1 Then
           Doc2.Application.Selection.Text = Contrato(37, m)
           Doc2.Application.Selection.MoveRight Unit:=wdCell
           Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
           
           Doc2.Application.Selection.Text = Contrato(5, m)
           Doc2.Application.Selection.MoveRight Unit:=wdCell
           Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
           

           Doc2.Application.Selection.Text = Contrato(38, m)
           Doc2.Application.Selection.MoveRight Unit:=wdCell
           Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft

           Doc2.Application.Selection.Text = Contrato(7, m)
           Doc2.Application.Selection.MoveRight Unit:=wdCell
           Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphCenter

           Doc2.Application.Selection.Text = NemoMon & " " & Format((Contrato(17, m)), "###,###,###,##0.###0")
           Doc2.Application.Selection.MoveRight Unit:=wdCell
           Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphCenter

           Doc2.Application.Selection.Text = NemoMon & " " & Format((Contrato(16, m)), "###,###,###,##0.###0")
           Doc2.Application.Selection.MoveRight Unit:=wdCell
           Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft

           If Contrato(10, m) = "FIJA" Or Contrato(14, m) = 1 Then
                Doc2.Application.Selection.Text = Contrato(8, m) & " % "
                Doc2.Application.Selection.MoveRight Unit:=wdCell
                Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft

           Else
                Doc2.Application.Selection.Text = Contrato(10, m) & " + " & Format(Contrato(19, m), "###0.###0") & " %"
                Doc2.Application.Selection.MoveRight Unit:=wdCell
                Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft

           End If

           contadorlineas = contadorlineas + 1
      End If

    Next
    '*****
    Doc2.Bookmarks("NomBco5").Select
    Doc2.Application.Selection.Text = DatosCond(1)
    Doc2.Bookmarks("NomCli5").Select
    Doc2.Application.Selection.Text = DatosCond(6)

    contadorlineas = 1
    A = 1


'    Doc2.Bookmarks("NemoMonPagoCap").Select  'revisar
'    Doc2.Application.Selection.Text = Datos(32)
'
'    Doc2.Bookmarks("NemoMonPagoInt").Select 'revisar
'    Doc2.Application.Selection.Text = Datos(33)
    'Grilla Pagamos
    For m = 1 To total
        Doc2.Bookmarks("Grilla").Select

        If contadorlineas >= 1 And Contrato(27, m) = 2 Then
            Doc2.Application.Selection.MoveDown Unit:=wdLine, Count:=A
            Doc2.Bookmarks.Add Name:="Prueba", Range:=Doc2.Application.Selection.Range
            Doc2.Bookmarks("Prueba").Select
            A = A + 1
        End If

        If Contrato(27, m) = 2 Then
           Doc2.Application.Selection.Text = Contrato(37, m)
           Doc2.Application.Selection.MoveRight Unit:=wdCell
           Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
           
           Doc2.Application.Selection.Text = Contrato(5, m)
           Doc2.Application.Selection.MoveRight Unit:=wdCell
           Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
           
           Doc2.Application.Selection.Text = Contrato(38, m)
           Doc2.Application.Selection.MoveRight Unit:=wdCell
           Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft

           Doc2.Application.Selection.Text = Contrato(7, m)
           Doc2.Application.Selection.MoveRight Unit:=wdCell
           Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphCenter

           Doc2.Application.Selection.Text = NemoMon1 & " " & Format((Contrato(22, m)), "###,###,###,##0.###0")
           Doc2.Application.Selection.MoveRight Unit:=wdCell
           Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphCenter

           Doc2.Application.Selection.Text = NemoMon1 & " " & Format((Contrato(21, m)), "###,###,###,##0.###0")
           Doc2.Application.Selection.MoveRight Unit:=wdCell
           Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft

           If Contrato(11, m) = "FIJA" Or Contrato(14, m) = 1 Then
                Doc2.Application.Selection.Text = Contrato(9, m) & " % "
                Doc2.Application.Selection.MoveRight Unit:=wdCell
                Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft

           Else
                Doc2.Application.Selection.Text = Contrato(11, m) & " + " & Format(Contrato(24, m), "###0.###0") & " %"
                Doc2.Application.Selection.MoveRight Unit:=wdCell
                Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft

           End If

           contadorlineas = contadorlineas + 1

        End If

    Next

    Doc2.Bookmarks("ModalidadPago").Select
    Doc2.Application.Selection.Text = Contrato(4, 1)
    
   
    If Contrato(4, i) <> "COMPENSACION" Then
        Doc2.Bookmarks("FraseNemoMonMod").Select
        Doc2.Application.Selection.Text = Datos(42) & " " & Datos(39) & Datos(43) & " " & Datos(40)
    Else
        Doc2.Bookmarks("FraseNemoMonMod").Select
        Doc2.Application.Selection.Text = Datos(41) & " " & Datos(39)
    End If
    
    
    With BacContratoSwap
         Call FIRMAS(Doc2, "Nombre_Banco_12", .txtRutRepBco1, Trim(Mid(BacContratoSwap.cmbRepBco1.Text, 1, 60)), gsc_Parametros.direccion, gsc_Parametros.telefono, gsc_Parametros.fax, (BacFormatoRut(gsc_Parametros.Rut & "-" & gsc_Parametros.digrut)), .txtEntidad.Caption)
         Call FIRMAS(Doc2, "Nombre_Cliente_14", .txtRutRepBco2, Trim(Mid(BacContratoSwap.cmbRepBco2.Text, 1, 60)), gsc_Parametros.direccion, gsc_Parametros.telefono, gsc_Parametros.fax, (BacFormatoRut(gsc_Parametros.Rut & "-" & gsc_Parametros.digrut)), .txtEntidad.Caption)
    End With
    
    Dim telefonocli As String
    Dim FaxCli As String
    Dim RutCli As String
    telefonocli = DatosCond(17)
    FaxCli = DatosCond(18)
    RutCli = DatosCond(7)
    If Len(BacContratoSwap.cmbRepCliente1.Text) <> 0 And Len(BacContratoSwap.cmbRepCliente2.Text) = 0 Or Len(BacContratoSwap.cmbRepCliente1.Text) <> 0 And Len(BacContratoSwap.cmbRepCliente2.Text) <> 0 Then

        With BacContratoSwap
     
         FIRMAS Doc2, "pp_cli", .txtRutRepCli1, Trim(Left(BacContratoSwap.cmbRepCliente1, Len(BacContratoSwap.cmbRepCliente1) - 15)), .txtDirecCli, telefonocli, FaxCli, RutCli, .txtCliente.Caption
         
        End With
                                                                            
           If Len(BacContratoSwap.cmbRepCliente2.Text) <> 0 Then

            With BacContratoSwap
            
            FIRMAS Doc2, "pp_cli1", .txtRutRepCli2, Trim(Left(BacContratoSwap.cmbRepCliente2, Len(BacContratoSwap.cmbRepCliente2) - 15)), .txtDirecCli, telefonocli, FaxCli, RutCli, .txtCliente.Caption '(BacFormatoRut(.Txt_RutCli2.Text & "-" & .Txt_Digcli2.Text)), .Cmb_ApoCli2.Text, gsDireccion, telefonocli, faxcli, (BacFormatoRut(gsCodigo & "-" & gsDigito)), cliente.clnombre
            
            End With
        
            End If
            
          ElseIf Len(BacContratoSwap.cmbRepCliente2.Text) = 0 And Len(BacContratoSwap.cmbRepCliente2.Text) <> 0 Then

        With BacContratoSwap
          FIRMAS Doc2, "pp_cli1", .txtRutRepCli2, Trim(Left(BacContratoSwap.cmbRepCliente2, Len(BacContratoSwap.cmbRepCliente2) - 15)), .txtDirecCli, telefonocli, FaxCli, RutCli, .txtCliente.Caption
          
        End With
          End If

'    Doc2.Bookmarks("NomBco6").Select
'    Doc2.Application.Selection.Text = DatosCond(3)
'    Doc2.Bookmarks("RutRep6").Select
'    Doc2.Application.Selection.Text = DatosCond(4)

'    Doc2.Bookmarks("RepCli6").Select
'    Doc2.Application.Selection.Text = DatosCond(8)
'    Doc2.Bookmarks("RutCli6").Select
'    Doc2.Application.Selection.Text = DatosCond(9)

'    Doc2.Bookmarks("RepBco7").Select
'    Doc2.Application.Selection.Text = DatosCond(21)
'    Doc2.Bookmarks("RutRep7").Select
'    Doc2.Application.Selection.Text = DatosCond(22)

'    Doc2.Bookmarks("RepCli7").Select
'    Doc2.Application.Selection.Text = DatosCond(23)
'    Doc2.Bookmarks("RutCli7").Select
'    Doc2.Application.Selection.Text = DatosCond(24)

'    Doc2.Bookmarks("NomBcoFir1").Select
'    Doc2.Application.Selection.Text = DatosCond(1)
'    Doc2.Bookmarks("NomBcoFir2").Select
'    Doc2.Application.Selection.Text = DatosCond(1)
'    Doc2.Bookmarks("NomCliFir1").Select
'    Doc2.Application.Selection.Text = DatosCond(6)
'    Doc2.Bookmarks("NomCliFir2").Select
'    Doc2.Application.Selection.Text = DatosCond(6)
'
'    ActiveDocument.SaveAs FileName:=DatosCond(20) & "\Contrato Swap de Tasas " & DatosCond(6) & ".doc"
    
    If Donde = "Impresora" Then
        ActiveDocument.PrintOut
    Else
        Doc2.Application.Visible = True
         Doc2.Application.WindowState = wdWindowStateMaximize
    End If
    
 Set Doc2 = Nothing
 Set ClsMoneda = Nothing
Exit Function

Control:

    MsgBox "Problemas para crear Contrato!!. " & err.Description, vbInformation, Msj
    Set Doc2 = Nothing
    Set ClsMoneda = Nothing
    
End Function

Public Function BacContratoForwardRateAgreement(Documento As Long, iRutApoBco1 As Long, iRutApoBco2 As Long, iRutApoCli1 As Long, iRutApoCli2 As Long) As Boolean
   On Error GoTo ErrorImpresion
   Dim MiDoc      As Word.Document
   Dim Error      As Boolean
   Dim Datos()
   
   Error = False
   
   Set MiDoc = IniciaWordListadoLog("ContratoFRABanco", Error)
   
   If Error = False Then
      MiDoc.Application.Documents.Close
      Set MiDoc = Nothing
      
      MsgBox "Error en Impresión de Contrato para la Operación N° " & Documento, vbExclamation, TITSISTEMA
      Exit Function
   End If
   
   Envia = Array()
   AddParam Envia, Documento
   AddParam Envia, iRutApoBco1
   AddParam Envia, iRutApoBco2
   AddParam Envia, iRutApoCli1
   AddParam Envia, iRutApoCli2
   If Not Bac_Sql_Execute("CONTRATO_FRA", Envia) Then
      GoTo ErrorImpresion
   End If
   If Bac_SQL_Fetch(Datos()) Then
      MiDoc.Application.Visible = True
      
      MiDoc.Activate: MiDoc.Bookmarks("FechaInicio1").Select
      MiDoc.Application.Selection.Text = Datos(1)
      MiDoc.Activate: MiDoc.Bookmarks("Nombrebanco1").Select
      MiDoc.Application.Selection.Text = Datos(2)
      MiDoc.Activate: MiDoc.Bookmarks("RutBanco1").Select
      MiDoc.Application.Selection.Text = Format(Datos(3), TipoFormato("CLP")) & "-" & Datos(4)
      MiDoc.Activate: MiDoc.Bookmarks("ApoderadoBanco1").Select
      MiDoc.Application.Selection.Text = Datos(5)
      
      If Datos(8) <> "" Then
         MiDoc.Activate: MiDoc.Bookmarks("RutApoderadobanco1").Select
         MiDoc.Application.Selection.Text = Format(Datos(6), TipoFormato("CLP")) & "-" & Datos(7) & " y Don(ña) " & Datos(8) & " cédula de identidad N° " & Format(Datos(9), TipoFormato("CLP")) & "-" & Datos(10)
      Else
         MiDoc.Activate: MiDoc.Bookmarks("RutApoderadobanco1").Select
         MiDoc.Application.Selection.Text = Format(Datos(6), TipoFormato("CLP")) & "-" & Datos(7)
      End If
      
      MiDoc.Activate: MiDoc.Bookmarks("DireccionBanco").Select
      MiDoc.Application.Selection.Text = Datos(11)
      MiDoc.Activate: MiDoc.Bookmarks("NombreCliente1").Select
      MiDoc.Application.Selection.Text = Datos(12)
      MiDoc.Activate: MiDoc.Bookmarks("RutCliente1").Select
      MiDoc.Application.Selection.Text = Format(Datos(13), TipoFormato("CLP")) & "-" & Datos(14)
      MiDoc.Activate: MiDoc.Bookmarks("ApoderadoCliente1").Select
      MiDoc.Application.Selection.Text = Datos(15)
      
      If Datos(18) <> "" Then
         MiDoc.Activate: MiDoc.Bookmarks("RutApoderadoCliente1").Select
         MiDoc.Application.Selection.Text = Format(Datos(16), TipoFormato("CLP")) & "-" & Datos(17) & " y Don(ña) " & Datos(18) & " cédula de identidad N° " & Format(Datos(19), TipoFormato("CLP")) & "-" & Datos(20)
      Else
         MiDoc.Activate: MiDoc.Bookmarks("RutApoderadoCliente1").Select
         MiDoc.Application.Selection.Text = Format(Datos(16), TipoFormato("CLP")) & "-" & Datos(17)
      End If

      MiDoc.Activate: MiDoc.Bookmarks("DireccionCliente").Select
      MiDoc.Application.Selection.Text = Datos(21)
      MiDoc.Activate: MiDoc.Bookmarks("FechaInicio2").Select
      MiDoc.Application.Selection.Text = Format(Datos(22), "dddd dd") & " de " & Format(Datos(22), "mmmm") & " del año " & Format(Datos(22), "yyyy")
      MiDoc.Activate: MiDoc.Bookmarks("MontoContratado").Select
      MiDoc.Application.Selection.Text = Datos(54) & " " & Format(Datos(24), TipoFormato("USD"))
      MiDoc.Activate: MiDoc.Bookmarks("FechaFijacion").Select
      MiDoc.Application.Selection.Text = Format(Datos(27), "DD/MM/YYYY")
      MiDoc.Activate: MiDoc.Bookmarks("FechaVencimiento").Select
      MiDoc.Application.Selection.Text = Format(Datos(28), "DD/MM/YYYY")
      MiDoc.Activate: MiDoc.Bookmarks("FechaPago").Select
      MiDoc.Application.Selection.Text = Format(Datos(27), "DD/MM/YYYY")
      MiDoc.Activate: MiDoc.Bookmarks("ParidadPactada").Select
      MiDoc.Application.Selection.Text = Format(CDbl(Datos(25)), TipoFormato("USD"))
      MiDoc.Activate: MiDoc.Bookmarks("ParidadRef").Select
      MiDoc.Application.Selection.Text = Datos(32)
      MiDoc.Activate: MiDoc.Bookmarks("Descuento").Select
      MiDoc.Application.Selection.Text = "N/A"
      MiDoc.Activate: MiDoc.Bookmarks("paridad").Select
      MiDoc.Application.Selection.Text = "N/A"
      MiDoc.Activate: MiDoc.Bookmarks("Lugar").Select
      MiDoc.Application.Selection.Text = "SANTIAGO"
      MiDoc.Activate: MiDoc.Bookmarks("ValutaPago").Select
      MiDoc.Application.Selection.Text = "N/A"
      MiDoc.Activate: MiDoc.Bookmarks("FormaPago").Select
      MiDoc.Application.Selection.Text = Datos(34)

      If UCase(Datos(23)) = UCase("Tomador") Then
         MiDoc.Activate: MiDoc.Bookmarks("Nombre1").Select
         MiDoc.Application.Selection.Text = Datos(23)
         MiDoc.Activate: MiDoc.Bookmarks("Nombre2").Select
         MiDoc.Application.Selection.Text = Datos(28)
         MiDoc.Activate: MiDoc.Bookmarks("Nombre3").Select
         MiDoc.Application.Selection.Text = Datos(28)
         MiDoc.Activate: MiDoc.Bookmarks("Nombre4").Select
         MiDoc.Application.Selection.Text = Datos(23)
      Else
         MiDoc.Activate: MiDoc.Bookmarks("Nombre1").Select
         MiDoc.Application.Selection.Text = Datos(28)
         MiDoc.Activate: MiDoc.Bookmarks("Nombre2").Select
         MiDoc.Application.Selection.Text = Datos(23)
         MiDoc.Activate: MiDoc.Bookmarks("Nombre3").Select
         MiDoc.Application.Selection.Text = Datos(23)
         MiDoc.Activate: MiDoc.Bookmarks("Nombre4").Select
         MiDoc.Application.Selection.Text = Datos(28)
      End If

      MiDoc.Activate: MiDoc.Bookmarks("MonedaPago").Select
      MiDoc.Application.Selection.Text = Datos(56)
      MiDoc.Activate: MiDoc.Bookmarks("NomBco6").Select
      MiDoc.Application.Selection.Text = Datos(5)
      MiDoc.Activate: MiDoc.Bookmarks("RutRep6").Select
      MiDoc.Application.Selection.Text = Format(Datos(16), TipoFormato("CLP")) & "-" & Datos(17)
      MiDoc.Activate: MiDoc.Bookmarks("RepCli6").Select
      MiDoc.Application.Selection.Text = Datos(15)
      MiDoc.Activate: MiDoc.Bookmarks("RutCli6").Select
      MiDoc.Application.Selection.Text = Format(Datos(16), TipoFormato("CLP")) & "-" & Datos(17)
      MiDoc.Activate: MiDoc.Bookmarks("RepBco7").Select
      MiDoc.Application.Selection.Text = Datos(8)
      MiDoc.Activate: MiDoc.Bookmarks("RutRep7").Select
      MiDoc.Application.Selection.Text = Format(Datos(9), TipoFormato("CLP")) & "-" & Datos(10)
      MiDoc.Activate: MiDoc.Bookmarks("RepCli7").Select
      MiDoc.Application.Selection.Text = Datos(18)
      MiDoc.Activate: MiDoc.Bookmarks("RutCli7").Select
      MiDoc.Application.Selection.Text = Format(Datos(19), TipoFormato("CLP")) & "-" & Datos(20)
      MiDoc.Activate: MiDoc.Bookmarks("NomBcoFir1").Select
      MiDoc.Application.Selection.Text = Datos(2)
      MiDoc.Activate: MiDoc.Bookmarks("NomBcoFir2").Select
      MiDoc.Application.Selection.Text = Datos(2)
      MiDoc.Activate: MiDoc.Bookmarks("NomCliFir1").Select
      MiDoc.Application.Selection.Text = Datos(12)
      MiDoc.Activate: MiDoc.Bookmarks("NomCliFir2").Select
      MiDoc.Application.Selection.Text = Datos(12)
      
      MiDoc.SaveAs FileName:="C:\Mis documentos\Contrato FRA " & Trim(Datos(12)) & ".Doc"
   End If
  
   MiDoc.Application.Documents.Close
   Set MiDoc = Nothing
Exit Function
ErrorImpresion:
   MiDoc.Application.Documents.Close
   Set MiDoc = Nothing
End Function

Function BacContratoFraBanco(DatosCond(), NumOper, Donde) As Boolean
   On Error GoTo Control:
   
   Dim Doc2          As Word.Document
   Dim SQL           As String
   Dim contadorlineas
   Dim A, m
   Dim Datos()
   Dim i             As Integer
   Dim total         As Integer
   Dim Contrato()
   Dim NemoMon       As String
   Dim NemoMon1      As String
   Dim Paso          As String
   Dim Glosa         As String
   Dim Okk           As Boolean
    
   Dim ClsMoneda As Object
   Set ClsMoneda = New ClsMoneda
   
   Call ClsMoneda.LeerxCodigo(CInt(DatosCond(29)))
   NemoMon = ClsMoneda.mnnemo
       
   Set Doc2 = IniciaWordListadoLog("ContratoFRABanco", Okk)
    
    If Not Okk Then
        MsgBox "No podra ser Generado el contrato!", vbCritical, Msj
        BacContratoFraBanco = False
        Set ClsMoneda = Nothing
        Exit Function
    End If
  
    Doc2.Activate
    Doc2.Bookmarks("FechaInicio1").Select
    Doc2.Application.Selection.Text = DatosCond(12) & " de " & DatosCond(13) & " del año " & DatosCond(14)
    Doc2.Bookmarks("Nombrebanco1").Select
    Doc2.Application.Selection.Text = DatosCond(1)
    Doc2.Bookmarks("RutBanco1").Select
    Doc2.Application.Selection.Text = DatosCond(2)
    Doc2.Bookmarks("ApoderadoBanco1").Select
    Doc2.Application.Selection.Text = DatosCond(3)

    If Len(Trim(DatosCond(21))) > 0 Then
        Doc2.Bookmarks("RutApoderadobanco1").Select
        Doc2.Application.Selection.Text = DatosCond(4) & " y don " & DatosCond(21) & " cédula de identidad N° " & DatosCond(22)
      
    Else
        Doc2.Bookmarks("RutApoderadobanco1").Select
        Doc2.Application.Selection.Text = DatosCond(4)
    
    End If
   
    Doc2.Bookmarks("DireccionBanco").Select
    Doc2.Application.Selection.Text = DatosCond(5)
    
    Doc2.Bookmarks("NombreCliente1").Select
    Doc2.Application.Selection.Text = DatosCond(6)
    Doc2.Bookmarks("RutCliente1").Select
    Doc2.Application.Selection.Text = DatosCond(7)
    Doc2.Bookmarks("ApoderadoCliente1").Select
    Doc2.Application.Selection.Text = DatosCond(8)

    If Len(Trim(DatosCond(23))) > 0 Then
        Doc2.Bookmarks("RutApoderadoCliente1").Select
        Doc2.Application.Selection.Text = DatosCond(9) & " y don " & DatosCond(23) & " cédula de identidad N° " & DatosCond(24)
        
    Else
        Doc2.Bookmarks("RutApoderadoCliente1").Select
        Doc2.Application.Selection.Text = DatosCond(9)
        
    End If
    
    Doc2.Bookmarks("DireccionCliente").Select
    Doc2.Application.Selection.Text = DatosCond(10)
    Doc2.Bookmarks("FechaInicio2").Select
    Doc2.Application.Selection.Text = DatosCond(31) & " de " & DatosCond(32) & " del año " & DatosCond(33)
        
    ReDim Preserve Contrato(27, 1)
    For i = 1 To 27
        Contrato(i, 1) = "**"
    Next

    SQL = "EXECUTE SP_DATOSCONTRATO " & NumOper
    If MISQL.SQL_Execute(SQL$) = 0 Then
       i = 1
       While MISQL.SQL_Fetch(Datos()) = 0
            ReDim Preserve Contrato(27, i)
            Contrato(1, i) = Datos(1)   'Tipo_operacion
            Contrato(2, i) = Datos(2)   'MontoOperacion
            Contrato(3, i) = Datos(3)   'TasaConversion
            Contrato(4, i) = Datos(4)   'Modalidad
            Contrato(5, i) = Datos(5)   'fechainicioflujo
            Contrato(6, i) = Datos(6)   'fechavenceflujo
            Contrato(7, i) = Datos(7)   'dias
            Contrato(8, i) = BacStrTran((Datos(8)), ".", gsc_PuntoDecim)    'compra_valor_tasa
            Contrato(9, i) = BacStrTran((Datos(9)), ".", gsc_PuntoDecim)    'venta_valor_tasa
            Contrato(10, i) = Datos(10) 'nombretasacompra
            Contrato(11, i) = Datos(11) 'nombretasaventa
            Contrato(12, i) = Datos(12) 'pagamosdoc
            Contrato(13, i) = Datos(13) 'recibimosdoc
            Contrato(14, i) = Datos(14) 'numero_flujo
            Contrato(15, i) = BacStrTran((Datos(15)), ".", gsc_PuntoDecim)  'compra_capital
            Contrato(16, i) = BacStrTran((Datos(16)), ".", gsc_PuntoDecim)  'compra_amortiza
            Contrato(17, i) = BacStrTran((Datos(17)), ".", gsc_PuntoDecim)  'compra_saldo
            Contrato(18, i) = Datos(18) 'compra_interes
            Contrato(19, i) = Datos(19) 'compra_spread
            Contrato(20, i) = Datos(20) 'venta_capital
            Contrato(21, i) = BacStrTran((Datos(21)), ".", gsc_PuntoDecim)  'venta_amortiza
            Contrato(22, i) = BacStrTran((Datos(22)), ".", gsc_PuntoDecim)  'venta_saldo
            Contrato(23, i) = Datos(23) 'venta_interes
            Contrato(24, i) = Datos(24) 'venta_spread
            Contrato(25, i) = Datos(25) 'pagamos_moneda
            Contrato(26, i) = Datos(26) 'recibimos_moneda
            Contrato(27, i) = Datos(27) 'tipo_flujo
            i = i + 1
       Wend
       i = i - 1
    Else
        MsgBox "Datos necesarios para generar Contrato no han sido encontrados !!", vbCritical, Msj
        Set Doc2 = Nothing
        Set ClsMoneda = Nothing
        Exit Function

    End If

    Doc2.Bookmarks("MontoContratado").Select
    Doc2.Application.Selection.Text = NemoMon & " " & Format(DatosCond(30), "###,###,###,##0.###0")
    Doc2.Bookmarks("FechaFijacion").Select
    Doc2.Application.Selection.Text = Contrato(5, i)
    
    Doc2.Bookmarks("FechaVencimiento").Select
    Doc2.Application.Selection.Text = Contrato(6, i)
    
    Doc2.Bookmarks("FechaPago").Select
    Doc2.Application.Selection.Text = Contrato(5, i)
    Doc2.Bookmarks("ParidadPactada").Select
    Doc2.Application.Selection.Text = Trim(Contrato(3, i))
    Doc2.Bookmarks("ParidadRef").Select
    Doc2.Application.Selection.Text = Trim(Contrato(10, i))
    
    Doc2.Bookmarks("Descuento").Select
    Doc2.Application.Selection.Text = "N/A"
    Doc2.Bookmarks("paridad").Select
    Doc2.Application.Selection.Text = "N/A"
    Doc2.Bookmarks("Lugar").Select
    Doc2.Application.Selection.Text = "SANTIAGO"
    Doc2.Bookmarks("ValutaPago").Select
    Doc2.Application.Selection.Text = "N/A"
    Doc2.Bookmarks("FormaPago").Select
    Doc2.Application.Selection.Text = Contrato(12, 1)
    

    If Contrato(1, 1) = "C" Then
       Doc2.Bookmarks("Nombre1").Select
       Doc2.Application.Selection.Text = DatosCond(1)
       Doc2.Bookmarks("Nombre2").Select
       Doc2.Application.Selection.Text = DatosCond(6)
       
       Doc2.Bookmarks("Nombre3").Select
       Doc2.Application.Selection.Text = DatosCond(6)
       Doc2.Bookmarks("Nombre4").Select
       Doc2.Application.Selection.Text = DatosCond(1)
       
    Else
       Doc2.Bookmarks("Nombre1").Select
       Doc2.Application.Selection.Text = DatosCond(6)
       Doc2.Bookmarks("Nombre2").Select
       Doc2.Application.Selection.Text = DatosCond(1)
       
       Doc2.Bookmarks("Nombre3").Select
       Doc2.Application.Selection.Text = DatosCond(1)
       Doc2.Bookmarks("Nombre4").Select
       Doc2.Application.Selection.Text = DatosCond(6)
    End If
    
    Doc2.Application.Visible = True

    Call ClsMoneda.LeerxCodigo(CInt(Contrato(25, i)))
    NemoMon1 = ClsMoneda.MnGlosa
    
    Doc2.Bookmarks("MonedaPago").Select
    Doc2.Application.Selection.Text = NemoMon1

    Doc2.Bookmarks("NomBco6").Select
    Doc2.Application.Selection.Text = DatosCond(3)
    Doc2.Bookmarks("RutRep6").Select
    Doc2.Application.Selection.Text = DatosCond(4)

    Doc2.Bookmarks("RepCli6").Select
    Doc2.Application.Selection.Text = DatosCond(8)
    Doc2.Bookmarks("RutCli6").Select
    Doc2.Application.Selection.Text = DatosCond(9)

    Doc2.Bookmarks("RepBco7").Select
    Doc2.Application.Selection.Text = DatosCond(21)
    Doc2.Bookmarks("RutRep7").Select
    Doc2.Application.Selection.Text = DatosCond(22)

    Doc2.Bookmarks("RepCli7").Select
    Doc2.Application.Selection.Text = DatosCond(23)
    Doc2.Bookmarks("RutCli7").Select
    Doc2.Application.Selection.Text = DatosCond(24)

    Doc2.Bookmarks("NomBcoFir1").Select
    Doc2.Application.Selection.Text = DatosCond(1)
    Doc2.Bookmarks("NomBcoFir2").Select
    Doc2.Application.Selection.Text = DatosCond(1)
    Doc2.Bookmarks("NomCliFir1").Select
    Doc2.Application.Selection.Text = DatosCond(6)
    Doc2.Bookmarks("NomCliFir2").Select
    Doc2.Application.Selection.Text = DatosCond(6)

    ActiveDocument.SaveAs FileName:=DatosCond(20) & "\Contrato Swap de Tasas " & DatosCond(6) & ".doc"
    
    If Donde = "Impresora" Then
        ActiveDocument.PrintOut
    Else
        Doc2.Application.Visible = True
         Doc2.Application.WindowState = wdWindowStateMaximize
    End If
    
 Set Doc2 = Nothing
 Set ClsMoneda = Nothing
Exit Function

Control:

    MsgBox "Problemas para crear Contrato!!. " & err.Description, vbInformation, Msj
    Set Doc2 = Nothing
    Set ClsMoneda = Nothing
    
End Function


Function BacContratoSwapTasaICPBanco(DatosCond(), NumOper, Donde) As Boolean
   On Error GoTo Control:
   Dim Doc2             As Word.Document
   Dim SQL              As String
   Dim i                As Integer
   Dim total            As Integer
   Dim NemoMon          As String
   Dim Paso             As String
   Dim Glosa            As String
   Dim Okk              As Boolean
   Dim contadorlineas
   Dim A, m
   Dim Datos()
   Dim Contrato() As Variant

   SQL = giSQL_DatabaseCommon
   SQL = SQL & "..SP_LEER_MONEDA "
   SQL = SQL & DatosCond(29)
   
   If MISQL.SQL_Execute(SQL) = 0 Then
      If MISQL.SQL_Fetch(Datos()) = 0 Then
         NemoMon = UCase(Datos(2))
      End If
   End If
   
   Set Doc2 = IniciaWordListadoLog("ContratoTasasBancoICP", Okk)
   
   If Not Okk Then
      MsgBox "No podra ser Generado el contrato!", vbCritical, Msj
      BacContratoSwapTasaICPBanco = False
      Exit Function
   End If
   
   Dim NombreCliente    As String
   Dim FechaCondiciones As String
   
   Let NombreCliente = Trim(BacContratoSwap.grdLista.TextMatrix(BacContratoSwap.grdLista.Row, 2))
   Let FechaCondiciones = BacContratoSwap.grdLista.TextMatrix(BacContratoSwap.grdLista.Row, 12)

   If Year(CDate(FechaCondiciones)) = "1900" Or Len(FechaCondiciones) = 0 Then
      MsgBox "No se han emitido condiciones generales para el cliente " & vbCrLf & NombreCliente
      Exit Function
   End If
   
Imprimir:
  
   Doc2.Activate
  'Doc2.Application.Visible = True
   
   Doc2.Bookmarks("FECHA_PROCESO").Select
  'Doc2.Application.Selection.Text = BacFormatoFecha("DDMMAA", gsBAC_Fecp)
   Doc2.Application.Selection.Text = DatosCond(12) & " de " & DatosCond(13) & " del " & DatosCond(14)
   Doc2.Application.Selection.Font.Bold = True
   
   Doc2.Bookmarks("folio").Select
   Doc2.Application.Selection.Text = NumOper
   Doc2.Application.Selection.Font.Bold = True
   
   Doc2.Bookmarks("Nombre_Banco_1").Select
   Doc2.Application.Selection.Text = DatosCond(1)
   Doc2.Application.Selection.Font.Bold = True
   
   Let Doc2.ActiveWindow.View.Type = wdPrintView

   Doc2.Bookmarks("Rut_Banco_1").Select
   Doc2.Application.Selection.Text = DatosCond(2)
   
   Doc2.Bookmarks("Apoderado_Banco").Select
   Doc2.Application.Selection.Text = DatosCond(3)
   Doc2.Application.Selection.Font.Bold = True

   Doc2.Bookmarks("Rut_Apoderado_Banco").Select
   Doc2.Application.Selection.Text = DatosCond(4)
   
   If Len(Trim(DatosCond(21))) > 0 Then
      Doc2.Bookmarks("RepBco2").Select
      Doc2.Application.Selection.Text = DatosCond(21)
      Doc2.Application.Selection.Font.Bold = True
      
      Doc2.Bookmarks("RutRepBco2").Select
      Doc2.Application.Selection.Text = DatosCond(22)
   End If
   
  
    Doc2.Bookmarks("Direccion_Banco").Select
    Doc2.Application.Selection.Text = gsc_Parametros.direccion
    Doc2.Application.Selection.Font.Bold = True
  
    Doc2.Bookmarks("Nombre_Cliente_1").Select
    Doc2.Application.Selection.Text = DatosCond(6)
    Doc2.Application.Selection.Font.Bold = True
    
    Doc2.Bookmarks("rut_cliente").Select
    Doc2.Application.Selection.Text = DatosCond(7)
    
   Doc2.Bookmarks("Apoderado_Cliente").Select
   Doc2.Application.Selection.Text = DatosCond(8)
   Doc2.Application.Selection.Font.Bold = True
   
   Doc2.Bookmarks("Rut_Apoderado_Cliente").Select
   Doc2.Application.Selection.Text = DatosCond(9)
    
    If Len(Trim(DatosCond(23))) > 0 Then
      Doc2.Bookmarks("RepCli2").Select
      Doc2.Application.Selection.Text = DatosCond(23)
      Doc2.Application.Selection.Font.Bold = True
      
      Doc2.Bookmarks("RutRepCli2").Select
      Doc2.Application.Selection.Text = DatosCond(24)
   End If
   
    Doc2.Bookmarks("Direccion_Cliente").Select
   Doc2.Application.Selection.Text = DatosCond(10)
   Doc2.Application.Selection.Font.Bold = True
   
   Doc2.Bookmarks("fecha_gnral").Select
   Doc2.Application.Selection.Text = BacFormatoFecha("DDMMAA", BacContratoSwap.grdLista.TextMatrix(BacContratoSwap.grdLista.Row, 12))
   
   
'   Doc2.Bookmarks("DiaDe").Select
'   Doc2.Application.Selection.Text = DatosCond(12)
'   Doc2.Bookmarks("MesDe").Select
'   Doc2.Application.Selection.Text = DatosCond(13)
'   Doc2.Bookmarks("AñoDe").Select
'   Doc2.Application.Selection.Text = DatosCond(14)
'   Doc2.Bookmarks("NomBco").Select
'   Doc2.Application.Selection.Text = DatosCond(1)
'   Doc2.Bookmarks("RutBco").Select
'   Doc2.Application.Selection.Text = DatosCond(2)

'   Doc2.Bookmarks("DireccBco").Select
'   Doc2.Application.Selection.Text = DatosCond(5)
''
'   Doc2.Bookmarks("NomCli").Select
'   Doc2.Application.Selection.Text = DatosCond(6)
'   Doc2.Bookmarks("RutCli").Select
'   Doc2.Application.Selection.Text = DatosCond(7)
'
'   Doc2.Bookmarks("RepCli1").Select
'   Doc2.Application.Selection.Text = DatosCond(8)
'   Doc2.Bookmarks("RutRepCli1").Select
'   Doc2.Application.Selection.Text = DatosCond(9)
'   If Len(Trim(DatosCond(23))) > 0 Then
'      Doc2.Bookmarks("RepCli2").Select
'      Doc2.Application.Selection.Text = DatosCond(23)
'      Doc2.Bookmarks("RutRepCli2").Select
'      Doc2.Application.Selection.Text = DatosCond(24)
'   End If
'   Doc2.Bookmarks("DireccCli").Select
'   Doc2.Application.Selection.Text = DatosCond(10)
'   Doc2.Bookmarks("NomCli1").Select
'   Doc2.Application.Selection.Text = DatosCond(6)
'
'   Doc2.Bookmarks("DiaCond").Select
'   Doc2.Application.Selection.Text = DatosCond(31)
'   Doc2.Bookmarks("MesCond").Select
'   Doc2.Application.Selection.Text = DatosCond(32)
'   Doc2.Bookmarks("AñoCond").Select
'   Doc2.Application.Selection.Text = DatosCond(33)
'
   
   Let MiVariable = DatosCond(1) & Space(35 - Len(Trim(DatosCond(1)))) & " : " & NemoMon & " " & Format(DatosCond(30), "###,###,###,##0.###0")
   Doc2.Bookmarks("ConFin1").Select
   Doc2.Application.Selection.Text = MiVariable
   
   Let MiVariable = DatosCond(6) & Space(35 - Len(Trim(DatosCond(6)))) & " : " & NemoMon & " " & Format(DatosCond(30), "###,###,###,##0.###0")
   Doc2.Bookmarks("ConFin2").Select
   Doc2.Application.Selection.Text = MiVariable

'   Doc2.Bookmarks("NomBco3").Select
'   Doc2.Application.Selection.Text = DatosCond(1)
   
 '  Doc2.Bookmarks("NomCli3").Select
 '  Doc2.Application.Selection.Text = DatosCond(6)

   Doc2.Bookmarks("FechaIni").Select
   Doc2.Application.Selection.Text = DatosCond(27)

   Doc2.Bookmarks("Lugar").Select
   Doc2.Application.Selection.Text = "SANTIAGO, CHILE"

   Doc2.Bookmarks("NomBco4").Select
   Doc2.Application.Selection.Text = DatosCond(1)
   Doc2.Application.Selection.Font.Bold = True
   
   Doc2.Bookmarks("NomCli4").Select
   Doc2.Application.Selection.Text = DatosCond(6)
   Doc2.Application.Selection.Font.Bold = True

   contadorlineas = 1
   A = 1
   ''ReDim Preserve Contrato(27, 1) ''PRD-7904
   ReDim Preserve Contrato(30, 1)
   'For i = 1 To 27
   For i = 1 To 30 'PRD-7904
      Contrato(i, 1) = "**"
   Next

   'SQL = "EXECUTE SP_DATOSCONTRATO " & NumOper
   SQL = "EXECUTE SP_DATOSCONTRATO_TODOSFLUJOS " & NumOper
   If MISQL.SQL_Execute(SQL$) = 0 Then
      i = 1
      While MISQL.SQL_Fetch(Datos()) = 0
         'ReDim Preserve Contrato(27, i)
         ReDim Preserve Contrato(30, i) 'PRD-7904
         Contrato(1, i) = Datos(1)                                       'Tipo_operacion
         Contrato(2, i) = Datos(2)                                       'MontoOperacion
         Contrato(3, i) = Datos(3)                                       'TasaConversion
         Contrato(4, i) = Datos(4)                                       'Modalidad
         Contrato(5, i) = Datos(5)                                       'fechainicioflujo
         Contrato(6, i) = Datos(6)                                       'fechavenceflujo
         Contrato(7, i) = Datos(7)                                       'dias
         Contrato(8, i) = BacStrTran((Datos(8)), ".", gsc_PuntoDecim)    'compra_valor_tasa
         Contrato(9, i) = BacStrTran((Datos(9)), ".", gsc_PuntoDecim)    'venta_valor_tasa
         Contrato(10, i) = Datos(10)                                     'nombretasacompra
         Contrato(11, i) = Datos(11)                                     'nombretasaventa
         Contrato(12, i) = Datos(12)                                     'pagamosdoc
         Contrato(13, i) = Datos(13)                                     'recibimosdoc
         Contrato(14, i) = Datos(14)                                     'numero_flujo
         Contrato(15, i) = BacStrTran((Datos(15)), ".", gsc_PuntoDecim)  'compra_capital
         Contrato(16, i) = BacStrTran((Datos(16)), ".", gsc_PuntoDecim)  'compra_amortiza
         Contrato(17, i) = BacStrTran((Datos(17)), ".", gsc_PuntoDecim)  'compra_saldo
         Contrato(17, i) = CDbl(Contrato(16, i)) + CDbl(Contrato(17, i))
         Contrato(18, i) = Datos(18)                                     'compra_interes
         Contrato(19, i) = Datos(19)                                     'compra_spread
         Contrato(20, i) = Datos(20)                                     'venta_capital
         Contrato(21, i) = BacStrTran((Datos(21)), ".", gsc_PuntoDecim)  'venta_amortiza
         Contrato(22, i) = BacStrTran((Datos(22)), ".", gsc_PuntoDecim)  'venta_saldo
         Contrato(22, i) = CDbl(Contrato(21, i)) + CDbl(Contrato(22, i))
         Contrato(23, i) = Datos(23)                                     'venta_interes
         Contrato(24, i) = Datos(24)                                     'venta_spread
         Contrato(25, i) = Datos(25)                                     'pagamos_moneda
         Contrato(26, i) = Datos(26)                                     'recibimos_moneda
         Contrato(27, i) = Datos(27)                                     'tipo_flujo
         Contrato(28, i) = Datos(46)                                     'CompraGlosaBase 'PRD-7904
         Contrato(29, i) = Datos(47)                                     'VentaGlosaBase 'PRD-7904
         Contrato(30, i) = Datos(35)                                     'Estado_Flujo'PRD-7904
         i = i + 1
      Wend
      i = i - 1
   Else
      MsgBox "Datos necesarios para generar Contrato no han sido encontrados !!", vbCritical, Msj
      Set Doc2 = Nothing
      Exit Function
   End If
   total = i

   Doc2.Bookmarks("BANCO_REFERENCIA").Select
   Doc2.Application.Selection.Text = Replace(FuncEntregaBacoRef(NumOper), ", CHILE", "")

   Doc2.Bookmarks("TCRef").Select
   Doc2.Application.Selection.Text = FuncEntregaTCRef(NumOper)

   Doc2.Bookmarks("FechaVenc").Select
   Doc2.Application.Selection.Text = Contrato(6, i)

    Doc2.Bookmarks("FormaPago").Select
    Doc2.Application.Selection.Text = "MONEDA NACIONAL: " & IIf((Contrato(12, i) <> ""), (Contrato(12, i)), "N/A")
    
    Doc2.Bookmarks("FormaPago2").Select
    Doc2.Application.Selection.Text = "MONEDA EXTRANJERA: " & IIf((Contrato(13, i) <> ""), (Contrato(13, i)), "N/A")
    
   Doc2.Bookmarks("valuta").Select
   Doc2.Application.Selection.Text = FuncLoadValuta(NumOper)
    
   Doc2.Bookmarks("PlazoContrato").Select
   Doc2.Application.Selection.Text = Abs(DateDiff("D", CDate(DatosCond(27)), CDate(Contrato(6, i))))
   
   Doc2.Bookmarks("OBS2").Select
   Doc2.Application.Selection.Text = ""

   Doc2.Bookmarks("PlazoContrato").Select
   Doc2.Application.Selection.Text = "" '--> Abs(DateDiff("D", CDate(DatosCond(27)), CDate(Contrato(6, i))))

   If Contrato(1, 1) = "C" Then
      Glosa = Contrato(11, 1)
   Else
      Glosa = Contrato(10, 1)
   End If

   If Datos(7) >= 30 And Datos(7) < 41 Then
      Glosa = Glosa & " 30 DIAS"
   ElseIf Datos(7) >= 90 And Datos(7) < 101 Then
      Glosa = Glosa & " 90 DIAS"
   ElseIf Datos(7) >= 180 And Datos(7) < 191 Then
      Glosa = Glosa & " 180 DIAS"
   ElseIf Datos(7) >= 360 Then
      Glosa = Glosa & " 360 DIAS"
   End If

   For m = 1 To total
      If Contrato(27, m) = 2 And Contrato(30, m) = 1 Then 'PRD-7904
         Doc2.Bookmarks("NomBco3").Select
         If Contrato(11, m) = "FIJA" Then
            Doc2.Application.Selection.Text = DatosCond(1) & " " & Trim(Contrato(11, m)) & " " & Format(Contrato(9, m), FDecimal) & "% " & "Base Cálculo " & Trim(Contrato(29, m))
         Else
            If Contrato(11, m) = "ICP" Then
               If NemoMon = "UF" Then
                  Doc2.Application.Selection.Text = DatosCond(1) & " " & Trim("TRA") & " + " & Format(Contrato(24, m), FDecimal) & "% + SPREAD " & "Base Cálculo " & Trim(Contrato(29, m))
               End If
               If NemoMon = "CLP" Then
                  Doc2.Application.Selection.Text = DatosCond(1) & " " & Trim("TNA") & " + " & Format(Contrato(24, m), FDecimal) & "% + SPREAD " & "Base Cálculo " & Trim(Contrato(29, m))
               End If
            Else
               Doc2.Application.Selection.Text = DatosCond(1) & " " & Trim(Contrato(11, m)) & " + " & Format(Contrato(24, m), FDecimal) & "% + SPREAD " & "Base Cálculo " & Trim(Contrato(29, m))
            End If
         End If
      End If

      If Contrato(27, m) = 1 And Contrato(30, m) = 1 Then
         Doc2.Bookmarks("NomCli3").Select
         If Contrato(10, m) = "FIJA" Then
            Doc2.Application.Selection.Text = DatosCond(6) & " " & Trim(Contrato(10, m)) & " " & Format(Contrato(8, m), FDecimal) & "%" & " Base Cálculo " & Trim(Contrato(28, m))
         Else
            If Contrato(10, m) = "ICP" Then
               If NemoMon = "UF" Then
                  Doc2.Application.Selection.Text = DatosCond(6) & " " & Trim("TRA") & " " & Format(Contrato(19, m), FDecimal) + "% + SPREAD " & "Base Cálculo " & Contrato(28, m)
               End If
               If NemoMon = "CLP" Then
                  Doc2.Application.Selection.Text = DatosCond(6) & " " & Trim("TNA") & " " & Format(Contrato(19, m), FDecimal) + "% + SPREAD " & "Base Cálculo " & Contrato(28, m)
               End If
            Else
               Doc2.Application.Selection.Text = DatosCond(6) & " " & Trim(Contrato(10, m)) & " " & Format(Contrato(19, m), FDecimal) + "% + SPREAD " & "Base Cálculo " & Contrato(28, m)
            End If
         End If
      End If
   Next
   
   
   
'
'   Doc2.Bookmarks("NomBco5").Select
'   Doc2.Application.Selection.Text = DatosCond(1)

'   Doc2.Bookmarks("NomCli5").Select
'   Doc2.Application.Selection.Text = DatosCond(6)


  ' Grilla Recibimos
   For m = 1 To total
         Doc2.Bookmarks("GrillaCli").Select
      If contadorlineas >= 1 And Contrato(27, m) = 1 Then
         Doc2.Application.Selection.MoveDown Unit:=wdLine, Count:=A
         Doc2.Bookmarks.Add Name:="Prueba", Range:=Doc2.Application.Selection.Range
         Doc2.Bookmarks("Prueba").Select
         A = A + 1
      End If
      If Contrato(27, m) = 1 Then
         Doc2.Application.Selection.Text = Contrato(5, m)
         Doc2.Application.Selection.MoveRight Unit:=wdCell
         Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft

         Doc2.Application.Selection.Text = Contrato(6, m)
         Doc2.Application.Selection.MoveRight Unit:=wdCell
         Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft

         Doc2.Application.Selection.Text = Contrato(7, m)
         Doc2.Application.Selection.MoveRight Unit:=wdCell
         Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphCenter

         Doc2.Application.Selection.Text = NemoMon & " " & Format((Contrato(17, m)), "###,###,###,##0.###0")
         Doc2.Application.Selection.MoveRight Unit:=wdCell
         Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphCenter

         Doc2.Application.Selection.Text = NemoMon & " " & Format((Contrato(16, m)), "###,###,###,##0.###0")
         Doc2.Application.Selection.MoveRight Unit:=wdCell
         Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
         
         If Contrato(10, m) = "FIJA" Or Contrato(14, m) = 1 Then
            If Contrato(10, m) = "FIJA" Then
               Doc2.Application.Selection.Text = Format(Contrato(18, m), "###,###,###,##0.###0")
            Else
               Doc2.Application.Selection.Text = Contrato(10, m) & " + " & Format(Contrato(19, m), "###0.###0") & " %"
            End If
            Doc2.Application.Selection.MoveRight Unit:=wdCell
            Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
         Else
            Doc2.Application.Selection.Text = Contrato(10, m) & " + " & Format(Contrato(19, m), "###0.###0") & " %"
            Doc2.Application.Selection.MoveRight Unit:=wdCell
            Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
         End If
         
         contadorlineas = contadorlineas + 1
      End If
   Next
'

   Doc2.Bookmarks("Modalidad").Select
   Doc2.Application.Selection.Text = Contrato(4, i)
   Doc2.Application.Selection.Font.Bold = True

   Doc2.Bookmarks("NomBco6").Select
   Doc2.Application.Selection.Text = DatosCond(1)
   Doc2.Application.Selection.Font.Bold = True
   
   Doc2.Bookmarks("NomCli6").Select
   Doc2.Application.Selection.Text = DatosCond(6)
   Doc2.Application.Selection.Font.Bold = True

   contadorlineas = 1
   A = 1

    'Grilla Pagamos
    For m = 1 To total
        Doc2.Bookmarks("Grilla").Select

        If contadorlineas >= 1 And Contrato(27, m) = 2 Then
            Doc2.Application.Selection.MoveDown Unit:=wdLine, Count:=A
            Doc2.Bookmarks.Add Name:="Prueba", Range:=Doc2.Application.Selection.Range
            Doc2.Bookmarks("Prueba").Select
            A = A + 1
        End If

        If Contrato(27, m) = 2 Then
           Doc2.Application.Selection.Text = Contrato(5, m)
           Doc2.Application.Selection.MoveRight Unit:=wdCell
           Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft

           Doc2.Application.Selection.Text = Contrato(6, m)
           Doc2.Application.Selection.MoveRight Unit:=wdCell
           Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft

           Doc2.Application.Selection.Text = Contrato(7, m)
           Doc2.Application.Selection.MoveRight Unit:=wdCell
           Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphCenter

           Doc2.Application.Selection.Text = NemoMon & " " & Format((Contrato(22, m)), "###,###,###,##0.###0")
           Doc2.Application.Selection.MoveRight Unit:=wdCell
           Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphCenter

           Doc2.Application.Selection.Text = NemoMon & " " & Format((Contrato(21, m)), "###,###,###,##0.###0")
           Doc2.Application.Selection.MoveRight Unit:=wdCell
           Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft

         If Contrato(11, m) = "FIJA" Or Contrato(14, m) = 1 Then
            If Contrato(11, m) = "FIJA" Then
               Doc2.Application.Selection.Text = Format(Contrato(23, m), "###,###,###,##0.###0")
            Else
               Doc2.Application.Selection.Text = Contrato(11, m) & " + " & Format(Contrato(24, m), "###0.###0") & " %"
            End If
            Doc2.Application.Selection.MoveRight Unit:=wdCell
            Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
         Else
            Doc2.Application.Selection.Text = Contrato(11, m) & " + " & Format(Contrato(24, m), "###0.###0") & " %"
            Doc2.Application.Selection.MoveRight Unit:=wdCell
            Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
         End If

            contadorlineas = contadorlineas + 1

        End If

    Next
'
'    'Doc2.Bookmarks("ModalidadPago").Select
'    'Doc2.Application.Selection.Text = Contrato(4, 1)
'
'    Doc2.Bookmarks("NomBco7").Select
'    Doc2.Application.Selection.Text = DatosCond(3)
'   'Doc2.Bookmarks("RutRep7").Select
'   'Doc2.Application.Selection.Text = DatosCond(4)
'
'    Doc2.Bookmarks("RepCli8").Select
'    Doc2.Application.Selection.Text = DatosCond(8)
'   'Doc2.Bookmarks("RutCli8").Select
'   'Doc2.Application.Selection.Text = DatosCond(9)
'
'    Doc2.Bookmarks("RepBco9").Select
'    Doc2.Application.Selection.Text = DatosCond(21)
'   'Doc2.Bookmarks("RutRep9").Select
'   'Doc2.Application.Selection.Text = DatosCond(22)
'
'    Doc2.Bookmarks("RepCli10").Select
'    Doc2.Application.Selection.Text = DatosCond(23)
'   'Doc2.Bookmarks("RutCli10").Select
'   'Doc2.Application.Selection.Text = DatosCond(24)
'
'    Doc2.Bookmarks("NomBcoFir1").Select
'    Doc2.Application.Selection.Text = DatosCond(1)
'   'Doc2.Bookmarks("NomBcoFir2").Select
'   'Doc2.Application.Selection.Text = DatosCond(1)
'    Doc2.Bookmarks("NomCliFir1").Select
'    Doc2.Application.Selection.Text = DatosCond(6)
'   'Doc2.Bookmarks("NomCliFir2").Select
'   'Doc2.Application.Selection.Text = DatosCond(6)
'
'    ActiveDocument.SaveAs FileName:=DatosCond(20) & "\Contrato Swap de Tasas " & DatosCond(6) & ".doc"

    With BacContratoSwap
         Call FIRMAS(Doc2, "Nombre_Banco_12", .txtRutRepBco1, Trim(Mid(BacContratoSwap.cmbRepBco1.Text, 1, 60)), gsc_Parametros.direccion, gsc_Parametros.telefono, gsc_Parametros.fax, (BacFormatoRut(gsc_Parametros.Rut & "-" & gsc_Parametros.digrut)), .txtEntidad.Caption)
         Call FIRMAS(Doc2, "Nombre_Cliente_14", .txtRutRepBco2, Trim(Mid(BacContratoSwap.cmbRepBco2.Text, 1, 60)), gsc_Parametros.direccion, gsc_Parametros.telefono, gsc_Parametros.fax, (BacFormatoRut(gsc_Parametros.Rut & "-" & gsc_Parametros.digrut)), .txtEntidad.Caption)
    End With
    
Dim telefonocli As String
    Dim FaxCli As String
    Dim RutCli As String
    telefonocli = DatosCond(17)
    FaxCli = DatosCond(18)
    RutCli = DatosCond(7)

   If Len(Trim(BacContratoSwap.cmbRepCliente1.Text)) <> 0 And Len(Trim(BacContratoSwap.cmbRepCliente2.Text)) = 0 Or Len(Trim(BacContratoSwap.cmbRepCliente1.Text)) <> 0 And Len(Trim(BacContratoSwap.cmbRepCliente2.Text)) <> 0 Then
      With BacContratoSwap
         FIRMAS Doc2, "pp_cli", .txtRutRepCli1, Trim(Left(BacContratoSwap.cmbRepCliente1, Len(BacContratoSwap.cmbRepCliente1) - 15)), .txtDirecCli, telefonocli, FaxCli, RutCli, .txtCliente.Caption
      End With
      If Len(Trim(BacContratoSwap.cmbRepCliente2.Text)) <> 0 Then
         With BacContratoSwap
            FIRMAS Doc2, "pp_cli1", .txtRutRepCli2, Trim(Left(BacContratoSwap.cmbRepCliente2, Len(BacContratoSwap.cmbRepCliente2) - 15)), .txtDirecCli, telefonocli, FaxCli, RutCli, .txtCliente.Caption
         End With
      Else
         FIRMAS Doc2, "pp_cli1", "", "", BacContratoSwap.txtDirecCli, telefonocli, FaxCli, RutCli, BacContratoSwap.txtCliente.Caption
      End If
   ElseIf Len(Trim(BacContratoSwap.cmbRepCliente2.Text)) = 0 And Len(Trim(BacContratoSwap.cmbRepCliente2.Text)) <> 0 Then
      With BacContratoSwap
         FIRMAS Doc2, "pp_cli1", .txtRutRepCli2, Trim(Left(BacContratoSwap.cmbRepCliente2, Len(BacContratoSwap.cmbRepCliente2) - 15)), .txtDirecCli, telefonocli, FaxCli, RutCli, .txtCliente.Caption
      End With
   Else
      Call FIRMAS(Doc2, "pp_cli", "", "", BacContratoSwap.txtDirecCli, telefonocli, FaxCli, RutCli, BacContratoSwap.txtCliente.Caption)
      Call FIRMAS(Doc2, "pp_cli1", "", "", BacContratoSwap.txtDirecCli, telefonocli, FaxCli, RutCli, BacContratoSwap.txtCliente.Caption)
   End If
   
   Doc2.Application.Visible = True
   If Donde = "Impresora" Then
      ActiveDocument.PrintOut
   Else
      Doc2.Application.Visible = True
      Doc2.Application.WindowState = wdWindowStateMaximize
   End If
    
   Set Doc2 = Nothing

Exit Function
Control:
   Resume
    Call MsgBox("Problemas para crear Contrato!!. " & err.Description, vbInformation, Msj)
    Set Doc2 = Nothing
End Function

Function BacContratoSwapTasaICPBanco2(DatosCond(), NumOper, Donde) As Boolean
   On Error GoTo Control:
   Dim Doc2             As Word.Document
   Dim SQL              As String
   Dim i                As Integer
   Dim total            As Integer
   Dim NemoMon          As String
   Dim Paso             As String
   Dim Glosa            As String
   Dim Okk              As Boolean
   Dim contadorlineas
   Dim A, m
   Dim Datos()
   Dim Contrato() As Variant

   SQL = giSQL_DatabaseCommon
   SQL = SQL & "..SP_LEER_MONEDA "
   SQL = SQL & DatosCond(29)
   If MISQL.SQL_Execute(SQL) = 0 Then
      If MISQL.SQL_Fetch(Datos()) = 0 Then
         NemoMon = UCase(Datos(2))
      End If
   End If
   Set Doc2 = IniciaWordListadoLog("ContratoTasasBancoICP2", Okk)
   If Not Okk Then
      MsgBox "No podra ser Generado el contrato!", vbCritical, Msj
      BacContratoSwapTasaICPBanco2 = False
      Exit Function
   End If
   
   Doc2.Activate
   
   Doc2.Bookmarks("FECHA_PROCESO").Select
   Doc2.Application.Selection.Text = BacFormatoFecha("DDMMAA", gsBAC_Fecp)
   
   Doc2.Bookmarks("folio").Select
   Doc2.Application.Selection.Text = NumOper
   
   Doc2.Bookmarks("Nombre_Banco_1").Select
   Doc2.Application.Selection.Text = DatosCond(1)
   
   Doc2.Bookmarks("Rut_Banco_1").Select
   Doc2.Application.Selection.Text = DatosCond(2)
   
   Doc2.Bookmarks("Apoderado_Banco").Select
   Doc2.Application.Selection.Text = DatosCond(3)
   Doc2.Bookmarks("Rut_Apoderado_Banco").Select
   Doc2.Application.Selection.Text = DatosCond(4)
   
      If Len(Trim(DatosCond(21))) > 0 Then
      Doc2.Bookmarks("RepBco2").Select
      Doc2.Application.Selection.Text = DatosCond(21)
      Doc2.Bookmarks("RutRepBco2").Select
      Doc2.Application.Selection.Text = DatosCond(22)
   End If
   
   
    Doc2.Bookmarks("Direccion_Banco").Select
    Doc2.Application.Selection.Text = gsc_Parametros.direccion
   
    Doc2.Bookmarks("Nombre_Cliente_1").Select
    Doc2.Application.Selection.Text = DatosCond(6)
    
    Doc2.Bookmarks("rut_cliente").Select
    Doc2.Application.Selection.Text = DatosCond(7)
    
   Doc2.Bookmarks("Apoderado_Cliente").Select
   Doc2.Application.Selection.Text = DatosCond(8)
   Doc2.Bookmarks("Rut_Apoderado_Cliente").Select
   Doc2.Application.Selection.Text = DatosCond(9)
    
    If Len(Trim(DatosCond(23))) > 0 Then
      Doc2.Bookmarks("RepCli2").Select
      Doc2.Application.Selection.Text = DatosCond(23)
      Doc2.Bookmarks("RutRepCli2").Select
      Doc2.Application.Selection.Text = DatosCond(24)
   End If
   
    Doc2.Bookmarks("Direccion_Cliente").Select
   Doc2.Application.Selection.Text = gsc_Parametros.direccion
   
   Doc2.Bookmarks("fecha_gnral").Select
   Doc2.Application.Selection.Text = BacFormatoFecha("DDMMAA", BacContratoSwap.grdLista.TextMatrix(BacContratoSwap.grdLista.Row, 12))
   
   
'   Doc2.Bookmarks("DiaDe").Select
'   Doc2.Application.Selection.Text = DatosCond(12)
'   Doc2.Bookmarks("MesDe").Select
'   Doc2.Application.Selection.Text = DatosCond(13)
'   Doc2.Bookmarks("AñoDe").Select
'   Doc2.Application.Selection.Text = DatosCond(14)
'   Doc2.Bookmarks("NomBco").Select
'   Doc2.Application.Selection.Text = DatosCond(1)
'   Doc2.Bookmarks("RutBco").Select
'   Doc2.Application.Selection.Text = DatosCond(2)

'   Doc2.Bookmarks("DireccBco").Select
'   Doc2.Application.Selection.Text = DatosCond(5)
''
'   Doc2.Bookmarks("NomCli").Select
'   Doc2.Application.Selection.Text = DatosCond(6)
'   Doc2.Bookmarks("RutCli").Select
'   Doc2.Application.Selection.Text = DatosCond(7)
'
'   Doc2.Bookmarks("RepCli1").Select
'   Doc2.Application.Selection.Text = DatosCond(8)
'   Doc2.Bookmarks("RutRepCli1").Select
'   Doc2.Application.Selection.Text = DatosCond(9)
'   If Len(Trim(DatosCond(23))) > 0 Then
'      Doc2.Bookmarks("RepCli2").Select
'      Doc2.Application.Selection.Text = DatosCond(23)
'      Doc2.Bookmarks("RutRepCli2").Select
'      Doc2.Application.Selection.Text = DatosCond(24)
'   End If
'   Doc2.Bookmarks("DireccCli").Select
'   Doc2.Application.Selection.Text = DatosCond(10)
'   Doc2.Bookmarks("NomCli1").Select
'   Doc2.Application.Selection.Text = DatosCond(6)
'
'   Doc2.Bookmarks("DiaCond").Select
'   Doc2.Application.Selection.Text = DatosCond(31)
'   Doc2.Bookmarks("MesCond").Select
'   Doc2.Application.Selection.Text = DatosCond(32)
'   Doc2.Bookmarks("AñoCond").Select
'   Doc2.Application.Selection.Text = DatosCond(33)
'
   Doc2.Bookmarks("ConFin1").Select
   Doc2.Application.Selection.Text = DatosCond(1) & " : " & NemoMon & " " & Format(DatosCond(30), "###,###,###,##0.###0")
   Doc2.Bookmarks("ConFin2").Select
   Doc2.Application.Selection.Text = DatosCond(6) & " : " & NemoMon & " " & Format(DatosCond(30), "###,###,###,##0.###0")

   Doc2.Bookmarks("NomBco3").Select
   Doc2.Application.Selection.Text = DatosCond(1)
   Doc2.Bookmarks("NomCli3").Select
   Doc2.Application.Selection.Text = DatosCond(6)

   Doc2.Bookmarks("FechaIni").Select
   Doc2.Application.Selection.Text = DatosCond(27)

   Doc2.Bookmarks("Lugar").Select
   Doc2.Application.Selection.Text = "SANTIAGO, CHILE"

   Doc2.Bookmarks("NomBco4").Select
   Doc2.Application.Selection.Text = DatosCond(1)
   Doc2.Bookmarks("NomCli4").Select
   Doc2.Application.Selection.Text = DatosCond(6)

   contadorlineas = 1
   A = 1
   'ReDim Preserve Contrato(27, 1) 'PRD-7904
   ReDim Preserve Contrato(29, 1)
   'For i = 1 To 27'PRD-7904
   For i = 1 To 29
      Contrato(i, 1) = "**"
   Next

   'SQL = "EXECUTE SP_DATOSCONTRATO " & NumOper
   SQL = "EXECUTE SP_DATOSCONTRATO_TODOSFLUJOS " & NumOper
   If MISQL.SQL_Execute(SQL$) = 0 Then
      i = 1
      While MISQL.SQL_Fetch(Datos()) = 0
         'ReDim Preserve Contrato(27, i) 'PRD-7904
         ReDim Preserve Contrato(29, i)
         Contrato(1, i) = Datos(1)                                       'Tipo_operacion
         Contrato(2, i) = Datos(2)                                       'MontoOperacion
         Contrato(3, i) = Datos(3)                                       'TasaConversion
         Contrato(4, i) = Datos(4)                                       'Modalidad
         Contrato(5, i) = Datos(5)                                       'fechainicioflujo
         Contrato(6, i) = Datos(6)                                       'fechavenceflujo
         Contrato(7, i) = Datos(7)                                       'dias
         Contrato(8, i) = BacStrTran((Datos(8)), ".", gsc_PuntoDecim)    'compra_valor_tasa
         Contrato(9, i) = BacStrTran((Datos(9)), ".", gsc_PuntoDecim)    'venta_valor_tasa
         Contrato(10, i) = Datos(10)                                     'nombretasacompra
         Contrato(11, i) = Datos(11)                                     'nombretasaventa
         Contrato(12, i) = Datos(12)                                     'pagamosdoc
         Contrato(13, i) = Datos(13)                                     'recibimosdoc
         Contrato(14, i) = Datos(14)                                     'numero_flujo
         Contrato(15, i) = BacStrTran((Datos(15)), ".", gsc_PuntoDecim)  'compra_capital
         Contrato(16, i) = BacStrTran((Datos(16)), ".", gsc_PuntoDecim)  'compra_amortiza
         Contrato(17, i) = BacStrTran((Datos(17)), ".", gsc_PuntoDecim)  'compra_saldo
         Contrato(17, i) = CDbl(Contrato(16, i)) + CDbl(Contrato(17, i))
         Contrato(18, i) = Datos(18)                                     'compra_interes
         Contrato(19, i) = Datos(19)                                     'compra_spread
         Contrato(20, i) = Datos(20)                                     'venta_capital
         Contrato(21, i) = BacStrTran((Datos(21)), ".", gsc_PuntoDecim)  'venta_amortiza
         Contrato(22, i) = BacStrTran((Datos(22)), ".", gsc_PuntoDecim)  'venta_saldo
         Contrato(22, i) = CDbl(Contrato(21, i)) + CDbl(Contrato(22, i))
         Contrato(23, i) = Datos(23)                                     'venta_interes
         Contrato(24, i) = Datos(24)                                     'venta_spread
         Contrato(25, i) = Datos(25)                                     'pagamos_moneda
         Contrato(26, i) = Datos(26)                                     'recibimos_moneda
         Contrato(27, i) = Datos(27)                                     'tipo_flujo
         Contrato(28, i) = Datos(46)                                     'CompraGlosaBase 'PRD-7904
         Contrato(29, i) = Datos(47)                                     'VentaGlosaBase 'PRD-7904
        
         i = i + 1
      Wend
      i = i - 1
   Else
      MsgBox "Datos necesarios para generar Contrato no han sido encontrados !!", vbCritical, Msj
      Set Doc2 = Nothing
      Exit Function
   End If
   total = i
'
   Doc2.Bookmarks("FechaVenc").Select
   Doc2.Application.Selection.Text = Contrato(6, i)

   Doc2.Bookmarks("FormaPago").Select
    Doc2.Application.Selection.Text = "MONEDA NACIONAL: " & IIf((Contrato(12, i) <> ""), (Contrato(12, i)), "N/A")
    
    Doc2.Bookmarks("FormaPago2").Select
    Doc2.Application.Selection.Text = "MONEDA EXTRANJERA: " & IIf((Contrato(13, i) <> ""), (Contrato(13, i)), "N/A")

   Doc2.Bookmarks("PlazoContrato").Select
   Doc2.Application.Selection.Text = Abs(DateDiff("D", CDate(DatosCond(27)), CDate(Contrato(6, i))))

   If Contrato(1, 1) = "C" Then
      Glosa = Contrato(11, 1)
   Else
      Glosa = Contrato(10, 1)
   End If

   If Datos(7) >= 30 And Datos(7) < 41 Then
      Glosa = Glosa & " 30 DIAS"
   ElseIf Datos(7) >= 90 And Datos(7) < 101 Then
      Glosa = Glosa & " 90 DIAS"
   ElseIf Datos(7) >= 180 And Datos(7) < 191 Then
      Glosa = Glosa & " 180 DIAS"
   ElseIf Datos(7) >= 360 Then
      Glosa = Glosa & " 360 DIAS"
   End If

   For m = 1 To total
      If Contrato(27, m) = 2 And Contrato(14, m) = 1 Then
         Doc2.Bookmarks("TasaBco").Select
         If Contrato(11, m) = "FIJA" Then
            Doc2.Application.Selection.Text = Format(Contrato(9, m), "###0.###0") & " % "
            Doc2.Bookmarks("FijaVarBco").Select
            Doc2.Application.Selection.Text = Contrato(11, m)
         
            'PRD-7904
            Doc2.Bookmarks("BaseBco").Select
            Doc2.Application.Selection.Text = "Base Cálculo " & Contrato(29, m)
         
         Else
            Doc2.Application.Selection.Text = Contrato(11, m) & " + " & Format(Contrato(24, m), "###0.###0") & " %"
            Doc2.Bookmarks("FijaVarBco").Select
            Doc2.Application.Selection.Text = Contrato(11, m) & " + SPREAD"
         
            'PRD-7904
            Doc2.Bookmarks("BaseBco").Select
            Doc2.Application.Selection.Text = "Base Cálculo " & Contrato(29, m)
         
         End If
      End If
      If Contrato(27, m) = 1 And Contrato(14, m) = 1 Then
         Doc2.Bookmarks("TasaCli").Select

         If Contrato(10, m) = "FIJA" Then
            Doc2.Application.Selection.Text = Format(Contrato(8, m), "###0.###0") & " % "
            Doc2.Bookmarks("FijaVarCli").Select
            Doc2.Application.Selection.Text = Contrato(10, m)
         
            'PRD-7904
            Doc2.Bookmarks("BaseCli").Select
            Doc2.Application.Selection.Text = "Base Cálculo " & Contrato(28, m)
         
         
         Else
            Doc2.Application.Selection.Text = Contrato(10, m) & " + " & Format(Contrato(19, m), "###0.###0") & " %"
            Doc2.Bookmarks("FijaVarCli").Select
            Doc2.Application.Selection.Text = Contrato(10, m) & " + SPREAD"
         
            'PRD-7904
            Doc2.Bookmarks("BaseCli").Select
            Doc2.Application.Selection.Text = "Base Cálculo " & Contrato(28, m)
         
         End If
      End If
   Next
   Doc2.Application.Visible = True
'
'   Doc2.Bookmarks("NomBco5").Select
'   Doc2.Application.Selection.Text = DatosCond(1)

'   Doc2.Bookmarks("NomCli5").Select
'   Doc2.Application.Selection.Text = DatosCond(6)

'
'   'Grilla Recibimos
   For m = 1 To total
         Doc2.Bookmarks("GrillaCli").Select
      If contadorlineas >= 1 And Contrato(27, m) = 1 Then
         Doc2.Application.Selection.MoveDown Unit:=wdLine, Count:=A
         Doc2.Bookmarks.Add Name:="Prueba", Range:=Doc2.Application.Selection.Range
         Doc2.Bookmarks("Prueba").Select
         A = A + 1
      End If
      If Contrato(27, m) = 1 Then
         Doc2.Application.Selection.Text = Contrato(5, m)
         Doc2.Application.Selection.MoveRight Unit:=wdCell
         Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft

         Doc2.Application.Selection.Text = Contrato(6, m)
         Doc2.Application.Selection.MoveRight Unit:=wdCell
         Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft

         Doc2.Application.Selection.Text = Contrato(7, m)
         Doc2.Application.Selection.MoveRight Unit:=wdCell
         Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphCenter

         Doc2.Application.Selection.Text = NemoMon & " " & Format((Contrato(17, m)), "###,###,###,##0.###0")
         Doc2.Application.Selection.MoveRight Unit:=wdCell
         Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphCenter

         Doc2.Application.Selection.Text = NemoMon & " " & Format((Contrato(16, m)), "###,###,###,##0.###0")
         Doc2.Application.Selection.MoveRight Unit:=wdCell
         Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
         
         
         If Contrato(10, m) = "FIJA" Or Contrato(14, m) = 1 Then
            Doc2.Application.Selection.Text = Contrato(8, m) & " % "
            Doc2.Application.Selection.MoveRight Unit:=wdCell
            Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
         Else
            Doc2.Application.Selection.Text = Contrato(10, m) & " + " & Format(Contrato(19, m), "###0.###0") & " %"
            Doc2.Application.Selection.MoveRight Unit:=wdCell
            Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
         End If
         
         Doc2.Application.Selection.Text = Format(Contrato(23, i), "###,###,###,##0.###0")
         Doc2.Application.Selection.MoveRight Unit:=wdCell
         Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
         
         contadorlineas = contadorlineas + 1
      End If
   Next

   Doc2.Bookmarks("NomBco6").Select
   Doc2.Application.Selection.Text = DatosCond(1)
   Doc2.Bookmarks("NomCli6").Select
   Doc2.Application.Selection.Text = DatosCond(6)

   contadorlineas = 1
   A = 1

    'Grilla Pagamos
    For m = 1 To total
        Doc2.Bookmarks("Grilla").Select

        If contadorlineas >= 1 And Contrato(27, m) = 2 Then
            Doc2.Application.Selection.MoveDown Unit:=wdLine, Count:=A
            Doc2.Bookmarks.Add Name:="Prueba", Range:=Doc2.Application.Selection.Range
            Doc2.Bookmarks("Prueba").Select
            A = A + 1
        End If

        If Contrato(27, m) = 2 Then
           Doc2.Application.Selection.Text = Contrato(5, m)
           Doc2.Application.Selection.MoveRight Unit:=wdCell
           Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft

           Doc2.Application.Selection.Text = Contrato(6, m)
           Doc2.Application.Selection.MoveRight Unit:=wdCell
           Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft

           Doc2.Application.Selection.Text = Contrato(7, m)
           Doc2.Application.Selection.MoveRight Unit:=wdCell
           Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphCenter

           Doc2.Application.Selection.Text = NemoMon & " " & Format((Contrato(22, m)), "###,###,###,##0.###0")
           Doc2.Application.Selection.MoveRight Unit:=wdCell
           Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphCenter

           Doc2.Application.Selection.Text = NemoMon & " " & Format((Contrato(21, m)), "###,###,###,##0.###0")
           Doc2.Application.Selection.MoveRight Unit:=wdCell
           Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
           
           

           If Contrato(11, m) = "FIJA" Or Contrato(14, m) = 1 Then
                Doc2.Application.Selection.Text = Contrato(9, m) & " % "
                Doc2.Application.Selection.MoveRight Unit:=wdCell
                Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft

           Else
                Doc2.Application.Selection.Text = Contrato(11, m) & " + " & Format(Contrato(24, m), "###0.###0") & " %"
                Doc2.Application.Selection.MoveRight Unit:=wdCell
                Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft

           End If


         Doc2.Application.Selection.Text = Format(Contrato(18, i), "###,###,###,##0.###0")
         Doc2.Application.Selection.MoveRight Unit:=wdCell
         Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
         
            contadorlineas = contadorlineas + 1

        End If

    Next
'
'    'Doc2.Bookmarks("ModalidadPago").Select
'    'Doc2.Application.Selection.Text = Contrato(4, 1)
'
'    Doc2.Bookmarks("NomBco7").Select
'    Doc2.Application.Selection.Text = DatosCond(3)
'   'Doc2.Bookmarks("RutRep7").Select
'   'Doc2.Application.Selection.Text = DatosCond(4)
'
'    Doc2.Bookmarks("RepCli8").Select
'    Doc2.Application.Selection.Text = DatosCond(8)
'   'Doc2.Bookmarks("RutCli8").Select
'   'Doc2.Application.Selection.Text = DatosCond(9)
'
'    Doc2.Bookmarks("RepBco9").Select
'    Doc2.Application.Selection.Text = DatosCond(21)
'   'Doc2.Bookmarks("RutRep9").Select
'   'Doc2.Application.Selection.Text = DatosCond(22)
'
'    Doc2.Bookmarks("RepCli10").Select
'    Doc2.Application.Selection.Text = DatosCond(23)
'   'Doc2.Bookmarks("RutCli10").Select
'   'Doc2.Application.Selection.Text = DatosCond(24)
'
'    Doc2.Bookmarks("NomBcoFir1").Select
'    Doc2.Application.Selection.Text = DatosCond(1)
'   'Doc2.Bookmarks("NomBcoFir2").Select
'   'Doc2.Application.Selection.Text = DatosCond(1)
'    Doc2.Bookmarks("NomCliFir1").Select
'    Doc2.Application.Selection.Text = DatosCond(6)
'   'Doc2.Bookmarks("NomCliFir2").Select
'   'Doc2.Application.Selection.Text = DatosCond(6)
'
'    ActiveDocument.SaveAs FileName:=DatosCond(20) & "\Contrato Swap de Tasas " & DatosCond(6) & ".doc"

    With BacContratoSwap
         Call FIRMAS(Doc2, "Nombre_Banco_12", .txtRutRepBco1, Trim(Mid(BacContratoSwap.cmbRepBco1.Text, 1, 60)), gsc_Parametros.direccion, gsc_Parametros.telefono, gsc_Parametros.fax, (BacFormatoRut(gsc_Parametros.Rut & "-" & gsc_Parametros.digrut)), .txtEntidad.Caption)
         Call FIRMAS(Doc2, "Nombre_Cliente_14", .txtRutRepBco2, Trim(Mid(BacContratoSwap.cmbRepBco2.Text, 1, 60)), gsc_Parametros.direccion, gsc_Parametros.telefono, gsc_Parametros.fax, (BacFormatoRut(gsc_Parametros.Rut & "-" & gsc_Parametros.digrut)), .txtEntidad.Caption)
    End With
    
Dim telefonocli As String
    Dim FaxCli As String
    Dim RutCli As String
    telefonocli = DatosCond(17)
    FaxCli = DatosCond(18)
    RutCli = DatosCond(7)

If Len(BacContratoSwap.cmbRepCliente1.Text) <> 0 And Len(BacContratoSwap.cmbRepCliente2.Text) = 0 Or Len(BacContratoSwap.cmbRepCliente1.Text) <> 0 And Len(BacContratoSwap.cmbRepCliente2.Text) <> 0 Then

        With BacContratoSwap
     
         FIRMAS Doc2, "pp_cli", .txtRutRepCli1, Trim(Left(BacContratoSwap.cmbRepCliente1, Len(BacContratoSwap.cmbRepCliente1) - 15)), .txtDirecCli, telefonocli, FaxCli, RutCli, .txtCliente.Caption
         
        End With
                                                                            
           If Len(BacContratoSwap.cmbRepCliente2.Text) <> 0 Then

            With BacContratoSwap
            
            FIRMAS Doc2, "pp_cli1", .txtRutRepCli2, Trim(Left(BacContratoSwap.cmbRepCliente2, Len(BacContratoSwap.cmbRepCliente2) - 15)), .txtDirecCli, telefonocli, FaxCli, RutCli, .txtCliente.Caption '(BacFormatoRut(.Txt_RutCli2.Text & "-" & .Txt_Digcli2.Text)), .Cmb_ApoCli2.Text, gsDireccion, telefonocli, faxcli, (BacFormatoRut(gsCodigo & "-" & gsDigito)), cliente.clnombre
            
            End With
        
            End If
            
          ElseIf Len(BacContratoSwap.cmbRepCliente2.Text) = 0 And Len(BacContratoSwap.cmbRepCliente2.Text) <> 0 Then

        With BacContratoSwap
          FIRMAS Doc2, "pp_cli1", .txtRutRepCli2, Trim(Left(BacContratoSwap.cmbRepCliente2, Len(BacContratoSwap.cmbRepCliente2) - 15)), .txtDirecCli, telefonocli, FaxCli, RutCli, .txtCliente.Caption
          
        End With
          End If
    If Donde = "Impresora" Then
        ActiveDocument.PrintOut
    Else
        Doc2.Application.Visible = True
         Doc2.Application.WindowState = wdWindowStateMaximize
    End If
    
   Set Doc2 = Nothing

Exit Function

Control:
   Resume
    MsgBox "Problemas para crear Contrato!!. " & err.Description, vbInformation, Msj
    Set Doc2 = Nothing

End Function




Public Function BacContratoSwapTasaICPBancoNuevo(Apoderados(), NumOper, Donde) As Boolean
   On Error GoTo ErrorImprimir
   Dim Doc              As Word.Document
   Dim Status           As Boolean
   Dim NemoMon          As String
   Dim fecha_gnral      As String
   Dim VarPaso          As String
   Dim nPuntero         As Long
   Dim nFirstCompra     As Long
   Dim nFirsVenta       As Long
   Dim nContador        As Long
   Dim DatosContrato()
   
   Const nTipoFlujo = 27
   Const nNumFlujo = 14
   
   Let BacContratoSwapTasaICPBancoNuevo = False
   Let Screen.MousePointer = vbHourglass
   
   Let NemoMon = BacRetornoNemoMoneda(Apoderados(29))
   Let fecha_gnral = BacFormatoFecha("DDMMAA", BacContratoSwap.grdLista.TextMatrix(BacContratoSwap.grdLista.Row, 12))
   
   If LoadDataContrato(CDbl(NumOper), DatosContrato(), nPuntero, nFirstCompra, nFirsVenta) = False Then
      Exit Function
   End If
   
   Set Doc = IniciaWordListadoLog("ContratoTasasBancoICP2", Status)
   If Not Status Then
      Call MsgBox("Se ha generado un error inesperado en la generacion del Contrato.!", vbExclamation, App.Title)
      Exit Function
   End If


   Call Doc.Activate
   'Let Doc.Application.Visible = True

   Call Doc.Bookmarks("folio").Select:                   Let Doc.Application.Selection.Text = NumOper:                                       Let Doc.Application.Selection.Font.Bold = True
   Call Doc.Bookmarks("FECHA_PROCESO").Select:           Let Doc.Application.Selection.Text = BacFormatoFecha("DDMMAA", Apoderados(28)):     Let Doc.Application.Selection.Font.Bold = True

    Let Doc.ActiveWindow.View.Type = wdPrintView

   Call Doc.Bookmarks("Nombre_Banco_1").Select:          Let Doc.Application.Selection.Text = Apoderados(1):             Let Doc.Application.Selection.Font.Bold = True
   Call Doc.Bookmarks("Rut_Banco_1").Select:             Let Doc.Application.Selection.Text = Apoderados(2):             Let Doc.Application.Selection.Font.Bold = True
   Call Doc.Bookmarks("Apoderado_Banco").Select:         Let Doc.Application.Selection.Text = Apoderados(3):             Let Doc.Application.Selection.Font.Bold = True
   
   If Len(Trim(Apoderados(21))) > 0 Then
      Call Doc.Bookmarks("RepBco2").Select:              Let Doc.Application.Selection.Text = Apoderados(21):            Let Doc.Application.Selection.Font.Bold = True
      Call Doc.Bookmarks("RutRepBco2").Select:           Let Doc.Application.Selection.Text = Apoderados(22):            Let Doc.Application.Selection.Font.Bold = True
   End If

   Call Doc.Bookmarks("Direccion_Banco").Select:        Let Doc.Application.Selection.Text = gsc_Parametros.direccion:   Let Doc.Application.Selection.Font.Bold = True
   Call Doc.Bookmarks("Nombre_Cliente_1").Select:       Let Doc.Application.Selection.Text = Apoderados(6):              Let Doc.Application.Selection.Font.Bold = True
   Call Doc.Bookmarks("rut_cliente").Select:            Let Doc.Application.Selection.Text = Apoderados(7):              Let Doc.Application.Selection.Font.Bold = True
   Call Doc.Bookmarks("Apoderado_Cliente").Select:      Let Doc.Application.Selection.Text = Apoderados(8):              Let Doc.Application.Selection.Font.Bold = True
   Call Doc.Bookmarks("Rut_Apoderado_Cliente").Select:  Let Doc.Application.Selection.Text = Apoderados(9):              Let Doc.Application.Selection.Font.Bold = True

   If Len(Trim(Apoderados(23))) > 0 Then
      Call Doc.Bookmarks("RepCli2").Select:              Let Doc.Application.Selection.Text = Apoderados(23):            Let Doc.Application.Selection.Font.Bold = True
      Call Doc.Bookmarks("RutRepCli2").Select:           Let Doc.Application.Selection.Text = Apoderados(24):            Let Doc.Application.Selection.Font.Bold = True
   End If

   Call Doc.Bookmarks("Direccion_Cliente").Select:       Let Doc.Application.Selection.Text = Apoderados(10):            Let Doc.Application.Selection.Font.Bold = True
   Call Doc.Bookmarks("fecha_gnral").Select:             Let Doc.Application.Selection.Text = fecha_gnral

    Let VarPaso = Apoderados(1) & Space(35 - Len(Trim(Apoderados(1)))) & " : " & NemoMon & " " & Format(Apoderados(30), "###,###,###,##0.###0")
   Call Doc.Bookmarks("ConFin1").Select:                 Let Doc.Application.Selection.Text = Trim(VarPaso)

    Let VarPaso = Apoderados(6) & Space(35 - Len(Trim(Apoderados(6)))) & " : " & NemoMon & " " & Format(Apoderados(30), "###,###,###,##0.###0")
   Call Doc.Bookmarks("ConFin2").Select:                 Let Doc.Application.Selection.Text = Trim(VarPaso)

    Let VarPaso = Abs(DateDiff("D", CDate(Apoderados(27)), CDate(DatosContrato(6, i))))
   Call Doc.Bookmarks("PlazoContrato").Select:           Let Doc.Application.Selection.Text = 0 '--> VarPaso

   Call Doc.Bookmarks("FechaIni").Select:                Let Doc.Application.Selection.Text = Apoderados(27)
   Call Doc.Bookmarks("FechaVenc").Select:               Let Doc.Application.Selection.Text = DatosContrato(6, nPuntero)

   Let VarPaso = Apoderados(1)
   If DatosContrato(11, nFirsVenta) = "FIJA" Then
      Let VarPaso = VarPaso & " " & Format(DatosContrato(9, nFirsVenta), "###0.###0") & "% " & DatosContrato(11, nFirsVenta)
      Let VarPaso = VarPaso & " Base Cálculo " & DatosContrato(29, nFirsVenta)
   Else
      Let VarPaso = VarPaso & " " & DatosContrato(11, nFirsVenta) & " + " & Format(DatosContrato(9, nFirsVenta), "###0.###0") & "% "
      Let VarPaso = VarPaso & " Base Cálculo " & DatosContrato(29, nFirsVenta) & " + SPREAD"
   End If
   Call Doc.Bookmarks("TasaInteresPactada1").Select:     Let Doc.Application.Selection.Text = VarPaso
    
    Let VarPaso = Apoderados(6)
   If DatosContrato(10, nFirstCompra) = "FIJA" Then
      Let VarPaso = VarPaso & " " & Format(DatosContrato(8, nFirstCompra), "###0.###0") & "% " & DatosContrato(10, nFirstCompra)
      Let VarPaso = VarPaso & " Base Cálculo " & DatosContrato(28, nFirstCompra)
   Else
      Let VarPaso = VarPaso & " " & DatosContrato(10, nFirstCompra) & " + " & Format(DatosContrato(8, nFirstCompra), "###0.###0") & "% "
      Let VarPaso = VarPaso & " Base Cálculo " & DatosContrato(28, nFirstCompra) & " + SPREAD"
   End If
   Call Doc.Bookmarks("TasaInteresPactada2").Select:     Let Doc.Application.Selection.Text = VarPaso
   Call Doc.Bookmarks("Lugar").Select:                   Let Doc.Application.Selection.Text = "SANTIAGO, CHILE"
   
    Let VarPaso = Trim(FuncEntregaBacoRef(NumOper))
    Let VarPaso = Replace(VarPaso, ", CHILE", "")
   Call Doc.Bookmarks("BANCO_REFERENCIA").Select:        Let Doc.Application.Selection.Text = VarPaso
   

   Let VarPaso = "MONEDA NACIONAL   : " & IIf((DatosContrato(12, nPuntero) <> ""), (DatosContrato(12, nPuntero)), "N/A")
   Call Doc.Bookmarks("FormaPago").Select:               Let Doc.Application.Selection.Text = VarPaso

   Let VarPaso = "MONEDA EXTRANJERA : " & IIf((DatosContrato(13, nPuntero) <> ""), (DatosContrato(13, nPuntero)), "N/A")
   Call Doc.Bookmarks("FormaPago2").Select:              Let Doc.Application.Selection.Text = VarPaso
   
   Call Doc.Bookmarks("valuta").Select:                  Let Doc.Application.Selection.Text = ""
   Call Doc.Bookmarks("OBS").Select:                     Let Doc.Application.Selection.Text = ""
   
   Call Doc.Bookmarks("NomBco4").Select:                 Let Doc.Application.Selection.Text = Apoderados(1):   Let Doc.Application.Selection.Font.Bold = True
   Call Doc.Bookmarks("NomCli4").Select:                 Let Doc.Application.Selection.Text = Apoderados(6):   Let Doc.Application.Selection.Font.Bold = True
   
   Call Doc.Bookmarks("NomCli6").Select:                 Let Doc.Application.Selection.Text = Apoderados(6):   Let Doc.Application.Selection.Font.Bold = True
   Call Doc.Bookmarks("NomBco6").Select:                 Let Doc.Application.Selection.Text = Apoderados(1):   Let Doc.Application.Selection.Font.Bold = True
   
   Dim nLinea  As Long
   Let nLinea = 1
   
   Dim nCelda  As Long
   Let nCelda = 1
   
   For nContador = nFirsVenta To nPuntero
      Call Doc.Bookmarks("Grilla").Select

      If nLinea >= 1 And DatosContrato(nTipoFlujo, nContador) = 2 Then
         Call Doc.Application.Selection.MoveDown(Unit:=wdLine, Count:=nCelda): Call Doc.Bookmarks.Add(Name:="Boock01", Range:=Doc.Application.Selection.Range): Call Doc.Bookmarks("Boock01").Select
         Let nCelda = nCelda + 1
      End If
      If DatosContrato(nTipoFlujo, nContador) = 2 Then
         Let Doc.Application.Selection.Text = DatosContrato(5, nContador): Call Doc.Application.Selection.MoveRight(Unit:=wdCell): Let Doc.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
         Let Doc.Application.Selection.Text = DatosContrato(6, nContador): Call Doc.Application.Selection.MoveRight(Unit:=wdCell): Let Doc.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
         Let Doc.Application.Selection.Text = DatosContrato(7, nContador): Call Doc.Application.Selection.MoveRight(Unit:=wdCell): Let Doc.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphCenter

         Let VarPaso = NemoMon & " " & Format((DatosContrato(22, nContador)), "###,###,###,##0.###0")
         Let Doc.Application.Selection.Text = VarPaso:                     Call Doc.Application.Selection.MoveRight(Unit:=wdCell): Let Doc.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphCenter
         
         Let VarPaso = NemoMon & " " & Format((DatosContrato(21, nContador)), "###,###,###,##0.###0")
         Let Doc.Application.Selection.Text = VarPaso:                     Call Doc.Application.Selection.MoveRight(Unit:=wdCell): Let Doc.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft

         If DatosContrato(11, nContador) = "FIJA" Or DatosContrato(14, nContador) = 1 Then
            Let VarPaso = DatosContrato(9, nContador) & " % "
            Let Doc.Application.Selection.Text = VarPaso:                  Call Doc.Application.Selection.MoveRight(Unit:=wdCell): Let Doc.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
         Else
            Let VarPaso = DatosContrato(11, nContador) & " + " & Format(DatosContrato(24, nContador), "###0.###0") & " %"
            Let Doc.Application.Selection.Text = VarPaso:                  Call Doc.Application.Selection.MoveRight(Unit:=wdCell): Let Doc.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
         End If

         Let VarPaso = Format(DatosContrato(18, nContador), "###,###,###,##0.###0")
         Let Doc.Application.Selection.Text = VarPaso:                     Call Doc.Application.Selection.MoveRight(Unit:=wdCell): Let Doc.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
         
         Let nLinea = nLinea + 1
      End If
   Next nContador
   
   Let nLinea = 1
   Let nCelda = 1
   
   For nContador = nFirscompra To nPuntero
      Call Doc.Bookmarks("GrillaCli").Select
      
      If nLinea >= 1 And DatosContrato(nTipoFlujo, nContador) = 1 Then
         Call Doc.Application.Selection.MoveDown(Unit:=wdLine, Count:=nCelda):   Call Doc.Bookmarks.Add(Name:="Boock02", Range:=Doc.Application.Selection.Range): Call Doc.Bookmarks("Boock02").Select
         Let nCelda = nCelda + 1
      End If
      If DatosContrato(nTipoFlujo, nContador) = 1 Then
         Let Doc.Application.Selection.Text = DatosContrato(5, nContador):       Call Doc.Application.Selection.MoveRight(Unit:=wdCell): Let Doc.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
         Let Doc.Application.Selection.Text = DatosContrato(6, nContador):       Call Doc.Application.Selection.MoveRight(Unit:=wdCell): Let Doc.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
         Let Doc.Application.Selection.Text = DatosContrato(7, nContador):       Call Doc.Application.Selection.MoveRight(Unit:=wdCell): Let Doc.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphCenter
         
         Let VarPaso = NemoMon & " " & Format((DatosContrato(17, nContador)), "###,###,###,##0.###0")
         Let Doc.Application.Selection.Text = VarPaso:                           Call Doc.Application.Selection.MoveRight(Unit:=wdCell): Let Doc.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphCenter

         Let VarPaso = NemoMon & " " & Format((DatosContrato(16, nContador)), "###,###,###,##0.###0")
         Let Doc.Application.Selection.Text = VarPaso:                           Call Doc.Application.Selection.MoveRight(Unit:=wdCell): Let Doc.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
         
         If DatosContrato(10, nContador) = "FIJA" Or DatosContrato(14, nContador) = 1 Then
            Let VarPaso = Format(DatosContrato(8, nContador), "###0.###0") & " % "
            Let Doc.Application.Selection.Text = VarPaso:                        Call Doc.Application.Selection.MoveRight(Unit:=wdCell): Let Doc.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
         Else
            Let VarPaso = DatosContrato(10, nContador) & " + " & Format(DatosContrato(19, nContador), "###0.###0") & " %"
            Let Doc.Application.Selection.Text = VarPaso:                        Call Doc.Application.Selection.MoveRight(Unit:=wdCell): Let Doc.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
         End If

         Let VarPaso = Format(DatosContrato(23, nContador), "###,###,###,##0.###0")
         Let Doc.Application.Selection.Text = VarPaso:                           Call Doc.Application.Selection.MoveRight(Unit:=wdCell): Let Doc.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft

         Let nLinea = nLinea + 1
      End If

   Next nContador
   
   With BacContratoSwap
      Call FIRMAS(Doc, "Nombre_Banco_12", .txtRutRepBco1, Trim(Mid(BacContratoSwap.cmbRepBco1.Text, 1, 60)), gsc_Parametros.direccion, gsc_Parametros.telefono, gsc_Parametros.fax, (BacFormatoRut(gsc_Parametros.Rut & "-" & gsc_Parametros.digrut)), .txtEntidad.Caption)
      Call FIRMAS(Doc, "Nombre_Cliente_14", .txtRutRepBco2, Trim(Mid(BacContratoSwap.cmbRepBco2.Text, 1, 60)), gsc_Parametros.direccion, gsc_Parametros.telefono, gsc_Parametros.fax, (BacFormatoRut(gsc_Parametros.Rut & "-" & gsc_Parametros.digrut)), .txtEntidad.Caption)
   End With

   Dim telefonocli   As String
   Dim FaxCli        As String
   Dim RutCli        As String
   
   Let telefonocli = Apoderados(17)
   Let FaxCli = Apoderados(18)
   Let RutCli = Apoderados(7)

   If Len(Trim(BacContratoSwap.cmbRepCliente1.Text)) <> 0 And Len(Trim(BacContratoSwap.cmbRepCliente2.Text)) = 0 Or Len(Trim(BacContratoSwap.cmbRepCliente1.Text)) <> 0 And Len(Trim(BacContratoSwap.cmbRepCliente2.Text)) <> 0 Then
      With BacContratoSwap
         Call FIRMAS(Doc, "pp_cli", .txtRutRepCli1, Trim(Left(BacContratoSwap.cmbRepCliente1, Len(BacContratoSwap.cmbRepCliente1) - 15)), .txtDirecCli, telefonocli, FaxCli, RutCli, .txtCliente.Caption)
      End With
      If Len(Trim(BacContratoSwap.cmbRepCliente2.Text)) <> 0 Then
         With BacContratoSwap
            Call FIRMAS(Doc, "pp_cli1", .txtRutRepCli2, Trim(Left(BacContratoSwap.cmbRepCliente2, Len(BacContratoSwap.cmbRepCliente2) - 15)), .txtDirecCli, telefonocli, FaxCli, RutCli, .txtCliente.Caption)
         End With
      End If
   ElseIf Len(Trim(BacContratoSwap.cmbRepCliente2.Text)) = 0 And Len(Trim(BacContratoSwap.cmbRepCliente2.Text)) <> 0 Then
      With BacContratoSwap
         Call FIRMAS(Doc, "pp_cli1", .txtRutRepCli2, Trim(Left(BacContratoSwap.cmbRepCliente2, Len(BacContratoSwap.cmbRepCliente2) - 15)), .txtDirecCli, telefonocli, FaxCli, RutCli, .txtCliente.Caption)
      End With
   End If

   Let Doc.Application.Visible = True
   Let Doc.Application.WindowState = wdWindowStateMaximize
  
   Set Doc = Nothing
   
   Let BacContratoSwapTasaICPBancoNuevo = True
   Let Screen.MousePointer = vbDefault
   
Exit Function
ErrorImprimir:
   
   Set Doc = Nothing
   Call MsgBox("Se ha generado un error en la impresion de contrato....", vbExclamation, App.Title)
End Function

Private Function BacRetornoNemoMoneda(nValor As Variant) As String
   Dim cSQL    As String
   Dim SqlDatos()
   
   Let BacRetornoNemoMoneda = ""
   
   Let cSQL = ""
   Let cSQL = giSQL_DatabaseCommon
   Let cSQL = cSQL & "..SP_LEER_MONEDA "
   Let cSQL = cSQL & nValor
   
   If Not Bac_Sql_Execute(cSQL) Then
      Let BacRetornoNemoMoneda = ""
   End If
   If Bac_SQL_Fetch(SqlDatos()) Then
      Let BacRetornoNemoMoneda = UCase(SqlDatos(2))
   End If
   
End Function

Public Function FuncEntregaBacoRef(ByVal FolioOperacion As Long) As String
   Dim cSQL    As String
   Dim SqlDatos()
   
   Let cSQL = "SET NOCOUNT ON "
   Let cSQL = cSQL & " SELECT TOP 3 LTRIM(RTRIM( clnombre )) FROM BacParamSuda.dbo.CLIENTE "
   Let cSQL = cSQL & " WHERE clrut <> isnull((SELECT TOP 1 rut_cliente FROM BacSwapSuda.dbo.CARTERA WHERE numero_operacion = " & FolioOperacion & " ),0)"
   Let cSQL = cSQL & " AND   clrut IN(97032000, 97004000, 97006000, 97030000) ORDER BY clrut "

   If Not Bac_Sql_Execute(cSQL) Then
      Let FuncEntregaBacoRef = ""
      Exit Function
   End If
   Let FuncEntregaBacoRef = ""
   Do While Bac_SQL_Fetch(SqlDatos())
      Let FuncEntregaBacoRef = FuncEntregaBacoRef & Trim(SqlDatos(1)) & "; "
   Loop

   Let FuncEntregaBacoRef = " " & Left(FuncEntregaBacoRef, Len(FuncEntregaBacoRef) - 2)

End Function

Public Function FuncEntregaTCRef(ByVal FolioOperacion As Long) As String
   Dim iMonCompra    As Variant
   Dim iMonRecibimos As Variant
   Dim iMonVenta     As Variant
   Dim iMonPagamos   As Variant
   Dim cSQL          As String
   Dim vValorTCRef   As Variant
   Dim SqlDatos()

   Let cSQL = ""
   Let cSQL = cSQL & " SET NOCOUNT ON ;"
   Let cSQL = cSQL & " SELECT TOP 1 'Mon1' = mn1.mnnemo "      '--> LTRIM(RTRIM( mn1.mnnemo )) + ' - ' + LTRIM(RTRIM( compra_moneda    )) "
   Let cSQL = cSQL & "            , 'Mon2' = mn2.mnnemo "      '--> LTRIM(RTRIM( mn2.mnnemo )) + ' - ' + LTRIM(RTRIM( recibimos_moneda )) "
   Let cSQL = cSQL & " FROM BacSwapSuda.dbo.CARTERA with(nolock) "
   Let cSQL = cSQL & " INNER JOIN BacParamSuda.dbo.MONEDA mn1 ON mn1.mncodmon = compra_moneda "
   Let cSQL = cSQL & " INNER JOIN BacParamSuda.dbo.MONEDA mn2 ON mn2.mncodmon = recibimos_moneda "
   Let cSQL = cSQL & " WHERE tipo_flujo = 1 And Numero_Operacion = " & FolioOperacion
   If Not Bac_Sql_Execute(cSQL) Then
      Let FuncEntregaTCRef = ""
      Exit Function
   End If
   If Bac_SQL_Fetch(SqlDatos()) Then
         Let iMonCompra = IIf(SqlDatos(1) = "CLP", "", IIf(SqlDatos(1) = "USD", "DO", SqlDatos(1)))
      Let iMonRecibimos = IIf(SqlDatos(2) = "CLP", "", IIf(SqlDatos(2) = "USD", "DO", SqlDatos(2)))
   End If

   Let cSQL = ""
   Let cSQL = cSQL & " SET NOCOUNT ON ;"
   Let cSQL = cSQL & " SELECT TOP 1 'Mon1' = mn1.mnnemo "      '--> LTRIM(RTRIM( mn1.mnnemo )) + ' - ' + LTRIM(RTRIM( venta_moneda   )) "
   Let cSQL = cSQL & "            , 'Mon2' = mn2.mnnemo "      '--> LTRIM(RTRIM( mn2.mnnemo )) + ' - ' + LTRIM(RTRIM( pagamos_moneda )) "
   Let cSQL = cSQL & " FROM BacSwapSuda.dbo.CARTERA with(nolock) "
   Let cSQL = cSQL & " INNER JOIN BacParamSuda.dbo.MONEDA mn1 ON mn1.mncodmon = venta_moneda "
   Let cSQL = cSQL & " INNER JOIN BacParamSuda.dbo.MONEDA mn2 ON mn2.mncodmon = pagamos_moneda "
   Let cSQL = cSQL & " WHERE tipo_flujo = 2 And Numero_Operacion = " & FolioOperacion
   If Not Bac_Sql_Execute(cSQL) Then
      Let FuncEntregaTCRef = ""
      Exit Function
   End If
   If Bac_SQL_Fetch(SqlDatos()) Then
        Let iMonVenta = IIf(SqlDatos(1) = "CLP", "", IIf(SqlDatos(1) = "USD", "DO", SqlDatos(1)))
      Let iMonPagamos = IIf(SqlDatos(2) = "CLP", "", IIf(SqlDatos(2) = "USD", "DO", SqlDatos(2)))
   End If
   
   If InStr(1, iMonRecibimos, iMonCompra) > 0 Then
      Let iMonRecibimos = ""
   End If
   If InStr(1, iMonPagamos, iMonVenta) > 0 Then
      Let iMonPagamos = ""
   End If
   If InStr(1, iMonCompra, iMonVenta) > 0 Then
      Let iMonVenta = ""
   End If

   Let vValorTCRef = ""

   If Len(iMonCompra) > 0 Then
      Let vValorTCRef = "Valor " & iMonCompra & " al día de vencimiento."
   End If
   If Len(iMonVenta) > 0 Then
      If Len(vValorTCRef) > 0 Then
         Let vValorTCRef = vValorTCRef & " Y " & "Valor " & iMonVenta & " al día de vencimiento."
      Else
         Let vValorTCRef = vValorTCRef & " Valor " & iMonVenta & " al día de vencimiento."
      End If
   End If

   If Len(iMonRecibimos) > 0 Then Let vValorTCRef = "; " & vValorTCRef & "Valor " & iMonRecibimos & " al día de vencimiento."
      If Len(iMonPagamos) > 0 Then Let vValorTCRef = "; " & vValorTCRef & "Valor " & iMonPagamos & " al día de vencimiento."

   If Len(vValorTCRef) = 0 Then
      vValorTCRef = "N/A"
   End If

   Let FuncEntregaTCRef = vValorTCRef

End Function

Private Function LoadDataContrato(nOperacion As Long, ByRef Arreglo As Variant, ByRef IndiceFinal As Long, nFirsComp As Long, nFirsVenta As Long) As Boolean
   Dim iContador  As Long
   Dim cSQL       As String
   Dim oControl   As Boolean
   Dim SqlDatos()
   
   Let LoadDataContrato = False
   Let oControl = False
   
   ReDim Preserve Arreglo(29, 1)
   
   For iContador = 1 To 29
      Let Arreglo(iContador, 1) = "**"
   Next iContador
   
   Let iContador = 1
   
   Let cSQL = "EXECUTE SP_DATOSCONTRATO_TODOSFLUJOS " & nOperacion
   If Not Bac_Sql_Execute(cSQL) Then
      Call MsgBox("Error en la recuperacion de datos de contrato.!", vbExclamation, App.Title)
      Exit Function
   End If
   Do While Bac_SQL_Fetch(SqlDatos())
      Let oControl = True
      ReDim Preserve Arreglo(29, iContador)
      
      If SqlDatos(27) = 1 And SqlDatos(14) = 1 Then
         Let nFirsComp = iContador
      End If
      If SqlDatos(27) = 2 And SqlDatos(14) = 1 Then
         Let nFirsVenta = iContador
      End If
      
      Let Arreglo(1, iContador) = SqlDatos(1)                                       'Tipo_operacion
      Let Arreglo(2, iContador) = SqlDatos(2)                                       'MontoOperacion
      Let Arreglo(3, iContador) = SqlDatos(3)                                       'TasaConversion
      Let Arreglo(4, iContador) = SqlDatos(4)                                       'Modalidad
      Let Arreglo(5, iContador) = SqlDatos(5)                                       'fechainicioflujo
      Let Arreglo(6, iContador) = SqlDatos(6)                                       'fechavenceflujo
      Let Arreglo(7, iContador) = SqlDatos(7)                                       'dias
      Let Arreglo(8, iContador) = BacStrTran((SqlDatos(8)), ".", gsc_PuntoDecim)    'compra_valor_tasa
      Let Arreglo(9, iContador) = BacStrTran((SqlDatos(9)), ".", gsc_PuntoDecim)    'venta_valor_tasa
      Let Arreglo(10, iContador) = SqlDatos(10)                                     'nombretasacompra
      Let Arreglo(11, iContador) = SqlDatos(11)                                     'nombretasaventa
      Let Arreglo(12, iContador) = SqlDatos(12)                                     'pagamosdoc
      Let Arreglo(13, iContador) = SqlDatos(13)                                     'recibimosdoc
      Let Arreglo(14, iContador) = SqlDatos(14)                                     'numero_flujo
      Let Arreglo(15, iContador) = BacStrTran((SqlDatos(15)), ".", gsc_PuntoDecim)  'compra_capital
      Let Arreglo(16, iContador) = BacStrTran((SqlDatos(16)), ".", gsc_PuntoDecim)  'compra_amortiza
      Let Arreglo(17, iContador) = BacStrTran((SqlDatos(17)), ".", gsc_PuntoDecim)  'compra_saldo
      Let Arreglo(17, iContador) = CDbl(Arreglo(16, iContador)) + CDbl(Arreglo(17, iContador))
      Let Arreglo(18, iContador) = SqlDatos(18)                                     'compra_interes
      Let Arreglo(19, iContador) = SqlDatos(19)                                     'compra_spread
      Let Arreglo(20, iContador) = SqlDatos(20)                                     'venta_capital
      Let Arreglo(21, iContador) = BacStrTran((SqlDatos(21)), ".", gsc_PuntoDecim)  'venta_amortiza
      Let Arreglo(22, iContador) = BacStrTran((SqlDatos(22)), ".", gsc_PuntoDecim)  'venta_saldo
      Let Arreglo(22, iContador) = CDbl(Arreglo(21, iContador)) + CDbl(Arreglo(22, iContador))
      Let Arreglo(23, iContador) = SqlDatos(23)                                     'venta_interes
      Let Arreglo(24, iContador) = SqlDatos(24)                                     'venta_spread
      Let Arreglo(25, iContador) = SqlDatos(25)                                     'pagamos_moneda
      Let Arreglo(26, iContador) = SqlDatos(26)                                     'recibimos_moneda
      Let Arreglo(27, iContador) = SqlDatos(27)                                     'tipo_flujo
      Let Arreglo(28, iContador) = SqlDatos(46)                                     'CompraGlosaBase 'PRD-7904
      Let Arreglo(29, iContador) = SqlDatos(47)                                     'VentaGlosaBase 'PRD-7904
      Let iContador = iContador + 1
   Loop
   
   Let IndiceFinal = iContador - 1
   
   If oControl = False Then
      Call MsgBox("Error en la recuperacion de datos de contrato.!", vbExclamation, App.Title)
      Exit Function
   End If
   
   Let LoadDataContrato = True
End Function


Private Function FuncLoadValuta(ByVal NumOper As Long) As String
   Dim cSQL    As String
   Dim cSqlDatos()
   
   Let cSQL = ""
   Let cSQL = cSQL & " SELECT DISTINCT diasvalor, recibimos_documento From BacSwapSuda.dbo.CARTERA "
   Let cSQL = cSQL & " INNER JOIN BacParamSuda.dbo.FORMA_DE_PAGO ON codigo = recibimos_documento "
   Let cSQL = cSQL & " WHERE numero_operacion = " & NumOper
 
   If Bac_Sql_Execute(cSQL) Then
      If Bac_SQL_Fetch(cSqlDatos()) Then
         Let FuncLoadValuta = "T + " & Trim(cSqlDatos(1))
      End If
   End If
    
End Function
