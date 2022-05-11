Attribute VB_Name = "modMDCI"
Option Explicit


Public Sub CI_Agregar(hWnd As Long, Data1 As Control)

    Data1.Recordset.AddNew
    Data1.Recordset("tm_hwnd") = hWnd
   ' VB +- 09/06/2000 se debe dejar vacio  por cambio de revision
   ' data1.Recordset("tm_custodia") = "PROPIA" ' VB+- 18/02/2000 se deja para custodia
    Call CI_Limpiar(Data1)
    Data1.Recordset.Update
    Data1.Recordset.MoveLast
    
End Sub


Public Sub CI_BorrarTx(hWnd As Long)
   
    db.Execute "DELETE * FROM mdci WHERE tm_hwnd = " & hWnd
    
    db.Execute "DELETE * FROM mdco WHERE tm_hwnd = " & hWnd

End Sub
Public Sub CI_Eliminar(Data1 As Control)
Dim FormHandle&, Correlativo&

    FormHandle& = Data1.Recordset("tm_hwnd")
    Correlativo& = Data1.Recordset("tm_correlativo")
    
    Call CO_EliminarCortesMDB(FormHandle&, Correlativo&)

    If Data1.Recordset.RecordCount > 1 Then
        Data1.Recordset.Delete
    Else
        Data1.Recordset.Edit
        Call CI_Limpiar(Data1)
        Data1.Recordset.Update
    End If

End Sub


Public Sub CI_IniciarTx(hWnd As Long, Data1 As Control)

    Call CI_BorrarTx(hWnd)
    
    Data1.DatabaseName = gsMDB_Path & gsMDB_Database
    Data1.RecordsetType = 1
    Data1.RecordSource = "SELECT * FROM mdci WHERE tm_hwnd = " & hWnd
    Data1.Refresh
    
    Call CI_Agregar(hWnd, Data1)
       
End Sub

Private Sub CI_Limpiar(Data1 As Control)

    Data1.Recordset("tm_instser") = ""
    Data1.Recordset("tm_genemi") = ""
    Data1.Recordset("tm_nemmon") = ""
    Data1.Recordset("tm_nominal") = 0#
    Data1.Recordset("tm_tir") = 0#
    Data1.Recordset("tm_pvp") = 0#
    Data1.Recordset("tm_vpar") = 0#
    Data1.Recordset("tm_mt") = 0#
    Data1.Recordset("tm_mt100") = 0#
    Data1.Recordset("tm_tirmcd") = 0#
    Data1.Recordset("tm_pvpmcd") = 0#
    Data1.Recordset("tm_mtmcd") = 0#
    Data1.Recordset("tm_mtmcd100") = 0#
    Data1.Recordset("tm_mtml") = 0#
    Data1.Recordset("tm_tcml") = 0#
    Data1.Recordset("tm_rutemi") = 0#
    Data1.Recordset("tm_monemi") = 0#
    Data1.Recordset("tm_basemi") = 0#
    Data1.Recordset("tm_fecemi") = ""
    Data1.Recordset("tm_fecven") = ""
    Data1.Recordset("tm_tasemi") = 0#
    Data1.Recordset("tm_mascara") = ""
    Data1.Recordset("tm_numucup") = 0#
    Data1.Recordset("tm_tasest") = 0#
    Data1.Recordset("tm_mdse") = ""
    Data1.Recordset("tm_codigo") = 0#
    Data1.Recordset("tm_refnomi") = ""
    Data1.Recordset("tm_serie") = ""
    Data1.Recordset("tm_cortemin") = 0#
    Data1.Recordset("tm_valmcd") = "N"
    Data1.Recordset("tm_leeemi") = ""
    Data1.Recordset("tm_fecinip") = ""
    Data1.Recordset("tm_fecvenp") = ""
    Data1.Recordset("tm_valinip") = 0#
    Data1.Recordset("tm_valvenp") = 0#
    Data1.Recordset("tm_taspact") = 0#
    Data1.Recordset("tm_baspact") = 0
    Data1.Recordset("tm_monpact") = 0
    Data1.Recordset("tm_fecpcup") = ""
    Data1.Recordset("tm_clave_dcv") = ""
    Data1.Recordset("tm_custodia") = ""
    
    
