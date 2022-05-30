VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BACCONTROLES.OCX"
Begin VB.Form BacFiltraFechas 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Filtro de Fechas"
   ClientHeight    =   1260
   ClientLeft      =   2070
   ClientTop       =   3015
   ClientWidth     =   4710
   Icon            =   "Bacfilt.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   1260
   ScaleWidth      =   4710
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   4080
      Top             =   645
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
            Picture         =   "Bacfilt.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacfilt.frx":075C
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
      Width           =   4710
      _ExtentX        =   8308
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
      Height          =   750
      Index           =   2
      Left            =   0
      TabIndex        =   0
      Top             =   510
      Width           =   4710
      _Version        =   65536
      _ExtentX        =   8308
      _ExtentY        =   1323
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
      Begin VB.ComboBox Cmb_Years 
         Height          =   315
         Left            =   3120
         Style           =   2  'Dropdown List
         TabIndex        =   6
         Top             =   240
         Width           =   1095
      End
      Begin VB.ComboBox Cmb_Meses 
         Height          =   315
         Left            =   1920
         Style           =   2  'Dropdown List
         TabIndex        =   5
         Top             =   240
         Width           =   1215
      End
      Begin BACControles.TXTFecha DateText2 
         Height          =   312
         Left            =   1776
         TabIndex        =   3
         Top             =   240
         Width           =   1212
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
         Height          =   315
         Index           =   1
         Left            =   3195
         TabIndex        =   2
         Top             =   285
         Width           =   1320
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
Attribute VB_Name = "BacFiltraFechas"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Function CargaApoderados()
   SwUnload = False
   Bac_Apoderados.Show 1

End Function
Public Function Llena_Combos()
Dim I As Integer

       Cmb_Meses.AddItem ("ENERO"): Cmb_Meses.ItemData(Cmb_Meses.NewIndex) = 1
       Cmb_Meses.AddItem ("FEBRERO"): Cmb_Meses.ItemData(Cmb_Meses.NewIndex) = 2
       Cmb_Meses.AddItem ("MARZO"): Cmb_Meses.ItemData(Cmb_Meses.NewIndex) = 3
       Cmb_Meses.AddItem ("ABRIL"): Cmb_Meses.ItemData(Cmb_Meses.NewIndex) = 4
       Cmb_Meses.AddItem ("MAYO"): Cmb_Meses.ItemData(Cmb_Meses.NewIndex) = 5
       Cmb_Meses.AddItem ("JUNIO"): Cmb_Meses.ItemData(Cmb_Meses.NewIndex) = 6
       Cmb_Meses.AddItem ("JULIO"): Cmb_Meses.ItemData(Cmb_Meses.NewIndex) = 7
       Cmb_Meses.AddItem ("AGOSTO"): Cmb_Meses.ItemData(Cmb_Meses.NewIndex) = 8
       Cmb_Meses.AddItem ("SEPTIEMBRE"): Cmb_Meses.ItemData(Cmb_Meses.NewIndex) = 9
       Cmb_Meses.AddItem ("OCTUBRE"): Cmb_Meses.ItemData(Cmb_Meses.NewIndex) = 10
       Cmb_Meses.AddItem ("NOVIEMBRE"): Cmb_Meses.ItemData(Cmb_Meses.NewIndex) = 11
       Cmb_Meses.AddItem ("DICIEMBRE"): Cmb_Meses.ItemData(Cmb_Meses.NewIndex) = 12

       For I = 1999 To Year(Date)
            Cmb_Years.AddItem I: Cmb_Years.ItemData(Cmb_Years.NewIndex) = I
       Next

       Call bacBuscarCombo(Cmb_Meses, Month(Date))
       Call bacBuscarCombo(Cmb_Years, Year(Date))

End Function

Public Function OpeValidarDatos() As Boolean
   OpeValidarDatos = True

   If BacFiltraFechas.Tag = "CapIXA3" Then
      
      If Cmb_Meses.ListIndex <> -1 Then
         
         If Cmb_Meses.ItemData(Cmb_Meses.ListIndex) > Month(Date) And Cmb_Years.ItemData(Cmb_Years.ListIndex) >= Year(Date) Then
            MsgBox "Fecha No Puede Ser Mayor a la Actual", vbOKOnly, TITSISTEMA
            OpeValidarDatos = False
         End If

      End If

   Else
         If Format(gsBAC_Fecp, FEFecha) < Format(DateText2.Text, FEFecha) Then
            OpeValidarDatos = False
            MsgBox "Fecha de Busqueda debe ser Menor a la de Proceso", vbExclamation, "MENSAJE"
         End If
      
         If lblFecha(1).Tag <> "OK" Then
            OpeValidarDatos = False
            MsgBox "Fecha de Busqueda Invalida", vbExclamation, "MENSAJE"
         End If

   End If

End Function

Private Sub cmdBuscar()

      If OpeValidarDatos() Then
       
            If BacFiltraFechas.Tag = "CapIXA3" Then
                   Call CargaApoderados
                   If SwUnload = False Then
                      Call BacLeeCapituloIX_A3(CDbl(Cmb_Meses.ItemData(Cmb_Meses.ListIndex)), CDbl(Cmb_Years.Text))
                   End If
                   Unload Bac_Apoderados
                   Unload Me
                   Exit Sub
            End If
   
       End If

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

Private Sub Form_Activate()

   Me.Icon = BACSwap.Icon
   giAceptar% = False
   
   If BacFiltraFechas.Tag = "CapIXA3" Then
       BacFiltraFechas.Caption = "Anexo IX Capitulo 3"
       Cmb_Meses.Visible = True
       Cmb_Years.Visible = True

       lblFecha(1).Visible = False
       DateText2.Visible = False
       Call Llena_Combos

   Else
      Cmb_Meses.Visible = False
      Cmb_Years.Visible = False

      DateText2.Text = gsBAC_Fecp
      Call DiaSemana(DateText2.Text, lblFecha(1))

   End If
End Sub

Private Sub Toolbar_ButtonClick(ByVal Button As MSComctlLib.Button)

    Select Case Button.Index
        Case 1          '"Buscar"
            Call cmdBuscar
            giAceptar% = True
            Unload Me
              
        Case 2          '"Salir"
            Unload Bac_Apoderados
            Unload Me
               
    End Select
    
End Sub
