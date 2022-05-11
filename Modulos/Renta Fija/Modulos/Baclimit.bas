Attribute VB_Name = "BACLimit"
'   Nota : Archivo .BAS  de limites
' =======================================================================================================================================================
'   En este modulo se encuentran todas las funcion de control de limites
'   se ruega a la persona que tuviese que mantener tenga presente que fue
'   un desarrollo rapido de sacar, y que no se acuerde mucho de la familia
'   del autor, ya que nadie es PERFEsTO
'
'   Atte.
'   Victor Barra Fuentes
'   Julio 2000 Deutsche Bank
' =======================================================================================================================================================
Option Explicit
Global aVarLimites()    As Variant
Global iContArrayLim    As Integer



''
'
'
Public Function funcGrabaExcesos(nNumdocu As Double, iCorrela As Integer, cTipOper As String, cTipLIM, iCodExeLIM As Integer, dMtoExcLIM As Double, cAccion As String, iPlazoLimite As Integer, dRutcli As Double, iCodcli As Integer, dMontoAfecto As Double) As Boolean
Dim cSql As String
Dim Datos()
Dim dValorMoneda As Double
Dim dMontoExceso As Double

funcGrabaExcesos = False
        
        
  ' VB+ 28/07/2000 para los excesos diferentes de PFE y CCE se cambio monto afectado a dolar
  ' ------------------------------------------------------------------------------------------
    dValorMoneda = FUNC_BUSCA_VALOR_MONEDA(988, Format(gsBac_Fecp, "DD/MM/YYYY"))
    
    If cTipLIM <> "PFECCE" Then
       dMontoExceso = Format$((dMontoAfecto / dValorMoneda), "###########0.0000")
    End If
  ' ------------------------------------------------------------------------------------------
  ' VB- 28/07/2000
  
    cSql = "EXECUTE SP_GRABA_EXCESOS_LIMITES "
    cSql = cSql & "'BTR',"
    cSql = cSql & "'" & cTipOper & "',"
    cSql = cSql & nNumdocu & ","
    cSql = cSql & "'" & cTipLIM & "',"
    cSql = cSql & iCorrela & ","
    cSql = cSql & iCodExeLIM & ","
    cSql = cSql & dMtoExcLIM & ","
    cSql = cSql & "'" & cAccion & "',"
    cSql = cSql & iPlazoLimite & ","
    cSql = cSql & dRutcli & ","
    cSql = cSql & iCodcli & ","
    cSql = cSql & dMontoExceso
        
    If miSQL.SQL_Execute(cSql) <> 0 Then Exit Function
    If miSQL.SQL_Fetch(Datos()) <> 0 Then Exit Function
    
    If Datos(1) <> 0 Then
        MsgBox "Problemas en actualización de mensajes de excesos de limites ", vbExclamation, "BAC Limites"
        Exit Function
    End If
    
    funcGrabaExcesos = True
    
End Function

Public Function funcRebajaLimites_PFECCE(dRut As Double, nCod As Integer, dFecvcto As String, cTipOper As String, Monto_PFE As Double, Monto_CCE As Double)

Dim cSql As String
Dim Datos()

    funcRebajaLimites_PFECCE = False

  ' Realizo Validación de limites PFE y CCE
  ' ----------------------------------------------
    cSql = "EXECUTE SP_LIMITES_PFE_CCE "
    cSql = cSql & "'BTR',"
    cSql = cSql & "'DES',"
    cSql = cSql & dRut & ","
    cSql = cSql & nCod & ","
    cSql = cSql & 0 & ","
    cSql = cSql & 0 & ","
    cSql = cSql & 0 & ","
    cSql = cSql & 0 & ","
    cSql = cSql & 0 & ","
    cSql = cSql & "'" & Format$(gsBac_Fecp, "yyyymmdd") & "',"
    cSql = cSql & "'" & Format$(dFecvcto, "yyyymmdd") & "',"
    cSql = cSql & "'" & cTipOper & "',"
    cSql = cSql & Monto_PFE & ","
    cSql = cSql & Monto_CCE & ","
    cSql = cSql & NumeroOperacionExceso

    
    If miSQL.SQL_Execute(cSql) <> 0 Then Exit Function
    If miSQL.SQL_Fetch(Datos()) <> 0 Then Exit Function
    
    funcRebajaLimites_PFECCE = True


End Function



Public Function funcLimitesModificacion_PFECCE(dRut As Double, nCod As Double, dTotal As Double, dFecvcto As Variant, cTipOper As String, cAccion As String, dTotal_PFE As Double, dTotal_CCE As Double)

Dim cSql As String
Dim Datos()
Dim nRow As Integer
Dim dFecha As String

    funcLimitesModificacion_PFECCE = False

       
    
  ' Realizo Validación de limites PFE y CCE
  ' ----------------------------------------------
    cSql = "EXECUTE SP_LIMITES_PFE_CCE "
    cSql = cSql & "'BTR',"
    cSql = cSql & "'" & cAccion & "',"
    cSql = cSql & dRut & ","
    cSql = cSql & nCod & ","
    cSql = cSql & 0 & ","
    cSql = cSql & 0 & ","
    cSql = cSql & 0 & ","
    cSql = cSql & 0 & ","
    cSql = cSql & 0 & ","
    cSql = cSql & "'" & Format$(gsBac_Fecp, "yyyymmdd") & "',"
    cSql = cSql & "'" & Format$(dFecvcto, "yyyymmdd") & "',"
    cSql = cSql & "'" & cTipOper & "',"
    cSql = cSql & dTotal_PFE & ","
    cSql = cSql & dTotal_CCE & ","
    cSql = cSql & IIf(cAccion = "DES", NumeroOperacionExceso, 0)

    
    If miSQL.SQL_Execute(cSql) <> 0 Then Exit Function
    If miSQL.SQL_Fetch(Datos()) <> 0 Then Exit Function
    
    If cAccion = "VAL" Then
        If Datos(1) <> 0 Then
            MsgBox Datos(2), vbExclamation, "Validación Limites PFE y CCE "
            Exit Function
        End If
    End If
    
    funcLimitesModificacion_PFECCE = True



