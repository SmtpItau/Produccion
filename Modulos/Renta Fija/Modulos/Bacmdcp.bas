Attribute VB_Name = "modMDCP"
Option Explicit
Global Tipo_Carga As String * 2
    'Tipo_Carga = "MN" 'Manual
    'Tipo_Carga = "AU" 'Automatica
Global Termino_Carga As String * 2
    'Termino_Carga = "SI" 'TERMINADA
    'Termino_Carga = "NO" 'NO TERMINADA
    Const FDec2Dec = "#,##0.00"

Global gFecha_PagoMañana As String

Function CPP_GrabarTx(hForm As Form, Rutcart As String) As Double
'lRutCar&, iTipCar%, lForPagI&, sTipCus$, sRetiro$, _
'   sPagMan$, sObserv$, lRutCli&, nCodigo, hForm As Form, TCart$, Mercado$, _
'   Sucursal$, AreaResponsable$, Fecha_PagoMañana$, Laminas$, Tipo_Inversion$) As Double

'-------------------------------------------------------------------------------
'( nRutcart ,     -- rut del due¤o de cartera.-
'  cTipcart ,     -- código tipo de cartera.-
'  nForpagi ,     -- código de forma de inicio
'  cTipcust ,     -- con l mina o sin lámina.- S/N
'  cRetiro  ,     -- tipo de retiro.-          V/I
'  cPagohoy ,     -- pago hoy o ma¤ana         H/M
'  cObserva ,     -- Observaciones
'  nRutcli  ,     -- Rut del cliente
'  fCPForm  )     -- Formulario de la compra.-
'-------------------------------------------------------------------------------

On Error GoTo CPP_GrabarTxError

