VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BACCONTROLES.OCX"
Begin VB.Form BacTasasMTM 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Ingreso de Tasas Mark to Market"
   ClientHeight    =   6630
   ClientLeft      =   2085
   ClientTop       =   405
   ClientWidth     =   7545
   Icon            =   "bactasasmtm.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   6630
   ScaleWidth      =   7545
   Begin VB.Frame Frame2 
      Caption         =   "Tasas Interbancario"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   585
      Left            =   0
      TabIndex        =   1
      Top             =   1095
      Width           =   7530
      Begin BACControles.TXTNumero TxtTasaUF 
         Height          =   255
         Left            =   5280
         TabIndex        =   11
         Top             =   240
         Width           =   1335
         _ExtentX        =   2355
         _ExtentY        =   450
         ForeColor       =   -2147483635
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
         Text            =   "0,0000"
         Text            =   "0,0000"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin BACControles.TXTNumero TxtTasaNominal 
         Height          =   255
         Left            =   1560
         TabIndex        =   10
         Top             =   240
         Width           =   1575
         _ExtentX        =   2778
         _ExtentY        =   450
         ForeColor       =   -2147483635
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
         Text            =   "0,0000"
         Text            =   "0,0000"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin VB.Label Label3 
         AutoSize        =   -1  'True
         Caption         =   "Tasa UF"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   210
         Left            =   4335
         TabIndex        =   2
         Top             =   240
         Width           =   600
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "Tasa Nominal"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   210
         Left            =   135
         TabIndex        =   3
         Top             =   240
         Width           =   960
      End
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   3825
      Top             =   -15
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
            Picture         =   "bactasasmtm.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bactasasmtm.frx":075C
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bactasasmtm.frx":0BB0
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bactasasmtm.frx":0ED4
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bactasasmtm.frx":11F8
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bactasasmtm.frx":151C
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   6
      Top             =   0
      Width           =   7545
      _ExtentX        =   13309
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   6
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "CmbGrabar"
            Description     =   "CmbGrabar"
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "CmdDesviacion"
            Description     =   "CmdDesviacion"
            Object.ToolTipText     =   "Cambiar desviacion estandar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "CmdTasa"
            Description     =   "CmdTasa"
            Object.ToolTipText     =   "Tasa dolar interbancario"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "CmdImprimir"
            Description     =   "CmdImprimir"
            Object.ToolTipText     =   "Imprimir valores"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "CmdSalir"
            Description     =   "CmdSalir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "CmdAyuda"
            Description     =   "CmdAyuda"
            Object.ToolTipText     =   "Ayuda"
            ImageIndex      =   6
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin Threed.SSFrame Frame3 
      Height          =   4935
      Left            =   0
      TabIndex        =   0
      Top             =   1665
      Width           =   7530
      _Version        =   65536
      _ExtentX        =   13282
      _ExtentY        =   8705
      _StockProps     =   14
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin VB.TextBox Txt_Ingreso 
         BackColor       =   &H00800000&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   270
         Left            =   4125
         TabIndex        =   5
         Top             =   1860
         Visible         =   0   'False
         Width           =   1185
      End
      Begin MSFlexGridLib.MSFlexGrid Table1 
         Height          =   4740
         Left            =   45
         TabIndex        =   4
         Top             =   135
         Width           =   7410
         _ExtentX        =   13070
         _ExtentY        =   8361
         _Version        =   393216
         Cols            =   4
         FixedCols       =   0
         BackColor       =   -2147483644
         ForeColor       =   8388608
         BackColorFixed  =   8421376
         ForeColorFixed  =   16777215
         BackColorSel    =   8388608
         FocusRect       =   0
         GridLines       =   2
         GridLinesFixed  =   0
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
   End
   Begin Threed.SSFrame frame1 
      Height          =   585
      Left            =   0
      TabIndex        =   7
      Top             =   495
      Width           =   7530
      _Version        =   65536
      _ExtentX        =   13282
      _ExtentY        =   1032
      _StockProps     =   14
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin BACControles.TXTNumero TxtDesviacionEstandar 
         Height          =   255
         Left            =   2040
         TabIndex        =   9
         Top             =   220
         Width           =   1575
         _ExtentX        =   2778
         _ExtentY        =   450
         ForeColor       =   -2147483635
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
         Text            =   "0,0000"
         Text            =   "0,0000"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Desviacion Estandar"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   210
         Left            =   150
         TabIndex        =   8
         Top             =   225
         Width           =   1485
      End
   End
End
Attribute VB_Name = "BacTasasMTM"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim lIngresa            As Boolean
Dim lDesviacionEstandar As Boolean
Dim lTasaInterbancaria  As Boolean
Dim nDesviacionEstandar As Double
Dim nMedia              As Double
Dim nMedia1             As Double
Dim nMedia2             As Double
Dim nMedia3             As Double
Dim nDesvEst            As Double
Dim nDesvEst1           As Double
Dim nDesvEst2           As Double
Dim nDesvEst3           As Double
Dim nDesMedia           As Double
Dim nDesFinal           As Double

