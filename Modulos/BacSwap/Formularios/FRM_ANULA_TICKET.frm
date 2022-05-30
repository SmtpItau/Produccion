VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "Msflxgrd.ocx"
Object = "{00025600-0000-0000-C000-000000000046}#5.2#0"; "CRYSTL32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form FRM_ANULA_TICKET 
   Caption         =   "Form2"
   ClientHeight    =   6030
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   13695
   LinkTopic       =   "Form2"
   MDIChild        =   -1  'True
   ScaleHeight     =   6030
   ScaleWidth      =   13695
   Begin MSComctlLib.Toolbar Toolbar2 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   3
      Top             =   510
      Width           =   13695
      _ExtentX        =   24156
      _ExtentY        =   794
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   2
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   6690
         Top             =   30
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   22
         ImageHeight     =   22
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   3
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ANULA_TICKET.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ANULA_TICKET.frx":0EDA
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ANULA_TICKET.frx":1DB4
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin MSComctlLib.ImageList ImageList3 
      Left            =   9435
      Top             =   105
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   5
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_ANULA_TICKET.frx":20CE
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_ANULA_TICKET.frx":23E8
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_ANULA_TICKET.frx":2702
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_ANULA_TICKET.frx":2B54
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_ANULA_TICKET.frx":2E70
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   2
      Top             =   0
      Width           =   13695
      _ExtentX        =   24156
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList3"
      DisabledImageList=   "ImageList3"
      HotImageList    =   "ImageList3"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Anular"
            Object.ToolTipText     =   "Anular Operación"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Buscar"
            Object.ToolTipText     =   "Buscar Movimientos"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Imprimir Papeletas"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Object.ToolTipText     =   "Salir de la Pantalla"
            ImageIndex      =   1
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin Crystal.CrystalReport crImpPape 
         Left            =   8055
         Top             =   120
         _ExtentX        =   741
         _ExtentY        =   741
         _Version        =   348160
         PrintFileLinesPerPage=   60
      End
   End
   Begin VB.Frame FRA_Fechas 
      Height          =   750
      Left            =   15
      TabIndex        =   4
      Top             =   435
      Width           =   13650
      Begin BACControles.TXTFecha TXTFechaDesde 
         Height          =   300
         Left            =   1365
         TabIndex        =   7
         Top             =   210
         Width           =   1590
         _ExtentX        =   2805
         _ExtentY        =   529
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
         Text            =   "06/01/2010"
      End
      Begin BACControles.TXTFecha TXTFechaHasta 
         Height          =   300
         Left            =   4230
         TabIndex        =   8
         Top             =   210
         Width           =   1590
         _ExtentX        =   2805
         _ExtentY        =   529
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
         Text            =   "06/01/2010"
      End
      Begin VB.Label LBLEtiqueta 
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
         Index           =   1
         Left            =   3150
         TabIndex        =   6
         Top             =   255
         Width           =   1035
      End
      Begin VB.Label LBLEtiqueta 
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
         Index           =   0
         Left            =   210
         TabIndex        =   5
         Top             =   240
         Width           =   1065
      End
   End
   Begin VB.Frame Frame1 
      Height          =   4890
      Left            =   15
      TabIndex        =   0
      Top             =   1110
      Width           =   13665
      Begin MSFlexGridLib.MSFlexGrid Table1 
         Height          =   4725
         Left            =   15
         TabIndex        =   1
         Top             =   120
         Width           =   13605
         _ExtentX        =   23998
         _ExtentY        =   8334
         _Version        =   393216
         Cols            =   13
         FixedCols       =   0
         BackColor       =   -2147483633
         ForeColor       =   -2147483630
         BackColorFixed  =   -2147483646
         ForeColorFixed  =   -2147483639
         BackColorBkg    =   -2147483636
         GridColor       =   -2147483633
         GridColorFixed  =   -2147483642
         FocusRect       =   0
         GridLines       =   2
         GridLinesFixed  =   0
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
   End
End
Attribute VB_Name = "FRM_ANULA_TICKET"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public Anticipo   As Boolean

 Const formatoMx = "#,##0.0000"
 Const nRow0 = 0
 Const nCol0 = 0
 Const nCol1 = 1
 Const nCol2 = 2
 Const nCol3 = 3
 Const nCol4 = 4
 Const nCol5 = 5
 Const nCol6 = 6
 Const nCol7 = 7
 Const nCol8 = 8
 Const nCol9 = 9
 Const nCol10 = 10
 Const nCol11 = 11
 Const nCol12 = 12

Private Sub Form_Load()
   Me.Icon = BACSwap.Icon
   Me.Top = 0:   Me.Left = 0

   Me.Caption = "Consulta y Anulación de Operaciones de Ticket IntraMesa"
   Toolbar2.Visible = False
   
   Frame1.Top = 435
   Toolbar2.Visible = False
   FRA_Fechas.Visible = False

   If Anticipo = True Then
      Me.Caption = "Consulta y Anticipo de Ticket IntraMesa."
      Toolbar1.Visible = False
      Toolbar2.Visible = True
      FRA_Fechas.Top = 435
      FRA_Fechas.Visible = True
      Frame1.Top = 1100
   End If

   Call SeteaGrilla
