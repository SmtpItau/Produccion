VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MsComCtl.ocx"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form Frm_Mnt_Plazos 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantencion de Plazos"
   ClientHeight    =   6705
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   3675
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   6705
   ScaleWidth      =   3675
   Begin MSComctlLib.Toolbar TlbHerramientas 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   7
      Top             =   0
      Width           =   3675
      _ExtentX        =   6482
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImlBotones"
      HotImageList    =   "ImlBotones"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   5
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Eliminar"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Cerrar"
            ImageIndex      =   5
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImlBotones 
         Left            =   4410
         Top             =   -90
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
               Picture         =   "Frm_Mnt_Plazos.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Mnt_Plazos.frx":0EDA
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Mnt_Plazos.frx":1DB4
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Mnt_Plazos.frx":2C8E
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Mnt_Plazos.frx":3B68
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame FrParametros 
      Caption         =   "Parametros"
      ForeColor       =   &H00800000&
      Height          =   1620
      Left            =   0
      TabIndex        =   5
      Top             =   510
      Width           =   3660
      Begin VB.ComboBox CmbMoneda 
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   135
         Style           =   2  'Dropdown List
         TabIndex        =   1
         Top             =   1125
         Width           =   3420
      End
      Begin VB.Frame FrDuration 
         Caption         =   "Duration"
         ForeColor       =   &H00800000&
         Height          =   825
         Left            =   135
         TabIndex        =   6
         Top             =   1770
         Width           =   5220
      End
      Begin VB.ComboBox CmbSistema 
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   135
         Style           =   2  'Dropdown List
         TabIndex        =   0
         Top             =   465
         Width           =   3420
      End
      Begin VB.Label Label2 
         Caption         =   "Moneda"
         ForeColor       =   &H00800000&
         Height          =   240
         Left            =   135
         TabIndex        =   9
         Top             =   900
         Width           =   735
      End
      Begin VB.Label Label1 
         Caption         =   "Sistema"
         ForeColor       =   &H00800000&
         Height          =   270
         Left            =   135
         TabIndex        =   8
         Top             =   225
         Width           =   795
      End
   End
   Begin VB.Frame FrPlazos 
      Caption         =   "Plazos"
      ForeColor       =   &H00800000&
      Height          =   4545
      Left            =   0
      TabIndex        =   3
      Top             =   2145
      Width           =   3660
      Begin BACControles.TXTNumero TxnValor 
         Height          =   285
         Left            =   60
         TabIndex        =   4
         Top             =   4635
         Width           =   1665
         _ExtentX        =   2937
         _ExtentY        =   503
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
         Text            =   "0,0000"
         Text            =   "0,0000"
         Min             =   "1"
         Max             =   "99999"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin MSFlexGridLib.MSFlexGrid GrdPlazos 
         Height          =   4290
         Left            =   60
         TabIndex        =   2
         Top             =   225
         Width           =   3540
         _ExtentX        =   6244
         _ExtentY        =   7567
         _Version        =   393216
         GridLines       =   2
      End
   End
End
Attribute VB_Name = "Frm_Mnt_Plazos"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit


Const BtnLimpiar = 1
Const BtnBuscar = 2
Const BtnGrabar = 3
Const BtnEliminar = 4
Const BtnCerrar = 5

'Constante de Grilla GRDPLAZOS
Const ColCodigo = 0
Const ColDesde = 1
Const ColHasta = 2


' Constantes de retorno de procedimiento SP_CON_PLAZOS_LINEAS
Const nCodigo = 2
Const nDurationDesde = 3
Const nDurationHasta = 4

'----------------------------------------------------------------------

Dim nContador   As Long

Private Sub Form_Load()
    
    Me.Icon = BacControlFinanciero.Icon
    Call PROC_LLENA_COMBOS(CmbSistema, 7, False, "S", "N", "")
    Call PROC_LLENA_COMBOS(CmbMoneda, 8, False, "", "2", "3")

    Call Proc_Limpiar


