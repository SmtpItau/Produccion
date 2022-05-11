VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form Mantenedor_Mitigador 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantenedor Instrumento / Mitigador"
   ClientHeight    =   6600
   ClientLeft      =   510
   ClientTop       =   1545
   ClientWidth     =   6315
   Icon            =   "Mantenedor_Mitigador.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   6600
   ScaleWidth      =   6315
   Begin Threed.SSFrame Frame3 
      Height          =   5775
      Left            =   0
      TabIndex        =   0
      Top             =   720
      Width           =   6255
      _Version        =   65536
      _ExtentX        =   11033
      _ExtentY        =   10186
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
      Begin VB.TextBox texto 
         BackColor       =   &H00800000&
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   285
         Left            =   2280
         MaxLength       =   8
         TabIndex        =   6
         Top             =   1080
         Visible         =   0   'False
         Width           =   1185
      End
      Begin VB.ComboBox Cmb_Instrumento 
         BackColor       =   &H00C0C0C0&
         Height          =   315
         ItemData        =   "Mantenedor_Mitigador.frx":030A
         Left            =   3600
         List            =   "Mantenedor_Mitigador.frx":031D
         Style           =   2  'Dropdown List
         TabIndex        =   5
         Top             =   1080
         Visible         =   0   'False
         Width           =   1935
      End
      Begin MSFlexGridLib.MSFlexGrid Table1 
         Height          =   5340
         Left            =   75
         TabIndex        =   3
         Top             =   120
         Width           =   6000
         _ExtentX        =   10583
         _ExtentY        =   9419
         _Version        =   393216
         Cols            =   5
         FixedCols       =   0
         BackColor       =   -2147483644
         ForeColor       =   8388608
         BackColorFixed  =   8421376
         ForeColorFixed  =   16777215
         BackColorSel    =   8388608
         ForeColorSel    =   8388608
         BackColorBkg    =   -2147483645
         GridColor       =   255
         GridColorFixed  =   8421504
         GridLines       =   2
         ScrollBars      =   2
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
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   4
      Top             =   0
      Width           =   6315
      _ExtentX        =   11139
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   4
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   0
      Top             =   0
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   6
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Mantenedor_Mitigador.frx":0335
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Mantenedor_Mitigador.frx":0787
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Mantenedor_Mitigador.frx":0BD9
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Mantenedor_Mitigador.frx":0EF3
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Mantenedor_Mitigador.frx":120D
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Mantenedor_Mitigador.frx":1527
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin VB.Frame Frame 
      Caption         =   "Plazo Residual"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1245
      Left            =   45
      TabIndex        =   2
      Top             =   2340
      Visible         =   0   'False
      Width           =   6225
      Begin BACControles.TXTNumero TXTPlazoResidual 
         Height          =   270
         Left            =   150
         TabIndex        =   1
         Top             =   360
         Width           =   855
         _ExtentX        =   1508
         _ExtentY        =   476
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0"
         Text            =   "0"
         Min             =   "0"
         Max             =   "999999"
         MarcaTexto      =   -1  'True
      End
   End
End
Attribute VB_Name = "Mantenedor_Mitigador"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim lIngresa            As Boolean
Dim lDesviacionEstandar As Boolean
Dim lTasaInterbancaria  As Boolean
Dim nDesviacionEstandar As Double
Dim nMedia              As Double
Dim nMedia1             As Double
Dim nMedia2             As Double
Dim nMedia3             As Double
Dim nDesvEst            As Double
Dim nDesvEst1           As Double
Dim nDesvEst2           As Double
Dim nDesvEst3           As Double
Dim nDesMedia           As Double
Dim nDesFinal           As Double

Sub cargar_grilla()
Dim nCont  As Integer
Dim nerror As String
Dim DATOS()

    Table1.Redraw = False
    Table1.Clear
    Dibuja_Grilla
  
    If Bac_Sql_Execute("tblMitigacion_SelectAll ") Then
        With Table1

        .Rows = 1

        Do While Bac_SQL_Fetch(DATOS())

           .Rows = .Rows + 1
           .Row = .Rows - 1

           .Col = 0: .text = DATOS(1)
           .Col = 1: .text = DATOS(2)
           .Col = 2: .text = DATOS(3)
           .Col = 3: .text = DATOS(4)
        Loop


        End With
    End If
    Table1.Redraw = True
    Exit Sub
Errores:
MsgBox err.Description
End Sub

Function FUNC_POSICION_COMBO(Cmb_Control As Control, texto As String, Posicion As Integer) As Integer
Dim i%
Dim encontro As Boolean
  FUNC_POSICION_COMBO = 0
    For i% = 0 To Cmb_Control.ListCount - 1
      Cmb_Control.ListIndex = i%
        If Trim(Mid(Cmb_Control.text, 1, Posicion)) = Trim(texto) Then
          encontro = True
          FUNC_POSICION_COMBO = i%
          Exit For
        End If
    Next i%
