VERSION 5.00
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "comdlg32.ocx"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "Msflxgrd.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form FRM_DETALLE_LCR 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Detalle LCR"
   ClientHeight    =   5580
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   10455
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   5580
   ScaleWidth      =   10455
   Begin VB.Frame Frame1 
      Height          =   4920
      Left            =   75
      TabIndex        =   0
      Top             =   600
      Width           =   10335
      Begin VB.Frame Frame2 
         ForeColor       =   &H00800000&
         Height          =   1455
         Left            =   135
         TabIndex        =   2
         Top             =   120
         Width           =   10125
         Begin VB.OptionButton Opt_Opcion 
            Caption         =   "Mtm Carteras"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00C00000&
            Height          =   255
            Index           =   7
            Left            =   4560
            TabIndex        =   10
            Top             =   870
            Width           =   1635
         End
         Begin BACControles.TXTNumero txtExpMax 
            Height          =   345
            Left            =   7620
            TabIndex        =   9
            Top             =   360
            Width           =   2340
            _ExtentX        =   4128
            _ExtentY        =   609
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
         Begin VB.OptionButton Opt_Opcion 
            Caption         =   "Rec"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00C00000&
            Height          =   225
            Index           =   6
            Left            =   4545
            TabIndex        =   7
            Top             =   450
            Width           =   825
         End
         Begin VB.OptionButton Opt_Opcion 
            Caption         =   "Exposición Actual"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00C00000&
            Height          =   225
            Index           =   4
            Left            =   2715
            TabIndex        =   6
            Top             =   435
            Width           =   1815
         End
         Begin VB.OptionButton Opt_Opcion 
            Caption         =   "AddOn "
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00C00000&
            Height          =   225
            Index           =   3
            Left            =   2730
            TabIndex        =   5
            Top             =   900
            Width           =   1080
         End
         Begin VB.OptionButton Opt_Opcion 
            Caption         =   "Threshold "
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00C00000&
            Height          =   225
            Index           =   2
            Left            =   255
            TabIndex        =   4
            Top             =   900
            Width           =   1335
         End
         Begin VB.OptionButton Opt_Opcion 
            Caption         =   "AddOn90d y Var por OP"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00C00000&
            Height          =   225
            Index           =   0
            Left            =   240
            TabIndex        =   3
            Top             =   420
            Width           =   2265
         End
         Begin VB.Label lblExpMax 
            Caption         =   "Exposición Maxima"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00C00000&
            Height          =   210
            Left            =   5790
            TabIndex        =   8
            Top             =   465
            Width           =   1680
         End
      End
      Begin MSFlexGridLib.MSFlexGrid Grd_Datos 
         Height          =   2940
         Left            =   135
         TabIndex        =   1
         Top             =   1740
         Width           =   10065
         _ExtentX        =   17754
         _ExtentY        =   5186
         _Version        =   393216
         Cols            =   13
         FixedCols       =   0
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   11
      Top             =   0
      Width           =   10455
      _ExtentX        =   18441
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Generar"
            Object.ToolTipText     =   "Exportar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   5
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComDlg.CommonDialog Command 
         Left            =   5025
         Top             =   30
         _ExtentX        =   847
         _ExtentY        =   847
         _Version        =   393216
      End
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   7215
         Top             =   30
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   22
         ImageHeight     =   22
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   6
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_DETALLE_LCR.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_DETALLE_LCR.frx":0EDA
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_DETALLE_LCR.frx":1DB4
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_DETALLE_LCR.frx":2C8E
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_DETALLE_LCR.frx":3B68
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_DETALLE_LCR.frx":3E82
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
End
Attribute VB_Name = "FRM_DETALLE_LCR"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub Calculorec_Fra(Num As Integer, miForm As Form, rut As Long, codcli As Long)
    
    Screen.MousePointer = vbDefault
  
    Dim miClase         As New Swap_OP
    Dim iNumeroFlujos   As Integer
    Dim iTipoFlujo      As Integer
    Dim MiGrilla        As MSFlexGrid
    Dim MonedaBac       As Integer
    Dim Convencion      As Integer
    Dim Base            As Integer
    Dim PlazoFwd        As Integer
    Dim CodigoTasa      As Long
    Dim TipoSwap        As Integer
    Dim FechaInicioFlujo As Date
    Dim Det_MsgError        As String
    Dim FechaMadurez        As Date
    Dim Det_Threshold_LCR   As Double
    Dim Det_Metodologia_LCR As Integer
    Dim Det_Cliente_LCR     As String
    Screen.MousePointer = vbHourglass
   

    Dim SwapCarteraREC As Negociacion
    
    Det_Metodologia_LCR = miForm.Fra_Metodologia_LCR
    Det_Threshold_LCR = miForm.Fra_Threshold_LCR
    Det_Cliente_LCR = miForm.Fra_Cliente_LCR
       
     
    'PROD-10967
    If Det_Metodologia_LCR <> 1 And Det_Metodologia_LCR <> 4 Then
        
        Dim Indicador As Long
        Let Indicador = 0
        
        For iTipoFlujo = 1 To 2
        
            If miForm.CmbTipoFra = 1 Then
                Set MiGrillaaux = IIf(iTipoFlujo = 1, miForm.I_Grid, miForm.D_Grid)
            Else
                Set MiGrillaaux = IIf(iTipoFlujo = 1, FRM_SWAP_OP_FRA.D_Grid, FRM_SWAP_OP_FRA.I_Grid)
            End If
             'Set MiGrillaAux = IIf(iTipoFlujo = 1, miForm.I_Grid, miForm.D_Grid)
            For iNumeroFlujos = 1 To MiGrillaaux.Rows - 1
                 'POR HACER: donde esta el tipo de dato en comentario
                 ' se debe llamar a una funcion para que obtenga
                 ' los valores
                 ReDim Preserve SwapCarteraREC.Cartera_Swap(Indicador)
                 SwapCarteraREC.Cartera_Swap(Indicador).rut = rut
                 SwapCarteraREC.Cartera_Swap(Indicador).Codigo = codcli
                 SwapCarteraREC.Cartera_Swap(Indicador).Numero_Operacion = 0 'miClase.A01_NumeroOperacion
                 SwapCarteraREC.Cartera_Swap(Indicador).Numero_flujo = iNumeroFlujos
                 SwapCarteraREC.Cartera_Swap(Indicador).Tipo_flujo = iTipoFlujo
                 SwapCarteraREC.Cartera_Swap(Indicador).Tipo_swap = 3 'EntregaTipoSwap(Miform)
                
                 
                 SwapCarteraREC.Cartera_Swap(Indicador).Modalidad_pago = Left(miForm.Modalidad, 1)
                 SwapCarteraREC.Cartera_Swap(Indicador).Cartera = 0 'As Long para siempre
                 
                 MonedaBac = miForm.Moneda.ItemData(miForm.Moneda.ListIndex)
            '              MonedaBac = IIf(iTipoFlujo = 1 _
            '                        , Miform.I_Moneda.ItemData(Miform.I_Moneda.ListIndex) _
            '                        , Miform.D_Moneda.ItemData(Miform.D_Moneda.ListIndex))
                 
                 SwapCarteraREC.Cartera_Swap(Indicador).Moneda = Func_Riesgo_Financiero(MonedaBac)
