VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Begin VB.Form BacGrupoProd 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Mantenedor Grupo por productos"
   ClientHeight    =   4785
   ClientLeft      =   3120
   ClientTop       =   3480
   ClientWidth     =   6225
   Icon            =   "BacGrupoProd.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4785
   ScaleWidth      =   6225
   ShowInTaskbar   =   0   'False
   Begin VB.PictureBox ConCheck 
      BorderStyle     =   0  'None
      Height          =   345
      Index           =   0
      Left            =   975
      Picture         =   "BacGrupoProd.frx":030A
      ScaleHeight     =   345
      ScaleWidth      =   405
      TabIndex        =   8
      Top             =   4875
      Visible         =   0   'False
      Width           =   405
   End
   Begin VB.PictureBox SinCheck 
      BorderStyle     =   0  'None
      Height          =   330
      Index           =   0
      Left            =   150
      Picture         =   "BacGrupoProd.frx":0464
      ScaleHeight     =   330
      ScaleWidth      =   375
      TabIndex        =   7
      Top             =   4860
      Visible         =   0   'False
      Width           =   375
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   5400
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
            Picture         =   "BacGrupoProd.frx":05BE
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacGrupoProd.frx":0A10
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacGrupoProd.frx":0D2A
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacGrupoProd.frx":117C
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
      Width           =   6225
      _ExtentX        =   10980
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
            Enabled         =   0   'False
            Object.Visible         =   0   'False
            Object.ToolTipText     =   "Eliminar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin Threed.SSPanel SSPanel1 
      Height          =   4245
      Left            =   0
      TabIndex        =   1
      Top             =   540
      Width           =   6285
      _Version        =   65536
      _ExtentX        =   11086
      _ExtentY        =   7488
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
      Begin VB.Frame Frame2 
         Height          =   1380
         Left            =   60
         TabIndex        =   3
         Top             =   15
         Width           =   6165
         Begin VB.TextBox txtDescrip 
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
            Left            =   1515
            MaxLength       =   35
            MouseIcon       =   "BacGrupoProd.frx":1496
            MousePointer    =   99  'Custom
            TabIndex        =   12
            Top             =   600
            Width           =   4095
         End
         Begin VB.ComboBox CMB_Sistema 
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
            Left            =   1515
            Style           =   2  'Dropdown List
            TabIndex        =   10
            Top             =   960
            Width           =   4095
         End
         Begin VB.TextBox TxtCodigo 
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
            ForeColor       =   &H00800000&
            Height          =   315
            Left            =   1515
            MaxLength       =   5
            MouseIcon       =   "BacGrupoProd.frx":17A0
            MousePointer    =   99  'Custom
            TabIndex        =   0
            Top             =   210
            Width           =   855
         End
         Begin VB.Label Label4 
            Caption         =   "Sistema"
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
            TabIndex        =   11
            Top             =   960
            Width           =   1335
         End
         Begin VB.Label Label2 
            Caption         =   "Nombre Grupo"
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
            TabIndex        =   9
            Top             =   600
            Width           =   1335
         End
         Begin VB.Label Label3 
            Caption         =   "Codigo Grupo"
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
            Left            =   105
            TabIndex        =   4
            Top             =   240
            Width           =   1335
         End
      End
      Begin Threed.SSFrame Frame 
         Height          =   2820
         Index           =   1
         Left            =   45
         TabIndex        =   5
         Top             =   1365
         Width           =   6165
         _Version        =   65536
         _ExtentX        =   10874
         _ExtentY        =   4974
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
         Begin MSFlexGridLib.MSFlexGrid Grilla 
            Height          =   2715
            Left            =   75
            TabIndex        =   2
            Top             =   120
            Width           =   6015
            _ExtentX        =   10610
            _ExtentY        =   4789
            _Version        =   393216
            Cols            =   3
            RowHeightMin    =   315
            BackColor       =   -2147483644
            ForeColor       =   8388608
            BackColorFixed  =   8421376
            ForeColorFixed  =   16777215
            BackColorSel    =   8388608
            ForeColorSel    =   16777215
            BackColorBkg    =   -2147483645
            GridColor       =   16777215
            GridColorFixed  =   16777215
            FocusRect       =   0
            GridLines       =   2
            GridLinesFixed  =   0
            ScrollBars      =   2
            SelectionMode   =   1
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
Attribute VB_Name = "BacGrupoProd"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Sub Habilitacontroles(Valor As Boolean)
    
    TxtCodigo.Enabled = Not Valor
    txtDescrip.Enabled = Valor
'    Cmb_Sistema.Enabled = Valor
    Toolbar1.Buttons(2).Enabled = Valor
    Toolbar1.Buttons(1).Enabled = Valor
    Toolbar1.Buttons(3).Enabled = Valor
    Screen.MousePointer = 0
    
