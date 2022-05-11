VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacIntPV01 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Interfaz Valorizacion de Mercado"
   ClientHeight    =   3210
   ClientLeft      =   2100
   ClientTop       =   2970
   ClientWidth     =   4455
   ForeColor       =   &H00C0C0C0&
   Icon            =   "BaciPV01.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   3210
   ScaleWidth      =   4455
   Visible         =   0   'False
   Begin Threed.SSPanel SSPanel1 
      Height          =   2715
      Left            =   30
      TabIndex        =   1
      Top             =   480
      Width           =   4320
      _Version        =   65536
      _ExtentX        =   7620
      _ExtentY        =   4789
      _StockProps     =   15
      Caption         =   "SSPanel1"
      BackColor       =   12632256
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BevelInner      =   1
      Begin Threed.SSFrame SSFrame1 
         Height          =   1020
         Left            =   165
         TabIndex        =   11
         Top             =   1605
         Width           =   3975
         _Version        =   65536
         _ExtentX        =   7011
         _ExtentY        =   1799
         _StockProps     =   14
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Begin Threed.SSPanel PorcPV01 
            Height          =   525
            Left            =   45
            TabIndex        =   13
            Top             =   405
            Width           =   3885
            _Version        =   65536
            _ExtentX        =   6853
            _ExtentY        =   926
            _StockProps     =   15
            ForeColor       =   16777215
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            BevelOuter      =   0
            BevelInner      =   2
            FloodType       =   1
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "Generación Archivo plano"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   195
            Left            =   45
            TabIndex        =   12
            Top             =   150
            Width           =   2220
         End
      End
      Begin VB.Frame Frame4 
         Caption         =   "Expotar a Excel  "
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   -1  'True
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   1350
         Left            =   180
         TabIndex        =   7
         Top             =   2775
         Width           =   3960
         Begin VB.PictureBox ConCheck 
            BorderStyle     =   0  'None
            Height          =   330
            Index           =   0
            Left            =   120
            Picture         =   "BaciPV01.frx":030A
            ScaleHeight     =   330
            ScaleWidth      =   330
            TabIndex        =   9
            Top             =   870
            Visible         =   0   'False
            Width           =   330
         End
         Begin VB.PictureBox SinCheck 
            BorderStyle     =   0  'None
            Height          =   330
            Index           =   0
            Left            =   120
            Picture         =   "BaciPV01.frx":0464
            ScaleHeight     =   330
            ScaleWidth      =   375
            TabIndex        =   8
            Top             =   930
            Width           =   375
         End
         Begin Threed.SSPanel PorcExcel 
            Height          =   525
            Left            =   45
            TabIndex        =   14
            Top             =   255
            Width           =   3870
            _Version        =   65536
            _ExtentX        =   6826
            _ExtentY        =   926
            _StockProps     =   15
            ForeColor       =   16777215
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            BevelOuter      =   0
            BevelInner      =   2
            FloodType       =   1
         End
         Begin VB.Label Etiqueta 
            AutoSize        =   -1  'True
            Caption         =   "Valorización cartera mercado por flujos"
            ForeColor       =   &H00800000&
            Height          =   195
            Index           =   3
            Left            =   600
            TabIndex        =   10
            Top             =   945
            Width           =   2730
         End
      End
      Begin VB.Frame Frame3 
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   -1  'True
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   1500
         Left            =   165
         TabIndex        =   2
         Top             =   75
         Width           =   3975
         Begin BACControles.TXTFecha TXTFecha 
            Height          =   255
            Left            =   960
            TabIndex        =   6
            Top             =   1080
            Width           =   1335
            _ExtentX        =   2355
            _ExtentY        =   450
            Enabled         =   -1  'True
            Enabled         =   -1  'True
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            MaxDate         =   2958465
            MinDate         =   -328716
            Text            =   "31/12/2003"
         End
         Begin VB.ComboBox Combo1 
            BeginProperty Font 
               Name            =   "Courier New"
               Size            =   9
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   345
            Left            =   180
            Style           =   2  'Dropdown List
            TabIndex        =   3
            Top             =   495
            Width           =   3675
         End
         Begin VB.Label lblEtiqueta 
            AutoSize        =   -1  'True
            Caption         =   "Fecha"
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
            Height          =   195
            Index           =   0
            Left            =   225
            TabIndex        =   5
            Top             =   1050
            Width           =   540
         End
         Begin VB.Label lblEtiqueta 
            AutoSize        =   -1  'True
            Caption         =   "Entidad"
            BeginProperty Font 
               Name            =   "Times New Roman"
               Size            =   9
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   225
            Index           =   1
            Left            =   180
            TabIndex        =   4
            Top             =   270
            Width           =   600
         End
      End
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   2835
      Top             =   45
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
            Picture         =   "BaciPV01.frx":05BE
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BaciPV01.frx":08D8
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BaciPV01.frx":0D2C
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BaciPV01.frx":1046
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BaciPV01.frx":1360
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Height          =   510
      Left            =   60
      TabIndex        =   0
      Top             =   -15
      Width           =   4290
      _ExtentX        =   7567
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Generar Archivo PV01"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Object.ToolTipText     =   "Genera planilla a Exel"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
End
Attribute VB_Name = "BacIntPV01"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim Sql As String
Dim Datos()
Dim TCartera As String
Dim TotReg_PV01 As Double
Function ESPACIOS_CL(Dato As String, Largo As Integer, alineacion As String)

