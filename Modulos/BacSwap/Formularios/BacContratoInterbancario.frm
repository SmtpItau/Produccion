VERSION 5.00
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.3#0"; "comctl32.ocx"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BACCONTROLES.OCX"
Begin VB.Form BacContratoInterbancario 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Contratos Interbancarios"
   ClientHeight    =   5130
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   5985
   Icon            =   "BacContratoInterbancario.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   5130
   ScaleWidth      =   5985
   ShowInTaskbar   =   0   'False
   Begin ComctlLib.Toolbar Toolbar1 
      Height          =   510
      Left            =   0
      TabIndex        =   27
      Top             =   15
      Width           =   5985
      _ExtentX        =   10557
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   327682
      BeginProperty Buttons {0713E452-850A-101B-AFC0-4210102A8DA7} 
         NumButtons      =   2
         BeginProperty Button1 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Key             =   ""
            Object.ToolTipText     =   "Imprimir"
            Object.Tag             =   ""
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Key             =   ""
            Object.ToolTipText     =   "Salir"
            Object.Tag             =   ""
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin VB.CommandButton btnSalir 
      Caption         =   "&Salir"
      Height          =   780
      Left            =   4770
      Picture         =   "BacContratoInterbancario.frx":000C
      Style           =   1  'Graphical
      TabIndex        =   4
      Top             =   5310
      Visible         =   0   'False
      Width           =   1185
   End
   Begin VB.CommandButton btnImpresora 
      Caption         =   "&Impresora"
      Height          =   780
      Left            =   3510
      Picture         =   "BacContratoInterbancario.frx":0316
      Style           =   1  'Graphical
      TabIndex        =   3
      ToolTipText     =   "Informe directo a Impresora"
      Top             =   5310
      Visible         =   0   'False
      Width           =   1185
   End
   Begin VB.Frame Frame1 
      Height          =   4740
      Index           =   0
      Left            =   0
      TabIndex        =   0
      Top             =   390
      Width           =   6000
      Begin VB.Frame Frame1 
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   2445
         Index           =   2
         Left            =   135
         TabIndex        =   2
         Top             =   2175
         Width           =   5730
         Begin BACControles.TXTFecha txtFecha 
            Height          =   270
            Left            =   1305
            TabIndex        =   26
            Top             =   2025
            Width           =   1215
            _ExtentX        =   2143
            _ExtentY        =   476
            Enabled         =   -1  'True
            Enabled         =   -1  'True
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   8388608
            MaxDate         =   2958465
            MinDate         =   -328716
            Text            =   "25/10/2000"
         End
         Begin VB.ComboBox cmbRepCliente2 
            ForeColor       =   &H00800000&
            Height          =   315
            Left            =   1305
            Style           =   2  'Dropdown List
            TabIndex        =   15
            Top             =   1215
            Width           =   3075
         End
         Begin VB.ComboBox cmbRepCliente1 
            ForeColor       =   &H00800000&
            Height          =   315
            Left            =   1305
            Style           =   2  'Dropdown List
            TabIndex        =   14
            Top             =   855
            Width           =   3075
         End
         Begin VB.Label txtDirecCli 
            BackColor       =   &H00FFFFFF&
            BorderStyle     =   1  'Fixed Single
            Caption         =   "Label1"
            ForeColor       =   &H00800000&
            Height          =   330
            Left            =   1305
            TabIndex        =   24
            Top             =   1575
            Width           =   4290
         End
         Begin VB.Label txtRutRepCli1 
            BackColor       =   &H00FFFFFF&
            BorderStyle     =   1  'Fixed Single
            Caption         =   "Label1"
            ForeColor       =   &H00800000&
            Height          =   330
            Left            =   4455
            TabIndex        =   23
            Top             =   855
            Width           =   1140
         End
         Begin VB.Label txtRutRepCli2 
            BackColor       =   &H00FFFFFF&
            BorderStyle     =   1  'Fixed Single
            Caption         =   "Label1"
            ForeColor       =   &H00800000&
            Height          =   330
            Left            =   4455
            TabIndex        =   22
            Top             =   1215
            Width           =   1140
         End
         Begin VB.Label txtRutCli 
            BackColor       =   &H00FFFFFF&
            BorderStyle     =   1  'Fixed Single
            Caption         =   "Label1"
            ForeColor       =   &H00800000&
            Height          =   330
            Left            =   4455
            TabIndex        =   21
            Top             =   405
            Width           =   1140
         End
         Begin VB.Label txtCliente 
            BackColor       =   &H00FFFFFF&
            BorderStyle     =   1  'Fixed Single
            Caption         =   "Label1"
            ForeColor       =   &H00800000&
            Height          =   330
            Left            =   135
            MouseIcon       =   "BacContratoInterbancario.frx":0620
            MousePointer    =   99  'Custom
            TabIndex        =   20
            Top             =   405
            Width           =   4245
         End
         Begin VB.Label lblEtiqueta 
            AutoSize        =   -1  'True
            Caption         =   "Cliente"
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
            Index           =   6
            Left            =   135
            TabIndex        =   19
            Top             =   180
            Width           =   600
         End
         Begin VB.Label lblEtiqueta 
            AutoSize        =   -1  'True
            Caption         =   "Fecha"
            Height          =   195
            Index           =   4
            Left            =   135
            TabIndex        =   17
            Top             =   2070
            Width           =   450
         End
         Begin VB.Label lblEtiqueta 
            AutoSize        =   -1  'True
            Caption         =   "Dirección"
            Height          =   195
            Index           =   3
            Left            =   135
            TabIndex        =   16
            Top             =   1620
            Width           =   675
         End
         Begin VB.Label lblEtiqueta 
            AutoSize        =   -1  'True
            Caption         =   "Representantes"
            Height          =   195
            Index           =   2
            Left            =   135
            TabIndex        =   13
            Top             =   900
            Width           =   1125
         End
      End
      Begin VB.Frame Frame1 
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   2040
         Index           =   1
         Left            =   135
         TabIndex        =   1
         Top             =   150
         Width           =   5730
         Begin VB.TextBox txtDirecBco 
            BackColor       =   &H00E0E0E0&
            ForeColor       =   &H00800000&
            Height          =   330
            Left            =   1305
            TabIndex        =   12
            Text            =   "Text1"
            Top             =   1575
            Width           =   4290
         End
         Begin VB.TextBox txtRutRepBco1 
            BackColor       =   &H00E0E0E0&
            ForeColor       =   &H00800000&
            Height          =   330
            Left            =   4455
            TabIndex        =   10
            Text            =   "Text1"
            Top             =   855
            Width           =   1140
         End
         Begin VB.TextBox txtRutRepBco2 
            BackColor       =   &H00E0E0E0&
            ForeColor       =   &H00800000&
            Height          =   330
            Left            =   4455
            TabIndex        =   9
            Text            =   "Text1"
            Top             =   1215
            Width           =   1140
         End
         Begin VB.TextBox txtRepBco2 
            BackColor       =   &H00E0E0E0&
            ForeColor       =   &H00800000&
            Height          =   330
            Left            =   1305
            TabIndex        =   8
            Text            =   "Text1"
            Top             =   1215
            Width           =   3075
         End
         Begin VB.TextBox txtRepBco1 
            BackColor       =   &H00E0E0E0&
            ForeColor       =   &H00800000&
            Height          =   330
            Left            =   1305
            TabIndex        =   7
            Text            =   "Text1"
            Top             =   855
            Width           =   3075
         End
         Begin VB.TextBox txtEntidad 
            BackColor       =   &H00E0E0E0&
            ForeColor       =   &H00800000&
            Height          =   330
            Left            =   135
            TabIndex        =   5
            Text            =   "Text1"
            Top             =   405
            Width           =   5460
         End
         Begin VB.Label lblEtiqueta 
            AutoSize        =   -1  'True
            Caption         =   "Entidad"
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
            Index           =   5
            Left            =   135
            TabIndex        =   18
            Top             =   180
            Width           =   660
         End
         Begin VB.Label lblEtiqueta 
            AutoSize        =   -1  'True
            Caption         =   "Dirección"
            Height          =   195
            Index           =   1
            Left            =   135
            TabIndex        =   11
            Top             =   1620
            Width           =   675
         End
         Begin VB.Label lblEtiqueta 
            AutoSize        =   -1  'True
            Caption         =   "Representantes"
            Height          =   195
            Index           =   0
            Left            =   135
            TabIndex        =   6
            Top             =   900
            Width           =   1305
         End
      End
   End
   Begin ComctlLib.ImageList ImageList1 
      Left            =   780
      Top             =   5520
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   327682
      BeginProperty Images {0713E8C2-850A-101B-AFC0-4210102A8DA7} 
         NumListImages   =   2
         BeginProperty ListImage1 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "BacContratoInterbancario.frx":0772
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "BacContratoInterbancario.frx":0A8C
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin VB.Label LblImp 
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   11.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   285
      Left            =   135
      TabIndex        =   25
      Top             =   4995
      Width           =   3210
   End
