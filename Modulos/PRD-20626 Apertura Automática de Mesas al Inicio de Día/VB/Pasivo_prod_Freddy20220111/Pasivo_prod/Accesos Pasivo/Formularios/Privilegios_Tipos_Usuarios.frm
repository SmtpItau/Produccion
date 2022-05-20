VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "threed32.ocx"
Begin VB.Form Privilegios_Tipos_Usuarios 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Privilegios Tipos de Usuarios"
   ClientHeight    =   6600
   ClientLeft      =   2640
   ClientTop       =   1980
   ClientWidth     =   8235
   ForeColor       =   &H00C0C0C0&
   Icon            =   "Privilegios_Tipos_Usuarios.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   6600
   ScaleWidth      =   8235
   Begin Threed.SSFrame Frm_Filtro 
      Height          =   735
      Left            =   30
      TabIndex        =   4
      Top             =   525
      Width           =   8190
      _Version        =   65536
      _ExtentX        =   14446
      _ExtentY        =   1296
      _StockProps     =   14
      Caption         =   "Seleccion"
      ForeColor       =   -2147483641
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Font3D          =   1
      Begin VB.ComboBox Cmb_tipo_usuario 
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
         Left            =   1305
         Style           =   2  'Dropdown List
         TabIndex        =   1
         Top             =   285
         Width           =   2565
      End
      Begin VB.ComboBox Cmb_sistema 
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
         Left            =   4890
         Style           =   2  'Dropdown List
         TabIndex        =   2
         Top             =   300
         Width           =   3195
      End
      Begin VB.Label Label1 
         Caption         =   "Tipo Usuario"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   255
         Left            =   150
         TabIndex        =   6
         Top             =   330
         Width           =   1200
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "Sistema"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   210
         Left            =   4125
         TabIndex        =   5
         Top             =   345
         Width           =   675
      End
   End
   Begin MSComctlLib.Toolbar Tool_opciones 
      Align           =   1  'Align Top
      Height          =   480
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   8235
      _ExtentX        =   14526
      _ExtentY        =   847
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "Img_opciones"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpia"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Graba"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Busca"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin Threed.SSFrame Frm_Menu 
      Height          =   5370
      Left            =   30
      TabIndex        =   7
      Top             =   1215
      Width           =   8190
      _Version        =   65536
      _ExtentX        =   14446
      _ExtentY        =   9472
      _StockProps     =   14
      Caption         =   "Selección de Menu"
      ForeColor       =   -2147483641
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Font3D          =   1
      Begin VB.ListBox List_Menu 
         Height          =   2400
         Left            =   5280
         TabIndex        =   8
         Top             =   960
         Visible         =   0   'False
         Width           =   2490
      End
      Begin MSComctlLib.TreeView Tree_Menu 
         Height          =   4995
         Left            =   120
         TabIndex        =   3
         Top             =   285
         Width           =   8025
         _ExtentX        =   14155
         _ExtentY        =   8811
         _Version        =   393217
         Indentation     =   529
         LabelEdit       =   1
         LineStyle       =   1
         Style           =   7
         Checkboxes      =   -1  'True
         Appearance      =   1
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
   End
   Begin MSComctlLib.ImageList Img_opciones 
      Left            =   6870
      Top             =   60
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   24
      ImageHeight     =   24
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   5
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Privilegios_Tipos_Usuarios.frx":2EFA
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Privilegios_Tipos_Usuarios.frx":3361
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Privilegios_Tipos_Usuarios.frx":3857
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Privilegios_Tipos_Usuarios.frx":3CEA
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Privilegios_Tipos_Usuarios.frx":41D2
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "Privilegios_Tipos_Usuarios"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim OptLocal As String
Dim Chequea As Boolean
Dim IndiceNodo As Integer

Function FUNC_GRABA_PRIVILEGIOS() As Boolean
Dim Datos()
Dim error_proc As Boolean

FUNC_GRABA_PRIVILEGIOS = False

Comando$ = "BEGIN TRANSACTION"

If Not BAC_SQL_EXECUTE(Comando$) Then Exit Function

error_proc = False

Screen.MousePointer = 11

Envia = Array("E", _
               "T", _
               Cmb_tipo_usuario.Text, _
               right(Cmb_sistema.Text, 3), _
               "", _
               "")

If Not BAC_SQL_EXECUTE("SP_GRABA_PRIVILEGIOS ", Envia) Then error_proc = True

'Debug.Print Tree_Menu.Nodes.Count

