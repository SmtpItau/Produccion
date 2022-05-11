VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "threed32.ocx"
Object = "{BDC217C8-ED16-11CD-956C-0000C04E4C0A}#1.1#0"; "TABCTL32.OCX"
Begin VB.Form BacFrmTipoCliente 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Tipo de Emisores"
   ClientHeight    =   2880
   ClientLeft      =   3435
   ClientTop       =   2925
   ClientWidth     =   5190
   Icon            =   "BacFrmTipoCliente.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   2880
   ScaleWidth      =   5190
   Begin TabDlg.SSTab Tb_Tipo 
      Height          =   2355
      Left            =   15
      TabIndex        =   7
      Top             =   540
      Width           =   5175
      _ExtentX        =   9128
      _ExtentY        =   4154
      _Version        =   393216
      Style           =   1
      TabHeight       =   520
      ForeColor       =   -2147483641
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      TabCaption(0)   =   "&1.-Emisores"
      TabPicture(0)   =   "BacFrmTipoCliente.frx":2EFA
      Tab(0).ControlEnabled=   -1  'True
      Tab(0).Control(0)=   "FRM_DESCRIPCION"
      Tab(0).Control(0).Enabled=   0   'False
      Tab(0).ControlCount=   1
      TabCaption(1)   =   "&2.-Plazos"
      TabPicture(1)   =   "BacFrmTipoCliente.frx":2F16
      Tab(1).ControlEnabled=   0   'False
      Tab(1).Control(0)=   "FRM_PLAZOS"
      Tab(1).ControlCount=   1
      TabCaption(2)   =   "&3.-Categorias"
      TabPicture(2)   =   "BacFrmTipoCliente.frx":2F32
      Tab(2).ControlEnabled=   0   'False
      Tab(2).Control(0)=   "FRM_CATEGORIAS"
      Tab(2).ControlCount=   1
      Begin Threed.SSFrame FRM_DESCRIPCION 
         Height          =   1830
         Left            =   90
         TabIndex        =   9
         Top             =   420
         Width           =   4990
         _Version        =   65536
         _ExtentX        =   8811
         _ExtentY        =   3228
         _StockProps     =   14
         Caption         =   "Descripcion"
         ForeColor       =   -2147483641
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Font3D          =   3
         Begin VB.TextBox TxtCodigoEmi 
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
            Left            =   1470
            MaxLength       =   3
            MouseIcon       =   "BacFrmTipoCliente.frx":2F4E
            MousePointer    =   99  'Custom
            TabIndex        =   0
            Top             =   450
            Width           =   2205
         End
         Begin VB.TextBox TxtDescEmi 
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
            Left            =   1470
            MaxLength       =   50
            TabIndex        =   1
            Top             =   810
            Width           =   3165
         End
         Begin VB.TextBox Txtglosa 
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
            Height          =   330
            Left            =   1470
            MaxLength       =   15
            TabIndex        =   2
            Top             =   1170
            Width           =   3165
         End
         Begin VB.Label Label1 
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
            Height          =   315
            Left            =   210
            TabIndex        =   12
            Top             =   480
            Width           =   1335
         End
         Begin VB.Label Label2 
            Caption         =   "Descripción"
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
            Height          =   315
            Left            =   210
            TabIndex        =   11
            Top             =   840
            Width           =   1335
         End
         Begin VB.Label Label8 
            Caption         =   "Glosa"
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
            Height          =   285
            Left            =   225
            TabIndex        =   10
            Top             =   1215
            Width           =   1230
         End
      End
      Begin Threed.SSFrame FRM_PLAZOS 
         Height          =   1830
         Left            =   -74910
         TabIndex        =   13
         Top             =   420
         Width           =   4995
         _Version        =   65536
         _ExtentX        =   8811
         _ExtentY        =   3228
         _StockProps     =   14
         Caption         =   "Mantención de Plazos "
         ForeColor       =   -2147483641
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Font3D          =   3
         Enabled         =   0   'False
         Begin VB.TextBox TxtDescPlazo 
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
            Left            =   1470
            MaxLength       =   50
            TabIndex        =   4
            Top             =   810
            Width           =   3165
         End
         Begin VB.TextBox TxtCodigoPlazo 
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
            Left            =   1470
            MaxLength       =   3
            MouseIcon       =   "BacFrmTipoCliente.frx":3258
            MousePointer    =   99  'Custom
            TabIndex        =   3
            Top             =   450
            Width           =   2205
         End
         Begin VB.Label Label3 
            Caption         =   "Descripción"
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
            Height          =   315
            Left            =   210
            TabIndex        =   15
            Top             =   870
            Width           =   1215
         End
         Begin VB.Label Label4 
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
            Height          =   315
            Left            =   210
            TabIndex        =   14
            Top             =   450
            Width           =   1215
         End
      End
      Begin Threed.SSFrame FRM_CATEGORIAS 
         Height          =   1830
         Left            =   -74910
         TabIndex        =   16
         Top             =   420
         Width           =   4990
         _Version        =   65536
         _ExtentX        =   8811
         _ExtentY        =   3228
         _StockProps     =   14
         Caption         =   "Mantención de  Categorias"
         ForeColor       =   -2147483641
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Font3D          =   3
         Enabled         =   0   'False
         Begin VB.TextBox TxtDescCat 
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
            Left            =   1470
            MaxLength       =   20
            TabIndex        =   6
            Top             =   810
            Width           =   3165
         End
         Begin VB.TextBox TxtCodigoCat 
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
            Left            =   1470
            MaxLength       =   1
            MouseIcon       =   "BacFrmTipoCliente.frx":3562
            MousePointer    =   99  'Custom
            TabIndex        =   5
            Top             =   450
            Width           =   2205
         End
         Begin VB.Label Label5 
            Caption         =   "Descripción"
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
            Height          =   315
            Left            =   210
            TabIndex        =   18
            Top             =   870
            Width           =   1215
         End
         Begin VB.Label Label6 
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
            Height          =   315
            Left            =   210
            TabIndex        =   17
            Top             =   450
            Width           =   1215
         End
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   480
      Left            =   0
      TabIndex        =   8
      Top             =   0
      Width           =   5190
      _ExtentX        =   9155
      _ExtentY        =   847
      ButtonWidth     =   820
      ButtonHeight    =   794
      Appearance      =   1
      Style           =   1
      ImageList       =   "Img_opciones"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   5
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Limpiar"
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Grabar"
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Eliminar"
            Object.ToolTipText     =   "Eliminar"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Buscar"
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin MSComctlLib.ImageList Img_opciones 
      Left            =   4440
      Top             =   -90
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
            Picture         =   "BacFrmTipoCliente.frx":386C
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacFrmTipoCliente.frx":3CD3
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacFrmTipoCliente.frx":41C9
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacFrmTipoCliente.frx":465C
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacFrmTipoCliente.frx":4B44
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "BacFrmTipoCliente"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim OptLocal As String

