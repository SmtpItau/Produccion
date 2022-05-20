VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "threed32.ocx"
Object = "{989C9190-EDF5-45A8-AB6C-98E6EF0384D7}#1.0#0"; "Bac_Controles_Pas.ocx"
Begin VB.Form BacMntEm 
   Appearance      =   0  'Flat
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantención de Emisores"
   ClientHeight    =   2115
   ClientLeft      =   2925
   ClientTop       =   3945
   ClientWidth     =   6225
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
   MouseIcon       =   "Bacmntem.frx":2EFA
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   2115
   ScaleWidth      =   6225
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   8
      Top             =   0
      Width           =   6225
      _ExtentX        =   10980
      _ExtentY        =   794
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Style           =   1
      ImageList       =   "Img_opciones"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   5
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Eliminar"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
      Begin MSComctlLib.ImageList Img_opciones 
         Left            =   5250
         Top             =   0
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   24
         ImageHeight     =   24
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   10
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacmntem.frx":3204
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacmntem.frx":366B
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacmntem.frx":3B61
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacmntem.frx":3FF4
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacmntem.frx":44DC
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacmntem.frx":49EF
               Key             =   ""
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacmntem.frx":4EC2
               Key             =   ""
            EndProperty
            BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacmntem.frx":5388
               Key             =   ""
            EndProperty
            BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacmntem.frx":587F
               Key             =   ""
            EndProperty
            BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacmntem.frx":5C78
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.TextBox TxEtipo 
      Height          =   375
      Left            =   5400
      TabIndex        =   7
      TabStop         =   0   'False
      Top             =   4500
      Width           =   375
   End
   Begin Threed.SSFrame SSFrame1 
      Height          =   1695
      Left            =   0
      TabIndex        =   9
      Top             =   435
      Width           =   6225
      _Version        =   65536
      _ExtentX        =   10980
      _ExtentY        =   2990
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
      Begin VB.TextBox txtRut 
         Alignment       =   1  'Right Justify
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   975
         MaxLength       =   9
         MouseIcon       =   "Bacmntem.frx":606E
         MousePointer    =   99  'Custom
         TabIndex        =   0
         Top             =   180
         Width           =   1155
      End
      Begin VB.TextBox txtNombre 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   975
         MaxLength       =   40
         TabIndex        =   3
         Top             =   525
         Width           =   5115
      End
      Begin VB.TextBox txtDigito 
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   2280
         MaxLength       =   1
         TabIndex        =   1
         Top             =   195
         Width           =   285
      End
      Begin VB.ComboBox cmbTipoEmisor 
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
         Left            =   975
         Style           =   2  'Dropdown List
         TabIndex        =   6
         Top             =   1185
         Width           =   3270
      End
      Begin VB.TextBox txtGenerico 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   5265
         MaxLength       =   5
         TabIndex        =   2
         Top             =   195
         Width           =   825
      End
      Begin VB.ComboBox CmbLineas 
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
         ItemData        =   "Bacmntem.frx":6378
         Left            =   4725
         List            =   "Bacmntem.frx":6382
         Style           =   2  'Dropdown List
         TabIndex        =   5
         Top             =   840
         Width           =   1365
      End
      Begin BACControles.TXTNumero FLTCODIGO 
         Height          =   315
         Left            =   975
         TabIndex        =   4
         Top             =   855
         Width           =   900
         _ExtentX        =   1588
         _ExtentY        =   556
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0"
         Text            =   "0"
         Max             =   "99999"
      End
      Begin VB.Label Label 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
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
         ForeColor       =   &H80000007&
         Height          =   210
         Index           =   0
         Left            =   180
         TabIndex        =   16
         Top             =   240
         Width           =   270
      End
      Begin VB.Label Label 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
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
         ForeColor       =   &H80000007&
         Height          =   210
         Index           =   1
         Left            =   180
         TabIndex        =   15
         Top             =   555
         Width           =   660
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
         Left            =   2145
         TabIndex        =   14
         Top             =   195
         Width           =   75
      End
      Begin VB.Label Label 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         Caption         =   "Código"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   210
         Index           =   7
         Left            =   195
         TabIndex        =   13
         Top             =   885
         UseMnemonic     =   0   'False
         Width           =   585
      End
      Begin VB.Label Label 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         Caption         =   "Tipo"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   210
         Index           =   5
         Left            =   180
         TabIndex        =   12
         Top             =   1230
         UseMnemonic     =   0   'False
         Width           =   360
      End
      Begin VB.Label Label 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         Caption         =   "Genérico"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   210
         Index           =   2
         Left            =   4380
         TabIndex        =   11
         Top             =   225
         UseMnemonic     =   0   'False
         Width           =   750
      End
      Begin VB.Label Label 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         Caption         =   "Afecto a Lineas"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   210
         Index           =   3
         Left            =   3315
         TabIndex        =   10
         Top             =   900
         UseMnemonic     =   0   'False
         Width           =   1275
      End
   End
