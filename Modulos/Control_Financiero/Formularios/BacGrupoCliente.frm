VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacGrupoCliente 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantención Endeudamiento"
   ClientHeight    =   6330
   ClientLeft      =   1710
   ClientTop       =   1995
   ClientWidth     =   7545
   Icon            =   "BacGrupoCliente.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   6330
   ScaleWidth      =   7545
   Visible         =   0   'False
   Begin Threed.SSPanel SSPanel2 
      Height          =   4950
      Left            =   0
      TabIndex        =   8
      Top             =   1335
      Width           =   7545
      _Version        =   65536
      _ExtentX        =   13309
      _ExtentY        =   8731
      _StockProps     =   15
      Caption         =   "SSPanel2"
      BackColor       =   13160660
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin MSFlexGridLib.MSFlexGrid Grilla 
         Height          =   4455
         Left            =   0
         TabIndex        =   12
         Top             =   420
         Visible         =   0   'False
         Width           =   7455
         _ExtentX        =   13150
         _ExtentY        =   7858
         _Version        =   393216
         Rows            =   3
         FixedRows       =   0
         FixedCols       =   0
         BackColor       =   -2147483633
         BackColorFixed  =   -2147483646
         ForeColorFixed  =   -2147483639
         BackColorBkg    =   -2147483633
         Enabled         =   0   'False
         FocusRect       =   2
         HighLight       =   2
         GridLines       =   2
         GridLinesFixed  =   0
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin VB.Label Label3 
         Appearance      =   0  'Flat
         BackColor       =   &H80000000&
         BackStyle       =   0  'Transparent
         Caption         =   "   Nombre Cliente Relacionado"
         BeginProperty Font 
            Name            =   "Arial"
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
         TabIndex        =   13
         Top             =   180
         Width           =   2865
      End
   End
   Begin Threed.SSPanel SSPanel1 
      Height          =   885
      Left            =   -30
      TabIndex        =   1
      Top             =   525
      Width           =   7575
      _Version        =   65536
      _ExtentX        =   13361
      _ExtentY        =   1561
      _StockProps     =   15
      BackColor       =   13160660
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Font3D          =   2
      Alignment       =   1
      Begin Threed.SSCheck chkAfectaLinea 
         Height          =   255
         Left            =   6960
         TabIndex        =   9
         Top             =   120
         Width           =   255
         _Version        =   65536
         _ExtentX        =   450
         _ExtentY        =   450
         _StockProps     =   78
         Caption         =   "SSCheck1"
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin BACControles.TXTNumero TxtCodCli2 
         Height          =   315
         Left            =   2745
         TabIndex        =   7
         Top             =   120
         Width           =   375
         _ExtentX        =   661
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
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin BACControles.TXTNumero TxtRut2 
         Height          =   315
         Left            =   1125
         TabIndex        =   6
         Top             =   120
         Width           =   1260
         _ExtentX        =   2223
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
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin VB.Label Label2 
         BackColor       =   &H80000000&
         Caption         =   "Desmarcado: Imputa Linea solo al Padre."
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   225
         Left            =   3360
         TabIndex        =   11
         Top             =   225
         Width           =   3615
      End
      Begin VB.Label A 
         BackColor       =   &H80000000&
         Caption         =   "Marcado: Imputa Linea a Padre e Hijo."
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   3360
         TabIndex        =   10
         Top             =   15
         Width           =   3375
      End
      Begin VB.Label Label1 
         BorderStyle     =   1  'Fixed Single
         Caption         =   "   Nombre"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   315
         Left            =   60
         TabIndex        =   2
         Top             =   450
         Width           =   1065
      End
      Begin VB.Label Label13 
         BorderStyle     =   1  'Fixed Single
         Caption         =   "   Rut"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   315
         Left            =   60
         TabIndex        =   3
         Top             =   120
         Width           =   1065
      End
      Begin VB.Label LabNombre2 
         BackColor       =   &H00E0E0E0&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   315
         Left            =   1125
         TabIndex        =   5
         Top             =   465
         Width           =   6300
      End
      Begin VB.Label labDigVeri2 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00E0E0E0&
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
         Left            =   2400
         TabIndex        =   4
         Top             =   120
         Width           =   315
      End
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   4800
      Top             =   0
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
            Picture         =   "BacGrupoCliente.frx":000C
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacGrupoCliente.frx":0460
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacGrupoCliente.frx":08B4
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacGrupoCliente.frx":0D08
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacGrupoCliente.frx":0E64
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
      Width           =   7545
      _ExtentX        =   13309
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      ToolTips        =   0   'False
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList2"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   6
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.Visible         =   0   'False
            Object.ToolTipText     =   "Informe"
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Eliminar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   4
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList2 
         Left            =   3120
         Top             =   45
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
               Picture         =   "BacGrupoCliente.frx":0F78
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacGrupoCliente.frx":1E52
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacGrupoCliente.frx":2D2C
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacGrupoCliente.frx":3C06
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacGrupoCliente.frx":3F20
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
End
Attribute VB_Name = "BacGrupoCliente"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Const iColNombre = 0
Const iColCodigo = 2
Const iColRut = 1
Const iColEstado = 3
Dim TipoEliminacion As Integer


     
Private Sub Eliminar()
    On Error GoTo ErrorEliminacion
    Dim datos()
    
    If TxtRut2.Text <> 0 Then
    If Grilla.Rows > 0 Then
      If CDbl(Grilla.TextMatrix(Grilla.RowSel, iColRut)) <> 0 Then  'COC
        If MsgBox("¿ Esta seguro que desea Eliminar.? Se Grabara inmediatamente.", vbQuestion + vbYesNo + vbDefaultButton2, TITSISTEMA) = vbNo Then
            Exit Sub
        End If
        
        If Grilla.TextMatrix(Grilla.RowSel, iColEstado) = "NUEVO" Then
            If Grilla.RowSel = 0 Then
               Me.Grilla.Rows = 0
            Else
            Grilla.RemoveItem Grilla.Row
            End If
        Else
        Envia = Array()
        AddParam Envia, CDbl(TxtRut2.Text)
        AddParam Envia, CDbl(TxtCodCli2.Text)
        AddParam Envia, CDbl(Grilla.TextMatrix(Grilla.RowSel, iColRut))
        AddParam Envia, CDbl(Grilla.TextMatrix(Grilla.RowSel, iColCodigo))
        If Not Bac_Sql_Execute("SP_ELIMINA_RELACION_CLIENTE", Envia) Then
            MsgBox "Se ha producido un error al Ejecutar : SP_ELIMINA_RELACION_CLIENTE", vbCritical, TITSISTEMA
            Exit Sub
        End If
        Do While Bac_SQL_Fetch(datos())
            If datos(1) <> "OK" Then
                        MsgBox "No puede eliminar del grupo, debido a que existen operaciones vigentes relacionadas" & vbCrLf & "con alguna entidad perteneciente a esta agrupación", vbExclamation, TITSISTEMA
                Exit Sub
            End If
        Loop
        If TipoEliminacion = 0 Then
        Call LimpiarFormulario
         Else
                    If Grilla.Rows = 1 Then
                        Me.Grilla.Rows = 0
                    Else
            Grilla.RemoveItem Grilla.Row
        End If
    End If
        End If
      End If
    End If
    'COC
    'Else
    '    MsgBox "Debe seleccionar un Cliente", vbExclamation, TITSISTEMA
    '    Exit Sub
    End If
