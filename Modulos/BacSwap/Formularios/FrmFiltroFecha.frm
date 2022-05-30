VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form FrmFiltroFecha 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Filtro por rango de Fechas"
   ClientHeight    =   1440
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   5895
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   1440
   ScaleWidth      =   5895
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   5895
      _ExtentX        =   10398
      _ExtentY        =   794
      ButtonWidth     =   1958
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      Style           =   1
      TextAlignment   =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Aceptar"
            Key             =   "Aceptar"
            Object.ToolTipText     =   "Aceptar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Salir"
            Key             =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   3975
         Top             =   495
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   22
         ImageHeight     =   22
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   2
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FrmFiltroFecha.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FrmFiltroFecha.frx":0EDA
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame Frame1 
      Height          =   915
      Left            =   45
      TabIndex        =   1
      Top             =   390
      Width           =   5805
      Begin BACControles.TXTFecha Txt_fecha_desde 
         Height          =   285
         Left            =   1335
         TabIndex        =   3
         Top             =   180
         Width           =   1515
         _ExtentX        =   2672
         _ExtentY        =   503
         Enabled         =   -1  'True
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "14/08/2006"
      End
      Begin BACControles.TXTFecha Txt_Fecha_Hasta 
         Height          =   285
         Left            =   1335
         TabIndex        =   5
         Top             =   510
         Width           =   1515
         _ExtentX        =   2672
         _ExtentY        =   503
         Enabled         =   -1  'True
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "14/08/2006"
      End
      Begin VB.Label LblFechaLargaHasta 
         Caption         =   "Miercoles, 21 de Septiembre del 2007"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   270
         Left            =   2895
         TabIndex        =   8
         Top             =   540
         Width           =   2775
      End
      Begin VB.Label LblFechaLargaDesde 
         Caption         =   "Miercoles, 21 de Septiembre del 2007"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   270
         Left            =   2895
         TabIndex        =   7
         Top             =   210
         Width           =   2775
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "Fecha Hasta"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Left            =   150
         TabIndex        =   6
         Top             =   555
         Width           =   1035
      End
      Begin VB.Label lblFecha 
         Alignment       =   2  'Center
         Caption         =   "Miercoles, 21 de Septiembre del 2006"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H000000FF&
         Height          =   285
         Left            =   45
         TabIndex        =   4
         Top             =   1485
         Width           =   4155
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Fecha Desde"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Left            =   165
         TabIndex        =   2
         Top             =   225
         Width           =   1065
      End
   End
End
Attribute VB_Name = "FrmFiltroFecha"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub Form_Load()
Dim FecProcAnt   As Date
Dim Aux          As Date
   Me.Icon = BACSwap.Icon
   FecProcAnt = Format(gsc_Parametros.FechaAnt, gsc_FechaDMA)
   FecProcProx = Format(gsc_Parametros.fechaprox, gsc_FechaDMA)
        
'''    Envia = Array()
'''    AddParam Envia, CDate(gsBAC_Fecp)
'''    AddParam Envia, CInt(1)    'Dia anterior
'''    AddParam Envia, CStr(";6;") 'Plaza Paises (Chile)
'''    AddParam Envia, "v"
''''    If MISQL.SQL_Execute(Sql) > 0 Then
'''    If Not Bac_Sql_Execute("BacParamSuda.dbo.SP_AGREGA_N_DIAS_HABILES", Envia) Then
'''       Exit Sub
'''    End If
'''    If Bac_SQL_Fetch(Datos()) Then
'''        Aux = DateAdd("d", -1, Datos(1))
'''    End If
   Aux = DateAdd("d", -1, FecProcProx)
   
   
   If filtroini <> "" Then
        Txt_fecha_desde.Text = filtroini
    Else
        Txt_fecha_desde.Text = gsBAC_Fecp
    End If
   LblFechaLargaDesde.Caption = Format(Txt_fecha_desde.Text, "dddd, dd") & " de " & Format(Txt_fecha_desde.Text, "mmmm") & " del " & Format(Txt_fecha_desde.Text, "yyyy")
   
   
   If filtrofin <> "" Then
        Txt_Fecha_Hasta.Text = filtrofin
   Else
        Txt_Fecha_Hasta.Text = Aux
   End If
   
   
   LblFechaLargaHasta.Caption = Format(Txt_Fecha_Hasta.Text, "dddd, dd") & " de " & Format(Txt_Fecha_Hasta.Text, "mmmm") & " del " & Format(Txt_Fecha_Hasta.Text, "yyyy")
   
   ''If filtroini <> "" Or filtrofin <> "" Then
   ''  Call Me.FiltraFlujos
   
   
End Sub

Private Sub Form_LostFocus()
    If FrmFiltroFecha.Visible = True Then
        FrmFiltroFecha.SetFocus
    End If
End Sub

Private Sub Form_Unload(Cancel As Integer)
    If BacTasaFlujo.Visible = True Then
        BacTasaFlujo.Enabled = True
    End If

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 1
        Call FiltraFlujos
           FecProcAnt = Format(gsc_Parametros.FechaAnt, gsc_FechaDMA)
      Case 2
         Unload FrmFiltroFecha
   End Select
End Sub
Private Sub Txt_fecha_desde_Change()
   LblFechaLargaDesde.Caption = Format(Txt_fecha_desde.Text, "dddd, dd") & " de " & Format(Txt_fecha_desde.Text, "mmmm") & " del " & Format(Txt_fecha_desde.Text, "yyyy")
filtroini = Txt_fecha_desde.Text
End Sub
Private Sub Txt_Fecha_Hasta_Change()
   LblFechaLargaHasta.Caption = Format(Txt_Fecha_Hasta.Text, "dddd, dd") & " de " & Format(Txt_Fecha_Hasta.Text, "mmmm") & " del " & Format(Txt_Fecha_Hasta.Text, "yyyy")
     filtrofin = Txt_Fecha_Hasta.Text
End Sub

Public Sub FiltraFlujos()
Dim dtFecFijacion As Date
Dim strFeriadosLiq As String
Dim strFechaFila As String
Dim intFila As Integer
Dim nNumero As Double
Dim i As Integer

   Envia = Array()
   AddParam Envia, CDbl(BacTasaFlujo.chkSwapICP.Value)
   AddParam Envia, Txt_fecha_desde.Text
   AddParam Envia, Txt_Fecha_Hasta.Text
   If Not Bac_Sql_Execute("SP_CONSULTAFLUJOSINICIAN", Envia) Then
      MsgBox "Problemas al leer procedimiento  " & vbCrLf & "SP_CONSULTAFLUJOSINICIAN", vbCritical, TITSISTEMA
      Exit Sub
   End If
   
   nNumero = 0
   BacTasaFlujo.Table1.Rows = 1
   'Call BacTasaFlujo.Dibuja_Grilla
   Do While Bac_SQL_Fetch(Datos())
         'BacTasaFlujo.Table1.ColWidth(9) = 0
         'BacTasaFlujo.Table1.TextMatrix(0, 5) = "Inicio Flujo"
         Call BacControlWindows(100)
         
            intFila = BacTasaFlujo.Table1.Rows - 1
         
            nNumero = Datos(2)
            BacTasaFlujo.Table1.Rows = BacTasaFlujo.Table1.Rows + 1
            BacTasaFlujo.Table1.Row = BacTasaFlujo.Table1.Rows - 1
            BacTasaFlujo.Table1.Col = 1: BacTasaFlujo.Table1.Text = Val(Datos(2))                                               'Numero Operación
            BacTasaFlujo.Table1.Col = 2: BacTasaFlujo.Table1.Text = Datos(3)                                                    'Nombre Cliente
            BacTasaFlujo.Table1.Col = 3: BacTasaFlujo.Table1.Text = Datos(1)                                                    'Tipo Producto
            BacTasaFlujo.Table1.Col = 4: BacTasaFlujo.Table1.Text = Datos(39)                                                    'Tipo Producto
            BacTasaFlujo.Table1.Col = 5: BacTasaFlujo.Table1.Text = Val(Datos(13))                                              'Numero Flujo
            BacTasaFlujo.Table1.Col = 6: BacTasaFlujo.Table1.Text = Datos(14)                                                   'Fecha Inicio Flujo
'''            If Datos(20) = 0 Then
'''               BacTasaFlujo.Table1.Col = 7: BacTasaFlujo.Table1.Text = Datos(23)                                                 'Nombre Tasa
'''               BacTasaFlujo.Table1.Col = 8: BacTasaFlujo.Table1.Text = BacFormatoMonto(CDbl(Datos(19)), 6)                       'Valor Tasa
'''            Else
               If Datos(24) = 1 Then
                  BacTasaFlujo.Table1.Col = 7: BacTasaFlujo.Table1.Text = Datos(22)                                                 'Nombre Tasa
                  BacTasaFlujo.Table1.Col = 8: BacTasaFlujo.Table1.Text = BacFormatoMonto(CDbl(Datos(18)), 6)                       'Valor Tasa
               Else
                  BacTasaFlujo.Table1.Col = 7: BacTasaFlujo.Table1.Text = Datos(23)                                                 'Nombre Tasa
                  BacTasaFlujo.Table1.Col = 8: BacTasaFlujo.Table1.Text = BacFormatoMonto(CDbl(Datos(19)), 6)                       'Valor Tasa
               End If
'''             End If
            BacTasaFlujo.Table1.Col = 9: BacTasaFlujo.Table1.Text = Datos(24)
            BacTasaFlujo.Table1.Col = 10: BacTasaFlujo.Table1.Text = Datos(31)
            BacTasaFlujo.Table1.Col = 11: BacTasaFlujo.Table1.Text = BacFormatoMonto(Datos(26), 6)
            BacTasaFlujo.Table1.Col = 12: BacTasaFlujo.Table1.Text = Datos(27)
            BacTasaFlujo.Table1.Col = 13: BacTasaFlujo.Table1.Text = Datos(28)
            BacTasaFlujo.Table1.Col = 14: BacTasaFlujo.Table1.Text = Datos(29)
            BacTasaFlujo.Table1.Col = 15: BacTasaFlujo.Table1.Text = Datos(30)
            BacTasaFlujo.Table1.Col = 16: BacTasaFlujo.Table1.Text = Datos(20)
            BacTasaFlujo.Table1.Col = 17: BacTasaFlujo.Table1.Text = Datos(21)
            BacTasaFlujo.Table1.Col = 18: BacTasaFlujo.Table1.Text = Datos(32)
            BacTasaFlujo.Table1.Col = 19: BacTasaFlujo.Table1.Text = Datos(33)
            
'''            If Datos(35) = 0 Then
'''                BacTasaFlujo.Table1.Col = 20: BacTasaFlujo.Table1.Text = ""
'''                BacTasaFlujo.Table1.Col = 21: BacTasaFlujo.Table1.Text = ""
'''            Else
'''                BacTasaFlujo.Table1.Col = 20: BacTasaFlujo.Table1.Text = Datos(34)
'''                BacTasaFlujo.Table1.Col = 21: BacTasaFlujo.Table1.Text = BacFormatoMonto(Datos(35), 6)
'''            End If
'''         uniformizando con la carga desde el objeto BacTasaFlujo

            BacTasaFlujo.Table1.Col = 20: BacTasaFlujo.Table1.Text = IIf(Datos(34) <> "01-01-1900", Datos(34), "")                      'fecha_propuesta=fecha_rescate                                       '-> Fecha Propuesta
            BacTasaFlujo.Table1.Col = 21: BacTasaFlujo.Table1.Text = IIf(Datos(35) <> 0, Datos(35), "")                                 '-> Tasa Propuesta
            
            
            'BacTasaFlujo.Table1.Col = 22: BacTasaFlujo.Table1.Text = Datos(40)
            For i = 0 To 21
            'If Datos(36) = "X" Or Datos(37) = "X" Then
            If Datos(40) = "X" Then 'Mostrando feriado en el pais del índice
                BacTasaFlujo.Table1.Row = BacTasaFlujo.Table1.Rows - 1
                BacTasaFlujo.Table1.Col = i
                BacTasaFlujo.Table1.CellBackColor = vbYellow
                BacTasaFlujo.Table1.Col = 0
                'BacTasaFlujo.Table1.Text = "¤"
                BacTasaFlujo.Table1.CellForeColor = &HC0&
                BacTasaFlujo.Table1.CellFontBold = True
                BacTasaFlujo.Toolbar1.Buttons(6).Enabled = True
                'BacTasaFlujo.Toolbar1.Buttons(3).Enabled = True
             End If
        Next

            
            
            
            
            
            '******************************************************************
            ' Cambios PRD 21657
           ' dtFecFijacion = CDate(Datos(27))
            'strFeriadosLiq = Trim(Datos(28)) & "-" & Trim(Datos(29)) & "-" & Trim(Datos(30))
            'If strFechaFila = "" Then
             '   strFechaFila = CStr(intFila) & " / " & CStr(dtFecFijacion) & " / " & strFeriadosLiq
            'Else
             '   strFechaFila = strFechaFila & "," & CStr(intFila) & " / " & CStr(dtFecFijacion) & " / " & strFeriadosLiq
            'End If
            ' FIN Cambios PRD 21657
            '*******************************************************************
   Loop
   
   If BacTasaFlujo.Table1.Rows < 2 Then
      BacTasaFlujo.Table1.Redraw = True
      MsgBox "No Hay Vencimientos de Flujos para rango de fechas", vbOKOnly, "MENSAJE"
      FrmFiltroFecha.SetFocus
   Else
      BacTasaFlujo.frame(1).Enabled = True
      BacTasaFlujo.Toolbar1.Buttons(3).Enabled = True 'MAP17072015 se elimna comentario
                                                      'Se necesita activo este botón
                                                      'para fijar tasas e
      BacTasaFlujo.Table1.Redraw = True
      ' Cambios PRD 21657
      '******************************************************************
      ' REVISO SI FECHAS OBTENIDAS EN LOS FLUJOS CAEN EN DIAS NO HABILES
      '******************************************************************
     ' Call BacTasaFlujo.ValidaFechasInhabiles(strFechaFila)
      ' FIN  Cambios PRD 21657
      Unload FrmFiltroFecha
   End If
End Sub


