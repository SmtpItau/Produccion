VERSION 5.00
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.3#0"; "comctl32.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Begin VB.Form BacAyudaSwap 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Ayuda de BacSwap"
   ClientHeight    =   5460
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   5925
   BeginProperty Font 
      Name            =   "Courier New"
      Size            =   9
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   Icon            =   "BacAyudaSwap.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   5460
   ScaleWidth      =   5925
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin ComctlLib.Toolbar Toolbar1 
      Height          =   480
      Left            =   15
      TabIndex        =   2
      Top             =   0
      Width           =   5895
      _ExtentX        =   10398
      _ExtentY        =   847
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   327682
      BeginProperty Buttons {0713E452-850A-101B-AFC0-4210102A8DA7} 
         NumButtons      =   2
         BeginProperty Button1 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Key             =   ""
            Object.ToolTipText     =   "Aceptar"
            Object.Tag             =   ""
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Key             =   ""
            Object.ToolTipText     =   "Cancelar"
            Object.Tag             =   ""
            ImageIndex      =   2
         EndProperty
      EndProperty
   End
   Begin Threed.SSPanel SSPanel1 
      Height          =   4950
      Left            =   30
      TabIndex        =   3
      Top             =   480
      Width           =   5865
      _Version        =   65536
      _ExtentX        =   10345
      _ExtentY        =   8731
      _StockProps     =   15
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Courier New"
         Size            =   9
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BorderWidth     =   2
      Begin VB.TextBox TxtBusca 
         BackColor       =   &H00FFFFFF&
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   9
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   1110
         MaxLength       =   80
         TabIndex        =   5
         Top             =   75
         Width           =   4635
      End
      Begin VB.ListBox CmbAyuda 
         BackColor       =   &H00FFFFFF&
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   11.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   4395
         Left            =   75
         TabIndex        =   4
         ToolTipText     =   "Doble click Acepta selección"
         Top             =   435
         Width           =   5670
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Buscar ..."
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   240
         Left            =   75
         TabIndex        =   6
         Top             =   105
         Width           =   900
      End
   End
   Begin VB.CommandButton btnSalir 
      Caption         =   "&Salir"
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   780
      Left            =   4500
      Picture         =   "BacAyudaSwap.frx":000C
      Style           =   1  'Graphical
      TabIndex        =   1
      Top             =   5745
      Width           =   1050
   End
   Begin VB.CommandButton Aceptar 
      Caption         =   "&Aceptar"
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   780
      Left            =   3375
      Picture         =   "BacAyudaSwap.frx":044E
      Style           =   1  'Graphical
      TabIndex        =   0
      Top             =   5745
      Width           =   1050
   End
   Begin ComctlLib.ImageList ImageList1 
      Left            =   4290
      Top             =   60
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
            Picture         =   "BacAyudaSwap.frx":0890
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "BacAyudaSwap.frx":0BAA
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "BacAyudaSwap"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit


Private Sub Aceptar_Click()
    giAceptar = True
    Unload Me
End Sub
Private Sub btnSalir_Click()
    giAceptar = False
    Unload Me
End Sub

Private Sub CmbAyuda_Click()
    If Len(Trim(TxtBusca)) > 5 Or Trim(TxtBusca) = "" Then
        'TxtBusca = Trim(Left(CmbAyuda.List(CmbAyuda.ListIndex), 48))
    End If
End Sub

Private Sub CmbAyuda_DblClick()
    Aceptar_Click
End Sub

Private Sub CmbAyuda_KeyDown(KeyCode As Integer, Shift As Integer)
Select Case KeyCode
   Case 13
      'MsgBox Me.CmbAyuda
      TxtBusca = Trim(Left(CmbAyuda.List(CmbAyuda.ListIndex), 48))
      giAceptar = True
      Unload Me
End Select
End Sub

Private Sub Form_Activate()
   On Error Resume Next
      Me.TxtBusca.SetFocus
   On Error GoTo 0
End Sub

Private Sub Form_Load()
   Me.Icon = BACSwap.Icon
   TxtBusca = ""
End Sub

Private Sub Form_Unload(Cancel As Integer)
Dim sLine$


    If CmbAyuda.ListIndex < 0 Or Not giAceptar Then
        Exit Sub
    End If
    
Select Case BacAyudaSwap.Tag
    
    Case "Cliente":        '---- PENDIENTE
        sLine = Trim(Right(CmbAyuda.List(CmbAyuda.ListIndex), 11))
        gsCodigo = Left(sLine, Len(sLine) - 2)      'RUT
        gsDigito = Right(sLine, 1)                          'DIGITO VERIF
        gsNombre = Trim(Left(CmbAyuda.List(CmbAyuda.ListIndex), 45))
        gsCodCli = CDbl(CmbAyuda.ItemData(CmbAyuda.ListIndex)) 'CODIGO CLIENTE
        
    Case "CliContrato":
        sLine = Trim(Right(CmbAyuda.List(CmbAyuda.ListIndex), 11))
        gsCodigo = Left(sLine, Len(sLine) - 2)                       'RUT
        gsDigito = Right(sLine, 1)                                   'DIGITO VERIF
        gsNombre = Trim(Left(CmbAyuda.List(CmbAyuda.ListIndex), 45))
        gsCodCli = CDbl(CmbAyuda.ItemData(CmbAyuda.ListIndex))       'CODIGO CLIENTE
        
    Case "Moneda"
        sLine = CmbAyuda.List(CmbAyuda.ListIndex)
        gsCodigo = CmbAyuda.ItemData(CmbAyuda.ListIndex)
        gsNemo = Trim(Left(sLine, 5))
        gsGlosa = Trim(Mid(sLine, 6))
        
    Case Else
        gsCodigo = CmbAyuda.ItemData(CmbAyuda.ListIndex)
        gsGlosa = CmbAyuda.List(CmbAyuda.ListIndex)
        