If alineacion = "I" Then
    ESPACIOS_CL = 0
    If Len(Dato) <= Largo Then
        ESPACIOS_CL = Space((Largo - Len(Dato))) & Dato
    End If
Else
    ESPACIOS_CL = 0
    If Len(Dato) <= Largo Then
        ESPACIOS_CL = Dato & Space((Largo - Len(Dato)))
    End If
End If


End Function

Function funcGeneraPV01(iTotRegistros As Double)
Dim cSql            As String
Dim Datos()
Dim hFile%
Dim cCadenaWrite    As String
Dim nRegAct         As Double


On Error GoTo ErrInter


    funcGeneraPV01 = False
    nRegAct = 1
    'If ConCheck.Item(1).Visible Then
    '  cSql = "SP_ARCHIVOPV01 " & "'" & Format(TXTFecha.Text, "YYYYMMDD") & "'"
    'Else
      cSql = "SP_ARCHIVOPV01 " & "'" & Format(TXTFecha.Text, "YYYYMMDD") & "'"
    'End If
    If miSQL.SQL_Execute(cSql) <> 0 Then MsgBox "No fue posible recuperar la informacion para la fecha ingresada", vbCritical, gsc_bacversion: Screen.MousePointer = 0: Exit Function


        Open gsBac_DIRIN & "\CONFLUJO" & Format(TXTFecha.Text, "DDMMYYYY") & ".txt" For Output As #1

        'cCadenaWrite = "HEADER" & Chr(59) & "SAN" & Chr(59) & "EMERGING MARKETS" & Chr(59) & "LATIN AMERICAN LOCAL MARKETS" & Chr(59) & "TRADING" & Chr(59) & "TRADING" & Chr(59) & "IR" & Chr(59) & Trim$(CStr(iTotRegistros + 1)) & Chr(59) & Format$(gsBac_Fecp, "dd/mm/yyyy") & Chr(59) & gsBac_Dolar
        'Print #1, cCadenaWrite
    'nRegAct = 1
    
   Do While Bac_SQL_Fetch(Datos())
        If Datos(1) > 0 Then
        'Replace(Format(datos(34), "00000000.00000000"), gsBac_PtoDec, "")
        'ESPACIOS_CL(Trim(Str(datos(2))), 15, "D")
            cCadenaWrite = Datos(9) & Chr(59) & Datos(1) & Chr(59) & Datos(10) & Chr(59) & ESPACIOS_CL(Trim(Datos(2)), 15, "D") & Chr(59) & Format(Datos(3), "dd/mm/yyyy") & Chr(59) & Format(CDbl(Datos(4)), "###,###,##0.00") & Chr(59) & Format(CDbl(Datos(5)), "###,###,##0.00") & Chr(59) & ESPACIOS_CL(Trim(Datos(6)), 1, "D") & Chr(59) & ESPACIOS_CL(Trim(Datos(7)), 15, "D") & Chr(59) & Format(Datos(8))   ' & Chr(59) & datos(11)
            'Format(Str(datos(4))), 13), "000000000000000000")
              If (nRegAct * 100) / iTotRegistros > 100 Then
                 PorcPV01.FloodPercent = 100
              Else
                 PorcPV01.FloodPercent = (nRegAct * 100) / iTotRegistros
              End If
              Print #1, cCadenaWrite
              nRegAct = nRegAct + 1
        Else
              nRegAct = 0
        End If
    Loop
        If nRegAct > 0 Then
            PorcPV01.FloodPercent = 100
        Else
            PorcPV01.FloodPercent = 0
        End If

    Close #1
    
    funcGeneraPV01 = True
    Exit Function
