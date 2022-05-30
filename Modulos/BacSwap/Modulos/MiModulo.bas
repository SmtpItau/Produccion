Attribute VB_Name = "MiModulo"
Option Explicit

Dim AHORA      As Integer
Dim pl(2)      As Integer
Dim intentos   As Integer

Public Function Func_Valida_Ingreso(sUsuario As String, sPassword As String) As Boolean

   Func_Valida_Ingreso = False

   If Bloqueado(sUsuario) Then
      Call Grabar_Log(gsBAC_Version, sUsuario, gsc_Parametros.fechaproc, "No pudo entrar al sistema: usuario bloqueado")
      MsgBox "Usuario esta Bloqueado", vbOKOnly + vbExclamation
      End

   End If

   If Func_Valida_Usuario(sUsuario, sPassword) Then
      If Not Expira(Fecha_Expira) Then
         If Not Bloquea_Usuario(True, sUsuario) Then
            Call Grabar_Log(gsBAC_Version, sUsuario, gsc_Parametros.fechaproc, "Entrada al Sistema sin problemas")
            On Error GoTo 0
            'Unload Me
            Exit Function

         End If

      Else
         If Trim(sUsuario) <> "ADMINISTRA" Then
            If (MsgBox("La password ha expirado " & Chr(10) & "¿ Desea Cambiarla ?", vbYesNo + vbQuestion)) = vbYes Then
               Cambio_Password.Tag = "X"
               Cambio_Password.Show vbModal

               If Bloquea_Usuario(True, sUsuario) Then
                  Call Grabar_Log(gsBAC_Version, sUsuario, gsc_Parametros.fechaproc, "Entrada al Sistema sin problemas : cambio de password")
                  On Error GoTo 0
                  'Unload Me
                  Exit Function

               End If

            Else
               End

            End If

         Else
            On Error GoTo 0
            'Unload Me
            Exit Function

         End If

      End If

   Else
      intentos = intentos + 1

   End If

   If intentos > 2 Then
      If Bloquea_Usuario(True, sUsuario) And Trim(sUsuario) <> "ADMINISTRA" Then
         Call Grabar_Log(gsBAC_Version, sUsuario, gsc_Parametros.fechaproc, "Usuario ha sido bloqueado")
         MsgBox "Usuario ha sido Bloqueado", vbOKOnly + vbCritical

      End If

      On Error GoTo 0
      'Unload Me
      Exit Function

   End If

End Function

Public Function Func_Valida_Usuario(sUsuario As String, sPassword As String) As Boolean

   Dim Password_Usuario    As String
   Dim Sql                 As String
   Dim Datos()

   Screen.MousePointer = vbHourglass

   Func_Valida_Usuario = False

   If giSQL_ConnectionMode <> 3 Then
      gsBAC_User$ = ""
      gsBAC_Pass$ = ""
   End If

    Envia = Array()
    AddParam Envia, sUsuario
    
    If Not Bac_Sql_Execute("SP_VALIDA_INGRESO_USUARIO", Envia) Then
       Screen.MousePointer = 0
       MsgBox "Usuario NO Existe.", vbCritical
       Exit Function
    End If
    If Not Bac_SQL_Fetch(Datos) Then
       Screen.MousePointer = 0
       MsgBox "Usuario NO Existe.", vbCritical
       Exit Function
    Else
       Password_Usuario = Datos(1)
       gsBac_Tipo_Usuario = Datos(2)
       Fecha_Expira = Format(Datos(3), "dd/mm/yyyy")
       nDiasClave = DATOS(5) '-->cs req.4146
       Largo_Clave = IIf(DATOS(6) = 0, 8, DATOS(6))
       nTipoClave = DATOS(7)
    End If

   If giSQL_ConnectionMode <> 3 Then
      If Trim(Password_Usuario) <> Encript(Trim(sPassword), True) Then
         Screen.MousePointer = 0
         MsgBox "Clave Invalida." & Chr(10) & Chr(10) & "Verifique la tecla [Bloq Mayús].", vbExclamation
         Exit Function
      End If

   End If

   Screen.MousePointer = vbDefault

   gsBAC_User$ = sUsuario
   gsBAC_Pass$ = sPassword
   gsBAC_Login = True

   Func_Valida_Usuario = True

End Function

Public Function Bloqueado(xUsuario As String) As Boolean
   Bloqueado = False
   If Bac_Sql_Execute("SP_TRAEBLOQUEO_USUARIO", Array(xUsuario)) Then
       If Bac_SQL_Fetch(DATOS()) Then
         If DATOS(1) = "1" Then
            Bloqueado = True
            Exit Function
         End If
      End If
   End If
