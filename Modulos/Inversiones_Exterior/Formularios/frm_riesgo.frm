VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form Bac_Riesgo 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Clasificador de Riesgo"
   ClientHeight    =   5445
   ClientLeft      =   4335
   ClientTop       =   3030
   ClientWidth     =   7050
   Icon            =   "frm_riesgo.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5445
   ScaleWidth      =   7050
   Begin VB.Frame frm_tipos 
      Caption         =   "Tipos de Riesgo"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00C00000&
      Height          =   4005
      Left            =   75
      TabIndex        =   3
      Top             =   1485
      Width           =   7005
      Begin VB.TextBox txt_codigo 
         Height          =   285
         Left            =   1650
         TabIndex        =   4
         Top             =   1455
         Visible         =   0   'False
         Width           =   3495
      End
      Begin MSFlexGridLib.MSFlexGrid grilla 
         Height          =   3585
         Left            =   135
         TabIndex        =   5
         Top             =   285
         Width           =   6720
         _ExtentX        =   11853
         _ExtentY        =   6324
         _Version        =   393216
         BackColor       =   -2147483644
         ForeColor       =   12582912
         BackColorFixed  =   8421376
         BackColorSel    =   8388608
         ForeColorSel    =   12632256
         BackColorBkg    =   8421376
         GridColor       =   64
         Enabled         =   -1  'True
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
         MouseIcon       =   "frm_riesgo.frx":030A
      End
   End
   Begin VB.Frame frm_clasificador 
      Caption         =   "Clasificación"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00C00000&
      Height          =   750
      Left            =   45
      TabIndex        =   2
      Top             =   675
      Width           =   6975
      Begin VB.TextBox txt_Clasi 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   345
         Left            =   165
         MaxLength       =   40
         MousePointer    =   14  'Arrow and Question
         TabIndex        =   1
         Top             =   240
         Width           =   6675
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   660
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   7050
      _ExtentX        =   12435
      _ExtentY        =   1164
      ButtonWidth     =   1032
      ButtonHeight    =   1005
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.ToolTipText     =   "Grabar Clasificación de Riesgo"
            ImageIndex      =   9
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   11
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   12
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   4620
      Top             =   -45
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
            Picture         =   "frm_riesgo.frx":075C
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_riesgo.frx":0A76
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_riesgo.frx":0EC8
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_riesgo.frx":131A
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_riesgo.frx":1634
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_riesgo.frx":194E
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_riesgo.frx":1DA0
            Key             =   ""
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_riesgo.frx":1EFA
            Key             =   ""
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_riesgo.frx":234C
            Key             =   ""
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_riesgo.frx":279E
            Key             =   ""
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_riesgo.frx":2AB8
            Key             =   ""
         EndProperty
         BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_riesgo.frx":2DD2
            Key             =   ""
         EndProperty
         BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_riesgo.frx":2F2C
            Key             =   ""
         EndProperty
         BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_riesgo.frx":337E
            Key             =   ""
         EndProperty
         BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_riesgo.frx":37D0
            Key             =   ""
         EndProperty
         BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_riesgo.frx":3AEA
            Key             =   ""
         EndProperty
         BeginProperty ListImage17 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_riesgo.frx":3E04
            Key             =   ""
         EndProperty
         BeginProperty ListImage18 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_riesgo.frx":411E
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "Bac_Riesgo"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim contenido As String
Function buscar_rieago(Glosa)
    Dim datos()
    envia = Array()
    AddParam envia, Glosa
    grilla.Rows = 1
    I = 0
    If Bac_Sql_Execute("SVC_RSG_BUS_COD", envia) Then
        grilla.Enabled = False
        Do While Bac_SQL_Fetch(datos)
            I = I + 1
            If datos(1) = "1" Then
                grilla.Rows = datos(3) + 1
                grilla.TextMatrix(I, 0) = I
                grilla.TextMatrix(I, 1) = datos(2)
            Else
                If MsgBox("Clasificación De Riesgo No Existe, Desea Agregar", vbQuestion + vbYesNo, gsBac_Version) = vbYes Then
                    grilla.Rows = grilla.Rows + 1
                    grilla.Row = grilla.Rows - 1
                    grilla.TextMatrix(grilla.Row, 0) = grilla.Rows - 1
                    grilla.Row = grilla.Rows - 1
                Else
                    Call Clear_Objetos
                    Exit Function
                End If


            End If
            
        Loop
        txt_Clasi.Enabled = False
        Toolbar1.Buttons(1).Enabled = True
        grilla.Enabled = True
        grilla.SetFocus
    End If

