VERSION 5.00
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form FRM_RecalculoDRV 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Nuevo Cálculo Lineas DRV"
   ClientHeight    =   1950
   ClientLeft      =   495
   ClientTop       =   2745
   ClientWidth     =   4215
   ForeColor       =   &H00C0C0C0&
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   1950
   ScaleWidth      =   4215
   Begin VB.CommandButton btnRecalcular 
      Caption         =   "Recalcular Lineas DRV "
      Height          =   615
      Left            =   120
      TabIndex        =   0
      Top             =   1080
      Width           =   3975
   End
   Begin BACControles.TXTFecha TXTFechaGeneracion 
      Height          =   315
      Left            =   360
      TabIndex        =   2
      Top             =   600
      Width           =   2295
      _ExtentX        =   4048
      _ExtentY        =   556
      BackColor       =   12648447
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MaxDate         =   2958465
      MinDate         =   -328716
      Text            =   "01/07/2011"
   End
   Begin VB.Label LBLEtiquetaSup 
      AutoSize        =   -1  'True
      Caption         =   "Fecha de Generación"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Index           =   0
      Left            =   240
      TabIndex        =   1
      Top             =   360
      Width           =   1755
   End
End
Attribute VB_Name = "FRM_RecalculoDRV"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False


Private Sub btnRecalcular_Click()

    If MsgBox("¿Está seguro que desea volver a generar el nuevo calculo de Lineas DRV? ", vbQuestion + vbYesNo, gsBac_Version) <> vbYes Then
        Exit Sub
    End If
 
    Call BacCalculoRec.NuevoCalculoLineasDRV(1)
End Sub

Private Sub Form_Load()
  Let Me.Icon = BacTrader.Icon
  Let TXTFechaGeneracion.BackColor = &H80000005:  Let TXTFechaGeneracion.ForeColor = &H80000008
  Let TXTFechaGeneracion.text = Format(gsBac_Fecp, "dd-mm-yyyy")
  
End Sub


