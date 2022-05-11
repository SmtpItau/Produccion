VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "Msflxgrd.ocx"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "comdlg32.ocx"
Begin VB.Form FRM_MNT_TC_CONTABLE 
   Caption         =   "Ingreso de Valores Contables."
   ClientHeight    =   3195
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   5625
   LinkTopic       =   "Form2"
   MDIChild        =   -1  'True
   ScaleHeight     =   3195
   ScaleWidth      =   5625
   Begin MSComctlLib.Toolbar ToolBar 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   5625
      _ExtentX        =   9922
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImlBotones"
      HotImageList    =   "ImlBotones"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   6
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Cerrar"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   6
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Interfaz"
            ImageIndex      =   7
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComDlg.CommonDialog MiCommand 
         Left            =   3660
         Top             =   30
         _ExtentX        =   847
         _ExtentY        =   847
         _Version        =   393216
      End
      Begin MSComctlLib.ImageList ImlBotones 
         Left            =   4410
         Top             =   -90
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
               Picture         =   "FRM_MNT_TC_CONTABLE.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_TC_CONTABLE.frx":0EDA
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_TC_CONTABLE.frx":1DB4
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_TC_CONTABLE.frx":2C8E
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_TC_CONTABLE.frx":3B68
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_TC_CONTABLE.frx":3E82
               Key             =   ""
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_TC_CONTABLE.frx":4D5C
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame CuadroFecha 
      Enabled         =   0   'False
      Height          =   510
      Left            =   0
      TabIndex        =   1
      Top             =   450
      Width           =   5625
      Begin BACControles.TXTFecha FechaCarga 
         Height          =   285
         Left            =   870
         TabIndex        =   3
         TabStop         =   0   'False
         Top             =   150
         Width           =   1515
         _ExtentX        =   2672
         _ExtentY        =   503
         Enabled         =   -1  'True
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "01/02/2007"
      End
      Begin VB.Label Etiqueta 
         AutoSize        =   -1  'True
         Caption         =   "Fecha"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   1
         Left            =   2430
         TabIndex        =   8
         Top             =   195
         Width           =   495
      End
      Begin VB.Label Etiqueta 
         AutoSize        =   -1  'True
         Caption         =   "Fecha"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   0
         Left            =   135
         TabIndex        =   2
         Top             =   180
         Width           =   495
      End
   End
   Begin VB.Frame CuadroGrilla 
      Height          =   2325
      Left            =   0
      TabIndex        =   4
      Top             =   870
      Width           =   5625
      Begin BACControles.TXTNumero txtValor 
         Height          =   330
         Left            =   1605
         TabIndex        =   7
         Top             =   930
         Visible         =   0   'False
         Width           =   1170
         _ExtentX        =   2064
         _ExtentY        =   582
         BackColor       =   -2147483646
         ForeColor       =   -2147483639
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BorderStyle     =   0
         Text            =   "0.0000"
         Text            =   "0.0000"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin VB.ComboBox cmbMoneda 
         BackColor       =   &H80000002&
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000009&
         Height          =   330
         Left            =   225
         Style           =   2  'Dropdown List
         TabIndex        =   6
         Top             =   930
         Visible         =   0   'False
         Width           =   1290
      End
      Begin MSFlexGridLib.MSFlexGrid Grid 
         Height          =   2130
         Left            =   45
         TabIndex        =   5
         Top             =   135
         Width           =   5520
         _ExtentX        =   9737
         _ExtentY        =   3757
         _Version        =   393216
         BackColor       =   -2147483633
         ForeColor       =   -2147483641
         BackColorFixed  =   -2147483646
         ForeColorFixed  =   -2147483639
         BackColorBkg    =   -2147483636
         FocusRect       =   0
         GridLines       =   2
         GridLinesFixed  =   0
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
End
Attribute VB_Name = "FRM_MNT_TC_CONTABLE"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
    '+++jcamposd 20170621, desarrollo que permite duplicar las monedas cuando es un fin de mes especial
    Dim fechaInicial    As Date
    Dim fechaFinal      As Date
    Dim finMes          As Date
    Dim cicloDiasMoneda As Integer
    Dim fechaCiclo      As Date
    '---jcamposd 20170621, desarrollo que permite duplicar las monedas cuando es un fin de mes especial
    
