VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form ProdxCampos 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Productos por Campos"
   ClientHeight    =   4965
   ClientLeft      =   4845
   ClientTop       =   2880
   ClientWidth     =   6255
   Icon            =   "ProdxCampos.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   4965
   ScaleWidth      =   6255
   Begin VB.PictureBox SinCheck 
      BorderStyle     =   0  'None
      Height          =   330
      Index           =   0
      Left            =   180
      Picture         =   "ProdxCampos.frx":2EFA
      ScaleHeight     =   330
      ScaleWidth      =   375
      TabIndex        =   1
      Top             =   5985
      Visible         =   0   'False
      Width           =   375
   End
   Begin VB.PictureBox ConCheck 
      BorderStyle     =   0  'None
      Height          =   345
      Index           =   0
      Left            =   1005
      Picture         =   "ProdxCampos.frx":3054
      ScaleHeight     =   345
      ScaleWidth      =   405
      TabIndex        =   0
      Top             =   6000
      Visible         =   0   'False
      Width           =   405
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   2
      Top             =   0
      Width           =   6255
      _ExtentX        =   11033
      _ExtentY        =   794
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Style           =   1
      ImageList       =   "Img_opciones"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Grabar"
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Key             =   "Eliminar"
            Object.ToolTipText     =   "Eliminar"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Limpiar"
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
      Begin MSComctlLib.ImageList Img_opciones 
         Left            =   5310
         Top             =   0
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   24
         ImageHeight     =   24
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   12
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "ProdxCampos.frx":31AE
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "ProdxCampos.frx":3615
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "ProdxCampos.frx":3B0B
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "ProdxCampos.frx":3F9E
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "ProdxCampos.frx":4486
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "ProdxCampos.frx":4999
               Key             =   ""
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "ProdxCampos.frx":4E6C
               Key             =   ""
            EndProperty
            BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "ProdxCampos.frx":5332
               Key             =   ""
            EndProperty
            BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "ProdxCampos.frx":5829
               Key             =   ""
            EndProperty
            BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "ProdxCampos.frx":5C22
               Key             =   ""
            EndProperty
            BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "ProdxCampos.frx":6018
               Key             =   ""
            EndProperty
            BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "ProdxCampos.frx":6555
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin Threed.SSPanel SSPanel1 
      Height          =   4665
      Left            =   -30
      TabIndex        =   3
      Top             =   480
      Width           =   6285
      _Version        =   65536
      _ExtentX        =   11086
      _ExtentY        =   8229
      _StockProps     =   15
      BackColor       =   -2147483644
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BevelOuter      =   1
      Begin VB.Frame Frame1 
         Height          =   525
         Left            =   0
         TabIndex        =   11
         Top             =   0
         Width           =   6255
         Begin VB.ComboBox cmbEvento 
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
            Left            =   960
            Style           =   2  'Dropdown List
            TabIndex        =   13
            Top             =   120
            Width           =   2490
         End
         Begin VB.Label Label1 
            Caption         =   "Evento"
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
            Height          =   255
            Left            =   120
            TabIndex        =   12
            Top             =   240
            Width           =   735
         End
      End
      Begin Threed.SSFrame SSFrame1 
         Height          =   540
         Left            =   60
         TabIndex        =   8
         Top             =   480
         Width           =   1845
         _Version        =   65536
         _ExtentX        =   3254
         _ExtentY        =   952
         _StockProps     =   14
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ShadowStyle     =   1
         Begin VB.TextBox TxtCodigo 
            Alignment       =   1  'Right Justify
            BackColor       =   &H00FFFFFF&
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
            Height          =   300
            Left            =   840
            MaxLength       =   5
            MouseIcon       =   "ProdxCampos.frx":6A16
            MousePointer    =   99  'Custom
            TabIndex        =   9
            Top             =   150
            Width           =   855
         End
         Begin VB.Label Label3 
            Caption         =   "Campo"
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
            Height          =   255
            Left            =   60
            TabIndex        =   10
            Top             =   195
            Width           =   735
         End
      End
      Begin VB.Frame Frame2 
         Height          =   570
         Left            =   1875
         TabIndex        =   4
         Top             =   480
         Width           =   4350
         Begin VB.Label txtDescrip 
            BackColor       =   &H80000009&
            BorderStyle     =   1  'Fixed Single
            Enabled         =   0   'False
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
            Height          =   315
            Left            =   60
            TabIndex        =   5
            Top             =   180
            Width           =   4215
         End
      End
      Begin Threed.SSFrame Frame 
         Height          =   3495
         Index           =   1
         Left            =   60
         TabIndex        =   6
         Top             =   960
         Width           =   6165
         _Version        =   65536
         _ExtentX        =   10874
         _ExtentY        =   6165
         _StockProps     =   14
         Caption         =   "Productos"
         ForeColor       =   8388608
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Font3D          =   1
         Begin MSFlexGridLib.MSFlexGrid grilla 
            Height          =   3180
            Left            =   0
            TabIndex        =   7
            Top             =   240
            Width           =   6105
            _ExtentX        =   10769
            _ExtentY        =   5609
            _Version        =   393216
            Cols            =   3
            RowHeightMin    =   280
            BackColor       =   -2147483644
            ForeColor       =   8388608
            BackColorFixed  =   8421376
            ForeColorFixed  =   16777215
            BackColorSel    =   8388608
            ForeColorSel    =   16777215
            BackColorBkg    =   -2147483644
            GridColor       =   0
            FocusRect       =   0
            GridLines       =   2
            GridLinesFixed  =   0
            ScrollBars      =   2
            SelectionMode   =   1
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
         End
      End
   End
