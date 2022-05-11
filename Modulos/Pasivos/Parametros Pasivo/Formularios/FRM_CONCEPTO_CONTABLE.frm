VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "Mscomctl.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "threed32.ocx"
Begin VB.Form FRM_CONCEPTO_CONTABLE 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantención de Conceptos Contables"
   ClientHeight    =   5100
   ClientLeft      =   3375
   ClientTop       =   3255
   ClientWidth     =   7515
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form5"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   5100
   ScaleWidth      =   7515
   Begin VB.Frame Frame2 
      Height          =   3210
      Left            =   0
      TabIndex        =   22
      Top             =   1860
      Width           =   7515
      Begin Threed.SSFrame SSFrame2 
         Height          =   2655
         Left            =   5025
         TabIndex        =   26
         Top             =   150
         Width           =   2415
         _Version        =   65536
         _ExtentX        =   4260
         _ExtentY        =   4683
         _StockProps     =   14
         Caption         =   "Otras Condiciones"
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Begin VB.CheckBox ChkInventario 
            Caption         =   "Inventario"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   285
            Left            =   150
            TabIndex        =   17
            Top             =   600
            Width           =   1770
         End
         Begin VB.CheckBox ChkResultado 
            Caption         =   "Resultado"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   285
            Left            =   150
            TabIndex        =   19
            Top             =   1290
            Width           =   1755
         End
         Begin VB.CheckBox ChkGarantia 
            Caption         =   "Garantía"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   285
            Left            =   150
            TabIndex        =   16
            Top             =   285
            Width           =   1770
         End
         Begin VB.CheckBox ChkPropiedad 
            Caption         =   "Propiedad"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   285
            Left            =   150
            TabIndex        =   18
            Top             =   930
            Width           =   1875
         End
      End
      Begin Threed.SSFrame SSFrame1 
         Height          =   2640
         Left            =   105
         TabIndex        =   25
         Top             =   165
         Width           =   4875
         _Version        =   65536
         _ExtentX        =   8599
         _ExtentY        =   4657
         _StockProps     =   14
         Caption         =   "Afectan Directamente la Ristra"
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Begin VB.CheckBox ChkTipoMoneda 
            Caption         =   "[T] Tipo Moneda"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   285
            Left            =   2415
            TabIndex        =   9
            Top             =   1815
            Width           =   2085
         End
         Begin VB.CheckBox ChkProducto 
            Caption         =   "[PROD] Producto"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   285
            Left            =   105
            TabIndex        =   4
            Top             =   270
            Width           =   1875
         End
         Begin VB.CheckBox ChkTipoPlazo 
            Caption         =   "[P] Tipo Plazo"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   285
            Left            =   105
            TabIndex        =   5
            Top             =   615
            Width           =   2085
         End
         Begin VB.CheckBox ChkFinancia 
            Caption         =   "[FIN] Financia"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   285
            Left            =   105
            TabIndex        =   6
            Top             =   1005
            Width           =   1875
         End
         Begin VB.CheckBox ChkSector 
            Caption         =   "[SEC] Sector"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   285
            Left            =   105
            TabIndex        =   7
            Top             =   1380
            Width           =   2025
         End
         Begin VB.CheckBox ChkCorresponsal 
            Caption         =   "[CORRE] Corresponsal"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   285
            Left            =   105
            TabIndex        =   8
            Top             =   1770
            Width           =   2175
         End
         Begin VB.CheckBox ChkCuota 
            Caption         =   "[C] Cuota"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   285
            Left            =   105
            TabIndex        =   10
            Top             =   2145
            Width           =   2025
         End
         Begin VB.CheckBox ChkColocacion 
            Caption         =   "[O] Colocación"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   285
            Left            =   2415
            TabIndex        =   11
            Top             =   300
            Width           =   2085
         End
         Begin VB.CheckBox ChkRecup 
            Caption         =   "[R] Recup"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   285
            Left            =   2415
            TabIndex        =   12
            Top             =   690
            Width           =   1875
         End
         Begin VB.CheckBox ChkDivisa 
            Caption         =   "[DIV] Divisa"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   285
            Left            =   2415
            TabIndex        =   14
            Top             =   1440
            Width           =   2025
         End
         Begin VB.CheckBox ChkOperacion 
            Caption         =   "[OPE] Codigo Operacion"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   285
            Left            =   2415
            TabIndex        =   13
            Top             =   1050
            Width           =   2250
         End
      End
      Begin VB.Label lbl_Ristra 
         BackColor       =   &H80000009&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   30
         TabIndex        =   24
         Top             =   2820
         Width           =   7410
      End
   End
   Begin MSComctlLib.Toolbar TlbOpciones 
      Align           =   1  'Align Top
      Height          =   480
      Left            =   0
      TabIndex        =   21
      Top             =   0
      Width           =   7515
      _ExtentX        =   13256
      _ExtentY        =   847
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   5
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Nuevo"
            Object.ToolTipText     =   "Nuevo"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Grabar"
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Cargar"
            Object.ToolTipText     =   "Cargar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Buscar"
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   5
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   5800
         Top             =   0
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
               Picture         =   "FRM_CONCEPTO_CONTABLE.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_CONCEPTO_CONTABLE.frx":0EDA
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_CONCEPTO_CONTABLE.frx":1DB4
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_CONCEPTO_CONTABLE.frx":2C8E
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_CONCEPTO_CONTABLE.frx":3B68
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame Frame1 
      Height          =   1395
      Left            =   15
      TabIndex        =   2
      Top             =   465
      Width           =   7485
      Begin VB.TextBox txt_Referencia 
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
         Left            =   1755
         TabIndex        =   3
         Top             =   930
         Width           =   750
      End
      Begin VB.TextBox TxtDescripcion 
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
         Left            =   1755
         MaxLength       =   50
         TabIndex        =   1
         Top             =   585
         Width           =   4590
      End
      Begin VB.TextBox TxtConcepto 
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
         Left            =   1755
         MaxLength       =   5
         MousePointer    =   14  'Arrow and Question
         TabIndex        =   0
         Top             =   240
         Width           =   750
      End
      Begin VB.Label LblDescripcion 
         Caption         =   "Referencia"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   270
         Index           =   2
         Left            =   150
         TabIndex        =   23
         Top             =   990
         Width           =   1470
      End
      Begin VB.Label LblDescripcion 
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
         Height          =   270
         Index           =   1
         Left            =   150
         TabIndex        =   20
         Top             =   615
         Width           =   1470
      End
      Begin VB.Label LblDescripcion 
         Caption         =   "Código Concepto"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   270
         Index           =   0
         Left            =   150
         TabIndex        =   15
         Top             =   270
         Width           =   1470
      End
   End
