VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form bacMntCampos 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Mantención de Valores a Contabilizar"
   ClientHeight    =   7485
   ClientLeft      =   1455
   ClientTop       =   975
   ClientWidth     =   8370
   Icon            =   "BacMntCampos.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   7485
   ScaleWidth      =   8370
   ShowInTaskbar   =   0   'False
   Begin Threed.SSPanel SSPanel1 
      Height          =   6990
      Left            =   0
      TabIndex        =   1
      Top             =   495
      Width           =   8340
      _Version        =   65536
      _ExtentX        =   14711
      _ExtentY        =   12330
      _StockProps     =   15
      BackColor       =   -2147483644
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin VB.Frame fraOperacion 
         Height          =   6810
         Left            =   0
         TabIndex        =   2
         Top             =   0
         Width           =   8340
         Begin Threed.SSFrame frame2 
            Height          =   2055
            Left            =   90
            TabIndex        =   12
            Top             =   210
            Width           =   8130
            _Version        =   65536
            _ExtentX        =   14340
            _ExtentY        =   3625
            _StockProps     =   14
            Caption         =   "Tipo Operación"
            ForeColor       =   8388608
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Font3D          =   3
            Begin VB.TextBox txtDescripcion 
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
               Height          =   315
               Left            =   2085
               MaxLength       =   60
               TabIndex        =   19
               Top             =   1545
               Width           =   5190
            End
            Begin VB.CheckBox chkEvento 
               Caption         =   "Evento Especial"
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
               Height          =   255
               Left            =   5355
               TabIndex        =   18
               Top             =   1155
               Width           =   1905
            End
            Begin VB.ComboBox cmbProducto 
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
               Height          =   315
               Left            =   2085
               Style           =   2  'Dropdown List
               TabIndex        =   17
               Top             =   1155
               Width           =   2925
            End
            Begin VB.ComboBox cmbOperacion 
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
               Height          =   315
               Left            =   2085
               Style           =   2  'Dropdown List
               TabIndex        =   16
               Top             =   765
               Width           =   2925
            End
            Begin VB.ComboBox cmbSistema 
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
               Height          =   315
               Left            =   2085
               Style           =   2  'Dropdown List
               TabIndex        =   15
               Top             =   375
               Width           =   2940
            End
            Begin VB.OptionButton OptTipOpe 
               Caption         =   "&Compra"
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
               Height          =   375
               Index           =   0
               Left            =   5355
               TabIndex        =   14
               Top             =   360
               Value           =   -1  'True
               Width           =   1305
            End
            Begin VB.OptionButton OptTipOpe 
               Caption         =   "&Venta"
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
               Height          =   375
               Index           =   1
               Left            =   5355
               TabIndex        =   13
               Top             =   735
               Width           =   1305
            End
            Begin VB.Label Label1 
               AutoSize        =   -1  'True
               Caption         =   "Descripción"
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
               Index           =   4
               Left            =   420
               TabIndex        =   23
               Top             =   1590
               Width           =   1110
            End
            Begin VB.Label Label1 
               AutoSize        =   -1  'True
               Caption         =   "Producto"
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
               Index           =   2
               Left            =   420
               TabIndex        =   22
               Top             =   1200
               Width           =   870
            End
            Begin VB.Label Label1 
               AutoSize        =   -1  'True
               Caption         =   "Operación"
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
               Left            =   420
               TabIndex        =   21
               Top             =   810
               Width           =   975
            End
            Begin VB.Label Label1 
               AutoSize        =   -1  'True
               Caption         =   "Sistema"
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
               Left            =   420
               TabIndex        =   20
               Top             =   420
               Width           =   765
            End
         End
         Begin VB.Frame fraRelacion 
            Height          =   4230
            Left            =   90
            TabIndex        =   3
            Top             =   2430
            Width           =   8130
            Begin Threed.SSPanel SSPanel2 
               Height          =   3870
               Left            =   120
               TabIndex        =   4
               Top             =   240
               Width           =   7935
               _Version        =   65536
               _ExtentX        =   13996
               _ExtentY        =   6826
               _StockProps     =   15
               BackColor       =   -2147483644
               BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Begin MSComctlLib.Toolbar Toolbar3 
                  Height          =   480
                  Left            =   6030
                  TabIndex        =   11
                  Top             =   3240
                  Width           =   1770
                  _ExtentX        =   3122
                  _ExtentY        =   847
                  ButtonWidth     =   767
                  ButtonHeight    =   741
                  Appearance      =   1
                  ImageList       =   "ImageList2"
                  _Version        =   393216
                  BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
                     NumButtons      =   4
                     BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
                        Object.ToolTipText     =   "Agregar"
                        ImageIndex      =   2
                     EndProperty
                     BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
                        Object.ToolTipText     =   "Limpiar"
                        ImageIndex      =   3
                     EndProperty
                     BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
                        Object.ToolTipText     =   "Eliminar"
                        ImageIndex      =   4
                     EndProperty
                     BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
                        Object.ToolTipText     =   "Grabar"
                        ImageIndex      =   5
                     EndProperty
                  EndProperty
               End
               Begin MSComctlLib.ImageList ImageList2 
                  Left            =   1575
                  Top             =   -450
                  _ExtentX        =   1005
                  _ExtentY        =   1005
                  BackColor       =   -2147483643
                  ImageWidth      =   22
                  ImageHeight     =   22
                  MaskColor       =   12632256
                  _Version        =   393216
                  BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
                     NumListImages   =   5
                     BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                        Picture         =   "BacMntCampos.frx":030A
                        Key             =   ""
                     EndProperty
                     BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                        Picture         =   "BacMntCampos.frx":075E
                        Key             =   ""
                     EndProperty
                     BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                        Picture         =   "BacMntCampos.frx":0A7E
                        Key             =   ""
                     EndProperty
                     BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                        Picture         =   "BacMntCampos.frx":0D9E
                        Key             =   ""
                     EndProperty
                     BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                        Picture         =   "BacMntCampos.frx":11F2
                        Key             =   ""
                     EndProperty
                  EndProperty
               End
               Begin MSComctlLib.Toolbar Toolbar2 
                  Height          =   480
                  Left            =   135
                  TabIndex        =   10
                  Top             =   3240
                  Width           =   465
                  _ExtentX        =   820
                  _ExtentY        =   847
                  ButtonWidth     =   767
                  ButtonHeight    =   741
                  Appearance      =   1
                  ImageList       =   "ImageList2"
                  _Version        =   393216
                  BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
                     NumButtons      =   1
                     BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
                        Object.ToolTipText     =   "Volver"
                        ImageIndex      =   1
                     EndProperty
                  EndProperty
               End
               Begin VB.TextBox txtGlosa 
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
                  Height          =   315
                  Left            =   2760
                  MaxLength       =   60
                  TabIndex        =   6
                  Top             =   180
                  Width           =   3735
               End
               Begin VB.TextBox txtCodigo 
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
                  ForeColor       =   &H00800000&
                  Height          =   315
                  Left            =   1920
                  MaxLength       =   3
                  MouseIcon       =   "BacMntCampos.frx":1646
                  MousePointer    =   99  'Custom
                  TabIndex        =   5
                  Top             =   180
                  Width           =   735
               End
               Begin MSFlexGridLib.MSFlexGrid grdCampos 
                  Height          =   2535
                  Left            =   90
                  TabIndex        =   7
                  Top             =   720
                  Width           =   7695
                  _ExtentX        =   13573
                  _ExtentY        =   4471
                  _Version        =   393216
                  Cols            =   5
                  FixedCols       =   0
                  BackColor       =   -2147483644
                  ForeColor       =   0
                  BackColorFixed  =   8421376
                  ForeColorFixed  =   16777215
                  BackColorSel    =   8388608
                  ForeColorSel    =   8388608
                  BackColorBkg    =   -2147483645
                  Enabled         =   -1  'True
                  GridLines       =   2
                  GridLinesFixed  =   0
               End
               Begin VB.Label lblTipo 
                  BorderStyle     =   1  'Fixed Single
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
                  Height          =   315
                  Left            =   6600
                  TabIndex        =   9
                  Top             =   180
                  Width           =   1245
               End
               Begin VB.Label Label1 
                  AutoSize        =   -1  'True
                  Caption         =   "Valor Contable"
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
                  Index           =   3
                  Left            =   270
                  TabIndex        =   8
                  Top             =   225
                  Width           =   1260
               End
            End
         End
      End
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   3420
      Top             =   0
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   2
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMntCampos.frx":1950
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMntCampos.frx":1DA8
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   8370
      _ExtentX        =   14764
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "bacMntCampos"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim sql$, datos(), I&

