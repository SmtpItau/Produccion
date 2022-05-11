VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Begin VB.Form BacIrfSl 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Seleccionar Información"
   ClientHeight    =   4440
   ClientLeft      =   1755
   ClientTop       =   2085
   ClientWidth     =   7515
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
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MinButton       =   0   'False
   Moveable        =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4440
   ScaleWidth      =   7515
   ShowInTaskbar   =   0   'False
   Begin Threed.SSFrame Marco 
      Height          =   2895
      Index           =   6
      Left            =   4170
      TabIndex        =   21
      Top             =   1440
      Width           =   3225
      _Version        =   65536
      _ExtentX        =   5689
      _ExtentY        =   5106
      _StockProps     =   14
      Caption         =   "Serie"
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
         TabIndex        =   26
         Top             =   630
         Width           =   1410
      End
      Begin VB.OptionButton opt_tod_ser 
         Caption         =   "Todas"
         ForeColor       =   &H00800000&
         Height          =   195
         Left            =   240
         TabIndex        =   25
         Top             =   360
         Width           =   1245
      End
      Begin VB.ListBox lstSeries 
         ForeColor       =   &H00000000&
         Height          =   1815
         Left            =   120
         MultiSelect     =   1  'Simple
         Sorted          =   -1  'True
         TabIndex        =   24
         TabStop         =   0   'False
         Top             =   915
         Width           =   3015
      End
   End
   Begin Threed.SSFrame Marco 
      Height          =   2895
      Index           =   5
      Left            =   2130
      TabIndex        =   20
      Top             =   1440
      Width           =   1965
      _Version        =   65536
      _ExtentX        =   3466
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
         Left            =   150
         MultiSelect     =   1  'Simple
         Sorted          =   -1  'True
         TabIndex        =   9
         TabStop         =   0   'False
         Top             =   930
         Width           =   1668
      End
      Begin VB.OptionButton Opt_tod_mon 
         Caption         =   "Todas"
         ForeColor       =   &H00800000&
         Height          =   195
         Left            =   150
         TabIndex        =   7
         Top             =   360
         Width           =   1245
      End
      Begin VB.OptionButton Opt_sel_mon 
         Caption         =   "Selección"
         ForeColor       =   &H00800000&
         Height          =   195
         Left            =   150
         TabIndex        =   8
         Top             =   630
         Width           =   1410
      End
   End
   Begin Threed.SSFrame Marco 
      Height          =   2895
      Index           =   4
      Left            =   2040
      TabIndex        =   19
      Top             =   5220
      Visible         =   0   'False
      Width           =   1965
      _Version        =   65536
      _ExtentX        =   3466
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
         TabIndex        =   6
         TabStop         =   0   'False
         Top             =   915
         Width           =   1668
      End
      Begin VB.OptionButton Opt_tod_emi 
         Caption         =   "Todos"
         ForeColor       =   &H00800000&
         Height          =   195
         Left            =   165
         TabIndex        =   4
         Top             =   360
         Width           =   1065
      End
      Begin VB.OptionButton Opt_sel_emi 
         Caption         =   "Selección"
         ForeColor       =   &H00800000&
         Height          =   195
         Left            =   165
         TabIndex        =   5
         Top             =   630
         Width           =   1245
      End
   End
   Begin Threed.SSFrame Marco 
      Height          =   2895
      Index           =   3
      Left            =   120
      TabIndex        =   18
      Top             =   1440
      Width           =   1965
      _Version        =   65536
      _ExtentX        =   3466
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
         TabIndex        =   2
         TabStop         =   0   'False
         Top             =   915
         Width           =   1665
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
         TabIndex        =   3
         Top             =   630
         Width           =   1320
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Height          =   495
      Left            =   0
      TabIndex        =   16
      Top             =   0
      Width           =   7470
      _ExtentX        =   13176
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
      Height          =   795
      Index           =   1
      Left            =   0
      TabIndex        =   17
      Top             =   510
      Width           =   3675
      _Version        =   65536
      _ExtentX        =   6482
      _ExtentY        =   1402
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
         ItemData        =   "Bacirfsl.frx":030A
         Left            =   120
         List            =   "Bacirfsl.frx":030C
         Style           =   2  'Dropdown List
         TabIndex        =   10
         Top             =   315
         Width           =   3435
      End
   End
   Begin Threed.SSFrame Marco 
      Height          =   795
      Index           =   2
      Left            =   3810
      TabIndex        =   22
      Top             =   510
      Width           =   3615
      _Version        =   65536
      _ExtentX        =   6376
      _ExtentY        =   1402
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
         ItemData        =   "Bacirfsl.frx":030E
         Left            =   120
         List            =   "Bacirfsl.frx":0310
         Style           =   2  'Dropdown List
         TabIndex        =   23
         Top             =   315
         Width           =   3375
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
            Picture         =   "Bacirfsl.frx":0312
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacirfsl.frx":0764
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin Threed.SSFrame Marco 
      Height          =   795
      Index           =   0
      Left            =   0
      TabIndex        =   14
      Top             =   3555
      Visible         =   0   'False
      Width           =   6435
      _Version        =   65536
      _ExtentX        =   11351
      _ExtentY        =   1402
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
         MouseIcon       =   "Bacirfsl.frx":0BB6
         MousePointer    =   99  'Custom
         TabIndex        =   11
         TabStop         =   0   'False
         Top             =   1500
         Width           =   1095
      End
      Begin VB.TextBox txtNomCar 
         BackColor       =   &H00FFFFFF&
         Enabled         =   0   'False
         Height          =   285
         Left            =   1800
         TabIndex        =   13
         TabStop         =   0   'False
         Top             =   1500
         Width           =   2895
      End
      Begin VB.TextBox txtDigCar 
         BackColor       =   &H00FFFFFF&
         Enabled         =   0   'False
         Height          =   285
         Left            =   1440
         TabIndex        =   12
         TabStop         =   0   'False
         Top             =   1500
         Width           =   255
      End
      Begin VB.Label Label 
         Caption         =   "-"
         Height          =   255
         Index           =   6
         Left            =   1320
         TabIndex        =   15
         Top             =   1500
         Width           =   135
      End
   End
