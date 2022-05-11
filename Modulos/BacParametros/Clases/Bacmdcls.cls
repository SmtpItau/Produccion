VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsClientes"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit
Public clrut As Integer
Public clcodigo As Integer
Public cldatatec As String
Public clbolsa As String

Public clNomSinacofi As String
Public clNumSinacofi As Integer
Public objCliente As Object
Public coleccion As New Collection


Public Sub VaciarColeccion()

   Dim Filas&, Max&

   Max& = coleccion.Count
   For Filas& = 1 To Max&
      coleccion.Remove 1

   Next Filas&

End Sub

Public Sub Coleccion2Control(objControl As Object)

   Dim Filas      As Long
   Dim IdGlosa    As String * 40
   Dim Max        As Long
   Dim Var$
   With objControl
      .Clear
      Max = coleccion.Count
      Var = "1"
      For Filas = 1 To Max
         IdGlosa = coleccion(Filas).clnombre
         .AddItem IdGlosa
         .ItemData(.NewIndex) = coleccion(Filas).clrut
         Var = "2"
      Next Filas
   End With

End Sub
'Consulta clientes ordenados alfabeticamente y llena una colección
Public Function LeerClientes2(IdNombre As String) As Boolean
Dim Datos()
Dim IdRow         As Integer
Dim objBuffer     As Object
   
    LeerClientes2 = False
    Envia = Array()
    AddParam Envia, IdNombre
    
    'If SQL_ExecuteLog(SQL, Screen.ActiveForm.name, "Ayuda de Clientes", "Ayuda de la tabla de Clientes") <> 0 Then
    If Not Bac_Sql_Execute("SP_MDCLLEERNOMBRE ", Envia) Then
        Exit Function
    End If

    Call VaciarColeccion
    
    Do While Bac_SQL_Fetch(Datos())
    
        Set objBuffer = New clsCliente
    
        With objBuffer
            .clrut = CDbl(Val(Datos(1)))
            .cldv = Datos(2)
            .clcodigo = CDbl(Val(Datos(3)))
            .clnombre = Datos(4)
            .clgeneric = Datos(5)
            .cldirecc = Datos(6)
            .clcomuna = CDbl(Val(Datos(7)))
            .clregion = CDbl(Val(Datos(8)))
            .cltipcli = CDbl(Val(Datos(9)))
            .clfecingr = Datos(10)
            .clctacte = Datos(11)
            .clfono = Datos(12)
            .clfax = Datos(13)
            .cltipocliente = CDbl(Val(Datos(14)))
            .clcalidadjuridica = CDbl(Val(Datos(15)))
            .clciudad = CDbl(Val(Datos(16)))
            .clentidad = CDbl(Val(Datos(17)))
            .clmercado = CDbl(Val(Datos(18)))
            .clgrupo = CDbl(Val(Datos(19)))
            .clapoderado = Datos(20)
            .clpais = CDbl(Val(Datos(21)))
            .cl1nombre = Datos(22)
            .cl2nombre = Datos(23)
            .cl1apellido = Datos(24)
            .cl2apellido = Datos(25)
            '.clGlosab = Datos(26)
            '.ClCtausd = Datos(27)
            '.clImplic = Datos(28)
            '.clAba = Datos(29)
            '.clChips = Datos(30)
            '.clSwift = Datos(31)
        End With
        
        coleccion.Add objBuffer
        
        Set objBuffer = Nothing
   
    Loop
   
    LeerClientes2 = True

End Function

