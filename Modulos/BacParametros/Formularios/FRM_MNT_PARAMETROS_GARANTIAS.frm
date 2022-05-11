VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form FRM_MNT_PARAMETROS_GARANTIAS 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Parámetros Generales de Garantías"
   ClientHeight    =   2730
   ClientLeft      =   645
   ClientTop       =   2220
   ClientWidth     =   5055
   LinkTopic       =   "Form2"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   2730
   ScaleWidth      =   5055
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   5055
      _ExtentX        =   8916
      _ExtentY        =   794
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   5
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Object.ToolTipText     =   "Recargar valores"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar / Actualizar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Cerrar"
            ImageIndex      =   4
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   4470
         Top             =   15
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   22
         ImageHeight     =   22
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   6
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_PARAMETROS_GARANTIAS.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_PARAMETROS_GARANTIAS.frx":0EDA
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_PARAMETROS_GARANTIAS.frx":1034
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_PARAMETROS_GARANTIAS.frx":1F0E
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_PARAMETROS_GARANTIAS.frx":2228
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_PARAMETROS_GARANTIAS.frx":3102
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame Frame1 
      Height          =   2310
      Left            =   30
      TabIndex        =   7
      Top             =   375
      Width           =   4995
      Begin BACControles.TXTNumero TXT_FactorMultiplicativo 
         Height          =   255
         Left            =   2520
         TabIndex        =   1
         Top             =   600
         Width           =   1095
         _ExtentX        =   1931
         _ExtentY        =   450
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
         Text            =   "0.00"
         Text            =   "0.00"
         Min             =   "0"
         Max             =   "1E+14"
         CantidadDecimales=   "2"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin BACControles.TXTNumero TXT_FactorAditivo 
         Height          =   255
         Left            =   2520
         TabIndex        =   3
         Top             =   960
         Width           =   1095
         _ExtentX        =   1931
         _ExtentY        =   450
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
         Text            =   "0"
         Text            =   "0"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin BACControles.TXTNumero TXT_MontoConstitucion 
         Height          =   255
         Left            =   2520
         TabIndex        =   5
         Top             =   1440
         Width           =   2295
         _ExtentX        =   4048
         _ExtentY        =   450
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
         Text            =   "0"
         Text            =   "0"
         Min             =   "0"
         Max             =   "1E+16"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin BACControles.TXTNumero TXT_MontoRetiro 
         Height          =   255
         Left            =   2520
         TabIndex        =   6
         Top             =   1800
         Width           =   2295
         _ExtentX        =   4048
         _ExtentY        =   450
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
         Text            =   "0"
         Text            =   "0"
         Min             =   "0"
         Max             =   "1E+16"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin BACControles.TXTNumero txt_FacMultiplicativo_Otor 
         Height          =   255
         Left            =   3720
         TabIndex        =   2
         Top             =   600
         Width           =   1095
         _ExtentX        =   1931
         _ExtentY        =   450
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
         Text            =   "0.00"
         Text            =   "0.00"
         Min             =   "0"
         Max             =   "1E+14"
         CantidadDecimales=   "2"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin BACControles.TXTNumero txt_FacAditivoOtor 
         Height          =   255
         Left            =   3720
         TabIndex        =   4
         Top             =   960
         Width           =   1095
         _ExtentX        =   1931
         _ExtentY        =   450
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
         Text            =   "0"
         Text            =   "0"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin VB.Label LblEtiqueta 
         AutoSize        =   -1  'True
         Caption         =   "Otorgadas"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   5
         Left            =   3720
         TabIndex        =   13
         Top             =   360
         Width           =   885
      End
      Begin VB.Label LblEtiqueta 
         AutoSize        =   -1  'True
         Caption         =   "Constituídas"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   4
         Left            =   2520
         TabIndex        =   12
         Top             =   360
         Width           =   1050
      End
      Begin VB.Label LblEtiqueta 
         AutoSize        =   -1  'True
         Caption         =   "Monto para retiro"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   3
         Left            =   720
         TabIndex        =   11
         Top             =   1800
         Width           =   1500
      End
      Begin VB.Label LblEtiqueta 
         AutoSize        =   -1  'True
         Caption         =   "Monto para constitución"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   2
         Left            =   150
         TabIndex        =   10
         Top             =   1470
         Width           =   2055
      End
      Begin VB.Label LblEtiqueta 
         AutoSize        =   -1  'True
         Caption         =   "Factor Aditivo"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   1
         Left            =   990
         TabIndex        =   9
         Top             =   1020
         Width           =   1185
      End
      Begin VB.Label LblEtiqueta 
         AutoSize        =   -1  'True
         Caption         =   "Factor Multiplicativo"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   0
         Left            =   390
         TabIndex        =   8
         Top             =   630
         Width           =   1725
      End
   End
