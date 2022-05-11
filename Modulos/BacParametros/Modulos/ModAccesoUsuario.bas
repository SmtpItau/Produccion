Attribute VB_Name = "ModAccesoUsuario"
'----------------------------------------------------------------------------------------------------------------------------------------
'
'OS             :
'NOMBRE         : ModAccesoUsuario.bas
'AUTOR          : Cristian Vega Sanhueza.
'DESCRIPCION    : Procedimientos y funciones para validación de usuario.
'FECHA CREACIÓN : 2017.06.05

'HISTÓRICO DE CAMBIOS
'FECHA             AUTOR                         OS               MODIFICACION                              TAG DE LA MODIFICACION
'----------------------------------------------------------------------------------------------------------------------------------------
'2017.06.05         CVS                                           Se inhabilita formulario Acceso Usuario   cvegasan 2017.06.05 HOM Ex-Itau
'
'


Option Explicit

Public Function Func_Valida_Login(sUser As String, Optional KeyAscii As Integer) As Boolean
    Func_Valida_Login = False

    If func_valida_usuario(sUser) = True Then
        Call SaveSetting("BAC", "SISTEMAS", "ActiveUser", Encript(sUser, True))
        Call Grabar_Log_AUDITORIA(1, _
                   gsbac_fecp, _
                   gsBac_IP, _
                   gsBAC_User, _
                   "PCA", _
                   "", _
                   "05", _
                   "Ingreso al Sistema", _
                   "", _
                   "", _
                   "")

        Func_Valida_Login = True
    End If
gsBAC_Login = Func_Valida_Login
Exit Function
ErrUNLOAD:
   If Err.Number = 364 Then
      End
   End If
End Function

Function func_valida_usuario(sUser As String) As Boolean
   Dim Datos()
   Dim SQL              As String
   Dim Password_Usuario As String

   func_valida_usuario = False
 
   Envia = Array()
   AddParam Envia, sUser
 
   If Not Bac_Sql_Execute("BacParamSuda.dbo.SP_VALIDA_INGRESO_USUARIO", Envia) Then
      Exit Function
   End If
   
   If Bac_SQL_Fetch(Datos()) Then
      If Datos(1) < 0 Then
        MsgBox Datos(2), vbExclamation, App.Title
        Exit Function
      End If
   End If

   Password_Usuario = Datos(1)
   gsBac_Tipo_Usuario = Datos(2)
   Fecha_Expira = Datos(3)
   nDiasClave = Datos(5)
   largo_clave = IIf(Datos(6) = 0, 8, Datos(6))
   nTipoClave = Datos(7)
   
   gsBAC_User$ = sUser
   gsUsuario = sUser
   func_valida_usuario = True

End Function
