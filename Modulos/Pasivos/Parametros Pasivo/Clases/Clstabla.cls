VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsTabla"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'Agregar un campo que indique si se puede mantener o no.
Public CodTab    As Integer
Public GlosaTab  As String
Public TabCod    As New Collection




'Public Function LeerTabCod(ByVal ncodtab As Integer) As Boolean
'
'Dim Sql   As String
'Dim Datos()
'
'    LeerTabCod = False
'    Sql = "EXEC Sp_TcLeeItem " & ncodtab
'    If SM_Execute(Sql) <> 0 Then
'        Exit Function
'    End If
'
'    TabCodClear
'    CodTab = ncodtab%
'
'    Do While SM_Fetch(Datos()) = 0
'        Dim oCodigo As New clsCodigo
'        oCodigo.codigo = Val(Datos(1))
'        oCodigo.glosa = Trim$(Datos(2))
'        TabCod.Add oCodigo
'        Set oCodigo = Nothing
'    Loop
'    LeerTabCod = True
'
'End Function
'




'Public Function LeerTabla() As Boolean
'
'Dim Sql   As String
'Dim Datos()
'
'    LeerTabla = False
'    Sql = "EXEC Sp_TcLeeTod"
'    If SM_Execute(Sql) <> 0 Then
'       Exit Function
'    End If
'
'    TabCodClear
'
'    Do While SM_Fetch(Datos()) = 0
'        Dim oCodigo As New clsCodigo
'        oCodigo.codigo = Val(Datos(1))
'        oCodigo.glosa = Trim$(Datos(2))
'        TabCod.Add oCodigo
'        Set oCodigo = Nothing
'    Loop
'
'    LeerTabla = True
'
'End Function


Public Sub TabCodClear()

Dim Filas As Long
          
    For Filas = 1 To TabCod.Count
        TabCod.Remove 1
    Next Filas
          
End Sub

Public Sub Tab2List(oControl As Object)

Dim Filas   As Long
Dim IdGlosa As String * 25
          
    oControl.Clear
    For Filas = 1 To TabCod.Count
        IdGlosa = TabCod(Filas).glosa
        oControl.AddItem IdGlosa
        oControl.ItemData(oControl.NewIndex) = TabCod(Filas).codigo
    Next Filas
    
End Sub

Public Sub Tab2Grid(oControl As Object)
Dim Filas As Long

          oControl.Rows = 1
          For Filas = 1 To TabCod.Count
              oControl.Rows = oControl.Rows + 1
              oControl.Row = oControl.Rows - 1
              oControl.Col = 1: oControl.Text = Mid$(TabCod(Filas).glosa, 126, 3)
              oControl.Col = 2: oControl.Text = Mid$(TabCod(Filas).glosa, 1, 25)
          Next Filas

End Sub


