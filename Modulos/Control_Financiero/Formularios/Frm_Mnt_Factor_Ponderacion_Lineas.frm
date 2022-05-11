VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{BDC217C8-ED16-11CD-956C-0000C04E4C0A}#1.1#0"; "tabctl32.ocx"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "comdlg32.ocx"
Begin VB.Form Frm_Mnt_Factor_Ponderacion_Lineas 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantencion De Factores De Ponderacion"
   ClientHeight    =   5880
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   5415
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   5880
   ScaleWidth      =   5415
   Begin MSComDlg.CommonDialog Cd_Archivo 
      Left            =   6075
      Top             =   2295
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin TabDlg.SSTab Tab_Tipo 
      Height          =   4650
      Left            =   15
      TabIndex        =   8
      Top             =   1215
      Width           =   5400
      _ExtentX        =   9525
      _ExtentY        =   8202
      _Version        =   393216
      Tabs            =   2
      Tab             =   1
      TabHeight       =   520
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      TabCaption(0)   =   "Tasas"
      TabPicture(0)   =   "Frm_Mnt_Factor_Ponderacion_Lineas.frx":0000
      Tab(0).ControlEnabled=   0   'False
      Tab(0).Control(0)=   "lbl_Moneda(0)"
      Tab(0).Control(1)=   "Label3"
      Tab(0).Control(2)=   "GrdFactor(0)"
      Tab(0).Control(3)=   "txt_Moneda(0)"
      Tab(0).ControlCount=   4
      TabCaption(1)   =   "Divisas"
      TabPicture(1)   =   "Frm_Mnt_Factor_Ponderacion_Lineas.frx":001C
      Tab(1).ControlEnabled=   -1  'True
      Tab(1).Control(0)=   "lbl_Moneda(1)"
      Tab(1).Control(0).Enabled=   0   'False
      Tab(1).Control(1)=   "Label1"
      Tab(1).Control(1).Enabled=   0   'False
      Tab(1).Control(2)=   "GrdFactor(1)"
      Tab(1).Control(2).Enabled=   0   'False
      Tab(1).Control(3)=   "txt_Moneda(1)"
      Tab(1).Control(3).Enabled=   0   'False
      Tab(1).ControlCount=   4
      Begin VB.TextBox txt_Moneda 
         Height          =   300
         Index           =   0
         Left            =   -74055
         MaxLength       =   8
         TabIndex        =   14
         Top             =   480
         Width           =   840
      End
      Begin VB.TextBox txt_Moneda 
         Height          =   300
         Index           =   1
         Left            =   945
         MaxLength       =   8
         TabIndex        =   11
         Top             =   480
         Width           =   840
      End
      Begin MSFlexGridLib.MSFlexGrid GrdFactor 
         Height          =   3660
         Index           =   0
         Left            =   -74970
         TabIndex        =   9
         Top             =   930
         Width           =   5280
         _ExtentX        =   9313
         _ExtentY        =   6456
         _Version        =   393216
         GridLines       =   2
      End
      Begin MSFlexGridLib.MSFlexGrid GrdFactor 
         Height          =   3660
         Index           =   1
         Left            =   30
         TabIndex        =   10
         Top             =   930
         Width           =   5280
         _ExtentX        =   9313
         _ExtentY        =   6456
         _Version        =   393216
         GridLines       =   2
      End
      Begin VB.Label Label3 
         Caption         =   "Moneda"
         Height          =   255
         Left            =   -74805
         TabIndex        =   16
         Top             =   510
         Width           =   690
      End
      Begin VB.Label lbl_Moneda 
         BorderStyle     =   1  'Fixed Single
         Height          =   300
         Index           =   0
         Left            =   -73155
         TabIndex        =   15
         Top             =   480
         Width           =   3435
      End
      Begin VB.Label Label1 
         Caption         =   "Moneda"
         Height          =   255
         Left            =   195
         TabIndex        =   13
         Top             =   510
         Width           =   690
      End
      Begin VB.Label lbl_Moneda 
         BorderStyle     =   1  'Fixed Single
         Height          =   300
         Index           =   1
         Left            =   1845
         TabIndex        =   12
         Top             =   480
         Width           =   3435
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "Opcion de generacion para archivo Excel"
      ForeColor       =   &H00C00000&
      Height          =   630
      Left            =   15
      TabIndex        =   5
      Top             =   555
      Width           =   5400
      Begin VB.OptionButton Op_Exportar 
         Caption         =   "Exportar hacia Excel"
         Height          =   315
         Left            =   135
         TabIndex        =   6
         Top             =   240
         Width           =   2190
      End
      Begin VB.OptionButton Op_Importar 
         Caption         =   "Importar desde Excel"
         Height          =   255
         Left            =   3045
         TabIndex        =   7
         Top             =   240
         Width           =   1935
      End
   End
   Begin VB.Frame FrParametros 
      Caption         =   "Parametros"
      ForeColor       =   &H00800000&
      Height          =   600
      Left            =   5775
      TabIndex        =   2
      Top             =   720
      Width           =   5400
      Begin VB.ComboBox CmbSistema 
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   1095
         Style           =   2  'Dropdown List
         TabIndex        =   0
         Top             =   180
         Visible         =   0   'False
         Width           =   4080
      End
      Begin VB.Frame FrDuration 
         Caption         =   "Duration"
         ForeColor       =   &H00800000&
         Height          =   825
         Left            =   135
         TabIndex        =   3
         Top             =   1770
         Width           =   5220
      End
      Begin VB.Label Label9 
         Caption         =   "Sistema"
         ForeColor       =   &H00800000&
         Height          =   270
         Left            =   75
         TabIndex        =   4
         Top             =   255
         Width           =   945
      End
   End
   Begin MSComctlLib.Toolbar TlbHerramientas 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   1
      Top             =   0
      Width           =   5415
      _ExtentX        =   9551
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImlBotones"
      HotImageList    =   "ImlBotones"
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
            Object.ToolTipText     =   "Importa / Exporta a Excel"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Cerrar Ventana"
            ImageIndex      =   6
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImlBotones 
         Left            =   5460
         Top             =   -45
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   22
         ImageHeight     =   22
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   6
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Mnt_Factor_Ponderacion_Lineas.frx":0038
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Mnt_Factor_Ponderacion_Lineas.frx":0F12
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Mnt_Factor_Ponderacion_Lineas.frx":1DEC
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Mnt_Factor_Ponderacion_Lineas.frx":2CC6
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Mnt_Factor_Ponderacion_Lineas.frx":3BA0
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Mnt_Factor_Ponderacion_Lineas.frx":4A7A
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
End
Attribute VB_Name = "Frm_Mnt_Factor_Ponderacion_Lineas"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit


Const BtnLimpiar = 1
Const BtnBuscar = 2
Const BtnGrabar = 3
Const BtnEliminar = 4
Const BtnExcel = 5
Const BtnCerrar = 6

'Constante de Grilla GrdFactor
Const nColPlazo = 0
Const nColFactor = 1

' Constantes de retorno de procedimiento SP_CON_FACTOR_PONDERACION_LINEAS
Const nSistema = 1
Const nMoneda = 2
Const nPlazo = 3
Const nFactor = 4
''''Const nFactorMlMx = 5
Const nDesMon = 5
Const nGlosaMon = 6

Dim nContador   As Long
Private Sub Proc_Buscar()

    Dim DATOS()
    
''''    If CmbSistema.ListIndex = -1 Then
''''        MsgBox "Debe seleccionar un sistema", vbExclamation, TITSISTEMA
''''        CmbSistema.SetFocus
''''        Exit Sub
''''    ElseIf CmbMoneda.ListIndex = -1 Then
''''        MsgBox "Debe seleccionar una moneda", vbExclamation, TITSISTEMA
''''        CmbMoneda.SetFocus
''''        Exit Sub
''''    End If

    If Trim(txt_Moneda(Tab_Tipo.Tab)) = "" Then
       Screen.MousePointer = vbDefault
       MsgBox "Debe ingresar un nemotecnico de moneda para la busqueda de los factores de ponderacion.", vbExclamation + vbOKOnly
       Exit Sub
    End If
    
    Screen.MousePointer = vbHourglass
    
    GrdFactor(Tab_Tipo.Tab).Rows = 1
    
    Envia = Array()
    AddParam Envia, "PCS"
    AddParam Envia, txt_Moneda(Tab_Tipo.Tab)
    AddParam Envia, IIf(Tab_Tipo.Tab = 0, "T", "D")
    
