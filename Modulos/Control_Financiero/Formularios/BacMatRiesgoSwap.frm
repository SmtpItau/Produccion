VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacMatRiesgoSwap 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Matriz de Riesgo SWAP"
   ClientHeight    =   4410
   ClientLeft      =   4485
   ClientTop       =   3285
   ClientWidth     =   4590
   Icon            =   "BacMatRiesgoSwap.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   MouseIcon       =   "BacMatRiesgoSwap.frx":000C
   ScaleHeight     =   4410
   ScaleWidth      =   4590
   Begin MSFlexGridLib.MSFlexGrid Oculta 
      Height          =   345
      Left            =   240
      TabIndex        =   6
      Top             =   4755
      Visible         =   0   'False
      Width           =   750
      _ExtentX        =   1323
      _ExtentY        =   609
      _Version        =   393216
      FixedCols       =   0
   End
   Begin Threed.SSPanel SSPanel1 
      Height          =   3975
      Left            =   15
      TabIndex        =   0
      Top             =   495
      Width           =   4650
      _Version        =   65536
      _ExtentX        =   8202
      _ExtentY        =   7011
      _StockProps     =   15
      BackColor       =   -2147483644
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BevelOuter      =   1
      Begin VB.Frame marco1 
         Height          =   990
         Left            =   75
         TabIndex        =   4
         Top             =   15
         Width           =   4485
         Begin VB.ComboBox CmbProducto 
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   315
            ItemData        =   "BacMatRiesgoSwap.frx":0316
            Left            =   1140
            List            =   "BacMatRiesgoSwap.frx":0318
            Style           =   2  'Dropdown List
            TabIndex        =   9
            Top             =   240
            Width           =   3270
         End
         Begin VB.ComboBox Cmbmoneda 
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   315
            ItemData        =   "BacMatRiesgoSwap.frx":031A
            Left            =   1140
            List            =   "BacMatRiesgoSwap.frx":031C
            Style           =   2  'Dropdown List
            TabIndex        =   8
            Top             =   600
            Width           =   3270
         End
         Begin VB.Label Label2 
            Caption         =   "Moneda"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   210
            Left            =   75
            TabIndex        =   7
            Top             =   615
            Width           =   960
         End
         Begin VB.Label Label1 
            Caption         =   "Producto"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   210
            Left            =   75
            TabIndex        =   5
            Top             =   270
            Width           =   975
         End
      End
      Begin VB.Frame marco2 
         Height          =   2985
         Left            =   60
         TabIndex        =   3
         Top             =   945
         Width           =   4545
         Begin BACControles.TXTNumero texto 
            Height          =   315
            Left            =   1440
            TabIndex        =   2
            Top             =   630
            Visible         =   0   'False
            Width           =   1455
            _ExtentX        =   2566
            _ExtentY        =   556
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
            Text            =   "0"
            Text            =   "0"
            Min             =   "0"
         End
         Begin MSFlexGridLib.MSFlexGrid Grid 
            Height          =   2805
            Left            =   60
            TabIndex        =   1
            Top             =   120
            Width           =   4410
            _ExtentX        =   7779
            _ExtentY        =   4948
            _Version        =   393216
            Rows            =   5
            Cols            =   3
            FixedCols       =   0
            BackColor       =   -2147483644
            ForeColor       =   8388608
            BackColorFixed  =   8421376
            ForeColorFixed  =   16777215
            BackColorSel    =   8388608
            ForeColorSel    =   16777215
            BackColorBkg    =   -2147483636
            GridColor       =   8421504
            GridColorFixed  =   16777215
            FocusRect       =   0
            GridLines       =   2
         End
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   480
      Left            =   0
      TabIndex        =   10
      Top             =   0
      Width           =   4590
      _ExtentX        =   8096
      _ExtentY        =   847
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   5
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   1
            BeginProperty ButtonMenus {66833FEC-8583-11D1-B16A-00C0F0283628} 
               NumButtonMenus  =   1
               BeginProperty ButtonMenu1 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
            EndProperty
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   2
            BeginProperty ButtonMenus {66833FEC-8583-11D1-B16A-00C0F0283628} 
               NumButtonMenus  =   1
               BeginProperty ButtonMenu1 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
            EndProperty
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.ToolTipText     =   "Eliminar"
            ImageIndex      =   3
            BeginProperty ButtonMenus {66833FEC-8583-11D1-B16A-00C0F0283628} 
               NumButtonMenus  =   1
               BeginProperty ButtonMenu1 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
            EndProperty
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   4
            BeginProperty ButtonMenus {66833FEC-8583-11D1-B16A-00C0F0283628} 
               NumButtonMenus  =   1
               BeginProperty ButtonMenu1 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
            EndProperty
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   5
            BeginProperty ButtonMenus {66833FEC-8583-11D1-B16A-00C0F0283628} 
               NumButtonMenus  =   8
               BeginProperty ButtonMenu1 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
               BeginProperty ButtonMenu2 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
               BeginProperty ButtonMenu3 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
               BeginProperty ButtonMenu4 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
               BeginProperty ButtonMenu5 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
               BeginProperty ButtonMenu6 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
               BeginProperty ButtonMenu7 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
               BeginProperty ButtonMenu8 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
            EndProperty
         EndProperty
      EndProperty
      BorderStyle     =   1
      MouseIcon       =   "BacMatRiesgoSwap.frx":031E
      OLEDropMode     =   1
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   8490
      Top             =   690
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   24
      ImageHeight     =   24
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   5
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMatRiesgoSwap.frx":0638
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMatRiesgoSwap.frx":1512
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMatRiesgoSwap.frx":23EC
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMatRiesgoSwap.frx":32C6
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMatRiesgoSwap.frx":41A0
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "BacMatRiesgoSwap"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim Irayuda
Dim TEXTVISIBLE As Boolean
Dim COLGRID2 As Integer
Dim ROWGRID2 As Integer
Dim COLGRID1 As Integer
Dim ROWGRID1 As Integer
Dim Asciitexto As Integer
Dim Erro As Boolean
Dim ValNue  As String
Dim ValAnt  As String