Private Sub Form_Activate()
   PROC_CARGA_AYUDA Me, " "
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
Dim opcion As Integer
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

      Toolbar1.Buttons(2).Enabled = False
      Toolbar1.Buttons(3).Enabled = False
      Toolbar1.Buttons(4).Enabled = True


    Call LogAuditoria("07", OptLocal, Me.Caption, "", "")
End Sub

Private Sub Form_Unload(Cancel As Integer)
    Call LogAuditoria("08", OptLocal, Me.Caption, "", "")
End Sub

Private Sub TabStrip1_Click()
With TabStrip1
   SSFrame2.Visible = False
   SSFrame3.Visible = False
   SSFrame4.Visible = False

   If .SelectedItem = "Emisores" Then
      SSFrame2.Visible = True
      TxtCodigoEmi.SetFocus
   ElseIf .SelectedItem = "Plazos" Then
      SSFrame3.Visible = True
      TxtCodigoPlazo.SetFocus
   ElseIf .SelectedItem = "Categorias" Then
      SSFrame4.Visible = True
      TxtCodigoCat.SetFocus
   End If
End With
End Sub

Private Sub TabStrip1_LostFocus()
   TxtCodigoEmi = ""
   TxtDescEmi = ""
   TxtCodigoPlazo = ""
   TxtDescPlazo = ""
   TxtCodigoCat = ""
   TxtDescCat = ""
End Sub

