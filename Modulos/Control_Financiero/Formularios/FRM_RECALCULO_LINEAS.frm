VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form FRM_RECALCULO_LINEAS 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Recalculo de Líneas de Crédito DRV."
   ClientHeight    =   2535
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   5490
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   2535
   ScaleWidth      =   5490
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   5490
      _ExtentX        =   9684
      _ExtentY        =   794
      ButtonWidth     =   767
      ButtonHeight    =   741
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
            Object.ToolTipText     =   "Procesar Recalculo de Lineas"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Cerrar Ventana"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Validar Parametros"
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   3990
         Top             =   15
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
               Picture         =   "FRM_RECALCULO_LINEAS.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_RECALCULO_LINEAS.frx":0EDA
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_RECALCULO_LINEAS.frx":11F4
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame Frame1 
      Height          =   1350
      Left            =   0
      TabIndex        =   1
      Top             =   405
      Width           =   5475
      Begin VB.TextBox Txtnombre 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   45
         MousePointer    =   14  'Arrow and Question
         TabIndex        =   9
         Top             =   945
         Width           =   5325
      End
      Begin VB.Frame Frame2 
         BorderStyle     =   0  'None
         Enabled         =   0   'False
         Height          =   600
         Left            =   45
         TabIndex        =   2
         Top             =   120
         Width           =   2850
         Begin VB.TextBox TxtDv 
            Alignment       =   2  'Center
            BeginProperty Font 
               Name            =   "Tahoma"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   300
            Left            =   1740
            TabIndex        =   3
            Top             =   225
            Width           =   360
         End
         Begin BACControles.TXTNumero TxtRut 
            Height          =   300
            Left            =   30
            TabIndex        =   4
            Top             =   225
            Width           =   1710
            _ExtentX        =   3016
            _ExtentY        =   529
            Enabled         =   -1  'True
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Tahoma"
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
         Begin BACControles.TXTNumero TxtCodigo 
            Height          =   300
            Left            =   2115
            TabIndex        =   5
            Top             =   225
            Width           =   630
            _ExtentX        =   1111
            _ExtentY        =   529
            Enabled         =   -1  'True
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Tahoma"
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
         Begin VB.Label Etiquetas 
            AutoSize        =   -1  'True
            Caption         =   "Rut Cliente"
            BeginProperty Font 
               Name            =   "Tahoma"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   195
            Index           =   0
            Left            =   45
            TabIndex        =   8
            Top             =   0
            Width           =   795
         End
         Begin VB.Label Etiquetas 
            AutoSize        =   -1  'True
            Caption         =   "Dv"
            BeginProperty Font 
               Name            =   "Tahoma"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   195
            Index           =   1
            Left            =   1755
            TabIndex        =   7
            Top             =   15
            Width           =   195
         End
         Begin VB.Label Etiquetas 
            AutoSize        =   -1  'True
            Caption         =   "Código"
            BeginProperty Font 
               Name            =   "Tahoma"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   195
            Index           =   2
            Left            =   2130
            TabIndex        =   6
            Top             =   15
            Width           =   495
         End
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Nombre Cliente"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   3
         Left            =   90
         TabIndex        =   10
         Top             =   750
         Width           =   1095
      End
   End
   Begin Threed.SSPanel Pnlprogress 
      Align           =   2  'Align Bottom
      Height          =   495
      Left            =   0
      TabIndex        =   11
      Top             =   2040
      Width           =   5490
      _Version        =   65536
      _ExtentX        =   9684
      _ExtentY        =   873
      _StockProps     =   15
      ForeColor       =   -2147483634
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BorderWidth     =   1
      BevelInner      =   1
      FloodType       =   1
      FloodColor      =   -2147483635
   End
   Begin MSFlexGridLib.MSFlexGrid Grid 
      Height          =   1245
      Left            =   5475
      TabIndex        =   13
      Top             =   495
      Width           =   7125
      _ExtentX        =   12568
      _ExtentY        =   2196
      _Version        =   393216
      Cols            =   6
      FixedCols       =   0
   End
   Begin VB.Label ClienteEnproceso 
      Alignment       =   2  'Center
      Caption         =   "Actualizando Cliente: BANCO DEL DESARROLLO"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Left            =   45
      TabIndex        =   12
      Top             =   1785
      Width           =   5430
   End
End
Attribute VB_Name = "FRM_RECALCULO_LINEAS"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub NombresGrilla()
    Let Grid.Rows = 2
    Let Grid.Cols = 5
    
    Let Grid.TextMatrix(0, 0) = "Rut"
    Let Grid.TextMatrix(0, 1) = "Codigo"
    Let Grid.TextMatrix(0, 2) = "Nombre"
    Let Grid.TextMatrix(0, 3) = "Metodologia"
    Let Grid.TextMatrix(0, 4) = "Threshold"