Dim nerror%, sError$

Dim objCodigo As Object
Private Sub BuscarValorContable(Buscar$)

    Me.MousePointer = 11
    
''''''''''''''''''''''    Sql = "sp_Buscar_Campo '" & cmbSistema.Tag & "'"    '-- Id_Sistema
    
    Envia = Array()
    
    AddParam Envia, cmbSistema.Tag
    
    If Buscar = "" Then
        
''''''''''''''''''''''''''''''        Sql = Sql & ",'" & cmbOperacion.Tag & "'"           '-- Tipo_Movimiento
''''''''''''''''''''''''''''''        Sql = Sql & ",'" & Toolbar3.Buttons(4).Tag & "'"              '-- Tipo_Operacion
    
        AddParam Envia, cmbOperacion.Tag
        AddParam Envia, Toolbar3.Buttons(4).Tag
    
    Else
        
        ''''''''''''''''''''' Sql = Sql & ",'',''"
        AddParam Envia, ""
        AddParam Envia, ""
        
    End If
    
'''''''''''''''''''    Sql = Sql & ", " & Val(txtCodigo.Text)                    '-- Codigo de Campo
    
    AddParam Envia, CDbl(txtCodigo.Text)
    
    If Not Bac_Sql_Execute("SP_BUSCAR_CAMPO", Envia) Then
        
        MsgBox "Problemas al tratar de traer datos de Valor Contable solicitado", vbExclamation + vbOKOnly, TITSISTEMA
        GoTo fin
    
    End If
    
    If Bac_SQL_Fetch(datos()) Then
        
        TxtGlosa.Text = datos(5)
        TxtGlosa.Tag = datos(6)
        lblTipo.Caption = datos(7)
    
    Else
        
        cmdlimpiar_Click
        MsgBox "Valor Contable no se encontro ...", vbExclamation + vbOKOnly, TITSISTEMA
    
    End If
        
fin:
    
    Me.MousePointer = 0

End Sub
Sub PROC_CARGA_COMBO_SISTEMA()

    On Error GoTo ErrCarga

''''''''''''''    Sql = "SP_BUSCAR_SISTEMAS "
    
    If Bac_Sql_Execute("SP_BUSCAR_SISTEMAS ") Then
        
        cmbSistema.Clear
        
        Do While Bac_SQL_Fetch(datos())
            
            cmbSistema.AddItem Mid$(datos(2), 1, 15) & Space(50) & datos(1)
        
        Loop
        'cmbSistema.ListIndex = IIf(cmbSistema.ListCount >= 0, 0, -1)
    
    Else
        
        MsgBox "No se pudo obtener información del servidor", vbCritical, TITSISTEMA
        Exit Sub
    
    End If
    
    Exit Sub
    
ErrCarga:
    MsgBox "Se detectó problemas en carga de información: " & Err.Description & ". Comunique al Administrador.", vbCritical, TITSISTEMA
    Exit Sub
    
End Sub