Exit Sub
ErrorEliminacion:
    MsgBox Err.Description, vbExclamation, TITSISTEMA
End Sub




Private Sub GrabarInformacion()
    On Error GoTo ErrorGrabacion
    Dim iContador   As Long
    Dim datos()
    Dim oMensaje    As String
    Dim swGraba     As Integer
    Dim oForzado    As Integer
    
    Dim oCodMensaje As Integer
    
    Let oCodMensaje = 0
    Let oForzado = -1

GRABARFORZADO:

    swGraba = 0

    If TxtRut2.Text <> 0 Then   'COC

    If Grilla.Rows >= 1 Then 'COC

    Call Bac_Sql_Execute("BEGIN TRANSACTION")
    
    For iContador = 0 To Grilla.Rows - 1
             
        Envia = Array()
        AddParam Envia, CDbl(TxtRut2.Text)
        AddParam Envia, CDbl(TxtCodCli2.Text)
        AddParam Envia, CDbl(Val(Grilla.TextMatrix(iContador, 1)))
        AddParam Envia, CDbl(Val(Grilla.TextMatrix(iContador, 2)))
        AddParam Envia, CDbl("0")
        AddParam Envia, IIf(chkAfectaLinea.Value = False, "0", "1")
             AddParam Envia, oForzado
        If CDbl(Val(Grilla.TextMatrix(iContador, 1))) <> 0 Then 'COC
        If Not Bac_Sql_Execute("SP_GRABA_RELACION_CLIENTE", Envia) Then
            GoTo ErrorGrabacion
        End If
        If Bac_SQL_Fetch(datos()) Then
            If datos(1) = -2 Then
               oMensaje = "No es posible agregar al cliente : " & Grilla.TextMatrix(iContador, 0) & vbCrLf & "al grupo. Debido a que posee línea de crédito asignada"
               GoTo ErrorGrabacion
            End If
            If datos(1) < 0 Then
                        Let oCodMensaje = DATOS(1)
               oMensaje = datos(2)
               GoTo ErrorGrabacion
            End If
                swGraba = 1
        End If
        End If
        
    Next iContador
    
    Call Bac_Sql_Execute("COMMIT TRANSACTION")
    
    If swGraba = 1 Then
    MsgBox "La grabación ha finalizado exitosamente.", vbInformation, TITSISTEMA
    Call LimpiarFormulario
    End If
    
