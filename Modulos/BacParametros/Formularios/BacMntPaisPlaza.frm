VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{BDC217C8-ED16-11CD-956C-0000C04E4C0A}#1.1#0"; "TABCTL32.OCX"
Begin VB.Form BacMntPaisPlaza 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Corresponsales"
   ClientHeight    =   3885
   ClientLeft      =   1545
   ClientTop       =   1290
   ClientWidth     =   6735
   Icon            =   "BacMntPaisPlaza.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   3885
   ScaleWidth      =   6735
   Begin VB.Frame Frame1 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000D&
      Height          =   3210
      Left            =   0
      TabIndex        =   6
      Top             =   480
      Width           =   6735
      Begin TabDlg.SSTab SSTab1 
         Height          =   2655
         Left            =   345
         TabIndex        =   0
         Top             =   360
         Width           =   6090
         _ExtentX        =   10742
         _ExtentY        =   4683
         _Version        =   393216
         Style           =   1
         Tabs            =   2
         TabsPerRow      =   2
         TabHeight       =   520
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
         TabCaption(0)   =   "Pais"
         TabPicture(0)   =   "BacMntPaisPlaza.frx":030A
         Tab(0).ControlEnabled=   -1  'True
         Tab(0).Control(0)=   "Label1"
         Tab(0).Control(0).Enabled=   0   'False
         Tab(0).Control(1)=   "Label2"
         Tab(0).Control(1).Enabled=   0   'False
         Tab(0).Control(2)=   "txtdescri"
         Tab(0).Control(2).Enabled=   0   'False
         Tab(0).Control(3)=   "txtcodpais"
         Tab(0).Control(3).Enabled=   0   'False
         Tab(0).ControlCount=   4
         TabCaption(1)   =   "Plaza"
         TabPicture(1)   =   "BacMntPaisPlaza.frx":0326
         Tab(1).ControlEnabled=   0   'False
         Tab(1).Control(0)=   "cmb_plaza"
         Tab(1).Control(1)=   "txtdescri1"
         Tab(1).Control(2)=   "Txtglosa1"
         Tab(1).Control(3)=   "Label6"
         Tab(1).Control(4)=   "Label4"
         Tab(1).Control(5)=   "Label3"
         Tab(1).ControlCount=   6
         Begin VB.TextBox txtcodpais 
            BackColor       =   &H80000009&
            DragIcon        =   "BacMntPaisPlaza.frx":0342
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
            Left            =   240
            MaxLength       =   5
            MouseIcon       =   "BacMntPaisPlaza.frx":064C
            MousePointer    =   99  'Custom
            TabIndex        =   1
            Top             =   840
            Width           =   975
         End
         Begin VB.ComboBox cmb_plaza 
            BackColor       =   &H80000009&
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
            Left            =   -74760
            Style           =   2  'Dropdown List
            TabIndex        =   3
            Top             =   810
            Width           =   1095
         End
         Begin VB.TextBox txtdescri1 
            BackColor       =   &H80000009&
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
            Left            =   -74760
            MaxLength       =   50
            TabIndex        =   5
            Top             =   1800
            Width           =   5535
         End
         Begin VB.TextBox Txtglosa1 
            BackColor       =   &H80000009&
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
            Left            =   -72750
            MaxLength       =   10
            TabIndex        =   4
            Top             =   855
            Width           =   1485
         End
         Begin VB.TextBox txtdescri 
            BackColor       =   &H80000009&
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
            Left            =   240
            MaxLength       =   50
            TabIndex        =   2
            Top             =   1800
            Width           =   5535
         End
         Begin VB.Label Label6 
            Caption         =   "Glosa"
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
            Left            =   -72750
            TabIndex        =   11
            Top             =   540
            Width           =   870
         End
         Begin VB.Label Label4 
            Caption         =   "Descripcion"
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
            Left            =   -74760
            TabIndex        =   10
            Top             =   1440
            Width           =   1140
         End
         Begin VB.Label Label3 
            Caption         =   "Codigo"
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
            Left            =   -74760
            TabIndex        =   9
            Top             =   480
            Width           =   1410
         End
         Begin VB.Label Label2 
            Caption         =   "Descripcion"
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
            Left            =   240
            TabIndex        =   8
            Top             =   1440
            Width           =   1590
         End
         Begin VB.Label Label1 
            Caption         =   "Codigo"
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
            Height          =   240
            Left            =   240
            TabIndex        =   7
            Top             =   480
            Width           =   1500
         End
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   12
      Top             =   0
      Width           =   6735
      _ExtentX        =   11880
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Guardar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Eliminar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limjpiar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   4
            BeginProperty ButtonMenus {66833FEC-8583-11D1-B16A-00C0F0283628} 
               NumButtonMenus  =   1
               BeginProperty ButtonMenu1 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
            EndProperty
         EndProperty
      EndProperty
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   4680
         Top             =   0
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
               Picture         =   "BacMntPaisPlaza.frx":0956
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntPaisPlaza.frx":0DA8
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntPaisPlaza.frx":11FA
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntPaisPlaza.frx":1514
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
End
Attribute VB_Name = "BacMntPaisPlaza"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public SWPLA, SWTAB, SWVERIPA, SWVERIPL, swpais, swlimp, noexis, siexis, swnotiene, num2, SW2, Suma, num





