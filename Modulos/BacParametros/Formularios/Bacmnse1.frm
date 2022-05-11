VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacMnSe1 
   Appearance      =   0  'Flat
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantención de Tablas de Desarrollo"
   ClientHeight    =   5100
   ClientLeft      =   2055
   ClientTop       =   2715
   ClientWidth     =   8445
   ClipControls    =   0   'False
   ControlBox      =   0   'False
   FillColor       =   &H00C0C0C0&
   BeginProperty Font 
      Name            =   "MS Sans Serif"
      Size            =   8.25
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   ForeColor       =   &H00C0C0C0&
   Icon            =   "Bacmnse1.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form5"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5100
   ScaleWidth      =   8445
   Begin Threed.SSPanel SSPanel1 
      Height          =   4515
      Left            =   0
      TabIndex        =   2
      Top             =   555
      Width           =   8415
      _Version        =   65536
      _ExtentX        =   14843
      _ExtentY        =   7964
      _StockProps     =   15
      Caption         =   "SSPanel1"
      BackColor       =   -2147483644
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin VB.TextBox txtNumDecimal 
         Enabled         =   0   'False
         ForeColor       =   &H00800000&
         Height          =   285
         Left            =   3570
         MaxLength       =   1
         TabIndex        =   6
         Top             =   210
         Width           =   285
      End
      Begin VB.TextBox txtSerie 
         Enabled         =   0   'False
         ForeColor       =   &H00800000&
         Height          =   285
         Left            =   840
         MaxLength       =   10
         TabIndex        =   5
         Top             =   195
         Width           =   1245
      End
      Begin BACControles.TXTNumero txtNumerico 
         Height          =   255
         Left            =   2535
         TabIndex        =   3
         Top             =   1905
         Visible         =   0   'False
         Width           =   1815
         _ExtentX        =   3201
         _ExtentY        =   450
         BackColor       =   8388608
         ForeColor       =   16777215
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BorderStyle     =   0
         Text            =   "0"
         Text            =   "0"
      End
      Begin MSFlexGridLib.MSFlexGrid grilla 
         Height          =   3690
         Left            =   120
         TabIndex        =   4
         Top             =   720
         Width           =   8190
         _ExtentX        =   14446
         _ExtentY        =   6509
         _Version        =   393216
         Cols            =   7
         FixedCols       =   0
         BackColor       =   -2147483644
         ForeColor       =   8388608
         BackColorFixed  =   8421376
         ForeColorFixed  =   16777215
         BackColorSel    =   8388608
         ForeColorSel    =   16777215
         BackColorBkg    =   -2147483645
         GridColor       =   255
         GridColorFixed  =   8421504
         FocusRect       =   0
         GridLines       =   2
      End
      Begin Threed.SSFrame SSFrame1 
         Height          =   615
         Left            =   60
         TabIndex        =   7
         Top             =   15
         Width           =   8295
         _Version        =   65536
         _ExtentX        =   14631
         _ExtentY        =   1085
         _StockProps     =   14
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ShadowStyle     =   1
         Begin VB.Label Label 
            Appearance      =   0  'Flat
            AutoSize        =   -1  'True
            BackColor       =   &H80000005&
            BackStyle       =   0  'Transparent
            Caption         =   "Serie"
            ForeColor       =   &H00800000&
            Height          =   195
            Index           =   0
            Left            =   105
            TabIndex        =   9
            Top             =   210
            Width           =   450
         End
         Begin VB.Label Label 
            Appearance      =   0  'Flat
            BackColor       =   &H80000005&
            BackStyle       =   0  'Transparent
            Caption         =   "Nº Decimales"
            ForeColor       =   &H00800000&
            Height          =   255
            Index           =   1
            Left            =   2160
            TabIndex        =   8
            Top             =   210
            Width           =   1215
         End
      End
      Begin Threed.SSFrame SSFrame2 
         Height          =   3870
         Left            =   60
         TabIndex        =   10
         Top             =   570
         Width           =   8280
         _Version        =   65536
         _ExtentX        =   14605
         _ExtentY        =   6826
         _StockProps     =   14
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   6525
      Top             =   45
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   4
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmnse1.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmnse1.frx":0762
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmnse1.frx":0A82
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmnse1.frx":0DA2
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   1
      Top             =   0
      Width           =   8445
      _ExtentX        =   14896
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
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Generar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Recalcular"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   4
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin VB.Data Data2 
      Caption         =   "Data2"
      Connect         =   "Access"
      DatabaseName    =   ""
      DefaultCursorType=   0  'DefaultCursor
      DefaultType     =   2  'UseODBC
      Exclusive       =   0   'False
      Height          =   300
      Left            =   1665
      Options         =   0
      ReadOnly        =   0   'False
      RecordsetType   =   1  'Dynaset
      RecordSource    =   ""
      Top             =   5100
      Width           =   1155
   End
   Begin VB.PictureBox Grillas 
      BackColor       =   &H00FFFFFF&
      Height          =   375
      Left            =   240
      ScaleHeight     =   315
      ScaleWidth      =   7035
      TabIndex        =   0
      Top             =   7200
      Width           =   7095
   End
