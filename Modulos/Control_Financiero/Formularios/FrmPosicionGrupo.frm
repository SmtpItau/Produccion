VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BACCONTROLES.OCX"
Begin VB.Form FrmPosicionGrupo 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Posicion por Grupo"
   ClientHeight    =   5955
   ClientLeft      =   2535
   ClientTop       =   3045
   ClientWidth     =   9990
   Icon            =   "FrmPosicionGrupo.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   5955
   ScaleWidth      =   9990
   Begin Threed.SSPanel SSPanel1 
      Height          =   5460
      Left            =   0
      TabIndex        =   0
      Top             =   480
      Width           =   9975
      _Version        =   65536
      _ExtentX        =   17595
      _ExtentY        =   9631
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
      BevelOuter      =   0
      BevelInner      =   2
      Begin BACControles.TXTNumero Texto 
         Height          =   285
         Left            =   2820
         TabIndex        =   3
         Top             =   1290
         Visible         =   0   'False
         Width           =   1545
         _ExtentX        =   2725
         _ExtentY        =   503
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
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin MSFlexGridLib.MSFlexGrid Grid1 
         Height          =   5265
         Left            =   90
         TabIndex        =   1
         Top             =   90
         Width           =   9765
         _ExtentX        =   17224
         _ExtentY        =   9287
         _Version        =   393216
         RowHeightMin    =   315
         BackColor       =   -2147483644
         BackColorBkg    =   -2147483636
         GridColorFixed  =   16777215
         Enabled         =   0   'False
         FocusRect       =   0
         GridLines       =   2
         GridLinesFixed  =   0
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   480
      Left            =   0
      TabIndex        =   2
      Top             =   0
      Width           =   9990
      _ExtentX        =   17621
      _ExtentY        =   847
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   6
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.Visible         =   0   'False
            Object.ToolTipText     =   "Limpiar"
            BeginProperty ButtonMenus {66833FEC-8583-11D1-B16A-00C0F0283628} 
               NumButtonMenus  =   1
               BeginProperty ButtonMenu1 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
            EndProperty
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   2
            BeginProperty ButtonMenus {66833FEC-8583-11D1-B16A-00C0F0283628} 
               NumButtonMenus  =   1
               BeginProperty ButtonMenu1 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
            EndProperty
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.Visible         =   0   'False
            Object.ToolTipText     =   "Eliminar"
            BeginProperty ButtonMenus {66833FEC-8583-11D1-B16A-00C0F0283628} 
               NumButtonMenus  =   1
               BeginProperty ButtonMenu1 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
            EndProperty
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   4
            BeginProperty ButtonMenus {66833FEC-8583-11D1-B16A-00C0F0283628} 
               NumButtonMenus  =   1
               BeginProperty ButtonMenu1 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
            EndProperty
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Informe"
            ImageIndex      =   6
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   5
            BeginProperty ButtonMenus {66833FEC-8583-11D1-B16A-00C0F0283628} 
               NumButtonMenus  =   8
               BeginProperty ButtonMenu1 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
               BeginProperty ButtonMenu2 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
               BeginProperty ButtonMenu3 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
               BeginProperty ButtonMenu4 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
               BeginProperty ButtonMenu5 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
               BeginProperty ButtonMenu6 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
               BeginProperty ButtonMenu7 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
               BeginProperty ButtonMenu8 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
            EndProperty
         EndProperty
      EndProperty
      BorderStyle     =   1
      MouseIcon       =   "FrmPosicionGrupo.frx":000C
      OLEDropMode     =   1
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   9150
      Top             =   690
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   24
      ImageHeight     =   24
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   6
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmPosicionGrupo.frx":0326
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmPosicionGrupo.frx":1200
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmPosicionGrupo.frx":20DA
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmPosicionGrupo.frx":2FB4
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmPosicionGrupo.frx":3E8E
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmPosicionGrupo.frx":41A8
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "FrmPosicionGrupo"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim Grilla          As Variant
Dim ValNue          As String
Dim ValAnt          As String

Private Sub CmbCombo_Change()

End Sub

