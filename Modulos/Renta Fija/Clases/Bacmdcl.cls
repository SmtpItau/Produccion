VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsCliente"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

 'MDCL : TABLA DE CLIENTES
 '-----------------------------------------------
 
 Public clrut               As String
 Public cldv                As String
 Public clcodigo            As String
 Public clnombre            As String
 Public clgeneric           As String
 Public clnomb              As String
 Public clappater           As String
 Public clapmater           As String
 Public cldirecc            As String
 Public cldirec1            As String
 Public cldirec2            As String
 Public clcomuna            As String
 Public clregion            As String
 Public cltipcli            As String
 Public clfecingr           As String
 Public clfono              As String
 Public clfax               As String
 Public clcompint           As String
 Public clanexo             As String
 Public clsexo              As String
 Public clestciv            As String
 Public clctacte            As String
 Public clciudad            As String
 Public clsecemp            As String
 Public clpais              As String
 Public cltipocliente       As String
 Public clentidad           As String
 Public clcalidadjuridica   As String
 Public clgrupo             As String
 Public clmercado           As String
 Public clapoderado         As String
 Public cl1nombre           As String
 Public cl2nombre           As String
 Public cl1apellido         As String
 Public cl2apellido         As String
 Public clglosab            As String
 Public clctausd            As String
 Public climplic            As String
 Public claba               As String
 Public clchips             As String
 Public clswift             As String
 Public clopcion            As String
 Public clvigente           As String
 Public clcodcli            As Long
 










Public Function Eliminar(RutCli As Long, CodCli As Long) As Boolean
    
    Eliminar = False
    
'    Sql = "SP_CLELIMINAR1 " & RutCli & "," & Codcli
     
    Envia = Array(CDbl(RutCli), CDbl(CodCli))
    
    If Not Bac_Sql_Execute("SP_CLELIMINAR1", Envia) Then
       Exit Function
    End If
    
    Call Limpiar
    
    Eliminar = True
    
End Function


Public Function LeerPorRut(RutCli As Long, DigVer As String, Masdatos As Integer, CodCli As Long) As Boolean
Dim ncodi%
Dim I%
Dim k%
Dim dummy As Boolean
Dim cString As String
Dim Datos()
Dim xclrut As Long

    Screen.MousePointer = 11

    LeerPorRut = False
    
'    Sql = "SP_CLLEERRUT1 "
'    Sql = Sql & RutCli
'    Sql = Sql & "," & Codcli

    Envia = Array(CDbl(RutCli), CDbl(CodCli))
          
    If Not Bac_Sql_Execute("SP_CLLEERRUT1", Envia) Then
        MsgBox "Consulta en Bactrader Ha Fallado. Servidor SQL No Responde", vbCritical, gsBac_Version
        Exit Function
    End If
       
    Call Limpiar
        
    If Bac_SQL_Fetch(Datos()) Then
        clrut = Val(Datos(1))
        cldv = Datos(2)
        clcodigo = Val(Datos(3))
        clnombre = Datos(4)
        clgeneric = Datos(5)
        cldirecc = Datos(6)
        clcomuna = Val(Datos(7))
        clregion = Val(Datos(8))
        clcompint = Val(Datos(9))
        cltipcli = Val(Datos(10))
        clfecingr = Datos(11)
        clctacte = Datos(12)
        clfono = Datos(13)
        clfax = Datos(14)
        clvigente = Datos(15)
        LeerPorRut = True

    End If
    
    Screen.MousePointer = 0

End Function

Public Function Grabar() As Boolean
Dim dCero As Double
     
    Grabar = False
    dCero = 0
    
