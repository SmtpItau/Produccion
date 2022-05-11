VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "Mscomctl.ocx"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "Comdlg32.ocx"
Begin VB.Form Frm_Mnt_Factor_Correlaciones 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantencion de Correlaciones"
   ClientHeight    =   6330
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   6630
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   6330
   ScaleWidth      =   6630
   Begin MSComDlg.CommonDialog cd_archivo 
      Left            =   465
      Top             =   6420
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin VB.Frame Frame1 
      Height          =   5190
      Left            =   15
      TabIndex        =   5
      Top             =   1125
      Width           =   6600
      Begin VB.TextBox Txt_Moneda 
         Height          =   285
         Left            =   990
         TabIndex        =   8
         Top             =   165
         Width           =   1065
      End
      Begin MSFlexGridLib.MSFlexGrid GrdVistaPrevia 
         Height          =   4395
         Left            =   90
         TabIndex        =   6
         Top             =   735
         Width           =   6450
         _ExtentX        =   11377
         _ExtentY        =   7752
         _Version        =   393216
      End
      Begin VB.Label Lbl_Moneda 
         BorderStyle     =   1  'Fixed Single
         Height          =   285
         Left            =   2190
         TabIndex        =   9
         Top             =   165
         Width           =   4305
      End
      Begin VB.Label Label10 
         Caption         =   "Moneda 1"
         Height          =   210
         Left            =   150
         TabIndex        =   7
         Top             =   210
         Width           =   735
      End
   End
   Begin MSComctlLib.Toolbar TlbHerramientas 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   2
      Top             =   0
      Width           =   6630
      _ExtentX        =   11695
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImlBotones"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   6
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.Visible         =   0   'False
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.Visible         =   0   'False
            Object.ToolTipText     =   "Eliminar"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Excel"
            ImageIndex      =   8
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Cerrar"
            ImageIndex      =   5
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImlBotones 
         Left            =   6870
         Top             =   0
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   22
         ImageHeight     =   22
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   8
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Mnt_Factor_Correlaciones.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Mnt_Factor_Correlaciones.frx":0EDA
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Mnt_Factor_Correlaciones.frx":1DB4
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Mnt_Factor_Correlaciones.frx":2C8E
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Mnt_Factor_Correlaciones.frx":3B68
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Mnt_Factor_Correlaciones.frx":3E82
               Key             =   ""
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Mnt_Factor_Correlaciones.frx":4D5C
               Key             =   ""
            EndProperty
            BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Mnt_Factor_Correlaciones.frx":5C36
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame FrParametros 
      Caption         =   "Opcion de generacion para archivo Excel"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   600
      Left            =   15
      TabIndex        =   3
      Top             =   525
      Width           =   6600
      Begin VB.OptionButton Op_Importar 
         Alignment       =   1  'Right Justify
         Caption         =   "Importar Desde Excel"
         Height          =   345
         Left            =   3885
         TabIndex        =   1
         Top             =   210
         Width           =   1950
      End
      Begin VB.OptionButton Op_Exportar 
         Caption         =   "Exportar Hacia Excel"
         Height          =   360
         Left            =   600
         TabIndex        =   0
         Top             =   210
         Width           =   2235
      End
   End
   Begin MSComctlLib.Toolbar TlbVistaPrevia 
      Height          =   195
      Left            =   45
      TabIndex        =   4
      Top             =   0
      Width           =   1395
      _ExtentX        =   2461
      _ExtentY        =   344
      ButtonWidth     =   609
      ButtonHeight    =   582
      Appearance      =   1
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Restaurar Vista Previa"
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Vista Previa"
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
End
Attribute VB_Name = "Frm_Mnt_Factor_Correlaciones"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit


' CONSTANTES DE TOOLBAR TLBHERRAMIENTAS
Const BtnLimpiar = 1
Const BtnBuscar = 2
Const BtnGrabar = 3
Const BtnEliminar = 4
Const BtnExcel = 5
Const BtnCerrar = 6

' CONSTANTES DE RETORNO DE PROCEDIMIENTO SP_CON_FACTOR_CORRELACIONES_LINEAS
Const nDatCodMoneda1 = 1
Const nDatPlazo11 = 2
Const nDatPlazo12 = 3

Const nDatCodMoneda2 = 4
Const nDatPlazo21 = 5
Const nDatPlazo22 = 6

Const nDatFactor = 7

Const nDatNemMoneda1 = 8
Const nDatNemMoneda2 = 9

' CONSTANTES DE CABECERAS DE GRILLA GRDVISTAPREVIA

Const nColNemMoneda2 = 0
Const nColPlazoIni1 = 1
Const nColPlazoFin1 = 2
Const nColPlazoIni2 = 3
Const nColPlazoFin2 = 4
Const nColFactor = 5

'-----------------------------------------------------------------------------

Dim DATOS()
Dim nContador   As Long
Dim nContador2  As Long
Dim nPosCol     As Integer
Dim nPosRow     As Integer