Dim Datos()
Dim dNumdocu    As Double
Dim iCorrela%
Dim sMascara$, sInstSer$, sGenEmi$, sNemMon$, dNominal#, dTir#, sFecpcup$
Dim dPvp#, dVPar#, dMt#, dMt100#, iNumUCup%, dTasEst#, sFecEmi$
Dim sFecVen$, sMdse$, lCodigo&, sSerie$, iMonemi%, lRutemi&
Dim dTasEmi#, iBasemi%
Dim dTirMcd#, dPvpMcd#, dMtMcd#, dMtMcd100#
Dim sFecPro$
Dim FlagTx                  As Boolean
Dim Resultado%
Dim Correlativo&
Dim CorteMin#
Dim cCustodiaDCV            As String
Dim cClaveDCV               As String
Dim cCarteraSuper           As String
'VB+- 27/06/2000 se crean estas variables para grabar en las compras propias estos datos
Dim dConvexidad             As Double
Dim dDuratMac               As Double
Dim dDuratMod               As Double
Dim iCodExeLIM              As Integer
Dim dMtoExcLIM              As Double
Dim iPlazo                  As Long     '- As Integer
Dim dMontoOriginal          As Double
Dim dTipoCambio988          As Double
Dim bExisteDPX              As Boolean


    bExisteDPX = False
    dTipoCambio988 = FUNC_BUSCA_VALOR_MONEDA(998, Format(gsBac_Fecp, "DD/MM/YYYY"))

    sFecPro = Format(gsBac_Fecp, feFECHA)
                
  ' Pone en falso indicando que todavia no se realiz un Begin Transaction
    FlagTx = False
        
    If Not Bac_Sql_Execute("BEGIN TRANSACTION") Then
        GoTo CPP_GrabarTxError
    End If
        
  ' Indica inicio de Begin Transaction y se puede hacer el RollBack
    FlagTx = True
    
  ' Consulto el número de documento de tabla mdac (Mesa Dinero Archivo Control)
    If Not Bac_Sql_Execute("SP_OPMDAC") Then
        GoTo CPP_GrabarTxError
    End If
        
  ' Recupero el Numero de Documento
    If Bac_SQL_Fetch(Datos()) Then
        dNumdocu = Val(Datos(1))
    End If
    

    '********** Linea -- Mkilo
    
    iCorrela% = 0
  ' Para cada linea de compra llamo al SP_GRABARCP
    hForm.Data1.Recordset.MoveFirst
             
    Do While Not hForm.Data1.Recordset.EOF
        
      ' Verifica que el registro esté con datos
        If Trim$(hForm.Data1.Recordset("tm_instser")) <> "" Then
                  
          ' Recupera datos del Data Control del Form enviado
            With hForm
                sMascara = .Data1.Recordset("tm_mascara")
                sInstSer = .Data1.Recordset("tm_instser")
                sGenEmi = .Data1.Recordset("tm_genemi")
                sNemMon = .Data1.Recordset("tm_nemmon")
                dNominal = .Data1.Recordset("tm_nominal")
                dTir = .Data1.Recordset("tm_tir")
                dPvp = .Data1.Recordset("tm_pvp")
                dVPar = .Data1.Recordset("tm_vpar")
                dMt = .Data1.Recordset("tm_mt")
                dMt100 = .Data1.Recordset("tm_mt100")
                dTirMcd = .Data1.Recordset("tm_tirmcd")
                dPvpMcd = .Data1.Recordset("tm_pvpmcd")
                dMtMcd = .Data1.Recordset("tm_mtmcd")
                dMtMcd100 = .Data1.Recordset("tm_mtmcd100")
                iNumUCup = .Data1.Recordset("tm_numucup")
                dTasEst = .Data1.Recordset("tm_tasest")
                sFecEmi = .Data1.Recordset("tm_fecemi")
                sFecVen = .Data1.Recordset("tm_fecven")
                sMdse = .Data1.Recordset("tm_mdse")
                lCodigo = .Data1.Recordset("tm_codigo")
                iMonemi = .Data1.Recordset("tm_monemi")
                lRutemi = .Data1.Recordset("tm_rutemi")
                dTasEmi = .Data1.Recordset("tm_tasemi")
                iBasemi = .Data1.Recordset("tm_basemi")
                sSerie = .Data1.Recordset("tm_serie")
                sFecpcup = .Data1.Recordset("tm_fecpcup")
                cCustodiaDCV = " " 'Mid$(.Data1.Recordset("tm_custodia"), 1, 1)
                
              ' VB+ 27/06/2000  Se Agregan estas variables para guardar estos datos en la grabación
              ' -------------------------------------------------------
                dConvexidad = IIf(IsNull(.Data1.Recordset("tm_convexidad")), 0, .Data1.Recordset("tm_convexidad"))
                dDuratMac = IIf(IsNull(.Data1.Recordset("tm_durationmac")), 0, .Data1.Recordset("tm_durationmac"))
                dDuratMod = IIf(IsNull(.Data1.Recordset("tm_durationmod")), 0, .Data1.Recordset("tm_durationmod"))
              ' -------------------------------------------------------
              ' VB-
                iCodExeLIM = IIf(IsNull(.Data1.Recordset("tm_codexceso")), 0, .Data1.Recordset("tm_codexceso"))
                dMtoExcLIM = IIf(IsNull(.Data1.Recordset("tm_mtoexceso")), 0, .Data1.Recordset("tm_mtoexceso"))
                iPlazo = DateDiff("D", Format(gsBac_Fecp, "dd/mm/yyyy"), Format$(sFecVen, "dd/mm/yyyy"))
                cCarteraSuper = IIf(IsNull(.Data1.Recordset("tm_carterasuper")), "T", .Data1.Recordset("tm_carterasuper"))
            End With
            
            iCorrela% = iCorrela% + 1
            
            
            Envia = Array()
            AddParam Envia, CDbl(Rutcart) 'colocar
            AddParam Envia, CDbl(1) 'colocar
            AddParam Envia, dNumdocu
            AddParam Envia, CDbl(iCorrela)
            AddParam Envia, sMascara
            AddParam Envia, sInstSer
            AddParam Envia, sGenEmi
            AddParam Envia, sNemMon
            AddParam Envia, dNominal
            AddParam Envia, dTir
            AddParam Envia, dPvp
            AddParam Envia, dVPar
            AddParam Envia, dMt
            AddParam Envia, CDbl(iNumUCup)
            AddParam Envia, 0
            AddParam Envia, 0
            AddParam Envia, Format(gsBac_Fecp, feFECHA)
            AddParam Envia, dTasEst
            AddParam Envia, Format(sFecEmi, feFECHA)
            AddParam Envia, Format(sFecVen, feFECHA)
            AddParam Envia, sMdse
            AddParam Envia, CDbl(lCodigo)
            AddParam Envia, sSerie
            AddParam Envia, CDbl(iMonemi)
            AddParam Envia, CDbl(lRutemi)
            AddParam Envia, dTasEmi
            AddParam Envia, CDbl(iBasemi)
            AddParam Envia, 0
            AddParam Envia, 0
            AddParam Envia, 0
            AddParam Envia, gsUsuario
            AddParam Envia, gsTerminal
            AddParam Envia, Format(sFecpcup, feFECHA)
            AddParam Envia, " "
            AddParam Envia, " "
            AddParam Envia, dConvexidad
            AddParam Envia, dDuratMac
            AddParam Envia, dDuratMod
            AddParam Envia, " "   'Este es el Codigo de Categoría Cartera Super
            AddParam Envia, " "
            AddParam Envia, " "
            AddParam Envia, " "
            AddParam Envia, "BTR"
            AddParam Envia, " "
            AddParam Envia, " "
            AddParam Envia, " "
                    
            If Not Bac_Sql_Execute("SP_GRABARCP_PASIVO", Envia) Then
                GoTo CPP_GrabarTxError
            End If
                               
'            CorteMin# = hForm.Data1.Recordset("tm_cortemin")
'            Correlativo = hForm.Data1.Recordset("tm_correlativo")
'
'            If CO_GrabarCortesSQL(0, dNumdocu, iCorrela, dNominal, Correlativo, CorteMin#) = False Then
'                GoTo CP_GrabarTxError
'            End If
'
        End If
                            
        hForm.Data1.Recordset.MoveNext
             
    Loop
    
    
    
    
    If bExisteDPX Then
        dMontoOriginal = BacIrfGr.proMtoOper * dTipoCambio988
    Else
        dMontoOriginal = BacIrfGr.proMtoOper
    End If
                   
    If Not Bac_Sql_Execute("COMMIT TRANSACTION") Then
        GoTo CPP_GrabarTxError
    End If
   'log_auditoria
    
    Valor_antiguo = " "
    Valor_antiguo = "Operacion:" & dNumdocu & ";CPP;" & "Rut Cliente:" & 0 & ";Codigo Cliente:" & 0 & ";Forma de Pago Inicio:" & 0 & ";Forma de Pago Venc:0;Tasa Pacto:0"
    
    Call GRABA_LOG_AUDITORIA(1, gsBac_Fecp, gsBac_IP, gsBac_User, _
            "BTR", "Opc_20100", "01", "Compra Definitiva", "mdcp,mdmo,mddi", Valor_antiguo, " ")

    Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Operación de compra propia número: " & dNumdocu & ", grabada con éxito.")
   
    CPP_GrabarTx = dNumdocu
   
    Exit Function
        
        
