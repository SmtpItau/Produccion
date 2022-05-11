VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Begin VB.Form BacAyuda 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Ayuda de Control Financiero"
   ClientHeight    =   5805
   ClientLeft      =   3225
   ClientTop       =   2925
   ClientWidth     =   6435
   ClipControls    =   0   'False
   ControlBox      =   0   'False
   FillStyle       =   0  'Solid
   Icon            =   "Bacayuda.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5805
   ScaleWidth      =   6435
   Begin Threed.SSPanel SSPanel2 
      Height          =   5280
      Left            =   -75
      TabIndex        =   0
      Top             =   495
      Width           =   6465
      _Version        =   65536
      _ExtentX        =   11404
      _ExtentY        =   9313
      _StockProps     =   15
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin VB.ListBox lstNombre 
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00400000&
         Height          =   4680
         ItemData        =   "Bacayuda.frx":000C
         Left            =   165
         List            =   "Bacayuda.frx":0013
         TabIndex        =   2
         Top             =   510
         Width           =   6225
      End
      Begin VB.TextBox txtNombre 
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   9
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00400000&
         Height          =   360
         Left            =   1275
         LinkTimeout     =   0
         MaxLength       =   65
         TabIndex        =   1
         Top             =   120
         Width           =   5070
      End
      Begin VB.Label Label1 
         BackStyle       =   0  'Transparent
         Caption         =   "Buscar ..."
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   12
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00400000&
         Height          =   255
         Left            =   150
         TabIndex        =   3
         Top             =   120
         Width           =   1095
      End
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   7470
      Top             =   780
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   24
      ImageHeight     =   24
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   2
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacayuda.frx":0022
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacayuda.frx":0EFC
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Botones 
      Height          =   480
      Left            =   0
      TabIndex        =   4
      Top             =   -60
      Width           =   10665
      _ExtentX        =   18812
      _ExtentY        =   847
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "ACEPTAR"
            Description     =   "ACEPTAR"
            Object.ToolTipText     =   "Aceptar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdSalir"
            Description     =   "Salir"
            Object.ToolTipText     =   "Salr de la Ventana"
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
End
Attribute VB_Name = "BacAyuda"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim SW
Public TipoCliente   As Long

