VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "Msflxgrd.ocx"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "comdlg32.ocx"
Begin VB.Form FRM_MNT_TASA_REFERENCIAL 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Tasa Referencial (SOMA)"
   ClientHeight    =   5865
   ClientLeft      =   4320
   ClientTop       =   330
   ClientWidth     =   6345
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   5902.838
   ScaleMode       =   0  'User
   ScaleWidth      =   6380.447
   Begin VB.Frame Frame1 
      Height          =   3885
      Left            =   105
      TabIndex        =   7
      Top             =   1875
      Width           =   6150
      Begin VB.ComboBox CmbSerie 
         Height          =   315
         Left            =   210
         TabIndex        =   9
         Text            =   "CmbSerie"
         Top             =   2835
         Width           =   1560
      End
      Begin BACControles.TXTNumero TxtDiasHasta 
         Height          =   300
         Left            =   1935
         TabIndex        =   8
         Top             =   2835
         Width           =   1275
         _ExtentX        =   2249
         _ExtentY        =   529
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
         Min             =   "1"
         Max             =   "9999999999"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin BACControles.TXTNumero TxtTasaRef 
         Height          =   315
         Left            =   3585
         TabIndex        =   10
         Top             =   2820
         Width           =   1290
         _ExtentX        =   2275
         _ExtentY        =   556
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
         Max             =   "999999999999,9999"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin MSFlexGridLib.MSFlexGrid Grd_Datos 
         Height          =   3525
         Left            =   105
         TabIndex        =   11
         Top             =   180
         Width           =   5910
         _ExtentX        =   10425
         _ExtentY        =   6218
         _Version        =   393216
         Cols            =   9
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
      Height          =   1125
      Left            =   120
      TabIndex        =   3
      Top             =   630
      Width           =   6120
      Begin VB.TextBox Text1 
         Height          =   300
         Left            =   3900
         TabIndex        =   6
         Top             =   660
         Visible         =   0   'False
         Width           =   1335
      End
      Begin BACControles.TXTFecha TXTFecha 
         Height          =   330
         Left            =   855
         TabIndex        =   1
         Top             =   645
         Width           =   1215
         _ExtentX        =   2143
         _ExtentY        =   582
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "20/10/2010"
      End
      Begin VB.ComboBox Cmb_Familia 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         ItemData        =   "FRM_MNT_TASA_REFERENCIAL.frx":0000
         Left            =   870
         List            =   "FRM_MNT_TASA_REFERENCIAL.frx":0002
         Style           =   2  'Dropdown List
         TabIndex        =   0
         TabStop         =   0   'False
         Top             =   180
         Width           =   3420
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Familia"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   1
         Left            =   120
         TabIndex        =   5
         Top             =   270
         Width           =   480
      End
      Begin VB.Label LblFecha 
         Caption         =   "Fecha"
         Height          =   225
         Left            =   120
         TabIndex        =   4
         Top             =   750
         Width           =   630
      End
   End
   Begin MSComctlLib.Toolbar Tbl_Opciones 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   2
      Top             =   0
      Width           =   6345
      _ExtentX        =   11192
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
      Begin MSComDlg.CommonDialog MiCommand 
         Left            =   2550
         Top             =   15
         _ExtentX        =   847
         _ExtentY        =   847
         _Version        =   393216
      End
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
               Picture         =   "FRM_MNT_TASA_REFERENCIAL.frx":0004
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_TASA_REFERENCIAL.frx":0EDE
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_TASA_REFERENCIAL.frx":1DB8
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_TASA_REFERENCIAL.frx":2C92
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_TASA_REFERENCIAL.frx":3B6C
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_TASA_REFERENCIAL.frx":4A46
               Key             =   ""
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_TASA_REFERENCIAL.frx":4D60
               Key             =   ""
            EndProperty
            BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_TASA_REFERENCIAL.frx":5C3A
               Key             =   ""
            EndProperty
            BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_TASA_REFERENCIAL.frx":6B14
               Key             =   ""
            EndProperty
            BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_TASA_REFERENCIAL.frx":6F66
               Key             =   ""
            EndProperty
            BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_TASA_REFERENCIAL.frx":7280
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
End
Attribute VB_Name = "FRM_MNT_TASA_REFERENCIAL"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Const Cons_CodInst = 0
Const Cons_Tipo = 1
Const Cons_Serie = 2
Const Cons_Desde = 3
Const Cons_Hasta = 4
Const Cons_TasaRef = 5
Const Cons_ClasfRiesgo = 6
Const Cons_CodEmisor = 7
Const Cons_GenEmisor = 8

Const Cons_PlazoTramo = "PT"
Const Cons_PlazoRemanente = "PR"

Dim salir As Boolean





Private Sub Proc_CargaDatosOcultos()
    With Grd_Datos
        
        .TextMatrix(.Row, Cons_CodInst) = Trim(Right(Cmb_Familia.Text, 10))
        .TextMatrix(.Row, Cons_Tipo) = Trim(Left(Cmb_Familia.Text, 10))
        If Trim(Left(Cmb_Familia.Text, 10)) = "LH-AA" Then
            .TextMatrix(.Row, Cons_ClasfRiesgo) = "AA"
        ElseIf Trim(Left(Cmb_Familia.Text, 10)) = "LH-A" Then
            .TextMatrix(.Row, Cons_ClasfRiesgo) = "A"
        Else
            .TextMatrix(.Row, Cons_ClasfRiesgo) = ""
        End If
      
    End With
End Sub



Private Function ValDiasDesde() As Boolean
   Dim var_hasta As Double
   Dim nContador As Integer
   Dim nContador2 As Integer
   ValDiasDesde = True
With Grd_Datos
   
     If .Rows = 2 Then
        If .Row = 1 Then
           .TextMatrix(1, Cons_Desde) = "1"
        End If
     Else
        
        var_hasta = CDbl(TxtDiasHasta.Text)
        
        If .Rows - 1 = .Row Then
           If var_hasta > .TextMatrix(.Row - 1, Cons_Hasta) Then
              Call CargaDiasDesde(1)
           Else
              ValDiasDesde = False
              Call MsgBox("Debe Ingresar un Rango Mayor al anterior.", vbInformation, App.Title)
              TxtDiasHasta.SetFocus
           End If
        Else
           If .Row = 1 Then
              If var_hasta < .TextMatrix(.Row + 1, Cons_Hasta) Then
                 Call CargaDiasDesde(1)
              Else
                 ValDiasDesde = False
                 Call MsgBox("Debe Ingresar un Rango Menor al siguiente.", vbInformation, App.Title)
                 TxtDiasHasta.SetFocus
              End If
           Else
              If CDbl(var_hasta) > CDbl(.TextMatrix(.Row - 1, Cons_Hasta)) And CDbl(var_hasta) < CDbl(.TextMatrix(.Row + 1, Cons_Hasta)) Then
                 Call CargaDiasDesde(1)
              Else
                 ValDiasDesde = False
                 Call MsgBox("Debe Ingresar un Rango menor al siguiente y uno mayor al anterior.", vbInformation, App.Title)
                 TxtDiasHasta.SetFocus
                 Exit Function
              End If
           End If
        End If
    
    
     End If
   
