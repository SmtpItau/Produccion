VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BACCONTROLES.OCX"
Begin VB.Form BacMntIp 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantención Proyección de U.F."
   ClientHeight    =   5175
   ClientLeft      =   1770
   ClientTop       =   1155
   ClientWidth     =   4800
   Icon            =   "bacmntip.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5175
   ScaleWidth      =   4800
   Begin MSComctlLib.ImageList ImageList2 
      Left            =   555
      Top             =   2880
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
            Picture         =   "bacmntip.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bacmntip.frx":075C
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bacmntip.frx":0BAE
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bacmntip.frx":0EC8
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   9
      Top             =   0
      Width           =   4800
      _ExtentX        =   8467
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      Appearance      =   1
      ImageList       =   "ImageList2"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Buscar"
            Description     =   "Buscar"
            Object.ToolTipText     =   "Buscar Datos"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Grabar"
            Description     =   "Grabar"
            Object.ToolTipText     =   "Grabar Datos"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Limpiar"
            Description     =   "Limpiar"
            Object.ToolTipText     =   "Limpiar Datos"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Description     =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   4
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin Threed.SSFrame Frame 
      Height          =   765
      Index           =   0
      Left            =   0
      TabIndex        =   1
      Top             =   510
      Width           =   4725
      _Version        =   65536
      _ExtentX        =   8334
      _ExtentY        =   1349
      _StockProps     =   14
      Caption         =   "Proyeccion de UF"
      ForeColor       =   8388608
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Font3D          =   3
      Begin BACControles.TXTNumero itbAno 
         Height          =   324
         Left            =   864
         TabIndex        =   7
         Top             =   324
         Width           =   636
         _ExtentX        =   1111
         _ExtentY        =   582
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
         Text            =   "0"
         Text            =   "0"
         Max             =   "2099"
      End
      Begin VB.Label Label 
         Caption         =   "Año"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   315
         Index           =   93
         Left            =   150
         TabIndex        =   0
         Top             =   375
         Width           =   675
      End
   End
   Begin Threed.SSFrame Frame 
      Height          =   3930
      Index           =   1
      Left            =   0
      TabIndex        =   2
      Top             =   1230
      Width           =   4725
      _Version        =   65536
      _ExtentX        =   8334
      _ExtentY        =   6932
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
      Font3D          =   3
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
         Left            =   1620
         TabIndex        =   8
         Top             =   1710
         Visible         =   0   'False
         Width           =   1185
      End
      Begin MSFlexGridLib.MSFlexGrid Table1 
         Height          =   3720
         Left            =   60
         TabIndex        =   6
         Top             =   135
         Width           =   4605
         _ExtentX        =   8123
         _ExtentY        =   6562
         _Version        =   393216
         Cols            =   6
         FixedCols       =   0
         BackColor       =   -2147483644
         ForeColor       =   12582912
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
   Begin Threed.SSFrame Frame 
      Height          =   5640
      Index           =   3
      Left            =   6240
      TabIndex        =   3
      Top             =   105
      Width           =   4200
      _Version        =   65536
      _ExtentX        =   7408
      _ExtentY        =   9948
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
      ShadowStyle     =   1
      Begin VB.Label Label 
         BackColor       =   &H00800000&
         Caption         =   "Label(0)"
         ForeColor       =   &H00FFFFFF&
         Height          =   405
         Index           =   0
         Left            =   225
         TabIndex        =   5
         Top             =   4560
         Width           =   855
      End
      Begin VB.Label Label 
         BackColor       =   &H00800000&
         Caption         =   "Label(1)"
         ForeColor       =   &H00FFFFFF&
         Height          =   405
         Index           =   1
         Left            =   225
         TabIndex        =   4
         Top             =   4995
         Width           =   855
      End
   End
End
Attribute VB_Name = "BacMntIp"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private objMoneda      As Object
Public ClsValorMoneda  As Object
Dim ArregloDias(31, 3) As String

Sub Dibuja_Grilla()

Table1.TextMatrix(0, 0) = ""
Table1.TextMatrix(0, 1) = "Mes"
Table1.TextMatrix(0, 2) = "Dias"
Table1.TextMatrix(0, 3) = "IPC"
Table1.TextMatrix(0, 4) = "Calc."
Table1.TextMatrix(0, 5) = "Valor UF"

