VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form FRM_MNT_REDTHRESHOLD 
   Caption         =   "Mantención de Tabla de Reducción de Threshold."
   ClientHeight    =   5835
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   6540
   LinkTopic       =   "Form2"
   LockControls    =   -1  'True
   MDIChild        =   -1  'True
   ScaleHeight     =   5835
   ScaleWidth      =   6540
   Begin BACControles.TXTNumero txtCampo 
      Height          =   315
      Left            =   1800
      TabIndex        =   7
      TabStop         =   0   'False
      Top             =   2160
      Visible         =   0   'False
      Width           =   1335
      _ExtentX        =   2355
      _ExtentY        =   556
      BackColor       =   -2147483646
      ForeColor       =   -2147483643
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BorderStyle     =   0
      Text            =   "0"
      Text            =   "0"
      Min             =   "0"
      Separator       =   -1  'True
      MarcaTexto      =   -1  'True
   End
   Begin VB.ComboBox cmbClasif 
      BackColor       =   &H80000002&
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000005&
      Height          =   330
      Left            =   120
      Style           =   2  'Dropdown List
      TabIndex        =   6
      Top             =   2160
      Visible         =   0   'False
      Width           =   1335
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   6540
      _ExtentX        =   11536
      _ExtentY        =   794
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   7
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "botBuscar"
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "botLimpiar"
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "botGuardar"
            Object.ToolTipText     =   "Guardar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   3
            Style           =   3
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "botDelSegmento"
            Object.ToolTipText     =   "Borrar Segmento"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button7 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "botSalir"
            Object.ToolTipText     =   "Cerrar"
            ImageIndex      =   5
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   5190
         Top             =   15
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
               Picture         =   "FRM_MNT_REDTHRESHOLD.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_REDTHRESHOLD.frx":0EDA
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_REDTHRESHOLD.frx":1DB4
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_REDTHRESHOLD.frx":2C8E
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_REDTHRESHOLD.frx":3B68
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame FRA_SEGMENTO 
      Height          =   735
      Left            =   30
      TabIndex        =   1
      Top             =   375
      Width           =   6495
      Begin VB.ComboBox CmbSegmentoComercial 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   105
         Style           =   2  'Dropdown List
         TabIndex        =   3
         Top             =   330
         Width           =   6030
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Segmento Comercial"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   210
         Left            =   120
         TabIndex        =   2
         Top             =   120
         Width           =   1470
      End
   End
   Begin VB.Frame FRA_DETALLE 
      Enabled         =   0   'False
      Height          =   4800
      Left            =   30
      TabIndex        =   4
      Top             =   1020
      Width           =   6495
      Begin MSFlexGridLib.MSFlexGrid Grilla 
         Height          =   4260
         Left            =   30
         TabIndex        =   5
         Top             =   120
         Width           =   6405
         _ExtentX        =   11298
         _ExtentY        =   7514
         _Version        =   393216
         Cols            =   4
         FixedCols       =   0
         RowHeightMin    =   315
         BackColor       =   -2147483633
         ForeColor       =   -2147483641
         BackColorFixed  =   -2147483646
         ForeColorFixed  =   -2147483639
         BackColorBkg    =   -2147483636
         GridColor       =   -2147483633
         GridColorFixed  =   -2147483642
         FocusRect       =   0
         GridLines       =   2
         GridLinesFixed  =   0
         AllowUserResizing=   2
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin VB.Label LblPiePagina 
         AutoSize        =   -1  'True
         Caption         =   "INS"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   195
         Index           =   0
         Left            =   45
         TabIndex        =   11
         Top             =   4545
         Width           =   330
      End
      Begin VB.Label LblPiePagina 
         AutoSize        =   -1  'True
         Caption         =   "SUPR"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   195
         Index           =   2
         Left            =   4365
         TabIndex        =   10
         Top             =   4545
         Width           =   525
      End
      Begin VB.Label LblPiePagina 
         AutoSize        =   -1  'True
         Caption         =   "Agregar fila a grilla"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   210
         Index           =   1
         Left            =   525
         TabIndex        =   9
         Top             =   4530
         Width           =   1365
      End
      Begin VB.Label LblPiePagina 
         AutoSize        =   -1  'True
         Caption         =   "Borrar fila de grilla"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   210
         Index           =   3
         Left            =   4965
         TabIndex        =   8
         Top             =   4545
         Width           =   1320
      End
   End