ErrInter:
    Close #1
    MsgBox "No se pudo realizar generación de Archivo " & TipInter & ": <" & err.Description & ">.  Comunique al Administrador.", vbCritical, gsBac_Version
    
    Exit Function
End Function


Private Sub Cmd_Generar(Donde)
Dim Nombre_Rpt      As String: Nombre_Rpt = ""
Dim TipRep          As String
Dim Fecha           As String
Dim AuxTit          As String
Dim CDolar          As String
Dim Datos()

On Error GoTo Control:

    Sql = "SP_FIN_DE_MES "
    Sql = Sql & "'" & Format(TXTFecha.Text, "yyyymmdd") & "'"
     If Not Bac_Sql_Execute(Sql) Then
        MsgBox "SQL no responde ", 16
        Exit Sub
    End If
    Do While Bac_SQL_Fetch(Datos)
         Sw_Fin_De_Mes = Datos(1)
    Loop

    

Fecha = Format(TXTFecha.Text, feFECHA)


xentidad = Val(Trim$(Right$(Combo1, 10)))

Screen.MousePointer = 11

If Donde = "Impresora" Then
    BacTrader.bacrpt.Destination = 0
Else
    BacTrader.bacrpt.Destination = 1
End If

    Dim Inf%, x%, Marca  As Boolean
    
    Marca = False
    
    For x = 2 To 3
        If ConCheck.Item(x).Visible = True Then Marca = True
    Next x

    If Marca = False Then
        MsgBox "Debe Seleccionar Transable i/o Permanente ", vbInformation, TITSISTEMA
        Screen.MousePointer = vbDefault
        Exit Sub
    End If

    If ConCheck.Item(4).Visible = True Then
       CDolar = "S"
    Else
       CDolar = "N"
    End If

    
For I = 1 To ConCheck.Count - 1
   
    If ConCheck.Item(I).Visible = True Then

        Select Case I
        
              Case 1


                For x = 2 To 3

                     If ConCheck.Item(x).Visible = True Then

                        If x = 3 Then TCartera = "P": AuxTit = "PERMANENTE"
                        If x = 2 Then TCartera = "T": AuxTit = "TRANSABLE"

                        
                        If CDolar = "S" Then
                           AuxTit = AuxTit & " EN DOLARES"
                        End If
                        
                        Call Limpiar_Cristal
                        
                    'If Sw_Fin_De_Mes = 1 Then  ' fin de mes
                     If ConCheck.Item(1).Visible = True Then
                        
                         TipRpt = "VALORIZACION DE MERCADO " & AuxTit
                         BacTrader.bacrpt.ReportFileName = RptList_Path & "VALORMERC.RPT"
                         BacTrader.bacrpt.StoredProcParam(0) = "BTR"
                         BacTrader.bacrpt.StoredProcParam(1) = Fecha
                         BacTrader.bacrpt.StoredProcParam(2) = TCartera
                         BacTrader.bacrpt.StoredProcParam(3) = TipRpt
                         BacTrader.bacrpt.StoredProcParam(4) = CDolar
                         BacTrader.bacrpt.Connect = CONECCION
                         BacTrader.bacrpt.Action = 1
                    End If
                    End If
              Next x
                    
     Case 5
                  For x = 2 To 3

                         If ConCheck.Item(x).Visible = True Then

                         If x = 3 Then TCartera = "P": AuxTit = "PERMANENTE"
                         If x = 2 Then TCartera = "T": AuxTit = "TRANSABLE"

                        
                        If CDolar = "S" Then
                           AuxTit = AuxTit & " EN DOLARES"
                        End If
                        
                        Call Limpiar_Cristal
                     If ConCheck.Item(5).Visible = True And Sw_Fin_De_Mes <> 1 Then
                         TipRpt = "VALORIZACION DE MERCADO DIARIA " & AuxTit
                         BacTrader.bacrpt.ReportFileName = RptList_Path & "VALORMERC_DIA.RPT"
                         BacTrader.bacrpt.StoredProcParam(0) = "BTR"
                         BacTrader.bacrpt.StoredProcParam(1) = Fecha
                         BacTrader.bacrpt.StoredProcParam(2) = TCartera
                         BacTrader.bacrpt.StoredProcParam(3) = TipRpt
                         BacTrader.bacrpt.StoredProcParam(4) = CDolar
                         BacTrader.bacrpt.Connect = CONECCION
                         BacTrader.bacrpt.Action = 1
                    End If
                     
                     End If
               
                Next x
                
        End Select
    End If