Private Sub Limpia()

    grdCampos.FixedRows = 0
    grdCampos.Rows = 1
    grdCampos.Cols = 6
    
    grdCampos.Rows = 2
    grdCampos.FixedRows = 1

    grdCampos.TextMatrix(0, 0) = "Sistema"
    grdCampos.TextMatrix(0, 1) = "Movimiento"
    grdCampos.TextMatrix(0, 2) = "Operación"
    grdCampos.TextMatrix(0, 3) = "Código"
    grdCampos.TextMatrix(0, 4) = "Valor Contable"
    grdCampos.TextMatrix(0, 5) = "Tipo Valor"

    'grdCampos.ColWidth(0) = 0
    For I = 0 To grdCampos.Cols - 1
        grdCampos.ColWidth(I) = TextWidth(grdCampos.TextMatrix(0, I)) * IIf(I = 4, 2.5, 1.5)
        grdCampos.ColAlignment(I) = 0
    Next I

End Sub

Private Sub chkEvento_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        OptTipOpe(IIf(OptTipOpe(0).Value, 0, 1)).SetFocus
    End If
End Sub


Private Sub cmbOperacion_Click()

    cmbOperacion_LostFocus

End Sub

Private Sub cmbOperacion_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        cmbProducto.SetFocus
    End If
End Sub
Private Sub cmbOperacion_LostFocus()
    With cmbOperacion
        If .ListIndex >= 0 Then
            .Tag = Right(.List(.ListIndex), 3)
        Else
            .Tag = ""
        End If
    End With
    
    '---- Prefijo Tipo_Operacion para bac_cnt_campos
    If cmbOperacion.Tag = "MOV" Then
        chkEvento.Caption = "&Vencimiento"
        chkEvento.Tag = "V"
        chkEvento.Value = 0
        chkEvento.Enabled = True
    Else
        chkEvento.Caption = "&Devengamiento"
        chkEvento.Tag = "D"
        chkEvento.Value = 1
        chkEvento.Enabled = False
    End If
    
End Sub

Private Sub cmbProducto_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        If Not chkEvento.Enabled Then
            OptTipOpe(IIf(OptTipOpe(0).Value, 0, 1)).SetFocus
        Else
            chkEvento.SetFocus
        End If
    End If
End Sub
Private Sub cmbProducto_LostFocus()
    With cmbProducto
        If .ListIndex >= 0 Then
            .Tag = Trim(Right(cmbProducto, 5))
        Else
            .Tag = ""
        End If
    End With
End Sub


Private Sub cmbSistema_Click()

    With cmbSistema
        If .ListIndex >= 0 Then
            .Tag = Trim(Right(.List(.ListIndex), 5))
        Else
            .Tag = ""
        End If
        
         Set objCodigo = New clsCodigo
        If objCodigo.CargaProductos(cmbProducto, .Tag) Then
            cmbProducto_LostFocus
        End If
        Set objCodigo = Nothing
        'cmbOperacion.Clear
        TxtDescripcion.Text = ""
        If Trim(Right(.List(.ListIndex), 5)) = "BCC" Then
            cmbOperacion.Clear
            cmbOperacion.AddItem Left("MOVIMIENTO          " & Space(50), 50) & "MOV"
            cmbOperacion.ListIndex = 0
            cmbOperacion_LostFocus
        Else
            cmbOperacion.Clear
            cmbOperacion.AddItem Left("MOVIMIENTO          " & Space(50), 50) & "MOV"
            cmbOperacion.AddItem Left("DEVENGAMIENTO       " & Space(50), 50) & "DEV"
            cmbOperacion.ListIndex = 0
            cmbOperacion_LostFocus
        End If
        
    End With

End Sub

Private Sub cmbSistema_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        
    End If
End Sub
Private Sub cmbSistema_LostFocus()

    With cmbSistema
        If .ListIndex >= 0 Then
            .Tag = Trim(Right(.List(.ListIndex), 5))
        Else
            .Tag = ""
        End If
        
         Set objCodigo = New clsCodigo
        If objCodigo.CargaProductos(cmbProducto, .Tag) Then
            cmbProducto_LostFocus
        End If
        Set objCodigo = Nothing
        'cmbOperacion.Clear
        
        
    End With
End Sub

Private Sub cmdEliminar_Click()

    '---- Validando
    If Val(txtCodigo.Text) = 0 Or TxtGlosa.Tag = "" Then
        MsgBox "Debe seleccionar el Valor Contable que desea Eliminar", vbExclamation + vbOKOnly, TITSISTEMA
        Exit Sub
    End If

    '----
    Me.MousePointer = 11
    'ojo ver si el if esta bien colocado
    If MsgBox("Esta Seguro de Eliminar este elemento", 36, TITSISTEMA) = 6 Then
        nerror = 0
        sError = "Se Eliminó con éxito la relación ..."
    
'''''''''''''''''''''''''''''''''''''        Sql = "sp_Borrar_Campo '" & cmbSistema.Tag & "'"    '-- Id_Sistema
'''''''''''''''''''''''''''''''''''''        Sql = Sql & ",'" & cmbOperacion.Tag & "'"           '-- Tipo_Movimiento
'''''''''''''''''''''''''''''''''''''        Sql = Sql & ",'" & Toolbar3.Buttons(4).Tag & "'"              '-- Tipo_Operacion
'''''''''''''''''''''''''''''''''''''        Sql = Sql & ", " & txtCodigo                        '-- Codigo de Campo
        
        Envia = Array()
        
        AddParam Envia, cmbSistema.Tag
        AddParam Envia, cmbOperacion.Tag
        AddParam Envia, Toolbar3.Buttons(4).Tag
        AddParam Envia, CDbl(txtCodigo)
        
        If Not Bac_Sql_Execute("SP_BORRAR_CAMPO ", Envia) Then
            
            nerror = -1
            sError = "Problemas al Eliminar"
        
        End If
        
        If Bac_SQL_Fetch(datos()) Then
            
            nerror = datos(1)
            sError = datos(2)
        
        End If
    
    End If
        If nerror <> 0 Then
            sError = "Se presento el siguiente problema al intentar Eliminar" & vbCrLf & sError
            MsgBox sError, vbInformation + vbOKOnly, TITSISTEMA
        Else
            cmdRefresh_Click
        End If
    
    Me.MousePointer = 0

