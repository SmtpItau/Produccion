VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "threed32.ocx"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form bacMntCampos 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Mantención de Valores a Contabilizar"
   ClientHeight    =   7575
   ClientLeft      =   1455
   ClientTop       =   975
   ClientWidth     =   8430
   Icon            =   "BacMntCampos.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   7575
   ScaleWidth      =   8430
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
            Begin VB.CheckBox Chk_Vcto 
               Caption         =   "Vcto."
               Height          =   255
               Left            =   7200
               TabIndex        =   25
               Top             =   1200
               Visible         =   0   'False
               Width           =   855
            End
            Begin VB.CheckBox Check1 
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
               Left            =   0
               TabIndex        =   24
               Top             =   0
               Width           =   1905
            End
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
               ItemData        =   "BacMntCampos.frx":74F2
               Left            =   2085
               List            =   "BacMntCampos.frx":74F4
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
                  Height          =   450
                  Left            =   5790
                  TabIndex        =   11
                  Top             =   3240
                  Width           =   1905
                  _ExtentX        =   3360
                  _ExtentY        =   794
                  ButtonWidth     =   820
                  ButtonHeight    =   794
                  Style           =   1
                  ImageList       =   "Img_opciones"
                  _Version        =   393216
                  BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
                     NumButtons      =   4
                     BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
                        Object.ToolTipText     =   "Agregar"
                        ImageIndex      =   10
                     EndProperty
                     BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
                        Object.ToolTipText     =   "Limpiar"
                        ImageIndex      =   1
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
               Begin MSComctlLib.Toolbar Toolbar2 
                  Height          =   450
                  Left            =   5370
                  TabIndex        =   10
                  Top             =   3240
                  Width           =   465
                  _ExtentX        =   820
                  _ExtentY        =   794
                  ButtonWidth     =   820
                  ButtonHeight    =   794
                  AllowCustomize  =   0   'False
                  Style           =   1
                  ImageList       =   "Img_opciones"
                  _Version        =   393216
                  BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
                     NumButtons      =   1
                     BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
                        Object.ToolTipText     =   "Volver"
                        ImageIndex      =   9
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
                  MouseIcon       =   "BacMntCampos.frx":74F6
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
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   480
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   8430
      _ExtentX        =   14870
      _ExtentY        =   847
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "Img_opciones"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList Img_opciones 
         Left            =   6870
         Top             =   -90
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
               Picture         =   "BacMntCampos.frx":7800
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntCampos.frx":7C67
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntCampos.frx":815D
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntCampos.frx":85F0
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntCampos.frx":8AD8
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntCampos.frx":8FEB
               Key             =   ""
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntCampos.frx":94BE
               Key             =   ""
            EndProperty
            BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntCampos.frx":9984
               Key             =   ""
            EndProperty
            BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntCampos.frx":9E7B
               Key             =   ""
            EndProperty
            BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntCampos.frx":A274
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
End
Attribute VB_Name = "bacMntCampos"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim Sql$, Datos(), i&

Dim nerror%, sError$
Dim PRUEBA As String
Dim Tipo_Operac As String
Dim objCodigo As Object
Private Sub BuscarValorContable(Buscar$)


    Me.MousePointer = 11
    Envia = Array()
    
    AddParam Envia, CmbSistema.Tag
    

    
'    If Buscar = "" Then
'        AddParam Envia, cmbOperacion.Tag
'        AddParam Envia, Toolbar3.Buttons(4).Tag
'    Else
'        AddParam Envia, ""
'        AddParam Envia, ""
'
'    End If
    
    If chkEvento.Tag = "D" Then
       Tipo_Operac = IIf(chkEvento.Value = 1, "DEV", "")
       Tipo_Operac = IIf(Chk_Vcto.Value = 1, "VEN", "DEV")
    Else
       Tipo_Operac = IIf(OptTipOpe(0).Value = True, "ING", "VEN") 'IIf(chkEvento.Value = 1, "VC ", tipoOperacion)
    End If

    Toolbar3.Buttons(4).Tag = Tipo_Operac
    AddParam Envia, Tipo_Operac
    PRUEBA = right(CmbProducto, 5)
    AddParam Envia, PRUEBA 'cmbOperacion.Tag

    AddParam Envia, CDbl(txtCodigo.Text)
    
    If Not BAC_SQL_EXECUTE("sp_Buscar_Campo", Envia) Then
        
        MsgBox "Problemas al tratar de traer datos de Valor Contable solicitado", vbExclamation + vbOKOnly, TITSISTEMA
        GoTo fin
    
    End If
    
    If BAC_SQL_FETCH(Datos()) Then
        TxtGlosa.Text = Datos(5)
        TxtGlosa.Tag = Datos(6)
        lblTipo.Caption = Datos(7)
    Else
        cmdlimpiar_Click
        MsgBox "Valor Contable no se encontro ...", vbExclamation + vbOKOnly, TITSISTEMA
    End If
        