Public ClsValorMoneda   As Object
Sub CalcTasa()

Dim nCont     As Integer
Dim nPrNom    As Double
Dim nPrUfr    As Double
Dim nVolatil  As Double
Dim nTasUS    As Double
Dim nPreFu    As Double
Dim nPrSpot   As Double
Dim nUfProy   As Double
Dim nTasaEfec As Double

With Table1
   nPrSpot = 0
   
   For nCont = 1 To .Rows - 1
   
      If Val(.TextMatrix(nCont, 5)) = 1 Then ' Solo Libor
         nPrNom = BacDiv(CDbl(.TextMatrix(nCont, 3)) + CDbl(.TextMatrix(nCont, 4)), 2)
         nVolatil = GeneraVol(Val(.TextMatrix(nCont, 5)), Val(.TextMatrix(nCont, 6)), nPrNom)
         Call DesvEst(Val(.TextMatrix(nCont, 5)), Val(.TextMatrix(nCont, 6)), nPrNom, nVolatil)
         
         Table1.TextMatrix(nCont, 8) = nPrNom                    'Tasa Nominal
         Table1.TextMatrix(nCont, 11) = nVolatil                 'Punto Forward
         Table1.TextMatrix(nCont, 12) = nDesvEst                 'Desviacion Estandar
         Table1.TextMatrix(nCont, 13) = nDesFinal                'Tasa Var
         Table1.TextMatrix(nCont, 14) = nDesvEst1                'Desviacion 1
         Table1.TextMatrix(nCont, 15) = nDesvEst2                'Desviacion 2
         Table1.TextMatrix(nCont, 16) = nDesvEst3                'Desviacion 3
         Table1.TextMatrix(nCont, 17) = nDesvEst                 'Desviacion Total
         Table1.TextMatrix(nCont, 18) = nMedia1                  'Media 1
         Table1.TextMatrix(nCont, 19) = nMedia2                  'Media 2
         Table1.TextMatrix(nCont, 20) = nMedia3                  'Media 3
         Table1.TextMatrix(nCont, 21) = nDesMedia                'Desviación Media 1
         
      End If
      
      If Val(.TextMatrix(nCont, 5)) = 3 And Val(.TextMatrix(nCont, 6)) = 1 Then  'Precio Punta, 1 días
         Table1.TextMatrix(nCont, 8) = CDbl(TxtTasaNominal.Text)                                                        'Tasa Nominal
         Table1.TextMatrix(nCont, 9) = CDbl(TxtTasaUF.Text)                                                             'Tasa UF
         Table1.TextMatrix(nCont, 10) = BacDiv(CDbl(Table1.TextMatrix(nCont, 3)) + CDbl(Table1.TextMatrix(nCont, 4)), 2) 'Precio Nominal
         nPrSpot = BacDiv(CDbl(Table1.TextMatrix(nCont, 3)) + CDbl(Table1.TextMatrix(nCont, 4)), 2)
      End If
      
      If Val(.TextMatrix(nCont, 5)) = 3 And Val(.TextMatrix(nCont, 6)) > 1 Then 'Precio Punta, <> 1 días
         nTasaEfec = 0
         nTasUS = MtmTasa(1, gsbac_fecp, Val(.TextMatrix(nCont, 6)))
         
         Call ClsValorMoneda.ValorUFProyect(DateAdd("d", Val(.TextMatrix(nCont, 6)), gsbac_fecp))
         nUfProy = ClsValorMoneda.nUfProyec
         If nUfProy = 0 Then
            nUfProy = 1
         End If
         'gsBAC_ValmonUF
         'gsBAC_DolarObs
         
         If Val(.TextMatrix(nCont, 6)) < 43 Then
            nPreFu = BacDiv(CDbl(.TextMatrix(nCont, 3)) + CDbl(.TextMatrix(nCont, 4)), 2)
            nPrNom = (BacDiv(nPreFu, nPrSpot) * (1 + nTasUS * Val(.TextMatrix(nCont, 6)) / 36000) - 1) * 36000 / Val(.TextMatrix(nCont, 6))
            nPrUfr = (BacDiv(BacDiv(nPreFu, nPrSpot) * (1 + nTasUS * Val(.TextMatrix(nCont, 6)) / 36000), BacDiv(nUfProy, gsBAC_ValmonUF)) - 1) * 36000 / Val(.TextMatrix(nCont, 6))
         Else
            nTasaEfec = (((BacDiv(CDbl(.TextMatrix(nCont, 3)) + CDbl(.TextMatrix(nCont, 4)), 2) * Val(.TextMatrix(nCont, 6)) / 36000 + 1) * BacDiv(gsBAC_DolarObs, nPrSpot)) - 1) * BacDiv(36000, Val(.TextMatrix(nCont, 6)))
            nPrUfr = ((1 + nTasaEfec * Val(.TextMatrix(nCont, 6)) / 36000) * (1 + nTasUS * Val(.TextMatrix(nCont, 6)) / 36000) - 1) * BacDiv(36000, Val(.TextMatrix(nCont, 6)))
            nPrNom = ((1 + nPrUfr * Val(.TextMatrix(nCont, 6)) / 36000) * BacDiv(nUfProy, gsBAC_ValmonUF) - 1) * BacDiv(36000, Val(.TextMatrix(nCont, 6)))
         End If
         
         nVolatil = GeneraVol(Val(.TextMatrix(nCont, 5)), Val(.TextMatrix(nCont, 6)), nPrNom)
         Call DesvEst(Val(.TextMatrix(nCont, 5)), Val(.TextMatrix(nCont, 6)), nPrNom, nVolatil)
         
         Table1.TextMatrix(nCont, 8) = nPrNom                    'Tasa Nominal
         Table1.TextMatrix(nCont, 9) = nPrUfr                    'Tasa UF
         Table1.TextMatrix(nCont, 11) = nVolatil                 'Punto Forward
         Table1.TextMatrix(nCont, 12) = nDesvEst                 'Desviacion Estandar
         Table1.TextMatrix(nCont, 13) = nDesFinal                'Tasa Var
         Table1.TextMatrix(nCont, 14) = nDesvEst1                'Desviacion 1
         Table1.TextMatrix(nCont, 15) = nDesvEst2                'Desviacion 2
         Table1.TextMatrix(nCont, 16) = nDesvEst3                'Desviacion 3
         Table1.TextMatrix(nCont, 17) = nDesvEst                 'Desviacion Total
         Table1.TextMatrix(nCont, 18) = nMedia1                  'Media 1
         Table1.TextMatrix(nCont, 19) = nMedia2                  'Media 2
         Table1.TextMatrix(nCont, 20) = nMedia3                  'Media 3
         Table1.TextMatrix(nCont, 21) = nDesMedia                'Desviación Media 1
         Table1.TextMatrix(nCont, 22) = nTasaEfec                'Tasa Efectiva
         
      End If
      
   Next
   
