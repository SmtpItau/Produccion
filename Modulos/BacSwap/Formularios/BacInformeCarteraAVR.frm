VERSION 5.00
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.3#0"; "comctl32.ocx"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacInformeCarteraAVR 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Infome Cartera con Resultados Reconocidos o A.V.R."
   ClientHeight    =   4485
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   7845
   BeginProperty Font 
      Name            =   "Times New Roman"
      Size            =   8.25
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   ForeColor       =   &H00000000&
   Icon            =   "BacInformeCarteraAVR.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   4485
   ScaleWidth      =   7845
   ShowInTaskbar   =   0   'False
   Begin ComctlLib.Toolbar Toolbar1 
      Height          =   480
      Left            =   120
      TabIndex        =   8
      Top             =   0
      Width           =   7425
      _ExtentX        =   13097
      _ExtentY        =   847
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   327682
      BeginProperty Buttons {0713E452-850A-101B-AFC0-4210102A8DA7} 
         NumButtons      =   4
         BeginProperty Button1 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Key             =   ""
            Object.ToolTipText     =   "Pantalla"
            Object.Tag             =   ""
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Key             =   ""
            Object.ToolTipText     =   "Impresora"
            Object.Tag             =   ""
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Key             =   ""
            Object.ToolTipText     =   "Genera Archivo Excel"
            Object.Tag             =   ""
            ImageIndex      =   4
         EndProperty
         BeginProperty Button4 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Caption         =   "Excel"
            Key             =   ""
            Object.ToolTipText     =   "Salir"
            Object.Tag             =   ""
            ImageIndex      =   3
         EndProperty
      EndProperty
   End
   Begin VB.Frame Frame1 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   3825
      Left            =   120
      TabIndex        =   9
      Top             =   600
      Width           =   7410
      Begin VB.Frame Frame8 
         Caption         =   "Rango de Fechas"
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
         Height          =   735
         Left            =   120
         TabIndex        =   16
         Top             =   3000
         Width           =   7095
         Begin BACControles.TXTFecha fecHasta 
            Height          =   315
            Left            =   3600
            TabIndex        =   7
            Top             =   240
            Width           =   1440
            _ExtentX        =   2540
            _ExtentY        =   556
            Enabled         =   -1  'True
            Enabled         =   -1  'True
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            MaxDate         =   2958465
            MinDate         =   -328716
            Text            =   "25/10/2000"
         End
         Begin BACControles.TXTFecha fecDesde 
            Height          =   315
            Left            =   840
            TabIndex        =   6
            Top             =   240
            Width           =   1410
            _ExtentX        =   2487
            _ExtentY        =   556
            Enabled         =   -1  'True
            Enabled         =   -1  'True
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            MaxDate         =   2958465
            MinDate         =   -328716
            Text            =   "25/10/2000"
         End
         Begin VB.Label lblEtiquetaD 
            AutoSize        =   -1  'True
            Caption         =   "Hasta"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   195
            Index           =   1
            Left            =   2880
            TabIndex        =   18
            Top             =   360
            Width           =   420
         End
         Begin VB.Label lblEtiquetaD 
            AutoSize        =   -1  'True
            Caption         =   "Desde"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   195
            Index           =   0
            Left            =   120
            TabIndex        =   17
            Top             =   360
            Width           =   465
         End
      End
      Begin VB.Frame Frame2 
         Caption         =   "Cliente"
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
         Height          =   735
         Left            =   120
         TabIndex        =   15
         Top             =   2160
         Width           =   7095
         Begin VB.TextBox txtCliente 
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   315
            Left            =   120
            MouseIcon       =   "BacInformeCarteraAVR.frx":0442
            MousePointer    =   99  'Custom
            TabIndex        =   5
            ToolTipText     =   "Doble click para desplegar ayuda"
            Top             =   240
            Width           =   6780
         End
      End
      Begin VB.Frame Frame4 
         Caption         =   "Area Responsable"
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
         Height          =   615
         Left            =   120
         TabIndex        =   14
         Top             =   1480
         Width           =   3510
         Begin VB.ComboBox Cmb_Area_Responsable 
            Height          =   330
            Left            =   75
            Style           =   2  'Dropdown List
            TabIndex        =   4
            Top             =   210
            Width           =   3345
         End
      End
      Begin VB.Frame Frame5 
         Caption         =   "Cartera Normativa"
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
         Height          =   615
         Left            =   3720
         TabIndex        =   13
         Top             =   180
         Width           =   3510
         Begin VB.ComboBox Cmb_Cartera_Normativa 
            Height          =   330
            Left            =   90
            Style           =   2  'Dropdown List
            TabIndex        =   1
            Top             =   210
            Width           =   3345
         End
      End
      Begin VB.Frame Frame6 
         Caption         =   "Operador"
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
         Height          =   615
         Left            =   3720
         TabIndex        =   12
         Top             =   840
         Width           =   3510
         Begin VB.ComboBox cmb_OperadorCod 
            Height          =   330
            Left            =   120
            Style           =   2  'Dropdown List
            TabIndex        =   19
            Top             =   240
            Visible         =   0   'False
            Width           =   390
         End
         Begin VB.ComboBox cmb_OperadorNom 
            Height          =   330
            Left            =   120
            Style           =   2  'Dropdown List
            TabIndex        =   3
            Top             =   210
            Width           =   3345
         End
      End
      Begin VB.Frame Frame7 
         Caption         =   "Libro"
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
         Height          =   615
         Left            =   120
         TabIndex        =   11
         Top             =   840
         Width           =   3510
         Begin VB.ComboBox Cmb_Libro 
            Height          =   330
            Left            =   90
            Style           =   2  'Dropdown List
            TabIndex        =   2
            Top             =   210
            Width           =   3345
         End
      End
      Begin VB.Frame Frame3 
         Caption         =   "Tipo de Cartera"
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
         Height          =   615
         Left            =   120
         TabIndex        =   10
         Top             =   180
         Width           =   3510
         Begin VB.ComboBox Cmb_Cartera 
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   315
            Left            =   90
            Style           =   2  'Dropdown List
            TabIndex        =   0
            Top             =   210
            Width           =   3345
         End
      End
   End
   Begin ComctlLib.ImageList ImageList1 
      Left            =   5760
      Top             =   120
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   327682
      BeginProperty Images {0713E8C2-850A-101B-AFC0-4210102A8DA7} 
         NumListImages   =   4
         BeginProperty ListImage1 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "BacInformeCarteraAVR.frx":074C
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "BacInformeCarteraAVR.frx":0A66
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "BacInformeCarteraAVR.frx":0D80
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "BacInformeCarteraAVR.frx":109A
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "BacInformeCarteraAVR"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Public Tipo_Producto            As String
Dim TRutClie As String

