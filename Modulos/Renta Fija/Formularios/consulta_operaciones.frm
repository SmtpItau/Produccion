VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.3#0"; "comctl32.ocx"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form consulta_operaciones 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Consulta De Operaciones Historicas"
   ClientHeight    =   5715
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   11355
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   5715
   ScaleWidth      =   11355
   ShowInTaskbar   =   0   'False
   Begin ComctlLib.Toolbar Toolbar1 
      Height          =   480
      Left            =   0
      TabIndex        =   21
      Top             =   -30
      Width           =   11370
      _ExtentX        =   20055
      _ExtentY        =   847
      ButtonWidth     =   767
      ButtonHeight    =   741
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   327682
      BeginProperty Buttons {0713E452-850A-101B-AFC0-4210102A8DA7} 
         NumButtons      =   4
         BeginProperty Button1 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Object.ToolTipText     =   "Buscar"
            Object.Tag             =   ""
            ImageIndex      =   3
         EndProperty
         BeginProperty Button2 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Object.ToolTipText     =   "Imprimir"
            Object.Tag             =   ""
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Object.ToolTipText     =   "Limpiar"
            Object.Tag             =   ""
            ImageIndex      =   1
         EndProperty
         BeginProperty Button4 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Object.ToolTipText     =   "Salir"
            Object.Tag             =   ""
            ImageIndex      =   4
         EndProperty
      EndProperty
   End
   Begin VB.Frame Frame1 
      Height          =   5295
      Left            =   0
      TabIndex        =   0
      Top             =   390
      Width           =   11355
      Begin VB.Frame Frame2 
         Height          =   1515
         Left            =   60
         TabIndex        =   2
         Top             =   135
         Width           =   11205
         Begin VB.ComboBox Cmb_Libro 
            Height          =   315
            Left            =   1440
            Style           =   2  'Dropdown List
            TabIndex        =   20
            Top             =   1125
            Width           =   3630
         End
         Begin VB.ComboBox Combo1 
            Height          =   315
            ItemData        =   "consulta_operaciones.frx":0000
            Left            =   1440
            List            =   "consulta_operaciones.frx":001C
            Sorted          =   -1  'True
            Style           =   2  'Dropdown List
            TabIndex        =   10
            Top             =   795
            Width           =   3630
         End
         Begin VB.TextBox txtusuario 
            Enabled         =   0   'False
            Height          =   285
            Left            =   5145
            MaxLength       =   15
            TabIndex        =   7
            Top             =   2460
            Visible         =   0   'False
            Width           =   1575
         End
         Begin VB.TextBox Text2 
            Enabled         =   0   'False
            Height          =   285
            Left            =   5130
            MaxLength       =   10
            TabIndex        =   6
            Top             =   3075
            Visible         =   0   'False
            Width           =   1590
         End
         Begin VB.TextBox txtnombre 
            BackColor       =   &H80000011&
            Height          =   285
            Left            =   5355
            Locked          =   -1  'True
            TabIndex        =   5
            TabStop         =   0   'False
            Top             =   420
            Width           =   5655
         End
         Begin VB.TextBox txtcodigo 
            Enabled         =   0   'False
            Height          =   300
            Left            =   5160
            TabIndex        =   4
            Top             =   2760
            Visible         =   0   'False
            Width           =   510
         End
         Begin BACControles.TXTNumero txtrut 
            Height          =   255
            Left            =   5355
            TabIndex        =   3
            ToolTipText     =   "Doble click para desplegar ayuda"
            Top             =   120
            Width           =   1575
            _ExtentX        =   2778
            _ExtentY        =   450
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
         Begin BACControles.TXTFecha TXTFecha2 
            Height          =   270
            Left            =   1440
            TabIndex        =   8
            Top             =   495
            Width           =   1575
            _ExtentX        =   2778
            _ExtentY        =   476
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
            Text            =   "29/08/2001"
         End
         Begin BACControles.TXTFecha TXTFecha1 
            Height          =   270
            Left            =   1440
            TabIndex        =   9
            Top             =   195
            Width           =   1575
            _ExtentX        =   2778
            _ExtentY        =   476
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
            Text            =   "29/08/2001"
         End
         Begin VB.Label Lbl_Libro 
            Caption         =   "Libro"
            Height          =   180
            Left            =   135
            TabIndex        =   19
            Top             =   1170
            Width           =   840
         End
         Begin VB.Label Label1 
            Caption         =   "Tipo Operación"
            Height          =   255
            Left            =   120
            TabIndex        =   18
            Top             =   840
            Width           =   1200
         End
         Begin VB.Label Label2 
            Caption         =   "Fecha Inicio"
            Height          =   255
            Left            =   135
            TabIndex        =   17
            Top             =   210
            Width           =   1170
         End
         Begin VB.Label Label3 
            Caption         =   "Fecha Término"
            Height          =   225
            Left            =   135
            TabIndex        =   16
            Top             =   525
            Width           =   1215
         End
         Begin VB.Label Label4 
            Caption         =   "Operador"
            Height          =   255
            Left            =   3840
            TabIndex        =   15
            Top             =   2475
            Visible         =   0   'False
            Width           =   1200
         End
         Begin VB.Label Label5 
            Caption         =   "Serie"
            Height          =   180
            Left            =   3825
            TabIndex        =   14
            Top             =   3135
            Visible         =   0   'False
            Width           =   1215
         End
         Begin VB.Label Label7 
            Caption         =   "Rut Cliente"
            Height          =   255
            Left            =   4050
            TabIndex        =   13
            Top             =   195
            Width           =   975
         End
         Begin VB.Label Label8 
            Caption         =   "Nombre"
            Height          =   255
            Left            =   4050
            TabIndex        =   12
            Top             =   480
            Width           =   855
         End
         Begin VB.Label Label6 
            Caption         =   "Código Instrum."
            Height          =   255
            Left            =   3855
            TabIndex        =   11
            Top             =   2790
            Visible         =   0   'False
            Width           =   1125
         End
      End
      Begin MSFlexGridLib.MSFlexGrid table1 
         Height          =   3555
         Left            =   45
         TabIndex        =   1
         TabStop         =   0   'False
         Top             =   1680
         Width           =   11250
         _ExtentX        =   19844
         _ExtentY        =   6271
         _Version        =   393216
         FixedCols       =   0
         BackColor       =   12632256
         ForeColor       =   8388608
         BackColorFixed  =   8421376
         ForeColorFixed  =   -2147483634
         GridLines       =   2
      End
   End
   Begin ComctlLib.ImageList ImageList1 
      Left            =   10530
      Top             =   5850
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   327682
      BeginProperty Images {0713E8C2-850A-101B-AFC0-4210102A8DA7} 
         NumListImages   =   4
         BeginProperty ListImage1 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "consulta_operaciones.frx":0032
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "consulta_operaciones.frx":034C
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "consulta_operaciones.frx":0666
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "consulta_operaciones.frx":0980
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "consulta_operaciones"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
    
    Dim ObjCliente      As New clsCliente

    Const ColRut = 0
    Const ColNombre = 1
    Const ColSerie = 2
    Const ColNumOpe = 3
    Const ColNumdocu = 4
    Const ColCorrela = 5
    Const ColFechaIni = 6
    Const ColFechaVenc = 7
    Const ColMoneda = 8
    Const ColMontoIni = 9
    Const ColMontoFin = 10
    Const ColTipOpe = 11
    Const ColOperador = 12
    Const ColLibro = 13
    Const ColCartNorm = 14