'For I% = 0 To List_Menu.ListCount - 1
For I% = 0 To Tree_Menu.Nodes.Count - 1

    If error_proc Then Exit For

    If Tree_Menu.Nodes.item(I% + 1).Checked Then

      Envia = Array("G", _
                     "T", _
                     Cmb_tipo_usuario.Text, _
                     right(Cmb_sistema.Text, 3), _
                     List_Menu.List(I%), _
                     "S")
      If Not BAC_SQL_EXECUTE("SP_GRABA_PRIVILEGIOS ", Envia) Then error_proc = True

    End If

Next I%

If error_proc Then
   Comando$ = "ROLLBACK"
Else
   Comando$ = "COMMIT"
End If

If Not BAC_SQL_EXECUTE(Comando$) Then error_proc = True

Screen.MousePointer = 0
FUNC_GRABA_PRIVILEGIOS = True

End Function

Sub PROC_CARGA_ARCHIVO()
Dim item              As String
Dim Item_Menu         As String
Dim Contador_Menu     As Integer
Dim Posicion_Menu(20) As String
Dim Indice_Menu       As String
Dim Codigo_Ascii      As Integer: Codigo_Ascii = 64

archivo_menu$ = Trim(Mid(Cmb_sistema.Text, 1, 30)) + ".MNU"

Open archivo_menu$ For Input As #1

List_Menu.Clear

Tree_Menu.Nodes.Clear

Do While Not EOF(1)

   Line Input #1, Registro$
   
   List_Menu.AddItem Trim(right(Registro$, 20))
   
   If Mid(Registro$, 1, 1) = "0" Then
   
      Codigo_Ascii = Codigo_Ascii + 1
      item = Chr(Codigo_Ascii)
      Contador_Menu = 0
      Indice_Menu = Trim(Str(Contador_Menu + 1))
         
      Tree_Menu.Nodes.Add , , item, Trim(Mid(Registro$, 2, 69))
   Else
      
      Contador_Menu = Contador_Menu + 1
      
      If Indice_Menu <> Mid(Registro$, 1, 1) Then
      
         If Val(Mid(Registro$, 1, 1)) > Val(Indice_Menu) Then
            Posicion_Menu(Val(Mid(Registro$, 1, 1))) = item
            item = Item_Menu
         Else
            item = Posicion_Menu(Val(Indice_Menu))
         End If
      
         Item_Menu = Chr(Codigo_Ascii) + item + Trim(Str(Contador_Menu))
      Else
         Item_Menu = item + Trim(Str(Contador_Menu))
      End If
  
      Tree_Menu.Nodes.Add item, tvwChild, Item_Menu, Trim(Mid(Registro$, 2, 69))
      
      Indice_Menu = Mid(Registro$, 1, 1)
            
   End If
   
Loop

Close #1

Frm_Filtro.Enabled = False
Frm_Menu.Enabled = True
Tool_opciones.Buttons(2).Enabled = True
Tool_opciones.Buttons(3).Enabled = False

End Sub

Sub PROC_CARGA_PRIVILEGIOS()
Dim Datos()


Envia = Array("T", _
               right(Cmb_sistema.Text, 3), _
               Trim(Cmb_tipo_usuario.Text) _
               )

If Not BAC_SQL_EXECUTE("SP_BUSCA_PRIVILEGIOS ", Envia) Then Exit Sub

Do While BAC_SQL_FETCH(Datos)

   For I% = 0 To List_Menu.ListCount - 1
       If Trim(Datos(1)) = List_Menu.List(I%) Then
          Tree_Menu.Nodes.item(I% + 1).Checked = True
       End If
   Next I%

Loop

End Sub

Sub PROC_CARGA_SISTEMAS(Combo As Object)
Dim Datos()


Envia = Array("S", "")

If Not BAC_SQL_EXECUTE("SP_BUSCA_ACCESO_USUARIO", Envia) Then Exit Sub

Combo.Clear

Do While BAC_SQL_FETCH(Datos)

   Combo.AddItem Datos(1) + Space(150 - Len(Datos(1))) + Datos(2)

Loop

End Sub

Sub PROC_LIMPIA()

PROC_CARGA_TIPO_USUARIO Cmb_tipo_usuario

PROC_CARGA_SISTEMAS Cmb_sistema

Frm_Filtro.Enabled = True
Frm_Menu.Enabled = False

Tool_opciones.Buttons(2).Enabled = False
Tool_opciones.Buttons(3).Enabled = True

If Cmb_sistema.ListCount > 0 Then Cmb_sistema.ListIndex = 0
If Cmb_tipo_usuario.ListCount > 0 Then Cmb_tipo_usuario.ListIndex = 0

Tree_Menu.Visible = False
Tree_Menu.Nodes.Clear
Tree_Menu.Visible = True


