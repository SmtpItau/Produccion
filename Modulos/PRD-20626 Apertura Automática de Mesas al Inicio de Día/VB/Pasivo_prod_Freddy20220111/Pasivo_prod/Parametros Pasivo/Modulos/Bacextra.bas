Attribute VB_Name = "BacExtra"
Global Const PAISES = 1
Global Const REGION = 2
Global Const Ciudad = 3
Global Const COMUNA = 4


Dim Sql As String
Dim Datos()
Global NumeroOperacionExceso As Long

Global cCAMPO_CONTABILIDAD_SISTEMA As String
Global cCAMPO_CONTABILIDAD_CODIGO_PRODUCTO As String

Public Function BacDevuelveDig(Rut As String) As String

   Dim i       As Integer
   Dim D       As Integer
   Dim Divi    As Long
   Dim Suma    As Long
   Dim Digito  As String
   Dim Multi   As Double

   BacDevuelveDig = ""
   
   Select Case Len(Rut)
      Case 1
         Rut = Format(Rut, "0")
      Case 2
         Rut = Format(Rut, "00")
      Case 3
         Rut = Format(Rut, "000")
      Case 4
         Rut = Format(Rut, "0000")
      Case 5
         Rut = Format(Rut, "00000")
      Case 6
         Rut = Format(Rut, "000000")
      Case 7
         Rut = Format(Rut, "0000000")
      Case 8
         Rut = Format(Rut, "00000000")
      Case 9
         Rut = Format(Rut, "000000000")
   
   End Select
   
   D = 2
   For i = Len(Rut) To 1 Step -1
     Multi = Val(Mid$(Rut, i, 1)) * D
     Suma = Suma + Multi
     D = D + 1
      
      If D = 8 Then
         D = 2
      End If
      
   Next i
    
   Divi = (Suma \ 11)
   Multi = Divi * 11
   Digito = Trim$(Str$(11 - (Suma - Multi)))
    
   If Digito = "10" Then
      Digito = "K"
   
   End If
    
   If Digito = "11" Then
      Digito = "0"
   
   End If
    
   BacDevuelveDig = UCase(Digito)

End Function



Sub Grabar_Log(xSistema As String, xUsuario As String, xFechaProc As Date, xEvento As String)

'''''''''''''''''''''''''''''Sql = "Sp_Grabar_Log '" & xSistema & "'," & Chr(10)
'''''''''''''''''''''''''''''Sql = Sql & "'" & xUsuario & "'," & Chr(10)
'''''''''''''''''''''''''''''Sql = Sql & "'" & Format(xFechaProc, "yyyymmdd") & "'," & Chr(10)
'''''''''''''''''''''''''''''Sql = Sql & "'" & xEvento & "'"

Envia = Array()

AddParam Envia, xSistema
AddParam Envia, xUsuario
AddParam Envia, Format(xFechaProc, "yyyymmdd")
AddParam Envia, xEvento


If BAC_SQL_EXECUTE("Sp_Grabar_Log", Envia) Then

   If BAC_SQL_FETCH(Datos()) Then

        If Datos(1) = "NO" Then

             MsgBox "Problemas al grabar log", vbOKOnly + vbExclamation

        End If

   End If

End If

End Sub

' ============================================================================================
Function BacPunto(txtObjeto As Object, xkeyascii As Integer, xEntero As Integer, xRedondeo As Integer) As Integer
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
        Else
            If Len(txtObjeto.Text) >= xEntero And xkeyascii <> 8 And xkeyascii <> 13 And Chr(xkeyascii) <> "." And Chr(xkeyascii) <> "," Then
                 xkeyascii = 0
            End If
        End If
        If (Chr(xkeyascii) = "." Or Chr(xkeyascii) = ",") And xRedondeo = 0 Then
           xkeyascii = 0
        End If
        
    BacPunto = xkeyascii
End Function


Public Function Bloqueado(xUsuario As String) As Boolean
'Objetivo  : Devuelve el estado del usuario ( Bloqueado o no bloqueado)
'Auitor     : Miguel Gajardo

   Bloqueado = False
   
   Envia = Array()
   
   AddParam Envia, xUsuario
   
   If BAC_SQL_EXECUTE("Sp_TraeBloqueo_Usuario", Envia) Then
       
       If BAC_SQL_FETCH(Datos()) Then
          
          If Datos(1) = "1" Then
             
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

Letras = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890abcdefghijklmnopqrstuvwxyz_"
Codigos = "RaMbKCgTrZHYFIPAuSiQVONmLfJWzGXEDqBUx_kpjcys{dn}ve]htwl[\`@?><2"
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



'
Function Bloquea_Usuario(xBloquea As Boolean, xUsuario As String) As Boolean
'Objetivo : Bloquear usuarios en tablas FOX y en SQL
'Autor     : Miguel Gajardo
'Fecha    : 18/02/2000

