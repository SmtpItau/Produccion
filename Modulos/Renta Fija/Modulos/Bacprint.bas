Attribute VB_Name = "BacFunImpre"
'**********************
Global Const ConstTitle% = 0
Global Const ConstTexto% = 1
Global Const Getchr = 1
Global Const GetNum = 0
Global Const CourierNew = 6
'**********************
Type OrientStructure
  Orientation As Long
  Pad As String * 16
End Type





Function ImprimeCertificadoVP() As Boolean
On erro GoTo ErrImp

Dim Contador As Integer
Dim Pagina As Integer
Dim Datos()

    frmCerVp.Show vbModal
    Screen.MousePointer = 11

    Contador = 1
    Pagina = 1

    If giAceptar% = True Then

    If Not Llenar_Parametros("CERTIFICADO DE VENTA DEFINITIVA DE VALORES") Then
        Exit Function
    End If

    Sql = "DELETE FROM CERVENDEF;"
    ImprimeCertificadoVP = True
    db.Execute Sql
    
    Sql = "SP_GEN_CERTIFICADO_VP " & xCodigo
    If Bac_Sql_Execute(Sql, Envia) Then
        Do While Bac_SQL_Fetch(Datos())
            
            If Contador = 12 Then
                Contador = 1
                Pagina = Pagina + 1
            End If
            
            Sql = "INSERT INTO CERVENDEF VALUES( " & Chr(10)
            Sql = Sql + "'" + Datos(1) + "'," & Chr(10)        'Fecha
            Sql = Sql + "'" + Datos(2) + "'," & Chr(10)        'Cliente
            Sql = Sql + "'" + Datos(3) + "'," & Chr(10)        'Pais
            Sql = Sql + "'" + Datos(4) + "'," & Chr(10)        'Rut
            Sql = Sql + "'" + Datos(5) + "'," & Chr(10)        'Instrumento
            Sql = Sql + "'" + Datos(6) + "'," & Chr(10)        'Fecha Vcto
            Sql = Sql + Datos(7) + "," & Chr(10)             'Valor Efec.
            Sql = Sql + Datos(8) + "," & Chr(10)             'Valor Nominal
            Sql = Sql + Datos(9) + "," & Chr(10)             'Valor Total
            Sql = Sql + "'" + Datos(10) + "'," & Chr(10)       'Forma Pago
            Sql = Sql + Str(Pagina) + "," & Chr(10)          'Pagina
            Sql = Sql + Datos(12) & Chr(10)                 'Número
            Sql = Sql + " );"
            db.Execute Sql
            
            Contador = Contador + 1
        Loop
    Else
        MsgBox "Informe no puede ser Generado", vbExclamation, "Informes"
        ImprimeCertificadoVP = False
    End If
End If
Screen.MousePointer = 0
Exit Function

ErrImp:
    MsgBox "Error :" + err.Descripcion
End Function


Function DiaSemana(xFecha As Date) As String
Dim cDia As Integer

        cDia = DatePart("w", xFecha)
        
        Select Case cDia
            Case 1:
                DiaSemana = "Domingo"
            Case 2:
                DiaSemana = "Lunes"
            Case 3:
                DiaSemana = "Martes"
            Case 4:
                DiaSemana = "Miercoles"
            Case 5:
                DiaSemana = "Jueves"
            Case 6:
                DiaSemana = "Viernes"
            Case 7:
                DiaSemana = "Sabado"
      End Select

End Function

Function Fecha_Completa(xFecha As Date) As String
Dim ddd As String
Dim dd As Single
Dim mmm As String
Dim aaaa As Single
Fecha_Completa = ""
 
 dd = Day(xFecha)
 ddd = DiaSemana(xFecha)
 Select Case Month(xFecha)
           Case Is = 1: mmm = "Enero"
           Case Is = 2: mmm = "Febrero"
           Case Is = 3: mmm = "Marzo"
           Case Is = 4: mmm = "Abril"
           Case Is = 5: mmm = "Mayo"
           Case Is = 6: mmm = "Junio"
           Case Is = 7: mmm = "Julio"
           Case Is = 8: mmm = "Agosto"
           Case Is = 9: mmm = "Septiembre"
           Case Is = 10: mmm = "Octubre"
           Case Is = 11: mmm = "Noviembre"
           Case Is = 12: mmm = "Diciembre"
 End Select
 aaaa = Year(xFecha)
 
 Fecha_Completa = ddd + Str(dd) + " de " + mmm + " del " + Str(aaaa)
End Function

Function MONTO_ESCRITO(n As Double) As String

ReDim uni(15) As String
ReDim Dec(9) As String
Dim z, Num, Var   As Variant
Dim c, D, u, v, I As Integer
Dim k

If n = 0 Or n > 1E+17 Then
   MONTO_ESCRITO = IIf(n = 0, "CERO", "*")
   Exit Function
End If

uni(1) = "UN"
uni(2) = "DOS"
uni(3) = "TRES"
uni(4) = "CUATRO"
uni(5) = "CINCO"
uni(6) = "SEIS"
uni(7) = "SIETE"
uni(8) = "OCHO"
uni(9) = "NUEVE"
uni(10) = "DIEZ"
uni(11) = "ONCE"
uni(12) = "DOCE"
uni(13) = "TRECE"
uni(14) = "CATORCE"
uni(15) = "QUINCE"

Dec(3) = "TREINTA"
Dec(4) = "CUARENTA"
Dec(5) = "CINCUENTA"
Dec(6) = "SESENTA"
Dec(7) = "SETENTA"
Dec(8) = "OCHENTA"
Dec(9) = "NOVENTA"

Num = String$(19 - Len(Str(Trim(n))), Space(1))
Num = Num + Trim(Str(n))
I = 1
z = ""

