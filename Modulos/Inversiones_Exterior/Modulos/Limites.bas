Attribute VB_Name = "Limites"
Function Limites_Error(cSist As String, nNumoper As Double)

    Dim Mensaje1    As String
    Dim Mensaje     As String
    Dim datos()

    Mensaje = ""
            
    envia = Array()
    AddParam envia, "BEX"
    AddParam envia, nNumoper
                            
    If Bac_Sql_Execute(gsBac_LineasDB & "..SP_LIMITES_CHEQUEARERROR", envia) Then
            
        Do While Bac_SQL_Fetch(datos())
            Mensaje = Mensaje & datos(1)
            If CDbl(datos(2)) > 0 Then
                Mensaje = Mensaje & " " & Format(CDbl(datos(2)), FEntero)
            End If
            Mensaje = Mensaje & Chr(10) & Chr(13)
                   
            Mensaje1 = vbCrLf & vbCrLf & vbCrLf & "Problemas Limites Usuarios: " & vbCrLf & vbCrLf
        Loop
                
    End If
    
    Limites_Error = Mensaje1 & Mensaje
    
    
'    '********** Linea -- Mkilo
'     Dim Mensaje_Lin     As String
'     Dim Mensaje_Lim     As String
'
'     Mensaje_Lin = ""
'     Mensaje_Lim = ""
'
'     If gsBac_Lineas = "S" Then
'
'         Mensaje_Lin = Lineas_Error("BTR", dNumdocu)
'         Mensaje_Lim = Limites_Error("BTR", dNumdocu)
'
'     End If
'     '********** Fin
    

End Function

Function Lineas_Error(cSist As String, nNumoper As Double)

    Dim Mensaje1    As String
    Dim Mensaje     As String
    Dim datos()

    Mensaje = ""
            
    envia = Array()
    AddParam envia, "BEX"
    AddParam envia, nNumoper
  '  AddParam envia, Format(gsBac_Fecp, "YYYYMMDD")
                            
    If Bac_Sql_Execute(gsBac_LineasDB & "..SP_LINEAS_GRABARERROR", envia) Then
            
        Do While Bac_SQL_Fetch(datos())
            Mensaje = Mensaje & datos(1)
            If CDbl(datos(2)) > 0 Then
                Mensaje = Mensaje & " " & Format(CDbl(datos(2)), FEntero)
            End If
            Mensaje = Mensaje & Chr(10) & Chr(13)
                   
            Mensaje1 = vbCrLf & vbCrLf & vbCrLf & "Problemas Lineas: " & vbCrLf & vbCrLf
        Loop
                
    End If
    
    Lineas_Error = Mensaje1 & Mensaje
    
    
'    '********** Linea -- Mkilo
'     Dim Mensaje_Lin     As String
'     Dim Mensaje_Lim     As String
'
'     Mensaje_Lin = ""
'     Mensaje_Lim = ""
'
'     If gsBac_Lineas = "S" Then
'
'         Mensaje_Lin = Lineas_Error("BTR", dNumdocu)
'         Mensaje_Lim = Limites_Error("BTR", dNumdocu)
'
'     End If
'     '********** Fin

End Function


Function Lineas_Anular(cSist As String, nNumoper As Double)

    Dim datos()
                    
    envia = Array()
    AddParam envia, gsBac_Fecp
    AddParam envia, "BEX"
    AddParam envia, nNumoper
                            
    Lineas_Anular = True
    If Not Bac_Sql_Execute(gsBac_LineasDB & "..SP_LINEAS_ANULA", envia) Then
        Lineas_Anular = False
    End If
    
End Function




Function Lineas_Chequear(cSist As String, cTipOper As String, nNumPantalla As Double, cTipoOpBCC As String, cValCheque As String, cMercado As String)

    Dim datos()

    envia = Array()
    AddParam envia, cSist                               'Sistema
    AddParam envia, cTipOper                            'Producto
    AddParam envia, nNumPantalla                        'Numero Pantalla
    AddParam envia, cTipoOpBCC                          'Tipo Operacion BCC
    AddParam envia, cValCheque                          'Valida Cheque - BCC
    AddParam envia, cMercado                            'Mercado Local/externo - FWD


    Lineas_Chequear = ""
                        
    If Bac_Sql_Execute(gsBac_LineasDB & "..SP_LINEAS_CHEQUEAR", envia) Then
        Do While Bac_SQL_Fetch(DATOS())
           Lineas_Chequear = Lineas_Chequear & DATOS(1) & vbCrLf
        Loop
    End If

