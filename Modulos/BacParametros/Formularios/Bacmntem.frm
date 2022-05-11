VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacMntEm 
   Appearance      =   0  'Flat
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantención de Emisores"
   ClientHeight    =   6165
   ClientLeft      =   1425
   ClientTop       =   1545
   ClientWidth     =   6195
   ClipControls    =   0   'False
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
   Icon            =   "Bacmntem.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   MouseIcon       =   "Bacmntem.frx":030A
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   6165
   ScaleWidth      =   6195
   Begin VB.Frame Frame3 
      ForeColor       =   &H8000000D&
      Height          =   675
      Left            =   60
      TabIndex        =   30
      Top             =   5400
      Width           =   6075
      Begin VB.CommandButton BtnCodSVS 
         BackColor       =   &H8000000D&
         Caption         =   "Codigo SVS"
         Height          =   315
         Left            =   1980
         MaskColor       =   &H8000000D&
         TabIndex        =   31
         Top             =   240
         Width           =   1695
      End
   End
   Begin VB.Frame Frame2 
      Caption         =   "Clasificador de Riesgo 2"
      ForeColor       =   &H8000000D&
      Height          =   1575
      Left            =   30
      TabIndex        =   17
      Top             =   3750
      Width           =   6135
      Begin VB.ComboBox box_tipo_l2 
         Height          =   315
         Left            =   1290
         Style           =   2  'Dropdown List
         TabIndex        =   26
         Top             =   1140
         Width           =   2175
      End
      Begin VB.ComboBox box_tipo_c2 
         Height          =   315
         Left            =   1290
         Style           =   2  'Dropdown List
         TabIndex        =   25
         Top             =   720
         Width           =   2175
      End
      Begin VB.ComboBox box_Clas2 
         Height          =   315
         Left            =   1290
         Style           =   2  'Dropdown List
         TabIndex        =   24
         Top             =   300
         Width           =   3735
      End
      Begin VB.Label Label6 
         AutoSize        =   -1  'True
         Caption         =   "Largo Plazo"
         Height          =   195
         Left            =   150
         TabIndex        =   29
         Top             =   1170
         Width           =   1020
      End
      Begin VB.Label Label5 
         AutoSize        =   -1  'True
         Caption         =   "Corto Plazo"
         Height          =   195
         Left            =   150
         TabIndex        =   28
         Top             =   720
         Width           =   990
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "Clasificador"
         Height          =   195
         Left            =   150
         TabIndex        =   27
         Top             =   330
         Width           =   1005
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "Clasificador de Riesgo 1"
      ForeColor       =   &H8000000D&
      Height          =   1575
      Left            =   30
      TabIndex        =   16
      Top             =   2100
      Width           =   6135
      Begin VB.ComboBox box_tipo_l1 
         Height          =   315
         Left            =   1290
         Style           =   2  'Dropdown List
         TabIndex        =   23
         Top             =   1110
         Width           =   2175
      End
      Begin VB.ComboBox box_tipo_c1 
         Height          =   315
         Left            =   1305
         Style           =   2  'Dropdown List
         TabIndex        =   22
         Top             =   690
         Width           =   2175
      End
      Begin VB.ComboBox box_Clas1 
         Height          =   315
         Left            =   1290
         Style           =   2  'Dropdown List
         TabIndex        =   19
         Top             =   270
         Width           =   3735
      End
      Begin VB.Label Label4 
         AutoSize        =   -1  'True
         Caption         =   "Largo Plazo"
         Height          =   195
         Left            =   180
         TabIndex        =   21
         Top             =   1200
         Width           =   1020
      End
      Begin VB.Label Label3 
         AutoSize        =   -1  'True
         Caption         =   "Corto Plazo"
         Height          =   195
         Left            =   180
         TabIndex        =   20
         Top             =   750
         Width           =   990
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Clasificador"
         Height          =   195
         Left            =   180
         TabIndex        =   18
         Top             =   360
         Width           =   1005
      End
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   2715
      Top             =   -45
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
            Picture         =   "Bacmntem.frx":0614
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmntem.frx":0A66
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmntem.frx":0EB8
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmntem.frx":11D2
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   7
      Top             =   0
      Width           =   6195
      _ExtentX        =   10927
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
            Object.ToolTipText     =   "Eliminar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
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
      Height          =   1470
      Left            =   0
      TabIndex        =   8
      Top             =   555
      Width           =   6180
      _Version        =   65536
      _ExtentX        =   10901
      _ExtentY        =   2593
      _StockProps     =   15
      Caption         =   "SSPanel1"
      BackColor       =   -2147483644
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin Threed.SSFrame SSFrame1 
         Height          =   1395
         Left            =   45
         TabIndex        =   9
         Top             =   15
         Width           =   6075
         _Version        =   65536
         _ExtentX        =   10716
         _ExtentY        =   2461
         _StockProps     =   14
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Begin BACControles.TXTNumero FLTCODIGO 
            Height          =   315
            Left            =   5040
            TabIndex        =   15
            Top             =   960
            Visible         =   0   'False
            Width           =   735
            _ExtentX        =   1296
            _ExtentY        =   556
            ForeColor       =   -2147483635
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
            Text            =   "0"
            Text            =   "0"
            Separator       =   -1  'True
            MarcaTexto      =   -1  'True
         End
         Begin VB.TextBox txtGenerico 
            ForeColor       =   &H00800000&
            Height          =   315
            Left            =   105
            MaxLength       =   5
            TabIndex        =   4
            Top             =   960
            Width           =   825
         End
         Begin VB.ComboBox cmbTipoEmisor 
            ForeColor       =   &H00800000&
            Height          =   315
            Left            =   1350
            Style           =   2  'Dropdown List
            TabIndex        =   5
            Top             =   960
            Width           =   3615
         End
         Begin VB.TextBox txtDigito 
            ForeColor       =   &H00800000&
            Height          =   315
            Left            =   1365
            MaxLength       =   1
            TabIndex        =   2
            Top             =   375
            Width           =   225
         End
         Begin VB.TextBox txtNombre 
            ForeColor       =   &H00800000&
            Height          =   315
            Left            =   1695
            MaxLength       =   40
            TabIndex        =   3
            Top             =   375
            Width           =   4275
         End
         Begin VB.TextBox txtRut 
            ForeColor       =   &H00800000&
            Height          =   315
            Left            =   105
            MaxLength       =   9
            MouseIcon       =   "Bacmntem.frx":14EC
            MousePointer    =   99  'Custom
            TabIndex        =   1
            Top             =   375
            Width           =   1155
         End
         Begin VB.Label Label 
            Appearance      =   0  'Flat
            AutoSize        =   -1  'True
            BackColor       =   &H80000005&
            BackStyle       =   0  'Transparent
            Caption         =   "Genérico"
            ForeColor       =   &H00800000&
            Height          =   195
            Index           =   2
            Left            =   105
            TabIndex        =   6
            Top             =   735
            UseMnemonic     =   0   'False
            Width           =   780
         End
         Begin VB.Label Label 
            Appearance      =   0  'Flat
            AutoSize        =   -1  'True
            BackColor       =   &H80000005&
            BackStyle       =   0  'Transparent
            Caption         =   "Tipo"
            ForeColor       =   &H00800000&
            Height          =   195
            Index           =   5
            Left            =   1365
            TabIndex        =   14
            Top             =   735
            UseMnemonic     =   0   'False
            Width           =   390
         End
         Begin VB.Label Label 
            Appearance      =   0  'Flat
            AutoSize        =   -1  'True
            BackColor       =   &H80000005&
            BackStyle       =   0  'Transparent
            Caption         =   "Código"
            ForeColor       =   &H00800000&
            Height          =   195
            Index           =   7
            Left            =   5070
            TabIndex        =   13
            Top             =   750
            UseMnemonic     =   0   'False
            Visible         =   0   'False
            Width           =   585
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            Caption         =   "-"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   12
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   300
            Index           =   6
            Left            =   1260
            TabIndex        =   12
            Top             =   390
            Width           =   105
         End
         Begin VB.Label Label 
            Appearance      =   0  'Flat
            AutoSize        =   -1  'True
            BackColor       =   &H80000005&
            BackStyle       =   0  'Transparent
            Caption         =   "Nombre"
            ForeColor       =   &H00800000&
            Height          =   195
            Index           =   1
            Left            =   1710
            TabIndex        =   11
            Top             =   150
            Width           =   660
         End
         Begin VB.Label Label 
            Appearance      =   0  'Flat
            AutoSize        =   -1  'True
            BackColor       =   &H80000005&
            BackStyle       =   0  'Transparent
            Caption         =   "Rut"
            ForeColor       =   &H00800000&
            Height          =   195
            Index           =   0
            Left            =   105
            TabIndex        =   10
            Top             =   135
            Width           =   315
         End
      End
   End
   Begin VB.TextBox TxEtipo 
      Height          =   375
      Left            =   570
      TabIndex        =   0
      Top             =   5610
      Width           =   375
   End