End
Attribute VB_Name = "BacIrfSl"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Public bFlagDpx                 As Boolean
Dim iLoadOk%
Dim objDCartera As New clsDCarteras
Dim objTipCar   As New clsCodigos
Dim sw As Integer
Public proTipOper   As String

Dim PrimeraVez As Boolean
Dim npuntero As Integer

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
    
    ChkDatos = True

End Function

Private Function EmisoresEnDisponibilidad(RutCart&) As Boolean

Dim Sql             As String
Dim datos()

On Error GoTo ErrSelEmi

    EmisoresEnDisponibilidad = False
'    If Mid$(BacTrader.ActiveForm.Tag, 1, 2) = "ST" Then
'
'        envia = Array(CDbl(Rutcart))
'
'        If Not Bac_Sql_Execute("SP_DIEMISORESSORTEO", envia) Then
'            Exit Function
'        End If
'    Else
'
'        envia = Array(CDbl(Rutcart), _
'                proTipOper, _
'                CDbl(CmbTCart.ItemData(CmbTCart.ListIndex)))
'
'        Sql = "SP_DIEMISORES" & IIf(bFlagDpx, "_DPX", "")
'
'        If Not Bac_Sql_Execute(Sql, envia) Then
'            Exit Function
'        End If
'    End If
'
'    Do While Bac_SQL_Fetch(DATOS())
'        lstEmisores.AddItem DATOS(1)
'    Loop
'
    EmisoresEnDisponibilidad = True
    Exit Function
    
    
ErrSelEmi:
    MsgBox "Problemas en la selección de emisores disponibles: " & err.Description, vbCritical, "BAC Trader"
    Exit Function

End Function

Private Function FamiliasEnDisponibilidad(RutCart&) As Boolean
Dim datos()
Dim Sql             As String