End Sub
Private Sub cmdGrabar_Click()

    '---- Validando
    If Val(txtCodigo.Text) = 0 Or TxtGlosa.Tag = "" Then
        MsgBox "Debe seleccionar el Valor Contable que desea Agregar", vbExclamation + vbOKOnly, TITSISTEMA
        Exit Sub
    End If

    '----
    Me.MousePointer = 11
    
    nerror = 0
    sError = "Se Grabo con éxito la relación ..."
    
    Envia = Array()
    
    AddParam Envia, cmbSistema.Tag
    AddParam Envia, cmbOperacion.Tag
    AddParam Envia, Toolbar3.Buttons(4).Tag
    AddParam Envia, CDbl(txtCodigo)
    AddParam Envia, TxtGlosa
    AddParam Envia, TxtGlosa.Tag
    AddParam Envia, Left(lblTipo, 1)
    AddParam Envia, ""
    AddParam Envia, ""
    AddParam Envia, ""
    
    If Not Bac_Sql_Execute("SP_GRABAR_CAMPO", Envia) Then
        
        nerror = -1
        sError = "Problemas al Grabar"
    
    End If
    
    If Bac_SQL_Fetch(datos()) Then
        
        nerror = datos(1)
        sError = datos(2)
    
    End If
    
    If nerror <> 0 Then
        
        sError = "Se presento el siguiente problema al intentar grabar" & vbCrLf & sError
        MsgBox sError, vbInformation + vbOKOnly, TITSISTEMA
    
    Else
        Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                                    , gsbac_fecp _
                                    , gsBac_IP _
                                    , gsBAC_User _
                                    , "PCA" _
                                    , "OPC_553 " _
                                    , "02" _
                                    , "Grabado" & " " & cmbSistema.Tag & " " & cmbOperacion.Tag & " " & TipoOperacionMOV _
                                    , " " _
                                    , " " _
                                    , " ")
        cmdRefresh_Click
    
    End If
    
    Me.MousePointer = 0

End Sub
Private Sub cmdlimpiar_Click()

    txtCodigo.Text = ""
    TxtGlosa.Text = ""
    lblTipo.Caption = ""
   ' fraRelacion.Enabled = True
    txtCodigo.SetFocus

End Sub

Private Sub cmdNew_Click()

    txtCodigo_DblClick
    
    If giAceptar = True Then
        cmdGrabar_Click
    End If

End Sub

Private Sub cmdRefresh_Click()
    
    If cmbSistema.Tag = "" Then
        MsgBox "Sistema no ha sido definido", vbInformation + vbOKOnly, TITSISTEMA
        Exit Sub
    End If

    '---- Armado del Tipo_Operacion para bac_cnt_campos
    Toolbar3.Buttons(4).Tag = TipoOperacionMOV
        
    '---- Valida existencia Tipo de Operación
    sql = ""
    sql = "SELECT glosa_operacion FROM movimiento_cnt"
    sql = sql & " WHERE id_sistema = '" & cmbSistema.Tag & "'"
    sql = sql & "   AND tipo_movimiento = '" & cmbOperacion.Tag & "'"
    sql = sql & "   AND tipo_operacion = '" & Toolbar3.Buttons(4).Tag & "'"
    
    If MISQL.SQL_Execute(sql) <> 0 Then
        MsgBox "Problemas con la Consulta ...", vbCritical + vbOKOnly, TITSISTEMA
        Exit Sub
    End If
    '---- Agrega nuevo Tipo de Operación a bac_cnt_movimiento
    nerror = -1
    sError = "Este Tipo de Operación no esta registrado"
    If MISQL.SQL_Fetch(datos()) = 0 Then
        nerror = 0
        TxtDescripcion.Text = datos(1)
    End If
    If nerror <> 0 Then
        TxtDescripcion = Trim(TxtDescripcion)
        If TxtDescripcion = "" Then
            If chkEvento.Value = 1 Then
                TxtDescripcion.Text = IIf(chkEvento.Tag = "V", "VCTO.", "DEV.")
            End If
            TxtDescripcion.Text = TxtDescripcion.Text & Trim(Left(cmbProducto, 50))
            TxtDescripcion.Text = TxtDescripcion.Text & IIf(OptTipOpe(0).Value, " COMPRA ", " VENTA ")
        End If
        sError = sError & vbCrLf & vbCrLf & TxtDescripcion.Text
        sError = sError & vbCrLf & vbCrLf & "¿ Desea registrarla ?"
        If MsgBox(sError, vbQuestion + vbYesNo, TITSISTEMA) <> vbYes Then
            Exit Sub
        End If
        sql = "INSERT INTO bac_cnt_movimiento VALUES( '" & cmbSistema.Tag & "'"
        sql = sql & ",'" & cmbOperacion.Tag & "'"
        sql = sql & ",'" & Trim(Left(cmbOperacion.Text, 50)) & "'"
        sql = sql & ",'" & Toolbar3.Buttons(4).Tag & "'"
        sql = sql & ",'" & Trim(TxtDescripcion) & "'"
        sql = sql & ", 1"       '-- Tipo de Voucher    PENDIENTE definición
        sql = sql & ",'N'"      '-- Tipo de Movimiento Caja ???
        sql = sql & ",'N'"      '-- Controla Instrumento
        sql = sql & ",'S'"     '-- Controla Moneda
        sql = sql & ",'')"
        If MISQL.SQL_Execute(sql) <> 0 Then
            MsgBox "Problemas al Grabar nuevo Tipo de Operación ...", vbCritical + vbOKOnly, TITSISTEMA
            Exit Sub
        End If
    End If

    '---- Carga
