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

Public ObjAyudaCliente As Object
Dim ObjCliente      As Object
Public coleccion As New Collection

Public Function BuscarColeccion(ByVal oPuntero As Long, ByRef Rut As Variant, ByRef Codigo As Variant, ByRef Dv As Variant, ByRef NOMBRE As Variant)
    Dim nFila   As Long

    If oPuntero = 0 Then
           Rut = 0
        Codigo = 0
        NOMBRE = ""
            Dv = ""
        Exit Function
    End If
    
'    Rut = coleccion.Item(oPuntero).clrut
'    Codigo = coleccion.Item(oPuntero).clcodigo
'    NOMBRE = coleccion.Item(oPuntero).clnombre
'    Dv = coleccion.Item(oPuntero).cldv
     gsrut$ = coleccion.Item(oPuntero).clrut
     gsvalor$ = coleccion.Item(oPuntero).clcodigo
        
End Function

Public Function LeerClientes(ByVal IdNombre As String, ByRef MiObjeto As Object, ByRef MiObjeto2 As Object) As Boolean
    Dim IdRow           As Integer
    Dim objBuffer       As Object
    Dim nIdPuntero      As Long
    Dim Datos()
     
    LeerClientes = False
    Envia = Array()
    AddParam Envia, "" '->Mercado
    If Not Bac_Sql_Execute("bacparamsuda..SP_MDCLEERCLIENTE", Envia) Then
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

