VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "threed32.ocx"
Object = "{00025600-0000-0000-C000-000000000046}#5.2#0"; "Crystl32.OCX"
Begin VB.MDIForm Menu_Principal 
   BackColor       =   &H8000000F&
   Caption         =   "Control de Accesos de Usuarios"
   ClientHeight    =   8115
   ClientLeft      =   1995
   ClientTop       =   2055
   ClientWidth     =   11880
   Icon            =   "Menu_Principal.frx":0000
   LinkTopic       =   "MDIForm1"
   Picture         =   "Menu_Principal.frx":2EFA
   WindowState     =   2  'Maximized
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   11340
      Top             =   -60
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   24
      ImageHeight     =   24
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   8
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Menu_Principal.frx":9084
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Menu_Principal.frx":956E
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Menu_Principal.frx":9A13
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Menu_Principal.frx":9EA1
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Menu_Principal.frx":A3D8
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Menu_Principal.frx":A863
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Menu_Principal.frx":ACE6
            Key             =   ""
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Menu_Principal.frx":B13D
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin VB.Timer Timer1 
      Interval        =   5000
      Left            =   1650
      Top             =   7050
   End
   Begin Crystal.CrystalReport REPORT 
      Left            =   960
      Top             =   7050
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   348160
      WindowState     =   2
      PrintFileLinesPerPage=   60
   End
   Begin Threed.SSPanel PnlInfo 
      Align           =   2  'Align Bottom
      Height          =   420
      Left            =   0
      TabIndex        =   0
      Top             =   7695
      Width           =   11880
      _Version        =   65536
      _ExtentX        =   20955
      _ExtentY        =   741
      _StockProps     =   15
      ForeColor       =   8421504
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Times New Roman"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      RoundedCorners  =   0   'False
      Outline         =   -1  'True
      Alignment       =   8
      Begin Threed.SSPanel PnlEstado 
         Height          =   315
         Left            =   65
         TabIndex        =   1
         Top             =   60
         Width           =   4000
         _Version        =   65536
         _ExtentX        =   7056
         _ExtentY        =   556
         _StockProps     =   15
         ForeColor       =   -2147483641
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   9.01
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BevelOuter      =   1
         Alignment       =   1
      End
      Begin Threed.SSPanel Pnl_UF 
         Height          =   315
         Left            =   6765
         TabIndex        =   2
         Top             =   60
         Width           =   1980
         _Version        =   65536
         _ExtentX        =   3492
         _ExtentY        =   556
         _StockProps     =   15
         ForeColor       =   -2147483641
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   9.01
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BorderWidth     =   1
         BevelOuter      =   1
         RoundedCorners  =   0   'False
      End
      Begin Threed.SSPanel PnlUsuario 
         Height          =   315
         Left            =   4065
         TabIndex        =   3
         Top             =   60
         Width           =   2685
         _Version        =   65536
         _ExtentX        =   4736
         _ExtentY        =   556
         _StockProps     =   15
         ForeColor       =   -2147483639
         BackColor       =   -2147483646
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   9.01
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BorderWidth     =   1
         BevelOuter      =   1
         RoundedCorners  =   0   'False
      End
      Begin Threed.SSPanel PnlFecha 
         Height          =   315
         Left            =   10635
         TabIndex        =   4
         Top             =   60
         Width           =   1470
         _Version        =   65536
         _ExtentX        =   2593
         _ExtentY        =   556
         _StockProps     =   15
         ForeColor       =   -2147483641
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   9
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BorderWidth     =   1
         BevelOuter      =   1
         RoundedCorners  =   0   'False
         Autosize        =   3
      End
      Begin Threed.SSPanel Pnl_DO 
         Height          =   315
         Left            =   8760
         TabIndex        =   5
         Top             =   60
         Width           =   1860
         _Version        =   65536
         _ExtentX        =   3281
         _ExtentY        =   556
         _StockProps     =   15
         ForeColor       =   -2147483641
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   9.01
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BorderWidth     =   1
         BevelOuter      =   1
         RoundedCorners  =   0   'False
      End
   End
   Begin MSComctlLib.ImageList ILST_ImagenesMDI 
      Left            =   240
      Top             =   6960
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   1024
      ImageHeight     =   768
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   2
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Menu_Principal.frx":B58B
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Menu_Principal.frx":11725
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   6
      Top             =   0
      Width           =   11880
      _ExtentX        =   20955
      _ExtentY        =   794
      ButtonWidth     =   3149
      ButtonHeight    =   794
      Style           =   1
      TextAlignment   =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   11
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Tipo Usuarios  "
            Object.ToolTipText     =   "Tipo Usuarios"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Usuarios         "
            Object.ToolTipText     =   "Usuarios"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "B/D Usuarios     "
            Object.ToolTipText     =   "Bloqueo de Usuarios"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button7 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Privilegios  T.       "
            Object.Tag             =   "Privilegios de Usuario"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button8 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button9 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Clave Admin     "
            Object.ToolTipText     =   "Cambiar Clave Administrador"
            ImageIndex      =   6
         EndProperty
         BeginProperty Button10 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button11 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Privilegios U.      "
            ImageIndex      =   8
         EndProperty
      EndProperty
   End
   Begin VB.Menu Opcion_004 
      Caption         =   "Administración"
      Begin VB.Menu Opcion_005 
         Caption         =   "Tipos de Usuarios"
      End
      Begin VB.Menu Opcion_006 
         Caption         =   "Usuarios"
      End
      Begin VB.Menu Raya1 
         Caption         =   "-"
      End
      Begin VB.Menu Opcion_008 
         Caption         =   "Asignar Privilegios a Tipos de Usuarios"
      End
      Begin VB.Menu Opcion_009 
         Caption         =   "Asignar Privilegios Especiales a Usuarios"
      End
      Begin VB.Menu Raya4 
         Caption         =   "-"
      End
      Begin VB.Menu Opcion_010 
         Caption         =   "Cambio de Clave Administrador"
      End
      Begin VB.Menu Raya5 
         Caption         =   "-"
      End
      Begin VB.Menu Opcion_007 
         Caption         =   "Bloqueo/Desbloqueo de Usuarios"
      End
      Begin VB.Menu Opcion_014 
         Caption         =   "Control de Bloqueo de Usuarios"
         Enabled         =   0   'False
         Visible         =   0   'False
      End
      Begin VB.Menu Opcion_013 
         Caption         =   "Informe de LOG"
         Enabled         =   0   'False
         Visible         =   0   'False
      End
      Begin VB.Menu Raya_11 
         Caption         =   "-"
      End
      Begin VB.Menu Opcion_016 
         Caption         =   "Control de Switch Operativos"
         Enabled         =   0   'False
         Visible         =   0   'False
      End
      Begin VB.Menu Opcion_017 
         Caption         =   "Mensajeria Switch Operativo"
         Enabled         =   0   'False
         Visible         =   0   'False
      End
   End
   Begin VB.Menu Opcion_003 
      Caption         =   "Salir"
   End
   Begin VB.Menu Opcion_011 
      Caption         =   "?"
      Visible         =   0   'False
   End
   Begin VB.Menu Opc 
      Caption         =   "Opciones"
      Visible         =   0   'False
      Begin VB.Menu CamPassPopup 
         Caption         =   "Cambio de Password"
      End
      Begin VB.Menu A 
         Caption         =   "-"
      End
      Begin VB.Menu CreaUsuPopup 
         Caption         =   "Crear Usuarios"
      End
      Begin VB.Menu AsigPrivPopup 
         Caption         =   "Asignar Privilegios Especiales a Usuarios"
      End
   End