End If
End If

Exit Sub
ErrorGrabacion:
    Call Bac_Sql_Execute("ROLLBACK TRANSACTION")
    
    If oMensaje = "" Then
        MsgBox Err.Description, vbExclamation, TITSISTEMA
    Else
      If oCodMensaje = -9 Then
         If MsgBox(oMensaje & vbCrLf & vbCrLf & "¿ Desea grabar igual la relación ?", vbQuestion + vbYesNo, TITSISTEMA) = vbYes Then
            Let oForzado = 1
            GoTo GRABARFORZADO
         End If
      Else
        MsgBox oMensaje, vbExclamation, TITSISTEMA
    End If
    End If
End Sub

Sub Grabar()
    Call GrabarInformacion
Exit Sub

    On Error GoTo ErrorGrabacion
    Dim I%
    Dim datos()
       
    Envia = Array("B")
    If Not Bac_Sql_Execute("SP_BCR_TRANSACTION", Envia) Then
       MsgBox "Error al tratar de iniciar una nueva Transacción", vbCritical, TITSISTEMA
       Exit Sub
    End If
    For I% = 1 To Grilla.Rows - 1
        Envia = Array()
        AddParam Envia, CDbl(TxtRut2.Text)
        AddParam Envia, CDbl(TxtCodCli2.Text)
        AddParam Envia, CDbl(Grilla.TextMatrix(I, iColRut))
        AddParam Envia, CDbl(Grilla.TextMatrix(I, iColCodigo))
         AddParam Envia, CDbl("0")
        AddParam Envia, IIf(chkAfectaLinea.Value = False, "0", "1")
        If Not Bac_Sql_Execute("SP_GRABA_RELACION_CLIENTE", Envia) Then
            Envia = Array("R")
            If Not Bac_Sql_Execute("SP_BCR_TRANSACTION", Envia) Then
                MsgBox "Error al tratar de Canelar la Transacción.", vbCritical, TITSISTEMA
                Grilla.SetFocus
                Exit Sub
            End If
            MsgBox "No se ha podido finalizar esta operación", vbExclamation, TITSISTEMA
            Grilla.SetFocus
            Exit Sub
        End If
    Next I%
   
    Envia = Array("C")
    If Not Bac_Sql_Execute("SP_BCR_TRANSACTION", Envia) Then
        MsgBox "Problemas al Tratar de Confirmar la Transacción", vbCritical, TITSISTEMA
        Exit Sub
    End If
    MsgBox "La grabación ha finalizado correctamente.", vbInformation, TITSISTEMA
    Call LimpiarFormulario
Exit Sub
ErrorGrabacion:
    MsgBox "Se ha producido un error, al grabar la información" & vbCrLf & Err.Description, vbExclamation, TITSISTEMA
    Grilla.SetFocus
End Sub

Sub Busca()
    On Error GoTo ErrorBuscar
    Dim I%
    Dim datos()
    Dim TieneRela As String
    
    TieneRela = "No"
    
