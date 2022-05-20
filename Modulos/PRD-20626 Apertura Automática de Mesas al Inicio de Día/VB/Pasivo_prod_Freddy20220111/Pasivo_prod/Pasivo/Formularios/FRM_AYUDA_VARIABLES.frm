VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form FRM_AYUDA_VARIABLES 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Lista De Variables"
   ClientHeight    =   4740
   ClientLeft      =   3525
   ClientTop       =   1350
   ClientWidth     =   3900
   Icon            =   "FRM_AYUDA_VARIABLES.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4740
   ScaleWidth      =   3900
   Begin VB.Frame Frm_ayu_list 
      Height          =   4260
      Left            =   0
      TabIndex        =   0
      Top             =   480
      Width           =   3885
      Begin VB.TextBox Txt_Variable 
         Enabled         =   0   'False
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
         TabIndex        =   2
         Top             =   420
         Width           =   3690
      End
      Begin VB.ListBox Lst_Variables_Formulas 
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   3420
         Left            =   90
         TabIndex        =   1
         Top             =   750
         Width           =   3690
      End
      Begin VB.Label Label1 
         Caption         =   "Buscar"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Left            =   120
         TabIndex        =   3
         Top             =   195
         Width           =   1050
      End
   End
   Begin MSComctlLib.Toolbar Tlb_Variables 
      Height          =   450
      Left            =   0
      TabIndex        =   4
      Top             =   0
      Width           =   5190
      _ExtentX        =   9155
      _ExtentY        =   794
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Style           =   1
      ImageList       =   "Img_opciones"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Aceptar"
            ImageIndex      =   6
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   10
         EndProperty
      EndProperty
      Begin MSComctlLib.ImageList Img_opciones 
         Left            =   2760
         Top             =   0
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   24
         ImageHeight     =   24
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   25
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_AYUDA_VARIABLES.frx":2EFA
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_AYUDA_VARIABLES.frx":3361
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_AYUDA_VARIABLES.frx":3857
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_AYUDA_VARIABLES.frx":3CEA
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_AYUDA_VARIABLES.frx":41D2
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_AYUDA_VARIABLES.frx":46E5
               Key             =   ""
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_AYUDA_VARIABLES.frx":4C22
               Key             =   ""
            EndProperty
            BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_AYUDA_VARIABLES.frx":5064
               Key             =   ""
            EndProperty
            BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_AYUDA_VARIABLES.frx":551E
               Key             =   ""
            EndProperty
            BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_AYUDA_VARIABLES.frx":59F1
               Key             =   ""
            EndProperty
            BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_AYUDA_VARIABLES.frx":5E35
               Key             =   ""
            EndProperty
            BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_AYUDA_VARIABLES.frx":639C
               Key             =   ""
            EndProperty
            BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_AYUDA_VARIABLES.frx":686B
               Key             =   ""
            EndProperty
            BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_AYUDA_VARIABLES.frx":6C8A
               Key             =   ""
            EndProperty
            BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_AYUDA_VARIABLES.frx":7182
               Key             =   ""
            EndProperty
            BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_AYUDA_VARIABLES.frx":757B
               Key             =   ""
            EndProperty
            BeginProperty ListImage17 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_AYUDA_VARIABLES.frx":79FE
               Key             =   ""
            EndProperty
            BeginProperty ListImage18 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_AYUDA_VARIABLES.frx":7EC4
               Key             =   ""
            EndProperty
            BeginProperty ListImage19 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_AYUDA_VARIABLES.frx":83BB
               Key             =   ""
            EndProperty
            BeginProperty ListImage20 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_AYUDA_VARIABLES.frx":8871
               Key             =   ""
            EndProperty
            BeginProperty ListImage21 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_AYUDA_VARIABLES.frx":8C36
               Key             =   ""
            EndProperty
            BeginProperty ListImage22 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_AYUDA_VARIABLES.frx":902C
               Key             =   ""
            EndProperty
            BeginProperty ListImage23 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_AYUDA_VARIABLES.frx":9423
               Key             =   ""
            EndProperty
            BeginProperty ListImage24 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_AYUDA_VARIABLES.frx":982C
               Key             =   ""
            EndProperty
            BeginProperty ListImage25 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_AYUDA_VARIABLES.frx":9CEA
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
End
Attribute VB_Name = "FRM_AYUDA_VARIABLES"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim cOptLocal As String