CPP_GrabarTxError:

    MsgBox "Se ha producido un problema en la grabación de la operación de compra: " & err.Description & ". Comunique al Administrador. ", vbCritical, gsBac_Version
   
        
    If FlagTx = True Then
        If Not Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
            MsgBox "No se pudo realizar devolución de transacción inicializada", vbCritical, gsBac_Version
        End If
    End If
   
    CPP_GrabarTx = 0
    Exit Function
End Function


Public Sub CP_Agregar(hWnd As Long, Data1 As Control)

  ' Agrega un registro en blanco a la Tabla MDCP
    
    Data1.Recordset.AddNew
    Data1.Recordset("tm_hwnd") = hWnd
    Data1.Recordset("tm_codexceso") = 0
    Data1.Recordset("tm_tcml") = 1
   ' VB +- 09/06/2000 se debe dejar vacio  por cambio de revision
  '  data1.Recordset("tm_custodia") = "PROPIA" ' VB+- 18/02/2000 se deja para custodia
    Call CP_Limpiar(Data1)
    Data1.Recordset.Update
    
    Data1.Recordset.MoveLast
    
End Sub


Public Sub CP_BorrarTx(hWnd As Long)
   
   'Limpia datos de la tabla de compras propias
    db.Execute "DELETE * FROM mdcp WHERE tm_hwnd = " & hWnd
    
   'Limpia datos de la tabla de cortes
    db.Execute "DELETE * FROM mdco WHERE tm_hwnd = " & hWnd

End Sub

Public Function CP_ChkSerie(cInstser As String, Data1 As Control) As Boolean
Dim Sal As BacTypeChkSerie

    CP_ChkSerie = False
       
    If CPCI_ChkSerie(cInstser, Sal) = True Then
        If Sal.nerror = 0 Then
            Data1.Recordset.Edit
            Call CP_Limpiar(Data1)
            Data1.Recordset("tm_mascara") = Sal.cMascara
            Data1.Recordset("tm_codigo") = Sal.nCodigo
            Data1.Recordset("tm_serie") = Sal.nSerie
            Data1.Recordset("tm_rutemi") = Sal.nRutemi
            Data1.Recordset("tm_monemi") = Sal.nMonemi
            Data1.Recordset("tm_tasemi") = Sal.fTasemi
            Data1.Recordset("tm_basemi") = Sal.fBasemi
            Data1.Recordset("tm_fecemi") = Sal.dFecemi
            Data1.Recordset("tm_fecven") = Sal.dFecven
            Data1.Recordset("tm_refnomi") = Sal.cRefnomi
            Data1.Recordset("tm_genemi") = Sal.cGenemi
            Data1.Recordset("tm_nemmon") = Sal.cNemmon
            Data1.Recordset("tm_cortemin") = Sal.nCorMin
            Data1.Recordset("tm_mdse") = Sal.cSeriado
            Data1.Recordset("tm_leeemi") = Sal.cLeeEmi
            Data1.Recordset("tm_valmcd") = "N"
            Data1.Recordset.Update
            
            
            
            CP_ChkSerie = True
        End If
    Else
'        CP_ChkSerie = False
    End If
    

End Function
Public Sub CP_Eliminar(Data1 As Control)
Dim FormHandle&, Correlativo&


    FormHandle& = Data1.Recordset("tm_hwnd")
    Correlativo& = Data1.Recordset("tm_correlativo")
    
    Call CO_EliminarCortesMDB(FormHandle&, Correlativo&)

    If Data1.Recordset.RecordCount > 1 Then
        Data1.Recordset.Delete
    Else
        Data1.Recordset.Edit
        Call CP_Limpiar(Data1)
        Data1.Recordset.Update
    End If

End Sub

Public Sub CP_Eliminar2(Data1 As Control, indice As Integer)
    On Error GoTo indice
    
    Dim FormHandle&, Correlativo&
    Dim Criterio As String
    
    FormHandle& = Data1.Recordset("tm_hwnd")
    Correlativo& = Data1.Recordset("tm_correlativo")
    
    Criterio = " tm_correlativo = " & indice & " and  tm_hwnd = " & FormHandle&
    
    Call CO_EliminarCortesMDB(FormHandle&, Correlativo&)

    Data1.Recordset.MoveFirst
    
    Data1.Recordset.FindNext Criterio
    
    Do While Not Data1.Recordset.NoMatch

        If Not Data1.Recordset.NoMatch Then
                Data1.Recordset.Delete 'Borrar registro
            Exit Do
        End If

        Data1.Recorset.FindNext Criterio

    Loop

    If Data1.Recordset.RecordCount = 1 Then
        Data1.Recordset.Edit
        Call CP_Limpiar(Data1)
        Data1.Recordset.Update
    End If

    'Data1.Recordset.MoveLast
    
    BacControlWindows (10)
    
indice:
    
    If err.Number <> 0 Then
        MsgBox err.Number & " " & err.Description, vbExclamation, TITSISTEMA
    End If
    
    
End Sub