End
Attribute VB_Name = "FRM_CONCEPTO_CONTABLE"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim OptLocal      As String
Function FUNC_Ver_Ejemplo_Ristra()
Dim sString As String

sString = "89"

If Me.ChkProducto.Value = 1 Then
    sString = sString & "PROD"
Else
    sString = sString & "----"
End If

If Me.ChkTipoPlazo.Value = 1 Then
    sString = sString & "P"
Else
    sString = sString & "-"
End If

If Me.ChkFinancia.Value = 1 Then
    sString = sString & "FIN"
Else
    sString = sString & "---"
End If

If Me.ChkSector.Value = 1 Then
    sString = sString & "SEC"
Else
    sString = sString & "---"
End If

If Me.ChkCorresponsal.Value = 1 Then
    sString = sString & "CORRE"
Else
    sString = sString & "-----"
End If

sString = sString & "--"
'space(2,"-")

If Me.ChkCuota.Value = 1 Then
    sString = sString & "C"
Else
    sString = sString & "-"
End If

If Me.ChkColocacion.Value = 1 Then
    sString = sString & "O"
Else
    sString = sString & "-"
End If

'space(2,"-")
'space(1," ")

sString = sString & "--"
sString = sString & " "

If Me.ChkRecup.Value = 1 Then
    sString = sString & "R"
Else
    sString = sString & "-"
End If

If Me.ChkOperacion.Value = 1 Then
    sString = sString & "OPE"
Else
    sString = sString & "---"
End If

sString = sString & "CONCE"

'concepto de 5
If Me.ChkDivisa.Value = 1 Then
    sString = sString & "DIV"
Else
    sString = sString & "---"
End If

If Me.ChkTipoMoneda.Value = 1 Then
    sString = sString & "T"
