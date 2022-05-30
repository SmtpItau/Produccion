VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "CLSFORWARD"
Attribute VB_Creatable = False
Attribute VB_Exposed = False
Option Explicit

Public objForward As Object
Public Coleccion As New Collection

Public Sub LlenarControl(objControl As Object)

Dim Filas   As Long
Dim IdGlosa As String * 40
Dim Max     As Long
          
    objControl.Clear
    Max = Coleccion.Count
    For Filas = 1 To Max
        IdGlosa = Coleccion(Filas).prglosa
        objControl.AddItem IdGlosa
'        objControl.ItemData(objControl.NewIndex) = Coleccion(Filas).clrut
    Next Filas
    
End Sub

Public Sub VaciarColeccion()

Dim Filas&, Max&
          
    Max& = Coleccion.Count
    For Filas& = 1 To Max&
        Coleccion.Remove 1
    Next Filas&
          
End Sub


Public Function LeerCartSegCmb(cCodcart As String) As Boolean

Dim SQL   As String
Dim Datos()
 
    LeerCartSegCmb = False
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
            .prcodmon1 = Datos(2)
            .prcodmon2 = Datos(3)
            .prglosa = Datos(4)
            .prdecpr = Val(Datos(5))
            .prdectc = Val(Datos(6))
            .prbase = Val(Datos(7))
            .prtippr = Datos(8)
            .prtipmod = Datos(9)
            .prprmmon1 = Datos(10)
            .prprmmon2 = Datos(11)
            .prprogcal = Datos(12)
            .prprogdev = Datos(13)
        End With
        Coleccion.Add objBuf
        Set objBuf = Nothing
    Loop
    
    LeerCartSegCmb = True

End Function

Private Sub Class_Initialize()
   Set objForward = New ClsMFPR
End Sub


Private Sub Class_Terminate()
 Set objForward = Nothing
    
End Sub