End
Attribute VB_Name = "BacMntEm"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim Datos()
Dim OptLocal    As String
Dim cSql        As String
Dim dEmcodigo   As Double
Dim cEmnombre   As String
Dim cEmgeneric  As String
Dim cEmdirecc   As String
Dim dEmcomuna   As Double
Dim dEmtipo     As Double

Function EliminarEmisor(xRut As Double) As Boolean
On Error GoTo ErrEliminar

    EliminarEmisor = False
    
  ' ====================================================
    
    
    'cSql = "EXECUTE sp_elimina_emisor " & xRut
    
    Envia = Array()
    
    AddParam Envia, CDbl(xRut)
    
    If BAC_SQL_EXECUTE("sp_elimina_emisor", Envia) Then
        
        Do While BAC_SQL_FETCH(Datos())
            
            If Datos(1) = "NO" Then
                
                Call Grabar_Log("BTR", gsBAC_User, gsbac_fecp, "Problemas al eliminar emisor")
                MsgBox "Problemas en eliminación de emisor ", vbCritical
                Exit Function
            
            ElseIf Datos(1) = "NN" Then
                MsgBox "No puede borrar emisor debido a relación en tablas ", vbCritical
                Exit Function
            End If
            
        
        Loop
    
    End If
    
    'Call Grabar_Log("BTR", gsBAC_User, gsbac_fecp, "Eliminación de emisor " & TxtNombre.Text & ", realizado satisfactoriamente.")
    Call LogAuditoria("07", OptLocal, Me.Caption, "", "")
    
    EliminarEmisor = True
    Exit Function

ErrEliminar:
    Call Grabar_Log("BTR", gsBAC_User, gsbac_fecp, "Eliminación de emisor ha fallado")
    MsgBox "Problemas  en eliminación de emisor: " & err.Description, vbCritical
    Exit Function
End Function

Function EmisorLeerPorRut(parEdRut As Double) As Boolean

    EmisorLeerPorRut = False
    
'    cSql = "EXECUTE sp_trae_emisor " & parEdRut
    
    Envia = Array()
    
    AddParam Envia, parEdRut
    

    If Not BAC_SQL_EXECUTE("sp_trae_emisor", Envia) Then Exit Function
    
    If Not BAC_SQL_FETCH(Datos()) Then Exit Function
      If Datos(1) = "EXISTE" Then
        MsgBox Datos(2), vbInformation
         Call LimpiarEm
         Toolbar1.Buttons(3).Enabled = False
        Exit Function
      End If
    dEmcodigo = Val(Datos(1))
    cEmnombre = Datos(4)
    cEmgeneric = Datos(5)
    dEmtipo = Val(Datos(8))
    CmbLineas.Text = Datos(11)

    Toolbar1.Buttons(3).Enabled = True
    
    EmisorLeerPorRut = True
    
End Function


Function GrabarEmisor() As Boolean
Dim gsbac_fecp

