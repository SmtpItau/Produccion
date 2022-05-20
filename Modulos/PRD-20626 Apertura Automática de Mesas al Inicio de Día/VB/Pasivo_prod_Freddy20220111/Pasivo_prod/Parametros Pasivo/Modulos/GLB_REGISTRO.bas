Attribute VB_Name = "GLB_REGISTRO"
'---- LEER INI

Declare Function RegOpenKey Lib "advapi32.dll" Alias "RegOpenKeyA" (ByVal Hkey As Long, ByVal lpSubKey As String, phkResult As Long) As Long
Declare Function RegQueryValueEx Lib "advapi32.dll" Alias "RegQueryValueExA" (ByVal Hkey As Long, ByVal lpValueName As String, ByVal lpReserved As Long, lpType As Long, lpData As Any, lpcbData As Long) As Long
Declare Function RegCreateKey Lib "advapi32.dll" Alias "RegCreateKeyA" (ByVal Hkey As Long, ByVal lpSubKey As String, phkResult As Long) As Long
Declare Function RegSetValueEx Lib "advapi32.dll" Alias "RegSetValueExA" (ByVal Hkey As Long, ByVal lpValueName As String, ByVal Reserved As Long, ByVal dwType As Long, lpData As Any, ByVal cbData As Long) As Long
Declare Function RegCloseKey Lib "advapi32.dll" (ByVal Hkey As Long) As Long

Public Const HKEY_CLASSES_ROOT = &H80000000
Public Const HKEY_CURRENT_USER = &H80000001
Public Const HKEY_LOCAL_MACHINE = &H80000002
Public Const HKEY_USERS = &H80000003
Public Const HKEY_PERFORMANCE_DATA = &H80000004
Public Const REG_SZ = 1
Public Const ERROR_SUCCESS = 0&
Public Const RUTA_REGISTRO = "Software\BAC\Trader\"

Public Sub PROC_SaveString(Hkey As Long, sPath As String, sValue As String, sData As String)
    Dim lkeyhand As Long
    Dim lReturn  As Long
    lReturn = RegCreateKey(Hkey, sPath, lkeyhand)
    lReturn = RegSetValueEx(lkeyhand, sValue, 0, REG_SZ, ByVal sData, Len(sData))
    lReturn = RegCloseKey(lkeyhand)
End Sub



Function FUNC_LEER_REGISTRO(Nombre_APP As String, Seccion As String, Llave As String) As String
'Autor    : Miguel Gajardo
'Fecha    : 31 de Julio de 2002
'Objetivo : Leer los parametros para el inicio del sistema del registro de windows

   FUNC_LEER_REGISTRO = ""
   FUNC_LEER_REGISTRO = FUNC_GetString(HKEY_CURRENT_USER, RUTA_REGISTRO & Seccion, Llave)

'   FUNC_LEER_REGISTRO = GetSetting(Nombre_APP, Seccion, Llave)

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

Sub PROC_GUARDAR_REGISTRO(Nombre_APP As String, Seccion As String, Llave As String, Valor As String)
'Autor    : Miguel Gajardo
'Fecha    : 31 de Julio de 2002
'Objetivo : Guardar los parametros para el inicio del sistema del registro de windows

'   SaveSetting Nombre_APP, Seccion, Llave, Valor
 Call PROC_SaveString(HKEY_CURRENT_USER, RUTA_REGISTRO + Seccion, Llave, Valor)

End Sub

