VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form Bac_Formulas_Copiar 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   " Copia De Fomulas"
   ClientHeight    =   1665
   ClientLeft      =   240
   ClientTop       =   2430
   ClientWidth     =   7845
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   1665
   ScaleWidth      =   7845
   ShowInTaskbar   =   0   'False
   Begin VB.Frame Frm_nemo_nue 
      Caption         =   "Serie Destino"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000D&
      Height          =   960
      Left            =   3930
      TabIndex        =   3
      ToolTipText     =   "Elija Instrumeto"
      Top             =   645
      Width           =   3825
      Begin VB.ComboBox box_nemo_nue 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   75
         Style           =   2  'Dropdown List
         TabIndex        =   1
         Top             =   555
         Width           =   3630
      End
   End
   Begin VB.Frame Frm_nemo_ant 
      Caption         =   "Serie Origen"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000D&
      Height          =   945
      Left            =   45
      TabIndex        =   2
      ToolTipText     =   "Elija Instrumeto"
      Top             =   660
      Width           =   3855
      Begin VB.ComboBox Box_nemo_ant 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   105
         Style           =   2  'Dropdown List
         TabIndex        =   0
         Top             =   525
         Width           =   3630
      End
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   30
      Top             =   540
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   16
      ImageHeight     =   16
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   3
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bac_Copia_formulas.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bac_Copia_formulas.frx":0452
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bac_Copia_formulas.frx":076C
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   4
      Top             =   0
      Width           =   7845
      _ExtentX        =   13838
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList2"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   4
         EndProperty
      EndProperty
      BorderStyle     =   1
      MouseIcon       =   "Bac_Copia_formulas.frx":0A86
      Begin MSComctlLib.ImageList ImageList2 
         Left            =   4800
         Top             =   0
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
               Picture         =   "Bac_Copia_formulas.frx":0DA0
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bac_Copia_formulas.frx":11F2
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bac_Copia_formulas.frx":1304
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bac_Copia_formulas.frx":1416
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bac_Copia_formulas.frx":1730
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bac_Copia_formulas.frx":1A4A
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
End
Attribute VB_Name = "Bac_Formulas_Copiar"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Function Clear_Objetos()

    Frm_nemo_ant.Enabled = True
    Box_nemo_ant.ListIndex = -1
    box_nemo_nue.ListIndex = -1
    Box_nemo_ant.SetFocus
    Toolbar1.Buttons(1).Enabled = False
End Function

Function existe_Datos()
    If Box_nemo_ant.Text = "" Or box_nemo_nue.Text = "" Then
        MsgBox "Selecione Papeles Para Realizar Copia de Formulas", vbExclamation, gsBac_Version
        Exit Function
    End If
    Dim datos()
    Dim res
    envia = Array()
    AddParam envia, Trim(Mid(box_nemo_nue.Text, 1, 20))
    AddParam envia, Trim(Mid(box_nemo_nue.Text, 23, 10))
    If Bac_Sql_Execute("SVC_FMU_VAL_EXT", envia) Then
        Do While Bac_SQL_Fetch(datos)
            res = datos(1)
        Loop
    End If
    Dim OpC
    If res = 1 Then
        OpC = MsgBox("Este Intrumeto Ya tiene Sus Fórmulas, ¿ Desea Remplazarlas ?", vbQuestion + vbYesNo, gsBac_Version)
        If OpC = vbYes Then
            Call grabar_formulas
            Clear_Objetos
            Exit Function
        Else
            Call Clear_Objetos
            Exit Function
        End If
    Else
            Call grabar_formulas
            Clear_Objetos
    End If
End Function

Function grabar_formulas()
    Dim datos()
    envia = Array()
    'parametros combo antiguos
    AddParam envia, Trim(Mid(Box_nemo_ant.Text, 1, 20))
    AddParam envia, Trim(Mid(Box_nemo_ant.Text, 23, 10))
    'parametros combo nuevos
    AddParam envia, Trim(Mid(box_nemo_nue.Text, 1, 20))
    AddParam envia, Trim(Mid(box_nemo_nue.Text, 23, 10))
    If Bac_Sql_Execute("SVA_FMU_COP_DAT", envia) Then
        Do While Bac_SQL_Fetch(datos)
        Loop
        Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "Copia de Fórmula desde el instrumento " & Box_nemo_ant & " al instrumento " & box_nemo_nue.Text & " se grabó con éxito.")
        MsgBox "Proceso Realizado Con Exito", vbInformation, gsBac_Version
        Call Clear_Objetos
        Exit Function
    Else
        Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "Problemas en Copia de Fórmula desde el instrumento " & Box_nemo_ant & " al instrumento " & box_nemo_nue.Text)
    End If
End Function


Function llena_combo_nemo_ant()
    Dim datos()
    Box_nemo_ant.Clear
    box_nemo_nue.Clear
    If Bac_Sql_Execute("SVC_GEN_LEE_SER") Then
        Do While Bac_SQL_Fetch(datos)
        
            ' carga combo nemotecnico antiguo
            Box_nemo_ant.AddItem datos(2) & Space(20 - Len(datos(2))) & " (" & Format(datos(3), "DD/MM/YYYY") & ") "
            Box_nemo_ant.ItemData(Box_nemo_ant.NewIndex) = Val(datos(1))
            
            ' carga combo nemotecnico nuevo
            box_nemo_nue.AddItem datos(2) & Space(20 - Len(datos(2))) & " (" & Format(datos(3), "DD/MM/YYYY") & ") "
            box_nemo_nue.ItemData(box_nemo_nue.NewIndex) = Val(datos(1))
            
        Loop
    End If
End Function


Private Sub Box_nemo_ant_Click()
    If Box_nemo_ant.ListIndex <> -1 Then
        Frm_nemo_ant.Enabled = False
    End If
End Sub


Private Sub box_nemo_nue_Click()
    If Box_nemo_ant.ListIndex = box_nemo_nue.ListIndex And Box_nemo_ant.ListIndex <> -1 Then
        MsgBox "Selección No Válida, No Puden Ser Iguales", vbExclamation, gsBac_Version
        box_nemo_nue.ListIndex = -1
        Toolbar1.Buttons(1).Enabled = False
    Else
        Toolbar1.Buttons(1).Enabled = True
    End If
End Sub


Private Sub Form_Load()

    Move 0, 0
    Me.Icon = BAC_INVERSIONES.Icon
    'Me.Height = 2610
    'Me.Width = 11475
    Call llena_combo_nemo_ant
    
End Sub


Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
    Select Case Button.Index
        Case 1
            Call existe_Datos
        Case 2
            Call Clear_Objetos
        Case 3
            Unload Me
    End Select
End Sub