'Consulta clientes ordenados alfabeticamente y llena una colección
Public Function LeerClienteSinacofi(IdNombre As String) As Boolean
Dim Datos()
Dim IdRow         As Integer
Dim objBuffer     As Object
   
    LeerClienteSinacofi = False
    Envia = Array()
    AddParam Envia, IdNombre
    
    'If SQL_ExecuteLog(SQL, Screen.ActiveForm.name, "Ayuda de Clientes", "Ayuda de la tabla de Clientes") <> 0 Then
    If Not Bac_Sql_Execute("SP_MDCLLEERNOMBRESINACOFI ", Envia) Then
        Exit Function
    End If

    Call VaciarColeccion
    
    Do While Bac_SQL_Fetch(Datos())
    
        Set objBuffer = New clsCliente
    
        With objBuffer
            .clrut = CDbl(Val(Datos(1)))
            .cldv = Datos(2)
            .clcodigo = CDbl(Val(Datos(3)))
            .clnombre = Datos(4)
            .clgeneric = Datos(5)
            .cldirecc = Datos(6)
            .clcomuna = CDbl(Val(Datos(7)))
            .clregion = CDbl(Val(Datos(8)))
            .cltipcli = CDbl(Val(Datos(9)))
            .clfecingr = Datos(10)
            .clctacte = Datos(11)
            .clfono = Datos(12)
            .clfax = Datos(13)
            .cltipocliente = CDbl(Val(Datos(14)))
            .clcalidadjuridica = CDbl(Val(Datos(15)))
            .clciudad = CDbl(Val(Datos(16)))
            .clentidad = CDbl(Val(Datos(17)))
'            .clmercado = CDbl(Val(datos(18)))
'            .clgrupo = CDbl(Val(datos(19)))
'            .clapoderado = datos(20)
'            .clpais = CDbl(Val(datos(21)))
'            .cl1nombre = datos(22)
'            .cl2nombre = datos(23)
'            .cl1apellido = datos(24)
'            .cl2apellido = datos(25)
            '.clGlosab = Datos(26)
            '.ClCtausd = Datos(27)
            '.clImplic = Datos(28)
            '.clAba = Datos(29)
            '.clChips = Datos(30)
            '.clSwift = Datos(31)
        End With
        
        coleccion.Add objBuffer
        
        Set objBuffer = Nothing
   
    Loop
   
    LeerClienteSinacofi = True

End Function
'Consulta clientes segun su tipo y son ordenados alfabeticamente y llena una colección
Public Function LeerClientesPorTipo(codTipo As Integer, Optional nombre As String = "", Optional maximo As Integer = 0) As Boolean
    Dim datos()
    Dim nomSp As String
    LeerClientesPorTipo = False
    nomSp = "BacParamsuda.dbo.SP_CLIENTESPORTIPO"
    Envia = Array()
    AddParam Envia, codTipo
    AddParam Envia, nombre
    AddParam Envia, maximo
    If Not Bac_Sql_Execute(nomSp, Envia) Then
        Exit Function
    End If
    Call VaciarColeccion
    Dim objBuf As New clsCliente
    Do While Bac_SQL_Fetch(datos())
        With objBuf
            .clrut = datos(1)
            .cldv = datos(2)
            .clcodigo = datos(3)
            .clnombre = datos(4)
            .clgeneric = datos(5)
            .cldirecc = datos(6)
            .clcomuna = datos(7)
            .clregion = datos(8)
            .clcompint = datos(9)
            .cltipcli = datos(10)
            .clfecingr = datos(11)
            .clctacte = datos(12)
            .clfono = datos(13)
            .clfax = datos(14)
            .mxcontab = datos(15)
            .clpais = datos(16)
            .clciudad = datos(17)
            .clVigente = datos(18)
        End With
        coleccion.Add objBuf
        Set objBuf = Nothing
    Loop
    LeerClientesPorTipo = True
End Function

