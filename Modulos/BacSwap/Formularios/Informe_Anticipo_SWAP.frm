VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "Msflxgrd.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form Informe_Anticipo_SWAP 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Informe_Anticipo_SWAP"
   ClientHeight    =   6780
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   9780
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   6780
   ScaleWidth      =   9780
   Begin MSFlexGridLib.MSFlexGrid Table1 
      Height          =   5175
      Left            =   30
      TabIndex        =   9
      Top             =   1380
      Width           =   9675
      _ExtentX        =   17066
      _ExtentY        =   9128
      _Version        =   393216
      Cols            =   6
      FixedCols       =   0
      BackColor       =   -2147483633
      ForeColor       =   -2147483641
      BackColorFixed  =   -2147483646
      ForeColorFixed  =   -2147483633
      ForeColorSel    =   -2147483633
      BackColorBkg    =   -2147483636
      GridColor       =   -2147483633
      GridColorFixed  =   -2147483642
      FocusRect       =   0
      GridLines       =   2
      GridLinesFixed  =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   9780
      _ExtentX        =   17251
      _ExtentY        =   794
      ButtonWidth     =   2434
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      Style           =   1
      TextAlignment   =   1
      ImageList       =   "ImageList1"
      DisabledImageList=   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Buscar"
            Key             =   "BUSCAR"
            Object.ToolTipText     =   "Genera busqueda"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Vista Previa "
            Key             =   "VISTA"
            Object.ToolTipText     =   "Genera una vista previa del informe."
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Imprimir "
            Key             =   "IMPRIMIR"
            Object.ToolTipText     =   "Envía directamente el informe a la impresora."
            ImageIndex      =   2
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Cerrar "
            Key             =   "CERRAR"
            Object.ToolTipText     =   "Cerrar ventana."
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   6225
         Top             =   30
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   22
         ImageHeight     =   22
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   4
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Informe_Anticipo_SWAP.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Informe_Anticipo_SWAP.frx":0EDA
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Informe_Anticipo_SWAP.frx":1DB4
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Informe_Anticipo_SWAP.frx":20CE
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame Frame1 
      Height          =   915
      Left            =   45
      TabIndex        =   1
      Top             =   390
      Width           =   9690
      Begin BACControles.TXTFecha Txt_fecha_desde 
         Height          =   285
         Left            =   1335
         TabIndex        =   3
         Top             =   180
         Width           =   1515
         _ExtentX        =   2672
         _ExtentY        =   503
         Enabled         =   -1  'True
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "14/08/2006"
      End
      Begin BACControles.TXTFecha Txt_Fecha_Hasta 
         Height          =   285
         Left            =   1335
         TabIndex        =   5
         Top             =   510
         Width           =   1515
         _ExtentX        =   2672
         _ExtentY        =   503
         Enabled         =   -1  'True
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "14/08/2006"
      End
      Begin VB.Label LblFechaLargaHasta 
         Caption         =   "Miercoles, 21 de Septiembre del 2007"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   270
         Left            =   2895
         TabIndex        =   8
         Top             =   540
         Width           =   2775
      End
      Begin VB.Label LblFechaLargaDesde 
         Caption         =   "Miercoles, 21 de Septiembre del 2007"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   270
         Left            =   2895
         TabIndex        =   7
         Top             =   210
         Width           =   2775
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "Fecha Hasta"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Left            =   150
         TabIndex        =   6
         Top             =   555
         Width           =   1035
      End
      Begin VB.Label lblFecha 
         Alignment       =   2  'Center
         Caption         =   "Miercoles, 21 de Septiembre del 2006"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H000000FF&
         Height          =   285
         Left            =   45
         TabIndex        =   4
         Top             =   1485
         Width           =   4155
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Fecha Desde"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Left            =   165
         TabIndex        =   2
         Top             =   225
         Width           =   1065
      End
   End
End
Attribute VB_Name = "Informe_Anticipo_SWAP"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Const nRow0 = 0
Const nCol0 = 0
Const nCol1 = 1
Const nCol2 = 2
Const nCol3 = 3
Const nCol4 = 4
Const nCol5 = 5