Else
    sString = sString & "-"
End If

lbl_Ristra.Caption = sString

'If Me.ChkGarantia.Value = 1 Then
'If Me.ChkInventario.Value = 1 Then
'If Me.ChkPropiedad.Value = 1 Then
'If Me.ChkResultado.Value = 1 Then

End Function


Private Sub ChkColocacion_Click()
Call FUNC_Ver_Ejemplo_Ristra
End Sub

Private Sub ChkCorresponsal_Click()
Call FUNC_Ver_Ejemplo_Ristra
End Sub

Private Sub ChkCuota_Click()
Call FUNC_Ver_Ejemplo_Ristra
End Sub

Private Sub ChkDivisa_Click()
Call FUNC_Ver_Ejemplo_Ristra
End Sub


Private Sub ChkFinancia_Click()
Call FUNC_Ver_Ejemplo_Ristra
End Sub

Private Sub ChkOperacion_Click()
Call FUNC_Ver_Ejemplo_Ristra
End Sub

Private Sub ChkProducto_Click()
Call FUNC_Ver_Ejemplo_Ristra
End Sub

Private Sub ChkRecup_Click()
Call FUNC_Ver_Ejemplo_Ristra
End Sub

Private Sub ChkSector_Click()
Call FUNC_Ver_Ejemplo_Ristra
End Sub


Private Sub ChkTipoMoneda_Click()
Call FUNC_Ver_Ejemplo_Ristra
End Sub

Private Sub ChkTipoPlazo_Click()
Call FUNC_Ver_Ejemplo_Ristra
End Sub

Private Sub Form_Activate()
    PROC_CARGA_AYUDA Me, " "
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
Dim iOpcion          As Integer

   iOpcion = 0

   If KeyCode = vbKeyReturn And Me.ActiveControl.Name = "TxtConcepto" Then
      KeyCode = 0
      iOpcion = 4
      If TlbOpciones.Buttons(iOpcion).Enabled Then
         Call TlbOpciones_ButtonClick(TlbOpciones.Buttons(iOpcion))

      End If
   
   End If

   If KeyCode = vbKeyAyuda And Me.ActiveControl.Name = "TxtConcepto" Then
      KeyCode = 0
      Call TxtConcepto_DblClick
      Exit Sub

   End If


   If KeyCode = vbKeyReturn Then
      KeyCode = 0
      Bac_SendKey vbKeyTab
      Exit Sub

   End If

   If KeyCode <> vbKeyControl And (Shift = 2 Or (Shift = 0 And (KeyCode = vbKeyReturn Or KeyCode = vbKeyEscape Or (KeyCode >= vbKeyF1 And KeyCode <= vbKeyF12)))) Then
      Select Case KeyCode
      
      Case vbKeyLimpiar
         iOpcion = 1

      Case vbKeyGrabar
         iOpcion = 2

      Case vbKeyEliminar
         iOpcion = 3

      Case vbKeyBuscar
         iOpcion = 4

      Case vbKeySalir
         iOpcion = 5

      End Select

      If iOpcion <> 0 Then
         If TlbOpciones.Buttons(iOpcion).Enabled Then
            Call TlbOpciones_ButtonClick(TlbOpciones.Buttons(iOpcion))

         End If

         KeyCode = 0

      End If


   End If

End Sub


Private Sub Form_Load()

   Me.Icon = BAC_Parametros.Icon
   OptLocal = Opt
   Me.top = 0
   Me.left = 0
   PROC_HABILITA_CONTROLES False
   Call LogAuditoria("07", OptLocal, Me.Caption, "", "")

End Sub

Private Sub Form_Unload(Cancel As Integer)

   Call LogAuditoria("08", OptLocal, Me.Caption, "", "")

End Sub

Private Sub TlbOpciones_ButtonClick(ByVal Button As MSComctlLib.Button)

   Select Case UCase(Button.Key)
   
      Case "NUEVO"
         Call PROC_LIMPIAR

      Case "GRABAR"
         Call PROC_GRABAR
      
      Case "CARGAR"
         'Call PROC_ELIMINAR
      
      Case "BUSCAR"
         Call PROC_BUSCAR
      
      Case "SALIR"
         Unload Me

   End Select

End Sub

