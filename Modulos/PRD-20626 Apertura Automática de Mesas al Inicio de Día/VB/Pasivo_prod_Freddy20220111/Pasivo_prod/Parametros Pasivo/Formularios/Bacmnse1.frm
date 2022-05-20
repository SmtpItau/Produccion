VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "threed32.ocx"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{989C9190-EDF5-45A8-AB6C-98E6EF0384D7}#1.0#0"; "Bac_Controles_Pas.ocx"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "COMDLG32.OCX"
Begin VB.Form BacMnSe1 
   Appearance      =   0  'Flat
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantención de Tablas de Desarrollo"
   ClientHeight    =   4950
   ClientLeft      =   2160
   ClientTop       =   2295
   ClientWidth     =   8370
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
   ScaleHeight     =   4950
   ScaleWidth      =   8370
   Begin Threed.SSPanel SSPanel1 
      Height          =   4515
      Left            =   0
      TabIndex        =   2
      Top             =   480
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
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   285
         Left            =   3570
         MaxLength       =   1
         TabIndex        =   6
         Top             =   180
         Width           =   285
      End
      Begin VB.TextBox txtSerie 
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   285
         Left            =   840
         MaxLength       =   10
         TabIndex        =   5
         Top             =   195
         Width           =   1245
      End
      Begin BACControles.TXTNumero txtNumerico 
         Height          =   255
         Left            =   2505
         TabIndex        =   3
         Top             =   1905
         Visible         =   0   'False
         Width           =   1815
         _ExtentX        =   3201
         _ExtentY        =   450
         BackColor       =   -2147483634
         ForeColor       =   -2147483635
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BorderStyle     =   0
         Text            =   "0.0000"
         Text            =   "0.0000"
         Min             =   "-999.00"
         Max             =   "999.00"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
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
         Cols            =   8
         FixedCols       =   0
         BackColor       =   -2147483644
         ForeColor       =   8388608
         BackColorFixed  =   8421376
         ForeColorFixed  =   16777215
         BackColorBkg    =   12632256
         GridColor       =   255
         FocusRect       =   0
         GridLines       =   2
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
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
            Caption         =   "Serie"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000007&
            Height          =   210
            Index           =   0
            Left            =   105
            TabIndex        =   9
            Top             =   210
            Width           =   435
         End
         Begin VB.Label Label 
            Appearance      =   0  'Flat
            Caption         =   "Nº Decimales"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000007&
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
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   480
      Left            =   0
      TabIndex        =   1
      Top             =   0
      Width           =   8370
      _ExtentX        =   14764
      _ExtentY        =   847
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "Img_opciones"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   5
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Generar"
            ImageIndex      =   9
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Recalcular"
            ImageIndex      =   6
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Cerrar Ventana"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.Visible         =   0   'False
            Object.ToolTipText     =   "Cargar TD"
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComDlg.CommonDialog dlg_Rutas 
         Left            =   7125
         Top             =   30
         _ExtentX        =   847
         _ExtentY        =   847
         _Version        =   393216
      End
      Begin MSComctlLib.ImageList Img_opciones 
         Left            =   5940
         Top             =   -30
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   24
         ImageHeight     =   24
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   9
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacmnse1.frx":2EFA
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacmnse1.frx":3361
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacmnse1.frx":3857
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacmnse1.frx":3CEA
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacmnse1.frx":41D2
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacmnse1.frx":46E5
               Key             =   ""
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacmnse1.frx":4BB8
               Key             =   ""
            EndProperty
            BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacmnse1.frx":507E
               Key             =   ""
            EndProperty
            BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacmnse1.frx":5575
               Key             =   ""
            EndProperty
         EndProperty
      End
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
Dim OptLocal       As String

Dim Sql As String
Dim Datos()
'Public Saldos As Double
Dim FormatDecimal  As String

Const Ncupon = 0
Const FecVcto = 1
Const Interes = 2
Const Amortiza = 3
Const Flujo = 4
Const Saldos = 5
Const Mascara = 6
Const TasaVariable = 7

Dim Existe As Boolean
Public proOrigense As String   ' SE ->series  CT ->crear Tabla
Public cTasaVariable As String

Public Function GrabarTD() As Boolean

Dim f%, c%

