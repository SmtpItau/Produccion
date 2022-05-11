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
Public coleccion As New Collection

Public Sub VaciarColeccion()
Dim Filas&, Max&

    Max& = coleccion.Count
    For Filas& = 1 To Max&
        coleccion.Remove 1
    Next Filas&
          
End Sub

Public Sub Coleccion2Control(objControl As Object)
Dim Filas   As Long
Dim glosa   As String * 110
Dim Max     As Long

    objControl.Clear
    Max = coleccion.Count
    For Filas = 1 To Max
        'Se guarda el codigo en el string porque no se puede guardar en el ItemData ya que tendria que ser un entero
        'De esta forma se que el codigo esta desde la posicion 101 hasta la . Ademas no se ve en el ListBox
'       Glosa = Trim$(Coleccion(Filas).inglosa) & Space(30 - Len(Trim$(Coleccion(Filas).inglosa))) & Coleccion(Filas).inserie
         On Error Resume Next
        glosa = Trim$(coleccion(Filas).inserie) & Space(10 - Len(Trim$(coleccion(Filas).inserie))) & coleccion(Filas).inglosa
        
        objControl.AddItem glosa
        
    Next Filas
          
End Sub

Public Function LeerFamilias() As Boolean

    LeerFamilias = False
              
    If Not Bac_Sql_Execute("SP_INLEERFAMILIAS") Then
       Exit Function
    End If
    
    Call VaciarColeccion
        
    Dim datos()
    Do While Bac_SQL_Fetch(datos())
        Dim objBuf As New clsFamilia
        With objBuf
            .incodigo = Val(datos(1))
            .inserie = datos(2)
            .inglosa = datos(3)
            .inrutemi = Val(datos(4))
            .inmonemi = Val(datos(5))
            .inbasemi = Val(datos(6))
            .inprog = datos(7)
            .inrefnomi = datos(8)
            .inmdse = datos(9)
            .inmdtd = datos(10)
            .inmdpr = datos(11)
            .intipfec = Val(datos(12))
            .intasest = Val(datos(13))
            .intipo = datos(14)
            .inemision = datos(15)
            .ineleg = datos(16)
        End With
        coleccion.Add objBuf
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


