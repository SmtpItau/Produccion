VERSION 5.00
Begin VB.Form BacAyudaSwap 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Ayuda"
   ClientHeight    =   4812
   ClientLeft      =   48
   ClientTop       =   336
   ClientWidth     =   5592
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
   ScaleHeight     =   4812
   ScaleWidth      =   5592
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   Begin VB.ListBox CmbAyuda 
      BackColor       =   &H00FFFFFF&
      BeginProperty Font 
         Name            =   "Fixedsys"
         Size            =   10.8
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   3408
      Left            =   45
      TabIndex        =   1
      ToolTipText     =   "Doble click Acepta selección"
      Top             =   495
      Width           =   5505
   End
   Begin VB.TextBox TxtBusca 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFFFFF&
      BeginProperty Font 
         Name            =   "Fixedsys"
         Size            =   10.8
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   45
      MaxLength       =   80
      TabIndex        =   0
      Text            =   "Text1"
      Top             =   45
      Width           =   5505
   End
   Begin VB.CommandButton btnSalir 
      Caption         =   "&Salir"
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   9.6
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   780
      Left            =   4500
      Picture         =   "BacAyudaSwap.frx":0442
      Style           =   1  'Graphical
      TabIndex        =   3
      Top             =   4005
      Width           =   1050
   End
   Begin VB.CommandButton Aceptar 
      Caption         =   "&Aceptar"
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   9.6
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   780
      Left            =   3375
      Picture         =   "BacAyudaSwap.frx":0884
      Style           =   1  'Graphical
      TabIndex        =   2
      Top             =   4005
      Width           =   1050
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
        TxtBusca = Trim(Left(CmbAyuda.List(CmbAyuda.ListIndex), 48))
    End If

End Sub

Private Sub CmbAyuda_DblClick()
    Aceptar_Click
End Sub

Private Sub Form_Load()

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
        gsCodigo = Left(sLine, Len(sLine) - 2)
        gsDigito = Right(sLine, 1)
        gsNombre = Trim(Left(CmbAyuda.List(CmbAyuda.ListIndex), 45))
        gsCodCli = CDbl(CmbAyuda.ItemData(CmbAyuda.ListIndex))
        
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
Private Sub TxtBusca_Change()
Dim i As Integer
Dim TotPal As Integer
Dim pal As String
    
    With CmbAyuda
    TotPal = Len(Trim(TxtBusca.Text))
    pal = Trim(TxtBusca.Text)
    For i = 0 To .ListCount - 1
        If UCase(Trim(TxtBusca.Text)) = UCase(Trim(Left(.List(i), TotPal))) Then
            .ListIndex = i
            TxtBusca.Text = pal
            If Me.Visible Then
                TxtBusca.SetFocus
                SendKeys "{END}"
            End If
            Exit For
        End If
    Next
    End With
    
End Sub

Private Sub TxtBusca_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then
        TxtBusca = Trim(Left(CmbAyuda.List(CmbAyuda.ListIndex), 48))
        
    End If
    
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
