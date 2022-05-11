VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacInfCarterasAVR 
   BorderStyle     =   1  'Fixed Single
   Caption         =   " Informes Cartera con Resultados Reconocidos o A.V.R."
   ClientHeight    =   5730
   ClientLeft      =   1950
   ClientTop       =   1200
   ClientWidth     =   7800
   ForeColor       =   &H00C0C0C0&
   Icon            =   "BacInfCarterasAVR.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5730
   ScaleWidth      =   7800
   Begin Threed.SSPanel SSPanel1 
      Height          =   5175
      Left            =   0
      TabIndex        =   10
      Top             =   480
      Width           =   7875
      _Version        =   65536
      _ExtentX        =   13891
      _ExtentY        =   9128
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
         Height          =   5010
         Left            =   120
         TabIndex        =   11
         Top             =   120
         Width           =   7665
         Begin VB.Frame Frame 
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
            Height          =   975
            Left            =   60
            TabIndex        =   25
            Top             =   3480
            Width           =   7455
            Begin BACControles.TXTFecha Desde 
               Height          =   300
               Left            =   120
               TabIndex        =   26
               Top             =   570
               Width           =   1440
               _ExtentX        =   2540
               _ExtentY        =   529
               Enabled         =   -1  'True
               Enabled         =   -1  'True
               BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               MaxDate         =   2958465
               MinDate         =   -328716
               Text            =   "25/04/2006"
            End
            Begin BACControles.TXTFecha Hasta 
               Height          =   300
               Left            =   1590
               TabIndex        =   27
               Top             =   570
               Width           =   1440
               _ExtentX        =   2540
               _ExtentY        =   529
               Enabled         =   -1  'True
               Enabled         =   -1  'True
               BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               MaxDate         =   2958465
               MinDate         =   -328716
               Text            =   "25/04/2006"
            End
            Begin VB.Label Etiquetas 
               AutoSize        =   -1  'True
               Caption         =   "Hasta"
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00800000&
               Height          =   210
               Index           =   2
               Left            =   1575
               TabIndex        =   29
               Top             =   360
               Width           =   450
            End
            Begin VB.Label Etiquetas 
               AutoSize        =   -1  'True
               Caption         =   "Desde"
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00800000&
               Height          =   210
               Index           =   1
               Left            =   150
               TabIndex        =   28
               Top             =   375
               Width           =   525
            End
         End
         Begin VB.CheckBox CheckDolar 
            Alignment       =   1  'Right Justify
            Caption         =   "Dólares"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   9.75
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   255
            Left            =   6120
            TabIndex        =   8
            Top             =   4680
            Width           =   1215
         End
         Begin VB.Frame Frame5 
            Caption         =   "Cliente"
            BeginProperty Font 
               Name            =   "Times New Roman"
               Size            =   9.75
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   -1  'True
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   1215
            Left            =   60
            TabIndex        =   17
            Top             =   2160
            Width           =   7455
            Begin VB.TextBox txtrut 
               Alignment       =   1  'Right Justify
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
               Left            =   1080
               MouseIcon       =   "BacInfCarterasAVR.frx":030A
               MousePointer    =   99  'Custom
               TabIndex        =   24
               ToolTipText     =   "Doble click para desplegar ayuda"
               Top             =   360
               Width           =   1500
            End
            Begin VB.Label Label2 
               Caption         =   "Nombre"
               BeginProperty Font 
                  Name            =   "Times New Roman"
                  Size            =   9.75
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   -1  'True
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00800000&
               Height          =   255
               Left            =   120
               TabIndex        =   23
               Top             =   720
               Width           =   855
            End
            Begin VB.Label Label1 
               Caption         =   "Código"
               BeginProperty Font 
                  Name            =   "Times New Roman"
                  Size            =   9.75
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   -1  'True
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00800000&
               Height          =   255
               Left            =   3240
               TabIndex        =   22
               Top             =   360
               Width           =   855
            End
            Begin VB.Label lblRutCliente 
               Caption         =   "Rut"
               BeginProperty Font 
                  Name            =   "Times New Roman"
                  Size            =   9.75
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   -1  'True
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00800000&
               Height          =   255
               Left            =   120
               TabIndex        =   21
               Top             =   360
               Width           =   855
            End
            Begin VB.Label lblCodCliente 
               BorderStyle     =   1  'Fixed Single
               Height          =   315
               Left            =   4080
               TabIndex        =   20
               Top             =   360
               Width           =   1335
            End
            Begin VB.Label lblDVCliente 
               BorderStyle     =   1  'Fixed Single
               Height          =   315
               Left            =   2760
               TabIndex        =   19
               Top             =   360
               Width           =   255
            End
            Begin VB.Label lblNomClie 
               BorderStyle     =   1  'Fixed Single
               Height          =   315
               Left            =   1080
               TabIndex        =   18
               Top             =   765
               Width           =   6855
            End
         End
         Begin VB.Frame Frame2 
            Caption         =   "Operador"
            BeginProperty Font 
               Name            =   "Times New Roman"
               Size            =   9.75
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   -1  'True
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   630
            Left            =   3825
            TabIndex        =   16
            Top             =   1440
            Width           =   3735
            Begin VB.ComboBox Cmb_Operador 
               Height          =   315
               Left            =   120
               Style           =   2  'Dropdown List
               TabIndex        =   5
               Top             =   240
               Width           =   3585
            End
         End
         Begin VB.Frame Frame1 
            Caption         =   "Área de Negocio"
            BeginProperty Font 
               Name            =   "Times New Roman"
               Size            =   9.75
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   -1  'True
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   630
            Left            =   60
            TabIndex        =   15
            Top             =   1440
            Width           =   3735
            Begin VB.ComboBox Cmb_Negocio 
               Height          =   315
               Left            =   120
               Style           =   2  'Dropdown List
               TabIndex        =   4
               Top             =   240
               Width           =   3585
            End
         End
         Begin VB.Frame Fr_Libro 
            Caption         =   "Libro"
            BeginProperty Font 
               Name            =   "Times New Roman"
               Size            =   9.75
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   -1  'True
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   630
            Left            =   3825
            TabIndex        =   14
            Top             =   810
            Width           =   3735
            Begin VB.ComboBox Cmb_Libro 
               Height          =   315
               Left            =   60
               Style           =   2  'Dropdown List
               TabIndex        =   3
               Top             =   210
               Width           =   3585
            End
         End
         Begin VB.Frame Frame4 
            Caption         =   "Entidad"
            BeginProperty Font 
               Name            =   "Times New Roman"
               Size            =   9.75
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   -1  'True
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   630
            Left            =   60
            TabIndex        =   13
            Top             =   165
            Width           =   3735
            Begin VB.ComboBox cmb_Entidad 
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
               Left            =   60
               Style           =   2  'Dropdown List
               TabIndex        =   0
               Top             =   195
               Width           =   3585
            End
         End
         Begin VB.Frame Ssf_Cartera_Normativa 
            Caption         =   "Cartera Normativa"
            BeginProperty Font 
               Name            =   "Times New Roman"
               Size            =   9.75
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   -1  'True
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   630
            Left            =   3840
            TabIndex        =   1
            Top             =   165
            Width           =   3735
            Begin VB.ComboBox Cmb_Cartera_Normativa 
               Enabled         =   0   'False
               Height          =   315
               Left            =   75
               Style           =   2  'Dropdown List
               TabIndex        =   7
               Top             =   255
               Width           =   3585
            End
         End
         Begin VB.Frame fr_Cartera 
            Caption         =   "Cartera de Inversión"
            BeginProperty Font 
               Name            =   "Times New Roman"
               Size            =   9.75
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   -1  'True
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   630
            Left            =   60
            TabIndex        =   12
            Top             =   810
            Width           =   3735
            Begin VB.ComboBox Cmb_Cartera 
               Height          =   315
               Left            =   75
               Style           =   2  'Dropdown List
               TabIndex        =   2
               Top             =   210
               Width           =   3585
            End
         End
      End
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   7230
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
            Picture         =   "BacInfCarterasAVR.frx":0614
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacInfCarterasAVR.frx":092E
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacInfCarterasAVR.frx":0D82
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacInfCarterasAVR.frx":109C
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Height          =   510
      Left            =   60
      TabIndex        =   9
      Top             =   0
      Width           =   7770
      _ExtentX        =   13705
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Generar Informe a Pantalla"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Imprimir Informe"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Generar Informe Excel"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Cerrar Ventana"
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin VB.Label Lbl_index 
      BorderStyle     =   1  'Fixed Single
      Height          =   375
      Left            =   3810
      TabIndex        =   6
      Top             =   135
      Visible         =   0   'False
      Width           =   465
   End