'''''''''''''''''''''''''''''''''''    Sql = "sp_Buscar_Campo '" & cmbSistema.Tag & "'"    '-- Id_Sistema
'''''''''''''''''''''''''''''''''''    Sql = Sql & ",'" & cmbOperacion.Tag & "'"           '-- Tipo_Movimiento
'''''''''''''''''''''''''''''''''''    Sql = Sql & ",'" & Toolbar3.Buttons(4).Tag & "'"              '-- Tipo_Operacion
'''''''''''''''''''''''''''''''''''    Sql = Sql & ",0"                                    '-- Codigo de Campo
    
    Envia = Array()
    
    AddParam Envia, cmbSistema.Tag
    AddParam Envia, cmbOperacion.Tag
    AddParam Envia, Toolbar3.Buttons(4).Tag
    AddParam Envia, CDbl(0)
    
    If Not Bac_Sql_Execute("SP_BUSCAR_CAMPO", Envia) Then
        
        MsgBox "Problemas con la Consulta ...", vbCritical + vbOKOnly, TITSISTEMA
        Exit Sub
    
    End If
    
    '-- Limpia Valores Contables
    Call Limpia
    
    I = 0
    
    Do While Bac_SQL_Fetch(datos())
        
        I = I + 1
        grdCampos.Row = grdCampos.Rows - 1
        grdCampos.TextMatrix(grdCampos.Row, 0) = datos(1)       '-- Sistema
        grdCampos.TextMatrix(grdCampos.Row, 1) = datos(2)       '-- Tipo de Movimiento
        grdCampos.TextMatrix(grdCampos.Row, 2) = datos(3)       '-- Tipo de Operacion
        grdCampos.TextMatrix(grdCampos.Row, 3) = Val(datos(4))  '-- Codigo Valor Contable
        grdCampos.TextMatrix(grdCampos.Row, 4) = datos(5)       '-- Glosa  Valor Contable
        grdCampos.TextMatrix(grdCampos.Row, 5) = IIf(datos(7) = "V", "Variable", "Fijo") '-- Tipo de Administracion
        grdCampos.Rows = grdCampos.Rows + 1
    
    Loop
    
    If I > 0 Then
        
        grdCampos.Rows = grdCampos.Rows - 1
    
    End If
    
    fraRelacion.Enabled = True
    Frame2.Enabled = False
    cmdlimpiar_Click

End Sub
Private Sub cmdVolver_Click()

    cmdlimpiar_Click
    
    '---- Cheque si Tipo de Operacion tiene Valores Contables Asignados
    If grdCampos.TextMatrix(1, 0) = cmbSistema.Tag Then
        GoTo fin
    End If
    
    '---- Eliminando Tipo de Operación
    sError = "Este Tipo de Operación ya no registra Valores Contables" & vbCrLf
    sError = sError & "¿ Desea dejarla registrada ?"
    nerror = MsgBox(sError, vbQuestion + vbYesNoCancel, TITSISTEMA)
    If nerror = vbCancel Then
        Exit Sub
    ElseIf nerror <> vbNo Then
        MsgBox "Este Tipo de Operación seguirá registrado", vbInformation + vbOKOnly, TITSISTEMA
        GoTo fin
    End If

    '---- Elimina existencia Tipo de Operación
    sql = "DELETE FROM movimiento_cnt"
    sql = sql & " WHERE id_sistema = '" & cmbSistema.Tag & "'"
    sql = sql & "   AND tipo_movimiento = '" & cmbOperacion.Tag & "'"
    sql = sql & "   AND tipo_operacion = '" & Toolbar3.Buttons(4).Tag & "'"
    If MISQL.SQL_Execute(sql) <> 0 Then
        MsgBox "Problemas al tratar de Eliminar Tipo de Operación ...", vbCritical + vbOKOnly, TITSISTEMA
        Exit Sub
    End If
        
fin:
    Call Limpia
    fraRelacion.Enabled = False
    Frame2.Enabled = True
    TxtDescripcion.Text = ""
    

End Sub

Private Sub Form_Activate()

    '-- Carga Sistema
    PROC_CARGA_COMBO_SISTEMA
    bacBuscarComboR cmbSistema, Sistema
    cmbSistema_LostFocus
    If cmbSistema.Tag = "" Then
        MsgBox "Sistema " & Chr(32) & Sistema & Chr(32) & " NO existe , debe generarlo", vbCritical + vbOKOnly, TITSISTEMA
        Unload Me
        Exit Sub
    Else
        'cmbSistema.Enabled = False
    End If

    '---- Tipo de Operación
    cmbOperacion.Clear
    cmbOperacion.AddItem Left("MOVIMIENTO          " & Space(50), 50) & "MOV"
    cmbOperacion.AddItem Left("DEVENGAMIENTO       " & Space(50), 50) & "DEV"
    cmbOperacion.ListIndex = 0
    cmbOperacion_LostFocus
    
    '---- Tipo de Producto
    Set objCodigo = New clsCodigo
    If objCodigo.CargaObjetos(cmbProducto, MDTC_TIPOSWAP) Then
        cmbProducto_LostFocus
    End If
    Set objCodigo = Nothing
    
    '-- Limpia Valor Contable
    txtCodigo.Text = ""
    TxtGlosa.Text = ""
    lblTipo.Caption = ""

    Call Limpia
    
    
    Toolbar3.Buttons(4).Tag = ""

    fraRelacion.Enabled = False
    
End Sub

Private Sub Form_Load()
    Me.Top = 0
    Me.Left = 0
    Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                          , gsbac_fecp _
                          , gsBac_IP _
                          , gsBAC_User _
                          , "PCA" _
                          , "OPC_553" _
                          , "07" _
                          , "INGRESO A OPCION MENU" _
                          , " " _
                          , " " _
                          , " ")
