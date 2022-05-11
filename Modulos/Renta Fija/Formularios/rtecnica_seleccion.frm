VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form rtecnica_seleccion 
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Selección de Reserva Técnica"
   ClientHeight    =   6480
   ClientLeft      =   120
   ClientTop       =   1935
   ClientWidth     =   11385
   LinkTopic       =   "Form2"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   6480
   ScaleWidth      =   11385
   Begin VB.Frame Frame3 
      Caption         =   "Selección Automatica"
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
      Height          =   2955
      Left            =   7920
      TabIndex        =   10
      Top             =   600
      Width           =   3375
      Begin Threed.SSOption Opt_Pesos 
         Height          =   255
         Left            =   1200
         TabIndex        =   23
         Top             =   1560
         Width           =   255
         _Version        =   65536
         _ExtentX        =   450
         _ExtentY        =   450
         _StockProps     =   78
         Caption         =   "SSOption2"
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin Threed.SSOption Opt_Porc 
         Height          =   255
         Left            =   1920
         TabIndex        =   22
         Top             =   1200
         Width           =   255
         _Version        =   65536
         _ExtentX        =   450
         _ExtentY        =   450
         _StockProps     =   78
         Caption         =   "SSOption1"
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Value           =   -1  'True
      End
      Begin VB.TextBox TxtAFiltrar 
         Alignment       =   1  'Right Justify
         Enabled         =   0   'False
         Height          =   350
         Left            =   1560
         TabIndex        =   20
         Top             =   2400
         Width           =   1600
      End
      Begin VB.TextBox txtMontoFaltante 
         Alignment       =   1  'Right Justify
         Enabled         =   0   'False
         Height          =   350
         Left            =   1560
         TabIndex        =   15
         Top             =   600
         Width           =   1600
      End
      Begin BACControles.TXTNumero TxtAdi_Pesos 
         Height          =   345
         Left            =   1560
         TabIndex        =   13
         Top             =   1530
         Width           =   1605
         _ExtentX        =   2831
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
         Min             =   "0"
         Max             =   "999999999999999"
      End
      Begin BACControles.TXTNumero TxtAdi_Porcentaje 
         Height          =   345
         Left            =   2260
         TabIndex        =   12
         Top             =   1155
         Width           =   900
         _ExtentX        =   1588
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
         Min             =   "-99"
         Max             =   "99"
         SelStart        =   1
      End
      Begin VB.Label Label3 
         Caption         =   "Total  a Selec. Automatica"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   100
         TabIndex        =   21
         Top             =   2400
         Width           =   1335
      End
      Begin VB.Label Label6 
         Alignment       =   1  'Right Justify
         Caption         =   "Monto Selección"
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
         Left            =   840
         TabIndex        =   14
         Top             =   345
         Width           =   2295
      End
      Begin VB.Label Label4 
         Caption         =   "Porcentaje Adicional"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   100
         TabIndex        =   11
         Top             =   1185
         Width           =   1335
      End
   End
   Begin VB.Frame Frame2 
      Caption         =   "Documentos Recuperados"
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
      Height          =   5775
      Left            =   120
      TabIndex        =   8
      Top             =   600
      Width           =   7695
      Begin VB.TextBox txttotal_seleccion 
         Alignment       =   1  'Right Justify
         Enabled         =   0   'False
         Height          =   375
         Left            =   5880
         TabIndex        =   17
         Top             =   5250
         Width           =   1695
      End
      Begin MSFlexGridLib.MSFlexGrid grilla1 
         Height          =   4935
         Left            =   120
         TabIndex        =   9
         Top             =   240
         Width           =   7455
         _ExtentX        =   13150
         _ExtentY        =   8705
         _Version        =   393216
         BackColor       =   -2147483648
         ForeColor       =   -2147483635
         BackColorFixed  =   8421376
         ForeColorFixed  =   -2147483634
         GridColor       =   3947580
         FocusRect       =   0
      End
      Begin VB.Label Label7 
         Caption         =   "Total Seleccion"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   4800
         TabIndex        =   16
         Top             =   5250
         Width           =   975
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "Totales"
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
      Height          =   2715
      Left            =   7920
      TabIndex        =   0
      Top             =   3670
      Width           =   3375
      Begin VB.TextBox TxtSeleccion 
         Alignment       =   1  'Right Justify
         Enabled         =   0   'False
         Height          =   375
         Left            =   1560
         TabIndex        =   18
         Top             =   1560
         Width           =   1600
      End
      Begin VB.TextBox txtExceso 
         Alignment       =   1  'Right Justify
         Enabled         =   0   'False
         Height          =   350
         Left            =   1560
         TabIndex        =   6
         Top             =   2160
         Width           =   1600
      End
      Begin VB.TextBox TxtOOperaciones 
         Alignment       =   1  'Right Justify
         Enabled         =   0   'False
         Height          =   350
         Left            =   1560
         TabIndex        =   4
         Top             =   960
         Width           =   1600
      End
      Begin VB.TextBox TxtRTecnica 
         Alignment       =   1  'Right Justify
         Enabled         =   0   'False
         Height          =   350
         Left            =   1560
         TabIndex        =   2
         Top             =   360
         Width           =   1600
      End
      Begin VB.Label Label8 
         Caption         =   "Cartera Seleccionada"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   100
         TabIndex        =   19
         Top             =   1560
         Width           =   1455
      End
      Begin VB.Label LblExeso 
         Caption         =   "Exceso"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   100
         TabIndex        =   5
         Top             =   2160
         Width           =   975
      End
      Begin VB.Label Label2 
         Caption         =   "Otras Operaciones"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   100
         TabIndex        =   3
         Top             =   960
         Width           =   1455
      End
      Begin VB.Label Label1 
         Caption         =   "Monto Reserva Tenica"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   100
         TabIndex        =   1
         Top             =   360
         Width           =   1335
      End
   End
   Begin MSComctlLib.ImageList imagelist1 
      Left            =   4320
      Top             =   0
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   23
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   10
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "rtecnica_seleccion.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "rtecnica_seleccion.frx":0452
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "rtecnica_seleccion.frx":08A4
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "rtecnica_seleccion.frx":0BBE
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "rtecnica_seleccion.frx":1010
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "rtecnica_seleccion.frx":132A
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "rtecnica_seleccion.frx":1644
            Key             =   ""
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "rtecnica_seleccion.frx":179E
            Key             =   ""
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "rtecnica_seleccion.frx":1BF0
            Key             =   ""
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "rtecnica_seleccion.frx":1F0A
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Tool 
      Height          =   510
      Left            =   0
      TabIndex        =   7
      Top             =   0
      Width           =   11355
      _ExtentX        =   20029
      _ExtentY        =   900
      ButtonWidth     =   794
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "imagelist1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   6
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdFiltrar"
            Description     =   "Asignación automática"
            Object.ToolTipText     =   "Asignación Automática"
            ImageIndex      =   7
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdBuscar"
            Description     =   "Buscar"
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdGrabar"
            Description     =   "Grabar"
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdRefrescar"
            Description     =   "Refrescar montos"
            Object.ToolTipText     =   "Refrescar montos"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdSalir"
            Description     =   "Cerrar"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   10
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
End
Attribute VB_Name = "rtecnica_seleccion"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Dim MReserva_Faltante       As Double
Dim MReserva_Adicional      As Double
Dim MReserva_Porct          As Double
Dim MReserva_Filtrar        As Double
Dim MReserva_Total          As Double
Dim MReserva_Operaciones    As Double
Dim MReserva_Seleccion      As Double
Dim MReserva_Exceso         As Double

