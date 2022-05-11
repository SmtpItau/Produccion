VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form FRM_MNT_APODERADOS 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Selección de Apoderados."
   ClientHeight    =   2745
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   5595
   LinkTopic       =   "Form2"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2745
   ScaleWidth      =   5595
   StartUpPosition =   1  'CenterOwner
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   1
      Top             =   0
      Width           =   5595
      _ExtentX        =   9869
      _ExtentY        =   794
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   3975
         Top             =   0
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
               Picture         =   "FRM_MNT_APODERADOS.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_APODERADOS.frx":0EDA
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_APODERADOS.frx":1DB4
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame FraApoderadoBanco 
      Height          =   1215
      Left            =   30
      TabIndex        =   0
      Top             =   375
      Width           =   5550
      Begin VB.ComboBox CMBApooderadoBco2 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   90
         Style           =   2  'Dropdown List
         TabIndex        =   6
         Top             =   825
         Width           =   3915
      End
      Begin VB.ComboBox CMBApooderadoBco1 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   90
         Style           =   2  'Dropdown List
         TabIndex        =   3
         Top             =   465
         Width           =   3915
      End
      Begin VB.Label LblCodApoBco2 
         Alignment       =   2  'Center
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "1"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   315
         Left            =   5175
         TabIndex        =   8
         Top             =   825
         Width           =   255
      End
      Begin VB.Label LblRutApoBco2 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "97051000-1"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   315
         Left            =   4005
         TabIndex        =   7
         Top             =   825
         Width           =   1155
      End
      Begin VB.Label LblCodApoBco1 
         Alignment       =   2  'Center
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "1"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   315
         Left            =   5175
         TabIndex        =   5
         Top             =   465
         Width           =   255
      End
      Begin VB.Label LblRutApoBco1 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "97051000-1"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   315
         Left            =   4005
         TabIndex        =   4
         Top             =   465
         Width           =   1155
      End
      Begin VB.Label LblNombreBanco 
         AutoSize        =   -1  'True
         Caption         =   "Apoderados del Banco"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Left            =   105
         TabIndex        =   2
         Top             =   195
         Width           =   1605
      End
   End
   Begin VB.Frame Frame1 
      Height          =   1215
      Left            =   30
      TabIndex        =   9
      Top             =   1500
      Width           =   5550
      Begin VB.ComboBox CMBApooderadoCli1 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   90
         Style           =   2  'Dropdown List
         TabIndex        =   11
         Top             =   465
         Width           =   3915
      End
      Begin VB.ComboBox CMBApooderadoCli2 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   90
         Style           =   2  'Dropdown List
         TabIndex        =   10
         Top             =   825
         Width           =   3915
      End
      Begin VB.Label LblNombreCliente 
         AutoSize        =   -1  'True
         Caption         =   "Apoderados del Banco"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Left            =   105
         TabIndex        =   16
         Top             =   195
         Width           =   1605
      End
      Begin VB.Label LblRutApoCli1 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "97051000-1"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   315
         Left            =   4005
         TabIndex        =   15
         Top             =   465
         Width           =   1155
      End
      Begin VB.Label LblCodApoCli1 
         Alignment       =   2  'Center
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "1"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   315
         Left            =   5175
         TabIndex        =   14
         Top             =   465
         Width           =   255
      End
      Begin VB.Label LblRutApoCli2 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "97051000-1"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   315
         Left            =   4005
         TabIndex        =   13
         Top             =   825
         Width           =   1155
      End
      Begin VB.Label LblCodApoCli2 
         Alignment       =   2  'Center
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "1"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   315
         Left            =   5175
         TabIndex        =   12
         Top             =   825
         Width           =   255
      End
   End
End
Attribute VB_Name = "FRM_MNT_APODERADOS"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Public gsAceptarDatos      As Boolean

Public NumeroOperacion     As Long
Public TipoOperacion       As String

Public RutBanco            As Long
Public DvBanco             As String
Public CodBanco            As Integer
Public NombreBanco         As String
Public DireccionBanco      As String