End Function
Function Clear_Objetos()
    txt_Clasi.Text = ""
    txt_Clasi.Enabled = True
    grilla.Rows = 1
    grilla.Enabled = False
    txt_codigo.Visible = False
    txt_codigo.Text = ""
    Toolbar1.Buttons(1).Enabled = False
    
End Function

Function dibuja_grilla()

    grilla.TextMatrix(0, 0) = ""
    grilla.TextMatrix(0, 1) = "Clasificación"
    grilla.ColWidth(0) = 300
    grilla.ColWidth(1) = 2000
    
    grilla.ColAlignment(1) = 0
End Function

Function grabar_datos()
    I = 0
    Dim datos()
    envia = Array()
    AddParam envia, txt_Clasi.Text
    If Bac_Sql_Execute("SVA_RSG_GRB_DET", envia) Then
        Do While Bac_SQL_Fetch(datos)
        Loop
    End If
    envia = Array()
    AddParam envia, txt_Clasi.Text
    If Bac_Sql_Execute("SVA_RSG_ELI_COD", envia) Then
        Do While Bac_SQL_Fetch(datos)
        Loop
    End If
    
    For I = 1 To grilla.Rows - 1
        envia = Array()
        AddParam envia, txt_Clasi.Text
        AddParam envia, grilla.TextMatrix(I, 1)
        If Bac_Sql_Execute("SVA_RSG_GRB_DAT", envia) Then
            Do While Bac_SQL_Fetch(datos)
            Loop
        End If
    Next
    MsgBox "Datos Grabados Con Exito", vbInformation, gsBac_Version
    Call Clear_Objetos
End Function

Private Sub Form_Load()
    Call dibuja_grilla
    Move 0, 0
    Me.Icon = BAC_INVERSIONES.Icon
End Sub

Private Sub grilla_Click()
        txt_codigo.Visible = False
End Sub

Private Sub grilla_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = vbKeyInsert Then
        grilla.Rows = grilla.Rows + 1
        grilla.Row = grilla.Rows - 1
        grilla.TextMatrix(grilla.Row, 0) = grilla.Rows - 1
        grilla.Row = grilla.Rows - 1
    End If
    If KeyCode = vbKeyDelete Then
        If grilla.Rows = 1 Then
            MsgBox "No hay más líneas que borrar", vbExclamation, gsBac_Version
            grilla.SetFocus
        Else
            grilla.Rows = grilla.Rows - 1
        End If
    End If
End Sub

Private Sub grilla_KeyPress(KeyAscii As Integer)
    txt_codigo.Text = " "
    If grilla.Col = 1 And KeyAscii > 47 Then
        contenido = grilla.TextMatrix(grilla.Row, 1)
        txt_codigo.Top = grilla.CellTop + grilla.Top
        txt_codigo.Left = grilla.CellLeft + grilla.Left
        txt_codigo.Height = grilla.CellHeight + 20
        txt_codigo.Width = grilla.CellWidth
        txt_codigo.Visible = True
        txt_codigo.SetFocus
        txt_codigo.Text = UCase(Chr(KeyAscii))
    End If
End Sub


Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
    Select Case Button.Index
        Case 1
            Call grabar_datos
        Case 2
            Call Clear_Objetos
        Case 3
            Unload Me
    End Select
End Sub


Private Sub txt_clasi_DblClick()
    BacAyuda.Tag = "RIESGO"
    BacAyuda.Show 1
    If giAceptar% = True Then
        txt_Clasi.Text = gsrut$
        Call buscar_rieago(txt_Clasi.Text)
    End If
End Sub


Private Sub txt_Clasi_KeyPress(KeyAscii As Integer)
 KeyAscii = Asc(UCase(Chr(KeyAscii)))
    

    If KeyAscii = 13 And txt_Clasi.Text <> "" Then
       buscar_rieago (txt_Clasi.Text)
    End If
End Sub

Private Sub txt_corto_KeyPress(KeyAscii As Integer)
KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub


Private Sub txt_largo_KeyPress(KeyAscii As Integer)
KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub


Private Sub txt_codigo_GotFocus()
    txt_codigo.SelStart = Len(txt_codigo)
End Sub

Private Sub txt_codigo_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        If txt_codigo.Text = " " Then
            grilla.TextMatrix(grilla.Row, 1) = contenido
            txt_codigo.Visible = False
        Else
            grilla.TextMatrix(grilla.Row, 1) = txt_codigo.Text
            txt_codigo.Visible = False
            txt_codigo.Text = " "
        End If
    ElseIf KeyAscii = 27 Then
        grilla.TextMatrix(grilla.Row, 1) = contenido
        txt_codigo.Visible = False
    End If
'KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub

