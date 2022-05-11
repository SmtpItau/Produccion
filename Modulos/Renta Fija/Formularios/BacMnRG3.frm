VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacMnRG3 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mark to Market"
   ClientHeight    =   3255
   ClientLeft      =   330
   ClientTop       =   1335
   ClientWidth     =   10290
   ForeColor       =   &H00C0C0C0&
   Icon            =   "BacMnRG3.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   Moveable        =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   3255
   ScaleWidth      =   10290
   Begin BACControles.TXTNumero Text1 
      Height          =   225
      Left            =   3420
      TabIndex        =   4
      TabStop         =   0   'False
      Top             =   1950
      Visible         =   0   'False
      Width           =   930
      _ExtentX        =   1640
      _ExtentY        =   397
      BackColor       =   8388608
      ForeColor       =   -2147483639
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
      BorderStyle     =   0
      Text            =   "0"
      Text            =   "0"
      SelStart        =   1
   End
   Begin MSFlexGridLib.MSFlexGrid Grilla1 
      Height          =   2280
      Left            =   2565
      TabIndex        =   3
      Top             =   945
      Width           =   7710
      _ExtentX        =   13600
      _ExtentY        =   4022
      _Version        =   393216
      Cols            =   1
      FixedCols       =   0
      BackColor       =   14737632
      ForeColorSel    =   -2147483635
   End
   Begin MSFlexGridLib.MSFlexGrid Grilla 
      Height          =   2280
      Left            =   45
      TabIndex        =   2
      Top             =   945
      Width           =   2535
      _ExtentX        =   4471
      _ExtentY        =   4022
      _Version        =   393216
      FixedCols       =   0
      BackColor       =   14737632
   End
   Begin VB.ComboBox Cmb_Emisor 
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
      Left            =   1185
      Style           =   2  'Dropdown List
      TabIndex        =   0
      Top             =   600
      Width           =   4665
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   90
      Top             =   3150
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   25
      ImageHeight     =   25
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   7
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMnRG3.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMnRG3.frx":075C
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMnRG3.frx":0A76
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMnRG3.frx":0D90
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMnRG3.frx":10AA
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMnRG3.frx":14FC
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMnRG3.frx":1816
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Tool 
      Height          =   465
      Left            =   0
      TabIndex        =   5
      Top             =   0
      Width           =   10260
      _ExtentX        =   18098
      _ExtentY        =   820
      ButtonWidth     =   847
      ButtonHeight    =   820
      AllowCustomize  =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   8
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdReporte"
            Description     =   "Reporte"
            Object.ToolTipText     =   "Imprime Reporte de Mark to Market"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdValorizar"
            Description     =   "Valorizar"
            Object.ToolTipText     =   "Valoriza Mark to Market"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdRangos"
            Description     =   "M.Rangos"
            Object.ToolTipText     =   "M.Rangos"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdGrabar"
            Description     =   "Grabar"
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdBuscar"
            Description     =   "Buscar"
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button7 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdLimpiar"
            Description     =   "Limpiar"
            Object.ToolTipText     =   "Limpiar Pantalla"
            ImageIndex      =   6
         EndProperty
         BeginProperty Button8 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdCerrar"
            Description     =   "Cerrar"
            Object.ToolTipText     =   "Cerrar el Formulario"
            ImageIndex      =   7
         EndProperty
      EndProperty
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      Caption         =   "Emisor"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Left            =   270
      TabIndex        =   1
      Top             =   660
      Width           =   570
   End
End
Attribute VB_Name = "BacMnRG3"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit
Dim Cont As Integer
Dim sPunto          As String
Dim Frm_estado      As Integer
Dim iFlagKeyDown

Sub GrabarRG()
Dim Fecha_Proceso       As String * 10
Dim Datos()
Dim F                   As Long
Dim Max                 As Long
Dim Valor1              As Double
Dim Valor2              As Double

    Max = 0
    
    If Max = 0 Then
        Exit Sub
    End If
    'Retorna la fecha de proceso
    '---------------------------

