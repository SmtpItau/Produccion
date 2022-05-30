VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "Msflxgrd.ocx"
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.3#0"; "COMCTL32.OCX"
Begin VB.Form BacConsultaOper 
   Appearance      =   0  'Flat
   BackColor       =   &H80000004&
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Mantención de Operaciones"
   ClientHeight    =   5715
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   14115
   BeginProperty Font 
      Name            =   "Times New Roman"
      Size            =   8.25
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   Icon            =   "BacConsultaOper.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   5715
   ScaleWidth      =   14115
   ShowInTaskbar   =   0   'False
   Begin ComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   3
      Top             =   0
      Width           =   14115
      _ExtentX        =   24897
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   327682
      BeginProperty Buttons {0713E452-850A-101B-AFC0-4210102A8DA7} 
         NumButtons      =   8
         BeginProperty Button1 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Key             =   ""
            Object.ToolTipText     =   "Filtrar"
            Object.Tag             =   ""
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Key             =   ""
            Object.ToolTipText     =   "Anular"
            Object.Tag             =   ""
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Key             =   ""
            Object.ToolTipText     =   "Modificar"
            Object.Tag             =   ""
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Key             =   ""
            Object.ToolTipText     =   "Imprimir Papeleta"
            Object.Tag             =   ""
            ImageIndex      =   4
         EndProperty
         BeginProperty Button5 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Key             =   ""
            Object.ToolTipText     =   "Aviso Próx. Vcto."
            Object.Tag             =   ""
            ImageIndex      =   5
         EndProperty
         BeginProperty Button6 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Key             =   "Coberturas"
            Object.ToolTipText     =   "Coberturas"
            Object.Tag             =   ""
            ImageIndex      =   7
         EndProperty
         BeginProperty Button7 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Key             =   ""
            Object.ToolTipText     =   "Papeletas"
            Object.Tag             =   ""
            ImageIndex      =   8
         EndProperty
         BeginProperty Button8 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Key             =   ""
            Object.ToolTipText     =   "Salir"
            Object.Tag             =   ""
            ImageIndex      =   6
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin VB.Frame Frame1 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   5220
      Index           =   0
      Left            =   15
      TabIndex        =   0
      Top             =   450
      Width           =   14085
      Begin MSFlexGridLib.MSFlexGrid grdConsulta 
         Height          =   4650
         Left            =   60
         TabIndex        =   1
         Top             =   495
         Width           =   13980
         _ExtentX        =   24659
         _ExtentY        =   8202
         _Version        =   393216
         Rows            =   15
         FixedCols       =   0
         BackColor       =   12632256
         BackColorFixed  =   8421440
         ForeColorFixed  =   16777215
         BackColorSel    =   8388608
         ForeColorSel    =   16777215
         GridColor       =   16777215
         FocusRect       =   0
         GridLines       =   2
         SelectionMode   =   1
      End
      Begin VB.Label Label1 
         Alignment       =   2  'Center
         BackColor       =   &H00800000&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "Consulta"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   11.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H0000FFFF&
         Height          =   345
         Left            =   60
         TabIndex        =   2
         Top             =   135
         Width           =   13965
      End
   End
   Begin ComctlLib.ImageList ImageList1 
      Left            =   9390
      Top             =   210
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   327682
      BeginProperty Images {0713E8C2-850A-101B-AFC0-4210102A8DA7} 
         NumListImages   =   8
         BeginProperty ListImage1 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "BacConsultaOper.frx":0442
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "BacConsultaOper.frx":075C
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "BacConsultaOper.frx":0A76
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "BacConsultaOper.frx":0D90
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "BacConsultaOper.frx":10AA
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "BacConsultaOper.frx":13C4
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "BacConsultaOper.frx":16DE
            Key             =   ""
         EndProperty
         BeginProperty ListImage8 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "BacConsultaOper.frx":1EF8
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "BacConsultaOper"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim NoEntrar   As Boolean
Dim FilaAnt    As Integer
Dim ColAct     As Integer

Function VerificaDia()
   Toolbar1.Buttons(3).Enabled = False
   If grdConsulta.Row <> 0 Then
      If grdConsulta.TextMatrix(grdConsulta.Row, 4) <> "" Then
         If CDate((grdConsulta.TextMatrix(grdConsulta.Row, 4))) = CDate((gsBAC_Fecp)) Then
            Toolbar1.Buttons.Item(2).Enabled = True
         Else  'MAP 20080520
          '  Se permitirá anular al otro día pero
          '  solo si es Cotización
             If grdConsulta.TextMatrix(grdConsulta.Row, 2) = "CARTERA" Then
                Toolbar1.Buttons.Item(2).Enabled = False
             Else
                Toolbar1.Buttons.Item(2).Enabled = True
             End If
         End If
         If CDate(grdConsulta.TextMatrix(grdConsulta.Row, 4)) = CDate(gsBAC_Fecp) Then
            Toolbar1.Buttons(3).Enabled = True
         End If
      End If
      If (grdConsulta.TextMatrix(grdConsulta.Row, 0)) = "TASA" Then
         Toolbar1.Buttons.Item(5).Enabled = True
      Else
         Toolbar1.Buttons.Item(5).Enabled = False
      End If
    End If
