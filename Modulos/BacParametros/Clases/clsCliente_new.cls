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

Dim sql$, datos(), I&

'MDCL : TABLA DE CLIENTES
'-----------------------------------------------
'*******hola***
'Public clgeneric           As String
'Public cldirecc            As String
'Public clcompint           As String
'Public cltipcli            As String
'Public clfecingr           As String


'**********

'Public clrut            As Long
'Public cldv             As String
'Public clcodigo         As Long
'Public clcodigoBCCH     As Integer
'Public clcodigoSBIF     As Integer
'Public clnombre         As String
'Public clgenerico       As String
'Public cldireccion      As String
'Public clcomuna         As Integer
'Public clcomunaglosa    As String
'Public clciudad         As Integer
'Public clciudadglosa    As String
'Public clregion         As Integer
'Public clregionglosa    As String
'Public clpais           As Integer
'Public clPaisglosa      As String
'Public clfono           As String
'Public clfax            As String
'Public clfecingreso     As Date
'Public clctacte         As String
'Public clctausd         As String
'Public clchips          As String
'Public claba            As String
'Public clswift          As String
'Public cltipocliente    As Integer
'Public clnumsin         As String
'Public clnomsin         As String
'Public clmercado       As Integer
'Public datatec         As string
'public bolsa           as string





'*************************************************
'MDCL : TABLA DE CLIENTES
 '-----------------------------------------------
 
 Public clrut               As String
 Public cldv                As String
 Public clcodigo            As String
 Public clcodigoBCCH As String
 Public clcodigoSBIF As String
 Public clnombre            As String
 Public clgeneric           As String
 Public clnomb              As String
 Public cldatatec           As String
 Public clbolsa             As String
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
 Public clNumSinacofi       As String
 Public clNomSinacofi       As String
 Public mxcontab            As String
 'Public cldatatec           As String
 'Public clbolsa             As String

'*************************************************

Public Function CargaObjetos(obj As Object, sCadena$, iOrden%) As Boolean

    CargaObjetos = False

    
        
    obj.Clear
    
    If Not Bac_Sql_Execute("sp_Leer_Cliente ") Then
        Exit Function
    End If
   ''HOLA
    If Bac_SQL_Fetch(datos()) Then
    End If
        
    Do While Bac_SQL_Fetch(datos())
        sCadena = Right(Space(15) & Val(datos(1)) & "-" & datos(2), 15)
        sCadena = Left(datos(4) & Space(40), 40) & Space(3) & sCadena
        obj.AddItem sCadena
        obj.ItemData(obj.NewIndex) = Val(datos(3))
        CargaObjetos = True
    Loop
    
    'Next MISQL.SQL_FETCH(Datos())

End Function


Public Function CargaApoderados(obj As Object, lRutCli&, lCodCli&, tipo%) As Boolean

    CargaApoderados = False

    Envia = Array()
    AddParam Envia, lRutCli
    AddParam Envia, lCodCli
    
    
    If tipo = 1 Then
        obj.Clear
    Else
        obj.Rows = 2
    End If
    
    If Not Bac_Sql_Execute("sp_Leer_Apoderado ", Envia) Then
        Exit Function
    End If
    
    Do While Bac_SQL_Fetch(datos())
        
        If tipo = 1 Then
        
            obj.AddItem Left(datos(6) & Space(40), 40) & Space(3) & Left(datos(7) & Space(40), 40)  '-- Nombre y Cargo
            obj.ItemData(obj.NewIndex) = Val(datos(4))                                              '-- Rut Apoderado
        Else
            obj.Row = obj.Rows - 1
                                              '- rut
            If IsNumeric(Val(datos(4))) And IsNumeric(Val(datos(5))) Then
                obj.TextMatrix(obj.Row, 0) = Trim$(Val(datos(4)) & "-" & Val(datos(5))) '-dv
            Else
                obj.TextMatrix(obj.Row, 0) = "0"
            End If
               
            obj.TextMatrix(obj.Row, 1) = UCase(datos(6))  '- nombre
            obj.TextMatrix(obj.Row, 2) = UCase(datos(7))  '-cargo
            obj.TextMatrix(obj.Row, 3) = datos(8) '- fono
            obj.TextMatrix(obj.Row, 5) = datos(9) ' EMAIL
            obj.Rows = obj.Rows + 1

        End If
    
    Loop
    
    CargaApoderados = True
      
End Function

Public Function CargaOperador(obj As Object, lRutCli&, lCodCli&, tipo&) As Boolean

    CargaOperador = False

    sql = "sp_Leer_Operador 0," & lRutCli & "," & lCodCli
    Envia = Array()
    AddParam Envia, "0"
    AddParam Envia, lRutCli
    AddParam Envia, lCodCli
    
    
    If tipo = 1 Then
     obj.Clear
    Else
      obj.Rows = 2
    End If
    
    
    If Not Bac_Sql_Execute("sp_Leer_Operador", Envia) Then
        Exit Function
    End If
    
    Do While Bac_SQL_Fetch(datos())
        
       If tipo = 1 Then
        
        obj.AddItem datos(5)
        obj.ItemData(obj.NewIndex) = Val(datos(3))
       Else
            obj.Row = obj.Rows - 1
             
            obj.TextMatrix(obj.Row, 0) = Val(datos(3))
            obj.TextMatrix(obj.Row, 1) = UCase(datos(5))
            
            obj.Rows = obj.Rows + 1

        End If
                
    Loop

  CargaOperador = True

End Function

