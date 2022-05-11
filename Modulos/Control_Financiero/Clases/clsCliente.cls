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

Dim sql$, Datos(), i&

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
 
 'Agregado 12-03-2010 RQ3146-RQ5276-RQ5277
 Public clstandard             As String
 Public clbarclays             As String
 Public clcitibank             As String
 
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
 Public clVigente           As String
 Public clcodcli            As Long
 
 Public SourceBac As String
 Public BankDealinkCoded As String
 Public Terminal As String
 Public System As String
 Public SOfData As String
 Public CodigoSwifth As String
 Public PlataformaExterna As Boolean



'*************************************************

Public Function CargaObjetos(obj As Object, sCadena$, iOrden%) As Boolean

    CargaObjetos = False

    
        
    obj.Clear
    
    If Not Bac_Sql_Execute("SP_LEER_CLIENTE ") Then
        Exit Function
    End If
   ''HOLA
    If Bac_SQL_Fetch(Datos()) Then
    End If
        
    Do While Bac_SQL_Fetch(Datos())
        sCadena = Right(Space(15) & Val(Datos(1)) & "-" & Datos(2), 15)
        sCadena = Left(Datos(4) & Space(40), 40) & Space(3) & sCadena
        obj.AddItem sCadena
        obj.ItemData(obj.NewIndex) = Val(Datos(3))
        CargaObjetos = True
    Loop
    
    'Next MISQL.SQL_FETCH(Datos())

End Function


Public Function CargaApoderados(obj As Object, lRutCli&, lCodCli&, Tipo%) As Boolean

    CargaApoderados = False

    Envia = Array()
    AddParam Envia, lRutCli
    AddParam Envia, lCodCli
    
    
    If Tipo = 1 Then
        obj.Clear
    Else
        obj.Rows = 2
    End If
    
    If Not Bac_Sql_Execute("SP_LEER_APODERADO ", Envia) Then
        Exit Function
    End If
    
    Do While Bac_SQL_Fetch(Datos())
        
        If Tipo = 1 Then
        
            obj.AddItem Left(Datos(6) & Space(40), 40) & Space(3) & Left(Datos(7) & Space(40), 40)  '-- Nombre y Cargo
            obj.ItemData(obj.NewIndex) = Val(Datos(4))                                              '-- Rut Apoderado
        Else
            obj.Row = obj.Rows - 1
                                              '- rut
'            If IsNumeric(Val(Datos(4))) And IsNumeric(Val(Datos(5))) Then
'                obj.TextMatrix(obj.Row, 0) = Trim$(Val(Datos(4)) & "-" & Val(Datos(5))) '-dv
'            Else
'                obj.TextMatrix(obj.Row, 0) = "0"
'            End If
'   Modificado para dv = K

            If IsNumeric(Val(Datos(4))) Then
                obj.TextMatrix(obj.Row, 0) = Trim$(Val(Datos(4)) & "-" & CStr(Datos(5))) '-dv
            Else
                obj.TextMatrix(obj.Row, 0) = "0"
            End If
               
            obj.TextMatrix(obj.Row, 1) = UCase(Datos(6))  '- nombre
            obj.TextMatrix(obj.Row, 2) = UCase(Datos(7))  '-cargo
            obj.TextMatrix(obj.Row, 3) = Datos(8) '- fono
            obj.TextMatrix(obj.Row, 5) = Datos(9) ' EMAIL
            obj.TextMatrix(obj.Row, 6) = Datos(10)
            
            obj.Rows = obj.Rows + 1

        End If
    
    Loop
    
    CargaApoderados = True
      
End Function

Public Function CargaOperador(obj As Object, lRutCli&, lCodCli&, Tipo&) As Boolean

    CargaOperador = False

    sql = "sp_Leer_Operador 0," & lRutCli & "," & lCodCli
    Envia = Array()
    AddParam Envia, "0"
    AddParam Envia, lRutCli
    AddParam Envia, lCodCli
    
    
    If Tipo = 1 Then
     obj.Clear
    Else
      obj.Rows = 2
    End If
    
    
    If Not Bac_Sql_Execute("SP_LEER_OPERADOR", Envia) Then
        Exit Function
    End If
    
    Do While Bac_SQL_Fetch(Datos())
        
       If Tipo = 1 Then
        
        obj.AddItem Datos(5)
        obj.ItemData(obj.NewIndex) = Val(Datos(3))
       Else
            obj.Row = obj.Rows - 1
             
            obj.TextMatrix(obj.Row, 0) = Val(Datos(3))
            obj.TextMatrix(obj.Row, 1) = UCase(Datos(5))
            
            obj.Rows = obj.Rows + 1

        End If
                
    Loop

  CargaOperador = True

End Function

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
    
    SourceBac = ""
    BankDealinkCoded = ""
    Terminal = ""
    System = ""
    SOfData = 0
    CodigoSwifth = ""
    PlataformaExterna = False
            
End Sub

Public Function LeerSQL(lRutCli&, lCodCli&, sNombre$, iCodBCCH%, iCodSBIF%, iOrden%) As Boolean

    LeerSQL = False
    
    Envia = Array()
    AddParam Envia, lRutCli
    
           
    If Not Bac_Sql_Execute("SP_LEER_CLIENTEBUS ", Envia) Then
        Exit Function
    End If
            
    Call Limpiar
     
    If Bac_SQL_Fetch(Datos()) Then
        clrut = Val(Datos(1))
        cldv = Datos(2)
        clcodigo = Val(Datos(3))
        clnombre = Datos(4)
        cldirecc = Datos(7)
        clcomuna = Val(Datos(8))
'        clcomunaglosa = Datos(9)
        clciudad = Val(Datos(10))
        'clciudadglosa = Datos(11)
        clregion = Val(Datos(12))
        'clregionglosa = Datos(13)
        clpais = Val(Datos(14))
        'clPaisglosa = Datos(15)
        clfono = Datos(16)
        clfax = Datos(17)
        clchips = Datos(18)
        claba = Datos(19)
        clswift = Datos(20)
        clctacte = Datos(21)
        clctausd = Datos(22)
        'clnumsin = Datos(23)
        'clnomsin = Datos(24)
        cltipocliente = Val(Datos(25))
        'clgenerico = Datos(26)
        clmercado = Datos(27)
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
   Dim Datos()

   LeerPorRut = False
   Envia = Array()
   AddParam Envia, rutcli
   AddParam Envia, codcli
           
   If Not Bac_Sql_Execute("SP_MDCLLEERRUT11 ", Envia) Then
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
      'clcomuna = CDbl(Datos(7))
      clregion = Val(Datos(8))
      'clcompint = Val(Datos(9))
      cltipcli = Val(Datos(9))
      clfecingr = Datos(10)
      clctacte = Datos(11)
      clfono = Datos(12)
      clfax = Datos(13)
      cltipocliente = Val(Datos(14))
      'clcalidadjuridica = Val(Datos(15))
      'clciudad = CDbl(Datos(16))
      'clEntidad = Val(Datos(17))
      clmercado = Val(Datos(18))
      'clGrupo = Val(Datos(19))
      'clapoderado = Datos(20)
      clpais = Val(Datos(21))
      'clcodcli = Val(Datos(22))
      If IsNull(Datos(23)) Then
        clNumSinacofi = ""
      Else
         clNumSinacofi = Datos(23)
      End If
     
      If IsNull(Datos(24)) Then
        clNomSinacofi = ""
       Else
        clNomSinacofi = Datos(24)
      End If
      If IsNull(Datos(25)) Then
        cldatatec = ""
      Else
        cldatatec = Datos(25)
      End If
      If IsNull(Datos(26)) Then
        clbolsa = ""
      Else
         clbolsa = Datos(26)
      End If
      
      'Agregado 12-03-2010 RQ3146-RQ5276-RQ5277
      If IsNull(Datos(27)) Then
        clstandard = ""
      Else
         clstandard = Datos(27)
      End If
      
      If IsNull(Datos(28)) Then
        clbarclays = ""
      Else
         clbarclays = Datos(28)
      End If
       
      If IsNull(Datos(29)) Then
        clcitibank = ""
      Else
         clcitibank = Datos(29)
      End If
      
    BankDealinkCoded = Datos(27)
    SourceBac = Datos(28)
    Terminal = Datos(29)
    System = Datos(30)
    SOfData = Datos(31)
    CodigoSwifth = Datos(32)
    PlataformaExterna = IIf(Datos(33) = "Falso", 0, 1)
    
    
    
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
    AddParam Envia, clnombre
    
    AddParam Envia, SourceBac
    AddParam Envia, BankDealinkCoded
    AddParam Envia, Terminal
    AddParam Envia, System
    AddParam Envia, SOfData
    AddParam Envia, CodigoSwifth
    AddParam Envia, IIf(PlataformaExterna, 1, 0)
    
    If Not Bac_Sql_Execute("SP_SINACOFI_GRABA ", Envia) Then
        Exit Function
    End If

    GrabarSINACOFI = True

End Function
Public Function BorrarSINACOFI() As Boolean

    BorrarSINACOFI = False
    Envia = Array()
    AddParam Envia, clrut
    AddParam Envia, clcodigo
    
    If Not Bac_Sql_Execute("SP_BORRASINACOFIMDCL ", Envia) Then
        Exit Function
    End If

    BorrarSINACOFI = True

End Function