End
Attribute VB_Name = "BacMntEm"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit

Dim datos()
Dim cSql        As String
Dim dEmcodigo   As Double
Dim cEmnombre   As String
Dim cEmgeneric  As String
Dim cEmdirecc   As String
Dim dEmcomuna   As Double
Dim dEmtipo     As Double

Function Valida_Datos()
    Valida_Datos = True
    If box_Clas1.ListIndex = -1 Then
        MsgBox "Ingrese Clasificador 1", vbExclamation, gsBac_Version
        Valida_Datos = False
        box_Clas1.SetFocus
        Exit Function
    ElseIf box_Clas2.ListIndex = -1 Then
        MsgBox "Ingrese Clasificador 2", vbExclamation, gsBac_Version
        Valida_Datos = False
        box_Clas2.SetFocus
        Exit Function
    ElseIf box_tipo_c1.ListIndex = -1 Then
        MsgBox "Ingrese Tipo de Clasificación", vbExclamation, gsBac_Version
        Valida_Datos = False
        box_tipo_c1.SetFocus
        Exit Function
    ElseIf box_tipo_l1.ListIndex = -1 Then
        MsgBox "Ingrese Tipo de Clasificación", vbExclamation, gsBac_Version
        Valida_Datos = False
        box_tipo_l1.SetFocus
        Exit Function
    ElseIf box_tipo_c2.ListIndex = -1 Then
        MsgBox "Ingrese Tipo de Clasificación", vbExclamation, gsBac_Version
        Valida_Datos = False
        box_tipo_c2.SetFocus
        Exit Function
    ElseIf box_tipo_l2.ListIndex = -1 Then
        MsgBox "Ingrese Tipo de Clasificación", vbExclamation, gsBac_Version
        Valida_Datos = False
        box_tipo_l2.SetFocus
        Exit Function
    End If