Private Sub FormatoGrilla()
   Grid.Cols = 6: Grid.FixedCols = 0
   Grid.Rows = 2: Grid.FixedRows = 1
   Grid.RowHeightMin = 315
   
   Grid.TextMatrix(0, 0) = "Código Sbif": Grid.ColWidth(0) = 0
   Grid.TextMatrix(0, 1) = "Moneda":      Grid.ColWidth(1) = 3200
   Grid.TextMatrix(0, 2) = "Tipo Cambio": Grid.ColWidth(2) = 1500
   Grid.TextMatrix(0, 3) = "Porcentaje":  Grid.ColWidth(3) = 0
   Grid.TextMatrix(0, 4) = "Spot Compra": Grid.ColWidth(4) = 1500
   Grid.TextMatrix(0, 5) = "Spot Venta":  Grid.ColWidth(5) = 1500
End Sub

Private Sub CargaMonedas()
   Dim Datos()
   
   Envia = Array()
   AddParam Envia, CDbl(5) '--> Indice Lectura Monedas
   If Not Bac_Sql_Execute("SP_MNT_VALOR_MONEDA_CONTABLE", Envia) Then
      Exit Sub
   End If
   Do While Bac_SQL_Fetch(Datos())
      cmbMoneda.AddItem Mid(Datos(2), 1, 3) & "-" & Datos(3)
      cmbMoneda.ItemData(cmbMoneda.NewIndex) = Datos(1)
   Loop
End Sub

Private Sub LeerValorContables()
   Dim Datos()

   Envia = Array()
   AddParam Envia, CDbl(4) '--> Indice Consulta Ultima Carga de Valores
   AddParam Envia, Format(FechaCarga.Text, "YYYYMMDD")
   If Not Bac_Sql_Execute("dbo.SP_MNT_VALOR_MONEDA_CONTABLE", Envia) Then
      Exit Sub
   End If
   Grid.Rows = 1
   Do While Bac_SQL_Fetch(Datos())
      Grid.Rows = Grid.Rows + 1
      Grid.TextMatrix(Grid.Rows - 1, 0) = Datos(2)                   '--> Codigo Sbif
      Grid.TextMatrix(Grid.Rows - 1, 1) = Datos(3)                   '--> Nemo Moneda
      Grid.TextMatrix(Grid.Rows - 1, 2) = Format(Datos(4), FDecimal) '--> Tipo Cambio
      Grid.TextMatrix(Grid.Rows - 1, 3) = Format(Datos(5), FDecimal) '--> Porcentaje Variacion
      Grid.TextMatrix(Grid.Rows - 1, 4) = Format(Datos(6), FDecimal) '--> Bid
      Grid.TextMatrix(Grid.Rows - 1, 5) = Format(Datos(7), FDecimal) '--> Ask
   Loop

   If Grid.Rows = 1 Then
      Grid.Rows = 2
   End If

End Sub

Private Function Exists() As Boolean
   Dim iContador As Long
   
   Exists = True
   For iContador = 1 To Grid.Rows - 1
      If Val(Grid.TextMatrix(iContador, 0)) = cmbMoneda.ItemData(cmbMoneda.ListIndex) And Grid.RowSel <> iContador Then
         Exit Function
      End If
   Next iContador
   Exists = False
   
End Function