Private Sub PROC_LIMPIAR()

   PROC_HABILITA_CONTROLES False

   TxtConcepto.Text = ""
   TxtDescripcion.Text = ""
   ChkInventario.Value = 0
   ChkResultado.Value = 0
   ChkProducto.Value = 0
   ChkGarantia.Value = 0
   ChkTipoPlazo.Value = 0
   ChkFinancia.Value = 0
   ChkSector.Value = 0
   ChkCorresponsal.Value = 0
   ChkPropiedad.Value = 0
   ChkCuota.Value = 0
   ChkColocacion.Value = 0
   ChkRecup.Value = 0
   ChkDivisa.Value = 0
   ChkTipoMoneda.Value = 0
   ChkOperacion.Value = 0
     
   TxtConcepto.SetFocus

End Sub

Private Sub PROC_GRABAR()
   
   If TxtDescripcion.Text = "" Then
      MsgBox "Debe ingresar la Descripción", vbExclamation
      Exit Sub
      
   End If
   
   Envia = Array()
   AddParam Envia, TxtConcepto.Text
   AddParam Envia, TxtDescripcion.Text
   AddParam Envia, IIf(ChkInventario.Value = 1, 1, 0)
   AddParam Envia, IIf(ChkResultado.Value = 1, 1, 0)
   AddParam Envia, IIf(ChkProducto.Value = 1, 1, 0)
   AddParam Envia, IIf(ChkGarantia.Value = 1, 1, 0)
   AddParam Envia, IIf(ChkTipoPlazo.Value = 1, 1, 0)
   AddParam Envia, IIf(ChkFinancia.Value = 1, 1, 0)
   AddParam Envia, IIf(ChkSector.Value = 1, 1, 0)
   AddParam Envia, IIf(ChkCorresponsal.Value = 1, 1, 0)
   AddParam Envia, IIf(ChkPropiedad.Value = 1, 1, 0)
   AddParam Envia, IIf(ChkCuota.Value = 1, 1, 0)
   AddParam Envia, IIf(ChkColocacion.Value = 1, 1, 0)
   AddParam Envia, IIf(ChkRecup.Value = 1, 1, 0)
   AddParam Envia, IIf(ChkDivisa.Value = 1, 1, 0)
   AddParam Envia, IIf(ChkTipoMoneda.Value = 1, 1, 0)
   AddParam Envia, txt_Referencia.Text
   AddParam Envia, IIf(ChkOperacion.Value = 1, 1, 0)
   
   If Not BAC_SQL_EXECUTE("SP_ACT_CONCEPTO_CONTABILIDAD", Envia) Then
      MsgBox "Problemas Ejecutando Proceso", vbExclamation
      Call LogAuditoria("01", OptLocal, "Problemas en Grabación " & Me.Caption, "", "")
      Exit Sub
      
   End If

   MsgBox "Grabación realizada con Exito", vbInformation
   Call LogAuditoria("01", OptLocal, Me.Caption, "", "")
   Call PROC_LIMPIAR

End Sub

Private Sub PROC_ELIMINAR()
Dim Datos()

   Envia = Array()
   AddParam Envia, TxtConcepto.Text
   
   If Not BAC_SQL_EXECUTE("SP_ELI_CONCEPTO_CONTABILIDAD", Envia) Then
      MsgBox "Problemas Ejecutando Proceso", vbExclamation
      Call LogAuditoria("03", OptLocal, "Problemas en eliminación " & Me.Caption, "", "")
      Exit Sub
      
   End If

   While BAC_SQL_FETCH(Datos())
   
      If Datos(1) = "RELACIONADO" Then
         MsgBox "No se puede realizar eliminación debido a que se encuentra relacionado", vbExclamation
         Exit Sub
      
      End If

   Wend

   MsgBox "Eliminación realizada con Exito", vbInformation
   Call LogAuditoria("03", OptLocal, Me.Caption, "", "")
   Call PROC_LIMPIAR

End Sub

Private Function PROC_BUSCAR()
Dim Datos()

