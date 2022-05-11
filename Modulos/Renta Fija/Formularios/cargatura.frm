VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.3#0"; "COMCTL32.OCX"
Begin VB.Form Cargatura 
   Caption         =   "Cargatura"
   ClientHeight    =   3045
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   3330
   ClipControls    =   0   'False
   ControlBox      =   0   'False
   Icon            =   "cargatura.frx":0000
   LinkTopic       =   "Form1"
   MDIChild        =   -1  'True
   ScaleHeight     =   3045
   ScaleWidth      =   3330
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   600
      Top             =   3120
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   2
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "cargatura.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "cargatura.frx":0624
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   8
      Top             =   0
      Width           =   3330
      _ExtentX        =   5874
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Carga Datos"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
   End
   Begin VB.Frame Frame1 
      Caption         =   "Cargatura de:"
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   11.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   2100
      Left            =   0
      TabIndex        =   1
      Top             =   480
      Width           =   3330
      Begin VB.PictureBox ConCheck 
         BorderStyle     =   0  'None
         Height          =   330
         Index           =   1
         Left            =   270
         Picture         =   "cargatura.frx":093E
         ScaleHeight     =   330
         ScaleWidth      =   330
         TabIndex        =   5
         Top             =   765
         Visible         =   0   'False
         Width           =   330
      End
      Begin VB.PictureBox SinCheck 
         BorderStyle     =   0  'None
         Height          =   330
         Index           =   1
         Left            =   270
         Picture         =   "cargatura.frx":0A98
         ScaleHeight     =   330
         ScaleWidth      =   375
         TabIndex        =   4
         Top             =   765
         Width           =   375
      End
      Begin VB.PictureBox ConCheck 
         BorderStyle     =   0  'None
         Height          =   330
         Index           =   0
         Left            =   240
         Picture         =   "cargatura.frx":0BF2
         ScaleHeight     =   330
         ScaleWidth      =   330
         TabIndex        =   3
         Top             =   360
         Visible         =   0   'False
         Width           =   330
      End
      Begin VB.PictureBox SinCheck 
         BorderStyle     =   0  'None
         Height          =   330
         Index           =   0
         Left            =   240
         Picture         =   "cargatura.frx":0D4C
         ScaleHeight     =   330
         ScaleWidth      =   375
         TabIndex        =   2
         Top             =   360
         Width           =   375
      End
      Begin VB.Label Label1 
         ForeColor       =   &H000000FF&
         Height          =   255
         Left            =   120
         TabIndex        =   9
         Top             =   1680
         Width           =   2895
      End
      Begin VB.Label Etiqueta 
         AutoSize        =   -1  'True
         Caption         =   "Clientes"
         Height          =   195
         Index           =   1
         Left            =   720
         TabIndex        =   7
         Top             =   810
         Width           =   555
      End
      Begin VB.Label Etiqueta 
         AutoSize        =   -1  'True
         Caption         =   "Cartera "
         Height          =   195
         Index           =   0
         Left            =   720
         TabIndex        =   6
         Top             =   405
         Width           =   555
      End
   End
   Begin ComctlLib.ProgressBar ProgressBar1 
      Height          =   375
      Left            =   0
      TabIndex        =   0
      Top             =   2640
      Width           =   3255
      _ExtentX        =   5741
      _ExtentY        =   661
      _Version        =   327682
      Appearance      =   1
   End
   Begin VB.Data Data1 
      Caption         =   "Data1"
      Connect         =   "dBASE IV;"
      DatabaseName    =   ""
      DefaultCursorType=   0  'DefaultCursor
      DefaultType     =   2  'UseODBC
      Exclusive       =   0   'False
      Height          =   345
      Left            =   480
      Options         =   0
      ReadOnly        =   0   'False
      RecordsetType   =   0  'Table
      RecordSource    =   ""
      Top             =   600
      Width           =   3135
   End
