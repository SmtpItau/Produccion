VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsLimitePermanencia"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Private MiEstado                As Integer
Private MiModulo                As String
Private MiProducto              As String
Private MiNumOperacion          As Long
Private MiNumDocumento          As Long
Private MiCorrelativo           As Long
Private MiCodigo                As Long
Private MiFamilia               As String
Private MiInstrumento           As String
Private MiRutEmisor             As Long
Private MiTrader                As String
Private MiNominal               As Double
Private MiTasa                  As Double
Private MiPvp                   As Double
Private MiPlazoLimite           As Long
Private MiPlazoActual           As Long
Private MiMensaje               As String
Private MinId                   As Long
Private MiRelacionId            As Long

'->     -1 = Defecto;   1 = Ingresado;  2 = Grabado;    3 = No Grabado
Property Get Estado() As Integer
    Let Estado = MiEstado
End Property
Property Let Estado(ByVal NewEstado As Integer)
    Let MiEstado = NewEstado
End Property


Property Get Modulo() As String
    Let Modulo = MiModulo
End Property
Property Let Modulo(ByVal NewModulo As String)
    Let MiModulo = NewModulo
End Property
Property Get Producto() As String
    Let Producto = MiProducto
End Property
Property Let Producto(ByVal NewProducto As String)
    Let MiProducto = NewProducto
End Property
Property Get NumeroOperacion() As Long
    Let NumeroOperacion = MiNumOperacion
End Property
Property Let NumeroOperacion(ByVal NewNumOperacion As Long)
    Let MiNumOperacion = NewNumOperacion
End Property
Property Get NumeroDocumento() As Long
    Let NumeroDocumento = MiNumDocumento
End Property
Property Let NumeroDocumento(ByVal NewNumeroDocumento As Long)
    Let MiNumDocumento = NewNumeroDocumento
End Property
Property Get Correlativo() As Long
    Let Correlativo = MiCorrelativo
End Property
Property Let Correlativo(ByVal NewCorrelativo As Long)
    Let MiCorrelativo = NewCorrelativo
End Property
Property Get Codigo() As Long
    Let Codigo = MiCodigo
End Property
Property Let Codigo(ByVal NewCodigo As Long)
    Let MiCodigo = NewCodigo
End Property
Property Get Familia() As String
    Let Familia = MiFamilia
End Property
Property Let Familia(ByVal NewFamilia As String)
    Let MiFamilia = NewFamilia
End Property
Property Get Instrumento() As String
    Let Instrumento = MiInstrumento
End Property
Property Let Instrumento(ByVal NewInstrumento As String)
    Let MiInstrumento = NewInstrumento
End Property
Property Get RutEmisor() As Long
    Let RutEmisor = MiRutEmisor
End Property
Property Let RutEmisor(ByVal NewRutEmisor As Long)
    Let MiRutEmisor = NewRutEmisor
End Property
Property Get Trader() As String
    Let Trader = MiTrader
End Property
Property Let Trader(ByVal NewTrader As String)
    Let MiTrader = NewTrader
End Property
Property Get Nominal() As Double
    Let Nominal = MiNominal
End Property
Property Let Nominal(ByVal NewNominal As Double)
    Let MiNominal = NewNominal
End Property
Property Get Tasa() As Double
    Let Tasa = MiTasa
End Property
Property Let Tasa(ByVal NewTasa As Double)
    Let MiTasa = NewTasa
End Property
Property Get Pvp() As Double
    Let Pvp = MiPvp
End Property
Property Let Pvp(ByVal NewPvp As Double)
    Let MiPvp = NewPvp
End Property
Property Get PlazoLimite() As Long
    Let PlazoLimite = MiPlazoLimite
End Property
Property Let PlazoLimite(ByVal NewPlazoLimite As Long)
    Let MiPlazoLimite = NewPlazoLimite
End Property
Property Get PlazoActual() As Long
    Let PlazoActual = MiPlazoActual
End Property
Property Let PlazoActual(ByVal NewPlazoActual As Long)
    Let MiPlazoActual = NewPlazoActual
End Property

Property Get Mensaje() As String
    Let Mensaje = MiMensaje
End Property
Property Let Mensaje(ByVal NewMensaje As String)
    Let MiMensaje = NewMensaje
End Property

Property Get Id() As Long
    Let Id = MinId
End Property
Property Let Id(ByVal NewId As Long)
    Let MinId = NewId
End Property

Property Get RelacionId() As Long
    RelacionId = MiRelacionId
End Property
Property Let RelacionId(ByVal NewIdRelacion As Long)
    MiRelacionId = NewIdRelacion
End Property

Private Sub Class_Initialize()
    Call Fx_Clear
End Sub