Sub VALIDATEXTO()
    Erro = True
    Grid.Col = COLGRID2
    If ROWGRID2 < Grid.Rows - 1 Then
        Grid.Row = ROWGRID2
    End If
    If Grid.Col = 0 Then
            If Grid.Row <> 2 Then
                If Val(Format(Grid.TextMatrix(Grid.Row - 1, 1), FEntero)) <> Val(Format(texto.Text, FEntero)) Then
                    MsgBox "Datos mal Ingresados", vbCritical, TITSISTEMA
                    texto.SetFocus
                    Erro = True
                    Exit Sub
                Else
                    Grid.Text = texto.Text
                    Grid.Text = Format(Grid.Text, FEntero)
            
                End If
            Else
                If Val(Format(Grid.TextMatrix(Grid.Row, 1), FEntero)) > Val(Format(texto.Text, FEntero)) Then
                    If texto.Text = 0 Then
                        MsgBox "Datos mal Ingresados", vbCritical, TITSISTEMA
                        texto.SetFocus
                        Erro = True
                        Exit Sub
                    Else
                        Grid.Text = texto.Text
                        Grid.Text = Format(Grid.Text, FEntero)
                    End If
                Else
                    MsgBox "Datos mal Ingresados", vbCritical, TITSISTEMA
                    texto.SetFocus
                    Erro = True
                    Exit Sub
                End If
            End If
       ElseIf Grid.Col = 1 Then
            If Val(Grid.TextMatrix(Grid.Row, 0)) >= Val(texto.Text) Then
                MsgBox "Datos mal Ingresados", vbCritical, TITSISTEMA
                texto.SetFocus
                Erro = True
                Exit Sub
            Else
                If Grid.Rows - 1 <> Grid.Row Then
                    If Val(Format(texto.Text, FEntero)) < Val(Format(Grid.TextMatrix(Grid.Row + 1, 1), FEntero)) Then
                        Grid.TextMatrix(Grid.Row + 1, 0) = Val(Format(texto.Text, FEntero))
                    Else
                        MsgBox "Datos mal Ingresados", vbCritical, TITSISTEMA
                        texto.SetFocus
                        Erro = True
                        Exit Sub
                    End If
                End If
                Grid.Text = texto.Text
                Grid.Text = Format(Grid.Text, FEntero)
            End If
       Else
            If texto.Text <> "0" Then
               Grid.Text = Format(texto.Text, FDecimal)
               If Grid.Text = "." Then
                  Grid.Text = 0
               End If
            Else
               MsgBox "Datos mal Ingresados", vbCritical, TITSISTEMA
               texto.SetFocus
               Erro = True
               Exit Sub
            End If
       End If
       Erro = False
       If Grid.Enabled = True Then
            Grid.SetFocus
       End If
       texto.Visible = False
