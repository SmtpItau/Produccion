VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form infCirc477 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Informe Circular 477"
   ClientHeight    =   4260
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   8115
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   4260
   ScaleWidth      =   8115
   ShowInTaskbar   =   0   'False
   Begin VB.Frame Frame1 
      Height          =   4215
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   8085
      Begin Threed.SSCommand SSCommand1 
         Height          =   615
         Left            =   6540
         TabIndex        =   1
         Top             =   3420
         Width           =   615
         _Version        =   65536
         _ExtentX        =   1085
         _ExtentY        =   1085
         _StockProps     =   78
         Picture         =   "InfCirc477.frx":0000
      End
      Begin Threed.SSFrame SSFrame1 
         Height          =   1560
         Left            =   180
         TabIndex        =   2
         Top             =   1770
         Width           =   7710
         _Version        =   65536
         _ExtentX        =   13600
         _ExtentY        =   2752
         _StockProps     =   14
         Caption         =   "Apoderados"
         ForeColor       =   8388608
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Begin VB.ComboBox Cmb_Apoderado2 
            Enabled         =   0   'False
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   330
            ItemData        =   "InfCirc477.frx":031A
            Left            =   1755
            List            =   "InfCirc477.frx":031C
            Style           =   2  'Dropdown List
            TabIndex        =   8
            Top             =   1035
            Width           =   5835
         End
         Begin VB.TextBox Txt_Digito2 
            Enabled         =   0   'False
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   315
            Left            =   1260
            TabIndex        =   7
            Top             =   1050
            Width           =   300
         End
         Begin VB.TextBox Txt_Rut2 
            Enabled         =   0   'False
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   315
            Left            =   135
            TabIndex        =   6
            Top             =   1050
            Width           =   975
         End
         Begin VB.TextBox Txt_Rut1 
            Enabled         =   0   'False
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   315
            Left            =   150
            TabIndex        =   5
            Top             =   360
            Width           =   975
         End
         Begin VB.TextBox Txt_Digito1 
            Enabled         =   0   'False
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   315
            Left            =   1275
            TabIndex        =   4
            Top             =   360
            Width           =   300
         End
         Begin VB.ComboBox Cmb_Apoderado1 
            Enabled         =   0   'False
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   330
            ItemData        =   "InfCirc477.frx":031E
            Left            =   1755
            List            =   "InfCirc477.frx":0320
            Style           =   2  'Dropdown List
            TabIndex        =   3
            Top             =   345
            Width           =   5835
         End
         Begin VB.Label Label4 
            Alignment       =   2  'Center
            AutoSize        =   -1  'True
            Caption         =   "-"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   13.5
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   360
            Left            =   1140
            TabIndex        =   10
            Top             =   1020
            Width           =   90
         End
         Begin VB.Label Lbl_Guion1 
            Alignment       =   2  'Center
            AutoSize        =   -1  'True
            Caption         =   "-"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   13.5
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   360
            Left            =   1155
            TabIndex        =   9
            Top             =   330
            Width           =   90
         End
      End
      Begin VB.Frame Frame2 
         Height          =   1485
         Left            =   150
         TabIndex        =   11
         Top             =   270
         Width           =   7725
         Begin VB.TextBox Txtcapitulo 
            Height          =   285
            Left            =   4650
            TabIndex        =   14
            Top             =   360
            Width           =   1635
         End
         Begin VB.TextBox Txtemail 
            Height          =   285
            Left            =   1470
            TabIndex        =   13
            Top             =   870
            Width           =   3135
         End
         Begin BACControles.TXTFecha txtFecha1 
            Height          =   285
            Left            =   1470
            TabIndex        =   15
            Top             =   360
            Width           =   1455
            _ExtentX        =   2566
            _ExtentY        =   503
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
            Text            =   "13/08/2001"
         End
         Begin VB.Label Label3 
            Caption         =   "Email"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   9.75
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   345
            Left            =   330
            TabIndex        =   17
            Top             =   930
            Width           =   735
         End
         Begin VB.Label Label2 
            Caption         =   "Capitulos"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   9.75
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   285
            Left            =   3300
            TabIndex        =   16
            Top             =   390
            Width           =   1185
         End
         Begin VB.Label Label1 
            Caption         =   "Fecha"
            DragMode        =   1  'Automatic
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   9.75
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   255
            Left            =   330
            TabIndex        =   12
            Top             =   390
            Width           =   855
         End
      End
   End
