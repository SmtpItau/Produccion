VERSION 5.00
Begin VB.Form BacAyuda 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Ayuda de Bac Fordward"
   ClientHeight    =   4500
   ClientLeft      =   2880
   ClientTop       =   1875
   ClientWidth     =   5310
   ClipControls    =   0   'False
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4500
   ScaleWidth      =   5310
   ShowInTaskbar   =   0   'False
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
      Left            =   150
      TabIndex        =   0
      Top             =   120
      Width           =   5055
   End
   Begin VB.ListBox lstNombre 
      BeginProperty Font 
         Name            =   "Courier New"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   2940
      ItemData        =   "BACAYUDA.frx":0000
      Left            =   150
      List            =   "BACAYUDA.frx":0007
      TabIndex        =   1
      Top             =   480
      Width           =   5055
   End
   Begin VB.PictureBox Frame 
      Height          =   930
      Left            =   150
      ScaleHeight     =   870
      ScaleWidth      =   4995
      TabIndex        =   2
      Top             =   3420
      Width           =   5055
      Begin VB.PictureBox cmdCancelar 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   840
         Left            =   3840
         ScaleHeight     =   780
         ScaleWidth      =   1140
         TabIndex        =   4
         Top             =   90
         Width           =   1200
      End
      Begin VB.PictureBox cmdAceptar 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   840
         Left            =   2655
         ScaleHeight     =   780
         ScaleWidth      =   1140
         TabIndex        =   3
         Top             =   90
         Width           =   1200
      End
   End
End
Attribute VB_Name = "BacAyuda"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private objAyuda As Object
Const WM_USER = &H400
Const LB_SELECTSTRING = (WM_USER + 13)

Dim sPatron$

Public Function MDOP_LlenaGrilla()

   Dim Filas   As Long
   Dim Idcodigo As String * 11
   Dim IdNombre As String * 25 '40
   Dim Max     As Long
          
   lstNombre.Clear
    
   Max = objAyuda.coleccion.Count
    
   For Filas = 1 To Max
      Idcodigo = objAyuda.coleccion(Filas).opcodigo
      IdNombre = objAyuda.coleccion(Filas).opnombre
      lstNombre.AddItem Idcodigo & Space(3) & IdNombre
      lstNombre.ItemData(lstNombre.NewIndex) = objAyuda.coleccion(Filas).opcodigo

   Next Filas

End Function

Public Function MFCR_LlenaGrilla()

   Dim Filas   As Long
   Dim Idcodigo As Long
   Dim iddigito As String
   Dim IdNombre As String
   Dim Max     As Long
          
   lstNombre.Clear
    
   Max = objAyuda.coleccion.Count
    
   For Filas = 1 To Max
      Idcodigo = Val(objAyuda.coleccion(Filas).rut)
      iddigito = objAyuda.coleccion(Filas).dig
      IdNombre = objAyuda.coleccion(Filas).nombre
      lstNombre.AddItem Idcodigo & "-" & iddigito & Space(3) & IdNombre
      lstNombre.ItemData(lstNombre.NewIndex) = objAyuda.coleccion(Filas).rut

   Next Filas

End Function

Private Sub MDCD_LlenaGrilla()

   Dim Filas   As Long
   Dim idRut   As String * 11
   Dim IdGlosa As String * 25 '40
   Dim Max     As Long
          
   lstNombre.Clear
    
   Max = objAyuda.coleccion.Count
    
   For Filas = 1 To Max
      idRut = objAyuda.coleccion(Filas).rcrut & "-" & objAyuda.coleccion(Filas).rcdv
      IdGlosa = objAyuda.coleccion(Filas).rcnombre
      lstNombre.AddItem IdGlosa & Space(3) & idRut
      lstNombre.ItemData(lstNombre.NewIndex) = objAyuda.coleccion(Filas).rcrut

   Next Filas
    
End Sub

Private Sub MDCL_LlenaGrilla()

   Dim Filas   As Long
   Dim idRut   As String * 11
   Dim IdGlosa As String * 25 '40
   Dim Max     As Long

   lstNombre.Clear
    
   Max = objAyuda.coleccion.Count
    
   For Filas = 1 To Max
      idRut = objAyuda.coleccion(Filas).clrut & "-" & objAyuda.coleccion(Filas).cldv
      IdGlosa = objAyuda.coleccion(Filas).clnombre
      lstNombre.AddItem IdGlosa & Space(3) & idRut
      lstNombre.ItemData(lstNombre.NewIndex) = objAyuda.coleccion(Filas).clrut

   Next Filas

