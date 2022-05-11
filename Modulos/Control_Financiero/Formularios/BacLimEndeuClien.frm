VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "Msflxgrd.ocx"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacLimEndeuClien 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantención de Activo Circulante por Cliente"
   ClientHeight    =   3765
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   7920
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   3765
   ScaleWidth      =   7920
   Begin VB.PictureBox ConCheck 
      BorderStyle     =   0  'None
      Height          =   315
      Index           =   1
      Left            =   2550
      Picture         =   "BacLimEndeuClien.frx":0000
      ScaleHeight     =   315
      ScaleWidth      =   465
      TabIndex        =   2
      Top             =   2520
      Visible         =   0   'False
      Width           =   465
   End
   Begin VB.PictureBox SinCheck 
      BorderStyle     =   0  'None
      Height          =   315
      Index           =   1
      Left            =   3630
      Picture         =   "BacLimEndeuClien.frx":015A
      ScaleHeight     =   315
      ScaleWidth      =   345
      TabIndex        =   1
      Top             =   2520
      Visible         =   0   'False
      Width           =   345
   End
   Begin BACControles.TXTNumero Txt_Ing_Cap 
      Height          =   285
      Left            =   2730
      TabIndex        =   0
      Top             =   1740
      Visible         =   0   'False
      Width           =   1455
      _ExtentX        =   2566
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
      Text            =   "0,00"
      Text            =   "0,00"
      CantidadDecimales=   "2"
      Separator       =   -1  'True
      MarcaTexto      =   -1  'True
   End
   Begin BACControles.TXTNumero txt_Ingreso 
      Height          =   285
      Left            =   4770
      TabIndex        =   3
      Top             =   1710
      Visible         =   0   'False
      Width           =   1410
      _ExtentX        =   2487
      _ExtentY        =   503
      ForeColor       =   8388608
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
      Min             =   "0"
      Max             =   "99999999999999"
      Separator       =   -1  'True
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   5640
      Top             =   480
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   7
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacLimEndeuClien.frx":02B4
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacLimEndeuClien.frx":0706
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacLimEndeuClien.frx":0A20
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacLimEndeuClien.frx":0D3A
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacLimEndeuClien.frx":118C
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacLimEndeuClien.frx":14A6
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacLimEndeuClien.frx":17C0
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSFlexGridLib.MSFlexGrid Grilla 
      Height          =   3225
      Left            =   0
      TabIndex        =   4
      Top             =   510
      Width           =   7875
      _ExtentX        =   13891
      _ExtentY        =   5689
      _Version        =   393216
      Cols            =   4
      FixedCols       =   0
      RowHeightMin    =   315
      BackColor       =   -2147483644
      ForeColor       =   8388608
      BackColorFixed  =   8421376
      ForeColorFixed  =   16777215
      BackColorSel    =   8388608
      ForeColorSel    =   16777215
      BackColorBkg    =   -2147483644
      GridColor       =   16777215
      GridColorFixed  =   16777215
      FocusRect       =   0
      GridLines       =   2
      GridLinesFixed  =   0
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   5
      Top             =   0
      Width           =   7920
      _ExtentX        =   13970
      _ExtentY        =   794
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   6
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Guardar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Informe de Límites"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Imprime por Pantalla"
            ImageIndex      =   7
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Actualizar"
            ImageIndex      =   6
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
End
Attribute VB_Name = "BacLimEndeuClien"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim Datos()
Dim A, i
Dim Existe, ValidaDato As Boolean

Private Sub Form_Load()
    
    Me.top = 0
    Me.Left = 0
    
    Existe = False
    
    Toolbar1.Buttons(3).Enabled = False
    Toolbar1.Buttons(1).Enabled = False
    
    Call NombresGrilla
    Call carga_grilla
    
End Sub

Sub NombresGrilla()
    With Grilla
        .Clear
        .Rows = 2
        .Cols = 6
        .Row = 0

        .Col = 0: .Text = "Rut":
        .CellAlignment = 4
        .Col = 1: .Text = "Codigo":
        .CellAlignment = 4
        .Col = 2: .Text = "Institución Financiera":
        .CellAlignment = 4
        .Col = 3: .Text = "Cap. US$":
        .CellAlignment = 4
        .Col = 4: .Text = "Activo Circulante":
        .CellAlignment = 4
        .Col = 5: .Text = "E":
        .CellAlignment = 4
                
        .ColWidth(0) = 0
        .ColWidth(1) = 0
        .ColWidth(2) = 3500
        .ColWidth(3) = 1700
        .ColWidth(4) = 2000
        .ColWidth(5) = 325
        
        
    End With
End Sub

