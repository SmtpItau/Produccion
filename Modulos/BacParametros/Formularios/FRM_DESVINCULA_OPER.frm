VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "Msflxgrd.ocx"
Begin VB.Form FRM_DESVINCULA_OPER 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Desvinculación de Operaciones con Garantías"
   ClientHeight    =   4155
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   11655
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   4155
   ScaleWidth      =   11655
   ShowInTaskbar   =   0   'False
   Begin VB.Frame Frame2 
      Caption         =   "Operaciones Asociadas"
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
      Height          =   3495
      Left            =   9240
      TabIndex        =   3
      Top             =   600
      Width           =   2415
      Begin VB.ListBox ListOper 
         Columns         =   1
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
         Height          =   2985
         Left            =   120
         TabIndex        =   4
         Top             =   240
         Width           =   2175
      End
   End
   Begin VB.Frame Frame1 
      Height          =   3495
      Left            =   0
      TabIndex        =   1
      Top             =   600
      Width           =   9135
      Begin MSFlexGridLib.MSFlexGrid grilla 
         Height          =   3135
         Left            =   120
         TabIndex        =   2
         Top             =   240
         Width           =   8895
         _ExtentX        =   15690
         _ExtentY        =   5530
         _Version        =   393216
         Cols            =   6
         FixedCols       =   0
         BackColor       =   -2147483634
         ForeColor       =   8388608
         BackColorFixed  =   8421376
         ForeColorFixed  =   -2147483634
         BackColorSel    =   -2147483643
         ForeColorSel    =   8388608
         AllowBigSelection=   0   'False
         SelectionMode   =   1
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   11655
      _ExtentX        =   20558
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      DisabledImageList=   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   5
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Limpiar"
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Marcar"
            Object.ToolTipText     =   "Marcar"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Desmarcar"
            Object.ToolTipText     =   "Desmarcar"
            ImageIndex      =   6
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Grabar"
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   8
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   13
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   6480
      Top             =   120
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   13
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_DESVINCULA_OPER.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_DESVINCULA_OPER.frx":0EDA
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_DESVINCULA_OPER.frx":1DB4
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_DESVINCULA_OPER.frx":35A6
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_DESVINCULA_OPER.frx":502C
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_DESVINCULA_OPER.frx":68AE
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_DESVINCULA_OPER.frx":8334
            Key             =   ""
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_DESVINCULA_OPER.frx":920E
            Key             =   ""
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_DESVINCULA_OPER.frx":A0E8
            Key             =   ""
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_DESVINCULA_OPER.frx":AFC2
            Key             =   ""
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_DESVINCULA_OPER.frx":BE9C
            Key             =   ""
         EndProperty
         BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_DESVINCULA_OPER.frx":CD76
            Key             =   ""
         EndProperty
         BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_DESVINCULA_OPER.frx":D090
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "FRM_DESVINCULA_OPER"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public colorFore As Long
Public colorBack As Long
Public colSelec As Long
Public colFondo As Long
Public colFondg As Long
Private Sub FormateaGrilla()
With grilla
    .FixedRows = 1
    .Cols = 7
    .ColWidth(0) = 300      'Marca
    .ColWidth(1) = 1000     'N° Gtia.
    .ColWidth(2) = 1500     'Rut Cliente
    .ColWidth(3) = 500      'Cod. Cliente
    .ColWidth(4) = 4000     'Nombre Cliente
    .ColWidth(5) = 1000     'Folio Asoc.
    .ColWidth(6) = 0
        
    .FixedAlignment(0) = flexAlignCenter
    .FixedAlignment(1) = flexAlignRight
    .FixedAlignment(2) = flexAlignRight
    .FixedAlignment(3) = flexAlignRight
    .FixedAlignment(4) = flexAlignRight
    .FixedAlignment(5) = flexAlignRight
    .FixedAlignment(6) = flexAlignRight
        
    .TextMatrix(0, 0) = " "
    .TextMatrix(0, 1) = "N° Gtía."
    .TextMatrix(0, 2) = "Rut Cliente"
    .TextMatrix(0, 3) = "Cód. Clte."
    .TextMatrix(0, 4) = "Nombre Cliente"
    .TextMatrix(0, 5) = "Folio Asoc."
    .TextMatrix(0, 6) = ""
