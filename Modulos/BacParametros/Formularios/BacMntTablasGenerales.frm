VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form BacMntTablasGenerales 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantenedor de Tablas"
   ClientHeight    =   4050
   ClientLeft      =   1305
   ClientTop       =   2280
   ClientWidth     =   6030
   BeginProperty Font 
      Name            =   "MS Sans Serif"
      Size            =   8.25
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   ForeColor       =   &H00C0C0C0&
   Icon            =   "BacMntTablasGenerales.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4050
   ScaleWidth      =   6030
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   6345
      Top             =   0
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   4
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMntTablasGenerales.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMntTablasGenerales.frx":075E
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMntTablasGenerales.frx":0BB2
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMntTablasGenerales.frx":0ECE
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   8
      Top             =   0
      Width           =   6030
      _ExtentX        =   10636
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Eliminar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   4
         EndProperty
      EndProperty
   End
   Begin Threed.SSPanel SSPanel2 
      Height          =   3525
      Left            =   0
      TabIndex        =   0
      Top             =   540
      Width           =   6045
      _Version        =   65536
      _ExtentX        =   10663
      _ExtentY        =   6218
      _StockProps     =   15
      Caption         =   "SSPanel2"
      BackColor       =   12632256
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin VB.Frame Fra1 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   945
         Left            =   135
         TabIndex        =   5
         Top             =   45
         Width           =   5775
         Begin VB.ComboBox Cmbtablasgenerales 
            Height          =   315
            Left            =   240
            Style           =   2  'Dropdown List
            TabIndex        =   6
            Top             =   480
            Width           =   5415
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            Caption         =   "Descripción de Tablas"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   195
            Left            =   240
            TabIndex        =   7
            Top             =   240
            Width           =   1920
         End
      End
      Begin VB.Frame Fra2 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   2415
         Left            =   135
         TabIndex        =   1
         Top             =   990
         Width           =   5775
         Begin VB.TextBox TxtGlosa 
            BackColor       =   &H80000004&
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   195
            Left            =   2880
            MaxLength       =   24
            MultiLine       =   -1  'True
            TabIndex        =   3
            Text            =   "BacMntTablasGenerales.frx":11EA
            Top             =   1200
            Visible         =   0   'False
            Width           =   1695
         End
         Begin VB.TextBox Txtcodigo 
            Alignment       =   1  'Right Justify
            BackColor       =   &H80000004&
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   285
            Left            =   1440
            MaxLength       =   9
            TabIndex        =   2
            Top             =   1800
            Visible         =   0   'False
            Width           =   1335
         End
         Begin MSFlexGridLib.MSFlexGrid Grilla 
            Height          =   2052
            Left            =   240
            TabIndex        =   4
            Top             =   240
            Width           =   5412
            _ExtentX        =   9551
            _ExtentY        =   3625
            _Version        =   393216
            BackColor       =   12632256
            BackColorFixed  =   8421376
            ForeColorFixed  =   16777215
            GridLines       =   2
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
         End
      End
   End
End
Attribute VB_Name = "BacMntTablasGenerales"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private objBuf          As Object
Private objcodtab       As Object
Private objCodigos      As Object
Private objMensajesTB   As Object

Private Sub LimpiarControles()

    Cmbtablasgenerales.Tag = "TABLA"
    Cmbtablasgenerales.ListIndex = -1
    Cmbtablasgenerales.Tag = ""
    
End Sub

Private Sub ColecGrilla()

Dim Fila As Integer
Dim Col As Integer

 
 Call HABILCONTROL(False)
 CmdSalir.Enabled = True
   
  With grilla
       
       .Redraw = False
       .Rows = 2
       
    If objCodigos.coleccion.Count >= 1 Then
                
        Call HABILCONTROL(True)
        
          For Fila = 1 To objCodigos.coleccion.Count
             
              .Row = Fila
              .ColAlignment(0) = 8
              .TextMatrix(.Row, 0) = objCodigos.coleccion(Fila).codigo
              .ColAlignment(1) = 2
              .TextMatrix(.Row, 1) = UCase$(Trim$(objCodigos.coleccion(Fila).glosa))
              .Rows = .Rows + 1
           
         Next Fila

   Else
          objCodigos.VaciarColeccion
          Call BacLimpiaGrilla(grilla)
          Call BacIniciaGrilla(40, 2, 1, 0, True, grilla)
          Call CargarParam_TB(grilla)
          .Redraw = True
          Exit Sub
 End If
   
   Call BacAgrandaGrilla(grilla, 40)
   .Enabled = True
   .Redraw = True
   .Row = 1
   .Col = 0
   .SetFocus
 
 End With
   
   