End Sub
Private Sub Proc_ValidaParametrosDRV()
    Dim Det_MsgError As String
    Dim CliMet_2_5 As Long
    Dim CliMet_3  As Long
    Dim VerificaSim As String
    Dim Parametros As Boolean
    Dim iCadena As String
    Dim Titulo As String
    Dim HayDatos As Boolean
    Dim Datos()
    Let iRut = CDbl(TxtRut.Text)
    Let iCodigo = CDbl(TxtCodigo.Text)
   
    Let Toolbar1.Buttons(2).Enabled = False
    Let Toolbar1.Buttons(3).Enabled = False
    Let Toolbar1.Buttons(4).Enabled = False

    Let Screen.MousePointer = vbHourglass
   
    Envia = Array()
    AddParam Envia, iRut
    AddParam Envia, iCodigo
    If Not Bac_Sql_Execute("BacTraderSuda..SP_CON_CLIENTE_DERIVADOS", Envia) Then
        Let Screen.MousePointer = vbDefault
        Let Toolbar1.Buttons(2).Enabled = True
        Let Toolbar1.Buttons(3).Enabled = True
        Let Toolbar1.Buttons(3).Enabled = True
        MsgBox "Actualizacion de Lineas" & vbCrLf & vbCrLf & "Error en la carga de clientes.", vbExclamation, App.Title
        On Error GoTo 0
        Exit Sub
    End If
    Let Grid.Rows = 1
    
    Let CliMet_2_5 = 0
    Let CliMet_3 = 0
    Let HayDatos = False
    Do While Bac_SQL_Fetch(Datos())
                    
        If Datos(4) = 2 Or Datos(4) = 5 Then
            CliMet_2_5 = CliMet_2_5 + 1
        End If
        
        ' PRD 21119 Lineas derivados ComDer, Se agrega met 6
        If Datos(4) = 3 Or Datos(4) = 6 Then
            CliMet_3 = CliMet_3 + 1
        End If
        Let HayDatos = True
    Loop
       
    If HayDatos = False Then
        Call MsgBox("No hay Clientes con Metodologías Netting. ", vbInformation, App.Title)
        Let Screen.MousePointer = vbDefault
        Let Toolbar1.Buttons(2).Enabled = True
        Let Toolbar1.Buttons(3).Enabled = True
        Let Toolbar1.Buttons(4).Enabled = True
        Exit Sub
    End If
    
    Let Parametros = False
    Let iCadena = ""
    Let Titulo = ""
    If CliMet_3 >= 1 Then
        Let VerificaSim = "PAR_SIMULACIONES"
        Call Proc_Verifica_Parametros(VerificaSim, Parametros, iCadena)
        If Parametros = True Then
            Call MsgBox(iCadena, vbCritical, "Faltan los siguentes parametros")
            Let Titulo = "Falta Agregar los siguientes parametros: "
            Call BacCalculoRec.Proc_EnviarMail(iCadena, Titulo)
            Let Toolbar1.Buttons(2).Enabled = True
            Let Toolbar1.Buttons(3).Enabled = True
            Let Toolbar1.Buttons(4).Enabled = True
            Let Screen.MousePointer = vbDefault
            Exit Sub
        End If
    Else
        Let VerificaSim = "PAR_DIA"
        Call Proc_Verifica_Parametros(VerificaSim, Parametros, iCadena)
        If Parametros = True Then
            Call MsgBox(iCadena, vbCritical, "Faltan los siguentes parametros")
            Let Titulo = "Falta Agregar los siguientes parametros: "
            Call BacCalculoRec.Proc_EnviarMail(iCadena, Titulo)
            Let Toolbar1.Buttons(2).Enabled = True
            Let Toolbar1.Buttons(3).Enabled = True
            Let Toolbar1.Buttons(4).Enabled = True
            Let Screen.MousePointer = vbDefault

            Exit Sub
        End If
    End If
    
    Let Toolbar1.Buttons(2).Enabled = True
    Let Toolbar1.Buttons(3).Enabled = True
    Let Toolbar1.Buttons(4).Enabled = True

    Let Screen.MousePointer = vbDefault

    MsgBox "Validación de parametros" & vbCrLf & "Se ha completado en forma correcta.", vbInformation, App.Title

End Sub
Private Sub Form_Load()
   Let Me.Icon = BacControlFinanciero.Icon
   Let Me.top = 0: Let Me.Left = 0
   
   Call NombresGrilla
   Let ClienteEnproceso.Caption = ""