End Select
    
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As ComctlLib.Button)
Select Case Button.Index
   Case 1
      giAceptar = True
      Unload Me
   Case 2
      giAceptar = False
      Unload Me
End Select
End Sub

Sub busca_Nombre_de_lista()

   Dim nPos  As Double
   Dim sText As String

   sText = TxtBusca.Text
   
   For nPos = 0 To CmbAyuda.ListCount - 1
        If sText = Left(CmbAyuda.List(nPos), Len(sText)) Then
            CmbAyuda.ListIndex = nPos
            Exit For
        End If
   Next nPos
End Sub


Private Function FuncBuscarClientes()
   Dim nContador  As Long
   
   For nContador = 0 To CmbAyuda.ListCount - 1
      If Mid(CmbAyuda.List(nContador), 1, Len(Trim(TxtBusca.Text))) = Trim(TxtBusca.Text) Then
         Let CmbAyuda.ListIndex = nContador
         Exit For
      End If
   Next nContador
   
End Function


Private Sub TxtBusca_Change()
   Dim nPos  As Long
   Dim sText As String
   Dim objAyuda
   Dim nContador As Long

   If Trim$(Me.Tag) = "Cliente" Then
      Call FuncBuscarClientes
      Exit Sub
   End If

   sText = Trim$(TxtBusca.Text)
   
   For nPos = 0 To CmbAyuda.ListCount - 1
       If sText = Left(CmbAyuda.List(nPos), Len(sText)) Then
           Exit For
       End If
   Next nPos
   
   If sText <> CmbAyuda.List(nPos) Then
      nPos = -1
   ElseIf CmbAyuda.ListCount - 1 >= 0 Then
      CmbAyuda.ListIndex = nPos
   Else
      nPos = -1
   End If
   
   If (nPos& < 0) Then
      sText = Trim$(TxtBusca.Text)

      Select Case Trim$(Me.Tag)
      Case "Cliente"
         Dim Cliente As New clsCliente

            If Len(TxtBusca.Text) = 1 Then
            If Not Cliente.Ayuda(sText) Then
                MsgBox "No Existen Datos para ayuda solicitada", vbExclamation, Msj
                Exit Sub
            End If
            ElseIf Len(TxtBusca.Text) > 1 Then
               For nContador = 0 To CmbAyuda.ListCount - 1
                  If TxtBusca.Text = Mid(Me.CmbAyuda.List(nContador), 1, Len(TxtBusca.Text)) Then
                     CmbAyuda.ListIndex = nContador
                     CmbAyuda.TopIndex = nContador
                     Exit For
                  End If
               Next nContador
            End If

         Case "CliContrato"
            If Len(TxtBusca.Text) = 1 Then
               If Not Cliente.Func_LeeClienteContratoImpreso(sText) Then
                  MsgBox "No Existen Datos para ayuda solicitada", vbExclamation, Msj
                  Exit Sub
               End If
            ElseIf Len(TxtBusca.Text) > 1 Then
               For nContador = 0 To CmbAyuda.ListCount - 1
                  If TxtBusca.Text = Mid(Me.CmbAyuda.List(nContador), 1, Len(TxtBusca.Text)) Then
                     CmbAyuda.ListIndex = nContador
                     CmbAyuda.TopIndex = nContador
                     Exit For
                  End If
               Next nContador
            End If
      End Select

      'nPos = SendMessageByString(cmbayuda.hWnd, LB_SELECTSTRING, -1, sText)

   End If

   TxtBusca.Tag = TxtBusca.Text
    
End Sub

Private Sub TxtBusca_KeyDown(KeyCode As Integer, Shift As Integer)
Select Case KeyCode
   Case 13
      'MsgBox Me.CmbAyuda
      TxtBusca = Trim(Left(CmbAyuda.List(CmbAyuda.ListIndex), 48))
      giAceptar = True
      Unload Me
End Select
End Sub

Private Sub TxtBusca_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then
        'TxtBusca = Trim(Left(CmbAyuda.List(CmbAyuda.ListIndex), 48))
    End If
    
    KeyAscii = Asc(UCase(Chr(KeyAscii)))
       
End Sub

Private Sub TxtBusca_KeyUp(KeyCode As Integer, Shift As Integer)
    
    Select Case KeyCode
        Case 38
            'sube
            If CmbAyuda.ListIndex > 0 Then
                CmbAyuda.ListIndex = CmbAyuda.ListIndex - 1
            End If
            TxtBusca = Trim(Left(CmbAyuda.List(CmbAyuda.ListIndex), 48))
         Case 40
            'baja
            If CmbAyuda.ListIndex < CmbAyuda.ListCount - 1 Then
                CmbAyuda.ListIndex = CmbAyuda.ListIndex + 1
            End If
                    
            TxtBusca = Trim(Left(CmbAyuda.List(CmbAyuda.ListIndex), 48)) ' CmbAyuda
    End Select
    
End Sub