Private Sub Form_Load()
    Me.Icon = BACSwap.Icon
    
    'PRD-5149, jbh, 12-01-2010, para evitar "paseo" del form por la pantalla
    Me.Top = 0
    Me.Left = 0
    
    'optRecibimos.Value = True
    'Func_Cartera Cmb_Cartera, "PCS"
    'gsBac_DIRCONTA
    Call PROC_LLENA_COMBOS(Cmb_Cartera, 3, True, GLB_CARTERA)
    Call PROC_LLENA_COMBOS(Cmb_Area_Responsable, 3, True, GLB_AREA_RESPONSABLE)
    Call PROC_LLENA_COMBOS(Cmb_Libro, 3, True, GLB_LIBRO)
    Call PROC_LLENA_COMBOS(Cmb_Cartera_Normativa, 3, True, GLB_CARTERA_NORMATIVA)
    Call Operadores
    
    fecHasta.Text = gsBAC_Fecp
    fecDesde.Text = gsBAC_Fecp
    TRutClie = "0"
End Sub

Private Sub fecDesde_LostFocus()
   If Format(fecDesde.Text, "yyyymmdd") > Format(fecHasta.Text, "yyyymmdd") Then
      MsgBox "La Fecha Desde debe ser Menor o Igual a Fecha Hasta.", vbCritical, Msj
   End If
