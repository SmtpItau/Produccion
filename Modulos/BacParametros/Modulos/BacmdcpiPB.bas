Attribute VB_Name = "modMDCPCIPB"
Option Explicit

Type BacTypeChkSeriePB
    nerror  As Integer
    cMascara    As String
    nCodigo     As Long
    nSerie      As String
    sFamilia    As String    'FLI
    nRutemi     As Long
    nMonemi     As Integer
    fTasemi     As Double
    fBasemi     As Integer
    dFecemi     As String
    dFecVen     As String
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

'Variable global de Formulario de Emision de Tasa Referencial
Global gb_FrmEmTasRef As Boolean

Public Function CPCI_ChkSeriePB(ByVal cInstser As String, ByRef Sal As BacTypeChkSeriePB)
On Error GoTo BacErrorHandler
Dim Datos()

    CPCI_ChkSeriePB = False

'    Sql$ = "sp_chkinstser '" & cInstser & "'"

    Envia = Array(cInstser)
    
    If Not Bac_Sql_Execute("BacTraderSuda.dbo.SP_CHKINSTSER", Envia) Then
        MsgBox "Serie no pudo ser validada", vbExclamation, gsBac_Version
        Exit Function
    End If
    
    CPCI_ChkSeriePB = True
           
    If Bac_SQL_Fetch(Datos()) Then
        Sal.nerror = Val(Datos(1))
        
        If Sal.nerror = 0 Then
            If Format(Datos(10), "yyyymmdd") <= Format(gsbac_fecp, "yyyymmdd") Then
                MsgBox "Serie ingresada esta vencida ", vbInformation, gsBac_Version
                CPCI_ChkSeriePB = False
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
                .dFecVen = Datos(10)
                .cRefnomi = Datos(11)
                .cGenemi = Datos(12)
                .cNemmon = Datos(13)
                .nCorMin = Val(Datos(14))
                .cSeriado = Datos(15)
                .cLeeEmi = Datos(16)
            End With
        Else
            Select Case Sal.nerror
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
                        .nerror = 0
                        .cMascara = Datos(2)
                        .nCodigo = Val(Datos(3))
                        .nSerie = Datos(4)
                        .nRutemi = Val(Datos(5))
                        .nMonemi = Val(Datos(6))
                        .fTasemi = Val(Datos(7))
                        .fBasemi = Val(Datos(8))
                        .dFecemi = Datos(9)
                        .dFecVen = Datos(10)
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
    MsgBox "Problemas en chequeo de serie : " & Err.Description, vbCritical, gsBac_Version
    Exit Function

End Function
