VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BACCONTROLES.OCX"
Begin VB.Form FRM_Informes 
   BorderStyle     =   1  'Fixed Single
   ClientHeight    =   1170
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   3240
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   1170
   ScaleWidth      =   3240
   Begin Threed.SSFrame SSFrame1 
      Height          =   690
      Left            =   0
      TabIndex        =   0
      Top             =   480
      Width           =   3240
      _Version        =   65536
      _ExtentX        =   5715
      _ExtentY        =   1217
      _StockProps     =   14
      Caption         =   "Fecha"
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Font3D          =   1
      Begin BACControles.TXTFecha txtFechaInicio 
         Height          =   315
         Left            =   1545
         TabIndex        =   1
         Top             =   270
         Width           =   1575
         _ExtentX        =   2778
         _ExtentY        =   556
         Enabled         =   -1  'True
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "24/11/2003"
      End
      Begin VB.Label Label3 
         BackColor       =   &H00808000&
         BackStyle       =   0  'Transparent
         Caption         =   "Busqueda"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   300
         Left            =   300
         TabIndex        =   2
         Top             =   315
         Width           =   1140
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   480
      Left            =   0
      TabIndex        =   3
      Top             =   0
      Width           =   3240
      _ExtentX        =   5715
      _ExtentY        =   847
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Imprimir"
            Object.ToolTipText     =   "Imprimir"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Preliminar"
            Object.ToolTipText     =   "Vista Previa"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   6090
         Top             =   -45
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   24
         ImageHeight     =   24
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   3
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_Informes.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_Informes.frx":0EDA
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_Informes.frx":11F4
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
End
Attribute VB_Name = "FRM_Informes"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub Form_Load()


If Reporte_Error = "TASAS" Then
   Me.Caption = "Informe Errores en Tasas"
End If
If Reporte_Error = "CARGA" Then
   Me.Caption = "Informe Errores en Carga"
End If

Me.Icon = BacControlFinanciero.Icon
Me.txtFechaInicio.Text = gsBAC_Fecp

If Trim(Me.Caption) = "Informe Errores en Tasas" Then
   Me.txtFechaInicio.Enabled = True
Else
   Me.txtFechaInicio.Enabled = False
End If

Me.Top = 0
Me.Left = 0

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
 Select Case UCase(Button.Index)
     Case 1, 2
        If Trim(Me.Caption) = "Informe Errores en Tasas" Then
          If txtFechaInicio.Text > FechaSistema Then
            MsgBox "La Fecha de Busqueda no puede ser mayor a la Fecha de Sistema.", vbExclamation, Me.Caption
            Exit Sub
          End If
        End If
        If Reporte_Error = "CARGA" Then
            Call Limpiar_Cristal
            If Button.Index = 1 Then
                BacControlFinanciero.CryFinanciero.Destination = 1
            Else
                BacControlFinanciero.CryFinanciero.Destination = 0
            End If
                       
            BacControlFinanciero.CryFinanciero.ReportFileName = gsRPT_Path & "Reporte_Error_Carga.rpt"
            BacControlFinanciero.CryFinanciero.StoredProcParam(0) = Format(txtFechaInicio.Text, "yyyy-mm-dd 00:00:00.000")
            BacControlFinanciero.CryFinanciero.Connect = swConeccion
            BacControlFinanciero.CryFinanciero.Action = 1
            MousePointer = 0
        End If
       
        If Reporte_Error = "TASAS" Then
           Call Limpiar_Cristal
           If Button.Index = 1 Then
              BacControlFinanciero.CryFinanciero.Destination = 1
           Else
              BacControlFinanciero.CryFinanciero.Destination = 0
           End If
                       
           BacControlFinanciero.CryFinanciero.ReportFileName = gsRPT_Path & "inf_Errores_Tasas.rpt"
           BacControlFinanciero.CryFinanciero.StoredProcParam(0) = Format(txtFechaInicio.Text, "yyyymmdd")
           BacControlFinanciero.CryFinanciero.Connect = swConeccion
           BacControlFinanciero.CryFinanciero.Action = 1
           MousePointer = 0
                      
'          BacControlFinanciero.CryFinanciero.ReportFileName = gsRPT_Path & "Inf_Error_Tasas.rpt"
'          BacControlFinanciero.CryFinanciero.StoredProcParam(0) = Format(txtFechaInicio.Text, "yyyy-mm-dd 00:00:00.000")
'          BacControlFinanciero.CryFinanciero.Connect = swConeccion
'          BacControlFinanciero.CryFinanciero.Action = 1
           MousePointer = 0
        End If
     Case 3
        Unload Me
End Select


End Sub