''''    AddParam Envia, Trim(Right(CmbSistema.Text, 10))
''''    AddParam Envia, Trim(Right(CmbMoneda.Text, 10))
    
    If Not Bac_Sql_Execute("SP_CON_FACTOR_PONDERACION_LINEAS", Envia) Then
        Screen.MousePointer = vbDefault
        MsgBox "Ha ocurrido un error al intentar recuperar los factores de ponderacion", vbCritical, TITSISTEMA
        Exit Sub
    Else
        Do While Bac_SQL_Fetch(DATOS())
            If DATOS(nMoneda) = -999 Then
                  Screen.MousePointer = vbDefault
                  MsgBox "Moneda no registrada en el sistema", vbExclamation + vbOKOnly
                  Exit Sub
            End If
        
            With GrdFactor(Tab_Tipo.Tab)
                .Rows = .Rows + 1
                .Row = .Rows - 1
                .RowHeight(.Row) = 270
                                
                .TextMatrix(.Row, nColPlazo) = DATOS(nPlazo)
                '.TextMatrix(.Row, nColFactor) = Format((DATOS(nFactor) * 100), "#,##0.00")
                'MAP 20080703 Mostrar como biene en la Base de datos
                .TextMatrix(.Row, nColFactor) = Format((DATOS(nFactor)), "#,##0.00")
                lbl_Moneda(Tab_Tipo.Tab).Caption = DATOS(nGlosaMon)
            End With
        Loop
        
        FrParametros.Enabled = False
        
    End If
    
    Screen.MousePointer = vbDefault

End Sub

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



