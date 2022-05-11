VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsTPremio"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Public prcodi    As Integer
Public prserie   As String
Public prcupon   As Integer
Public prpremio  As Currency

Public Function Grabar() As Boolean

    Grabar = False
        
'    Sql = "SP_TPGRABAR  " & Chr(10)
'    Sql = Sql & prcodi & ","
'    Sql = Sql & "'" & prserie & "',"
'    Sql = Sql & prcupon & ","
'    Sql = Sql & BacStrTran(Trim$(CStr(prpremio)), ",", ".")
    
    Envia = Array(CDbl(prcodi), _
            prserie, _
            CDbl(prcupon), _
            CDbl(prpremio))
    
    If Not Bac_Sql_Execute("SP_TPGRABAR", Envia) Then
        Exit Function
    End If
    
    Grabar = True
  
End Function