Private Sub cmbMoneda_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyReturn Then
      If Exists = True Or cmbMoneda.ListIndex = -1 Then
         MsgBox "Aviso." & vbCrLf & vbCrLf & "La Moneda Seleccionada [" & Mid(cmbMoneda.Text, 1, InStr(1, cmbMoneda.Text, "-") - 1) & "] .... ya se encuentra especificada.", vbExclamation, TITSISTEMA
         Exit Sub
      End If
      Grid.TextMatrix(Grid.RowSel, 0) = cmbMoneda.ItemData(cmbMoneda.ListIndex)
      Grid.TextMatrix(Grid.RowSel, 1) = cmbMoneda.List(cmbMoneda.ListIndex)
      Call AgregaDefault
      Grid.Enabled = True
      cmbMoneda.Visible = False
      Grid.SetFocus
   End If
   If KeyCode = vbKeyEscape Then
      Grid.Enabled = True
      cmbMoneda.Visible = False
      Grid.SetFocus
   End If
End Sub

Private Sub AgregaDefault()
   
   Grid.TextMatrix(Grid.RowSel, 2) = IIf(Grid.TextMatrix(Grid.RowSel, 2) = "", "0.0000", Grid.TextMatrix(Grid.RowSel, 2))
   Grid.TextMatrix(Grid.RowSel, 3) = IIf(Grid.TextMatrix(Grid.RowSel, 3) = "", "0.0000", Grid.TextMatrix(Grid.RowSel, 3))
   Grid.TextMatrix(Grid.RowSel, 4) = IIf(Grid.TextMatrix(Grid.RowSel, 4) = "", "0.0000", Grid.TextMatrix(Grid.RowSel, 4))
   Grid.TextMatrix(Grid.RowSel, 5) = IIf(Grid.TextMatrix(Grid.RowSel, 5) = "", "0.0000", Grid.TextMatrix(Grid.RowSel, 5))
   
End Sub

Private Sub Form_Load()
   Me.Icon = BACSwapParametros.Icon
   Me.Top = 0: Me.Left = 0
   Me.Width = 8250: Me.Height = 8445
   
   FechaCarga.Text = Format(gsbac_fecp, "dd/mm/yyyy")
   Etiqueta(1).Caption = Format(FechaCarga.Text, "dddd, dd") & " de " & Format(FechaCarga.Text, "mmmm") & " del " & Format(FechaCarga.Text, "yyyy")
   
    '+++jcamposd 20170621, desarrollo que permite duplicar las monedas cuando es un fin de mes especial
    fechaInicial = Format(gsbac_fecp, "dd-mm-yyyy")
    fechaFinal = Format(gsBAC_Fecpx, "dd-mm-yyyy")
    finMes = DateAdd("d", -1, DateAdd("m", 1, DateAdd("d", 1, DateAdd("d", (Day(fechaInicial) * -1), fechaInicial))))
    '---jcamposd 20170621, desarrollo que permite duplicar las monedas cuando es un fin de mes especial
   
   Call FormatoGrilla
   Call LeerValorContables
End Sub

Private Sub Form_Resize()
   On Error Resume Next
   
   CuadroFecha.Width = Me.Width - 120
   CuadroGrilla.Width = CuadroFecha.Width
   Grid.Width = CuadroGrilla.Width - 120
   
   CuadroGrilla.Height = Me.Height - (CuadroFecha.Height + 800)
   Grid.Height = CuadroGrilla.Height - 450
   
   On Error GoTo 0
End Sub

