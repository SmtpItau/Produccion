VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "clsDCartera"
Attribute VB_Creatable = True
Attribute VB_Exposed = True
Option Explicit

 'MDDC : TABLAS DE DUEÑOS DE CARTERAS
 '-----------------------------------------------
 Public rccodcar   As Currency  'numeric 10,0
 Public rcrut      As Long      'numeric  9,0
 Public rcdv       As String
 Public rcnombre   As String
 Public rcnumoper  As Currency  'numeric 10,0
 Public rctelefono As String
 Public rcfax      As String
 Public rcdirecc   As String

 




            


Public Function Grabar() As Boolean

Dim SQL As String

    Grabar = False
     
    SQL = ""
    SQL = SQL & "Exec Sp_RcGrabar "
    SQL = SQL & rccodcar & ","
    SQL = SQL & rcrut & ","
    SQL = SQL & "'" & rcdv & "',"
    SQL = SQL & "'" & rcnombre & "',"
    SQL = SQL & rcnumoper & ","
    SQL = SQL & "'" & rctelefono & "',"
    SQL = SQL & "'" & rcfax & "',"
    SQL = SQL & "'" & rcdirecc & "'"
     
    If SQL_Execute(SQL) <> 0 Then
        Exit Function
    End If
    
    Call Limpiar
    Grabar = True
     
End Function






Public Function LeerPorCodigo(IdCodigo As Long)

Dim SQL As String

    LeerPorCodigo = False
    
    SQL = " Exec Sp_RcLeerCod " & IdCodigo
    
    If SQL_Execute(SQL) <> 0 Then
       Exit Function
    End If
     
    Limpiar
    
    Dim Datos()
    If SQL_Fetch(Datos()) = 0 Then
        rccodcar = Val(Datos(1))
        rcrut = Val(Datos(2))
        rcdv = Datos(3)
        rcnombre = Datos(4)
        rcnumoper = Val(Datos(5))
        rctelefono = Datos(6)
        rcfax = Datos(7)
        rcdirecc = Datos(8)
    End If
    
    LeerPorCodigo = True
    
End Function

Public Function LeerPorRut(IdRut As Long) As Boolean

Dim SQL As String

    LeerPorRut = False
    
    SQL = " Exec Sp_RcLeerRut " & IdRut
    
    If SQL_Execute(SQL) <> 0 Then
       Exit Function
    End If
     
    Limpiar
    
    Dim Datos()
    If SQL_Fetch(Datos()) = 0 Then
        rccodcar = Val(Datos(1))
        rcrut = Val(Datos(2))
        rcdv = Datos(3)
        rcnombre = Datos(4)
        rcnumoper = Val(Datos(5))
        rctelefono = Datos(6)
        rcfax = Datos(7)
        rcdirecc = Datos(8)
    End If
    
    LeerPorRut = True
    
End Function



Public Function Eliminar(IdRut As Long) As Boolean

Dim SQL As String

    Eliminar = False
    SQL = " Exec Sp_RcEliminar " & IdRut
    If SQL_Execute(SQL) <> 0 Then
       Exit Function
    End If
    Call Limpiar
    Eliminar = True
    
End Function



Private Sub Limpiar()
 
    rccodcar = 0
    rcrut = 0
    rcdv = ""
    rcnombre = ""
    rcnumoper = 0
    rctelefono = ""
    rcfax = ""
    rcdirecc = ""
 
End Sub

Private Sub Class_Initialize()

    Call Limpiar
    
End Sub