End Sub

Private Sub MDEM_LlenaGrilla()

   Dim Filas   As Long
   Dim idRut   As String * 11
   Dim IdGlosa As String * 25 '40
   Dim Max     As Long
          
   lstNombre.Clear
    
   Max = objAyuda.coleccion.Count
    
   For Filas = 1 To Max
      idRut = objAyuda.coleccion(Filas).emrut & "-" & objAyuda.coleccion(Filas).emdv
      IdGlosa = objAyuda.coleccion(Filas).emnombre
      lstNombre.AddItem IdGlosa & Space(3) & idRut
      lstNombre.ItemData(lstNombre.NewIndex) = objAyuda.coleccion(Filas).emrut

   Next Filas
 
End Sub

Private Sub CmdAceptar_Click()

   Dim nPos  As Long
   Dim sText As String
   Dim Indice As Integer
        
   sText = Trim$(txtNombre.Text)
   'nPos = SendMessageByString(lstNombre.hWnd, LB_SELECTSTRING, -1, sText$)
    
   If (nPos >= 0) Then
      'Toma el indice de la lista que es el mismo que la coleccion
      Indice = lstNombre.ListIndex + 1
   
      Select Case Me.Tag
      Case "MDCL"      'TABLA DE CLIENTES
         gsCodigo$ = objAyuda.coleccion(Indice).clrut
         gsDigito$ = objAyuda.coleccion(Indice).cldv
         gsDescripcion$ = objAyuda.coleccion(Indice).clnombre
         gsFax$ = objAyuda.coleccion(Indice).clfax
      '   gscodcli% = objAyuda.coleccion(Indice).clcodigo
                
      Case "MDEM"      'TABLA DE EMISORES
         gsCodigo$ = objAyuda.coleccion(Indice).emrut
         gsDigito$ = objAyuda.coleccion(Indice).emdv
         gsDescripcion$ = objAyuda.coleccion(Indice).emnombre

      Case "MDCD"      'TABLA DE DUEÑOS DE CARTERA
         gsCodigo$ = objAyuda.coleccion(Indice).rcrut
         gsDigito$ = objAyuda.coleccion(Indice).rcdv

      Case "MFMN"      'TABLA DE MONEDAS
         gsCodigo$ = objAyuda.coleccion(Indice).mncodigo ''codmon
         gsglosa$ = objAyuda.coleccion(Indice).mnglosa

      Case "MFMNMN"     'TABLA DE MONEDAS
         gsCodigo$ = objAyuda.coleccion(Indice).mncodigo ''codmon
         gsglosa$ = objAyuda.coleccion(Indice).mnglosa

      Case "MFMNMX"     'TABLA DE MONEDAS
         gsCodigo$ = objAyuda.coleccion(Indice).mncodigo ''codmon
         gsglosa$ = objAyuda.coleccion(Indice).mnglosa

      Case "MFMX"       'TABLA DE MONEDAS EXTRANJERAS
         gsCodigo$ = objAyuda.coleccion(Indice).mxcodigo ''codmon
         gsglosa$ = objAyuda.coleccion(Indice).mxglosamoneda

      Case "MFOP"       'TABLA DE OPERADORES
         gsCodigo$ = objAyuda.coleccion(Indice).opcodigo
         gsnombre$ = objAyuda.coleccion(Indice).opnombre

      Case "MFCR"       'TABLA DE CARTERAS
         gsCodigo$ = objAyuda.coleccion(Indice).rut
         gsDigito$ = objAyuda.coleccion(Indice).dig
         gsnombre$ = objAyuda.coleccion(Indice).nombre
      
      Case "MDTC"      'TABLA DE PARAMETROS
         gsCodigo$ = objAyuda.coleccion(Indice).codigo
         gsglosa$ = objAyuda.coleccion(Indice).glosa

      End Select

   Else
      txtNombre.SetFocus
      Exit Sub

   End If

   giAceptar% = True

   Unload Me
        
End Sub

Private Sub cmdCancelar_Click()

   giAceptar% = False
   Unload Me
    
End Sub