Function buscarpais()
  txtdescri.BackColor = &H80000009
  
  swpais = 1
  SSTab1.TabEnabled(1) = True
 
  Dim datos()
  
  
  Dim Sw As Integer
  Dim Sql As String
  Dim var1 As Long
   
   
   var1 = TxtCodPais.Text

   Envia = Array()
   AddParam Envia, var1
  
 
    Sw = 0
      
   If Bac_Sql_Execute("sp_mntpaisplaza_buscarpais ", Envia) And Sw Then
     If Bac_SQL_Fetch(datos()) Then
        Sw = 1
        
         txtdescri.Text = datos(2)
         pais_busca = datos(2)
         
         
     End If
   End If
  
 
 
 If Sw = 0 Then
  noexis = 1
  SSTab1.TabEnabled(1) = False
   txtdescri.MaxLength = 50
   txtdescri.Enabled = True
   txtdescri.SetFocus
   

   Toolbar1.Buttons(2).Enabled = False
  
   txtdescri.Text = ""
     
  End If
  If Sw = 1 Then
  siexis = 1
   txtdescri.Enabled = False
   Toolbar1.Buttons(2).Enabled = True
  
      
  End If
   



End Function

Function grabarPAIS()
   
    Dim Sw As Integer
    Dim VAR3
    
    Dim datos()
    Dim Y As Integer
    
           VAR3 = txtdescri.Text
                   
            Envia = Array()
            AddParam Envia, TxtCodPais
            AddParam Envia, VAR3
            
            If Bac_Sql_Execute("SP_MNTPAISPLAZA_GRABARPAIS  ", Envia) Then
                If Bac_SQL_Fetch(datos()) Then
                    Select Case datos(1)
                        Case Is = "ok"
                        Sw = 1
                    End Select
                End If
            Else
            
                TxtCodPais.SetFocus
            End If
       
        If Sw = 1 Then
            Toolbar1.Buttons(1).Enabled = False
                MsgBox "La información ha sido Grabada", vbInformation + vbOKOnly, TITSISTEMA
                Call Form_Load
                If SWPLA = 0 Then
                   SSTab1.TabEnabled(1) = True
                End If
                txtdescri.BackColor = &H8000000E
                txtdescri.ForeColor = &H80000008
                TxtCodPais.Enabled = True
                TxtCodPais.SetFocus
           
        End If
    
End Function

Private Sub cmb_pais_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = 13 And cmb_pais <> "" Then
       
End If
End Sub


Private Sub txtcodpais_DblClick()
Call llamarayuda

End Sub

