VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacSwapFechaLiquidacion 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Corregir fecha de Liquidación "
   ClientHeight    =   8520
   ClientLeft      =   45
   ClientTop       =   375
   ClientWidth     =   14640
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   8520
   ScaleWidth      =   14640
   Begin VB.Frame FrameOperaciones 
      Caption         =   "Operaciones"
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
      Height          =   7995
      Left            =   0
      TabIndex        =   1
      Top             =   480
      Width           =   14535
      Begin VB.CommandButton btnPreliquidacion 
         Height          =   255
         Left            =   4200
         TabIndex        =   10
         Top             =   1440
         Visible         =   0   'False
         Width           =   735
      End
      Begin VB.CheckBox Check_Incluye_Liquidacion 
         Caption         =   "Incluye Liquidaciones en días hábiles"
         Height          =   255
         Left            =   6240
         TabIndex        =   3
         Top             =   480
         Width           =   3015
      End
      Begin VB.CheckBox Check_LIQUIDACION_CHECK_USA 
         Height          =   255
         Left            =   3840
         TabIndex        =   2
         Top             =   1440
         Width           =   255
      End
      Begin BACControles.TXTFecha TXTFechaPropuesta 
         Height          =   255
         Left            =   2520
         TabIndex        =   4
         Top             =   1440
         Width           =   1215
         _ExtentX        =   2143
         _ExtentY        =   450
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
         Text            =   "26-02-2015"
      End
      Begin BACControles.TXTFecha txtFechaOperacionHasta 
         Height          =   375
         Left            =   4320
         TabIndex        =   5
         Top             =   600
         Width           =   1455
         _ExtentX        =   2566
         _ExtentY        =   661
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
         Text            =   "26-02-2015"
      End
      Begin MSFlexGridLib.MSFlexGrid Gr_Operacion 
         Height          =   6855
         Left            =   120
         TabIndex        =   6
         Top             =   1080
         Width           =   14280
         _ExtentX        =   25188
         _ExtentY        =   12091
         _Version        =   393216
         Rows            =   3
         FixedRows       =   2
         FixedCols       =   0
         RowHeightMin    =   2
         BackColor       =   16777215
         AllowBigSelection=   -1  'True
         ScrollTrack     =   -1  'True
         HighLight       =   0
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Courier New"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin BACControles.TXTFecha txtFechaOperacionDesde 
         Height          =   330
         Left            =   4320
         TabIndex        =   7
         Top             =   240
         Width           =   1455
         _ExtentX        =   2566
         _ExtentY        =   582
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
         Text            =   "15/06/2001"
      End
      Begin VB.Label LblFechaBusqueda 
         AutoSize        =   -1  'True
         Caption         =   "Fecha Busqueda Desde"
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
         Index           =   7
         Left            =   2160
         TabIndex        =   9
         Top             =   240
         Width           =   2040
      End
      Begin VB.Label LblFechaBusquedaHasta 
         AutoSize        =   -1  'True
         Caption         =   "Fecha Busqueda Hasta"
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
         Left            =   2160
         TabIndex        =   8
         Top             =   720
         Width           =   1995
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   14640
      _ExtentX        =   25823
      _ExtentY        =   794
      ButtonWidth     =   1931
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      Style           =   1
      TextAlignment   =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   5
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Buscar"
            Key             =   "BUSCAR"
            Object.ToolTipText     =   "Genera busqueda"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Grabar"
            Key             =   "Grabar"
            Description     =   "Grabar"
            Object.ToolTipText     =   "Grabar Operaciones"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Limpiar"
            Key             =   "Limpiar"
            Object.ToolTipText     =   "Genera una vista previa del informe."
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.Visible         =   0   'False
            Caption         =   "Imprimir "
            Key             =   "IMPRIMIR"
            Object.ToolTipText     =   "Envía directamente el informe a la impresora."
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Cerrar "
            Key             =   "CERRAR"
            Object.ToolTipText     =   "Cerrar ventana."
            ImageIndex      =   5
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   6225
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
               Picture         =   "BacSwapFechaLiquidacion.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacSwapFechaLiquidacion.frx":0EDA
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacSwapFechaLiquidacion.frx":1DB4
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacSwapFechaLiquidacion.frx":2C8E
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacSwapFechaLiquidacion.frx":3B68
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacSwapFechaLiquidacion.frx":3E82
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
End
Attribute VB_Name = "BacSwapFechaLiquidacion"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim I_i%
Dim Fila#
Dim FechaProceso
Dim cuenta#

