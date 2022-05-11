VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "comdlg32.ocx"
Begin VB.Form FRM_MNT_PRIORIDAD_MONEDAS 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Prioridad de Monedas"
   ClientHeight    =   5280
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   5565
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   5280
   ScaleWidth      =   5565
   Begin VB.Frame Frame1 
      Height          =   4605
      Left            =   90
      TabIndex        =   1
      Top             =   600
      Width           =   5355
      Begin BACControles.TXTNumero TxtPrioridad 
         Height          =   285
         Left            =   1005
         TabIndex        =   2
         Top             =   3855
         Width           =   1155
         _ExtentX        =   2037
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
         Min             =   "0"
         Max             =   "60000"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin MSFlexGridLib.MSFlexGrid Grd_datos 
         Height          =   4185
         Left            =   165
         TabIndex        =   3
         Top             =   225
         Width           =   5025
         _ExtentX        =   8864
         _ExtentY        =   7382
         _Version        =   393216
         Cols            =   3
         FixedCols       =   0
         BackColor       =   -2147483639
         ForeColor       =   -2147483641
         BackColorFixed  =   -2147483644
         ForeColorFixed  =   -2147483641
         Enabled         =   -1  'True
         AllowUserResizing=   2
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
   End
   Begin MSComctlLib.Toolbar Tbl_Opciones 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   5565
      _ExtentX        =   9816
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Grabar"
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   9
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Buscar"
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   6
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComDlg.CommonDialog MiCommand 
         Left            =   2550
         Top             =   15
         _ExtentX        =   847
         _ExtentY        =   847
         _Version        =   393216
      End
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   4380
         Top             =   60
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   22
         ImageHeight     =   22
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   11
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_PRIORIDAD_MONEDAS.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_PRIORIDAD_MONEDAS.frx":0EDA
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_PRIORIDAD_MONEDAS.frx":1DB4
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_PRIORIDAD_MONEDAS.frx":2C8E
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_PRIORIDAD_MONEDAS.frx":3B68
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_PRIORIDAD_MONEDAS.frx":4A42
               Key             =   ""
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_PRIORIDAD_MONEDAS.frx":4D5C
               Key             =   ""
            EndProperty
            BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_PRIORIDAD_MONEDAS.frx":5C36
               Key             =   ""
            EndProperty
            BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_PRIORIDAD_MONEDAS.frx":6B10
               Key             =   ""
            EndProperty
            BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_PRIORIDAD_MONEDAS.frx":6F62
               Key             =   ""
            EndProperty
            BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_PRIORIDAD_MONEDAS.frx":727C
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
End
Attribute VB_Name = "FRM_MNT_PRIORIDAD_MONEDAS"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Const Cons_CodMoneda = 0
Const Cons_GlosaMoneda = 1
Const Cons_Prioridad = 2


Private Sub Proc_Grabar()
Dim nContador1 As Integer
Dim nContador2 As Integer
         
With Grd_datos
    
   If MsgBox("¿ Esta seguro que desea actualizar los valores. ? ", vbQuestion + vbYesNo, App.Title) = vbNo Then
      Exit Sub
   End If
   
   For nContador2 = 1 To .Rows - 1
        If Trim(.TextMatrix(nContador2, Cons_CodMoneda)) = "" Or Trim(.TextMatrix(nContador2, Cons_GlosaMoneda)) = "" _
        Or Trim(.TextMatrix(nContador2, Cons_Prioridad)) = "" Then
               
             MsgBox "Registro incompleto, revizar para grabar", vbInformation
            .Col = Cons_Tipo: .CellBackColor = vbRed
            .Col = Cons_TasaRef: .CellBackColor = vbRed
            .Row = nContador2
            .SetFocus
             Exit Sub
        End If
    Next nContador2
       
    For nContador1 = 1 To .Rows - 1
        Envia = Array()
        AddParam Envia, CDbl(Trim(.TextMatrix(nContador1, Cons_CodMoneda)))
          
        If Not Bac_Sql_Execute("SP_DELMONEDAPRIORIDAD", Envia) Then
           Let Screen.MousePointer = vbDefault
           Call MsgBox("Error en proceso." & vbCrLf & "No se ha podido iniciar la actualización de la Información.", vbExclamation, App.Title)
           Exit Sub
        End If
    Next nContador1
  
         
    For nContador1 = 1 To .Rows - 1
       Envia = Array()
       AddParam Envia, CDbl(Trim(.TextMatrix(nContador1, Cons_CodMoneda)))
       AddParam Envia, bacTranMontoSql(CDbl(Trim(.TextMatrix(nContador1, Cons_Prioridad))))
       
       If Not Bac_Sql_Execute("SP_ACTMONEDAPRIORIDAD", Envia) Then
            bRespuesta = Bac_Sql_Execute("ROLLBACK TRAN")
            Screen.MousePointer = vbDefault
            MsgBox "Ha ocurrido un error al intentar grabar la informacion", vbCritical
            Exit Sub
       End If
    Next nContador1
    
    bRespuesta = Bac_Sql_Execute("COMMIT TRAN")
    Screen.MousePointer = vbDefault
    MsgBox "La informacion ha sido grabada con exito", vbInformation, TITSISTEMA
    Call Proc_NombresGrilla