End Sub

Private Sub Cmb_sistema_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = 13 Then Call Tool_opciones_ButtonClick(Tool_opciones.Buttons(3))

End Sub

Private Sub Cmb_tipo_usuario_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = 13 Then Me.Cmb_sistema.SetFocus
End Sub

Private Sub Form_Activate()

   PROC_CARGA_AYUDA Me, ""
   
If Cmb_tipo_usuario.ListCount = 0 Then
   MsgBox "Debe Crear Tipos de Usuarios Antes de Asignar Privilegios.", vbExclamation
   Unload Me
   Exit Sub
End If

If Cmb_sistema.ListCount = 0 Then

   MsgBox "NO Existen Sistemas Cargados.", vbExclamation
   Unload Me
   Exit Sub
End If

   If Me.Cmb_tipo_usuario.Enabled Then
      Me.Cmb_tipo_usuario.SetFocus
   End If
   
   
End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)

   Select Case KeyAscii
   Case vbKeyLimpiar
      If Tool_opciones.Buttons(1).Enabled Then
         KeyAscii = 0
         Call Tool_opciones_ButtonClick(Tool_opciones.Buttons(1))

      End If

   Case vbKeyGrabar
      If Tool_opciones.Buttons(2).Enabled Then
         KeyAscii = 0
         Call Tool_opciones_ButtonClick(Tool_opciones.Buttons(2))

      End If

   Case vbKeyBuscar
      If Tool_opciones.Buttons(3).Enabled Then
         KeyAscii = 0
         Call Tool_opciones_ButtonClick(Tool_opciones.Buttons(3))

      End If

   Case vbKeySalir
      Unload Me

   End Select

End Sub

Private Sub Form_Load()
   OptLocal = Opt
   Me.top = 0
   Me.left = 0
   
   Call PROC_LIMPIA
   
   Me.Caption = Privilegios_Tipos_Usuarios.Caption
   Call LogAuditoria("07", OptLocal, Me.Caption, "", "")
End Sub

Private Sub Form_Unload(Cancel As Integer)
    Call LogAuditoria("08", OptLocal, Me.Caption, "", "")
End Sub


Private Sub Tool_opciones_ButtonClick(ByVal Button As MSComctlLib.Button)

If Button.Index = 2 Then

   If MsgBox("Seguro de Grabar ?", 36) <> vbYes Then Exit Sub
   
   Micro = 1
   If Not FUNC_GRABA_PRIVILEGIOS() Then
      For A = 1 To Tree_Menu.Nodes.Count
      If Tree_Menu.Nodes(A).Checked = True Then
         If Tree_Menu.Nodes.item(A).Children = 0 Then
            Call LogAuditoria("01", OptLocal, Me.Caption & "Error al eliminar- Usuario: " & Cmb_tipo_usuario.Text & " Sistema: " & right(Cmb_sistema.Text, 6) & " Opciones Menu: " & Tree_Menu.Nodes.item(A).Text, "", "")
         End If
      End If
      Next

      Micro = 0
      Exit Sub
   End If

   For A = 1 To Tree_Menu.Nodes.Count
   If Tree_Menu.Nodes(A).Checked = True Then
      If Tree_Menu.Nodes.item(A).Children = 0 Then
         Call LogAuditoria("01", OptLocal, Me.Caption, "", "Usuario: " & Cmb_tipo_usuario.Text & " Sistema: " & right(Cmb_sistema.Text, 6) & " Opciones Menu: " & Tree_Menu.Nodes.item(A).Text)
      End If
   End If
   Next A
   
   Micro = 0
End If

If Button.Index = 3 Then

   'PROC_CARGA_ARCHIVO
   
   PROC_CARGA_BACMENU
   
   PROC_CARGA_PRIVILEGIOS
   Me.Tree_Menu.SetFocus
   
   Exit Sub

End If

If Button.Index = 4 Then
  Unload Me
  Exit Sub
End If

PROC_LIMPIA
  
End Sub


Sub PROC_CARGA_BACMENU()
Dim Datos()
Dim item              As String
Dim Item_Menu         As String
'Dim contador_menu     As Integer
Dim Posicion_Menu(3000) As String
Dim Contador_Menu(3000) As Integer
Dim Indice_Menu       As String
Dim Codigo_Ascii      As Integer: Codigo_Ascii = 64
Dim Xentidad As String

Dim ElUltimoItem As String

Codigo_Ascii = 64

item = ""
Item_Menu = ""
Xentidad = Trim(right(Cmb_sistema.Text, 3))

Envia = Array("M", Xentidad)