'MODIFICADO PARA LD|-COR-035 IMPLEMENTAR CARTERA VOLCKER RULE
Function CP_GrabarTx(lRutCar&, iTipCar%, lForPagI&, sTipCus$, sRetiro$, _
   sPagMan$, sObserv$, lRutCli&, nCodigo, hForm As Form, TCart$, Mercado$, _
   Sucursal$, AreaResponsable$, Fecha_PagoMañana$, Laminas$, Tipo_Inversion$, CodCorresponsal$, Libro$, Volcker_Rule$, Rentabilidad$, Ejecutivo$, dFechaCustHasta, Scomi) As Double

'-------------------------------------------------------------------------------
'( nRutcart ,     -- rut del due¤o de cartera.-
'  cTipcart ,     -- código tipo de cartera.-
'  nForpagi ,     -- código de forma de inicio
'  cTipcust ,     -- con l mina o sin lámina.- S/N
'  cRetiro  ,     -- tipo de retiro.-          V/I
'  cPagohoy ,     -- pago hoy o ma¤ana         H/M
'  cObserva ,     -- Observaciones
'  nRutcli  ,     -- Rut del cliente
'  fCPForm  )     -- Formulario de la compra.-
'-------------------------------------------------------------------------------

On Error GoTo CP_GrabarTxError
Dim Datos()
Dim dNumdocu    As Double
Dim iCorrela%
Dim sMascara$, sInstSer$, sGenEmi$, sNemMon$, dNominal#, dTir#, sFecpcup$
Dim dPvp#, dVPar#, dMt#, dMt100#, iNumUCup%, dTasEst#, sFecEmi$
Dim sFecVen$, sMdse$, lCodigo&, sSerie$, iMonemi%, lRutemi&
Dim dTasEmi#, iBasemi%
Dim dTirMcd#, dPvpMcd#, dMtMcd#, dMtMcd100#
Dim dDifTran_MO#, dDifTran_CLP#, nTipoCambio As Double
Dim sFecPro$
Dim FlagTx                  As Boolean
Dim Resultado%
Dim Correlativo&
Dim CorteMin#
Dim cCustodiaDCV            As String
Dim cClaveDCV               As String
Dim cCarteraSuper           As String
'VB+- 27/06/2000 se crean estas variables para grabar en las compras propias estos datos
Dim dConvexidad             As Double
Dim dDuratMac               As Double
Dim dDuratMod               As Double
Dim iCodExeLIM              As Integer
Dim dMtoExcLIM              As Double
Dim iPlazo                  As Long      '- As Integer
Dim dMontoOriginal          As Double
Dim dTipoCambio988          As Double
Dim bExisteDPX              As Boolean
Dim Mensaje_Lim             As String
Dim Mensaje_Lin             As String
Dim Mens_Lim_Graba          As String
Dim Mens_Lin_Graba          As String

'--- para el control de precios y tasas
Dim ptCodInst               As String
Dim ptPlazo                 As Long     '- As Integer
Dim ptTasa                  As Double
Dim resControlPT            As String
Dim Mensaje_CPT             As String

    bExisteDPX = False
    dTipoCambio988 = FUNC_BUSCA_VALOR_MONEDA(998, Format(gsBac_Fecp, "DD/MM/YYYY"))

    sFecPro = Format(gsBac_Fecp, feFECHA)
                
  ' Pone en falso indicando que todavia no se realiz un Begin Transaction
    FlagTx = False
        
    If Not Bac_Sql_Execute("BEGIN TRANSACTION") Then
        GoTo CP_GrabarTxError
    End If
        
  ' Indica inicio de Begin Transaction y se puede hacer el RollBack
    FlagTx = True
    
  ' Consulto el número de documento de tabla mdac (Mesa Dinero Archivo Control)
    If Not Bac_Sql_Execute("SP_OPMDAC") Then
        GoTo CP_GrabarTxError
    End If
        
  ' Recupero el Numero de Documento
    If Bac_SQL_Fetch(Datos()) Then
        dNumdocu = Val(Datos(1))
    End If
    
    
    If Trim$(hForm.Data1.Recordset("tm_instser")) = "FMUTUO" Then
        hForm.Data1.Recordset.MoveFirst
       
  '  If Trim$(hForm.Data1.Recordset("tm_instser")) = "FMUTUO" Then
  '      hForm.Data1.Recordset.MoveFirst
        Do While Not hForm.Data1.Recordset.EOF
        
            hForm.Data1.Recordset.Edit
            hForm.Data1.Recordset("tm_rutemi") = lRutCli
            hForm.Data1.Recordset("tm_codemi") = nCodigo
            hForm.Data1.Recordset.Update
            
            hForm.Data1.Recordset.MoveNext
            
        Loop
    End If

    '********** Linea -- Mkilo
    If gsBac_Lineas = "S" Then

        Dim Mensaje     As String
        Dim SwResp      As Integer
        Dim TCambio     As Double
        Dim nMonto As Double
        Dim dFecvcto As Date
        Dim nRutemi  As Double
        Dim nMonemi  As Integer
        Dim ncodigo1 As Integer
        Dim nTir As Double
        Dim xSeriado As String
        Dim xSer As String
        Dim dMontoCorrela   As Double
        

        Mensaje = ""
        hForm.Data1.Recordset.MoveFirst
        iCorrela% = 0
                 
        Do While Not hForm.Data1.Recordset.EOF
        
            If Trim$(hForm.Data1.Recordset("tm_instser")) <> "" Then
            
                iCorrela% = iCorrela% + 1
                
                If Mid(Trim$(hForm.Data1.Recordset("tm_instser")), 1, 3) = "DPX" Then
                    TCambio = 0
                Else
                    TCambio = gsBac_TCambio
                End If
                
                nMonto = nMonto + hForm.Data1.Recordset("tm_mt")
                dFecvcto = hForm.Data1.Recordset("tm_fecven")
                nRutemi = hForm.Data1.Recordset("tm_rutemi")
                nMonemi = hForm.Data1.Recordset("tm_monemi")
                ncodigo1 = hForm.Data1.Recordset("tm_codigo")
                nTir = hForm.Data1.Recordset("tm_tir")
                xSeriado = hForm.Data1.Recordset("tm_instser")
                xSer = hForm.Data1.Recordset("tm_mdse")
            
                Let dMontoCorrela = hForm.Data1.Recordset("tm_mt")
                
                If Not Lineas_ChequearGrabar("BTR", "CP ", dNumdocu, dNumdocu, CDbl(iCorrela), CDbl(lRutCli), CDbl(nCodigo), CDbl(dMontoCorrela), TCambio, dFecvcto, nRutemi, nMonemi, dFecvcto, ncodigo1, xSer, nMonemi, "C", 0, "N", 0, gsBac_Fecp, 0, CDbl(lForPagI), CDbl(nTir), 0, xSeriado) Then
                    GoTo CP_GrabarTxError
                End If

            End If
            
            
            hForm.Data1.Recordset.MoveNext
        Loop
        
