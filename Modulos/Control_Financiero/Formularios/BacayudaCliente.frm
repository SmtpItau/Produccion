VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form BacAyudaCliente 
   Caption         =   "Ayuda de Control Financiero Clientes"
   ClientHeight    =   7635
   ClientLeft      =   6705
   ClientTop       =   1440
   ClientWidth     =   13350
   ClipControls    =   0   'False
   Icon            =   "BacayudaCliente.frx":0000
   LinkTopic       =   "Form1"
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   7635
   ScaleWidth      =   13350
   StartUpPosition =   2  'CenterScreen
   Begin VB.ListBox ListClientes 
      BeginProperty Font 
         Name            =   "Courier"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   4545
      Left            =   7815
      TabIndex        =   4
      Top             =   1620
      Visible         =   0   'False
      Width           =   5445
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   4770
      Top             =   -510
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   2
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacayudaCliente.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacayudaCliente.frx":075C
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   3
      Top             =   0
      Width           =   13350
      _ExtentX        =   23548
      _ExtentY        =   794
      ButtonWidth     =   1984
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      Style           =   1
      TextAlignment   =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Aceptar"
            Key             =   "Aceptar"
            Description     =   "Aceptar"
            Object.ToolTipText     =   "Aceptar Datos"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Cancelar"
            Key             =   "Cancelar"
            Description     =   "Cancelar"
            Object.ToolTipText     =   "Cancelar"
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin VB.TextBox txtNombre 
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
      Left            =   750
      TabIndex        =   0
      Text            =   "[Ingrese texto para buscar]"
      Top             =   495
      Width           =   12510
   End
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
      Height          =   6360
      ItemData        =   "BacayudaCliente.frx":0BAE
      Left            =   45
      List            =   "BacayudaCliente.frx":0BB5
      TabIndex        =   1
      Top             =   870
      Width           =   7605
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      Caption         =   "Buscar"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000007&
      Height          =   195
      Left            =   45
      TabIndex        =   2
      Top             =   540
      Width           =   600
   End
End
Attribute VB_Name = "BacAyudaCliente"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private ObjAyudaCliente As Object
Const WM_USER = &H400
Const LB_SELECTSTRING = (WM_USER + 13)

Dim sPatron$
Public indice As Integer
Public TipoCliente   As Long


Private Sub MDCL_LlenaGrilla()
   Dim Filas   As Long
   Dim IdRut   As String * 11
   Dim IdGlosa As String * 25 '40
   Dim Max     As Long
   
   lstNombre.Clear
    
   Max = ObjAyudaCliente.coleccion.Count
    
   For Filas = 1 To Max
      IdRut = ObjAyudaCliente.coleccion(Filas).clrut & "-" & ObjAyudaCliente.coleccion(Filas).cldv
      IdGlosa = ObjAyudaCliente.coleccion(Filas).clnombre

      ListClientes.AddItem Space(14 - Len(Trim(IdRut))) & " " & Trim(IdRut) & " - " & ObjAyudaCliente.coleccion(Filas).clcodigo & Space(4) & ObjAyudaCliente.coleccion(Filas).clnombre
      ListClientes.ItemData(ListClientes.NewIndex) = ObjAyudaCliente.coleccion(Filas).clrut
      
  Next Filas
End Sub

Private Sub CmdAceptar()
   Dim nPos         As Long
   Dim sText        As String
   Dim indice       As Integer
   Dim sLine        As String
        
      If lstNombre.ListIndex < 0 Then
         If lstNombre.List(0) <> "" Then
            lstNombre.ListIndex = 0
            SendKeys "{DOWN}"
         Else
             MsgBox ("No se ha seleccionado Cliente"), vbInformation, TITSISTEMA
             Me.txtNombre.SetFocus
             Exit Sub
         End If
      
      End If
 
    nPos = lstNombre.ItemData(lstNombre.ListIndex)
    Call ObjAyudaCliente.BuscarColeccion(nPos, gsCodigo, gsCodCli, gsDigito, gsDescripcion)

    giAceptar = True
    Call Unload(Me)
Exit Sub
    
    nPos = lstNombre.ListIndex
   ' --------------------------------------
    If (nPos >= 0) And lstNombre.ListCount - 1 >= 0 Then
        indice = lstNombre.ListIndex + 1
'        gsCodigo$ = Mid(Me.lstNombre.List(nPos), 4, 12)
'        gsCodCli% = Mid(Me.lstNombre.List(nPos), 19, 2)
'
        ' gsCodigo$ = ObjAyudaCliente.coleccion(nPos).clrut
        ' gsDigito$ = ObjAyudaCliente.coleccion(Indice).cldv
        ' gsDescripcion$ = objAyuda.coleccion(Indice).clnombre
        ' gsFax$ = objAyuda.coleccion(Indice).clfax
        ' gscodcli% = objAyuda.coleccion(indice).clcodigo
        ' gsDireccion = objAyuda.coleccion(Indice).cldirecc
        ' gsFono = objAyuda.coleccion(Indice).clfono
        ' gsnotaria = objAyuda.coleccion(Indice).clnotaria
        ' gsfecha_escritura = objAyuda.coleccion(Indice).clfecha_escritura
    Else
        SendKeys "{DOWN}"
        Exit Sub
    End If
    
    giAceptar = True
    Call Unload(Me)
End Sub

