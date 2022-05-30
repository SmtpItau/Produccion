VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "clsCarter"
Attribute VB_Creatable = False
Attribute VB_Exposed = False
Option Explicit

'MFCR : TABLA DE CARTERAS
'-----------------------------------------------

Public rut As Long
Public dig As String
Public nombre As String
Public Function LeerPorRut() As Boolean

   Dim Sql           As String
   Dim Datos()

   LeerPorRut = False

   Sql = "execute sp_crleerporrut1 "
   Sql = Sql & rut & "," & "'" & dig & "'"
          
   If SQL_Execute(Sql) <> 0 Then
      Exit Function

   End If

   Call Limpiar

   If SQL_Fetch(Datos()) = 0 Then
      rut = Val(Datos(1))
      dig = Datos(2)
      nombre = Datos(3)

   End If

   LeerPorRut = True

End Function

Public Function Grabar(opcion As Integer) As Boolean

   Dim Sql As String

   Grabar = False

   Sql = "Exec Sp_crGrabar1 " & vbCrLf
   Sql = Sql & rut & "," & vbCrLf
   Sql = Sql & "'" & dig & "'," & vbCrLf
   Sql = Sql & "'" & nombre & "'," & vbCrLf
   Sql = Sql & opcion & vbCrLf
    
   If SQL_Execute(Sql) <> 0 Then
      Exit Function

   End If

   Call Limpiar

   Grabar = True

End Function

Private Sub Class_Initialize()

   Call Limpiar

End Sub

Public Sub Limpiar()

   rut = 0
   dig = ""
   nombre = ""

End Sub

Public Function Eliminar() As Boolean
   Dim Sql As String

   Eliminar = False

   Sql = "execute sp_creliminar1 " & rut & "," & "'" & dig & "'" & Chr(10)

   If SQL_Execute(Sql) <> 0 Then
      Exit Function

   End If

   Call Limpiar

   Eliminar = True

End Function
