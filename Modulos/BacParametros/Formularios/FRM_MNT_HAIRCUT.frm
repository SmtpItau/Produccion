VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "Msflxgrd.ocx"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "comdlg32.ocx"
Begin VB.Form FRM_MNT_HAIRCUT 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Haircut (SOMA)"
   ClientHeight    =   5835
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   3375
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   5835
   ScaleWidth      =   3375
   Begin VB.Frame Frame1 
      Height          =   3885
      Left            =   75
      TabIndex        =   5
      Top             =   1890
      Width           =   3240
      Begin BACControles.TXTNumero TxtTasaRef 
         Height          =   285
         Left            =   600
         TabIndex        =   8
         Top             =   2505
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
         Min             =   "-100"
         Max             =   "1000"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin VB.ComboBox Cmb_Familia 
         Height          =   315
         Left            =   480
         Style           =   2  'Dropdown List
         TabIndex        =   7
         Top             =   2040
         Width           =   1560
      End
      Begin MSFlexGridLib.MSFlexGrid Grd_datos 
         Height          =   3525
         Left            =   195
         TabIndex        =   6
         Top             =   210
         Width           =   2835
         _ExtentX        =   5001
         _ExtentY        =   6218
         _Version        =   393216
         Cols            =   4
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
   Begin VB.Frame CuadroFecha 
      Height          =   1200
      Left            =   60
      TabIndex        =   0
      Top             =   600
      Width           =   3270
      Begin VB.ComboBox Cmb_TipoOpSoma 
         Height          =   315
         Left            =   1560
         Style           =   2  'Dropdown List
         TabIndex        =   2
         Top             =   285
         Width           =   1470
      End
      Begin BACControles.TXTFecha TXTFecha 
         Height          =   300
         Left            =   1575
         TabIndex        =   1
         Top             =   705
         Width           =   1455
         _ExtentX        =   2566
         _ExtentY        =   529
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   12582912
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "02/11/2010"
      End
      Begin VB.Label LblTipoSoma 
         Caption         =   "Tipo Op. SOMA"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C00000&
         Height          =   270
         Left            =   120
         TabIndex        =   4
         Top             =   360
         Width           =   1335
      End
      Begin VB.Label LblFecha 
         Caption         =   "Fecha"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C00000&
         Height          =   225
         Left            =   165
         TabIndex        =   3
         Top             =   780
         Width           =   1200
      End
   End
   Begin MSComctlLib.Toolbar Tbl_Opciones 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   9
      Top             =   0
      Width           =   3375
      _ExtentX        =   5953
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   5
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Grabar"
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   9
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Eliminar"
            Object.ToolTipText     =   "Eliminar"
            ImageIndex      =   11
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Limpiar"
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   10
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Buscar"
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   6
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   4365
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
               Picture         =   "FRM_MNT_HAIRCUT.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_HAIRCUT.frx":0EDA
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_HAIRCUT.frx":1DB4
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_HAIRCUT.frx":2C8E
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_HAIRCUT.frx":3B68
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_HAIRCUT.frx":4A42
               Key             =   ""
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_HAIRCUT.frx":4D5C
               Key             =   ""
            EndProperty
            BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_HAIRCUT.frx":5C36
               Key             =   ""
            EndProperty
            BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_HAIRCUT.frx":6B10
               Key             =   ""
            EndProperty
            BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_HAIRCUT.frx":6F62
               Key             =   ""
            EndProperty
            BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_HAIRCUT.frx":727C
               Key             =   ""
            EndProperty
         EndProperty
      End
      Begin MSComDlg.CommonDialog MiCommand 
         Left            =   2550
         Top             =   15
         _ExtentX        =   847
         _ExtentY        =   847
         _Version        =   393216
      End
   End
End
Attribute VB_Name = "FRM_MNT_HAIRCUT"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Const Cons_CodInst = 0
Const Cons_Tipo = 1
Const Cons_ClasfRiesgo = 2
Const Cons_TasaRef = 3


Private Sub Proc_Limpiar()
       
    If MsgBox("¿ Esta seguro que desea limpiar, ¿Grabo la Información? ", vbQuestion + vbYesNo, App.Title) = vbNo Then
       Exit Sub
    End If
    Call Proc_NombresGrilla

    
    TxtTasaRef.Visible = False
    Cmb_Familia.Visible = False

End Sub

