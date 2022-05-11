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

Dim Sql$, DATOS(), i&
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

    Ayuda = CargaObjectos(BacAyuda.lstNombre, sTipo$)
    
    If Not Ayuda Then
        MsgBox "No es posible cargar información de Ayuda", vbExclamation, TITSISTEMA
    Else
        BacAyuda.Tag = "MONEDA"
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

   If Not Bac_Sql_Execute("SP_LEER_MONEDA ", Envia) Then
      Exit Function
   End If

   Call Limpiar
   
   If Bac_SQL_Fetch(DATOS()) Then
   
        mncodigo = Val(DATOS(1))
        mnnemo = UCase(DATOS(2))
        mnsimbol = UCase(DATOS(3))
        mnglosa = UCase(DATOS(4))
        mncodsuper = Val(DATOS(5))
        mnnemsuper = UCase(DATOS(6))
        mncodbanco = Val(Val(DATOS(7)))
        mnnembanco = UCase(DATOS(8))
        mnbase = Val(DATOS(9))
        mnredondeo = Val(DATOS(10))
        mndecimal = Val(DATOS(11))
        mncodpais = Val(DATOS(12))
        mnrrda = UCase(DATOS(13))
        mnfactor = Val(DATOS(14))
        mnrefusd = DATOS(15)
        mnlocal = DATOS(16)
        mnextranj = DATOS(17)
        mnvalor = DATOS(18)
        MNREFMERC = DATOS(19)
        MNINGVAL = Val(DATOS(20))
        mntipmon = DATOS(21)
        mnperiodo = Val(DATOS(22))
        mnmx = DATOS(23)
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
   Dim DATOS()
    
   LeerPorCodigo = False
   Envia = Array()
   AddParam Envia, codigo
   AddParam Envia, Format(fecha, "YYYYMMDD")
   

   If Not Bac_Sql_Execute("SP_MDMNLEERCODIGO ", Envia) Then
      Exit Function
   End If

   Call Limpiar
   
   If Bac_SQL_Fetch(DATOS()) Then
   
      mncodigo = Val(DATOS(1))
      mnglosa = DATOS(2)
      mnnemo = DATOS(3)
      mnfactor = Val(DATOS(4))
      mnredondeo = Val(DATOS(5))
      mncodbanco = Val(DATOS(6))
      mncodsuper = DATOS(7)
      mnbase = Val(DATOS(8))
      mnrefusd = DATOS(9)
      mnlocal = DATOS(10)
      mnextranj = DATOS(11)
      mnvalor = DATOS(12)
      MNREFMERC = DATOS(13)
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
       
        
    If Not Bac_Sql_Execute("SP_MARCA_X", Envia) Then
       Exit Function
    End If
    
    If IsMissing(iTipo) Then
        iTipo = 0
        obj.Clear
    End If
    
    Do While Bac_SQL_Fetch(DATOS())
        If iTipo = 1 Then       '--- Carga Grilla de Monedas por Producto
            For i = 1 To obj.Rows - 1
                If Val(obj.TextMatrix(i, 0)) = Val(DATOS(2)) Then
                    obj.TextMatrix(i, 1) = IIf(Val(DATOS(3)) <> 0, "X", "")
                End If
            Next i
        Else
            obj.AddItem DATOS(4)
            obj.ItemData(obj.NewIndex) = Val(DATOS(3))
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
     
        If Not Bac_Sql_Execute("SP_LEER_MONEDA", Envia) Then
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

    Do While Bac_SQL_Fetch(DATOS())
  
        If IsMissing(iTipo) Then   'si se tranfirio el valor al option = true
            'obj.AddItem Left(Datos(1) & Space(5), 5) & "  " & Datos(4)
            obj.AddItem Left(DATOS(4) & Space(70), 70) & "  " & DATOS(1)
            obj.ItemData(obj.NewIndex) = Val(DATOS(1))
            
        ElseIf iTipo = 1 Then       '-- Carga Grilla
            obj.Row = obj.Rows - 1
            obj.TextMatrix(obj.Row, 0) = Val(DATOS(1))
            obj.TextMatrix(obj.Row, 1) = ""
            obj.TextMatrix(obj.Row, 2) = UCase(DATOS(4))
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
   
     
    GrabarxProducto = (Bac_Sql_Execute("SP_GRABAR_MONEDAPRODUCTO", Envia))
    
    If Not GrabarxProducto Then
        MsgBox "Error Grabando Producto Moneda", vbCritical, TITSISTEMA
        Exit Function
    End If
    
    If Bac_SQL_Fetch(DATOS()) Then
        
        If Val(DATOS(1)) < 0 Then
            
            GrabarxProducto = False
            MsgBox DATOS(2), vbInformation, TITSISTEMA
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
     
    GrabarxProductos = (Bac_Sql_Execute("SP_GRABAR_MONEDA ", Envia))
    
    If Bac_SQL_Fetch(DATOS()) Then
        
        If Val(DATOS(1)) < 0 Then
            
            GrabarxProductos = False
            MsgBox DATOS(2), vbInformation, TITSISTEMA
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
    
        
    Grabar = (Bac_Sql_Execute("SP_GRABAR_MONEDA ", Envia))
    
    If Bac_SQL_Fetch(DATOS()) Then
        If Val(DATOS(1)) < 0 Then
            grabar = False
            Screen.MousePointer = 0
            MsgBox DATOS(2), vbInformation, TITSISTEMA
            Exit Function
        End If
    End If

 grabar = True
 