PROC_BUSCAR = False

   If TxtConcepto.Text = "" Then
      Exit Function
   End If
   
   Envia = Array()
   AddParam Envia, TxtConcepto.Text
   
   If Not BAC_SQL_EXECUTE("SP_CON_CONCEPTO_CONTABILIDAD", Envia) Then
      MsgBox "Problemas Ejecutando Proceso", vbExclamation
      Exit Function
   End If
   
   While BAC_SQL_FETCH(Datos())
   
      TxtDescripcion.Text = Datos(2)
      ChkInventario.Enabled = True
      ChkInventario.Value = IIf(Datos(3) = 1, 1, 0)
      ChkResultado.Value = IIf(Datos(4) = 1, 1, 0)
      ChkProducto.Value = IIf(Datos(5) = 1, 1, 0)
      ChkGarantia.Value = IIf(Datos(6) = 1, 1, 0)
      ChkTipoPlazo.Value = IIf(Datos(7) = 1, 1, 0)
      ChkFinancia.Value = IIf(Datos(8) = 1, 1, 0)
      ChkSector.Value = IIf(Datos(9) = 1, 1, 0)
      ChkCorresponsal.Value = IIf(Datos(10) = 1, 1, 0)
      ChkPropiedad.Value = IIf(Datos(11) = 1, 1, 0)
      ChkCuota.Value = IIf(Datos(12) = 1, 1, 0)
      ChkColocacion.Value = IIf(Datos(13) = 1, 1, 0)
      ChkRecup.Value = IIf(Datos(14) = 1, 1, 0)
      ChkDivisa.Value = IIf(Datos(15) = 1, 1, 0)
      ChkTipoMoneda.Value = IIf(Datos(16) = 1, 1, 0)
      txt_Referencia.Text = Datos(17)
      ChkOperacion.Value = IIf(Datos(18) = 1, 1, 0)
      PROC_BUSCAR = True
   Wend
   
   PROC_HABILITA_CONTROLES True
   
   If TxtDescripcion.Enabled Then
      TxtDescripcion.SetFocus
   End If
   
   
End Function

Private Sub PROC_HABILITA_CONTROLES(bEstado As Boolean)

   With TlbOpciones

      .Buttons(2).Enabled = bEstado
      .Buttons(3).Enabled = bEstado
      .Buttons(4).Enabled = Not bEstado

   End With

   TxtConcepto.Enabled = Not bEstado
   TxtDescripcion.Enabled = bEstado
   ChkInventario.Enabled = bEstado
   ChkResultado.Enabled = bEstado
   ChkProducto.Enabled = bEstado
   ChkGarantia.Enabled = bEstado
   ChkTipoPlazo.Enabled = bEstado
   ChkFinancia.Enabled = bEstado
   ChkSector.Enabled = bEstado
   ChkCorresponsal.Enabled = bEstado
   ChkPropiedad.Enabled = bEstado
   ChkCuota.Enabled = bEstado
   ChkColocacion.Enabled = bEstado
   ChkRecup.Enabled = bEstado
   ChkDivisa.Enabled = bEstado
   ChkTipoMoneda.Enabled = bEstado
   txt_Referencia.Enabled = bEstado
   ChkOperacion.Enabled = bEstado
   
End Sub

Private Sub TxtConcepto_DblClick()

   MiTag = "CONCEPTO_CONTABILIDAD"
   BacAyuda.Show 1

   If giAceptar% Then
      TxtConcepto = gsCodigo
      Call PROC_BUSCAR
   End If


End Sub

Private Sub TxtConcepto_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then
          If Not PROC_BUSCAR Then
            TxtConcepto.Text = ""
            TxtDescripcion.Enabled = False
            PROC_HABILITA_CONTROLES False
          End If
   End If

    BacToUCase KeyAscii
   
End Sub

Private Sub TxtControlCentral_KeyPress(KeyAscii As Integer)
   
   KeyAscii = Asc(UCase(Chr(KeyAscii)))

End Sub

Private Sub TxtCuentaControl_KeyPress(KeyAscii As Integer)
   
   KeyAscii = Asc(UCase(Chr(KeyAscii)))

End Sub

Private Sub TxtDescripcion_KeyPress(KeyAscii As Integer)
   
   KeyAscii = Asc(UCase(Chr(KeyAscii)))

End Sub

Private Sub TxtPartida_KeyPress(KeyAscii As Integer)
   
   KeyAscii = Asc(UCase(Chr(KeyAscii)))

End Sub