End Function

Sub CmdAyuda()

Dim cTexto

cTexto = cTexto + "[F1]  => Ayuda" + vbCrLf
cTexto = cTexto + "[F2]  => Cambia Desviación Estandar" + vbCrLf
cTexto = cTexto + "[Ins] => Agrega Periodo" + vbCrLf
cTexto = cTexto + "[Del] => Elimina Periodo" + vbCrLf

MsgBox cTexto, , "Ayuda"
Table1.SetFocus

End Sub
Private Sub cmdGrabar()
Dim iCartera        As Variant
Dim iInstrumento    As Variant
  
    Screen.MousePointer = vbHourglass

    If Not Bac_Sql_Execute("dbo.tblMitigacion_Delete") Then
        MsgBox "Problemas en proceso de grabacion de parametros", vbCritical, TITSISTEMA
        Screen.MousePointer = 0
    End If
  
    With Table1
        For i = 1 To .Rows - 1
            .Row = i

            Envia = Array()
            AddParam Envia, .TextMatrix(.Row, 0)
            AddParam Envia, CDbl(.TextMatrix(.Row, 1))
            AddParam Envia, CDbl(.TextMatrix(.Row, 2))
            AddParam Envia, CDbl(.TextMatrix(.Row, 3))            
            If Not Bac_Sql_Execute("dbo.tblMitigacion_Save", Envia) Then
            MsgBox "Grabación no tuvo éxito", vbCritical, TITSISTEMA
            Exit Sub
            End If
        Next
    End With

    Screen.MousePointer = 0
End Sub



Private Sub cmdGrabar_Pre_Aprobado()

On Error GoTo xError
    Dim iCartera        As Variant
    Dim iInstrumento    As Variant
    Dim r%
    Dim i As Integer
   Dim Cont As Integer
    Cont = 0
    
       
    With Table1
    
        For i = 1 To .Rows - 1
            .Row = i
            If .CellBackColor = vbRed Then
                  Cont = Cont + 1
            End If
        Next

        

        For i = 1 To .Rows - 1
            .Row = i
            If .CellBackColor <> vbRed Then

                Envia = Array()
                AddParam Envia, IIf(.TextMatrix(.Row, 0) = "TRADING", 1, 2)
                AddParam Envia, Right(.TextMatrix(.Row, 1), 6)
                AddParam Envia, CDbl(.TextMatrix(.Row, 2))
                AddParam Envia, CDbl(.TextMatrix(.Row, 3))
          
          If Me.Tag = "APR" Then
            AddParam Envia, Trim(txtUsr_ing.text)
            AddParam Envia, gsBac_User
            AddParam Envia, Trim(txtFec_ing.text)
            AddParam Envia, Format(gsBac_Fecp, gsc_fechadma)
            AddParam Envia, cmbStatus.ItemData(cmbStatus.ListIndex)
          Else
            AddParam Envia, gsBac_User 'Trim(txtUsr_ing.Text)
            AddParam Envia, 0
            AddParam Envia, Trim(txtFec_ing.text)
            AddParam Envia, 0 ' Trim(txtFec_Aut.Text)
            AddParam Envia, 1 'cmbStatus.ItemData(cmbStatus.ListIndex) '---5815490
        End If
        
         AddParam Envia, IIf(Existe, 2, 1)
        
        If Not Bac_Sql_Execute("Sp_Graba_Plazos_preaprobado", Envia) Then
           MsgBox "Grabación no tuvo éxito", vbCritical, TITSISTEMA
           Exit Sub
        End If
    End If
  Next
  End With
'Next r%
   
      O = 0
      For Y = 1 To Table1.Rows - 1
         Table1.Col = 4
         Table1.Row = Y
         If Table1.CellBackColor = vbRed Then
           O = 1
           Exit For
         End If
      Next Y
      If O > 0 Then
        If MsgBox("Los Datos Que Esten En Rojo Serán Eliminados, ¿Está Seguro de Continuar?", vbQuestion + vbYesNo, TITSISTEMA) = vbYes Then
            
        End If
      End If
      MsgBox "Grabación se realizó con exito", 64, TITSISTEMA

   

Screen.MousePointer = 0

Exit Sub
xError:
    MsgBox err.Description, vbCritical, TITSISTEMA
End Sub



Sub DesviacionEstandar()

TxtDesviacionEstandar.Enabled = True
TxtDesviacionEstandar.SetFocus

End Sub

