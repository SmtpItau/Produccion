VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form BacMntTasasMercado 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Mantenedor Valor Tasas de Mercado"
   ClientHeight    =   5010
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   6630
   Icon            =   "BacMntTasasMercado.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   5010
   ScaleWidth      =   6630
   ShowInTaskbar   =   0   'False
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   6120
      Top             =   45
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
            Picture         =   "BacMntTasasMercado.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMntTasasMercado.frx":0626
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMntTasasMercado.frx":0942
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMntTasasMercado.frx":0AA6
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMntTasasMercado.frx":0DC2
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   6
      Top             =   0
      Width           =   6630
      _ExtentX        =   11695
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   5
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Actualizar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Insertar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Refresh"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   5
         EndProperty
      EndProperty
   End
   Begin Threed.SSPanel SSPanel1 
      Height          =   4515
      Left            =   45
      TabIndex        =   0
      Top             =   495
      Width           =   6585
      _Version        =   65536
      _ExtentX        =   11615
      _ExtentY        =   7964
      _StockProps     =   15
      BackColor       =   12632256
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin VB.Frame Frame2 
         Height          =   1575
         Left            =   90
         TabIndex        =   8
         Top             =   45
         Width           =   6375
         Begin VB.TextBox Txtglosatasa 
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   315
            Left            =   2145
            TabIndex        =   4
            Top             =   1080
            Width           =   3975
         End
         Begin VB.TextBox TxtGlosamon 
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   315
            Left            =   2145
            TabIndex        =   2
            Top             =   480
            Width           =   3975
         End
         Begin VB.TextBox TxtCodTasa 
            Alignment       =   1  'Right Justify
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   315
            Left            =   225
            MaxLength       =   5
            MouseIcon       =   "BacMntTasasMercado.frx":10DE
            MousePointer    =   99  'Custom
            TabIndex        =   3
            Top             =   1080
            Width           =   1095
         End
         Begin VB.TextBox TxtCodMoneda 
            Alignment       =   1  'Right Justify
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   315
            Left            =   225
            MaxLength       =   5
            MouseIcon       =   "BacMntTasasMercado.frx":13E8
            MousePointer    =   99  'Custom
            TabIndex        =   1
            Top             =   480
            Width           =   1095
         End
         Begin VB.Label Label4 
            AutoSize        =   -1  'True
            Caption         =   "Nombre Tasa"
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
            Left            =   2220
            TabIndex        =   12
            Top             =   840
            Width           =   1140
         End
         Begin VB.Label Label3 
            AutoSize        =   -1  'True
            Caption         =   "Nombre  Moneda"
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
            Left            =   2220
            TabIndex        =   11
            Top             =   240
            Width           =   1455
         End
         Begin VB.Label Label2 
            AutoSize        =   -1  'True
            Caption         =   "Cod.Tasa"
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
            Left            =   225
            TabIndex        =   10
            Top             =   840
            Width           =   825
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "Cod. Moneda"
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
            Left            =   225
            TabIndex        =   9
            Top             =   240
            Width           =   1140
         End
      End
      Begin VB.Frame Frame1 
         Height          =   2775
         Left            =   90
         TabIndex        =   7
         Top             =   1620
         Width           =   6375
         Begin MSFlexGridLib.MSFlexGrid grilla 
            Height          =   2415
            Left            =   180
            TabIndex        =   5
            Top             =   225
            Width           =   6015
            _ExtentX        =   10610
            _ExtentY        =   4260
            _Version        =   393216
            FixedCols       =   0
            BackColor       =   12632256
            BackColorFixed  =   8421376
            ForeColorFixed  =   16777215
            GridLines       =   2
         End
         Begin VB.Image Image1 
            Height          =   375
            Left            =   2400
            Top             =   2250
            Width           =   735
         End
      End
   End
End
Attribute VB_Name = "BacMntTasasMercado"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim oka, Existe, VarSele    As Boolean

