VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form RTecnica_Informes 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Informes de Reserva Técnica"
   ClientHeight    =   2820
   ClientLeft      =   1815
   ClientTop       =   3105
   ClientWidth     =   3990
   ForeColor       =   &H00C0C0C0&
   Icon            =   "RTenica_Informes.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   NegotiateMenus  =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   2820
   ScaleWidth      =   3990
   Begin VB.Frame Frame2 
      Caption         =   "Informes"
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   11.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   2055
      Left            =   120
      TabIndex        =   1
      Top             =   600
      Width           =   3735
      Begin VB.PictureBox ConCheck 
         BorderStyle     =   0  'None
         Height          =   330
         Index           =   3
         Left            =   3120
         Picture         =   "RTenica_Informes.frx":030A
         ScaleHeight     =   330
         ScaleWidth      =   330
         TabIndex        =   12
         Top             =   1560
         Visible         =   0   'False
         Width           =   330
      End
      Begin VB.PictureBox SinCheck 
         BorderStyle     =   0  'None
         Height          =   330
         Index           =   3
         Left            =   240
         Picture         =   "RTenica_Informes.frx":0464
         ScaleHeight     =   330
         ScaleWidth      =   375
         TabIndex        =   11
         Top             =   1560
         Width           =   375
      End
      Begin VB.PictureBox SinCheck 
         BorderStyle     =   0  'None
         Height          =   330
         Index           =   0
         Left            =   240
         Picture         =   "RTenica_Informes.frx":05BE
         ScaleHeight     =   330
         ScaleWidth      =   375
         TabIndex        =   7
         Top             =   360
         Width           =   375
      End
      Begin VB.PictureBox ConCheck 
         BorderStyle     =   0  'None
         Height          =   330
         Index           =   0
         Left            =   3150
         Picture         =   "RTenica_Informes.frx":0718
         ScaleHeight     =   330
         ScaleWidth      =   330
         TabIndex        =   6
         Top             =   360
         Visible         =   0   'False
         Width           =   330
      End
      Begin VB.PictureBox SinCheck 
         BorderStyle     =   0  'None
         Height          =   330
         Index           =   1
         Left            =   240
         Picture         =   "RTenica_Informes.frx":0872
         ScaleHeight     =   330
         ScaleWidth      =   375
         TabIndex        =   5
         Top             =   765
         Width           =   375
      End
      Begin VB.PictureBox SinCheck 
         BorderStyle     =   0  'None
         Height          =   330
         Index           =   2
         Left            =   240
         Picture         =   "RTenica_Informes.frx":09CC
         ScaleHeight     =   330
         ScaleWidth      =   375
         TabIndex        =   4
         Top             =   1170
         Width           =   375
      End
      Begin VB.PictureBox ConCheck 
         BorderStyle     =   0  'None
         Height          =   330
         Index           =   1
         Left            =   3150
         Picture         =   "RTenica_Informes.frx":0B26
         ScaleHeight     =   330
         ScaleWidth      =   330
         TabIndex        =   3
         Top             =   765
         Visible         =   0   'False
         Width           =   330
      End
      Begin VB.PictureBox ConCheck 
         BorderStyle     =   0  'None
         Height          =   330
         Index           =   2
         Left            =   3150
         Picture         =   "RTenica_Informes.frx":0C80
         ScaleHeight     =   330
         ScaleWidth      =   330
         TabIndex        =   2
         Top             =   1200
         Visible         =   0   'False
         Width           =   330
      End
      Begin VB.Label Etiqueta 
         AutoSize        =   -1  'True
         Caption         =   "Vencimientos de Pagares"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   3
         Left            =   720
         TabIndex        =   13
         Top             =   1560
         Width           =   1800
      End
      Begin VB.Label Etiqueta 
         AutoSize        =   -1  'True
         Caption         =   "Antecedentes Sobre Elegibles"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   0
         Left            =   720
         TabIndex        =   10
         Top             =   405
         Width           =   2130
      End
      Begin VB.Label Etiqueta 
         AutoSize        =   -1  'True
         Caption         =   "Detalle Cartera Elegibles"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   1
         Left            =   720
         TabIndex        =   9
         Top             =   810
         Width           =   1725
      End
      Begin VB.Label Etiqueta 
         AutoSize        =   -1  'True
         Caption         =   "Reserva Tecnica"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   2
         Left            =   720
         TabIndex        =   8
         Top             =   1215
         Width           =   1230
      End
   End
   Begin MSComctlLib.ImageList imagelist1 
      Left            =   4320
      Top             =   -120
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   23
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   9
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "RTenica_Informes.frx":0DDA
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "RTenica_Informes.frx":122C
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "RTenica_Informes.frx":1546
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "RTenica_Informes.frx":1998
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "RTenica_Informes.frx":1CB2
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "RTenica_Informes.frx":1FCC
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "RTenica_Informes.frx":2126
            Key             =   ""
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "RTenica_Informes.frx":2578
            Key             =   ""
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "RTenica_Informes.frx":2892
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Tool 
      Height          =   480
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   7875
      _ExtentX        =   13891
      _ExtentY        =   847
      ButtonWidth     =   794
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      ImageList       =   "imagelist1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdinforme"
            Description     =   "Informe Valorizacion"
            Object.ToolTipText     =   "Informe Valorizacion"
            ImageIndex      =   8
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdCerrar"
            Description     =   "Cerrar"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   9
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "RTecnica_Informes"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim Con As Integer