End With
End Function


Private Sub CargaDiasDesde(ind_mod As Integer)
   Dim var_ind          As Long
   Dim var_row, var_col As Long

Exit Sub
With Grd_Datos
   var_row = .Row
   var_col = .Col

   If ind_mod = 1 Then
      .TextMatrix(.Row, Cons_Hasta) = TxtDiasHasta.Text
   End If

   For var_ind = 1 To .Rows - 1
      If var_ind = 1 Then
         .TextMatrix(var_ind, Cons_Desde) = "1"
         .TextMatrix(1, Cons_Desde) = "1"
      Else
         If Trim(.TextMatrix(.Row, Cons_Hasta)) <> "" Then
           'Grid.TextMatrix(var_ind, COLDIAD) = Format(Str(Val(Replace(Grid.TextMatrix(var_ind - 1, COLDIAH), ".", "")) + 1), FEntero)
            .TextMatrix(var_ind, Cons_Desde) = Format(.TextMatrix(var_ind - 1, Cons_Hasta), FEntero)
         End If
      End If
   Next var_ind
   .Row = var_row
   .Col = var_col
 End With
End Sub
Private Function FUNC_INIT_ROW() As Boolean
   Dim oValorAnterior   As Double
   Dim nContador As Integer
   Let FUNC_INIT_ROW = False
   
    With Grd_Datos
      
       .Rows = .Rows + 1
       .Row = .Rows - 1
       If Trim(Mid(Cmb_Familia.Text, 81, 10)) = Cons_PlazoTramo Then
        oValorAnterior = CDbl(.TextMatrix(.Rows - 2, Cons_Hasta)) + 1
       End If
       
       .TextMatrix(.Rows - 1, Cons_Desde) = Format(oValorAnterior, FEntero)
       .TextMatrix(.Rows - 1, Cons_Hasta) = Format(0, FEntero)
       .TextMatrix(.Rows - 1, Cons_TasaRef) = Format(0, FDecimal)
    
       Let FUNC_INIT_ROW = True
    End With
End Function
Private Sub Proc_CargaCmbSerie()
    Dim Datos()
    Envia = Array()
    AddParam Envia, CDate(TXTFecha.Text)
    AddParam Envia, Trim(Right(Cmb_Familia.Text, 10))
    If Not Bac_Sql_Execute("SP_CONTIPOINSTRUMENTO", Envia) Then
       Exit Sub
    End If
    Call CmbSerie.Clear
    
    Do While Bac_SQL_Fetch(Datos())
      
       Call CmbSerie.AddItem(Trim(Datos(2)) & Space(80) & Datos(1) & Space(80) & "")
      
    Loop
End Sub

Private Sub Proc_ValidaSerieGrilla()
   Dim nFilaAnt As Integer
   Dim Contador1 As Integer
    
   With Grd_Datos
    
        nFilaAnt = .Row
                        
        For Contador1 = 1 To .Rows - 1
             If nFilaAnt <> Contador1 Then
                If .TextMatrix(Contador1, Cons_Serie) = .TextMatrix(nFilaAnt, Cons_Serie) Then
                   
                     CmbSerie.Visible = False
                     .Col = Cons_Serie
                     .Row = Contador1
                     .CellBackColor = vbRed
                     
                      Call MsgBox("Numero de serie ya existe en la Grilla." & vbCrLf & vbCrLf & Err.Description, vbExclamation, App.Title)
                     .SetFocus
                     .TextMatrix(.Rows - 1, Cons_CodInst) = ""
                     .TextMatrix(.Rows - 1, Cons_Tipo) = ""
                     .TextMatrix(.Rows - 1, Cons_Desde) = ""
                     .TextMatrix(.Rows - 1, Cons_Hasta) = ""
                     .TextMatrix(.Rows - 1, Cons_ClasfRiesgo) = ""
                     .TextMatrix(.Rows - 1, Cons_CodEmisor) = ""
                     .TextMatrix(.Rows - 1, Cons_GenEmisor) = ""
                     .TextMatrix(.Rows - 1, Cons_Desde) = Format(0, FEntero)
                     .TextMatrix(.Rows - 1, Cons_Hasta) = Format(0, FEntero)
                     .TextMatrix(.Rows - 1, Cons_TasaRef) = Format(0, FDecimal)
                     Exit Sub
                 End If
              End If
         Next Contador1
     End With
End Sub