End Sub

Private Sub CMB_Sistema_Click()
Dim Datos()
Dim i As Integer

    
    If CMB_Sistema.ListIndex = -1 Then
       Exit Sub
    End If
    
    If CMB_Sistema.ListIndex <> -1 Then
        Envia = Array()
        AddParam Envia, Trim(Right(CMB_Sistema.Text, 3))
        
        If Not Bac_Sql_Execute("SP_BACMATRIZATRIBUCIONES_LEEPRODUCTO", Envia) Then
            MsgBox "Problemas en consulta", vbCritical, TITSISTEMA
            Exit Sub
        End If
                 
        With Grilla
            .Rows = 2
            Do While Bac_SQL_Fetch(Datos())
                .Row = .Rows - 1
                .TextMatrix(.Row, 0) = Datos(1)
                .TextMatrix(.Row, 1) = ""
                .TextMatrix(.Row, 2) = UCase(Datos(2))
                .Rows = .Rows + 1
            Loop
            
            Envia = Array()
            AddParam Envia, 1
            AddParam Envia, TxtCodigo.Text
            If Not Bac_Sql_Execute("SP_CON_GRUPOPRODUCTO", Envia) Then
                MsgBox "Problemas en consulta", vbCritical, TITSISTEMA
                Exit Sub
            End If
            
            Do While Bac_SQL_Fetch(Datos())
                For i = 1 To .Rows - 1
                    If .TextMatrix(i, 0) = Datos(3) Then
                        .TextMatrix(i, 1) = "X"
                    End If
                Next i
            Loop
            
        End With
        
    End If
    
    Call Carga_Options
    'Grilla.Redraw = False
    Grilla.Enabled = True
    Grilla.Row = 1
    Call Habilitacontroles(True)
      
End Sub

Private Sub Form_Load()
Dim Datos()
    Me.Top = 0
    Me.Left = 0
    
    CMB_Sistema.Clear
    'Sp_CmbSistema2
    If Bac_Sql_Execute("SP_LEER_SISTAMA_CNT") Then
       Do While Bac_SQL_Fetch(Datos())
          CMB_Sistema.AddItem Datos(2) & Space(150) & Datos(1)
       Loop
    End If
    
    Call Limpiar2
        
End Sub

Private Sub Form_Unload(Cancel As Integer)
   Me.MousePointer = 0

End Sub

Private Sub grilla_Click()

    With Grilla
    
        .CellPictureAlignment = 4
        If Trim$(.TextMatrix(.Row, 0)) <> "" Then
            .Col = 1
            
            If Trim(.Text) = "X" Then
                .Text = ""
                .Col = 1
                Set .CellPicture = SinCheck(0).Picture
                .ColSel = .Cols - 1
            
            Else
                .Text = Space(100) + "X"
                .Col = 1
                Set .CellPicture = ConCheck(0).Picture
                .ColSel = .Cols - 1
            
            End If
        
        End If
    
    End With
  
End Sub

Private Sub grilla_KeyPress(KeyAscii As Integer)
    Call grilla_Click
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Index
    Case 1
        Call Grabar
        Call Limpiar2
    Case 2
    
    Case 3
    
        Call Limpiar2
    
    Case 4
        Unload Me

End Select
   
End Sub

Private Sub TxtCodigo_DblClick()

    BacControlWindows 100

    BacAyuda.Tag = "grupoprod"
    BacAyuda.Show 1

    If giAceptar = True Then
       TxtCodigo.Text = RetornoAyuda
       Call BuscaDatos
       SendKeys "{TAB}"
    End If
    
    MousePointer = 0
    
End Sub

Private Sub txtCodigo_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = vbKeyF3 Then Call TxtCodigo_DblClick

End Sub

Private Sub TxtCodigo_KeyPress(KeyAscii As Integer)
Dim Datos()
    
    If KeyAscii = 13 Then
    
        If TxtCodigo.Text <> "" Then
        
           Envia = Array()
           AddParam Envia, TxtCodigo.Text
           If Not Bac_Sql_Execute("SP_CON_VALIDAGRUPO", Envia) Then
              MsgBox "Problemas en consulta", vbCritical, "CONTROLFINANCIERO"
              TxtCodigo.Text = ""
              Call Limpiar2
              Exit Sub
           End If
           
           If Bac_SQL_Fetch(Datos()) Then
              If Datos(1) = "S" Then
                MsgBox "Codigo de grupo no puede ser igual a código de producto", vbCritical, "CONTROLFINANCIERO"
                TxtCodigo.Text = ""
                Call Limpiar2
                Exit Sub
              End If
           End If
        
           Call BuscaDatos
           'Cmb_Sistema.Enabled = True
           SendKeys "{TAB}"
        End If
        
    End If
    
