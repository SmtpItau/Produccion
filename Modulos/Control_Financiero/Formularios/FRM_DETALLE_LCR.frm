VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "Msflxgrd.ocx"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "comdlg32.ocx"
Begin VB.Form FRM_DETALLE_LCR 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Detalle LCR"
   ClientHeight    =   5580
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   10455
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   5580
   ScaleWidth      =   10455
   Begin VB.Frame Frame1 
      Height          =   4920
      Left            =   75
      TabIndex        =   0
      Top             =   600
      Width           =   10335
      Begin VB.Frame Frame2 
         ForeColor       =   &H00800000&
         Height          =   1455
         Left            =   135
         TabIndex        =   2
         Top             =   120
         Width           =   10125
         Begin VB.OptionButton Opt_Opcion 
            Caption         =   "Matriz Covarianza"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00C00000&
            Height          =   375
            Index           =   1
            Left            =   6480
            TabIndex        =   12
            Top             =   840
            Width           =   2115
         End
         Begin VB.OptionButton Opt_Opcion 
            Caption         =   "Mtm Carteras"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00C00000&
            Height          =   255
            Index           =   7
            Left            =   4560
            TabIndex        =   10
            Top             =   870
            Width           =   1635
         End
         Begin BACControles.TXTNumero txtExpMax 
            Height          =   345
            Left            =   7620
            TabIndex        =   9
            Top             =   360
            Width           =   2340
            _ExtentX        =   4128
            _ExtentY        =   609
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Text            =   "0"
            Text            =   "0"
            Separator       =   -1  'True
            MarcaTexto      =   -1  'True
         End
         Begin VB.OptionButton Opt_Opcion 
            Caption         =   "Rec"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00C00000&
            Height          =   225
            Index           =   6
            Left            =   4545
            TabIndex        =   7
            Top             =   450
            Width           =   825
         End
         Begin VB.OptionButton Opt_Opcion 
            Caption         =   "Exposición Actual"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00C00000&
            Height          =   225
            Index           =   4
            Left            =   2715
            TabIndex        =   6
            Top             =   435
            Width           =   1815
         End
         Begin VB.OptionButton Opt_Opcion 
            Caption         =   "AddOn "
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00C00000&
            Height          =   225
            Index           =   3
            Left            =   2730
            TabIndex        =   5
            Top             =   900
            Width           =   1080
         End
         Begin VB.OptionButton Opt_Opcion 
            Caption         =   "Threshold "
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00C00000&
            Height          =   225
            Index           =   2
            Left            =   255
            TabIndex        =   4
            Top             =   900
            Width           =   1335
         End
         Begin VB.OptionButton Opt_Opcion 
            Caption         =   "AddOn90d y Var por OP"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00C00000&
            Height          =   225
            Index           =   0
            Left            =   240
            TabIndex        =   3
            Top             =   420
            Width           =   2265
         End
         Begin VB.Label lblExpMax 
            Caption         =   "Exposición Maxima"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00C00000&
            Height          =   210
            Left            =   5790
            TabIndex        =   8
            Top             =   465
            Width           =   1680
         End
      End
      Begin MSFlexGridLib.MSFlexGrid Grd_Datos 
         Height          =   2940
         Left            =   135
         TabIndex        =   1
         Top             =   1740
         Width           =   10065
         _ExtentX        =   17754
         _ExtentY        =   5186
         _Version        =   393216
         Cols            =   13
         FixedCols       =   0
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   11
      Top             =   0
      Width           =   10455
      _ExtentX        =   18441
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Generar"
            Object.ToolTipText     =   "Exportar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   5
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComDlg.CommonDialog Command 
         Left            =   5025
         Top             =   30
         _ExtentX        =   847
         _ExtentY        =   847
         _Version        =   393216
      End
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   7215
         Top             =   30
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
               Picture         =   "FRM_DETALLE_LCR.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_DETALLE_LCR.frx":0EDA
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_DETALLE_LCR.frx":1DB4
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_DETALLE_LCR.frx":2C8E
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_DETALLE_LCR.frx":3B68
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_DETALLE_LCR.frx":3E82
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
End
Attribute VB_Name = "FRM_DETALLE_LCR"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
    Public Rut As Long
    Public CodCli As Long
    Public Det_Cliente_LCR As String
    Public Det_Metodologia_LCR As Integer
    Public Det_Threshold_LCR As Double
    Public Det_MsgError As String






Private Function Func_Rescata_metodologia(Rut As Long, CodCli As Integer)
    Dim DATOS()

    Envia = Array()
    AddParam Envia, CDbl(Rut)
    AddParam Envia, CDbl(CodCli)
    AddParam Envia, -1
    AddParam Envia, ""
   
    'PROD-10967
    If Not Bac_Sql_Execute("BacSwapSuda..SP_LEER_CLIENTE", Envia) Then
        Exit Function
    End If
            
   
     
    If Bac_SQL_Fetch(DATOS()) Then
    
        clrut = Val(DATOS(1))
        cldv = DATOS(2)
        clcodigo = Val(DATOS(3))
        clnombre = UCase(DATOS(4))
        cldireccion = UCase(DATOS(5))
        clcomuna = Val(DATOS(6))
        clfono = DATOS(8)
        clfax = DATOS(9)
        cltipocliente = Val(DATOS(10))
        clciudad = DATOS(11)
        clregion = Val(DATOS(12))
        clPais = Val(DATOS(13))
        clfecha_escritura = DATOS(14)
        clnotaria = DATOS(15)
        clfecha_cond_generales = DATOS(16)
        clciudadglosa = DATOS(18)
        clcomunaglosa = DATOS(17)
        clUtilizaNuevoCgg = IIf(DATOS(19) = "S", True, False)
        clFechaNuevoCgg = DATOS(20)
        clThreshold = DATOS(21)
        clMetodologia_LCR = DATOS(22)
       
        Func_Rescata_metodologia = clMetodologia_LCR
    End If

End Function

Private Sub Habilitacontroles()
    lblExpMax.Visible = False
    txtExpMax.Visible = False
End Sub
Private Sub Form_Load()
    
    Grd_Datos.Rows = 1
    'Screen.MousePointer = vbDefault
    Call Habilitacontroles
    
    'PRD 21119 - Consumo de Línea derivados ComDer cambio de label
    If gsc_Parametros.iMetodologia = 6 Then
      Opt_Opcion(0).Caption = "AddOn3d y Var por OP"
    End If
    ' Check en radio button REC al abrir popUp
      Opt_Opcion(6).Value = True
    
   
    Grd_Datos.Rows = 1
    Calculorec 6
    Call Habilitacontroles
    Screen.MousePointer = vbDefault
    EjecutaBtnREC = True
  
 End Sub

Private Sub Calculorec(Num As Integer)

    Dim Cartera_Aux As Negociacion   'Se elige uno cualquiera

    Screen.MousePointer = vbDefault
    
 '   PROD-10967
 '   If BacLinCreGen3.SSTab1.Tab = 0 Then
 '       Rut = BacLinCreGen3.TxtRut.Text
 '       CodCli = BacLinCreGen3.TxtCodCli.Text
 '       Det_Cliente_LCR = BacLinCreGen3.LabNombre.Caption
 '       Det_Threshold_LCR = BacLinCreGen3.TxtMtoThresHold.Text
 '   End If
 '   PROD-10967
    
 '   If BacLinCreGen3.SSTab1.Tab = 1 Then
 '       Rut = BacLinCreGen3.TxtRut2.Text
 '       CodCli = BacLinCreGen3.TxtCodCli2.Text
 '       Det_Cliente_LCR = BacLinCreGen3.LabNombre2.Caption
 '       Det_Threshold_LCR = BacLinCreGen3.TXTMtoThresHold2.Text
 '   End If

 '   Det_Metodologia_LCR = BacLinCreGen3.Metodologia_LCR 'PROD-10967
   
    
        
   
    Let ResultadoREC = ProcesoCalculoREC(Rut, CodCli, Det_Cliente_LCR _
                                                     , Cartera_Aux _
                                                     , "ControlFinanciero" _
                                                    , Det_Threshold_LCR _
                                                    , Det_Metodologia_LCR _
                                                    , Det_MsgError, Num)

                               
