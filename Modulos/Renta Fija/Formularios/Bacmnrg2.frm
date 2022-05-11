VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form BacMntRG2 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mark to Market"
   ClientHeight    =   3615
   ClientLeft      =   4230
   ClientTop       =   2760
   ClientWidth     =   2550
   ForeColor       =   &H00C0C0C0&
   Icon            =   "Bacmnrg2.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   Moveable        =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   3615
   ScaleWidth      =   2550
   Begin MSFlexGridLib.MSFlexGrid Grilla 
      Height          =   2565
      Left            =   30
      TabIndex        =   4
      Top             =   510
      Width           =   2475
      _ExtentX        =   4366
      _ExtentY        =   4524
      _Version        =   393216
      FixedCols       =   0
      BackColorFixed  =   8421376
      BackColorSel    =   12632256
      BackColorBkg    =   12632256
      FocusRect       =   0
      GridLines       =   2
   End
   Begin Threed.SSCommand cmdAgregarFila 
      Height          =   450
      Left            =   15
      TabIndex        =   3
      Top             =   3105
      Width           =   1200
      _Version        =   65536
      _ExtentX        =   2117
      _ExtentY        =   794
      _StockProps     =   78
      Caption         =   "&Agregar Fila"
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
      AutoSize        =   2
   End
   Begin Threed.SSCommand cmdEliminarFila 
      Height          =   450
      Left            =   1260
      TabIndex        =   2
      Top             =   3105
      Width           =   1200
      _Version        =   65536
      _ExtentX        =   2117
      _ExtentY        =   794
      _StockProps     =   78
      Caption         =   "&Eliminar Fila"
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
      AutoSize        =   2
   End
   Begin Threed.SSCommand cmdEliminar 
      Height          =   420
      Left            =   4485
      TabIndex        =   1
      Top             =   1350
      Width           =   1200
      _Version        =   65536
      _ExtentX        =   2117
      _ExtentY        =   741
      _StockProps     =   78
      Caption         =   "&Eliminar"
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
      AutoSize        =   2
   End
   Begin Threed.SSCommand cmdGrabar 
      Height          =   420
      Left            =   4470
      TabIndex        =   0
      Top             =   930
      Width           =   1200
      _Version        =   65536
      _ExtentX        =   2117
      _ExtentY        =   741
      _StockProps     =   78
      Caption         =   "&Grabar"
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
      AutoSize        =   2
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   3585
      Top             =   1470
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   25
      ImageHeight     =   25
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   4
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmnrg2.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmnrg2.frx":075C
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmnrg2.frx":0BAE
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmnrg2.frx":0EC8
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Height          =   495
      Left            =   45
      TabIndex        =   5
      Top             =   0
      Width           =   2445
      _ExtentX        =   4313
      _ExtentY        =   873
      ButtonWidth     =   847
      ButtonHeight    =   820
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
            Key             =   "cmdGrabar"
            Description     =   "Grabar"
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdEliminar"
            Description     =   "Eliminar"
            Object.ToolTipText     =   "Eliminar"
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
End
Attribute VB_Name = "BacMntRG2"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Dim sPunto          As String
Dim Frm_Valor       As Integer


Private Sub LlenaGrillaMM()
Dim Datos()

    Screen.MousePointer = 11
    