Sub Montos()
    
    Dim Datos()
    
    If Not Bac_Sql_Execute("SP_RTECNICA_SELECCION_MONTOS") Then
        MsgBox "Error al calcular reserva técnica", vbCritical, gsBac_Version
        Exit Sub
    End If
    
    MReserva_Faltante = 0
    MReserva_Porct = 0
    MReserva_Adicional = 0
    MReserva_Filtrar = 0
    MReserva_Total = 0
    MReserva_Operaciones = 0
    MReserva_Seleccion = 0
    MReserva_Exceso = 0
    
    
    MReserva_Porct = CDbl(TxtAdi_Porcentaje.Text) 'CDbl(BACChBl(TxtAdi_Porcentaje.Text))
    MReserva_Adicional = CDbl(TxtAdi_Pesos.Text) 'CDbl(BACChBl(TxtAdi_Pesos.Text))
    MReserva_Seleccion = CDbl(BACChBl(txttotal_seleccion.Text))
    
    Do While Bac_SQL_Fetch(Datos())
        MReserva_Total = CDbl(Datos(1))
        MReserva_Operaciones = CDbl(Datos(2))
        MReserva_Faltante = CDbl(Datos(3))
        MReserva_Filtrar = CDbl(Datos(3))
    Loop
    
    Call Adicional
    
    
    MReserva_Exceso = MReserva_Total - MReserva_Operaciones - MReserva_Seleccion

        
    If MReserva_Exceso > 0 Then
        LblExeso.Caption = "FALTA EN RESERVA"
        LblExeso.ForeColor = vbRed
    Else
        LblExeso.Caption = "EXCESO RESERVA"
        LblExeso.ForeColor = vbBlue
    End If
        
    
    txtMontoFaltante.Text = Format(MReserva_Faltante, "###,###,###,###,##0")
    TxtAdi_Porcentaje.Text = Format(MReserva_Porct, "###,###,###,###,##0.0000")
    TxtAdi_Pesos.Text = Format(MReserva_Adicional, "###,###,###,###,##0")
    TxtAFiltrar.Text = Format(MReserva_Filtrar, "###,###,###,###,##0")
    TxtRTecnica.Text = Format(MReserva_Total, "###,###,###,###,##0")
    TxtOOperaciones.Text = Format(MReserva_Operaciones, "###,###,###,###,##0")
    TxtSeleccion.Text = Format(MReserva_Seleccion, "###,###,###,###,##0")
    txtExceso.Text = Format(Abs(MReserva_Exceso), "###,###,###,###,##0")
    
    If MReserva_Seleccion > 0 Then
        Tool.Buttons(4).Enabled = True
    Else
        Tool.Buttons(4).Enabled = False
    End If
    