Private Function Func_Letras_Columnas_Excell(nNumCol As Integer) As String

    Dim nLetra1     As Integer
    Dim nLetra2     As Integer
    Dim cLetras     As String

    nLetra1 = 1
    nLetra2 = 0
    
    If nNumCol <= 26 Then
        Func_Letras_Columnas_Excell = Chr(nNumCol + 64)
    Else
        For nContador = 27 To nNumCol
            
            nLetra2 = nLetra2 + 1
            
            If nLetra2 = 27 Then
                nLetra2 = 1
                nLetra1 = nLetra1 + 1
                
                If nLetra1 = 27 Then
                    nLetra1 = 1
                End If
            End If
        Next nContador
        
        cLetras = Chr(nLetra1 + 64) & Chr(nLetra2 + 64)
        
        Func_Letras_Columnas_Excell = cLetras
    End If

End Function



Private Sub Proc_Excel()

   If Op_Importar.Value = True Then
      Call PROC_IMPORTAR_EXCEL
      
   ElseIf Op_Exportar.Value = True Then
      Call PROC_EXPORTA_EXCEL
   
   Else
      Screen.MousePointer = vbDefault
      MsgBox "Debe seleccionar una opcion (Importar / Exportar) antes de utilizar esta opcion.", vbExclamation + vbOKOnly
      Exit Sub
   End If

End Sub

Private Sub PROC_IMPORTAR_EXCEL()
      
   Dim sNombre$
   Dim xlApp        ''''As EXCEL.Application
   Dim xlBook       ''''As EXCEL.Workbook
   Dim xlSheet      ''''As EXCEL.Worksheet
   Dim iRow         As Integer
   Dim xRow         As Integer
   Dim xCol         As Integer
   Dim bTransaccion As Boolean
   
   Dim cMoneda1     As String
   Dim cMoneda2     As String
   Dim nPlazoIni1   As Double
   Dim nPlazoFin1   As Double
   Dim nPlazoIni2   As Double
   Dim nPlazoFin2   As Double
   Dim nFactor      As Double
   Dim nHastaCol    As Long
   Dim nHastarow    As Long
   Dim bExcelOpen   As Boolean
   
        
   On Error GoTo LISTA_ERROR
   
   bExcelOpen = False
      
   cd_archivo.CancelError = True
   cd_archivo.FileName = ""
   cd_archivo.Filter = "Archivo de Correlaciones *.xls"
   cd_archivo.DialogTitle = "Importar Archivo de Correlaciones"
   cd_archivo.ShowOpen
   
   Screen.MousePointer = vbHourglass
   
    If Not Bac_Sql_Execute("BEGIN TRANSACTION") Then
        Screen.MousePointer = vbDefault
        MsgBox "Ha ocurrido un error al intentar grabar los factores de correlacion - BEGIN TRANSACTION", vbCritical, TITSISTEMA
        Exit Sub
    End If
          
    bTransaccion = True
          
    If Not Bac_Sql_Execute("SP_DEL_CORRELACIONES_LINEAS") Then
        Call Bac_Sql_Execute("ROLLBACK TRANSACTION")
        Screen.MousePointer = vbDefault
        MsgBox "Ha ocurrido un error al intentar grabar las correlaciones (1)", vbCritical, TITSISTEMA
        GoSub CIERRA_EXCEL
        Exit Sub
    End If

   Set xlApp = CreateObject("Excel.Application")
   Set xlBook = xlApp.Workbooks.Open(cd_archivo.FileName)
   Set xlSheet = xlApp.ActiveSheet
   bExcelOpen = True
   
   nHastarow = xlApp.ActiveCell.SpecialCells(xlLastCell).Row
     
   For xRow = 4 To nHastarow
      xlSheet.Range("D" & CStr(xRow)).Select
      nHastaCol = IIf(xlApp.ActiveCell.Columns.End(xlToRight).Column = 256, 4, xlApp.ActiveCell.Columns.End(xlToRight).Column)
      For xCol = 4 To nHastaCol
         If CStr(Func_Leer_Celda(xlSheet, xRow, 1)) <> "0" Then
            cMoneda1 = Func_Leer_Celda(xlSheet, xRow, 1)
         End If
         
         nPlazoIni1 = Func_Leer_Celda(xlSheet, xRow, 2)
         nPlazoFin1 = Func_Leer_Celda(xlSheet, xRow, 3)
         
         If CStr(Func_Leer_Celda(xlSheet, 1, xCol)) <> "0" Then
            cMoneda2 = Func_Leer_Celda(xlSheet, 1, xCol)
         End If
         
         nPlazoIni2 = Func_Leer_Celda(xlSheet, 2, xCol)
         nPlazoFin2 = Func_Leer_Celda(xlSheet, 3, xCol)
      
         nFactor = Func_Leer_Celda(xlSheet, xRow, xCol)
       
         Envia = Array()
         AddParam Envia, cMoneda1
         AddParam Envia, nPlazoIni1
         AddParam Envia, nPlazoFin1
         AddParam Envia, cMoneda2
         AddParam Envia, nPlazoIni2
         AddParam Envia, nPlazoFin2
         AddParam Envia, nFactor
         
         If Not Bac_Sql_Execute("SP_ACT_CORRELACIONES_LINEAS", Envia) Then
             Call Bac_Sql_Execute("ROLLBACK TRANSACTION")
             Screen.MousePointer = vbDefault
             MsgBox "Ha ocurrido un error al intentar grabar las correlaciones.", vbCritical, TITSISTEMA
             GoSub CIERRA_EXCEL
             Exit Sub
         End If
         
      Next xCol
   Next xRow
   
   If Not Bac_Sql_Execute("COMMIT TRANSACTION") Then
      Screen.MousePointer = vbDefault
      MsgBox "Ha ocurrido un error al intentar grabar las correlaciones - COMMIT TRANSACTION", vbCritical, TITSISTEMA
      GoSub CIERRA_EXCEL
      Exit Sub
   End If
     
   GoSub CIERRA_EXCEL

''''   Pnl_Avance.FloodPercent = 0
   Screen.MousePointer = vbDefault
   
   MsgBox "Proceso de carga de correlaciones desde planilla excel ha finalizado con exito", vbInformation, TITSISTEMA