End With

End Sub


Sub cmdImprimir()

  On Error GoTo Control:
  
  Call limpiar_cristal
  
  BACSwapParametros.BACParam.ReportFileName = gsRPT_Path & "Bacvalorestasasmtm.rpt"
  BACSwapParametros.BACParam.Destination = crptToWindow
  BACSwapParametros.BACParam.WindowTitle = TITSISTEMA & " - Informe de Valores Mark To Market"
  BACSwapParametros.BACParam.StoredProcParam(0) = Format$(gsbac_fecp, feFecha)
  BACSwapParametros.BACParam.Connect = SwConeccion
  BACSwapParametros.BACParam.WindowState = crptMaximized
  BACSwapParametros.BACParam.Action = 1

   Exit Sub

Control:

    MsgBox "Problemas al generar Listado. " & Err.Description & ", " & Err.Number, vbCritical, "BACPARAMETROS"
    Screen.MousePointer = 0


End Sub



Sub cargar_grilla()

On Error GoTo Errores

Dim Datos()

Table1.Redraw = False

If Not Bac_Sql_Execute("SP_LEERTASASMTM") Then
   
   MsgBox "Problemas al leer ", vbCritical, "MENSAJE"
   Exit Sub

End If

With Table1
   
   .Rows = 1
   
   Do While Bac_SQL_Fetch(Datos())
  
      'BacControlWindows 100
      
      .Rows = .Rows + 1
      .Row = .Rows - 1
      
      .Col = 1: .Text = Datos(1)                                                               'Moneda
      .Col = 2: .Text = Format(Datos(2), "#,##0") + IIf(Val(Datos(2)) = 1, " Dia", " Días")    'Periodo
      .Col = 3: .Text = Format(Datos(3), "#.###0")                                             'Tasa Compra
      .Col = 4: .Text = Format(Datos(4), "#.###0")                                             'Tasa Venta
      .Col = 5: .Text = Val(Datos(5))                                                          'Codigo Moneda
      .Col = 6: .Text = Val(Datos(2))                                                          'Plazo

   Loop
   
   '.Row = 1
   '.Col = 1
End With

If Table1.Rows < 2 Then
   Call CmdLimpiar
   MsgBox "No existen tasas para la fecha de proceso", vbCritical, "MENSAJE"
Else
   Frame3.Enabled = True
End If

Table1.Redraw = True
Exit Sub

Errores:

   MsgBox Err.Description

End Sub

Sub CmdAyuda()

Dim cTexto