Private Sub txtcodpais_GotFocus()
noexis = 0: siexis = 0: swnotiene = 0
TxtCodPais.BackColor = &H80000002
TxtCodPais.ForeColor = &H80000009

End Sub

Private Sub txtcodpais_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = 13 And TxtCodPais <> "" Then
   Toolbar1.Buttons(3).Enabled = True
   Call buscarpais
   
   
End If


If KeyCode = 46 And Toolbar1.Buttons(2).Enabled = True Then
   Call ELIMINAR_PAIS
End If
If KeyCode = vbKeyF2 And Toolbar1.Buttons(3).Enabled = True Then
   Call pais
End If
If KeyCode = 27 Then
 Unload Me
End If
End Sub

Private Sub txtcodpais_KeyPress(KeyAscii As Integer)
If Not IsNumeric(Chr(KeyAscii)) And KeyAscii <> 13 And KeyAscii <> 8 Then
  KeyAscii = 0
End If
End Sub

Private Sub txtcodpais_LostFocus()
TxtCodPais.BackColor = &H80000009
TxtCodPais.ForeColor = &H80000002
SSTab1.ShowFocusRect = True

End Sub

Private Sub cmb_plaza_Click()

If cmb_plaza <> "" Then
 Call Buscar_plaza
End If

'If swpais = 1 And swlimp = 0 And SSTab1.Tab = 1 Then
 ' Call FILTRAR_PLAZASDEPAIS
'End If
End Sub

Private Sub cmb_plaza_KeyDown(KeyCode As Integer, Shift As Integer)
If swpais = 0 Or swlim = 1 And SSTab1.Tab = 1 Then
If KeyCode = 13 And cmb_plaza <> "" Then
   Call Buscar_plaza
End If

If KeyCode = 46 And Toolbar1.Buttons(2).Enabled = True Then
  Call eliminar_plaza
End If
If KeyCode = vbKeyF2 And Toolbar1.Buttons(3).Enabled = True Then
  Call PLAZAS
End If
End If


If KeyCode = 27 Then
 Unload Me
End If
End Sub

Private Sub cmb_plaza_LostFocus()
SSTab1.ShowFocusRect = True

End Sub

Private Sub Form_Load()
    Me.Top = 0
    Me.Left = 0
SWVERIPA = 0
SWVERIPL = 0
SWPLA = 0
swpais = 0
swlimp = 0
noexis = 0
siexis = 0
swnotiene = 0
SSTab1.TabEnabled(1) = False

Call pais

Call PLAZAS
SSTab1.TabEnabled(1) = False

End Sub



Private Sub SSTab1_Click(PreviousTab As Integer)
   If SSTab1.Tab = 0 Then
        swpais = 1
        swlimp = 0
        If Sw = 0 And swlimp = 1 Then
        Call pais
        End If
        TxtCodPais.Enabled = True
        TxtCodPais.SetFocus
        SWTAB = 0
        
   End If
  If SSTab1.Tab = 1 And SWPLA = 0 Then
       
       If swpais = 0 Or swlimp = 1 Then
       Call PLAZAS
       cmb_plaza.Enabled = True
       cmb_plaza.SetFocus
       End If
       
       If swpais = 1 Then
         swmensaj = 0
        If noexis = 1 Then
           
           SSTab1.TabEnabled(1) = False
        End If
        If siexis = 1 Then
       
        
        Call FILTRAR_PLAZASDEPAIS
             
       
       
       Call nuevo_limpiar
          If cmb_plaza.ListCount = 0 And swmensaj = 0 Then
              swnotiene = 1
               
              Call nuevo_limpiar
             
             Call llenar_comboplaza
             If SW2 = 1 Then
             Var = Suma
             
             End If
             cmb_plaza.Clear
             cmb_plaza.AddItem Var
            
              cmb_plaza.SetFocus
           
           
          End If
          
       End If
       
       End If
       
       SWTAB = 1
       
  End If
  
End Sub

Private Sub SSTab1_GotFocus()
If SSTab1.ShowFocusRect = False Then
   TxtCodPais.SetFocus