End Sub

Private Sub cmbTablasGenerales_Click()

On Error GoTo Label1

Dim ncodtab As Long

     Screen.MousePointer = 11

    If Cmbtablasgenerales.Tag = "TABLA" Then
       Exit Sub
    End If
    
    If Cmbtablasgenerales.ListIndex = -1 Then
       Call objMensajesTB.BacLeeMensaje(objMensajesTB.MSG_TGValElemento)
       Screen.MousePointer = 0
       Exit Sub
    End If
             
   ' If Trim(objcodtab.coleccion(cmbTablasGenerales.ListIndex + 1).TipMan) <> "M" Then
   '    cmdEliminar.Enabled = False
   '    cmdGrabar.Enabled = False
   '     Screen.MousePointer = 0
   '    Exit Sub
   ' End If
    
    ncodtab = objcodtab.coleccion(Cmbtablasgenerales.ListIndex + 1).codigo
    
    ' La primera vez enganche con la otra tabla con ncodtab
    
    If objCodigos.LeerCodigos(ncodtab) = False Then
       Call objMensajesTB.BacLeeMensaje(objMensajesTB.MSG_TGConeccion)
        Screen.MousePointer = 0
       Exit Sub
    End If
   
   
    Call ColecGrilla
    Call BacAgrandaGrilla(grilla, 40)
    Call EstadoGrilla(grilla)
        
     Cmbtablasgenerales.Enabled = False
     Screen.MousePointer = 0
     Exit Sub

Label1:
    Call objMensajesTB.BacMsgError

End Sub

Private Sub cmbTablasGenerales_LostFocus()

    If Cmbtablasgenerales.ListIndex <> -1 Then
       Call Habilitacontroles(True)
       Cmbtablasgenerales.Enabled = False
    End If
    
End Sub

Private Sub cmdEliminar_Click()

 'Screen.MousePointer = 11
 
    txtCodigo.Text = ""
    txtGlosa.Text = ""
    txtCodigo.Visible = False
    txtGlosa.Visible = False
    grilla.Enabled = True
   
    With grilla
    
        If .Rows > 2 Then
            If Trim$(.TextMatrix(.Row, 0)) <> "" Then
                'row = .row
                .RemoveItem .Row
                .SetFocus
                'Call EstadoGrilla(Grilla)
                Exit Sub
            End If
        End If
        
    End With
   
' Screen.MousePointer = 0
 
End Sub

Private Sub CmdGrabar_Click()

On Error GoTo Label1

Dim IdOpcion   As Integer
Dim Indice     As Integer
Dim ncodtab    As Integer

Dim Fila       As Long
Dim codig      As Long
Dim glosa      As String

    Screen.MousePointer = 11
    
    
    If Valida_Ingreso(grilla) = False Then
        txtGlosa.Visible = False
        Exit Sub
    End If
    
    
    Call objCodigos.VaciarColeccion
    Call GrillaColeccion
    
  
    Indice = Cmbtablasgenerales.ItemData(Cmbtablasgenerales.ListIndex)
    
    IdOpcion = objCodigos.grabar(Indice)
      Screen.MousePointer = 0
  
    Set objBuf = Nothing
    Select Case IdOpcion
        Case False: Call objMensajesTB.BacLeeMensaje(objMensajesTB.MSG_TGGrabar)
        Case 1: Call objMensajesTB.BacLeeMensaje(objMensajesTB.MSG_TGBegin)
        Case 2: Call objMensajesTB.BacLeeMensaje(objMensajesTB.MSG_TGBorrarRollBack)
        Case 3: Call objMensajesTB.BacLeeMensaje(objMensajesTB.MSG_TGGrabarRollback)
        Case 4: Call objMensajesTB.BacLeeMensaje(objMensajesTB.MSG_TGCommit)
        Case True:
          MsgBox "  La  Grabación  fue exitosa   ", 64, gsPARAMS_Version
          
       
    End Select

 '   ncodtab = objcodtab.coleccion(Cmbtablasgenerales.ListIndex + 1).codigo
    
  '  If objCodigos.LeerCodigos(ncodtab) = False Then
  '     Call objMensajesTB.BacLeeMensaje(objMensajesTB.MSG_TGConeccion)
  '     Exit Sub
  '  End If
    
     Call cmdlimpiar_Click
     Cmbtablasgenerales.SetFocus
     Screen.MousePointer = 0
     Exit Sub
             