'OPERACION
Const C_CORRELATIVO = 0
Const C_OPERACION = 1
Const C_NUMERO_FLUJO = 2
Const C_NOMBRE_CLIENTE = 3
Const C_TIPO_CLIENTE = 4
Const C_PAIS_CLIENTE = 5
Const C_TIPO_TASA = 6
Const C_CHECK_USA = 7
Const C_CHECK_ING = 8
Const C_CHECK_SCL = 9
Const C_FECHA_LIQUIDACION = 10
Const C_LIQUIDACION_CHECK_USA = 11
Const C_LIQUIDACION_CHECK_ING = 12
Const C_LIQUIDACION_CHECK_SCL = 13
Const C_FECHA_PROPUESTA_LIQUIDACION = 14
Const C_AUTORIZA_CHECK = 15
Const C_PROPUESTA_CHECK_USA = 16
Const C_PROPUESTA_CHECK_ING = 17
Const C_PROPUESTA_CHECK_SCL = 18
Const C_RUT_CLIENTE = 19
Const C_TIPO_FLUJO = 20
Const C_FECHA_PROCESO = 21
Const C_PRE_LIQUIDACION = 22

Const strUnChecked = "q"
Const strChecked = "þ"

Public NumOperacion
Public FecPropuesta

'''Private Sub btnPreliquidacion_Click()
'''    NumOperacion = Gr_Operacion.TextMatrix(Gr_Operacion.Row, 1)
'''    FecPropuesta = Gr_Operacion.TextMatrix(Gr_Operacion.Row, 14)
    
'''    BacSwapFechaPreLiquidacion.Show
'''End Sub

Private Sub Form_Activate()
    TXTFechaPropuesta.Visible = False
    Check_LIQUIDACION_CHECK_USA.Visible = False
    '''btnPreliquidacion.Visible = False

End Sub

Private Sub Form_Load()
On Error GoTo Error_Form_Load

    txtFechaOperacionDesde.MinDate = DateAdd("d", 1, Format(gsBAC_Fecp, gsc_FechaDMA))
    txtFechaOperacionDesde.Text = DateAdd("d", 1, Format(gsBAC_Fecp, gsc_FechaDMA))

    txtFechaOperacionHasta.MinDate = DateAdd("d", 1, Format(gsBAC_Fecp, gsc_FechaDMA))
    SQL = ""
    SQL = "EXEC BACPARAMSUDA.DBO.SP_MUESTRAFECHAVALIDA " & "'" & Format(DateAdd("d", 2, Format(gsBAC_Fecp, gsc_FechaDMA)), "yyyymmdd") & "','" & ";6;255;510;" & "'"
    If MISQL.SQL_Execute(SQL) <> 0 Then
        MsgBox "¡No se encuentran datos Principales de la Entidad!", vbCritical, Msj
        Exit Sub
    End If

    Do While MISQL.SQL_Fetch(Datos()) = 0
        txtFechaOperacionHasta.Text = Datos(1)
    Loop

    Me.Left = 0
    Me.Top = 0
    Call PROC_LIMPIA_DATOS
Exit Sub
Error_Form_Load:
    Select Case err.Number
        Case 53
            Resume Next
        Case Else
            Call MsgBox("Error número: " & err.Number & Chr(10) & "Descripción: " & err.Description, vbCritical)
    End Select
    Screen.MousePointer = 0
End Sub