On Error GoTo ErrGrabar

   GrabarTD = False
   
   If Not LimpiaTD Then
     Exit Function
   End If
   
   If BAC_SQL_EXECUTE("BEGIN TRANSACTION") Then
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
            AddParam Envia, IIf(cTasaVariable = "S", CDbl(.TextMatrix(.Row, TasaVariable)), 0)
              
              
            If BAC_SQL_EXECUTE("Sp_Grabar_TablaDesarrollo", Envia) Then
                
                Do While BAC_SQL_FETCH(Datos())
                    
                    If Datos(1) = "NO" Then
                        
                        If BAC_SQL_EXECUTE("ROLLBACK TRANSACTION") Then
                           
                           End If
                        
                        Exit Function
                    
                    End If
                
                Loop
            
            End If

      End If
   
   Next f%
    
   .Redraw = True
    
End With

    If BAC_SQL_EXECUTE("COMMIT TRANSACTION") Then
    End If
    
    GrabarTD = True
    
Exit Function

ErrGrabar:
   MsgBox "Error : " & err.Description, vbOKOnly + vbCritical
   If BAC_SQL_EXECUTE("ROLLBACK TRANSACTION") Then
   
      End If
   
   Exit Function


End Function

Function CalculaTD() As Boolean

Dim Sql As String
Dim Datos()

On Error GoTo ErrCalcula

 CalculaTD = False

    If Mid$(xtdmascara, 1, 3) <> "PRC" Then
        
'''''''''''''''''''''''''''''''''''        Sql = ""
'''''''''''''''''''''''''''''''''''        Sql = "EXECUTE sp_tdgenerar "
'''''''''''''''''''''''''''''''''''        Sql = Sql & "'" & xtdmascara & "',"                       'Máscara
'''''''''''''''''''''''''''''''''''        Sql = Sql & "'" & xtdfecven & "',"                        'Fecha Vencimiento
'''''''''''''''''''''''''''''''''''        'Sql = Sql & BacFormatoSQL(xtdinteres) & ","              'Interes ó Tera
'''''''''''''''''''''''''''''''''''        Sql = Sql & xtdcupon & ","                                'Cupones
'''''''''''''''''''''''''''''''''''        Sql = Sql & xtdamort & ","                                'Amortización
'''''''''''''''''''''''''''''''''''        Sql = Sql & xtdPeriodo & ","                              'Periodo Vcto Cupón
'''''''''''''''''''''''''''''''''''        Sql = Sql & xtdDecimales                                  'Nº de Decimales

        Envia = Array()
        
        AddParam Envia, xtdmascara                                'Máscara
        AddParam Envia, xtdfecven                                 'Fecha Vencimiento
        AddParam Envia, CDbl(xtdinteres)
        AddParam Envia, CDbl(xtdcupon)                            'Cupones
        AddParam Envia, CDbl(xtdamort)                            'Amortización
        AddParam Envia, CDbl(xtdPeriodo)                          'Periodo Vcto Cupón
        AddParam Envia, CDbl(xtdDecimales)                        'Nº de Decimales
        
        If Not BAC_SQL_EXECUTE("sp_tdgenerar", Envia) Then
           
           Exit Function
        
        End If

  With grilla
       
       .Rows = 2
        Call F_BacLimpiaGrilla(grilla)

    Do While BAC_SQL_FETCH(Datos())
          
          .Row = .Rows - 1
          .TextMatrix(.Row, Mascara) = Datos(1)         'mascara
          .TextMatrix(.Row, Ncupon) = CDbl(Datos(3))     'cupon
          .TextMatrix(.Row, FecVcto) = Format(Datos(2), "DD/MM/YYYY") 'fecha venci
          .TextMatrix(.Row, Interes) = Format(CDbl(Datos(4)), FormatDecimal)   'interes
          .TextMatrix(.Row, Amortiza) = Format(CDbl(Datos(5)), FormatDecimal)  'amortizacion
          .TextMatrix(.Row, Flujo) = Format(CDbl(Datos(6)), FormatDecimal)     'flujo
          .TextMatrix(.Row, Saldos) = Format(CDbl(Datos(7)), FormatDecimal)    'saldo
          .TextMatrix(.Row, TasaVariable) = Format(0, FormatDecimal)            'Valor spread tasa variable
          .Rows = .Rows + 1
    Loop
  
  End With

       'Call BacAgrandaGrilla(Grilla, 40)
  Else
'''''''''''''''''''''''''''''''''''''''''''''''         Sql = ""
'''''''''''''''''''''''''''''''''''''''''''''''         Sql = "sp_creaprc '"
'''''''''''''''''''''''''''''''''''''''''''''''         Sql = Sql & xtdmascara & "'"

         Envia = Array()
         
         AddParam Envia, xtdmascara

         If Not BAC_SQL_EXECUTE("sp_creaprc", Envia) Then Exit Function
           Call LeerTD(xtdmascara)
          End If

         CalculaTD = True

