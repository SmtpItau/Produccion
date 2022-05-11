VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "Bac_Controles_Pas.ocx"
Begin VB.Form FRM_AYUDA 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   " Ayuda  de  Acceso"
   ClientHeight    =   5340
   ClientLeft      =   480
   ClientTop       =   2190
   ClientWidth     =   6060
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
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5340
   ScaleWidth      =   6060
   ShowInTaskbar   =   0   'False
   Begin MSComctlLib.ListView Lstnombre 
      Height          =   4455
      Left            =   -30
      TabIndex        =   3
      Top             =   900
      Width           =   6105
      _ExtentX        =   10769
      _ExtentY        =   7858
      View            =   3
      LabelEdit       =   1
      LabelWrap       =   -1  'True
      HideSelection   =   -1  'True
      _Version        =   393217
      ForeColor       =   -2147483640
      BackColor       =   -2147483643
      BorderStyle     =   1
      Appearance      =   1
      NumItems        =   0
   End
   Begin VB.TextBox lblnombre 
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   345
      Left            =   1080
      Locked          =   -1  'True
      MaxLength       =   255
      TabIndex        =   1
      ToolTipText     =   " "
      Top             =   540
      Width           =   4965
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   2880
      Top             =   -60
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   24
      ImageHeight     =   24
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   2
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_AYUDA.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_AYUDA.frx":031A
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Height          =   450
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   6060
      _ExtentX        =   10689
      _ExtentY        =   794
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Aceptar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Cancelar"
            ImageIndex      =   1
         EndProperty
      EndProperty
      Begin MSComctlLib.ImageList ImageList2 
         Left            =   5220
         Top             =   -30
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   10
         ImageHeight     =   10
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   2
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_AYUDA.frx":11F4
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_AYUDA.frx":1646
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Label LblBuscarPor 
      Caption         =   "Usuario (s) :"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   60
      TabIndex        =   2
      Top             =   600
      Width           =   1230
   End
End
Attribute VB_Name = "FRM_AYUDA"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim sPatron$
Dim Sql$
Dim Datos()
Public Mascara      As String

Private objAyuda As Object
Public parAyuda  As String    ' Ayuda de perfiles
Public parFiltro As String    ' Ayuda de Perfiles
Public codigo    As Long
Public glosa     As String
Public Function BuscaListIndex(Combo As Object, BUSCA As String) As Integer
 Dim Linea As Integer
 
 BuscaListIndex = 0              ' Nada en el ComboList
 
  With Combo
    Linea = Lstnombre.Index
    If .ListCount <> 0 Then       ' = 0 Nada
        For Linea = 0 To .ListCount - 1
            .ListIndex = Linea
            If Trim$(Left(UCase(Trim$(.List(.ListIndex))), 25)) = Trim$(Left(UCase(BUSCA), 25)) Then
                     BuscaListIndex = Linea
                     Exit Function
            End If
        Next
    End If
 End With
      
End Function
 Private Sub Form_Activate()
 Dim Datos()
 Dim aux As String
    
    Lstnombre.ListItems.Clear

    BacControlWindows 12

    Screen.MousePointer = 11
        
        Envia = Array("U", "")
        
        If Not BAC_SQL_EXECUTE("SP_BUSCA_ACCESO_USUARIO ", Envia) Then
            Screen.MousePointer = 0
            Unload Me
            Exit Sub
        End If
    
        Do While BAC_SQL_FETCH(Datos())
            Lstnombre.ListItems.Add , , UCase(Datos(1))
        Loop
        
    Screen.MousePointer = 0

End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)

    If KeyCode <> vbKeyControl And (Shift = 2 Or (Shift = 0 And (KeyCode = vbKeyReturn Or KeyCode = vbKeyEscape Or (KeyCode >= vbKeyF1 And KeyCode <= vbKeyF12)))) Then

      Select Case KeyCode
         Case vbKeyAceptar:
                          Call Toolbar1_ButtonClick(Toolbar1.Buttons(1))
         Case vbKeySalir:
                          Unload Me
      End Select
   End If
End Sub

Private Sub Form_Load()
   PROC_GENERA_LISTA
End Sub

Private Sub Form_Unload(Cancel As Integer)
        
    Set objAyuda = Nothing
        
End Sub
Private Sub lblnombre_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode <> 36 And KeyCode <> 35 And KeyCode <> 39 And KeyCode <> 37 Then
      KeyCode = 0
   End If
End Sub
Private Sub LblNombre_KeyPress(KeyAscii As Integer)
   KeyAscii = 0
End Sub
Private Sub lstNombre_DblClick()
   If lblnombre.Text = "" Then
         lblnombre.Text = " " + Trim$(Lstnombre.SelectedItem.Text)
   Else
      If InStr(1, Trim(lblnombre.Text), Trim$(Lstnombre.SelectedItem.Text)) > 0 Then Exit Sub
      If Len(Trim(lblnombre.Text) + ";" + Trim$(Lstnombre.SelectedItem.Text)) > 255 Then
         MsgBox "No Se Puede Agregar Mas Usuarios Porque Sobrepasa El Largo Del Campo", vbExclamation
         Exit Sub
      End If
         lblnombre.Text = " " + Trim(lblnombre.Text) + ";" + Trim$(Lstnombre.SelectedItem.Text)
   End If
End Sub

Private Sub Lstnombre_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = 13 Then
   If lblnombre.Text = "" Then
         lblnombre.Text = " " + Trim$(Lstnombre.SelectedItem.Text)
   Else
      If InStr(1, Trim(lblnombre.Text), Trim$(Lstnombre.SelectedItem.Text)) > 0 Then Exit Sub
      If Len(Trim(lblnombre.Text) + ";" + Trim$(Lstnombre.SelectedItem.Text)) > 255 Then
         MsgBox "No Se Puede Agregar Mas Usuarios Porque Sobrepasa El Largo Del Campo", vbExclamation
         Exit Sub
      End If
         lblnombre.Text = " " + Trim(lblnombre.Text) + ";" + Trim$(Lstnombre.SelectedItem.Text)
   End If
End If
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Dim Indice As Integer

   Select Case Button.Index
       Case 1
       giAceptar% = False
       
       If Not Lstnombre.ListItems.Count > 0 Then
           GoTo Fin
       End If
   
       Select Case UCase(Trim(Me.Tag))
   
       Case "USER"
           gsDescripcion$ = Trim(lblnombre.Text)
       Case Else
           GoTo Fin
   
    End Select
   
       giAceptar% = True
   
Fin:
       Screen.MousePointer = 0
       Unload Me
   
   Case 2
       giAceptar% = False
       Unload Me
   
   End Select
End Sub

Private Sub PROC_GENERA_LISTA()

With Lstnombre
 
    .ColumnHeaderIcons = ImageList2
    .ColumnHeaders.Add 1, , "Usuario", 5800
End With

End Sub

