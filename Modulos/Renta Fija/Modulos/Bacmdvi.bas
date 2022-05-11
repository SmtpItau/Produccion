Attribute VB_Name = "modMDVI"
Option Explicit
''++GRC Req007
Global TipoCarga        As String
Global ValVenta         As Boolean
Global TipoCarga_RP     As String
Global ValVenta_RP      As Boolean
Global Correlativo_SOMA As String
Global NumOper_SOMA     As String
Global Correlativo_SOMA_RP As String
Global NumOper_SOMA_RP     As String
''--GRC Req007


Public Function DesloquearPapeles_SorteoLetras(Hwnd As Long, Data1 As Control, Optional ByVal dFechaSorteo As Variant) As Boolean
   Dim Datos()
    
   DesloquearPapeles_SorteoLetras = False
    
   Envia = Array()
   AddParam Envia, CDbl(Data1.Recordset("tm_rutcart"))
   AddParam Envia, CDbl(Data1.Recordset("tm_numdocu"))
   AddParam Envia, CDbl(Data1.Recordset("tm_correla"))
   AddParam Envia, CDbl(Hwnd)
   AddParam Envia, gsBac_User ' "ST_" & Format(dFechaSorteo, "YYYYMMDD")
   If Bac_Sql_Execute("SP_DESBLOQUEARINST", Envia) Then
      Do While Bac_SQL_Fetch(Datos())
         If Datos(1) = "SI" Then
            DesloquearPapeles_SorteoLetras = True
         Else
            Beep
            MsgBox "Instrumento no pudo desbloquearse", vbCritical, gsBac_Version 'insertado 06/02/2001
         End If
      Loop
   End If
    
End Function

Public Function BloquearPapeles_SorteoLetras(Hwnd As Long, Data1 As Control, Optional ByVal dFechaSorteo As Variant) As Boolean
Dim Datos()
    
    BloquearPapeles_SorteoLetras = False
    
    Envia = Array()
    AddParam Envia, CDbl(Data1.Recordset("tm_rutcart"))
    AddParam Envia, CDbl(Data1.Recordset("tm_numdocu"))
    AddParam Envia, CDbl(Data1.Recordset("tm_correla"))
    AddParam Envia, CDbl(Data1.Recordset("tm_nominalo"))
    AddParam Envia, CDbl(Hwnd)
    AddParam Envia, gsBac_User ' "ST_" & Format(dFechaSorteo, "YYYYMMDD")
    If Bac_Sql_Execute("SP_BLOQUEARVP", Envia) Then
        Do While Bac_SQL_Fetch(Datos())
            If Datos(1) = "SI" Then
                BloquearPapeles_SorteoLetras = True
            Else
               Select Case Datos(4)
               Case "3"
                 MsgBox "Instrumento está marcado por " & Datos(2) & ".", vbInformation, gsBac_Version
               Case Else
                 MsgBox "Instrumento está seleccionado en otra ventana", vbInformation, gsBac_Version
               End Select
            End If
        Loop
    End If
    
End Function

Public Function Llena_Grilla()

'    Data1.Recordset("tm_serie") = Datos(11)
'    Data1.Recordset("tm_instser") = Datos(12)
'    Data1.Recordset("tm_genemi") = Datos(13)
'    Data1.Recordset("tm_nemmon") = Datos(14)
'    Data1.Recordset("tm_nominal") = Val(Datos(15))
'    Data1.Recordset("tm_nominalo") = Val(Datos(15))
'    Data1.Recordset("tm_tir") = Val(Datos(16))
'    Data1.Recordset("tm_pvp") = Val(Datos(17))
'    Data1.Recordset("tm_vpar") = 0#
'    Data1.Recordset("tm_vp") = Val(Datos(18))
'    Data1.Recordset("tm_vp100") = 0#
'    Data1.Recordset("tm_tircomp") = Val(Datos(16))
'    Data1.Recordset("tm_pvpcomp") = Val(Datos(17))
'    Data1.Recordset("tm_vptirc") = Val(Datos(18))
'    Data1.Recordset("tm_pvpmcd") = Val(Datos(19))
'    Data1.Recordset("tm_tirmcd") = Val(Datos(20))
'    Data1.Recordset("tm_vpmcd100") = Val(Datos(21))
'    Data1.Recordset("tm_vpmcd") = Val(Datos(22))
'    Data1.Recordset("tm_vptirci") = Val(Datos(23))
'    Data1.Recordset("tm_fecsal") = Datos(24)
'    Data1.Recordset("tm_numucup") = Val(Datos(25))
'    Data1.Recordset("tm_interesc") = Val(Datos(26))
'    Data1.Recordset("tm_reajustc") = Val(Datos(27))
'    Data1.Recordset("tm_intereci") = Val(Datos(28))
'    Data1.Recordset("tm_reajusci") = Val(Datos(29))
'    Data1.Recordset("tm_capitalc") = Val(Datos(30))
'    Data1.Recordset("tm_capitaci") = Val(Datos(31))
'    Data1.Recordset("tm_mtml") = 0#
'    Data1.Recordset("tm_tcml") = 0#
'
'  ' Datos necesarios para la valorización
'    Data1.Recordset("tm_codigo") = Val(Datos(32))
'    Data1.Recordset("tm_mascara") = Datos(33)
'    Data1.Recordset("tm_tasest") = Val(Datos(34))
'
'  ' Datos de Emision
'    Data1.Recordset("tm_rutemi") = Val(Datos(35))
'    Data1.Recordset("tm_monemi") = Val(Datos(36))
'    Data1.Recordset("tm_tasemi") = Val(Datos(37))
'    Data1.Recordset("tm_basemi") = Val(Datos(38))
'    Data1.Recordset("tm_fecemi") = Datos(39)
'    Data1.Recordset("tm_fecven") = Datos(40)
'    Data1.Recordset("tm_fecpcup") = Datos(41)
'
'    If Datos(42) = "" Then
'        Data1.Recordset("tm_venta") = " "
'    Else
'        Data1.Recordset("tm_venta") = Datos(42)
'    End If
'
'    Data1.Recordset("tm_diasdisp") = Datos(43)
'
'    Select Case Trim(Datos(44))
'           Case "C"
'                Data1.Recordset("tm_custodia") = "CLIENTE"
'                Data1.Recordset("tm_custoori") = "CLIENTE"
'           Case "D"
'                Data1.Recordset("tm_custodia") = "DCV"
'                Data1.Recordset("tm_custoori") = "DCV"
'           Case Else
'                Data1.Recordset("tm_custodia") = "PROPIA"
'                Data1.Recordset("tm_custoori") = "PROPIA"
'    End Select
'
'    Data1.Recordset("tm_mdse") = Datos(45)
'
'  ' VB+- 27/06/2000 se agrega estos campos para el control de limites PFE y CCE
'  ' ===========================================================================
'    Data1.Recordset("tm_convex") = Datos(46)
'    Data1.Recordset("tm_duratmac") = Datos(47)
'    Data1.Recordset("tm_duratmod") = Datos(48)
'  ' Datos de respaldo
'    Data1.Recordset("tm_convexori") = Datos(46)
'    Data1.Recordset("tm_durmacori") = Datos(47)
'    Data1.Recordset("tm_durmodori") = Datos(48)
End Function
Public Function VI_ValorFinal(ValIni#, Tasa#, Plazo&, Base%) As Double
    
    VI_ValorFinal = ValIni * (((Tasa / (Base * 100#)) * Plazo) + 1)
    If Base = 30 Then
        VI_ValorFinal = Format(VI_ValorFinal, "##,###,###,###,##0")
 
    End If
End Function

Public Function VENTA_SumarTotal(Hwnd As Long) As Double
Dim rs As Recordset
Dim Sql As String
Dim nTotal As Double
    
VENTA_SumarTotal = 0
nTotal = 0
Sql = "SELECT tm_monemi As Moneda,tm_vp As Monto FROM mdventa WHERE ( tm_venta = 'V' OR tm_venta = 'P' ) AND tm_hwnd = " & Hwnd
Set rs = db.OpenRecordset(Sql, dbOpenSnapshot)
If rs.RecordCount <= 0 Then Exit Function
rs.MoveFirst
Do While Not rs.EOF
   nTotal = nTotal + IIf(rs.Fields("Moneda") = 13, Round(rs.Fields("Monto") * gsBac_TCambio, 0), rs.Fields("Monto"))
   rs.MoveNext
Loop
VENTA_SumarTotal = nTotal
    
    
'    Sql = "SELECT SUM(tm_vp) As Total FROM mdventa WHERE ( tm_venta = 'V' OR tm_venta = 'P' ) AND tm_hwnd = " & hWnd
'    Set rs = db.OpenRecordset(Sql, dbOpenSnapshot)
'
'    If rs.RecordCount > 0 Then
'        If Not IsNull(rs.Fields("Total")) Then
'            VENTA_SumarTotal = CDbl(rs.Fields("Total"))
'        End If
'    End If
    
End Function

Public Sub VENTA_Valorizar(ModCal%, Data1 As Control, Optional ByVal dFechaSorteo As String, Optional cTipo As String)
   
   On Error GoTo CP_ValorizarError
   Dim Ent As BacValorizaInput
   Dim Sal As BacValorizaOutput
    
   Screen.MousePointer = vbHourglass
   
    With Ent
        .ModCal = ModCal%
        If dFechaSorteo = "" Then
           .FecCal = Format(gsBac_Fecp, "dd/mm/yyyy")
        Else
           .FecCal = dFechaSorteo
        End If
        
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
      If Data1.Recordset!tm_codigo <> 98 Then
      End If
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
            Data1.Recordset("tm_vptirc") = Data1.Recordset("tm_vptirc") * (Sal.Nominal / IIf(Data1.Recordset("tm_nominalo") = 0, 1, Data1.Recordset("tm_nominalo")))  ' PRD-6005
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
        '++GRC Req07
        Data1.Recordset!TM_VALINICIAL = Round(Data1.Recordset!TM_MARGEN * Data1.Recordset!TM_VP, 0)
        '--GRC Req07
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
        MsgBox Error(err), vbCritical, gsBac_Version
    End If
  
    Exit Sub
End Sub


Public Sub VENTA_ValorizarTotal(Data1 As Control, dTotalNuevo#, dTotalActual#, Optional ByVal dFechaSorteo As String)
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
        MsgBox Error(err), vbCritical, gsBac_Version
    Else
        MsgBox "Problema en proceso de valorización de operación de venta: " & err.Description & ". Comunique al Administrador. ", vbCritical, gsBac_Version
    End If
    
    Screen.MousePointer = 0
    WS.Rollback
    Data1.Refresh

    Exit Sub
    
End Sub
Public Function VENTA_VerBloqueo(Hwnd As Long, Data1 As Control)
Dim Datos()
    
    VENTA_VerBloqueo = True

    Envia = Array(CDbl(Data1.Recordset("tm_rutcart")), _
            CDbl(Data1.Recordset("tm_numdocu")), _
            CDbl(Data1.Recordset("tm_correla")), _
            CDbl(Data1.Recordset("tm_nominalo")), _
            CDbl(Hwnd), _
            gsBac_User)
            
    If Bac_Sql_Execute("SP_VERBLOQUEO", Envia) Then
        Do While Bac_SQL_Fetch(Datos())
            If Datos(1) = "SI" Then
                VENTA_VerBloqueo = False
            End If
        Loop
    End If
       
End Function
Public Function VENTA_VerDispon(Hwnd As Long, Data1 As Control)
Dim Datos()
On Error GoTo ErrVenta
    
    VENTA_VerDispon = False
    ''++GRC Req007
    ValVenta_RP = False
    ''--GRC Req007
    
    Envia = Array(CDbl(Data1.Recordset!tm_rutcart), _
            CDbl(Data1.Recordset!Tm_numdocu), _
            CDbl(Data1.Recordset!tm_correla), _
            CDbl(Data1.Recordset!tm_nominalo), _
            CDbl(Hwnd), _
            gsBac_User)
            
    If Bac_Sql_Execute("SP_VERDISPON", Envia) Then
        Do While Bac_SQL_Fetch(Datos())
            
            If Datos(1) = "SI" Then
                
                VENTA_VerDispon = True
                ''++GRC Req007
                ValVenta_RP = True
                ''--GRC Req007
            
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

Public Function VENTA_VerDisponBloqueoPactoVI(Hwnd As Long, Data1 As Control)
''PRD-6005
Dim Datos()
On Error GoTo ErrVenta
    
    VENTA_VerDisponBloqueoPactoVI = False
    ''++GRC Req007
    ValVenta_RP = False
    ''--GRC Req007
    
            
    Envia = Array(CDbl(Data1.Recordset!tm_rutcart), _
            CDbl(Data1.Recordset!Tm_numdocu), _
            CDbl(Data1.Recordset!tm_correla), _
            CDbl(Data1.Recordset!tm_nominalo), _
            CDbl(Hwnd), _
            gsBac_User)
            
    If Bac_Sql_Execute("dbo.SP_VERDISPON_VI_BLOQPACTO_6005", Envia) Then   '6005
    
    Do While Bac_SQL_Fetch(Datos())
            
            If Datos(1) = "SI" Then
                
                VENTA_VerDisponBloqueoPactoVI = True
                ''++GRC Req007
                ValVenta_RP = True
                ''--GRC Req007
            
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

''PRD-6005
End Function



Public Function VENTA_SumarCartera(Hwnd As Long, txtplazo As String, CmdTipoFiltro As Control) As Double
   Dim Datos()
   Dim rs As Recordset
   Dim Sql As String
   Dim nTotal As Double

   VENTA_SumarCartera = 0
   
   nTotal = 0
   
'   If CmdTipoFiltro.Buttons(6).Tag = "Ver Sel." Then
'       Sql = "SELECT tm_monemi As Moneda, tm_vptirc As Monto FROM mdventa WHERE tm_hwnd = " & Hwnd & " AND tm_diasdisp >= " & txtplazo
'   Else
'       Sql = "SELECT tm_monemi As Moneda, tm_vptirc As Monto FROM mdventa WHERE ( tm_venta = 'V' OR tm_venta = 'P' ) AND tm_hwnd = " & Hwnd & " AND tm_diasdisp >= " & txtplazo
'   End If

   If CmdTipoFiltro.Buttons(6).Tag = "Ver Sel." Then
       Sql = "SELECT Moneda , Valor_Presente As Monto FROM DETALLE_VTAS_CON_PCTO WHERE ventana = " & Hwnd & " AND Plazo >= " & txtplazo
   Else
       Sql = "SELECT Moneda , Valor_Presente As Monto FROM DETALLE_VTAS_CON_PCTO WHERE marca = 'S' AND ventana = " & Hwnd & " AND Plazo >= " & txtplazo
   End If

   If Not Bac_Sql_Execute(Sql) Then
      Let Screen.MousePointer = vbDefault
      Call MsgBox("Se ha producido un error al tratar de tomar el registro.", vbExclamation, App.Title)
      Exit Function
   End If
      
   Do While Bac_SQL_Fetch(Datos())
         nTotal = nTotal + IIf(Datos(1) = 13, Round(Datos(2) * gsBac_TCambio, 0), Datos(2))
    Loop
   
'   Set rs = db.OpenRecordset(Sql, dbOpenSnapshot)
'   If rs.RecordCount <= 0 Then Exit Function
'   rs.MoveFirst
'   Do While Not rs.EOF
'       nTotal = nTotal + IIf(rs.Fields("Moneda") = 13, Round(rs.Fields("Monto") * gsBac_TCambio, 0), rs.Fields("Monto"))
'       rs.MoveNext
'   Loop
   
   VENTA_SumarCartera = nTotal
   
End Function


Public Function VENTA_SumarDif(Hwnd As Long) As Double
Dim rs As Recordset
Dim Sql As String

   VENTA_SumarDif = 0
   Sql = "SELECT SUM(tm_vp - tm_vptirc) As Total FROM mdventa WHERE ( tm_venta = 'V' OR tm_venta = 'P' ) AND tm_hwnd = " & Hwnd
   Set rs = db.OpenRecordset(Sql, dbOpenSnapshot)
    
   If rs.RecordCount > 0 Then
      If Not IsNull(rs.Fields("Total")) Then
         VENTA_SumarDif = rs.Fields("Total")
      End If
   End If

End Function


Public Sub VENTA_Agregar(Data1 As Control, Datos(), Hwnd, TipVen$, Optional ByVal TipOp As String)
   
    If IsMissing(TipOp) Then
        TipOp = ""
    End If
   
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
   '++GRC Req007
    If TipOp = "RP" Then
        Data1.Recordset("tm_margen") = Datos(52)
        Data1.Recordset("tm_valinicial") = Datos(53)
    End If
   '--GRC Req007
   
   'PRD-6005
   If TipVen$ = "VI" Then
      Data1.Recordset("tm_NominalBloqPact") = CDbl(Datos(52)) 'MAP PROD-6005
    End If
   'PRD-6005
   
   
   '-> Correccion aplicada para la Venta Definitiva y la Venta Automática.- 30-05-2013
    Data1.Recordset("TM_TIR_TRAN") = CDbl(Datos(16))    '-> Tir
    Data1.Recordset("TM_Pvp_TRAN") = CDbl(Datos(17))    '-> Pvp
    Data1.Recordset("tm_vp_TRAN") = CDbl(Datos(18))     '-> vp
    '-> Correccion aplicada para la Venta Definitiva y la Venta Automática.- 30-05-2013
   
   Data1.Recordset.Update
   
End Sub

Public Function VENTA_Bloquear(Hwnd As Long, Data1 As Control)
Dim Datos()
    
    VENTA_Bloquear = False
    ''++GRC Req007
    ValVenta_RP = False
    ''--GRC Req007
    
    Envia = Array()
    AddParam Envia, CDbl(Data1.Recordset("tm_rutcart"))
    AddParam Envia, CDbl(Data1.Recordset("tm_numdocu"))
    AddParam Envia, CDbl(Data1.Recordset("tm_correla"))
    AddParam Envia, CDbl(Data1.Recordset("tm_nominalo"))
    AddParam Envia, CDbl(Hwnd)
    AddParam Envia, gsBac_User

    If Bac_Sql_Execute("SP_BLOQUEARVP", Envia) Then
        Do While Bac_SQL_Fetch(Datos())
            If Datos(1) = "SI" Then
                VENTA_Bloquear = True
                ''++GRC Req007
                ValVenta_RP = True
                ''--GRC Req007
            Else
               Select Case Datos(4)
               Case "3"
                 MsgBox "Instrumento está marcado por " & Datos(2) & ".", vbInformation, gsBac_Version

               Case Else
                 If Tipo_Carga <> "AU" Then
                 MsgBox "Instrumento está seleccionado en otra ventana", vbInformation, gsBac_Version
                 End If
               End Select
            End If
        Loop
    End If
   
End Function
Public Sub VENTA_BorrarTx(Hwnd As Long)
                       
    db.Execute "DELETE * FROM mdventa WHERE tm_hwnd = " & Hwnd
    db.Execute "DELETE * FROM mdco WHERE tm_hwnd = " & Hwnd
    
End Sub
Public Function VENTA_DesBloquear(Hwnd As Long, Data1 As Control)
Dim Datos()
    
    VENTA_DesBloquear = False
    
    Envia = Array(CDbl(Data1.Recordset("tm_rutcart")), _
            CDbl(Data1.Recordset("tm_numdocu")), _
            CDbl(Data1.Recordset("tm_correla")), _
            CDbl(Hwnd), _
            gsBac_User)
            
    If Bac_Sql_Execute("SP_DESBLOQUEARINST", Envia) Then
        Do While Bac_SQL_Fetch(Datos())
            If Datos(1) = "SI" Then
                VENTA_DesBloquear = True
            Else
               Beep
               MsgBox "Instrumento no pudo desbloquearse", vbCritical, gsBac_Version 'insertado 06/02/2001
            End If
        Loop
    End If
    
End Function

'Elimina todos los registro bloqueados que estan en la MDB
'de la tabla de bloqueados del servidor
Public Sub VENTA_EliminarBloqueados(Data1 As Control, FormHandle&)

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
Public Sub VENTA_IniciarTx(Hwnd As Long, Data1 As Control, Dias As Double)

    Call VENTA_BorrarTx(Hwnd)
    
    Data1.DatabaseName = gsMDB_Path & gsMDB_Database
    Data1.RecordSource = "SELECT * FROM mdventa WHERE tm_hwnd = " & Hwnd & " AND tm_diasdisp >= " & Dias
    Data1.Refresh
    
End Sub
Public Sub VENTA_Restaurar(Data1 As Control, Optional ByVal Repos As String)
Dim Rutcart&, NumDocu#, Correla%, FormHandle&
Dim Correlativo&


    If IsMissing(Repos) Then
        Repos = ""
    End If
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
    
    If Repos = "RP" Then
        Data1.Recordset("tm_valinicial") = Data1.Recordset("tm_margen") * Data1.Recordset("tm_vp")
    End If
    
    Data1.Recordset.Update
    
End Sub