Sub SeteaGrilla()
    Table1.Rows = 1
    Table1.Row = 0
    
    Table1.TextMatrix(nRow0, nCol0) = "Fecha Anticipo"
    Table1.ColWidth(nCol0) = 1500
    
    Table1.TextMatrix(nRow0, nCol1) = "Numero Operación"
    Table1.ColWidth(nCol1) = 1500

    Table1.TextMatrix(nRow0, nCol2) = "Rut Cliente"
    Table1.ColWidth(nCol2) = 1500
    
    Table1.TextMatrix(nRow0, nCol3) = "Nombre Cliente"
    Table1.ColWidth(nCol3) = 2500
    
    Table1.TextMatrix(nRow0, nCol4) = "Moneda Compra"
    Table1.ColWidth(nCol4) = 1500
    
    Table1.TextMatrix(nRow0, nCol5) = "Monto Compra"
    Table1.ColWidth(nCol5) = 1500
    
    
End Sub


Private Sub Form_Load()
   Me.Icon = BACSwap.Icon
   'PRD-5149, jbh, 12-01-2010, para evitar que el formulario "pasee" por toda la pantalla
   Me.Top = 0
   Me.Left = 0
   
   Me.Caption = "Anticipos de Operaciones de Swap"
   SeteaGrilla
   
   Txt_fecha_desde.Text = gsBAC_Fecp
   LblFechaLargaDesde.Caption = Format(Txt_fecha_desde.Text, "dddd, dd") & " de " & Format(Txt_fecha_desde.Text, "mmmm") & " del " & Format(Txt_fecha_desde.Text, "yyyy")
   
   Txt_Fecha_Hasta.Text = gsBAC_Fecp
   LblFechaLargaHasta.Caption = Format(Txt_Fecha_Hasta.Text, "dddd, dd") & " de " & Format(Txt_Fecha_Hasta.Text, "mmmm") & " del " & Format(Txt_Fecha_Hasta.Text, "yyyy")
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Dim nNumOpe As Integer

   Select Case UCase(Button.Key)
      Case Is = "BUSCAR"

         Call Carga_Grilla

      Case Is = "VISTA"

            If Table1.Row = 0 Then
                MsgBox "No hay operaciones para Anticipar", vbInformation, TITSISTEMA
                Exit Sub
            End If

            nRow = Table1.RowSel
            nNumOpe = Table1.TextMatrix(nRow, nCol1)

         Call GeneraInformeCartera(crptToWindow)
            Call GeneraInformeDetallenuevo(crptToWindow, nNumOpe)

      Case Is = "IMPRIMIR"

         If Table1.Row = 0 Then
            MsgBox "No hay operaciones para Anticipar", vbInformation, TITSISTEMA
            Exit Sub
         End If

         nRow = Table1.RowSel
         nNumOpe = Table1.TextMatrix(nRow, nCol1)

         Call GeneraInformeCartera(crptToPrinter)
         Call GeneraInformeDetallenuevo(crptToPrinter, nNumOpe)

      Case Is = "CERRAR"
         Unload Me
   End Select

End Sub


Private Sub GeneraInformeCartera(iDestino As DestinationConstants)
   On Error GoTo ErrorImpresionCartera
   
   Me.MousePointer = vbHourglass
   
   Call BacLimpiaParamCrw
   
   BACSwap.Crystal.ReportFileName = gsRPT_Path & "Informe_Anticipo_Swap.rpt"
                                             '--> Store Procedure : dbo.SP_INFORME_ANTICIPOS.sql
   BACSwap.Crystal.WindowTitle = "Informe de Cartera Swap."
   BACSwap.Crystal.StoredProcParam(0) = Format(Txt_fecha_desde.Text, "yyyy-mm-dd 00:00:00.000")
   BACSwap.Crystal.StoredProcParam(1) = Format(Me.Txt_Fecha_Hasta.Text, "yyyy-mm-dd 00:00:00.000")
   BACSwap.Crystal.StoredProcParam(2) = Mid(Trim(gsBAC_User), 1, 15)
   BACSwap.Crystal.Destination = iDestino
   BACSwap.Crystal.Connect = swConeccion
   BACSwap.Crystal.Action = 1
   
   Me.MousePointer = vbDefault
   On Error GoTo 0