End
Attribute VB_Name = "Menu_Principal"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim clsWall As New CLS_Wallpaper

Sub MENU_TODOHABILITADO()
    Dim I%
    ' HABILITA TODAS LAS OPCIONES DEL MENU
    For I% = 0 To Me.Controls.Count - 1

        If TypeOf Me.Controls(I%) Is Menu Then
       
            If Me.Controls(I%).Caption <> "-" And Me.Controls(I%).Caption <> "?" And Me.Controls(I%).Caption <> "Salir" Then
                Me.Controls(I%).Enabled = True
            End If
       
        End If
    
        If TypeOf Me.Controls(I%) Is CommandButton Then Me.Controls(I%).Enabled = True

    Next I%
End Sub

Sub PROC_CARGA_PRIVILEGIOS()
Dim Datos()
Dim I%
Dim Comando As String

If Trim(gsBAC_User) = "ADMINISTRA" Then
    Call MENU_TODOHABILITADO
    Exit Sub
End If



Envia = Array("T", "SPT", gsBac_Tipo_Usuario)

If Not BAC_SQL_EXECUTE("SP_BUSCA_PRIVILEGIOS ") Then Exit Sub

' BUSCA LAS OPCIONES POR TIPO DE USUARIO

Do While BAC_SQL_FETCH(Datos())

   For I% = 0 To Me.Controls.Count - 1

       If TypeOf Me.Controls(I%) Is Menu Then
       
          If Trim(Me.Controls(I%).Name) = Trim(Datos(1)) Then Me.Controls(I%).Enabled = True
       
       End If
       
       If TypeOf Me.Controls(I%) Is CommandButton Then
       
          If Trim(Me.Controls(I%).Name) = "B" + Trim(Datos(1)) Then Me.Controls(I%).Enabled = True
       
       End If

   Next I%

