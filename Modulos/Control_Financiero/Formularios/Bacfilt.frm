VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BACCONTROLES.OCX"
Begin VB.Form BacFiltraFechas 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Filtro de Fechas"
   ClientHeight    =   1320
   ClientLeft      =   2070
   ClientTop       =   3015
   ClientWidth     =   4710
   Icon            =   "Bacfilt.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   1320
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
      Begin BACControles.TXTFecha DateText2 
         Height          =   315
         Left            =   1770
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
         Left            =   3075
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


Public Function OpeValidarDatos() As Boolean
   OpeValidarDatos = True

   If Format(gsBAC_Fecp, FeFecha) < Format(DateText2.Text, FeFecha) Then
      OpeValidarDatos = False
      MsgBox "Fecha de Busqueda debe ser Menor o Igual a la de Proceso", vbExclamation, "MENSAJE"
   End If

   If lblFecha(1).Tag <> "OK" Then
      OpeValidarDatos = False
      MsgBox "Fecha de Busqueda Invalida", vbExclamation, "MENSAJE"
   End If

End Function

Private Sub cmdBuscar()

    If OpeValidarDatos() Then
    
       If BacFiltraFechas.Tag = "VctoLinOper" Then

              

              Call BacRptVctoLinOper(DateText2.Text)
              
       ElseIf BacFiltraFechas.Tag = "OperAprobLineas" Then
             
                          
              Call BacRptOperAprobLineas(DateText2.Text)
              

       Else

            Exit Sub

        End If
        
    End If

End Sub



Private Sub DateText2_Click()
    Call DiaSemanaDos(DateText2.Text, lblFecha(1))
    
End Sub

Private Sub DateText2_GotFocus()
        Call DiaSemanaDos(DateText2.Text, lblFecha(1))
        
End Sub

Private Sub DateText2_KeyPress(KeyAscii As Integer)
        If KeyAscii% = vbKeyReturn Then
          KeyAscii% = 0
          SendKeys$ "{TAB}"

       End If

End Sub

Private Sub DateText2_LostFocus()
        Call DiaSemanaDos(DateText2.Text, lblFecha(1))

End Sub

Private Sub Form_Load()
Dim datos()

   If BacFiltraFechas.Tag = "VctoLinOper" Then
        
      DateText2.Enabled = False
      
   End If
           
   
   DateText2.Text = gsBAC_Fecp


   Call DiaSemanaDos(DateText2.Text, lblFecha(1))

End Sub

Private Sub Toolbar_ButtonClick(ByVal Button As MSComctlLib.Button)

    Select Case Button.Index
        Case 1          '"Buscar"
            Call cmdBuscar
            DateText2.Text = gsBAC_Fecp

''            giAceptar% = True
''            Unload Me
              
        Case 2          '"Salir"
   
            Unload Me
               
    End Select
    
End Sub


Function BacRptVctoLinOper(cFecha As String)
   
   On Error GoTo Err_Print
   

   Call Limpiar_Cristal
   
   BacControlFinanciero.CryFinanciero.ReportFileName = gsRPT_Path & "Rpt_Ope_Liberan_Lin.rpt"
   BacControlFinanciero.CryFinanciero.Destination = crptToWindow
   
   BacControlFinanciero.CryFinanciero.StoredProcParam(0) = Format$(cFecha, "YYYYMMDD")
   
   BacControlFinanciero.CryFinanciero.Connect = swConeccion
   BacControlFinanciero.CryFinanciero.WindowState = crptMaximized
   BacControlFinanciero.CryFinanciero.Action = 1

   Exit Function

Err_Print:
   
   MsgBox BacControlFinanciero.CryFinanciero.ReportFileName & ", " & Err.Description, vbInformation, TITSISTEMA

End Function



Function BacRptOperAprobLineas(cFecha As String)
   
   On Error GoTo Err_Print
   

   Call Limpiar_Cristal
   
   BacControlFinanciero.CryFinanciero.ReportFileName = gsRPT_Path & "Rpt_Ope_Aprobadas_Usuario.rpt"
   BacControlFinanciero.CryFinanciero.Destination = crptToWindow
   
   BacControlFinanciero.CryFinanciero.StoredProcParam(0) = Format$(cFecha, "YYYYMMDD")
   
   BacControlFinanciero.CryFinanciero.Connect = swConeccion
   BacControlFinanciero.CryFinanciero.WindowState = crptMaximized
   BacControlFinanciero.CryFinanciero.Action = 1

   Exit Function

Err_Print:
   
   MsgBox BacControlFinanciero.CryFinanciero.ReportFileName & ", " & Err.Description, vbInformation, TITSISTEMA

End Function