End
Attribute VB_Name = "ProdxCampos"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim Datos()

Private Sub Form_Load()

   Me.top = 0
   Me.left = 0
   Me.Icon = BAC_Parametros.Icon
   PROC_CARGA_COMBO_EVENTO
   CARGAPAR_GRILLA grilla
   
   Limpiar
   
'   If LogAuditoria("07", "opc_555", Me.Caption) = False Then
'        MsgBox "Problemas en la grabación" + Chr(13) + "del log de auditoría", 16, TITSISTEMA
'   End If
   
End Sub

Sub PROC_CARGA_COMBO_EVENTO()
Dim Datos()
Dim Sql As String
Dim i
On Error GoTo CargaData

    Envia = Array()
    
    AddParam Envia, Trim(right$("PSV", 7))
     
    i = 0
    If BAC_SQL_EXECUTE("sp_cnt_leermovimientos", Envia) Then
        cmbEvento.Clear
        Do While BAC_SQL_FETCH(Datos())
            cmbEvento.AddItem Trim$(Datos(2)) & Space(50) & Datos(1)

            i = i + 1
        Loop
        cmbEvento.ListIndex = 0
        cmbEvento.Enabled = True
    Else
        MsgBox "Problemas en obtención de información del servidor ", vbCritical, TITSISTEMA
        Exit Sub
    End If
  ' ======================================================================================
    
    Exit Sub
CargaData:
    MsgBox "Problemas en carga de información de objetos: " & err.Description & ". Comunique al Administrador.", vbCritical, TITSISTEMA
    Exit Sub
End Sub

Private Sub Form_Unload(Cancel As Integer)
'    If LogAuditoria("08", "opc_555", Me.Caption) = False Then
'        MsgBox "Problemas en la grabación" + Chr(13) + "del log de auditoría", 16, TITSISTEMA
'    End If
End Sub

Private Sub Grilla_Click()
   
     With grilla
      
    If .Col = 1 Then
            .CellPictureAlignment = 4
                
            .Col = 1
               
            If .CellPicture = ConCheck(0).Picture Then
                
                .Col = 1
                Set .CellPicture = SinCheck(0).Picture
                .ColSel = .Cols - 1
            
            Else
               
               .Col = 1
               Set .CellPicture = ConCheck(0).Picture
               .ColSel = .Cols - 1
                                
            End If
    End If
    End With
     

End Sub


Public Function CARGAPAR_GRILLA(Grillas As MSFlexGrid)

  With Grillas
      
        .Cols = 4
        
        .Enabled = True
        .FixedCols = 1
        .FixedRows = 1
        .RowHeight(0) = 320
        .CellFontWidth = 3         ' TAMAÑO
        
        .ColWidth(0) = 0
        .ColWidth(1) = 1500
        .ColWidth(2) = 4300
        .ColWidth(3) = 0
        
        .Rows = 2
        .Row = 0
        .Col = 1
        
        .FixedAlignment(1) = 4
        .CellFontBold = True       'RESALSE
        .Text = "Marca"
        .ColAlignment(1) = 4
        
        .Col = 2
        .FixedAlignment(2) = 4
        .CellFontBold = True       'RESALSE
        .Text = "Descripción "
        
        .Row = 1
        .Col = 0
        .Rows = 1
        
  End With

End Function
Private Sub Grilla_KeyPress(KeyAscii As Integer)

   Grilla_Click

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

   Select Case UCase(Button.Key)

      Case "GRABAR"
            Call GRABAR

      Case "LIMPIAR"
            Call Limpiar
      
      Case "SALIR"
            Unload Me
            
   End Select

