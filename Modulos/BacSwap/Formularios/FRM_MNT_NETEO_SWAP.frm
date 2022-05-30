VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Begin VB.Form FRM_MNT_NETEO_SWAP 
   Caption         =   "Neto de Operaciones Swap"
   ClientHeight    =   2760
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   10305
   LinkTopic       =   "Form2"
   MDIChild        =   -1  'True
   ScaleHeight     =   2760
   ScaleWidth      =   10305
   Begin MSComctlLib.ListView List 
      Height          =   2715
      Left            =   15
      TabIndex        =   0
      Top             =   30
      Width           =   10275
      _ExtentX        =   18124
      _ExtentY        =   4789
      View            =   3
      LabelWrap       =   0   'False
      HideSelection   =   -1  'True
      OLEDragMode     =   1
      OLEDropMode     =   1
      AllowReorder    =   -1  'True
      FullRowSelect   =   -1  'True
      HotTracking     =   -1  'True
      HoverSelection  =   -1  'True
      _Version        =   393217
      ForeColor       =   -2147483635
      BackColor       =   -2147483644
      BorderStyle     =   1
      Appearance      =   1
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      OLEDragMode     =   1
      OLEDropMode     =   1
      NumItems        =   0
   End
End
Attribute VB_Name = "FRM_MNT_NETEO_SWAP"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public Sub RefrescaDatos(nFlujo As Integer, nPagamos As Double, nRecibimos As Double, nNeto As Double, iMoneda As String, dMoneda As String)
   Dim iRegistros As Integer
   
   If nFlujo = 1 Then
      Call NombresListaNeto(iMoneda, dMoneda)
   End If
   
   Envia = Array()
   AddParam Envia, nFlujo
   AddParam Envia, Format(nPagamos, TipoFormato("usd"))
   AddParam Envia, Format(nRecibimos, TipoFormato("usd"))
   AddParam Envia, Format(nNeto, TipoFormato("usd"))
   Call LlenaListado(Envia, False)
   
End Sub

Private Sub NombresListaNeto(iMoneda As String, dMoneda As String)
   List.ColumnHeaders.Clear
   List.ListItems.Clear
   
   Envia = Array()
   AddParam Envia, "N° de Flujo"
   AddParam Envia, "Monto Recibimos " & iMoneda
   AddParam Envia, "Monto Pagamos " & dMoneda
   AddParam Envia, "Neto USD"
   Call LlenaListado(Envia, True)
   
End Sub

Private Sub LlenaListado(Arreglo As Variant, Titulos As Boolean)
   Dim nRegistro As Integer
   
   With List
      For nRegistro = 0 To UBound(Arreglo)
         If Titulos Then
            .ColumnHeaders.Add nRegistro + 1, , Arreglo(nRegistro), IIf(nRegistro = 0, 1000, 1800)
            If nRegistro = 0 Then
            End If
         Else
            If nRegistro = 0 Then
               .ListItems.Add , , Arreglo(nRegistro)
            Else
               .ListItems.Item(.ListItems.Count).ListSubItems.Add , , Arreglo(nRegistro)
            End If
         End If
      Next nRegistro
   End With
End Sub

Private Sub Form_Load()
   Me.Icon = BACSwap.Icon
   Me.Top = 0: Me.Left = 11025
   Me.Width = 6900: Me.Height = 7900
   Call NombresListaNeto("", "")
End Sub

Private Sub Form_Resize()
   On Error Resume Next
   
   List.Width = Me.Width - 150
   List.Height = Me.Height - 450
   
   On Error GoTo 0
End Sub