End With

End Sub
Private Sub Form_Load()
Me.Top = 0
Me.Left = 0
colorFore = grilla.ForeColor
colorBack = grilla.BackColor
colSelec = &H40C0&
colFondo = &HFFFF80
colFondg = &HE0E0E0
Call Limpiar
'Call LlenaGrilla
End Sub

Private Sub grilla_Click()
Dim xfila As Long
xfila = grilla.RowSel
If FilaVacia(xfila) Then
    Exit Sub
End If
ListOper.Clear
Call LlenaListOper(xfila)
End Sub

Private Sub Grilla_DblClick()
Dim xfila As Long
xfila = grilla.RowSel
If FilaVacia(xfila) Then
    Exit Sub
End If
If grilla.TextMatrix(xfila, 0) = "M" Then
    grilla.TextMatrix(xfila, 0) = " "
    Call PintaFila(grilla, xfila, colorFore, colorBack)
Else
    grilla.TextMatrix(xfila, 0) = "M"
    Call PintaFila(grilla, xfila, colSelec, colFondg)
    'ListOper.Clear
    'Call LlenaListOper(xfila)
End If
End Sub
Private Function LlenaListOper(ByVal nFila As Long) As Boolean
Dim nomSp As String
Dim Oper As String
Dim Datos()
Envia = Array()
nomSp = " BacParamsuda.dbo.SP_GAR_OPERASOC_FOLIO"
AddParam Envia, CLng(grilla.TextMatrix(nFila, 5))
AddParam Envia, CDbl(grilla.TextMatrix(nFila, 2))
AddParam Envia, CDbl(grilla.TextMatrix(nFila, 3))
If Not Bac_Sql_Execute(nomSp, Envia) Then
    MsgBox "Se ha producido un error al leer las Operaciones Asociadas a la Garantía!", vbExclamation, TITSISTEMA
    LlenaListOper = False
    Exit Function
End If
Do While (Bac_SQL_Fetch(Datos()))
    Oper = IIf(IsNull(Datos(1)), "", Datos(1)) & " - " & IIf(IsNull(Datos(2)), "", Datos(2))
    If Trim(Oper) <> "-" Then
        ListOper.AddItem (Oper)
    End If
Loop
LlenaListOper = True
End Function
Private Function MarcarTodasAsoc(ByVal nFolio As Long) As Boolean
Dim I As Long
With grillaAsoc
    For I = 1 To .Rows - 1
        If CLng(.TextMatrix(I, 1)) = nFolio Then
            If .TextMatrix(I, 0) <> "*" Then
                .TextMatrix(I, 0) = "*"
                Call PintaFila(grillaAsoc, I, colSelec, colFondg)
            End If
        End If
    Next I
End With
MarcarTodasAsoc = True
End Function
Private Function DesmarcarTodasAsoc(ByVal nFolio As Long) As Boolean
Dim I As Long
With grillaAsoc
    For I = 1 To .Rows - 1
        If CLng(.TextMatrix(I, 1)) = nFolio Then
            If .TextMatrix(I, 0) <> " " Then
                .TextMatrix(I, 0) = " "
                Call PintaFila(grillaAsoc, I, colorFore, colorBack)
            End If
        End If
    Next I
End With
DesmarcarTodasAsoc = True
End Function

Private Function FilaVacia(ByVal Fila As Long) As Boolean
FilaVacia = False
If grilla.TextMatrix(Fila, 1) = "" And grilla.TextMatrix(Fila, 2) = "" Then
    FilaVacia = True
End If
End Function
Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Index
    Case 1
        Call Limpiar
    Case 2
        Call Marcar
    Case 3
        Call Desmarcar
    Case 4
        Call Grabar
    Case 5
        Unload Me