End Sub

Private Sub Carga_Grilla_Threshold()
     Dim DATOS()
'    Dim iRut As Long
'    Dim iCodigo As Integer
'    iRut = RutSinDV(BacGrabar.TXTRut.Text)
'    iCodigo = CInt(BacGrabar.txtCliente.Tag)
'    iCliente = BacGrabar.txtCliente.Text
     
    With Grd_Datos
        .Rows = 2:          .FixedRows = 1
        .Cols = 13:         .FixedCols = 0
    
        .Font.Name = "Tahoma"
        .Font.Size = 8
        .RowHeightMin = 315
        .TextMatrix(0, 0) = "Rut"
        .TextMatrix(0, 1) = "Codigo"
        .TextMatrix(0, 2) = "Threshold"
        .TextMatrix(0, 3) = "Metodologia"
        .TextMatrix(0, 4) = "Cliente"
        .TextMatrix(0, 5) = ""
        .TextMatrix(0, 6) = ""
        .TextMatrix(0, 7) = ""
        .TextMatrix(0, 8) = ""
        .TextMatrix(0, 9) = ""
        .TextMatrix(0, 10) = ""
        .TextMatrix(0, 11) = ""
        .TextMatrix(0, 12) = ""
               
        .ColWidth(0) = 1500
        .ColWidth(1) = 1500
        .ColWidth(2) = 1500
        .ColWidth(3) = 1500
        .ColWidth(4) = 2000
        .ColWidth(5) = 0
        .ColWidth(6) = 0
        .ColWidth(7) = 0
        .ColWidth(8) = 0
        .ColWidth(9) = 0
        .ColWidth(10) = 0
        .ColWidth(11) = 0
        .ColWidth(12) = 0
        .Rows = .Rows - 1
              
        .Rows = .Rows + 1
           
        .TextMatrix(.Rows - 1, 0) = Rut
        .TextMatrix(.Rows - 1, 1) = CodCli
        .TextMatrix(.Rows - 1, 2) = Format(CDbl(Det_Threshold_LCR), "###0")
        .TextMatrix(.Rows - 1, 3) = Det_Metodologia_LCR
        .TextMatrix(.Rows - 1, 4) = Det_Cliente_LCR
        
        If .Rows > 1 Then
            .AllowUserResizing = flexResizeColumns
        Else
            .AllowUserResizing = flexResizeNone
        End If
        
        For nContador = 0 To .Cols - 1
            .Row = 0
            .Col = nContador
            .TextStyle = TextStyleHeader
            .CellAlignment = flexAlignCenterCenter
            .WordWrap = True
        Next nContador
    End With
End Sub
Private Function RutSinDV(ByVal recRut As String) As String
Dim p As Integer
Dim l As Integer
Dim I As Integer
Dim xRut As String
RutSinDV = ""
xRut = Trim(recRut)
l = Len(xRut)
p = 0
For I = l To 1 Step -1
    If Mid$(xRut, I, 1) = "-" Then
        p = I
        Exit For
    End If
Next
If p = 0 Then
    RutSinDV = xRut
Else
    RutSinDV = Mid$(xRut, 1, p - 1)
