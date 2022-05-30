VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "clsValoresMoneda"
Attribute VB_Creatable = True
Attribute VB_Exposed = True
Option Explicit

Public objValorMoneda   As Object
Public objColeccion     As New Collection

Private Function BacStrTran(sCadena$, sFind$, sReplace$) As String
         
Dim iPos%
Dim iLen%
         
    iPos% = 1
    iLen% = Len(sFind$)
    Do While True
        iPos% = InStr(1, sCadena$, sFind$)
        If iPos% = 0 Then
                Exit Do
        End If
        sCadena$ = Mid$(sCadena$, 1, iPos% - 1) + sReplace$ + Mid$(sCadena$, iPos% + iLen%)
    Loop
    BacStrTran = sCadena$
         
End Function

Public Function Grabar() As Integer

Dim SQL     As String
Dim Msg     As String
Dim Fila    As Integer

Dim cCodigo As String
Dim cFecha  As String
Dim cValor  As String
Dim Max     As Long
     
    Grabar = False
        
    If sm_Execute("BEGIN TRANSACTION") <> 0 Then
       Grabar = 1
       Exit Function
    End If
    
    Max = TabVmon.Count
    For Fila = 1 To Max
        objValorMoneda.vmcodigo = objColecion(Fila).vmcodigo
        objValorMoneda.vmvalor = BacStrTran(CDbl(objColeccion(Fila).vmvalor), ",", ".")
        objValorMoneda.vmfecha = Format(objColeccion(Fila).vmfecha, "mm/dd/yyyy")
        If objValorMoneda.Grabar() = False Then
           If sm_Execute("ROLLBACK TRANSACTION") <> 0 Then
              Grabar = 2
              Exit Function
           End If
           Exit For
        End If
    Next Fila
    
    If sm_Execute("COMMIT TRANSACTION") <> 0 Then
       Grabar = 3
       Exit Function
    End If
    
    Grabar = True
    
End Function

Public Sub VaciarColeccion()

Dim Filas As Long
Dim Max As Long
          
    Max = TabVmon.Count
    For Filas = 1 To Max
        objColeccion.Remove 1
    Next Filas
          
End Sub

Public Function Leer(Codigo As Integer, Mes As Integer, Ano As Integer) As Boolean

Dim SQL As String
 
    Leer = False
    
    SQL = "Exec Sp_VmLeer " & Codigo & ", " & Mes & ", " & Ano
   
    If sm_Execute(SQL) <> 0 Then
       Exit Function
    End If
    
    Call VaciarColeccion
    
    Dim Datos()
    Do While sm_Fetch(Datos()) = 0
        Dim objBuf As New clsValorMoneda
        With objBuf
            .vmcodigo = Val(Datos(1))
            .vmvalor = Val(Datos(2))
            .vmfecha = Datos(3)
        End With
        objColeccion.Add objBuf
        Set objBuf = Nothing
    Loop
     
    Leer = True
    
End Function

Public Sub Coleccion2Control(CodMoneda As Integer, Periodo As Integer, LargoDia As Integer, Mes As Integer, Ano As Integer)

Dim Fila    As Integer
Dim IdLargo As Integer

    objBuf.vmcodigo = CodMoneda
    For Fila = 1 To LargoDia
        Dim objBuf As New clsValorMoneda
        objBuf.vmvalor = 0
        Select Case Periodo
            Case 1
                objBuf.vmfecha = Format(Fila, "00") + "/" + Format(Mes, "00") + "/" + Trim$(Str(Ano))
            Case 30
                objBuf.vmfecha = "01" + "/" + Format(Fila, "00") + "/" + Trim$(CStr(Ano))
        End Select
        objColeccion.Add objBuf
        Set objBuf = Nothing
    Next Fila
    
End Sub

Private Sub Class_Initialize()

    Set objValorMoneda = New clsValorMoneda
    
End Sub


Private Sub Class_Terminate()

    Set objValorMoneda = Nothing
    
End Sub