End
Attribute VB_Name = "BacInfCarterasAVR"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim Sql As String
Dim Datos()
Dim TCartera As String

Private Sub Desde_LostFocus()
   If Format(Desde.Text, "yyyymmdd") > Format(Hasta.Text, "yyyymmdd") Then
      MsgBox "La Fecha Desde debe ser Menor o Igual a Fecha Hasta.", vbCritical, gsBac_Version
   End If
End Sub


Private Sub Form_Load()
Dim x As Integer
Dim FecNueva As String

    Me.Top = 0
    Me.Left = 0
    Me.Icon = BacTrader.Icon
    
    Screen.MousePointer = vbHourglass
    giAceptar% = False

    Call CARGA_ENTIDAD
    
    Call PROC_LLENA_COMBOS(Cmb_Cartera_Normativa, 3, True, GLB_CARTERA_NORMATIVA)
    Call PROC_LLENA_COMBOS(Cmb_Cartera, 4, True, "", GLB_CARTERA, GLB_ID_SISTEMA)
    
    Call CARGA_AREA_NEGOCIO
    Call PROC_LLENA_COMBOS(Cmb_Libro, 3, True, GLB_LIBRO)
    Call CARGA_OPERADORES

    cmb_Entidad.ListIndex = 0
    Cmb_Negocio.ListIndex = 0
    Cmb_Operador.ListIndex = 0
    Ssf_Cartera_Normativa.Enabled = True
    Cmb_Cartera_Normativa.Enabled = True
    Hasta.Text = gsBac_Fecp
    Desde.Text = gsBac_Fecp

    Screen.MousePointer = vbDefault