Public Function Fx_Clear()

    Let MiModulo = ""
    Let MiProducto = ""
    Let MiNumOperacion = 0
    Let MiNumDocumento = 0
    Let MiCorrelativo = 0
    Let MiCodigo = 0
    Let MiFamilia = ""
    Let MiInstrumento = ""
    Let MiRutEmisor = 0
    Let MiTrader = ""
    Let MiNominal = 0
    Let MiTasa = 0
    Let MiPvp = 0
    Let MinPlazoLimite = 0
    Let MinPlazoActual = 0
    Let MiMensaje = ""
    Let MinId = 0
    Let MiRelacionId = 0
    Let MiEstado = -1
End Function

Public Function Fx_Grabacion_Mensajes_LimitePermamencia() As Boolean
    On Error GoTo ErrGrabacion
    Dim SqlDatos()

    Let Fx_Grabacion_Mensajes_LimitePermamencia = False

    Envia = Array()
    Call AddParam(Envia, Format(gsBac_Fecp, "yyyymmdd"))
    Call AddParam(Envia, Modulo)
    Call AddParam(Envia, Producto)
    Call AddParam(Envia, NumeroOperacion)
    Call AddParam(Envia, NumeroDocumento)
    Call AddParam(Envia, Correlativo)
    Call AddParam(Envia, Codigo)
    Call AddParam(Envia, Familia)
    Call AddParam(Envia, Instrumento)
    Call AddParam(Envia, RutEmisor)
    Call AddParam(Envia, Trader)
    Call AddParam(Envia, Nominal)
    Call AddParam(Envia, Tasa)
    Call AddParam(Envia, Pvp)
    Call AddParam(Envia, PlazoLimite)
    Call AddParam(Envia, PlazoActual)
    Call AddParam(Envia, Mensaje)
    Call AddParam(Envia, RelacionId)
    Call AddParam(Envia, Estado)
    If Not Bac_Sql_Execute("BacLineas.dbo.SP_GRABA_MENSAJES_LIMITE_PERMANENCIA", Envia) Then
        GoTo ErrGrabacion
    End If
    If Bac_SQL_Fetch(SqlDatos()) Then
        If Not SqlDatos(1) = -1 Then
            Let RelacionId = SqlDatos(3)
        End If
    Else
        GoTo ErrGrabacion
    End If
    
    Let Fx_Grabacion_Mensajes_LimitePermamencia = True

    On Error GoTo 0
Exit Function
ErrGrabacion:

    On Error GoTo 0
End Function

Public Function Fx_Actualiza_FolioOperacion(ByVal nId As Long, ByVal nFolioOperacion As Long) As Boolean
    On Error GoTo ErrActualizacion
    Dim SqlDatos()
    
    Let Fx_Actualiza_FolioOperacion = False
    
    Envia = Array()
    Call AddParam(Envia, nId)
    Call AddParam(Envia, nFolioOperacion)

    If Not Bac_Sql_Execute("BacLineas.dbo.SP_ACTUALIZA_FOLIOOP_MSGLIMITEPERMANENCIA", Envia) Then
        GoTo ErrActualizacion
    End If
    If Bac_SQL_Fetch(SqlDatos()) Then
        If Not SqlDatos(1) = -1 Then
            Let MinId = SqlDatos(3)
        End If
    Else
        GoTo ErrActualizacion
    End If
    
    Let Fx_Actualiza_FolioOperacion = True
    On Error GoTo 0

Exit Function
ErrActualizacion:

    On Error GoTo 0

End Function


Public Function Fx_EliminaRegistroLimite(ByVal nId As Long) As Boolean
    On Error GoTo ErrActualizacion
    Dim SqlDatos()
    
    Let Fx_EliminaRegistroLimite = False
    
    If nId = -1 Then
        Let Fx_EliminaRegistroLimite = True
        Exit Function
    End If

    Envia = Array()
    Call AddParam(Envia, nId)
    If Not Bac_Sql_Execute("BacLineas.dbo.SP_ELIMINA_LIMITE_PERMANENCIA", Envia) Then
        GoTo ErrActualizacion
    End If

    Let Fx_EliminaRegistroLimite = True
    On Error GoTo 0

Exit Function
ErrActualizacion:

    On Error GoTo 0
End Function

Public Function FX_CarteraNormativa(ByVal cCartera As String) As Integer
    Dim cSqlString  As String
    Dim SqlDatos()

    Let cSqlString = "select tbtasa from BacParamSuda.dbo.Tabla_general_detalle where tbcateg = 1111 and tbcodigo1 = '" & cCartera & "'"

    Let fxCarteraNormativa = 0

    If Not Bac_Sql_Execute(cSqlString) Then
        Exit Function
    End If
    If Bac_SQL_Fetch(SqlDatos()) Then
        Let FX_CarteraNormativa = SqlDatos(1)
    End If

End Function