End Function


Function funcRebajaLimites_RCA_RVA(dRut As Double, nCod As Integer, cTipo As String, cTipoOperac As String, dFecvcto As Date, dValAct As Double, fValorPFE As Double, fValorCCE As Double) As Boolean
Dim cSql        As String
Dim dDurMod     As Double
Dim dTotal_PFE  As Double
Dim dTotal_CCE  As Double
Dim cAccion     As String
Dim iMoneda     As Integer
Dim nRow        As Integer
Dim Datos()

    funcRebajaLimites_RCA_RVA = False

    cAccion = IIf(cTipo = "Q", "VAL", IIf(cTipo = "S", "CAR", "DES"))
    
       
  ' Realizo Validación d e limites PFE y CCE
  ' ----------------------------------------------
    cSql = "EXECUTE SP_LIMITES_PFE_CCE "
    cSql = cSql & "'BTR',"
    cSql = cSql & "'" & cAccion & "',"
    cSql = cSql & dRut & ","
    cSql = cSql & nCod & ","
    cSql = cSql & 0 & ","
    cSql = cSql & 0 & ","
    cSql = cSql & 0 & ","
    cSql = cSql & 0 & ","
    cSql = cSql & 0 & ","
    cSql = cSql & "'" & Format$(gsBac_Fecp, "yyyymmdd") & "',"
    cSql = cSql & "'" & Format$(dFecvcto, "yyyymmdd") & "',"
    cSql = cSql & "'" & cTipoOperac & "',"
    cSql = cSql & fValorPFE & ","
    cSql = cSql & fValorCCE & ","
    cSql = cSql & IIf(cAccion = "DES", NumeroOperacionExceso, 0)


    If miSQL.SQL_Execute(cSql) <> 0 Then Exit Function
    If miSQL.SQL_Fetch(Datos()) <> 0 Then Exit Function
    If Datos(1) = -1 Then
        MsgBox "Problemas en actualización de limites PFE y CCE ", vbCritical, gsBac_Version
        Exit Function
    End If
    
    If cTipoOperac = "RVA" Then
      ' Envio a dar de baja limite ART 84
      ' ----------------------------------------------------------
        If Not funcValidacionLimites_CI(dRut, dValAct, "D") Then
            Exit Function
        End If
    End If
    
    funcRebajaLimites_RCA_RVA = True
    
End Function

Public Function funcValidacionLimites_PFE_CCE_CI(dRut As Double, nCod As Integer, dTotal As Double, cTipo As String, ByRef dPFE As Double, ByRef dCCE As Double, ByRef iCodExceso_PFE As Integer, ByRef dMtoExceso_PFE As Double, ByRef iCodExceso_CCE As Integer, ByRef dMtoExceso_CCE As Double) As Boolean
Dim cSql        As String
Dim dDurMod     As Double
Dim dTotal_PFE  As Double
Dim dTotal_CCE  As Double
Dim cAccion     As String
Dim Datos()

    cAccion = IIf(cTipo = "Q", "VAL", IIf(cTipo = "S", "CAR", "DES"))

    funcValidacionLimites_PFE_CCE_CI = False
     
    Set BacFrmIRF = BacTrader.ActiveForm
    
    With BacFrmIRF.Data1
    If cTipo = "Q" Then
        .Recordset.MoveFirst
      ' Calculo montos para validar
        Do While Not .Recordset.EOF
            dDurMod = .Recordset("tm_durationmod")
            
            cSql = "EXECUTE SP_LIMITES_PFE_CCE "
            cSql = cSql & "'BTR',"
            cSql = cSql & "'CAL',"
            cSql = cSql & dRut & ","
            cSql = cSql & nCod & ","
            cSql = cSql & .Recordset("tm_monemi") & ","
            cSql = cSql & dDurMod & ","
            cSql = cSql & .Recordset("tm_tir") & ","
            cSql = cSql & .Recordset("tm_mtmcd") & ","
            cSql = cSql & .Recordset("tm_mt") & ","
            cSql = cSql & "'" & Format$(gsBac_Fecp, "yyyymmdd") & "',"
            cSql = cSql & "'" & Format$(BacFrmIRF.TxtFecVct.Text, "yyyymmdd") & "',"
            cSql = cSql & "'CI',"
            cSql = cSql & "0,"
            cSql = cSql & "0,"
            cSql = cSql & "0"

            If miSQL.SQL_Execute(cSql) <> 0 Then Exit Function
            If miSQL.SQL_Fetch(Datos()) <> 0 Then Exit Function
            
            dTotal_PFE = dTotal_PFE + CDbl(Datos(2))
            dTotal_CCE = dTotal_CCE + CDbl(Datos(3))
            
            .Recordset.MoveNext
        Loop
        dPFE = dTotal_PFE
        dCCE = dTotal_CCE
    End If
    
        
  ' Realizo Validación de limites PFE y CCE
  ' ----------------------------------------------
    If cTipo = "S" Or cTipo = "Q" Then
        cSql = "EXECUTE SP_LIMITES_PFE_CCE "
        cSql = cSql & "'BTR',"
        cSql = cSql & "'" & cAccion & "',"
        cSql = cSql & dRut & ","
        cSql = cSql & nCod & ","
        cSql = cSql & 0 & ","
        cSql = cSql & 0 & ","
        cSql = cSql & 0 & ","
        cSql = cSql & 0 & ","
        cSql = cSql & 0 & ","
        cSql = cSql & "'" & Format$(gsBac_Fecp, "yyyymmdd") & "',"
        cSql = cSql & "'" & Format$(BacFrmIRF.TxtFecVct.Text, "yyyymmdd") & "',"
        cSql = cSql & "'CI',"
        cSql = cSql & dPFE & ","
        cSql = cSql & dCCE & ","
        cSql = cSql & IIf(cAccion = "DES", NumeroOperacionExceso, 0)


        If miSQL.SQL_Execute(cSql) <> 0 Then Exit Function
        
        Do While Bac_SQL_Fetch(Datos())
                    
           ' If cAccion = "VAL" Then
           '     iCodExcesopfecce = Datos(1)
           ' End If
        
            If cAccion = "VAL" Then
            
                If Val(Datos(1)) = 3 Or Val(Datos(1)) = 1 Then
                    dMtoExceso_PFE = Datos(3)
                    iCodExceso_PFE = Datos(1)
                End If
                If Val(Datos(1)) = 4 Or Val(Datos(1)) = 2 Then
                    dMtoExceso_CCE = Datos(3)
                    iCodExceso_CCE = Datos(1)
                End If
               
                If Val(Datos(1)) = 3 Or Val(Datos(1)) = 4 Then
                    iContArrayLim = iContArrayLim + 1
                    ReDim Preserve aVarLimites(iContArrayLim) As Variant
                    aVarLimites(iContArrayLim) = Datos(2) & vbCrLf & vbCrLf & "Monto sobrepasado : " & Format$(Datos(3), "###,###,###,###,###,###,##0.00")
 '                   Exit Function
                End If
              
                If Val(Datos(1)) = 1 Or Val(Datos(1)) = 2 Then
                    iContArrayLim = iContArrayLim + 1
                    ReDim Preserve aVarLimites(iContArrayLim) As Variant
                    aVarLimites(iContArrayLim) = Datos(2)