End Sub

Private Sub Carga_Productos()
Dim Productos As String

   Envia = Array()
   AddParam Envia, txtCodigo.Text
   AddParam Envia, Trim(Mid(cmbEvento.Text, 50, Len(cmbEvento.Text)))
   AddParam Envia, Me.Tag
   
   If Not BAC_SQL_EXECUTE("Sp_ProdxCampos_LeeCampos", Envia) Then
   
      Exit Sub
   
   End If

   With grilla
         
      .Enabled = True
      .Redraw = False
      .Rows = 1
      .Col = 1
      While BAC_SQL_FETCH(Datos())
   
            .Rows = .Rows + 1
            .Row = .Rows - 1
            .TextMatrix(.Rows - 1, 2) = Datos(2)
            .TextMatrix(.Rows - 1, 3) = Datos(1)
            .CellPictureAlignment = 4
            Datos(1) = Datos(1)
            
            If Datos(5) = "S" Then
                Set .CellPicture = ConCheck(0).Picture
            Else
                Set .CellPicture = SinCheck(0).Picture
            End If
         
      Wend
   
      .Row = 1
      .Col = 0
      .Redraw = True
   
   End With
   

End Sub


Sub CodigoCampo()
On Error GoTo Label1
    
    txtCodigo.Text = ""
    If Me.Tag = "F" Then
        MiTag = "PROD_CAMPOS"
        BacAyuda.Tag = "PROD_CAMPOS"
    Else
        MiTag = "PROD_CAMPOSLOGICOS"
        BacAyuda.Tag = "PROD_CAMPOSLOGICOS"
    End If
    BacAyuda.Show 1
    
    If giAceptar% = True Then
       Toolbar1.Buttons(1).Enabled = True
       txtCodigo.Text = gsCodigo$
       txtDescrip.Caption = gsGlosa
       cmbEvento.Enabled = False
       txtCodigo.Enabled = False
       Carga_Productos
       SendKeys "{ENTER}"
    End If
    
    Exit Sub

Label1:
    
    MousePointer = 0
    MsgBox "Error : " & err.Description, vbOKOnly + vbCritical, TITSISTEMA

End Sub

Private Sub txtCodigo_DblClick()

   CodigoCampo

End Sub

Sub Limpiar()

   txtCodigo.Text = ""
   txtCodigo.Enabled = True
   txtDescrip.Caption = ""
   txtCodigo.Enabled = True
   cmbEvento.Enabled = True
   grilla.Rows = 1
   grilla.Enabled = False
   grilla.Col = 0
   Toolbar1.Buttons(1).Enabled = False

End Sub


Sub GRABAR()
Dim i          As Integer
Dim Row        As Integer
Dim Productos  As String

   With grilla
   
      Row = .Row
      .Col = 1
     ' .Redraw = False
      Productos = ""
   
      
        Envia = Array()
        AddParam Envia, Trim(Mid(cmbEvento.Text, 50, Len(cmbEvento.Text)))
        AddParam Envia, CDbl(txtCodigo.Text)
        AddParam Envia, Me.Tag
   
        If Not BAC_SQL_EXECUTE("Sp_ProdxCampos_Eliminar", Envia) Then
        
           MsgBox "Problemas al Grabar Productos por Campos", vbExclamation, TITSISTEMA
           .Redraw = True
           Exit Sub
        
        End If
        
      For i = 1 To .Rows - 1
      
         .Row = i
         If .CellPicture = ConCheck(0).Picture Then
      
            Productos = .TextMatrix(i, 3)
                        
            Envia = Array()
            AddParam Envia, CDbl(txtCodigo.Text)
            AddParam Envia, Trim(Mid(cmbEvento.Text, 50, Len(cmbEvento.Text)))
            AddParam Envia, "PSV"
            AddParam Envia, Productos
            AddParam Envia, Me.Tag
      
   
            If Not BAC_SQL_EXECUTE("Sp_ProdxCampos_Grabar", Envia) Then
            
               MsgBox "Problemas al Grabar Productos por Campos", vbExclamation, TITSISTEMA
               .Redraw = True
               Exit Sub
            
            End If
      
         End If
      
      Next i
   
      .Row = Row
      .ColSel = .Cols - 1
      .Redraw = True
   
      
   
      MsgBox "Grabación Realizada con Exito", vbInformation, TITSISTEMA
      Call Limpiar
   
   End With

End Sub
