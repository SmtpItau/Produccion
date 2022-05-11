Attribute VB_Name = "BacLineas"
   Global Const Cafe = &H40&
   Global Const Blanco = &HFFFFFF
   Global Const Verde = &H808000
   Global Const Gris = &H80000004
   Global Const Azul = &HFF0000
   Global Const Celeste = &HFFFF00
   Global Const Plomo = &H808080
   Global Const AzulOsc = &H800000
   Global Const Rojo = &HFF&
   Global Const Negro = &H1
   Global Const Amarillo = &HC0FFFF
   
Sub IntraDay_Marca_Operacion(Grid As MSFlexGrid, Fila As Integer, Caja As String, Letra As String)
   
   Dim Col As Integer
   Dim C As Integer
   
   With Grid
      
      For C = 0 To .Cols - 1
         
         .Row = Fila
         .Col = C
         .CellBackColor = Val(Caja)
         .CellForeColor = Val(Letra)
      
      Next
      
      .Col = Col
   
   End With

End Sub

Function Formato_Grilla(grilla As MSFlexGrid)
   Dim x       As Integer
   With grilla
      .ForeColorSel = Azul
      .ForeColor = AzulOsc
      .GridLines = flexGridInset
      .GridLinesFixed = flexGridNone
      .ForeColorFixed = Blanco
      .BackColorFixed = Verde
      .BackColor = Gris
      .BackColorSel = AzulOsc
      .BackColorBkg = &H808080    'Gris 'PLOMO
      .Font.Bold = True
      .CellFontBold = True
      .ForeColorSel = Blanco
      .FocusRect = flexFocusNone
      .WordWrap = True
      .RowHeightMin = 250
      .BorderStyle = flexBorderSingle
      .Appearance = flex3D
      .TextStyle = flexTextFlat
      .GridColorFixed = RGB(0, 0, 0)
   End With
End Function

Public Function BacBeginTransaction() As Boolean

   BacBeginTransaction = True
   If Not Bac_Sql_Execute("BEGIN TRANSACTION") Then
      BacBeginTransaction = False
   End If

End Function

Public Function BacRollBackTransaction() As Boolean

   BacRollBackTransaction = True
   If Not Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
      BacRollBackTransaction = False
   End If

End Function

Public Function BacCommitTransaction() As Boolean

   BacCommitTransaction = True
   If Not Bac_Sql_Execute("COMMIT TRANSACTION") Then
      BacCommitTransaction = False
   End If

End Function

Function Relleno(Dato, Maximo As Integer, Caracter As String, Tipo As Integer, Decimales) As String
   Dim Formato As String
   Dim Largo As Integer
   
   Formato = ""
   Relleno = ""
   Formato = String((Maximo), Caracter)
   Select Case Tipo
      Case 1
         If Dato >= 0 Then 'Si el monto es positivo
            If Dato <> "" Then
               Relleno = Trim(Format(Dato, Formato))
            Else
               Relleno = Formato
            End If
         Else
            Relleno = Trim(Format(Mid(Dato, 2, Len(Dato)), Formato)) 'Quita el signo negativo
         End If
      Case 2
         If Dato <> "" Then
            Dim I As Integer
            Dim sT As String
            Dim xT As String
            Relleno = Dato
            For I = 1 To Len(Relleno)
               sT = Right(Relleno, I)
               xT = Mid(sT, 1, 1)
               If xT = "," Then
                  Exit For
               End If
            Next I
            
            If xT <> "," Then
               Relleno = MontoPunto(Trim(Str(Dato)))
               Relleno = Relleno + "," + String(Decimales, "0")
            Else
               If Len(sT) = 2 Then
                  Relleno = Relleno + String(1, "0")
               End If
               If Len(sT) = 3 Then
                  Relleno = Relleno + String(2, "0")
               End If
               If sT = 4 Then
                  Relleno = Relleno + String(3, "0")
               End If
            End If
            Relleno = Space(Maximo - Len(Relleno)) + Trim(Format(Relleno, Formato))
         
         Else
            Relleno = Space(Maximo - Len(Dato)) + Trim(Format(Dato, Formato))
         End If
      Case 3
         Relleno = Space(Maximo - Len(Dato)) + Trim(Format(Dato, Formato))
      Case 4
         Relleno = Trim(Format(Dato, Formato)) + Space(Maximo - Len(Dato))
      Case 5
         Dim Dec As String
         Dec = Right(Dato, 5)
         Relleno = Mid(Dato, 1, (Len(Dato) - Len(Right(Dato, 5))))
         Relleno = MontoPunto(Relleno)
         Relleno = Relleno + Dec
         Relleno = Space(Maximo - Len(Relleno)) + Trim(Format(Relleno, Formato))
   End Select
      
End Function

