VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form FRM_Interfaz_Descalce 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Interfaz Descalce"
   ClientHeight    =   1305
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   4185
   Icon            =   "FRM_Interfaz_Descalce.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   1305
   ScaleWidth      =   4185
   Begin VB.Frame Frame1 
      Height          =   855
      Left            =   0
      TabIndex        =   1
      Top             =   480
      Width           =   4335
      Begin VB.Label Label1 
         BorderStyle     =   1  'Fixed Single
         Height          =   495
         Left            =   180
         TabIndex        =   2
         Top             =   240
         Width           =   3855
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   4185
      _ExtentX        =   7382
      _ExtentY        =   794
      ButtonWidth     =   820
      ButtonHeight    =   794
      Style           =   1
      ImageList       =   "Img_opciones"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "interfaz"
            Description     =   "INTERFAZ"
            Object.ToolTipText     =   "Genera interfaz descalce"
            ImageIndex      =   14
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmbsalir"
            Description     =   "SALIR"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
      Begin MSComctlLib.ImageList Img_opciones 
         Left            =   3240
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
               Picture         =   "FRM_Interfaz_Descalce.frx":2EFA
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_Interfaz_Descalce.frx":3361
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_Interfaz_Descalce.frx":3857
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_Interfaz_Descalce.frx":3CEA
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_Interfaz_Descalce.frx":41D2
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_Interfaz_Descalce.frx":46E5
               Key             =   ""
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_Interfaz_Descalce.frx":4C22
               Key             =   ""
            EndProperty
            BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_Interfaz_Descalce.frx":5064
               Key             =   ""
            EndProperty
            BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_Interfaz_Descalce.frx":551E
               Key             =   ""
            EndProperty
            BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_Interfaz_Descalce.frx":59F1
               Key             =   ""
            EndProperty
            BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_Interfaz_Descalce.frx":5E35
               Key             =   ""
            EndProperty
            BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_Interfaz_Descalce.frx":639C
               Key             =   ""
            EndProperty
            BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_Interfaz_Descalce.frx":686B
               Key             =   ""
            EndProperty
            BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_Interfaz_Descalce.frx":6C8A
               Key             =   ""
            EndProperty
            BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_Interfaz_Descalce.frx":7182
               Key             =   ""
            EndProperty
            BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_Interfaz_Descalce.frx":757B
               Key             =   ""
            EndProperty
            BeginProperty ListImage17 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_Interfaz_Descalce.frx":79FE
               Key             =   ""
            EndProperty
            BeginProperty ListImage18 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_Interfaz_Descalce.frx":7EC4
               Key             =   ""
            EndProperty
            BeginProperty ListImage19 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_Interfaz_Descalce.frx":83BB
               Key             =   ""
            EndProperty
            BeginProperty ListImage20 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_Interfaz_Descalce.frx":8871
               Key             =   ""
            EndProperty
            BeginProperty ListImage21 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_Interfaz_Descalce.frx":8C36
               Key             =   ""
            EndProperty
            BeginProperty ListImage22 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_Interfaz_Descalce.frx":902C
               Key             =   ""
            EndProperty
            BeginProperty ListImage23 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_Interfaz_Descalce.frx":9423
               Key             =   ""
            EndProperty
            BeginProperty ListImage24 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_Interfaz_Descalce.frx":982C
               Key             =   ""
            EndProperty
            BeginProperty ListImage25 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_Interfaz_Descalce.frx":9CEA
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
End
Attribute VB_Name = "FRM_Interfaz_Descalce"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim cOptLocal As String

Private Sub Form_Load()
cOptLocal = GLB_Opcion_Menu
 Call PROC_LOG_AUDITORIA("07", GLB_Opcion_Menu, Me.Caption & " Fecha Proceso: " & GLB_Fecha_Proceso, "", "")
End Sub


Private Sub Form_Unload(Cancel As Integer)
Call PROC_LOG_AUDITORIA("08", GLB_Opcion_Menu, Me.Caption & " Fecha Proceso: " & GLB_Fecha_Proceso, "", "")
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
    Select Case UCase(Button.Description)
        Case "INTERFAZ"
            If MsgBox("Seguro de generar interfaz descalce ?", 36, gsBac_Version) <> 6 Then Exit Sub
        
            Label1.Caption = "Generando interfaz descalce"
            Label1.Refresh
            Call PROC_INTERFAZ_DESCALCE
            Label1.Caption = "Interfaz descalce generada"
            Label1.Refresh
        
            
        Case "SALIR"
            Unload Me
    End Select
End Sub


Function PROC_INTERFAZ_DESCALCE()
Dim Texto As String
Dim Datos()
Dim Largo As Integer
Dim DPAF As String
Dim PAFI As String

On Error GoTo Error_Interfaz
   
   

DPAF = LTrim(RTrim(GLB_Ruta_Int_Descalce)) & "DPAF.DAT"
PAFI = LTrim(RTrim(GLB_Ruta_Int_Descalce)) & "PAFI.BCP"

If Dir(DPAF) <> "" Then
   Kill (DPAF)
End If


If Dir(PAFI) <> "" Then
   Kill (PAFI)
End If


Open PAFI For Binary Access Write As #1
   
If FUNC_EXECUTA_COMANDO_SQL("SP_INTERFAZ_DESCALCE " & "'E'") Then
    Do While FUNC_LEE_RETORNO_SQL(Datos())
        Texto = Datos(1) & Chr(vbKeyTab)
        Texto = Texto & Datos(2) & Chr(vbKeyTab)
        Texto = Texto & Datos(3) & Chr(vbKeyTab)
        Texto = Texto & Datos(4) & Chr(vbKeyTab)
        Texto = Texto & Datos(5) & Chr(vbKeyTab)
        Texto = Texto & Datos(6) & Chr(vbKeyTab)
        Texto = Texto & Datos(7) & Chr(vbKeyTab)
        Texto = Texto & Datos(8) & Chr(vbKeyTab)
        Texto = Texto & Datos(9) & Chr(vbKeyTab)
        Texto = Texto & Datos(10) & Chr(vbKeyTab)
        Texto = Texto & Datos(11) & Chr(vbKeyTab)
        Texto = Texto & Datos(12) & Chr(vbKeyTab)
        Texto = Texto & Datos(13) & Chr(vbKeyTab)
        Texto = Texto & Datos(14) & Chr(vbKeyTab)
        Texto = Texto & Datos(15) & Chr(vbKeyTab)
        Texto = Texto & Datos(16) & Chr(vbKeyTab)
        Texto = Texto & Datos(17) & Chr(vbKeyTab)
        Texto = Texto & Datos(18) & Chr(vbKeyTab)
        Texto = Texto & Datos(19) & Chr(vbKeyTab)
        Texto = Texto & Datos(20) & Chr(vbKeyTab)
        Texto = Texto & Datos(21) & Chr(vbKeyTab)
        Texto = Texto & Datos(22) & Chr(vbKeyTab)
        Texto = Texto & Datos(23) & Chr(vbKeyTab)
        Texto = Texto & Chr(13) & Chr(10)
        Put #1, , Texto
        
    Loop
End If

Close #1

Texto = ""
Open DPAF For Binary Access Write As #2
   
If FUNC_EXECUTA_COMANDO_SQL("SP_INTERFAZ_DESCALCE " & "'D'") Then
    Do While FUNC_LEE_RETORNO_SQL(Datos())
        Texto = Datos(1) & Chr(vbKeyTab)
        Texto = Texto & Datos(2) & Chr(vbKeyTab)
        Texto = Texto & Datos(3) & Chr(vbKeyTab)
        Texto = Texto & Datos(4) & Chr(vbKeyTab)
        Texto = Texto & Datos(5) & Chr(vbKeyTab)
        Texto = Texto & Datos(6) & Chr(vbKeyTab)
        Texto = Texto & Datos(7) & Chr(vbKeyTab)
        Texto = Texto & Datos(8) & Chr(vbKeyTab)
        Texto = Texto & Chr(13) & Chr(10)
        Put #2, , Texto
    Loop
End If

Close #2

Call PROC_LOG_AUDITORIA("18", GLB_Opcion_Menu, Me.Caption & "(interfaz generada) &  Fecha : " & GLB_Fecha_Proceso, "", "")
Exit Function

Error_Interfaz:
MsgBox "Problemas en generaciòn de interfaz"
Call PROC_LOG_AUDITORIA("18", GLB_Opcion_Menu, Me.Caption & "(problema en generacion interfaz) &  Fecha : " & GLB_Fecha_Proceso, "", "")





End Function

