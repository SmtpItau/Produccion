VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.1#0"; "MSCOMCTL.OCX"
Begin VB.Form BacIrfSl 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Seleccionar Información"
   ClientHeight    =   5580
   ClientLeft      =   1755
   ClientTop       =   2085
   ClientWidth     =   8100
   ClipControls    =   0   'False
   ControlBox      =   0   'False
   BeginProperty Font 
      Name            =   "MS Sans Serif"
      Size            =   8.25
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   ForeColor       =   &H00C0C0C0&
   Icon            =   "Bacirfsl.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   Moveable        =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5580
   ScaleWidth      =   8100
   ShowInTaskbar   =   0   'False
   Begin Threed.SSFrame SSF_Modalidad 
      Height          =   735
      Left            =   4080
      TabIndex        =   29
      Top             =   1920
      Width           =   3975
      _Version        =   65536
      _ExtentX        =   7011
      _ExtentY        =   1296
      _StockProps     =   14
      Caption         =   "Modalidad de Pago"
      ForeColor       =   8388608
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin VB.ComboBox CmbModalidad 
         ForeColor       =   &H00000000&
         Height          =   315
         ItemData        =   "Bacirfsl.frx":030A
         Left            =   120
         List            =   "Bacirfsl.frx":030C
         Style           =   2  'Dropdown List
         TabIndex        =   30
         Top             =   240
         Width           =   3795
      End
   End
   Begin Threed.SSFrame Marco 
      Height          =   660
      Index           =   7
      Left            =   45
      TabIndex        =   28
      Top             =   1230
      Width           =   3915
      _Version        =   65536
      _ExtentX        =   6906
      _ExtentY        =   1164
      _StockProps     =   14
      Caption         =   "Libro"
      ForeColor       =   8388608
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Font3D          =   1
      Begin VB.ComboBox CmbLibro 
         Height          =   315
         Left            =   135
         Style           =   2  'Dropdown List
         TabIndex        =   2
         Top             =   255
         Width           =   3690
      End
   End
   Begin Threed.SSFrame Marco 
      Height          =   2895
      Index           =   6
      Left            =   6120
      TabIndex        =   26
      Top             =   2640
      Width           =   1935
      _Version        =   65536
      _ExtentX        =   3413
      _ExtentY        =   5106
      _StockProps     =   14
      Caption         =   "Serie del Instrum."
      ForeColor       =   8388608
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Font3D          =   3
      Begin VB.OptionButton opt_sel_ser 
         Caption         =   "Selección"
         ForeColor       =   &H00800000&
         Height          =   195
         Left            =   240
         TabIndex        =   14
         Top             =   630
         Width           =   1410
      End
      Begin VB.OptionButton opt_tod_ser 
         Caption         =   "Todas"
         ForeColor       =   &H00800000&
         Height          =   195
         Left            =   240
         TabIndex        =   13
         Top             =   360
         Width           =   1245
      End
      Begin VB.ListBox lstSeries 
         ForeColor       =   &H00000000&
         Height          =   1815
         Left            =   120
         MultiSelect     =   1  'Simple
         Sorted          =   -1  'True
         TabIndex        =   15
         TabStop         =   0   'False
         Top             =   915
         Width           =   1665
      End
   End
   Begin Threed.SSFrame Marco 
      Height          =   2895
      Index           =   5
      Left            =   4095
      TabIndex        =   25
      Top             =   2640
      Width           =   1950
      _Version        =   65536
      _ExtentX        =   3440
      _ExtentY        =   5106
      _StockProps     =   14
      Caption         =   "Monedas"
      ForeColor       =   8388608
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Font3D          =   3
      Begin VB.ListBox lstMonedas 
         ForeColor       =   &H00000000&
         Height          =   1815
         Left            =   120
         MultiSelect     =   1  'Simple
         Sorted          =   -1  'True
         TabIndex        =   12
         TabStop         =   0   'False
         Top             =   915
         Width           =   1668
      End
      Begin VB.OptionButton Opt_tod_mon 
         Caption         =   "Todas"
         ForeColor       =   &H00800000&
         Height          =   195
         Left            =   150
         TabIndex        =   10
         Top             =   360
         Width           =   1245
      End
      Begin VB.OptionButton Opt_sel_mon 
         Caption         =   "Selección"
         ForeColor       =   &H00800000&
         Height          =   195
         Left            =   150
         TabIndex        =   11
         Top             =   630
         Width           =   1410
      End
   End
   Begin Threed.SSFrame Marco 
      Height          =   2895
      Index           =   4
      Left            =   2070
      TabIndex        =   24
      Top             =   2640
      Width           =   1950
      _Version        =   65536
      _ExtentX        =   3440
      _ExtentY        =   5106
      _StockProps     =   14
      Caption         =   "Emisores"
      ForeColor       =   8388608
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Font3D          =   3
      Begin VB.ListBox lstEmisores 
         Height          =   1815
         Left            =   120
         MultiSelect     =   1  'Simple
         Sorted          =   -1  'True
         TabIndex        =   9
         TabStop         =   0   'False
         Top             =   915
         Width           =   1668
      End
      Begin VB.OptionButton Opt_tod_emi 
         Caption         =   "Todos"
         ForeColor       =   &H00800000&
         Height          =   195
         Left            =   165
         TabIndex        =   7
         Top             =   360
         Width           =   1065
      End
      Begin VB.OptionButton Opt_sel_emi 
         Caption         =   "Selección"
         ForeColor       =   &H00800000&
         Height          =   195
         Left            =   165
         TabIndex        =   8
         Top             =   630
         Width           =   1245
      End
   End
   Begin Threed.SSFrame Marco 
      Height          =   2895
      Index           =   3
      Left            =   45
      TabIndex        =   23
      Top             =   2640
      Width           =   1950
      _Version        =   65536
      _ExtentX        =   3440
      _ExtentY        =   5106
      _StockProps     =   14
      Caption         =   "Familias"
      ForeColor       =   8388608
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Font3D          =   3
      Begin VB.ListBox lstFamilias 
         ForeColor       =   &H00000000&
         Height          =   1815
         Left            =   120
         MultiSelect     =   1  'Simple
         Sorted          =   -1  'True
         TabIndex        =   6
         TabStop         =   0   'False
         Top             =   885
         Width           =   1668
      End
      Begin VB.OptionButton Opt_tod_fam 
         Caption         =   "Todas"
         ForeColor       =   &H00800000&
         Height          =   195
         Left            =   135
         TabIndex        =   4
         Top             =   360
         Width           =   1290
      End
      Begin VB.OptionButton Opt_sel_fam 
         Caption         =   "Selección"
         ForeColor       =   &H00800000&
         Height          =   195
         Left            =   135
         TabIndex        =   5
         Top             =   630
         Width           =   1320
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Height          =   495
      Left            =   0
      TabIndex        =   21
      Top             =   0
      Width           =   8070
      _ExtentX        =   14235
      _ExtentY        =   873
      ButtonWidth     =   847
      ButtonHeight    =   820
      AllowCustomize  =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmbAceptar"
            Description     =   "ACEPTAR"
            Object.ToolTipText     =   "Aceptar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmbcancelar"
            Description     =   "CANCELAR"
            Object.ToolTipText     =   "Cancelar"
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin Threed.SSFrame Marco 
      Height          =   705
      Index           =   0
      Left            =   30
      TabIndex        =   19
      Top             =   495
      Width           =   8055
      _Version        =   65536
      _ExtentX        =   14208
      _ExtentY        =   1244
      _StockProps     =   14
      Caption         =   "Entidad"
      ForeColor       =   8388608
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Font3D          =   3
      Begin VB.ComboBox CmbEntidad 
         ForeColor       =   &H00000000&
         Height          =   315
         Left            =   120
         Style           =   2  'Dropdown List
         TabIndex        =   0
         Top             =   315
         Width           =   7815
      End
      Begin VB.TextBox txtRutCar 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00FFFFFF&
         Height          =   285
         Left            =   180
         MaxLength       =   9
         MouseIcon       =   "Bacirfsl.frx":030E
         MousePointer    =   99  'Custom
         TabIndex        =   16
         TabStop         =   0   'False
         Top             =   1500
         Width           =   1095
      End
      Begin VB.TextBox txtNomCar 
         BackColor       =   &H00FFFFFF&
         Enabled         =   0   'False
         Height          =   285
         Left            =   1800
         TabIndex        =   18
         TabStop         =   0   'False
         Top             =   1500
         Width           =   2895
      End
      Begin VB.TextBox txtDigCar 
         BackColor       =   &H00FFFFFF&
         Enabled         =   0   'False
         Height          =   285
         Left            =   1440
         TabIndex        =   17
         TabStop         =   0   'False
         Top             =   1500
         Width           =   255
      End
      Begin VB.Label Label 
         Caption         =   "-"
         Height          =   255
         Index           =   6
         Left            =   1320
         TabIndex        =   20
         Top             =   1500
         Width           =   135
      End
   End
   Begin Threed.SSFrame Marco 
      Height          =   660
      Index           =   1
      Left            =   4080
      TabIndex        =   22
      Top             =   1245
      Width           =   4005
      _Version        =   65536
      _ExtentX        =   7064
      _ExtentY        =   1164
      _StockProps     =   14
      Caption         =   "Tipo Cartera"
      ForeColor       =   8388608
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Font3D          =   3
      Begin VB.ComboBox CmbTCart 
         ForeColor       =   &H00000000&
         Height          =   315
         ItemData        =   "Bacirfsl.frx":0618
         Left            =   120
         List            =   "Bacirfsl.frx":061A
         Style           =   2  'Dropdown List
         TabIndex        =   1
         Top             =   270
         Width           =   3780
      End
   End
   Begin Threed.SSFrame Marco 
      Height          =   675
      Index           =   2
      Left            =   45
      TabIndex        =   27
      Top             =   1905
      Width           =   3930
      _Version        =   65536
      _ExtentX        =   6932
      _ExtentY        =   1191
      _StockProps     =   14
      Caption         =   "Categoría Cartera Super"
      ForeColor       =   8388608
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Font3D          =   3
      Begin VB.ComboBox cboCategSuper 
         ForeColor       =   &H00000000&
         Height          =   315
         ItemData        =   "Bacirfsl.frx":061C
         Left            =   120
         List            =   "Bacirfsl.frx":061E
         Style           =   2  'Dropdown List
         TabIndex        =   3
         Top             =   285
         Width           =   3735
      End
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   60
      Top             =   5340
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   25
      ImageHeight     =   25
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   2
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacirfsl.frx":0620
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacirfsl.frx":0A72
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "BacIrfSl"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
''============================
''Historial de Modificaciones
''============================
''Dia 07/04/2005
''Por Victor Gonzalez S.   : Solicitud de Cristian Mascareño para que las letras propia emision
''                           no aparezcan en el filtro de ventas con pacto
''
Option Explicit
Public bFlagDpx            As Boolean
Public ProTipOper          As String
Public oFiltroDVP          As DvpCp
Public MiTipoPago          As Integer
Public fecModPago          As String