Private Sub Form_Load()
   Me.Top = 0
   Me.Left = 0
   
   Me.Icon = Acceso_Usuario.Icon
   
   Call CargarGrid
   
   Call Carga_Datos
   
   
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Texto.Visible = False
   
   Select Case Button.Index
    Case 2
       Call Graba
       Call CargarGrid
    Case 3
       Call Elimina
       Call CargarGrid
    Case 1
       Call CargarGrid
    Case 4
         Call Busca
         Toolbar1.Buttons(5).Enabled = True
         Grid1.Enabled = True
         Grid1.SetFocus
    Case 5
       
       Call Genera_Informe
       
    Case 6
    
        Unload Me
        
    
   End Select

End Sub

Private Sub Grid1_KeyDown(KeyCode As Integer, Shift As Integer)
    Grilla = 1
    If Trim(Right(Grid1.TextMatrix(Grid1.Row, 0), 5)) = "08" Then Exit Sub
    Call Grid_KeyDown(KeyCode, Shift, Grid1)
End Sub

Private Sub Grid1_KeyPress(KeyAscii As Integer)
    
    If KeyAscii = 27 Then
        Unload Me
        Exit Sub
    End If
    Call Grid_KeyPress(KeyAscii, Grid1, Texto)

End Sub

Private Sub Texto_KeyDown(KeyCode As Integer, Shift As Integer)
    If Grilla = 1 Then
        Call TextoKeyDown(KeyCode, Shift, Grid1, Texto)
    End If
End Sub
    
Private Sub texto_Change()
   Call PROC_CALCULO
End Sub

Sub textovisible(Grid As MSFlexGrid, Texto As Control)
    
    If Grid.Col = 0 Then
        Texto.CantidadDecimales = 0
        Texto.Max = "99"
        Texto.Text = Grid.Text
        Call PROC_POSICIONA_TEXTO(Grid, Texto)
        Texto.Visible = True
        Texto.SetFocus
    End If
    If Grid.Col = 1 Then
        Texto.CantidadDecimales = 0
        Texto.Max = "9999999999999"
        Texto.Text = Grid.Text
        Call PROC_POSICIONA_TEXTO(Grid, Texto)
        Texto.Visible = True
        Texto.SetFocus
    End If
End Sub

Sub Grid_KeyDown(KeyCode As Integer, Shift As Integer, Grid As MSFlexGrid)
    If KeyCode = 13 Then
        If Grid.Col = 1 Then
           'Call textovisible(Grid, texto)
        End If
    End If
End Sub
Sub Grid_KeyPress(KeyAscii As Integer, Grid As MSFlexGrid, Texto As Control)
    
    If KeyAscii > 47 And KeyAscii < 58 Then
        TeclaPre = KeyAscii
        
        If Grid.Col = 1 Then
           Call textovisible(Grid, Texto)
           Texto.Text = Chr(KeyAscii)
           Texto.SelStart = 1
        End If
    End If

End Sub

Sub TextoKeyDown(KeyCode As Integer, Shift As Integer, Grid As MSFlexGrid, Texto As Control)
    
    If KeyCode = vbKeyEscape Then
        Texto.Visible = False
        Grid.SetFocus
    End If
    
    If KeyCode = vbKeyReturn And Grid.Col = 1 Then
        Call PROC_CALCULO
        Grid.Text = Texto.Text
        Grid.SetFocus
    End If
End Sub

Private Sub Texto_LostFocus()

If Grilla = 1 Then
  If Grid1.Col = 1 Then
     Grid1.Text = BacFormatoMonto(Texto.Text, 3)
  End If
End If
 
 Texto.Visible = False
End Sub

Private Function CargarGrid()
   
   Titulos1 = Array(" ", "Total ", "Total", "Total", "Total %")
   Titulos2 = Array("Grupo Detalle", "Posicion", "Ocupado", "Disponible", "Excedido")

   Anchos = Array("3100", "2550", "2550", "2550", "1500")
   Call PROC_CARGARGRILLA(Grid1, 315, 215, Anchos, Titulos1, , Titulos2)
   Grid1.Col = 0
   Grid1.Row = Grid1.FixedRows
   Grid1.Rows = Grid1.Rows - 1
   Call InsertarRow(Grid1)
   Grid1.Enabled = False
   Texto.Visible = False
   Toolbar1.Buttons(2).Enabled = False
   Toolbar1.Buttons(3).Enabled = False
   Toolbar1.Buttons(4).Enabled = True
   Toolbar1.Buttons(5).Enabled = False
   