Public NombreApoderadoBco1 As String
Public RutApoderadoBco1    As Long
Public DvApoderadoBco1     As String
Public NombreApoderadoBco2 As String
Public RutApoderadoBco2    As Long
Public DvApoderadoBco2     As String

Public RutCliente          As Long
Public DvCliente           As String
Public CodCliente          As Integer
Public NombreCliente       As String
Public DireccionCliente    As String

Public NombreApoderadoCli1 As String
Public RutApoderadoCli1    As Long
Public DvApoderadoCli1     As String

Public NombreApoderadoCli2 As String
Public RutApoderadoCli2    As Long
Public DvApoderadoCli2     As String

Private Enum nTipRef
   [BANCO] = 0
   [CLIENTE] = 1
End Enum

Private Function LEER_APODERADOS(ByVal nRut As Long, ByVal nCodigo As Long, ByVal nRef As nTipRef)
   Dim SqlDatos()
   
   Envia = Array()
   AddParam Envia, nRut
   AddParam Envia, nCodigo
   If Not Bac_Sql_Execute("DBO.SP_LEER_APODERADOS", Envia) Then
      Call MsgBox("ha orurrido un error al Leer Apoderados.", vbExclamation, App.Title)
      Exit Function
   End If

   If nRef = BANCO Then
      Call CMBApooderadoBco2.AddItem("<< SIN INFORMACION >>" & Space(100) & " "): Let CMBApooderadoBco2.ItemData(CMBApooderadoBco2.NewIndex) = 0
   Else
      Call CMBApooderadoCli2.AddItem("<< SIN INFORMACION >>" & Space(100) & " "): Let CMBApooderadoCli2.ItemData(CMBApooderadoCli2.NewIndex) = 0
   End If

   Do While Bac_SQL_Fetch(SqlDatos())
      If nRef = BANCO Then
         Call CMBApooderadoBco1.AddItem(Trim(SqlDatos(5)) & Space(50) & Trim(SqlDatos(7)) & "   - " & Trim(SqlDatos(8))): Let CMBApooderadoBco1.ItemData(CMBApooderadoBco1.NewIndex) = SqlDatos(6)
         Call CMBApooderadoBco2.AddItem(Trim(SqlDatos(5)) & Space(50) & Trim(SqlDatos(7)) & "   - " & Trim(SqlDatos(8))): Let CMBApooderadoBco2.ItemData(CMBApooderadoBco2.NewIndex) = SqlDatos(6)
      Else
         Call CMBApooderadoCli1.AddItem(Trim(SqlDatos(5)) & Space(50) & Trim(SqlDatos(7)) & "   - " & Trim(SqlDatos(8))): Let CMBApooderadoCli1.ItemData(CMBApooderadoCli1.NewIndex) = SqlDatos(6)
         Call CMBApooderadoCli2.AddItem(Trim(SqlDatos(5)) & Space(50) & Trim(SqlDatos(7)) & "   - " & Trim(SqlDatos(8))): Let CMBApooderadoCli2.ItemData(CMBApooderadoCli2.NewIndex) = SqlDatos(6)
      End If
   Loop

   If nRef = BANCO Then
      Let CMBApooderadoBco1.ListIndex = 0
      Let CMBApooderadoBco2.ListIndex = 0
   Else
      Let CMBApooderadoCli1.ListIndex = 0
      Let CMBApooderadoCli2.ListIndex = 0
   End If
End Function

