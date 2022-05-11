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

Dim Sql$, datos(), i&
Public Tabla     As Integer
Public codigo    As Long
Public glosa     As String


''''Public Function grabar(iTabla%, iCodigo%, sGlosa$) As Boolean
''''
''''    Sql = "EXECUTE " & giSQL_DatabaseCommon & ".."
''''    Sql = Sql & "sp_Grabar_TC " & iTabla
''''    Sql = Sql & ", " & iCodigo
''''    Sql = Sql & ",'" & sGlosa & "'"
''''    Sql = Sql & ",'" & Sistema & "'"    '---- PENDIENTE chequear, debe ser 'PCS'
''''
''''    grabar = (MISQL.SQL_Execute(Sql) = 0)
''''
''''    If MISQL.SQL_Fetch(Datos()) = 0 Then
''''        If Val(Datos(1)) < 0 Then
''''            grabar = False
''''            MsgBox Datos(2), vbInformation, Msj
''''        End If
''''    End If
''''
''''End Function

Public Function Leer(iTabla%, iCodigo%) As Boolean

    Leer = False
    Envia = Array()
    AddParam Envia, iTabla
    AddParam Envia, iCodigo
    
    If Not Bac_Sql_Execute("SP_LEER_TC ", Envia) Then
        Exit Function
    End If
     
    Call Limpiar
              
    If Bac_SQL_Fetch(datos()) Then
        Tabla = Val(datos(1))
        codigo = Val(datos(2))
        glosa = UCase(Trim$(datos(3)))
        Leer = True
    End If
    
End Function

Public Function CargaProductos(obj As Object, Sistema) As Boolean

    CargaProductos = False
    
    obj.Clear
    
    If Not Bac_Sql_Execute("SP_LEERPRODUCTOSSISTEMAS '" & Sistema & "'") Then
         Exit Function
    End If
    
    Do While Bac_SQL_Fetch(datos())
        obj.AddItem UCase(datos(2)) & Space(150) & datos(1)
        CargaProductos = True
    Loop

End Function

Public Function CargaObjetos(obj As Object, iTabla%) As Boolean

    CargaObjetos = False
    Envia = Array()
    AddParam Envia, iTabla
    
    obj.Clear
    
    'On Error Resume Next
    If Not Bac_Sql_Execute("SP_LEER_TC ", Envia) Then
   
        Exit Function
    End If
    
    Do While Bac_SQL_Fetch(datos())
        obj.AddItem UCase(datos(3))
        obj.ItemData(obj.NewIndex) = Val(datos(2))
        CargaObjetos = True
    Loop

End Function

Private Sub Limpiar()

    Tabla = 0
    codigo = 0
    glosa = ""

End Sub