End Function
Function llena_combo_corto_pargo(Clas, cod)
    
    Dim datos()
    If cod = 1 Then
        box_tipo_c1.Clear
        box_tipo_l1.Clear
    Else
        box_tipo_c2.Clear
        box_tipo_l2.Clear
    End If
    Envia = Array()
    AddParam Envia, Clas
    If Bac_Sql_Execute("Svc_Emi_clf_rsg", Envia) Then
        Do While Bac_SQL_Fetch(datos)
            If cod = 1 Then
                box_tipo_c1.AddItem datos(1)
                box_tipo_l1.AddItem datos(1)
            Else
                box_tipo_c2.AddItem datos(1)
                box_tipo_l2.AddItem datos(1)
            End If
        Loop
    End If
End Function
Function buscar_emisor_riesgo(Rut, Dv, cod)
    Dim datos()
    Dim i As Integer
   
    Envia = Array()
    AddParam Envia, CDbl(Rut)
    AddParam Envia, Dv
    AddParam Envia, CDbl(cod)
    
    If Bac_Sql_Execute("Svc_Emi_bus_dat", Envia) Then
        Do While Bac_SQL_Fetch(datos)
            box_Clas1.ListIndex = -1
            For i = 0 To box_Clas1.ListCount - 1
                'box_Clas1.ListIndex = i
                If box_Clas1.List(i) = datos(1) Then
                    box_Clas1.ListIndex = i
                    'box_Clas1.Enabled = False
                    Exit For
                End If
            Next i

            For i = 0 To box_Clas2.ListCount - 1
                'box_Clas2.ListIndex = i
                If box_Clas2.List(i) = datos(2) Then
                    box_Clas2.ListIndex = i
                    'box_Clas2.Enabled = False
                    Exit For
                End If
                box_Clas2.ListIndex = -1
            Next i
            
            Call llena_combo_corto_pargo(box_Clas1.Text, 1)
            Call llena_combo_corto_pargo(box_Clas2.Text, 2)

            For i = 0 To box_tipo_c1.ListCount - 1
                'box_tipo_c1.ListIndex = i
                If box_tipo_c1.List(i) = datos(3) Then
                    box_tipo_c1.ListIndex = i
                    'box_tipo_c1.Enabled = False
                    Exit For
                End If
                box_tipo_c1.ListIndex = -1
            Next i

            For i = 0 To box_tipo_l1.ListCount - 1
                
                If box_tipo_l1.List(i) = datos(4) Then
                    'box_tipo_l1.Enabled = False
                    box_tipo_l1.ListIndex = i
                    Exit For
                End If
                box_tipo_l1.ListIndex = -1
            Next
            
            For i = 0 To box_tipo_c2.ListCount - 1
                If box_tipo_c2.List(i) = datos(5) Then
                    box_tipo_c2.ListIndex = i
                    'box_tipo_c2.Enabled = False
                    Exit For
                End If
                box_tipo_c2.ListIndex = -1
            Next

            For i = 0 To box_tipo_l2.ListCount - 1
                If box_tipo_l2.List(i) = datos(6) Then
                    box_tipo_l2.ListIndex = i
                    'box_tipo_l2.Enabled = False
                    Exit For
                End If
                box_tipo_l2.ListIndex = -1
            Next
        Loop
    End If
    box_Clas1.Enabled = True
    box_Clas2.Enabled = True
    box_tipo_c1.Enabled = True
    box_tipo_l1.Enabled = True
    box_tipo_c2.Enabled = True
    box_tipo_l2.Enabled = True

