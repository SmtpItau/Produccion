VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form Frm_SelCP_Ticket 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Selecciona datos de Cartera Ticket Intramesa"
   ClientHeight    =   4140
   ClientLeft      =   6075
   ClientTop       =   6240
   ClientWidth     =   6045
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
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MinButton       =   0   'False
   Moveable        =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4140
   ScaleWidth      =   6045
   ShowInTaskbar   =   0   'False
   Begin Threed.SSFrame Marco 
      Height          =   660
      Index           =   7
      Left            =   45
      TabIndex        =   14
      Top             =   510
      Width           =   2955
      _Version        =   65536
      _ExtentX        =   5212
      _ExtentY        =   1164
      _StockProps     =   14
      Caption         =   "Mesa"
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
      Begin VB.ComboBox CmbMesa 
         ForeColor       =   &H00000000&
         Height          =   315
         Left            =   120
         Style           =   2  'Dropdown List
         TabIndex        =   16
         Top             =   240
         Width           =   2700
      End
   End
   Begin Threed.SSFrame Marco 
      Height          =   2895
      Index           =   6
      Left            =   4080
      TabIndex        =   13
      Top             =   1200
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
         TabIndex        =   8
         Top             =   630
         Width           =   1410
      End
      Begin VB.OptionButton opt_tod_ser 
         Caption         =   "Todas"
         ForeColor       =   &H00800000&
         Height          =   195
         Left            =   240
         TabIndex        =   7
         Top             =   360
         Width           =   1245
      End
      Begin VB.ListBox lstSeries 
         ForeColor       =   &H00000000&
         Height          =   1815
         Left            =   120
         MultiSelect     =   1  'Simple
         Sorted          =   -1  'True
         TabIndex        =   9
         TabStop         =   0   'False
         Top             =   915
         Width           =   1665
      End
   End
   Begin Threed.SSFrame Marco 
      Height          =   2895
      Index           =   5
      Left            =   2055
      TabIndex        =   12
      Top             =   1200
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
         TabIndex        =   6
         TabStop         =   0   'False
         Top             =   915
         Width           =   1668
      End
      Begin VB.OptionButton Opt_tod_mon 
         Caption         =   "Todas"
         ForeColor       =   &H00800000&
         Height          =   195
         Left            =   150
         TabIndex        =   4
         Top             =   360
         Width           =   1245
      End
      Begin VB.OptionButton Opt_sel_mon 
         Caption         =   "Selección"
         ForeColor       =   &H00800000&
         Height          =   195
         Left            =   150
         TabIndex        =   5
         Top             =   630
         Width           =   1410
      End
   End
   Begin Threed.SSFrame Marco 
      Height          =   2895
      Index           =   3
      Left            =   45
      TabIndex        =   11
      Top             =   1200
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
         TabIndex        =   3
         TabStop         =   0   'False
         Top             =   885
         Width           =   1668
      End
      Begin VB.OptionButton Opt_tod_fam 
         Caption         =   "Todas"
         ForeColor       =   &H00800000&
         Height          =   195
         Left            =   135
         TabIndex        =   1
         Top             =   360
         Width           =   1290
      End
      Begin VB.OptionButton Opt_sel_fam 
         Caption         =   "Selección"
         ForeColor       =   &H00800000&
         Height          =   195
         Left            =   135
         TabIndex        =   2
         Top             =   630
         Width           =   1320
      End
   End
   Begin Threed.SSFrame Marco 
      Height          =   660
      Index           =   1
      Left            =   3120
      TabIndex        =   10
      Top             =   525
      Width           =   2925
      _Version        =   65536
      _ExtentX        =   5159
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
         Left            =   120
         Style           =   2  'Dropdown List
         TabIndex        =   0
         Top             =   270
         Width           =   2700
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Height          =   495
      Left            =   0
      TabIndex        =   15
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
            Description     =   "CANCELAR"
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   6120
      Top             =   0
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
            Picture         =   "frm_sel_datos.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_sel_datos.frx":0452
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "Frm_SelCP_Ticket"
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

Dim iLoadOk%
Dim objDCartera            As New clsDCarteras
Dim objTipCar              As New clsCodigos
Dim sw                     As Integer
Dim PrimeraVez             As Boolean
Dim npuntero               As Integer
Dim nContador              As Integer
Dim bRefrescar             As Boolean

Private Function ChkDatos() As Boolean

    ChkDatos = False
    
    If lstFamilias.SelCount = 0 And lstMonedas.SelCount = 0 And lstSeries.SelCount Then
        Call MsgBox("DEBE SELECCIONAR UN ITEM DE LAS LISTAS", vbExclamation, "Mensaje")
        Call lstFamilias.SetFocus
        Exit Function
    End If
    
    If lstFamilias.SelCount > 10 Then
        Call MsgBox("SE PERMITE UNA SELECCION MAXIMA DE 15 FAMILIAS", vbExclamation, "Mensaje")
        Call lstFamilias.SetFocus
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