Next

Screen.MousePointer = 0
Exit Sub
Control:
    MsgBox "Problemas al generar Listado de Cartera. " & err.Description & ", " & err.Number, vbCritical, "BACTRADER"
    Screen.MousePointer = 0
End Sub
Function BacProxHabil(xFecha As String) As String
Dim gsc_fechadma As String
    Dim dFecha As String
    
   dFecha = xFecha
   dFecha = Format(DateAdd("d", 1, dFecha), gsc_fechadma)

   Do While Not BacEsHabil(dFecha)
      dFecha = Format(DateAdd("d", 1, dFecha), gsc_fechadma)

   Loop

   BacProxHabil = dFecha


End Function



Private Sub Cmd_Salir_Click()
Unload Me
End Sub

Private Sub ConCheck_Click(Index As Integer)

SinCheck.Item(Index).Visible = Not SinCheck.Item(Index).Visible
ConCheck.Item(Index).Visible = Not ConCheck.Item(Index).Visible

End Sub



Private Sub Form_Load()
Dim x As Integer
Dim FecNueva As String
Dim Sql As String
    Me.Top = 0
    Me.Left = 0
    Me.Icon = BacTrader.Icon



    Screen.MousePointer = 11
    giAceptar% = False

    Combo1.Clear
'    Sql = "SP_LEER_ENTIDADES"

    If Bac_Sql_Execute("SP_LEER_ENTIDADES") Then
        Combo1.AddItem "TODAS LAS ENTIDADES                                                 "
        Do While Bac_SQL_Fetch(Datos())
            Combo1.AddItem Datos(1) & Space(50 + (30 - Len(Datos(1)))) & Str(Datos(2))
        Loop
    Else
        MsgBox "Proceso " & Sql & "no existe", vbOKOnly + vbCritical, "Entidades"
        Unload Me
    End If
    
    
   
    Combo1.ListIndex = 0
    
    TXTFecha.Text = gsBac_Fecp

   Screen.MousePointer = 0


End Sub


Private Sub SSCommand1_Click()

End Sub


Private Sub SinCheck_Click(Index As Integer)
    ConCheck.Item(Index).Left = SinCheck.Item(Index).Left
    SinCheck.Item(Index).Visible = Not SinCheck.Item(Index).Visible
    ConCheck.Item(Index).Visible = Not ConCheck.Item(Index).Visible
End Sub


Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Index

Case 1
    Dim cSql As String
    Dim Data()

    Screen.MousePointer = vbHourglass
    TotReg_PV01 = 0
    cSql = "SP_INTERFAZ_PV01_OLD" & Format(TXTFecha.Text, "'YYYYMMDD'")    '***CMN***
    'cSql = "SP_INTERFAZ_PV01"         ***CMN***
    If miSQL.SQL_Execute(cSql) <> 0 Then: Screen.MousePointer = vbDefault: Exit Sub
    If miSQL.SQL_Fetch(Data()) <> 0 Then: Screen.MousePointer = vbDefault: Exit Sub
    If Data(1) <> "SI" Then
        MsgBox "Problemas en generación de Interfaz", vbCritical, gsBac_Version
        Exit Sub
    Else
        TotReg_PV01 = Data(2)
    End If
    TotReg_PV01 = 11
    PorcPV01.FloodPercent = 0
    Call funcGeneraPV01(TotReg_PV01)
    Screen.MousePointer = vbDefault
    MsgBox "Generación de archivo finalizado.", vbInformation, gsBac_Version
    Toolbar1.Buttons(1).Enabled = False

 Case 2
         If ConCheck.Item(0).Visible = False Then
            MsgBox "Debe seleccionar Exportar a Excel"
            Exit Sub
         End If
        TotReg_PV01 = 0
        PorcExcel.FloodPercent = 0
        Call Exporta_Excel
  
        MousePointer = 0
