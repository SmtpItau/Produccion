VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsForPago"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Dim Sql$, DATOS(), i&

Public Codigo     As Integer
Public Glosa      As String
Public Perfil     As String
Public CodGen     As Integer
Public Glosa2     As String
Public cc2756     As String
Public AfectaCorr As String
Public DiasValor  As Integer
Public NumCheque  As String
Public CtaCte     As String

Public Sub Limpiar()

    Codigo = 0
    Glosa = ""
    Perfil = ""
    CodGen = 0
    Glosa2 = ""
    cc2756 = ""
    AfectaCorr = ""
    DiasValor = 0
    NumCheque = ""
    CtaCte = ""

End Sub

Public Function LeerxCodigo(iCodigo%) As Boolean

Envia = Array()
AddParam Envia, iCodigo

'    Sql = "EXECUTE " & giSQL_DatabaseCommon & ".."
'    Sql = Sql & "sp_Leer_FormaPago " & iCodigo
    
'    LeerxCodigo = (MISQL.SQL_Execute(Sql) = 0)
    LeerxCodigo = (Bac_Sql_Execute("SP_LEER_FORMAPAGO", Envia))
    
'    If MISQL.SQL_Fetch(DATOS()) = 0 Then
    If Bac_SQL_Fetch(DATOS()) Then
        Codigo = Val(DATOS(1))
        Glosa = DATOS(2)
        Glosa2 = DATOS(3)
        Perfil = DATOS(4)
        CodGen = Val(DATOS(5))
        cc2756 = DATOS(6)
        AfectaCorr = DATOS(7)
        DiasValor = Val(DATOS(8))
        NumCheque = DATOS(9)
        CtaCte = DATOS(10)
    End If

End Function

Public Function Eliminar(iCodigo%) As Boolean

    Eliminar = False
    
    'Sql = "EXECUTE sp_Borrar_FormaPago " & iCodigo
    
    Envia = Array()
    AddParam Envia, iCodigo
    
    'If MISQL.SQL_Execute(Sql) = 0 Then
    If Bac_Sql_Execute("SP_BORRAR_FORMAPAGO", Envia) Then
        Eliminar = True
        
    'ElseIf MISQL.SQL_Fetch(DATOS) = 0 Then
    ElseIf Bac_SQL_Fetch(DATOS()) Then
        
        If Val(DATOS(1)) <> 0 Then
            MsgBox DATOS(2), vbCritical, gsPARAMS_Version
        End If
    Else
        MsgBox "Error en la Eliminacion", vbCritical, gsPARAMS_Version

    End If

End Function

Public Function Grabar() As Boolean

    i = Screen.MousePointer
    Screen.MousePointer = 11

    Grabar = False

'    Sql = "EXECUTE sp_Grabar_FormaPago " & Codigo
'    Sql = Sql & ",'" & Glosa & "'"
'    Sql = Sql & ",'" & Perfil & "'"
'    Sql = Sql & ", " & CodGen
'    Sql = Sql & ",'" & Glosa2 & "'"
'    Sql = Sql & ",'" & cc2756 & "'"
'    Sql = Sql & ",'" & AfectaCorr & "'"
'    Sql = Sql & ", " & DiasValor
'    Sql = Sql & ",'" & NumCheque & "'"
'    Sql = Sql & ",'" & CtaCte & "'"
      
    Envia = Array()
    AddParam Envia, Glosa
    AddParam Envia, Perfil
    AddParam Envia, CDbl(CodGen)
    AddParam Envia, Glosa2
    AddParam Envia, CDbl(CodGen)
    AddParam Envia, Glosa2
    AddParam Envia, cc2756
    AddParam Envia, AfectaCorr
    AddParam Envia, CDbl(DiasValor)
    AddParam Envia, NumCheque
    AddParam Envia, CtaCte
      
'    Grabar = (MISQL.SQL_Execute(Sql) = 0)
    grabar = (Bac_Sql_Execute("SP_GRABAR_FORMAPAGO", Envia))
    
'    If MISQL.SQL_Fetch(DATOS) = 0 Then
    If Bac_SQL_Fetch(DATOS()) Then
        If Val(DATOS(1)) <> 0 Then
            Screen.MousePointer = 0
            Grabar = False
            MsgBox DATOS(2), vbCritical, gsPARAMS_Version
        End If
    End If
    
    Screen.MousePointer = i

End Function
Public Function GrabarxMonedaaaaaa(iMoneda%, iMonPago, iFPago%, sActiva$) As Boolean

    i = Screen.MousePointer
    Screen.MousePointer = 11

    GrabarxMonedaaaaaa = False
    
    If Val(sActiva) <> 1 Then
        sActiva = "0"
    End If
    
'    Sql = ""
'    Sql = "EXECUTE sp_Grabar_DocPagoMoneda 'PCS'"   '--- PENDIENTE variable Sistema
'    Sql = Sql & ", " & iMoneda
'    Sql = Sql & ", " & iMonPago
'    Sql = Sql & ", " & iFPago
'    Sql = Sql & ",'" & sActiva & "'"
      
    Envia = Array()
    AddParam Envia, CDbl(iMoneda)
    AddParam Envia, CDbl(iMonPago)
    AddParam Envia, iFPago
    AddParam Envia, sActiva
      