cTexto = cTexto + "[F1]  => Ayuda" + vbCrLf
cTexto = cTexto + "[F2]  => Cambia Desviación Estandar" + vbCrLf
cTexto = cTexto + "[Ins] => Agrega Periodo" + vbCrLf
cTexto = cTexto + "[Del] => Elimina Periodo" + vbCrLf

MsgBox cTexto, , "Ayuda"
Table1.SetFocus

End Sub
Private Sub cmdGrabar()

Dim nCont  As Integer
Dim nCont2 As Integer

Screen.MousePointer = 11

Call CalcTasa

If Not BacBeginTransaction() Then
   Exit Sub
End If

Envia = Array()

With Table1
   Envia = Array()
   
   AddParam Envia, 0                          'Codigo
   AddParam Envia, 0                          'Plazo
   AddParam Envia, 0                          'Tasa Compra
   AddParam Envia, 0                          'Tasa Venta
   AddParam Envia, 0                          'lleva plazo
   AddParam Envia, 0                          'tasa nominal
   AddParam Envia, 0                          'tasa uf
   AddParam Envia, 0                          'precio nominal
   AddParam Envia, 0                          'punto forward
   AddParam Envia, 0                          'Desviacion Estandar
   AddParam Envia, 0                          'Tasa Var
   AddParam Envia, 0                          'Desviacion 1
   AddParam Envia, 0                          'Desviacion 2
   AddParam Envia, 0                          'Desviacion 3
   AddParam Envia, 0                          'Desviacion total
   AddParam Envia, 0                          'Media 1
   AddParam Envia, 0                          'Media 2
   AddParam Envia, 0                          'Media 3
   AddParam Envia, 0                          'Media total
   AddParam Envia, gsbac_fecp   'Fecha
   AddParam Envia, 0                          'Tasa Efectiva
   AddParam Envia, 1                          '0=Graba, 1=Elimina
   
   If Not Bac_Sql_Execute("SP_GRABARTASASMTM", Envia) Then
      
      If Not BacRollBackTransaction() Then
         Exit Sub
      End If
      
      MsgBox "Problemas al cargar monedas. ", vbCritical, TITSISTEMA
      Exit Sub
   End If
   
   For nCont = 1 To .Rows - 1
      Envia = Array()

      For nCont2 = 3 To 22
         If Len(.TextMatrix(nCont, nCont2)) > 0 Then
            .TextMatrix(nCont, nCont2) = .TextMatrix(nCont, nCont2)
         Else
            .TextMatrix(nCont, nCont2) = 0
         End If
      Next

      AddParam Envia, Round(Val(.TextMatrix(nCont, 5)), 0)                    'Codigo Moneda
      AddParam Envia, Round(Val(.TextMatrix(nCont, 6)), 0)                    'Plazo
      AddParam Envia, Round(CDbl(.TextMatrix(nCont, 3)), 4)                   'Tasa Compra
      AddParam Envia, Round(CDbl(.TextMatrix(nCont, 4)), 4)                   'Tasa Venta
      AddParam Envia, IIf(Val(.TextMatrix(nCont, 7)) > 0, 1, 0)               'Lleva Plazo
      AddParam Envia, Round(CDbl(.TextMatrix(nCont, 8)), 4)                   'Tasa Nominal
      AddParam Envia, Round(CDbl(.TextMatrix(nCont, 9)), 4)                   'Tasa UF
      AddParam Envia, Round(CDbl(.TextMatrix(nCont, 10)), 4)                  'Precio Nominal
      AddParam Envia, Round(CDbl(.TextMatrix(nCont, 11)), 4)                  'Punto Forward
      AddParam Envia, Round(CDbl(.TextMatrix(nCont, 12)), 4)                  'Desviacion Estandar
      AddParam Envia, Round(CDbl(.TextMatrix(nCont, 13)), 4)                  'Tasa Var
      AddParam Envia, Round(CDbl(.TextMatrix(nCont, 14)), 4)                  'Desviacion 1
      AddParam Envia, Round(CDbl(.TextMatrix(nCont, 15)), 4)                  'Desviacion 2
      AddParam Envia, Round(CDbl(.TextMatrix(nCont, 16)), 4)                  'Desviacion 3
      AddParam Envia, Round(CDbl(.TextMatrix(nCont, 17)), 4)                  'Desviacion Total
      AddParam Envia, Round(CDbl(.TextMatrix(nCont, 18)), 4)                  'Media 1
      AddParam Envia, Round(CDbl(.TextMatrix(nCont, 19)), 4)                  'Media 2
      AddParam Envia, Round(CDbl(.TextMatrix(nCont, 20)), 4)                  'Media 3
      AddParam Envia, Round(CDbl(.TextMatrix(nCont, 21)), 4)                  'Desviación Media 1
      AddParam Envia, gsbac_fecp
      AddParam Envia, Round(CDbl(.TextMatrix(nCont, 22)), 4)                  'Tasa Efectiva
      AddParam Envia, 0                                                       '0=Graba, 1=Elimina

      If Not Bac_Sql_Execute("SP_GRABARTASASMTM", Envia) Then
         
         If Not BacRollBackTransaction() Then
            Exit Sub
         End If
         
         MsgBox "Problemas al cargar monedas. ", vbCritical, TITSISTEMA
         Exit Sub
      End If

   Next
  