Exit Function

ErrCalcula:
    
    MsgBox "Error : " & err.Description, vbOKOnly + vbCritical
    
    Exit Function


On Error GoTo ErrCalcula

DB.Execute "Delete * From MDTD"

    CalculaTD = False
    If Mid$(xtdmascara, 1, 3) <> "PRC" Then
'''''''''''''''''''''''''''''''''''''''''''        Sql = "EXECUTE sp_tdgenerar "
'''''''''''''''''''''''''''''''''''''''''''        Sql = Sql & "'" & xtdmascara & "',"                       'Máscara
'''''''''''''''''''''''''''''''''''''''''''        Sql = Sql & "'" & xtdfecven & "',"                        'Fecha Vencimiento
'''''''''''''''''''''''''''''''''''''''''''        'Sql = Sql & BacFormatoSQL(xtdinteres) & ","              'Interes ó Tera
'''''''''''''''''''''''''''''''''''''''''''        Sql = Sql & xtdcupon & ","                                'Cupones
'''''''''''''''''''''''''''''''''''''''''''        Sql = Sql & xtdamort & ","                                'Amortización
'''''''''''''''''''''''''''''''''''''''''''        Sql = Sql & xtdPeriodo & ","                              'Periodo Vcto Cupón
'''''''''''''''''''''''''''''''''''''''''''        Sql = Sql & xtdDecimales                                  'Nº de Decimales

        Envia = Array()
        
        AddParam Envia, xtdmascara                                'Máscara
        AddParam Envia, xtdfecven                                 'Fecha Vencimiento
        AddParam Envia, CDbl(xtdcupon)                            'Cupones
        AddParam Envia, CDbl(xtdamort)                            'Amortización
        AddParam Envia, CDbl(xtdPeriodo)                          'Periodo Vcto Cupón
        AddParam Envia, CDbl(xtdDecimales)                        'Nº de Decimales


        If Not BAC_SQL_EXECUTE("sp_tdgenerar ", Envia) Then
           
           Exit Function
        
        End If
        
        Do While BAC_SQL_FETCH(Datos())
            
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
        
        If Not BAC_SQL_EXECUTE("sp_creaprc", Envia) Then Exit Function
        
        Call LeerTD(xtdmascara)
    
    End If

    CalculaTD = True

Exit Function

End Function

Function LeerTD(xMascara As String) As Boolean
   
Dim Sql As String
   
   LeerTD = False
   Existe = False
   
'''''''''''''''''''''''''''''''    Sql = ""
'''''''''''''''''''''''''''''''    Sql = "EXECUTE sp_tdleer '" & xMascara & "'"
     
    Envia = Array()
    
    AddParam Envia, xMascara
     
    If Not BAC_SQL_EXECUTE("sp_tdleer", Envia) Then
       Exit Function
    End If
    
With grilla
        
    .Redraw = False
    .Rows = 2
        
    Call F_BacLimpiaGrilla(grilla)
   
    Do While BAC_SQL_FETCH(Datos())
          .Row = .Rows - 1
          .TextMatrix(.Row, Mascara) = Datos(1)  'mascara
          .TextMatrix(.Row, Ncupon) = Datos(2) 'cupon
          .TextMatrix(.Row, FecVcto) = Format(Datos(3), "DD/MM/YYYY") 'fecha venci
          .TextMatrix(.Row, Interes) = Format(Datos(4), FormatDecimal) 'interes
          .TextMatrix(.Row, Amortiza) = Format(Datos(5), FormatDecimal) 'amortizacion
          .TextMatrix(.Row, Flujo) = Format(Datos(6), FormatDecimal) 'flujo
          
          If left(Datos(7), 1) = "-" Then
            .TextMatrix(.Row, Saldos) = "-" + Format(Mid(Datos(7), 2, Len(Datos(7))), FormatDecimal)
          Else
            .TextMatrix(.Row, Saldos) = Format(Datos(7), FormatDecimal) 'saldo
          End If
          .TextMatrix(.Row, TasaVariable) = Format(Datos(8), FormatDecimal) 'Valor spread tasa variable
          
          Existe = True
          .Rows = .Rows + 1
    Loop
    
    'Call BacAgrandaGrilla(Grilla, 40)
    
    .Redraw = True
    
    If Existe Then
       .Enabled = True
       Toolbar1.Buttons(2).Enabled = True
       Toolbar1.Buttons(3).Enabled = True
    Else
       .Enabled = False
       Toolbar1.Buttons(2).Enabled = False
       Toolbar1.Buttons(3).Enabled = False
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

If Not BAC_SQL_EXECUTE("Sp_Limpia_TablaDesarrollo", Envia) Then
  Exit Function
End If

LimpiaTD = True
Exit Function

ErrLimpia:
  MsgBox "Error : " & err.Description, vbOKOnly + vbCritical
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
            
              Saldo = Saldo - CDbl(.TextMatrix(f%, Amortiza)) 'AMORTIZACION
             .TextMatrix(f%, Saldos) = Saldo
             
             If Mid(.TextMatrix(f%, Saldos), 1, 1) = "-" Then
             
               .TextMatrix(f%, Saldos) = Format(Mid(Saldo, 2, Len(Saldo)), FormatDecimal)
             
               .TextMatrix(f%, Saldos) = "-" + .TextMatrix(f%, Saldos)
             
             Else
             
               .TextMatrix(f%, Saldos) = Format(.TextMatrix(f%, Saldos), FormatDecimal) ' FDECIMAL
               '.TextMatrix(.Row, saldos) = Format(Val(Str(Saldo)), "###,###,###0.###0")
             
             End If
             
             
          End If
          
        Next f%
   
        .Row = Pos
        .SetFocus
 
  End With

Exit Sub

Label1:

    MsgBox "Error : " & err.Description, vbOKOnly + vbCritical
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
           MsgBox "La Grabacion se realizó con éxito", vbOKOnly + vbInformation
           If Not LeerTD(ParamSerie) Then
              MsgBox "No se puede leer tabla de desarrollo", vbOKOnly + vbExclamation
           End If
        Else
           MsgBox "No se completo la grabacion", vbOKOnly + vbExclamation
        End If
  
 Screen.MousePointer = 0
 
Exit Sub

Label1:
    Screen.MousePointer = 0
    MsgBox "Error : " & err.Description, vbOKOnly + vbCritical
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

Dim f   As Long
Dim Max As Long
   
   PROC_CARGA_AYUDA Me, " "
   
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
             
             'Fecha Emision
             '-----------------------------------------
             ParamFecha = Mid$(Me.Tag, 1, Len(Me.Tag))
             
             'Mascara
             '-----------------------------------------
             txtSerie.Text = mascaraux
             
             'Numero Decimal
             '-----------------------------------------
             txtNumDecimal.Text = ParamNumDec
             txtNumerico.CantidadDecimales = ParamNumDec
             
             FormatDecimal = FormatDec(ParamNumDec)
             
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
            MsgBox "No se pudo generar tabla de desarrollo", vbOKOnly + vbExclamation
        End If
    End If
'        txtSerie.Text = mascaraux
    MousePointer = 0
    
    Exit Sub

Label1:
    MousePointer = 0
    MsgBox "Error : " & err.Description, vbOKOnly + vbCritical
    Exit Sub
End Sub

Function FormatDec(Decimales As Variant) As String

   FormatDec = "#,##0"
   If Decimales > 0 Then
      FormatDec = FormatDec + "."
      FormatDec = FormatDec + String(Decimales, "#")
      FormatDec = Mid(FormatDec, 1, Len(FormatDec) - 1) + "0"
   End If
   

End Function

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
Dim opcion As Integer

If KeyCode = vbKeyReturn And UCase(Me.ActiveControl.Name) <> "TXTNUMERICO" And UCase(Me.ActiveControl.Name) <> "GRILLA" Then
      KeyCode = 0
      Exit Sub
End If



If KeyCode <> vbKeyControl And (Shift = 2 Or (Shift = 0 And (KeyCode = vbKeyReturn Or KeyCode = vbKeyEscape Or (KeyCode >= vbKeyF1 And KeyCode <= vbKeyF12)))) Then

opcion = 0
   Select Case KeyCode

         Case vbKeyGrabar
               opcion = 1

         Case vbKeyProcesar
               opcion = 2

         Case vbKeyCalcular
               opcion = 3
         
         Case vbKeySalir
               opcion = 4
   End Select

   If opcion <> 0 Then
      If Toolbar1.Buttons(opcion).Enabled Then
         Call Toolbar1_ButtonClick(Toolbar1.Buttons(opcion))
      End If

   End If

End If

End Sub

Private Sub Form_Load()

Me.top = 1150
Me.left = 30


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
    
    OptLocal = Opt
    Call LogAuditoria("07", OptLocal, Me.Caption, "", "")
      
    Exit Sub
    
ErrDbf:
  If err.Number = 3051 Then
     MsgBox "No se puede conectar a tabla de desarrollo", vbOKOnly + vbExclamation
     Unload Me
     Exit Sub
  Else
     MsgBox "Error : " & err.Description, vbOKOnly + vbCritical
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
    MsgBox "Error : " & err.Description, vbOKOnly + vbCritical
    Exit Sub

End Sub


Private Sub Form_Unload(Cancel As Integer)
   ' DB.Execute "Delete * From MDTD" 'DBINAVILITADO
    If BacMnSe1.proOrigense = "SE" Then
        BacMntSe.Enabled = True
    End If
    
    Call LogAuditoria("08", OptLocal, Me.Caption, "", "")
     
End Sub



Private Sub Grilla_DblClick()

 Call Grilla_KeyPress(vbKeyReturn)
 
End Sub

Private Sub Grilla_KeyPress(KeyAscii As Integer)

With grilla
            
            
    If .Col = 2 Or .Col = 3 Or .Col = 7 Then
           
        If Trim$(.TextMatrix(.Row, 0)) <> "" And (KeyAscii = 13 Or KeyAscii = 8 Or IsNumeric(Chr(KeyAscii))) Then
           
           .Enabled = False
        
            txtNumerico.Text = BacCtrlTransMonto(.TextMatrix(.Row, .Col))
            If IsNumeric(Chr(KeyAscii)) Then
            
               txtNumerico.Text = Chr(KeyAscii)
               SendKeys "{RIGHT 1}"
            
            End If
            
            PROC_POSICIONA_TEXTOX grilla, txtNumerico
            
            txtNumerico.Visible = True
            txtNumerico.SetFocus
        
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
           MsgBox "La Grabacion se realizó con éxito", vbOKOnly + vbInformation
           If Not LeerTD(Trim(txtSerie.Text)) Then
              MsgBox "No se puede leer tabla de desarrollo", vbOKOnly + vbExclamation
           End If
        Else
           MsgBox "No se completo la grabacion", vbOKOnly + vbExclamation
        End If
  
        Call LogAuditoria("01", OptLocal, Me.Caption, "", "")
  
 Screen.MousePointer = 0
 
Exit Sub

Label1:
    Screen.MousePointer = 0
    MsgBox "Error : " & err.Description, vbOKOnly + vbCritical
    Exit Sub

    Case 2
        Screen.MousePointer = 11
  
        'If Not LeerTD(Trim(txtSerie.Text)) Then
           If Not CalculaTD() Then
              MsgBox "No se pudo generar tabla de desarrollo", vbOKOnly + vbExclamation
           End If
        'End If
        
           Call LogAuditoria("19", OptLocal, Me.Caption, "", "")
        
        Screen.MousePointer = 0
        
    Case 3
        Call SumarGrilla
        Call LogAuditoria("20", OptLocal, Me.Caption, "", "")

    Case 4
        Unload Me
        
   Case 5
         func_carga_TD dlg_Rutas, grilla
         
         
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
         
          grilla.Cols = 8
            
         
         .Col = 0: .FixedAlignment(0) = 4
         .CellFontBold = True
         .TextMatrix(.Row, 0) = " N°Cupon "
         .ColWidth(0) = TextWidth(.TextMatrix(.Row, 0)) + 200
         .ColAlignment(0) = 4

         .Col = 1: .FixedAlignment(1) = 4
         .CellFontBold = True
         .TextMatrix(.Row, 1) = "  Fech. Vcto   "
         .ColWidth(1) = TextWidth(.TextMatrix(.Row, 1)) + 300
         .ColAlignment(1) = 4

         .Col = 2: .FixedAlignment(2) = 4
         .CellFontBold = True
         .TextMatrix(.Row, 2) = "   Interes   "
         .ColWidth(2) = TextWidth(.TextMatrix(.Row, 2)) + 300
         .ColAlignment(2) = 8

         .Col = 3: .FixedAlignment(3) = 4
         .CellFontBold = True
         .TextMatrix(.Row, 3) = "     Amortización      "
         .ColWidth(3) = TextWidth(.TextMatrix(.Row, 3)) + 300
         .ColAlignment(3) = 8

         .Col = 4: .FixedAlignment(4) = 4
         .CellFontBold = True
         .TextMatrix(.Row, 4) = "        Flujo             "
         .ColWidth(4) = TextWidth(.TextMatrix(.Row, 4)) + 300
         .ColAlignment(4) = 8
         
         .Col = 5: .FixedAlignment(5) = 4
         .CellFontBold = True
         .TextMatrix(.Row, 5) = "        Saldo             "
         .ColWidth(5) = TextWidth(.TextMatrix(.Row, 5)) + 300
         .ColAlignment(5) = 8
         
         .ColWidth(6) = 1   'mascara
         
         If cTasaVariable = "S" Then
            .Col = 7: .FixedAlignment(7) = 4
            .CellFontBold = True
            .TextMatrix(.Row, 7) = "     Tasa Variable     "
            .ColWidth(7) = TextWidth(.TextMatrix(.Row, 7)) + 300
            .ColAlignment(7) = 8
         Else
            .ColWidth(7) = 1
         End If
         
         
         
End With

End Function

Private Sub TXTNumerico_KeyPress(KeyAscii As Integer)

On Error GoTo Label1

Dim nInteres      As Double
Dim nAmortizacion As Double
Dim nFactor       As Double
Dim nsaldoa       As Double

 
With grilla

If KeyAscii = vbKeyReturn Then
    
    Select Case .Col
    
        Case 2, 3, 7
         
            If .Col = 2 Then
               ' << Interes >>
              .TextMatrix(.Row, Interes) = Format(txtNumerico.Text, FormatDecimal)
            End If
            
            If .Col = 3 Then
               ' << Amortización >>
                .TextMatrix(.Row, Amortiza) = Format(txtNumerico.Text, FormatDecimal)
            End If
            If .Col = 7 Then
               ' << Tasa Variable >>
                .TextMatrix(.Row, TasaVariable) = Format(txtNumerico.Text, FormatDecimal)
            End If
            
                 
            'Suma el Flujo
            '-------------
            
           ' flujo = nInteres + nAmortizacion
            .TextMatrix(.Row, Flujo) = CDbl(.TextMatrix(.Row, Interes)) + CDbl(.TextMatrix(.Row, Amortiza))
            .TextMatrix(.Row, Flujo) = Format(CDbl(.TextMatrix(.Row, Flujo)), FormatDecimal)
                       
            'Saldo
            '-------------


              
            If .Row = 1 Then
                    nFactor = 100
            Else
                    nFactor = CDbl(.TextMatrix(.Row - 1, Saldos))
            End If
            
                .TextMatrix(.Row, Saldos) = CDbl(nFactor - CDbl(.TextMatrix(.Row, Amortiza)))
                .TextMatrix(.Row, Saldos) = Format(CDbl(.TextMatrix(.Row, Saldos)), FormatDecimal)
    
    
        
            
    End Select
    
     .Enabled = True
     .SetFocus
  
End If

    If KeyAscii = vbKeyEscape Then
        .Enabled = True
        .SetFocus
    End If
  
End With

Exit Sub

Label1:
    MsgBox "Error : " & err.Description, vbOKOnly + vbCritical
    Exit Sub

End Sub

Private Sub TXTNumerico_LostFocus()

    txtNumerico.Visible = False
    txtNumerico.Text = ""
    grilla.Enabled = True

End Sub