End Function

Function llena_combo_clasificador()
    Dim datos()
    box_Clas1.Clear
    box_Clas2.Clear
    If Bac_Sql_Execute("Svc_Emi_cod_rsg") Then
        Do While Bac_SQL_Fetch(datos)
                box_Clas1.AddItem datos(1)
                box_Clas2.AddItem datos(1)
        Loop
    End If
    
End Function
Function EliminarEmisor(xRut As Double) As Boolean
On Error GoTo ErrEliminar

    EliminarEmisor = False
    
  ' ====================================================
    
    
    'cSql = "EXECUTE sp_elimina_emisor " & xRut
    
    Envia = Array()
    
    AddParam Envia, CDbl(xRut)
    
    If Bac_Sql_Execute("sp_elimina_emisor", Envia) Then
        
        Do While Bac_SQL_Fetch(datos())
            
            If datos(1) = "NO" Then
                
                Call Grabar_Log("BTR", gsBAC_User, gsbac_fecp, "Problemas al eliminar emisor")
                MsgBox "Problemas en eliminación de emisor ", vbCritical, TITSISTEMA
                Exit Function
            
            End If
        
        Loop
    
    End If
      Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                                    , gsbac_fecp _
                                    , gsBac_IP _
                                    , gsBAC_User _
                                    , "PCA" _
                                    , "OPC_611 " _
                                    , "03" _
                                    , "Eliminación " _
                                    , "Emisor" _
                                    , " " _
                                    , "Eliminación de emisor " & " " & txtNombre.Text & " " & cmbTipoEmisor.Text)
  '  Call Grabar_Log("BTR", gsBAC_User, gsbac_fecp, "Eliminación de emisor " & txtNombre.Text & ", realizado satisfactoriamente.")
    
    EliminarEmisor = True
    Exit Function