End Sub
Sub Desbloqueo_general()

    Dim I As Long
       
    Screen.MousePointer = vbHourglass
    
    'declaracion de variables locales
    Dim Datos()
            
    Envia = Array()
    
    AddParam Envia, "RTECNICA"
    
    'ejecuto sp
    If Not Bac_Sql_Execute("SP_RTECNICA_SELECCION_DESBLINST", Envia()) Then
    
        'aviso al usuario
        MsgBox "Se ha producido un error al tomar documento", vbCritical, gsBac_Version
        
        Screen.MousePointer = vbDefault
        
        Exit Sub
    
    End If
    
    Screen.MousePointer = vbDefault
    
End Sub
Sub Adicional_porcentaje()
    TxtAdi_Porcentaje.Text = Format(CDbl(BACChBl(TxtAdi_Pesos.Text) / CDbl(txttotal_rtecnica) * 100), "###,##0.##")
End Sub
Sub Adicional()

  
    If Opt_Porc.Value = True Then
        MReserva_Porct = CDbl(TxtAdi_Porcentaje.Text)
        MReserva_Adicional = (MReserva_Faltante * MReserva_Porct) / 100
        MReserva_Filtrar = MReserva_Faltante + MReserva_Adicional
    Else
      If MReserva_Faltante > 0 Then
        MReserva_Porct = MReserva_Adicional / MReserva_Faltante * 100
        End If
    End If
    
    MReserva_Filtrar = MReserva_Faltante + MReserva_Adicional
    
End Sub

Sub desbloquear()
'--------------------------------------------------------------------------------------------
    If grilla1.TextMatrix(grilla1.Row, 3) = "M" Then
    
        'declaracion de variables locales
        Dim Datos()
        
        Envia = Array()
        
        AddParam Envia, CDbl(grilla1.TextMatrix(grilla1.Row, 9))
        AddParam Envia, CDbl(grilla1.TextMatrix(grilla1.Row, 0))
        AddParam Envia, CDbl(grilla1.TextMatrix(grilla1.Row, 1))
        AddParam Envia, Me.Hwnd
        AddParam Envia, "RTECNICA" 'gsUsuario
        
        'ejecuto sp
        If Not Bac_Sql_Execute("SP_DESBLOQUEARINST ", Envia()) Then
        
            'aviso al usuario
            MsgBox "Se ha producido un error al tomar documento", vbCritical, gsBac_Version
            
            Exit Sub
            
        End If
        
        If Bac_SQL_Fetch(Datos()) Then
        
            If Datos(1) = "SI" Then
        
                grilla1.TextMatrix(grilla1.Row, 3) = ""
        
                txttotal_seleccion.Text = Format((CDbl(txttotal_seleccion.Text) _
                                        - CDbl(grilla1.TextMatrix(grilla1.Row, 8))), _
                                        "###,###,###,###,##0")
                Call colores
        
            Else
        
                'aviso al usuario
                MsgBox "problemas al desbloquear el papel", vbInformation, gsBac_Version
        
            End If
        End If
