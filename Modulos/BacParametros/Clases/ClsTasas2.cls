VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "ClsTasas2"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Dim Sql, i As String
Dim DATOS()

Public Tabla        As String
Public codigo       As String
Public glosa        As String

' Tasas de Mercado : MDTASAS
'---------------------------
Public CodMoneda       As Integer
Public GloMoneda       As String
Public NemMoneda       As String
Public CodTasa         As Integer
Public GloTasa         As String
Public dias            As Integer
Public Bid             As Double
Public Offer           As Double
Public Tasa            As Double
Public BaseOri         As Integer
Public BaseConv        As Double
Public TasaFinal       As Double
Public TasaZcr         As Double
Public ValorTasa       As Double

' Tasas por Monedas y Periodo segun Tasa : MDTASASMONEDAS
'--------------------------------------------------------
Public CodPeriodo   As Integer
Public GloPeriodo   As String
Public MesPeriodo   As Integer
Public DiaPeriodo   As Integer
Public fecha        As Date
Public Valor        As String

Public Function GrabarTM() As Boolean

    Dim Sql As String
    Dim DATOS()
    
    'SQL = "EXECUTE " & giSQL_DatabaseCommon & ".."
    
    sql = ""
    sql = sql & "SP_GRABAR_TASASMONEDAS "  ''& Sistema & "'"
    sql = sql & CodMoneda
    sql = sql & ", " & CodTasa
    sql = sql & ",'" & Format(Fecha, "yyyymmdd") & "'"
    sql = sql & ", " & CDbl(Valor)
    sql = sql & ", " & CodPeriodo
    
    Envia = Array()
    'AddParam Envia, Sistema
    AddParam Envia, CDbl(CodMoneda)
    AddParam Envia, CDbl(CodTasa)
    AddParam Envia, Format(fecha, "yyyymmdd")
    AddParam Envia, CDbl(Valor)
    AddParam Envia, CDbl(CodPeriodo)
    
    GrabarTM = True
    
    'If Bac_SQL_Fetch(Datos) = 0 Then
     If Not Bac_Sql_Execute("SP_GRABAR_TASASMONEDAS", Envia) Then
        
        If Bac_SQL_Fetch(DATOS()) Then
          
          If Val(DATOS(1)) < 0 Then
              
              GrabarTM = False
              MsgBox DATOS(2), 16, TITSISTEMA
          
          End If
        
        End If
    
    End If
    
End Function
Public Sub LimpiarTM()

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

Public Function LeerTM(iMoneda%, iTasa%, iPeriodo%, sFecha$) As Boolean
Dim fechaymd()
   
    LeerTM = False

    'Sql = "EXECUTE " & giSQL_DatabaseCommon & ".."
    sql = sql & "SP_LEER_TASASMONEDAS " & iMoneda
    sql = sql & ", " & iTasa
    sql = sql & ", " & iPeriodo
    sql = sql & ",'" & fechaymd(sFecha) & "'"
    
    If MISQL.SQL_Execute(Sql) = 0 Then
        If MISQL.SQL_Fetch(DATOS) = 0 Then
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

    LeerTM = True
    
End Function

Public Function CargaPeriodosTM(iMoneda%, iTasa%, obj As Object) As Boolean

    CargaPeriodosTM = False

   ' Sql = "EXECUTE " & giSQL_DatabaseCommon & ".."
    sql = sql & "SP_LEER_TASASMONEDAS " & iMoneda%
    sql = sql & ", " & iTasa%
    sql = sql & ", 0" '-- Todos los Periodo
    sql = sql & ",'" & Format(CDate(gsbac_fecp), "yyyymmdd") & "'"
    
    If MISQL.SQL_Execute(Sql) <> 0 Then
        Exit Function
    End If
    
    obj.Clear
    
    Do While MISQL.SQL_Fetch(DATOS) = 0
        obj.AddItem Left(DATOS(6) & Space(50), 50) & Right(Space(5) & Val(DATOS(11)), 5) & Right(Space(5) & Val(DATOS(12)), 5)
        obj.ItemData(obj.NewIndex) = Val(DATOS(5))
        CargaPeriodosTM = True
    Loop
          
End Function