Public gDias_Antes          As Integer
Public gDias_Despues        As Long
Public objTasa              As New clsTasaMercado

Private objMoneda   As New clsMoneda
Private objCodigo   As New clsCodigo 'PENDIENTE
Private Sub cmdActualizar_Click()

Dim TotFilas&

With grilla

    If Val(.TextMatrix(.RowSel, 1)) <= 0 Then
        Exit Sub
    End If
    
    .Row = .RowSel
                     
    If Not IsNumeric(.TextMatrix(.Row, 1)) Then
        MsgBox "ERROR : Debe Seleccionar Periodo CLICK ", 16, gsPARAMS_Version
        Exit Sub
    End If
            
    Screen.MousePointer = 11
    
    objTasa.CodMoneda = txtCodMoneda.Text
    objTasa.CodTasa = txtCodTasa.Text
    objTasa.Dias = .TextMatrix(.Row, 1)
    objTasa.Bid = .TextMatrix(.Row, 2)
    objTasa.Offer = .TextMatrix(.Row, 3)
    objTasa.Tasa = .TextMatrix(.Row, 4)
    objTasa.BaseOri = .TextMatrix(.Row, 5)
    objTasa.BaseConv = .TextMatrix(.Row, 6)
    objTasa.TasaFinal = .TextMatrix(.Row, 7)
    objTasa.TasaZcr = .TextMatrix(.Row, 8)
    
    Ingreso_TasasMercado.Tag = "ACTUALIZAR"
    Ingreso_TasasMercado.Show 1
    
    Call cmdRefresh_Click
    Call EstadoGrilla(grilla)
    .SetFocus
    
End With
    
    Screen.MousePointer = 0
    
End Sub
Private Sub CmdInserta_Click()
Dim Row&
'Dim objTasa As clsTasaMercado

With grilla
    
    If Existe And VarSele Then
        MsgBox "ERROR : Debe Seleccionar Periodo CLICK ", 16, gsPARAMS_Version
        Exit Sub
    End If
    
    Screen.MousePointer = 11
    
    objTasa.Limpiar
    objTasa.CodMoneda = txtCodMoneda.Text
    objTasa.CodTasa = txtCodTasa.Text
    objTasa.Bid = 0
    objTasa.Offer = 0
    objTasa.Tasa = 0
    objTasa.BaseOri = 360
    objTasa.BaseConv = 360
    objTasa.TasaFinal = 0
    objTasa.TasaZcr = 0

    If Existe Then
        If .Rows - 1 = 1 Then                    '- Un Registro
            .Row = 1
            gDias_Antes = -1
            gDias_Despues = 10000
        Else
            gDias_Antes = .TextMatrix(.Row - 1, 1)
            If Not IsNumeric(.TextMatrix(.Row - 1, 1)) Then
                gDias_Antes = -1
            End If
            If .Rows - 1 = .Row Then
                gDias_Despues = 10000
            Else
                gDias_Despues = .TextMatrix(.Row + 1, 1)
                If Not IsNumeric(.TextMatrix(.Row + 1, 1)) Then
                    gDias_Despues = 10000
                End If
            End If
        End If
     
        objTasa.Dias = .TextMatrix(.Row, 1)
                
    Else        '---- NO EXISTE (AGREGO)
        gDias_Antes = -1
        gDias_Despues = 10000
        objTasa.Dias = 0
    End If
                 
    Ingreso_TasasMercado.Tag = "INSERTA"
    Ingreso_TasasMercado.Show 1

    Call cmdRefresh_Click
    Call EstadoGrilla(grilla)
    .SetFocus
    
End With

VarSele = False

Screen.MousePointer = 0

End Sub
Private Sub cmdlimpiar_Click()
    
   Screen.MousePointer = 11
   
    Call LimpiarTodo
   
    Call BacLimpiaGrilla(grilla)
    Call BacIniciaGrilla(2, 9, 1, 0, True, grilla)
    Call Habilitar(False)
    'grilla.Enabled = True
    Call BacAgrandaGrilla(grilla, 40)
    txtCodMoneda.SetFocus
    
 Screen.MousePointer = 0
 