Sub PROC_EXPORTA_EXCEL()
    Dim nFila1      As Long
    Dim nFila2      As Long
    Dim ruta        As String
    Dim Crea_xls    As Boolean
    Dim retorno     As Double
    Dim oDatos()
    Dim MiExcell         ''''As New EXCEL.Application
    Dim MiLibro          ''''As New EXCEL.Workbook
    Dim MiHoja           ''''As New EXCEL.Worksheet
    Dim MiSheet          As Object
    Dim ExcelActivo      As Boolean
    
    On Error GoTo CONTROLA_ERROR

    Screen.MousePointer = vbHourglass

    If MsgBox("¿ Seguro que desea generar la planilla excel para los factores de ponderacion ?", vbQuestion + vbYesNo) = vbNo Then
        Screen.MousePointer = vbDefault
        Exit Sub
    End If
        
    Cd_Archivo.CancelError = True
    Cd_Archivo.FileName = ""
    Cd_Archivo.Filter = "Archivo Factor de Ponderacion *.xls"
    Cd_Archivo.DialogTitle = "Exportar Archivo Factor de Ponderacion"
    Cd_Archivo.ShowSave
       
    DoEvents
    
    If Dir(Cd_Archivo.FileName) <> "" Then
       If MsgBox("Archivo ya existe, desea reemplazar el archivo", vbQuestion + vbYesNo) = vbNo Then
          Screen.MousePointer = vbDefault
          Cd_Archivo.FileName = ""
          Exit Sub
       Else
          Call Kill(Cd_Archivo.FileName)
       End If
    End If
  
    Set MiExcell = CreateObject("Excel.Application")
    Set MiLibro = MiExcell.Application.Workbooks.Add
    Set MiHoja = MiLibro.Sheets(1)
    Set MiSheet = MiExcell.ActiveSheet
    
    ExcelActivo = True
    
    MiExcell.DisplayAlerts = False
    MiExcell.Worksheets(3).Delete
    MiExcell.DisplayAlerts = True
        
    MiLibro.Sheets("Hoja1").Name = "TBL_POND_TASAS"
    MiLibro.Sheets("Hoja2").Name = "TBL_POND_DIVISAS"
           
    '******************************************************************
    '*********************** CABECERAS ********************************
    '******************************************************************
    MiLibro.Worksheets("TBL_POND_TASAS").Cells(1, "A") = "MONEDA"
    MiLibro.Worksheets("TBL_POND_TASAS").Cells(1, "B") = "PLAZO"
    MiLibro.Worksheets("TBL_POND_TASAS").Cells(1, "C") = "PONDERADOR TASA"
   
    MiLibro.Worksheets("TBL_POND_DIVISAS").Cells(1, "A") = "MONEDA"
    MiLibro.Worksheets("TBL_POND_DIVISAS").Cells(1, "B") = "PLAZO"
    MiLibro.Worksheets("TBL_POND_DIVISAS").Cells(1, "C") = "PONDERADOR TASA"
    
    MiLibro.Worksheets("TBL_POND_TASAS").Columns("C:C").EntireColumn.AutoFit
    MiLibro.Worksheets("TBL_POND_DIVISAS").Columns("C:C").EntireColumn.AutoFit
   
    nFila1 = 2
    nFila2 = 2
   
    For nContador = 1 To 2
   
      Envia = Array()
      AddParam Envia, "PCS"
      AddParam Envia, ""
      AddParam Envia, IIf(nContador = 1, "T", "D")
      
      If Not Bac_Sql_Execute("SP_CON_FACTOR_PONDERACION_LINEAS ", Envia) Then
        GoSub CIERRA_EXCEL
        Screen.MousePointer = vbDefault
        MsgBox "Ha ocurrido un error al intentar rescatar informacion para la generacion de la planilla excel", vbCritical, gsBac_Version
        Exit Sub
      End If
    
      Do While Bac_SQL_Fetch(oDatos())
         If nContador = 1 Then
            MiLibro.Worksheets("TBL_POND_TASAS").Activate
            MiLibro.Worksheets("TBL_POND_TASAS").Cells(nFila1, "A") = oDatos(nDesMon)
            MiLibro.Worksheets("TBL_POND_TASAS").Cells(nFila1, "B") = Str(oDatos(nPlazo))
            MiLibro.Worksheets("TBL_POND_TASAS").Cells(nFila1, "C") = Str(Format(oDatos(nFactor), "#,##0.0#################"))
            nFila1 = nFila1 + 1
         ElseIf nContador = 2 Then
            MiLibro.Worksheets("TBL_POND_DIVISAS").Activate
            MiLibro.Worksheets("TBL_POND_DIVISAS").Cells(nFila2, "A") = oDatos(nDesMon)
            MiLibro.Worksheets("TBL_POND_DIVISAS").Cells(nFila2, "B") = Str(oDatos(nPlazo))
            MiLibro.Worksheets("TBL_POND_DIVISAS").Cells(nFila2, "C") = Str(Format$(oDatos(nFactor), "#,##0.0#################"))
            nFila2 = nFila2 + 1
         End If
               
         Crea_xls = True
      
       Loop
    Next nContador
   
    MiLibro.Worksheets("TBL_POND_DIVISAS").Activate
    MiLibro.Worksheets("TBL_POND_DIVISAS").Range("B2").Select
    MiLibro.Worksheets("TBL_POND_DIVISAS").Range(MiExcell.Selection, MiExcell.Selection.End(xlDown)).Select
    MiExcell.Selection.NumberFormat = "General"
    
    With MiExcell.Selection
        .HorizontalAlignment = xlRight
        .VerticalAlignment = xlBottom
        .WrapText = False
        .Orientation = 0
        .AddIndent = False
        .ShrinkToFit = False
        .MergeCells = False
    End With
   
    MiLibro.Worksheets("TBL_POND_DIVISAS").Activate
    MiLibro.Worksheets("TBL_POND_DIVISAS").Range("C2").Select
    MiLibro.Worksheets("TBL_POND_DIVISAS").Range(MiExcell.Selection, MiExcell.Selection.End(xlDown)).Select
    MiExcell.Selection.NumberFormat = "General"
    With MiExcell.Selection
        .HorizontalAlignment = xlRight
        .VerticalAlignment = xlBottom
        .WrapText = False
        .Orientation = 0
        .AddIndent = False
        .ShrinkToFit = False
        .MergeCells = False
    End With
    
    GoSub FORMATEA_EXCEL
    
    MiLibro.Worksheets("TBL_POND_DIVISAS").Range("A2").Select
   
    MiLibro.Worksheets("TBL_POND_TASAS").Activate
    MiLibro.Worksheets("TBL_POND_TASAS").Range("B2").Select
    MiLibro.Worksheets("TBL_POND_TASAS").Range(MiExcell.Selection, MiExcell.Selection.End(xlDown)).Select
    MiExcell.Selection.NumberFormat = "General"
    With MiExcell.Selection
        .HorizontalAlignment = xlRight
        .VerticalAlignment = xlBottom
        .WrapText = False
        .Orientation = 0
        .AddIndent = False
        .ShrinkToFit = False
        .MergeCells = False
    End With
       
    MiLibro.Worksheets("TBL_POND_TASAS").Activate
    MiLibro.Worksheets("TBL_POND_TASAS").Range("C2").Select
    MiLibro.Worksheets("TBL_POND_TASAS").Range(MiExcell.Selection, MiExcell.Selection.End(xlDown)).Select
    MiExcell.Selection.NumberFormat = "General"
    With MiExcell.Selection
        .HorizontalAlignment = xlRight
        .VerticalAlignment = xlBottom
        .WrapText = False
        .Orientation = 0
        .AddIndent = False
        .ShrinkToFit = False
        .MergeCells = False
    End With
    
    GoSub FORMATEA_EXCEL
   
    MiLibro.Worksheets("TBL_POND_DIVISAS").Activate
    MiLibro.Worksheets("TBL_POND_DIVISAS").Range("A2").Select

    MiLibro.Worksheets("TBL_POND_TASAS").Activate
    MiLibro.Worksheets("TBL_POND_TASAS").Range("A2").Select

    If Crea_xls Then
        MiExcell.DisplayAlerts = False
        MiHoja.SaveAs (Cd_Archivo.FileName)
        MiExcell.DisplayAlerts = True
    Else
        GoSub CIERRA_EXCEL

        MousePointer = vbDefault
        MsgBox "No se encontró Información para generar el Excel", vbExclamation, gsBac_Version
        Exit Sub
    End If
              
    'GoSub CIERRA_EXCEL  MAP 20080703
  
    Screen.MousePointer = vbDefault
    MsgBox "El archivo excel con los factores de ponderacion ha sido generado con exito", vbInformation, gsBac_Version
     
    'MAP 20080703 No funciona en todas las instalaciones
    'retorno = Shell(gsBac_Office & "EXCEL.EXE  " & """" & Cd_Archivo.FileName & """", vbMaximizedFocus)
                  
    'GoSub CIERRA_EXCEL MAP 20080703
 
   
    'MAP 20080703
    MiLibro.Activate
    MiLibro.Application.Visible = True 'MAP 20080702 Para ver lo que va en el Excel y no usar Shell
    
    
    Exit Sub
    
CIERRA_EXCEL:
      MiExcell.DisplayAlerts = False
      MiHoja.Application.Workbooks.Close
      MiExcell.Application.Workbooks.Close
      MiExcell.Application.Quit
      
''''      MiLibro.Close
''''      MiExcell.Visible = False
''''      MiExcell.Quit
      
      Set MiExcell = Nothing
      Set MiLibro = Nothing
      Set MiHoja = Nothing
      Return
      
