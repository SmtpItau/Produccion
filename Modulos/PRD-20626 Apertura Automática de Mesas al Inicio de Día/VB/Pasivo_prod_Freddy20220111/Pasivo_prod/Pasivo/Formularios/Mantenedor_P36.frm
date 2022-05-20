VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{989C9190-EDF5-45A8-AB6C-98E6EF0384D7}#1.0#0"; "Bac_Controles_Pas.ocx"
Begin VB.Form Mantenedor_P36 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Mantenedor estructura de registros P36"
   ClientHeight    =   3810
   ClientLeft      =   45
   ClientTop       =   405
   ClientWidth     =   6735
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   3810
   ScaleWidth      =   6735
   ShowInTaskbar   =   0   'False
   Begin VB.Frame Frame1 
      Height          =   945
      Left            =   30
      TabIndex        =   10
      Top             =   420
      Width           =   6705
      Begin VB.TextBox TxtSerie 
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
         Left            =   90
         MaxLength       =   15
         TabIndex        =   1
         Top             =   510
         Width           =   1755
      End
      Begin VB.TextBox TxtNumero_de_inscripcion 
         Alignment       =   1  'Right Justify
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
         Left            =   2070
         MaxLength       =   10
         TabIndex        =   2
         Top             =   510
         Width           =   1845
      End
      Begin BACControles.TXTFecha TXT_Fecha_inscripcion 
         Height          =   315
         Left            =   4200
         TabIndex        =   3
         Top             =   510
         Width           =   1755
         _ExtentX        =   3096
         _ExtentY        =   556
         Enabled         =   -1  'True
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
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "16/04/2003"
      End
      Begin VB.Label Label7 
         AutoSize        =   -1  'True
         Caption         =   "Fecha de inscripción"
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
         Height          =   210
         Left            =   4200
         TabIndex        =   13
         Top             =   240
         Width           =   1695
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Nombre de Serie"
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
         Height          =   210
         Left            =   120
         TabIndex        =   12
         Top             =   210
         Width           =   1395
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "Número de inscripción"
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
         Height          =   210
         Left            =   2100
         TabIndex        =   11
         Top             =   210
         Width           =   1875
      End
   End
   Begin MSComctlLib.Toolbar Tlb_Mant_Instrumento 
      Align           =   1  'Align Top
      Height          =   480
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   6735
      _ExtentX        =   11880
      _ExtentY        =   847
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList2"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   5
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Limpiar"
            Description     =   "Limpiar"
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Grabar"
            Description     =   "Grabar"
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Key             =   "Eliminar"
            Description     =   "Eliminar"
            Object.ToolTipText     =   "Eliminar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Buscar"
            Description     =   "Buscar"
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Description     =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   1
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList2 
         Left            =   6120
         Top             =   30
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
               Picture         =   "Mantenedor_P36.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Mantenedor_P36.frx":031A
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Mantenedor_P36.frx":11F4
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Mantenedor_P36.frx":20CE
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Mantenedor_P36.frx":2FA8
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame Frame2 
      Height          =   1575
      Left            =   30
      TabIndex        =   14
      Top             =   1290
      Width           =   6705
      Begin VB.TextBox TxtClasificadora_de_Riesgo1 
         Alignment       =   1  'Right Justify
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
         Left            =   90
         MaxLength       =   3
         TabIndex        =   4
         Top             =   450
         Width           =   2730
      End
      Begin VB.TextBox TxtClasificacion_de_Riesgo1 
         Alignment       =   1  'Right Justify
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
         Left            =   3120
         MaxLength       =   5
         TabIndex        =   5
         Top             =   450
         Width           =   2730
      End
      Begin VB.TextBox TxtClasificadora_de_Riesgo2 
         Alignment       =   1  'Right Justify
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
         Left            =   90
         MaxLength       =   3
         TabIndex        =   6
         Top             =   1110
         Width           =   2730
      End
      Begin VB.TextBox TxtClasificacion_de_Riesgo2 
         Alignment       =   1  'Right Justify
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
         Left            =   3120
         MaxLength       =   5
         TabIndex        =   7
         Top             =   1110
         Width           =   2730
      End
      Begin VB.Label Label3 
         AutoSize        =   -1  'True
         Caption         =   "Clasificadora de Riesgo 1"
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
         Height          =   210
         Left            =   90
         TabIndex        =   18
         Top             =   180
         Width           =   2070
      End
      Begin VB.Label Label4 
         AutoSize        =   -1  'True
         Caption         =   "Clasificación de Riesgo  1"
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
         Height          =   210
         Left            =   3120
         TabIndex        =   17
         Top             =   180
         Width           =   2085
      End
      Begin VB.Label Label5 
         AutoSize        =   -1  'True
         Caption         =   "Clasificadora de Riesgo 2"
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
         Height          =   210
         Left            =   120
         TabIndex        =   16
         Top             =   840
         Width           =   2070
      End
      Begin VB.Label Label6 
         AutoSize        =   -1  'True
         Caption         =   "Clasificación de Riesgo  2"
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
         Height          =   210
         Left            =   3120
         TabIndex        =   15
         Top             =   840
         Width           =   2085
      End
   End
   Begin VB.Frame Frame3 
      Height          =   1005
      Left            =   30
      TabIndex        =   19
      Top             =   2790
      Width           =   6705
      Begin BACControles.TXTFecha TXTFecha_limite_para_la_colocacion 
         Height          =   315
         Left            =   120
         TabIndex        =   8
         Top             =   450
         Width           =   1755
         _ExtentX        =   3096
         _ExtentY        =   556
         Enabled         =   -1  'True
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
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "16/04/2003"
      End
      Begin BACControles.TXTNumero FTB_Monto_inscrito 
         Height          =   315
         Left            =   3090
         TabIndex        =   9
         Top             =   450
         Width           =   2025
         _ExtentX        =   3572
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
         Min             =   "1"
         Max             =   "99999999999999"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin VB.Label Label9 
         AutoSize        =   -1  'True
         Caption         =   "Monto inscrito"
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
         Height          =   210
         Left            =   3090
         TabIndex        =   21
         Top             =   180
         Width           =   1200
      End
      Begin VB.Label Label8 
         AutoSize        =   -1  'True
         Caption         =   "Fecha limite para la  colocación"
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
         Height          =   210
         Left            =   120
         TabIndex        =   20
         Top             =   180
         Width           =   2535
      End
   End
