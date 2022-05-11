VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BACCONTROLES.OCX"
Begin VB.Form BacGenUF 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Generación Automática de UF"
   ClientHeight    =   5220
   ClientLeft      =   5265
   ClientTop       =   885
   ClientWidth     =   5760
   Icon            =   "Bacgenuf.frx":0000
   LinkTopic       =   "Form2"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5220
   ScaleWidth      =   5760
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   14
      Top             =   0
      Width           =   5760
      _ExtentX        =   10160
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Generar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   4185
         Top             =   0
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   22
         ImageHeight     =   22
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   3
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacgenuf.frx":030A
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacgenuf.frx":0626
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacgenuf.frx":0942
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin Threed.SSPanel SSPanel1 
      Height          =   4680
      Left            =   0
      TabIndex        =   7
      Top             =   540
      Width           =   5745
      _Version        =   65536
      _ExtentX        =   10134
      _ExtentY        =   8255
      _StockProps     =   15
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin Threed.SSFrame SSFrame1 
         Height          =   1005
         Left            =   45
         TabIndex        =   8
         Top             =   15
         Width           =   5640
         _Version        =   65536
         _ExtentX        =   9948
         _ExtentY        =   1773
         _StockProps     =   14
         Caption         =   " Datos  "
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
         ShadowStyle     =   1
         Begin BACControles.TXTNumero FltUf 
            Height          =   315
            Left            =   350
            TabIndex        =   20
            Top             =   600
            Width           =   1335
            _ExtentX        =   2355
            _ExtentY        =   556
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
            Text            =   "0,0000"
            Text            =   "0,0000"
            CantidadDecimales=   "4"
            Separator       =   -1  'True
            MarcaTexto      =   -1  'True
         End
         Begin VB.TextBox DtxFechaUF 
            Alignment       =   2  'Center
            BackColor       =   &H00FFFFFF&
            Enabled         =   0   'False
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
            Height          =   315
            Left            =   1770
            Locked          =   -1  'True
            TabIndex        =   1
            Top             =   600
            Width           =   1215
         End
         Begin VB.Label Label3 
            AutoSize        =   -1  'True
            Caption         =   "Ultima UF Conocida"
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
            Height          =   195
            Left            =   350
            TabIndex        =   10
            Top             =   300
            Width           =   1695
         End
      End
      Begin Threed.SSFrame SSFrame4 
         Height          =   780
         Left            =   45
         TabIndex        =   16
         Top             =   960
         Width           =   5640
         _Version        =   65536
         _ExtentX        =   9948
         _ExtentY        =   1376
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
         Begin BACControles.TXTNumero FltIpc 
            Height          =   315
            Left            =   350
            TabIndex        =   21
            Top             =   390
            Width           =   1215
            _ExtentX        =   2143
            _ExtentY        =   556
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
            Text            =   "0,0000"
            Text            =   "0,0000"
            CantidadDecimales=   "4"
            Separator       =   -1  'True
            MarcaTexto      =   -1  'True
         End
         Begin VB.TextBox TxtMes 
            BackColor       =   &H00FFFFFF&
            Enabled         =   0   'False
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
            Height          =   315
            Left            =   1665
            Locked          =   -1  'True
            TabIndex        =   18
            TabStop         =   0   'False
            Top             =   390
            Width           =   1095
         End
         Begin VB.TextBox IntAnn 
            BackColor       =   &H00FFFFFF&
            Enabled         =   0   'False
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
            Height          =   315
            Left            =   2865
            Locked          =   -1  'True
            MaxLength       =   4
            TabIndex        =   17
            Top             =   390
            Width           =   715
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "IPC"
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
            Height          =   195
            Left            =   350
            TabIndex        =   0
            Top             =   150
            Width           =   315
         End
         Begin VB.Label Label2 
            AutoSize        =   -1  'True
            Caption         =   "Mes"
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
            Height          =   195
            Left            =   1665
            TabIndex        =   5
            Top             =   150
            Width           =   360
         End
         Begin VB.Label Label4 
            AutoSize        =   -1  'True
            Caption         =   "Año"
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
            Height          =   195
            Left            =   2865
            TabIndex        =   19
            Top             =   150
            Width           =   345
         End
      End
      Begin Threed.SSFrame SSFrame2 
         Height          =   2850
         Left            =   45
         TabIndex        =   9
         Top             =   1755
         Width           =   2055
         _Version        =   65536
         _ExtentX        =   3620
         _ExtentY        =   5017
         _StockProps     =   14
         Caption         =   " Ingreso "
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
         Begin BACControles.TXTNumero FltIpcIng 
            Height          =   315
            Left            =   350
            TabIndex        =   22
            Top             =   2280
            Width           =   1335
            _ExtentX        =   2355
            _ExtentY        =   556
            ForeColor       =   8388608
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
            Text            =   "0,0000"
            Text            =   "0,0000"
            CantidadDecimales=   "4"
            Separator       =   -1  'True
            MarcaTexto      =   -1  'True
         End
         Begin VB.TextBox IntAnnIng 
            Alignment       =   2  'Center
            BackColor       =   &H00FFFFFF&
            Enabled         =   0   'False
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
            Height          =   285
            Left            =   350
            TabIndex        =   4
            Top             =   1440
            Width           =   735
         End
         Begin VB.HScrollBar HSclano 
            Enabled         =   0   'False
            Height          =   315
            LargeChange     =   10
            Left            =   1320
            Max             =   2054
            Min             =   1900
            TabIndex        =   3
            Top             =   1440
            Value           =   2000
            Width           =   495
         End
         Begin VB.ComboBox CmbMes 
            BackColor       =   &H00FFFFFF&
            Enabled         =   0   'False
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
            Height          =   315
            Left            =   350
            Style           =   2  'Dropdown List
            TabIndex        =   2
            Top             =   600
            Width           =   1215
         End
         Begin VB.Label Label7 
            AutoSize        =   -1  'True
            Caption         =   "IPC"
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
            Height          =   195
            Left            =   350
            TabIndex        =   13
            Top             =   2040
            Width           =   315
         End
         Begin VB.Label Label6 
            AutoSize        =   -1  'True
            Caption         =   "Año"
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
            Height          =   195
            Left            =   350
            TabIndex        =   12
            Top             =   1200
            Width           =   345
         End
         Begin VB.Label Label5 
            AutoSize        =   -1  'True
            Caption         =   "Mes a Generar"
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
            Height          =   195
            Left            =   350
            TabIndex        =   11
            Top             =   360
            Width           =   1260
         End
      End
      Begin MSFlexGridLib.MSFlexGrid grilla 
         Height          =   2655
         Left            =   2160
         TabIndex        =   6
         Top             =   1905
         Width           =   3495
         _ExtentX        =   6165
         _ExtentY        =   4683
         _Version        =   393216
         Rows            =   13
         FixedCols       =   0
         BackColor       =   -2147483644
         ForeColor       =   8388608
         BackColorFixed  =   8421376
         ForeColorFixed  =   16777215
         BackColorSel    =   8388608
         ForeColorSel    =   8388608
         BackColorBkg    =   -2147483645
         GridColor       =   255
         GridColorFixed  =   8421504
         GridLines       =   2
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
      Begin Threed.SSFrame SSFrame3 
         Height          =   2850
         Left            =   2115
         TabIndex        =   15
         Top             =   1755
         Width           =   3585
         _Version        =   65536
         _ExtentX        =   6324
         _ExtentY        =   5027
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
      End
   End
