VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsFamilia"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
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
Public incontab   As String  'CHAR     (01)   NULL


Public Function Eliminar(Idserie As String) As Boolean

    Eliminar = False
          
'    Sql = "SP_INELIMINAR '" & Idserie & "'"

    Envia = Array(CDbl(Idserie))
    
    If Not Bac_Sql_Execute("SP_INELIMINAR", Envia) Then
        Exit Function
    End If
    
    Call Limpiar
    Eliminar = True
       
End Function

Public Function Grabar() As Boolean

    Grabar = False
          
'    Sql = "SP_INGRABAR "
'    Sql = Sql & incodigo & ","
'    Sql = Sql & "'" & inserie & "',"
'    Sql = Sql & "'" & inglosa & "',"
'    Sql = Sql & inrutemi & ","
'    Sql = Sql & inmonemi & ","
'    Sql = Sql & inbasemi & ","
'    Sql = Sql & "'" & inprog & "',"
'    Sql = Sql & "'" & inrefnomi & "',"
'    Sql = Sql & "'" & inmdse & "',"
'    Sql = Sql & "'" & inmdtd & "',"
'    Sql = Sql & "'" & inmdpr & "',"
'    Sql = Sql & intipfec & ","
'    Sql = Sql & intasest & ","
'    Sql = Sql & "'" & intipo & "',"
'    Sql = Sql & "'" & inemision & "',"
'    Sql = Sql & "'" & ineleg & "',"
'    Sql = Sql & "'" & incontab & "'"

    Envia = Array(CDbl(incodigo), _
            inserie, _
            inglosa, _
            CDbl(inrutemi), _
            CDbl(inmonemi), _
            CDbl(inbasemi), _
            inprog, _
            inrefnomi, _
            inmdse, _
            inmdtd, _
            inmdpr, _
            CDbl(intipfec), _
            CDbl(intasest), _
            intipo, _
            inemision, _
            ineleg, _
            incontab)

    If Not Bac_Sql_Execute("SP_INGRABAR", Envia) Then
        Exit Function
    End If
    
    Call Limpiar
    
    Grabar = True

End Function


Function LeerPorCodigo(IDCodigo As Long)

    LeerPorCodigo = False
          
'    Sql = "SP_INLEERCOD " & IDCodigo

    Envia = Array(CDbl(IDCodigo))
    
    If Not Bac_Sql_Execute("SP_INLEERCOD", Envia) Then
       Exit Function
    End If
    
    Dim Datos()
    
    Call Limpiar
       
    If Bac_SQL_Fetch(Datos()) Then
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
'        incontab = Datos(17)
    End If
    
    LeerPorCodigo = True
    
End Function

Public Function LeerPorSerie(Idserie As String) As Boolean

    LeerPorSerie = False
          
'    Sql = "SP_INLEERSER '" & Idserie & "'"

    Envia = Array(Idserie)
    
    If Not Bac_Sql_Execute("SP_INLEERSER", Envia) Then
        Exit Function
    End If
    
    Dim Datos()
    
    Call Limpiar
       
    If Bac_SQL_Fetch(Datos()) Then
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
        incontab = Datos(17)
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
        incontab = ""
        
End Sub