Table1.RowHeight(0) = 500

Table1.ColAlignment(0) = 1
Table1.ColAlignment(1) = 1
Table1.ColAlignment(2) = 7
Table1.ColAlignment(3) = 7
Table1.ColAlignment(4) = 7
Table1.ColAlignment(5) = 7

Table1.ColWidth(0) = 0
Table1.ColWidth(1) = 1500
Table1.ColWidth(2) = 500
Table1.ColWidth(3) = 500
Table1.ColWidth(4) = 500
Table1.ColWidth(5) = 1500

End Sub


Private Sub FechaDefault()

   Dim f As Long

   itbAno.Tag = "AÑO"

   'Mostramos el año por default del sistema operativo
   '--------------------------------------------------
   itbAno.Text = Year(gsbac_fecp)
         
   itbAno.Tag = ""

End Sub

Function GeneraDias(nMes As Integer, Ano As Integer) As Integer
   
   
   Dim nMaxDia       As Integer
  
      
   Select Case nMes
   Case 1:  nMaxDia = 31   'Enero
   Case 2:  nMaxDia = 28   'Febrero
   Case 3:  nMaxDia = 31   'Marzo
   Case 4:  nMaxDia = 30   'Abril
   Case 5:  nMaxDia = 31   'Mayo
   Case 6:  nMaxDia = 30   'Junio
   Case 7:  nMaxDia = 31   'Julio
   Case 8:  nMaxDia = 31   'Agosto
   Case 9:  nMaxDia = 30   'Septiembre
   Case 10: nMaxDia = 31   'Octubre
   Case 11: nMaxDia = 30   'Noviembre
   Case 12: nMaxDia = 31   'Diciembre
   
   
   End Select

   If (Ano / 4) = Int(Ano / 4) And nMes = 2 Then nMaxDia = 29
   GeneraDias = nMaxDia

End Function

Function GeneraMes(nMes As Integer) As String
   
   Dim nMeses       As String
         
   Select Case nMes
   Case 1:  nMeses = "Enero"
   Case 2:  nMeses = "Febrero"
   Case 3:  nMeses = "Marzo"
   Case 4:  nMeses = "Abril"
   Case 5:  nMeses = "Mayo"
   Case 6:  nMeses = "Junio"
   Case 7:  nMeses = "Julio"
   Case 8:  nMeses = "Agosto"
   Case 9:  nMeses = "Septiembre"
   Case 10: nMeses = "Octubre"
   Case 11: nMeses = "Noviembre"
   Case 12: nMeses = "Diciembre"
   End Select

  GeneraMes = nMeses
  
End Function

Function Habilitacontroles(Valor As Boolean)

   itbAno.Enabled = Not Valor
   Toolbar1.Buttons(1).Enabled = Not Valor
   Toolbar1.Buttons(2).Enabled = Valor
   Toolbar1.Buttons(3).Enabled = Valor
   Table1.Enabled = Valor

End Function
Function LeerIPC(Ano As Integer, oControl As Object)
   
   Dim Dias          As Integer
   Dim valorUf       As Double
   Dim Fecha         As String
   Dim Datos()

   ' Esto Para Traer la UF con la Que debe empezar el Año si es que no se ha Generado
   Fecha = Format("09/01" & Str(Ano), "dd/mm/yyyy")
   LeerIPC = False
   
   If Not Bac_Sql_Execute("SP_LEEVALORIPC", Array(CDbl(Ano))) Then
      MsgBox "Problemas al Leer Tabla de IPC", vbInformation, "MENSAJE"
      Exit Function

   End If

   Dias = 9
   With oControl
      
      .Rows = 1

      Do While Bac_SQL_Fetch(Datos())

         .Rows = .Rows + 1
         
         .TextMatrix(.Rows - 1, 0) = Datos(1)
         .TextMatrix(.Rows - 1, 1) = GeneraMes(Val(DatePart("M", Datos(1))))
         .TextMatrix(.Rows - 1, 2) = Dias
         .TextMatrix(.Rows - 1, 3) = Format(Datos(2), "#,##0.##")
         .TextMatrix(.Rows - 1, 4) = GeneraDias(Val(DatePart("M", Datos(1))), Ano)
         .TextMatrix(.Rows - 1, 5) = BacFormatoMonto(Datos(3), 2)
        
      Loop

   End With
   
   LeerIPC = True
   
   oControl.Row = 1
   oControl.Col = 5
   
   If CDbl(oControl.TextMatrix(oControl.Row, 5)) = 0 Then
      Call ClsValorMoneda.ValorUFProyect(Fecha)
      oControl.TextMatrix(oControl.Row, 5) = BacFormatoMonto(ClsValorMoneda.nUfProyec, 2)
      Txt_Ingreso.Text = CDbl(oControl.TextMatrix(oControl.Row, 5))
      Call Txt_Ingreso_KeyPress(13)
   End If