Private Sub Crea_Grilla()
    
    With Table1
        .Rows = 1
        .Cols = 15
    
        .ColWidth(ColRut) = 1000
        .ColWidth(ColNombre) = 3500
        .ColWidth(ColSerie) = 1300
        .ColWidth(ColNumOpe) = 900
        .ColWidth(ColNumdocu) = 900
        .ColWidth(ColCorrela) = 700
        .ColWidth(ColFechaIni) = 1200
        .ColWidth(ColFechaVenc) = 1200
        .ColWidth(ColMoneda) = 800
        .ColWidth(ColMontoIni) = 1900
        .ColWidth(ColMontoFin) = 1900
        .ColWidth(ColTipOpe) = 700
        .ColWidth(ColOperador) = 1300
        .ColWidth(ColLibro) = 2000
        .ColWidth(ColCartNorm) = 3000
        
        .TextMatrix(0, ColRut) = "Rut"
        .TextMatrix(0, ColNombre) = "Nombre"
        .TextMatrix(0, ColSerie) = "Serie"
        .TextMatrix(0, ColNumOpe) = "Num.Ope."
        .TextMatrix(0, ColNumdocu) = "Num.Docu."
        .TextMatrix(0, ColCorrela) = "Correla."
        .TextMatrix(0, ColFechaIni) = "Fecha Ini."
        .TextMatrix(0, ColFechaVenc) = "Fecha Venc."
        .TextMatrix(0, ColMoneda) = "Moneda"
        .TextMatrix(0, ColMontoIni) = "Monto Ini."
        .TextMatrix(0, ColMontoFin) = "Monto Fin."
        .TextMatrix(0, ColTipOpe) = "Tip.Ope"
        .TextMatrix(0, ColOperador) = "Operador"
        .TextMatrix(0, ColLibro) = "Libro"
        .TextMatrix(0, ColCartNorm) = "Cartera Normativa"
        
        
    End With
    ''''table1.Rows = 2
End Sub

Private Sub imprimir()
Dim TitRpt As String
      
     Call Limpiar_Cristal

     TitRpt = "MOVIMIENTOS HISTORICOS DE OPERACIONES" + Titulo
     BacTrader.bacrpt.Destination = crptToWindow
     BacTrader.bacrpt.ReportFileName = RptList_Path & "LISTAHS.RPT"
     BacTrader.bacrpt.StoredProcParam(0) = IIf(Combo1.ListIndex = 0, Space(1), Combo1.Text)
     BacTrader.bacrpt.StoredProcParam(1) = Format(txtFecha1.Text, "YYYYMMDD")
     BacTrader.bacrpt.StoredProcParam(2) = Format(TXTFecha2.Text, "YYYYMMDD")
     BacTrader.bacrpt.StoredProcParam(3) = IIf(TxtUsuario.Text = "", Space(1), TxtUsuario.Text)
     BacTrader.bacrpt.StoredProcParam(4) = Val(TEXT2.Tag)
     BacTrader.bacrpt.StoredProcParam(5) = Val(txtrut.Text)
     BacTrader.bacrpt.StoredProcParam(6) = Val(txtcodigo.Text)
     BacTrader.bacrpt.StoredProcParam(7) = GLB_LIBRO
     BacTrader.bacrpt.StoredProcParam(8) = IIf(Trim(Right(Cmb_Libro.Text, 10)) = "", Space(1), Trim(Right(Cmb_Libro.Text, 10)))

     BacTrader.bacrpt.Connect = CONECCION
     BacTrader.bacrpt.Action = 1
     Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Impresión " & TitRpt)

End Sub

Private Function Limpiar()
Dim I As Long
TEXT2.Text = ""
TEXT2.Tag = ""
txtnombre.Text = ""
txtusuario.Text = ""
txtrut.Text = 0
txtFecha1.Text = DateAdd("D", gsBac_Fecp, -1)
TXTFecha2.Text = DateAdd("D", gsBac_Fecp, -1)
Combo1.ListIndex = 0
Table1.Rows = 1
''''table1.Rows = 2
''''For i = 0 To 9
''''    table1.TextMatrix(1, i) = ""
''''Next i
End Function



Private Sub Llenar_Grilla()

Dim datos()

    Screen.MousePointer = vbHourglass
    
    Envia = Array()
    AddParam Envia, Trim(Right(Combo1.Text, 10))
    AddParam Envia, Format(txtFecha1.Text, "YYYYMMDD")
    AddParam Envia, Format(TXTFecha2.Text, "YYYYMMDD")
    AddParam Envia, txtusuario.Text
    AddParam Envia, Val(TEXT2.Tag)
    AddParam Envia, Val(txtrut.Text)
    AddParam Envia, Val(txtcodigo.Text)
    AddParam Envia, GLB_LIBRO
    AddParam Envia, Trim(Right(Cmb_Libro.Text, 10))
    
    If Not Bac_Sql_Execute("SP_BUSCA_OPERACIONES", Envia) Then
            Screen.MousePointer = vbDefault
            MsgBox "Ha ocurrido un problema al intentar recuperar la informacion de las operaciones historicas", vbCritical
            Exit Sub
    End If

    Table1.Rows = 1
    ''''table1.Rows = 2
    Table1.Redraw = False

    Do While Bac_SQL_Fetch(datos())
        If datos(1) <> "OK" Then
            With Table1
                .Rows = .Rows + 1
                .Row = .Rows - 1
                
                .Col = ColCorrela
                .CellAlignment = flexAlignCenterCenter
        
                .Col = ColTipOpe
                .CellAlignment = flexAlignCenterCenter
                
                .Col = ColOperador
                .CellAlignment = flexAlignCenterCenter
                        
                .Col = ColMoneda
                .CellAlignment = flexAlignCenterCenter
                
                .Col = ColFechaIni
                .CellAlignment = flexAlignCenterCenter
                
                .Col = ColFechaVenc
                .CellAlignment = flexAlignCenterCenter
                
                .TextMatrix(.Row, ColRut) = Trim(CStr(datos(1))) + "-" + Trim(CStr(datos(11)))
                .TextMatrix(.Row, ColNombre) = datos(2)
                .TextMatrix(.Row, ColSerie) = datos(3)
                .TextMatrix(.Row, ColNumOpe) = datos(14)
                .TextMatrix(.Row, ColCorrela) = datos(19)
                .TextMatrix(.Row, ColNumdocu) = datos(20)  '6
                .TextMatrix(.Row, ColFechaIni) = IIf(IsNull(datos(4)) = True, "", datos(4))
                .TextMatrix(.Row, ColFechaVenc) = IIf(IsNull(datos(5)) = True, "", datos(5))
                .TextMatrix(.Row, ColMoneda) = datos(13)
                .TextMatrix(.Row, ColMontoIni) = Format(datos(7), "###,###,##0") 'datos(10)
                .TextMatrix(.Row, ColMontoFin) = Format(datos(8), "###,###,##0") 'datos(15)
                .TextMatrix(.Row, ColTipOpe) = datos(9)
                .TextMatrix(.Row, ColOperador) = datos(10)
                .TextMatrix(.Row, ColLibro) = datos(15)
                .TextMatrix(.Row, ColCartNorm) = datos(18)
            End With
        End If
    Loop

    Table1.Redraw = True
    Screen.MousePointer = vbDefault
    
