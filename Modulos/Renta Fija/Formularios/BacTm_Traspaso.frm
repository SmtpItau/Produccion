VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacTm_Traspaso 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Cierre de Valorización"
   ClientHeight    =   4170
   ClientLeft      =   345
   ClientTop       =   1455
   ClientWidth     =   9975
   ForeColor       =   &H00C0C0C0&
   Icon            =   "BacTm_Traspaso.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   NegotiateMenus  =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4170
   ScaleWidth      =   9975
   Begin VB.Frame Frame2 
      Caption         =   "Escenario"
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   735
      Left            =   4080
      TabIndex        =   5
      Top             =   600
      Width           =   3855
      Begin VB.ComboBox CmbEscenario 
         Enabled         =   0   'False
         Height          =   315
         ItemData        =   "BacTm_Traspaso.frx":030A
         Left            =   120
         List            =   "BacTm_Traspaso.frx":031A
         Style           =   2  'Dropdown List
         TabIndex        =   6
         Top             =   260
         Width           =   3615
      End
   End
   Begin VB.Frame Frame1 
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      Height          =   735
      Left            =   120
      TabIndex        =   1
      Top             =   600
      Width           =   3735
      Begin BACControles.TXTFecha txtFecha1 
         Height          =   375
         Left            =   2280
         TabIndex        =   2
         Top             =   240
         Width           =   1335
         _ExtentX        =   2355
         _ExtentY        =   661
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
         Text            =   "24/07/2001"
      End
      Begin VB.Label Label1 
         Caption         =   "Fecha Valorización"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   255
         Left            =   120
         TabIndex        =   3
         Top             =   360
         Width           =   2055
      End
   End
   Begin MSComctlLib.Toolbar Tool 
      Align           =   1  'Align Top
      Height          =   495
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   9975
      _ExtentX        =   17595
      _ExtentY        =   873
      ButtonWidth     =   847
      ButtonHeight    =   820
      AllowCustomize  =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdrefrescar"
            Description     =   "Refrescar"
            Object.ToolTipText     =   "Tabular "
            ImageIndex      =   14
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdlimpiar"
            Description     =   "Limpiar"
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   16
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdprocesa"
            Description     =   "Procesa"
            Object.ToolTipText     =   "Procesa"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdCerrar"
            Description     =   "Cerrar"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   18
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   0
      Top             =   0
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   25
      ImageHeight     =   25
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   18
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacTm_Traspaso.frx":034E
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacTm_Traspaso.frx":07A0
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacTm_Traspaso.frx":0DCA
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacTm_Traspaso.frx":0F24
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacTm_Traspaso.frx":123E
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacTm_Traspaso.frx":1558
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacTm_Traspaso.frx":1872
            Key             =   ""
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacTm_Traspaso.frx":1B8C
            Key             =   ""
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacTm_Traspaso.frx":1FDE
            Key             =   ""
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacTm_Traspaso.frx":2430
            Key             =   ""
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacTm_Traspaso.frx":274A
            Key             =   ""
         EndProperty
         BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacTm_Traspaso.frx":2B9C
            Key             =   ""
         EndProperty
         BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacTm_Traspaso.frx":2FEE
            Key             =   ""
         EndProperty
         BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacTm_Traspaso.frx":3148
            Key             =   ""
         EndProperty
         BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacTm_Traspaso.frx":359A
            Key             =   ""
         EndProperty
         BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacTm_Traspaso.frx":38B4
            Key             =   ""
         EndProperty
         BeginProperty ListImage17 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacTm_Traspaso.frx":3BCE
            Key             =   ""
         EndProperty
         BeginProperty ListImage18 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacTm_Traspaso.frx":4020
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSFlexGridLib.MSFlexGrid Table1 
      Height          =   2595
      Left            =   105
      TabIndex        =   4
      Top             =   1470
      Width           =   9795
      _ExtentX        =   17277
      _ExtentY        =   4577
      _Version        =   393216
      FixedCols       =   0
      BackColor       =   12632256
      ForeColor       =   8388608
      BackColorFixed  =   8421376
      ForeColorFixed  =   16777215
      BackColorBkg    =   12632256
      AllowBigSelection=   0   'False
      FocusRect       =   0
      GridLines       =   2
   End
End
Attribute VB_Name = "BacTm_Traspaso"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim Con As Integer

Option Explicit



Const Btn_Buscar = 1
Const Btn_Limpiar = 2
Const Btn_Procesa = 3
Const Btn_Salir = 4


Sub Imprime_InformeValorizacion()

'    If Not Parametros_Reportes(701, 0, "T", txtFecha1.Text, gsBac_Fecp, gsBac_Fecp, "VALORIZACION MERCADO") Then
'        Exit Sub
'    End If


 BacTrader.bacrpt.ReportFileName = RptList_Path & "TM_VALORMERC.RPT"
''''BacTrader.bacrpt.StoredProcParam(0) = "BTR"
''''BacTrader.bacrpt.StoredProcParam(1) = Format(txtFecha1.Text, "yyyymmdd")
''''BacTrader.bacrpt.StoredProcParam(2) = "T"
''''BacTrader.bacrpt.StoredProcParam(3) = "VALORIZACION MERCADO " '"Sp_tasamercado_Inforvalmercado"
 BacTrader.bacrpt.Connect = CONECCION
 BacTrader.bacrpt.Action = 1

    Unload Me

