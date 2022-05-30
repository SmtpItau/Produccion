VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "clsEmisor"
Attribute VB_Creatable = True
Attribute VB_Exposed = True
Option Explicit

 'MDEM : TABLA DE EMISORES
 '-----------------------------------------------
 Public emcodigo   As Currency 'numeric 10,0
 Public emrut      As Long     'numeric  9,0
 Public emdv       As String
 Public emnombre   As String
 Public emgeneric  As String
 Public emdirecc   As String
 Public emcomuna   As Integer
 Public emtipo     As String
  
 




Public Function Eliminar(oRut As Long) As Boolean
Dim SQL As String

    Eliminar = False
    
    SQL = SQL & "exec Sp_EmEliminar " & emrut
    
    If SQL_Execute(SQL) <> 0 Then
       Exit Function
    End If
    
    Call Limpiar
    Eliminar = True
    
End Function



Public Function Grabar() As Boolean

Dim SQL As String
    Grabar = False
 
    SQL = "EXEC Sp_EmGrabar "
    SQL = SQL & emcodigo & ","
    SQL = SQL & emrut & ","
    SQL = SQL & "'" & emdv & "',"
    SQL = SQL & "'" & emnombre & "',"
    SQL = SQL & "'" & emgeneric & "',"
    SQL = SQL & "'" & emdirecc & "',"
    SQL = SQL & emcomuna & ","
    SQL = SQL & "'" & emtipo & "'"
    
    If SQL_Execute(SQL) <> 0 Then
       Exit Function
    End If
    
    Call Limpiar
    Grabar = True
    
End Function


Function LeerPorGenerico(Generico As String)

Dim SQL As String
 
    LeerPorGenerico = False
    
    SQL = SQL & "Exec Sp_EmLeerGen '" & Generico & "'"
    
    If SQL_Execute(SQL) <> 0 Then
       Exit Function
    End If
    
    Call Limpiar
    Dim Datos()
    If SQL_Fetch(Datos()) = 0 Then
        emcodigo = Val(Datos(1))
        emrut = Val(Datos(2))
        emdv = Datos(3)
        emnombre = Datos(4)
        emgeneric = Datos(5)
        emdirecc = Datos(6)
        emcomuna = Val(Datos(7))
        emtipo = Datos(8)
    End If
    
    LeerPorGenerico = True
    
End Function

Public Function LeerPorRut(eRut As Long) As Boolean

Dim SQL As String
 
    LeerPorRut = False
    
    SQL = SQL & "Exec Sp_EmLeerRut " & eRut
    
    If SQL_Execute(SQL) <> 0 Then
       Exit Function
    End If
    
    Call Limpiar
    
    Dim Datos()
    If SQL_Fetch(Datos()) = 0 Then
       emcodigo = Val(Datos(1))
       emrut = Val(Datos(2))
       emdv = Datos(3)
       emnombre = Datos(4)
       emgeneric = Datos(5)
       emdirecc = Datos(6)
       emcomuna = Val(Datos(7))
       emtipo = Datos(8)
    End If
    
    LeerPorRut = True
    
End Function




Private Sub Limpiar()
     
    emcodigo = 0
    emrut = 0
    emdv = ""
    emnombre = ""
    emgeneric = ""
    emdirecc = ""
    emcomuna = 0
    emtipo = ""

End Sub

Private Sub Class_Initialize()

    Call Limpiar
    
End Sub