'    Sql = "SP_GRABAR_RG "
    If Not Bac_Sql_Execute("SP_GRABAR_RG") Then
        Screen.MousePointer = 0
        MsgBox "No Se Puede Eliminar Registros de Tabla Tasa Rangos", vbInformation, Me.Caption
        Exit Sub
    End If
    
    Do While Bac_SQL_Fetch(Datos())
       Fecha_Proceso = Datos(1)
    Loop
          
    'Validamos que los valores sean menores a 10
    '-------------------------------------------
    For F = 1 To Max
        
        grilla.Row = F
        grilla.Col = 1: Valor1 = grilla.Text
        grilla.Col = 2: Valor2 = grilla.Text
        
        If F <= Max Then
           
           If Valor1 > Valor2 And F <> Max Then
               MsgBox "Valor Inicio es Mayor al Valor Final en la Fila" & Str(F), vbInformation, Me.Caption
               Exit Sub
           End If
        
        End If
    
    Next F
       
    Screen.MousePointer = 11
    ' Eliminamos Los Registros de las tablas
    '---------------------------------------------
'    Sql = "SP_RGELIMINAR"
    If Not Bac_Sql_Execute("SP_RGELIMINAR") Then
       Screen.MousePointer = 0
       MsgBox "No Se Puede Eliminar Registros de Tabla de Rangos", vbInformation, Me.Caption
       Exit Sub
    End If
    
    'Grabamos en la tabla MDRG
    '-------------------------
    Dim fechaFinal      As String
    Dim fechaInicial    As String
    Dim meses           As Integer
    
    For F = 1 To Max
        grilla.Row = F
        grilla.Col = 1: Valor1 = grilla.Text
        grilla.Col = 2: Valor2 = grilla.Text
        
        fechaInicial$ = DateAdd("yyyy", Int(Valor1), Fecha_Proceso$)            'Format(Now, "yyyy/mm/dd")
        fechaFinal$ = DateAdd("yyyy", Int(Valor2), Fecha_Proceso$)              'Format(Now, "yyyy/mm/dd")
        
        meses% = CInt((Valor1 - Int(Valor1)) * 100)
        If meses% > 0 Then
        
           meses% = (meses% * 12) / 100
           fechaInicial$ = DateAdd("m", meses%, Format(fechaInicial$, "yyyy/mm/dd"))
        
        End If
                
        meses% = CInt((Valor2 - Int(Valor2)) * 100)
        If meses% > 0 Then
        
           meses% = (meses% * 12) / 100
           fechaFinal$ = DateAdd("m", meses%, Format(fechaFinal$, "yyyy/mm/dd"))
        
        End If
        
        
        fechaInicial = Format(fechaInicial$, "yyyymmdd")
        fechaFinal = Format(fechaFinal$, "yyyymmdd")
        
'        Sql = "SP_RGGRABAR "
'        Sql = Sql & BacStrTran(Str(Valor1), ",", ".") & ","
'        Sql = Sql & BacStrTran(Str(Valor2), ",", ".") & ","
'        Sql = Sql & "'" & fechaInicial$ & "',"
'        Sql = Sql & "'" & fechaFinal$ & "'"
        
        Envia = Array(CDbl(Valor1), _
                CDbl(Valor2), _
                fechaInicial, _
                fechaFinal)
        
        If Not Bac_Sql_Execute("SP_RGGRABAR", Envia) Then
            Screen.MousePointer = 0
            MsgBox "No Se Puede Grabar en Tabla de Rangos", vbInformation, Me.Caption
            Exit Sub
        End If
        
    Next F
    
    Screen.MousePointer = 0
    
    MsgBox "Valores Han Sido Grabados", vbInformation, Me.Caption

End Sub
Private Sub CargaGrilla()
Dim Datos()
Dim Max      As Long
Dim Fila     As Long
Dim Col      As Long
Dim cValor1  As String
Dim cValor2  As String
Dim bFormato As Boolean
 
    Text1.BackColor = &HE0E0E0
   
    Screen.MousePointer = 11
    bFormato = False
        
  ' Se carga grilla de plazos, para Mark to Market
  ' ========================================================================================
    grilla.Rows = 1
    'GrdMM.Rows = 0
        
