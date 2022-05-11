Attribute VB_Name = "BacLimEndeudamiento"
Option Explicit
'-----------------------------------------------------------
'
'           MODULO BACLIMENDEUDAMIENTO.BAS :
'           Incorporado para implementar limites de endeudamientos
'           Incorporada 08-Nov-2001
'-----------------------------------------------------------
Global d_OP_LIM                   As String
Global d_producto                 As String
Global d_Monto_Perdida_DifT       As Double
Global d_diez_porciento           As Double
Global d_tres_porciento           As Double
Global d_Monto_Final_Dif          As Double
Global d_Monto_Perdida_Dif        As Double
Global d_Monto_USD                As Double
Global d_Monto_CLP                As Double
Global d_Mtodif                   As Double
Global d_MtoUSD                   As Double
Global d_MtoCLP                   As Double
Global Autoriza_Grabacion_Limite  As Boolean
Global xexistepapelusd            As Boolean
Global numope   As Double


'***************************************************************
'**********  Garantias *****************************************
'***************************************************************
Global Grt_Garantia, Grt_GarantiaX, Grt_GarantiaOpc As Double
Global Grt_Entidad                  As Integer
Global Grt_Datos, Grt_Plazo         As Integer
Global Grt_Mensaje                  As String
Global Grt_MensPreg                 As String
Global Grt_Garantizar               As Boolean
'Global Const Grt_Base = "PBBDD000.." 'base del sistema parametro


'***************************************************************
'***************************************************************
'***************************************************************
Global d_Plazo                    As Integer

'***************************************************************
'**********  Liquidez *****************************************
'***************************************************************
Global Liq_estado                   As Integer
Global Liq_Mensaje                  As String
Global Liq_Mto_Erning_Assets        As Double
Global Liq_Limite_Deficit_Intraday  As Double
Global Liq_Porcentaje_Primer_Tramo  As Double
Global Liq_Porcentaje_Segundo_Tramo As Double
Global Liq_Monto_Primer_Tramo       As Double
Global Liq_Monto_Segundo_Tramo      As Double
Global Liq_Caja_IBL_Bisa_30         As Double
Global Liq_Caja_IBL_Bisa_90         As Double
Global Liq_Cartera_Trading          As Double
Global Liq_Posicion_Hedge           As Double
Global Liq_Posicion_Fordward        As Double
Global Liq_Posicion_Trading         As Double
Global Liq_Saldo_Total_Manana       As Double
Global Liq_Saldo_Caja_Depurado_30   As Double
Global Liq_Saldo_Caja_Depurado_90   As Double
Global Liq_Monto_Operacion          As Double
Global Liq_Exceso                   As Double
Global Liq_Tipo_Operacion           As String
Global Liq_Plazo_Operacion          As Double


Public Function Chequea_Lineas_End(cSistema, cTipOper As String, nRutcli, nCodcli, nMonto As Double, iEntidad As Integer, iTipo_Porcentaje As Integer) As Boolean
Dim Dato()

    Chequea_Lineas_End = False

    Envia = Array()
    AddParam Envia, cSistema
    AddParam Envia, cTipOper
    AddParam Envia, CDbl(nRutcli)
    AddParam Envia, CDbl(nCodcli)
    AddParam Envia, CDbl(nMonto)
    AddParam Envia, iEntidad
    AddParam Envia, iTipo_Porcentaje
    
    If Not Bac_Sql_Execute(giSQL_DatabaseCommon & "..Sp_ChkLimite_Deuda", Envia) Then
        MsgBox "Problemas al Chequear lineas de Endeudamiento", 16, TITSISTEMA
        Exit Function
    Else
        If Bac_SQL_Fetch(Dato) Then
            Grt_Datos = Dato(1)
            Grt_Mensaje = Dato(2)
            Grt_Garantia = CDbl(Dato(3))
            Grt_MensPreg = Dato(8)
            Chequea_Lineas_End = True
        End If
    End If