End Sub


Private Sub fecHasta_LostFocus()
   If Format(fecHasta.Text, "yyyymmdd") < Format(fecDesde.Text, "yyyymmdd") Then
      MsgBox "La Fecha Desde debe ser Mayor o Igual a Fecha Hasta.", vbCritical, Msj
   End If
End Sub

Private Sub Cmb_Cartera_Normativa_Click()
'    If Cmb_Cartera_Normativa.ListIndex > 0 Then
'        Call PROC_LLENA_COMBOS(cmb_OperadorNom, 1, True, GLB_SUB_CARTERA_NORMATIVA, Trim(Right(Cmb_Cartera_Normativa.Text, 10)))
'    Else
'        cmb_OperadorNom.Clear
'        cmb_OperadorNom.AddItem "<TODOS [AS]>" + Space(100)
'        cmb_OperadorNom.ListIndex = 0
'    End If
End Sub

Private Sub cmb_OperadorNom_Change()
    cmb_OperadorCod.ListIndex = cmb_OperadorNom.ListIndex
End Sub

Private Sub cmb_OperadorNom_Click()
    If cmb_OperadorCod.ListIndex <> -1 Then
        cmb_OperadorCod.ListIndex = cmb_OperadorNom.ListIndex
    End If
End Sub

Private Sub Form_Unload(Cancel As Integer)

'    BacInformeCartera.Tag = ""

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As ComctlLib.Button)
    If Button.Index <> 4 Then
        If Format(fecDesde.Text, "yyyymmdd") > Format(fecHasta.Text, "yyyymmdd") Then
           MsgBox "La Fecha Desde debe ser Menor o Igual a Fecha Hasta.", vbCritical, gsBAC_Version
           Exit Sub
        End If
        If Format(fecHasta.Text, "yyyymmdd") < Format(fecDesde.Text, "yyyymmdd") Then
           MsgBox "La Fecha Desde debe ser Mayor o Igual a Fecha Hasta.", vbCritical, gsBAC_Version
           Exit Sub
        End If
    End If
    If txtCliente.Text = "" Then
        TRutClie = "0"
    End If
    Select Case Button.Index
    Case 1
      Call InformeCartera("Pantalla")
    Case 2
      Call BacLimpiaParamCrw
      Call InformeCartera("Impresora")
    Case 3
        GeneraInfExcel
    Case 4
      Unload BacInformeCarteraAVR
    End Select
End Sub

Private Sub txtCliente_Change()
    If Len(txtCliente.Text) > 0 And gsCodigo = "" Then
        txtCliente.Text = ""
    End If
End Sub

Private Sub txtCliente_DblClick()
Dim Cliente As New clsCliente

    If Not Cliente.Ayuda("") Then
        MsgBox "No Existen Datos para ayuda solicitada", vbExclamation, Msj
        Exit Sub
    End If
    
        'BacAyudaSwap.Tag = "Cliente"
        'BacAyudaSwap.Show 1
        BacAyudaCliente.Tag = "Cliente"
        BacAyudaCliente.Show 1
    'gsCodigo = "0"
    If giAceptar Then
        If Cliente.LeerxRut(CDbl(gsCodigo), CDbl(gsCodCli)) Then
        'If Cliente.LeerxRut(Cliente.clrut, Cliente.clcodigo) Then
            TRutClie = gsCodigo
            txtCliente.Text = Cliente.clnombre
            txtCliente.Tag = Cliente.clcodigo
'            optCliente.Tag = Cliente.clrut
        Else
            MsgBox "No se encontro información de Cliente solicitado", vbCritical, Msj
        End If
    End If
    gsCodigo = ""
    Set Cliente = Nothing

End Sub


