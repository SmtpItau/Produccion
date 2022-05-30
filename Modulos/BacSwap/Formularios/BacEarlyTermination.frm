VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form EarlyTermination 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Early Termination"
   ClientHeight    =   2550
   ClientLeft      =   45
   ClientTop       =   375
   ClientWidth     =   4740
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2550
   ScaleWidth      =   4740
   StartUpPosition =   2  'CenterScreen
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   8
      Top             =   0
      Width           =   4740
      _ExtentX        =   8361
      _ExtentY        =   794
      ButtonWidth     =   2090
      ButtonHeight    =   741
      ToolTips        =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      Style           =   1
      TextAlignment   =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   1
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Aceptar"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Cancelar"
            ImageIndex      =   6
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   2880
         Top             =   240
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
               Picture         =   "BacEarlyTermination.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacEarlyTermination.frx":0452
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacEarlyTermination.frx":076C
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacEarlyTermination.frx":1646
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacEarlyTermination.frx":2520
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacEarlyTermination.frx":33FA
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "Aplica Early Termination"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   780
      Left            =   60
      TabIndex        =   0
      Top             =   465
      Width           =   4620
      Begin VB.OptionButton optNoET 
         Caption         =   "No"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   2205
         TabIndex        =   2
         Top             =   300
         Width           =   615
      End
      Begin VB.OptionButton optSiET 
         Caption         =   "Si"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   720
         TabIndex        =   1
         Top             =   300
         Width           =   855
      End
   End
   Begin VB.Frame Frame2 
      Height          =   1320
      Left            =   60
      TabIndex        =   3
      Top             =   1185
      Width           =   4620
      Begin BACControles.TXTFecha TXTFecha1 
         Height          =   255
         Left            =   2175
         TabIndex        =   7
         Top             =   495
         Width           =   1695
         _ExtentX        =   2990
         _ExtentY        =   450
         Enabled         =   -1  'True
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
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "26-01-2015"
      End
      Begin VB.ComboBox cmbPeriodicidad 
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
         Left            =   120
         Style           =   2  'Dropdown List
         TabIndex        =   5
         Top             =   480
         Width           =   1695
      End
      Begin VB.Label Label2 
         Caption         =   "Fecha Inicio"
         Height          =   255
         Left            =   2160
         TabIndex        =   6
         Top             =   240
         Width           =   1695
      End
      Begin VB.Label Label1 
         Caption         =   "Periodicidad"
         Height          =   375
         Left            =   120
         TabIndex        =   4
         Top             =   240
         Width           =   1815
      End
   End
End
Attribute VB_Name = "EarlyTermination"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public Periodicidad As Integer
Public FechaInicio As Date

'Periodicidad = 0
'FechaInicio = Format(gsBAC_Fecp, gsc_FechaDMA)

Private Sub Form_Load()
    optSiET.Value = False
    optNoET.Value = True

    Call CargaInicial

    'If gsc_Operacion.nNumoper <> 0 Then
    If nNumoper <> 0 Then
        Call Carga_Info_ET(TXTFecha1)   'cmbPeriodicidad, TXTFecha1)
        Call FuncLeerDatoCombo(Periodicidad)
        'TXTFecha1.Text = Format(FechaInicio, gsc_FechaDMA)
    End If

End Sub
    
Private Function FuncLeerDatoCombo(ByVal nValor As Long)
    Dim nContador As Long
    
    If cmbPeriodicidad.ListCount > 0 Then
    
        For nContador = 0 To cmbPeriodicidad.ListCount - 1
            If cmbPeriodicidad.ItemData(nContador) = nValor Then
                Let cmbPeriodicidad.ListIndex = nContador
                Exit For
            End If
        Next nContador
    
    End If
   
End Function

Private Sub CargaInicial()
    Me.Icon = BACSwap.Icon
    Let cmbPeriodicidad.Enabled = False
    Let TXTFecha1.Enabled = False
    
    TXTFecha1.Text = Format(gsBAC_Fecp, gsc_FechaDMA)
    
    Call CargaObjeto_Periodicidad(cmbPeriodicidad)
End Sub

Private Sub optSiET_Click()
    Let cmbPeriodicidad.Enabled = True
    Let TXTFecha1.Enabled = True
    
    Call Func_VisualizaItems(True)
    
