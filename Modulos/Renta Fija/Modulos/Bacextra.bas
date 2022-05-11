Attribute VB_Name = "BacExtra"
Dim Sql As String
Dim datos()

Global tir              As Double
Global ValorTir         As Double
Global Durmacori        As Double
Global Durmodori        As Double
Global Convex           As Double
Global RangoTir         As Double
Global codigo_planilla  As Double
Global Correlativo      As Double
'Global largo_clave      As Integer
Global Sw_Fin_De_Mes As Integer
Global NumeroOperacionExceso As Long
Global Tipo_Operacion   As String

'LD1_COR_035
Global SW_TASA_TRAN     As Double
'LD1_COR_035

Public Function Func_Cartera(Combo As ComboBox, Sistema As String)
Dim Sql   As String
Dim datos()
Dim I As Integer
    
Combo.Clear

Combo.AddItem "< TODAS >"
Combo.ItemData(Combo.NewIndex) = 0


Envia = Array()

    AddParam Envia, Sistema

    Sql = "BACPARAMSUDA..SP_LEECARTERASISTEMA"
   If Not Bac_Sql_Execute(Sql, Envia) Then
      Screen.MousePointer = 0
      Exit Function
   Else
      Do While Bac_SQL_Fetch(datos())
           
           Combo.AddItem UCase(datos(2))
           Combo.ItemData(Combo.NewIndex) = Val(datos(1))
           
      Loop
   End If

If Combo.ListCount > 0 Then Combo.ListIndex = 0

End Function

Function Busca_Fin_Mes_Feriado() As Boolean

If Not BacEsHabil(Format$(gsBac_Fecp, "dd/mm/yyyy")) Then
   Busca_Fin_Mes_Feriado = True
Else
   Busca_Fin_Mes_Feriado = False
End If

End Function


Sub Grabar_Log(xSistema As String, xUsuario As String, xFechaProc As Date, xEvento As String)
    
   Envia = Array()
   AddParam Envia, xSistema
   AddParam Envia, xUsuario
   AddParam Envia, xFechaProc
   AddParam Envia, xEvento
            
    If Bac_Sql_Execute("SP_GRABAR_LOG", Envia) Then
        If Bac_SQL_Fetch(datos()) Then
            If datos(1) = "NO" Then
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
   If Bac_Sql_Execute("SP_TRAEBLOQUEO_USUARIO", Array(xUsuario)) Then
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
   Bloquea_Usuario = False
   Envia = Array(xUsuario, IIf(xBloquea, 1, 0))
   
   If Not Bac_Sql_Execute("SP_BLOQUEA_GEN_USUARIO", Envia) Then
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

Function Llenar_Combos(xcombo As Object, xcategoriaTC As Double) As Boolean
Dim Cont As Single

    Llenar_Combos = False

    Cont = 0
'    Sql = "SP_TCLEECODIGOS1 " & xcategoriaTC

    Envia = Array(xcategoriaTC)
    
    If Not Bac_Sql_Execute("SP_TCLEECODIGOS1", Envia) Then
        Exit Function
    End If
    
    Do While Bac_SQL_Fetch(datos())
        Cont = Cont + 1
        xcombo.AddItem datos(2) + Space(40 + Len(datos(2))) + Str(datos(1))
    Loop
    
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

Function FechaMayorActual(Xdia As String, xMes As String, xano As String) As Boolean
FechaMayorActual = False

Da = Format(Date, "dd/mm/yyyy")
xMes = Mid(Da, 4, 2)
xano = Mid(Da, 7, 9)
Xdia = Mid(Da, 1, 2)
If Not IsDate(xano + "/" + xMes + "/" + Xdia) Then
     Exit Function
End If
If CDate(xano + "/" + xMes + "/" + Xdia) < gsBac_Fecp Then
      Exit Function
End If

FechaMayorActual = True
End Function


Public Function BacIsFormLoaded(ByVal sFormName As String) As Boolean
Dim I As Integer

   BacIsFormLoaded = False

   For I = 0 To Forms.Count - 1
   
      If UCase(Forms(I).Name) = UCase(sFormName) Then
         
         BacIsFormLoaded = True
         
      End If
      
   Next I
      

End Function


'
'' Enviar archivos via FTP
''
 Public Function Enviar_por_ftp(cruta As String, direct_carchivo As String) As Boolean
 Dim X
 Dim fName1
 Dim iFileHost
 Dim arc_scrp As String
 Dim variable   As String
 
 On Error GoTo Erroftp
 
 arc_scrp = ""
 fName1 = ""
 fName1 = cruta & "Ftpscrip.txt"
 iFileHost = FreeFile
 
 Enviar_por_ftp = True
 variable = " " & Trim(gsNom_maq)
   Open fName1 For Output As iFileHost
   Close #iFileHost

   Open fName1 For Output As iFileHost
  ' Print #ifilehost, gsNom_maq                                 ' nombre maquina
   Print #iFileHost, gsUser_maq                                 ' USERNAME
   Print #iFileHost, gsPass_maq                                 ' Password
   Print #iFileHost, gsPath_maq                              ' RUTA DE LA MAQUINA
   Print #iFileHost, "put " & direct_carchivo                ' archivo a traspasar
   Print #iFileHost, "bye"   ' termina la secion

   Close #iFileHost
   
    X = Shell("ftp.exe -s:" & fName1 & " " & gsNom_maq)
   
   
   Exit Function
  
Erroftp:
Select Case err.Number
    Case 55
            Close iFileHost
            MsgBox " Error " & err.Number & " " & err.Description
    Case 53
            iFileHost = FreeFile
            Open fName1 For Output As iFileHost
            Close #iFileHost
            MsgBox " Error " & err.Number & " " & err.Description
            'Resume
    Case 0
    MsgBox " Error " & err.Number & " " & err.Description
    '''otro problema
End Select

Enviar_por_ftp = False


Exit Function
Resume
End Function