Private Sub Proc_Grabar()
Dim nContador1 As Integer
Dim nContador2 As Integer
         
With Grd_datos
    If TxtTasaRef.Visible = True Then
        Exit Sub
    End If
    
    If Cmb_Familia.Visible = True Then
        Exit Sub
    End If
   
    
   If MsgBox("¿ Esta seguro que desea actualizar los valores. ? ", vbQuestion + vbYesNo, App.Title) = vbNo Then
      Exit Sub
   End If
   
   If Trim(.TextMatrix(1, Cons_CodInst)) = "" And Trim(.TextMatrix(1, Cons_Tipo)) = "" _
       And Trim(.TextMatrix(1, Cons_TasaRef)) = 0# Then
         
        If MsgBox("¿Eliminara toda la información.?", vbQuestion + vbYesNo, App.Title) = vbNo Then
          Exit Sub
        End If
    
    Else
         
         For nContador2 = 1 To .Rows - 1
            
                If .Rows = .Rows And Trim(.TextMatrix(nContador2, Cons_CodInst)) = "" _
                Or .Rows = .Rows And Trim(.TextMatrix(nContador2, Cons_Tipo)) = "" Then
                 
                                        
                    MsgBox "Registro incompleto, revizar para grabar", vbInformation
                    .Col = Cons_Tipo: .CellBackColor = vbRed
                    .Col = Cons_TasaRef: .CellBackColor = vbRed
                    .Row = nContador2
                    .SetFocus
                    Exit Sub
                End If
          
         Next nContador2
         
        For nContador1 = 1 To .Rows - 1
             If CDbl(.TextMatrix(nContador1, Cons_TasaRef)) = Format(0, FDecimal) Then
               'Call MsgBox("No puede grabar Valor en 0,000. Revizar fila N° " & nContador1, vbInformation, App.Title)
               If MsgBox("Valores de Tasa Ref en  0,000. Revizar fila N° " & nContador1 & ", Desea Grabar? ", vbQuestion + vbYesNo, App.Title) = vbNo Then
                    .Row = nContador1
                    .Col = Cons_TasaRef: .CellBackColor = vbRed
                    .SetFocus
                     Exit Sub
               End If
             End If
                  
        Next nContador1
            
        For nContador1 = 1 To .Rows - 1
                    If CDbl(.TextMatrix(nContador1, Cons_TasaRef)) > Format(100, FEntero) _
                    Or CDbl(.TextMatrix(nContador1, Cons_TasaRef)) < Format(-100, FEntero) Then
                        Call MsgBox(" Valores de Tasa Ref no puede ser mayor que 100 ni menor que -100, Revizar fila N° " & nContador1, vbInformation, App.Title)
                        .Row = nContador1
                        .Col = Cons_TasaRef
                        .SetFocus
                        
                        Exit Sub
                    End If
                 Next nContador1
        
    End If
    
    Envia = Array()
    AddParam Envia, Trim(Left(Cmb_TipoOpSoma.Text, 10))
      
    If Not Bac_Sql_Execute("SP_DELHAIRCUTSOMA", Envia) Then
       Let Screen.MousePointer = vbDefault
       Call MsgBox("Error en proceso." & vbCrLf & "No se ha podido iniciar la actualización de la Información.", vbExclamation, App.Title)
       Exit Sub
    End If
        
    If Trim(.TextMatrix(1, Cons_CodInst)) <> "" And Trim(.TextMatrix(1, Cons_Tipo)) <> "" Then
   
         
        
        For nContador1 = 1 To .Rows - 1
            Envia = Array()
            AddParam Envia, CDbl(Trim(.TextMatrix(nContador1, Cons_CodInst)))
            AddParam Envia, Trim(.TextMatrix(nContador1, Cons_ClasfRiesgo))
            AddParam Envia, Trim(Left(Cmb_TipoOpSoma.Text, 10))
            AddParam Envia, bacTranMontoSql(CDbl(Trim(.TextMatrix(nContador1, Cons_TasaRef))))
           
            If Not Bac_Sql_Execute("SP_ACTHAIRCUTSOMA", Envia) Then
                 bRespuesta = Bac_Sql_Execute("ROLLBACK TRAN")
                 Screen.MousePointer = vbDefault
                 MsgBox "Ha ocurrido un error al intentar grabar la informacion", vbCritical
                 Exit Sub
            End If
           
         Next nContador1
    End If
            bRespuesta = Bac_Sql_Execute("COMMIT TRAN")
            Screen.MousePointer = vbDefault
            MsgBox "La informacion ha sido grabada con exito", vbInformation, TITSISTEMA
            Call Proc_NombresGrilla
   
