Attribute VB_Name = "BacExtra"
Dim Sql As String
Dim datos()
Sub Grabar_Log(xSistema As String, xUsuario As String, xFechaProc As Date, xEvento As String)
''''    Sql = "Sp_Grabar_Log '" & xSistema & "'," & Chr(10)
''''    Sql = Sql & "'" & xUsuario & "'," & Chr(10)
''''    Sql = Sql & "'" & Format(xFechaProc, feFECHA) & "'," & Chr(10)
''''    Sql = Sql & "'" & xEvento & "'"
    Envia = Array(xSistema, _
                  xUsuario, _
                  xFechaProc, _
                  xEvento)
    If Bac_Sql_Execute("Sp_Grabar_Log", Envia) Then
        If Bac_SQL_Fetch(datos()) Then
            If datos(1) = "NO" Then
                MsgBox "Problemas al Grabar Log", vbOKOnly + vbExclamation, TITSISTEMA
            End If
        End If
    End If
End Sub
' ============================================================================================
Function BacPunto(txtObjeto As Object, xkeyascii As Integer, xRedondeo As Integer) As Integer
' ============================================================================================
'   Función     : BacPunto
'   Objetivo    : Validar el ingreso de decimales
'   Autor       : Miguel Gajardo
'   Fecha       : 15/05/2000
' ============================================================================================
If Not IsNumeric(Chr(xkeyascii)) And Chr(xkeyascii) <> "." And Chr(xkeyascii) <> "," And xkeyascii <> 8 And xkeyascii <> 13 Then
  xkeyascii = 0
End If
       If Chr(xkeyascii) = "." Or Chr(xkeyascii) = "," Then
            If InStr(1, txtObjeto.Text, ".") <> 0 Then
              xkeyascii = 0
            End If
        End If
        If InStr(1, txtObjeto.Text, ".") <> 0 Then
            If Len(Mid(txtObjeto.Text, InStr(1, txtObjeto.Text, "."))) > xRedondeo And xkeyascii <> 8 And xkeyascii <> 13 Then
              xkeyascii = 0
            End If
        End If
        
    BacPunto = xkeyascii
End Function

Public Function Bloqueado(xUsuario As String) As Boolean

   Bloqueado = False

   Envia = Array(xUsuario)
   
   If Bac_Sql_Execute("Sp_TraeBloqueo_Usuario", Envia) Then
       
       If Bac_SQL_Fetch(datos()) Then
          
          If datos(1) = "1" Then
             
             Bloqueado = True
             Exit Function
          
          End If
       
       End If
   
   End If
   
End Function

Function Encript(xClave As String, xEncriptar As Boolean) As String
Dim X As Single
Dim xPsw As String
Dim Letras As String
Dim Codigos As String

'Letras = "ABCDEFGHIJKLMNOPQRSTUVWXYWZ1234567890ÿ[¦´«]#$%&úß¡?ý}<_>§æØáø×ƒ®ÇéåêëèïîÐ"
'Codigos = "ÿ[¦´«]#$%&úß¡?ý}<_>§æØáø×ƒ®ÇéåêëèïîÐABCDEFGHIJKLMNOPQRSTUVWXYWZ1234567890"

'Letras = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890abcdefghijklmnopqrstuvwxyz"
'Codigos = "RaMbKCgTrZHYFIPAuSiQVONmLfJWzGXEDqBUx_kpjcys{dn}ve]htwl[\`@?><"
Letras = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890abcdefghijklmnopqrstuvwxyzÑñ#$%&()*+/=[\]_{}"
Codigos = "RaMbKCgTrZHYFIPAuSiQVONmLfJWzGXEDqBUx_kpjcys{dn}ve]htwl[\`@?><Ññ1234567890;:.'~¿"

xPsw = ""
Encript = ""