Private Function FamiliasTICKETs() As Boolean
Dim Datos()
Dim Sql             As String
On Error GoTo ErrSel
   
    Let FamiliasTICKETs = False
    
    Envia = Array()
    
    If Me.CmbMesa.ListIndex <> -1 Then
        AddParam Envia, CmbMesa.ItemData(Me.CmbMesa.ListIndex)
    Else
        AddParam Envia, 0
    End If
    
    If Me.CmbTCart.ListIndex <> -1 Then
        AddParam Envia, Val(Right(Me.CmbTCart.Text, 10))
    Else
        AddParam Envia, 0
    End If
    
    Let Sql = "DBO.SP_LIS_FAMILIAS_VP_TICKET "
    
    If Not Bac_Sql_Execute(Sql, Envia) Then
        Exit Function
    End If
      
    Do While Bac_SQL_Fetch(Datos())
        Call lstFamilias.AddItem(Datos(1))
    Loop
    
    Let FamiliasTICKETs = True
    Exit Function
    
ErrSel:
    Call MsgBox("Problemas en la selección de familias disponibles: " & err.Description, vbCritical, "BAC Trader")
    Exit Function
    
End Function

Private Sub LlenarListas()
Dim Rutcart&

    Screen.MousePointer = vbHourglass
    
    lstFamilias.Clear
    lstMonedas.Clear
    lstSeries.Clear
    
    If Not FamiliasTICKETs() Then
        Screen.MousePointer = vbDefault
        MsgBox "NO  SE PUDO CONSULTAR FAMILIAS EN TABLA DE DISPONIBILIDAD", vbExclamation, "Mensaje"
    End If
        
    If Not MonedasTICKETS() Then
        Screen.MousePointer = vbDefault
        MsgBox "NO  SE PUDO CONSULTAR MONEDAS EN TABLA DE DISPONIBILIDAD", vbExclamation, "Mensaje"
    End If
    
    Screen.MousePointer = vbDefault
    

End Sub

Private Function MonedasTICKETS() As Boolean
Dim Datos()
Dim Sql             As String
On Error GoTo ErrDisp

    MonedasTICKETS = False
    
    Envia = Array()
    
    If Me.CmbMesa.ListIndex <> -1 Then
        AddParam Envia, CmbMesa.ItemData(Me.CmbMesa.ListIndex)
    Else
        AddParam Envia, 0
    End If
    
    If Me.CmbTCart.ListIndex <> -1 Then
        AddParam Envia, Right(Me.CmbTCart.Text, 10)
    Else
        AddParam Envia, 0
    End If
    
    Sql = "DBO.SP_LIS_MONEDAS_VP_TICKET "
    
    If Not Bac_Sql_Execute(Sql, Envia) Then
        Exit Function
    End If
    
    Do While Bac_SQL_Fetch(Datos())
        Call lstMonedas.AddItem(Datos(1))
    Loop
    
    MonedasTICKETS = True
    Exit Function
    
ErrDisp:
    MsgBox "Problemas en la selección de disponibilidad: " & err.Description, vbCritical, "BAC Trader"
    Exit Function

End Function


Private Sub Proc_Busca_Papeles_Disponibles(cCadena_Familia As String, cCadena_Moneda As String)

    Dim Datos()

    Envia = Array()
    AddParam Envia, cCadena_Familia
    AddParam Envia, cCadena_Moneda
    If Me.CmbMesa.ListIndex <> -1 Then
        AddParam Envia, CmbMesa.ItemData(Me.CmbMesa.ListIndex)
    Else
        AddParam Envia, 0
    End If
    
    If Me.CmbTCart.ListIndex <> -1 Then
        AddParam Envia, Val(Right(Me.CmbTCart.Text, 10))
    Else
        AddParam Envia, 0
    End If
    
    
    If Bac_Sql_Execute("DBO.SP_LIS_SERIES_VP_TICKET", Envia) Then
    
        
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

    Dim I%
    Dim cCadena_Familia     As String
    Dim cCadena_Emisor      As String
    Dim cCadena_Moneda      As String

    cCadena_Familia = ""
    cCadena_Emisor = ""
    cCadena_Moneda = ""
    
    Screen.MousePointer = vbHourglass
    
        
    If lstFamilias.SelCount > 0 Then
        For I% = 0 To lstFamilias.ListCount - 1
            If lstFamilias.Selected(I%) = True Then
                cCadena_Familia = cCadena_Familia & "-" & lstFamilias.List(I%)
            End If
        Next I%
    End If
    
    
    
    If lstMonedas.SelCount > 0 Then
        For I% = 0 To lstMonedas.ListCount - 1
            If lstMonedas.Selected(I%) = True Then
                cCadena_Moneda = cCadena_Moneda & "-" & lstMonedas.List(I%)
            End If
        Next I%
    End If
                
    Call Proc_Busca_Papeles_Disponibles(cCadena_Familia, cCadena_Moneda)

                                    
    Screen.MousePointer = vbDefault
    