'                    Exit Function
                End If
                
               If iContArrayLim > 1 Then
                    Exit Function
                End If
    
            End If
            If Val(Datos(1)) = -1 Then
               MsgBox Datos(2), vbExclamation, "Validación Limites PFE y CCE "
               Exit Function
            End If
            
        Loop
    
    End If
    
    End With
    funcValidacionLimites_PFE_CCE_CI = True
    
End Function


Public Function funcValidacionLimites_PFE_CCE_VI(dRut As Double, nCod As Integer, dTotal As Double, cTipo As String, ByRef dPFE As Double, ByRef dCCE As Double, ByRef iCodExceso_PFE As Integer, ByRef dMtoExceso_PFE As Double, ByRef iCodExceso_CCE As Integer, ByRef dMtoExceso_CCE As Double) As Boolean
Dim cSql As String
Dim dDurMod As Double
Dim dTotal_PFE As Double
Dim dTotal_CCE As Double
Dim cAccion As String
Dim Datos()


    cAccion = IIf(cTipo = "Q", "VAL", IIf(cTipo = "S", "CAR", "DES"))

    funcValidacionLimites_PFE_CCE_VI = False
     
    Set BacFrmIRF = BacTrader.ActiveForm
    
    With BacFrmIRF.Data1
    
    If cTipo = "Q" Then
    
        .Recordset.MoveFirst
      ' Calculo montos para validar
        Do While Not .Recordset.EOF
            dDurMod = .Recordset("tm_duratmod")
            
            cSql = "EXECUTE SP_LIMITES_PFE_CCE "
            cSql = cSql & "'BTR',"
            cSql = cSql & "'CAL',"
            cSql = cSql & dRut & ","
            cSql = cSql & nCod & ","
            cSql = cSql & .Recordset("tm_monemi") & ","
            cSql = cSql & dDurMod & ","
            cSql = cSql & .Recordset("tm_tir") & ","
            cSql = cSql & .Recordset("tm_vp") & ","
            cSql = cSql & .Recordset("tm_vp") & ","
            cSql = cSql & "'" & Format$(gsBac_Fecp, "yyyymmdd") & "',"
            cSql = cSql & "'" & Format$(BacFrmIRF.TxtFecVct.Text, "yyyymmdd") & "',"
            cSql = cSql & "'VI',"
            cSql = cSql & "0,"
            cSql = cSql & "0,"
            cSql = cSql & "0"

            If miSQL.SQL_Execute(cSql) <> 0 Then Exit Function
            If miSQL.SQL_Fetch(Datos()) <> 0 Then Exit Function
            
            dTotal_PFE = dTotal_PFE + CDbl(Datos(2))
            dTotal_CCE = dTotal_CCE + CDbl(Datos(3))
            
            .Recordset.MoveNext
        Loop
        dPFE = dTotal_PFE
        dCCE = dTotal_CCE
    End If
    End With
        
    If cTipo = "S" Or cTipo = "Q" Then
      ' Realizo Validación de limites PFE y CCE
      ' ----------------------------------------------
        cSql = "EXECUTE SP_LIMITES_PFE_CCE "
        cSql = cSql & "'BTR',"
        cSql = cSql & "'" & cAccion & "',"
        cSql = cSql & dRut & ","
        cSql = cSql & nCod & ","
        cSql = cSql & 0 & ","
        cSql = cSql & 0 & ","
        cSql = cSql & 0 & ","
        cSql = cSql & 0 & ","
        cSql = cSql & 0 & ","
        cSql = cSql & "'" & Format$(gsBac_Fecp, "yyyymmdd") & "',"
        cSql = cSql & "'" & Format$(BacFrmIRF.TxtFecVct.Text, "yyyymmdd") & "',"
        cSql = cSql & "'VI',"
        cSql = cSql & dPFE & ","
        cSql = cSql & dCCE & ","
        cSql = cSql & IIf(cAccion = "DES", NumeroOperacionExceso, 0)

        If miSQL.SQL_Execute(cSql) <> 0 Then Exit Function
        
        Do While Bac_SQL_Fetch(Datos())
        
           If cAccion = "VAL" Then
            
                If Val(Datos(1)) = 3 Or Val(Datos(1)) = 1 Then
                    dMtoExceso_PFE = Datos(3)
                    iCodExceso_PFE = Datos(1)
                End If
                
                If Val(Datos(1)) = 4 Or Val(Datos(1)) = 2 Then
                    dMtoExceso_CCE = Datos(3)
                    iCodExceso_CCE = Datos(1)
                End If
               
                If Val(Datos(1)) = 3 Or Val(Datos(1)) = 4 Then
                    iContArrayLim = iContArrayLim + 1
                    ReDim Preserve aVarLimites(iContArrayLim) As Variant
                    aVarLimites(iContArrayLim) = Datos(2) & vbCrLf & vbCrLf & "Monto sobrepasado : " & Format$(Datos(3), "###,###,###,###,###,###,##0.00")
