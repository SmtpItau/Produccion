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

Dim SQL$, Datos(), i&

'MDCL : TABLA DE CLIENTES
'-----------------------------------------------
Public clrut            As Long
Public cldv             As String
Public clcodigo         As Long
Public clcodigoBCCH     As Integer
Public clcodigoSBIF     As Integer
Public clnombre         As String
Public clgenerico       As String
Public cldireccion      As String
Public clcomuna         As Long
Public clcomunaglosa    As String
Public clciudad         As Long
Public clciudadglosa    As String
Public clregion         As Integer
Public clregionglosa    As String
Public clPais           As Integer
Public clPaisglosa      As String
Public clfono           As String
Public clfax            As String
Public clfecingreso     As Date
Public clctacte         As String
Public clctausd         As String
Public clchips          As String
Public claba            As String
Public clswift          As String
Public cltipocliente    As Integer
Public clnumsin         As String
Public clnomsin         As String
Public clnotaria         As String
Public clfecha_escritura         As String
Public clfecha_cond_generales As String
Public clUtilizaNuevoCgg As Boolean
Public clFechaNuevoCgg   As String
Public clcodcli As String
'PROD-10967
Public clMetodologia_LCR As Integer
Public clThreshold As Double
'PROD-10967

Public clvigente                As String   '-> Se agrega para la validacion Comder PRD-19111 //
Public clComDer                 As String   '-> Se agrega para Validacion Comder PRD-19111 //



Public Function leeClientePorTipo(sCadena$, tipo) As Boolean

    leeClientePorTipo = CargaObjetos(BacAyudaSwap.CmbAyuda, sCadena$, 1, tipo)
    
    If leeClientePorTipo Then
        BacAyudaSwap.Tag = "Cliente"
    Else
        MsgBox "No se encontraron Clientes para Ayuda", vbInformation, "Ayuda de Clientes"
    End If

End Function


Public Function Func_LeeClienteContratoImpreso(sCadena$) As Boolean

    Func_LeeClienteContratoImpreso = CargaClienteContratoImpreso(BacAyudaSwap.CmbAyuda, sCadena$)
    
    If Func_LeeClienteContratoImpreso Then
        BacAyudaSwap.Tag = "CliContrato"
    Else
        MsgBox "No se encontraron Clientes para Ayuda", vbInformation, "Ayuda de Clientes"
    End If

End Function

Public Function LeerPais(nPais As Integer) As Integer
   
   Dim Datos()

   LeerPais = 1

   If Not Bac_Sql_Execute("BacFwdSuda.dbo.SP_MDCLBUSCAPAIS", Array(CDbl(nPais))) Then
      
      Exit Function
   
   End If

   If Bac_SQL_Fetch(Datos()) Then
      
      LeerPais = Datos(1)
   
   End If

End Function


Public Function LeerPorRut(ByVal nRutCliente As Long, ByVal nCodCliente As Long, ByVal nTipCliente As Long) As Boolean
    Dim Datos()

    Let LeerPorRut = False
    
    Envia = Array()
    AddParam Envia, nRutCliente
    AddParam Envia, nCodCliente
    AddParam Envia, nTipCliente
          
    If Not Bac_Sql_Execute("BacFwdSuda.dbo.SP_MDCLLEERRUT", Envia) Then
        Call MsgBox("Error en Sql (BacFwdSuda.dbo.SP_MDCLLEERRUT)", vbExclamation, App.Title)
        Exit Function
    End If
    If Bac_SQL_Fetch(Datos()) Then
        Let clvigente = Datos(33)
        Let clComDer = Datos(36)
        Let clPais = Datos(21)
        
        Let LeerPorRut = True
    End If
 
End Function

Public Function leepornombre(cadena As String) As Boolean

'Para Ayuda DE SWAP

Dim SQL           As String
Dim Datos()
Dim J As String


   leepornombre = False
    
   SQL = "exec " & giSQL_DatabaseCommon & "..SP_MDCLPORNOMBRE "
           
   If MISQL.SQL_Execute(SQL) <> 0 Then
      Exit Function
   End If
       
       
   Dim idRut   As String * 11
   Dim IdGlosa As String * 45 '40
      
   With BacAyudaSwap
   J = 1
   Do While MISQL.SQL_Fetch(Datos()) = 0
   
        idRut = Val(Datos(1)) & "-" & Datos(2)
        IdGlosa = Datos(4)
        .CmbAyuda.AddItem IdGlosa & Space(3) & idRut
        .CmbAyuda.ItemData(.CmbAyuda.NewIndex) = Val(Datos(3))
   
   Loop
   End With
   
   leepornombre = True
  