Private Sub Form_Activate()
   Dim Datos()
   Dim NomProc As String
   Dim Glosa   As String * 35
   Dim Rut     As String * 15
   Dim Espacio0 As Integer
   
   lstNombre.Clear
   
   Envia = Array()
   Select Case Me.Tag
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
         
         If UCase(Me.Tag) = "LINGENHELPCLI" Then '->> Agregado .-->> 15-06-2009
            Glosa = Datos(3)
            Rut = Datos(1)
            lstNombre.AddItem (Glosa & Space(1) & Rut & Space(60) & Format(Val(Datos(2)), "000000000") & Space(100) & Datos(4))
         Else
         If UCase(Me.Tag) = "CLIENTES" Or UCase(Me.Tag) = "CLIENTE" Or UCase(Me.Tag) = "LINCREGEN" Or UCase(Me.Tag) = "LINCREGENB" Or UCase(Me.Tag) = "LINCREGENF" Or UCase(Me.Tag) = "CLIENTEF" Or UCase(Me.Tag) = "CLIENTEB" Or UCase(Me.Tag) = "CLIENTEGRUPO1" Or UCase(Me.Tag) = "CLIENTEGRUPO2" Or UCase(Me.Tag) = "CLIENTESYGRUPOS1" Or UCase(Me.Tag) = "CLIENTESYGRUPOS2" Then
            Glosa = Datos(3)
            Rut = Datos(1)
            lstNombre.AddItem (Glosa & Space(1) & Rut & Space(60) & Format(Val(Datos(2)), "000000000") & Space(100) & Datos(4))
         Else
            Espacio0 = 13 - Len(Datos(1))
            lstNombre.AddItem (Datos(1) & Space(Espacio0) & Datos(2))
         End If
         End If
         If UCase(Me.Tag) = UCase("Clientes_DRV") Then
            Glosa = Datos(3)
            Rut = Datos(1)
            lstNombre.AddItem (Glosa & Space(1) & Rut & Space(60) & Format(Val(Datos(2)), "000000000") & Space(100) & Datos(4))

         End If
      
      End If
   
   Loop

End Sub

Private Sub Form_Load()
   'Me.ListClientes.Visible = False
    
    Let Screen.MousePointer = vbHourglass

    Set ObjAyudaCliente = New ClsAyudaCliente

    Call lstNombre.Clear
    'ARM Se agrega filtro para diferenciar Instituciones de Clientes
    If TipoCliente = 1 Then
       Call ObjAyudaCliente.LeerClientes_Inst("a", ListClientes, lstNombre)
    Else
    Call ObjAyudaCliente.LeerClientes("a", ListClientes, lstNombre)
    End If

    Let Screen.MousePointer = vbDefault
End Sub

Private Sub Form_Resize()
    On Error Resume Next
    lstNombre.Width = Me.Width - 350
    lstNombre.Height = Me.Height - 1650
    
    txtNombre.Width = lstNombre.Width - 730
    On Error GoTo 0
End Sub

Private Sub Form_Unload(Cancel As Integer)
   Set ObjAyudaCliente = Nothing
End Sub

Private Sub lstNombre_DblClick()
   Call CmdAceptar
End Sub


Private Sub lstNombre_KeyPress(KeyAscii As Integer)
   If KeyAscii = vbKeyReturn Then
      Call CmdAceptar
   End If
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
    Select Case Button.Index
        Case 1          '"Aceptar"
            Call CmdAceptar
        Case 2          '"Cancelar"
            giAceptar = False
            Call Unload(Me)
    End Select
End Sub

Private Sub txtNombre_Change()
    Dim nPos            As Long
    Dim sText           As String
    Dim nContador       As Long
    Dim oEncontro       As Boolean

    sText = txtNombre.Text

    If Len(sText) = 0 Then
        GoSub BUSCAR
    
    ElseIf Len(sText) >= 1 Then
        'If Mid(Trim(txtNombre.Text), 1, 1) = Mid(Trim(Me.ListClientes.List(1)), 1, 1) Then
            'lstNombre.ListIndex = 1
        'Else
            sText = txtNombre.Text
            GoSub BUSCAR
        'End If
        
    ElseIf Len(sText) > 1 Then
      Let oEncontro = False
        For nPos = 0 To lstNombre.ListCount - 1
            If sText = Left(lstNombre.List(nPos), Len(sText)) Then
                lstNombre.ListIndex = nPos
                lstNombre.TopIndex = nPos
            Let oEncontro = True
                Exit For
            End If
        Next nPos
   
      If oEncontro = False Then
         sText = txtNombre.Text
         GoSub BUSCAR
      End If
    End If
   
Exit Sub

BUSCAR:

'  Set ObjAyudaCliente = New ClsAyudaCliente
    
    Call BuscaCadena(sText, "")
    
    Return
End Sub

Private Sub txtNombre_GotFocus()
    txtNombre.Tag = txtNombre.Text
    txtNombre.Text = ""
End Sub

Private Sub txtNombre_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = vbKeyDown Or KeyCode = vbKeyUp Then
        lstNombre.SetFocus
        If KeyCode = vbKeyDown Then
            SendKeys "{DOWN}"
        Else
            SendKeys "{UP}"
        End If
    End If
End Sub

Private Sub txtNombre_KeyPress(KeyAscii As Integer)

   If KeyAscii% = vbKeyReturn Then
        Call CmdAceptar

   Else
      KeyAscii% = Asc(UCase$(Chr$(KeyAscii%)))

   End If

End Sub

Public Function BuscaCadena(texto As String, busqueda As String) As Boolean
    Dim busca               As String
    Dim i                   As Integer
    Dim totalregistros      As Integer
    Dim cadena              As String

    totalregistros = Me.ListClientes.ListCount
   
    Call lstNombre.Clear
   
    For i = 0 To totalregistros
        cadena = InStr(1, Me.ListClientes.List(i), texto)
        
        If cadena <> 0 Then
            lstNombre.AddItem Me.ListClientes.List(i)
            lstNombre.ItemData(lstNombre.NewIndex) = ListClientes.ItemData(i)
        End If
    Next i
End Function
