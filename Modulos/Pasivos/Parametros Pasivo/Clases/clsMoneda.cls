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

Dim Sql$, Datos(), i&
'********************************************
Public mncodmon As Integer
Public mnCodfox As String
Public mnvalfox As Integer
Public mncodcor As Integer
Public codigo_pais As Integer
Public mniso_coddes As String
'********************************************
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
Public MNREFMERC    As String
Public MNINGVAL     As Integer
Public mntipmon     As String
Public mnperiodo    As Integer
Public mnmx         As String
Public vmValor      As Double



'-----------------------------------------------
'Public mncodmon   As Long  'numeric  3,0
'Public mnnemo     As String
'Public mnsimbol   As String
Public mndescrip  As String
'Public mnredondeo As Integer  'numeric  1,0
'Public mnbase     As Integer  'numeric  3,0
'Public mntipmon   As String
'Public mnperiodo  As Integer  'numeric  2,0
'Public mncodsuper As Integer  'numeric  3,0
'Public MNREFMERC  As String
'Public MNINGVAL   As Integer


Public Function Ayuda(sTipo$) As Boolean

    'Ayuda = CargaObjectos(BacAyuda.lstNombre, sTipo$)
    
    If Not Ayuda Then
        MsgBox "No es posible cargar información de Ayuda", vbExclamation
    Else
        MiTag = "MONEDA"
    End If
     
End Function

'Trae datos de una moneda
Public Function LeerSQL(codigo%, glosa$, Nemo$, Simbol$, TipoMoneda$, Pagadora$) As Boolean

   LeerSQL = False
   Envia = Array()
   AddParam Envia, codigo
   AddParam Envia, glosa
   AddParam Envia, Nemo
   AddParam Envia, Simbol
   AddParam Envia, TipoMoneda
   AddParam Envia, Pagadora

   If Not BAC_SQL_EXECUTE("sp_Leer_Moneda ", Envia) Then
      Exit Function
   End If

   Call Limpiar
   
   If BAC_SQL_FETCH(Datos()) Then
   
        mncodigo = Val(Datos(1))
        mnnemo = UCase(Datos(2))
        mnsimbol = UCase(Datos(3))
        mnglosa = UCase(Datos(4))
        mncodsuper = Val(Datos(5))
        mnnemsuper = UCase(Datos(6))
        mncodbanco = Val(Val(Datos(7)))
        mnnembanco = UCase(Datos(8))
        mnbase = Val(Datos(9))
        mnredondeo = Val(Datos(10))
        mndecimal = Val(Datos(11))
'        mncodpais = Val(Datos(12))
        mnrrda = UCase(Datos(12))
        mnfactor = Val(Datos(13))
        mnrefusd = Datos(14)
        mnlocal = Datos(15)
        mnextranj = Datos(16)
        mnvalor = Datos(17)
        MNREFMERC = Datos(18)
'        MNINGVAL = Val(Datos(20))
        mntipmon = Datos(19)
        mnperiodo = Val(Datos(20))
        mnmx = Datos(21)
        'vmValor = ValorMoneda(mncodigo, gsbac_fecp)'HABILITAR
        
        Existe = True
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
    MNREFMERC = ""
    MNINGVAL = 0
    mntipmon = ""
    mnperiodo = 0
    mnmx = ""
    
    mncodmon = 0
    mnnemo = ""
    mnsimbol = ""
    mndescrip = ""
    mnredondeo = 0
    mnbase = 0
    mntipmon = ""
    mnperiodo = 0
    mncodsuper = 0
    
    
    vmValor = 0#

End Sub

'Trae datos de una moneda a partir del codigo
Public Function LeerPorCodigo(codigo As Integer, fecha As String) As Boolean
 
   Dim Sql        As String
   Dim Datos()
    
   LeerPorCodigo = False
   Envia = Array()
   AddParam Envia, codigo
   AddParam Envia, Format(fecha, "YYYYMMDD")
   

   If Not BAC_SQL_EXECUTE("sp_mdmnleercodigo ", Envia) Then
      Exit Function
   End If

   Call Limpiar
   
   If BAC_SQL_FETCH(Datos()) Then
   
      mncodigo = Val(Datos(1))
      mnglosa = Datos(2)
      mnnemo = Datos(3)
      mnfactor = Val(Datos(4))
      mnredondeo = Val(Datos(5))
      mncodbanco = Val(Datos(6))
      mncodsuper = Datos(7)
      mnbase = Val(Datos(8))
      mnrefusd = Datos(9)
      mnlocal = Datos(10)
      mnextranj = Datos(11)
      mnvalor = Datos(12)
      MNREFMERC = Datos(13)
      'mntipval = Val(Datos(14))
      LeerPorCodigo = True

   End If

