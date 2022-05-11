VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form BAC_FRM_GEN_SORTEO 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Generación de Sorteo de Letras L043."
   ClientHeight    =   1635
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   4620
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   1635
   ScaleWidth      =   4620
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   4620
      _ExtentX        =   8149
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Generación Sorteo"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   3
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   4
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Cerrar Ventana"
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   3180
         Top             =   -15
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   22
         ImageHeight     =   22
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   4
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BAC_FRM_GEN_SORTEO.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BAC_FRM_GEN_SORTEO.frx":0EDA
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BAC_FRM_GEN_SORTEO.frx":11F4
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BAC_FRM_GEN_SORTEO.frx":20CE
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame Cuadro 
      Height          =   1185
      Left            =   0
      TabIndex        =   1
      Top             =   435
      Width           =   4605
      Begin MSComctlLib.ProgressBar Progress 
         Height          =   330
         Left            =   75
         TabIndex        =   5
         Top             =   795
         Visible         =   0   'False
         Width           =   4440
         _ExtentX        =   7832
         _ExtentY        =   582
         _Version        =   393216
         Appearance      =   1
      End
      Begin VB.Label MiFechaSorteo 
         Alignment       =   2  'Center
         BackColor       =   &H80000004&
         Caption         =   "Miercoles, 29 de Septiembre del 2006"
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
         Index           =   1
         Left            =   75
         TabIndex        =   4
         Top             =   525
         Width           =   4440
      End
      Begin VB.Label MiFechaSorteo 
         Alignment       =   2  'Center
         BackColor       =   &H80000002&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "22/12/2006"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000009&
         Height          =   345
         Index           =   0
         Left            =   1350
         TabIndex        =   3
         Top             =   150
         Width           =   3180
      End
      Begin VB.Label Etiquetas 
         Alignment       =   2  'Center
         BackColor       =   &H80000004&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "Fecha"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   345
         Left            =   75
         TabIndex        =   2
         Top             =   150
         Width           =   1260
      End
   End
End
Attribute VB_Name = "BAC_FRM_GEN_SORTEO"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub Form_Load()
   Me.Top = 0: Me.Left = 0
   Me.Icon = BacTrader.Icon
   
   MiFechaSorteo(0).Caption = Format(gsBac_Fecp, "DD/MM/YYYY")
   MiFechaSorteo(1).Caption = MiFormatoLargo(gsBac_Fecp)
End Sub

Private Function MiFormatoLargo(cFecha As Date) As String
   Dim MiFecha As String
   MiFormatoLargo = Format(cFecha, "dddd, dd ") & " de " & Format(cFecha, "mmmm") & " del " & Year(cFecha)
End Function


Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 1
         Call GenerarSorteoLchr
      Case 2
         Call Informe_Sorteos(crptToWindow)
      Case 3
         Call Informe_Sorteos(crptToPrinter)
      Case 4
         Unload Me
   End Select
End Sub

Private Sub GenerarSorteoLchr()
   Dim Datos()
   Dim cMensaje   As String
   
   Progress.Max = 100
   Progress.Visible = True
   
   Progress.Value = 25
   Call Bac_Sql_Execute("BEGIN TRANSACTION")
   
   Envia = Array()
   AddParam Envia, Format(gsBac_Fecp, "YYYYMMDD")
   If Not Bac_Sql_Execute("VALIDACIÓN_SORTEO_L043", Envia) Then
      Call Bac_Sql_Execute("ROLLBACK TRANSACTION")
      MsgBox "ERROR" & vbCrLf & vbCrLf & "Se ha generado un error al Generar la Validación de Sorteos provenientes del Dcv", vbExclamation, TITSISTEMA
      Exit Sub
   End If
   Progress.Value = 50
   If Bac_SQL_Fetch(Datos()) Then
      If Datos(1) <> 0 Then
         cMensaje = Datos(2)
         Call Bac_Sql_Execute("ROLLBACK TRANSACTION")
         MsgBox "Error" & vbCrLf & vbCrLf & cMensaje, vbExclamation, TITSISTEMA
         Exit Sub
      End If
   End If
   Progress.Value = 75
   
   
   Envia = Array()
   AddParam Envia, Format(gsBac_Fecp, "YYYYMMDD")
   AddParam Envia, gsBac_User
   If Not Bac_Sql_Execute("GENERA_SORTEO", Envia) Then
      Call Bac_Sql_Execute("ROLLBACK TRANSACTION")
      MsgBox "No se han posido generar los Sorteos de Letras Hipotecarias", vbExclamation, TITSISTEMA
      Exit Sub
   End If
   
   Progress.Value = 100
   Call Bac_Sql_Execute("COMMIT TRANSACTION")
   MsgBox "Se han generados los sorteos de letras hipotecarias sin problemas.", vbInformation, TITSISTEMA
   
   Progress.Visible = False
End Sub

Private Sub Informe_Sorteos(MiDestino As DestinationConstants)
   On Error GoTo ErrPrint
   
   Call Limpiar_Cristal
   BacTrader.bacrpt.Destination = MiDestino
   BacTrader.bacrpt.ReportFileName = RptList_Path & "Informe_Sorteo_Letras.rpt"
                          '--> Store Procedure : DBO.SP_INFORME_SORTEO
   BacTrader.bacrpt.StoredProcParam(0) = Format(gsBac_Fecp, "yyyy-mm-dd 00:00:00.000")
   BacTrader.bacrpt.StoredProcParam(1) = gsBac_User
   BacTrader.bacrpt.WindowTitle = "Informe de Sorteos de Letras Hipotecarias."
   BacTrader.bacrpt.ReportTitle = "Informe de Sorteos de Letras Hipotecarias."
   BacTrader.bacrpt.Connect = CONECCION
   BacTrader.bacrpt.Action = 1

   Call Limpiar_Cristal
   BacTrader.bacrpt.Destination = MiDestino
   BacTrader.bacrpt.ReportFileName = RptList_Path & "Informe_Sorteo_Letras_PimEdic.rpt"
                          '--> Store Procedure : DBO.SP_INFORME_SORTEO_PrimEdic
   BacTrader.bacrpt.StoredProcParam(0) = Format(gsBac_Fecp, "yyyy-mm-dd 00:00:00.000")
   BacTrader.bacrpt.StoredProcParam(1) = gsBac_User
   BacTrader.bacrpt.WindowTitle = "Informe de Sorteos de Letras Hipotecarias."
   BacTrader.bacrpt.ReportTitle = "Informe de Sorteos de Letras Hipotecarias."
   BacTrader.bacrpt.Connect = CONECCION
   BacTrader.bacrpt.Action = 1
Exit Sub
ErrPrint:
   
End Sub