End Sub

Private Sub Cmd_Generar(Donde)
Dim Nombre_Rpt      As String: Nombre_Rpt = ""
Dim TipRep          As String
Dim Fecha           As String
Dim AuxTit          As String
Dim CDolar          As String
Dim Datos()
Dim TOperador      As String
On Error GoTo Control:

    xentidad = Val(Trim$(Right$(cmb_Entidad.Text, 10)))
    TCartera = ""
    TCarteraN = Trim(Right(Cmb_Cartera_Normativa.Text, 1))
    TCarteraf = Trim(Right(Cmb_Cartera.Text, 1))
    
    xLibro = Trim(Right(Cmb_Libro.Text, 10))
    xAreaNeg = Trim(Right(Cmb_Negocio.Text, 10))
    fdesde = Format(Desde.Text, "YYYYMMDD")
    fHasta = Format(Hasta.Text, "YYYYMMDD")
    TOperador = Trim(Right(Cmb_Operador.Text, 10))
    
    If Donde = "Impresora" Then
        BacTrader.bacrpt.Destination = 0
    Else
        BacTrader.bacrpt.Destination = 1
    End If

    Dim Inf%, x%, Marca  As Boolean

    If CheckDolar.Value = True Then
       CDolar = "S"
    Else
       CDolar = "N"
    End If
    
    nContador = IIf(Cmb_Cartera_Normativa.ListIndex > 0, 1, Cmb_Cartera_Normativa.ListCount - 1)
        For x = 1 To nContador
             
            AuxTit = ""
            TCartera = ""
    
            TCartera = Trim(Right(Cmb_Cartera_Normativa.List(IIf(nContador = 1, Cmb_Cartera_Normativa.ListIndex, x)), 10))
            AuxTit = Trim(Left(Cmb_Cartera_Normativa.List(IIf(nContador = 1, Cmb_Cartera_Normativa.ListIndex, x)), 50))
                   
            If CDolar = "S" Then
               AuxTit = AuxTit & " EN DOLARES"
            End If
                    
            TipRpt = "CARTERA DE RENTA FIJA CON RESULTADOS RECONOCIDOS O A.V.R. " & AuxTit
            Call Limpiar_Cristal
     
            BacTrader.bacrpt.ReportFileName = RptList_Path & "VALORMERC_AVR.rpt"
            
            Call PROC_ESTABLECE_UBICACION(BacTrader.bacrpt.RetrieveDataFiles, BacTrader.bacrpt)
            
            BacTrader.bacrpt.StoredProcParam(0) = "BTR"
            BacTrader.bacrpt.StoredProcParam(1) = IIf(xLibro = "", Space(1), xLibro) 'Libro
            BacTrader.bacrpt.StoredProcParam(2) = IIf(xAreaNeg = "", Space(1), xAreaNeg)
            BacTrader.bacrpt.StoredProcParam(3) = IIf(TCarteraf = "", Space(1), TCarteraf)
            BacTrader.bacrpt.StoredProcParam(4) = TCartera
            BacTrader.bacrpt.StoredProcParam(5) = IIf(txtrut.Text = "", 0, txtrut.Text)
            BacTrader.bacrpt.StoredProcParam(6) = fdesde
            BacTrader.bacrpt.StoredProcParam(7) = fHasta
            BacTrader.bacrpt.StoredProcParam(8) = TipRpt
            BacTrader.bacrpt.StoredProcParam(9) = IIf(TOperador = "", Space(1), TOperador)
            BacTrader.bacrpt.StoredProcParam(10) = CDolar
 
            BacTrader.bacrpt.Connect = CONECCION
            BacTrader.bacrpt.Action = 1
        Next x
    Screen.MousePointer = vbDefault
    Exit Sub