'    GrabarxMonedaaaaaa = (MISQL.SQL_Execute(Sql) = 0)
     GrabarxMonedaaaaaa = (Bac_Sql_Execute("SP_GRABAR_DOCPAGOMONEDA", Envia))
        
        
'    If MISQL.SQL_Fetch(DATOS) = 0 Then
    If Bac_SQL_Fetch(DATOS()) Then
        If Val(DATOS(1)) <> 0 Then
            Screen.MousePointer = 0
            GrabarxMonedaaaaaa = False
            MsgBox DATOS(2), vbCritical, gsPARAMS_Version
        End If
    End If
    
    Screen.MousePointer = i

End Function

Public Function CargaObjectos(obj As Object, Optional iTipo) As Boolean

    If IsMissing(iTipo) Then
        iTipo = 0
    End If

    CargaObjectos = False

    Envia = Array()
    AddParam Envia, CDbl(0)
    
'    Sql = "EXECUTE sp_Leer_FormaPago 0"
    
    
'    If MISQL.SQL_Execute(Sql) > 0 Then
    If Bac_Sql_Execute("SP_LEER_FORMAPAGO", Envia) Then
        MsgBox "Problemas al Leer Formas de Pago", vbCritical, gsPARAMS_Version
        Exit Function
    End If

    If iTipo = 1 Then
       ' obj.ColWidth(0) = 0
       ' obj.ColWidth(2) = 4700
        obj.Rows = 2
    Else
        obj.Clear
    End If
    
    
    If iTipo = 1 Then
     obj.Redraw = False
     End If
    
'    Do While MISQL.SQL_Fetch(DATOS()) = 0
    Do While Bac_SQL_Fetch(DATOS())
        If iTipo = 1 Then
            obj.Row = obj.Rows - 1
            obj.TextMatrix(obj.Row, 0) = Val(DATOS(1))
            obj.TextMatrix(obj.Row, 1) = " "
            obj.TextMatrix(obj.Row, 2) = UCase(DATOS(2))
            obj.Rows = obj.Rows + 1
        Else
            obj.AddItem DATOS(2)
            obj.ItemData(obj.NewIndex) = Val(DATOS(1))
        End If
        CargaObjectos = True
    Loop
    
    If Not CargaObjectos Then
        Exit Function
    End If
    
    If iTipo = 1 Then
        obj.Rows = obj.Rows - 1
        obj.Redraw = True
    End If

End Function

Public Function CargaxMoneda(iMoneda%, iMonPago%, obj As Object, Optional iTipo) As Boolean
Dim Y As Integer

    If IsMissing(iTipo) Then
        iTipo = 0
    End If

    CargaxMoneda = False
    
'    Sql = ""
'  '  Sql = "EXECUTE " & giSQL_DatabaseCommon & "..sp_Leer_DocPagoMoneda " & iMoneda
'    Sql = Sql & "EXECUTE " & "sp_Leer_DocPagoMoneda " & iMoneda
'    Sql = Sql & ", " & iMonPago
'    Sql = Sql & ", 0, '1', '" & Sistema & "'"
    
    Envia = Array()
    AddParam Envia, CDbl(iMoneda)
    AddParam Envia, CDbl(iMonPago)
    AddParam Envia, CDbl(0)
    AddParam Envia, "1"
    AddParam Envia, Sistema
    
'    If MISQL.SQL_Execute(Sql) > 0 Then
    If Not Bac_Sql_Execute("SP_LEER_DOCPAGOMONEDA", Envia) Then
        MsgBox "Problemas al Leer Formas de Pago por Moneda", vbCritical, gsPARAMS_Version
        Exit Function
    End If

    obj.Clear
    If iTipo = 0 Then
        obj.Clear
    End If
    
'    Do While MISQL.SQL_Fetch(DATOS()) = 0
    Do While Bac_SQL_Fetch(DATOS())
        If iTipo = 1 Then
            For i = 1 To obj.Rows - 1
                If Val(obj.TextMatrix(i, 0)) = Val(DATOS(5)) Then
                    obj.TextMatrix(i, 1) = IIf(Val(DATOS(7)) <> 0, "X", "")
                End If
            Next i
        Else
        If (obj.Name = "cmbMonedaRecibimos" Or obj.Name = "cmbMonedaPagamos") Then
            If Y <> Val(DATOS(3)) Then
                obj.AddItem DATOS(4)
                obj.ItemData(obj.NewIndex) = Val(DATOS(3))
                Y = Val(DATOS(3))
            End If
        Else
            obj.AddItem DATOS(6)
            obj.ItemData(obj.NewIndex) = Val(DATOS(5))
        End If

        
        
        End If
        CargaxMoneda = True
    Loop
    
End Function