Private Sub Tb_Tipo_Click(PreviousTab As Integer)

 FRM_DESCRIPCION.Enabled = (Trim(UCase(Tb_Tipo.Tab)) = 0)
 FRM_PLAZOS.Enabled = (Trim(UCase(Tb_Tipo.Tab)) = 1)
 FRM_CATEGORIAS.Enabled = (Trim(UCase(Tb_Tipo.Tab)) = 2)

 Toolbar1_ButtonClick Toolbar1.Buttons(1)
  

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
    Select Case Trim(UCase(Button.Key))
        Case Is = "BUSCAR"
            If Tb_Tipo.Tab = 0 Then
               TxtCodigoEmi_LostFocus
            End If
            If Tb_Tipo.Tab = 1 Then
               TxtCodigoPlazo_LostFocus
            End If
            If Tb_Tipo.Tab = 2 Then
               TxtCodigoCat_LostFocus
            End If
            Toolbar1.Buttons(4).Enabled = False
        Case Is = "SALIR"
            Unload Me

        Case Is = "GRABAR"
            If Tb_Tipo.Tab = 0 Then
                If TxtCodigoEmi.Text = "" Or TxtDescEmi.Text = "" Then Exit Sub
                If Not FUNC_GRABA_EMISORES() Then Exit Sub
            End If
            If Tb_Tipo.Tab = 1 Then
                If TxtCodigoPlazo.Text = "" Or TxtDescPlazo.Text = "" Then Exit Sub
                If Not FUNC_GRABA_PLAZOS() Then Exit Sub
            End If
            If Tb_Tipo.Tab = 2 Then
                If TxtCodigoCat.Text = "" Or TxtDescCat.Text = "" Then Exit Sub
                If Not FUNC_GRABA_CATEGORIAS() Then Exit Sub
            End If
           
        Case Is = "LIMPIAR"
            If Tb_Tipo.Tab = 0 Then
                TxtCodigoEmi.Enabled = True
                TxtCodigoEmi.Text = ""
                txtGlosa.Text = ""
                TxtCodigoEmi.SetFocus
            ElseIf Tb_Tipo.Tab = 1 Then
                TxtCodigoPlazo.Enabled = True
                TxtCodigoPlazo.Text = ""
                TxtCodigoPlazo.SetFocus
            ElseIf Tb_Tipo.Tab = 2 Then
                TxtCodigoCat.Enabled = True
                TxtCodigoCat.Text = ""
                If TxtCodigoCat.Enabled Then TxtCodigoCat.SetFocus
            End If

            Toolbar1.Buttons(2).Enabled = False
            Toolbar1.Buttons(3).Enabled = False
            Toolbar1.Buttons(4).Enabled = True
        Case Is = "ELIMINAR"
            If Tb_Tipo.Tab = 0 Then
                If TxtCodigoEmi.Text = "" Or TxtDescEmi.Text = "" Then Exit Sub
                If Not FUNC_ELIMINA_EMISORES() Then Exit Sub
            End If
            If Tb_Tipo.Tab = 1 Then
                If TxtCodigoPlazo.Text = "" Or TxtDescPlazo.Text = "" Then Exit Sub
                If Not FUNC_ELIMINA_PLAZO() Then Exit Sub
            End If
            If Tb_Tipo.Tab = 2 Then
                If TxtCodigoCat.Text = "" Or TxtDescCat.Text = "" Then Exit Sub
                If Not FUNC_ELIMINA_CATEGORIAS() Then Exit Sub
            End If
     End Select
End Sub

Function FUNC_GRABA_EMISORES() As Boolean
Dim Datos()
FUNC_GRABA_EMISORES = False

Envia = Array()

AddParam Envia, TxtCodigoEmi
AddParam Envia, TxtDescEmi
AddParam Envia, txtGlosa
             
If Not BAC_SQL_EXECUTE("SP_TABLAEMISORES_AGREGAR_EMISORES ", Envia) Then Exit Function
Do While BAC_SQL_FETCH(Datos())
    Select Case Datos(1)
        Case Is = "ERROR"
               Case Is = "EXISTE"
               MsgBox "Emisor Ya Existe", vbCritical
               Limpiar
               TxtCodigoEmi.SetFocus
               Exit Function
        End Select
    Loop
Beep
MsgBox " Información Grabada...", vbInformation
Call LogAuditoria("01", OptLocal, Me.Caption, "", "Codigo emisor: " & TxtCodigoEmi.Text)

Limpiar
TxtCodigoEmi.SetFocus
FUNC_GRABA_EMISORES = True
End Function

