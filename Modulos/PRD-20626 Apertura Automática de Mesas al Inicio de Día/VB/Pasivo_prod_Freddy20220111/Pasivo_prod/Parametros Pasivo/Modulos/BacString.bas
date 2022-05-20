Attribute VB_Name = "BACString"
'*=================================================================*
'* Función    : BacFormatearTexto                                  *
'* Objetivo   : Formatea un Parrafo                                *
'* Parametros : sTexto    String  Parrafo a Formatear              *
'*              nFormato  Integer Justificación (1) Izquierda      *
'*                                              (2) Derecha        *
'*                                              (3) Centrar        *
'*                                              (4) Margen Pefecto *
'*              nPLinea   Integer Primera línea es justificada     *
'*              nTPLinea  Integer Tabulación Primera línea         *
'*              nULinea   Integer Ultima línea es justificada      *
'*              nLargo    Integer Largo de las líneas.             *
'* Retorna    : El texto formateado                                *
'*=================================================================*
'* Función    : BacMLCount                                         *
'* Objectivo  : Cuenta la cantidad de lineas que posee el texto.   *
'* Parametros : sTexto    String  Parrafo                          *
'*              nLargo    Integer Largo máximo por línea           *
'* Retorna    : Cantidad de líneas.                                *
'*=================================================================*
'* Función    : BacMemoLine                                        *
'* Objectivo  : Cuenta la cantidad de lineas que posee el texto.   *
'* Parametros : sTexto    String  Parrafo                          *
'*              nLargo    Integer Largo máximo por línea           *
'*              aLinea    Arreglo con las lineas
'* Retorna    : Cantidad de líneas.                                *
'*=================================================================*
'* Función    : BacRemplazar                                       *
'* Objectivo  : Remplaza un cadena de caracteres por otra          *
'* Parametros : sTexto    String  Parrafo                          *
'*              sBuscar   String  Cadena Buscada                   *
'*              sReplazar String  Cadena con la que se remplaza    *
'* Retorno    : El texto ya remplazado                             *
'*=================================================================*
'* Función    : BacSpread                                          *
'* Objectivo  : Formatea el texto al margen perfecto               *
'* Parametros : sLinea    String  Parrafo                          *
'*              nLargo    Integer Largo máximo por línea           *
'* Retorna    : El texto formateado a un margen perfecto.          *
'*=================================================================*
Option Explicit



Function BacFormatearTexto(sTexto As Variant, nFormato As Integer, nPLinea As Integer, nTPLinea As Integer, nULinea As Integer, nLargo As Integer) As String

   Dim sLinea           As String
   Dim sCadena          As String
   Dim nLar             As Integer
   Dim nCol             As Integer
   Dim nRow             As Integer
   Dim nBus             As Integer
   Dim nBusLin          As Integer
   Dim nCarControl      As Integer
   Dim bProceso         As Boolean
   Dim ncLinea          As Integer

   If nLargo = 0 Then
      BacFormatearTexto = sTexto
      Exit Function

   End If

   If sTexto = "" Then
      BacFormatearTexto = ""
      Exit Function

   End If

   nCol = 1
   nRow = 1

   bProceso = True

   'Elimina los dobles espacios
   sTexto = BacRemplazar(sTexto, "  ", " ")
   sTexto = BacRemplazar(sTexto, vbCrLf, " ")

   'Cuenta la cantidad de lineas
   If nPLinea = 1 Then
      ncLinea = BacMLCount(Space(nTPLinea) + sTexto, nLargo)

   Else
      ncLinea = BacMLCount(sTexto, nLargo)
      nTPLinea = 0

   End If

   nRow = 0

   Do While bProceso

      If Len(Mid$(sTexto, nCol)) > nLargo Then
         sLinea = Mid$(sTexto, nCol, nLargo - nTPLinea)
         nBus = (InStr(Mid$(sTexto, nCol), vbCrLf))

         If nBus > nLargo Then
            nBus = 0

         End If

         If nBus = 0 And Mid$(sTexto, nCol + (nLargo - nTPLinea), 1) <> " " Then
            For nBusLin = Len(sLinea) To 1 Step -1
               If Mid$(sLinea, nBusLin, 1) = " " Then
                  nBus = nBusLin
                  Exit For

               End If
      
            Next nBusLin
      
            If nBus > 0 Then
               sLinea = Mid$(sLinea, 1, nBus - 1)

            End If
      
         Else
            nBus = Len(sLinea)

         End If

         nRow = nRow + 1
         nCol = nCol + Len(sLinea) + nCarControl
         sLinea = RTrim(sLinea)

      Else
         nRow = nRow + 1
         nLar = Len(Mid$(sTexto, nCol)) - IIf(InStr(Mid$(sTexto, nCol), vbCrLf), 2, 0)
         sLinea = Trim(Mid$(sTexto, nCol, nLar))
         bProceso = False

      End If

      If nPLinea = 1 And nRow = 1 Then
         sLinea = BacSpread(sLinea, nLargo - nTPLinea)
         sLinea = Space(nTPLinea) + sLinea

      ElseIf nULinea = 1 And nRow >= ncLinea Then
         sLinea = sLinea

      Else
         Select Case nFormato
         Case 1            'Izquierda
            sLinea = sLinea

         Case 2            'Derecha
            sLinea = Space(nLargo - Len(sLinea)) + sLinea
   
         Case 3            'Centrar
            nLar = Int((nLargo - Len(sLinea)) / 2)
            sLinea = Space(nLar) + sLinea

         Case 4            'Justificar
            sLinea = BacSpread(sLinea, nLargo)

         End Select

      End If

      nTPLinea = 0
      sCadena = sCadena & sLinea & vbCrLf '"  (" & Format(nRow, "000") & ")" & vbCrLf

   Loop

   BacFormatearTexto = sCadena

