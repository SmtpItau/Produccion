VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsClientes"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Public objCliente As Object
Public coleccion As New Collection

Public Sub VaciarColeccion()

   Dim Filas&, Max&

   Max& = coleccion.Count
   For Filas& = 1 To Max&
      coleccion.Remove 1

   Next Filas&

End Sub

Public Sub Coleccion2Control(objControl As Object)

   Dim Filas      As Long
   Dim IdGlosa    As String * 40
   Dim Max        As Long

   With objControl
      .Clear
      Max = coleccion.Count
      
      For Filas = 1 To Max
         IdGlosa = coleccion(Filas).clnombre
         .AddItem IdGlosa
         .ItemData(.NewIndex) = coleccion(Filas).clrut
         
      Next Filas

   End With

End Sub
'Consulta clientes ordenados alfabeticamente y llena una colección
Public Function LeerClientes(IdNombre As String) As Boolean

   Dim Sql           As String
   Dim IdRow         As Integer
   Dim objBuffer     As Object
   Dim Datos()
 
   LeerClientes = False
   Sql = "exec " & giSQL_DatabaseCommon & ".. sp_mdclpornombre "
   'SQL = "EXECUTE " & giSQL_DatabaseCommon & "..sp_mdclleernombre " & "'" & IdNombre & "'"
                          
   If SQL_Execute(Sql) <> 0 Then
      Exit Function

   End If

   Call VaciarColeccion

   Do While SQL_Fetch(Datos()) = 0

      Set objBuffer = New clsCliente

      With objBuffer
         .clrut = Val(Datos(1))
         .cldv = Datos(2)
         .clcodigo = Val(Datos(3))
         .clnombre = Datos(4)
         .clgeneric = Datos(5)
         .cldirecc = Datos(6)
         '.clcomuna = Val(Datos(7))
         '.clregion = Val(Datos(8))
         '.cltipcli = Val(Datos(10))
         '.clfecingr = Datos(11)
         '.clctacte = Datos(12)
         '.clfono = Datos(13)
         '.clfax = Datos(14)

      End With

      coleccion.Add objBuffer

      Set objBuffer = Nothing

   Loop
   
   LeerClientes = True

End Function
Public Function LeerOperadoresCliente(codcli) As Boolean

   Dim Sql           As String
   Dim IdRow         As Integer
   Dim objBuffer     As Object
   Dim Datos()
 
   LeerOperadoresCliente = False
   
   Sql = "EXECUTE " & giSQL_DatabaseCommon & ".."
   Sql = Sql & "sp_Leer_Operador 0,0," & codcli
                          
   If SQL_Execute(Sql) <> 0 Then
      Exit Function

   End If

   Call VaciarColeccion

   Do While SQL_Fetch(Datos()) = 0

      Set objBuffer = New clsCliente

      With objBuffer
         .clrut = Val(Datos(1))
         .cldv = Datos(2)
         .clnombre = Datos(3)

      End With

      coleccion.Add objBuffer

      Set objBuffer = Nothing

   Loop
   
  LeerOperadoresCliente = True

End Function
Public Function LeerApoderadosCliente(RutCli) As Boolean

   Dim Sql           As String
   Dim IdRow         As Integer
   Dim objBuffer     As Object
   Dim Datos()
 
   LeerApoderadosCliente = False
   'EN LA TABLA DE DONDE SACA LOS APODERADOS EL RUT DEL CLIENTES ES NUMERICO!!!
   
   Sql = "EXECUTE " & giSQL_DatabaseCommon & "..sp_apodclientes " _
            & RutCli _
            & ",'" & Sistema & "'"
            
   If SQL_Execute(Sql) <> 0 Then
      Exit Function

   End If

   Call VaciarColeccion

   Do While SQL_Fetch(Datos()) = 0

      Set objBuffer = New clsCliente

      With objBuffer
         .clrut = Val(Datos(3))
         .cldv = Datos(4)
         .clnombre = Datos(5)
         .clgeneric = Datos(1) & "-" & Datos(2)   ' se guardara rut cliente

      End With

      coleccion.Add objBuffer

      Set objBuffer = Nothing

   Loop
   
  LeerApoderadosCliente = True

End Function
Private Sub Class_Initialize()

   Set objCliente = New clsCliente
    
End Sub

Private Sub Class_Terminate()

   Set objCliente = Nothing
    
End Sub