ErrEliminar:
    Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                                    , gsbac_fecp _
                                    , gsBac_IP _
                                    , gsBAC_User _
                                    , "PCA" _
                                    , "OPC_611 " _
                                    , "03" _
                                    , "Eliminación de emisor ha fallado" _
                                    , "Emisor" _
                                    , " " _
                                    , " " & txtNombre.Text & " " & cmbTipoEmisor.Text)
    'Call Grabar_Log("BTR", gsBAC_User, gsbac_fecp, "Eliminación de emisor ha fallado")
    MsgBox "Problemas  en elimnación de emisor: " & Err.Description, vbCritical, TITSISTEMA
    Exit Function
End Function

Function EmisorLeerPorRut(parEdRut As Double) As Boolean

    EmisorLeerPorRut = False
    
'    cSql = "EXECUTE sp_trae_emisor " & parEdRut
    
    Envia = Array()
    
    AddParam Envia, parEdRut
    

    If Not Bac_Sql_Execute("sp_trae_emisor", Envia) Then Exit Function
    
    If Not Bac_SQL_Fetch(datos()) Then Exit Function
    
    dEmcodigo = Val(datos(1))
    cEmnombre = datos(4)
    cEmgeneric = datos(5)
    dEmtipo = Val(datos(8))
    
    EmisorLeerPorRut = True
    
End Function


Function GrabarEmisor() As Boolean
Dim gsbac_fecp As Date
On Error GoTo ErrGrabar


    Screen.MousePointer = vbHourglass
    
    GrabarEmisor = False

    Envia = Array()
    
    AddParam Envia, CDbl(txtRut.Text)
    AddParam Envia, txtDigito.Text
    AddParam Envia, txtNombre
    AddParam Envia, txtGenerico.Text
    AddParam Envia, ""
    AddParam Envia, 0
    AddParam Envia, Trim(Right(cmbTipoEmisor.Text, 5))
    AddParam Envia, CDbl(FLTCODIGO.Text)
    AddParam Envia, box_Clas1.Text
    AddParam Envia, box_Clas2.Text
    AddParam Envia, box_tipo_c1.Text
    AddParam Envia, box_tipo_l1.Text
    AddParam Envia, box_tipo_c2.Text
    AddParam Envia, box_tipo_l2.Text
        
    If Bac_Sql_Execute("Sp_Graba_Emisor ", Envia) Then
        
        Do While Bac_SQL_Fetch(datos())
            
            If datos(1) = "NO" Then
                
                Screen.MousePointer = vbDefault
                Exit Function
            
            End If
        
        Loop
    
    End If
    Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                                    , gsbac_fecp _
                                    , gsBac_IP _
                                    , gsBAC_User _
                                    , "PCA" _
                                    , "OPC_611 " _
                                    , "01" _
                                    , "Operación de grabación" _
                                    , "Emisor" _
                                    , " " _
                                    , "Operación de grabación de emisores" & " " & txtNombre.Text & " " & cmbTipoEmisor.Text)
   ' Call Grabar_Log("BTR", gsBAC_User, gsbac_fecp, "Operación de grabación de emisores realizada satisfactoriamente.")
    

    GrabarEmisor = True
    MsgBox "Grabación de emisor realizado correctamente.", vbInformation, TITSISTEMA
    
    Screen.MousePointer = vbDefault
    Exit Function

ErrGrabar:
    Screen.MousePointer = vbDefault

    MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical, TITSISTEMA
    Exit Function
End Function

