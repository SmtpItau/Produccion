VERSION 1.0 CLASS
BEGIN
  MultiUse = 0   'False
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsDCarteras"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Public objDCartera As Object
Public coleccion As New Collection

Public Sub Coleccion2Control(objControl As Object)
Dim Filas   As Long
Dim IdGlosa As String * 40
Dim Max     As Long
          
    objControl.Clear
    Max = coleccion.Count
    
    For Filas = 1 To Max
        IdGlosa = coleccion(Filas).rcnombre
        objControl.AddItem IdGlosa
        objControl.ItemData(objControl.NewIndex) = coleccion(Filas).rcrut
    Next Filas
    
End Sub

Public Function LeerDCarteras(DcNombre As String) As Boolean
Dim Sql   As String
Dim IdRow As Integer
Dim Datos()

    LeerDCarteras = False
    Envia = Array()
    AddParam Envia, DcNombre
    
          
    If Not BAC_SQL_EXECUTE("SP_RCLEERNOMBRES", Envia) Then
       Exit Function
    
   
    End If
       
    'Elimino todos los miembros de la coleccion
    Call VaciarColeccion
    
    LeerDCarteras = True
 
End Function
Private Sub VaciarColeccion()
Dim Filas&, Max&
          
    Max& = coleccion.Count
    For Filas& = 1 To Max&
        coleccion.Remove 1
    Next Filas&
          
End Sub

Private Sub Class_Initialize()

    'Set objDCartera = New clsDCartera
    
End Sub


Private Sub Class_Terminate()

    Set objDCartera = Nothing
    
End Sub