'    Sql = "SP_RGLEER"
    If Not Bac_Sql_Execute("SP_RGLEER") Then
        Screen.MousePointer = 0
        MsgBox "No Se Puede Cargar Tabla de Rangos", vbInformation, Me.Caption
        Exit Sub
    End If
        
    grilla.Rows = 1
    Grilla1.Rows = 1

    Do While Bac_SQL_Fetch(Datos())
        grilla.Rows = grilla.Rows + 1
        Grilla1.Rows = Grilla1.Rows + 1
        grilla.Row = grilla.Rows - 1
        Grilla1.Row = Grilla1.Rows - 1
        grilla.Col = 0: grilla.Text = Format(Datos(1), "##0")
        grilla.Col = 1: grilla.Text = Format(Datos(2), "##0")
    Loop
    
    'GrdMM.Rows = 0
    'GrdMM.Rows = Grilla.Rows - 1
  ' ========================================================================================
  ' Se carga segunda grilla con los datos por serie
  ' ========================================================================================
    Envia = Array(Trim(Right(Cmb_Emisor.Text, 10)))
    
    If Not Bac_Sql_Execute("SP_TRLEERSERIES", Envia) Then
        Screen.MousePointer = 0
        MsgBox "No se puede cargar tabla de series", vbInformation, gsBac_Version
        Exit Sub
    End If
        
    Col = 0
    Max = 0
    Do While Bac_SQL_Fetch(Datos())
        If Max = 0 Then
            Max = IIf(Datos(1) = 0, 1, Datos(1))
            Grilla1.cols = Max
            'Grilla1.Cols = Grilla1.Cols - 1
        End If

        Grilla1.Row = 0
        Grilla1.ColWidth(Col) = 1000
        Grilla1.Col = Col: Grilla1.Text = Datos(2)
        Col = Col + 1
    Loop
    
    Grilla1.Col = Grilla1.Cols - 1
  
        
    For Col = 0 To Grilla1.Cols - 1
        For Fila = 1 To Grilla1.Rows - 1
            Grilla1.Row = Fila
            Grilla1.Col = Col
            Grilla1.Text = Format(0, "##0.0000")
        Next Fila
    Next Col

    ' Lee Tabla de Mark to Market
    '----------------------------
'    Sql = "SP_TRLEER " & "'" & Format(gsBac_Fecp, "dd/mm/yyyy") & "'," + Trim(Right(Cmb_Emisor.Text, 10))
    Envia = Array(Format(gsBac_Fecp, "dd/mm/yyyy"), _
            Trim(Right(Cmb_Emisor.Text, 10)))
            
    If Not Bac_Sql_Execute("SP_TRLEER", Envia) Then
        Screen.MousePointer = 0
        MsgBox "No Se Puede Cargar Tabla de Mark to Market", vbInformation, Me.Caption
        Exit Sub
    End If
    
    Do While Bac_SQL_Fetch(Datos())
        'Buscamos la serie en la grilla
        '----------------------------------------------
        For Col = 0 To Grilla1.Cols - 1
            Grilla1.Row = 0
            Grilla1.Col = Col
            If Trim$(Datos(2)) = Grilla1.Text Then
                Exit For
            End If
        Next Col
        'Buscamos la tasa en la grilla
        '----------------------------------------------
        For Fila = 1 To grilla.Rows - 1
            grilla.Row = Fila
            grilla.Col = 0: cValor1 = Val(grilla.Text)
            grilla.Col = 1: cValor2 = Val(grilla.Text)
            If cValor1 = Val(Datos(3)) And cValor2 = Val(Datos(4)) Then
                Exit For
            End If
        Next Fila
        Grilla1.Row = Fila
        Grilla1.Col = Col
        Grilla1.Text = Format(Datos(5), "##0.0000")
        bFormato = True

    Loop
    
    Grilla1.Col = 0: Grilla1.Row = 0
    Screen.MousePointer = 0
   
End Sub
Sub Graba_Rangos()
Dim Fila    As Long
Dim Col     As Long
Dim Max     As Long
Dim cRango1 As String
Dim cRango2 As String
Dim Serie   As String
Dim Tasa    As Double
Dim cTasa   As String

On Error GoTo ErrGrabar

    Screen.MousePointer = 11


    'Elimina Registros Con Fecha de Sistema ( Todos )
    '------------------------------------------------
