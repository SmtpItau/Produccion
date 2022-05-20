VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsValorMoneda"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

 'MDVM : TABLA DE VALORES DE MONEDAS
 '------------------------------------------------
 Public vmcodigo   As Integer  'numeric   3,0
 Public vmValor    As Double   'numeric 18,10
 Public vmptacmp   As Double   'numeric 18,10
 Public vmptavta   As Double   'numeric 18,10
 Public vmfecha    As String
 Public nUfProyec  As Double    'UF Proyectada
    

Function Grabar()

   Dim Sql As String

   Grabar = False
    
''''''''''''''''''   Sql = "exec sp_mdvmgrabarvalmon "
''''''''''''''''''   Sql = Sql & vmcodigo & ","
''''''''''''''''''   Sql = Sql & BacStrTran(CStr(vmValor), ",", ".") & ","
''''''''''''''''''   Sql = Sql & BacStrTran("0.0", ",", ".") & ","
''''''''''''''''''   Sql = Sql & BacStrTran("0.0", ",", ".") & ","
''''''''''''''''''   Sql = Sql & "'" & Format$(vmfecha, "YYYYMMDD") & "'"
   
   Envia = Array()
   
   AddParam Envia, CDbl(vmcodigo)
   AddParam Envia, BacStrTran(CStr(vmValor), ",", ".")
   AddParam Envia, BacStrTran("0.0", ",", ".")
   AddParam Envia, BacStrTran("0.0", ",", ".")
   AddParam Envia, Format$(vmfecha, "YYYYMMDD")
   
   
   If Not Bac_Sql_Execute("sp_mdvmgrabarvalmon", Envia) Then
      
      Exit Function

   End If

   Call Limpiar

   Grabar = True
    
End Function

Private Sub Limpiar()

    vmcodigo = 0
    vmValor = 0
    vmfecha = ""
    nUfProyec = 0
    vmptacmp = 0
    vmptavta = 0
    
End Sub