End If

End Sub

Private Sub SSTab1_KeyDown(KeyCode As Integer, Shift As Integer)
If SSTab1.Tab = 0 Then
  If KeyCode = 45 And Toolbar1.Buttons(1).Enabled = True Then
           Call grabarPAIS
   End If
End If
If SSTab1.Tab = 1 Then
 If swpais = 0 Or swlimp = 1 Then
 If KeyCode = vbKeyG And Toolbar1.Buttons(1).Enabled = True Then
           Call grabarplaza
  End If
 End If
End If
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Dim i As Integer
   Dim var1 As String
   Dim Sw As Integer
   Dim VAR2 As Integer
   Dim datos()
   
   Select Case Button.Index
       Case 1
           If SWTAB = 0 Then
             Call grabarPAIS
           End If
           If SWTAB = 1 Then
              Call grabarplaza
           End If
       Case 2
           If SWTAB = 0 Then
             Call ELIMINAR_PAIS
           End If
           If SWTAB = 1 Then
              Call eliminar_plaza
           End If
               
       Case 3
       Call Form_Load

       swlimp = 1
'           If SWTAB = 0 Then
'             Call pais
'             txtcodpais.SetFocus
'           End If
'           If SWTAB = 1 Then
'              Call PLAZAS
'              Call Form_Load
'              cmb_plaza.SetFocus
'           End If
         Case 4
        
           Unload Me
      End Select
 
      
End Sub

Private Sub Txtcodigo1_GotFocus()
txtCodigo1.BackColor = &H8000000D
txtCodigo1.ForeColor = &H8000000E
End Sub


Private Sub txtCodigo1_LostFocus()
txtCodigo1.BackColor = &H8000000E
txtCodigo1.ForeColor = &H80000008
End Sub


Private Sub txtdescri_GotFocus()
txtdescri.BackColor = &H8000000D
txtdescri.ForeColor = &H8000000E
End Sub

Private Sub txtdescri_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = 13 And txtdescri.Text <> "" And TxtCodPais <> "" Then
       
      Call veridescripais
       
End If
If KeyCode = VBF2 And Toolbar1.Buttons(3).Enabled = True Then
  Call Form_Load
End If
End Sub

Private Sub txtdescri_KeyPress(KeyAscii As Integer)

KeyAscii = Asc(UCase(Chr(KeyAscii)))



End Sub

Private Sub txtdescri_LostFocus()

txtdescri.BackColor = &H8000000E
txtdescri.ForeColor = &H80000008
End Sub

Private Sub txtdescri1_GotFocus()
txtdescri1.BackColor = &H8000000D
txtdescri1.ForeColor = &H8000000E
End Sub

Private Sub txtdescri1_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = 13 And txtdescri1.Text <> "" Then
      Call veridescriplaza
End If
End Sub

Private Sub txtdescri1_KeyPress(KeyAscii As Integer)
 KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub

Private Sub txtdescri1_LostFocus()
txtdescri1.BackColor = &H8000000E
txtdescri1.ForeColor = &H80000008
End Sub

Private Sub Txtglosa1_GotFocus()
 Txtglosa1.BackColor = &H8000000D
 Txtglosa1.ForeColor = &H8000000E
End Sub


Private Sub Txtglosa1_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = 13 And Txtglosa1.Text <> "" Then
      Call Veriglosaplaza
End If
End Sub


Private Sub Txtglosa1_KeyPress(KeyAscii As Integer)
 KeyAscii = Asc(UCase(Chr(KeyAscii)))
  


End Sub

Private Sub Txtglosa1_LostFocus()
Txtglosa1.BackColor = &H8000000E
Txtglosa1.ForeColor = &H80000008
End Sub