Private Sub LimpiaControles()

    txtRut.Enabled = True
    txtDigito.Enabled = True
    txtRut.Text = ""
    txtDigito.Text = ""
    txtNombre.Text = ""
    txtGenerico.Text = ""
    FLTCODIGO.Text = 1
    TxEtipo.Text = ""
    cmbTipoEmisor.ListIndex = -1
    
    box_tipo_c1.ListIndex = -1
    box_tipo_l1.ListIndex = -1
    box_tipo_c2.ListIndex = -1
    box_tipo_l2.ListIndex = -1
    
    box_Clas1.ListIndex = -1
    box_Clas2.ListIndex = -1
    box_Clas1.Enabled = False
    box_Clas2.Enabled = False
    
End Sub


Private Function ValidaDatos() As Boolean

    ValidaDatos = False
    
    'If Val(FLTCODIGO.Text) = 0 Then
    '    MsgBox "El código del emisor está vacio", vbExclamation, TITSISTEMA
    '    Exit Function
    'End If
    
    If Trim(txtNombre.Text) = "" Then
        MsgBox "El nombre del emisor está vacio ", vbExclamation, TITSISTEMA
        Exit Function
    End If
    
    If Trim(txtGenerico.Text) = "" Then
        MsgBox "El nombre genérico del emisor está vacio", vbExclamation, TITSISTEMA
        Exit Function
    End If
    
    If Trim(cmbTipoEmisor.Text) = "" Then
        MsgBox "Emisor debe tener asociado un tipo", vbExclamation, TITSISTEMA
        Exit Function
    End If
    
    ValidaDatos = True

End Function





Private Sub box_Clas1_Click()
  Call llena_combo_corto_pargo(box_Clas1.Text, 1)
End Sub


Private Sub box_Clas2_Click()
  Call llena_combo_corto_pargo(box_Clas2.Text, 2)
End Sub


Private Sub cmbTipoEmisor_Change()
FLTCODIGO.SetFocus
End Sub

Private Sub cmbTipoEmisor_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = 13 Then
'    FLTCODIGO.SetFocus
txtGenerico.SetFocus
End If
End Sub

Private Sub cmdEliminar_Click()
On Error GoTo Label1


    If MsgBox("¿ Esta seguro de eliminar emisor ?", vbYesNo, TITSISTEMA) = vbYes Then
       
        Screen.MousePointer = vbHourglass
        If EliminarEmisor(txtRut.Text) Then
            MsgBox "El emisor ha sido eliminado", vbOKOnly + vbInformation, TITSISTEMA
            Call LimpiarEm
        Else
            MsgBox "No se pudo eliminar el emisor", vbCritical, TITSISTEMA
        End If
        Screen.MousePointer = vbDefault
        
    End If

    Exit Sub

Label1:
    Screen.MousePointer = vbDefault
    MsgBox "No se pudo realizar eliminación de emisor: " & Err.Description, vbCritical, TITSISTEMA
    Exit Sub
End Sub

Private Sub cmdGrabar_Click()
Dim IdNum   As Long
Dim datos()

On Error GoTo Label1

    If Not ValidaDatos Then
        Exit Sub
    End If
    
    Screen.MousePointer = vbHourglass
    If GrabarEmisor Then
        Call LimpiarEm
    Else
        MsgBox "No se pudo completar la granbación", vbOKOnly + vbExclamation, TITSISTEMA
    End If
    Screen.MousePointer = vbDefault

      
Exit Sub

Label1:
   Screen.MousePointer = 0
   MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical, TITSISTEMA
   Exit Sub
End Sub

Private Sub LimpiarEm()

    Screen.MousePointer = 0
    
    Call LimpiaControles
    
    Toolbar1.Buttons(1).Enabled = False
    Toolbar1.Buttons(2).Enabled = False
    txtRut.SetFocus

End Sub


Private Sub cmdlimpiar_Click()
Call LimpiarEm
End Sub

Private Sub cmdSalir_Click()
        Unload Me
End Sub

Private Sub data1_Error(DataErr As Integer, Response As Integer)
 MsgBox DataErr, vbCritical, TITSISTEMA