Case 3
    Unload Me

End Select

End Sub

Function Exporta_Excel()
Dim Linea As String
Dim Arr()
Dim Data()
Dim J As Double
Dim I As Double
Dim Exc
Dim Hoja
Dim S As Integer
Dim Sheet
Dim ruta As String
Dim Crea_xls As Boolean
Dim nRegAct As Double
'Const Filas_Buffer = 55000
ruta = gsBac_DIREXEL & "PV01" & Format(TXTFecha.Text, "mmddYYYY") & ".xls" ' NOMBRE 'ruta del .XLS
Screen.MousePointer = 11
DoEvents
'Sql = "SP_INTERFAZ_PV01"              ***CMN***

Sql = "SP_INTERFAZ_PV01_OLD " & Format(TXTFecha.Text, "'YYYYMMDD'")    '***CMN***

If Not Bac_Sql_Execute(Sql) Then MsgBox "No se pudo generar Planilla", vbCritical, gsBac_Version: Screen.MousePointer = 0: Exit Function
    If miSQL.SQL_Fetch(Data()) <> 0 Then: Screen.MousePointer = vbDefault: Exit Function
    If Data(1) <> "SI" Then
        MsgBox "Problemas en generación de la interfaz", vbCritical, gsBac_Version
        Exit Function
    Else
        TotReg_PV01 = Data(2)
    End If
'TotReg_PV01 = 11
Const Filas_Buffer = 55000 '150

Sql = "SP_ARCHIVOPV01 " & Format(TXTFecha.Text, "'YYYYMMDD'")   '***CMN***

If Not Bac_Sql_Execute(Sql) Then MsgBox "No fue posible recuperar la informacion para la fecha ingresada", vbCritical, gsc_bacversion: Screen.MousePointer = 0: Exit Function
nRegAct = 0
Set Exc = CreateObject("Excel.Application")
Set Hoja = Exc.Application.Workbooks.Add.Sheets.Add
Set Sheet = Exc.ActiveSheet
Linea = ""
Linea = Linea & "Numero Operacion" & vbTab   '----1
Linea = Linea & "Serie Bolsa" & vbTab        '----2
Linea = Linea & "Fecha Flujo" & vbTab        '----3
Linea = Linea & "Flujo" & vbTab              '----4
Linea = Linea & "Tir Mercado" & vbTab        '----5
Linea = Linea & "Tipo Cartera" & vbTab       '----6
Linea = Linea & "Disp/Intermed" & vbTab      '----7
Linea = Linea & "Moneda" & vbTab             '----8
Clipboard.Clear
Clipboard.SetText Linea
Sheet.Range("A1").Select
Sheet.Paste
Linea = ""
Clipboard.Clear
I = 1
nRegAct = 1
Do While Bac_SQL_Fetch(Arr())
   If I = 995 Then
        I = I
   End If
    For J = 1 To 8
        If (J >= 1 And J < 3) Or (J > 3 And J < 9) Then
            If J = 4 Then
               'Linea = Linea & Format(BacStrTran(IIf(Trim(Arr(J)) = "", 0, Trim(Arr(J))), ",", "."), "###,###,##0.00") & vbTab
               Linea = Linea & Format(IIf(Trim(Arr(J)) = "", 0, Trim(Arr(J))), "###,###,##0.00") & vbTab
            Else
               Linea = Linea & BacStrTran(IIf(Trim(Arr(J)) = "", 0, Trim(Arr(J))), ",", ".") & vbTab
            End If
        Else
            Linea = Linea & Format(IIf(Trim(Arr(J)) = "", "01/01/1900", Trim(Arr(J))), "mm/dd/yyyy") & vbTab
        End If
    Next J

    If (nRegAct * 100) / TotReg_PV01 > 100 Then
        PorcExcel.FloodPercent = 100
    Else
        PorcExcel.FloodPercent = (nRegAct * 100) / TotReg_PV01
    End If
    nRegAct = nRegAct + 1
    Linea = Linea + vbCrLf
    If I Mod Filas_Buffer = 0 Then
        Clipboard.Clear
        Clipboard.SetText Linea
        If I = Filas_Buffer Then
            Sheet.Range("A2").Select
        Else
            Sheet.Range("A" & CStr((I + 1) - Filas_Buffer)).Select
        End If
        Sheet.Paste
        Linea = ""
   End If

    Crea_xls = True
    I = I + 1