Private Sub Grid_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyReturn Then
      If Grid.ColSel = 1 Then
         Grid.Enabled = False
         Call CargaMonedas
         Call PROC_POSICIONA_TEXTO(Grid, cmbMoneda)
         If Grid.TextMatrix(Grid.RowSel, Grid.ColSel) <> "" Then
            cmbMoneda.Text = Grid.TextMatrix(Grid.RowSel, Grid.ColSel)
         End If
         cmbMoneda.Visible = True
         cmbMoneda.SetFocus
      End If
      If Grid.ColSel > 1 Then
         Grid.Enabled = False
         Call PROC_POSICIONA_TEXTO(Grid, txtValor)
         txtValor.Visible = True
         txtValor.Text = Format(Grid.TextMatrix(Grid.RowSel, Grid.ColSel), FDecimal)
         txtValor.SetFocus
      End If
   End If
   
   If KeyCode = vbKeyInsert Then
      Grid.Rows = Grid.Rows + 1
   End If
   
   If KeyCode = vbKeyDelete Then
      If Grid.Rows = 2 Then
         Grid.Rows = 1
         Grid.Rows = 2
      Else
         Grid.RemoveItem (Grid.RowSel)
      End If
   End If
End Sub

Private Sub ToolBar_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 1
         Call LeerValorContables
      Case 2
         Call Grabarvalores
      Case 3
         Unload Me
      Case 5
         Call CargarExcel
      '============================================================================
      ' LD1-COR-035-Configuración BAC Corpbanca  , Tema: Interfaz TCRC917-TCRC915
      ' INICIO
      '============================================================================
      Case 6
         If Genera_Txtdolar() Or Genera_TxtParidad() Then
           MsgBox "Exportación generada con éxito", vbOKOnly + vbInformation, TITSISTEMA
         End If
      '============================================================================
      ' LD1-COR-035-Configuración BAC Corpbanca  , Tema: Interfaz TCRC917-TCRC915
      ' FIN
      '============================================================================
   End Select
End Sub

'============================================================================
' LD1-COR-035-Configuración BAC Corpbanca  , Tema: Interfaz TCRC917-TCRC915
' INICIO
'============================================================================
Function Genera_Txtdolar() As Boolean

    
    Dim Datos()
    Dim i As Integer
    Dim Cont As Integer
    Dim cNomArch As String
    Dim cNomArchivo As String
    Dim cRuta  As String
    Dim AuxArr() As String
     
    Genera_Txtdolar = True
        
    Envia = Array()
    AddParam Envia, 1
   
    If Not Bac_Sql_Execute("Sp_BacInterfaces_Archivo_Pca", Envia) Then
      MsgBox "Problemas al Leer Archivo de Interfaces", vbCritical, TITSISTEMA
      Genera_Txtdolar = False
      Exit Function
    End If
      
    If Bac_SQL_Fetch(Datos()) Then
   
      cNomArchivo = Mid(Datos(2), 1, 6) + Mid(FechaCarga.Text, 1, 2) + Mid(FechaCarga.Text, 4, 2) + Mid(FechaCarga.Text, 7, 4) + ".TXT"
      cNomArch = cNomArchivo
      cRuta = Datos(4)
   
    End If
   
    cNomArchivo = cRuta + cNomArchivo
    
    If Dir(cNomArchivo, vbArchive) <> "" Then
          If MsgBox("Ya Existe el Archivo: " + cNomArch + "  Lo Reemplaza ? ", vbInformation + vbYesNo) = vbNo Then
             Genera_Txtdolar = False
             Exit Function
          End If
    End If
    

    Envia = Array()
    Close #1
    Open cNomArchivo For Output As #1
    Cont = 0
    With Grid
            
        Linea = "D21"
        Linea = Linea + Mid(FechaCarga.Text, 1, 2) + Mid(FechaCarga.Text, 4, 2) + Mid(FechaCarga.Text, 7, 4)
        Print #1, Linea
        For i = 1 To .Rows - 1
               .Row = i
                            
                Linea = ""
                 If Bac_Sql_Execute("sp_busca_trae_monedas ") Then
                        Do While Bac_SQL_Fetch(Datos())
                            AuxArr = Split(Trim(.TextMatrix(.Row, 1)), "-")
                            'If Trim(.TextMatrix(.Row, 1)) = datos(2) Then
                            If AuxArr(1) = Datos(2) Then
                               'If Trim(.TextMatrix(.Row, 1)) = "DOLAR OBSERVADO" Then
                               If AuxArr(1) = "DOLAR OBSERVADO" Then
                                    Linea = Linea & Datos(3) + Space(8)
                                    Linea = Linea & Format(.TextMatrix(.Row, 2), "00000.00000000")
                                    Linea = Replace(Linea, ".", "")
                                    Linea = Replace(Linea, ",", "")
                                    'linea = linea & FormatoString((Val(.TextMatrix(.Row, 2))), "d", 9)
                                    'linea = linea & FormatoString((Val(.TextMatrix(.Row, 3))), "d", 9)
                                    'linea = linea & FormatoString((Val(Datos(1))), "d", 9)
                               End If
                            End If
                        Loop
                    Else
                        MsgBox "No se pudo obtener información del servidor", 16, TITSISTEMA
                        Exit Function
                    End If
                                
                If Len(Linea) > 1 Then
                  Print #1, Linea
                End If
        Next
       
    End With
    Close #1