Dim iLoadOk%
Dim objDCartera            As New clsDCarteras
Dim objTipCar              As New ClsCodigos
Dim SW                     As Integer
Dim PrimeraVez             As Boolean
Dim npuntero               As Integer
Dim nContador              As Integer
Dim bRefrescar             As Boolean




Private Function ChkDatos() As Boolean
   'Se validará que no se ingresen demasiadas familias,emisores o monedas
   'para que no sobrepase la longitud del string y no haga la consulta muy compleja

    ChkDatos = False
    
    If lstFamilias.SelCount = 0 And lstEmisores.SelCount = 0 And lstMonedas.SelCount = 0 And lstSeries.SelCount Then
        MsgBox "DEBE SELECCIONAR UN ITEM DE LAS LISTAS", vbExclamation, "Mensaje"
        lstFamilias.SetFocus
        Exit Function
    End If
    
    
    If lstFamilias.SelCount > 10 Then
        MsgBox "SE PERMITE UNA SELECCION MAXIMA DE 15 FAMILIAS", vbExclamation, "Mensaje"
        lstFamilias.SetFocus
        Exit Function
    End If
    
    If lstEmisores.SelCount > 10 Then
        MsgBox "SE PERMITE UNA SELECCION MAXIMA DE 15 EMISORES", vbExclamation, "Mensaje"
        lstEmisores.SetFocus
        Exit Function
    End If
    
    If lstMonedas.SelCount > 10 Then
        MsgBox "SE PERMITE UNA SELECCION MAXIMA DE 15 MONEDAS", vbExclamation, "Mensaje"
        lstMonedas.SetFocus
        Exit Function
    End If
    
    If lstSeries.SelCount > 10 Then
        MsgBox "SE PERMITE UNA SELECCION MAXIMA DE 15 SERIES", vbExclamation, "Mensaje"
        lstSeries.SetFocus
        Exit Function
    End If
    
    If Validar_Seleccion_FM() Then
        ChkDatos = False
        Exit Function
    End If
    
    ChkDatos = True