Private Sub CMBApooderadoBco1_Click()
   If CMBApooderadoBco1.ListIndex >= 0 Then
      Let NombreApoderadoBco1 = Mid(CMBApooderadoBco1.List(CMBApooderadoBco1.ListIndex), 1, 50)
      Let RutApoderadoBco1 = CMBApooderadoBco1.ItemData(CMBApooderadoBco1.ListIndex)
      Let DvApoderadoBco1 = Trim(Mid(CMBApooderadoBco1.List(CMBApooderadoBco1.ListIndex), InStr(1, CMBApooderadoBco1.List(CMBApooderadoBco1.ListIndex), "-") - 10, 10))
      Let DireccionBanco = Mid(CMBApooderadoBco1.List(CMBApooderadoBco1.ListIndex), InStr(1, CMBApooderadoBco1.List(CMBApooderadoBco1.ListIndex), "-") + 1)
      
      Let LblRutApoBco1.Caption = RutApoderadoBco1 & "-" & DvApoderadoBco1
   End If
End Sub
Private Sub CMBApooderadoBco2_Click()
   If CMBApooderadoBco2.ListIndex = 0 Then
      Let NombreApoderadoBco2 = ""
      Let RutApoderadoBco2 = 0
      Let DvApoderadoBco2 = ""

      Let LblRutApoBco2.Caption = ""
   End If
   If CMBApooderadoBco2.ListIndex > 0 Then
      Let NombreApoderadoBco2 = Mid(CMBApooderadoBco2.List(CMBApooderadoBco2.ListIndex), 1, 50)
      Let RutApoderadoBco2 = CMBApooderadoBco2.ItemData(CMBApooderadoBco2.ListIndex)
      Let DvApoderadoBco2 = Trim(Mid(CMBApooderadoBco2.List(CMBApooderadoBco2.ListIndex), InStr(1, CMBApooderadoBco2.List(CMBApooderadoBco2.ListIndex), "-") - 10, 10))

      Let LblRutApoBco2.Caption = RutApoderadoBco2 & "-" & DvApoderadoBco2
   End If
End Sub

Private Sub CMBApooderadoCli1_Click()
   If CMBApooderadoCli1.ListIndex >= 0 Then
      Let NombreApoderadoCli1 = Mid(CMBApooderadoCli1.List(CMBApooderadoCli1.ListIndex), 1, 50)
      Let RutApoderadoCli1 = CMBApooderadoCli1.ItemData(CMBApooderadoCli1.ListIndex)
      Let DvApoderadoCli1 = Trim(Mid(CMBApooderadoCli1.List(CMBApooderadoCli1.ListIndex), InStr(1, CMBApooderadoCli1.List(CMBApooderadoCli1.ListIndex), "-") - 10, 10))
      Let DireccionCliente = Mid(CMBApooderadoCli1.List(CMBApooderadoCli1.ListIndex), InStr(1, CMBApooderadoCli1.List(CMBApooderadoCli1.ListIndex), "-") + 1)

      Let LblRutApoCli1.Caption = RutApoderadoCli1 & "-" & DvApoderadoCli1
   End If
End Sub
Private Sub CMBApooderadoCli2_Click()
   If CMBApooderadoCli2.ListIndex = 0 Then
      Let NombreApoderadoCli2 = ""
      Let RutApoderadoCli2 = 0
      Let DvApoderadoCli2 = ""

      Let LblRutApoCli2.Caption = ""
   End If
   If CMBApooderadoCli2.ListIndex > 0 Then
      Let NombreApoderadoCli2 = Mid(CMBApooderadoCli2.List(CMBApooderadoCli2.ListIndex), 1, 50)
      Let RutApoderadoCli2 = CMBApooderadoCli2.ItemData(CMBApooderadoCli2.ListIndex)
      Let DvApoderadoCli2 = Trim(Mid(CMBApooderadoCli2.List(CMBApooderadoCli2.ListIndex), InStr(1, CMBApooderadoCli2.List(CMBApooderadoCli2.ListIndex), "-") - 10, 10))

      Let LblRutApoCli2.Caption = RutApoderadoCli2 & "-" & DvApoderadoCli2
   End If
End Sub