'                    Exit Function
                End If
              
                If Val(Datos(1)) = 1 Or Val(Datos(1)) = 2 Then
                    iContArrayLim = iContArrayLim + 1
                    ReDim Preserve aVarLimites(iContArrayLim) As Variant
                    aVarLimites(iContArrayLim) = Datos(2)
 '                   Exit Function
                End If
                
                If iContArrayLim > 0 Then
                    Exit Function
                End If
            End If
            
            If Val(Datos(1)) = -1 Then
                MsgBox Datos(2), vbExclamation, "Validación Limites PFE y CCE "
                Exit Function
            End If
        Loop
             
End If

    
    funcValidacionLimites_PFE_CCE_VI = True
    
End Function


' ================================================================================================================
 Public Function funcValidaLimites_SETTLEMENT(dRutCliente As Double, dCodigoRut As Double, _
                                              cTipOperacion As String, _
                                              nNumoper As Double, _
                                              iCorrela As Integer, _
                                              iForpago As Integer, _
                                              dMtoOper As Double, _
                                              cAction As String, _
                                      ByRef iCodSETTLE As Integer, _
                                      ByRef dMtoSETTLE As Double, _
                                      ByRef iPlazoValuta As Integer) As Boolean
' ================================================================================================================
' Función   :   funcValidaLimites_SETTLEMENT
' Objetivo  :   Realiza la validación de limites SETTLEMENT
' Fecha     :   Junio 2000
' Autor     :   Victor Barra Fuentes
' ================================================================================================================
Dim cSql As String
Dim Datos()
Dim cTipo  As String
Dim nTotal  As Integer

    funcValidaLimites_SETTLEMENT = False

    
    cTipo = IIf(cAction = "Q", "VAL", IIf(cAction = "S", "CAR", "DES"))

    cSql = ""
    cSql = cSql & "EXECUTE SP_LIMITES_SETTLEMENT "
    cSql = cSql & "'BTR',"
    cSql = cSql & "'" & Format$(gsBac_Fecp, "yyyymmdd") & "',"
    cSql = cSql & "'" & cTipo & "',"
    cSql = cSql & dRutCliente & ","
    cSql = cSql & dCodigoRut & ","
    cSql = cSql & "'" & cTipOperacion & "',"
    cSql = cSql & nNumoper & ","
    cSql = cSql & iCorrela & ","
    cSql = cSql & iForpago & ","
    cSql = cSql & dMtoOper
    
    If miSQL.SQL_Execute(cSql) <> 0 Then Exit Function
    
    If miSQL.SQL_Fetch(Datos()) <> 0 Then Exit Function
    iPlazoValuta = 0
    If cTipo = "VAL" Then
        iCodSETTLE = Datos(1)
        
        If Val(Datos(1)) = 6 Then
            nTotal = nTotal + 1
            dMtoSETTLE = Datos(3)   ' Monto Sobregiro
            iPlazoValuta = Datos(4) ' Plazo Valuta
            
            iContArrayLim = iContArrayLim + 1
            ReDim Preserve aVarLimites(iContArrayLim) As Variant
            aVarLimites(iContArrayLim) = Datos(2) & vbCrLf & vbCrLf & "Monto sobrepasado : " & Format$(Datos(3), "###,###,###,###,###,###,##0.00")
        End If
        
        If Val(Datos(1)) = 5 Then
 
            nTotal = nTotal + 1
            dMtoSETTLE = Datos(3)   ' Monto Sobregiro
            iPlazoValuta = Datos(4) ' Plazo Valuta
            iContArrayLim = iContArrayLim + 1
            ReDim Preserve aVarLimites(iContArrayLim) As Variant
            aVarLimites(iContArrayLim) = Datos(2)
             
        End If
    End If
    
    If Val(Datos(1)) = -1 Then
        MsgBox "Problemas con limites ", vbExclamation, "Validación SETTLEMENT"
        nTotal = nTotal + 1
    End If
    
    If nTotal <> 0 Then
        Screen.MousePointer = vbHourglass
        Exit Function
    End If
    

    funcValidaLimites_SETTLEMENT = True
    
End Function


'==================================================================================================================================
 Public Function funcRebajoLimites(dEmisor As Long, dFecvcto As Date, cFamilia As String, dMonto As Double, cTpoAction As String) As Boolean