End
Attribute VB_Name = "infCirc477"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub Form_Load()
  Dim Sql As String
  Dim cRutBanco1 As String
  Dim Datos()
    Me.Icon = BacTrader.Icon
    Me.txtFecha1.Text = Format(gsBac_Fecp, "dd/mm/yyyy")
    Me.Txtcapitulo.Text = "8026 - 491"
    Me.Txtemail.Text = "CSILVA@CORPBANCA.CL"
   
   ' Lee apoderados del Banco
    Sql = "SP_LEE_CLIENTE " & "'" & gsBac_RutC & "'"
    Sql = Sql & ", '" & gsBac_DigC & "'"
    If Bac_Sql_Execute(Sql) Then
      Cmb_Apoderado1.Enabled = True
      Cmb_Apoderado2.Enabled = True
      Cmb_Apoderado1.Clear
      Cmb_Apoderado2.Clear
      Cmb_Apoderado1.AddItem ""
      Cmb_Apoderado2.AddItem ""
      
      Do While Bac_SQL_Fetch(Datos())
         Cmb_Apoderado1.AddItem Datos(6) & Space(200) & Datos(5)
         Cmb_Apoderado1.ItemData(Cmb_Apoderado1.NewIndex) = Datos(4)
      
         Cmb_Apoderado2.AddItem Datos(6) & Space(200) & Datos(5)
         Cmb_Apoderado2.ItemData(Cmb_Apoderado2.NewIndex) = Datos(4)
      
      Loop
     Else
      Cmb_Apoderado1.Enabled = False
      Cmb_Apoderado2.Enabled = False
    End If
    
    Cmb_Apoderado1.ListIndex = 1
    Cmb_Apoderado2.ListIndex = 2
End Sub


Private Sub SSCommand1_Click()
         Screen.MousePointer = vbHourglass
         Call Limpiar_Cristal
         BacTrader.bacrpt.Connect = CONECCION
         BacTrader.bacrpt.ReportFileName = RptList_Path & "CIRC_477.RPT"
         BacTrader.bacrpt.StoredProcParam(0) = Format(txtFecha1.Text, "yyyy-mm-dd") + " 00:00:00.000"
         BacTrader.bacrpt.StoredProcParam(1) = Trim(Txtcapitulo.Text)
         BacTrader.bacrpt.StoredProcParam(2) = Trim(Txtemail.Text)
         BacTrader.bacrpt.StoredProcParam(3) = Mid(Cmb_Apoderado1.Text, 1, 50)
         BacTrader.bacrpt.StoredProcParam(4) = Mid(Cmb_Apoderado2.Text, 1, 50)
         BacTrader.bacrpt.Action = 1
         Screen.MousePointer = vbDefault
End Sub


Private Sub Txtcapitulo_KeyPress(KeyAscii As Integer)

' Txtcapitulo.MaxLength = 20

 BacToUCase KeyAscii
 If KeyAscii = 13 Then
  SendKeys "{tab}"
 End If

End Sub
Private Sub Txtemail_KeyPress(KeyAscii As Integer)

' Txtemail.MaxLength = 40

 BacToUCase KeyAscii
 If KeyAscii = 13 Then
  SendKeys "{tab}"
 End If

End Sub


Private Sub Cmb_Apoderado1_Click()

If Len(Cmb_Apoderado1.Text) = 0 Then
   Txt_Rut1.Text = ""
   Txt_Digito1.Text = ""
Else
  If Cmb_Apoderado1.ListIndex <> Cmb_Apoderado2.ListIndex Then
     Txt_Digito1.Text = Mid(Cmb_Apoderado1.Text, Len(Cmb_Apoderado1.Text), 1)
     Txt_Rut1.Text = Cmb_Apoderado1.ItemData(Cmb_Apoderado1.ListIndex)
   Else
     MsgBox "Apoderados iguales", vbExclamation
     Cmb_Apoderado1.ListIndex = 0
     Txt_Rut1.Text = ""
     Txt_Digito1.Text = ""
   End If
End If
End Sub

Private Sub Cmb_Apoderado2_Click()
If Len(Cmb_Apoderado2.Text) = 0 Then
   Txt_Digito2.Text = ""
   Txt_Rut2.Text = ""
Else
   If Cmb_Apoderado2.ListIndex <> Cmb_Apoderado1.ListIndex Then
      Txt_Digito2.Text = Mid(Cmb_Apoderado2.Text, Len(Cmb_Apoderado2.Text), 1)
      Txt_Rut2 = Cmb_Apoderado2.ItemData(Cmb_Apoderado2.ListIndex)
   Else
      MsgBox "Apoderados iguales", vbExclamation
      Cmb_Apoderado2.ListIndex = 0
      Txt_Digito2.Text = ""
      Txt_Rut2.Text = ""
      
  End If
End If
End Sub

