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

Dim Sql$, Datos(), I&

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
 Public clcodcli            As String
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
 Public clCuenta_Dcv        As String
 Public clnombre_datatec    As String

'*************************************************

Public Function CargaObjetos(obj As Object, sCadena$, iOrden%) As Boolean

    CargaObjetos = False
    
    obj.Clear
    
    If BAC_Parametros.ActiveForm.Name = "BacMntClie" Then
    
      If BacMntClie.Tag <> "MATRIZ" Then
        If Not BAC_SQL_EXECUTE("sp_Leer_Cliente ") Then
           Exit Function
        End If
      Else
        If Not BAC_SQL_EXECUTE("Sp_Ayuda_Clientes ") Then
           Exit Function
        End If
      End If
    ElseIf BAC_Parametros.ActiveForm.Name = "BacMntApoderado" Then
        If Not BAC_SQL_EXECUTE("sp_Leer_Cliente", Array("APODERADOS")) Then
           Exit Function
        End If
    ElseIf BAC_Parametros.ActiveForm.Name = "BacMntOperador" Then
        If Not BAC_SQL_EXECUTE("sp_Leer_Cliente", Array("OPERADORES")) Then
           Exit Function
        End If
    Else
        If Not BAC_SQL_EXECUTE("sp_Leer_Cliente") Then
           Exit Function
        End If
    End If
        
    Do While BAC_SQL_FETCH(Datos())
        sCadena = Right(Space(15) & Val(Datos(1)) & "-" & Datos(2), 15)
        sCadena = Left(Datos(4) & Space(40), 40) & Space(3) & sCadena
        obj.AddItem sCadena
        obj.ItemData(obj.NewIndex) = Val(Datos(3))
        CargaObjetos = True
    Loop
    

End Function


Public Function CargaObjetosBancos(obj As Object, sCadena$, iOrden%) As Boolean

    CargaObjetosBancos = False
    
    obj.Clear
    
    If Not BAC_SQL_EXECUTE("Sp_Leer_Cliente_Bancos ") Then
        Exit Function
    End If
        
    Do While BAC_SQL_FETCH(Datos())
        sCadena = Right(Space(15) & Val(Datos(1)) & "-" & Datos(2), 15)
        sCadena = Left(Datos(4) & Space(40), 40) & Space(3) & sCadena
        obj.AddItem sCadena
        obj.ItemData(obj.NewIndex) = Val(Datos(3))
        CargaObjetosBancos = True
    Loop

End Function


Public Function CargaApoderados(obj As Object, lRutCli&, lCodCli&, tipo%) As Boolean

    CargaApoderados = False

    Envia = Array()
    AddParam Envia, lRutCli
    AddParam Envia, lCodCli
    
    If tipo = 1 Then
        obj.Clear
    Else
        obj.Rows = obj.FixedRows
    End If
    
    If Not BAC_SQL_EXECUTE("sp_Leer_Apoderado ", Envia) Then
        Exit Function
    End If
    
    If tipo = 1 Then
       Do While BAC_SQL_FETCH(Datos())
            obj.AddItem Left(Datos(6) & Space(40), 40) & Space(3) & Left(Datos(7) & Space(40), 40)  '-- Nombre y Cargo
            obj.ItemData(obj.NewIndex) = Val(Datos(4))                                              '-- Rut Apoderado
       Loop
       CargaApoderados = True
    Else
        obj.Rows = obj.FixedRows
        Do While BAC_SQL_FETCH(Datos())
            'obj.Rows = obj.FixedRows
            
            obj.Rows = obj.Rows + 1
            obj.Row = obj.Rows - 1
                                              '- rut
            If IsNumeric(Val(Datos(4))) And IsNumeric(Val(Datos(5))) Then
                obj.TextMatrix(obj.Row, 0) = Val(Datos(4)) 'Trim$( Val(Datos(4)) & "-" & Val(Datos(5))) '-dv
            Else
                obj.TextMatrix(obj.Row, 0) = "0"
            End If
               
            obj.TextMatrix(obj.Row, 1) = UCase(Datos(5))  '- Dv
            obj.TextMatrix(obj.Row, 2) = UCase(Datos(6))  '- nombre
            obj.TextMatrix(obj.Row, 3) = UCase(Datos(7))  '-cargo
            obj.TextMatrix(obj.Row, 4) = Datos(8) '- fono
            obj.TextMatrix(obj.Row, 6) = Datos(9) '- eMail
            CargaApoderados = True
      Loop

    End If
        
    
      
End Function