End Sub
Private Sub cmdRefresh_Click()

Screen.MousePointer = 11

    If BuscarMoneda(txtCodMoneda.Text) And BuscarTasa(txtCodTasa.Text) Then
    
        Screen.MousePointer = 11
        
        If Not LeerTasas(txtCodMoneda.Text, txtCodTasa.Text) Then
            Toolbar1.Buttons(1).Enabled = False
            Screen.MousePointer = 0
            MsgBox "ERROR : DE LECTURA  ", 16, gsPARAMS_Version
        Else
            Toolbar1.Buttons(1).Enabled = True
        End If
    
    End If
    
    Screen.MousePointer = 0
    
End Sub

Private Sub cmdSalir_Click()

  Unload Me

End Sub

Private Sub Form_Activate()

  '  Call bacIniciaGrilla(2, 9, 1, 0, False, grilla)
    Call CargarParam_Tasas(grilla)
    
End Sub

Private Sub Form_Load()

  
    'Call BacLimpiaGrilla(Grilla)
    Call BacIniciaGrilla(10, 9, 1, 0, False, grilla)
    Call CargarParam_Tasas(grilla)
    
    Call Habilitar(False)
     
     oka = False
    
    TxtGlosaMon.Enabled = False
    TxtGlosaTasa.Enabled = False
    Toolbar1.Buttons(5).Enabled = True
    txtCodMoneda.Enabled = True
        
End Sub

Public Function CargarParam_Tasas(Grillas As Object)

 With Grillas
 
        .Enabled = True
        .Row = 0
        .RowHeight(0) = 375
        .CellFontWidth = 4         ' TAMAÑO
        
        .ColWidth(0) = 1
        .TextMatrix(0, 0) = " "
        .ColWidth(0) = TextWidth(.TextMatrix(0, 0))
        '.ColWidth(0) = 240
        
        .ColWidth(1) = 1000
        .ColWidth(2) = 2000
        .ColWidth(3) = 2000
        .ColWidth(4) = 2000
        .ColWidth(5) = 900
        .ColWidth(6) = 900
        .ColWidth(7) = 2100
        .ColWidth(8) = 2100
        
        
        .Row = 0
        '.CellFontBold = True       'RESALSE
        '.Text = " "
        .FixedAlignment(1) = 4

        .Col = 1
        .CellFontBold = True       'RESALSE
        .Text = " Dias "
        .FixedAlignment(1) = 4
        
        .Col = 2
        .CellFontBold = True       'RESALSE
        .FixedAlignment(2) = 4
        .Text = " Bid   "

        .Col = 3
        .CellFontBold = True       'RESALSE
        .FixedAlignment(3) = 4
        .Text = "  Offer "
    
        .Col = 4
        .CellFontBold = True       'RESALSE
        .FixedAlignment(4) = 4
        .Text = " Tasa "
    
        .Col = 5
        .CellFontBold = True       'RESALSE
        .FixedAlignment(5) = 4
        .Text = " Original "
        
        .Col = 6
        .CellFontBold = True       'RESALSE
        .FixedAlignment(6) = 4
        .Text = " Conv. "
            
        .Col = 7
        .CellFontBold = True       'RESALSE
        .FixedAlignment(7) = 4
        .Text = " Tasa Final "
            
        .Col = 8
        .CellFontBold = True       'RESALSE
        .FixedAlignment(8) = 4
        .Text = " Tasa ZCR "
        
        If .Rows >= 2 Then
         .Col = 1
         .Row = 1
        '.SetFocus
       End If
       
End With

End Function