On Error GoTo ErrSel
   
    FamiliasEnDisponibilidad = False
    
    lstFamilias.Clear
    If Bac_Sql_Execute("Svc_Gen_fam_ins") Then
        Do While Bac_SQL_Fetch(datos)
            lstFamilias.AddItem datos(2)
            lstFamilias.ItemData(lstFamilias.NewIndex) = Val(datos(1))
        Loop
    End If
    
    FamiliasEnDisponibilidad = True
    Exit Function
    
ErrSel:
    MsgBox "Problemas en la selección de familias disponibles: " & err.Description, vbCritical, "Bonos Exterior"
    Exit Function
    
End Function

Private Sub LlenarListas()
Dim RutCart&
    
    RutCart& = gsBac_RutC 'CmbEntidad.ItemData(CmbEntidad.ListIndex)
    If FamiliasEnDisponibilidad(RutCart&) = False Then
        MsgBox "NO  SE PUDO CONSULTAR FAMILIAS EN TABLA DE DISPONIBILIDAD", vbExclamation, "Mensaje"
    End If
        
    If EmisoresEnDisponibilidad(RutCart&) = False Then
         MsgBox "NO  SE PUDO CONSULTAR EMISORES EN TABLA DE DISPONIBILIDAD", vbExclamation, "Mensaje"
    End If
        
    If MonedasEnDisponibilidad = False Then
         MsgBox "NO  SE PUDO CONSULTAR MONEDAS EN TABLA DE DISPONIBILIDAD", vbExclamation, "Mensaje"
    End If

End Sub

Private Function MonedasEnDisponibilidad() As Boolean
Dim datos()
Dim Sql             As String
On Error GoTo ErrDisp
Dim TIPOPROD As String

On Error GoTo ErrDisp

    MonedasEnDisponibilidad = False
    
    Sql = "sp_Invex_MonedasDisponibles"
            
    If Not Bac_Sql_Execute(Sql) Then
        Exit Function
    End If
             
    Do While Bac_SQL_Fetch(datos())
        lstMonedas.AddItem datos(1)
        lstMonedas.ItemData(lstMonedas.NewIndex) = CDbl(datos(2))
    Loop
    
    MonedasEnDisponibilidad = True
    Exit Function
    
ErrDisp:
    MsgBox "Problemas en la selección de disponibilidad: " & err.Description, vbCritical, "Bonos Exterior"
    Exit Function

End Function

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

Private Sub CmbTCart_Click()

    Call CmbEntidad_Change
    
    Opt_sel_fam.Value = True
    Opt_sel_emi.Value = True
    Opt_sel_mon.Value = True
    
End Sub


Private Sub Form_Load()

    Dim datos()
    ReDim Preserve OperacionesVenta(0)
    Set objDCartera = New clsDCarteras
    
    CmbEntidad.Visible = False
    Call objTipCar.LeerCodigos(204)
    Call objTipCar.Coleccion2Control(CmbTCart)
    
    CmbTCart.Enabled = True
    CmbTCart.ListIndex = IIf(CmbTCart.ListCount > 0, 0, -1)
   
    If Not Bac_Sql_Execute("sp_categoria_carterasuper") Then
        Exit Sub
    End If

     cboCategSuper.Clear

    Do While Bac_SQL_Fetch(datos())
        cboCategSuper.AddItem datos(1)
        
    Loop

    cboCategSuper.ListIndex = IIf(cboCategSuper.ListCount > 0, 0, -1)

    lstFamilias.Clear
    lstEmisores.Clear
    lstMonedas.Clear
    
    Marco(6).Enabled = False
    
    Call LlenarListas
    
    SendKeys "{TAB}"
            
End Sub


Private Sub Form_LostFocus()
    Unload Me
End Sub


Private Sub Form_Unload(Cancel As Integer)

    Set objDCartera = Nothing
    Set objTipCar = Nothing
    
End Sub

Private Sub lstFamilias_Click()
Dim Sql As String
Dim j%
Dim i%
Dim Cadena
Dim datos()
Dim cadena2 As String
Dim M%
Dim ok As Boolean
Dim X%
ok = False
npuntero = lstFamilias.ListIndex
Dim codMon As String
Dim SQL1 As String