End Sub


Private Sub Proc_Grabar()

    Screen.MousePointer = vbHourglass
    
    With GrdPlazos
    
        For nContador = 1 To .Rows - 1
        
            If .TextMatrix(nContador, ColHasta) = "" Then
                Screen.MousePointer = vbDefault
                MsgBox "Existen plazos sin valores... Debe completar antes de grabar", vbExclamation, TITSISTEMA
                .Row = nContador
                .Col = ColHasta
                Exit Sub
            End If
            
            If nContador > 1 Then
                If (CDbl(.TextMatrix(nContador, ColDesde)) <= CDbl(.TextMatrix(nContador - 1, ColHasta)) Or CDbl(.TextMatrix(nContador, ColDesde)) >= CDbl(.TextMatrix(nContador, ColHasta))) Then
                    Screen.MousePointer = vbDefault
                    MsgBox "Existen plazos incongruentes, favor de rectifique los plazos ante de grabar", vbExclamation, TITSISTEMA
                    .Row = nContador
                    .Col = ColHasta
                    .SetFocus
                    Exit Sub
                End If
            End If
            
        Next nContador
    End With
    
    If Not Bac_Sql_Execute("BEGIN TRANSACTION") Then
        Screen.MousePointer = vbDefault
        MsgBox "Ha ocurrido un error al intentar grabar los plazos - BEGIN TRANSACTION", vbCritical, TITSISTEMA
        Exit Sub
    End If
        
    Envia = Array()
    AddParam Envia, Trim(Right(CmbSistema.Text, 10))
    AddParam Envia, Trim(Right(CmbMoneda.Text, 10))
        
    If Not Bac_Sql_Execute("SP_DEL_PLAZOS_LINEAS", Envia) Then
        Call Bac_Sql_Execute("ROLLBACK TRANSACTION")
        Screen.MousePointer = vbDefault
        MsgBox "Ha ocurrido un error al intentar grabar los plazos (1)", vbCritical, TITSISTEMA
        Exit Sub
    End If
    
    With GrdPlazos
    
        For nContador = 1 To .Rows - 1
   
            Envia = Array()
            AddParam Envia, Trim(Right(CmbSistema.Text, 10))
            AddParam Envia, Trim(Right(CmbMoneda.Text, 10))
            AddParam Envia, .TextMatrix(nContador, ColCodigo)
            AddParam Envia, CDbl(.TextMatrix(nContador, ColDesde))
            AddParam Envia, CDbl(.TextMatrix(nContador, ColHasta))
        
            If Not Bac_Sql_Execute("SP_ACT_PLAZOS_LINEAS", Envia) Then
                Call Bac_Sql_Execute("ROLLBACK TRANSACTION")
                Screen.MousePointer = vbDefault
                MsgBox "Ha ocurrido un error al intentar grabar los plazos", vbCritical, TITSISTEMA
                Exit Sub
            End If
        Next nContador
    End With
        
    If Not Bac_Sql_Execute("COMMIT TRANSACTION") Then
        Screen.MousePointer = vbDefault
        MsgBox "Ha ocurrido un error al intentar grabar los plazos - COMMIT TRANSACTION", vbCritical, TITSISTEMA
        Exit Sub
    End If
    
        
    Screen.MousePointer = vbDefault
    MsgBox "Los plazos han sido grabado con exito", vbInformation, TITSISTEMA
    Proc_Limpiar

End Sub