End Function

Function InicializaGrilla()
   Dim i As Integer

   grdConsulta.Cols = 21 'PROD-10967
   grdConsulta.Rows = 15
        
   grdConsulta.RowHeight(0) = 500
   grdConsulta.TextMatrix(0, 0) = "Tipo Producto"
   grdConsulta.TextMatrix(0, 1) = "N° Operación"
   grdConsulta.TextMatrix(0, 2) = "Tip.Operación"
   grdConsulta.TextMatrix(0, 3) = "Cliente"
   grdConsulta.TextMatrix(0, 4) = "Fecha Inicio"
   grdConsulta.TextMatrix(0, 5) = "Fecha Venc."
   grdConsulta.TextMatrix(0, 6) = "Moneda Operación"
   grdConsulta.TextMatrix(0, 7) = "Monto Operación"
   grdConsulta.TextMatrix(0, 8) = "Tasa Base"
   grdConsulta.TextMatrix(0, 9) = "Monto Conversión"
   grdConsulta.TextMatrix(0, 10) = "Tasa Conversión"
   grdConsulta.TextMatrix(0, 11) = "Modalidad"
   grdConsulta.TextMatrix(0, 15) = "Area Responsable"
   grdConsulta.TextMatrix(0, 16) = "Cartera Normativa"
   grdConsulta.TextMatrix(0, 17) = "SubCartera Normativa"
   grdConsulta.TextMatrix(0, 18) = "Libro"
   grdConsulta.TextMatrix(0, 19) = "Rut"    'PROD-10967
   grdConsulta.TextMatrix(0, 20) = "Codigo" 'PROD-10967

   
   grdConsulta.ColWidth(0) = 1200
   grdConsulta.ColWidth(1) = 1200
   grdConsulta.ColWidth(2) = 1200
   grdConsulta.ColWidth(3) = 3500
   grdConsulta.ColWidth(4) = 1000
   grdConsulta.ColWidth(5) = 1000
   grdConsulta.ColWidth(6) = 2500
   grdConsulta.ColWidth(7) = 1500
   grdConsulta.ColWidth(8) = 1000
   grdConsulta.ColWidth(9) = 1500
   grdConsulta.ColWidth(10) = 1500
   grdConsulta.ColWidth(11) = 1500
   grdConsulta.ColWidth(12) = 0
   grdConsulta.ColWidth(13) = 0
   grdConsulta.ColWidth(14) = 0
   grdConsulta.ColWidth(15) = 2500
   grdConsulta.ColWidth(16) = 2500
   grdConsulta.ColWidth(17) = 2500
   grdConsulta.ColWidth(18) = 2500
   grdConsulta.ColWidth(19) = 0 'PROD-10967
   grdConsulta.ColWidth(20) = 0 'PROD-10967
  
   grdConsulta.Row = 0
   
   For i = 0 To grdConsulta.Cols - 1
      grdConsulta.Col = i
      grdConsulta.CellAlignment = 4
   Next i
   grdConsulta.Tag = "NO"  'Grilla no tiene datos
End Function

Private Sub btnAnular_Click()
    Call AnulaOperacion
End Sub

Function AnulaOperacion()
Dim nAsociadas As Long
Dim lista As String

    'PROD-10967
    Dim RfRut As Long
    'prd19111 ini
    Dim RfRutdv As String
     Dim LeerDv As String
    'prd19111 fin
    Dim RfCodigo As Long
    Dim Rfmetodologia As Integer
    Dim RfThreshold As Double
    Dim LeerRut As Boolean
    Dim leerMet As New clsCliente
    Dim Det_MsgError As String
    Dim RfNombre As String
    Dim RfMontoOP As Double
    Dim RfNum As Integer
    Dim RfCodProducto As Integer
    Dim Mensaje As String
    'PROD-10967
    'prd19111 inicio
    Dim EstadoOperComder As String
    Dim CodMoneda As String
    Dim bRespuesta As Boolean
    Dim estado As Integer
    Dim MensajeComder As String
    Dim Anula As String
    
    Dim DVCliente As String
    'prd19111 fin

   If grdConsulta.TextMatrix(grdConsulta.Row, 1) = "" Then
      Exit Function
   End If
   If Not ChequeaCierreMesa() Then
      MsgBox "No se puede Anular Operacion, Mesa de Dinero está Cerrada!!!", vbExclamation, Msj
      Exit Function
   End If

   Dim Anulacion  As New clsMantencionSwap
   Dim Num        As Double
   
   'PROD-10967
    Let RfRut = 0
    Let RfCodigo = 0
    Let RfNombre = ""
    Let RfThreshold = 0
    Let Rfmetodologia = 0
    Let RfMontoOP = 0
    'PROD-10967
   
    'PROD-10967
    If grdConsulta.Row = 0 Then
       MsgBox ("Seleccionar Operacion")
       Exit Function
    End If

    
    Let RfRut = grdConsulta.TextMatrix(grdConsulta.Row, 19)
    Let RfCodigo = grdConsulta.TextMatrix(grdConsulta.Row, 20)
    Let RfNombre = grdConsulta.TextMatrix(grdConsulta.Row, 3)
    'prd19111 ini
    Let LeerDv = leerMet.LeerSQLDV(RfRut, RfCodigo, "", 0, 0, 0)
    Let RfRutdv = CStr(grdConsulta.TextMatrix(grdConsulta.Row, 19)) & LeerDv
    'Let RfRut = CStr(grdConsulta.TextMatrix(grdConsulta.Row, 19))
    'prd19111 fin
    Let LeerRut = leerMet.LeerSQL(RfRut, RfCodigo, "", 0, 0, 0)
    Let RfMontoOP = ((grdConsulta.TextMatrix(grdConsulta.Row, 7)) * -1)
    Let Rfmetodologia = leerMet.clMetodologia_LCR
    Let RfThreshold = leerMet.clThreshold
    'PROD-10967
   
    Select Case UCase(grdConsulta.TextMatrix(grdConsulta.Row, 0))
        Case "TASA"
            RfCodProducto = 1
        Case "MONEDA"
            RfCodProducto = 2
        Case "FRA"
            RfCodProducto = 3
        Case "PROMEDIO CAMARA"
            RfCodProducto = 4
    End Select
    'PROD-10967

   Num = grdConsulta.TextMatrix(grdConsulta.Row, 1)
   'Mostrar la cantidad y números de las garantías asociadas a la operación
   nAsociadas = GarantiasAsociadas(Num, lista)
   If nAsociadas > 0 Then
        MsgBox "La Operación tiene asociadas " & Trim(Str(nAsociadas)) & " Garantías Constituídas." & vbCrLf & lista & vbCrLf & vbCrLf & "(Al anular la operación se anulará la relación con las Garantías Asociadas)", vbInformation, "Garantías asociadas a la Operación N° " & Format(Num, "#,##0")
   End If
   
    If MsgBox("¿Desea Anular Operación número " & Num & "?", vbQuestion + vbYesNo, TITSISTEMA) = vbNo Then
      Exit Function
   End If

 'Cambios Artículo 84


        If (blnProcesoArt84Activo("PCS")) Then
        
             gblSW_MontoReserva = 0 'CONTROL IDD, jcamposd seteo variable en cero
             
             If Not blnValidaNormaArt84(Me.Tag, CDbl(Num), RfRut, RfCodigo) Then

             If glngNroTicketAnulacion > 0 Then
             Call GeneraConfirmacionProceso(glngNroTicketAnulacion, CDbl(Num), "PCS", gstrNrosOperacionesIBS)
             End If

        End If


        End If
       
   'Fin Cambios Artículo 84
   
   'PRD-4858, 25-02-2010
   Select Case UCase(grdConsulta.TextMatrix(grdConsulta.Row, 0))
        Case "TASA"
            Thr_CodProducto = 1
        Case "MONEDA"
            Thr_CodProducto = 2
        Case "FRA"
            Thr_CodProducto = 3
        Case "PROMEDIO CAMARA"
            Thr_CodProducto = 4
   End Select
   'fin PRD-4858
   
    Envia = Array()
    AddParam Envia, Num
    AddParam Envia, "PCS"
    If Not Bac_Sql_Execute("BDBOMESA.DBO.COMDER_EstadoOperacion", Envia) Then
        MsgBox ("Error busca estado operacion")
    End If
    
     
     'nAsociadas = GarantiasAsociadas(Num, lista)
     'If nAsociadas > 0 Then
     '    MsgBox "La Operación tiene asociadas " & Trim(Str(nAsociadas)) & " Garantías Constituídas." & vbCrLf & lista & vbCrLf & vbCrLf & "(Al anular la operación se anulará la relación con las Garantías Asociadas)", vbInformation, "Garantías asociadas a la Operación N° " & Format(Num, "#,##0")
     'End If
    
     If MsgBox("¿Está Seguro de eliminar la operación?", vbQuestion + vbYesNo, TITSISTEMA) = vbNo Then
        Exit Function
     End If
   
    
    If Bac_SQL_Fetch(Datos()) Then
        EstadoOperComder = Datos(3)
    End If
    Envia = Array()
    AddParam Envia, Num
    AddParam Envia, "PCS"
   If Not Bac_Sql_Execute("BDBOMESA.DBO.COMDER_EstadoOperacion", Envia) Then
       GoTo ErrorComder
    End If
    
    If Bac_SQL_Fetch(Datos()) Then
    If IsNull(Datos(1)) Then
       estado = 0
    Else
      estado = Datos(1)
    End If
    If IsNull(Datos(2)) Then
       MensajeComder = Datos(2)
    Else
       MensajeComder = Datos(2)
    End If
        'estado = Datos(1)
        'MensajeComder = Datos(2)
        Anula = Datos(3)
        
    End If

    
    'If UCase(EstadoOperComder) = "SI" Then
    '     MsgBox "La Operacion N°: " & Num & ", No es operacion ComDer" & vbCrLf & " Y tiene el siguiente estado : " & estado & "-->" & MensajeComder & vbCrLf & "Por lo que no puede seguir el proceso.", vbExclamation
        
      
    'End If
    
    
    '--> Valida si es operacion Comder
    If UCase(EstadoOperComder) = "SI" And estado = 3 Then
       If MsgBox("La Operacion N°: " & Num & ",   es operacion ComDer" & vbCrLf & " Y tiene el siguiente estado : " & estado & "-->" & vbCrLf & vbCrLf & "¿Esta seguro de enviar Solicitud de Anulación a ComDer?", vbQuestion + vbYesNo, TITSISTEMA) = vbNo Then
            
            Exit Function
        End If
        Envia = Array()
        AddParam Envia, Num '--> Numero Operacion
        AddParam Envia, "PCS"
        AddParam Envia, Thr_CodProducto
        AddParam Envia, "C"
        
      '  AddParam Envia, grdConsulta.TextMatrix(grdConsulta.Row, 6)
        
        
        Select Case grdConsulta.TextMatrix(grdConsulta.Row, 6)
        Case "DOLAR USA":            CodMoneda = "USD"
        Case "YEN JAPONES":          CodMoneda = "JPY"
        Case "UF":                   CodMoneda = "UF"
        Case "PESOS":                CodMoneda = "CLP"
        Case "CORONA DANESA":        CodMoneda = "DKK"
        Case "CORONA NORUEGA":       CodMoneda = "NOK"
        Case "CORONA SUECA":         CodMoneda = "SEK"
        Case "DOLAR ACUERDO":        CodMoneda = "DA"
        Case "DOLAR AUSTRALIA":      CodMoneda = "AUD"
        Case "DOLAR CANADIENSE":     CodMoneda = "CAD"
        Case "EURO":                 CodMoneda = "EUR"
        Case "FRANCO SUIZO":         CodMoneda = "CHF"
        Case "FRANCOS BELGAS":       CodMoneda = "BEM"
        Case "LIBRA ESTERLINA":      CodMoneda = "GBP"
        Case "MARCO ALEMAN":         CodMoneda = "DEM"
        Case "NUEVO PESO MEXICANO":  CodMoneda = "MXN"
        Case "NUEVO SOL PERUANO":    CodMoneda = "PEN"
        Case "PESO COLOMBIANO":      CodMoneda = "COP"
        Case "SHILLING AUSTRI":      CodMoneda = "ATS"
        Case "UNIDAD DE FOMENTO":    CodMoneda = "UF"
        Case "YUAN REMINBI":         CodMoneda = "CNY"
        Case Else: CodMoneda = " "
        End Select
        
        
        AddParam Envia, CodMoneda
        
        AddParam Envia, CDec(grdConsulta.TextMatrix(grdConsulta.Row, 9))
        
        AddParam Envia, Date
        AddParam Envia, Date
        AddParam Envia, RfRutdv
        AddParam Envia, grdConsulta.TextMatrix(grdConsulta.Row, 20)
       
        AddParam Envia, "A"
        
         
        If Not Bac_Sql_Execute("BDBOMESA.DBO.COMDER_InsertaSolicitud", Envia) Then
            bRespuesta = Bac_Sql_Execute("ROLLBACK TRAN")
            Screen.MousePointer = vbDefault
            MsgBox "Ha ocurrido un error al intentar enviar la información al MonitorComDer", vbCritical
            Exit Function
        End If
        
        bRespuesta = Bac_Sql_Execute("COMMIT TRAN")
        Exit Function
   Else
        If estado > 3 Then
            MsgBox ("Operacion ya fue anulada")
            Exit Function
        Else
           If UCase(EstadoOperComder) = "NO" And estado = 0 Then
              MsgBox ("Falta aprobar operacion en Control Financiero")
              Exit Function
           End If
        End If
   End If
     
     
   Anulacion.NumOperacion = Num
   Anulacion.MetodologiaLCRCliente = Rfmetodologia 'PROD-10967
   Anulacion.TipoOperacion = Thr_CodProducto
   If Anulacion.AnularDatos Then
      'Actualiza Coberturas Asociadas
      Envia = Array()
      AddParam Envia, "PCS"
      AddParam Envia, CDbl(Num)
      AddParam Envia, CDbl(1#)
      Call Bac_Sql_Execute("BACTRADERSUDA..SP_ACTUALIZACION_POSTVENTA", Envia)
      'Actualiza Coberturas Asociadas
         
      'Elimina fila de Grilla
      grdConsulta.RemoveItem grdConsulta.Row
      grdConsulta.Rows = grdConsulta.Rows + 1
      
      'PRD-4858, 25-02-2010
      
      Thr_NumeroOperacion = CDbl(Num)
      Call BorrarOpThreshold
      'fin PRD-4858
      
      'Borrar Operación del Control de Precios y Tasas
      Envia = Array()
      AddParam Envia, "PCS"
      AddParam Envia, IIf(Thr_CodProducto = 1, "ST", "SM")
      AddParam Envia, CDbl(Num)
      If Bac_Sql_Execute("BACPARAMSUDA..SP_BORRA_OPPENDIENTEPRECIOS", Envia) Then
            Do While Bac_SQL_Fetch(Datos())
                            
            Loop
      End If
      
      'PRD-5521, Eliminar las garantías relacionadas con la operación
      If nAsociadas > 0 Then
            Call EliminaGarantiasAsociadas(Num)
      End If
      'fin PRD-5521
      
        
        '--+++CONTROL IDD, jcamposd se revisa proceso y no entra en este IF por metodologia
        'PROD-10967
        If Not (Rfmetodologia = 1 Or Rfmetodologia = 4) Then
            Dim FwdCarteraREC As Negociacion
            Dim ResultadoREC As Double
            Let ResultadoREC = 0
            
            Let RfNum = 0
            
            Let ResultadoREC = ProcesoCalculoREC(RfRut, RfCodigo, RfNombre _
                                                                , FwdCarteraREC _
                                                                , "Forward" _
                                                                , RfThreshold _
                                                                , Rfmetodologia _
                                                                , Det_MsgError, RfNum)
                                                                                                                                                                     
            
            If Not (BacBeginTransaction()) Then
                MsgBox ("No Genera Trasaccion para actualizar LCR DRV")
            Else
                'OJO: Se puso en duro el  parametro tipo de cambio
                If Not Lineas_ChequearGrabar("PCS", CDbl(RfCodProducto), CDbl(Num) _
                                                  , CDbl(Num), 0, CDbl(RfRut), CDbl(RfCodigo) _
                                                  , CDbl(RfMontoOP), 34#, 0, 0 _
                                                  , 0, CDate(gsBAC_Fecp), 0, "N", Val(13) _
                                                  , "C", 0, "N", 0, CDate(gsBAC_Fecp), 0 _
                                                  , Val(0), ResultadoREC, Rfmetodologia) Then 'PROD-10967
                   Call BacRollBackTransaction
                   MsgBox "Problemas en Procedimientos"
                   Exit Function
                End If
            
            
                Mensaje = Mensaje & Lineas_Chequear("PCS", CDbl(RfCodProducto), 1, " ", " ", " ")
            
                If Mensaje <> "" Then
                    MsgBox "Error al Chequear Lineas : " + Chr(10) + Chr(13) + Chr(10) + Chr(13) + Mensaje, vbCritical
                    Call BacRollBackTransaction
                    Exit Function
                End If
            
            
                If Not Lineas_GrbOperacion("PCS", CDbl(RfCodProducto), CDbl(Num), CDbl(Num), " ", "N", "L") Then
                    If Not Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
                       MsgBox "Error en la grabación" & vbCrLf & "Imposible generar transacciones.", vbExclamation, TITSISTEMA
                       Exit Function
                    End If
                End If
            
                Call BacCommitTransaction
            
            End If
        End If
        'PROD-10967
    
      MsgBox " Operación número " & Num & " Anulada!", vbInformation, TITSISTEMA
   Else
      MsgBox " Error!,  no se pudo Anular Operación número " & Num, vbInformation, TITSISTEMA
   End If
   Set Anulacion = Nothing
   
ErrorComder:
   On Error GoTo 0
   Exit Function
End Function

Private Function EliminaGarantiasAsociadas(ByVal numero As Double) As Boolean
Envia = Array()
Dim nomSp As String

    nomSp = "BACPARAMSUDA..SP_ELIMINA_RELACION_OPERGTIA"
    AddParam Envia, "PCS"
    AddParam Envia, numero
    If Not Bac_Sql_Execute(nomSp, Envia) Then
        EliminaGarantiasAsociadas = False
        Exit Function
    End If
    EliminaGarantiasAsociadas = True
End Function

Private Function GarantiasAsociadas(ByVal numero As Double, ByRef lista As String) As Long
Dim X        As Long
    X = 0
Dim Datos()
Envia = Array()
Dim nomSp    As String
Dim Y        As Long

    nomSp = "BACPARAMSUDA..SP_GARANTIAS_ASOCIADAS_OPERACION"
    AddParam Envia, "PCS"
    AddParam Envia, numero
    If Not Bac_Sql_Execute(nomSp, Envia) Then
        lista = ""
        GarantiasAsociadas = 0
        Exit Function
    End If
    Do While Bac_SQL_Fetch(Datos())
        X = CLng(Datos(1))
        If X > 0 Then
            lista = Trim(Datos(2))
        Else
            lista = ""
        End If
        Exit Do
    Loop
    If X > 0 Then
        lista = Replace(lista, "-", ",")
    End If
    If Len(lista) < 80 Then
        Y = Int((80 - Len(lista)) / 2)
        lista = Space(Y) & lista & Space(Y)
    End If
    GarantiasAsociadas = X
End Function

Private Sub btnAviso_Click()
   On Error GoTo Control
   Dim cCristal      As New clsCristal
   Dim NumOperacion  As Double

   Call BacLimpiaParamCrw

   If grdConsulta.TextMatrix(grdConsulta.Row, 1) <> "" And grdConsulta.Row > 0 Then
      NumOperacion = grdConsulta.TextMatrix(grdConsulta.Row, 1)
   Else
      Exit Sub
   End If
   BACSwap.Crystal.ReportFileName = gsRPT_Path & "BacAvisoVencimiento.rpt"
   BACSwap.Crystal.WindowTitle = "Aviso Vencimiento Flujo"
   BACSwap.Crystal.Destination = crptToWindow
   BACSwap.Crystal.StoredProcParam(0) = NumOperacion
   BACSwap.Crystal.Connect = swConeccion
   BACSwap.Crystal.Action = 1
Exit Sub
Control:
   MsgBox BACSwap.Crystal.LastErrorString, vbCritical, TITSISTEMA
End Sub

Private Sub btnFiltrar_Click()
   Call BacFiltrarConsulta.Show
End Sub

Private Sub btnModificar_Click()
    
 Dim EstadoOperComder As String
    
    'CER 18/04/2008  - Req. Pantalla Ingreso Op. Swap
    'Este desarrollo se ralizará en 2° Etapa.
    'prd 19111 ini
    MsgBox "Modificación se realizará," & vbCrLf & vbCrLf & "en segunda Etapa.", vbExclamation, TITSISTEMA
    Exit Sub
   'prd 19111 fin
   If grdConsulta.TextMatrix(grdConsulta.Row, 1) = "" Or grdConsulta.Row = 0 Then
      Exit Sub
   End If
   'traspaso de dato a variable global para modificacion de operacion
   swModNumOpe = grdConsulta.TextMatrix(grdConsulta.Row, 1)
   
   'prd19111 ini
   
    Envia = Array()
    AddParam Envia, swModNumOpe
    AddParam Envia, "PCS"
    If Not Bac_Sql_Execute("BDBOMESA.DBO.COMDER_EstadoOperacion", Envia) Then
        MsgBox ("Error busca estado operacion")
    End If
    
    If Bac_SQL_Fetch(Datos()) Then
           If IsNull(Datos(3)) = True Then
              EstadoOperComder = 0
           Else
              EstadoOperComder = Datos(3)
           End If
    End If
    
    '--> Valida si es operacion Comder
    If UCase(EstadoOperComder) = "NO" Then
            MsgBox "Operación ComDer No puede ser modificada.", vbExclamation, "CONSULTA"
           Exit Sub
    End If
    
    
   'prd19111 fin
   
   
   
   Select Case swModTipoOpe
      Case 1:  swOperSwap = "Modificacion"
      Case 3:  swOperSwap = "ModificacionCartera"
   End Select
   BacConsultaOper.Hide 'Ocultar Formulario de consulta

   If UCase((grdConsulta.TextMatrix(grdConsulta.Row, 0))) = "TASA" Then
      FRM_SWAP_OP.SwapModificacion = swModNumOpe
      FRM_SWAP_OP.Show
     ' Tipo_Producto = "ST"
     ' BacOpeSwapTasaULT.Caption = "Swap de Tasas"
     ' BacOpeSwapTasaULT.Show
   ElseIf UCase((grdConsulta.TextMatrix(grdConsulta.Row, 0))) = "MONEDA" Then
      FRM_SWAP_OP.SwapModificacion = swModNumOpe
      FRM_SWAP_OP.Show
     
     ' Tipo_Producto = "SM"
     ' BacOpeSwapMonedaULT.Caption = "Swap de Monedas"
     ' BacOpeSwapMonedaULT.Show
   ElseIf (grdConsulta.TextMatrix(grdConsulta.Row, 0)) = "FRA" Then
      FRM_SWAP_OP_FRA.SwapModificacion = swModNumOpe
      FRM_SWAP_OP_FRA.Show

     ' BacIrfNueVentana "FRANA"
   ElseIf (grdConsulta.TextMatrix(grdConsulta.Row, 0)) = "PROMEDIO CAMARA" Then
      FRM_SWAP_OP.SwapModificacion = swModNumOpe
      FRM_SWAP_OP.Show
     
     ' Tipo_Producto = "SP"
     ' MiTipoSwapTasa = [Swap Promedio Camara]
     ' BacOpeSwapTasaULT.Caption = "Swap Promedio Camara"
     ' BacOpeSwapTasaULT.Show
   End If

End Sub

Private Sub unwind_Click()
   Dim Cual          As Integer
   Dim m             As Long
   Dim NumOperacion  As Double
   Dim iTipoSwap     As Integer
   
   Screen.MousePointer = 11
   
   Select Case UCase(grdConsulta.TextMatrix(grdConsulta.Row, 0))
      Case "TASA":            Cual = 1
      Case "MONEDA":          Cual = 2
      Case "PROMEDIO CAMARA": Cual = 4
      Case Else:              Cual = 3
   End Select

   iTipoSwap = Cual
   If grdConsulta.Row = 0 Then
        Screen.MousePointer = 0
        Exit Sub
   End If
   NumOperacion = CDbl(grdConsulta.TextMatrix(grdConsulta.Row, 1))

   If grdConsulta.TextMatrix(grdConsulta.Row, 1) <> "" And IsNumeric(grdConsulta.TextMatrix(grdConsulta.Row, 1)) Then
      Call GeneraNuevasPapeletas(NumOperacion, iTipoSwap, "S")
   Else
      MsgBox "Debe selecionar Operación para Imprimir Papeleta", vbInformation, Msj
   End If

   Screen.MousePointer = 0
End Sub

Private Sub btnPapeleta_Click()
   Dim Cual          As Integer
   Dim m             As Long
   Dim NumOperacion  As Double
   Dim iTipoSwap     As Integer
   
   Screen.MousePointer = 11
   
   Select Case UCase(grdConsulta.TextMatrix(grdConsulta.Row, 0))
      Case "TASA":            Cual = 1
      Case "MONEDA":          Cual = 2
      Case "PROMEDIO CAMARA": Cual = 4
      Case Else:              Cual = 3
   End Select

   iTipoSwap = Cual
   NumOperacion = CDbl(grdConsulta.TextMatrix(grdConsulta.Row, 1))

   If grdConsulta.TextMatrix(grdConsulta.Row, 1) <> "" And IsNumeric(grdConsulta.TextMatrix(grdConsulta.Row, 1)) Then
      Call GeneraNuevasPapeletas(NumOperacion, iTipoSwap)
   Else
      MsgBox "Debe selecionar Operación para Imprimir Papeleta", vbInformation, Msj
   End If

   Screen.MousePointer = 0
End Sub

Private Sub GeneraNuevasPapeletas(NumOpeer As Double, TiposSwap As Integer, Optional ESUnwind As String = "N")
   On Error GoTo PrinterError
   Dim cPapeleta As String
   
   cPapeleta = "PAPELETA_SWAP.RPT"     ' --> Store Procedure : "dbo.SP_PAPELETA_SWAP"
   
   If TiposSwap = 3 Then
      cPapeleta = "PAPELETA_FRA.RPT"   ' --> Store Procedure : "dbo.SP_PAPELETA_SWAP"
   End If
   
   Call BacLimpiaParamCrw
   
   BACSwap.Crystal.ReportTitle = "Papeleta de Derivados Swap."
   BACSwap.Crystal.ReportFileName = gsRPT_Path & cPapeleta
   BACSwap.Crystal.WindowTitle = "Papeleta Swap de Tasas"
   BACSwap.Crystal.StoredProcParam(0) = Val(NumOpeer)
   BACSwap.Crystal.StoredProcParam(1) = Trim(gsBAC_User)
   'BACSwap.Crystal.StoredProcParam(2) = ESUnwind
   BACSwap.Crystal.Destination = crptToWindow
   BACSwap.Crystal.Connect = swConeccion
   BACSwap.Crystal.Action = 1
   Call BacLimpiaParamCrw
   If ESUnwind = "N" Then
        '-- MAP 20080415 Imprime Detalle de Valorizacion
        If MsgBox("¿ Imprime Detalle Valorizacion ?", vbQuestion + vbYesNo, TITSISTEMA) = vbNo Then
           On Error GoTo 0
        Else
           BACSwap.Crystal.ReportTitle = "Valorizacion Swap."
           BACSwap.Crystal.ReportFileName = gsRPT_Path & "VALORIZACION_SWAP.rpt"
           BACSwap.Crystal.WindowTitle = "Valorizacion Swap"
           BACSwap.Crystal.StoredProcParam(0) = "PARAM_01"
           BACSwap.Crystal.StoredProcParam(1) = Val(NumOpeer)
           BACSwap.Crystal.Destination = crptToWindow
           BACSwap.Crystal.Connect = swConeccion
           BACSwap.Crystal.Action = 1
        End If
   End If
   On Error GoTo 0
Exit Sub
PrinterError:
   MsgBox "Se ha producido un error al imprimir papeleta" & vbCrLf & BACSwap.Crystal.LastErrorString, vbExclamation, TITSISTEMA
   On Error GoTo 0
End Sub

Private Sub btnSalir_Click()
    Unload Me
   ' Unload (BacConsultaOper)
End Sub

Private Sub Form_Activate()
   If grdConsulta.Tag = "NO" Then
      Call EstadoBtn(False)
      Call EstadoToolBar(False)
   Else
      Call EstadoBtns
      Call EstadoToolBars
   End If
End Sub

Function EstadoBtn(estado)
End Function

Function EstadoToolBar(estado)
   Toolbar1.Buttons.Item(2).Enabled = estado
   Toolbar1.Buttons.Item(3).Enabled = estado
   Toolbar1.Buttons.Item(4).Enabled = estado
   Toolbar1.Buttons.Item(5).Enabled = estado
End Function

Function EstadoBtns()
   Select Case swModTipoOpe 'TipoOperacion
      Case 0
         Call EstadoBtn(False)
      Case 1
         Call EstadoBtn(True)
      Case 2
         Toolbar1.Buttons.Item(2).Enabled = False
         Toolbar1.Buttons.Item(3).Enabled = False
         Toolbar1.Buttons.Item(5).Enabled = False
      Case 3
         Toolbar1.Buttons.Item(2).Enabled = False
         Toolbar1.Buttons.Item(3).Enabled = True
         Toolbar1.Buttons.Item(5).Enabled = True
      Case 4
         Toolbar1.Buttons.Item(2).Enabled = False
         Toolbar1.Buttons.Item(3).Enabled = False
         Toolbar1.Buttons.Item(5).Enabled = False
   End Select
End Function

Function EstadoToolBars()
   Toolbar1.Buttons.Item(5).Enabled = True
   Select Case swModTipoOpe
      Case 0
         Call EstadoToolBar(False)
      Case 1
         Call EstadoToolBar(True)
      Case 2
         Toolbar1.Buttons.Item(2).Enabled = False
         Toolbar1.Buttons.Item(3).Enabled = False
         Toolbar1.Buttons.Item(5).Enabled = False
      Case 3
         Toolbar1.Buttons.Item(2).Enabled = False
         Toolbar1.Buttons.Item(3).Enabled = True
         Toolbar1.Buttons.Item(4).Enabled = True
         Toolbar1.Buttons.Item(5).Enabled = True
      Case 4
         Toolbar1.Buttons.Item(2).Enabled = False
         Toolbar1.Buttons.Item(3).Enabled = False
         Toolbar1.Buttons.Item(5).Enabled = False
   End Select
End Function

Private Sub Form_Load()
   Me.Icon = BACSwap.Icon
   
   'PRD-5149, jbh, 12-01-2010, para evitar "paseo" del form por la pantalla
   Me.Top = 0
   Me.Left = 0
   
   Call InicializaGrilla
End Sub

Private Sub grdConsulta_EnterCell()
   Call VerificaDia
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As ComctlLib.Button)
   Select Case Button.Index
      Case 1
         BacFiltrarConsulta.Show
      Case 2
         Call AnulaOperacion
      Case 3
         Call btnModificar_Click
      Case 4
         Call btnPapeleta_Click
      Case 5
         Call btnAviso_Click
      Case 6
         Call Coberturas
      Case 7
         Call unwind_Click
      Case 8
         Call btnSalir_Click
   End Select
