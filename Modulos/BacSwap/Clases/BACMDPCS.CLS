VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "clsPlanCtas"
Attribute VB_Creatable = True
Attribute VB_Exposed = True
Option Explicit

Public objPlanCta As Object
Public Coleccion As New Collection

Public Sub Coleccion2Combo(objControl As Object)

Dim Filas As Long
Dim Max   As Long

    objControl.Clear
    Max = Coleccion.Count
    For Filas = 1 To Max
        objControl.AddItem Coleccion(Filas).pcdescrip
    Next Filas
          
End Sub


Public Function LeerCuentas(cCuenta As String) As Boolean

'Lee todas las Planes de Cuentas y llena una colecccion

Dim SQL As String

    LeerCuentas = False
    
    SQL = "Exec Sp_PcLeerTodo '" & cCuenta & "'"
    
    If SQL_Execute(SQL) <> 0 Then
       Exit Function
    End If
    
    Call VaciarColeccion
    
    Dim Datos()
    Do While SQL_Fetch(Datos()) = 0
        Dim objBuf As New clsPlanCta
        With objBuf
            .pccuenta = Datos(1)
            .pctipo = Datos(2)
            .pcdescrip = Datos(3)
            .pcpadre = Datos(4)
            .pcnivel = Datos(5)
            .pchaber = Datos(6)
            .pcdebe = Datos(7)
        End With
        Coleccion.Add objBuf
        Set objBuf = Nothing
    Loop
    
    LeerCuentas = True
       
End Function



Public Sub VaciarColeccion()

Dim Filas   As Long
Dim Max     As Long
          
    Max = Coleccion.Count
    For Filas = 1 To Max
        Coleccion.Remove 1
    Next Filas
          
End Sub
 

Private Sub Class_Initialize()

 Set objPlanCta = New clsPlanCta
 
End Sub


Private Sub Class_Terminate()
 
 Set objPlanCta = Nothing
 

End Sub