End
Attribute VB_Name = "FRM_MNT_REDTHRESHOLD"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'Const gPuntero = 0
Const gInternacional = 0
Const gNacional = 1
Const gPorcentaje = 2
Const gMonto = 3
Const gNomInt = 4
Const gNomNac = 5

Private Function FuncSettingGrid()
   Let Grilla.Rows = 2:       Let Grilla.Cols = 6
   Let Grilla.FixedRows = 1:  Let Grilla.FixedCols = 0

   Let Grilla.TextMatrix(0, gInternacional) = "Clasif. Internacional":   Let Grilla.ColWidth(gInternacional) = 0    '1500
   Let Grilla.TextMatrix(0, gNacional) = "Clasif. Nacional":             Let Grilla.ColWidth(gNacional) = 1500
   Let Grilla.TextMatrix(0, gPorcentaje) = "Porcentaje REC":            Let Grilla.ColWidth(gPorcentaje) = 1200
   Let Grilla.TextMatrix(0, gMonto) = "Monto Tope US$":                 Let Grilla.ColWidth(gMonto) = 1800
   Let Grilla.TextMatrix(0, gNomInt) = "":                              Let Grilla.ColWidth(gNomInt) = 0
   Let Grilla.TextMatrix(0, gNomNac) = "":                              Let Grilla.ColWidth(gNomNac) = 0
End Function

Private Function FuncLoadSegmentoComercial()
   Dim Datos()

   Envia = Array()
   If Not Bac_Sql_Execute("Bacparamsuda.dbo.SP_TRAESEGMENTOCOMERCIAL", Envia) Then
      MsgBox "Error al cargar los Segmentos Comerciales", vbCritical, TITSISTEMA
      Exit Function
   End If
   Do While Bac_SQL_Fetch(Datos())
      CmbSegmentoComercial.AddItem Datos(1) & Space(200) & Datos(2)
      CmbSegmentoComercial.ItemData(CmbSegmentoComercial.NewIndex) = Datos(2)
   Loop

End Function

Private Function FuncLoadClasificacion()
   Dim Datos()

   Envia = Array()
   If Not Bac_Sql_Execute("Bacparamsuda.dbo.SP_TRAECLASIFICACIONRIESGO", Envia) Then
      MsgBox "Error al cargar las Clasificaciones de Riesgos", vbCritical, TITSISTEMA
      Exit Function
   End If
   Do While Bac_SQL_Fetch(Datos())
      cmbClasif.AddItem Datos(1) & Space(200) & Datos(2)
   Loop
End Function