Sub Dibuja_Grilla()
 
   With Table1
   
      .cols = 4
      
      .TextMatrix(0, 0) = "Instrumento"
      .TextMatrix(0, 1) = "Plazo Mín."
      .TextMatrix(0, 2) = "Plazo Máx."
      .TextMatrix(0, 3) = "Porcentaje"
      
      .RowHeight(0) = 310
      
      .ColAlignment(0) = 0:   .ColWidth(0) = 1500
      .ColAlignment(1) = 1:   .ColWidth(1) = 1300
      .ColAlignment(2) = 4:   .ColWidth(2) = 1000
      .ColAlignment(3) = 4:   .ColWidth(3) = 1000
      
   End With
   
End Sub

Private Sub CmdLimpiar()
   
   
    Table1.Clear
    Table1.Rows = 2
    Cmb_Instrumento.Clear
    Dibuja_Grilla
    Call LeerInstrumentos
 
    Existe = False
   
End Sub

Private Sub cmdsalir()
   Unload Me
End Sub


Sub LeerInstrumentos()

On Error GoTo ErrCarga
    
    Dim DATOS()


    With Cmb_Instrumento
        .Clear
        If Bac_Sql_Execute("sp_carga_instrumentos ") Then
            Do While Bac_SQL_Fetch(DATOS())
                .AddItem DATOS(1) '& Space(100) & DATOS(1)
            Loop
        Else
            MsgBox "No se pudo obtener información del servidor", 16, TITSISTEMA
            Exit Sub
        End If
        .ListIndex = 0
    End With
    
    
    
    
Exit Sub
ErrCarga:
    MsgBox "Se detectó problemas en carga de información: " & err.Description & ". Comunique al Administrador.", 16, TITSISTEMA

End Sub

Private Sub LeerPlazos()

Dim DATOS()

If Not Bac_Sql_Execute("Sp_Carga_Plazo_Residual") Then
   
   MsgBox "Problemas al leer Plazos", vbCritical, "MENSAJE"
   Exit Sub

End If

Do While Bac_SQL_Fetch(DATOS())
   TXTPlazoResidual.text = DATOS(1)
Loop

End Sub



Function MtmTasa(nCodigo As Integer, ByVal dFecPro As String, nPlazo As Integer) As Double

Dim DATOS()
   
Envia = Array()
AddParam Envia, nCodigo
AddParam Envia, dFecPro
AddParam Envia, nPlazo

If Not Bac_Sql_Execute("sp_mtmtasa", Envia) Then
   MsgBox "Problemas al leer tasas MTM", vbCritical, "MENSAJE"
   Exit Function
End If

Do While Bac_SQL_Fetch(DATOS())
   MtmTasa = DATOS(1)
Loop

End Function

Sub TasasDolarInterbancario()

TxtMinimo.Enabled = True
TxtMaximo.Enabled = True
TxtMinimo.SetFocus

End Sub

Private Sub Cmb_Instrumento_KeyPress(KeyAscii As Integer)

 With Table1

     If KeyAscii = 27 Then
        Cmb_Instrumento.Visible = False
        .SetFocus
     End If

    If KeyAscii = 13 Then
            .TextMatrix(.Row, 0) = Cmb_Instrumento.text
            Cmb_Instrumento.Visible = False
            .Col = .Col + 1
            .SetFocus
            Exit Sub
    End If
 End With

End Sub

Private Sub Cmb_Instrumento_LostFocus()

       Cmb_Instrumento.Visible = False
       Table1.SetFocus
       
End Sub


Private Sub cmbinstrumento_Click()

Toolbar1.Buttons(2).Enabled = True
'Toolbar.Buttons(1).Enabled = True

End Sub

Private Sub Combo1_KeyPress(KeyAscii As Integer)

 With Table1

     If KeyAscii = 27 Then
        Cmb_Producto.Visible = False
        .SetFocus
     End If

    If KeyAscii = 13 Then
            .TextMatrix(.Row, .Col) = Combo1.text
            Combo1.Visible = False
            .Col = .Col + 1
            .SetFocus
            Exit Sub
    End If
 End With
 
End Sub


Private Sub Combo1_LostFocus()

       Combo1.Visible = False
       Table1.SetFocus
       
End Sub


Private Sub Form_Activate()

Call Dibuja_Grilla

End Sub

Private Sub Form_Load()

    Me.Top = 0
    Me.Left = 0

    LeerInstrumentos
    Call cargar_grilla


End Sub


Private Sub Table1_DblClick()

    With Table1
       ' If .Col = 0 Then
       '     Cmb_Cartera.Visible = True
       '     Cmb_Cartera.ListIndex = 0
       '     Proc_Posiciona_Combo Table1, Cmb_Cartera
       '     Cmb_Cartera.SetFocus
       ' End If
        
        If .Col = 0 Then
            Cmb_Instrumento.Visible = True
            Cmb_Instrumento.ListIndex = 0
            Proc_Posiciona_Combo Table1, Cmb_Instrumento
            Cmb_Instrumento.SetFocus
        End If

        If .Col = 1 Or .Col = 2 Or .Col = 3 Then
           PROC_POSICIONA_TEXTO Table1, texto
           texto.Visible = True
           texto.SetFocus
        End If

