VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "Msflxgrd.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacIrfAn 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Anulacion de Operaciones"
   ClientHeight    =   5235
   ClientLeft      =   2550
   ClientTop       =   1620
   ClientWidth     =   9015
   ForeColor       =   &H00C0C0C0&
   Icon            =   "Bacirfan.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   Moveable        =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5235
   ScaleWidth      =   9015
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   3435
      Top             =   15
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
            Picture         =   "Bacirfan.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacirfan.frx":0624
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacirfan.frx":093E
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   18
      Top             =   0
      Width           =   9015
      _ExtentX        =   15901
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdAnular"
            Description     =   "Anular"
            Object.ToolTipText     =   "Anular Operación"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdLimpiar"
            Description     =   "Limpiar"
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdSalir"
            Description     =   "Salir"
            Object.ToolTipText     =   "Salir de la Ventana"
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin MSFlexGridLib.MSFlexGrid Gridpaso 
      Height          =   2685
      Left            =   0
      TabIndex        =   16
      Top             =   2565
      Width           =   9030
      _ExtentX        =   15928
      _ExtentY        =   4736
      _Version        =   393216
      Cols            =   10
      FixedCols       =   0
      BackColor       =   12632256
      ForeColor       =   12582912
      BackColorFixed  =   8421376
      ForeColorFixed  =   16777215
      BackColorBkg    =   12632256
      GridLines       =   2
   End
   Begin Threed.SSFrame SSFrame1 
      Height          =   2115
      Left            =   0
      TabIndex        =   0
      Top             =   420
      Width           =   9015
      _Version        =   65536
      _ExtentX        =   15901
      _ExtentY        =   3731
      _StockProps     =   14
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin BACControles.TXTNumero txtNumDocu 
         Height          =   315
         Left            =   120
         TabIndex        =   17
         Top             =   480
         Width           =   1095
         _ExtentX        =   1931
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
         MarcaTexto      =   -1  'True
      End
      Begin VB.TextBox txtDigCli 
         Alignment       =   1  'Right Justify
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   1320
         TabIndex        =   8
         Top             =   1620
         Width           =   1140
      End
      Begin VB.TextBox txtRutCli 
         Alignment       =   1  'Right Justify
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   165
         MaxLength       =   9
         MousePointer    =   99  'Custom
         TabIndex        =   7
         Top             =   1620
         Width           =   1095
      End
      Begin VB.TextBox txtNomCli 
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   2505
         TabIndex        =   6
         Top             =   1620
         Width           =   6315
      End
      Begin VB.TextBox txtRutCar 
         Alignment       =   1  'Right Justify
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   150
         MaxLength       =   9
         MousePointer    =   99  'Custom
         TabIndex        =   5
         Top             =   1050
         Width           =   1095
      End
      Begin VB.TextBox txtNomCar 
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   1830
         TabIndex        =   4
         Top             =   1050
         Width           =   4905
      End
      Begin VB.TextBox txtDigCar 
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   1455
         TabIndex        =   3
         Top             =   1050
         Width           =   255
      End
      Begin VB.TextBox txtTipOpe 
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   1455
         TabIndex        =   2
         Top             =   480
         Width           =   7365
      End
      Begin VB.TextBox TxtTipcart 
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   6915
         TabIndex        =   1
         Top             =   1050
         Width           =   1905
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Código"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   0
         Left            =   1305
         TabIndex        =   15
         Top             =   1425
         Width           =   600
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Nº Operación"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   20
         Left            =   165
         TabIndex        =   14
         Top             =   285
         Width           =   1155
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Cliente"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   5
         Left            =   165
         TabIndex        =   13
         Top             =   1425
         Width           =   600
      End
      Begin VB.Label Label 
         Caption         =   "-"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   6
         Left            =   1320
         TabIndex        =   12
         Top             =   1050
         Width           =   135
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Entidad"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   1
         Left            =   165
         TabIndex        =   11
         Top             =   855
         Width           =   660
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Tipo de Operación"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   2
         Left            =   1440
         TabIndex        =   10
         Top             =   285
         Width           =   1590
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Tipo de Cartera"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   4
         Left            =   6900
         TabIndex        =   9
         Top             =   855
         Width           =   1335
      End
   End