Private Sub cmbClasif_KeyDown(KeyCode As Integer, Shift As Integer)
   Dim Fila    As Integer
   Dim xCol    As Integer
   Dim Dato    As String
   Dim dato1   As String
   Dim dato2   As String
    
   If KeyCode = vbKeyReturn Then
      If cmbClasif.ListIndex = -1 Then
         cmbClasif.Visible = False
         Grilla.Enabled = True
         Toolbar1.Enabled = True
         FRA_SEGMENTO.Enabled = True
         Grilla.SetFocus
         Exit Sub
      End If
        
      Fila = Grilla.Row
      Dato = cmbClasif.Text
        
      If Dato = "" Then
         Exit Sub
      End If
      
      xCol = Grilla.Col
      dato1 = RTrim(Mid$(Dato, 1, 100))
      dato2 = LTrim(Mid$(Dato, 100))
        
      'Bloquear la Grilla y la Toolbar
      Grilla.Enabled = False
      Toolbar1.Enabled = False
      FRA_SEGMENTO.Enabled = False
      
      'Revisar si el valor ya está en la misma columna excepto en la fila actual
      If DatoEsta(dato1, CInt(dato2), Fila, xCol) Then
         MsgBox "Atención! El valor seleccionado ya existe en otra fila de la misma columna", vbExclamation, TITSISTEMA
         Exit Sub
      End If
        
      Grilla.Enabled = True
      Toolbar1.Enabled = True
      FRA_SEGMENTO.Enabled = True
      Grilla.TextMatrix(Fila, xCol) = dato1

      'Solo llegara para xCol = 1
      Grilla.TextMatrix(Fila, gNomNac) = dato2
      
      'Replicar el valor en la columna oculta
      Grilla.TextMatrix(Fila, gNomInt) = dato2
      cmbClasif.Visible = False
      Grilla.SetFocus
   End If
   
   If KeyCode = vbKeyEscape Then
      cmbClasif.Visible = False
      If Grilla.Enabled = False Then
         Grilla.Enabled = True
      End If
      If Toolbar1.Enabled = False Then
         Toolbar1.Enabled = True
      End If
      If FRA_SEGMENTO.Enabled = False Then
         FRA_SEGMENTO.Enabled = True
      End If
      Grilla.SetFocus
   End If

End Sub

Private Sub CmbSegmentoComercial_Click()
   Call Buscar
End Sub

Private Sub Form_Load()
   Let Me.top = 0: Me.Left = 0
   Let Me.Icon = BacControlFinanciero.Icon

   Call FuncSettingGrid
   Call FuncLoadSegmentoComercial
   Call FuncLoadClasificacion
End Sub

Private Sub Form_Resize()
   On Error Resume Next

   FRA_SEGMENTO.Width = Me.Width - 150
   FRA_DETALLE.Width = FRA_SEGMENTO.Width
   Grilla.Width = FRA_DETALLE.Width - 100
   
   FRA_DETALLE.Height = Me.Height - 1550
   Grilla.Height = FRA_DETALLE.Height - 550
   
   LblPiePagina(0).top = FRA_DETALLE.Height - 300
   LblPiePagina(1).top = LblPiePagina(0).top
   LblPiePagina(2).top = LblPiePagina(0).top
   LblPiePagina(3).top = LblPiePagina(0).top
   
   On Error GoTo 0
End Sub

Private Sub Grilla_DblClick()
   Call Grilla_KeyDown(vbKeyReturn, 0)
End Sub