End
Attribute VB_Name = "Cargatura"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim Sql As String
Private Sub Clientes()
Label1.Visible = True
Label1.Caption = "Cargando Clientes"
Data1.RecordSource = "MDCL.dbf"
Data1.Refresh
ProgressBar1.Visible = True
ProgressBar1.Value = 0
ProgressBar1.Max = Data1.Recordset.RecordCount + 1
formato_fecha = "yyyymmdd"
Do While Not Data1.Recordset.EOF
  If Not Data1.Recordset!clnombre = "" Then
    Sql = ""
    Sql = "EXECUTE SP_CARGA_MDCL " & Mid(Data1.Recordset!clrut, 1, 9)
    Sql = Sql & "," & Chr(34) & Mid(Data1.Recordset!cldv, 1, 1) & Chr(34) & ","
    Sql = Sql & Mid(Data1.Recordset!clcodclie, 1, 9) & "," & Chr(34)
    Sql = Sql & Data1.Recordset!clnombre & Chr(34) & "," & Chr(34) & Data1.Recordset!clgeneric & Chr(34) & ","
    Sql = Sql & Chr(34) & Data1.Recordset!cldirecc & Chr(34) & "," & IIf(IsNull(Data1.Recordset!clcomuna), 0, Data1.Recordset!clcomuna) & ","
    Sql = Sql & IIf(IsNull(Data1.Recordset!clregion), 0, Data1.Recordset!clregion) & "," & IIf(IsNull(Data1.Recordset!clTipo), 0, Data1.Recordset!clTipo) & "," & Chr(34)
    Sql = Sql & Format(Data1.Recordset!clfecingr, formato_fecha) & Chr(34) & "," & Chr(34) & Data1.Recordset!cltelefon
    Sql = Sql & Chr(34) & "," & Chr(34) & Data1.Recordset!clfax & Chr(34) & "," & Chr(34) & Data1.Recordset!clcaljuri & Chr(34) & ","
    Sql = Sql & IIf(IsNull(Data1.Recordset!clcompint), 0, Data1.Recordset!clcompint) & "," & Chr(34) & Data1.Recordset!clreple & Chr(34) & "," & Chr(34) & Format(gsBac_Fecp, formato_fecha) & Chr(34) & "," & Chr(34)
    Sql = Sql & Format(gsBac_Fecp, formato_fecha) & Chr(34) & "," & Chr(34) & Format(gsBac_Fecp, formato_fecha) & Chr(34)
    Sql = Sql & "," & Chr(34) & IIf(Data1.Recordset!clTipo = 1, "N", "J") & Chr(34)
       
    
    Sql = BacStrTran(Sql, Chr(34) & Chr(34), Chr(34) & " " & Chr(34))
    If miSQL.SQL_Execute(Sql) <> 0 Then
         MsgBox ("error")
    End If
 End If
   Data1.Recordset.MoveNext
   ProgressBar1.Value = ProgressBar1.Value + 1
   
Loop
Label1.Caption = "Clientes Cargados Ok"
ProgressBar1.Visible = False
Label1.Visible = False

End Sub