End
Attribute VB_Name = "BacIrfAn"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim Frm_Tipoper         As String
Dim Frm_Rut_Emisor()    As Long
Dim Frm_V_Presente()    As Double
Dim Frm_Instrumento()   As String
Dim Frm_DuratModif()    As Double
Dim Frm_CodMoneda()     As Integer

Dim frm_series()        As String
Dim Frm_V_Venta()       As Double
Dim Frm_F_vcto()        As String
Dim Frm_Rut_Cliente     As Long
Dim Frm_FP_Vencimiento  As Long
Dim Frm_FP_Inicio       As Long
Dim dTotalOper          As Double

Dim Monto_PFE           As Double
Dim Monto_CCE           As Double
Dim Fecha_Vcto_Pacto    As String

Dim Sql                 As String
Dim Datos()

Private Sub Func_Anular_Datos()
   On Error GoTo AnularOperacion3
   Dim Msg              As String
   Dim dNumdocu#
   Dim i%
   Dim iContador        As Long
     Dim Cont As Integer
   Dim nCod As Integer

        'ld1-cor-035
        '-------LIMITES-ALCO--20-FEB-2002
        'Data1.Recordset.MoveFirst
        Cont2 = 1
        Cont = 1
        TOTAL_GRILLA_VALOR_PRESENTE_AN = 0
        TOTAL_GRILLA_VALOR_PRESENTE_AN = 0
        Series_AN = Array()
        Montos_Series_AN = Array()
        Nominal_Series_AN = Array()
        Plazos_AN = Array()
        Codigos = Array()
        Emisores_AN = Array()
'        ReDim Series_AN(GridPaso.Rows - 1)
'        ReDim Montos_Series_AN(GridPaso.Rows - 1)
'        ReDim Nominal_Series_AN(GridPaso.Rows - 1)
'        ReDim Plazos_AN(GridPaso.Rows - 1)
'        ReDim Codigos(GridPaso.Rows - 1)
        Do
           ' nCod = Trae_Codigo(GridPaso.TextMatrix(Cont, 9))
            'nCod = Trae_Codigo(frm_series(Cont))
            nCod = Trae_Codigo(frm_series(Cont))
            
            'If Valida_Instrumento(nCod, CDbl(GridPaso.TextMatrix(Cont, 10))) Then
                ReDim Preserve Series_AN(Cont2)
                ReDim Preserve Montos_Series_AN(Cont2)
                ReDim Preserve Nominal_Series_AN(Cont2)
                ReDim Preserve Plazos_AN(Cont2)
                ReDim Preserve Codigos(Cont2)
                ReDim Preserve Emisores_AN(Cont2)
                'Rut Emisor
                'Emisores_AN(Cont2) = CDbl(GridPaso.TextMatrix(Cont, 2))
                Emisores_AN(Cont2) = Frm_Rut_Emisor(Cont)
                Codigos(Cont2) = nCod
                Series_AN(Cont2) = GridPaso.TextMatrix(Cont, 1)
                'Montos_Series_AN(Cont2) = GridPaso.TextMatrix(Cont, 11)
                Montos_Series_AN(Cont2) = GridPaso.TextMatrix(Cont, 7)
                Nominal_Series_AN(Cont2) = GridPaso.TextMatrix(Cont, 4)
                Plazos_AN(Cont2) = PLAZO_PAPEL_TRADING(GridPaso.TextMatrix(Cont, 1))
                'TOTAL_GRILLA_VALOR_PRESENTE_AN = TOTAL_GRILLA_VALOR_PRESENTE_AN + GridPaso.TextMatrix(Cont, 11)
                TOTAL_GRILLA_VALOR_PRESENTE_AN = TOTAL_GRILLA_VALOR_PRESENTE_AN + GridPaso.TextMatrix(Cont, 7)
                
                TipoOper_AN = "AN"
                TipoProducto_AN = TxtTipope.Tag
                Cont2 = Cont2 + 1
            'End If
            Cont = Cont + 1

        Loop Until Cont = GridPaso.Rows