Private Sub Proc_Grabar()
Dim nContador1 As Integer
Dim nContador2 As Integer
Dim TipoOpe
TipoOpe = "FLI"
Dim ClasfRiesgo As String
Dim TotGrid As Integer
      
   If Trim(Left(Cmb_Familia.Text, 10)) = "LH-AA" Then
          ClasfRiesgo = "AA"
   ElseIf Trim(Left(Cmb_Familia.Text, 10)) = "LH-A" Then
          ClasfRiesgo = "A"
   Else
          ClasfRiesgo = ""
   End If
   
   If TxtTasaRef.Visible = True Then
        Exit Sub
   End If
   
   If CmbSerie.Visible = True Then
        Exit Sub
   End If
   
       
    With Grd_Datos
    
   If MsgBox("¿ Esta seguro que desea actualizar los valores. ? ", vbQuestion + vbYesNo, App.Title) = vbNo Then
      Exit Sub
   End If
   
   If Trim(.TextMatrix(1, Cons_CodInst)) = "" And Trim(.TextMatrix(1, Cons_Tipo)) = "" _
      And Trim(.TextMatrix(1, Cons_Desde)) = 0 And Trim(.TextMatrix(1, Cons_Hasta)) = 0 Then
       
      
       If MsgBox("¿Eliminara toda la información.?", vbQuestion + vbYesNo, App.Title) = vbNo Then
            Exit Sub
            End If
    
    Else
               
         For nContador2 = 1 To .Rows - 1
            If Trim(Mid(Me.Cmb_Familia, 81, 10)) = Cons_PlazoTramo Then
                If .Rows = .Rows And Trim(.TextMatrix(nContador2, Cons_CodInst)) = "" _
                Or .Rows = .Rows And Trim(.TextMatrix(nContador2, Cons_Tipo)) = "" _
                Or .Rows = .Rows And Trim(.TextMatrix(nContador2, Cons_Desde)) = 0 _
                Or .Rows = .Rows And Trim(.TextMatrix(nContador2, Cons_Hasta)) = 0 Then
                 
                    
                    MsgBox "No se ha asignado ninguna Serie para grabar", vbExclamation
                    .Row = nContador2
                    .SetFocus
                    .Col = Cons_Hasta: .CellBackColor = vbRed
                    .Col = Cons_TasaRef: .CellBackColor = vbRed
                    
                    
                    Exit Sub
                End If
             End If
             
             If Trim(Mid(Me.Cmb_Familia, 81, 10)) = Cons_PlazoRemanente Then
                If .Rows = .Rows And Trim(.TextMatrix(nContador2, Cons_CodInst)) = "" _
                Or .Rows = .Rows And Trim(.TextMatrix(nContador2, Cons_Tipo)) = "" _
                Or .Rows = .Rows And Trim(.TextMatrix(nContador2, Cons_Serie)) = "" _
                Or .Rows = .Rows And Trim(.TextMatrix(nContador2, Cons_Desde)) = 0 _
                Or .Rows = .Rows And Trim(.TextMatrix(nContador2, Cons_Hasta)) = 0 Then
                
                    
                    MsgBox "No se ha asignado ninguna Serie para grabar", vbExclamation
                    
                    Exit Sub
                End If
             End If
          
         Next nContador2
         
          If Trim(Mid(Me.Cmb_Familia, 81, 10)) = Cons_PlazoTramo Then
            TotGrid = .Rows - 1
            For nContador1 = 1 To .Rows - 1
                If TotGrid = nContador1 And nContador1 >= 1 Then
                  
                Else
                    If CDbl(.TextMatrix(nContador1 + 1, Cons_Desde)) > CDbl(.TextMatrix(nContador1, Cons_Hasta)) + 1 Then
                        Call MsgBox("Revizar Plazos " & "Dias Hasta Valor:" & CDbl(.TextMatrix(nContador1, Cons_Hasta)), vbInformation, App.Title)
                        .Col = Cons_Hasta
                        .Row = nContador1
                        .SetFocus
                        .CellBackColor = vbRed
                        Exit Sub
                    End If
                End If
            Next nContador1
         End If
         
         For nContador1 = 1 To .Rows - 1
             If CDbl(.TextMatrix(nContador1, Cons_Hasta)) = Format(0, FEntero) Then
               Call MsgBox("No puede grabar Valor en 0,000. Revizar fila N° " & nContador1, vbInformation, App.Title)
               .Row = nContador1
               .Col = Cons_Hasta: .CellBackColor = vbRed
               .SetFocus
               Exit Sub
             End If
         Next nContador1
        
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
                'TxtTasaRef.Visible = True
                'TxtTasaRef.SetFocus
                Exit Sub
            End If
         Next nContador1
               
    End If
    
    Envia = Array()
    AddParam Envia, Trim(Right(Cmb_Familia.Text, 10))                '->> Fecha de Margenes
    AddParam Envia, ClasfRiesgo
    
    If Not Bac_Sql_Execute("SP_DELTODOTASAREFERENCIASOMA", Envia) Then
       Let Screen.MousePointer = vbDefault
       Call MsgBox("Error en proceso." & vbCrLf & "No se ha podido iniciar la actualización de la Información.", vbExclamation, App.Title)
       Exit Sub
    End If
        
    If Trim(.TextMatrix(1, Cons_CodInst)) <> "" And Trim(.TextMatrix(1, Cons_Tipo)) <> "" _
      And Trim(.TextMatrix(1, Cons_Desde)) <> 0 And Trim(.TextMatrix(1, Cons_Hasta)) <> 0 Then
      
        
        For nContador1 = 1 To .Rows - 1
            Envia = Array()
            AddParam Envia, CDbl(Trim(.TextMatrix(nContador1, Cons_CodInst)))
            AddParam Envia, ClasfRiesgo
            AddParam Envia, IIf(Trim(.TextMatrix(nContador1, Cons_Serie)) = "", "", Trim(.TextMatrix(nContador1, Cons_Serie)))
            
            If Trim(Mid(Me.Cmb_Familia, 81, 10)) = Cons_PlazoRemanente Then
                 AddParam Envia, "0"
                 AddParam Envia, "0"
            End If
            
            If Trim(Mid(Me.Cmb_Familia, 81, 10)) = Cons_PlazoTramo Then
                 AddParam Envia, CDbl(Trim(.TextMatrix(nContador1, Cons_Desde)))
                 AddParam Envia, CDbl(Trim(.TextMatrix(nContador1, Cons_Hasta)))
            End If
            
            AddParam Envia, TipoOpe
            AddParam Envia, bacTranMontoSql(CDbl(Trim(.TextMatrix(nContador1, Cons_TasaRef))))
                                                                    
            If Not Bac_Sql_Execute("SP_ACTTASAREFERENCIASOMA", Envia) Then
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
             .Rows = 1
            .AddItem ""
            Grd_Datos.TextMatrix(Grd_Datos.Row, Cons_Desde) = Format(0, FEntero)
            Grd_Datos.TextMatrix(Grd_Datos.Row, Cons_Hasta) = Format(0, FEntero)
            Grd_Datos.TextMatrix(Grd_Datos.Rows - 1, Cons_TasaRef) = Format(0, FDecimal)
            
            
            If Trim(.TextMatrix(1, Cons_CodInst)) <> "" And Trim(.TextMatrix(1, Cons_Tipo)) <> "" _
                And Trim(.TextMatrix(1, Cons_Desde)) <> 0 And Trim(.TextMatrix(1, Cons_Hasta)) <> 0 Then
                   
                Tbl_Opciones.Buttons("Grabar").Enabled = True
                Tbl_Opciones.Buttons("Eliminar").Enabled = True
                      
            Else
        
                Tbl_Opciones.Buttons("Grabar").Enabled = False
                Tbl_Opciones.Buttons("Eliminar").Enabled = False
            End If
   
End With
    
End Sub

Private Sub Proc_Eliminar()

    With Grd_Datos
        If TxtTasaRef.Visible = True Then
            Exit Sub
        End If
    
        If CmbSerie.Visible = True Then
            Exit Sub
        End If
    
        If .Row = 0 Then
             MsgBox "No ha seleccionado ningun registro para eliminar", vbInformation
             Exit Sub
        End If
        
        If Trim(.TextMatrix(.Row, Cons_Tipo)) = "" Then
            Screen.MousePointer = vbDefault
            MsgBox "No ha seleccionado ningun registro para eliminar", vbExclamation
            Exit Sub
        End If
        
        
        If MsgBox("Esta seguro de eliminar la Serie", vbQuestion + vbYesNo, TITSISTEMA) = vbNo Then
            Exit Sub
        End If
        
                If .Rows > 2 Then
                    .RemoveItem .Row
                      
                    If Trim(Mid(Cmb_Familia.Text, 81, 10)) = Cons_PlazoTramo Then
                       
                       If .TextMatrix(1, Cons_Desde) <> 1 Then
                          .TextMatrix(1, Cons_Desde) = Format(1, FEntero)
                       End If
                       
                       Call CargaDiasDesde(0)
                    End If
                 Else
                   .TextMatrix(1, Cons_CodInst) = ""
                   .TextMatrix(1, Cons_Tipo) = ""
                   .TextMatrix(1, Cons_Serie) = ""
                   .TextMatrix(1, Cons_ClasfRiesgo) = ""
                   .TextMatrix(.Rows - 1, Cons_Desde) = Format(0, FEntero)
                   .TextMatrix(.Rows - 1, Cons_Hasta) = Format(0, FEntero)
                   .TextMatrix(.Rows - 1, Cons_TasaRef) = Format(0, FDecimal)
                                      
                End If
      
    End With


