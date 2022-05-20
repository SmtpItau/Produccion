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

Dim Sql$, Datos(), I&

Public codigo     As Integer
Public glosa      As String
Public Perfil     As String
Public CodGen     As Integer
Public Glosa2     As String
Public cc2756     As String
Public AfectaCorr As String
Public DiasValor  As Integer
Public NumCheque  As String
Public CtaCte     As String
Public Settlement As String
Public iRelacion_Bcch As Integer
Public FPBancoC   As String
Public Contable As String
Public Sub Limpiar()

    codigo = 0
    glosa = ""
    Perfil = ""
    CodGen = 0
    Glosa2 = ""
    cc2756 = ""
    AfectaCorr = ""
    DiasValor = 0
    NumCheque = ""
    CtaCte = ""
    Settlement = ""
    FPBancoC = ""
    Contable = "S"
End Sub

Public Function LeerxCodigo(iCodigo%) As Boolean

    Envia = Array()
    AddParam Envia, iCodigo
    
    LeerxCodigo = (BAC_SQL_EXECUTE("sp_Leer_FormaPago ", Envia))
    
    If BAC_SQL_FETCH(Datos()) Then
        codigo = Val(Datos(1))
        glosa = Datos(2)
        Glosa2 = Datos(3)
        Perfil = Datos(4)
        CodGen = Val(Datos(5))
        cc2756 = Datos(6)
        AfectaCorr = Datos(7)
        DiasValor = Val(Datos(8))
        NumCheque = Datos(9)
        CtaCte = Datos(10)
        Settlement = Datos(11)
        iRelacion_Bcch = Datos(12)
        FPBancoC = Datos(13)
        Contable = Datos(14)
    End If

End Function

Public Function Eliminar(iCodigo%) As Boolean

    Eliminar = False
    Envia = Array()
    AddParam Envia, iCodigo
    
    If BAC_SQL_EXECUTE("sp_Borrar_FormaPago ", Envia) Then
        Eliminar = True
        
        If BAC_SQL_FETCH(Datos()) Then
            If Val(Datos(1)) <> 0 Then
                MsgBox Datos(2), vbCritical
            Else
                MsgBox Datos(2), vbInformation
            End If
        End If
        
    ElseIf BAC_SQL_FETCH(Datos()) Then
        If Val(Datos(1)) <> 0 Then
            MsgBox Datos(2), vbCritical
        End If
    Else
        MsgBox "Error en la Eliminacion", vbCritical

    End If

End Function

Public Function Grabar() As Boolean

    I = Screen.MousePointer
    Screen.MousePointer = 11

    Envia = Array()
    AddParam Envia, codigo
    AddParam Envia, glosa
    AddParam Envia, Perfil
    AddParam Envia, CodGen
    AddParam Envia, Glosa2
    AddParam Envia, cc2756
    AddParam Envia, AfectaCorr
    AddParam Envia, DiasValor
    AddParam Envia, NumCheque
    AddParam Envia, CtaCte
    AddParam Envia, Settlement
    AddParam Envia, iRelacion_Bcch
    AddParam Envia, FPBancoC
    AddParam Envia, Contable
    Grabar = (BAC_SQL_EXECUTE("sp_Grabar_FormaPago ", Envia))
    
      If Grabar = False Then
         Screen.MousePointer = 0
         Exit Function
      End If
    
    
    If BAC_SQL_FETCH(Datos()) Then
        If Val(Datos(1)) <> 0 Then
            Screen.MousePointer = 0
            Grabar = False
            MsgBox Datos(2), vbExclamation
            Exit Function
        End If
    End If
    
    Screen.MousePointer = I
    Grabar = True

End Function
'Public Function GrabarxMoneda(iMoneda%, iMonPago, iFPago%, sActiva$) As Boolean
'
'    I = Screen.MousePointer
'    Screen.MousePointer = 11
'
'    GrabarxMoneda = False
'
'    If Val(sActiva) <> 1 Then
'        sActiva = "0"
'    End If
'
'    Envia = Array()
'    AddParam Envia, "PCS"
'    AddParam Envia, iMoneda
'    AddParam Envia, iMonPago
'    AddParam Envia, iFPago
'    AddParam Envia, sActiva
'
'
'    GrabarxMoneda = (Bac_Sql_Execute("sp_Grabar_DocPagoMoneda 'PCS'"))
'
'    If Bac_SQL_Fetch(Datos()) Then
'        If Val(Datos(1)) <> 0 Then
'            Screen.MousePointer = 0
'            GrabarxMoneda = False
'            MsgBox Datos(2), vbCritical
'            Exit Function
'        End If
'    End If
'
'    Screen.MousePointer = I
'
'End Function