'--------------------------------------------------------------------------------------------
        grilla1.TextMatrix(grilla1.Row, 3) = ""
        
        txttotal_seleccion.Text = Format((CDbl(txttotal_seleccion.Text) _
                                        - CDbl(grilla1.TextMatrix(grilla1.Row, 8))), _
                                        "###,###,###,###,##0")
        Call colores
    End If
End Sub

Sub Marcar_rtecnica()
    
    'declaracion de variables locales
    Dim I As Long
    Dim x As Long
    
    Screen.MousePointer = vbHourglass
    
    'elimino marcas anteriores
    If Not Bac_Sql_Execute("SP_RTECNICA_SELECCION_DESMARCA") Then

        'aviso al usuario
        MsgBox "Se ha producido un error al tomar documento", vbCritical, gsBac_Version
    
        Exit Sub
    
    End If
        
    For I = 1 To grilla1.Rows - 1
        
        If grilla1.TextMatrix(I, 3) = "M" Then
            
            Envia = Array()
        
            AddParam Envia, grilla1.TextMatrix(I, 0)
            AddParam Envia, grilla1.TextMatrix(I, 1)
            
            'ejecuto sp
            If Not Bac_Sql_Execute("SP_RTECNICA_SELECCION_MARCA", Envia()) Then
        
                'aviso al usuario
                MsgBox "Se ha producido al actualizar cartera", vbCritical, gsBac_Version
                
                Screen.MousePointer = vbDefault
                
                Exit Sub
            
            End If
        
        End If
        
    Next
    
    'elimino marcas anteriores
    If Not Bac_Sql_Execute("SP_RTECNICA_ACTUALIZA_MONTOS_ELEGIBLES ") Then
        MsgBox "Se ha producido al actualizar cartera", vbCritical, gsBac_Version
        Screen.MousePointer = vbDefault
        Exit Sub
    
    End If
    
    MsgBox "Reserva técnica ha sido asignada exitosamente", vbInformation, gsBac_Version
    
    Screen.MousePointer = vbDefault
    
End Sub
Sub Leer_rtecnica_marcada()
    
    Dim ld_Total_Seleccion As Double
    Dim Datos()
       
       
       
    Screen.MousePointer = vbHourglass
    
    Call Titulos_grilla
    
  '  Call Desbloqueo_general
    
    grilla1.Rows = 1
    grilla1.Rows = 2
    
    'ejecuto sp
    If Not Bac_Sql_Execute("SP_RTECNICA_LEER_MARCADOS") Then
    
        'aviso al usuario
        MsgBox "Se ha producido un error al recuperar papeles", vbCritical, gsBac_Version
        
        Exit Sub
    End If
    
    Do While Bac_SQL_Fetch(Datos())
    
        With grilla1
            .Redraw = False
            .Row = .Rows - 1
            
            .TextMatrix(.Rows - 1, 0) = Datos(1)
            .TextMatrix(.Rows - 1, 1) = Datos(2)
            .TextMatrix(.Rows - 1, 2) = Datos(3)
            
            .TextMatrix(.Rows - 1, 4) = Datos(5)
            .TextMatrix(.Rows - 1, 5) = Format(Datos(6), "###,###,###,###,##0.0000")
            .TextMatrix(.Rows - 1, 6) = Datos(7)
            .TextMatrix(.Rows - 1, 7) = Datos(8)
            .TextMatrix(.Rows - 1, 8) = Format(Datos(9), "###,###,###,###,##0")
            .TextMatrix(.Rows - 1, 9) = Datos(10)
            
            If Datos(4) = "M" Then
            
              .TextMatrix(.Rows - 1, 3) = Datos(4)
              
              Call colores
              
              ld_Total_Seleccion = ld_Total_Seleccion + CDbl(Datos(9))
              
            Else
              .TextMatrix(.Rows - 1, 3) = " "
              
            End If
            .Rows = .Rows + 1
            .Redraw = True
        End With
        
    Loop
    
    If grilla1.Rows > 2 Then
        grilla1.Rows = grilla1.Rows - 1
        txttotal_seleccion.Text = Format(ld_Total_Seleccion, "###,###,###,###,##0")
    End If
    
    Call Montos

    Screen.MousePointer = vbDefault
    