Control:
    MsgBox "Problemas al generar Listado de Cartera. " & err.Description & ", " & err.Number, vbCritical, "BACTRADER"
    Screen.MousePointer = vbDefault
    
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

Private Sub Hasta_LostFocus()
   If Format(Hasta.Text, "yyyymmdd") < Format(Desde.Text, "yyyymmdd") Then
      MsgBox "La Fecha Desde debe ser Mayor o Igual a Fecha Hasta.", vbCritical, gsBac_Version
   End If
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   If Button.Index <> 4 Then
        If Format(Desde.Text, "yyyymmdd") > Format(Hasta.Text, "yyyymmdd") Then
           MsgBox "La Fecha Desde debe ser Menor o Igual a Fecha Hasta.", vbCritical, gsBac_Version
           Exit Sub
        End If
        If Format(Hasta.Text, "yyyymmdd") < Format(Desde.Text, "yyyymmdd") Then
           MsgBox "La Fecha Desde debe ser Mayor o Igual a Fecha Hasta.", vbCritical, gsBac_Version
           Exit Sub
        End If
   End If
'   Screen.MousePointer = vbHourglass
    
    Select Case Button.Index
       Case 1
          Call Cmd_Generar("Impresora")
       Case 2
          Call Cmd_Generar("Pantalla")
       Case 3
           Call Exporta_Excel
       Case 4
       
          Screen.MousePointer = vbDefault
          Unload Me
    End Select
    
    Screen.MousePointer = vbDefault