End Function

Sub Limpiar()

   Table1.Clear
   Table1.Rows = 2
   
   Dibuja_Grilla

End Sub
Private Sub cmdBuscar()
  Dim Ann As Integer
  
  itbAno_KeyPress 13
  
  If itbAno.Text <= 0 Then Exit Sub
  
  Ann = itbAno.Text
  Call LeerIPC(Ann, Table1)
  Call Habilitacontroles(True)
  Table1.SetFocus
      
   
End Sub

Private Sub cmdGrabar()
   Dim sql         As String
   Dim nLin        As Integer
   Dim nValorIPC   As Double

   With Table1
      For nLin = 1 To .Rows - 1
                           
         Envia = Array( _
                        .TextMatrix(nLin, 0), _
                        CDbl(.TextMatrix(nLin, 5)), _
                        CDbl(.TextMatrix(nLin, 3)) _
                      )
       
         If Not Bac_Sql_Execute("SP_GRABAVALORIPC", Envia) Then
            
            MsgBox "Problemas al Grabar Valores de IPC", vbExclamation, "MENSAJE"
            Exit Sub
         
         End If
        
      Next nLin

   End With

    Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                          , gsbac_fecp _
                          , gsBac_IP _
                          , gsBAC_User _
                          , "PCA" _
                          , "OPC_792" _
                          , "01" _
                          , "GRABACION IPC PROYECTADOS" _
                          , " " _
                          , " " _
                          , " ")

   MsgBox "Valores de IPC Grabados Correctamente", vbOKOnly, TITSISTEMA
End Sub

Private Sub CmdLimpiar()

   Call Limpiar
   Call Habilitacontroles(False)

End Sub



Private Sub Form_Load()

   Dim iCol       As Integer
   Set objMoneda = New clsMoneda
   Set ClsValorMoneda = New ClsValorMoneda
   
   Me.Icon = BACSwapParametros.Icon
   Dibuja_Grilla
 
   Call FechaDefault
   Toolbar1.Buttons(2).Enabled = False 'grabar
   Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                          , gsbac_fecp _
                          , gsBac_IP _
                          , gsBAC_User _
                          , "PCA" _
                          , "OPC_792" _
                          , "07" _
                          , "INGRESO A OPCION MENU" _
                          , " " _
                          , " " _
                          , " ")


End Sub

Private Sub Form_Unload(Cancel As Integer)
       Set ClsValorMoneda = Nothing
       Set objMoneda = Nothing
       
      Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                          , gsbac_fecp _
                          , gsBac_IP _
                          , gsBAC_User _
                          , "PCA" _
                          , "OPC_792" _
                          , "08" _
                          , "SALIR DE OPCION MENU" _
                          , " " _
                          , " " _
                          , " ")
End Sub

Private Sub itbAno_KeyPress(KeyAscii As Integer)

   If KeyAscii = 13 Then
      
      If itbAno.Text < 1905 Then
         itbAno.Text = 0
         itbAno.SetFocus
      End If
   
   End If

End Sub

Private Sub itbAno_LostFocus()

   itbAno_KeyPress 13

End Sub

Private Sub Table1_Click()
   Call PintaCelda(Table1)
End Sub

Private Sub Table1_GotFocus()
   Call PintaCelda(Table1)
End Sub

Private Sub Table1_LeaveCell()
   Call CellPintaCelda(Table1)
End Sub

Private Sub Table1_SelChange()
   Call PintaCelda(Table1)
End Sub

Private Sub Table1_KeyPress(KeyAscii As Integer)