End
Attribute VB_Name = "BacContratoInterbancario"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim DatosContrato(20)
Dim RutCli As Long
Dim Codigo As Long
Dim Ciudad As String

Private Sub btnImpresora_Click()
    Dim m
        
    If ValidaDatos Then
        Me.MousePointer = 11
        Call BacDOCCondicionesGenerales(DatosContrato(), "Pantalla")
        'Call BacCondicionesGenerales(DatosContrato())
        LblImp.Caption = "Informe enviado a Impresora!!"
        For m = 1 To 100000
            DoEvents
        Next
        LblImp.Caption = ""
        Me.MousePointer = 0
    End If

End Sub
Function ValidaDatos() As Boolean
Dim digBco, fechaCont As String
Dim Nomcli2 As String

    ValidaDatos = False
    If txtEntidad = "" Then
        MsgBox "Debe ingresar Nombre del Banco", vbInformation, Msj
        Exit Function
    End If
    If txtRepBco1 = "" Then
        MsgBox "Debe ingresar Nombre del Representante del Banco", vbInformation, Msj
        Exit Function
    End If
    If txtRutRepBco1 = "" Then
        MsgBox "Debe ingresar RUT del Representante del Banco", vbInformation, Msj
        Exit Function
    End If
    If txtRepBco2 = "" Then
        'MsgBox "Debe ingresar Nombre del Representante del Banco", vbInformation, Msj
        'Exit Function
    End If
    If txtRutRepBco2 = "" Then
        'MsgBox "Debe ingresar Nombre del Representante del Banco", vbInformation, Msj
        'Exit Function
    End If
    If txtDirecBco = "" Then
        MsgBox "Debe ingresar dirección del Banco", vbInformation, Msj
        Exit Function
    End If
    If txtCliente = "" Then
        MsgBox "Debe Ingresar nombre del Cliente", vbInformation, Msj
       ' txtCliente.SetFocus
        Exit Function
    End If
    If txtRutCli = "" Then
        MsgBox "Debe Ingresar RUT del Cliente", vbInformation, Msj
        'txtRutCli.SetFocus
        Exit Function
    End If
    If cmbRepCliente1.ListIndex = -1 Then
        MsgBox "Debe Seleccionar Representante del Cliente", vbInformation, Msj
        cmbRepCliente1.SetFocus
        Exit Function
    End If
    If txtRutRepCli1 = "" Then
        MsgBox "Debe Ingresar Rut del Representante del Cliente", vbInformation, Msj
        'txtRutRepCli1.SetFocus
        Exit Function
    End If
    If cmbRepCliente2.ListIndex = -1 Then
        'MsgBox "Debe Seleccionar Representante del Cliente", vbInformation, Msj
        'cmbRepCliente2.SetFocus
        'Exit Function
    End If
    If txtRutRepCli2 = "" Then
        'MsgBox "Debe Ingresar Rut del Representante del Cliente", vbInformation, Msj
        'txtRutRepCli2.SetFocus
        'Exit Function
    End If
    If txtDirecCli = "" Then
        MsgBox "Debe Ingresar Dirección del Cliente", vbInformation, Msj
        'txtDirecCli.SetFocus
        Exit Function
    End If
    
    digBco = BacCheckRut(CStr(RutCli))
    
    fechaCont = Day(txtFecha.Text) & " de " & BacMesStr(Month(txtFecha.Text)) & " de " & Year(txtFecha.Text)
    
    DatosContrato(1) = txtEntidad
    DatosContrato(2) = RutCli & "-" & digBco
    DatosContrato(3) = txtRepBco1
    DatosContrato(4) = txtRutRepBco1
    DatosContrato(5) = txtRepBco2
    DatosContrato(6) = txtRutRepBco2
    DatosContrato(7) = txtDirecBco
    DatosContrato(8) = txtCliente
    DatosContrato(9) = txtRutCli
    DatosContrato(10) = Trim(Left(cmbRepCliente1, Len(cmbRepCliente1) - 15))
    DatosContrato(11) = txtRutRepCli1
    If cmbRepCliente2 <> "" Then
        Nomcli2 = Trim(Left(cmbRepCliente2, Len(cmbRepCliente2) - 15))
    Else
        Nomcli2 = ""
    End If
    DatosContrato(12) = Nomcli2
    DatosContrato(13) = txtRutRepCli2
    DatosContrato(14) = txtDirecCli
    DatosContrato(15) = fechaCont
    DatosContrato(16) = Ciudad
    
    ValidaDatos = True
    
