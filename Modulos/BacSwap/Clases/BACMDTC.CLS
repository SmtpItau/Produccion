VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsCodigo"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Public codigo    As Integer
Public glosa     As String


Public Function grabar(CodTab As Integer) As Boolean

Dim Fila As Long
Dim SQL  As String
    
    grabar = False
    
    SQL = "EXEC sp_TcGrabar1  " & Chr(10)
    SQL = SQL & CodTab & "," & Chr(10)
    SQL = SQL & codigo & "," & Chr(10)
    SQL = SQL & "'" & glosa & "'"
    
    If SQL_Execute(SQL) <> 0 Then
        Exit Function
    End If
    
'    Call Limpiar
    
    grabar = True

End Function
Public Function Leer(ByVal cCodTab As Integer, cCodigo As String) As Boolean

'Lee un Item de una Tabla, devolviendo la Glosa

Dim SQL   As String
Dim Datos()

    Leer = False
    SQL = "EXEC sp_TcLeeItem1 " & cCodTab
    SQL = SQL & ",'" & cCodigo & "'"
    
    If SQL_Execute(SQL) <> 0 Then
        Exit Function
    End If
     
    Call limpiar
              
    If SQL_Fetch(Datos()) = 0 Then
        codigo = Val(Datos(1))
        glosa = Trim$(Datos(2))
    End If
    
    Leer = True
           
End Function

Private Sub limpiar()

    codigo = 0
    glosa = ""

End Sub


