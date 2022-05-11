VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form bacMntCampos 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Mantención de Valores a Contabilizar"
   ClientHeight    =   7020
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   8355
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   7020
   ScaleWidth      =   8355
   ShowInTaskbar   =   0   'False
   Begin VB.Frame fraOperacion 
      Height          =   6990
      Left            =   0
      TabIndex        =   15
      Top             =   0
      Width           =   8340
      Begin VB.Frame Frame2 
         Caption         =   "Tipo Operación"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   2175
         Left            =   120
         TabIndex        =   20
         Top             =   240
         Width           =   6912
         Begin VB.TextBox txtDescripcion 
            Height          =   315
            Left            =   1560
            MaxLength       =   60
            TabIndex        =   3
            Top             =   1650
            Width           =   4344
         End
         Begin VB.CheckBox chkEvento 
            Caption         =   "Evento Especial"
            BeginProperty Font 
               Name            =   "Times New Roman"
               Size            =   9.75
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   255
            Left            =   4560
            TabIndex        =   6
            Top             =   1260
            Width           =   2055
         End
         Begin VB.ComboBox cmbProducto 
            Height          =   288
            Left            =   1560
            Style           =   2  'Dropdown List
            TabIndex        =   2
            Top             =   1260
            Width           =   2592
         End
         Begin VB.ComboBox cmbOperacion 
            Height          =   288
            Left            =   1560
            Style           =   2  'Dropdown List
            TabIndex        =   1
            Top             =   870
            Width           =   2592
         End
         Begin VB.ComboBox cmbSistema 
            Height          =   288
            Left            =   1560
            Style           =   2  'Dropdown List
            TabIndex        =   0
            Top             =   480
            Width           =   2616
         End
         Begin VB.OptionButton OptTipOpe 
            Caption         =   "&Compra"
            BeginProperty Font 
               Name            =   "Times New Roman"
               Size            =   9.75
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Index           =   0
            Left            =   4560
            TabIndex        =   4
            Top             =   480
            Value           =   -1  'True
            Width           =   1215
         End
         Begin VB.OptionButton OptTipOpe 
            Caption         =   "&Venta"
            BeginProperty Font 
               Name            =   "Times New Roman"
               Size            =   9.75
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Index           =   1
            Left            =   4560
            TabIndex        =   5
            Top             =   840
            Width           =   1215
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "Descripción"
            BeginProperty Font 
               Name            =   "Times New Roman"
               Size            =   9.75
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   225
            Index           =   4
            Left            =   360
            TabIndex        =   24
            Top             =   1695
            Width           =   990
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "Producto"
            BeginProperty Font 
               Name            =   "Times New Roman"
               Size            =   9.75
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   225
            Index           =   2
            Left            =   360
            TabIndex        =   23
            Top             =   1305
            Width           =   735
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "Operación"
            BeginProperty Font 
               Name            =   "Times New Roman"
               Size            =   9.75
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   225
            Index           =   1
            Left            =   360
            TabIndex        =   22
            Top             =   915
            Width           =   855
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "Sistema"
            BeginProperty Font 
               Name            =   "Times New Roman"
               Size            =   9.75
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   225
            Index           =   0
            Left            =   360
            TabIndex        =   21
            Top             =   525
            Width           =   660
         End
      End
      Begin VB.Frame fraRelacion 
         Height          =   4590
         Left            =   120
         TabIndex        =   16
         Top             =   2400
         Width           =   8130
         Begin Threed.SSPanel SSPanel1 
            Height          =   4230
            Left            =   120
            TabIndex        =   17
            Top             =   240
            Width           =   7935
            _Version        =   65536
            _ExtentX        =   13996
            _ExtentY        =   7461
            _StockProps     =   15
            BackColor       =   12632256
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
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
               Height          =   315
               Left            =   1875
               MaxLength       =   3
               MouseIcon       =   "bacmntcampos.frx":0000
               MousePointer    =   99  'Custom
               TabIndex        =   7
               Top             =   180
               Width           =   735
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
               Height          =   315
               Left            =   2715
               MaxLength       =   60
               TabIndex        =   8
               Top             =   180
               Width           =   3735
            End
            Begin Threed.SSCommand cmdGrabar 
               Height          =   780
               Left            =   6885
               TabIndex        =   14
               ToolTipText     =   "Grabar"
               Top             =   3330
               Width           =   960
               _Version        =   65536
               _ExtentX        =   1693
               _ExtentY        =   1376
               _StockProps     =   78
               Caption         =   "&Grabar"
               BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Font3D          =   1
               Picture         =   "bacmntcampos.frx":030A
            End
            Begin Threed.SSCommand cmdEliminar 
               Height          =   780
               Left            =   5895
               TabIndex        =   13
               ToolTipText     =   "Eliminar"
               Top             =   3330
               Width           =   960
               _Version        =   65536
               _ExtentX        =   1693
               _ExtentY        =   1376
               _StockProps     =   78
               Caption         =   "&Eliminar"
               BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Font3D          =   1
               Picture         =   "bacmntcampos.frx":075C
            End
            Begin Threed.SSCommand cmdLimpiar 
               Height          =   780
               Left            =   4905
               TabIndex        =   12
               ToolTipText     =   "Limpiar"
               Top             =   3330
               Width           =   960
               _Version        =   65536
               _ExtentX        =   1693
               _ExtentY        =   1376
               _StockProps     =   78
               Caption         =   "&Limpiar"
               BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Font3D          =   1
               AutoSize        =   1
               Picture         =   "bacmntcampos.frx":0A76
            End
            Begin Threed.SSCommand cmdVolver 
               Height          =   690
               Left            =   120
               TabIndex        =   10
               ToolTipText     =   "Retorna a Ventana Tipo de Operación"
               Top             =   3360
               Width           =   690
               _Version        =   65536
               _ExtentX        =   1217
               _ExtentY        =   1217
               _StockProps     =   78
               AutoSize        =   1
               Picture         =   "bacmntcampos.frx":0D90
            End
            Begin MSFlexGridLib.MSFlexGrid grdCampos 
               Height          =   2535
               Left            =   120
               TabIndex        =   9
               Top             =   705
               Width           =   7695
               _ExtentX        =   13573
               _ExtentY        =   4471
               _Version        =   393216
               Cols            =   5
               FixedCols       =   0
               Enabled         =   -1  'True
            End
            Begin Threed.SSCommand cmdNew 
               Height          =   780
               Left            =   3915
               TabIndex        =   11
               ToolTipText     =   "Agregar Nuevo(s) Valor(es) Contable(s)"
               Top             =   3330
               Width           =   960
               _Version        =   65536
               _ExtentX        =   1693
               _ExtentY        =   1376
               _StockProps     =   78
               Caption         =   "V. Contab"
               BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Font3D          =   1
               AutoSize        =   1
               Picture         =   "bacmntcampos.frx":11E2
            End
            Begin VB.Label Label1 
               AutoSize        =   -1  'True
               Caption         =   "Valor Contable"
               BeginProperty Font 
                  Name            =   "Times New Roman"
                  Size            =   9.75
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   225
               Index           =   3
               Left            =   210
               TabIndex        =   19
               Top             =   225
               Width           =   1230
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
               Height          =   315
               Left            =   6555
               TabIndex        =   18
               Top             =   180
               Width           =   1245
            End
         End
      End
      Begin Threed.SSCommand cmdRefresh 
         Height          =   795
         Left            =   7365
         TabIndex        =   25
         ToolTipText     =   "Actualiza vista de datos"
         Top             =   345
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1402
         _StockProps     =   78
         Caption         =   "&Buscar"
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Font3D          =   1
         AutoSize        =   1
         Picture         =   "bacmntcampos.frx":14FC
      End
      Begin Threed.SSCommand SSCommand1 
         Height          =   795
         Left            =   7380
         TabIndex        =   26
         ToolTipText     =   "Salir"
         Top             =   1170
         Width           =   870
         _Version        =   65536
         _ExtentX        =   1535
         _ExtentY        =   1402
         _StockProps     =   78
         Caption         =   "&Salir"
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Font3D          =   1
         Picture         =   "bacmntcampos.frx":194E
      End
   End
