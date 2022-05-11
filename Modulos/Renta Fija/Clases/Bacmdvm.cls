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
 Public vmvalor    As Double   'numeric 18,10
 Public vmfecha    As String












    

Function Grabar() As Boolean
   Grabar = False

   Envia = Array(CDbl(vmcodigo), CDbl(vmvalor), Format(vmfecha, "dd/mm/yyyy"))
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
    
'    Sql = "SP_VMLEERIND "
'    Sql = Sql & vmcodigo & ",'"
'    Sql = Sql & vmfecha & "'"
          
    Envia = Array(CDbl(vmcodigo), vmfecha)
    If Not Bac_Sql_Execute("SP_VMLEERIND", Envia) Then
        Exit Function
    End If
       
    Call Limpiar
    
    Dim Datos()
    If Bac_SQL_Fetch(Datos()) Then
        vmvalor = Val(Datos(1))
    End If
    
    Leer = True

End Function

Private Sub Limpiar()

    vmcodigo = 0
    vmvalor = 0
    vmfecha = ""
    
End Sub


