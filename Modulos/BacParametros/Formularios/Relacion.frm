VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Begin VB.Form bacMntPlanillaOperacion 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Relaciones Códigos de Comercio  para Operaciones"
   ClientHeight    =   3015
   ClientLeft      =   390
   ClientTop       =   375
   ClientWidth     =   5280
   FillStyle       =   0  'Solid
   Icon            =   "Relacion.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   3015
   ScaleWidth      =   5280
   ShowInTaskbar   =   0   'False
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   4950
      Top             =   0
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
            Picture         =   "Relacion.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Relacion.frx":075C
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Relacion.frx":0A76
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Relacion.frx":0BD0
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   13
      Top             =   0
      Width           =   5280
      _ExtentX        =   9313
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Refresh"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   4
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin Threed.SSPanel SSPanel1 
      Height          =   2460
      Left            =   0
      TabIndex        =   0
      Top             =   540
      Width           =   5280
      _Version        =   65536
      _ExtentX        =   9313
      _ExtentY        =   4339
      _StockProps     =   15
      BackColor       =   -2147483644
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin Threed.SSFrame fraRelacion 
         Height          =   2385
         Left            =   75
         TabIndex        =   7
         Top             =   15
         Width           =   5130
         _Version        =   65536
         _ExtentX        =   9049
         _ExtentY        =   4207
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
         ShadowStyle     =   1
         Begin VB.ComboBox cmbCodigoOMA 
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
            Height          =   315
            Left            =   1800
            Sorted          =   -1  'True
            Style           =   2  'Dropdown List
            TabIndex        =   3
            Top             =   1150
            Width           =   3255
         End
         Begin VB.TextBox txtComercio 
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
            Height          =   360
            Left            =   1800
            MouseIcon       =   "Relacion.frx":0EEA
            MousePointer    =   99  'Custom
            TabIndex        =   4
            Text            =   "000000"
            Top             =   1550
            Width           =   795
         End
         Begin VB.TextBox txtConcepto 
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
            Height          =   360
            Left            =   6195
            TabIndex        =   5
            Text            =   "000000"
            Top             =   1550
            Width           =   885
         End
         Begin VB.TextBox txtGlosa 
            BackColor       =   &H80000004&
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
            Height          =   300
            Left            =   120
            Locked          =   -1  'True
            TabIndex        =   6
            TabStop         =   0   'False
            Top             =   2000
            Width           =   4935
         End
         Begin VB.ComboBox cmbOperacion 
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
            Height          =   315
            Left            =   1800
            Sorted          =   -1  'True
            Style           =   2  'Dropdown List
            TabIndex        =   1
            Top             =   240
            Width           =   3255
         End
         Begin VB.ComboBox cmbProducto 
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
            Height          =   315
            Left            =   1785
            Sorted          =   -1  'True
            Style           =   2  'Dropdown List
            TabIndex        =   2
            Top             =   705
            Width           =   3255
         End
         Begin VB.Label lblRelacion 
            Caption         =   "Tipo de Operación"
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
            Height          =   255
            Index           =   0
            Left            =   90
            TabIndex        =   12
            Top             =   285
            Width           =   1650
         End
         Begin VB.Label lblRelacion 
            Caption         =   "Código OMA"
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
            Height          =   255
            Index           =   2
            Left            =   90
            TabIndex        =   11
            Top             =   1200
            Width           =   1650
         End
         Begin VB.Label lblRelacion 
            Caption         =   "Código de Comercio"
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
            Height          =   375
            Index           =   3
            Left            =   90
            TabIndex        =   10
            Top             =   1560
            Width           =   1710
         End
         Begin VB.Label lblRelacion 
            Caption         =   "Concepto"
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
            Height          =   255
            Index           =   4
            Left            =   5160
            TabIndex        =   9
            Top             =   1545
            Width           =   945
         End
         Begin VB.Label lblRelacion 
            Caption         =   "Tipo Cliente / Producto"
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
            Height          =   510
            Index           =   5
            Left            =   90
            TabIndex        =   8
            Top             =   660
            Width           =   1650
         End
      End
   End
End
Attribute VB_Name = "bacMntPlanillaOperacion"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private I&
Private xLine$
Private xStr$
Private datos()