End With

 Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                          , gsbac_fecp _
                          , gsBac_IP _
                          , gsBAC_User _
                          , "PCA" _
                          , "OPC_720" _
                          , "01" _
                          , "Grabar" _
                          , "tasa_fwd" _
                          , " " _
                          , " ")
'Si no Hubo Error Compromete la Transacción
'------------------------------------------
If Not BacCommitTransaction() Then
   Exit Sub
End If

Call CmdLimpiar
Call cargar_grilla

Screen.MousePointer = 0

End Sub

Sub DesvEst(nCodigo As Integer, nPlazo As Integer, nTasaNominal As Double, nVolatilidad)

Dim nCont1        As Integer
Dim nCont2        As Integer
Dim cFecha        As String
Dim cFechaCien    As String
Dim cFechaInicial As String
Dim cFechaFinal   As String

cFecha = gsbac_fecp        'gsc_Parametros.ACfecante
cFechaCien = gsbac_fecp    'gsc_Parametros.ACfecante
cFechaInicial = gsbac_fecp 'gsc_Parametros.ACfecante
cFechaFinal = gsbac_fecp   'gsc_Parametros.ACfecante
nDesviacionEstandar = 0
nMedia = 0
nMedia1 = 0
nMedia2 = 0
nMedia3 = 0
nDesvEst = 0
nDesvEst1 = 0
nDesvEst2 = 0
nDesvEst3 = 0
nDesMedia = 0
nDesFinal = 0

'<--------- Calcula la media desde dia habil anterior hasta 100 dias habiles hacia atras --------->
For nCont2 = 1 To 99
   cFechaCien = BacPrevHabil(cFechaCien)
Next

nMedia = LeerMedia(cFechaCien, cFecha, nCodigo, nPlazo, 0)

'<--------- Calcula la media desde dia habil anterior hasta 40 dias habiles hacia atras --------->
For nCont2 = 1 To 39
   cFechaInicial = BacPrevHabil(cFechaInicial)
Next

nMedia3 = LeerMedia(cFechaInicial, cFechaFinal, nCodigo, nPlazo, nMedia)
nDesvEst3 = nDesviacionEstandar
nDesvEst3 = Sqr(BacDiv(nDesvEst3, 40))

cFechaInicial = BacPrevHabil(cFechaInicial)
cFechaFinal = cFechaInicial
   
'<--------- Calcula la media desde dia 41 habil anterior hasta 30 dias habiles hacia atras --------->
For nCont2 = 1 To 29
   cFechaInicial = BacPrevHabil(cFechaInicial)
Next

nMedia2 = LeerMedia(cFechaInicial, cFechaFinal, nCodigo, nPlazo, nMedia)
nDesvEst2 = nDesviacionEstandar
nDesvEst2 = Sqr(BacDiv(nDesvEst2, 30))

cFechaInicial = BacPrevHabil(cFechaInicial)
cFechaFinal = cFechaInicial
   
'<--------- Calcula la media desde dia 71 habil anterior hasta 30 dias habiles hacia atras --------->
For nCont2 = 1 To 29
   cFechaInicial = BacPrevHabil(cFechaInicial)
Next

nMedia1 = LeerMedia(cFechaInicial, cFechaFinal, nCodigo, nPlazo, nMedia)
nDesvEst1 = nDesviacionEstandar
nDesvEst1 = Sqr(BacDiv(nDesvEst1, 30))

nDesvEst = ((nDesvEst1 * 0.25) + (nDesvEst2 * 0.25) + (nDesvEst3 * 0.5))
nDesMedia = ((nMedia1 * 0.25) + (nMedia2 * 0.25) + (nMedia3 * 0.5))
nDesFinal = Round(nTasaNominal * (1 + (nDesMedia + CDbl(TxtDesviacionEstandar.Text) * nDesvEst)), 6)

End Sub
Function LeerMedia(cFechaInicial, cFechaFinal, nCodigo, nPlazo, nMedia As Double) As Double

Dim Datos()
   
Envia = Array()
AddParam Envia, cFechaInicial
AddParam Envia, cFechaFinal
AddParam Envia, nCodigo
AddParam Envia, nPlazo
AddParam Envia, nMedia

If Not Bac_Sql_Execute("SP_LEERMEDIA", Envia) Then
   MsgBox "Problemas al leer Media MTM", vbCritical, "MENSAJE"
   Exit Function
End If

Do While Bac_SQL_Fetch(Datos())
   LeerMedia = Datos(1)
   nDesviacionEstandar = Datos(2)