End Function

Private Function InsertarRow(Grid As MSFlexGrid)
    Grid1.Rows = Grid1.Rows + 1
    Grid1.Row = Grid1.Rows - 1
    Grid1.Col = 0

        Grid1.TextMatrix(Grid1.Row, 0) = ""
        Grid1.TextMatrix(Grid1.Row, 1) = 0
        Grid1.TextMatrix(Grid1.Row, 2) = 0
        Grid1.TextMatrix(Grid1.Row, 3) = 0
        Grid1.TextMatrix(Grid1.Row, 4) = 0
        Grid1.TextMatrix(Grid1.Row, 1) = Format(Grid1.TextMatrix(Grid1.Row, 1), FDecimal)
        Grid1.TextMatrix(Grid1.Row, 2) = Format(Grid1.TextMatrix(Grid1.Row, 2), FDecimal)
        Grid1.TextMatrix(Grid1.Row, 3) = Format(Grid1.TextMatrix(Grid1.Row, 3), FDecimal)
        Grid1.TextMatrix(Grid1.Row, 4) = Format(Grid1.TextMatrix(Grid1.Row, 4), FDecimal)
    
    SendKeys "{HOME}"
End Function

Private Function Graba()
    
    Dim I%
    Dim datos()
    
    Envia = Array("B")
    If Not Bac_Sql_Execute("SP_BCR_TRANSACTION", Envia) Then
       MsgBox "Error en Begin Transaction", vbCritical, TITSISTEMA
       Exit Function
    End If
    
    For I% = 2 To Grid1.Rows - 1
         If Grid1.TextMatrix(I%, 0) = "0" Then Exit For
         Envia = Array("I", _
                       Trim(Right(Grid1.TextMatrix(I%, 0), 5)), _
                       CDbl(Grid1.TextMatrix(I%, 1)), _
                       CDbl(Grid1.TextMatrix(I%, 2)), _
                       CDbl(Grid1.TextMatrix(I%, 3)), _
                       CDbl(Grid1.TextMatrix(I%, 4)))
        
        If Not Bac_Sql_Execute("SP_GRABAR_POSICION_GRUPO", Envia) Then
            
            Envia = Array("R")
            
            If Not Bac_Sql_Execute("SP_BCR_TRANSACTION", Envia) Then
                MsgBox "Error en RollBack Transaction", vbCritical, TITSISTEMA
                Grid1.SetFocus
                Exit Function
            End If
            
            MsgBox "No se puede Grabar problema con la comunicacion", vbCritical, TITSISTEMA
            Grid1.SetFocus
            
            Exit Function
        
        End If
    
    Next I%
   
    Envia = Array("C")
    If Not Bac_Sql_Execute("SP_BCR_TRANSACTION", Envia) Then
        MsgBox "Error en Commit Transaction", vbCritical, TITSISTEMA
        Exit Function
    End If
    
    MsgBox "Grabación Realizada con Exito", vbInformation, TITSISTEMA
    
End Function

Private Function Elimina()
   
    res = MsgBox("Esta seguro que desea Eliminar?", vbYesNo + vbQuestion, TITSISTEMA)
    If res = vbYes Then

         Dim I%
         Dim datos()
         
         Envia = Array("B")
         If Not Bac_Sql_Execute("SP_BCR_TRANSACTION", Envia) Then
            MsgBox "Error en Begin Transaction", vbCritical, TITSISTEMA
            Exit Function
         End If
         
         For I% = 2 To Grid1.Rows - 1
              
              Envia = Array("E", _
                            Grid1.TextMatrix(I%, 0))

             If Not Bac_Sql_Execute("SP_GRABAR_POSICION_GRUPO", Envia) Then
                 
                 Envia = Array("R")
                 
                 If Not Bac_Sql_Execute("SP_BCR_TRANSACTION", Envia) Then
                     MsgBox "Error en RollBack Transaction", vbCritical, TITSISTEMA
                     Grid1.SetFocus
                     Exit Function
                 End If
                 
                 MsgBox "No se puede Eliminar problema con la comunicacion", vbCritical, TITSISTEMA
                 Grid1.SetFocus
                 
                 Exit Function
             
             End If
         
         Next I%
        
         Envia = Array("C")
         If Not Bac_Sql_Execute("SP_BCR_TRANSACTION", Envia) Then
             MsgBox "Error en Commit Transaction", vbCritical, TITSISTEMA
             Exit Function
         End If
         
         MsgBox "Eliminacion Realizada con Exito", vbInformation, TITSISTEMA

    End If