'        '----------------------------




   Dim ptTipoOp As String
   Dim ptNumOp As Double   'era Integer y se desbordaba

   ptTipoOp = Me.TxtTipope.Tag
   If ptTipoOp = "ICOL" Or ptTipoOp = "ICAP" Then
        ptTipoOp = "IB"
   End If
   ptTipoOp = Mid$(ptTipoOp, 1, 2)
   ptNumOp = CDbl(Me.TxtNumDocu.text)


   If Val(Me.TxtNumDocu.text) <> 0 Then
      If MsgBox("¿Está seguro de Anular operación? ", vbQuestion + vbYesNo, TITSISTEMA) = vbYes Then
         ' reviso si el Flag de encendido del proceso
        If blnProcesoArt84Activo("BTR") Then
            If Not blnAnulaControlMargenes(Val(TxtNumDocu.text), "BTR", txtRutCli.text, txtDigCli.text) Then
               MsgBox "Problemas al Anular control de márgenes (Art84), para la siguiente operación :" + TxtNumDocu.text, vbCritical, gsBac_Version
            End If
        End If
         
         NumeroOperacionExceso = TxtNumDocu.text
         Toolbar1.Buttons(2).Enabled = False
         MousePointer = 11
         
         Envia = Array()
         AddParam Envia, Me.TxtNumDocu.text
         AddParam Envia, Me.TxtTipope.Tag
         AddParam Envia, Me.txtRutCar.text
         If Bac_Sql_Execute("SP_LLAMAPROCESO", Envia) Then
            If Bac_SQL_Fetch(Datos()) Then
            
                 If (Datos(2)) = 0 Then
                  
                    'Anulación por Documento
                    For iContador = 1 To Me.GridPaso.Rows - 1
                    'Actualiza Coberturas Asociadas
                        Envia = Array()
                        AddParam Envia, "BTR"
                        AddParam Envia, CDbl(GridPaso.TextMatrix(iContador, 8))
                        AddParam Envia, CDbl(GridPaso.TextMatrix(iContador, 9))
                        Call Bac_Sql_Execute("BacTraderSuda..SP_ACTUALIZACION_POSTVENTA", Envia)
                    'Actualiza Coberturas Asociadas
                    Next iContador
                    'Anulación por Documento
                    
                    Msg$ = "Operacion Nº  " + Me.TxtNumDocu.text + ":  " + Datos(1)
                    MsgBox Msg$, vbInformation, gsBac_Version
                    MousePointer = 0
                    '''Call Func_Limpiar_Pantalla
                    NumeroOperacionExceso = 0
                    '''TxtNumDocu.Text = 0
                    TxtNumDocu.SetFocus
                Else
                    Msg$ = Datos(1)
                    MousePointer = 0
                    MsgBox Msg$, vbInformation 'insertado 05/02/2001
                    Exit Sub
                End If
            Else
                MousePointer = 0
                MsgBox "Problemas al ejecutar Procedimiento " & err.Description, vbInformation, gsBac_Version
                Exit Sub
            End If
          
            'LD1-COR-035 VALIDACION ALCO
            '-------- 10-11-2015 --------
            'ALCO 21-Feb-2002 - Incrementa Disponibilidad de Copra al Actuzlizar ALCO
            '************************************************************************
             Call Actualiza_Limites_Por_Anulacion(TipoOper_AN, TipoProducto_AN, Me.TxtTipcart.text)
             
            '************************************************************************
            'LD1-COR-035 VALIDACION ALCO
            
            
                
            '********** Linea -- Mkilo
            If gsBac_Lineas = "S" Then
               If Me.TxtTipope.Tag <> "RCA" And Me.TxtTipope.Tag <> "RVA" Then
                  If Not Lineas_Anular("BTR", CDbl(Me.TxtNumDocu.text)) Then
                  End If
                  
                  '+++CONTROL IDD, jcamposd llamada a nuevo control IDD para las líneas
                    'iCorrela% = 1
        
                    For iContador = 1 To Me.GridPaso.Rows - 1
        
                        Dim oParametrosLinea As New clsControlLineaIDD
        
                        With oParametrosLinea
                            .Modulo = "BTR"
                            .Producto = ptTipoOp
                            .Operacion = Me.TxtNumDocu.text
                            .Documento = Me.TxtNumDocu.text
                            .Correlativo = iContador
                            .Accion = "R"
            
                            .RecuperaDatosLineaIDD
                            
                            If .numeroiddAnula <> 0 Then
                                .EjecutaProcesoWsLineaIDD ' solo anula si consumio línea
                            End If
                            
                        End With
                        Set oParametrosLinea = Nothing
                        On Error GoTo seguirAnulacion
                        
                   Next iContador
                  '---CONTROL IDD, jcamposd llamada a nuevo control IDD para las líneas
                  
               End If
            End If
            '********* Fin
         Else
                MsgBox "Problemas al ejecutar Procedimiento " & err.Description, vbInformation, gsBac_Version
                Exit Sub
         End If