Function ELIMINAR_PAIS()
Dim datos(), datos1()
Dim e As Integer
Dim Sql As String
e = MsgBox("¿Seguro De Eliminar Pais?", vbYesNo + vbQuestion, TITSISTEMA)
If e = 6 Then
   Call VERIFICAR_ENUSOPAIS
  If SWVERIPA = 0 Then
  
              Dim cmbPais As Long
               cmbPais = TxtCodPais
  Envia = Array()
  AddParam Envia, cmbPais
  
        
              If Not Bac_Sql_Execute("SP_MNTPAISPLAZA_ELIMINARPLAZASPAIS ", Envia) Then
               MsgBox "PROBLEMAS EN sql", vbCritical, TITSISTEMA
              Else
               
                    Do While Bac_SQL_Fetch(datos())
                       Select Case datos(1)
                          
                           Case "OK"
                             MsgBox "Eliminadas las Plazas del Pais ", vbInformation, TITSISTEMA
                           Case "NO EXISTE"
                             MsgBox "No Existen Plazas del pais a Eliminar", vbExclamation, TITSISTEMA
                             TxtCodPais.SetFocus
                        End Select
                    
'                      MsgBox "Error", vbCritical, "Bac-Parametros"
                    Loop
                 
              End If
                 
               Envia = Array()
               AddParam Envia, cmbPais
               
               Dim SWP As Integer
                  If Not Bac_Sql_Execute("SP_MNTPAISPLAZA_ELIMINARPAIS ", Envia) Then
                         MsgBox "PROBLEMAS EN sql", vbCritical, TITSISTEMA
                  Else
                  SWP = 0
                      Do While Bac_SQL_Fetch(datos1())
                            Select Case datos1(1)
                          
                             Case "OK"
                               MsgBox "Pais Eliminado", vbInformation, TITSISTEMA
                               SWP = 1
                             Case "NO EXISTE"
                               MsgBox "Pais no Existe  ", vbExclamation, TITSISTEMA
                               TxtCodPais.SetFocus
                           End Select

                     '     MsgBox "Error", vbCritical, "Bac-Parametros"
                       Loop
                  End If
             
      If SWP = 1 Then
         
         Call pais
         
      End If
    Else
        MsgBox "Pais en Uso,Imposible Eliminar", vbCritical, TITSISTEMA
        Call pais
        
    End If
 Else
    TxtCodPais.SetFocus
    Toolbar1.Buttons(2).Enabled = False
    Toolbar1.Buttons(3).Enabled = True
 End If


 
End Function

Function veridescripais()
  
  Dim datos()
  
  
  Dim Sw As Integer
  Dim Sql As String
  Dim vare As String
   vare = txtdescri.Text
   Envia = Array()
   AddParam Envia, vare
   
   
   Sw = 0
      
   If Bac_Sql_Execute(" sp_mntpaisplaza_Veridescripais ", Envia) And Sw = 0 Then
        If Bac_SQL_Fetch(datos()) Then
           Sw = 1
        End If
       
   End If
  
 
 
 If Sw = 1 Then
   MsgBox "La Descripcion De PAis Ya Existe ", vbExclamation, TITSISTEMA
   txtdescri.MaxLength = 50
   txtdescri.Enabled = True
   txtdescri.SetFocus
   Toolbar1.Buttons(1).Enabled = False
 Else
 
     Toolbar1.Buttons(1).Enabled = True
       Toolbar1.Buttons(2).Enabled = False
       Toolbar1.Buttons(3).Enabled = True
       TxtCodPais.Enabled = False
       txtdescri.Enabled = False
 End If
  
   
'If KeyCode = 46 Then
 ' Toolbar1.Buttons(2).Enabled = True
  'Call Eliminar
 'End If
  
End Function
Function PLAZAS()

Toolbar1.Buttons(1).Enabled = False
Toolbar1.Buttons(2).Enabled = False
Toolbar1.Buttons(3).Enabled = False
cmb_plaza.Enabled = True
Txtglosa1.Text = ""
Txtglosa1.MaxLength = 10
Txtglosa1.Enabled = False
txtdescri1.Enabled = False
txtdescri1.Text = ""
txtdescri1.MaxLength = 50



     Call LLENAR_COMBOPAIS_PLAZA
          
     Call llenar_comboplaza
 


End Function
Function Buscar_plaza()
 
  Dim datos()
  
  
  Dim Sw As Integer
  Dim Sql As String
  Dim var1 As Long
   var1 = cmb_plaza
   Envia = Array()
   AddParam Envia, var1
   
   
   Sw = 0
      
   If Bac_Sql_Execute("sp_mntpaisplaza_buscarplaza", Envia) And Sw = 0 Then
     If Bac_SQL_Fetch(datos()) Then
        Sw = 1
         Txtglosa1.Text = datos(2)
         txtdescri1.Text = datos(3)
      '   cmb_pais.Text = datos(5)
         
     End If
  End If
  
 
 
 If Sw = 0 Then
   txtdescri1.Text = ""
   txtdescri1.MaxLength = 50
   Call LLENAR_COMBOPAIS_PLAZA
   Txtglosa1.Text = ""
   Txtglosa1.MaxLength = 10
   Txtglosa1.Enabled = True
   Txtglosa1.SetFocus
   
   
   Toolbar1.Buttons(2).Enabled = False
   Toolbar1.Buttons(3).Enabled = False
   
     
  End If
  If Sw = 1 Then
   Txtglosa1.Enabled = False
   txtdescri1.Enabled = False
  
   Toolbar1.Buttons(2).Enabled = True
   Toolbar1.Buttons(3).Enabled = True
      
  End If
   
'If KeyCode = 46 Then
 ' Toolbar1.Buttons(2).Enabled = True
  'Call Eliminar
'End If



End Function
Function veridescriplaza()
 Dim datos()
  
  
  Dim Sw As Integer
  Dim Sql As String
  Dim vare As String
   vare = txtdescri1.Text
   Envia = Array()
   AddParam Envia, vare
    
   
   Sw = 0
      
   If Bac_Sql_Execute("sp_mntpaisplaza_Veridescriplaza", Envia) And Sw = 0 Then
        If Bac_SQL_Fetch(datos()) Then
           Sw = 1
        End If
       
   End If
  
 
 
 If Sw = 1 Then
   MsgBox "La Descripcion De Plaza Ya Existe ", vbExclamation, TITSISTEMA
   txtdescri1.MaxLength = 50
   txtdescri1.Enabled = True
   txtdescri1.SetFocus
   'Toolbar1.Buttons(1).Enabled = False
 Else
 
     'Toolbar1.Buttons(1).Enabled = True
     '  Toolbar1.Buttons(2).Enabled = False
     '  Toolbar1.Buttons(3).Enabled = True
       
      Toolbar1.Buttons(1).Enabled = True
       Toolbar1.Buttons(2).Enabled = False
       Toolbar1.Buttons(3).Enabled = True
       cmb_plaza.Enabled = False
       Txtglosa1.Enabled = False
       txtdescri1.Enabled = False
      
          
 End If
  
   
'If KeyCode = 46 Then
 ' Toolbar1.Buttons(2).Enabled = True
  'Call Eliminar
 'End If
End Function

Function pais()
TxtCodPais.Enabled = True
txtdescri.Text = ""
txtdescri.Enabled = False
TxtCodPais.Text = ""

Toolbar1.Buttons(1).Enabled = False
Toolbar1.Buttons(2).Enabled = False
Toolbar1.Buttons(3).Enabled = False
SSTab1.ShowFocusRect = False


'Dim datos()
'
'Dim SW As Integer
'Dim num As Integer
'
'     txtdescri.Text = ""
'     txtdescri.MaxLength = 50
'     txtdescri.Enabled = False
'
'         Sql = "SP_corresponsales_cmbpais"
'       If MISQL.SQL_Execute(Sql) = 0 Then
'              SW = 0
'                txtcodpais.Clear
'
'            Do While MISQL.SQL_Fetch(datos()) = 0
'
'                txtcodpais.AddItem datos(2)
'                 SW = 1
'            Loop
'            If MISQL.SQL_Fetch(datos()) Then
'                 If SW = 1 Then
'                    num = 1
'                    txtcodpais.AddItem datos(2) + num
'                 Else
'                    num = 1
'                        txtcodpais.AddItem num
'                        SWPLA = 1
'                        SSTab1.TabEnabled(1) = False
'
'                 End If
'            End If
'        End If