End Sub

Private Sub txtrut_Change()
If Len(txtrut.Text) > 0 And gsrut$ = "" Then
    txtrut.Text = ""
    lblDVCliente.Caption = ""
    lblNomClie.Caption = ""
    lblCodCliente.Caption = ""
End If
End Sub

Private Sub txtRut_DblClick()
    BacAyuda.Tag = "MDCL"
    BacAyuda.Show 1
    BacControlWindows 12
    If giAceptar% = True Then
        txtrut.Text = Val(gsrut$)
'        txtRut.Separator = True
        lblDVCliente.Caption = gsDigito$
        lblNomClie.Caption = gsDescripcion$
        lblCodCliente.Caption = gsvalor$
    End If
    gsrut$ = ""

End Sub

Function Exporta_Excel()
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
    Dim NombreArch  As String
    Dim TOperador   As String
    Dim CDolar      As String
    Const Filas_Buffer = 2500 '150
    Dim nombre_arch As String

    xentidad = Val(Trim$(Right$(cmb_Entidad.Text, 10)))
    TCartera = ""
    TCarteraN = Trim(Right(Cmb_Cartera_Normativa.Text, 1))
    TCarteraf = Trim(Right(Cmb_Cartera.Text, 1))
    
    xLibro = Trim(Right(Cmb_Libro.Text, 10))
    xAreaNeg = Trim(Right(Cmb_Negocio.Text, 10))
    TipRpt = "CARTERA DE RENTA FIJA CON RESULTADOS RECONOCIDOS O A.V.R. " & AuxTit
    fdesde = Format(Desde.Text, "YYYYMMDD")
    fHasta = Format(Hasta.Text, "YYYYMMDD")
    TOperador = Trim(Right(Cmb_Operador.Text, 10))
    NombreArch = "BTR_AVR" & Format(gsBac_Fecp, "mmdd") & ".xls"
    ruta = gsBac_DIREXEL & NombreArch '"tasamer" & Format(Desde.Text, "mmdd") & ".xls" ' NOMBRE 'ruta del .XLS
    
    If CheckDolar.Value = True Then
       CDolar = "S"
    Else
       CDolar = "N"
    End If
    
    If MsgBox("¿ Seguro que desea generar la planilla excel para " & Me.Caption & "?", vbQuestion + vbYesNo) = vbNo Then
        Screen.MousePointer = vbDefault
        Exit Function
    End If
     
    Frm_Guarda_Ruta.Txtpath.Text = "C:\"
    Frm_Guarda_Ruta.Show 1
    
    Screen.MousePointer = vbHourglass
    
    If Mid(Me.Tag, Len(Me.Tag), 1) = "\" Then
        nombre_arch = Me.Tag & NombreArch
    Else
        nombre_arch = Me.Tag & "\" & NombreArch
    End If
    
