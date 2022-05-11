VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form Bac_inst_finan 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Instituciones Financieras"
   ClientHeight    =   5685
   ClientLeft      =   2550
   ClientTop       =   2940
   ClientWidth     =   9915
   Icon            =   "frm_inst_finan.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   5685
   ScaleWidth      =   9915
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   45
      Top             =   0
      Width           =   9915
      _ExtentX        =   17489
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
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Eliminar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   1
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   3960
         Top             =   0
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
               Picture         =   "frm_inst_finan.frx":030A
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frm_inst_finan.frx":0624
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frm_inst_finan.frx":0736
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame Frame2 
      Height          =   4215
      Left            =   -15
      TabIndex        =   26
      Top             =   1470
      Width           =   9930
      Begin VB.ComboBox box_tipo_riesgo 
         Height          =   315
         Left            =   6840
         Style           =   2  'Dropdown List
         TabIndex        =   19
         Top             =   1680
         Width           =   2895
      End
      Begin VB.ComboBox box_riesgo 
         Height          =   315
         Left            =   6840
         Style           =   2  'Dropdown List
         TabIndex        =   20
         Top             =   2280
         Width           =   2895
      End
      Begin VB.Frame Frame3 
         Caption         =   "Institución"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   615
         Left            =   6840
         TabIndex        =   43
         Top             =   2760
         Width           =   2895
         Begin VB.CheckBox Check2 
            Caption         =   "Emisor"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   210
            Left            =   1800
            TabIndex        =   44
            Top             =   240
            Width           =   975
         End
         Begin VB.CheckBox Check1 
            Caption         =   "Dealer"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   255
            Left            =   120
            TabIndex        =   21
            Top             =   240
            Width           =   1215
         End
      End
      Begin VB.ComboBox box_tipo_insti 
         Height          =   315
         Left            =   3480
         Style           =   2  'Dropdown List
         TabIndex        =   13
         Top             =   1680
         Width           =   2895
      End
      Begin VB.ComboBox box_nombre_gener 
         Height          =   315
         Left            =   3480
         Style           =   2  'Dropdown List
         TabIndex        =   14
         Top             =   2280
         Width           =   2895
      End
      Begin VB.ComboBox box_ciudad 
         Height          =   315
         Left            =   240
         Style           =   2  'Dropdown List
         TabIndex        =   4
         Top             =   480
         Width           =   2895
      End
      Begin VB.Frame Frame4 
         Height          =   615
         Left            =   240
         TabIndex        =   39
         Top             =   2280
         Width           =   2895
         Begin VB.OptionButton Option2 
            Caption         =   "No"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   255
            Left            =   1560
            TabIndex        =   8
            Top             =   240
            Width           =   735
         End
         Begin VB.OptionButton Option1 
            Caption         =   "Si"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   255
            Left            =   240
            TabIndex        =   7
            Top             =   240
            Width           =   735
         End
      End
      Begin VB.TextBox txt_cod_sw 
         Height          =   285
         Left            =   240
         TabIndex        =   10
         Top             =   3840
         Width           =   2895
      End
      Begin VB.ComboBox box_clas_emi 
         Height          =   315
         Left            =   6840
         Style           =   2  'Dropdown List
         TabIndex        =   18
         Top             =   1080
         Width           =   2895
      End
      Begin VB.ComboBox box_prod_deu 
         Height          =   315
         Left            =   3480
         Style           =   2  'Dropdown List
         TabIndex        =   16
         Top             =   3720
         Width           =   2895
      End
      Begin VB.ComboBox box_nacio 
         Height          =   315
         Left            =   240
         Style           =   2  'Dropdown List
         TabIndex        =   6
         Top             =   1680
         Width           =   2895
      End
      Begin VB.TextBox txt_nro_cta 
         Height          =   285
         Left            =   3480
         TabIndex        =   11
         Top             =   480
         Width           =   2895
      End
      Begin VB.ComboBox box_act_econ 
         Height          =   315
         Left            =   3480
         Style           =   2  'Dropdown List
         TabIndex        =   15
         Top             =   3000
         Width           =   2895
      End
      Begin VB.TextBox txt_nro_aba 
         Height          =   285
         Left            =   3480
         TabIndex        =   12
         Top             =   1080
         Width           =   2895
      End
      Begin VB.ComboBox box_pais 
         Height          =   315
         Left            =   240
         Style           =   2  'Dropdown List
         TabIndex        =   5
         Top             =   1080
         Width           =   2895
      End
      Begin VB.ComboBox box_giro 
         Height          =   315
         Left            =   240
         Style           =   2  'Dropdown List
         TabIndex        =   9
         Top             =   3240
         Width           =   2895
      End
      Begin VB.ComboBox box_tip_deu 
         Height          =   315
         Left            =   6840
         Style           =   2  'Dropdown List
         TabIndex        =   17
         Top             =   480
         Width           =   2895
      End
      Begin VB.Label Label17 
         Caption         =   "Riesgo"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   255
         Left            =   6840
         TabIndex        =   46
         Top             =   2040
         Width           =   2775
      End
      Begin VB.Label Label19 
         Caption         =   "Nombre Genérico"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   255
         Left            =   3480
         TabIndex        =   42
         Top             =   2040
         Width           =   2895
      End
      Begin VB.Label Label18 
         Caption         =   "Tipo Institución"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   255
         Left            =   3480
         TabIndex        =   41
         Top             =   1440
         Width           =   2895
      End
      Begin VB.Label Label4 
         Caption         =   "Ciudad"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   255
         Left            =   240
         TabIndex        =   40
         Top             =   240
         Width           =   1215
      End
      Begin VB.Label Label7 
         Caption         =   "Casa Matriz"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   255
         Left            =   240
         TabIndex        =   38
         Top             =   2040
         Width           =   2895
      End
      Begin VB.Label Label9 
         Caption         =   "Código Swift"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   255
         Left            =   240
         TabIndex        =   37
         Top             =   3600
         Width           =   2895
      End
      Begin VB.Label Label13 
         Caption         =   "Producto Deudor"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   255
         Left            =   3480
         TabIndex        =   36
         Top             =   3480
         Width           =   2895
      End
      Begin VB.Label Label15 
         Caption         =   "Clasificación Emisor"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   255
         Left            =   6840
         TabIndex        =   35
         Top             =   840
         Width           =   2895
      End
      Begin VB.Label Label6 
         Caption         =   "Nacionalidad"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   255
         Left            =   240
         TabIndex        =   34
         Top             =   1440
         Width           =   2895
      End
      Begin VB.Label Label10 
         Caption         =   "Nro. Cuenta"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   255
         Left            =   3480
         TabIndex        =   33
         Top             =   240
         Width           =   2895
      End
      Begin VB.Label Label12 
         Caption         =   "Actividad Económica"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   255
         Left            =   3480
         TabIndex        =   32
         Top             =   2760
         Width           =   2895
      End
      Begin VB.Label Label16 
         Caption         =   "Tipo de Riesgo"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   255
         Left            =   6840
         TabIndex        =   31
         Top             =   1440
         Width           =   2895
      End
      Begin VB.Label Label5 
         Caption         =   "País"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   255
         Left            =   240
         TabIndex        =   30
         Top             =   840
         Width           =   2895
      End
      Begin VB.Label Label11 
         Caption         =   "Nro. ABA"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   255
         Left            =   3480
         TabIndex        =   29
         Top             =   840
         Width           =   2895
      End
      Begin VB.Label Label8 
         Caption         =   "Giro"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   255
         Left            =   240
         TabIndex        =   28
         Top             =   3000
         Width           =   2895
      End
      Begin VB.Label Label14 
         Caption         =   "Tipo de Deudor"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   255
         Left            =   6840
         TabIndex        =   27
         Top             =   240
         Width           =   2895
      End
   End
   Begin VB.Frame Frame1 
      Height          =   975
      Left            =   0
      TabIndex        =   0
      Top             =   510
      Width           =   9900
      Begin VB.TextBox txt_nombre 
         Height          =   285
         Left            =   5040
         TabIndex        =   2
         Top             =   240
         Width           =   4695
      End
      Begin VB.TextBox txt_rut 
         ForeColor       =   &H80000012&
         Height          =   285
         Left            =   1200
         MaxLength       =   12
         TabIndex        =   1
         Top             =   240
         Width           =   1455
      End
      Begin VB.TextBox txt_direc 
         Height          =   285
         Left            =   1200
         TabIndex        =   3
         Top             =   600
         Width           =   7095
      End
      Begin VB.CommandButton Command1 
         Caption         =   "..."
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Left            =   2760
         TabIndex        =   22
         ToolTipText     =   "Busca Rut"
         Top             =   240
         Width           =   375
      End
      Begin VB.Label Label20 
         Caption         =   "-"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   12
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   375
         Left            =   2640
         TabIndex        =   47
         Top             =   240
         Width           =   15
      End
      Begin VB.Label Label2 
         Caption         =   "Nombre"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   255
         Left            =   4200
         TabIndex        =   25
         Top             =   240
         Width           =   1215
      End
      Begin VB.Label Label1 
         Caption         =   "Rut"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   255
         Left            =   120
         TabIndex        =   24
         Top             =   240
         Width           =   855
      End
      Begin VB.Label Label3 
         Caption         =   "Dirección"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   255
         Left            =   120
         TabIndex        =   23
         Top             =   600
         Width           =   1335
      End
   End