Private Sub Proc_Buscar()

    Dim Datos()
    
    If CmbSistema.ListIndex = -1 Then
        MsgBox "Debe seleccionar un sistema", vbExclamation, TITSISTEMA
        CmbSistema.SetFocus
        Exit Sub
    End If
    
    If CmbMoneda.ListIndex = -1 Then
        MsgBox "Debe seleccionar una moneda", vbExclamation, TITSISTEMA
        CmbMoneda.SetFocus
        Exit Sub
    End If

    Screen.MousePointer = vbHourglass
    
    Envia = Array()
    AddParam Envia, Trim(Right(CmbSistema.Text, 10))
    AddParam Envia, Trim(Right(CmbMoneda.Text, 10))
        
    If Not Bac_Sql_Execute("SP_CON_PLAZOS_LINEAS", Envia) Then
        Screen.MousePointer = vbDefault
        MsgBox "Ha ocurrido un error al intentar recuperar los factores de ponderacion", vbCritical, TITSISTEMA
        Exit Sub
    Else
        Do While Bac_SQL_Fetch(Datos())
            With GrdPlazos
                .Rows = .Rows + 1
                .Row = .Rows - 1
                .RowHeight(.Row) = 270
                
                .TextMatrix(.Row, ColCodigo) = Datos(nCodigo)
                .TextMatrix(.Row, ColDesde) = CDbl(Datos(nDurationDesde))
                .TextMatrix(.Row, ColHasta) = CDbl(Datos(nDurationHasta))
            End With
        Loop
        
        FrParametros.Enabled = False
        FrPlazos.Enabled = True
        GrdPlazos.SetFocus
        
        TlbHerramientas.Buttons(BtnBuscar).Enabled = False
        TlbHerramientas.Buttons(BtnGrabar).Enabled = True
        If GrdPlazos.Rows > 1 Then TlbHerramientas.Buttons(BtnEliminar).Enabled = True
    End If
    
    Screen.MousePointer = vbDefault

End Sub


Private Sub GrdPlazos_DblClick()

    With GrdPlazos
        If .Rows > 1 And .Col <> ColDesde Then
        
            If .Col <> ColDesde Then
                Call PROC_POSICIONA_TEXTO(GrdPlazos, TxnValor)
                TxnValor.Text = .TextMatrix(.Row, .Col)
                TxnValor.Visible = True
                TxnValor.MarcaTexto = True
                TxnValor.SetFocus
            End If
        End If
    End With

End Sub