'SELECT car.id_instrum,car.cod_familia , car.cpmonemi, car.cpnumdocu
'FROM text_ctr_inv car ,text_mvt_dri
'WHERE car.cod_familia = 2000 and  car.codigo_carterasuper = 'T'  AND car.cpmonemi = 13 AND car.cpnominal>0
'AND car.cpnumdocu =* monumoper
'AND mostatreg = ""
'GROUP BY car.id_instrum , car.cod_familia, car.cpmonemi,car.cpnumdocu

Sql = "SELECT isnull (car.id_instrum , ' ') , isnull( car.cod_familia , 0 ) , isnull( car.cpmonemi, 0) , isnull(car.cpnumdocu, 0) " _
     & " FROM text_ctr_inv car ,text_mvt_dri WHERE "
    
Cadena = " "
codMon = " "
    If lstFamilias.ListIndex > -1 Then
        For i% = 0 To lstFamilias.ListCount - 1
            If lstFamilias.Selected(i%) = True And i% = npuntero Then
        
                cadena2 = " car.cod_familia = " & lstFamilias.ItemData(i%)
                
          '      If CmbTCart.ListIndex > -1 Then
          '          cadena2 = cadena2 & " and  tipo_cartera_financiera = " & CmbTCart.ItemData(CmbTCart.ListIndex)
          '        End If
                
                If cboCategSuper.ListIndex > -1 Then
                    cadena2 = cadena2 & " and  car.codigo_carterasuper = '" & Left(cboCategSuper, 1) & "' "
                End If
                
                
            ElseIf lstFamilias.Selected(i%) = False Then
               RemoverLista lstFamilias.ItemData(i%), lstSeries
            End If
        Next
  
      
        If cadena2 <> "" Then
        
            If lstMonedas.ListCount > 0 Then
                For M% = 0 To lstMonedas.ListCount - 1
                    Cadena = " "
                    codMon = " "
                     If lstMonedas.Selected(M%) = True Then
                         Cadena = " AND car.cpmonemi = " & lstMonedas.ItemData(M)
                         codMon = lstMonedas.ItemData(M)
                                      
                           
                        SQL1 = Sql & cadena2 & Cadena & " AND cpnominal>0  AND car.cpnumdocu =* monumoper " _
                               & " AND mostatreg = ''  GROUP BY car.id_instrum , car.cod_familia, cpmonemi,cpnumdocu "
                               
                        If Bac_Sql_Execute(SQL1) Then
                            
                            Do While Bac_SQL_Fetch(datos())
                              For X = 0 To lstSeries.ListCount - 1
                                    If lstSeries.ItemData(X) = datos(2) And (datos(1) & Space(100) & datos(4) & Space(20) & datos(3)) = lstSeries.List(X) Then
                                        ok = True
                                        Exit For
                                    End If
                              Next X
                                                       
                                If Not ok Then
                                        lstSeries.AddItem datos(1) & Space(100) & datos(4) & Space(20) & datos(3)
                                        lstSeries.ItemData(lstSeries.NewIndex) = (datos(2))
                                End If
                             ok = False
                            Loop
                            Marco(6).Enabled = True
                            opt_sel_ser.Value = True
                        End If
                    End If
                Next
                
                If Len(Trim(Cadena)) = 0 Then
                        SQL1 = Sql & cadena2 & " AND cpnominal>0  AND car.cpnumdocu =* monumoper " _
                               & " AND mostatreg = ''  GROUP BY car.id_instrum , car.cod_familia, cpmonemi,cpnumdocu "
                               
                        If Bac_Sql_Execute(SQL1) Then
                            
                            Do While Bac_SQL_Fetch(datos())
                              For X = 0 To lstSeries.ListCount - 1
                                    If lstSeries.ItemData(X) = datos(2) And (datos(1) & Space(100) & datos(4) & Space(20) & datos(3)) = lstSeries.List(X) Then
                                        ok = True
                                        Exit For
                                    End If
                              Next X
                                                       
                                If Not ok Then
                                        lstSeries.AddItem datos(1) & Space(100) & datos(4) & Space(20) & datos(3)
                                        lstSeries.ItemData(lstSeries.NewIndex) = (datos(2))
                                End If
                             ok = False
                            Loop
                            Marco(6).Enabled = True
                            opt_sel_ser.Value = True
                        End If
                
                End If
                
            Else
            
                'Sql = Sql & cadena2 & Cadena & " AND cpnominal>0 GROUP BY  id_instrum , cod_familia, cpmonemi,cpnumdocu "
                SQL1 = Sql & cadena2 & Cadena & " AND cpnominal>0  AND car.cpnumdocu =* monumoper " _
                           & " AND mostatreg = ''  GROUP BY car.id_instrum , car.cod_familia, cpmonemi,cpnumdocu "
                    
                If Bac_Sql_Execute(SQL1) Then
                    
                    Do While Bac_SQL_Fetch(datos())
                        lstSeries.AddItem datos(1)
                        lstSeries.ItemData(lstSeries.NewIndex) = (datos(2))
                    Loop
                    Marco(6).Enabled = True
                    opt_sel_ser.Value = True
                End If
            End If
        End If
        
    End If
    
