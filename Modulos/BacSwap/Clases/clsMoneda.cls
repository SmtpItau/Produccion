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

Dim Sql$
Dim Datos()
Dim i&

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

Public Function Ayuda(sTipo$) As Boolean
   Ayuda = CargaObjectos(BacAyudaSwap.CmbAyuda, sTipo$)
   
   If Not Ayuda Then
      MsgBox "No es posible cargar información de Ayuda", vbExclamation, "Ayuda de Monedas"
   Else
      BacAyudaSwap.Tag = "Moneda"
   End If
End Function

'Trae datos de una moneda
Public Function LeerSQL(Codigo%, Glosa$, Nemo$, Simbol$, TipoMoneda$, Pagadora$) As Boolean
    
   LeerSQL = False

   Envia = Array()
   AddParam Envia, CDbl(Codigo)
   AddParam Envia, Glosa
   AddParam Envia, Nemo
   AddParam Envia, Simbol
   AddParam Envia, TipoMoneda
   AddParam Envia, Pagadora
   If Not Bac_Sql_Execute("SP_LEER_MONEDA", Envia) Then
      Exit Function
   End If
   Call Limpiar
   If Bac_SQL_Fetch(Datos()) Then
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
      mnrefusd = IIf(Datos(15) = "", 0, Val(Datos(15)))
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

Public Function LeerxCodigo(Codigo%) As Boolean
   LeerxCodigo = LeerSQL(Codigo%, "", "", "", "", "")
End Function
Public Function LeerxGlosa(Glosa$) As Boolean
    LeerxGlosa = LeerSQL(0, Glosa$, "", "", "", "")
End Function
Public Function LeerxNemo(Nemo$) As Boolean
    LeerxNemo = LeerSQL(0, "", Nemo$, "", "", "")
End Function
Public Function LeerxSimbol(Simbol$) As Boolean
    LeerxSimbol = LeerSQL(0, "", "", Simbol$, "", "")
End Function
Public Function LeerxTipoMoneda(TipoMoneda$) As Boolean
    LeerxTipoMoneda = LeerSQL(0, "", "", "", TipoMoneda$, "")
End Function

Public Function CargaxProducto(iProd%, obj As Object, Optional iTipo) As Boolean
   CargaxProducto = False
    
   Envia = Array()
   AddParam Envia, CDbl(iProd)
   AddParam Envia, CDbl(0)
   AddParam Envia, Sistema
   If Not Bac_Sql_Execute("SP_LEER_MONEDAPRODUCTO", Envia) Then
      Exit Function
   End If
   If IsMissing(iTipo) Then
      iTipo = 0
      obj.Clear
   End If
   Do While Bac_SQL_Fetch(Datos())
      If iTipo = 1 Then       '--- Carga Grilla de Monedas por Producto
         For i = 1 To obj.Rows - 1
            If Val(obj.TextMatrix(i, 0)) = Val(Datos(3)) Then
               obj.TextMatrix(i, 1) = IIf(Val(Datos(5)) <> 0, "X", "")
            End If
         Next i
      Else
         obj.AddItem Datos(4)
         obj.ItemData(obj.NewIndex) = Val(Datos(3))
      End If
      CargaxProducto = True
   Loop
End Function

Public Function CargaObjectos(obj As Object, sTipo$, Optional iTipo) As Boolean

    CargaObjectos = False

    Sql = "EXECUTE " & giSQL_DatabaseCommon & ".."
    Sql = Sql & "SP_LEER_MONEDA 0,'','',''"
    
    Envia = Array()
    AddParam Envia, CDbl(0)
    AddParam Envia, ""
    AddParam Envia, ""
    AddParam Envia, ""
    
   If UCase(sTipo) = "PAGADORA" Then
      Sql = Sql & ",'','1'"
      AddParam Envia, ""
      AddParam Envia, "1"
   Else
      Sql = Sql & ",'" & sTipo & "',''"
      AddParam Envia, sTipo
   End If
     
   If Not Bac_Sql_Execute("SP_LEER_MONEDA", Envia) Then
      Exit Function
   End If
    
   If IsMissing(iTipo) Then
      obj.Clear
   ElseIf iTipo = 1 Then       '---- Monedas por Producto
      obj.Redraw = False
      obj.Rows = 2
   End If
   Do While Bac_SQL_Fetch(Datos())
      If IsMissing(iTipo) Then
         obj.AddItem Left(Datos(2) & Space(5), 5) & "  " & Datos(4)
         obj.ItemData(obj.NewIndex) = Val(Datos(1))
      ElseIf iTipo = 1 Then       '-- Carga Grilla
         obj.Row = obj.Rows - 1
         obj.TextMatrix(obj.Row, 0) = Val(Datos(1))
         obj.TextMatrix(obj.Row, 1) = ""
         obj.TextMatrix(obj.Row, 2) = UCase(Datos(4))
         obj.Rows = obj.Rows + 1
      End If
   Loop

   If IsMissing(iTipo) Then
   ElseIf iTipo = 1 Then
      obj.Rows = obj.Rows - 1
      obj.Redraw = True
   End If
    
   CargaObjectos = True
