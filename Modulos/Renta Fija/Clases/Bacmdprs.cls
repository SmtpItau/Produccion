VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
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
    
   If miSQL.SQL_Execute("BEGIN TRANSACTION") <> 0 Then
      Exit Function
   End If

    Max = Coleccion.Count
    For F = 1 To Max
        If Coleccion(F).Grabar() = False Then
            If miSQL.SQL_Execute("ROLLBACK TRANSACTION") <> 0 Then
                Exit Function
            End If
            Exit For
        End If
    Next F
   
    If miSQL.SQL_Execute("COMMIT TRANSACTION") <> 0 Then
       Exit Function
    End If
   
    Grabar = True

End Function


Public Function Leer(Idcodi As Integer, Idserie As String) As Boolean

    Leer = False
'    Sql = "SP_TPLEER " & Idcodi & ",'" & Idserie & "'"
     
    Envia = Array(CDbl(Idcodi), Idserie)
    
    If Not Bac_Sql_Execute("SP_TPLEER", Envia) Then
       Exit Function
    End If
    
    Call VaciarColeccion
    Dim Datos()
    
    Do While Bac_SQL_Fetch(Datos())
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
Dim FILAS As Long

    Call VaciarColeccion
    
    For FILAS = 1 To IdCupon
        Dim objBuf As New clsTPremio
        With objBuf
            .prcodi = Idcodi
            .prserie = Idserie
            .prcupon = FILAS
            .prpremio = 0
        End With
        Coleccion.Add objBuf
        Set objBuf = Nothing
    Next FILAS
    
End Sub

Public Sub VaciarColeccion()
Dim FILAS As Long
Dim Max   As Long

    Max = Coleccion.Count
    
    For FILAS = 1 To Max
        Coleccion.Remove 1
    Next FILAS
          
End Sub




Private Sub Class_Initialize()
 
    Set objTPremio = New clsTPremio
 
End Sub


Private Sub Class_Terminate()
 
    Set objTPremio = Nothing

End Sub


