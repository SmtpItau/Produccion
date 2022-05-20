VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsCodigo"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Dim Sql$, Datos(), i&
Public Tabla     As Integer
Public codigo    As Long
Public glosa     As String



Public Function Leer(iTabla%, iCodigo%) As Boolean

    Leer = False
    Envia = Array()
    AddParam Envia, iTabla
    AddParam Envia, iCodigo
    
    If Not BAC_SQL_EXECUTE("sp_Leer_TC ", Envia) Then
        Exit Function
    End If
     
    Call Limpiar
              
    If BAC_SQL_FETCH(Datos()) Then
        Tabla = Val(Datos(1))
        codigo = Val(Datos(2))
        glosa = UCase(Trim$(Datos(3)))
        Leer = True
    End If
    
End Function
Public Function CargaProductos(obj As Object, Sistema) As Boolean

    CargaProductos = False
    
    obj.Clear
    
    If Not BAC_SQL_EXECUTE("sp_LeerProductosSistemas '" & Sistema & "'") Then
         Exit Function
    End If
    
    Do While BAC_SQL_FETCH(Datos())
        obj.AddItem UCase(Datos(2)) & Space(150) & Datos(1)
        CargaProductos = True
    Loop

End Function

Public Function CargaObjetos(obj As Object, iTabla%) As Boolean
Dim Espacios As Double
    CargaObjetos = False
    Envia = Array()
    AddParam Envia, iTabla
    
    
    obj.Clear
    
    If Not BAC_SQL_EXECUTE("sp_Leer_TC ", Envia) Then
        Exit Function
    End If
    
    Do While BAC_SQL_FETCH(Datos())
        Espacios = 50 - Len(RTrim(LTrim(Datos(3))))
        obj.AddItem UCase(Datos(3)) + Space(Espacios) + Datos(2)
        obj.ItemData(obj.NewIndex) = Val(Datos(2))
        CargaObjetos = True
    Loop

End Function
Private Sub Limpiar()

    Tabla = 0
    codigo = 0
    glosa = ""

End Sub


