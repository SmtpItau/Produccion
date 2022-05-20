Attribute VB_Name = "BacLib"
'*********************JUANLIZAMA************************
'Global objCentralizacion     As New CLS_Parametros
'*******************************************************
Function Encript(xClave As String, xEncriptar As Boolean) As String
Dim x As Single
Dim xPsw As String
Dim Letras As String
Dim Codigos As String

'Letras = "ABCDEFGHIJKLMNOPQRSTUVWXYWZ1234567890ÿ[¦´«]#$%&úß¡?ý}<_>§æØáø×ƒ®ÇéåêëèïîÐ"
'Codigos = "ÿ[¦´«]#$%&úß¡?ý}<_>§æØáø×ƒ®ÇéåêëèïîÐABCDEFGHIJKLMNOPQRSTUVWXYWZ1234567890"

Letras = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890abcdefghijklmnopqrstuvwxyz"
Codigos = "RaMbKCgTrZHYFIPAuSiQVONmLfJWzGXEDqBUx_kpjcys{dn}ve]htwl[\`@?><"
xPsw = ""
Encript = ""

For x = 1 To Len(xClave)
 
 If xEncriptar Then
    xPsw = xPsw + Chr((Asc(Mid(Codigos, InStr(1, Letras, Mid(xClave, x, 1)), 1)) - x))
 Else
    xPsw = xPsw + Mid(Letras, InStr(1, Codigos, Chr(Asc(Mid(xClave, x, 1)) + x)), 1)
 End If
 
Next

Encript = xPsw

End Function

Public Function BacEncript(sPassword As String, bEncript As Boolean) As String
       
       Const LEN_PSW = 15
       Const KEY_PSW = "jm*sx/ch^yr<=ze"
       Const nMAGIC1 = 5
       Const nMAGIC2 = 11
       Const nMAGIC3 = 253

       Dim iDir%, jDir%, kDir%, nAnt%, nAsc%, nKey%, nPsw%, cPsw$

       nAnt% = nMAGIC1
       jDir% = IIf(bEncript, Len(sPassword$), 1)
       kDir% = 0

       For iDir% = 1 To Len(sPassword$)

           If iDir% > LEN_PSW Then kDir% = 1 Else kDir% = kDir% + 1
           
           nAsc% = Asc(Mid$(sPassword$, jDir%, 1))
           nKey% = Asc(Mid$(KEY_PSW$, kDir%, 1))
           nPsw% = nAsc% Xor nKey% Xor nAnt% Xor ((I% / nMAGIC2) Mod nMAGIC3)

           If bEncript Then
                  cPsw$ = cPsw$ & Chr$(nPsw%)
                  nAnt% = nAsc%
                  jDir% = jDir% - 1
           Else
                  cPsw$ = Chr$(nPsw%) & cPsw$
                  nAnt% = nPsw%
                  jDir% = jDir% + 1
           End If

       Next
       
       BacEncript = cPsw$

End Function

Public Function BacExtraer(ByRef sBuff$) As String
       
       Dim iPos%
       iPos% = InStr(sBuff$, "|")
       
       If iPos% > 0 Then
             BacExtraer = Mid$(sBuff$, 1, iPos% - 1)
             sBuff$ = Mid$(sBuff$, iPos% + 1)
       Else
             BacExtraer = sBuff$
             sBuff$ = ""
       End If
       
End Function

Public Function BacStrTran(sCadena$, sFind$, sReplace$) As String
         
'Función que quita las comas dependiendo del formato windows
'Al SqlServer no se le puede pasar un valor numérico con comas

Dim iPos%
Dim iLen%
         
    If Trim$(sCadena$) = "" Then
       sCadena$ = "0"
    End If
    
    iPos% = 1
    
    iLen% = Len(sFind$)
    
    Do While True
        
       iPos% = InStr(1, sCadena$, sFind$)
        
       If iPos% = 0 Then Exit Do
        
       sCadena$ = Mid$(sCadena$, 1, iPos% - 1) + sReplace$ + Mid$(sCadena$, iPos% + iLen%)
        
    Loop
    
    BacStrTran = Trim$(CStr(sCadena$))
         
End Function

Public Function BacDiaSemana(sfec$) As String

BacDiaSem = ""
    
If IsDate(sfec$) Then
   BacDiaSem = Mid("Domingo   Lunes     Martes    Miércoles Jueves    Viernes   Sábado", (Weekday(sfec$) * 10) - 9, 10)
End If

End Function
Public Sub BacLLenaComboMes(cbx As ComboBox)
   
   cbx.Clear
   
   cbx.AddItem "Enero"
   cbx.ItemData(cbx.NewIndex) = 1
   cbx.AddItem "Febrero"
   cbx.ItemData(cbx.NewIndex) = 2
   cbx.AddItem "Marzo"
   cbx.ItemData(cbx.NewIndex) = 3
   cbx.AddItem "Abril"
   cbx.ItemData(cbx.NewIndex) = 4
   cbx.AddItem "Mayo"
   cbx.ItemData(cbx.NewIndex) = 5
   cbx.AddItem "Junio"
   cbx.ItemData(cbx.NewIndex) = 6
   cbx.AddItem "Julio"
   cbx.ItemData(cbx.NewIndex) = 7
   cbx.AddItem "Agosto"
   cbx.ItemData(cbx.NewIndex) = 8
   cbx.AddItem "Septiembre"
   cbx.ItemData(cbx.NewIndex) = 9
   cbx.AddItem "Octubre"
   cbx.ItemData(cbx.NewIndex) = 10
   cbx.AddItem "Noviembre"
   cbx.ItemData(cbx.NewIndex) = 11
   cbx.AddItem "Diciembre"
   cbx.ItemData(cbx.NewIndex) = 12
   
   cbx.ListIndex = -1

End Sub


Public Function BacValidaRut(Rut As String, dig As String) As Integer

Dim I       As Integer
Dim D       As Integer
Dim Divi    As Long
Dim Suma    As Long
Dim digito  As String
Dim multi   As Double

    BacValidaRut = False
    
    If Trim$(Rut) = "" Or Trim$(dig) = "" Then
       Exit Function
    End If
    
    Rut = Format(Rut, "00000000")
    D = 2
    For I = 8 To 1 Step -1
        multi = Val(Mid$(Rut, I, 1)) * D
        Suma = Suma + multi
        D = D + 1
        If D = 8 Then
           D = 2
        End If
    Next I
    
    Divi = (Suma \ 11)
    multi = Divi * 11
    digito = Trim$(Str$(11 - (Suma - multi)))
    
    If digito = "10" Then
       digito = "K"
    End If
    
    If digito = "11" Then
       digito = "0"
    End If
    
    If Trim$(UCase$(digito)) = UCase$(Trim$(dig)) Then
       BacValidaRut = True
    End If

End Function



Public Sub BacControlWindows(N%)

    Dim I%
    For I% = 1 To N%
          DoEvents
    Next
    
End Sub
