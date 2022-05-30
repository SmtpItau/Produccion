VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.3#0"; "COMCTL32.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form Frm_Reimprime_Contratos 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Reimpresion de nuevos contratos derivados"
   ClientHeight    =   6075
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   8595
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   6075
   ScaleWidth      =   8595
   Begin ComctlLib.Toolbar Tbl_Opciones 
      Height          =   510
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   8655
      _ExtentX        =   15266
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   327682
      BeginProperty Buttons {0713E452-850A-101B-AFC0-4210102A8DA7} 
         NumButtons      =   2
         BeginProperty Button1 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Key             =   ""
            Object.ToolTipText     =   "Imprimir"
            Object.Tag             =   ""
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Key             =   ""
            Object.ToolTipText     =   "Salir"
            Object.Tag             =   ""
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin VB.Frame Fr_Datos 
      Caption         =   "Contratos Impresos"
      Height          =   4065
      Left            =   60
      TabIndex        =   1
      Top             =   1965
      Width           =   8475
      Begin MSFlexGridLib.MSFlexGrid Grd_Datos 
         Height          =   3720
         Left            =   75
         TabIndex        =   3
         Top             =   225
         Width           =   8295
         _ExtentX        =   14631
         _ExtentY        =   6562
         _Version        =   393216
      End
   End
   Begin VB.Frame Fr_OpcBusqueda 
      Caption         =   "Opciones de busqueda"
      Height          =   1410
      Left            =   60
      TabIndex        =   2
      Top             =   540
      Width           =   8475
      Begin VB.Frame Fr_Cliente 
         Height          =   765
         Left            =   2175
         TabIndex        =   7
         Top             =   495
         Width           =   6120
         Begin VB.TextBox Txt_Cliente 
            Height          =   300
            Left            =   105
            TabIndex        =   9
            Top             =   285
            Width           =   5880
         End
      End
      Begin VB.Frame Fr_Fecha 
         Height          =   765
         Left            =   120
         TabIndex        =   6
         Top             =   495
         Width           =   1935
         Begin BACControles.TXTFecha Txt_Fecha 
            Height          =   300
            Left            =   300
            TabIndex        =   8
            Top             =   285
            Width           =   1305
            _ExtentX        =   2302
            _ExtentY        =   529
            Enabled         =   -1  'True
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
            MaxDate         =   2958465
            MinDate         =   -328716
            Text            =   "28/12/2009"
         End
      End
      Begin VB.OptionButton Opt_Opcion 
         Caption         =   "Cliente"
         Height          =   225
         Index           =   1
         Left            =   2175
         TabIndex        =   5
         Top             =   270
         Width           =   870
      End
      Begin VB.OptionButton Opt_Opcion 
         Caption         =   "Fecha"
         Height          =   225
         Index           =   0
         Left            =   120
         TabIndex        =   4
         Top             =   270
         Width           =   825
      End
   End
   Begin ComctlLib.ImageList ImageList1 
      Left            =   8115
      Top             =   405
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   8421504
      _Version        =   327682
      BeginProperty Images {0713E8C2-850A-101B-AFC0-4210102A8DA7} 
         NumListImages   =   2
         BeginProperty ListImage1 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "Frm_Reimprime_Contratos.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "Frm_Reimprime_Contratos.frx":031A
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "Frm_Reimprime_Contratos"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Dim DatosContrato(33)
Dim DATOS()

Dim nRutBco       As Long
Dim nCodigoBco    As Integer
Dim cNombreBco    As String
Dim cDireccionBco As String
Dim cCiudadBco    As String
Dim cComunaBco    As String

Enum Columnas
   ncolfecha = 0
   ncoltipo = 1
   ncolOperacion = 2
   ncolRutCliente = 3
   ncolCodigoCliente = 4
   ncolNombreCliente = 5
   ncolRutApoderadoBco1 = 6
   ncolRutApoderadoBco2 = 7
   ncolRutApoderadoCli1 = 8
   ncolRutApoderadoCli2 = 9
   ncolCantidadAvales = 10
End Enum

Const btn_Imprimir = 1
Const btn_Salir = 2




