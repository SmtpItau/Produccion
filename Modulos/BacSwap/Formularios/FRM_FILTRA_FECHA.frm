VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form FRM_FILTRA_FECHA 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Filtro de Fechas"
   ClientHeight    =   1170
   ClientLeft      =   2070
   ClientTop       =   3015
   ClientWidth     =   4290
   Icon            =   "FRM_FILTRA_FECHA.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   1170
   ScaleWidth      =   4290
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   4080
      Top             =   600
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
            Picture         =   "FRM_FILTRA_FECHA.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_FILTRA_FECHA.frx":075C
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   4
      Top             =   0
      Width           =   4290
      _ExtentX        =   7567
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Buscar"
            Object.ToolTipText     =   "Buscar Fechas"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin Threed.SSFrame Frame 
      Height          =   1050
      Index           =   2
      Left            =   0
      TabIndex        =   0
      Top             =   540
      Width           =   4290
      _Version        =   65536
      _ExtentX        =   7567
      _ExtentY        =   1852
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
      Begin BACControles.TXTFecha DateTerm 
         Height          =   315
         Left            =   2010
         TabIndex        =   6
         Top             =   660
         Width           =   1215
         _ExtentX        =   2143
         _ExtentY        =   556
         Enabled         =   -1  'True
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "30/11/2004"
      End
      Begin BACControles.TXTFecha DateText2 
         Height          =   315
         Left            =   2010
         TabIndex        =   3
         Top             =   240
         Width           =   1215
         _ExtentX        =   2143
         _ExtentY        =   556
         Enabled         =   -1  'True
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "25-10-2000"
      End
      Begin VB.Label lblFecha 
         AutoSize        =   -1  'True
         Caption         =   "Martes"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00008000&
         Height          =   210
         Index           =   0
         Left            =   3360
         TabIndex        =   7
         Top             =   720
         Width           =   585
      End
      Begin VB.Label Label 
         Alignment       =   2  'Center
         BackColor       =   &H00808000&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "Fecha Proceso"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   315
         Index           =   0
         Left            =   150
         TabIndex        =   5
         Top             =   660
         Width           =   1620
      End
      Begin VB.Label lblFecha 
         AutoSize        =   -1  'True
         Caption         =   "Martes"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00008000&
         Height          =   210
         Index           =   1
         Left            =   3360
         TabIndex        =   2
         Top             =   285
         Width           =   585
      End
      Begin VB.Label Label 
         Alignment       =   2  'Center
         BackColor       =   &H00808000&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "Fecha a Procesar"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   315
         Index           =   1
         Left            =   150
         TabIndex        =   1
         Top             =   255
         Width           =   1620
      End
   End
End
Attribute VB_Name = "FRM_FILTRA_FECHA"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Public FechaIntCapIXA3     As String

Function CargaApoderados()
   SwUnload = False
   Bac_Apoderados.Show 1
End Function

Public Function OpeValidarDatos() As Boolean
   OpeValidarDatos = True

   
   If DateTerm.Visible = True Then
    If Format$(DateText2.Text, FEFecha) > Format$(DateTerm.Text, FEFecha) Then
       OpeValidarDatos = False
       MsgBox "La Fecha de Inicio de Busqueda, no puede ser mayor a la Fecha de Proceso.", vbExclamation, "Filtro Fecha"
       DateTerm.SetFocus
    End If
    
    If Format$(DateTerm.Text, FEFecha) > Format$(gsBAC_Fecp, FEFecha) Then
      MsgBox "La Fecha de Proceso debe ser menor o igual a la Fecha de Sistema.", vbInformation, "Filtro Fecha"
      DateTerm.Text = gsBAC_Fecp
      OpeValidarDatos = False
    End If
   Else
    If Format(gsBAC_Fecp, FEFecha) < Format(DateText2.Text, FEFecha) Then
      OpeValidarDatos = False
      MsgBox "Fecha de Busqueda debe ser Menor a la de Proceso", vbExclamation, "MENSAJE"
    End If
   End If
   
   If lblFecha(1).Tag <> "OK" Then
      OpeValidarDatos = False
      MsgBox "Fecha de Busqueda Invalida", vbExclamation, "MENSAJE"
   End If

End Function

Private Sub cmdBuscar()


    If OpeValidarDatos() Then
    
       If FRM_FILTRA_FECHA.Tag = "IntCapIXA3Cart_Vig" Then

                  Call CargaInterfaces
                    If SwUnload = False Then
                         FechaIntCapIXA3 = DateText2.Text
                   End If
                   Unload Me
                   Exit Sub
                    
        Else

            Exit Sub

        End If
        
    End If

End Sub

Private Sub DateTerm_GotFocus()
    Call DiaSemana(DateTerm.Text, lblFecha(0))
End Sub


Private Sub DateTerm_KeyPress(KeyAscii As Integer)
   If KeyAscii% = vbKeyReturn Then
          KeyAscii% = 0
          SendKeys$ "{TAB}"

       End If
End Sub


Private Sub DateTerm_LostFocus()
   
   Call DiaSemana(DateTerm.Text, lblFecha(0))

End Sub

Private Sub DateText2_GotFocus()
   Call DiaSemana(DateText2.Text, lblFecha(1))
End Sub

Private Sub DateText2_KeyPress(KeyAscii As Integer)
        If KeyAscii% = vbKeyReturn Then
          KeyAscii% = 0
          SendKeys$ "{TAB}"

       End If

End Sub

Private Sub DateText2_LostFocus()
        Call DiaSemana(DateText2.Text, lblFecha(1))

End Sub

Private Sub Form_Load()

  'inicializa ventana y controles
    
    Frame(2).Height = 630
    FRM_FILTRA_FECHA.Height = 1650
    
    Label(0).Visible = False
    Label(0).Caption = "Fecha de Proceso"
    DateTerm.Visible = False
   '************fin
 
   Me.Icon = BACSwap.Icon
   giAceptar% = False
   
   If FRM_FILTRA_FECHA.Tag = "IntCapIXA3Cart_Vig" Then
       FRM_FILTRA_FECHA.Caption = "Cap.IX Anexo 3 Cartera Vigente"
        
   End If

   DateText2.Text = gsBAC_Fecp
   DateTerm.Text = gsBAC_Fecp
   Call DiaSemana(DateText2.Text, lblFecha(1))

End Sub

Private Sub Toolbar_ButtonClick(ByVal Button As MSComctlLib.Button)

    Select Case Button.Index
        Case 1          '"Buscar"
            Call cmdBuscar
            giAceptar% = True
            Unload Me
              
        Case 2          '"Salir"
            Unload Me
               
    End Select
    
End Sub

Function CargaInterfaces()
   SwUnload = False
   BacInterfaces.Interfaz = "Interfaz Capítulo IX Anexo 3 Cartera Vigente"
   BacInterfaces.Show 0

End Function


