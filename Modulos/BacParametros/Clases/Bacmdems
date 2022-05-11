VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsEmisores"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Public objEmisor As Object
Public coleccion As New Collection

Public Sub VaciarColeccion()
Dim Filas&, Max&
          
    Max& = coleccion.Count
    For Filas& = 1 To Max&
        coleccion.Remove 1
    Next Filas&
          
End Sub
Public Function LeerEmisores(IdNombre As String, cOrigen As String) As Boolean
Dim Sql   As String
Dim Datos()
Dim cEntra As Boolean

    LeerEmisores = False
    Envia = Array()
    AddParam Envia, IdNombre
          
    If Not Bac_Sql_Execute("SP_EMLEERNOMBRES", Envia) Then
       Exit Function
    End If
       
    'Elimino todos los miembros de la colección
    Call VaciarColeccion
    
    Do While Bac_SQL_Fetch(Datos())
        Dim objBuf As New clsEmisor
        With objBuf
        
            cEntra = False
            
            If cOrigen = "O" And Val(Datos(8)) = 2 Then
                cEntra = True
            ElseIf cOrigen = "T" Then
                cEntra = True
            End If
            
            If cEntra Then
                .emcodigo = Val(Datos(1))
                .emrut = Val(Datos(2))
                .emdv = Datos(3)
                .emnombre = Datos(4)
                .emgeneric = Datos(5)
                .emdirecc = Datos(6)
                .emcomuna = Datos(7)
                .emtipo = Datos(8)
            End If
        End With
        If cEntra Then
            coleccion.Add objBuf
            Set objBuf = Nothing
        End If
    Loop
    
    LeerEmisores = True

End Function


Public Sub Coleccion2Control(objControl As Object)
Dim Filas   As Long
Dim IdGlosa As String * 40
Dim Max     As Long
          
    objControl.Clear
    Max& = coleccion.Count
    For Filas = 1 To Max&
        IdGlosa = coleccion(Filas).emnombre
        objControl.AddItem IdGlosa
        objControl.ItemData(objControl.NewIndex) = coleccion(Filas).emrut
    Next Filas
    
End Sub



Private Sub Class_Initialize()

    Set objEmisor = New clsEmisor
    
End Sub


Private Sub Class_Terminate()

    Set objEmisor = Nothing
    
End Sub