End If
End Function
Private Sub Proc_Genera_Excel()
   On Error GoTo ErrorAction
   Dim I  As Long
   Dim cFile      As String
   Dim nFilas     As Long
   Dim MiFila     As Long
   Dim MiSheet    As Object
   Dim Respalda   As Boolean
   Dim DATOS()
   Dim MiExcell As Object
   
   Respalda = False
   
   If Grd_Datos.Rows = 1 Then
        MsgBox "No existen datos a exportar", vbInformation
        Exit Sub
   End If
   
   Screen.MousePointer = vbHourglass
   cFile = App.Path & "\RescataCartera.xlsx"
   cFile = "Vaciado.xlsx"
   Command.Filter = ".xlsx"
   Command.CancelError = True

   Set MiExcell = CreateObject("Excel.Application")
   MiExcell.Application.Workbooks.Close
   Set MiLibro = MiExcell.Application.Workbooks.Add
   Set MiHoja = MiLibro.Sheets.Add
   Set MiSheet = MiExcell.Worksheets(1) '--> MiExcell.ActiveSheet
   MiSheet.Name = "Carteras"
   
   MiExcell.DisplayAlerts = False
   Call MiExcell.Worksheets(3).Delete
   Call MiExcell.Worksheets(2).Delete
   MiExcell.DisplayAlerts = True
      
    With Grd_Datos
        Num_Flujos = .Rows - 1
        For I = 0 To Num_Flujos
            If Num_Flujos > 0 Then
                Let MiFila = MiFila + 1
                If I = 0 Then
                    MiHoja.Cells(MiFila, 1) = .TextMatrix(I, 0)
                ElseIf Opt_Opcion(4).Value = True Or _
                       Opt_Opcion(7).Value = True Or _
                       Opt_Opcion(6).Value = True Then
                       
                    MiHoja.Cells(MiFila, 1) = CDate(.TextMatrix(I, 0))
                
                Else
                    MiHoja.Cells(MiFila, 1) = .TextMatrix(I, 0)
                End If
                
                    MiHoja.Cells(MiFila, 2) = .TextMatrix(I, 1)
                    MiHoja.Cells(MiFila, 3) = .TextMatrix(I, 2)
                    MiHoja.Cells(MiFila, 4) = .TextMatrix(I, 3)
                    MiHoja.Cells(MiFila, 5) = .TextMatrix(I, 4)
                    MiHoja.Cells(MiFila, 6) = .TextMatrix(I, 5)
                    MiHoja.Cells(MiFila, 7) = .TextMatrix(I, 6)
                    MiHoja.Cells(MiFila, 8) = .TextMatrix(I, 7)
                    MiHoja.Cells(MiFila, 9) = .TextMatrix(I, 8)
                    MiHoja.Cells(MiFila, 10) = .TextMatrix(I, 10)
                    MiHoja.Cells(MiFila, 11) = .TextMatrix(I, 11)
                    MiHoja.Cells(MiFila, 12) = .TextMatrix(I, 12)
            End If
        Next
    End With
     
   Call BacControlWindows(10)
   Screen.MousePointer = vbDefault
   MiExcell.DisplayAlerts = True
   On Error GoTo ErrorAction
   Command.CancelError = True
   Command.FileName = cFile
   
   Call Command.ShowSave
   
  MiExcell.DisplayAlerts = True
  
   Call MiHoja.SaveAs(Command.FileName)
   
   Screen.MousePointer = vbHourglass
    
   If Respalda = False Then
      Call MsgBox("Proceso Finalizado" & vbCrLf & vbCrLf & "Archivo ha sido almacenado en la ruta : " & vbCrLf & Command.FileName, vbInformation, App.Title)
   End If
     
   MiExcell.Visible = True
  
   Set MiSheet = Nothing
   Set MiHoja = Nothing
   Set MiLibro = Nothing
   Set MiExcell = Nothing
   
  'Call MiLibro.Close
   
   Let Screen.MousePointer = vbDefault
   On Error GoTo 0

