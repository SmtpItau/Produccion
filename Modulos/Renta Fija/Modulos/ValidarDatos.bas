Attribute VB_Name = "ValidarDatos"
Option Explicit

Dim Sql           As String
Dim Datos()

Public Function Chequear_Cortes(ByRef Nominal#, ByVal CorteMin#)

   Dim Residuo1#
   Dim Residuo2#
     

   On Error GoTo ErrCortes

   If CorteMin# <> 0 Then
   
   
      If Nominal# < CorteMin# Then
         MsgBox "Monto nominal debe ser mayor o igual al corte minimo " & vbCrLf & vbCrLf & "Corte minimo : " & Format$(CorteMin#, "#,##0.0000"), vbExclamation, "ERROR"
         Nominal# = CorteMin#
         Exit Function
      End If
      
      Residuo1# = Round(Nominal# / CorteMin#, 8)
      Residuo2# = Int(Residuo1#)
     
      If Residuo1# - Residuo2# <> 0 Then
         MsgBox "Nominal debe ser divisible por el valor del corte mínimo del papel: " & vbCrLf & "Corte Mínimo: " & Format(CorteMin#, "#,##0.0000"), vbExclamation, "ERROR"
         Nominal# = CorteMin# * Residuo2#
         Exit Function
      End If

      If (Residuo1#) > 999999990 Then
         MsgBox "Cantidad de cortes sobrepasa el máximo (999999990)", vbExclamation, "ERROR"
         Nominal# = CorteMin# * 999999990
         Exit Function
      End If


   End If

   Exit Function

ErrCortes:

   MsgBox "Problemas en chequeo de cortes: " & err.Description & ". Comunique al Administrador.", vbExclamation, "Error"
   Exit Function

End Function

Public Function Chequear_Instrumento(sInstSer As String, objOperacion As Object, Optional Monedapago%, Optional TipoOper$) As Boolean

Dim Sal              As BacTypeChkSerie
Dim MonedapagoAux%
Dim MonedaExtranjera$

Chequear_Instrumento = False

If Validar_Serie(sInstSer, Sal) <> True Then
    Exit Function
End If


If Sal.nError <> 0 Then
   objOperacion.Error = Sal.nError
   Exit Function
End If
         
         
MonedaExtranjera$ = "N"

If Sal.nMonemi <> 999 And _
   Sal.nMonemi <> 998 And _
   Sal.nMonemi <> 997 And _
   Sal.nMonemi <> 995 And _
   Sal.nMonemi <> 994 Then
   
   MonedaExtranjera$ = "S"
   
End If

If TipoOper$ = "CP" Or TipoOper$ = "VP" Then

   If Monedapago% <> 0 Then
   
      MonedapagoAux% = 999
      
      If MonedaExtranjera$ = "S" Then
         
         MonedapagoAux% = Sal.nMonemi
         
      End If
      
      If Monedapago% <> MonedapagoAux% Then
         MsgBox "No se pueden mezclar monedas de pago", vbExclamation, "ERROR"
         objOperacion.Error = 321
         Exit Function
      End If
                
   End If

End If

With objOperacion

            .Mascara = Sal.nSerie
  .CodigoInstrumento = Sal.nCodigo
            .InstSer = Sal.cMascara
            .Familia = Sal.sFamilia
            .RutEmis = Sal.nRutemi
            .Monemis = Sal.nMonemi
            .TasEmis = Sal.fTasemi
            .BasEmis = Sal.fBasemi
            .FecEmis = Sal.dFecemi
            .FecVcto = Sal.dFecven
            .GenEmis = Sal.cGenemi
             .NemMon = Sal.cNemmon
        .CorteMinimo = Sal.nCorMin
            .seriado = Sal.cSeriado
            .LeeEmis = Sal.cLeeEmi
            .ValMcdo = "N"
                .tir = 0
                .Pvp = 0
                 .Mt = 0
            .ValMcdo = 0
              .Error = 0
    
End With
   
Chequear_Instrumento = True


End Function


Public Sub Proc_Consulta_Porcentaje_Transacciones(cModulo As String)

    Dim Datos()
    Envia = Array()
    AddParam Envia, GLB_ID_SISTEMA
    AddParam Envia, cModulo
    
    If Not Bac_Sql_Execute("BACPARAMSUDA..SP_LEE_PORCENTAJE_TRANSFERENCIA", Envia) Then
        Screen.MousePointer = vbDefault
        MsgBox "Ha ocurrido un error al intentar recuperar el porcentaje de margen de transacciones", vbCritical + vbOKOnly
        Exit Sub
    End If
  
    nPorcentaje = 0
  
    If Bac_SQL_Fetch(Datos()) Then
        nPorcentaje = Val(Datos(1)) 'valor
    End If

End Sub

Public Function Proc_Valida_Tasa_Transferencia(nTasaCompra As Double, nTasaTrans As Double) As Boolean
          
    Proc_Valida_Tasa_Transferencia = False
          
    nPorcMaximo = nTasaCompra + (nTasaCompra * (nPorcentaje / 100))
    nPorcMinimo = nTasaCompra - (nTasaCompra * (nPorcentaje / 100))

    '- Control para Variación con Tasa de Transferencia Negativa. -'
    If nTasaTrans < 0 Then
       Let nPorcMaximo = nTasaCompra - (nTasaCompra * (nPorcentaje / 100))
       Let nPorcMinimo = nTasaCompra + (nTasaCompra * (nPorcentaje / 100))
    End If
    '- Control para Variación con Tasa de Transferencia Negativa. -'
    
    If nTasaTrans < nPorcMinimo Then
        Screen.MousePointer = vbDefault
        MsgBox "La tasa de transaccion ingresada esta por debajo del porcentaje minimo de margen de transaccion" + vbCrLf + vbCrLf + "Valor Minimo : " + CStr(nPorcMinimo), vbExclamation + vbOKOnly
        Exit Function
    End If
    
    If nTasaTrans > nPorcMaximo Then
        Screen.MousePointer = vbDefault
        MsgBox "La tasa ingresada sobrepasa el porcentaje maximo de margen de transaccion" + vbCrLf + vbCrLf + "Valor Maximo : " + CStr(nPorcMaximo), vbExclamation + vbOKOnly
        Exit Function
    End If
    
    Proc_Valida_Tasa_Transferencia = True
    
End Function




Private Function Validar_Serie(ByVal cInstser As String, ByRef Sal As BacTypeChkSerie)

   'Funcion común para compras propias y compras con pacto
   On Error GoTo BacErrorHandler

   Sql = "EXECUTE SP_CHKINSTSER '" & cInstser & "'"

   If miSQL.SQL_Execute(Sql) <> 0 Then
      MsgBox "Serie no pudo ser validada", vbExclamation, "error"
      Exit Function

   End If

   Validar_Serie = False

   If miSQL.SQL_Fetch(Datos()) = 0 Then
      Sal.nError = Val(Datos(1))

      If Sal.nError = 0 Then

         With Sal
            .cMascara = Datos(2)
            .nCodigo = Val(Datos(3))
            .nSerie = Datos(18)
            .sFamilia = Datos(4)
            .nRutemi = Val(Datos(5))
            .nMonemi = Val(Datos(6))
            .fTasemi = Val(Datos(7))
            .fBasemi = Val(Datos(8))
            .dFecemi = Datos(9)
            .dFecven = Datos(10)
            .cRefnomi = Datos(11)
            .cGenemi = Datos(12)
            .cNemmon = Datos(13)
            .nCorMin = Datos(14)
            .cSeriado = Datos(15)
            .cLeeEmi = Datos(16)

         End With

         Validar_Serie = True

      Else
         Select Case Sal.nError
         Case 1: MsgBox "'DD' no es dia", vbExclamation, "ERROR"
         Case 2: MsgBox "'MM' no es fecha", vbExclamation, "ERROR"
         Case 3: MsgBox "'YY' no es año", vbExclamation, "ERROR"
         Case 4: MsgBox "'DDMMAA' o 'AAMMDD' no es fecha", vbExclamation, "ERROR"
         Case 5: MsgBox "' ' no es blanco", vbExclamation, "ERROR"
         Case 6: MsgBox "'N' no es número", vbExclamation, "ERROR"
         Case 7: MsgBox "No Coincidió con ninguna máscara", vbExclamation, "ERROR"
         Case 8: MsgBox "No existe en familia de instrumentos", vbExclamation, "ERROR"
         Case 9: MsgBox "No existe en series", vbExclamation, "ERROR"
         Case 10: MsgBox "No fue posible determinar fecha de vencimiento", vbExclamation, "ERROR"
         Case 11: MsgBox "Fecha de la serie no es válida", vbExclamation, "ERROR"
         Case 12:
                    'No Validar
                    'MsgBox "Fecha de vencimiento es feriado", vbExclamation, "ERROR"
                    Sal.nError = 0
         Case 15: MsgBox "Serie ingresada no es valida", vbExclamation, "ERROR"
         Case Else: MsgBox "No se encontró máscara", vbExclamation, "ERROR"
         End Select

     End If
   Else
     MsgBox "No se pudo chequear la serie", vbExclamation, "ERROR"
   End If

   Exit Function

BacErrorHandler:
   MsgBox "Problemas en chequeo de serie : " & err.Description, vbCritical, "ERROR"
   Exit Function

End Function


Public Function CondicionesPactoFirmada(ByVal iRut As Long, ByVal iCodigo As Long) As Boolean
   Dim SqlDatos()
   
   Let CondicionesPactoFirmada = False

   Envia = Array()
   AddParam Envia, iRut
   AddParam Envia, iCodigo
   If Not Bac_Sql_Execute("dbo.SP_VALIDACION_FECHA_CONDICION_PACTO", Envia) Then
      Let CondicionesPactoFirmada = True
      Exit Function
   End If
   If Bac_SQL_Fetch(SqlDatos()) Then
      If SqlDatos(2) = 1 Then
         Let CondicionesPactoFirmada = True
      Else
         Call MsgBox(SqlDatos(5), vbExclamation, App.Title)
      End If
   End If

End Function