End Function


Function Lineas_ChequearGrabar(cSist As String, cTipOper As String, nNumPantalla As Double, nNumdocu As Double, ncorrela As Double, nRut As Double, nCodigo As Double, nMonto As Double, nTipCambio As Double, dFecven As Date, nRut_emisor As Double, nMonedaEmision As Integer, dFecvenInst As Date, nIncodigo As Integer, cSeriado As String, nMonedaPago As Integer, cGarantia As String, nCodigo_pais As Integer, cPagoCheque As String, nRutCheque As Double, dFecvenCheque As Date, nFactorVenta As Double, nForPag As Integer, nTir As Double, nTasaPact As Double, cInstser As String)
'                              "BEX"         , "CPX"              , Numoper             , Numoper            , 1                 , CDbl(rut_cli) , Cod_cli          , CDbl(grilla.TextMatrix(i, 6)), 0      , gsBac_Fecp     , 0                     , 0                          , gsBac_Fecp       , 0                   , "S"              , 0                     , "C"                 , 0                     , "N"                  , 0                   , gsBac_Fecp           , 0                     , 0                 , CDbl(TR)      ,                   0, "")

    Dim datos()

    envia = Array()
    AddParam envia, gsBac_Fecp                         'Fecha de Proceso
    AddParam envia, cSist                                    'Sistema
    AddParam envia, cTipOper                              'Producto
    AddParam envia, nNumPantalla                       'Numero Operacion
    AddParam envia, nNumdocu                            'Numero Documento
    AddParam envia, ncorrela                               'Numero Correlativo
    AddParam envia, nRut                                    'Rut a Chequear
    AddParam envia, nCodigo                               'Codigo a Chequear
    AddParam envia, nMonto                               'Monto
    AddParam envia, nTipCambio                          'Tipo Cambio
    AddParam envia, Format(dFecven, feFECHA)   'Fecha Vencimiento
    AddParam envia, gsUsuario                           'Usuario
    AddParam envia, nRut_emisor                        'Emisor Instrumento (BTR)
    AddParam envia, nMonedaEmision                  'Moneda Emision (BTR)
    AddParam envia, dFecvenInst                         'Fecha Vencimiento Istrumento
    AddParam envia, nIncodigo                            'Codigo Familia (BTR)
    AddParam envia, cSeriado                             'Seriado S/N (BTR)
    AddParam envia, nMonedaPago                     'Moneda Forward
    AddParam envia, cGarantia                           '(C)Con Garantia   (S)Sin Garantia (BTR)
    AddParam envia, nCodigo_pais                        'Codigo Pais (FWD-SPO)
    AddParam envia, cPagoCheque                         'Pago con Cheque S/N
    AddParam envia, nRutCheque                          'Rut a chequear en pago Chueque
    AddParam envia, dFecvenCheque                       'Fecha Vcto linea Cheque
    AddParam envia, nFactorVenta                        'Factor en Venta Definitiva
''    AddParam envia, nCodEmisor                          'Codigo Emisor
    AddParam envia, nForPag                             ' Forma de Pago VGS
    AddParam envia, nTir                                ' Tir del Papel
    AddParam envia, nTasaPact                           ' Tasa pacto
    AddParam envia, cInstser                            ' Nemotecnico

                        
    Lineas_ChequearGrabar = True
                        
    If Not Bac_Sql_Execute(gsBac_LineasDB & "..SP_LINEAS_CHEQUEARGRABAR", envia) Then
        Lineas_ChequearGrabar = False
    End If
    
End Function

Function Lineas_GrbOperacion(cSist As String, cTipOper As String, nNumPantalla As Double, nNumoper As Double, cTipoOpBCC As String, cValCheque As String, cMercado As String)

    Dim datos()

If cTipOper = "CP" Or cTipOper = "VP" Then
    envia = Array()
    AddParam envia, cSist                               'Sistema
    AddParam envia, cTipOper                            'Producto
    AddParam envia, nNumPantalla                        'Numero Pantalla
    AddParam envia, nNumoper                            'Numero Operacion
    AddParam envia, cTipoOpBCC                          'Tipo Operacion BCC
    AddParam envia, cValCheque                          'Valida Cheque - BCC
    AddParam envia, cMercado                            'Mercado Local/externo - FWD

    Lineas_GrbOperacion = True
                        
    If Not Bac_Sql_Execute(gsBac_LineasDB & "..SP_LINEAS_GRBOPERACION", envia) Then
        MsgBox "Error al Grabar Lineas", vbCritical, "LINEAS"
        Lineas_GrbOperacion = False
    End If