Function MontoPunto(nMonto As String) As String
   If Len(nMonto) = 4 Then MontoPunto = Mid(nMonto, 1, 1) + "." + Mid(nMonto, 2, 3)
   If Len(nMonto) = 5 Then MontoPunto = Mid(nMonto, 1, 2) + "." + Mid(nMonto, 3, 3)
   If Len(nMonto) = 6 Then MontoPunto = Mid(nMonto, 1, 3) + "." + Mid(nMonto, 4, 3)
   If Len(nMonto) = 7 Then MontoPunto = Mid(nMonto, 1, 1) + "." + Mid(nMonto, 2, 3) + "." + Mid(nMonto, 5, 3)
   If Len(nMonto) = 8 Then MontoPunto = Mid(nMonto, 1, 2) + "." + Mid(nMonto, 3, 3) + "." + Mid(nMonto, 6, 3)
   If Len(nMonto) = 9 Then MontoPunto = Mid(nMonto, 1, 3) + "." + Mid(nMonto, 4, 3) + "." + Mid(nMonto, 7, 3)
   If Len(nMonto) = 10 Then MontoPunto = Mid(nMonto, 1, 1) + "." + Mid(nMonto, 2, 3) + "." + Mid(nMonto, 5, 3) + "." + Mid(nMonto, 8, 3)
   If Len(nMonto) = 11 Then MontoPunto = Mid(nMonto, 1, 2) + "." + Mid(nMonto, 3, 3) + "." + Mid(nMonto, 6, 3) + "." + Mid(nMonto, 9, 3)
   If Len(nMonto) = 12 Then MontoPunto = Mid(nMonto, 1, 3) + "." + Mid(nMonto, 4, 3) + "." + Mid(nMonto, 7, 3) + "." + Mid(nMonto, 10, 3)
   If Len(nMonto) = 13 Then MontoPunto = Mid(nMonto, 1, 1) + "." + Mid(nMonto, 2, 3) + "." + Mid(nMonto, 5, 3) + "." + Mid(nMonto, 8, 3) + "." + Mid(nMonto, 11, 3)
   If Len(nMonto) = 14 Then MontoPunto = Mid(nMonto, 1, 2) + "." + Mid(nMonto, 3, 3) + "." + Mid(nMonto, 6, 3) + "." + Mid(nMonto, 9, 3) + "." + Mid(nMonto, 12, 3)
   If Len(nMonto) = 15 Then MontoPunto = Mid(nMonto, 1, 3) + "." + Mid(nMonto, 4, 3) + "." + Mid(nMonto, 7, 3) + "." + Mid(nMonto, 10, 3) + "." + Mid(nMonto, 13, 3)
   If Len(nMonto) = 16 Then MontoPunto = Mid(nMonto, 1, 1) + "." + Mid(nMonto, 2, 3) + "." + Mid(nMonto, 5, 3) + "." + Mid(nMonto, 8, 3) + "." + Mid(nMonto, 11, 3) + "." + Mid(nMonto, 14, 3)
   If Len(nMonto) = 17 Then MontoPunto = Mid(nMonto, 1, 2) + "." + Mid(nMonto, 3, 3) + "." + Mid(nMonto, 6, 3) + "." + Mid(nMonto, 9, 3) + "." + Mid(nMonto, 12, 3) + "." + Mid(nMonto, 15, 3)
   If Len(nMonto) = 18 Then MontoPunto = Mid(nMonto, 1, 3) + "." + Mid(nMonto, 4, 3) + "." + Mid(nMonto, 7, 3) + "." + Mid(nMonto, 10, 3) + "." + Mid(nMonto, 13, 3) + "." + Mid(nMonto, 16, 3)
   If Len(nMonto) = 19 Then MontoPunto = Mid(nMonto, 1, 1) + "." + Mid(nMonto, 2, 3) + "." + Mid(nMonto, 5, 3) + "." + Mid(nMonto, 8, 3) + "." + Mid(nMonto, 11, 3) + "." + Mid(nMonto, 14, 3) + "." + Mid(nMonto, 17, 3)
   If Len(nMonto) = 20 Then MontoPunto = Mid(nMonto, 1, 2) + "." + Mid(nMonto, 3, 3) + "." + Mid(nMonto, 6, 3) + "." + Mid(nMonto, 9, 3) + "." + Mid(nMonto, 12, 3) + "." + Mid(nMonto, 15, 3) + "." + Mid(nMonto, 18, 3)
   If Len(nMonto) = 21 Then MontoPunto = Mid(nMonto, 1, 3) + "." + Mid(nMonto, 4, 3) + "." + Mid(nMonto, 7, 3) + "." + Mid(nMonto, 10, 3) + "." + Mid(nMonto, 13, 3) + "." + Mid(nMonto, 16, 3) + "." + Mid(nMonto, 19, 3)
   If Len(nMonto) = 22 Then MontoPunto = Mid(nMonto, 1, 1) + "." + Mid(nMonto, 2, 3) + "." + Mid(nMonto, 5, 3) + "." + Mid(nMonto, 8, 3) + "." + Mid(nMonto, 11, 3) + "." + Mid(nMonto, 14, 3) + "." + Mid(nMonto, 17, 3) + "." + Mid(nMonto, 14, 3) + "." + Mid(nMonto, 20, 3)
   If Len(nMonto) = 23 Then MontoPunto = Mid(nMonto, 1, 2) + "." + Mid(nMonto, 3, 3) + "." + Mid(nMonto, 6, 3) + "." + Mid(nMonto, 9, 3) + "." + Mid(nMonto, 12, 3) + "." + Mid(nMonto, 15, 3) + "." + Mid(nMonto, 18, 3) + "." + Mid(nMonto, 14, 3) + "." + Mid(nMonto, 21, 3)
   If Len(nMonto) = 24 Then MontoPunto = Mid(nMonto, 1, 3) + "." + Mid(nMonto, 4, 3) + "." + Mid(nMonto, 7, 3) + "." + Mid(nMonto, 10, 3) + "." + Mid(nMonto, 13, 3) + "." + Mid(nMonto, 16, 3) + "." + Mid(nMonto, 19, 3) + "." + Mid(nMonto, 14, 3) + "." + Mid(nMonto, 22, 3)
End Function