'    Sql = "SP_TRELIMINAR "
'    Sql = Sql & "'" & Format(gsBac_Fecp, "yyyymmdd") & "'," + Trim(Right(Cmb_Emisor.Text, 10))

    Envia = Array(Format(gsBac_Fecp, "yyyymmdd"), Trim(Right(Cmb_Emisor.Text, 10)))
    
    If Not Bac_Sql_Execute("SP_TRELIMINAR", Envia) Then
        Screen.MousePointer = 0
        MsgBox "No Se Puede Eliminar Registros de Tabla Mark to Market", vbInformation, Me.Caption
        Exit Sub
    End If

   'Graba Valores en Tabla de Mark to Market (MDMM)
   '-----------------------------------------------
    Max = grilla.Rows - 1

    For Col = 0 To Grilla1.Cols - 1
    
        Grilla1.Row = 0
        Grilla1.Col = Col
        Serie = Grilla1.Text
        
        For Fila = 1 To Max
        
            grilla.Row = Fila
            grilla.Col = 0: cRango1 = IIf(Trim$(grilla.Text) = "", 0, grilla.Text)
            grilla.Col = 1: cRango2 = IIf(Trim$(grilla.Text) = "", 0, grilla.Text)
      
            Grilla1.Row = Fila
            Grilla1.Col = Col
            cTasa = IIf(Trim$(Grilla1.Text) = "", 0, Grilla1.Text)
            
'            Sql = "SP_TRGRABAR "
'            Sql = Sql & "'" & Format(gsBac_Fecp, "yyyymmdd") & "',"
'            Sql = Sql & "'" & Serie & "',"
'            Sql = Sql & BacStrTran(cRango1, ",", ".") & ","
'            Sql = Sql & BacStrTran(cRango2, ",", ".") & ","
'            Sql = Sql & BacStrTran(cTasa, ",", ".") & ","
'            Sql = Sql & Trim(Right(Cmb_Emisor.Text, 10))

            Envia = Array(Format(gsBac_Fecp, "yyyymmdd"), _
                    Serie, _
                    CDbl(cRango1), _
                    CDbl(cRango2), _
                    CDbl(cTasa), _
                    Trim(Right(Cmb_Emisor.Text, 10)))
            
            If Not Bac_Sql_Execute("SP_TRGRABAR", Envia) Then
                Screen.MousePointer = 0
                MsgBox "No Se Puede Grabar Registros en Tabla Mark to Market", vbInformation, Me.Caption
                Exit Sub
            End If
        Next Fila
    
    Next Col
    
    MsgBox "Registros Grabados en Tabla Mark to Market ", vbInformation, Me.Caption
    
    Screen.MousePointer = 0
    Exit Sub
    
ErrGrabar:
    MsgBox "Problemas al grabar información: " & err.Description & ". Verifique.", vbCritical, "BAC Trader"
    Exit Sub
    
End Sub



Private Sub GrabarGrilla()
Dim Fila    As Long
Dim Col     As Long
Dim Max     As Long
Dim cRango1 As String
Dim cRango2 As String
Dim Serie   As String
Dim Tasa    As Double
Dim cTasa   As String

On Error GoTo ErrGrabar

    Screen.MousePointer = 11

    'Elimina Registros Con Fecha de Sistema ( Todos )
    '------------------------------------------------
'    Sql = "SP_TRELIMINAR "
'    Sql = Sql & "'" & Format(gsBac_Fecp, "yyyymmdd") & "'," + Trim(Right(Cmb_Emisor.Text, 10))
    
    Envia = Array(Format(gsBac_Fecp, "yyyymmdd"), Trim(Right(Cmb_Emisor.Text, 10)))
    
    If Not Bac_Sql_Execute("SP_TRELIMINAR", Envia) Then
        Screen.MousePointer = 0
        MsgBox "No Se Puede Eliminar Registros de Tabla Mark to Market", vbInformation, Me.Caption
        Exit Sub
    End If

   'Graba Valores en Tabla de Mark to Market (MDMM)
   '-----------------------------------------------
    Max = grilla.Rows - 1

    For Fila = 1 To Max
        grilla.Row = Fila
        grilla.Col = 0: cRango1 = IIf(Trim$(grilla.Text) = "", 0, grilla.Text)
        grilla.Col = 1: cRango2 = IIf(Trim$(grilla.Text) = "", 0, grilla.Text)
        
        For Col = 0 To Grilla1.Cols - 1
            Grilla1.Row = Fila - 1
            Grilla1.Col = Col
            Serie = Grilla1.Text
            Grilla1.Row = Fila
            Grilla1.Col = Col
            cTasa = IIf(Trim$(Grilla1.Text) = "", 0, Grilla1.Text)
            