End
Attribute VB_Name = "bacMntCampos"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit


Dim Sql$, i&
Dim datos()

Dim nError%, sError$
Function bacBuscarCombo(cControl As Object, nValor As Variant, Optional Leer) As Integer
Dim iLin    As Integer

    If VarType(nValor) = vbString Then
        nValor = Trim(nValor)
    End If
    
    If VarType(Leer) = vbString Then
        Leer = UCase(Left(Trim(Leer), 1))
    Else
        Leer = "L"
    End If
    Leer = IIf(InStr("RL", Leer) = 0, "L", Leer)

    bacBuscarCombo = -1

    For iLin = 0 To cControl.ListCount - 1
        If VarType(nValor) = vbString Then
            If Leer = "L" And Left(cControl.List(iLin), Len(nValor)) = nValor Then
                bacBuscarCombo = iLin
            ElseIf Leer = "R" And Right(cControl.List(iLin), Len(nValor)) = nValor Then
                bacBuscarCombo = iLin
            End If
        ElseIf cControl.ItemData(iLin) = nValor Then
            bacBuscarCombo = iLin
        End If
        If bacBuscarCombo = iLin And iLin > -1 Then
            cControl.ListIndex = iLin
            Exit For
        End If
    Next iLin

End Function

Private Sub BuscarValorContable(Buscar$)

    Me.MousePointer = 11
    
    Sql = "sp_Buscar_Campo '" & cmbSistema.Tag & "'"    '-- Id_Sistema
    If Buscar = "" Then
        Sql = Sql & ",'" & cmbOperacion.Tag & "'"           '-- Tipo_Movimiento
        Sql = Sql & ",'" & CmdGrabar.Tag & "'"              '-- Tipo_Operacion
    Else
        Sql = Sql & ",'',''"
    End If
    Sql = Sql & ", " & Val(txtCodigo.Text)                    '-- Codigo de Campo
    If miSQL.SQL_Execute(Sql) <> 0 Then
        MsgBox "Problemas al tratar de traer datos de Valor Contable solicitado", vbExclamation + vbOKOnly
        GoTo Fin
    End If
    
    If miSQL.SQL_Fetch(datos) = 0 Then
        txtGlosa.Text = datos(5)
        txtGlosa.Tag = datos(6)
        lblTipo.Caption = datos(7)
    Else
        cmdlimpiar_Click
        MsgBox "Valor Contable no se encontro ...", vbExclamation + vbOKOnly
    End If
        