Private Sub Grilla_KeyDown(KeyCode As Integer, Shift As Integer)
   Dim Fila    As Integer
   Dim top     As Integer
   Dim lef     As Integer
   Dim p       As Integer

   Fila = Grilla.RowSel

   Select Case KeyCode
      Case vbKeyReturn
         
         Select Case Grilla.ColSel
            Case 0, 1 'Mostrar combo
               Call PROC_POSICIONA_TEXTO(Grilla, cmbClasif)
               If Grilla.ColSel = 0 Then
                  If Grilla.TextMatrix(Grilla.RowSel, 0) <> "" Then
                     p = CInt(Grilla.TextMatrix(Grilla.RowSel, 4))
                     cmbClasif.ListIndex = p - 1
                  End If
               Else
                  If Grilla.TextMatrix(Grilla.RowSel, 1) <> "" Then
                     p = CInt(Grilla.TextMatrix(Grilla.RowSel, 5))
                     cmbClasif.ListIndex = p - 1
                  End If
               End If
               top = Grilla.CellTop + Grilla.top + FRA_DETALLE.top
               lef = Grilla.CellLeft + Grilla.Left + FRA_DETALLE.Left
               cmbClasif.top = top
               cmbClasif.Left = lef
               cmbClasif.Visible = True
               Grilla.Enabled = False
               Toolbar1.Enabled = False
               FRA_SEGMENTO.Enabled = False
               cmbClasif.SetFocus
            
            Case 2  'Editar % REC
               Call Editar(1)
            Case 3  'Editar Monto Tope
               Call Editar(2)
         End Select
    
      Case vbKeyInsert
         '¿Está completa la fila anterior? (¿o es esta la primera fila?)
         If FilaCompleta(Grilla.Rows - 1) Then
            Grilla.Rows = Grilla.Rows + 1
            Grilla.TextMatrix(Grilla.Rows - 1, 2) = 0
            Grilla.TextMatrix(Grilla.Rows - 1, 3) = 0
            Grilla.SetFocus
         Else
            MsgBox "La fila anterior no está completa. No puede insertar una nueva. !", vbInformation, TITSISTEMA
            Grilla.SetFocus
            Exit Sub
         End If
    
      Case vbKeyDelete
         'Si fila es vacía eliminar, sino preguntar
         If FilaEstaVacia(Fila) Then
            If Grilla.Row > Grilla.FixedRows Then
               Grilla.RemoveItem (Fila)
            End If
         Else
            If MsgBox("La fila tiene datos. ¿Desea borrarla?", vbYesNo + vbQuestion, TITSISTEMA) = vbYes Then
               If Grilla.Row > Grilla.FixedRows Then
                  Grilla.RemoveItem (Fila)
               Else
                  VaciarFila (Fila)
               End If
               Grilla.SetFocus
            Else
               Grilla.RowSel = Fila
               Grilla.SetFocus
            End If
         End If
   End Select
End Sub

Private Function FilaCompleta(ByVal Fila As Integer) As Boolean
   'Si es la primera fila, se asume completa la anterior
   FilaCompleta = True
   If Fila = 0 Then
      Exit Function
   End If

   'Se asume completa la fila si los campos en las columnas 4 y 5 son distintos de "" (los punteros de los datos en columnas 0 y 1)
   If Grilla.TextMatrix(Fila, 4) <> "" And Grilla.TextMatrix(Fila, 5) <> "" Then
      FilaCompleta = True
   Else
      FilaCompleta = False
   End If
End Function

Private Function VaciarFila(ByVal xFila As Integer)
   Grilla.TextMatrix(xFila, 0) = ""
   Grilla.TextMatrix(xFila, 1) = ""
   Grilla.TextMatrix(xFila, 2) = ""
   Grilla.TextMatrix(xFila, 3) = ""
   Grilla.TextMatrix(xFila, 4) = ""
   Grilla.TextMatrix(xFila, 5) = ""
End Function

Private Function Editar(ByVal Tipo As Integer)
   Dim Fila    As Integer
   Dim top     As Integer
   Dim lef     As Integer
   Dim oTop    As Integer
   Dim oLef    As Integer
   Dim xCol    As Integer
   
   Fila = Grilla.RowSel
   xCol = Grilla.ColSel
   oTop = txtCampo.top
   oLef = txtCampo.Left
   top = Grilla.CellTop + Grilla.top + FRA_DETALLE.top
   lef = Grilla.CellLeft + Grilla.Left + FRA_DETALLE.Left

   Select Case Tipo
      Case 1  '% de REC
         Grilla.Enabled = False
         Toolbar1.Enabled = False
         FRA_SEGMENTO.Enabled = False
         txtCampo.Max = 100
         txtCampo.Min = 0
         txtCampo.CantidadDecimales = 0
         txtCampo.Enabled = True
         txtCampo.Visible = True
         txtCampo.Width = Grilla.CellWidth
         txtCampo.top = top
         txtCampo.Left = lef
         txtCampo.Text = Grilla.TextMatrix(Fila, xCol)
         txtCampo.SetFocus
      Case 2  'Valor del Threshold
         Grilla.Enabled = False
         Toolbar1.Enabled = False
         FRA_SEGMENTO.Enabled = False
         txtCampo.Max = 9999999999999#
         txtCampo.Min = 0
         txtCampo.CantidadDecimales = 0
         txtCampo.Enabled = True
         txtCampo.Visible = True
         txtCampo.Width = Grilla.CellWidth
         txtCampo.top = top
         txtCampo.Left = lef
         txtCampo.Text = Grilla.TextMatrix(Fila, xCol)
         txtCampo.SetFocus
   End Select