Loop

End Function

Sub DesviacionEstandar()

TxtDesviacionEstandar.Enabled = True
TxtDesviacionEstandar.SetFocus

End Sub

Sub Dibuja_Grilla()
 
   With Table1
   
      .Cols = 23
      
      .TextMatrix(0, 0) = ""
      .TextMatrix(0, 1) = "Moneda"
      .TextMatrix(0, 2) = "Periodo"
      .TextMatrix(0, 3) = "Tasa Compra"
      .TextMatrix(0, 4) = "Tasa Venta"
      .TextMatrix(0, 5) = "Codigo Moneda"
      .TextMatrix(0, 6) = "Plazo"
      .TextMatrix(0, 7) = ""               'lleva plazo
      .TextMatrix(0, 8) = ""               'tasa nominal
      .TextMatrix(0, 9) = ""               'tasa uf
      .TextMatrix(0, 10) = ""              'precio nominal
      .TextMatrix(0, 11) = ""              'punto forward
      .TextMatrix(0, 12) = ""              'desviacion estandar
      .TextMatrix(0, 13) = ""              'tasa var
      .TextMatrix(0, 14) = ""              'desviacion1
      .TextMatrix(0, 15) = ""              'desviacion2
      .TextMatrix(0, 16) = ""              'desviacion3
      .TextMatrix(0, 17) = ""              'desviacion total
      .TextMatrix(0, 18) = ""              'media1
      .TextMatrix(0, 19) = ""              'media2
      .TextMatrix(0, 20) = ""              'media3
      .TextMatrix(0, 21) = ""              'media total
      .TextMatrix(0, 22) = ""              'tasa efectiva
             
      .RowHeight(0) = 500
      
      .ColAlignment(0) = 0:   .ColWidth(0) = 0
      .ColAlignment(1) = 1:   .ColWidth(1) = 2500
      .ColAlignment(2) = 4:   .ColWidth(2) = 1500
      .ColAlignment(3) = 7:   .ColWidth(3) = 1500
      .ColAlignment(4) = 7:   .ColWidth(4) = 1500
      .ColAlignment(5) = 7:   .ColWidth(5) = 0
      .ColAlignment(6) = 7:   .ColWidth(6) = 0
      .ColAlignment(7) = 7:   .ColWidth(7) = 0
      .ColAlignment(8) = 7:   .ColWidth(8) = 0
      .ColAlignment(9) = 7:   .ColWidth(9) = 0
      .ColAlignment(10) = 7:   .ColWidth(10) = 0
      .ColAlignment(11) = 7:   .ColWidth(11) = 0
      .ColAlignment(12) = 7:   .ColWidth(12) = 0
      .ColAlignment(13) = 7:   .ColWidth(13) = 0
      .ColAlignment(14) = 7:   .ColWidth(14) = 0
      .ColAlignment(15) = 7:   .ColWidth(15) = 0
      .ColAlignment(16) = 7:   .ColWidth(16) = 0
      .ColAlignment(17) = 7:   .ColWidth(17) = 0
      .ColAlignment(18) = 7:   .ColWidth(18) = 0
      .ColAlignment(19) = 7:   .ColWidth(19) = 0
      .ColAlignment(20) = 7:   .ColWidth(20) = 0
      .ColAlignment(21) = 7:   .ColWidth(21) = 0
      .ColAlignment(22) = 7:   .ColWidth(22) = 0
     
   End With
   
End Sub

Private Sub CmdLimpiar()
   
   Table1.Clear
   Table1.Rows = 2
   
   Dibuja_Grilla
   
End Sub

Private Sub cmdSalir()
   Unload Me
End Sub


Function GeneraVol(nCodigo As Integer, nPlazo As Integer, nTasaHoy As Double) As Double

Dim Datos()
Dim nTasaCompra  As Double
Dim nTasaVenta   As Double
Dim nTasaNominal As Double
Dim nTasaAyer    As Double
Envia = Array()

AddParam Envia, nCodigo
AddParam Envia, nPlazo

If Not Bac_Sql_Execute("SP_LEERTASASAYER", Envia) Then
   
   MsgBox "Problemas al leer tasas anteriores", vbCritical, "MENSAJE"
   Exit Function

End If

Do While Bac_SQL_Fetch(Datos())
   nTasaCompra = Datos(1)
   nTasaVenta = Datos(2)
   nTasaNominal = Datos(3)
Loop

If nCodigo = 3 Then
   nTasaAyer = nTasaNominal
Else
   nTasaAyer = BacDiv(nTasaCompra + nTasaVenta, 2)
End If

GeneraVol = BacDiv(nTasaHoy, nTasaAyer) - 1

End Function

Sub LeerDesviacionEstandar()

Dim Datos()

If Not Bac_Sql_Execute("SP_LEERDESVIACIONESTANDAR") Then
   
   MsgBox "Problemas al leer desviacion estandar", vbCritical, "MENSAJE"
   Exit Sub