End
Attribute VB_Name = "Bac_inst_finan"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Sub graba_datos()
'grabar, mostrar imagen, indicar base de datos
End Sub
Sub elimina_datos()
'eliminar,mostrar imagen, indicar nombre registro
End Sub
Private Sub box_act_econ_KeyPress(KeyAscii As Integer)

If KeyAscii = 13 Then box_prod_deu.SetFocus

End Sub
Private Sub box_ciudad_KeyPress(KeyAscii As Integer)

If KeyAscii = 13 Then box_pais.SetFocus

End Sub

Private Sub box_clas_emi_KeyPress(KeyAscii As Integer)

If KeyAscii = 13 Then box_tipo_riesgo.SetFocus

End Sub
Private Sub box_giro_KeyPress(KeyAscii As Integer)

If KeyAscii = 13 Then txt_cod_sw.SetFocus

End Sub
Private Sub box_nacio_KeyPress(KeyAscii As Integer)
Select Case KeyAscii
Case 13
    Option1.SetFocus
End Select
End Sub

Private Sub box_nombre_gener_KeyPress(KeyAscii As Integer)

If KeyAscii = 13 Then box_act_econ.SetFocus

End Sub
Private Sub box_pais_KeyPress(KeyAscii As Integer)

If KeyAscii = 13 Then box_nacio.SetFocus

