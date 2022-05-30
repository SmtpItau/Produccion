VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "clsArbitrajesFut"
Attribute VB_Creatable = False
Attribute VB_Exposed = False

Option Explicit

Public objForward As Object
Public coleccion As New Collection

Public Sub VaciarColeccion()

Dim Filas&, Max&
          
    Max& = coleccion.Count
    For Filas& = 1 To Max&
        coleccion.Remove 1
    Next Filas&
          
End Sub

Private Sub Class_Initialize()
   Set objForward = New clsArbFut
End Sub

Private Sub Class_Terminate()
 
    Set objForward = Nothing
    
End Sub


Public Sub LlenarControl(objControl As Object)

Dim Filas   As Long
Dim IdGlosa As String * 40
Dim Max     As Long
          
    objControl.Clear
    Max = coleccion.Count
    For Filas = 1 To Max
        IdGlosa = coleccion(Filas).prglosa
        objControl.AddItem IdGlosa
        objControl.ItemData(objControl.NewIndex) = coleccion(Filas).prcodmon1
    Next Filas
    
End Sub

Public Function LeerCartArbFut(cCodcart As String) As Boolean

Dim SQL   As String
Dim Datos()
 
    LeerCartArbFut = False
    SQL = "exec sp_PRLeerCartera "
    SQL = SQL + "'" + cCodcart + "'"
          
    If SQL_Execute(SQL) <> 0 Then
       Exit Function
    End If
       
    Call VaciarColeccion
    
    Do While SQL_Fetch(Datos()) = 0
        Dim objBuf As New ClsMFPR
        With objBuf
            .prcartera = Datos(1)
            .prcodmon1 = Val(Datos(2))
            .prcodmon2 = Datos(3)
            .prglosa = Datos(4)
            '.prdecpr = Val(Datos(5))
            '.prdectc = Val(Datos(6))
            '.prbase = Val(Datos(5))
            '.prtippr = Datos(6)
            '.prtipmod = Datos(7)
            '.prprmmon1 = Datos(10)
            '.prprmmon2 = Datos(8)
            '.prprogcal = Datos(9)
            '.prprogdev = Datos(10)
        End With
        coleccion.Add objBuf
        Set objBuf = Nothing
    Loop
    
    LeerCartArbFut = True

End Function



