Attribute VB_Name = "BACContratos"

Public Function FuentesImpresora()
Printer.PaperSize = 1
Printer.FontName = "Courier New"
Printer.FontSize = 10
Printer.Font = "Courier New"
End Function

Public Function IniciaWordListadoLog(Cual, ByRef OK As Boolean) As Word.Document
    'se inicia una aplicacion word
    Dim Wrd
    Dim UbicacionDeDocumentos
    
    
    On Error GoTo Control:
    
    OK = False
    'on Error Resume Next
    'Set Wrd = GetObject(, "Word.Application")
    'If Err.Number <> 0 Then
        Set Wrd = New Word.Application
    'End If
    Err.Clear
    On Error GoTo 0
    
    If Cual = "Condiciones" Then
        'si se desea hacer que word este visible
        Set IniciaWordListadoLog = Wrd.Documents.Add(gsDOC_Path & "\Condiciones Generales.doc")
        DoEvents
    ElseIf Cual = "Anexo A" Then
        Set IniciaWordListadoLog = Wrd.Documents.Add(gsDOC_Path & "\Anexo A.doc")
        DoEvents
    ElseIf Cual = "CondicionesNoBanco" Then
        Set IniciaWordListadoLog = Wrd.Documents.Add(gsDOC_Path & "\Condiciones Generales No Banco.doc")
        DoEvents
    ElseIf Cual = "ContratoTasasBanco" Then
        Set IniciaWordListadoLog = Wrd.Documents.Add(gsDOC_Path & "\Anexo No 3.doc")
        DoEvents
    
    End If
    
    OK = True
Exit Function

Control:

Select Case Err
    Case 1
        'MsgBox "Aplicacion WORD no esta Instalada en Pc", vbCritical, Msj
        
    Case Else
        MsgBox "Ocurrio un evento numero " & Err.Number & ". " & Err.Description, vbCritical, Msj
End Select
        
End Function

Function BacContratoSwapTasaBanco(DatosCond(), NumOper, Donde) As Boolean
On Error GoTo Control:

    Dim Doc2           As Word.Document
    Dim Sql As String
    Dim contadorlineas
    Dim A, m
    Dim Datos()
    Dim i As Integer
    Dim total As Integer
    Dim Contrato()
    Dim NemoMon As String
    Dim Paso As String
    Dim Glosa  As String
    Dim Okk As Boolean

 Sql = giSQL_DatabaseCommon
 Sql = Sql & "..sp_Leer_Moneda "
 Sql = Sql & DatosCond(29)

 If MISQL.SQL_Execute(Sql) = 0 Then
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
  
    Doc2.Activate
    
    Doc2.Bookmarks("Dia").Select
    Doc2.Application.Selection.Text = DatosCond(12)
    Doc2.Bookmarks("Mes").Select
    Doc2.Application.Selection.Text = DatosCond(13)
    Doc2.Bookmarks("Año").Select
    Doc2.Application.Selection.Text = DatosCond(14)
    
    Doc2.Bookmarks("NomBco").Select
    Doc2.Application.Selection.Text = DatosCond(1)
    Doc2.Bookmarks("RutBco").Select
    Doc2.Application.Selection.Text = DatosCond(2)
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
    Doc2.Application.Selection.Text = DatosCond(5)
    Doc2.Bookmarks("NomBco1").Select
    Doc2.Application.Selection.Text = DatosCond(1)
    Doc2.Bookmarks("NomCli").Select
    Doc2.Application.Selection.Text = DatosCond(6)
    Doc2.Bookmarks("RutCli").Select
    Doc2.Application.Selection.Text = DatosCond(7)
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
    Doc2.Bookmarks("NomCli1").Select
    Doc2.Application.Selection.Text = DatosCond(6)
        
    Doc2.Bookmarks("DiaCond").Select
    Doc2.Application.Selection.Text = DatosCond(31)
    Doc2.Bookmarks("MesCond").Select
    Doc2.Application.Selection.Text = DatosCond(32)
    Doc2.Bookmarks("AñoCond").Select
    Doc2.Application.Selection.Text = DatosCond(33)
    
    Doc2.Bookmarks("NomBco2").Select
    Doc2.Application.Selection.Text = DatosCond(1) & ":   " & NemoMon & " " & Format(DatosCond(30), "###,###,###,##0.###0")
    Doc2.Bookmarks("NomCli2").Select
    Doc2.Application.Selection.Text = DatosCond(6) & ":   " & NemoMon & " " & Format(DatosCond(30), "###,###,###,##0.###0")
    
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
    
    Doc2.Bookmarks("ValutaPago").Select
    Doc2.Application.Selection.Text = "N/A"
    
    Doc2.Bookmarks("FechaIni").Select
    Doc2.Application.Selection.Text = DatosCond(27)
       
    Doc2.Bookmarks("NomBco4").Select
    Doc2.Application.Selection.Text = DatosCond(1)
    Doc2.Bookmarks("NomCli4").Select
    Doc2.Application.Selection.Text = DatosCond(6)
    
    contadorlineas = 1
    A = 1
ReDim Preserve Contrato(27, 1)
    For i = 1 To 27
        Contrato(i, 1) = "**"
    Next

   Sql = "EXECUTE sp_DatosContrato " & NumOper
   If MISQL.SQL_Execute(Sql$) = 0 Then
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
            Contrato(16, i) = CDbl(Contrato(16, i)) + CDbl(Contrato(17, i))
            Contrato(18, i) = Datos(18) 'compra_interes
            Contrato(19, i) = Datos(19) 'compra_spread
            Contrato(20, i) = Datos(20) 'venta_capital
            Contrato(21, i) = BacStrTran((Datos(21)), ".", gsc_PuntoDecim)  'venta_amortiza
            Contrato(22, i) = BacStrTran((Datos(22)), ".", gsc_PuntoDecim)  'venta_saldo
            Contrato(21, i) = CDbl(Contrato(21, i)) + CDbl(Contrato(22, i))
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
        Exit Function
    
    End If
    total = i
    '******
    Doc2.Bookmarks("FechaVenc").Select
    Doc2.Application.Selection.Text = Contrato(6, i)

    Doc2.Bookmarks("FormaPago").Select
    Doc2.Application.Selection.Text = Contrato(12, 1)
    
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
            Doc2.Application.Selection.Text = Format(Contrato(9, m), "###0.###0") & " " & Contrato(11, m) & " % "
            Doc2.Bookmarks("FijaVarCli").Select
            Doc2.Application.Selection.Text = Contrato(11, m)
            
        End If
        
        If Contrato(27, m) = 1 And Contrato(14, m) = 1 Then
            Doc2.Bookmarks("TasaCli").Select
            Doc2.Application.Selection.Text = Format(Contrato(8, m), "###0.###0") & " " & Contrato(10, m) & " % "
            Doc2.Bookmarks("FijaVarBco").Select
            Doc2.Application.Selection.Text = Contrato(10, m)

        End If
        
    
    Next

    Doc2.Application.WindowState = wdWindowStateMinimize
    Doc2.Application.Visible = True
    
    For m = 1 To total
        Doc2.Bookmarks("GrillaCli").Select
        
        If contadorlineas >= 1 And Contrato(27, m) = 1 Then
            Doc2.Application.Selection.MoveDown Unit:=wdLine, Count:=A
            Doc2.Bookmarks.Add Name:="Prueba", Range:=Doc2.Application.Selection.Range
            Doc2.Bookmarks("Prueba").Select
            A = A + 1
        End If
            
        If Contrato(27, m) = 1 Then
            
           Doc2.Application.Selection.Text = Contrato(5, contadorlineas)
           Doc2.Application.Selection.MoveRight Unit:=wdCell
           Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
             
           Doc2.Application.Selection.Text = Contrato(6, contadorlineas)
           Doc2.Application.Selection.MoveRight Unit:=wdCell
           Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
                                         
           Doc2.Application.Selection.Text = Contrato(7, contadorlineas)
           Doc2.Application.Selection.MoveRight Unit:=wdCell
           Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphCenter
             
           Doc2.Application.Selection.Text = NemoMon & " " & Format((Contrato(16, contadorlineas)), "###,###,###,##0.###0")
           Doc2.Application.Selection.MoveRight Unit:=wdCell
           Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphCenter
            
           Doc2.Application.Selection.Text = NemoMon & " " & Format((Contrato(17, contadorlineas)), "###,###,###,##0.###0")
           Doc2.Application.Selection.MoveRight Unit:=wdCell
           Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft

           Doc2.Application.Selection.Text = Contrato(8, contadorlineas) & " % "
           Doc2.Application.Selection.MoveRight Unit:=wdCell
           Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
      
      End If
      
      contadorlineas = contadorlineas + 1
               
    Next
    '*****
    Doc2.Bookmarks("NomBco5").Select
    Doc2.Application.Selection.Text = DatosCond(1)
    Doc2.Bookmarks("NomCli5").Select
    Doc2.Application.Selection.Text = DatosCond(6)
        
    contadorlineas = 1
    A = 1
    
    For m = 1 To total
        Doc2.Bookmarks("Grilla").Select
 
        If contadorlineas >= 1 And Contrato(27, m) = 2 Then
            Doc2.Application.Selection.MoveDown Unit:=wdLine, Count:=A
            Doc2.Bookmarks.Add Name:="Prueba", Range:=Doc2.Application.Selection.Range
            Doc2.Bookmarks("Prueba").Select
            A = A + 1
        End If
            
        If Contrato(27, m) = 2 Then
            
           Doc2.Application.Selection.Text = Contrato(5, contadorlineas)
           Doc2.Application.Selection.MoveRight Unit:=wdCell
           Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
            
           Doc2.Application.Selection.Text = Contrato(6, contadorlineas)
           Doc2.Application.Selection.MoveRight Unit:=wdCell
           Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
                                        
           Doc2.Application.Selection.Text = Contrato(7, contadorlineas)
           Doc2.Application.Selection.MoveRight Unit:=wdCell
           Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphCenter
            
           Doc2.Application.Selection.Text = NemoMon & " " & Format((Contrato(21, contadorlineas)), "###,###,###,##0.##0")
           Doc2.Application.Selection.MoveRight Unit:=wdCell
           Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphCenter
                       
           Doc2.Application.Selection.Text = NemoMon & " " & Format((Contrato(22, contadorlineas)), "###,###,###,##0.###0")
           Doc2.Application.Selection.MoveRight Unit:=wdCell
           Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
            
           Doc2.Application.Selection.Text = Contrato(9, contadorlineas) & " % "
           Doc2.Application.Selection.MoveRight Unit:=wdCell
           Doc2.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft

        End If
        
        contadorlineas = contadorlineas + 1
               
    Next
    
    Doc2.Bookmarks("ModalidadPago").Select
    Doc2.Application.Selection.Text = Contrato(4, 1)
    
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

Exit Function

Control:

    MsgBox "Problemas para crear Contrato!!. " & Err.Description, vbInformation, Msj
    Set Doc2 = Nothing

End Function

Public Function BacDOCCondicionesGeneralesNoBanco(DatosCond(), Donde) As Boolean

On erro GoTo Control:

    Dim Doc2           As Word.Document
    Dim Sql As String
    Dim Paso As String
    Dim Okk As Boolean
    
    Set Doc2 = IniciaWordListadoLog("CondicionesNoBanco", Okk)
    If Not Okk Then
        MsgBox "Condiciones Generales no pueden ser Generadas", vbCritical, Msj
        Exit Function
    End If
    
    Doc2.Activate
    
    Doc2.Bookmarks("NombreCli").Select
    Doc2.Application.Selection.Text = DatosCond(6)
    
    Doc2.Bookmarks("Dia").Select
    Doc2.Application.Selection.Text = DatosCond(12)
    Doc2.Bookmarks("Mes").Select
    Doc2.Application.Selection.Text = DatosCond(13)
    Doc2.Bookmarks("Año").Select
    Doc2.Application.Selection.Text = DatosCond(14)
    Doc2.Bookmarks("RepresentanteBco").Select
    Doc2.Application.Selection.Text = DatosCond(3)
    Doc2.Bookmarks("RutRepBco").Select
    Doc2.Application.Selection.Text = DatosCond(4)
    
    Doc2.Bookmarks("DireccRepBco").Select
    Doc2.Application.Selection.Text = DatosCond(10)
    
    Doc2.Bookmarks("NombreCli1").Select
    Doc2.Application.Selection.Text = DatosCond(6)
    Doc2.Bookmarks("RutCli").Select
    Doc2.Application.Selection.Text = DatosCond(2)
    
    Doc2.Bookmarks("RepresentanteClii").Select
    Doc2.Application.Selection.Text = DatosCond(8)
    
    Doc2.Bookmarks("RutRepCli").Select
    Doc2.Application.Selection.Text = DatosCond(9)
    
    Doc2.Bookmarks("DeireccRepCli").Select
    Doc2.Application.Selection.Text = DatosCond(10)
    
    Doc2.Bookmarks("NomBco2").Select
    Doc2.Application.Selection.Text = DatosCond(1)
    Doc2.Bookmarks("NomCliente2").Select
    Doc2.Application.Selection.Text = DatosCond(6)
    
    Doc2.Bookmarks("DirBco2").Select
    Doc2.Application.Selection.Text = DatosCond(5)
    Doc2.Bookmarks("DirCli2").Select
    Doc2.Application.Selection.Text = DatosCond(10)
        
    Doc2.Bookmarks("TelefBco").Select
    Doc2.Application.Selection.Text = DatosCond(15)
    Doc2.Bookmarks("TelefCli").Select
    Doc2.Application.Selection.Text = DatosCond(17)
    Doc2.Bookmarks("FaxBco").Select
    Doc2.Application.Selection.Text = DatosCond(16)
    Doc2.Bookmarks("FaxCli").Select
    Doc2.Application.Selection.Text = DatosCond(18)
    
    Doc2.Bookmarks("RutBco2").Select
    Doc2.Application.Selection.Text = DatosCond(2)
    Doc2.Bookmarks("RutCli2").Select
    Doc2.Application.Selection.Text = DatosCond(7)
    
    Doc2.Bookmarks("NomRepBco2").Select
    Doc2.Application.Selection.Text = DatosCond(3)
    Doc2.Bookmarks("NomRepCli2").Select
    Doc2.Application.Selection.Text = DatosCond(8)
    
    
    'Paso = DatosCond(20) & "\Contrato Swap de Tasas " & DatosCond(6) & ".doc"
      
    'If Dir(Paso) <> "" Then
    '  Kill Paso
    'Else
        
        ActiveDocument.SaveAs FileName:=DatosCond(20) & "\Condiciones Generales Empresa " & DatosCond(6) & ".doc"
    'End If
    
    If Donde = "Impresora" Then
        ActiveDocument.PrintOut
    Else
        Doc2.Application.Visible = True
    End If
    
    'Actualizacion Fecha de Condiciones de Generales en Tabla Cliente
    Sql = ""
    Sql = "Update " & giSQL_DatabaseCommon & "..mdcl Set clfeccondgrl = '" & Format(DatosCond(11), "yyyymmdd") _
          & "' Where clcodigo = " & DatosCond(19)
    
    If MISQL.SQL_Execute(Sql) <> 0 Then
        MsgBox "Problemas al actualizar fecha de Condiciones Generales en archivo de Clientes", vbCritical, Msj
    End If

Exit Function

Control:

    MsgBox "Problemas para crear Condiciones Generales con Empresas. " & Err.Description, vbInformation, Msj
      