Private Sub Grilla_Click()
    If Grilla.Col = 5 Then
        If Grilla.Rows > 1 Then
            If Trim(Grilla.TextMatrix(Grilla.Row, 5)) = "X" Then
                Grilla.TextMatrix(Grilla.Row, 5) = ""
                Set Grilla.CellPicture = Me.SinCheck(1).Image
            Else
                Set Grilla.CellPicture = Me.ConCheck(1).Image
                Grilla.TextMatrix(Grilla.Row, 5) = Space(100) & "X"
            End If
        End If
    End If
End Sub

Private Sub Grilla_DblClick()
    grilla_KeyPress 13
End Sub

Private Sub grilla_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 And KeyAscii = 8 Then
        KeyAscii = 0
    End If

    
    If IsNumeric(Chr(KeyAscii)) Or KeyAscii = 13 Then
    
        'txt_Ingreso.text = ""
        'PROC_POSICIONA_TEXTO Grilla, txt_Ingreso
        
        If Grilla.Col = 4 Then
            txt_Ingreso.Text = ""
            PROC_POSICIONA_TEXTO Grilla, txt_Ingreso
            txt_Ingreso.CantidadDecimales = 0
            txt_Ingreso.Tag = Grilla.Text
            
            If KeyAscii = 13 Then
                txt_Ingreso.Text = Grilla.Text
            Else
                txt_Ingreso.Text = IIf(KeyAscii = 13, 0, Chr(KeyAscii))
            End If
            
            txt_Ingreso.Visible = True
            txt_Ingreso.SetFocus
            
        ElseIf Grilla.Col = 3 Then
        
            Txt_Ing_Cap.Text = ""
            PROC_POSICIONA_TEXTO Grilla, Txt_Ing_Cap
            
            Txt_Ing_Cap.CantidadDecimales = 2
            Txt_Ing_Cap.Tag = Grilla.Text
            
            If KeyAscii = 13 Then
                Txt_Ing_Cap.Text = Grilla.Text
            Else
                Txt_Ing_Cap.Text = IIf(KeyAscii = 13, 0, Chr(KeyAscii))
            End If
            
            Txt_Ing_Cap.Visible = True
            Txt_Ing_Cap.SetFocus

        Else
        
        End If
        
    End If

End Sub

Private Sub Grilla_Scroll()
    txt_Ingreso.Visible = False
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
    
    Screen.MousePointer = vbHourglass
    
    Select Case Button.Index
        Case 1
            If Not Existe Then
               MsgBox "No se Puede Grabar, No Existen Datos", 16, Me.Caption
            Else
                Proc_Grabar
            End If
            
        Case 2
            Existe = False
    
            Call carga_grilla
        
        Case 3
            If Not Existe Then
               MsgBox "No se Puede Imprimir, los Datos no Estan Guardados", 16, Me.Caption
            Else
                Proc_Imprimir (1)
            End If
        Case 4
            If Not Existe Then
               MsgBox "No se Puede Imprimir, los Datos no Estan Guardados", 16, Me.Caption
            Else
                Proc_Imprimir (0)
            End If
    
        Case 5
            Call Actualiza_Endeudamiento
        
        Case 6
            Unload Me
            
    End Select
    
    Screen.MousePointer = 0

End Sub
Private Sub Actualiza_Endeudamiento()
Dim giSQL_DatabaseIRF As String

    giSQL_DatabaseIRF = "BacTraderSuda"
    
    If Not Bac_Sql_Execute(giSQL_DatabaseIRF & "..Sp_Actualiza_Deudas") Then
        MsgBox "Problemas al Actualizar los Limites de Endeudamiento al Día", 16, Me.Caption
        Exit Sub
    Else
        Call carga_grilla
        MsgBox "Actualización Limites de Endeudamiento Terminado Correctamente", , Me.Caption
    End If

End Sub
Private Sub Proc_Grabar()
On Error GoTo Print_d

    With Grilla

    For i = 1 To .Rows - 1
        .Row = i
        
        Envia = Array()
        AddParam Envia, CDbl(.TextMatrix(.Row, 0))
        AddParam Envia, CDbl(.TextMatrix(.Row, 1))
        AddParam Envia, CDbl(.TextMatrix(.Row, 4))
        
        If Trim(Grilla.TextMatrix(Grilla.Row, 5)) = "X" Then
            AddParam Envia, 1
        Else
            AddParam Envia, 0
        End If
        
        AddParam Envia, CDbl(.TextMatrix(.Row, 3))
        
        If Not Bac_Sql_Execute(gsBac_Parametros + ".dbo.Sp_Graba_Activo_Cliente", Envia) Then
            MsgBox "Grabación de Activo Circulante Clientes con Problemas", 16, Me.Caption
            Exit Sub
        End If
    Next
    
    MsgBox "Grabación de Activo Circulante Clientes Correcta", vbInformation, Me.Caption
    
    End With
    
Exit Sub

Print_d:
    MsgBox Err.Description, vbCritical, Me.Caption

End Sub

Private Sub Proc_Imprimir(nWinPri As Integer)
On Error GoTo Print_d

    Call LimpiarCristal

    BacControlFinanciero.CryFinanciero.WindowTitle = "Informe de Activo Circulante Por Cliente"
    BacControlFinanciero.CryFinanciero.ReportFileName = gsRPT_Path & "inf_Activo_cliente.rpt"
    BacControlFinanciero.CryFinanciero.StoredProcParam(0) = "R"
    BacControlFinanciero.CryFinanciero.Connect = swConeccion
    BacControlFinanciero.CryFinanciero.Destination = nWinPri 'crptToWindow
    BacControlFinanciero.CryFinanciero.WindowState = crptMaximized
    BacControlFinanciero.CryFinanciero.Action = 1

Exit Sub

Print_d:
    MsgBox Err.Description, vbCritical, TITSISTEMA
    
End Sub

Private Sub carga_grilla()
On Error GoTo busca

    Envia = Array()
    AddParam Envia, "C"

    With Grilla
        .Rows = 1
        .Rows = 2
        
         If Not Bac_Sql_Execute(gsBac_Parametros + ".dbo.Sp_Llena_Grilla_Endeu_Cliente", Envia) Then
            MsgBox "Error al Cargar la Información", 16, Me.Caption
            Exit Sub
         End If
         
         Do While Bac_SQL_Fetch(Datos())
            .Row = .Rows - 1
            .TextMatrix(.Row, 0) = Datos(1)
            .TextMatrix(.Row, 1) = Datos(2)
            .TextMatrix(.Row, 2) = Datos(3)
            .TextMatrix(.Row, 3) = Format(Datos(7), "#,##0.00")
            .TextMatrix(.Row, 4) = Format(Datos(5), FEntero)
            .TextMatrix(.Row, 5) = Space(100) & Datos(6)
            .Col = 5
            If Datos(6) = "X" Then
                Set Grilla.CellPicture = Me.ConCheck(1).Image
            Else
                Set Grilla.CellPicture = Me.SinCheck(1).Image
            End If
             
            .Rows = .Rows + 1
            Existe = True
         Loop
         
         If Existe = True Then
            .Rows = .Rows - 1
            Toolbar1.Buttons(3).Enabled = True
            Toolbar1.Buttons(1).Enabled = True
         End If
    End With
    
Exit Sub

busca:
    MsgBox "Se Detectó Problemas al Buscar la Información: " & Err.Description & ". Comunique al Administrador.", vbCritical, TITSISTEMA

End Sub

Private Sub Txt_Ing_Cap_KeyPress(KeyAscii As Integer)

If Not IsNumeric(Chr(KeyAscii)) And KeyAscii <> 8 And KeyAscii <> 13 And Chr(KeyAscii) <> "," And Chr(KeyAscii) <> "." And KeyAscii <> 27 Then
        KeyAscii = 0
    End If

    If KeyAscii = 27 Then
        Txt_Ing_Cap.Text = ""
        Txt_Ing_Cap.Visible = False
        Grilla.Text = Txt_Ing_Cap.Tag
        Grilla.SetFocus
        Exit Sub
    End If

    If KeyAscii = 13 Then
        If Trim(Txt_Ing_Cap.Text) = "" Or Txt_Ing_Cap.Text < 0 Then Exit Sub
            Grilla.Text = Txt_Ing_Cap.Text
            Txt_Ing_Cap.Visible = False
            Txt_Ing_Cap.Tag = Grilla.Text
            Txt_Ing_Cap.CantidadDecimales = 4
            Txt_Ing_Cap.Max = 999999999999999#
            Grilla.SetFocus
            
    If Grilla.Rows = 2 Then Exit Sub
    
    End If

End Sub

Private Sub Txt_Ing_Cap_LostFocus()
txt_Ingreso.Visible = False
End Sub

Private Sub Txt_Ingreso_KeyPress(KeyAscii As Integer)

    If Not IsNumeric(Chr(KeyAscii)) And KeyAscii <> 8 And KeyAscii <> 13 And Chr(KeyAscii) <> "," And Chr(KeyAscii) <> "." And KeyAscii <> 27 Then
        KeyAscii = 0
    End If

    If KeyAscii = 27 Then
        txt_Ingreso.Text = ""
        txt_Ingreso.Visible = False
        Grilla.Text = txt_Ingreso.Tag
        Grilla.SetFocus
        Exit Sub
    End If

    If KeyAscii = 13 Then
        If Trim(txt_Ingreso.Text) = "" Or txt_Ingreso.Text < 0 Then Exit Sub
            Grilla.Text = txt_Ingreso.Text
            txt_Ingreso.Visible = False
            txt_Ingreso.Tag = Grilla.Text
            txt_Ingreso.CantidadDecimales = 4
            txt_Ingreso.Max = 999999999999999#
            Grilla.SetFocus
         
        If Grilla.Rows = 2 Then Exit Sub
    End If

End Sub

Private Sub txt_Ingreso_LostFocus()
    txt_Ingreso.Visible = False
End Sub