Private Sub Refresh_PlanillaOperacion()

    If Len(Trim(cmbOperacion.Tag)) <= 0 Or Len(Trim(cmbProducto.Tag)) <= 0 Then
        Exit Sub
    End If
    
    '---- Captura Comercio y Concepto
    Envia = Array()
    AddParam Envia, cmbOperacion.Tag & cmbProducto.Tag
    
    If Bac_Sql_Execute("SP_PLANILLA_OPERACION", Envia) Then
    
        txtComercio.Text = ""
        txtConcepto.Text = ""
        txtGlosa.Text = ""
        
        If Bac_SQL_Fetch(datos()) Then
            txtComercio.Text = datos(1)
            txtConcepto.Text = datos(2)
            txtGlosa.Text = datos(3)
            bacBuscarCombo cmbOperacion, CDbl(datos(4))
            bacBuscarCombo cmbCodigoOMA, CDbl(datos(5))
            
        End If
        
    End If
    
End Sub

Private Sub cmbCodigoOMA_Click()
         cmbCodigoOMA_LostFocus
         
End Sub
'
'Private Sub cmbCodigoOMA_Change()
'
'    txtComercio.Text = ""
'    txtConcepto.Text = ""
'    txtGlosa.Text = ""
'
'End Sub

Private Sub cmbCodigoOMA_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then
        txtComercio.SetFocus
    End If
    
End Sub

Private Sub cmbCodigoOMA_LostFocus()

    If cmbCodigoOMA.ListIndex >= 0 Then
        cmbCodigoOMA.Tag = cmbCodigoOMA.ItemData(cmbCodigoOMA.ListIndex)
    Else
        cmbCodigoOMA.Tag = ""
    End If
    
  
    
End Sub

Private Sub cmbOperacion_Click()
        cmbOperacion_LostFocus
'    If cmbOperacion.ListIndex >= 0 Then
'        cmbOperacion.Tag = cmbOperacion.ItemData(cmbOperacion.ListIndex)
'        cmbOperacion.Tag = IIf(cmbOperacion.Tag = "1", "C", "V")
'        Carga_Listas Left(cmbOperacion, 1) & "OPERACIONESxDOCUMENTO", cmbCodigoOMA
'    Else
'        cmbOperacion.Tag = ""
'        Carga_Listas "OPERACIONESxDOCUMENTO", cmbCodigoOMA
'    End If
'
'
'    cmbCodigoOMA_LostFocus
    
End Sub

Private Sub cmbOperacion_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then
        cmbProducto.SetFocus
    
    End If
    
End Sub

Private Sub cmbOperacion_LostFocus()

    If cmbOperacion.ListIndex >= 0 Then
        cmbOperacion.Tag = cmbOperacion.ItemData(cmbOperacion.ListIndex)
        cmbOperacion.Tag = IIf(cmbOperacion.Tag = "1", "C", "V")
        If Left(cmbOperacion, 1) < 3 Then
           Carga_Listas "1OPERACIONESxDOCUMENTO", cmbCodigoOMA
        Else
           Carga_Listas Left(cmbOperacion, 1) & "OPERACIONESxDOCUMENTO", cmbCodigoOMA
        End If
    Else
        cmbOperacion.Tag = ""
        Carga_Listas "OPERACIONESxDOCUMENTO", cmbCodigoOMA
    End If
    
    Refresh_PlanillaOperacion
    cmbCodigoOMA_LostFocus
    
End Sub

Private Sub cmbProducto_Click()

    If cmbProducto.ListIndex >= 0 Then
        cmbProducto.Tag = Trim(Left(cmbProducto.List(cmbProducto.ListIndex), 3))
        
        If cmbProducto.ListIndex >= 11 Then
            cmbProducto.Tag = "USD" & cmbProducto.Tag
        Else
            cmbProducto.Tag = "CLP" & cmbProducto.Tag
        End If
        
    Else
        cmbProducto.Tag = ""
    End If
    
    Call Refresh_PlanillaOperacion
    
End Sub

Private Sub cmbProducto_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then
        cmbCodigoOMA.SetFocus
    End If
    
End Sub

Private Sub cmbProducto_LostFocus()

    If cmbProducto.ListIndex >= 0 Then
        cmbProducto.Tag = Trim(Left(cmbProducto.List(cmbProducto.ListIndex), 3))
        
        If cmbProducto.ListIndex >= 11 Then
            cmbProducto.Tag = "USD" & cmbProducto.Tag
        Else
            cmbProducto.Tag = "CLP" & cmbProducto.Tag
        End If
        
    Else
        cmbProducto.Tag = ""
    End If
    
    Call Refresh_PlanillaOperacion
    