'    DoEvents

    Sql = "SP_INFORVALMERCADO_AVR_EXCEL " & "'BTR'," & _
            "'" & xLibro & "'," & _
            "'" & xAreaNeg & "'," & _
            "'" & TCarteraf & "'," & _
            "'" & TCarteraN & "'," & _
            IIf(txtrut.Text = "", 0, txtrut.Text) & "," & _
            "'" & fdesde & "'," & _
            "'" & fHasta & "','" & _
            TipRpt & "','" & _
            TOperador & "','" & _
            CDolar & "'"
    
    If Not Bac_Sql_Execute(Sql) Then MsgBox "No se pudo generar Planilla", vbCritical, gsBac_Version: Screen.MousePointer = vbDefault: Exit Function

    Set Exc = CreateObject("Excel.Application")
    Set Hoja = Exc.Application.Workbooks.Add.Sheets.Add
    Set Sheet = Exc.ActiveSheet
    
    ''''''''''''''''''''''''''
    'Titulos en Archivo EXCEL
    Linea = ""
    Linea = Linea & "rmnumdocu" & vbTab
    Linea = Linea & "rmnumoper" & vbTab
    Linea = Linea & "tminster" & vbTab
    Linea = Linea & "tmfecpro" & vbTab
    Linea = Linea & "tmnominal" & vbTab
    Linea = Linea & "moneda" & vbTab
    Linea = Linea & "rmttir" & vbTab
    Linea = Linea & "rmvpres" & vbTab
    Linea = Linea & "rmvmerc" & vbTab
    Linea = Linea & "tmtmerc" & vbTab
    Linea = Linea & "rmdmerc" & vbTab
    Linea = Linea & "tmmarket" & vbTab
    Linea = Linea & "rmvmarket" & vbTab
    Linea = Linea & "rmdmarket" & vbTab
    Linea = Linea & "tmmarket1" & vbTab
    Linea = Linea & "rmvmarket1" & vbTab
    Linea = Linea & "rmdmarket1" & vbTab
    Linea = Linea & "tmmarket2" & vbTab
    Linea = Linea & "rmvmarket2" & vbTab
    Linea = Linea & "rmdmarket2" & vbTab
    Linea = Linea & "inserie" & vbTab
    Linea = Linea & "acfecproc" & vbTab
    Linea = Linea & "acfecprox" & vbTab
    Linea = Linea & "uf_hoy" & vbTab
    Linea = Linea & "uf_man" & vbTab
    Linea = Linea & "ivp_hoy" & vbTab
    Linea = Linea & "ivp_man" & vbTab
    Linea = Linea & "do_hoy" & vbTab
    Linea = Linea & "do_man" & vbTab
    Linea = Linea & "da_hoy" & vbTab
    Linea = Linea & "da_man" & vbTab
    Linea = Linea & "acnomprop" & vbTab
    Linea = Linea & "rut_empresa" & vbTab
    Linea = Linea & "hora" & vbTab
    Linea = Linea & "sw" & vbTab
    Linea = Linea & "titulo" & vbTab
    Linea = Linea & "subtitulo" & vbTab
    Linea = Linea & "Fecha Desde" & vbTab
    Linea = Linea & "Fecha Hasta" & vbTab
    Linea = Linea & "TASA_EMISION" & vbTab
    Linea = Linea & "rsvppresen" & vbTab
    Linea = Linea & "fechaaux" & vbTab
    Linea = Linea & "duration" & vbTab
    Linea = Linea & "clasificacion1" & vbTab
    Linea = Linea & "clasificacion2" & vbTab
    Linea = Linea & "tipo_corto1" & vbTab
    Linea = Linea & "tipo_largo1" & vbTab
    Linea = Linea & "tipo_corto2" & vbTab
    Linea = Linea & "tipo_largo2" & vbTab
    Linea = Linea & "ValPresTC_LT" & vbTab
    Linea = Linea & "ValPresTM_LT" & vbTab
    Linea = Linea & "TirCompra_LT" & vbTab
    Linea = Linea & "TirMercado_LT" & vbTab
    Linea = Linea & "ResDif_LT" & vbTab
    Linea = Linea & "Usuario" & vbTab
    Linea = Linea & "Area_de_Negocio" & vbTab
    Linea = Linea & "Cartera_Normativa" & vbTab
    Linea = Linea & "Cartera_Financiera" & vbTab
    Linea = Linea & "Cliente" & vbTab
    Linea = Linea & "Operador" & vbTab
    Linea = Linea & "Libro"

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

        For J = 1 To 61
'            If (J >= 1 And J < 3) Or (J > 3 And J < 62) Then
                Linea = Linea & BacStrTran(IIf(Trim(Arr(J)) = "", 0, Trim(Arr(J))), ",", ".") & vbTab