On Error GoTo ErrGrabar


    Screen.MousePointer = vbHourglass
    
    GrabarEmisor = False

    Envia = Array()
    
    AddParam Envia, CDbl(txtRut.Text)
    AddParam Envia, txtDigito.Text
    AddParam Envia, TxtNombre
    AddParam Envia, txtGenerico.Text
    AddParam Envia, ""
    AddParam Envia, 0
    AddParam Envia, Trim(right(cmbTipoEmisor.Text, 5))
    AddParam Envia, CDbl(FLTCODIGO.Text)
    AddParam Envia, left(CmbLineas.Text, 1)
    
    
    If BAC_SQL_EXECUTE("Sp_Graba_Emisor ", Envia) Then
        
        Do While BAC_SQL_FETCH(Datos())
            
            If Datos(1) = "NO" Then
                
                MsgBox "No se pudo completar la grabación", vbOKOnly + vbExclamation
                LogAuditoria "01", OptLocal, Me.Caption + " No se pudo completar la grabación", "", ""
                Screen.MousePointer = vbDefault
                Exit Function
            
            ElseIf Datos(1) = "GENERICO" Then
            
                MsgBox Datos(2), vbExclamation
                Screen.MousePointer = vbDefault
                Exit Function
            
            End If
        
        Loop
    Else
      Exit Function
    
    End If
    
   ' Call Grabar_Log("BTR", gsBAC_User, gsbac_fecp, "Operación de grabación de emisores realizada satisfactoriamente.")
    

    GrabarEmisor = True
    MsgBox "Grabación de emisor realizado correctamente.", vbInformation
    
    Screen.MousePointer = vbDefault
    Exit Function

ErrGrabar:
    Screen.MousePointer = vbDefault

    MsgBox "Error : " & err.Description, vbOKOnly + vbCritical
    Exit Function
End Function

Private Sub LimpiaControles()

    txtRut.Enabled = True
    CmbLineas.ListIndex = -1
    txtRut.Text = ""
    txtDigito.Text = ""
    TxtNombre.Text = ""
    txtGenerico.Text = ""
    FLTCODIGO.Text = 0
    TxEtipo.Text = ""
    cmbTipoEmisor.ListIndex = -1
    
    PROC_HABILITA_CONTROLES False
    
End Sub


Private Function ValidaDatos() As Boolean

    ValidaDatos = False
    
    If Trim(TxtNombre.Text) = "" Then
        MsgBox "El nombre del emisor está vacio ", vbExclamation
        Exit Function
    End If

    If Trim(txtGenerico.Text) = "" Then
        MsgBox "El nombre genérico del emisor está vacio", vbExclamation
        Exit Function
    End If

    If Trim(cmbTipoEmisor.Text) = "" Then
        MsgBox "Emisor debe tener asociado un tipo", vbExclamation
        Exit Function
    End If

    If Val(FLTCODIGO.Text) = 0 Then
        MsgBox "El código del emisor está vacio", vbExclamation
        Exit Function
    End If
    
    ValidaDatos = True

End Function


Private Sub CmbLineas_KeyPress(KeyAscii As Integer)

   If KeyAscii = 13 Then
       'txtNombre.SetFocus
   End If

End Sub

Private Sub cmbTipoEmisor_Change()
'FLTCODIGO.SetFocus
End Sub

Private Sub cmbTipoEmisor_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = 13 Then
    'FLTCODIGO.SetFocus
End If
End Sub

Private Sub cmdEliminar_Click()
On Error GoTo Label1


    If MsgBox("¿ Esta seguro de eliminar emisor ?", vbYesNo) = vbYes Then
       
        Screen.MousePointer = vbHourglass
        If EliminarEmisor(txtRut.Text) Then
            MsgBox "El emisor ha sido eliminado", vbOKOnly + vbInformation
            Call LimpiarEm
        Else
            MsgBox "No se pudo eliminar el emisor", vbCritical
        End If
        Screen.MousePointer = vbDefault
        
    End If

    Exit Sub

Label1:
    Screen.MousePointer = vbDefault
    MsgBox "No se pudo realizar eliminación de emisor: " & err.Description, vbCritical
    Exit Sub
End Sub

Private Sub cmdGrabar_Click()
Dim IdNum   As Long
Dim Datos()

