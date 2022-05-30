VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "clsValoresMoneda"
Attribute VB_Creatable = True
Attribute VB_Exposed = True
Option Explicit

Public objValorMoneda   As Object
Public Coleccion        As New Collection

Function Agregar(codigo As Integer, Fecha As String, Valor As Double)

'Agrega un nuevo miembro a la coleccion

Dim objBuf As Object

    Set objBuf = New clsValorMoneda
    With objBuf
        .vmcodigo = codigo
        .vmfecha = Fecha
        .vmvalor = Valor
    End With
    Coleccion.Add objBuf
Set objBuf = Nothing
    
End Function


Public Function grabar() As Integer

'Graba todos los miembros de la coleccion

Dim SQL     As String
Dim Msg     As String
Dim Fila    As Integer

Dim cCodigo As String
Dim cFecha  As String
Dim cValor  As String
Dim Max     As Long
     
    grabar = False
        
    If SQL_Execute("BEGIN TRANSACTION") <> 0 Then
       grabar = 1
       Exit Function
    End If
    
    Max = Coleccion.Count
    For Fila = 1 To Max
        If Coleccion(Fila).grabar() = False Then
            If SQL_Execute("ROLLBACK TRANSACTION") <> 0 Then
               grabar = 2
               Exit Function
            End If
            Exit For
        End If
    Next Fila
    
    If SQL_Execute("COMMIT TRANSACTION") <> 0 Then
       grabar = 3
       Exit Function
    End If
    
    grabar = True
    
End Function

Public Sub VaciarColeccion()

Dim Filas As Long
Dim Max As Long
          
    Max = Coleccion.Count
    For Filas = 1 To Max
        Coleccion.Remove 1
    Next Filas
          
End Sub

Public Function Leer(codigo As Integer, Mes As Integer, Ano As Integer) As Boolean

'Lee para un codigo, mes y año los valores de la moneda
'Si el mes es cero, el periodo es mensual --> Lee los 12 meses del año
Dim SQL As String
 
    Leer = False
    
    SQL = "Exec Sp_mdvmleervalmon " & codigo & ", " & Mes & ", " & Ano
   
    If SQL_Execute(SQL) <> 0 Then
       Exit Function
    End If
    
    Call VaciarColeccion
    
    Dim Datos()
    Do While SQL_Fetch(Datos()) = 0
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

'Public Sub Coleccion2Control(CodMoneda As Integer, Periodo As Integer, LargoDia As Integer, Mes As Integer, Ano As Integer)
Public Sub Coleccion2Control(CodMoneda As Integer, LargoDia As Integer, Mes As Integer, Ano As Integer)

Dim Fila    As Integer
Dim IdLargo As Integer

    For Fila = 1 To LargoDia
        Dim objBuf As New clsValorMoneda
        objBuf.vmcodigo = CodMoneda
        objBuf.vmvalor = 0
       ' Select Case Periodo
       '     Case 1
                objBuf.vmfecha = Format(Fila, "00") + "/" + Format(Mes, "00") + "/" + Trim$(Str(Ano))
       '     Case 30
       '         objBuf.vmfecha = "01" + "/" + Format(Fila, "00") + "/" + Trim$(CStr(Ano))
       ' End Select
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