For X = 1 To Len(xClave)
 
    If xEncriptar Then
       xPsw = xPsw + Chr((Asc(Mid(Codigos, InStr(1, Letras, Mid(xClave, X, 1)), 1)) - X))
    Else
       xPsw = xPsw + Mid(Letras, InStr(1, Codigos, Chr(Asc(Mid(xClave, X, 1)) + X)), 1)
    End If
 
Next

Encript = xPsw

End Function
Function Bloquea_Usuario(xBloquea As Boolean, xUsuario As String) As Boolean
'Objetivo : Bloquear usuarios en tablas FOX y en SQL
'Autor     : Miguel Gajardo
'Fecha    : 18/02/2000
Bloquea_Usuario = False
Envia = Array(xUsuario, IIf(xBloquea, 1, 0))
   
   If Not Bac_Sql_Execute("Sp_Bloquea_Gen_Usuario", Envia) Then       ' & xUsuario & "','" & IIf(xBloquea, 1, 0) & "'") = 0 Then
'       Do While miSQL.SQL_Fetch(Datos()) = 0
'       Loop
'   Else
      Exit Function
   End If

Bloquea_Usuario = True
End Function
Function BuscaEnCombo(Combo As Object, xcod As String, xForma As String) As Double
Dim X As Single
BuscaEnCombo = -1

If xForma = "C" Then
For X = 0 To Combo.ListCount - 1
 If Val(Right(Combo.List(X), 5)) = Val(xcod) Then
    BuscaEnCombo = X
    Exit For
 End If
Next
ElseIf xForma = "G" Then
For X = 0 To Combo.ListCount - 1
 If Trim(Left(Combo.List(X), Len(Combo.List(X)) - 5)) = Trim(xcod) Then
    BuscaEnCombo = X
    Exit For
 End If
Next
End If
End Function


Function Punto(txtObjecto As Object, xkeyascii As Integer) As Integer
    If Not IsNumeric(Chr(xkeyascii)) And Chr(xkeyascii) <> "." And Chr(xkeyascii) <> "," And xkeyascii <> 8 And xkeyascii <> 13 And xkeyascii <> 82 And xkeyascii <> 86 Then
        xkeyascii = 0
    End If
    If Chr(xkeyascii) = "." Or Chr(xkeyascii) = "," Then
        If InStr(1, txtObjecto.Text, ".") <> 0 Then
            xkeyascii = 0
        End If
    End If
    Punto = xkeyascii
End Function

Function FechaMayorActual(Xdia As String, xMes As String, xAno As String) As Boolean
FechaMayorActual = False

If Not IsDate(xAno + "/" + xMes + "/" + Xdia) Then
     Exit Function
End If
If CDate(xAno + "/" + xMes + "/" + Xdia) < gsBAC_Fecp Then
      Exit Function
End If

FechaMayorActual = True
End Function

Sub Limpiar_Cristal()
   Dim I As Integer
   
   For I = 0 To 20
        BacControlFinanciero.CryFinanciero.StoredProcParam(I) = ""
        BacControlFinanciero.CryFinanciero.Formulas(I) = ""
   Next I
   
   BacControlFinanciero.CryFinanciero.WindowTitle = ""
   BacControlFinanciero.CryFinanciero.WindowState = crptNormal
   BacControlFinanciero.CryFinanciero.WindowBorderStyle = crptFixedDouble
   BacControlFinanciero.CryFinanciero.WindowControlBox = True
   BacControlFinanciero.CryFinanciero.WindowControls = True
   BacControlFinanciero.CryFinanciero.WindowTop = 75
   BacControlFinanciero.CryFinanciero.WindowLeft = 0
   BacControlFinanciero.CryFinanciero.WindowHeight = Screen.Height / Screen.TwipsPerPixelX - 102
   BacControlFinanciero.CryFinanciero.WindowWidth = Screen.Width / Screen.TwipsPerPixelY + 1
   BacControlFinanciero.CryFinanciero.Connect = swConeccion

End Sub