Loop

' BUSCA LAS OPCIONES POR USUARIO


Envia = Array("U", "SPT", gsBAC_User)

If Not BAC_SQL_EXECUTE("SP_BUSCA_PRIVILEGIOS") Then
   Exit Sub
End If

' BUSCA LAS OPCIONES DEL USUARIO Y LAS HABILITA

Do While BAC_SQL_FETCH(Datos())

   For I% = 0 To Me.Controls.Count - 1

       If TypeOf Me.Controls(I%) Is Menu Then
       
          If Trim(Me.Controls(I%).Name) = Trim(Datos(1)) Then Me.Controls(I%).Enabled = IIf(Mid(Datos(2), 1, 1) = "N", False, True)
          
       End If
       
       If TypeOf Me.Controls(I%) Is CommandButton Then
       
          If Trim(Me.Controls(I%).Name) = "B" + Trim(Datos(1)) Then Me.Controls(I%).Enabled = IIf(Mid(Datos(2), 1, 1) = "N", False, True)
       
       End If

   Next I%

Loop

End Sub

Sub DESHABILITA_MENU()
    Dim I%
    ' DESHABILITA TODAS LAS OPCIONES DEL MENU
    For I% = 0 To Me.Controls.Count - 1

        If TypeOf Me.Controls(I%) Is Menu Then
       
            If Me.Controls(I%).Caption <> "-" And Me.Controls(I%).Caption <> "?" And Me.Controls(I%).Caption <> "Salir" Then
                Me.Controls(I%).Enabled = False
            End If
       
        End If
    
        If TypeOf Me.Controls(I%) Is CommandButton Then Me.Controls(I%).Enabled = False

    Next I%
End Sub

Sub PROC_GENERA_MENU(Entidad As String)
Dim Sql         As String
Dim Indice      As Integer: Indice = 1
Dim Primera_Vez As String: Primera_Vez = "S"
Dim I%

For I% = 0 To Me.Controls.Count - 1

    If TypeOf Me.Controls(I%) Is Menu Then
       
       If Me.Controls(I%).Caption <> "-" And Me.Controls(I%).Caption <> "?" And Me.Controls(I%).Visible And Me.Controls(I%).Caption <> "Salir" Then
       
          Indice = Indice + 1
          
          Envia = Array(Primera_Vez, _
                        Entidad, _
                        Str(Indice), _
                        Me.Controls(I%).Caption, _
                        Me.Controls(I%).Name, _
                        Format(Me.Controls(I%).HelpContextID, "0"))
          
         If Not BAC_SQL_EXECUTE("SP_CARGA_GEN_MENU", Envia) Then
            Exit Sub
         End If
          
          Primera_Vez = "N"
       End If
       
    End If

Next I%

End Sub

Private Sub AsigPrivPopup_Click()
On Error Resume Next
  Privilegios_Usuarios.Show
On Error GoTo 0
End Sub

Private Sub asxToolbar1_ButtonClick(ByVal ButtonIndex As Integer, ByVal ButtonKey As String)

End Sub

Private Sub BOpcion_006_Click()
  Opcion_006_Click
End Sub

Private Sub BOpcion_007_Click()
  Opcion_007_Click