CONTROLA_ERROR:
      Screen.MousePointer = vbDefault
      
      If Err.Number = cdlCancel Then
         Exit Sub
      End If
     
      MsgBox CStr(Err.Number) + vbCrLf + Err.Description, vbExclamation + vbOKOnly
      
      If ExcelActivo = True Then
         GoSub CIERRA_EXCEL
      End If

      Exit Sub
      
FORMATEA_EXCEL:

    MiExcell.Range("A1:C1").Select
    With MiExcell.Selection.Interior
        .ColorIndex = 1
        .Pattern = xlSolid
    End With
    MiExcell.Selection.Font.ColorIndex = 2
    MiExcell.Range("A2").Select
    MiExcell.Range(MiExcell.Selection, MiExcell.ActiveCell.SpecialCells(xlLastCell)).Select
    MiExcell.Selection.Borders(xlDiagonalDown).LineStyle = xlNone
    MiExcell.Selection.Borders(xlDiagonalUp).LineStyle = xlNone
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
    MiExcell.Columns("C:C").EntireColumn.AutoFit

    Return
      
      
End Sub



Private Sub PROC_IMPORTAR_EXCEL()
      
   Dim sNombre$
   Dim xlApp        ''''As EXCEL.Application
   Dim xlBook       ''''As EXCEL.Workbook
   Dim xlSheet      ''''As EXCEL.Worksheet
   Dim iRow         As Integer
   Dim xRow         As Integer
   Dim bTransaccion As Boolean
   Dim cMoneda      As String
   Dim nPlazo       As Double
   Dim nFactor      As Double
   Dim nFactorMlMx  As Double
        
   On Error GoTo LISTA_ERROR
      
   Cd_Archivo.CancelError = True
   Cd_Archivo.FileName = ""
   Cd_Archivo.Filter = "Archivo Factor de Ponderacion *.xls"
   Cd_Archivo.DialogTitle = "Importar Archivo Factor de Ponderacion"
   Cd_Archivo.ShowOpen
   
   Screen.MousePointer = vbHourglass
   
    If Not Bac_Sql_Execute("BEGIN TRANSACTION") Then
        Screen.MousePointer = vbDefault
        MsgBox "Ha ocurrido un error al intentar grabar los factores de ponderacion - BEGIN TRANSACTION", vbCritical, TITSISTEMA
        Exit Sub
    End If
    
    bTransaccion = True
        
    Envia = Array()
    AddParam Envia, "PCS" ''''Trim(Right(CmbSistema.Text, 10)) -- SE RESTRINGE SOLO PARA PCS Y FWD
    ''''AddParam Envia, Trim(Right(CmbMoneda.Text, 10))

    If Not Bac_Sql_Execute("SP_DEL_FACTOR_PONDERACION_LINEAS", Envia) Then
        Call Bac_Sql_Execute("ROLLBACK TRANSACTION")
        Screen.MousePointer = vbDefault
        MsgBox "Ha ocurrido un error al intentar grabar los factores de ponderacion (1)", vbCritical, TITSISTEMA
        GoTo CIERRA_EXCEL
    End If

   Set xlApp = CreateObject("Excel.Application")
   Set xlBook = xlApp.Workbooks.Open(Cd_Archivo.FileName)
        
   For nContador = 0 To Tab_Tipo.Tabs - 1
   
      If nContador = 0 Then
         Set xlSheet = xlApp.Worksheets("TBL_POND_TASAS")
      Else
         Set xlSheet = xlApp.Worksheets("TBL_POND_DIVISAS")
      End If
      
      For xRow = 2 To xlSheet.Columns.End(xlDown).Row
         cMoneda = Func_Leer_Celda(xlSheet, "A" & LTrim(Str(xRow)))
         nPlazo = Format(Func_Leer_Celda(xlSheet, "B" & LTrim(Str(xRow))), "#,##0.0000")
         nFactor = Format(Func_Leer_Celda(xlSheet, "C" & LTrim(Str(xRow))), "#,##0.####################")
''''         nFactorMlMx = IIf(nContador = 0, 0, Format(Func_Leer_Celda(xlSheet, "C" & LTrim(Str(xRow))), "#,##0.####################"))
         
         Envia = Array()
         AddParam Envia, "PCS" ''''Trim(Right(CmbSistema.Text, 10))
         AddParam Envia, cMoneda ''''Trim(Right(CmbMoneda.Text, 10))
         AddParam Envia, nPlazo ''''Int(.TextMatrix(nContador, ColCodigo))
         AddParam Envia, nFactor ''''(.TextMatrix(nContador, ColFactorPond) / 100)