End Function

Public Function CargaTasas(iMoneda%, obj As Object) As Boolean

   CargaTasas = False
    
   Envia = Array()
   AddParam Envia, CDbl(iMoneda)
   AddParam Envia, CDbl(0)
   AddParam Envia, CDbl(0)
   AddParam Envia, Format(gsBAC_Fecp, "yyyymmdd")
   If Not Bac_Sql_Execute("SP_LEER_TASASMONEDAS", Envia) Then
      Exit Function
   End If
   obj.Clear
   Do While Bac_SQL_Fetch(Datos())
      If bacBuscarCombo(obj, Val(Datos(3))) < 0 Then
         obj.AddItem Datos(4)
         obj.ItemData(obj.NewIndex) = Val(Datos(3))
         CargaTasas = True
      End If
   Loop
   CargaTasas = True

End Function

Public Function CargaBases(combo As Object, Optional iProducto As Integer) As Boolean
   Dim Datos()
   
   CargaBases = False
    
   Envia = Array()
   AddParam Envia, CDbl(0)
   AddParam Envia, CDbl(Val(iProducto))
   If Not Bac_Sql_Execute("SP_LEEBASES", Envia) Then
      Exit Function
   End If
   combo.Clear
   Do While Bac_SQL_Fetch(Datos())
      CargaBases = True

      combo.AddItem Datos(2) & Space(50) & Datos(3) & Space(5 - Len(Datos(3))) & Datos(4) & Space(5 - Len(Datos(4)))
      combo.ItemData(combo.NewIndex) = Val(Datos(1))
   Loop
   
End Function

Public Function GrabarxProducto(iMoneda%, iProducto%, sEstado$) As Boolean
    Envia = Array()
    AddParam Envia, iProducto
    AddParam Envia, iMoneda
    AddParam Envia, sEstado
    
    GrabarxProducto = (Bac_Sql_Execute("SP_GRABAR_MONEDAPRODUCTO", Envia))
    If Bac_SQL_Fetch(DATOS()) Then
        If Val(DATOS(1)) < 0 Then
            GrabarxProducto = False
            MsgBox Datos(2), vbInformation, gsPARAMS_Version
        End If
    End If

End Function
Public Function Grabar() As Boolean

    Envia = Array()
    AddParam Envia, mnnemo
    AddParam Envia, mnsimbol
    AddParam Envia, mnglosa
    AddParam Envia, mncodsuper
    AddParam Envia, mnnemsuper
    AddParam Envia, mncodbanco
    AddParam Envia, mnnembanco
    AddParam Envia, mnbase
    AddParam Envia, mnredondeo
    AddParam Envia, mndecimal
    AddParam Envia, mncodpais
    AddParam Envia, mnrrda
    AddParam Envia, mnfactor
    AddParam Envia, mnrefusd
    AddParam Envia, mnlocal
    AddParam Envia, mnextranj
    AddParam Envia, mnvalor
    AddParam Envia, mnrefmerc
    AddParam Envia, mningval
    AddParam Envia, mntipmon
    AddParam Envia, mnperiodo
    AddParam Envia, mnmx
    
    grabar = (Bac_Sql_Execute("SP_GRABAR_MONEDA", Envia))
    
    If Bac_SQL_Fetch(Datos()) Then
        If Val(Datos(1)) < 0 Then
            Grabar = False
            MsgBox Datos(2), vbInformation, "MENSAJE"
        End If
    End If

End Function
Public Function BorrarxProducto(iMoneda%, iProducto%) As Boolean
     
   Envia = Array()
   AddParam Envia, iProducto
   AddParam Envia, "PCS"
     
   BorrarxProducto = (Bac_Sql_Execute("SP_BORRAR_MONEDAPRODUCTO", Envia))
   If Bac_SQL_Fetch(DATOS()) Then
      If Val(DATOS(1)) < 0 Then
         BorrarxProducto = False
         MsgBox Datos(2), vbInformation, gsPARAMS_Version
      End If
   End If

End Function

Public Function ValorMoneda(Codigo%, Fecha$, Optional ValorDefault) As Double
   Dim Sql$
   Dim Datos()
   
   ValorMoneda = 0#
   
   If Codigo = 999 Then
      ValorMoneda = 1#
      Exit Function
   End If
   If Not IsMissing(ValorDefault) Then
      ValorMoneda = ValorDefault
   End If
   
   Envia = Array()
   AddParam Envia, Codigo
   AddParam Envia, Format(Fecha, "yyyymmdd")
   If Not Bac_Sql_Execute("SP_LEER_VALORMONEDA", Envia) Then
      Exit Function
   End If
   If Bac_SQL_Fetch(Datos()) Then
      vmValor = CDbl(Datos(2))
      ValorMoneda = CDbl(Datos(2))
   End If
   
End Function