Private Sub grilla_Click()

 With grilla
     
    VarSele = True
    
    .Row = .RowSel
    
    .Col = 0
    .ColSel = .Cols - 1
    
    Toolbar1.Buttons(1).Enabled = (Val(.TextMatrix(.Row, 1)) > 0)
    
 End With

End Sub

Private Sub grilla_DblClick()

 With grilla
     
'
'If .CellPicture = 0 Then
'
'
''   .RowHeight(.Row) = 375
'  '.ColWidth(0) = 240
'
'  .RowHeight(.Row) = Imagen.Height
'  .ColWidth(0) = Imagen.Width
'  .CellPictureAlignment = flexAlignCenterCenter
'
'
'     Set .CellPicture = Imagen.Picture
'
'   Else
'        Set .CellPicture = LoadPicture()
'  End If
'
'
     End With
     

End Sub

Private Sub grilla_KeyPress(KeyAscii As Integer)

  With grilla
         
       ' .Col = 0
       '.ColSel = .Cols - 1
      
   '      .ColAlignment(.Col) = 8
         
   '  If .Col = 0 Or .Col = 4 Or .Col = 5 Then
     
   '     Call PROC_KEYGRILLA_NUM(grilla, KeyAscii, 3)
        
   '     If .Col = 0 Then
   '        If .Rows - 1 = .Row Then
   '          .Rows = .Rows + 1
   '        End If
   '     End If
     
   ' ElseIf .Col = 1 Or .Col = 2 Then
   '     MaskGlobal = "###" & gsc_PuntoDecim & "######"   '- 3.6
   '     Call PROC_KEYGRILLA_MASK(grilla, KeyAscii, Trim$(MaskGlobal), gsc_PuntoDecim)
   '  End If
    
  End With
    
End Sub


Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Index
    Case 1
        Dim TotFilas&
    
        With grilla
    
        If Val(.TextMatrix(.RowSel, 1)) <= 0 Then
            Exit Sub
        End If
        
        .Row = .RowSel
                         
        If Not IsNumeric(.TextMatrix(.Row, 1)) Then
            MsgBox "ERROR : Debe Seleccionar Periodo CLICK ", 16, gsPARAMS_Version
            Exit Sub
        End If
                
        Screen.MousePointer = 11
        
        objTasa.CodMoneda = txtCodMoneda.Text
        objTasa.CodTasa = txtCodTasa.Text
        objTasa.Dias = .TextMatrix(.Row, 1)
        objTasa.Bid = .TextMatrix(.Row, 2)
        objTasa.Offer = .TextMatrix(.Row, 3)
        objTasa.Tasa = .TextMatrix(.Row, 4)
        objTasa.BaseOri = .TextMatrix(.Row, 5)
        objTasa.BaseConv = .TextMatrix(.Row, 6)
        objTasa.TasaFinal = .TextMatrix(.Row, 7)
        objTasa.TasaZcr = .TextMatrix(.Row, 8)
        
        Ingreso_TasasMercado.Tag = "ACTUALIZAR"
        Ingreso_TasasMercado.Show 1
        
        Call cmdRefresh_Click
        Call EstadoGrilla(grilla)
        .SetFocus
        End With
    Case 2
        Dim Row&
            'Dim objTasa As clsTasaMercado
            
            With grilla
                
                If Existe And VarSele Then
                    MsgBox "ERROR : Debe Seleccionar Periodo CLICK ", 16, gsPARAMS_Version
                    Exit Sub
                End If
                
                Screen.MousePointer = 11
                
                objTasa.Limpiar
                objTasa.CodMoneda = txtCodMoneda.Text
                objTasa.CodTasa = txtCodTasa.Text
                objTasa.Bid = 0
                objTasa.Offer = 0
                objTasa.Tasa = 0
                objTasa.BaseOri = 360
                objTasa.BaseConv = 360
                objTasa.TasaFinal = 0
                objTasa.TasaZcr = 0
            
                If Existe Then
                    If .Rows - 1 = 1 Then                    '- Un Registro
                        .Row = 1
                        gDias_Antes = -1
                        gDias_Despues = 10000
                    Else
                        gDias_Antes = .TextMatrix(.Row - 1, 1)
                        If Not IsNumeric(.TextMatrix(.Row - 1, 1)) Then
                            gDias_Antes = -1
                        End If
                        If .Rows - 1 = .Row Then
                            gDias_Despues = 10000
                        Else
                            gDias_Despues = .TextMatrix(.Row + 1, 1)
                            If Not IsNumeric(.TextMatrix(.Row + 1, 1)) Then
                                gDias_Despues = 10000
                            End If
                        End If
                    End If
                 
                    objTasa.Dias = .TextMatrix(.Row, 1)
                            
                Else        '---- NO EXISTE (AGREGO)
                    gDias_Antes = -1
                    gDias_Despues = 10000
                    objTasa.Dias = 0
                End If
                             
                Ingreso_TasasMercado.Tag = "INSERTA"
                Ingreso_TasasMercado.Show 1
            
                Call cmdRefresh_Click
                Call EstadoGrilla(grilla)
                .SetFocus
                End With
    Case 3
            Screen.MousePointer = 11
    
        If BuscarMoneda(txtCodMoneda.Text) And BuscarTasa(txtCodTasa.Text) Then
        
            Screen.MousePointer = 11
            
            If Not LeerTasas(txtCodMoneda.Text, txtCodTasa.Text) Then
                Toolbar1.Buttons(1).Enabled = False
                Screen.MousePointer = 0
                MsgBox "ERROR : DE LECTURA  ", 16, gsPARAMS_Version
            Else
                Toolbar1.Buttons(1).Enabled = True
            End If
        
        End If
        
        Screen.MousePointer = 0
    Case 4
         Screen.MousePointer = 11
         Call LimpiarTodo
   
           Call BacLimpiaGrilla(grilla)
           Call BacIniciaGrilla(2, 9, 1, 0, True, grilla)
           Call Habilitar(False)
           'grilla.Enabled = True
           Call BacAgrandaGrilla(grilla, 40)
           txtCodMoneda.SetFocus
           
        Screen.MousePointer = 0
    Case 5
        Unload Me