Private Sub Form_Activate()
   Dim Datos()
   Dim NomProc As String
   Dim Glosa   As String * 35
   Dim Rut     As String * 15
   
   lstNombre.Clear
   
   Envia = Array()
   Select Case Me.tag
      Case "Clientes"
         NomProc = "Sp_AYUDACLIENTES"
         AddParam Envia, CDbl(0)
         AddParam Envia, CDbl(0)
         AddParam Envia, CDbl(TipoCliente)
      Case "Cliente"
         NomProc = "SP_AYUDACLIENTE"
      Case "ClienteF"
         NomProc = "SP_AYUDACLIENTEF"
      Case "ClienteB"
         NomProc = "SP_AYUDACLIENTEB"
      Case "ClienteGrupo1"
         AddParam Envia, 1 'Banco
         NomProc = "SP_AYUDACLIENTEGRUPO"
      Case "ClienteGrupo2"
         AddParam Envia, 0 'NO Banco
         NomProc = "SP_AYUDACLIENTEGRUPO"
      Case "PosGrupal"
          AddParam Envia, "C"
          NomProc = "SP_MTN_GLOSA_GRUPAL_POSICION"
      Case "grupoprod"
          NomProc = "SP_CON_GRUPOPRODUCTO"
      Case "ClientesyGrupos1"
         AddParam Envia, 1 'Banco
         NomProc = "SP_AYUDACLIENTESYGRUPO" ' COG
      Case "ClientesyGrupos2"
         AddParam Envia, 2 'NO Banco
         NomProc = "SP_AYUDACLIENTESYGRUPO"  'COG
      
      Case "LINGENHELPCLI" '->> Agregado .-->> 15-06-2009
         AddParam Envia, TipoCliente
         AddParam Envia, gsBAC_User
         NomProc = "dbo.SP_AYUDA_LEE_CLIENTES"
      Case "Clientes_DRV"
        
         NomProc = "BacTraderSuda..SP_CON_CLIENTE_DERIVADOS"
         If Not Bac_Sql_Execute(NomProc, Envia) Then
            Exit Sub
         End If
         Do While Bac_SQL_Fetch(Datos())
        
            Glosa = Datos(3)
            Rut = Trim(Datos(1))
            lstNombre.AddItem (Glosa & Space(1) & Trim(Rut) & "-" & Trim(Datos(6)) & Space(60) & Format(Val(Datos(2)), "000000000") & Space(100) & Datos(6)) & Space(20) & Trim(Rut)
         Loop
         Exit Sub
            
   End Select
   
   If Not Bac_Sql_Execute(NomProc, Envia) Then
      Exit Sub
   End If
    
   Do While Bac_SQL_Fetch(Datos())
      If Datos(1) <> "ERROR" Then
         Espacio0 = 13 - Len(Datos(1))
         
         If UCase(Me.tag) = "LINGENHELPCLI" Then '->> Agregado .-->> 15-06-2009
            Glosa = Datos(3)
            Rut = Datos(1)
            lstNombre.AddItem (Glosa & Space(1) & Rut & Space(60) & Format(Val(Datos(2)), "000000000") & Space(100) & Datos(4))
         Else
         If UCase(Me.tag) = "CLIENTES" Or UCase(Me.tag) = "CLIENTE" Or UCase(Me.tag) = "LINCREGEN" Or UCase(Me.tag) = "LINCREGENB" Or UCase(Me.tag) = "LINCREGENF" Or UCase(Me.tag) = "CLIENTEF" Or UCase(Me.tag) = "CLIENTEB" Or UCase(Me.tag) = "CLIENTEGRUPO1" Or UCase(Me.tag) = "CLIENTEGRUPO2" Or UCase(Me.tag) = "CLIENTESYGRUPOS1" Or UCase(Me.tag) = "CLIENTESYGRUPOS2" Then
            Glosa = Datos(3)
            Rut = Datos(1)
            lstNombre.AddItem (Glosa & Space(1) & Rut & Space(60) & Format(Val(Datos(2)), "000000000") & Space(100) & Datos(4))
         Else
            Espacio0 = 13 - Len(Datos(1))
            lstNombre.AddItem (Datos(1) & Space(Espacio0) & Datos(2))
         End If
         End If
         If UCase(Me.tag) = UCase("Clientes_DRV") Then
            Glosa = Datos(3)
            Rut = Datos(1)
            lstNombre.AddItem (Glosa & Space(1) & Rut & Space(60) & Format(Val(Datos(2)), "000000000") & Space(100) & Datos(4))

         End If

      End If
   
   Loop

End Sub