'            Sql = "sp_trgrabar "
'            Sql = Sql & "'" & Format(gsBac_Fecp, "yyyymmdd") & "',"
'            Sql = Sql & "'" & Serie & "',"
'            Sql = Sql & BacStrTran(cRango1, ",", ".") & ","
'            Sql = Sql & BacStrTran(cRango2, ",", ".") & ","
'            Sql = Sql & BacStrTran(cTasa, ",", ".") & ","
'            Sql = Sql & Trim(Right(Cmb_Emisor.Text, 10))

            Envia = Array(Format(gsBac_Fecp, "yyyymmdd"), _
                    Serie, _
                    CDbl(cRango1), _
                    CDbl(cRango2), _
                    CDbl(cTasa), _
                    Trim(Right(Cmb_Emisor.Text, 10)))
            
            If Not Bac_Sql_Execute("SP_TRGRABAR", Envia) Then
                Screen.MousePointer = 0
                MsgBox "No Se Puede Grabar Registros en Tabla Mark to Market", vbInformation, Me.Caption
                Exit Sub
            End If
            
        Next Col
    
    Next Fila
    
    MsgBox "Registros Grabados en Tabla Mark to Market ", vbInformation, Me.Caption
    
    Screen.MousePointer = 0
    Exit Sub
    
ErrGrabar:
    MsgBox "Problemas al grabar información: " & err.Description & ". Verifique.", vbCritical, "BAC Trader"
    Exit Sub
    
End Sub

Private Sub Cmb_Emisor_KeyPress(KeyAscii As Integer)
Dim I As Integer
With Tool
    If KeyAscii = 13 Then
        Screen.MousePointer = 11
        .Buttons(2).Enabled = True '(Cmd_Reporte)'antes true
        .Buttons(3).Enabled = True '(cmdValorizar)'antes true
        .Buttons(4).Enabled = True '(cmdRangos)
        .Buttons(5).Enabled = True '(cmdGrabar)
         Cmb_Emisor.Enabled = False
        .Buttons(6).Enabled = False '(CmdBuscar)
        Call CargaGrilla
    
        Screen.MousePointer = 0
    
        grilla.Col = 1
        grilla.Row = 0
    
    End If
End With
End Sub

Sub Nombres()
   With grilla
      .Rows = 2
      .Row = 0
      .Col = 0: .Text = "Rango Desde"
      .Col = 1: .Text = "Rango Hasta"
      .ColWidth(0) = 1150
      .ColWidth(1) = 1150
      .RowHeight(0) = 350
      .Width = .ColWidth(0) + .ColWidth(1) + 110
      .FontWidth = 5
      .BackColorFixed = &H808000
      .ForeColorFixed = &HFFFFFF
   End With
   With Grilla1
      .Rows = 2
      .Row = 0
      .Cols = 1
      .Col = 0: .Text = "Tasas para Rangos"
      .ColWidth(0) = 7000
      .RowHeight(0) = 350
      .BackColorFixed = &H808000
      .ForeColorFixed = &HFFFFFF
   End With