End Function

Private Function FilaEstaVacia(ByVal Fila As Integer) As Boolean
   FilaEstaVacia = False
   If Grilla.TextMatrix(Fila, 0) = "" And Grilla.TextMatrix(Fila, 1) = "" And Grilla.TextMatrix(Fila, 2) = "" And Grilla.TextMatrix(Fila, 3) = "" Then
      FilaEstaVacia = True
   End If
End Function

Private Function DatoEsta(ByVal bDato As String, ByVal cdato As Integer, ByVal xFila As Integer, ByVal xCol As Integer) As Boolean
   Dim cMirror As Integer
   Dim I       As Integer
   Dim n       As Integer
   Dim mPos    As Integer
   Dim cParte  As Integer

   If xCol = 0 Then
      cMirror = 4
   Else
      cMirror = 5
   End If

   n = Grilla.Rows
   DatoEsta = False

   If Grilla.TextMatrix(xFila, cMirror) = "" And xFila = 1 Then
      DatoEsta = False
      Exit Function
   End If

   For I = 1 To n - 1
      If I <> xFila Then
         cParte = CInt(Grilla.TextMatrix(I, cMirror))
         If cParte = cdato Then
            DatoEsta = True
            Exit For
         End If
      End If
   Next
End Function

Private Function FijaCombo(ByVal Dato As String)
   Dim I    As Integer
   Dim n    As Integer
   Dim p    As Integer
   Dim rev  As String

   p = -1
   If Dato = "" Then
      cmbClasif.ListIndex = p
      Exit Function
   End If
   
   n = cmbClasif.ListCount
   For I = 0 To n - 1
      If Len(cmbClasif.List(I)) > 100 Then
         rev = RTrim(Mid$(cmbClasif.List(I), 1, 80))
      Else
         rev = cmbClasif.List(I)
      End If
      If rev = Dato Then
         p = I
         Exit For
      End If
   Next
   cmbClasif.ListIndex = p

End Function

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Key
      Case "botBuscar":       Call Buscar
      Case "botLimpiar":      Call Limpiar
      Case "botGuardar":      Call FuncSavedata
      Case "botDelSegmento":  Call BorrarSegmento
      Case "botSalir":        Unload Me
   End Select
End Sub

Private Function Limpiar()
   If FRA_DETALLE.Enabled = False Then
      FRA_DETALLE.Enabled = True
   End If
   Grilla.Clear
   
   Call FuncSettingGrid
   
   If FRA_SEGMENTO.Enabled = False Then
      FRA_SEGMENTO.Enabled = True
   End If

   CmbSegmentoComercial.ListIndex = -1
   FRA_DETALLE.Enabled = False

End Function

