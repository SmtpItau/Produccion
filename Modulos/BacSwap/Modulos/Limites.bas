Attribute VB_Name = "Limites"
Function Limites_Error(cSist As String, nNumoper As Double)

    Dim Mensaje1    As String
    Dim Mensaje     As String
    Dim Datos()

    Mensaje = ""
            
    Envia = Array()
    AddParam Envia, cSist
    AddParam Envia, nNumoper
    If Bac_Sql_Execute(gsBac_LineasDb & "..SP_LIMITES_CHEQUEARERROR", Envia) Then
    'If Bac_Sql_Execute("Sp_Limites_ChequearError", Envia) Then
            
''''        Do While Bac_SQL_Fetch(Datos())
''''            Mensaje = Mensaje & Datos(1)
''''            If CDbl(Datos(2)) > 0 Then
''''                Mensaje = Mensaje & " " & Format(CDbl(Datos(2)), FEntero)
''''            End If
''''            Mensaje = Mensaje & Chr(10) & Chr(13)
''''
''''            Mensaje1 = vbCrLf & vbCrLf & vbCrLf & "Problemas Limites Usuarios: " & vbCrLf & vbCrLf
''''        Loop
                
    End If
    
    Limites_Error = Mensaje1 & Mensaje

End Function


'prd19111 ini
Function Limites_Valida_Comder() As String
Dim swt As String

    If Bac_Sql_Execute("BDBOMESA..COMDER_Valida_Comder_MFCA") Then
         Do While Bac_SQL_Fetch(Datos())
            swt = Datos(1)
         Loop
    End If
    
    Limites_Valida_Comder = swt

End Function
'prd19111 fin

Function Lineas_Error(cSist As String, nNumoper As Double)

    Dim Mensaje1    As String
    Dim Mensaje     As String
    Dim Datos()

    Mensaje = ""
            
    Envia = Array()
    AddParam Envia, cSist
    AddParam Envia, nNumoper
    If Bac_Sql_Execute(gsBac_LineasDb & "..SP_LINEAS_GRABARERROR", Envia) Then
    'If Bac_Sql_Execute("Sp_Lineas_GrabarError", Envia) Then
            
        Do While Bac_SQL_Fetch(Datos())
            Mensaje = Mensaje & Datos(1)
            If CDbl(Datos(2)) > 0 Then
                Mensaje = Mensaje & " " & Format(CDbl(Datos(2)), Fentero)
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

Function Lineas_Anular(cSist As String, nNumoper As Long) As Boolean

    Dim Datos()
                    
    Envia = Array()
    AddParam Envia, gsBAC_Fecp
    AddParam Envia, cSist
    AddParam Envia, nNumoper
                            
    Lineas_Anular = True
    If Not Bac_Sql_Execute(gsBac_LineasDb & "..SP_LINEAS_ANULA", Envia) Then
    'If Not Bac_Sql_Execute("Sp_Lineas_Anula", Envia) Then
        Lineas_Anular = False
    End If
    
End Function

Function Lineas_Chequear(cSist As String, cTipOper As String, nNumPantalla As Double, cTipoOpBCC As String, cValCheque As String, cMercado As String)

    Dim Datos()

    Envia = Array()
    AddParam Envia, cSist                               'Sistema
    AddParam Envia, cTipOper                            'Producto
    AddParam Envia, nNumPantalla                        'Numero Pantalla
    AddParam Envia, cTipoOpBCC                          'Tipo Operacion BCC
    AddParam Envia, cValCheque                          'Valida Cheque - BCC
    AddParam Envia, cMercado                            'Mercado Local/externo - FWD


    Lineas_Chequear = ""
    If Bac_Sql_Execute(gsBac_LineasDb & "..SP_LINEAS_CHEQUEAR", Envia) Then
    'If Bac_Sql_Execute("Sp_Lineas_Chequear", Envia) Then
        Do While Bac_SQL_Fetch(Datos())
           Lineas_Chequear = Lineas_Chequear & Datos(1) & vbCrLf
        Loop
    End If

End Function



Function Lineas_GrbOperacion(cSist As String, cTipOper As String, nNumPantalla As Double, nNumoper As Double, cTipoOpBCC As String, cValCheque As String, cMercado As String)

    Dim Datos()

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
    'If Not Bac_Sql_Execute("Sp_Lineas_GrbOperacion", Envia) Then
        MsgBox "Error al Grabar Lineas", vbCritical, "LINEAS"
        Lineas_GrbOperacion = False
    End If

End Function


'prd19111
Function RelacionMarcaComder(cSist As String, nNumoper As Double, nReCodCliente As Integer, nRut As Long)
    Dim Datos()

    Dim iReNovacion As Integer
    
    Dim vReEstado As String
    
    Dim vReMotivRechazo As String
    
    'Dim nRut As Double
    
    'nRut = 76307486
    
    iReNovacion = 1
    vReEstado = "V"
    vReMotivRechazo = ""


    Envia = Array()
    AddParam Envia, cSist
    AddParam Envia, nNumoper
    AddParam Envia, iReNovacion
    AddParam Envia, nRut
    AddParam Envia, nReCodCliente
    AddParam Envia, vReEstado
    AddParam Envia, vReMotivRechazo


    RelacionMarcaComder = True
    
    If Not Bac_Sql_Execute("BDBOMESA..COMDER_InsertaRelacionMarcaComder", Envia) Then
        MsgBox "Error al Grabar Relacion Marca Comder", vbCritical, "LINEAS"
        RelacionMarcaComder = False
    End If

End Function
'prd19111





Function Lineas_ChequearGrabar(cSist As String, cTipOper As String, nNumPantalla As Double _
                              , nNumDocu As Double, ncorrela As Double, nRut As Double _
                              , nCodigo As Double, nMonto As Double, nTipCambio As Double _
                              , dFecven As Date, nRut_emisor As Double, nMonedaEmision As Integer _
                              , dFecvenInst As Date, nIncodigo As Integer, cSeriado As String _
                              , nMonedaPago As Integer, cGarantia As String, nCodigo_pais As Integer _
                              , cPagoCheque As String, nRutCheque As Double, dFecvenCheque As Date _
                               , nFactorVenta As Double, nFormaPago As Double, nResultado As Double _
                               , nMetodologiaLCR As Integer) 'PROD-10967

    Dim Datos()

    Envia = Array()
    AddParam Envia, gsBAC_Fecp                          'Fecha de Proceso
    AddParam Envia, cSist                               'Sistema
    AddParam Envia, cTipOper                            'Producto
    AddParam Envia, nNumPantalla                        'Numero Operacion
    AddParam Envia, nNumDocu                            'Numero Documento
    AddParam Envia, ncorrela                            'Numero Correlativo
    AddParam Envia, nRut                                'Rut a Chequear
    AddParam Envia, nCodigo                             'Codigo a Chequear
    AddParam Envia, nMonto                              'Monto
    AddParam Envia, nTipCambio                          'Tipo Cambio
    AddParam Envia, Format(dFecven, FEFecha)            'Fecha Vencimiento
    AddParam Envia, gsBAC_User                          'Usuario
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
    AddParam Envia, 0                                   'PROD-10967
    AddParam Envia, 0                                   'PROD-10967
    AddParam Envia, nResultado                          'PROD-10967
    AddParam Envia, nMetodologiaLCR                     'PROD-10967
    AddParam Envia, 0                                   'Las garantias las rescataremos en este Sp
                                                         'hasta que se normalice el sistema. 'PROD-10967
    
                        
    Lineas_ChequearGrabar = True
    If Not Bac_Sql_Execute(gsBac_LineasDb & "..SP_LINEAS_CHEQUEARGRABAR", Envia) Then
        Lineas_ChequearGrabar = False
    End If
    
End Function

Function Lineas_ConsultaOperacion(cSist As String, cTipOper As String, nNumPantalla As Double, cTipoOpBCC As String, cValCheque As String, cMercado As String)

Dim Mensaje_Lin1    As String
Dim Mensaje_Lin     As String
Dim Mensaje_Lim1    As String
Dim Mensaje_Lim     As String

Dim Datos()

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
If Bac_Sql_Execute(gsBac_LineasDb & "..SP_LINEAS_CONSULTAROPERACION", Envia) Then
'If Bac_Sql_Execute("Sp_Lineas_ConsultarOperacion", Envia) Then

     Do While Bac_SQL_Fetch(Datos())

        If Datos(1) = "LIN" Then

           Mensaje_Lin = Mensaje_Lin & Datos(3)

           If CDbl(Datos(4)) > 0 Then
              Mensaje_Lin = Mensaje_Lin & " En " & Format(CDbl(Datos(4)), Fentero)
           End If
           Mensaje_Lin = Mensaje_Lin & Chr(10) & Chr(13)
              
           Mensaje_Lin1 = vbCrLf & vbCrLf & "Problemas Lineas: " & vbCrLf & vbCrLf
        End If


        If Datos(1) = "LIM" Then

           Mensaje_Lim = Mensaje_Lim & Datos(3)

           If CDbl(Datos(4)) > 0 Then
              Mensaje_Lim = Mensaje_Lim & " En " & Format(CDbl(Datos(4)), Fentero)
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

Dim Datos()

Envia = Array()
AddParam Envia, cSist                               'Sistema
AddParam Envia, nNumPantalla                        'Numero Pantalla
                    
If Not Bac_Sql_Execute("SP_LINEAS_BORRARCONSULTAROPERACION", Envia) Then
'If Not Bac_Sql_Execute(gsBac_LineasDb & "..Sp_Lineas_BorrarConsultarOperacion", Envia) Then
    MsgBox "'SP_LINEAS_BORRARCONSULTAROPERACION' , Error al Eliminar Registro Temporal", vbCritical, "LINEAS"
     
End If

End Function

