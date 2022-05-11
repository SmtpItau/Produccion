VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacInformeModificaciones 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Informe Modificaciones"
   ClientHeight    =   2685
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   6150
   ClipControls    =   0   'False
   FillStyle       =   0  'Solid
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   2685
   ScaleWidth      =   6150
   StartUpPosition =   2  'CenterScreen
   Begin VB.Frame Frame1 
      Height          =   1935
      Left            =   45
      TabIndex        =   1
      Top             =   450
      Width           =   4995
      Begin VB.ComboBox Cmb_Modulo 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000012&
         Height          =   315
         Left            =   2295
         Style           =   2  'Dropdown List
         TabIndex        =   8
         Top             =   300
         Width           =   2265
      End
      Begin VB.ComboBox Cmb_Operacion 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000012&
         Height          =   315
         Left            =   2280
         Style           =   2  'Dropdown List
         TabIndex        =   6
         Top             =   810
         Width           =   2265
      End
      Begin BACControles.TXTFecha cmbFechaInicio 
         Height          =   315
         Left            =   1065
         TabIndex        =   2
         Top             =   1350
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
      Begin BACControles.TXTFecha cmbFechaTermino 
         Height          =   315
         Left            =   3360
         TabIndex        =   4
         Top             =   1335
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
      Begin VB.Label Label4 
         AutoSize        =   -1  'True
         Caption         =   "Modulo"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Left            =   405
         TabIndex        =   9
         Top             =   360
         Width           =   630
      End
      Begin VB.Label Label3 
         AutoSize        =   -1  'True
         Caption         =   "Numero Operación"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Left            =   390
         TabIndex        =   7
         Top             =   870
         Width           =   1590
      End
      Begin VB.Label Label2 
         Caption         =   "Hasta:"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   270
         Left            =   2670
         TabIndex        =   5
         Top             =   1365
         Width           =   645
      End
      Begin VB.Label Label1 
         Caption         =   "Desde:"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   270
         Left            =   405
         TabIndex        =   3
         Top             =   1395
         Width           =   645
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   6150
      _ExtentX        =   10848
      _ExtentY        =   794
      ButtonWidth     =   767
      ButtonHeight    =   741
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   4
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   3
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   5400
      Top             =   465
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      UseMaskColor    =   0   'False
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   4
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacInformeModificaciones.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacInformeModificaciones.frx":0EDA
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacInformeModificaciones.frx":11F4
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacInformeModificaciones.frx":20CE
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "BacInformeModificaciones"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public bDesdeReemplazo  As Boolean

Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)
   Let bDesdeReemplazo = False
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
       Select Case Button.Index
        Case 1          '"Buscar"
            Call Proc_Imprimir(crptToWindow)
        Case 2
            Call Proc_Imprimir(crptToPrinter)
        Case 3          '"Salir"
            Unload Me
    End Select
End Sub

Private Sub Form_Load()
   Let Me.top = 0:   Me.Left = 0
   Let Me.Icon = BacControlFinanciero.Icon
    
   cmbFechaInicio.Text = Format(gsBAC_Fecp, "dd/mm/yyyy")
   cmbFechaTermino.Text = Format(gsBAC_Fecp, "dd/mm/yyyy")
   
   Call FuncLoadModulos
End Sub

Private Sub Cmb_Modulo_Click()
   'LblModulo.Caption = Trim(Right(Cmb_Modulo.Text, 7))
    Call CargaComboOperacion
End Sub


Private Function FuncLoadModulos()
   Dim SQL     As String
   Dim DATOS()

   '--> Esto Debiese ser un SP, pero dejemos así
   Let SQL = ""
   Let SQL = "SELECT nombre_sistema, id_sistema  FROM BacParamSuda..SISTEMA_CNT WHERE operativo = 'S' AND gestion = 'N' and id_sistema IN ('PCS', 'BFW')"
   
   If Not Bac_Sql_Execute("SP_BUSCAR_SISTEMAS_CF") Then
      Call MsgBox("E - Error en procedimiento ...", vbExclamation, App.Title)
      Exit Function
   End If
   Call Cmb_Modulo.Clear
   Call Cmb_Modulo.AddItem("<<TODO>>")
   Do While Bac_SQL_Fetch(DATOS())
      If bDesdeReemplazo = True Then
         If DATOS(1) = "PCS" Then
            Cmb_Modulo.AddItem DATOS(1) & Space(50) & DATOS(2)
         End If
      Else
         Cmb_Modulo.AddItem DATOS(1) & Space(50) & DATOS(2)
      End If
   Loop
   If Cmb_Modulo.ListCount > 0 Then
      If bDesdeReemplazo = True Then
         Let Cmb_Modulo.ListIndex = 1
      Else
         Let Cmb_Modulo.ListIndex = 0
      End If
   End If

End Function