End Function
'Public Function BacContratoInterbancario(nNumOpe As Long) As Boolean
'   Dim Sql       As String
'   Dim Datos()
'   Dim Lin(80)
'   Dim nPosicion As Integer
'   Dim nFila     As Integer
'   Dim nTab      As Integer
'   Dim aString()
'   Dim nCont     As Integer
'   Dim sTexto    As String
'   Dim nCont2    As Integer
'   Dim cCaracter As String
'
'   'Recuperación de los datos de la operación
'   Sql = "EXECUTE sp_contratointerbancario " & nNumOpe & ","
'   Sql = Sql & Bac_Apoderados.Txt_Rut1 & ","
'   Sql = Sql & Bac_Apoderados.Txt_Rut2
'
'   If MISQL.SQL_Execute(Sql) <> 0 Then
'      MsgBox "Problemas al leer datos del contrato interbancario", vbCritical, "MENSAJE"
'      Exit Function
'   End If
'   Call FuentesImpresora
'   Lin(1) = "@BANCO"
'   Lin(2) = "Casa Matriz"
'   Lin(3) = "Morande 226 Santiago"
'   Lin(4) = "RUT : @RUTBANCO"
'   Lin(5) = " "
'   Lin(6) = "CONTRATO DE FORWARDS Y/O SWAP DE MONEDAS EN EL MERCADO LOCAL"
'   Lin(7) = "(Institucional)"
'   Lin(8) = "Folio : @NUMOPE"
'   Lin(9) = " "
'
'   Lin(10) = "En Santiago de Chile, a^@FECHAINICIO^, entre^@BANCO, RUT @RUTBANCO^"
'   Lin(10) = Lin(10) + "debidamente representado por la(s) persona(s) que suscribe(n) al final, todos domiciliados "
'   Lin(10) = Lin(10) + "en esta ciudad calle^@DIRBANCO^, teléfono^@TELBANCO^, fax^@FAXBANCO^, por una parte, y por la "
'   Lin(10) = Lin(10) + "otra^@CONTRAPARTE^, RUT^@RUTCONTRAPARTE^, debidamente representado "
'   Lin(10) = Lin(10) + "por la(s) persona(s) que suscribe(n) al final, todos domiciliados en esta ciudad, "
'   Lin(10) = Lin(10) + "calle^@DIRCONTRAPARTE^, telefono^@TELCONTRAPARTE^, fax^@FAXCONTRAPARTE^, se ha convenido y cerrado a "
'   Lin(10) = Lin(10) + "firme una transacción forward y/o swap de las monedas que más adelante se indican y en los términos que a "
'   Lin(10) = Lin(10) + "continuación se expresan, amparada y regida por las normas del Capitulo VII del Titulo I del Compendio de Normas de "
'   Lin(10) = Lin(10) + "Cambios Internacionales del Banco Central de Chile y del Capitulo 13-2 de la Recopilación actualizada de Normas de la "
'   Lin(10) = Lin(10) + "Superintendencia de Bancos e Instituciones Financieras, y por el Protocolo de Definiciones Utilizadas en Contrato de "
'   Lin(10) = Lin(10) + "Forwards y/o Swaps de Monedas en el Mercado Local de la Asociación de Bancos, vigente a la fecha de cierre del contrato, "
'   Lin(10) = Lin(10) + "que las partes declaran conocer :"
'
'   Lin(11) = " "
'   Lin(12) = "1.  Vendedor                                              : @VENDEDOR"
'   Lin(13) = "2.  Comprador                                             : @COMPRADOR"
'   Lin(14) = "3.  Tipo de Transacción                                   : FORWARD"
'   Lin(15) = "4.  Fecha de Cierre (dd/mm/aa)                            : @FECINI"
'   Lin(16) = "5.  Hora de Cierre                                        : 12:00"
'   Lin(17) = "6.  Fecha de Vencimiento                                  : @FECVEN"
'   Lin(18) = "7.  Mecanismo de Cumplimiento                             : @MODALIDAD"
'   Lin(19) = "8.  Cantidad de Moneda Vendida                            : @CODMON @MTOMEX"
'   Lin(20) = "      @MONESCMTOMEX"
'   Lin(21) = "9.  Tipo de cambio Forward Pactado                        : @TIPCAM"
'   Lin(22) = "10. Paridad Forward Pactada                               : @PARFWD"
'   Lin(23) = "11. Valor Forward Pactado                                 : @CODCNV @MTOFIN"
'   Lin(24) = "      @MONESCMTOFIN"
'   Lin(25) = "12. Tipo de Cambio de Referencia                          : @TCREFERENCIA"
'   Lin(26) = "13. Paridad de Referencia                                 : N/A"
'   Lin(27) = "14. Lugar de Cumplimiento                                 : Santiago"
'   Lin(28) = "15. Otras Condiciones                                     : "
'   Lin(29) = " "
'
'   Lin(30) = "En el caso de cumplimiento por compensación, a la fecha de vencimiento pactada se establecer la cuantía de las "
'   Lin(30) = Lin(30) + "obligaciones contraídas por ambas partes, compensándose dichas obligaciones, y extinguiendose‚ éstas hasta por el monto de "
'   Lin(30) = Lin(30) + "la menor de ellas. La diferencia que resulte de esta compensación y liquidación deber  ser pagada por la parte deudora a la "
'   Lin(30) = Lin(30) + "parte acreedora, en pesos moneda nacional, al contado, en el domicilio de esta última. Para el caso en que ambas monedas "
'   Lin(30) = Lin(30) + "sean monedas extranjeras esta diferencia deber  pagarse en dólares de los Estados Unidos de América. "
'   Lin(30) = Lin(30) + "Las partes de común acuerdo podr n anticipar la fecha de liquidación del contrato. Ni el presente contrato, ni los "
'   Lin(30) = Lin(30) + "derechos que de él emanan podrán endosarse o transferirse, sin  consentimiento escrito  de  ambas  partes, del que deber  "
'   Lin(30) = Lin(30) + "dejarse constancia en los dos ejemplares que se firman en el mismo."
'   Lin(30) = Lin(30) + "Si cualquiera de las partes no cumple las obligaciones contraídas en este contrato, operar  automática  y obligatoriamente "
'   Lin(30) = Lin(30) + "el mecanismo de compensación estipulado anteriormente. Si la parte deudora no pagare a la parte acreedora la diferencia que "
'   Lin(30) = Lin(30) + "arrojare a favor de esta última la aludida compensación, el monto adeudado devengar , a partir de la mora y hasta la fecha de "
'   Lin(30) = Lin(30) + "pago efectivo, la tasa de interés máximo convencional que la ley permite estipular para la moneda adecuada, sin perjuicio del "
'   Lin(30) = Lin(30) + "derecho de la parte acreedora para exigir el cumplimiento forzado de la obligación."
'
'   Lin(31) = " "
'   Lin(32) = " "
'   Lin(33) = " "
'   Lin(34) = " "
'   Lin(35) = "           ------------------------------                    ------------------------------"
'   Lin(36) = "                     P. Vendedor                                       P. Comprador"
'   Lin(37) = " "
'   Lin(38) = "Nombre: @APOVEN1              RUT: @RUTAPOVEN1      Nombre: @APOCOM1              RUT: @RUTAPOCOM1  "
'   Lin(39) = "Nombre: @APOVEN2              RUT: @RUTAPOVEN2      Nombre: @APOCOM2              RUT: @RUTAPOCOM2  "
'
'   Do While MISQL.SQL_Fetch(Datos()) = 0
'      Lin(1) = BacRemplazar(Lin(1), "@BANCO", Datos(1))
'      Lin(4) = BacRemplazar(Lin(4), "@RUTBANCO", BacFormatoRut(Datos(4)))
'      Lin(8) = BacRemplazar(Lin(8), "@NUMOPE", BacFormatoMonto(Val(Datos(2)), 0))
'
'      Lin(10) = BacRemplazar(Lin(10), "@FECHAINICIO", BacFormatoFecha("DDMMAA", Datos(3)))
'      Lin(10) = BacRemplazar(Lin(10), "@BANCO", Datos(1))
'      Lin(10) = BacRemplazar(Lin(10), "@RUTBANCO", BacFormatoRut(Datos(4)))
'      Lin(10) = BacRemplazar(Lin(10), "@DIRBANCO", Datos(5))
'      Lin(10) = BacRemplazar(Lin(10), "@TELBANCO", Datos(6))
'      Lin(10) = BacRemplazar(Lin(10), "@FAXBANCO", Datos(7))
'      Lin(10) = BacRemplazar(Lin(10), "@CONTRAPARTE", Datos(8))
'      Lin(10) = BacRemplazar(Lin(10), "@RUTCONTRAPARTE", BacFormatoRut(Datos(9)))
'      Lin(10) = BacRemplazar(Lin(10), "@DIRCONTRAPARTE", Datos(10))
'      Lin(10) = BacRemplazar(Lin(10), "@TELCONTRAPARTE", Datos(11))
'      Lin(10) = BacRemplazar(Lin(10), "@FAXCONTRAPARTE", Datos(12))
'
'      Lin(12) = BacRemplazar(Lin(12), "@VENDEDOR", IIf(Datos(13) = "C", Datos(8), Datos(1)))
'      Lin(13) = BacRemplazar(Lin(13), "@COMPRADOR", IIf(Datos(13) = "V", Datos(8), Datos(1)))
'      Lin(15) = BacRemplazar(Lin(15), "@FECINI", Datos(3))
'      Lin(17) = BacRemplazar(Lin(17), "@FECVEN", Datos(14))
'      Lin(18) = BacRemplazar(Lin(18), "@MODALIDAD", Datos(15))
'      Lin(19) = BacRemplazar(Lin(19), "@CODMON", Datos(16))
'      Lin(19) = BacRemplazar(Lin(19), "@MTOMEX", BacFormatoMonto(Val(Datos(17)), 2))
'      Lin(20) = BacRemplazar(Lin(20), "@MONESCMTOMEX", BacMonto_Escrito(Val(Datos(17))) & " " & BacGlosaMon(Datos(16), True, Datos(29), Datos(30)))
'      Lin(21) = BacRemplazar(Lin(21), "@TIPCAM", IIf(Val(Datos(19)) = 1, BacGlosaPrecioFuturo(Datos(20), Datos(16), Datos(21), Datos(31)), "N/A"))
'      Lin(22) = BacRemplazar(Lin(22), "@PARFWD", IIf(Val(Datos(19)) = 2, BacGlosaPrecioFuturo(Datos(20), Datos(16), Datos(21), Datos(31)), "N/A"))
'      Lin(23) = BacRemplazar(Lin(23), "@CODCNV", IIf(Datos(21) = "CLP", "$", Datos(21)))
'      Lin(23) = BacRemplazar(Lin(23), "@MTOFIN", BacFormatoMonto(Val(Datos(22)), IIf(Datos(21) = "CLP", 0, IIf(Datos(21) = "UF", 4, 2))))
'      Lin(24) = BacRemplazar(Lin(24), "@MONESCMTOFIN", BacMonto_Escrito(Val(Datos(22))) & " " & BacGlosaMon(Datos(21), False, Datos(29), Datos(30)))
'      Lin(25) = BacRemplazar(Lin(25), "@TCREFERENCIA", Datos(24))
'
'      Lin(38) = BacRemplazarII(Lin(38), "RUT:", "@APOVEN1", IIf(Datos(13) = "V" And Datos(25) <> "", Trim(Datos(25)), String(20, ".")))
'      Lin(38) = BacRemplazarII(Lin(38), "Nombre:", "@RUTAPOVEN1", IIf(Datos(13) = "V" And Mid(Trim(Datos(26)), 1, 1) <> "0", BacFormatoRut(Trim(Datos(26))), String(13, ".")))
'      Lin(38) = BacRemplazarII(Lin(38), "RUT:", "@APOCOM1", IIf(Datos(13) = "C" And Datos(25) <> "", Trim(Datos(25)), String(20, ".")))
'      Lin(38) = BacRemplazar(Lin(38), "@RUTAPOCOM1", IIf(Datos(13) = "C" And Mid(Trim(Datos(26)), 1, 1) <> "0", BacFormatoRut(Trim(Datos(26))), String(13, ".")))
'
'      Lin(39) = BacRemplazarII(Lin(39), "RUT:", "@APOVEN2", IIf(Datos(13) = "V" And Datos(27) <> "", Trim(Datos(27)), String(20, ".")))
'      Lin(39) = BacRemplazarII(Lin(39), "Nombre:", "@RUTAPOVEN2", IIf(Datos(13) = "V" And Mid(Trim(Datos(28)), 1, 1) <> "0", BacFormatoRut(Trim(Datos(28))), String(13, ".")))
'      Lin(39) = BacRemplazarII(Lin(39), "RUT:", "@APOCOM2", IIf(Datos(13) = "C" And Datos(27) <> "", Trim(Datos(27)), String(20, ".")))
'      Lin(39) = BacRemplazar(Lin(39), "@RUTAPOCOM2", IIf(Datos(13) = "C" And Mid(Trim(Datos(28)), 1, 1) <> "0", BacFormatoRut(Trim(Datos(28))), String(13, ".")))
'
'   Loop
'
'   nTab = 8
'   nFila = 3
'
'   BacGlbSetPrinter 65, 120, 1, 1
'   'BacGlbSetFont CourierNew, 8, True
'   Printer.FontBold = True
'   BacGlbPrinter nFila, 1, nTab, 1, Lin(1), 0, 1
'
'   nFila = nFila + 1
'   BacGlbPrinter nFila, 1, nTab, 1, Lin(2), 0, 1
'
'   nFila = nFila + 1
'   BacGlbPrinter nFila, 1, nTab, 1, Lin(3), 0, 1
'
'   nFila = nFila + 1
'   BacGlbPrinter nFila, 1, nTab, 1, Lin(4), 0, 1
'
''   BacGlbSetFont CourierNew, 8, False
'   Printer.FontBold = False
'   nFila = nFila + 1
'   BacGlbPrinter nFila, 1, nTab, 1, Lin(5), 0, 1
'
'   Lin(6) = BacFormatearTexto(Lin(6), 3, 0, 0, 0, 110)
'   nFila = nFila + 1
'   BacGlbPrinter nFila, 1, nTab, 1, Lin(6), 0, 1
'
'   Lin(7) = BacFormatearTexto(Lin(7), 3, 0, 0, 0, 110)
'   nFila = nFila + 1
'   BacGlbPrinter nFila, 1, nTab, 1, Lin(7), 0, 1
'
'   Lin(8) = BacFormatearTexto(Lin(8), 2, 0, 0, 0, 110)
'   nFila = nFila + 1
'   BacGlbPrinter nFila, 1, nTab, 1, Lin(8), 0, 1
'
'   nFila = nFila + 1
'   BacGlbPrinter nFila, 1, nTab, 1, Lin(9), 0, 1
'
'   BacCentraTexto aString(), Lin(10), 110
'
'   For nCont = 1 To UBound(aString())
'      nFila = nFila + 1
'      sTexto = aString(nCont)
'
'      For nCont2 = 1 To Len(sTexto)
'         cCaracter = Mid(sTexto, nCont2, 1)
'
'         If cCaracter = "^" Then
'            Printer.FontBold = IIf(Printer.FontBold = False, True, False)
'            cCaracter = " "
'         End If
'
'         BacGlbPrinter nFila, 1, nTab - 1 + nCont2, 1, cCaracter, 0, 1
'      Next
'
'   Next
'
'   nFila = nFila + 1
'   BacGlbPrinter nFila, 1, nTab, 1, Lin(11), 0, 1
'
'   nFila = nFila + 1
'   BacGlbPrinter nFila, 1, nTab, 1, Lin(12), 0, 1
'
'   nFila = nFila + 1
'   BacGlbPrinter nFila, 1, nTab, 1, Lin(13), 0, 1
'
'   nFila = nFila + 1
'   BacGlbPrinter nFila, 1, nTab, 1, Lin(14), 0, 1
'
'   nFila = nFila + 1
'   BacGlbPrinter nFila, 1, nTab, 1, Lin(15), 0, 1
'
'   nFila = nFila + 1
'   BacGlbPrinter nFila, 1, nTab, 1, Lin(16), 0, 1
'
'   nFila = nFila + 1
'   BacGlbPrinter nFila, 1, nTab, 1, Lin(17), 0, 1
'
'   nFila = nFila + 1
'   BacGlbPrinter nFila, 1, nTab, 1, Lin(18), 0, 1
'
'   nFila = nFila + 1
'   BacGlbPrinter nFila, 1, nTab, 1, Lin(19), 0, 1
'
'   nFila = nFila + 1
'   BacGlbPrinter nFila, 1, nTab, 1, Lin(20), 0, 1
'
'   nFila = nFila + 1
'   BacGlbPrinter nFila, 1, nTab, 1, Lin(21), 0, 1
'
'   nFila = nFila + 1
'   BacGlbPrinter nFila, 1, nTab, 1, Lin(22), 0, 1
'
'   nFila = nFila + 1
'   BacGlbPrinter nFila, 1, nTab, 1, Lin(23), 0, 1
'
'   nFila = nFila + 1
'   BacGlbPrinter nFila, 1, nTab, 1, Lin(24), 0, 1
'
'   nFila = nFila + 1
'   BacGlbPrinter nFila, 1, nTab, 1, Lin(25), 0, 1
'
'   nFila = nFila + 1
'   BacGlbPrinter nFila, 1, nTab, 1, Lin(26), 0, 1
'
'   nFila = nFila + 1
'   BacGlbPrinter nFila, 1, nTab, 1, Lin(27), 0, 1
'
'   nFila = nFila + 1
'   BacGlbPrinter nFila, 1, nTab, 1, Lin(28), 0, 1
'
'   nFila = nFila + 1
'   BacGlbPrinter nFila, 1, nTab, 1, Lin(29), 0, 1
'
'   BacCentraTexto aString(), Lin(30), 110
'
'   For nCont = 1 To UBound(aString())
'      nFila = nFila + 1
'      sTexto = aString(nCont)
'
'      For nCont2 = 1 To Len(sTexto)
'         cCaracter = Mid(sTexto, nCont2, 1)
'
'         If cCaracter = "^" Then
'            Printer.FontBold = IIf(Printer.FontBold = False, True, False)
'            cCaracter = " "
'         End If
'
'         BacGlbPrinter nFila, 1, nTab - 1 + nCont2, 1, cCaracter, 0, 1
'      Next
'
'   Next
'
'   nFila = nFila + 1
'   BacGlbPrinter nFila, 1, nTab, 1, Lin(31), 0, 1
'
'   nFila = nFila + 1
'   BacGlbPrinter nFila, 1, nTab, 1, Lin(32), 0, 1
'
'   nFila = nFila + 1
'   BacGlbPrinter nFila, 1, nTab, 1, Lin(33), 0, 1
'
'   nFila = nFila + 1
'   BacGlbPrinter nFila, 1, nTab, 1, Lin(34), 0, 1
'
'   nFila = nFila + 1
'   BacGlbPrinter nFila, 1, nTab, 1, Lin(35), 0, 1
'
'   nFila = nFila + 1
'   BacGlbPrinter nFila, 1, nTab, 1, Lin(36), 0, 1
'
'   nFila = nFila + 1
'   BacGlbPrinter nFila, 1, nTab, 1, Lin(37), 0, 1
'
'   nFila = nFila + 1
'   BacGlbPrinter nFila, 1, nTab, 1, Lin(38), 0, 1
'
'   nFila = nFila + 1
'   BacGlbPrinter nFila, 1, nTab, 1, Lin(39), 0, 1
'
'   BacGlbPrinterEnd
'
'End Function

