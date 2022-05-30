VERSION 5.00
Begin VB.Form CarteraMTM 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "INFORME CARTERAS MTM"
   ClientHeight    =   2370
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   3930
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   2370
   ScaleWidth      =   3930
   ShowInTaskbar   =   0   'False
   Begin VB.Frame Frame1 
      Height          =   2295
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   3855
      Begin VB.CommandButton Command2 
         Caption         =   "&Salir"
         Height          =   735
         Left            =   2760
         Picture         =   "CarteraMTM.frx":0000
         Style           =   1  'Graphical
         TabIndex        =   6
         Top             =   1200
         Width           =   975
      End
      Begin VB.CommandButton Command1 
         Caption         =   "&Imprimir"
         Height          =   735
         Left            =   2760
         Picture         =   "CarteraMTM.frx":030A
         Style           =   1  'Graphical
         TabIndex        =   4
         Top             =   360
         Width           =   975
      End
      Begin VB.OptionButton Option2 
         Caption         =   "Monedas"
         Height          =   255
         Left            =   360
         TabIndex        =   3
         Top             =   1320
         Width           =   975
      End
      Begin VB.OptionButton Option1 
         Caption         =   "Tasa"
         Height          =   195
         Left            =   360
         TabIndex        =   2
         Top             =   960
         Value           =   -1  'True
         Width           =   975
      End
      Begin VB.Frame Frame2 
         Height          =   975
         Left            =   240
         TabIndex        =   5
         Top             =   720
         Width           =   2055
      End
      Begin VB.Label Lblimpre 
         Caption         =   "    ¡ INFORME ENVIADO  A LA                        IMPRESORA ¡"
         ForeColor       =   &H000000FF&
         Height          =   375
         Left            =   120
         TabIndex        =   7
         Top             =   1800
         Visible         =   0   'False
         Width           =   2535
      End
      Begin VB.Label Label1 
         BorderStyle     =   1  'Fixed Single
         Caption         =   "Tipo de Swap"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   240
         TabIndex        =   1
         Top             =   360
         Width           =   2055
      End
   End
End
Attribute VB_Name = "CarteraMTM"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit


Private Sub Command1_Click()
Dim tipo%, UF#, m%
Dim dia$, Sql$, ultimodia
Dim Datos()
Dim Fecha As Date
On Error GoTo errores:
Screen.MousePointer = 11
If Option1.Value = True Then
    tipo = 1
Else: Option2.Value = True
    tipo = 2
End If
UF = gsBAC_ValmonUF
If BacLastHabil(gsBAC_Fecp) Then
    ultimodia = BacUltimoDia(gsBAC_Fecp, "SI")
    Sql = "sp_Leer_ValorMoneda 998, '" & FechaYMD(ultimodia) & "'"
    If SQL_Execute(Sql) <> 0 Then
        MsgBox ("¡Error en la recuperacion del valor de la UF!")
        Exit Sub
    End If
    If SQL_Fetch(Datos) = 0 Then
        UF = Val(Datos(2))
    End If
End If
With BACSwap.Crystal
    .ReportFileName = gsRPT_Path & "rptmtm.rpt"
    .Destination = crptToWindow
    .StoredProcParam(0) = tipo
    .StoredProcParam(1) = UF
    .StoredProcParam(2) = Str(Time)
    .Connect = swConeccion
    .Action = 1
End With
Lblimpre.Visible = True
 For m = 1 To 30000
      DoEvents
 Next
Lblimpre.Visible = False
Screen.MousePointer = 0
Exit Sub
errores:
Screen.MousePointer = 0
MsgBox Error(Err), vbExclamation
Exit Sub
End Sub

Private Sub Command2_Click()
 Unload Me
End Sub