Private Function BorrarSegmento()
   Dim actSegm    As Integer
   Dim msg        As String
   Dim sp         As String
   Dim res        As String
   Dim Datos()

   actSegm = CmbSegmentoComercial.ListIndex

   If actSegm = -1 Then
      MsgBox "No ha seleccionado un Segmento", vbInformation, TITSISTEMA
      Exit Function
   End If

   'Ver si hay datos en la grilla
   If Grilla.Rows = 1 Then
       MsgBox "No hay datos para eliminar!", vbExclamation, TITSISTEMA
       Exit Function
   End If

   If Grilla.Rows = 2 Then
      If FilaEstaVacia(1) Then
         MsgBox "No hay datos para eliminar!", vbExclamation, TITSISTEMA
         Exit Function
      End If
   End If

   Envia = Array()
  'msg = "Atención!" & vbCrLf & "Este proceso borrará todos los registros" & vbCrLf & "asociados al segmento seleccionado." & vbCrLf & "¿Confirma la eliminación?"
  'If MsgBox(msg, vbYesNo + vbQuestion, App.Title) <> vbYes Then
  
   If MsgBox("¿ Esta seguro que desea eliminar los registros expuestos para el segmento seleccionado ?", vbQuestion + vbYesNo, App.Title) = vbNo Then
      Exit Function
   End If

   AddParam Envia, actSegm
   If Not Bac_Sql_Execute("Bacparamsuda.dbo.SP_BORRASEGMENTOTABLASDEREDUCCION", Envia) Then
      MsgBox "Error! Se ha producido el siguiente error al intentar borrar el segmento:" & Err.Description, vbCritical, TITSISTEMA
      Exit Function
   End If
   Do While Bac_SQL_Fetch(Datos())
      res = Datos(1)
   Loop
   If res = "0" Then
      MsgBox "Los datos asociados al segmento han sido eliminados exitosamente!", vbInformation, TITSISTEMA
      Call Limpiar
   Else
      MsgBox "Se ha producido un error al intentar borrar los datos asociados al segmento seleccionado", vbExclamation, TITSISTEMA
   End If
End Function

Private Function Buscar()
   Dim Datos()
   Dim sp            As String
   Dim xSegmento     As String
   Dim vienen        As Integer
   Dim codSegmento   As Integer
   
   'Bloquear combo
   If CmbSegmentoComercial.ListIndex = -1 Then
      Exit Function
   End If
   
   'Traer datos a la grilla
   xSegmento = LTrim(Mid$(CmbSegmentoComercial.List(CmbSegmentoComercial.ListIndex), 100))
   If xSegmento = "" Then
      MsgBox "Error: El segmento seleccionado tiene un error en el código.  Verifique con el administrador!", vbCritical, TITSISTEMA
      Exit Function
   End If

   codSegmento = CInt(xSegmento)
   CmbSegmentoComercial.Tag = codSegmento
   
   Envia = Array()
   AddParam Envia, codSegmento
   If Not Bac_Sql_Execute("Bacparamsuda.dbo.SP_TRAETABLASDEREDUCCION", Envia) Then
      MsgBox "Se ha producido un error al cargar los datos de la Tabla de Reducción de Threshold!", vbCritical, TITSISTEMA
      Exit Function
   End If
   
   Screen.MousePointer = vbHourglass
   Grilla.Rows = 1
   Grilla.Redraw = False
   Do While Bac_SQL_Fetch(Datos())
      vienen = vienen + 1
      Grilla.Rows = Grilla.Rows + 1
      Grilla.TextMatrix(Grilla.Rows - 1, 0) = Datos(3)
      Grilla.TextMatrix(Grilla.Rows - 1, 1) = Datos(5)
      Grilla.TextMatrix(Grilla.Rows - 1, 2) = Format(Datos(6), FEntero)
      Grilla.TextMatrix(Grilla.Rows - 1, 3) = Format(Datos(7), FEntero)
      Grilla.TextMatrix(Grilla.Rows - 1, gNomInt) = Datos(2)
      Grilla.TextMatrix(Grilla.Rows - 1, gNomNac) = Datos(4)
   Loop
   Grilla.Redraw = True
   Screen.MousePointer = vbDefault

   If FRA_DETALLE.Enabled = False Then
      FRA_DETALLE.Enabled = True
   End If
  ' grilla.SetFocus
End Function