End If


'''If cTipOper = "VP" Then
'''
'''    envia = Array()
'''    AddParam envia, cSist                               'Sistema
'''    AddParam envia, cTipOper                            'Producto
'''    AddParam envia, nNumPantalla                        'Numero Pantalla
'''    AddParam envia, nNumoper                            'Numero Operacion
'''    AddParam envia, cTipoOpBCC                          'Tipo Operacion BCC
'''    AddParam envia, cValCheque                          'Valida Cheque - BCC
'''    AddParam envia, cMercado                            'Mercado Local/externo - FWD
'''
'''
'''    If Not Bac_Sql_Execute(gsBac_LineasDB + "..SP_GRABA_LIMITES_VENTAS", envia) Then
'''        MsgBox "Error al Grabar Lineas", vbCritical, "LINEAS"
'''        Lineas_GrbOperacion = False
'''    End If
'''
'''End If



End Function


Function Lineas_ConsultaOperacion(cSist As String, cTipOper As String, nNumPantalla As Double, cTipoOpBCC As String, cValCheque As String, cMercado As String)

    Dim Mensaje_Lin1    As String
    Dim Mensaje_Lin     As String
    Dim Mensaje_Lim1    As String
    Dim Mensaje_Lim     As String


    Dim datos()

    envia = Array()
    AddParam envia, cSist                               'Sistema
    AddParam envia, cTipOper                            'Producto
    AddParam envia, nNumPantalla                        'Numero Pantalla
    AddParam envia, cTipoOpBCC                          'Tipo Operacion BCC
    AddParam envia, cValCheque                          'Valida Cheque - BCC
    AddParam envia, cMercado                            'Mercado Local/externo - FWD


    Lineas_ConsultaOperacion = ""

    Mensaje_Lin1 = ""
    Mensaje_Lin = ""
    Mensaje_Lim1 = ""
    Mensaje_Lim = ""

                        
    If Bac_Sql_Execute("SP_LINEAS_CONSULTAROPERACION", envia) Then

         Do While Bac_SQL_Fetch(datos())

            If datos(1) = "LIN" Then

               Mensaje_Lin = Mensaje_Lin & datos(3)

               If CDbl(datos(4)) > 0 Then
                  Mensaje_Lin = Mensaje_Lin & " En " & Format(CDbl(datos(4)), FEntero)
               End If
               Mensaje_Lin = Mensaje_Lin & Chr(10) & Chr(13)
                  
               Mensaje_Lin1 = vbCrLf & vbCrLf & "Problemas Lineas: " & vbCrLf & vbCrLf
            End If

'''''
'''''            If datos(1) = "LIM" Then
'''''
'''''               Mensaje_Lim = Mensaje_Lim & datos(3)
'''''
'''''               If CDbl(datos(4)) > 0 Then
'''''                  Mensaje_Lim = Mensaje_Lim & " En " & Format(CDbl(datos(4)), FEntero)
'''''               End If
'''''               Mensaje_Lim = Mensaje_Lim & Chr(10) & Chr(13)
'''''
'''''               Mensaje_Lim1 = vbCrLf & vbCrLf & "Problemas Lineas: " & vbCrLf & vbCrLf
'''''            End If


         Loop


         Lineas_ConsultaOperacion = Mensaje_Lin1 & Mensaje_Lin & Mensaje_Lim1 & Mensaje_Lim


    End If

End Function






Function Lineas_BorraConsultaOperacion(cSist As String, nNumPantalla As Double)

Dim Mensaje_Lin1    As String
Dim Mensaje_Lin     As String
Dim Mensaje_Lim1    As String
Dim Mensaje_Lim     As String

Dim datos()

envia = Array()
AddParam envia, cSist                               'Sistema
AddParam envia, nNumPantalla                        'Numero Pantalla
                    
If Not Bac_Sql_Execute("SP_LINEAS_BORRARCONSULTAROPERACION", envia) Then
    MsgBox "'Sp_Lineas_BorrarConsultarOperacion' , Error al Eliminar Registro Temporal", vbCritical, "LINEAS"
     
End If

End Function




