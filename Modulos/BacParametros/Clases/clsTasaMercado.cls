VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsTasaMercado"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Dim Sql$, DATOS(), i&

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
Public fecha           As Date

Public Function grabar() As Boolean
    
'''''''''''''''''''''''''''''''    Sql = ""
'''''''''''''''''''''''''''''''    Sql = "sp_Grabar_TasasMTM "
'''''''''''''''''''''''''''''''    Sql = Sql & "  " & CodTasa
'''''''''''''''''''''''''''''''    Sql = Sql & ", " & CodMoneda
'''''''''''''''''''''''''''''''    Sql = Sql & ", " & Val(Dias)
'''''''''''''''''''''''''''''''    Sql = Sql & ", " & FUNC_SACACOMA_GRILLA_STandar(Bid)
'''''''''''''''''''''''''''''''    Sql = Sql & ", " & FUNC_SACACOMA_GRILLA_STandar(Offer)
'''''''''''''''''''''''''''''''    Sql = Sql & ", " & FUNC_SACACOMA_GRILLA_STandar(Tasa)
'''''''''''''''''''''''''''''''    Sql = Sql & ", " & Val(BaseOri)
'''''''''''''''''''''''''''''''    Sql = Sql & ", " & Val(BaseConv)
'''''''''''''''''''''''''''''''    Sql = Sql & ",'" & FechaYMD(fecha) & "'"
'''''''''''''''''''''''''''''''    Sql = Sql & ",'" & gsBAC_User & "'"
    Envia = Array()
    
    AddParam Envia, CodTasa
    AddParam Envia, CodMoneda
    AddParam Envia, CDbl(dias)
    AddParam Envia, CDbl(FUNC_SACACOMA_GRILLA_STandar(Bid))
    AddParam Envia, CDbl(FUNC_SACACOMA_GRILLA_STandar(Offer))
    AddParam Envia, CDbl(FUNC_SACACOMA_GRILLA_STandar(Tasa))
    AddParam Envia, CDbl(BaseOri)
    AddParam Envia, CDbl(BaseConv)
    AddParam Envia, FechaYMD2(fecha)
    AddParam Envia, gsBAC_User
    
    Grabar = (Bac_Sql_Execute("SP_GRABAR_TASASMTM", Envia))
    
    If Bac_SQL_Fetch(DATOS()) Then
        If Val(DATOS(1)) < 0 Then
            grabar = False
            MsgBox DATOS(2), vbInformation, TITSISTEMA
            Exit Function
        End If
    End If
    
   grabar = True
    
End Function

Public Function Eliminar(iMoneda%, iTasa%, iDias%) As Boolean

'''''''''''''''''''''''    Sql = "sp_Borrar_TasasMTM " & iTasa
'''''''''''''''''''''''    Sql = Sql & "," & iMoneda
'''''''''''''''''''''''    Sql = Sql & "," & iDias
   
    Envia = Array()
   
    AddParam Envia, iTasa
    AddParam Envia, iMoneda
    AddParam Envia, iDias
    
    Eliminar = (Bac_Sql_Execute("SP_BORRAR_TASASMTM", Envia))
    
    If Bac_SQL_Fetch(DATOS()) Then
        If Val(DATOS(1)) < 0 Then
            MsgBox DATOS(2), vbCritical, TITSISTEMA
            Eliminar = False
        End If
    End If

End Function

Sub Limpiar()

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

Public Function Leer(iMoneda%, iTasa%, iDesde%, sFecha$) As Boolean

    Leer = False

    
''''''''''''''''''''''''''''    Sql = "sp_Leer_TasasMTM " & iMoneda
''''''''''''''''''''''''''''    Sql = Sql & ", " & iTasa
''''''''''''''''''''''''''''    Sql = Sql & ", " & iDesde
    Envia = Array()
    
    AddParam Envia, iMoneda
    AddParam Envia, iTasa
    AddParam Envia, iDesde
    
    '---- Si no viene definida la fecha, SQL define la de proceso
    If Len(sFecha) > 0 Then
        
        'Sql = Sql & ",'" & FechaYMD(sFecha) & "'"
    
        AddParam Envia, FechaYMD2(sFecha)
    
    
    End If
    
    If Bac_Sql_Execute("SP_LEER_TASASMTM", Envia) Then
        
        If Bac_SQL_Fetch(DATOS()) Then
            
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

End Function
Public Function CargaObjetos(obj As Object, iTipObj%, iMoneda%, iTasa%, iDesde%, sFecha$) As Boolean
Dim sLine$

    CargaObjetos = False

'''''''''''''''''''''    Sql = "sp_Leer_TasasMTM " & iMoneda%
'''''''''''''''''''''    Sql = Sql & ", " & iTasa%
'''''''''''''''''''''    Sql = Sql & ", " & iDesde%
'''''''''''''''''''''    Sql = Sql & ",'" & Format(sFecha$, "yyyymmdd") & "'"
    Envia = Array()
        
    AddParam Envia, iMoneda%
    AddParam Envia, iTasa%
    AddParam Envia, iDesde%
    AddParam Envia, Format(sFecha$, "yyyymmdd")
        
    If Not Bac_Sql_Execute("SP_LEER_TASASMTM", Envia) Then
        
        MsgBox "Problemas al Leer Tasas de Mercado", vbCritical, TITSISTEMA
        Exit Function
    
    End If

    If iTipObj = 1 Then
        
        obj.Rows = 2
        
    Else       '---- Combo/List
        obj.Clear
        
    End If
    
    Do While Bac_SQL_Fetch(DATOS())
        
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
        CargaObjetos = True
    Loop
    
    If Not CargaObjetos Then
        Exit Function
    End If
    
   
End Function
Public Function ValorTasa(iMoneda%, iTasa%, iDesde%, sFecha$) As Double

    ValorTasa = 0#

'''''''''''''''''''''''    Sql = "sp_Leer_TasasMTM " & iMoneda%
'''''''''''''''''''''''    Sql = Sql & ", " & iTasa%
'''''''''''''''''''''''    Sql = Sql & ", " & iDesde%
'''''''''''''''''''''''    Sql = Sql & ",'" & Format(sFecha$, "yyyymmdd") & "'"
    Envia = Array()
    
    AddParam Envia, iMoneda%
    AddParam Envia, iTasa%
    AddParam Envia, iDesde%
    AddParam Envia, Format(sFecha$, "yyyymmdd")
    
    If Not Bac_Sql_Execute("SP_LEER_TASASMTM ", Envia) Then
        
        Exit Function
        
    ElseIf Not Bac_SQL_Fetch(DATOS()) Then
        
        MsgBox "No se retorno valor de Tasa ", vbCritical, TITSISTEMA
        
    Else
        ValorTasa = Val(DATOS(4))
        
    End If
          
End Function
