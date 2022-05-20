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
Attribute VB_Exposed = True
Option Explicit
Public objValorMoneda   As Object
Public coleccion        As New Collection

Function Agregar(Codigo As Integer, Fecha As String, Valor As Double)
    Dim objBuf As Object
    
    Set objBuf = New clsValorMoneda
    
    With objBuf
        .vmcodigo = Codigo
        .vmfecha = Fecha
        .vmValor = Valor
    End With
    coleccion.Add objBuf
    Set objBuf = Nothing
    
End Function


Public Function Grabar() As Boolean
    Dim Sql     As String
    Dim Msg     As String
    Dim Fila    As Integer
    Dim cCodigo As String
    Dim cFecha  As String
    Dim cValor  As String
    Dim Max     As Long
     
    Grabar = False
        
    Max = coleccion.Count
    
    For Fila = 1 To Max
        If coleccion(Fila).Grabar() = False Then
            Exit Function
        End If
    Next Fila
    
    Grabar = True
End Function

Public Sub VaciarColeccion()
    Dim Filas As Long
    Dim Max As Long
          
    Max = coleccion.Count
    For Filas = 1 To Max
        coleccion.Remove 1
    Next Filas
End Sub

Public Function Leer(Codigo As Integer, Mes As Integer, Ano As Integer) As Boolean
 
    Leer = False
    
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
            .vmValor = Val(Datos(2))
            .vmfecha = Datos(3)
        End With
        coleccion.Add objBuf
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
        objBuf.vmValor = 0
        Select Case Periodo
            Case 1
                objBuf.vmfecha = Format(Fila, "00") + "/" + Format(Mes, "00") + "/" + Trim$(Str(Ano))
            Case 30
                objBuf.vmfecha = "01" + "/" + Format(Fila, "00") + "/" + Trim$(CStr(Ano))
        End Select
        coleccion.Add objBuf
        Set objBuf = Nothing
    Next Fila
    
End Sub

Private Sub Class_Initialize()

    Set objValorMoneda = New clsValorMoneda
    
End Sub


Private Sub Class_Terminate()

    Set objValorMoneda = Nothing
    
End Sub