Do While True
   k = Mid(Num, 18 - (I * 3 - 1), 3)

   If k = Space(3) Then
      Exit Do
   End If

   c = Val(Mid(k, 1, 1))
   D = Val(Mid(k, 2, 1))
   u = Val(Mid(k, 3, 1))
   v = Val(Mid(k, 2, 2))

   If I > 1 Then
      If (I = 2 Or I = 4) And Val(k) > 0 Then
         z = " MIL " + z
      End If
      If I = 3 And Val(Mid(Num, 7, 6)) > 0 Then
         If Val(k) = 1 Then
            z = " MILLON " + z
         Else
            z = " MILLONES " + z
         End If
      End If
      If I = 5 And Val(k) > 0 Then
         If Val(k) = 1 Then
            z = " BILLON " + z
         Else
            z = " BILLONES " + z
         End If
      End If
   End If

   If v > 0 Then
      Select Case v
             Case 0 To 15
                  z = uni(v) + z
             Case 0 To 19
                  z = " DIECI" + uni(u) + z
             Case 20
                  z = " VEINTE " + z
             Case 0 To 29
                  z = " VEINTI" + uni(u) + z
             Case Else
                  If u = 0 Then
                     z = Dec(D) + z
                  Else
                     z = Dec(D) + " Y " + uni(u) + z
                  End If
      End Select
   End If

   If c > 0 Then
      If c = 1 Then
         If v = 0 Then
            z = " CIEN " + z
         Else
            z = " CIENTO " + z
         End If
      End If
      If c = 2 Or c = 3 Or c = 4 Or c = 6 Or c = 8 Then
         z = uni(c) + "CIENTOS " + z
      End If
      If c = 5 Then
         z = " QUINIENTOS " + z
      End If
      If c = 7 Then
         z = " SETECIENTOS " + z
      End If
      If c = 9 Then
         z = " NOVECIENTOS " + z
      End If
   End If

   I = I + 1
Loop

MONTO_ESCRITO = Trim(z)
End Function








Function Buscar_Pagares(xDesde As Double, xHasta As Double) As Boolean
  Dim Sql As String
  Dim Datos()
  Dim p As Single
  Dim xRutAP1 As Double
  Dim xDvAP1 As String
  Dim xNomAP1 As String
  Dim xRutAP2 As Double
  Dim xDvAP2 As String
  Dim xNomAP2 As String

  p = 0
  Buscar_Pagares = False
  
  db.Execute "Delete * from Captaciones"
  
  Sql = "SP_TRAEAPODERADO "
        If Bac_Sql_Execute(Sql, Envia) Then
          If Bac_SQL_Fetch(Datos()) Then
             xRutAP1 = Datos(1)
             xDvAP1 = Datos(2)
             xNomAP1 = Datos(3)
             xRutAP2 = Datos(4)
             xDvAP2 = Datos(5)
             xNomAP2 = Datos(6)
        
          Else
             Exit Function
          End If
        Else
          Exit Function
        End If
  
 Sql = "SP_PAGARES " & xDesde & "," & xHasta
 If Bac_Sql_Execute(Sql, Envia) Then
    Do While Bac_SQL_Fetch(Datos())
       p = p + 1
       Sql = "INSERT INTO CAPTACIONES VALUES ('"
       Sql = Sql & Fecha_Completa(CDate(Datos(1))) & "'," & Chr(10)
       Sql = Sql & "'" & Fecha_Completa(CDate(Datos(2))) & "'," & Chr(10)
       Sql = Sql & "'" & Datos(3) & "'," & Chr(10)
       Sql = Sql & "'" & Val(Datos(4)) & "'," & Chr(10)
       Sql = Sql & "'" & Val(Datos(5)) & "'," & Chr(10)
       Sql = Sql & Val(Datos(6)) & "," & Chr(10)
       Sql = Sql & "'" & Val(Datos(8)) & "'," & Chr(10)
       Sql = Sql & "'" & Datos(7) & "'," & Chr(10)
       Sql = Sql & "'" & Datos(9) & "'," & Chr(10)
       Sql = Sql & Datos(10) & "," & Chr(10)
       Sql = Sql & Datos(11) & "," & Chr(10)
       Sql = Sql & "'" & Datos(12) & "'," & Chr(10)
       Sql = Sql & Datos(13) & "," & Chr(10)
       Sql = Sql & Datos(14) & "," & Chr(10)
       Sql = Sql & Datos(15) & "," & Chr(10)
       Sql = Sql & "'" & Datos(16) & "'," & Chr(10)
       Sql = Sql & Val(Datos(17)) & "," & Chr(10)
       Sql = Sql & "'" & Datos(18) & "'," & Chr(10)
       Sql = Sql & "'" & Datos(19) & "'," & Chr(10)
       Sql = Sql & "'" & xNomAP1 & "'," & Chr(10)
       Sql = Sql & "'" & xRutAP1 & "'," & Chr(10)
       Sql = Sql & "'" & xDvAP1 & "'," & Chr(10)
       Sql = Sql & "'" & xNomAP2 & "'," & Chr(10)
       Sql = Sql & "'" & xRutAP2 & "'," & Chr(10)
       Sql = Sql & "'" & xDvAP2 & "'," & Chr(10)
       Sql = Sql & "'" & Datos(20) & "'," & Chr(10)
       Sql = Sql & "'" & MONTO_ESCRITO(CDbl(Mid(Str(Datos(10)), 1, InStr(1, Str(Datos(10)), ".") - 1))) + IIf(CDbl(Mid(Str(Datos(10)), InStr(1, Str(Datos(10)), ".") + 1)) = 0, "", " CON " + Mid(Str(Datos(10)), InStr(1, Str(Datos(10)), ".") + 1) + "/10000") & "'," & Chr(10)        'MONTO_ESCRITO(Val(Datos(10))) & "'," & Chr(10)
       Sql = Sql & "'" & MONTO_ESCRITO(CDbl(Mid(Str(Datos(15)), 1, InStr(1, Str(Datos(15)), ".") - 1))) + IIf(CDbl(Mid(Str(Datos(15)), InStr(1, Str(Datos(15)), ".") + 1)) = 0, "", " CON " + Mid(Str(Datos(15)), InStr(1, Str(Datos(15)), ".") + 1) + "/10000") & "'," & Chr(10)        'MONTO_ESCRITO(Val(Datos(15))) & "'," & Chr(10)
       Sql = Sql & "'" & Datos(21) & "'," & Chr(10)
       Sql = Sql & "'" & Datos(22) & "'," & Chr(10)
       Sql = Sql & "'" & Datos(23) & "')"
      db.Execute Sql
    Loop
  Else
     Exit Function
  End If
  If p = 0 Then
    Exit Function
  End If
   Buscar_Pagares = True