'==================================================================================================================================
'   Función     :   funcRebajoLimites
'   Objetivo    :   Realiza la rebaja de los limites involucrados en las ventas definitivas
'   Fecha       :   Junio 2000
'   Autor       :   Victor Barra
'==================================================================================================================================
Dim cSql As String
Dim Datos()
Dim cAccion As String * 3

    cAccion = IIf(cTpoAction = "Q", "VAL", IIf(cTpoAction = "S", "CAR", "DES"))

    funcRebajoLimites = False
  ' ====================================================+
  ' Elimino Limites articulo 84                         |
  ' ----------------------------------------------------+

    cSql = "EXECUTE SP_LIMITES_ART84 "
    cSql = cSql & "'" & cTpoAction & "',"
    cSql = cSql & dEmisor & ","
    cSql = cSql & dMonto
    
    If miSQL.SQL_Execute(cSql) <> 0 Then Exit Function
    
    If miSQL.SQL_Fetch(Datos()) <> 0 Then Exit Function
            
    If Datos(1) = "NOD" Then
        MsgBox Datos(2), vbExclamation, "Limites Articulo 84"
        Exit Function
    End If
    
    If Datos(1) = "NOS" Then
        MsgBox Datos(2), vbExclamation, "Limites Articulo 84"
        Exit Function
    End If
    
  ' ====================================================+
  ' Elimino Limites Emisor/Instrumento/Plazo            |
  ' ----------------------------------------------------+
    cSql = "EXECUTE SP_LIMITES_EMISOR "
    cSql = cSql & "'" & Format$(gsBac_Fecp, "yyyymmdd") & "',"
    cSql = cSql & "'" & cAccion & "', "
    cSql = cSql & dEmisor & ","
    cSql = cSql & "'" & cFamilia & "', "
    cSql = cSql & "'" & Format$(dFecvcto, "yyyymmdd") & "', "
    cSql = cSql & dMonto & ","
    cSql = cSql & IIf(cAccion = "DES", NumeroOperacionExceso, 0)

    If miSQL.SQL_Execute(cSql) <> 0 Then Exit Function
    
    If miSQL.SQL_Fetch(Datos()) <> 0 Then Exit Function

    If Val(Datos(1)) = -1 Then
        MsgBox "Problemas con limites ", vbExclamation, "Limites Emisor/Instrumento/Plazo"
        Exit Function
    End If

    funcRebajoLimites = True

End Function


'=============================================================================================
 Public Function funcValidacionART84CP(Hwnd As Long, TipoART84 As String, ByRef cExisteDPX As Boolean) As Boolean
 '=============================================================================================
'   Función     :   funcValidacionART84
'   Objetivo    :   Realiza la validación de Información en relación sobre limites de ART.84
'=============================================================================================
Dim Datos()
Dim cSql         As String
Dim rRs          As Recordset
Dim dTotal       As Double
Dim dRut         As Double
Dim nTotal       As Integer
Dim nTotPFE      As Double
Dim nTotCCE      As Double
Dim Valor_moneda As Double
Dim bInstDPX     As Boolean

    funcValidacionART84CP = False

On Error GoTo ErrART84

    Set BacFrmIRF = BacTrader.ActiveForm
    
    Valor_moneda = FUNC_BUSCA_VALOR_MONEDA(988, Format(gsBac_Fecp, "DD/MM/YYYY"))

    bInstDPX = False
    If BacFrmIRF.Data1.Recordset.RecordCount = 1 Then
        BacFrmIRF.Data1.Recordset.MoveFirst
        If BacFrmIRF.Data1.Recordset("tm_monemi") = 13 Then
            bInstDPX = True
        End If
    End If
   
    nTotal = 0
  ' Conformo senetencia SQL para obtener total por emisor en operación Ingresada
    cSql = "SELECT tm_rutemi, SUM(tm_mt) AS total FROM mdcp WHERE tm_hwnd = " & Hwnd & " GROUP BY tm_rutemi"
    
    Set rRs = db.OpenRecordset(cSql, dbOpenSnapshot)
    
    If rRs.RecordCount > 0 Then
        If Not IsNull(rRs.Fields("Total")) And Not IsNull(rRs.Fields("tm_rutemi")) Then
            rRs.MoveFirst
            
            Do While Not rRs.EOF
                dTotal = rRs.Fields("total")
                dRut = rRs.Fields("tm_rutemi")
                
                cSql = "EXECUTE SP_LIMITES_ART84 "
                cSql = cSql & "'" & TipoART84 & "',"
                cSql = cSql & dRut & ","
                
              ' Parafernalia para DPX
              ' ------------------------------------
                If bInstDPX Then
                    cSql = cSql & Format(dTotal * Valor_moneda, "#####0")
                Else
                    cSql = cSql & dTotal
                End If
              ' ------------------------------------
                If miSQL.SQL_Execute(cSql) <> 0 Then Exit Do
                
                If miSQL.SQL_Fetch(Datos()) <> 0 Then Exit Do
                
                If Datos(1) = "NOQ" Then
                    MsgBox Datos(2) + vbCrLf + vbCrLf + "Monto con que sobrepasa : " & Format$(CDbl(Datos(4)) - CDbl(Datos(3)), "###,###,###,###,###,##0"), vbExclamation, "Validación limites ART 84"
                    nTotal = nTotal + 1
                End If
                
                If Datos(1) = "NOE" Or Datos(1) = "NOS" Then
                    MsgBox Datos(2), vbExclamation, "Validación limites ART 84"
                    nTotal = nTotal + 1
                End If
                              
                rRs.MoveNext
            Loop
            
        End If
    End If
    
    cExisteDPX = bInstDPX
    
    If nTotal <> 0 Then
        Screen.MousePointer = vbHourglass
        Exit Function
    End If
    
    funcValidacionART84CP = True
    Exit Function
    
ErrART84:
    MsgBox "Problemas en chequeo de limites Articulo 84", vbExclamation, gsBac_Version
    Exit Function

End Function


'=============================================================================================
 Public Function funcValidacionLimites_CI(dRut As Double, dTotal As Double, TipoART84 As String) As Boolean