'                 If ParamMoneda_LCR = True Then
'                     ParamMoneda_LCR = False
'                     Exit Sub
'                 End If
                 SwapCarteraREC.Cartera_Swap(Indicador).Codigo_tasa = IIf(iTipoFlujo = 1, _
                             miForm.Indicador.ItemData(miForm.Indicador.ListIndex), _
                             miForm.Indicador.ItemData(miForm.Indicador.ListIndex))
                             
                             
                 Convencion = miForm.ConteoDias.ItemData(miForm.ConteoDias.ListIndex)
            '              Convencion = IIf(iTipoFlujo = 1 _
            '                         , Miform.I_ConteoDias.ItemData(Miform.I_ConteoDias.ListIndex) _
            '                         , Miform.D_ConteoDias.ItemData(Miform.D_ConteoDias.ListIndex))
                 
                 SwapCarteraREC.Cartera_Swap(Indicador).Convencion = Func_TipoConvencio(Convencion)     '"P"  ' As String
                 Base = miForm.ConteoDias.ItemData(miForm.ConteoDias.ListIndex)
                 
            '              Base = IIf(iTipoFlujo = 1 _
            '                      , Miform.I_ConteoDias.ItemData(Miform.I_ConteoDias.ListIndex) _
            '                      , Miform.D_ConteoDias.ItemData(Miform.D_ConteoDias.ListIndex))
                 
                 SwapCarteraREC.Cartera_Swap(Indicador).Base = Func_BaseSwap(Base)   ' 360 'As Long
                 
                 PlazoFwd = miForm.Indicador.ItemData(miForm.Indicador.ListIndex)
            '              PlazoFwd = IIf(iTipoFlujo = 1 _
            '                      , Miform.I_Indicador.ItemData(Miform.I_Indicador.ListIndex) _
            '                      , Miform.D_Indicador.ItemData(Miform.D_Indicador.ListIndex))
                 
                 SwapCarteraREC.Cartera_Swap(Indicador).PlazoFwd = Func_BaseForward(PlazoFwd)   '180 'As Long
                 
                 SwapCarteraREC.Cartera_Swap(Indicador).IndexLag = IIf(iTipoFlujo = 1 _
                                         , miForm.I_DiasReset.Text, miForm.D_DiasReset.Text)
                 
                 If iTipoFlujo = 1 Then
                   SwapCarteraREC.Cartera_Swap(Indicador).Fecha_ini = IIf(iNumeroFlujos = 1, miForm.FechaEfectiva.Text _
                                                       , Format(MiGrillaaux.TextMatrix(iNumeroFlujos - 1, 1), "dd/mm/yyyy"))
                 Else
                   SwapCarteraREC.Cartera_Swap(Indicador).Fecha_ini = IIf(iNumeroFlujos = 1, miForm.FechaEfectiva.Text _
                                                       , Format(MiGrillaaux.TextMatrix(iNumeroFlujos - 1, 1), "dd/mm/yyyy"))
                 End If
                 
                 
                 SwapCarteraREC.Cartera_Swap(Indicador).Fecha_fin = Format(MiGrillaaux.TextMatrix(iNumeroFlujos, 1), "dd/mm/yyyy")
                 SwapCarteraREC.Cartera_Swap(Indicador).Fecha_fija = Format(MiGrillaaux.TextMatrix(iNumeroFlujos, 16), "dd/mm/yyyy")
                 SwapCarteraREC.Cartera_Swap(Indicador).Fecha_liq = Format(MiGrillaaux.TextMatrix(iNumeroFlujos, 14), "dd/mm/yyyy") ' As Date
                 
                 CodigoTasa = SwapCarteraREC.Cartera_Swap(Indicador).Codigo_tasa
                 TipoSwap = 1 ' SwapCarteraREC.Cartera_Swap(Indicador).Tipo_swap Agregar tipo de fra
                 SwapCarteraREC.Cartera_Swap(Indicador).Codigo_descuento = Func_CodigoDescuento(MonedaBac, CodigoTasa, TipoSwap, 1)  '0 'As Long
 '                If ParamMoneda_LCR = True Then
 '                    ParamMoneda_LCR = False
 '                    Exit Sub
 '                End If
                 SwapCarteraREC.Cartera_Swap(Indicador).Codigo_forward = Func_CodigoDescuento(MonedaBac, CodigoTasa, TipoSwap, 2) '1 'As Long