Private Function Func_Busca_Apoderado_X_Rut(nRutCli As Long, nCodigoCli As Integer, nRutApoderado As Long) As String

   Func_Busca_Apoderado_X_Rut = ""

   Envia = Array()
   AddParam Envia, CDbl(nRutCli)
   AddParam Envia, CDbl(nCodigoCli)
   
   If Not Bac_Sql_Execute("SP_MDAPLEERRUT", Envia) Then
       Exit Function
   End If
   
   Do While Bac_SQL_Fetch(DATOS())
      If DATOS(1) = CStr(nRutApoderado) Then
         Func_Busca_Apoderado_X_Rut = Trim(UCase(DATOS(3)))
         Exit Do
      End If
   Loop

End Function


Sub Proc_Busca_Datos(nRutCliente As Long, nCodigoCliente As Integer, cFechaImpresion As String)

   Envia = Array()
   AddParam Envia, nRutCliente
   AddParam Envia, nCodigoCliente
   AddParam Envia, Mid(cFechaImpresion, 7, 4) & Mid(cFechaImpresion, 4, 2) & Mid(cFechaImpresion, 1, 2)
   
   If Not Bac_Sql_Execute("SP_CON_CONTRATO_IMPRESO_FILTRO", Envia) Then
      Screen.MousePointer = vbDefault
      MsgBox "Ha ocurrido un error al intenter consultar los contratos ya emitidos", vbCritical + vbOKOnly
      Exit Sub
   End If
   
   Grd_Datos.Rows = 1
   Grd_Datos.Cols = 11
             
   If Bac_SQL_Fetch(DATOS()) Then
      With Grd_Datos
         .Rows = .Rows + 1
         .TextMatrix(.Rows - 1, Columnas.ncolfecha) = Mid(DATOS(4), 7, 2) & "/" & Mid(DATOS(4), 5, 2) & "/" & Mid(DATOS(4), 1, 4)
         .TextMatrix(.Rows - 1, Columnas.ncoltipo) = IIf(DATOS(3) = 0, "CONDICIONES GENERALES", "CONTRATOS ESPECIFICOS")
         .TextMatrix(.Rows - 1, Columnas.ncolOperacion) = DATOS(3)
         .TextMatrix(.Rows - 1, Columnas.ncolRutCliente) = Format(DATOS(1), "#,###") & "-" & DATOS(7)
         .TextMatrix(.Rows - 1, Columnas.ncolCodigoCliente) = DATOS(2)
         .TextMatrix(.Rows - 1, Columnas.ncolNombreCliente) = Trim(DATOS(6))
         .TextMatrix(.Rows - 1, Columnas.ncolRutApoderadoBco1) = Trim(DATOS(8))
         .TextMatrix(.Rows - 1, Columnas.ncolRutApoderadoBco2) = Trim(DATOS(9))
         .TextMatrix(.Rows - 1, Columnas.ncolRutApoderadoCli1) = Trim(DATOS(10))
         .TextMatrix(.Rows - 1, Columnas.ncolRutApoderadoCli2) = Trim(DATOS(11))
         .TextMatrix(.Rows - 1, Columnas.ncolCantidadAvales) = Trim(DATOS(12))
      End With
   End If


End Sub