Public Function ValorTasaTM(iMoneda%, iTasa%, iPeriodo%, sFecha$) As Double

    ValorTasaTM = 0#

    
    sql = ""
    sql = sql & "SP_LEER_TASASMONEDAS " & iMoneda%
    sql = sql & ", " & iTasa%
    sql = sql & ", " & iPeriodo%
    sql = sql & ",'" & Format(sFecha$, "yyyymmdd") & "'"
    
    If MISQL.SQL_Execute(Sql) <> 0 Then
        Exit Function
        
    ElseIf MISQL.SQL_Fetch(DATOS) = 0 Then
        'MsgBox "No se retorno valor de Tasa ", vbCritical,  gsBac_Version
        
    'Else
        ValorTasaTM = Val(DATOS(8))
        
    End If
          
End Function


Public Function GrabarMTM() As Boolean
    Dim fechaymd()
    Dim Sql As String
    Dim DATOS(0 To 0)
    
    Sql = ""
   
    sql = sql & "SP_GRABAR_TASASMTM "
    sql = sql & "  " & CodTasa
    sql = sql & ", " & CodMoneda
    sql = sql & ", " & Val(dias)
    sql = sql & "," & F_FomateaValor(CDbl(Bid), ",", ".")
    sql = sql & "," & F_FomateaValor(CDbl(Offer), ",", ".")
    sql = sql & "," & F_FomateaValor(CDbl(Tasa), ",", ".")
   ' Sql = Sql & ", " & FUNC_SACACOMA_GRILLA_STandar(Bid)
   ' Sql = Sql & ", " & FUNC_SACACOMA_GRILLA_STandar(Offer)
   ' Sql = Sql & ", " & FUNC_SACACOMA_GRILLA_STandar(Tasa)
    Sql = Sql & ", " & Val(BaseOri)
    Sql = Sql & ", " & Val(BaseConv)
    Sql = Sql & ",'" & fechaymd(fecha) & "'"
    Sql = Sql & ",'" & gsBAC_User & "'"
    
    GrabarMTM = (MISQL.SQL_Execute(Sql) = 0)
    
    If MISQL.SQL_Fetch(DATOS) = 0 Then
        If Val(DATOS(1)) < 0 Then
            GrabarMTM = False
            MsgBox DATOS(2), gsBac_Version, TITSISTEMA
            Exit Function
        End If
    End If
    
   GrabarMTM = True
    
End Function

Public Function EliminarMTM(iMoneda%, iTasa%, iDias%) As Boolean

    sql = ""
    sql = sql & "SP_BORRAR_TASASMTM " & iTasa
    sql = sql & "," & iMoneda
    sql = sql & "," & iDias
            
    EliminarMTM = (MISQL.SQL_Execute(Sql) = 0)
    
    If MISQL.SQL_Fetch(DATOS) = 0 Then
        If Val(DATOS(1)) < 0 Then
            MsgBox DATOS(2), vbCritical, TITSISTEMA
            EliminarMTM = False
        End If
    End If

End Function

Sub LimpiarMTM()

    CodMoneda = 0
    GloMoneda = ""
    NemMoneda = ""
    CodTasa = 0
    GloTasa = ""
    dias = 0
    Bid = 0
    Offer = 0
    Tasa = 0
    BaseOri = 0
    BaseConv = 0
    TasaFinal = 0
    TasaZcr = 0
    fecha = gsbac_fecp

End Sub

Public Function LeerMTM(iMoneda%, iTasa%, iDesde%, sFecha$) As Boolean
Dim fechaymd()
    LeerMTM = False

    sql = ""
    sql = sql & "SP_LEER_TASASMTM " & iMoneda
    sql = sql & ", " & iTasa
    sql = sql & ", " & iDesde
    
    '---- Si no viene definida la fecha, SQL define la de proceso
    
    If Len(sFecha) > 0 Then
        Sql = Sql & ",'" & fechaymd(sFecha) & "'"
    End If
    
    If MISQL.SQL_Execute(Sql) = 0 Then
        If MISQL.SQL_Fetch(DATOS) = 0 Then
            dias = Val(DATOS(1))
            Bid = Val(DATOS(2))
            Offer = Val(DATOS(3))
            Tasa = Val(DATOS(4))
            BaseOri = Val(DATOS(5))
            BaseConv = Val(DATOS(6))
            TasaFinal = Val(DATOS(7))
            TasaZcr = Val(DATOS(8))
            CodMoneda = Val(DATOS(9))
            GloMoneda = DATOS(10)
            NemMoneda = DATOS(11)
            CodTasa = Val(DATOS(12))
            GloTasa = DATOS(13)
            fecha = DATOS(14)
        End If
    End If

  LeerMTM = True