End Sub

Private Sub Form_Resize()
   On Error Resume Next
   If Anticipo = False Then
      Me.Frame1.Height = Me.Height - 1050
      Me.Table1.Height = Me.Frame1.Height - 150
   
      Me.FRA_Fechas.Width = Me.Width - 150
      Me.Frame1.Width = Me.FRA_Fechas.Width
      Me.Table1.Width = Me.Frame1.Width - 50
   
   Else
      Me.Frame1.Height = Me.Height - 1620
      Me.Table1.Height = Me.Frame1.Height - 150
      
      Me.FRA_Fechas.Width = Me.Width - 150
      Me.Frame1.Width = Me.FRA_Fechas.Width
      Me.Table1.Width = Me.Frame1.Width - 50
   End If
   
   On Error GoTo 0
End Sub

Private Sub Form_Unload(Cancel As Integer)
   Let Anticipo = False
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Dim nRow       As Long
   Dim opBase     As Long
   Dim opEspejo   As Long

   nRow = 0
   
   Select Case Button.Index
      Case 1
         If Table1.Rows = 1 Then
            MsgBox "No hay Operaciones para Anular", vbInformation, TITSISTEMA
            Exit Sub
         End If
            
         nRow = Table1.RowSel
         
         If Table1.TextMatrix(nRow, nCol12) <> 0 Then
            'JBH, 17-12-2009
            'OPERACION ESPEJO!
            'La operacion Table1.TextMatrix(nRow, 0)      es Op. Espejo
            'La operacion Table1.TextMatrix(nRow, nCol12) es Op. Base
            'Llamar a Anulacion apuntando a la Op. Base
            opBase = Table1.TextMatrix(nRow, nCol12)
            opEspejo = Table1.TextMatrix(nRow, 0)
            
            'MsgBox "Operacion espejo, no se puede Anular, para hacerlo debe seleccionar la Operación Origen: " & Table1.TextMatrix(nRow - 1, nCol0), vbInformation, TITSISTEMA 'JBH, 17-12-2009
            'Exit Sub   'JBH, 17-12-2009
            
            If MsgBox("¿Está Seguro de eliminar la operación?", vbQuestion + vbYesNo, TITSISTEMA) = vbYes Then
               Call AnulacionEspejo(opBase, opEspejo)
               Exit Sub
            Else
               Exit Sub
            End If
            'fin JBH, 17-12-2009
         End If
            
         If MsgBox("¿ Esta Seguro de eliminar la operación. ?", vbQuestion + vbYesNo, TITSISTEMA) = vbYes Then
            Call Anulacion
         End If
      
      Case 2
         Call Carga_Grilla
      
      Case 3
         If Table1.Rows > 1 Then
            Call Imprimir_Papeleta
         Else
            MsgBox "No hay operaciones para Imprimir Papeletas", vbInformation, TITSISTEMA
            Exit Sub
         End If
      
      Case 4
         Unload Me
   End Select
End Sub

Sub SeteaGrilla()
    
    Table1.Rows = 1
    Table1.Row = 0
    
    Table1.TextMatrix(nRow0, nCol0) = "N° Operación":       Table1.ColWidth(nCol0) = 1200
    Table1.TextMatrix(nRow0, nCol1) = "Fecha Inicio":       Table1.ColWidth(nCol1) = 1200
    Table1.TextMatrix(nRow0, nCol2) = "Fecha Vcto":         Table1.ColWidth(nCol2) = 1200
    Table1.TextMatrix(nRow0, nCol3) = "Moneda Operación":   Table1.ColWidth(nCol3) = 1800
    Table1.TextMatrix(nRow0, nCol4) = "Monto Operación":    Table1.ColWidth(nCol4) = 2200
    Table1.TextMatrix(nRow0, nCol5) = "Tasa":               Table1.ColWidth(nCol5) = 1000
    Table1.TextMatrix(nRow0, nCol6) = "Modalidad":          Table1.ColWidth(nCol6) = 1800
    Table1.TextMatrix(nRow0, nCol7) = "Cartera Origen":     Table1.ColWidth(nCol7) = 1800
    Table1.TextMatrix(nRow0, nCol8) = "Cartera Destino":    Table1.ColWidth(nCol8) = 1800
    Table1.TextMatrix(nRow0, nCol9) = "Portafolio":         Table1.ColWidth(nCol9) = 1800
    Table1.TextMatrix(nRow0, nCol10) = "Contraparte":       Table1.ColWidth(nCol10) = 1800
    Table1.TextMatrix(nRow0, nCol11) = "Usuario":           Table1.ColWidth(nCol11) = 1200
    Table1.TextMatrix(nRow0, nCol12) = "N° Op.Relacional":  Table1.ColWidth(nCol12) = 1200
End Sub

