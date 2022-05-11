VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "Clstipmonedas"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit
 
Public objMoneda As Object
Public Coleccion As New Collection

Public Function BuscaCombo(nCod As Integer) As Long
Dim Max As Long
Dim FILAS As Long

    BuscaCombo = -1
    Max = Coleccion.Count
    
    For FILAS = 1 To Max
        If Coleccion(FILAS).Codigo = nCod Then
            BuscaCombo = FILAS - 1
            Exit Function
        End If
    Next FILAS

End Function

Public Sub LlenaCombo(objControl As Object)
Dim FILAS As Long
Dim Max   As Long

    objControl.Clear
    Max = Coleccion.Count
    
    For FILAS = 1 To Max
        objControl.AddItem Coleccion(FILAS).Nemo
        objControl.ItemData(objControl.NewIndex) = Coleccion(FILAS).Codigo
    Next FILAS
          
End Sub

Public Sub Llama()
Dim Datos()

    If miSQL.SQL_Execute("EXECUTE SP_LEEMONEDAS") <> 0 Then
        MsgBox "Error en la lectura de las Monedas ", vbExclamation, gsBac_Version
        Exit Sub
    End If
    
    Call LimpiaColeccion
    
    Do While Bac_SQL_Fetch(Datos())
        Dim objBuf As New ClsTipomoneda
        With objBuf
            .Nemo = Trim$(Datos(1))
            .Codigo = Val(Datos(2))
            .base = Val(Datos(3))
            .Valor = Val(Datos(4))
        End With
        Coleccion.Add objBuf
        Set objBuf = Nothing
    Loop
    
End Sub

Public Sub LimpiaColeccion()
Dim FILAS   As Long
Dim Max     As Long
          
    Max = Coleccion.Count
    For FILAS = 1 To Max
        Coleccion.Remove 1
    Next FILAS
          
End Sub
Private Sub Class_Initialize()
                Set objMoneda = New ClsTipomoneda
                
End Sub


Private Sub Class_Terminate()
                    Set objMoneda = Nothing
End Sub


