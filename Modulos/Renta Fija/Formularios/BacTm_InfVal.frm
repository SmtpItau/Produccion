VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacTm_Informes 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Informes de Tasa de Mercado"
   ClientHeight    =   4740
   ClientLeft      =   1920
   ClientTop       =   2010
   ClientWidth     =   3900
   ForeColor       =   &H00C0C0C0&
   Icon            =   "BacTm_InfVal.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   NegotiateMenus  =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4740
   ScaleWidth      =   3900
   Begin VB.Frame Fr_Excel 
      Caption         =   "Exportar a Excel"
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   11.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   975
      Left            =   120
      TabIndex        =   16
      Top             =   3600
      Width           =   3615
      Begin VB.PictureBox ConCheck 
         BorderStyle     =   0  'None
         Height          =   330
         Index           =   3
         Left            =   600
         Picture         =   "BacTm_InfVal.frx":030A
         ScaleHeight     =   330
         ScaleWidth      =   330
         TabIndex        =   18
         Top             =   480
         Visible         =   0   'False
         Width           =   330
      End
      Begin VB.PictureBox SinCheck 
         BorderStyle     =   0  'None
         Height          =   330
         Index           =   3
         Left            =   240
         Picture         =   "BacTm_InfVal.frx":0464
         ScaleHeight     =   330
         ScaleWidth      =   375
         TabIndex        =   17
         Top             =   480
         Width           =   375
      End
      Begin VB.Label Etiqueta 
         AutoSize        =   -1  'True
         Caption         =   "Valorización a Tasa de Mercado"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   3
         Left            =   840
         TabIndex        =   19
         Top             =   480
         Width           =   2295
      End
   End
   Begin VB.Frame Frame2 
      Caption         =   "Informes"
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   11.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   1590
      Left            =   120
      TabIndex        =   2
      Top             =   1920
      Width           =   3615
      Begin VB.PictureBox SinCheck 
         BorderStyle     =   0  'None
         Height          =   330
         Index           =   0
         Left            =   240
         Picture         =   "BacTm_InfVal.frx":05BE
         ScaleHeight     =   330
         ScaleWidth      =   375
         TabIndex        =   8
         Top             =   360
         Width           =   375
      End
      Begin VB.PictureBox ConCheck 
         BorderStyle     =   0  'None
         Height          =   330
         Index           =   0
         Left            =   3150
         Picture         =   "BacTm_InfVal.frx":0718
         ScaleHeight     =   330
         ScaleWidth      =   330
         TabIndex        =   7
         Top             =   360
         Visible         =   0   'False
         Width           =   330
      End
      Begin VB.PictureBox SinCheck 
         BorderStyle     =   0  'None
         Height          =   330
         Index           =   1
         Left            =   240
         Picture         =   "BacTm_InfVal.frx":0872
         ScaleHeight     =   330
         ScaleWidth      =   375
         TabIndex        =   6
         Top             =   765
         Width           =   375
      End
      Begin VB.PictureBox SinCheck 
         BorderStyle     =   0  'None
         Height          =   330
         Index           =   2
         Left            =   240
         Picture         =   "BacTm_InfVal.frx":09CC
         ScaleHeight     =   330
         ScaleWidth      =   375
         TabIndex        =   5
         Top             =   1170
         Width           =   375
      End
      Begin VB.PictureBox ConCheck 
         BorderStyle     =   0  'None
         Height          =   330
         Index           =   1
         Left            =   3150
         Picture         =   "BacTm_InfVal.frx":0B26
         ScaleHeight     =   330
         ScaleWidth      =   330
         TabIndex        =   4
         Top             =   765
         Visible         =   0   'False
         Width           =   330
      End
      Begin VB.PictureBox ConCheck 
         BorderStyle     =   0  'None
         Height          =   330
         Index           =   2
         Left            =   3150
         Picture         =   "BacTm_InfVal.frx":0C80
         ScaleHeight     =   330
         ScaleWidth      =   330
         TabIndex        =   3
         Top             =   1200
         Visible         =   0   'False
         Width           =   330
      End
      Begin VB.Label Etiqueta 
         AutoSize        =   -1  'True
         Caption         =   "Detalle Valorización"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   0
         Left            =   720
         TabIndex        =   11
         Top             =   405
         Width           =   1395
      End
      Begin VB.Label Etiqueta 
         AutoSize        =   -1  'True
         Caption         =   "Resumen Valorización"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   1
         Left            =   720
         TabIndex        =   10
         Top             =   810
         Width           =   1575
      End
      Begin VB.Label Etiqueta 
         AutoSize        =   -1  'True
         Caption         =   "Informe de Tasas"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   2
         Left            =   720
         TabIndex        =   9
         Top             =   1215
         Width           =   1230
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
      Height          =   1240
      Left            =   120
      TabIndex        =   1
      Top             =   600
      Width           =   3615
      Begin VB.ComboBox CmbEscenario 
         Height          =   315
         ItemData        =   "BacTm_InfVal.frx":0DDA
         Left            =   1560
         List            =   "BacTm_InfVal.frx":0DEA
         Style           =   2  'Dropdown List
         TabIndex        =   14
         Top             =   780
         Width           =   1815
      End
      Begin BACControles.TXTFecha txtFecha1 
         Height          =   375
         Left            =   1560
         TabIndex        =   12
         Top             =   300
         Width           =   1815
         _ExtentX        =   3201
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
      Begin VB.Label Label2 
         Caption         =   "Escenario"
         ForeColor       =   &H00800000&
         Height          =   255
         Left            =   120
         TabIndex        =   15
         Top             =   810
         Width           =   1815
      End
      Begin VB.Label Label1 
         Caption         =   "Fecha Valorización"
         ForeColor       =   &H00800000&
         Height          =   255
         Left            =   120
         TabIndex        =   13
         Top             =   360
         Width           =   1695
      End
   End
   Begin MSComctlLib.Toolbar Tool 
      Height          =   495
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   7875
      _ExtentX        =   13891
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
            Key             =   "impresora"
            Description     =   "Informe Valorizacion"
            Object.ToolTipText     =   "Informe Valorizacion"
            ImageIndex      =   15
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "pantalla"
            Object.ToolTipText     =   "Imprimir Informe en Pantalla"
            ImageIndex      =   9
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Key             =   "Excel"
            Object.ToolTipText     =   "Exportar Valorización a Excel"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "salir"
            Description     =   "Cerrar"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   18
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   3360
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
            Picture         =   "BacTm_InfVal.frx":0E1E
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacTm_InfVal.frx":1270
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacTm_InfVal.frx":189A
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacTm_InfVal.frx":19F4
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacTm_InfVal.frx":1D0E
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacTm_InfVal.frx":2028
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacTm_InfVal.frx":2342
            Key             =   ""
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacTm_InfVal.frx":265C
            Key             =   ""
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacTm_InfVal.frx":2AAE
            Key             =   ""
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacTm_InfVal.frx":2F00
            Key             =   ""
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacTm_InfVal.frx":321A
            Key             =   ""
         EndProperty
         BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacTm_InfVal.frx":366C
            Key             =   ""
         EndProperty
         BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacTm_InfVal.frx":3ABE
            Key             =   ""
         EndProperty
         BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacTm_InfVal.frx":3C18
            Key             =   ""
         EndProperty
         BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacTm_InfVal.frx":406A
            Key             =   ""
         EndProperty
         BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacTm_InfVal.frx":4384
            Key             =   ""
         EndProperty
         BeginProperty ListImage17 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacTm_InfVal.frx":469E
            Key             =   ""
         EndProperty
         BeginProperty ListImage18 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacTm_InfVal.frx":4AF0
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "BacTm_Informes"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim Con As Integer

Option Explicit



Const Btn_Buscar = 2
Const Btn_Limpiar = 3
Const Btn_InfVal = 4
Const Btn_Salir = 5

Sub Imprime_InformeValorizacion(Destino As Integer)

    'declaro variables locales
    Dim I As Integer
    
    'limpio los reports
    Call Limpiar_Cristal
    
    'si la fecha existe...
    If Buscar_Fecha <> True Then
        Exit Sub
    End If
    
    'destino del reporte
    BacTrader.bacrpt.Destination = Destino
    
    'de uno al total de checks
    For I = 0 To ConCheck.Count - 1
    
        'si el check esta seleccionado
        If ConCheck.Item(I).Visible = True Then
            
            'select case con la seleccion
            Select Case I
                    
                Case 0
                        'If Not Parametros_Reportes(701, 0, "T", txtFecha1.Text, gsBac_Fecp, gsBac_Fecp, "VALORIZACION MERCADO") Then
                        '    Exit Sub
                        'End If
                        Limpiar_Cristal
                        BacTrader.bacrpt.WindowTitle = "INFORME DE VALORIZACION A MERCADO"
                        BacTrader.bacrpt.ReportFileName = RptList_Path & "TM_VALORMERC.RPT"
                        BacTrader.bacrpt.StoredProcParam(0) = Format(txtFecha1.Text, "yyyymmdd")
                        BacTrader.bacrpt.StoredProcParam(1) = "INFORME DE VALORIZACION A MERCADO"
                        BacTrader.bacrpt.StoredProcParam(2) = CmbEscenario.ItemData(CmbEscenario.ListIndex)
                        BacTrader.bacrpt.Connect = CONECCION
                        BacTrader.bacrpt.Action = 1
                        
                    Case 1
                        Limpiar_Cristal
                        BacTrader.bacrpt.WindowTitle = "RESUMEN DE VALORIZACION A MERCADO"
                        BacTrader.bacrpt.ReportFileName = RptList_Path & "RS_VALORMERC.RPT"
                        BacTrader.bacrpt.StoredProcParam(0) = Format(txtFecha1.Text, "yyyymmdd")
                        BacTrader.bacrpt.StoredProcParam(1) = "RESUMEN DE VALORIZACION A MERCADO"
                        BacTrader.bacrpt.StoredProcParam(2) = CmbEscenario.ItemData(CmbEscenario.ListIndex)
                        BacTrader.bacrpt.Connect = CONECCION
                        BacTrader.bacrpt.Action = 1


                    Case 2
                        
                        BacTrader.bacrpt.WindowTitle = "TASAS DE VALORIZACION A MERCADO"
                        BacTrader.bacrpt.ReportFileName = RptList_Path & "TM_TASAS.RPT"
                        BacTrader.bacrpt.StoredProcParam(0) = Format(txtFecha1.Text, "yyyymmdd")
                        BacTrader.bacrpt.StoredProcParam(1) = "TASAS DE VALORIZACION A MERCADO"
                        BacTrader.bacrpt.StoredProcParam(2) = CmbEscenario.ItemData(CmbEscenario.ListIndex)
                        BacTrader.bacrpt.Connect = CONECCION
                        BacTrader.bacrpt.Action = 1

                    
            End Select
        End If
    Next I

End Sub
Private Function Buscar_Fecha()

    'declaro variables locales
    Dim lv_fecrec   As Variant
    Dim Datos()
    Dim xRepuesta   As Integer
    Dim nSw         As Integer
    
    'sw de respuesta
    Buscar_Fecha = False
    
    'preparo parametros para sp
    Envia = Array()
    AddParam Envia, CDate(Me.txtFecha1.Text)
    AddParam Envia, CmbEscenario.ItemData(CmbEscenario.ListIndex)
    
    'ejecuto sp
    If Not Bac_Sql_Execute("SP_TASAMERCADO_CHEQUEAPROCESO ", Envia) Then
    
        'aviso al usuario
        MsgBox "Problemas al Ejecutar Proceso", vbCritical, gsBac_Version
        Exit Function
    End If
    
    'recorro los datos del sp
    Do While Bac_SQL_Fetch(Datos())
    
        'no existen datos...
        If Datos(1) = "NO" Then
        
            'aviso al usuario
            MsgBox "Fecha No se Encuentra en Archivo de Valorizacion Mercado", vbExclamation, gsBac_Version
            Exit Function
        End If
    Loop
    
    'sw de respuesta
    Buscar_Fecha = True
        
End Function
        
Private Sub ConCheck_Click(Index As Integer)

    SinCheck.Item(Index).Visible = Not SinCheck.Item(Index).Visible
    ConCheck.Item(Index).Visible = Not ConCheck.Item(Index).Visible
    If Index = 4 Then
        Tool.Buttons(Index).Visible = False
    End If

End Sub

Private Sub Form_Load()
    
    'seteo la ventana
    Me.Move 0, 0
    Me.Icon = BacTrader.Icon
    
    'escenario
    CmbEscenario.ListIndex = 0
    
    'fecha del sistema
    txtFecha1.Text = Format(gsBac_Fecp, "DD/MM/YYYY")

End Sub

Private Sub SinCheck_Click(Index As Integer)

    ConCheck.Item(Index).Left = SinCheck.Item(Index).Left
    SinCheck.Item(Index).Visible = Not SinCheck.Item(Index).Visible
    ConCheck.Item(Index).Visible = Not ConCheck.Item(Index).Visible
    If Index = 3 Then
        Tool.Buttons(Index).Visible = True
    End If

End Sub

Private Sub Tool_ButtonClick(ByVal Button As MSComctlLib.Button)

    Select Case UCase(Button.Key)
       Case Is = "IMPRESORA":   Call Imprime_InformeValorizacion(1)
       Case Is = "PANTALLA":    Call Imprime_InformeValorizacion(0)
       Case Is = "SALIR":       Unload Me
       Case Is = "EXCEL":       Call Exporta_Excel
    End Select
    
End Sub

Function Exporta_Excel()
Dim Linea As String
Dim Arr()
Dim J As Double
Dim I As Double
Dim Exc
Dim Hoja
Dim S As Integer
Dim Sheet
Dim Ruta As String
Dim Crea_xls As Boolean

Const Filas_Buffer = 150

'If Not Nombre_Archivo(Ruta, "Tasamer.xls", "Guardar Como", "Planilla Excel", "*.xls", "d:\") Then: Screen.MousePointer = 0: Exit Function
   
'no si el check esta seleccionado
If ConCheck.Item(0).Visible = False Then
        Exit Function
End If
   
Screen.MousePointer = 11
DoEvents

Envia = Array()
AddParam Envia, Format(txtFecha1.Text, "yyyymmdd")
AddParam Envia, CmbEscenario.ItemData(CmbEscenario.ListIndex)
If Not Bac_Sql_Execute("SP_TASAMERCADO_CARTERA_EXCEL", Envia) Then MsgBox "No se pudo generar Planilla", vbCritical, gsBac_Version: Screen.MousePointer = 0: Exit Function

Set Exc = CreateObject("Excel.Application")
Set Hoja = Exc.Application.Workbooks.Add.Sheets.Add
Set Sheet = Exc.ActiveSheet
Linea = ""

Linea = Linea & "tipo_operacion" & vbTab
Linea = Linea & "rminstser" & vbTab
Linea = Linea & "rut_emisor" & vbTab
Linea = Linea & "rmcodigo" & vbTab
Linea = Linea & "moneda_emision" & vbTab
Linea = Linea & "fecha_valorizacion" & vbTab
Linea = Linea & "inserie" & vbTab
Linea = Linea & "tasa_compra" & vbTab
Linea = Linea & "tasa_mercado" & vbTab
Linea = Linea & "codigo_carterasuper" & vbTab
Linea = Linea & "valor_nominal" & vbTab
Linea = Linea & "valor_presente" & vbTab
Linea = Linea & "valor_mercado"

Clipboard.Clear
Clipboard.SetText Linea
Sheet.Range("A1").Select
Sheet.Paste
Linea = ""
Clipboard.Clear

I = 1
Do While Bac_SQL_Fetch(Arr())

    For J = 1 To 13
        If (J > 2 And J < 6) Or (J > 7 And J < 10) Or (J > 10) Then
            Linea = Linea & BacStrTran(IIf(Trim(Arr(J)) = "", 0, Trim(Arr(J))), ",", ".") & vbTab
        Else
            If J = 6 Then
                Linea = Linea & Format(IIf(Trim(Arr(J)) = "", "01/01/1900", Trim(Arr(J))), "mm/dd/yyyy") & vbTab
            Else
                Linea = Linea & IIf(Trim(Arr(J)) = "", "NULL", Trim(Arr(J))) & vbTab
            End If
        End If
    Next J
    Linea = Linea + vbCrLf
    If I Mod Filas_Buffer = 0 Then
        Clipboard.Clear
        Clipboard.SetText Linea
        If I = Filas_Buffer Then
            Sheet.Range("A2").Select
        Else
            Sheet.Range("A" & CStr((I + 1) - Filas_Buffer)).Select
        End If
        Sheet.Paste
        Linea = ""
    End If

    Crea_xls = True
    I = I + 1
Loop
Clipboard.Clear
Clipboard.SetText Linea
Sheet.Range("A" & CStr((Int(I / Filas_Buffer) * Filas_Buffer) + IIf(I > Filas_Buffer, 1, 2))).Select
Sheet.Paste
Linea = ""
Clipboard.Clear

Sheet.Range("A1").Select

Hoja.Application.DisplayAlerts = False
For I = 2 To Hoja.Application.Sheets.Count
  Hoja.Application.Sheets(2).Delete
Next I
If Crea_xls Then
    Hoja.SaveAs (Ruta)
Else
    MsgBox "No se Encontró Información Correspondiente", vbExclamation, gsBac_Version
End If
Hoja.Application.Workbooks.Close

Screen.MousePointer = 0

Set Hoja = Nothing
Set Exc = Nothing
Set Sheet = Nothing

ConCheck_Click 0

End Function