Option Explicit



Const Btn_Buscar = 2
Const Btn_Limpiar = 3
Const Btn_InfVal = 4
Const Btn_Salir = 5


Sub Imprime_Informes()

    Call Limpiar_Cristal

    Dim I As Integer

    For I = 0 To ConCheck.Count - 1
   
        If ConCheck.Item(I).Visible = True Then
            Select Case I
                    Case 0
                        BacTrader.bacrpt.WindowTitle = "ANTECEDENTES SOBRE ELEGIBLES"
                        BacTrader.bacrpt.ReportFileName = RptList_Path & "rtecnica_inf_antecedentes_inv_elegibles.rpt"
                        BacTrader.bacrpt.Connect = CONECCION
                         BacTrader.bacrpt.Action = 1
                        
                    Case 1
                        BacTrader.bacrpt.WindowTitle = "DETALLE CARTERA ELEGIBLE"
                        BacTrader.bacrpt.ReportFileName = RptList_Path & "rtecnica_detalle_cartera_elegible.rpt"
                        BacTrader.bacrpt.Connect = CONECCION
                        BacTrader.bacrpt.Action = 1


                    Case 2
                        BacTrader.bacrpt.WindowTitle = "RESERVA TECNICA"
                        BacTrader.bacrpt.ReportFileName = RptList_Path & "rtecnica_informe_diario.rpt"
                        BacTrader.bacrpt.Connect = CONECCION
                        BacTrader.bacrpt.Action = 1

                    Case 3
                        BacTrader.bacrpt.WindowTitle = "VENCIMIENTOS DE PAGARES"
                        BacTrader.bacrpt.ReportFileName = RptList_Path & "rtecnica_vctos_pagares_elegibles.rpt"
                        BacTrader.bacrpt.Connect = CONECCION
                        BacTrader.bacrpt.Action = 1
                    
            End Select
        End If
    Next I

End Sub
Private Sub ConCheck_Click(Index As Integer)

    SinCheck.Item(Index).Visible = Not SinCheck.Item(Index).Visible
    ConCheck.Item(Index).Visible = Not ConCheck.Item(Index).Visible

End Sub

Private Sub Form_Load()
    
    Me.Top = 0
    Me.Left = 0

End Sub

Private Sub SinCheck_Click(Index As Integer)

    ConCheck.Item(Index).Left = SinCheck.Item(Index).Left
    SinCheck.Item(Index).Visible = Not SinCheck.Item(Index).Visible
    ConCheck.Item(Index).Visible = Not ConCheck.Item(Index).Visible
    
End Sub

Private Sub Tool_ButtonClick(ByVal Button As MSComctlLib.Button)

    Select Case Button.key
       Case Is = "cmdinforme":  Call Imprime_Informes
       Case Is = "cmdCerrar":   Unload Me
    End Select
    
End Sub

