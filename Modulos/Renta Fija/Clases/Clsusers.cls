VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "ClsUsuarios"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Public objUser     As Object
Public Coleccion As New Collection

Public Sub VaciarColeccion()
Dim FILAS&, Max&
          
    Max& = Coleccion.Count
    For FILAS& = 1 To Max&
        Coleccion.Remove 1
    Next FILAS&
          
End Sub

Public Function LeerUsuarios() As Boolean
Dim Datos()
    LeerUsuarios = False
   
'    Sql = "SP_LEERUSUARIOS " & "ADMINISTRA"

    Envia = Array("ADMINISTRA")
    
    If Not Bac_Sql_Execute("SP_LEERUSUARIOS", Envia) Then
       Exit Function
    End If
       
    Call VaciarColeccion
    
    Do While Bac_SQL_Fetch(Datos())
        Dim objBuf As New clsUsuario
        With objBuf
            .Usuario = Mid$(Datos(1) + Space(15), 1, 15)
            .NOMBRE = Datos(2)
        End With
        Coleccion.Add objBuf
        Set objBuf = Nothing
    Loop
    
    LeerUsuarios = True

End Function

Public Sub ColeccionUControl(objControl As Object)
Dim FILAS   As Long
Dim IDGLOSA As String * 40
Dim Max     As Long
          
    objControl.Clear
    Max = Coleccion.Count
    For FILAS = 1 To Max
        IDGLOSA = Coleccion(FILAS).Usuario + "   " + Coleccion(FILAS).NOMBRE
        objControl.AddItem IDGLOSA
    Next FILAS
    
End Sub

Private Sub Class_Initialize()
    Set objUser = New clsUsuario
End Sub


Private Sub Class_Terminate()
    Set objUser = Nothing
End Sub


