VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form Frm_Cierra_Mesa 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Abrir/Cerrar Mesa"
   ClientHeight    =   1740
   ClientLeft      =   4575
   ClientTop       =   2370
   ClientWidth     =   2745
   ForeColor       =   &H00C0C0C0&
   Icon            =   "Baccieme.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   1740
   ScaleWidth      =   2745
   Begin MSComctlLib.Toolbar Toolbar1 
      Height          =   480
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   2970
      _ExtentX        =   5239
      _ExtentY        =   847
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   3
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   3990
      Top             =   150
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   3
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Baccieme.frx":030A
            Key             =   "Rojo"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Baccieme.frx":075C
            Key             =   "Verde"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Baccieme.frx":0BAE
            Key             =   "Salir"
         EndProperty
      EndProperty
   End
   Begin VB.Image Image1 
      Height          =   960
      Index           =   0
      Left            =   700
      Picture         =   "Baccieme.frx":0EC8
      Stretch         =   -1  'True
      Top             =   615
      Width           =   900
   End
   Begin VB.Image Image2 
      Height          =   960
      Left            =   700
      Picture         =   "Baccieme.frx":130A
      Stretch         =   -1  'True
      Top             =   615
      Width           =   900
   End
   Begin VB.Image Image1 
      BorderStyle     =   1  'Fixed Single
      Height          =   540
      Index           =   1
      Left            =   30
      Picture         =   "Baccieme.frx":174C
      Top             =   1995
      Visible         =   0   'False
      Width           =   540
   End
   Begin VB.Image Image1 
      BorderStyle     =   1  'Fixed Single
      Height          =   540
      Index           =   2
      Left            =   570
      Picture         =   "Baccieme.frx":1B8E
      Top             =   1995
      Visible         =   0   'False
      Width           =   540
   End
End
Attribute VB_Name = "Frm_Cierra_Mesa"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim objCierreMesa As Object

Private Sub Form_Load()
Dim Arr()
Dim Cons As String

   Me.Left = 0
   Me.Top = 0
   Cons = "SVA_PRC_CIE_MES"
         If miSQL.SQL_Execute(Cons) = 0 Then
            If miSQL.SQL_Fetch(Arr) = 0 Then
              If Arr(1) = 0 Then
                Image1(0).Visible = True
                Image2.Visible = False
              Else
                Image1(0).Visible = False
                Image2.Visible = True
              End If
            End If
          End If
          
   Set objCierreMesa = New clsCierraMesa

End Sub



Private Sub Form_Unload(Cancel As Integer)

   Set objCierreMesa = Nothing

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   
   Dim SwBloqueo As Integer
   Dim Cons As String
   Dim Arr()
   
   With objCierreMesa
   
      Select Case Button.Index
     
         Case Is = 1
        Call guardar_hora_proceso("me", Time, gsBac_Fecp)
        
         Cons = "SVA_PRC_CIE_MES"
         If miSQL.SQL_Execute(Cons) = 0 Then
            If miSQL.SQL_Fetch(Arr) = 0 Then
              If Arr(1) = 1 Then
                .xValor = 0
              Else
                .xValor = 1
              End If
            End If
          End If
            
            
            If Not .CierreMesa Then
               
               MsgBox "Problemas con el cierre de mesa.", vbExclamation, gsBac_Version
               Exit Sub
            Else
              Image1(0).Visible = Not (Image1(0).Visible)
              Image2.Visible = Not (Image2.Visible)
            End If
            
            'all RefrescarMesa
         
         Case Else
            
            Unload Me
      
      End Select
   
   End With
 
End Sub