Label1:
    Call objMensajesTB.BacMsgError
     Screen.MousePointer = 0
     
End Sub

Private Sub cmdlimpiar_Click()
    
    Call BacLimpiaGrilla(grilla)
    Call BacIniciaGrilla(40, 2, 1, 0, False, grilla)
    Call CargarParam_TB(grilla)
    
    Call Habilitacontroles(False)
    Cmbtablasgenerales.Enabled = True
    Call EstadoGrilla(grilla)
    txtCodigo.Text = ""
    txtGlosa.Text = ""
    txtCodigo.Visible = False
    txtGlosa.Visible = False
    grilla.Enabled = False
    
End Sub

Private Sub cmdSalir_Click()
    
    objCodigos.VaciarColeccion
    Unload Me
    
End Sub

Private Sub Habilitacontroles(Valor As Boolean)

On Error GoTo Label1

    Cmbtablasgenerales.Enabled = Valor
    cmdGrabar.Enabled = Valor
    cmdEliminar.Enabled = Valor
    cmdLimpiar.Enabled = Valor
    
Exit Sub

Label1:
      Call objMensajesTB.BacMsgError
      
End Sub

Private Sub Form_Activate()

    Call BacIniciaGrilla(40, 2, 1, 0, False, grilla)

End Sub

'Private Sub Form_KeyPress(KeyAscii As Integer)
        
 '       If KeyAscii = 13 Then
 '          SendKeys "{TAB}"
 '       End If
        
'End Sub

Private Sub Form_Load()

On Error GoTo Label1
   
    
    Call HABILCONTROL(False)
    
    Set objcodtab = New clsCodigos
    Set objCodigos = New clsCodigos
    Set objMensajesTB = New ClsMsg
   
    Call BacIniciaGrilla(40, 2, 1, 0, False, grilla)
    Call CargarParam_TB(grilla)
    Call objMensajesTB.Valores
    
    ' Primer load form es true
    If objcodtab.LeerTablas() = False Then
       Call objMensajesTB.BacLeeMensaje(objMensajesTB.MSG_TGConeccion)
       Unload Me
       Cmbtablasgenerales.Enabled = False
       Exit Sub
    End If
    
    ' Llena la list con nombres de tablas
    Call objcodtab.Coleccion2Control(Cmbtablasgenerales)
    
    Call LimpiarControles
    Call Habilitacontroles(False)
    Cmbtablasgenerales.Enabled = True
    grilla.Enabled = False
    txtCodigo.Text = ""
    txtGlosa.Text = ""
    txtCodigo.Visible = False
    txtGlosa.Visible = False
    
Exit Sub

Label1:
    Call objMensajesTB.BacMsgError
    
End Sub

Private Sub Form_Unload(Cancel As Integer)
       
    Set objcodtab = Nothing
    Set objCodigos = Nothing
    Set objMensajesTB = Nothing
    
End Sub

Public Sub HABILCONTROL(Valor As Boolean)

On Error GoTo Label1
       cmdGrabar.Enabled = Valor
       cmdEliminar.Enabled = Valor
       cmdLimpiar.Enabled = Valor
       
Exit Sub

Label1:
      Call objMensajesTB.BacMsgError
End Sub

Public Function CargarParam_TB(Grillas As Object)

     With Grillas
 
         .Enabled = True
         .Row = 0
         .RowHeight(0) = 360
         .CellFontWidth = 4         ' TAMAÑO
      
         .ColWidth(0) = 1200
         .ColWidth(1) = 3810

         .Row = 0

         .Col = 0
         .FixedAlignment(0) = 4
         .Text = "     Codigo    "
         .CellFontBold = True
         

         .Col = 1
         .FixedAlignment(1) = 4
         .Text = "      Glosa     "
         .CellFontBold = True
         
    End With

End Function

Private Sub grilla_DblClick()
 
 If Cmbtablasgenerales.ListIndex = -1 Then
   Exit Sub
 End If
    