End Sub
Sub colores()
    
    'declacion de variables locales
    Dim I As Integer
    
    If grilla1.TextMatrix(grilla1.Row, 3) = "M" Then
    
         For I = 0 To 8
            
            grilla1.Col = I
                
            grilla1.CellBackColor = &HFF0000
            grilla1.CellForeColor = &HFFFFFF
            grilla1.CellFontBold = True
            
        Next
    
    Else
    
        For I = 0 To 8
            
            grilla1.Col = I
                
            grilla1.CellBackColor = &HC0C0C0
            grilla1.CellForeColor = &H8000000D
            grilla1.CellFontBold = False
            
        Next
        
    End If
    
End Sub

Sub Bloquear()

    If grilla1.TextMatrix(grilla1.Row, 3) <> "M" Then
        
        'declaracion de variables locales
        Dim Datos()
        
        Envia = Array()
        
        AddParam Envia, CDbl(grilla1.TextMatrix(grilla1.Row, 9))
        AddParam Envia, CDbl(grilla1.TextMatrix(grilla1.Row, 0))
        AddParam Envia, CDbl(grilla1.TextMatrix(grilla1.Row, 1))
        AddParam Envia, 1
        AddParam Envia, Me.Hwnd
        AddParam Envia, "RTECNICA"
        
        If Not Bac_Sql_Execute("SP_BLOQUEARINST", Envia()) Then
            MsgBox "Se ha producido un error al tomar documento", vbCritical, gsBac_Version
            Exit Sub
            
        End If
                    
        If Bac_SQL_Fetch(Datos()) Then
        
            If Datos(1) = "SI" Then
        
                grilla1.TextMatrix(grilla1.Row, 3) = "M"
                
                txttotal_seleccion.Text = Format((CDbl(txttotal_seleccion.Text) _
                                        + CDbl(grilla1.TextMatrix(grilla1.Row, 8))), _
                                        "###,###,###,###,##0")
                Call colores
                
            Else
        
                'aviso al usuario
                MsgBox "El papel seleccionado esta siendo utilizado por otro usuario", vbInformation, gsBac_Version
            
            End If
        End If
    End If
    
End Sub
Sub Titulos_grilla()

    With grilla1
    
        .Cols = 10
        
        '.ColAlignment(5) = 0
        '.ColAlignment(6) = 0
        
        .TextMatrix(0, 3) = "M"
        .TextMatrix(0, 4) = "Papel"
        .TextMatrix(0, 5) = "Nominal"
        .TextMatrix(0, 6) = "Fecha Compra"
        .TextMatrix(0, 7) = "Fecha Vencimiento"
        .TextMatrix(0, 8) = "Monto"
                
        .ColWidth(0) = 0
        .ColWidth(1) = 0
        .ColWidth(2) = 0
        .ColWidth(3) = 250
        .ColWidth(4) = 1200
        .ColWidth(5) = 2000
        .ColWidth(6) = 1150
        .ColWidth(7) = 1150
        .ColWidth(8) = 1300
        .ColWidth(9) = 0
        
    End With
            
End Sub

Sub Filtrar()

    'declaracion de variables locales
    Dim ld_Total_Seleccion As Double
    Dim Datos()
          
    Screen.MousePointer = vbHourglass
    
    grilla1.Rows = 1
    'grilla1.Row = 1
    grilla1.Rows = 2
    
    Envia = Array()
    