End Function
Public Function LeerxCodigo(codigo%) As Boolean

    LeerxCodigo = LeerSQL(codigo%, "", "", "", "", "")

End Function

Public Function LeerxGlosa(glosa$) As Boolean

    LeerxGlosa = LeerSQL(0, glosa$, "", "", "", "")

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

'Public Function CargaxProducto(sSistema$, iProd%, obj As Object, Optional iTipo) As Boolean
Public Function CargaxProducto(sSistema$, iProd$, obj As Object, Optional iTipo) As Boolean

    CargaxProducto = False
    Envia = Array()
    AddParam Envia, sSistema
    AddParam Envia, iProd
       
        
    If Not BAC_SQL_EXECUTE("sp_marca_x", Envia) Then
       Exit Function
    End If
    
    If IsMissing(iTipo) Then
        iTipo = 0
        obj.Clear
    End If
    
    Do While BAC_SQL_FETCH(Datos())
        If iTipo = 1 Then       '--- Carga Grilla de Monedas por Producto
            For i = 1 To obj.Rows - 1
                If Val(obj.TextMatrix(i, 0)) = Val(Datos(2)) Then
                    obj.TextMatrix(i, 1) = IIf(Val(Datos(3)) <> 0, "X", "")
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

    Envia = Array()
    AddParam Envia, "0"
    AddParam Envia, ""
    AddParam Envia, ""
    AddParam Envia, ""
    
    If UCase(sTipo) = "PAGADORA" Then
        AddParam Envia, "1"
    Else
        AddParam Envia, sTipo
    End If
     
        If Not BAC_SQL_EXECUTE("sp_Leer_Moneda", Envia) Then
            Exit Function
        End If
    
    If IsMissing(iTipo) Then
        obj.Clear
        
    ElseIf iTipo = 1 Then       '---- Monedas por Producto
        obj.Redraw = False
        obj.Rows = 2
        
        'obj.ColWidth(0) = 0
        'obj.ColWidth(2) = 4250
        
    End If
    obj.Clear

    Do While BAC_SQL_FETCH(Datos())
  
        If IsMissing(iTipo) Then   'si se tranfirio el valor al option = true
            'obj.AddItem Left(Datos(1) & Space(5), 5) & "  " & Datos(4)
            obj.AddItem Left(Datos(4) & Space(110), 110) & "  " & Datos(1)
            obj.ItemData(obj.NewIndex) = Val(Datos(1))
            
        ElseIf iTipo = 1 Then       '-- Carga Grilla
            obj.Row = obj.Rows - 1
            obj.TextMatrix(obj.Row, 0) = Val(Datos(1))
            obj.TextMatrix(obj.Row, 1) = ""
            obj.TextMatrix(obj.Row, 2) = UCase(Datos(4))
            obj.Rows = obj.Rows + 1
            
        End If
        CargaObjectos = True
    Loop
  
    If IsMissing(iTipo) Then
    '----
    ElseIf iTipo = 1 Then
        obj.Rows = obj.Rows - 1
        obj.Redraw = True
    End If
    
End Function

'Public Function GrabarxProducto(sSistema$, iMoneda%, iProducto%, sEstado$) As Boolean
Public Function GrabarxProducto(sSistema$, iProducto$, iMoneda%, sEstado$) As Boolean

    Envia = Array()
    AddParam Envia, sSistema
    AddParam Envia, iProducto
    AddParam Envia, iMoneda
    AddParam Envia, sEstado
   
     
    GrabarxProducto = (BAC_SQL_EXECUTE("sp_Grabar_MonedaProducto", Envia))
    
    If Not GrabarxProducto Then
        MsgBox "Error Grabando Producto Moneda", vbCritical
        Exit Function
    End If
    
    If BAC_SQL_FETCH(Datos()) Then
        
        If Val(Datos(1)) < 0 Then
            
            GrabarxProducto = False
            MsgBox Datos(2), vbInformation
            Exit Function
        
        End If
    
    End If
    
End Function