'    Sql = "SP_RGLEER "
    
    If Not Bac_Sql_Execute("SP_RGLEER") Then
       Screen.MousePointer = 0
       MsgBox "No Se Puede Leer Tabla de MDRG", vbInformation, Me.Caption
       Exit Sub
    End If

    Grilla.Rows = 1
    
    Do While Bac_SQL_Fetch(Datos())
       Grilla.Rows = Grilla.Rows + 1
       Grilla.Row = Grilla.Rows - 1
       If sPunto = "," Then
          Grilla.Col = 0: Grilla.Text = BacStrTran(CStr(Datos(1)), ".", ",")
          Grilla.Col = 1: Grilla.Text = BacStrTran(CStr(Datos(2)), ".", ",")
       Else
          Grilla.Col = 0: Grilla.Text = BacStrTran(CStr(Datos(1)), ",", ".")
          Grilla.Col = 1: Grilla.Text = BacStrTran(CStr(Datos(2)), ",", ".")
       End If
    Loop
    
    Screen.MousePointer = 0
    
    'GrdMM.Rows = 0
    
    'GrdMM.Rows = Grilla.Rows - 1
    
    Grilla.Row = 0
    Grilla.Col = 0: Grilla.Text = "Rango Desde"
    Grilla.Col = 1: Grilla.Text = "Rango Hasta"
    
End Sub


Private Sub cmdAgregarFila_Click()
Dim Max       As Long
Dim F         As Long
Dim Valor1    As Double
Dim Valor2    As Double
Dim ValorFila As Double

With Grilla
    If Frm_Valor% = True Then
        'Se cambio el nombre de la grilla grdMM por Grilla
        'Ademas se cambio la terminacion
        'EJ: RowIndex por Row
        '====================================================
        Max = .Rows
        If Max > 0 Then
            ' Validamos que hayan ingresados valores
            '-----------------------------------------------
            For F = 1 To Max - 1
                .Row = F
                .Col = 0: Valor1 = IIf(Trim$(.Text) = "", 0, .Text)
                .Col = 1: Valor2 = IIf(Trim$(.Text) = "", 0, .Text)
                    If .Row = 1 Then
                        If Valor2 = 0 Then
                            MsgBox "Valor(es) en cero en la fila " & Str(F), vbInformation, Me.Caption
                            .Row = F
                            .Col = 1: .SetFocus
                            Exit Sub
                        End If
                    Else
                        If Valor1 = 0 Or Valor2 = 0 Then
                            MsgBox "Valor(es) en cero en la fila " & Str(F), vbInformation, Me.Caption
                            .Row = F
                            .Col = 1: .SetFocus
                            Exit Sub
                        End If
                    End If
            Next F
        
                'Validamos que los valores sean menores a 10
                '------------------------------------------------
            For F = 1 To Max - 1
                .Row = F
                .Col = 0: Valor1 = .Text
                .Col = 1: Valor2 = .Text
                If Valor1 > Valor2 Then
                    MsgBox "Valor Inicio es Mayor al Valor Final en la Fila" & Str(F), vbInformation, Me.Caption
                    Exit Sub
                End If
            Next F
            
        End If
    
         .Col = 1: ValorFila = IIf(.Text = "", 0, .Text)
         .Rows = .Rows + 1
         .Row = .Rows - 1
         .Col = 0: .Text = ValorFila + 1
         .Col = 1: .Text = 0
         .Row = .Rows - 1
          .SetFocus
         .Col = 1
        
'            GrdMM.Rows = 0
'            GrdMM.Rows = Grilla.Rows - 1
'            GrdMM.RowIndex = GrdMM.Rows
'            GrdMM.ColumnIndex = 2
'            GrdMM.SetFocus
        
    End If
End With

End Sub

Private Sub cmdEliminarFila_Click()

   Screen.MousePointer = 11
   
   With Grilla
   If .RowSel = 0 Then
      If .Rows <> 1 Then
         MsgBox "No Ha Seleccionado Elemento", vbInformation, Me.Caption
      Else
         MsgBox "No Existen Elementos en la grilla", vbInformation, Me.Caption
      End If
      Screen.MousePointer = 0
      Exit Sub
   End If
      If Frm_Valor% = True Then
         If .Rows > 2 Then
            .RemoveItem .Row
         ElseIf .Rows = 2 Then
            .Rows = 1
            Screen.MousePointer = 0
            Exit Sub
         Else
      End If
      End If
   End With

   Grilla.Row = 0
   Screen.MousePointer = 0

