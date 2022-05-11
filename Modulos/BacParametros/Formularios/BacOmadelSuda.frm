VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Begin VB.Form BacOmadelSuda 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Asociación Oma - Código Comercio"
   ClientHeight    =   3360
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   5415
   LinkTopic       =   "Form2"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   3360
   ScaleWidth      =   5415
   Begin Threed.SSFrame SSFrame1 
      Height          =   2760
      Left            =   0
      TabIndex        =   0
      Top             =   600
      Width           =   5415
      _Version        =   65536
      _ExtentX        =   9551
      _ExtentY        =   4868
      _StockProps     =   14
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin VB.TextBox Glosa 
         Height          =   345
         Left            =   240
         TabIndex        =   12
         Text            =   "Text1"
         Top             =   2190
         Width           =   4905
      End
      Begin VB.TextBox CodigoComercio 
         Height          =   300
         Left            =   2160
         MousePointer    =   14  'Arrow and Question
         TabIndex        =   11
         Text            =   "Text1"
         Top             =   1830
         Width           =   1215
      End
      Begin VB.ComboBox Cmb_TipoOma 
         Height          =   315
         Left            =   2160
         Style           =   2  'Dropdown List
         TabIndex        =   10
         Top             =   1440
         Width           =   3015
      End
      Begin VB.ComboBox Cmb_TipOpe 
         Height          =   315
         Left            =   2160
         Style           =   2  'Dropdown List
         TabIndex        =   9
         Top             =   1080
         Width           =   1335
      End
      Begin VB.TextBox Txt_Glosa 
         Height          =   285
         Left            =   2160
         MaxLength       =   40
         TabIndex        =   8
         Text            =   "Text1"
         Top             =   720
         Width           =   3015
      End
      Begin VB.TextBox Txt_Codigo 
         Height          =   285
         Left            =   2160
         MaxLength       =   2
         MousePointer    =   14  'Arrow and Question
         TabIndex        =   7
         Text            =   "Text1"
         Top             =   360
         Width           =   1215
      End
      Begin VB.Label Label1 
         Caption         =   "Código Comercio"
         ForeColor       =   &H00800000&
         Height          =   255
         Index           =   4
         Left            =   255
         TabIndex        =   13
         Top             =   1860
         Width           =   1335
      End
      Begin VB.Label Label1 
         Caption         =   "Tipo OMA"
         ForeColor       =   &H00800000&
         Height          =   255
         Index           =   3
         Left            =   240
         TabIndex        =   6
         Top             =   1500
         Width           =   1335
      End
      Begin VB.Label Label1 
         Caption         =   "Tipo Operación"
         ForeColor       =   &H00800000&
         Height          =   255
         Index           =   2
         Left            =   240
         TabIndex        =   5
         Top             =   1125
         Width           =   1455
      End
      Begin VB.Label Label1 
         Caption         =   "Concepto Operación"
         ForeColor       =   &H00800000&
         Height          =   255
         Index           =   1
         Left            =   240
         TabIndex        =   4
         Top             =   735
         Width           =   1815
      End
      Begin VB.Label Label1 
         Caption         =   "Código Operación"
         ForeColor       =   &H00800000&
         Height          =   255
         Index           =   0
         Left            =   240
         TabIndex        =   3
         Top             =   375
         Width           =   1335
      End
   End
   Begin Threed.SSFrame SSFrame2 
      Height          =   615
      Left            =   0
      TabIndex        =   1
      Top             =   0
      Width           =   5415
      _Version        =   65536
      _ExtentX        =   9551
      _ExtentY        =   1085
      _StockProps     =   14
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin MSComctlLib.Toolbar Toolbar1 
         Height          =   480
         Left            =   120
         TabIndex        =   2
         Top             =   120
         Width           =   5175
         _ExtentX        =   9128
         _ExtentY        =   847
         ButtonWidth     =   767
         ButtonHeight    =   741
         Appearance      =   1
         ImageList       =   "ImageList1"
         _Version        =   393216
         BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
            NumButtons      =   4
            BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Key             =   "Limpiar"
               Description     =   "Limpiar"
               Object.ToolTipText     =   "Limpiar Datos"
               ImageIndex      =   1
            EndProperty
            BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Key             =   "Grabar"
               Description     =   "Grabar"
               Object.ToolTipText     =   "Grabar"
               ImageIndex      =   2
            EndProperty
            BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Key             =   "Eliminar"
               Description     =   "Eliminar"
               Object.ToolTipText     =   "Elimina"
               ImageIndex      =   3
            EndProperty
            BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Key             =   "Salir"
               Description     =   "Salir"
               Object.ToolTipText     =   "Salir"
               ImageIndex      =   4
            EndProperty
         EndProperty
      End
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   4800
         Top             =   120
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   22
         ImageHeight     =   22
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   4
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacOmadelSuda.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacOmadelSuda.frx":031C
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacOmadelSuda.frx":0770
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacOmadelSuda.frx":0A8C
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
End
Attribute VB_Name = "BacOmadelSuda"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub BuscaCodigo()
        Dim Datos
        Dim nCual As Integer
        
        If Txt_Codigo.Text = "" Then
           MsgBox "No Ha Ingresado Código", vbOKOnly, TITSISTEMA
           Exit Sub
           
        Else
        
            Envia = Array()
            AddParam Envia, Val(Txt_Codigo.Text)
            
            If Not Bac_Sql_Execute("SP_TRAE_OMADELSUDA", Envia) Then
                MsgBox "Problemas Porcedimiento", vbCritical, TITSISTEMA
                Exit Sub
            End If
            
            If Bac_SQL_Fetch(Datos) Then
               
                    Txt_Glosa.Text = Datos(1)
                    CodigoComercio.Text = Datos(4)
                    Glosa.Text = Datos(5)
                    
                    Call bacBuscarCombo(Cmb_TipOpe, Datos(2))
                    nCual = Datos(3)
                    
                   ' If Left(Cmb_TipOpe, 1) = "V" Then
                   '    nCual = nCual - 5
                   ' ElseIf Left(Cmb_TipOpe, 1) = "" Then
                   '    nCual = 0
                   ' End If
                    If Cmb_TipOpe.ListIndex = 1 Then
                       Cmb_TipoOma.Clear
                       Cmb_TipoOma.AddItem " 1 Comercio Invisble no Financiero": Cmb_TipoOma.ItemData(Cmb_TipoOma.NewIndex) = 1
                       Cmb_TipoOma.AddItem " 2 Interbancario": Cmb_TipoOma.ItemData(Cmb_TipoOma.NewIndex) = 2
                       Cmb_TipoOma.AddItem " 3 Retornos de Exportación": Cmb_TipoOma.ItemData(Cmb_TipoOma.NewIndex) = 3
                       Cmb_TipoOma.AddItem " 4 Comercio Invisble Financiero": Cmb_TipoOma.ItemData(Cmb_TipoOma.NewIndex) = 4
                       Cmb_TipoOma.AddItem " 5 Banco Central": Cmb_TipoOma.ItemData(Cmb_TipoOma.NewIndex) = 5
                       Cmb_TipoOma.AddItem " 0 No Aplica": Cmb_TipoOma.ItemData(Cmb_TipoOma.NewIndex) = 0
                    Else
                       Cmb_TipoOma.Clear
                       Cmb_TipoOma.AddItem " 6 Comercio Invisble no Financiero": Cmb_TipoOma.ItemData(Cmb_TipoOma.NewIndex) = 6
                       Cmb_TipoOma.AddItem " 7 Interbancario": Cmb_TipoOma.ItemData(Cmb_TipoOma.NewIndex) = 7
                       Cmb_TipoOma.AddItem " 8 Retornos de Exportación": Cmb_TipoOma.ItemData(Cmb_TipoOma.NewIndex) = 8
                       Cmb_TipoOma.AddItem " 9 Comercio Invisble Financiero": Cmb_TipoOma.ItemData(Cmb_TipoOma.NewIndex) = 9
                       Cmb_TipoOma.AddItem "10 Banco Central": Cmb_TipoOma.ItemData(Cmb_TipoOma.NewIndex) = 10
                       Cmb_TipoOma.AddItem " 0 No Aplica": Cmb_TipoOma.ItemData(Cmb_TipoOma.NewIndex) = 0
                    End If
                    
                    Call bacBuscarCombo(Cmb_TipoOma, nCual)
                              
            End If
            
            Txt_Glosa.Enabled = True
            Cmb_TipOpe.Enabled = True
            Cmb_TipoOma.Enabled = True
            CodigoComercio.Enabled = True
            Glosa.Enabled = True
            
        End If

