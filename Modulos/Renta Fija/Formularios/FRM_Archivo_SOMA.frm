VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form FRM_Archivo_SOMA 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Carga Archivo SOMA"
   ClientHeight    =   2025
   ClientLeft      =   2040
   ClientTop       =   2325
   ClientWidth     =   4275
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2025
   ScaleWidth      =   4275
   StartUpPosition =   2  'CenterScreen
   Begin VB.Frame Frame1 
      Caption         =   "Acrchivo SOMA"
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
      Height          =   1335
      Left            =   0
      TabIndex        =   1
      Top             =   600
      Width           =   4215
      Begin VB.OptionButton OptTxt 
         Caption         =   "Carga Archivo Txt"
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
         Height          =   495
         Left            =   240
         TabIndex        =   3
         Top             =   240
         Width           =   3135
      End
      Begin VB.OptionButton OptExcel 
         Caption         =   "Carga Archivo Excel"
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
         Height          =   495
         Left            =   240
         TabIndex        =   2
         Top             =   720
         Width           =   3255
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   4275
      _ExtentX        =   7541
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Cmb_Aceptar"
            Object.ToolTipText     =   "Aceptar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Cmb_Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   840
         Top             =   120
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   22
         ImageHeight     =   22
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   2
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_Archivo_SOMA.frx":0000
               Key             =   "Cmb_Aceptar"
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_Archivo_SOMA.frx":0EDA
               Key             =   "Cmb_Salir"
            EndProperty
         EndProperty
      End
   End
End
Attribute VB_Name = "FRM_Archivo_SOMA"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public TipoArchivoSOMA As Long
Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)


 Select Case Button.Index
     Case 1
        If OptTxt.Value = True Then
            Call BACFLI.CargaArchivo_Soma(BACFLI.GrillaSoma)
            Let TipoArchivoSOMA = 1
            If BACFLI.SwErrorArch = True Then
                Close #1
                Let Screen.MousePointer = vbDefault
                Exit Sub
            End If
            
        End If
        
        If OptExcel.Value = True Then
            Call BACFLI.CargaArchivo_Soma_Excel(BACFLI.GrillaSoma)
            Let TipoArchivoSOMA = 2
            If BACFLI.SwErrorArch = True Then
                Call BACFLI.MiLibro.Close
                Set BACFLI.MiExcel = Nothing
                Let Screen.MousePointer = vbDefault
                Exit Sub
            End If
            
        End If
     
     Let BACFLI.Progreso.Value = 50
     Let BACFLI.LblProgreso.Caption = "Carga Finalizada. 100 %"
     Let BACFLI.Command1.Enabled = True
     Call BACFLI.Realizar_Fli_Soma
     Call Unload(Me)
        
     Case 2
            Call Unload(Me)
        
     End Select
End Sub