End Sub

Sub RemoverLista(ByVal Familia As Integer, Lista As ListBox)
Dim i As Integer
Dim iLargo As Integer
Dim iLargoFamilia As Integer
      
    iLargo = Lista.ListCount - 1

    For i = iLargo To 0 Step -1
      If Lista.ItemData(i) = Familia Then
         Lista.RemoveItem i
      End If
   Next i
   
End Sub


Private Sub lstMonedas_Click()

  Dim i As Integer
  
    If lstMonedas.Selected(lstMonedas.ListIndex) = False Then
        
            For i = lstSeries.ListCount - 1 To 0 Step -1
                If IsNumeric(Trim(Right(lstSeries.List(i), 5))) Then
                    If Trim(Right(lstSeries.List(i), 5)) = lstMonedas.ItemData(lstMonedas.ListIndex) Then
                           lstSeries.RemoveItem i
                        End If
                End If
                  
            Next i
    End If
    
    lstFamilias_Click
    
End Sub

Private Sub Opt_sel_emi_Click()
   Dim i As Integer
   For i% = 0 To lstEmisores.ListCount - 1
       lstEmisores.Selected(i%) = False
   Next i%
End Sub


Private Sub Opt_sel_fam_Click()
   Dim i As Integer
   For i% = 0 To lstFamilias.ListCount - 1
       lstFamilias.Selected(i%) = False
   Next i%
   lstSeries.Clear
End Sub


Private Sub Opt_sel_mon_Click()
   Dim i As Integer
   For i% = 0 To lstMonedas.ListCount - 1
       lstMonedas.Selected(i%) = False
   Next i%
End Sub


Private Sub opt_sel_ser_Click()
   Dim i As Integer
   For i% = 0 To lstSeries.ListCount - 1
       lstSeries.Selected(i%) = False
   Next i%
End Sub

Private Sub Opt_tod_emi_Click()
Dim i As Integer

For i% = 0 To lstEmisores.ListCount - 1
    lstEmisores.Selected(i%) = True
Next i%

End Sub

Private Sub Opt_tod_fam_Click()
Dim i As Integer

For i% = 0 To lstFamilias.ListCount - 1
    lstFamilias.Selected(i%) = True
Next i%

lstSeries.Clear

Marco(6).Enabled = False

End Sub

Private Sub Opt_tod_mon_Click()
Dim i As Integer

For i% = 0 To lstMonedas.ListCount - 1
    lstMonedas.Selected(i%) = True
Next i%

End Sub

Private Sub opt_tod_ser_Click()
   Dim i As Integer
   
'   For i% = 0 To lstSeries.ListCount - 1
'       lstSeries.Selected(i%) = True
'   Next i%

'        10


For i% = 0 To lstSeries.ListCount - 1
    lstSeries.Selected(i%) = True
Next i%

'lstSeries.Clear