End Function
Private Sub btnSalir_Click()

    Unload Me

End Sub

Private Sub cmbRepCliente1_Click()

    If cmbRepCliente1.ListIndex <> -1 Then
        txtRutRepCli1 = ""
        txtRutRepCli1 = cmbRepCliente1.ItemData(cmbRepCliente1.ListIndex)
        txtRutRepCli1 = Format(txtRutRepCli1, "###,###,###") & "-" & Trim(Right(cmbRepCliente1.List(cmbRepCliente1.ListIndex), 10))
    End If

End Sub

Private Sub cmbRepCliente2_Click()
    
    If cmbRepCliente2.ListIndex <> -1 Then
        txtRutRepCli2 = ""
        txtRutRepCli2 = cmbRepCliente2.ItemData(cmbRepCliente2.ListIndex)
        txtRutRepCli2 = Format(txtRutRepCli2, "###,###,###") & "-" & Trim(Right(cmbRepCliente2.List(cmbRepCliente2.ListIndex), 10))
    End If

End Sub

Private Sub Form_Load()
Me.Icon = BACSwap.Icon
'Err.Number = 380

    Call Limpia
    Call CargaDatosEntidad
    
    Frame1(1).Enabled = False

End Sub
Function CargaDatosEntidad()

    Dim i As Integer
    Dim tot As Integer
    Dim Datos()
    Dim Sql As String
    
    