End Sub
Private Sub Proc_CargaSerie()
 Dim nContador As Integer
 Dim FechaVenc As Date
 Dim desde As Integer
 Dim Hasta As Integer
     With Grd_Datos
        
    For nContador = 1 To .Rows - 1
       Envia = Array()
       AddParam Envia, 1
       AddParam Envia, .TextMatrix(nContador, Cons_Serie)
    
       If Not Bac_Sql_Execute("SP_CONINSTRUMENTOSERIE", Envia) Then
           Call MsgBox("Error Lectura" & vbCrLf & vbCrLf _
           & "Se ha originado un error al leer la  información.", vbExclamation, App.Title)
          Exit Sub
       End If
       Do While Bac_SQL_Fetch(Datos())
       
       If .TextMatrix(nContador, Cons_Serie) = Trim(Datos(2)) Then
           .TextMatrix(nContador, Cons_CodInst) = Trim(Datos(3))
           .TextMatrix(nContador, Cons_Tipo) = Trim(Datos(4))
            FechaVenc = Trim(Datos(10))
            desde = ((FechaVenc - gsbac_fecp) - 1)
            Hasta = ((FechaVenc - gsbac_fecp) + 1)
           .TextMatrix(nContador, Cons_Desde) = Format(desde, FEntero)
           .TextMatrix(nContador, Cons_Hasta) = Format(Hasta, FEntero)
          ' .TextMatrix(nContador, Cons_RutEmisor) = Trim(Datos(5))
           '.TextMatrix(nContador, Cons_CodEmisor) = 1
          ' .TextMatrix(nContador, Cons_GenEmisor) = Trim(Datos(12))
           
           '.Rows = .Rows + 1
        End If
       Loop
     Next nContador
    End With
End Sub

Private Sub Proc_Buscar()
   Dim Datos()
   Dim nContador As Integer
   Dim desde As Integer
   Dim Hasta As Integer
   Dim FechaVenc As Date
   Dim serie As String
   Dim ClasfRiesgo As String
    
   If Trim(Left(Cmb_Familia.Text, 10)) = "LH-AA" Then
          ClasfRiesgo = "AA"
   ElseIf Trim(Left(Cmb_Familia.Text, 10)) = "LH-A" Then
          ClasfRiesgo = "A"
   Else
          ClasfRiesgo = ""
   End If
   
   If TxtTasaRef.Visible = True Then
        Exit Sub
   End If
   
   If CmbSerie.Visible = True Then
        Exit Sub
   End If
   

   Envia = Array()
   AddParam Envia, Trim(Right(Cmb_Familia.Text, 10))
   AddParam Envia, ClasfRiesgo
   If Not Bac_Sql_Execute("SP_CONTASAREFERENCIASOMA", Envia) Then
      Call MsgBox("Problemas al Leer Instrumento", vbCritical, App.Title)
      Let Buscar = False
      Exit Sub
   End If
    With Grd_Datos
        .Rows = 1
        Do While Bac_SQL_Fetch(Datos())
            If Trim(Datos(1)) = -1 Then
               If salir = False Then
                    Call MsgBox(Trim(Datos(2)), vbInformation, App.Title)
               End If
                
                .Rows = .Rows + 1
                .TextMatrix(.Rows - 1, Cons_Desde) = Format(0, FEntero)
                .TextMatrix(.Rows - 1, Cons_Hasta) = Format(0, FEntero)
                .TextMatrix(.Rows - 1, Cons_TasaRef) = Format(0, FDecimal)
                Exit Do
            Else
               If Trim(Mid(Me.Cmb_Familia, 81, 10)) = Cons_PlazoTramo Then
                    .Rows = .Rows + 1
                    .TextMatrix(.Rows - 1, Cons_CodInst) = Trim(Datos(1))
                    .TextMatrix(.Rows - 1, Cons_Desde) = Format(Trim(Datos(4)), FEntero)
                    .TextMatrix(.Rows - 1, Cons_Hasta) = Format(Trim(Datos(5)), FEntero)
                    .TextMatrix(.Rows - 1, Cons_TasaRef) = Format(Trim(Datos(7)), FDecimal)
                    .TextMatrix(.Rows - 1, Cons_CodInst) = Trim(Right(Cmb_Familia.Text, 10))
                    .TextMatrix(.Rows - 1, Cons_Tipo) = Trim(Left(Cmb_Familia.Text, 10))
                    If Trim(Left(Cmb_Familia.Text, 10)) = "LH-AA" Then
                        .TextMatrix(.Rows - 1, Cons_ClasfRiesgo) = "AA"
                    ElseIf Trim(Left(Cmb_Familia.Text, 10)) = "LH-A" Then
                        .TextMatrix(.Rows - 1, Cons_ClasfRiesgo) = "A"
                    Else
                        .TextMatrix(.Rows - 1, Cons_ClasfRiesgo) = ""
                    End If
               End If
               
               If Trim(Mid(Me.Cmb_Familia, 81, 10)) = Cons_PlazoRemanente Then
                    .Rows = .Rows + 1
                    .TextMatrix(.Rows - 1, Cons_CodInst) = Trim(Datos(1))
                    .TextMatrix(.Rows - 1, Cons_Serie) = Trim(Datos(3))
                    .TextMatrix(.Rows - 1, Cons_TasaRef) = Format(Trim(Datos(7)), FDecimal)
                    .TextMatrix(.Rows - 1, Cons_CodInst) = Trim(Right(Cmb_Familia.Text, 10))
                    .TextMatrix(.Rows - 1, Cons_Tipo) = Trim(Left(Cmb_Familia.Text, 10))
                    
                    If Trim(Left(Cmb_Familia.Text, 10)) = "LH-AA" Then
                        .TextMatrix(.Rows - 1, Cons_ClasfRiesgo) = "AA"
                    ElseIf Trim(Left(Cmb_Familia.Text, 10)) = "LH-A" Then
                        .TextMatrix(.Rows - 1, Cons_ClasfRiesgo) = "A"
                    Else
                        .TextMatrix(.Rows - 1, Cons_ClasfRiesgo) = ""
                    End If
               End If
               
            End If
        Loop
        If Trim(Mid(Me.Cmb_Familia, 81, 10)) = Cons_PlazoRemanente Then
           Call Proc_CargaSerie
        End If
        For nContador = 1 To .Rows - 1
            .TextMatrix(nContador, Cons_Desde) = Format(.TextMatrix(nContador, Cons_Desde), "0")
        Next nContador
        
        .Row = 0
        .Col = Cons_Desde
        .Sort = flexSortNumericAscending
        
        For nContador = 1 To .Rows - 1
            .TextMatrix(nContador, Cons_Desde) = Format(.TextMatrix(nContador, Cons_Desde), "#,##0")
        Next nContador
        

        If Trim(.TextMatrix(1, Cons_CodInst)) <> "" And Trim(.TextMatrix(1, Cons_Tipo)) <> "" _
          And Trim(.TextMatrix(1, Cons_Desde)) <> 0 And Trim(.TextMatrix(1, Cons_Hasta)) <> 0 Then
          
          
           Tbl_Opciones.Buttons("Grabar").Enabled = True
           Tbl_Opciones.Buttons("Eliminar").Enabled = True
                      
        Else
        
           Tbl_Opciones.Buttons("Grabar").Enabled = False
           Tbl_Opciones.Buttons("Eliminar").Enabled = False
        End If
        Cmb_Familia.Enabled = False
        Grd_Datos.Enabled = True
  End With
  