End Function

Function Inf_SETTLEMENT() As Boolean
Dim Sql As String
Dim Datos()

Screen.MousePointer = 11

    Sql = "DELETE FROM INFORMESETT;"
    Inf_SETTLEMENT = True
    db.Execute Sql
    Sql = "SP_INFORME_SETTLEMENT"
    If Bac_Sql_Execute(Sql, Envia) Then
        Do While Bac_SQL_Fetch(Datos())
            Sql = "INSERT INTO INFORMESETT VALUES( " & Chr(10)
            Sql = Sql + "'" + Trim(Datos(3)) + "'," & Chr(10)
            Sql = Sql + Datos(10) + "," & Chr(10)
            Sql = Sql + Datos(11) + "," & Chr(10)
            Sql = Sql + Datos(12) + "," & Chr(10)
            Sql = Sql + Datos(13) + "," & Chr(10)
            Sql = Sql + Datos(14) + "," & Chr(10)
            Sql = Sql + Datos(15) + "," & Chr(10)
            Sql = Sql + Datos(16) + "," & Chr(10)
            Sql = Sql + Datos(1) + "," & Chr(10)
            Sql = Sql + "'" + Trim(Datos(2)) + "' ," & Chr(10)
            Sql = Sql + Datos(9) + "," & Chr(10)
            Sql = Sql + Datos(17) & Chr(10)
            Sql = Sql + " );"
            db.Execute Sql
        Loop
    Else
        MsgBox "Informe no puede ser Generado", vbExclamation, "Informes"
        Inf_SETTLEMENT = False
    End If

Screen.MousePointer = 0

End Function

Public Function Llenar_Parametros(titulo_informe As String) As Boolean
Dim Sql As String
Dim Datos()


Llenar_Parametros = False

'SQL = "DELETE FROM PARAMETROS;"
'db.Execute SQL

If miSQL.SQL_Execute("SP_CARGA_PARAMETROS ") <> 0 Then Exit Function

If Bac_SQL_Fetch(Datos()) Then
'   SQL = "INSERT INTO PARAMETROS VALUES (  " & Chr(10)
'   SQL = SQL + "'" + Datos(1) + "'," & Chr(10)
'   SQL = SQL + "'" + Datos(2) + "'," & Chr(10)
'   SQL = SQL + Datos(3) + "," & Chr(10)
'   SQL = SQL + Datos(4) + "," & Chr(10)
'   SQL = SQL + Datos(5) + "," & Chr(10)
'   SQL = SQL + Datos(6) + "," & Chr(10)
'   SQL = SQL + Datos(7) + "," & Chr(10)
'   SQL = SQL + Datos(8) + "," & Chr(10)
'   SQL = SQL + Datos(9) + "," & Chr(10)
'   SQL = SQL + Datos(10) + "," & Chr(10)
'   SQL = SQL + "'" + Datos(11) + "'," & Chr(10)
'   SQL = SQL + "'" + Datos(12) + "'," & Chr(10)
'   SQL = SQL + "'" + titulo_informe + "'," & Chr(10)
'   SQL = SQL + "'" + Str(Time) + "');"
'
'   db.Execute SQL
'
   Llenar_Parametros = True
End If

End Function


'el SP_LISTADOCPCON fue modificado si ocupan esta funcion deben arreglar dicho sp
Function Llenar_Resumen(xent As String, Cartera As String) As Boolean
Dim Sql As String
Dim Datos()

    Llenar_Resumen = False

    Sql = "DELETE FROM RESCAR;"
    db.Execute Sql
    
    If Cartera = "111" Or Cartera = "114" Then
       Sql = "SP_LISTADOCPCON '" & Cartera & "'," & Val(xent) & ", 'S'"
    Else
       Sql = "SP_INFOCI '" & Cartera & "'," & Val(xent) & ", 'S'"
    End If

    If Bac_Sql_Execute(Sql, Envia) Then
    
       Do While Bac_SQL_Fetch(Datos())
          Sql = "INSERT INTO RESCAR VALUES (  " & Chr(10)
          Sql = Sql + "'" + Datos(1) + "'," & Chr(10)
          Sql = Sql + "'" + Datos(2) + "'," & Chr(10)
          Sql = Sql + Datos(3) + "," & Chr(10)
          Sql = Sql + Datos(4) + "," & Chr(10)
          Sql = Sql + Datos(5) + "," & Chr(10)
          Sql = Sql + Datos(6) + "," & Chr(10)
          Sql = Sql + Datos(7) + "," & Chr(10)
          Sql = Sql + "'" + Datos(8) + "');" & Chr(10)
                
          db.Execute Sql
            
       Loop
       
       Llenar_Resumen = True
    Else
       MsgBox " Falla Procedimiento. Reporte NO Generado.", vbExclamation, "INFORMES"
    End If

End Function
Sub BacEncabeza(Ancho%, Titu_List$, nFolio%)
    Dim nFila As Integer

    nFila = 3
  '  BacGlbSetFont 12, False
    BacGlbPrinter nFila, 0, Ancho% + 20, ConstTexto, "Folio :" & Format(nFolio%, "0000000"), 0, Getchr
   ' BacGlbSetFont 15, True
    BacGlbPrinter nFila + 1, 0, 0, ConstTitle, Titu_List$, 0, Getchr
             
        
End Sub
Static Sub BacGlbPrinter(pCurrenty As Variant, pCurrentx As Integer, pTab As Integer, pModo As Integer, pString As Variant, Largo As Integer, tipo As Integer)
       Static vMenos
       Static xPos

       Select Case pModo
       
              Case ConstTitle                                   'Titulos
                   HWidth = Printer.TextWidth(pString) / 2
                   Printer.CurrentX = Int(Printer.ScaleWidth / 2 - HWidth)
                   Printer.CurrentY = Int(pCurrenty)
                   Printer.Print pString

              Case ConstTexto                                   'Texto Normal
                   Printer.CurrentY = pCurrenty
                   Printer.CurrentX = pCurrentx
                   
                   Select Case tipo
                   
                          Case GetNum
                               Printer.Print Tab(pTab); String(Largo - Len(Trim(pString)), Space(1)) + Trim(pString)
                          Case Getchr
                               Printer.Print Tab(pTab); pString
'                               Printer.Print Tab(pTab); Trim(pString)
                               
                   End Select
                   
       End Select

End Sub
Static Sub BacGlbPrinterEnd()
       Printer.EndDoc
End Sub
Static Sub BacGlbSetFont(nFont, nFontSize As Double, lNegrilla As Boolean)
   Printer.FontName = Printer.Fonts(nFont)
   Printer.FontSize = nFontSize
   Printer.FontBold = lNegrilla

End Sub
Static Sub BacGlbSetPrinter(pLines As Integer, pColum As Integer, pTop As Integer, pLeft As Integer)
    Printer.ScaleHeight = pLines
    Printer.ScaleWidth = pColum
    Printer.ScaleTop = pTop
    Printer.ScaleLeft = pLeft
End Sub
Static Function BacCentraTexto(aArr_ini As Variant, cString As Variant, nLargo As Integer)

Dim aArr_Pas()
Dim nLen_Var As Long
Dim cVar_aux As String
Dim nPosit   As Integer
Dim nCont    As Integer
Dim nNumReg  As Integer
Dim cLinStr1 As String
Dim cLinStr2 As String
Dim cLinStr3 As String
Dim nNumEsp  As Integer
Dim nNumEsp2 As Integer
Dim lUltima  As Boolean

nNumReg = 0

nLen_Var = Len(cString)
nLargo = IIf(nLargo < 15, 15, nLargo)
ReDim aArr_ini(BacRound1(nLen_Var / nLargo))

For nCont = 1 To nLen_Var Step nLargo
   nNumReg = nNumReg + 1
   aArr_ini(nNumReg) = Mid(cString, nCont, nLargo)
Next

'// Tabulacion de las lineas **********
For nCont = 1 To nNumReg - 1
   cLinStr1 = aArr_ini(nCont)
   cLinStr2 = aArr_ini(nCont + 1)
   nNumEsp = BacRAT(" ", cLinStr1)
   
   If nNumEsp <> Len(cLinStr1) Then
   
      If Mid(cLinStr2, 1, 1) <> " " Then
         cLinStr2 = Mid(cLinStr1, nNumEsp + 1) + cLinStr2
         aArr_ini(nCont) = Trim(Mid(cLinStr1, 1, nNumEsp))
         aArr_ini(nCont + 1) = cLinStr2
      End If
   
   End If

Next

cVar_aux = ""
For nCont = 1 To UBound(aArr_ini) - 1
     
     If Len(cVar_aux + aArr_ini(nCont)) > nLargo Then
        nNumEsp = BacRAT(" ", aArr_ini(nCont))
        nNumEsp2 = 0
        
        Do While nNumEsp > nLargo
            nNumEsp2 = (nNumEsp - 1)
            nNumEsp = BacRAT(" ", Mid(aArr_ini(nCont), 1, nNumEsp2))
        Loop
        
        cLinStr1 = Trim(Mid(aArr_ini(nCont), 1, nNumEsp - 1))
        cLinStr2 = Mid(aArr_ini(nCont), nNumEsp + 1) + " "
        aArr_ini(nCont) = cLinStr1
        aArr_ini(nCont + 1) = cLinStr2 + aArr_ini(nCont + 1)
     End If

Next

cLinStr3 = Trim(aArr_ini(UBound(aArr_ini)))
lUltima = IIf(Len(cLinStr3) > nLargo, True, False)

Do While True

   If Len(cLinStr3) > nLargo Then
      nNumEsp = BacRAT(" ", cLinStr3)
      nNumEsp2 = 0
     
      Do While nNumEsp > nLargo
         nNumEsp2 = (nNumEsp - 1)
         nNumEsp = BacRAT(" ", Mid(cLinStr3, 1, nNumEsp2))
      Loop
      
      cLinStr1 = Trim(Mid(cLinStr3, 1, nNumEsp - 1))
      cLinStr2 = Mid(cLinStr3, nNumEsp + 1) + " "
      aArr_ini(UBound(aArr_ini)) = cLinStr1
      cLinStr3 = cLinStr2
   Else
      If lUltima Then
         ReDim aArr_Pas(UBound(aArr_ini))
      
         For nCont = 1 To UBound(aArr_ini)
            aArr_Pas(nCont) = aArr_ini(nCont)
         Next
         
         ReDim aArr_ini(UBound(aArr_ini) + 1)
      
         For nCont = 1 To UBound(aArr_ini)
      
            If nCont = UBound(aArr_ini) Then
               aArr_ini(nCont) = cLinStr3
            Else
               aArr_ini(nCont) = aArr_Pas(nCont)
            End If
            
         Next
         
      End If
      
      Exit Do
   End If
   
Loop

For nCont = 1 To UBound(aArr_ini) - 1
   nPosit = 0
   cVar_aux = Trim(aArr_ini(nCont))
   Do While Len(cVar_aux) < nLargo
      nPosit = BacFind_Char(" ", cVar_aux, nPosit + 1)
      
      If nPosit <> 0 Then
         cVar_aux = Left(cVar_aux, nPosit) + " " + Right(cVar_aux, Len(cVar_aux) - nPosit)
         nPosit = nPosit + 1
      End If
      
      If nPosit > Len(cVar_aux) Then
         nPosit = 0
      End If
      
      If BacAT(" ", cVar_aux) = 0 Then
         Exit Do
      End If
      
   Loop
   
   If Len(cVar_aux) <> 0 Then
      aArr_ini(nCont) = cVar_aux
   End If
Next

End Function
Static Function BacFind_Char(cBusqueda, cString, nInicio)
Dim nCont As Integer

For nCont = nInicio To Len(cString)

    If Mid(cString, nCont, 1) = cBusqueda And nCont < Len(cString) And Mid(cString, nCont + 1, 1) <> cBusqueda Then
       BacFind_Char = nCont
       Exit For
    End If
    
