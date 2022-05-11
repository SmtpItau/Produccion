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

Public Function Eliminar(RutCli As Long, Codcli As Long) As Boolean
    
    Eliminar = False
    
'    Sql = "SP_CLELIMINAR1 " & RutCli & "," & Codcli
     
    envia = Array(CDbl(RutCli), CDbl(Codcli))
    
    If Not Bac_Sql_Execute("SP_CLELIMINAR1", envia) Then
       Exit Function
    End If
    
    Call Limpiar
    
    Eliminar = True
    
End Function


Public Function LeerPorRut(RutCli As Long, DigVer As String, Masdatos As Integer, Codcli As Long) As Boolean
Dim ncodi%
Dim I%
Dim k%
Dim dummy As Boolean
Dim cString As String
Dim datos()
Dim xclrut As Long

    Screen.MousePointer = 11

    LeerPorRut = False
    
'    Sql = "sp_clleerrut1 "
'    Sql = Sql & RutCli
'    Sql = Sql & "," & Codcli

    envia = Array(CDbl(RutCli), CDbl(Codcli))
          
    If Not Bac_Sql_Execute("SVA_GEN_LEE_RUT", envia) Then
        MsgBox "Consulta en Bactrader Ha Fallado. Servidor SQL No Responde", vbCritical, gsBac_Version
        Exit Function
    End If
       
    Call Limpiar
        
    If Bac_SQL_Fetch(datos()) Then
        clrut = Val(datos(1))
        cldv = datos(2)
        clcodigo = Val(datos(3))
        clnombre = datos(4)
        clgeneric = datos(5)
        cldirecc = datos(6)
        clcomuna = Val(datos(7))
        clregion = Val(datos(8))
        clcompint = Val(datos(9))
        cltipcli = Val(datos(10))
        clfecingr = datos(11)
        clctacte = datos(12)
        clfono = datos(13)
        clfax = datos(14)
        clvigente = datos(15)
        
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

    envia = Array()
    AddParam envia, CDbl(clrut)
    AddParam envia, Trim(cldv)
    AddParam envia, CDbl(clcodigo)
    AddParam envia, Trim(clnombre)
    AddParam envia, Trim(clgeneric)
    AddParam envia, Trim(cldirecc)
    AddParam envia, Trim(clcomuna)
    AddParam envia, Trim(clregion)
    AddParam envia, Trim(cltipocliente)
    If Len(Trim$(clfecingr)) < 8 Then
        AddParam envia, Format(gsBac_Fecp, "mm/dd/yyyy")
    Else
        AddParam envia, Format(gsBac_Fecp, "mm/dd/yyyy")
    End If
    AddParam envia, Trim(clctacte)
    AddParam envia, Trim(clfono)
    AddParam envia, Trim(clfax)
    AddParam envia, Trim(cl1apellido)
    AddParam envia, Trim(cl2apellido)
    AddParam envia, Trim(cl1nombre)
    AddParam envia, Trim(cl2nombre)
    AddParam envia, Trim(clapoderado)
    AddParam envia, Trim(clciudad)
    AddParam envia, Trim(clmercado)
    AddParam envia, Trim(clgrupo)
    AddParam envia, Trim(clpais)
    AddParam envia, Trim(clcalidadjuridica)
    AddParam envia, dCero
    AddParam envia, dCero
    AddParam envia, dCero
    AddParam envia, " "
    AddParam envia, dCero
    AddParam envia, " "
    AddParam envia, Trim(clchips)
    AddParam envia, Trim(claba)
    AddParam envia, Trim(clswift)
    AddParam envia, dCero
    AddParam envia, " "
    AddParam envia, "06/28/1999"
    AddParam envia, " "
    AddParam envia, Trim(clentidad)
    AddParam envia, " "
    AddParam envia, dCero
    AddParam envia, " "
    AddParam envia, clctausd
    AddParam envia, " "
    AddParam envia, clglosab
    AddParam envia, Trim(climplic)
    AddParam envia, Trim(clopcion)
   
    If Not Bac_Sql_Execute("SP_CLGRABAR1", envia) Then
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


Public Function LeerPorRut1(RutCli As Long, Codcli As Long) As Boolean
Dim datos()

    LeerPorRut1 = False
      
'    Sql = "sp_mdclleerrut " & Str(RutCli) + "," + Str(Codcli)

    envia = Array(CDbl(RutCli), CDbl(Codcli))
       
    If Not Bac_Sql_Execute("sp_mdclleerrut", envia) Then
        Exit Function
    End If
       
    Call Limpiar
    
    If Bac_SQL_Fetch(datos()) Then
        clrut = CDbl(CDbl(datos(1)))
        cldv = datos(2)
        clcodigo = CDbl(CDbl(datos(3)))
        clnombre = datos(4)
        clgeneric = datos(5)
        cldirecc = datos(6)
        clcomuna = CDbl(Val(datos(7)))
        clregion = CDbl(Val(datos(8)))
        cltipcli = datos(9)
        clfecingr = datos(10)
        clctacte = datos(11)
        clfono = datos(12)
        clfax = datos(13)
        cltipocliente = CDbl(Val(datos(14)))
        clcalidadjuridica = CDbl(Val(datos(15)))
        clciudad = CDbl(Val(datos(16)))
        clentidad = CDbl(Val(datos(17)))
        clmercado = CDbl(Val(datos(18)))
        clgrupo = CDbl(Val(datos(19)))
        clapoderado = datos(20)
        clpais = CDbl(Val(datos(21)))
        cl1nombre = datos(22)
        cl2nombre = datos(23)
        cl1apellido = datos(24)
        cl2apellido = datos(25)
        clglosab = datos(26)
        clctausd = datos(27)
        climplic = datos(28)
        claba = datos(29)
        clchips = datos(30)
        clswift = datos(31)
        clopcion = datos(32)
    End If
    
    LeerPorRut1 = True
 
End Function