End Sub

Private Sub BtnCodSVS_Click()
      ''REQ.6010
      Call BacMntSVS.Show(vbModal)
End Sub

Private Sub Form_Load()
    Me.Top = 0
    Me.Left = 0

Call LimpiaControles

Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                          , gsbac_fecp _
                          , gsBac_IP _
                          , gsBAC_User _
                          , "PCA" _
                          , "OPC_661" _
                          , "07" _
                          , "INGRESO A OPCION MENU" _
                          , " " _
                          , " " _
                          , " ")
                          
On Error GoTo Label1
'Dim gsbac_fecp As Date 'declaracion nula

    If Not Llenar_Combos(cmbTipoEmisor, 210) Then
        MsgBox "No existen tipos de emisor definidos", vbExclamation, TITSISTEMA
        Exit Sub
    End If
   Toolbar1.Buttons(1).Enabled = False
   Toolbar1.Buttons(2).Enabled = False
    
    ''REQ.6010
    BtnCodSVS.Enabled = False
    
    txtRut.Enabled = True
    txtDigito.Enabled = True
    
    Call Grabar_Log("BRT", gsBAC_User, gsbac_fecp, "Inicio de mantenedor de emisores")
    Call llena_combo_clasificador
    
    Exit Sub

Label1:
    
    MsgBox "Problemas en enlace de tablas de emisores: " & Err.Description, vbCritical, TITSISTEMA
    Unload Me
    Exit Sub
    
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Index
   Case 1
         Dim IdNum   As Long
Dim datos()

On Error GoTo Label1

    If Not ValidaDatos Then
        Exit Sub
    End If
    
    Screen.MousePointer = vbHourglass
    If GrabarEmisor Then
        Call LimpiarEm
    Else
        MsgBox "No se pudo completar la granbación", vbOKOnly + vbExclamation, TITSISTEMA
    End If
    Screen.MousePointer = vbDefault

      
Exit Sub

Label1:
   Screen.MousePointer = 0
   MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical, TITSISTEMA
   Exit Sub
   
   Case 2
         On Error GoTo Label11


    If MsgBox("Esta seguro de eliminar emisor :" & Chr(13) & txtNombre.Text, vbYesNo, TITSISTEMA) = vbYes Then
       
        Screen.MousePointer = vbHourglass
        If EliminarEmisor(txtRut.Text) Then
            MsgBox "El emisor ha sido eliminado", vbOKOnly + vbInformation, TITSISTEMA
            Call LimpiarEm
        Else
            MsgBox "No se pudo eliminar el emisor", vbCritical, TITSISTEMA
        End If
        Screen.MousePointer = vbDefault
        
    End If

    Exit Sub

Label11:
    Screen.MousePointer = vbDefault
    MsgBox "No se pudo realizar eliminación de emisor: " & Err.Description, vbCritical, TITSISTEMA
    Exit Sub
   Case 3
         Call LimpiarEm
   Case 4
   Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                                    , gsbac_fecp _
                                    , gsBac_IP _
                                    , gsBAC_User _
                                    , "PCA" _
                                    , "OPC_611 " _
                                    , "08" _
                                    , "Salir Opcion De Menu" _
                                    , " " _
                                    , " " _
                                    , " ")
         Unload Me
End Select
End Sub

Private Sub txtDigito_KeyPress(KeyAscii As Integer)


'    BacCaracterNumerico KeyAscii
    
    If KeyAscii = 13 Then txtNombre.SetFocus
    
    If (Asc(KeyAscii) < 48 Or Asc(KeyAscii) > 57) Then
        If UCase(Chr$(KeyAscii)) <> 107 Then
            KeyAscii = 0
            txtNombre.SetFocus
        Else
            KeyAscii = UCase(Chr$(KeyAscii))
        End If
    End If
    

    
End Sub

Private Sub txtDigito_LostFocus()
Dim idRut    As Long
Dim iddigito As String