End Sub

Private Sub Coberturas()
   If grdConsulta.TextMatrix(grdConsulta.RowSel, 1) = "" Or grdConsulta.RowSel = 0 Then
      MsgBox "Acción Cancelada." & vbCrLf & vbCrLf & "No existen operaciones para asignar cobertura.", vbExclamation, TITSISTEMA
      Exit Sub
   End If
   If UCase(grdConsulta.TextMatrix(grdConsulta.RowSel, 16)) = UCase("Cobertura") Then
      FRM_MNT_COBERTURA.Derivado = CDbl(grdConsulta.TextMatrix(grdConsulta.RowSel, 1))
      FRM_MNT_COBERTURA.Correlativo = 1
      FRM_MNT_COBERTURA.Modulo = "PCS"
      FRM_MNT_COBERTURA.Show 1
   Else
      MsgBox "Acción Cancelada." & vbCrLf & vbCrLf & "Operación seleccionada no es de Cobertura.", vbExclamation, TITSISTEMA
   End If
End Sub

Private Function blnValidaNormaArt84(strTag As String, lngNumeroOpe As Long, lngRut As Long, lngCodCliente As Long) As Boolean
Dim blnResult As Boolean
blnResult = True


Call GeneraArchivoAnulacion(lngNumeroOpe, lngRut, lngCodCliente)

blnValidaNormaArt84 = gblnProcesoExitoso
End Function

