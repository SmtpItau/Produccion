VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsDCartera"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

 'MDDC : TABLAS DE DUEÑOS DE CARTERAS
 '-----------------------------------------------
 Public rccodcar   As Currency  'numeric 10,0
 Public rcrut      As Long      'numeric  9,0
 Public rcdv       As String
 Public rcnombre   As String
 Public rcnumoper  As Currency  'numeric 10,0
 Public rctelefono As String
 Public rcfax      As String
 Public rcdirecc   As String

 




            


Public Function Grabar() As Boolean

    Grabar = False
     
'    Sql = "SP_RCGRABAR "
'    Sql = Sql & rccodcar & ","
'    Sql = Sql & rcrut & ","
'    Sql = Sql & "'" & rcdv & "',"
'    Sql = Sql & "'" & rcnombre & "',"
'    Sql = Sql & rcnumoper & ","
'    Sql = Sql & "'" & rctelefono & "',"
'    Sql = Sql & "'" & rcfax & "',"
'    Sql = Sql & "'" & rcdirecc & "'"

    Envia = Array(rccodcar, _
            rcrut, _
            rcdv, _
            rcnombre, _
            rcnumoper, _
            rctelefono, _
            rcfax, _
            rcdirecc)
     
    If Not Bac_Sql_Execute("SP_RCGRABAR", Envia) Then
        Exit Function
    End If
    
    Call Limpiar
    Grabar = True
     
End Function






Public Function LeerPorCodigo(IDCodigo As Long)

    LeerPorCodigo = False
    
'    Sql = "SP_RCLEERCOD " & IDCodigo
    
    Envia = Array(CDbl(IDCodigo))
    
    If Not Bac_Sql_Execute("SP_RCLEERCOD", Envia) Then
        Exit Function
    End If
     
    Limpiar
    
    Dim Datos()
    If Bac_SQL_Fetch(Datos()) Then
        rccodcar = Val(Datos(1))
        rcrut = Val(Datos(2))
        rcdv = Datos(3)
        rcnombre = Datos(4)
        rcnumoper = Val(Datos(5))
        rctelefono = Datos(6)
        rcfax = Datos(7)
        rcdirecc = Datos(8)
    End If
    
    LeerPorCodigo = True
    
End Function

Public Function LeerPorRut(idRut As Long) As Boolean

    LeerPorRut = False
    
'    Sql = "SP_RCLEERRUT " & idRut
    
    Envia = Array(CDbl(idRut))
    If Not Bac_Sql_Execute("SP_RCLEERRUT", Envia) Then
       Exit Function
    End If
     
    Limpiar
    
    Dim Datos()
    If Bac_SQL_Fetch(Datos()) Then
        rccodcar = Val(Datos(1))
        rcrut = Val(Datos(2))
        rcdv = Datos(3)
        rcnombre = Datos(4)
        rcnumoper = Val(Datos(5))
        rctelefono = Datos(6)
        rcfax = Datos(7)
        rcdirecc = Datos(8)
    End If
    
    LeerPorRut = True
    
End Function



Public Function Eliminar(idRut As Long) As Boolean

    Eliminar = False
'    Sql = "SP_RCElIMINAR " & idRut
    Envia = Array(CDbl(idRut))
    
    If Not Bac_Sql_Execute("SP_RCElIMINAR", Envia) Then
       Exit Function
    End If
    
    Call Limpiar
    Eliminar = True
    
End Function



Private Sub Limpiar()
 
    rccodcar = 0
    rcrut = 0
    rcdv = ""
    rcnombre = ""
    rcnumoper = 0
    rctelefono = ""
    rcfax = ""
    rcdirecc = ""
 
End Sub

Private Sub Class_Initialize()

    Call Limpiar
    
End Sub