''''Public Function Eliminar(lRut&, lCodigo&) As Boolean
''''
''''    'Sql = "EXECUTE " & giSQL_DatabaseCommon & ".."
''''    Sql = "sp_Borrar_Cliente " & lRut & "," & lCodigo
''''
''''    Eliminar = (MISQL.SQL_Execute(Sql) = 0)
''''
''''    If MISQL.SQL_Fetch(Datos()) = 0 Then
''''        If Val(Datos(1)) < 0 Then
''''            MsgBox Datos(2), vbCritical, Msj
''''            Eliminar = False
''''        End If
''''    End If
''''
''''End Function


 Private Sub Limpiar()

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
            cldatatec = ""
            clbolsa = ""
            mxcontab = 0
End Sub

Public Function LeerSQL(lRutCli&, lCodCli&, sNombre$, iCodBCCH%, iCodSBIF%, iOrden%) As Boolean

    LeerSQL = False
    
    Envia = Array()
    AddParam Envia, lRutCli
    
           
    If Not Bac_Sql_Execute("sp_Leer_Clientebus ", Envia) Then
        Exit Function
    End If
            
    Call Limpiar
     
    If Bac_SQL_Fetch(datos()) Then
        clrut = Val(datos(1))
        cldv = datos(2)
        clcodigo = Val(datos(3))
        clnombre = datos(4)
        cldirecc = datos(7)
        clcomuna = Val(datos(8))
'        clcomunaglosa = Datos(9)
        clciudad = Val(datos(10))
        'clciudadglosa = Datos(11)
        clregion = Val(datos(12))
        'clregionglosa = Datos(13)
        clpais = Val(datos(14))
        'clPaisglosa = Datos(15)
        clfono = datos(16)
        clfax = datos(17)
        clchips = datos(18)
        claba = datos(19)
        clswift = datos(20)
        clctacte = datos(21)
        clctausd = datos(22)
        'clnumsin = Datos(23)
        'clnomsin = Datos(24)
        cltipocliente = Val(datos(25))
        'clgenerico = Datos(26)
        clmercado = datos(27)
   End If
      
        LeerSQL = True
          

End Function

Public Function LeerxRut(lRutCli&, lCodCli&) As Boolean

   LeerxRut = LeerSQL(lRutCli, lCodCli, "", 0, 0, 0)
        
End Function
Public Function LeerxCodigo(lCodCli&) As Boolean

   LeerxCodigo = LeerSQL(0, lCodCli, "", 0, 0, 0)
        
End Function

Public Function LeerxNombre(sNombre$) As Boolean

   LeerxNombre = LeerSQL(0, 0, sNombre, 0, 0, 1)
        
End Function
Public Function Ayuda(sCadena$) As Boolean

    '--- ordenados por Nombre (indica el 1)
       
    
    Ayuda = CargaObjetos(BacAyuda.lstNombre, sCadena$, 1)
    
    If Ayuda Then
           'BacAyuda.Tag = "Cliente"
    Else
        MsgBox "No se encontraron Clientes para Ayudarle", vbInformation, TITSISTEMA
    End If
     
End Function

Private Sub Class_Initialize()

    Call Limpiar
    
End Sub
Public Function LeerPorRut(rutcli As Long, codcli As Long) As Boolean

   Dim sql           As String
   Dim datos()

   LeerPorRut = False
   Envia = Array()
   AddParam Envia, rutcli
   AddParam Envia, codcli
           
   If Not Bac_Sql_Execute("sp_mdclleerrut1 ", Envia) Then
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
      'clcomuna = CDbl(Datos(7))
      clregion = Val(datos(8))
      'clcompint = Val(Datos(9))
      cltipcli = Val(datos(9))
      clfecingr = datos(10)
      clctacte = datos(11)
      clfono = datos(12)
      clfax = datos(13)
      cltipocliente = Val(datos(14))
      'clcalidadjuridica = Val(Datos(15))
      'clciudad = CDbl(Datos(16))
      'clEntidad = Val(Datos(17))
      clmercado = Val(datos(18))
      'clGrupo = Val(Datos(19))
      'clapoderado = Datos(20)
      clpais = Val(datos(21))
      'clcodcli = Val(Datos(22))
      If IsNull(datos(23)) Then
        clNumSinacofi = ""
      Else
         clNumSinacofi = datos(23)
      End If
     
      If IsNull(datos(24)) Then
        clNomSinacofi = ""
       Else
        clNomSinacofi = datos(24)
      End If
      If IsNull(datos(25)) Then
        cldatatec = ""
      Else
        cldatatec = datos(25)
      End If
      If IsNull(datos(26)) Then
        clbolsa = ""
      Else
         clbolsa = datos(26)
      End If
      LeerPorRut = True
      
   End If
 
End Function

Public Function GrabarSINACOFI() As Boolean

    GrabarSINACOFI = False

    Envia = Array()
    AddParam Envia, Val(clrut)
    AddParam Envia, Val(clcodigo)
    AddParam Envia, clNumSinacofi
    AddParam Envia, clNomSinacofi
    AddParam Envia, cldatatec
    AddParam Envia, clbolsa
    
    If Not Bac_Sql_Execute("sp_sinacofi_graba ", Envia) Then
        Exit Function
    End If

    GrabarSINACOFI = True

End Function
Public Function BorrarSINACOFI() As Boolean

    BorrarSINACOFI = False
    Envia = Array()
    AddParam Envia, clrut
    AddParam Envia, clcodigo
    
    If Not Bac_Sql_Execute("sp_BorraSinacofiMDCL ", Envia) Then
        Exit Function
    End If

    BorrarSINACOFI = True

End Function