End Sub

Public Function CI_SumarTotal(hWnd As Long) As Double

'Devuelve la suma en moneda de liquidación

Dim rs As Recordset
Dim Sql As String
Dim nTotal As Double
''    Sql = "SELECT SUM(tm_mt) As Total FROM mdci WHERE tm_hwnd = " & hWnd
    On Error GoTo Err_Rocordset
    Sql = "SELECT tm_monemi as moneda,tm_mt as Monto FROM mdci WHERE tm_hwnd = " & hWnd
    Set rs = db.OpenRecordset(Sql, dbOpenSnapshot)   'dbOpenSnapshot
    rs.MoveFirst
    Do While Not rs.EOF
        If rs.Fields("Moneda") = 13 Then
            nTotal = nTotal + Round(rs.Fields("Monto") * gsBac_TCambio, 0)
        Else
            nTotal = nTotal + rs.Fields("Monto")
        End If
        rs.MoveNext
    Loop
    CI_SumarTotal = nTotal
    
'    If rs.RecordCount > 0 Then
'        If Not IsNull(rs.Fields("Total")) Then
'            CI_SumarTotal = rs.Fields("Total")
'        Else
'            CI_SumarTotal = 0
'        End If
'    Else
'        CI_SumarTotal = 0
'    End If
    Exit Function
    
Err_Rocordset:
    MsgBox err.Description, vbCritical, "Error de Datos"
    
End Function
Public Function CI_ChkSerie(cInstser As String, Data1 As Control) As Boolean
Dim Sal As BacTypeChkSerie

    CI_ChkSerie = False
    
    If CPCI_ChkSerie(cInstser, Sal) = True Then
        If Sal.nError = 0 Then
            Data1.Recordset.Edit
            Call CI_Limpiar(Data1)
            Data1.Recordset("tm_mascara") = Sal.cMascara
            Data1.Recordset("tm_codigo") = Sal.nCodigo
            Data1.Recordset("tm_serie") = Sal.nSerie
            Data1.Recordset("tm_rutemi") = Sal.nRutemi
            Data1.Recordset("tm_monemi") = Sal.nMonemi
            Data1.Recordset("tm_tasemi") = Sal.fTasemi
            Data1.Recordset("tm_basemi") = Sal.fBasemi
            Data1.Recordset("tm_fecemi") = Sal.dFecemi
            Data1.Recordset("tm_fecven") = Sal.dFecven
            Data1.Recordset("tm_refnomi") = Sal.cRefnomi
            Data1.Recordset("tm_genemi") = Sal.cGenemi
            Data1.Recordset("tm_nemmon") = Sal.cNemmon
            Data1.Recordset("tm_cortemin") = Sal.nCorMin
            Data1.Recordset("tm_mdse") = Sal.cSeriado
            Data1.Recordset("tm_leeemi") = Sal.cLeeEmi
            Data1.Recordset("tm_valmcd") = "N"
            Data1.Recordset.Update
        
            CI_ChkSerie = True
        End If
    Else
'        CI_ChkSerie = False
    End If

End Function


Public Function CI_ValorFinal(ValIni#, Tasa#, Plazo&, base%) As Double
    
'   WRMS
'   CI_ValorFinal = ValIni + (ValIni * Tasa * Plazo) / (Base * 100#)

    CI_ValorFinal = ValIni * (((Tasa / (base * 100#)) * Plazo) + 1)
    
    If base = 30 Then
        CI_ValorFinal = Format(CI_ValorFinal, "##,###,###,###,##0")
    Else
        CI_ValorFinal = Format(CI_ValorFinal, "##,###,###,###,##0.0000")
    End If
    
End Function


