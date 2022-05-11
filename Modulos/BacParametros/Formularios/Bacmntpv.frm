VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BACCONTROLES.OCX"
Begin VB.Form Frm_Porc_Variacion 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantención de Porcentaje de Variación"
   ClientHeight    =   4590
   ClientLeft      =   4065
   ClientTop       =   1185
   ClientWidth     =   4425
   ForeColor       =   &H00C0C0C0&
   Icon            =   "Bacmntpv.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4590
   ScaleWidth      =   4425
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   5445
      Top             =   90
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   3
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmntpv.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmntpv.frx":046E
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmntpv.frx":08C2
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   2
      Top             =   0
      Width           =   4425
      _ExtentX        =   7805
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
            Object.ToolTipText     =   "Refresh"
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
         Font3D          =   3
         Begin BACControles.TXTNumero TXTNumerico 
            Height          =   255
            Left            =   4320
            TabIndex        =   4
            Top             =   600
            Width           =   1095
            _ExtentX        =   1931
            _ExtentY        =   450
            ForeColor       =   -2147483635
            Enabled         =   -1  'True
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Text            =   "0"
            Text            =   "0"
            Separator       =   -1  'True
            MarcaTexto      =   -1  'True
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
            BackColorSel    =   8388608
            ForeColorSel    =   16777215
            GridColor       =   255
            GridColorFixed  =   8421504
            FocusRect       =   0
            GridLines       =   2
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
Attribute VB_Name = "Frm_Porc_Variacion"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit

Dim sPunto      As String
Dim Existe      As Boolean
Dim Fila, Columna As Integer

Private Sub Cmd_Grabar_Click()

   Dim Fila        As Integer
   Dim Valor       As Double
   Dim codigo      As Integer
   Dim sql         As String
    
   Screen.MousePointer = 11
   TXTNumerico.Text = 0#
   TXTNumerico.Visible = False

   If Validacion = False Then
      Exit Sub
   End If
 
   With grilla
 
      For Fila = 1 To .Rows - 1
         .Row = Fila
         If Trim(.TextMatrix(.Row, 0)) <> "" Then
           
            Envia = Array()
            AddParam Envia, CInt(.TextMatrix(.Row, 2))
            AddParam Envia, BacCtrlTransMonto(.TextMatrix(.Row, 1))
            
            If Not Bac_Sql_Execute("SP_ACTUALIZA_MDPV ", Envia) Then
               Screen.MousePointer = 0
               MsgBox "No Se Puede Grabar los Porcentajes de Variación", vbInformation, TITSISTEMA
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
    
   TXTNumerico.Visible = False
   TXTNumerico.Text = 0#
   
   grilla.Rows = 2
   Call F_BacLimpiaGrilla(grilla)
   Call LlenaGrillaPV
   'Call BacAgrandaGrilla(Grilla, 40)

   Screen.MousePointer = 0
    
End Sub

Private Sub Cmd_Salir_Click()

   TXTNumerico.Visible = False
   TXTNumerico.Text = 0
   
   Unload Me
End Sub