On Error GoTo Label1

    If Not ValidaDatos Then
        Exit Sub
    End If
    
    Screen.MousePointer = vbHourglass
    If GrabarEmisor Then
        Call LimpiarEm
    Else
        MsgBox "No se pudo completar la granbación", vbOKOnly + vbExclamation
    End If
    Screen.MousePointer = vbDefault

      
Exit Sub

Label1:
   Screen.MousePointer = 0
   MsgBox "Error : " & err.Description, vbOKOnly + vbCritical
   Exit Sub
End Sub

Private Sub LimpiarEm()

    Screen.MousePointer = 0
       
    PROC_HABILITA_CONTROLES False
    
    Call LimpiaControles
    
    txtRut.SetFocus

End Sub


Private Sub cmdlimpiar_Click()
Call LimpiarEm
End Sub

Private Sub cmdSalir_Click()
        Unload Me
End Sub

Private Sub data1_Error(DataErr As Integer, Response As Integer)
 MsgBox DataErr, vbCritical
End Sub

Private Sub FLTCODIGO_KeyPress(KeyAscii As Integer)
   
   If KeyAscii = 13 Then
       'CmbLineas.SetFocus
   End If

End Sub


Private Sub Form_Activate()
   PROC_CARGA_AYUDA Me, " "
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
Dim opcion As Integer


   If KeyCode = vbKeyReturn Then
      KeyCode = 0
      Bac_SendKey vbKeyTab
      Exit Sub
   
   End If


If KeyCode <> vbKeyControl And (Shift = 2 Or (Shift = 0 And (KeyCode = vbKeyReturn Or KeyCode = vbKeyEscape Or (KeyCode >= vbKeyF1 And KeyCode <= vbKeyF12)))) Then

opcion = 0
   Select Case KeyCode

         Case vbKeyLimpiar
               opcion = 1

         Case vbKeyGrabar
               opcion = 2
         
         Case vbKeyEliminar
               opcion = 3

         Case vbKeyBuscar
               opcion = 4
         
         Case vbKeySalir
               opcion = 5
   End Select

   If opcion <> 0 Then
      If Toolbar1.Buttons(opcion).Enabled Then
         Call Toolbar1_ButtonClick(Toolbar1.Buttons(opcion))
      End If

   End If

End If

End Sub

Private Sub Form_Load()
   OptLocal = Opt
    Me.top = 0
    Me.left = 0

Me.Icon = BAC_Parametros.Icon

On Error GoTo Label1

    If Not Llenar_Combos(cmbTipoEmisor, 0) Then
        MsgBox "No existen tipos de emisor definidos", vbExclamation
        Exit Sub
    End If
      
    PROC_HABILITA_CONTROLES False

    CmbLineas.ListIndex = 0

    Toolbar1.Buttons(3).Enabled = False
   
   
    txtRut.Enabled = True
    
   
    LogAuditoria "07", OptLocal, Me.Caption, "", ""
    
    Exit Sub

Label1:
    
    MsgBox "Problemas en enlace de tablas de emisores: " & err.Description, vbCritical
    Unload Me
    Exit Sub
    
End Sub

Private Sub Form_Unload(Cancel As Integer)
    Call LogAuditoria("08", OptLocal, Me.Caption, "", "")
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Index
   Case 1
         Call LimpiarEm
         Toolbar1.Buttons(3).Enabled = False
   Case 2
         Dim IdNum   As Long
         Dim Datos()

On Error GoTo Label1

    If Not ValidaDatos Then
        Exit Sub
    End If

    Screen.MousePointer = vbHourglass
    If GrabarEmisor Then
        LogAuditoria "01", OptLocal, Me.Caption, "", "Rut: " & txtRut.Text + "-" + txtDigito.Text & " Generico: " & txtGenerico.Text & " Tipo: " & cmbTipoEmisor.Text & " Codigo: " & FLTCODIGO.Text & " Afecto a lineas: " & CmbLineas.Text
        Call LimpiarEm
        Toolbar1.Buttons(3).Enabled = False
    End If
    Screen.MousePointer = vbDefault

      
Exit Sub