End Sub
Sub Limpiar()

    Me.Tool.Buttons(Btn_Buscar).Enabled = True
    Me.Tool.Buttons(Btn_Procesa).Enabled = False
    Me.Tool.Buttons(Btn_Limpiar).Enabled = True

    Me.txtFecha1.Enabled = True
    Me.txtFecha1.Text = gsBac_Fecp
    
    Call Titulos_grilla

End Sub
Sub Refrescar()

    Screen.MousePointer = 11
    
    Call Buscar_Fecha
        
    Screen.MousePointer = 0
    
End Sub

Private Sub Buscar_Fecha()

    Dim lv_fecrec   As Variant
    Dim Datos()
    Dim xRepuesta   As Integer
    Dim nSw         As Integer
    
    Envia = Array()
    AddParam Envia, CDate(Me.txtFecha1.Text)
    AddParam Envia, CmbEscenario.ItemData(CmbEscenario.ListIndex)
    
    If Not Bac_Sql_Execute("SP_TASAMERCADO_CHEQUEAPROCESO", Envia) Then
        MsgBox "Problemas al Ejecutar Proceso", vbCritical, gsBac_Version
        Exit Sub
    End If
    
    
    Do While Bac_SQL_Fetch(Datos())
        If Datos(1) = "NO" Then
            MsgBox "Fecha No se Encuentra en Archivo de Valorazacion Mercado", vbExclamation, gsBac_Version
            Exit Sub
        End If
    Loop
    
    
    Envia = Array()
    AddParam Envia, CDate(Me.txtFecha1.Text)
    AddParam Envia, CmbEscenario.ItemData(CmbEscenario.ListIndex)
    
    If Not Bac_Sql_Execute("SP_TASAMERCADO_RESUMEN", Envia) Then
        MsgBox "Problemas al Ejecutar Proceso", vbCritical, gsBac_Version
        Exit Sub
    End If
    
    Table1.Rows = 1
    
    Do While Bac_SQL_Fetch(Datos())
              
        With Table1
        
            .Rows = .Rows + 1
        
            .TextMatrix(0, 0) = "Cartera"
            .TextMatrix(0, 1) = "Tipo Cartera SBIF"
            .TextMatrix(0, 2) = "Valor Presente"
            .TextMatrix(0, 3) = "Valor Mercado"
            .TextMatrix(0, 4) = "Ajuste"
             
            .TextMatrix(.Rows - 1, 0) = Datos(1)
            .TextMatrix(.Rows - 1, 1) = Datos(2)
            .TextMatrix(.Rows - 1, 2) = Format(Datos(3), "###,###,###,##0")
            .TextMatrix(.Rows - 1, 3) = Format(Datos(4), "###,###,###,##0")
            .TextMatrix(.Rows - 1, 4) = Format(Datos(5), "###,###,###,##0")
            .RowHeight(.Rows - 1) = 350

        End With
    Loop
    
        
    Me.Tool.Buttons(Btn_Buscar).Enabled = False
    Me.Tool.Buttons(Btn_Procesa).Enabled = True
    Me.Tool.Buttons(Btn_Limpiar).Enabled = True
    
    txtFecha1.Enabled = False
        
End Sub
        
Private Sub Form_Load()
    
    Me.Top = 0
    Me.Left = 0
    
    'posiiono combo
    CmbEscenario.ListIndex = 0
    
    Call Limpiar

        
End Sub

Sub Titulos_grilla()

    Dim iCol As Integer

    Table1.Rows = 1

    With Table1
    
        .Cols = 5
        .Rows = 2
        
        .WordWrap = True
        For iCol = 0 To 4
            .Col = iCol
            .CellAlignment = 4
            .CellFontBold = True
            .FixedAlignment(iCol) = 4
            
        Next iCol

        .RowHeight(0) = 500

        .ColWidth(0) = 2900
        .ColWidth(1) = 1700
        .ColWidth(2) = 1700
        .ColWidth(3) = 1700
        .ColWidth(4) = 1700
        
        .TextMatrix(0, 0) = "Cartera"
        .TextMatrix(0, 1) = "Tipo Cartera SBIF"
        .TextMatrix(0, 2) = "Valor Presente"
        .TextMatrix(0, 3) = "Valor Mercado"
        .TextMatrix(0, 4) = "Ajuste"
             
    End With
    
   
End Sub


Private Sub Tool_ButtonClick(ByVal Button As MSComctlLib.Button)

    Select Case Button.Key
       Case Is = "cmdrefrescar":  Call Refrescar
       Case Is = "cmdlimpiar":    Call Limpiar
       Case Is = "cmdprocesa":    Call Actualizar_cartera
       Case Is = "cmdCerrar":     Unload Me
    End Select
    
End Sub

Sub Actualizar_cartera()

    Envia = Array()
    AddParam Envia, Me.txtFecha1.Text

    If Not Bac_Sql_Execute("SP_TASAMERCADO_ACTUALIZA_MDRS", Envia) Then
        MsgBox "Se ha producido mientras se actualizabab la cartera.Proceso abortado", vbCritical, gsBac_Version
        Exit Sub
    End If
    
    MsgBox "La Cartera ha sido Actualizada Exitosamente", vbInformation, gsBac_Version
    
    Unload Me
    
End Sub

