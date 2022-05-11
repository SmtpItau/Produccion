Attribute VB_Name = "Module1"
Option Explicit

Public Function Chequea_ControlProcesos(pareProceso As String) As Boolean
Dim gsBac_FM   As String
Dim varssql    As String
Dim varvDataSql()

On Error GoTo ErrChequeo

    Chequea_ControlProcesos = False
    
    varssql = "SP_SW_PARAMETROS "
    
    If miSQL.SQL_Execute(varssql) = 0 Then
    
        Do While miSQL.SQL_Fetch(varvDataSql) = 0
            
            Select Case pareProceso
            
                Case "ID"   ' Inicio de día
                    ' 1.- Se valida que se haya realizado el fin de día
                    ' 2.- Se debe validar que no se haya realizado apertura de mesa
                    ' 3.- se debe validar que no se haya realizado
                    If Val(varvDataSql(9)) = 1 Then
                        If Val(varvDataSql(7)) = 1 Then
                            If Val(varvDataSql(1)) = 0 Then
                                Chequea_ControlProcesos = True
                                Exit Function
                            Else
                                MsgBox "Proceso de inicio de día ya realizado, continue con proceso  de apertura de mesa", vbInformation, gsBac_Version
                                Exit Function
                            End If
                        Else
                            MsgBox " Se ha realizado el proceso correcto de cierre", vbInformation, gsBac_Version
                            Exit Function
                        End If
                    Else
                        MsgBox "Proceso de fin de día no se ha realizado, Verifique control de procesos. ", vbExclamation, gsBac_Version
                        Exit Function
                    End If
                    
            Case "RC"   ' Recompras
                    ' 1.- Se valida que se haya realizado el Inicio de día
                    ' 2.- Se debe validar que no se haya el proceso
                    If Val(varvDataSql(1)) = 1 Then
                        If Val(varvDataSql(2)) = 0 Then
                            Chequea_ControlProcesos = True
                            Exit Function
                        Else
                            MsgBox "Proceso de Recompras ya realizado", vbInformation, gsBac_Version
                            Exit Function
                        End If
                    Else
                        MsgBox "Proceso de fin de día no se ha realizado, Verifique control de procesos. ", vbExclamation, gsBac_Version
                        Exit Function
                    End If

            Case "RV"   ' Reventas
                    ' 1.- Se valida que se haya realizado el fin de día
                    ' 2.- Se debe validar que no se haya realizado apertura de mesa
                    ' 3.- se debe validar que no se haya realizado
                    If Val(varvDataSql(1)) = 1 Then
                        If Val(varvDataSql(2)) = 1 Then
                            If Val(varvDataSql(3)) = 0 Then
                                Chequea_ControlProcesos = True
                                Exit Function
                            Else
                                MsgBox "Proceso de reventas ya realizado", vbInformation, gsBac_Version
                                Exit Function
                            End If
                        Else
                            MsgBox "No se ha realizado el proceso de Recomrpas, Realice el proceso de recompras ", vbInformation, gsBac_Version
                            Exit Function
                        End If
                    Else
                        MsgBox "Proceso de Inicio de día no se ha realizado, Verifique control de procesos. ", vbExclamation, gsBac_Version
                        Exit Function
                    End If

                    
                Case "OP" ' Operaciones
                    ' 1.- Se valida que se haya realizado el Inicio de día
                    ' 2.- Se debe validar que se haya realizado apertura de mesa
                    If Val(varvDataSql(1)) = 1 Then
                        If Val(varvDataSql(3)) = 1 Then
                            If Val(varvDataSql(7)) = 0 Then
                                Chequea_ControlProcesos = True
                                Exit Function
                            Else
                                MsgBox "Mesa bloqueada", vbCritical, gsBac_Version
                                Exit Function
                            End If
                        Else
                            MsgBox "Proceso de reventas no se ha realizado, realice este proceso antes de ingresar operaciones", vbInformation, gsBac_Version
                            Exit Function
                        End If
                    Else
                        MsgBox "Proceso de Inicio de día NO se ha realizado, Realice este proceso antes de ingresar operaciones. ", vbExclamation, gsBac_Version
                        Exit Function
                    End If
                    
                Case "CN" ' Contabilidad
                    ' 1.- Se debe realizar proceso de cierre de mesa
                    ' 2.- que no se haya realizado el proceso de contabilidad
                    If Val(varvDataSql(7)) = 1 Then
                        If Val(varvDataSql(3)) = 1 Then
                            If Val(varvDataSql(4)) = 0 Then
                                Chequea_ControlProcesos = True
                                Exit Function
                            Else
                                MsgBox "Proceso de contabilización automatica ya fue realizado", vbExclamation, gsBac_Version
                                Exit Function
                            End If
                        Else
                            MsgBox "Proeceso de Reventas no se ha realizado", vbExclamation, gsBac_Version
                            Exit Function
                        End If
                    Else
                        MsgBox "Proceso de cierre de mesa no se ha realizado. Cierre la mesa antes de contabilizar ", vbExclamation, gsBac_Version
                        Exit Function
                    End If
                    
                Case "DV" ' Devengamiento
                    ' 1.- Se debe realizar proceso de contabilidad
                    ' 2.- que no se haya realizado el proceso de devengamiento
                    If Val(varvDataSql(4)) = 1 Then
                        'If Val(varvDataSql(5)) = 0 Then
                            Chequea_ControlProcesos = True
                            Exit Function
                        'Else
                        '    MsgBox "Proceso de devengamiento ya fue realizado", vbExclamation, gsBac_Version
                        '    Exit Function
                        'End If
                    Else
                        gsBac_FM = CDate("01/" + Str(Month(gsBac_Fecp)) + "/" + Str(Year(gsBac_Fecp)))
                        gsBac_FM = DateAdd("m", 1, gsBac_FM)
                        gsBac_FM = DateAdd("d", -1, gsBac_FM)

                        If gsBac_Fecp <> gsBac_FM And gsBac_Fecx > gsBac_FM Then
                            Chequea_ControlProcesos = True
                            Exit Function
                        Else
                           MsgBox "Proceso de contabilización no se ha realizado. Realice proceso de contabilización antes de devengar.", vbExclamation, gsBac_Version
                           Exit Function
                        End If

                    End If
                    
                Case "RENT"
                
                    If Val(varvDataSql(9)) = 1 Then
                       MsgBox "Proceso de fin de dia ya realizado.", vbExclamation, gsBac_Version
                       Exit Function
                    End If
                    
                    If Val(varvDataSql(7)) = 0 Then
                       MsgBox "Proceso cierre de mesa no realizado.", vbExclamation, gsBac_Version
                       Exit Function
                    End If
                    
                    If Val(varvDataSql(4)) = 0 Then
                       MsgBox "Proceso de contabilización no realizado.", vbExclamation, gsBac_Version
                       Exit Function
                    End If
                    
                    If Val(varvDataSql(22)) = 0 Then
                       MsgBox "Proceso de Devengamiento de Cartera propia No realizado.", vbExclamation, gsBac_Version
                       Exit Function
                    End If

                    If Val(varvDataSql(23)) = 0 Then
                       MsgBox "Proceso de Devengamiento de Compras con Pacto No realizado.", vbExclamation, gsBac_Version
                       Exit Function
                    End If

                    If Val(varvDataSql(24)) = 0 Then
                       MsgBox "Proceso de Devengamiento de Ventas con Pacto No realizado.", vbExclamation, gsBac_Version
                       Exit Function
                    End If


                    If Val(varvDataSql(25)) = 0 Then
                       MsgBox "Proceso de Devengamiento de Interbancarios No realizado.", vbExclamation, gsBac_Version
                       Exit Function
                    End If

                    Chequea_ControlProcesos = True

                    
                Case "FD" ' Fin de día
                    ' 1.- Se debe verificar que el fin de dia no este realizado
                    ' 2.- Se debe realizar proceso de cierre de mesa
                    ' 3.- Se debe realizar proceso de contabilizacion
                    ' 4.- Se debe realizar proceso de devengamiento
                    ' 5.- Se debe realizar proceso de reventas
                    ' 6.- Se debe realizar proceso de recompras
                    ' 7.- se debe realizar proceso de valorizacion Mark to Market
                    
                    If Val(varvDataSql(9)) = 1 Then
                       MsgBox "Proceso de fin de dia ya realizado.", vbExclamation, gsBac_Version
                       Exit Function
                    End If
                    
                    If Val(varvDataSql(7)) = 0 Then
                       MsgBox "Proceso cierre de mesa no realizado.", vbExclamation, gsBac_Version
                       Exit Function
                    End If
                    
                    If Val(varvDataSql(4)) = 0 Then
                       MsgBox "Proceso de contabilización no realizado.", vbExclamation, gsBac_Version
                       Exit Function
                    End If
                    
                    
                    If Val(varvDataSql(22)) = 0 Then
                       MsgBox "Proceso de Devengamiento de Cartera propia No realizado.", vbExclamation, gsBac_Version
                       Exit Function
                    End If

                    If Val(varvDataSql(23)) = 0 Then
                       MsgBox "Proceso de Devengamiento de Compras con Pacto No realizado.", vbExclamation, gsBac_Version
                       Exit Function
                    End If

                    If Val(varvDataSql(24)) = 0 Then
                       MsgBox "Proceso de Devengamiento de Ventas con Pacto No realizado.", vbExclamation, gsBac_Version
                       Exit Function
                    End If


                    If Val(varvDataSql(25)) = 0 Then
                       MsgBox "Proceso de Devengamiento de Interbancarios No realizado.", vbExclamation, gsBac_Version
                       Exit Function
                    End If

                    
                    If Val(varvDataSql(3)) = 0 Then
                       MsgBox "Proceso de reventas no realizado.", vbExclamation, gsBac_Version
                       Exit Function
                    End If
                    
                    If Val(varvDataSql(2)) = 0 Then
                       MsgBox "Proceso de recompras no realizado.", vbExclamation, gsBac_Version
                       Exit Function
                    End If


                    If Val(varvDataSql(12)) = 1 Then
                       MsgBox "Interfaz C08 No ha sido Generada", vbExclamation, gsBac_Version
                       Exit Function
                    End If
                    
                    If Val(varvDataSql(13)) = 1 Then
                       MsgBox "Interfaz CTA.CTE. No ha sido Generada", vbExclamation, gsBac_Version
                       Exit Function
                    End If

                    If Val(varvDataSql(14)) = 1 Then
                       MsgBox "Interfaz CTA.CTE.II No ha sido Generada", vbExclamation, gsBac_Version
                       Exit Function
                    End If
                    