Public Function CargaObjectos(obj As Object, Optional iTipo) As Boolean

    If IsMissing(iTipo) Then
        iTipo = 0
    End If

    CargaObjectos = False
    Envia = Array()
    AddParam Envia, "0"
    
    If Not BAC_SQL_EXECUTE("sp_Leer_FormaPago", Envia) Then
        MsgBox "Problemas al Leer Formas de Pago", vbCritical
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
    
    Do While BAC_SQL_FETCH(Datos())
        
          If iTipo = 1 Then
                obj.Row = obj.Rows - 1
                obj.TextMatrix(obj.Row, 0) = Val(Datos(1))
                obj.TextMatrix(obj.Row, 1) = " "
                obj.TextMatrix(obj.Row, 2) = UCase(Datos(2))
                obj.Rows = obj.Rows + 1
                
          Else
                
                
                obj.AddItem UCase(Datos(1)) & Space(15 - Len(Datos(1))) & Trim(Datos(2))
                obj.ItemData(obj.NewIndex) = Val(Datos(1))
          End If
        
           CargaObjectos = True
    Loop
    
    If Not CargaObjectos Then
          If iTipo = 1 Then              'LLamada desde la Grilla
            'Call BacAgrandaGrilla(obj, 40)
            obj.Redraw = True
        End If
        Exit Function
    End If
    
    If iTipo = 1 Then
        'obj.Rows = obj.Rows - 1
        'obj.Redraw = True
'        Call BacAgrandaGrilla(obj, 40)
        obj.Redraw = True
    End If

End Function

Public Function CargaListView(obj As ListView, Optional iTipo) As Boolean

    If IsMissing(iTipo) Then
        iTipo = 0
    End If

    CargaListView = False
    Envia = Array()
    AddParam Envia, "0"
    
    If Not BAC_SQL_EXECUTE("sp_Leer_FormaPago", Envia) Then
        MsgBox "Problemas al Leer Formas de Pago", vbCritical
        Exit Function
    End If

    obj.ColumnHeaders.Add 1, , "Codigo", 2000
    obj.ColumnHeaders.Add 2, , "Descripcion", 2000

    
    Do While BAC_SQL_FETCH(Datos())
        
      obj.ListItems.Add , , UCase(Datos(1))
      obj.ListItems.Item(obj.ListItems.Count).ListSubItems.Add , , Trim(Datos(2))
      CargaListView = True
    
    Loop
    
End Function


Public Function CargaxMoneda(iMoneda%, iMonPago%, obj As Object, Optional iTipo, Optional iSistema) As Boolean

    If IsMissing(iTipo) Then
        iTipo = 0
    End If

    CargaxMoneda = False
    Envia = Array()
    AddParam Envia, iMoneda
    AddParam Envia, iMonPago
    AddParam Envia, 0
    AddParam Envia, "1"
    AddParam Envia, Trim(iSistema)
    
    If Not BAC_SQL_EXECUTE("sp_Leer_DocPagoMoneda ", Envia) Then
        MsgBox "Problemas al Leer Formas de Pago por Moneda", vbCritical
        Exit Function
    End If

    If iTipo = 0 Then
        obj.Clear
    End If
    
    Do While BAC_SQL_FETCH(Datos())
        If iTipo = 1 Then
            For I = 1 To obj.Rows - 1
                If Val(obj.TextMatrix(I, 0)) = Val(Datos(5)) Then
                    obj.TextMatrix(I, 1) = IIf(Val(Datos(7)) <> 0, "X", "")
                End If
            Next I
        Else
            obj.AddItem Datos(6)
            obj.ItemData(obj.NewIndex) = Val(Datos(5))
        End If
        CargaxMoneda = True
    Loop
    
End Function
