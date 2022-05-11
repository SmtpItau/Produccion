Attribute VB_Name = "modTicket_Intramesa"
Option Explicit
Dim Datos()
Public ENVIA2()



 

Public Function TICKETVENTA_SumarTotal(Hwnd As Long) As Double
Dim rs As Recordset
Dim Sql As String
Dim nTotal As Double
    
TICKETVENTA_SumarTotal = 0
nTotal = 0
Sql = "SELECT tm_monemi As Moneda,tm_vp As Monto FROM ticket_venta WHERE ( tm_venta = 'V' OR tm_venta = 'P' ) AND tm_hwnd = " & Hwnd
Set rs = db.OpenRecordset(Sql, dbOpenSnapshot)
If rs.RecordCount <= 0 Then Exit Function
rs.MoveFirst
Do While Not rs.EOF
   nTotal = nTotal + IIf(rs.Fields("Moneda") = 13, Round(rs.Fields("Monto") * gsBac_TCambio, 0), rs.Fields("Monto"))
   rs.MoveNext
Loop
TICKETVENTA_SumarTotal = nTotal
    
    
    
End Function



Function funcLoadObjCombo(StringSQL As String, Combo As ComboBox, Optional bEmptyRow As Boolean = False, Optional bCodigoSTR As Boolean = False)
   
   Combo.Clear
   
    If bEmptyRow Then
        Combo.AddItem "< TODOS >"
        Combo.ItemData(Combo.NewIndex) = 0
    End If
   
    If Bac_Sql_Execute(StringSQL) Then
            
        Do While Bac_SQL_Fetch(Datos)
        
            If bCodigoSTR Then
                Combo.AddItem Datos(2) & Space(100) & Datos(1)
            Else
                Combo.AddItem Datos(2)
                Combo.ItemData(Combo.NewIndex) = Datos(1)
            End If
            
          
        Loop
                
    Else
        MsgBox "problemas con la obtencion de información: " & vbCrLf & vbCrLf, vbCritical
        Exit Function
    End If
    
    If bEmptyRow Then Combo.ListIndex = 0
    
End Function








Public Sub TICKETVENTA_Valorizar(ModCal%, Data1 As Control, Optional ByVal dFechaSorteo As String, Optional cTipo As String)
   
   On Error GoTo CP_ValorizarError
   Dim Ent As BacValorizaInput
   Dim Sal As BacValorizaOutput
    
   Screen.MousePointer = vbHourglass
   
    With Ent
        .ModCal = ModCal%
        .FecCal = Format(gsBac_Fecp, "dd/mm/yyyy")
        
        .Codigo = Data1.Recordset("tm_codigo")
        .Mascara = Data1.Recordset("tm_instser")
        .Nominal = Data1.Recordset("tm_nominal")
      
        If cTipo = "" Then
            .tir = IIf(IsNull(Data1.Recordset("tm_tir")), 0, Data1.Recordset("tm_tir"))
            .Pvp = IIf(IsNull(Data1.Recordset("tm_pvp")), 0, Data1.Recordset("tm_pvp"))
            .Mt = IIf(IsNull(Data1.Recordset("tm_vp")), 0, Data1.Recordset("tm_vp"))
        Else
            .tir = IIf(IsNull(Data1.Recordset("tm_tir_tran")), 0, Data1.Recordset("tm_tir_tran"))
            .Pvp = IIf(IsNull(Data1.Recordset("tm_pvp_tran")), 0, Data1.Recordset("tm_pvp_tran"))
            .Mt = IIf(IsNull(Data1.Recordset("tm_vp_tran")), 0, Data1.Recordset("tm_vp_tran"))
        End If
      
        .TasEst = Data1.Recordset("tm_tasest")
        .MonEmi = Data1.Recordset("tm_monemi")
        .fecemi = Format(Data1.Recordset("tm_fecemi"), "dd/mm/yyyy")
        .FecVen = Format(Data1.Recordset("tm_fecven"), "dd/mm/yyyy")
        .TasEmi = Data1.Recordset("tm_tasemi")
        .BasEmi = Data1.Recordset("tm_basemi")
    End With
   
    If BacValorizar(Ent, Sal) Then
        Data1.Recordset.Edit
        Data1.Recordset("tm_nominal") = Sal.Nominal
    
        If cTipo = "" Then
            Data1.Recordset("tm_tir") = Sal.tir
            Data1.Recordset("tm_pvp") = Sal.Pvp
            Data1.Recordset("tm_vpar") = Sal.Vpar
            Data1.Recordset("tm_vp") = Sal.Mt
            Data1.Recordset("tm_vp100") = Sal.Mt100
            Data1.Recordset("tm_numucup") = Sal.Numucup
            Data1.Recordset("tm_vptirc") = Data1.Recordset("tm_capitalc") + Data1.Recordset("tm_interesc") + Data1.Recordset("tm_reajustc")
            Data1.Recordset("tm_vptirc") = Data1.Recordset("tm_vptirc") * (Sal.Nominal / Data1.Recordset("tm_nominalo"))
            Data1.Recordset("tm_fecpcup") = Sal.Fecpcup
            Data1.Recordset("tm_VpMo") = Sal.MtUM
        ElseIf cTipo = "TRAN" Then
            Data1.Recordset("tm_tir_tran") = Sal.tir
            Data1.Recordset("tm_pvp_tran") = Sal.Pvp
            Data1.Recordset("tm_vp_tran") = Sal.Mt
            Data1.Recordset("tm_Vp_Tran_Mo") = Sal.MtUM
        End If
    
        ' Grabo datos para calcular limites PFE y CCE
        Data1.Recordset("tm_duratmac") = Sal.duratmac
        Data1.Recordset("tm_duratmod") = Sal.duratmod
        Data1.Recordset("tm_convex") = Sal.convexid
        Data1.Recordset.Update
    End If

   '--> Agregado para las Ventas PM
    With Ent
        If .FecCal > gsBac_Fecp Then
            .ModCal = 2 '--> ModCal%
            
            If dFechaSorteo = "" Then
                .FecCal = Format(gsBac_Fecp, "dd/mm/yyyy")
            Else
                .FecCal = dFechaSorteo
            End If
            
            .Codigo = Data1.Recordset("tm_codigo")
            .Mascara = Data1.Recordset("tm_instser")
            .Nominal = Data1.Recordset("tm_nominal")
            .tir = IIf(IsNull(Data1.Recordset("tm_tircomp")), 0, Data1.Recordset("tm_tircomp"))
            .Pvp = IIf(IsNull(Data1.Recordset("tm_pvp")), 0, Data1.Recordset("tm_pvp"))
            .Mt = IIf(IsNull(Data1.Recordset("tm_vp")), 0, Data1.Recordset("tm_vp"))
            .TasEst = Data1.Recordset("tm_tasest")
            .MonEmi = Data1.Recordset("tm_monemi")
            .fecemi = Format(Data1.Recordset("tm_fecemi"), "dd/mm/yyyy")
            .FecVen = Format(Data1.Recordset("tm_fecven"), "dd/mm/yyyy")
            .TasEmi = Data1.Recordset("tm_tasemi")
            .BasEmi = Data1.Recordset("tm_basemi")

            Call BacValorizar(Ent, Sal)

            Data1.Recordset.Edit
            Data1.Recordset("tm_vptirc") = Sal.Mt
            Data1.Recordset.Update
        End If
    End With
   '--> Agregado para las Ventas PM
   
   Screen.MousePointer = vbDefault