Private Sub Form_Load()
   Me.Top = 0
   Me.Left = 0
   
   Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                          , gsbac_fecp _
                          , gsBac_IP _
                          , gsBAC_User _
                          , "PCA" _
                          , "OPC_616" _
                          , "07" _
                          , "Ingreso a Opción Variación Porcentaje" _
                          , " " _
                          , " " _
                          , " ")
   
   Screen.MousePointer = 11
   Existe = False
   
   Call CargarParam_Vm(grilla)
   If InStr(1, CStr(Format(100#, "##0.000")), ".", 1) > 0 Then
      sPunto = "."
   Else
      sPunto = ","
   End If
   
   Call LlenaGrillaPV
   'Call BacAgrandaGrilla(grilla, 40)
   
        
   Screen.MousePointer = 0

End Sub

Private Sub LlenaGrillaPV()
   Dim sql     As String
   Dim x As Integer
   Dim Datos()
       
   With grilla
         
      If Bac_Sql_Execute("SP_LEER_MDPV") Then
      
         .Rows = .FixedRows
      
         Do While Bac_SQL_Fetch(Datos())
            x = .Rows
            .Rows = .Rows + 1
            .TextMatrix(x, 0) = Datos(2)
            .TextMatrix(x, 1) = Format(Datos(3), FDecimal)
            .TextMatrix(x, 2) = Datos(1)
            Existe = True
         Loop
         
      Else
      
         MsgBox "No Se Puede Leer los instrumento con Porcentaje de Variación", vbInformation, TITSISTEMA
         Exit Sub
      
      End If
      
      If Existe = True Then
      
         Toolbar1.Buttons(2).Enabled = True
         grilla.Enabled = True
         
      Else
      
         Toolbar1.Buttons(2).Enabled = False
         grilla.Enabled = False
      
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

Private Sub grilla_DblClick()

Call grilla_KeyPress(vbKeyReturn)

End Sub



Private Sub grilla_RowColChange()
With grilla
   Fila = .RowSel
   Columna = .ColSel
End With
End Sub


Private Sub grilla_KeyPress(KeyAscii As Integer)

With grilla

           '-----------col 0 serie   /datos(2)/
           '-----------col 1 %       /datos(3)/ 2
           '-----------col 2 codigo  /datos(1)/ 1
            
    If .Col = 1 And Trim$(.TextMatrix(.Row, 0)) <> "" And Trim$(.TextMatrix(.Row, 2)) <> "" Then
        .Enabled = False
        TXTNumerico.Visible = True
        If CDbl(.TextMatrix(.Row, .Col)) > 100# Then .TextMatrix(.Row, .Col) = 0
        TXTNumerico.Text = BacCtrlTransMonto(.TextMatrix(.Row, .Col))
        PROC_POSICIONA_TEXTOX grilla, TXTNumerico
        If KeyAscii = 13 Then
            Fila = .RowSel
            Columna = .ColSel
        End If
        TXTNumerico.SetFocus
        
        'SendKeys "{RIGHT}"    'Comienzo Izquierda
    End If
   
 End With

End Sub
Sub MoverPunteros()
With grilla
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
   Dim sql         As String
   
   Screen.MousePointer = 11
   
   
   
   Select Case Button.Index
      Case 1
         
         TXTNumerico.Visible = False
         TXTNumerico.Text = 0#
         
         grilla.Rows = 1
                
         Call F_BacLimpiaGrilla(grilla)
         Call LlenaGrillaPV
         'Call BacAgrandaGrilla(Grilla, 40)
               
      Case 2
         TXTNumerico.Text = 0#
         TXTNumerico.Visible = False
         
         If Validacion = False Then
            Exit Sub
         End If
 
         With grilla
         
            For Fila = 1 To .Rows - 1

               If Trim(.TextMatrix(Fila, 0)) <> "" Then
         
                  Envia = Array()
                  AddParam Envia, CInt(.TextMatrix(Fila, 2))
                  AddParam Envia, CDbl(.TextMatrix(Fila, 1))
                  
                  If Not Bac_Sql_Execute("SP_ACTUALIZA_MDPV ", Envia) Then
                     Screen.MousePointer = 0
                     MsgBox "No Se Puede Grabar los Porcentajes de Variación", vbInformation, TITSISTEMA
                     Exit Sub
                  Else
                    Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                                    , gsbac_fecp _
                                    , gsBac_IP _
                                    , gsBAC_User _
                                    , "PCA" _
                                    , "OPC_616 " _
                                    , "01" _
                                    , "Grabación, Porcentajes de Variación " _
                                    , "Porcentaje_Variacion" _
                                    , " " _
                                    , "Grabación, Porcentajes de Variación " & " " & Str(CInt(.TextMatrix(Fila, 2))) & " " & Str(CDbl(.TextMatrix(Fila, 1))))
                    ' Screen.MousePointer = 0
                    ' MsgBox "Grabación de Porcentajes de Variación Correctamente", vbInformation, TITSISTEMA
                    ' Exit Sub
                  End If
         
               End If
         
            Next Fila
         
         End With
         Screen.MousePointer = 0
         MsgBox "Grabación de Porcentajes de Variación Correctamente", vbInformation, TITSISTEMA
         Exit Sub
         Call LlenaGrillaPV
         'Call BacAgrandaGrilla(Grilla, 40)
         
      Case 3
         
         TXTNumerico.Visible = False
         TXTNumerico.Text = 0
         
         Screen.MousePointer = 0
          Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                                    , gsbac_fecp _
                                    , gsBac_IP _
                                    , gsBAC_User _
                                    , "PCA" _
                                    , "OPC_616 " _
                                    , "08" _
                                    , "Salir Opcion De Variación de Porcentajes" _
                                    , " " _
                                    , " " _
                                    , " ")
         Unload Me
        
   End Select
   
   
   Screen.MousePointer = 0
   
End Sub

Private Sub txtNumerico_KeyPress(KeyAscii As Integer)
Dim Valor#
With grilla
   Select Case KeyAscii
      Case vbKeyReturn
      '========================================
         Valor# = Format(TXTNumerico.Text, "##0.00")
         If (Valor > 100 Or Valor < 0) Then
            MsgBox " El Porcentaje debe ser Mayor o Igual a 0 y Menor Igual a 100", 16, TITSISTEMA
            TXTNumerico.Text = BacCtrlTransMonto(.TextMatrix(.Row, 1))
            KeyAscii = 0
            TXTNumerico.SetFocus
            Exit Sub
         End If
         
         
         .TextMatrix(.Row, .Col) = Format(TXTNumerico.Text, FDecimal)
         TXTNumerico.Text = 0
         .Enabled = True
         TXTNumerico.Visible = False
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
         TXTNumerico.Text = " "
         TXTNumerico.Visible = False
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
  
With grilla
 
    For Fila = 1 To .Rows - 1
    
        
            
       If Trim(.TextMatrix(Fila, 0)) <> "" Then
        
            Instrumento$ = .TextMatrix(Fila, 0)
            Valor# = CDbl(.TextMatrix(Fila, 1))
            
            If Valor# < 0 Or Valor > 100 Then
                Screen.MousePointer = 0
                MsgBox " El Porcentaje debe ser Mayor o Igual a 0 y Menor Igual a 100 para el : " & Instrumento$, 32, TITSISTEMA
               '.Col = 1: .SetFocus
               Exit Function
            End If
            
       End If
       
    Next Fila
    
End With

            Validacion = True

End Function

Private Sub txtNumerico_LostFocus()

   TXTNumerico.Visible = False
   grilla.Enabled = True

End Sub