End Function


Public Function CargaObjetos(obj As Object, sCadena$, iOrden%, TipCli) As Boolean

    CargaObjetos = False

    Envia = Array()
    AddParam Envia, CDbl(0)
    AddParam Envia, CDbl(0)
    AddParam Envia, CDbl(TipCli)
    AddParam Envia, sCadena
    
    obj.Clear

    If Not Bac_Sql_Execute("SP_LEER_CLIENTE", Envia) Then
       Exit Function
    End If
    
    Do While Bac_SQL_Fetch(Datos())
        sCadena = Right(Space(15) & Val(Datos(1)) & "-" & Datos(2), 15)
        sCadena = Left(Datos(4) & Space(40), 40) & Space(3) & sCadena
        obj.AddItem sCadena
        obj.ItemData(obj.NewIndex) = Val(Datos(3))
        CargaObjetos = True
    Loop

End Function

Public Function CargaClienteContratoImpreso(obj As Object, sCadena$) As Boolean

    CargaClienteContratoImpreso = False

    Envia = Array()
    AddParam Envia, -999
    AddParam Envia, -999
    AddParam Envia, sCadena
    
    obj.Clear

    If Not Bac_Sql_Execute("SP_CON_AYUDA_CONTRATO_IMPRESO", Envia) Then
       Exit Function
    End If
    
    Do While Bac_SQL_Fetch(Datos())
        sCadena = Right(Space(15) & Val(Datos(1)) & "-" & Datos(4), 15)
        sCadena = Left(Datos(3) & Space(40), 40) & Space(3) & sCadena
        obj.AddItem sCadena
        obj.ItemData(obj.NewIndex) = Val(Datos(2))
        CargaClienteContratoImpreso = True
    Loop

End Function

Public Function CargaApoderados(obj As Object, lRutCli&, lCodCli&) As Boolean

    CargaApoderados = False

    Envia = Array()
    AddParam Envia, CDbl(lRutCli)
    AddParam Envia, CDbl(lCodCli)
'    AddParam Envia, CDbl(0)

    obj.Clear
    
    If Not Bac_Sql_Execute("SP_MDAPLEERRUT", Envia) Then
        Exit Function
    End If
    
    Do While Bac_SQL_Fetch(Datos())
        obj.AddItem Left(UCase(Datos(3)), 55) & Space(55) & Datos(2)
        obj.ItemData(obj.NewIndex) = Datos(1) '-- Rut Apoderado
        
        If lRutCli& = gsBAC_Rut Then
            On Error Resume Next
             ReDim Preserve vFechasEscrituras((obj.ListCount - 1))
             On Error GoTo 0
             vFechasEscrituras(obj.NewIndex) = Datos(6)
        End If
        CargaApoderados = True
    Loop

End Function
Public Function CargaOperador(obj As Object, lRutCli, lCodCli) As Boolean

    CargaOperador = False

    Envia = Array()
    AddParam Envia, CDbl(0)
    AddParam Envia, CDbl(lRutCli)
    AddParam Envia, CDbl(lCodCli)
    
    obj.Clear
    
    If Not Bac_Sql_Execute("SP_LEER_OPERADOR", Envia) Then
        Exit Function
    End If
    
    Do While Bac_SQL_Fetch(Datos())
        obj.AddItem Datos(5)
        obj.ItemData(obj.NewIndex) = Val(Datos(3))
        CargaOperador = True
    Loop

End Function

Public Function Eliminar(lRut&, lCodigo&) As Boolean

    Envia = Array()
    AddParam Envia, CDbl(lRut)
    AddParam Envia, CDbl(lCodigo)
    
    Eliminar = (Bac_Sql_Execute("SP_BORRAR_CLIENTE", Envia))
    
    If Bac_SQL_Fetch(Datos()) Then
        If Val(Datos(1)) < 0 Then
            MsgBox Datos(2), vbCritical, Msj
            Eliminar = False
        End If
    End If

End Function

