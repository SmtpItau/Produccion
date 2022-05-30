VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "clsFamilia"
Attribute VB_Creatable = True
Attribute VB_Exposed = True
Option Explicit

Public incodigo   As Integer 'NUMERIC  (03,0) NULL ,
Public inserie    As String  'CHAR     (12)   NULL ,
Public inglosa    As String  'CHAR     (40)   NULL ,
Public inrutemi   As Long    'NUMERIC  (09,0) NULL ,
Public inmonemi   As Integer 'NUMERIC  (03,0) NULL ,
Public inbasemi   As Integer 'NUMERIC  (03,0) NULL ,
Public inprog     As String  'CHAR     (08)   NULL ,
Public inrefnomi  As String  'CHAR     (01)   NULL ,
Public inmdse     As String  'CHAR     (01)   NULL ,
Public inmdtd     As String  'CHAR     (01)   NULL ,
Public inmdpr     As String  'CHAR     (01)   NULL ,
Public intipfec   As Integer 'NUMERIC  (01,0) NULL ,
Public intasest   As Integer 'NUMERIC  (03,0) NULL ,
Public intipo     As String  'CHAR     (03)   NULL ,
Public inemision  As String  'CHAR     (03)   NULL
Public ineleg     As String  'CHAR     (01)   NULL


Public Function Eliminar(Idserie As String) As Boolean

Dim SQL As String

    Eliminar = False
          
    SQL = ""
    SQL = " Exec Sp_InEliminar '" & Idserie & "'"
    
    If SQL_Execute(SQL) <> 0 Then
       Exit Function
    End If
    Call Limpiar
    Eliminar = True
       
End Function

Public Function Grabar() As Boolean

Dim SQL As String

    Grabar = False
          
    SQL = ""
    SQL = " Exec Sp_InGrabar "
    SQL = SQL & incodigo & ","
    SQL = SQL & "'" & inserie & "',"
    SQL = SQL & "'" & inglosa & "',"
    SQL = SQL & inrutemi & ","
    SQL = SQL & inmonemi & ","
    SQL = SQL & inbasemi & ","
    SQL = SQL & "'" & inprog & "',"
    SQL = SQL & "'" & inrefnomi & "',"
    SQL = SQL & "'" & inmdse & "',"
    SQL = SQL & "'" & inmdtd & "',"
    SQL = SQL & "'" & inmdpr & "',"
    SQL = SQL & intipfec & ","
    SQL = SQL & intasest & ","
    SQL = SQL & "'" & intipo & "',"
    SQL = SQL & "'" & inemision & "',"
    SQL = SQL & "'" & ineleg & "'"

    If SQL_Execute(SQL) <> 0 Then
       Exit Function
    End If
    
    Call Limpiar
    
    Grabar = True

End Function


Function LeerPorCodigo(IdCodigo As Long)

Dim SQL As String

    LeerPorCodigo = False
          
    SQL = ""
    SQL = " Exec Sp_InLeerCod " & IdCodigo
    
    If SQL_Execute(SQL) <> 0 Then
       Exit Function
    End If
    
    Dim Datos()
    
    Call Limpiar
       
    If SQL_Fetch(Datos()) = 0 Then
        incodigo = Val(Datos(1))
        inserie = Datos(2)
        inglosa = Datos(3)
        inrutemi = Val(Datos(4))
        inmonemi = Val(Datos(5))
        inbasemi = Val(Datos(6))
        inprog = Datos(7)
        inrefnomi = Datos(8)
        inmdse = Datos(9)
        inmdtd = Datos(10)
        inmdpr = Datos(11)
        intipfec = Val(Datos(12))
        intasest = Val(Datos(13))
        intipo = Datos(14)
        inemision = Datos(15)
        ineleg = Datos(16)
    End If
    
    LeerPorCodigo = True
    
End Function

Public Function LeerPorSerie(Idserie As String) As Boolean

Dim SQL As String

    LeerPorSerie = False
          
    SQL = ""
    SQL = " Exec Sp_InLeerSer '" & Idserie & "'"
    
    If SQL_Execute(SQL) <> 0 Then
       Exit Function
    End If
    
    Dim Datos()
    
    Call Limpiar
       
    If SQL_Fetch(Datos()) = 0 Then
        incodigo = Val(Datos(1))
        inserie = Datos(2)
        inglosa = Datos(3)
        inrutemi = Val(Datos(4))
        inmonemi = Val(Datos(5))
        inbasemi = Val(Datos(6))
        inprog = Datos(7)
        inrefnomi = Datos(8)
        inmdse = Datos(9)
        inmdtd = Datos(10)
        inmdpr = Datos(11)
        intipfec = Val(Datos(12))
        intasest = Val(Datos(13))
        intipo = Datos(14)
        inemision = Datos(15)
        ineleg = Datos(16)
    End If

    LeerPorSerie = True

End Function




Private Sub Limpiar()

        incodigo = 0
        inserie = ""
        inglosa = ""
        inrutemi = 0
        inmonemi = 0
        inbasemi = 0
        inprog = ""
        inrefnomi = ""
        inmdse = ""
        inmdtd = ""
        inmdpr = ""
        intipfec = 0
        intasest = 0
        intipo = ""
        inemision = ""
        ineleg = ""
        
End Sub



Private Sub Class_Initialize()

End Sub