End Sub

Private Sub Borrar()

        If Txt_Codigo.Text = "" Then
           MsgBox "No Ha Ingresado Código", vbOKOnly, TITSISTEMA
           Exit Sub
           
        End If
                
        Envia = Array()
        AddParam Envia, Txt_Codigo.Text
        
        If Not Bac_Sql_Execute("SP_BORRA_OMADELSUDA", Envia) Then
            MsgBox "Problemas Porcedimiento", vbCritical, TITSISTEMA
            Exit Sub
        End If

        MsgBox "Se Ha Borrado el Registro", vbOKOnly, TITSISTEMA
        
End Sub
Private Sub Grabar()
        Dim nCual  As Integer
        
        If Txt_Codigo.Text = "" Then
           MsgBox "No Ha Ingresado Código", vbOKOnly, TITSISTEMA
           Exit Sub
           
        End If
                
        nCual = Cmb_TipoOma.ListIndex + 1
        
        If nCual <> 6 Then
           If Left(Cmb_TipOpe, 1) = "V" Then
              nCual = nCual + 5
           ElseIf Left(Cmb_TipOpe, 1) = "" Then
                  nCual = 0
               End If
        Else
            nCual = 0
        End If
        Envia = Array()
        AddParam Envia, Txt_Codigo.Text
        AddParam Envia, Txt_Glosa.Text
        AddParam Envia, Left(Cmb_TipOpe, 1)
        AddParam Envia, nCual
        AddParam Envia, CodigoComercio.Text
                
        If Not Bac_Sql_Execute("SP_GRABA_OMADELSUDA", Envia) Then
            MsgBox "Problemas Porcedimiento", vbCritical, TITSISTEMA
            Exit Sub
        End If

        MsgBox "Se Ha Grabado el Registro ", vbOKOnly, TITSISTEMA
        