Private Sub Form_Load()
   Let Me.Icon = BacTrader.Icon
   Let Screen.MousePointer = vbDefault

   Let gsAceptarDatos = False
   Let LblNombreBanco.Caption = "Apoderados del Banco."
   Let LblNombreCliente.Caption = "Apoderados del Cliente."
   
   Let LblRutApoBco1.Caption = "":  Let LblRutApoBco1.Caption = "":  Let LblCodApoBco1.Visible = False
   Let LblRutApoBco2.Caption = "":  Let LblRutApoBco2.Caption = "":  Let LblCodApoBco2.Visible = False
   Let LblRutApoCli1.Caption = "":  Let LblRutApoCli1.Caption = "":  Let LblCodApoCli1.Visible = False
   Let LblRutApoCli2.Caption = "":  Let LblRutApoCli2.Caption = "":  Let LblCodApoCli2.Visible = False

   Call LEER_APODERADOS(RutBanco, CodBanco, BANCO)
   Call LEER_APODERADOS(RutCliente, CodCliente, CLIENTE)
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 2
         Let gsAceptarDatos = True
         Call GENERAR_DOCUMENTO
   End Select
   Call Unload(Me)
End Sub

Private Function GENERA_ANEXO_2()
   On Error GoTo ERROR_GEN_DOC
   Dim Documento  As Word.Document
   Dim nRegistros As Long
   Dim nContador  As Long
   Dim SqlDatos()

   Let nRegistros = 0

   Envia = Array()
   AddParam Envia, NumeroOperacion
   AddParam Envia, TipoOperacion
   If Not Bac_Sql_Execute("DBO.SP_LEER_DATOS_CONTRATO", Envia) Then
      Call MsgBox("Se ha originado un error en la carga de la información para escribir el contrato.", vbExclamation, App.Title)
      Exit Function
   End If
   Do While Bac_SQL_Fetch(SqlDatos())
      If nRegistros = 0 Then
         Let nRegistros = nRegistros + 1
         Set Documento = IniciaWordListadoLog("ANEXO2_RENTA_FIJA.doc")
         Documento.Activate

         Documento.Activate
         Documento.Bookmarks("FECHA_DATOS").Select
         Documento.Application.Selection.Text = Format(gsBac_Fecp, "Dddd, dd") & " de " & Format(gsBac_Fecp, "Mmmm") & " del " & Format(gsBac_Fecp, "yyyy") & "."

         Documento.Activate
         Documento.Bookmarks("NumeroContrato").Select
         Documento.Application.Selection.Text = Format(SqlDatos(1), FEntero)

         Documento.Activate
         Documento.Bookmarks("CLIENTE").Select
         Documento.Application.Selection.Text = Format(SqlDatos(33), FEntero)

         Documento.Activate
         Documento.Bookmarks("RUT_CLIENTE").Select
         Documento.Application.Selection.Text = Format(SqlDatos(34), FEntero)

         Documento.Activate
         Documento.Bookmarks("NOM_CUSTODIO").Select
         Documento.Application.Selection.Text = Format(SqlDatos(36), FEntero)

         Documento.Activate
         Documento.Bookmarks("CLIENTE_CUSTODIO").Select
         Documento.Application.Selection.Text = Format(SqlDatos(35), FEntero)

         Documento.Activate
         Documento.Bookmarks("NOMBRE_CUSTODIO").Select
         Documento.Application.Selection.Text = Format(SqlDatos(36), FEntero)

         Documento.Activate
         Documento.Bookmarks("NOMBRE_CUSTODIO2").Select
         Documento.Application.Selection.Text = Format(SqlDatos(35), FEntero)

         Documento.Activate
         Documento.Bookmarks("NOM_CUSTODIO2").Select
         Documento.Application.Selection.Text = Format(SqlDatos(36), FEntero)

         Documento.Activate
         Documento.Bookmarks("NOMBRE").Select
         Documento.Application.Selection.Text = ""
         
         Documento.Activate
         Documento.Bookmarks("CARGO").Select
         Documento.Application.Selection.Text = ""
         
      End If

      Documento.Bookmarks("GRILLA_OPERACIONES").Select
      nContador = nContador + 1

      Documento.Application.Selection.MoveDown Unit:=wdLine, Count:=nContador
      Documento.Bookmarks.Add Name:="Prueba", Range:=Documento.Application.Selection.Range
      Documento.Bookmarks("Prueba").Select

      Documento.Application.Selection.Text = SqlDatos(25)
      Documento.Application.Selection.MoveRight Unit:=wdCell
      Documento.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
         
      Documento.Application.Selection.Text = SqlDatos(26)
      Documento.Application.Selection.MoveRight Unit:=wdCell
      Documento.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
         
      Documento.Application.Selection.Text = SqlDatos(27)
      Documento.Application.Selection.MoveRight Unit:=wdCell
      Documento.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
         
      Documento.Application.Selection.Text = SqlDatos(28)
      Documento.Application.Selection.MoveRight Unit:=wdCell
      Documento.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
         
      Documento.Application.Selection.Text = SqlDatos(29)
      Documento.Application.Selection.MoveRight Unit:=wdCell
      Documento.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
         
      Documento.Application.Selection.Text = SqlDatos(30)
      Documento.Application.Selection.MoveRight Unit:=wdCell
      Documento.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
         
      Documento.Application.Selection.Text = Format(SqlDatos(31), FDecimal)
      Documento.Application.Selection.MoveRight Unit:=wdCell
      Documento.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
         
      Documento.Application.Selection.Text = ""
      Documento.Application.Selection.MoveRight Unit:=wdCell
      Documento.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
      
      Documento.Application.Selection.Text = ""
      Documento.Application.Selection.MoveRight Unit:=wdCell
      Documento.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
      
   Loop
   
   Documento.Application.WindowState = wdWindowStateMaximize
   Documento.Activate

   Set Documento = Nothing

