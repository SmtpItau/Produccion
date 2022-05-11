Attribute VB_Name = "BacFunImpre"
'**********************
Global CodLibro As String
Global CodCartNorm As String

Global Const ConstTitle% = 0
Global Const ConstTexto% = 1
Global Const Getchr = 1
Global Const GetNum = 0
Global Const CourierNew = 11

'**********************

Type OrientStructure
  
  Orientation As Long
  Pad As String * 16

End Type

Declare Function Escape% Lib "GDI" (ByVal hDC%, ByVal nEsc%, ByVal nLen%, lpData As OrientStructure, lpOut As Any)

Sub BacEncabeza(Ancho%, Titu_List$, nFolio%)
    
    Dim nFila As Integer

    nFila = 3
  '  BacGlbSetFont 12, False
    BacGlbPrinter nFila, 0, Ancho% + 20, ConstTexto, "Folio :" & Format(nFolio%, "0000000"), 0, Getchr
   ' BacGlbSetFont 15, True
    BacGlbPrinter nFila + 1, 0, 0, ConstTitle, Titu_List$, 0, Getchr
             
        
End Sub
Function BacFGb_SetOrientPrint(horizont) As Integer
    FGb_SetOrientPrint = False
    Const PORTRAIT = 1
    Const LANDSCAPE = 2
    Const GETSETPAPERORIENT = 30
    Const NULL1 = 0

    Dim Orient As OrientStructure

    Printer.Print " "
    Orient.Orientation = horizont
    X% = Escape(Printer.hDC, GETSETPAPERORIENT, Len(Orient), Orient, Null)
    FGb_SetOrientPrint = True
    
End Function
Static Sub BacGlbPrinter(pCurrenty As Variant, pCurrentx As Integer, pTab As Integer, pModo As Integer, pString As Variant, largo As Integer, tipo As Integer)
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
                               Printer.Print Tab(pTab); String(largo - Len(Trim(pString)), Space(1)) + Trim(pString)
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
Public Function Impresion_Entidades(xReporte As String) As Boolean
'Entidad.Show 1

If giAceptar% = True Then
 Select Case xReporte
          Case "VencimientosDia"
             'Call BacVencimientosDia(xEntidad)
             
          Case "SegurosCambioCom"
             'Call BacLeeCarteraSegurosCambio(xEntidad)
          
          Case "SegurosCambioVen"
             'Call BacLeeSegurosCambio(xEntidad)
          
          Case "SegurosInflacionCom"
             'Call BacCarteraComSegInflacion(xEntidad)
          
          Case "SegurosInflacionVen"
             'Call BacCarteravenSegInflacion(xEntidad)
          
          Case "CarteraArbitrajes"
             'Call BacCarteraArbitrajes(xEntidad)
          
          Case "Cartera1446"
             'Call BacCarteraOper1446(xEntidad)
             
          Case "CarteraSinteticos"
             '  Call BacCarteraOperpos(xEntidad)
          
          Case "MovDiaSegCambio"
             'Call BacMovDiaSegCam(xEntidad)

          Case "MovDiaArbitrajes"
             'Call BacMovArbitrajeFut(xEntidad)

          Case "MovDiaUf/Clp"
             'Call BacMovFuturoUF(xEntidad)
          
 End Select
End If

End Function

Public Function LimpiaReportes()

Dim j As Integer

    
    For j = 0 To 20
    
      Parametros.bacrpt.StoredProcParam(j) = ""
      
    Next
    
End Function


