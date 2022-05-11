VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsOperador"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'MDOP : TABLA DE OPERADORES
'-----------------------------------------------
Public opcodigo   As Long
Public opdigito   As String
Public opnombre   As String


Public Sub Limpiar()

  opcodigo = 0
  opnombre = ""
  opdigito = ""

End Sub

Public Function LeerPorCodigo(CodigoOp As Long) As Boolean

   Dim Sql           As String
   Dim DATOS()

   LeerPorCodigo = False
          
   Envia = Array()
   
   AddParam Envia, CodigoOp
          
   If Not Bac_Sql_Execute("SP_OPLEERCODIGO1", Envia) Then
      
      Exit Function

   End If

   Call Limpiar

   If Bac_SQL_Fetch(DATOS()) Then
      opcodigo = Val(DATOS(1))
      opnombre = DATOS(2)

   End If

   LeerPorCodigo = True

End Function

Public Function grabar(opcion As Integer) As Boolean

   Dim Sql As String

   grabar = False

''''''''''''''''''''   Sql = "exec SP_OPGRABAR1 " & vbCrLf
''''''''''''''''''''   Sql = Sql & opcodigo & "," & vbCrLf
''''''''''''''''''''   Sql = Sql & "'" & opnombre & "'" & "," & opcion & vbCrLf

   Envia = Array()

   
   AddParam Envia, opcodigo
   AddParam Envia, opnombre
   AddParam Envia, opcion
   
   If Not Bac_Sql_Execute("SP_OPGRABAR1", Envia) Then
      
      Exit Function

   End If

   Call Limpiar

   grabar = True

End Function

Public Function Eliminar(CodigoOp As Long) As Boolean

   Dim Sql As String

   Eliminar = False

   Envia = Array()
   
   AddParam Envia, CodigoOp

   If Not Bac_Sql_Execute("SP_OPELIMINAR1 ", Envia) Then
      
      Exit Function

   End If

   Call Limpiar

   Eliminar = True
    
End Function

Private Sub Class_Initialize()

   Call Limpiar
    
End Sub

Public Function EliminarOperador(rutcli As String, codcli As String) As Boolean
Dim Sql As String


If eliminame <> 100 Then
   
   EliminarOperador = False
   
   Envia = Array()
   
   AddParam Envia, 0
   AddParam Envia, CDbl(rutcli)
   AddParam Envia, CDbl(codcli)
   
   If Not Bac_Sql_Execute("SP_BORRAR_OPERADOR", Envia) Then
       
       Exit Function
   
   End If
   
   EliminarOperador = True

Else
   
    
    
   EliminarOperador = False
   
   Envia = Array()
   
   AddParam Envia, CDbl(codcli)
   AddParam Envia, CDbl(rutcli)
   AddParam Envia, CDbl(opecod)
   
   
   If Not Bac_Sql_Execute("SP_BORRAR_OPERADOR1", Envia) Then
       
       Exit Function
   
   End If
   
   EliminarOperador = True

End If
   

End Function

Public Function GrabarOperadores(obj As Object, rutcli As String, codcli As String) As Boolean

   Dim Fila       As Long
   Dim Sql        As String
   Dim iLin       As Integer
   Dim imax       As Integer

With obj
    
For iLin = 1 To obj.Rows - 1
 
    'obj.Row = iLin
       
    If Trim(obj.TextMatrix(iLin, 0)) <> "" And Trim(obj.TextMatrix(iLin, 1)) <> "" Then
       
''''''''''''       Sql = ""
''''''''''''       Sql = "Sp_Grabar_Operador "
''''''''''''       Sql = Sql & Val(rutcli)
''''''''''''       Sql = Sql & "," & Val(codcli)
''''''''''''       Sql = Sql & "," & Val(obj.TextMatrix(obj.Row, 0))
''''''''''''       Sql = Sql & "," & 0
''''''''''''       Sql = Sql & ",'" & UCase(obj.TextMatrix(obj.Row, 1)) & "'"
       
       Envia = Array()
                    
       AddParam Envia, CDbl(rutcli)
       AddParam Envia, CDbl(codcli)
       AddParam Envia, CDbl(obj.TextMatrix(iLin, 0))
       AddParam Envia, 0
       AddParam Envia, UCase(obj.TextMatrix(iLin, 1))
                    
             
       If Not Bac_Sql_Execute("SP_GRABAR_OPERADOR ", Envia) Then
         
         Exit Function

       End If
                
   End If
   
Next iLin

End With
   GrabarOperadores = True

End Function