''                    If Val(varvDataSql(16)) = 1 Then
''                       MsgBox "Interfaz D3 No ha sido Generada", vbExclamation, gsBac_Version
''                       Exit Function
''                    End If
                    
''                    If Val(varvDataSql(17)) = 0 And DatePart("M", gsBac_Fecp) <> DatePart("M", gsBac_Fecx) Then
''                       MsgBox "Interfaz de Clientes No ha sido Generada", vbExclamation, gsBac_Version
''                       Exit Function
''                    End If
                    
''                    If Val(varvDataSql(18)) = 0 And DatePart("M", gsBac_Fecp) <> DatePart("M", gsBac_Fecx) Then
''                       MsgBox "Interfaz de Colocaciones No ha sido Generada", vbExclamation, gsBac_Version
''                       Exit Function
''                    End If
                    
                    If Val(varvDataSql(19)) = 1 Then
                       MsgBox "Interfaz C14 No ha sido Generada", vbExclamation, gsBac_Version
                       Exit Function
                    End If
                    
                    If Val(varvDataSql(20)) = 1 Then
                       MsgBox "Interfaz RCC No ha sido Generada", vbExclamation, gsBac_Version
                       Exit Function
                    End If
                    
''                    If Val(varvDataSql(21)) = 0 And DatePart("M", gsBac_Fecp) <> DatePart("M", gsBac_Fecx) Then
''                       MsgBox "Interfaz de Gestion No ha sido Generada", vbExclamation, gsBac_Version
''                       Exit Function
''                    End If
                    