''''         AddParam Envia, nFactorMlMx ''''(.TextMatrix(nContador, ColFactorPondDiv) / 100)
         AddParam Envia, IIf(nContador = 0, "T", "D")
         
         If Not Bac_Sql_Execute("SP_ACT_FACTOR_PONDERACION_LINEAS", Envia) Then
             Call Bac_Sql_Execute("ROLLBACK TRANSACTION")
             Screen.MousePointer = vbDefault
             MsgBox "Ha ocurrido un error al intentar grabar los factores de ponderacion", vbCritical, TITSISTEMA
             GoTo CIERRA_EXCEL
         End If
   ''''               Pnl_Avance.FloodPercent = (nRegAct * 100) / nTotalReg
      Next xRow
   Next nContador
   
   If Not Bac_Sql_Execute("COMMIT TRANSACTION") Then
      Screen.MousePointer = vbDefault
      MsgBox "Ha ocurrido un error al intentar grabar los factores de ponderacion - COMMIT TRANSACTION", vbCritical, TITSISTEMA
      GoTo CIERRA_EXCEL
   End If
     
   xlBook.Close
   xlApp.Visible = False
   xlApp.Quit

   Set xlApp = Nothing
   Set xlBook = Nothing
   Set xlSheet = Nothing

''''   Pnl_Avance.FloodPercent = 0
   Screen.MousePointer = vbDefault
   
   MsgBox "Proceso de carga de factores de ponderacion desde planilla excel ha finalizado con exito", vbInformation, TITSISTEMA