End Function
Function grabarplaza()
   Dim datos()

    Dim Sw As Integer
    Dim cmbPlaza
    Dim VAR2
    Dim VAR3
    Dim codigopais
    
    
            cmbPlaza = cmb_plaza
            VAR2 = Txtglosa1.Text
            VAR3 = txtdescri1.Text
            codigopais = TxtCodPais
            
            Envia = Array()
            AddParam Envia, cmbPlaza
            AddParam Envia, VAR2
            AddParam Envia, VAR3
            AddParam Envia, codigopais
              
            If Bac_Sql_Execute("SP_MNTPAISPLAZA_GRABARPLAZA ", Envia) Then
                Do While Bac_SQL_Fetch(datos())
                    Select Case datos(1)
                        Case Is = "ok"
                          Sw = 1
                        Case Is = "error"
                          MsgBox "ERROR al intentar Grabar Plaza", vbCritical, TITSISTEMA
                    End Select
                Loop
             End If
        If Sw = 1 Then
                Toolbar1.Buttons(1).Enabled = False
                MsgBox "La información ha sido Grabada", vbInformation + vbOKOnly, TITSISTEMA
                Call PLAZAS
                txtdescri1.BackColor = &H8000000E
                txtdescri1.ForeColor = &H80000008
                cmb_plaza.Enabled = True
                cmb_plaza.SetFocus
                
       End If
    If KeyCode = 46 Then
        'Toolbar1.Buttons(2).Enabled = True
        'Call Eliminar
    End If
End Function

Function eliminar_plaza()
Dim datos1()
Dim e As Integer
Dim Sql As String
e = MsgBox("¿Seguro De Eliminar Plaza?", vbYesNo + vbQuestion, TITSISTEMA)
If e = 6 Then
Call VERIFICAR_ENUSOPLAZA
   If SWVERIPL = 0 Then
               Dim cmbPlaza As Long
               cmbPlaza = cmb_plaza.Text
               Envia = Array()
               AddParam Envia, cmbPlaza
               
               Dim SWP As Integer
                  If Not Bac_Sql_Execute("SP_MNTPAISPLAZA_ELIMINARPlaza ", Envia) Then
                         MsgBox "PROBLEMAS EN sql", vbCritical, TITSISTEMA
                  Else
                  SWP = 0
                      Do While Bac_SQL_Fetch(datos1())
                            Select Case datos1(1)
                          
                             Case "OK"
                               MsgBox "Plaza Eliminada", vbInformation, TITSISTEMA
                               SWP = 1
                             Case "NO EXISTE"
                               MsgBox "Plaza no Existe", vbExclamation, TITSISTEMA
                               cmb_plaza.SetFocus
                           End Select

                     '     MsgBox "Error", vbCritical, "Bac-Parametros"
                       Loop
                  End If
             
      If SWP = 1 Then
         If swpais = 0 And limp = 1 Then
         Call PLAZAS
         Else
           Call nuevo_limpiar
           SSTab1.Tab = 0
           SSTab1.ShowFocusRect = True
           'cmb_plaza.SetFocus
         End If
      End If
    Else
        MsgBox "Plaza en Uso,Imposible Eliminar", vbCritical, TITSISTEMA
        Call PLAZAS
    End If
 Else
    cmb_plaza.SetFocus
    Toolbar1.Buttons(2).Enabled = False
    Toolbar1.Buttons(3).Enabled = True
 End If



