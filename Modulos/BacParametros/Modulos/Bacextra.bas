Attribute VB_Name = "BacExtra"
Dim sql As String
Dim Datos()
Global NumeroOperacionExceso As Long

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


If Bac_Sql_Execute("SP_GRABAR_LOG", Envia) Then
   
   If Bac_SQL_Fetch(Datos()) Then
        
        If Datos(1) = "NO" Then
             
             MsgBox "Problemas al grabar log", vbOKOnly + vbExclamation, TITSISTEMA
        
        End If
   
   End If

End If

End Sub

Sub Grabar_Log_AUDITORIA( _
                              Entidad As String _
                            , fechaproc As Date _
                            , Terminal As String _
                            , Usuario As String _
                            , Id_Sistema As String _
                            , Codigo_menu As String _
                            , Evento As String _
                            , Detalle_Transac As String _
                            , TablaInvolucrada As String _
                            , ValorAntiguo As String _
                            , ValorNuevo As String _
                        )

    Envia = Array()
    
    AddParam Envia, Entidad
    AddParam Envia, fechaproc
    AddParam Envia, Terminal
    AddParam Envia, Usuario
    AddParam Envia, Id_Sistema
    AddParam Envia, Codigo_menu
    AddParam Envia, Evento
    AddParam Envia, Detalle_Transac
    AddParam Envia, TablaInvolucrada
    AddParam Envia, ValorAntiguo
    AddParam Envia, ValorNuevo
    
    'If Bac_Sql_Execute("Sp_Grabar_Log_AUDITORIA", Envia) Then
    If Bac_Sql_Execute("SP_LOG_AUDITORIA", Envia) Then
       
       If Bac_SQL_Fetch(Datos()) Then
            
            If Datos(1) = "NO" Then MsgBox "Problemas al grabar log", vbOKOnly + vbExclamation, TITSISTEMA
       
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


Public Function bloqueado(xUsuario As String) As Boolean
'Objetivo  : Devuelve el estado del usuario ( Bloqueado o no bloqueado)
'Auitor     : Miguel Gajardo

   bloqueado = False
   
   Envia = Array()
   
   AddParam Envia, xUsuario
   
   If Bac_Sql_Execute("SP_TRAEBLOQUEO_USUARIO", Envia) Then
       
       If Bac_SQL_Fetch(Datos()) Then
          
          If Datos(1) = "1" Then
             
             bloqueado = True
             Exit Function
          
          End If
       
       End If
   
   End If

End Function


Function Encript(xClave As String, xEncriptar As Boolean) As String
Dim x As Single
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

For x = 1 To Len(xClave)
 
 If xEncriptar Then
    xPsw = xPsw + Chr((Asc(Mid(Codigos, InStr(1, Letras, Mid(xClave, x, 1)), 1)) - x))
 Else
    xPsw = xPsw + Mid(Letras, InStr(1, Codigos, Chr(Asc(Mid(xClave, x, 1)) + x)), 1)
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
Dim x As Single
BuscaEnCombo = -1

If xForma = "C" Then
For x = 0 To Combo.ListCount - 1
 If Val(Right(Combo.List(x), 5)) = Val(xcod) Then
    BuscaEnCombo = x
    Exit For
 End If
Next
ElseIf xForma = "G" Then
For x = 0 To Combo.ListCount - 1
 If Trim(Left(Combo.List(x), Len(Combo.List(x)) - 5)) = Trim(xcod) Then
    BuscaEnCombo = x
    Exit For
 End If
Next
End If
End Function



'insertado 20/12/2000
Function Llenar_Combos(xcombo As Object, xcategoriaTC As Double) As Boolean
Dim Cont As Single

    Llenar_Combos = False

    Cont = 0
    'xcategoriaTC = 180
    
'    Sql = "EXECUTE sp_tcleecodigos1 " & xcategoriaTC
    
    Envia = Array()
    
    AddParam Envia, xcategoriaTC
    
    If Not Bac_Sql_Execute("SP_TCLEECODIGOS1", Envia) Then Exit Function
    
    Do While Bac_SQL_Fetch(Datos())
        
        Cont = Cont + 1
        xcombo.AddItem Datos(2) + Space(40 + Len(Datos(2))) + Str(Datos(1))
    
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
Sub CellPintaCelda(Grilla As Control)
    Grilla.CellForeColor = &H800000
    Grilla.CellBackColor = &H8000000F
End Sub

Sub PintaCelda(Grilla As Control)
    Grilla.CellForeColor = 16777215
    Grilla.CellBackColor = &H80000002
End Sub