End Sub

Private Sub cmdlimpiar_Click()

    '---- Tipos de Documento (C/V)
    cmbOperacion.Clear
    cmbOperacion.AddItem "1 - Compras": cmbOperacion.ItemData(cmbOperacion.NewIndex) = 1
    cmbOperacion.AddItem "2 - Ventas": cmbOperacion.ItemData(cmbOperacion.NewIndex) = 2
    bacBuscarCombo cmbOperacion, 1
    cmbOperacion_LostFocus
    
    '---- Tipos de Producto
    cmbProducto.Clear
    cmbProducto.AddItem "1   Banco Nacional                       ": cmbProducto.ItemData(cmbProducto.NewIndex) = 1
    cmbProducto.AddItem "2   Banco Extranjero                     ": cmbProducto.ItemData(cmbProducto.NewIndex) = 2
    cmbProducto.AddItem "3   Instituciones Financieros            ": cmbProducto.ItemData(cmbProducto.NewIndex) = 3
    cmbProducto.AddItem "4   Corredores de Bolsa                  ": cmbProducto.ItemData(cmbProducto.NewIndex) = 4
    cmbProducto.AddItem "5   Instituciones de Inversiones         ": cmbProducto.ItemData(cmbProducto.NewIndex) = 5
    cmbProducto.AddItem "6   Administradoras de Fondos de Pensión ": cmbProducto.ItemData(cmbProducto.NewIndex) = 6
    cmbProducto.AddItem "7   Empresas                             ": cmbProducto.ItemData(cmbProducto.NewIndex) = 7
    cmbProducto.AddItem "8   Personas Naturales                   ": cmbProducto.ItemData(cmbProducto.NewIndex) = 8
    cmbProducto.AddItem "9   Otros                                ": cmbProducto.ItemData(cmbProducto.NewIndex) = 9
    cmbProducto.AddItem "S   Sucursales                           ": cmbProducto.ItemData(cmbProducto.NewIndex) = 10
    cmbProducto.AddItem "A   Arbitrajes                           ": cmbProducto.ItemData(cmbProducto.NewIndex) = 11
    cmbProducto.AddItem "C   Banco Central                        ": cmbProducto.ItemData(cmbProducto.NewIndex) = 12
    cmbProducto.AddItem "FE  Forward/Swaps Empresas               ": cmbProducto.ItemData(cmbProducto.NewIndex) = 13
    cmbProducto.AddItem "FB  Forward/Swaps  Bancos                ": cmbProducto.ItemData(cmbProducto.NewIndex) = 14
    cmbProducto.AddItem "FAE Forward/Swaps Empresas  Arbitrajes   ": cmbProducto.ItemData(cmbProducto.NewIndex) = 15
    cmbProducto.AddItem "FAB Forward/Swaps  Bancos Arbitrajes     ": cmbProducto.ItemData(cmbProducto.NewIndex) = 16
    bacBuscarCombo cmbProducto, 1
    cmbProducto_LostFocus
    
    '---- Codigos OMA
    Carga_Listas Left(cmbOperacion, 1) & "OPERACIONESxDOCUMENTO", cmbCodigoOMA
    
    '---- Codigos de Comercio y Concepto
    txtComercio.Text = ""
    txtConcepto.Text = ""
    txtGlosa.Text = ""
    
    Call Refresh_PlanillaOperacion
    
End Sub
Private Sub Form_Load()
    Me.Top = 0
    Me.Left = 0
    Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                          , gsbac_fecp _
                          , gsBac_IP _
                          , gsBAC_User _
                          , "PCA" _
                          , "OPC_653" _
                          , "07" _
                          , "Ingreso a Opción Códigos Planillas Automáticas " _
                          , " " _
                          , " " _
                          , " ")
    
    
    WindowState = 0
    Top = 1
    Left = 15

    cmdlimpiar_Click

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Dim varaux2 As String