Private Sub Proc_Imprimir(ByVal Destino As DestinationConstants)
   Dim sCadena       As String
   Dim nContador     As Integer
   Dim nContrato     As Long
   Dim nModulo       As Integer
   
   If Not OpeValidarDatos() Then
      Exit Sub
   End If

   On Error GoTo Control:
   sCadena = ""

   FechaDesde = Format(cmbFechaInicio.Text, "yyyymmdd")
   FechaHasta = Format(cmbFechaTermino.Text, "yyyymmdd")
    
   Let nContrato = 0
   If Cmb_Operacion.ListIndex < 0 Then
      Exit Sub
   End If
   If Not Cmb_Operacion.List(Cmb_Operacion.ListIndex) = "<<TODO>>" Then
      Let nContrato = Cmb_Operacion.List(Cmb_Operacion.ListIndex)
   End If
   
   Screen.MousePointer = vbHourglass
   
   Call Limpiar_Cristal
   
   BacControlFinanciero.CryFinanciero.Destination = Destino '--> crptToWindow
   BacControlFinanciero.CryFinanciero.ReportFileName = gsRPT_Path & "BacInformeModificaciones.RPT"
   
   BacControlFinanciero.CryFinanciero.StoredProcParam(0) = Format(cmbFechaInicio.Text, "yyyy-mm-dd 00:00:00.000")                          'FechaDesde
   BacControlFinanciero.CryFinanciero.StoredProcParam(1) = Format(cmbFechaTermino.Text, "yyyy-mm-dd 00:00:00.000")
   BacControlFinanciero.CryFinanciero.StoredProcParam(2) = nContrato
   BacControlFinanciero.CryFinanciero.StoredProcParam(3) = gsBAC_User
   
   If Trim(Cmb_Modulo.List(Cmb_Modulo.ListIndex)) = "<<TODO>>" Then
      BacControlFinanciero.CryFinanciero.StoredProcParam(4) = " "
   Else
      BacControlFinanciero.CryFinanciero.StoredProcParam(4) = Left(Trim(Cmb_Modulo.List(Cmb_Modulo.ListIndex)), 3)
   End If
   BacControlFinanciero.CryFinanciero.StoredProcParam(5) = IIf(bDesdeReemplazo = True, 1, 0)

   BacControlFinanciero.CryFinanciero.WindowTitle = "INFORME MODIFICACIONES"
   BacControlFinanciero.CryFinanciero.WindowState = crptMaximized
   BacControlFinanciero.CryFinanciero.Connect = swConeccion
   BacControlFinanciero.CryFinanciero.Action = 1
   
   Screen.MousePointer = vbDefault
Exit Sub
Control:
   MsgBox "Problemas al generar Listado. " & Err.Description & ", " & Err.Number, vbCritical, "BACPARAMETROS"
   Screen.MousePointer = vbDefault
End Sub

Public Function OpeValidarDatos() As Boolean
   Dim cValidaciones As String
   Let cValidaciones = ""
   
   Let OpeValidarDatos = False

   If Format(gsBAC_Fecp, FeFecha) < Format(cmbFechaInicio.Text, FeFecha) Then
      cValidaciones = cValidaciones & "- Fecha de Inicio debe ser Menor o Igual a la de Proceso" & vbCrLf
   End If
   If Format(gsBAC_Fecp, FeFecha) < Format(cmbFechaTermino.Text, FeFecha) Then
      cValidaciones = cValidaciones & "- Fecha de Termino debe ser Menor o Igual a la de Proceso" & vbCrLf
   End If
   If Not cmbFechaInicio.Text <= cmbFechaTermino.Text Then
      cValidaciones = cValidaciones & "- Fecha de Inicio debe ser Menor o Igual a la de Final" & vbCrLf
   End If

   If Len(cValidaciones) = 0 Then
      OpeValidarDatos = True
      Exit Function
   End If

   Call MsgBox("V - Validaciones" & vbCrLf & vbCrLf & cValidaciones, vbExclamation, App.Title)

End Function


Private Function CargaComboOperacion()
   Dim SqlDatos()
   Dim DATOS()
   Dim sModulo As String

   Screen.MousePointer = vbHourglass
   Cmb_Modulo.Enabled = True
   
   Cmb_Modulo.Enabled = True
   If bDesdeReemplazo = True Then
      Let SQL = "SELECT distinct foliocontrato FROM tbl_modificaciaones where modulo = 'pcs' and foliocontrato <> foliocotizacion order by foliocontrato "
      Let Cmb_Modulo.Enabled = False
   Else
      If Trim(Cmb_Modulo.Text) = "<<TODO>>" Then
         Let SQL = "SELECT distinct foliocontrato from tbl_modificaciaones where foliocontrato = foliocotizacion order by foliocontrato "
      Else
         Let SQL = "SELECT distinct foliocontrato from tbl_modificaciaones where foliocontrato = foliocotizacion AND modulo = '" & Trim(Left(Cmb_Modulo.Text, 3)) & "' order by foliocontrato "
      End If
   End If
   
   If Not Bac_Sql_Execute(SQL) Then
      Screen.MousePointer = vbDefault
      MsgBox "Error al leer el archivo", vbCritical, TITSISTEMA
      Exit Function
   End If
   
   Call Cmb_Operacion.Clear
   Call Cmb_Operacion.AddItem("<<TODO>>")
   Let Cmb_Operacion.Enabled = False
   If Not Trim(Cmb_Modulo.List(Cmb_Modulo.ListIndex)) = "<<TODO>>" Then
      Do While Bac_SQL_Fetch(DATOS())
         Cmb_Operacion.AddItem (DATOS(1))
      Loop
      Let Cmb_Operacion.Enabled = True
   End If
   
   Let Cmb_Operacion.Text = "<<TODO>>"

   Screen.MousePointer = vbDefault
End Function
