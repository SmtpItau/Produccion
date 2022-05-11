VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Begin VB.Form Bac_Tabla_Desarrollo 
   Caption         =   "Listado de Tabla Desarrollo"
   ClientHeight    =   1320
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   3750
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   1320
   ScaleWidth      =   3750
   Begin Threed.SSPanel Panel 
      Height          =   795
      Index           =   1
      Left            =   0
      TabIndex        =   0
      Top             =   525
      Width           =   4845
      _Version        =   65536
      _ExtentX        =   8546
      _ExtentY        =   1402
      _StockProps     =   15
      ForeColor       =   -2147483640
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Alignment       =   1
      Begin VB.TextBox txtMascara 
         ForeColor       =   &H00800000&
         Height          =   315
         Left            =   1785
         MaxLength       =   10
         MouseIcon       =   "Bac_tabla_Desarrollo.frx":0000
         MousePointer    =   99  'Custom
         TabIndex        =   2
         Top             =   345
         Width           =   1335
      End
      Begin VB.TextBox txtFamilia 
         ForeColor       =   &H00800000&
         Height          =   315
         Left            =   90
         MaxLength       =   8
         MouseIcon       =   "Bac_tabla_Desarrollo.frx":030A
         MousePointer    =   99  'Custom
         TabIndex        =   1
         Top             =   345
         Width           =   1335
      End
      Begin VB.Label Label 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Familia"
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
         Index           =   0
         Left            =   480
         TabIndex        =   5
         Top             =   105
         Width           =   600
      End
      Begin VB.Label Label 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Máscara"
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
         Index           =   1
         Left            =   2025
         TabIndex        =   3
         Top             =   105
         Width           =   735
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   4
      Top             =   0
      Width           =   3750
      _ExtentX        =   6615
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      DisabledImageList=   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Imprimir"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   2580
      Top             =   150
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
            Picture         =   "Bac_tabla_Desarrollo.frx":0614
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bac_tabla_Desarrollo.frx":0938
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bac_tabla_Desarrollo.frx":0C5C
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "Bac_Tabla_Desarrollo"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim Sql As String
Dim Datos()
Public xincodigo As Double
Public xMascara As String

Function LeerFamilia(xFamilia As String) As Boolean
Dim Cont As Single

    LeerFamilia = False
    Cont = 0
    Envia = Array()
    AddParam Envia, Trim(txtFamilia.Text)
    
    If Bac_Sql_Execute("SP_TRAE_INSTRUMENTOS", Envia) Then
        Do While Bac_SQL_Fetch(Datos())
            Cont = Cont + 1
            'xinserie = Datos(1)
            xincodigo = Datos(3)
            'xinrutemi = Datos(6)
            'xinmonemi = Datos(7)
           ' xinbasemi = Datos(8)
           ' xintipfec = Datos(14)
           ' xinmdpr = Datos(12)
           ' xinmdtd = Datos(13)
           ' xrefnomi = Datos(5)
           ' cmdTabDes.Enabled = IIf(xinmdtd = "S", True, False)
           ' cmdTabPre.Enabled = IIf(xinmdpr = "S", True, False)
        
        
        Loop
    Else
        Exit Function
    End If
    
    If Cont = 0 Then
        Exit Function
    End If
    
    LeerFamilia = True

End Function

Sub Familia()

   On Error GoTo Label1
    BacAyuda.Tag = "MDIN"
    BacAyuda.Show 1
   If giAceptar% = True Then
      txtFamilia.Enabled = True
      txtFamilia.Text = gsSerie$
      txtFamilia.SetFocus
      SendKeys "{ENTER}"
   End If
   Exit Sub
Label1:
    MousePointer = 0
    MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical, TITSISTEMA
    Exit Sub

End Sub

Sub GENERAR_LISTADO()

On Error GoTo Control:

If Trim$(txtFamilia.Text) = "" Then
    MsgBox "Debe Ingresar familia  ", 64, TITSISTEMA
    Exit Sub
 End If

If Trim$(txtMascara.Text) = "" Then
    MsgBox "Debe Ingresar Mascara  ", 64, TITSISTEMA
    Exit Sub
 End If
 
'Else

    If Trim$(txtMascara.Text) <> "" Then
            If Not LeerSeries(Trim$(txtMascara.Text)) = True Then
                MsgBox "No Existe la Serie " & Trim$(txtMascara.Text), 64, TITSISTEMA
                Screen.MousePointer = 0
                Exit Sub
            'Else
            '    Toolbar1.Buttons(1).Enabled = True
            '    Exit Sub
            End If
       End If