Private Sub GrdPlazos_KeyDown(KeyCode As Integer, Shift As Integer)

    Dim nFilaOld    As Long
    Dim nMayor      As Long
    
    If KeyCode = vbKeyInsert Then
        With GrdPlazos
            
            nMayor = 0
        
            For nContador = 1 To .Rows - 1
                    If Val(.TextMatrix(nContador, ColCodigo)) > nMayor Then
                        nMayor = Val(.TextMatrix(nContador, ColCodigo))
                    End If
            Next nContador
        
    
            If .Row > 1 And .Row < .Rows - 1 Then
                For nContador = 1 To .Rows - 1
                    If .TextMatrix(nContador, ColDesde) = "" Or .TextMatrix(nContador, ColHasta) = "" Then
                        Screen.MousePointer = vbDefault
                        MsgBox "Debe Corregir los plazos del duration antes de insertar otra linea", vbExclamation, TITSISTEMA
                        .SetFocus
                        KeyCode = 0
                        .Col = ColHasta
                        Exit Sub
                    End If
                Next nContador
                
                nFilaOld = .Row
                .Rows = .Rows + 1
                .RowHeight(.Row) = 270
                                       
                For nContador = .Rows - 1 To nFilaOld Step -1
                    If nContador <> nFilaOld Then
                        .TextMatrix(nContador, ColCodigo) = .TextMatrix(nContador - 1, ColCodigo)
                        .TextMatrix(nContador, ColDesde) = .TextMatrix(nContador - 1, ColDesde)
                        .TextMatrix(nContador, ColHasta) = .TextMatrix(nContador - 1, ColHasta)
                    Else
                        .TextMatrix(nContador, ColCodigo) = nMayor + 1
                        .TextMatrix(nContador, ColDesde) = ""
                        .TextMatrix(nContador, ColHasta) = ""
                        
                        .TextMatrix(nContador, ColDesde) = CDbl(.TextMatrix(nContador - 1, ColHasta) + 0.0001)
                    End If
                Next nContador
                .Col = ColHasta
                
            ElseIf .Rows = 2 Or .Row = .Rows - 1 Then
                If .TextMatrix(.Row, ColHasta) = "" Then
                    Screen.MousePointer = vbDefault
                    MsgBox "Debe Corregir los plazos antes de insertar otra linea", vbExclamation, TITSISTEMA
                    .SetFocus
                    KeyCode = 0
                    .Col = ColHasta
                    Exit Sub
                End If
                .Rows = .Rows + 1
                .Row = .Rows - 1
                .RowHeight(.Row) = 270
                
                If .Rows > 2 Then
                    .TextMatrix(.Rows - 1, ColDesde) = CDbl((.TextMatrix(.Rows - 1 - 1, ColHasta) + 0.0001))
                    .TextMatrix(.Rows - 1, ColCodigo) = .TextMatrix(.Row - 1, ColCodigo) + 1
                
                    If CDbl(.TextMatrix(.Row - 1, ColHasta) + 0.0001) > 99999.9 Then
                        .RemoveItem (.Row)
                        Screen.MousePointer = vbDefault
                        MsgBox "El plazo maximo permitido es de 99.999,9- Debe corregir el ultimo plazo para poder agregar una nueva fila", vbExclamation, TITSISTEMA
                        .SetFocus
                        Exit Sub
                    End If
                ElseIf .Rows = 2 Then
                    .TextMatrix(.Row, ColDesde) = 0
                    .TextMatrix(.Row, ColCodigo) = 1
                End If
                .Col = ColHasta
            End If
        End With
    End If
    
    If KeyCode = vbKeyDelete Then
        With GrdPlazos
            If .Row > 1 Then
                If .Row < .Rows - 1 Then
                    .TextMatrix(.Row + 1, ColDesde) = CDbl((.TextMatrix(.Row - 1, ColHasta) + 0.0001))
                End If
                .RemoveItem (.Row)
            End If
        End With
    End If
    
    If KeyCode = vbKeyReturn Then
        With GrdPlazos
    
            If GrdPlazos.Row > 0 And GrdPlazos.Col <> ColDesde Then
                Call PROC_POSICIONA_TEXTO(GrdPlazos, TxnValor)
                TxnValor.Visible = True
                TxnValor.Text = .Text
                TxnValor.MarcaTexto = True
                TxnValor.SetFocus
            End If
        End With
    End If

End Sub


Private Sub GrdPlazos_KeyPress(KeyAscii As Integer)

    If KeyAscii >= vbKey0 And KeyAscii <= vbKey9 And GrdPlazos.Col <> ColDesde Then
        TxnValor.Text = 0
        Call PROC_POSICIONA_TEXTO(GrdPlazos, TxnValor)
        TxnValor.Visible = True
        TxnValor.Text = Chr(KeyAscii)
        TxnValor.MarcaTexto = False
        TxnValor.SelStart = 1
        TxnValor.SetFocus
    End If

End Sub


Private Sub TlbHerramientas_ButtonClick(ByVal Button As MSComctlLib.Button)

    Select Case Button.Index
    
        Case BtnLimpiar
            Call Proc_Limpiar
        
        Case BtnBuscar
            Call Proc_Buscar
            
        Case BtnGrabar
            Call Proc_Grabar
            
        Case BtnEliminar
            Call Proc_Eliminar
            
        Case BtnCerrar
            Unload Me
    
    End Select
    
End Sub