Exit Sub
LISTA_ERROR:

Screen.MousePointer = vbDefault

   If Err.Number = cdlCancel Then
      Exit Sub
   Else
      If bTransaccion = True Then
         Call Bac_Sql_Execute("ROLLBACK TRANSACTION")
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

End Sub


Private Function Func_Leer_Celda(ByVal objSheet As Object, sCelda As String) As Variant  'Double
   Dim nColumna      As Integer
   Dim nFila         As Integer
   
   nColumna = Asc(Mid$(UCase(sCelda), 1, 1)) - 64
   nFila = Val(Trim(Mid$(sCelda, 2, 5)))
   
   If nColumna = 1 Or nColumna = 3 Or nColumna = 13 Or nColumna = 2 Then
      Func_Leer_Celda = objSheet.Cells(nFila, nColumna)
   Else
      Func_Leer_Celda = CDbl(objSheet.Cells(nFila, nColumna))
   End If

End Function
Private Sub Proc_Limpiar()

   For nContador = 0 To Tab_Tipo.Tabs - 1
    With GrdFactor(nContador)
        .Rows = 1
        .Cols = 2
    
        .TextMatrix(0, nColPlazo) = "PLAZO EN AÑOS"
        .TextMatrix(0, nColFactor) = "% POND"
                
        .FixedCols = 1
        
        .BackColorFixed = ColorVerde
        .ForeColorFixed = ColorBlanco
        
        .RowHeight(0) = 350
                
        .ColWidth(nColPlazo) = 2000
        .ColWidth(nColFactor) = 2500
        
        .ColAlignment(nColPlazo) = flexAlignCenterCenter
    End With
   Next nContador
   
    Tab_Tipo.Tab = 0

    CmbSistema.ListIndex = -1
    FrParametros.Enabled = True
    
    TlbHerramientas.Buttons(BtnBuscar).Enabled = True
    TlbHerramientas.Buttons(BtnGrabar).Enabled = False
    TlbHerramientas.Buttons(BtnEliminar).Enabled = False

End Sub

Private Sub Form_Load()

    Me.Icon = BacControlFinanciero.Icon
    Call PROC_LLENA_COMBOS(CmbSistema, 7, False, "S", "N", "")
    ''''Call PROC_LLENA_COMBOS(CmbMoneda, 8, False, "", "2", "3")
    
    Call Proc_Limpiar

End Sub




Private Sub GrdFactor_DblClick(Index As Integer)
''''    With GrdFactor
''''        If .Rows > 1 Then
''''            If .Col = ColFactorPond Or .Col = ColFactorPondDiv Then
''''                Call Proc_Setea_TxnFactor(GrdFactor)
''''                Call PROC_POSICIONA_TEXTO(GrdFactor, TxnFactor)
''''                TxnFactor.Text = .TextMatrix(.Row, .Col)
''''                TxnFactor.Visible = True
''''                TxnFactor.MarcaTexto = True
''''                TxnFactor.SetFocus
''''            End If
''''        End If
''''    End With
    
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



Private Sub Txt_Moneda_KeyPress(Index As Integer, KeyAscii As Integer)

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


