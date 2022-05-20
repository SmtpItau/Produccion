Attribute VB_Name = "MOD_LLAMADOS_SQL"
Option Explicit
Global Const FEFecha = "yyyymmdd"

Function FUNC_EXECUTA_COMANDO_SQL(cProcedimiento As String, Optional vArreglo As Variant) As Boolean

On Error GoTo ErrEjecuta
 
 FUNC_EXECUTA_COMANDO_SQL = False
 
   Dim nContador     As Integer
   Dim nSubContador  As Integer
   Dim nComa         As Integer
   Dim cSql          As String

   cSql = cProcedimiento

   Pbl_Punto_Decimal = Mid$(Format(0#, "0.0"), 2, 1)

   If IsMissing(vArreglo) Then
      nSubContador = -1
   Else
      nSubContador = UBound(vArreglo)
   End If

   For nContador = 0 To nSubContador
   
      If TypeName(vArreglo(nContador)) = "String" Then
      
         If IsDate(vArreglo(nContador)) Then
         
            cSql = cSql & " '" & Format(vArreglo(nContador), GLB_FORMATO_FECHA_REGIONAL) & "',"
            
         Else
         
            If InStr(1, vArreglo(nContador), "'") > 0 Then
            
               If Len(vArreglo(nContador)) <= 128 Then
              
                  ''cSql = cSql & " [" & vArreglo(nContador) & "],"
                  cSql = cSql & vArreglo(nContador) & ","
               
               Else
               
                  vArreglo(nContador) = Replace(vArreglo(nContador), "'", "^")
                  cSql = cSql & " '" & vArreglo(nContador) & "',"
                  
               End If
               
            Else
            
               cSql = cSql & " '" & vArreglo(nContador) & "',"
            
            End If
         
         End If
         
      ElseIf TypeName(vArreglo(nContador)) = "Date" Then
      
         cSql = cSql & " '" & Format(vArreglo(nContador), FEFecha) & "',"
         
      Else
      
         If Pbl_Punto_Decimal = "," Then
         
            nComa = InStr(1, vArreglo(nContador), ",")
            If nComa > 0 Then
            
                vArreglo(nContador) = Mid(vArreglo(nContador), 1, nComa - 1) & "." & Mid(vArreglo(nContador), nComa + 1)
            
            End If
         
         End If
         
         cSql = cSql & " " & vArreglo(nContador) & ","
      
      End If
   
   Next nContador

   If nSubContador > -1 Then
      
      cSql = Mid(cSql, 1, Len(cSql) - 1)
   
   End If

   GLB_VerSql = cSql
   
   GLB_Sql_Resultado.Open GLB_VerSql, GLB_Sql_Conexion, adOpenForwardOnly, adLockReadOnly
   
   FUNC_EXECUTA_COMANDO_SQL = True

 Exit Function
   
ErrEjecuta:
    
    If Err.Number = 3705 Then
       
       GLB_Sql_Resultado.Close
       Resume
    
    End If
    
    If Err.Number = -2147217900 Then ' Para Formulas y Valorización
    
       Exit Function
    
    End If
    
    
    If Err.Number = -2147467259 Then
       
       Resume
    
    End If
    
     Clipboard.Clear
     Clipboard.SetText GLB_VerSql
     
     MsgBox "Se ha producido un error al ejecutar " & cProcedimiento & Chr(10) & Chr(10) & _
            Err.Description, vbOKOnly + vbExclamation
     
     Exit Function

End Function

Function FUNC_LEE_RETORNO_SQL(ByRef vArreglo As Variant) As Boolean

On Error GoTo ErrFetch
   
   Dim nContador        As Integer
   Dim nSubContador     As Integer
   Dim nComa            As Integer
   Dim vValor_Variable  As Variant

   FUNC_LEE_RETORNO_SQL = False
  
   If Not FUNC_EXISTEN_DATOS Then
       
       Exit Function
   
   End If
   
   If GLB_Sql_Resultado.EOF Then
      
      Exit Function
   
   End If
   
      nSubContador = GLB_Sql_Resultado.Fields.Count
      ReDim vArreglo(1 To nSubContador)
      
      For nContador = 1 To nSubContador
         
         vValor_Variable = Trim(GLB_Sql_Resultado.Fields(nContador - 1))
         
         If IsNumeric(vValor_Variable) Then
            
            If Pbl_Punto_Decimal = "." Then
               nComa = InStr(1, vValor_Variable, ",")
               
               If nComa > 0 Then
                   
                   vValor_Variable = Mid(vValor_Variable, 1, nComa - 1) & "." & Mid(vValor_Variable, nComa + 1)
               
               End If
            
            End If
         
         ElseIf IsDate(vValor_Variable) Then
            
            vArreglo(nContador) = IIf(IsNull(vValor_Variable), "", Format(vValor_Variable, "DD/MM/YYYY"))
         
         End If
         
         vArreglo(nContador) = IIf(IsNull(vValor_Variable), "", vValor_Variable)
      
      Next

       GLB_Sql_Resultado.MoveNext
 
  
   FUNC_LEE_RETORNO_SQL = True

Exit Function

ErrFetch:
    
    If Err.Number = 3705 Then
       
       GLB_Sql_Resultado.Close
       Resume
    
    End If
     
     MsgBox "Se ha producido un error al ejecutar :" & Chr(10) & Chr(10) & _
            Err.Description, vbOKOnly + vbExclamation
     
     Exit Function
    
End Function

Function FUNC_EXISTEN_DATOS() As Boolean

 On Error GoTo ErrDatos
  
   FUNC_EXISTEN_DATOS = False

  If GLB_Sql_Resultado.RecordCount = 0 Then
  
      Exit Function
      
  End If

   FUNC_EXISTEN_DATOS = True

 Exit Function

ErrDatos:
   
   If Err.Number <> 3704 Then
     
     MsgBox "Error al recuperar datos desde Sql :" & Chr(10) & Chr(10) & Err.Description, vbOKOnly + vbExclamation
   
   End If
     
     Exit Function

End Function

Sub PROC_NOMBRE_USUARIO_TERMINAL()

   Dim nTamaño As Long
   
   GLB_Nombre_Uusario = Space$(260)
   nTamaño = Len(GLB_Nombre_Uusario)
   GLB_Usuario_Bac = UCase(Environ("USERNAME"))
    
   GLB_Nombre_Computador = Space$(260)
   nTamaño = Len(GLB_Nombre_Computador)
   GLB_Terminal_Bac = UCase(Environ("COMPUTERNAME"))
    
End Sub

Public Sub AddParam(ByRef Arreglo As Variant, Parametro As Variant)
Dim Cuenta As Integer
   On Error GoTo Errorcuenta:
   
   Cuenta = UBound(Arreglo) + 1
   ReDim Preserve Arreglo(Cuenta)
   Arreglo(Cuenta) = Parametro
   
   Exit Sub

Errorcuenta:
   
   Cuenta = 0
   Resume Next

End Sub

