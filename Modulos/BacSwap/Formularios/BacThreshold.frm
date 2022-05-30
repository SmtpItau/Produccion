VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacThreshold 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Threshold"
   ClientHeight    =   2025
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   5160
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2025
   ScaleWidth      =   5160
   StartUpPosition =   2  'CenterScreen
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   1245
      Top             =   -135
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
            Picture         =   "BacThreshold.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacThreshold.frx":0452
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacThreshold.frx":076C
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacThreshold.frx":1646
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacThreshold.frx":2520
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacThreshold.frx":33FA
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   5160
      _ExtentX        =   9102
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
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Aceptar"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Cancelar / Volver"
            ImageIndex      =   6
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin VB.Frame FRA_THRESHOLD 
      Height          =   585
      Left            =   15
      TabIndex        =   6
      Top             =   375
      Width           =   5175
      Begin VB.OptionButton OPTThreshold 
         Caption         =   "SI Aplica Threshold"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   225
         Index           =   0
         Left            =   480
         TabIndex        =   8
         Top             =   210
         Value           =   -1  'True
         Width           =   2040
      End
      Begin VB.OptionButton OPTThreshold 
         Caption         =   "NO Aplica Threshold"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   225
         Index           =   1
         Left            =   2925
         TabIndex        =   7
         Top             =   210
         Width           =   2040
      End
   End
   Begin Threed.SSFrame SSFrame1 
      Height          =   1200
      Left            =   15
      TabIndex        =   1
      Top             =   810
      Width           =   5130
      _Version        =   65536
      _ExtentX        =   9049
      _ExtentY        =   2117
      _StockProps     =   14
      ForeColor       =   8388608
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   13.5
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Font3D          =   3
      Begin BACControles.TXTNumero txtValorAplic 
         Height          =   375
         Left            =   2010
         TabIndex        =   2
         Top             =   675
         Width           =   3015
         _ExtentX        =   5318
         _ExtentY        =   661
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0"
         Text            =   "0"
         Min             =   "0"
         Max             =   "1E+14"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin BACControles.TXTNumero txtValorProp 
         Height          =   375
         Left            =   2010
         TabIndex        =   3
         Top             =   270
         Width           =   3015
         _ExtentX        =   5318
         _ExtentY        =   661
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0"
         Text            =   "0"
         Min             =   "0"
         Max             =   "1E+14"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin VB.Label Label4 
         Caption         =   "Threshold Propuesto"
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
         Left            =   135
         TabIndex        =   5
         Top             =   360
         Width           =   1770
      End
      Begin VB.Label Label3 
         AutoSize        =   -1  'True
         Caption         =   "Threshold Operación"
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
         Left            =   150
         TabIndex        =   4
         Top             =   750
         Width           =   1785
      End
   End
End
Attribute VB_Name = "BacThreshold"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim tipoSalida    As String
Dim nValorRec     As Double
Dim MSGThreshold  As String

Private Sub Form_Activate()
   Call RetornaValorRec("PCS", Thr_NumeroOperacion)
End Sub

Private Sub Form_Load()
   Me.Icon = BACSwap.Icon
End Sub

Private Function RetornaValorRec(ByVal Modulo As String, ByVal NumeroOperacion As Long)
   Dim DATOS()

   Let Screen.MousePointer = vbHourglass

   Envia = Array()
   AddParam Envia, Modulo
   AddParam Envia, NumeroOperacion
   If Not Bac_Sql_Execute("BACPARAMSUDA.dbo.SP_GENERA_THRESHOLD_INICIO", Envia) Then
      Call MsgBox("Errores en el procesos de obtencion del Threshold Propuesto.", vbExclamation, App.Title)
      Exit Function
   End If
   If Bac_SQL_Fetch(DATOS()) Then
      Let nValorRec = CDbl(DATOS(5))
      If DATOS(4) = "N" Then
         Let OPTThreshold.Item(1).Value = True
      End If
      Let txtValorProp.Text = CDbl(DATOS(1))
      Let txtValorAplic.Text = CDbl(DATOS(2))
      Let MSGThreshold = ""
   End If
   Let Screen.MousePointer = vbDefault
End Function

Private Sub OPTThreshold_Click(Index As Integer)
   If Index = 1 Then
      Let SSFrame1.Enabled = False
      Let txtValorAplic.Text = 0
      Let txtValorAplic.Enabled = False
      Let Thr_OptAplicaThreshold = False
   Else
      Let SSFrame1.Enabled = True
      Let txtValorAplic.Text = txtValorProp.Text
      Let txtValorAplic.Enabled = True
      Let Thr_OptAplicaThreshold = True
      
      If txtValorAplic.Text = 0# Then
         Let txtValorAplic.Text = nValorRec
      End If
   End If
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   tipoSalida = -1
   Select Case Button.Index
      Case 2  'Grabar
         Call FuncSaveThreshold
    Case 3  'Cancelar
      Call AnulaOperacion
      Thr_GrabaThreshold = False
      Unload Me
      Exit Sub
   End Select
End Sub

Private Function FuncSaveThreshold()
         
   If Val(txtValorAplic.Text) < 0# Then
      If MsgBox("¡ Esta Aplicando Threshold Cero !.. ¿ Desea Continuar ? ", vbQuestion + vbYesNo, TITSISTEMA) = vbNo Then
         Exit Function
      End If
   End If

   Thr_GrabaThreshold = True
   Thr_ValorPropuesto = CDbl(txtValorProp.Text)
   Thr_ValorAplicado = CDbl(txtValorAplic.Text)
   Thr_MensajeLineas = MSGThreshold
   
   Unload Me
End Function

Private Function AnulaOperacion()

   Call Lineas_Anular("PCS", CLng(Thr_NumeroOperacion))
    
   If Not BorrarOpThreshold Then
      MsgBox "Se ha producido un error al eliminar el threshold de la operación", vbExclamation, TITSISTEMA
      Exit Function
   End If

   Envia = Array()
   AddParam Envia, Thr_NumeroOperacion
   If Not Bac_Sql_Execute("SP_BORRAR_OPERACION", Envia) Then
     'MsgBox "Problema al eliminar la operación", vbExclamation, "MENSAJE"
   End If

   Envia = Array()
   AddParam Envia, "PCS"
   AddParam Envia, CDbl(Thr_NumeroOperacion)
   AddParam Envia, CDbl(1#)
   Call Bac_Sql_Execute("BacTraderSuda..SP_ACTUALIZACION_POSTVENTA", Envia)

  'Call MsgBox("La Grabación operación se ha cancelado... ", vbInformation, TITSISTEMA)

End Function