'   Sql = "EXECUTE sp_leerdatosgenerales "
                        
'    If MISQL.SQL_Execute(Sql) <> 0 Then
    If Not Bac_Sql_Execute("SP_LEERDATOSGENERALES") Then
    
        MsgBox "¡No se encuentran datos Principales de la Entidad!", vbCritical, Msj
        Exit Function

    End If

'    If MISQL.SQL_Fetch(DATOS()) = 0 Then
    If Bac_SQL_Fetch(Datos()) Then
        txtEntidad = Datos(3)
        txtDirecBco = Datos(5)
        RutCli = Val(Datos(4))
        Ciudad = Datos(7)
        Codigo = Datos(22)
    End If
    
'    '-- PENDIENTE carga de Apoderados ???

'    'Sql = "EXECUTE " & giSQL_DatabaseCommon & ".."
'    'Sql = Sql & "sp_Leer_Apoderado " & RutCli
'    '
''    sql = "EXECUTE " & giSQL_DatabaseCommon & ".."
'    Sql = "EXECUTE "
'    Sql = Sql & "sp_mdapleerrut " & RutCli & ", " & Codigo
    
    Envia = Array()
    AddParam Envia, CDbl(RutCli)
    AddParam Envia, CDbl(Codigo)
    
'    If MISQL.SQL_Execute(Sql) <> 0 Then
    If Not Bac_Sql_Execute("SP_MDAPLEERRUT", Envia) Then
    
        MsgBox " Error de sp ", vbCritical, Msj
        Exit Function
    End If
    
    i = 1