'''                    If Val(varvDataSql(26)) = 0 Then
'''                       MsgBox "Proceso de Calculo Rentabilidad No realizado.", vbExclamation, gsBac_Version
'''                       Exit Function
'''                    End If

                    
                    
                Chequea_ControlProcesos = True
                    
                Case "CM" ' Cierre de Mesa
                    ' 1.- Se debe realizar proceso de contabilidad
                    ' 2.- que no se haya realizado el proceso de devengamiento
                    If Val(varvDataSql(7)) = 1 Then  ' La mesa esta cerrada
                        If Val(varvDataSql(3)) = 1 Then
                            Chequea_ControlProcesos = True
                            Exit Function
                        Else
                            MsgBox "Proceso de reventas no se ha realizado, no se puede aperturar mesa", vbExclamation, gsBac_Version
                            Exit Function
                        End If
                    Else  ' La mesa esta abierta
                        If Val(varvDataSql(3)) = 1 Then
                            Chequea_ControlProcesos = True
                            Exit Function
                        Else
                            MsgBox "Proceso de reventas no se ha realizado, no se puede Cerrar mesa", vbInformation, gsBac_Version
                            Exit Function
                        End If

                    End If
                    
                Case "INT_C8"
                
                    If Val(varvDataSql(12)) = 1 Then
                       If MsgBox("Interfaz C08 Ya ha sido Generada, Vuelve a Generar", vbQuestion + vbYesNo, gsBac_Version) <> vbYes Then
                            Exit Function
                       End If
                    End If
                    
                    Chequea_ControlProcesos = True
                    
                    
               Case "INT_CTACTE"
                    
                    If Val(varvDataSql(13)) = 1 Then
                       If MsgBox("Interfaz CTA.CTE. Ya ha sido Generada, Vuelve a Generar", vbQuestion + vbYesNo, gsBac_Version) <> vbYes Then
                            Exit Function
                       End If
                    End If
                    
                    Chequea_ControlProcesos = True
                    
                    
               Case "INT_CTACTEII"

                    If Val(varvDataSql(14)) = 1 Then
                       If MsgBox("Interfaz CTA.CTE.II Ya ha sido Generada, Vuelve a Generar", vbQuestion + vbYesNo, gsBac_Version) <> vbYes Then
                            Exit Function
                       End If
                    End If
                    
                    Chequea_ControlProcesos = True
                    
                    
               Case "INT_D3"
                    
                    If Val(varvDataSql(16)) = 1 Then
                       If MsgBox("Interfaz D3 Ya ha sido Generada, Vuelve a Generar", vbQuestion + vbYesNo, gsBac_Version) <> vbYes Then
                            Exit Function
                       End If
                    End If
                    
                    Chequea_ControlProcesos = True
                    
                    
               Case "INT_CLI"
                    
                    If Val(varvDataSql(17)) = 1 Then
                       If MsgBox("Interfaz de Clientes Ya ha sido Generada, Vuelve a Generar", vbQuestion + vbYesNo, gsBac_Version) <> vbYes Then
                            Exit Function
                       End If
                    End If
                    
                    Chequea_ControlProcesos = True
                    
                    
               Case "INT_ICOL"
                    
                    If Val(varvDataSql(18)) = 1 Then
                       If MsgBox("Interfaz de Colocaciones Ya ha sido Generada, Vuelve a Generar", vbQuestion + vbYesNo, gsBac_Version) <> vbYes Then
                            Exit Function
                       End If
                    End If
                    
                    Chequea_ControlProcesos = True
                    
                    
               Case "INT_C14"
                    
                    If Val(varvDataSql(19)) = 1 Then
                       If MsgBox("Interfaz C14 Ya ha sido Generada, Vuelve a Generar", vbQuestion + vbYesNo, gsBac_Version) <> vbYes Then
                            Exit Function
                       End If
                    End If
                    
                    Chequea_ControlProcesos = True
                    
                    
               Case "INT_RCC"
                    
                    If Val(varvDataSql(20)) = 1 Then
                       If MsgBox("Interfaz RCC Ya ha sido Generada, Vuelve a Generar", vbQuestion + vbYesNo, gsBac_Version) <> vbYes Then
                            Exit Function
                       End If
                    End If
                    
                    Chequea_ControlProcesos = True
                    
                    
               Case "INT_GES"
                    
                    If Val(varvDataSql(21)) = 1 Then
                       If MsgBox("Interfaz de Gestion Ya ha sido Generada, Vuelve a Generar", vbQuestion + vbYesNo, gsBac_Version) <> vbYes Then
                            Exit Function
                       End If
                    End If
                    
                    Chequea_ControlProcesos = True
                
                
            End Select
            Loop
    End If
    
    Exit Function
    