End Function
Public Sub Mensajes_Liquidez()
'Dim Datos()
'Dim cMensaje As String
'Dim iEstado As Integer
'
'    iEstado = 0
'    cMensaje = ""
'    If Bac_SQL_Fetch(Datos()) Then
'        If Datos(1) = "1" Then
'            cMensaje = cMensaje & Datos(2) & vbCrLf
'            iEstado = 1
'        End If
'    End If
'
'    If iEstado > 0 Then
'        MsgBox "Advertencia : " + Chr(10) + Chr(13) + Chr(10) + Chr(13) + cMensaje, vbInformation, "Advertencia LImite de Liquidez"
'    End If

End Sub
Public Function Chequea_Liquidez(nMonto As Double, cTipOper As String, iForpag As Integer, nPlazo As Double) As Boolean
Dim Dato()
Dim cMensaje As String
Dim iEstado As Integer
    On Error GoTo Err_Liq
    Chequea_Liquidez = True
    
    Liq_estado = 0
    Liq_Mensaje = Space(30)
    Liq_Mto_Erning_Assets = 0
    Liq_Limite_Deficit_Intraday = 0
    Liq_Porcentaje_Primer_Tramo = 0
    Liq_Porcentaje_Segundo_Tramo = 0
    Liq_Monto_Primer_Tramo = 0
    Liq_Monto_Segundo_Tramo = 0
    Liq_Caja_IBL_Bisa_30 = 0
    Liq_Caja_IBL_Bisa_90 = 0
    Liq_Cartera_Trading = 0
    Liq_Posicion_Hedge = 0
    Liq_Posicion_Fordward = 0
    Liq_Posicion_Trading = 0
    Liq_Saldo_Total_Manana = 0
    Liq_Saldo_Caja_Depurado_30 = 0
    Liq_Saldo_Caja_Depurado_90 = 0
    Liq_Exceso = 0

    Envia = Array()
    AddParam Envia, Round(nMonto / gsValor_DO, 2)
    AddParam Envia, cTipOper
    AddParam Envia, iForpag
    AddParam Envia, nPlazo
    
    If Not Bac_Sql_Execute(giSQL_DatabaseCommon & "..Sp_ChkLimite_Liquidez", Envia) Then
        MsgBox "Problemas al Chequear Limites de Liquidez", 16, TITSISTEMA
        Exit Function
    Else
        iEstado = 0
        cMensaje = ""
        Do While Bac_SQL_Fetch(Dato())
            If Dato(1) = "1" Then
                cMensaje = cMensaje & Dato(2) & Format(Dato(20), "###,###.00") & vbCrLf
                Liq_estado = Dato(1)
                Liq_Mensaje = Dato(2)
                Liq_Mto_Erning_Assets = Dato(3)
                Liq_Limite_Deficit_Intraday = Dato(4)
                Liq_Porcentaje_Primer_Tramo = Dato(5)
                Liq_Porcentaje_Segundo_Tramo = Dato(6)
                Liq_Monto_Primer_Tramo = Dato(7)
                Liq_Monto_Segundo_Tramo = Dato(8)
                Liq_Caja_IBL_Bisa_30 = Dato(9)
                Liq_Caja_IBL_Bisa_90 = Dato(10)
                Liq_Cartera_Trading = Dato(11)
                Liq_Posicion_Hedge = Dato(12)
                Liq_Posicion_Fordward = Dato(13)
                Liq_Posicion_Trading = Dato(14)
                Liq_Saldo_Total_Manana = Dato(15)
                Liq_Saldo_Caja_Depurado_30 = Dato(16)
                Liq_Saldo_Caja_Depurado_90 = Dato(17)
                Liq_Monto_Operacion = Dato(18)
                Liq_Plazo_Operacion = Dato(19)
                Liq_Exceso = Dato(20)
                iEstado = 1
            End If
        Loop
                
        If iEstado > 0 Then
            MsgBox "ADVERTENCIA : " + Chr(10) + Chr(13) + Chr(10) + Chr(13) + cMensaje, vbExclamation, "Advertencia LImite de Liquidez"
        End If

    End If
    Exit Function
    
Err_Liq:
    MsgBox err.Description & " (Limite Liquidez)", vbCritical, TITSISTEMA
    
End Function