Public Function LeerClientes(IdNombre As String, Solo_Bancos As String) As Boolean
Dim sql   As String
Dim IdRow As Integer
Dim Datos()
 
    LeerClientes = False
    Envia = Array()
    AddParam Envia, IdNombre
          
    If Not Bac_Sql_Execute("SP_CLLEERNOMBRES1", Envia) Then
       Exit Function
    End If
       
    Call VaciarColeccion
    Dim objBuf As New clsCliente
    Do While Bac_SQL_Fetch(Datos())
        
        
        If (Solo_Bancos = "S" And Val(Datos(10)) = 1) Or Solo_Bancos = "N" Then
        
           With objBuf
                .clrut = Datos(1)
                .cldv = Datos(2)
                .clcodigo = Datos(3)
                .clnombre = Datos(4)
                .clgeneric = Datos(5)
                .cldirecc = Datos(6)
                .clcomuna = Datos(7)
                .clregion = Datos(8)
                .clcompint = Datos(9)
                .cltipcli = Datos(10)
                .clfecingr = Datos(11)
                .clctacte = Datos(12)
                .clfono = Datos(13)
                .clfax = Datos(14)
                .mxcontab = Datos(15)
                .clpais = Datos(16)
                .clciudad = Datos(17)
                .clVigente = Datos(18)
            End With
            coleccion.Add objBuf
            Set objBuf = Nothing
            
        End If
        
    Loop
    
    LeerClientes = True

End Function
'modificadoi 21/12/2000
'Public Function LeerClientes(IdNombre As String, IdTipoCliente As Integer) As Boolean
''LeerTipoClientes(IdTipoCliente As Integer) As Boolean
'Dim Datos()
'Dim IdRow         As Integer
'Dim objBuffer     As Object
'
'    LeerClientes = False
'
'    Sql = "Sp_ClientesxTipo " & IdTipoCliente
'    'If SQL_ExecuteLog(SQL, Screen.ActiveForm.name, "Ayuda de Clientes", "Ayuda de la tabla de Clientes") <> 0 Then
'    If MISQL.SQL_Execute(Sql) <> 0 Then
'        Exit Function
'    End If
'
'    Call VaciarColeccion
'
'    Do While MISQL.SQL_Fetch(Datos()) = 0
'
'        Set objBuffer = New clsCliente
'
'        With objBuffer
'            .clrut = CDbl(Val(Datos(1)))
'            .cldv = Datos(2)
'            .clcodigo = CDbl(Val(Datos(3)))
'            .clnombre = Datos(4)
'            .clgeneric = Datos(5)
'            .cldirecc = Datos(6)
'            .clcomuna = CDbl(Val(Datos(7)))
'            .clregion = CDbl(Val(Datos(8)))
'            .cltipcli = CDbl(Val(Datos(9)))
'            .clfecingr = Datos(10)
'            .clctacte = Datos(11)
'            .clfono = Datos(12)
'            .clfax = Datos(13)
'            .cltipocliente = CDbl(Val(Datos(14)))
'            .clcalidadjuridica = CDbl(Val(Datos(15)))
'            .clciudad = CDbl(Val(Datos(16)))
'            .clEntidad = CDbl(Val(Datos(17)))
'            .clmercado = CDbl(Val(Datos(18)))
'            .clGrupo = CDbl(Val(Datos(19)))
'            .clapoderado = Datos(20)
'            .clPais = CDbl(Val(Datos(21)))
'            .cl1Nombre = Datos(22)
'            .cl2Nombre = Datos(23)
'            .cl1Apellido = Datos(24)
'            .cl2Apellido = Datos(25)
'            '.clGlosab = Datos(26)
'            '.ClCtausd = Datos(27)
'            '.clImplic = Datos(28)
'            '.clAba = Datos(29)
'            '.clChips = Datos(30)
'            '.clSwift = Datos(31)
'        End With
'
'        Coleccion.Add objBuffer
'        'nPanta = 0
'
'        Set objBuffer = Nothing
'
'    Loop
'
'    LeerClientes = True
'
'End Function
'Private Sub Class_Initialize()
'
'   Set ObjCliente = New clsCliente
'
'End Function

Private Sub Class_Terminate()

   Set objCliente = Nothing
    
End Sub

Private Sub Class_Initialize()

    Set objCliente = New clsCliente
    