End
Attribute VB_Name = "BacGenUF"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Form_Activate()
  Call CargarParam_Vm(grilla)
  
End Sub

Private Sub Form_Load()
    Me.Top = 0
    Me.Left = 0
Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                          , gsbac_fecp _
                          , gsBac_IP _
                          , gsBAC_User _
                          , "PCA" _
                          , "OPC_700" _
                          , "07" _
                          , "INGRESO A OPCION MENU" _
                          , " " _
                          , " " _
                          , " ")
 
   'Meses
   Call BacLLenaComboMes(CmbMes)
  
   'Año de Ingreso
   IntAnnIng.Text = Trim(Year(gsbac_fecp))
   HSclano.Value = Trim(Year(gsbac_fecp))

   Toolbar1.Buttons(1).Enabled = False
   Toolbar1.Buttons(2).Enabled = False
   
   Envia = Array()
   AddParam Envia, "09/" + Format(gsbac_fecp, "MM/YYYY")
   AddParam Envia, "01/" + Format(DateAdd("M", -1, gsbac_fecp), "MM/YYYY")

   
   If Not Bac_Sql_Execute("SP_LEEULTIMAUF", Envia) Then
      
      MsgBox "No Se puede Leer última U.F.", 64, TITSISTEMA
      Screen.MousePointer = 0
      Exit Sub
   
   End If
 
   Dim Datos()
 
   If Bac_SQL_Fetch(Datos()) Then
       
       FltUf.Text = CDbl(Datos(1))
       DtxFechaUF.Text = Format(Datos(2), "dd/mm/yyyy")
       FltIpc.Text = CDbl(Datos(3))
       FltIpcIng.Text = CDbl(Datos(3))
       
       If Trim(Datos(4)) <> "" Then
          
          TxtMes.Text = CmbMes.List(Val(Mid$(Datos(4), 4, 2)) - 1)
          IntAnn.Text = Val(DatePart("yyyy", Datos(4)))
          CmbMes.Text = CmbMes.List(Val(Mid$(Datos(2), 4, 2)) - 1)
          
       Else
          
          TxtMes.Text = ""
          IntAnn.Text = 0
       
       End If
   
   End If
   
   Toolbar1.Buttons(1).Enabled = True
   Toolbar1.Buttons(2).Enabled = True
   
   Screen.MousePointer = 0
  