Private Sub Cartera()

    Label1.Visible = True
    Label1.Caption = "Cargando Carteras"
    
    Dim Fecha, FECHA1, Serie As String
    
    Data1.RecordSource = "mdca.dbf"
    Data1.Refresh
    ProgressBar1.Visible = True
    ProgressBar1.Value = 0
    ProgressBar1.Max = Data1.Recordset.RecordCount + 1
    formato_fecha = "yyyymmdd"
    
    If miSQL.SQL_Execute("SP_BORRA_TABLAS_CARGATURA 1") <> 0 Then
        MsgBox ("No se puedo borrar mdca")
        ProgressBar1.Visible = False
        Exit Sub
    End If
    
    Do While Not Data1.Recordset.EOF
    
        Sql = ""
        Sql = "EXECUTE SP_CARGA_MDCA " & Chr(34) & Data1.Recordset!CAENTIDAD & Chr(34)
        Sql = Sql & "," & Chr(34) & Data1.Recordset!CACARTERA & Chr(34) & ","
        Sql = Sql & IIf(IsNull(Data1.Recordset!CANUMDOCU), 0, Data1.Recordset!CANUMDOCU)
        Sql = Sql & "," & IIf(IsNull(Data1.Recordset!CANUMOPER), 0, Data1.Recordset!CANUMOPER) & ","
        Sql = Sql & IIf(IsNull(Data1.Recordset!CACORRELA), 0, Data1.Recordset!CACORRELA) & "," & Chr(34)
        Serie = Data1.Recordset!cainstser
        
        If Mid(Trim(Data1.Recordset!cainstser), 1, 4) = "PDBC" Or Mid(Trim(Data1.Recordset!cainstser), 1, 4) = "PRBC" Or Mid(Trim(Data1.Recordset!cainstser), 1, 4) = "DPR " Or Mid(Trim(Data1.Recordset!cainstser), 1, 4) = "DPD " Or Mid(Trim(Data1.Recordset!cainstser), 1, 4) = "DPF " Then
                    Fecha = Right(Trim(Data1.Recordset!cainstser), 6)
                    FECHA1 = Right(Trim(Fecha), 2) + Mid(Trim(Fecha), 3, 2) + Left(Trim(Fecha), 2)
                    Serie = ""
                    Serie = Mid(Trim(Data1.Recordset!cainstser), 1, 4) + FECHA1
        End If
        
        Sql = Sql & Serie & Chr(34) & "," & Chr(34)
        Sql = Sql & Format(Data1.Recordset!CAFECEMIS, formato_fecha) & Chr(34) & "," & IIf(IsNull(Data1.Recordset!CARUTEMIS), 0, Data1.Recordset!CARUTEMIS)
        Sql = Sql & "," & Chr(34) & Data1.Recordset!CAGENEMIS & Chr(34) & ","
        Sql = Sql & IIf(IsNull(Data1.Recordset!CAMONEMIS), 0, Data1.Recordset!CAMONEMIS) & "," & IIf(IsNull(Data1.Recordset!CATASEMIS), 0, Data1.Recordset!CATASEMIS) & ","
        Sql = Sql & IIf(Mid(Trim(Data1.Recordset!cainstser), 1, 4) = "CERO" Or Mid(Trim(Data1.Recordset!cainstser), 1, 4) = "ZERO", 365, IIf(IsNull(Data1.Recordset!CABTSEMIS), 0, Data1.Recordset!CABTSEMIS)) & "," & Chr(34) & Format(Data1.Recordset!CAFECVCTO, formato_fecha) & Chr(34)
        Sql = Sql & "," & Chr(34) & Format(Data1.Recordset!CAFECPCUP, formato_fecha) & Chr(34) & "," & IIf(IsNull(Data1.Recordset!CANOMINAL), 0, Data1.Recordset!CANOMINAL)
        Sql = Sql & "," & IIf(IsNull(Data1.Recordset!CANOMINALP), 0, Data1.Recordset!CANOMINALP) & "," & IIf(IsNull(Data1.Recordset!CAVALVENC), 0, Data1.Recordset!CAVALVENC) & ","
        Sql = Sql & IIf(IsNull(Data1.Recordset!CARUTCLIC), 0, Data1.Recordset!CARUTCLIC) & "," & IIf(IsNull(Data1.Recordset!CACODCLIC), 0, Data1.Recordset!CACODCLIC) & "," & Chr(34)
        Sql = Sql & Format(Data1.Recordset!CAFECCOMP, formato_fecha) & Chr(34) & "," & IIf(IsNull(Data1.Recordset!CAVALCOMP), 0, Data1.Recordset!CAVALCOMP) & ","
        Sql = Sql & IIf(IsNull(Data1.Recordset!CATIRCOMP), 0, Data1.Recordset!CATIRCOMP) & "," & IIf(IsNull(Data1.Recordset!CABTSCOMP), 0, Data1.Recordset!CABTSCOMP) & ","
        Sql = Sql & IIf(IsNull(Data1.Recordset!CAVALCOMU), 0, Data1.Recordset!CAVALCOMU) & "," '& IIf(IsNull(Data1.Recordset!CAVALUMREA), 0, Data1.Recordset!CAVALUMREA) & "," '& Chr(34)
        Sql = Sql & Chr(34) & Data1.Recordset!CAFECVEND & Chr(34) & "," & IIf(IsNull(Data1.Recordset!CARUTCLIV), 0, Data1.Recordset!CARUTCLIV) & ","
        Sql = Sql & IIf(IsNull(Data1.Recordset!CACODCLIV), 0, Data1.Recordset!CACODCLIV) & "," & IIf(IsNull(Data1.Recordset!CATIRVENT), 0, Data1.Recordset!CATIRVENT) & ","
        Sql = Sql & IIf(IsNull(Data1.Recordset!CABTRVENT), 0, Data1.Recordset!CABTRVENT) & "," & IIf(IsNull(Data1.Recordset!CAVALVENP), 0, Data1.Recordset!CAVALVENP) & ","
        Sql = Sql & IIf(IsNull(Data1.Recordset!CAVALVENU), 0, Data1.Recordset!CAVALVENU) & "," & IIf(IsNull(Data1.Recordset!CARUTCLIP), 0, Data1.Recordset!CARUTCLIP) & ","
        Sql = Sql & IIf(IsNull(Data1.Recordset!CACODCLIP), 0, Data1.Recordset!CACODCLIP) & "," & Chr(34) & Format(Data1.Recordset!CAFECINIP, formato_fecha) & Chr(34)
        Sql = Sql & "," & Chr(34) & Format(Data1.Recordset!CAFECVTOP, formato_fecha) & Chr(34) & ","
        Sql = Sql & IIf(IsNull(Data1.Recordset!CAVALINIP), 0, Data1.Recordset!CAVALINIP) & "," & IIf(IsNull(Data1.Recordset!CAVALVTOP), 0, Data1.Recordset!CAVALVTOP) & ","
        Sql = Sql & IIf(IsNull(Data1.Recordset!CATASPACT), 0, Data1.Recordset!CATASPACT) & "," & IIf(IsNull(Data1.Recordset!CABTSPACT), 0, Data1.Recordset!CABTSPACT) & ","
        Sql = Sql & IIf(IsNull(Data1.Recordset!CAMONPACT), 0, Data1.Recordset!CAMONPACT) & "," & IIf(IsNull(Data1.Recordset!CAFORPPCT), 0, Data1.Recordset!CAFORPPCT) & ","
        Sql = Sql & IIf(IsNull(Data1.Recordset!CARETDOCU), 0, Data1.Recordset!CARETDOCU) & "," & IIf(IsNull(Data1.Recordset!CACOMPROM), 0, Data1.Recordset!CACOMPROM) & ","
        Sql = Sql & IIf(IsNull(Data1.Recordset!CAPRCVPAR), 0, Data1.Recordset!CAPRCVPAR) & "," & IIf(IsNull(Data1.Recordset!CACODIGO), 0, Data1.Recordset!CACODIGO) & ","
        Sql = Sql & Chr(34) & Data1.Recordset!CAPROG & Chr(34) & ","
        Sql = Sql & IIf(IsNull(Data1.Recordset!CAVPRESEN), 0, Data1.Recordset!CAVPRESEN) & "," & Chr(34)
        Sql = Sql & Data1.Recordset!CAINDPAC & Chr(34) & ","
        Sql = Sql & IIf(IsNull(Data1.Recordset!CANUMPAC), 0, Data1.Recordset!CANUMPAC) & "," & IIf(IsNull(Data1.Recordset!CAVALPARC), 0, Data1.Recordset!CAVALPARC) & ","
        Sql = Sql & IIf(IsNull(Data1.Recordset!CAVALPARCP), 0, Data1.Recordset!CAVALPARCP) & "," & IIf(IsNull(Data1.Recordset!CANOMIREAL), 0, Data1.Recordset!CANOMIREAL) & ","
        Sql = Sql & IIf(IsNull(Data1.Recordset!CAFORPAGO), 0, Data1.Recordset!CAFORPAGO) & "," & IIf(IsNull(Data1.Recordset!CAFORPAG1), 0, Data1.Recordset!CAFORPAG1) & ","
        Sql = Sql & IIf(IsNull(Data1.Recordset!CASALDAMOR), 0, Data1.Recordset!CASALDAMOR) & "," & Chr(34) & Data1.Recordset!CATIPOPER & Chr(34) & ","
        Sql = Sql & Chr(34) & Data1.Recordset!CANETTERM & Chr(34) & "," & Chr(34)
        Sql = Sql & Data1.Recordset!CANETUSER & Chr(34) & "," & Chr(34)
        Sql = Sql & Data1.Recordset!CACOMQUIEN & Chr(34) & "," & Chr(34)
        Sql = Sql & Data1.Recordset!CACOND_CI & Chr(34) & "," & Chr(34)
        Sql = Sql & Data1.Recordset!CACOND_VI & Chr(34) & "," & Chr(34)
        Sql = Sql & Data1.Recordset!CACOND_IT & Chr(34) & "," & Chr(34)
        Sql = Sql & Data1.Recordset!CAINST & Chr(34) & "," & IIf(IsNull(Data1.Recordset!Count), 0, Data1.Recordset!Count) & ","
        Sql = Sql & IIf(IsNull(Data1.Recordset!RESTA), 0, Data1.Recordset!RESTA) & "," & IIf(IsNull(Data1.Recordset!OLD_VPTE), 0, Data1.Recordset!OLD_VPTE) & ","
        Sql = Sql & Chr(34) & Data1.Recordset!CACODSUC & Chr(34) & ","
        Sql = Sql & IIf(IsNull(Data1.Recordset!VPTE_27), 0, Data1.Recordset!VPTE_27) & "," & IIf(IsNull(Data1.Recordset!NOMI_27), 0, Data1.Recordset!NOMI_27) & ","
        Sql = Sql & IIf(IsNull(Data1.Recordset!OLD_VCOMP), 0, Data1.Recordset!OLD_VCOMP) & "," & IIf(IsNull(Data1.Recordset!VPTE_31), 0, Data1.Recordset!VPTE_31) & ","
        Sql = Sql & IIf(IsNull(Data1.Recordset!NOMI_31), 0, Data1.Recordset!NOMI_31) & "," & Chr(34)
        Sql = Sql & Data1.Recordset!CALET_AST & Chr(34) & "," & Chr(34)
        Sql = Sql & Data1.Recordset!CAFG_VIV & Chr(34) & "," & Chr(34)
        Sql = Sql & Data1.Recordset!CAMARCA & Chr(34) & "," & Chr(34)
        Sql = Sql & Data1.Recordset!CARETDOCP & Chr(34) & ","
        Sql = Sql & IIf(IsNull(Data1.Recordset!CATASFIN), 0, Data1.Recordset!CATASFIN) & "," & Chr(34)
        Sql = Sql & Data1.Recordset!CAEMISOR & Chr(34) & "," & Chr(34)
        Sql = Sql & Data1.Recordset!CACODCALC & Chr(34) & "," & Chr(34)
        Sql = Sql & IIf(IsNull(Data1.Recordset!CANUMCOR), "", Data1.Recordset!CANUMCOR) & Chr(34) & ","
        Sql = Sql & IIf(IsNull(Data1.Recordset!CAVALCOM1), 0, Data1.Recordset!CAVALCOM1) & ","
        Sql = Sql & Chr(34) & IIf(IsNull(Data1.Recordset!CAOPERADR), 0, Data1.Recordset!CAOPERADR) & Chr(34) & ","
        Sql = Sql & "0," 'IIf(IsNull(Data1.Recordset!CAPRIMERA), 0, Data1.Recordset!CAPRIMERA) & ","
        Sql = Sql & Chr(34) & IIf(IsNull(Data1.Recordset!CARELAC), "", Data1.Recordset!CARELAC) & Chr(34) & ","
        Sql = Sql & IIf(IsNull(Data1.Recordset!CATASREAL), 0, Data1.Recordset!CATASREAL) & ","
        Sql = Sql & IIf(IsNull(Data1.Recordset!CABTSREAL), 0, Data1.Recordset!CABTSREAL) & ","
        Sql = Sql & IIf(IsNull(Data1.Recordset!CATIPCLI), 0, Data1.Recordset!CATIPCLI) & ","
        Sql = Sql & Chr(34) & IIf(IsNull(Data1.Recordset!CACTACTE), "", Data1.Recordset!CACTACTE) & Chr(34) & ","
        Sql = Sql & IIf(IsNull(Data1.Recordset!CAINTERES), 0, Data1.Recordset!CAINTERES) & "," & IIf(IsNull(Data1.Recordset!CAREAJUSTE), 0, Data1.Recordset!CAREAJUSTE) & ","
        Sql = Sql & IIf(IsNull(Data1.Recordset!CAVALEFEC), 0, Data1.Recordset!CAVALEFEC) & ","
        Sql = Sql & IIf(IsNull(Data1.Recordset!CAVALHOY), 0, Data1.Recordset!CAVALHOY) & ","
        Sql = Sql & IIf(IsNull(Data1.Recordset!CAVALORIG), 0, Data1.Recordset!CAVALORIG) & ","
        Sql = Sql & IIf(IsNull(Data1.Recordset!CASUCURSAL), 0, Data1.Recordset!CASUCURSAL) & ","
        Sql = Sql & IIf(IsNull(Data1.Recordset!CAINT_MES), 0, Data1.Recordset!CAINT_MES) & ","
        Sql = Sql & IIf(IsNull(Data1.Recordset!CAREA_MES), 0, Data1.Recordset!CAREA_MES) & "," & Chr(34)
        Sql = Sql & IIf(IsNull(Format(Data1.Recordset!CAFECCUP, formato_fecha)), "", Format(Data1.Recordset!CAFECCUP, formato_fecha)) & Chr(34) & ","
        Sql = Sql & IIf(IsNull(Data1.Recordset!CACORRVENT), 0, Data1.Recordset!CACORRVENT) & ","
        Sql = Sql & IIf(IsNull(Data1.Recordset!CAVALCOMO), 0, Data1.Recordset!CAVALCOMO) & ","
        Sql = Sql & Chr(34) & IIf(IsNull(Data1.Recordset!CACARTORIG), "", Data1.Recordset!CACARTORIG) & Chr(34) & ","
        Sql = Sql & IIf(IsNull(Data1.Recordset!CACUPCAP), 0, Data1.Recordset!CACUPCAP) & ","
        Sql = Sql & IIf(IsNull(Data1.Recordset!CACUPINT), 0, Data1.Recordset!CACUPINT) & ","
        Sql = Sql & IIf(IsNull(Data1.Recordset!CAINTFINM), 0, Data1.Recordset!CAINTFINM) & ","
        Sql = Sql & IIf(IsNull(Data1.Recordset!CAREAFINM), 0, Data1.Recordset!CAREAFINM) & ","
        Sql = Sql & IIf(IsNull(Data1.Recordset!CACUPGAN), 0, Data1.Recordset!CACUPGAN) & ","
        Sql = Sql & IIf(IsNull(Data1.Recordset!CACUPREA), 0, Data1.Recordset!CACUPREA) & ","
        Sql = Sql & IIf(IsNull(Data1.Recordset!CATIRTRAN), 0, Data1.Recordset!CATIRTRAN) & ","
        Sql = Sql & IIf(IsNull(Data1.Recordset!CADIFMCDOP), 0, Data1.Recordset!CADIFMCDOP) & ","
        Sql = Sql & IIf(IsNull(Data1.Recordset!CACORRCLIC), 0, Data1.Recordset!CACORRCLIC) & ","
        Sql = Sql & IIf(IsNull(Data1.Recordset!CACORRCLIV), 0, Data1.Recordset!CACORRCLIV) & ","
        Sql = Sql & IIf(IsNull(Data1.Recordset!CACORRCLIP), 0, Data1.Recordset!CACORRCLIP) & ","
        Sql = Sql & Chr(34) & IIf(IsNull(Data1.Recordset!CABONOS), "", Data1.Recordset!CABONOS) & Chr(34) & ","
        Sql = Sql & IIf(Data1.Recordset!CATC_SBIF <> 2 Or IsNull(Data1.Recordset!CATC_SBIF), 1, Data1.Recordset!CATC_SBIF) & ","
        Sql = Sql & IIf(IsNull(Data1.Recordset!CADURAT), 0, Data1.Recordset!CADURAT) & ","
        Sql = Sql & IIf(IsNull(Data1.Recordset!CADURAT_M), 0, Data1.Recordset!CADURAT_M) & ","
        Sql = Sql & IIf(IsNull(Data1.Recordset!CACONVEX), 0, Data1.Recordset!CACONVEX) & ","
        Sql = Sql & Chr(34) & IIf(IsNull(Data1.Recordset!CACORRES), "", Data1.Recordset!CACORRES) & Chr(34)
    
            
        Sql = BacStrTran(Sql, Chr(34) & Chr(34), Chr(34) & " " & Chr(34))
        If miSQL.SQL_Execute(Sql) <> 0 Then
             MsgBox ("Error Carga mdca")
             
        End If
    
       Data1.Recordset.MoveNext
       ProgressBar1.Value = ProgressBar1.Value + 1
       
    Loop