With grilla

     If .Col = 0 Then
        Call grilla_KeyPress(13)
     End If
      
      
     If .Col = 1 Then
         Call grilla_KeyPress(13)
     End If
   
 End With
   
End Sub

Private Sub grilla_KeyPress(KeyAscii As Integer)
 
 Dim row_tem%
 
 If Cmbtablasgenerales.ListIndex = -1 Then
   Exit Sub
 End If
    
With grilla

     If .Col = 0 Then
         If .Rows - 1 = .Row Then .Rows = .Rows + 1
            If KeyAscii = 13 Or KeyAscii = 8 Then
            
              row_tem = .Row
              
              If Valida_Ingreso(grilla) = False Then
                    Exit Sub
              End If
                
               .Row = row_tem
               .Col = 0
            
            
               txtCodigo.Visible = True
               txtCodigo.Text = ""
               txtCodigo.Text = .TextMatrix(.Row, 0)
               PROC_POSICIONA_TEXTO grilla, txtCodigo
               grilla.Enabled = False
               txtCodigo.SetFocus
               'SendKeys "{end}"
               SendKeys "{RIGHT}"
         End If
     End If
      
      
  If .Col = 1 Then
            
        If KeyAscii = 8 Or KeyAscii = 13 Then
          If Trim(.TextMatrix(.Row, 0)) = "" Then
             MsgBox " Debe Ingresar primero el Codigo ", 16, gsPARAMS_Version
             .SetFocus
             Exit Sub
          End If
        End If
         
      If KeyAscii = 13 Or KeyAscii = 8 Then
         
         If .Rows - 1 = .Row Then .Rows = .Rows + 1
                
               txtGlosa.Visible = True
               txtGlosa.Text = ""
               txtGlosa.Text = .TextMatrix(.Row, 1)
               PROC_POSICIONA_TEXTO grilla, txtGlosa
               grilla.Enabled = False
               txtGlosa.SetFocus
               SendKeys "{RIGHT}"
               'SendKeys "{end}"
      End If
   
   End If
   
 End With
   
End Sub

Public Sub GrillaColeccion()
    
 Dim Fila, codig As Long
 Dim glosa    As String
 
 
With grilla
       
    For Fila = 1 To .Rows - 1
          
      Dim objBuf As New clsCodigo
          
        .Row = Fila
        .Col = 0
     
        If Val(Trim$(.TextMatrix(.Row, 0))) <> 0 Then
       
           If Trim$(.TextMatrix(.Row, 1)) <> "" Then       '- Diferente de ""
             codig = Val(Trim$(.TextMatrix(.Row, 0)))      '- tccodigo
             glosa = UCase(Trim$(.TextMatrix(.Row, 1)))    '- tcglosa
          
               With objBuf
                   .codigo = Val(codig)
                   .glosa = glosa
               End With
        
              objCodigos.coleccion.Add objBuf
       
           Set objBuf = Nothing
      
          End If
       End If
     
   Next Fila
  
End With
  
End Sub

Public Function ValidGrilla()

Dim Fila As Integer

 With grilla
  
   For Fila = 0 To .Rows - 1
      If Not (Len(.TextMatrix(.Row - 1, 0)) >= 1 And Trim$(.TextMatrix(.Row - 1, 1)) <> "") Then
       
       If .Rows > 2 Then
      
       .RemoveItem .Row
      
       End If
       
     End If
   Next Fila
   
  .Rows = .Rows + 1
  
 End With
 
      
End Function

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Index
    Case 1
            On Error GoTo Label11

Dim IdOpcion   As Integer
Dim Indice     As Integer
Dim ncodtab    As Integer