End Sub

Private Sub CmbMesa_Click()

    Call LlenarListas
    
End Sub

Private Sub CmbTCart_Click()
    Dim I As Integer

    For nContador = 0 To lstFamilias.ListCount - 1
        lstFamilias.Selected(nContador) = False
    Next nContador
    
    For nContador = 0 To lstMonedas.ListCount - 1
        lstMonedas.Selected(nContador) = False
    Next nContador
    
    Call LlenarListas
    
    Opt_sel_fam.Value = True
    Opt_sel_mon.Value = True
    
    I = -1
    
    Do While I < Frm_TicketIntramesa.CmbCarteraDestino.ListCount And I <> CmbTCart.ListIndex
            I = I + 1
    Loop
    
    If I <> -1 And I < Frm_TicketIntramesa.CmbCarteraDestino.ListCount Then
         Frm_TicketIntramesa.CmbCarteraDestino.ListIndex = I
    End If

End Sub


Private Sub Form_Load()

    Call BacCentrarPantalla(Me)
        
    Let bRefrescar = True
   
    Call Me.CmbMesa.Clear
    Call Me.CmbTCart.Clear
    
    Call funcLoadObjCombo("EXECUTE bacparamsuda.DBO.SP_CARGAMESAS", Me.CmbMesa, False, False)
    Call PROC_LLENA_COMBOS(CmbTCart, 2, False, "VP", GLB_CARTERA, GLB_ID_SISTEMA)
    
    Me.CmbMesa.ListIndex = 0
    
    Let CmbTCart.Enabled = True
    
    
    Call lstFamilias.Clear
    Call lstMonedas.Clear
    
    Call LlenarListas
    Call BacControlWindows(12)
    Call SendKeys("{TAB}")
            
End Sub


Private Sub Form_LostFocus()

    Unload Me
    
End Sub


Private Sub lstFamilias_Click()
    
    Call lstSeries.Clear
    
    If lstFamilias.SelCount > 0 And bRefrescar = True Then
        Call Proc_Llena_Cadena
    End If
    
End Sub

Sub RemoverLista(ByVal sFamilia As String, Lista As ListBox)
Dim I As Integer
Dim iLargo As Integer
Dim iLargoFamilia As Integer

    iLargoFamilia = Len(sFamilia)

    iLargo = Lista.ListCount - 1

    For I = iLargo To 0 Step -1
         If Mid(Lista.List(I), 1, iLargoFamilia) = sFamilia Then Lista.RemoveItem I
    Next I

    If sFamilia = "BONOS" Then
       For I = iLargo To 0 Step -1
          'If Mid(Lista.List(I), 1, 1) = Mid(sFamilia, 1, 1) Then Lista.RemoveItem I
          If Right(Lista.List(I), 2) = 15 Then
             Lista.RemoveItem I
          End If
       Next I
    End If

    If sFamilia = "LCHR" Then
       For I = iLargo To 0 Step -1
          'If Mid(Lista.List(I), 1, 1) = Mid(sFamilia, 1, 1) Then Lista.RemoveItem I
          If Right(Lista.List(I), 3) = 20 Then
             Lista.RemoveItem I
          End If
       Next I
    End If
    
End Sub


Private Sub lstMonedas_Click()

    If lstFamilias.SelCount > 0 And bRefrescar = True Then
        Call lstSeries.Clear
        Call Proc_Llena_Cadena
    End If

End Sub

Private Sub Opt_sel_fam_Click()
Dim I As Integer
   
    Call lstSeries.Clear
    Let bRefrescar = False
    
    For I% = 0 To lstFamilias.ListCount - 1
        Let lstFamilias.Selected(I%) = False
    Next I%
    
    Let bRefrescar = True
   
End Sub


Private Sub Opt_sel_mon_Click()
   Dim I As Integer
   
    bRefrescar = False
   
   For I% = 0 To lstMonedas.ListCount - 1
       lstMonedas.Selected(I%) = False
   Next I%
   
   DoEvents
   
   bRefrescar = True
   
   lstSeries.Clear
   Call Proc_Llena_Cadena

   
End Sub


Private Sub opt_sel_ser_Click()
   Dim I As Integer
   For I% = 0 To lstSeries.ListCount - 1
       lstSeries.Selected(I%) = False
   Next I%
