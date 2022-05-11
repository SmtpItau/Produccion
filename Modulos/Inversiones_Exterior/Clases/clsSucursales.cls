VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsSucursales"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Public Codigo As Double
Public Glosa As String

Public Function TraeDatos(oCombo As ComboBox)
Dim Arr()
Dim i As Double
Dim Cons As String
Dim Aux As String
Dim Aux1 As String
Dim Aux2 As String


oCombo.Clear
oCombo.Enabled = True

If Bac_Sql_Execute("Sp_invex_TraeSucursales") Then
    i = 1
    Do While Bac_SQL_Fetch(Arr)
        Aux = Trim(Arr(2))
        Aux1 = Trim(Arr(1))
        Aux2 = (Aux & Space(50 - Len(Aux)) & Trim(Str(CDbl(Aux1))))
        oCombo.AddItem Aux2
        oCombo.ItemData(oCombo.NewIndex) = Val(Arr(1))
        i = i + 1
    Loop
End If

'BacSAVP.Conectar.RecordSource = Cons
'BacSAVP.Conectar.Refresh
'
'
'
'If BacSAVP.Conectar.Recordset.RecordCount > 1 Then
'
'    BacSAVP.Conectar.Recordset.MoveFirst
'    I = 1
'    Do While I <= BacSAVP.Conectar.Recordset.RecordCount
'        Aux = Trim(BacSAVP.Conectar.Recordset.Fields(1))
'        Aux1 = Trim(BacSAVP.Conectar.Recordset.Fields(0))
'        Aux2 = (Aux & Space(50 - Len(Aux)) & Trim(Str(CDbl(Aux1))))
'        oCombo.AddItem Aux2
'        BacSAVP.Conectar.Recordset.MoveNext
'        If BacSAVP.Conectar.Recordset.EOF Then BacSAVP.Conectar.Recordset.Close: Exit Function
'        I = I + 1
'    Loop
'
'
'End If


End Function