Loop
        If nRegAct > 0 Then
            PorcExcel.FloodPercent = 100
        Else
            PorcExcel.FloodPercent = 0
        End If
Clipboard.Clear
Clipboard.SetText Linea
Sheet.Range("A" & CStr((Int(I / Filas_Buffer) * Filas_Buffer) + IIf(I > Filas_Buffer, 1, 2))).Select
Sheet.Paste
Linea = ""
Clipboard.Clear

Sheet.Range("A1").Select

Hoja.Application.DisplayAlerts = False
For I = 2 To Hoja.Application.Sheets.Count
  Hoja.Application.Sheets(2).Delete
Next I
If Crea_xls Then
    Hoja.SaveAs (ruta)
Else
    MsgBox "No se encontró Información para generar el Excel", vbExclamation, gsBac_Version
    Hoja.Application.Workbooks.Close
    MousePointer = 0
    Exit Function
End If
Hoja.Application.Workbooks.Close

Screen.MousePointer = 0

Set Hoja = Nothing
Set Exc = Nothing
Set Sheet = Nothing

Shell (gsBac_Office & "EXCEL.EXE  " & ruta)

 ConCheck_Click 0

End Function


Function Nombre_Archivo(ByRef ruta As String, Def_Name As String, Optional Titulo As String, Optional Nom_Filtro As String, Optional Ext_Filtro As String, Optional Def_Path As String) As Boolean
''Dim Dialogo As CommonDialog
''Dim Contenedor As Form
''
''
''On Error GoTo Error
''
''Set Contenedor = New Frm_Rec
''Contenedor.Hide
''Contenedor.Visible = False
''
''
''If Trim(Titulo) = "" Then Titulo = "Guardar Como"
''If Trim(Nom_Filtro) = "" Then Nom_Filtro = "Planilla Excel"
''If Trim(Ext_Filtro) = "" Then Ext_Filtro = "*.xls"
''If Trim(Def_Path) = "" Then Def_Path = App.Path
''
''
''Contenedor.Dialogo.CancelError = True
''Contenedor.Dialogo.DialogTitle = Titulo
''Contenedor.Dialogo.Filter = Nom_Filtro & "|" & Ext_Filtro & "|"
''Contenedor.Dialogo.InitDir = Def_Path
''Contenedor.Dialogo.FileName = Def_Name
''Contenedor.Dialogo.ShowSave
''
''
''Nombre_Archivo = True
''ruta = Contenedor.Dialogo.FileName
''Set Contenedor = Nothing
''
''Exit Function
''
''Error:
''    Nombre_Archivo = False
''    Set Contenedor = Nothing

End Function            ' jlc


Private Sub TXTFecha_Click()

If TXTFecha.Text > gsBac_Fecp Then
   MsgBox "Fecha no puede ser mayor a la fecha de proceso 1", vbInformation, Me.Caption
   Exit Sub
End If


End Sub

Private Sub TXTFecha_DblClick()

If TXTFecha.Text > gsBac_Fecp Then
   MsgBox "Fecha no puede ser mayor a la fecha de proceso 2", vbInformation, Me.Caption
   Exit Sub
End If

End Sub

Private Sub TXTFecha_GotFocus()

If TXTFecha.Text > gsBac_Fecp Then
   MsgBox "Fecha no puede ser mayor a la fecha de proceso 3", vbInformation, Me.Caption
   Exit Sub
End If

End Sub

Private Sub TXTFecha_LostFocus()

If TXTFecha.Text > gsBac_Fecp Then
   MsgBox "Fecha no puede ser mayor a la fecha de proceso 4", vbInformation, Me.Caption
   Exit Sub
End If

End Sub