Public Function GrabarxProductos(sSistema$, iMoneda%, iProducto%, sEstado$) As Boolean

    
    Envia = Array()
    AddParam Envia, sSistema
    AddParam Envia, CODI
    AddParam Envia, codipag
    AddParam Envia, iMoneda
    AddParam Envia, sEstado
     
    GrabarxProductos = (BAC_SQL_EXECUTE("sp_Grabar_Moneda ", Envia))
    
    If BAC_SQL_FETCH(Datos()) Then
        
        If Val(Datos(1)) < 0 Then
            
            GrabarxProductos = False
            MsgBox Datos(2), vbInformation
            Exit Function
        
        End If
    
    End If

 GrabarxProductos = True

End Function

Public Function grabar() As Boolean


    Envia = Array()
    AddParam Envia, mncodigo
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
    AddParam Envia, MNREFMERC
    AddParam Envia, MNINGVAL
    AddParam Envia, mntipmon
    AddParam Envia, mnperiodo
    AddParam Envia, mnmx
    
        
    grabar = (BAC_SQL_EXECUTE("sp_Grabar_Moneda ", Envia))
    
    If BAC_SQL_FETCH(Datos()) Then
        If Val(Datos(1)) < 0 Then
            grabar = False
            Screen.MousePointer = 0
            MsgBox Datos(2), vbInformation
            Exit Function
        End If
    End If

 grabar = True
 
End Function


Public Function BorrarxProducto(sSistema$, iMoneda%, iProducto$) As Boolean
    Dim Datos()
    'Sql = ""
    'Sql = "sp_Borrar_MonedaProducto " & iMoneda
    'Sql = Sql & ", " & iProducto
    'Sql = Sql & ",'" & Sistema & "'"
    'Sql = Sql & ",'PCS'"

    Envia = Array()
    AddParam Envia, sSistema
    AddParam Envia, iMoneda
    AddParam Envia, iProducto
    
    BorrarxProducto = (BAC_SQL_EXECUTE("sp_Borrar_MonedaProducto  ", Envia))
    
    If BAC_SQL_FETCH(Datos()) Then
        If Val(Datos(1)) < 0 Then
            BorrarxProducto = False
            MsgBox Datos(2), vbInformation
        End If
    End If

End Function
Public Function BorrarxProductos(iMoneda%, iProducto%, iSistema As String) As Boolean
    
    'Sql = ""
    'Sql = "sp_Borrar_MonedaProducto " & iMoneda
    'Sql = Sql & ", " & iProducto
    'Sql = Sql & ",'" & Sistema & "'"
    'Sql = Sql & ",'PCS'"
    Envia = Array()
    AddParam Envia, CODI
    AddParam Envia, codipag
    AddParam Envia, iMoneda
    AddParam Envia, iSistema
    
    BorrarxProductos = (BAC_SQL_EXECUTE("sp_Borrar_MonedaP  ", Envia))
    
    If BAC_SQL_FETCH(Datos()) Then
        If Val(Datos(1)) < 0 Then
            BorrarxProductos = False
            MsgBox Datos(2), vbInformation
        End If
    End If

End Function
Public Function ValorMoneda(codigo%, fecha$, Optional ValorDefault) As Double

   ValorMoneda = 0#
   
   If codigo = 999 Then
      ValorMoneda = 1#
      Exit Function
   End If
   
   If Not IsMissing(ValorDefault) Then
       ValorMoneda = ValorDefault
   End If

   Envia = Array()
   AddParam Envia, codigo
   AddParam Envia, Format(fecha, "yyyymmdd")

   If Not BAC_SQL_EXECUTE("sp_Leer_ValorMoneda ", Envia) Then
      Exit Function
   End If

   If BAC_SQL_FETCH(Datos()) Then
        ValorMoneda = Val(Datos(2))
   End If
   
End Function




Public Function LeerPorCodigox(CodMon As Long) As Boolean
Dim Sql As String
    
    LeerPorCodigox = False
    Existe = False
    
    'Sql = "SP_MNLEER " & codMon
    
    Envia = Array(CDbl(CodMon))
    If Not BAC_SQL_EXECUTE("SP_MNLEER", Envia) Then
       Exit Function
    End If

    Call Limpiar
    
    Dim Datos()
    If BAC_SQL_FETCH(Datos()) Then
        If Val(Datos(1)) < 0 Then
            MsgBox Datos(2), vbExclamation
        Else
            mncodmon = Val(Datos(1))
            mnnemo = Datos(2)
            mnsimbol = Datos(3)
            mndescrip = Datos(4)
            mnredondeo = Val(Datos(5))
            mnbase = Val(Datos(6))
            mntipmon = Datos(7)
            mnperiodo = Val(Datos(8))
            mncodsuper = Val(Datos(9))
            Existe = True
        End If
    End If
       
    LeerPorCodigox = True
    
End Function
