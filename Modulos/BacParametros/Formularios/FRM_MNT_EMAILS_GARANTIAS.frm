VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "Msflxgrd.ocx"
Begin VB.Form FRM_MNT_EMAILS 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Configuración de E-mails"
   ClientHeight    =   7155
   ClientLeft      =   90
   ClientTop       =   1680
   ClientWidth     =   7515
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   7155
   ScaleWidth      =   7515
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   6
      Top             =   0
      Width           =   7515
      _ExtentX        =   13256
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
         NumButtons      =   5
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar / Actualizar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Eliminar"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Cerrar"
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   4470
         Top             =   15
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   22
         ImageHeight     =   22
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   5
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_EMAILS_GARANTIAS.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_EMAILS_GARANTIAS.frx":0EDA
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_EMAILS_GARANTIAS.frx":1DB4
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_EMAILS_GARANTIAS.frx":20CE
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_EMAILS_GARANTIAS.frx":2FA8
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame Frame1 
      Height          =   6630
      Left            =   30
      TabIndex        =   7
      Top             =   375
      Width           =   7395
      Begin VB.TextBox txtAsunto 
         Height          =   285
         Left            =   2280
         TabIndex        =   11
         Top             =   1320
         Width           =   4980
      End
      Begin VB.CheckBox Chk_Texto 
         Caption         =   "Texto del Email"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   120
         TabIndex        =   3
         Top             =   1680
         Width           =   2055
      End
      Begin VB.TextBox Txt_Texto 
         Enabled         =   0   'False
         Height          =   1095
         Left            =   2280
         MultiLine       =   -1  'True
         TabIndex        =   4
         Top             =   1680
         Width           =   5010
      End
      Begin VB.TextBox txt_NombreDestino 
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
         Left            =   2295
         TabIndex        =   0
         Top             =   240
         Width           =   4980
      End
      Begin VB.ComboBox CmbTipoDestino 
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
         Left            =   2295
         Style           =   2  'Dropdown List
         TabIndex        =   1
         Top             =   615
         Width           =   5010
      End
      Begin VB.TextBox TxtEmail 
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
         Left            =   2295
         TabIndex        =   2
         Top             =   945
         Width           =   4980
      End
      Begin MSFlexGridLib.MSFlexGrid GRID 
         Height          =   3030
         Left            =   45
         TabIndex        =   5
         Top             =   3465
         Width           =   7305
         _ExtentX        =   12885
         _ExtentY        =   5345
         _Version        =   393216
         Cols            =   3
         FixedCols       =   0
         BackColor       =   -2147483633
         BackColorFixed  =   -2147483646
         ForeColorFixed  =   -2147483639
         BackColorBkg    =   -2147483636
         FocusRect       =   0
         GridLines       =   2
         GridLinesFixed  =   0
         SelectionMode   =   1
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin VB.Label lblAsunto 
         AutoSize        =   -1  'True
         Caption         =   "Asunto"
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
         Left            =   120
         TabIndex        =   12
         Top             =   1320
         Width           =   600
      End
      Begin VB.Label LblEtiqueta 
         AutoSize        =   -1  'True
         Caption         =   "E-Mail"
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
         Index           =   2
         Left            =   150
         TabIndex        =   10
         Top             =   990
         Width           =   510
      End
      Begin VB.Label LblEtiqueta 
         AutoSize        =   -1  'True
         Caption         =   "Tipo "
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
         Index           =   1
         Left            =   150
         TabIndex        =   9
         Top             =   660
         Width           =   405
      End
      Begin VB.Label LblEtiqueta 
         AutoSize        =   -1  'True
         Caption         =   "Nombre destinatario"
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
         Left            =   150
         TabIndex        =   8
         Top             =   270
         Width           =   1740
      End
   End
End
Attribute VB_Name = "FRM_MNT_EMAILS"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Function funcValidar_Information() As Boolean
Dim sMensaje As String

    Let funcValidar_Information = False
    
    Let sMensaje = ""
    
    If Len(Trim(Me.txt_NombreDestino.Text)) = 0 Then
        Let sMensaje = sMensaje & " - Falta ingresar nombre destinatario.-" & vbCrLf
    End If
    
    If Len(Trim(Me.CmbTipoDestino.Text)) = 0 Then
        Let sMensaje = sMensaje & " - Falta seleccion el tipo de EMail.-" & vbCrLf
    End If
   
    
    If Len(Trim(Me.TxtEmail.Text)) = 0 Then
        Let sMensaje = sMensaje & " - Falta ingresar la dirección Email.-" & vbCrLf
    End If
    
    If Not ValidaCasilla(Trim(TxtEmail.Text)) Then
        sMensaje = sMensaje & " - Dirección de E-mail inválida." & vbCrLf
    End If
    
    
    If Len(Trim(Me.Txt_Texto.Text)) = 0 Then
        Let sMensaje = sMensaje & " - Falta ingresar el texto del Email.-" & vbCrLf
    End If
    
    
    If Len(sMensaje) > 0 Then
        MsgBox sMensaje, vbExclamation, TITSISTEMA
        Exit Function
    End If


    funcValidar_Information = True
    
