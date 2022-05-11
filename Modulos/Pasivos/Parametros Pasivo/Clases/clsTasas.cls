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
Public fecha        As Date
Public Valor        As String

Public Tabla        As String
Public codigo       As String
Public glosa        As String

Public Function grabar() As Boolean

'''''''''''''''''''    Sql = "sp_Grabar_TasasMonedas '" & Sistema & "'"
'''''''''''''''''''    Sql = Sql & ", " & CodMoneda
'''''''''''''''''''    Sql = Sql & ", " & CodTasa
'''''''''''''''''''    Sql = Sql & ",'" & FechaYMD(fecha) & "'"
'''''''''''''''''''    Sql = Sql & ", " & CDbl(Valor)
'''''''''''''''''''    Sql = Sql & ", " & CodPeriodo
    
    Envia = Array()
    
    AddParam Envia, Sistema
    AddParam Envia, CDbl(CodMoneda)
    AddParam Envia, CDbl(CodTasa)
    AddParam Envia, FechaYMD2(fecha)
    AddParam Envia, CDbl(Valor)
    AddParam Envia, CodPeriodo
    
    
    grabar = (BAC_SQL_EXECUTE("sp_Grabar_TasasMonedas", Envia))
    
    If BAC_SQL_FETCH(Datos()) Then
        
        If Val(Datos(1)) < 0 Then
            
            grabar = False
            MsgBox Datos(2), vbInformation
        
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
    fecha = gsbac_fecp
    Valor = 0#

End Sub

Public Function Leer(iMoneda%, iTasa%, iPeriodo%, sFecha$) As Boolean

    Leer = False

''''''''''''''''''''    Sql = "sp_Leer_TasasMonedas " & iMoneda
''''''''''''''''''''    Sql = Sql & ", " & iTasa
''''''''''''''''''''    Sql = Sql & ", " & iPeriodo
''''''''''''''''''''    Sql = Sql & ",'" & FechaYMD(sFecha) & "'"
    
    Envia = Array()
    
    AddParam Envia, iMoneda
    AddParam Envia, iTasa
    AddParam Envia, iPeriodo
    AddParam Envia, FechaYMD2(sFecha)
    
    If BAC_SQL_EXECUTE("sp_Leer_TasasMonedas", Envia) Then
        
        If BAC_SQL_FETCH(Datos()) Then
            
            CodMoneda = Val(Datos(1))
            GloMoneda = Datos(2)
            CodTasa = Val(Datos(3))
            GloTasa = Datos(4)
            CodPeriodo = Val(Datos(5))
            GloPeriodo = Datos(6)
            fecha = Datos(7)
            Valor = Val(Datos(8))
            MesPeriodo = Val(Datos(11))
            DiaPeriodo = Val(Datos(12))
        
        End If
    
    End If

End Function

Public Function CargaPeriodos(iMoneda%, iTasa%, obj As Object) As Boolean

    CargaPeriodos = False

'''''''''''''''''''    Sql = "sp_Leer_TasasMonedas " & iMoneda%
'''''''''''''''''''    Sql = Sql & ", " & iTasa%
'''''''''''''''''''    Sql = Sql & ", 0" '-- Todos los Periodo
'''''''''''''''''''    Sql = Sql & ",'" & Format(gsbac_fecp, "yyyymmdd") & "'"
    
    Envia = Array()
    
    AddParam Envia, iMoneda%
    AddParam Envia, iTasa%
    AddParam Envia, 0   '-- Todos los Periodo
    AddParam Envia, Format(gsbac_fecp, "yyyymmdd")
    
    If Not BAC_SQL_EXECUTE("sp_Leer_TasasMonedas", Envia) Then
        
        Exit Function
    
    End If
    
    obj.Clear
    
    Do While BAC_SQL_FETCH(Datos())
        
        obj.AddItem Left(Datos(6) & Space(50), 50) & Right(Space(5) & Val(Datos(11)), 5) & Right(Space(5) & Val(Datos(12)), 5)
        obj.ItemData(obj.NewIndex) = Val(Datos(5))
        CargaPeriodos = True
    
    Loop
          
End Function

Public Function ValorTasa(iMoneda%, iTasa%, iPeriodo%, sFecha$) As Double

    ValorTasa = 0#

'''''''''''''''''''    Sql = "sp_Leer_TasasMonedas " & iMoneda%
'''''''''''''''''''    Sql = Sql & ", " & iTasa%
'''''''''''''''''''    Sql = Sql & ", " & iPeriodo%
'''''''''''''''''''    Sql = Sql & ",'" & Format(sFecha$, "yyyymmdd") & "'"
    
    Envia = Array()
    
    AddParam Envia, iMoneda%
    AddParam Envia, iTasa%
    AddParam Envia, iPeriodo%
    AddParam Envia, Format(sFecha$, "yyyymmdd")
    
    
    If Not BAC_SQL_EXECUTE("sp_Leer_TasasMonedas", Envia) Then
        
        Exit Function
        
    ElseIf BAC_SQL_FETCH(Datos()) Then
        
        ValorTasa = Val(Datos(8))
        
    End If
          
End Function



Public Function LeerTc(iTabla%, iCodigo%) As Boolean

    Dim Sql As String
    LeerTc = False
    
    'Sql = "EXECUTE sp_Leer_TC " & iTabla & "," & ICodigo
    
    Envia = Array(CDbl(iTabla), _
                  iCodigo)
    If Not BAC_SQL_EXECUTE("sp_Leer_TC", Envia) Then
        Exit Function
    End If
     
    'Call Limpiar
              
    If BAC_SQL_FETCH(Datos()) Then
        Tabla = Val(Datos(1))
        codigo = Val(Datos(2))
        glosa = UCase(Trim$(Datos(3)))
        LeerTc = True
    End If
    
End Function

