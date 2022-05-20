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
        glosa = Trim$(coleccion(Filas).inserie) & Space(10 - Len(Trim$(coleccion(Filas).inserie))) & coleccion(Filas).inglosa
        
        objControl.AddItem glosa
        
    Next Filas
          
End Sub

Public Sub ColeccionListView(objControl As ListView)
Dim Filas   As Long
Dim glosa   As String * 110
Dim Max     As Long

    Max = coleccion.Count
       
    With objControl
       
          .ColumnHeaders.Add 1, , "Serie", 2000
          .ColumnHeaders.Add 2, , "Descripción", 2000
                      
          
          For Filas = 1 To Max
              'Se guarda el codigo en el string porque no se puede guardar en el ItemData ya que tendria que ser un entero
              'De esta forma se que el codigo esta desde la posicion 101 hasta la . Ademas no se ve en el ListBox
      '       Glosa = Trim$(Coleccion(Filas).inglosa) & Space(30 - Len(Trim$(Coleccion(Filas).inglosa))) & Coleccion(Filas).inserie
              
              .ListItems.Add , , Trim$(coleccion(Filas).inserie)
              .ListItems.Item(.ListItems.Count).ListSubItems.Add , , coleccion(Filas).inglosa
              
              'glosa = Trim$(coleccion(Filas).inserie) & Space(10 - Len(Trim$(coleccion(Filas).inserie))) & coleccion(Filas).inglosa
              
              
          Next Filas
          
     End With
          
End Sub


Public Function LeerFamilias() As Boolean

    LeerFamilias = False
              
    If Not BAC_SQL_EXECUTE("SP_INLEERFAMILIAS") Then
       Exit Function
    End If
    
    Call VaciarColeccion
        
    Dim Datos()
    Do While BAC_SQL_FETCH(Datos())
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