Dim mes1       As Integer
Dim ano1       As Integer
Dim mes2       As Integer
Dim ano2       As Integer
Dim nFecha     As String
Dim I          As Integer
Dim MesEscrito As String
Dim nCol       As Integer

If ((KeyAscii > 47 And KeyAscii < 58) Or KeyAscii = 8 Or KeyAscii = 46 Or KeyAscii = 44 Or KeyAscii = 45) Then
   
   If Table1.Col = 5 And KeyAscii = 45 Then
      Exit Sub
   End If
   
   If Table1.Col = 3 Or Table1.Col = 5 Then
      nCol = Table1.Col
      mes1 = Val(DatePart("M", gsbac_fecp))
      ano1 = Val(DatePart("YYYY", gsbac_fecp))
      mes2 = Table1.Row
      Table1.Col = 0
      nFecha = Table1.Text
      mes2 = Val(mes2)
      ano2 = Val(DatePart("YYYY", nFecha))

      If mes2 <= mes1 And ano2 < ano1 Then
         KeyAscii = 0
         Exit Sub
      Else
         Txt_Ingreso.Text = ""
         Table1.Col = nCol
         PROC_POSICIONA_TEXTO Table1, Txt_Ingreso
         Txt_Ingreso.Text = Chr(KeyAscii)
         Txt_Ingreso.Visible = True
         Txt_Ingreso.SetFocus
         Txt_Ingreso.SelStart = 1 'SendKeys "{END}"
      End If
      
   End If
   
Else
   KeyAscii = 0
End If
Call PintaCelda(Table1)
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Index
    Case 1          '"Buscar"
        Call cmdBuscar
    Case 2          '"Grabar"
        Call cmdGrabar
    Case 3          '"Limpiar"
        Call CmdLimpiar
    Case 4          '"Salir"
        Unload Me
    End Select

End Sub

Private Sub Txt_Ingreso_KeyPress(KeyAscii As Integer)

Dim nValIPC       As Double
Dim nValUFDia     As Double
Dim nValUF        As Double
Dim I             As Integer
Dim J             As Integer
Dim ok            As Boolean
Dim nPosActual    As Integer

If Not (IsNumeric(Chr(KeyAscii)) Or KeyAscii = 45) And KeyAscii <> 8 And KeyAscii <> 13 And Chr(KeyAscii) <> "," And Chr(KeyAscii) <> "." And KeyAscii <> 27 Then
   KeyAscii = 0
End If

If KeyAscii = 27 Then
  Txt_Ingreso.Text = ""
  Txt_Ingreso.Visible = False
  Table1.SetFocus
  Exit Sub
End If

Select Case Table1.Col
Case 3
   KeyAscii = BacPunto(Txt_Ingreso, KeyAscii, 2, 2)
Case 5
   KeyAscii = BacPunto(Txt_Ingreso, KeyAscii, 5, 2)
End Select

If KeyAscii = 13 Then

   If Trim(Txt_Ingreso.Text) = "" Then Exit Sub
    
   Select Case Table1.Col
   Case 3
      Table1.Text = Format(Val(Txt_Ingreso.Text), "#,##0.##")
   Case 5
      Table1.Text = BacFormatoMonto(Val(Txt_Ingreso.Text), 2)
   End Select
  
   If Table1.Col = 3 Or Table1.Col = 5 Then

      nValIPC = Table1.TextMatrix(Table1.Row, 3)
      nValUF = Table1.TextMatrix(Table1.Row, 5)

      ok = False
      I = Table1.Row
      nPosActual = I

      For J = I + 1 To 12

         Table1.Row = J

         If ok = False Then
            nValUFDia = (BacDiv(nValIPC, 100) + 1) * nValUF
            ok = True
         Else
            nValUFDia = (BacDiv(nValIPC, 100) + 1) * nValUFDia
         End If

         Table1.TextMatrix(Table1.Row, 5) = BacFormatoMonto(nValUFDia, 2)
         nValIPC = Table1.TextMatrix(Table1.Row, 3)
         I = I + 1
      Next J

   End If

'   table1.SetFocus
   Table1.Row = nPosActual
   Txt_Ingreso.Text = ""
   Txt_Ingreso.Visible = False
   
End If
  
End Sub