End Sub

Private Sub BOpcion_016_Click()
  Opcion_016_Click
End Sub

Private Sub BOpcion_017_Click()
   Opcion_017_Click
End Sub

Private Sub Bpcion_005_Click()
   Opcion_005_Click
End Sub

Private Sub CamPassPopup_Click()
Cambio_Clave.Show
End Sub

Private Sub CreaUsuPopup_Click()
On Error Resume Next
  Crea_Usuarios.Show
On Error GoTo 0
End Sub

Private Sub MDIForm_Activate()
    gsBAC_SNActiva = "N"
    montosimula = 0
    Screen.MousePointer = 0
    Me.Caption = "Accesos ( Sql Server ) " & gsSQL_Server & "/" & gsSQL_DataBase

    If Not Proc_Carga_Parametros Then
         MsgBox "Error al cargar parámetros", vbCritical
         Call LogAuditoria("05", "Acceso", Me.Caption + " Error al cargar Acceso", "", "")
         End
         Exit Sub
    End If
      
    'Activa el Login a BacCambio.-
    If Not gsBAC_Login Then
        Call DESHABILITA_MENU

        Timer1.Enabled = False

        Acceso_Control_Usuario.Show 1

        Timer1.Enabled = True

        If gsBAC_Login Then
            Screen.MousePointer = 11
            PROC_CARGA_PRIVILEGIOS
        Else
            Unload Me
            Exit Sub
        End If
    End If

   Me.PnlEstado.Caption = Space(1) + gsBAC_Clien
   Me.PnlFecha.Caption = Format(gsbac_fecp, gsc_FechaDMA)
   Me.Pnl_UF.Caption = "U.F. : " & Format(gsBAC_ValmonUF, FDecimal)
   Me.Pnl_DO.Caption = "D.O. : " & Format(gsBAC_DolarObs, FDecimal)
   Me.PnlUsuario.Caption = gsBAC_User

   Me.Caption = App.Title & " ( Sql Server ) " & gsSQL_Server & "/" & gsSQL_DataBase
   Screen.MousePointer = 0
End Sub

Private Sub MDIForm_Load()
   Micro = 0
   gs_Pusd = False
   Call DetectarResolucion(Me, Form1)
   
   Screen.MousePointer = 11
     
   If App.PrevInstance Then
      Screen.MousePointer = 0
      MsgBox "Sistema Esta Cargado en Memoria.", vbExclamation
      End
   End If
   
   If Not Valida_Configuracion_Regional() Then
      Screen.MousePointer = 0
      MsgBox "Debe cambiar el formato de fecha como dd/mm/aaaa antes de ejecutar el sistema.", vbCritical
      End
      
   End If
   
   PROC_ImagenFondo Me
   PROC_Wallpaper
    
   If Not BacInit Then ' Parametros de Inicio.-
      Screen.MousePointer = 0
      End
   End If
   
   If Not BAC_LOGIN(gsSQL_Login, gsSQL_Password) Then
      Screen.MousePointer = 0
      MsgBox "Problemas de Comunicación con el Servidor SQL", vbCritical
      End
   End If

   If Not DatosGenerales() Then
   
      Exit Sub
      
   End If

   Me.PnlEstado.Caption = Space(1) + gsBAC_Clien
   Me.PnlFecha.Caption = Format(gsbac_fecp, gsc_FechaDMA)
   Me.Pnl_UF.Caption = "U.F. : " & Format(gsBAC_ValmonUF, FDecimal)
   Me.Pnl_DO.Caption = "D.O. : " & Format(gsBAC_DolarObs, FDecimal)
   
   PROC_TITULO_MODULO "ADM", gsBac_Version
'   Call LogAuditoria("05", "Acceso", Me.Caption, "", "")

   Screen.MousePointer = 0
End Sub


Private Sub MDIForm_MouseDown(Button As Integer, Shift As Integer, x As Single, Y As Single)
If Button = 2 Then
  PopupMenu Opc, , , , CamPassPopup
End If
End Sub

Private Sub MDIForm_QueryUnload(Cancel As Integer, UnloadMode As Integer)
   If gsBAC_Login Then
      Cancel = (MsgBox("¿Seguro que desea Salir?", vbQuestion + vbYesNo) = vbNo)
   End If