Private Function FuncSavedata()
   Dim nFila        As Long
   Dim nColumna     As Long
   Dim I            As Integer
   Dim n            As Integer
   Dim fallas       As Integer
   Dim Contador     As Integer
    
   fallas = 0
   n = Grilla.Rows

   If CmbSegmentoComercial.ListIndex < 0 Then
      Call MsgBox("No ha seleccionado un Segmento....", vbExclamation, App.Title)
      Exit Function
   End If
   If Grilla.Rows = Grilla.FixedRows Then
      Call MsgBox("No existen registros para grabar.", vbExclamation, App.Title)
      Exit Function
   End If
    
   For I = n - 1 To 2 Step -1
      If FilaEstaVacia(I) Then
         Grilla.RemoveItem (I)
      End If
   Next
   If Not BacBeginTransaction Then
      Call MsgBox("Se ha producido un error en la Grabación.", vbExclamation, App.Title)
      Exit Function
   End If

   Contador = 0

   If HayFilasIncompletas() Then
      MsgBox "Debe completar la información solicitada para proceder con la actualización.", vbExclamation, TITSISTEMA
      Grilla.SetFocus
      Exit Function
   End If
    
   For nFila = 1 To Grilla.Rows - 1

      If Not FilaEstaVacia(nFila) Then
         Contador = Contador + 1

         Envia = Array()
         AddParam Envia, Contador
         AddParam Envia, CmbSegmentoComercial.ItemData(CmbSegmentoComercial.ListIndex)
         AddParam Envia, CInt(Grilla.TextMatrix(nFila, 4))
         AddParam Envia, CInt(Grilla.TextMatrix(nFila, 5))
         AddParam Envia, CDbl(Grilla.TextMatrix(nFila, 2))
         AddParam Envia, CDbl(SinPuntos(Grilla.TextMatrix(nFila, 3)))
         If Not Bac_Sql_Execute("BacParamSuda.dbo.SP_GRABATABLASDEREDUCCION", Envia) Then
            Call BacRollBackTransaction
            Call MsgBox("Se ha producido un error en la Grabación.", vbExclamation, App.Title)
            Exit Function
         End If
      End If
   Next nFila
    
   Call BacCommitTransaction
    
   If Contador > 0 Then
      Call MsgBox("La información ha sido grabada en forma correcta.", vbInformation, App.Title)
   Else
      Call MsgBox("No hay datos para grabar.", vbInformation, App.Title)
   End If
   Call Limpiar
End Function

Private Function HayFilasIncompletas() As Boolean
   Dim n As Integer
   Dim I As Integer
   Dim j As Integer
   
   HayFilasIncompletas = False
   n = Grilla.Rows
   j = 0

   For I = 1 To n - 1
      If Grilla.TextMatrix(I, 0) = "" And Len(Grilla.TextMatrix(I, gNomInt)) = 0 Then
         HayFilasIncompletas = True
         Exit For
      End If
      If Grilla.TextMatrix(I, 1) = "" And Len(Grilla.TextMatrix(I, gNomNac)) = 0 Then
         HayFilasIncompletas = True
         Exit For
      End If
      If Grilla.TextMatrix(I, 2) = "" Then
         HayFilasIncompletas = True
         Exit For
      End If
      If Grilla.TextMatrix(I, 3) = "" Then
         HayFilasIncompletas = True
         Exit For
      End If
   Next
End Function

Private Sub txtCampo_KeyDown(KeyCode As Integer, Shift As Integer)
Select Case KeyCode
    Case vbKeyReturn
        Grilla.Enabled = True
        Toolbar1.Enabled = True
        FRA_SEGMENTO.Enabled = True
        Grilla.TextMatrix(Grilla.RowSel, Grilla.ColSel) = txtCampo.Text
        txtCampo.Visible = False
        txtCampo.Enabled = False
        Grilla.SetFocus
    Case vbKeyEscape
        Grilla.Enabled = True
        Toolbar1.Enabled = True
        FRA_SEGMENTO.Enabled = True
        txtCampo.Visible = False
        txtCampo.Enabled = False
        Grilla.SetFocus
End Select
End Sub
Private Function SinPuntos(ByVal Dato As String) As String
Dim salida As String
Dim car As String
salida = ""
SinPuntos = ""
Dim I As Integer
Dim n As Integer
n = Len(Dato)
For I = 1 To n
    car = Mid$(Dato, I, 1)
    If car <> "," And car <> "." Then
        salida = salida + car
    End If
Next
SinPuntos = salida
End Function