fin:
   
    Me.MousePointer = 0

End Sub
Sub PROC_CARGA_COMBO_SISTEMA()

    On Error GoTo ErrCarga
    
    If BAC_SQL_EXECUTE("SP_BUSCAR_SISTEMAS ") Then
        
        CmbSistema.Clear
        
        Do While BAC_SQL_FETCH(Datos())
            CmbSistema.AddItem Mid$(Datos(2), 1, 15) & Space(50) & Datos(1)
        Loop
    Else
        MsgBox "No se pudo obtener información del servidor", vbCritical, TITSISTEMA
        Exit Sub
    End If
    
    Exit Sub
    
ErrCarga:
    MsgBox "Se detectó problemas en carga de información: " & err.Description & ". Comunique al Administrador.", vbCritical, TITSISTEMA
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
    For i = 0 To grdCampos.Cols - 1
        grdCampos.ColWidth(i) = TextWidth(grdCampos.TextMatrix(0, i)) * IIf(i = 4, 2.5, 1.5)
        grdCampos.ColAlignment(i) = 0
    Next i

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
        CmbProducto.SetFocus
    End If
End Sub
Private Sub cmbOperacion_LostFocus()
    With cmbOperacion
        If .ListIndex >= 0 Then
            .Tag = right(.List(.ListIndex), 3)
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
        Chk_Vcto.Visible = False
    ElseIf cmbOperacion.Tag = "MTM" Then
        chkEvento.Caption = "&Mark to Market"
        chkEvento.Tag = "MTM"
        chkEvento.Value = 1
        chkEvento.Enabled = False
    Else
        chkEvento.Caption = "&Devengamiento"
        chkEvento.Tag = "D"
        chkEvento.Value = 1
        chkEvento.Enabled = False
        Chk_Vcto.Visible = True
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
    With CmbProducto
        If .ListIndex >= 0 Then
            .Tag = Trim(right(CmbProducto, 5))
        Else
            .Tag = ""
        End If
    End With
End Sub

