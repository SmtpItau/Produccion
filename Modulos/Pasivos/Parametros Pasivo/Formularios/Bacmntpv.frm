VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "Mscomctl.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "threed32.ocx"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{989C9190-EDF5-45A8-AB6C-98E6EF0384D7}#1.0#0"; "Bac_Controles_Pas.ocx"
Begin VB.Form Frm_Porc_Variacion 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantención de Porcentaje de Variación"
   ClientHeight    =   4590
   ClientLeft      =   4155
   ClientTop       =   3195
   ClientWidth     =   4410
   BeginProperty Font 
      Name            =   "Arial"
      Size            =   8.25
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   ForeColor       =   &H00C0C0C0&
   Icon            =   "Bacmntpv.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4590
   ScaleWidth      =   4410
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   5445
      Top             =   90
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   24
      ImageHeight     =   24
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   3
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmntpv.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmntpv.frx":11E4
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmntpv.frx":20BE
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   480
      Left            =   0
      TabIndex        =   4
      Top             =   0
      Width           =   4410
      _ExtentX        =   7779
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
            Object.ToolTipText     =   "Refrescar Pantalla"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin Threed.SSPanel SSPanel1 
      Height          =   4035
      Left            =   0
      TabIndex        =   0
      Top             =   540
      Width           =   4395
      _Version        =   65536
      _ExtentX        =   7752
      _ExtentY        =   7117
      _StockProps     =   15
      Caption         =   "SSPanel1"
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
      Begin Threed.SSFrame FrmFrame 
         Height          =   3945
         Index           =   1
         Left            =   60
         TabIndex        =   1
         Top             =   15
         Width           =   4260
         _Version        =   65536
         _ExtentX        =   7514
         _ExtentY        =   6959
         _StockProps     =   14
         Caption         =   "Porcentaje de Variación"
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
         Font3D          =   3
         Begin BACControles.TXTNumero txtNumerico 
            Height          =   255
            Left            =   2070
            TabIndex        =   2
            Top             =   3000
            Visible         =   0   'False
            Width           =   1335
            _ExtentX        =   2355
            _ExtentY        =   450
            BackColor       =   -2147483634
            ForeColor       =   -2147483635
            Enabled         =   -1  'True
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Text            =   "0.0000"
            Text            =   "0.0000"
            Max             =   "100.00"
            CantidadDecimales=   "4"
            Separator       =   -1  'True
         End
         Begin MSFlexGridLib.MSFlexGrid grilla 
            Height          =   3615
            Left            =   60
            TabIndex        =   3
            Top             =   255
            Width           =   4140
            _ExtentX        =   7303
            _ExtentY        =   6376
            _Version        =   393216
            Cols            =   3
            FixedCols       =   0
            BackColor       =   -2147483644
            ForeColor       =   8388608
            BackColorFixed  =   8421376
            ForeColorFixed  =   16777215
            BackColorBkg    =   12632256
            GridColor       =   255
            FocusRect       =   0
            GridLines       =   2
            GridLinesFixed  =   0
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
   End
End
Attribute VB_Name = "Frm_Porc_Variacion"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim OptLocal    As String
Dim sPunto      As String
Dim Existe      As Boolean
Dim Fila, Columna As Integer

Private Sub Cmd_Grabar_Click()

   Dim Fila        As Integer
   Dim Valor       As Double
   Dim codigo      As Integer
   Dim Sql         As String
    
   Screen.MousePointer = 11
   txtNumerico.Text = 0#
   txtNumerico.Visible = False

   If Validacion = False Then
      Exit Sub
   End If
 
   With Grilla
 
      For Fila = 1 To .Rows - 1
         .Row = Fila
         If Trim(.TextMatrix(.Row, 0)) <> "" Then
           
            Envia = Array()
            AddParam Envia, CInt(.TextMatrix(.Row, 2))
            AddParam Envia, BacCtrlTransMonto(.TextMatrix(.Row, 1))
            
            If Not BAC_SQL_EXECUTE("SP_ACTUALIZA_MDPV ", Envia) Then
               Screen.MousePointer = 0
               MsgBox "No Se Puede Grabar los Porcentajes de Variación", vbInformation
               Exit Sub
            End If
           
         End If
      
      Next Fila
    
   End With
    
   Call LlenaGrillaPV
   'Call BacAgrandaGrilla(Grilla, 40)
    
   Screen.MousePointer = 0
    
End Sub

Private Sub Cmd_Limpiar_Click()

   Screen.MousePointer = 11
    
   txtNumerico.Visible = False
   txtNumerico.Text = 0#
   
   Grilla.Rows = 2
   Call F_BacLimpiaGrilla(Grilla)
   Call LlenaGrillaPV
   'Call BacAgrandaGrilla(Grilla, 40)

   Screen.MousePointer = 0
    
End Sub

Private Sub Cmd_Salir_Click()

   txtNumerico.Visible = False
   txtNumerico.Text = 0
   
   Unload Me
End Sub