End Sub

Private Sub Form_Load()

        Frm_Valor% = True
        
        If InStr(1, CStr(Format(100#, "##0.000")), ".", 1) > 0 Then
           sPunto = "."
        Else
           sPunto = ","
        End If

        Screen.MousePointer = 11
        Call LlenaGrillaMM
        
        'grilla.Rows = grilla.Rows + 1
        'grilla.Row = grilla.Rows - 1
        'grilla.Col = 1: grilla.Text = 0
        'GrdMM.Rows = 0
        'GrdMM.Rows = grilla.Rows - 1
        
        'GrdMM.ColumnCellAttrs(1) = True
        'GrdMM.ColumnCellAttrs(2) = True
        
        Screen.MousePointer = 0
        
End Sub



Private Sub GrdMM_Fetch(Row As Long, Col As Integer, Value As String)

        Grilla.Col = Col
        Grilla.Row = Row
        GrdMM.Text = Grilla.Text
        
End Sub


Private Sub GrdMM_FetchAttributes(Status As Integer, Split As Integer, Row As Long, Col As Integer, FgColor As Long, BgColor As Long, FontStyle As Integer)
    If Col = GrdMM.ColumnIndex And Row = GrdMM.RowIndex Then
        FgColor = BacToolTip.Color_Dest.ForeColor
        BgColor = BacToolTip.Color_Dest.BackColor
    Else
        FgColor = BacToolTip.Color_Normal.ForeColor
        BgColor = BacToolTip.Color_Normal.BackColor
    End If
       
End Sub

Private Sub GrdMM_KeyPress(KeyAscii As Integer)

    If Not ((KeyAscii >= 48 And KeyAscii <= 57) Or KeyAscii = 8 Or KeyAscii = Asc(sPunto)) Then
       KeyAscii = 0
    End If
    If Chr(KeyAscii) = "." Or Chr(KeyAscii) = "," Then
        KeyAscii = Asc(gsBac_PtoDec)
    End If

End Sub

Private Sub GrdMM_Update(Row As Long, Col As Integer, Value As String)

        Grilla.Col = Col
        Grilla.Row = Row
        Grilla.Text = GrdMM.Text

End Sub

Private Sub Grilla_KeyPress(KeyAscii As Integer)
Static C As Integer
C = C + 1
   With grilla
      If KeyAscii = 13 Then
         If C = 1 Then
            
         Else
            C = 0
            .Row = 0
            cmdGrabar.SetFocus
            Exit Sub
         End If
      End If
      If .Row = 0 Or .Col = 0 Then Exit Sub
      If KeyAscii = 8 Then
         Dim Largo As Integer
         If Len(.Text) = 0 Then Exit Sub
            .Text = Mid(.Text, 1, Len(.Text) - 1)
         Exit Sub
      End If
      If Not ((KeyAscii >= 48 And KeyAscii <= 57) Or KeyAscii = 8 Or KeyAscii = Asc(sPunto)) Then
         KeyAscii = 0
      End If
      If Chr(KeyAscii) = "." Or Chr(KeyAscii) = "," Then
         KeyAscii = Asc(gsBac_PtoDec)
      End If
      If C = 1 Then .Text = ""
         .Text = .Text + Chr(KeyAscii)
         .SetFocus
   End With
End Sub
Sub Graba()
Dim Fecha_Proceso       As Date
Dim Datos()
Dim F                   As Long
Dim Max                 As Long
Dim Valor1              As Double
Dim Valor2              As Double

    Max = 0
    Max = Grilla.Rows - 1
    
    If Max <= 1 Then
        MsgBox "Ingreso de rangos NO Válido", vbInformation, Me.Caption
        Exit Sub
    End If
    
    Fecha_Proceso = Format(gsBac_Fecp, "dd/mm/yy")
  
    'Elimina Registros Con Fecha de Sistema ( Todos )
    '------------------------------------------------
'    Sql = "SP_TRELIMINAR "
'    Sql = Sql & "'" & Format(Fecha_Proceso, "yyyymmdd") & "',0"

    Envia = Array(Format(Fecha_Proceso, "yyyymmdd"))
    
    If Not Bac_Sql_Execute("SP_TRELIMINAR", Envia) Then
       Screen.MousePointer = 0
       MsgBox "No Se Puede Eliminar Registros de Tabla Tasa Rangos", vbInformation, Me.Caption
       Exit Sub
    End If
        
    'Validamos que los valores sean menores a 10
    '-------------------------------------------
    For F = 1 To Max
        
        Grilla.Row = F
        Grilla.Col = 0: Valor1 = Grilla.Text
        Grilla.Col = 1: Valor2 = Grilla.Text
        
        If F <= Max Then
           
           If Valor1 > Valor2 And F <> Max Then
                MsgBox "Valor Inicio es Mayor al Valor Final en la Fila" & Str(F), vbInformation, Me.Caption
                Screen.MousePointer = 0
                Exit Sub
           End If
           
           If Valor1 = Valor2 Then
                MsgBox "Valor Inicio es Igual al Valor Final en la Fila" & Str(F), vbInformation, Me.Caption
                Screen.MousePointer = 0
                Exit Sub
           End If
                   
        End If
    
    Next F
       
    Screen.MousePointer = 11
    ' Eliminamos Los Registros de las tablas
    '---------------------------------------------
'    Sql = "SP_RGELIMINAR "
    If Not Bac_Sql_Execute("SP_RGELIMINAR") Then
       Screen.MousePointer = 0
       MsgBox "No Se Puede Eliminar Registros de Tabla de Rangos", vbInformation, Me.Caption
       Exit Sub
    End If
    
    'Grabamos en la tabla MDRG
    '-------------------------
    Dim fechaFinal      As Date
    Dim fechaInicial    As Date
    Dim meses           As Integer
    Dim anos            As Integer
    
    fechaFinal = Fecha_Proceso
    
    For F = 1 To Max
    
        Grilla.Row = F
        Grilla.Col = 0: Valor1 = Grilla.Text
        Grilla.Col = 1: Valor2 = Grilla.Text
                
        If F = 1 Then
            fechaInicial = Fecha_Proceso
        Else
            fechaInicial = DateAdd("m", 1, fechaFinal)
        End If
                
        fechaFinal = DateAdd("m", Valor2 - Valor1, fechaFinal)
        
        If F = Max Then
           fechaFinal = DateAdd("yyyy", 50, fechaFinal)
        End If
                
'        Sql = "SP_RGGRABAR  "
'        Sql = Sql & BacStrTran(Str(Valor1), ",", ".") & ","
'        Sql = Sql & BacStrTran(Str(Valor2), ",", ".") & ","
'        Sql = Sql & "'" & Format(fechaInicial, "yyyymmdd") & "',"
'        Sql = Sql & "'" & Format(fechaFinal, "yyyymmdd") & "'"

        Envia = Array(CDbl(Valor1), _
                CDbl(Valor2), _
                Format(fechaInicial, "yyyymmdd"), _
                Format(fechaFinal, "yyyymmdd"))
        
        If Not Bac_Sql_Execute("SP_RGGRABAR", Envia) Then
            Screen.MousePointer = 0
            MsgBox "No Se Puede Grabar en Tabla de Rangos", vbInformation, Me.Caption
            Exit Sub
        End If
        
    Next F
    
    Screen.MousePointer = 0
    
    MsgBox "Valores Han Sido Grabados", vbInformation, Me.Caption
    
End Sub
Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Key
   Case Is = "cmdGrabar": Call Graba
   Case Is = "cmdEliminar"
       Call LlenaGrillaMM
End Select
End Sub


Sub EliminaFilita()

End Sub


