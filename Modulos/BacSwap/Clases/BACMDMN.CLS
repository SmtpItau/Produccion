VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsMoneda"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Dim Sql$, Datos()

Public mncodigo     As Integer
Public mnnemo       As String
Public mnsimbol     As String
Public mnglosa      As String
Public mncodsuper   As String
Public mnnemsuper   As String
Public mncodbanco   As Integer
Public mnnembanco   As String
Public mnbase       As Integer
Public mnredondeo   As Integer
Public mndecimal    As Integer
Public mncodpais    As Integer
Public mnrrda       As String
Public mnfactor     As Integer
Public mnrefusd     As String
Public mnlocal      As String
Public mnextranj    As String
Public mnvalor      As String
Public mnrefmerc    As String
Public mningval     As Integer
Public mntipmon     As String
Public mnperiodo    As Integer
Public mnmx         As String

Public vmValor      As Double

'Trae datos de una moneda
Public Function LeerSQL(codigo%, glosa$, Nemo$, Simbol$, TipoMoneda$) As Boolean
    
   LeerSQL = False

   Sql = "EXECUTE " & giSQL_DatabaseCommon & ".."
   Sql = Sql & "sp_Leer_Moneda " & codigo
   Sql = Sql & ",'" & glosa & "'"
   Sql = Sql & ",'" & Nemo & "'"
   Sql = Sql & ",'" & Simbol & "'"
   Sql = Sql & ",'" & TipoMoneda & "'"

   If SQL_Execute(Sql) > 0 Then
      Exit Function
   End If

   Call Limpiar
   
   If SQL_Fetch(Datos()) = 0 Then
   
        mncodigo = Val(Datos(1))
        mnnemo = Datos(2)
        mnsimbol = Datos(3)
        mnglosa = Datos(4)
        mncodsuper = Datos(5)
        mnnemsuper = Datos(6)
        mncodbanco = Val(Datos(7))
        mnnembanco = Datos(8)
        mnbase = Val(Datos(9))
        mnredondeo = Val(Datos(10))
        mndecimal = Val(Datos(11))
        mncodpais = Val(Datos(12))
        mnrrda = Datos(13)
        mnfactor = Val(Datos(14))
        mnrefusd = Datos(15)
        mnlocal = Datos(16)
        mnextranj = Datos(17)
        mnvalor = Datos(18)
        mnrefmerc = Datos(19)
        mningval = Val(Datos(20))
        mntipmon = Datos(21)
        mnperiodo = Val(Datos(22))
        mnmx = Datos(23)
        vmValor = ValorMoneda(mncodigo, gsBAC_Fecp)
      
        LeerSQL = True

   End If

End Function

Public Sub Limpiar()

    mncodigo = 0
    mnnemo = ""
    mnsimbol = ""
    mnglosa = ""
    mncodsuper = ""
    mnnemsuper = ""
    mncodbanco = 0
    mnnembanco = ""
    mnbase = 0
    mnredondeo = 0
    mndecimal = 0
    mncodpais = 0
    mnrrda = ""
    mnfactor = 0
    mnrefusd = ""
    mnlocal = ""
    mnextranj = ""
    mnvalor = ""
    mnrefmerc = ""
    mningval = 0
    mntipmon = ""
    mnperiodo = 0
    mnmx = ""
    
    vmValor = 0#

End Sub

Public Function LeerxCodigo(codigo%) As Boolean

    LeerxCodigo = LeerSQL(codigo%, "", "", "", "")

End Function

Public Function LeerxGlosa(glosa$) As Boolean

    LeerxGlosa = LeerSQL(0, glosa$, "", "", "")

End Function

Public Function LeerxNemo(Nemo$) As Boolean

    LeerxNemo = LeerSQL(0, "", Nemo$, "", "")

End Function

Public Function LeerxSimbol(Simbol$) As Boolean

    LeerxSimbol = LeerSQL(0, "", "", Simbol$, "")

End Function

Public Function LeerxTipoMoneda(TipoMoneda$) As Boolean

    LeerxTipoMoneda = LeerSQL(0, "", "", "", TipoMoneda$)

End Function

Public Function CargaxProducto(iProd%, obj As Object) As Boolean

    CargaxProducto = False

    Sql = "EXECUTE " & giSQL_DatabaseCommon & ".."
    Sql = Sql & "sp_Leer_MonedaProducto " & iProd & ", 0"
     
    If SQL_Execute(Sql) > 0 Then
       Exit Function
    End If
    
    obj.Clear
    
    Do While SQL_Fetch(Datos()) = 0
         obj.AddItem Datos(4)
         obj.ItemData(obj.NewIndex) = Val(Datos(3))
         CargaxProducto = True
    Loop

End Function

Public Function CargaTasas(iMoneda%, obj As Object) As Boolean

    CargaTasas = False

    Sql = "EXECUTE " & giSQL_DatabaseCommon & ".."
    Sql = Sql & "sp_Leer_TasasMonedas " & iMoneda
    Sql = Sql & ", 0, 0, '" & FechaYMD(gsBAC_Fecp) & "'"
     
    If SQL_Execute(Sql) > 0 Then
       Exit Function
    End If
    
    obj.Clear
    
    Do While SQL_Fetch(Datos()) = 0
        If bacBuscarCombo(obj, Val(Datos(3))) < 0 Then
            obj.AddItem Datos(4)
            obj.ItemData(obj.NewIndex) = Val(Datos(3))
            CargaTasas = True
        End If
    Loop

End Function

Public Function CargaBases(obj As Object) As Boolean

    CargaBases = False

    Sql = "EXECUTE " & giSQL_DatabaseCommon & ".."
    Sql = Sql & "sp_Leer_TC 11"
     
    If SQL_Execute(Sql) > 0 Then
       Exit Function
    End If
    
    obj.Clear
    
    Do While SQL_Fetch(Datos()) = 0
        obj.AddItem Datos(3)
        obj.ItemData(obj.NewIndex) = Val(Datos(2))
        CargaBases = True
    Loop

End Function

Public Function ValorMoneda(codigo%, fecha$, Optional ValorDefault) As Double

   ValorMoneda = 0#
   
   If Not IsMissing(ValorDefault) Then
       ValorMoneda = ValorDefault
   End If

   Sql = "EXECUTE " & giSQL_DatabaseCommon & ".."
   Sql = Sql & "sp_Leer_ValorMoneda " & codigo
   Sql = Sql & ",'" & Format(fecha, "yyyymmdd") & "'"

   If SQL_Execute(Sql) > 0 Then
      Exit Function
   End If

   If SQL_Fetch(Datos()) = 0 Then
        ValorMoneda = Val(Datos(2))
   End If
   
End Function