'                 If ParamMoneda_LCR = True Then
'                     ParamMoneda_LCR = False
'                     Exit Sub
'                 End If
                 
                 'SwapCarteraREC.Cartera_Swap(Indicador).Tasa_flujo = CDbl(MiGrillaaux.TextMatrix(iNumeroFlujos, 23))
                 
                 SwapCarteraREC.Cartera_Swap(Indicador).Tasa_flujo = IIf(iTipoFlujo = 1, miForm.C_Tasa.Text, miForm.Tasa.Text) / 100#
                 SwapCarteraREC.Cartera_Swap(Indicador).Spread = CDbl(0#) 'CDbl(MiGrillaaux.TextMatrix(iNumeroFlujos, 24))
                 SwapCarteraREC.Cartera_Swap(Indicador).Saldo = CDbl(MiGrillaaux.TextMatrix(iNumeroFlujos, 8)) + CDbl(MiGrillaaux.TextMatrix(iNumeroFlujos, 2))
                 SwapCarteraREC.Cartera_Swap(Indicador).Amortizacion = CDbl(MiGrillaaux.TextMatrix(iNumeroFlujos, 2))
                 SwapCarteraREC.Cartera_Swap(Indicador).Flujo_adicional = CDbl(0#) 'CDbl(MiGrillaaux.TextMatrix(iNumeroFlujos, 21))
                 SwapCarteraREC.Cartera_Swap(Indicador).Valor_Mercado_BAC = 0
                 SwapCarteraREC.Cartera_Swap(Indicador).Moneda_Bac = MonedaBac
                 FechaMadurez = IIf(iTipoFlujo = 1, miForm.Madurez.Text, miForm.Madurez.Text)
                 SwapCarteraREC.Cartera_Swap(Indicador).Plazo = DateDiff("D", gsBAC_Fecp, FechaMadurez)
                 
                 'Datos calculados
                 SwapCarteraREC.Cartera_Swap(Indicador).Plazo_ini = 0
                 SwapCarteraREC.Cartera_Swap(Indicador).Plazo_fin = 0
                 SwapCarteraREC.Cartera_Swap(Indicador).Plazo_liq = 0
                 SwapCarteraREC.Cartera_Swap(Indicador).Dias = 0
                 SwapCarteraREC.Cartera_Swap(Indicador).Valor_Mercado = 0
                 'Valor_Simulacion() As Double
                 
                 If SwapCarteraREC.Cartera_Swap(Indicador).Codigo_tasa = 13 Then
                     SwapCarteraREC.Cartera_Swap(Indicador).PlazoFwd = CuentaDias(SwapCarteraREC.Cartera_Swap(Indicador).Fecha_ini _
                     , SwapCarteraREC.Cartera_Swap(Indicador).Fecha_fin _
                     , SwapCarteraREC.Cartera_Swap(Indicador).Convencion _
                     , SwapCarteraREC.Cartera_Swap(Indicador).Base)
                 End If
               
                 Let Indicador = Indicador + 1
            Next
        Next
                  
        Dim ResultadoREC As Double
        Let ResultadoREC = ProcesoCalculoREC(rut, codcli, Det_Cliente_LCR _
                                                   , SwapCarteraREC _
                                                   , "Swap" _
                                                   , Det_Threshold_LCR _
                                                   , Det_Metodologia_LCR _
                                                   , Det_MsgError, Num)
    End If
End Sub



Private Sub Calculorec_Swap(Num As Integer, miForm As Form, rut As Long, codcli As Long)
       
    Dim miClase         As New Swap_OP
    Dim iNumeroFlujos   As Integer
    Dim iTipoFlujo      As Integer
    Dim MiGrilla        As MSFlexGrid
    Dim MonedaBac       As Integer
    Dim Convencion      As Integer
    Dim Base            As Integer
    Dim PlazoFwd        As Integer
    Dim CodigoTasa      As Long
    Dim TipoSwap        As Integer
    Dim FechaInicioFlujo As Date
    Dim Det_Threshold_LCR   As Double
    Dim Det_Metodologia_LCR As Integer
    Dim Det_Cliente_LCR     As String
    Dim Det_MsgError        As String
    Dim FechaMadurez        As Date
    Screen.MousePointer = vbHourglass
    Dim ResultadoREC As Double
    Dim SwapCarteraREC As Negociacion
    
    
    'PROD-10967
    Det_Metodologia_LCR = miForm.Swap_Op_Metodologia_LCR
    Det_Threshold_LCR = miForm.Swap_Op_Threshold_LCR
    Det_Cliente_LCR = miForm.Swap_Op_Cliente_LCR
   
    If Det_Metodologia_LCR <> 1 And Det_Metodologia_LCR <> 4 Then
        Dim Indicador As Long
        Let Indicador = 0
        For iTipoFlujo = 1 To 2
            Set MiGrillaaux = IIf(iTipoFlujo = 1, miForm.I_Grid, miForm.D_Grid)
            For iNumeroFlujos = 1 To MiGrillaaux.Rows - 1
                'POR HACER: donde esta el tipo de dato en comentario
                ' se debe llamar a una funcion para que obtenga
                ' los valores
                ReDim Preserve SwapCarteraREC.Cartera_Swap(Indicador)
                SwapCarteraREC.Cartera_Swap(Indicador).rut = rut
                SwapCarteraREC.Cartera_Swap(Indicador).Codigo = codcli
                SwapCarteraREC.Cartera_Swap(Indicador).Numero_Operacion = 0 'miClase.A01_NumeroOperacion
                SwapCarteraREC.Cartera_Swap(Indicador).Numero_flujo = iNumeroFlujos
                SwapCarteraREC.Cartera_Swap(Indicador).Tipo_flujo = iTipoFlujo
                SwapCarteraREC.Cartera_Swap(Indicador).Tipo_swap = EntregaTipoSwap(miForm)
                SwapCarteraREC.Cartera_Swap(Indicador).Modalidad_pago = Left(miForm.Modalidad, 1)
                SwapCarteraREC.Cartera_Swap(Indicador).Cartera = 0 'As Long para siempre
               
                MonedaBac = IIf(iTipoFlujo = 1 _
                          , miForm.I_Moneda.ItemData(miForm.I_Moneda.ListIndex) _
                          , miForm.D_Moneda.ItemData(miForm.D_Moneda.ListIndex))
                
                SwapCarteraREC.Cartera_Swap(Indicador).Moneda = Func_Riesgo_Financiero(MonedaBac)
                'If ParamMoneda_LCR = True Then
                    'ParamMoneda_LCR = False
                    'Exit Sub
                'End If
                SwapCarteraREC.Cartera_Swap(Indicador).Codigo_tasa = IIf(iTipoFlujo = 1, _
                            miForm.I_Indicador.ItemData(miForm.I_Indicador.ListIndex), _
                            miForm.D_Indicador.ItemData(miForm.D_Indicador.ListIndex))
                
                Convencion = IIf(iTipoFlujo = 1 _
                           , miForm.I_ConteoDias.ItemData(miForm.I_ConteoDias.ListIndex) _
                           , miForm.D_ConteoDias.ItemData(miForm.D_ConteoDias.ListIndex))
                
                SwapCarteraREC.Cartera_Swap(Indicador).Convencion = Func_TipoConvencio(Convencion)     '"P"  ' As String
                
                Base = IIf(iTipoFlujo = 1 _
                        , miForm.I_ConteoDias.ItemData(miForm.I_ConteoDias.ListIndex) _
                        , miForm.D_ConteoDias.ItemData(miForm.D_ConteoDias.ListIndex))
                
                SwapCarteraREC.Cartera_Swap(Indicador).Base = Func_BaseSwap(Base)   ' 360 'As Long
                
                PlazoFwd = IIf(iTipoFlujo = 1 _
                        , miForm.I_Indicador.ItemData(miForm.I_Indicador.ListIndex) _
                        , miForm.D_Indicador.ItemData(miForm.D_Indicador.ListIndex))
                
                SwapCarteraREC.Cartera_Swap(Indicador).PlazoFwd = Func_BaseForward(PlazoFwd)   '180 'As Long
                
                SwapCarteraREC.Cartera_Swap(Indicador).IndexLag = IIf(iTipoFlujo = 1 _
                                        , miForm.I_DiasReset.Text, miForm.D_DiasReset.Text)
                
                If iTipoFlujo = 1 Then
                  SwapCarteraREC.Cartera_Swap(Indicador).Fecha_ini = IIf(iNumeroFlujos = 1, miForm.I_FechaEfectiva.Text _
                                                      , Format(MiGrillaaux.TextMatrix(iNumeroFlujos - 1, 1), "dd/mm/yyyy"))
                Else
                  SwapCarteraREC.Cartera_Swap(Indicador).Fecha_ini = IIf(iNumeroFlujos = 1, miForm.D_FechaEfectiva.Text _
                                                      , Format(MiGrillaaux.TextMatrix(iNumeroFlujos - 1, 1), "dd/mm/yyyy"))
                End If
                                
                SwapCarteraREC.Cartera_Swap(Indicador).Fecha_fin = Format(MiGrillaaux.TextMatrix(iNumeroFlujos, 1), "dd/mm/yyyy")
                SwapCarteraREC.Cartera_Swap(Indicador).Fecha_fija = Format(MiGrillaaux.TextMatrix(iNumeroFlujos, 16), "dd/mm/yyyy")
                SwapCarteraREC.Cartera_Swap(Indicador).Fecha_liq = Format(MiGrillaaux.TextMatrix(iNumeroFlujos, 14), "dd/mm/yyyy") ' As Date
                
                CodigoTasa = SwapCarteraREC.Cartera_Swap(Indicador).Codigo_tasa
                TipoSwap = SwapCarteraREC.Cartera_Swap(Indicador).Tipo_swap
                SwapCarteraREC.Cartera_Swap(Indicador).Codigo_descuento = Func_CodigoDescuento(MonedaBac, CodigoTasa, TipoSwap, 1) '0 'As Long
                'If ParamMoneda_LCR = True Then
                '    ParamMoneda_LCR = False
                '    Exit Sub
                'End If
                SwapCarteraREC.Cartera_Swap(Indicador).Codigo_forward = Func_CodigoDescuento(MonedaBac, CodigoTasa, TipoSwap, 2) '1 'As Long
                'If ParamMoneda_LCR = True Then
                '    ParamMoneda_LCR = False
                '    Exit Sub
                'End If
                
                SwapCarteraREC.Cartera_Swap(Indicador).Tasa_flujo = CDbl(MiGrillaaux.TextMatrix(iNumeroFlujos, 23)) / 100#
                SwapCarteraREC.Cartera_Swap(Indicador).Spread = CDbl(MiGrillaaux.TextMatrix(iNumeroFlujos, 24)) / 100#
                SwapCarteraREC.Cartera_Swap(Indicador).Saldo = CDbl(MiGrillaaux.TextMatrix(iNumeroFlujos, 8)) + CDbl(MiGrillaaux.TextMatrix(iNumeroFlujos, 2))
                SwapCarteraREC.Cartera_Swap(Indicador).Amortizacion = CDbl(MiGrillaaux.TextMatrix(iNumeroFlujos, 2)) * IIf(MiGrillaaux.TextMatrix(iNumeroFlujos, 19) = "No", 0, 1)
                SwapCarteraREC.Cartera_Swap(Indicador).Flujo_adicional = CDbl(MiGrillaaux.TextMatrix(iNumeroFlujos, 21))
                SwapCarteraREC.Cartera_Swap(Indicador).Valor_Mercado_BAC = 0
                SwapCarteraREC.Cartera_Swap(Indicador).Moneda_Bac = MonedaBac
                
                FechaMadurez = IIf(iTipoFlujo = 1, miForm.I_Madurez.Text, miForm.D_Madurez.Text)
                
                If SwapCarteraREC.Cartera_Swap(Indicador).Tipo_swap <> 2 Then
                    SwapCarteraREC.Cartera_Swap(Indicador).Plazo = DateDiff("D", gsBAC_Fecp, FechaMadurez)
                Else
                    SwapCarteraREC.Cartera_Swap(Indicador).Plazo = DateDiff("D", gsBAC_Fecp, SwapCarteraREC.Cartera_Swap(Indicador).Fecha_fin)
                End If
                'Datos calculados
                SwapCarteraREC.Cartera_Swap(Indicador).Plazo_ini = 0
                SwapCarteraREC.Cartera_Swap(Indicador).Plazo_fin = 0
                SwapCarteraREC.Cartera_Swap(Indicador).Plazo_liq = 0
                SwapCarteraREC.Cartera_Swap(Indicador).Dias = 0
                SwapCarteraREC.Cartera_Swap(Indicador).Valor_Mercado = 0
                'Valor_Simulacion() As Double
                
                If SwapCarteraREC.Cartera_Swap(Indicador).Codigo_tasa = 13 Then
                    SwapCarteraREC.Cartera_Swap(Indicador).PlazoFwd = CuentaDias(SwapCarteraREC.Cartera_Swap(Indicador).Fecha_ini _
                    , SwapCarteraREC.Cartera_Swap(Indicador).Fecha_fin _
                    , SwapCarteraREC.Cartera_Swap(Indicador).Convencion _
                    , SwapCarteraREC.Cartera_Swap(Indicador).Base)
                End If
              
                Let Indicador = Indicador + 1
            Next
        Next
                           
        Let ResultadoREC = ProcesoCalculoREC(rut, codcli, Det_Cliente_LCR _
                                                  , SwapCarteraREC _
                                                  , "Swap" _
                                                  , Det_Threshold_LCR _
                                                  , Det_Metodologia_LCR _
                                                  , Det_MsgError, Num)
    End If
End Sub


Private Sub Habilitacontroles()
    lblExpMax.Visible = False
    txtExpMax.Visible = False
End Sub
Private Sub Form_Load()
    
    Grd_Datos.Rows = 1
    Screen.MousePointer = vbDefault
    Call Habilitacontroles
    
   
    Grd_Datos.Rows = 1
    Calculorec 6
    Call Habilitacontroles
    Screen.MousePointer = vbDefault
    EjecutaBtnREC = True
  
 End Sub

Private Sub Calculorec(Num As Integer)
    Screen.MousePointer = vbDefault
    Dim rut As Long
    Dim codcli As Long
    
   
    rut = RutSinDV(BacGrabar.TxtRut.Text)
    codcli = CInt(BacGrabar.txtCliente.Tag)
    
    If BacGrabar.MiFormulario = "Nuevo Swap" Then
        
        Calculorec_Swap Num, FRM_SWAP_OP, rut, codcli
    
    ElseIf BacGrabar.MiFormulario = "Nuevo Fra" Then
        
        Calculorec_Fra Num, FRM_SWAP_OP_FRA, rut, codcli
    
    End If
                                
End Sub


Public Function EntregaTipoSwap(miForm As Form) As Integer
   If miForm.I_Moneda.ListIndex = -1 Or miForm.D_Moneda.ListIndex = -1 Then
      MsgBox "Debe seleccionar ambas monedas antes de prosegir.", vbInformation, TITSISTEMA
      EntregaTipoSwap = -1
   End If
   If miForm.I_Moneda.ItemData(miForm.I_Moneda.ListIndex) <> miForm.D_Moneda.ItemData(miForm.D_Moneda.ListIndex) Then
      EntregaTipoSwap = 2    '--> Swap de Monedas      CCS
   Else
      If miForm.I_Indicador.ItemData(miForm.I_Indicador.ListIndex) = 13 Or miForm.D_Indicador.ItemData(miForm.D_Indicador.ListIndex) = 13 Then
         EntregaTipoSwap = 4 '--> Swap Promedio Camara ICP
      Else
         EntregaTipoSwap = 1 '--> Swap de Tasas        IRF
      End If
   End If
End Function
Private Sub Carga_Grilla_Threshold()
    Dim DATOS()
    Dim iRut As Long
    Dim iCodigo As Integer
    iRut = RutSinDV(BacGrabar.TxtRut.Text)
    iCodigo = CInt(BacGrabar.txtCliente.Tag)
    iCliente = BacGrabar.txtCliente.Text
    
    With Grd_Datos
        .Rows = 2:          .FixedRows = 1
        .Cols = 13:         .FixedCols = 0
    
        .Font.Name = "Tahoma"
        .Font.Size = 8
        .RowHeightMin = 315
        .TextMatrix(0, 0) = "Rut"
        .TextMatrix(0, 1) = "Codigo"
        .TextMatrix(0, 2) = "Threshold"
        .TextMatrix(0, 3) = "Metodologia"
        .TextMatrix(0, 4) = "Cliente"
        .TextMatrix(0, 5) = ""
        .TextMatrix(0, 6) = ""
        .TextMatrix(0, 7) = ""
        .TextMatrix(0, 8) = ""
        .TextMatrix(0, 9) = ""
        .TextMatrix(0, 10) = ""
        .TextMatrix(0, 11) = ""
        .TextMatrix(0, 12) = ""
               
        .ColWidth(0) = 1500
        .ColWidth(1) = 1500
        .ColWidth(2) = 1500
        .ColWidth(3) = 1500
        .ColWidth(4) = 2000
        .ColWidth(5) = 0
        .ColWidth(6) = 0
        .ColWidth(7) = 0
        .ColWidth(8) = 0
        .ColWidth(9) = 0
        .ColWidth(10) = 0
        .ColWidth(11) = 0
        .ColWidth(12) = 0
        .Rows = .Rows - 1
              
        .Rows = .Rows + 1
           
            .TextMatrix(.Rows - 1, 0) = iRut
            .TextMatrix(.Rows - 1, 1) = iCodigo
            If BacGrabar.MiFormulario = "Nuevo Swap" Then
                .TextMatrix(.Rows - 1, 2) = FRM_SWAP_OP.Swap_Op_Threshold_LCR
                .TextMatrix(.Rows - 1, 3) = FRM_SWAP_OP.Swap_Op_Metodologia_LCR
            ElseIf BacGrabar.MiFormulario = "Nuevo Fra" Then
                .TextMatrix(.Rows - 1, 2) = FRM_SWAP_OP_FRA.Fra_Threshold_LCR
                .TextMatrix(.Rows - 1, 3) = FRM_SWAP_OP_FRA.Fra_Metodologia_LCR
            End If
            .TextMatrix(.Rows - 1, 4) = iCliente
            
        If .Rows > 1 Then
            .AllowUserResizing = flexResizeColumns
        Else
            .AllowUserResizing = flexResizeNone
        End If
        
        For nContador = 0 To .Cols - 1
            .Row = 0
            .Col = nContador
            .TextStyle = TextStyleHeader
            .CellAlignment = flexAlignCenterCenter
            .WordWrap = True
        Next nContador
    End With
End Sub
Private Function RutSinDV(ByVal recRut As String) As String
Dim p As Integer
Dim l As Integer
Dim i As Integer
Dim xRut As String
RutSinDV = ""
xRut = Trim(recRut)
l = Len(xRut)
p = 0
For i = l To 1 Step -1
    If Mid$(xRut, i, 1) = "-" Then
        p = i
        Exit For
    End If
Next
If p = 0 Then
    RutSinDV = xRut
Else
    RutSinDV = Mid$(xRut, 1, p - 1)
End If
End Function
Private Sub Proc_Genera_Excel()
   On Error GoTo ErrorAction
   Dim i  As Long
   Dim cFile      As String
   Dim nFilas     As Long
   Dim MiFila     As Long
   Dim MiSheet    As Object
   Dim Respalda   As Boolean
   Dim DATOS()
   Dim MiExcell As Object
   
   Respalda = False
   
   If Grd_Datos.Rows = 1 Then
        MsgBox "No existen datos a exportar", vbInformation
        Exit Sub
   End If
   
   Screen.MousePointer = vbHourglass
   cFile = App.Path & "\RescataCartera.xlsx"
   cFile = "Vaciado.xlsx"
   Command.Filter = ".xlsx"
   Command.CancelError = True

   Set MiExcell = CreateObject("Excel.Application")
   MiExcell.Application.Workbooks.Close
   Set MiLibro = MiExcell.Application.Workbooks.Add
   Set MiHoja = MiLibro.Sheets.Add
   Set MiSheet = MiExcell.Worksheets(1) '--> MiExcell.ActiveSheet
   MiSheet.Name = "Carteras"
   
   MiExcell.DisplayAlerts = False
   Call MiExcell.Worksheets(3).Delete
   Call MiExcell.Worksheets(2).Delete
   MiExcell.DisplayAlerts = True
      
    With Grd_Datos
        Num_Flujos = .Rows - 1
        For i = 0 To Num_Flujos
            If Num_Flujos > 0 Then
                Let MiFila = MiFila + 1
                If i = 0 Then
                    MiHoja.Cells(MiFila, 1) = .TextMatrix(i, 0)
                ElseIf Opt_Opcion(4).Value = True Or _
                       Opt_Opcion(7).Value = True Or _
                       Opt_Opcion(6).Value = True Then
                       
                    MiHoja.Cells(MiFila, 1) = CDate(.TextMatrix(i, 0))
                
                Else
                    MiHoja.Cells(MiFila, 1) = .TextMatrix(i, 0)
                End If
                
                    MiHoja.Cells(MiFila, 2) = .TextMatrix(i, 1)
                    MiHoja.Cells(MiFila, 3) = .TextMatrix(i, 2)
                    MiHoja.Cells(MiFila, 4) = .TextMatrix(i, 3)
                    MiHoja.Cells(MiFila, 5) = .TextMatrix(i, 4)
                    MiHoja.Cells(MiFila, 6) = .TextMatrix(i, 5)
                    MiHoja.Cells(MiFila, 7) = .TextMatrix(i, 6)
                    MiHoja.Cells(MiFila, 8) = .TextMatrix(i, 7)
                    MiHoja.Cells(MiFila, 9) = .TextMatrix(i, 8)
                    MiHoja.Cells(MiFila, 10) = .TextMatrix(i, 10)
                    MiHoja.Cells(MiFila, 11) = .TextMatrix(i, 11)
                    MiHoja.Cells(MiFila, 12) = .TextMatrix(i, 12)
            End If
        Next
    End With
     
   Call BacControlWindows(10)
   Screen.MousePointer = vbDefault
   MiExcell.DisplayAlerts = True
   On Error GoTo ErrorAction
   Command.CancelError = True
   Command.FileName = cFile
   
   Call Command.ShowSave
   
  MiExcell.DisplayAlerts = True
  
   Call MiHoja.SaveAs(Command.FileName)
   
   Screen.MousePointer = vbHourglass
    
   If Respalda = False Then
      Call MsgBox("Proceso Finalizado" & vbCrLf & vbCrLf & "Archivo ha sido almacenado en la ruta : " & vbCrLf & Command.FileName, vbInformation, App.Title)
   End If
     
   MiExcell.Visible = True
  
   Set MiSheet = Nothing
   Set MiHoja = Nothing
   Set MiLibro = Nothing
   Set MiExcell = Nothing
   
  'Call MiLibro.Close
   
   Let Screen.MousePointer = vbDefault
   On Error GoTo 0

Exit Sub
ErrorAction:
   Screen.MousePointer = vbDefault
   
 If err.Number = 32755 Then
    MiExcell.DisplayAlerts = False
    MiExcell.Application.Quit
      Set MiSheet = Nothing
      Set MiHoja = Nothing
     'Call MiLibro.Close
      Set MiLibro = Nothing
      Set MiExcell = Nothing
      'MiExcell.Application.Quit
 Else
   
   If err.Number = 70 Then
            
        MiExcell.Application.DisplayAlerts = False
        
        Call MiExcell.Application.Workbooks.Close
        MiExcell.Application.Quit
        If MsgBox("Error de Escritura..." & vbCrLf & "Archivo se encuentra protegido contra escritura o bien esta en uso ... Reintentar ?", vbQuestion + vbYesNo, App.Title) = vbYes Then
            
            Resume
        Else
            Respalda = True
            Exit Sub
            Resume
            Exit Sub
        End If
    End If
       If err.Number = 1004 Then
        If MsgBox("Error de Escritura..." & vbCrLf & "Archivo existe, se encuentra protegido contra escritura o bien esta en uso ... Reintentar ?", vbQuestion + vbYesNo, App.Title) = vbYes Then
            
            Resume
        Else
            Respalda = True
            MiExcell.Application.DisplayAlerts = False
            MiLibro.Application.Workbooks.Close
            MiExcell.Application.Quit
            Screen.MousePointer = vbdefaul
            Exit Sub
        End If
             
       End If
      
      If err.Number <> 0 Then
         Call MsgBox("Error en la carga de archivo" & vbCrLf & vbCrLf & err.Description, vbExclamation, App.Title)
         Screen.MousePointer = vbDefault
         MiExcell.DisplayAlerts = False
         MiExcell.Application.Quit
      End If
   End If
   
End Sub

Private Sub Opt_Opcion_Click(Index As Integer)
    Dim Opc As Integer
    If Opt_Opcion(0).Value = True Then
        Grd_Datos.Rows = 1
        Calculorec 1
        Screen.MousePointer = vbDefault
        EjecutaBtnREC = True
    ElseIf Opt_Opcion(2).Value = True Then
        Grd_Datos.Rows = 1
        Call Carga_Grilla_Threshold
        Call Habilitacontroles
        Screen.MousePointer = vbDefault
        EjecutaBtnREC = True
    ElseIf Opt_Opcion(3).Value = True Then
        Grd_Datos.Rows = 1
        Calculorec 3
        Call Habilitacontroles
        EjecutaBtnREC = True
        Screen.MousePointer = vbDefault
    ElseIf Opt_Opcion(4).Value = True Then
        Grd_Datos.Rows = 1
        Calculorec 4
        Screen.MousePointer = vbDefault
        EjecutaBtnREC = True
    ElseIf Opt_Opcion(6).Value = True Then
        Grd_Datos.Rows = 1
        Calculorec 6
        Call Habilitacontroles
        Screen.MousePointer = vbDefault
        EjecutaBtnREC = True
    ElseIf Opt_Opcion(7).Value = True Then
        Grd_Datos.Rows = 1
        Calculorec 7
        Call Habilitacontroles
        Screen.MousePointer = vbDefault
        EjecutaBtnREC = True
    End If
End Sub
Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
     Select Case (Button.Key)
        Case "Generar"
              
              Call Proc_Genera_Excel
        Case "Salir"
           Unload Me
           Exit Sub
    End Select
End Sub