Private Sub Form_Activate()

   lstNombre.Clear

   BacControlWindows 12

   MousePointer = 11

   Select Case Trim$(Me.Tag)
   Dim a
   
   Case "MDCL"
      Set objAyuda = New clsClientes
'       objAyuda.leepornombre "a"
      Call objAyuda.LeerClientes("")
      Call MDCL_LlenaGrilla

   Case "MFMN"
      Set objAyuda = New clsMonedas
      objAyuda.LeerMonedas ("")
      Call objAyuda.Coleccion2Control(lstNombre)

   Case "MFMNME"
      Set objAyuda = New clsMonedas
      objAyuda.LeerMonedas ("")
      Call objAyuda.Coleccion2Control2(2, lstNombre)

   Case "MFMNMN"
      Set objAyuda = New clsMonedas
      objAyuda.LeerMonedas ("")
      Call objAyuda.Coleccion2Control2(6, lstNombre)

   Case "MFMX"
      Set objAyuda = New clsmonexs
      objAyuda.LeerMonedas (Val("*"))
      Call objAyuda.Coleccion2Control(lstNombre)

   Case "MFOP"
      'Set objAyuda = New clsOperador
     ' Call objAyuda.LeerOperadores("")
      'Call MDOP_LlenaGrilla
      
   Case "MDTC"
   '   Set objAyuda = New clscodtabs
   '   Call objAyuda.LeerCodigos(40)
   '   Call objAyuda.Coleccion2Control(lstNombre)
   

   Case "MFCR"
'     Set objAyuda = New clsCarters
'     Call objAyuda.LeerCartera("")
'     Call MFCR_LlenaGrilla

   End Select

   MousePointer = 0
    
End Sub

Private Sub Form_Unload(Cancel As Integer)

   Set objAyuda = Nothing

End Sub

Private Sub lstNombre_Click()

   Select Case Trim$(Me.Tag)
   Case "MDCL", "MDEM", "MDCD", "MDPC", "MDOP"
      txtNombre.Text = Mid$(lstNombre.List(lstNombre.ListIndex), 1, 25)

   Case Else
      txtNombre.Text = lstNombre.List(lstNombre.ListIndex)

   End Select

   txtNombre.Tag = txtNombre.Text

End Sub

Private Sub lstNombre_DblClick()

   txtNombre.Text = lstNombre.List(lstNombre.ListIndex)
   txtNombre.Tag = txtNombre.Text
   Call CmdAceptar_Click

End Sub

Private Sub lstNombre_KeyPress(KeyAscii As Integer)

   If KeyAscii = 13 Then
      KeyAscii = 0
      cmdAceptar.SetFocus

   End If

End Sub

Private Sub txtNombre_Change()

   Dim nPos  As Long
   Dim sText As String

   sText = Trim$(txtNombre.Text)
  'nPos = SendMessageByString(lstNombre.hWnd, LB_SELECTSTRING, -1, sText)
     
   If (nPos& < 0) Then
      sText = Trim$(txtNombre.Text)

      Select Case Trim$(Me.Tag)
      Case "MDCL"
         Set objAyuda = New clsClientes
         Call objAyuda.LeerClientes(sText)
         Call MDCL_LlenaGrilla

      Case "MFMN"
         Set objAyuda = New clsMonedas
         objAyuda.LeerMonedas ("*")
         Call objAyuda.Coleccion2Control(lstNombre)

      Case "MFMX"
         Set objAyuda = New clsmonexs
         objAyuda.LeerMonedas ("*")
         Call objAyuda.Coleccion2Control(lstNombre)

      Case "MDOP"
         'Set objAyuda = New clsOperador
         'Call objAyuda.LeerOperadores(sText)
         'Call MDCL_LlenaGrilla

      Case "MFCR"
'        Set objAyuda = New clsCarters
'        Call objAyuda.LeerCartera(sText)
'        Call MFCR_LlenaGrilla
'
      End Select

      nPos = SendMessageByString(lstNombre.hWnd, LB_SELECTSTRING, -1, sText)

   End If

   txtNombre.Tag = txtNombre.Text

End Sub

Private Sub txtNombre_GotFocus()

   txtNombre.Tag = txtNombre.Text

End Sub

Private Sub txtNombre_KeyPress(KeyAscii As Integer)

   If KeyAscii% = vbKeyReturn Then
      CmdAceptar_Click

   Else
      KeyAscii% = Asc(UCase$(Chr$(KeyAscii%)))

   End If

End Sub

