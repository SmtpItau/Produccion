VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacIrfCo 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Cortes"
   ClientHeight    =   4596
   ClientLeft      =   3060
   ClientTop       =   1716
   ClientWidth     =   5100
   ClipControls    =   0   'False
   ControlBox      =   0   'False
   ForeColor       =   &H00C0C0C0&
   Icon            =   "Bacirfco.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MinButton       =   0   'False
   Moveable        =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4596
   ScaleWidth      =   5100
   ShowInTaskbar   =   0   'False
   Begin Threed.SSFrame SSFrame2 
      Height          =   525
      Left            =   105
      TabIndex        =   9
      Top             =   3915
      Width           =   4950
      _Version        =   65536
      _ExtentX        =   8731
      _ExtentY        =   926
      _StockProps     =   14
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   7.76
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin BACControles.TXTNumero TxtNominal 
         Height          =   315
         Left            =   2880
         TabIndex        =   10
         Top             =   120
         Width           =   2010
         _ExtentX        =   3535
         _ExtentY        =   550
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   7.8
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0.0000"
         Text            =   "0.0000"
         Max             =   "999999999999999.9999"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Total"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   7.8
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   3
         Left            =   2280
         TabIndex        =   11
         Top             =   210
         Width           =   450
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   396
      Left            =   0
      TabIndex        =   8
      Top             =   0
      Width           =   5100
      _ExtentX        =   8996
      _ExtentY        =   699
      ButtonWidth     =   677
      ButtonHeight    =   656
      AllowCustomize  =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdAceptar"
            Description     =   "Aceptar"
            Object.ToolTipText     =   "Aceptar Modificaciones"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdSalir"
            Description     =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   855
      Top             =   5910
      _ExtentX        =   995
      _ExtentY        =   995
      BackColor       =   -2147483643
      ImageWidth      =   25
      ImageHeight     =   25
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   2
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacirfco.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacirfco.frx":075C
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin BACControles.TXTNumero TEXT1 
      Height          =   195
      Left            =   360
      TabIndex        =   6
      Top             =   2160
      Visible         =   0   'False
      Width           =   1095
      _ExtentX        =   1926
      _ExtentY        =   339
      BackColor       =   8388608
      ForeColor       =   16777215
      Enabled         =   -1  'True
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   7.8
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BorderStyle     =   0
      Text            =   "0"
      Text            =   "0"
      Separator       =   -1  'True
   End
   Begin MSFlexGridLib.MSFlexGrid TABLE1 
      Height          =   2415
      Left            =   105
      TabIndex        =   5
      Top             =   1500
      Width           =   4950
      _ExtentX        =   8721
      _ExtentY        =   4255
      _Version        =   393216
      Cols            =   3
      FixedCols       =   0
      BackColor       =   12632256
      ForeColor       =   8388608
      BackColorFixed  =   8421376
      ForeColorFixed  =   16777215
      BackColorBkg    =   12632256
      GridColorFixed  =   4210752
      FocusRect       =   0
      GridLines       =   2
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   7.8
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin VB.Data Data1 
      Caption         =   "Data1"
      Connect         =   "Access"
      DatabaseName    =   "C:\BTRADER\MDBDEUT\BACTRD.MDB"
      DefaultCursorType=   0  'DefaultCursor
      DefaultType     =   2  'UseODBC
      Exclusive       =   0   'False
      Height          =   300
      Left            =   1560
      Options         =   0
      ReadOnly        =   0   'False
      RecordsetType   =   0  'Table
      RecordSource    =   "MDCP"
      Top             =   5040
      Visible         =   0   'False
      Width           =   1905
   End
   Begin Threed.SSFrame SSFrame1 
      Height          =   900
      Left            =   105
      TabIndex        =   0
      Top             =   525
      Width           =   4950
      _Version        =   65536
      _ExtentX        =   8731
      _ExtentY        =   1587
      _StockProps     =   14
      Caption         =   "Datos Instrumento"
      ForeColor       =   8388608
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   7.8
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Font3D          =   3
      Enabled         =   0   'False
      Begin VB.TextBox TxtSerie 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   7.8
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   315
         Left            =   120
         TabIndex        =   4
         Text            =   "PRC-1A0190"
         Top             =   500
         Width           =   1275
      End
      Begin VB.TextBox TxtUM 
         Alignment       =   2  'Center
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   7.8
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   315
         Left            =   1560
         TabIndex        =   1
         Text            =   "UF"
         Top             =   480
         Width           =   705
      End
      Begin BACControles.TXTNumero txtNominalReal 
         Height          =   315
         Left            =   2400
         TabIndex        =   12
         Top             =   480
         Width           =   2490
         _ExtentX        =   4382
         _ExtentY        =   550
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   7.8
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0.0000"
         Text            =   "0.0000"
         Max             =   "999999999999999.9999"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Moneda"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   7.8
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   2
         Left            =   1560
         TabIndex        =   7
         Top             =   300
         Width           =   705
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Nemotécnico"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   7.8
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   0
         Left            =   120
         TabIndex        =   3
         Top             =   300
         Width           =   1125
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Monto Nominal"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   7.8
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   1
         Left            =   2400
         TabIndex        =   2
         Top             =   300
         Width           =   1275
      End
   End
End
Attribute VB_Name = "BacIrfCo"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim Rutcart             As Long
Dim NumDocu             As Double
Dim Correla             As Integer
Dim Venta               As String
Dim sTipo               As String  'Tipo de operacion CP,CI

'Variables para identificar el registro
Dim FormHandle&
Dim Correlativo&

Dim Corte               As New clsCortes
Dim Cortes              As New Collection
Dim CorteMin#

Dim Sql                 As String
Dim Datos()

Private Sub Func_Aceptar_Datos()

   If ChkCortes() = False Then
      Exit Sub

   End If

   ' Actualización para operaciones
   If GrabarCortes() = False Then
      Exit Sub

   End If

   'Asigna el monto calculado a la pantalla de ventas
   'en la de compra no se puede hacer porque
   'al actualizar el nominal borra los cortes

   If sTipo = "VP" Or sTipo = "VI" Or sTipo = "ST" Then
        If BacFrmIRF.Data1.Recordset!tm_nominalo = CDbl(TxtNominal.Text) Then 'BacFrmIRF.Table1.TextMatrix(BacFrmIRF.Table1.Row, Ven_NOMINAL)
                BacFrmIRF.Table1.TextMatrix(BacFrmIRF.Table1.Row, 0) = "V"
         End If
      If BacFrmIRF.Table1.Col <> Ven_NOMINAL Then
         BacFrmIRF.Table1.Col = Ven_NOMINAL
         BacFrmIRF.Table1.TextMatrix(BacFrmIRF.Table1.Row, Ven_NOMINAL) = CDbl(TxtNominal.Text)
         BacFrmIRF.Table1.Col = 0

      Else
        
                BacFrmIRF.Table1.TextMatrix(BacFrmIRF.Table1.Row, Ven_NOMINAL) = CDbl(TxtNominal.Text)
             

      End If

   End If

   Unload Me

End Sub

'Agrega un nuevo elemento a la colección y los refresca en la grilla
Private Sub Agregar(MtoCort#, CantCortD#, CantCortV#)

   Dim bufCorte As New clsCortes

   With bufCorte
      .MtoCort = MtoCort#
      .CantCortD = CantCortD#
      .CantCortV = CantCortV#

      Table1.Col = 0
      
      Table1.TextMatrix(Table1.Row, Table1.Col) = Format(MtoCort#, FDecimal)
      Table1.Col = 1
      Table1.TextMatrix(Table1.Row, Table1.Col) = CantCortD#
      Table1.Col = 2
      Table1.TextMatrix(Table1.Row, Table1.Col) = CantCortV#

   End With

   Table1.Rows = Table1.Rows + 1
   Table1.Row = Table1.Rows - 1

   Cortes.Add bufCorte

   Set bufCorte = Nothing

End Sub

'Agrega un solo corte con el monto total en caso no se encuentren cortes
'en la tabla temporal
Private Function AgregarCorteUnico() As Boolean

   Dim Cortes#

   AgregarCorteUnico = False

   Table1.Rows = 2
   Table1.Row = Table1.Rows - 1
   If CorteMin# <> 0 Then
      Cortes = CDbl(txtNominalReal.Text) / CorteMin# 'antes txtnominal
      Call Agregar(CorteMin#, Cortes, Cortes)

   Else
      Call Agregar(CDbl(txtNominalReal.Text), 1, 1)

   End If

   Table1.Rows = 2

   AgregarCorteUnico = True

End Function

'Valida que no se repitan Montos iguales y que el monto total no se exceda
'al total del nominal en caso de ventas
'El monto por linea debe ser divisible por el corte mínimo
Private Function ChkCortes()
Dim MtoCort#, CantCortD#, CantCortV#
   Dim I&, J&, Max&, Monto#, MonMax#

   ChkCortes = False

   ' Valida que no cambie el nominal desde aqui
   ' en la compra porque se hace un update al
   ' nominal en la grilla por lo cual se borran
   ' los cortes recien ingresados
   If sTipo = "CP" Or sTipo = "CI" Then
      gsBac_Corte = txtNominalReal.Text

      If CDbl(TxtNominal.Text) <> gsBac_Corte Then
         MsgBox "Suma no cuadra con el nominal ingresado en la pantalla de compra", vbExclamation, gsBac_Version
         Table1.TextMatrix(1, 0) = Format(txtNominalReal.Text, "###,###.###0") 'insertado 05/02/2001
         TxtNominal.Text = txtNominalReal.Text 'insertado 05/02/2001
         Exit Function
         

      End If

   End If

   Max& = Cortes.Count

   For I& = 1 To Max&
      Monto = CDbl(Cortes(I&).MtoCort)

      For J& = I& To Max&
         If Monto# = Cortes(J&).MtoCort Then
            If I& <> J& Then
               MsgBox "Existen cortes con montos iguales", vbExclamation, gsBac_Version
               Exit Function

            End If

         End If

      Next J&

   Next I&

   'Validación solo para ventas
   If sTipo = "VP" Or sTipo = "VI" Or sTipo = "ST" Then
      Monto = CDbl(TxtNominal.Text)

      MonMax = BacFrmIRF.Data1.Recordset("tm_nominalo")

      If Monto > MonMax Then
         MsgBox "SUMA EXCEDE AL MONTO DISPONIBLE", vbExclamation, gsBac_Version
         
         Exit Function

      End If

   End If

   'Validación de corte mínimo
   ChkCortes = True

End Function

'Elimina un corte de la coleccion
Private Sub Eliminar(INDICE As Long)

   Dim I&

   If INDICE > 0 Then
      Cortes.Remove INDICE

      Table1.RemoveItem INDICE

      For I& = 1 To Cortes.Count
         Table1.Refresh '= i&

      Next I&

   End If

   Call SumarColumnas

End Sub

'Elimina los cortes de la tabla temporal
'Agrega todos los cortes que esta en la coleccion
Private Function GrabarCortes()

   On Error GoTo BacErrorHandler

   Dim I&

   GrabarCortes = False

   'Empieza una transacción MDB
   WS.BeginTrans

   db.Execute "DELETE * FROM mdco WHERE tm_hwnd = " & FormHandle & " AND tm_correlativo = " & Correlativo

   For I& = 1 To Cortes.Count
      Data1.Recordset.AddNew
      Data1.Recordset("tm_correlativo") = Correlativo
      Data1.Recordset("tm_hwnd") = FormHandle
      Data1.Recordset("tm_rutcart") = Rutcart
      Data1.Recordset("tm_numdocu") = NumDocu
      Data1.Recordset("tm_correla") = Correla
      Data1.Recordset("tm_mtocort") = Cortes(I&).MtoCort
      Data1.Recordset("tm_cantcortd") = Cortes(I&).CantCortD
      Data1.Recordset("tm_cantcortv") = Cortes(I&).CantCortV
      Data1.Recordset.Update

   Next I&

   GrabarCortes = True

   WS.CommitTrans

   On Error GoTo 0

   Exit Function

BacErrorHandler:
   On Error GoTo 0

   WS.Rollback

   MsgBox error(err)

   Exit Function

End Function

Private Function RecuperaCortes() As Boolean
Dim MtoCort#, CantCortD#, CantCortV#

    RecuperaCortes = False

'   Sql = "EXECUTE SP_COLEERCORTES "
'   Sql = Sql & Rutcart & ","
'   Sql = Sql & NumDocu & ","
'   Sql = Sql & Correla

    Envia = Array(CDbl(Rutcart), _
            CDbl(NumDocu), _
            CDbl(Correla))

    If Not Bac_Sql_Execute("SP_COLEERCORTES", Envia) Then
        MsgBox "No se pudo recuperar cortes de instrumento seleccionado ", vbCritical, gsBac_Version
        Unload Me
        Exit Function
    End If

    Do While Bac_SQL_Fetch(Datos())
        If CDbl(Datos(1)) = 0 Then
            MsgBox Datos(2), vbExclamation, gsBac_Version
            Exit Function
        Else
            MtoCort = CDbl(Datos(4))
            CantCortD = Val(Datos(6))

            If Venta = "V" Then
                CantCortV = Val(Datos(6))
            Else
                CantCortV = 0
            End If

            Call Agregar(MtoCort, CantCortD, CantCortV)

        End If

    Loop

    Table1.Rows = Cortes.Count + 1

    RecuperaCortes = True

End Function

Private Sub SumarColumnas()

   'Suma las montos de la colección y lo displaya como total
   Dim I&, Total#

   Total# = 0

   For I& = 1 To Cortes.Count
      Total# = Total + Cortes(I&).MtoCort * Cortes(I&).CantCortV

   Next I&

   TxtNominal.Text = Total#

End Sub

Private Sub Form_Activate()

   'El gControlWindow sirve para que la True Grid no se tupa
   On Error GoTo BacErrorHandler

   ' -------------------------------------------------------
   ' Configuración de la pantalla de cortes.-
   ' -------------------------------------------------------
   BacControlWindows 12

   If sTipo = "VP" Or sTipo = "VI" Or sTipo = "ST" Or sTipo = "RP" Then 'PRD-5285-REPOS, jbh, 25-01-2010
      TxtSerie.Text = BacFrmIRF.Table1.TextMatrix(BacFrmIRF.Table1.Row, Ven_SERIE)
      TxtUM.Text = BacFrmIRF.Table1.TextMatrix(BacFrmIRF.Table1.Row, Ven_UM)
      txtNominalReal.Text = CDbl(BacFrmIRF.Table1.TextMatrix(BacFrmIRF.Table1.Row, Ven_NOMINAL))
      TxtNominal.Text = 0

   Else
      TxtSerie.Text = BacFrmIRF.Table1.TextMatrix(BacFrmIRF.Table1.Row, com_SERIE)
      TxtUM.Text = BacFrmIRF.Table1.TextMatrix(BacFrmIRF.Table1.Row, com_UM)
      txtNominalReal.Text = CDbl(BacFrmIRF.Table1.TextMatrix(BacFrmIRF.Table1.Row, com_NOMINAL))
      TxtNominal.Text = 0
   End If
   
  
   Venta = BacFrmIRF.Table1.TextMatrix(BacFrmIRF.Table1.Row, Ven_MARCA)

   BacControlWindows 100

   If sTipo = "VP" Or sTipo = "VI" Or sTipo = "ST" Or sTipo = "RP" Then   'VB+- 28/01/2010
      'Si no tiene cortes en la tabla temporal, recupero todos y los cargo a la colección
      If Data1.Recordset.RecordCount = 0 Then
         If RecuperaCortes() = False Then
            Unload Me
            Exit Sub

         End If

      Else
         Call LeerCortes
         Table1.Rows = Table1.Rows - 1

      End If

   ElseIf sTipo$ = "CP" Or sTipo = "CI" Then
      If Data1.Recordset.RecordCount = 0 Then
         If AgregarCorteUnico() = False Then
            Unload Me
            Exit Sub

         End If

      Else
         Call LeerCortes
         Table1.Rows = Cortes.Count + 1

      End If

   End If

   Call SumarColumnas

   Call Bac_SendKey(vbKeyUp)
   'DEJA COMO DEFAUL UN CORTE
'      If Table1.Rows <= 2 Then
'         Table1.Col = 1: Table1.Row = 1
'         Table1.Text = 1
'      End If
'
   On Error GoTo 0

   Exit Sub

BacErrorHandler:
   Resume
   On Error GoTo 0

   MsgBox error(err)

   Unload Me

   Exit Sub

End Sub

Private Sub LeerCortes()

   'Lee los cortes de la tabla temporal y los carga a la colección
   Dim MtoCort#, CantCortD#, CantCortV#

   Data1.Recordset.MoveFirst

   Do While Not Data1.Recordset.EOF
      MtoCort = Data1.Recordset("tm_mtocort")
      CantCortD = Data1.Recordset("tm_cantcortd")
      CantCortV = Data1.Recordset("tm_cantcortv")

      Call Agregar(MtoCort, CantCortD, CantCortV)

      Data1.Recordset.MoveNext

   Loop

End Sub

Private Sub Form_Load()

   On Error GoTo BacErrorHandler

   BacCentrarPantalla Me

   sTipo = Mid$(BacFrmIRF.Tag, 1, 2)
   FormHandle = BacFrmIRF.Hwnd

   Table1.TextMatrix(0, 0) = "Monto del Corte"
   Table1.TextMatrix(0, 1) = "Nº de Cortes"
   Table1.TextMatrix(0, 2) = "Cortes Vendidos"


   If sTipo$ = "VP" Or sTipo$ = "VI" Or sTipo$ = "ST" Or sTipo$ = "RP" Then 'PRD-5285-REPOS, jbh, 25-01-2010
      txtNominalReal.Tag = BacFrmIRF.Table1.TextMatrix(BacFrmIRF.Table1.Row, Ven_NOMINAL)
      Correlativo = IIf(IsNull(BacFrmIRF.Data1.Recordset("tm_correlao")) = True, 0, BacFrmIRF.Data1.Recordset("tm_correlao"))

   Else
      txtNominalReal.Tag = BacFrmIRF.Table1.TextMatrix(BacFrmIRF.Table1.Row, com_NOMINAL)
      Correlativo = BacFrmIRF.Data1.Recordset("tm_correlativo")

   End If

   If sTipo$ = "VP" Or sTipo$ = "VI" Or sTipo$ = "ST" Or sTipo$ = "RP" Then 'PRD-5285-REPOS, jbh, 25-01-2010
      Rutcart = BacFrmIRF.Data1.Recordset("tm_rutcart")
      NumDocu = BacFrmIRF.Data1.Recordset("tm_numdocu")
      Correla = BacFrmIRF.Data1.Recordset("tm_correla")

      Table1.ColWidth(0) = 2000
      Table1.ColWidth(1) = 1490
      Table1.ColWidth(2) = 1370
      

      CorteMin# = 0

   ElseIf sTipo$ = "CP" Or sTipo$ = "CI" Then
      CorteMin# = BacFrmIRF.Data1.Recordset("tm_cortemin")
      Rutcart = 0
      NumDocu = 0
      Correla = 0

      Table1.ColWidth(0) = 2700
      Table1.ColWidth(1) = 2100
      Table1.ColWidth(2) = 0

   End If


   ' Activar filtro para la Cortes .-
   Data1.DatabaseName = gsMDB_Path & gsMDB_Database
   Data1.RecordsetType = 1
   Data1.RecordSource = "SELECT * FROM mdco WHERE tm_hwnd = " & FormHandle & " AND tm_correlativo = " & Correlativo & " AND tm_numdocu = " & NumDocu '& "'"
   Data1.Refresh

   BacControlWindows 100

   On Error GoTo 0

   Exit Sub

BacErrorHandler:
   On Error GoTo 0

   MsgBox error(err), vbExclamation, gsBac_Version
   Unload Me

   Exit Sub

End Sub


Private Sub Form_Unload(Cancel As Integer)

   Set Corte = Nothing
   Set Cortes = Nothing

End Sub

Private Sub Table1_KeyDown(KeyCode As Integer, Shift As Integer)
   Dim aux&
   On Error GoTo KeyDownError

    If sTipo$ = "VP" Or sTipo$ = "VI" Or sTipo$ = "RP" Then  ' VB+- Se Agregar codificación para Repos
      Exit Sub

   End If


   If KeyCode = vbKeyInsert Then
      If Val(Table1.TextMatrix(Table1.Row, 0)) <> 0 Then
         Table1.Rows = Table1.Rows + 1
         Table1.Row = Table1.Rows - 1

         Call Agregar(0, 0, 0)

         BacControlWindows 60

         Table1.Rows = Table1.Rows - 1

      End If

      Call Bac_SendKey(vbKeyDown)

   ElseIf KeyCode = vbKeyUp Then
      If Trim$(Table1.TextMatrix(Table1.Row, 1)) = "" Then
         BacControlWindows 60

         If Cortes.Count > 1 Then
            Call Eliminar(Table1.Row)

         End If

      End If

   ElseIf KeyCode = vbKeyDelete And Table1.Rows > 0 Then
      Call Eliminar(Table1.Row)

   End If

   On Error GoTo 0
   Table1.SetFocus
   Exit Sub

KeyDownError:

   On Error GoTo 0
   If error(err) <> "" Then
      MsgBox error(err), vbExclamation, "MENSAJE"
   End If
   Data1.Refresh

   Exit Sub

End Sub



Private Sub Table1_KeyPress(KeyAscii As Integer)

   If KeyAscii = 27 Then
      Exit Sub

   End If

   If sTipo = "VP" Or sTipo = "VI" And Table1.Col = 2 Then
      If Table1.Col = 0 Then
         Text1.CantidadDecimales = 4

      Else
         
         Text1.CantidadDecimales = 0

      End If

      If KeyAscii >= 48 And KeyAscii <= 57 Then
         Text1.Text = Chr(KeyAscii)

      Else
         Text1.Text = Table1.TextMatrix(Table1.Row, Table1.Col)

      End If

      Text1.Visible = True
      Text1.SetFocus

   End If

   If sTipo = "CP" Or sTipo = "CI" And Table1.Col = 0 Or sTipo = "CP" Or sTipo = "CI" And Table1.Col = 1 Then
      If Table1.Col = 0 Then
         Text1.CantidadDecimales = 4

      Else
         Text1.CantidadDecimales = 0

      End If

      If KeyAscii > 47 And KeyAscii < 58 Then
         Text1.Text = Chr(KeyAscii)

      Else
         Text1.Text = CDbl(Table1.TextMatrix(Table1.Row, Table1.Col))

      End If

      Text1.Visible = True
      Text1.SetFocus

   End If

End Sub

Private Sub Table1_Scroll()

   Text1.Text = ""
   Text1.Visible = False

End Sub

Private Sub Text1_GotFocus()

   Call PROC_POSI_TEXTO(Table1, Text1)
             
   If Table1.Col = 1 Or Table1.Col = 2 Then
        Text1.SelStart = Len(Text1.Text)
   Else
        Text1.SelStart = Len(Text1.Text) - 5
   End If
    
End Sub

Private Sub Text1_KeyDown(KeyCode As Integer, Shift As Integer)

   Dim Value As Double
   Dim I&
   Dim Total#

   If KeyCode = 27 Then
   
      Text1.Text = 0
      Text1.Visible = False
      Table1.SetFocus

   End If

   ' update
   If KeyCode = 13 Then
      Value = Text1.Text

      If Not IsNumeric(Value) Then
         Value = 0

      End If

      Table1.TextMatrix(Table1.Row, Table1.Col) = Text1.Text

      If Table1.Col = 0 Then
         Cortes(Table1.Row).MtoCort = Value
         
      ElseIf Table1.Col = 1 Then
         Cortes(Table1.Row).CantCortD = Value
         Cortes(Table1.Row).CantCortV = Value
         
      ElseIf Table1.Col = 2 Then
         Cortes(Table1.Row).CantCortV = Value
         
      End If

      BacControlWindows 30

      If sTipo = "VP" Or sTipo = "VI" Then
         If Val(Table1.TextMatrix(Table1.Row, 2)) > Val(Table1.TextMatrix(Table1.Row, 1)) Then
            MsgBox "Cortes vendidos no puede ser mayor a cortes disponibles", vbExclamation, gsBac_Version
            Table1.TextMatrix(Table1.Row, 2) = Table1.TextMatrix(Table1.Row, 1)
            Call Table1_Scroll
            Table1.SetFocus
            Exit Sub

         End If

      ElseIf sTipo = "CP" Or sTipo = "CI" Then
         If CorteMin# <> 0 Then
            'Realiza las validaciones para el corte minimo
            If CDbl(Table1.TextMatrix(Table1.Row, 0)) < CorteMin# Then
               MsgBox "Monto del corte debe ser mayor o igual al corte mínimo " & vbCrLf & vbCrLf & "Corte mínimo: " & Format$(CorteMin#, "0.0000"), vbExclamation, "Mensaje"
               Table1.TextMatrix(Table1.Row, 0) = CorteMin#
               
               Call Table1_Scroll
               Table1.SetFocus
               Exit Sub

            ElseIf CDbl(Table1.TextMatrix(Table1.Row, 0)) Mod CorteMin# <> 0 Then
               MsgBox "Monto del corte debe ser divisible por el corte minimo " & vbCrLf & vbCrLf & "Corte mínimo: " & Format(CorteMin#, "0.0000"), vbExclamation, gsBac_Version
               Table1.TextMatrix(Table1.Row, 0) = CorteMin#
               Call Table1_Scroll
               Table1.SetFocus
               Exit Sub

            End If

         End If

      End If

      Call SumarColumnas


      If Table1.Col = 0 Then
         Table1.TextMatrix(Table1.Row, Table1.Col) = Format(Text1.Text, "###,###.###0")

      Else
         Table1.TextMatrix(Table1.Row, Table1.Col) = Text1.Text

      End If
    
      Text1.Visible = False
      Table1.Col = 1
      Table1.SetFocus

   End If

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

   Select Case UCase(Button.Description)
   Case "ACEPTAR"
      If TxtNominal.Text <> 0 Then
       Call Func_Aceptar_Datos
       'If Me.txtNominalReal = TxtNominal Then
      Else
       Unload Me
      End If
      
   Case "SALIR"
      If Me.Table1.ColWidth(2) <> 0 Then
        BacFrmIRF.Table1.TextMatrix(BacFrmIRF.Table1.Row, 0) = "N"
      
      End If
       Unload Me
   End Select

End Sub

Private Sub TxtNominal_GotFocus()
 Table1.SetFocus
End Sub

