Attribute VB_Name = "modMDVPVI"
Option Explicit
Global Const Ven_MARCA = 0
Global Const Ven_SERIE = 1
Global Const Ven_UM = 2
Global Const Ven_NOMINAL = 3
Global Const Ven_TIR = 4
Global Const Ven_VPAR = 5
Global Const Ven_VPS = 6
Global Const Ven_CUST = 7
Global Const Ven_CDCV = 8
Global Const Ven_TIRM = 9
Global Const Ven_VPARM = 10
Global Const Ven_VCOMP = 11
Global Const Ven_UTIL = 12


Public Function VPVI_GrabarTx(lRutCar&, iTipCar$, lForPagI&, sTipCus$, sRetiro$, sPagMan$, sObserv$, lRutCli&, nCodigo, hForm As Form, TCart$, Mercado$, Sucursal$, AreaResponsable$, Fecha_PagoMañana$, Laminas$, Tipo_Inversion$, Optional ByVal FechaSorteo As Variant, Optional ByVal FechaReal As String) As Double
   On Error GoTo VPVI_GrabarTxError
   Dim Datos()
   Dim iCorrela%
   Dim iCorrVent%
   Dim sMascara$, sInstSer$, sGenEmi$, sNemMon$, dNominal#, dTir#, dPvp#
   Dim dVPar#, dVpTirV#, dVpTirV100#, iNumUCup%, dTasEst#, sFecEmi$, sFecVen$
   Dim dTirTran#, dPvpTran#, dVPTran#, dDifTran_MO#, dDifTran_CLP#, nTipoCambio As Double
   Dim sMdse$, lCodigo&, sSerie$, iMonemi%, dTasEmi#, iBasemi%
   Dim dNumoper#
   Dim sFecPro$
   Dim Resultado%
   Dim Correlativo&
   Dim lRutemi&
   Dim clave_dcv        As String
   Dim FlagTx           As Boolean
   Dim dNumdocu         As Double
   Dim dTipoCambio988   As Double
   Dim dMontoDolar988   As Double
   Dim codcarterasuper  As String
   Dim nombcarterasuper As String
   Dim CodLibro$
   Dim nValorCompraPM   As Double '--> Agregado para Ventas PM
   Dim nDifTran_MO      As Double
   Dim nDifTran_CLP     As Double

   'Para Control de Precios y Tasas
   Dim ptCodInst        As String
   Dim ptPlazo          As Long    '- AS Integer
   Dim ptTasa           As Double
   Dim resControlPT     As String

   dTipoCambio988 = FUNC_BUSCA_VALOR_MONEDA(998, Format(gsBac_Fecp, "DD/MM/YYYY"))
   FlagTx = False
   If Not Bac_Sql_Execute("BEGIN TRANSACTION") Then
      GoTo VPVI_GrabarTxError
   End If
                    
  'Indica inicio de Begin Transaction y se puede hacer el RollBack
   FlagTx = True
   If Not Bac_Sql_Execute("SP_OPMDAC") Then
      GoTo VPVI_GrabarTxError
   End If
   If Bac_SQL_Fetch(Datos()) Then
      dNumoper = Val(Datos(1))
   End If
   hForm.Data1.RecordSource = "SELECT * FROM mdventa WHERE tm_hwnd = " & BacFrmIRF.Hwnd & " AND tm_diasdisp >= 1 AND ( tm_venta = " & Chr(34) & "V" & Chr(34) & " OR tm_venta = " & Chr(34) & "P" & Chr(34) & " )"
   hForm.Data1.Refresh
    
   '********** Linea -- Mkilo
   If gsBac_Lineas = "S" Then
      Dim mensaje     As String

      mensaje = ""
      hForm.Data1.Recordset.MoveFirst
      iCorrela% = 0
      
      Do While Not hForm.Data1.Recordset.EOF
         If hForm.Data1.Recordset("tm_venta") = "P" Or BacFrmIRF.Data1.Recordset("tm_venta") = "V" Then
            If Trim$(hForm.Data1.Recordset("tm_instser")) <> "" Then
               With hForm
                  dNumdocu = .Data1.Recordset("tm_numdocu")
                  iCorrela = .Data1.Recordset("tm_correla")
                  dNominal = .Data1.Recordset("tm_nominal")
                  dVpTirV# = .Data1.Recordset("tm_vp")
                  sFecVen$ = .Data1.Recordset("tm_fecven")
                  lCodigo& = .Data1.Recordset("tm_codigo")
                  iMonemi% = .Data1.Recordset("tm_monemi")
                  lRutemi& = .Data1.Recordset("tm_rutemi")
                  sSerie$ = .Data1.Recordset("tm_mdse")
               End With
               
               If Not Lineas_ChequearGrabar("BTR", "VP ", dNumoper, dNumdocu, CDbl(iCorrela), CDbl(lRutCli), CDbl(nCodigo), dVpTirV#, gsBac_TCambio, gsBac_Fecp, CDbl(lRutemi&), iMonemi%, hForm.Data1.Recordset("tm_fecven"), CDbl(lCodigo&), sSerie$, 0, "C", 0, "N", 0, gsBac_Fecp, dNominal / hForm.Data1.Recordset("tm_nominalO"), 0, hForm.Data1.Recordset("tm_tir"), 0, hForm.Data1.Recordset("tm_instser")) Then
                  GoTo VPVI_GrabarTxError
               End If
            End If
         End If
         hForm.Data1.Recordset.MoveNext
      Loop
        
      mensaje = mensaje & Lineas_Chequear("BTR", "VP ", dNumoper, " ", " ", " ")
      If mensaje <> "" Then
         MsgBox "Error al Chequear Lineas : " + Chr(10) + Chr(13) + Chr(10) + Chr(13) + mensaje, vbCritical
         If FlagTx = True Then
            If Not Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
               MsgBox "No se pudo realizar devolución de transacción inicializada", vbCritical, gsBac_Version
            End If
         End If
         VPVI_GrabarTx = 0
         Exit Function
      End If
   End If
   '********** Fin
   iCorrela% = 0
   iCorrVent% = 1
   hForm.Data1.Recordset.MoveFirst
    
   Do While Not hForm.Data1.Recordset.EOF
      If hForm.Data1.Recordset("tm_venta") = "P" Or BacFrmIRF.Data1.Recordset("tm_venta") = "V" Then
         ' Verifica que el registro esté con datos
         If Trim$(hForm.Data1.Recordset("tm_instser")) <> "" Then
            ' Recupera datos del Data Control del Form enviado
            With hForm
               lRutCar = .Data1.Recordset("tm_rutcart")
               dNumdocu = .Data1.Recordset("tm_numdocu")
               iCorrela = .Data1.Recordset("tm_correla")
               sMascara = .Data1.Recordset("tm_mascara")
               sInstSer = .Data1.Recordset("tm_instser")
               sGenEmi = .Data1.Recordset("tm_genemi")
               sNemMon = .Data1.Recordset("tm_nemmon")
               dNominal = .Data1.Recordset("tm_nominal")
               dTir = .Data1.Recordset("tm_tir")
               dPvp = .Data1.Recordset("tm_pvp")
               dVPar = .Data1.Recordset("tm_vpar")
               dVpTirV = .Data1.Recordset("tm_vp")
               dVpTirV100 = .Data1.Recordset("tm_vp100")
               iNumUCup = .Data1.Recordset("tm_numucup")
               dTasEst = .Data1.Recordset("tm_tasest")
               sFecEmi = .Data1.Recordset("tm_fecemi")
               sFecVen = .Data1.Recordset("tm_fecven")
               lCodigo = .Data1.Recordset("tm_codigo")
               iMonemi = .Data1.Recordset("tm_monemi")
               lRutemi = .Data1.Recordset("tm_rutemi")
               dTasEmi = .Data1.Recordset("tm_tasemi")
               iBasemi = .Data1.Recordset("tm_basemi")
               sSerie = .Data1.Recordset("tm_serie")
               sTipCus = Mid$(.Data1.Recordset("tm_custodia"), 1, 1)
               clave_dcv = IIf(IsNull(.Data1.Recordset("tm_clave_dcv")), "", .Data1.Recordset("tm_clave_dcv"))
               codcarterasuper = IIf(IsNull(.Data1.Recordset("tm_carterasuper")), "T", .Data1.Recordset("tm_carterasuper"))
               iTipCar$ = .Data1.Recordset("tm_tipcart")
               CodLibro$ = Trim(.Data1.Recordset("tm_id_libro"))
               nValorCompraPM = .Data1.Recordset("tm_vptirc") '--> Agregado para Ventas PM
               
               nTipoCambio = 1
               nTipoCambio = funcBuscaTipcambio(.Data1.Recordset!tm_monemi, gsBac_Fecp)
               
               dTirTran# = .Data1.Recordset("tm_Tir_Tran")
               dPvpTran# = .Data1.Recordset("tm_Pvp_Tran")
               dVPTran# = .Data1.Recordset("tm_Vp_Tran")
               dDifTran_MO# = Str((.Data1.Recordset("tm_vp") - .Data1.Recordset("tm_vp_tran")))
               dDifTran_CLP# = Str((.Data1.Recordset("tm_vp") - .Data1.Recordset("tm_vp_tran"))) * IIf(.Data1.Recordset!tm_monemi <> "CLP", nTipoCambio, 1)

               dDifTran_CLP# = dDifTran_MO#
               If Trim(sNemMon) = "USD" Then
                    dDifTran_CLP# = Str((.Data1.Recordset("tm_vp") - .Data1.Recordset("tm_vp_tran"))) * IIf(.Data1.Recordset!tm_monemi <> "CLP", nTipoCambio, 1)
               End If
            End With

            Envia = Array()
            AddParam Envia, dNumoper
            AddParam Envia, CDbl(lRutCar)
            AddParam Envia, CDbl(iTipCar)
            AddParam Envia, dNumdocu
            AddParam Envia, CDbl(iCorrela)
            AddParam Envia, dNominal
            AddParam Envia, dTir
            AddParam Envia, dPvp
            AddParam Envia, dVPar
            AddParam Envia, dVpTirV
            AddParam Envia, CDbl(iNumUCup)
            AddParam Envia, lRutCli
            AddParam Envia, nCodigo
            AddParam Envia, Format$(gsBac_Fecp, "yyyymmdd")
            AddParam Envia, dTasEst
            AddParam Envia, iMonemi
            AddParam Envia, lRutemi
            AddParam Envia, dTasEmi
            AddParam Envia, CDbl(iBasemi)
            AddParam Envia, sTipCus
            AddParam Envia, CDbl(lForPagI)
            AddParam Envia, sRetiro
            AddParam Envia, gsBac_User
            AddParam Envia, gsTerminal
            AddParam Envia, sMascara
            AddParam Envia, sInstSer
            AddParam Envia, sGenEmi
            AddParam Envia, sNemMon
            AddParam Envia, Format(sFecEmi, "yyyymmdd")
            AddParam Envia, Format(sFecVen, "yyyymmdd")
            AddParam Envia, CDbl(lCodigo)
            AddParam Envia, CDbl(iCorrVent)
            AddParam Envia, clave_dcv
            AddParam Envia, codcarterasuper
            AddParam Envia, TCart
            AddParam Envia, Mercado
            AddParam Envia, Sucursal
            AddParam Envia, AreaResponsable
            AddParam Envia, Format(Fecha_PagoMañana, feFECHA)
            AddParam Envia, Laminas
            AddParam Envia, Tipo_Inversion
            AddParam Envia, sObserv$
            
            If Mid$(hForm.Tag, 1, 2) = "ST" Then
               AddParam Envia, CodLibro$
               AddParam Envia, Format(FechaSorteo, "yyyymmdd")
               AddParam Envia, Format(FechaReal, "yyyymmdd")
               
               If Not Bac_Sql_Execute("SP_GRABARST", Envia) Then
                  GoTo VPVI_GrabarTxError
               End If
            Else
               AddParam Envia, ""
               AddParam Envia, CodLibro$
               AddParam Envia, nValorCompraPM '--> Agregado para Ventas PM
               
               AddParam Envia, dTirTran#
               AddParam Envia, dPvpTran#
               AddParam Envia, dVPTran#
               AddParam Envia, dDifTran_MO#
               AddParam Envia, dDifTran_CLP#
               
               If Not Bac_Sql_Execute("SP_GRABARVP", Envia) Then
                  GoTo VPVI_GrabarTxError
               End If
            End If
                                                        
            Correlativo = hForm.Data1.Recordset("tm_correlao")
            
            If VPVI_GrabarCortesSQL(lRutCar, dNumdocu, iCorrela, dNumoper, Correlativo) = False Then
               GoTo VPVI_GrabarTxError
            End If
            
            If hForm.Data1.Recordset("tm_monemi") = 13 Then
               dMontoDolar988 = Format$(BacFrmIRF.Data1.Recordset("tm_vptirc") * dTipoCambio988, "######0")
            Else
               dMontoDolar988 = Format$(BacFrmIRF.Data1.Recordset("tm_vptirc"))
            End If
         End If
      End If
      
      If Mid$(hForm.Tag, 1, 2) = "VP" Then
         'Actualiza las Coberturas
         Envia = Array()
         AddParam Envia, "BTR"
         AddParam Envia, CDbl(dNumdocu)
         AddParam Envia, CDbl(iCorrela)
         Call Bac_Sql_Execute("SP_ACTUALIZACION_POSTVENTA", Envia)
      End If
      
      iCorrVent% = iCorrVent% + 1
      hForm.Data1.Recordset.MoveNext
   Loop
    
   '********** Linea -- Mkilo
   If gsBac_Lineas = "S" Then
      If Not Lineas_GrbOperacion("BTR", "VP ", dNumoper, dNumoper, " ", " ", " ") Then
         GoTo VPVI_GrabarTxError
      End If
   End If
   '********** Fin
    
   Valor_antiguo = " "
   Valor_antiguo = "Operacion:" & dNumoper & ";VP;" & "Rut Cliente: " & lRutCli & ";Codigo Cliente:" & nCodigo & ";Forma de Pago:" & lForPagI & ";Forma de Pago Venc:0;Tasa Pacto:0"
   
   '---------------------------------------------------------------------------------
   'Proceso para grabar cada uno de los instrumentos en el control de precios y tasas
   '---------------------------------------------------------------------------------
   hForm.Data1.Recordset.MoveFirst
   iCorrela% = 1
   Do While Not hForm.Data1.Recordset.EOF
        'ptCodInst = hForm.Data1.Recordset("tm_instser")
        ptCodInst = hForm.Data1.Recordset("tm_codigo")
        ptPlazo = DateDiff("D", gsBac_Fecp, CDate(hForm.Data1.Recordset("tm_fecsal")))
        ptTasa = CDbl(hForm.Data1.Recordset("tm_tir"))
        
        resControlPT = ControlPreciosTasas("VP", ptCodInst, ptPlazo, ptTasa, False)
        If Ctrlpt_AplicarControl Then
        If Ctrlpt_ModoOperacion = "S" Then
            Ctrlpt_codProducto = "VP"
            Ctrlpt_NumOp = dNumoper
            Ctrlpt_NumDocu = dNumdocu
            Ctrlpt_TipoOp = "V"
            Ctrlpt_Correlativo = iCorrela%
            Call GrabaModoSilencioso
        Else
            'grabar el instrumento ssi EnviarCF = "S"
            If EnviarCF = "S" Then
            Ctrlpt_codProducto = "VP"
            Ctrlpt_NumOp = dNumoper
            Ctrlpt_NumDocu = dNumdocu
            Ctrlpt_TipoOp = "V"
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
    
   
   Call GRABA_LOG_AUDITORIA(1, gsBac_Fecp, gsBac_IP, gsBac_User, "BTR", "Opc_20200", "01", "Venta Definitiva", "mdmo,mddi", Valor_antiguo, " ")
   
   If Not Bac_Sql_Execute("COMMIT TRANSACTION") Then
      GoTo VPVI_GrabarTxError
   End If
                    
   VPVI_GrabarTx = dNumoper
                                  
   Screen.MousePointer = vbDefault
    
Exit Function
VPVI_GrabarTxError:

   If FlagTx = True Then
      If miSQL.SQL_Execute("ROLLBACK TRANSACTION") <> 0 Then
         MsgBox "NO SE PUDO REALIZAR ROLLBACK", vbExclamation, gsBac_Version
      End If
   End If

   If Mid$(hForm.Tag, 1, 2) = "ST" Then
      MsgBox "No se pudo completar la grabación de operación de Sorteo de Letras", vbExclamation, gsBac_Version
   Else
      MsgBox "No se pudo completar la grabación de operación de Ventas definitivas", vbExclamation, gsBac_Version
   End If
   VPVI_GrabarTx = 0
End Function

Public Function VPVI_GrabarCortesSQL(Rutcart&, NumDocu#, Correla%, Numoper#, Correlativo&) As Boolean
Dim rs As Recordset

    VPVI_GrabarCortesSQL = False

    Sql = "SELECT * FROM mdco WHERE tm_correlativo = " & Correlativo
    
    Set rs = db.OpenRecordset(Sql, dbOpenSnapshot)
    
    If rs.RecordCount > 0 Then
        rs.MoveFirst
        Do While Not rs.EOF
            Envia = Array(CDbl(Rutcart), _
                    NumDocu, _
                    CDbl(Correla), _
                    Numoper, _
                    CDbl(rs("tm_cantcortv")), _
                    CDbl(rs("tm_mtocort")))

            If Not Bac_Sql_Execute("SP_VTCORTESPARCIAL", Envia) Then
                Exit Function
            End If
            
            rs.MoveNext
        Loop
    Else
        
        Envia = Array(CDbl(Rutcart), _
                NumDocu, _
                CDbl(Correla), _
                Numoper)
                
        If Not Bac_Sql_Execute("SP_VTCORTESTOTAL", Envia) Then
            Exit Function
        End If
        
    End If

    VPVI_GrabarCortesSQL = True
    
End Function





Public Function VPVI_ChkTipoCambio(FormHandle&) As Boolean
Dim rs As Recordset
Dim Sql$

'Selecciona todos los registros que tengan tipo de cambio igual a cero

    Sql = "SELECT * FROM mddi WHERE tm_tcml = 0 AND tm_hwnd = " & FormHandle&

    Set rs = db.OpenRecordset(Sql, dbOpenSnapshot)
    
    If rs.RecordCount > 0 Then
        VPVI_ChkTipoCambio = False
    Else
        VPVI_ChkTipoCambio = True
    End If

End Function



Public Function VPVI_LeerCortes(Data1 As Control, FormHandle&)
Dim rs As Recordset
Dim Datos()
Dim Rutcart&
Dim NumDocu#
Dim Correla%
Dim Nominal#
Dim Correlativo&

    Rutcart = Data1.Recordset("tm_rutcart")
    NumDocu = Data1.Recordset("tm_numdocu")
    Correla = Data1.Recordset("tm_correla")
    Nominal = Data1.Recordset("tm_nominal")
    Correlativo = Data1.Recordset("tm_correlao")
    
    'Elimino todos los cortes que hubierann en el temporal
    Call CO_EliminarCortesMDB(FormHandle, Correlativo)
    
    Set rs = db.OpenRecordset("mdco", dbOpenTable)
    VPVI_LeerCortes = False

    Envia = Array(CDbl(Rutcart), _
            NumDocu, _
            CDbl(Correla), _
            Nominal)
        
    If Not Bac_Sql_Execute("SP_VALCORT", Envia) Then
        MsgBox "NO SE PUDO EJECUTAR LA RUTINA DE SELECCION DE CORTES", vbExclamation, gsBac_Version
        Exit Function
    End If
    
    If Bac_SQL_Fetch(Datos()) Then
    
        rs.AddNew
        rs("tm_correlativo") = Correlativo
        rs("tm_hwnd") = FormHandle&
        rs("tm_rutcart") = Rutcart
        rs("tm_numdocu") = NumDocu
        rs("tm_correla") = Correla
        rs("tm_mtocort") = CDbl(Datos(1))
        rs("tm_cantcortd") = Val(Datos(2))
        rs("tm_cantcortv") = Val(Datos(3))
        rs.Update

        Do While Bac_SQL_Fetch(Datos())
            rs.AddNew
            rs("tm_correlativo") = Correlativo
            rs("tm_hwnd") = FormHandle&
            rs("tm_rutcart") = Rutcart
            rs("tm_numdocu") = NumDocu
            rs("tm_correla") = Correla
            rs("tm_mtocort") = CDbl(Datos(1))
            rs("tm_cantcortd") = Val(Datos(2))
            rs("tm_cantcortv") = Val(Datos(3))
            rs.Update
        Loop
        VPVI_LeerCortes = True

    Else
        MsgBox "No se encontró combinación para nominal seleccionado " & vbCrLf & vbCrLf & "Se restaurará valor nominal inicial", vbExclamation, gsBac_Version
        VPVI_LeerCortes = False
     End If
    
End Function