If Not BAC_SQL_EXECUTE("SP_BUSCA_ACCESO_USUARIO ", Envia) Then Exit Sub

List_Menu.Clear

Tree_Menu.Nodes.Clear

Do While BAC_SQL_FETCH(Datos)
      
   List_Menu.AddItem Datos(2)
   
   If Val(Datos(3)) = 0 Then
   
      Codigo_Ascii = Codigo_Ascii + 1
'      If Codigo_Ascii = 67 Then
'        aa = 10
'      End If
      item = Chr(Codigo_Ascii)
      Contador_Menu(1) = 0
      Indice_Menu = "0"
      Item_Menu = ""
         
      Tree_Menu.Nodes.Add , , item, Datos(1)
   
   Else
      
      Contador_Menu(Val(Datos(3))) = Contador_Menu(Val(Datos(3))) + 1
      
      If Indice_Menu <> Val(Datos(3)) Then
         
         If Datos(3) > Val(Indice_Menu) Then
            Contador_Menu(Val(Datos(3))) = 1
            Posicion_Menu(Val(Datos(3))) = item 'ULTIMO INDICE PADRE
            item = IIf(Item_Menu = "", item, Item_Menu)
            Posicion_Menu(Val(Datos(3))) = item
         Else
            item = Posicion_Menu(Val(Datos(3)))
         End If
         If Indice_Menu = 4 Then
         End If
         Item_Menu = item + Chr(64 + Contador_Menu(Val(Datos(3))))
      Else
         Item_Menu = item + Chr(64 + Contador_Menu(Val(Datos(3))))               'Trim(Str(contador_menu))
      End If
      Tree_Menu.Nodes.Add item, tvwChild, Item_Menu, Datos(1)
      Indice_Menu = Val(Datos(3))
   End If
   
Loop

Frm_Filtro.Enabled = False
Frm_Menu.Enabled = True
Tool_opciones.Buttons(2).Enabled = True
Tool_opciones.Buttons(3).Enabled = False

End Sub


Private Sub Tree_Menu_MouseUp(Button As Integer, Shift As Integer, x As Single, Y As Single)
On Error Resume Next
   
   Dim I As Long
   For I = 1 To Tree_Menu.Nodes.Count
   
      If Tree_Menu.Nodes(I).Children > 0 And Not Tree_Menu.Nodes(I).Checked Then
      
         DesCheketNodos Tree_Menu.Nodes(I), (I), Tree_Menu.Nodes(I).Children, True
      
      End If
   
   Next
   
   If Not Chequea Then

      Tree_Menu.Nodes(IndiceNodo).Checked = False

   End If

End Sub

Private Sub Tree_Menu_NodeCheck(ByVal Node As MSComctlLib.Node)
Dim I       As Integer

On Error Resume Next

   With Tree_Menu
      
      Chequea = True
      
      If Node.Checked Then
      
         CheketNodos Node
      
      End If

      If Not Node.Checked Then
      
         DesCheketNodos Node, Node.Index, Node.Children, True
      
      End If
   
   End With

End Sub


Sub CheketNodos(Node As MSComctlLib.Node)

    Node.Parent.Checked = True
    CheketNodos Node.Parent

End Sub

Sub DesCheketNodos(Node As MSComctlLib.Node, Index As Integer, Hijos As Integer, FirsTime As Boolean)
Dim Parent As String
Dim Limite As Integer
Dim I      As Integer

   If Hijos > 0 Then

      Limite = Index + Hijos

      For Index = Index To Limite  'Node.Children
         
         If Not FirsTime Then
      
            If Parent <> Tree_Menu.Nodes.item(Index).Parent And Parent <> "" Then
               GoTo Seguir
            
            End If
            
         End If
      
         If Not FirsTime Then
      
            Parent = Tree_Menu.Nodes.item(Index).Parent
      
         Else
            
            If FirsTime Then
               On Error Resume Next
                  If Tree_Menu.Nodes.item(Index + 1).Parent = Tree_Menu.Nodes.item(Index).Parent Then
                  
                     DesCheketNodos Tree_Menu.Nodes.item(Index).Child, Index + 1, Tree_Menu.Nodes.item(Index).Children + Limite, False
               
                  End If
            
            End If
                        
         End If
      
         Tree_Menu.Nodes.item(Index).Checked = False
         
         If Tree_Menu.Nodes.item(Index).Children > 0 Then
         
            DesCheketNodos Tree_Menu.Nodes.item(Index).Child, Index + 1, Tree_Menu.Nodes.item(Index).Children, False
         
         End If
Seguir:
      Next Index

   End If
   
End Sub