'=============================================================================================
'   Función     :   funcValidacionLimites_CI
'   Objetivo    :   Realiza la validación de Información en relación sobre limites de ART.84
'=============================================================================================
Dim cSql    As String
Dim nTotal  As Integer
Dim Datos()

On Error GoTo ErrART84

    Set BacFrmIRF = BacTrader.ActiveForm

    funcValidacionLimites_CI = False
    
    cSql = "EXECUTE SP_LIMITES_ART84 "
    cSql = cSql & "'" & TipoART84 & "',"
    cSql = cSql & dRut & ","
    cSql = cSql & dTotal

    If miSQL.SQL_Execute(cSql) <> 0 Then Exit Function
    
    If miSQL.SQL_Fetch(Datos()) <> 0 Then Exit Function
    
    If Datos(1) = "NOQ" Then
        MsgBox Datos(2) + vbCrLf + vbCrLf + "Monto con que sobrepasa : " & Format$(CDbl(Datos(4)) - CDbl(Datos(3)), "###,###,###,###,###,##0"), vbExclamation, "Validación limites ART 84"
        nTotal = nTotal + 1
    End If
    
    If Datos(1) = "NOS" Then
        MsgBox Datos(2) + vbCrLf + vbCrLf + "Monto con que sobrepasa : " & Format$(CDbl(Datos(4)) - CDbl(Datos(3)), "###,###,###,###,###,##0"), vbExclamation, "Validación limites ART 84"
        nTotal = nTotal + 1
    End If
    
    
    If nTotal <> 0 Then
        Screen.MousePointer = vbHourglass
        Exit Function
    End If
    
    funcValidacionLimites_CI = True
    Exit Function
    
ErrART84:
    MsgBox "Problemas en chequeo de limites Articulo 84", vbExclamation, gsBac_Version
    Exit Function

End Function



'=============================================================================================
 Public Function funcValidacionLimites_IB(dRut As Double, dTotal As Double, TipoLimite As String, dFecvcto As String, cFamilia As String, ByRef iCodexcesoIB As Integer, dMtoExcesoIB As Double) As Boolean
'=============================================================================================
'   Función     :   funcValidacionLimites_IB
'   Objetivo    :   Realiza la validación de Información en relación sobre limites de ART.84.
'                   Ademas se debe validar el limite por Emisor/Instrumento/Plazo
'=============================================================================================
Dim cSql    As String
Dim nTotal  As Integer
Dim Datos()
Dim cTipo As String * 3
On Error GoTo ErrART84

    Set BacFrmIRF = BacTrader.ActiveForm

    funcValidacionLimites_IB = False
    
    cTipo = IIf(TipoLimite = "Q", "VAL", IIf(TipoLimite = "S", "CAR", "DES"))
    
    If cFamilia = "ICOL" Then
        cSql = "EXECUTE SP_LIMITES_ART84 "
        cSql = cSql & "'" & TipoLimite & "',"
        cSql = cSql & dRut & ","
        cSql = cSql & dTotal
    
        If miSQL.SQL_Execute(cSql) <> 0 Then Exit Function
        
        If miSQL.SQL_Fetch(Datos()) <> 0 Then Exit Function
        
        If Datos(1) = "NOQ" Then
            MsgBox Datos(2) + vbCrLf + vbCrLf + "Monto con que sobrepasa : " & Format$(CDbl(Datos(4)) - CDbl(Datos(3)), "###,###,###,###,###,##0"), vbExclamation, "Validación limites ART 84"
            nTotal = nTotal + 1
        End If
        
        If Datos(1) = "NOS" Then
            MsgBox Datos(2), vbExclamation, "Validación limites ART 84"
            nTotal = nTotal + 1
        End If
        
        If nTotal <> 0 Then
            Screen.MousePointer = vbHourglass
            iCodexcesoIB = -1
            Exit Function
        End If
    End If
    
    cSql = "EXECUTE SP_LIMITES_EMISOR "
    cSql = cSql & "'" & Format$(gsBac_Fecp, "yyyymmdd") & "',"
    cSql = cSql & "'" & cTipo & "', "
    cSql = cSql & dRut & ","
    cSql = cSql & "'" & cFamilia & "', "
    cSql = cSql & "'" & Format$(dFecvcto, "yyyymmdd") & "', "
    cSql = cSql & dTotal & ","
    cSql = cSql & IIf(cTipo = "DES", NumeroOperacionExceso, 0)

    If miSQL.SQL_Execute(cSql) <> 0 Then Exit Function
    
    If miSQL.SQL_Fetch(Datos()) <> 0 Then Exit Function
    
    iCodexcesoIB = Val(Datos(1))
    
    If cTipo = "VAL" Then
        If Val(Datos(1)) = 8 Then
          'l  MsgBox Datos(2) & vbCrLf & vbCrLf & "Monto sobrepasado : " & Format$(Datos(3), "###,###,###,###,###,###,##0.00"), vbExclamation, "Validación Emisor/Instrumento/Plazo"
            nTotal = nTotal + 1
            dMtoExcesoIB = Datos(3)
          ' Actualizo arreglo de errores
          ' ----------------------------------------------------------
            iContArrayLim = iContArrayLim + 1
            ReDim Preserve aVarLimites(iContArrayLim) As Variant
            aVarLimites(iContArrayLim) = Datos(2) & vbCrLf & vbCrLf & "Monto sobrepasado : " & Format$(Datos(3), "###,###,###,###,###,###,##0.00")
          ' ----------------------------------------------------------
            
        End If
        
        If Val(Datos(1)) = 7 Then
            nTotal = nTotal + 1
            dMtoExcesoIB = Datos(3)
            
            iContArrayLim = iContArrayLim + 1
            ReDim Preserve aVarLimites(iContArrayLim) As Variant
            aVarLimites(iContArrayLim) = Datos(2)
        End If
    End If
    
    If Val(Datos(1)) = -1 Then
        MsgBox "Problemas con limites ", vbExclamation, "Validación Emisor/Instrumento/Plazo"
        nTotal = nTotal + 1
    End If
    
    If nTotal <> 0 Then
        Screen.MousePointer = vbHourglass
        Exit Function
    End If
    
    funcValidacionLimites_IB = True
    Exit Function
    