Bloquea_Usuario = False


Bloquea_Usuario = True
End Function




Function BuscaEnCombo(Combo As Object, xcod As String, xForma As String) As Double
Dim X As Single
BuscaEnCombo = -1

If xForma = "C" Then
   For X = 0 To Combo.ListCount - 1
    If Val(right(Combo.List(X), 5)) = Val(xcod) Then
       BuscaEnCombo = X
       Exit For
    End If
   Next
ElseIf xForma = "G" Then
   For X = 0 To Combo.ListCount - 1
    If Trim(left(Combo.List(X), Len(Combo.List(X)) - 5)) = Trim(xcod) Then
       BuscaEnCombo = X
       Exit For
    End If
   Next
End If
End Function

Function Expira(xFechaExpira As Date) As Boolean
   Expira = False
      If Format(gsbac_fecp, "yyyymmdd") < Format(xFechaExpira, "yyyymmdd") Then
         Exit Function
      End If
   Expira = True
End Function
'insertado 20/12/2000

Function Llenar_Combos(xCombo As Object, xcategoriaTC As Double) As Boolean

Dim Cont As Single
   Llenar_Combos = False
      Cont = 0
     
      
   If xcategoriaTC = 0 Then
   
      If Not BAC_SQL_EXECUTE("Sp_Mostrar_Emisores") Then Exit Function
        Do While BAC_SQL_FETCH(Datos())
            Cont = Cont + 1
            xCombo.AddItem Datos(2) + Space(40 + Len(Datos(2))) + Str(Datos(1))
        Loop
      If Cont = 0 Then
          Exit Function
      End If
   
   Else
   
       Envia = Array()
       AddParam Envia, xcategoriaTC
       If Not BAC_SQL_EXECUTE("sp_tcleecodigos1", Envia) Then Exit Function
         Do While BAC_SQL_FETCH(Datos())
             Cont = Cont + 1
             xCombo.AddItem Datos(2) + Space(40 + Len(Datos(2))) + Str(Datos(1))
             
         Loop
       If Cont = 0 Then
           Exit Function
       End If
   
   End If
      
      
   Llenar_Combos = True
   
End Function

Sub PROC_CARGA_AYUDA(oForm As Form, NumeroF As String)
'AGREGADO POR ERBAQ ; 20-08-2004
'*******************************
Dim Datos()
On Error GoTo ERRCARGAAYUDA

Envia = Array()
AddParam Envia, "PCA"
'If oForm.Name = "FRM_INTERFAZ_GESTION" Then
'   AddParam Envia, "FRM_INTERFAZ" + NumeroF
'Else
'   AddParam Envia, oForm.Name + NumeroF
'End If
'If Not BAC_SQL_EXECUTE("SP_CON_AYUDA_SISTEMA", Envia) Then GoTo ERRCARGAAYUDA
'If Not BAC_SQL_FETCH(Datos()) Then GoTo ERRCARGAAYUDA
'
'If Dir(Datos(1)) = "" Then GoTo ERRCARGAAYUDA
'
'App.HelpFile = Datos(1)
'oForm.HelpContextID = Datos(2)

Exit Sub
ERRCARGAAYUDA:
   App.HelpFile = ""
   oForm.HelpContextID = 0
End Sub

Sub PROC_CENTRAR_FORMULARIO(oFormulario As Form, oFormPrincipal As Form)

   oFormulario.left = (oFormPrincipal.Width / 2) - (oFormulario.Width / 2)
   oFormulario.top = (oFormPrincipal.Height / 2) - (oFormulario.Height / 2)


End Sub

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

Function FechaMayorActual(Xdia As String, xMes As String, xano As String) As Boolean
FechaMayorActual = False
DA = Format(Date, "dd/mm/yyyy")
xMes = Mid(DA, 4, 2)
xano = Mid(DA, 7, 9)
Xdia = Mid(DA, 1, 2)
If Not IsDate(xano + "/" + xMes + "/" + Xdia) Then
     Exit Function
End If
If CDate(xano + "/" + xMes + "/" + Xdia) < gsbac_fecp Then
      Exit Function
End If

FechaMayorActual = True
End Function
Sub CellPintaCelda(grilla As Control)
    grilla.CellForeColor = &H800000
    grilla.CellBackColor = &H8000000F
End Sub

Sub PintaCelda(grilla As Control)
    grilla.CellForeColor = 16777215
    grilla.CellBackColor = &H80000002
End Sub

' << controlador de errores inesperados >>
Sub ShowError()
  Dim sTmp As String
  Screen.MousePointer = vbDefault
  sTmp = "Ocurrió el siguiente error:" & vbCrLf & vbCrLf
  sTmp = sTmp & err.Description & vbCrLf
  sTmp = sTmp & Msg1 & err
  Beep
  MsgBox sTmp, 16
End Sub