End Sub

Private Sub grdCampos_Click()

    If grdCampos.RowSel <= 0 Then
        Exit Sub
    End If

    If grdCampos.TextMatrix(grdCampos.RowSel, 3) <> "" Then
        txtCodigo.Text = grdCampos.TextMatrix(grdCampos.RowSel, 3)
        Call BuscarValorContable("BUSCAR")
    End If

End Sub

Private Sub lblTipo_Change()
    If Len(lblTipo.Caption) = 1 Then
        lblTipo.Caption = IIf(lblTipo.Caption = "V", "Variable", "Fijo")
    End If
End Sub

Private Sub OptTipOpe_KeyPress(Index As Integer, KeyAscii As Integer)
    If KeyAscii = 13 Then
        
    End If
End Sub


Private Sub SSCommand1_Click()
Unload Me
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Dim ControlMon As String
Dim ControlMonInst  As String
Dim tipoOperacion As String



Select Case Button.Index
    Case 1
    If cmbSistema.Tag = "" Then
        MsgBox "Sistema no ha sido definido", vbInformation + vbOKOnly, TITSISTEMA
        Exit Sub
    End If
    
    If cmbProducto.ListCount = 0 Then
        MsgBox "Productos no se han definido No existe Relación", vbInformation + vbOKOnly, TITSISTEMA
        Exit Sub
    End If

    If cmbProducto.ListIndex = -1 Then
        MsgBox "Debe seleccionar el Producto", vbInformation + vbOKOnly, TITSISTEMA
        Exit Sub
    End If

    
    
    tipoOperacion = TipoOperacionMOV
        
    Toolbar3.Buttons(4).Tag = tipoOperacion
    
    Envia = Array()
    
    AddParam Envia, cmbSistema.Tag
    AddParam Envia, tipoOperacion ' Toolbar3.Buttons(4).Tag
    AddParam Envia, cmbOperacion.Tag
    
    Select Case Envia(1)
               Case "PTASC"
                       Envia(1) = "CMXN"
               Case "PTASV"
                       Envia(1) = "VMXN"
               Case "ARBIC"
                       Envia(1) = "CMXA"
               Case "ARBIV"
                       Envia(1) = "VMXA"
               Case "VPTASC"
                       Envia(1) = "ACMX"
               Case "VPTASV"
                       Envia(1) = "AVMX"
               Case "VARBIC"
                       Envia(1) = "ACAR"
               Case "VARBIV"
                       Envia(1) = "AVAR"
    End Select
    
    If Not Bac_Sql_Execute("SP_BACMNTCAMPOS_SELCTGLOSA", Envia) Then
        MsgBox "Problemas con la Consulta ...", vbCritical + vbOKOnly, TITSISTEMA
        Exit Sub
    End If
    '---- Agrega nuevo Tipo de Operación a bac_cnt_movimiento
    nerror = -1
    sError = "Este Tipo de Operación no esta registrado"
    
    If Bac_SQL_Fetch(datos()) Then
        
        nerror = 0
        TxtDescripcion.Text = datos(1)
    
    End If
    
    If nerror <> 0 Then
        
        TxtDescripcion = Trim(TxtDescripcion)
        
        If TxtDescripcion = "" Then
            
            If chkEvento.Value = 1 Then
                
                TxtDescripcion.Text = IIf(chkEvento.Tag = "V", "VCTO.", "DEV.")
            
            End If
            
            TxtDescripcion.Text = TxtDescripcion.Text & Trim(Left(cmbProducto, 50))
            TxtDescripcion.Text = TxtDescripcion.Text & IIf(OptTipOpe(0).Value, " COMPRA ", " VENTA ")
        
        End If
        
        sError = sError & vbCrLf & vbCrLf & TxtDescripcion.Text
        sError = sError & vbCrLf & vbCrLf & "¿ Desea registrarla ?"
        
        If MsgBox(sError, vbQuestion + vbYesNo, TITSISTEMA) <> vbYes Then
            
            Exit Sub
        
        End If
        
        Envia = Array()
        
        If cmbSistema.Tag = "PCS" Then
            ControlMon = "S"
            ControlMonInst = "N"
            Select Case cmbProducto.Tag 'Toolbar3.Buttons(4).Tag
                Case "ST"
                 '   CodProducto = 1
                Case "SM"
                  '  CodProducto = 2
                Case "FR"
                   ' CodProducto = 3
            End Select
        ElseIf cmbSistema.Tag = "BFW" Then
            ControlMon = "N"
            ControlMonInst = IIf(cmbOperacion.Tag = "DEV", "N", "S")
        ElseIf cmbSistema.Tag = "BEX" Then
            ControlMon = "N"
            ControlMonInst = "S" 'IIf(cmbOperacion.Tag = "DEV", "N", "S")
           ' CodProducto = cmbProducto.Tag
        Else
            'CodProducto = cmbProducto.Tag
        End If
        sql = ""
        
        AddParam Envia, cmbSistema.Tag
        AddParam Envia, cmbOperacion.Tag
        AddParam Envia, tipoOperacion '
        AddParam Envia, Trim(Left(cmbOperacion.Text, 50)) 'CodProducto
        AddParam Envia, Trim(TxtDescripcion)
        AddParam Envia, 1       '-- Tipo de Voucher    PENDIENTE definición
        AddParam Envia, "N"      '-- Tipo de Movimiento Caja ???
        AddParam Envia, ControlMonInst      '-- Controla Instrumento
        AddParam Envia, ControlMon     '-- Controla Moneda
        AddParam Envia, "S"
        
        
        If Not Bac_Sql_Execute("SP_BACMNTCAMPOS_GRABA", Envia) Then
            
            MsgBox "Problemas al Grabar nuevo Tipo de Operación ...", vbCritical + vbOKOnly, TITSISTEMA
            Exit Sub
        
        End If
    
    End If

    '---- Carga