End With

End Sub



Sub Proc_Posiciona_Combo(GRILLA As Control, texto As Control)

   If Not TypeOf texto Is ComboBox Then
      texto.Height = 270

   End If

   texto.Top = GRILLA.CellTop + GRILLA.Top + 20
   texto.Left = GRILLA.CellLeft + GRILLA.Left + 20
   texto.Width = GRILLA.CellWidth - 20

End Sub


Private Sub Table1_KeyDown(KeyCode As Integer, Shift As Integer)
Dim i As Integer

    With Table1
        If KeyCode = 46 Then ' Suprimir
            .RemoveItem (.Row)
            .SetFocus
            Exit Sub
        End If
        If KeyCode = 45 Then 'Insert
            If .TextMatrix(.Rows - 1, 0) <> "" Or .TextMatrix(.Rows - 1, 1) <> "" Or .TextMatrix(.Rows - 1, 2) <> "" Or .TextMatrix(.Rows - 1, 3) <> "" Then
                .Rows = .Rows + 1
                .Row = .Rows - 1
                .Col = 0
            End If
        End If
    End With

End Sub


Private Sub Table1_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then
        Call Table1_DblClick
    End If
    
    If Table1.Col = 1 Or Table1.Col = 2 Or Table1.Col = 3 Then
        If (KeyAscii >= 47 And KeyAscii <= 57) Then
           PROC_POSICIONA_TEXTO Table1, texto
           texto.Visible = True
           texto.text = Chr(KeyAscii)
           SendKeys "{END}"
           texto.SetFocus
        End If
    End If

End Sub


Private Sub Texto_KeyPress(KeyAscii As Integer)

With Table1
    
   KeyAscii = Asc(UCase$(Chr$(KeyAscii)))
   
     If KeyAscii = 13 Then
          .TextMatrix(.Row, .Col) = texto.text
            texto.text = ""
           .Enabled = True
           texto.Visible = False
           
            If .Col = .cols - 1 Then
                .Col = 0
            Else
                .Col = .Col + 1
            End If
            .SetFocus
      End If
      If KeyAscii = 27 Then
           texto.text = ""
           texto.Visible = False
           .Enabled = True
           .SetFocus
      End If
     
 End With
BacCaracterNumerico KeyAscii

End Sub

Private Sub Texto_LostFocus()

   Texto_KeyPress 27
   
End Sub


Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Dim coun
Dim fo
    Dim DATOS()
    
   Select Case Button.ToolTipText
   Case "Grabar"
        Call cmdGrabar
        Call CmdLimpiar
     
        Call LeerInstrumentos
        Toolbar1.Buttons(2).Enabled = False
        Call cargar_grilla

   Case "Limpiar"
      CmdLimpiar
   Case "Salir"
       Unload Me
End Select
End Sub
Private Sub Toolbar_ButtonClick(ByVal Button As MSComctlLib.Button)
Dim coun
Dim fo
Select Case Button.Index
    Case 1
        Call cmdGrabar_Pre_Aprobado
   Case 2
       Call cargar_grilla
       TxtMinimo.text = 0
       TxtMaximo.text = 0
       cmbinstrumento.Clear
      Call LeerInstrumentos
      Call LeerPlazos
   Case 3
      CmdLimpiar
   Case 4
      Unload Me
End Select
End Sub

Private Sub Txt_Ingreso_KeyPress(KeyAscii As Integer)


End Sub



Private Sub TxtDesviacionEstandar_GotFocus()
lDesviacionEstandar = True
End Sub

Private Sub TxtDesviacionEstandar_KeyPress(KeyAscii As Integer)

If KeyAscii% = vbKeyReturn Then
   KeyAscii% = 0
   SendKeys$ "{TAB}"

Else
   KeyAscii = Asc(UCase(Chr(KeyAscii))) 'KeyPress(KeyAscii)

End If

End Sub

Private Sub TxtMinimo_GotFocus()
lTasaInterbancaria = True
End Sub

Private Sub TxtMinimo_KeyPress(KeyAscii As Integer)

If KeyAscii% = vbKeyReturn Then
   KeyAscii% = 0
   SendKeys$ "{TAB}"

Else
   'Call bacKeyPress(KeyAscii)
      KeyAscii = Asc(UCase(Chr(KeyAscii)))

End If

End Sub

Private Sub TxtMaximo_KeyPress(KeyAscii As Integer)

If KeyAscii% = vbKeyReturn Then
   KeyAscii% = 0
   SendKeys$ "{TAB}"

Else
   'Call bacKeyPress(KeyAscii)
      KeyAscii = Asc(UCase(Chr(KeyAscii)))

End If

End Sub