Fin:
    Me.MousePointer = 0

End Sub
Sub PROC_CARGA_COMBO_SISTEMA()

    On Error GoTo ErrCarga

    Sql = "SP_BUSCAR_SISTEMAS"
    If miSQL.SQL_Execute(Sql) = 0 Then
        cmbSistema.Clear
        Do While miSQL.SQL_Fetch(datos()) = 0
            cmbSistema.AddItem Mid$(datos(2), 1, 15) & Space(50) & datos(1)
        Loop
        'cmbSistema.ListIndex = IIf(cmbSistema.ListCount >= 0, 0, -1)
    Else
        MsgBox "No se pudo obtener información del servidor", vbCritical, Me.Caption
        Exit Sub
    End If
    Exit Sub
    
ErrCarga:
    MsgBox "Se detectó problemas en carga de información: " & Err.Description & ". Comunique al Administrador.", vbCritical, Me.Caption
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
            .Tag = .ItemData(.ListIndex)
        Else
            .Tag = ""
        End If
    End With
End Sub


Private Sub cmbSistema_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        cmbOperacion.SetFocus
    End If
End Sub
Private Sub cmbSistema_LostFocus()
    With cmbSistema
        If .ListIndex >= 0 Then
            .Tag = Right(.List(.ListIndex), 3)
        Else
            .Tag = ""
        End If
    End With
End Sub