End
Attribute VB_Name = "BacMnSe1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit

'Dim objDesa        As Object
Dim objMensajesTD  As Object

Dim ParamSerie     As String
Dim ParamTera      As String
Dim ParamCupones   As String
Dim ParamNumAmor   As String
Dim ParamPeriodo   As String
Dim ParamNumDec    As String
Dim ParamFecha     As String
Dim xtdmascara     As String
Dim xtdfecven      As String
Dim xtdinteres     As Double
Dim xtdcupon       As Integer
Dim xtdamort       As Double
Dim xtdPeriodo     As Integer
Dim xtdDecimales   As Integer

Dim sql As String
Dim Datos()
'Public Saldos As Double

Const Ncupon = 0
Const FecVcto = 1
Const Interes = 2
Const Amortiza = 3
Const Flujo = 4
Const Saldos = 5
Const Mascara = 6

Dim Existe As Boolean
Public proOrigense As String   ' SE ->series  CT ->crear Tabla

Public Function GrabarTD() As Boolean

Dim f%, c%

On Error GoTo ErrGrabar

   GrabarTD = False
   
   If Not LimpiaTD Then
     Exit Function
   End If
   
   If Bac_Sql_Execute("BEGIN TRANSACTION") Then
   End If

With grilla

    .Redraw = False

    For f% = 1 To .Rows - 1
    
    
    
        .Row = f%
      If Trim$(.TextMatrix(.Row, Ncupon)) <> "" Then
        
'''''            Sql = ""
'''''            Sql = "Sp_Grabar_TablaDesarrollo "
'''''            Sql = Sql & "'" & xtdmascara & "',"
'''''            Sql = Sql & .TextMatrix(.Row, Ncupon) & ","  'CUPON
            
            Envia = Array()
            
            AddParam Envia, xtdmascara
            AddParam Envia, .TextMatrix(.Row, Ncupon)
            
            If Trim$(.TextMatrix(.Row, FecVcto)) <> "" Then  'VECHA VENCIMIENTO
                
                'Sql = Sql & "'" & Format(.TextMatrix(.Row, FecVcto), "MM/DD/YYYY") & "',"
                AddParam Envia, Format(.TextMatrix(.Row, FecVcto), feFecha)
            
            Else
                
                'Sql = Sql & "null,"
                AddParam Envia, Format(.TextMatrix(.Row, FecVcto), feFecha)
            
            End If
            
