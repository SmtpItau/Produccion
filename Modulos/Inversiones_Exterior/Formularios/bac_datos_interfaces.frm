VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form Bac_Datos_Interfaces 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Datos Para Interfaces"
   ClientHeight    =   5340
   ClientLeft      =   405
   ClientTop       =   915
   ClientWidth     =   11145
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   5340
   ScaleWidth      =   11145
   Begin VB.Frame Frame1 
      Height          =   4620
      Left            =   30
      TabIndex        =   1
      Top             =   645
      Width           =   11085
      Begin VB.TextBox Txt_Cta_Sbif 
         Alignment       =   1  'Right Justify
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   1320
         MaxLength       =   4
         TabIndex        =   4
         Top             =   2460
         Visible         =   0   'False
         Width           =   3270
      End
      Begin VB.TextBox txt_cta_bech 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   3900
         MaxLength       =   10
         TabIndex        =   3
         Top             =   1095
         Visible         =   0   'False
         Width           =   3270
      End
      Begin MSFlexGridLib.MSFlexGrid grilla 
         Height          =   4260
         Left            =   90
         TabIndex        =   2
         Top             =   240
         Width           =   10920
         _ExtentX        =   19262
         _ExtentY        =   7514
         _Version        =   393216
         Rows            =   1
         Cols            =   6
         FixedCols       =   4
         BackColor       =   -2147483644
         ForeColor       =   16711680
         BackColorFixed  =   8421376
         ForeColorFixed  =   -2147483643
         BackColorSel    =   12582912
         ForeColorSel    =   12632256
         BackColorBkg    =   8421376
         GridColor       =   64
         HighLight       =   2
         GridLines       =   2
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   9
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MouseIcon       =   "bac_datos_interfaces.frx":0000
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   660
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   11145
      _ExtentX        =   19659
      _ExtentY        =   1164
      ButtonWidth     =   1032
      ButtonHeight    =   1005
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   9
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   11
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   12
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   14655
      Top             =   8205
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   32
      ImageHeight     =   32
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   18
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_datos_interfaces.frx":0452
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_datos_interfaces.frx":076C
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_datos_interfaces.frx":0BBE
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_datos_interfaces.frx":1010
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_datos_interfaces.frx":132A
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_datos_interfaces.frx":1644
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_datos_interfaces.frx":1A96
            Key             =   ""
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_datos_interfaces.frx":1BF0
            Key             =   ""
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_datos_interfaces.frx":2042
            Key             =   ""
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_datos_interfaces.frx":2494
            Key             =   ""
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_datos_interfaces.frx":27AE
            Key             =   ""
         EndProperty
         BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_datos_interfaces.frx":2AC8
            Key             =   ""
         EndProperty
         BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_datos_interfaces.frx":2C22
            Key             =   ""
         EndProperty
         BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_datos_interfaces.frx":3074
            Key             =   ""
         EndProperty
         BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_datos_interfaces.frx":34C6
            Key             =   ""
         EndProperty
         BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_datos_interfaces.frx":37E0
            Key             =   ""
         EndProperty
         BeginProperty ListImage17 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_datos_interfaces.frx":3AFA
            Key             =   ""
         EndProperty
         BeginProperty ListImage18 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_datos_interfaces.frx":3E14
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "Bac_Datos_Interfaces"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Function buscar_datos()

    Call dibuja_grilla
    Dim datos()
    Dim I
    I = 1
    If Bac_Sql_Execute("SVC_ITF_BUS_DAT") Then
        Do While Bac_SQL_Fetch(datos)
            If datos(1) = "0" Then
                MsgBox datos(2), vbExclamation, gsBac_Version
                Exit Function
            End If
            grilla.Rows = grilla.Rows + 1
            grilla.RowHeight(I) = 350
            grilla.TextMatrix(I, 0) = datos(1)
            grilla.TextMatrix(I, 1) = datos(2)
            grilla.TextMatrix(I, 2) = datos(3)
            grilla.TextMatrix(I, 3) = datos(4)
            grilla.TextMatrix(I, 4) = datos(5)
            grilla.TextMatrix(I, 5) = datos(6)
            I = I + 1
        Loop
    End If
    If grilla.Rows > 1 Then
        Toolbar1.Buttons(1).Enabled = True
        Toolbar1.Buttons(2).Enabled = False
    Else
        MsgBox "No Hay Información", vbExclamation, gsBac_Version
    End If
    grilla.Enabled = True
