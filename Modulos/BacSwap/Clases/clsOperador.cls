VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsOperador"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'MDOP : TABLA DE OPERADORES
'-----------------------------------------------
Public opcodigo   As Long
Public opdigito   As String
Public opnombre   As String


Public Sub Limpiar()

  opcodigo = 0
  opnombre = ""
  opdigito = ""

End Sub

Public Function LeerPorCodigo(CodigoOp As Long) As Boolean

   Dim Sql           As String
   Dim Datos()

   LeerPorCodigo = False
    
   Sql = "exec sp_OpLeerCodigo1 "
   Sql = Sql & CodigoOp
          
   If SQL_Execute(Sql) > 0 Then
      Exit Function

   End If

   Call Limpiar

   If SQL_Fetch(Datos()) = 0 Then
      opcodigo = Val(Datos(1))
      opnombre = Datos(2)

   End If

   LeerPorCodigo = True

End Function

Public Function grabar(opcion As Integer) As Boolean

   Dim Sql As String

   grabar = False

   Sql = "exec sp_opgrabar1 " & vbCrLf
   Sql = Sql & opcodigo & "," & vbCrLf
   Sql = Sql & "'" & opnombre & "'" & "," & opcion & vbCrLf

   If SQL_Execute(Sql) > 0 Then
      Exit Function

   End If

   Call Limpiar

   grabar = True

End Function

Public Function Eliminar(CodigoOp As Long) As Boolean

   Dim Sql As String

   Eliminar = False

   Sql = "execute sp_opeliminar1 " & CodigoOp

   If SQL_Execute(Sql) > 0 Then
      Exit Function

   End If

   Call Limpiar

   Eliminar = True
    
End Function

Private Sub Class_Initialize()

   Call Limpiar
    
End Sub