End Sub

Sub Pregrabado()
    Dim datos()
    
    If Not Bac_Sql_Execute("SP_MATRIZRIESGO_AYUDAPRODUCTO") Then
       GoTo Nogragar
    End If

    existe = 0
    Do While Bac_SQL_Fetch(datos())
       If datos(1) = CmbProducto.ItemData(CmbProducto.ListIndex) Then
           existe = 1
           Exit Do
       End If
    Loop
    
    If existe = 0 Then
        GoTo Nogragar
    Else
        For m = 2 To Grid.Rows - 1
            mm = Format(Grid.TextMatrix(m, 2), FDecimal)
            If CDbl(Grid.TextMatrix(m, 2)) = 0 Then
                GoTo Nogragar
            End If
        Next m
    End If
    Call Graba
    Exit Sub
Nogragar:
MsgBox "No se puede Grabar", vbCritical, TITSISTEMA
End Sub

Sub Busca()

Dim datos()
    
   Envia = Array()
                  
   AddParam Envia, CmbProducto.ItemData(CmbProducto.ListIndex)
   AddParam Envia, Cmbmoneda.ItemData(Cmbmoneda.ListIndex)
   
    If Not Bac_Sql_Execute("SP_MATRIZRIESGO_BUSCA_SWP", Envia) Then
        Exit Sub
    End If
    
    Grid.Rows = 2
    
    Grid.Redraw = False
    
    Do While Bac_SQL_Fetch(datos())
               
        Grid.Rows = Grid.Rows + 1
        Grid.RowHeight(Grid.Rows - 1) = 315
        Grid.Row = Grid.Rows - 1
        Grid.TextMatrix(Grid.Row, 0) = Format(datos(3), FEntero)
        Grid.TextMatrix(Grid.Row, 1) = Format(datos(4), FEntero)
        Grid.TextMatrix(Grid.Row, 2) = Format(datos(5), FDecimal)
        Grid.Row = 2
    Loop
    
    Grid.Redraw = True
    
    If Grid.Rows = 2 Then
        Existeope = "NO"
        Toolbar1.Buttons(1).Enabled = True
        Toolbar1.Buttons(2).Enabled = True
        Toolbar1.Buttons(3).Enabled = True
        Toolbar1.Buttons(4).Enabled = True
        Toolbar1.Buttons(5).Enabled = True
        InsertarRow
    Else
        Existeope = "SI"
        Toolbar1.Buttons(1).Enabled = True
        Toolbar1.Buttons(2).Enabled = True
        Toolbar1.Buttons(3).Enabled = True
        Toolbar1.Buttons(4).Enabled = False
        Toolbar1.Buttons(5).Enabled = True
        
    End If
    
    Call CargaValoresGrilla

End Sub
Sub CargaValoresGrilla()
    Dim F%, C%
    With Oculta
      .Clear
      .FixedRows = 0
      .Cols = Grid.Cols
      .Rows = Grid.Rows
      For F = 0 To Grid.Rows - 1
         For C = 0 To Grid.Cols - 1
            .TextMatrix(F, C) = Grid.TextMatrix(F, C)
         Next C
      Next F
    End With
End Sub
Sub Graba()
    Dim datos()
    
   Envia = Array()
                  
   AddParam Envia, CmbProducto.ItemData(CmbProducto.ListIndex)
   AddParam Envia, Cmbmoneda.ItemData(Cmbmoneda.ListIndex)
   
    If Not Bac_Sql_Execute("SP_MATRIZRIESGO_ELIMINA_SWAP", Envia) Then
       MsgBox "Problemas al Eliminar", vbCritical, TITSISTEMA
       Exit Sub
    End If
    