'    Sql = "SP_CLGRABAR1 " & Chr(10)
'    Sql = Sql & Trim(clrut) & "," & Chr(10)
'    Sql = Sql & "'" & Trim(cldv) & "'," & Chr(10)
'    Sql = Sql & Trim(clcodigo) & "," & Chr(10)
'    Sql = Sql & "'" & Trim(clnombre) & "'," & Chr(10)
'    Sql = Sql & "'" & Trim(clgeneric) & "'," & Chr(10)
'    Sql = Sql & "'" & Trim(cldirecc) & "'," & Chr(10)
'    Sql = Sql & Trim(clcomuna) & "," & Chr(10)
'    Sql = Sql & Trim(clregion) & "," & Chr(10)
'    Sql = Sql & Trim(cltipocliente) & "," & Chr(10)
'    If Len(Trim$(clfecingr)) < 8 Then
'        Sql = Sql & "'" & Format(gsBac_Fecp, "mm/dd/yyyy") & "'," & Chr(10)
'    Else
'        Sql = Sql & "'" & Format(gsBac_Fecp, "mm/dd/yyyy") & "'," & Chr(10)
'    End If
'    Sql = Sql & "'" & Trim(clctacte) & "'," & Chr(10)
'    Sql = Sql & "'" & Trim(clfono) & "'," & Chr(10)
'    Sql = Sql & "'" & Trim(clfax) & "'," & Chr(10)
'    Sql = Sql & "'" & Trim(cl1apellido) & "'," & Chr(10)
'    Sql = Sql & "'" & Trim(cl2apellido) & "'," & Chr(10)
'    Sql = Sql & "'" & Trim(cl1nombre) & "'," & Chr(10)
'    Sql = Sql & "'" & Trim(cl2nombre) & "'," & Chr(10)
'    Sql = Sql & "'" & Trim(clapoderado) & "'," & Chr(10)
'    Sql = Sql & Trim(clciudad) & "," & Chr(10)
'    Sql = Sql & Trim(clmercado) & "," & Chr(10)
'    Sql = Sql & Trim(clgrupo) & "," & Chr(10)
'    Sql = Sql & Trim(clpais) & "," & Chr(10)
'    Sql = Sql & Trim(clcalidadjuridica) & "," & Chr(10)
'    Sql = Sql & 0 & "," & Chr(10)
'    Sql = Sql & 0 & "," & Chr(10)
'    Sql = Sql & 0 & "," & Chr(10)
'    Sql = Sql & "'" & "" & "'," & Chr(10)
'    Sql = Sql & 0 & "," & Chr(10)
'    Sql = Sql & "'" & "" & "'," & Chr(10)
'    Sql = Sql & "'" & Trim(clchips) & "'," & Chr(10)
'    Sql = Sql & "'" & Trim(claba) & "'," & Chr(10)
'    Sql = Sql & "'" & Trim(clswift) & "'," & Chr(10)
'    Sql = Sql & 0 & "," & Chr(10)
'    Sql = Sql & "'" & "" & "'," & Chr(10)
'    Sql = Sql & "'06/28/1999'," & Chr(10)
'    Sql = Sql & "'" & "" & "'," & Chr(10)
'    Sql = Sql & Trim(clentidad) & "," & Chr(10)
'    Sql = Sql & "'" & "" & "'," & Chr(10)
'    Sql = Sql & 0 & "," & Chr(10)
'    Sql = Sql & "'" & "" & "'," & Chr(10)
'    Sql = Sql & "'" & clctausd & "'," & Chr(10)
'    Sql = Sql & "'" & "" & "'," & Chr(10)
'    Sql = Sql & "'" & clglosab & "'," & Chr(10)
'    Sql = Sql & "'" & Trim(climplic) & "'," & Chr(10)
'    Sql = Sql & "'" & Trim(clopcion) & "'"

    Envia = Array()
    AddParam Envia, CDbl(clrut)
    AddParam Envia, Trim(cldv)
    AddParam Envia, CDbl(clcodigo)
    AddParam Envia, Trim(clnombre)
    AddParam Envia, Trim(clgeneric)
    AddParam Envia, Trim(cldirecc)
    AddParam Envia, Trim(clcomuna)
    AddParam Envia, Trim(clregion)
    AddParam Envia, Trim(cltipocliente)
    If Len(Trim$(clfecingr)) < 8 Then
        AddParam Envia, Format(gsBac_Fecp, "mm/dd/yyyy")
    Else
        AddParam Envia, Format(gsBac_Fecp, "mm/dd/yyyy")
    End If
    AddParam Envia, Trim(clctacte)
    AddParam Envia, Trim(clfono)
    AddParam Envia, Trim(clfax)
    AddParam Envia, Trim(cl1apellido)
    AddParam Envia, Trim(cl2apellido)
    AddParam Envia, Trim(cl1nombre)
    AddParam Envia, Trim(cl2nombre)
    AddParam Envia, Trim(clapoderado)
    AddParam Envia, Trim(clciudad)
    AddParam Envia, Trim(clmercado)
    AddParam Envia, Trim(clgrupo)
    AddParam Envia, Trim(clpais)
    AddParam Envia, Trim(clcalidadjuridica)
    AddParam Envia, dCero
    AddParam Envia, dCero
    AddParam Envia, dCero
    AddParam Envia, " "
    AddParam Envia, dCero
    AddParam Envia, " "
    AddParam Envia, Trim(clchips)
    AddParam Envia, Trim(claba)
    AddParam Envia, Trim(clswift)
    AddParam Envia, dCero
    AddParam Envia, " "
    AddParam Envia, "06/28/1999"
    AddParam Envia, " "
    AddParam Envia, Trim(clentidad)
    AddParam Envia, " "
    AddParam Envia, dCero
    AddParam Envia, " "
    AddParam Envia, clctausd
    AddParam Envia, " "
    AddParam Envia, clglosab
    AddParam Envia, Trim(climplic)
    AddParam Envia, Trim(clopcion)
   
    If Not Bac_Sql_Execute("SP_CLGRABAR1", Envia) Then
        Exit Function
    End If
    
    Call Limpiar
    
    Grabar = True
     
