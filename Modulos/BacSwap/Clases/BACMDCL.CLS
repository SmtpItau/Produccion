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

Dim Sql$, Datos(), i&

'MDCL : TABLA DE CLIENTES
'-----------------------------------------------
Public clrut            As Long
Public cldv             As String
Public clcodigo         As Long
Public clnombre         As String
Public clcodigoBCCH     As Integer
Public clcodigoSBIF     As Integer
Public cldireccion      As String
Public clcomuna         As Integer
Public clcomunaglosa    As String
Public clciudad         As Integer
Public clciudadglosa    As String
Public clregion         As Integer
Public clregionglosa    As String
Public clPais           As Integer
Public clPaisglosa      As String
Public clfono           As String
Public clfax            As String
Public clchips          As String
Public claba            As String
Public clswift          As String
Public clctacte         As String
Public clctausd         As String
Public clnumsin         As String
Public clnomsin         As String
Public cltipocliente    As Integer

Public Function CargaObjetos(obj As Object, sCadena$, iOrden%) As Boolean

    CargaObjetos = False

    Sql = "EXECUTE " & giSQL_DatabaseCommon & ".."
    Sql = Sql & "sp_Leer_Operador 0,0,0,'" & sCadena    '-- Posibles nombres
    Sql = Sql & "',0,0," & iOrden                       '-- indica Orden
    
    obj.Clear
    
    If SQL_Execute(Sql) <> 0 Then
        Exit Function
    End If
    
    Do While SQL_Fetch(Datos) = 0
        sCadena = Right(Space(15) & Val(Datos(1)) & "-" & Datos(2), 15)
        sCadena = Left(Datos(4) & Space(40), 40) & Space(3) & sCadena
        obj.AddItem sCadena
        obj.ItemData(obj.NewIndex) = Val(Datos(3))
        CargaObjetos = True
    Loop

End Function
Public Function CargaApoderados(obj As Object, lRutCli&, lCodCli&) As Boolean

    CargaApoderados = False

    Sql = "EXECUTE " & giSQL_DatabaseCommon & ".."
    Sql = Sql & "sp_Leer_Apoderado 0," & lRutCli & "," & lCodCli
    
    obj.Clear
    
    If SQL_Execute(Sql) <> 0 Then
        Exit Function
    End If
    
    Do While SQL_Fetch(Datos) = 0
        obj.AddItem Left(Datos(6) & Space(40), 40) & Space(3) & Left(Datos(7) & Space(40), 40)  '-- Nombre y Cargo
        obj.ItemData(obj.NewIndex) = Val(Datos(4))                                              '-- Rut Apoderado
        CargaApoderados = True
    Loop

End Function
Public Function CargaOperador(obj As Object, lRutCli&, lCodCli&) As Boolean

    CargaOperador = False

    Sql = "EXECUTE " & giSQL_DatabaseCommon & ".."
    Sql = Sql & "sp_Leer_Operador 0," & lRutCli & "," & lCodCli
    
    obj.Clear
    
    If SQL_Execute(Sql) <> 0 Then
        Exit Function
    End If
    
    Do While SQL_Fetch(Datos) = 0
        obj.AddItem Datos(5)
        obj.ItemData(obj.NewIndex) = Val(Datos(3))
        CargaOperador = True
    Loop

End Function

 Sub Limpiar()

    clrut = 0
    cldv = ""
    clcodigo = 0
    clnombre = ""
    clcodigoBCCH = 0
    clcodigoSBIF = 0
    cldireccion = ""
    clcomuna = 0
    clcomunaglosa = ""
    clciudad = 0
    clciudadglosa = ""
    clregion = 0
    clregionglosa = ""
    clPais = 0
    clPaisglosa = ""
    clfono = ""
    clfax = ""
    clchips = ""
    claba = ""
    clswift = ""
    clctacte = ""
    clctausd = ""
    clnumsin = ""
    clnomsin = ""
    cltipocliente = 0

End Sub

Public Function LeerSQL(lRutCli&, lCodCli&, sNombre$, iCodBCCH%, iCodSBIF%, iOrden%) As Boolean

    LeerSQL = False
     
    Sql = "EXECUTE " & giSQL_DatabaseCommon & ".."
    Sql = Sql & "sp_Leer_Cliente " & lRutCli
    Sql = Sql & ", " & lCodCli
    Sql = Sql & ",'" & sNombre & "'"
    Sql = Sql & ", " & iCodBCCH
    Sql = Sql & ", " & iCodSBIF
    Sql = Sql & ", " & iOrden
           
    If SQL_Execute(Sql) > 0 Then
        Exit Function
    End If
            
    Call Limpiar
     
    If SQL_Fetch(Datos()) = 0 Then
        clrut = Val(Datos(1))
        cldv = Datos(2)
        clcodigo = Val(Datos(3))
        clnombre = Datos(4)
        clcodigoBCCH = Val(Datos(5))
        clcodigoSBIF = Val(Datos(6))
        cldireccion = Datos(7)
        clcomuna = Val(Datos(8))
        clcomunaglosa = Datos(9)
        clciudad = Val(Datos(10))
        clciudadglosa = Datos(11)
        clregion = Val(Datos(12))
        clregionglosa = Datos(13)
        clPais = Val(Datos(14))
        clPaisglosa = Datos(15)
        clfono = Datos(16)
        clfax = Datos(17)
        clchips = Datos(18)
        claba = Datos(19)
        clswift = Datos(20)
        clctacte = Datos(21)
        clctausd = Datos(22)
        clnumsin = Datos(23)
        clnomsin = Datos(24)
        cltipocliente = Val(Datos(25))
      
        LeerSQL = True
        
    End If

End Function

Public Function LeerxRut(lRutCli&, lCodCli&) As Boolean

   LeerxRut = LeerSQL(lRutCli, lCodCli, "", 0, 0, 0)
        
End Function
Public Function LeerxNombre(sNombre$) As Boolean

   LeerxNombre = LeerSQL(0, 0, sNombre, 0, 0, 1)
        
End Function
Public Function Ayuda(sCadena$) As Boolean

    '--- ordenados por Nombre (indica el 1)
    Ayuda = CargaObjetos(BacAyudaSwap.CmbAyuda, sCadena$, 1)
     
End Function

Private Sub Class_Initialize()

    Call Limpiar
    
End Sub
