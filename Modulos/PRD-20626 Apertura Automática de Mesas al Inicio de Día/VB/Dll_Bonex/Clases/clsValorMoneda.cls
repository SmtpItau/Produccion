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
 'MDVM : TABLA DE VALORES DE MONEDAS
 '------------------------------------------------
 Public vmcodigo   As Integer  'numeric   3,0
 Public vmvalor    As Double   'numeric 18,10
 Public vmfecha    As String

Function Grabar()
     
    Grabar = False
    
    Envia = Array(CDbl(vmcodigo), _
            CDbl(vmvalor), _
            Format(vmfecha, "dd/mm/yyyy"))
    
    If Not Bac_Sql_Execute("SP_VMGRABAR", Envia) Then
        Exit Function
    End If
    
    Call Limpiar
    Grabar = True
    
End Function


Function Leer(Codigo As Integer, Fecha As String)

    Leer = False
    vmcodigo = Codigo
    vmfecha = Format(Fecha, "mm/dd/yyyy")
    
    Envia = Array(CDbl(vmcodigo), vmfecha)
    If Not Bac_Sql_Execute("sp_vmleerind", Envia) Then
        Exit Function
    End If
       
    Call Limpiar
    
    Dim datos()
    If Bac_SQL_Fetch(datos()) Then
        vmvalor = Val(datos(1))
    End If
    
    Leer = True

End Function

Private Sub Limpiar()

    vmcodigo = 0
    vmvalor = 0
    vmfecha = ""
    
End Sub




