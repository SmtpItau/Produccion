Attribute VB_Name = "GLB_REGISTRO"
Function FUNC_LEER_REGISTRO(Nombre_APP As String, Seccion As String, Llave As String) As String
'Autor    : Miguel Gajardo
'Fecha    : 31 de Julio de 2002
'Objetivo : Leer los parametros para el inicio del sistema del registro de windows

   FUNC_LEER_REGISTRO = ""
   
   FUNC_LEER_REGISTRO = FUNC_GetString(HKEY_CURRENT_USER, RUTA_REGISTRO & Seccion, Llave)

   'FUNC_LEER_REGISTRO = GetSetting(Nombre_APP, Seccion, Llave)

End Function
Public Function FUNC_GetString(Hkey As Long, sPath As String, sValue As String)
    Dim lkeyhand        As Long
    Dim ldatatype       As Long
    Dim lResult         As Long
    Dim sBuf            As String
    Dim lDataBufSize    As Long
    Dim iZeroPos        As Integer
    Dim lReturn         As Long
    Dim lValueType      As Long
    
    lReturn = RegOpenKey(Hkey, sPath, lkeyhand)
    
    lResult = RegQueryValueEx(lkeyhand, sValue, 0&, lValueType, ByVal 0&, lDataBufSize)
    If lValueType = REG_SZ Then
        sBuf = String(lDataBufSize, " ")
        lResult = RegQueryValueEx(lkeyhand, sValue, 0&, 0&, ByVal sBuf, lDataBufSize)
        If lResult = ERROR_SUCCESS Then
            iZeroPos = InStr(sBuf, Chr$(0))
            If iZeroPos > 0 Then
                FUNC_GetString = Left$(sBuf, iZeroPos - 1)
            Else
                FUNC_GetString = sBuf
            End If
        End If
    End If
End Function
Sub PROC_CENTRAR_FORMULARIO(oFormulario As Form, oFormPrincipal As Form)

   oFormulario.Left = (oFormPrincipal.Width / 2) - (oFormulario.Width / 2)
   oFormulario.Top = (oFormPrincipal.Height / 2) - (oFormulario.Height / 2)


End Sub
Sub PROC_GUARDAR_REGISTRO(Nombre_APP As String, Seccion As String, Llave As String, Valor As Variant)
'Autor    : Miguel Gajardo
'Fecha    : 31 de Julio de 2002
'Objetivo : Guardar los parametros para el inicio del sistema del registro de windows

   SaveSetting Nombre_APP, Seccion, Llave, Valor

End Sub

