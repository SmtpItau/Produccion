VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "clsPlanCta"
Attribute VB_Creatable = True
Attribute VB_Exposed = True
Option Explicit

Public pccuenta  As String
Public pctipo    As Integer
Public pcdescrip As String
Public pcpadre   As String
Public pcnivel   As Integer
Public pchaber   As Double
Public pcdebe    As Double



Public Function Eliminar(cCuenta As String) As Integer
Dim SQL As String


    Eliminar = False
    
    SQL = "Execute Sp_PcEliminar '" & cCuenta & "'"
    
    If SQL_Execute(SQL) <> 0 Then
       Exit Function
    End If
    
    Eliminar = True
    
End Function

Public Function Grabar() As Boolean
Dim SQL As String

    Grabar = False
    
    SQL = ""
    SQL = SQL & "Execute sp_PcGrabar " & "'" & pccuenta & "',"
    SQL = SQL & pctipo & ","
    SQL = SQL & "'" & pcdescrip & "',"
    SQL = SQL & "'" & pcpadre & "',"
    SQL = SQL & pcnivel & ","
    SQL = SQL & pchaber & ","
    SQL = SQL & pcdebe

    If SQL_Execute(SQL) <> 0 Then
       Exit Function
    End If
    
    Grabar = True
    
End Function

Public Function Leer(cCuenta As String) As Integer
Dim SQL As String

    Leer = False
    
    SQL = "Execute Sp_PcLeer '" & cCuenta & "'"
    
    If SQL_Execute(SQL) <> 0 Then
       Exit Function
    End If
    
    Dim Datos()
    
    Call Limpiar
    
    If SQL_Fetch(Datos()) = 0 Then
        pccuenta = Datos(1)
        pctipo = Datos(2)
        pcdescrip = Datos(3)
        pcpadre = Datos(4)
        pcnivel = Datos(5)
        pchaber = Datos(6)
        pcdebe = Datos(7)
    End If
    
    Leer = True
    
End Function



Private Sub Limpiar()

    pccuenta = ""
    pctipo = 0
    pcdescrip = ""
    pcpadre = ""
    pcnivel = 0
    pchaber = 0
    pcdebe = 0

End Sub