Sub Proc_Imprimir()

   Dim cCodigoFisico       As String
   Dim cCodigoClausula     As String
   Dim nContador1          As Long
   Dim ncontador2          As Long
   Dim nContador3          As Long
   Dim nContador4          As Long
   Dim cuenta              As Integer
   Dim cConceptoImrpresion As String
   Dim nNumoper            As Long
   Dim cRutCliente         As String
   Dim ClienteOp           As Long
   Dim ClienteCod          As Integer
   Dim Cliente             As New clsCliente
   
   If Grd_Datos.Row < 1 Then
      Exit Sub
   End If

   If MsgBox("Esta Seguro de Imprimir el contrato seleccionado", vbQuestion + vbYesNo) = vbYes Then
   
      Screen.MousePointer = vbHourglass
      
      cConceptoImrpresion = IIf(Grd_Datos.TextMatrix(Grd_Datos.Row, Columnas.ncolOperacion) = 0, cConceptoCG, cConceptoCE)
      
      cRutCliente = Mid(Grd_Datos.TextMatrix(Grd_Datos.Row, Columnas.ncolRutCliente), 1, Len(Grd_Datos.TextMatrix(Grd_Datos.Row, Columnas.ncolRutCliente)) - 2)
      cRutCliente = Replace(Replace(cRutCliente, ",", ""), ".", "")
      ClienteOp = CLng(cRutCliente)
      ClienteCod = Grd_Datos.TextMatrix(Grd_Datos.Row, Columnas.ncolCodigoCliente)
      nNumoper = Grd_Datos.TextMatrix(Grd_Datos.Row, Columnas.ncolOperacion)
      
      If Not Cliente.LeerxRut(Val(gsCodigo), Val(gsCodCli)) Then
         MsgBox "No se pudo capturar datos de Cliente solicitado", vbCritical, Msj
      End If
      
      Erase ArregloDatosBasicos
      
      ArregloDatosBasicos(ColsDatosBasicos.ApoderadoBco1) = Func_Busca_Apoderado_X_Rut(nRutBco, nCodigoBco, Grd_Datos.TextMatrix(Grd_Datos.Row, Columnas.ncolRutApoderadoBco1))
      ArregloDatosBasicos(ColsDatosBasicos.RutApoderadoBco1) = Grd_Datos.TextMatrix(Grd_Datos.Row, Columnas.ncolRutApoderadoBco1)
      ArregloDatosBasicos(ColsDatosBasicos.ApoderadoBco2) = Func_Busca_Apoderado_X_Rut(nRutBco, nCodigoBco, Grd_Datos.TextMatrix(Grd_Datos.Row, Columnas.ncolRutApoderadoBco2))
      ArregloDatosBasicos(ColsDatosBasicos.RutApoderadoBco2) = Grd_Datos.TextMatrix(Grd_Datos.Row, Columnas.ncolRutApoderadoBco2)
      ArregloDatosBasicos(ColsDatosBasicos.NombreCli) = Grd_Datos.TextMatrix(Grd_Datos.Row, Columnas.ncolNombreCliente)
      ArregloDatosBasicos(ColsDatosBasicos.RutCli) = Trim(Strings.Split(Grd_Datos.TextMatrix(Grd_Datos.Row, Columnas.ncolRutCliente), "-")(0))
      ArregloDatosBasicos(ColsDatosBasicos.ApoderadoCli1) = Func_Busca_Apoderado_X_Rut(ClienteOp, ClienteCod, Grd_Datos.TextMatrix(Grd_Datos.Row, Columnas.ncolRutApoderadoCli1))
      ArregloDatosBasicos(ColsDatosBasicos.RutApoderadoCli1) = Grd_Datos.TextMatrix(Grd_Datos.Row, Columnas.ncolRutApoderadoCli1)
      ArregloDatosBasicos(ColsDatosBasicos.ApoderadoCli2) = Func_Busca_Apoderado_X_Rut(ClienteOp, ClienteCod, Grd_Datos.TextMatrix(Grd_Datos.Row, Columnas.ncolRutApoderadoCli2))
      ArregloDatosBasicos(ColsDatosBasicos.RutApoderadoCli2) = Grd_Datos.TextMatrix(Grd_Datos.Row, Columnas.ncolRutApoderadoCli1)
      ArregloDatosBasicos(ColsDatosBasicos.DireccionCli) = Cliente.cldireccion
      ArregloDatosBasicos(ColsDatosBasicos.ComunaCli) = Cliente.clcomunaglosa
      ArregloDatosBasicos(ColsDatosBasicos.CiudadCli) = Cliente.clciudadglosa
      
      ArregloDatosBasicos(ColsDatosBasicos.TipoCli) = Cliente.cltipocliente
      ArregloDatosBasicos(ColsDatosBasicos.FechaAntiguoCcg) = Cliente.clfecha_cond_generales
      ArregloDatosBasicos(ColsDatosBasicos.FechaNuevoCcg) = Cliente.clFechaNuevoCgg
      
      DatosContrato(6) = ArregloDatosBasicos(ColsDatosBasicos.NombreCli)  'Nombre Cliente
      DatosContrato(7) = ArregloDatosBasicos(ColsDatosBasicos.RutCli)     'Rut Cliente
      'DatosContrato(19) =   'Codigo Cliente PENDIENTE
      DatosContrato(10) = ArregloDatosBasicos(ColsDatosBasicos.DireccionCli)   'Direccion Cliente
      
   
      If Not Func_Busca_Dctos_Fisicos(MatrizDctosFisicos(), cConceptoImrpresion, True) Then
         Screen.MousePointer = vbDefault
         MsgBox "Ha ocurrido un error al intentar generar los contratos", vbCritical + vbOKOnly
         Exit Sub
      End If
      
      If Not Func_Lee_Clausulas_Arbol(MatrizClausulas(), "PCS", True) Then
         Screen.MousePointer = vbDefault
         MsgBox "Ha ocurrido un error al intentar generar los contratos", vbCritical + vbOKOnly
         Exit Sub
      End If
      
      Erase MatrizAvales
               
      If Not Func_Busca_Avales_Cliente_Derivados(ClienteOp, ClienteCod, MatrizAvales()) Then
         Exit Sub
      End If
      
      '**********************************************************************************************************************
      '**************************************** BUSCA LOS DATOS DEL CONTRATO IMPRESO ****************************************
      '**********************************************************************************************************************
      
      
      Dim cDigBco As String
      
      If Not Bac_Sql_Execute("SP_LEERDATOSGENERALES") Then
         Screen.MousePointer = vbDefault
         MsgBox "Ha ocurrido un error al intentar consultar los datos generales", vbCritical, TITSISTEMA
         Exit Sub
      End If
         
      If Bac_SQL_Fetch(DATOS()) Then
         DatosContrato(1) = UCase(DATOS(3))                       'Nombre Banco
         digBco = BacCheckRut(CStr(Val(DATOS(4))))
         DatosContrato(2) = BacFormatoRut(Val(DATOS(4)) & "-" & digBco) 'Rut Banco
         DatosContrato(5) = DATOS(5)                              'Direccion Banco
         DatosContrato(15) = DATOS(8)                             'Telefono Banco
         DatosContrato(16) = DATOS(9)                             'Fax Banco
      End If
      
         Envia = Array()
         AddParam Envia, ClienteOp
         AddParam Envia, ClienteCod
         AddParam Envia, nNumoper
            
      If Not Bac_Sql_Execute("SP_CON_CONTRATO_IMPRESO", Envia) Then
         Screen.MousePointer = vbDefault
         MsgBox "Ha ocurrido un error al intentar rescatar los contratos seleccionados", vbCritical + vbOKOnly
         Exit Sub
      End If
             
      cuenta = 0
             
      Do While Bac_SQL_Fetch(DATOS())
         cuenta = cuenta + 1
         ReDim Preserve MatrizSeleccionados(5, cuenta)
         
         MatrizSeleccionados(1, cuenta) = DATOS(1)        ' RUT CLIENTE
         MatrizSeleccionados(2, cuenta) = DATOS(2)        ' CODIGO CLIENTE
         MatrizSeleccionados(3, cuenta) = "PCS"           ' CODIGO SISTEMA
         MatrizSeleccionados(4, cuenta) = Trim(DATOS(6))  ' CODIGO DCTO PRINCIPAL
         MatrizSeleccionados(5, cuenta) = Trim(DATOS(7))  ' CODIGO DCTO
         nCuentaAvales = Val(DATOS(12))
      Loop
      
      '**********************************************************************************************************************
      '**********************************************************************************************************************
      '**********************************************************************************************************************
           
      If Not Func_Genera_Contrato_Dinamico(ClienteOp, ClienteCod, nNumoper, DatosContrato(), "", cConceptoImrpresion, False, , True) Then
         Exit Sub
      End If
      
      Screen.MousePointer = vbDefault
   
   End If