End Function
Function Veriglosaplaza()

 Dim datos()
  
  
  Dim Sw As Integer
  Dim Sql As String
  Dim vare As String
   vare = Txtglosa1.Text
   
   Envia = Array()
   AddParam Envia, vare
   
   
   Sw = 0
      
   If Bac_Sql_Execute(" sp_mntpaisplaza_VeriGlosaplaza", Envia) And Sw = 0 Then
        If Bac_SQL_Fetch(datos()) Then
           Sw = 1
        End If
       
   End If
  
 
 
 If Sw = 1 Then
   MsgBox "Glosa Ya Existe ", vbExclamation, TITSISTEMA
   Txtglosa1.MaxLength = 10
   Txtglosa1.Enabled = True
   Txtglosa1.SetFocus
   'Toolbar1.Buttons(1).Enabled = False
 Else
 
     'Toolbar1.Buttons(1).Enabled = True
     '  Toolbar1.Buttons(2).Enabled = False
     '  Toolbar1.Buttons(3).Enabled = True
       txtdescri1.Text = ""
       txtdescri1.MaxLength = 50
       txtdescri1.Enabled = True
       
       txtdescri1.SetFocus
          
 End If
  
   
'If KeyCode = 46 Then
 ' Toolbar1.Buttons(2).Enabled = True
  'Call Eliminar
 'End If
End Function

Function LLENAR_COMBOPAIS_PLAZA()

End Function



Function VERIFICAR_ENUSOPAIS()
 Dim datos()
  
  
  
  Dim Sql As String
  Dim var1 As Long
   var1 = TxtCodPais
   Envia = Array()
   AddParam Envia, var1

   

 
    
      
   If Bac_Sql_Execute("sp_MNTPAISPLAZA_VERIFICAR_ENUSO_PAIS ", Envia) Then
     If Bac_SQL_Fetch(datos()) Then
        
        Select Case datos(1)
             Case "OK"
                SWVERIPA = 1
              Case "NO EXISTE"
                SWVERIPA = 0
        End Select
     End If
  End If
  
End Function



Function VERIFICAR_ENUSOPLAZA()
Dim datos()
  
  
  
  Dim Sql As String
  Dim var1 As Long
   var1 = cmb_plaza

   Envia = Array()
   AddParam Envia, var1
   
    
      
   If Bac_Sql_Execute("sp_MNTPAISPLAZA_VERIFICAR_ENUSO_PLAZA ", Envia) Then
     If Bac_SQL_Fetch(datos()) Then
        
        Select Case datos(1)
             Case "OK"
                SWVERIPL = 1
              Case "NO EXISTE"
                SWVERIPL = 0
        End Select
     End If
  End If
End Function


Function FILTRAR_PLAZASDEPAIS()

var1 = TxtCodPais
Envia = Array()
AddParam Envia, var1



     If Bac_Sql_Execute("SP_mntpaisplaza_filtroplazapais ", Envia) Then
          cmb_plaza.Clear
          Dim filpla
          Do While Bac_SQL_Fetch(datos())
            filpla = datos(1)
            cmb_plaza.AddItem filpla
          Loop
      
    End If

End Function


Function nuevo_limpiar()

cmb_plaza.Enabled = True
Txtglosa1.Text = ""
Txtglosa1.MaxLength = 10
Txtglosa1.Enabled = False
txtdescri1.Enabled = False
txtdescri1.Text = ""
txtdescri1.MaxLength = 50

End Function

Function llenar_comboplaza()
 ' Dim SW2 As Integer
'Dim num2 As Integer
      
     If Bac_Sql_Execute("SP_corresponsales_cmbpLAZA") Then
         SW2 = 0
          cmb_plaza.Clear
          
          Do While Bac_SQL_Fetch(datos())
               cmb_plaza.AddItem datos(1)
               SW2 = 1
          Loop
            If Bac_SQL_Fetch(datos()) Then
                 If SW2 = 1 Then
                    num2 = 1
                    Suma = datos(1) + num2
                 cmb_plaza.AddItem Suma
                 Else
                     num2 = 1
                     cmb_plaza.AddItem num2
                                               
                 End If
            End If

     End If
End Function
Function llamarayuda()

End Function