'                Linea = Linea & Arr(J) '(IIf(Trim(Arr(J)) = "", 0, Trim(Arr(J))), ",", ".") & vbTab
'            Else
'                If J = 3 Then
'                    Linea = Linea & Format(IIf(Trim(Arr(J)) = "", "01/01/1900", Trim(Arr(J))), "mm/dd/yyyy") & vbTab
'                End If

'                If J = 6 Then
'                    Linea = Linea & BacStrTran(IIf(Trim(Arr(J)) = "", 0, Trim(Arr(J))), ",", ".") & vbTab
'                End If

'                If Sw_Fin_De_Mes = 0 Then
'                    If J = 13 Then
'                        Linea = Linea & Format(IIf(Trim(Arr(J)) = "", "01/01/1900", Trim(Arr(J))), "mm/dd/yyyy") & vbTab
'                    End If
'                End If
'            End If
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
        Hoja.SaveAs (nombre_arch)
    Else
        Hoja.Application.Workbooks.Close
        MousePointer = vbDefault
        MsgBox "No se encontró Información para generar el Excel", vbExclamation, gsBac_Version
        Exit Function
    End If
    
    Hoja.Application.Workbooks.Close
    
    Screen.MousePointer = vbDefault
'    MsgBox "El archivo excel con la Cartera con Resultados Reconocidos o AVR ", vbInformation, gsBac_Version
    MsgBox "El archivo " & nombre_arch & " de Cartera con Resultados Reconocidos o AVR se genero de forma OK ", vbInformation, gsBac_Version

    Set Hoja = Nothing
    Set Exc = Nothing
    Set Sheet = Nothing
    
    'retorno = Shell(gsBac_Office & "EXCEL.EXE  " & ruta, vbMaximizedFocus)

ErrLevel:
    If err.Description <> "" Then
        MsgBox err.Description, vbInformation, Msj
    End If
    Screen.MousePointer = vbDefault

End Function


Private Function CARGA_ENTIDAD()
'Carga combo entidad
    cmb_Entidad.Clear
    If Bac_Sql_Execute("SP_LEER_ENTIDADES") Then
        cmb_Entidad.AddItem "TODAS LAS ENTIDADES                                                 "
        Do While Bac_SQL_Fetch(Datos())
            cmb_Entidad.AddItem Datos(1) & Space(50 + (30 - Len(Datos(1)))) & Str(Datos(2))
        Loop
    Else
        MsgBox "Proceso " & Sql & "no existe", vbOKOnly + vbCritical, "Entidades"
        Unload Me
    End If
End Function

Private Function CARGA_AREA_NEGOCIO()
'CARGA COMBO AREA DE NEGOCIO
    Cmb_Negocio.Clear
    If Bac_Sql_Execute("SP_LEER_AREA_NEGOCIO") Then
        Cmb_Negocio.AddItem "< TODOS (AS) >" & Space(10)
        Do While Bac_SQL_Fetch(Datos())
            Cmb_Negocio.AddItem Datos(1) & Space(50 + (30 - Len(Datos(1)))) & Datos(2)
        Loop
    Else
        MsgBox "Proceso " & Sql & "no existe", vbOKOnly + vbCritical, "Entidades"
        Unload Me
    End If
    Cmb_Negocio.ListIndex = 0
End Function

Private Function CARGA_OPERADORES()
'CARGA COMBO OPERADORES
    Cmb_Operador.Clear
    If Bac_Sql_Execute("SP_LEER_OPERADORES") Then
        Cmb_Operador.AddItem "< TODOS (AS) >" & Space(10)
        Do While Bac_SQL_Fetch(Datos())
            Cmb_Operador.AddItem Datos(1) & Space(50 + (30 - Len(Datos(1)))) & Datos(2)
        Loop
    Else
        MsgBox "Proceso " & Sql & "no existe", vbOKOnly + vbCritical, "Entidades"
        Unload Me
    End If
    Cmb_Operador.ListIndex = 0
End Function