seguirAnulacion:

         dNumdocu = Val(TxtNumDocu.text)
         NumeroOperacionExceso = TxtNumDocu.text
         Toolbar1.Buttons(2).Enabled = False

         MousePointer = 11
         If gsBac_QUEDEF <> gsBac_IMPWIN Then
            i = ActArcIni(gsBac_QUEDEF)
            Select Case Frm_Tipoper$
               Case "CP":   Sql = ImprimeAnulacionPapeleta(txtRutCar.text, Str(dNumdocu#), "CP")
               Case "VP":   Sql = ImprimeAnulacionPapeleta(txtRutCar.text, Str(dNumdocu#), "VP")
               Case "CI":   Sql = ImprimeAnulacionPapeleta(txtRutCar.text, Str(dNumdocu#), "CI")
               Case "VI":   Sql = ImprimeAnulacionPapeleta(txtRutCar.text, Str(dNumdocu#), "VI")
               Case "RCA":  Sql = ImprimeAnulacionPapeleta(txtRutCar.text, Str(dNumdocu#), "RCA")
               Case "RVA":  Sql = ImprimeAnulacionPapeleta(txtRutCar.text, Str(dNumdocu#), "RVA")
            End Select
            i = ActArcIni(gsBac_IMPWIN)
         End If
         
         If Sql = "NO" Then
            MsgBox "No se pudo imprimir Papeleta(s) de Operación", vbCritical, "Papeletas de Operaciones"
         End If

         Valor_antiguo = " "
         Valor_antiguo = "Numero_Documento=" & Me.TxtNumDocu.text & ";Tipo_Operacion=" & Me.TxtTipope.Tag & ";Tipo_Cartera=" & Me.txtRutCar.text
         Call GRABA_LOG_AUDITORIA(1, gsBac_Fecp, gsBac_IP, gsBac_User, "BTR", "Opc_21100", "04", "Anulación de Operaciones", "mdmo", Valor_antiguo, " ")
         
         Toolbar1.Buttons(2).Enabled = False
         MousePointer = 0
         Call Func_Limpiar_Pantalla
         
         'Borrar Operación del Control de Precios y Tasas
         Envia = Array()
         AddParam Envia, "BTR"
         AddParam Envia, ptTipoOp
         AddParam Envia, ptNumOp
         If Bac_Sql_Execute("Bacparamsuda..SP_BORRA_OPPENDIENTEPRECIOS", Envia) Then
            Do While Bac_SQL_Fetch(Datos())
                            
            Loop
         End If
         
         NumeroOperacionExceso = 0
         TxtNumDocu.text = 0
         TxtNumDocu.SetFocus
      Else
         Exit Sub
      End If
   End If
   
   On Error GoTo 0
Exit Sub
AnularOperacion3:
   On Error GoTo 0
   MsgBox "Problemas con operación: " + Me.TxtNumDocu.text & ": " & err.Description, vbInformation, gsBac_Version
End Sub

Function Trae_Codigo(Serie As String) As Long
Trae_Codigo = 0
Envia = Array(Serie)
If Bac_Sql_Execute("SP_TRAE_CODIGO_SERIE", Envia) Then
    Do While Bac_SQL_Fetch(Datos())
        If Val(Datos(1)) > 0 Then
            Trae_Codigo = Val(Datos(1))
        Else
            MsgBox "No Existe Instrumento", vbExclamation, gsBac_Version
            Exit Function

        End If
    Loop
End If
End Function

Private Sub Func_Limpiar_Pantalla()

   Me.TxtTipope.text = ""
   Me.txtRutCar.text = ""
   Me.txtDigCar.text = ""
   Me.txtNomCar.text = ""
   Me.TxtTipcart.text = ""
   Me.txtRutCli.text = ""
   Me.txtDigCli.text = ""
   Me.TxtNomCli.text = ""

   GridPaso.Rows = 2
   GridPaso.Row = 1
   GridPaso.Col = 1: GridPaso.text = ""
   GridPaso.Col = 2: GridPaso.text = ""
   GridPaso.Col = 3: GridPaso.text = ""
   GridPaso.Col = 4: GridPaso.text = ""
   GridPaso.Col = 5: GridPaso.text = ""
   GridPaso.Col = 6: GridPaso.text = ""
   GridPaso.Col = 7: GridPaso.text = ""
   GridPaso.Highlight = False

End Sub

Sub Llena_Grilla_Anulacion()
On Error GoTo ErrOper

Dim Cont_E           As Integer

    Cont_E% = 1
    dTotalOper = 0
    
    Envia = Array()

    AddParam Envia, Val(Me.TxtNumDocu.text)
    AddParam Envia, GLB_CARTERA
    
    If Bac_Sql_Execute("SP_BUSCAOPERACION", Envia) Then
        Screen.MousePointer = vbHourglass
        GridPaso.Rows = 1

        Do While Bac_SQL_Fetch(Datos())
            GridPaso.Rows = GridPaso.Rows + 1
            GridPaso.Row = GridPaso.Rows - 1

            If Datos(1) = "NO" Then
                MsgBox Datos(2), vbExclamation, gsBac_Version
                Me.TxtNumDocu.text = 0
                Me.TxtNumDocu.SetFocus
            Else
                Me.TxtNumDocu.text = Datos(1)
                Me.TxtTipope.text = Datos(2)
                Me.TxtTipope.Tag = Datos(17)
                Frm_Tipoper$ = Me.TxtTipope.Tag
                Me.txtRutCar.text = Datos(3)
                Me.txtDigCar.text = Datos(4)
                Me.txtNomCar.text = Datos(5)
                Me.TxtTipcart.text = Datos(6)
                Me.txtRutCli.text = Datos(7)

                Frm_Rut_Cliente& = CLng(Datos(7))

                Me.txtDigCli.text = CDbl(Datos(8))
                Me.TxtNomCli.text = Datos(9)
                GridPaso.Col = 1: GridPaso.text = Datos(10)
                If Trim(Datos(10)) = "FMUTUO" Then
                    GridPaso.ColWidth(5) = 1800
                End If
                GridPaso.Col = 2: GridPaso.text = Datos(11)
                GridPaso.Col = 3: GridPaso.text = Datos(12)
                GridPaso.Col = 4: GridPaso.text = Format(CDbl(Datos(13)), "#,##0.0000")
                GridPaso.Col = 5: GridPaso.text = Format(CDbl(Datos(14)), "#,##0.0000")
                GridPaso.Col = 6: GridPaso.text = Format(CDbl(Datos(15)), "#,##0.0000")
                GridPaso.Col = 7: GridPaso.text = Format(CDbl(Datos(16)), "###,###0.0000")
                GridPaso.TextMatrix(GridPaso.Rows - 1, 8) = Datos(31)
                GridPaso.TextMatrix(GridPaso.Rows - 1, 9) = Datos(32)

                'RUT del Emisor en la grilla
                  ReDim Preserve Frm_Rut_Emisor(Cont_E%) As Long
                  Frm_Rut_Emisor(Cont_E%) = Datos(18)
                
                'RUT del Emisor en la grilla
                  ReDim Preserve frm_series(Cont_E%) As String
                  frm_series(Cont_E%) = Datos(23)
                
                'Valor Presente
                  ReDim Preserve Frm_V_Presente(Cont_E%) As Double
                  Frm_V_Presente(Cont_E%) = Datos(16)
                  dTotalOper = dTotalOper + Datos(16)
                
                'Forma de pago al vencimiento
                  If IsNumeric(Datos(19)) Then
                     Frm_FP_Vencimiento& = CLng(Datos(19))
                  Else
                     Frm_FP_Vencimiento& = 0
                  End If

                'Forma de pago al Inicio
                  If IsNumeric(Datos(20)) Then
                     Frm_FP_Inicio& = CLng(Datos(20))
                  Else
                     Frm_FP_Inicio& = 0
                  End If

               'Monto de la Venta Def.
                  ReDim Preserve Frm_V_Venta(Cont_E%) As Double
                  If IsNumeric(Datos(21)) Then
                     Frm_V_Venta(Cont_E%) = CDbl(Datos(21))
                  Else
                     Frm_V_Venta(Cont_E%) = 0
                  End If

               'Serie
                  ReDim Preserve Frm_Instrumento(Cont_E%) As String
                  Frm_Instrumento(Cont_E%) = Datos(10)

               'Fecha de Vencimiento del Papel
                  ReDim Preserve Frm_F_vcto(Cont_E%) As String
                  Frm_F_vcto(Cont_E%) = Datos(22)

                  ReDim Preserve Frm_DuratModif(Cont_E%) As Double
                  Frm_DuratModif(Cont_E%) = Datos(24)

                  ReDim Preserve Frm_CodMoneda(Cont_E%) As Integer
                     Frm_CodMoneda(Cont_E%) = Datos(25)

               ' Datos(26) y DAtos(27) no USAR VB +- 27/07/2000
                Cont_E% = Cont_E% + 1

                'Rescata monto PFE y CCE limites
                '-------------------------------

                Monto_PFE = Val(Datos(28))
                Monto_CCE = Val(Datos(29))
                Fecha_Vcto_Pacto = Datos(30)

                Toolbar1.Buttons(2).Enabled = True

            End If

        Loop

   End If

   On Error GoTo 0
   Screen.MousePointer = vbDefault
   Exit Sub

ErrOper:

    On Error GoTo 0
    Screen.MousePointer = vbDefault
    MsgBox "Problemas al realizar consulta de operación por eliminar", vbCritical, gsBac_Version

    Exit Sub

End Sub

Function Verifica_Tesoreria() As Boolean
   On Error GoTo ErrTeso

    Verifica_Tesoreria = False

    Envia = Array("BTR", _
            txtRutCar.text, _
            TxtNumDocu.text)

    If Bac_Sql_Execute("SP_CHKOPER_TESORERIA", Envia) Then
        Do While Bac_SQL_Fetch(Datos())
            If Datos(1) <> "N" Then
                MsgBox "Operación no se puede anular, ya que se encuentra liquidada en tesoreria, Verifique operación en Tesorería.", vbExclamation, gsBac_Version
                Exit Function
            End If
        Loop
    End If

    Verifica_Tesoreria = True

    On Error GoTo 0

    Exit Function

ErrTeso:
    On Error GoTo 0
    MsgBox "Problemas en verificación de información de tesoreria: " & err.Description & ". Verifique.", vbCritical, gsBac_Version
    Exit Function

End Function

Private Sub Form_Activate()

   Toolbar1.Buttons(2).Enabled = False
   TxtNumDocu.SetFocus

End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)

   If KeyAscii = 13 Then
      Call Bac_SendKey(vbKeyTab)

   End If

End Sub

Private Sub Form_Load()

   With GridPaso
      .Rows = 1
      .Row = 0
      .ColWidth(0) = 0
      .ColWidth(1) = 1500
      .ColWidth(2) = 1000
      .ColWidth(3) = 800
      .ColWidth(4) = 1500
      .ColWidth(5) = 1000
      .ColWidth(6) = 1000
      .ColWidth(7) = 2000

      .TextMatrix(0, 1) = "Serie"
      .TextMatrix(0, 2) = "Emisor"
      .TextMatrix(0, 3) = "UM"
      .TextMatrix(0, 4) = "Nominal"
      .TextMatrix(0, 5) = "Tir"
      .TextMatrix(0, 6) = "% Vpar"
      .TextMatrix(0, 7) = "Valor Presente"
      .RowHeight(0) = 315
      
      .ColWidth(8) = 0
      .ColWidth(9) = 0
   End With

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

   Select Case UCase(Button.Description)
   Case "ANULAR"
      Call Func_Anular_Datos

   Case "LIMPIAR"
      Call Func_Limpiar_Pantalla

      NumeroOperacionExceso = 0
      TxtNumDocu.text = 0
      TxtNumDocu.SetFocus

   Case "SALIR"
      Unload Me

   End Select

End Sub

Private Sub txtNumDocu_LostFocus()

   
   If Val(TxtNumDocu.text) <> 0 Then
      Call Func_Limpiar_Pantalla
      BacControlWindows 12

      Call Llena_Grilla_Anulacion

   End If

End Sub