Next

End Function

Static Function BacRound1(nNumero As Double) As Long
   BacRound1 = IIf(nNumero - Int(nNumero) > 0, Int(nNumero) + 1, nNumero)
End Function

Static Function BacRAT(cBusqueda, cString)
Dim nCont As Long

For nCont = Len(cString) To 1 Step -1
    If Mid(cString, nCont, 1) = cBusqueda Then
       BacRAT = nCont
       Exit For
    End If
    BacRAT = 0
Next
End Function

Static Function BacAT(cBusqueda, cString)
Dim nCont As Long
nCont = 0

For nCont = 1 To Len(cString)
    If Mid(cString, nCont, 1) = cBusqueda Then
       BacAT = nCont
       Exit For
    End If
    BacAT = 0
Next
End Function

Public Function Impresion_Entidades(varEsReporte As String) As Boolean
   Dim TitRpt As String
   Dim cs As Integer
   Dim oDatos()
   On Error GoTo ErrPrinter

   Entidad.Show 1
   cs = 1
    
   
    
   If giAceptar% = True Then
      
      Call Limpiar_Cristal
      Screen.MousePointer = vbHourglass
      
        Select Case varEsReporte
 
        ' Este bloque contiene las funciones correspondientes a los listados de movimientos
        ' ------------------------------------------------------------------------------------
           Case "CP"  'Adrian
'''''               If XCarteraSuper = "" Then
'''''                  cs = 2
'''''               End If
'''''               For x = 1 To cs
'''''               If cs > 1 Then
'''''                  If x = 1 Then XCarteraSuper = "T": Titulo = "TRANSABLE"
'''''                  If x = 2 Then XCarteraSuper = "P": Titulo = "PERMANENTE"
'''''               End If

                Sql = "SP_CON_INFO_COMBO"
                
                Envia = Array()
                AddParam Envia, GLB_CARTERA_NORMATIVA

                If Bac_Sql_Execute(Sql, Envia) Then
                    Do While Bac_SQL_Fetch(oDatos())
                        If XCarteraSuper = "" Or XCarteraSuper = oDatos(2) Then
                        
                            Titulo = Trim(oDatos(6))
                        
                            TitRpt = "MOVIMIENTO DIARIO DE COMPRAS DEFINITIVAS " + Titulo
                            
                            BacTrader.bacrpt.Destination = crptToWindow
                            BacTrader.bacrpt.ReportFileName = RptList_Path & "LISTCP.RPT"
                            BacTrader.bacrpt.StoredProcParam(0) = IIf(xentidad = Trim(""), 0, xentidad)
'''''                            BacTrader.bacrpt.StoredProcParam(1) = XCarteraSuper
                            BacTrader.bacrpt.StoredProcParam(1) = Trim(oDatos(2))
                            BacTrader.bacrpt.StoredProcParam(2) = TitRpt
                            BacTrader.bacrpt.Formulas(0) = "titulo='" & TitRpt & "'"
                            BacTrader.bacrpt.Connect = CONECCION
                            BacTrader.bacrpt.Action = 1
                            
                            Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Impresión " & TitRpt)
                    
                        End If
                    Loop
                Else
                    MsgBox "Ha ocurrido un error al intentar rescatar la descripcion de las carteras normativas", vbOKOnly + vbCritical
                    Exit Function
                End If
                
        Case "VP" 'LlenarVP
'''''               If XCarteraSuper = "" Then
'''''                  cs = 2
'''''               End If
'''''               For x = 1 To cs
'''''                If cs > 1 Then
'''''                   If x = 1 Then XCarteraSuper = "T": Titulo = "TRANSABLE"
'''''                   If x = 2 Then XCarteraSuper = "P": Titulo = "PERMANENTE"
'''''                End If
                Sql = "SP_CON_INFO_COMBO"
                
                Envia = Array()
                AddParam Envia, GLB_CARTERA_NORMATIVA

                If Bac_Sql_Execute(Sql, Envia) Then
                    Do While Bac_SQL_Fetch(oDatos())
                        If XCarteraSuper = "" Or XCarteraSuper = oDatos(2) Then
                        
                            Titulo = Trim(oDatos(6))
            
                            TitRpt = "MOVIMIENTO DIARIO DE VENTAS DEFINITIVAS " + Titulo
                            
                            BacTrader.bacrpt.Destination = 0
                            BacTrader.bacrpt.ReportFileName = RptList_Path & "LISTVP.RPT"
                            BacTrader.bacrpt.StoredProcParam(0) = IIf(xentidad = Trim(""), 0, xentidad)
'''''                            BacTrader.bacrpt.StoredProcParam(1) = XCarteraSuper
                            BacTrader.bacrpt.StoredProcParam(1) = Trim(oDatos(2))
                            BacTrader.bacrpt.StoredProcParam(2) = TitRpt
                            BacTrader.bacrpt.Formulas(0) = "tit='" & TitRpt & "'"
                            BacTrader.bacrpt.Connect = CONECCION
                            BacTrader.bacrpt.Action = 1
                            
                            Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Impresión " & TitRpt)
                        End If
                    Loop
                 Else
                    MsgBox "Ha ocurrido un error al intentar rescatar la descripcion de las carteras normativas", vbOKOnly + vbCritical
                    Exit Function
                End If
                    
