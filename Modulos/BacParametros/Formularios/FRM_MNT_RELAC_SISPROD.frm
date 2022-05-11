VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form FRM_MNT_RELAC_SISPROD 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantenedor de Sistemas y Productos del Control de Precios y Tasas"
   ClientHeight    =   7335
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   9360
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   7335
   ScaleWidth      =   9360
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   6360
      Top             =   0
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   24
      ImageHeight     =   24
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   5
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MNT_RELAC_SISPROD.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MNT_RELAC_SISPROD.frx":0EDA
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MNT_RELAC_SISPROD.frx":132C
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MNT_RELAC_SISPROD.frx":1646
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MNT_RELAC_SISPROD.frx":2520
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   540
      Left            =   0
      TabIndex        =   1
      Top             =   0
      Width           =   9360
      _ExtentX        =   16510
      _ExtentY        =   953
      ButtonWidth     =   820
      ButtonHeight    =   794
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Nuevo"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   3
         EndProperty
      EndProperty
   End
   Begin VB.Frame Frame1 
      Height          =   5535
      Left            =   0
      TabIndex        =   0
      Top             =   600
      Width           =   9255
      Begin VB.CommandButton cmdToYes 
         BackColor       =   &H00800000&
         Height          =   495
         Left            =   4320
         Picture         =   "FRM_MNT_RELAC_SISPROD.frx":33FA
         Style           =   1  'Graphical
         TabIndex        =   10
         Top             =   3480
         Width           =   495
      End
      Begin VB.CommandButton cmdToNo 
         BackColor       =   &H000000C0&
         Height          =   495
         Left            =   4320
         Picture         =   "FRM_MNT_RELAC_SISPROD.frx":383C
         Style           =   1  'Graphical
         TabIndex        =   9
         Top             =   2640
         Width           =   495
      End
      Begin VB.Frame fraNoAplican 
         Caption         =   "Operaciones que no aplican Control"
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
         Height          =   4215
         Left            =   4920
         TabIndex        =   7
         Top             =   1200
         Width           =   3975
         Begin VB.ListBox lstNoAplican 
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H000000C0&
            Height          =   3765
            Left            =   120
            MultiSelect     =   1  'Simple
            TabIndex        =   8
            Top             =   240
            Width           =   3735
         End
      End
      Begin VB.Frame fraAplican 
         Caption         =   "Operaciones que sí aplican Control"
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
         Height          =   4215
         Left            =   120
         TabIndex        =   5
         Top             =   1200
         Width           =   3975
         Begin VB.ListBox lstAplican 
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
            Height          =   3765
            Left            =   120
            MultiSelect     =   1  'Simple
            TabIndex        =   6
            Top             =   240
            Width           =   3735
         End
      End
      Begin VB.Frame fraSelector 
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
         Height          =   855
         Left            =   120
         TabIndex        =   2
         Top             =   240
         Width           =   4215
         Begin VB.ComboBox cmbSistemas 
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
            Left            =   120
            Style           =   2  'Dropdown List
            TabIndex        =   3
            Top             =   360
            Width           =   3855
         End
         Begin VB.Label lblSistemas 
            AutoSize        =   -1  'True
            Caption         =   "Sistemas"
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
            Height          =   195
            Left            =   120
            TabIndex        =   4
            Top             =   120
            Width           =   765
         End
      End
   End
End
Attribute VB_Name = "FRM_MNT_RELAC_SISPROD"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub cmbSistemas_Click()
    If cmbSistemas.ListIndex = -1 Then
        Exit Sub
    End If
    Call cmbSistemas_KeyPress(13)
End Sub
   
Private Sub cmbSistemas_KeyPress(KeyAscii As Integer)
    Dim linea As String
    Envia = Array()
    AddParam Envia, Trim(Right(cmbSistemas.Text, 10))
    'Llenar listbox lstSiAplican con la lista de los productos
    Dim Datos()
    lstAplican.Clear
    lstNoAplican.Clear
    If Not Bac_Sql_Execute("SP_LEER_TABLA_APLICAN_CONTROL_PT", Envia) Then
    Exit Sub
    End If
    Do While Bac_SQL_Fetch(Datos())
        linea = Datos(4) & Space(100) & Datos(3)
        If Datos(5) = "S" Then
            'lstAplican.AddItem (Datos(4))
            lstAplican.AddItem (linea)
        Else
            'lstNoAplican.AddItem (Datos(4))
            lstNoAplican.AddItem (linea)
        End If
    Loop
End Sub
Private Sub cmbSistemas_LostFocus()
    If cmbSistemas.ListIndex = -1 Then
        MsgBox "No ha seleccionado Sistema!", vbInformation, "Validación"
        cmbSistemas.SetFocus
        Exit Sub
    End If
