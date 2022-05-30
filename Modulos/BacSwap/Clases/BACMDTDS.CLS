VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "clsTDesarrollos"
Attribute VB_Creatable = True
Attribute VB_Exposed = True
Option Explicit

Public objDesarrollo As Object
Public Coleccion  As New Collection
Private Function BacDivision(IdDivi1 As Double, IdDivi2 As Double) As Double

    If IdDivi1 = 0 Or IdDivi2 = 0 Then
       BacDivision = 0
    Else
       BacDivision = (IdDivi1 / IdDivi2)
    End If

End Function


Public Function Calcula() As Integer
Dim SQL As String
Dim Datos()

    Calcula = False
    
    ' Generamos cálculos para la tabla de desarrollo
    '--------------------------------------------------
    SQL = "EXECUTE sp_tdgenerar "
    SQL = SQL & "'" & objDesarrollo.tdmascara & "'," 'Máscara
    SQL = SQL & "'" & objDesarrollo.tdfecven & "',"  'Fecha Vencimiento
    SQL = SQL & objDesarrollo.tdinteres & ","        'Interes ó Tera
    SQL = SQL & objDesarrollo.tdcupon & ","          'Cupones
    SQL = SQL & objDesarrollo.tdamort & ","          'Amortización
    SQL = SQL & objDesarrollo.tdPeriodo & ","        'Periodo Vcto Cupón
    SQL = SQL & objDesarrollo.tdDecimales            'Nº de Decimales

    If SQL_Execute(SQL) <> 0 Then
       Exit Function
    End If
          
    'Limpiamos la colección
    '--------------------------------------------------
    Call VaciarColeccion
    
    ' Traspasamos datos a la colección
    '--------------------------------------------------
    Do While SQL_Fetch(Datos()) = 0
        Dim oTdesarrollo As New clsTDesarrollo
            oTdesarrollo.tdmascara = Datos(1)
            oTdesarrollo.tdfecven = Datos(2)
            oTdesarrollo.tdcupon = Datos(3)
            oTdesarrollo.tdinteres = Datos(4)
            oTdesarrollo.tdamort = Datos(5)
            oTdesarrollo.tdflujo = Datos(6)
            oTdesarrollo.tdsaldo = Datos(7)
        Coleccion.Add oTdesarrollo
        Set oTdesarrollo = Nothing
    Loop
         
    Calcula = True
    
End Function
Public Function Grabar() As Boolean

Dim SQL         As String
Dim F           As Long
Dim Max         As Long

   Grabar = False
    
   If SQL_Execute("BEGIN TRANSACTION") <> 0 Then
      Exit Function
   End If

    Max = Coleccion.Count
    For F = 1 To Max
         If Coleccion(F).Grabar() = False Then
            If SQL_Execute("ROLLBACK TRANSACTION") <> 0 Then
                Exit Function
            End If
           Exit For
        End If
    Next F
   
    If SQL_Execute("COMMIT TRANSACTION") <> 0 Then
       Exit Function
    End If
   
    Grabar = True

End Function


Public Function Leer(IdMascara As String) As Boolean

Dim SQL As String

    Leer = False
    
    SQL = "Exec Sp_TdLeer '" & IdMascara & "'"
     
    If SQL_Execute(SQL) <> 0 Then
       Exit Function
    End If
    
    Dim Datos()
    
    Call VaciarColeccion
    
    Do While SQL_Fetch(Datos()) = 0
       Dim objBuf As New clsTDesarrollo
       With objBuf
           .tdmascara = Datos(1)
           .tdcupon = Datos(2)
           .tdfecven = Datos(3)
           .tdinteres = Val(Datos(4))
           .tdamort = Val(Datos(5))
           .tdflujo = Val(Datos(6))
           .tdsaldo = Val(Datos(7))
        End With
       Coleccion.Add objBuf
       Set objBuf = Nothing
    Loop
    
    Leer = True
    
End Function



Private Sub VaciarColeccion()
Dim Filas As Long
          
          For Filas = 1 To Coleccion.Count
                   Coleccion.Remove 1
          Next Filas
          
End Sub

Private Sub Class_Initialize()
       Set objDesarrollo = New clsTDesarrollo
End Sub


Private Sub Class_Terminate()
        Set objDesarrollo = Nothing
End Sub