'Marco(6).Enabled = False

   
   
'   If lstSeries.ListCount < 8 Then
'      For I% = lstSeries.TopIndex To lstSeries.ListCount - 1
'          lstSeries.Selected(I%) = True
'      Next I%
'   Else
'      For I% = lstSeries.TopIndex To lstSeries.TopIndex + 8
'          lstSeries.Selected(I%) = True
'      Next I%
'   End If
End Sub

Sub AceptarOperaciones()

Dim i%
Dim j%


j = 0
    If lstSeries.SelCount > 0 Then
          For i% = 0 To lstSeries.ListCount - 1
            If Trim(Mid(lstSeries.List(i), (Len(lstSeries.List(i)) - 25), 20)) > 0 Then
                If lstSeries.Selected(i%) = True Then
                      j = j + 1
                      ReDim Preserve OperacionesVenta(j)
                      OperacionesVenta(j) = Trim(Mid(lstSeries.List(i), (Len(lstSeries.List(i)) - 25), 20))
                End If
            End If
          Next i%
        
    
     Else
    
    End If
    
    j = 0
    ReDim Preserve MonedasOPVenta(2, j)
    If lstMonedas.SelCount > 0 Then
          For i% = 0 To lstMonedas.ListCount - 1
            If lstMonedas.Selected(i%) = True Then
                  j = j + 1
                  ReDim Preserve MonedasOPVenta(2, j)
                  MonedasOPVenta(1, j) = lstMonedas.ItemData(i)
                  MonedasOPVenta(2, j) = lstMonedas.List(i)
            End If
          Next i%
    End If
    
    
       Unload Me
       

End Sub
Private Sub Aceptar()
    
On Error GoTo BacErrHnd24

Dim i%, RutCart&
Dim SqlCad
    If ChkDatos() = False Then
        Exit Sub
    End If
    
    RutCart& = gsBac_RutC  ' CmbEntidad.ItemData(CmbEntidad.ListIndex)

    gSQLVar = ""
    
    If CmbTCart.ListIndex > -1 Then
        gSQLVar = CmbTCart.ItemData(CmbTCart.ListIndex)
        gs_Cart = CmbTCart.ItemData(CmbTCart.ListIndex)
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
    'gSQLEmi = ""
   ' If lstEmisores.SelCount > 0 Then
  '      For I% = 0 To lstEmisores.ListCount - 1
 '           If lstEmisores.Selected(I%) = True Then
'                gSQLEmi = gSQLEmi & "-" & lstEmisores.List(I%)'
            'End If
       ' Next I%
   ' Else
  '      For I% = 0 To lstEmisores.ListCount - 1
 '           gSQLEmi = gSQLEmi & "-" & lstEmisores.List(I%)
'        Next I%'
'    End If
    
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
    '   gSQLSer = Mid(gSQLSer, 1, Len(gSQLSer) - 1)
   End If
   If gSQLSer = "" Then
      gSQLSer = "VACIO"
 Else
'gSQLSer = Mid(gSQLSer, 1, 25) & ";"
End If
   
   giAceptar% = True
   
    envia = Array(RutCart&, _
            gSQLVar, _
            gSQLFam, _
            gSQLEmi, _
            gSQLMon, _
            gSQLSer, _
            Mid(cboCategSuper.List(cboCategSuper.ListIndex), 1, 1), gsBac_User)
            
'   RutCartV = CmbEntidad.ItemData(CmbEntidad.ListIndex)

   Unload Me
   Exit Sub

BacErrHnd24:
   MsgBox Error(err), vbExclamation, "MENSAJE"
   On Error GoTo 0
   Exit Sub
   
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
        txtRutCar.Text = gsrut$
        txtDigCar.Text = gsDigito$
        txtNomCar.Text = gsDescripcion$
        SendKeys "{TAB}"
    End If

End Sub


Private Sub txtRutCar_Change()

    txtNomCar.Text = ""
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
        Call AceptarOperaciones 'Aceptar
    Case "CANCELAR"
        Call Cancelar
End Select
End Sub