End Sub

Private Sub cmdToNo_Click()
    Dim n As Long
    Dim i As Long
    Dim linea As String
    'Revisar si en lstAplican hay líneas
    If lstAplican.ListCount = 0 Then
        Exit Sub
    End If
    n = lstAplican.ListCount
    For i = n - 1 To 0 Step -1
        If lstAplican.Selected(i) Then
            linea = lstAplican.List(i)
            lstNoAplican.AddItem (linea)
            lstAplican.RemoveItem (i)
            'i = i + 1
        End If
    Next i
    
End Sub

Private Sub cmdToYes_Click()
Dim n As Long
    Dim i As Long
    Dim linea As String
    'Revisar si en lstNoAplican hay líneas
    If lstNoAplican.ListCount = 0 Then
        Exit Sub
    End If
    n = lstNoAplican.ListCount
    For i = n - 1 To 0 Step -1
        If lstNoAplican.Selected(i) Then
            linea = lstNoAplican.List(i)
            lstAplican.AddItem (linea)
            lstNoAplican.RemoveItem (i)
            'i = i + 1
        End If
    Next i
End Sub

Private Sub Form_Load()
Me.Top = 0
Me.Left = 0

'Llena combo Sistemas
Call PROC_LLENA_COMBOS("SP_CMBSISTEMA", Array(), cmbSistemas, False, 1, 2)
cmbSistemas.ListIndex = -1
'fraSelector.Enabled = False
End Sub
Private Sub lstAplican_Click()
    If fraSelector.Enabled Then
        fraSelector.Enabled = False
    End If
End Sub
Private Sub lstNoAplican_Click()
    If fraSelector.Enabled Then
        fraSelector.Enabled = False
    End If
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
    Dim fila As Long
    Select Case Button.Index
        Case 1  'Limpiar
            Call Limpiar
        Case 2  'Grabar
            Call Grabar
        Case 3  'Salir
            Unload Me
      
    
    End Select
End Sub
Private Sub Limpiar()
    'Recargar la combo de Sistemas
    cmbSistemas.Clear
    Call PROC_LLENA_COMBOS("SP_CMBSISTEMA", Array(), cmbSistemas, False, 1, 2)
    cmbSistemas.ListIndex = -1
    lstAplican.Clear
    lstNoAplican.Clear
        If fraSelector.Enabled = False Then
        fraSelector.Enabled = True
    End If

End Sub
Private Sub Grabar()
    Dim n1 As Long
    Dim n2 As Long
    Dim i As Long
    Dim grabados As Long
    Dim codSistema As String
    Dim linea As String
    codSistema = Trim(Right(cmbSistemas.Text, 10))
    'Primero los que sí aplican
    n1 = lstAplican.ListCount
    n2 = lstNoAplican.ListCount
    If n1 = 0 And n2 = 0 Then
        MsgBox "No hay datos para grabar!", vbExclamation, "Validación"
        Exit Sub
    End If
    grabados = 0
    If n1 > 0 Then
        For i = 0 To n1 - 1
            linea = lstAplican.List(i)
            If GrabaLinea(codSistema, linea, True) Then
                grabados = grabados + 1
            End If
        Next i
    End If
    'Luego, los que no aplican
    
    If n2 > 0 Then
        For i = 0 To n2 - 1
            linea = lstNoAplican.List(i)
            If GrabaLinea(codSistema, linea, False) Then
                grabados = grabados + 1
            End If
        Next i
    End If
    If grabados = (n1 + n2) Then
        MsgBox "Los datos han sido grabados correctamente!", vbInformation
    Else
        MsgBox "Verifique la información grabada.  Se han producido algunos errores en la grabación!", vbExclamation
    End If
    If fraSelector.Enabled = False Then
        fraSelector.Enabled = True
    End If
    Call Limpiar
End Sub
Private Function GrabaLinea(ByVal codSis As String, ByVal dato As String, ByVal aplica As Boolean) As Boolean
    'codigo a la cola de dato, ultimas 10 posiciones
    Dim codProd As String
    Dim snAplica As String
    snAplica = "N"
    If aplica Then
        snAplica = "S"
    End If
    codProd = Trim(Right(dato, 10))
    Envia = Array()
    AddParam Envia, codSis
    AddParam Envia, codProd
    AddParam Envia, snAplica
    If Not Bac_Sql_Execute("SP_MNT_APLICAN_CONTROL_PRECIOSTASAS", Envia) Then
        GrabaLinea = False
        Exit Function
    End If
    GrabaLinea = True
End Function