Private Sub Proc_Eliminar()

    Screen.MousePointer = vbDefault
    
    If MsgBox("Esta seguro de eliminar los plazos de esste sistema", vbQuestion + vbYesNo, TITSISTEMA) = vbNo Then
        Exit Sub
    End If

    Screen.MousePointer = vbHourglass
    
    If Not Bac_Sql_Execute("BEGIN TRANSACTION") Then
        Screen.MousePointer = vbDefault
        MsgBox "Ha ocurrido un error al intentar eliminar plazos (1)", vbCritical, TITSISTEMA
        Exit Sub
    End If
    
    Envia = Array()
    AddParam Envia, Trim(Right(CmbSistema.Text, 10))
    AddParam Envia, Trim(Right(CmbMoneda.Text, 10))
        
    If Not Bac_Sql_Execute("SP_DEL_PLAZOS_LINEAS", Envia) Then
        Call Bac_Sql_Execute("ROLLBACK TRANSACTION")
        Screen.MousePointer = vbDefault
        MsgBox "Ha ocurrido un error al intentar eliminar los plazos (2)", vbCritical, TITSISTEMA
        Exit Sub
    End If
    
    If Not Bac_Sql_Execute("COMMIT TRANSACTION") Then
        Screen.MousePointer = vbDefault
        MsgBox "Ha ocurrido un error al intentar eliminar los plazos (1)", vbCritical, TITSISTEMA
        Exit Sub
    End If
    
    Screen.MousePointer = vbDefault
    
    MsgBox "Los plazos del sistema " + Trim(Left(CmbSistema.Text, 80)) + " - moneda " + Trim(Left(CmbMoneda.Text, 5)) + " han sido eliminada con exito", vbInformation, TITSISTEMA
    Proc_Limpiar

End Sub


Private Sub Proc_Limpiar()

    With GrdPlazos
        .Rows = 1
        .Cols = 3
    
        .TextMatrix(0, ColCodigo) = "CODIGO"
        .TextMatrix(0, ColDesde) = "DESDE"
        .TextMatrix(0, ColHasta) = "HASTA"
        
        .FixedCols = 2
        
        .BackColorFixed = ColorVerde
        .ForeColorFixed = ColorGris
        
        
        .RowHeight(0) = 350
        .ColAlignment(0) = 4
        
        .ColWidth(ColCodigo) = 1100
        .ColWidth(ColDesde) = 1100
        .ColWidth(ColHasta) = 1100
    End With

    CmbSistema.ListIndex = -1
    CmbMoneda.ListIndex = -1
    
    TxnValor.Visible = False
    FrParametros.Enabled = True
    FrPlazos.Enabled = False
    
    TlbHerramientas.Buttons(BtnBuscar).Enabled = True
    TlbHerramientas.Buttons(BtnGrabar).Enabled = False
    TlbHerramientas.Buttons(BtnEliminar).Enabled = False

End Sub

Private Sub TxnValor_KeyDown(KeyCode As Integer, Shift As Integer)

    If KeyCode = vbKeyEscape Then
        TxnValor.Visible = False
        GrdPlazos.SetFocus
    End If
    
    If KeyCode = vbKeyReturn Then
        With GrdPlazos
    
            If .Col = ColHasta Then
                If CDbl(TxnValor.Text) <= CDbl(.TextMatrix(.Row, ColDesde)) Then
                    MsgBox "Cantidad de dias HASTA no puede ser menor o igual que DESDE", vbExclamation, TITSISTEMA
                    TxnValor.SetFocus
                    KeyCode = 0
                    TxnValor.SelStart = 0
                    TxnValor.SelLength = Len(TxnValor.Text)
                    Exit Sub
                End If
                
                If .Row < .Rows - 1 Then
                    .TextMatrix(.Row + 1, ColDesde) = TxnValor.Text + 0.0001
                    
                End If
                
            End If
            .Text = TxnValor.Text
            TxnValor.Visible = False
            .SetFocus
        End With
    End If

End Sub


Private Sub TxnValor_LostFocus()

    TxnValor.Visible = False
    GrdPlazos.SetFocus

End Sub