''''    If table1.Rows > 3 Then
''''        table1.Rows = table1.Rows - 1
''''    End If

    If Table1.Rows > 1 Then
        Table1.Row = 1
        Table1.Col = 1
    End If
End Sub



Private Sub Form_Activate()
    Combo1.ListIndex = 0
    Call Crea_Grilla
    txtFecha1.Text = DateAdd("D", gsBac_Fecp, -1)
    TXTFecha2.Text = DateAdd("D", gsBac_Fecp, -1)
End Sub

Private Sub Form_Load()
    Me.Top = 0
    Me.Left = 0
    Me.Icon = BacTrader.Icon
    
    ''''Call PROC_LLENA_COMBOS(GLB_LIBRO, Cmb_Libro, True)
    Call PROC_LLENA_COMBOS(Cmb_Libro, 1, True, GLB_LIBRO, GLB_ID_SISTEMA)
    Call PROC_LLENA_COMBOS(Combo1, 7, True, GLB_ID_SISTEMA, "")
        
End Sub

Private Sub Label9_Click()

End Sub

Private Sub TEXT2_Change()
If TEXT2.Text = "" Then
       TEXT2.Tag = ""
End If
End Sub

Private Sub Text2_DblClick()
    BacAyuda.Tag = "MDIN"
    BacAyuda.Show 1

    If giAceptar% = True Then
        TEXT2 = gsSerie$
        TEXT2.Tag = gscodigo$
        
    End If
End Sub

Private Sub Text2_KeyPress(KeyAscii As Integer)
KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As ComctlLib.Button)
Select Case Button.Index
    Case 1
        Call Llenar_Grilla
    Case 2
        Call imprimir
   
    Case 3
       Call Limpiar
    Case 4
        Unload Me
End Select
End Sub





Private Sub txtcodigo_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = 13 Then
    On Error GoTo ErrConsulta


    If Len(Trim$(txtcodigo.Text)) = 0 Then Exit Sub
    
    gsBac_OkComi = 0


    If Val(txtrut.Text) <> 0 Then
    
        Call ObjCliente.LeerPorRut(txtrut.Text, 0, 0, txtcodigo.Text)
        
             
        If ObjCliente.clrut = 0 Then
            txtrut.Text = ""
            txtcodigo.Text = ""
            MsgBox "Cliente no existente, verifique datos.", vbExclamation, "BAC Trader"
            txtrut.SetFocus
        Else
            
            txtnombre.Text = ObjCliente.clnombre
            txtcodigo.Text = ObjCliente.clcodigo
        End If
        
    End If
End If
Exit Sub
    
ErrConsulta:
    MsgBox "Problemas en verificación de datos: " & err.Description & ". Verifique.", vbExclamation, "BAC Trader"
    Exit Sub
    

End Sub

Private Sub txtFecha1_Change()

If Not IsDate(txtFecha1.Text) Then
   txtFecha1.SetFocus
   Exit Sub
End If

If txtFecha1.Text >= gsBac_Fecp Then
    MsgBox "Fecha Mayor o igual a fecha de Proceso", vbCritical
    txtFecha1.Text = DateAdd("D", gsBac_Fecp, -1)
End If
End Sub



Private Sub TXTFecha2_Change()
If TXTFecha2.Text >= gsBac_Fecp Then
    MsgBox "Fecha Mayor o igual a fecha de Proceso", vbCritical
    TXTFecha2.Text = DateAdd("D", gsBac_Fecp, -1)
End If
End Sub

Private Sub TxtRut_Change()

    txtcodigo.Text = ""
    txtnombre.Text = ""



End Sub

Private Sub txtRut_DblClick()
BacAyuda.Tag = "MDCL"
BacAyuda.Show 1
BacControlWindows 12
 If giAceptar% = True Then

            txtrut.Text = Val(gsrut$)
            txtrut.Separator = True
            'txtDigCli.Text = gsDigito$
            txtnombre.Text = gsDescripcion$
            txtcodigo.Text = gsvalor$

  End If
End Sub

Private Sub txtrut_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = 13 Then
        txtcodigo.SetFocus
End If
End Sub

Private Sub txtUsuario_DblClick()
    BacAyuda.Tag = "BACUSER"
    BacAyuda.Show 1

    If giAceptar% = True Then
        txtusuario.Text = gsDescripcion$
    End If
End Sub


Private Sub txtusuario_KeyPress(KeyAscii As Integer)
KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub


