Attribute VB_Name = "modMDCPCI"
Option Explicit

Type BacTypeChkSerie
    nError  As Integer
    cMascara    As String
    nCodigo     As Long
    nSerie      As String
    sFamilia    As String    'FLI
    nRutemi     As Long
    nMonemi     As Integer
    fTasemi     As Double
    fBasemi     As Integer
    dFecemi     As String
    dFecven     As String
    cRefnomi    As String
    cGenemi     As String
    cNemmon     As String
    nCorMin     As Double
    cSeriado    As String
    cLeeEmi     As String
End Type

'CONSTANTES DE GRILLA TABLE1 DE OPERACIONES COMPRA PROPIA
Global Const nCol_SERIE = 0
Global Const nCol_UM = 1
Global Const nCol_NOMINAL = 2
Global Const nCol_TIR = 3
Global Const nCol_VPAR = 4
Global Const nCol_VPS = 5
Global Const nCol_CUST = 6
Global Const nCol_CDCV = 7
Global Const nCol_TTRAN = 8
Global Const nCol_PTRAN = 9
Global Const nCol_VPTRAN = 10
Global Const nCol_UTIL = 11
Global Const nCol_DifTran_CLP = 12
Global Const nCol_TCSP = 13
Global Const nCol_CORR = 14 'cass


' Constantes correspondientes a las columnas de operaciones
Global Const com_SERIE = 0
Global Const com_UM = 1
Global Const com_NOMINAL = 2
Global Const com_TIR = 3
Global Const com_VPAR = 4
Global Const com_VPS = 5
Global Const com_CUST = 6
Global Const com_CDCV = 7
Global Const com_TIRM = 8
Global Const com_VPARM = 9
Global Const com_VPSM = 10
Global Const com_UTIL = 11
Global Const com_TCSP = 12

' variables para limites
Global iCodExcesoSETTLE   As Integer
Global dMtoExcesoSETTLE   As Double
'  Corresponden al control de PFE
Global iCodExcesoPFEcce   As Integer
Global dMtoExcesoPFEcce   As Double
' Corresponde al control de CCE
Global iCodExcesopfeCCE_1 As Integer
Global dMtoExcesopfeCCE_1 As Double

Global iCodexcesoIB       As Integer
Global dMtoExcesoIB       As Double
Global iPlazoSETLLEMENT   As Integer

Public Function CPCI_ChkTipoCambio(FormHandle&, TipOpe$) As Boolean

'Selecciona todos los registros que tengan tipo de cambio igual a cero,
'segun el tipo de operacion (CP,CI)

'Dim rs As Recordset
'Dim Sql$

    'If TipOpe = "CP" Then
    '    SQL = "SELECT * FROM mdcp WHERE tm_tcml = 0 AND tm_hwnd = " & FormHandle&
    'ElseIf TipOpe = "CI" Then
    '    SQL = "SELECT * FROM mdcp WHERE tm_tcml = 0 AND tm_hwnd = " & FormHandle&
    'Else
    '    CPCI_ChkTipoCambio = False
    '    Exit Function
    'End If

    'Set rs = DB.OpenRecordset(SQL, dbOpenSnapshot)
    
    'If rs.RecordCount > 0 Then
    '    CPCI_ChkTipoCambio = False
    'Else
    '    CPCI_ChkTipoCambio = True
    'End If

End Function

Public Sub CPCI_ValorizarTotal(Data1 As Control, dTotalNuevo#, dTotalActual#)

On Error GoTo BacErrorHandler

Dim Sql$

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
    
    'Factor de cambio
    If dTotalActual = 0 Then Exit Sub
    dFactor# = dTotalNuevo# / dTotalActual#
    
    'Empieza una transacción local (MDB)
    WS.BeginTrans
    
'    nRecord& = Data1.Recordset.AbsolutePosition
    Data1.Recordset.MoveFirst
    lNumReg& = Data1.Recordset.RecordCount
    lContador& = 0#
    dTotalAcum# = 0#
    
    Do While Not Data1.Recordset.EOF

        lContador& = lContador& + 1
        With Ent
            .ModCal = ModCal%
            .FecCal = Format$(gsBac_Fecp, "yyyymmdd")
            .Codigo = Data1.Recordset("tm_codigo")
            .Mascara = Data1.Recordset("tm_mascara")
            .Nominal = Data1.Recordset("tm_nominal")
            .tir = Data1.Recordset("tm_tir")
            .Pvp = Data1.Recordset("tm_pvp")
            .Mt = Data1.Recordset("tm_mt")
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
            Ent.Mt# = Data1.Recordset("tm_mt") * dFactor#
            MtMl# = Data1.Recordset("tm_mtml") * dFactor#
            MtMl# = Format(MtMl#, IIf(Data1.Recordset("tm_monemi") = 13, "00000000000000.00", "00000000000000000"))
            Ent.Mt# = Format(Ent.Mt#, IIf(Data1.Recordset("tm_monemi") = 13, "00000000000000.00", "00000000000000000"))
            dTotalAcum# = dTotalAcum# + IIf(Data1.Recordset("tm_monemi") = 13, Round(Ent.Mt# * gsBac_TCambio, 0), Ent.Mt#)
        End If
               
        If BacValorizar(Ent, Sal) = True Then
            Data1.Recordset.Edit
            Data1.Recordset("tm_nominal") = Sal.Nominal
            Data1.Recordset("tm_tir") = Sal.tir
            Data1.Recordset("tm_pvp") = Sal.Pvp
            Data1.Recordset("tm_vpar") = Sal.Vpar
            Data1.Recordset("tm_mt") = Sal.Mt
            Data1.Recordset("tm_mt100") = Sal.Mt100
            Data1.Recordset("tm_mtml") = MtMl#
            Data1.Recordset("tm_numucup") = Sal.Numucup
            Data1.Recordset("tm_fecpcup") = Sal.Fecpcup
            Data1.Recordset.Update
            'dTotalAcum# = dTotalAcum# - data1.Recordset("tm_mtml")
        Else
            GoTo BacErrorHandler
        End If
        
        Data1.Recordset.MoveNext

    Loop
'    If nRecord& >= 0 Then
'     Data1.Recordset.AbsolutePosition = nRecord&
'    End If
    Screen.MousePointer = vbDefault
    
    'Compromete los cambios
    WS.CommitTrans
    
    Exit Sub
    
BacErrorHandler:
    If err <> 0 Then
        MsgBox error(err), vbCritical, gsBac_Version
    Else
        MsgBox "Problema en proceso de valorización de operación: " & err.Description & ". Comunique al Administrador. ", vbCritical, gsBac_Version

    End If
    
    Screen.MousePointer = 0
    WS.Rollback
    Data1.Refresh
    Exit Sub
    
End Sub
Public Sub CPCI_ValorizarMcd(Data1 As Control, NominalOld#, dEmisor As Double)

Dim Sql$

'Datos de Input
Dim Ent As BacValorizaInput

'Datos de Output
Dim Sal As BacValorizaOutput

'    If data1.Recordset("tm_valmcd") = "N" Then
        
        With Ent
            .ModCal = 2
            .FecCal = Format$(gsBac_Fecp, "yyyymmdd")
            .Codigo = Data1.Recordset("tm_codigo")
            .Mascara = Data1.Recordset("tm_mascara")
            .Nominal = Data1.Recordset("tm_nominal")
            .tir = Data1.Recordset("tm_tirmcd")
            .Pvp = Data1.Recordset("tm_pvpmcd")
            .Mt = Data1.Recordset("tm_mtmcd")
            .TasEst = Data1.Recordset("tm_tasest")
            .MonEmi = Data1.Recordset("tm_monemi")
            .fecemi = Data1.Recordset("tm_fecemi")
            .FecVen = Data1.Recordset("tm_fecven")
            .TasEmi = Data1.Recordset("tm_tasemi")
            .BasEmi = Data1.Recordset("tm_basemi")
        End With
        Ent.tir = CPCI_LeerTasaMcd(Ent.Codigo, Ent.FecVen, dEmisor)
        
        If BacValorizar(Ent, Sal) = True Then
            Data1.Recordset.Edit
            Data1.Recordset("tm_tirmcd") = Sal.tir
            Data1.Recordset("tm_pvpmcd") = Sal.Pvp
            Data1.Recordset("tm_mtmcd") = Sal.Mt
            Data1.Recordset("tm_mtmcd100") = Sal.Mt100
            Data1.Recordset("tm_valmcd") = "S"
          ' Grabo datos para calcular limites PFE y CCE
          ' -------------------------------------------------
            Data1.Recordset("tm_durationmac") = Sal.duratmac
            Data1.Recordset("tm_durationmod") = Sal.duratmod
            Data1.Recordset("tm_convexidad") = Sal.convexid
          ' -------------------------------------------------
            Data1.Recordset.Update
        End If
 '   Else
  '      'REGLA DE TRES PARA CALCULAR EL Mt
  '      If NominalOld# <> 0 Then
  '          data1.Recordset.Edit
  '          data1.Recordset("tm_mtmcd") = data1.Recordset("tm_nominal") * data1.Recordset("tm_mtmcd100") / NominalOld#
  ''          data1.Recordset.Update
  '      End If
  '  End If

End Sub

Public Sub CPCI_Valorizar(ModCal%, Data1 As Control, dFechaCalculo As Date, Optional cTipo As String)
   
   On Error GoTo BacErrorHandler
   
   Dim Sql$
   Dim nEmisor As Double
   Dim Ent     As BacValorizaInput  '-->   'Datos de Input
   Dim Sal     As BacValorizaOutput '-->   'Datos de Output

   Let Screen.MousePointer = vbHourglass
   
   With Ent
      .ModCal = ModCal%
      .FecCal = Format(dFechaCalculo, "yyyymmdd")  '--> Format$(gsBac_Fecp, "yyyymmdd")
      
      .Codigo = Data1.Recordset("tm_codigo")
      .Mascara = Data1.Recordset("tm_instser")
      .Nominal = Data1.Recordset("tm_nominal")
      
      If cTipo = "" Then
        .tir = IIf(IsNull(Data1.Recordset("tm_tir")), 0, Data1.Recordset("tm_tir"))
        .Pvp = IIf(IsNull(Data1.Recordset("tm_pvp")), 0, Data1.Recordset("tm_pvp"))
        .Mt = IIf(IsNull(Data1.Recordset("tm_mt")), 0, Data1.Recordset("tm_mt"))
      Else
        'Se reutilizan variables para valorizar a VALORES DE TRANSACCION
        .tir = IIf(IsNull(Data1.Recordset("tm_tirMCD")), 0, Data1.Recordset("tm_tirMCD"))
        .Pvp = IIf(IsNull(Data1.Recordset("tm_pvpMCD")), 0, Data1.Recordset("tm_pvpMCD"))
        .Mt = IIf(IsNull(Data1.Recordset("tm_mtMCD")), 0, Data1.Recordset("tm_mtMCD"))
      End If
      
      .TasEst = Data1.Recordset("tm_tasest")
      .MonEmi = Data1.Recordset("tm_monemi")
      .fecemi = Format(Data1.Recordset("tm_fecemi"), "yyyymmdd")
      .FecVen = Format(Data1.Recordset("tm_fecven"), "yyyymmdd")
      .TasEmi = Data1.Recordset("tm_tasemi")
      .BasEmi = Data1.Recordset("tm_basemi")
      nEmisor = Data1.Recordset("tm_rutemi")
   End With
    
   If BacValorizar(Ent, Sal) = True Then
      Data1.Recordset.Edit
      Data1.Recordset("tm_nominal") = Sal.Nominal
      
      If cTipo = "" Then
         Data1.Recordset("tm_tir") = Format(Sal.tir, "###0.0000")
         Data1.Recordset("tm_pvp") = Format(Sal.Pvp, "###0.0000")
         Data1.Recordset("tm_vpar") = Format(Sal.Vpar, "###0.0000")
         Data1.Recordset("tm_mt") = Sal.Mt
         Data1.Recordset("tm_VPMo") = Sal.MtUM
      Else
         Data1.Recordset("tm_tirmcd") = Format(Sal.tir, "###0.0000")
         Data1.Recordset("tm_pvpmcd") = Format(Sal.Pvp, "###0.0000")
         Data1.Recordset("tm_mtmcd") = Sal.Mt
         Data1.Recordset("tm_VpTranMo") = Sal.MtUM
      End If
           
      Data1.Recordset("tm_mt100") = Sal.Mt100
      Data1.Recordset("tm_numucup") = Sal.Numucup
      Data1.Recordset("tm_fecpcup") = Sal.Fecpcup
      Data1.Recordset("tm_mtmcd100") = Sal.Mt100
      Data1.Recordset("tm_durationmac") = Sal.duratmac
      Data1.Recordset("tm_durationmod") = Sal.duratmod
      Data1.Recordset("tm_convexidad") = Sal.convexid
      
      Data1.Recordset.Update
   End If
   
   Let Screen.MousePointer = vbDefault

Exit Sub
BacErrorHandler:
   Screen.MousePointer = vbDefault
   
   If err <> 0 Then
      If err.Number = 94 Then
         MsgBox " ¡ Existen Valores Nulos ! verifique", vbCritical, gsBac_Version
      Else
         MsgBox error(err), vbCritical, gsBac_Version
      End If
   End If

End Sub

Public Function CPCI_ChkSerie(ByVal cInstser As String, ByRef Sal As BacTypeChkSerie)
On Error GoTo BacErrorHandler
Dim Datos()

    CPCI_ChkSerie = False

'    Sql$ = "SP_CHKINSTSER '" & cInstser & "'"

    Envia = Array(cInstser)
    
    If Not Bac_Sql_Execute("SP_CHKINSTSER", Envia) Then
        MsgBox "Serie no pudo ser validada", vbExclamation, gsBac_Version
        Exit Function
    End If
    
    CPCI_ChkSerie = True
           
    If Bac_SQL_Fetch(Datos()) Then
        Sal.nError = Val(Datos(1))
        
        If Sal.nError = 0 Then
            If Format(Datos(10), "yyyymmdd") <= Format(gsBac_Fecp, "yyyymmdd") Then
                MsgBox "Serie ingresada esta vencida ", vbInformation, gsBac_Version
                CPCI_ChkSerie = False
                Exit Function
            End If

            With Sal
                .cMascara = Datos(2)
                .nCodigo = Val(Datos(3))
                .nSerie = Datos(4)
                .nRutemi = Val(Datos(5))
                .nMonemi = Val(Datos(6))
                .fTasemi = Datos(7)
                .fBasemi = Val(Datos(8))
                .dFecemi = Datos(9)
                .dFecven = Datos(10)
                .cRefnomi = Datos(11)
                .cGenemi = Datos(12)
                .cNemmon = Datos(13)
                .nCorMin = Val(Datos(14))
                .cSeriado = Datos(15)
                .cLeeEmi = Datos(16)
            End With
        Else
            Select Case Sal.nError
                Case 1: MsgBox "'DD' no es dia", vbExclamation, gsBac_Version
                Case 2: MsgBox "'MM' no es fecha", vbExclamation, gsBac_Version
                Case 3: MsgBox "'YY' no es año", vbExclamation, gsBac_Version
                Case 4: MsgBox "'DDMMAA' o 'AAMMDD' no es fecha", vbExclamation, gsBac_Version
                Case 5: MsgBox "' ' no es blanco", vbExclamation, gsBac_Version
                Case 6: MsgBox "'N' no es número", vbExclamation, gsBac_Version
                Case 7: MsgBox "No Coincidió con ninguna máscara", vbExclamation, gsBac_Version
                Case 8: MsgBox "No existe en familia de instrumentos", vbExclamation, gsBac_Version
                Case 9: MsgBox "No existe en series", vbExclamation, gsBac_Version
                Case 10: MsgBox "No fue posible determinar fecha de vencimiento", vbExclamation, gsBac_Version
                Case 11: MsgBox "Fecha de la serie no es válida", vbExclamation, gsBac_Version
                Case 12: 'No Validar
                         'MsgBox "Fecha de vencimiento es feriado", vbExclamation, gsBac_Version
                    With Sal
                        .nError = 0
                        .cMascara = Datos(2)
                        .nCodigo = Val(Datos(3))
                        .nSerie = Datos(4)
                        .nRutemi = Val(Datos(5))
                        .nMonemi = Val(Datos(6))
                        .fTasemi = Val(Datos(7))
                        .fBasemi = Val(Datos(8))
                        .dFecemi = Datos(9)
                        .dFecven = Datos(10)
                        .cRefnomi = Datos(11)
                        .cGenemi = Datos(12)
                        .cNemmon = Datos(13)
                        .nCorMin = Val(Datos(14))
                        .cSeriado = Datos(15)
                        .cLeeEmi = Datos(16)
                    End With

                Case 15: MsgBox "Serie ingresada no es valida", vbExclamation, gsBac_Version
                Case 30: MsgBox "Plazo residual debe ser menor o igual a 180 días", vbExclamation, gsBac_Version
                Case 31: MsgBox "Plazo residual debe ser mayor a 180 días", vbExclamation, gsBac_Version
                Case Else: MsgBox "No se encontró máscara", vbExclamation, gsBac_Version
            End Select
        End If
    Else
        MsgBox "No se pudo chequear la serie", vbExclamation, gsBac_Version
    End If
    
    Exit Function


BacErrorHandler:
    MsgBox "Problemas en chequeo de serie : " & err.Description, vbCritical, gsBac_Version
    Exit Function

End Function
Public Function CPCI_LeerTasaMcd(Codigo&, FecVen$, dEmisor As Double) As Double
Dim Datos()
Dim FecCal$, DiasVcto&, TirMcd#
    
    FecCal$ = Format(gsBac_Fecp, "dd/mm/yyyy")
    DiasVcto& = DateDiff("M", FecCal$, FecVen$)
    
'    Sql = "EXECUTE SP_LEERTASAMCDO "
'    Sql = Sql & Codigo & ","
'    Sql = Sql & DiasVcto& & ","
'    Sql = Sql & dEmisor & ",0"
    
    Envia = Array(CDbl(Codigo), _
            CDbl(DiasVcto), _
            dEmisor)
            
    If Not Bac_Sql_Execute("SP_LEERTASAMCDO", Envia) Then
        CPCI_LeerTasaMcd = 0
        Exit Function
    End If
        
    If Bac_SQL_Fetch(Datos()) Then
        TirMcd# = Val(Datos(1))
    Else
        TirMcd# = 0
    End If
    
    CPCI_LeerTasaMcd = TirMcd#
    
End Function