''''''''''''''''''''''''''''''''''''''''''''    Sql = "sp_Buscar_Campo '" & cmbSistema.Tag & "'"    '-- Id_Sistema
''''''''''''''''''''''''''''''''''''''''''''    Sql = Sql & ",'" & cmbOperacion.Tag & "'"           '-- Tipo_Movimiento
''''''''''''''''''''''''''''''''''''''''''''    Sql = Sql & ",'" & Toolbar3.Buttons(4).Tag & "'"              '-- Tipo_Operacion
''''''''''''''''''''''''''''''''''''''''''''    Sql = Sql & ",0"                                    '-- Codigo de Campo
''''''''''''''''''''''''''''''''''''''''''''
    Envia = Array()
    
    AddParam Envia, cmbSistema.Tag
    AddParam Envia, cmbOperacion.Tag
    AddParam Envia, tipoOperacion 'Toolbar3.Buttons(4).Tag
    AddParam Envia, CDbl(0)

    Select Case Envia(2)
               Case "PTASC"
                       Envia(2) = "CMXN"
               Case "PTASV"
                       Envia(2) = "VMXN"
               Case "ARBIC"
                       Envia(2) = "CMXA"
               Case "ARBIV"
                       Envia(2) = "VMXA"
               Case "VPTASC"
                       Envia(2) = "ACMX"
               Case "VPTASV"
                       Envia(2) = "AVMX"
               Case "VARBIC"
                       Envia(2) = "ACAR"
               Case "VARBIV"
                       Envia(2) = "AVAR"
    End Select

    If Not Bac_Sql_Execute("SP_BUSCAR_CAMPO", Envia) Then
        
        MsgBox "Problemas con la Consulta ...", vbCritical + vbOKOnly, TITSISTEMA
        Exit Sub
    
    End If
    
    '-- Limpia Valores Contables
    
    Call Limpia
    
    I = 0
    
    Do While Bac_SQL_Fetch(datos())
        
        I = I + 1
        grdCampos.Row = grdCampos.Rows - 1
        grdCampos.TextMatrix(grdCampos.Row, 0) = datos(1)       '-- Sistema
        grdCampos.TextMatrix(grdCampos.Row, 1) = datos(2)       '-- Tipo de Movimiento
        grdCampos.TextMatrix(grdCampos.Row, 2) = datos(3)       '-- Tipo de Operacion
        grdCampos.TextMatrix(grdCampos.Row, 3) = Val(datos(4))  '-- Codigo Valor Contable
        grdCampos.TextMatrix(grdCampos.Row, 4) = datos(5)       '-- Glosa  Valor Contable
        grdCampos.TextMatrix(grdCampos.Row, 5) = IIf(datos(7) = "V", "Variable", "Fijo") '-- Tipo de Administracion
        grdCampos.Rows = grdCampos.Rows + 1
    
    Loop
    
    If I > 0 Then
        
        grdCampos.Rows = grdCampos.Rows - 1
    
    End If
    
    fraRelacion.Enabled = True
    Frame2.Enabled = False
    cmdlimpiar_Click
    
    Case 2
        Unload Me
End Select
End Sub

Private Sub Toolbar2_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Index
    Case 1
      cmdlimpiar_Click
    
    '---- Cheque si Tipo de Operacion tiene Valores Contables Asignados
    If grdCampos.TextMatrix(1, 0) = cmbSistema.Tag Then
        GoTo fin
    End If
    
    '---- Eliminando Tipo de Operación
    sError = "Este Tipo de Operación ya no registra Valores Contables" & vbCrLf
    sError = sError & "¿ Desea dejarla registrada ?"
    nerror = MsgBox(sError, vbQuestion + vbYesNoCancel, TITSISTEMA)
    If nerror = vbCancel Then
        Exit Sub
    ElseIf nerror <> vbNo Then
        MsgBox "Este Tipo de Operación seguirá registrado", vbInformation + vbOKOnly, TITSISTEMA
        GoTo fin
    End If

    '---- Elimina existencia Tipo de Operación
    sql = "DELETE FROM movimiento_cnt"
    sql = sql & " WHERE id_sistema = '" & cmbSistema.Tag & "'"
    sql = sql & "   AND tipo_movimiento = '" & cmbOperacion.Tag & "'"
    sql = sql & "   AND tipo_operacion = '" & Toolbar3.Buttons(4).Tag & "'"
    If MISQL.SQL_Execute(sql) <> 0 Then
        MsgBox "Problemas al tratar de Eliminar Tipo de Operación ...", vbCritical + vbOKOnly, TITSISTEMA
        Exit Sub
    End If
        
fin:
    Call Limpia
    fraRelacion.Enabled = False
    Frame2.Enabled = True
    TxtDescripcion.Text = ""
    

End Select
End Sub