Function FUNC_LLENA_LISTA_VARIABLE()

    Dim vDatos_Retorno()
    GLB_Envia = Array()
    PROC_AGREGA_PARAMETRO GLB_Envia, 1
    
    Lst_Variables_Formulas.Clear
    
    If FUNC_EXECUTA_COMANDO_SQL("SP_PRO_CAPTURA_DATOS_CALCULO", GLB_Envia) Then
        
        Do While FUNC_LEE_RETORNO_SQL(vDatos_Retorno)
            
            If Trim(vDatos_Retorno(6)) <> "" Then
                
                Lst_Variables_Formulas.AddItem vDatos_Retorno(2) & " - " & vDatos_Retorno(4)
                Lst_Variables_Formulas.ItemData(Lst_Variables_Formulas.NewIndex) = Val(vDatos_Retorno(5))
                
            End If
        
        Loop
    
    End If

End Function

Private Sub Form_Activate()

   PROC_CARGA_AYUDA Me
   
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
   
    
    If KeyCode <> vbKeyControl And (Shift = 2 Or (Shift = 0 And (KeyCode = vbKeyReturn Or KeyCode = vbKeyEscape Or (KeyCode >= vbKeyF1 And KeyCode <= vbKeyF12)))) Then
    
        Select Case KeyCode
           
            Case VbkeyAceptar
                
                Call Tlb_Variables_ButtonClick(Tlb_Variables.Buttons(1))
                
            Case vbKeySalir
                
                Call Tlb_Variables_ButtonClick(Tlb_Variables.Buttons(2))
            
        End Select
        
    End If
    
End Sub

Private Sub Form_Load()

   cOptLocal = GLB_Opcion_Menu
   
   Me.Icon = FRM_MDI_PASIVO.Icon
    
   Call FUNC_LLENA_LISTA_VARIABLE
    
   Dim Arreglo_Variables_2(100)

   PROC_LOG_AUDITORIA "07", cOptLocal, Me.Caption, "", ""
  
End Sub
Private Sub Form_Unload(Cancel As Integer)

  PROC_LOG_AUDITORIA "08", cOptLocal, Me.Caption, "", ""
  
End Sub

Private Sub Lst_Variables_Formulas_Click()

    Txt_Variable.Text = Lst_Variables_Formulas.Text
    
End Sub

Private Sub Lst_Variables_Formulas_DblClick()

     Call Tlb_Variables_ButtonClick(Tlb_Variables.Buttons(1))
     
End Sub

Private Sub Tlb_Variables_ButtonClick(ByVal Button As MSComctlLib.Button)

Dim vDatos_Retorno()
    
Select Case Button.Index
    Case 1
    
      If Lst_Variables_Formulas.ListIndex <> -1 Then
      
          GLB_Instrumento = Lst_Variables_Formulas.ItemData(Lst_Variables_Formulas.ListIndex)
          GLB_Envia = Array()
          PROC_AGREGA_PARAMETRO GLB_Envia, Val(GLB_Instrumento)
          
          If FUNC_EXECUTA_COMANDO_SQL("SP_CON_VARIABLES", GLB_Envia) Then
              
              Do While FUNC_LEE_RETORNO_SQL(vDatos_Retorno)
                  
                  FRM_FORMULAS.Grd_Formula.TextMatrix(FRM_FORMULAS.Grd_Formula.Row, 2) = vDatos_Retorno(1)
                  FRM_FORMULAS.Grd_Formula.TextMatrix(FRM_FORMULAS.Grd_Formula.Row, 0) = vDatos_Retorno(3)
              
              Loop
          
          End If
          
          Unload Me
          
      End If
      
      Unload Me

    Case 2
            Unload Me
    
End Select

End Sub


