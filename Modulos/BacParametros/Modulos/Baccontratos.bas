Attribute VB_Name = "BACContratos"
Public Function BacContratoInterbancario(nNumOpe As Long) As Boolean
   Dim Sql       As String
   Dim datos()
   Dim Lin(80)
   Dim nPosicion As Integer
   Dim nFila     As Integer
   Dim nTab      As Integer
   Dim aString()
   Dim nCont     As Integer
   Dim sTexto    As String
   Dim nCont2    As Integer
   Dim cCaracter As String

   'Recuperaci�n de los datos de la operaci�n
''''''''''''''''   Sql = "EXECUTE sp_contratointerbancario " & nNumOpe & ","
''''''''''''''''   Sql = Sql & Bac_Apoderados.Txt_Rut1 & ","
''''''''''''''''   Sql = Sql & Bac_Apoderados.Txt_Rut2

   Envia = Array()
   
   AddParam Envia, CDbl(nNumOpe)
   AddParam Envia, CDbl(Bac_Apoderados.Txt_Rut1)
   AddParam Envia, CDbl(Bac_Apoderados.Txt_Rut2)
   

   If Not Bac_Sql_Execute("SP_CONTRATOINTERBANCARIO", Envia) Then
      
      MsgBox "Problemas al leer datos del contrato interbancario", vbCritical, TITSISTEMA
      Exit Function
   
   End If
   
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
   Lin(10) = Lin(10) + "en esta ciudad calle^@DIRBANCO^, tel�fono^@TELBANCO^, fax^@FAXBANCO^, por una parte, y por la "
   Lin(10) = Lin(10) + "otra^@CONTRAPARTE^, RUT^@RUTCONTRAPARTE^, debidamente representado "
   Lin(10) = Lin(10) + "por la(s) persona(s) que suscribe(n) al final, todos domiciliados en esta ciudad, "
   Lin(10) = Lin(10) + "calle^@DIRCONTRAPARTE^, telefono^@TELCONTRAPARTE^, fax^@FAXCONTRAPARTE^, se ha convenido y cerrado a "
   Lin(10) = Lin(10) + "firme una transacci�n forward y/o swap de las monedas que m�s adelante se indican y en los t�rminos que a "
   Lin(10) = Lin(10) + "continuaci�n se expresan, amparada y regida por las normas del Capitulo VII del Titulo I del Compendio de Normas de "
   Lin(10) = Lin(10) + "Cambios Internacionales del Banco Central de Chile y del Capitulo 13-2 de la Recopilaci�n actualizada de Normas de la "
   Lin(10) = Lin(10) + "Superintendencia de Bancos e Instituciones Financieras, y por el Protocolo de Definiciones Utilizadas en Contrato de "
   Lin(10) = Lin(10) + "Forwards y/o Swaps de Monedas en el Mercado Local de la Asociaci�n de Bancos, vigente a la fecha de cierre del contrato, "
   Lin(10) = Lin(10) + "que las partes declaran conocer :"
      
   Lin(11) = " "
   Lin(12) = "1.  Vendedor                                              : @VENDEDOR"
   Lin(13) = "2.  Comprador                                             : @COMPRADOR"
   Lin(14) = "3.  Tipo de Transacci�n                                   : FORWARD"
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
   
   Lin(30) = "En el caso de cumplimiento por compensaci�n, a la fecha de vencimiento pactada se establecer�la cuant�a de las "
   Lin(30) = Lin(30) + "obligaciones contra�das por ambas partes, compens�ndose dichas obligaciones, y extinguiendose� �stas hasta por el monto de "
   Lin(30) = Lin(30) + "la menor de ellas. La diferencia que resulte de esta compensaci�n y liquidaci�n deber� ser pagada por la parte deudora a la "
   Lin(30) = Lin(30) + "parte acreedora, en pesos moneda nacional, al contado, en el domicilio de esta �ltima. Para el caso en que ambas monedas "
   Lin(30) = Lin(30) + "sean monedas extranjeras esta diferencia deber� pagarse en d�lares de los Estados Unidos de Am�rica. "
   Lin(30) = Lin(30) + "Las partes de com�n acuerdo podr�n anticipar la fecha de liquidaci�n del contrato. Ni el presente contrato, ni los "
   Lin(30) = Lin(30) + "derechos que de �l emanan podr�n endosarse o transferirse, sin  consentimiento escrito  de  ambas  partes, del que deber� "
   Lin(30) = Lin(30) + "dejarse constancia en los dos ejemplares que se firman en el mismo."
   Lin(30) = Lin(30) + "Si cualquiera de las partes no cumple las obligaciones contra�das en este contrato, operar� autom�tica  y obligatoriamente "
   Lin(30) = Lin(30) + "el mecanismo de compensaci�n estipulado anteriormente. Si la parte deudora no pagare a la parte acreedora la diferencia que "
   Lin(30) = Lin(30) + "arrojare a favor de esta �ltima la aludida compensaci�n, el monto adeudado devengar�, a partir de la mora y hasta la fecha de "
   Lin(30) = Lin(30) + "pago efectivo, la tasa de inter�s m�ximo convencional que la ley permite estipular para la moneda adecuada, sin perjuicio del "
   Lin(30) = Lin(30) + "derecho de la parte acreedora para exigir el cumplimiento forzado de la obligaci�n."
   
   Lin(31) = " "
   Lin(32) = " "
   Lin(33) = " "
   Lin(34) = " "
   Lin(35) = "           ------------------------------                    ------------------------------"
   Lin(36) = "                     P. Vendedor                                       P. Comprador"
   Lin(37) = " "
   Lin(38) = "Nombre: @APOVEN1              RUT: @RUTAPOVEN1      Nombre: @APOCOM1              RUT: @RUTAPOCOM1  "
   Lin(39) = "Nombre: @APOVEN2              RUT: @RUTAPOVEN2      Nombre: @APOCOM2              RUT: @RUTAPOCOM2  "
   
   Do While MISQL.SQL_Fetch(datos()) = 0
      Lin(1) = BacRemplazar(Lin(1), "@BANCO", datos(1))
      Lin(4) = BacRemplazar(Lin(4), "@RUTBANCO", BacFormatoRut(datos(4)))
      Lin(8) = BacRemplazar(Lin(8), "@NUMOPE", BacFormatoMonto(Val(datos(2)), 0))

      Lin(10) = BacRemplazar(Lin(10), "@FECHAINICIO", BacFormatoFecha("DDMMAA", datos(3)))
      Lin(10) = BacRemplazar(Lin(10), "@BANCO", datos(1))
      Lin(10) = BacRemplazar(Lin(10), "@RUTBANCO", BacFormatoRut(datos(4)))
      Lin(10) = BacRemplazar(Lin(10), "@DIRBANCO", datos(5))
      Lin(10) = BacRemplazar(Lin(10), "@TELBANCO", datos(6))
      Lin(10) = BacRemplazar(Lin(10), "@FAXBANCO", datos(7))
      Lin(10) = BacRemplazar(Lin(10), "@CONTRAPARTE", datos(8))
      Lin(10) = BacRemplazar(Lin(10), "@RUTCONTRAPARTE", BacFormatoRut(datos(9)))
      Lin(10) = BacRemplazar(Lin(10), "@DIRCONTRAPARTE", datos(10))
      Lin(10) = BacRemplazar(Lin(10), "@TELCONTRAPARTE", datos(11))
      Lin(10) = BacRemplazar(Lin(10), "@FAXCONTRAPARTE", datos(12))
      
      Lin(12) = BacRemplazar(Lin(12), "@VENDEDOR", IIf(datos(13) = "C", datos(8), datos(1)))
      Lin(13) = BacRemplazar(Lin(13), "@COMPRADOR", IIf(datos(13) = "V", datos(8), datos(1)))
      Lin(15) = BacRemplazar(Lin(15), "@FECINI", datos(3))
      Lin(17) = BacRemplazar(Lin(17), "@FECVEN", datos(14))
      Lin(18) = BacRemplazar(Lin(18), "@MODALIDAD", datos(15))
      Lin(19) = BacRemplazar(Lin(19), "@CODMON", datos(16))
      Lin(19) = BacRemplazar(Lin(19), "@MTOMEX", BacFormatoMonto(CDbl(datos(17)), 2))
      Lin(20) = BacRemplazar(Lin(20), "@MONESCMTOMEX", BacMonto_Escrito(Val(datos(17))) & " " & BacGlosaMon(datos(16), True, datos(29), datos(30)))
      Lin(21) = BacRemplazar(Lin(21), "@TIPCAM", IIf(Val(datos(19)) = 1, BacGlosaPrecioFuturo(datos(20), datos(16), datos(21), datos(31)), "N/A"))
      Lin(22) = BacRemplazar(Lin(22), "@PARFWD", IIf(Val(datos(19)) = 2, BacGlosaPrecioFuturo(datos(20), datos(16), datos(21), datos(31)), "N/A"))
      Lin(23) = BacRemplazar(Lin(23), "@CODCNV", IIf(datos(21) = "CLP", "$", datos(21)))
      Lin(23) = BacRemplazar(Lin(23), "@MTOFIN", BacFormatoMonto(Val(datos(22)), IIf(datos(21) = "CLP", 0, IIf(datos(21) = "UF", 4, 2))))
      Lin(24) = BacRemplazar(Lin(24), "@MONESCMTOFIN", BacMonto_Escrito(Val(datos(22))) & " " & BacGlosaMon(datos(21), False, datos(29), datos(30)))
      Lin(25) = BacRemplazar(Lin(25), "@TCREFERENCIA", datos(24))
      
      Lin(38) = BacRemplazarII(Lin(38), "RUT:", "@APOVEN1", IIf(datos(13) = "V" And datos(25) <> "", Trim(datos(25)), String(20, ".")))
      Lin(38) = BacRemplazarII(Lin(38), "Nombre:", "@RUTAPOVEN1", IIf(datos(13) = "V" And Mid(Trim(datos(26)), 1, 1) <> "0", BacFormatoRut(Trim(datos(26))), String(13, ".")))
      Lin(38) = BacRemplazarII(Lin(38), "RUT:", "@APOCOM1", IIf(datos(13) = "C" And datos(25) <> "", Trim(datos(25)), String(20, ".")))
      Lin(38) = BacRemplazar(Lin(38), "@RUTAPOCOM1", IIf(datos(13) = "C" And Mid(Trim(datos(26)), 1, 1) <> "0", BacFormatoRut(Trim(datos(26))), String(13, ".")))
      
      Lin(39) = BacRemplazarII(Lin(39), "RUT:", "@APOVEN2", IIf(datos(13) = "V" And datos(27) <> "", Trim(datos(27)), String(20, ".")))
      Lin(39) = BacRemplazarII(Lin(39), "Nombre:", "@RUTAPOVEN2", IIf(datos(13) = "V" And Mid(Trim(datos(28)), 1, 1) <> "0", BacFormatoRut(Trim(datos(28))), String(13, ".")))
      Lin(39) = BacRemplazarII(Lin(39), "RUT:", "@APOCOM2", IIf(datos(13) = "C" And datos(27) <> "", Trim(datos(27)), String(20, ".")))
      Lin(39) = BacRemplazar(Lin(39), "@RUTAPOCOM2", IIf(datos(13) = "C" And Mid(Trim(datos(28)), 1, 1) <> "0", BacFormatoRut(Trim(datos(28))), String(13, ".")))
      
   Loop
  
   nTab = 8
   nFila = 3
   
   BacGlbSetPrinter 65, 120, 1, 1
   BacGlbSetFont CourierNew, 8, True
   
   BacGlbPrinter nFila, 1, nTab, 1, Lin(1), 0, 1
   
   nFila = nFila + 1
   BacGlbPrinter nFila, 1, nTab, 1, Lin(2), 0, 1
   
   nFila = nFila + 1
   BacGlbPrinter nFila, 1, nTab, 1, Lin(3), 0, 1
   
   nFila = nFila + 1
   BacGlbPrinter nFila, 1, nTab, 1, Lin(4), 0, 1
   
   BacGlbSetFont CourierNew, 8, False

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

    MsgBox "Problemas para Generar Protocolo de Contrato!. Referido a n�mero " & BACSwap.Crystal.Err.Number & ". " & vbcrl _
    & "Descripci�n: " & BACSwap.Crystal.LastErrorString, vbCritical, TITSISTEMA

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

Lin(0) = " "
Lin(1) = "PROTOCOLO DE DEFINICIONES UTILIZADAS EN CONTRATO DE FORWARD Y/O SWAP DE MONEDAS"
Lin(2) = "EN EL MERCADO LOCAL"

Lin(3) = "El presente documento contiene las definiciones de los t�rminos empleados en el  Contrato de Forward y/o Swap de "
Lin(3) = Lin(3) & "de Monedas en el Mercado Local, en adelante 'el contrato'. "

Lin(4) = "^1.       Vendedor:^ En el caso de transacciones forward o swap de d�lares de los  Estados  Unidos  de  Am�rica  ( en "
Lin(4) = Lin(4) & "adelante, EEUU )  versus  moneda  nacional,  ya sea  pesos moneda nacional o Unidades de Fomento pagaderas en pesos "
Lin(4) = Lin(4) & "moneda nacional, el vendedor es la parte que se obliga a vender o entregar los d�lares de los EEUU.   En el caso de "
Lin(4) = Lin(4) & "transacciones forward o swap de d�lares de los  EEUU  versus una moneda extranjera distinta del d�lar  de los EEUU, "
Lin(4) = Lin(4) & "el vendedor es la parte que se obliga a vender o entregar la moneda extranjera distinta del d�lar de los EEUU. "

Lin(5) = "^2.       Comprador:^ En el caso de transacciones forward o swap de d�lares de los EEUU versus moneda nacional, ya sea "
Lin(5) = Lin(5) & "pesos moneda nacional  o  Unidades de Fomento pagaderas  en pesos moneda nacional,  el comprador es la parte que se "
Lin(5) = Lin(5) & "obliga a comprar o recibir los d�lares de los EEUU.    En el caso de transacciones forward o swap de d�lares de los "
Lin(5) = Lin(5) & "EEUU versus una moneda extranjera distinta de d�lar de los EEUU, el comprador es la parte que se obliga  a  comprar "
Lin(5) = Lin(5) & "o recibir la moneda extranjera distinta del d�lar de los EEUU. "

Lin(6) = "^3.       Tipo de Transacci�n:^ Los tipos de transacci�n amparados por el contrato son los Forward de Monedas  y  los "
Lin(6) = Lin(6) & "Swap de Monedas, seg�n lo definido en el N� 2 del Capitulo VII  del  Compendio de Normas de  Cambios Internacionales "
Lin(6) = Lin(6) & "del Banco Central de Chile, en adelante, el Capitulo VII. "

Lin(7) = "^4.       Fecha de Cierre:^ Es la fecha en que las partes convienen y cierran a firme una transacci�n  de  forward  o "
Lin(7) = Lin(7) & "swap, fijando las condiciones de la misma. "

Lin(8) = "^5.       Hora de Cierre:^ Es la hora que las partes convienen los t�rminos de la transacci�n. "

Lin(9) = "^6.       Fecha de Vencimiento:^ Se llama Fecha de Vencimiento o Fecha de Liquidaci�n y Compensaci�n,  aquella  fecha "
Lin(9) = Lin(9) & "�nica para cada contrato, en que se debe producir la entrega de la moneda extranjera  o  en que se debe producir la "
Lin(9) = Lin(9) & "compensaci�n entre ambas obligaciones, seg�n la forma de cumplimiento estipulada en el contrato.   En el evento que "
Lin(9) = Lin(9) & "la citada fecha correspondiera a un d�a que no es d�a h�bil  bancario  en  la  ciudad  de  Santiago,  la  Fecha  de "
Lin(9) = Lin(9) & "Vencimiento o Fecha de Liquidaci�n y Compensaci�n se postergara hasta el siguiente d�a h�bil bancario. "

Lin(10) = "^7.       Mecanismo de Cumplimiento:^ El mecanismo de cumplimiento  del  contrato podr� ser la  entrega f�sica  o  la "
Lin(10) = Lin(10) & "compensaci�n seg�n se define en el N� 3 del Capitulo VII.  En caso que el mecanismo sea la  compensaci�n,  para los "
Lin(10) = Lin(10) & "forward  o  swap de d�lares de los  EEUU  versus moneda nacional se entiende  por  Precio Referencial de Mercado la "
Lin(10) = Lin(10) & "cantidad de pesos resultante de multiplicar el Tipo de Cambio de Referencia estipulado en el contrato, vigente a la "
Lin(10) = Lin(10) & "fecha de vencimiento de este, por el monto de d�lares de los EEUU objeto del contrato. Para los forward  o  swap de "
Lin(10) = Lin(10) & "d�lares de los EEUU versus una moneda extranjera distinta de d�lar de los EEUU, se entiende por  Precio Referencial "
Lin(10) = Lin(10) & "de Mercado la cantidad de d�lares de los EEUU, seg�n la Paridad de Referencia estipulada en el contrato, vigente  a "
Lin(10) = Lin(10) & "la fecha de vencimiento de este. "

Lin(11) = "^8.       Cantidad de moneda Vendida:^ Es el monto de moneda que se compromete a vender o entregar el vendedor en  la "
Lin(11) = Lin(11) & "fecha de vencimiento. "

Lin(12) = "^9.       Tipo de Cambio Forward Pactado:^ Es la cantidad de pesos moneda nacional o unidades de fomento,  estipulada "
Lin(12) = Lin(12) & "por las partes en el contrato, necesaria para comprar una unidad de moneda extranjera en la Fecha de Vencimiento. "
Lin(12) = Lin(12) & "El tipo de cambio en pesos moneda nacional por d�lar de los EEUU se expresara con 2 decimales. El tipo de cambio en "
Lin(12) = Lin(12) & "Unidades de Fomento por d�lar de los EEUU se expresara con 10 decimales. "

Lin(13) = "^10.      Paridad de Forward Pactada:^ Es la cantidad de moneda extranjera distinta del d�lar de los EEUU, estipulada "
Lin(13) = Lin(13) & "por las partes en el contrato, necesaria para comprar un d�lar de los EEUU en la Fecha de Vencimiento.   La paridad "
Lin(13) = Lin(13) & "en unidades de moneda extranjera por d�lar de los EEUU se expresara con 4 decimales. "

Lin(14) = "^11.      Valor Forward Pactado:^ Es el monto de moneda que se compromete a pagar o entregar el comprador en la fecha "
Lin(14) = Lin(14) & "de vencimiento. Para los Forward o swap de d�lares de los  EEUU  versus moneda nacional el Valor Forward Pactado se "
Lin(14) = Lin(14) & "expresara en pesos moneda nacional o en Unidades de Fomento, seg�n corresponda.  Para los Forward o Swap de D�lares "
Lin(14) = Lin(14) & "de los EEUU  versus una moneda extranjera distinta del d�lar de los EEUU,  el Valor Forward Pactado se expresara en "
Lin(14) = Lin(14) & "d�lares de los EEUU. "

Lin(15) = "^12.      Tipo de Cambio de Referencia:^ Se entiende el Tipo de Cambio Observado, o el Tipo de Cambio Acuerdo,  o  el "
Lin(15) = Lin(15) & "Tipo de Cambio REUTERS, o cualquier otra referencia, estipulada por las partes en el contrato. "

Lin(16) = "^13.      Paridad de Referencia:^ Se entiende la Paridad Banco Central de Chile,  o la Paridad REUTERS,  o  cualquier "
Lin(16) = Lin(16) & "otra referencia, estipulada por las partes en el contrato. "

Lin(17) = "^14.      Otras Condiciones:^ Espacio reservado en el contrato para precisar o definir condiciones no establecidas en "
Lin(17) = Lin(17) & " el mismo. "

Lin(18) = "^15.      Otras Definiciones:^ Para todos los efectos, se aplicaran las siguientes definiciones: "

Lin(19) = "^a)^ Por Unidad de Fomento se entiende aquella unidad de reajustabilidad que determine  el  Banco Central de "
Lin(19) = Lin(19) & "Chile de acuerdo a lo previsto en el articulo 35, numero 9 de la Ley N� 18.840, y que publique en el Diario Oficial "
Lin(19) = Lin(19) & "conforme al Capitulo II.B.3 del Compendio de Normas Financieras, por el valor vigente en la correspondiente   Fecha "
Lin(19) = Lin(19) & "de Vencimiento o de exigibilidad en caso de liquidaci�n anticipada. "

Lin(20) = "^b)^ Por Tipo de Cambio Observado del d�lar de los  EEUU  se entiende el valor en pesos moneda nacional  del "
Lin(20) = Lin(20) & "d�lar  de  los  EEUU,  seg�n lo publique el  Banco Central de Chile  y  que rija en la  Fecha de Vencimiento  o  de "
Lin(20) = Lin(20) & "exigibilidad en caso de liquidaci�n anticipada,  conforme al numero 6  del Capitulo I del Titulo I del Compendio de "
Lin(20) = Lin(20) & "Normas de Cambios Internacionales. "

Lin(21) = "^c)^ Por Tipo de Cambio Acuerdo del d�lar de los  EEUU  se entiende  el  valor en pesos moneda nacional  del "
Lin(21) = Lin(21) & "d�lar  de los  EEUU,  seg�n fijaci�n que haya hecho el Consejo  del  Banco Central de Chile,  conforme al N� 7  del "
Lin(21) = Lin(21) & " Capitulo I  del  Titulo I  del  Compendio de Normas  de  Cambios Internacionales,  en la  Fecha de Vencimiento o de "
Lin(21) = Lin(21) & "exigibilidad en caso de liquidaci�n anticipada. "

Lin(22) = "^d)^ Por Tipo de Cambio Reuters,  se entiende el valor en pesos moneda nacional  de una  unidad de la moneda "
Lin(22) = Lin(22) & "extranjera de que se trate, seg�n el valor comprador,  vendedor o promedio simple,  seg�n se pacte en el  contrato, "
Lin(22) = Lin(22) & "informado por REUTERS en pantalla 'CHLJ' para el mercado interbancario, a la hora estipulada en el contrato,  en la "
Lin(22) = Lin(22) & " Fecha de Vencimiento o de exigibilidad en caso de liquidaci�n anticipada. "

Lin(23) = "^e)^ Por Paridad Banco Central de Chile,  se entiende la cantidad de moneda extranjera  distinta  del  d�lar "
Lin(23) = Lin(23) & " EEUU, necesaria para comprar un d�lar EEUU, informada por el Banco Central de Chile conforme al N� 6 del Capitulo I "
Lin(23) = Lin(23) & "del Titulo I del Comprendi� de Normas de Cambios Internacionales, en la Fecha de Vencimiento  o  de exigibilidad en "
Lin(23) = Lin(23) & " caso de liquidaci�n anticipada. "

Lin(24) = "^f)^ Por paridad REUTERS,  se entiende la cantidad de moneda extranjera distinta del d�lar  EEUU,  necesaria "
Lin(24) = Lin(24) & "para comprar un d�lar EEUU,  seg�n el valor comprador,  vendedor o promedio simple,  seg�n se pacte en el contrato, "
Lin(24) = Lin(24) & "informado por REUTERS en pantalla 'EFX=',  a la hora estipulada en el contrato,  en la  Fecha de Vencimiento  o  de "
Lin(24) = Lin(24) & " exigibilidad en caso de liquidaci�n anticipada. "

Lin(25) = "En caso que  deje de existir o se modifique alguno de los  factores  definidos,  todas las referencias a 'Unidad de "
Lin(25) = Lin(25) & "Fomento', 'Tipo de Cambio Observado', 'Tipo de Cambio Acuerdo', 'Tipo de Cambio REUTERS', 'Paridad Banco Central de "
Lin(25) = Lin(25) & "Chile', o 'Paridad REUTERS', se entender�n como referidas a aquel factor que los reemplace y que sea aplicable a la "
Lin(25) = Lin(25) & "operaci�n. "

Lin(26) = "@FECHA"

FechaHoy = "Santiago, " & Day(Date) & " de " & BacMesStr(Month(Date)) & " del " & Year(Date)

Lin(26) = BacRemplazar(Lin(26), "@FECHA", FechaHoy)


Lin(1) = BacFormatearTexto(Lin(1), 3, 0, 0, 0, 88)
Lin(2) = BacFormatearTexto(Lin(2), 3, 0, 0, 0, 88)

 nTab = 8
 nFila = 2
 BacGlbSetPrinter 65, 80, 1, 1
 BacGlbSetFont CourierNew, 10, True
 
nFila = nFila + 1
BacGlbPrinter nFila, 1, nTab, 1, Lin(1), 0, 1
nFila = nFila + 1
BacGlbPrinter nFila, 1, nTab, 1, Lin(2), 0, 1
nFila = nFila + 1
BacGlbPrinter nFila, 1, nTab, 1, Lin(0), 0, 1

nTab = 12

nFila = nFila + 1
BacGlbPrinter nFila, 1, nTab, 1, Lin(0), 0, 1

BacGlbSetFont CourierNew, 10, False
    
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

    MsgBox "Problemas para Imprimir Informe de Protocolo de Contrato", vbCritical, TITSISTEMA
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

Dim Sql As String
Dim datos()
Dim TipOperacion As String
Dim FechaAnt As Date
Dim FechaVstr As String
Dim dias As Integer
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

'Sql = "EXECUTE sp_datoscontrato " & NumOper & ", " & tabla & ", '" & giSQL_DatabaseCommon & "'"

Envia = Array()

AddParam Envia, CDbl(NumOper)
AddParam Envia, CDbl(Tabla)
AddParam Envia, giSQL_DatabaseCommon

If Not Bac_Sql_Execute("SP_DATOSCONTRATO ", Envia) Then
   
   MsgBox "Problemas al leer datos para generar contrato", vbCritical, TITSISTEMA
   Exit Function

End If

Lin(0) = " "
Lin(1) = "@BANCO"
Lin(2) = "CONTRATO A FUTURO"
Lin(3) = "N�mero Operaci�n : @NUMERO"
                  
Lin(4) = "Entre ^@BANCO^, Sucursal  en  Chile, en  adelante denominada  'el Banco', "
Lin(4) = Lin(4) & "representada  por  Don ^@REPBANCO1^,  RUT  N�   ^@RUTREPBCO1^ "
If DatCont(5) <> "" Then
    Lin(4) = Lin(4) & "y Don ^@REPBANCO2^,  RUT  N�   ^@RUTREPBCO2^ "
End If

Lin(4) = Lin(4) & "y  ^@CLIENTE^, representado por Don "
Lin(4) = Lin(4) & "^@REPCLIENTE1^,  Rut  N� ^@RUTREPCLI1^ "
If DatCont(12) <> "" Then
    Lin(4) = Lin(4) & "y Don ^@REPCLIENTE2^,  Rut  N� ^@RUTREPCLI2^ "
End If
Lin(4) = Lin(4) & ", en adelante denominado el 'cliente', todo con los "
Lin(4) = Lin(4) & "domicilios que en este instrumento mas adelante se se�alan, se conviene el siguiente Contrato de Futuros: "

Lin(5) = "^PRIMERO : Objeto.^ "

Lin(6) = "Las  partes,  conscientes  que por el dinamismo propio del mercado en que se desarrollan las actividades de su giro, "
Lin(6) = Lin(6) & "cualquier  fluctuaci�n  importante  que se produzca en las principales variables econ�micas se traduce en efectos de "
Lin(6) = Lin(6) & "significaci�n  en  sus  estados  financieros y situaci�n patrimonial, y con el objetivo b�sico de evitar o minimizar "
Lin(6) = Lin(6) & "tales  efectos,  en  sus resultados y lograr una adecuada compatibilidad y calce en las estructuras de sus activos y "
Lin(6) = Lin(6) & "pasivos,  han convenido en la celebraci�n del presente contrato. "

Lin(7) = "^SEGUNDO : Definiciones.^"

Lin(8) = "Para  todos  los  efectos  del  presente contrato, los t�rminos que a continuaci�n se indican, cuando en el presente "
Lin(8) = Lin(8) & "instrumento se escriban con may�scula, tendr�n el significado que a continuaci�n de cada uno de ellos se expresa: "

Lin(9) = "^(a)  U.F.:^  Es  la  Unidad de Fomento a que se refiere el Art. 35 N� 9 de la Ley 18.840, por su valor vigente en las "
Lin(9) = Lin(9) & "correspondientes  Fechas  de  Liquidaci�n.  En  el  caso que se modificare o suprimiere el sistema de reajuste de la "
Lin(9) = Lin(9) & "Unidad  de  Fomento,  las  partes  continuar�n  rigi�ndose por ella como si no se hubiese modificado o suprimido, de "
Lin(9) = Lin(9) & "acuerdo  a  las  publicaciones e informes que deber  hacer el Banco Central de Chile seg�n lo dispone el art�culo 35 "
Lin(9) = Lin(9) & "N� 9, inciso 2  y siguientes, de la Ley N� 18.840 Org�nica constitucional del Banco Central de Chile. "

Lin(10) = "^(b) D�lar o US$:^ Es la moneda legal de los Estados Unidos de Am�rica. "

Lin(11) = "^(c) Pesos o  $:^ Es la moneda legal de Chile. "

Lin(12) = "^(d)  Fecha  de  Liquidaci�n:^  Son aquellas fechas establecidas en el art�culo tercero que sigue, en las cuales deben "
Lin(12) = Lin(12) & "determinarse  las  obligaciones  rec�procas de las partes, efectuarse la compensaci�n entre ambas hasta por el monto "
Lin(12) = Lin(12) & "de la  menor de ellas, y solucionarse la obligaci�n por la que resulte deudora. "

Lin(13) = "^(d.1)^  Sin  embargo,  si  cualquiera  Fecha de Liquidaci�n correspondiente a un d�a que no es un D�a H�bil Bancario, "
Lin(13) = Lin(13) & "dicha Fecha de Liquidaci�n se postergar  hasta el D�a H�bil Bancario siguiente. "

Lin(14) = "^(d.2)^  Si  el  cliente  incurriere,  en  cualquier  tiempo, en mora o simple retardo en el cumplimiento de cualquier "
Lin(14) = Lin(14) & "obligaci�n  con 'el Banco', provenga de este contrato o de cualquier otro, o si cayere en cesaci�n de pagos o insolvencia "
Lin(14) = Lin(14) & "o  se solicitare o declarare su quiebra, 'el Banco' tendr�  el derecho a anticipar la Fecha de Liquidaci�n correspondiente "
Lin(14) = Lin(14) & "previo   aviso  por carta certificada enviada al Cliente con 24 horas de anticipaci�n, a su domicilio se�alado en la "
Lin(14) = Lin(14) & "cl�usula  sexta del presente contrato. "

Lin(15) = "^(d.3)^  Si  el  Cliente  incurriere,  en  cualquier  tiempo, en mora o simple retardo en el cumplimiento de cualquier "
Lin(15) = Lin(15) & "obligaci�n  contraida  con 'el Banco' en virtud de este contrato, en especial, en el cumplimiento de cualquier obligaci�n "
Lin(15) = Lin(15) & "de  pago  de  una suma de dinero, as� como en el caso que 'el Banco' anticipare cualquier Fecha de liquidaci�n conforme a "
Lin(15) = Lin(15) & "lo  se�alado  en  (d.2),  'el Banco' podr�  poner t�rmino a este contrato de inmediato, previo aviso por carta certificada "
Lin(15) = Lin(15) & "enviada al Cliente con 24 horas de anticipaci�n, a su domicilio se�alado en la cl�usula sexta del presente contrato. "

Lin(16) = "^(e)  D�a  H�bil  Bancario:^  Es aquel en que los bancos comerciales establecidos en Santiago, est�n obligados a abrir "
Lin(16) = Lin(16) & "para la atenci�n de p�blico. "

Lin(17) = "^(f)  Tipo  de Cambio:^ Es la cantidad de Pesos necesaria para comprar un D�lar, seg�n el valor que publicite el Banco "
Lin(17) = Lin(17) & "Central  de  Chile  o  el  organismo  que  lo  sustituya o reemplace, en conformidad con lo dispuesto en el N� 6 del "
Lin(17) = Lin(17) & "Cap�tulo  I,  T�tulo  I,  del Compendio De Normas de Cambios Internacionales del Banco Central de Chile, que rija en "
Lin(17) = Lin(17) & "las correspondientes Fechas de Liquidaci�n (D�lar Observado). "

Lin(18) = "Si  el  tipo  de  cambio  del D�lar Observado no fuera publicado por el Banco Central de Chile o el organismo que lo "
Lin(18) = Lin(18) & "reemplace  o  sustituya,  se  aplicar�   a este contrato el tipo de cambio promedio informado en las correspondientes "
Lin(18) = Lin(18) & "Fecha  de  Liquidaci�n  por el Banco Central de Chile como aplicables a las operaciones de compra o venta realizadas "
Lin(18) = Lin(18) & "por  las  empresas  bancarias.  Si  se  informasen  cotizaciones distintas de compra y venta se aplicar�  el promedio "
Lin(18) = Lin(18) & "aritm�tico  de  ambas. En caso de que el Banco Central de Chile dejase de informar dicho tipo de cambio promedio, se "
Lin(18) = Lin(18) & "aplicara  el  tipo   de cambio promedio informado por Inversiones Citicorp Chile S.A. y publicado en alg�n diario de "
Lin(18) = Lin(18) & "la  ciudad  de  Santiago  de  Chile,  en  las  correspondientes Fechas de Liquidaci�n y que corresponda al D�a H�bil "
Lin(18) = Lin(18) & "Bancario  inmediatamente  anterior.  A  falta  de  todos los anteriores, se aplicar�  el promedio aritm�tico entre el "
Lin(18) = Lin(18) & "precio  del  D�lar  comprador  y  del  D�lar vendedor ofrecido en las correspondientes Fechas de Liquidaci�n por las "
Lin(18) = Lin(18) & "oficinas principales de @BANCO, Sucursal en Chile. "

Lin(19) = "^(g)  Libo  o  Libor:^  Es  la  tasa  de  inter�s  a  180  d�as  certificada como tal en la informaci�n del 'Estado de "
Lin(19) = Lin(19) & "Equivalencias  en  Moneda  Extranjera'  proporcionada  por  el  Banco  Central de Chile, y publicada en el diario El "
Lin(19) = Lin(19) & "Mercurio  de  Santiago, Estrategia o en el Diario Financiero en las correspondientes Fechas de Liquidaci�n indicadas "
Lin(19) = Lin(19) & "en  la  cl�usula  tercera.  No  obstante  para  el  c�lculo  de la tasa que regir�  entre la fecha de suscripci�n del "
Lin(19) = Lin(19) & "presente  contrato  y  la  primera  Fecha  de  Liquidaci�n,  esto  es, el @FECHVCT1, se considerar  la tasa Libo de "
Lin(19) = Lin(19) & "@VALORLIB % corresponde al d�a @FECHCIERRE. "

'Lin(20) = *****"En  caso  que  por  cualquiera  causa  o  motivo  el  Banco Central de Chile no hubiere informado la tasa Libo antes"
'Lin(20) = Lin(20) & "indicada,  se  aplicar�  en  su  reemplazo  la tasa Libo para 180 d�as que informe @BANCO, en su oficina"
'Lin(20) = Lin(20) & "principal de  la ciudad de Londres, Inglaterra, como vigente durante el respectivo per�odo."

Lin(21) = "^(h) Tasa Activa Bancario o TAB:^ Es la tasa de inter�s ponderada que, para operaciones de ciento ochenta d�as informa "
Lin(21) = Lin(21) & "y  determina  para  cada  d�a  h�bil  bancario la Asociaci�n de Bancos e Instituciones Financieras de Chile A.G., en "
Lin(21) = Lin(21) & "adelante  la  'Asociaci�n',  sobre  la  base de los datos que le proporcionan cada d�a las instituciones financieras "
Lin(21) = Lin(21) & "participantes,  a  m�s  tardar  a  las  once  horas  ante  meridiano,  acerca  de sus tasas marginales de captaci�n, "
Lin(21) = Lin(21) & "agreg�ndoles  el  costo  que  representan  aquellos factores objetivos cuantificables y comunes para todo el sistema "
Lin(21) = Lin(21) & "financiero  que,  a  juicio  de  la  Asociaci�n, encarecen la captaci�n de fondos del p�blico, todo ello conforme al "
Lin(21) = Lin(21) & "reglamento  de  Tasa  Activa  Bancaria  (TAB)  publicado en extracto por la Asociaci�n en el Diario Oficial de fecha "
Lin(21) = Lin(21) & "veintid�s de Agosto de mil novecientos noventa y dos."

Lin(22) = "^TERCERO:^  Por  el  presente  instrumento,  el  Cliente  se  obliga  a pagar a 'el Banco' en la Fecha de Liquidaci�n las "
Lin(22) = Lin(22) & "siguientes cantidades equivalentes en Pesos al tipo de cambio de las respectivas Fechas de Liquidaci�n. "
          '12345678901234567890123456789012345678901234567890123456789012345678901234567890
Lin(23) = "^Fecha de Liquidaci�n       Monto @MONEDA^ "
Lin(24) = "_________________________________________________________________________________________"

Lin(26) = "Por  su  parte,  'el Banco'  se  obliga  a  pagar al Cliente en las correspondientes Fechas de liquidaci�n las siguientes "
Lin(26) = Lin(26) & "cantidades equivalentes en Pesos al valor de la Unidad de Fomento de las respectivas Fechas de Liquidaci�n: "

Lin(27) = "^Fecha de Liquidaci�n    Monto @MONEDA^"

Lin(29) = "Para todos los c�lculos a efectuar en cada una de las Fechas de Liquidaci�n se�aladas en los p�rrafos anteriores, se "
Lin(29) = Lin(29) & "utilizar�  seg�n  corresponda,  la  tasa  Libo  y  la  tasa  TAB  vigente  en  el mercado, a la Fecha de liquidaci�n "
Lin(29) = Lin(29) & "inmediatamente anterior. "

Lin(30) = "^QUINTO:^  Las  partes  acuerdan  que  ni  el  presente  contrato  ni los derechos que en �l constan, son libremente "
Lin(30) = Lin(30) & "transferibles  ni  pueden  cederse  por  endoso. En consecuencia, ninguna de las partes podr�  ceder o transferir los "
Lin(30) = Lin(30) & "derechos  del   presente contrato sin el previo consentimiento de la otra parte. Para este efecto, el consentimiento "
Lin(30) = Lin(30) & "de  ambas  partes deber  manifestarse en cada uno de los dos ejemplares del presentes contratos, indic�ndose bajo la "
Lin(30) = Lin(30) & "firma  de  cada  una de ellas el nombre de la persona a quien se venden los derechos, as� como la aceptaci�n de �sta "
Lin(30) = Lin(30) & "�ltima para contraer todas las obligaciones que ten�a anteriormente la parte cesionaria. "

Lin(31) = "^SEXTO:^  Durante  la  vigencia del presente contrato, 'el Banco' estar�  facultado para que a su sola discreci�n, efect�e "
Lin(31) = Lin(31) & "colocaciones  interbancarias  en  @CLIENTE  por  un  monto equivalente a la cantidad se�alada en la fecha de "
Lin(31) = Lin(31) & "Liquidaci�n  inmediatamente  posterior  a la Fecha de Liquidaci�n en que se realiza la respectiva colocaci�n y @CLIENTE "
Lin(31) = Lin(31) & "se  obliga a captar dichas colocaciones. Tales colocaciones se realizar�n en cualquier per�odo comprendido "
Lin(31) = Lin(31) & "entre  dos  Fechas  de  Liquidaci�n  sucesivas  y @CLIENTE pagar�  a 'el Banco' la tasa   @VALORTASCLI % vigente en el "
Lin(31) = Lin(31) & "mercado en la fecha  en que se efect�e la colocaci�n referida. "

Lin(32) = "^SEPTIMO:^ Para todos los efectos derivados del presente contrato, las partes fijan domicilio especial y �nico en la "
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

Lin(41) = "Cualquiera  de  las  partes  podr�   modificar  el  domicilio  antes  indicado,  comunic�ndoselo  a la otra por carta "
Lin(41) = Lin(41) & "certificada  dirigida al domicilio se�alado precedentemente en esta cl�usula, como una anticipaci�n no inferior a 10 "
Lin(41) = Lin(41) & "d�as  de la fecha en que dicho cambio de domicilio producir�  sus efectos. En todo caso, todos los domicilios que las "
Lin(41) = Lin(41) & "partes fijen deber�n encontrarse en la ciudad de Santiago de Chile. "

Lin(42) = "^SEPTIMO:^ Todos los gastos, impuestos, derechos y desembolsos de cualquier naturaleza que se causaren con motivo del "
Lin(42) = Lin(42) & "otorgamiento del presente contrato, de su aplicaci�n y/o de su cumplimiento, ser�n de cargo exclusivo del Cliente. "

Lin(43) = "^OCTAVO:^ Todas las obligaciones de las partes derivadas del presente contrato ser�n individuales, en los t�rminos de "
Lin(43) = Lin(43) & "los art�culos 1526 # 4 y 1528 del C�digo Civil de la Rep�blica de Chile. "

Lin(44) = "^NOVENO:^  Cualquier  dificultad o controversia que se suscite entre las partes por cualquier motivo o circunstancia, "
Lin(44) = Lin(44) & "que se relacione directa o indirectamente con este contrato, ser�  resuelta en arbitraje ante un  �rbitro arbitrador o "
Lin(44) = Lin(44) & "amigable  componedor  quien  resolver�  sin forma de juicio y sin ulterior recurso. El  �rbitro ser�  nombrado de com�n "
Lin(44) = Lin(44) & "acuerdo  por las partes. A falta de acuerdo la designaci�n de  �rbitro la har�  la justicia ordinaria, a requerimiento "
Lin(44) = Lin(44) & "de   cualquiera  de  las  partes,  pero  en este caso el  �rbitro ser� de derecho, el procedimiento se sujetar� a las "
Lin(44) = Lin(44) & "normas de  juicio sumario, y las resoluciones que dicte el  �rbitro ser�n susceptibles de todo los recursos legales. "

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
Lin(48) = BacRemplazar(Lin(48), "@REPBANCO", DatCont(3) & Space(31 - Len(DatCont(3))))
Lin(48) = BacRemplazar(Lin(48), "@REPCLIENTE", DatCont(10) & Space(30 - Len(DatCont(10))))
Lin(49) = BacRemplazar(Lin(49), "@RUTREPBCO", DatCont(4) & Space(31 - Len(DatCont(4))))
Lin(49) = BacRemplazar(Lin(49), "@RUTREPCLI", DatCont(11) & Space(30 - Len(DatCont(11))))

Lin(25) = ""
Lin(28) = ""

m = 0
Do While MISQL.SQL_Fetch(datos()) = 0
    FechaAnt = datos(6)
    m = m + 1
    
    TipOperacion = datos(4)
    
    FechaVstr = Format(Day(datos(20)), "00") & " de " & BacMesStr(Month(datos(20))) & " del " & Year(datos(20))
    
    LinCli(m) = "@FECHAVENCFLUJ @MONTOCLI @NOMTASA @VALORTASA% @DIASBASE @MONTOAMORT "
    LinBco(m) = "@FECHAVENCFLUJ @MONTOBCO @NOMTASA @VALORTASA% @DIASBASE @MONTOAMORT "
                        '12345678901234567890123456789012345678901234567890123456789012345678901234567890
    dias = DateDiff("d", FechaAnt, datos(20))
    
    If TipOperacion = "C" Then
        
        LinCli(m) = BacRemplazar(LinCli(m), "@FECHAVENCFLUJ", FechaVstr & Space(25 - Len(FechaVstr)))
        Dat = Format(datos(53), "###,###,###,##0.00")
        LinCli(m) = BacRemplazar(LinCli(m), "@MONTOCLI", Space(18 - Len(Dat)) & Dat)
        LinCli(m) = BacRemplazar(LinCli(m), "@NOMTASA", Space(5 - Len(datos(27))) & datos(27))
        Dat = Format(datos(57), "###0.00000")
        LinCli(m) = BacRemplazar(LinCli(m), "@VALORTASA", Space(10 - Len(Dat)) & Dat)
        Dat = dias & "/" & Val(datos(22))
        LinCli(m) = BacRemplazar(LinCli(m), "@DIASBASE", Space(7 - Len(Dat)) & Dat)
        Dat = Format(datos(52), "###,###,###,##0.00")
        LinCli(m) = BacRemplazar(LinCli(m), "@MONTOAMORT", Space(18 - Len(Dat)) & Dat)

        LinBco(m) = BacRemplazar(LinBco(m), "@FECHAVENCFLUJ", FechaVstr & Space(25 - Len(FechaVstr)))
        Dat = Format(datos(34), "###,###,###,##0.00")
        LinBco(m) = BacRemplazar(LinBco(m), "@MONTOBCO", Space(18 - Len(Dat)) & Dat)
        LinBco(m) = BacRemplazar(LinBco(m), "@NOMTASA", Space(5 - Len(datos(26))) & datos(26))
        Dat = Format(datos(38), "###0.00000")
        LinBco(m) = BacRemplazar(LinBco(m), "@VALORTASA", Space(10 - Len(Dat)) & Dat)
        Dat = dias & "/" & Val(datos(23))
        LinBco(m) = BacRemplazar(LinBco(m), "@DIASBASE", Space(7 - Len(Dat)) & Dat)
        Dat = Format(datos(33), "###,###,###,##0.00")
        LinBco(m) = BacRemplazar(LinBco(m), "@MONTOAMORT", Space(18 - Len(Dat)) & Dat)

    Else
        
        LinBco(m) = BacRemplazar(LinBco(m), "@FECHAVENCFLUJ", FechaVstr & Space(25 - Len(FechaVstr)))
        Dat = Format(datos(53), "###,###,###,##0.00")
        LinBco(m) = BacRemplazar(LinBco(m), "@MONTOCLI", Space(18 - Len(Dat)) & Dat)
        LinBco(m) = BacRemplazar(LinBco(m), "@NOMTASA", Space(5 - Len(datos(27))) & datos(27))
        Dat = Format(datos(57), "###0.00000")
        LinBco(m) = BacRemplazar(LinBco(m), "@VALORTASA", Space(10 - Len(Dat)) & Dat)
        Dat = dias & "/" & Val(datos(22))
        LinBco(m) = BacRemplazar(LinBco(m), "@DIASBASE", Space(7 - Len(Dat)) & Dat)
        Dat = Format(datos(52), "###,###,###,##0.00")
        LinBco(m) = BacRemplazar(LinBco(m), "@MONTOAMORT", Space(18 - Len(Dat)) & Dat)

        LinCli(m) = BacRemplazar(LinCli(m), "@FECHAVENCFLUJ", FechaVstr & Space(25 - Len(FechaVstr)))
        Dat = Format(datos(34), "###,###,###,##0.00")
        LinCli(m) = BacRemplazar(LinCli(m), "@MONTOBCO", Space(18 - Len(Dat)) & Dat)
        LinCli(m) = BacRemplazar(LinCli(m), "@NOMTASA", Space(5 - Len(datos(26))) & datos(26))
        Dat = Format(datos(38), "###0.00000")
        LinCli(m) = BacRemplazar(LinCli(m), "@VALORTASA", Space(10 - Len(Dat)) & Dat)
        Dat = dias & "/" & Val(datos(23))
        LinCli(m) = BacRemplazar(LinCli(m), "@DIASBASE", Space(7 - Len(Dat)) & Dat)
        Dat = Format(datos(33), "###,###,###,##0.00")
        LinCli(m) = BacRemplazar(LinCli(m), "@MONTOAMORT", Space(18 - Len(Dat)) & Dat)

    End If

Loop

Lin(23) = BacRemplazar(Lin(23), "@MONEDA", datos(10))
Lin(27) = BacRemplazar(Lin(27), "@MONEDA", datos(10))
If TipOperacion = "C" Then
    Lin(31) = BacRemplazar(Lin(31), "@VALORTASCLI", datos(24))
Else
    Lin(31) = BacRemplazar(Lin(31), "@VALORTASCLI", datos(23))
End If


Lin(1) = BacFormatearTexto(Lin(1), 3, 0, 0, 0, 88)
Lin(2) = BacFormatearTexto(Lin(2), 3, 0, 0, 0, 88)

 nTab = 8
 nFila = 2
 BacGlbSetPrinter 65, 80, 1, 1
 BacGlbSetFont CourierNew, 10, True

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

BacGlbSetFont CourierNew, 10, False
    
For i = 4 To 45

    Call SumaFila(nFila, 65)
    BacGlbPrinter nFila, 1, nTab, 1, Lin(0), 0, 1
    
    If i = 24 Then
        BacGlbSetFont CourierNew, 8, False
        nTab = 18
        
        Call SumaFila(nFila, 65)
        BacGlbPrinter nFila, 1, nTab, 1, Lin(24), 0, 1
        For j = 1 To m
            Call SumaFila(nFila, 65)
            BacGlbPrinter nFila, 1, nTab, 1, LinCli(j), 0, 1
        Next

        Call SumaFila(nFila, 65)
        BacGlbPrinter nFila, 1, nTab, 1, Lin(24), 0, 1
        
        BacGlbSetFont CourierNew, 10, False
        nTab = 12
    
    ElseIf i = 28 Then
    
        BacGlbSetFont CourierNew, 8, False
        nTab = 18

        Call SumaFila(nFila, 65)
        BacGlbPrinter nFila, 1, nTab, 1, Lin(24), 0, 1
        
        For j = 1 To m
            Call SumaFila(nFila, 65)
            BacGlbPrinter nFila, 1, nTab, 1, LinBco(j), 0, 1
        Next

        Call SumaFila(nFila, 65)
        BacGlbPrinter nFila, 1, nTab, 1, Lin(24), 0, 1
        
        BacGlbSetFont CourierNew, 10, False
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

    MsgBox "Problemas al generar Contrato!", vbInformation, TITSISTEMA
    Exit Function

End Function
Public Function BacCondicionesGenerales(DatCont()) As Boolean

Dim Sql       As String
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
Lin(7) = Lin(7) & "del giro de su denominaci�n, representada por don(a) ^@REPBANCO1^  RUT  N� ^@RUTREPBCO1^ "
Lin(7) = Lin(7) & "y   ^@REPBANCO2^  RUT  N� ^@RUTREPBCO2^  los anteriores  con domicilio, para estos efectos, en calle "
Lin(7) = Lin(7) & "@DIRBANCO de esta ciudad en adelante tambi�n indistintamente  'El  Banco' y  por  la otra "
Lin(7) = Lin(7) & "^@NOMBRECLIENTE^ representada por don(a) ^@REPCLIENTE1^ RUT  N� ^@RUTREPCLI1^ "
Lin(7) = Lin(7) & "y  don(a) ^@REPCLIENTE2^ RUT  N� ^@RUTREPCLI2^ ambos domiciliados, para estos efectos, "
Lin(7) = Lin(7) & "en ^@DIRCLIENTE^ de esta ciudad, en adelante tambi�n el 'Cliente', quienes exponen:"

Lin(8) = "^PRIMERO:^ Por el presente instrumento,  las partes  mas arriba  individualizadas vienen en convenir los "
Lin(8) = Lin(8) & "t�rminos y condiciones generales que regir�n y se aplicaran a todas y cada una de las transacciones  de "
Lin(8) = Lin(8) & "CompraVenta a futuro de moneda extranjera,  de Arbitrajes a futuro de moneda extranjera  (Forwards) y "
Lin(8) = Lin(8) & "Permutas a futuro de moneda extranjera (Swaps),  que se acuerden  o  celebren entre ellas,  a contar de "
Lin(8) = Lin(8) & "esta fecha. "

Lin(9) = "En consecuencia,  todas y cada una de las  transacciones reci�n  indicadas celebrada  o  acordada entre "
Lin(9) = Lin(9) & "ambas,  quedara sujeta a las presentes  condiciones generales,  salvo en cuanto  en el documento  de la "
Lin(9) = Lin(9) & "respectiva operaci�n, acordaren expresamente algo distinto. "

Lin(10) = "Las presentes  Condiciones Generales se rigen y han sido elaboradas en conformidad a las  disposiciones "
Lin(10) = Lin(10) & "del Capitulo VII del Titulo I  del  Compendio de Normas sobre Cambios Internacionales Del Banco Central "
Lin(10) = Lin(10) & "de Chile, vigentes a esta fecha y que las partes declaran conocer y entender plenamente. "

Lin(11) = "^SEGUNDO:^ El Cliente declara y acepta que las transacciones de CompraVenta, de Arbitrajes (Forwards)  y "
Lin(11) = Lin(11) & "de Permuta (Swaps), de moneda extranjera a futuro, implica el riesgo propio de la variaci�n del tipo de "
Lin(11) = Lin(11) & "cambio y/o de la paridad de la divisa objeto del contrato, entre la Fecha de Celebraci�n  y la Fecha de "
Lin(11) = Lin(11) & "Vencimiento del mismo, ambas definidas mas adelante. "

Lin(12) = "En consecuencia,  declara y acepta asimismo  que el car�cter aleatorio  de las referidas transacciones, "
Lin(12) = Lin(12) & "implica el riesgo de que la diferencia entre el precio pactado en pesos moneda corriente nacional  y el "
Lin(12) = Lin(12) & "precio referencial de mercado,  que m�s adelante se define,  a la Fecha de Vencimiento de la respectiva "
Lin(12) = Lin(12) & "transacci�n,  podr� resultarle  adversa o favorable,  lo que ha  considerado  al convenir las presentes "
Lin(12) = Lin(12) & "Condiciones Generales as� como al celebrar cada transacci�n regida por las mismas. "

Lin(13) = "^TERCERO:^ Definiciones:  Para todos  los  efectos de  aplicaci�n  e  interpretaci�n  de  las  presentes "
Lin(13) = Lin(13) & "Condiciones Generales,  as� como de los t�rminos y condiciones de cada Formulario de Confirmaci�n,  los "
Lin(13) = Lin(13) & "t�rminos  que  a continuaci�n se indican,  cuando  se  expresen  con  may�scula  tendr�n  el  siguiente "
Lin(13) = Lin(13) & "significado: "

Lin(14) = "^a) Formulario de Confirmaci�n o Confirmaci�n:^ El documento  mediante  el cual las partes convienen  en "
Lin(14) = Lin(14) & "celebrar una o varias transacciones especificadas de CompraVenta o de Arbitraje (Forward) o de  Permuta "
Lin(14) = Lin(14) & " (Swap) de Moneda Extranjera a futuro, fijando los t�rminos y condiciones de la o las mismas.       Cada "
Lin(14) = Lin(14) & "documento de  Confirmaci�n  que las partes  suscriban, se entender�  formar  parte  integrante  de  las "
Lin(14) = Lin(14) & "presentes Condiciones Generales. "

Lin(15) = "Cada  Confirmaci�n  de  una  o  m�s  transacciones  especificas  acordadas  entre  las  partes,  deber� "
Lin(15) = Lin(15) & "documentarse  en un  'Formulario  de  Confirmaci�n'  similar  al que contiene en el  'Anexo  A'  de las "
Lin(15) = Lin(15) & "presentes Condiciones Generales el cual se inserta al final y que forma parte integrante de las mismas. "

Lin(16) = "^b) Contradicci�n:^ En caso  de  contradicci�n  entre  un documento  de  Confirmaci�n  y  las  presentes "
Lin(16) = Lin(16) & "Condiciones Generales, primaran los t�rminos de la respectiva Confirmaci�n. "

Lin(17) = "^c) Tipo de Transacci�n:^ CompraVenta, Arbitraje(Forward) y Permuta(Swap) de Moneda Extranjera a futuro: "

Lin(18) = "^c.1) CompraVenta:^ Aquella transacci�n en que el Vendedor se compromete a entregar la  Moneda Extranjera "
Lin(18) = Lin(18) & "vendida y el Comprador se obliga a pagar el precio convenido en pesos, moneda corriente nacional, o  en "
Lin(18) = Lin(18) & "Unidades de Fomento pagaderas por su equivalente en pesos,  moneda corriente nacional,  en la  Fecha de "
Lin(18) = Lin(18) & "Vencimiento acordada en la respectiva Confirmaci�n. "

Lin(19) = "^c.2) Arbitraje o Forward:^ Aquella transacci�n  en que el Vendedor se compromete  a  entregar la Moneda "
Lin(19) = Lin(19) & "Extranjera vendida y el Comprador se obliga a  pagar el precio convenido  en  D�lares,  en la  Fecha de "
Lin(19) = Lin(19) & "Vencimiento estipulada en la respectiva Confirmaci�n. "

Lin(20) = "^c.3) Permuta o Swap:^ Aquella transacci�n  en que las partes  intercambian  flujos  financieros  en dos "
Lin(20) = Lin(20) & "monedas diferentes, comprometi�ndose una de ellas a entregar pesos, moneda corriente nacional, Unidades "
Lin(20) = Lin(20) & "de Fomento pagaderas por su equivalente en pesos,  moneda corriente nacional,  o D�lares  y  la otra  a "
Lin(20) = Lin(20) & "entregar la Moneda Extranjera, en la Fecha de Vencimiento especificadas en la respectiva  Confirmaci�n. "

Lin(21) = "^d) Parte Vendedora o Vendedor y parte Compradora o Comprador:^"

Lin(22) = "^d.1) Vendedor:^ Aquella parte que se obliga a entregar a la otra, la Moneda Extranjera,  en la Fecha de "
Lin(22) = Lin(22) & "Vencimiento de la respectiva Confirmaci�n."

Lin(23) = "El Vendedor deber� cumplir con las obligaciones  que le impone  el contrato  a la  Fecha de Vencimiento "
Lin(23) = Lin(23) & "pactada, de acuerdo al mecanismo que se haya convenido en la respectiva Confirmaci�n, el que deber� ser "
Lin(23) = Lin(23) & "alguno de los que se indican a continuaci�n : "

Lin(24) = "^i) Entrega:^ El Vendedor entregara la Moneda Extranjera en la Fecha de Vencimiento estipulada. "

Lin(25) = "En esta modalidad y para el caso que el Vendedor o Comprador fuere persona natural o jur�dica residente "
Lin(25) = Lin(25) & "en Chile, la entrega de Moneda Extranjera quedara condicionada a que este demuestre a satisfacci�n  del "
Lin(25) = Lin(25) & "banco contraparte,  a  mas  tardar  el d�a h�bil bancario  anterior  a la  Fecha de Vencimiento  de  la "
Lin(25) = Lin(25) & "transacci�n, que con dichas divisas realizara a trav�s de dicho banco una operaci�n de cambio expresada "
Lin(25) = Lin(25) & "en la misma Moneda Extranjera objeto del contrato,  por un monto igual  o  superior al estipulado en �l "
Lin(25) = Lin(25) & "mismo."

Lin(26) = "En tal evento,  la entrega de Moneda Extranjera se efectuara  por el  Vendedor mediante  la  entrega de "
Lin(26) = Lin(26) & "cheque bancario girado sobre la ciudad de Nueva York, Estados Unidos de Am�rica  o mediante abono en la "
Lin(26) = Lin(26) & "cuenta corriente en esa misma moneda y que el Comprador hubiere indicado en la respectiva Confirmaci�n. "

Lin(27) = "En esta modalidad,  si no se cumplieren  o  demostraren las condiciones antes referidas,  o si el monto "
Lin(27) = Lin(27) & "pactado  de la divisa  objeto  del  contrato fuere  superior  al  involucrado en la operaci�n de cambio "
Lin(27) = Lin(27) & "demostrada  a  satisfacci�n de  'El Banco',  respecto del total en el primer caso  o  por el excedente en �l "
Lin(27) = Lin(27) & "segundo,  el contrato  se cumplir�  mediante  el  mecanismo de  compensaci�n  descrito en el  punto ii) "
Lin(27) = Lin(27) & "siguiente."

Lin(28) = "^ii) Compensaci�n:^ En esta modalidad, el contrato se cumplir� pagando el Comprador al Vendedor, el monto "
Lin(28) = Lin(28) & "de la diferencia resultante entre el valor del Precio Referencial de mercado  acordado en la respectiva "
Lin(28) = Lin(28) & "Confirmaci�n  vigente a la Fecha de Vencimiento  del  Contrato y el valor del precio pactado por las "
Lin(28) = Lin(28) & "partes ambos multiplicados por el monto de Moneda Extranjera objeto de la respectiva transacci�n, cuando "
Lin(28) = Lin(28) & "este sea superior a aquel."

Lin(29) = "En el caso contrario, el Vendedor pagara dicha diferencia al Comprador."

Lin(30) = "La compensaci�n se efectuara siempre en pesos,  moneda corriente nacional,  mediante la entrega de vale "
Lin(30) = Lin(30) & "vista bancario de la plaza,  o  deposito en la cuenta corriente en pesos,  que la parte correspondiente "
Lin(30) = Lin(30) & "hubiere designado para tal efecto en la respectiva Confirmaci�n."

Lin(31) = "^d.2) Comprador:^ Aquella parte  que se obliga  a  pagar a la otra el precio convenido en pesos,  moneda "
Lin(31) = Lin(31) & "corriente nacional, o en Unidades de Fomento por su equivalente en pesos, moneda corriente nacional, en "
Lin(31) = Lin(31) & "la Fecha de Vencimiento del contrato."

Lin(32) = "Para la aplicaci�n de las disposiciones de la presente letra,  en las transacciones de  Permuta (Swaps) "
Lin(32) = Lin(32) & "de Moneda Extranjera  a  futuro,  se entender� por Vendedor a aquella parte que se obliga a entregar la "
Lin(32) = Lin(32) & "Moneda Extranjera, y por Comprador,  a  aquella parte que se obliga a entregar pesos,  moneda corriente "
Lin(32) = Lin(32) & "nacional, o Unidades de Fomento. "

Lin(33) = "^e) Fecha de Vencimiento de la Transacci�n:^ La  fecha   que  las  partes  convienen  en  la  respectiva "
Lin(33) = Lin(33) & "Confirmaci�n y en la cual deben cumplir sus respectivas obligaciones de Entrega o de Compensaci�n de la "
Lin(33) = Lin(33) & "Moneda Extranjera vendida y pago del precio correspondiente. "

Lin(34) = "^f) D�lar:^ Es la moneda de curso legal en los Estados Unidos de Am�rica."

Lin(35) = "^g) Moneda Extranjera:^ Es la divisa cuya CompraVenta, Arbitraje (Forward)  o  Permuta (Swaps) es objeto "
Lin(35) = Lin(35) & "de la respectiva transacci�n pactada en cada Confirmaci�n, distinta del D�lar. "

Lin(36) = "^h) Precio Referencial de Mercado:^ Es aquel que las partes convienen en cada Confirmaci�n,  vigente a la "
Lin(36) = Lin(36) & "Fecha de Vencimiento de la respectiva transacci�n, que se aplicara al monto de Moneda Extranjera objeto "
Lin(36) = Lin(36) & "de dicha transacci�n, con el fin de expresar su valor en pesos moneda corriente nacional  y definir as� "
Lin(36) = Lin(36) & "el precio final pactado. Este Precio Referencial podr� corresponder al D�lar Acuerdo, D�lar Observado o "
Lin(36) = Lin(36) & "o  al D�lar Interbancario,  todos los cuales se definen mas adelante,  seg�n estipulen las partes en la "
Lin(36) = Lin(36) & "respectiva Confirmaci�n."

Lin(37) = "^i) Cierre de Transacci�n:^ Instante  en el cual  ambas partes manifiestan su consentimiento y cierran a "
Lin(37) = Lin(37) & "firme una determinada transacci�n de  CompraVenta,  Arbitraje o Permuta  de Moneda Extranjera a futuro, "
Lin(37) = Lin(37) & "fijando las condiciones de la misma."

Lin(38) = "El cierre de transacci�n podr� verificarse en una cualquiera de las siguientes formas: verbalmente; por "
Lin(38) = Lin(38) & "v�a  telef�nica;  mediante  telex testeado;  o fax.  Sin  embargo,  cualquiera  sea  el  medio  de  los "
Lin(38) = Lin(38) & "anteriormente  indicados  que se  utilice,  las  partes  deber�n  firmar el original del 'Formulario de "
Lin(38) = Lin(38) & "Confirmaci�n ' correspondiente,  a mas tardar dentro de las 24 horas h�biles bancarias siguientes  a  la "
Lin(38) = Lin(38) & "Fecha de Celebraci�n de dicha transacci�n. "

Lin(39) = "Para los efectos de la presente letra,  las partes aceptan y autorizan expresamente desde ya,  que  sus "
Lin(39) = Lin(39) & "conversaciones y comunicaciones telef�nicas,  sean grabadas por la contraparte,  grabaciones que podr�n "
Lin(39) = Lin(39) & "ser utilizadas como medio probatorio  en caso de controversia  a fin  de establecer la existencia de un "
Lin(39) = Lin(39) & "cierre de Transacciones y/o las condiciones precisas de dicho cierre. "

Lin(40) = "^j) Fecha de Celebraci�n:^ Es la fecha en que las partes cierran una transacci�n determinada."

Lin(41) = "^k) D�lar Acuerdo:^ Es la cantidad de pesos, moneda corriente nacional, necesarios para comprar un D�lar "
Lin(41) = Lin(41) & "y  que fija  y determina  el Banco Central de Chile,  conforme al N� 7 del Capitulo I del Titulo I  del "
Lin(41) = Lin(41) & "Compendio de Normas de Cambios Internacionales.     Si por cualquier causa el referido D�lar acuerdo no "
Lin(41) = Lin(41) & "existiere en la Fecha de Vencimiento respectiva,  se aplicara en su defecto el Tipo de Cambio que a esa "
Lin(41) = Lin(41) & "fecha se aplique  a  los Pagares emitidos en conformidad al Capitulo XIX  del  Titulo I  del  Compendio "
Lin(41) = Lin(41) & "reci�n aludido,  de las series  PCDUS$A  o  PCDUS$B.    Si tampoco pudiere determinarse este ultimo por "
Lin(41) = Lin(41) & "cualquier causa, se aplicara el Tipo de Cambio promedio informado en la Fecha de Vencimiento respectiva, "
Lin(41) = Lin(41) & "por el Banco Central de Chile como aplicable a sus propias operaciones.      Si se informaren distintas "
Lin(41) = Lin(41) & "cotizaciones para compra y venta, se aplicara el promedio aritm�tico entre ambas.  A falta de todos los "
Lin(41) = Lin(41) & "anteriores,  se aplicara el  Tipo de Cambio  D�lar  Observado  existente  a  la  fecha  del  respectivo "
Lin(41) = Lin(41) & "vencimiento."

Lin(42) = "^l) D�lar Interbancario:^ Es la cantidad de pesos, moneda corriente nacional,  necesaria para comprar un "
Lin(42) = Lin(42) & "D�lar,  seg�n se informe en la pagina  CHLE  del  REUTERS, a las o alrededor de las 11:00 horas A.M. de "
Lin(42) = Lin(42) & "Santiago de Chile, y que corresponde a aquel que utilizan los bancos comerciales autorizados para operar "
Lin(42) = Lin(42) & "en Chile, para las compras y ventas de d�lares que celebran entre ellos. "

Lin(43) = "^m) D�lar Observado:^ Es la cantidad de  pesos,  moneda corriente nacional,  necesaria para  comprar  un "
Lin(43) = Lin(43) & "D�lar, publicado por el Banco Central de Chile, en conformidad a lo dispuesto en el N� 6 del Capitulo I "
Lin(43) = Lin(43) & "del Titulo I del Compendio de normas de Cambios Internacionales, en la Fecha de Vencimiento respectiva. "
Lin(43) = Lin(43) & "Si por cualquier causa dejare de publicarse el  D�lar Observado en la Fecha de Vencimiento  respectiva, "
Lin(43) = Lin(43) & "se  aplicara  el  Tipo de Cambio  promedio  informado en dicha  fecha por el  Banco  Central  de  Chile "
Lin(43) = Lin(43) & "como aplicable  a las operaciones bancarias  de compra y venta de  D�lares,  realizadas por los  bancos "
Lin(43) = Lin(43) & "autorizados para operar en el mercado chileno. Si se informaren distintas cotizaciones para la compra y "
Lin(43) = Lin(43) & "venta, se aplicara el promedio aritm�tico entre ambas.    Si tampoco se informare el tipo Cambio reci�n "
Lin(43) = Lin(43) & "referido,  se aplicara en su defecto el  Tipo de Cambio promedio  informado por Citicorp-Chile y que se "
Lin(43) = Lin(43) & "publique en el diario El Mercurio de Santiago en la fecha inmediatamente anterior a la respectiva Fecha "
Lin(43) = Lin(43) & "de Vencimiento. "

Lin(44) = "A falta de todos los anteriores, se aplicara el promedio aritm�tico entre el precio del D�lar comprador "
Lin(44) = Lin(44) & "y  vendedor ofrecidos a publico en la respectiva Fecha de Vencimiento,  por las oficinas principales de "
Lin(44) = Lin(44) & "los bancos y @BANCO y sus sucursales en Chile "

Lin(45) = "^n) Tipo de Cambio:^ Es la cantidad de pesos, moneda corriente nacional, necesaria para adquirir un D�lar "
Lin(45) = Lin(45) & "de los Estados Unidos de Am�rica. "

Lin(46) = "^�) Paridad de la moneda extranjera o Paridad:^ Es la  cantidad  de  Moneda  Extranjera  necesaria  para "
Lin(46) = Lin(46) & "comprar un D�lar. "

Lin(47) = "^o) Precio Referencial de Paridad:^ Es aquel que en la respectiva  Fecha de Vencimiento  corresponda  al "
Lin(47) = Lin(47) & "precio Spot de la Moneda Extranjera de que se trate, por un D�lar o viceversa,  seg�n la cotizaci�n que "
Lin(47) = Lin(47) & "se informe en la pagina WRLD de REUTERS a las o alrededor de las 11:00 horas A.M. de Santiago de Chile. "

Lin(48) = "Precio Spot: Se entiende por tal el  precio contado  de mercado que tiene una Moneda Extranjera  o  el "
Lin(48) = Lin(48) & "D�lar en la respectiva Fecha de Vencimiento, a la Paridad o Tipo de Cambio, seg�n corresponda."

Lin(49) = "^CUARTO:^ Causales de Terminaci�n Anticipada : La verificaci�n  en cualquier tiempo durante  la vigencia "
Lin(49) = Lin(49) & "de este contrato,  de uno cualquiera de los hechos que se indican a continuaci�n,  facultara a la parte "
Lin(49) = Lin(49) & "afectada para exigir la terminaci�n anticipada de una, varias o todas las transacciones de Compraventa, "
Lin(49) = Lin(49) & "Arbitraje (Forward) y/o Permuta(Swap), de Moneda Extranjera a futuro, vigentes entre ellas y pendientes "
Lin(49) = Lin(49) & "de vencimiento:"

Lin(50) = "^a)^ La falta de cumplimiento integro y oportuno de una cualquiera de las obligaciones que le impongan  y "
Lin(50) = Lin(50) & "a que resulte obligada sea por estas Condiciones Generales y/o por la o las respectivas Confirmaciones; "

Lin(51) = "^b)^ Si se declarare la quiebra o liquidaci�n  y/o  se decretare por autoridad competente la intervenci�n "
Lin(51) = Lin(51) & "de una de las partes contratantes; si se presentaren proposiciones de convenio extrajudicial o judicial "
Lin(51) = Lin(51) & "preventivo a sus o por sus acreedores;  si cayere en cesaci�n de pagos u ocurriese cualquier otro hecho "
Lin(51) = Lin(51) & "que comprometa seriamente su solvencia; "

Lin(52) = "^c)^ Si una de las partes se disuelve y/o entra en proceso de liquidaci�n;"

Lin(53) = "^d)^ Si una de las partes transfiere la totalidad  o  parte importante de sus  bienes necesarios  para el "
Lin(53) = Lin(53) & "desarrollo de su giro, sin previo consentimiento escrito de la contraparte; "

Lin(54) = "^e)^ Si una de las partes dejare de cumplir el tiempo  y forma una cualquiera de sus obligaciones de pago "
Lin(54) = Lin(54) & "para con la otra y/o se produjere la exigibilidad anticipada de la misma sea de acuerdo a la ley y/o de "
Lin(54) = Lin(54) & "acuerdo a las estipulaciones de los documentos en que estuviere expresada. "

Lin(55) = "Respecto de 'El Banco',  esta causal se  verificara  tambi�n cuando dicho  incumplimiento  y/o  exigibilidad "
Lin(55) = Lin(55) & "anticipada se produzca en relaci�n a cualquiera "
Lin(55) = Lin(55) & "de sus subsidiarias con domicilio en Chile o el extranjero,  especialmente cualquier agencia o sucursal "
Lin(55) = Lin(55) & "de @BANCO"

Lin(56) = "En el evento de que proceda la terminaci�n anticipada de acuerdo a lo estipulado en esta cl�usula,  las "
Lin(56) = Lin(56) & "transacciones pendientes se liquidaran de inmediato anticipando en consecuencia  la Fecha de Vencimiento "
Lin(56) = Lin(56) & "originalmente pactada, en base a los precios, Paridades o  Tipos de Cambio Referenciales  acordados  en "
Lin(56) = Lin(56) & "las respectivas Confirmaciones y que est�n vigentes a la fecha de dicha liquidaci�n."

Lin(57) = "Siempre y en todo caso,  la parte afectada, tendr� y mantendr� el derecho de ser plenamente indemnizada "
Lin(57) = Lin(57) & "por  la  contratare  de toda perdida  o  perjuicio  que  sufriere  a  consecuencia  de la  terminaci�n "
Lin(57) = Lin(57) & "anticipada,  lo que se determinara una vez  que se verifique  la  Fecha  de  Vencimiento  originalmente "
Lin(57) = Lin(57) & "pactada para la respectiva Confirmaci�n. "

Lin(58) = "En el evento de que a la  Fecha de Vencimiento  originalmente  pactada  en la  respectiva  Confirmaci�n "
Lin(58) = Lin(58) & "resultaren diferencias en contra de la parte afectada, esta no ser� obligada a pago ni devoluci�n alguna "
Lin(58) = Lin(58) & "a la  contraparte,  reteniendo  �ntegramente  dicho beneficio para si a  titulo de pena,  la  que  ser� "
Lin(58) = Lin(58) & "compatible y exigible conjuntamente con cualquiera otra indemnizaci�n que fuere procedente,  de acuerdo "
Lin(58) = Lin(58) & "al presente contrato o la ley, en conformidad al articulo 1.537 del C�digo Civil."

Lin(59) = "Se deja expresa constancia que la aplicaci�n de la  terminaci�n anticipada de que se  trata esta letra, "
Lin(59) = Lin(59) & "son  facultativas  para  la  parte  afectada  y  establecidas  en su  exclusivo beneficio,  pudiendo en "
Lin(59) = Lin(59) & "consecuencia a su absoluto y exclusivo arbitrio,  ejercerlas  o  perseverar en la  o  las transacciones "
Lin(59) = Lin(59) & "pendientes,  sin perjuicio  de su  derecho  de ser plenamente  indemnizada  de todo  da�o,  menoscabo o "
Lin(59) = Lin(59) & "perjuicio que sufriere."

Lin(60) = "^QUINTO:^ Mora o simple retardo : En caso de mora o simple retardo por unas de las partes en cumplir con "
Lin(60) = Lin(60) & "las  obligaciones  de  pago que le  imponen las  presentes  Condiciones  Generales  y  las  respectivas "
Lin(60) = Lin(60) & "Confirmaciones, la parte incumplidora se obliga a pagar a la contraparte,  intereses penales calculados "
Lin(60) = Lin(60) & "sobre el monto de la respectiva obligaci�n,  en raz�n  de la tasa m�xima permitida estipular por la ley "
Lin(60) = Lin(60) & "para operaciones de cr�dito de dinero reajustables en moneda extranjera,  vigente durante el tiempo  de "
Lin(60) = Lin(60) & "la mora o simple retardo y hasta el d�a de pago efectivo. "

Lin(61) = "^SEXTO:^ Vigencia: El presente contrato sobre Condiciones Generales de Compraventa  a  futuro de Moneda "
Lin(61) = Lin(61) & "Extranjera regir� a contar de esta fecha y tendr� duraci�n indefinida."

Lin(62) = "En consecuencia,  estas  Condiciones Generales  se aplicaran a todas las transacciones de  Compraventa, "
Lin(62) = Lin(62) & "Arbitraje (Forwards) y/o Permuta (Swaps) de moneda Extranjera  a Futuro que celebren las partes,  salvo "
Lin(62) = Lin(62) & "que en la respectiva transacci�n las partes dispongan expresamente otra cosa."

Lin(63) = "Sin perjuicio de lo anterior,  cualquiera de las partes podr� poner termino a este contrato avisando  a "
Lin(63) = Lin(63) & "la otra por escrito con a lo menos 30 d�as h�biles bancarios de anticipaci�n. En todo caso, dicho aviso "
Lin(63) = Lin(63) & "no afectara a las transacciones ya efectuadas  y  pendientes de vencimiento,  a  las  cuales  le  ser�n "
Lin(63) = Lin(63) & "plenamente aplicables estas Condiciones Generales,  en cuanto las partes no hubieren dispuesto de com�n "
Lin(63) = Lin(63) & "acuerdo otra cosa."

Lin(64) = "^SEPTIMO:^ Transferibilidad: Los derechos  y  obligaciones que emanan para las partes de las  presentes "
Lin(64) = Lin(64) & "Condiciones Generales,  as� como de las Confirmaciones que celebren a su amparo,  no  son  cesibles  ni "
Lin(64) = Lin(64) & "transferibles a terceros, ni por endoso ni en ninguna otra forma. "

Lin(65) = "No obstante lo anterior,  una o ambas partes podr�n ceder sus derechos  y  obligaciones emanados de las "
Lin(65) = Lin(65) & "presentes Condiciones Generales y respecto de una o m�s de las Confirmaciones vigentes entre ellas,  de "
Lin(65) = Lin(65) & "com�n acuerdo manifestado en forma expresa por escrito en los dos ejemplares de la o las Confirmaciones "
Lin(65) = Lin(65) & "respectivas y en dos copias de estas Condiciones Generales, debidamente firmada."

Lin(66) = "^OCTAVO:^ Pago Con Documentos: Se deja  expresa constancia que los pagos efectuados con documentos,  no "
Lin(66) = Lin(66) & "causaran novaci�n de las obligaciones, si dichos documentos no fueren pagados al presentarlos a cobro."

Lin(67) = "^NOVENO:^ Arbitraje: Cualquier duda, controversia o disputa que surgiere entre las partes con motivo de "
Lin(67) = Lin(67) & "la vigencia,  validez,  aplicaci�n  o  interpretaci�n del  presente contrato  y/o  de  las  respectivas "
Lin(67) = Lin(67) & "Confirmaciones amparadas bajo el mismo, ser�n conocidas y resueltas sin ulterior recurso por un arbitro "
Lin(67) = Lin(67) & "arbitrador, el cual conocer� de acuerdo al procedimiento que dicho arbitro establezca y fallara conforme "
Lin(67) = Lin(67) & "a lo que su prudencia y equidad determinen."

Lin(68) = "Para tal efecto,  las partes designan en este acto a don @ARBITRO1  y  si este no pudiese por "
Lin(68) = Lin(68) & "cualquier causa o no quisiese desempe�ar el cargo o se imposibilitase durante su cometido,  las  partes "
Lin(68) = Lin(68) & "designan en su reemplazo a don @ARBITRO2. "
Lin(68) = Lin(68) & "Si este ultimo por cualquier causa no pudiese o no aceptare desempe�ar el encargo  o  se imposibilitare "
Lin(68) = Lin(68) & "durante su cometido, el arbitro ser� designado de com�n acuerdo por las partes. "

Lin(69) = "A falta  de  dicho  acuerdo,  el arbitro ser� designado por los tribunales ordinarios de justicia de la "
Lin(69) = Lin(69) & "ciudad y comuna de Santiago, debiendo conocer y fallar conforme a Derecho.    Dicho nombramiento deber� "
Lin(69) = Lin(69) & "recaer en un  ex ministro  de  Corte de Apelaciones,  Corte Suprema,  o actual ex abogado integrante de "
Lin(69) = Lin(69) & "alguno de dichos tribunales. "

Lin(70) = "El presente documento se firma en dos ejemplares de id�ntico tenor  y  data,  quedando uno en poder  de "
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
 BacGlbSetFont CourierNew, 10, True

 For i = 1 To 6
    nFila = nFila + 1
    BacGlbPrinter nFila, 1, nTab, 1, Lin(i), 0, 1
    
 Next

nTab = 12

nFila = nFila + 1
BacGlbPrinter nFila, 1, nTab, 1, Lin(0), 0, 1

BacGlbSetFont CourierNew, 10, False
    
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

Function BacContrato01(nNumOper As Long) As String

   Dim sCadena       As String
   Dim Sql           As String
   Dim datos()
   Dim Lin(29)

   BacContrato01 = ""

   'Recuperaci�n de los datos de la operaci�n
   '''''''''Sql = "EXECUTE sp_contrato01 " & nNumOper

   Envia = Array()
   
   AddParam Envia, CDbl(nNumOper)

   If Not Bac_Sql_Execute("SP_CONTRATO01", Envia) Then
   
      MsgBox "Problemas al leer datos del contrato01", vbCritical, TITSISTEMA
      Exit Function

   End If

   'Definici�n del Contrato
   Lin(1) = "@BANCO1"
   Lin(2) = "@CASAMATRIZ"
   Lin(3) = "@DIRECCION"
   Lin(4) = "RUT  :   @RUTBANCO1"

   Lin(5) = "CONTRATO DE FORWARDS UF/PESOS ML. EN EL MERCADO LOCAL"
   Lin(6) = "(Institucional)"

   Lin(7) = "Folio  :  @NUMEROOPERACION"
