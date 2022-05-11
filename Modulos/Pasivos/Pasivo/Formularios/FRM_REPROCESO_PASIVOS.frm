VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "threed32.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form FRM_REPROCESO_PASIVOS 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "REPROCESO PASIVOS"
   ClientHeight    =   4305
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   3765
   Icon            =   "FRM_REPROCESO_PASIVOS.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   4305
   ScaleWidth      =   3765
   ShowInTaskbar   =   0   'False
   Begin VB.PictureBox PicFin 
      Appearance      =   0  'Flat
      BorderStyle     =   0  'None
      FillColor       =   &H00FFFFFF&
      ForeColor       =   &H80000009&
      Height          =   555
      Left            =   300
      Picture         =   "FRM_REPROCESO_PASIVOS.frx":2EFA
      ScaleHeight     =   555
      ScaleWidth      =   555
      TabIndex        =   7
      Top             =   2490
      Visible         =   0   'False
      Width           =   555
   End
   Begin VB.PictureBox PicInicio 
      Appearance      =   0  'Flat
      BorderStyle     =   0  'None
      FillColor       =   &H00FFFFFF&
      ForeColor       =   &H80000009&
      Height          =   375
      Left            =   300
      Picture         =   "FRM_REPROCESO_PASIVOS.frx":32F3
      ScaleHeight     =   375
      ScaleWidth      =   435
      TabIndex        =   6
      Top             =   840
      Visible         =   0   'False
      Width           =   435
   End
   Begin VB.PictureBox PicConta 
      Appearance      =   0  'Flat
      BorderStyle     =   0  'None
      FillColor       =   &H00FFFFFF&
      ForeColor       =   &H80000009&
      Height          =   555
      Left            =   300
      Picture         =   "FRM_REPROCESO_PASIVOS.frx":36EC
      ScaleHeight     =   555
      ScaleWidth      =   555
      TabIndex        =   5
      Top             =   1380
      Visible         =   0   'False
      Width           =   555
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Height          =   450
      Left            =   0
      Negotiate       =   -1  'True
      TabIndex        =   0
      Top             =   0
      Width           =   1005
      _ExtentX        =   1773
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
            Key             =   "Reprocesar"
            Description     =   "Procesar"
            Object.ToolTipText     =   "Reprocesar Pasivos"
            ImageIndex      =   14
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Description     =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
      Begin MSComctlLib.ImageList Img_opciones 
         Left            =   2880
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
               Picture         =   "FRM_REPROCESO_PASIVOS.frx":3AE5
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_REPROCESO_PASIVOS.frx":3F4C
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_REPROCESO_PASIVOS.frx":4442
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_REPROCESO_PASIVOS.frx":48D5
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_REPROCESO_PASIVOS.frx":4DBD
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_REPROCESO_PASIVOS.frx":52D0
               Key             =   ""
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_REPROCESO_PASIVOS.frx":580D
               Key             =   ""
            EndProperty
            BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_REPROCESO_PASIVOS.frx":5C4F
               Key             =   ""
            EndProperty
            BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_REPROCESO_PASIVOS.frx":6109
               Key             =   ""
            EndProperty
            BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_REPROCESO_PASIVOS.frx":65DC
               Key             =   ""
            EndProperty
            BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_REPROCESO_PASIVOS.frx":6A20
               Key             =   ""
            EndProperty
            BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_REPROCESO_PASIVOS.frx":6F87
               Key             =   ""
            EndProperty
            BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_REPROCESO_PASIVOS.frx":7456
               Key             =   ""
            EndProperty
            BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_REPROCESO_PASIVOS.frx":7875
               Key             =   ""
            EndProperty
            BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_REPROCESO_PASIVOS.frx":7D6D
               Key             =   ""
            EndProperty
            BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_REPROCESO_PASIVOS.frx":8166
               Key             =   ""
            EndProperty
            BeginProperty ListImage17 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_REPROCESO_PASIVOS.frx":85E9
               Key             =   ""
            EndProperty
            BeginProperty ListImage18 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_REPROCESO_PASIVOS.frx":8AAF
               Key             =   ""
            EndProperty
            BeginProperty ListImage19 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_REPROCESO_PASIVOS.frx":8FA6
               Key             =   ""
            EndProperty
            BeginProperty ListImage20 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_REPROCESO_PASIVOS.frx":945C
               Key             =   ""
            EndProperty
            BeginProperty ListImage21 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_REPROCESO_PASIVOS.frx":9821
               Key             =   ""
            EndProperty
            BeginProperty ListImage22 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_REPROCESO_PASIVOS.frx":9C17
               Key             =   ""
            EndProperty
            BeginProperty ListImage23 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_REPROCESO_PASIVOS.frx":A00E
               Key             =   ""
            EndProperty
            BeginProperty ListImage24 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_REPROCESO_PASIVOS.frx":A417
               Key             =   ""
            EndProperty
            BeginProperty ListImage25 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_REPROCESO_PASIVOS.frx":A8D5
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin Threed.SSPanel SSPanel5 
      Height          =   2865
      Left            =   0
      TabIndex        =   1
      Top             =   390
      Width           =   3795
      _Version        =   65536
      _ExtentX        =   6694
      _ExtentY        =   5054
      _StockProps     =   15
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin VB.PictureBox PicDevengo 
         Appearance      =   0  'Flat
         BorderStyle     =   0  'None
         FillColor       =   &H00FFFFFF&
         ForeColor       =   &H80000009&
         Height          =   555
         Left            =   300
         Picture         =   "FRM_REPROCESO_PASIVOS.frx":AD96
         ScaleHeight     =   555
         ScaleWidth      =   555
         TabIndex        =   4
         Top             =   1560
         Visible         =   0   'False
         Width           =   555
      End
      Begin VB.Frame frmRepro 
         Appearance      =   0  'Flat
         Caption         =   "Próximo proceso"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C00000&
         Height          =   2745
         Left            =   60
         TabIndex        =   8
         Top             =   60
         Width           =   3675
         Begin VB.Label Lbl_Fin 
            Caption         =   "Fin de día"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   9.75
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00C00000&
            Height          =   255
            Index           =   3
            Left            =   1020
            TabIndex        =   12
            Top             =   2160
            Width           =   1095
         End
         Begin VB.Label Lbl_Devengo 
            Caption         =   "Devengamiento"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   9.75
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00C00000&
            Height          =   255
            Index           =   2
            Left            =   1020
            TabIndex        =   11
            Top             =   1590
            Width           =   1665
         End
         Begin VB.Label lbl_Contabilidad 
            Caption         =   "Contabilidad"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   9.75
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00C00000&
            Height          =   255
            Index           =   1
            Left            =   1020
            TabIndex        =   10
            Top             =   1020
            Width           =   1365
         End
         Begin VB.Label Lbl_Inicio 
            Caption         =   "Inicio de día"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   9.75
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00C00000&
            Height          =   285
            Index           =   0
            Left            =   1020
            TabIndex        =   9
            Top             =   480
            Width           =   1305
         End
      End
   End
   Begin Threed.SSPanel SSPanel1 
      Height          =   1425
      Left            =   0
      TabIndex        =   2
      Top             =   3300
      Width           =   3825
      _Version        =   65536
      _ExtentX        =   6747
      _ExtentY        =   2514
      _StockProps     =   15
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin VB.ListBox Lst_Reproceso 
         BackColor       =   &H8000000F&
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C00000&
         Height          =   840
         Left            =   60
         TabIndex        =   3
         Top             =   90
         Width           =   3645
      End
   End
End
Attribute VB_Name = "FRM_REPROCESO_PASIVOS"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Form_Load()
    Me.Icon = FRM_MDI_PASIVO.Icon
    Call Marca_Reproceso_Pasivos
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
 
      Select Case Button.Index
        Case 1
          If valida_mesa() Then
            Call Reproceso_Pasivos
          End If
        Case 2
            Unload Me
    End Select
    
End Sub

Public Sub Reproceso_Pasivos()
GLB_Envia = Array()

    Me.Lst_Reproceso.Clear
    Screen.MousePointer = 11
    
    Select Case Marca_Reproceso_Pasivos
    Case "I"
    
            GLB_Envia = Array("I")
    
            If Not FUNC_EXECUTA_COMANDO_SQL("SP_REPROCESO_PASIVOS", GLB_Envia) Then
                Lst_Reproceso.AddItem ("Reproceso inicio de día... (ERROR)")
                Lst_Reproceso.ForeColor = &HFF&
                Screen.MousePointer = 0
                Exit Sub
            End If
            
            Lst_Reproceso.AddItem ("Reproceso inicio de día... (OK)")
            Lst_Reproceso.ForeColor = &HC00000
            Screen.MousePointer = 0
            
            Call Grabar_Estado("PSV", "INICIO", 0, True)
            Call Grabar_Estado("PSV", "CONTABILIDAD", 1, True)
            Call Grabar_Estado("PSV", "DEVENGAMIENTO", 1, True)
            Call Grabar_Estado("PSV", "FIN", 1, True)
                 
    Case "C"
            GLB_Envia = Array("C")
            
            If Not FUNC_EXECUTA_COMANDO_SQL("SP_REPROCESO_PASIVOS", GLB_Envia) Then
                Lst_Reproceso.ForeColor = &HFF&
                Lst_Reproceso.AddItem ("Reproceso contabilidad... (ERROR)")
                Screen.MousePointer = 0
                Exit Sub
            End If
            
            Lst_Reproceso.AddItem ("Reproceso contabilidad... (OK)")
            Call Grabar_Estado("PSV", "CONTABILIDAD", 0, True)
            Lst_Reproceso.ForeColor = &HC00000
            Screen.MousePointer = 0
            
    Case "D"
            GLB_Envia = Array("D")
            
            If Not FUNC_EXECUTA_COMANDO_SQL("SP_REPROCESO_PASIVOS", GLB_Envia) Then
                Lst_Reproceso.ForeColor = &HFF&
                Lst_Reproceso.AddItem ("Reproceso devengamiento... (ERROR)")
                Screen.MousePointer = 0
                Exit Sub
            End If

            Lst_Reproceso.AddItem ("Reproceso devengamiento... (OK)")
            Call Grabar_Estado("PSV", "DEVENGAMIENTO", 0, True)
            Lst_Reproceso.ForeColor = &HC00000
            Screen.MousePointer = 0

    Case "F"
            GLB_Envia = Array("F")
            
            If Not FUNC_EXECUTA_COMANDO_SQL("SP_REPROCESO_PASIVOS", GLB_Envia) Then
                Lst_Reproceso.ForeColor = &HFF&
                Lst_Reproceso.AddItem ("Reproceso fin de día... ERROR)")
                Screen.MousePointer = 0
                Exit Sub
            End If
            
            Call Grabar_Estado("PSV", "INICIO", 1, True)
            Call Grabar_Estado("PSV", "FIN", 0, True)
            Lst_Reproceso.AddItem ("Reproceso fin de día... (OK)")
            Lst_Reproceso.ForeColor = &HC00000
            Screen.MousePointer = 0

    End Select
     
    Call Marca_Reproceso_Pasivos
    
End Sub



Public Function Marca_Reproceso_Pasivos() As String

Dim Datos()
GLB_Envia = Array()

If mvarFinMesEspecial = True Then
    GLB_Envia = Array(1)
Else
    GLB_Envia = Array(0)
End If

     If FUNC_EXECUTA_COMANDO_SQL("SP_SALIDA_ESTADO", GLB_Envia) Then
        Do While FUNC_LEE_RETORNO_SQL(Datos())
        
            
        If mvarFinMesEspecial = False Then
        
        If Datos(1) = "INICIO DE DIA" And Datos(2) = 1 And Datos(3) = 1 Then
                Marca_Reproceso_Pasivos = "I"
                
                Me.PicInicio.Visible = True
                Me.PicConta.Visible = False
                Me.PicDevengo.Visible = False
                Me.PicFin.Visible = False
                
            End If
            
            If Datos(11) = 0 And Datos(5) = 1 Then
                If Datos(4) = "CONTABILIDAD" And Datos(5) = 1 And Datos(6) = 2 Then
                    Marca_Reproceso_Pasivos = "C"
                    
                    Me.PicInicio.Visible = False
                    Me.PicConta.Visible = True
                    Me.PicDevengo.Visible = False
                    Me.PicFin.Visible = False

                End If
            
            
                If Datos(7) = "DEVENGAMIENTO" And Datos(8) = 1 And Datos(9) = 3 Then
                    Marca_Reproceso_Pasivos = "D"
                    
                    Me.PicInicio.Visible = False
                    Me.PicConta.Visible = False
                    Me.PicDevengo.Visible = True
                    Me.PicFin.Visible = False
       
                End If
            End If
            Else ' Especial dia
            
            If Datos(1) = "INICIO DE DIA" And Datos(2) = 1 And Datos(3) = 1 And Datos(8) = 0 Then
                Marca_Reproceso_Pasivos = "I"
                
                Me.PicInicio.Visible = True
                Me.PicConta.Visible = False
                Me.PicDevengo.Visible = False
                Me.PicFin.Visible = False
                
            End If
                If Datos(4) = "CONTABILIDAD" And Datos(5) = 1 And Datos(6) = 3 Then
                    Marca_Reproceso_Pasivos = "C"
                    
                    Me.PicInicio.Visible = False
                    Me.PicConta.Visible = True
                    Me.PicDevengo.Visible = False
                    Me.PicFin.Visible = False
                    
              
              Else
               If Datos(7) = "DEVENGAMIENTO" And Datos(8) = 1 And Datos(9) = 2 Then
                    Marca_Reproceso_Pasivos = "D"
                    Me.PicInicio.Visible = False
                    Me.PicConta.Visible = False
                    Me.PicDevengo.Visible = True
                    Me.PicFin.Visible = False
               End If
              
             End If
          End If
            
            If Datos(10) = "FIN DE DIA" And Datos(11) = 1 And Datos(12) = 4 Then
                Marca_Reproceso_Pasivos = "F"
                
                Me.PicInicio.Visible = False
                Me.PicConta.Visible = False
                Me.PicDevengo.Visible = False
                Me.PicFin.Visible = True

            End If

            
        Loop

    End If


End Function