Private Sub cmdeliminar_Click()

    '---- Validando
    If Val(txtCodigo.Text) = 0 Or txtGlosa.Tag = "" Then
        MsgBox "Debe seleccionar el Valor Contable que desea Eliminar", vbExclamation + vbOKOnly
        Exit Sub
    End If

    '----
    Me.MousePointer = 11
    
    nError = 0
    sError = "Se Eliminó con éxito la relación ..."
    
    Sql = "sp_Borrar_Campo '" & cmbSistema.Tag & "'"    '-- Id_Sistema
    Sql = Sql & ",'" & cmbOperacion.Tag & "'"           '-- Tipo_Movimiento
    Sql = Sql & ",'" & CmdGrabar.Tag & "'"              '-- Tipo_Operacion
    Sql = Sql & ", " & txtCodigo                        '-- Codigo de Campo
    If miSQL.SQL_Execute(Sql) <> 0 Then
        nError = -1
        sError = "Problemas al Eliminar"
    End If
    
    If miSQL.SQL_Fetch(datos) = 0 Then
        nError = datos(1)
        sError = datos(2)
    End If
    
    If nError <> 0 Then
        sError = "Se presento el siguiente problema al intentar Eliminar" & vbCrLf & sError
        MsgBox sError, vbInformation + vbOKOnly
    Else
        cmdRefresh_Click
    End If
    
    Me.MousePointer = 0

End Sub
Private Sub cmdgrabar_Click()

    '---- Validando
    If Val(txtCodigo.Text) = 0 Or txtGlosa.Tag = "" Then
        MsgBox "Debe seleccionar el Valor Contable que desea Agregar", vbExclamation + vbOKOnly
        Exit Sub
    End If

    '----
    Me.MousePointer = 11
    
    nError = 0
    sError = "Se Grabo con éxito la relación ..."
    
    Sql = "sp_Grabar_Campo '" & cmbSistema.Tag & "'"    '-- Id_Sistema
    Sql = Sql & ",'" & cmbOperacion.Tag & "'"           '-- Tipo_Movimiento
    Sql = Sql & ",'" & CmdGrabar.Tag & "'"              '-- Tipo_Operacion
    Sql = Sql & ", " & txtCodigo                        '-- Codigo de Campo
    Sql = Sql & ",'" & txtGlosa & "'"                   '-- Descripcion de Campo
    Sql = Sql & ",'" & txtGlosa.Tag & "'"               '-- Nombre de Campo
    Sql = Sql & ",'" & Left(lblTipo, 1) & "'"               '-- Tipo de Valor
    Sql = Sql & ",''"                                   '-- Nombre de Tabla valores condicionales posibles
    Sql = Sql & ",''"                                   '-- Nombre de Columna retorna valor condicional posible
    Sql = Sql & ",''"                                   '-- Columnas a desplegar como valores condicionales posibles
    If miSQL.SQL_Execute(Sql) <> 0 Then
        nError = -1
        sError = "Problemas al Grabar"
    End If
    
    If miSQL.SQL_Fetch(datos) = 0 Then
        nError = datos(1)
        sError = datos(2)
    End If
    
    If nError <> 0 Then
        sError = "Se presento el siguiente problema al intentar grabar" & vbCrLf & sError
        MsgBox sError, vbInformation + vbOKOnly
    Else
        cmdRefresh_Click
    End If
    
    Me.MousePointer = 0

End Sub
Private Sub cmdlimpiar_Click()

    txtCodigo.Text = ""
    txtGlosa.Text = ""
    lblTipo.Caption = ""
   ' fraRelacion.Enabled = True
    txtCodigo.SetFocus

End Sub

Private Sub cmdNew_Click()

    txtCodigo_DblClick
    
    If giAceptar = True Then
        cmdgrabar_Click
    End If

End Sub