Function FUNC_GRABA_PLAZOS() As Boolean
Dim Datos()
FUNC_GRABA_PLAZOS = False

Envia = Array()

AddParam Envia, TxtCodigoPlazo
AddParam Envia, TxtDescPlazo
             
If Not BAC_SQL_EXECUTE("SP_TABLAPLAZO_AGREGAR_PLAZOS ", Envia) Then Exit Function
Do While BAC_SQL_FETCH(Datos())
    Select Case Datos(1)
        Case Is = "ERROR"
               Case Is = "EXISTE"
               MsgBox "Plazos Ya Existe", vbCritical
               Limpiar
               TxtCodigoPlazo.SetFocus
               Exit Function
        End Select
    Loop
Beep
MsgBox " Información Grabada...", vbInformation
Call LogAuditoria("01", OptLocal, Me.Caption, "", "Codigo Plazo: " & TxtCodigoPlazo.Text)

Limpiar
TxtCodigoPlazo.SetFocus
FUNC_GRABA_PLAZOS = True
End Function

Function FUNC_GRABA_CATEGORIAS() As Boolean
Dim Datos()
FUNC_GRABA_CATEGORIA = False

Envia = Array()

AddParam Envia, TxtCodigoCat
AddParam Envia, TxtDescCat
             
If Not BAC_SQL_EXECUTE("SP_TABLACATEGORIAS_AGREGAR_CATEGORIAS ", Envia) Then Exit Function
Do While BAC_SQL_FETCH(Datos())
    Select Case Datos(1)
        Case Is = "ERROR"
               Case Is = "EXISTE"
               MsgBox "Categoria Ya Existe", vbCritical
               Limpiar
               TxtCodigoCat.SetFocus
               Exit Function
        End Select
    Loop
Beep
MsgBox " Información Grabada...", vbInformation
Call LogAuditoria("01", OptLocal, Me.Caption, "", "Codigo Categoria: " & TxtCodigoCat.Text)

Limpiar
TxtCodigoCat.SetFocus
FUNC_GRABA_CATEGORIA = True
End Function

Function FUNC_ELIMINA_EMISORES() As Boolean
Dim Datos()
FUNC_ELIMINA_EMISORES = False

Envia = Array()
AddParam Envia, TxtCodigoEmi
'AddParam Envia, TxtDescEmi

If Not BAC_SQL_EXECUTE("SP_TABLAEMISORES_ELIMINAR_EMISORES", Envia) Then Exit Function
Do While BAC_SQL_FETCH(Datos())
   If Datos(1) = "RELACIONADA" Then MsgBox "No se Puede Eliminar EL Emisor, Esta Relacionado", vbCritical
   If Datos(1) = "NO EXISTE" Then MsgBox "Emisor No Existe", vbCritical
      Limpiar
      TxtCodigoEmi.SetFocus
      Exit Function
Loop
MsgBox "Información Eliminada...", vbInformation
Call LogAuditoria("03", OptLocal, Me.Caption, "Codigo Emisor: " & TxtCodigoEmi.Text, "")

Limpiar
TxtCodigoEmi.SetFocus
FUNC_ELIMINA_EMISORES = True
End Function

Function FUNC_ELIMINA_PLAZO() As Boolean
Dim Datos()
FUNC_ELIMINA_PLAZO = False

Envia = Array()
AddParam Envia, TxtCodigoPlazo
'AddParam Envia, TxtDescPlazo

If Not BAC_SQL_EXECUTE("SP_TABLAPLAZOS_ELIMINAR_PLAZOS", Envia) Then Exit Function
Do While BAC_SQL_FETCH(Datos())
   If Datos(1) = "RELACIONADA" Then MsgBox "No se Puede Eliminar El Plazo, Esta Relacionado", vbCritical
   If Datos(1) = "NO EXISTE" Then MsgBox "Plazo No Existe", vbCritical
      Limpiar
      TxtCodigoPlazo.SetFocus
      Exit Function
Loop
MsgBox "Información Eliminada...", vbInformation
Call LogAuditoria("03", OptLocal, Me.Caption, "Codigo Plazo: " & TxtCodigoPlazo.Text, "")

Limpiar
TxtCodigoPlazo.SetFocus
FUNC_ELIMINA_PLAZO = True
End Function