End Sub



Private Sub Proc_Limpiar()
    Dim TotGrid As Integer
    Dim nContador As Long
      
    With Grd_Datos
        If .Rows - 1 Then
            If MsgBox("¿ Esta seguro que desea limpiar, ¿Grabo la Información? ", vbQuestion + vbYesNo, App.Title) = vbNo Then
               Exit Sub
            End If
            TotGrid = .Rows - 1
            For nContador = 1 To .Rows - 1
                If TotGrid = nContador And nContador >= 1 Then
               
                Else
                   If Trim(Mid(Me.Cmb_Familia, 81, 10)) = Cons_PlazoTramo Then
                        If CDbl(.TextMatrix(nContador + 1, Cons_Desde)) > CDbl(.TextMatrix(nContador, Cons_Hasta)) + 1 Then
                            Call MsgBox("Revizar Plazos " & "Dias Hasta Valor:" & CDbl(.TextMatrix(nContador, Cons_Hasta)), vbInformation, App.Title)
                            .Col = Cons_Hasta
                            .Row = nContador
                            .SetFocus
                            .CellBackColor = vbRed
                            Exit Sub
                            
                        End If
                    End If
                End If
            Next nContador
        End If
    End With
    
    
    
    Cmb_Familia.Enabled = True
    Call Proc_NombresGrilla
    Grd_Datos.Enabled = False
    
End Sub







Private Sub Proc_CargaCmbFamilia()
   Dim Datos()

   If Not Bac_Sql_Execute("SP_LEERFAMILIASTASAREF") Then
      Exit Sub
   End If
   Call Cmb_Familia.Clear
   Do While Bac_SQL_Fetch(Datos())
     
      Call Cmb_Familia.AddItem(Trim(Datos(2)) & String(80 - Len(Trim(Datos(2))), " ") & Datos(5) & Space(80) & Datos(1))
              
   Loop
End Sub


Private Sub Proc_NombresGrilla()
    
  With Grd_Datos
    
    Tbl_Opciones.Buttons("Grabar").Enabled = False
    Tbl_Opciones.Buttons("Eliminar").Enabled = False
    
    
    .Rows = 2:         .FixedRows = 1
    .Cols = 9:         .FixedCols = 0

    .Font.Name = "Tahoma"
    .Font.Size = 8
    .RowHeightMin = 315
    .TextMatrix(0, Cons_CodInst) = "CodInst"
    .TextMatrix(0, Cons_Tipo) = "Instrumento"
    .TextMatrix(0, Cons_Serie) = "Serie"
    .TextMatrix(0, Cons_Desde) = "Desde"
    .TextMatrix(0, Cons_Hasta) = "Hasta"
    .TextMatrix(0, Cons_TasaRef) = "Tasa Ref."
    .TextMatrix(0, Cons_ClasfRiesgo) = "Riesgo"
    .TextMatrix(0, Cons_CodEmisor) = "Cod Emisor"
    .TextMatrix(0, Cons_GenEmisor) = "Gen.Emisor"
    
    .ColWidth(Cons_CodInst) = 0
    .ColWidth(Cons_Tipo) = 1000
    .ColWidth(Cons_Serie) = 1400
    .ColWidth(Cons_Desde) = 1000
    .ColWidth(Cons_Hasta) = 1000
    .ColWidth(Cons_TasaRef) = 1000
    .ColWidth(Cons_ClasfRiesgo) = 0
    .ColWidth(Cons_CodEmisor) = 0
    .ColWidth(Cons_GenEmisor) = 0
     
    .Rows = 1
    .AddItem ""
    Grd_Datos.TextMatrix(Grd_Datos.Row, Cons_Desde) = Format(0, FEntero)
    Grd_Datos.TextMatrix(Grd_Datos.Row, Cons_Hasta) = Format(0, FEntero)
    Grd_Datos.TextMatrix(Grd_Datos.Rows - 1, Cons_TasaRef) = Format(0, FDecimal)
    TxtDiasHasta.Visible = False
    CmbSerie.Visible = False
    TxtTasaRef.Visible = False
    Grd_Datos.Enabled = False
    
   
  End With
End Sub







Private Sub Proc_ValidaExisteSerie()
    
    With Grd_Datos
           Dim CodSerie  As String
           Dim Generico  As String
           Dim nContador1 As Integer
           
           For nContador1 = 1 To .Rows - 1
                Envia = Array()
                AddParam Envia, Trim(Left(CmbSerie.Text, 10))
               
                
                If Not Bac_Sql_Execute("SP_CONSERIEGENERICO", Envia) Then
                    Screen.MousePointer = vbDefault
                    MsgBox "Ha ocurrido un error al intentar leer la parametrización", vbCritical + vbOKOnly, TITSISTEMA
                    Exit Sub
                End If
           
                Do While Bac_SQL_Fetch(Datos())
                    CodSerie = (Datos(2))
                   'Generico = (Datos(7))
                Loop
           Next nContador1
           
           For nContador1 = 1 To .Rows - 1
             If Trim(.TextMatrix(nContador1, Cons_Serie)) = CodSerie Then
               
                    CmbSerie.Visible = False
                   
                   .Col = Cons_Serie
                   .Row = nContador1
                   .CellBackColor = vbRed
                   .SetFocus
                    Call MsgBox("Numero de serie ya existe en Base de datos" & vbCrLf & vbCrLf & Err.Description, vbExclamation, App.Title)
                   .TextMatrix(.Rows - 1, Cons_CodInst) = ""
                   .TextMatrix(.Rows - 1, Cons_Tipo) = ""
                   .TextMatrix(.Rows - 1, Cons_Desde) = Format(0, FEntero)
                   .TextMatrix(.Rows - 1, Cons_Hasta) = Format(0, FEntero)
                   .TextMatrix(.Rows - 1, Cons_TasaRef) = Format(0, FDecimal)
                   .SetFocus
                   Exit Sub
               End If
            Next nContador1
     End With
End Sub

Private Sub Cmb_Familia_Click()
   
    With Grd_Datos
        .Clear
        .Rows = 2
         Call Proc_NombresGrilla
        .Enabled = True
         Text1.Text = Trim(Mid(Me.Cmb_Familia, 81, 10))
         If Trim(Mid(Me.Cmb_Familia, 81, 10)) = Cons_PlazoTramo Then
             CmbSerie.Clear
             CmbSerie.Visible = False
             
         Else
             Call Proc_CargaCmbSerie
         End If
         Call Proc_CargaDatosOcultos
        If Me.Cmb_Familia.ListIndex = -1 Then
         Exit Sub
        Else
         Call Proc_Buscar
         
        End If
       
    End With
End Sub


Private Sub Cmb_Familia_KeyDown(KeyCode As Integer, Shift As Integer)
    
     salir = False
    Select Case KeyCode
    
        Case vbKeyDown
            salir = True
        Case vbKeyUp
            salir = True
        
    End Select
End Sub