End Function






Public Sub Limpiar()

            clrut = 0
            cldv = ""
            clcodigo = 0
            clnombre = ""
            clnomb = ""
            clgeneric = ""
            clappater = ""
            clapmater = ""
            cldirec1 = ""
            cldirec2 = ""
            cldirecc = ""
            clcomuna = 0
            clregion = 0
            cltipcli = 0
            clfecingr = ""
            clfono = ""
            clanexo = ""
            clsexo = 0
            clestciv = 0
            clfax = ""
            clctacte = ""
            clcompint = 0
            clciudad = 0
            clsecemp = 0
    
End Sub

Private Sub Class_Initialize()

    Call Limpiar
    
End Sub


Public Function LeerPorRut1(RutCli As Long, CodCli As Long) As Boolean
Dim Datos()

    LeerPorRut1 = False
      
'    Sql = "SP_MDCLLEERRUT " & Str(RutCli) + "," + Str(Codcli)

    Envia = Array(CDbl(RutCli), CDbl(CodCli))
       
    If Not Bac_Sql_Execute("SP_MDCLLEERRUT", Envia) Then
        Exit Function
    End If
       
    Call Limpiar
    
    If Bac_SQL_Fetch(Datos()) Then
        clrut = CDbl(Val(Datos(1)))
        cldv = Datos(2)
        clcodigo = CDbl(Val(Datos(3)))
        clnombre = Datos(4)
        clgeneric = Datos(5)
        cldirecc = Datos(6)
        clcomuna = CDbl(Val(Datos(7)))
        clregion = CDbl(Val(Datos(8)))
        cltipcli = Datos(9)
        clfecingr = Datos(10)
        clctacte = Datos(11)
        clfono = Datos(12)
        clfax = Datos(13)
        cltipocliente = CDbl(Val(Datos(14)))
        clcalidadjuridica = CDbl(Val(Datos(15)))
        clciudad = CDbl(Val(Datos(16)))
        clentidad = CDbl(Val(Datos(17)))
        clmercado = CDbl(Val(Datos(18)))
        clgrupo = CDbl(Val(Datos(19)))
        clapoderado = Datos(20)
        clpais = CDbl(Val(Datos(21)))
        cl1nombre = Datos(22)
        cl2nombre = Datos(23)
        cl1apellido = Datos(24)
        cl2apellido = Datos(25)
        clglosab = Datos(26)
        clctausd = Datos(27)
        climplic = Datos(28)
        claba = Datos(29)
        clchips = Datos(30)
        clswift = Datos(31)
        clopcion = Datos(32)
    End If
    
    LeerPorRut1 = True
 
End Function