Sub Carga_Grilla()
   On Error Resume Next
   Dim DATOS()
   Dim datos2()
   Dim sTipoSp     As Boolean
   Dim nSprdTV1    As Double
   Dim nSprdTC1    As Double
   Dim nCoRows     As Long
    
   Call SeteaGrilla
    
   If Not Bac_Sql_Execute("SP_LISTACARTKINMESA") Then
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
      Table1.TextMatrix(Table1.Rows - 1, nCol4) = Format(DATOS(5), formatoMx)
      Table1.TextMatrix(Table1.Rows - 1, nCol5) = Format(DATOS(6), "#,##0.00000")
      Table1.TextMatrix(Table1.Rows - 1, nCol6) = DATOS(7)
      Table1.TextMatrix(Table1.Rows - 1, nCol7) = DATOS(8)
      Table1.TextMatrix(Table1.Rows - 1, nCol8) = DATOS(9)
      Table1.TextMatrix(Table1.Rows - 1, nCol9) = DATOS(10)
      Table1.TextMatrix(Table1.Rows - 1, nCol10) = DATOS(11)
      Table1.TextMatrix(Table1.Rows - 1, nCol11) = DATOS(12)
      Table1.TextMatrix(Table1.Rows - 1, nCol12) = DATOS(13)
    Loop
    
   Table1.Redraw = True
   
   If Table1.Rows = 1 Then
      MsgBox "No hay Operaciones Vigentes.", vbExclamation, TITSISTEMA
   End If

End Sub

Private Sub AnulacionEspejo(ByVal nOperacion As Long, ByVal nEspejo As Long)
   'JBH, 17-12-2009
   On Error Resume Next
   Dim DATOS()
   Dim nRow    As Long
   Dim nRowd   As Long
    
   If Not Trim(Table1.TextMatrix(Table1.RowSel, nCol11)) = Trim(gsBAC_User) Then
      MsgBox "Usted No puede anular esta operación", vbInformation, TITSISTEMA
      Exit Sub
   End If

   Envia = Array(nOperacion)
   If Not Bac_Sql_Execute("SP_ANULAOPERTICKET", Envia) Then
      MsgBox "No se pudo Anular la Operación", vbInformation, TITSISTEMA
      Exit Sub
   Else
      MsgBox "Anulacion Ok." & vbCrLf & vbCrLf & "Operación N° : " & Format(nEspejo, TipoFormato("CLP")) & " Se ha Anulado en forma correcta.", vbInformation, TITSISTEMA
   End If

   Call SeteaGrilla
   Call Carga_Grilla
End Sub

Sub Anulacion()
   On Error Resume Next
   Dim DATOS()
   Dim nOperacion  As Long
   Dim nRow        As Long
   Dim nRowd        As Long
    
   nOperacion = Table1.TextMatrix(Table1.RowSel, nCol0)

   If Not Trim(Table1.TextMatrix(Table1.RowSel, nCol11)) = Trim(gsBAC_User) Then
      MsgBox "Usted No puede anular esta operación", vbInformation, TITSISTEMA
      Exit Sub
   End If
    
   Envia = Array(nOperacion)
   If Not Bac_Sql_Execute("SP_ANULAOPERTICKET", Envia) Then
      MsgBox "No se pudo Anular la Operación", vbInformation, TITSISTEMA
      Exit Sub
   Else
      MsgBox "Anulacion Ok." & vbCrLf & vbCrLf & "Operación N° : " & Format(nOperacion, TipoFormato("CLP")) & " Se ha Anulado en forma correcta.", vbInformation, TITSISTEMA
   End If

   Call SeteaGrilla
   Call Carga_Grilla
End Sub

Sub Imprimir_Papeleta()
   Dim nRow    As Long
   Dim nRowd   As Long

   nOperacion = Table1.TextMatrix(Table1.RowSel, 0)

   crImpPape.ReportFileName = gsRPT_Path & "PAPELETA_TICKET.rpt"
   crImpPape.Destination = crptToWindow
   crImpPape.WindowState = crptMaximized
   crImpPape.WindowTitle = TITSISTEMA & " - Papeleta de Operaciones de Ticket Intramesa"
   crImpPape.StoredProcParam(0) = nOperacion
   crImpPape.StoredProcParam(1) = gsBAC_User
   crImpPape.Connect = swConeccion
   crImpPape.Action = 1
End Sub

Private Sub Toolbar2_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 2
         Call Carga_Grilla
      Case 3
         Call AnticiparOperacion
      Case 4
         Call Unload(Me)
   End Select
End Sub

Private Function AnticiparOperacion()

   If Me.Table1.Rows = Me.Table1.FixedRows Then
      Call MsgBox("No Existen Operaciones Para Anicipar.", vbExclamation, App.Title)
      Exit Function
   End If

    Let GlbEstadoAnticipo = False
    Let GlbNumeroAnticipo = Table1.TextMatrix(Table1.RowSel, nCol0)
    Let FRM_ANTICIPO_OP.nNumeroOperacion = GlbNumeroAnticipo
    Let FRM_ANTICIPO_OP.nTicketIntraMesa = True
   Call FRM_ANTICIPO_OP.Show(vbModal)

   Call Carga_Grilla

End Function
