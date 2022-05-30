VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "clsTPremios"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Public objTPremio   As Object
Public Coleccion    As New Collection


Public Function Grabar() As Boolean

Dim Sql         As String
Dim F           As Long
Dim Max         As Long

   Grabar = False
    
   If SQL_Execute("BEGIN TRANSACTION") <> 0 Then
      Exit Function
   End If

    Max = Coleccion.Count
    For F = 1 To Max
        If Coleccion(F).Grabar() = False Then
            If SQL_Execute("ROLLBACK TRANSACTION") <> 0 Then
                Exit Function
            End If
            Exit For
        End If
    Next F
   
    If SQL_Execute("COMMIT TRANSACTION") <> 0 Then
       Exit Function
    End If
   
    Grabar = True

End Function


Public Function Leer(Idcodi As Integer, Idserie As String) As Boolean

Dim Sql As String

    Leer = False
    Sql = "Exec Sp_TPLeer " & Idcodi & ",'" & Idserie & "'"
     
    If SQL_Execute(Sql) <> 0 Then
       Exit Function
    End If
    
    Call VaciarColeccion
    Dim Datos()
    
    Do While SQL_Fetch(Datos()) = 0
        Dim objBuf As New clsTPremio
        With objBuf
            .prcodi = Val(Datos(1))
            .prserie = Datos(2)
            .prcupon = Val(Datos(3))
            .prpremio = Val(Datos(4))
        End With
        Coleccion.Add objBuf
        Set objBuf = Nothing
    Loop
    
    Leer = True
    
End Function


Public Sub LlenarColeccionVacia(Idcodi As Integer, Idserie As String, IdCupon As Long)

Dim Filas As Long

    Call VaciarColeccion
    
    For Filas = 1 To IdCupon
        Dim objBuf As New clsTPremio
        With objBuf
            .prcodi = Idcodi
            .prserie = Idserie
            .prcupon = Filas
            .prpremio = 0
        End With
        Coleccion.Add objBuf
        Set objBuf = Nothing
    Next Filas
    
End Sub

Public Sub VaciarColeccion()

Dim Filas As Long
Dim Max   As Long

    Max = Coleccion.Count
    
    For Filas = 1 To Max
        Coleccion.Remove 1
    Next Filas
          
End Sub




Private Sub Class_Initialize()
 
    Set objTPremio = New clsTPremio
 
End Sub


Private Sub Class_Terminate()
 
    Set objTPremio = Nothing

End Sub