Private Sub CmbSistema_Click()
    With CmbSistema
        If .ListIndex >= 0 Then
            .Tag = Trim(right(.List(.ListIndex), 5))
        Else
            .Tag = ""
        End If
        
         Set objCodigo = New clsCodigo
        If objCodigo.CargaProductos(CmbProducto, .Tag) Then
            cmbProducto_LostFocus
        End If
        Set objCodigo = Nothing
        txtDescripcion.Text = ""
        If Trim(right(.List(.ListIndex), 5)) = "BCC" Then
            cmbOperacion.Clear
            cmbOperacion.AddItem left("MOVIMIENTO          " & Space(50), 50) & "MOV"
            cmbOperacion.ListIndex = 0
            cmbOperacion_LostFocus
        Else
            cmbOperacion.Clear
            cmbOperacion.AddItem left("MOVIMIENTO          " & Space(50), 50) & "MOV"
            cmbOperacion.AddItem left("DEVENGAMIENTO       " & Space(50), 50) & "DEV"
            cmbOperacion.AddItem left("MARK TO MARKET      " & Space(50), 50) & "MTM"
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

    With CmbSistema
        If .ListIndex >= 0 Then
            .Tag = Trim(right(.List(.ListIndex), 5))
        Else
            .Tag = ""
        End If
        
         Set objCodigo = New clsCodigo
        If objCodigo.CargaProductos(CmbProducto, .Tag) Then
            cmbProducto_LostFocus
        End If
        Set objCodigo = Nothing
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
    
        Envia = Array()
        AddParam Envia, CmbSistema.Tag
        AddParam Envia, cmbOperacion.Tag
        AddParam Envia, Toolbar3.Buttons(4).Tag
        AddParam Envia, CDbl(txtCodigo)
        If Not BAC_SQL_EXECUTE("sp_Borrar_Campo ", Envia) Then
            nerror = -1
            sError = "Problemas al Eliminar"
        End If
        
        If BAC_SQL_FETCH(Datos()) Then
            nerror = Datos(1)
            sError = Datos(2)
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
    AddParam Envia, CmbSistema.Tag
    AddParam Envia, Toolbar3.Buttons(4).Tag
    PRUEBA = right(CmbProducto, 5)
    AddParam Envia, PRUEBA 'AddParam Envia, cmbOperacion.Tag

    AddParam Envia, CDbl(txtCodigo)
    AddParam Envia, TxtGlosa
    AddParam Envia, TxtGlosa.Tag
    AddParam Envia, left(lblTipo, 1)
    AddParam Envia, ""
    AddParam Envia, ""
    AddParam Envia, ""
    
    If Not BAC_SQL_EXECUTE("sp_Grabar_Campo", Envia) Then
        nerror = -1
        sError = "Problemas al Grabar"
    End If
    
    If BAC_SQL_FETCH(Datos()) Then
        
        nerror = Datos(1)
        sError = Datos(2)
    
    End If
    
    If nerror <> 0 Then
        
        sError = "Se presento el siguiente problema al intentar grabar" & vbCrLf & sError
        MsgBox sError, vbInformation + vbOKOnly, TITSISTEMA
    
    Else
        Call Grabar_Log_Auditoria(giBAC_Entidad _
                                    , gsbac_fecp _
                                    , gsBAC_Term _
                                    , gsBAC_User _
                                    , "PCA" _
                                    , "OPC_553 " _
                                    , "02" _
                                    , "Grabado" & " " & CmbSistema.Tag & " " & cmbOperacion.Tag & " " & TipoOperacionMOV _
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
    txtCodigo.SetFocus

End Sub

Private Sub cmdNew_Click()

    txtCodigo_DblClick
    
    If giAceptar = True Then
        cmdGrabar_Click
    End If

End Sub

Private Sub cmdRefresh_Click()
    
    If CmbSistema.Tag = "" Then
        MsgBox "Sistema no ha sido definido", vbInformation + vbOKOnly, TITSISTEMA
        Exit Sub
    End If

    '---- Armado del Tipo_Operacion para bac_cnt_campos
    Toolbar3.Buttons(4).Tag = TipoOperacionMOV
        
    '---- Valida existencia Tipo de Operación
    PRUEBA = right(CmbProducto, 5)
    Sql = ""
    Sql = "SELECT glosa_operacion FROM movimiento_cnt"
    Sql = Sql & " WHERE id_sistema = '" & CmbSistema.Tag & "'"
    'Sql = Sql & "   AND tipo_movimiento = '" & cmbOperacion.Tag & "'"
    'Sql = Sql & "   AND tipo_operacion = '" & Toolbar3.Buttons(4).Tag & "'"
    Sql = Sql & "   AND tipo_movimiento = '" & Toolbar3.Buttons(4).Tag & "'"
    Sql = Sql & "   AND tipo_operacion = '" & PRUEBA & "'"
    
    If Not BAC_SQL_EXECUTE(Sql) Then
        MsgBox "Problemas con la Consulta ...", vbCritical + vbOKOnly, TITSISTEMA
        Exit Sub
    End If
    '---- Agrega nuevo Tipo de Operación a bac_cnt_movimiento
    nerror = -1
    sError = "Este Tipo de Operación no esta registrado"
    If BAC_SQL_FETCH(Datos()) Then
        nerror = 0
        txtDescripcion.Text = Datos(1)
    End If
    If nerror <> 0 Then
        txtDescripcion = Trim(txtDescripcion)
        If txtDescripcion = "" Then
            If chkEvento.Value = 1 Then
                txtDescripcion.Text = IIf(chkEvento.Tag = "V", "VCTO.", "DEV.")
            End If
            txtDescripcion.Text = txtDescripcion.Text & Trim(left(CmbProducto, 50))
            txtDescripcion.Text = txtDescripcion.Text & IIf(OptTipOpe(0).Value, " COMPRA ", " VENTA ")
        End If
        sError = sError & vbCrLf & vbCrLf & txtDescripcion.Text
        sError = sError & vbCrLf & vbCrLf & "¿ Desea registrarla ?"
        If MsgBox(sError, vbQuestion + vbYesNo, TITSISTEMA) <> vbYes Then
            Exit Sub
        End If
        Sql = "INSERT INTO bac_cnt_movimiento VALUES( '" & CmbSistema.Tag & "'"
        Sql = Sql & ",'" & cmbOperacion.Tag & "'"
        Sql = Sql & ",'" & Trim(left(cmbOperacion.Text, 50)) & "'"
        Sql = Sql & ",'" & Toolbar3.Buttons(4).Tag & "'"
        Sql = Sql & ",'" & Trim(txtDescripcion) & "'"
        Sql = Sql & ", 1"       '-- Tipo de Voucher    PENDIENTE definición
        Sql = Sql & ",'N'"      '-- Tipo de Movimiento Caja ???
        Sql = Sql & ",'N'"      '-- Controla Instrumento
        Sql = Sql & ",'S'"     '-- Controla Moneda
        Sql = Sql & ",'')"
        If Not BAC_SQL_EXECUTE(Sql) Then
            MsgBox "Problemas al Grabar nuevo Tipo de Operación ...", vbCritical + vbOKOnly, TITSISTEMA
            Exit Sub
        End If
    End If

    Envia = Array()
    AddParam Envia, CmbSistema.Tag
    If chkEvento.Tag = "D" Then
       Tipo_Operac = IIf(chkEvento.Value = 1, "DEV", "")
       Tipo_Operac = IIf(Chk_Vcto.Value = 1, "VEN", "DEV")
    Else
       Tipo_Operac = IIf(OptTipOpe(0).Value = True, "ING", "VEN")
    End If

    Toolbar3.Buttons(4).Tag = Tipo_Operac
    AddParam Envia, Tipo_Operac
    PRUEBA = right(CmbProducto, 5)
    AddParam Envia, PRUEBA
    AddParam Envia, CDbl(0)
    
    

'    AddParam Envia, cmbOperacion.Tag
'    AddParam Envia, Toolbar3.Buttons(4).Tag
'    AddParam Envia, CDbl(0)
    
    If Not BAC_SQL_EXECUTE("sp_Buscar_Campo", Envia) Then
        
        MsgBox "Problemas con la Consulta ...", vbCritical + vbOKOnly, TITSISTEMA
        Exit Sub
    
    End If
    
    '-- Limpia Valores Contables
    Call Limpia
    
    i = 0
    
    Do While BAC_SQL_FETCH(Datos())
        i = i + 1
        grdCampos.Row = grdCampos.Rows - 1
        grdCampos.TextMatrix(grdCampos.Row, 0) = Datos(1)       '-- Sistema
        grdCampos.TextMatrix(grdCampos.Row, 1) = Datos(2)       '-- Tipo de Movimiento
        grdCampos.TextMatrix(grdCampos.Row, 2) = Datos(3)       '-- Tipo de Operacion
        grdCampos.TextMatrix(grdCampos.Row, 3) = Val(Datos(4))  '-- Codigo Valor Contable
        grdCampos.TextMatrix(grdCampos.Row, 4) = Datos(5)       '-- Glosa  Valor Contable
        grdCampos.TextMatrix(grdCampos.Row, 5) = IIf(Datos(7) = "V", "Variable", "Fijo") '-- Tipo de Administracion
        grdCampos.Rows = grdCampos.Rows + 1
    Loop
    
    If i > 0 Then
        grdCampos.Rows = grdCampos.Rows - 1
    End If
    
    fraRelacion.Enabled = True
    Frame2.Enabled = False
    cmdlimpiar_Click

End Sub
Private Sub cmdVolver_Click()

    cmdlimpiar_Click
    
    '---- Cheque si Tipo de Operacion tiene Valores Contables Asignados
    If grdCampos.TextMatrix(1, 0) = CmbSistema.Tag Then
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
    Sql = "DELETE FROM movimiento_cnt"
    Sql = Sql & " WHERE id_sistema = '" & CmbSistema.Tag & "'"
    Sql = Sql & "   AND tipo_movimiento = '" & cmbOperacion.Tag & "'"
    Sql = Sql & "   AND tipo_operacion = '" & Toolbar3.Buttons(4).Tag & "'"
    If Not BAC_SQL_EXECUTE(Sql) Then
        MsgBox "Problemas al tratar de Eliminar Tipo de Operación ...", vbCritical + vbOKOnly, TITSISTEMA
        Exit Sub
    End If
        
fin:
    Call Limpia
    fraRelacion.Enabled = False
    Frame2.Enabled = True
    txtDescripcion.Text = ""
    

End Sub

Private Sub Form_Activate()

    '-- Carga Sistema
    PROC_CARGA_COMBO_SISTEMA
    bacBuscarComboR CmbSistema, Sistema
    cmbSistema_LostFocus
    If CmbSistema.Tag = "" Then
        MsgBox "Sistema " & Chr(32) & Sistema & Chr(32) & " NO existe , debe generarlo", vbCritical + vbOKOnly, TITSISTEMA
        Unload Me
        Exit Sub
    End If

    '---- Tipo de Operación
    cmbOperacion.Clear
    cmbOperacion.AddItem left("MOVIMIENTO          " & Space(50), 50) & "MOV"
    cmbOperacion.AddItem left("DEVENGAMIENTO       " & Space(50), 50) & "DEV"
    cmbOperacion.ListIndex = 0
    cmbOperacion_LostFocus
    
    '---- Tipo de Producto
    Set objCodigo = New clsCodigo
    If objCodigo.CargaObjetos(CmbProducto, MDTC_TIPOSWAP) Then
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
    Me.top = 0
    Me.left = 0
    Me.Icon = BAC_Parametros.Icon
    
    Call Grabar_Log_Auditoria(giBAC_Entidad _
                          , gsbac_fecp _
                          , gsBAC_Term _
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
    If CmbSistema.Tag = "" Then
        MsgBox "Sistema no ha sido definido", vbInformation + vbOKOnly, TITSISTEMA
        Exit Sub
    End If
    
    If CmbProducto.ListCount = 0 Then
        MsgBox "Productos no se han definido No existe Relación", vbInformation + vbOKOnly, TITSISTEMA
        Exit Sub
    End If

    If CmbProducto.ListIndex = -1 Then
        MsgBox "Debe seleccionar el Producto", vbInformation + vbOKOnly, TITSISTEMA
        Exit Sub
    End If
   
    
    tipoOperacion = TipoOperacionMOV
        
    Toolbar3.Buttons(4).Tag = tipoOperacion
    
    Envia = Array()
    
    PRUEBA = right(CmbProducto, 5)
    AddParam Envia, CmbSistema.Tag
    AddParam Envia, PRUEBA
    AddParam Envia, Toolbar3.Buttons(4).Tag
    'AddParam Envia, cmbOperacion.Tag
    
    
    
    If Not BAC_SQL_EXECUTE("sp_bacmntcampos_selctglosa", Envia) Then
        MsgBox "Problemas con la Consulta ...", vbCritical + vbOKOnly, TITSISTEMA
        Exit Sub
    End If
    '---- Agrega nuevo Tipo de Operación a bac_cnt_movimiento
    nerror = -1
    sError = "Este Tipo de Operación no esta registrado"
    
    If BAC_SQL_FETCH(Datos()) Then
        
        nerror = 0
        txtDescripcion.Text = Datos(1)
    
    End If
    
    If nerror <> 0 Then
        
        txtDescripcion = Trim(txtDescripcion)
        
        If txtDescripcion = "" Then
            
            If chkEvento.Value = 1 Then
                
                txtDescripcion.Text = IIf(chkEvento.Tag = "V", "VCTO.", "DEV.")
                If Chk_Vcto.Value = 1 Then
                    txtDescripcion.Text = "VENCIMIENTO "
                End If
            
            End If
            
            txtDescripcion.Text = txtDescripcion.Text & Trim(left(CmbProducto, 50))
            txtDescripcion.Text = txtDescripcion.Text & IIf(OptTipOpe(0).Value, " COMPRA ", " VENTA ")
             
            If cmbOperacion.Tag = "MTM" Then
                    txtDescripcion.Text = cmbOperacion.Tag & "." & txtDescripcion.Text
            End If
        
        End If
        
        sError = sError & vbCrLf & vbCrLf & txtDescripcion.Text
        sError = sError & vbCrLf & vbCrLf & "¿ Desea registrarla ?"
        
        If MsgBox(sError, vbQuestion + vbYesNo, TITSISTEMA) <> vbYes Then
            
            Exit Sub
        
        End If
        
        Envia = Array()
        
        If CmbSistema.Tag = "PCS" Then
            ControlMon = "S"
            ControlMonInst = "N"
            Select Case CmbProducto.Tag 'Toolbar3.Buttons(4).Tag
                Case "ST"
                 '   CodProducto = 1
                Case "SM"
                  '  CodProducto = 2
                Case "FR"
                   ' CodProducto = 3
            End Select
        ElseIf CmbSistema.Tag = "BFW" Then
            ControlMon = "N"
            ControlMonInst = IIf(cmbOperacion.Tag = "DEV", "N", "S")
        End If
        Sql = ""
        
        
        AddParam Envia, CmbSistema.Tag
        AddParam Envia, tipoOperacion '
        AddParam Envia, PRUEBA 'cmbOperacion.Tag
        If Chk_Vcto.Value = 1 Then
            AddParam Envia, "VENCIMIENTO"
        Else
            AddParam Envia, Trim(left(cmbOperacion.Text, 50)) 'CodProducto
        End If


        AddParam Envia, Trim(txtDescripcion)
        AddParam Envia, 1       '-- Tipo de Voucher    PENDIENTE definición
        AddParam Envia, "N"      '-- Tipo de Movimiento Caja ???
        AddParam Envia, ControlMonInst      '-- Controla Instrumento
        AddParam Envia, ControlMon     '-- Controla Moneda
        AddParam Envia, "S"
        If Not BAC_SQL_EXECUTE("sp_bacmntcampos_GRABA", Envia) Then
            MsgBox "Problemas al Grabar nuevo Tipo de Operación ...", vbCritical + vbOKOnly, TITSISTEMA
            Exit Sub
        End If
    End If

    '---- Carga
    Envia = Array()
    AddParam Envia, CmbSistema.Tag
    AddParam Envia, Toolbar3.Buttons(4).Tag
    AddParam Envia, PRUEBA 'cmbOperacion.Tag
    AddParam Envia, CDbl(0)
    
    If Not BAC_SQL_EXECUTE("sp_Buscar_Campo", Envia) Then
        MsgBox "Problemas con la Consulta ...", vbCritical + vbOKOnly, TITSISTEMA
        Exit Sub
    End If
    
    '-- Limpia Valores Contables
    
    Call Limpia
    
    i = 0
    
    Do While BAC_SQL_FETCH(Datos())
        
        i = i + 1
        grdCampos.Row = grdCampos.Rows - 1
        grdCampos.TextMatrix(grdCampos.Row, 0) = Datos(1)       '-- Sistema
        grdCampos.TextMatrix(grdCampos.Row, 1) = Datos(2)       '-- Tipo de Movimiento
        grdCampos.TextMatrix(grdCampos.Row, 2) = Datos(3)       '-- Tipo de Operacion
        grdCampos.TextMatrix(grdCampos.Row, 3) = Val(Datos(4))  '-- Codigo Valor Contable
        grdCampos.TextMatrix(grdCampos.Row, 4) = Datos(5)       '-- Glosa  Valor Contable
        grdCampos.TextMatrix(grdCampos.Row, 5) = IIf(Datos(7) = "V", "Variable", "Fijo") '-- Tipo de Administracion
        grdCampos.Rows = grdCampos.Rows + 1
    
    Loop
    
    If i > 0 Then
        
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
    If grdCampos.TextMatrix(1, 0) = CmbSistema.Tag Then
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
    Sql = "DELETE FROM movimiento_cnt"
    Sql = Sql & " WHERE id_sistema = '" & CmbSistema.Tag & "'"
    Sql = Sql & "   AND tipo_movimiento = '" & cmbOperacion.Tag & "'"
    Sql = Sql & "   AND tipo_operacion = '" & Toolbar3.Buttons(4).Tag & "'"
    If Not BAC_SQL_EXECUTE(Sql) Then
        MsgBox "Problemas al tratar de Eliminar Tipo de Operación ...", vbCritical + vbOKOnly, TITSISTEMA
        Exit Sub
    End If
        
fin:
    Call Limpia
    fraRelacion.Enabled = False
    Frame2.Enabled = True
    txtDescripcion.Text = ""
    

End Select
End Sub

Private Sub Toolbar3_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Index
    Case 1
        txtCodigo_DblClick
    
        If giAceptar = True Then
            'cmdGrabar_Click
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
        
            PRUEBA = right(CmbProducto, 5)
            
            Envia = Array()
            
            AddParam Envia, CmbSistema.Tag
            AddParam Envia, TipoOperacionMOV
            AddParam Envia, PRUEBA 'cmbOperacion.Tag
            AddParam Envia, CDbl(txtCodigo)
            
            If Not BAC_SQL_EXECUTE("sp_Borrar_Campo", Envia) Then
                
                nerror = -1
                sError = "Problemas al Eliminar"
            
            End If
            
            If BAC_SQL_FETCH(Datos()) Then
                
                nerror = Datos(1)
                sError = Datos(2)
            
            End If
            Call Grabar_Log_Auditoria(giBAC_Entidad _
                                    , gsbac_fecp _
                                    , gsBAC_Term _
                                    , gsBAC_User _
                                    , "PCA" _
                                    , "OPC_553 " _
                                    , "01" _
                                    , "Se Eliminó con éxito la relación ..." & " " & CmbSistema.Tag & " " & cmbOperacion.Tag & " " & TipoOperacionMOV _
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
        
        AddParam Envia, CmbSistema.Tag
        AddParam Envia, cmbOperacion.Tag
        AddParam Envia, Toolbar3.Buttons(4).Tag
        AddParam Envia, CDbl(txtCodigo)
        AddParam Envia, TxtGlosa
        AddParam Envia, TxtGlosa.Tag
        AddParam Envia, left(lblTipo, 1)
        AddParam Envia, ""
        AddParam Envia, ""
        AddParam Envia, ""
        
        If Not BAC_SQL_EXECUTE("sp_Grabar_Campo", Envia) Then
            
            nerror = -1
            sError = "Problemas al Grabar"
        
        End If
        
        If BAC_SQL_FETCH(Datos()) = 0 Then
            
            nerror = Val(Datos(1))
            sError = Datos(2)
        
        End If
        
        If nerror <> 0 Then
            
            sError = "Se presento el siguiente problema al intentar grabar" & vbCrLf & sError
            MsgBox sError, vbInformation + vbOKOnly, TITSISTEMA
        
        Else
            Call Grabar_Log_Auditoria(giBAC_Entidad _
                                    , gsbac_fecp _
                                    , gsBAC_Term _
                                    , gsBAC_User _
                                    , "PCA" _
                                    , "OPC_553 " _
                                    , "01" _
                                    , "Se Grabo con éxito la relación " & " " & CmbSistema.Tag & " " & cmbOperacion.Tag & " " & lblTipo _
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

    Dim Tipo_Movto As String
    Dim Tipo_Opera As String
    BacControlWindows 100
    
    MiTag = "CAMPOS"
    PRUEBA = right(CmbProducto, 5)
    Tipo_Opera = PRUEBA 'right(cmbOperacion, 3) 'IIf(OptTipOpe(0).Value, "ING", "VEN")
    If chkEvento.Tag = "D" Then
       'Tipo_Movto = IIf(chkEvento.Value = 1, "DEV", Tipo_Movto)
       Tipo_Movto = IIf(Chk_Vcto.Value = 1, "VEN", "DEV")
    Else
       
       Tipo_Movto = IIf(OptTipOpe(0).Value = True, "ING", "V")
    End If

    
    
    BacAyuda.parAyuda = "BAC_CNT_CAMPOS "
    BacAyuda.parFiltro = CmbSistema.Tag
    BacAyuda.parTipoMo = Tipo_Movto
    BacAyuda.parTipoOp = Tipo_Opera
    BacAyuda.Tag = "CAMPOS"
    
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

Private Sub TxtDescripcion_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        
    Else
        KeyAscii = Asc(UCase(Chr(KeyAscii)))
    End If
End Sub

Private Sub Txtglosa_KeyPress(KeyAscii As Integer)
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

CodProducto = Trim(right(CmbProducto, 5))
tipoEvento = IIf(chkEvento.Value = 1, chkEvento.Tag, "")
    
    If CmbSistema.Tag = "PCS" Then
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
    If CmbSistema.Tag <> "PCS" Then
        'tipoOperacion = tipoOperacion & IIf(OptTipOpe(0).Value, "C", "V")
        If chkEvento.Tag = "D" Then
            tipoOperacion = IIf(chkEvento.Value = 1, "DEV", tipoOperacion)
            tipoOperacion = IIf(Chk_Vcto.Value = 1, "VEN", "DEV")
        Else
            tipoOperacion = IIf(OptTipOpe(0).Value = True, "ING", "VEN") 'IIf(chkEvento.Value = 1, "VC ", tipoOperacion)
        End If
         ' chkEvento.Tag
    End If
    
    
    
    
    TipoOperacionMOV = tipoOperacion
End Function