End Select
End Sub
Private Sub Limpiar()
grilla.Clear
grilla.Rows = 2
ListOper.Clear
Call FormateaGrilla
Call LlenaGrilla
End Sub
Private Sub Marcar()
'Ver si ya no está marcada...
    Dim xfila As Long
    xfila = grilla.RowSel
    If grilla.TextMatrix(xfila, 0) = "M" Then
        'Ya está marcada!
        Exit Sub
    End If
    Call Grilla_DblClick
End Sub
Private Sub Desmarcar()
    Dim xfila As Long
    xfila = grilla.RowSel
    If grilla.TextMatrix(xfila, 0) = " " Then
        'No está marcada!
        Exit Sub
    End If
    Call Grilla_DblClick
End Sub
Private Sub Grabar()
Dim marcados As Long
Dim borrados As Long
Dim I As Long
Dim n As Long
Dim Msg As String
n = grilla.Rows
marcados = 0
borrados = 0
For I = 1 To n - 1
    If grilla.TextMatrix(I, 0) = "M" Then
        marcados = marcados + 1
    End If
Next I
If marcados = 0 Then
    MsgBox "No hay datos marcados para grabar!", vbInformation, TITSISTEMA
    Exit Sub
End If
If marcados = 1 Then
    Msg = "¿Confirma la desvinculación de la Garantía marcada?"
Else
    Msg = "¿Confirma la desvinculación de las " & Format(marcados, FEntero) & " Garantías marcadas?"
End If
If MsgBox(Msg, vbQuestion + vbYesNo, TITSISTEMA) <> vbYes Then
    Exit Sub
End If
For I = 1 To n - 1
    If grilla.TextMatrix(I, 0) = "M" Then
        If Desvincula(I) Then
            borrados = borrados + 1
        End If
    End If
Next I
If borrados = marcados Then
    MsgBox "El proceso de desvinculación ha terminado exitosamente", vbInformation, TITSISTEMA
Else
    MsgBox "El proceso de desvinculación no se realizó por completo!", vbExclamation, TITSISTEMA
End If
Call Limpiar
End Sub
Private Function Desvincula(ByVal Linea As Long) As Boolean
Dim nomSp As String
nomSp = "BacParamsuda.dbo.SP_GAR_DESVINCULA"
Envia = Array()
If Not BacBeginTransaction() Then
    Desvincula = False
    Exit Function
End If
AddParam Envia, CLng(grilla.TextMatrix(Linea, 5))   'FolioAsocia
AddParam Envia, CDbl(grilla.TextMatrix(Linea, 2))   'Rut Cliente
AddParam Envia, CDbl(grilla.TextMatrix(Linea, 3))   'Cod. Cliente
AddParam Envia, CDbl(grilla.TextMatrix(Linea, 1))   'Número de Garantía

If Not Bac_Sql_Execute(nomSp, Envia) Then
    Desvincula = False
    Exit Function
End If
If Not BacCommitTransaction Then
    Desvincula = False
    Exit Function
End If
Desvincula = True
End Function
Private Sub LlenaGrilla()
Dim Datos()
Dim nomSp As String
Dim numOp As String
Dim I As Long
nomSp = "BacParamsuda.dbo.SP_RETREGISTROGARANTIAS"
I = 0
If Not Bac_Sql_Execute(nomSp) Then
    MsgBox "Se ha producido un error al leer el Registro de Garantías!", vbExclamation, TITSISTEMA
    Exit Sub
End If
Do While Bac_SQL_Fetch(Datos())
    I = I + 1
    grilla.TextMatrix(grilla.Rows - 1, 1) = Format(Datos(1), FEntero)
    grilla.TextMatrix(grilla.Rows - 1, 2) = Format(CDbl(Datos(2)), FEntero)
    grilla.TextMatrix(grilla.Rows - 1, 3) = Datos(3)
    grilla.TextMatrix(grilla.Rows - 1, 4) = Datos(4)
    grilla.TextMatrix(grilla.Rows - 1, 5) = Datos(5)
    grilla.Rows = grilla.Rows + 1
Loop
If I = 0 Then
    MsgBox "No hay datos para procesar!", vbInformation, titisistema
    Exit Sub
End If
grilla.Rows = grilla.Rows - 1
End Sub
