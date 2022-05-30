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

Dim SQL$, Datos(), i&

Public codigo     As Integer
Public glosa      As String
Public perfil     As String
Public codgen     As Integer
Public glosa2     As String
Public cc2756     As String
Public afectacorr As String
Public diasvalor  As Integer
Public numcheque  As String
Public ctacte     As String

Public Sub Limpiar()

    codigo = 0
    glosa = ""
    perfil = ""
    codgen = 0
    glosa2 = ""
    cc2756 = ""
    afectacorr = ""
    diasvalor = 0
    numcheque = ""
    ctacte = ""

End Sub

Public Function Eliminar(iCodigo%) As Boolean

    Eliminar = False
    
    SQL = "EXECUTE sp_Borrar_FormaPago " & iCodigo
    
    If SQL_Execute(SQL) = 0 Then
        Eliminar = True
        
    ElseIf SQL_Fetch(Datos) = 0 Then
        If Val(Datos(1)) <> 0 Then
            MsgBox Datos(2), vbCritical, "MENSAJE"
        End If
    Else
        MsgBox "Error en la Eliminacion", vbCritical, "MENSAJE"

    End If

End Function

Public Function Grabar() As Boolean

    Grabar = False

    SQL = "EXECUTE sp_Grabar_FormaPago " & codigo
    SQL = SQL & ",'" & glosa & "'"
    SQL = SQL & ",'" & perfil & "'"
    SQL = SQL & ", " & codgen
    SQL = SQL & ",'" & glosa2 & "'"
    SQL = SQL & ",'" & cc2756 & "'"
    SQL = SQL & ",'" & afectacorr & "'"
    SQL = SQL & ", " & diasvalor
    SQL = SQL & ",'" & numcheque & "'"
    SQL = SQL & ",'" & ctacte & "'"
      
    If SQL_Execute(SQL) = 0 Then
        Grabar = True
    ElseIf SQL_Fetch(Datos) = 0 Then
        If Val(Datos(1)) <> 0 Then
            MsgBox Datos(2), vbCritical, "MENSAJE"
        End If
        
    Else
        MsgBox "Error en la grabación", vbCritical, "MENSAJE"
    
    End If

End Function

Public Function CargaObjectos(obj As Object) As Boolean

    CargaObjectos = False

    SQL = "EXECUTE sp_Leer_FormaPago 0"
    
    If SQL_Execute(SQL) > 0 Then
        MsgBox "Problemas al Leer Formas de Pago", vbCritical, "MENSAJE"
        Exit Function
    End If

    obj.Clear
    
    Do While SQL_Fetch(Datos()) = 0
        obj.AddItem Datos(2)
        obj.ItemData(obj.NewIndex) = Val(Datos(1))
        CargaObjectos = True
    Loop

End Function

Public Function CargaxMoneda(iMoneda%, obj As Object) As Boolean

    CargaxMoneda = False
    
    SQL = "EXECUTE sp_Leer_DocPagoMoneda " & iMoneda
    SQL = SQL & ", 0, '1'"
    
    If SQL_Execute(SQL) > 0 Then
        MsgBox "Problemas al Leer Formas de Pago por Moneda", vbCritical, "MENSAJE"
        Exit Function
    End If

    obj.Clear
    
    Do While SQL_Fetch(Datos()) = 0
        obj.AddItem Datos(4)
        obj.ItemData(obj.NewIndex) = Val(Datos(3))
        CargaxMoneda = True
    Loop
    
End Function