ErrART84:
    MsgBox "Problemas en chequeo de limites Articulo 84", vbExclamation, gsBac_Version
    Exit Function

End Function


'===============================================================================================================================================
 Public Function funcAnulaLimites(varRutEmisor As Variant, pGrilla As Object, varFecVcto As Variant, varSerie As Variant, cTipoperAn As String)
'===============================================================================================================================================
'   Función     :   FuncAnulaLimites
'   Objetivo    :   Realiza la actualización de los limites en relación cuando se anula una operación
'   Fecha       :   Junio 2000
'   Autor       :   Victor Barra Fuentes
'===============================================================================================================================================
Dim nPos    As Integer
Dim dRut    As Long
Dim dTotal  As Double
Dim dFecv   As Date
Dim cSql    As String
Dim cSerie  As String
Dim Datos()
Dim dMontoDolar988 As Double

On Error GoTo ErrDeleteLimites


    dMontoDolar988 = FUNC_BUSCA_VALOR_MONEDA(998, Format(gsBac_Fecp, "DD/MM/YYYY"))

    For nPos = 1 To pGrilla.Rows - 1
    
        pGrilla.Row = nPos
        pGrilla.Col = 7
        
        
        dTotal = CDbl(pGrilla.Text)
        
        dRut = varRutEmisor(nPos)
        dFecv = varFecVcto(nPos)
        cSerie = varSerie(nPos)
        If Trim$(cSerie) = "DPX" Then
            dTotal = Format$((dTotal * dMontoDolar988), "#######0")
        End If
        
        Call funcRebajoLimites(dRut, dFecv, cSerie, dTotal, IIf(cTipoperAn = "CP", "D", "S"))
        
    Next nPos
    
    Exit Function
    
ErrDeleteLimites:
    MsgBox "Problemas en elimnación de limites: " & err.Description, vbCritical, gsBac_Version
    Exit Function
End Function
'=============================================================================================
 Public Function funcValidaEmisorInstPlazoCP(Hwnd As Long, TipoLimite As String, ByRef cExisteDPX As Boolean) As Boolean
'=============================================================================================
'   Función     :   funcValidaEmisorInstPlazoCP
'   Objetivo    :   Realiza la validación de Información en relación sobre limites
'                   de Emisor Instrumento Plazo
'=============================================================================================
Dim cSql        As String
Dim cFamilia    As String
Dim cFecVcto    As String * 10
Dim dTotal      As Double
Dim dRut        As Double
Dim nTotal      As Integer
Dim rRs         As Recordset
Dim cTipo       As String * 3
Dim bMto        As Boolean
Dim Datos()
Dim dMontoSobregiro As Double
Dim Valor_moneda As Double
Dim bInstDPX    As Boolean
On Error GoTo EmisInstPlazo


    Valor_moneda = FUNC_BUSCA_VALOR_MONEDA(988, Format(gsBac_Fecp, "DD/MM/YYYY"))

    bInstDPX = False
    
    If BacFrmIRF.Data1.Recordset.RecordCount = 1 Then
        BacFrmIRF.Data1.Recordset.MoveFirst
        If BacFrmIRF.Data1.Recordset("tm_monemi") = 13 Then
            bInstDPX = True
        End If
    End If

    cTipo = IIf(TipoLimite = "Q", "VAL", IIf(TipoLimite = "S", "CAR", "DES"))
    
    Set BacFrmIRF = BacTrader.ActiveForm

    funcValidaEmisorInstPlazoCP = False
    nTotal = 0
    cSql = "SELECT tm_rutemi, tm_serie, tm_fecven, SUM(tm_mt) AS total FROM mdcp WHERE tm_hwnd = " & Hwnd & " GROUP BY  tm_rutemi, tm_serie, tm_fecven "
    
    Set rRs = db.OpenRecordset(cSql, dbOpenSnapshot)
    
    If rRs.RecordCount > 0 Then
    
        If Not IsNull(rRs.Fields("Total")) And _
           Not IsNull(rRs.Fields("tm_rutemi")) And _
           Not IsNull(rRs.Fields("tm_serie")) And _
           Not IsNull(rRs.Fields("tm_fecven")) Then
        
            rRs.MoveFirst
            
            Do While Not rRs.EOF
            
                dTotal = rRs.Fields("total")
                dRut = rRs.Fields("tm_rutemi")
                cFamilia = rRs.Fields("tm_serie")
                cFecVcto = rRs.Fields("tm_fecven")
                
                cSql = "EXECUTE SP_LIMITES_EMISOR "
                cSql = cSql & "'" & Format$(gsBac_Fecp, "yyyymmdd") & "',"
                cSql = cSql & "'" & cTipo & "', "
                cSql = cSql & dRut & ","
                cSql = cSql & "'" & cFamilia & "', "
                cSql = cSql & "'" & Format$(cFecVcto, "yyyymmdd") & "', "
              ' Parafernalia para DPX
              ' ------------------------------------
                If bInstDPX Then
                    cSql = cSql & Format(dTotal * Valor_moneda, "#####0") & ","
                Else
                    cSql = cSql & dTotal & ","
                End If
              ' ------------------------------------
                
                cSql = cSql & IIf(cTipo = "DES", NumeroOperacionExceso, 0)

                If miSQL.SQL_Execute(cSql) <> 0 Then Exit Do
                
                If miSQL.SQL_Fetch(Datos()) <> 0 Then Exit Do
                
                If cTipo = "VAL" Then
                
                    If Val(Datos(1)) = 8 Then
                         nTotal = nTotal + 1
                        dMontoSobregiro = Datos(3)
                        
                      ' Actualizo arreglo de errores
                      ' ----------------------------------------------------------
                        iContArrayLim = iContArrayLim + 1
                        ReDim Preserve aVarLimites(iContArrayLim) As Variant
                        aVarLimites(iContArrayLim) = Datos(2) & vbCrLf & vbCrLf & "Monto sobrepasado : " & Format$(Datos(3), "###,###,###,###,###,###,##0.00")
                      ' ----------------------------------------------------------
                    End If
                    
                    If Val(Datos(1)) = 7 Then
                        dMontoSobregiro = Datos(3)
                        nTotal = nTotal + 1
                        
                        iContArrayLim = iContArrayLim + 1
                        ReDim Preserve aVarLimites(iContArrayLim) As Variant
                        aVarLimites(iContArrayLim) = Datos(2)
 
                    End If
                    
                  ' Grabo códigos de exceso en Data1
                  ' =================================================================
                    If Val(Datos(1)) = 7 Or Val(Datos(1)) = 8 Then
                    bMto = False
                    
                    BacFrmIRF.Data1.Recordset.MoveFirst
                    
                    Do While Not BacFrmIRF.Data1.Recordset.EOF
                        If BacFrmIRF.Data1.Recordset("tm_rutemi") = dRut Then
                            BacFrmIRF.Data1.Recordset.Edit
                            If Not bMto Then
                                BacFrmIRF.Data1.Recordset("tm_mtoexceso") = dMontoSobregiro
                                bMto = True
                            End If
                            BacFrmIRF.Data1.Recordset("tm_codexceso") = Val(Datos(1))
                            BacFrmIRF.Data1.Recordset.Update
                        End If
                        BacFrmIRF.Data1.Recordset.MoveNext
                        
                    Loop
                  ' =================================================================
                    End If
                End If
                
                If Val(Datos(1)) = -1 Then
                    MsgBox "Problemas con limites ", vbExclamation, "Validación Emisor/Instrumento/Plazo"
                    nTotal = nTotal + 1
                End If
                
                
                rRs.MoveNext
            Loop
            
        End If
    End If
    
    cExisteDPX = bInstDPX
    
    If nTotal <> 0 Then
        Screen.MousePointer = vbHourglass
        Exit Function
    End If
    
    funcValidaEmisorInstPlazoCP = True

    Exit Function
    
