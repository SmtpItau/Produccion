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

Dim Sql$, DATOS(), i&

Public Tabla     As Integer
Public Codigo    As Integer
Public Glosa     As String


Public Function Grabar(iTabla%, iCodigo%, sGlosa$) As Boolean
    Envia = Array()
    AddParam Envia, iCodigo
    AddParam Envia, sGlosa
    AddParam Envia, Sistema
    
'    Sql = "EXECUTE " & giSQL_DatabaseCommon & ".."
'    Sql = Sql & "sp_Grabar_TC " & iTabla
'    Sql = Sql & ", " & iCodigo
'    Sql = Sql & ",'" & sGlosa & "'"
'    Sql = Sql & ",'" & Sistema & "'"    '---- PENDIENTE chequear, debe ser 'PCS'
    
    Grabar = (MISQL.SQL_Execute(Sql) = 0)
    
'    If MISQL.SQL_Fetch(DATOS) = 0 Then
    If Bac_SQL_Fetch(DATOS()) Then
        If Val(DATOS(1)) < 0 Then
            Grabar = False
            MsgBox DATOS(2), vbInformation, Msj
        End If
    End If

End Function
Public Function Leer(iTabla%, iCodigo%) As Boolean

    Leer = False
    
'    Sql = "EXECUTE sp_Leer_TC " & iTabla & "," & iCodigo
    Envia = Array()
    AddParam Envia, CDbl(iTabla)
    AddParam Envia, CDbl(iCodigo)
    
'    If MISQL.SQL_Execute(Sql) <> 0 Then
    If Bac_Sql_Execute("SP_LEER_TC", Envia) Then
        
        Exit Function
    End If
     
    Call Limpiar
              
'If MISQL.SQL_Fetch(DATOS()) = 0 Then
If Bac_SQL_Fetch(DATOS()) Then
        Tabla = Val(DATOS(1))
        Codigo = Val(DATOS(2))
        Glosa = Trim$(DATOS(3))
        Leer = True
    End If
    
End Function

Public Function CargaObjetos(obj As Object, iTabla%) As Boolean

    CargaObjetos = False

'    Sql = "EXECUTE " & giSQL_DatabaseCommon & ".."
'    Sql = Sql & "sp_Leer_TC " & iTabla
    
    Envia = Array()
    AddParam Envia, CDbl(iTabla)
    
    obj.Clear
    
'    If MISQL.SQL_Execute(Sql) <> 0 Then
    If Not Bac_Sql_Execute("SP_LEER_TC", Envia) Then
        Exit Function
    End If
    
    Do While MISQL.SQL_Fetch(DATOS) = 0
        obj.AddItem DATOS(3)
        obj.ItemData(obj.NewIndex) = Val(DATOS(2))
        CargaObjetos = True
    Loop

End Function
Private Sub Limpiar()

    Tabla = 0
    Codigo = 0
    Glosa = ""

End Sub


