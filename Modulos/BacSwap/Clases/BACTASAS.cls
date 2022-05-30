VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "ClsTasas"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Dim Sql$, Datos(), i&

Public CodMoneda    As Integer
Public GloMoneda    As String
Public CodTasa      As Integer
Public GloTasa      As String
Public CodPerido    As Integer
Public GloPeriodo   As String
Public MesPeriodo   As Integer
Public DiaPeriodo   As Integer
Public Fecha        As Date
Public Valor        As Double

Public Sub Limpiar()

    CodMoneda = 0
    GloMoneda = ""
    CodTasa = 0
    GloTasa = ""
    CodPerido = 0
    GloPeriodo = ""
    MesPeriodo = 0
    DiaPeriodo = 0
    Fecha = gsBAC_Fecp
    Valor = 0#

End Sub

Public Function Leer(iMoneda%, iTasa%, iPeriodo%, sFecha$) As Boolean

    Leer = False

    Sql = "EXECUTE " & giSQL_DatabaseCommon & ".."
    Sql = Sql & "sp_Leer_TasasMonedas " & iMoneda
    Sql = Sql & ", " & iTasa
    Sql = Sql & ", " & iPeriodo
    Sql = Sql & ",'" & FechaYMD(sFecha) & "'"
    
    If SQL_Execute(Sql) = 0 Then
        If SQL_Fetch(Datos) = 0 Then
            CodMoneda = Val(Datos(1))
            GloMoneda = Datos(2)
            CodTasa = Val(Datos(3))
            GloTasa = Datos(4)
            CodPerido = Val(Datos(5))
            GloPeriodo = Datos(6)
            Fecha = Datos(7)
            Valor = Val(Datos(8))
            MesPeriodo = Val(Datos(11))
            DiaPeriodo = Val(Datos(12))
        End If
    End If

End Function

Public Function CargaPeriodos(iMoneda%, iTasa%, obj As Object) As Boolean

    CargaPeriodos = False

    Sql = "EXECUTE " & giSQL_DatabaseCommon & ".."
    Sql = Sql & "sp_Leer_TasasMonedas " & iMoneda%
    Sql = Sql & ", " & iTasa%
    Sql = Sql & ", 0" '-- Todos los Periodo
    Sql = Sql & ",'" & Format(gsBAC_Fecp, "yyyymmdd") & "'"
    
    If SQL_Execute(Sql) <> 0 Then
        Exit Function
    End If
    
    obj.Clear
    
    Do While SQL_Fetch(Datos) = 0
        obj.AddItem Left(Datos(6) & Space(50), 50) & Right(Space(5) & Val(Datos(11)), 5) & Right(Space(5) & Val(Datos(12)), 5)
        obj.ItemData(obj.NewIndex) = Val(Datos(5))
        CargaPeriodos = True
    Loop
          
End Function

Public Function ValorTasa(iMoneda%, iTasa%, iPeriodo%, sFecha$) As Double

    ValorTasa = 0#

    Sql = "EXECUTE " & giSQL_DatabaseCommon & ".."
    Sql = Sql & "sp_Leer_TasasMonedas " & iMoneda%
    Sql = Sql & ", " & iTasa%
    Sql = Sql & ", " & iPeriodo%
    Sql = Sql & ",'" & Format(sFecha$, "yyyymmdd") & "'"
    
    If SQL_Execute(Sql) <> 0 Then
        Exit Function
        
    ElseIf SQL_Fetch(Datos) <> 0 Then
        MsgBox "No se retorno valor de Tasa ", vbCritical, "MENSAJE"
        
    Else
        ValorTasa = Val(Datos(8))
        
    End If
          
End Function