End Sub
'Public Function LeerPorRut(rutcli As Long, codcli As Long) As Boolean
'
'   Dim Sql           As String
'   Dim datos()
'
'   LeerPorRut = False
'
'   Sql = "sp_mdclleerrut " & rutcli & ", " & 0 & ", " & codcli
'
'   If MISQL.SQL_Execute(Sql) > 0 Then
'      Exit Function
'
'   End If
'
'    Call Limpiar
'
'   If MISQL.SQL_Fetch(datos()) = 0 Then
'      clrut = Val(datos(1))
'      cldv = datos(2)
'      clcodigo = Val(datos(3))
'      clnombre = datos(4)
'      clgeneric = datos(5)
'      cldirecc = datos(6)
'      'clcomuna = CDbl(Datos(7))
'      clregion = Val(datos(8))
'      'clcompint = Val(Datos(9))
'      cltipcli = Val(datos(9))
'      clfecingr = datos(10)
'      clctacte = datos(11)
'      clfono = datos(12)
'      clfax = datos(13)
'      cltipocliente = Val(datos(14))
'      'clcalidadjuridica = Val(Datos(15))
'      'clciudad = CDbl(Datos(16))
'      'clEntidad = Val(Datos(17))
'      clmercado = Val(datos(18))
'      'clGrupo = Val(Datos(19))
'      'clapoderado = Datos(20)
'      clpais = Val(datos(21))
'      'clcodcli = Val(Datos(22))
'      clNumSinacofi = datos(23)
'      clNomSinacofi = datos(24)
'
'      LeerPorRut = True
'
'   End If
'
'End Function

Public Function GrabarSINACOFI() As Boolean

    GrabarSINACOFI = False
    Envia = Array()
    AddParam Envia, clrut
    AddParam Envia, clcodigo
    AddParam Envia, clNumSinacofi
    AddParam Envia, clNomSinacofi
    AddParam Envia, cldatatec
    AddParam Envia, clbolsa
    
    If Not Bac_Sql_Execute("SP_GRABASINACOFIMDCL", Envia) Then
        Exit Function
    End If

    GrabarSINACOFI = True

End Function
Public Function BorrarSINACOFI() As Boolean

    BorrarSINACOFI = False
    Envia = Array()
    AddParam Envia, clrut
    
    If Not Bac_Sql_Execute("SP_BORRASINACOFIMDCL ", Envia) Then
        Exit Function
    End If

    BorrarSINACOFI = True

End Function

'Private Sub Limpiar()
'
'    emcodigo = 0
'    emrut = 0
'    emdv = ""
'    emnombre = ""
'    emgeneric = ""
'    emdirecc = ""
'    emcomuna = 0
'    emtipo = ""
'
'End Sub


Public Function LeerClientesBanco() As Boolean
   Dim sql   As String
   Dim IdRow As Integer
   Dim Datos()
 
   LeerClientesBanco = False
   
   Envia = Array()
   If Not Bac_Sql_Execute("SP_LEECLIENTEBANCOS") Then
      Exit Function
   End If
       
   Dim objBuf As New clsCliente
   
   Call VaciarColeccion
   Do While Bac_SQL_Fetch(Datos())
      objBuf.clrut = Datos(1)
      objBuf.cldv = Datos(2)
      objBuf.clcodigo = Datos(3)
      objBuf.clnombre = Datos(4)
      objBuf.clgeneric = Datos(5)
      objBuf.cldirecc = Datos(6)
      objBuf.clcomuna = Datos(7)
      objBuf.clregion = Datos(8)
      objBuf.clcompint = Datos(9)
      objBuf.cltipcli = Datos(10)
      objBuf.clfecingr = Datos(11)
      objBuf.clctacte = Datos(12)
      objBuf.clfono = Datos(13)
      objBuf.clfax = Datos(14)
      objBuf.mxcontab = Datos(15)
      objBuf.clpais = Datos(16)
      objBuf.clciudad = Datos(17)
      objBuf.clswift = Datos(18)
      
      coleccion.Add objBuf
      Set objBuf = Nothing
   Loop
   
   LeerClientesBanco = True
End Function