Public Function BacDOCCondicionesGenerales(DatosCond(), Donde) As Boolean

On erro GoTo Control:

    Dim Doc2 As Word.Document
    Dim Sql  As String
    Dim Okk  As Boolean
    
    Set Doc2 = IniciaWordListadoLog("Condiciones", Okk)
    
    If Not Okk Then
        MsgBox "Condiciones Generales no pueden ser Generada", vbCritical, Msj
        Exit Function
    End If
    Doc2.Activate
     'Doc2.Application.Visible = True
    Doc2.Bookmarks("NomBancoT").Select
    Doc2.Application.Selection.Text = DatosCond(1)
    Doc2.Bookmarks("NomCliT").Select
    Doc2.Application.Selection.Text = DatosCond(6)
    Doc2.Bookmarks("NomBanco").Select
    Doc2.Application.Selection.Text = DatosCond(1)
    Doc2.Bookmarks("NomCliente").Select
    Doc2.Application.Selection.Text = DatosCond(6)
    Doc2.Bookmarks("NomBancoC").Select
    Doc2.Application.Selection.Text = DatosCond(1)
    Doc2.Bookmarks("NomCliC").Select
    Doc2.Application.Selection.Text = DatosCond(6)
    Doc2.Bookmarks("NomBanco1").Select
    Doc2.Application.Selection.Text = DatosCond(1)
    Doc2.Bookmarks("NomCliC1").Select
    Doc2.Application.Selection.Text = DatosCond(6)
        
    Doc2.Bookmarks("Dia").Select
    Doc2.Application.Selection.Text = DatosCond(12)
    Doc2.Bookmarks("Mes").Select
    Doc2.Application.Selection.Text = DatosCond(13)
    Doc2.Bookmarks("Año").Select
    Doc2.Application.Selection.Text = DatosCond(14)
    
    Doc2.Bookmarks("RutBco").Select
    Doc2.Application.Selection.Text = DatosCond(2)
    Doc2.Bookmarks("RutCli").Select
    Doc2.Application.Selection.Text = DatosCond(7)
    
    Doc2.Bookmarks("NomRepBco").Select
    Doc2.Application.Selection.Text = DatosCond(3)


   If Len(Trim(DatosCond(21))) > 0 Then
    Doc2.Bookmarks("RutRepBco").Select
    Doc2.Application.Selection.Text = DatosCond(4) & " y don " & DatosCond(21) & " cédula de identidad N° " & DatosCond(22)
   Else
    Doc2.Bookmarks("RutRepBco").Select
    Doc2.Application.Selection.Text = DatosCond(4)
   End If

'    Doc2.Bookmarks("RutRepBco").Select
'    Doc2.Application.Selection.Text = DatosCond(4)
    
    Doc2.Bookmarks("DireccBco").Select
    Doc2.Application.Selection.Text = DatosCond(5)
    
    Doc2.Bookmarks("NomRepCli").Select
    Doc2.Application.Selection.Text = DatosCond(8)
'    Doc2.Bookmarks("RutRepCli").Select
'    Doc2.Application.Selection.Text = DatosCond(9)

   If Len(Trim(DatosCond(23))) > 0 Then
      Doc2.Bookmarks("RutRepCli").Select
      Doc2.Application.Selection.Text = DatosCond(9) & " y don " & DatosCond(23) & " cédula de identidad N° " & DatosCond(24)
   Else
    Doc2.Bookmarks("RutRepCli").Select
    Doc2.Application.Selection.Text = DatosCond(9)
   End If

    
    Doc2.Bookmarks("DireccCli").Select
    Doc2.Application.Selection.Text = DatosCond(10)
    
    Doc2.Bookmarks("NomRepBco2").Select
    Doc2.Application.Selection.Text = DatosCond(3)
    Doc2.Bookmarks("RutRepBco2").Select
    Doc2.Application.Selection.Text = DatosCond(4)
    
    Doc2.Bookmarks("NomRepCli2").Select
    Doc2.Application.Selection.Text = DatosCond(8)
    Doc2.Bookmarks("RutRepCli2").Select
    Doc2.Application.Selection.Text = DatosCond(9)
   

    'Doc2.Application.Visible = True
    Doc2.Bookmarks("NomRepBco3").Select
    Doc2.Application.Selection.Text = DatosCond(21)
    Doc2.Bookmarks("RutRepBco3").Select
    Doc2.Application.Selection.Text = DatosCond(22)
    Doc2.Bookmarks("NomRepCli3").Select
    Doc2.Application.Selection.Text = DatosCond(23)
    Doc2.Bookmarks("RutRepCli3").Select
    Doc2.Application.Selection.Text = DatosCond(24)

    ActiveDocument.SaveAs FileName:=DatosCond(20) & "\Condiciones Generales " & DatosCond(6) & ".doc"
    
    If Donde = "Impresora" Then
        ActiveDocument.PrintOut
    Else
        Doc2.Application.Visible = True
    End If
    'Actualizacion Fecha de Condiciones de Generales en Tabla Cliente
    Sql = "Update View_Cliente Set clfeccondgrl = '" & Format(DatosCond(11), "yyyymmdd") _
          & "' Where clrut = " & DatosCond(25) & " and clcodigo  = " & DatosCond(26)
    If MISQL.SQL_Execute(Sql) <> 0 Then
        MsgBox "Problemas al actualizar fecha de Condiciones Generales en archivo de Clientes", vbCritical, Msj
    End If
    Set Doc2 = Nothing

Exit Function

Control:

    MsgBox "Problemas para crear Condiciones Generales. " & Err.Description, vbInformation, Msj
    Set Doc2 = Nothing

End Function


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
MsgBox Error(Err), vbExclamation
Exit Function
End Function

