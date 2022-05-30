VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "ClsTGenerales"
Attribute VB_Creatable = True
Attribute VB_Exposed = True
 'MDTB : TABLAS DE USO GENERAL O DEL SISTEMA
 '-----------------------------------------------
 Public tbcodtab   As Integer  'numeric  3,0
 Public tbglosa    As String
 Public tbpict     As String
 Public tbmant     As String

 Public tbOk       As Integer




Public Sub Eliminar()
Dim SQL As String

    SQL = SQL & "Delete    " & Chr(10)
    SQL = SQL & "  from    " & Chr(10)
    SQL = SQL & "MDTB      " & Chr(10)
    SQL = SQL & "  WHERE   " & Chr(10)
    SQL = SQL & "tbcodtab =" & tbcodtab
    
    If SM_Execute(SQL) <> 0 Then
       MsgBox "No Se peuede Eliminar registro de Tablas de uso General"
       Exit Sub
    End If
     
End Sub



Public Sub Grabar()
Dim SQL As String

    SQL = SQL & "SELECT       " & Chr(10)
    SQL = SQL & "  tbcodtab   " & Chr(10)
    SQL = SQL & "FROM         " & Chr(10)
    SQL = SQL & "  MDTB       " & Chr(10)
    SQL = SQL & "WHERE        " & Chr(10)
    SQL = SQL & "  tbcodtab = " & tbcodtab
    
    If SM_Execute(SQL) <> 0 Then
       MsgBox "No Se puede Conectar a tabla de uso general"
       Exit Sub
    End If
    
    SQL = ""
    ReDim Datos(1)
    If SM_Fetch(Datos()) = 0 Then
       'Actualizar Registro en Tablas Generales
       '---------------------------------------
       SQL = SQL & "UPDATE       " & Chr(10)
       SQL = SQL & "  MDTB       " & Chr(10)
       SQL = SQL & "SET          " & Chr(10)
       SQL = SQL & "  tbcodtab = " & tbcodtab & "," & Chr(10)
       SQL = SQL & "  tbglosa  ='" & tbglosa & "'," & Chr(10)
       SQL = SQL & "  tbpict   ='" & tbpict & "'," & Chr(10)
       SQL = SQL & "  tbmant   ='" & tbmant & "'" & Chr(10)
       SQL = SQL & "WHERE        " & Chr(10)
       SQL = SQL & "  tbcodtab = " & tbcodtab & Chr(10)
    Else
       'Insertar Registro E Tablas Generales
       '----------------------------------------
       SQL = SQL & "INSERT       " & Chr(10)
       SQL = SQL & "  INTO       " & Chr(10)
       SQL = SQL & "MDTB         " & Chr(10)
       SQL = SQL & "(            " & Chr(10)
       SQL = SQL & "tbcodtab ,   " & Chr(10)
       SQL = SQL & "tbglosa,     " & Chr(10)
       SQL = SQL & "tbpict,      " & Chr(10)
       SQL = SQL & "tbmant       " & Chr(10)
       SQL = SQL & ")            " & Chr(10)
       SQL = SQL & " VALUES      " & Chr(10)
       SQL = SQL & "(            " & Chr(10)
       SQL = SQL & tbcodtab & "," & Chr(10)
       SQL = SQL & "'" & tbglosa & "'," & Chr(10)
       SQL = SQL & "'" & tbpict & "'," & Chr(10)
       SQL = SQL & "'" & tbmant & "'" & Chr(10)
       SQL = SQL & ")             " & Chr(10)
    
    End If
    
    If SM_Execute(SQL) <> 0 Then
       MsgBox "No Se Pudo Grabar Registro en Tablas Generales"
       Exit Sub
    End If
    
End Sub

Public Sub Leer()
Dim SQL As String

    SQL = SQL & "SELECT       " & Chr(10)
    SQL = SQL & "  tbcodtab,  " & Chr(10)  '1
    SQL = SQL & "  tbglosa,   " & Chr(10)  '2
    SQL = SQL & "  tbpict,    " & Chr(10)  '3
    SQL = SQL & "  tbmant     " & Chr(10)  '4
    SQL = SQL & "FROM         " & Chr(10)
    SQL = SQL & " MDTB        " & Chr(10)
    SQL = SQL & "WHERE        " & Chr(10)
    SQL = SQL & "  tbcodtab = " & tbcodtab & Chr(10)
    
    If SM_Execute(SQL) <> 0 Then
       MsgBox "No Se puede conectar a Tabla de Uso General"
       Exit Sub
    End If
    
    ReDim Datos(4)
    If SM_Fetch(Datos()) = 0 Then
       tbcodtab = Datos(1)
       tbglosa = Datos(2)
       tbpict = Datos(3)
       tbmant = Datos(4)
    End If
    
End Sub



Public Sub Limpiar()

    tbcodtab = 0
    tbglosa = ""
    tbpict = ""
    tbmant = ""

End Sub