'''''''''            Sql = Sql & F_FomateaValor(.TextMatrix(.Row, Interes), ",", ".") & ","   'INTERES
'''''''''            Sql = Sql & F_FomateaValor(.TextMatrix(.Row, Amortiza), ",", ".") & ","  'AMORTIZACION
'''''''''            Sql = Sql & F_FomateaValor(.TextMatrix(.Row, Flujo), ",", ".") & ","     'FLUJO
'''''''''            Sql = Sql & F_FomateaValor(.TextMatrix(.Row, Saldos), ",", ".")          'SALDO
              
            AddParam Envia, CDbl(.TextMatrix(.Row, Interes))
            AddParam Envia, CDbl(.TextMatrix(.Row, Amortiza))
            AddParam Envia, CDbl(.TextMatrix(.Row, Flujo))
            AddParam Envia, CDbl(.TextMatrix(.Row, Saldos))
              
              
            If Bac_Sql_Execute("Sp_Grabar_TablaDesarrollo", Envia) Then
                
                Do While Bac_SQL_Fetch(Datos())
                    
                    If Datos(1) = "NO" Then
                        
                        If Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
                           
                           End If
                        
                        Exit Function
                    
                    End If
                
                Loop
            
            End If

      End If
   
   Next f%
    
   .Redraw = True
    
End With

    If Bac_Sql_Execute("COMMIT TRANSACTION") Then
    End If
    
    GrabarTD = True
    
Exit Function

ErrGrabar:
   MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical, TITSISTEMA
   If Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
   
      End If
   
   Exit Function


End Function

Function CalculaTD() As Boolean
   On Error GoTo ErrCalcula
   
   Dim sql  As String
   Dim Datos()

   CalculaTD = False

   If Mid$(xtdmascara, 1, 3) <> "PRC" Then
      Envia = Array()
      AddParam Envia, xtdmascara                                'Máscara
      AddParam Envia, xtdfecven                                 'Fecha Vencimiento
      AddParam Envia, CDbl(xtdinteres)
      AddParam Envia, CDbl(xtdcupon)                            'Cupones
      AddParam Envia, CDbl(xtdamort)                            'Amortización
      AddParam Envia, CDbl(xtdPeriodo)                          'Periodo Vcto Cupón
      AddParam Envia, CDbl(xtdDecimales)                        'Nº de Decimales
      If Not Bac_Sql_Execute("sp_tdgenerar", Envia) Then
         Exit Function
      End If
      
      With grilla
         .Rows = 2
         Call F_BacLimpiaGrilla(grilla)
         
         Do While Bac_SQL_Fetch(Datos())
             .Row = .Rows - 1
             .TextMatrix(.Row, Mascara) = Datos(1)         'mascara
             .TextMatrix(.Row, Ncupon) = Val(Datos(3))     'cupon
             .TextMatrix(.Row, FecVcto) = Format(Datos(2), "DD/MM/YYYY") 'fecha venci
             .TextMatrix(.Row, Interes) = CDbl(Datos(4))    'interes
             .TextMatrix(.Row, Amortiza) = CDbl(Datos(5))   'amortizacion
             .TextMatrix(.Row, Flujo) = CDbl(Datos(6))      'flujo
             .TextMatrix(.Row, Saldos) = CDbl(Datos(7))     'saldo
   
             .Rows = .Rows + 1
         Loop
      End With
   Else

      Envia = Array()
      AddParam Envia, xtdmascara
      If Not Bac_Sql_Execute("sp_creaprc", Envia) Then Exit Function
         Call LeerTD(xtdmascara)
      End If
      CalculaTD = True
   
Exit Function
ErrCalcula:
    
   MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical, TITSISTEMA
   Exit Function

   On Error GoTo ErrCalcula
   
   DB.Execute "Delete * From MDTD"

   CalculaTD = False
   
   If Mid$(xtdmascara, 1, 3) <> "PRC" Then
      Envia = Array()
      AddParam Envia, xtdmascara                                'Máscara
      AddParam Envia, xtdfecven                                 'Fecha Vencimiento
      AddParam Envia, CDbl(xtdcupon)                            'Cupones
      AddParam Envia, CDbl(xtdamort)                            'Amortización
      AddParam Envia, CDbl(xtdPeriodo)                          'Periodo Vcto Cupón
      AddParam Envia, CDbl(xtdDecimales)                        'Nº de Decimales
      
      If Not Bac_Sql_Execute("sp_tdgenerar ", Envia) Then
         Exit Function
      End If
      
      Do While Bac_SQL_Fetch(Datos())
         Data2.Recordset.AddNew
         Data2.Recordset("Mascara") = Datos(1)
         Data2.Recordset("FechaVencimiento") = Format(Datos(2), "MM/DD/YYYY")
         Data2.Recordset("Cupon") = Val(Datos(3))
         Data2.Recordset("Interes") = Val(Datos(4))
         Data2.Recordset("Amortizacion") = Val(Datos(5))
         Data2.Recordset("Flujo") = Val(Datos(6))
         Data2.Recordset("Saldo") = Val(Datos(7))
         Data2.Recordset.Update
      Loop

      Data2.Refresh

      If Data2.Recordset.RecordCount = 0 Then
         Exit Function
      End If
   
   Else
      Envia = Array()
      AddParam Envia, xtdmascara
      If Not Bac_Sql_Execute("sp_creaprc", Envia) Then
         Exit Function
      End If
      Call LeerTD(xtdmascara)
   End If
   
   CalculaTD = True
   Exit Function
