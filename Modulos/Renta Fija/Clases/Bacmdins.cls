VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsFamilias"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Public objFamilia As Object
Public Coleccion As New Collection

Public Sub VaciarColeccion()
Dim FILAS&, Max&

    Max& = Coleccion.Count
    For FILAS& = 1 To Max&
        Coleccion.Remove 1
    Next FILAS&
          
End Sub

Public Sub Coleccion2Control(objControl As Object)
Dim FILAS   As Long
Dim Glosa   As String * 110
Dim Max     As Long

    objControl.Clear
    Max = Coleccion.Count
    For FILAS = 1 To Max
        'Se guarda el codigo en el string porque no se puede guardar en el ItemData ya que tendria que ser un entero
        'De esta forma se que el codigo esta desde la posicion 101 hasta la . Ademas no se ve en el ListBox
'       Glosa = Trim$(Coleccion(Filas).inglosa) & Space(30 - Len(Trim$(Coleccion(Filas).inglosa))) & Coleccion(Filas).inserie
        Glosa = Trim$(Coleccion(FILAS).inserie) & Space(10 - Len(Trim$(Coleccion(FILAS).inserie))) & Coleccion(FILAS).inglosa
        
        objControl.AddItem Glosa
        
    Next FILAS
          
End Sub

Public Function LeerFamilias() As Boolean

    LeerFamilias = False
    
    If miSQL.SQL_Execute("SP_INLEERFAMILIAS ") <> 0 Then
       Exit Function
    End If
    
    Call VaciarColeccion
        
    Dim Datos()
    Do While Bac_SQL_Fetch(Datos())
        Dim objBuf As New clsFamilia
        With objBuf
            .incodigo = Val(Datos(1))
            .inserie = Datos(2)
            .inglosa = Datos(3)
            .inrutemi = Val(Datos(4))
            .inmonemi = Val(Datos(5))
            .inbasemi = Val(Datos(6))
            .inprog = Datos(7)
            .inrefnomi = Datos(8)
            .inmdse = Datos(9)
            .inmdtd = Datos(10)
            .inmdpr = Datos(11)
            .intipfec = Val(Datos(12))
            .intasest = Val(Datos(13))
            .intipo = Datos(14)
            .inemision = Datos(15)
            .ineleg = Datos(16)
        End With
        Coleccion.Add objBuf
        Set objBuf = Nothing
    Loop
    
    LeerFamilias = True
       
End Function

Private Sub Class_Initialize()

    Set objFamilia = New clsFamilia
    
End Sub


Private Sub Class_Terminate()

    Set objFamilia = Nothing
    
End Sub


