Attribute VB_Name = "Limites"
Function Limites_Error(cSist As String, nNumoper As Double)

    Dim Mensaje1    As String
    Dim mensaje     As String
    Dim DATOS()

    mensaje = ""
            
    Envia = Array()
    AddParam Envia, "BTR"
    AddParam Envia, nNumoper
                            
    If Bac_Sql_Execute(gsBac_LineasDb & "..SP_LIMITES_CHEQUEARERROR", Envia) Then
    'If Bac_Sql_Execute("SP_LIMITES_CHEQUEARERROR", Envia) Then
            
''''        Do While Bac_SQL_Fetch(datos())
''''            Mensaje = Mensaje & datos(1)
''''            If CDbl(datos(2)) > 0 Then
''''                Mensaje = Mensaje & " " & Format(CDbl(datos(2)), FEntero)
''''            End If
''''            Mensaje = Mensaje & Chr(10) & Chr(13)
''''
''''            Mensaje1 = vbCrLf & vbCrLf & vbCrLf & "Problemas Limites Usuarios: " & vbCrLf & vbCrLf
''''        Loop
                
    End If
    
    Limites_Error = Mensaje1 & mensaje
    
    
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
    Dim mensaje     As String
    Dim DATOS()

    mensaje = ""
            
    Envia = Array()
    AddParam Envia, "BTR"
    AddParam Envia, nNumoper
    'AddParam Envia, Format(gsBac_Fecp, "YYYYMMDD")
                            
    'If Bac_Sql_Execute("SP_LINEAS_GRABARERROR", Envia) Then
    If Bac_Sql_Execute(gsBac_LineasDb & "..SP_LINEAS_GRABARERROR", Envia) Then
            
        Do While Bac_SQL_Fetch(DATOS())
            mensaje = mensaje & DATOS(1)
            If CDbl(DATOS(2)) > 0 Then
                mensaje = mensaje & " " & Format(CDbl(DATOS(2)), FEntero)
            End If
            mensaje = mensaje & Chr(10) & Chr(13)
                   
            Mensaje1 = vbCrLf & vbCrLf & vbCrLf & "Problemas Lineas: " & vbCrLf & vbCrLf
        Loop
                
    End If
    
    Lineas_Error = Mensaje1 & mensaje
    
    
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

    Dim DATOS()
                    
    Envia = Array()
    AddParam Envia, gsBac_Fecp
    AddParam Envia, "BTR"
    AddParam Envia, nNumoper
                            
    Lineas_Anular = True
    'If Not Bac_Sql_Execute("SP_LINEAS_ANULA", Envia) Then
    If Not Bac_Sql_Execute(gsBac_LineasDb & "..SP_LINEAS_ANULA", Envia) Then
        Lineas_Anular = False
    End If
    
    '********************************
    'Control Art84
    '********************************
    Envia = Array()
    AddParam Envia, "BTR"
    AddParam Envia, nNumoper
    AddParam Envia, 0

    If Not Bac_Sql_Execute(gsBac_LineasDb & "..SP_REBAJA_ENDEUDAMIENTO", Envia) Then
        MsgBox "No se pudo anular Art84 atribuidas a la operacion", vbInformation, "Anulacion de Art84"
        Lineas_Anular = False
    End If
    
End Function




Function Lineas_Chequear(cSist As String, cTipOper As String, nNumPantalla As Double, cTipoOpBCC As String, cValCheque As String, cMercado As String)

    Dim DATOS()

    Envia = Array()
    AddParam Envia, cSist                               'Sistema
    AddParam Envia, cTipOper                            'Producto
    AddParam Envia, nNumPantalla                        'Numero Pantalla
    AddParam Envia, cTipoOpBCC                          'Tipo Operacion BCC
    AddParam Envia, cValCheque                          'Valida Cheque - BCC
    AddParam Envia, cMercado                            'Mercado Local/externo - FWD


    Lineas_Chequear = ""
                        
    'If Bac_Sql_Execute("SP_LINEAS_CHEQUEAR", Envia) Then
    If Bac_Sql_Execute(gsBac_LineasDb & "..SP_LINEAS_CHEQUEAR", Envia) Then
        Do While Bac_SQL_Fetch(DATOS())
           Lineas_Chequear = Lineas_Chequear & DATOS(1) & vbCrLf
        Loop
    End If

End Function




Function Lineas_ChequearGrabar(cSist As String, cTipOper As String, nNumPantalla As Double _
                            , nNumdocu As Double, nCorrela As Double, nRut As Double _
                            , nCodigo As Double, nMonto As Double, nTipCambio As Double _
                            , dFecven As Date, nRut_emisor As Double, nMonedaEmision As Integer _
                            , dFecvenInst As Date, nIncodigo As Integer, cSeriado As String _
                            , nMonedaPago As Integer, cGarantia As String, nCodigo_pais As Integer _
                            , cPagoCheque As String, nRutCheque As Double, dFecvenCheque As Date _
                            , nFactorVenta As Double, nForPag As Integer, nTir As Double _
                            , nTasaPact As Double, cInstser As String, nResultado As Double _
                            , nMetodologiaLCR As Integer)

    Dim DATOS()

    Envia = Array()
    AddParam Envia, gsBac_Fecp                         'Fecha de Proceso
    AddParam Envia, cSist                              'Sistema
    AddParam Envia, cTipOper                           'Producto
    AddParam Envia, nNumPantalla                       'Numero Operacion
    AddParam Envia, nNumdocu                           'Numero Documento
    AddParam Envia, nCorrela                           'Numero Correlativo
    AddParam Envia, nRut                               'Rut a Chequear
    AddParam Envia, nCodigo                            'Codigo a Chequear
    AddParam Envia, nMonto                             'Monto
    AddParam Envia, nTipCambio                         'Tipo Cambio
    AddParam Envia, Format(dFecven, feFECHA)           'Fecha Vencimiento
    AddParam Envia, gsUsuario                          'Usuario
    AddParam Envia, nRut_emisor                        'Emisor Instrumento (BTR)
    AddParam Envia, nMonedaEmision                     'Moneda Emision (BTR)
    AddParam Envia, dFecvenInst                        'Fecha Vencimiento Istrumento
    AddParam Envia, nIncodigo                          'Codigo Familia (BTR)
    AddParam Envia, cSeriado                           'Seriado S/N (BTR)
    AddParam Envia, nMonedaPago                        'Moneda Forward
    AddParam Envia, cGarantia                          '(C)Con Garantia   (S)Sin Garantia (BTR)
    AddParam Envia, nCodigo_pais                       'Codigo Pais (FWD-SPO)
    AddParam Envia, cPagoCheque                        'Pago con Cheque S/N
    AddParam Envia, nRutCheque                         'Rut a chequear en pago Chueque
    AddParam Envia, dFecvenCheque                      'Fecha Vcto linea Cheque
    AddParam Envia, nFactorVenta                       'Factor en Venta Definitiva
'    AddParam Envia, nCodEmisor                        'Codigo Emisor
    AddParam Envia, nForPag                            ' Forma de Pago VGS
    AddParam Envia, nTir                               ' Tir del Papel
    AddParam Envia, nTasaPact                          ' Tasa pacto
    AddParam Envia, cInstser                           ' Nemotecnico
    AddParam Envia, 0
    AddParam Envia, 0
    AddParam Envia, nResultado                         'PROD-10967
    AddParam Envia, nMetodologiaLCR                    'PROD-10967
    AddParam Envia, 0                                  'PROD-10967

    Lineas_ChequearGrabar = True
                        
    If Not Bac_Sql_Execute(gsBac_LineasDb & "..SP_LINEAS_CHEQUEARGRABAR", Envia) Then
        Lineas_ChequearGrabar = False
    End If
                        
End Function




Function Lineas_GrbOperacion(cSist As String, cTipOper As String, nNumPantalla As Double, nNumoper As Double, cTipoOpBCC As String, cValCheque As String, cMercado As String)

    Dim DATOS()

    Envia = Array()
    AddParam Envia, cSist                               'Sistema
    AddParam Envia, cTipOper                            'Producto
    AddParam Envia, nNumPantalla                        'Numero Pantalla
    AddParam Envia, nNumoper                            'Numero Operacion
    AddParam Envia, cTipoOpBCC                          'Tipo Operacion BCC
    AddParam Envia, cValCheque                          'Valida Cheque - BCC
    AddParam Envia, cMercado                            'Mercado Local/externo - FWD

    Lineas_GrbOperacion = True

    If Not Bac_Sql_Execute(gsBac_LineasDb & "..SP_LINEAS_GRBOPERACION", Envia) Then
            MsgBox "Error al Grabar Lineas", vbCritical, "LINEAS"
            Lineas_GrbOperacion = False
        End If
End Function


Function Lineas_ConsultaOperacion(cSist As String, cTipOper As String, nNumPantalla As Double, cTipoOpBCC As String, cValCheque As String, cMercado As String)

    Dim Mensaje_Lin1    As String
    Dim Mensaje_Lin     As String
    Dim Mensaje_Lim1    As String
    Dim Mensaje_Lim     As String


    Dim DATOS()

    Envia = Array()
    AddParam Envia, cSist                               'Sistema
    AddParam Envia, cTipOper                            'Producto
    AddParam Envia, nNumPantalla                        'Numero Pantalla
    AddParam Envia, cTipoOpBCC                          'Tipo Operacion BCC
    AddParam Envia, cValCheque                          'Valida Cheque - BCC
    AddParam Envia, cMercado                            'Mercado Local/externo - FWD


    Lineas_ConsultaOperacion = ""

    Mensaje_Lin1 = ""
    Mensaje_Lin = ""
    Mensaje_Lim1 = ""
    Mensaje_Lim = ""

                        
    If Bac_Sql_Execute("SP_LINEAS_CONSULTAROPERACION", Envia) Then

         Do While Bac_SQL_Fetch(DATOS())

            If DATOS(1) = "LIN" Then

               Mensaje_Lin = Mensaje_Lin & DATOS(3)

               If CDbl(DATOS(4)) > 0 Then
                  Mensaje_Lin = Mensaje_Lin & " En " & Format(CDbl(DATOS(4)), FEntero)
               End If
               Mensaje_Lin = Mensaje_Lin & Chr(10) & Chr(13)
                  
               Mensaje_Lin1 = vbCrLf & vbCrLf & "Problemas Lineas: " & vbCrLf & vbCrLf
            End If


            If DATOS(1) = "LIM" Then

               Mensaje_Lim = Mensaje_Lim & DATOS(3)

               If CDbl(DATOS(4)) > 0 Then
                  Mensaje_Lim = Mensaje_Lim & " En " & Format(CDbl(DATOS(4)), FEntero)
               End If
               Mensaje_Lim = Mensaje_Lim & Chr(10) & Chr(13)

               Mensaje_Lim1 = vbCrLf & vbCrLf & "Problemas Lineas: " & vbCrLf & vbCrLf
            End If


         Loop


         Lineas_ConsultaOperacion = Mensaje_Lin1 & Mensaje_Lin & Mensaje_Lim1 & Mensaje_Lim


    End If

End Function






Function Lineas_BorraConsultaOperacion(cSist As String, nNumPantalla As Double)

Dim Mensaje_Lin1    As String
Dim Mensaje_Lin     As String
Dim Mensaje_Lim1    As String
Dim Mensaje_Lim     As String

Dim DATOS()

Envia = Array()
AddParam Envia, cSist                               'Sistema
AddParam Envia, nNumPantalla                        'Numero Pantalla
                    
If Not Bac_Sql_Execute("SP_LINEAS_BORRARCONSULTAROPERACION", Envia) Then
    MsgBox "'SP_LINEAS_BORRARCONSULTAROPERACION' , Error al Eliminar Registro Temporal", vbCritical, "LINEAS"
     
End If

End Function


Function ControlArt84(nRutcli As Double, _
                      nCodigo_Cliente As Double, _
                      nMonto As Double, _
                      dFechaOrigen As Date, _
                      dFechaVcto As Date, _
                      nNumoper As Double, _
                      nCorrela As Double, _
                      cTipOper As String) As Boolean
Dim DATOS()



    ControlArt84 = False

    Envia = Array()
    AddParam Envia, nRutcli
    AddParam Envia, nCodigo_Cliente
    AddParam Envia, "BTR"
    AddParam Envia, dFechaOrigen
    AddParam Envia, dFechaVcto
    AddParam Envia, nNumoper
    AddParam Envia, nCorrela
    AddParam Envia, nMonto
    AddParam Envia, cTipOper

    If Not Bac_Sql_Execute(gsBac_LineasDb & "..SP_CONTROL_ENDEUDAMIENTO", Envia) Then
       MsgBox "'sp_control_Endeudamiento' , Problemas en Procedimiento", vbCritical, TITSISTEMA

    End If

    Do While Bac_SQL_Fetch(DATOS())

        If DATOS(1) = "OK" Then
           ControlArt84 = True
        Else
           
           MsgBox "Excede Límite Normativo Art.84." & vbCrLf _
                & "Se excede Art84 en : " & Format(CDbl(DATOS(2)), FEntero) & vbCrLf _
                & DATOS(3) & vbCrLf _
                & "Se excede Art84 en : " & Format(CDbl(DATOS(4)), FEntero) & vbCrLf _
                & DATOS(5) & vbCrLf _
                & "No se Puede Realizar la Operación", vbCritical, TITSISTEMA
           
        End If

    Loop

End Function


