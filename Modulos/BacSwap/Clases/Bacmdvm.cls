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
    

Function grabar()

   Dim Sql As String

   grabar = False
    
   Sql = "exec sp_mdvmgrabarvalmon "
   Sql = Sql & vmcodigo & ","
   Sql = Sql & BacStrTran(CStr(vmValor), ",", ".") & ","
   Sql = Sql & BacStrTran("0.0", ",", ".") & ","
   Sql = Sql & BacStrTran("0.0", ",", ".") & ","
   Sql = Sql & "'" & Format$(vmfecha, "YYYYMMDD") & "'"
   
   If SQL_Execute(Sql) <> 0 Then
      Exit Function

   End If

   Call Limpiar

   grabar = True
    
End Function

Function Leer(codigo As Integer, Fecha As String)

    Dim Sql As String

    Leer = False
    vmcodigo = codigo
    vmfecha = Format(Fecha, "YYYYMMDD")
    
    Sql = "exec sp_VmLeerInd "
    Sql = Sql & vmcodigo & ",'"
    Sql = Sql & vmfecha & "'"
          
    If SQL_Execute(Sql) <> 0 Then
       Exit Function
    End If
       
    Call Limpiar
    
    Dim Datos()
    If SQL_Fetch(Datos()) = 0 Then
       vmValor = Val(Datos(1))
       vmptacmp = Val(Datos(2))
       vmptavta = Val(Datos(3))
    End If
    
    Leer = True

End Function

Private Sub Limpiar()

    vmcodigo = 0
    vmValor = 0
    vmfecha = ""
    nUfProyec = 0
    vmptacmp = 0
    vmptavta = 0
    
End Sub

Function ValorUFProyect(Fecha As String)
    Dim Sql As String
    Dim nValor As Double
    
    vmfecha = Format(Fecha, "YYYYMMDD")
    nValor = 0
    
    Sql = "execute sp_ufproyectada "
    Sql = Sql & "'" & vmfecha & "', "
    Sql = Sql & bacTranMontoSql(nValor)
          
    If SQL_Execute(Sql) <> 0 Then
       Exit Function
    End If
    
    Call Limpiar
    
    Dim Datos()
    If SQL_Fetch(Datos()) = 0 Then
       nUfProyec = Val(Datos(1))
    End If
    
End Function