Exit Function
ERROR_GEN_DOC:
   MsgBox err.Description, vbExclamation, App.Title
   
   Set Documento = Nothing
   Exit Function

End Function

Private Function GENERAR_DOCUMENTO()
   On Error GoTo ERROR_GEN_DOC
   Dim Documento  As Word.Document
   Dim nRegistros As Long
   Dim nContador  As Long
   Dim SqlDatos()

   Let nRegistros = 0
   Let nContador = -1

   Envia = Array()
   AddParam Envia, NumeroOperacion
   AddParam Envia, TipoOperacion
   If Not Bac_Sql_Execute("DBO.SP_LEER_DATOS_CONTRATO", Envia) Then
      Call MsgBox("Se ha originado un error en la carga de la información para escribir el contrato.", vbExclamation, App.Title)
      Exit Function
   End If
   Do While Bac_SQL_Fetch(SqlDatos())

      If nRegistros = 0 Then

         Let nRegistros = nRegistros + 1

         Set Documento = IniciaWordListadoLog("ANEXO1_RENTA_FIJA.doc")
         Documento.Activate

         Documento.Activate
         Documento.Bookmarks("NumeroContrato").Select
         Documento.Application.Selection.Text = Format(SqlDatos(1), FEntero)

         Documento.Activate
         Documento.Bookmarks("A").Select
         Documento.Application.Selection.Text = Format(SqlDatos(2), FEntero)

         Documento.Activate
         Documento.Bookmarks("DE").Select
         Documento.Application.Selection.Text = Format(SqlDatos(3), FEntero)

         Documento.Activate
         Documento.Bookmarks("FECHA_DATOS").Select
         Documento.Application.Selection.Text = Format(gsBac_Fecp, "Dddd, dd") & " de " & Format(gsBac_Fecp, "Mmmm") & " del " & Format(gsBac_Fecp, "yyyy") & "."

         Documento.Activate
         Documento.Bookmarks("FECHA_CONDICIONES").Select
         Documento.Application.Selection.Text = Format(SqlDatos(4), "Dddd, dd") & " de " & Format(SqlDatos(4), "Mmmm") & " del " & Format(SqlDatos(4), "yyyy") & "."

         Documento.Activate
         Documento.Bookmarks("COMPRADOR").Select
         Documento.Application.Selection.Text = Trim(SqlDatos(6))

         Documento.Activate
         Documento.Bookmarks("VENDEDOR").Select
         Documento.Application.Selection.Text = Trim(SqlDatos(7))

         Documento.Activate
         Documento.Bookmarks("FECHA_CIERRE").Select
         Documento.Application.Selection.Text = Format(SqlDatos(8), "Dddd, dd") & " de " & Format(SqlDatos(8), "Mmmm") & " del " & Format(SqlDatos(8), "yyyy") & "."

         Documento.Activate
         Documento.Bookmarks("MONEDA_COMVTA").Select
         Documento.Application.Selection.Text = Trim(SqlDatos(9))

         Documento.Activate
         Documento.Bookmarks("PRECIO_COMVTA").Select
         Documento.Application.Selection.Text = IIf(SqlDatos(9) = "CLP", Format(SqlDatos(10), FEntero), Format(SqlDatos(10), FDecimal))

         Documento.Activate
         Documento.Bookmarks("FECHA_ENTREVALOR").Select
         Documento.Application.Selection.Text = Format(SqlDatos(11), "DD/MM/YYYY")

         Documento.Activate
         Documento.Bookmarks("FORMA_ENTREVALOR").Select
         Documento.Application.Selection.Text = SqlDatos(12)

         Documento.Activate
         Documento.Bookmarks("FECHA_PAGOPRECIO").Select
         Documento.Application.Selection.Text = Format(SqlDatos(13), "DD/MM/YYYY")

         Documento.Activate
         Documento.Bookmarks("FORMA_PAGOPRECIO").Select
         Documento.Application.Selection.Text = SqlDatos(14)

         Documento.Activate
         Documento.Bookmarks("FECHA_RETROCOMPRA").Select
         Documento.Application.Selection.Text = Format(SqlDatos(15), "DD/MM/YYYY")

         Documento.Activate
         Documento.Bookmarks("MONEDA_RETROCOMPRA").Select
         Documento.Application.Selection.Text = SqlDatos(16)

         Documento.Activate
         Documento.Bookmarks("PRECIO_RETROCOMPRA").Select
         Documento.Application.Selection.Text = IIf(SqlDatos(16) = "CLP", Format(SqlDatos(17), FEntero), Format(SqlDatos(17), FDecimal))

         Documento.Activate
         Documento.Bookmarks("FORMA_ENTREVALOR_R").Select
         Documento.Application.Selection.Text = SqlDatos(18)

         Documento.Activate
         Documento.Bookmarks("FORMA_PAGOPRECIO_R").Select
         Documento.Application.Selection.Text = SqlDatos(19)

         Documento.Activate
         Documento.Bookmarks("BANCO_REF").Select
         Documento.Application.Selection.Text = SqlDatos(20)

         Documento.Activate
         Documento.Bookmarks("VALORES_SUSTITUTOS").Select
         Documento.Application.Selection.Text = SqlDatos(21)

         Documento.Activate
         Documento.Bookmarks("OTRAS_CONDICIONES").Select
         Documento.Application.Selection.Text = SqlDatos(22)

         
         Documento.Activate
         Documento.Bookmarks("DIRECCION_BANCO").Select
         Documento.Application.Selection.Text = Trim(DireccionBanco)

         Documento.Activate
         Documento.Bookmarks("NOMBRE_APODERADO_1").Select
         Documento.Application.Selection.Text = NombreApoderadoBco1

         Documento.Activate
         Documento.Bookmarks("CI_APODERADO_1").Select
         Documento.Application.Selection.Text = RutApoderadoBco1 & "-" & DvApoderadoBco1

         Documento.Activate
         Documento.Bookmarks("NOMBRE_APODERADO_2").Select
         Documento.Application.Selection.Text = NombreApoderadoBco2

         Documento.Activate
         Documento.Bookmarks("CI_APODERADO_2").Select
         Documento.Application.Selection.Text = IIf(NombreApoderadoBco2 = "", "", RutApoderadoBco2 & "-" & DvApoderadoBco2)
         
         Documento.Activate
         Documento.Bookmarks("DIRECCION_CLIENTE").Select
         Documento.Application.Selection.Text = Trim(DireccionCliente)

         Documento.Activate
         Documento.Bookmarks("NOMBRE_APODERADO_3").Select
         Documento.Application.Selection.Text = NombreApoderadoCli1

         Documento.Activate
         Documento.Bookmarks("CI_APODERADO_3").Select
         Documento.Application.Selection.Text = RutApoderadoCli1 & "-" & DvApoderadoCli1

         Documento.Activate
         Documento.Bookmarks("NOMBRE_APODERADO_4").Select
         Documento.Application.Selection.Text = NombreApoderadoCli2

         Documento.Activate
         Documento.Bookmarks("CI_APODERADO_4").Select
         Documento.Application.Selection.Text = IIf(NombreApoderadoCli2 = "", "", RutApoderadoCli2 & "-" & DvApoderadoCli2)
         
         
         Documento.Activate
         Documento.Bookmarks("PP_BANCO").Select
         Documento.Application.Selection.Text = SqlDatos(23)
         
         Documento.Activate
         Documento.Bookmarks("PP_CLIENTE").Select
         Documento.Application.Selection.Text = SqlDatos(24)
      End If
      
      Documento.Bookmarks("GRILLA_OPERACIONES").Select
      nContador = nContador + 1
      
      Documento.Application.Selection.MoveDown Unit:=wdLine, Count:=nContador
      Documento.Bookmarks.Add Name:="Prueba", Range:=Documento.Application.Selection.Range
      Documento.Bookmarks("Prueba").Select
      
         
      Documento.Application.Selection.Text = SqlDatos(25)
      Documento.Application.Selection.MoveRight Unit:=wdCell
      Documento.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
         
      Documento.Application.Selection.Text = SqlDatos(26)
      Documento.Application.Selection.MoveRight Unit:=wdCell
      Documento.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
         
      Documento.Application.Selection.Text = SqlDatos(27)
      Documento.Application.Selection.MoveRight Unit:=wdCell
      Documento.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
         
      Documento.Application.Selection.Text = SqlDatos(28)
      Documento.Application.Selection.MoveRight Unit:=wdCell
      Documento.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
         
      Documento.Application.Selection.Text = SqlDatos(29)
      Documento.Application.Selection.MoveRight Unit:=wdCell
      Documento.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
         
      Documento.Application.Selection.Text = SqlDatos(30)
      Documento.Application.Selection.MoveRight Unit:=wdCell
      Documento.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
         
      Documento.Application.Selection.Text = Format(SqlDatos(31), FDecimal)
      Documento.Application.Selection.MoveRight Unit:=wdCell
      Documento.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
         
      Documento.Application.Selection.Text = Format(SqlDatos(32), FDecimal)
      Documento.Application.Selection.MoveRight Unit:=wdCell
      Documento.Application.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
      
      Let nRegistros = nRegistros + 1
   Loop

   Documento.Application.WindowState = wdWindowStateMaximize
   Documento.Activate

   Set Documento = Nothing

   Call GENERA_ANEXO_2

Exit Function
ERROR_GEN_DOC:
   MsgBox err.Description, vbExclamation, App.Title
   Set Documento = Nothing
   Exit Function
End Function


Public Function IniciaWordListadoLog(cNombreDocumento As String) As Word.Document
   Dim Wrd As Variant
   Dim UbicacionDeDocumentos As String

   On Error Resume Next
   
   Set Wrd = GetObject(, "Word.Application")
   
   If err.Number <> 0 Then
      Set Wrd = New Word.Application
   End If
   
   err.Clear
   On Error GoTo 0
    
   Wrd.Application.Visible = True
   UbicacionDeDocumentos = RptList_Path
   
   Set IniciaWordListadoLog = Wrd.Documents.Add(UbicacionDeDocumentos & cNombreDocumento)

   Call BacControlWindows(1)
End Function