End Function

Function Genera_TxtParidad()
    
    Dim Datos()
    Dim i As Integer
    Dim Cont As Integer
    Dim cNomArch As String
    Dim cNomArchivo As String
    Dim cRuta  As String
    Dim AuxArr() As String
    
    Genera_TxtParidad = True
        
    Envia = Array()
    AddParam Envia, 2
   
    If Not Bac_Sql_Execute("Sp_BacInterfaces_Archivo_Pca", Envia) Then
      MsgBox "Problemas al Leer Archivo de Interfaces", vbCritical, TITSISTEMA
      Genera_TxtParidad = False
      Exit Function
    End If
      
    If Bac_SQL_Fetch(Datos()) Then
   
      cNomArchivo = Mid(Datos(2), 1, 6) + Mid(FechaCarga.Text, 1, 2) + Mid(FechaCarga.Text, 4, 2) + Mid(FechaCarga.Text, 7, 4) + ".TXT"
      cNomArch = cNomArchivo
      cRuta = Datos(4)
   
    End If
   
    cNomArchivo = cRuta + cNomArchivo
    
    If Dir(cNomArchivo, vbArchive) <> "" Then
          If MsgBox("Ya Existe el Archivo: " + cNomArch + "  Lo Reemplaza ? ", vbInformation + vbYesNo) = vbNo Then
             Genera_TxtParidad = False
             Exit Function
          End If
    End If
    

    Envia = Array()
    Close #1
    Open cNomArchivo For Output As #1
    Cont = 0
    With Grid
        Linea = "D21"
        Linea = Linea + Mid(FechaCarga.Text, 1, 2) + Mid(FechaCarga.Text, 4, 2) + Mid(FechaCarga.Text, 7, 4)
        Print #1, Linea
        For i = 1 To .Rows - 1
               .Row = i
                            
                Linea = ""
                 If Bac_Sql_Execute("sp_busca_trae_monedas ") Then
                        Do While Bac_SQL_Fetch(Datos())
                            AuxArr = Split(Trim(.TextMatrix(.Row, 1)), "-")
                            'If Trim(.TextMatrix(.Row, 1)) = datos(2) Then
                            If AuxArr(1) = Datos(2) Then
                              'If Trim(.TextMatrix(.Row, 1)) <> "DOLAR OBSERVADO" Then
                              If AuxArr(1) <> "DOLAR OBSERVADO" Then
                                    Linea = Linea & Datos(3) + Space(8)
                                    Linea = Linea & Format(.TextMatrix(.Row, 2), "00000.00000000")
                                    Linea = Replace(Linea, ".", "")
                                    Linea = Replace(Linea, ",", "")
                                    'linea = linea & FormatoString((Val(.TextMatrix(.Row, 2))), "d", 9)
                                    'linea = linea & FormatoString((Val(.TextMatrix(.Row, 3))), "d", 9)
                                    'linea = linea & FormatoString((Val(Datos(1))), "d", 9)
                              Else
                                  '  linea = "B24" + Space(8)
                                  '  linea = linea & Format(.TextMatrix(.Row, 1), "00000.00000000")
                                  '  linea = Replace(linea, ".", "")
                              End If
                            End If
                        Loop
                    Else
                        MsgBox "No se pudo obtener información del servidor", 16, TITSISTEMA
                        Genera_TxtParidad = False
                        Exit Function
                    End If
                
               If Len(Linea) > 1 Then
                  Print #1, Linea
               End If
        
        Next
    End With
    Close #1
    