End Select
End Sub

Private Sub TxtCodMoneda_DblClick()
      
    BacAyuda.Tag = "MDMN_U"
    BacAyuda.Show 1
    
    If giAceptar% = True Then
    
         txtCodMoneda.Text = gsCodigo
         TxtGlosaMon.Text = gsDescripcion
         txtCodMoneda.SetFocus
         SendKeys "{ENTER}"
         
    End If
    
End Sub

Private Sub TxtCodMoneda_KeyPress(KeyAscii As Integer)

    BacSoloNumeros KeyAscii
   
    If KeyAscii = 13 And Trim$(txtCodMoneda.Text) <> "" Then
       
       KeyAscii = 0
       
       If BuscarMoneda(txtCodMoneda.Text) = True Then
          txtCodMoneda.SetFocus
          SendKeys "{TAB}"
       Else
          Call cmdlimpiar_Click
          txtCodMoneda.Text = ""
          txtCodMoneda.SetFocus
       End If
          
   End If
     
End Sub

Private Sub TxtCodTasa_DblClick()
       
    BacAyuda.Tag = "MDTC_TASASMERCADO"
    BacAyuda.Show 1
    
    If giAceptar% = True Then
        
        txtCodTasa.Text = gsCodigo$
        TxtGlosaTasa.Text = gsGlosa$
        txtCodTasa.SetFocus
        SendKeys "{ENTER}"
    
    End If
   
End Sub
Public Function LimpiarTodo()

    txtCodMoneda.Text = ""
    txtCodTasa.Text = ""
    TxtGlosaMon.Text = ""
    TxtGlosaTasa.Text = ""
    