Function GeneraInfExcel()
On Error GoTo ErrLevel:
'funcion que crea el archivo excel de carteras con resultados reconocidos o AVR
    Dim Linea       As String
    Dim Arr()
    Dim J           As Double
    Dim I           As Double
    Dim Exc
    Dim Hoja
    Dim S           As Integer
    Dim Sheet
    Dim ruta        As String
    Dim Crea_xls    As Boolean
    Dim retorno     As Double
    Dim xLibro      As String
    Dim xAreaNeg    As String
    Dim fdesde      As String
    Dim fHasta      As String
    Dim TCarteraN   As String
    Dim TCarteraf   As String
    Dim TOperador   As String
    Dim SQL         As String
'    Dim TRutClie    As String
    Dim TipRpt      As String
    Dim NombreArch  As String
    Const Filas_Buffer = 2500 '150
    Dim nombre_arch As String

   ' Screen.MousePointer = vbHourglass

    If MsgBox("¿ Seguro que desea generar la planilla excel para la Cartera con Resultados Reconocidos o AVR?", vbQuestion + vbYesNo) = vbNo Then
        Screen.MousePointer = vbDefault
        Exit Function
    End If
    TCarteraN = ""
    TCarteraN = Trim(Right(Cmb_Cartera_Normativa.Text, 1))
    TCarteraf = IIf(Trim(Right(Cmb_Cartera.Text, 1)) <> "", Trim(Right(Cmb_Cartera.Text, 1)), "0") ' cartera financiera
    
    xLibro = Trim(Right(Cmb_Libro.Text, 10))
    xAreaNeg = Trim(Right(Cmb_Area_Responsable.Text, 10))
    TipRpt = "CARTERA DE RENTA FIJA CON RESULTADOS RECONOCIDOS O A.V.R. " '& AuxTit
    fdesde = Format(fecDesde.Text, "DD/MM/YYYY")
    fHasta = Format(fecHasta.Text, "DD/MM/YYYY")
    TOperador = cmb_OperadorCod.Text
'    TRutClie = IIf(txtCliente.Text = "", 0, txtCliente.Text)
'    NombreArch = "tasamer" & Format(fecDesde.Text, "mmdd") & ".xls"
    NombreArch = "SWP_AVR" & Format(gsBAC_Fecp, "mmdd") & ".xls"

'    Ruta = gsBac_DIREXEL & NombreArch '"tasamer" & Format(fecDesde.text, "mmdd") & ".xls" ' NOMBRE 'ruta del .XLS
    
    Frm_Guarda_Ruta.Txtpath.Text = "C:\"
    Frm_Guarda_Ruta.Show 1
    
    If Mid(BacInformeCarteraAVR.Tag, Len(BacInformeCarteraAVR.Tag), 1) = "\" Then
        nombre_arch = BacInformeCarteraAVR.Tag & NombreArch
    Else
        nombre_arch = BacInformeCarteraAVR.Tag & "\" & NombreArch
    End If
        