Private Sub cmdRefresh_Click()
    
    If cmbSistema.Tag = "" Then
        MsgBox "Sistema no ha sido definido", vbInformation + vbOKOnly
        Exit Sub
    End If

    '---- Armado del Tipo_Operacion para bac_cnt_campos
    CmdGrabar.Tag = IIf(chkEvento.Value = 1, chkEvento.Tag, "") & cmbProducto.Tag
    CmdGrabar.Tag = CmdGrabar.Tag & IIf(OptTipOpe(0).Value, "C", "V")
        
    '---- Valida existencia Tipo de Operación
    Sql = "SELECT glosa_operacion FROM bac_cnt_movimiento"
    Sql = Sql & " WHERE id_sistema = '" & cmbSistema.Tag & "'"
    Sql = Sql & "   AND tipo_movimiento = '" & cmbOperacion.Tag & "'"
    Sql = Sql & "   AND tipo_operacion = '" & CmdGrabar.Tag & "'"
    If miSQL.SQL_Execute(Sql) <> 0 Then
        MsgBox "Problemas con la Consulta ...", vbCritical + vbOKOnly
        Exit Sub
    End If
    '---- Agrega nuevo Tipo de Operación a bac_cnt_movimiento
    nError = -1
    sError = "Este Tipo de Operación no esta registrado"
    If miSQL.SQL_Fetch(datos) = 0 Then
        nError = 0
        txtDescripcion.Text = datos(1)
    End If
    If nError <> 0 Then
        txtDescripcion = Trim(txtDescripcion)
        If txtDescripcion = "" Then
            If chkEvento.Value = 1 Then
                txtDescripcion.Text = IIf(chkEvento.Tag = "V", "VCTO.", "DEV.")
            End If
            txtDescripcion.Text = txtDescripcion.Text & Trim(Left(cmbProducto, 50))
            txtDescripcion.Text = txtDescripcion.Text & IIf(OptTipOpe(0).Value, " COMPRA ", " VENTA ")
        End If
        sError = sError & vbCrLf & vbCrLf & txtDescripcion.Text
        sError = sError & vbCrLf & vbCrLf & "¿ Desea registrarla ?"
        If MsgBox(sError, vbQuestion + vbYesNo) <> vbYes Then
            Exit Sub
        End If
        Sql = "INSERT INTO bac_cnt_movimiento VALUES( '" & cmbSistema.Tag & "'"
        Sql = Sql & ",'" & cmbOperacion.Tag & "'"
        Sql = Sql & ",'" & Trim(Left(cmbOperacion.Text, 50)) & "'"
        Sql = Sql & ",'" & CmdGrabar.Tag & "'"
        Sql = Sql & ",'" & Trim(txtDescripcion) & "'"
        Sql = Sql & ", 1"       '-- Tipo de Voucher    PENDIENTE definición
        Sql = Sql & ",'N'"      '-- Tipo de Movimiento Caja ???
        Sql = Sql & ",'N'"      '-- Controla Instrumento
        Sql = Sql & ",'S')"     '-- Controla Moneda
        If miSQL.SQL_Execute(Sql) <> 0 Then
            MsgBox "Problemas al Grabar nuevo Tipo de Operación ...", vbCritical + vbOKOnly
            Exit Sub
        End If
    End If

    '---- Carga
    Sql = "sp_Buscar_Campo '" & cmbSistema.Tag & "'"    '-- Id_Sistema
    Sql = Sql & ",'" & cmbOperacion.Tag & "'"           '-- Tipo_Movimiento
    Sql = Sql & ",'" & CmdGrabar.Tag & "'"              '-- Tipo_Operacion
    Sql = Sql & ",0"                                    '-- Codigo de Campo
    If miSQL.SQL_Execute(Sql) <> 0 Then
        MsgBox "Problemas con la Consulta ...", vbCritical + vbOKOnly
        Exit Sub
    End If
    
    '-- Limpia Valores Contables
    Call Limpia
    
    i = 0
    Do While miSQL.SQL_Fetch(datos) = 0
        i = i + 1
        grdCampos.Row = grdCampos.Rows - 1
        grdCampos.TextMatrix(grdCampos.Row, 0) = datos(1)       '-- Sistema
        grdCampos.TextMatrix(grdCampos.Row, 1) = datos(2)       '-- Tipo de Movimiento
        grdCampos.TextMatrix(grdCampos.Row, 2) = datos(3)       '-- Tipo de Operacion
        grdCampos.TextMatrix(grdCampos.Row, 3) = Val(datos(4))  '-- Codigo Valor Contable
        grdCampos.TextMatrix(grdCampos.Row, 4) = datos(5)       '-- Glosa  Valor Contable
        grdCampos.TextMatrix(grdCampos.Row, 5) = IIf(datos(7) = "V", "Variable", "Fijo") '-- Tipo de Administracion
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
    If grdCampos.TextMatrix(1, 0) = cmbSistema.Tag Then
        GoTo Fin
    End If
    
    '---- Eliminando Tipo de Operación
    sError = "Este Tipo de Operación ya no registra Valores Contables" & vbCrLf
    sError = sError & "¿ Desea dejarla registrada ?"
    nError = MsgBox(sError, vbQuestion + vbYesNoCancel)
    If nError = vbCancel Then
        Exit Sub
    ElseIf nError <> vbNo Then
        MsgBox "Este Tipo de Operación seguirá registrado", vbInformation + vbOKOnly
        GoTo Fin
    End If

    '---- Elimina existencia Tipo de Operación
    Sql = "DELETE FROM bac_cnt_movimiento"
    Sql = Sql & " WHERE id_sistema = '" & cmbSistema.Tag & "'"
    Sql = Sql & "   AND tipo_movimiento = '" & cmbOperacion.Tag & "'"
    Sql = Sql & "   AND tipo_operacion = '" & CmdGrabar.Tag & "'"
    If miSQL.SQL_Execute(Sql) <> 0 Then
        MsgBox "Problemas al tratar de Eliminar Tipo de Operación ...", vbCritical + vbOKOnly
        Exit Sub
    End If
        