End Function
Public Function Habilitar(Valor As Boolean)

    Toolbar1.Buttons(1).Enabled = Valor
    Toolbar1.Buttons(2).Enabled = Valor
    Toolbar1.Buttons(3).Enabled = Valor
    Toolbar1.Buttons(4).Enabled = Valor
    

End Function

Public Function BuscarMoneda(CodMon As String) As Boolean
   
    BuscarMoneda = objMoneda.LeerxCodigo(Val(CodMon))
   
    If BuscarMoneda Then
        TxtGlosaMon.Text = objMoneda.mnglosa
    End If
            
 End Function

Private Sub TxtCodTasa_KeyPress(KeyAscii As Integer)
 
 Dim Paso As String
 Dim Pasos As String
 
 If Trim$(txtCodMoneda.Text) = "" Then
  '  MsgBox " Debe Ingresar Codigo - Moneda ", 16, gsPARAMS_Version
    Exit Sub
 End If
 
 BacSoloNumeros KeyAscii
   
    If KeyAscii = 13 And Trim$(txtCodTasa.Text) <> "" Then
       
       If BuscarMoneda(txtCodMoneda.Text) = False Or BuscarTasa(txtCodTasa.Text) = False Then
             Paso = txtCodMoneda.Text
             Pasos = TxtGlosaMon.Text
             Call cmdlimpiar_Click
             txtCodMoneda.Text = Paso
             TxtGlosaMon.Text = Pasos
             txtCodTasa.Text = ""
             txtCodTasa.SetFocus
             oka = False
             Exit Sub
      End If
       
       oka = True
       Call Habilitar(True)
       grilla.SetFocus
      
    End If
     
End Sub
Public Function BuscarTasa(CodTasa As String) As Boolean
  
    BuscarTasa = objCodigo.Leer(MDTC_MTM, Val(CodTasa))
   
    If BuscarTasa Then
        TxtGlosaTasa.Text = objCodigo.glosa
    End If
            
 End Function

Public Function LeerTasas(CodMoneda As String, CodTasa As String) As Boolean
Dim i%
  
    grilla.Redraw = False
    
    Call BacLimpiaGrilla(grilla)
    Call BacIniciaGrilla(2, 9, 1, 1, True, grilla)
        
    For i = 1 To grilla.Cols - 1
        grilla.ColAlignment(i) = 8 ' DERECHA
    Next i
    
    LeerTasas = objTasa.CargaObjetos(grilla, 1, Val(CodMoneda), Val(CodTasa), 0, CStr(gsbac_fecp))
        
    'Grilla.ColWidth(0) = 0
    For i = 1 To grilla.Rows - 1
        grilla.RowHeight(i) = 245
    Next i
    
    grilla.Redraw = True
    Call BacAgrandaGrilla(grilla, 40)
              
    LeerTasas = True
          
End Function
Private Sub TxtCodTasa_LostFocus()

    If Not oka Then
        Exit Sub
    End If
   
    Screen.MousePointer = 11

    If Not LeerTasas(txtCodMoneda.Text, txtCodTasa.Text) Then
        Screen.MousePointer = 0
        MsgBox "ERROR : DE LECTURA  ", 16, gsPARAMS_Version
    Else
        Toolbar1.Buttons(1).Enabled = Existe
        Call BacAgrandaGrilla(grilla, 40)
        
    End If
        
    Screen.MousePointer = 0

End Sub

Public Function GrabarTasas(Sistema As String, CodMon As String, CodTasa As String) As Boolean