Private Sub Form_Activate()
   PROC_CARGA_AYUDA Me, " "
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
Dim opcion As Integer

If KeyCode = vbKeyReturn And UCase(Me.ActiveControl.Name) <> "TXTNUMERICO" And UCase(Me.ActiveControl.Name) <> "GRILLA" Then
      KeyCode = 0
      Exit Sub
End If


If KeyCode <> vbKeyControl And (Shift = 2 Or (Shift = 0 And (KeyCode = vbKeyReturn Or KeyCode = vbKeyEscape Or (KeyCode >= vbKeyF1 And KeyCode <= vbKeyF12)))) Then

opcion = 0
   Select Case KeyCode

         Case vbKeyBuscar
               opcion = 1

         Case vbKeyGrabar
               opcion = 2
         
         Case vbKeySalir
              If Me.ActiveControl.Name <> "txtNumerico" Then
                  opcion = 3
              End If
   End Select

   If opcion <> 0 Then
      If Toolbar1.Buttons(opcion).Enabled Then
         Call Toolbar1_ButtonClick(Toolbar1.Buttons(opcion))
         KeyCode = 0
      End If

   End If

End If

End Sub

Private Sub Form_Load()
   OptLocal = Opt
   Me.top = 0
   Me.left = 0
   Screen.MousePointer = 11
   Existe = False
   
   Call CargarParam_Vm(Grilla)
   If InStr(1, CStr(Format(100#, "##0.000")), ".", 1) > 0 Then
      sPunto = "."
   Else
      sPunto = ","
   End If
   
   Call LlenaGrillaPV
   'Call BacAgrandaGrilla(grilla, 40)
   
        
   Screen.MousePointer = 0
   
   Call LogAuditoria("07", OptLocal, Me.Caption, "", "")
  
End Sub

Private Sub LlenaGrillaPV()
   Dim Sql     As String
   Dim X As Integer
   Dim Datos()
       
   With Grilla
         
      If BAC_SQL_EXECUTE("SP_LEER_MDPV") Then
      
         .Rows = .FixedRows
      
         Do While BAC_SQL_FETCH(Datos())
            X = .Rows
            .Rows = .Rows + 1
            .TextMatrix(X, 0) = Datos(2)
            .TextMatrix(X, 1) = Format(Datos(3), FDecimal)
            .TextMatrix(X, 2) = Datos(1)
            Existe = True
         Loop
         
      Else
      
         MsgBox "No Se Puede Leer los instrumento con Porcentaje de Variación", vbInformation
         Exit Sub
      
      End If
      
      If Existe = True Then
      
         Toolbar1.Buttons(2).Enabled = True
         Grilla.Enabled = True
         
      Else
      
         Toolbar1.Buttons(2).Enabled = False
         Grilla.Enabled = False
      
      End If
      
   
   End With
   
    'Call BacAgrandaGrilla(Grilla, 40)

End Sub


Private Sub GrdMM_KeyPress(KeyAscii As Integer)
    
    If Chr(KeyAscii) = "." Or Chr(KeyAscii) = "," Then
        KeyAscii = Asc(gsc_PuntoDecim)
    End If
    
    KeyAscii = BACValIngNumGrid(KeyAscii)
    
End Sub
Public Function CargarParam_Vm(Grillas As Object)

With Grillas
         .Rows = 2
         .Cols = 3
       
         .ColWidth(0) = 2000  'instrumento
         .ColWidth(1) = 2000  '% variacion
         .ColWidth(2) = 1     '% variacion
       
         .RowHeight(0) = 350
         .CellFontWidth = 4
         

         .Row = 0
         
         .Col = 0
         .FixedAlignment(0) = 4
         .CellFontBold = True
         .Text = " Instrumento"
         .ColAlignment(0) = 4

         .Col = 1
         .FixedAlignment(1) = 4
         .CellFontBold = True
         .Text = " % Variación "
         .ColAlignment(1) = 8
        

End With

End Function

Private Sub Form_Unload(Cancel As Integer)
    Call LogAuditoria("08", OptLocal, Me.Caption, "", "")
End Sub


Private Sub Grilla_RowColChange()
With Grilla
   Fila = .RowSel
   Columna = .ColSel
End With
End Sub


Private Sub Grilla_KeyPress(KeyAscii As Integer)

With Grilla

           '-----------col 0 serie   /datos(2)/
           '-----------col 1 %       /datos(3)/ 2
           '-----------col 2 codigo  /datos(1)/ 1
            
'If KeyAscii = vbKeyReturn Then
 If .Col = 1 And Trim$(.TextMatrix(.Row, 0)) <> "" And Trim$(.TextMatrix(.Row, 2)) <> "" And KeyAscii <> 71 And KeyAscii <> 2 Then
        .Enabled = False
        If CDbl(.TextMatrix(.Row, .Col)) > 100# Then .TextMatrix(.Row, .Col) = 0
        txtNumerico.Text = BacCtrlTransMonto(.TextMatrix(.Row, .Col))
        
        If IsNumeric(Chr(KeyAscii)) Then
        
            txtNumerico.Text = Chr(KeyAscii)
            Bac_SendKey vbKeyRight
        
        End If
                
        PROC_POSICIONA_TEXTOX Grilla, txtNumerico
        If KeyAscii = 13 Then
            Fila = .RowSel
            Columna = .ColSel
        End If
        
        txtNumerico.Visible = True
        txtNumerico.SetFocus
        
    End If
'End If
   
 End With

End Sub
Sub MoverPunteros()
With Grilla
      If .Row = .Rows - 1 Then
         .Row = 0
      Else
         .Row = .Row + 1
      End If
End With
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Dim Fila        As Integer
   Dim Valor       As Double
   Dim codigo      As Integer
   Dim Sql         As String
   
   Screen.MousePointer = 11

   Select Case Button.Index
      Case 1
         
         txtNumerico.Visible = False
         txtNumerico.Text = 0#
         
         Grilla.Rows = 1
                
         Call F_BacLimpiaGrilla(Grilla)
         Call LlenaGrillaPV
         'Call BacAgrandaGrilla(Grilla, 40)
               
      Case 2
         txtNumerico.Text = 0#
         txtNumerico.Visible = False
         
         If Validacion = False Then
            Exit Sub
         End If
 
         With Grilla
         
            For Fila = 1 To .Rows - 1

               If Trim(.TextMatrix(Fila, 0)) <> "" Then
         
                  Envia = Array()
                  AddParam Envia, CInt(.TextMatrix(Fila, 2))
                  AddParam Envia, CDbl(.TextMatrix(Fila, 1))
                  
                  If Not BAC_SQL_EXECUTE("SP_ACTUALIZA_MDPV ", Envia) Then
                     Screen.MousePointer = 0
                     MsgBox "No Se Puede Grabar los Porcentajes de Variación", vbInformation
                     Call LogAuditoria("01", OptLocal, Me.Caption & " Error al grabar- Instrumento: " + .TextMatrix(Fila, 0) + " % Variación: " + .TextMatrix(Fila, 1), "", "")
                     Exit Sub
                  End If
                  Call LogAuditoria("01", OptLocal, Me.Caption, "", "Instrumento: " & .TextMatrix(Fila, 0) + " % Variación: " + .TextMatrix(Fila, 1))

               End If
         
            Next Fila
         
         End With
         MsgBox "Grabación realizada con éxito", vbOKOnly + vbInformation
         Call F_BacLimpiaGrilla(Grilla)
         Call LlenaGrillaPV
         Grilla.SetFocus

      Case 3
         
'         TXTNumerico.Visible = False
'         TXTNumerico.Text = 0
'
'         Screen.MousePointer = 0

         Unload Me
        
   End Select
   
   
   Screen.MousePointer = 0
   
End Sub

Private Sub TXTNumerico_KeyPress(KeyAscii As Integer)
Dim Valor#
With Grilla
   Select Case KeyAscii
      Case vbKeyReturn
      '========================================
         Valor# = Format(txtNumerico.Text, "##0.00")
         If (Valor > 100 Or Valor < 0) Then
            MsgBox " El Porcentaje debe ser Mayor o Igual a 0 y Menor Igual a 100", 16
            txtNumerico.Text = BacCtrlTransMonto(.TextMatrix(.Row, 1))
            KeyAscii = 0
            txtNumerico.SetFocus
            Exit Sub
         End If
         
         
         .TextMatrix(.Row, .Col) = Format(txtNumerico.Text, FDecimal)
         txtNumerico.Text = 0
         .Enabled = True
         txtNumerico.Visible = False
         .SetFocus
         If Fila = .Rows - 1 Then
            Fila = 1
            .Row = Fila
            .Col = Columna
         Else
            Fila = Fila + 1
            .Row = Fila
            .Col = Columna
            '.RowSel = .Row + 1
         End If

      Case vbKeyEscape
      '==========================================
         txtNumerico.Text = ""
         txtNumerico.Visible = False
         .Enabled = True
         .SetFocus
   End Select
End With

End Sub


Public Function Validacion() As Boolean

Dim Fila%
Dim Valor As Double
Dim Instrumento$

        Validacion = False
  
With Grilla
 
    For Fila = 1 To .Rows - 1
    
       If Trim(.TextMatrix(Fila, 0)) <> "" Then
        
            Instrumento$ = .TextMatrix(Fila, 0)
            Valor# = CDbl(.TextMatrix(Fila, 1))
            
            If Valor# < 0 Or Valor > 100 Then
                Screen.MousePointer = 0
                MsgBox " El Porcentaje debe ser Mayor o Igual a 0 y Menor Igual a 100 para el : " & Instrumento$, 32
               '.Col = 1: .SetFocus
               Exit Function
            End If
            
       End If
       
    Next Fila
    
End With

            Validacion = True

End Function

Private Sub TXTNumerico_LostFocus()

   txtNumerico.Visible = False
   Grilla.Enabled = True

End Sub