ErrChequeo:
    MsgBox "Problemas en chequeo de control procesos: " & err.Description & ". Verifique", vbCritical, gsBac_Version
    Exit Function
End Function


Sub BacIrfNueVentana(ByVal sTipOper$, Optional ByVal sNomlist As Variant)
Dim iNumVentana%
Dim FrmOpr      As Form
Dim nContador   As Integer
    
    Screen.MousePointer = vbHourglass

  ' Halla el número de ventana correspondiente.-
    iNumVentana% = BacIrfNumVentana(sTipOper$)
    
    If iNumVentana% = 0 Then
        Screen.MousePointer = vbDefault
        Exit Sub
    End If
    
  ' Asigna el form dependiendo del tipo
''''    Select Case sTipOper$
''''            Case "CP": Set FrmOpr = New BacCP: FrmOpr.bFlagDpx = False
''''            Case "CU": Set FrmOpr = New BacCP: FrmOpr.bFlagDpx = True
''''            Case "VP": Set FrmOpr = New BacVP: FrmOpr.bFlagDpx = False
''''            Case "VU": Set FrmOpr = New BacVP: FrmOpr.bFlagDpx = True
''''            Case "ST": Set FrmOpr = New BacSH
''''            Case "CI": Set FrmOpr = New BacCI
''''            Case "VI": Set FrmOpr = New BacVI
''''            Case "RC": Set FrmOpr = New BacRcRv
''''            Case "RV": Set FrmOpr = New BacRcRv
''''            Case "FLI": Set FrmOpr = New BacFrm
'''' '           Case "IC": Set FrmOpr = New Ingreso_captaciones
''''
''''            Case Else
''''                   Screen.MousePointer = vbDefault
''''                   Exit Sub
''''    End Select

    Select Case sTipOper$
            Case "CP"
                Set FrmOpr = BacCP
                FrmOpr.bFlagDpx = False
            Case "CU"
                Set FrmOpr = BacCP
                FrmOpr.bFlagDpx = True
            Case "VP"
                Set FrmOpr = BacVP
                FrmOpr.bFlagDpx = False
            Case "VU"
                Set FrmOpr = BacVP
                FrmOpr.bFlagDpx = True
            Case "ST"
                Set FrmOpr = BacSH
            Case "CI"
                Set FrmOpr = BacCI
            Case "VI"
                'Set FrmOpr = BacVI 'PRD-6006 CASS 22-12-2010
                Set FrmOpr = Frm_Vtas_con_Pcto
            Case "RC"
                Set FrmOpr = BacRcRv
            Case "RV"
                Set FrmOpr = BacRcRv
            Case "FLI"
                Set FrmOpr = BACFLI 'BacFrm
'            Case "REP"
'                Set FrmOpr = BacRP
'            Case "FLI2"
'                Set FrmOpr = BacFrm2
'
            Case Else
                   Screen.MousePointer = vbDefault
                   Exit Sub
    End Select

    For nContador = 0 To Forms.Count - 1
        If Forms(nContador).Name = FrmOpr.Name Then
            Screen.MousePointer = vbDefault
            Exit Sub
        End If
    Next nContador
        
    ' Asigna el Tag para identificar al Form
    If sTipOper$ = "LI" Then
        FrmOpr.Tag = sTipOper$ & Format$(iNumVentana%, "00") & sNomlist
    Else
        FrmOpr.Tag = sTipOper$ & Format$(iNumVentana%, "00")
    End If
        
  ' Setean el Caption del form para la ventana correspondiente
    Select Case sTipOper$
           Case "CP": FrmOpr.Caption = iNumVentana% & ".- Compra Propia"
           Case "CU": FrmOpr.Caption = iNumVentana% & ".- Compra a Termino en dolares"
           Case "CU": FrmOpr.Caption = iNumVentana% & ".- Venta a Termino en dolares"
           Case "VP": FrmOpr.Caption = iNumVentana% & ".- Venta Definitiva"
           Case "ST": FrmOpr.Caption = iNumVentana% & ".- Sorteo de Letras"
           Case "CI": FrmOpr.Caption = iNumVentana% & ".- Compra con Pacto"
           Case "VI": FrmOpr.Caption = iNumVentana% & ".- Venta con Pacto"
           Case "RC": FrmOpr.Caption = iNumVentana% & ".- Recompra Anticipada"
           Case "RV": FrmOpr.Caption = iNumVentana% & ".- Reventa Anticipada"
           Case "LI": FrmOpr.Caption = iNumVentana% & ".- Listados"
           Case "IC": FrmOpr.Caption = iNumVentana% & ".- Ingreso de Captaciones"
           Case "FLI": FrmOpr.Caption = iNumVentana% & ".- Facilidad de Liquidez Intradía"
           Case "REP": FrmOpr.Caption = iNumVentana% & ".- REPOS"
    End Select
    
    FrmOpr.Show vbNormal
    
    Screen.MousePointer = vbDefault
    
End Sub
Function BacIrfNumVentana(sTipOper$) As Integer

'--------------------------------------------------------------------------
'Calcula el numero de ventana que corresponde
'En el Tag de guarda el tipo de ventana (Ej.: CP,CI,...) mas el correlativo
'de la ventana (CP01,CI03)
'De hecho el gcNumeroMaximo de ventanas debe ser menor a 10 y mayor a uno
'Devuelve 0 si excedió el numero maximo de ventanas
'-------------------------------------------------------------------------

 Dim I%, iUltVentana%, cInfo$
Dim iNumVentanas As Integer
 iNumVentanas% = 0
 For I% = 1 To Forms.Count
 
        cInfo$ = Forms(I% - 1).Tag
        If Mid$(cInfo$, 1, 2) = sTipOper$ Then
              
               iNumVentanas% = iNumVentanas% + 1
               iUltVentana% = Val(Mid$(cInfo$, 3, 2))
            
        End If
Next I%
    
If iNumVentanas% > gcMaximoVentanas Then
        MsgBox "NUMERO MAXIMO DE VENTANAS ABIERTAS EXCEDIDO", vbExclamation, gsBac_Version
        BacIrfNumVentana = 0
        iNumVentanas% = 1
Else
        If iNumVentanas% = 0 Then
               BacIrfNumVentana = 1
        Else
               BacIrfNumVentana = iNumVentanas% + 1
        End If
        
End If

End Function


'==================================================================================
' LD1-COR-035-Configuración BAC Corpbanca, Tema: OP. Excedidas control de Tasas
' INICIO
'==================================================================================
'
'Sub LimpiarCristal()
'
'   Dim X                      As Integer
'
'   For X = 0 To 40
'      BTrader.Cristal.StoredProcParam(X) = ""
'      BTrader.Cristal.Formulas(X) = ""
'
'   Next
'
'End Sub

'==================================================================================
' LD1-COR-035-Configuración BAC Corpbanca, Tema: OP. Excedidas control de Tasas
' FIN
'==================================================================================