End Function

Function LeerTD(xMascara As String) As Boolean
   Dim sql As String
   
   LeerTD = False
   Existe = False
   
'''''''''''''''''''''''''''''''    Sql = ""
'''''''''''''''''''''''''''''''    Sql = "EXECUTE sp_tdleer '" & xMascara & "'"
     
    Envia = Array()
    
    AddParam Envia, xMascara
     
    If Not Bac_Sql_Execute("sp_tdleer", Envia) Then
       Exit Function
    End If
    
With grilla
        
    .Redraw = False
    .Rows = 2
        
    Call F_BacLimpiaGrilla(grilla)
   
    Do While Bac_SQL_Fetch(Datos())
          .Row = .Rows - 1
          .TextMatrix(.Row, Mascara) = Datos(1)  'mascara
          .TextMatrix(.Row, Ncupon) = Datos(2) 'cupon
          .TextMatrix(.Row, FecVcto) = Format(Datos(3), "DD/MM/YYYY") 'fecha venci
          .TextMatrix(.Row, Interes) = Format(Datos(4), FDecimales) 'interes
          .TextMatrix(.Row, Amortiza) = Format(Datos(5), FDecimales) 'amortizacion
          .TextMatrix(.Row, Flujo) = Format(Datos(6), FDecimales) 'flujo
          
'''          .TextMatrix(.Row, Interes) = Format(datos(4), "#,##0.000000") 'interes
'''          .TextMatrix(.Row, Amortiza) = Format(datos(5), "#,##0.000000") 'amortizacion
'''          .TextMatrix(.Row, Flujo) = Format(datos(6), "#,##0.000000") 'flujo
          
          
          If Left(Datos(7), 1) = "-" Then
            '.TextMatrix(.Row, Saldos) = "-" + Format(Mid(datos(7), 2, Len(datos(7))), "#,##0.000000")
            .TextMatrix(.Row, Saldos) = "-" + Format(Mid(Datos(7), 2, Len(Datos(7))), FDecimales)
          Else
            '.TextMatrix(.Row, Saldos) = Format(datos(7), "#,##0.000000") 'saldo
            .TextMatrix(.Row, Saldos) = Format(Datos(7), FDecimales) 'saldo
          End If
          Existe = True
          .Rows = .Rows + 1
    Loop
    
    'Call BacAgrandaGrilla(Grilla, 40)
    
    .Redraw = True
    
    If Existe = True Then
       .Enabled = True
    Else
      ' .Enabled = False
       'Toolbar1.Buttons(2).Enabled = True
       'Toolbar1.Buttons(3).Enabled = False
'      CmdSaldos.Enabled = False
    End If
          
    LeerTD = Existe
    
End With

    
End Function


Function LimpiaTD() As Boolean
On Error GoTo ErrLimpia

LimpiaTD = False

'''''''''''''''''''''''''' Sql = "Sp_Limpia_TablaDesarrollo '" & xtdmascara & "'"

Envia = Array()

AddParam Envia, xtdmascara

If Not Bac_Sql_Execute("Sp_Limpia_TablaDesarrollo", Envia) Then
  Exit Function
End If

LimpiaTD = True
Exit Function

ErrLimpia:
  MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical, TITSISTEMA
  Exit Function

End Function

Private Sub SumarGrilla()

On Error GoTo Label1

Dim f%
Dim Max As Long
Dim Pos As Integer
Dim Saldo As Double
 
    Saldo = 100#

With grilla

        Pos = .Row
    
    
        For f% = 1 To .Rows - 1
              '.Row = f%
          If Trim$(.TextMatrix(f%, Ncupon)) <> "" Then
            
              'Saldo = Format(Saldo - CDbl(.TextMatrix(f%, Amortiza)), FDecimal)  'AMORTIZACION
              Saldo = Format(Saldo - CDbl(.TextMatrix(f%, Amortiza)), FDecimales)    'AMORTIZACION
             
             .TextMatrix(f%, Saldos) = Saldo
             
             If Mid(.TextMatrix(f%, Saldos), 1, 1) = "-" Then
             
               '.TextMatrix(f%, Saldos) = Format(Mid(Saldo, 2, Len(Saldo)), FDecimal)
             .TextMatrix(f%, Saldos) = Format(Mid(Saldo, 2, Len(Saldo)), FDecimales)
               .TextMatrix(f%, Saldos) = "-" + .TextMatrix(f%, Saldos)
             
             Else
             '.TextMatrix(f%, Saldos) = Format(.TextMatrix(f%, Saldos), FDecimal)
             .TextMatrix(f%, Saldos) = Format(.TextMatrix(f%, Saldos), FDecimales)
              ' .TextMatrix(.Row, Saldos) = Format(Val(Str(Saldo)), "###,###,###0.#####0")
             
             End If
             
             
          End If
          
        Next f%
   
        .Row = Pos
        .SetFocus

 
  End With

Exit Sub

Label1:

    MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical, TITSISTEMA
    Exit Sub
    
''On Error GoTo Label1
''
''Dim F   As Long
''Dim Max As Long
''Dim Pos As Integer
''Dim Saldo As Double
''
''    Saldo = 100
''
''    Pos = grdDesa.RowIndex
''
''    Data2.Refresh
''
''
''    Do While Not Data2.Recordset.EOF
''
''       Saldo = Saldo - Data2.Recordset("Amortizacion")
''       Data2.Recordset.Edit
''       Data2.Recordset("Saldo") = Saldo
''       Data2.Recordset.Update
''       Data2.Recordset.MoveNext
''    Loop
''
''    grdDesa.RowIndex = Pos
''
''Exit Sub
''
''Label1:
''    MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical
''    Exit Sub
''
    
End Sub

'Private Sub cmdCalcular_Click()
'
'    Screen.MousePointer = 11
'
'
'    If Not LeerTD(ParamSerie) Then
'       If Not CalculaTD() Then
'          MsgBox "No se pudo generar tabla de desarrollo", vbOKOnly + vbExclamation
'       End If
'    End If
'
'     Screen.MousePointer = 0
'
'End Sub

Private Sub cmdGenerarTabla_Click()

Dim f As Long

 On Error GoTo Label1

 Screen.MousePointer = 11

        If GrabarTD Then
           MsgBox "La Grabacion se realizó con éxito", vbOKOnly + vbInformation, TITSISTEMA
           If Not LeerTD(ParamSerie) Then
              MsgBox "No se puede leer tabla de desarrollo", vbOKOnly + vbExclamation, TITSISTEMA
           End If
        Else
           MsgBox "No se completo la grabacion", vbOKOnly + vbExclamation, TITSISTEMA
        End If
  
 Screen.MousePointer = 0
 
Exit Sub

Label1:
    Screen.MousePointer = 0
    MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical, TITSISTEMA
    Exit Sub

End Sub


Private Sub CmdSaldos_Click()
    
        Call SumarGrilla
End Sub

Private Sub cmdSalir_Click()
        Unload Me
End Sub

Private Sub Form_Activate()
On Error GoTo Label1
Dim i As Integer
Dim f   As Long
Dim Max As Long
'Dim FDecimales As Variant
'FDecimal


    If proOrigense = "SE" Then
        MousePointer = 11
        BacControlWindows 60
        Existe = False
        
        'Lee los parámetros del form de series
        'y los asigna a variables del form
        '-------------------------------------
        If Trim$(Me.Tag) <> "" Then
             ParamSerie = ""
             ParamTera = ""
             ParamCupones = ""
             ParamNumAmor = ""
             ParamPeriodo = ""
             ParamNumDec = ""
             ParamFecha = ""
                              
             'Sub Serie antes era (mascara)
             '-----------------------------------------
             f = InStr(1, Me.Tag, "@", 1)
             ParamSerie = Mid$(Me.Tag, 1, f - 1)
             Me.Tag = Mid$(Me.Tag, f + 1, Len(Me.Tag))
             
             'interes o tera
             '-----------------------------------------
             f = InStr(1, Me.Tag, "@", 1)
             ParamTera = CStr((Mid$(Me.Tag, 1, f - 1)))
             Me.Tag = Mid$(Me.Tag, f + 1, Len(Me.Tag))
             
             'cupones
             '-----------------------------------------
             f = InStr(1, Me.Tag, "@", 1)
             ParamCupones = Mid$(Me.Tag, 1, f - 1)
             Me.Tag = Mid$(Me.Tag, f + 1, Len(Me.Tag))
             
             'numero amortizacion
             '-----------------------------------------
             f = InStr(1, Me.Tag, "@", 1)
             ParamNumAmor = Mid$(Me.Tag, 1, f - 1)
             Me.Tag = Mid$(Me.Tag, f + 1, Len(Me.Tag))
             
             'periodo
             '-----------------------------------------
             f = InStr(1, Me.Tag, "@", 1)
             ParamPeriodo = Mid$(Me.Tag, 1, f - 1)
             Me.Tag = Mid$(Me.Tag, f + 1, Len(Me.Tag))
             
             'num decimales
             '-----------------------------------------
             f = InStr(1, Me.Tag, "@", 1)
             ParamNumDec = Mid$(Me.Tag, 1, f - 1)
             Me.Tag = Mid$(Me.Tag, f + 1, Len(Me.Tag))
             
              FDecimales = " #,##0."
             For i = 1 To ParamNumDec - 1
                FDecimales = FDecimales & "#"
            Next
             FDecimales = FDecimales & "0"
'Print FDecimal
'#,##0.#####0
'#,##0.0000
             'Fecha Emision
             '-----------------------------------------
             ParamFecha = Mid$(Me.Tag, 1, Len(Me.Tag))
             
             'Mascara
             '-----------------------------------------
             txtSerie.Text = mascaraux
             
             'Numero Decimal
             '-----------------------------------------
             txtNumDecimal.Text = ParamNumDec
             
             xtdmascara = mascaraux
             xtdfecven = ParamFecha
             xtdinteres = ParamTera
             xtdcupon = ParamCupones
             xtdamort = ParamNumAmor
             xtdPeriodo = ParamPeriodo
             xtdDecimales = ParamNumDec
        End If
    Else
        xtdmascara = mascaraux
    End If
    
    'Call BacAgrandaGrilla(Grilla, 40)
    
    
    If Not LeerTD(mascaraux) Then
        If Not CalculaTD() Then
            MsgBox "No se pudo generar tabla de desarrollo", vbOKOnly + vbExclamation, TITSISTEMA
        End If
    End If
'        txtSerie.Text = mascaraux
    MousePointer = 0
    
    Exit Sub

Label1:
    MousePointer = 0
    MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical, TITSISTEMA
    Exit Sub
End Sub

Private Sub Form_Load()

Me.Top = 1150
Me.Left = 30


On Error GoTo ErrDbf

'     Set objDesa = New clsTDesarrollos
     Set objMensajesTD = New ClsMsg
     
    Call CargarParam(grilla)
      
    ''Call objMensajesTD.Valores
     
    ''grdDesa.ColumnCellAttrs(1) = True
    ''grdDesa.ColumnCellAttrs(2) = True
    ''grdDesa.ColumnCellAttrs(3) = True
    ''grdDesa.ColumnCellAttrs(4) = True
    ''grdDesa.ColumnCellAttrs(5) = True
    ''grdDesa.ColumnCellAttrs(6) = True
    
    
    ''Data2.DatabaseName = gsMDB_Path & gsMDB_Database
    ''Data2.RecordSource = "MDTD"
    ''Data2.Refresh
      
    Exit Sub
    
ErrDbf:
  If Err.Number = 3051 Then
     MsgBox "No se puede conectar a tabla de desarrollo", vbOKOnly + vbExclamation, TITSISTEMA
     Unload Me
     Exit Sub
  Else
     MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical, TITSISTEMA
     Unload Me
     Exit Sub
   End If
    
    
End Sub

Private Sub RecalcularFila(nRow As Long)
On Error GoTo Label1
        
  '  grdDesa.RowIndex = nRow
  '  Data2.Recordset.Edit
  '  Data2.Recordset("Flujo") = Data2.Recordset("Interes") + Data2.Recordset("Amortizacion")
  '  Data2.Recordset("Saldo") = Data2.Recordset("Amortizacion") - Data2.Recordset("Flujo")
  '  Data2.Recordset.Update
      
Exit Sub

Label1:
    MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical, TITSISTEMA
    Exit Sub

End Sub


Private Sub Form_Unload(Cancel As Integer)
   ' DB.Execute "Delete * From MDTD" 'DBINAVILITADO
    If BacMnSe1.proOrigense = "SE" Then
        BacMntSe.Enabled = True
    End If
     
End Sub



Private Sub Grilla_DblClick()

 Call grilla_KeyPress(vbKeyReturn)
 
End Sub

Private Sub grilla_KeyPress(KeyAscii As Integer)

With grilla
            
            
    If .Col = 2 Or .Col = 3 Then
           
        If Trim$(.TextMatrix(.Row, 0)) <> "" And (KeyAscii = 13 Or KeyAscii = 8 Or IsNumeric(Chr(KeyAscii))) Then
           
           .Enabled = False
            txtNumerico.Visible = True
            txtNumerico.CantidadDecimales = Val(txtNumDecimal.Text)
            txtNumerico.Text = .TextMatrix(.Row, .Col)
            PROC_POSICIONA_TEXTOX grilla, txtNumerico
            txtNumerico.SetFocus
            txtNumerico.Text = Chr(KeyAscii)
            SendKeys "{RIGHT}"    'Comienzo Izquierda
        End If
        
   End If
   
 End With

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Index
    Case 1
        Dim f As Long

 On Error GoTo Label1

 Screen.MousePointer = 11

        If GrabarTD Then
           MsgBox "La Grabacion se realizó con éxito", vbOKOnly + vbInformation, TITSISTEMA
           If Not LeerTD(Trim(txtSerie.Text)) Then
              MsgBox "No se puede leer tabla de desarrollo", vbOKOnly + vbExclamation, TITSISTEMA
           End If
        Else
           MsgBox "No se completo la grabacion", vbOKOnly + vbExclamation, TITSISTEMA
        End If
  
 Screen.MousePointer = 0
 
Exit Sub

Label1:
    Screen.MousePointer = 0
    MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical, TITSISTEMA
    Exit Sub

    Case 2
       
      Screen.MousePointer = 11
   
      'If Not LeerTD(Trim(txtSerie.Text)) Then
         If Not CalculaTD() Then
            MsgBox "No se pudo generar tabla de desarrollo", vbOKOnly + vbExclamation, TITSISTEMA
         End If
      'End If
    
      Screen.MousePointer = 0
    
    Case 3
        Call SumarGrilla
    Case 4
        Unload Me
End Select
End Sub

Private Sub txtNumDecimal_KeyPress(KeyAscii As Integer)

    If Not IsNumeric(Chr(KeyAscii)) Then
        KeyAscii = 0
    End If
    
End Sub


Public Function CargarParam(Grillas As Object)

With Grillas
          
          .RowHeight(0) = 340
          .CellFontWidth = 4
          .Row = 0
         
         .Col = 0: .FixedAlignment(0) = 4
         .CellFontBold = True
         .TextMatrix(.Row, 0) = " N°Cupon "
         .ColWidth(0) = 1000
         .ColAlignment(0) = 4

         .Col = 1: .FixedAlignment(1) = 4
         .CellFontBold = True
         .TextMatrix(.Row, 1) = " Fech. Vcto  "
         .ColWidth(1) = 1300
         .ColAlignment(1) = 4

         .Col = 2: .FixedAlignment(2) = 4
         .CellFontBold = True
         .TextMatrix(.Row, 2) = " Interes "
         .ColWidth(2) = 1300
         .ColAlignment(2) = 8

         .Col = 3: .FixedAlignment(3) = 4
         .CellFontBold = True
         .TextMatrix(.Row, 3) = " Amortización  "
         .ColWidth(3) = 1300
         .ColAlignment(3) = 8

         .Col = 4: .FixedAlignment(4) = 4
         .CellFontBold = True
         .TextMatrix(.Row, 4) = "  Flujo     "
         .ColWidth(4) = 1300
         .ColAlignment(4) = 8
         
         .Col = 5: .FixedAlignment(5) = 4
         .CellFontBold = True
         .TextMatrix(.Row, 5) = "   Saldo    "
         .ColWidth(5) = 1300
         .ColAlignment(5) = 8
         
         .ColWidth(6) = 1   'mascara
         
         
End With


    Toolbar1.Buttons(3).Visible = False
    

End Function

Private Sub txtNumerico_KeyPress(KeyAscii As Integer)

On Error GoTo Label1

Dim nInteres      As Double
Dim nAmortizacion As Double
Dim nFactor       As Double
Dim nsaldoa       As Double

 
With grilla

If KeyAscii = vbKeyReturn Then
    
    Select Case .Col
    
        Case 2, 3
         
            If .Col = 2 Then
               ' << Interes >>
              '.TextMatrix(.Row, Interes) = Format(TXTNumerico.Text, "#,##0.000000")
              .TextMatrix(.Row, Interes) = Format(txtNumerico.Text, FDecimales)
            End If
            
            If .Col = 3 Then
               ' << Amortización >>
              '.TextMatrix(.Row, Amortiza) = Format(TXTNumerico.Text, "#,##0.000000")
              .TextMatrix(.Row, Amortiza) = Format(txtNumerico.Text, FDecimales)
            End If
            
                 
            'Suma el Flujo
            '-------------
            
           ' flujo = nInteres + nAmortizacion
            .TextMatrix(.Row, Flujo) = CDbl(.TextMatrix(.Row, Interes)) + CDbl(.TextMatrix(.Row, Amortiza))
            '.TextMatrix(.Row, Flujo) = Format(CDbl(.TextMatrix(.Row, Flujo)), "###,###,###0.#####0")
            .TextMatrix(.Row, Flujo) = Format(CDbl(.TextMatrix(.Row, Flujo)), FDecimales)
                       
            'Saldo
            '-------------


              
            If .Row = 1 Then
                    nFactor = 100
            Else
                    nFactor = CDbl(.TextMatrix(.Row - 1, Saldos))
            End If
            
                .TextMatrix(.Row, Saldos) = CDbl(nFactor - CDbl(.TextMatrix(.Row, Amortiza)))
              
                '.TextMatrix(.Row, Saldos) = Format(CDbl(.TextMatrix(.Row, Saldos)), "###,###,###0.#####0")
                .TextMatrix(.Row, Saldos) = Format(CDbl(.TextMatrix(.Row, Saldos)), FDecimales)
    End Select
    
     .Enabled = True
     .SetFocus
     
     
     Call SumarGrilla
  
End If

    If KeyAscii = vbKeyEscape Then
        .Enabled = True
        .SetFocus
    End If
  
End With

Exit Sub

Label1:
    MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical, TITSISTEMA
    Exit Sub

End Sub

Private Sub txtNumerico_LostFocus()

    txtNumerico.Visible = False
    txtNumerico.Text = ""
    grilla.Enabled = True

End Sub

