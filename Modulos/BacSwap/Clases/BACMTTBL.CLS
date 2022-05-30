VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "clscodtab"
Attribute VB_Creatable = True
Attribute VB_Exposed = True
Option Explicit

Public codigo As Integer
Public Glosa As String

'Public tipman As String
Public Function grabar(CodTab As Integer) As Boolean

   Dim Fila       As Long
   Dim Sql        As String
    
   grabar = False
    
   Sql = "EXECUTE sp_mdtcgrabar  " & Chr(10)
   Sql = Sql & CodTab & "," & Chr(10)
   Sql = Sql & codigo & "," & Chr(10)
   Sql = Sql & "'" & Glosa & "'"
    
   If SQL_Execute(Sql) > 0 Then
      Exit Function
   
   End If
    
   grabar = True

End Function