End Function
Public Function CargaObjetosMTM(obj As Object, iTipObj%, iMoneda%, iTasa%, iDesde%, sFecha$) As Boolean
Dim sLine$

    CargaObjetosMTM = False

    sql = ""
    sql = sql & "SP_LEER_TASASMTM " & iMoneda%
    sql = sql & ", " & iTasa%
    sql = sql & ", " & iDesde%
    sql = sql & ",'" & Format(sFecha$, "yyyymmdd") & "'"
    sql = sql & "," & MDTC_MTM
        
    If MISQL.SQL_Execute(Sql) > 0 Then
        MsgBox "Problemas al Leer Tasas de Mercado", vbCritical, TITSISTEMA
        Exit Function
    End If

    If iTipObj = 1 Then
        obj.Rows = 2
        
    Else       '---- Combo/List
        obj.Clear
        
    End If
    
    Do While MISQL.SQL_Fetch(DATOS()) = 0
        If iTipObj = 1 Then     '---- Grilla
            obj.Row = obj.Rows - 1
            obj.TextMatrix(obj.Row, 1) = Val(DATOS(1))                          '-  Dias
            obj.TextMatrix(obj.Row, 2) = Format(Val(DATOS(2)), "#,##0.000000")  '-  Bid
            obj.TextMatrix(obj.Row, 3) = Format(Val(DATOS(3)), "#,##0.000000")  '-  Offer
            obj.TextMatrix(obj.Row, 4) = Format(Val(DATOS(4)), "#,##0.000000")  '-  Tasa
            obj.TextMatrix(obj.Row, 5) = Val(DATOS(5))                          '-  Base
            obj.TextMatrix(obj.Row, 6) = Val(DATOS(6))                          '-  Base Conversion
            obj.TextMatrix(obj.Row, 7) = Format(Val(DATOS(7)), "#,##0.000000")  '-  Tasa Final (base 365)
            obj.TextMatrix(obj.Row, 8) = Format(Val(DATOS(8)), "#,##0.000000")  '-  Tasa ZCR
            obj.Rows = obj.Rows + 1
            
        Else                    '---- Combo/List
            sLine = Format(Val(DATOS(1)), "0000")
            sLine = sLine & " Tasa Final " & Val(DATOS(4))
            sLine = sLine & " de " & DATOS(11) & "/" & DATOS(13)
            obj.AddItem sLine
            obj.ItemData(obj.NewIndex) = obj.NewIndex
            
        End If
        CargaObjetosMTM = True
    Loop
    
    If Not CargaObjetosMTM Then
        Exit Function
    End If
    
   
End Function
Public Function ValorTasaMTM(iMoneda%, iTasa%, iDesde%, sFecha$) As Double

    ValorTasa = 0#

    sql = ""
    sql = sql & "SP_LEER_TASASMTM " & iMoneda%
    sql = sql & ", " & iTasa%
    sql = sql & ", " & iDesde%
    sql = sql & ",'" & Format(sFecha$, "yyyymmdd") & "'"
    
    If MISQL.SQL_Execute(Sql) <> 0 Then
        Exit Function
        
    ElseIf MISQL.SQL_Fetch(DATOS) <> 0 Then
        MsgBox "No se retorno valor de Tasa ", vbCritical, TITSISTEMA
        
    Else
        ValorTasa = Val(DATOS(4))
        
    End If
          
End Function
 Public Function CargaObjetos(obj As Object, iTabla%) As Boolean

    CargaObjetos = False

    sql = ""
    sql = sql & "SP_MDTCLEERCODIGOS" & iTabla
    
    obj.Clear
    
    If MISQL.SQL_Execute(Sql) <> 0 Then
        Exit Function
    End If
    
    Do While MISQL.SQL_Fetch(DATOS) = 0
        obj.AddItem UCase(DATOS(3))
        obj.ItemData(obj.NewIndex) = Val(DATOS(2))
        CargaObjetos = True
    Loop

End Function

Public Function LeerTc(iTabla%, iCodigo%) As Boolean

    Dim Sql As String
    LeerTc = False
    
    sql = ""
    sql = "EXECUTE SP_LEER_TC " & iTabla & "," & iCodigo
    
    If MISQL.SQL_Execute(Sql) <> 0 Then
        Exit Function
    End If
     
    'Call Limpiar
              
    If MISQL.SQL_Fetch(DATOS()) = 0 Then
        Tabla = Val(DATOS(1))
        codigo = Val(DATOS(2))
        glosa = UCase(Trim$(DATOS(3)))
        LeerTc = True
    End If
    
End Function