With Grid
    
    For ROWGRID = 2 To .Rows - 1
      Envia = Array()
                     
      AddParam Envia, CmbProducto.ItemData(CmbProducto.ListIndex)
      AddParam Envia, Cmbmoneda.ItemData(Cmbmoneda.ListIndex)
      AddParam Envia, CDbl(.TextMatrix(ROWGRID, 0))
      AddParam Envia, CDbl(.TextMatrix(ROWGRID, 1))
      AddParam Envia, CDbl(.TextMatrix(ROWGRID, 2))
        
      If Not Bac_Sql_Execute("SP_MATRIZRIESGO_GRABA_SWAP", Envia) Then
          MsgBox "Problemas al GraBar", vbCritical, TITSISTEMA
          Exit Sub
      End If
                            
    Next ROWGRID
    MsgBox "Grabación se realizo con exito", vbInformation, TITSISTEMA
End With
    
    Call ValAntNue
    
    Call GRABA_LOG_AUDITORIA(1, (gsBAC_Fecp), gsBac_IP, gsBAC_User, "SCF", "Opt30005", "01", "GRABA MATRIZ DE RIESGO SWAP", "MATRIZ_RIESGO", "", ValNue)
    
    Call Cargar

End Sub
Sub ValAntNue()
    Dim F%, C%
    ValAnt = "": ValNue = ""
    With Oculta
      For F = 0 To Grid.Rows - 1
         For C = 0 To Grid.Cols - 1
            If .TextMatrix(F, C) <> Grid.TextMatrix(F, C) Then
               ValAnt = ValAnt & .TextMatrix(F, C) & ";"
               ValNue = ValNue & .TextMatrix(F, C) & ";"
            End If
         Next C
      Next F
    End With
End Sub

Sub Elimina()
    Dim datos()
    
   Envia = Array()
                  
   AddParam Envia, CmbProducto.ItemData(CmbProducto.ListIndex)
   AddParam Envia, Cmbmoneda.ItemData(Cmbmoneda.ListIndex)
    
    If Not Bac_Sql_Execute("SP_MATRIZRIESGO_ELIMINA", Envia) Then
        Exit Sub
    End If
    
    Existeope = "SI"
    If Existeope = "SI" Then
        res = MsgBox("¿Esta seguro que desea eliminar?", vbQuestion + vbYesNo, TITSISTEMA)
        If res = 6 Then
            
            Envia = Array()
                           
            AddParam Envia, CmbProducto.ItemData(CmbProducto.ListIndex)
            AddParam Envia, Cmbmoneda.ItemData(Cmbmoneda.ListIndex)
            
            If Not Bac_Sql_Execute("SP_MATRIZRIESGO_ELIMINA", Envia) Then
                Exit Sub
            End If
            
            Call ValAntNue
            Call GRABA_LOG_AUDITORIA(1, (gsBAC_Fecp), gsBac_IP, gsBAC_User, "SCF", "Opt30005", "03", "ELIMINA MATRIZ DE RIESGO", "MATRIZ_RIESGO", ValAnt, "")
            
            Call Cargar
            Exit Sub
        End If
    End If
End Sub

Sub formatexto()
    With Grid
    If .Col = 0 Or .Col = 1 Then
        texto.CantidadDecimales = 0
        texto.Max = "9999"
    Else
        texto.CantidadDecimales = 4
        texto.Max = "100"
    End If
    End With
End Sub