Private Sub CmbSerie_Click()
     
    Dim Datos()
    Dim nContador  As Integer
    Dim Contador1 As Integer
    Dim FechaVenc As Date
    Dim desde As Integer
    Dim Hasta As Integer
    Dim nFilaAnt As Integer
    Dim Sal As BacTypeChkSeriePB
    Dim Sal2 As BacTypeChkSerie
    '-- para asegurar que funcione en Garantias
    
      If salir = True Then
            Exit Sub
      End If
        If CmbSerie.Text = "" And CmbSerie.Visible = True Or CmbSerie.Visible = False Then
           Exit Sub
        End If
        
        cInstser = Trim(Left(CmbSerie.Text, 10))
        If CPCI_ChkSeriePB(cInstser, Sal) = True Then
            If Sal.nerror = 0 Then

               Envia = Array()
               AddParam Envia, 1
               AddParam Envia, cInstser

               If Not Bac_Sql_Execute("SP_CONINSTRUMENTOSERIE", Envia) Then
                   Call MsgBox("Error Lectura" & vbCrLf & vbCrLf _
                   & "Se ha originado un error al leer la  información.", vbExclamation, App.Title)
                   Exit Sub
               End If

               With Grd_Datos
                   Do While Bac_SQL_Fetch(Datos())

                            .TextMatrix(.Row, Cons_CodInst) = ""
                            .TextMatrix(.Row, Cons_Tipo) = ""
                            .TextMatrix(.Row, Cons_CodInst) = Trim(Datos(3))
                            .TextMatrix(.Row, Cons_Tipo) = Trim(Datos(4))
                             FechaVenc = Trim(Datos(10))
                             desde = ((FechaVenc - gsbac_fecp) - 1)
                             Hasta = ((FechaVenc - gsbac_fecp) + 1)
                            .TextMatrix(.Row, Cons_Desde) = Format(desde, FEntero)
                            .TextMatrix(.Row, Cons_Hasta) = Format(Hasta, FEntero)
                            '.TextMatrix(.Row, Cons_ClasfRiesgo) = Trim(Datos(5))
                            '.TextMatrix(.Row, Cons_GenEmisor) = Trim(Datos(12))
                            .TextMatrix(.Row, Cons_Serie) = Trim(Left(CmbSerie.Text, 10))
                             CmbSerie.Visible = False
                            .SetFocus
                            .Col = Cons_TasaRef
                            .Row = .Rows - 1
                             Call Proc_ValidaSerieGrilla
                             Call Proc_ValidaExisteSerie
                     'Exit Sub
                    Loop
                End With
            End If
        End If
        Tbl_Opciones.Buttons("Grabar").Enabled = True
        Tbl_Opciones.Buttons("Eliminar").Enabled = True
End Sub

Private Sub Habilitacion(ByVal iVal_ As Boolean, iObjeto As Object)
   Let Tbl_Opciones.Enabled = Not iVal_
   Let CuadroFecha.Enabled = Not iVal_
   Let Grd_Datos.Enabled = Not iVal_
   Let iObjeto.Visible = iVal_

   If iVal_ = True Then
      Call iObjeto.SetFocus
   Else
      Call Grd_Datos.SetFocus
   End If
End Sub

Private Sub AJObjeto(Marco As MSFlexGrid, Objeto As Control)
   On Error Resume Next

   Let Objeto.Top = Marco.CellTop + Marco.Top
   Let Objeto.Left = Marco.CellLeft + Marco.Left
   Let Objeto.Height = Marco.CellHeight + 20
   Let Objeto.Width = Marco.CellWidth

   On Error GoTo 0
End Sub
Private Sub CmbSerie_GotFocus()
     With Grd_Datos

        If Trim(.TextMatrix(.Row, Cons_Serie)) <> "" Then
            For nContador = 1 To CmbSerie.ListCount - 1
                If Trim(Right(CmbSerie.List(nContador), 10)) = Trim(.TextMatrix(.Row, Cons_Serie)) Then
                    CmbSerie.ListIndex = nContador
                    Exit For
                End If
            Next nContador
        End If

    End With

End Sub

Private Sub CmbSerie_KeyDown(KeyCode As Integer, Shift As Integer)
    Dim Datos()
    Dim nContador  As Integer
    Dim Contador1 As Integer
    Dim FechaVenc As Date
    Dim desde As Integer
    Dim Hasta As Integer
    Dim nFilaAnt As Integer
    Dim Sal As BacTypeChkSeriePB
    Dim Sal2 As BacTypeChkSerie
       salir = False
    Select Case KeyCode
       
       Case vbKeyDown
            salir = True
       Case vbKeyUp
            salir = True
       Case vbKeyReturn
 
 
                If CmbSerie.Text = "" And CmbSerie.Visible = True Then
                   Exit Sub
                End If
         
                cInstser = Trim(Left(CmbSerie.Text, 10))
          
                If CPCI_ChkSeriePB(cInstser, Sal) = True Then
                   If Sal.nerror = 0 Then
        
                       Envia = Array()
                       AddParam Envia, 1
                       AddParam Envia, cInstser
        
                       If Not Bac_Sql_Execute("SP_CONINSTRUMENTOSERIE", Envia) Then
                           Call MsgBox("Error Lectura" & vbCrLf & vbCrLf _
                           & "Se ha originado un error al leer la  información.", vbExclamation, App.Title)
                           Exit Sub
                       End If
        
                       With Grd_Datos
                           Do While Bac_SQL_Fetch(Datos())
        
        
                                    .TextMatrix(.Row, Cons_CodInst) = ""
                                    .TextMatrix(.Row, Cons_Tipo) = ""
                                    .TextMatrix(.Row, Cons_CodInst) = Trim(Datos(3))
                                    .TextMatrix(.Row, Cons_Tipo) = Trim(Datos(4))
                                     FechaVenc = Trim(Datos(10))
                                     desde = ((FechaVenc - gsbac_fecp) - 1)
                                     Hasta = ((FechaVenc - gsbac_fecp) + 1)
                                    .TextMatrix(.Row, Cons_Desde) = Format(desde, FEntero)
                                    .TextMatrix(.Row, Cons_Hasta) = Format(Hasta, FEntero)
                                   ' .TextMatrix(.Row, Cons_ClasfRiesgo) = Trim(Datos(5))
                                   ' .TextMatrix(.Row, Cons_GenEmisor) = Trim(Datos(12))
                                    .TextMatrix(.Row, Cons_Serie) = Trim(Left(CmbSerie.Text, 10))
                                     CmbSerie.Visible = False
                                     
                                     .TextMatrix(.Rows - 1, Cons_CodEmisor) = CodEmisor
                                    .SetFocus
                                    .Col = Cons_TasaRef
                                    .Row = .Rows - 1
                                     Call Proc_ValidaSerieGrilla
                                     Call Proc_ValidaExisteSerie
                                     
                                                     
                            ' Exit Sub
                        Loop
                    End With
                    End If
                End If
                With Grd_Datos
                   
                    For nContador = 1 To .Rows - 1
                        If Trim(.TextMatrix(nContador, Cons_CodInst)) <> "" And Trim(.TextMatrix(nContador, Cons_Tipo)) <> "" Then
                            If Trim(Right(Cmb_Familia.Text, 10)) <> Trim(.TextMatrix(nContador, Cons_CodInst)) _
                            And Trim(Mid(Cmb_Familia.Text, 1, 80)) <> Trim(.TextMatrix(nContador, Cons_Tipo)) Then
                                 MsgBox "Serie ingresada no es valida, debe ser " & Trim(Left(Cmb_Familia.Text, 10)), vbExclamation
                                .TextMatrix(.Rows - 1, Cons_Desde) = Format(0, FEntero)
                                .TextMatrix(.Rows - 1, Cons_Hasta) = Format(0, FEntero)
                                .TextMatrix(.Rows - 1, Cons_TasaRef) = Format(0, FDecimal)
                                .Row = nContador
                                .SetFocus
                                 Exit Sub
                            End If
                        End If
                    Next nContador
                  
               End With
        Case vbKeyEscape
            CmbSerie.Visible = False
            Grd_Datos.SetFocus
    End Select
    Tbl_Opciones.Buttons("Grabar").Enabled = True
    Tbl_Opciones.Buttons("Eliminar").Enabled = True