'    DoEvents

    SQL = "SP_INFORME_CARTERA_AVR  " & _
            "'" & fdesde & "'," & _
            "'" & fHasta & "'," & _
            TCarteraf & "," & _
            "'" & TCarteraN & "'," & _
            "'" & xLibro & "'," & _
            "'" & xAreaNeg & "','" & _
            TOperador & "'," & _
            TRutClie & ",'" & _
            TipRpt & "',''"
            
    If Not Bac_Sql_Execute(SQL) Then MsgBox "No se pudo generar Planilla", vbCritical, gsBAC_Version: Screen.MousePointer = vbDefault: Exit Function
    Set Exc = CreateObject("Excel.Application")
    Set Hoja = Exc.Application.Workbooks.Add.Sheets.Add
    Set Sheet = Exc.ActiveSheet
    
    ''''''''''''''''''''''''''
    'Titulos en Archivo EXCEL
    Linea = ""
    Linea = Linea & "Fecha Proceso" & vbTab
    Linea = Linea & "Numero" & vbTab
    Linea = Linea & "Marca" & vbTab
    Linea = Linea & "Tipo" & vbTab
    Linea = Linea & "Flujo" & vbTab
    Linea = Linea & "Cartera" & vbTab
    Linea = Linea & "FecInicio" & vbTab
    Linea = Linea & "FecTermino" & vbTab
    Linea = Linea & "Convexidad" & vbTab
    Linea = Linea & "Macaulay" & vbTab
    Linea = Linea & "Modificada" & vbTab
    Linea = Linea & "Moneda" & vbTab
    Linea = Linea & "Capital" & vbTab
    Linea = Linea & "Saldo" & vbTab
    Linea = Linea & "TipoTasa" & vbTab
    Linea = Linea & "Tasa" & vbTab
    Linea = Linea & "vRazonableMn" & vbTab
    Linea = Linea & "vRazonableMx" & vbTab
    Linea = Linea & "InformeProceso" & vbTab
    Linea = Linea & "InformeEmision" & vbTab
    Linea = Linea & "InformeHora" & vbTab
    Linea = Linea & "Usuario" & vbTab
    Linea = Linea & "SubCartera" & vbTab
    Linea = Linea & "vRazNetoMn" & vbTab
    Linea = Linea & "vRazNetoMx" & vbTab
    Linea = Linea & "tasaajustada" & vbTab
    Linea = Linea & "DifNetoMonMn" & vbTab
    Linea = Linea & "DifNetoMonMx" & vbTab
    Clipboard.Clear
    Clipboard.SetText Linea
    Sheet.Range("A1").Select
    Sheet.Paste
    Linea = ""
    Clipboard.Clear

    I = 1
    Do While Bac_SQL_Fetch(Arr())
        If I = 995 Then
            I = I
        End If
        For J = 1 To 28
            If (J >= 1 And J < 3) Or (J > 3 And J < 39) Then
                Linea = Linea & BacStrTran(IIf(Trim(Arr(J)) = "", 0, Trim(Arr(J))), ",", ".") & vbTab
            Else
                If J = 3 Then
                    Linea = Linea & Format(IIf(Trim(Arr(J)) = "", "01/01/1900", Trim(Arr(J))), "mm/dd/yyyy") & vbTab
                End If

                If J = 6 Then
                    Linea = Linea & BacStrTran(IIf(Trim(Arr(J)) = "", 0, Trim(Arr(J))), ",", ".") & vbTab
                End If

'                If Sw_Fin_De_Mes = 0 Then
'                    If J = 13 Then
'                        Linea = Linea & Format(IIf(Trim(Arr(J)) = "", "01/01/1900", Trim(Arr(J))), "mm/dd/yyyy") & vbTab
'                    End If
'                End If
            End If
        Next J
        
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
'        Hoja.SaveAs (Ruta)
        Hoja.SaveAs (nombre_arch)
    Else
        Hoja.Application.Workbooks.Close
        MousePointer = 0
        MsgBox "No se encontró Información para generar el Excel", vbExclamation, gsBAC_Version
        Exit Function
    End If
    
    Hoja.Application.Workbooks.Close
    
    Screen.MousePointer = vbDefault
    MsgBox "El archivo " & nombre_arch & " de Cartera con Resultados Reconocidos o AVR se genero en forma OK ", vbInformation, Msj

    Set Hoja = Nothing
    Set Exc = Nothing
    Set Sheet = Nothing
    Screen.MousePointer = vbDefault
    'retorno = Shell("EXCEL.EXE  " & ruta, vbMaximizedFocus)
    'retorno = Shell("C:\Archivos de programa\Microsoft Office\Office\EXCEL.EXE  " & Ruta, vbMaximizedFocus)
ErrLevel:
    'err.Source
    If err.Description <> "" Then
        MsgBox err.Description, vbInformation, Msj
    End If
    Screen.MousePointer = vbDefault
End Function