'Dim Datos()
'Dim SQL As String
'Dim FILA As Integer
'Dim Fecha As String
'
'    GrabarTasas = False
'
'    Call GrillaValid(grilla)
'
'With grilla
'
'    For FILA = 1 To .Rows - 1
'
'    .Row = FILA
'    SQL = ""
'    SQL = giSQL_DatabaseCommon
'    SQL = SQL & "..Sp_GrabarTasas "
'    'SQL = SQL & Sistema
'    SQL = SQL & Val(CodTasa)                                   '-  Cod Tasa
'    SQL = SQL & "," & Val(codMon)                              '-  Cod Mon
'    SQL = SQL & "," & FUNC_ISNUM_GRILLA(.TextMatrix(FILA, 1))  '-  Desde
'    SQL = SQL & "," & "0"                                      '-  Hasta
'    SQL = SQL & "," & FUNC_ISNUM_GRILLA(.TextMatrix(FILA, 2))  '-  Bid
'    SQL = SQL & "," & FUNC_ISNUM_GRILLA(.TextMatrix(FILA, 3))  '-  Offer
'    SQL = SQL & "," & FUNC_ISNUM_GRILLA(.TextMatrix(FILA, 4))  '-  Tasa
'    SQL = SQL & "," & "0"                                      '-  Spread
'    SQL = SQL & "," & FUNC_ISNUM_GRILLA(.TextMatrix(FILA, 7))  '-  Tasa final
'    SQL = SQL & "," & FUNC_ISNUM_GRILLA(.TextMatrix(FILA, 8))  '-  Tasazcr
'    SQL = SQL & "," & FUNC_ISNUM_GRILLA(.TextMatrix(FILA, 5))  '-  Base
'    SQL = SQL & "," & FUNC_ISNUM_GRILLA(.TextMatrix(FILA, 6))  '-  Basecomun
'    SQL = SQL & ",'" & FUCT_RETORNAFECHA(gsBAC_Fecp, "yyyymmdd") & "'" '-  Fecha
'    SQL = SQL & "," & gsPARAMS_Version      '-  Usuario
'
'
'            If Val(FUNC_ISNUM_GRILLA(.TextMatrix(FILA, 0))) > 0 Then
'
'                If MISQL.SQL_EXECUTE(SQL) <> 0 Then
'                    Exit Function
'                End If
'
'            End If
'
'     Next FILA
'
'  End With
'
'            GrabarTasas = True

End Function
Public Sub GrillaValid(grilla As Control)
   
Dim Filas As Long
'
' With grilla
'
'  For FILAS = 1 To .Rows - 1
'
'        .Row = FILAS
'
'
'        .TextMatrix(.Row, 1) = FUNC_SACACOMA_GRILLA(.TextMatrix(.Row, 1))
'        .TextMatrix(.Row, 2) = FUNC_SACACOMA_GRILLA(.TextMatrix(.Row, 2))
'        .TextMatrix(.Row, 3) = FUNC_SACACOMA_GRILLA(.TextMatrix(.Row, 3))
'        .TextMatrix(.Row, 4) = FUNC_SACACOMA_GRILLA(.TextMatrix(.Row, 4))
'        .TextMatrix(.Row, 5) = FUNC_SACACOMA_GRILLA(.TextMatrix(.Row, 5))
'        .TextMatrix(.Row, 6) = FUNC_SACACOMA_GRILLA(.TextMatrix(.Row, 6))
'        .TextMatrix(.Row, 7) = FUNC_SACACOMA_GRILLA(.TextMatrix(.Row, 7))
'        .TextMatrix(.Row, 8) = FUNC_SACACOMA_GRILLA(.TextMatrix(.Row, 8))
'
'
'    Next FILAS
'
'  End With
'
End Sub

Public Function Actualiza_Tasas(CodMoneda As String, CodTasa As String) As Boolean

Dim datos()
Dim Sql As String
Dim Fila, a As Integer
Dim fecha As String
  
  Actualiza_Tasas = False

            Sql = ""
            Sql = giSQL_DatabaseCommon
            Sql = Sql & "..Sp_tasas_refresh "
            'SQL = SQL & Sistema
            Sql = Sql & Val(CodTasa)
            Sql = Sql & "," & Val(CodMoneda)
            
            
                If MISQL.SQL_Execute(Sql) <> 0 Then
                    Exit Function
                End If
           
           
  Actualiza_Tasas = True
  
End Function