'   AddParam envia, CDbl(txtdiferencia.Text)
'   If txtadi_pesos.Text = "" Then
'       AddParam envia, 0
'   Else
'       AddParam envia, CDbl(txtadi_pesos.Text) 'ld_Adicional
'   End If
           
    AddParam Envia, CDbl(TxtAFiltrar.Text)
    AddParam Envia, 0
    AddParam Envia, Me.Hwnd
    AddParam Envia, "RTECNICA"
    
    'llamo procedimiento
    If Not Bac_Sql_Execute("SP_RTECNICA_FILTRA_PAPELES", Envia()) Then
    
        'aviso al usuario
        MsgBox "Se ha producido un error al filtrar papeles", vbCritical, gsBac_Version
        
        Screen.MousePointer = vbDefault
        
        Exit Sub
    End If
    
    Do While Bac_SQL_Fetch(Datos())
    
        With grilla1
            .Redraw = False
            .Row = .Rows - 1
            .TextMatrix(.Rows - 1, 0) = Datos(1)
            .TextMatrix(.Rows - 1, 1) = Datos(2)
            .TextMatrix(.Rows - 1, 2) = Datos(3)
            .TextMatrix(.Rows - 1, 4) = Datos(5)
            .TextMatrix(.Rows - 1, 5) = Format(Datos(6), "###,###,###,###,##0.0000")
            .TextMatrix(.Rows - 1, 6) = Datos(7)
            .TextMatrix(.Rows - 1, 7) = Datos(8)
            .TextMatrix(.Rows - 1, 8) = Format(Datos(9), "###,###,###,###,##0")
            .TextMatrix(.Rows - 1, 9) = Datos(10)
            
            If Datos(4) = "M" Then
                
              .TextMatrix(.Rows - 1, 3) = Datos(4)
              
              Call colores
              
              ld_Total_Seleccion = ld_Total_Seleccion + CDbl(Datos(9))
              
            Else
              .TextMatrix(.Rows - 1, 3) = " "
              
            End If
            .Rows = .Rows + 1
            .Redraw = True
        End With
        
    Loop
    
    If grilla1.Rows > 2 Then
        grilla1.Rows = grilla1.Rows - 1
        txttotal_seleccion.Text = Format(ld_Total_Seleccion, "###,###,###,###,##0")
    End If
    
    
    Call Montos
    
    Screen.MousePointer = vbDefault
    
End Sub

Private Sub Form_Activate()

    Call Montos

End Sub

Private Sub Form_Load()

    Move 0, 0
    Me.Icon = BacTrader.Icon
    
    'declaracion de variables locales
    Dim Datos()
    
    'lleno titulos
    Call Titulos_grilla
    
    MReserva_Faltante = 0
    MReserva_Porct = 0
    MReserva_Adicional = 0
    MReserva_Filtrar = 0
    MReserva_Total = 0
    MReserva_Operaciones = 0
    MReserva_Seleccion = 0
    MReserva_Exceso = 0
    
    TxtAdi_Porcentaje.Enabled = True
    TxtAdi_Pesos.Enabled = False

'    Call Montos
    
    Tool.Buttons(5).Visible = False
    
End Sub

Private Sub Form_Unload(Cancel As Integer)

    Call Desbloqueo_general
    
End Sub

Private Sub Grilla1_KeyPress(KeyAscii As Integer)

    If UCase(Chr(KeyAscii)) = "M" Then
        
        Call Bloquear
        
    ElseIf UCase(Chr(KeyAscii)) = "D" Then
        
       Call desbloquear
       
    End If
    
    Call Montos

End Sub

Private Sub Label5_Click()

End Sub

Private Sub OPT_Porc_Click(Value As Integer)

    TxtAdi_Porcentaje.Enabled = True
    TxtAdi_Pesos.Enabled = False

End Sub

Private Sub OPT_Pesos_Click(Value As Integer)

    TxtAdi_Porcentaje.Enabled = False
    TxtAdi_Pesos.Enabled = True

End Sub


Private Sub Tool_ButtonClick(ByVal Button As MSComctlLib.Button)

    Select Case Button.Key
        
        Case Is = "cmdFiltrar": Call Filtrar
        Case Is = "cmdSalir": Unload Me
        Case Is = "cmdBuscar": Call Leer_rtecnica_marcada
        Case Is = "cmdGrabar": Call Marcar_rtecnica
        Case Is = "cmdRefrescar": Call Montos
    End Select

End Sub


Private Sub txtadi_pesos_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then
        Call Montos
        'Call Adicional_porcentaje
    End If

End Sub

Private Sub txtadi_pesos_LostFocus()

    Call Montos
   'Call Adicional_porcentaje
   
End Sub

Private Sub txtadi_porcentaje_KeyPress(KeyAscii As Integer)

    If Chr(KeyAscii) = "." Or Chr(KeyAscii) = "," Then
      KeyAscii = Asc(gsBac_PtoDec)

    ElseIf KeyAscii = 13 Then
        Call Montos
        'Call Adicional_pesos
    End If
    
End Sub

Private Sub txtadi_porcentaje_LostFocus()

    Call Montos
   'Call Adicional_pesos
    
End Sub



Function BACChBl(Texto As String) As Double

    BCCHBL = Texto
End Function