Public Function CargaOperador(obj As Object, lRutCli&, lCodCli&, tipo&) As Boolean

    CargaOperador = False

    Sql = "sp_Leer_Operador 0," & lRutCli & "," & lCodCli
    Envia = Array()
    AddParam Envia, "0"
    AddParam Envia, lRutCli
    AddParam Envia, lCodCli
    
    
    If tipo = 1 Then
     obj.Clear
    Else
      obj.Rows = 2
      obj.RowHeight(obj.Rows - 1) = 345
    End If
    
    
    If Not BAC_SQL_EXECUTE("sp_Leer_Operador", Envia) Then
        Exit Function
    End If
    
    Do While BAC_SQL_FETCH(Datos())
        
       If tipo = 1 Then
        
        obj.AddItem Datos(5)
        obj.ItemData(obj.NewIndex) = Val(Datos(3))
       Else
            obj.Row = obj.Rows - 1
            obj.RowHeight(obj.Row) = 345
            obj.TextMatrix(obj.Row, 0) = Val(Datos(3))
            obj.TextMatrix(obj.Row, 1) = UCase(Datos(5))
            
            obj.Rows = obj.Rows + 1
            obj.RowHeight(obj.Rows - 1) = 345
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
            clCuenta_Dcv = ""
End Sub

Public Function LeerSQL(lRutCli As Double, lCodCli&, sNombre$, iCodBCCH%, iCodSBIF%, iOrden%) As Boolean

    LeerSQL = False
    


    Envia = Array()
    AddParam Envia, lRutCli
    AddParam Envia, lCodCli&
    
           
    
    If Not BAC_SQL_EXECUTE("sp_Leer_Clientebus ", Envia) Then
        Exit Function
    End If
            
    Call Limpiar
     
    If BAC_SQL_FETCH(Datos()) Then
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

Public Function LeerxRut(lRutCli As Double, lCodCli&) As Boolean

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
       
    
    'Ayuda = CargaObjetos(BacAyuda.lstNombre, sCadena$, 1)
    
    If Ayuda Then
           'MiTag = "Cliente"
    Else
        MsgBox "No se encontraron Clientes para Ayudarle", vbInformation
    End If
     
End Function

Public Function AyudaBancos(sCadena$) As Boolean

    'AyudaBancos = CargaObjetosBancos(BacAyuda.lstNombre, sCadena$, 1)
    
    If AyudaBancos Then
           'MiTag = "Cliente"
    Else
        MsgBox "No se encontraron Clientes para Ayudarle", vbInformation
    End If


End Function

Private Sub Class_Initialize()

    Call Limpiar
    
End Sub
Public Function LeerPorRut(rutcli As Long, codcli As Long) As Boolean

   Dim Sql           As String
   Dim Datos()

   LeerPorRut = False
   Envia = Array()
   AddParam Envia, rutcli
   AddParam Envia, codcli
           
   If Not BAC_SQL_EXECUTE("sp_mdclleerrut1 ", Envia) Then
      Exit Function

   End If
       
   Call Limpiar
    
   If BAC_SQL_FETCH(Datos()) Then
      clrut = Val(Datos(1))
      cldv = Datos(2)
      clcodigo = Val(Datos(3))
      clnombre = Datos(4)
      clgeneric = Datos(5)
      cldirecc = Datos(6)
      clcomuna = CDbl(Datos(7))
      clregion = Val(Datos(8))
      clfecingr = Datos(9)
      clctacte = Datos(10)
      clfono = Datos(11)
      clfax = Datos(12)
      cltipocliente = Val(Datos(13))
      clcalidadjuridica = Val(Datos(14))
      clciudad = CDbl(Datos(15))
      clmercado = Val(Datos(16))
      clpais = Val(Datos(17))
      clcodcli = Val(Datos(18))
      clNumSinacofi = Datos(19)
      clNomSinacofi = Datos(20)
      cldatatec = Datos(21)
      clbolsa = Datos(22)
      clCuenta_Dcv = Datos(23)
      clnombre_datatec = Datos(24)
      LeerPorRut = True
      
   End If
 
End Function

Public Function GrabarSINACOFI() As Boolean

    GrabarSINACOFI = False

    Envia = Array()
    AddParam Envia, clrut
    AddParam Envia, clcodigo
    AddParam Envia, clNumSinacofi
    AddParam Envia, clNomSinacofi
    AddParam Envia, cldatatec
    AddParam Envia, clbolsa
    AddParam Envia, clCuenta_Dcv
    AddParam Envia, clnombre_datatec
    
    If Not BAC_SQL_EXECUTE("sp_sinacofi_graba ", Envia) Then
        Exit Function
    End If

    GrabarSINACOFI = True

End Function
Public Function BorrarSINACOFI() As Boolean

    BorrarSINACOFI = False
    Envia = Array()
    AddParam Envia, clrut
    AddParam Envia, clcodigo
    
    If Not BAC_SQL_EXECUTE("sp_BorraSinacofiMDCL ", Envia) Then
        Exit Function
    End If

    BorrarSINACOFI = True

End Function