End Sub

Private Sub Limpiar()

        Cmb_TipOpe.Clear
        Cmb_TipOpe.AddItem "": Cmb_TipOpe.ItemData(Cmb_TipOpe.NewIndex) = 0
        Cmb_TipOpe.AddItem "Compra": Cmb_TipOpe.ItemData(Cmb_TipOpe.NewIndex) = 1
        Cmb_TipOpe.AddItem "Venta": Cmb_TipOpe.ItemData(Cmb_TipOpe.NewIndex) = 2


        Txt_Codigo.Text = ""
        Txt_Glosa.Text = ""
        CodigoComercio.Tag = ""
        CodigoComercio.Text = ""
        Glosa.Text = ""
        
        Cmb_TipoOma.Clear
        'Cmb_TipoOma.AddItem "Comercio Invisble no Financiero": Cmb_TipoOma.ItemData(Cmb_TipoOma.NewIndex) = 1
        'Cmb_TipoOma.AddItem "Interbancario": Cmb_TipoOma.ItemData(Cmb_TipoOma.NewIndex) = 2
        'Cmb_TipoOma.AddItem "Retornos de Exportación": Cmb_TipoOma.ItemData(Cmb_TipoOma.NewIndex) = 3
        'Cmb_TipoOma.AddItem "Comercio Invisble Financiero": Cmb_TipoOma.ItemData(Cmb_TipoOma.NewIndex) = 4
        'Cmb_TipoOma.AddItem "Banco Central": Cmb_TipoOma.ItemData(Cmb_TipoOma.NewIndex) = 4
        'Cmb_TipoOma.AddItem "No Aplica": Cmb_TipoOma.ItemData(Cmb_TipoOma.NewIndex) = 5

        Txt_Glosa.Enabled = False
        Cmb_TipOpe.Enabled = False
        Cmb_TipoOma.Enabled = False
        CodigoComercio.Enabled = False
        Glosa.Enabled = False
        
End Sub











Private Sub Cmb_TipoOma_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then
      KeyAscii = 0
      SendKeys "{TAB}"
   End If
End Sub

Private Sub Cmb_TipOpe_Change()
      If Cmb_TipOpe.ListIndex = 1 Then
        Cmb_TipoOma.Clear
        Cmb_TipoOma.AddItem " 1 Comercio Invisble no Financiero": Cmb_TipoOma.ItemData(Cmb_TipoOma.NewIndex) = 1
        Cmb_TipoOma.AddItem " 2 Interbancario": Cmb_TipoOma.ItemData(Cmb_TipoOma.NewIndex) = 2
        Cmb_TipoOma.AddItem " 3 Retornos de Exportación": Cmb_TipoOma.ItemData(Cmb_TipoOma.NewIndex) = 3
        Cmb_TipoOma.AddItem " 4 Comercio Invisble Financiero": Cmb_TipoOma.ItemData(Cmb_TipoOma.NewIndex) = 4
        Cmb_TipoOma.AddItem " 5 Banco Central": Cmb_TipoOma.ItemData(Cmb_TipoOma.NewIndex) = 5
        Cmb_TipoOma.AddItem " 0 No Aplica": Cmb_TipoOma.ItemData(Cmb_TipoOma.NewIndex) = 0
      Else
        Cmb_TipoOma.Clear
        Cmb_TipoOma.AddItem " 6 Comercio Invisble no Financiero": Cmb_TipoOma.ItemData(Cmb_TipoOma.NewIndex) = 6
        Cmb_TipoOma.AddItem " 7 Interbancario": Cmb_TipoOma.ItemData(Cmb_TipoOma.NewIndex) = 7
        Cmb_TipoOma.AddItem " 8 Retornos de Exportación": Cmb_TipoOma.ItemData(Cmb_TipoOma.NewIndex) = 8
        Cmb_TipoOma.AddItem " 9 Comercio Invisble Financiero": Cmb_TipoOma.ItemData(Cmb_TipoOma.NewIndex) = 9
        Cmb_TipoOma.AddItem "10 Banco Central": Cmb_TipoOma.ItemData(Cmb_TipoOma.NewIndex) = 10
        Cmb_TipoOma.AddItem " 0 No Aplica": Cmb_TipoOma.ItemData(Cmb_TipoOma.NewIndex) = 0
      End If

End Sub

Private Sub Cmb_TipOpe_Click()
      If Cmb_TipOpe.ListIndex = 1 Then
        Cmb_TipoOma.Clear
        Cmb_TipoOma.AddItem " 1 Comercio Invisble no Financiero": Cmb_TipoOma.ItemData(Cmb_TipoOma.NewIndex) = 1
        Cmb_TipoOma.AddItem " 2 Interbancario": Cmb_TipoOma.ItemData(Cmb_TipoOma.NewIndex) = 2
        Cmb_TipoOma.AddItem " 3 Retornos de Exportación": Cmb_TipoOma.ItemData(Cmb_TipoOma.NewIndex) = 3
        Cmb_TipoOma.AddItem " 4 Comercio Invisble Financiero": Cmb_TipoOma.ItemData(Cmb_TipoOma.NewIndex) = 4
        Cmb_TipoOma.AddItem " 5 Banco Central": Cmb_TipoOma.ItemData(Cmb_TipoOma.NewIndex) = 5
        Cmb_TipoOma.AddItem " 0 No Aplica": Cmb_TipoOma.ItemData(Cmb_TipoOma.NewIndex) = 0
      Else
        Cmb_TipoOma.Clear
        Cmb_TipoOma.AddItem " 6 Comercio Invisble no Financiero": Cmb_TipoOma.ItemData(Cmb_TipoOma.NewIndex) = 6
        Cmb_TipoOma.AddItem " 7 Interbancario": Cmb_TipoOma.ItemData(Cmb_TipoOma.NewIndex) = 7
        Cmb_TipoOma.AddItem " 8 Retornos de Exportación": Cmb_TipoOma.ItemData(Cmb_TipoOma.NewIndex) = 8
        Cmb_TipoOma.AddItem " 9 Comercio Invisble Financiero": Cmb_TipoOma.ItemData(Cmb_TipoOma.NewIndex) = 9
        Cmb_TipoOma.AddItem "10 Banco Central": Cmb_TipoOma.ItemData(Cmb_TipoOma.NewIndex) = 10
        Cmb_TipoOma.AddItem " 0 No Aplica": Cmb_TipoOma.ItemData(Cmb_TipoOma.NewIndex) = 0
      End If

End Sub