Fin:
    Call Limpia
    fraRelacion.Enabled = False
    Frame2.Enabled = True
    txtDescripcion.Text = ""
    cmbOperacion.SetFocus

End Sub

Private Sub Form_Activate()

    '-- Carga Sistema
    PROC_CARGA_COMBO_SISTEMA
    bacBuscarCombo cmbSistema, "BTR", "R"
    cmbSistema_LostFocus
    If cmbSistema.Tag = "" Then
        MsgBox "Sistema " & Chr(32) & Version & Chr(32) & " NO existe , debe generarlo", vbCritical + vbOKOnly, gsBac_Version
        Unload Me
        Exit Sub
    Else
        cmbSistema.Enabled = False
    End If

    '---- Tipo de Operación
    cmbOperacion.Clear
    cmbOperacion.AddItem Left("MOVIMIENTO          " & Space(50), 50) & "MOV"
    cmbOperacion.AddItem Left("DEVENGAMIENTO       " & Space(50), 50) & "DEV"
    cmbOperacion.ListIndex = 0
    cmbOperacion_LostFocus
    
    '---- Tipo de Producto
    'Call LeerCodigos(MDTC_TIPOSWAP, cmbProducto)
    cmbProducto_LostFocus
    
    '-- Limpia Valor Contable
    txtCodigo.Text = ""
    txtGlosa.Text = ""
    lblTipo.Caption = ""

    Call Limpia
    
    CmdGrabar.Tag = ""

    fraRelacion.Enabled = False
    
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
        cmdRefresh.SetFocus
    End If
End Sub


Private Sub SSCommand1_Click()
Unload Me
End Sub

Private Sub txtCodigo_DblClick()

    BacControlWindows 100
    
    BacAyuda.Tag = "CAMPOS"
    BacAyuda.parAyuda = "BAC_CNT_CAMPOS"
    BacAyuda.parFiltro = cmbSistema.Tag
    
    BacAyuda.Show 1
    
    If giAceptar = True Then
        txtCodigo = Val(gscodigo)
        txtCodigo_KeyPress 13
    End If

End Sub
Private Sub txtCodigo_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        If Val(txtCodigo.Text) <= 0 Then
            MsgBox "Debe indicar campo a Chequear o Crear" & vbCrLf & "Presione doble click si necesita Ayuda", vbInformation + vbOKOnly
            Exit Sub
        End If
        If Val(txtCodigo.Text) > 0 Then
            Call BuscarValorContable("BUSCAR")
        End If
        If Len(Trim(txtGlosa.Text)) = 0 Then
            txtGlosa.SetFocus
        Else
            CmdGrabar.SetFocus
        End If
    ElseIf InStr("0132456789", Chr(KeyAscii)) = 0 And KeyAscii <> 8 Then
        KeyAscii = 0
    End If
End Sub


Private Sub txtDescripcion_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        cmdRefresh.SetFocus
    Else
        KeyAscii = Asc(UCase(Chr(KeyAscii)))
    End If
End Sub

Private Sub txtGlosa_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        If Len(Trim(txtCodigo.Text)) = 0 Then
            MsgBox "Debe especificar la descripción del Campo", vbInformation + vbOKOnly
            Exit Sub
        End If
        CmdGrabar.SetFocus
    Else
        KeyAscii = Asc(UCase(Chr(KeyAscii)))
    End If
End Sub