Sub PROC_LLENA_GRILLA_OPERACIONES()
Dim i#
Dim check_incluye_dia_habil As Integer
    check_incluye_dia_habil = Me.Check_Incluye_Liquidacion.Value
    SQL = ""
    SQL = "SP_BUSCAR_CARTERA_FECHA_LIQUIDACION " & "'" & Format(txtFechaOperacionDesde.Text, "yyyymmdd") & "','" & Format(txtFechaOperacionHasta.Text, "yyyymmdd") & "'," & check_incluye_dia_habil
    If MISQL.SQL_Execute(SQL) <> 0 Then
        MsgBox "¡No se encuentran datos Principales de la Entidad!", vbCritical, Msj
        Exit Sub
    End If
    I_i = 2
    Fila = 2
    cuenta = 1
    Do While MISQL.SQL_Fetch(Datos()) = 0
        If I_i >= Gr_Operacion.Rows - 1 Then Gr_Operacion.AddItem ""
  
        I_i = I_i + 1
        Gr_Operacion.Rows = I_i
        Gr_Operacion.TextMatrix(Fila, C_CORRELATIVO) = cuenta
        Gr_Operacion.TextMatrix(Fila, C_OPERACION) = Trim(Datos(1))
        Gr_Operacion.TextMatrix(Fila, C_NUMERO_FLUJO) = Trim(Datos(2))
        Gr_Operacion.TextMatrix(Fila, C_NOMBRE_CLIENTE) = Trim(Datos(3))
        Gr_Operacion.TextMatrix(Fila, C_TIPO_CLIENTE) = Trim(Datos(4))
        Gr_Operacion.TextMatrix(Fila, C_PAIS_CLIENTE) = Trim(Datos(5))
        Gr_Operacion.TextMatrix(Fila, C_TIPO_TASA) = Trim(Datos(6))
    
        Gr_Operacion.TextMatrix(Fila, C_CHECK_USA) = Trim(Datos(7))
        Call editarCheck(Gr_Operacion, Check_LIQUIDACION_CHECK_USA, 7, I_i, Trim(Datos(7)))
    
        Gr_Operacion.TextMatrix(Fila, C_CHECK_ING) = Trim(Datos(8))
        Call editarCheck(Gr_Operacion, Check_LIQUIDACION_CHECK_USA, 8, I_i, Trim(Datos(8)))
    
        Gr_Operacion.TextMatrix(Fila, C_CHECK_SCL) = Trim(Datos(9))
        Call editarCheck(Gr_Operacion, Check_LIQUIDACION_CHECK_USA, 9, I_i, Trim(Datos(9)))
    
        Gr_Operacion.TextMatrix(Fila, C_FECHA_LIQUIDACION) = Trim(Format(Datos(10), "dd/mm/yyyy"))
    
        Gr_Operacion.TextMatrix(Fila, C_LIQUIDACION_CHECK_USA) = Trim(Datos(11))
        Call editarCheck(Gr_Operacion, Check_LIQUIDACION_CHECK_USA, 11, I_i, Trim(Datos(11)))
        
        Gr_Operacion.TextMatrix(Fila, C_LIQUIDACION_CHECK_ING) = Trim(Datos(12))
        Call editarCheck(Gr_Operacion, Check_LIQUIDACION_CHECK_USA, 12, I_i, Trim(Datos(12)))
    
        Gr_Operacion.TextMatrix(Fila, C_LIQUIDACION_CHECK_SCL) = Trim(Datos(13))
        Call editarCheck(Gr_Operacion, Check_LIQUIDACION_CHECK_USA, 13, I_i, Trim(Datos(13)))
    
        Gr_Operacion.TextMatrix(Fila, C_FECHA_PROPUESTA_LIQUIDACION) = Trim(Format(Datos(14), "dd/mm/yyyy"))
    
        Gr_Operacion.TextMatrix(Fila, C_AUTORIZA_CHECK) = 0
        Call editarCheck(Gr_Operacion, Check_LIQUIDACION_CHECK_USA, 15, I_i, 0)
    
        Gr_Operacion.TextMatrix(Fila, C_PROPUESTA_CHECK_USA) = Trim(Datos(15))
        Call editarCheck(Gr_Operacion, Check_LIQUIDACION_CHECK_USA, 16, I_i, Trim(Datos(15)))
    
        Gr_Operacion.TextMatrix(Fila, C_PROPUESTA_CHECK_ING) = Trim(Datos(16))
        Call editarCheck(Gr_Operacion, Check_LIQUIDACION_CHECK_USA, 17, I_i, Trim(Datos(16)))
    
        Gr_Operacion.TextMatrix(Fila, C_PROPUESTA_CHECK_SCL) = Trim(Datos(17))
        Call editarCheck(Gr_Operacion, Check_LIQUIDACION_CHECK_USA, 18, I_i, Trim(Datos(17)))
    
        Gr_Operacion.TextMatrix(Fila, C_RUT_CLIENTE) = Trim(Datos(18))
        Gr_Operacion.TextMatrix(Fila, C_TIPO_FLUJO) = Trim(Datos(19))
        Gr_Operacion.TextMatrix(Fila, C_FECHA_PROCESO) = Trim(Datos(20))
        
        '''Call CREA_BOTON(I_i)
        Fila = Fila + 1
        cuenta = cuenta + 1
    
    Loop

    Call PintaColumna
End Sub

'''Sub CREA_BOTON(Fila As Integer)