End Sub
Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 2
        Call Proc_ProcesarLineas
      Case 3
        Unload Me
      Case 4
        Call Proc_ValidaParametrosDRV
   End Select
End Sub
Private Sub Txtnombre_DblClick()
   BacAyuda.Tag = "Clientes_DRV"
   BacAyuda.Show 1
   If giAceptar Then
      Let TxtRut.Text = RetornoAyuda4 'gsCodigo$
      Let TxtDv.Text = RetornoAyuda 'gsDigito$
      Let TxtCodigo.Text = RetornoAyuda2 'gscodcli%
      Let txtNombre.Text = RetornoAyuda3 'RetornoAyuda4 'gsDescripcion$
   End If
End Sub
Private Sub txtNombre_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyDelete Or KeyCode = vbKeyBack Then
      Let TxtRut.Text = 0
      Let TxtCodigo.Text = 0
      Let TxtDv.Text = ""
      Let Grid.Rows = 1
   End If
End Sub
Private Sub Proc_ProcesarLineas()
    On Error Resume Next
    Dim sql        As String
    Dim iRut       As Long
    Dim iCodigo    As Long
    Dim iContador  As Long
    Dim iRegistros As Long
    Dim Switch     As Integer
    
    Dim Det_MsgError As String
    Dim CliMet_2_5 As Long
    Dim CliMet_3  As Long
    Dim VerificaSim As String
    Dim Parametros As Boolean
    Dim iCadena As String
    Dim Titulo As String
    Dim HayDatos As Boolean

    Dim CLIENTE As Datos_Cliente_DRV
   
    Dim Datos()
    
    Let iRut = CDbl(TxtRut.Text)
    Let iCodigo = CDbl(TxtCodigo.Text)
   
    Let Toolbar1.Buttons(2).Enabled = False
    Let Toolbar1.Buttons(3).Enabled = False
    Let Toolbar1.Buttons(4).Enabled = False
    
    If iRut = 0 Then
        If MsgBox("El proceso para todos los clientes puede demorar, Desea continuar S/N?", vbYesNo + vbQuestion) = vbNo Then
            Let Toolbar1.Buttons(2).Enabled = True
            Let Toolbar1.Buttons(3).Enabled = True
            Let Toolbar1.Buttons(4).Enabled = True
            Exit Sub
        End If
        
    End If

    Let Screen.MousePointer = vbHourglass

    Envia = Array()
    AddParam Envia, iRut
    AddParam Envia, iCodigo
    If Not Bac_Sql_Execute("BacTraderSuda..SP_CON_CLIENTE_DERIVADOS", Envia) Then
        Let Screen.MousePointer = vbDefault
        Let Toolbar1.Buttons(2).Enabled = True
        Let Toolbar1.Buttons(3).Enabled = True
        Let Toolbar1.Buttons(4).Enabled = True
        Let Screen.MousePointer = vbDefault
        MsgBox "Actualizacion de Lineas" & vbCrLf & vbCrLf & "Error en la carga de clientes.", vbExclamation, App.Title
        On Error GoTo 0
        Exit Sub
    End If
    Let Grid.Rows = 1

    Let CliMet_2_5 = 0
    Let CliMet_3 = 0
    Let HayDatos = False

    Do While Bac_SQL_Fetch(Datos())

        Let Grid.Rows = Grid.Rows + 1
        Let Grid.TextMatrix(Grid.Rows - 1, 0) = Datos(1) 'Rut
        Let Grid.TextMatrix(Grid.Rows - 1, 1) = Datos(2) 'Codigo
        Let Grid.TextMatrix(Grid.Rows - 1, 2) = Datos(3) 'Nombre
        Let Grid.TextMatrix(Grid.Rows - 1, 3) = Datos(4) 'Metodologia
        Let Grid.TextMatrix(Grid.Rows - 1, 4) = Datos(5) 'Threshold


        If Datos(4) = 2 Or Datos(4) = 5 Then

            CliMet_2_5 = CliMet_2_5 + 1

        End If

        If Datos(4) = 3 Or Datos(4) = 6 Then
            CliMet_3 = CliMet_3 + 1
        End If
        Let HayDatos = True
    Loop

    
    If HayDatos = False Then
        Call MsgBox("No hay Clientes con Metodologías Netting. ", vbInformation, App.Title)
        Let Toolbar1.Buttons(2).Enabled = True
        Let Toolbar1.Buttons(3).Enabled = True
        Let Toolbar1.Buttons(4).Enabled = True
        Let Screen.MousePointer = vbDefault
        Exit Sub
    End If

    Let Parametros = False
    Let iCadena = ""
    Let Titulo = ""
    If CliMet_3 >= 1 Then
        Let VerificaSim = "PAR_SIMULACIONES"
        Call Proc_Verifica_Parametros(VerificaSim, Parametros, iCadena)
        If Parametros = True Then
            Call MsgBox(iCadena, vbCritical, "Faltan los siguentes parametros")
            Let Titulo = "Falta Agregar los siguientes parametros: "
            Call BacCalculoRec.Proc_EnviarMail(iCadena, Titulo)
            Let Toolbar1.Buttons(2).Enabled = True
            Let Toolbar1.Buttons(3).Enabled = True
            Let Toolbar1.Buttons(4).Enabled = True
            Let Screen.MousePointer = vbDefault
            'Exit Sub
            'Lo mismo que Renta Fija, se verifican los parametros
            'y los que faltan no se cargan
        End If
    Else
        Let VerificaSim = "PAR_DIA"
        Call Proc_Verifica_Parametros(VerificaSim, Parametros, iCadena)
        If Parametros = True Then
            Call MsgBox(iCadena, vbCritical, "Faltan los siguentes parametros")
            Let Titulo = "Falta Agregar los siguientes parametros: "
            Call BacCalculoRec.Proc_EnviarMail(iCadena, Titulo)
            Let Toolbar1.Buttons(2).Enabled = True
            Let Toolbar1.Buttons(3).Enabled = True
            Let Toolbar1.Buttons(4).Enabled = True
            Let Screen.MousePointer = vbDefault
            Exit Sub
        End If
    End If

    Let iRegistros = Grid.Rows - 1
    Let Pnlprogress.ForeColor = vbBlack
    Let ClienteEnproceso.Caption = ""

    For iContador = 1 To Grid.Rows - 1

        ReDim Preserve CLIENTE.Clie_DRV(iContador - 1)
        Let CLIENTE.Clie_DRV(iContador - 1).Rut = Grid.TextMatrix(iContador, 0)
        Let CLIENTE.Clie_DRV(iContador - 1).Codigo = Grid.TextMatrix(iContador, 1)
        Let CLIENTE.Clie_DRV(iContador - 1).Nombre = Grid.TextMatrix(iContador, 2)
        Let CLIENTE.Clie_DRV(iContador - 1).Metodologia = Grid.TextMatrix(iContador, 3)
        Let CLIENTE.Clie_DRV(iContador - 1).Threshold = Grid.TextMatrix(iContador, 4)


        Let Switch = IIf(iContador = (Grid.Rows - 1), 1, 0)
        Let iRut = CDbl(Grid.TextMatrix(iContador, 0))
        Let iCodigo = CDbl(Grid.TextMatrix(iContador, 1))
        Let cNombre = Mid(Grid.TextMatrix(iContador, 2), 1, 41)
        Let ClienteEnproceso.Caption = "Actualizando Cliente: " & String(41 - Len(Trim(cNombre)), " ") & Trim(cNombre)
        Let ClienteEnproceso.Alignment = vbLeftJustify
        DoEvents: DoEvents: DoEvents

        Let Det_MsgError = ""
        'Call BacCalculoRec.ProcesoRECalculoREC(CLIENTE, Det_MsgError)
        Call Proc_Recalculo_LineasCF_DRV(iRut, iCodigo)
    
        If Err.Number <> 0 Then
            Let Det_MsgError = Err.Number & " " & Err.Description
            MsgBox "Error N° " & Det_MsgError, vbInformation
            Let Screen.MousePointer = vbDefault
            Exit Sub
        End If
        
        
      ' --> Porcentaje
        Let Pnlprogress.FloodPercent = ((iContador * 100#) / iRegistros)
        DoEvents: DoEvents: DoEvents

        If Pnlprogress.FloodPercent >= 49 Then
           Pnlprogress.ForeColor = vbWhite
        End If
        If Det_MsgError <> "" Then
            Let Det_MsgError = Det_MsgError & "-" & Det_MsgError
        End If
    Next iContador


    Let Titulo = ""
    If Det_MsgError <> "" Then
        Let Titulo = "Se generaron los siguientes Errores en Calculo REC.: "
        Call BacCalculoRec.Proc_EnviarMail(Det_MsgError, Titulo)
    End If


    Let Screen.MousePointer = vbDefault
    
    MsgBox "Actualizacion de Lineas" & vbCrLf & "Se ha completado en forma correcta la actualización.", vbInformation, App.Title
    
    Let Pnlprogress.FloodPercent = 0
    Let ClienteEnproceso.Caption = ""
    Let Toolbar1.Buttons(2).Enabled = True
    Let Toolbar1.Buttons(3).Enabled = True
    Let Toolbar1.Buttons(4).Enabled = True
    On Error GoTo 0
End Sub