Function InformeCartera(Donde)
    On Error GoTo Control
    Dim QueOp As String
    Dim TipoSwap As Integer
    Dim xLibro      As String
    Dim xAreaNeg    As String
    Dim fdesde      As String
    Dim fHasta      As String
    Dim TCarteraN   As String
    Dim TCarteraf   As String
    Dim TOperador   As String
    Dim SQL         As String
'    Dim TRutClie    As String
    Dim TipRpt      As String
    Dim NombreArch  As String
    Dim ruta        As String
    TCarteraN = ""
    TCarteraN = Trim(Right(Cmb_Cartera_Normativa.Text, 1))
    TCarteraf = IIf(Trim(Right(Cmb_Cartera.Text, 1)) <> "", Trim(Right(Cmb_Cartera.Text, 1)), "0") ' cartera financiera
    
    xLibro = Trim(Right(Cmb_Libro.Text, 10))
    xAreaNeg = Trim(Right(Cmb_Area_Responsable.Text, 10))
    TipRpt = "CARTERA SWAP CON RESULTADOS RECONOCIDOS o A.V.R." '& AuxTit
    fdesde = Format(fecDesde.Text, "DD/MM/YYYY")
    fHasta = Format(fecHasta.Text, "DD/MM/YYYY")
    TOperador = cmb_OperadorCod.Text
'    TRutClie = IIf(txtCliente.Text = "", 0, txtCliente.Text)
    NombreArch = "tasamer" & Format(fecDesde.Text, "mmdd") & ".xls"
    'ruta = gsBac_DIREXEL & NombreArch '"tasamer" & Format(fecDesde.text, "mmdd") & ".xls" ' NOMBRE 'ruta del .XLS
        
'    DoEvents

   QueOp = "C"
   '
   With BACSwap.Crystal
      Call BacLimpiaParamCrw
      If Donde = "Pantalla" Then
         .Destination = crptToWindow
      Else
         .Destination = crptToPrinter
      End If
        
      'PRD-3166 Verificar que gsRPT_Path no termine en un "\"
      If Right(Trim(gsRPT_Path), 1) = "\" Then
        .ReportFileName = gsRPT_Path & "Informe_Cartera_AVR.rpt"
      Else
        .ReportFileName = gsRPT_Path & "\Informe_Cartera_AVR.rpt"
      End If
      
      '.WindowTitle = "Movimientos en Cartera"
      .StoredProcParam(0) = fdesde                           'tipo de swap - Tasa
      .StoredProcParam(1) = fHasta                              'Discriminacion (Compra o Venta)
      .StoredProcParam(2) = TCarteraf
      .StoredProcParam(3) = TCarteraN
      .StoredProcParam(4) = xLibro
      .StoredProcParam(5) = xAreaNeg
      .StoredProcParam(6) = TOperador
      .StoredProcParam(7) = TRutClie
      .StoredProcParam(8) = TipRpt
      .StoredProcParam(9) = ""
      
      .Connect = swConeccion
      .Action = 1 'Envio
         
      
   End With
Exit Function
Control:
   Select Case BACSwap.Crystal.LastErrorNumber
      Case 20527
         MsgBox "No Existen datos para generar informe soicitado", vbInformation, Msj
      Case Else
         MsgBox BACSwap.Crystal.LastErrorString, vbCritical, Msj
   End Select
End Function

Private Function Operadores()
  If Not Bac_Sql_Execute("SP_LEER_OPERADORES") Then
        MsgBox "Problemas al Intentar llenar el combo"
        Exit Function
    End If
    cmb_OperadorNom.Clear
    cmb_OperadorNom.AddItem "<TODOS [AS]>"
    cmb_OperadorCod.Clear
    cmb_OperadorCod.AddItem ""
    
    Do While Bac_SQL_Fetch(Datos())
        cmb_OperadorCod.AddItem Datos(2)
        cmb_OperadorNom.AddItem Datos(1)
    Loop
    cmb_OperadorNom.ListIndex = 0
    cmb_OperadorCod.ListIndex = cmb_OperadorNom.ListIndex
End Function