End Function

Private Function EmisoresEnDisponibilidad(Rutcart&) As Boolean
Dim SQL             As String
Dim Datos()

On Error GoTo ErrSelEmi

    EmisoresEnDisponibilidad = False
    If Mid$(BacTrader.ActiveForm.Tag, 1, 2) = "ST" Then

        Envia = Array(CDbl(Rutcart))
        
        If Not Bac_Sql_Execute("SP_DIEMISORESSORTEO", Envia) Then
            Exit Function
        End If
    Else

        Envia = Array(CDbl(Rutcart), _
                ProTipOper, _
                Trim(Right(cmbTCart.text, 10)))
                'CDbl(CmbTCart.ItemData(CmbTCart.ListIndex)))
                
        SQL = "SP_DIEMISORES" & IIf(bFlagDpx, "_DPX", "")

        If Not Bac_Sql_Execute(SQL, Envia) Then
            Exit Function
        End If
    End If
                  
    Do While Bac_SQL_Fetch(Datos())
        lstEmisores.AddItem Datos(1)
    Loop
    
    EmisoresEnDisponibilidad = True
    Exit Function
    
    
ErrSelEmi:
    MsgBox "Problemas en la selección de emisores disponibles: " & err.Description, vbCritical, "BAC Trader"
    Exit Function

End Function

Private Function FamiliasEnDisponibilidad(Rutcart&) As Boolean
Dim Datos()
Dim SQL             As String
On Error GoTo ErrSel
   
    FamiliasEnDisponibilidad = False
    
    If Mid$(BacTrader.ActiveForm.Tag, 1, 2) = "ST" Then
        Envia = Array(CDbl(Rutcart))
        If Not Bac_Sql_Execute("SP_DIFAMILIASSORTEO", Envia) Then
            Exit Function
        End If
    Else

        Envia = Array(CDbl(Rutcart), _
                ProTipOper, _
                Val(Trim(Right(cmbTCart.text, 10))))
                'CDbl(CmbTCart.ItemData(CmbTCart.ListIndex)))
        
        SQL = "SP_DIFAMILIAS" & IIf(bFlagDpx, "_DPX", "")
        If Not Bac_Sql_Execute(SQL, Envia) Then
            Exit Function
        End If

    End If
    
              
    Do While Bac_SQL_Fetch(Datos())
        lstFamilias.AddItem Datos(1)
    Loop
    
    FamiliasEnDisponibilidad = True
    Exit Function
    