Label1:
   Screen.MousePointer = 0
   MsgBox "Error : " & err.Description, vbOKOnly + vbCritical
   LogAuditoria "01", OptLocal, Me.Caption + " Error al grabar- Rut: " & txtRut.Text + "-" + txtDigito.Text & " Generico: " & txtGenerico.Text & " Tipo: " & cmbTipoEmisor.Text & " Codigo: " & FLTCODIGO.Text & " Afecto a lineas: " & CmbLineas.Text, "", ""
   Exit Sub
   
   Case 3
        On Error GoTo Label11
        
        If Val(FLTCODIGO.Text) = 0 Then
            MsgBox "El código del emisor está vacio", vbExclamation
            Exit Sub
        End If

        
        If MsgBox("¿ Esta seguro de eliminar emisor " & TxtNombre.Text & " ?", vbInformation + vbYesNo) = vbYes Then
       
        Screen.MousePointer = vbHourglass
        If EliminarEmisor(txtRut.Text) Then
            MsgBox "El emisor ha sido eliminado", vbOKOnly + vbInformation
            LogAuditoria "03", OptLocal, Me.Caption, "Rut: " & txtRut.Text + "-" + txtDigito.Text & " Generico: " & txtGenerico.Text & " Tipo: " & cmbTipoEmisor.Text & " Codigo: " & FLTCODIGO.Text & " Afecto a lineas: " & CmbLineas.Text, ""
            Call LimpiarEm
            Toolbar1.Buttons(3).Enabled = False
        Else
            MsgBox "No se pudo eliminar el emisor", vbCritical
            LogAuditoria "03", OptLocal, Me.Caption + " Error al eliminar- Rut: " & txtRut.Text + "-" + txtDigito.Text & " Generico: " & txtGenerico.Text & " Tipo: " & cmbTipoEmisor.Text & " Codigo: " & FLTCODIGO.Text & " Afecto a lineas: " & CmbLineas.Text, "", ""
        End If
        Screen.MousePointer = vbDefault
        
        End If

        Exit Sub

Label11:
    Screen.MousePointer = vbDefault
    MsgBox "No se pudo realizar eliminación de emisor: " & err.Description, vbCritical
    LogAuditoria "03", OptLocal, Me.Caption + " Error al eliminar- Rut: " & txtRut.Text + "-" + txtDigito.Text & " Generico: " & txtGenerico.Text & " Tipo: " & cmbTipoEmisor.Text & " Codigo: " & FLTCODIGO.Text & " Afecto a lineas: " & CmbLineas.Text, "", ""
    Exit Sub
   
   Case 4
         txtRut_KeyPress vbKeyReturn

   Case 5
         Unload Me
End Select
End Sub

Private Sub txtDigito_KeyPress(KeyAscii As Integer)
    BacCaracterNumerico KeyAscii
    PROC_HABILITA_CONTROLES True
    'If KeyAscii = 13 Then txtNombre.SetFocus
   
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
        MsgBox "El rut ingresado no es válido", vbExclamation
        txtDigito.Text = ""
        'txtDigito.SetFocus
        Exit Sub
    End If

    txtRut.Enabled = False
    txtDigito.Enabled = False
    Toolbar1.Buttons(1).Enabled = True
    
    If EmisorLeerPorRut(txtRut.Text) = True Then
        FLTCODIGO.Text = dEmcodigo
        TxtNombre.Text = cEmnombre
        txtGenerico.Text = cEmgeneric
        cmbTipoEmisor.ListIndex = BuscaEnCombo(cmbTipoEmisor, Str(dEmtipo), "C")
        Toolbar1.Buttons(2).Enabled = True
    
            
    
    Else
        If Trim(txtRut.Text) <> "" Then
         PROC_HABILITA_CONTROLES True
        End If
        Exit Sub
    End If
    
    PROC_HABILITA_CONTROLES True
    
    If txtGenerico.Enabled Then
      txtGenerico.SetFocus
    
    End If
    

Exit Sub

Label1:
    MsgBox "Error : " & err.Description, vbOKOnly + vbCritical
 
 Exit Sub

End Sub