End
Attribute VB_Name = "Mantenedor_P36"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Form_Load()
   Me.Icon = FRM_MDI_PASIVO.Icon
   Me.TXT_Fecha_inscripcion.Text = GLB_Fecha_Proceso
   Me.TXTFecha_limite_para_la_colocacion.Text = GLB_Fecha_Proceso
  
End Sub



Private Sub Tlb_Mant_Instrumento_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Trim(UCase(Button.Key))
      Case "SALIR"
         Unload Me
         
      Case "LIMPIAR"
      
            Call LIMPIAR_PANTALLA
            
      Case "GRABAR"
      
            Call GRABAR
            
      Case "BUSCAR"
      
             Call Buscar
             
   End Select

End Sub

Private Sub TXT_Fecha_inscripcion_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then
      FUNC_ENVIA_TECLA (vbKeyTab)
   End If

End Sub

Private Sub TxtClasificacion_de_Riesgo1_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then
      FUNC_ENVIA_TECLA (vbKeyTab)
   End If

End Sub

Private Sub TxtClasificacion_de_Riesgo2_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then
      FUNC_ENVIA_TECLA (vbKeyTab)
   End If

End Sub

Private Sub TxtClasificadora_de_Riesgo1_KeyPress(KeyAscii As Integer)
    If KeyAscii <> 13 And KeyAscii <> 8 Then
        'Si no es numerico
        If Not IsNumeric(Chr$(KeyAscii)) Then
            KeyAscii = 0
        End If
    End If
    
    
    If KeyAscii = 13 Then
      FUNC_ENVIA_TECLA (vbKeyTab)
    End If

    
End Sub

Private Sub TxtClasificadora_de_Riesgo2_KeyPress(KeyAscii As Integer)
    If KeyAscii <> 13 And KeyAscii <> 8 Then
        'Si no es numerico
        If Not IsNumeric(Chr$(KeyAscii)) Then
            KeyAscii = 0
        End If
    End If
    
    If KeyAscii = 13 Then
      FUNC_ENVIA_TECLA (vbKeyTab)
   End If

    
End Sub
Private Sub TXTFecha_limite_para_la_colocacion_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then
      FUNC_ENVIA_TECLA (vbKeyTab)
   End If

End Sub


Private Sub TxtNumero_de_inscripcion_KeyPress(KeyAscii As Integer)
   If KeyAscii = vbKeyReturn Then
      FUNC_ENVIA_TECLA (vbKeyTab)
   End If

End Sub

Private Sub TxtSerie_DblClick()
    Call LIMPIAR_PANTALLA
    Call PROC_CON_SERIES

End Sub

Sub PROC_CON_SERIES()
On Error GoTo Error_series
     
        Pbl_cCodigo_Serie = "BONOS"
        cMiTag = "MDSE"
        FRM_AYUDA.Show 1
        
        If GLB_Aceptar% = True Then
            TxtSerie.Text = GLB_codigo$
        End If

Exit Sub
Error_series:
      MousePointer = 0
      MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical
      Exit Sub
      
End Sub