'End If

   Call limpiar_cristal
   Screen.MousePointer = vbHourglass
   BACSwapParametros.BacParam.ReportFileName = gsRPT_Path & "LISMASCARA.RPT"
   BACSwapParametros.BacParam.WindowTitle = "LISTADO DE TABLA DE DESARROLLO"
   BACSwapParametros.BacParam.StoredProcParam(0) = Trim$(txtMascara.Text)
   BACSwapParametros.BacParam.Destination = 0
   BACSwapParametros.BacParam.Connect = SwConeccion
   BACSwapParametros.BacParam.Action = 1
   Screen.MousePointer = vbDefault

Exit Sub

Control:

    MsgBox "Problemas al generar Listado. " & Err.Description & ", " & Err.Number, vbCritical, "BACPARAMETROS"
    Screen.MousePointer = 0

End Sub

Function LeerSeries(xSerie As String) As Boolean
Dim Cont As Single
LeerSeries = False
Cont = 0
Envia = Array()
AddParam Envia, txtMascara

If Bac_Sql_Execute("SP_TRAE_SERIE", Envia) Then
   Do While Bac_SQL_Fetch(Datos())
    Cont = Cont + 1
        xMascara = Val(Datos(1))
        
     Loop
End If
If Cont = 0 Then
  Exit Function
End If
LeerSeries = True
End Function

Sub Mascara()

On Error GoTo Label2

      If txtFamilia.Text = "" Then Exit Sub
         BacAyuda.Tag = "MDSETD"
         BacAyuda.Show 1
      If giAceptar% = True Then
         'txtMascara.Enabled = True
         txtMascara.Text = BacAyuda.Mascara 'PENDIENTE
        'txtMascara.Enabled = False
      End If
      Exit Sub
Label2:
      MousePointer = 0
      MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical, TITSISTEMA
      Exit Sub


End Sub


Private Sub Form_Load()

    Me.Top = 0
    Me.Left = 0
    Me.Height = 1815
    Me.Width = 3765
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

If Button.Index = 1 Then
   Call GENERAR_LISTADO
End If
If Button.Index = 2 Then
    txtFamilia.Text = ""
    txtMascara.Text = ""
    txtFamilia.SetFocus
End If
If Button.Index = 3 Then
   Unload Me
End If
   



End Sub

Private Sub txtFamilia_DblClick()

   Call Familia

End Sub


Private Sub txtFamilia_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyF3 Then Call Familia
End Sub


Private Sub txtFamilia_KeyPress(KeyAscii As Integer)

    BacToUCase KeyAscii
    
End Sub

Private Sub txtFamilia_LostFocus()

On Error GoTo Label1
    'If txtFamilia.Text <> "lchr" Or txtFamilia.Text <> "LCHR" Then
    '   cmbTipoLetra.Enabled = False
    'End If
    If Trim(txtFamilia.Text) = "" Then Exit Sub
    
    If LeerFamilia(txtFamilia.Text) Then
        'If xincodigo <> 0 Then
        '    txtRutEmi.Text = xinrutemi
        '    Call txtRutEmi_LostFocus
        '    txtFamilia.Enabled = False
        'Else
        '    txtFamilia.Text = ""
        'End If
    Else
        MsgBox "Familia no existe", vbOKOnly + vbExclamation, TITSISTEMA
        txtFamilia.Text = ""
        txtFamilia.SetFocus
        Exit Sub
    End If

Exit Sub

Label1:
    MousePointer = 0
    MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical, TITSISTEMA
    Exit Sub


End Sub

Private Sub txtMascara_DblClick()

   Call Mascara
   
End Sub

Private Sub txtMascara_KeyDown(KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyF3 Then Call Mascara
   
End Sub

Private Sub txtMascara_KeyPress(KeyAscii As Integer)

    
  BacToUCase KeyAscii
   ' If Not KeyAscii = 13 Then
   '    Exit Sub
   ' End If
    
      

'    BacToUCase KeyAscii
    
'    If Not KeyAscii = 13 Then
'       Exit Sub
'    End If
       
    
       
'    If objInfSerie.LeerSerie(Trim$(txtMascara.Text)) = True Then
'            txtMascara.Text = objInfSerie.semascara
'            If Trim$(objInfSerie.semascara) <> "" Then
               
'            Else
'               MsgBox "No Existe La Serie " & Trim$(txtMascara.Text), 64, TITSISTEMA
'               Exit Sub
'            End If
'    Else
'            Call objInfMensajesSE.BacLeeMensaje(objInfMensajesSE.MSG_SEConeccion)
'            txtMascara.Text = ""
'            txtMascara.SetFocus
'    End If
 

End Sub

