VERSION 5.00
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.3#0"; "Comctl32.ocx"
Begin VB.Form FrmAvisoValorizacion 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Valorización"
   ClientHeight    =   3045
   ClientLeft      =   2700
   ClientTop       =   3930
   ClientWidth     =   9165
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   3045
   ScaleWidth      =   9165
   ShowInTaskbar   =   0   'False
   Begin ComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   2
      Top             =   0
      Width           =   9165
      _ExtentX        =   16166
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   327682
      BeginProperty Buttons {0713E452-850A-101B-AFC0-4210102A8DA7} 
         NumButtons      =   2
         BeginProperty Button1 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Key             =   "Imprimir"
            Object.Tag             =   "Imprimir"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Key             =   "Salir"
            Object.Tag             =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
   End
   Begin VB.ListBox ListProblemasValoriza 
      ForeColor       =   &H8000000D&
      Height          =   1815
      Left            =   75
      TabIndex        =   0
      Top             =   495
      Width           =   9000
   End
   Begin ComctlLib.ImageList ImageList1 
      Left            =   5955
      Top             =   105
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   327682
      BeginProperty Images {0713E8C2-850A-101B-AFC0-4210102A8DA7} 
         NumListImages   =   2
         BeginProperty ListImage1 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "FrmAvisoValorizacion.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "FrmAvisoValorizacion.frx":081A
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin VB.Label Label1 
      Caption         =   "Informe debe ser entregado a  Riesgo Financiero"
      ForeColor       =   &H8000000D&
      Height          =   300
      Left            =   90
      TabIndex        =   1
      Top             =   2475
      Width           =   3855
   End
End
Attribute VB_Name = "FrmAvisoValorizacion"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Toolbar1_ButtonClick(ByVal Button As ComctlLib.Button)
    
     
   Select Case UCase(Button.Key)
      Case Is = "IMPRIMIR"
         Call InformeTasasCero
      Case Is = "SALIR"
         Unload Me
   End Select

End Sub


Private Sub InformeTasasCero()
Dim Parametro$
Dim fila As Integer
   On Error GoTo ErrorImpresionTasaCero
   
   Printer.ScaleHeight = 60
   Printer.ScaleWidth = 115
   Printer.ScaleTop = 0
   Printer.ScaleLeft = 0
   
   ''Printer.FontSize = "Arial"
   Printer.Font = "Times New Roman"
   
   Printer.FontSize = 14
   Printer.FontBold = True
   
   Printer.CurrentY = 5
   Printer.CurrentX = 0
   Printer.Print Tab(30); Trim("Informe de Tasas con Valor Cero")
      
   Printer.FontSize = 10
   Printer.FontBold = False
     fila = 10
     For i = 0 To ListProblemasValoriza.ListCount
          Printer.CurrentY = fila
          Printer.CurrentX = 0
          Printer.Print Tab(10); Trim(ListProblemasValoriza.List(i))
          fila = fila + 1
          
          If fila > 55 Then
             Printer.NewPage
             fila = 5
          End If
            
     Next
   
   Printer.EndDoc
   
   Me.MousePointer = vbDefault
   On Error GoTo 0
Exit Sub
ErrorImpresionTasaCero:
   Me.MousePointer = vbDefault
   MsgBox "Acción Abortada." & vbCrLf & vbCrLf & "Error al imprimir Error : " & vbCrLf & BACSwap.Crystal.LastErrorString, vbExclamation, TITSISTEMA
   On Error GoTo 0
End Sub



