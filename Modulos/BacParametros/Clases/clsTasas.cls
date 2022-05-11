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
    
    
    Grabar = (Bac_Sql_Execute("SP_GRABAR_TASASMONEDAS", Envia))
    
    If Bac_SQL_Fetch(DATOS()) Then
        
        If Val(DATOS(1)) < 0 Then
            
            grabar = False
            MsgBox DATOS(2), vbInformation, TITSISTEMA
        
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
    
    If Bac_Sql_Execute("SP_LEER_TASASMONEDAS", Envia) Then
        
        If Bac_SQL_Fetch(DATOS()) Then
            
            CodMoneda = Val(DATOS(1))
            GloMoneda = DATOS(2)
            CodTasa = Val(DATOS(3))
            GloTasa = DATOS(4)
            CodPeriodo = Val(DATOS(5))
            GloPeriodo = DATOS(6)
            fecha = DATOS(7)
            Valor = Val(DATOS(8))
            MesPeriodo = Val(DATOS(11))
            DiaPeriodo = Val(DATOS(12))
        
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
    
    If Not Bac_Sql_Execute("SP_LEER_TASASMONEDAS", Envia) Then
        
        Exit Function
    
    End If
    
    obj.Clear
    
    Do While Bac_SQL_Fetch(DATOS())
        
        obj.AddItem Left(DATOS(6) & Space(50), 50) & Right(Space(5) & Val(DATOS(11)), 5) & Right(Space(5) & Val(DATOS(12)), 5)
        obj.ItemData(obj.NewIndex) = Val(DATOS(5))
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
    
    
    If Not Bac_Sql_Execute("SP_LEER_TASASMONEDAS", Envia) Then
        
        Exit Function
        
    ElseIf Bac_SQL_Fetch(DATOS()) Then
        
        ValorTasa = Val(DATOS(8))
        
    End If
          
End Function



Public Function LeerTc(iTabla%, iCodigo%) As Boolean

    Dim Sql As String
    LeerTc = False
    
    'Sql = "EXECUTE sp_Leer_TC " & iTabla & "," & ICodigo
    
    Envia = Array(CDbl(iTabla), _
                  iCodigo)
    If Not Bac_Sql_Execute("SP_LEER_TC", Envia) Then
        Exit Function
    End If
     
    'Call Limpiar
              
    If Bac_SQL_Fetch(DATOS()) Then
        Tabla = Val(DATOS(1))
        codigo = Val(DATOS(2))
        glosa = UCase(Trim$(DATOS(3)))
        LeerTc = True
    End If
    
End Function