'''With Gr_Operacion
'''    .Col = 22
'''    .Row = Fila - 2
'''    If .Col = 22 Then
'''        btnPreliquidacion.Visible = True
'''    End If
    
'''End With
'''End Sub

Public Sub editarboton(grilla As MSFlexGrid, Control As Control, columna As Integer, Fila As Integer)
    With Gr_Operacion
        .Col = columna
        .Row = Fila - 1
        Call PROC_POSICIONA_TEXTO(grilla, Control)
        Control.Visible = True
        Control.Enabled = True
    End With
End Sub

Public Sub editarCheck(grilla As MSFlexGrid, _
                       Control As Control, _
                       columna As Integer, _
                       fila_ As Integer, _
                       datos_ As Integer)
    With Gr_Operacion
        .Col = columna
        Call PROC_POSICIONA_TEXTO(grilla, Control)
        .Col = columna
        .Row = fila_ - 1
        .CellFontName = "Wingdings"
        .CellFontSize = 14
        .CellAlignment = flexAlignCenterCenter
        If datos_ = 0 Then
            Gr_Operacion.Text = strUnChecked
        Else
            Gr_Operacion.Text = strChecked
            If columna = 11 Or columna = 12 Or columna = 13 Then
                Call PintaCelda_Feriado(fila_, columna)
            End If
        End If
    End With
End Sub

Public Sub editarCheck_Propuesta(grilla As MSFlexGrid, _
                       Control As Control, _
                       columna As Integer, _
                       fila_ As Integer, _
                       datos_ As Integer)
    With Gr_Operacion
        .Col = columna
        Call PROC_POSICIONA_TEXTO(grilla, Control)
        .Col = columna

        .CellFontName = "Wingdings"
        .CellFontSize = 14
        .CellAlignment = flexAlignCenterCenter
        If datos_ = 0 Then
            Gr_Operacion.Text = strUnChecked
            'Call PintaCelda_NOFeriado(fila_, columna)
        Else
            Gr_Operacion.Text = strChecked
            'Call PintaCelda_Feriado(fila_, columna)
            
        End If
    End With
End Sub

'''Private Sub Gr_Operacion_EnterCell()
'''With Gr_Operacion
'''    If .Col = 22 Then
'''        btnPreliquidacion.Move .Left + .CellLeft, .Top + .CellTop, .CellWidth - 8, .CellHeight - 8
'''        btnPreliquidacion.Visible = True
'''    End If
'''End With
'''End Sub

