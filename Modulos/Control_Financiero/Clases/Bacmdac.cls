VERSION 1.0 CLASS
BEGIN
  MultiUse = 0   'False
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsParametros"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit


'PROD Metodologia 6
'Se crea varible para ser usuado en FRM_DETALLE_LCR y cambiar colum. x AddOn 3
'-----------------------------------------------
Public iMetodologia As Integer





'MDAC : TABLA DE PARAMETROS   'MFAC
'-----------------------------------------------
Public ACrutprop           As Long
Public ACdigprop           As String
Public ACnomprop           As String
Public ACfecante           As String
Public ACfecproc           As Date
Public ACfecprox           As String
Public ACsucmesa           As Integer
Public ACofimesa           As Integer
Public ACcodmonloc         As Integer
Public ACcodmondol         As Integer
Public ACcodmonuf          As Integer
Public ACcodmonobs         As Integer
Public ACnumdecimales      As Integer
Public ACpais              As Integer
Public ACplaza             As Integer
Public ACcodempresa        As Integer
Public ACsw_pd             As String
Public ACsw_fd             As String
Public ACsw_ciemefwd       As String
Public ACsw_devenfwd       As String
Public ACsw_contafwd       As String
Public ACvaloruf           As Double
Public AcValDolObs         As Double
Public ACCodClie           As Integer
Public gsBac_TotalLinea    As Variant
Public ePatrimonio         As Double

Public Function DatosGenerales() As Boolean
Dim Datos()

    DatosGenerales = False

    Envia = Array("ME")
    If Not Bac_Sql_Execute("SP_CARGAPARAMETROS_CONTROLFINANCIERO", Envia) Then
        Exit Function
    End If
    
    If Bac_SQL_Fetch(Datos()) Then
        
        gsBAC_Fecp = Format(Datos(1), gsc_FechaDMA)
        gsBAC_FecAnt = Format(DATOS(10), gsc_FechaDMA) '8800
        
        gsBAC_FecConFin = gsBAC_FecAnt '8800
        
        gsBAC_DolarOBs = CDbl(Datos(2))
        gsBAC_ValmonUF = CDbl(Datos(3))
        gsBAC_Fecpx = Datos(4)
        gsBAC_Clien = Datos(5)
        gsBAC_DolarAcuer = CDbl(Datos(6))
        giBAC_Entidad = 1
        gsBac_Version = Trim("BacTrader " & gsBAC_Clien)
        gsBAC_GloMon = Datos(7)
        ePatrimonio = Datos(8)
        giBAC_TCRC = Datos(9)
        
        BacControlFinanciero.PnlUsuario.Caption = gsBAC_User
        
        BacControlFinanciero.PnlEstado.FontSize = 8
        BacControlFinanciero.PnlFecha.FontSize = 8
        BacControlFinanciero.Pnl_UF.FontSize = 8
        BacControlFinanciero.Pnl_DO.FontSize = 8
        BacControlFinanciero.PnlUsuario.FontSize = 8
        BacControlFinanciero.Pnl_TCRC.FontSize = 8

        BacControlFinanciero.PnlEstado.Caption = Space(1) + gsBAC_Clien
        BacControlFinanciero.PnlFecha.Caption = Format(gsBAC_Fecp, gsc_FechaDMA)
        BacControlFinanciero.Pnl_UF.Caption = "U.F. : " & Format(gsBAC_ValmonUF, "#,##0.00")
        BacControlFinanciero.Pnl_DO.Caption = "D.O. : " & Format(gsBAC_DolarOBs, "#,##0.00")
        BacControlFinanciero.PnlUsuario.Caption = gsBAC_User

        BacControlFinanciero.Pnl_TCRC.Caption = "TCRC : " & Format(giBAC_TCRC, "#,##0.0000")
        
        If Sql = "" Then Call IniProc
        
        DatosGenerales = True
    Else
        MsgBox "Falla Recuperando Parametros.", 16, TITSISTEMA
        End
    End If

End Function

Public Function gsBac_TotalOcupado() As Double
Dim Datos2()
Dim Sql2
    
    'Sql2 = "SP_CONTROLFINANCIERO_LEEOCUPADO"
    If Not Bac_Sql_Execute("SP_CONTROLFINANCIERO_LEEOCUPADO") Then
        
        Exit Function
    
    End If
    
    If Bac_SQL_Fetch(Datos2()) Then
        
        gsBac_TotalOcupado = Format(Datos2(1), FDecimal)
        gsBac_TotalLinea = Format(Datos2(3), FDecimal)
    
    End If

End Function