End Function

Function BacMLCount(sTexto As Variant, nLargo As Integer) As Integer

   Dim sLinea           As String
   Dim nLar             As Integer
   Dim nCol             As Integer
   Dim nRow             As Integer
   Dim nBus             As Integer
   Dim nBusLin          As Integer
   Dim bProceso         As Boolean

   bProceso = True
   nCol = 1
   nRow = 0

   sLinea = sTexto

   Do While bProceso

      If Len(Mid$(sTexto, nCol)) > nLargo Then
         sLinea = Mid$(sTexto, nCol, nLargo)

         nBus = (InStr(Mid$(sTexto, nCol), vbCrLf))

'         If nBus > nLargo Then
'            nBus = 0
'
'         End If

         If nBus = 0 And Mid$(sTexto, nCol + nLargo, 1) <> " " Then
            For nBusLin = Len(sLinea) To 1 Step -1
               If Mid$(sLinea, nBusLin, 1) = " " Then
                  nBus = nBusLin
                  Exit For

               End If
      
            Next nBusLin
      
            If nBus > 0 Then
               sLinea = Mid$(sLinea, 1, nBus - 1)

            End If
      
         ElseIf nBus = 0 Then
            nBus = Len(sLinea)

         Else
            sLinea = Mid$(sLinea, 1, nBus - 1)
            nBus = Len(sLinea) + 2

         End If

         nRow = nRow + 1
         nCol = nCol + nBus    'Len(sLinea)
   
      Else
         nRow = nRow + 1
         nLar = Len(Mid$(sTexto, nCol)) - IIf(InStr(Mid$(sTexto, nCol), vbCrLf), 2, 0)
         sLinea = Mid$(sTexto, nCol)
         bProceso = False

      End If

   Loop

   BacMLCount = nRow

End Function

Function BacMemoLine(sTexto As Variant, nLargo As Integer, ByRef aVec()) As Integer

   Dim sLinea           As String
   Dim nLar             As Integer
   Dim nCol             As Integer
   Dim nRow             As Integer
   Dim nBus             As Integer
   Dim nBusLin          As Integer
   Dim bProceso         As Boolean
   Dim nLin             As Integer

   nLin = BacMLCount(sTexto, nLargo)

   ReDim aVec(nLin)

   bProceso = True
   nCol = 1
   nRow = 0

   sLinea = sTexto

   Do While bProceso

      If Len(Mid$(sTexto, nCol)) > nLargo Then
         sLinea = Mid$(sTexto, nCol, nLargo)

         nBus = (InStr(Mid$(sTexto, nCol), vbCrLf))

'         If nBus > nLargo Then
'            nBus = 0
'
'         End If

         If nBus = 0 And Mid$(sTexto, nCol + nLargo, 1) <> " " Then
            For nBusLin = Len(sLinea) To 1 Step -1
               If Mid$(sLinea, nBusLin, 1) = " " Then
                  nBus = nBusLin
                  Exit For

               End If
      
            Next nBusLin
      
            If nBus > 0 Then
               sLinea = Mid$(sLinea, 1, nBus - 1)

            End If
      
         ElseIf nBus = 0 Then
            nBus = Len(sLinea)

         Else
            sLinea = Mid$(sLinea, 1, nBus - 1)
            nBus = Len(sLinea) + 2

         End If

         nRow = nRow + 1
         nCol = nCol + nBus       'Len(sLinea)
   
      Else
         nRow = nRow + 1
         nLar = Len(Mid$(sTexto, nCol)) - IIf(InStr(Mid$(sTexto, nCol), vbCrLf), 2, 0)
         sLinea = Mid$(sTexto, nCol)
         bProceso = False

      End If

      aVec(nRow) = sLinea

   Loop

   BacMemoLine = nRow