Exit Sub
ErrorAction:
   Screen.MousePointer = vbDefault
   
 If Err.Number = 32755 Then
    MiExcell.DisplayAlerts = False
    MiExcell.Application.Quit
      Set MiSheet = Nothing
      Set MiHoja = Nothing
     'Call MiLibro.Close
      Set MiLibro = Nothing
      Set MiExcell = Nothing
      'MiExcell.Application.Quit
 Else
   
   If Err.Number = 70 Then
            
        MiExcell.Application.DisplayAlerts = False
        
        Call MiExcell.Application.Workbooks.Close
        MiExcell.Application.Quit
        If MsgBox("Error de Escritura..." & vbCrLf & "Archivo se encuentra protegido contra escritura o bien esta en uso ... Reintentar ?", vbQuestion + vbYesNo, App.Title) = vbYes Then
            
            Resume
        Else
            Respalda = True
            Exit Sub
            Resume
            Exit Sub
        End If
    End If
       If Err.Number = 1004 Then
        If MsgBox("Error de Escritura..." & vbCrLf & "Archivo existe, se encuentra protegido contra escritura o bien esta en uso ... Reintentar ?", vbQuestion + vbYesNo, App.Title) = vbYes Then
            
            Resume
        Else
            Respalda = True
            MiExcell.Application.DisplayAlerts = False
            MiLibro.Application.Workbooks.Close
            MiExcell.Application.Quit
            Screen.MousePointer = vbdefaul
            Exit Sub
        End If
             
       End If
      
      If Err.Number <> 0 Then
         Call MsgBox("Error en la carga de archivo" & vbCrLf & vbCrLf & Err.Description, vbExclamation, App.Title)
         Screen.MousePointer = vbDefault
         MiExcell.DisplayAlerts = False
         MiExcell.Application.Quit
      End If
   End If
   
End Sub


Private Sub Proc_Genera_Excel_Mcovar()
   On Error GoTo ErrorAction
   Dim I  As Long
   Dim cFile      As String
   Dim nFilas     As Long
   Dim MiFila     As Long
   Dim MiSheet    As Object
   Dim Respalda   As Boolean
   Dim DATOS()
   Dim MiExcell As Object
   Dim NumColum As Long
   Dim NumFilas As Long
   
   Respalda = False
   
   If Grd_Datos.Rows = 1 Then
        MsgBox "No existen datos a exportar", vbInformation
        Exit Sub
   End If
   
   Screen.MousePointer = vbHourglass
   cFile = App.Path & "\RescataCartera.xlsx"
   cFile = "Vaciado.xlsx"
   Command.Filter = ".xlsx"
   Command.CancelError = True

   Set MiExcell = CreateObject("Excel.Application")
   MiExcell.Application.Workbooks.Close
   Set MiLibro = MiExcell.Application.Workbooks.Add
   Set MiHoja = MiLibro.Sheets.Add
   Set MiSheet = MiExcell.Worksheets(1) '--> MiExcell.ActiveSheet
   MiSheet.Name = "Carteras"
   
   MiExcell.DisplayAlerts = False
   Call MiExcell.Worksheets(3).Delete
   Call MiExcell.Worksheets(2).Delete
   MiExcell.DisplayAlerts = True
   
    With Grd_Datos
        NumFilas = .Rows - 1
        NumColum = .Cols - 1
    
        'MiExcell.Visible = True
        For I = 0 To NumColum
             MiHoja.Cells(1, I + 1) = .TextMatrix(0, I)
        Next
        
         For I = 0 To NumFilas
             MiHoja.Cells(I + 1, 1) = .TextMatrix(I, 0)
        Next
                       
        For I = 1 To NumColum
            For Z = 1 To NumFilas
            
                MiHoja.Cells(Z + 1, I + 1) = CDec(.TextMatrix(Z, I))
                'MiHoja.Cells(Z + 1, I + 1).NumberFormat = "#,##0.00"
               
            Next
        Next
    End With
     
   Call BacControlWindows(10)
   Screen.MousePointer = vbDefault
   MiExcell.DisplayAlerts = True
   On Error GoTo ErrorAction
   Command.CancelError = True
   Command.FileName = cFile
   
   Call Command.ShowSave
   
  MiExcell.DisplayAlerts = True
  
   Call MiHoja.SaveAs(Command.FileName)
   
   Screen.MousePointer = vbHourglass
    
   If Respalda = False Then
      Call MsgBox("Proceso Finalizado" & vbCrLf & vbCrLf & "Archivo ha sido almacenado en la ruta : " & vbCrLf & Command.FileName, vbInformation, App.Title)
   End If
     
   MiExcell.Visible = True
  
   Set MiSheet = Nothing
   Set MiHoja = Nothing
   Set MiLibro = Nothing
   Set MiExcell = Nothing
   
  'Call MiLibro.Close
   
   Let Screen.MousePointer = vbDefault
   On Error GoTo 0

