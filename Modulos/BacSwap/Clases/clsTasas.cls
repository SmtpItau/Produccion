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

Dim Sql$, DATOS(), i&

' Tasas por Monedas y Periodo segun Tasa : MDTASASMONEDAS
'--------------------------------------------------------

Public CodMoneda    As Integer
Public GloMoneda    As String
Public CodTasa      As Integer
Public GloTasa      As String
Public CodPeriodo   As Integer
Public GloPeriodo   As String
Public MesPeriodo   As Integer
Public DiaPeriodo   As Integer
Public Fecha        As Date
Public Valor        As String

Public Function Grabar() As Boolean

'    Sql = "EXECUTE " & giSQL_DatabaseCommon & ".."
'    Sql = Sql & "sp_Grabar_TasasMonedas '" & Sistema & "'"
'    Sql = Sql & ", " & CodMoneda
'    Sql = Sql & ", " & CodTasa
'    Sql = Sql & ",'" & FechaYMD(Fecha) & "'"
'    Sql = Sql & ", " & CDbl(Valor)
'    Sql = Sql & ", " & CodPeriodo
    
    Envia = Array()
    AddParam Envia, CodMoneda
    AddParam Envia, CodTasa
    AddParam Envia, Format(Fecha, "yyyymmdd")
    AddParam Envia, CDbl(Valor)
    AddParam Envia, CodPeriodo
    
'    Grabar = (MISQL.SQL_Execute(Sql) = 0)
    grabar = (Bac_Sql_Execute("SP_GRABAR_TASASMONEDAS", Envia))
    
'    If MISQL.SQL_Fetch(DATOS) = 0 Then
    If Bac_SQL_Fetch(DATOS()) Then
        If Val(DATOS(1)) < 0 Then
            Grabar = False
            MsgBox DATOS(2), vbInformation, Msj
        End If
    End If
    
End Function
Public Sub Limpiar()

    CodMoneda = 0
    GloMoneda = ""
    CodTasa = 0
    GloTasa = ""
    CodPeriodo = 0
    GloPeriodo = ""
    MesPeriodo = 0
    DiaPeriodo = 0
    Fecha = gsBAC_Fecp
    Valor = 0#

End Sub

Public Function Leer(iMoneda%, iTasa%, iPeriodo%, sFecha$) As Boolean

    Leer = False

'    Sql = "EXECUTE " & giSQL_DatabaseCommon & ".."
'    Sql = Sql & "sp_Leer_TasasMonedas " & iMoneda
'    Sql = Sql & ", " & iTasa
'    Sql = Sql & ", " & iPeriodo
'    Sql = Sql & ",'" & FechaYMD(sFecha) & "'"
    
    Envia = Array()
    AddParam Envia, CDbl(iTasa)
    AddParam Envia, iPeriodo
    AddParam Envia, Format(sFecha, "yyyymmdd")
    
'    If MISQL.SQL_Execute(Sql) = 0 Then
    If Bac_Sql_Execute("SP_LEER_TASASMONEDAS", Envia) Then
    
'        If MISQL.SQL_Fetch(DATOS) = 0 Then
        If Bac_SQL_Fetch(DATOS()) Then
            CodMoneda = Val(DATOS(1))
            GloMoneda = DATOS(2)
            CodTasa = Val(DATOS(3))
            GloTasa = DATOS(4)
            CodPeriodo = Val(DATOS(5))
            GloPeriodo = DATOS(6)
            Fecha = DATOS(7)
            Valor = Val(DATOS(8))
            MesPeriodo = Val(DATOS(11))
            DiaPeriodo = Val(DATOS(12))
        End If
    End If

End Function

Public Function CargaPeriodos(iMoneda%, iTasa%, obj As Object) As Boolean

    CargaPeriodos = False

'    Sql = "EXECUTE " & giSQL_DatabaseCommon & ".."
'    Sql = Sql & "sp_Leer_TasasMonedas " & iMoneda%
'    Sql = Sql & ", " & iTasa%
'    Sql = Sql & ", 0" '-- Todos los Periodo
'    Sql = Sql & ",'" & Format(gsBAC_Fecp, "yyyymmdd") & "'"
    
    Envia = Array()
    AddParam Envia, CDbl(iTasa%)
    AddParam Envia, CDbl(0)
    AddParam Envia, Format(gsBAC_Fecp, "yyyymmdd")
    
'    If MISQL.SQL_Execute(Sql) <> 0 Then
    If Not Bac_Sql_Execute("SP_LEER_TASASMONEDAS", Envia) Then
        Exit Function
    End If
    
    obj.Clear
    
'    Do While MISQL.SQL_Fetch(DATOS) = 0
    Do While Bac_SQL_Fetch(DATOS())
        obj.AddItem Left(DATOS(6) & Space(50), 50) & Right(Space(5) & Val(DATOS(11)), 5) & Right(Space(5) & Val(DATOS(12)), 5)
        obj.ItemData(obj.NewIndex) = Val(DATOS(5))
        CargaPeriodos = True
    Loop
          
End Function

Public Function ValorTasa(iMoneda%, iTasa%, iPeriodo%, sFecha$) As Double

    ValorTasa = 0#

    Sql = "EXECUTE " & giSQL_DatabaseCommon & ".."
    Sql = Sql & "SP_LEER_TASASMONEDAS " & iMoneda%
    Sql = Sql & ", " & iTasa%
    Sql = Sql & ", " & iPeriodo%
    Sql = Sql & ",'" & Format(sFecha$, "yyyymmdd") & "'"
    
    Envia = Array()
    AddParam Envia, CDbl(iTasa%)
    AddParam Envia, CDbl(iPeriodo%)
    AddParam Envia, Format(sFecha$, "yyyymmdd")
    
'    If MISQL.SQL_Execute(Sql) <> 0 Then
    If Bac_Sql_Execute("SP_LEER_TASASMONEDAS", Envia) <> 0 Then
        Exit Function
        
'    ElseIf MISQL.SQL_Fetch(DATOS) = 0 Then
    ElseIf Bac_SQL_Fetch(DATOS()) = 0 Then
    'MsgBox "No se retorno valor de Tasa ", vbCritical, "MENSAJE"
        
    'Else
        ValorTasa = Val(DATOS(8))
        
    End If
          
End Function