End Function

Private Function Busca()
    Dim I%
    Dim datos()
    
    Envia = Array("B")
    If Not Bac_Sql_Execute("SP_GRABAR_POSICION_GRUPO", Envia) Then
       MsgBox "Error en SqlServer", vbCritical, TITSISTEMA
       Exit Function
    End If
    
    Grid1.Rows = Grid1.FixedRows
    
    Do While Bac_SQL_Fetch(datos())
        Grid1.Rows = Grid1.Rows + 1
        Grid1.Row = Grid1.Rows - 1
        Grid1.TextMatrix(Grid1.Row, 0) = datos(1) + Space(100) + datos(2)
        Grid1.TextMatrix(Grid1.Row, 1) = Format(datos(3), FDecimal)
        Grid1.TextMatrix(Grid1.Row, 2) = Format(datos(4), FDecimal)
        Grid1.TextMatrix(Grid1.Row, 3) = Format(datos(5), FDecimal)
        Grid1.TextMatrix(Grid1.Row, 4) = Format(datos(6), FDecimal)
        Toolbar1.Buttons(2).Enabled = True
        Toolbar1.Buttons(3).Enabled = True
    Loop
    
    If Grid1.Rows = Grid1.FixedRows Then
        Call InsertarRow(Grid1)
    End If
    
    Grid1.Col = 0
    Grid1.Row = Grid1.FixedRows
    
End Function

Private Function PROC_CALCULO()
    Grid1.TextMatrix(Grid1.Row, 3) = IIf((Grid1.TextMatrix(Grid1.Row, 1) - Grid1.TextMatrix(Grid1.Row, 2)) < 0, 0, (Grid1.TextMatrix(Grid1.Row, 1) - Grid1.TextMatrix(Grid1.Row, 2)))
    Grid1.TextMatrix(Grid1.Row, 4) = IIf(Grid1.TextMatrix(Grid1.Row, 1) >= Grid1.TextMatrix(Grid1.Row, 2), 0, Abs((Grid1.TextMatrix(Grid1.Row, 1) - Grid1.TextMatrix(Grid1.Row, 2))))
    Grid1.TextMatrix(Grid1.Row, 3) = Format(Grid1.TextMatrix(Grid1.Row, 3), FDecimal)
    Grid1.TextMatrix(Grid1.Row, 4) = Format(Grid1.TextMatrix(Grid1.Row, 4), FDecimal)
End Function


Private Sub Genera_Informe()
    On Error GoTo ErrorImpresion
    
    Call Limpiar_Cristal
    
    BacControlFinanciero.CryFinanciero.Destination = Via
    BacControlFinanciero.CryFinanciero.ReportFileName = gsRPT_Path & "BacInformeExp_Maxima.rpt"
    BacControlFinanciero.CryFinanciero.Connect = swConeccion
    BacControlFinanciero.CryFinanciero.Action = 1
Exit Sub
ErrorImpresion:
    MsgBox Err.Description, vbExclamation, TITSISTEMA
End Sub


Private Function Carga_Datos()
   
   Dim datos()
    
    Envia = Array("BTR")
    If Not Bac_Sql_Execute("SP_EXPOSICION_MAXIMA_ACTUALIZA_INICIO", Envia) Then
       MsgBox "Error en SqlServer", vbCritical, TITSISTEMA
       Exit Function
    End If
    
    Envia = Array("BEX")
    If Not Bac_Sql_Execute("SP_EXPOSICION_MAXIMA_ACTUALIZA_INICIO", Envia) Then
       MsgBox "Error en SqlServer", vbCritical, TITSISTEMA
       Exit Function
    End If
   
End Function