On Error GoTo Label1


    If Trim$(txtRut.Text) = "" Or Trim$(txtDigito.Text) = "" Then
       Call LimpiarEm
       If txtRut.Enabled = True Then
          txtRut.SetFocus
       End If
       Exit Sub
    End If
    
    If Trim$(txtRut.Text) = "0" And Trim$(txtDigito.Text) = "0" Then
       Call LimpiarEm
       If txtRut.Enabled = True Then
          txtRut.SetFocus
       End If

       Exit Sub
    End If
    
   
    If BacValidaRut(CStr(txtRut.Text), CStr(txtDigito.Text)) = False Then
        MsgBox "El rut ingresado no es válido", vbExclamation, TITSISTEMA
        txtDigito.Text = ""
        txtDigito.SetFocus
        Exit Sub
    End If

    txtRut.Enabled = False
    txtDigito.Enabled = False
    Toolbar1.Buttons(1).Enabled = True
    
    If EmisorLeerPorRut(txtRut.Text) = True Then
        FLTCODIGO.Text = dEmcodigo
        txtNombre.Text = cEmnombre
        txtGenerico.Text = cEmgeneric
        cmbTipoEmisor.ListIndex = BuscaEnCombo(cmbTipoEmisor, Str(dEmtipo), "C")
        Toolbar1.Buttons(2).Enabled = True
    Else
        Exit Sub
    End If
    
    txtNombre.SetFocus
Exit Sub

Label1:
    MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical, TITSISTEMA
 
 Exit Sub

End Sub





Private Sub txtGenerico_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = 13 Then
    cmbTipoEmisor.SetFocus
End If
End Sub

Private Sub txtGenerico_KeyPress(KeyAscii As Integer)

    BacToUCase KeyAscii
    
End Sub


Private Sub TxtNombre_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = 13 Then
    txtGenerico.SetFocus
End If
End Sub

Private Sub txtNombre_KeyPress(KeyAscii As Integer)

    BacToUCase KeyAscii
    
End Sub


Private Sub txtRut_DblClick()
Dim Rut     As String
'On Error GoTo Label1

    Call LimpiarEm
    
    BacAyuda.Tag = "EMISOR"
    BacAyuda.Show 1
    
    If giAceptar% = True Then
        Call LimpiaControles
        txtRut.Text = gsCodigo$  'Mid(gsrut$, 44, 11)
        txtDigito.Text = gsDigito$ 'Trim(Mid(gsrut$, 56, 1))
        txtNombre = gsDescripcion$  'Trim(Mid(gsrut$, 1, Len(gsrut) - 11))
        FLTCODIGO.Text = gsCodCli 'Trim(Mid(gsrut$, 57))
    
        Call buscar_emisor_riesgo(txtRut.Text, txtDigito.Text, FLTCODIGO.Text)
        Call txtDigito_LostFocus
        
        ''REQ.6010
        BtnCodSVS.Enabled = True
        SendKeys "{ENTER}"
    End If

Exit Sub

Label1:
  MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical, TITSISTEMA
  Exit Sub
End Sub

Private Sub txtRut_KeyDown(KeyCode As Integer, Shift As Integer)
On Error GoTo Label1
   If KeyCode = vbKeyF3 Then
      Call LimpiarEm
      BacAyuda.Tag = "MDEM"
      BacAyuda.Show 1
      If giAceptar% = True Then
         Call LimpiaControles
         txtRut.Text = gsCodigo$
         txtDigito.Text = gsDigito$
         txtDigito.SetFocus
         SendKeys "{ENTER}"
      End If
      Exit Sub
Label1:
      MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical, TITSISTEMA
      Exit Sub
End If
End Sub

Private Sub txtRut_KeyPress(KeyAscii As Integer)

    If Not IsNumeric(Chr(KeyAscii)) And KeyAscii <> 8 And KeyAscii <> 13 Then
       KeyAscii = 0
    End If

    BacCaracterNumerico KeyAscii
    
    If KeyAscii = 13 Then
      txtDigito.SetFocus
    End If
    
End Sub