Private Sub LIMPIAR_PANTALLA()

    Me.TxtSerie.Text = ""
    Me.TxtNumero_de_inscripcion.Text = ""
    Me.TxtClasificacion_de_Riesgo1.Text = ""
    Me.TxtClasificacion_de_Riesgo2.Text = ""
    Me.TxtClasificadora_de_Riesgo1.Text = ""
    Me.TxtClasificadora_de_Riesgo2.Text = ""
    FTB_Monto_inscrito.Text = 0
    Me.TXT_Fecha_inscripcion.Text = GLB_Fecha_Proceso
    Me.TXTFecha_limite_para_la_colocacion.Text = GLB_Fecha_Proceso

End Sub

Private Sub Buscar()

Dim vDatos_Retorno()
Dim Numero_de_inscripcion As String

Numero_de_inscripcion = Me.TxtNumero_de_inscripcion.Text & "|"

   GLB_Envia = Array()
   PROC_AGREGA_PARAMETRO GLB_Envia, Me.TxtSerie.Text
   PROC_AGREGA_PARAMETRO GLB_Envia, Numero_de_inscripcion
   
   If FUNC_EXECUTA_COMANDO_SQL("sp_buscar_P36", GLB_Envia) Then
   
      If FUNC_LEE_RETORNO_SQL(vDatos_Retorno()) Then
            If (vDatos_Retorno(1) = "Error") Then
                MsgBox "" & vDatos_Retorno(2), vbExclamation
                Call LIMPIAR_PANTALLA
            Else
                
                Me.TxtSerie.Text = vDatos_Retorno(1)
                Me.TxtNumero_de_inscripcion.Text = vDatos_Retorno(6)
                Me.TxtClasificacion_de_Riesgo1.Text = vDatos_Retorno(3)
                Me.TxtClasificacion_de_Riesgo2.Text = vDatos_Retorno(5)
                Me.TxtClasificadora_de_Riesgo1.Text = vDatos_Retorno(2)
                Me.TxtClasificadora_de_Riesgo2.Text = vDatos_Retorno(4)
                FTB_Monto_inscrito.Text = vDatos_Retorno(9)
                Me.TXT_Fecha_inscripcion.Text = vDatos_Retorno(7)
                Me.TXTFecha_limite_para_la_colocacion.Text = vDatos_Retorno(8)
                
                          
            End If
      End If
      
   Else
        MsgBox "Error al cargar procedimiento", vbCritical
   End If
End Sub

Private Function GRABAR()

Dim vDatos_Retorno()
Dim Numero_de_inscripcion As String

Numero_de_inscripcion = Me.TxtNumero_de_inscripcion.Text & "|"

If Me.TxtClasificadora_de_Riesgo1.Text = "" Then
    Me.TxtClasificadora_de_Riesgo1.Text = 0
End If

If Me.TxtClasificadora_de_Riesgo2.Text = "" Then
    Me.TxtClasificadora_de_Riesgo2.Text = 0
End If

   GLB_Envia = Array()
   PROC_AGREGA_PARAMETRO GLB_Envia, Me.TxtSerie.Text
   PROC_AGREGA_PARAMETRO GLB_Envia, CInt(Me.TxtClasificadora_de_Riesgo1.Text)
   PROC_AGREGA_PARAMETRO GLB_Envia, Me.TxtClasificacion_de_Riesgo1.Text
   PROC_AGREGA_PARAMETRO GLB_Envia, CInt(Me.TxtClasificadora_de_Riesgo2.Text)
   PROC_AGREGA_PARAMETRO GLB_Envia, Me.TxtClasificacion_de_Riesgo2.Text
   PROC_AGREGA_PARAMETRO GLB_Envia, Numero_de_inscripcion
   PROC_AGREGA_PARAMETRO GLB_Envia, Me.TXT_Fecha_inscripcion.Text
   PROC_AGREGA_PARAMETRO GLB_Envia, Me.TXTFecha_limite_para_la_colocacion.Text
   PROC_AGREGA_PARAMETRO GLB_Envia, CDbl(FTB_Monto_inscrito.Text)

   If FUNC_EXECUTA_COMANDO_SQL("sp_Grabar_P36", GLB_Envia) Then

        If FUNC_LEE_RETORNO_SQL(vDatos_Retorno()) Then
            If (vDatos_Retorno(1) = "Error") Then
                MsgBox "" & vDatos_Retorno(2), vbExclamation
                Call LIMPIAR_PANTALLA
            Else
                MsgBox "" & vDatos_Retorno(1), vbInformation
                Call LIMPIAR_PANTALLA
            End If
        End If
            
    Else
                MsgBox " Error al cargar procedimiento", vbCritical
          
   End If

End Function


Public Function FUNC_ENVIA_TECLA(ByVal nKey As Integer)
 
   KeyBD_Event nKey, 0, 0, 0
 
End Function

Private Sub TxtSerie_KeyPress(KeyAscii As Integer)
   If KeyAscii = vbKeyReturn Then
      FUNC_ENVIA_TECLA (vbKeyTab)
   End If
End Sub


Private Sub TxtSerie_LostFocus()
If TxtSerie.Text <> "" Then
    Call Buscar
End If
End Sub