End Function


Public Function BorrarxProducto(sSistema$, iMoneda%, iProducto$) As Boolean
    Dim DATOS()
    'Sql = ""
    'Sql = "sp_Borrar_MonedaProducto " & iMoneda
    'Sql = Sql & ", " & iProducto
    'Sql = Sql & ",'" & Sistema & "'"
    'Sql = Sql & ",'PCS'"

    Envia = Array()
    AddParam Envia, sSistema
    AddParam Envia, iMoneda
    AddParam Envia, iProducto
    
    BorrarxProducto = (Bac_Sql_Execute("SP_BORRAR_MONEDAPRODUCTO  ", Envia))
    
    If Bac_SQL_Fetch(DATOS()) Then
        If Val(DATOS(1)) < 0 Then
            BorrarxProducto = False
            MsgBox DATOS(2), vbInformation, TITSISTEMA
        End If
    End If

End Function
Public Function BorrarxProductos(iMoneda%, iProducto%) As Boolean
    
    'Sql = ""
    'Sql = "sp_Borrar_MonedaProducto " & iMoneda
    'Sql = Sql & ", " & iProducto
    'Sql = Sql & ",'" & Sistema & "'"
    'Sql = Sql & ",'PCS'"
    Envia = Array()
    AddParam Envia, CODI
    AddParam Envia, codipag
    AddParam Envia, iMoneda
     
    BorrarxProductos = (Bac_Sql_Execute("SP_BORRAR_MONEDAP  ", Envia))
    
    If Bac_SQL_Fetch(DATOS()) Then
        If Val(DATOS(1)) < 0 Then
            BorrarxProductos = False
            MsgBox DATOS(2), vbInformation, TITSISTEMA
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

   If Not Bac_Sql_Execute("SP_LEER_VALORMONEDA ", Envia) Then
      Exit Function
   End If

   If Bac_SQL_Fetch(DATOS()) Then
        ValorMoneda = Val(DATOS(2))
   End If
   
End Function




Public Function LeerPorCodigox(CodMon As Long) As Boolean
Dim Sql As String
    
    LeerPorCodigox = False
    Existe = False
    
    'Sql = "SP_MNLEER " & codMon
    
    Envia = Array(CDbl(CodMon))
    If Not Bac_Sql_Execute("SP_MNLEER", Envia) Then
       Exit Function
    End If

    Call Limpiar
    
    Dim DATOS()
    If Bac_SQL_Fetch(DATOS()) Then
        mncodmon = Val(DATOS(1))
        mnnemo = DATOS(2)
        mnsimbol = DATOS(3)
        mndescrip = DATOS(4)
        mnredondeo = Val(DATOS(5))
        mnbase = Val(DATOS(6))
        mntipmon = DATOS(7)
        mnperiodo = Val(DATOS(8))
        mncodsuper = Val(DATOS(9))
        Existe = True
    End If
       
    LeerPorCodigox = True
    
End Function
