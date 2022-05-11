VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form FRM_MNT_RELAC_CLASCTE 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantenedor de Tipos de Clientes y Control de Precios y Tasas"
   ClientHeight    =   5550
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   9495
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   5550
   ScaleWidth      =   9495
   Begin VB.Frame Frame1 
      Height          =   4935
      Left            =   0
      TabIndex        =   1
      Top             =   600
      Width           =   9495
      Begin VB.CommandButton cmdToYes 
         BackColor       =   &H00800000&
         Height          =   495
         Left            =   4500
         Picture         =   "FRM_RELAC_CLASCTE.frx":0000
         Style           =   1  'Graphical
         TabIndex        =   5
         Top             =   3000
         Width           =   495
      End
      Begin VB.CommandButton cmdToNo 
         BackColor       =   &H000000C0&
         Height          =   495
         Left            =   4500
         Picture         =   "FRM_RELAC_CLASCTE.frx":0442
         Style           =   1  'Graphical
         TabIndex        =   4
         Top             =   2040
         Width           =   495
      End
      Begin VB.Frame fraNoAplicar 
         Caption         =   "Clasificaciones en las que no se aplica Control"
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
         Height          =   4575
         Left            =   5160
         TabIndex        =   3
         Top             =   240
         Width           =   4215
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
            Height          =   4155
            Left            =   120
            MultiSelect     =   1  'Simple
            TabIndex        =   7
            Top             =   360
            Width           =   3975
         End
      End
      Begin VB.Frame fraSiAplicar 
         Caption         =   "Clasificaciones en las que sí se aplica Control"
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
         Height          =   4575
         Left            =   120
         TabIndex        =   2
         Top             =   240
         Width           =   4215
         Begin VB.ListBox lstSiAplican 
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
            Height          =   4155
            Left            =   120
            MultiSelect     =   1  'Simple
            TabIndex        =   6
            Top             =   360
            Width           =   3975
         End
      End
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   8160
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
            Picture         =   "FRM_RELAC_CLASCTE.frx":0884
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_RELAC_CLASCTE.frx":175E
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_RELAC_CLASCTE.frx":1BB0
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_RELAC_CLASCTE.frx":1ECA
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_RELAC_CLASCTE.frx":2DA4
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   540
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   9495
      _ExtentX        =   16748
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
End
Attribute VB_Name = "FRM_MNT_RELAC_CLASCTE"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub cmdToNo_Click()
    Dim n As Long
    Dim I As Long
    Dim Linea As String
    'Revisar si en lstSiAplican hay líneas
    If lstSiAplican.ListCount = 0 Then
        Exit Sub
    End If
    n = lstSiAplican.ListCount
    For I = n - 1 To 0 Step -1
        If lstSiAplican.Selected(I) Then
            Linea = lstSiAplican.List(I)
            lstNoAplican.AddItem (Linea)
            lstSiAplican.RemoveItem (I)
            'i = i + 1
        End If
    Next I

End Sub

Private Sub cmdToYes_Click()
    Dim n As Long
    Dim I As Long
    Dim Linea As String
    'Revisar si en lstNoAplican hay líneas
    If lstNoAplican.ListCount = 0 Then
        Exit Sub
    End If
    n = lstNoAplican.ListCount
    For I = n - 1 To 0 Step -1
        If lstNoAplican.Selected(I) Then
            Linea = lstNoAplican.List(I)
            lstSiAplican.AddItem (Linea)
            lstNoAplican.RemoveItem (I)
            'i = i + 1
        End If
    Next I

End Sub

Private Sub Form_Load()
    Me.Top = 0
    Me.Left = 0
    Call LlenaListBox

End Sub
Private Sub LlenaListBox()
    Dim Linea As String
    'Llenar listbox lstSiAplican y lstNoAplican
    Dim Datos()
    lstSiAplican.Clear
    lstNoAplican.Clear
    If Not Bac_Sql_Execute("SP_LEER_CLASCLTE_APLICAN_CONTROL_PT") Then
        Exit Sub
    End If
    Do While Bac_SQL_Fetch(Datos())
        Linea = Datos(2) & Space(100) & Datos(1)
        If Datos(3) = "S" Then
            lstSiAplican.AddItem (Linea)
        Else
            lstNoAplican.AddItem (Linea)
        End If
    Loop
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
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
    lstSiAplican.Clear
    lstNoAplican.Clear
    Call LlenaListBox
End Sub
Private Sub Grabar()
    Dim n1 As Long
    Dim n2 As Long
    Dim I As Long
    Dim grabados As Long
    Dim codTipo As String
    Dim Linea As String
    'Primero los que sí aplican
    n1 = lstSiAplican.ListCount
    n2 = lstNoAplican.ListCount
    If n1 = 0 And n2 = 0 Then
        MsgBox "No hay datos para grabar!", vbExclamation, "Validación"
        Exit Sub
    End If
    grabados = 0
    If n1 > 0 Then
        For I = 0 To n1 - 1
            Linea = lstSiAplican.List(I)
            codTipo = Trim(Right(Linea, 10))
            If GrabaLinea(codTipo, True) Then
                grabados = grabados + 1
            End If
        Next I
    End If
    'Luego, los que no aplican
    
    If n2 > 0 Then
        For I = 0 To n2 - 1
            Linea = lstNoAplican.List(I)
            codTipo = Trim(Right(Linea, 10))
            If GrabaLinea(codTipo, False) Then
                grabados = grabados + 1
            End If
        Next I
    End If
    If grabados = (n1 + n2) Then
        MsgBox "Los datos han sido grabados correctamente!", vbInformation
    Else
        MsgBox "Verifique la información grabada.  Se han producido algunos errores en la grabación!", vbExclamation
    End If
    Call Limpiar
End Sub
Private Function GrabaLinea(ByVal codTipo As String, ByVal aplica As Boolean) As Boolean
    'codigo a la cola de dato, ultimas 10 posiciones
    Dim codProd As String
    Dim snAplica As String
    snAplica = "N"
    If aplica Then
        snAplica = "S"
    End If
    Envia = Array()
    AddParam Envia, CLng(codTipo)
    AddParam Envia, snAplica
    If Not Bac_Sql_Execute("BacParamsuda..SP_MNT_RELAC_CLASCTE_PRECIOSTASAS", Envia) Then
        GrabaLinea = False
        Exit Function
    End If
    GrabaLinea = True
End Function

