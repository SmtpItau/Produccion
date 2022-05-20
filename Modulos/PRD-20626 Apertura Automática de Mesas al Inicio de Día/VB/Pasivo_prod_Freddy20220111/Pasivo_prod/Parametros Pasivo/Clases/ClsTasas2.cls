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
Dim Datos()

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
    Dim Datos()
    
    'SQL = "EXECUTE " & giSQL_DatabaseCommon & ".."
    
    Sql = ""
    Sql = Sql & "sp_Grabar_TasasMonedas "  ''& Sistema & "'"
    Sql = Sql & CodMoneda
    Sql = Sql & ", " & CodTasa
    Sql = Sql & ",'" & Format(fecha, "yyyymmdd") & "'"
    Sql = Sql & ", " & CDbl(Valor)
    Sql = Sql & ", " & CodPeriodo
    
    Envia = Array()
    'AddParam Envia, Sistema
    AddParam Envia, CDbl(CodMoneda)
    AddParam Envia, CDbl(CodTasa)
    AddParam Envia, Format(fecha, "yyyymmdd")
    AddParam Envia, CDbl(Valor)
    AddParam Envia, CDbl(CodPeriodo)
    
    GrabarTM = True
    
    'If Bac_SQL_Fetch(Datos) = 0 Then
     If Not BAC_SQL_EXECUTE("Sp_Grabar_TasasMonedas", Envia) Then
        
        If BAC_SQL_FETCH(Datos()) Then
          
          If Val(Datos(1)) < 0 Then
              
              GrabarTM = False
              MsgBox Datos(2), 16
          
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
    Sql = Sql & "sp_Leer_TasasMonedas " & iMoneda
    Sql = Sql & ", " & iTasa
    Sql = Sql & ", " & iPeriodo
    Sql = Sql & ",'" & fechaymd(sFecha) & "'"
    
    If BAC_SQL_EXECUTE((Sql)) Then
        If BAC_SQL_FETCH(Datos) Then
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

    LeerTM = True
    
End Function

Public Function CargaPeriodosTM(iMoneda%, iTasa%, obj As Object) As Boolean

    CargaPeriodosTM = False

   ' Sql = "EXECUTE " & giSQL_DatabaseCommon & ".."
    Sql = Sql & "sp_Leer_TasasMonedas " & iMoneda%
    Sql = Sql & ", " & iTasa%
    Sql = Sql & ", 0" '-- Todos los Periodo
    Sql = Sql & ",'" & Format(CDate(gsbac_fecp), "yyyymmdd") & "'"
    
    If Not BAC_SQL_EXECUTE((Sql)) Then
        Exit Function
    End If
    
    obj.Clear
    
    Do While BAC_SQL_FETCH(Datos)
        obj.AddItem Left(Datos(6) & Space(50), 50) & Right(Space(5) & Val(Datos(11)), 5) & Right(Space(5) & Val(Datos(12)), 5)
        obj.ItemData(obj.NewIndex) = Val(Datos(5))
        CargaPeriodosTM = True
    Loop
          
End Function

Public Function ValorTasaTM(iMoneda%, iTasa%, iPeriodo%, sFecha$) As Double

    ValorTasaTM = 0#

    
    Sql = ""
    Sql = Sql & "sp_Leer_TasasMonedas " & iMoneda%
    Sql = Sql & ", " & iTasa%
    Sql = Sql & ", " & iPeriodo%
    Sql = Sql & ",'" & Format(sFecha$, "yyyymmdd") & "'"
    
    If Not BAC_SQL_EXECUTE((Sql)) Then
        Exit Function
        
    ElseIf BAC_SQL_FETCH(Datos) Then
        'MsgBox "No se retorno valor de Tasa ", vbCritical
        
    'Else
        ValorTasaTM = Val(Datos(8))
        
    End If
          
End Function


Public Function GrabarMTM() As Boolean
    Dim fechaymd()
    Dim Sql As String
    Dim Datos(0 To 0)
    
    Sql = ""
   
    Sql = Sql & "sp_Grabar_TasasMTM "
    Sql = Sql & "  " & CodTasa
    Sql = Sql & ", " & CodMoneda
    Sql = Sql & ", " & Val(dias)
    Sql = Sql & "," & F_FomateaValor(CDbl(Bid), ",", ".")
    Sql = Sql & "," & F_FomateaValor(CDbl(Offer), ",", ".")
    Sql = Sql & "," & F_FomateaValor(CDbl(Tasa), ",", ".")
   ' Sql = Sql & ", " & FUNC_SACACOMA_GRILLA_STandar(Bid)
   ' Sql = Sql & ", " & FUNC_SACACOMA_GRILLA_STandar(Offer)
   ' Sql = Sql & ", " & FUNC_SACACOMA_GRILLA_STandar(Tasa)
    Sql = Sql & ", " & Val(BaseOri)
    Sql = Sql & ", " & Val(BaseConv)
    Sql = Sql & ",'" & fechaymd(fecha) & "'"
    Sql = Sql & ",'" & gsBAC_User & "'"
    
    GrabarMTM = BAC_SQL_EXECUTE(Sql)
    
    If BAC_SQL_FETCH(Datos) Then
        If Val(Datos(1)) < 0 Then
            GrabarMTM = False
            MsgBox Datos(2), gsBac_Version
            Exit Function
        End If
    End If
    
   GrabarMTM = True
    