End Sub


Private Sub Opt_tod_fam_Click()
Dim I As Integer
    
    Let bRefrescar = False

    For I% = 0 To lstFamilias.ListCount - 1
        Let lstFamilias.Selected(I%) = True
    Next I%
    
    DoEvents
        
    Let bRefrescar = True
    
    Call lstFamilias_Click
    
    Let Marco(6).Enabled = False

End Sub

Private Sub Opt_tod_mon_Click()
Dim I As Integer

    bRefrescar = False

    For I% = 0 To lstMonedas.ListCount - 1
        lstMonedas.Selected(I%) = True
    Next I%
    
    DoEvents
    
    bRefrescar = True
    
    Call lstMonedas_Click

End Sub

Private Sub opt_tod_ser_Click()
Dim I As Integer
   
    If lstSeries.ListCount < 9 Then
        
        For I% = lstSeries.TopIndex To lstSeries.ListCount - 1
            Let lstSeries.Selected(I%) = True
        Next I%
        
    Else
        
        For I% = lstSeries.TopIndex To lstSeries.TopIndex + 8
            Let lstSeries.Selected(I%) = True
        Next I%
        
    End If
   
End Sub

Private Sub Aceptar()
On Error GoTo BacErrHnd24

Dim I%, Rutcart&
Dim SqlCad
Dim gSQLMesas As String
    
    If ChkDatos() = False Then
        Exit Sub
    End If

    gSQLVar = ""
    
    If CmbTCart.ListIndex > -1 Then
        gSQLVar = Trim(Right(CmbTCart.Text, 10))
        gs_Cart = Trim(Right(CmbTCart.Text, 10))
    End If
    
    If CmbMesa.ListIndex > -1 Then
        gSQLMesas = CmbMesa.ItemData(CmbMesa.ListIndex)
    End If

    
    'Familias
    gSQLFam = ""
    If lstFamilias.SelCount > 0 Then
        For I% = 0 To lstFamilias.ListCount - 1
            If lstFamilias.Selected(I%) = True Then
                gSQLFam = gSQLFam & "-" & lstFamilias.List(I%)
            End If
        Next I%
    Else
        For I% = 0 To lstFamilias.ListCount - 1
                gSQLFam = gSQLFam & "-" & lstFamilias.List(I%)
        Next I%
    End If
    
    
    'Monedas
    gSQLMon = ""
    If lstMonedas.SelCount > 0 Then
        For I% = 0 To lstMonedas.ListCount - 1
            If lstMonedas.Selected(I%) = True Then
                gSQLMon = gSQLMon & "-" & lstMonedas.List(I%)
            End If
        Next I%
    Else
        For I% = 0 To lstMonedas.ListCount - 1
            gSQLMon = gSQLMon & "-" & lstMonedas.List(I%)
        Next I%
    End If
    
   
   'Series
   gSQLSer = ""
   If lstSeries.SelCount > 0 Then
      For I% = 0 To lstSeries.ListCount - 1
          If lstSeries.Selected(I%) = True Then
              gSQLSer = gSQLSer & Mid(lstSeries.List(I%), 1, 20) & ";"
          End If
      Next I%
    
   End If
   If gSQLSer = "" Then
      gSQLSer = "VACIO"
 Else

End If
   
   giAceptar% = True
   
    ENVIA2 = Array( _
                Val(gSQLMesas), _
                Val(gSQLVar), _
                gSQLFam, _
                gSQLMon, _
                gSQLSer)
    
    Unload Me
    Exit Sub

BacErrHnd24:
   MsgBox error(err), vbExclamation, "MENSAJE"
   On Error GoTo 0
   
   
End Sub


Private Sub Cancelar()
 On Error GoTo BacErrHnd

    giAceptar% = False
    Unload Frm_SelCP_Ticket

    Exit Sub

BacErrHnd:
    MsgBox "ERROR", vbExclamation, "MENSAJE"
    On Error GoTo 0
    Resume
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
Dim I%

noOk = False
SiFMUT = False

    'Familias
    If lstFamilias.SelCount > 0 Then
        For I% = 0 To lstFamilias.ListCount - 1
            If lstFamilias.Selected(I%) = True And lstFamilias.List(I%) = "FMUTUO" Then
                SiFMUT = True
            End If
        Next I%
    End If

    If SiFMUT Then
        For I% = 0 To lstFamilias.ListCount - 1
            If lstFamilias.Selected(I%) = True And lstFamilias.List(I%) <> "FMUTUO" Then
                MsgBox "Si seleciono FONDOS MUTUOS, no deberia selecionar otra familia..."
                Validar_Seleccion_FM = True
                Exit Function
            End If
        Next I%
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