Private Sub Cmb_TipOpe_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then
      If Cmb_TipOpe.ListIndex = 1 Then
        Cmb_TipoOma.Clear
        Cmb_TipoOma.AddItem " 1 Comercio Invisble no Financiero": Cmb_TipoOma.ItemData(Cmb_TipoOma.NewIndex) = 1
        Cmb_TipoOma.AddItem " 2 Interbancario": Cmb_TipoOma.ItemData(Cmb_TipoOma.NewIndex) = 2
        Cmb_TipoOma.AddItem " 3 Retornos de Exportación": Cmb_TipoOma.ItemData(Cmb_TipoOma.NewIndex) = 3
        Cmb_TipoOma.AddItem " 4 Comercio Invisble Financiero": Cmb_TipoOma.ItemData(Cmb_TipoOma.NewIndex) = 4
        Cmb_TipoOma.AddItem " 5 Banco Central": Cmb_TipoOma.ItemData(Cmb_TipoOma.NewIndex) = 5
        Cmb_TipoOma.AddItem " 0 No Aplica": Cmb_TipoOma.ItemData(Cmb_TipoOma.NewIndex) = 0
      Else
        Cmb_TipoOma.Clear
        Cmb_TipoOma.AddItem " 6 Comercio Invisble no Financiero": Cmb_TipoOma.ItemData(Cmb_TipoOma.NewIndex) = 6
        Cmb_TipoOma.AddItem " 7 Interbancario": Cmb_TipoOma.ItemData(Cmb_TipoOma.NewIndex) = 7
        Cmb_TipoOma.AddItem " 8 Retornos de Exportación": Cmb_TipoOma.ItemData(Cmb_TipoOma.NewIndex) = 8
        Cmb_TipoOma.AddItem " 9 Comercio Invisble Financiero": Cmb_TipoOma.ItemData(Cmb_TipoOma.NewIndex) = 9
        Cmb_TipoOma.AddItem "10 Banco Central": Cmb_TipoOma.ItemData(Cmb_TipoOma.NewIndex) = 10
        Cmb_TipoOma.AddItem " 0 No Aplica": Cmb_TipoOma.ItemData(Cmb_TipoOma.NewIndex) = 0
      End If
      KeyAscii = 0
      SendKeys "{TAB}"
   End If
End Sub

Private Sub CodigoComercio_Change()
   If CodigoComercio.Tag <> "" Then
      CodigoComercio.Text = CodigoComercio.Tag
   End If
End Sub

Private Sub CodigoComercio_DblClick()
    BacControlWindows 100
    BacAyuda.Tag = "TBCODIGOSCOMERCIO"
    BacAyuda.Show 1
    
    If giAceptar% = True Then
    
       'Call ActivaBotones(True)
        CodigoComercio.Tag = gsCodigo$
        CodigoComercio.Text = gsCodigo$
        'txtConcepto.Text = gsDigito$
        Glosa.Text = gsGlosa$

    End If

End Sub

Private Sub CodigoComercio_GotFocus()
   If CodigoComercio.Tag <> "" Then
   CodigoComercio.Text = CodigoComercio.Tag
   End If
End Sub

Private Sub CodigoComercio_KeyPress(KeyAscii As Integer)
   Call CodigoComercio_DblClick
   CodigoComercio.Text = CodigoComercio.Tag
End Sub

Private Sub Form_Load()
        Call Limpiar
        
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

        Select Case Button.Index
            
                Case 1
                     Call Limpiar
                
                Case 2
                     Call Grabar
                     Call Limpiar
                
                Case 3
                    Call Borrar
                    Call Limpiar
                    
                Case 4
                    Unload Me
                    
        End Select
        
End Sub

Private Sub Txt_Codigo_DblClick()
        BacAyuda.Tag = "TB_CODIGOSOMADELCORP"
        BacAyuda.Show vbModal
        
        If giAceptar% = True Then
           Txt_Codigo.Text = gsCodigo$
           Call BuscaCodigo
        End If
        
End Sub

Private Sub Txt_Codigo_KeyPress(KeyAscii As Integer)

        If Not IsNumeric(KeyAscii) And KeyAscii <> 13 Then
           KeyAscii = 0
        End If

        If KeyAscii = 13 Then
           KeyAscii = 0
        
           Call BuscaCodigo
           SendKeys "{TAB}"
        
        End If

End Sub

Private Sub Txt_glosa_KeyPress(KeyAscii As Integer)
   BacToUCase KeyAscii
   If KeyAscii = 13 Then
      KeyAscii = 0
      SendKeys "{TAB}"
   End If
End Sub
'Function Carga_Codigo_Comercio(xcombo As ComboBox, Valor As String)
'Dim Datos()
'
'   With xcombo
'         xcombo.Clear
'
'         If Not Bac_Sql_Execute("SP_CARGA_OMA_CORP '" & Valor & "'") Then
'            MsgBox "Problemas en la Carga de codigo OMA"
'         End If
'
'         Do While Bac_SQL_Fetch(Datos())
'            xcombo.AddItem Right$("   " + Datos(1), 3) & Space(1) & Datos(2) & Space(100) & Datos(4)
'            xcombo.ItemData(xcombo.NewIndex) = Datos(1)
'         Loop
'
'   End With
'
'End Function