End Sub
Private Sub Form_Load()
Call Nombres
Dim I As Integer

    
    Me.Top = 0
    Me.Left = 0
    
    Frm_estado% = True
    
    If InStr(1, CStr(Format(100#, "##0.000")), ".", 1) > 0 Then
        sPunto = "."
    Else
        sPunto = ","
    End If
       iFlagKeyDown = True
           Call Act_FeRg

    PROC_CARGA_EMISOR
    
    Cmb_Emisor.ListIndex = 0
    
    Call Limpiar
End Sub

Function Act_FeRg()
Dim Fecha_Proceso   As Date
Dim fechaFinal      As Date
Dim fechaInicial    As Date
Dim meses           As Integer
Dim anos            As Integer
Dim xM              As Integer
Dim Max             As Integer
Dim MdRg(30, 30)
Dim Datos()
    
    Fecha_Proceso = Format$(gsBac_Fecp, "dd/mm/yyyy")
        
    xM = 1
        
    If Not Bac_Sql_Execute("SP_RGLEER") Then
       Screen.MousePointer = vbDefault
       MsgBox "No se puede leer tabla de << mdrg >> ", vbInformation, Me.Caption
       Exit Function
    End If
    
    Do While Bac_SQL_Fetch(Datos())
        If sPunto = "," Then
            MdRg(xM, 1) = BacStrTran(CStr(Datos(1)), ".", ",")
            MdRg(xM, 2) = BacStrTran(CStr(Datos(2)), ".", ",")
        Else
            MdRg(xM, 1) = BacStrTran(CStr(Datos(1)), ",", ".")
            MdRg(xM, 2) = BacStrTran(CStr(Datos(2)), ",", ".")
        End If
        xM = xM + 1
    Loop
    
    If xM <= 1 Then Exit Function

    If Not Bac_Sql_Execute("DELETE mdrg") Then
        Screen.MousePointer = 0
        MsgBox "No se puede actualizar tabla << mdrg >>", vbInformation, Me.Caption
        Exit Function
    End If
        
    Max = xM - 1
    xM = 1
    fechaFinal = Fecha_Proceso
    
    Do While xM <= Max
        
        If xM = 1 Then
            fechaInicial = Fecha_Proceso
        Else
            fechaInicial = DateAdd("d", 1, fechaFinal)
        End If
        
        fechaFinal = DateAdd("d", Val(MdRg(xM, 2)) - Val(MdRg(xM, 1)), fechaInicial)
        
        If xM = Max Then
            fechaFinal = DateAdd("yyyy", 50, fechaFinal)
        End If
                        
'        Sql = "SP_RGGRABAR "
'        Sql = Sql & BacStrTran(Str(MdRg(xM, 1)), ",", ".") & ","
'        Sql = Sql & BacStrTran(Str(MdRg(xM, 2)), ",", ".") & ","
'        Sql = Sql & "'" & Format(fechaInicial, "yyyymmdd") & "',"
'        Sql = Sql & "'" & Format(fechaFinal, "yyyymmdd") & "'"

        Envia = Array(CDbl(MdRg(xM, 1)), _
                CDbl(MdRg(xM, 2)), _
                Format(fechaInicial, "yyyymmdd"), _
                Format(fechaFinal, "yyyymmdd"))
        
        If Not Bac_Sql_Execute("SP_RGGRABAR", Envia) Then
            Screen.MousePointer = 0
            MsgBox "No Se Puede Grabar en Tabla de Rangos", vbInformation, Me.Caption
            Exit Function
        End If
        
        xM = xM + 1
        
    Loop

End Function


Sub PROC_CARGA_EMISOR()
Dim Datos()
      
If miSQL.SQL_Execute("SP_EMLEERNOMBRES ''") <> 0 Then Exit Sub
       
   Do While Bac_SQL_Fetch(Datos())
      Cmb_Emisor.AddItem Datos(4) + Space(60) + Format(Datos(2), "##0")
   Loop

End Sub



Private Sub Grilla1_Click()
If Text1.Visible = True Then Exit Sub
End Sub

Private Sub Grilla1_GotFocus()
   'Text1.Visible = False
   Text1.BackColor = &H808000 'color azul
   Text1.Font.bold = True
End Sub

Private Sub Grilla1_KeyPress(KeyAscii As Integer)
   If (KeyAscii = 13) Or (KeyAscii >= 47) And (KeyAscii <= 57) Then
      Text1.Visible = True
      Text1.BackColor = &H8000000D 'color azul
      Text1.Font.bold = True
      Text1.SetFocus
   End If
End Sub

Private Sub Grilla1_LeaveCell()
'devuelve el tono a la celda anterior
If Grilla1.Row <> 0 Then Grilla1.CellBackColor = &HE0E0E0
End Sub

Private Sub Grilla1_LostFocus()
'text1.Visible = False
End Sub

Private Sub Grilla1_RowColChange()
   If Not Grilla1.Row = 0 Then
      Call PROC_POSI_TEXTO(Grilla1, Text1)
      Text1.Text = Grilla1.Text
   End If
End Sub

Private Sub Grilla1_Scroll()
    'Call PROC_POSI_TEXTO(Grilla1, Text1)
    'text1.Visible = False
    Text1.Font.bold = True
End Sub

Private Sub Grilla1_SelChange()
'da el color actual a la celda
If Grilla1.Row <> 0 Then Grilla1.CellBackColor = &H808000: Text1.Font.bold = True
End Sub

Private Sub Text1_KeyPress(KeyAscii As Integer)

Text1.BackColor = &H8000000D 'color azul
Text1.Font.bold = True

With Grilla1
      
   If KeyAscii = 27 Then
      Text1.BackColor = &H808000 'color verde agua
      Text1.Text = 0
      .SetFocus
      Exit Sub
   End If

   If KeyAscii = 13 Then
         If Text1.Text > 100 Then
            MsgBox "la tasa no debe ser mayor a 100", vbInformation
            Text1 = ""
            Text1.SetFocus
            Exit Sub
         End If
         
         .Row = .RowSel: .Col = .ColSel
         
         If .Text = "0.0000" And Text1 = "0" Then
            Call CorrerCursor(Grilla1)
            Text1.Visible = True
            Text1.SetFocus
            Exit Sub
         Else
            On Error Resume Next
            .Text = Format(Text1, "##0.0000")
            Text1.Text = ""
            Call CorrerCursor(Grilla1)
            Text1.SetFocus
            On Error GoTo 0
         End If
   End If
End With
End Sub

Sub CorrerCursor(grilla As Control)
With grilla
   If .ColSel + 1 = .Cols Then
      If .RowSel + 1 = .Rows Then
         .Row = 1: .Col = 0
         Exit Sub
      End If
      
      .Row = .RowSel + 1
      .Col = 0
   Else
      .Col = .ColSel + 1
   End If
End With
End Sub
Sub Reporte()
Dim TitRpt As String
On Error GoTo ErrPrinter

    Screen.MousePointer = 11

      TitRpt = "INFORME DE MARK TO MARKET "
      BacTrader.bacrpt.Destination = 0
      BacTrader.bacrpt.ReportFileName = RptList_Path & "I_MARK1.RPT"
      'BacTrader.bacrpt.StoredProcParam(0) = xentidad
      BacTrader.bacrpt.Formulas(0) = "TIT='" & TitRpt & "'"
      BacTrader.bacrpt.Connect = CONECCION
      BacTrader.bacrpt.Action = 1
      Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Impresión " & TitRpt)
      
    Screen.MousePointer = 0
    Exit Sub
    
ErrPrinter:
    MsgBox "Problemas en impresión: " & err.Description & ". Verifique.", vbExclamation, "BAC Trader"
    Exit Sub
End Sub

Sub Limpiar()
With Tool
Text1.Visible = False
.Buttons(2).Enabled = True '(Cmd_Reporte)
.Buttons(3).Enabled = True '(cmdValorizar)
.Buttons(4).Enabled = False '(cmdRangos)
.Buttons(5).Enabled = False '(cmdGrabar)
.Buttons(6).Enabled = True '(CmdBuscar)

grilla.Rows = 1
Grilla1.Rows = 1
Grilla1.Cols = 2
grilla.Refresh
Grilla1.Refresh
Call Nombres

Cmb_Emisor.Enabled = True
Cmb_Emisor.ListIndex = 0
'Cmb_Emisor.SetFocus

End With
End Sub
Sub Buscar()
Cmb_Emisor.SetFocus
SendKeys "{ENTER}"
End Sub
Sub Grabar()
   
    Screen.MousePointer = 11
   
    'Call GrabarGrilla
    Call Graba_Rangos
    Tool.Buttons(1).Enabled = True     '(cmdValorizar)
    Tool.Buttons(5).Enabled = True     '(cmdValorizar)
    
    
    Call Limpiar
   
    Screen.MousePointer = 0
End Sub
Sub M_Rangos()
 
    Screen.MousePointer = 11
  
    Me.Tag = "MDCL"
    BacMntRG2.Tag = Me.Tag
    BacMntRG2.Show 1
    
    Screen.MousePointer = 0
End Sub
Sub Valorizar()
Dim Sql         As String
   
    Screen.MousePointer = 11
    
'    Sql = "SP_MARK_TO_MARKET '" & Format(gsBac_Fecp, "yyyymmdd") & "'"
    Envia = Array(Format(gsBac_Fecp, "yyyymmdd"))
    
    If Bac_Sql_Execute("SP_MARK_TO_MARKET", Envia) Then
        MsgBox "Valorización de Mark to Market generada correctamente", vbOKOnly + vbInformation, Me.Caption
    Else
        MsgBox "Problemas al Valorizar Mark to Market", vbCritical, Me.Caption
    End If
    
    Screen.MousePointer = 0
    
End Sub

Private Sub Tool_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Key
   Case Is = "cmdReporte": Call Reporte
   Case Is = "cmdValorizar": Call Valorizar
   Case Is = "cmdRangos": Call M_Rangos
   Case Is = "cmdGrabar": Call Grabar
   Case Is = "cmdBuscar": Call Buscar
   Case Is = "cmdLimpiar": Call Limpiar
   Case Is = "cmdCerrar": Call cerrar
End Select
End Sub
Sub cerrar()
   Unload Me
End Sub