End Sub

Private Sub GrdMo_1_Fetch(Row As Long, Col As Integer, Value As String)
            
      GrdUF.Row = Row
      GrdUF.Col = Col
      GrdMo_1.Text = GrdUF.Text

      
End Sub

Private Sub GrdMo_1_FetchAttributes(Status As Integer, Split As Integer, Row As Long, Col As Integer, FgColor As Long, BgColor As Long, FontStyle As Integer)

    If Col = GrdMo_1.ColumnIndex And Row = GrdMo_1.RowIndex Then
        FgColor = BacToolTip.Color_Dest.ForeColor
        BgColor = BacToolTip.Color_Dest.BackColor
    Else
        FgColor = BacToolTip.Color_Normal.ForeColor
        BgColor = BacToolTip.Color_Normal.BackColor
    End If
       

End Sub

Public Function CargarParam_Vm(Grillas As Object)

With Grillas

         
         ''.ColWidth(0) = 1320
         ''.ColWidth(1) = 2100
         
         .ColWidth(0) = 1270
         .ColWidth(1) = 1850
         
         .RowHeight(0) = 350
         .CellFontWidth = 4
         

         .Row = 0
         
         .Col = 0
         .FixedAlignment(0) = 4
         .CellFontBold = True
         .Text = " Fecha "
         .ColAlignment(0) = 4

         .Col = 1
         .FixedAlignment(1) = 4
         .CellFontBold = True
         .Text = " Valor "
         .ColAlignment(1) = 8

End With

End Function

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Index
    Case 1
            Dim sql    As String
            Dim AuxMes As String
            Dim AuxAno As String
            Dim AuxIpc As Double
            
            Screen.MousePointer = 11
            
            AuxMes = Format(CmbMes.ItemData(CmbMes.ListIndex), "00")
            AuxAno = Str(IntAnnIng.Text)
            AuxIpc = CDbl(FltIpcIng.Text)
            
            'Genera UF de un mes determinado
            '-------------------------------
            Envia = Array()
            AddParam Envia, CDbl(AuxMes)
            AddParam Envia, CDbl(AuxAno)
            AddParam Envia, CDbl(AuxIpc)
            AddParam Envia, CDbl(FltUf.Text)
            
            If Not Bac_Sql_Execute("SP_GENERAUF", Envia) Then
            
               MsgBox "No se puede generar UF", 64, TITSISTEMA
               Screen.MousePointer = 0
               Exit Sub
            
            End If
            'Muestra U.F. Generadas
            '----------------------
            
            With grilla
            
               Dim Datos()
               
               .Rows = 2
               
               Call F_BacLimpiaGrilla(grilla)
               
               .Redraw = False
                  
                  Do While MISQL.SQL_Fetch(Datos()) = 0
                  
                     .Row = .Rows - 1
                     .TextMatrix(.Row, 0) = Datos(1)
                     .TextMatrix(.Row, 1) = Format(Datos(2), FDecimal)
                     .Rows = .Rows + 1
                  
                  Loop
               
               If .Rows <> 2 Then .Rows = .Rows - 1
               .Redraw = True
               
            End With
            
            Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                          , gsbac_fecp _
                          , gsBac_IP _
                          , gsBAC_User _
                          , "PCA" _
                          , "OPC_700" _
                          , "01" _
                          , "Grabar, Mes " _
                          , "VALOR_MONEDA" _
                          , " " _
                          , "Grabar, Mes " & CmbMes.Text & " Año " & IntAnnIng.Text & " IPC " & FltIpcIng.Text)

            
            
            Screen.MousePointer = 0

    Case 2
               grilla.Tag = grilla.Rows
               grilla.Rows = 1
               grilla.Rows = grilla.Tag

    Case 3
            Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                          , gsbac_fecp _
                          , gsBac_IP _
                          , gsBAC_User _
                          , "PCA" _
                          , "OPC_700" _
                          , "08" _
                          , "SALIR DE OPCION MENU " _
                          , " " _
                          , " " _
                          , " ")
            Unload BacGenUF

End Select

End Sub