Private Sub Botones_ButtonClick(ByVal Button As MSComctlLib.Button)
    RetornoAyuda = ""
    Select Case Button.Index
        Case 2
            If lstNombre.ListIndex = -1 Then
               giAceptar = False
               Exit Sub
            End If
                
            giAceptar = True
             If UCase(Me.tag) = UCase("Clientes_DRV") Then 'Rq_8800
                RetornoAyuda = Trim((Mid(lstNombre, 212, 10))) 'DV
                RetornoAyuda2 = Trim(Mid$(lstNombre, 112, 9)) 'Codigo
                RetornoAyuda3 = Trim(Mid(lstNombre, 1, 35)) 'Glosa
                RetornoAyuda4 = Trim((Right(lstNombre, 10)))  'Rut
            
             Else
            If UCase(Me.tag) = "LINGENHELPCLI" Then '->> Agregado .-->> 15-06-2009
               RetornoAyuda = Trim((Right(lstNombre, 10)))
               RetornoAyuda2 = Trim(Mid$(lstNombre, 112, 9))
               RetornoAyuda3 = Mid(lstNombre, 1, 35)
            Else
            If Me.tag = "Clientes" Or Me.tag = "Cliente" Or Me.tag = "LinCreGen" Or Me.tag = "LinCreGenB" Or Me.tag = "LinCreGenF" Or Me.tag = "ClienteF" Or Me.tag = "ClienteB" Or UCase(Me.tag) = "CLIENTEGRUPO1" Or UCase(Me.tag) = "CLIENTEGRUPO2" Or UCase(Me.tag) = "CLIENTESYGRUPOS1" Or UCase(Me.tag) = "CLIENTESYGRUPOS2" Then
                RetornoAyuda = Trim((Right(lstNombre, 10)))
                RetornoAyuda2 = Trim(Mid$(lstNombre, 112, 9))
                RetornoAyuda3 = Mid(lstNombre, 1, 35)
                RetornoAyuda4 = Trim((Right(lstNombre, 10)))  'PROD-10967
                '--> 2021.06.16 cvegasan nGine obtiene rut con digito verificador
                If InStr(1, lstNombre, RetornoAyuda) > 0 Then
                    gsRutDV = ""
                    gsRutDV = Mid(lstNombre, InStr(1, lstNombre, RetornoAyuda), Len(RetornoAyuda) + 2)
                End If
                '--< 2021.06.16 cvegasan nGine obtiene rut con digito verificador
            Else
                RetornoAyuda = Trim((Left(lstNombre, 5)))
            End If
            End If
            
           
             End If
            Unload Me
                       
        Case 3
            giAceptar = False
            Unload Me
    End Select
End Sub


Private Sub lstNombre_Click()
    If SW <> 1 Then
        txtNombre.Text = lstNombre
    End If
End Sub

Private Sub lstNombre_DblClick()
    Call Botones_ButtonClick(Botones.Buttons(2))
End Sub

Private Sub lstNombre_KeyPress(KeyAscii As Integer)
    
    If KeyAscii = 27 Then
         Call Botones_ButtonClick(Botones.Buttons(2))
    End If
    
    If KeyAscii = 13 Then
        Call Botones_ButtonClick(Botones.Buttons(1))
    Else
        KeyAscii = Asc(UCase(Chr(KeyAscii)))
        txtNombre.Text = ""
        SW = 1
        txtNombre.Text = UCase(Chr(KeyAscii))
        txtNombre.SetFocus
    End If
End Sub

Private Sub txtNombre_Change()
    On Error GoTo ErrorChange
    Dim nPos    As Long
    Dim sText   As String
    Dim n       As Long
    
    For n = 0 To lstNombre.ListCount - 1
        If Mid(lstNombre.List(n), Len(txtNombre.Text), 1) <> "" Then
            If Mid$(lstNombre.List(n), 1, Len(txtNombre.Text)) = txtNombre.Text Then '_
                nPos = n
                lstNombre.ListIndex = nPos
                Exit For
            End If
        End If
    Next n
  
ErrorChange:

End Sub

Private Sub txtNombre_GotFocus()
    SW = 1
    If Len(txtNombre.Text) > 45 Then
        txtNombre.Text = ""
    End If
    txtNombre.SelStart = Len(txtNombre.Text)
End Sub

Private Sub txtNombre_KeyPress(KeyAscii As Integer)
    If KeyAscii = 27 Then
        Call Botones_ButtonClick(Botones.Buttons(2))
    End If
    If KeyAscii% = vbKeyReturn Then
        Call Botones_ButtonClick(Botones.Buttons(1))
    Else
        KeyAscii% = Asc(UCase$(Chr$(KeyAscii%)))
    End If
   
    If KeyAscii = 8 Then
        If Len(txtNombre.Text) = 1 Then
            lstNombre.ListIndex = 0
        End If
    End If
End Sub

Private Sub TxtNombre_KeyUp(KEYCODE As Integer, Shift As Integer)
    If KEYCODE = vbKeyDown Or KEYCODE = vbKeyUp Then
        lstNombre.SetFocus
    End If
End Sub
Private Sub txtNombre_LostFocus()
    SW = 0
End Sub

Private Function Aceptar() As Boolean
    Unload Me
End Function