End Sub

Private Sub box_prod_deu_KeyPress(KeyAscii As Integer)

If KeyAscii = 13 Then box_tip_deu.SetFocus

End Sub

Private Sub box_riesgo_KeyPress(KeyAscii As Integer)

If KeyAscii = 13 Then Check1.SetFocus

End Sub

Private Sub box_tip_deu_KeyPress(KeyAscii As Integer)

If KeyAscii = 13 Then box_clas_emi.SetFocus

End Sub
Private Sub box_tipo_insti_KeyPress(KeyAscii As Integer)

If KeyAscii = 13 Then box_nombre_gener.SetFocus

End Sub

Private Sub box_tipo_riesgo_KeyPress(KeyAscii As Integer)

If KeyAscii = 13 Then box_riesgo.SetFocus

End Sub

Private Sub Command1_Click()
    txt_rut.SetFocus
    Bac_ayuda_rut.Show
End Sub
Private Sub Form_Activate()
Move 0, 0
    txt_rut.SetFocus

End Sub

Private Sub Form_Load()
Move 0, 0
End Sub


Private Sub Option1_KeyPress(KeyAscii As Integer)

If KeyAscii = 13 Then box_giro.SetFocus


End Sub

Private Sub Option2_Click()

If KeyAscii = 13 Then box_giro.SetFocus

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Index
    Case 1
        graba_datos
    Case 2
        elimina_datos
    Case 3
         Unload Me
End Select
End Sub

Private Sub txt_cod_sw_KeyPress(KeyAscii As Integer)

If Not IsNumeric(Chr(KeyAscii)) And KeyAscii <> 13 Then
    
    KeyAscii = 0
    
Exit Sub
End If
If KeyAscii = 13 Then txt_nro_cta.SetFocus

End Sub

Private Sub txt_direc_Change()
With Me.txt_direc
            .Text = UCase(.Text)
            .SelStart = Len(Me.txt_direc.Text) + 1
    End With
End Sub

Private Sub txt_direc_KeyPress(KeyAscii As Integer)

If KeyAscii = 13 Then box_ciudad.SetFocus

End Sub

Private Sub txt_nombre_Change()

With Me.txt_nombre
            .Text = UCase(.Text)
            .SelStart = Len(Me.txt_nombre.Text) + 1
End With

End Sub

Private Sub txt_nombre_KeyPress(KeyAscii As Integer)

If KeyAscii = 13 Then txt_direc.SetFocus

End Sub
Private Sub txt_nro_aba_KeyPress(KeyAscii As Integer)
If Not IsNumeric(Chr(KeyAscii)) And KeyAscii <> 13 Then
    
    KeyAscii = 0
    
    Exit Sub
End If
If KeyAscii = 13 Then box_tipo_insti.SetFocus

End Sub

Private Sub txt_nro_cta_KeyPress(KeyAscii As Integer)
If Not IsNumeric(Chr(KeyAscii)) And KeyAscii <> 13 Then
    
    KeyAscii = 0
    
    Exit Sub
    End If
If KeyAscii = 13 Then txt_nro_aba.SetFocus

End Sub

Private Sub txt_rut_KeyPress(KeyAscii As Integer)

If Not IsNumeric(Chr(KeyAscii)) And KeyAscii <> 13 Then
   KeyAscii = 0
   Exit Sub
End If

If KeyAscii = 13 And Trim(txt_rut.Text) <> "" Then txt_nombre.SetFocus

End Sub

Private Sub txt_rut_LostFocus()
Dim RUT As String
If Me.txt_rut.Text = "" Then Exit Sub
    Me.txt_rut.Text = gfunFormatRut(Me.txt_rut.Text)
    Me.txt_rut.Text = gfunRutConGuion(Me.txt_rut.Text)
    If gfunDVerificador(gfunRutSinCerosLeft(Me.txt_rut.Text)) <> Right(Me.txt_rut.Text, 1) Then
            Me.txt_rut.Text = ""
            txt_rut.SetFocus
    End If
'    txt_rut.Text = Right(txt_rut.Text, 10)
End Sub