'''''               Next
           Case "CI"
                TitRpt = "MOVIMIENTO DIARIO DE COMPRAS CON PACTO"
                BacTrader.bacrpt.Destination = 0
                BacTrader.bacrpt.ReportFileName = RptList_Path & "LISTCI.RPT"
                If xentidad = "" Then xentidad = 0
                BacTrader.bacrpt.StoredProcParam(0) = IIf(xentidad = Trim(""), 0, xentidad)
                BacTrader.bacrpt.StoredProcParam(1) = TitRpt
                BacTrader.bacrpt.Formulas(0) = "tit='" & TitRpt & "'"
                BacTrader.bacrpt.Connect = CONECCION
                BacTrader.bacrpt.Action = 1
                Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Impresión" & TitRpt)
                
          Case "VI" 'LlenarVI
          
               TitRpt = "MOVIMIENTO DIARIO DE VENTAS CON PACTO"
               BacTrader.bacrpt.Destination = 0
               BacTrader.bacrpt.ReportFileName = RptList_Path & "LISTVI.RPT"
               BacTrader.bacrpt.StoredProcParam(0) = IIf(xentidad = Trim(""), 0, xentidad)
               BacTrader.bacrpt.StoredProcParam(1) = TitRpt
               BacTrader.bacrpt.Formulas(0) = "tit='" & TitRpt & "'"
               BacTrader.bacrpt.Connect = CONECCION
               BacTrader.bacrpt.Action = 1
               Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Impresión " & TitRpt)
          
          Case "RC" 'Adrian

               TitRpt = "MOVIMIENTO DIARIO DE RECOMPRAS"
               BacTrader.bacrpt.Destination = 0
               BacTrader.bacrpt.ReportFileName = RptList_Path & "LISTRC.RPT"
               BacTrader.bacrpt.StoredProcParam(0) = IIf(xentidad = Trim(""), 0, xentidad)
               BacTrader.bacrpt.Formulas(0) = "tit='" & TitRpt & "'"
               BacTrader.bacrpt.Connect = CONECCION
               BacTrader.bacrpt.Action = 1
               Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Impresión " & TitRpt)
                
          Case "RV" 'LlenarRV
               
               TitRpt = "MOVIMIENTO DIARIO DE REVENTAS"
               BacTrader.bacrpt.Destination = 0
               BacTrader.bacrpt.ReportFileName = RptList_Path & "LISTRV.RPT"
               BacTrader.bacrpt.StoredProcParam(0) = IIf(xentidad = Trim(""), 0, xentidad)
               BacTrader.bacrpt.Formulas(0) = "tit='" & TitRpt & "'"
               BacTrader.bacrpt.Connect = CONECCION
               BacTrader.bacrpt.Action = 1
               Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Impresión " & TitRpt)
                
          Case "IB" 'LlenarRV
          
               TitRpt = "MOVIMIENTO DIARIO DE INTERBANCARIOS"
               BacTrader.bacrpt.Destination = 0
               BacTrader.bacrpt.ReportFileName = RptList_Path & "LISTIB.RPT"
               BacTrader.bacrpt.StoredProcParam(0) = IIf(xentidad = Trim(""), 0, xentidad)
               BacTrader.bacrpt.Formulas(0) = "tit='" & TitRpt & "'"
               BacTrader.bacrpt.Connect = CONECCION
               BacTrader.bacrpt.Action = 1
               Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Impresión " & TitRpt)
          
            Case "AN" 'Adrián
'''''               If XCarteraSuper = "" Then
'''''                  cs = 2
'''''               End If
'''''               For x = 1 To cs
'''''                  If cs > 1 Then
'''''                     If x = 1 Then XCarteraSuper = "T": Titulo = "TRANSABLE"
'''''                     If x = 2 Then XCarteraSuper = "P": Titulo = "PERMANENTE"
'''''                  End If

                Sql = "SP_CON_INFO_COMBO"
                
                Envia = Array()
                AddParam Envia, GLB_CARTERA_NORMATIVA

                If Bac_Sql_Execute(Sql, Envia) Then
                    Do While Bac_SQL_Fetch(oDatos())
                        If XCarteraSuper = "" Or XCarteraSuper = oDatos(2) Then
                        
                            Titulo = Trim(oDatos(6))

                            TitRpt = "MOVIMIENTO DIARIO DE OPERACIONES ANULADAS " + Titulo
                            BacTrader.bacrpt.Destination = 0
                            BacTrader.bacrpt.ReportFileName = RptList_Path & "LISTAN.RPT"
                            BacTrader.bacrpt.StoredProcParam(0) = IIf(xentidad = Trim(""), 0, xentidad)
'''''                            BacTrader.bacrpt.StoredProcParam(1) = XCarteraSuper
                            BacTrader.bacrpt.StoredProcParam(1) = Trim(oDatos(2))
                            BacTrader.bacrpt.Formulas(0) = "titulo='" & TitRpt & "'"
                            BacTrader.bacrpt.Connect = CONECCION
                            BacTrader.bacrpt.Action = 1
                            Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Impresión " & TitRpt)
                        End If
                    Loop
                 Else
                    MsgBox "Ha ocurrido un error al intentar rescatar la descripcion de las carteras normativas", vbOKOnly + vbCritical
                    Exit Function
                End If