ErrSel:
    MsgBox "Problemas en la selección de familias disponibles: " & err.Description, vbCritical, "BAC Trader"
    Exit Function
    
End Function

Private Sub LlenarListas()
Dim Rutcart&

    Screen.MousePointer = vbHourglass


    lstFamilias.Clear
    lstEmisores.Clear
    lstMonedas.Clear
    lstSeries.Clear
    
    Rutcart& = cmbEntidad.ItemData(cmbEntidad.ListIndex)
    If FamiliasEnDisponibilidad(Rutcart&) = False Then
        Screen.MousePointer = vbDefault
        MsgBox "NO  SE PUDO CONSULTAR FAMILIAS EN TABLA DE DISPONIBILIDAD", vbExclamation, "Mensaje"
    End If
        
    If EmisoresEnDisponibilidad(Rutcart&) = False Then
        Screen.MousePointer = vbDefault
        MsgBox "NO  SE PUDO CONSULTAR EMISORES EN TABLA DE DISPONIBILIDAD", vbExclamation, "Mensaje"
    End If
        
    If MonedasEnDisponibilidad(Rutcart&) = False Then
        Screen.MousePointer = vbDefault
        MsgBox "NO  SE PUDO CONSULTAR MONEDAS EN TABLA DE DISPONIBILIDAD", vbExclamation, "Mensaje"
    End If
    
    Screen.MousePointer = vbDefault
    

End Sub

Private Function MonedasEnDisponibilidad(Rutcart&) As Boolean
Dim Datos()
Dim SQL             As String
On Error GoTo ErrDisp

    MonedasEnDisponibilidad = False
    
    If Mid$(BacTrader.ActiveForm.Tag, 1, 2) = "ST" Then

        Envia = Array(CDbl(Rutcart))
        
        If Not Bac_Sql_Execute("SP_DIMONEDASSORTEO", Envia) Then
            Exit Function
        End If
    Else

        Envia = Array(CDbl(Rutcart), _
                ProTipOper, _
                Trim(Right(cmbTCart.text, 10)))
                'CDbl(CmbTCart.ItemData(CmbTCart.ListIndex)))
                
        SQL = "SP_DIMONEDAS" & IIf(bFlagDpx, "_DPX", "")
                
        If Not Bac_Sql_Execute(SQL, Envia) Then
            Exit Function
        End If

    End If
                  
    Do While Bac_SQL_Fetch(Datos())
        lstMonedas.AddItem Datos(1)
    Loop
    
    MonedasEnDisponibilidad = True
    Exit Function
    
ErrDisp:
    MsgBox "Problemas en la selección de disponibilidad: " & err.Description, vbCritical, "BAC Trader"
    Exit Function

End Function


Private Sub Proc_Busca_Papeles_Disponibles(cTipOper As String, cCadena_Familia As String, cCadena_Emisor As String, cCadena_Moneda As String, cLibro As String, cCarteraNorm As String, cCarteraFin As String)
    Dim Datos()

    Envia = Array()
    AddParam Envia, cTipOper
    AddParam Envia, cCadena_Familia
    AddParam Envia, cCadena_Emisor
    AddParam Envia, cCadena_Moneda
    AddParam Envia, Trim(cLibro)
    AddParam Envia, Trim(cCarteraNorm)
    AddParam Envia, Trim(cCarteraFin)
 ' ------------------------------------------------------------------------------------
 ' +++ VB 05/07/2018 desarrollo t+2 se envia fecha de pago para carga de papelees
 ' ------------------------------------------------------------------------------------
    AddParam Envia, Me.fecModPago
 ' ------------------------------------------------------------------------------------
 ' --- VB 05/07/2018 desarrollo t+2 se envia fecha de pago para carga de papelees
 ' ------------------------------------------------------------------------------------
    If Bac_Sql_Execute("SP_CON_PAPELES_DISPONIBLES", Envia) Then
        Do While Bac_SQL_Fetch(Datos())
            lstSeries.AddItem Trim(Datos(1)) & Space(20) & Trim(Datos(2))
        Loop
        Marco(6).Enabled = True
        opt_sel_ser.Value = True
    Else
        MsgBox "Ha ocurrido un error al intentar filtrar los papeles disponibles", vbCritical, "Error en Bac-Trader"
        Screen.MousePointer = vbDefault
    End If

End Sub

Sub Proc_Llena_Cadena()

    Dim i%
    Dim cCadena_Familia     As String
    Dim cCadena_Emisor      As String
    Dim cCadena_Moneda      As String

    cCadena_Familia = ""
    cCadena_Emisor = ""
    cCadena_Moneda = ""
    
    Screen.MousePointer = vbHourglass
    
        
    If lstFamilias.SelCount > 0 Then
        For i% = 0 To lstFamilias.ListCount - 1
            If lstFamilias.Selected(i%) = True Then
                cCadena_Familia = cCadena_Familia & "-" & lstFamilias.List(i%)
            End If
        Next i%
    End If
    
    If lstEmisores.SelCount > 0 Then
        For i% = 0 To lstEmisores.ListCount - 1
            If lstEmisores.Selected(i%) = True Then
                cCadena_Emisor = cCadena_Emisor & "-" & lstEmisores.List(i%)
            End If
        Next i%
    End If
    
    
    If lstMonedas.SelCount > 0 Then
        For i% = 0 To lstMonedas.ListCount - 1
            If lstMonedas.Selected(i%) = True Then
                cCadena_Moneda = cCadena_Moneda & "-" & lstMonedas.List(i%)
            End If
        Next i%
    End If
                
    Proc_Busca_Papeles_Disponibles ProTipOper, _
                                    cCadena_Familia, _
                                    cCadena_Emisor, _
                                    cCadena_Moneda, _
                                    Trim(Right(CmbLibro.text, 10)), _
                                    Trim(Right(cboCategSuper.text, 10)), _
                                    Trim(Right(cmbTCart.text, 10))
                                    
                                    
    Screen.MousePointer = vbDefault
    