If TxtRut2.Text <> 0 Then   'COC
    Envia = Array()
    AddParam Envia, CDbl(TxtRut2.Text)
    AddParam Envia, CDbl(TxtCodCli2.Text)
    If Not Bac_Sql_Execute("SP_CLIENTERELA", Envia) Then
       MsgBox "Error en SqlServer", vbCritical, TITSISTEMA
       Exit Sub
    End If
    Grilla.Rows = 0 'Grilla.FixedRows
    Do While Bac_SQL_Fetch(datos())
         Let LabNombre2.Caption = DATOS(8)
      
        Grilla.Rows = Grilla.Rows + 1
        Grilla.Row = Grilla.Rows - 1
        Grilla.TextMatrix(Grilla.Row, iColNombre) = datos(6)    'Nombre
        Grilla.TextMatrix(Grilla.Row, iColCodigo) = datos(4)    'Codigo
        Grilla.TextMatrix(Grilla.Row, iColRut) = datos(3)       'Rut
        Grilla.TextMatrix(Grilla.Row, iColEstado) = ""          'Estado 'COC
        If DATOS(7) = "1" Then
            Me.chkAfectaLinea.Value = 1
        Else
            Me.chkAfectaLinea.Value = 0
        End If
        TieneRela = "Si"
    Loop
    Grilla.Col = 0
   
     ' LabNombre2.Caption = FuncAyudaNombre(CDbl(TxtRut2.Text), CDbl(TxtCodCli2.Text))
   
      If TieneRela = "No" Then
         Me.chkAfectaLinea.Value = 0
      End If
    
End If

Exit Sub
ErrorBuscar:
    MsgBox Err.Description, vbExclamation, TITSISTEMA
End Sub

Sub InsertarRow()
    Grilla.Rows = Grilla.Rows + 1
    Grilla.Row = Grilla.Rows - 1
    Grilla.Col = 0
    Grilla.TextMatrix(Grilla.Row, iColNombre) = ""
    Grilla.TextMatrix(Grilla.Row, iColCodigo) = 0
    Grilla.TextMatrix(Grilla.Row, iColRut) = 0
    Grilla.TextMatrix(Grilla.Row, iColEstado) = ""  'COC
    SendKeys "{HOME}"
End Sub

Sub CargarGrid()
    Grilla.Rows = 0
    Grilla.Cols = 4 'COC
'    Grilla.FixedRows = 0
'    Grilla.FixedCols = 0
    
'    Grilla.TextMatrix(0, 0) = " "
'    Grilla.TextMatrix(0, 1) = " "
'    Grilla.TextMatrix(0, 2) = " "
'    Grilla.TextMatrix(0, 3) = " "   'COC
    
    Grilla.ColWidth(0) = 5460
    Grilla.ColWidth(1) = 0
    Grilla.ColWidth(2) = 0
    Grilla.ColWidth(3) = 0
    
    Grilla.Font.Name = "Arial"
    Grilla.Font.Size = 8
    Grilla.Font.Bold = False
    Grilla.CellFontBold = False
    Grilla.WordWrap = False
    Grilla.RowHeightMin = 315
    
'    Grilla.GridLinesFixed = flexGridNone
    Grilla.GridLines = flexGridInset
    Grilla.FocusRect = flexFocusNone
    
End Sub


Private Function FuncCheqCliente(ByVal oRut As Long, ByVal oCod As Long) As Boolean
   Dim oContador  As Long
   
   Let FuncCheqCliente = False
   
   For oContador = 0 To Grilla.Rows - 1
      If Len(Grilla.TextMatrix(oContador, iColRut)) > 0 And Len(Grilla.TextMatrix(oContador, iColCodigo)) > 0 Then
         If Grilla.TextMatrix(oContador, iColRut) = oRut And Grilla.TextMatrix(oContador, iColCodigo) = oCod Then
            Exit Function
         End If
      End If
   Next oContador
   
   If CDbl(TxtRut2.Text) = oRut And CDbl(TxtCodCli2.Text) = oCod Then
            Exit Function
   End If
   
   Let FuncCheqCliente = True
   
End Function

Private Sub Grilla_DblClick()
    Dim nRow As Integer
    Dim I    As Integer

If Grilla.Row <> -1 Then
      
    If Grilla.Col = 0 Then
       'BacAyuda.Tag = "Cliente"-->Original
       'BacAyuda.Show 1
       BacAyudaCliente.Tag = "Cliente"
       BacAyudaCliente.Show 1

        nRow = grilla.Row
        If giAceptar = True Then
            If FuncCheqCliente(CLng(RetornoAyuda), CLng(RetornoAyuda2)) = False Then
               Call MsgBox("Cliente seleccionado ya forma parte de la relación", vbExclamation, App.Title)
                    Exit Sub
                End If
 
            Grilla.TextMatrix(Grilla.Row, iColNombre) = RetornoAyuda3      ' nombre
            Grilla.TextMatrix(Grilla.Row, iColCodigo) = RetornoAyuda2      ' codigo
            Grilla.TextMatrix(Grilla.Row, iColRut) = RetornoAyuda          ' rut
            Grilla.TextMatrix(Grilla.Row, iColEstado) = "NUEVO"               ' estado
            Toolbar1.Buttons(1).Enabled = True
            
            Grilla.TextMatrix(Grilla.Row, iColNombre) = FuncAyudaNombre(CLng(RetornoAyuda), CLng(RetornoAyuda2))
        End If
      
    End If