Public Function Grabar() As Boolean

        
    Envia = Array()
    AddParam Envia, CDbl(clrut)
    AddParam Envia, cldv
    AddParam Envia, clcodigo
    AddParam Envia, clcodigoBCCH
    AddParam Envia, clcodigoSBIF
    AddParam Envia, clnombre
    AddParam Envia, clgenerico
    AddParam Envia, cldireccion
    AddParam Envia, clcomuna
    AddParam Envia, clciudad
    AddParam Envia, clregion
    AddParam Envia, clPais
    AddParam Envia, clfono
    AddParam Envia, clfax
    AddParam Envia, FechaYMD(clfecingreso)
    AddParam Envia, clctacte
    AddParam Envia, clctausd
    AddParam Envia, clchips
    AddParam Envia, claba
    AddParam Envia, clswift
    AddParam Envia, cltipocliente
    AddParam Envia, clnumsin
    AddParam Envia, clnomsin
        
    
'    Grabar = (MISQL.SQL_Execute(Sql) = 0)
    Grabar = (Bac_Sql_Execute("SP_GRABAR_CLIENTE", Envia))
    
'    If MISQL.SQL_Fetch(DATOS) = 0 Then
    If Bac_SQL_Fetch(Datos()) Then
        If Val(Datos(1)) < 0 Then
           MsgBox Datos(2), vbCritical, Msj
           Grabar = False
        End If
    End If

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
     
    Envia = Array()
    AddParam Envia, CDbl(lRutCli)
    AddParam Envia, CDbl(lCodCli)
    AddParam Envia, -1
    AddParam Envia, sNombre
    
    If Not Bac_Sql_Execute("SP_LEER_CLIENTE", Envia) Then
        Exit Function
    End If
            
    Call Limpiar
     
    If Bac_SQL_Fetch(Datos()) Then
    
        clrut = Val(Datos(1))
        cldv = Datos(2)
        clcodigo = Val(Datos(3))
        clnombre = UCase(Datos(4))
        
        cldireccion = UCase(Datos(5))
        clcomuna = Val(Datos(6))
        clfono = Datos(8)
        clfax = Datos(9)
        cltipocliente = Val(Datos(10))
        clciudad = Datos(11)
        clregion = Val(Datos(12))
        clPais = Val(Datos(13))
        clfecha_escritura = Datos(14)
        clnotaria = Datos(15)
        clfecha_cond_generales = Datos(16)
        clciudadglosa = Datos(18)
        clcomunaglosa = Datos(17)
        clUtilizaNuevoCgg = IIf(Datos(19) = "S", True, False)
        clFechaNuevoCgg = Datos(20)

        'PROD-10967
        clThreshold = Datos(21)
        clMetodologia_LCR = Datos(22)
        'PROD-10967

        LeerSQL = True
        
    End If

End Function

Public Function LeerSQLDV(lRutCli&, lCodCli&, sNombre$, iCodBCCH%, iCodSBIF%, iOrden%) As String
'prd19111 ini

    LeerSQLDV = ""
     
    Envia = Array()
    AddParam Envia, CDbl(lRutCli)
    AddParam Envia, CDbl(lCodCli)
    AddParam Envia, -1
    AddParam Envia, sNombre
    
    If Not Bac_Sql_Execute("SP_LEER_CLIENTE", Envia) Then
        Exit Function
    End If
            
    'Call Limpiar
     
    If Bac_SQL_Fetch(Datos()) Then
    
        clrut = Val(Datos(1))
        cldv = Datos(2)
        clcodigo = Val(Datos(3))
        clnombre = UCase(Datos(4))
        
        cldireccion = UCase(Datos(5))
        clcomuna = Val(Datos(6))
        clfono = Datos(8)
        clfax = Datos(9)
        cltipocliente = Val(Datos(10))
        clciudad = Datos(11)
        clregion = Val(Datos(12))
        clPais = Val(Datos(13))
        clfecha_escritura = Datos(14)
        clnotaria = Datos(15)
        clfecha_cond_generales = Datos(16)
        clciudadglosa = Datos(18)
        clcomunaglosa = Datos(17)
        clUtilizaNuevoCgg = IIf(Datos(19) = "S", True, False)
        clFechaNuevoCgg = Datos(20)

        'PROD-10967
        clThreshold = Datos(21)
        clMetodologia_LCR = Datos(22)
        'PROD-10967

        LeerSQLDV = cldv
        
    End If
'prd19111 fin
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
    Ayuda = CargaObjetos(BacAyudaSwap.CmbAyuda, sCadena$, 1, -1)
    
    If Ayuda Then
        BacAyudaSwap.Tag = "Cliente"
    Else
        MsgBox "No se encontraron Clientes para Ayudarle", vbInformation, "Ayuda de Clientes"
    End If
     
End Function

Private Sub Class_Initialize()

    Call Limpiar
    
End Sub