End Sub

Private Sub cboCategSuper_Click()

    
    
    For nContador = 0 To lstEmisores.ListCount - 1
        lstEmisores.Selected(nContador) = False
    Next nContador
    
    For nContador = 0 To lstFamilias.ListCount - 1
        lstFamilias.Selected(nContador) = False
    Next nContador

    For nContador = 0 To lstMonedas.ListCount - 1
        lstMonedas.Selected(nContador) = False
    Next nContador

    Call LlenarListas
    
End Sub


Private Sub CmbEntidad_Change()

    lstEmisores.Clear
    lstMonedas.Clear
    lstFamilias.Clear
    
    Opt_sel_fam.Value = False
    Opt_tod_fam.Value = False
    
    Opt_tod_emi.Value = False
    Opt_sel_emi.Value = False
    
    Opt_tod_mon.Value = False
    Opt_sel_mon.Value = False
    
    Call LlenarListas


End Sub

Private Sub CmbLibro_Click()
        
    Call PROC_LLENA_COMBOS(cboCategSuper, 6, False, GLB_ID_SISTEMA, BacIrfSl.ProTipOper, Trim(Right(CmbLibro.text, 10)), GLB_CARTERA_NORMATIVA)
       
    If cboCategSuper.ListCount = 0 And Me.Visible = True Then
        MsgBox "El Libro " & Trim(Left(CmbLibro.text, 50)) & " No Tiene Asociada Ninguna Cartera Super", vbExclamation
    End If
    
    For nContador = 0 To lstEmisores.ListCount - 1
        lstEmisores.Selected(nContador) = False
    Next nContador
    
    For nContador = 0 To lstFamilias.ListCount - 1
        lstFamilias.Selected(nContador) = False
    Next nContador

    For nContador = 0 To lstMonedas.ListCount - 1
        lstMonedas.Selected(nContador) = False
    Next nContador
    
    Call LlenarListas
        
End Sub


Private Sub CmbTCart_Click()

    
    'Call CmbEntidad_Change
    
    For nContador = 0 To lstEmisores.ListCount - 1
        lstEmisores.Selected(nContador) = False
    Next nContador
    
    For nContador = 0 To lstFamilias.ListCount - 1
        lstFamilias.Selected(nContador) = False
    Next nContador

    For nContador = 0 To lstMonedas.ListCount - 1
        lstMonedas.Selected(nContador) = False
    Next nContador
   
    Call LlenarListas
    
    Opt_sel_fam.Value = True
    Opt_sel_emi.Value = True
    Opt_sel_mon.Value = True
    
End Sub


Private Sub Form_Activate()

    If CmbLibro.ListCount = 0 Then
        MsgBox "No Existen Libros Asociados A Este Producto", vbExclamation
        giAceptar% = 0
        Unload Me
        Exit Sub
    End If
   
    If cboCategSuper.ListCount = 0 Then
        MsgBox "El Libro " & Trim(Left(CmbLibro.text, 50)) & " No Tiene Asociada Ninguna Cartera Super", vbExclamation
        giAceptar% = 0
    End If

   CmbModalidad.Enabled = True
    If BacIrfSl.ProTipOper = "VP" Then
        If MiTipoPago = 1 Then
            CmbModalidad.ListIndex = 2
        Else
            CmbModalidad.ListIndex = 0
        End If
        '   CmbModalidad.ListIndex = (MiTipoPago + 1)
        '   CmbModalidad.Enabled = False
    End If
    

End Sub

Private Sub Form_Load()

    BacCentrarPantalla Me
   
    Set objDCartera = New clsDCarteras
        
    bRefrescar = True
    
    Call objDCartera.LeerDCarteras("")
    Call objDCartera.Coleccion2Control(Me.cmbEntidad)
   
    cmbEntidad.Enabled = True
    cmbEntidad.ListIndex = IIf(cmbEntidad.ListCount > 0, 0, -1)
    
    Call PROC_LLENA_COMBOS(cmbTCart, 2, False, ProTipOper, GLB_CARTERA, GLB_ID_SISTEMA)
    Call PROC_LLENA_COMBOS(CmbLibro, 5, False, GLB_ID_SISTEMA, BacIrfSl.ProTipOper, GLB_LIBRO)
   
    cmbTCart.Enabled = True
    
     If BacIrfSl.ProTipOper = "VP" Then
        SSF_Modalidad.Enabled = True
        SSF_Modalidad.Visible = True
        CmbModalidad.Visible = True
        
        