'    Do While MISQL.SQL_Fetch(DATOS) = 0
    Do While Bac_SQL_Fetch(Datos())

        If i = 1 Then
          txtRepBco1 = UCase(Datos(3))
          txtRutRepBco1 = Format(Datos(1), "###,###,##0") & "-" & Val(Datos(2))
        Else
          txtRepBco2 = UCase(Datos(3))
          txtRutRepBco2 = Format(Datos(1), "###,###,##0") & "-" & Val(Datos(2))
        End If
      i = i + 1
    Loop
    
   
End Function
Function BuscaRepresentantes(RutCli&, codcli&)
    
    Call Apoderados(cmbRepCliente1, RutCli, codcli&)
    Call Apoderados(cmbRepCliente2, RutCli, codcli&)
    
    If cmbRepCliente1.ListCount - 1 < 0 Then
        btnImpresora.Enabled = False
        MsgBox "Cliente no tiene Representantes ingresados", vbCritical, Msj
        
    End If
    
End Function

Function Limpia()
    
    txtEntidad = ""
    txtRepBco1 = ""
    txtRutRepBco1 = ""
    txtRepBco2 = ""
    txtRutRepBco2 = ""
    txtRutRepCli1 = ""
    txtRutRepCli2 = ""
    txtDirecBco = ""
    txtDirecCli = ""
    txtCliente = ""
    txtRutCli = ""
    cmbRepCliente1.ListIndex = -1
    cmbRepCliente2.ListIndex = -1

End Function

Private Sub Label1_DblClick()
'MsgBox "responde"
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As ComctlLib.Button)
   Select Case Button.Index
   Case 1
    Call btnImpresora_Click
   Case 2
    Call btnSalir_Click
End Select
End Sub

Private Sub txtCliente_DblClick()
Dim Cliente As New clsCliente
Dim codcli As Long

    If Not Cliente.Ayuda("") Then
        Set Cliente = Nothing
        MsgBox "No Existen Datos para ayuda solicitada", vbExclamation, Msj
        Exit Sub
    End If
    
    BacAyudaSwap.Tag = "Cliente"
    BacAyudaSwap.Show 1
    
    If giAceptar Then
        If Cliente.LeerxRut(Val(gsCodigo), Val(gsCodCli)) Then
            txtRutCli = Format(Cliente.clrut, "###,###,###") & "-" & Cliente.cldv
            txtCliente = Cliente.clnombre
            codcli = Cliente.clcodigo
            txtDirecCli = Cliente.cldireccion
            txtFecha.Text = Date
            txtRutRepCli1 = ""
            txtRutRepCli2 = ""
            Call BuscaRepresentantes(Val(gsCodigo), Val(gsCodCli))
        Else
            MsgBox "No se pudo capturar datos de Cliente solicitado", vbCritical, Msj
        End If
    End If
    
    Set Cliente = Nothing
    
End Sub