Function FUNC_ELIMINA_CATEGORIAS() As Boolean
Dim Datos()
FUNC_ELIMINA_CATEGORIAS = False

Envia = Array()
AddParam Envia, TxtCodigoCat
'AddParam Envia, TxtDescCat

If Not BAC_SQL_EXECUTE("SP_TABLACATEGORIAS_ELIMINAR_CATEGORIA", Envia) Then Exit Function
Do While BAC_SQL_FETCH(Datos())
   If Datos(1) = "RELACIONADA" Then MsgBox "No se Puede Eliminar la Categoria, Esta Relacionada", vbCritical
   If Datos(1) = "NO EXISTE" Then MsgBox "Categoria No Existe", vbCritical
      Limpiar
      TxtCodigoCat.SetFocus
      Exit Function
Loop
MsgBox "Información Eliminada...", vbInformation
Call LogAuditoria("03", OptLocal, Me.Caption, "Codigo Categoria: " & TxtCodigoCat.Text, "")

Limpiar
TxtCodigoCat.SetFocus
FUNC_ELIMINA_CATEGORIA = True
End Function

Private Sub TxtCodigoCat_KeyDown(KeyCode As Integer, Shift As Integer)
 If KeyCode = vbKeyF3 Then TxtCodigoCat_DblClick
End Sub

Private Sub TxtCodigoEmi_Change()
    
    If Len(TxtCodigoEmi.Text) = 0 Then
        TxtDescEmi.Text = ""
        txtGlosa.Text = ""
        TxtDescEmi.Enabled = False
        txtGlosa.Enabled = False
    Else
        TxtDescEmi.Enabled = True
        txtGlosa.Enabled = True
    End If
    
End Sub

Private Sub TxtCodigoEmi_DblClick()
        MiTag = "EmisoresMnt"
        BacAyuda.Show 1
        If giAceptar% = True Then
            TxtCodigoEmi.Text = RETORNOAYUDA
            Call TxtCodigoEmi_LostFocus
        End If
End Sub

Private Sub TxtCodigoEmi_KeyDown(KeyCode As Integer, Shift As Integer)
  If KeyCode = vbKeyF3 Then TxtCodigoEmi_DblClick
End Sub

Private Sub TxtCodigoEmi_KeyPress(KeyAscii As Integer)
    If Not IsNumeric(Chr(KeyAscii)) And Not (KeyAscii = 8 Or KeyAscii = vbKeyReturn Or KeyAscii = vbKeyEscape) Then
      KeyAscii = 0
    End If

    If KeyAscii = 13 Then
      If TxtDescEmi.Enabled Then
       TxtDescEmi.SetFocus
       Exit Sub
      End If
    End If
End Sub

Private Sub TxtCodigoEmi_LostFocus()
    Dim Datos()
    
    If Not BAC_SQL_EXECUTE("SP_MOSTRAR_EMISORES") Then
        Exit Sub
    End If
    If Trim(TxtCodigoEmi.Text) <> "" Then
        Do While BAC_SQL_FETCH(Datos())
            If Me.TxtCodigoEmi.Text = Datos(1) Then
                Me.TxtDescEmi.Text = Datos(2)
                Me.txtGlosa.Text = Datos(3)
                Toolbar1.Buttons(3).Enabled = True
                Exit Do
            End If
        Loop
          Me.TxtCodigoEmi.Enabled = False
          Toolbar1.Buttons(2).Enabled = True
    End If
End Sub

Private Sub TxtCodigoPlazo_Change()

    If Len(TxtCodigoPlazo.Text) = 0 Then
        TxtDescPlazo.Text = ""
        TxtDescPlazo.Enabled = False
    Else
        TxtDescPlazo.Enabled = True
    End If
    
End Sub

Private Sub TxtCodigoPlazo_DblClick()
        MiTag = "PlazosMnt"
        BacAyuda.Show 1
        If giAceptar% = True Then
            TxtCodigoPlazo.Text = RETORNOAYUDA
            Call TxtCodigoPlazo_LostFocus
        End If
End Sub

Private Sub TxtCodigoPlazo_KeyDown(KeyCode As Integer, Shift As Integer)
  If KeyCode = vbKeyF3 Then TxtCodigoPlazo_DblClick
End Sub