End Function
Private Function ValidaCasilla(ByVal direccion As String) As Boolean
' Usando expresión regular --> Implicar agregar Referencia a Microsoft VBScript Regular Expressions
'    Dim oReg As RegExp
'    Set oReg = New RegExp
'    oReg.Pattern = "^[\w-\.]+@\w+\.\w+$"
'    ValidaCasilla = oReg.Test(direccion)
'    Set oReg = Nothing
'End Function
ValidaCasilla = True
Dim p As Long
Dim parte1 As String, parte2 As String
Dim carValidos As String
carValidos = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!#$%&'*+-/=?^_`{|}~.@"
p = InStr(1, direccion, "@")
If p = 0 Then
    ValidaCasilla = False
    Exit Function
End If
If Mid$(direccion, 1, 1) = "." Then
    ValidaCasilla = False
    Exit Function
End If
If Mid$(direccion, 1, 1) = "@" Then
    ValidaCasilla = False
    Exit Function
End If
parte1 = Mid$(direccion, 1, p - 1)
parte2 = Mid$(direccion, p + 1)
If Trim(parte1) = "" Then
    ValidaCasilla = False
    Exit Function
End If
If Trim(parte2) = "" Then
    ValidaCasilla = False
    Exit Function
End If
If Not ValidaUnaVez("@", direccion) Then
    ValidaCasilla = False
    Exit Function
End If
If Not ValidaUnaVez(".", parte1, 1, True) Then
    ValidaCasilla = False
    Exit Function
End If
If Not ValidaUnaVez(".", parte2) Then
    ValidaCasilla = False
    Exit Function
End If
If Not ValidaCaracteres(carValidos, direccion) Then
    ValidaCasilla = False
    Exit Function
End If
End Function
Private Function ValidaCaracteres(ByVal validos As String, ByVal correo As String) As Boolean
ValidaCaracteres = True
Dim i As Long
For i = 1 To Len(correo)
    If InStr(1, validos, Mid$(correo, i, 1)) = 0 Then
        ValidaCaracteres = False
        Exit For
    End If
Next i
End Function
Private Function ValidaUnaVez(ByVal patron As String, ByVal texto As String, Optional largo As Long = 1, Optional ninguno As Boolean = False) As Boolean
Dim i As Long
Dim veces As Long
veces = 0
For i = 1 To Len(texto) Step largo
    If Mid$(texto, i, largo) = patron Then
        veces = veces + 1
    End If
Next i
If veces = 1 Then
    ValidaUnaVez = True
ElseIf ninguno Then
    If veces <> 0 Then
        ValidaUnaVez = False
    Else
        ValidaUnaVez = True
    End If
End If
End Function
Private Function SETTING_GRID()
   Let GRID.Rows = 2:         Let GRID.Cols = 4
   Let GRID.FixedRows = 1:    Let GRID.FixedCols = 0

   Let GRID.TextMatrix(0, 0) = "Nombre Destinatario":   Let GRID.ColWidth(0) = 2000
   Let GRID.TextMatrix(0, 1) = "Tipo":                  Let GRID.ColWidth(1) = 2500
   Let GRID.TextMatrix(0, 2) = "E-mail":                Let GRID.ColWidth(2) = 2500
   Let GRID.TextMatrix(0, 3) = "Codigo":                Let GRID.ColWidth(3) = 0
End Function

Private Sub subEliminar_Information()

    If MsgBox("¿Está seguro de Eliminar el E-mail: " & Me.TxtEmail.Text & "? ", vbQuestion + vbYesNo + vbDefaultButton2, TITSISTEMA) = vbNo Then
        Exit Sub
    End If
    
    Envia = Array()
    AddParam Envia, Me.TxtEmail.Text
    
    If Not Bac_Sql_Execute("bacparamsuda.dbo.SP_GAR_ELIMINA_MAILS", Envia) Then
        Call MsgBox("Se ha generado un error en la actualización de información.", vbExclamation, App.Title)
        Exit Sub
    End If

    Call subLimpia_Informacion
    
    

End Sub



Private Sub subLOAD_GlosaMail()
Dim Datos()
    
    
    If Not Bac_Sql_Execute("bacparamsuda.dbo.SP_GAR_GLOSAMAIL") Then
        Call MsgBox("Se ha generado un error en la carga de Información del mail.", vbExclamation, App.Title)
        Exit Sub
    End If
   
    Let Me.Txt_Texto.Text = ""
    
    Do While Bac_SQL_Fetch(Datos())
        txtAsunto.Text = IIf(IsNull(Datos(1)), "", Datos(1))
        Txt_Texto.Text = IIf(IsNull(Datos(2)), "", Datos(2))
    Loop
    
    
End Sub