Private Sub Toolbar3_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Index
    Case 1
        txtCodigo_DblClick
    
        If giAceptar = True Then
            cmdGrabar_Click
        End If
        
    Case 2
        txtCodigo.Text = ""
        TxtGlosa.Text = ""
        lblTipo.Caption = ""
        txtCodigo.SetFocus
    Case 3
        '---- Validando
        If Val(txtCodigo.Text) = 0 Or TxtGlosa.Tag = "" Then
            MsgBox "Debe seleccionar el Valor Contable que desea Eliminar", vbExclamation + vbOKOnly, TITSISTEMA
            Exit Sub
        End If

        '----
        Me.MousePointer = 11
        'ojo ver si el if esta bien colocado
        If MsgBox("Esta Seguro de Eliminar este elemento", 36, TITSISTEMA) = 6 Then
            nerror = 0
            sError = "Se Eliminó con éxito la relación ..."
        
            
            Envia = Array()
            
            AddParam Envia, cmbSistema.Tag
            AddParam Envia, cmbOperacion.Tag
            AddParam Envia, TipoOperacionMOV
            AddParam Envia, CDbl(txtCodigo)
            
            If Not Bac_Sql_Execute("SP_BORRAR_CAMPO", Envia) Then
                
                nerror = -1
                sError = "Problemas al Eliminar"
            
            End If
            
            If Bac_SQL_Fetch(datos()) Then
                
                nerror = datos(1)
                sError = datos(2)
            
            End If
            Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                                    , gsbac_fecp _
                                    , gsBac_IP _
                                    , gsBAC_User _
                                    , "PCA" _
                                    , "OPC_553 " _
                                    , "01" _
                                    , "Se Eliminó con éxito la relación ..." & " " & cmbSistema.Tag & " " & cmbOperacion.Tag & " " & TipoOperacionMOV _
                                    , " " _
                                    , " " _
                                    , " ")
    
        
        End If
            If nerror <> 0 Then
                sError = "Se presento el siguiente problema al intentar Eliminar" & vbCrLf & sError
                MsgBox sError, vbInformation + vbOKOnly, TITSISTEMA
            Else
                cmdRefresh_Click
            End If
        
        Me.MousePointer = 0
    
    Case 4
            '---- Validando
        If Val(txtCodigo.Text) = 0 Or TxtGlosa.Tag = "" Then
            MsgBox "Debe seleccionar el Valor Contable que desea Agregar", vbExclamation + vbOKOnly, TITSISTEMA
            Exit Sub
        End If
    
        '----
        Me.MousePointer = 11
        
        nerror = 0
        sError = "Se Grabo con éxito la relación ..."
        
        Envia = Array()
        
        AddParam Envia, cmbSistema.Tag
        AddParam Envia, cmbOperacion.Tag
        AddParam Envia, Toolbar3.Buttons(4).Tag
        AddParam Envia, CDbl(txtCodigo)
        AddParam Envia, TxtGlosa
        AddParam Envia, TxtGlosa.Tag
        AddParam Envia, Left(lblTipo, 1)
        AddParam Envia, ""
        AddParam Envia, ""
        AddParam Envia, ""
        
        If Not Bac_Sql_Execute("SP_GRABAR_CAMPO", Envia) Then
            
            nerror = -1
            sError = "Problemas al Grabar"
        
        End If
        
        If Bac_SQL_Fetch(datos()) = 0 Then
            
            nerror = Val(datos(1))
            sError = datos(2)
        
        End If
        
        If nerror <> 0 Then
            
            sError = "Se presento el siguiente problema al intentar grabar" & vbCrLf & sError
            MsgBox sError, vbInformation + vbOKOnly, TITSISTEMA
        
        Else
            Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                                    , gsbac_fecp _
                                    , gsBac_IP _
                                    , gsBAC_User _
                                    , "PCA" _
                                    , "OPC_553 " _
                                    , "01" _
                                    , "Se Grabo con éxito la relación " & " " & cmbSistema.Tag & " " & cmbOperacion.Tag & " " & lblTipo _
                                    , " " _
                                    , " " _
                                    , " ")
             MsgBox sError, vbInformation + vbOKOnly, TITSISTEMA
            cmdRefresh_Click
        
        End If
        
        Me.MousePointer = 0

End Select
End Sub

Private Sub txtCodigo_DblClick()

    BacControlWindows 100
    
    BacAyuda.Tag = "CAMPOS"
    BacAyuda.parAyuda = "BAC_CNT_CAMPOS"
    BacAyuda.parFiltro = cmbSistema.Tag
    
    BacAyuda.Show 1
    
    If giAceptar = True Then
        txtCodigo = Val(gsCodigo)
        txtCodigo_KeyPress 13
    End If

End Sub
Private Sub txtCodigo_KeyPress(KeyAscii As Integer)
    
    If KeyAscii = 13 Then
        If Val(txtCodigo.Text) <= 0 Then
            MsgBox "Debe indicar campo a Chequear o Crear" & vbCrLf & "Presione doble click si necesita Ayuda", vbInformation + vbOKOnly, TITSISTEMA
            Exit Sub
        End If
        If Val(txtCodigo.Text) > 0 Then
            Call BuscarValorContable("BUSCAR")
        End If
        If Len(Trim(TxtGlosa.Text)) = 0 Then
            TxtGlosa.SetFocus
        Else
            cmdGrabar_Click
        End If
    ElseIf InStr("0132456789", Chr(KeyAscii)) = 0 And KeyAscii <> 8 Then
        KeyAscii = 0
    End If
    
End Sub


Private Sub txtDescripcion_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        
    Else
        KeyAscii = Asc(UCase(Chr(KeyAscii)))
    End If
End Sub

Private Sub txtGlosa_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        If Len(Trim(txtCodigo.Text)) = 0 Then
            MsgBox "Debe especificar la descripción del Campo", vbInformation + vbOKOnly, TITSISTEMA
            Exit Sub
        End If
        
    Else
        KeyAscii = Asc(UCase(Chr(KeyAscii)))
    End If
End Sub


Private Function TipoOperacionMOV() As String

Dim tipoEvento As String
Dim CodProducto As String
Dim tipoOperacion   As String

CodProducto = Trim(Right(cmbProducto, 5))
tipoEvento = IIf(chkEvento.Value = 1, chkEvento.Tag, "")
    
    If cmbSistema.Tag = "PCS" Then
        Select Case CodProducto 'Toolbar3.Buttons(4).Tag
            Case "ST"
                tipoOperacion = 1
            Case "SM"
                tipoOperacion = 2
            Case "FR"
                tipoOperacion = 3
        End Select
    Else
        tipoOperacion = CodProducto
    End If

    tipoOperacion = tipoEvento & tipoOperacion
    '---- Armado del Tipo_Operacion para bac_cnt_campos
    tipoOperacion = tipoOperacion & IIf(OptTipOpe(0).Value, "C", "V")
        
    TipoOperacionMOV = tipoOperacion
End Function
