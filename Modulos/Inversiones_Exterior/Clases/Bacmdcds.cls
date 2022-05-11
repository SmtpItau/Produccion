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
Public Coleccion As New Collection

Public Sub Coleccion2Control(objControl As Object)
Dim FILAS   As Long
Dim IDGLOSA As String * 40
Dim Max     As Long
          
    objControl.Clear
    Max = Coleccion.Count
    
    For FILAS = 1 To Max
        IDGLOSA = Coleccion(FILAS).rcnombre
        objControl.AddItem IDGLOSA
        objControl.ItemData(objControl.NewIndex) = Coleccion(FILAS).rcrut
    Next FILAS
    
End Sub

Public Function LeerDCarteras(DcNombre As String) As Boolean
Dim IdRow As Integer
Dim DATOS()

    LeerDCarteras = False

    envia = Array(DcNombre)
          
'    If Not Bac_Sql_Execute("SP_RCLEERNOMBRES", envia) Then
'        Exit Function
'    End If
'
'    Call VaciarColeccion
'
'    Do While Bac_SQL_Fetch(DATOS())
'        Dim objBuf  As New clsDCarteras
'        With objBuf
'            .rccodcar = Val(DATOS(1))
'            .rcrut = Val(DATOS(2))
'            .rcdv = DATOS(3)
'            .rcnombre = DATOS(4)
'            .rcnumoper = Val(DATOS(5))
'            .rctelefono = DATOS(6)
'            .rcfax = DATOS(7)
'            .rcdirecc = DATOS(8)
'        End With
'        Coleccion.Add objBuf
'        Set objBuf = Nothing
'    Loop

    LeerDCarteras = True
 
End Function
Private Sub VaciarColeccion()
Dim FILAS&, Max&
          
    Max& = Coleccion.Count
    For FILAS& = 1 To Max&
        Coleccion.Remove 1
    Next FILAS&
          
End Sub

Private Sub Class_Initialize()

    'Set objDCartera = New clsDCartera
    
End Sub


Private Sub Class_Terminate()

    Set objDCartera = Nothing
    
End Sub