End Sub

Private Sub optNoET_Click()
    Let cmbPeriodicidad.Enabled = False
    Let TXTFecha1.Enabled = False
    
    Call Func_VisualizaItems(False)
    
End Sub


Private Function Func_VisualizaItems(ByVal oValor As Boolean)
    'If gsc_Operacion.nNumoper = 0 Then
    If nNumoper = o Then
        If oValor = True Then
            If cmbPeriodicidad.ListCount > 0 Then
                Let Me.cmbPeriodicidad.ListIndex = 0
            End If
        End If
        If oValor = False Then
            Let Me.cmbPeriodicidad.ListIndex = -1
        End If
    End If
    
End Function


Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
    Select Case Button.Index
        Case 2  'Grabar
            Call FuncSaveET
        Case 3  'Salir
            giAceptar_EarlyTermination = False
            Unload Me
            Exit Sub
    End Select
End Sub

Private Function FuncSaveET()
      
    If optSiET.Value = True And cmbPeriodicidad.ListIndex <= -1 Then
        Call MsgBox("- Debe seleccionar una periodicidad", vbInformation, App.Title)
        Exit Function
    End If
    
    If optSiET.Value = True Then
        Let giAceptar_EarlyTermination = True
        Let giMarca_EarlyTermination = IIf(optSiET.Value, 1, 0)
        Let giPeriodicidad_EarlyTermination = cmbPeriodicidad.ItemData(cmbPeriodicidad.ListIndex)
        Let giFechaInicio_EarlyTermination = TXTFecha1.Text
    Else
        Let giAceptar_EarlyTermination = False
        Let giMarca_EarlyTermination = IIf(optSiET.Value, 1, 0)
        'Let giPeriodicidad_EarlyTermination = cmbPeriodicidad.ItemData(cmbPeriodicidad.ListIndex)
        Let giFechaInicio_EarlyTermination = TXTFecha1.Text
    End If
    
    Unload Me
End Function


Private Function CargaObjeto_Periodicidad(ByRef oCombo As ComboBox) As Boolean
    Dim MISQL   As String
    Dim MiDatos()
    
    Let CargaObjeto_Periodicidad = False
    
    Envia = Array()
    Call AddParam(Envia, 1)
    Call AddParam(Envia, "9920")
    If Not Bac_Sql_Execute("BacParamSuda.dbo.SP_CON_INFO_COMBO", Envia) Then
        Exit Function
    End If
    
    Call oCombo.Clear
    
    Do While Bac_SQL_Fetch(MiDatos())
        Call oCombo.AddItem(UCase(MiDatos(6)))              '-> Define la Glosa
        Let oCombo.ItemData(oCombo.NewIndex) = MiDatos(2)   '-> Define el codigo

        Let CargaObjeto_Periodicidad = True
    Loop
    
    If CargaObjeto_Periodicidad = True Then
       'Let oCombo.ListIndex = 0    '-> Primer retorno cargado
    End If
    
    
End Function


Private Function Carga_Info_ET(ByRef oText As txtFecha) As Boolean 'ByRef oCombo As ComboBox, ByRef oText As TXTFecha) As Boolean
    Dim FechaInicio As Date
    Dim MISQL   As String
    Dim Datos()
    
    Let Carga_Info_ET = False
    
    Envia = Array()
    'Call AddParam(Envia, gsc_Operacion.nNumoper)
    Call AddParam(Envia, nNumoper)
    
    If Not Bac_Sql_Execute("SP_CargaEarlyTermination", Envia) Then
        Exit Function
    End If
    
    If Bac_SQL_Fetch(Datos()) Then
    
        If Datos(1) = True Then
            Let giAceptar_EarlyTermination = True
            Let optSiET.Value = True
        Else
            Let giAceptar_EarlyTermination = False
            Let optNoET.Value = True
        End If
       
        If Datos(2) > 0 Then
            Let Periodicidad = Datos(2)
        End If
         
        If Datos(3) <> "01-01-1900" Then
            Let TXTFecha1.Text = Datos(3)
        End If
        Let Carga_Info_ET = True
       
    End If
   
End Function