End Function



Function BacRemplazar(sTexto As Variant, sBuscar As String, sReplazar As Variant) As String

   Dim nBuscar          As Integer
   Dim nCampo           As Integer
   Dim nTexto           As Integer
   Dim sCadena          As String

   nCampo = Len(sBuscar)
   nTexto = Len(sTexto)

   If sBuscar = "" Then
      BacRemplazar = sTexto
      Exit Function

   End If

   Do While True
      nBuscar = InStr(sTexto, sBuscar)

      If nBuscar > 0 Then
         sCadena = IIf(nBuscar > 1, Mid$(sTexto, 1, nBuscar - 1), "")
         sCadena = sCadena & (sReplazar)
         sCadena = sCadena + Mid$(sTexto, nBuscar + nCampo, nTexto)
         sTexto = sCadena

      Else
         Exit Do

      End If

   Loop

   BacRemplazar = sTexto

End Function

Function BacSpread(sLinea As String, nLargo As Integer) As String

   Dim nSpread       As Integer
   Dim ncWord        As Integer
   Dim nlWord        As Integer
   Dim bProceso      As Boolean
   Dim sTexto        As String
   Dim nBus          As Integer
   Dim ncFactor      As Double
   Dim ndFactor      As Double
   Dim naFactor      As Integer
   Dim nlFactor      As Integer
   Dim sCadena       As String
   Dim sString       As String
   Dim sWord()

   'Chequea que el largo de la línea sea igual a lo deseado
   sLinea = Trim(sLinea)
   nSpread = nLargo - Len(sLinea)

   If nSpread = 0 Then
      BacSpread = sLinea
      Exit Function

   End If

   'cuenta las Palabras que posee la línea
   bProceso = True
   sTexto = sLinea
   ncWord = 0

   Do While bProceso
      nBus = InStr(sTexto, " ")
      ncWord = ncWord + 1

      If nBus = 0 Then
         nBus = Len(sTexto)
         bProceso = False

      End If

      sTexto = Trim$(Mid$(sTexto, nBus))

   Loop

   'Separa las palabras que posee la línea
   ReDim sWord(ncWord)
   bProceso = True
   sTexto = sLinea

   For nlWord = 1 To ncWord
      nBus = InStr(sTexto, " ")

      If nBus = 0 Then
         nBus = Len(sTexto)
         bProceso = False

      End If

      sWord(nlWord) = Trim(Mid$(sTexto, 1, nBus))

      sTexto = Trim$(Mid$(sTexto, nBus))

   Next nlWord

   'Justifica la línea
   sCadena = ""

   If ncWord > 1 Then
      ncFactor = Val(Format(nSpread / (ncWord - 1), "##0.0000"))

   Else
      ncWord = 0

   End If
   
   ndFactor = 0

   For nlWord = 1 To ncWord - 1
      ndFactor = (ncFactor - Int(ncFactor)) + ndFactor

'      naFactor = int(ndFactor, "#0")
      nlFactor = Int(ncFactor) + 1

      If Int(ndFactor) > 0 Then
         nlFactor = nlFactor + 1
         ndFactor = Val(Format$(ndFactor - 1, "##0.0000")) 'Int(ndFactor)

         If nlWord = (ncWord - 1) Then
            ndFactor = 0

         End If

      End If

      sCadena = sCadena + sWord(nlWord) + Space(nlFactor)

   Next nlWord

   If ndFactor > 0 Then
      sString = " " 'Space(nLargo - Len(sCadena) + Len(sWord(ncWord)))

   End If

   If Len(sCadena + sWord(ncWord)) < nLargo Then
      sString = Space(nLargo - (Len(sCadena + sWord(ncWord))))

   End If


   sCadena = sCadena + sString + sWord(ncWord)

   BacSpread = sCadena

End Function
Public Function BacRemplazarII(cTexto As Variant, cPalMasCerca As String, cVariable As String, cRemplazo As String) As String
   Dim nPosicion As String
   Dim cString1  As String
   Dim cString2  As String
   
   nPosicion = InStr(cTexto, cVariable) + InStr(Mid(cTexto, InStr(cTexto, cVariable), Len(cTexto)), cPalMasCerca) - 1
   cString1 = Mid(cTexto, 1, nPosicion - 1)
   cString2 = Mid(cTexto, nPosicion, Len(cTexto))
   cString1 = BacRemplazar(cTexto, cVariable, cRemplazo)
   cString1 = Mid(cString1, 1, nPosicion - 1)
   
   BacRemplazarII = cString1 + cString2
         
End Function
