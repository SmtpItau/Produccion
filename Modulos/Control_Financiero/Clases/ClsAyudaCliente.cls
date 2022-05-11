VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "ClsAyudaCliente"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit
Public ObjCliente As Object
Public ObjAyudaCliente As Object
Public coleccion As New Collection

Public Function BuscarColeccion(ByVal oPuntero As Long, ByRef Rut As Variant, ByRef Codigo As Variant, ByRef Dv As Variant, ByRef Nombre As Variant)
    Dim nFila   As Long

    If oPuntero = 0 Then
           Rut = 0
        Codigo = 0
        Nombre = ""
            Dv = ""
        Exit Function
    End If
       Rut = coleccion.Item(oPuntero).clrut
       Codigo = coleccion.Item(oPuntero).clcodigo
       Nombre = coleccion.Item(oPuntero).clnombre
       Dv = coleccion.Item(oPuntero).cldv
       RetornoAyuda = coleccion.Item(oPuntero).clrut
       RetornoAyuda2 = coleccion.Item(oPuntero).clcodigo
       RetornoAyuda3 = coleccion.Item(oPuntero).clnombre
End Function

Public Function LeerClientes(ByVal IdNombre As String, ByRef MiObjeto As Object, ByRef MiObjeto2 As Object) As Boolean
    Dim IdRow           As Integer
    Dim objBuffer       As Object
    Dim nIdPuntero      As Long
    Dim Datos()
    Dim CLIENTE As String
     
    LeerClientes = False

    If Not Bac_Sql_Execute("BacParamSuda..SP_MDCLEERCLIENTE") Then
        Exit Function
    End If
    
    Call VaciarColeccion

    Let nIdPuntero = 1

    Do While Bac_SQL_Fetch(Datos())
        Set objBuffer = New clsCliente
           objBuffer.clrut = Datos(1)
            objBuffer.cldv = Datos(2)
        objBuffer.clcodigo = Datos(3)
        objBuffer.clnombre = Datos(4)
        objBuffer.clcodcli = nIdPuntero

        MiObjeto.AddItem Space(9 - Len(Trim(Datos(1)))) & " " & Trim(Datos(1)) & " - " & Datos(3) & Space(4) & Datos(4)
        MiObjeto.ItemData(MiObjeto.NewIndex) = nIdPuntero

        MiObjeto2.AddItem Space(9 - Len(Trim(Datos(1)))) & " " & Trim(Datos(1)) & " - " & Datos(3) & Space(4) & Datos(4)
        MiObjeto2.ItemData(MiObjeto2.NewIndex) = nIdPuntero

        coleccion.Add objBuffer

        Let nIdPuntero = nIdPuntero + 1

        Set objBuffer = Nothing
    Loop
   
    LeerClientes = True
End Function
'Arm
Public Function LeerClientes_Inst(ByVal IdNombre As String, ByRef MiObjeto As Object, ByRef MiObjeto2 As Object) As Boolean
    Dim IdRow           As Integer
    Dim objBuffer       As Object
    Dim nIdPuntero      As Long
    Dim Datos()
    Dim CLIENTE As String
    Envia = Array()
    LeerClientes_Inst = False

    AddParam Envia, BacAyudaCliente.TipoCliente
    AddParam Envia, gsBAC_User
    If Not Bac_Sql_Execute("SP_AYUDA_LEE_CLIENTES", Envia) Then
       Exit Function
    End If
    
    Call VaciarColeccion

    Let nIdPuntero = 1

    Do While Bac_SQL_Fetch(Datos())
        Set objBuffer = New clsCliente
           objBuffer.clrut = Datos(4)
            objBuffer.cldv = Datos(5)
        objBuffer.clcodigo = Datos(2)
        objBuffer.clnombre = Datos(3)
        objBuffer.clcodcli = nIdPuntero

        MiObjeto.AddItem Space(9 - Len(Trim(Datos(4)))) & " " & Trim(Datos(4)) & " - " & Datos(2) & Space(4) & Datos(3)
        MiObjeto.ItemData(MiObjeto.NewIndex) = nIdPuntero

        MiObjeto2.AddItem Space(9 - Len(Trim(Left(Datos(4), 8)))) & " " & Trim(Datos(4)) & " - " & Datos(3) & Space(2) & Datos(3)
        MiObjeto2.ItemData(MiObjeto2.NewIndex) = nIdPuntero

        coleccion.Add objBuffer

        Let nIdPuntero = nIdPuntero + 1

        Set objBuffer = Nothing
    Loop
   
    LeerClientes_Inst = True
End Function
'ARM
Private Sub Class_Initialize()
    Set ObjCliente = New clsCliente
End Sub

Private Sub Class_Terminate()
    Set ObjCliente = Nothing
End Sub


Public Sub VaciarColeccion()
   Dim Filas&, Max&

   Max& = coleccion.Count
   For Filas& = 1 To Max&
      coleccion.Remove 1
   Next Filas&

End Sub