' ------------------------------------------------------------------------------------
' +++VFBF 20180705 SE AGREGA NUEVO OPCION DE TIPO DE PAGO
' ------------------------------------------------------------------------------------
        If Me.MiTipoPago = 1 Then
            CmbModalidad.AddItem "TODAS" + Space(120) + "T"
            CmbModalidad.AddItem "HOY" + Space(120) + "H"
            CmbModalidad.AddItem "MAÑANA" + Space(120) + "M"
        ElseIf Me.MiTipoPago = 0 Then
        '   CmbModalidad.AddItem "TODAS" + Space(120) + "T"
            CmbModalidad.AddItem "HOY" + Space(120) + "H"
        '   CmbModalidad.AddItem "MAÑANA" + Space(120) + "M"
        ElseIf Me.MiTipoPago = 2 Then
            CmbModalidad.AddItem "TODAS" + Space(120) + "T"
            CmbModalidad.AddItem "HOY" + Space(120) + "H"
            CmbModalidad.AddItem "MAÑANA" + Space(120) + "M"
            CmbModalidad.AddItem "T+2" + Space(120) + "M"
        End If
' ------------------------------------------------------------------------------------
' ---VFBF 20180705 SE AGREGA NUEVO OPCION DE TIPO DE PAGO
' ------------------------------------------------------------------------------------
        
        CmbModalidad.ListIndex = 0
     
     Else
        SSF_Modalidad.Enabled = False
        SSF_Modalidad.Visible = False
     End If
   
    lstFamilias.Clear
    lstEmisores.Clear
    lstMonedas.Clear
    
    Marco(6).Enabled = False
    
    Call LlenarListas
    
    BacControlWindows 12
    SendKeys "{TAB}"
            
End Sub


'
Private Sub Form_LostFocus()
    Unload Me
End Sub


Private Sub Form_Unload(Cancel As Integer)

    Set objDCartera = Nothing
    Set objTipCar = Nothing
    
End Sub

Private Sub lstEmisores_Click()

    If lstFamilias.SelCount > 0 And bRefrescar = True Then
                
        lstSeries.Clear
        
        Call Proc_Llena_Cadena
    
    End If

End Sub

Private Sub lstFamilias_Click()

    lstSeries.Clear

    If lstFamilias.SelCount > 0 And bRefrescar = True Then
        Proc_Llena_Cadena
    End If