End
Attribute VB_Name = "FRM_MNT_PARAMETROS_GARANTIAS"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Function funcValidar_Information() As Boolean
Dim sMensaje As String

    Let funcValidar_Information = False
    
    Let sMensaje = ""
    
    
    If Len(sMensaje) > 0 Then
        MsgBox sMensaje, vbExclamation, TITSISTEMA
        Exit Function
    End If


    funcValidar_Information = True
    
End Function
Private Sub Limpiar()
    TXT_FactorAditivo.Text = 0
    txt_FacAditivoOtor.Text = 0
    TXT_FactorMultiplicativo.Text = 0#
    txt_FacMultiplicativo_Otor.Text = 0#
    TXT_MontoConstitucion.Text = 0
    TXT_MontoRetiro.Text = 0
    
End Sub

Private Sub subLOAD_Parametros()
Dim Datos()

    If Not Bac_Sql_Execute("bacparamsuda.dbo.sp_gar_cargaParametros") Then
        Call MsgBox("Se ha generado un error en la carga de Información.", vbExclamation, App.Title)
        Exit Sub
    End If
    
    Do While Bac_SQL_Fetch(Datos())
        Me.TXT_FactorMultiplicativo.Text = Datos(1)
        Me.TXT_FactorAditivo.Text = Datos(2)
        Me.TXT_MontoConstitucion.Text = Datos(3)
        Me.TXT_MontoRetiro.Text = Datos(4)
        Me.txt_FacMultiplicativo_Otor.Text = Datos(5)
        Me.txt_FacAditivoOtor.Text = Datos(6)
    Loop
   
End Sub



Private Sub Form_Load()

   Let Me.Top = 0:   Let Me.Left = 0
   Let Me.Icon = BACSwapParametros.Icon
   Let Me.Caption = "Parametros Generales de Garantía."
   

   Call subLOAD_Parametros
  
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
    Select Case Button.Index
        Case 2
            Call Limpiar
        Case 3
            Call Recargar
        Case 4
            Call subGrabar_Informacion
        Case 5
            Call Unload(Me)
    End Select
End Sub
Private Sub Recargar()
    Call subLOAD_Parametros
End Sub
Private Sub subGrabar_Informacion()

    If Not funcValidar_Information() Then
        Exit Sub
    End If
    
    If MsgBox("¿Está seguro de actualizar los parámetros?", vbQuestion + vbYesNo + vbDefaultButton2, TITSISTEMA) = vbNo Then
        Exit Sub
    End If

    Envia = Array()
    AddParam Envia, CDbl(TXT_FactorMultiplicativo.Text)
    AddParam Envia, CDbl(TXT_FactorAditivo.Text)
    AddParam Envia, CDbl(TXT_MontoConstitucion.Text)
    AddParam Envia, CDbl(TXT_MontoRetiro.Text)
    AddParam Envia, CDbl(txt_FacMultiplicativo_Otor.Text)
    AddParam Envia, CDbl(txt_FacAditivoOtor.Text)

    If Not Bac_Sql_Execute("bacparamsuda.dbo.sp_gar_grabaParametros", Envia) Then
        Call MsgBox("Se ha generado un error en la actualización de información.", vbExclamation, App.Title)
        Exit Sub
    End If

    
   
End Sub



Private Sub txt_FacAditivoOtor_KeyPress(KeyAscii As Integer)
    If KeyAscii = vbKeyReturn Then
        KeyAscii = 0
        SendKeys "{TAB}"
    End If
End Sub

Private Sub txt_FacMultiplicativo_Otor_KeyPress(KeyAscii As Integer)
    If KeyAscii = vbKeyReturn Then
        KeyAscii = 0
        SendKeys "{TAB}"
    End If
End Sub

Private Sub TXT_FactorAditivo_KeyPress(KeyAscii As Integer)

    If KeyAscii = vbKeyReturn Then
    
        Let KeyAscii = 0
        'Call TXT_MontoConstitucion.SetFocus
        SendKeys "{TAB}"
        
    End If

End Sub
Private Sub TXT_FactorMultiplicativo_KeyPress(KeyAscii As Integer)

    If KeyAscii = vbKeyReturn Then
        Let KeyAscii = 0
        'Call TXT_FactorAditivo.SetFocus
        'Call txt_FacMultiplicativo_Otor.SetFocus
        SendKeys "{TAB}"
    End If

End Sub
Private Sub TXT_MontoConstitucion_KeyPress(KeyAscii As Integer)

    If KeyAscii = vbKeyReturn Then
        Let KeyAscii = 0
        'Call TXT_MontoRetiro.SetFocus
        SendKeys "{TAB}"
    End If

End Sub
Private Sub TXT_MontoRetiro_KeyPress(KeyAscii As Integer)
    If KeyAscii = vbKeyReturn Then
        KeyAscii = 0
        SendKeys "{TAB}"
    End If

End Sub