End If

Do While Bac_SQL_Fetch(Datos())
   TxtDesviacionEstandar.Text = Datos(1)                                                               'Moneda
Loop
   
End Sub

Sub LeerTasaInterbancaria()

Dim Datos()

If Not Bac_Sql_Execute("SP_LEERTASAINTERBANCARIA") Then
   
   MsgBox "Problemas al leer tasas interbancarias", vbCritical, "MENSAJE"
   Exit Sub

End If

Do While Bac_SQL_Fetch(Datos())
   TxtTasaNominal.Text = Datos(1)
   TxtTasaUF.Text = Datos(2)
Loop

End Sub

Sub Limpiar()

Table1.Clear
Table1.Rows = 2

'Call CargaGrilla

End Sub

Function MtmTasa(nCodigo As Integer, ByVal dFecPro As String, nPlazo As Integer) As Double

Dim Datos()
   
Envia = Array()
AddParam Envia, nCodigo
AddParam Envia, dFecPro
AddParam Envia, nPlazo

If Not Bac_Sql_Execute("SP_MTMTASA", Envia) Then
   MsgBox "Problemas al leer tasas MTM", vbCritical, "MENSAJE"
   Exit Function
End If

Do While Bac_SQL_Fetch(Datos())
   MtmTasa = Datos(1)
Loop

End Function

Sub TasasDolarInterbancario()

TxtTasaNominal.Enabled = True
TxtTasaUF.Enabled = True
TxtTasaNominal.SetFocus

End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)

With Table1

   If KeyCode = vbKeyInsert Then
     
     If .TextMatrix(.Row, 1) <> "" And _
        .TextMatrix(.Row, 2) <> "" Then
        
        .Rows = .Rows + 1
        .TextMatrix(.Rows - 1, 1) = .TextMatrix(.Row, 1)
        .TextMatrix(.Rows - 1, 3) = Format(0, "#.###0")
        .TextMatrix(.Rows - 1, 4) = Format(0, "#.###0")
        .TextMatrix(.Rows - 1, 5) = .TextMatrix(.Row, 5)
        .Col = 2
        .Row = .Rows - 1
        lIngresa = True
        
        Call Table1_KeyPress(vbKeyReturn)
        '.SetFocus
     End If
   
   ElseIf KeyCode = vbKeyBack Or KeyCode = vbKeyDelete Then
   
      If MsgBox("Esta Seguro que desea borrar este registro", vbYesNo, "MENSAJE") = vbYes Then
         .RemoveItem (.Row)

      End If
      
   ElseIf KeyCode = vbKeyF1 Then
      Call CmdAyuda
      
   ElseIf KeyCode = vbKeyF2 Then
      Call DesviacionEstandar
      
   ElseIf KeyCode = vbKeyF5 Then
      Call TasasDolarInterbancario
      
   End If
     
End With

End Sub

Private Sub Form_Load()

Me.Top = 0
Me.Left = 0
Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                          , gsbac_fecp _
                          , gsBac_IP _
                          , gsBAC_User _
                          , "PCA" _
                          , "OPC_720" _
                          , "07" _
                          , "INGRESO A OPCION MENU" _
                          , " " _
                          , " " _
                          , " ")

lIngresa = False
lDesviacionEstandar = False
lTasaInterbancaria = False

'Me.Icon = BACForward.Icon

Set ClsValorMoneda = New ClsValorMoneda

Call LeerDesviacionEstandar
Call LeerTasaInterbancaria
Call Dibuja_Grilla
Call cargar_grilla
 
End Sub

Private Sub Table1_GotFocus()

If lDesviacionEstandar Then
   Envia = Array()
   AddParam Envia, Val(TxtDesviacionEstandar.Text)
   
   If Not Bac_Sql_Execute("SP_GRABARDESVIACIONESTANDAR", Envia) Then
      MsgBox "Problemas al grabar desviacion estandar", vbCritical, "MENSAJE"
      Table1.SetFocus
   End If
         
   TxtDesviacionEstandar.Enabled = False
ElseIf lTasaInterbancaria Then
   Envia = Array()
   AddParam Envia, Val(TxtTasaNominal.Text)
   AddParam Envia, Val(TxtTasaUF.Text)
   
   If Not Bac_Sql_Execute("SP_GRABARTASAINTERBANCARIA", Envia) Then
      MsgBox "Problemas al grabar tasas interbancarias", vbCritical, "MENSAJE"
      Table1.SetFocus
   End If

   TxtTasaNominal.Enabled = False
   TxtTasaUF.Enabled = False
End If

lDesviacionEstandar = False
lTasaInterbancaria = False

End Sub

Private Sub Table1_KeyPress(KeyAscii As Integer)

If Not IsNumeric(Chr(KeyAscii)) And KeyAscii = 13 And KeyAscii = 8 Then
   KeyAscii = 0