End Function
 Public Function BAC_Login(sUser$, sPWD$) As Boolean
   
'      BAC_Login = False
'
'      If giSQL_ConnectionMode = 1 Then
'         SQL_Setup gsSQL_Server$, gsSQL_Login$, gsSQL_Password$, gsSQL_Database, gsBac_User, gsBac_Term, giSQL_LoginTimeOut, giSQL_QueryTimeOut
'      Else
'         SQL_Setup gsSQL_Server$, sUser$, sPWD$, gsSQL_Database, gsBac_User, gsBac_Term, giSQL_LoginTimeOut, giSQL_QueryTimeOut
'      End If
'
'      If miSQL.SQL_Coneccion() = False Then
'         Exit Function
'      End If
'
'      BAC_Login = True
 
   BAC_Login = False
'+++cvegasan 2017.06.05 HOM Ex-Itau
   If giSQL_ConnectionMode = 3 Then
        gsBAC_User = UCase(Trim(Environ("username")))
        gsBAC_Term = Trim(Environ("userdomain"))
        MISQL.Login = gsBAC_User
   End If
'---cvegasan 2017.06.05 HOM Ex-Itau
   MISQL.ServerName = gsSQL_Server$
   MISQL.HostName = gsBAC_Term
   MISQL.Application = "SWAP"
   MISQL.ConnectionMode = giSQL_ConnectionMode
   MISQL.DatabaseName = gsSQL_Database
   gsBAC_IP = BACSwap.NomObjWinIP.LocalIP
 
   If giSQL_ConnectionMode = 1 Then
      MISQL.Login = gsSQL_Login$
      MISQL.Password = gsSQL_Password$
        gsBAC_User = UCase(Trim(Environ("username")))
        gsBAC_Term = Trim(Environ("ComputerName"))
   ElseIf giSQL_ConnectionMode = 2 Then
      MISQL.Login = sUser$
      MISQL.Password = sPWD$
 
   End If
 
'   If giSQL_ConnectionMode = 1 Then
'      MISQL.Login = gsSQL_Login$
'      MISQL.Password = gsSQL_Password$
'
'   ElseIf giSQL_ConnectionMode = 2 Then
'      MISQL.Login = sUser$
'      MISQL.Password = sPWD$
'
'   End If
 
   MISQL.LoginTimeout = giSQL_LoginTimeOut
   MISQL.QueryTimeout = giSQL_QueryTimeOut
 
   If MISQL.SQL_Coneccion() = False Then
       BAC_Login = False
       Exit Function
 
   End If
   
'   'CONECCION AS400
'   miSQLAS400.ServerName = gsSQL_ServerAS400
'   If miSQLAS400.SQLAS400_Coneccion() = False Then
'       BAC_Login = False
'       MsgBox "Problemas Conección AS400", vbCritical, TITSISTEMA
'       Exit Function
'
'   End If
 
    BAC_Login = True
 
 
End Function
'Objetivo : Bloquear usuarios en tablas FOX y en SQL
'Autor     : Miguel Gajardo
'Fecha    : 18/02/2000
Function Bloquea_Usuario(xBloquea As Boolean, xUsuario As String) As Boolean

   Bloquea_Usuario = False
'   Sql = "Sp_Bloquea_Gen_Usuario "
'   Sql = Sql & "'" & xUsuario & "','"
'   Sql = Sql & IIf(xBloquea, 1, 0) & "'"
'   If MISQL.SQL_Execute(Sql) = 0 Then
      
   Envia = Array()
   AddParam Envia, xUsuario
   AddParam Envia, CDbl(IIf(xBloquea, 1, 0))
      
'   Do While MISQL.SQL_Fetch(DATOS()) = 0
   If Bac_Sql_Execute("SP_BLOQUEA_GEN_USUARIO", Envia) Then
      Do While Bac_SQL_Fetch(Datos())
        
      Loop

   Else
      Exit Function
    
   End If

   Bloquea_Usuario = True

End Function

Sub Grabar_Log(xSistema As String, xUsuario As String, xFechaProc As Date, xEvento As String)

         
'   Envia = Array()
'   AddParam Envia, xUsuario
'   AddParam Envia, Format(xFechaProc, "yyyymmdd")
'   AddParam Envia, xEvento
'
'   If Bac_Sql_Execute("Sp_Grabar_Log", Envia) Then
'      If Bac_SQL_Fetch(Datos()) Then
'
'         If Datos(1) = "NO" Then
'            MsgBox "Problemas al grabar log", vbOKOnly + vbExclamation
'
'         End If
'
'      End If
'
'   End If

End Sub