End Sub


Private Sub CmbSerie_KeyPress(KeyAscii As Integer)
     KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub

Private Sub CmbSerie_LostFocus()
    CmbSerie.Visible = False
End Sub

Private Sub Form_Load()
    Me.Icon = BACSwapParametros.Icon
    Me.Top = 0:       Let Me.Left = 0
    
    
    Call Proc_NombresGrilla
    Call Proc_CargaCmbFamilia
    TXTFecha.Text = gsbac_fecp
    FRM_MNT_TASA_REFERENCIAL.Show
    Tbl_Opciones.Buttons("Grabar").Enabled = False
    Tbl_Opciones.Buttons("Eliminar").Enabled = False
    If Me.Cmb_Familia.ListCount > 0 Then
        Cmb_Familia.ListIndex = 0
    End If
    
End Sub

Private Sub Form_Unload(Cancel As Integer)
  Dim nContador1 As Integer
  Dim nContador2 As Integer
  Dim TotGrid As Integer
  
  
  If MsgBox("¿Esta seguro que desea Salir, ¿Grabo la Información? ", vbQuestion + vbYesNo, App.Title) = vbNo Then
     Cancel = vbCancel
    
  Else
  
     With Grd_Datos
     
        If Trim(.TextMatrix(1, Cons_CodInst)) <> "" And Trim(.TextMatrix(1, Cons_Tipo)) <> "" _
            And Trim(.TextMatrix(1, Cons_Desde)) <> "" And Trim(.TextMatrix(1, Cons_Hasta)) <> "" _
            And Trim(.TextMatrix(1, Cons_TasaRef)) <> "" Then
     
            If Trim(Mid(Me.Cmb_Familia, 81, 10)) = Cons_PlazoTramo Then
                   TotGrid = .Rows - 1
                   For nContador1 = 1 To .Rows - 1
                       If TotGrid = nContador1 And nContador1 >= 1 Then
                         
                       Else
                           If CDbl(.TextMatrix(nContador1 + 1, Cons_Desde)) > CDbl(.TextMatrix(nContador1, Cons_Hasta)) + 1 Then
                                Call MsgBox("Revizar Plazos " & "Dias Hasta Valor:" & CDbl(.TextMatrix(nContador1, Cons_Hasta)), vbInformation, App.Title)
                               .Col = Cons_Hasta
                               .Row = nContador1
                               .SetFocus
                               .CellBackColor = vbRed
                                Cancel = vbCancel
                               
                           End If
                       End If
                   Next nContador1
            End If
                
            For nContador1 = 1 To .Rows - 1
                If CDbl(.TextMatrix(nContador1, Cons_Hasta)) = Format(0, FEntero) Then
                  Call MsgBox("Hasta esta en 0, Revizar fila N° " & nContador1, vbInformation, App.Title)
                  .Row = nContador1
                  .Col = Cons_TasaRef: .CellBackColor = vbRed
                  .Col = Cons_Hasta: .CellBackColor = vbRed
                  .SetFocus
                   Cancel = vbCancel
                End If
            Next nContador1
         End If
      End With
  End If
      
End Sub

Private Sub Grd_Datos_DblClick()
    Dim nContador As Integer
        
    If Grd_Datos.Enabled = False Then Exit Sub
            
    With Grd_Datos
                       
        Select Case .Col
            Case Cons_Serie
                If Trim(Mid(Cmb_Familia.Text, 81, 10)) = Cons_PlazoRemanente Then
                    TxtDiasHasta.Visible = False
                    If CmbSerie.ListCount >= 0 Then
                        For nContador = 0 To CmbSerie.ListCount - 1
                            If Trim(Right(CmbSerie.List(nContador), 10)) = Trim(.TextMatrix(.Row, Cons_Serie)) Then
                                CmbSerie.ListIndex = nContador
                                Exit For
                            End If
                        Next nContador
                    
                        CmbSerie.ListIndex = IIf(CmbSerie.ListCount > 0, -1, -1)
                        CmbSerie.Visible = True
                        CmbSerie.Width = .ColWidth(.Col)
                        CmbSerie.Left = .Left + .CellLeft
                        CmbSerie.Top = .Top + .CellTop
                        CmbSerie.SetFocus
                    End If
                End If
            Case Cons_Hasta
                 If Trim(Mid(Cmb_Familia.Text, 81, 10)) = Cons_PlazoTramo Then
                    CmbSerie.Visible = False
                    If .Row > 0 Then
                        TxtDiasHasta.CantidadDecimales = 0
                        TxtDiasHasta.Text = .TextMatrix(.RowSel, .ColSel)
                        Call AJObjeto(Grd_Datos, TxtDiasHasta)
                        Call Habilitacion(True, TxtDiasHasta)
                    End If
                 End If
            Case Cons_TasaRef
                 TxtTasaRef.CantidadDecimales = 4
                 TxtTasaRef.Text = Trim(.TextMatrix(.Row, Cons_TasaRef))
                 TxtTasaRef.Visible = True
                 TxtTasaRef.Width = .ColWidth(.Col)
                 TxtTasaRef.Left = .Left + .CellLeft
                 TxtTasaRef.Top = .Top + .CellTop
                 TxtTasaRef.SetFocus
                 
                If KeyAscii > 47 And KeyAscii < 58 Then Text2.Text = Chr(KeyAscii)
                      
        End Select
             
    End With

                  
End Sub


Private Sub Grd_Datos_KeyDown(KeyCode As Integer, Shift As Integer)
        
  With Grd_Datos
        Select Case KeyCode
            Case vbKeyInsert 'Inserta
            