'    Sql = ""
'    Sql = "sp_cargatotal_mdca '" & Format(gsBac_Fecp, formato_fecha) & "','" & Format(gsBac_Fecx, "yyyymmdd") & "'"
'    If miSQL.SQL_Execute(Sql) <> 0 Then
'         MsgBox ("Error carga Cartera")
'         ProgressBar1.Visible = False
'         Exit Sub
'    End If
    
    Data1.RecordSource = "mdco.dbf"
    Data1.Refresh
    ProgressBar1.Visible = True
    ProgressBar1.Value = 0
    ProgressBar1.Max = Data1.Recordset.RecordCount + 1

    If miSQL.SQL_Execute("SP_BORRA_TABLAS_CARGATURA 2") <> 0 Then
             MsgBox ("error Borrar cortes")
    End If
    
    Do While Not Data1.Recordset.EOF
    
        Sql = ""
        Sql = "EXECUTE SP_CARGA_MDCO " & Data1.Recordset!conumdocu & ", "
        Sql = Sql & Data1.Recordset!conumoper & ", "
        Sql = Sql & Data1.Recordset!cocorrcar & ","
        Sql = Sql & IIf(IsNull(Data1.Recordset!comoncort), 0, Data1.Recordset!comoncort) & ","
        Sql = Sql & IIf(IsNull(Data1.Recordset!conumcort), 0, Data1.Recordset!conumcort) & ","
        Sql = Sql & IIf(IsNull(Data1.Recordset!coreal), 0, Data1.Recordset!coreal)
        
        
        If miSQL.SQL_Execute(Sql) <> 0 Then
             MsgBox ("error cortes")
        End If
        
        Data1.Recordset.MoveNext
        ProgressBar1.Value = ProgressBar1.Value + 1
        
     Loop
         
     Label1.Caption = "Cartera Cargada OK"
     ProgressBar1.Visible = False
     Label1.Visible = False
     
End Sub
Private Sub ConCheck_Click(Index As Integer)
SinCheck.Item(Index).Visible = Not SinCheck.Item(Index).Visible
ConCheck.Item(Index).Visible = Not ConCheck.Item(Index).Visible
End Sub

Private Sub Form_Activate()
Data1.DatabaseName = App.Path & "\DBF"
End Sub

Private Sub Form_Load()
Me.Width = 3450
Me.Height = 3450

End Sub

 

Private Sub SinCheck_Click(Index As Integer)
SinCheck.Item(Index).Visible = Not SinCheck.Item(Index).Visible
ConCheck.Item(Index).Visible = Not ConCheck.Item(Index).Visible
End Sub


Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Index
Case 1
Screen.MousePointer = 11
    If ConCheck(0).Visible = True Then Call Cartera
'    If ConCheck(1).Visible = True Then Call Clientes
Screen.MousePointer = 0
Case 2
    Unload Me
End Select
End Sub