Exit Sub

CP_ValorizarError:
    Screen.MousePointer = vbDefault
   
    If err <> 0 Then
        MsgBox error(err), vbCritical, gsBac_Version
    End If
  
    Exit Sub
End Sub


Public Sub TICKETVENTA_ValorizarTotal(Data1 As Control, dTotalNuevo#, dTotalActual#, Optional ByVal dFechaSorteo As String)
On Error GoTo BacErrorHandler

'Datos de Input
Dim Ent As BacValorizaInput
'Datos de Output
Dim Sal As BacValorizaOutput
'Modalidad de cálculo
Dim ModCal%
'Datos para el cálculo.-
Dim dFactor#, nRecord&, lNumReg&, lContador&, dTotalAcum#, MtMl#

    'setear el mouse pointer.-
    Screen.MousePointer = vbHourglass
    
    'Valorización por Nominal y Valor presente
    ModCal% = 3
    
    If dTotalNuevo = 0 Then
        Screen.MousePointer = 0
        Exit Sub
    End If
    'Factor de cambio
    If dTotalActual# = 0 Then
        dFactor# = 1
    Else
        dFactor# = dTotalNuevo# / dTotalActual#
    End If
    
    'Empieza una transacción local (MDB)
    WS.BeginTrans
    
    nRecord& = Data1.Recordset.AbsolutePosition
    
    lNumReg& = 0
    Data1.Recordset.MoveFirst
    
    Do While Not Data1.Recordset.EOF
       If Data1.Recordset("tm_venta") = "P" Or Data1.Recordset("tm_venta") = "V" Then
          lNumReg& = lNumReg& + 1
       End If
       Data1.Recordset.MoveNext
    Loop
        
    Data1.Recordset.MoveFirst
'   lNumReg& = data1.Recordset.RecordCount
    lContador& = 0#
    dTotalAcum# = 0#
    
    Do While Not Data1.Recordset.EOF
    
       If Data1.Recordset("tm_venta") = "P" Or Data1.Recordset("tm_venta") = "V" Then
            lContador& = lContador& + 1
        
            With Ent
                .ModCal = ModCal%
               If dFechaSorteo = "" Then
                  .FecCal = Format$(gsBac_Fecp, "yyyymmdd")
               Else
                  .FecCal = dFechaSorteo
               End If
                .Codigo = Data1.Recordset("tm_codigo")
                .Mascara = Data1.Recordset("tm_instser")
                .Nominal = Data1.Recordset("tm_nominal")
                .tir = Data1.Recordset("tm_tir")
                .Pvp = Data1.Recordset("tm_pvp")
                .Mt = Data1.Recordset("tm_vp")
                .TasEst = Data1.Recordset("tm_tasest")
                .MonEmi = Data1.Recordset("tm_monemi")
                .fecemi = Format(Data1.Recordset("tm_fecemi"), "yyyymmdd")
                .FecVen = Format(Data1.Recordset("tm_fecven"), "yyyymmdd")
                .TasEmi = Data1.Recordset("tm_tasemi")
                .BasEmi = Data1.Recordset("tm_basemi")
            End With

            If lContador& = lNumReg& Then
                'Para el último registro envío a valorizar el saldo
                MtMl# = dTotalNuevo# - dTotalAcum#
                Ent.Mt# = IIf(Data1.Recordset("tm_monemi") = 13, Round(MtMl# / gsBac_TCambio, 2), MtMl#) 'VGS MtMl#
                If Ent.Mt# < 0 Then GoTo BacErrorHandler
            Else
                MtMl# = Data1.Recordset("tm_vp") * dFactor#
                MtMl# = Format(MtMl#, IIf(Data1.Recordset("tm_monemi") = 13, "00000000000000.00", "00000000000000000"))
                Ent.Mt# = MtMl#
                
            End If
        
            If BacValorizar(Ent, Sal) = True Then
                Data1.Recordset.Edit
                Data1.Recordset("tm_nominal") = Sal.Nominal
                Data1.Recordset("tm_tir") = Sal.tir
                Data1.Recordset("tm_pvp") = Sal.Pvp
                Data1.Recordset("tm_vpar") = Sal.Vpar
                Data1.Recordset("tm_vp") = Sal.Mt
                Data1.Recordset("tm_mtml") = MtMl#
                Data1.Recordset("tm_numucup") = Sal.Numucup
                'Para los datos de compra solo puede cambiar el VPres a Tir de Compra                data1.Recordset("tm_vptirc") = o_MtCom#
                Data1.Recordset.Update
' VGS                dTotalAcum# = dTotalAcum# + Data1.Recordset("tm_mtml")
                dTotalAcum# = dTotalAcum# + IIf(Data1.Recordset("tm_monemi") = 13, Round(Data1.Recordset("tm_mtml") * gsBac_TCambio, 0), Data1.Recordset("tm_mtml"))
                
            Else
                GoTo BacErrorHandler
            End If
          
        End If
        
        Data1.Recordset.MoveNext

    Loop
   If nRecord& >= 0 Then
    Data1.Recordset.AbsolutePosition = nRecord&
   End If
    Screen.MousePointer = vbDefault
    
    'Compromete los cambios
    WS.CommitTrans
    
    Exit Sub
    
BacErrorHandler:

    If err <> 0 Then
        MsgBox error(err), vbCritical, gsBac_Version
    Else
        MsgBox "Problema en proceso de valorización de operación de venta: " & err.Description & ". Comunique al Administrador. ", vbCritical, gsBac_Version
    End If
    
    Screen.MousePointer = 0
    WS.Rollback
    Data1.Refresh

    Exit Sub
    
End Sub
Public Function TICKETVENTA_VerBloqueo(Hwnd As Long, Data1 As Control)
Dim Datos()
    
    TICKETVENTA_VerBloqueo = True

    Envia = Array(CDbl(Data1.Recordset("tm_rutcart")), _
            CDbl(Data1.Recordset("tm_numdocu")), _
            CDbl(Data1.Recordset("tm_correla")), _
            CDbl(Data1.Recordset("tm_nominalo")), _
            CDbl(Hwnd), _
            gsBac_User)
            
    If Bac_Sql_Execute("SP_VERBLOQUEO", Envia) Then
        Do While Bac_SQL_Fetch(Datos())
            If Datos(1) = "SI" Then
                TICKETVENTA_VerBloqueo = False
            End If
        Loop
    End If
       
End Function
Public Function TICKETVENTA_VerDispon(Hwnd As Long, Data1 As Control)
Dim Datos()
On Error GoTo ErrVenta
    
    TICKETVENTA_VerDispon = False
    
    Envia = Array(CDbl(Data1.Recordset!tm_rutcart), _
            CDbl(Data1.Recordset!Tm_numdocu), _
            CDbl(Data1.Recordset!tm_correla), _
            CDbl(Data1.Recordset!tm_nominalo), _
            CDbl(Hwnd), _
            gsBac_User)
            
    If Bac_Sql_Execute("SP_VERDISPON", Envia) Then
        Do While Bac_SQL_Fetch(Datos())
            
            If Datos(1) = "SI" Then
                
                TICKETVENTA_VerDispon = True
            
            ElseIf Datos(1) = "VE" Then
                    
                    MsgBox "Instrumento fue Vendido de Cartera", vbInformation, gsBac_Version
            
            ElseIf Datos(1) = "MD" Then
                    
                    MsgBox "Nominal de Instrumento fue Modificado", vbInformation, gsBac_Version
                    Data1.Recordset.Edit
                    Data1.Recordset("tm_nominal") = CDbl(Datos(15))
                    Data1.Recordset("tm_nominalo") = CDbl(Datos(15))
                    Data1.Recordset("tm_tir") = CDbl(Datos(16))
                    Data1.Recordset("tm_pvp") = CDbl(Datos(17))
                    Data1.Recordset("tm_vpar") = 0#
                    Data1.Recordset("tm_vp") = Val(Datos(18))
                    Data1.Recordset("tm_tircomp") = CDbl(Datos(16))
                    Data1.Recordset("tm_pvpcomp") = CDbl(Datos(17))
                    Data1.Recordset("tm_vptirc") = Val(Datos(18))
                    Data1.Recordset("tm_pvpmcd") = CDbl(Datos(19))
                    Data1.Recordset("tm_tirmcd") = CDbl(Datos(20))
                    Data1.Recordset("tm_vpmcd100") = Val(Datos(21))
                    Data1.Recordset("tm_vpmcd") = Val(Datos(22))
                    Data1.Recordset("tm_vptirci") = Val(Datos(23))
                    Data1.Recordset("tm_interesc") = Val(Datos(26))
                    Data1.Recordset("tm_reajustc") = Val(Datos(27))
                    Data1.Recordset("tm_intereci") = Val(Datos(28))
                    Data1.Recordset("tm_reajusci") = Val(Datos(29))
                    Data1.Recordset("tm_capitalc") = Val(Datos(30))
                    Data1.Recordset("tm_capitaci") = Val(Datos(31))
                    Data1.Recordset("tm_mtml") = 0#
                    Data1.Recordset("tm_tcml") = 0#
                    Data1.Recordset.Update
                     
            End If
               
        Loop
    End If
    Exit Function
    
    
ErrVenta:
    MsgBox "Problemas en verificación de disponibilidad: " & err.Description & ". verifique.", vbCritical, gsBac_Version
    Exit Function

End Function


Public Function TICKETVENTA_SumarCartera(Hwnd As Long, txtplazo As String, CmdTipoFiltro As Control) As Double
Dim rs As Recordset
Dim Sql As String
Dim nTotal As Double

   TICKETVENTA_SumarCartera = 0
   nTotal = 0
   If CmdTipoFiltro.Buttons(6).Tag = "Ver Sel." Then
       Sql = "SELECT tm_monemi As Moneda,tm_vptirc As Monto FROM ticket_venta WHERE tm_hwnd = " & Hwnd & " AND tm_diasdisp >= " & txtplazo
   Else
       Sql = "SELECT tm_monemi As Moneda,tm_vptirc As Monto FROM ticket_venta WHERE ( tm_venta = 'V' OR tm_venta = 'P' ) AND tm_hwnd = " & Hwnd & " AND tm_diasdisp >= " & txtplazo
   End If

   Set rs = db.OpenRecordset(Sql, dbOpenSnapshot)
   If rs.RecordCount <= 0 Then Exit Function
   rs.MoveFirst
   Do While Not rs.EOF
       nTotal = nTotal + IIf(rs.Fields("Moneda") = 13, Round(rs.Fields("Monto") * gsBac_TCambio, 0), rs.Fields("Monto"))
       rs.MoveNext
   Loop
   TICKETVENTA_SumarCartera = nTotal
    
''   If CmdTipoFiltro.Buttons(6).Tag = "Ver Sel." Then
''       Sql = "SELECT SUM(tm_vptirc) As Total FROM mdventa WHERE tm_hwnd = " & hWnd & " AND tm_diasdisp >= " & txtplazo
''   Else
''       Sql = "SELECT SUM(tm_vptirc) As Total FROM mdventa WHERE ( tm_venta = 'V' OR tm_venta = 'P' ) AND tm_hwnd = " & hWnd & " AND tm_diasdisp >= " & txtplazo
''   End If
''
''   Set rs = db.OpenRecordset(Sql, dbOpenSnapshot)
''
''   If rs.RecordCount > 0 Then
''      If Not IsNull(rs.Fields("Total")) Then
''          VENTA_SumarCartera = rs.Fields("Total")
''      End If
''   End If
    
End Function


Public Function TICKETVENTA_SumarDif(Hwnd As Long) As Double
Dim rs As Recordset
Dim Sql As String

   TICKETVENTA_SumarDif = 0
   Sql = "SELECT SUM(tm_vp - tm_vptirc) As Total FROM ticket_venta WHERE ( tm_venta = 'V' OR tm_venta = 'P' ) AND tm_hwnd = " & Hwnd
   Set rs = db.OpenRecordset(Sql, dbOpenSnapshot)
    
   If rs.RecordCount > 0 Then
      If Not IsNull(rs.Fields("Total")) Then
         TICKETVENTA_SumarDif = rs.Fields("Total")
      End If
   End If

End Function


Public Sub TICKETVENTA_Agregar(Data1 As Data, Datos(), Hwnd, TipVen$)
   
   'Call VENTA_BorrarTx(36603626)
   Data1.Recordset.AddNew
   Data1.Recordset("tm_hwnd") = Hwnd
   Data1.Recordset("tm_tipven") = TipVen$
   Data1.Recordset("tm_rutcart") = Val(Datos(4))
   Data1.Recordset("tm_tipcart") = Val(Datos(5))
   Data1.Recordset("tm_numdocu") = Val(Datos(6))
   Data1.Recordset("tm_correla") = Val(Datos(7))
   Data1.Recordset("tm_numdocuo") = Val(Datos(8))
   Data1.Recordset("tm_correlao") = Val(Datos(9))
   Data1.Recordset("tm_tipoper") = Datos(10)
   Data1.Recordset("tm_serie") = Datos(11)
   Data1.Recordset("tm_instser") = Datos(12)
   Data1.Recordset("tm_genemi") = Datos(13)
   Data1.Recordset("tm_nemmon") = Datos(14)
   Data1.Recordset("tm_nominal") = CDbl(Datos(15))
   Data1.Recordset("tm_nominalo") = CDbl(Datos(15))
   Data1.Recordset("tm_tir") = CDbl(Datos(16))
   Data1.Recordset("tm_pvp") = CDbl(Datos(17))
   Data1.Recordset("tm_vpar") = 0#
   Data1.Recordset("tm_vp") = CDbl(Datos(18))
   Data1.Recordset("tm_vp100") = 0#
   Data1.Recordset("tm_tircomp") = CDbl(Datos(16))
   Data1.Recordset("tm_pvpcomp") = CDbl(Datos(17))
   Data1.Recordset("tm_vptirc") = CDbl(Datos(18))
   Data1.Recordset("tm_pvpmcd") = CDbl(Datos(19))
   Data1.Recordset("tm_tirmcd") = CDbl(Datos(20))
   Data1.Recordset("tm_vpmcd100") = CDbl(Datos(21))
   Data1.Recordset("tm_vpmcd") = Val(Datos(22))
   Data1.Recordset("tm_vptirci") = CDbl(Datos(23))
   Data1.Recordset("tm_fecsal") = Datos(24)
   Data1.Recordset("tm_numucup") = Val(Datos(25))
   Data1.Recordset("tm_interesc") = Val(Datos(26))
   Data1.Recordset("tm_reajustc") = Val(Datos(27))
   Data1.Recordset("tm_intereci") = Val(Datos(28))
   Data1.Recordset("tm_reajusci") = Val(Datos(29))
   Data1.Recordset("tm_capitalc") = CDbl(Datos(30))
   Data1.Recordset("tm_capitaci") = CDbl(Datos(31))
   Data1.Recordset("tm_mtml") = 0#
   Data1.Recordset("tm_tcml") = 0#
   
   ' Datos necesarios para la valorización
   Data1.Recordset("tm_codigo") = Val(Datos(32))
   Data1.Recordset("tm_mascara") = Datos(33)
   Data1.Recordset("tm_tasest") = CDbl(Datos(34))
   
   ' Datos de Emision
   Data1.Recordset("tm_rutemi") = Val(IIf(IsNull(Datos(35)), 0, Datos(35)))
   Data1.Recordset("tm_monemi") = Val(IIf(IsNull(Datos(36)), 0, Datos(36)))
   Data1.Recordset("tm_tasemi") = CDbl(IIf(IsNull(Datos(37)), 0, Datos(37)))
   Data1.Recordset("tm_basemi") = Val(IIf(IsNull(Datos(38)), 0, Datos(38)))
   Data1.Recordset("tm_fecemi") = Datos(39)
   Data1.Recordset("tm_fecven") = Datos(40)
   Data1.Recordset("tm_fecpcup") = Datos(41)
    
   If Datos(42) = "" Then
      
      Data1.Recordset("tm_venta") = " "
   
   Else
       
       Data1.Recordset("tm_venta") = Datos(42)
   
   End If
    
   Data1.Recordset("tm_diasdisp") = Val(Datos(43))
    
   Select Case Trim(Datos(44))
      
      Case "C"
         
         Data1.Recordset("tm_custodia") = "CLIENTE"
         Data1.Recordset("tm_custoori") = "CLIENTE"
      
      Case "D"
         
         Data1.Recordset("tm_custodia") = "DCV"
         Data1.Recordset("tm_custoori") = "DCV"
         
      Case Else
      
         Data1.Recordset("tm_custodia") = "PROPIA"
         Data1.Recordset("tm_custoori") = "PROPIA"
         
   End Select
    
   Data1.Recordset("tm_mdse") = Datos(45)
    
   Data1.Recordset("tm_convex") = Datos(46)
   Data1.Recordset("tm_duratmac") = Datos(47)
   Data1.Recordset("tm_duratmod") = Datos(48)
   
   ' Datos de respaldo
   Data1.Recordset("tm_convexori") = Datos(46)
   Data1.Recordset("tm_durmacori") = Datos(47)
   Data1.Recordset("tm_durmodori") = Datos(48)
   Data1.Recordset("tm_carterasuper") = Datos(49) 'insertado
   Data1.Recordset("tm_id_libro") = Datos(50)
   Data1.Recordset("tm_modpago") = IIf(Datos(51) = "", " ", Datos(51))
   
   Data1.Recordset("tm_tir_Tran") = CDbl(Datos(16))
   Data1.Recordset("tm_pvp_Tran") = CDbl(Datos(17))
   Data1.Recordset("tm_vp_Tran") = CDbl(Datos(18))
   
   Data1.Recordset.Update
   
End Sub

Public Function TICKETVENTA_Bloquear(Hwnd As Long, Data1 As Control)
Dim Datos()
    
    TICKETVENTA_Bloquear = False
    
    Envia = Array()
    AddParam Envia, CDbl(Data1.Recordset("tm_rutcart"))
    AddParam Envia, CDbl(Data1.Recordset("tm_numdocu"))
    AddParam Envia, CDbl(Data1.Recordset("tm_correla"))
    AddParam Envia, CDbl(Data1.Recordset("tm_nominalo"))
    AddParam Envia, CDbl(Hwnd)
    AddParam Envia, gsBac_User

   ' Envia = Array(CDbl(Data1.Recordset("tm_rutcart")), _
   '        CDbl(Data1.Recordset("tm_numdocu")), _
   '         CDbl(Data1.Recordset("tm_correla")), _
   '         CDbl(Data1.Recordset("tm_nominalo")), _
   '         CDbl(hWnd), _
   '         gsBac_User)
            
    If Bac_Sql_Execute("SP_BLOQUEARVP", Envia) Then
        Do While Bac_SQL_Fetch(Datos())
'            If datos(1) = "SI" Then
                TICKETVENTA_Bloquear = True
'            Else
'               Select Case datos(4)
'               Case "3"
'                 MsgBox "Instrumento está marcado por " & datos(2) & ".", vbInformation, gsBac_Version'''

'               Case Else
'                  MsgBox "Instrumento está seleccionado en otra ventana", vbInformation, gsBac_Version

'               End Select
            'End If
        Loop
    End If
   
End Function
Public Sub TICKETVENTA_BorrarTx(Hwnd As Long)
                       
    db.Execute "DELETE * FROM ticket_venta WHERE tm_hwnd = " & Hwnd
    db.Execute "DELETE * FROM mdco WHERE tm_hwnd = " & Hwnd
    
End Sub
Public Function TICKETVENTA_DesBloquear(Hwnd As Long, Data1 As Control)
Dim Datos()
    
    TICKETVENTA_DesBloquear = False
    
    Envia = Array(CDbl(Data1.Recordset("tm_rutcart")), _
            CDbl(Data1.Recordset("tm_numdocu")), _
            CDbl(Data1.Recordset("tm_correla")), _
            CDbl(Hwnd), _
            gsBac_User)
            
    If Bac_Sql_Execute("SP_DESBLOQUEARINST", Envia) Then
        Do While Bac_SQL_Fetch(Datos())
            If Datos(1) = "SI" Then
                TICKETVENTA_DesBloquear = True
            Else
               Beep
               MsgBox "Instrumento no pudo desbloquearse", vbCritical, gsBac_Version 'insertado 06/02/2001
            End If
        Loop
    End If
    
End Function

'Elimina todos los registro bloqueados que estan en la MDB
'de la tabla de bloqueados del servidor
Public Sub TICKETVENTA_EliminarBloqueados(Data1 As Control, FormHandle&)

    If Data1.Recordset.RecordCount > 0 Then
    
        Data1.Recordset.MoveFirst
        
        Do While Not Data1.Recordset.EOF
        
          If Data1.Recordset("tm_venta") = "V" Or Data1.Recordset("tm_venta") = "P" Then
                If VENTA_DesBloquear(FormHandle, Data1) Then
                End If
          End If
        
          Data1.Recordset.MoveNext
          
        Loop
        
    End If

End Sub
Public Sub TICKETVENTA_IniciarTx(Hwnd As Long, Data1 As Control, Dias As Double)

    Call TICKETVENTA_BorrarTx(Hwnd)
    
    Data1.DatabaseName = gsMDB_Path & gsMDB_Database
    Data1.RecordSource = "SELECT * FROM ticket_venta WHERE tm_hwnd = " & Hwnd & " AND tm_diasdisp >= " & Dias
    Data1.Refresh
    
End Sub
Public Sub TICKETVENTA_Restaurar(Data1 As Control)
Dim Rutcart&, NumDocu#, Correla%, FormHandle&
Dim Correlativo&

'Restaura los valore originales de Disponibilidad

    FormHandle = Data1.Recordset("tm_hwnd")
    Rutcart = Data1.Recordset("tm_rutcart")
    NumDocu = Data1.Recordset("tm_numdocu")
    Correla = Data1.Recordset("tm_correla")
    
'   Correlativo = data1.Recordset("tm_correlativo")

    Data1.Recordset.Edit
    Data1.Recordset("tm_nominal") = Data1.Recordset("tm_nominalo")
    Data1.Recordset("tm_tir") = Data1.Recordset("tm_tircomp")
    Data1.Recordset("tm_pvp") = Data1.Recordset("tm_pvpcomp")
    Data1.Recordset("tm_vp") = Data1.Recordset("tm_capitalc") + Data1.Recordset("tm_interesc") + Data1.Recordset("tm_reajustc")
    Data1.Recordset("tm_vptirc") = Data1.Recordset("tm_capitalc") + Data1.Recordset("tm_interesc") + Data1.Recordset("tm_reajustc")
    
    Data1.Recordset("tm_custodia") = Data1.Recordset("tm_custoori")
    Data1.Recordset("tm_clave_dcv") = ""
    Data1.Recordset("tm_convex") = Data1.Recordset("tm_convexori")
    Data1.Recordset("tm_duratmod") = Data1.Recordset("tm_durmodori")
    Data1.Recordset("tm_duratmac") = Data1.Recordset("tm_durmacori")
    
    If Data1.Recordset("tm_venta") = "P" Then
       Data1.Recordset("tm_venta") = "V"
    End If
    
    Data1.Recordset.Update
    
End Sub



Public Sub TICKETCP_Agregar(Hwnd As Long, Data1 As Control)

  ' Agrega un registro en blanco a la Tabla MDCP
    On Error GoTo 0
    Data1.Recordset.AddNew
    Data1.Recordset("tm_hwnd") = Hwnd
'    Data1.Recordset("tm_codexceso") = 0
    Data1.Recordset("tm_tcml") = 1
   ' VB +- 09/06/2000 se debe dejar vacio  por cambio de revision
  '  data1.Recordset("tm_custodia") = "PROPIA" ' VB+- 18/02/2000 se deja para custodia
    Call TICKETCP_Limpiar(Data1)
    Data1.Recordset.Update
    
    Data1.Recordset.MoveLast
    
End Sub


Public Sub TICKETCP_BorrarTx(Hwnd As Long)
   
   'Limpia datos de la tabla de compras propias
    db.Execute "DELETE * FROM ticket_compra WHERE tm_hwnd = " & Hwnd
    
    
   'Limpia datos de la tabla de cortes
    db.Execute "DELETE * FROM mdco WHERE tm_hwnd = " & Hwnd

End Sub

Public Function TICKETCP_ChkSerie(cInstser As String, Data1 As Control) As Boolean
Dim Sal As BacTypeChkSerie

    TICKETCP_ChkSerie = False
       
    If CPCI_ChkSerie(cInstser, Sal) = True Then
        If Sal.nError = 0 Then
            Data1.Recordset.Edit
            Call TICKETCP_Limpiar(Data1)
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
            
            
            
            TICKETCP_ChkSerie = True
        End If
    Else
'        CP_ChkSerie = False
    End If
    

End Function
Public Sub TICKETCP_Eliminar(Data1 As Control)
Dim FormHandle&, Correlativo&


    FormHandle& = Data1.Recordset("tm_hwnd")
    Correlativo& = 1 'Data1.Recordset("tm_correlativo")
    
    'Call CO_EliminarCortesMDB(FormHandle&, Correlativo&)

    If Data1.Recordset.RecordCount > 1 Then
        Data1.Recordset.Delete
    Else
        Data1.Recordset.Edit
        Call TICKETCP_Limpiar(Data1)
        Data1.Recordset.Update
    End If

End Sub



Function TICKETCP_GrabarTx(dNumOperacion As Long, sTipoOperacion As String, dNumOperRelacion As Long, hForm As Form) As Boolean
Dim Datos()

Dim sMascara        As String
Dim sInstSer        As String
Dim sGenEmi         As String
Dim sNemMon         As String
Dim sFecpcup        As String
Dim sFecEmi         As String
Dim sFecVen         As String
Dim sMdse           As String
Dim sSerie          As String
Dim sFecPro         As String
Dim cCustodiaDCV    As String
Dim cClaveDCV       As String
Dim cCarteraSuper   As String
Dim Mensaje_Lim     As String
Dim Mensaje_Lin     As String
Dim Mens_Lim_Graba  As String
Dim Mens_Lin_Graba  As String

Dim dNominal        As Double
Dim dTir            As Double
Dim dPvp            As Double
Dim dVPar           As Double
Dim dMt             As Double
Dim dMt100          As Double
Dim dTasEmi         As Double
Dim dTirMcd         As Double
Dim dPvpMcd         As Double
Dim dMtMcd          As Double
Dim dMtMcd100       As Double
Dim dTasEst         As Double
Dim CorteMin        As Double
Dim dDifTran_MO     As Double
Dim dDifTran_CLP    As Double
Dim nTipoCambio     As Double
Dim dNumdocu        As Double
Dim dMontoOriginal  As Double
Dim dTipoCambio988  As Double
Dim dMtoExcLIM      As Double
Dim dConvexidad     As Double
Dim dDuratMac       As Double
Dim dDuratMod       As Double

Dim iCorrela        As Integer
Dim iNumUCup        As Integer
Dim lCodigo         As Integer
Dim iMonemi         As Integer
Dim iBasemi         As Integer
Dim Resultado       As Integer
Dim iCodExeLIM      As Integer
Dim iPlazo          As Integer

Dim lRutemi         As Long
Dim Correlativo     As Long

Dim bExisteDPX      As Boolean
Dim FlagTx          As Boolean


On Error GoTo CP_GrabarTxError

    Let bExisteDPX = False
    Let dTipoCambio988 = FUNC_BUSCA_VALOR_MONEDA(998, Format(gsBac_Fecp, "DD/MM/YYYY"))
    
    Let sFecPro = Format(gsBac_Fecp, feFECHA)
    
    Let FlagTx = True
    
    Let iCorrela% = 0
    
    Call hForm.Data1.Recordset.MoveFirst
             
    Do While Not hForm.Data1.Recordset.EOF
        
        If Trim$(hForm.Data1.Recordset("tm_instser")) <> "" Then
        
            With hForm
            
                sMascara = .Data1.Recordset("tm_mascara")
                sInstSer = .Data1.Recordset("tm_instser")
                sGenEmi = .Data1.Recordset("tm_genemi")
                sNemMon = .Data1.Recordset("tm_nemmon")
                dNominal = .Data1.Recordset("tm_nominal")
                dTir = .Data1.Recordset("tm_tir")
                dPvp = .Data1.Recordset("tm_pvp")
                dVPar = .Data1.Recordset("tm_vpar")
                dMt = .Data1.Recordset("tm_mt")
                dMt100 = .Data1.Recordset("tm_mt100")
                dTirMcd = 0
                dPvpMcd = 0
                dMtMcd = 0
                dMtMcd100 = .Data1.Recordset("tm_mtmcd100")
                iNumUCup = .Data1.Recordset("tm_numucup")
                dTasEst = .Data1.Recordset("tm_tasest")
                sFecEmi = .Data1.Recordset("tm_fecemi")
                sFecVen = .Data1.Recordset("tm_fecven")
                sMdse = .Data1.Recordset("tm_mdse")
                lCodigo = .Data1.Recordset("tm_codigo")
                iMonemi = .Data1.Recordset("tm_monemi")
                lRutemi = .Data1.Recordset("tm_rutemi")
                dTasEmi = .Data1.Recordset("tm_tasemi")
                iBasemi = .Data1.Recordset("tm_basemi")
                sSerie = .Data1.Recordset("tm_serie")
                sFecpcup = .Data1.Recordset("tm_fecpcup")
                cCustodiaDCV = Mid$(.Data1.Recordset("tm_custodia"), 1, 1)
                
                cClaveDCV = " "
                
                dConvexidad = IIf(IsNull(.Data1.Recordset("tm_convexidad")), 0, .Data1.Recordset("tm_convexidad"))
                dDuratMac = IIf(IsNull(.Data1.Recordset("tm_durationmac")), 0, .Data1.Recordset("tm_durationmac"))
                dDuratMod = IIf(IsNull(.Data1.Recordset("tm_durationmod")), 0, .Data1.Recordset("tm_durationmod"))
                
                iCodExeLIM = 0
                dMtoExcLIM = 0
                iPlazo = DateDiff("D", Format(gsBac_Fecp, "dd/mm/yyyy"), Format$(sFecVen, "dd/mm/yyyy"))
                cCarteraSuper = IIf(IsNull(.Data1.Recordset("tm_carterasuper")), "SC", .Data1.Recordset("tm_carterasuper"))
                
                nTipoCambio = 0
                nTipoCambio = funcBuscaTipcambio(.Data1.Recordset!tm_monemi, gsBac_Fecp)
                
                dTirMcd# = .Data1.Recordset("tm_tirmcd")
                dPvpMcd# = .Data1.Recordset("tm_pvpmcd")
                dMtMcd# = .Data1.Recordset("tm_mtmcd")
                                
                dDifTran_MO# = Str((.Data1.Recordset("tm_mt") - .Data1.Recordset("tm_mtmcd")))
                dDifTran_CLP# = Str(((.Data1.Recordset("tm_mt") - .Data1.Recordset("tm_mtmcd")) * nTipoCambio))
                
            End With
            
            iCorrela% = iCorrela% + 1
            
            Envia = Array()
            AddParam Envia, dNumOperacion
            AddParam Envia, CDbl(iCorrela)
            AddParam Envia, sTipoOperacion
            AddParam Envia, dNumOperRelacion
            AddParam Envia, Format(gsBac_Fecp, "yyyymmdd")                                      '-> Fecha Operacion
            
           ' AddParam Envia, hForm.CmbCarteraOrigen.ItemData(hForm.CmbCarteraOrigen.ListIndex)   '-> Código Cartera Origen
            AddParam Envia, Trim(Right(hForm.CmbCarteraOrigen.Text, 5))                               '-> Código Cartera Origen
            AddParam Envia, Trim(Right(hForm.CmbMesaOrigen.Text, 5)) 'hForm.CmbMesaOrigen.ItemData(hForm.CmbMesaOrigen.ListIndex)         '-> Código Mesa Origen
            AddParam Envia, Trim(Right(hForm.CmbCarteraDestino.Text, 5))                              '-> Código Cartera Destino
            AddParam Envia, Trim(Right(hForm.CmbMesaDestino.Text, 5)) 'hForm.CmbMesaDestino.ItemData(hForm.CmbMesaDestino.ListIndex)       '-> Código Mesa Destino
            
            AddParam Envia, sMascara
            AddParam Envia, sInstSer
            AddParam Envia, sGenEmi
            AddParam Envia, sNemMon
            AddParam Envia, dNominal
            AddParam Envia, dTir
            AddParam Envia, dPvp
            AddParam Envia, dVPar
            AddParam Envia, dMt
            AddParam Envia, CDbl(iNumUCup)
            AddParam Envia, Format(gsBac_Fecp, feFECHA)
            AddParam Envia, dTasEst
            AddParam Envia, Format(sFecEmi, feFECHA)
            AddParam Envia, Format(sFecVen, feFECHA)
            AddParam Envia, sMdse
            AddParam Envia, CDbl(lCodigo)
            AddParam Envia, sSerie
            AddParam Envia, CDbl(iMonemi)
            AddParam Envia, CDbl(lRutemi)
            AddParam Envia, dTasEmi
            AddParam Envia, CDbl(iBasemi)
            AddParam Envia, gsUsuario
            AddParam Envia, gsTerminal
            AddParam Envia, Format(sFecpcup, feFECHA)
            AddParam Envia, dConvexidad
            AddParam Envia, dDuratMac
            AddParam Envia, dDuratMod
            AddParam Envia, Format(hForm.FechaPago.Text, feFECHA)

            If Not Bac_Sql_Execute("dbo.SP_GRABAOPERACION_TICKETINTRAMESA_COMPRAS", Envia) Then
                GoTo CP_GrabarTxError
            End If
                               
          ' CorteMin# = hForm.Data1.Recordset("tm_cortemin")
          ' Correlativo = 1hForm.Data1.Recordset("tm_correlativo")
                   
          ' If CO_GrabarCortesSQL(lRutCar, dNumdocu, iCorrela, dNominal, Correlativo, CorteMin#) = False Then
          '     GoTo CP_GrabarTxError
          ' End If
        End If
                            
        hForm.Data1.Recordset.MoveNext
    Loop
    
    If bExisteDPX Then
        Let dMontoOriginal = BacIrfGr.proMtoOper * dTipoCambio988
    Else
        Let dMontoOriginal = BacIrfGr.proMtoOper
    End If
                   
    
    Let Valor_antiguo = " "
    Let Valor_antiguo = "Operacion:" & dNumdocu & ";CP Ticket Intramesa"
    
    Call GRABA_LOG_AUDITORIA(1, gsBac_Fecp, gsBac_IP, gsBac_User, "BTR", "Opc_20100", "01", "Compra Ticket Intramesa", "mov_TicketRtaFija", Valor_antiguo, " ")

    Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Operación de compra ticket intramesa: " & dNumdocu & ", grabada con éxito.")
   
    TICKETCP_GrabarTx = dNumdocu
   
    Exit Function
        
        
CP_GrabarTxError:

    Call MsgBox("Se ha producido un problema en la grabación de la operación de intramesa: " & err.Description & ". Comunique al Administrador. ", vbCritical, gsBac_Version)
    Let TICKETCP_GrabarTx = 0
    Exit Function
    
End Function






Function TICKETVENTA_GrabarTx(dNumOperacion As Long, sTipoOperacion As String, dNumOperRelacion As Long, hForm As Form, Hwnd As Variant) As Boolean  '
'Public Function TICKETVENTA_GrabarTx(lRutCar&, iTipCar$, lForPagI&, sTipCus$, sRetiro$, sPagMan$, sObserv$, lRutCli&, nCodigo, hForm As Form, TCart$, Mercado$, Sucursal$, AreaResponsable$, Fecha_PagoMañana$, Laminas$, Tipo_Inversion$, Optional ByVal FechaSorteo As Variant, Optional ByVal FechaReal As String) As Double
On Error GoTo VPVI_GrabarTxError

Dim Datos()

Dim FlagTx              As Boolean

Dim iCorrela            As Integer
Dim iCorrVent           As Integer
Dim iMonemi             As Integer
Dim iBasemi             As Integer
Dim Resultado           As Integer
Dim iNumUCup            As Integer

Dim sMascara            As String
Dim sInstSer            As String
Dim sGenEmi             As String
Dim sNemMon             As String
Dim sFecEmi             As String
Dim sFecVen             As String
Dim sMdse               As String
Dim sSerie              As String
Dim clave_dcv           As String
Dim codcarterasuper     As String
Dim nombcarterasuper    As String
Dim CodLibro            As String
Dim sFecPro             As String

Dim dNominal            As Double
Dim dTir                As Double
Dim dPvp                As Double
Dim dVPar               As Double
Dim dVpTirV             As Double
Dim dVpTirV100          As Double
Dim dTasEst             As Double
Dim dNumdocu            As Double
Dim dTipoCambio988      As Double
Dim dMontoDolar988      As Double
Dim nTipoCambio         As Double
Dim dTasEmi             As Double
Dim dNumoper            As Double
Dim nValorCompraPM      As Double

Dim lCodigo             As Long
Dim Correlativo         As Long
Dim lRutemi             As Long






    dTipoCambio988 = FUNC_BUSCA_VALOR_MONEDA(998, Format(gsBac_Fecp, "DD/MM/YYYY"))
    FlagTx = False
                    
    hForm.Data2.RecordSource = "SELECT * FROM TICKET_VENTA WHERE tm_hwnd = " & Hwnd & " AND tm_diasdisp >= 1 AND ( tm_venta = " & Chr(34) & "V" & Chr(34) & " OR tm_venta = " & Chr(34) & "P" & Chr(34) & " )"
    hForm.Data2.Refresh
   
    iCorrela = 0
    iCorrVent = 1
    
    hForm.Data2.Recordset.MoveFirst
    
    Do While Not hForm.Data2.Recordset.EOF()
    
        If hForm.Data2.Recordset("tm_venta") = "P" Or hForm.Data2.Recordset("tm_venta") = "V" Then
        
            If Trim$(hForm.Data2.Recordset("tm_instser")) <> "" Then
            With hForm.Data2
               ' lRutCar = .Recordset("tm_rutcart")
                dNumdocu = .Recordset("tm_numdocu")
                iCorrela = .Recordset("tm_correla")
                sMascara = .Recordset("tm_mascara")
                sInstSer = .Recordset("tm_instser")
                sGenEmi = .Recordset("tm_genemi")
                sNemMon = .Recordset("tm_nemmon")
                dNominal = .Recordset("tm_nominal")
                dTir = .Recordset("tm_tir")
                dPvp = .Recordset("tm_pvp")
                dVPar = .Recordset("tm_vpar")
                dVpTirV = .Recordset("tm_vp")
                dVpTirV100 = .Recordset("tm_vp100")
                iNumUCup = .Recordset("tm_numucup")
                dTasEst = .Recordset("tm_tasest")
                sFecEmi = .Recordset("tm_fecemi")
                sFecVen = .Recordset("tm_fecven")
                lCodigo = .Recordset("tm_codigo")
                iMonemi = .Recordset("tm_monemi")
                lRutemi = .Recordset("tm_rutemi")
                dTasEmi = .Recordset("tm_tasemi")
                iBasemi = .Recordset("tm_basemi")
                sSerie = .Recordset("tm_serie")
                sTipCus = Mid$(.Recordset("tm_custodia"), 1, 1)
                clave_dcv = IIf(IsNull(.Recordset("tm_clave_dcv")), "", .Recordset("tm_clave_dcv"))
                codcarterasuper = IIf(IsNull(.Recordset("tm_carterasuper")), "T", .Recordset("tm_carterasuper"))
               ' iTipCar = .Recordset("tm_tipcart")
               ' CodLibro = Trim(.Recordset("tm_id_libro"))
                nValorCompraPM = .Recordset("tm_vptirc") '--> Agregado para Ventas PM
                nTipoCambio = 1
                nTipoCambio = funcBuscaTipcambio(.Recordset!tm_monemi, gsBac_Fecp)
            End With

            
                Envia = Array()
                AddParam Envia, dNumOperacion
                AddParam Envia, dNumdocu
                AddParam Envia, CDbl(iCorrela)
                AddParam Envia, sTipoOperacion
                AddParam Envia, dNumOperRelacion
                AddParam Envia, Format(gsBac_Fecp, "yyyymmdd")                                      '-> Fecha Operacion
                
                AddParam Envia, Trim(Right(hForm.CmbCarteraOrigen.Text, 5))                               '-> Código Cartera Origen
                AddParam Envia, Trim(Right(hForm.CmbMesaOrigenhForm.Text, 5)) 'CmbMesaOrigen.ItemData(hForm.CmbMesaOrigen.ListIndex)         '-> Código Mesa Origen
                AddParam Envia, Trim(Right(hForm.CmbCarteraDestino.Text, 5))                              '-> Código Cartera Destino
                AddParam Envia, Trim(Right(hForm.CmbMesaDestino.Text, 5)) 'hForm.CmbMesaDestino.ItemData(hForm.CmbMesaDestino.ListIndex)       '-> Código Mesa Destino
                
                AddParam Envia, dNominal
                AddParam Envia, dTir
                AddParam Envia, dPvp
                AddParam Envia, dVPar
                AddParam Envia, dVpTirV
                AddParam Envia, CDbl(iNumUCup)
                AddParam Envia, Format$(gsBac_Fecp, "yyyymmdd")
                AddParam Envia, dTasEst
                AddParam Envia, iMonemi
                AddParam Envia, lRutemi
                AddParam Envia, dTasEmi
                AddParam Envia, CDbl(iBasemi)
                AddParam Envia, gsBac_User
                AddParam Envia, gsTerminal
                AddParam Envia, sMascara
                AddParam Envia, sInstSer
                AddParam Envia, sGenEmi
                AddParam Envia, sNemMon
                AddParam Envia, Format(sFecEmi, "yyyymmdd")
                AddParam Envia, Format(sFecVen, "yyyymmdd")
                AddParam Envia, CDbl(lCodigo)
                AddParam Envia, CDbl(iCorrVent)
                AddParam Envia, Format(hForm.FechaPago.Text, feFECHA)
                AddParam Envia, nValorCompraPM                                                          '--> Agregado para Ventas PM
                
                If Not Bac_Sql_Execute("DBO.SP_GRABAOPERACION_TICKETINTRAMESA_VENTAS", Envia) Then
                    GoTo VPVI_GrabarTxError
                End If
                                                              
                Correlativo = hForm.Data2.Recordset("tm_correlao")
              
              ' If VPVI_GrabarCortesSQL(lRutCar, dNumdocu, iCorrela, dNumoper, Correlativo) = False Then
              '     GoTo VPVI_GrabarTxError
              ' End If
          
            End If
        End If
      
        iCorrVent% = iCorrVent% + 1
        hForm.Data2.Recordset.MoveNext
    
    Loop
    
    
    Valor_antiguo = " "
    Valor_antiguo = "Operacion Intramesa:" & dNumoper & ";VP;"
    
    Call GRABA_LOG_AUDITORIA(1, gsBac_Fecp, gsBac_IP, gsBac_User, "BTR", "Opc_20200", "01", "Venta Definitiva Intramesa", "tbl_mov, tbl_car ", Valor_antiguo, " ")
    
                
    TICKETVENTA_GrabarTx = dNumoper
                               
    Screen.MousePointer = vbDefault
    Exit Function
    
    
VPVI_GrabarTxError:

    MsgBox "No se pudo completar la grabación de operación de Ventas definitivas: " & err.Description, vbExclamation, gsBac_Version

   
   TICKETVENTA_GrabarTx = 0
   
End Function


Public Sub TICKETCP_IniciarTx(Hwnd As Long, Data1 As Control)
   On Error Resume Next
    ' Asegurarse no tener registros con el handler.-
    Call TICKETCP_BorrarTx(Hwnd)
    
    ' Activar filtro para la CP.-
    Data1.DatabaseName = gsMDB_Path & gsMDB_Database
    Data1.RecordsetType = 1
    Data1.RecordSource = "SELECT * FROM TICKET_COMPRA WHERE tm_hwnd = " & Hwnd
    If Data1.Recordset.RecordCount > 0 Then
      Data1.Refresh
    End If
    
    ' Agrega imediatamente un registro.-
    Call TICKETCP_Agregar(Hwnd, Data1)
       
End Sub



Private Sub TICKETCP_Limpiar(Data1 As Control)

    Data1.Recordset("tm_instser") = ""
    Data1.Recordset("tm_genemi") = " "
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
    Data1.Recordset("tm_codemi") = 0#
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
    Data1.Recordset("tm_fecpcup") = ""
    Data1.Recordset("tm_clave_dcv") = ""
    Data1.Recordset("tm_custodia") = ""
    Data1.Recordset("tm_carterasuper") = "T"
    
End Sub





Public Function TICKETCP_SumarTotal(Hwnd As Long) As Double
Dim rs As Recordset
Dim Sql As String
Dim Datos()

    Sql = "SELECT SUM(tm_mt) As Total FROM TICKET_compra WHERE tm_hwnd = " & Hwnd
    
    Set rs = db.OpenRecordset(Sql, dbOpenSnapshot)
    
    If rs.RecordCount > 0 Then
        TICKETCP_SumarTotal = rs.Fields("Total")
        If gsBac_Valmon <> 0 Then
            TICKETCP_SumarTotal = TICKETCP_SumarTotal / gsBac_Valmon
        Else
            TICKETCP_SumarTotal = TICKETCP_SumarTotal
        End If
    Else
        TICKETCP_SumarTotal = 0
    End If
    
End Function