Sub InsertarRow()
    
    If Val(Format(Grid.TextMatrix(Grid.Row, 1), FEntero)) < 9999 Then
        
        Grid.Rows = Grid.Rows + 1: Oculta.Rows = Oculta.Rows + 1
        Grid.RowHeight(Grid.Rows - 1) = 315
        Oculta.Cols = Grid.Cols
        
        If Grid.Rows = 3 Then
            
            ValAnterior = Val(Grid.TextMatrix(Grid.Rows - 2, 1))
        
        Else
            
            ValAnterior = Format((Grid.TextMatrix(Grid.Rows - 2, 1)), FEntero) + 1
        
        End If
        
        Grid.TextMatrix(Grid.Rows - 1, 0) = Format(ValAnterior, FEntero): Oculta.TextMatrix(Grid.Rows - 1, 0) = Grid.TextMatrix(Grid.Rows - 1, 0)
        Grid.TextMatrix(Grid.Rows - 1, 1) = Format(ValAnterior, FEntero) + 1: Oculta.TextMatrix(Grid.Rows - 1, 1) = Grid.TextMatrix(Grid.Rows - 1, 1)
        Grid.TextMatrix(Grid.Rows - 1, 2) = Format("0.0000", FDecimal): Oculta.TextMatrix(Grid.Rows - 1, 2) = Grid.TextMatrix(Grid.Rows - 1, 2)
        Grid.Col = 0: Oculta.Col = 0
        Grid.Row = Grid.Rows - 1: Oculta.Row = Grid.Row
    
            
    
    End If

End Sub
Sub Cargar_Grid()
    Grid.Rows = 3
    Grid.Cols = 3
    Grid.FixedRows = 2
    Grid.FixedCols = 0
    Grid.TextMatrix(0, 0) = "Plazo"
    Grid.TextMatrix(0, 1) = "Plazo"
    Grid.TextMatrix(0, 2) = "Pocentaje"
    Grid.TextMatrix(1, 0) = "Inicial"
    Grid.TextMatrix(1, 1) = "Final"
    Grid.TextMatrix(1, 2) = "Asignado"
    Grid.GridLinesFixed = flexGridNone
    
    For m = 0 To Grid.Cols - 1
        Grid.ColWidth(m) = 1350
    Next m
    
    For m = 0 To Grid.Rows - 2
        Grid.RowHeight(m) = 225
    Next m
    
    For m = 0 To Grid.Rows - 1
        For mm = 0 To Grid.Cols - 1
            Grid.Col = mm
            Grid.Row = m
            Grid.CellFontBold = True
            Grid.GridLinesFixed = flexGridNone
        Next mm
    Next m
    Grid.CellFontBold = False
    Grid.Rows = Grid.Rows - 1
    InsertarRow
End Sub
Sub Cargar()

    Dim datos()
  

   Dim nCont As Integer
    
   marco2.Enabled = False
   Toolbar1.Buttons(2).Enabled = False
   Toolbar1.Buttons(3).Enabled = False
   Toolbar1.Buttons(4).Enabled = True

   CmbProducto.Enabled = True
   Cmbmoneda.Enabled = True

    If Not Bac_Sql_Execute("SP_MATRIZRIESGO_AYUDAPRODUCTO_SWAP") Then
       Exit Sub
    End If

   If CmbProducto.ListCount = -1 Then
      MsgBox "No existen Productos cargados"
      Exit Sub
   End If

   If Cmbmoneda.ListCount = -1 Then
      MsgBox "No existen monedas cargadas"
      Exit Sub
   End If

   Toolbar1.Buttons(4).Enabled = True

   For nCont = 0 To CmbProducto.ListCount - 1

      If CmbProducto.ItemData(nCont) = "1" Then
         CmbProducto.ListIndex = nCont
         Exit For
      End If
   Next

   For nCont = 0 To Cmbmoneda.ListCount - 1

      If Cmbmoneda.ItemData(nCont) = 13 Then
         Cmbmoneda.ListIndex = nCont
         Exit For
      End If
   Next
    
   Cargar_Grid

End Sub

Private Sub cmbModalidad_Change()

End Sub

Private Sub Form_Load()
   
   Me.Top = 0
   Me.Left = 0
   
   Me.Icon = Acceso_Usuario.Icon
   
   Dim datos()
   Dim Envia
   
   Envia = Array()

   If Bac_Sql_Execute("SP_TRAEMONEDAS") Then
      Do While Bac_SQL_Fetch(datos())
         Cmbmoneda.AddItem datos(2)
         Cmbmoneda.ItemData(Cmbmoneda.NewIndex) = datos(1)
      Loop
   End If
   If Bac_Sql_Execute("SP_MATRIZRIESGO_AYUDAPRODUCTO_SWAP", Envia) Then
      Do While Bac_SQL_Fetch(datos())
         CmbProducto.AddItem datos(2)
         CmbProducto.ItemData(CmbProducto.NewIndex) = datos(5)
      Loop
   End If
        
   Cargar
End Sub



Private Sub Grid_KeyDown(KEYCODE As Integer, Shift As Integer)
  If Shift = 1 Then
      KEYCODE = 0
      Shift = 0
  End If
  If KEYCODE = 45 Then
       If Grid.Row = Grid.Rows - 1 Then
            If Val(Format(Grid.TextMatrix(Grid.Rows - 1, 1), FEntero)) > 0 Then
              If CDbl(Format(Grid.TextMatrix(Grid.Rows - 1, 2), FDecimal)) > 0 Then
                Call InsertarRow
              End If
            End If
       End If
       Exit Sub
    End If
    If KEYCODE = 46 Then
        If Grid.Row = Grid.Rows - 1 Then
            If Grid.Rows > 3 Then
                res = MsgBox("¿Esta seguro que desea eliminar?", vbQuestion + vbYesNo, TITSISTEMA)
                If res = 6 Then
                    Grid.Rows = Grid.Rows - 1
                End If
            End If
            Grid.SetFocus
        End If
        Exit Sub
    End If
End Sub

Private Sub Grid_KeyPress(KeyAscii As Integer)
Asciitexto = 0
If KeyAscii > 47 And KeyAscii < 58 Or KeyAscii = 13 Then
      If Grid.Col <> 0 Then
        If KeyAscii > 47 And KeyAscii < 58 Then Asciitexto = KeyAscii
        Call PROC_POSICIONA_TEXTO(Grid, texto)
        Call formatexto
            If texto.Visible = False Then
                COLGRID2 = Grid.Col
                ROWGRID2 = Grid.Row
            End If
            texto.Visible = True
            texto.Text = BacCtrlTransMonto(CDbl(Grid.Text))
            If Asciitexto > 0 Then
                texto.Text = Chr(Asciitexto)
            End If
            texto.SetFocus
            texto.SelStart = 1
      End If
      Exit Sub
End If
If KeyAscii = 46 Or KeyAscii = 45 Then
    Exit Sub
End If
KeyAscii = 0
End Sub

Private Sub Grid_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
    COLGRID1 = Grid.Col
    ROWGRID1 = Grid.Row
End Sub

Private Sub Grid_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
    Grid.Col = COLGRID1
    Grid.Row = ROWGRID1
End Sub

Private Sub Grid_Scroll()
    
    Call Texto_KeyDown(27, 0)
End Sub

Private Sub texto_Change()
TEXTVISIBLE = True
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

    Select Case Button.Index
        Case 2
            If texto.Visible = True Then
                Exit Sub
            End If
                Call Pregrabado
         Case 3
            If texto.Visible = True Then
                Exit Sub
            End If
                Call Elimina
        Case 1
            Call Cargar
        Case 4
            Call Busca
            CmbProducto.Enabled = False
            Cmbmoneda.Enabled = False
            Toolbar1.Buttons(2).Enabled = True
            Toolbar1.Buttons(3).Enabled = True
            Toolbar1.Buttons(4).Enabled = True
            marco2.Enabled = True

        Case 5
            Unload Me
    End Select
End Sub

Private Sub Texto_KeyDown(KEYCODE As Integer, Shift As Integer)
    If KEYCODE = 27 Then
        texto.Text = 0
        texto.Visible = False
        TEXTVISIBLE = False
        Grid.SetFocus
        Exit Sub
    End If
    If KEYCODE = 13 Then
       Call VALIDATEXTO
    End If
End Sub

Private Sub Texto_LostFocus()
    If TEXTVISIBLE = True Then
        Call VALIDATEXTO
    End If
End Sub

Private Sub Toolbar2_ButtonClick(ByVal Button As MSComctlLib.Button)

    Select Case Button.Index
        Case 1
            If texto.Visible = True Then
                Exit Sub
            End If
                Call Pregrabado
        Case 2
            If texto.Visible = True Then
                Exit Sub
            End If
                Call Elimina
        Case 3
            Call Cargar
        Case 4
            Call Busca
                marco2.Enabled = True
                Grid.Enabled = True
        Case 5
            Unload Me
    End Select

End Sub