Private Sub TxtCodigoPlazo_KeyPress(KeyAscii As Integer)
    If Not IsNumeric(Chr(KeyAscii)) And Not (KeyAscii = 8 Or KeyAscii = vbKeyReturn Or KeyAscii = vbKeyEscape) Then
      KeyAscii = 0
    End If
    
    If KeyAscii = 13 Then
      If TxtDescPlazo.Enabled Then
         TxtDescPlazo.SetFocus
         Exit Sub
      End If
    End If
End Sub

Private Sub TxtCodigoPlazo_LostFocus()
    Dim Datos()
    
    If Not BAC_SQL_EXECUTE("SP_MOSTRAR_PLAZOS") Then
        Exit Sub
    End If
    If Trim(TxtCodigoPlazo.Text) <> "" Then
        Do While BAC_SQL_FETCH(Datos())
            If Me.TxtCodigoPlazo.Text = Datos(1) Then
                Me.TxtDescPlazo.Text = Datos(2)
                Toolbar1.Buttons(3).Enabled = True
                Exit Do
            End If
        Loop
         TxtCodigoPlazo.Enabled = False
         Toolbar1.Buttons(2).Enabled = True
    End If
End Sub
Private Sub TxtCodigoCat_Change()
    
    If Len(TxtCodigoCat.Text) = 0 Then
        TxtDescCat.Text = ""
        TxtDescCat.Enabled = False
    Else
        TxtDescCat.Enabled = True
    End If

End Sub

Private Sub TxtCodigoCat_DblClick()
        MiTag = "CategoriasMnt"
        BacAyuda.Show 1
        If giAceptar% = True Then
            TxtCodigoCat.Text = RETORNOAYUDA
            Call TxtCodigoCat_LostFocus
        End If
End Sub

Private Sub TxtCodigoCat_KeyPress(KeyAscii As Integer)
'    If Not IsNumeric(Chr(KeyAscii)) And Not (KeyAscii = 8 Or KeyAscii = vbKeyReturn Or KeyAscii = vbKeyEscape) Then
'      KeyAscii = 0
'    End If
    
    KeyAscii = Caracter(KeyAscii)
    
    If KeyAscii = 13 Then
      If Me.TxtDescCat.Enabled Then
         TxtDescCat.SetFocus
         Exit Sub
      End If
    End If
End Sub

Private Sub TxtCodigoCat_LostFocus()
    Dim Datos()
    
    If Not BAC_SQL_EXECUTE("SP_MOSTRAR_CATEGORIAS") Then
        Exit Sub
    End If
    If Trim(TxtCodigoCat.Text) <> "" Then
        Do While BAC_SQL_FETCH(Datos())
            If Me.TxtCodigoCat.Text = Datos(1) Then
                Me.TxtDescCat.Text = Datos(2)
                Toolbar1.Buttons(3).Enabled = True
                Exit Do
            End If
        Loop
      TxtCodigoCat.Enabled = False
      Toolbar1.Buttons(2).Enabled = True
    End If
End Sub

Sub Limpiar()
    Me.TxtCodigoEmi.Enabled = True
    Me.TxtCodigoEmi = ""
    Me.TxtDescEmi = ""
    TxtCodigoPlazo.Enabled = True
    Me.TxtCodigoPlazo = ""
    Me.TxtDescPlazo = ""
    TxtCodigoCat.Enabled = True
    Me.TxtCodigoCat = ""
    Me.TxtDescCat = ""
    Me.txtGlosa = ""
End Sub
Private Sub TxtDescCat_KeyPress(KeyAscii As Integer)
KeyAscii = Asc(UCase(Chr(KeyAscii)))
KeyAscii = Caracter(KeyAscii)
End Sub

Private Sub TxtDescEmi_KeyPress(KeyAscii As Integer)
KeyAscii = Asc(UCase(Chr(KeyAscii)))
KeyAscii = Caracter(KeyAscii)
If KeyAscii = 13 Then
   Me.txtGlosa.SetFocus
End If
End Sub

Private Sub TxtDescPlazo_KeyPress(KeyAscii As Integer)
KeyAscii = Asc(UCase(Chr(KeyAscii)))
KeyAscii = Caracter(KeyAscii)
End Sub

Private Sub Txtglosa_KeyPress(KeyAscii As Integer)
KeyAscii = Asc(UCase(Chr(KeyAscii)))
KeyAscii = Caracter(KeyAscii)
End Sub