End Function

Function dibuja_grilla()
        grilla.FixedCols = 0
        grilla.RowHeight(0) = 400
        grilla.Rows = grilla.FixedRows
        grilla.TextMatrix(0, 0) = "N. Docu."
        grilla.TextMatrix(0, 1) = "Familia"
        grilla.TextMatrix(0, 2) = "Instrumento"
        grilla.TextMatrix(0, 3) = "Fecha Vcto."
        grilla.TextMatrix(0, 4) = "Cuentas Bech"
        grilla.TextMatrix(0, 5) = "Partida SBIF"
        
        
        grilla.ColWidth(0) = 1000
        grilla.ColWidth(1) = 1500
        grilla.ColWidth(2) = 2500
        grilla.ColWidth(3) = 1500
        grilla.ColWidth(4) = 1500
        grilla.ColWidth(5) = 1200

        grilla.ColAlignment(0) = 1
        grilla.ColAlignment(1) = 1
        grilla.ColAlignment(2) = 1
        grilla.ColAlignment(3) = 1
        grilla.ColAlignment(4) = 1
        grilla.ColAlignment(5) = 7
                         
End Function

Function grabar_datos()
    Dim datos()
    For I = 1 To grilla.Rows - 1
        envia = Array()
        AddParam envia, grilla.TextMatrix(I, 0)
        If grilla.TextMatrix(I, 1) = "BONOEX" Then
            AddParam envia, 2000
        ElseIf grilla.TextMatrix(I, 1) = "CD" Then
            AddParam envia, 2001
        ElseIf grilla.TextMatrix(I, 1) = "NOTEX" Then
            AddParam envia, 2002
        ElseIf grilla.TextMatrix(I, 1) = "DEPEX" Then
            AddParam envia, 2003
        End If
        AddParam envia, grilla.TextMatrix(I, 2)
        AddParam envia, grilla.TextMatrix(I, 3)
        AddParam envia, grilla.TextMatrix(I, 4)
        AddParam envia, CDbl(grilla.TextMatrix(I, 5))
        If Bac_Sql_Execute("Sva_Itf_grb_dat", envia) Then
            Do While Bac_SQL_Fetch(datos)
            Loop
        End If
    Next
    If datos(1) = "SI" Then
        MsgBox "Datos Grabados Con Exito", vbInformation, gsBac_Version
        txt_cta_bech.Text = " "
        Txt_Cta_Sbif.Text = " "
        Toolbar1.Buttons(1).Enabled = False
        Toolbar1.Buttons(2).Enabled = True
        grilla.Rows = 1
    End If
End Function


Private Sub Form_Load()
    Move 0, 0
    Me.Icon = BAC_INVERSIONES.Icon
    Call dibuja_grilla
    
End Sub


Private Sub grilla_Click()

    txt_cta_bech.Visible = False

    Txt_Cta_Sbif.Visible = False

    
End Sub


Private Sub grilla_DblClick()
    If grilla.Row > 0 Then
        If grilla.Col = 4 Then
            txt_cta_bech.Top = grilla.CellTop + grilla.Top
            txt_cta_bech.Left = grilla.CellLeft + grilla.Left
            txt_cta_bech.Height = grilla.CellHeight + 20
            txt_cta_bech.Width = grilla.CellWidth
            txt_cta_bech.Visible = True
            txt_cta_bech.SetFocus
        ElseIf grilla.Col = 5 Then
            Txt_Cta_Sbif.Top = grilla.CellTop + grilla.Top
            Txt_Cta_Sbif.Left = grilla.CellLeft + grilla.Left
            Txt_Cta_Sbif.Height = grilla.CellHeight + 20
            Txt_Cta_Sbif.Width = grilla.CellWidth
            Txt_Cta_Sbif.Visible = True
            Txt_Cta_Sbif.SetFocus
        End If
    End If