'Function ProtocoloContratoANt() As Boolean
'
'On Error GoTo Control:
'
'Dim Lin(30)
'Dim nPosicion As Integer
'Dim nFila     As Integer
'Dim nTab      As Integer
'Dim aString()
'Dim nCont     As Integer
'Dim sTexto    As String
'Dim nCont2    As Integer
'Dim cCaracter As String
'Dim FechaHoy As String
'Dim i As Integer
'
'ProtocoloContratoANt = False
'Call FuentesImpresora
'Lin(0) = " "
'Lin(1) = "PROTOCOLO DE DEFINICIONES UTILIZADAS EN CONTRATO DE FORWARD Y/O SWAP DE MONEDAS"
'Lin(2) = "EN EL MERCADO LOCAL"
'
'Lin(3) = "El presente documento contiene las definiciones de los términos empleados en el  Contrato de Forward y/o Swap de "
'Lin(3) = Lin(3) & "de Monedas en el Mercado Local, en adelante 'el contrato'. "
'
'Lin(4) = "^1.       Vendedor:^ En el caso de transacciones forward o swap de dólares de los  Estados  Unidos  de  América  ( en "
'Lin(4) = Lin(4) & "adelante, EEUU )  versus  moneda  nacional,  ya sea  pesos moneda nacional o Unidades de Fomento pagaderas en pesos "
'Lin(4) = Lin(4) & "moneda nacional, el vendedor es la parte que se obliga a vender o entregar los dólares de los EEUU.   En el caso de "
'Lin(4) = Lin(4) & "transacciones forward o swap de dólares de los  EEUU  versus una moneda extranjera distinta del dólar  de los EEUU, "
'Lin(4) = Lin(4) & "el vendedor es la parte que se obliga a vender o entregar la moneda extranjera distinta del dólar de los EEUU. "
'
'Lin(5) = "^2.       Comprador:^ En el caso de transacciones forward o swap de dólares de los EEUU versus moneda nacional, ya sea "
'Lin(5) = Lin(5) & "pesos moneda nacional  o  Unidades de Fomento pagaderas  en pesos moneda nacional,  el comprador es la parte que se "
'Lin(5) = Lin(5) & "obliga a comprar o recibir los dólares de los EEUU.    En el caso de transacciones forward o swap de dólares de los "
'Lin(5) = Lin(5) & "EEUU versus una moneda extranjera distinta de dólar de los EEUU, el comprador es la parte que se obliga  a  comprar "
'Lin(5) = Lin(5) & "o recibir la moneda extranjera distinta del dólar de los EEUU. "
'
'Lin(6) = "^3.       Tipo de Transacción:^ Los tipos de transacción amparados por el contrato son los Forward de Monedas  y  los "
'Lin(6) = Lin(6) & "Swap de Monedas, según lo definido en el N° 2 del Capitulo VII  del  Compendio de Normas de  Cambios Internacionales "
'Lin(6) = Lin(6) & "del Banco Central de Chile, en adelante, el Capitulo VII. "
'
'Lin(7) = "^4.       Fecha de Cierre:^ Es la fecha en que las partes convienen y cierran a firme una transacción  de  forward  o "
'Lin(7) = Lin(7) & "swap, fijando las condiciones de la misma. "
'
'Lin(8) = "^5.       Hora de Cierre:^ Es la hora que las partes convienen los términos de la transacción. "
'
'Lin(9) = "^6.       Fecha de Vencimiento:^ Se llama Fecha de Vencimiento o Fecha de Liquidación y Compensación,  aquella  fecha "
'Lin(9) = Lin(9) & "única para cada contrato, en que se debe producir la entrega de la moneda extranjera  o  en que se debe producir la "
'Lin(9) = Lin(9) & "compensación entre ambas obligaciones, según la forma de cumplimiento estipulada en el contrato.   En el evento que "
'Lin(9) = Lin(9) & "la citada fecha correspondiera a un día que no es día hábil  bancario  en  la  ciudad  de  Santiago,  la  Fecha  de "
'Lin(9) = Lin(9) & "Vencimiento o Fecha de Liquidación y Compensación se postergara hasta el siguiente día hábil bancario. "
'
'Lin(10) = "^7.       Mecanismo de Cumplimiento:^ El mecanismo de cumplimiento  del  contrato podrá ser la  entrega física  o  la "
'Lin(10) = Lin(10) & "compensación según se define en el N° 3 del Capitulo VII.  En caso que el mecanismo sea la  compensación,  para los "
'Lin(10) = Lin(10) & "forward  o  swap de dólares de los  EEUU  versus moneda nacional se entiende  por  Precio Referencial de Mercado la "
'Lin(10) = Lin(10) & "cantidad de pesos resultante de multiplicar el Tipo de Cambio de Referencia estipulado en el contrato, vigente a la "
'Lin(10) = Lin(10) & "fecha de vencimiento de este, por el monto de dólares de los EEUU objeto del contrato. Para los forward  o  swap de "
'Lin(10) = Lin(10) & "dólares de los EEUU versus una moneda extranjera distinta de dólar de los EEUU, se entiende por  Precio Referencial "
'Lin(10) = Lin(10) & "de Mercado la cantidad de dólares de los EEUU, según la Paridad de Referencia estipulada en el contrato, vigente  a "
'Lin(10) = Lin(10) & "la fecha de vencimiento de este. "
'
'Lin(11) = "^8.       Cantidad de moneda Vendida:^ Es el monto de moneda que se compromete a vender o entregar el vendedor en  la "
'Lin(11) = Lin(11) & "fecha de vencimiento. "
'
'Lin(12) = "^9.       Tipo de Cambio Forward Pactado:^ Es la cantidad de pesos moneda nacional o unidades de fomento,  estipulada "
'Lin(12) = Lin(12) & "por las partes en el contrato, necesaria para comprar una unidad de moneda extranjera en la Fecha de Vencimiento. "
'Lin(12) = Lin(12) & "El tipo de cambio en pesos moneda nacional por dólar de los EEUU se expresara con 2 decimales. El tipo de cambio en "
'Lin(12) = Lin(12) & "Unidades de Fomento por dólar de los EEUU se expresara con 10 decimales. "
'
'Lin(13) = "^10.      Paridad de Forward Pactada:^ Es la cantidad de moneda extranjera distinta del dólar de los EEUU, estipulada "
'Lin(13) = Lin(13) & "por las partes en el contrato, necesaria para comprar un dólar de los EEUU en la Fecha de Vencimiento.   La paridad "
'Lin(13) = Lin(13) & "en unidades de moneda extranjera por dólar de los EEUU se expresara con 4 decimales. "
'
'Lin(14) = "^11.      Valor Forward Pactado:^ Es el monto de moneda que se compromete a pagar o entregar el comprador en la fecha "
'Lin(14) = Lin(14) & "de vencimiento. Para los Forward o swap de dólares de los  EEUU  versus moneda nacional el Valor Forward Pactado se "
'Lin(14) = Lin(14) & "expresara en pesos moneda nacional o en Unidades de Fomento, según corresponda.  Para los Forward o Swap de Dólares "
'Lin(14) = Lin(14) & "de los EEUU  versus una moneda extranjera distinta del dólar de los EEUU,  el Valor Forward Pactado se expresara en "
'Lin(14) = Lin(14) & "dólares de los EEUU. "
'
'Lin(15) = "^12.      Tipo de Cambio de Referencia:^ Se entiende el Tipo de Cambio Observado, o el Tipo de Cambio Acuerdo,  o  el "
'Lin(15) = Lin(15) & "Tipo de Cambio REUTERS, o cualquier otra referencia, estipulada por las partes en el contrato. "
'
'Lin(16) = "^13.      Paridad de Referencia:^ Se entiende la Paridad Banco Central de Chile,  o la Paridad REUTERS,  o  cualquier "
'Lin(16) = Lin(16) & "otra referencia, estipulada por las partes en el contrato. "
'
'Lin(17) = "^14.      Otras Condiciones:^ Espacio reservado en el contrato para precisar o definir condiciones no establecidas en "
'Lin(17) = Lin(17) & " el mismo. "
'
'Lin(18) = "^15.      Otras Definiciones:^ Para todos los efectos, se aplicaran las siguientes definiciones: "
'
'Lin(19) = "^a)^ Por Unidad de Fomento se entiende aquella unidad de reajustabilidad que determine  el  Banco Central de "
'Lin(19) = Lin(19) & "Chile de acuerdo a lo previsto en el articulo 35, numero 9 de la Ley N° 18.840, y que publique en el Diario Oficial "
'Lin(19) = Lin(19) & "conforme al Capitulo II.B.3 del Compendio de Normas Financieras, por el valor vigente en la correspondiente   Fecha "
'Lin(19) = Lin(19) & "de Vencimiento o de exigibilidad en caso de liquidación anticipada. "
'
'Lin(20) = "^b)^ Por Tipo de Cambio Observado del dólar de los  EEUU  se entiende el valor en pesos moneda nacional  del "
'Lin(20) = Lin(20) & "dólar  de  los  EEUU,  según lo publique el  Banco Central de Chile  y  que rija en la  Fecha de Vencimiento  o  de "
'Lin(20) = Lin(20) & "exigibilidad en caso de liquidación anticipada,  conforme al numero 6  del Capitulo I del Titulo I del Compendio de "
'Lin(20) = Lin(20) & "Normas de Cambios Internacionales. "
'
'Lin(21) = "^c)^ Por Tipo de Cambio Acuerdo del dólar de los  EEUU  se entiende  el  valor en pesos moneda nacional  del "
'Lin(21) = Lin(21) & "dólar  de los  EEUU,  según fijación que haya hecho el Consejo  del  Banco Central de Chile,  conforme al N° 7  del "
'Lin(21) = Lin(21) & " Capitulo I  del  Titulo I  del  Compendio de Normas  de  Cambios Internacionales,  en la  Fecha de Vencimiento o de "
'Lin(21) = Lin(21) & "exigibilidad en caso de liquidación anticipada. "
'
'Lin(22) = "^d)^ Por Tipo de Cambio Reuters,  se entiende el valor en pesos moneda nacional  de una  unidad de la moneda "
'Lin(22) = Lin(22) & "extranjera de que se trate, según el valor comprador,  vendedor o promedio simple,  según se pacte en el  contrato, "
'Lin(22) = Lin(22) & "informado por REUTERS en pantalla 'CHLJ' para el mercado interbancario, a la hora estipulada en el contrato,  en la "
'Lin(22) = Lin(22) & " Fecha de Vencimiento o de exigibilidad en caso de liquidación anticipada. "
'
'Lin(23) = "^e)^ Por Paridad Banco Central de Chile,  se entiende la cantidad de moneda extranjera  distinta  del  dólar "
'Lin(23) = Lin(23) & " EEUU, necesaria para comprar un dólar EEUU, informada por el Banco Central de Chile conforme al N° 6 del Capitulo I "
'Lin(23) = Lin(23) & "del Titulo I del Comprendió de Normas de Cambios Internacionales, en la Fecha de Vencimiento  o  de exigibilidad en "
'Lin(23) = Lin(23) & " caso de liquidación anticipada. "
'
'Lin(24) = "^f)^ Por paridad REUTERS,  se entiende la cantidad de moneda extranjera distinta del dólar  EEUU,  necesaria "
'Lin(24) = Lin(24) & "para comprar un dólar EEUU,  según el valor comprador,  vendedor o promedio simple,  según se pacte en el contrato, "
'Lin(24) = Lin(24) & "informado por REUTERS en pantalla 'EFX=',  a la hora estipulada en el contrato,  en la  Fecha de Vencimiento  o  de "
'Lin(24) = Lin(24) & " exigibilidad en caso de liquidación anticipada. "
'
'Lin(25) = "En caso que  deje de existir o se modifique alguno de los  factores  definidos,  todas las referencias a 'Unidad de "
'Lin(25) = Lin(25) & "Fomento', 'Tipo de Cambio Observado', 'Tipo de Cambio Acuerdo', 'Tipo de Cambio REUTERS', 'Paridad Banco Central de "
'Lin(25) = Lin(25) & "Chile', o 'Paridad REUTERS', se entenderán como referidas a aquel factor que los reemplace y que sea aplicable a la "
'Lin(25) = Lin(25) & "operación. "
'
'Lin(26) = "@FECHA"
'
'FechaHoy = "Santiago, " & Day(Date) & " de " & BacMesStr(Month(Date)) & " del " & Year(Date)
'
'Lin(26) = BacRemplazar(Lin(26), "@FECHA", FechaHoy)
'
'
'Lin(1) = BacFormatearTexto(Lin(1), 3, 0, 0, 0, 88)
'Lin(2) = BacFormatearTexto(Lin(2), 3, 0, 0, 0, 88)
'
' nTab = 8
' nFila = 2
' BacGlbSetPrinter 65, 80, 1, 1
'' BacGlbSetFont CourierNew, 10, True
' Printer.FontBold = True
'nFila = nFila + 1
'BacGlbPrinter nFila, 1, nTab, 1, Lin(1), 0, 1
'nFila = nFila + 1
'BacGlbPrinter nFila, 1, nTab, 1, Lin(2), 0, 1
'nFila = nFila + 1
'BacGlbPrinter nFila, 1, nTab, 1, Lin(0), 0, 1
'
'nTab = 12
'
'nFila = nFila + 1
'BacGlbPrinter nFila, 1, nTab, 1, Lin(0), 0, 1
'Printer.FontBold = False
''BacGlbSetFont CourierNew, 10, False
'
'For i = 3 To 25
'    nFila = nFila + 1
'    BacGlbPrinter nFila, 1, nTab, 1, Lin(0), 0, 1
'
'    BacCentraTexto aString(), Lin(i), 80
'
'    For nCont = 1 To UBound(aString())
'
'        nFila = nFila + 1
'
'        If nFila = 65 Then
'            nFila = 4
'            Printer.NewPage
'        End If
'        sTexto = aString(nCont)
'        For nCont2 = 1 To Len(sTexto)
'            cCaracter = Mid(sTexto, nCont2, 1)
'
'            If cCaracter = "^" Then
'                Printer.FontBold = IIf(Printer.FontBold = False, True, False)
'                cCaracter = " "
'            End If
'
'            BacGlbPrinter nFila, 1, nTab - 1 + nCont2, 1, cCaracter, 0, 1
'        Next
'    Next
'Next
'
'nFila = nFila + 1
'BacGlbPrinter nFila, 1, nTab, 1, Lin(0), 0, 1
'nFila = nFila + 1
'BacGlbPrinter nFila, 1, nTab, 1, Lin(0), 0, 1
'nFila = nFila + 1
'BacGlbPrinter nFila, 1, nTab, 1, Lin(0), 0, 1
'nFila = nFila + 1
'BacGlbPrinter nFila, 1, nTab, 1, Lin(0), 0, 1
'
'Lin(26) = BacFormatearTexto(Lin(26), 2, 0, 0, 0, 88)    'alinear a la derecha
'nFila = nFila + 1
'BacGlbPrinter nFila, 1, nTab, 1, Lin(26), 0, 1
'
'Printer.NewPage
'
'BacGlbPrinterEnd
'
'ProtocoloContratoANt = True
'
'Exit Function
'
'Control:
'
'    MsgBox "Problemas para Imprimir Informe de Protocolo de Contrato", vbCritical, Msj
'    Exit Function
'
'End Function
'Function SumaFila(Fila, MaxFil)
'
'    Fila = Fila + 1
'
'    If Fila = MaxFil Then
'        Fila = 4
'        Printer.NewPage
'    End If
'
'End Function
'Public Function BacContratoSwaps(NumOper As Double, Tabla As Double, DatCont()) As Boolean
'
'On Error GoTo Control:
'
'Dim Sql As String
'Dim Datos()
'Dim TipOperacion As String
'Dim FechaAnt As Date
'Dim FechaVstr As String
'Dim dias As Integer
'Dim Lin(50)
'Dim LinCli(50)
'Dim LinBco(50)
'Dim LinDir(50)
'Dim m, j
'Dim nPosicion As Integer
'Dim nFila     As Integer
'
'Dim nTab      As Integer
'Dim aString()
'Dim nCont     As Integer
'Dim sTexto    As String
'Dim nCont2    As Integer
'Dim cCaracter As String
'Dim Dat As String
'
'BacContratoSwaps = False
'
'Sql = "EXECUTE sp_DatosContrato " & NumOper & ", " & Tabla & ", '" & giSQL_DatabaseCommon & "'"
'
'If MISQL.SQL_Execute(Sql) <> 0 Then
'   MsgBox "Problemas al leer datos para generar contrato", vbCritical, "MENSAJE"
'   Exit Function
'
'End If
'
'Call FuentesImpresora
'Lin(0) = " "
'Lin(1) = "@BANCO"
'Lin(2) = "CONTRATO A FUTURO"
'Lin(3) = "Número Operación : @NUMERO"
'
'Lin(4) = "Entre ^@BANCO^, Sucursal  en  Chile, en  adelante denominada  'el Banco', "
'Lin(4) = Lin(4) & "representada  por  Don ^@REPBANCO1^,  RUT  N°   ^@RUTREPBCO1^ "
'If DatCont(5) <> "" Then
'    Lin(4) = Lin(4) & "y Don ^@REPBANCO2^,  RUT  N°   ^@RUTREPBCO2^ "
'End If
'
'Lin(4) = Lin(4) & "y  ^@CLIENTE^, representado por Don "
'Lin(4) = Lin(4) & "^@REPCLIENTE1^,  Rut  N° ^@RUTREPCLI1^ "
'If DatCont(12) <> "" Then
'    Lin(4) = Lin(4) & "y Don ^@REPCLIENTE2^,  Rut  N° ^@RUTREPCLI2^ "
'End If
'Lin(4) = Lin(4) & ", en adelante denominado el 'cliente', todo con los "
'Lin(4) = Lin(4) & "domicilios que en este instrumento mas adelante se señalan, se conviene el siguiente Contrato de Futuros: "
'
'Lin(5) = "^PRIMERO : Objeto.^ "
'
'Lin(6) = "Las  partes,  conscientes  que por el dinamismo propio del mercado en que se desarrollan las actividades de su giro, "
'Lin(6) = Lin(6) & "cualquier  fluctuación  importante  que se produzca en las principales variables económicas se traduce en efectos de "
'Lin(6) = Lin(6) & "significación  en  sus  estados  financieros y situación patrimonial, y con el objetivo básico de evitar o minimizar "
'Lin(6) = Lin(6) & "tales  efectos,  en  sus resultados y lograr una adecuada compatibilidad y calce en las estructuras de sus activos y "
'Lin(6) = Lin(6) & "pasivos,  han convenido en la celebración del presente contrato. "
'
'Lin(7) = "^SEGUNDO : Definiciones.^"
'
'Lin(8) = "Para  todos  los  efectos  del  presente contrato, los términos que a continuación se indican, cuando en el presente "
'Lin(8) = Lin(8) & "instrumento se escriban con mayúscula, tendrán el significado que a continuación de cada uno de ellos se expresa: "
'
'Lin(9) = "^(a)  U.F.:^  Es  la  Unidad de Fomento a que se refiere el Art. 35 N° 9 de la Ley 18.840, por su valor vigente en las "
'Lin(9) = Lin(9) & "correspondientes  Fechas  de  Liquidación.  En  el  caso que se modificare o suprimiere el sistema de reajuste de la "
'Lin(9) = Lin(9) & "Unidad  de  Fomento,  las  partes  continuarán  rigiéndose por ella como si no se hubiese modificado o suprimido, de "
'Lin(9) = Lin(9) & "acuerdo  a  las  publicaciones e informes que deber  hacer el Banco Central de Chile según lo dispone el artículo 35 "
'Lin(9) = Lin(9) & "N° 9, inciso 2  y siguientes, de la Ley N° 18.840 Orgánica constitucional del Banco Central de Chile. "
'
'Lin(10) = "^(b) Dólar o US$:^ Es la moneda legal de los Estados Unidos de América. "
'
'Lin(11) = "^(c) Pesos o  $:^ Es la moneda legal de Chile. "
'
'Lin(12) = "^(d)  Fecha  de  Liquidación:^  Son aquellas fechas establecidas en el artículo tercero que sigue, en las cuales deben "
'Lin(12) = Lin(12) & "determinarse  las  obligaciones  recíprocas de las partes, efectuarse la compensación entre ambas hasta por el monto "
'Lin(12) = Lin(12) & "de la  menor de ellas, y solucionarse la obligación por la que resulte deudora. "
'
'Lin(13) = "^(d.1)^  Sin  embargo,  si  cualquiera  Fecha de Liquidación correspondiente a un día que no es un Día Hábil Bancario, "
'Lin(13) = Lin(13) & "dicha Fecha de Liquidación se postergar  hasta el Día Hábil Bancario siguiente. "
'
'Lin(14) = "^(d.2)^  Si  el  cliente  incurriere,  en  cualquier  tiempo, en mora o simple retardo en el cumplimiento de cualquier "
'Lin(14) = Lin(14) & "obligación  con 'el Banco', provenga de este contrato o de cualquier otro, o si cayere en cesación de pagos o insolvencia "
'Lin(14) = Lin(14) & "o  se solicitare o declarare su quiebra, 'el Banco' tendrá  el derecho a anticipar la Fecha de Liquidación correspondiente "
'Lin(14) = Lin(14) & "previo   aviso  por carta certificada enviada al Cliente con 24 horas de anticipación, a su domicilio señalado en la "
'Lin(14) = Lin(14) & "cláusula  sexta del presente contrato. "
'
'Lin(15) = "^(d.3)^  Si  el  Cliente  incurriere,  en  cualquier  tiempo, en mora o simple retardo en el cumplimiento de cualquier "
'Lin(15) = Lin(15) & "obligación  contraida  con 'el Banco' en virtud de este contrato, en especial, en el cumplimiento de cualquier obligación "
'Lin(15) = Lin(15) & "de  pago  de  una suma de dinero, así como en el caso que 'el Banco' anticipare cualquier Fecha de liquidación conforme a "
'Lin(15) = Lin(15) & "lo  señalado  en  (d.2),  'el Banco' podrá  poner término a este contrato de inmediato, previo aviso por carta certificada "
'Lin(15) = Lin(15) & "enviada al Cliente con 24 horas de anticipación, a su domicilio señalado en la cláusula sexta del presente contrato. "
'
'Lin(16) = "^(e)  Día  Hábil  Bancario:^  Es aquel en que los bancos comerciales establecidos en Santiago, están obligados a abrir "
'Lin(16) = Lin(16) & "para la atención de público. "
'
'Lin(17) = "^(f)  Tipo  de Cambio:^ Es la cantidad de Pesos necesaria para comprar un Dólar, según el valor que publicite el Banco "
'Lin(17) = Lin(17) & "Central  de  Chile  o  el  organismo  que  lo  sustituya o reemplace, en conformidad con lo dispuesto en el N° 6 del "
'Lin(17) = Lin(17) & "Capítulo  I,  Título  I,  del Compendio De Normas de Cambios Internacionales del Banco Central de Chile, que rija en "
'Lin(17) = Lin(17) & "las correspondientes Fechas de Liquidación (Dólar Observado). "
'
'Lin(18) = "Si  el  tipo  de  cambio  del Dólar Observado no fuera publicado por el Banco Central de Chile o el organismo que lo "
'Lin(18) = Lin(18) & "reemplace  o  sustituya,  se  aplicará   a este contrato el tipo de cambio promedio informado en las correspondientes "
'Lin(18) = Lin(18) & "Fecha  de  Liquidación  por el Banco Central de Chile como aplicables a las operaciones de compra o venta realizadas "
'Lin(18) = Lin(18) & "por  las  empresas  bancarias.  Si  se  informasen  cotizaciones distintas de compra y venta se aplicará  el promedio "
'Lin(18) = Lin(18) & "aritmético  de  ambas. En caso de que el Banco Central de Chile dejase de informar dicho tipo de cambio promedio, se "
'Lin(18) = Lin(18) & "aplicara  el  tipo   de cambio promedio informado por Inversiones Citicorp Chile S.A. y publicado en algún diario de "
'Lin(18) = Lin(18) & "la  ciudad  de  Santiago  de  Chile,  en  las  correspondientes Fechas de Liquidación y que corresponda al Día Hábil "
'Lin(18) = Lin(18) & "Bancario  inmediatamente  anterior.  A  falta  de  todos los anteriores, se aplicará  el promedio aritmético entre el "
'Lin(18) = Lin(18) & "precio  del  Dólar  comprador  y  del  Dólar vendedor ofrecido en las correspondientes Fechas de Liquidación por las "
'Lin(18) = Lin(18) & "oficinas principales de @BANCO, Sucursal en Chile. "
'
'Lin(19) = "^(g)  Libo  o  Libor:^  Es  la  tasa  de  interés  a  180  días  certificada como tal en la información del 'Estado de "
'Lin(19) = Lin(19) & "Equivalencias  en  Moneda  Extranjera'  proporcionada  por  el  Banco  Central de Chile, y publicada en el diario El "
'Lin(19) = Lin(19) & "Mercurio  de  Santiago, Estrategia o en el Diario Financiero en las correspondientes Fechas de Liquidación indicadas "
'Lin(19) = Lin(19) & "en  la  cláusula  tercera.  No  obstante  para  el  cálculo  de la tasa que regirá  entre la fecha de suscripción del "
'Lin(19) = Lin(19) & "presente  contrato  y  la  primera  Fecha  de  Liquidación,  esto  es, el @FECHVCT1, se considerar  la tasa Libo de "
'Lin(19) = Lin(19) & "@VALORLIB % corresponde al día @FECHCIERRE. "
'
''Lin(20) = *****"En  caso  que  por  cualquiera  causa  o  motivo  el  Banco Central de Chile no hubiere informado la tasa Libo antes"
''Lin(20) = Lin(20) & "indicada,  se  aplicará  en  su  reemplazo  la tasa Libo para 180 días que informe @BANCO, en su oficina"
''Lin(20) = Lin(20) & "principal de  la ciudad de Londres, Inglaterra, como vigente durante el respectivo período."
'
'Lin(21) = "^(h) Tasa Activa Bancario o TAB:^ Es la tasa de interés ponderada que, para operaciones de ciento ochenta días informa "
'Lin(21) = Lin(21) & "y  determina  para  cada  día  hábil  bancario la Asociación de Bancos e Instituciones Financieras de Chile A.G., en "
'Lin(21) = Lin(21) & "adelante  la  'Asociación',  sobre  la  base de los datos que le proporcionan cada día las instituciones financieras "
'Lin(21) = Lin(21) & "participantes,  a  más  tardar  a  las  once  horas  ante  meridiano,  acerca  de sus tasas marginales de captación, "
'Lin(21) = Lin(21) & "agregándoles  el  costo  que  representan  aquellos factores objetivos cuantificables y comunes para todo el sistema "
'Lin(21) = Lin(21) & "financiero  que,  a  juicio  de  la  Asociación, encarecen la captación de fondos del público, todo ello conforme al "
'Lin(21) = Lin(21) & "reglamento  de  Tasa  Activa  Bancaria  (TAB)  publicado en extracto por la Asociación en el Diario Oficial de fecha "
'Lin(21) = Lin(21) & "veintidós de Agosto de mil novecientos noventa y dos."
'
'Lin(22) = "^TERCERO:^  Por  el  presente  instrumento,  el  Cliente  se  obliga  a pagar a 'el Banco' en la Fecha de Liquidación las "
'Lin(22) = Lin(22) & "siguientes cantidades equivalentes en Pesos al tipo de cambio de las respectivas Fechas de Liquidación. "
'          '12345678901234567890123456789012345678901234567890123456789012345678901234567890
'Lin(23) = "^Fecha de Liquidación       Monto @MONEDA^ "
'Lin(24) = "_________________________________________________________________________________________"
'
'Lin(26) = "Por  su  parte,  'el Banco'  se  obliga  a  pagar al Cliente en las correspondientes Fechas de liquidación las siguientes "
'Lin(26) = Lin(26) & "cantidades equivalentes en Pesos al valor de la Unidad de Fomento de las respectivas Fechas de Liquidación: "
'
'Lin(27) = "^Fecha de Liquidación    Monto @MONEDA^"
'
'Lin(29) = "Para todos los cálculos a efectuar en cada una de las Fechas de Liquidación señaladas en los párrafos anteriores, se "
'Lin(29) = Lin(29) & "utilizará  según  corresponda,  la  tasa  Libo  y  la  tasa  TAB  vigente  en  el mercado, a la Fecha de liquidación "
'Lin(29) = Lin(29) & "inmediatamente anterior. "
'
'Lin(30) = "^QUINTO:^  Las  partes  acuerdan  que  ni  el  presente  contrato  ni los derechos que en él constan, son libremente "
'Lin(30) = Lin(30) & "transferibles  ni  pueden  cederse  por  endoso. En consecuencia, ninguna de las partes podrá  ceder o transferir los "
'Lin(30) = Lin(30) & "derechos  del   presente contrato sin el previo consentimiento de la otra parte. Para este efecto, el consentimiento "
'Lin(30) = Lin(30) & "de  ambas  partes deber  manifestarse en cada uno de los dos ejemplares del presentes contratos, indicándose bajo la "
'Lin(30) = Lin(30) & "firma  de  cada  una de ellas el nombre de la persona a quien se venden los derechos, así como la aceptación de ésta "
'Lin(30) = Lin(30) & "última para contraer todas las obligaciones que tenía anteriormente la parte cesionaria. "
'
'Lin(31) = "^SEXTO:^  Durante  la  vigencia del presente contrato, 'el Banco' estará  facultado para que a su sola discreción, efectúe "
'Lin(31) = Lin(31) & "colocaciones  interbancarias  en  @CLIENTE  por  un  monto equivalente a la cantidad señalada en la fecha de "
'Lin(31) = Lin(31) & "Liquidación  inmediatamente  posterior  a la Fecha de Liquidación en que se realiza la respectiva colocación y @CLIENTE "
'Lin(31) = Lin(31) & "se  obliga a captar dichas colocaciones. Tales colocaciones se realizarán en cualquier período comprendido "
'Lin(31) = Lin(31) & "entre  dos  Fechas  de  Liquidación  sucesivas  y @CLIENTE pagará  a 'el Banco' la tasa   @VALORTASCLI % vigente en el "
'Lin(31) = Lin(31) & "mercado en la fecha  en que se efectúe la colocación referida. "
'
'Lin(32) = "^SEPTIMO:^ Para todos los efectos derivados del presente contrato, las partes fijan domicilio especial y único en la "
'Lin(32) = Lin(32) & "Ciudad  y  Comuna  de Santiago. Para los efectos de los avisos, requerimientos y notificaciones a que haya lugar las "
'Lin(32) = Lin(32) & "partes fijan los siguientes domicilios: "
'
'LinDir(1) = "@BANCO"
'LinDir(2) = "@DIRBANCO"
'LinDir(3) = "Atn. : @REPBANCO1"
'LinDir(4) = "       @REPBANCO2"
'
'LinDir(5) = "@CLIENTE"
'LinDir(6) = "@DIRCLIENTE"
'LinDir(7) = "Atn. : @REPCLIENTE1"
'LinDir(8) = "       @REPCLIENTE2"
'
'Lin(41) = "Cualquiera  de  las  partes  podrá   modificar  el  domicilio  antes  indicado,  comunicándoselo  a la otra por carta "
'Lin(41) = Lin(41) & "certificada  dirigida al domicilio señalado precedentemente en esta cláusula, como una anticipación no inferior a 10 "
'Lin(41) = Lin(41) & "días  de la fecha en que dicho cambio de domicilio producirá  sus efectos. En todo caso, todos los domicilios que las "
'Lin(41) = Lin(41) & "partes fijen deberán encontrarse en la ciudad de Santiago de Chile. "
'
'Lin(42) = "^SEPTIMO:^ Todos los gastos, impuestos, derechos y desembolsos de cualquier naturaleza que se causaren con motivo del "
'Lin(42) = Lin(42) & "otorgamiento del presente contrato, de su aplicación y/o de su cumplimiento, serán de cargo exclusivo del Cliente. "
'
'Lin(43) = "^OCTAVO:^ Todas las obligaciones de las partes derivadas del presente contrato serán individuales, en los términos de "
'Lin(43) = Lin(43) & "los artículos 1526 # 4 y 1528 del Código Civil de la República de Chile. "
'
'Lin(44) = "^NOVENO:^  Cualquier  dificultad o controversia que se suscite entre las partes por cualquier motivo o circunstancia, "
'Lin(44) = Lin(44) & "que se relacione directa o indirectamente con este contrato, será  resuelta en arbitraje ante un  árbitro arbitrador o "
'Lin(44) = Lin(44) & "amigable  componedor  quien  resolverá  sin forma de juicio y sin ulterior recurso. El  árbitro será  nombrado de común "
'Lin(44) = Lin(44) & "acuerdo  por las partes. A falta de acuerdo la designación de  árbitro la hará  la justicia ordinaria, a requerimiento "
'Lin(44) = Lin(44) & "de   cualquiera  de  las  partes,  pero  en este caso el  árbitro será de derecho, el procedimiento se sujetará a las "
'Lin(44) = Lin(44) & "normas de  juicio sumario, y las resoluciones que dicte el  árbitro serán susceptibles de todo los recursos legales. "
'
'Lin(45) = "El presente contrato se suscribe en dos ejemplares del mismo temor y fecha, quedando uno en poder de cada parte. "
'          '12345678901234567890123456789012345678901234567890123456789012345678901234567890
'Lin(46) = "Firma  :______________________________  Firma  : ______________________________"
'Lin(47) = "pp.    :@BANCO pp.    : @CLIENTE "
'Lin(48) = "Nombre :@REPBANCO Nombre : @REPCLIENTE "
'Lin(49) = "Rut    :@RUTREPBCO Rut    : @RUTREPCLI "
'
'' Reemplazo de datos
'
'Lin(1) = BacRemplazar(Lin(1), "@BANCO", DatCont(1))
'Lin(3) = BacRemplazar(Lin(3), "@NUMERO", NumOper)
'Lin(4) = BacRemplazar(Lin(4), "@BANCO", DatCont(1))
'Lin(4) = BacRemplazar(Lin(4), "@REPBANCO1", DatCont(3))
'Lin(4) = BacRemplazar(Lin(4), "@RUTREPBCO1", DatCont(4))
'If DatCont(5) <> "" Then
'    Lin(4) = BacRemplazar(Lin(4), "@REPBANCO2", DatCont(5))
'    Lin(4) = BacRemplazar(Lin(4), "@RUTREPBCO2", DatCont(6))
'End If
'Lin(4) = BacRemplazar(Lin(4), "@CLIENTE", DatCont(8))
'Lin(4) = BacRemplazar(Lin(4), "@REPCLIENTE1", DatCont(10))
'Lin(4) = BacRemplazar(Lin(4), "@RUTREPCLI1", DatCont(11))
'If DatCont(12) <> "" Then
'    Lin(4) = BacRemplazar(Lin(4), "@REPCLIENTE2", DatCont(12))
'    Lin(4) = BacRemplazar(Lin(4), "@RUTREPCLI2", DatCont(13))
'End If
'
'Lin(18) = BacRemplazar(Lin(18), "@BANCO", DatCont(1))
'
'Lin(19) = BacRemplazar(Lin(19), "@FECHVCT1", DatCont(1))
'Lin(19) = BacRemplazar(Lin(19), "@VALORLIB", DatCont(1))
'Lin(19) = BacRemplazar(Lin(19), "@FECHCIERRE", DatCont(1))
'
'Lin(31) = BacRemplazar(Lin(31), "@CLIENTE", DatCont(8))
'Lin(31) = BacRemplazar(Lin(31), "@CLIENTE", DatCont(8))
'Lin(31) = BacRemplazar(Lin(31), "@CLIENTE", DatCont(8))
'
'LinDir(1) = BacRemplazar(LinDir(1), "@BANCO", DatCont(1))
'LinDir(2) = BacRemplazar(LinDir(2), "@DIRBANCO", DatCont(7))
'LinDir(3) = BacRemplazar(LinDir(3), "@REPBANCO1", DatCont(3))
'If DatCont(5) <> "" Then
'    LinDir(4) = BacRemplazar(LinDir(4), "@REPBANCO2", DatCont(5))
'End If
'
'LinDir(5) = BacRemplazar(LinDir(5), "@CLIENTE", DatCont(8))
'LinDir(6) = BacRemplazar(LinDir(6), "@DIRCLIENTE", DatCont(14))
'LinDir(7) = BacRemplazar(LinDir(7), "@REPCLIENTE1", DatCont(3))
'If DatCont(12) <> "" Then
'    LinDir(8) = BacRemplazar(LinDir(8), "@REPCLIENTE2", DatCont(12))
'End If
'
'Lin(47) = BacRemplazar(Lin(47), "@BANCO", DatCont(1) & Space(31 - Len(DatCont(1))))
'Lin(47) = BacRemplazar(Lin(47), "@CLIENTE", DatCont(8) & Space(30 - Len(DatCont(8))))
'DatCont(3) = Left(DatCont(3), 25)
'Lin(48) = BacRemplazar(Lin(48), "@REPBANCO", DatCont(3) & Space(31 - Len(DatCont(3))))
'Lin(48) = BacRemplazar(Lin(48), "@REPCLIENTE", DatCont(10) & Space(30 - Len(DatCont(10))))
'Lin(49) = BacRemplazar(Lin(49), "@RUTREPBCO", DatCont(4) & Space(31 - Len(DatCont(4))))
'Lin(49) = BacRemplazar(Lin(49), "@RUTREPCLI", DatCont(11) & Space(30 - Len(DatCont(11))))
'
'Lin(25) = ""
'Lin(28) = ""
'
'm = 0
'Do While MISQL.SQL_Fetch(Datos()) = 0
'    FechaAnt = Datos(6)
'    m = m + 1
'
'    TipOperacion = Datos(4)
'
'    FechaVstr = Format(Day(Datos(20)), "00") & " de " & BacMesStr(Month(Datos(20))) & " del " & Year(Datos(20))
'
'    LinCli(m) = "@FECHAVENCFLUJ @MONTOCLI @NOMTASA @VALORTASA% @DIASBASE @MONTOAMORT "
'    LinBco(m) = "@FECHAVENCFLUJ @MONTOBCO @NOMTASA @VALORTASA% @DIASBASE @MONTOAMORT "
'                        '12345678901234567890123456789012345678901234567890123456789012345678901234567890
'    dias = DateDiff("d", FechaAnt, Datos(20))
'
'    If TipOperacion = "C" Then
'
'        LinCli(m) = BacRemplazar(LinCli(m), "@FECHAVENCFLUJ", FechaVstr & Space(25 - Len(FechaVstr)))
'        Dat = Format(Datos(53), "###,###,###,##0.00")
'        LinCli(m) = BacRemplazar(LinCli(m), "@MONTOCLI", Space(18 - Len(Dat)) & Dat)
'        LinCli(m) = BacRemplazar(LinCli(m), "@NOMTASA", Space(5 - Len(Datos(27))) & Datos(27))
'        Dat = Format(Datos(57), "###0.00000")
'        LinCli(m) = BacRemplazar(LinCli(m), "@VALORTASA", Space(10 - Len(Dat)) & Dat)
'        Dat = dias & "/" & Val(Datos(22))
'        LinCli(m) = BacRemplazar(LinCli(m), "@DIASBASE", Space(7 - Len(Dat)) & Dat)
'        Dat = Format(Datos(52), "###,###,###,##0.00")
'        LinCli(m) = BacRemplazar(LinCli(m), "@MONTOAMORT", Space(18 - Len(Dat)) & Dat)
'
'        LinBco(m) = BacRemplazar(LinBco(m), "@FECHAVENCFLUJ", FechaVstr & Space(25 - Len(FechaVstr)))
'        Dat = Format(Datos(34), "###,###,###,##0.00")
'        LinBco(m) = BacRemplazar(LinBco(m), "@MONTOBCO", Space(18 - Len(Dat)) & Dat)
'        LinBco(m) = BacRemplazar(LinBco(m), "@NOMTASA", Space(5 - Len(Datos(26))) & Datos(26))
'        Dat = Format(Datos(38), "###0.00000")
'        LinBco(m) = BacRemplazar(LinBco(m), "@VALORTASA", Space(10 - Len(Dat)) & Dat)
'        Dat = dias & "/" & Val(Datos(23))
'        LinBco(m) = BacRemplazar(LinBco(m), "@DIASBASE", Space(7 - Len(Dat)) & Dat)
'        Dat = Format(Datos(33), "###,###,###,##0.00")
'        LinBco(m) = BacRemplazar(LinBco(m), "@MONTOAMORT", Space(18 - Len(Dat)) & Dat)
'
'    Else
'
'        LinBco(m) = BacRemplazar(LinBco(m), "@FECHAVENCFLUJ", FechaVstr & Space(25 - Len(FechaVstr)))
'        Dat = Format(Datos(53), "###,###,###,##0.00")
'        LinBco(m) = BacRemplazar(LinBco(m), "@MONTOCLI", Space(18 - Len(Dat)) & Dat)
'        LinBco(m) = BacRemplazar(LinBco(m), "@NOMTASA", Space(5 - Len(Datos(27))) & Datos(27))
'        Dat = Format(Datos(57), "###0.00000")
'        LinBco(m) = BacRemplazar(LinBco(m), "@VALORTASA", Space(10 - Len(Dat)) & Dat)
'        Dat = dias & "/" & Val(Datos(22))
'        LinBco(m) = BacRemplazar(LinBco(m), "@DIASBASE", Space(7 - Len(Dat)) & Dat)
'        Dat = Format(Datos(52), "###,###,###,##0.00")
'        LinBco(m) = BacRemplazar(LinBco(m), "@MONTOAMORT", Space(18 - Len(Dat)) & Dat)
'
'        LinCli(m) = BacRemplazar(LinCli(m), "@FECHAVENCFLUJ", FechaVstr & Space(25 - Len(FechaVstr)))
'        Dat = Format(Datos(34), "###,###,###,##0.00")
'        LinCli(m) = BacRemplazar(LinCli(m), "@MONTOBCO", Space(18 - Len(Dat)) & Dat)
'        LinCli(m) = BacRemplazar(LinCli(m), "@NOMTASA", Space(5 - Len(Datos(26))) & Datos(26))
'        Dat = Format(Datos(38), "###0.00000")
'        LinCli(m) = BacRemplazar(LinCli(m), "@VALORTASA", Space(10 - Len(Dat)) & Dat)
'        Dat = dias & "/" & Val(Datos(23))
'        LinCli(m) = BacRemplazar(LinCli(m), "@DIASBASE", Space(7 - Len(Dat)) & Dat)
'        Dat = Format(Datos(33), "###,###,###,##0.00")
'        LinCli(m) = BacRemplazar(LinCli(m), "@MONTOAMORT", Space(18 - Len(Dat)) & Dat)
'
'    End If
'
'Loop
'
'Lin(23) = BacRemplazar(Lin(23), "@MONEDA", Datos(10))
'Lin(27) = BacRemplazar(Lin(27), "@MONEDA", Datos(10))
'If TipOperacion = "C" Then
'    Lin(31) = BacRemplazar(Lin(31), "@VALORTASCLI", Datos(24))
'Else
'    Lin(31) = BacRemplazar(Lin(31), "@VALORTASCLI", Datos(23))
'End If
'
'
'Lin(1) = BacFormatearTexto(Lin(1), 3, 0, 0, 0, 88)
'Lin(2) = BacFormatearTexto(Lin(2), 3, 0, 0, 0, 88)
'
' nTab = 8
' nFila = 2
' BacGlbSetPrinter 65, 80, 1, 1
' 'BacGlbSetFont CourierNew, 10, True
'  Printer.FontBold = True
'Call SumaFila(nFila, 65)
'BacGlbPrinter nFila, 1, nTab, 1, Lin(1), 0, 1
'
'Call SumaFila(nFila, 65)
'BacGlbPrinter nFila, 1, nTab, 1, Lin(2), 0, 1
'
'Call SumaFila(nFila, 65)
'BacGlbPrinter nFila, 1, nTab, 1, Lin(0), 0, 1
'
'nTab = 12
'
'Call SumaFila(nFila, 65)
'BacGlbPrinter nFila, 1, nTab, 1, Lin(3), 0, 1
'
'Call SumaFila(nFila, 65)
'BacGlbPrinter nFila, 1, nTab, 1, Lin(0), 0, 1
'Printer.FontBold = False
''BacGlbSetFont CourierNew, 10, False
'
'For i = 4 To 45
'
'    Call SumaFila(nFila, 65)
'    BacGlbPrinter nFila, 1, nTab, 1, Lin(0), 0, 1
'
'    If i = 24 Then
'        'BacGlbSetFont CourierNew, 8, False
'        Printer.FontBold = False
'        nTab = 18
'
'        Call SumaFila(nFila, 65)
'        BacGlbPrinter nFila, 1, nTab, 1, Lin(24), 0, 1
'        For j = 1 To m
'            Call SumaFila(nFila, 65)
'            BacGlbPrinter nFila, 1, nTab, 1, LinCli(j), 0, 1
'        Next
'
'        Call SumaFila(nFila, 65)
'        BacGlbPrinter nFila, 1, nTab, 1, Lin(24), 0, 1
'        Printer.FontBold = False
'        'BacGlbSetFont CourierNew, 10, False
'        nTab = 12
'
'    ElseIf i = 28 Then
'        Printer.FontBold = False
'        'BacGlbSetFont CourierNew, 8, False
'        nTab = 18
'
'        Call SumaFila(nFila, 65)
'        BacGlbPrinter nFila, 1, nTab, 1, Lin(24), 0, 1
'
'        For j = 1 To m
'            Call SumaFila(nFila, 65)
'            BacGlbPrinter nFila, 1, nTab, 1, LinBco(j), 0, 1
'        Next
'
'        Call SumaFila(nFila, 65)
'        BacGlbPrinter nFila, 1, nTab, 1, Lin(24), 0, 1
'        Printer.FontBold = False
'        'BacGlbSetFont CourierNew, 10, False
'        nTab = 12
'
'    ElseIf i = 33 Then
'
'        Call SumaFila(nFila, 65)
'        BacGlbPrinter nFila, 1, nTab, 1, Lin(i), 0, 1
'
'        For j = 1 To 8
'
'            Call SumaFila(nFila, 65)
'            Select Case j
'            Case 4
'                If DatCont(5) <> "" Then
'                    BacGlbPrinter nFila, 1, nTab, 1, LinDir(j), 0, 1
'                    Call SumaFila(nFila, 65)
'                End If
'                BacGlbPrinter nFila, 1, nTab, 1, LinDir(0), 0, 1
'
'            Case 8
'                If DatCont(12) <> "" Then
'                    BacGlbPrinter nFila, 1, nTab, 1, LinDir(j), 0, 1
'                    Call SumaFila(nFila, 65)
'                End If
'                BacGlbPrinter nFila, 1, nTab, 1, LinDir(0), 0, 1
'
'            Case Else
'                BacGlbPrinter nFila, 1, nTab, 1, LinDir(j), 0, 1
'
'            End Select
'
'        Next
'
'        i = 41
'
'    Else
'
'        BacCentraTexto aString(), Lin(i), 80
'
'        For nCont = 1 To UBound(aString())
'
'            Call SumaFila(nFila, 65)
'
'            sTexto = aString(nCont)
'            For nCont2 = 1 To Len(sTexto)
'                cCaracter = Mid(sTexto, nCont2, 1)
'
'                If cCaracter = "^" Then
'                    Printer.FontBold = IIf(Printer.FontBold = False, True, False)
'                    cCaracter = " "
'                End If
'
'                BacGlbPrinter nFila, 1, nTab - 1 + nCont2, 1, cCaracter, 0, 1
'            Next
'        Next
'
'    End If
'Next
'
'For i = 1 To 4
'    Call SumaFila(nFila, 65)
'    BacGlbPrinter nFila, 1, nTab, 1, Lin(0), 0, 1
'Next
'For i = 46 To 49
'    Call SumaFila(nFila, 65)
'    BacGlbPrinter nFila, 1, nTab, 1, Lin(i), 0, 1
'Next
'
'Printer.NewPage
'
'BacGlbPrinterEnd
'
'BacContratoSwaps = True
'
'Exit Function
'
'Control:
'
'    MsgBox "Problemas al generar Contrato!", vbInformation, Msj
'    Exit Function
'
'End Function
'Public Function BacCondicionesGeneralesold(DatCont()) As Boolean
'
'Dim Sql       As String
'Dim Lin(72)
'Dim nPosicion As Integer
'Dim nFila     As Integer
'Dim nTab      As Integer
'Dim aString()
'Dim nCont     As Integer
'Dim sTexto    As String
'Dim nCont2    As Integer
'Dim cCaracter As String
'Dim i As Integer
'
'Call FuentesImpresora
'
'Lin(0) = " "
'Lin(1) = "CONDICIONES GENERALES PARA"
'Lin(1) = BacFormatearTexto(Lin(1), 3, 0, 0, 0, 88)
'Lin(2) = "LA CELEBRACION DE TRANSACCIONES"
'Lin(2) = BacFormatearTexto(Lin(2), 3, 0, 0, 0, 88)
'Lin(3) = "DE MERCADO A FUTURO DE MONEDA EXTRANJERA"
'Lin(3) = BacFormatearTexto(Lin(3), 3, 0, 0, 0, 88)
'Lin(4) = "@BANCO, SUCURSAL EN CHILE"
'Lin(5) = "Y"
'Lin(5) = BacFormatearTexto(Lin(5), 3, 0, 0, 0, 88)
'Lin(6) = "@CLIENTE"
'
'Lin(7) = "En @CIUDAD de Chile, a  @FECHACIERRE, comparecen por una parte,^@BANCO, @SUCURSAL^, "
'Lin(7) = Lin(7) & "del giro de su denominación, representada por don(a) ^@REPBANCO1^  RUT  Nø ^@RUTREPBCO1^ "
'Lin(7) = Lin(7) & "y   ^@REPBANCO2^  RUT  Nø ^@RUTREPBCO2^  los anteriores  con domicilio, para estos efectos, en calle "
'Lin(7) = Lin(7) & "@DIRBANCO de esta ciudad en adelante también indistintamente  'El  Banco' y  por  la otra "
'Lin(7) = Lin(7) & "^@NOMBRECLIENTE^ representada por don(a) ^@REPCLIENTE1^ RUT  Nø ^@RUTREPCLI1^ "
'Lin(7) = Lin(7) & "y  don(a) ^@REPCLIENTE2^ RUT  Nø ^@RUTREPCLI2^ ambos domiciliados, para estos efectos, "
'Lin(7) = Lin(7) & "en ^@DIRCLIENTE^ de esta ciudad, en adelante también el 'Cliente', quienes exponen:"
'
'Lin(8) = "^PRIMERO:^ Por el presente instrumento,  las partes  mas arriba  individualizadas vienen en convenir los "
'Lin(8) = Lin(8) & "términos y condiciones generales que regirán y se aplicaran a todas y cada una de las transacciones  de "
'Lin(8) = Lin(8) & "CompraVenta a futuro de moneda extranjera,  de Arbitrajes a futuro de moneda extranjera  (Forwards) y "
'Lin(8) = Lin(8) & "Permutas a futuro de moneda extranjera (Swaps),  que se acuerden  o  celebren entre ellas,  a contar de "
'Lin(8) = Lin(8) & "esta fecha. "
'
'Lin(9) = "En consecuencia,  todas y cada una de las  transacciones recién  indicadas celebrada  o  acordada entre "
'Lin(9) = Lin(9) & "ambas,  quedara sujeta a las presentes  condiciones generales,  salvo en cuanto  en el documento  de la "
'Lin(9) = Lin(9) & "respectiva operación, acordaren expresamente algo distinto. "
'
'Lin(10) = "Las presentes  Condiciones Generales se rigen y han sido elaboradas en conformidad a las  disposiciones "
'Lin(10) = Lin(10) & "del Capitulo VII del Titulo I  del  Compendio de Normas sobre Cambios Internacionales Del Banco Central "
'Lin(10) = Lin(10) & "de Chile, vigentes a esta fecha y que las partes declaran conocer y entender plenamente. "
'
'Lin(11) = "^SEGUNDO:^ El Cliente declara y acepta que las transacciones de CompraVenta, de Arbitrajes (Forwards)  y "
'Lin(11) = Lin(11) & "de Permuta (Swaps), de moneda extranjera a futuro, implica el riesgo propio de la variación del tipo de "
'Lin(11) = Lin(11) & "cambio y/o de la paridad de la divisa objeto del contrato, entre la Fecha de Celebración  y la Fecha de "
'Lin(11) = Lin(11) & "Vencimiento del mismo, ambas definidas mas adelante. "
'
'Lin(12) = "En consecuencia,  declara y acepta asimismo  que el carácter aleatorio  de las referidas transacciones, "
'Lin(12) = Lin(12) & "implica el riesgo de que la diferencia entre el precio pactado en pesos moneda corriente nacional  y el "
'Lin(12) = Lin(12) & "precio referencial de mercado,  que más adelante se define,  a la Fecha de Vencimiento de la respectiva "
'Lin(12) = Lin(12) & "transacción,  podrá resultarle  adversa o favorable,  lo que ha  considerado  al convenir las presentes "
'Lin(12) = Lin(12) & "Condiciones Generales así como al celebrar cada transacción regida por las mismas. "
'
'Lin(13) = "^TERCERO:^ Definiciones:  Para todos  los  efectos de  aplicación  e  interpretación  de  las  presentes "
'Lin(13) = Lin(13) & "Condiciones Generales,  así como de los términos y condiciones de cada Formulario de Confirmación,  los "
'Lin(13) = Lin(13) & "términos  que  a continuación se indican,  cuando  se  expresen  con  mayúscula  tendrán  el  siguiente "
'Lin(13) = Lin(13) & "significado: "
'
'Lin(14) = "^a) Formulario de Confirmación o Confirmación:^ El documento  mediante  el cual las partes convienen  en "
'Lin(14) = Lin(14) & "celebrar una o varias transacciones especificadas de CompraVenta o de Arbitraje (Forward) o de  Permuta "
'Lin(14) = Lin(14) & " (Swap) de Moneda Extranjera a futuro, fijando los términos y condiciones de la o las mismas.       Cada "
'Lin(14) = Lin(14) & "documento de  Confirmación  que las partes  suscriban, se entenderá  formar  parte  integrante  de  las "
'Lin(14) = Lin(14) & "presentes Condiciones Generales. "
'
'Lin(15) = "Cada  Confirmación  de  una  o  más  transacciones  especificas  acordadas  entre  las  partes,  deberá "
'Lin(15) = Lin(15) & "documentarse  en un  'Formulario  de  Confirmación'  similar  al que contiene en el  'Anexo  A'  de las "
'Lin(15) = Lin(15) & "presentes Condiciones Generales el cual se inserta al final y que forma parte integrante de las mismas. "
'
'Lin(16) = "^b) Contradicción:^ En caso  de  contradicción  entre  un documento  de  Confirmación  y  las  presentes "
'Lin(16) = Lin(16) & "Condiciones Generales, primaran los términos de la respectiva Confirmación. "
'
'Lin(17) = "^c) Tipo de Transacción:^ CompraVenta, Arbitraje(Forward) y Permuta(Swap) de Moneda Extranjera a futuro: "
'
'Lin(18) = "^c.1) CompraVenta:^ Aquella transacción en que el Vendedor se compromete a entregar la  Moneda Extranjera "
'Lin(18) = Lin(18) & "vendida y el Comprador se obliga a pagar el precio convenido en pesos, moneda corriente nacional, o  en "
'Lin(18) = Lin(18) & "Unidades de Fomento pagaderas por su equivalente en pesos,  moneda corriente nacional,  en la  Fecha de "
'Lin(18) = Lin(18) & "Vencimiento acordada en la respectiva Confirmación. "
'
'Lin(19) = "^c.2) Arbitraje o Forward:^ Aquella transacción  en que el Vendedor se compromete  a  entregar la Moneda "
'Lin(19) = Lin(19) & "Extranjera vendida y el Comprador se obliga a  pagar el precio convenido  en  Dólares,  en la  Fecha de "
'Lin(19) = Lin(19) & "Vencimiento estipulada en la respectiva Confirmación. "
'
'Lin(20) = "^c.3) Permuta o Swap:^ Aquella transacción  en que las partes  intercambian  flujos  financieros  en dos "
'Lin(20) = Lin(20) & "monedas diferentes, comprometiéndose una de ellas a entregar pesos, moneda corriente nacional, Unidades "
'Lin(20) = Lin(20) & "de Fomento pagaderas por su equivalente en pesos,  moneda corriente nacional,  o Dólares  y  la otra  a "
'Lin(20) = Lin(20) & "entregar la Moneda Extranjera, en la Fecha de Vencimiento especificadas en la respectiva  Confirmación. "
'
'Lin(21) = "^d) Parte Vendedora o Vendedor y parte Compradora o Comprador:^"
'
'Lin(22) = "^d.1) Vendedor:^ Aquella parte que se obliga a entregar a la otra, la Moneda Extranjera,  en la Fecha de "
'Lin(22) = Lin(22) & "Vencimiento de la respectiva Confirmación."
'
'Lin(23) = "El Vendedor deberá cumplir con las obligaciones  que le impone  el contrato  a la  Fecha de Vencimiento "
'Lin(23) = Lin(23) & "pactada, de acuerdo al mecanismo que se haya convenido en la respectiva Confirmación, el que deberá ser "
'Lin(23) = Lin(23) & "alguno de los que se indican a continuación : "
'
'Lin(24) = "^i) Entrega:^ El Vendedor entregara la Moneda Extranjera en la Fecha de Vencimiento estipulada. "
'
'Lin(25) = "En esta modalidad y para el caso que el Vendedor o Comprador fuere persona natural o jurídica residente "
'Lin(25) = Lin(25) & "en Chile, la entrega de Moneda Extranjera quedara condicionada a que este demuestre a satisfacción  del "
'Lin(25) = Lin(25) & "banco contraparte,  a  mas  tardar  el día hábil bancario  anterior  a la  Fecha de Vencimiento  de  la "
'Lin(25) = Lin(25) & "transacción, que con dichas divisas realizara a través de dicho banco una operación de cambio expresada "
'Lin(25) = Lin(25) & "en la misma Moneda Extranjera objeto del contrato,  por un monto igual  o  superior al estipulado en él "
'Lin(25) = Lin(25) & "mismo."
'
'Lin(26) = "En tal evento,  la entrega de Moneda Extranjera se efectuara  por el  Vendedor mediante  la  entrega de "
'Lin(26) = Lin(26) & "cheque bancario girado sobre la ciudad de Nueva York, Estados Unidos de América  o mediante abono en la "
'Lin(26) = Lin(26) & "cuenta corriente en esa misma moneda y que el Comprador hubiere indicado en la respectiva Confirmación. "
'
'Lin(27) = "En esta modalidad,  si no se cumplieren  o  demostraren las condiciones antes referidas,  o si el monto "
'Lin(27) = Lin(27) & "pactado  de la divisa  objeto  del  contrato fuere  superior  al  involucrado en la operación de cambio "
'Lin(27) = Lin(27) & "demostrada  a  satisfacción de  'El Banco',  respecto del total en el primer caso  o  por el excedente en él "
'Lin(27) = Lin(27) & "segundo,  el contrato  se cumplirá  mediante  el  mecanismo de  compensación  descrito en el  punto ii) "
'Lin(27) = Lin(27) & "siguiente."
'
'Lin(28) = "^ii) Compensación:^ En esta modalidad, el contrato se cumplirá pagando el Comprador al Vendedor, el monto "
'Lin(28) = Lin(28) & "de la diferencia resultante entre el valor del Precio Referencial de mercado  acordado en la respectiva "
'Lin(28) = Lin(28) & "Confirmación  vigente a la Fecha de Vencimiento  del  Contrato y el valor del precio pactado por las "
'Lin(28) = Lin(28) & "partes ambos multiplicados por el monto de Moneda Extranjera objeto de la respectiva transacción, cuando "
'Lin(28) = Lin(28) & "este sea superior a aquel."
'
'Lin(29) = "En el caso contrario, el Vendedor pagara dicha diferencia al Comprador."
'
'Lin(30) = "La compensación se efectuara siempre en pesos,  moneda corriente nacional,  mediante la entrega de vale "
'Lin(30) = Lin(30) & "vista bancario de la plaza,  o  deposito en la cuenta corriente en pesos,  que la parte correspondiente "
'Lin(30) = Lin(30) & "hubiere designado para tal efecto en la respectiva Confirmación."
'
'Lin(31) = "^d.2) Comprador:^ Aquella parte  que se obliga  a  pagar a la otra el precio convenido en pesos,  moneda "
'Lin(31) = Lin(31) & "corriente nacional, o en Unidades de Fomento por su equivalente en pesos, moneda corriente nacional, en "
'Lin(31) = Lin(31) & "la Fecha de Vencimiento del contrato."
'
'Lin(32) = "Para la aplicación de las disposiciones de la presente letra,  en las transacciones de  Permuta (Swaps) "
'Lin(32) = Lin(32) & "de Moneda Extranjera  a  futuro,  se entenderá por Vendedor a aquella parte que se obliga a entregar la "
'Lin(32) = Lin(32) & "Moneda Extranjera, y por Comprador,  a  aquella parte que se obliga a entregar pesos,  moneda corriente "
'Lin(32) = Lin(32) & "nacional, o Unidades de Fomento. "
'
'Lin(33) = "^e) Fecha de Vencimiento de la Transacción:^ La  fecha   que  las  partes  convienen  en  la  respectiva "
'Lin(33) = Lin(33) & "Confirmación y en la cual deben cumplir sus respectivas obligaciones de Entrega o de Compensación de la "
'Lin(33) = Lin(33) & "Moneda Extranjera vendida y pago del precio correspondiente. "
'
'Lin(34) = "^f) Dólar:^ Es la moneda de curso legal en los Estados Unidos de América."
'
'Lin(35) = "^g) Moneda Extranjera:^ Es la divisa cuya CompraVenta, Arbitraje (Forward)  o  Permuta (Swaps) es objeto "
'Lin(35) = Lin(35) & "de la respectiva transacción pactada en cada Confirmación, distinta del Dólar. "
'
'Lin(36) = "^h) Precio Referencial de Mercado:^ Es aquel que las partes convienen en cada Confirmación,  vigente a la "
'Lin(36) = Lin(36) & "Fecha de Vencimiento de la respectiva transacción, que se aplicara al monto de Moneda Extranjera objeto "
'Lin(36) = Lin(36) & "de dicha transacción, con el fin de expresar su valor en pesos moneda corriente nacional  y definir así "
'Lin(36) = Lin(36) & "el precio final pactado. Este Precio Referencial podrá corresponder al Dólar Acuerdo, Dólar Observado o "
'Lin(36) = Lin(36) & "o  al Dólar Interbancario,  todos los cuales se definen mas adelante,  según estipulen las partes en la "
'Lin(36) = Lin(36) & "respectiva Confirmación."
'
'Lin(37) = "^i) Cierre de Transacción:^ Instante  en el cual  ambas partes manifiestan su consentimiento y cierran a "
'Lin(37) = Lin(37) & "firme una determinada transacción de  CompraVenta,  Arbitraje o Permuta  de Moneda Extranjera a futuro, "
'Lin(37) = Lin(37) & "fijando las condiciones de la misma."
'
'Lin(38) = "El cierre de transacción podrá verificarse en una cualquiera de las siguientes formas: verbalmente; por "
'Lin(38) = Lin(38) & "vía  telefónica;  mediante  telex testeado;  o fax.  Sin  embargo,  cualquiera  sea  el  medio  de  los "
'Lin(38) = Lin(38) & "anteriormente  indicados  que se  utilice,  las  partes  deberán  firmar el original del 'Formulario de "
'Lin(38) = Lin(38) & "Confirmación ' correspondiente,  a mas tardar dentro de las 24 horas hábiles bancarias siguientes  a  la "
'Lin(38) = Lin(38) & "Fecha de Celebración de dicha transacción. "
'
'Lin(39) = "Para los efectos de la presente letra,  las partes aceptan y autorizan expresamente desde ya,  que  sus "
'Lin(39) = Lin(39) & "conversaciones y comunicaciones telefónicas,  sean grabadas por la contraparte,  grabaciones que podrán "
'Lin(39) = Lin(39) & "ser utilizadas como medio probatorio  en caso de controversia  a fin  de establecer la existencia de un "
'Lin(39) = Lin(39) & "cierre de Transacciones y/o las condiciones precisas de dicho cierre. "
'
'Lin(40) = "^j) Fecha de Celebración:^ Es la fecha en que las partes cierran una transacción determinada."
'
'Lin(41) = "^k) Dólar Acuerdo:^ Es la cantidad de pesos, moneda corriente nacional, necesarios para comprar un Dólar "
'Lin(41) = Lin(41) & "y  que fija  y determina  el Banco Central de Chile,  conforme al N° 7 del Capitulo I del Titulo I  del "
'Lin(41) = Lin(41) & "Compendio de Normas de Cambios Internacionales.     Si por cualquier causa el referido Dólar acuerdo no "
'Lin(41) = Lin(41) & "existiere en la Fecha de Vencimiento respectiva,  se aplicara en su defecto el Tipo de Cambio que a esa "
'Lin(41) = Lin(41) & "fecha se aplique  a  los Pagares emitidos en conformidad al Capitulo XIX  del  Titulo I  del  Compendio "
'Lin(41) = Lin(41) & "recién aludido,  de las series  PCDUS$A  o  PCDUS$B.    Si tampoco pudiere determinarse este ultimo por "
'Lin(41) = Lin(41) & "cualquier causa, se aplicara el Tipo de Cambio promedio informado en la Fecha de Vencimiento respectiva, "
'Lin(41) = Lin(41) & "por el Banco Central de Chile como aplicable a sus propias operaciones.      Si se informaren distintas "
'Lin(41) = Lin(41) & "cotizaciones para compra y venta, se aplicara el promedio aritmético entre ambas.  A falta de todos los "
'Lin(41) = Lin(41) & "anteriores,  se aplicara el  Tipo de Cambio  Dólar  Observado  existente  a  la  fecha  del  respectivo "
'Lin(41) = Lin(41) & "vencimiento."
'
'Lin(42) = "^l) Dólar Interbancario:^ Es la cantidad de pesos, moneda corriente nacional,  necesaria para comprar un "
'Lin(42) = Lin(42) & "Dólar,  según se informe en la pagina  CHLE  del  REUTERS, a las o alrededor de las 11:00 horas A.M. de "
'Lin(42) = Lin(42) & "Santiago de Chile, y que corresponde a aquel que utilizan los bancos comerciales autorizados para operar "
'Lin(42) = Lin(42) & "en Chile, para las compras y ventas de dólares que celebran entre ellos. "
'
'Lin(43) = "^m) Dólar Observado:^ Es la cantidad de  pesos,  moneda corriente nacional,  necesaria para  comprar  un "
'Lin(43) = Lin(43) & "Dólar, publicado por el Banco Central de Chile, en conformidad a lo dispuesto en el N° 6 del Capitulo I "
'Lin(43) = Lin(43) & "del Titulo I del Compendio de normas de Cambios Internacionales, en la Fecha de Vencimiento respectiva. "
'Lin(43) = Lin(43) & "Si por cualquier causa dejare de publicarse el  Dólar Observado en la Fecha de Vencimiento  respectiva, "
'Lin(43) = Lin(43) & "se  aplicara  el  Tipo de Cambio  promedio  informado en dicha  fecha por el  Banco  Central  de  Chile "
'Lin(43) = Lin(43) & "como aplicable  a las operaciones bancarias  de compra y venta de  Dólares,  realizadas por los  bancos "
'Lin(43) = Lin(43) & "autorizados para operar en el mercado chileno. Si se informaren distintas cotizaciones para la compra y "
'Lin(43) = Lin(43) & "venta, se aplicara el promedio aritmético entre ambas.    Si tampoco se informare el tipo Cambio recién "
'Lin(43) = Lin(43) & "referido,  se aplicara en su defecto el  Tipo de Cambio promedio  informado por Citicorp-Chile y que se "
'Lin(43) = Lin(43) & "publique en el diario El Mercurio de Santiago en la fecha inmediatamente anterior a la respectiva Fecha "
'Lin(43) = Lin(43) & "de Vencimiento. "
'
'Lin(44) = "A falta de todos los anteriores, se aplicara el promedio aritmético entre el precio del Dólar comprador "
'Lin(44) = Lin(44) & "y  vendedor ofrecidos a publico en la respectiva Fecha de Vencimiento,  por las oficinas principales de "
'Lin(44) = Lin(44) & "los bancos y @BANCO y sus sucursales en Chile "
'
'Lin(45) = "^n) Tipo de Cambio:^ Es la cantidad de pesos, moneda corriente nacional, necesaria para adquirir un Dólar "
'Lin(45) = Lin(45) & "de los Estados Unidos de América. "
'
'Lin(46) = "^ñ) Paridad de la moneda extranjera o Paridad:^ Es la  cantidad  de  Moneda  Extranjera  necesaria  para "
'Lin(46) = Lin(46) & "comprar un Dólar. "
'
'Lin(47) = "^o) Precio Referencial de Paridad:^ Es aquel que en la respectiva  Fecha de Vencimiento  corresponda  al "
'Lin(47) = Lin(47) & "precio Spot de la Moneda Extranjera de que se trate, por un Dólar o viceversa,  según la cotización que "
'Lin(47) = Lin(47) & "se informe en la pagina WRLD de REUTERS a las o alrededor de las 11:00 horas A.M. de Santiago de Chile. "
'
'Lin(48) = "Precio Spot: Se entiende por tal el  precio contado  de mercado que tiene una Moneda Extranjera  o  el "
'Lin(48) = Lin(48) & "Dólar en la respectiva Fecha de Vencimiento, a la Paridad o Tipo de Cambio, según corresponda."
'
'Lin(49) = "^CUARTO:^ Causales de Terminación Anticipada : La verificación  en cualquier tiempo durante  la vigencia "
'Lin(49) = Lin(49) & "de este contrato,  de uno cualquiera de los hechos que se indican a continuación,  facultara a la parte "
'Lin(49) = Lin(49) & "afectada para exigir la terminación anticipada de una, varias o todas las transacciones de Compraventa, "
'Lin(49) = Lin(49) & "Arbitraje (Forward) y/o Permuta(Swap), de Moneda Extranjera a futuro, vigentes entre ellas y pendientes "
'Lin(49) = Lin(49) & "de vencimiento:"
'
'Lin(50) = "^a)^ La falta de cumplimiento integro y oportuno de una cualquiera de las obligaciones que le impongan  y "
'Lin(50) = Lin(50) & "a que resulte obligada sea por estas Condiciones Generales y/o por la o las respectivas Confirmaciones; "
'
'Lin(51) = "^b)^ Si se declarare la quiebra o liquidación  y/o  se decretare por autoridad competente la intervención "
'Lin(51) = Lin(51) & "de una de las partes contratantes; si se presentaren proposiciones de convenio extrajudicial o judicial "
'Lin(51) = Lin(51) & "preventivo a sus o por sus acreedores;  si cayere en cesación de pagos u ocurriese cualquier otro hecho "
'Lin(51) = Lin(51) & "que comprometa seriamente su solvencia; "
'
'Lin(52) = "^c)^ Si una de las partes se disuelve y/o entra en proceso de liquidación;"
'
'Lin(53) = "^d)^ Si una de las partes transfiere la totalidad  o  parte importante de sus  bienes necesarios  para el "
'Lin(53) = Lin(53) & "desarrollo de su giro, sin previo consentimiento escrito de la contraparte; "
'
'Lin(54) = "^e)^ Si una de las partes dejare de cumplir el tiempo  y forma una cualquiera de sus obligaciones de pago "
'Lin(54) = Lin(54) & "para con la otra y/o se produjere la exigibilidad anticipada de la misma sea de acuerdo a la ley y/o de "
'Lin(54) = Lin(54) & "acuerdo a las estipulaciones de los documentos en que estuviere expresada. "
'
'Lin(55) = "Respecto de 'El Banco',  esta causal se  verificara  también cuando dicho  incumplimiento  y/o  exigibilidad "
'Lin(55) = Lin(55) & "anticipada se produzca en relación a cualquiera "
'Lin(55) = Lin(55) & "de sus subsidiarias con domicilio en Chile o el extranjero,  especialmente cualquier agencia o sucursal "
'Lin(55) = Lin(55) & "de @BANCO"
'
'Lin(56) = "En el evento de que proceda la terminación anticipada de acuerdo a lo estipulado en esta cláusula,  las "
'Lin(56) = Lin(56) & "transacciones pendientes se liquidaran de inmediato anticipando en consecuencia  la Fecha de Vencimiento "
'Lin(56) = Lin(56) & "originalmente pactada, en base a los precios, Paridades o  Tipos de Cambio Referenciales  acordados  en "
'Lin(56) = Lin(56) & "las respectivas Confirmaciones y que estén vigentes a la fecha de dicha liquidación."
'
'Lin(57) = "Siempre y en todo caso,  la parte afectada, tendrá y mantendrá el derecho de ser plenamente indemnizada "
'Lin(57) = Lin(57) & "por  la  contratare  de toda perdida  o  perjuicio  que  sufriere  a  consecuencia  de la  terminación "
'Lin(57) = Lin(57) & "anticipada,  lo que se determinara una vez  que se verifique  la  Fecha  de  Vencimiento  originalmente "
'Lin(57) = Lin(57) & "pactada para la respectiva Confirmación. "
'
'Lin(58) = "En el evento de que a la  Fecha de Vencimiento  originalmente  pactada  en la  respectiva  Confirmación "
'Lin(58) = Lin(58) & "resultaren diferencias en contra de la parte afectada, esta no será obligada a pago ni devolución alguna "
'Lin(58) = Lin(58) & "a la  contraparte,  reteniendo  íntegramente  dicho beneficio para si a  titulo de pena,  la  que  será "
'Lin(58) = Lin(58) & "compatible y exigible conjuntamente con cualquiera otra indemnización que fuere procedente,  de acuerdo "
'Lin(58) = Lin(58) & "al presente contrato o la ley, en conformidad al articulo 1.537 del Código Civil."
'
'Lin(59) = "Se deja expresa constancia que la aplicación de la  terminación anticipada de que se  trata esta letra, "
'Lin(59) = Lin(59) & "son  facultativas  para  la  parte  afectada  y  establecidas  en su  exclusivo beneficio,  pudiendo en "
'Lin(59) = Lin(59) & "consecuencia a su absoluto y exclusivo arbitrio,  ejercerlas  o  perseverar en la  o  las transacciones "
'Lin(59) = Lin(59) & "pendientes,  sin perjuicio  de su  derecho  de ser plenamente  indemnizada  de todo  daño,  menoscabo o "
'Lin(59) = Lin(59) & "perjuicio que sufriere."
'
'Lin(60) = "^QUINTO:^ Mora o simple retardo : En caso de mora o simple retardo por unas de las partes en cumplir con "
'Lin(60) = Lin(60) & "las  obligaciones  de  pago que le  imponen las  presentes  Condiciones  Generales  y  las  respectivas "
'Lin(60) = Lin(60) & "Confirmaciones, la parte incumplidora se obliga a pagar a la contraparte,  intereses penales calculados "
'Lin(60) = Lin(60) & "sobre el monto de la respectiva obligación,  en razón  de la tasa máxima permitida estipular por la ley "
'Lin(60) = Lin(60) & "para operaciones de crédito de dinero reajustables en moneda extranjera,  vigente durante el tiempo  de "
'Lin(60) = Lin(60) & "la mora o simple retardo y hasta el día de pago efectivo. "
'
'Lin(61) = "^SEXTO:^ Vigencia: El presente contrato sobre Condiciones Generales de Compraventa  a  futuro de Moneda "
'Lin(61) = Lin(61) & "Extranjera regirá a contar de esta fecha y tendrá duración indefinida."
'
'Lin(62) = "En consecuencia,  estas  Condiciones Generales  se aplicaran a todas las transacciones de  Compraventa, "
'Lin(62) = Lin(62) & "Arbitraje (Forwards) y/o Permuta (Swaps) de moneda Extranjera  a Futuro que celebren las partes,  salvo "
'Lin(62) = Lin(62) & "que en la respectiva transacción las partes dispongan expresamente otra cosa."
'
'Lin(63) = "Sin perjuicio de lo anterior,  cualquiera de las partes podrá poner termino a este contrato avisando  a "
'Lin(63) = Lin(63) & "la otra por escrito con a lo menos 30 días hábiles bancarios de anticipación. En todo caso, dicho aviso "
'Lin(63) = Lin(63) & "no afectara a las transacciones ya efectuadas  y  pendientes de vencimiento,  a  las  cuales  le  serán "
'Lin(63) = Lin(63) & "plenamente aplicables estas Condiciones Generales,  en cuanto las partes no hubieren dispuesto de común "
'Lin(63) = Lin(63) & "acuerdo otra cosa."
'
'Lin(64) = "^SEPTIMO:^ Transferibilidad: Los derechos  y  obligaciones que emanan para las partes de las  presentes "
'Lin(64) = Lin(64) & "Condiciones Generales,  así como de las Confirmaciones que celebren a su amparo,  no  son  cesibles  ni "
'Lin(64) = Lin(64) & "transferibles a terceros, ni por endoso ni en ninguna otra forma. "
'
'Lin(65) = "No obstante lo anterior,  una o ambas partes podrán ceder sus derechos  y  obligaciones emanados de las "
'Lin(65) = Lin(65) & "presentes Condiciones Generales y respecto de una o más de las Confirmaciones vigentes entre ellas,  de "
'Lin(65) = Lin(65) & "común acuerdo manifestado en forma expresa por escrito en los dos ejemplares de la o las Confirmaciones "
'Lin(65) = Lin(65) & "respectivas y en dos copias de estas Condiciones Generales, debidamente firmada."
'
'Lin(66) = "^OCTAVO:^ Pago Con Documentos: Se deja  expresa constancia que los pagos efectuados con documentos,  no "
'Lin(66) = Lin(66) & "causaran novación de las obligaciones, si dichos documentos no fueren pagados al presentarlos a cobro."
'
'Lin(67) = "^NOVENO:^ Arbitraje: Cualquier duda, controversia o disputa que surgiere entre las partes con motivo de "
'Lin(67) = Lin(67) & "la vigencia,  validez,  aplicación  o  interpretación del  presente contrato  y/o  de  las  respectivas "
'Lin(67) = Lin(67) & "Confirmaciones amparadas bajo el mismo, serán conocidas y resueltas sin ulterior recurso por un arbitro "
'Lin(67) = Lin(67) & "arbitrador, el cual conocerá de acuerdo al procedimiento que dicho arbitro establezca y fallara conforme "
'Lin(67) = Lin(67) & "a lo que su prudencia y equidad determinen."
'
'Lin(68) = "Para tal efecto,  las partes designan en este acto a don @ARBITRO1  y  si este no pudiese por "
'Lin(68) = Lin(68) & "cualquier causa o no quisiese desempeñar el cargo o se imposibilitase durante su cometido,  las  partes "
'Lin(68) = Lin(68) & "designan en su reemplazo a don @ARBITRO2. "
'Lin(68) = Lin(68) & "Si este ultimo por cualquier causa no pudiese o no aceptare desempeñar el encargo  o  se imposibilitare "
'Lin(68) = Lin(68) & "durante su cometido, el arbitro será designado de común acuerdo por las partes. "
'
'Lin(69) = "A falta  de  dicho  acuerdo,  el arbitro será designado por los tribunales ordinarios de justicia de la "
'Lin(69) = Lin(69) & "ciudad y comuna de Santiago, debiendo conocer y fallar conforme a Derecho.    Dicho nombramiento deberá "
'Lin(69) = Lin(69) & "recaer en un  ex ministro  de  Corte de Apelaciones,  Corte Suprema,  o actual ex abogado integrante de "
'Lin(69) = Lin(69) & "alguno de dichos tribunales. "
'
'Lin(70) = "El presente documento se firma en dos ejemplares de idéntico tenor  y  data,  quedando uno en poder  de "
'Lin(70) = Lin(70) & "cada parte."
'
'Lin(71) = "                     ---------------------------                 ----------------------------- "
'Lin(72) = "                                @BANCO                                      @CLIENTE"
'
'
'
'Lin(4) = BacRemplazar(Lin(4), "@BANCO", DatCont(1))
'Lin(6) = BacRemplazar(Lin(6), "@CLIENTE", DatCont(8))
'
'Lin(7) = BacRemplazar(Lin(7), "@CIUDAD", DatCont(16))
'Lin(7) = BacRemplazar(Lin(7), "@FECHACIERRE", DatCont(15))
'Lin(7) = BacRemplazar(Lin(7), "@BANCO", DatCont(1))
'Lin(7) = BacRemplazar(Lin(7), "@SUCURSAL", "Sucursal en Chile")
'Lin(7) = BacRemplazar(Lin(7), "@REPBANCO1", DatCont(3))
'Lin(7) = BacRemplazar(Lin(7), "@RUTREPBCO1", DatCont(4))
'Lin(7) = BacRemplazar(Lin(7), "@REPBANCO2", DatCont(5))
'Lin(7) = BacRemplazar(Lin(7), "@RUTREPBCO2", DatCont(6))
'Lin(7) = BacRemplazar(Lin(7), "@DIRBANCO", DatCont(7))
'Lin(7) = BacRemplazar(Lin(7), "@NOMBRECLIENTE", DatCont(8))
'Lin(7) = BacRemplazar(Lin(7), "@REPCLIENTE1", DatCont(10))
'Lin(7) = BacRemplazar(Lin(7), "@RUTREPCLI1", DatCont(11))
'Lin(7) = BacRemplazar(Lin(7), "@REPCLIENTE2", DatCont(12))
'Lin(7) = BacRemplazar(Lin(7), "@RUTREPCLI2", DatCont(13))
'Lin(7) = BacRemplazar(Lin(7), "@DIRCLIENTE", DatCont(14))
'Lin(55) = BacRemplazar(Lin(55), "@BANCO", DatCont(1))
'Lin(68) = BacRemplazar(Lin(68), "@ARBITRO1", DatCont(3))
'Lin(68) = BacRemplazar(Lin(68), "@ARBITRO2", DatCont(10))
'Lin(72) = BacRemplazar(Lin(72), "@BANCO", DatCont(1))
'Lin(72) = BacRemplazar(Lin(72), "@CLIENTE", DatCont(8))
'
'
'Lin(4) = BacFormatearTexto(Lin(4), 3, 0, 0, 0, 88)
'Lin(6) = BacFormatearTexto(Lin(6), 3, 0, 0, 0, 88)
'
' nTab = 8
' nFila = 2
' BacGlbSetPrinter 65, 80, 1, 1
' 'BacGlbSetFont CourierNew, 10, True
'Printer.FontBold = True
' For i = 1 To 6
'    nFila = nFila + 1
'    BacGlbPrinter nFila, 1, nTab, 1, Lin(i), 0, 1
'
' Next
'
'nTab = 12
'
'nFila = nFila + 1
'BacGlbPrinter nFila, 1, nTab, 1, Lin(0), 0, 1
'Printer.FontBold = False
''BacGlbSetFont CourierNew, 10, False
'
'For i = 7 To 70
'    nFila = nFila + 1
'    BacGlbPrinter nFila, 1, nTab, 1, Lin(0), 0, 1
'
'    BacCentraTexto aString(), Lin(i), 80
'
'    For nCont = 1 To UBound(aString())
'
'        nFila = nFila + 1
'
'        If nFila = 65 Then
'            nFila = 4
'            Printer.NewPage
'        End If
'        sTexto = aString(nCont)
'        For nCont2 = 1 To Len(sTexto)
'            cCaracter = Mid(sTexto, nCont2, 1)
'
'            If cCaracter = "^" Then
'                Printer.FontBold = IIf(Printer.FontBold = False, True, False)
'                cCaracter = " "
'            End If
'
'            BacGlbPrinter nFila, 1, nTab - 1 + nCont2, 1, cCaracter, 0, 1
'        Next
'    Next
'Next
'
'nFila = nFila + 1
'BacGlbPrinter nFila, 1, nTab, 1, Lin(0), 0, 1
'nFila = nFila + 1
'BacGlbPrinter nFila, 1, nTab, 1, Lin(0), 0, 1
'nFila = nFila + 1
'BacGlbPrinter nFila, 1, nTab, 1, Lin(0), 0, 1
'nFila = nFila + 1
'BacGlbPrinter nFila, 1, nTab, 1, Lin(0), 0, 1
'nFila = nFila + 1
'BacGlbPrinter nFila, 1, nTab, 1, Lin(71), 0, 1
'nFila = nFila + 1
'BacGlbPrinter nFila, 1, nTab, 1, Lin(72), 0, 1
'
'Printer.NewPage
'BacGlbPrinterEnd
'
'End Function
'