'''Private Sub Gr_Operacion_LeaveCell()
'''    If Gr_Operacion.Rows > 3 Then
'''        btnPreliquidacion.Visible = True
'''    End If
'''End Sub

Private Sub Gr_Operacion_Scroll()
    TXTFechaPropuesta.Visible = False
End Sub

Private Sub OK_Click()
    Screen.MousePointer = 11
    Call PROC_CREA_GRILLA_OPERACIONES
    Call PROC_LLENA_GRILLA_OPERACIONES
    Call PintaColumna
    Screen.MousePointer = 0
End Sub

Sub PROC_CREA_GRILLA_OPERACIONES()
    With Gr_Operacion
        .Rows = 3
        '''.Cols = 23
        .Cols = 22
        
        .ColWidth(C_CORRELATIVO) = 700
        .ColWidth(C_OPERACION) = 1000
        .ColWidth(C_NUMERO_FLUJO) = 1500
        .ColWidth(C_NOMBRE_CLIENTE) = 4000
        .ColWidth(C_TIPO_CLIENTE) = 2000
        .ColWidth(C_PAIS_CLIENTE) = 2000
        .ColWidth(C_TIPO_TASA) = 2000
        .ColWidth(C_CHECK_USA) = 700
        .ColWidth(C_CHECK_ING) = 700
        .ColWidth(C_CHECK_SCL) = 700
        .ColWidth(C_FECHA_LIQUIDACION) = 1900
        .ColWidth(C_LIQUIDACION_CHECK_USA) = 700
        .ColWidth(C_LIQUIDACION_CHECK_ING) = 700
        .ColWidth(C_LIQUIDACION_CHECK_SCL) = 700
        .ColWidth(C_FECHA_PROPUESTA_LIQUIDACION) = 1800
        .ColWidth(C_AUTORIZA_CHECK) = 2000
        .ColWidth(C_PROPUESTA_CHECK_USA) = 700
        .ColWidth(C_PROPUESTA_CHECK_ING) = 700
        .ColWidth(C_PROPUESTA_CHECK_SCL) = 700
        .ColWidth(C_RUT_CLIENTE) = 1
        .ColWidth(C_TIPO_FLUJO) = 1
        .ColWidth(C_FECHA_PROCESO) = 1
        '''.ColWidth(C_PRE_LIQUIDACION) = 300
                    
        .ColAlignment(C_CORRELATIVO) = flexAlignLeftCenter
        .ColAlignment(C_OPERACION) = flexAlignLeftCenter
        .ColAlignment(C_NUMERO_FLUJO) = flexAlignLeftCenter
        .ColAlignment(C_NOMBRE_CLIENTE) = flexAlignLeftCenter
        .ColAlignment(C_TIPO_CLIENTE) = flexAlignLeftCenter
        .ColAlignment(C_PAIS_CLIENTE) = flexAlignLeftCenter
        .ColAlignment(C_TIPO_TASA) = flexAlignLeftCenter
        .ColAlignment(C_CHECK_USA) = flexAlignLeftCenter
        .ColAlignment(C_CHECK_ING) = flexAlignLeftCenter
        .ColAlignment(C_CHECK_SCL) = flexAlignLeftCenter
        .ColAlignment(C_FECHA_LIQUIDACION) = flexAlignLeftCenter
        .ColAlignment(C_LIQUIDACION_CHECK_USA) = flexAlignLeftCenter
        .ColAlignment(C_LIQUIDACION_CHECK_ING) = flexAlignLeftCenter
        .ColAlignment(C_LIQUIDACION_CHECK_SCL) = flexAlignLeftCenter
        .ColAlignment(C_FECHA_PROPUESTA_LIQUIDACION) = flexAlignLeftCenter
        .ColAlignment(C_AUTORIZA_CHECK) = flexAlignLeftCenter
        .ColAlignment(C_PROPUESTA_CHECK_USA) = flexAlignLeftCenter
        .ColAlignment(C_PROPUESTA_CHECK_ING) = flexAlignLeftCenter
        .ColAlignment(C_PROPUESTA_CHECK_SCL) = flexAlignLeftCenter
        .ColAlignment(C_RUT_CLIENTE) = flexAlignLeftCenter
        .ColAlignment(C_TIPO_FLUJO) = flexAlignLeftCenter
        .ColAlignment(C_FECHA_PROCESO) = flexAlignLeftCenter
        '''.ColAlignment(C_PRE_LIQUIDACION) = flexAlignLeftCenter
        
        .TextMatrix(1, C_CORRELATIVO) = "N°"
        .TextMatrix(1, C_OPERACION) = "N° Op."
        .TextMatrix(1, C_NUMERO_FLUJO) = "Número Flujo"
        .TextMatrix(1, C_NOMBRE_CLIENTE) = "Nombre Cliente"
        .TextMatrix(1, C_TIPO_CLIENTE) = "Tipo Cliente"
        .TextMatrix(1, C_PAIS_CLIENTE) = "Pais Cliente"
        .TextMatrix(1, C_TIPO_TASA) = "Tipo Tasa"
        .TextMatrix(1, C_CHECK_USA) = "EE.UU"
        .TextMatrix(1, C_CHECK_ING) = "ING"
        .TextMatrix(1, C_CHECK_SCL) = "CHI"
        .TextMatrix(1, C_FECHA_LIQUIDACION) = "Fecha Liquidación"
        .TextMatrix(1, C_LIQUIDACION_CHECK_USA) = "EE.UU"
        .TextMatrix(1, C_LIQUIDACION_CHECK_ING) = "ING"
        .TextMatrix(1, C_LIQUIDACION_CHECK_SCL) = "CHI"
        .TextMatrix(1, C_FECHA_PROPUESTA_LIQUIDACION) = "Fecha Propuesta"
        .TextMatrix(1, C_AUTORIZA_CHECK) = "Check Autorización"
        .TextMatrix(1, C_PROPUESTA_CHECK_USA) = "EE.UU"
        .TextMatrix(1, C_PROPUESTA_CHECK_ING) = "ING"
        .TextMatrix(1, C_PROPUESTA_CHECK_SCL) = "CHI"
        .TextMatrix(1, C_RUT_CLIENTE) = ""
        .TextMatrix(1, C_TIPO_FLUJO) = ""
        .TextMatrix(1, C_FECHA_PROCESO) = ""
        '''.TextMatrix(1, C_PRE_LIQUIDACION) = ""
        
        .MergeCells = flexMergeRestrictColumns
        .MergeRow(0) = True
        .ColAlignment(1) = flexAlignCenterCenter
        .TextMatrix(0, 0) = "  "
        .TextMatrix(0, 1) = "  "
        .TextMatrix(0, 2) = "  "
        .TextMatrix(0, 3) = "  "
        .TextMatrix(0, 4) = "  "
        .TextMatrix(0, 5) = "  "
        .TextMatrix(0, 6) = "  "
        
        .ColAlignment(7) = flexAlignCenterCenter
        .TextMatrix(0, 7) = " Por Contrato "
        .TextMatrix(0, 8) = " Por Contrato "
        .TextMatrix(0, 9) = " Por Contrato "
        .Row = 0
        .Col = 7
        .CellFontBold = True
        .CellForeColor = &H800000
        
        .ColAlignment(11) = flexAlignCenterCenter
        .TextMatrix(0, 11) = " Por F. Liquidación "
        .TextMatrix(0, 12) = " Por F. Liquidación "
        .TextMatrix(0, 13) = " Por F. Liquidación "
        .Row = 0
        .Col = 11
        .CellFontBold = True
        .CellForeColor = &H800000
        
        .ColAlignment(14) = flexAlignCenterCenter
        .TextMatrix(0, 14) = "  "
        .TextMatrix(0, 15) = "  "
        
        .ColAlignment(16) = flexAlignCenterCenter
        .TextMatrix(0, 16) = " Por F. Propuesta "
        .TextMatrix(0, 17) = " Por F. Propuesta "
        .TextMatrix(0, 18) = " Por F. Propuesta "
        .Row = 0
        .Col = 16
        .CellFontBold = True
        .CellForeColor = &H800000
            
        .SelectionMode = flexSelectionFree
    End With
End Sub

Private Sub Gr_Operacion_DblClick()
    With Gr_Operacion
        If .ColSel = 14 Then
            Call editarfecha(Gr_Operacion, TXTFechaPropuesta, 14)
            TXTFechaPropuesta.MinDate = DateAdd("d", 1, gsBAC_Fecp)
        ElseIf .ColSel = 15 Then
            Call editarCheckAutoriza(Gr_Operacion, 15)
        End If
    End With
End Sub

Public Sub editarfecha(grilla As MSFlexGrid, Control As Control, columna As Integer)
    With Gr_Operacion
        .Col = columna
        Call PROC_POSICIONA_TEXTO(grilla, Control)
        Control.Text = .TextMatrix(.Row, columna)
        Control.Visible = True
        Control.Enabled = True
        Control.SetFocus
    End With
End Sub

Public Sub editarCheckAutoriza(grilla As MSFlexGrid, columna As Integer)
    With Gr_Operacion
        .Col = columna
        If .TextMatrix(.Row, .Col) = "q" Then
            Gr_Operacion.Text = strChecked
        Else
            Gr_Operacion.Text = strUnChecked
        End If
    End With
End Sub

Sub PROC_POSICIONA_TEXTO(grilla As Control, texto As Control)
    texto.Top = Gr_Operacion.CellTop + Gr_Operacion.Top
    texto.Left = Gr_Operacion.CellLeft + Gr_Operacion.Left
    texto.Height = Gr_Operacion.CellHeight
    texto.Width = Gr_Operacion.CellWidth
End Sub

Sub PROC_LIMPIA_DATOS()
Dim i As Integer

    FrameOperaciones.Enabled = True
    '''btnPreliquidacion.Visible = False
    Screen.MousePointer = 0
    Call LIMPIARGRILLA
    Call PROC_CREA_GRILLA_OPERACIONES
    
