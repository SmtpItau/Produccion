VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacMntArt84 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantención Endeudamiento"
   ClientHeight    =   6210
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   8985
   Icon            =   "MntArticulo84.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   6210
   ScaleWidth      =   8985
   Visible         =   0   'False
   Begin BACControles.TXTNumero porcentaje 
      Height          =   255
      Left            =   2280
      TabIndex        =   6
      Top             =   2640
      Visible         =   0   'False
      Width           =   1575
      _ExtentX        =   2778
      _ExtentY        =   450
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
      SelStart        =   1
   End
   Begin Threed.SSPanel SSPanel1 
      Height          =   1215
      Left            =   0
      TabIndex        =   5
      Top             =   600
      Width           =   9015
      _Version        =   65536
      _ExtentX        =   15901
      _ExtentY        =   2143
      _StockProps     =   15
      BackColor       =   13160660
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Font3D          =   2
      Alignment       =   1
      Begin BACControles.TXTNumero Txt_Global 
         Height          =   255
         Left            =   6240
         TabIndex        =   7
         Top             =   120
         Width           =   2415
         _ExtentX        =   4260
         _ExtentY        =   450
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
      Begin BACControles.TXTNumero Patrimonio 
         Height          =   255
         Left            =   2280
         TabIndex        =   8
         Top             =   120
         Width           =   2415
         _ExtentX        =   4260
         _ExtentY        =   450
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
      Begin BACControles.TXTNumero Txt_Individual 
         Height          =   255
         Left            =   6240
         TabIndex        =   9
         Top             =   720
         Width           =   2415
         _ExtentX        =   4260
         _ExtentY        =   450
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
      Begin VB.Label Label3 
         Caption         =   "% Individual"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   4920
         TabIndex        =   2
         Top             =   720
         Width           =   1575
      End
      Begin VB.Label Label2 
         Caption         =   "% Global"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   4920
         TabIndex        =   3
         Top             =   120
         Width           =   1215
      End
      Begin VB.Label Label1 
         Caption         =   "Activo Depurado"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   120
         TabIndex        =   4
         Top             =   120
         Width           =   1815
      End
   End
   Begin MSFlexGridLib.MSFlexGrid Art84 
      Height          =   4455
      Left            =   0
      TabIndex        =   1
      Top             =   1800
      Visible         =   0   'False
      Width           =   9015
      _ExtentX        =   15901
      _ExtentY        =   7858
      _Version        =   393216
      BackColor       =   16777215
      BackColorBkg    =   -2147483633
      Enabled         =   0   'False
      FocusRect       =   2
      HighLight       =   2
      GridLines       =   2
      GridLinesFixed  =   0
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
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   6240
      Top             =   0
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
            Picture         =   "MntArticulo84.frx":000C
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "MntArticulo84.frx":0460
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "MntArticulo84.frx":08B4
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "MntArticulo84.frx":0D08
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "MntArticulo84.frx":0E64
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   8985
      _ExtentX        =   15849
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   5
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Refrescar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.Visible         =   0   'False
            Object.ToolTipText     =   "Genera Informe"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Eliminar"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   4
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "BacMntArt84"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Function Imprimir()
''''''On Error GoTo Err_Impre
''''''
'''''''' Call LimpiarCristal
''''''''    BacControlFinanciero.Cristal.ReportFileName = gsRPT_Path & "Articulo84.rpt"
''''''''    BacControlFinanciero.Cristal.Destination = crptToWindow
''''''''    BacControlFinanciero.Cristal.WindowState = crptMaximized
''''''''    BacControlFinanciero.Cristal.WindowTitle = " Informe de Clientes / Articulo 84"
''''''''    BacControlFinanciero.Cristal.Connect = swConeccion
''''''''    BacControlFinanciero.Cristal.Action = 1
''''''
''''''Exit Function
''''''
''''''Err_Impre:
''''''   ErrorInforme BacControlFinanciero.Cristal.ReportFileName
''''''
End Function

Sub Eliminar()

    With Art84

       If .Rows > 2 Then
          res = MsgBox("¿Esta seguro que desea eliminar?", vbQuestion + vbYesNo, TITSISTEMA)
          
          If res = 6 Then
             
             Envia = Array()
             AddParam Envia, CDbl(.TextMatrix(.Row, 7))
             AddParam Envia, CDbl(.TextMatrix(.Row, 6))
             
             If Not Bac_Sql_Execute("SP_ELIMINACLIENTESENDEUDA", Envia) Then
                MsgBox "Error en SqlServer", vbCritical, TITSISTEMA
                Exit Sub
             Else
                Call CargarGrid
             End If
             
          End If
          
       End If
       
    End With
    
End Sub