EmisInstPlazo:
    MsgBox "Problemas en chequeo de limites Emisor/Instrumento/Plazo: " & err.Description, vbExclamation, gsBac_Version
    Exit Function
End Function




'=======================================================================================================================================
 Public Function funcVerificaLimitesModificacion(cTipOper As String, dRut As Double, dTotal As Double, dFecvcto As String, cInst As String, ByRef cEstado As String, cAction As String, dNumoper As Double, iForpago As Integer, dCodigo As Double, bValidaPFE_CCCE As Boolean, dMtoPFE As Double, dMtoCCE As Double) As Boolean
'=======================================================================================================================================
'   Función     :   funcVerificaLimitesModificacion
'   Objetivo    :   Realiza la validación de Información en relación sobre limites
'                   cuando se realice una modificación de operación por el nuevo cliente.
'=======================================================================================================================================
Dim cSql        As String
Dim cFamilia    As String
Dim cFecVcto    As String * 10
Dim nTotal      As Integer
Dim cTipo       As String * 3
Dim Datos()
Dim cAccion     As String
 
'On Error GoTo ErrLimMod

    cAccion = IIf(cAction = "Q", "VAL", IIf(cAction = "D", "DES", "CAR"))
    
    funcVerificaLimitesModificacion = False
    cEstado = "OK"
    Select Case cTipOper
        Case "CI"
            If Not funcValidacionLimites_CI(dRut, dTotal, cAction) Then Exit Function
            If bValidaPFE_CCCE Then
                If Not funcLimitesModificacion_PFECCE(dRut, dCodigo, dTotal, dFecvcto, "CI", cAccion, dMtoPFE, dMtoCCE) Then
                    cEstado = "NO"
                Else
                    cEstado = "OK"
                End If
            End If
            
        Case "VI"
            If bValidaPFE_CCCE Then
                If Not funcLimitesModificacion_PFECCE(dRut, dCodigo, dTotal, dFecvcto, "VI", cAccion, dMtoPFE, dMtoCCE) Then
                    cEstado = "NO"
                Else
                    cEstado = "OK"
                End If
            
            End If
            
        Case "IB"
            cEstado = IIf(funcValidacionLimites_IB(dRut, dTotal, cAction, dFecvcto, cInst, 0, 0), "OK", "NO")
        
    End Select
    
  ' VB+- 28/07/2000 se descartan el control de limites settlement para las operaciones
  ' de Compras con pacto , Ventas con Pacto e Interbancarios
  ' ==========================================================================================
    If cTipOper <> "IB" And cTipOper <> "CI" And cTipOper <> "VI" Then
        If Not funcValidaLimites_SETTLEMENT(dRut, dCodigo, cTipOper, dNumoper, 1, iForpago, dTotal, cAction, 0, 0, 0) Then
            cEstado = "NO"
        End If
    End If
  ' ==========================================================================================
    funcVerificaLimitesModificacion = True
        
    Exit Function
ErrLimMod:
    MsgBox "Problemas en chequeo de limites: " & err.Description, vbCritical, gsBac_Version
    Exit Function
End Function