End With
Tbl_Opciones.Buttons("Grabar").Enabled = False
End Sub
Private Sub Proc_Buscar()
    Dim Datos()
    Dim nContador1 As Integer
    Dim nContador2 As Integer
    
    If Not Bac_Sql_Execute("SP_CONPRIORIDADMONEDAS") Then
       Call MsgBox("Problemas al Leer Instrumento", vbCritical, App.Title)
       Let Buscar = False
       Exit Sub
    End If
    With Grd_datos
            .Rows = 1
            Do While Bac_SQL_Fetch(Datos())
                    .Rows = .Rows + 1
                    .TextMatrix(.Rows - 1, Cons_CodMoneda) = Trim(Datos(1))
                    .TextMatrix(.Rows - 1, Cons_GlosaMoneda) = Trim(Datos(3))
                    .TextMatrix(.Rows - 1, Cons_Prioridad) = Trim(Format(Datos(4), FEntero))
            Loop
            .Row = 0
            
            If .Rows > 1 Then
                .AllowUserResizing = flexResizeColumns
            Else
                .AllowUserResizing = flexResizeNone
            End If
    End With
    Tbl_Opciones.Buttons("Grabar").Enabled = True
        
End Sub

Private Sub Proc_NombresGrilla()
    
  With Grd_datos
    
    .Rows = 2:         .FixedRows = 1
    .Cols = 3:         .FixedCols = 0

    .Font.Name = "Tahoma"
    .Font.Size = 8
    .RowHeightMin = 315
    .TextMatrix(0, Cons_CodMoneda) = "Cod.Moneda"
    .TextMatrix(0, Cons_GlosaMoneda) = "Moneda"
    .TextMatrix(0, Cons_Prioridad) = "Prioridad"
         
    .ColWidth(Cons_CodMoneda) = 0
    .ColWidth(Cons_GlosaMoneda) = 3000
    .ColWidth(Cons_Prioridad) = 1000
    
    .Rows = 1
    .AddItem ""
  End With
End Sub
Private Sub Form_Load()
    Me.Icon = BACSwapParametros.Icon
    Me.Top = 0:        Me.Left = 0
    Call Proc_NombresGrilla
    TxtPrioridad.Visible = False
    Call Proc_Buscar
End Sub
Private Sub Grd_Datos_DblClick()
    If Grd_datos.Enabled = False Then Exit Sub
            
    With Grd_datos
       
        Select Case .Col
            
            Case Cons_Prioridad
                 TxtPrioridad.Text = Trim(.TextMatrix(.Row, Cons_Prioridad))
                 TxtPrioridad.Visible = True
                 TxtPrioridad.Width = .ColWidth(.Col)
                 TxtPrioridad.Left = .Left + .CellLeft
                 TxtPrioridad.Top = .Top + .CellTop
                 TxtPrioridad.SetFocus
                 
                If KeyAscii > 47 And KeyAscii < 58 Then Text2.Text = Chr(KeyAscii)
                
                If Me.TxtPrioridad.Visible = True Then
                    Grd_datos.ScrollBars = flexScrollBarVertical = False
                Else
                    Grd_datos.ScrollBars = flexScrollBarVertical = True
                End If
                      
        End Select
                 
    End With
End Sub
Private Sub Grd_datos_KeyPress(KeyAscii As Integer)
    If Not IsNumeric(Chr(KeyAscii)) And UCase(Chr(KeyAscii)) < "A" And UCase(Chr(KeyAscii)) > "Z" And KeyAscii <> 13 And KeyAscii <> 8 Then
        KeyAscii = 0
    End If
   
    If KeyAscii = 13 Then
        Call Grd_Datos_DblClick
    End If
End Sub
Private Sub Tbl_Opciones_ButtonClick(ByVal Button As MSComctlLib.Button)
    Select Case Button.Key
    
        Case "Buscar"
            Call Proc_Buscar
               
        Case "Grabar"
            Call Proc_Grabar
        
        Case "Salir"
            Unload Me
            Exit Sub
    End Select
End Sub

Private Sub TxtPrioridad_KeyDown(KeyCode As Integer, Shift As Integer)
 Dim nContador As Integer
    Select Case KeyCode
        Case vbKeyReturn
            With Grd_datos
                            
                      .TextMatrix(.Row, Cons_Prioridad) = Trim(TxtPrioridad.Text)
                      TxtPrioridad.Visible = False
                      .Col = Cons_Prioridad
                      .SetFocus
                                                      
            End With
        Case vbKeyEscape
            TxtPrioridad.Visible = False
            Grd_datos.SetFocus
    End Select
End Sub
Private Sub TxtPrioridad_LostFocus()
    TxtPrioridad.Visible = False
     
    If Me.TxtPrioridad.Visible = True Then
        Grd_datos.ScrollBars = flexScrollBarVertical = False
    Else
        Grd_datos.ScrollBars = flexScrollBarVertical
    End If
End Sub