'            If CDbl(.TextMatrix(.RowSel, Cons_Desde)) = CDbl(.TextMatrix(.RowSel, Cons_Hasta)) Then
'                Call MsgBox("Periodo de Dias hasta, debe ser mayor al periodo de Dias Desde, para poder agregar nuevos valores.", vbInformation, App.Title)
'                .SetFocus
'                Exit Sub
'            End If

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
            
                If CmbSerie.Visible <> True Then
                    If Trim(Mid(Cmb_Familia.Text, 81, 10)) = Cons_PlazoTramo Then
                        CmbSerie.Visible = False
                        If .TextMatrix(.Rows - 1, Cons_CodInst) <> "" And _
                           .TextMatrix(.Rows - 1, Cons_Tipo) <> "" And _
                           .TextMatrix(.Rows - 1, Cons_Desde) <> 0 And _
                           .TextMatrix(.Rows - 1, Cons_Hasta) <> 0 Then
                           
                           
                            Call FUNC_INIT_ROW
                           .SetFocus
                           .Col = Cons_Serie
                           .Row = .Rows - 1
                        Else
                            MsgBox "Debe Completar Valores para Insertar Registro.", vbInformation, App.Title
                            .SetFocus
                             Call Proc_CargaDatosOcultos
                            Exit Sub
                        End If
                        Call Proc_CargaDatosOcultos
                    End If
                    
                    If Trim(Mid(Cmb_Familia.Text, 81, 10)) = Cons_PlazoRemanente Then
                        
                        TxtDiasHasta.Visible = False
                        If .TextMatrix(.Rows - 1, Cons_CodInst) <> "" And _
                           .TextMatrix(.Rows - 1, Cons_Serie) <> "" And _
                           .TextMatrix(.Rows - 1, Cons_Tipo) <> "" And _
                           .TextMatrix(.Rows - 1, Cons_Desde) <> "" And _
                           .TextMatrix(.Rows - 1, Cons_Hasta) <> "" And _
                           .TextMatrix(.Rows - 1, Cons_TasaRef) <> "" Then
        
                            Call FUNC_INIT_ROW
                           .SetFocus
                           .Col = Cons_Serie
                           .Row = .Rows - 1
                        Else
                             MsgBox "Debe Completar Valores para Insertar Registro.", vbInformation, App.Title
                             .SetFocus
                        End If
                     Call Proc_CargaDatosOcultos
                    End If
                End If
        Case vbKeyDelete 'Elimina
            
            If MsgBox("Esta seguro de eliminar la Serie", vbQuestion + vbYesNo, TITSISTEMA) = vbNo Then
            Exit Sub
            End If
            
            If CmbSerie.Visible <> True Then
                If .Rows > 2 Then
                    .RemoveItem .Row
                      
                    If Trim(Mid(Cmb_Familia.Text, 81, 10)) = Cons_PlazoTramo Then
                       
                       If .TextMatrix(1, Cons_Desde) <> 1 Then
                          .TextMatrix(1, Cons_Desde) = Format(1, FEntero)
                       End If
                       
                       Call CargaDiasDesde(0)
                    End If
                 Else
                   .TextMatrix(1, Cons_CodInst) = ""
                   .TextMatrix(1, Cons_Tipo) = ""
                   .TextMatrix(1, Cons_Serie) = ""
                   .TextMatrix(1, Cons_Desde) = ""
                   .TextMatrix(1, Cons_Hasta) = ""
                   .TextMatrix(1, Cons_TasaRef) = ""
                   .TextMatrix(1, Cons_ClasfRiesgo) = ""
                   .TextMatrix(.Rows - 1, Cons_Desde) = Format(0, FEntero)
                   .TextMatrix(.Rows - 1, Cons_Hasta) = Format(0, FEntero)
                   .TextMatrix(.Rows - 1, Cons_TasaRef) = Format(0, FDecimal)
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




Private Sub TxtDiasHasta_Click()
    If TxtDiasHasta.Visible = True Then
        With Grd_Datos
            .TextMatrix(.Row, Cons_Hasta) = Trim(Left(TxtDiasHasta.Text, 50))
        End With
     End If
     Tbl_Opciones.Buttons("Grabar").Enabled = True
     Tbl_Opciones.Buttons("Eliminar").Enabled = True
End Sub

Private Sub TxtDiasHasta_KeyDown(KeyCode As Integer, Shift As Integer)
   Dim xValor  As Double
   Dim TotGrid As Integer
With Grd_Datos
   If KeyCode = vbKeyBack Then
      If Len(TxtDiasHasta.Text) = 1 Then
         Let TxtDiasHasta.Text = Format(0, FEntero)
      End If
   End If

   If KeyCode = vbKeyReturn Then
      xValor = TxtDiasHasta.Text
      
      If xValor > 9999999999# Then
         Call MsgBox("Días hasta  fuera de rango.", vbInformation, App.Title)
         TxtDiasHasta.SetFocus
         Exit Sub
      End If
             
      If xValor = 0 Then
         Call MsgBox("Es necesario, que ingrese un valor mayor al dato anterior.", vbInformation, App.Title)
         
         TxtDiasHasta.SetFocus
         Exit Sub
      End If
    
    TotGrid = .Rows - 1
    If TotGrid = .Row Then
      
    Else
        If CDbl(.TextMatrix(.Row + 1, Cons_Desde)) <= CDbl(TxtDiasHasta.Text) Then
                  Call MsgBox("Dias desde siguiente fila, no puede ser menor o igual que Dias Hasta.", vbInformation, App.Title)
                  TxtDiasHasta.SetFocus
                  Exit Sub
        End If
    End If

   If ValDiasDesde Then
      
      
    Let .TextMatrix(.RowSel, .ColSel) = Format(TxtDiasHasta.Text, FEntero)
         
    TotGrid = .Rows - 1
    
        If TotGrid = .Row And .Rows - 1 >= 1 Then
          
          Else
            If CDbl(.TextMatrix(.Row + 1, Cons_Desde)) > CDbl(TxtDiasHasta.Text) + 1 Then
                 .TextMatrix(.Row + 1, Cons_Desde) = CDbl(TxtDiasHasta.Text) + 1
            End If
        End If
    
    
         Call Habilitacion(False, TxtDiasHasta)
         
         Call .SetFocus
      End If
    Call Proc_CargaDatosOcultos
   End If
   If KeyCode = vbKeyEscape Then
      Call Habilitacion(False, TxtDiasHasta)
      Call .SetFocus
   End If
   
   
 End With
 Tbl_Opciones.Buttons("Grabar").Enabled = True
 Tbl_Opciones.Buttons("Eliminar").Enabled = True
End Sub




Private Sub TxtDiasHasta_LostFocus()
    Me.TxtDiasHasta.Visible = False
End Sub

Private Sub TxtTasaRef_KeyDown(KeyCode As Integer, Shift As Integer)
     Dim nContador1 As Integer
     Select Case KeyCode
        Case vbKeyReturn
            With Grd_Datos
                If IsNumeric(Trim(TxtTasaRef.Text)) = False Then
                     MsgBox "Debe Ingresar solo Numeros.", vbExclamation
                Else
                    .TextMatrix(.Row, Cons_TasaRef) = Trim(TxtTasaRef.Text)
                     TxtTasaRef.Visible = False
                     .SetFocus
                    .Col = Cons_Tipo
                    .Row = .Rows - 1
                
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
                    
            End With
        Case vbKeyEscape
            TxtTasaRef.Visible = False
            Grd_Datos.SetFocus
    End Select
End Sub


Private Sub TxtTasaRef_LostFocus()
    TxtTasaRef.Visible = False
End Sub