End Sub

Private Sub grilla_KeyPress(KeyAscii As Integer)
    If grilla.Col = 4 Then
        txt_cta_bech.Top = grilla.CellTop + grilla.Top
        txt_cta_bech.Left = grilla.CellLeft + grilla.Left
        txt_cta_bech.Height = grilla.CellHeight + 20
        txt_cta_bech.Width = grilla.CellWidth
        txt_cta_bech.Visible = True
        txt_cta_bech.SetFocus
        If KeyAscii <> 13 Then
             txt_cta_bech.Text = UCase(Chr(KeyAscii))
        End If
    End If
    If grilla.Col = 5 And KeyAscii > 47 And KeyAscii < 58 Then
         Txt_Cta_Sbif.Top = grilla.CellTop + grilla.Top
         Txt_Cta_Sbif.Left = grilla.CellLeft + grilla.Left
         Txt_Cta_Sbif.Height = grilla.CellHeight + 20
         Txt_Cta_Sbif.Width = grilla.CellWidth
         Txt_Cta_Sbif.Visible = True
         Txt_Cta_Sbif.SetFocus
        If KeyAscii <> 13 Then
             Txt_Cta_Sbif.Text = UCase(Chr(KeyAscii))
         End If
    End If
    If KeyAscii = 13 Then
        If grilla.Col = 4 Then
            txt_cta_bech.Top = grilla.CellTop + grilla.Top
            txt_cta_bech.Left = grilla.CellLeft + grilla.Left
            txt_cta_bech.Height = grilla.CellHeight + 20
            txt_cta_bech.Width = grilla.CellWidth
            txt_cta_bech.Visible = True
            txt_cta_bech.SetFocus
        ElseIf grilla.Col = 5 Then
            Txt_Cta_Sbif.Top = grilla.CellTop + grilla.Top
            Txt_Cta_Sbif.Left = grilla.CellLeft + grilla.Left
            Txt_Cta_Sbif.Height = grilla.CellHeight + 20
            Txt_Cta_Sbif.Width = grilla.CellWidth
            Txt_Cta_Sbif.Visible = True
            Txt_Cta_Sbif.SetFocus
        End If
    ElseIf KeyAscii = 27 Then
        txt_cta_bech.Visible = False
        Txt_Cta_Sbif.Visible = False
        grilla.SetFocus
    End If
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
    Select Case Button.Index
        Case 1
            Call grabar_datos
        Case 2
            Call buscar_datos
        Case 3
            txt_cta_bech.Text = " "
            Txt_Cta_Sbif.Text = " "
            grilla.Rows = 1
            Toolbar1.Buttons(1).Enabled = False
            Toolbar1.Buttons(2).Enabled = True
            grilla.Enabled = False
        Case 4
            Unload Me
    End Select
 
End Sub


Private Sub txt_cta_bech_GotFocus()
    txt_cta_bech.SelStart = Len(txt_cta_bech) + 1
End Sub

Private Sub txt_cta_bech_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        grilla.TextMatrix(grilla.Row, 4) = txt_cta_bech.Text
        txt_cta_bech.Visible = False
        grilla.SetFocus
    ElseIf KeyAscii = 27 Then
        txt_cta_bech.Visible = False
        txt_cta_bech.Text = " "
        grilla.SetFocus
    End If
KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub


Private Sub txt_cta_sbif_GotFocus()
        Txt_Cta_Sbif.SelStart = Len(ttxt_cta_sbif) + 1
End Sub

Private Sub txt_cta_sbif_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        grilla.TextMatrix(grilla.Row, 5) = Txt_Cta_Sbif.Text
        Txt_Cta_Sbif.Visible = False
        grilla.SetFocus
    ElseIf KeyAscii = 27 Then
        Txt_Cta_Sbif.Visible = False
        Txt_Cta_Sbif.Text = 0
        grilla.SetFocus
    End If
End Sub