Exit Sub
LISTA_ERROR:

Screen.MousePointer = vbDefault

   If Err.Number = cdlCancel Then
      Exit Sub
   Else
      If bTransaccion = True Then
         Call Bac_Sql_Execute("ROLLBACK TRANSACTION")
      End If
      
      If bExcelOpen = True Then
         GoSub CIERRA_EXCEL
      End If
      
      MsgBox "Error N° : (" & Err.Number & ")..." & vbCrLf & Err.Description, vbExclamation, Me.Caption
      Exit Sub
   End If
   
CIERRA_EXCEL:

   xlBook.Close
   xlApp.Visible = False
   xlApp.Quit

   Set xlApp = Nothing
   Set xlBook = Nothing
   Set xlSheet = Nothing
   Return

End Sub



Private Function Func_Leer_Celda(ByVal objSheet As Object, nFila As Integer, nColumna As Integer) As Variant     'Double
   
   If IsNumeric(objSheet.Cells(nFila, nColumna)) Then
      Func_Leer_Celda = CDbl(objSheet.Cells(nFila, nColumna))
   Else
      Func_Leer_Celda = Trim(objSheet.Cells(nFila, nColumna))
   End If

End Function

Sub PROC_EXPORTA_EXCEL()
    Dim nFila1       As Long
    Dim nFila2       As Long
    Dim ruta         As String
    Dim Crea_xls     As Boolean
    Dim retorno      As Double
    Dim oDatos()
    Dim MiExcell     ''''As New EXCEL.Application
    Dim MiLibro      ''''As New EXCEL.Workbook
    Dim MiHoja       ''''As New EXCEL.Worksheet
    Dim MiSheet      As Object
    Dim ExcelActivo  As Boolean
    
    Dim nRowMoneda   As Integer
    Dim nRowPlazo1   As Integer
    Dim nRowPlazo2   As Integer
    
    Dim nColMoneda   As Integer
    Dim nColPlazo1   As Integer
    Dim nColPlazo2   As Integer
    
    Dim nContadorRow As Integer
    Dim nContadorCol As Integer
    
    Dim cMoneda1     As String
    Dim cMoneda2     As String
    
    Dim nPlazo11     As Double
    Dim nPlazo12     As Double
    
    Dim cRangoDesde  As String
    Dim cRangoHasta  As String
    Dim cRangoSelec  As String
    
    On Error GoTo CONTROLA_ERROR
    
    '************************************************
    '****** SETEO DE VARIABLES PARA ENCABEZADOS ******
    '************************************************
    nRowMoneda = 1
    nRowPlazo1 = 2
    nRowPlazo2 = 3
    
    nColMoneda = 1
    nColPlazo1 = 2
    nColPlazo2 = 3
    
    '************************************************
    '************************************************
    '************************************************
       
    Screen.MousePointer = vbHourglass

    If MsgBox("¿ Seguro que desea generar la planilla excel para los factores de correlacion ?", vbQuestion + vbYesNo) = vbNo Then
        Screen.MousePointer = vbDefault
        Exit Sub
    End If
        
    cd_archivo.CancelError = True
    cd_archivo.FileName = ""
    cd_archivo.Filter = "Archivo de Correlaciones *.xls"
    cd_archivo.DialogTitle = "Exportar Archivo de Correlaciones"
    cd_archivo.ShowSave
       
    DoEvents
    
    If Dir(cd_archivo.FileName) <> "" Then
       If MsgBox("Archivo ya existe, desea reemplazar el archivo", vbQuestion + vbYesNo) = vbNo Then
          Screen.MousePointer = vbDefault
          cd_archivo.FileName = ""
          Exit Sub
       Else
          Call Kill(cd_archivo.FileName)
       End If
    End If
  
    Set MiExcell = CreateObject("Excel.Application")
    Set MiLibro = MiExcell.Application.Workbooks.Add
    Set MiHoja = MiLibro.Sheets(1)
    Set MiSheet = MiExcell.ActiveSheet
    
    ExcelActivo = True
    
    MiExcell.DisplayAlerts = False
    MiExcell.Worksheets(3).Delete
    MiExcell.Worksheets(2).Delete
    MiExcell.DisplayAlerts = True
        
    MiLibro.Sheets("Hoja1").Name = "TBL_CORRELACIONES"
           
    Envia = Array()
      
    If Not Bac_Sql_Execute("SP_CON_CORRELACIONES_LINEAS ") Then
      GoSub CIERRA_EXCEL
      Screen.MousePointer = vbDefault
      MsgBox "Ha ocurrido un error al intentar rescatar informacion para la generacion de la planilla excel", vbCritical, gsBac_Version
      Exit Sub
    End If
      
    cMoneda1 = ""
    cMoneda2 = ""
    
    nPlazo11 = 8888
    nPlazo12 = 8888
     
    nContadorRow = 4
    nContadorCol = 4
    
    MiLibro.Worksheets("TBL_CORRELACIONES").Activate
    
    Do While Bac_SQL_Fetch(oDatos())
    
        If Trim(oDatos(nDatNemMoneda1)) <> "MX/ML" Then
        
            If nPlazo11 <> CDbl(oDatos(nDatPlazo11)) Or nPlazo12 <> CDbl(oDatos(nDatPlazo12)) Then
                If nPlazo11 <> 8888 And nPlazo12 <> 8888 Then
                    nContadorRow = nContadorRow + 1
                    nContadorCol = 4
                End If

                nPlazo11 = CDbl(oDatos(nDatPlazo11))
                nPlazo12 = CDbl(oDatos(nDatPlazo12))
                
                MiLibro.Worksheets("TBL_CORRELACIONES").Cells(nContadorRow, nColPlazo1) = nPlazo11
                MiLibro.Worksheets("TBL_CORRELACIONES").Cells(nContadorRow, nColPlazo2) = nPlazo12
            End If
            
            If cMoneda1 <> Trim(oDatos(nDatNemMoneda1)) Then
                If cMoneda1 <> "" Then
                    MiLibro.Worksheets("TBL_CORRELACIONES").Cells((nContadorRow) - 1, nColMoneda).Select
                    MiLibro.Worksheets("TBL_CORRELACIONES").Range(MiExcell.Selection, MiExcell.Selection.End(xlUp)).Select
                    MiExcell.Selection.Interior.ColorIndex = 8
                    MiExcell.Selection.Interior.Pattern = xlSolid
                    GoSub UNE_CELDAS
                    GoSub MARCA_BORDES
                End If
            
                cMoneda1 = Trim(oDatos(nDatNemMoneda1))
                MiLibro.Worksheets("TBL_CORRELACIONES").Cells(nContadorRow, nColMoneda) = cMoneda1
            End If

            If cMoneda2 <> Trim(oDatos(nDatNemMoneda2)) Then
               cMoneda2 = Trim(oDatos(nDatNemMoneda2))
               MiLibro.Worksheets("TBL_CORRELACIONES").Cells(nRowMoneda, nContadorCol) = cMoneda2
            End If
                    
            MiLibro.Worksheets("TBL_CORRELACIONES").Cells(nColPlazo1, nContadorCol) = oDatos(nDatPlazo21)
            MiLibro.Worksheets("TBL_CORRELACIONES").Cells(nColPlazo2, nContadorCol) = oDatos(nDatPlazo22)
            
            MiLibro.Worksheets("TBL_CORRELACIONES").Cells(nContadorRow, nContadorCol) = Str(oDatos(nDatFactor))
            
            MiLibro.Worksheets("TBL_CORRELACIONES").Cells(nContadorRow, nContadorCol).Interior.ColorIndex = 15
            MiLibro.Worksheets("TBL_CORRELACIONES").Cells(nContadorRow, nContadorCol).Interior.Pattern = xlSolid
                    
            nContadorCol = nContadorCol + 1
                         
            Crea_xls = True
        End If
    
    Loop
    
    MiLibro.Worksheets("TBL_CORRELACIONES").Cells((nContadorRow), nColMoneda).Select
    MiLibro.Worksheets("TBL_CORRELACIONES").Range(MiExcell.Selection, MiExcell.Selection.End(xlUp)).Select
    MiExcell.Selection.Interior.ColorIndex = 8
    MiExcell.Selection.Interior.Pattern = xlSolid
    GoSub UNE_CELDAS
    GoSub MARCA_BORDES
    
    MiLibro.Worksheets("TBL_CORRELACIONES").Cells(nRowMoneda, (nContadorCol - 1)).Select
    MiLibro.Worksheets("TBL_CORRELACIONES").Range(MiExcell.Selection, MiExcell.Selection.End(xlToLeft)).Select
    MiExcell.Selection.Interior.ColorIndex = 8
    MiExcell.Selection.Interior.Pattern = xlSolid
    GoSub UNE_CELDAS
    MiLibro.Worksheets("TBL_CORRELACIONES").Cells(nRowMoneda, 1).Select
    
    Do While MiExcell.ActiveCell.Columns.End(xlToRight).Column <= MiExcell.ActiveCell.SpecialCells(xlLastCell).Column
    
        MiExcell.ActiveCell.Columns.End(xlToRight).Select
        cRangoDesde = (Func_Letras_Columnas_Excell(MiExcell.ActiveCell.Column) + CStr(MiExcell.ActiveCell.Row))
                
        cRangoHasta = (Func_Letras_Columnas_Excell((IIf(MiExcell.ActiveCell.Columns.End(xlToRight).Column = 256, MiExcell.ActiveCell.SpecialCells(xlLastCell).Column, MiExcell.ActiveCell.Columns.End(xlToRight).Column - 1))) + CStr(MiExcell.ActiveCell.Row))
        
        cRangoSelec = cRangoDesde & ":" & cRangoHasta
        MiLibro.Worksheets("TBL_CORRELACIONES").Range(cRangoSelec).Select
        MiExcell.Selection.Interior.ColorIndex = 8
        MiExcell.Selection.Interior.Pattern = xlSolid

        GoSub UNE_CELDAS
        GoSub MARCA_BORDES
    Loop
   
    MiLibro.Worksheets("TBL_CORRELACIONES").Range("A1:C3").Select
    
    GoSub UNE_CELDAS
    GoSub MARCA_BORDES

    MiSheet.Range("D4").Select
    MiSheet.Range(MiExcell.Selection, MiExcell.ActiveCell.SpecialCells(xlLastCell)).Select
    MiExcell.Selection.NumberFormat = "#,##0.0000"
    
    With MiExcell.Selection.Borders(xlEdgeLeft)
        .LineStyle = xlContinuous
        .Weight = xlThin
        .ColorIndex = xlAutomatic
    End With
    With MiExcell.Selection.Borders(xlEdgeTop)
        .LineStyle = xlContinuous
        .Weight = xlThin
        .ColorIndex = xlAutomatic
    End With
    With MiExcell.Selection.Borders(xlEdgeBottom)
        .LineStyle = xlContinuous
        .Weight = xlThin
        .ColorIndex = xlAutomatic
    End With
    With MiExcell.Selection.Borders(xlEdgeRight)
        .LineStyle = xlContinuous
        .Weight = xlThin
        .ColorIndex = xlAutomatic
    End With
    With MiExcell.Selection.Borders(xlInsideVertical)
        .LineStyle = xlContinuous
        .Weight = xlThin
        .ColorIndex = xlAutomatic
    End With
    With MiExcell.Selection.Borders(xlInsideHorizontal)
        .LineStyle = xlContinuous
        .Weight = xlThin
        .ColorIndex = xlAutomatic
    End With
    
    MiSheet.Range("D4").Select
    
    MiExcell.Cells.Select
    MiExcell.Cells.EntireColumn.AutoFit
    MiSheet.Range("A1").Select
    
    MiSheet.Range("D1").Select
    cRangoDesde = "D1"
    cRangoHasta = (Func_Letras_Columnas_Excell(MiExcell.ActiveCell.SpecialCells(xlLastCell).Column)) + "1"
    cRangoSelec = cRangoDesde & ":" & cRangoHasta
    MiLibro.Worksheets("TBL_CORRELACIONES").Range(cRangoSelec).Select

    GoSub MARCA_BORDES
   
    MiSheet.Range("D2").Select
    cRangoDesde = "D2"
    cRangoHasta = (Func_Letras_Columnas_Excell(MiExcell.ActiveCell.SpecialCells(xlLastCell).Column)) + CStr(nRowPlazo2)
    cRangoSelec = cRangoDesde & ":" & cRangoHasta
    MiLibro.Worksheets("TBL_CORRELACIONES").Range(cRangoSelec).Select
    GoSub MARCA_BORDES
    
    MiSheet.Range("B4").Select
    cRangoDesde = "B4"
    cRangoHasta = Chr(nColPlazo2 + 64) + CStr((MiExcell.ActiveCell.SpecialCells(xlLastCell).Row))
    cRangoSelec = cRangoDesde & ":" & cRangoHasta
    MiLibro.Worksheets("TBL_CORRELACIONES").Range(cRangoSelec).Select

    GoSub MARCA_BORDES
    
    MiSheet.Range("A1").Select
    Do While MiExcell.ActiveCell.Columns.End(xlToRight).Column <= MiExcell.ActiveCell.SpecialCells(xlLastCell).Column
        MiExcell.ActiveCell.Columns.End(xlToRight).Select
        cRangoDesde = (Func_Letras_Columnas_Excell(MiExcell.ActiveCell.Column) + CStr(MiExcell.ActiveCell.Row))
        cRangoHasta = (Func_Letras_Columnas_Excell(IIf(MiExcell.ActiveCell.Columns.End(xlToRight).Column = 256, MiExcell.ActiveCell.SpecialCells(xlLastCell).Column, MiExcell.ActiveCell.Columns.End(xlToRight).Column - 1)) + CStr(MiExcell.ActiveCell.SpecialCells(xlLastCell).Row))
        cRangoSelec = cRangoDesde & ":" & cRangoHasta
        MiLibro.Worksheets("TBL_CORRELACIONES").Range(cRangoSelec).Select
        GoSub MARCA_BORDES
        MiLibro.Worksheets("TBL_CORRELACIONES").Range(cRangoDesde).Select
    Loop
   
    MiSheet.Range("A1").Select
    Do While MiExcell.ActiveCell.Columns.End(xlDown).Row <= MiExcell.ActiveCell.SpecialCells(xlLastCell).Row
        MiExcell.ActiveCell.Columns.End(xlDown).Select
        cRangoDesde = (Func_Letras_Columnas_Excell((MiExcell.ActiveCell.Column)) + CStr(MiExcell.ActiveCell.Row))
        cRangoHasta = (Func_Letras_Columnas_Excell((MiExcell.ActiveCell.SpecialCells(xlLastCell).Column)) + CStr(IIf(MiExcell.ActiveCell.Columns.End(xlDown).Row = 65536, MiExcell.ActiveCell.SpecialCells(xlLastCell).Row, MiExcell.ActiveCell.Columns.End(xlDown).Row - 1)))
        cRangoSelec = cRangoDesde & ":" & cRangoHasta
        MiLibro.Worksheets("TBL_CORRELACIONES").Range(cRangoSelec).Select
        GoSub MARCA_BORDES
        MiLibro.Worksheets("TBL_CORRELACIONES").Range(cRangoDesde).Select
    Loop
    
    '***********************************************************************************************
    '**************************************** MX/ML ************************************************
    '***********************************************************************************************
     Envia = Array()
      
    If Not Bac_Sql_Execute("SP_CON_CORRELACIONES_LINEAS ") Then
      GoSub CIERRA_EXCEL
      Screen.MousePointer = vbDefault
      MsgBox "Ha ocurrido un error al intentar rescatar informacion para la generacion de la planilla excel", vbCritical, gsBac_Version
      Exit Sub
    End If
      
    cMoneda1 = ""
    cMoneda2 = ""
    
    nPlazo11 = 8888
    nPlazo12 = 8888
   
    cRangoHasta = "A" + CStr((MiExcell.ActiveCell.SpecialCells(xlLastCell).Row) + 1)
    MiLibro.Worksheets("TBL_CORRELACIONES").Range(cRangoHasta).Select
    nContadorRow = MiExcell.ActiveCell.Row
    nContadorCol = 4
    
    Do While Bac_SQL_Fetch(oDatos())
        If Trim(oDatos(nDatNemMoneda1)) = "MX/ML" Then
            MiLibro.Worksheets("TBL_CORRELACIONES").Cells(nContadorRow, nColMoneda) = oDatos(nDatNemMoneda1)
                    
            If Trim(oDatos(nDatNemMoneda2)) <> "MX/ML" Then
                MiLibro.Worksheets("TBL_CORRELACIONES").Cells(nContadorRow, nContadorCol) = oDatos(nDatFactor)
                MiLibro.Worksheets("TBL_CORRELACIONES").Cells(nContadorRow, nContadorCol).NumberFormat = "#,##0.0000"
            Else
                MiLibro.Worksheets("TBL_CORRELACIONES").Cells(nRowMoneda, MiExcell.ActiveCell.SpecialCells(xlLastCell).Column + 1) = oDatos(nDatNemMoneda2)
                MiExcell.ActiveCell.SpecialCells(xlLastCell).Select
                MiLibro.Worksheets("TBL_CORRELACIONES").Cells(MiExcell.Selection.Row, MiExcell.Selection.Column) = oDatos(nDatFactor)
                MiLibro.Worksheets("TBL_CORRELACIONES").Cells(MiExcell.Selection.Row, MiExcell.Selection.Column).NumberFormat = "#,##0.0000"
                MiLibro.Worksheets("TBL_CORRELACIONES").Cells(MiExcell.Selection.Row, MiExcell.Selection.Column).Interior.ColorIndex = 15
                MiLibro.Worksheets("TBL_CORRELACIONES").Cells(MiExcell.Selection.Row, MiExcell.Selection.Column).Interior.Pattern = xlSolid
                MiLibro.Worksheets("TBL_CORRELACIONES").Range(MiExcell.Selection, MiExcell.Selection.End(xlUp)).Select
                    
                With MiExcell.Selection.Borders(xlEdgeLeft)
                    .LineStyle = xlContinuous
                    .Weight = xlThin
                    .ColorIndex = xlAutomatic
                End With
                With MiExcell.Selection.Borders(xlEdgeTop)
                    .LineStyle = xlContinuous
                    .Weight = xlThin
                    .ColorIndex = xlAutomatic
                End With
                With MiExcell.Selection.Borders(xlEdgeBottom)
                    .LineStyle = xlContinuous
                    .Weight = xlThin
                    .ColorIndex = xlAutomatic
                End With
                With MiExcell.Selection.Borders(xlEdgeRight)
                    .LineStyle = xlContinuous
                    .Weight = xlThin
                    .ColorIndex = xlAutomatic
                End With
                With MiExcell.Selection.Borders(xlInsideHorizontal)
                    .LineStyle = xlContinuous
                    .Weight = xlThin
                    .ColorIndex = xlAutomatic
                End With
                MiExcell.Selection.End(xlUp).Select
                MiLibro.Worksheets("TBL_CORRELACIONES").Range(MiExcell.Selection, MiExcell.Selection.End(xlUp)).Select
                
                cRangoDesde = (Func_Letras_Columnas_Excell((MiExcell.ActiveCell.Column)) + CStr(MiExcell.ActiveCell.Row))
                cRangoHasta = (Func_Letras_Columnas_Excell((MiExcell.ActiveCell.Column)) + CStr(MiExcell.ActiveCell.Row + 2))
                cRangoSelec = cRangoDesde & ":" & cRangoHasta
                MiLibro.Worksheets("TBL_CORRELACIONES").Range(cRangoSelec).Select
                GoSub UNE_CELDAS
                MiExcell.Selection.Interior.ColorIndex = 8
                MiExcell.Selection.Interior.Pattern = xlSolid
                GoSub MARCA_BORDES
                cRangoDesde = (Func_Letras_Columnas_Excell((MiExcell.ActiveCell.Column)) + CStr(MiExcell.ActiveCell.Row))
                cRangoHasta = (Func_Letras_Columnas_Excell((MiExcell.ActiveCell.Column)) + CStr(MiExcell.Selection.End(xlDown).Row))
                cRangoSelec = cRangoDesde & ":" & cRangoHasta
                MiLibro.Worksheets("TBL_CORRELACIONES").Range(cRangoSelec).Select
                GoSub MARCA_BORDES
                
                nContadorCol = 3
            End If
            
            MiLibro.Worksheets("TBL_CORRELACIONES").Cells(nContadorRow, nContadorCol).Interior.ColorIndex = 15
            MiLibro.Worksheets("TBL_CORRELACIONES").Cells(nContadorRow, nContadorCol).Interior.Pattern = xlSolid
            
            nContadorCol = nContadorCol + 1
        Else
            Exit Do
        End If
    Loop
    
    cRangoDesde = "A" + CStr(MiExcell.ActiveCell.SpecialCells(xlLastCell).Row)
    cRangoHasta = "C" + CStr(MiExcell.ActiveCell.SpecialCells(xlLastCell).Row)
    cRangoSelec = cRangoDesde & ":" & cRangoHasta
    MiLibro.Worksheets("TBL_CORRELACIONES").Range(cRangoSelec).Select
    
    GoSub UNE_CELDAS
    
    MiExcell.Selection.Interior.ColorIndex = 8
    MiExcell.Selection.Interior.Pattern = xlSolid
    
    GoSub MARCA_BORDES
    
    cRangoDesde = "A" + CStr(MiExcell.ActiveCell.Row)
    cRangoHasta = (Func_Letras_Columnas_Excell((MiExcell.ActiveCell.SpecialCells(xlLastCell).Column)) + CStr(MiExcell.ActiveCell.SpecialCells(xlLastCell).Row))
    cRangoSelec = cRangoDesde & ":" & cRangoHasta
    MiLibro.Worksheets("TBL_CORRELACIONES").Range(cRangoSelec).Select
    
    With MiExcell.Selection.Borders(xlEdgeLeft)
        .LineStyle = xlContinuous
        .Weight = xlThin
        .ColorIndex = xlAutomatic
    End With
    With MiExcell.Selection.Borders(xlEdgeTop)
        .LineStyle = xlContinuous
        .Weight = xlThin
        .ColorIndex = xlAutomatic
    End With
    With MiExcell.Selection.Borders(xlEdgeBottom)
        .LineStyle = xlContinuous
        .Weight = xlThin
        .ColorIndex = xlAutomatic
    End With
    With MiExcell.Selection.Borders(xlEdgeRight)
        .LineStyle = xlContinuous
        .Weight = xlThin
        .ColorIndex = xlAutomatic
    End With
    With MiExcell.Selection.Borders(xlInsideVertical)
        .LineStyle = xlContinuous
        .Weight = xlThin
        .ColorIndex = xlAutomatic
    End With
    
    GoSub MARCA_BORDES
    
    MiSheet.Range("A1").Select
  
    If Crea_xls Then
        MiExcell.DisplayAlerts = False
        MiHoja.SaveAs (cd_archivo.FileName)
        MiExcell.DisplayAlerts = True
    Else
        GoSub CIERRA_EXCEL

        MousePointer = vbDefault
        MsgBox "No se encontró Información para generar el Excel", vbExclamation, gsBac_Version
        Exit Sub
    End If
              
    GoSub CIERRA_EXCEL
  
    Screen.MousePointer = vbDefault
    MsgBox "El archivo excel con las corrrelaciones ha sido generado con exito", vbInformation, gsBac_Version
     
    retorno = Shell(gsBac_Office & "EXCEL.EXE  " & """" & cd_archivo.FileName & """", vbMaximizedFocus)
    Exit Sub
    
CIERRA_EXCEL:
      MiExcell.DisplayAlerts = False
      MiHoja.Application.Workbooks.Close
      MiExcell.Application.Workbooks.Close
      MiExcell.Application.Quit
   
      Set MiExcell = Nothing
      Set MiLibro = Nothing
      Set MiHoja = Nothing
      Return
      
CONTROLA_ERROR:
      Screen.MousePointer = vbDefault
      
      If Err.Number = cdlCancel Then
         Exit Sub
      End If
      
      If ExcelActivo = True Then
         GoSub CIERRA_EXCEL
      End If
      
      MsgBox CStr(Err.Number) + vbCrLf + Err.Description, vbExclamation + vbOKOnly

      Exit Sub

UNE_CELDAS:
    MiExcell.Selection.HorizontalAlignment = xlCenter
    MiExcell.Selection.VerticalAlignment = xlCenter
    MiExcell.Selection.WrapText = False
    MiExcell.Selection.Orientation = 0
    MiExcell.Selection.AddIndent = False
    MiExcell.Selection.ShrinkToFit = False
    MiExcell.Selection.MergeCells = False
    MiExcell.Selection.Merge
        
    Return
      
MARCA_BORDES:
    
    MiExcell.Selection.Borders(xlDiagonalDown).LineStyle = xlNone
    MiExcell.Selection.Borders(xlDiagonalUp).LineStyle = xlNone
    
    With MiExcell.Selection.Borders(xlEdgeLeft)
        .LineStyle = xlContinuous
        .Weight = xlMedium
        .ColorIndex = xlAutomatic
    End With
    With MiExcell.Selection.Borders(xlEdgeTop)
        .LineStyle = xlContinuous
        .Weight = xlMedium
        .ColorIndex = xlAutomatic
    End With
    With MiExcell.Selection.Borders(xlEdgeBottom)
        .LineStyle = xlContinuous
        .Weight = xlMedium
        .ColorIndex = xlAutomatic
    End With
    With MiExcell.Selection.Borders(xlEdgeRight)
        .LineStyle = xlContinuous
        .Weight = xlMedium
        .ColorIndex = xlAutomatic
    End With
    ''''MiExcell.Selection.Borders(xlInsideVertical).LineStyle = xlNone
    ''''MiExcell.Selection.Borders(xlInsideHorizontal).LineStyle = xlNone
    
    Return
    
CREA_CUADRICULA:
    With MiExcell.Selection.Borders(xlEdgeLeft)
        .LineStyle = xlContinuous
        .Weight = xlThin
        .ColorIndex = xlAutomatic
    End With
    With MiExcell.Selection.Borders(xlEdgeTop)
        .LineStyle = xlContinuous
        .Weight = xlThin
        .ColorIndex = xlAutomatic
    End With
    With MiExcell.Selection.Borders(xlEdgeBottom)
        .LineStyle = xlContinuous
        .Weight = xlThin
        .ColorIndex = xlAutomatic
    End With
    With MiExcell.Selection.Borders(xlEdgeRight)
        .LineStyle = xlContinuous
        .Weight = xlThin
        .ColorIndex = xlAutomatic
    End With
    With MiExcell.Selection.Borders(xlInsideVertical)
'        .LineStyle = xlContinuous
'        .Weight = xlThin
'        .ColorIndex = xlAutomatic
    End With
    With MiExcell.Selection.Borders(xlInsideHorizontal)
        .LineStyle = xlContinuous
        .Weight = xlThin
        .ColorIndex = xlAutomatic
    End With
    
    Return
      
End Sub




Private Sub Form_Load()

    Me.Icon = BacControlFinanciero.Icon
    'Call PROC_LLENA_COMBOS(CmbSistema, 7, False, "S", "N", "")

    Call Proc_Limpiar
End Sub

Private Sub TlbHerramientas_ButtonClick(ByVal Button As MSComctlLib.Button)

    Select Case Button.Index
    
        Case BtnLimpiar
            Call Proc_Limpiar
        
        Case BtnBuscar
            Call Proc_Buscar
          
        Case BtnExcel
            Call Proc_Excel
            
        Case BtnCerrar
            Unload Me
    
    End Select
    
End Sub






Private Sub Proc_Buscar()

    Dim DATOS()

    Screen.MousePointer = vbHourglass
    
    GrdVistaPrevia.Rows = 1

    Envia = Array()
    AddParam Envia, Trim(Txt_Moneda.Text)
    AddParam Envia, -9999
    AddParam Envia, -9999
    AddParam Envia, Trim(Txt_Moneda.Text)
    AddParam Envia, -9999
    AddParam Envia, -9999

    If Not Bac_Sql_Execute("SP_CON_CORRELACIONES_LINEAS", Envia) Then
        Screen.MousePointer = vbDefault
        MsgBox "Ha ocurrido un error al intentar recuperar los factores de correlaciones", vbCritical, TITSISTEMA
        Exit Sub
    Else
        Do While Bac_SQL_Fetch(DATOS())
            'agregar a la busqueda la descripcion de la moneda
            With GrdVistaPrevia
                .Rows = .Rows + 1
                .TextMatrix(.Rows - 1, nColNemMoneda2) = DATOS(nDatNemMoneda2)
                .TextMatrix(.Rows - 1, nColPlazoIni1) = DATOS(nDatPlazo11)
                .TextMatrix(.Rows - 1, nColPlazoFin1) = DATOS(nDatPlazo12)
                .TextMatrix(.Rows - 1, nColPlazoIni2) = DATOS(nDatPlazo21)
                .TextMatrix(.Rows - 1, nColPlazoFin2) = DATOS(nDatPlazo22)
                .TextMatrix(.Rows - 1, nColFactor) = Format(CDbl(DATOS(nDatFactor)), "#,##0.0000")
            End With
        Loop
    End If

    Screen.MousePointer = vbDefault

End Sub


Private Sub Proc_Limpiar()

    With GrdVistaPrevia
        .Rows = 1
        .Cols = 6
    
        .TextMatrix(0, nColNemMoneda2) = "MDA 2"
        .TextMatrix(0, nColPlazoIni1) = "INI 1"
        .TextMatrix(0, nColPlazoFin1) = "FIN 1"
        .TextMatrix(0, nColPlazoIni2) = "INI 2"
        .TextMatrix(0, nColPlazoFin2) = "FIN 2"
        .TextMatrix(0, nColFactor) = "FACTOR"

''''        .RowHeight(0) = 0
''''        .ColWidth(0) = 0
''''        .BackColorBkg = vbBlack
''''        .GridColor = vbBlack
    End With
    
    TlbHerramientas.Buttons(BtnBuscar).Enabled = True
    TlbHerramientas.Buttons(BtnLimpiar).Enabled = True
    TlbHerramientas.Buttons(BtnExcel).Enabled = True

End Sub

Private Sub Txt_Moneda_KeyPress(KeyAscii As Integer)

   If KeyAscii >= vbKey0 And KeyAscii <= vbKey9 Then
      KeyAscii = 0
      Exit Sub
   End If

   If KeyAscii >= 97 Or KeyAscii <= 122 Then
      KeyAscii = Asc(UCase$(Chr$(KeyAscii)))
   End If
   
   If KeyAscii = vbKeyReturn Then
      Proc_Buscar
   End If


End Sub