End Sub

Private Sub Form_Load()

   Me.Icon = BACSwap.Icon
   Me.Top = 0
   Me.Left = 0
   
   Opt_Opcion(0).Value = True
   
   With Grd_Datos
      .Rows = 1
      .Cols = 11
      .FixedCols = 0
      
      .TextMatrix(0, Columnas.ncolfecha) = "Fecha Impre."
      .TextMatrix(0, Columnas.ncoltipo) = "Tipo Contrato"
      .TextMatrix(0, Columnas.ncolOperacion) = "N° Oper."
      .TextMatrix(0, Columnas.ncolRutCliente) = "Rut Cliente"
      .TextMatrix(0, Columnas.ncolCodigoCliente) = "Cod Cli"
      .TextMatrix(0, Columnas.ncolNombreCliente) = "Cliente"
      .TextMatrix(0, Columnas.ncolRutApoderadoBco1) = "RutApoBco1"
      .TextMatrix(0, Columnas.ncolRutApoderadoBco2) = "RutApoBco2"
      .TextMatrix(0, Columnas.ncolRutApoderadoCli1) = "RutApoCli1"
      .TextMatrix(0, Columnas.ncolRutApoderadoCli2) = "RutApoCli2"
      .TextMatrix(0, Columnas.ncolCantidadAvales) = "CantidadAvales"
      
      .ColWidth(Columnas.ncolfecha) = 1000
      .ColWidth(Columnas.ncoltipo) = 2500
      .ColWidth(Columnas.ncolOperacion) = 1000
      .ColWidth(Columnas.ncolRutCliente) = 1200
      .ColWidth(Columnas.ncolCodigoCliente) = 500
      .ColWidth(Columnas.ncolNombreCliente) = 2500
      .ColWidth(Columnas.ncolRutApoderadoBco1) = 0
      .ColWidth(Columnas.ncolRutApoderadoBco2) = 0
      .ColWidth(Columnas.ncolRutApoderadoCli1) = 0
      .ColWidth(Columnas.ncolRutApoderadoCli2) = 0
      .ColWidth(Columnas.ncolCantidadAvales) = 0
   End With
   
   
   If Not Bac_Sql_Execute("SP_LEERDATOSGENERALES") Then
      MsgBox "¡No se encuentran datos Principales de la Entidad!", vbCritical, Msj
      Exit Sub
   End If
  
   If Bac_SQL_Fetch(DATOS()) Then
      nRutBco = Val(DATOS(4))
      nCodigoBco = DATOS(22)
      cNombreBco = DATOS(3)
      cDireccionBco = DATOS(5)
      cCiudadBco = DATOS(7)
      cComunaBco = DATOS(6)
   End If
   