'        If Not Lineas_ChequearGrabar("BTR", "CP ", dNumdocu, dNumdocu, CDbl(iCorrela), CDbl(lRutCli), CDbl(nCodigo), CDbl(nMonto), TCambio, dFecvcto, nRutemi, nMonemi, dFecvcto, ncodigo1, xSer, nMonemi, "C", 0, "N", 0, gsBac_Fecp, 0, CDbl(lForPagI), CDbl(nTir), 0, xSeriado) Then
'            GoTo CP_GrabarTxError
'        End If
        
        Mensaje = Mensaje & Lineas_Chequear("BTR", "CP ", dNumdocu, " ", " ", " ")
        
        If Mensaje <> "" Then
        
            MsgBox "Error al Chequear Lineas : " + Chr(10) + Chr(13) + Chr(10) + Chr(13) + Mensaje, vbCritical
            
            If FlagTx = True Then
                If Not Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
                    MsgBox "No se pudo realizar devolución de transacción inicializada", vbCritical, gsBac_Version
                End If
            End If

            CP_GrabarTx = 0
            
            Exit Function
            
        End If
    
    End If
    
    '********** Fin
   
    iCorrela% = 0
  ' Para cada linea de compra llamo al SP_GRABARCP
    hForm.Data1.Recordset.MoveFirst
   Dim X, maxfilas As Integer 'ARM PRD12311
   Dim Nominal#
   Dim tir As Double
   Dim Serie         As String
             
    With BacCP.Table1 'verifica que operaciones seran grabadas
    maxfilas = BacCP.Table1.Rows - 1 'ARM PRD12311
'     For X = 1 To BacCP.Table1.Rows - 1
      '-> Se incorporo en Proyecto de Mejoras Balance. El cual funciona mal cuando se ingresan dos Series iguales seguidas con igual nocional y tir. Duplicando los Registros

         Let X = 0
    
'ARM PRD12311
     If maxfilas > X Then
        Let X = 1
     End If
    
    Do While Not hForm.Data1.Recordset.EOF
    'ARM PRD12311
    If maxfilas >= X Then