Select Case Button.Index

   Case 1
        Dim cFalta$
        
        cFalta = ""
        If cmbOperacion.ListIndex < 0 Then
            cFalta = cFalta & "- Tipo de Operación" & vbCrLf
        End If
        
        If cmbProducto.ListIndex < 0 Then
            cFalta = cFalta & "- Tipo de Cliente o Producto" & vbCrLf
        End If
            
        If cmbCodigoOMA.ListIndex < 0 Then
            cFalta = cFalta & "- Código OMA" & vbCrLf
        End If
        
        If Len(Trim(txtGlosa.Text)) = 0 Then
            cFalta = cFalta & "- Codigo de Comercio y Concepto, no definidos" & vbCrLf
        Else
            If Len(Trim(txtComercio.Text)) = 0 Then
                cFalta = cFalta & "- Código de Comercio" & vbCrLf
            End If
            If Len(Trim(txtConcepto.Text)) = 0 Then
                cFalta = cFalta & "- Concepto " & vbCrLf
            End If
        End If
        
        '---- ERROR
        If Len(cFalta) > 0 Then
            cFalta = "Falta la siguiente información..." & vbCrLf & vbCrLf & cFalta
            MsgBox cFalta, vbInformation, TITSISTEMA
            Exit Sub
        End If
        
        '---- Graba
        varaux2 = cmbOperacion.Tag & cmbProducto.Tag
        Envia = Array()
        AddParam Envia, cmbOperacion.ItemData(cmbOperacion.ListIndex)
        AddParam Envia, cmbCodigoOMA.Tag
        AddParam Envia, txtComercio.Text
        AddParam Envia, txtConcepto.Text
        AddParam Envia, varaux2
        
        If Not Bac_Sql_Execute("SP_GRABA_PLANILLAOPERACION ", Envia) Then
            MsgBox "Error En Sql", vbCritical, TITSISTEMA
            Exit Sub
        End If
        
        Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                                        , gsbac_fecp _
                                        , gsBac_IP _
                                        , gsBAC_User _
                                        , "PCA" _
                                        , "OPC_653 " _
                                        , "01" _
                                        , "Grabar,Relaciones Cod De Concepto " _
                                        , "CODIGO_PLANILLA_AUTOMATICA" _
                                        , " " _
                                        , "Grabar,Relaciones Cod De Concepto " & Trim(cmbOperacion.Text) & " " & Trim(cmbCodigoOMA.Text))
                                        
        MsgBox "Información Grabada", vbInformation, TITSISTEMA
        cmdlimpiar_Click
        cmbProducto.SetFocus
        
Case 2
           '---- Tipos de Documento (C/V)
        cmdlimpiar_Click
            
Case 3
        Call Refresh_PlanillaOperacion
       
Case 4
        Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                                , gsbac_fecp _
                                , gsBac_IP _
                                , gsBAC_User _
                                , "PCA" _
                                , "OPC_653 " _
                                , "08" _
                                , "Salir de Opción Códigos Planillas Automáticas" _
                                , " " _
                                , " " _
                                , " ")
        Unload Me
End Select
    
End Sub

Private Sub txtComercio_DblClick()

    BacControlWindows 100
    BacAyuda.Tag = "tbCodigosComercio" & cmbOperacion.ItemData(cmbOperacion.ListIndex) & cmbCodigoOMA.Tag
    BacAyuda.Show 1
    
    If giAceptar = True Then
        txtComercio.Text = gsCodigo
        txtConcepto.Text = gsDigito
        txtGlosa.Text = gsGlosa
    End If

End Sub

Private Sub txtComercio_KeyPress(KeyAscii As Integer)

0                                If KeyAscii = 13 Then
        txtConcepto.SetFocus
    ElseIf KeyAscii = 8 Then
    '---- Elimina Caracter
    ElseIf InStr("0123456789Kk", Chr(KeyAscii)) > 0 Then
        KeyAscii = Asc(UCase(Chr(KeyAscii)))
    Else
        KeyAscii = 0
    End If
    
End Sub

Private Sub txtConcepto_KeyPress(KeyAscii As Integer)
'
'    If KeyAscii = 13 Then
'        cmbOperacion.SetFocus
'    ElseIf KeyAscii = 8 Then
'    '---- Elimina Caracter
'    ElseIf InStr("0123456789Kk", Chr(KeyAscii)) > 0 Then
'        KeyAscii = Asc(UCase(Chr(KeyAscii)))
'    Else
'        KeyAscii = 0
'    End If
'
End Sub