End Sub

'''Private Sub Gr_Operacion_SelChange()
'''If Gr_Operacion.Col = 22 Then
'''    btnPreliquidacion.Visible = True
'''End If
'''End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
    Select Case Button.Index
    Case 5
        Unload Me
    
    Case 1
        If Format(Me.txtFechaOperacionDesde.Text, "yyyymmdd") > Format(Me.txtFechaOperacionHasta.Text, "yyyymmdd") Then
              MsgBox "Fecha desde no puede ser mayor a fecha hasta!", vbInformation, Msj
              txtFechaOperacionDesde.Text = gsBAC_Fecp
              txtFechaOperacionDesde.SetFocus
              Exit Sub
        End If
        Screen.MousePointer = 11
        Gr_Operacion.Clear
        Call PROC_CREA_GRILLA_OPERACIONES
        Call PROC_LLENA_GRILLA_OPERACIONES
        Screen.MousePointer = 0
    
    Case 2
        Call PROC_GUARDAR_MODIFICACIONES
'        Gr_Operacion.Clear
'        Call PROC_CREA_GRILLA_OPERACIONES
        
    Case 3
        Call LIMPIARGRILLA
        Call PROC_CREA_GRILLA_OPERACIONES
        
    End Select
End Sub

Sub LIMPIARGRILLA()
        Gr_Operacion.Clear
End Sub

Sub PROC_GUARDAR_MODIFICACIONES()
Dim sCadena As String
Dim X
Dim A
A = 0

    MousePointer = vbHourglass
    With Gr_Operacion
        For X = 1 To Gr_Operacion.Rows - 1
            If .TextMatrix(X, C_AUTORIZA_CHECK) = "þ" Then    'antes se tomaba la columna posición, interesa leer solo la marca
                Envia = Array()
                AddParam Envia, Format(Gr_Operacion.TextMatrix(X, 14), "yyyymmdd")
                AddParam Envia, CDbl(Gr_Operacion.TextMatrix(X, 1))
                AddParam Envia, CDbl(Gr_Operacion.TextMatrix(X, 2))
                AddParam Envia, CDbl(Gr_Operacion.TextMatrix(X, 19))
                AddParam Envia, CDbl(Gr_Operacion.TextMatrix(X, 20))
                If Not Bac_Sql_Execute("SP_GRABA_MODIFICACION_FECHA_LIQUIDACION", Envia) Then
                    MousePointer = vbDefault
                    MsgBox "Error en la grabación" & vbCrLf & "SP_GRABA_MODIFICACION_FECHA_LIQUIDACION", vbCritical, TITSISTEMA
                    Exit Sub
                Else
                    A = 1
                End If
            End If
        Next X
    End With

    If A = 1 Then
    MsgBox "Registros grabados en forma correcta", vbOKOnly + vbInformation, TITSISTEMA
    MousePointer = vbDefault
    Call PROC_LIMPIA_DATOS
    Else
        MsgBox "No hay registros marcados con Autorizacion!", vbOKOnly + vbInformation, TITSISTEMA
        MousePointer = vbDefault
    End If
    

End Sub

Sub PintaColumna()
Dim i As Integer
    
    With Gr_Operacion
        .Col = 15
        For i = 1 To .Rows - 1
            .Row = i
            .CellBackColor = vbYellow
        Next
    End With
End Sub

Sub PintaCelda_Feriado(row_ As Integer, col_ As Integer)
Dim i As Integer
    
    With Gr_Operacion
        For i = 1 To 20 - 1
            .Col = i
            .CellBackColor = vbCyan
        Next
    End With
End Sub

Sub PintaCelda_NOFeriado(row_ As Integer, col_ As Integer)
Dim i As Integer
    
    With Gr_Operacion
        For i = 1 To 20 - 1
            .Col = i
            .CellBackColor = vbWhite
        Next
    End With
End Sub


Private Sub TXTFechaPropuesta_KeyDown(KeyCode As Integer, Shift As Integer)
Dim C As Integer
Dim f As Integer
    
    If Not TXTFechaPropuesta.Visible Then Exit Sub
    
    If KeyCode = 13 Then
        With Gr_Operacion
            C = .Col
            f = .Row
            Dim i#
            
            SQL = ""
            SQL = "EXEC BACPARAMSUDA.DBO.SP_BUSCA_FERIADO_CHECK " & "'" & Format(TXTFechaPropuesta.Text, "yyyymmdd") & "',0,0,0,';6;225;510;',0"
            If MISQL.SQL_Execute(SQL) <> 0 Then
                MsgBox "¡No se encuentran datos...!", vbCritical, Msj
                Exit Sub
            End If
            
            Do While MISQL.SQL_Fetch(Datos()) = 0
                Gr_Operacion.TextMatrix(f, C_PROPUESTA_CHECK_USA) = Trim(Datos(1))
                Call editarCheck_Propuesta(Gr_Operacion, Check_LIQUIDACION_CHECK_USA, 16, f, Trim(Datos(2)))
                 
                Gr_Operacion.TextMatrix(f, C_PROPUESTA_CHECK_ING) = Trim(Datos(2))
                Call editarCheck_Propuesta(Gr_Operacion, Check_LIQUIDACION_CHECK_USA, 17, f, Trim(Datos(3)))
                 
                Gr_Operacion.TextMatrix(f, C_PROPUESTA_CHECK_SCL) = Trim(Datos(3))
                Call editarCheck_Propuesta(Gr_Operacion, Check_LIQUIDACION_CHECK_USA, 18, f, Trim(Datos(4)))
            Loop
            
            .Col = 14
            f = .Row
            Select Case KeyCode
                Case 13, 9, 27
                If .TextMatrix(.Row, .Col) <> TXTFechaPropuesta.Text Then
                    .TextMatrix(.Row, .Col) = TXTFechaPropuesta.Text
                    .RowData(.Row) = 1
                    .CellBackColor = vbRed
                    TXTFechaPropuesta.Visible = False
                    TXTFechaPropuesta.Enabled = False
                    .Col = C
                    .Row = f
                    .SetFocus
                   
                Else
                    TXTFechaPropuesta.Visible = False
                    TXTFechaPropuesta.Enabled = False
                    .Col = C
                    .Row = f
                    .SetFocus
                End If
            End Select
            
            
            FechaProceso = Mid(TXTFechaPropuesta.Text, 7, 4) & Mid(TXTFechaPropuesta.Text, 4, 2) & Mid(TXTFechaPropuesta.Text, 1, 2)
            SQL = ""
            SQL = "SP_BUSCA_FECHAS_LIQUIDACION " & "" & .TextMatrix(.Row, C_OPERACION) & "," & .TextMatrix(.Row, C_NUMERO_FLUJO) & "," & .TextMatrix(.Row, C_TIPO_FLUJO) & "," & .TextMatrix(.Row, C_RUT_CLIENTE) & ",'" & FechaProceso & "',0"
            If MISQL.SQL_Execute(SQL) <> 0 Then
                MsgBox "¡No se encuentran datos!", vbCritical, Msj
                Exit Sub
            End If
    
            Do While MISQL.SQL_Fetch(Datos()) = 0
                If Datos(1) = 1 Then
                    MsgBox "Hay liquidaciones de flujos siguientes en el Swap anteriores a la fecha que se quiere ingresar", vbInformation
                End If
            Loop
            
        End With
        Call PintaColumna
    End If
End Sub

Private Sub TXTFechaPropuesta_LostFocus()
    TXTFechaPropuesta.Visible = False
    TXTFechaPropuesta.Enabled = False
End Sub

