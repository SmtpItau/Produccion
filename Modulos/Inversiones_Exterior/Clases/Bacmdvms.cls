VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsValoresMoneda"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Public objValorMoneda   As Object
Public Coleccion        As New Collection

Function Agregar(Codigo As Integer, Fecha As String, Valor As Double)
Dim objBuf As Object

    Set objBuf = New clsValorMoneda
    With objBuf
        .vmcodigo = Codigo
        .vmfecha = Fecha
        .vmvalor = Valor
    End With
    Coleccion.Add objBuf
    Set objBuf = Nothing
    
End Function


Public Function Grabar() As Integer
Dim Sql     As String
Dim Msg     As String
Dim Fila    As Integer
Dim cCodigo As String
Dim cFecha  As String
Dim cValor  As String
Dim Max     As Long
     
    Grabar = False
        
    If Not BacBeginTransaction() Then
       Grabar = 1
       Exit Function
    End If
    
    Max = Coleccion.Count
    For Fila = 1 To Max
        If Coleccion(Fila).Grabar() = False Then
            If Not BacRollBackTransaction() Then
               Grabar = 2
               Exit Function
            End If
            Exit For
        End If
    Next Fila
    
    If Not BacCommitTransaction() <> 0 Then
       Grabar = 3
       Exit Function
    End If
    
    Grabar = True
    
End Function

Public Sub VaciarColeccion()
Dim FILAS As Long
Dim Max As Long
          
    Max = Coleccion.Count
    For FILAS = 1 To Max
        Coleccion.Remove 1
    Next FILAS
          
End Sub

Public Function Leer(Codigo As Integer, Mes As Integer, Ano As Integer) As Boolean
 
    Leer = False
    
'    Sql = "SP_VMLEER " & Codigo & ", " & Mes & ", " & Ano

    Envia = Array(CDbl(Codigo), CDbl(Mes), CDbl(Ano))
   
    If Not Bac_Sql_Execute("SP_VMLEER", Envia) Then
       Exit Function
    End If
    
    Call VaciarColeccion
    
    Dim Datos()
    Do While Bac_SQL_Fetch(Datos())
        Dim objBuf As New clsValorMoneda
        With objBuf
            .vmcodigo = Val(Datos(1))
            .vmvalor = Val(Datos(2))
            .vmfecha = Datos(3)
        End With
        Coleccion.Add objBuf
        Set objBuf = Nothing
    Loop
     
    Leer = True
    
End Function

Public Sub Coleccion2Control(CodMoneda As Integer, Periodo As Integer, LargoDia As Integer, Mes As Integer, Ano As Integer)
Dim Fila    As Integer
Dim IdLargo As Integer

    For Fila = 1 To LargoDia
        Dim objBuf As New clsValorMoneda
        objBuf.vmcodigo = CodMoneda
        objBuf.vmvalor = 0
        Select Case Periodo
            Case 1
                objBuf.vmfecha = Format(Fila, "00") + "/" + Format(Mes, "00") + "/" + Trim$(Str(Ano))
            Case 30
                objBuf.vmfecha = "01" + "/" + Format(Fila, "00") + "/" + Trim$(CStr(Ano))
        End Select
        Coleccion.Add objBuf
        Set objBuf = Nothing
    Next Fila
    
End Sub

Private Sub Class_Initialize()

    Set objValorMoneda = New clsValorMoneda
    
End Sub


Private Sub Class_Terminate()

    Set objValorMoneda = Nothing
    
End Sub