Sub Grabar()
On Error GoTo Errorr
    Dim i%
    Dim Datos()
       
    Envia = Array("B")
    If Not Bac_Sql_Execute("SP_BCR_TRANSACTION", Envia) Then
       MsgBox "Error en Begin Transaction", vbCritical, TITSISTEMA
       Exit Sub
    
    End If
    
    For i% = 2 To Art84.Rows - 1
         
         Envia = Array(CDbl(Art84.TextMatrix(i%, 7)), _
                       CDbl(Art84.TextMatrix(i%, 6)), _
                       0, _
                       CDbl(Art84.TextMatrix(i%, 3)), _
                       CDbl(Txt_Global.Text), _
                       CDbl(Txt_Individual.Text))
        
        If Not Bac_Sql_Execute("SP_CLIENTE_ENDEUDA_GRABAR", Envia) Then
            
            Envia = Array("R")
            
            If Not Bac_Sql_Execute("SP_BCR_TRANSACTION", Envia) Then
                MsgBox "Error en RollBack Transaction", vbCritical, TITSISTEMA
                Art84.SetFocus
                Exit Sub
            
            End If
            
            MsgBox "No se puede Grabar", vbCritical, TITSISTEMA
            Art84.SetFocus
            Exit Sub
        
        End If
    
    Next i%
   
    Envia = Array("C")
    If Not Bac_Sql_Execute("SP_BCR_TRANSACTION", Envia) Then
        MsgBox "Error en Commit Transaction", vbCritical, TITSISTEMA
        Exit Sub
        
    End If
    
    MsgBox "Grabación Realizada con Exito", vbInformation, TITSISTEMA
    Call CargarGrid

    Exit Sub
Errorr:
MsgBox "Datos Mal Ingresados Verifique", vbCritical, TITSISTEMA
        Art84.SetFocus

End Sub

Sub Busca()
    Dim i%
    Dim Datos()
    
    Call CargaPatrimonio
    
    If Not Bac_Sql_Execute("SP_BUSCACLIENTESENDEUDA") Then
       MsgBox "Error en SqlServer", vbCritical, TITSISTEMA
       Exit Sub
       
    End If
    
    Art84.Rows = Art84.FixedRows
    Txt_Global.Text = 0
    Txt_Individual.Text = 0
    
    Do While Bac_SQL_Fetch(Datos())
        Art84.Rows = Art84.Rows + 1
        Art84.Row = Art84.Rows - 1
        Art84.TextMatrix(Art84.Row, 0) = Datos(7)                       'Nombre
        Art84.TextMatrix(Art84.Row, 1) = Format(Datos(3), FDecimal)     'Porcentaje Endeudamiento
        Art84.TextMatrix(Art84.Row, 2) = Format(Datos(4), FEntero)      'Monto Endeudamiento
        Art84.TextMatrix(Art84.Row, 3) = Format(Datos(4), FEntero)      'Monto Endeudamiento
        Art84.TextMatrix(Art84.Row, 4) = Format(Datos(5), FEntero)      'Monto Garantia
        Art84.TextMatrix(Art84.Row, 5) = Format(Datos(6), FEntero)      'Monto Utilizado
        Art84.TextMatrix(Art84.Row, 6) = Datos(2)                       'Codigo
        Art84.TextMatrix(Art84.Row, 7) = Datos(1)                       'Rut
'        Art84.TextMatrix(Art84.Row, 8) = Val(Datos(8))                  'Tipo de Cliente
        
        Txt_Global.Text = Datos(3)
        Txt_Individual.Text = Datos(9)
        
    Loop
    
    Art84.ColWidth(1) = 0
    Art84.ColWidth(2) = 0
    Art84.ColWidth(7) = 0
    
    If Art84.Rows = Art84.FixedRows Then
        Call InsertarRow
    End If
    
    Art84.Col = 0
    Art84.Row = Art84.FixedRows
   
End Sub

Sub textovisible()
   Dim i%

If Art84.Col = 1 Then            'Porcentaje de Endeudamiento
   Call PROC_POSICIONA_TEXTO(Art84, porcentaje)
   porcentaje.Visible = True
   porcentaje.SetFocus

''''ElseIf Art84.Col = 3 Then        'Monto Garantias
''''   Call PROC_POSICIONA_TEXTO(Art84, Garantia)
''''   Garantia.Visible = True
''''   Garantia.SetFocus

End If

End Sub

Function CargaPatrimonio() As Boolean
    CargaPatrimonio = False
    
    If gsc_Parametros.DatosGenerales() Then
       Patrimonio.Text = gsc_Parametros.ePatrimonio
       
       If Patrimonio.Text = 0 Then
          MsgBox "Error Monto de Patrimonio no puede ser 0", vbCritical, TITSISTEMA
       Else
          CargaPatrimonio = True
       End If
       
    Else
       MsgBox "Error al Cargar Parametros", vbCritical, TITSISTEMA
       Exit Function
       
    End If
    
End Function

Sub InsertarRow()
    
    Art84.Rows = Art84.Rows + 1
    Art84.Row = Art84.Rows - 1
    Art84.Col = 0
    Art84.TextMatrix(Art84.Row, 0) = ""
    Art84.TextMatrix(Art84.Row, 1) = 0#
    Art84.TextMatrix(Art84.Row, 2) = 0
    Art84.TextMatrix(Art84.Row, 3) = 0
    Art84.TextMatrix(Art84.Row, 4) = 0
    Art84.TextMatrix(Art84.Row, 5) = 0
    Art84.TextMatrix(Art84.Row, 6) = 0
    
    Art84.TextMatrix(Art84.Row, 0) = ""
    Art84.TextMatrix(Art84.Row, 1) = 0 'Format(Art84.TextMatrix(Art84.Row, 1), FDecimal)
    Art84.TextMatrix(Art84.Row, 2) = 0 'Format(Art84.TextMatrix(Art84.Row, 2), FEntero)
    Art84.TextMatrix(Art84.Row, 3) = 0 'Format(Art84.TextMatrix(Art84.Row, 3), FEntero)
    Art84.TextMatrix(Art84.Row, 4) = 0 'Format(Art84.TextMatrix(Art84.Row, 4), FEntero)
    Art84.TextMatrix(Art84.Row, 5) = 0 'Format(Art84.TextMatrix(Art84.Row, 5), FEntero)
    Art84.TextMatrix(Art84.Row, 6) = 0 'Format(Art84.TextMatrix(Art84.Row, 6), FEntero)
    Art84.TextMatrix(Art84.Row, 7) = 0 'Format(Art84.TextMatrix(Art84.Row, 6), FEntero)
    
    SendKeys "{HOME}"

End Sub

Sub CargarGrid()
   
   Titulos1 = Array(" ", "           %      ", "Monto Máximo", " ", " ", " ", " ", " ")
   Titulos2 = Array("Cliente", "Endeudamiento", "Endeudamiento", "Endeudamiento", "Utilizado", " ", " ", " ")
   Anchos = Array("3000", "1000", "2000", "2000", "2000", "0", "0", "0")
   Call PROC_CARGARGRILLA(Art84, 315, 215, Anchos, Titulos1, , Titulos2)
   Art84.Col = 0
   Art84.Row = Art84.FixedRows
   Art84.Rows = Art84.Rows - 1
   Call InsertarRow
'   Art84.Enabled = False
   Call Busca
   
End Sub

Private Sub Art84_DblClick()

    With Art84
    
       'Posicionado en colunma de Clientes
       If .Col = 0 Then
           BacAyuda.Tag = "ClienteB"
           BacAyuda.Show 1
           
           If giAceptar = True Then
    
              Art84.Col = 0
              Art84.Text = RetornoAyuda3           'nombre
    
              Art84.Col = 6
              Art84.Text = RetornoAyuda2           'codiggo
    
              Art84.Col = 7
              Art84.Text = RetornoAyuda            'rut
            
              'Art84.Col = 7
              'Art84.Text = RetornoAyuda4           'tipo de cliente
            
              Toolbar1.Buttons(1).Enabled = True
              .TextMatrix(.Row, 3) = Format(Patrimonio.Text * (Txt_Individual.Text / 100), "#0,#00")
           End If
    
       End If
       
    End With
 
End Sub

Private Sub Art84_KeyDown(KeyCode As Integer, Shift As Integer)
 
 If KeyCode = 45 Then      'Insertar un Registro
             porcentaje.Visible = False
             
             'Garantia.Visible = False
             Call InsertarRow
             Art84.SetFocus
 End If
 
 If KeyCode = 46 Then       'Eliminar un Registro
             porcentaje.Visible = False
             'Garantia.Visible = False
             Call Eliminar
             SendKeys "{HOME}"
 End If
 
 If KeyCode = vbKeyF3 Then
             Call Art84_DblClick
 End If
 
End Sub

Private Sub Art84_KeyPress(KeyAscii As Integer)

    If KeyAscii > 47 And KeyAscii < 58 Then
        TeclaPre = KeyAscii
        
        If Art84.Col = 1 Or Art84.Col = 4 Then 'Or Art84.Col = 3
            Call textovisible
            
            If Art84.Col = 1 Then
                porcentaje.Text = Chr(KeyAscii)
                porcentaje.SelStart = 1
'''''            ElseIf Art84.Col = 3 Then
'''''                Garantia.Text = Chr(KeyAscii)
'''''                Garantia.SelStart = 1
            End If
            
        End If
        
    End If
    
End Sub

Private Sub Art84_Scroll()
   Art84.SetFocus
   porcentaje.Visible = False
   Garantia.Visible = False

End Sub

Private Sub Form_Load()
   Toolbar1.Buttons(1).Enabled = True
   Me.Height = 1545
   
   If CargaPatrimonio() = True Then
      Me.Top = 0
      Me.Left = 0
      Me.Height = 5940
      Call CargarGrid
      Art84.Enabled = True
      Art84.Visible = True
   End If
 
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   
   Select Case Button.Index
    Case 1
       Call Grabar
       
    Case 2
       Call Busca
       
    Case 3
       Call Imprimir
       
    Case 4
       Call Eliminar
       
    Case 5
       Unload Me
       
   End Select

End Sub

Private Sub TXT_Individual_KeyPress(KeyAscii As Integer)
Dim i As Integer

        If KeyAscii = vbKeyReturn Then
            
           With Art84
           
                For i = 2 To .Rows - 1
                    .TextMatrix(i, 3) = Format(Patrimonio.Text * (Txt_Individual.Text / 100), "#0,#00")
                
                Next
           
           End With
            
        End If


End Sub