End Function

'============================================================================
' LD1-COR-035-Configuración BAC Corpbanca  , Tema: Interfaz TCRC917-TCRC915
' INICIO
'============================================================================

Private Sub CargarExcel()
   On Error GoTo ErrorExcell
   Dim MiExcell         As New Excel.Application
   Dim MiLibro          As New Excel.Workbook
   Dim MiHoja           As New Excel.Worksheet
   Dim iFilas           As Long
   Dim iContador        As Long
   Dim iMoneda          As Integer
   Dim nValor           As Double
   Dim nSpotCompra      As Double
   Dim nSpotVenta       As Double
   
   
ShowOpenAgain:
   Let MiCommand.FileName = ""
   Let MiCommand.Filter = "*.xls"
  Call MiCommand.ShowOpen
   
   If Not UCase(MiCommand.FileName) Like "*" & Format(FechaCarga.Text, "YYMMDD") & ".XLS" Then
      If MsgBox("Advertencia." & vbCrLf & vbCrLf & "La planilla seleccionada no concuerda con la fecha de proceso." & vbCrLf & vbCrLf & ".... Reintente con otra planilla.", vbExclamation + vbRetryCancel, TITSISTEMA) = vbRetry Then
         GoTo ShowOpenAgain
      Else
         GoTo ErrorExcell
      End If
   End If
   
   Set MiExcell = CreateObject("Excel.Application")
   Set MiLibro = MiExcell.Workbooks.Open(MiCommand.FileName)

   Screen.MousePointer = vbHourglass
   Set MiHoja = Nothing
   Set MiHoja = MiLibro.Worksheets(1)
   
    '+++jcamposd 20170621, desarrollo que permite duplicar las monedas cuando es un fin de mes especial
    contadorDias = 1
    cicloDiasMoneda = 1
    fechaCiclo = fechaInicial
   
    If (finMes <> fechaInicial) And (Month(finMes) <> Month(fechaFinal)) Then   '-->  jcamposd 20170621 es fin de mes especial
        contadorDias = DateDiff("D", fechaInicial, fechaFinal) + 1 '--> jcamposd 20170621 el mas 1 es porque debe considerar la fecha en curso
    End If
   
    iFilas = MiHoja.Columns.End(xlDown).Row
   
    For cicloDiasMoneda = 1 To contadorDias
    '---jcamposd 20170621, desarrollo que permite duplicar las monedas cuando es un fin de mes especial
   
        Envia = Array()
        AddParam Envia, CDbl(0)                               '--> Limpia
        'AddParam Envia, Format(FechaCarga.Text, "YYYYMMDD")   '--> Fecha
        AddParam Envia, fechaCiclo                              '--> Fecha
        Call Bac_Sql_Execute("dbo.SP_CARGA_VMON_CNT", Envia)
   
        'iFilas = MiHoja.Columns.End(xlDown).Row
        For iContador = 2 To iFilas
           iMoneda = Val(MiHoja.Cells(iContador, "A"))
           nValor = IIf(MiHoja.Cells(iContador, "B") <> "", CDbl(MiHoja.Cells(iContador, "B")), 0#)
           nSpotCompra = IIf(MiHoja.Cells(iContador, "C") <> "", CDbl(MiHoja.Cells(iContador, "C")), 0#)
           nSpotVenta = IIf(MiHoja.Cells(iContador, "D") <> "", CDbl(MiHoja.Cells(iContador, "D")), 0#)
           
           If PorcentajeVariacion(iMoneda, nValor) = True Then
              Envia = Array()
              AddParam Envia, CDbl(1)                               '--> Inserta
              'AddParam Envia, Format(FechaCarga.Text, "YYYYMMDD")  '--> Fecha
              AddParam Envia, fechaCiclo                            '--> Fecha
              AddParam Envia, iMoneda                               '--> Moneda
              AddParam Envia, nValor                                '--> Valor Contable
              AddParam Envia, nSpotCompra                           '--> Spot Compra
              AddParam Envia, nSpotVenta                            '--> Spot Venta
              If Not Bac_Sql_Execute("dbo.SP_CARGA_VMON_CNT", Envia) Then
                 MsgBox "Problemas en la grabación", vbExclamation, TITSISTEMA
              End If
           End If
        Next iContador
   
        fechaCiclo = DateAdd("d", 1, fechaCiclo)
    
    Next cicloDiasMoneda
   
   
   Screen.MousePointer = vbDefault
   
   MiLibro.Close
   Set MiExcell = Nothing
   Set MiLibro = Nothing
   Set MiHoja = Nothing
   
   Call LeerValorContables
   
   MsgBox "Valores de Moneda Contable han sido cargados con exito.", vbInformation, TITSISTEMA
   
Exit Sub
ErrorExcell:
   Screen.MousePointer = vbDefault
   If Err.Number <> 32755 Then
      MsgBox "Error al cargar valores de moneda contable.", vbExclamation, TITSISTEMA
   End If

End Sub

Private Sub txtValor_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyReturn Then
      If Grid.ColSel = 2 Then
         If PorcentajeVariacion(Grid.TextMatrix(Grid.RowSel, 0), txtValor.Text) = False Then
            MsgBox "Advertencia." & vbCrLf & vbCrLf & "Tipo de Cambio Excede Porcentaje de Variación", vbExclamation, TITSISTEMA
            txtValor.SetFocus
            Exit Sub
         End If
      End If
      Grid.TextMatrix(Grid.RowSel, Grid.ColSel) = Format(txtValor.Text, FDecimal)
      Grid.Enabled = True
      txtValor.Visible = False
      Grid.SetFocus
   End If
   If KeyCode = vbKeyEscape Then
      Grid.Enabled = True
      txtValor.Visible = False
      Grid.SetFocus
   End If
End Sub

Private Function PorcentajeVariacion(iMonedas As Integer, iTipCambio As Double) As Boolean
   Dim Datos()
   Dim fValorAyer    As Double
   Dim fValorHoy     As Double
   Dim fPorcentaje   As Double
   Dim fCalculo      As Double
   
   PorcentajeVariacion = True
   
   fValorHoy = iTipCambio
   
   fCalculo = CDbl(0#)
   
   Envia = Array()
   AddParam Envia, CDbl(6) '--> Indice Consulta para Variación
   AddParam Envia, Format(FechaCarga.Text, "yyyymmdd")
   AddParam Envia, CDbl(iMonedas)
   If Not Bac_Sql_Execute("SP_MNT_VALOR_MONEDA_CONTABLE", Envia) Then
      Exit Function
   End If
   If Bac_SQL_Fetch(Datos()) Then
      fValorAyer = CDbl(Datos(1))
      fPorcentaje = CDbl(Datos(2))
   
      If fValorAyer = 0# Then
         Exit Function
      End If
   
      fCalculo = Abs(CDbl(100#) - (fValorHoy / fValorAyer) * CDbl(100#))
      
      If fCalculo > fPorcentaje Then
         If fValorAyer = 1# Then
            txtValor.Text = 1#
         End If
         PorcentajeVariacion = False
      End If
   
   End If
   
   Grid.TextMatrix(Grid.RowSel, 3) = Format(fCalculo, FDecimal)
End Function

Private Sub Grabarvalores()
   Dim Datos()
   Dim iContador     As Long
   Dim CodigoSuper   As Integer
   Dim NemoMoneda    As String
   Dim TCContable    As Double
   Dim ivariacion    As Double
   Dim PuntaBid      As Double
   Dim PuntaAsk      As Double
   Dim contadorDias As Integer
   
    Call BacBeginTransaction
   
    contadorDias = 1
    cicloDiasMoneda = 1
    fechaCiclo = fechaInicial
   
    If (finMes <> fechaInicial) And (Month(finMes) <> Month(fechaFinal)) Then   '-->  jcamposd 20170621 es fin de mes especial
        contadorDias = DateDiff("D", fechaInicial, fechaFinal) + 1 '--> jcamposd 20170621 el mas 1 es porque debe considerar la fecha en curso
    End If
   
   
    For cicloDiasMoneda = 1 To contadorDias
              
        Envia = Array()
        AddParam Envia, CDbl(2) '--> Indice Eliminación de Registros.
        '+++jcamposd
        'AddParam Envia, Format(FechaCarga.Text, "yyyymmdd")
        AddParam Envia, fechaCiclo
        '---jcamposd
        If Not Bac_Sql_Execute("SP_MNT_VALOR_MONEDA_CONTABLE", Envia) Then
           GoTo ErrorSaveDat
        End If
   
   
   
        For iContador = 1 To Grid.Rows - 1
           CodigoSuper = Val(Grid.TextMatrix(iContador, 0))
           
           If CodigoSuper <> 0 Then
              NemoMoneda = Mid(Grid.TextMatrix(iContador, 1), 1, InStr(1, Grid.TextMatrix(iContador, 1), "-") - 1)
              TCContable = CDbl(Grid.TextMatrix(iContador, 2))
              ivariacion = CDbl(Grid.TextMatrix(iContador, 3))
              PuntaBid = CDbl(Grid.TextMatrix(iContador, 4))
              PuntaAsk = CDbl(Grid.TextMatrix(iContador, 5))
              
              Envia = Array()
              AddParam Envia, CDbl(3) '--> Indice Grabación de Registros.
              '+++jcamposd
              'AddParam Envia, Format(FechaCarga.Text, "yyyymmdd")            '--> Fecha
              AddParam Envia, fechaCiclo                                      '--> Fecha
              '---jcamposd
              AddParam Envia, CodigoSuper                                    '--> Codigo
              AddParam Envia, NemoMoneda                                     '--> Nemo
              AddParam Envia, CDbl(0)                                        '--> Codigo Cnt
              AddParam Envia, TCContable                                     '--> TC Cambio
              AddParam Envia, ivariacion                                     '--> Variacion
              AddParam Envia, PuntaBid                                       '--> Punta Bid
              AddParam Envia, PuntaAsk                                       '--> Punta Ask
              If Not Bac_Sql_Execute("SP_MNT_VALOR_MONEDA_CONTABLE", Envia) Then
                 GoTo ErrorSaveDat
              End If
           End If
        Next iContador
    
        fechaCiclo = DateAdd("d", 1, fechaCiclo)
    
    Next cicloDiasMoneda
   
       Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                          , gsbac_fecp _
                          , gsBac_IP _
                          , gsBAC_User _
                          , "PCA" _
                          , "OPC_902" _
                          , "01" _
                          , "GRABA" _
                          , " " _
                          , " " _
                          , " ")
                          
   Call BacCommitTransaction
   
   MsgBox "Ok." & vbCrLf & vbCrLf & "Actualización de Registros ha finalizado Ok.", vbInformation, TITSISTEMA
Exit Sub
ErrorSaveDat:
   Call BacRollBackTransaction
   MsgBox "Error." & vbCrLf & vbCrLf & "Error en la Actualización de Registros.", vbExclamation, TITSISTEMA
End Sub