End Sub


Private Sub MDIForm_Resize()

    Dim strError As String
    Call clsWall.CreateFormPicture(Me, 4, strError)
    
End Sub


Private Function PROC_RunningInIde() As Boolean

    Dim sClassName As String
    Dim nStrLen    As Long

    sClassName = String$(260, vbNullChar)
    nStrLen = GetClassName(Me.hwnd, sClassName, Len(sClassName))
    If nStrLen Then sClassName = left$(sClassName, nStrLen)
    
    PROC_RunningInIde = (sClassName = "ThunderMDIForm")
  
End Function




Private Sub PROC_Wallpaper()

    Dim strError As String
    
    With clsWall
        .TransparentColor = vbGreen
        .ExeName = App.Path & "\" & App.ExeName & ".exe"
        .RunningInIDE = PROC_RunningInIde
        .MDIForm = Me
        Call .CreateFormPicture(Me, 4, strError)
    End With
    
End Sub


Private Sub MDIForm_Unload(Cancel As Integer)
   If gsUsuario <> "" Then
      LogAuditoria "06", "Acceso", Me.Caption + " Salida del Sistema", "", ""
   End If
   Call DesconectarSql
End Sub




Private Sub Opcion_003_Click()
   Unload Me
End Sub

Private Sub Opcion_005_Click()
    Opt = "opcion_005"
    Crea_Tipos_Usuarios.Show
End Sub

Private Sub Opcion_006_Click()
   Opt = "opcion_006"
   On Error Resume Next
   Crea_Usuarios.Show
   On Error GoTo 0
End Sub

Private Sub Opcion_007_Click()
   Opt = "opcion_007"
   On Error Resume Next
   Bloq_Usuarios.Show
   On Error GoTo 0
End Sub

Private Sub Opcion_008_Click()
   Opt = "opcion_008"
   Privilegios_Tipos_Usuarios.Show
End Sub

Private Sub Opcion_009_Click()
   Opt = "opcion_009"
   On Error Resume Next
   Privilegios_Usuarios.Show
   On Error GoTo 0
End Sub

Private Sub Opcion_010_Click()
   Opt = "opcion_010"
    Cambio_Clave.Show
End Sub

Private Sub Opcion_011_Click()
   Opt = "opcion_011"
   Load Acerca
End Sub

Private Sub Opcion_013_Click()
   Opt = "opcion_013"
   InformeLOG.Show
End Sub

Private Sub Opcion_014_Click()
   Opt = "opcion_014"
    Control_Bloq_Usuarios.Show
End Sub

Private Sub Opcion_015_Click()
   Opt = "opcion_015"
   Compactacion.Show
End Sub

Private Sub Opcion_016_Click()
   Opt = "opcion_016"
    Switch_Operativo.Show
End Sub

Private Sub Opcion_017_Click()
   Opt = "opcion_017"
   FRM_REGLAS.Show
End Sub

Private Sub Boton_Ayuda_Click()
   Bac_SendKey vbKeyF1
End Sub

Private Sub Timer1_Timer()
    If DatosGenerales() Then
        gsBAC_Ingreso = True
    Else
        MsgBox "Error al Cargar Parametros", vbCritical
        Unload Me
        Exit Sub
    End If

    Me.PnlEstado.Caption = Space(1) + gsBAC_Clien
    Me.PnlFecha.Caption = Format(gsbac_fecp, gsc_FechaDMA)
    Me.Pnl_UF.Caption = "U.F. : " & Format(gsBAC_ValmonUF, FDecimal)
    Me.Pnl_DO.Caption = "D.O. : " & Format(gsBAC_DolarObs, FDecimal)
    Me.PnlUsuario.Caption = gsBAC_User

End Sub
Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
    If Button.Index = 1 Then
        Opcion_005_Click
    ElseIf Button.Index = 3 Then
        Opcion_006_Click
    ElseIf Button.Index = 5 Then
        Opcion_007_Click
    ElseIf Button.Index = 7 Then
        Opcion_008_Click
    ElseIf Button.Index = 9 Then
        Opcion_010_Click
    ElseIf Button.Index = 11 Then
        Opcion_009_Click
    End If
End Sub