'''''               Next x
                
        Case "RCC"
                If Not Llenar_Parametros("REPORTE DE RECOMPRAS POR CLIENTE") Then Exit Function
           'no esta activo ni con odbc
                If LlenarRC(xentidad) Then
                    BacTrader.bacrpt.Destination = 0
                    BacTrader.bacrpt.ReportFileName = RptList_Path & "LISTRC.RPT"
                    'BacTrader.bacrpt.WindowParentHandle = BacTrader.hWnd
                    BacTrader.bacrpt.Action = 1
                    Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Impresión de informe de reporte de recompras por cliente")
                End If
          
          Case "RVC"
'               If Not Llenar_Parametros("REPORTE DE REVENTAS POR CLIENTE") Then Exit Function
           ' no esta activo ni con odbc
'               If LlenarRCRV(xentidad) Then

                    BacTrader.bacrpt.Destination = 0
                    BacTrader.bacrpt.ReportFileName = RptList_Path & "LISTRCRV.RPT"
                    BacTrader.bacrpt.StoredProcParam(0) = "RC"
                    BacTrader.bacrpt.StoredProcParam(1) = 0
                    BacTrader.bacrpt.Action = 1
                    
                    BacTrader.bacrpt.Destination = 0
                    BacTrader.bacrpt.ReportFileName = RptList_Path & "LISTRCRV.RPT"
                    BacTrader.bacrpt.StoredProcParam(0) = "RV"
                    BacTrader.bacrpt.StoredProcParam(1) = 0
                    BacTrader.bacrpt.Action = 1
                    
                    Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Impresión de informe de reporte de reventas por cliente")
'               End If
                
'          Case "PA"
'                   BacIrfNueVentana "LI", "VCTOPAP"
          
          Case "VCP"
              'no esta activo ni con odbc -- SP_INFORMEVCTOCI
                If Inf_VctoVcPactos(xentidad) Then
                    BacTrader.bacrpt.Destination = 0
                    BacTrader.bacrpt.ReportFileName = RptList_Path & "VCTOCI.RPT"
                    'BacTrader.bacrpt.WindowParentHandle = BacTrader.hWnd
                    BacTrader.bacrpt.Action = 1
                End If
         
         Case "VVP"
                    'no esta activo ni con odbc
                If Inf_VctoVvPactos(xentidad) Then
                    BacTrader.bacrpt.Destination = 0
                    BacTrader.bacrpt.ReportFileName = RptList_Path & "VCTOVI.RPT"
                    'BacTrader.bacrpt.WindowParentHandle = BacTrader.hWnd
                    BacTrader.bacrpt.Action = 1
                                                                                                                                                                   End If
         Case "VD"
                ' no esta activo ni con odbc
                If Inf_VctoDPosito(xentidad) Then
                    BacTrader.bacrpt.Destination = 0
                    BacTrader.bacrpt.ReportFileName = RptList_Path & "VCTODEP.RPT"
                    'BacTrader.bacrpt.WindowParentHandle = BacTrader.hWnd
                    BacTrader.bacrpt.Action = 1
                End If
         
         Case "CC"
          ' no esta activo ni con odbc
            If Inf_VctoCCamara(xentidad) Then
                    BacTrader.bacrpt.Destination = 0
                    BacTrader.bacrpt.ReportFileName = RptList_Path & "MDVIVC.RPT"
                    'BacTrader.bacrpt.WindowParentHandle = BacTrader.hWnd
                    BacTrader.bacrpt.Action = 1
                End If
                
         Case "5104" 'Adrian
'''''               If XCarteraSuper = "" Then
'''''                  cs = 2
'''''               End If
'''''               For x = 1 To cs
'''''               If cs > 1 Then
'''''                  If x = 1 Then XCarteraSuper = "T": Titulo = "TRANSABLE"
'''''                  If x = 2 Then XCarteraSuper = "P": Titulo = "PERMANENTE"
'''''               End If

               TitRpt = "INFORME DE CARTERA DISPONIBLE " + " AL DIA " '+ Titulo + " AL DÍA "
               BacTrader.bacrpt.Destination = 0
               BacTrader.bacrpt.ReportFileName = RptList_Path & "CACPDIS.RPT"
               BacTrader.bacrpt.StoredProcParam(0) = IIf(xentidad = Trim(""), 0, xentidad)
               BacTrader.bacrpt.Formulas(0) = "tit='" & TitRpt & "'"
               BacTrader.bacrpt.Connect = CONECCION
               BacTrader.bacrpt.Action = 1
               Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Impresión " & TitRpt)
'''''               Next
       
          
          Case "5105"
              ' no esta activo ni con odbc
                If Chequear_DvRE() Then
                    If LlenarCTDIS Then
                        BacTrader.bacrpt.ReportFileName = RptList_Path & "CATERDIS.RPT"
                        'BacTrader.bacrpt.WindowParentHandle = BacTrader.hWnd
                        BacTrader.bacrpt.Action = 1
                    End If
                End If
          Case "5106"
             ' no esta activo ni con odbc
                If Chequear_DvRE() Then
                    If LlenarCTINT Then
                        BacTrader.bacrpt.ReportFileName = RptList_Path & "CATERINT.RPT"
                        'BacTrader.bacrpt.WindowParentHandle = BacTrader.hWnd
                        BacTrader.bacrpt.Action = 1
                    End If
                End If
         Case "5107" 'Adrian

                TitRpt = "INFORME DE CARTERA DE COLOCACIONES INTERBANCARIAS AL DÍA "
                BacTrader.bacrpt.Destination = 0
                BacTrader.bacrpt.ReportFileName = RptList_Path & "CARTERIB.RPT"
                BacTrader.bacrpt.StoredProcParam(0) = "ICOL"
                BacTrader.bacrpt.StoredProcParam(1) = IIf(xentidad = Trim(""), 0, xentidad)
                BacTrader.bacrpt.Formulas(0) = "tit='" & TitRpt & "'"
                BacTrader.bacrpt.Connect = CONECCION
                BacTrader.bacrpt.Action = 1
                Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Impresión " & TitRpt)
          
          Case "5108" 'Adrian
               TitRpt = "INFORME DE CARTERA DE CAPTACION INTERBANCARIAS AL DÍA "
               BacTrader.bacrpt.Destination = 0
               BacTrader.bacrpt.ReportFileName = RptList_Path & "CARTERIB.RPT"
               BacTrader.bacrpt.StoredProcParam(0) = "ICAP"
               BacTrader.bacrpt.StoredProcParam(1) = IIf(xentidad = Trim(""), 0, xentidad)
               BacTrader.bacrpt.Formulas(0) = "tit='" & TitRpt & "'"
               BacTrader.bacrpt.Connect = CONECCION
               BacTrader.bacrpt.Action = 1
               Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Impresión " & TitRpt)
                
          Case "5109"
              ' no esta activo ni con odbc
                If LlenaPuntas(1) Then
                    BacTrader.bacrpt.Destination = 1
                    BacTrader.bacrpt.ReportFileName = RptList_Path & "MDPTAS1.RPT"
                    'BacTrader.bacrpt.WindowParentHandle = BacTrader.hWnd
                    BacTrader.bacrpt.Action = 1
                    Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Impresión de puntas de prc")
                End If
                    
                If LlenaPuntas(2) Then
                    BacTrader.bacrpt.Destination = 1
                    BacTrader.bacrpt.ReportFileName = RptList_Path & "MDPTAS2.RPT"
                    'BacTrader.bacrpt.WindowParentHandle = BacTrader.hWnd
                    BacTrader.bacrpt.Action = 1
                    Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Impresión de puntas de prc")
                End If
                
          Case "ND"
                TitRpt = "NÓMINA DE DOCUMENTOS"
                BacTrader.bacrpt.Destination = 0
                BacTrader.bacrpt.ReportFileName = RptList_Path & "CACUCP.RPT"
                'If xentidad = "" Then xentidad = 0
                'BacTrader.bacrpt.StoredProcParam(0) = IIf(xentidad = Trim(""), 0, xentidad)
                BacTrader.bacrpt.StoredProcParam(0) = 0
                BacTrader.bacrpt.Formulas(0) = "tit='" & TitRpt & "'"
                BacTrader.bacrpt.Connect = CONECCION
                BacTrader.bacrpt.Action = 1
                Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Impresión NÓMINA DE DOCUMENTOS")
                
          Case "CD"
                TitRpt = "INFORME DE CUSTODIA DCV AL DÍA "
                BacTrader.bacrpt.Destination = 0
                BacTrader.bacrpt.ReportFileName = RptList_Path & "CPDCV.RPT"
                If xentidad = "" Then xentidad = 0
                BacTrader.bacrpt.StoredProcParam(0) = IIf(xentidad = Trim(""), 0, xentidad)
                BacTrader.bacrpt.Formulas(0) = "tit='" & TitRpt & "'"
                BacTrader.bacrpt.Connect = CONECCION
                BacTrader.bacrpt.Action = 1
                Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Impresión INFORME DE CUSTODIA DCV AL DÍA ")
                
          Case "MD"
                TitRpt = "INFORME DE VENTAS DE CUSTODIA DCV DEL DÍA "
                BacTrader.bacrpt.Destination = 0
                BacTrader.bacrpt.ReportFileName = RptList_Path & "MOVDCV.RPT"
                If xentidad = "" Then xentidad = 0
                BacTrader.bacrpt.StoredProcParam(0) = IIf(xentidad = Trim(""), 0, xentidad)
                BacTrader.bacrpt.Formulas(0) = "tit='" & TitRpt & "'"
                BacTrader.bacrpt.Connect = CONECCION
                BacTrader.bacrpt.Action = 1
                Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Impresión INFORME DE VENTAS DE CUSTODIA DCV DEL DÍA ")
          Case "GP"
                ' no esta activo ni con odbc
                If LlenaInfoGesPactos(xentidad) Then
                     BacTrader.bacrpt.Destination = 1
                     BacTrader.bacrpt.ReportFileName = RptList_Path & "MDGEP.RPT"
                     'BacTrader.bacrpt.WindowParentHandle = BacTrader.hWnd
                     BacTrader.bacrpt.Action = 1
                    Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Impresión de informe de gestión de pactos")
                 End If
          Case "GCV"
                'No esta activo ni con odbc
                If LlenaInfoGesCVDef(xentidad) Then
                    BacTrader.bacrpt.Destination = 1
                    BacTrader.bacrpt.ReportFileName = RptList_Path & "MDGEV.RPT"
                    'BacTrader.bacrpt.WindowParentHandle = BacTrader.hWnd
                    BacTrader.bacrpt.Action = 1
                    Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Impresión de informe GCV ")
                End If
          Case "5502"
                'No esta activo ni con odbc
                If LlenaInfoGesInter Then
                    BacTrader.bacrpt.Destination = 1
                    BacTrader.bacrpt.ReportFileName = RptList_Path & "MDGEI.RPT"
                    'BacTrader.bacrpt.WindowParentHandle = BacTrader.hWnd
                    BacTrader.bacrpt.Action = 1
                    Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Impresión de informe de gestion")
                End If
          Case "5602"
                'no esta activo ni con odbc
                If LlenaInfoOperMes Then
                    BacTrader.bacrpt.Destination = 1
                    BacTrader.bacrpt.ReportFileName = RptList_Path & "MDOPMES.RPT"
                    'BacTrader.bacrpt.WindowParentHandle = BacTrader.hWnd
                    BacTrader.bacrpt.Action = 1
                    Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Impresión de operaciones del mes")
                End If
                
            Case "CIC" ' Cartera de Captaciones Adrian
               TitRpt = "INFORME DE CARTERA DE CAPTACIONES "
               BacTrader.bacrpt.Destination = 0
               BacTrader.bacrpt.ReportFileName = RptList_Path & "CAPTACAR.RPT"
               BacTrader.bacrpt.StoredProcParam(0) = IIf(xentidad = Trim(""), 0, xentidad)
               BacTrader.bacrpt.Formulas(0) = "tit='" & TitRpt & "'"
               BacTrader.bacrpt.Connect = CONECCION
               BacTrader.bacrpt.Action = 1
               Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Impresión " & TitRpt)
             
                
            Case "ICDF" ' Disponibilidad de fondos
               ' no esta activo ni con odbc
                If Not Llenar_Parametros("DISPONIBILIDAD DE FONDOS AL ") Then Exit Function

                If LlenarCartCaptacion(xentidad) Then
                    BacTrader.bacrpt.Destination = 0
                    BacTrader.bacrpt.ReportFileName = RptList_Path & "CAPTADIS.RPT"
                    'BacTrader.bacrpt.WindowParentHandle = BacTrader.hWnd
                    BacTrader.bacrpt.Action = 1
                    Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Impresión de disponibilidad de fondos de captaciones")
                End If

            Case "ICD" ' Movimiento de Captaciones Diarias Adrian
               TitRpt = "INFORME DE MOVIMIENTO DE CAPTACIONES "
               BacTrader.bacrpt.Destination = 0
               BacTrader.bacrpt.ReportFileName = RptList_Path & "CAPTAMOV.RPT"
               BacTrader.bacrpt.StoredProcParam(0) = IIf(xentidad = Trim(""), 0, xentidad)
               BacTrader.bacrpt.Formulas(0) = "TIT='" & TitRpt & "'"
               BacTrader.bacrpt.Connect = CONECCION
               BacTrader.bacrpt.Action = 1
               Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Impresión " & TitRpt)
    
     End Select
     Screen.MousePointer = vbDefault
    End If
    Exit Function
    
ErrPrinter:
    Screen.MousePointer = vbDefault
    MsgBox Str(err.Number) + " " + err.Description
    MsgBox "Problemas en impresión de reportes: " & err.Description & ". Verifique", vbExclamation, gsBac_Version
    Exit Function

End Function