End Function

Public Function EliminarMTM(iMoneda%, iTasa%, iDias%) As Boolean

    Sql = ""
    Sql = Sql & "sp_Borrar_TasasMTM " & iTasa
    Sql = Sql & "," & iMoneda
    Sql = Sql & "," & iDias
            
    EliminarMTM = BAC_SQL_EXECUTE((Sql))
    
    If BAC_SQL_FETCH(Datos) Then
        If Val(Datos(1)) < 0 Then
            MsgBox Datos(2), vbCritical
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

    Sql = ""
    Sql = Sql & "sp_Leer_TasasMTM " & iMoneda
    Sql = Sql & ", " & iTasa
    Sql = Sql & ", " & iDesde
    
    '---- Si no viene definida la fecha, SQL define la de proceso
    
    If Len(sFecha) > 0 Then
        Sql = Sql & ",'" & fechaymd(sFecha) & "'"
    End If
    
    If BAC_SQL_EXECUTE((Sql)) Then
        If BAC_SQL_FETCH(Datos) = 0 Then
            dias = Val(Datos(1))
            Bid = Val(Datos(2))
            Offer = Val(Datos(3))
            Tasa = Val(Datos(4))
            BaseOri = Val(Datos(5))
            BaseConv = Val(Datos(6))
            TasaFinal = Val(Datos(7))
            TasaZcr = Val(Datos(8))
            CodMoneda = Val(Datos(9))
            GloMoneda = Datos(10)
            NemMoneda = Datos(11)
            CodTasa = Val(Datos(12))
            GloTasa = Datos(13)
            fecha = Datos(14)
        End If
    End If

  LeerMTM = True

End Function
Public Function CargaObjetosMTM(obj As Object, iTipObj%, iMoneda%, iTasa%, iDesde%, sFecha$) As Boolean
Dim sLine$

    CargaObjetosMTM = False

    Sql = ""
    Sql = Sql & "sp_Leer_TasasMTM " & iMoneda%
    Sql = Sql & ", " & iTasa%
    Sql = Sql & ", " & iDesde%
    Sql = Sql & ",'" & Format(sFecha$, "yyyymmdd") & "'"
    Sql = Sql & "," & MDTC_MTM
        
    If Not BAC_SQL_EXECUTE((Sql)) Then
        MsgBox "Problemas al Leer Tasas de Mercado", vbCritical
        Exit Function
    End If

    If iTipObj = 1 Then
        obj.Rows = 2
        
    Else       '---- Combo/List
        obj.Clear
        
    End If
    
    Do While BAC_SQL_FETCH(Datos())
        If iTipObj = 1 Then     '---- Grilla
            obj.Row = obj.Rows - 1
            obj.TextMatrix(obj.Row, 1) = Val(Datos(1))                          '-  Dias
            obj.TextMatrix(obj.Row, 2) = Format(Val(Datos(2)), "#,##0.000000")  '-  Bid
            obj.TextMatrix(obj.Row, 3) = Format(Val(Datos(3)), "#,##0.000000")  '-  Offer
            obj.TextMatrix(obj.Row, 4) = Format(Val(Datos(4)), "#,##0.000000")  '-  Tasa
            obj.TextMatrix(obj.Row, 5) = Val(Datos(5))                          '-  Base
            obj.TextMatrix(obj.Row, 6) = Val(Datos(6))                          '-  Base Conversion
            obj.TextMatrix(obj.Row, 7) = Format(Val(Datos(7)), "#,##0.000000")  '-  Tasa Final (base 365)
            obj.TextMatrix(obj.Row, 8) = Format(Val(Datos(8)), "#,##0.000000")  '-  Tasa ZCR
            obj.Rows = obj.Rows + 1
            
        Else                    '---- Combo/List
            sLine = Format(Val(Datos(1)), "0000")
            sLine = sLine & " Tasa Final " & Val(Datos(4))
            sLine = sLine & " de " & Datos(11) & "/" & Datos(13)
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

    Sql = ""
    Sql = Sql & "sp_Leer_TasasMTM " & iMoneda%
    Sql = Sql & ", " & iTasa%
    Sql = Sql & ", " & iDesde%
    Sql = Sql & ",'" & Format(sFecha$, "yyyymmdd") & "'"
    
    If Not BAC_SQL_EXECUTE((Sql)) Then
        Exit Function
        
    Else
      If Not BAC_SQL_FETCH(Datos) Then
          MsgBox "No se retorno valor de Tasa ", vbCritical
          
      Else
          ValorTasa = Val(Datos(4))
          
      End If
    End If
          
End Function

Public Function LeerTc(iTabla%, iCodigo%) As Boolean

    Dim Sql As String
    LeerTc = False
    
    Sql = ""
    Sql = "EXECUTE sp_Leer_TC " & iTabla & "," & iCodigo
    
    If Not BAC_SQL_EXECUTE(Sql) Then
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