Exit Sub
ErrorImpresionCartera:
   Me.MousePointer = vbDefault
   MsgBox "Acción Abortada." & vbCrLf & vbCrLf & "Error al imprimir Error : " & vbCrLf & BACSwap.Crystal.LastErrorString, vbExclamation, TITSISTEMA
   On Error GoTo 0
End Sub

Private Sub GeneraInformeDetallenuevo(iDestino As DestinationConstants, nNumOpe As Integer)
   On Error GoTo ErrorImpresionCartera
   
   Me.MousePointer = vbHourglass
   
   Call BacLimpiaParamCrw
   
   BACSwap.Crystal.ReportFileName = gsRPT_Path & "INFORME_DETALLE_UNWIND.rpt"
                                             '--> Store Procedure : dbo.SP_INFORME_ANTICIPOS.sql
   BACSwap.Crystal.WindowTitle = "Informe de Cartera Anticipos Swap."
   BACSwap.Crystal.StoredProcParam(0) = nNumOpe
   BACSwap.Crystal.Destination = iDestino
   BACSwap.Crystal.Connect = swConeccion
   BACSwap.Crystal.Action = 1
   
   Me.MousePointer = vbDefault
   On Error GoTo 0
Exit Sub
ErrorImpresionCartera:
   Me.MousePointer = vbDefault
   MsgBox "Acción Abortada." & vbCrLf & vbCrLf & "Error al imprimir Error : " & vbCrLf & BACSwap.Crystal.LastErrorString, vbExclamation, TITSISTEMA
   On Error GoTo 0
End Sub

Private Sub Txt_fecha_desde_Change()
   LblFechaLargaDesde.Caption = Format(Txt_fecha_desde.Text, "dddd, dd") & " de " & Format(Txt_fecha_desde.Text, "mmmm") & " del " & Format(Txt_fecha_desde.Text, "yyyy")
End Sub

Private Sub Txt_Fecha_Hasta_Change()
   LblFechaLargaDesde.Caption = Format(Txt_Fecha_Hasta.Text, "dddd, dd") & " de " & Format(Txt_Fecha_Hasta.Text, "mmmm") & " del " & Format(Txt_Fecha_Hasta.Text, "yyyy")
End Sub

Sub Carga_Grilla()
   On Error GoTo ErrorFilas
    Dim DATOS()
    Dim Datos2()
    Dim sTipoSp     As Boolean
    Dim nSprdTV1    As Double
    Dim nSprdTC1    As Double
    Dim nCoRows     As Long

   Envia = Array()
   AddParam Envia, Txt_fecha_desde.Text
   AddParam Envia, Txt_Fecha_Hasta.Text
   If Not Bac_Sql_Execute("SP_LISTAOPE_ANTICIPOUNWIND", Envia) Then
      MsgBox "Error en la lectura de las operaciones.", vbExclamation, TITSISTEMA
      Exit Sub
   End If

   Table1.Redraw = False
   Table1.Rows = 1

   Do While Bac_SQL_Fetch(DATOS())
      Table1.Rows = Table1.Rows + 1
      Table1.TextMatrix(Table1.Rows - 1, nCol0) = DATOS(1)
      Table1.TextMatrix(Table1.Rows - 1, nCol1) = DATOS(2)
      Table1.TextMatrix(Table1.Rows - 1, nCol2) = DATOS(3)
      Table1.TextMatrix(Table1.Rows - 1, nCol3) = DATOS(4)
      Table1.TextMatrix(Table1.Rows - 1, nCol4) = DATOS(5)
      Table1.TextMatrix(Table1.Rows - 1, nCol5) = DATOS(6)
   Loop
   
   If Table1.Rows = Table1.FixedRows Then
      Table1.Rows = 1
   End If

   Table1.Redraw = True

   If Table1.Rows = 1 Then
      MsgBox "No hay operaciones para ese rango de Fechas.", vbExclamation, App.Title
   End If

Exit Sub
ErrorFilas:
   Call MsgBox(err.Description, vbExclamation, App.Title)
End Sub