End With
     
End Sub
Private Sub Proc_Eliminar()

    With Grd_datos
    
        If TxtTasaRef.Visible = True Then
            Exit Sub
        End If
        
        If Cmb_Familia.Visible = True Then
            Exit Sub
        End If
   
        If .Row = 0 Then
             MsgBox "No ha seleccionado ningun registro para eliminar", vbInformation
             Exit Sub
        End If
        
        If Trim(.TextMatrix(.Row, Cons_Tipo)) = "" Then
            Screen.MousePointer = vbDefault
            MsgBox "No ha seleccionado ningun registro para eliminar", vbInformation
            Exit Sub
        End If
        
        
        If MsgBox("Esta seguro de eliminar la Serie", vbQuestion + vbYesNo, TITSISTEMA) = vbNo Then
            .SetFocus
            Exit Sub
        End If
            .SetFocus
        If Cmb_Familia.Visible <> True Then
           If .Rows > 2 Then
               .RemoveItem .Row
           Else
               .TextMatrix(.Rows - 1, Cons_CodInst) = ""
               .TextMatrix(.Rows - 1, Cons_Tipo) = ""
               .TextMatrix(.Rows - 1, Cons_ClasfRiesgo) = ""
               .TextMatrix(.Rows - 1, Cons_TasaRef) = ""
               .TextMatrix(Grd_datos.Row, Cons_TasaRef) = Format(0, FDecimal)
           End If
        End If
    End With

End Sub


Private Sub Cmb_Familia_GotFocus()
     Dim nContador As Integer
     With Grd_datos

        If Trim(.TextMatrix(.Row, Cons_Tipo)) <> "" Then
            For nContador = 1 To Cmb_Familia.ListCount - 1
                If Trim(Left(Cmb_Familia.List(nContador), 10)) = Trim(.TextMatrix(.Row, Cons_Tipo)) Then
                    Cmb_Familia.ListIndex = nContador
                    Exit For
                End If
            Next nContador
        End If

    End With
End Sub


Private Sub Cmb_Familia_KeyDown(KeyCode As Integer, Shift As Integer)
    Dim nContador As Integer
    With Grd_datos
        Select Case KeyCode
            Case vbKeyReturn
            
                For nContador = 1 To .Rows - 1
                   If Trim(Right(Cmb_Familia.Text, 10)) = Trim(.TextMatrix(nContador, Cons_CodInst)) _
                   And Trim(Left(Cmb_Familia.Text, 10)) = Trim(.TextMatrix(nContador, Cons_Tipo)) And nContador <> .Row Then
                       MsgBox "Instrumento seleccionado ya existe", vbExclamation
                       .TextMatrix(.Row, Cons_TasaRef) = Format(0, FDecimal)
                       Cmb_Familia.Visible = False
                       .Col = Cons_Tipo
                       .Row = nContador
                       .CellBackColor = vbRed
                       .SetFocus
                    
                       Exit Sub
                   End If
                Next nContador
               
                .TextMatrix(.Row, Cons_Tipo) = Trim(Left(Cmb_Familia.Text, 10))
                .TextMatrix(.Row, Cons_CodInst) = Trim(Right(Cmb_Familia.Text, 10))
                .TextMatrix(.Row, Cons_TasaRef) = Format(0, FDecimal)
              
                Call Proc_CargaDatosOcultos
                Cmb_Familia.Visible = False
                
                Tbl_Opciones.Buttons("Grabar").Enabled = True
                Tbl_Opciones.Buttons("Eliminar").Enabled = True
                Tbl_Opciones.Buttons("Buscar").Enabled = True
                
            
            Case vbKeyEscape
                Cmb_Familia.Visible = False
                Grd_datos.SetFocus
        End Select
    
    End With
End Sub


Private Sub Proc_Buscar()
    Dim Datos()
    Dim nContador1 As Integer
    Dim nContador2 As Integer
    
    If TxtTasaRef.Visible = True Then
        Exit Sub
    End If
    
    If Cmb_Familia.Visible = True Then
        Exit Sub
    End If
   
    Envia = Array()
    AddParam Envia, Trim(Left(Cmb_TipoOpSoma.Text, 10))
   
    If Not Bac_Sql_Execute("SP_CONHAIRCUTSOMA", Envia) Then
       Call MsgBox("Problemas al Leer Instrumento", vbCritical, App.Title)
       Let Buscar = False
       Exit Sub
    End If
    With Grd_datos
            .Rows = 1
            Do While Bac_SQL_Fetch(Datos())
                
                If Trim(Datos(1)) = -1 Then
                  
                     Call MsgBox(Trim(Datos(2)), vbInformation, App.Title)
                    .Rows = .Rows + 1
                    .TextMatrix(.Rows - 1, Cons_CodInst) = ""
                    .TextMatrix(.Rows - 1, Cons_Tipo) = ""
                    .TextMatrix(.Rows - 1, Cons_ClasfRiesgo) = ""
                    .TextMatrix(.Rows - 1, Cons_TasaRef) = Format(0, FDecimal)
                    Exit Do
                Else
                
                    .Rows = .Rows + 1
                    .TextMatrix(.Rows - 1, Cons_CodInst) = Trim(Datos(1))
                    .TextMatrix(.Rows - 1, Cons_ClasfRiesgo) = Trim(Datos(2))
                    
                    For nContador2 = 1 To .Rows - 1
                       .Row = nContador2
                        For nContador1 = 0 To Cmb_Familia.ListCount - 1
                            If Trim(Right(Cmb_Familia.List(nContador1), 10)) = .TextMatrix(nContador2, Cons_CodInst) Then
                            
                                 If .TextMatrix(nContador2, Cons_ClasfRiesgo) = "A" Then
                                     .TextMatrix(nContador2, Cons_Tipo) = "LH-A"
                               
                                 ElseIf .TextMatrix(nContador2, Cons_ClasfRiesgo) = "AA" Then
                                     .TextMatrix(nContador2, Cons_Tipo) = "LH-AA"
                                
                                 Else
                                    .TextMatrix(nContador2, Cons_Tipo) = Trim(Left(Cmb_Familia.List(nContador1), 10))
                                 End If
                            Exit For
                            End If
                        Next nContador1
                    Next nContador2
                    
                    '.TextMatrix(.Rows - 1, Cons_ClasfRiesgo) = Trim(Datos(2))
                    .TextMatrix(.Rows - 1, Cons_TasaRef) = Format(Trim(Datos(4)), FDecimal)
                       
                End If
                              
            Loop
            .Row = 0
      End With
        Tbl_Opciones.Buttons("Grabar").Enabled = True
        Tbl_Opciones.Buttons("Eliminar").Enabled = True
        Tbl_Opciones.Buttons("Buscar").Enabled = True
End Sub

Private Sub Cmb_Familia_LostFocus()
   Cmb_Familia.Visible = False
End Sub

Private Sub Cmb_TipoOpSoma_Click()
FRM_MNT_HAIRCUT.Show
Call Proc_Buscar
 
End Sub

Private Sub Form_Load()
    Me.Icon = BACSwapParametros.Icon
    Me.Top = 0:        Me.Left = 0
    
    Call Proc_NombresGrilla
    Call Proc_CargaCmbTipoOpSoma
    Call Proc_CargaCmbFamilia
    If Me.Cmb_TipoOpSoma.ListCount > 0 Then
        Cmb_TipoOpSoma.ListIndex = 0
    End If
    
    If Me.Cmb_Familia.ListCount > 0 Then
        Cmb_Familia.ListIndex = 0
    End If
    Cmb_Familia.Visible = False
    TxtTasaRef.Visible = False
    TXTFecha.Text = gsbac_fecp
End Sub

Private Sub Proc_CargaDatosOcultos()
    With Grd_datos
        .TextMatrix(.Row, Cons_CodInst) = Trim(Right(Cmb_Familia.Text, 10))
        
        If Trim(Left(Cmb_Familia.Text, 10)) = "LH-AA" Then
            .TextMatrix(.Row, Cons_ClasfRiesgo) = "AA"
        ElseIf Trim(Left(Cmb_Familia.Text, 10)) = "LH-A" Then
            .TextMatrix(.Row, Cons_ClasfRiesgo) = "A"
        Else
            .TextMatrix(.Row, Cons_ClasfRiesgo) = ""
        End If
    End With