Dim Fila       As Long
Dim codig      As Long
Dim glosa      As String

    Screen.MousePointer = 11
    
    
    If Valida_Ingreso(grilla) = False Then
        txtGlosa.Visible = False
        Exit Sub
    End If
    
    
    Call objCodigos.VaciarColeccion
    Call GrillaColeccion
    
  
    Indice = Cmbtablasgenerales.ItemData(Cmbtablasgenerales.ListIndex)
    
    IdOpcion = objCodigos.grabar(Indice)
      Screen.MousePointer = 0
  
    Set objBuf = Nothing
    Select Case IdOpcion
        Case False: Call objMensajesTB.BacLeeMensaje(objMensajesTB.MSG_TGGrabar)
        Case 1: Call objMensajesTB.BacLeeMensaje(objMensajesTB.MSG_TGBegin)
        Case 2: Call objMensajesTB.BacLeeMensaje(objMensajesTB.MSG_TGBorrarRollBack)
        Case 3: Call objMensajesTB.BacLeeMensaje(objMensajesTB.MSG_TGGrabarRollback)
        Case 4: Call objMensajesTB.BacLeeMensaje(objMensajesTB.MSG_TGCommit)
        Case True:
          MsgBox "  La  Grabación  fue exitosa   ", 64, gsPARAMS_Version
          
       
    End Select

 '   ncodtab = objcodtab.coleccion(Cmbtablasgenerales.ListIndex + 1).codigo
    
  '  If objCodigos.LeerCodigos(ncodtab) = False Then
  '     Call objMensajesTB.BacLeeMensaje(objMensajesTB.MSG_TGConeccion)
  '     Exit Sub
  '  End If
    
     Call cmdlimpiar_Click
     Cmbtablasgenerales.SetFocus
     Screen.MousePointer = 0
     Exit Sub
             
Label11:
    Call objMensajesTB.BacMsgError
     Screen.MousePointer = 0
    Case 2
                txtCodigo.Text = ""
    txtGlosa.Text = ""
    txtCodigo.Visible = False
    txtGlosa.Visible = False
    grilla.Enabled = True
   
    With grilla
    
        If .Rows > 2 Then
            If Trim$(.TextMatrix(.Row, 0)) <> "" Then
                'row = .row
                .RemoveItem .Row
                .SetFocus
                'Call EstadoGrilla(Grilla)
                Exit Sub
            End If
        End If
        
    End With
    Case 3
            Call BacLimpiaGrilla(grilla)
    Call BacIniciaGrilla(40, 2, 1, 0, False, grilla)
    Call CargarParam_TB(grilla)
    
    Call Habilitacontroles(False)
    Cmbtablasgenerales.Enabled = True
    Call EstadoGrilla(grilla)
    txtCodigo.Text = ""
    txtGlosa.Text = ""
    txtCodigo.Visible = False
    txtGlosa.Visible = False
    grilla.Enabled = False
    Case 4
            objCodigos.VaciarColeccion
            Unload Me
End Select
End Sub

Private Sub txtCodigo_KeyPress(KeyAscii As Integer)
  
With grilla
    
     If KeyAscii = 13 Then
         
         If bacBuscaRepetidoGrilla(0, grilla, Val(Trim(txtCodigo.Text))) = False Then
            .TextMatrix(.Row, 0) = txtCodigo.Text
             txtCodigo.Visible = False
            .Enabled = True
            .TextMatrix(.Row, 1) = ""
            .Col = 0
            .SetFocus
             KeyAscii = 0
             Exit Sub
        End If
             
             txtCodigo.SetFocus
             
      ElseIf KeyAscii = 27 Then
             txtCodigo.Text = ""
             txtCodigo.Visible = False
             grilla.Enabled = True
            .SetFocus
             Exit Sub
     End If
     
     BacCaracterNumerico KeyAscii
     
  End With
  
End Sub

Private Sub txtGlosa_KeyPress(KeyAscii As Integer)

 With grilla
  
  KeyAscii = Asc(UCase$(Chr$(KeyAscii)))
  
     If KeyAscii = 13 Then
           .TextMatrix(.Row, .Col) = txtGlosa.Text
            txtGlosa.Text = ""
            txtGlosa.Visible = False
            .Enabled = True
           .SetFocus
      End If
   
     If KeyAscii = 27 Then
           txtGlosa.Text = ""
           txtGlosa.Visible = False
          .Enabled = True
          .SetFocus
     End If
     
  End With

End Sub

Public Function Valida_Ingreso(obj As Object) As Boolean

Dim Fila%
Valida_Ingreso = True

grilla.Enabled = True

With obj
  
    For Fila = 1 To .Rows - 1
      
      .Row = Fila
       
      If Trim$(.TextMatrix(.Row, 0)) <> "" And Trim$(.TextMatrix(.Row, 1)) = "" Then
           Screen.MousePointer = 0
           MsgBox "Falta Ingresar la Glosa a un Codigo ", 16, gsPARAMS_Version
           Valida_Ingreso = False
            .Col = 1
           .SetFocus
           Exit Function
       End If
         
   Next Fila
              
End With
        
End Function
