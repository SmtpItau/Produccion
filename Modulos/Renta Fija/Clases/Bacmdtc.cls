VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsCodigo"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Public Codigo    As Long
Public Glosa     As String


Public Function Grabar(CodTab As Integer) As Boolean
    
    Grabar = False
    
'    Sql = "SP_TCGRABAR1  " & Chr(10)
'    Sql = Sql & CodTab & "," & Chr(10)
'    Sql = Sql & Codigo & "," & Chr(10)
'    Sql = Sql & "'" & Glosa & "'"
    
    Envia = Array(CDbl(CodTab), _
            CDbl(Codigo), _
            Glosa)
            
    If Not Bac_Sql_Execute("SP_TCGRABAR1", Envia) Then
        Exit Function
    End If
       
    Grabar = True

End Function
Public Function Leer(ByVal cCodTab As Integer, cCodigo As String) As Boolean
Dim Datos()

    Leer = False
'    Sql = "SP_TCLEEITEM1 " & cCodTab
'    Sql = Sql & ",'" & cCodigo & "'"
    
    Envia = Array(CDbl(cCodTab), _
            cCodigo)
            
    If Not Bac_Sql_Execute("SP_TCLEEITEM1", Envia) Then
        Exit Function
    End If
     
    Call Limpiar
              
    If Bac_SQL_Fetch(Datos()) Then
        Codigo = Val(Datos(1))
        Glosa = Trim$(Datos(2))
    End If
    
    Leer = True
           
End Function

Private Sub Limpiar()

    Codigo = 0
    Glosa = ""

End Sub