Private Function subLimpia_Informacion()

    txt_NombreDestino.Text = ""
    CmbTipoDestino.ListIndex = -1
    TxtEmail.Text = ""
    Chk_Texto.Value = False
    Txt_Texto.Text = ""
    txtAsunto.Text = ""
    
    Call LOAD_Destinatarios(CmbTipoDestino)
    Call subLOAD_Informacion
    Call subLOAD_GlosaMail
   
End Function

Private Sub Chk_Texto_Click()

    Let Me.Txt_Texto.Enabled = Me.Chk_Texto.Value

End Sub


Private Sub CmbTipoDestino_KeyPress(KeyAscii As Integer)

    If KeyAscii = vbKeyReturn Then
        Let KeyAscii = 0
        Call TxtEmail.SetFocus
    End If

End Sub


Private Sub Form_Load()

   Let Me.Top = 0:   Let Me.Left = 0
   Let Me.Icon = BACSwapParametros.Icon
   Let Me.Caption = "Configuración de Email por Garantias."
   

   Call SETTING_GRID
   Call subLimpia_Informacion
  
End Sub

Private Sub GRID_DblClick()
   On Error Resume Next
   
   Let Me.txt_NombreDestino.Text = Trim(Left(GRID.TextMatrix(GRID.RowSel, 0), 50))
   'Let Me.CmbTipoDestino.ListIndex = CInt(GRID.TextMatrix(GRID.RowSel, 3))
   CmbTipoDestino.ListIndex = posDestino()
   
   Let TxtEmail.Text = GRID.TextMatrix(GRID.RowSel, 2)
   
   On Error GoTo 0
End Sub
Private Function posDestino() As Long
'Encuentra la posición de la combo cuyo ItemData(x) = Cint(GRID.TextMatrix(GRID.RowSel, 3))
Dim p As Long
Dim i As Long
p = CLng(GRID.TextMatrix(GRID.RowSel, 3))
posDestino = 0
For i = 0 To CmbTipoDestino.ListCount - 1
    If CmbTipoDestino.ItemData(i) = p Then
        posDestino = i
        Exit For
    End If
Next i
End Function
Private Sub GRID_KeyDown(KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyDelete Then
      'Call DEL_MENSAJE
   End If
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

   Select Case Button.Index
   
      Case 2
         Call subLimpia_Informacion
         
      Case 3
         Call subGrabar_Informacion
         
      Case 4
         Call subEliminar_Information
         
      Case 5
         Call Unload(Me)
         
   End Select
   
End Sub

Private Sub txt_NombreDestino_KeyPress(KeyAscii As Integer)


    BacToUCase KeyAscii
    
    If KeyAscii = vbKeyReturn Then
        Call Me.CmbTipoDestino.SetFocus
    End If

End Sub


Private Sub Txtemail_KeyPress(KeyAscii As Integer)

    Let KeyAscii = Asc(LCase(Chr(KeyAscii)))
    
    If KeyAscii = vbKeyReturn Then
        Me.Txt_Texto.SetFocus
    End If
   
End Sub

Private Sub subGrabar_Informacion()

    If Not funcValidar_Information() Then
        Exit Sub
    End If
    
    If MsgBox("¿Está seguro de Grabar el Email: " & Me.TxtEmail.Text & "? ", vbQuestion + vbYesNo + vbDefaultButton2, TITSISTEMA) = vbNo Then
        Exit Sub
    End If

    Envia = Array()
    AddParam Envia, txt_NombreDestino.Text
    AddParam Envia, CmbTipoDestino.ItemData(CmbTipoDestino.ListIndex)
    AddParam Envia, TxtEmail.Text
    AddParam Envia, Txt_Texto.Text
    AddParam Envia, txtAsunto.Text
   
    If Not Bac_Sql_Execute("bacparamsuda.dbo.SP_GAR_GRABA_MAILS", Envia) Then
        Call MsgBox("Se ha generado un error en la actualización de información.", vbExclamation, App.Title)
        Exit Sub
    End If

    Call subLimpia_Informacion
   
End Sub



Private Sub subLOAD_Informacion()
   Dim Datos()
   
   Envia = Array()
   
   If Not Bac_Sql_Execute("dbo.SP_GAR_CARGA_EMAILS", Envia) Then
      Call MsgBox("Se ha generado un error en la lectura de informacion.", vbExclamation, App.Title)
      Exit Sub
   End If
   
   Let GRID.Redraw = False
   Let GRID.Rows = 1
   
   Do While Bac_SQL_Fetch(Datos())
      Let GRID.Rows = GRID.Rows + 1
      Let GRID.TextMatrix(GRID.Rows - 1, 0) = Datos(1)
      Let GRID.TextMatrix(GRID.Rows - 1, 1) = Datos(2)
      Let GRID.TextMatrix(GRID.Rows - 1, 2) = Datos(3)
      Let GRID.TextMatrix(GRID.Rows - 1, 3) = Datos(4)
   Loop
   
   Let GRID.Redraw = True

End Sub