End Sub
Private Sub Proc_NombresGrilla()
    
  With Grd_datos
   
    Tbl_Opciones.Buttons("Grabar").Enabled = False
    Tbl_Opciones.Buttons("Eliminar").Enabled = False
    Tbl_Opciones.Buttons("Buscar").Enabled = True
    
    .Rows = 2:         .FixedRows = 1
    .Cols = 4:         .FixedCols = 0

    .Font.Name = "Tahoma"
    .Font.Size = 8
    .RowHeightMin = 315
    .TextMatrix(0, Cons_CodInst) = "CodInst"
    .TextMatrix(0, Cons_Tipo) = "Tipo Instrum."
    .TextMatrix(0, Cons_ClasfRiesgo) = "Clasf.Riesgo"
    .TextMatrix(0, Cons_TasaRef) = "Hair Cut"
     
    .ColWidth(Cons_CodInst) = 0
    .ColWidth(Cons_Tipo) = 1000
    .ColWidth(Cons_ClasfRiesgo) = 0
    .ColWidth(Cons_TasaRef) = 1000
         
    .Rows = 1
    .AddItem ""
    .TextMatrix(Grd_datos.Row, Cons_TasaRef) = Format(0, FDecimal)
     Cmb_Familia.Visible = False
     Me.TxtTasaRef.Visible = False
    
   
  End With
End Sub

Private Sub Proc_CargaCmbFamilia()
   Dim Datos()

   If Not Bac_Sql_Execute("SP_LEERFAMILIASTASAREF") Then
      Exit Sub
   End If
   Call Cmb_Familia.Clear
   Do While Bac_SQL_Fetch(Datos())
      Call Cmb_Familia.AddItem(Trim(Datos(2)) & String(80 - Len(Trim(Datos(2))), " ") & Datos(1))
   Loop
End Sub

Private Sub Proc_CargaCmbTipoOpSoma()
   Dim Datos()

   If Not Bac_Sql_Execute("SP_LEERTIPOOPSOMA") Then
      Exit Sub
   End If
   Call Cmb_TipoOpSoma.Clear
   Do While Bac_SQL_Fetch(Datos())
      Call Cmb_TipoOpSoma.AddItem(Trim(Datos(6)) & String(80 - Len(Trim(Datos(6))), " ") & Datos(2))
   Loop
End Sub

Private Sub Grd_Datos_DblClick()
    Dim nContador As Integer
    If Grd_datos.Enabled = False Then Exit Sub
            
    With Grd_datos
        Cmb_Familia.ListIndex = 0
        Select Case .Col
            Case Cons_Tipo
            
                TxtTasaRef.Visible = False
                If Cmb_Familia.ListCount > 0 Then
                    For nContador = 0 To Cmb_Familia.ListCount - 1
                        If Trim(Right(Cmb_Familia.List(nContador), 10)) = Trim(.TextMatrix(.Row, Cons_Tipo)) Then
                            Cmb_Familia.ListIndex = nContador
                            Exit For
                        End If
                    Next nContador
                
                    Cmb_Familia.ListIndex = IIf(Cmb_Familia.ListCount > 0, -1, -1)
                    Cmb_Familia.Visible = True
                    Cmb_Familia.Width = .ColWidth(.Col)
                    Cmb_Familia.Left = .Left + .CellLeft
                    Cmb_Familia.Top = .Top + .CellTop
                    Cmb_Familia.SetFocus
                End If
                     
            Case Cons_TasaRef
                 TxtTasaRef.CantidadDecimales = 4
                 TxtTasaRef.Text = Trim(.TextMatrix(.Row, Cons_TasaRef))
                 TxtTasaRef.Visible = True
                ' TxtTasaRef.Text = Replace(TxtTasaRef.Text, ".", ",")
                 TxtTasaRef.Width = .ColWidth(.Col)
                 TxtTasaRef.Left = .Left + .CellLeft
                 TxtTasaRef.Top = .Top + .CellTop
                 TxtTasaRef.SetFocus
                 
                If KeyAscii > 47 And KeyAscii < 58 Then Text2.Text = Chr(KeyAscii)
                      
        End Select
                 
    End With
End Sub