Exit Sub
ErrorAction:
   Screen.MousePointer = vbDefault
   
 If Err.Number = 32755 Then
    MiExcell.DisplayAlerts = False
    MiExcell.Application.Quit
      Set MiSheet = Nothing
      Set MiHoja = Nothing
     'Call MiLibro.Close
      Set MiLibro = Nothing
      Set MiExcell = Nothing
      'MiExcell.Application.Quit
 Else
   
   If Err.Number = 70 Then
            
        MiExcell.Application.DisplayAlerts = False
        
        Call MiExcell.Application.Workbooks.Close
        MiExcell.Application.Quit
        If MsgBox("Error de Escritura..." & vbCrLf & "Archivo se encuentra protegido contra escritura o bien esta en uso ... Reintentar ?", vbQuestion + vbYesNo, App.Title) = vbYes Then
            
            Resume
        Else
            Respalda = True
            Exit Sub
            Resume
            Exit Sub
        End If
    End If
       If Err.Number = 1004 Then
        If MsgBox("Error de Escritura..." & vbCrLf & "Archivo existe, se encuentra protegido contra escritura o bien esta en uso ... Reintentar ?", vbQuestion + vbYesNo, App.Title) = vbYes Then
            
            Resume
        Else
            Respalda = True
            MiExcell.Application.DisplayAlerts = False
            MiLibro.Application.Workbooks.Close
            MiExcell.Application.Quit
            Screen.MousePointer = vbdefaul
            Exit Sub
        End If
             
       End If
      
      If Err.Number <> 0 Then
         Call MsgBox("Error en la carga de archivo" & vbCrLf & vbCrLf & Err.Description, vbExclamation, App.Title)
         Screen.MousePointer = vbDefault
         MiExcell.DisplayAlerts = False
         MiExcell.Application.Quit
      End If
   End If
   
End Sub

Private Sub Opt_Opcion_Click(Index As Integer)
    Dim Opc As Integer
    If Opt_Opcion(0).Value = True Then
        Grd_Datos.Rows = 1
        Calculorec 1
        Screen.MousePointer = vbDefault
        EjecutaBtnREC = True
        
    ElseIf Opt_Opcion(1).Value = True Then
        Grd_Datos.Rows = 1
        Calculorec 8
        Screen.MousePointer = vbDefault
        EjecutaBtnREC = True
    ElseIf Opt_Opcion(2).Value = True Then
        Grd_Datos.Rows = 1
        Call Carga_Grilla_Threshold
        Call Habilitacontroles
        Screen.MousePointer = vbDefault
        EjecutaBtnREC = True
    ElseIf Opt_Opcion(3).Value = True Then
        Grd_Datos.Rows = 1
        Calculorec 3
        Call Habilitacontroles
        Screen.MousePointer = vbDefault
        EjecutaBtnREC = True
    ElseIf Opt_Opcion(4).Value = True Then
        Grd_Datos.Rows = 1
        Calculorec 4
        Screen.MousePointer = vbDefault
        EjecutaBtnREC = True
    ElseIf Opt_Opcion(6).Value = True Then
        Grd_Datos.Rows = 1
        Calculorec 6
        Call Habilitacontroles
        Screen.MousePointer = vbDefault
        EjecutaBtnREC = True
    ElseIf Opt_Opcion(7).Value = True Then
        Grd_Datos.Rows = 1
        Calculorec 7
        Call Habilitacontroles
        Screen.MousePointer = vbDefault
        EjecutaBtnREC = True
    End If
End Sub
Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
     Select Case (Button.Key)
        Case "Generar"
              
            If Opt_Opcion(1).Value = True Then
                Call Proc_Genera_Excel_Mcovar
            Else
              Call Proc_Genera_Excel
            End If
              
        Case "Salir"
           Unload Me
           Exit Sub
    End Select
End Sub