'-------------------------------------------------------------------------------------------
''''    If lstFamilias.ListIndex > -1 Then
''''        For I% = 0 To lstFamilias.ListCount - 1
''''            If lstFamilias.Selected(I%) = True Then 'And i% = npuntero Then VGS 07/04/2005
''''               Cadena = Cadena & " diserie LIKE '" & lstFamilias.List(I%) & "%' OR"
''''
''''            '--------------- PARCHE ???????? ---------
''''            If lstFamilias.List(I%) = "LCHR" Then
''''            '' VGS 07/04/2005 NO filtrar las LCHR propia Emision en Ventas con Pacto
''''                cadena2 = IIf(proTipOper = "VI", "AND (digenemi <> 'BCO' or diserie <> 'LCHR')", "")
''''                SW = 20
''''            End If
''''            If lstFamilias.List(I%) = "BONOS" Then
''''            '' VGS 07/04/2005
''''                SW = 15
''''            End If
''''            '-----------------------------------------
''''            ElseIf lstFamilias.Selected(I%) = False Then
''''               RemoverLista lstFamilias.List(I%), lstSeries
''''            End If
''''        Next
''''
''''        If Cadena <> "" Then
''''            Sql = Sql & " (" & Mid(Cadena, 1, Len(Cadena) - 2) & ")" & cadena2 & " AND dinominal > 0 "
''''            Sql = Sql & " AND mddi.Estado_Operacion_Linea = '' "
''''            Sql = Sql & " AND ditipcart = '" & Trim(Right(CmbTCart.Text, 10)) & "'"
''''            Sql = Sql & " AND mddi.id_libro  = '" & Trim(Right(CmbLibro.Text, 10)) & "'"
''''            Sql = Sql & " AND mddi.codigo_carterasuper = '" & Trim(Right(cboCategSuper.Text, 10)) & "'"
''''            Sql = Sql & " AND (dirutcart = cprutcart AND dinumdocu = cpnumdocu AND dicorrela = cpcorrela OR (dirutcart = cirutcart AND dinumdocu = cinumdocu AND dicorrela = cicorrela)) GROUP BY diinstser , ISNULL(cpcodigo,cicodigo)" ''VGS 07/04/2005
''''
''''            If Bac_Sql_Execute(Sql) Then
''''                lstSeries.Clear
''''                Do While Bac_SQL_Fetch(datos())
''''                    lstSeries.AddItem datos(1) & Space(20) & datos(2)
''''                Loop
''''                Marco(6).Enabled = True
''''                opt_sel_ser.Value = True
''''            End If
''''        End If
''''    End If
    
End Sub

Sub RemoverLista(ByVal sFamilia As String, Lista As ListBox)
Dim i As Integer
Dim iLargo As Integer
Dim iLargoFamilia As Integer

    iLargoFamilia = Len(sFamilia)

    iLargo = Lista.ListCount - 1

    For i = iLargo To 0 Step -1
         If Mid(Lista.List(i), 1, iLargoFamilia) = sFamilia Then Lista.RemoveItem i
    Next i

If sFamilia = "BONOS" Then
   For i = iLargo To 0 Step -1
      'If Mid(Lista.List(I), 1, 1) = Mid(sFamilia, 1, 1) Then Lista.RemoveItem I
      If Right(Lista.List(i), 2) = 15 Then
         Lista.RemoveItem i
      End If
   Next i
End If

If sFamilia = "LCHR" Then
   For i = iLargo To 0 Step -1
      'If Mid(Lista.List(I), 1, 1) = Mid(sFamilia, 1, 1) Then Lista.RemoveItem I
      If Right(Lista.List(i), 3) = 20 Then
         Lista.RemoveItem i
      End If
   Next i
End If
End Sub


Private Sub lstMonedas_Click()

    If lstFamilias.SelCount > 0 And bRefrescar = True Then
    
        lstSeries.Clear
                
        Call Proc_Llena_Cadena
    
    End If

End Sub

Private Sub Opt_sel_emi_Click()
   Dim i As Integer
   
   bRefrescar = False
   
   For i% = 0 To lstEmisores.ListCount - 1
       lstEmisores.Selected(i%) = False
   Next i%
   
   DoEvents
   
   bRefrescar = True
   
   lstSeries.Clear
   Call Proc_Llena_Cadena
   
End Sub


Private Sub Opt_sel_fam_Click()
   Dim i As Integer
   
    lstSeries.Clear
    bRefrescar = False
   
    For i% = 0 To lstFamilias.ListCount - 1
        lstFamilias.Selected(i%) = False
    Next i%
    
    bRefrescar = True
   
End Sub


Private Sub Opt_sel_mon_Click()
   Dim i As Integer
   
    bRefrescar = False
   
   For i% = 0 To lstMonedas.ListCount - 1
       lstMonedas.Selected(i%) = False
   Next i%
   
   DoEvents
   
   bRefrescar = True
   
   lstSeries.Clear
   Call Proc_Llena_Cadena

   
End Sub


Private Sub opt_sel_ser_Click()
   Dim i As Integer
   For i% = 0 To lstSeries.ListCount - 1
       lstSeries.Selected(i%) = False
   Next i%
End Sub

Private Sub Opt_tod_emi_Click()
Dim i As Integer


    bRefrescar = False

    For i% = 0 To lstEmisores.ListCount - 1
        lstEmisores.Selected(i%) = True
    Next i%
    
    DoEvents

    bRefrescar = True
    
    Call lstEmisores_Click



End Sub

Private Sub Opt_tod_fam_Click()
    
    Dim i As Integer
    
    bRefrescar = False

    For i% = 0 To lstFamilias.ListCount - 1
        lstFamilias.Selected(i%) = True
    Next i%
    
    DoEvents
        
    bRefrescar = True
    
    Call lstFamilias_Click
    
    Marco(6).Enabled = False

End Sub

Private Sub Opt_tod_mon_Click()
Dim i As Integer

    bRefrescar = False

    For i% = 0 To lstMonedas.ListCount - 1
        lstMonedas.Selected(i%) = True
    Next i%
    
    DoEvents
    
    bRefrescar = True
    
    Call lstMonedas_Click

End Sub

Private Sub opt_tod_ser_Click()
   Dim i As Integer
   
   If lstSeries.ListCount < 9 Then
      For i% = lstSeries.TopIndex To lstSeries.ListCount - 1
          lstSeries.Selected(i%) = True
      Next i%
   Else
      For i% = lstSeries.TopIndex To lstSeries.TopIndex + 8
          lstSeries.Selected(i%) = True
      Next i%
   End If
End Sub

Private Sub Aceptar()
    
On Error GoTo BacErrHnd24

Dim i%, Rutcart&
Dim SqlCad
    
    If ChkDatos() = False Then
        Exit Sub
    End If
    
    If cboCategSuper.ListIndex = -1 Then
        MsgBox "Debe Seleccionar una Cartera Super", vbExclamation
        Exit Sub
    End If
       
    Rutcart& = cmbEntidad.ItemData(cmbEntidad.ListIndex)

    gSQLVar = ""
    
    If cmbTCart.ListIndex > -1 Then
        gSQLVar = Trim(Right(cmbTCart.text, 10)) 'CmbTCart.ItemData(CmbTCart.ListIndex)
        gs_Cart = Trim(Right(cmbTCart.text, 10)) 'CmbTCart.ItemData(CmbTCart.ListIndex)
    End If
    
    'Familias
    gSQLFam = ""
    If lstFamilias.SelCount > 0 Then
        For i% = 0 To lstFamilias.ListCount - 1
            If lstFamilias.Selected(i%) = True Then
                gSQLFam = gSQLFam & "-" & lstFamilias.List(i%)
            End If
        Next i%
    Else
        For i% = 0 To lstFamilias.ListCount - 1
                gSQLFam = gSQLFam & "-" & lstFamilias.List(i%)
        Next i%
    End If
    
    'Emisores
    gSQLEmi = ""
    If lstEmisores.SelCount > 0 Then
        For i% = 0 To lstEmisores.ListCount - 1
            If lstEmisores.Selected(i%) = True Then
                gSQLEmi = gSQLEmi & "-" & lstEmisores.List(i%)
            End If
        Next i%
    Else
        For i% = 0 To lstEmisores.ListCount - 1
            gSQLEmi = gSQLEmi & "-" & lstEmisores.List(i%)
        Next i%
    End If
    
    'Monedas
    gSQLMon = ""
    If lstMonedas.SelCount > 0 Then
        For i% = 0 To lstMonedas.ListCount - 1
            If lstMonedas.Selected(i%) = True Then
                gSQLMon = gSQLMon & "-" & lstMonedas.List(i%)
            End If
        Next i%
    Else
        For i% = 0 To lstMonedas.ListCount - 1
            gSQLMon = gSQLMon & "-" & lstMonedas.List(i%)
        Next i%
    End If
    
   
   'Series
   gSQLSer = ""
   If lstSeries.SelCount > 0 Then
      For i% = 0 To lstSeries.ListCount - 1
          If lstSeries.Selected(i%) = True Then
              gSQLSer = gSQLSer & Mid(lstSeries.List(i%), 1, 20) & ";"
          End If
      Next i%
    
   End If
   If gSQLSer = "" Then
      gSQLSer = "VACIO"
 Else

End If
   
   giAceptar% = True
   
    Envia = Array( _
            Rutcart&, _
            gSQLVar, _
            gSQLFam, _
            gSQLEmi, _
            gSQLMon, _
            gSQLSer, _
            Trim(Right(cboCategSuper.text, 10)), _
            gsBac_User, _
            CmbLibro.text)
            
    If BacIrfSl.ProTipOper = "VP" Then
        AddParam Envia, Mid(CmbModalidad.text, 1, 1)
    End If
            
   RutCartV = cmbEntidad.ItemData(cmbEntidad.ListIndex)

   Unload Me
   Exit Sub

BacErrHnd24:
   MsgBox Error(err), vbExclamation, "MENSAJE"
   On Error GoTo 0
   
   
End Sub


Private Sub Cancelar()
 On Error GoTo BacErrHnd

    giAceptar% = False
    Unload BacIrfSl

    Exit Sub

BacErrHnd:
    MsgBox "ERROR", vbExclamation, "MENSAJE"
    On Error GoTo 0
    Resume
End Sub


Private Sub Ayuda()

    BacAyuda.Tag = "MDCD"
    
    BacAyuda.Show 1
    BacControlWindows 12
    
    If giAceptar% = True Then
        txtRutCar.text = gsrut$
        txtDigCar.text = gsDigito$
        txtNomCar.text = gsDescripcion$
        SendKeys "{TAB}"
    End If

End Sub


Private Sub txtRutCar_Change()

    txtNomCar.text = ""
    lstFamilias.Clear
    lstEmisores.Clear
    lstMonedas.Clear
    
End Sub


Private Sub txtRutCar_DblClick()

    Ayuda
    lstFamilias.Clear
    lstEmisores.Clear
    lstMonedas.Clear
    
End Sub


Private Sub txtRutCar_KeyPress(KeyAscii As Integer)

    BacCaracterNumerico KeyAscii
    
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
    
    Select Case UCase(Button.Description)
        
        Case "ACEPTAR"
            Call Aceptar
            
        Case "CANCELAR"
            Call Cancelar
    
    End Select
    
End Sub

Function Validar_Seleccion_FM() As Boolean
Dim iRow As Integer
Dim noOk As Boolean
Dim SiFMUT As Boolean
Dim i%

noOk = False
SiFMUT = False

    'Familias
    If lstFamilias.SelCount > 0 Then
        For i% = 0 To lstFamilias.ListCount - 1
            If lstFamilias.Selected(i%) = True And lstFamilias.List(i%) = "FMUTUO" Then
                SiFMUT = True
            End If
        Next i%
    End If

    If SiFMUT Then
        For i% = 0 To lstFamilias.ListCount - 1
            If lstFamilias.Selected(i%) = True And lstFamilias.List(i%) <> "FMUTUO" Then
                MsgBox "Si seleciono FONDOS MUTUOS, no deberia selecionar otra familia..."
                Validar_Seleccion_FM = True
                Exit Function
            End If
        Next i%
        If SiFMUT And lstEmisores.SelCount > 0 Then
           MsgBox "Si seleciono FONDOS MUTUOS, no deberia selecionar EMISORES..."
           Validar_Seleccion_FM = True
           Exit Function
        End If
        If lstMonedas.SelCount > 1 Then
           MsgBox "Si seleciono FONDOS MUTUOS, no deberia selecionar mas de una MONEDA..."
           Validar_Seleccion_FM = True
           Exit Function
        End If
        If lstSeries.SelCount > 1 Then
           MsgBox "Si seleciono FONDOS MUTUOS, no deberia selecionar mas de una SERIE..."
           Validar_Seleccion_FM = True
           Exit Function
        End If
        If lstMonedas.SelCount = 0 And lstSeries.SelCount = 0 Then
           MsgBox "Si seleciono FONDOS MUTUOS, deberia selecionar MONEDA o SERIE..."
           Validar_Seleccion_FM = True
           Exit Function
        End If
        
    End If

Validar_Seleccion_FM = False

End Function