'     Let x = 1
'    End If

    Nominal = BacCP.Table1.TextMatrix(X, 2)
    tir = BacCP.Table1.TextMatrix(X, 3)
    Serie = BacCP.Table1.TextMatrix(X, 0)
                  
            If Trim$(hForm.Data1.Recordset("tm_instser")) = Serie _
               And Trim$(hForm.Data1.Recordset("tm_tir")) = tir _
           And Trim$(hForm.Data1.Recordset("tm_nominal")) = Nominal Then

          ' Recupera datos del Data Control del Form enviado
            With hForm
                sMascara = .Data1.Recordset("tm_mascara")
                sInstSer = .Data1.Recordset("tm_instser")
                sGenEmi = .Data1.Recordset("tm_genemi")
                sNemMon = .Data1.Recordset("tm_nemmon")
                dNominal = .Data1.Recordset("tm_nominal")
                dTir = .Data1.Recordset("tm_tir")
                dPvp = .Data1.Recordset("tm_pvp")
                dVPar = .Data1.Recordset("tm_vpar")
                dMt = .Data1.Recordset("tm_mt")
                dMt100 = .Data1.Recordset("tm_mt100")
                dTirMcd = 0 ''''.Data1.Recordset("tm_tirmcd")
                dPvpMcd = 0 ''''.Data1.Recordset("tm_pvpmcd")
                dMtMcd = 0 ''''.Data1.Recordset("tm_mtmcd")
                dMtMcd100 = .Data1.Recordset("tm_mtmcd100")
                iNumUCup = .Data1.Recordset("tm_numucup")
                dTasEst = .Data1.Recordset("tm_tasest")
                sFecEmi = .Data1.Recordset("tm_fecemi")
                sFecVen = .Data1.Recordset("tm_fecven")
                sMdse = .Data1.Recordset("tm_mdse")
                lCodigo = .Data1.Recordset("tm_codigo")
                iMonemi = .Data1.Recordset("tm_monemi")
                lRutemi = .Data1.Recordset("tm_rutemi")
                dTasEmi = .Data1.Recordset("tm_tasemi")
                iBasemi = .Data1.Recordset("tm_basemi")
                sSerie = .Data1.Recordset("tm_serie")
                sFecpcup = .Data1.Recordset("tm_fecpcup")
                cCustodiaDCV = Mid$(.Data1.Recordset("tm_custodia"), 1, 1)
                
                If lRutCli = "97029000" Then
                    cClaveDCV = " "
                Else
                    cClaveDCV = IIf(IsNull(.Data1.Recordset("tm_clave_dcv")), "", .Data1.Recordset("tm_clave_dcv"))
                End If
                
              ' VB+ 27/06/2000  Se Agregan estas variables para guardar estos datos en la grabación
              ' -------------------------------------------------------
                dConvexidad = IIf(IsNull(.Data1.Recordset("tm_convexidad")), 0, .Data1.Recordset("tm_convexidad"))
                dDuratMac = IIf(IsNull(.Data1.Recordset("tm_durationmac")), 0, .Data1.Recordset("tm_durationmac"))
                dDuratMod = IIf(IsNull(.Data1.Recordset("tm_durationmod")), 0, .Data1.Recordset("tm_durationmod"))
              ' -------------------------------------------------------
              ' VB-
                iCodExeLIM = IIf(IsNull(.Data1.Recordset("tm_codexceso")), 0, .Data1.Recordset("tm_codexceso"))
                dMtoExcLIM = IIf(IsNull(.Data1.Recordset("tm_mtoexceso")), 0, .Data1.Recordset("tm_mtoexceso"))
                iPlazo = DateDiff("D", Format(gsBac_Fecp, "dd/mm/yyyy"), Format$(sFecVen, "dd/mm/yyyy"))
                cCarteraSuper = IIf(IsNull(.Data1.Recordset("tm_carterasuper")), "SC", .Data1.Recordset("tm_carterasuper"))
                
                nTipoCambio = 0
                nTipoCambio = funcBuscaTipcambio(.Data1.Recordset!tm_monemi, gsBac_Fecp)
                
                dTirMcd# = .Data1.Recordset("tm_tirmcd")
                dPvpMcd# = .Data1.Recordset("tm_pvpmcd")
                dMtMcd# = .Data1.Recordset("tm_mtmcd")
                                
                dDifTran_MO# = Str((.Data1.Recordset("tm_mt") - .Data1.Recordset("tm_mtmcd")))
                dDifTran_CLP# = Str(((.Data1.Recordset("tm_mt") - .Data1.Recordset("tm_mtmcd")) * nTipoCambio))
            End With
            
            iCorrela% = iCorrela% + 1
            
            Envia = Array()
            AddParam Envia, CDbl(lRutCar)
            AddParam Envia, CDbl(iTipCar)
            AddParam Envia, dNumdocu
            AddParam Envia, CDbl(iCorrela)
            AddParam Envia, sMascara
            AddParam Envia, sInstSer
            AddParam Envia, sGenEmi
            AddParam Envia, sNemMon
            AddParam Envia, dNominal
            AddParam Envia, dTir
            AddParam Envia, dPvp
            AddParam Envia, dVPar
            AddParam Envia, dMt
            AddParam Envia, CDbl(iNumUCup)
            AddParam Envia, CDbl(lRutCli)
            AddParam Envia, CDbl(nCodigo)
            AddParam Envia, Format(gsBac_Fecp, feFECHA)
            AddParam Envia, dTasEst
            AddParam Envia, Format(sFecEmi, feFECHA)
            AddParam Envia, Format(sFecVen, feFECHA)
            AddParam Envia, sMdse
            AddParam Envia, CDbl(lCodigo)
            AddParam Envia, sSerie
            AddParam Envia, CDbl(iMonemi)
            AddParam Envia, CDbl(lRutemi)
            AddParam Envia, dTasEmi
            AddParam Envia, CDbl(iBasemi)
            AddParam Envia, sTipCus
            AddParam Envia, CDbl(lForPagI)
            AddParam Envia, sRetiro
            AddParam Envia, gsUsuario
            AddParam Envia, gsTerminal
            AddParam Envia, Format(sFecpcup, feFECHA)
            AddParam Envia, cCustodiaDCV
            AddParam Envia, IIf(Trim(cCustodiaDCV) <> "D", "", cClaveDCV)
            AddParam Envia, dConvexidad
            AddParam Envia, dDuratMac
            AddParam Envia, dDuratMod
            AddParam Envia, cCarteraSuper   'Este es el Codigo de Categoría Cartera Super
            AddParam Envia, TCart
            AddParam Envia, Mercado
            AddParam Envia, Sucursal
            AddParam Envia, AreaResponsable
            AddParam Envia, Format(Fecha_PagoMañana, feFECHA)
            AddParam Envia, Laminas
            AddParam Envia, Tipo_Inversion
            AddParam Envia, sObserv$
            AddParam Envia, CodCorresponsal$
            AddParam Envia, dNominal
            AddParam Envia, Libro$
            
            AddParam Envia, CDbl(dTirMcd)       '@nTirTran
            AddParam Envia, dPvpMcd             '@nPvpTran
            AddParam Envia, dMtMcd              '@nVpTran
            AddParam Envia, CDbl(dDifTran_MO)   '@Dif_Tran_MO
            AddParam Envia, dDifTran_CLP        '@Dif_Tran_CLP
            
            AddParam Envia, Ejecutivo '''''''''''''''''''@Ejecutivo
            AddParam Envia, Rentabilidad ''''''''''''''''''@Rentabilidad
            'AddParam Envia, cTipCust '''''''''''''''''''@cTipoCustodia
            'AddParam Envia, sPagMan '''''''''''''''''''@cpago_hoy
           '' AddParam Envia, sObserv '''''''''''''''''''''''@observ
            'AddParam Envia, lForPagI& '''''''''''''''''''''''@nForPago
            AddParam Envia, Scomi ''''''''''''''''''''''''''''''@comi
            AddParam Envia, dFechaCustHasta ''''''''''@dFechaCusH
            
            AddParam Envia, Volcker_Rule$

            If Not Bac_Sql_Execute("SP_GRABARCP", Envia) Then
                GoTo CP_GrabarTxError
            End If
            X = X + 1 'ARM PRD12311
            CorteMin# = hForm.Data1.Recordset("tm_cortemin")
            Correlativo = hForm.Data1.Recordset("tm_correlativo")
                   
            If CO_GrabarCortesSQL(lRutCar, dNumdocu, iCorrela, dNominal, Correlativo, CorteMin#) = False Then
                GoTo CP_GrabarTxError
            End If
        End If
         End If 'ARM PRD12311
        hForm.Data1.Recordset.MoveNext
    Loop

'        hForm.Data1.Recordset.MoveFirst
'     Next X
  
  End With
    '********** Linea -- Mkilo
    If gsBac_Lineas = "S" Then
    
        If Not Lineas_GrbOperacion("BTR", "CP ", dNumdocu, dNumdocu, " ", " ", " ") Then
            GoTo CP_GrabarTxError
        End If
        
        If MarcaAplicaLinea = 1 Then
            '+++CONTROL IDD, jcamposd llamada a nuevo control IDD para las líneas
            iCorrela% = 1
            'Para cada linea de compra llamamos al IDD
            hForm.Data1.Recordset.MoveFirst
            Do While Not hForm.Data1.Recordset.EOF
                   
                Dim oParametrosLinea As New clsControlLineaIDD
    
                With oParametrosLinea
                    .Modulo = "BTR"
                    .Producto = "CP"
                    .Operacion = dNumdocu
                    .Documento = dNumdocu
                    .Correlativo = iCorrela%
                    .Accion = "Y"
    
                    .RecuperaDatosLineaIDD
                    
                    .MontoArticulo84 = hForm.Data1.Recordset("tm_mt") ' debe enviar el valor presente
                    
                    .EjecutaProcesoWsLineaIDD
                    
                End With
                Set oParametrosLinea = Nothing
                On Error GoTo seguirGrabacion
                
                iCorrela% = iCorrela% + 1
                hForm.Data1.Recordset.MoveNext
            Loop
            '---CONTROL IDD, jcamposd llamada a nuevo control IDD para las líneas
        End If
        
seguirGrabacion:
        
         Mensaje_Lin = ""
         Mensaje_Lim = ""
         Mens_Lin_Graba = ""
         Mens_Lim_Graba = ""
         If gsBac_Lineas = "S" Then
           ' Mensaje_Lin = Lineas_Error("BCC", nNumoper)
            'Mensaje_Lim = Limites_Error("BCC", nNumoper)
            Mens_Lin_Graba = Mensaje_Lin
            Mens_Lim_Graba = Mensaje_Lim
            Mens_Lin_Graba = Replace(Mens_Lin_Graba, vbCrLf, "")
            Mens_Lin_Graba = Replace(Mens_Lin_Graba, Chr(10), "")
            Mens_Lin_Graba = Replace(Mens_Lin_Graba, "Problemas Lineas: ", "")
            Mens_Lim_Graba = Replace(Mens_Lim_Graba, vbCrLf, "")
            Mens_Lim_Graba = Replace(Mens_Lim_Graba, Chr(10), "")
            Mens_Lim_Graba = Replace(Mens_Lim_Graba, "Problemas Limites ", "")
         End If
    End If
    '********** Fin
    
    
    If bExisteDPX Then
        dMontoOriginal = BacIrfGr.proMtoOper * dTipoCambio988
    Else
        dMontoOriginal = BacIrfGr.proMtoOper
    End If
                   
    If Not Bac_Sql_Execute("COMMIT TRANSACTION") Then
        GoTo CP_GrabarTxError
    End If
   'log_auditoria
    
    Valor_antiguo = " "
    Valor_antiguo = "Operacion:" & dNumdocu & ";CP;" & "Rut Cliente:" & lRutCli & ";Codigo Cliente:" & nCodigo & ";Forma de Pago Inicio:" & lForPagI & ";Forma de Pago Venc:0;Tasa Pacto:0"
    
    '---------------------------------------------------------------------------------
    'Proceso para grabar cada uno de los instrumentos en el control de precios y tasas
    '---------------------------------------------------------------------------------
    hForm.Data1.Recordset.MoveFirst
    iCorrela% = 1
    Do While Not hForm.Data1.Recordset.EOF
        'ptCodInst = hForm.Data1.Recordset("tm_serie")
        ptCodInst = hForm.Data1.Recordset("tm_codigo")
        ptPlazo = DateDiff("D", Fecha_PagoMañana$, CDate(hForm.Data1.Recordset("tm_fecven")))
        ptTasa = CDbl(hForm.Data1.Recordset("tm_tir"))
        resControlPT = ControlPreciosTasas("CP", ptCodInst, ptPlazo, ptTasa, False)
        
        If Ctrlpt_AplicarControl Then
        If Ctrlpt_ModoOperacion = "S" Then
            'Modo silencioso
            Ctrlpt_codProducto = "CP"
            Ctrlpt_NumOp = dNumdocu
            Ctrlpt_NumDocu = ""
            Ctrlpt_TipoOp = "C"
            Ctrlpt_Correlativo = iCorrela%
            Call GrabaModoSilencioso
        Else
            'grabar el instrumento ssi EnviarCF = "S"
            If EnviarCF = "S" Then
            Ctrlpt_codProducto = "CP"
            Ctrlpt_NumOp = dNumdocu
            Ctrlpt_NumDocu = ""
            Ctrlpt_TipoOp = "C"
            Ctrlpt_Correlativo = iCorrela%
            Call GrabaLineaPendPrecios
                    Call GrabaModoSilencioso    '--> PRD-10494 Incidencia 1
        End If
        End If
        End If
        hForm.Data1.Recordset.MoveNext
        iCorrela% = iCorrela% + 1
    Loop
    'fin proceso
    '---------------------------------------------------------------------------------
    Call GRABA_LOG_AUDITORIA(1, gsBac_Fecp, gsBac_IP, gsBac_User, _
            "BTR", "Opc_20100", "01", "Compra Definitiva", "mdcp,mdmo,mddi", Valor_antiguo, " ")

    Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Operación de compra propia número: " & dNumdocu & ", grabada con éxito.")
   
    CP_GrabarTx = dNumdocu
   
    Exit Function
        
        
CP_GrabarTxError:

    MsgBox "Se ha producido un problema en la grabación de la operación de compra: " & err.Description & ". Comunique al Administrador. ", vbCritical, gsBac_Version

        
    If FlagTx = True Then
        If Not Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
            MsgBox "No se pudo realizar devolución de transacción inicializada", vbCritical, gsBac_Version
        End If
    End If
   
    CP_GrabarTx = 0
    Exit Function
    
End Function

Public Sub CP_IniciarTx(hWnd As Long, Data1 As Control)
   On Error Resume Next
    ' Asegurarse no tener registros con el handler.-
    Call CP_BorrarTx(hWnd)
    
    ' Activar filtro para la CP.-
    Data1.DatabaseName = gsMDB_Path & gsMDB_Database
    Data1.RecordsetType = 1
   '-> Se agrega el Order By, para asegurar que el orden de los instrumentos sea el que esta en la Grilla.
    Data1.RecordSource = "SELECT * FROM MDCP WHERE tm_hwnd = " & hWnd & " Order by tm_hwnd, tm_correlativo"

    If Data1.Recordset.RecordCount > 0 Then
      Data1.Refresh
    End If
    
    ' Agrega imediatamente un registro.-
    Call CP_Agregar(hWnd, Data1)
       
End Sub



Private Sub CP_Limpiar(Data1 As Control)

    Data1.Recordset("tm_instser") = ""
    Data1.Recordset("tm_genemi") = ""
    Data1.Recordset("tm_nemmon") = ""
    Data1.Recordset("tm_nominal") = 0#
    Data1.Recordset("tm_tir") = 0#
    Data1.Recordset("tm_pvp") = 0#
    Data1.Recordset("tm_vpar") = 0#
    Data1.Recordset("tm_mt") = 0#
    Data1.Recordset("tm_mt100") = 0#
    Data1.Recordset("tm_tirmcd") = 0#
    Data1.Recordset("tm_pvpmcd") = 0#
    Data1.Recordset("tm_mtmcd") = 0#
    Data1.Recordset("tm_mtmcd100") = 0#
    Data1.Recordset("tm_mtml") = 0#
    Data1.Recordset("tm_tcml") = 0#
    Data1.Recordset("tm_rutemi") = 0#
    Data1.Recordset("tm_codemi") = 0#
    Data1.Recordset("tm_monemi") = 0#
    Data1.Recordset("tm_basemi") = 0#
    Data1.Recordset("tm_fecemi") = ""
    Data1.Recordset("tm_fecven") = ""
    Data1.Recordset("tm_tasemi") = 0#
    Data1.Recordset("tm_mascara") = ""
    Data1.Recordset("tm_numucup") = 0#
    Data1.Recordset("tm_tasest") = 0#
    Data1.Recordset("tm_mdse") = ""
    Data1.Recordset("tm_codigo") = 0#
    Data1.Recordset("tm_refnomi") = ""
    Data1.Recordset("tm_serie") = ""
    Data1.Recordset("tm_cortemin") = 0#
    Data1.Recordset("tm_valmcd") = "N"
    Data1.Recordset("tm_leeemi") = ""
    Data1.Recordset("tm_fecpcup") = ""
    Data1.Recordset("tm_clave_dcv") = ""
    Data1.Recordset("tm_custodia") = ""
    Data1.Recordset("tm_carterasuper") = "T"
    
End Sub





Public Function CP_SumarTotal(hWnd As Long) As Double
Dim rs As Recordset
Dim Sql As String
Dim Datos()

    Sql = "SELECT SUM(tm_mt) As Total FROM mdcp WHERE tm_hwnd = " & hWnd
    
    Set rs = db.OpenRecordset(Sql, dbOpenSnapshot)
    
    If rs.RecordCount > 0 Then
        CP_SumarTotal = rs.Fields("Total")
        If gsBac_Valmon <> 0 Then
            CP_SumarTotal = CP_SumarTotal / gsBac_Valmon
        Else
            CP_SumarTotal = 0
        End If
    Else
        CP_SumarTotal = 0
    End If
    
End Function