'   Month
   Lin(8) = "En Santiago de Chile, a @FECHAOPERACION, entre @BANCO1, "
   Lin(8) = Lin(8) + "RUT @RUTBANCO1 debidamente representado por "
   Lin(8) = Lin(8) + "la(s) persona(s) que suscribe(n) y  se individualiza(n)"
   Lin(8) = Lin(8) + "al final, todos domiciliados en esta ciudad, calle "
   Lin(8) = Lin(8) + "@DIRECCION, telefono @TELEFONO1, fax @FAX1, por su "
   Lin(8) = Lin(8) + "parte, y por la otra @BANCO2, RUT @RUT2, debidamente "
   Lin(8) = Lin(8) + "representado por la(s) persona(s) que suscribe(n) y "
   Lin(8) = Lin(8) + "se individualiza(n) al final, todos domiciliados en"
   Lin(8) = Lin(8) + "esta ciudad, calle @DIRECCION2, telefono @TELEFONO2 , "
   Lin(8) = Lin(8) + "fax @FAX2, se ha convenido y cerrado a firme una "
   Lin(8) = Lin(8) + "transaccion forward y/o swap de las monedas que mas "
   Lin(8) = Lin(8) + "adelante se indican y en los terminos que a continuacion "
   Lin(8) = Lin(8) + "se expresan,  amparada y regida por las normas del Capitulo"
   Lin(8) = Lin(8) + "III D1 del Compendio de Normas Financieras del Banco "
   Lin(8) = Lin(8) + "Central de Chile y del Capitulo 8-36 de la Recopilacion "
   Lin(8) = Lin(8) + "actualizada de Normas de la Superintendencia de Bancos e "
   Lin(8) = Lin(8) + "Instituciones Financieras, y por las Condiciones "
   Lin(8) = Lin(8) + "Generales utilizadas en Contratos de Forwards UF/Pesos ML. "
   Lin(8) = Lin(8) + "en el Mercado Local suscrito entre las partes, vigente a "
   Lin(8) = Lin(8) + "la fecha de cierre del contrato, que las partes declaran "
   Lin(8) = Lin(8) + "conocer :"

   Lin(9) = "1.  Vendedor                         :  @BANCO2"
   Lin(10) = "2.  Comprador                        :  @BANCO1"
   Lin(11) = "3.  Tipo de Transaccion              :  @TIPOTRANSACCION"
   Lin(12) = "4.  Fecha de Cierre (dd/mm/aa)       :  @FECHACIERRE"
   Lin(13) = "5.  Hora de Cierre                   :  @HORACIERRE"
   Lin(14) = "6.  Fecha de Vencimiento (dd/mm/aa)  :  @FECHAVENCIMIENTO"
   Lin(15) = "7.  Mecanismo de Cumplimiento        :  @MODALIDAD"
   Lin(16) = "8.  Cantidad de Moneda Vendida       :  @MONEDAVENDIDA @CANTIDADVENDIDA"
   Lin(17) = "    @GLOSA1"
   Lin(18) = "9.  Tipo de Cambio Forward Pactado   :  @TIPOCAMBIOPACTADO @MONEDACONV "
   Lin(18) = Lin(18) + "por @MONEDAVENIDA @PARFORWARDUF"
   Lin(19) = "10. Paridad Forward Pactada          :  @PARFORWARDPAC"
   Lin(20) = "11. Valor Forward Pactado            :  @VALORPACTADO"
   Lin(21) = "    @GLOSA2"
   Lin(22) = "12. Tipo de Cambio de Referencia     :  @TIPOCAMBIOREFERENCIA"
   Lin(23) = "13. Paridad de Referencia            :  @PARIDADREFERENCIA"
   Lin(24) = "14. Lugar de Cumplimiento            :  @LUGARCUMPLIMIENTO"
   Lin(25) = "15. Otras Condiciones                :  @OTRASCONDICIONES"

   Lin(26) = "En el caso de cumplimiento por compensacion, a la fecha de "
   Lin(26) = Lin(26) + "vencimiento pactada se establecerla cuantia de la obligaciones "
   Lin(26) = Lin(26) + "contraidas por ambas partes, compensandose dichas obligaciones, "
   Lin(26) = Lin(26) + "y extinguiendose, estas hasta por el monto de la menor de ellas.  "
   Lin(26) = Lin(26) + "La diferencia que resulte de esta compensacion y liquidacion "
   Lin(26) = Lin(26) + "debera ser pagada por la parte deudora a la parte acreedora, "
   Lin(26) = Lin(26) + "en pesos moneda nacional, al contado, en el domicilio de esta "
   Lin(26) = Lin(26) + "ultima. Las partes de comun acuerdo podran anticipar la fecha "
   Lin(26) = Lin(26) + "de liquidacion del contrato. Ni el presente contrato , ni los "
   Lin(26) = Lin(26) + "derechos que de el emanan podran endosarse o transferirse, sin "
   Lin(26) = Lin(26) + "consentimiento escrito de ambas partes, del que deber dejarse "
   Lin(26) = Lin(26) + "constancia en los dos ejemplares que se firman del mismo. Si "
   Lin(26) = Lin(26) + "cualquiera de las partes no cumple las obligaciones contraidas "
   Lin(26) = Lin(26) + "en este contrato, operar automatica y obligatoriamente el "
   Lin(26) = Lin(26) + "mecanismo de compensacion estipulado anteriormente. Si la parte "
   Lin(26) = Lin(26) + "deudora no pagare a la parte acreedora la diferencia que "
   Lin(26) = Lin(26) + "arrojare a favor de esta ultima la aludida compensacion, "
   Lin(26) = Lin(26) + "el monto adeudado devengar, a partir de la mora y hasta la "
   Lin(26) = Lin(26) + "fecha de pago efectivo, la tasa de interes maximo "
   Lin(26) = Lin(26) + "convencional que la ley permite estipular para la moneda "
   Lin(26) = Lin(26) + "adecuada, sin perjuicio del derecho de la parte acreedora "
   Lin(26) = Lin(26) + "para exigir el cumplimiento forzado de la obligacion."

   Lin(27) = "    p.Vendedor                                p.Comprador"
      
   Lin(28) = "Nombre: @APODERADO1 RUT: @RUTAPODERADO1   Nombre: @APODERADO3 RUT: "
   Lin(28) = Lin(28) + "@RUTAPODERADO3"
   Lin(29) = "Nombre: @APODERADO2 RUT: @RUTAPODERADO2   Nombre: @APODERADO4 RUT: "
   Lin(29) = Lin(29) + "@RUTAPODERADO4"

   Do While MISQL.SQL_Fetch(datos()) = 0

      Lin(1) = BacRemplazar(Lin(1), "@BANCO1", datos(1))
      Lin(2) = BacRemplazar(Lin(2), "@CASAMATRIZ", datos(2))
      Lin(3) = BacRemplazar(Lin(3), "@DIRECCION", datos(3))
      Lin(4) = BacRemplazar(Lin(4), "@RUTBANCO1", datos(4))

      Lin(7) = BacRemplazar(Lin(7), "@NUMEROOPERACION", Format(Val(datos(5))))

      Lin(8) = BacRemplazar(Lin(8), "@FECHAOPERACION", datos(6))
      Lin(8) = BacRemplazar(Lin(8), "@BANCO1", datos(1))
      Lin(8) = BacRemplazar(Lin(8), "@RUTBANCO1", datos(4))
      Lin(8) = BacRemplazar(Lin(8), "@DIRECCION", datos(3))
      Lin(8) = BacRemplazar(Lin(8), "@TELEFONO1", datos(7))
      Lin(8) = BacRemplazar(Lin(8), "@FAX1", datos(8))
      Lin(8) = BacRemplazar(Lin(8), "@BANCO2", datos(9))
      Lin(8) = BacRemplazar(Lin(8), "@RUT2", datos(10))
      Lin(8) = BacRemplazar(Lin(8), "@DIRECCION2", datos(11))
      Lin(8) = BacRemplazar(Lin(8), "@TELEFONO2", datos(12))
      Lin(8) = BacRemplazar(Lin(8), "@FAX2", datos(13))

      Lin(9) = BacRemplazar(Lin(9), "@BANCO2", datos(7))
      Lin(10) = BacRemplazar(Lin(10), "@BANCO1", datos(1))
      Lin(11) = BacRemplazar(Lin(11), "@TIPOTRANSACCION", IIf(datos(14) = "C", "COMPRA", "VENTA"))
      Lin(12) = BacRemplazar(Lin(12), "@FECHACIERRE", datos(15))
      Lin(13) = BacRemplazar(Lin(13), "@HORACIERRE", datos(16))
      Lin(14) = BacRemplazar(Lin(14), "@FECHAVENCIMIENTO", datos(17))
      Lin(15) = BacRemplazar(Lin(15), "@MODALIDAD", IIf(datos(18) = "C", "COMPENSACION", "ENTREGA FISICA"))
      Lin(16) = BacRemplazar(Lin(16), "@MONEDAVENDIDA", datos(19))
      Lin(16) = BacRemplazar(Lin(16), "@CANTIDADVENDIDA", datos(20))
      Lin(17) = BacRemplazar(Lin(17), "@GLOSA1", datos(21))
      Lin(18) = BacRemplazar(Lin(18), "@TIPOCAMBIOPACTADO", datos(22))
      Lin(18) = BacRemplazar(Lin(18), "@MONEDACONV", datos(25))
      Lin(18) = BacRemplazar(Lin(18), "@MONEDAVENDIDA", datos(19))
      Lin(18) = BacRemplazar(Lin(18), "@PARFORWARDUF", datos(23))
      Lin(19) = BacRemplazar(Lin(19), "@PARFORWARDPAC", datos(24))
      Lin(20) = BacRemplazar(Lin(20), "@VALORPACTADO", datos(25))
      Lin(21) = BacRemplazar(Lin(21), "@GLOSA2", datos(26))
      Lin(22) = BacRemplazar(Lin(22), "@TIPOCAMBIOREFERENCIA", datos(25))
      Lin(23) = BacRemplazar(Lin(23), "@PARIDADREFERENCIA", datos(26))
      Lin(24) = BacRemplazar(Lin(24), "@LUGARCUMPLIMIENTO", datos(27))
      Lin(25) = BacRemplazar(Lin(25), "@OTRASCONDICIONES", datos(28))
      
      Lin(28) = BacRemplazar(Lin(28), "@APODERADO1", datos(29))
      Lin(28) = BacRemplazar(Lin(28), "@RUTAPODERADO1", datos(30))
      Lin(28) = BacRemplazar(Lin(28), "@APODERADO3", datos(33))
      Lin(28) = BacRemplazar(Lin(28), "@RUTAPODERADO3", datos(34))
      Lin(29) = BacRemplazar(Lin(29), "@APODERADO2", datos(31))
      Lin(29) = BacRemplazar(Lin(29), "@RUTAPODERADO2", datos(32))
      Lin(29) = BacRemplazar(Lin(29), "@APODERADO4", datos(35))
      Lin(29) = BacRemplazar(Lin(29), "@RUTAPODERADO4", datos(36))

   Loop

   Lin(5) = BacFormatearTexto(Lin(5), 3, 0, 0, 0, 80)
   Lin(6) = BacFormatearTexto(Lin(6), 3, 0, 0, 0, 80)
   Lin(7) = BacFormatearTexto(Lin(7), 2, 0, 0, 0, 80)
   
   Lin(8) = BacFormatearTexto(Lin(8), 4, 0, 0, 1, 80)

   Lin(26) = BacFormatearTexto(Lin(26), 4, 0, 0, 1, 80)

   sCadena = ""
   sCadena = sCadena & Lin(1) & vbCrLf
   sCadena = sCadena & Lin(2) & vbCrLf
   sCadena = sCadena & Lin(3) & vbCrLf
   sCadena = sCadena & Lin(4) & vbCrLf & vbCrLf
   sCadena = sCadena & Lin(5) & vbCrLf
   sCadena = sCadena & Lin(6) & vbCrLf & vbCrLf
   sCadena = sCadena & Lin(7) & vbCrLf & vbCrLf
   sCadena = sCadena & Lin(8) & vbCrLf & vbCrLf
   sCadena = sCadena & Lin(9) & vbCrLf
   sCadena = sCadena & Lin(10) & vbCrLf
   sCadena = sCadena & Lin(11) & vbCrLf
   sCadena = sCadena & Lin(12) & vbCrLf
   sCadena = sCadena & Lin(13) & vbCrLf
   sCadena = sCadena & Lin(14) & vbCrLf
   sCadena = sCadena & Lin(15) & vbCrLf
   sCadena = sCadena & Lin(16) & vbCrLf
   sCadena = sCadena & Lin(17) & vbCrLf
   sCadena = sCadena & Lin(18) & vbCrLf
   sCadena = sCadena & Lin(19) & vbCrLf
   sCadena = sCadena & Lin(20) & vbCrLf
   sCadena = sCadena & Lin(21) & vbCrLf
   sCadena = sCadena & Lin(22) & vbCrLf
   sCadena = sCadena & Lin(23) & vbCrLf
   sCadena = sCadena & Lin(24) & vbCrLf
   sCadena = sCadena & Lin(25) & vbCrLf & vbCrLf
   sCadena = sCadena & Lin(26) & vbCrLf & vbCrLf
   sCadena = sCadena & Lin(27) & vbCrLf & vbCrLf
   sCadena = sCadena & Lin(28) & vbCrLf & vbCrLf
   sCadena = sCadena & Lin(29) & vbCrLf & vbCrLf

   BacContrato01 = sCadena

End Function