End Sub

Public Function ParamGrilla(Rows As Integer, Cols As Integer, Rowsf As Integer, Colsf As Integer, Valor As Boolean, Grillas As Object)

  With Grillas
     .Cols = Cols
     .Rows = Rows
     .FixedCols = Colsf
     .FixedRows = Rowsf
     .Enabled = Valor
  End With

End Function

Public Function CARGAPAR_GRILLA(Grillas As Object)

  With Grillas

        .Enabled = True
        .FixedCols = 1
        .FixedRows = 1
        .RowHeight(0) = 320
        .CellFontWidth = 3         ' TAMAÑO
        
        .ColWidth(0) = 75
        .ColWidth(1) = 1500
        .ColWidth(2) = 4300
        
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
        .Col = 1
        
  End With

End Function

Sub Carga_Options()

Dim i As Integer

    With Grilla
        .Redraw = False
        .Enabled = True
        
        For i = 1 To .Rows - 1
            .Row = i
            .CellPictureAlignment = 4
            
            If Trim(.TextMatrix(i, 1)) = "X" Then
                .Col = 1
                Set .CellPicture = ConCheck(0).Picture
                .Text = Space(100) + "X"
            Else
                Set .CellPicture = SinCheck(0).Picture
            End If
        
        Next i
        
        If .TextMatrix(.Rows - 1, 2) = "" Then
        .Rows = .Rows - 1
        
        End If
        
        .Redraw = True
        
    End With
   
End Sub

Sub Limpiar2()

   Grilla.Clear
   Call CARGAPAR_GRILLA(Grilla)
   TxtCodigo.Text = ""
   txtDescrip.Text = ""
   CMB_Sistema.ListIndex = -1
   Call Habilitacontroles(False)
   Grilla.ColWidth(0) = 0
   Grilla.Enabled = False
   
End Sub

Function Grabar()
Dim i As Integer
On Error GoTo Errores
        Screen.MousePointer = 11
        
'''''        If Not BacBeginTransaction Then
'''''            MsgBox "Problemas en el Servidor no se puede grabar", vbCritical, "CONTROL FINANCIERO"
'''''            Exit Function
'''''        End If
        
        Envia = Array()
        AddParam Envia, TxtCodigo.Text
        If Not Bac_Sql_Execute("SP_ELI_GRUPOPRODUCTO", Envia) Then
           MsgBox "No se pueden eliminar registros anteriores", vbCritical, "CONTROL FINANCIERO"
           GoTo Errores
        End If
                
        For i = 1 To Grilla.Rows - 1
         
             If Trim(Grilla.TextMatrix(i, 1)) = "X" Then
                 
                 Envia = Array()
                 AddParam Envia, TxtCodigo.Text
                 AddParam Envia, txtDescrip.Text
                 AddParam Envia, Trim(Right(CMB_Sistema.Text, 5))
                 AddParam Envia, Grilla.TextMatrix(i, 0)
                 
                 If Not Bac_Sql_Execute("SP_ACT_GRUPOPRODUCTO", Envia) Then
                    MsgBox "No se pueden grabar registros ", vbCritical, "CONTROL FINANCIERO"
                    GoTo Errores
                 End If
            
             End If
        
        Next i
                 
'''        BacCommitTransaction
        MsgBox "Grabacion terminado con Exito", vbOKOnly
        Screen.MousePointer = 0
        Exit Function
        
Errores:
'''        BacRollBackTransaction
        MsgBox "Grabacion con Problemas", vbCritical
        Exit Function
        
End Function

Public Function BuscaDatos()
Dim Datos()
Dim sSistema As String
Dim i        As Integer

'    Cmb_Sistema.Enabled = True
    Envia = Array()
    AddParam Envia, 1
    AddParam Envia, TxtCodigo.Text
    If Not Bac_Sql_Execute("SP_CON_GRUPOPRODUCTO", Envia) Then
        MsgBox "Problemas en consulta", vbCritical, TITSISTEMA
        Exit Function
    End If
    
    If Bac_SQL_Fetch(Datos()) Then
       sSistema = Datos(2)
       txtDescrip.Text = Datos(4)
       CMB_Sistema.Enabled = False
    Else
       CMB_Sistema.Enabled = True
       Exit Function
    End If

    For i = 0 To CMB_Sistema.ListCount - 1
        If Trim(Right(CMB_Sistema.List(i), 5)) = sSistema Then
           CMB_Sistema.ListIndex = i
           Exit For
        End If
    Next

End Function
           
Private Sub txtDescrip_KeyPress(KeyAscii As Integer)

    If KeyAscii >= vbKeyA And KeyAscii >= vbKeyZ Then
       KeyAscii = Asc(UCase(Chr(KeyAscii)))
    End If

End Sub
