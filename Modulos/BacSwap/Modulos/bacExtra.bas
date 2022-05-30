Attribute VB_Name = "BacExtra"
Option Explicit

Dim Sql        As String
Dim Datos()

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
Public Sub LlenaComboOperadores(ByRef COMBO As ComboBox)
'JBH, 22-12-2009.   Llena combo con Operadores
Dim nomSp As String
Dim xUsuario As String
Dim xNombre As String
Dim l1 As Integer
Dim l2 As Integer
Dim Linea As String
Dim dif As Integer
Dim DATOS()
nomSp = "BACPARAMSUDA.dbo.SP_CARGAOPERADORES"
Envia = Array()
If Not Bac_Sql_Execute(nomSp, Envia) Then
    Screen.MousePointer = 0
    Exit Sub
End If
Do While Bac_SQL_Fetch(DATOS)
    xUsuario = DATOS(1)
    xNombre = DATOS(2)
    l1 = Len(xUsuario)
    l2 = Len(xNombre)
    dif = 110 - l2
    Linea = xNombre & Space(dif) & xUsuario
    COMBO.AddItem (Linea)
Loop
End Sub
Public Function ActualizaDigitador(ByVal numdoc As Double) As Boolean
'JBH, 22-12-2009.  Actualiza el digitador en tabla MovDiario para el documento
Dim DATOS()
Envia = Array()
Dim nomSp As String
nomSp = "dbo.SP_ACTUALIZADIGITADORMOVDIARIO"
AddParam Envia, gsBAC_User
AddParam Envia, numdoc
If Bac_Sql_Execute(nomSp, Envia) Then
    ActualizaDigitador = True
Else
    ActualizaDigitador = False
End If
End Function

Public Function ControlAtribuciones() As Boolean
 Dim oHabilita  As Boolean
   Dim Sqldatos()

   Envia = Array()
   AddParam Envia, gsBAC_User
   If Not Bac_Sql_Execute("BacParamSuda.dbo.SP_CONTROL_ATRIBUCIONES", Envia) Then
      oHabilita = True
   End If
   If Bac_SQL_Fetch(Sqldatos()) Then
      oHabilita = Sqldatos(1)
   End If
   ControlAtribuciones = oHabilita
End Function

Function Encript(xClave As String, xEncriptar As Boolean) As String
Dim x As Single
Dim xPsw As String
Dim Letras As String
Dim Codigos As String

'Letras = "ABCDEFGHIJKLMNOPQRSTUVWXYWZ1234567890ÿ[¦´«]#$%&úß¡?ý}<_>§æØáø×ƒ®ÇéåêëèïîÐ"
'Codigos = "ÿ[¦´«]#$%&úß¡?ý}<_>§æØáø×ƒ®ÇéåêëèïîÐABCDEFGHIJKLMNOPQRSTUVWXYWZ1234567890"

Letras = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890abcdefghijklmnopqrstuvwxyzÑñ"
Codigos = "RaMbKCgTrZHYFIPAuSiQVONmLfJWzGXEDqBUx_kpjcys{dn}ve]htwl[\`@?><Ññ"
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
'
Function BuscaEnCombo(combo As Object, xcod As String, xForma As String) As Double
Dim x As Single
BuscaEnCombo = -1

If xForma = "C" Then
For x = 0 To combo.ListCount - 1
 If Val(Right(combo.List(x), 5)) = Val(xcod) Then
    BuscaEnCombo = x
    Exit For
 End If
Next
ElseIf xForma = "G" Then
For x = 0 To combo.ListCount - 1
 If Trim(Left(combo.List(x), Len(combo.List(x)) - 5)) = Trim(xcod) Then
    BuscaEnCombo = x
    Exit For
 End If
Next
End If
End Function

Function Llenar_Combos(xcombo As Object, xcategoriaTC As Double) As Boolean
Llenar_Combos = False
Dim Cont As Single
Cont = 0
'Sql = "Sp_TcLeeCodigos1 " & xcategoriaTC
'If MISQL.SQL_Execute(Sql) = 0 Then
'   Do While MISQL.SQL_Fetch(DATOS()) = 0
'    Cont = Cont + 1
'    xcombo.AddItem DATOS(2) + Space(40 + Len(DATOS(2))) + Str(DATOS(1))
'   Loop
'Else
'  Exit Function
'End If

Envia = Array()
AddParam Envia, CDbl(xcategoriaTC)

If Not Bac_Sql_Execute("SP_TCLEECODIGOS1", Envia) Then
   Screen.MousePointer = 0
   Exit Function
Else
   Do While Bac_SQL_Fetch(Datos()) = 0
    Cont = Cont + 1
    xcombo.AddItem Datos(2) + Space(40 + Len(Datos(2))) + Str(Datos(1))
   Loop
End If


If Cont = 0 Then
  Exit Function
End If
Llenar_Combos = True
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