Private Sub Grd_Datos_KeyDown(KeyCode As Integer, Shift As Integer)
    With Grd_datos
        Select Case KeyCode
            Case vbKeyInsert 'Inserta
                If TxtTasaRef.Visible = True Then
                    Exit Sub
                End If
    
                If Cmb_Familia.Visible = True Then
                    Exit Sub
                End If
   
            
                If Cmb_Familia.Visible <> True Then
                   Cmb_Familia.Visible = False
                   If .TextMatrix(.Rows - 1, Cons_CodInst) <> "" And _
                      .TextMatrix(.Rows - 1, Cons_Tipo) <> "" Then
                       
                      .SetFocus
                      .Col = Cons_Tipo
                      .Rows = .Rows + 1
                      .Row = .Rows - 1
                      .TextMatrix(.Row, Cons_TasaRef) = Format(0, FDecimal)
                   Else
                       MsgBox "Debe Completar Valores para Insertar Registro.", vbInformation, App.Title
                       .SetFocus
                       Exit Sub
                   End If
                 End If
                 
                 For nContador1 = 1 To .Rows - 1
                    If CDbl(.TextMatrix(nContador1, Cons_TasaRef)) > Format(100, FEntero) _
                    Or CDbl(.TextMatrix(nContador1, Cons_TasaRef)) < Format(-100, FEntero) Then
                        Call MsgBox(" Valores de Tasa Ref no puede ser mayor que 100 ni menor que -100, Revizar fila N° " & nContador1, vbInformation, App.Title)
                        .Row = nContador1
                        .Col = Cons_TasaRef
                        .SetFocus
                        TxtTasaRef.Visible = True
                        TxtTasaRef.SetFocus
                        Exit Sub
                    End If
                 Next nContador1
            
            Case vbKeyDelete 'Elimina
                
                If TxtTasaRef.Visible = True Then
                    Exit Sub
                End If
    
                If Cmb_Familia.Visible = True Then
                    Exit Sub
                End If
   
            
                If MsgBox("Esta seguro de eliminar la Serie", vbQuestion + vbYesNo, TITSISTEMA) = vbNo Then
                    .SetFocus
                    Exit Sub
                End If
                    .SetFocus
                If Cmb_Familia.Visible <> True Then
                    If .Rows > 2 Then
                        .RemoveItem .Row
                    Else
                        .TextMatrix(.Rows - 1, Cons_CodInst) = ""
                        .TextMatrix(.Rows - 1, Cons_Tipo) = ""
                        .TextMatrix(.Rows - 1, Cons_ClasfRiesgo) = ""
                        .TextMatrix(.Rows - 1, Cons_TasaRef) = ""
                        .TextMatrix(Grd_datos.Row, Cons_TasaRef) = Format(0, FDecimal)
                    End If
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
        Case "Eliminar"
            Call Proc_Eliminar
        
        Case "Limpiar"
      
           Call Proc_Limpiar
                
        Case "Grabar"
            Call Proc_Grabar
        
        Case "Buscar"
          Call Proc_Buscar
        
        Case "Salir"
           Unload Me
           Exit Sub
    End Select
End Sub


Private Sub TxtTasaRef_KeyDown(KeyCode As Integer, Shift As Integer)
Select Case KeyCode
    Case vbKeyReturn
        With Grd_datos
           
                .TextMatrix(.Row, Cons_TasaRef) = Trim(TxtTasaRef.Text)
                 TxtTasaRef.Visible = False
                 .SetFocus
                .Col = Cons_Tipo
                .Row = .Rows - 1
                
                 For nContador1 = 1 To .Rows - 1
                    If CDbl(.TextMatrix(nContador1, Cons_TasaRef)) > Format(100, FEntero) _
                    Or CDbl(.TextMatrix(nContador1, Cons_TasaRef)) < Format(-100, FEntero) Then
                        Call MsgBox(" Valores de Tasa Ref no puede ser mayor que 100 ni menor que -100, Revizar fila N° " & nContador1, vbInformation, App.Title)
                        .Row = nContador1
                        .Col = Cons_TasaRef
                        .SetFocus
                        TxtTasaRef.Visible = True
                        TxtTasaRef.SetFocus
                        Exit Sub
                    End If
                 Next nContador1
           
        End With
    Case vbKeyEscape
        TxtTasaRef.Visible = False
        Grd_datos.SetFocus
End Select
End Sub


Private Sub TxtTasaRef_LostFocus()
    TxtTasaRef.Visible = False
End Sub