End If

End Sub

Private Function FuncAyudaNombre(ByVal oRut As Long, ByVal oCod As Long) As String
   Dim SqlDatos()
   
   Let FuncAyudaNombre = ""
   
   Envia = Array()
   AddParam Envia, oRut
   AddParam Envia, oCod
   AddParam Envia, CDbl(1)
   If Not Bac_Sql_Execute("Sp_LineaCreditoGeneral_AyudaCliente_NoBancos", Envia) Then
      Exit Function
   End If
   If Bac_SQL_Fetch(SqlDatos()) Then
      Let FuncAyudaNombre = SqlDatos(3)
   End If
   
End Function


Private Sub Grilla_KeyDown(KEYCODE As Integer, Shift As Integer)
   TipoEliminacion = 0
    If KEYCODE = 45 Then      'Insertar un Registro
        Call InsertarRow
        Grilla.SetFocus
    End If
    If KEYCODE = 46 Then       'Eliminar un Registro
        TipoEliminacion = 1  'COC
        Call Eliminar
        'Call Busca
    End If
    If KEYCODE = vbKeyF3 Then
        Call Grilla_DblClick
    End If
End Sub



Private Sub Grilla_Scroll()
    Grilla.SetFocus
End Sub

Private Sub Form_Load()
    Me.Top = 0: Me.Left = 0
    Me.Icon = BacControlFinanciero.Icon
    
    Toolbar1.Buttons(1).Enabled = True
    
    Call CargarGrid
   
    Grilla.Enabled = True
    Grilla.Visible = True
    Me.chkAfectaLinea.Value = 1
End Sub





Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
    Select Case Button.Index
        Case 1
            Call LimpiarFormulario  'COC
        Case 2
            Call Busca
        Case 3
            Call Grabar
        Case 5
            TipoEliminacion = 1 'COC
            Call Eliminar
        Case 6
            Unload Me
   End Select
End Sub

Private Sub TxtCodCli2_KeyDown(KEYCODE As Integer, Shift As Integer)
    Dim datos()

    Select Case KEYCODE
        Case vbKeyReturn
            Envia = Array()
            AddParam Envia, CDbl(TxtRut2.Text)
            AddParam Envia, CDbl(TxtCodCli2.Text)
            If Bac_Sql_Execute("SP_AYUDACLIENTE", Envia) Then
                If Bac_SQL_Fetch(datos()) Then
                    Me.LabNombre2.Caption = datos(3)
                Else
                    MsgBox "Cliente especificado no existe." & vbCrLf & "Presione F1 sobre el cuadro de Rut para obtener Ayuda de Clientes," & vbCrLf & "o bien realice doble clik sobre este.", vbExclamation, TITSISTEMA
                    Me.LabNombre2.Caption = ""
                    Me.TxtCodCli2.SetFocus
                    Exit Sub
                End If
            End If
            
            Call Busca
    End Select
End Sub

Private Sub TxtRut2_DblClick()
'    BacAyuda.Tag = "Cliente"
'    BacAyuda.Show 1
    BacAyudaCliente.Tag = "Cliente"
    BacAyudaCliente.Show 1
    If giAceptar = True Then
        TxtRut2.Text = RetornoAyuda
        TxtCodCli2.Text = RetornoAyuda2
        LabNombre2.Caption = RetornoAyuda3
        Call Busca
    End If
End Sub

Private Sub TxtRut2_KeyDown(KEYCODE As Integer, Shift As Integer)
    Select Case KEYCODE
        Case vbKeyF1
            BacAyuda.Tag = "Cliente"
            BacAyuda.Show 1
            
            If giAceptar = True Then
                TxtRut2.Text = RetornoAyuda
                TxtCodCli2.Text = RetornoAyuda2
                LabNombre2.Caption = RetornoAyuda3
                Call Busca
            End If
        Case vbKeyReturn
            If Me.TxtCodCli2.Enabled = True Then
                TxtCodCli2.SetFocus
            End If
    End Select
End Sub

Private Sub LimpiarFormulario()
'    Me.Grilla.Rows = 1
'    Me.Grilla.Rows = 2
    Me.Grilla.Rows = 0
    
    Me.TxtRut2.Text = 0
    Me.TxtCodCli2.Text = 0
    Me.LabNombre2.Caption = ""
    Me.chkAfectaLinea.Value = False
End Sub