End Sub


Private Sub Grd_Datos_DblClick()

   Call Proc_Imprimir

End Sub

Private Sub Opt_Opcion_Click(Index As Integer)

   If Opt_Opcion(0).Value = True Then
      Fr_Cliente.Enabled = False
      Fr_Fecha.Enabled = True
      Txt_Cliente.Text = ""
      Grd_Datos.Rows = 1
   ElseIf Opt_Opcion(1).Value = True Then
      Fr_Cliente.Enabled = True
      Fr_Fecha.Enabled = False
      Txt_Fecha.Text = CDate(gsBAC_Fecp)
      Grd_Datos.Rows = 1
   End If

End Sub


Private Sub Tbl_Opciones_ButtonClick(ByVal Button As ComctlLib.Button)
   
   Select Case Button.Index
      Case btn_Imprimir
         Call Proc_Imprimir
         
      Case btn_Salir
         Unload Me
   
   End Select


End Sub

Private Sub Txt_Cliente_DblClick()

   Dim Cliente As New clsCliente
   Dim codcli As Long
   
   'If Not Cliente.CargaClienteContratoImpreso(Me.Txt_Cliente.Tag, "") Then
   If Cliente.Func_LeeClienteContratoImpreso("") Then
      'BacAyudaSwap.Tag = "CliContrato"
      'BacAyudaSwap.Show 1
      BacAyudaCliente.Tag = "CliContrato"
      BacAyudaCliente.Show 1
   Else
      Set Cliente = Nothing
      MsgBox "No Existen Datos para ayuda solicitada", vbExclamation
      Exit Sub
   End If
   
   If giAceptar Then
       If Cliente.LeerxRut(Val(gsCodigo), Val(gsCodCli)) Then
           Txt_Cliente.Text = Format(Cliente.clrut, "#,###") & "-" & Cliente.cldv & Space(15 - Len((Format(Cliente.clrut, "#,###") & "-" & Cliente.cldv))) & Space(1) & Cliente.clcodigo & Space(1) & Cliente.clnombre
       Else
           MsgBox "No se pudo capturar datos de Cliente solicitado", vbCritical, Msj
       End If
   End If
      

End Sub


Private Sub Txt_Cliente_KeyPress(KeyAscii As Integer)
   Dim cRutCli As String
   Dim nCodigoCli As Integer

   If KeyAscii = vbKeyReturn Then
      cRutCli = Replace(Replace(Trim(Mid(Txt_Cliente.Text, 1, 15)), ",", ""), ".", "")
      cRutCli = Mid(cRutCli, 1, Len(cRutCli) - 2)
      nCodigoCli = CInt(Mid(Txt_Cliente, 17, 1))
      Call Proc_Busca_Datos(CLng(cRutCli), nCodigoCli, "")
      Exit Sub
   End If
   
   KeyAscii = 0

End Sub

Private Sub Proc_Busca_Contratos_Impresos()

   


End Sub

Private Sub Txt_Fecha_Change()

   Call Proc_Busca_Datos(-999, -999, Txt_Fecha.Text)
   
End Sub


