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
Attribute VB_Exposed = True
Option Explicit

Public vmcodigo   As Integer
Public vmValor    As Double
Public vmptacmp   As Double
Public vmptavta   As Double
Public vmfecha    As String
Public nUfProyec  As Double

Function grabar()
   
   grabar = False
    
   Envia = Array()
   AddParam Envia, CDbl(vmcodigo)
   AddParam Envia, CDbl(vmValor)
   AddParam Envia, CDbl("0.0")
   AddParam Envia, CDbl("0.0")
   AddParam Envia, Format(vmfecha, "yyyymmdd")
   
   If Not Bac_Sql_Execute("SP_MDVMGRABARVALMON", Envia) Then
   
      Exit Function

   End If

   Call Limpiar

   grabar = True
    
End Function

Function Leer(Codigo As Integer, Fecha As String)
    
   Dim Datos()
   
   Leer = False
   
   vmcodigo = Codigo
   vmfecha = Fecha
   
   Envia = Array()
   AddParam Envia, vmcodigo
   AddParam Envia, Format(vmfecha, "yyyymmdd")
          
   If Not Bac_Sql_Execute("SP_VMLEERIND", Envia) Then
    
      Exit Function
       
   End If
       
   Call Limpiar
    
   If Bac_SQL_Fetch(Datos()) Then
      
      vmValor = Datos(1)
      vmptacmp = Datos(2)
      vmptavta = Datos(3)
   
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
    
   Dim nValor As Double
   Dim Datos()
   Dim A
   
   vmfecha = Fecha
   nValor = 0
   
   Envia = Array()
   AddParam Envia, Format(vmfecha, "yyyymmdd")
   AddParam Envia, CDbl(nValor)
            
   If Not Bac_Sql_Execute("SP_UFPROYECTADA", Envia) Then
   
      Exit Function
      
   End If
   
   Call Limpiar
   
   If miSQL.SQL_Fetch(Datos()) = 0 Then
      
      nUfProyec = CDbl(Datos(1))
   
   End If
    
End Function