Private Sub txtGenerico_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = 13 Then
    'cmbTipoEmisor.SetFocus
End If
End Sub

Private Sub txtGenerico_KeyPress(KeyAscii As Integer)

    BacToUCase KeyAscii
    KeyAscii = Caracter(KeyAscii)
    
End Sub


Private Sub TxtNombre_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = 13 Then
    'txtGenerico.SetFocus
End If
End Sub

Private Sub txtNombre_KeyPress(KeyAscii As Integer)

    BacToUCase KeyAscii
    KeyAscii = Caracter(KeyAscii)
       
End Sub


Private Sub txtRut_DblClick()

On Error GoTo Label1

    Call LimpiarEm
    MiTag = "MDEM"
    BacAyuda.Show 1
    If giAceptar% = True Then
        Call LimpiaControles
        txtRut.Text = gsCodigo$
        txtDigito.Text = gsDigito$
        TxtNombre = gsDescripcion$
                'gsGenerico$


        txtDigito_LostFocus
        
        If TxtNombre.Enabled Then
        
            'txtNombre.SetFocus
        
        End If
        
    End If

Exit Sub

Label1:
  MsgBox "Error : " & err.Description, vbOKOnly + vbCritical
  Exit Sub
End Sub

Private Sub txtRut_KeyDown(KeyCode As Integer, Shift As Integer)
On Error GoTo Label1
   If KeyCode = vbKeyF3 Then
      Call LimpiarEm
      MiTag = "MDEM"
      BacAyuda.Show 1
      If giAceptar% = True Then
         Call LimpiaControles
         txtRut.Text = gsCodigo$
         txtDigito.Text = gsDigito$
         SendKeys "{ENTER}"
      End If
      Exit Sub
Label1:
      MsgBox "Error : " & err.Description, vbOKOnly + vbCritical
      Exit Sub
End If
End Sub

Private Sub txtRut_KeyPress(KeyAscii As Integer)

    If Not IsNumeric(Chr(KeyAscii)) And KeyAscii <> 8 And KeyAscii <> 13 Then
       KeyAscii = 0
    End If

    BacCaracterNumerico KeyAscii
    
    If KeyAscii = 13 Then
      
      txtDigito = BacDevuelveDig(txtRut.Text)
      Call txtDigito_LostFocus
      'txtcodcli.SetFocus
      If TxtNombre.Text = "" Then
      
'         MsgBox "El Cliente Ingresado No Existe", vbExclamation
'         Call LimpiarEm
'         Call LimpiaControles
'         txtrut.SetFocus
      End If
    End If
    
   If txtGenerico.Enabled Then
   
      DoEvents
      txtGenerico.SetFocus
   
   End If
    
End Sub


Public Function BacDevuelveDig(Rut As String) As String

   Dim i       As Integer
   Dim D       As Integer
   Dim Divi    As Long
   Dim Suma    As Long
   Dim Digito  As String
   Dim Multi   As Double

   BacDevuelveDig = ""
    
   Rut = Format(Rut, "00000000")
   D = 2
   For i = 8 To 1 Step -1
      Multi = Val(Mid$(Rut, i, 1)) * D
     Suma = Suma + Multi
      D = D + 1
      
      If D = 8 Then
         D = 2
      
      End If
   Next i
    
   Divi = (Suma \ 11)
   Multi = Divi * 11
   Digito = Trim$(Str$(11 - (Suma - Multi)))
    
   If Digito = "10" Then
      Digito = "K"
   
   End If
    
   If Digito = "11" Then
      Digito = "0"
   
   End If
    
   BacDevuelveDig = UCase(Digito)

End Function


Sub PROC_HABILITA_CONTROLES(nEstado)

   txtRut.Enabled = Not nEstado
   
   TxtNombre.Enabled = nEstado
   txtGenerico.Enabled = nEstado
   cmbTipoEmisor.Enabled = nEstado
   FLTCODIGO.Enabled = nEstado
   CmbLineas.Enabled = nEstado

   Toolbar1.Buttons(2).Enabled = nEstado
   Toolbar1.Buttons(4).Enabled = Not nEstado
   
End Sub