End If

If Table1.Col = 2 Or _
   Table1.Col = 3 Or _
   Table1.Col = 4 And _
   IsNumeric(Chr(KeyAscii)) Or Chr(KeyAscii) = "-" Then

   Txt_Ingreso.Text = ""
   
   PROC_POSICIONA_TEXTO Table1, Txt_Ingreso
   
   Txt_Ingreso.Text = Chr(KeyAscii)
   Txt_Ingreso.Visible = True
   Txt_Ingreso.SetFocus
   
   SendKeys "{END}"
   
End If

End Sub

Private Sub Table1_MouseDown(Button As Integer, Shift As Integer, x As Single, Y As Single)

If Me.Txt_Ingreso.Visible = True Then
   Call CmdLimpiar
   Call cargar_grilla
End If

Me.Txt_Ingreso.Visible = False
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
   
      Case 1
         Call cmdGrabar
      
      Case 2
         Call DesviacionEstandar
         
      Case 3
         Call TasasDolarInterbancario

      Case 4
         Call cmdImprimir
         
      Case 5
       Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                          , gsbac_fecp _
                          , gsBac_IP _
                          , gsBAC_User _
                          , "PCA" _
                          , "OPC_720" _
                          , "08" _
                          , "SALIR DE OPCION MENU" _
                          , " " _
                          , " " _
                          , " ")
         Unload Me

      Case 6
         Call CmdAyuda
         
      End Select
End Sub

Private Sub Txt_Ingreso_KeyPress(KeyAscii As Integer)

Dim nCodigo As Integer
Dim nPlazo  As Long
Dim nCont   As Integer
Dim lExiste As Boolean

lExiste = False

If KeyAscii = 27 Then
   Txt_Ingreso.Visible = False
   Table1.SetFocus
End If

KeyAscii = BacPunto(Txt_Ingreso, KeyAscii, 6, 4)

If KeyAscii = 13 Then

   If Trim(Txt_Ingreso.Text) = "" Then Exit Sub
   
   If Table1.Col = 2 Then
      Table1.Text = Format(Val(Txt_Ingreso.Text), "#,##0") + IIf(Val(Txt_Ingreso.Text) = 1, " Dia", " Días")
   
      nCodigo = Val(Table1.TextMatrix(Table1.Row, 5))
      nPlazo = Val(Txt_Ingreso.Text)

      If lIngresa Then
         Table1.TextMatrix(Table1.Rows - 1, 6) = nPlazo
         
         For nCont = 1 To Table1.Rows - 2
            If nCodigo = Val(Table1.TextMatrix(nCont, 5)) And nPlazo = Val(Table1.TextMatrix(nCont, 6)) Then
               MsgBox "Plazo ya existente"
               Call CmdLimpiar
               Call cargar_grilla
               Exit For
               
            End If
         Next
         
         lIngresa = False
      Else
         
         For nCont = 1 To Table1.Rows - 1
            If nCodigo = Val(Table1.TextMatrix(nCont, 5)) And nPlazo = Val(Table1.TextMatrix(nCont, 6)) Then
               MsgBox "Plazo ya existente"
               lExiste = True
               Call CmdLimpiar
               Call cargar_grilla
               Exit For
               
            End If
         Next
                
         If Not lExiste Then
            Table1.TextMatrix(Table1.Row, 6) = nPlazo
         End If
         
      End If

   Else
      Table1.Text = Format(Val(Txt_Ingreso.Text), "#.###0")
   End If
   
   Txt_Ingreso.Visible = False
   Table1.SetFocus
End If

If KeyAscii = 0 And Table1.Col = 2 Then
   Call CmdLimpiar
   Call cargar_grilla
End If

End Sub



Private Sub TxtDesviacionEstandar_GotFocus()
lDesviacionEstandar = True
End Sub

Private Sub TxtDesviacionEstandar_KeyPress(KeyAscii As Integer)

If KeyAscii% = vbKeyReturn Then
   KeyAscii% = 0
   SendKeys$ "{TAB}"

Else
   Call bacKeyPress(KeyAscii)

End If

End Sub

Private Sub TxtTasaNominal_GotFocus()
lTasaInterbancaria = True
End Sub

Private Sub TxtTasaNominal_KeyPress(KeyAscii As Integer)

If KeyAscii% = vbKeyReturn Then
   KeyAscii% = 0
   SendKeys$ "{TAB}"

Else
   Call bacKeyPress(KeyAscii)

End If

End Sub

Private Sub TxtTasaUF_GotFocus()
lTasaInterbancaria = True
End Sub

Private Sub TxtTasaUF_KeyPress(KeyAscii As Integer)

If KeyAscii% = vbKeyReturn Then
   KeyAscii% = 0
   SendKeys$ "{TAB}"

Else
   Call bacKeyPress(KeyAscii)

End If

End Sub


