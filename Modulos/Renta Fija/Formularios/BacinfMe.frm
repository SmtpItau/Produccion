VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacInfMercado 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Informes De Valorización"
   ClientHeight    =   4875
   ClientLeft      =   2100
   ClientTop       =   2970
   ClientWidth     =   4170
   ForeColor       =   &H00C0C0C0&
   Icon            =   "BacinfMe.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4875
   ScaleWidth      =   4170
   Visible         =   0   'False
   Begin VB.Frame Frame4 
      Caption         =   "Expotar a Exel  "
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000D&
      Height          =   855
      Left            =   -15
      TabIndex        =   25
      Top             =   5775
      Width           =   3960
      Begin VB.PictureBox SinCheck 
         BorderStyle     =   0  'None
         Height          =   345
         Index           =   0
         Left            =   120
         Picture         =   "BacinfMe.frx":030A
         ScaleHeight     =   345
         ScaleWidth      =   375
         TabIndex        =   27
         Top             =   285
         Width           =   375
      End
      Begin VB.PictureBox ConCheck 
         BorderStyle     =   0  'None
         Height          =   330
         Index           =   0
         Left            =   120
         Picture         =   "BacinfMe.frx":0464
         ScaleHeight     =   330
         ScaleWidth      =   330
         TabIndex        =   26
         Top             =   285
         Visible         =   0   'False
         Width           =   330
      End
      Begin VB.Label Etiqueta 
         AutoSize        =   -1  'True
         Caption         =   "Valorización a Tasa de Mercado"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   3
         Left            =   600
         TabIndex        =   28
         Top             =   285
         Width           =   2535
      End
   End
   Begin Threed.SSPanel SSPanel1 
      Height          =   4335
      Left            =   0
      TabIndex        =   1
      Top             =   510
      Width           =   4170
      _Version        =   65536
      _ExtentX        =   7355
      _ExtentY        =   7646
      _StockProps     =   15
      Caption         =   "SSPanel1"
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
      BevelInner      =   1
      Begin VB.Frame Frame2 
         Caption         =   "Listados"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   -1  'True
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   1260
         Left            =   105
         TabIndex        =   29
         Top             =   2970
         Width           =   3975
         Begin VB.PictureBox ConCheck 
            BorderStyle     =   0  'None
            Height          =   330
            Index           =   7
            Left            =   3405
            Picture         =   "BacinfMe.frx":05BE
            ScaleHeight     =   330
            ScaleWidth      =   330
            TabIndex        =   33
            Top             =   360
            Visible         =   0   'False
            Width           =   330
         End
         Begin VB.PictureBox SinCheck 
            BorderStyle     =   0  'None
            Height          =   330
            Index           =   7
            Left            =   240
            Picture         =   "BacinfMe.frx":0718
            ScaleHeight     =   330
            ScaleWidth      =   375
            TabIndex        =   32
            Top             =   360
            Width           =   375
         End
         Begin VB.PictureBox SinCheck 
            BorderStyle     =   0  'None
            Height          =   330
            Index           =   6
            Left            =   240
            Picture         =   "BacinfMe.frx":0872
            ScaleHeight     =   330
            ScaleWidth      =   375
            TabIndex        =   31
            Top             =   780
            Width           =   375
         End
         Begin VB.PictureBox ConCheck 
            BorderStyle     =   0  'None
            Height          =   330
            Index           =   6
            Left            =   3390
            Picture         =   "BacinfMe.frx":09CC
            ScaleHeight     =   330
            ScaleWidth      =   330
            TabIndex        =   30
            Top             =   780
            Visible         =   0   'False
            Width           =   330
         End
         Begin VB.Label Etiqueta 
            AutoSize        =   -1  'True
            Caption         =   "Informe de Tasas Fusión"
            ForeColor       =   &H00800000&
            Height          =   195
            Index           =   2
            Left            =   705
            TabIndex        =   35
            Top             =   390
            Width           =   1740
         End
         Begin VB.Label Etiqueta 
            AutoSize        =   -1  'True
            Caption         =   "Valorización de Mercado Fusión"
            ForeColor       =   &H00800000&
            Height          =   195
            Index           =   1
            Left            =   690
            TabIndex        =   34
            Top             =   810
            Width           =   2265
         End
      End
      Begin VB.Frame Frame3 
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   -1  'True
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   2895
         Left            =   105
         TabIndex        =   2
         Top             =   75
         Width           =   3960
         Begin VB.ComboBox Cmb_Cartera_Normativa 
            Height          =   315
            Left            =   195
            Style           =   2  'Dropdown List
            TabIndex        =   16
            Top             =   1800
            Width           =   3675
         End
         Begin VB.PictureBox SinCheck 
            AutoSize        =   -1  'True
            BorderStyle     =   0  'None
            Height          =   270
            Index           =   4
            Left            =   1335
            Picture         =   "BacinfMe.frx":0B26
            ScaleHeight     =   270
            ScaleWidth      =   300
            TabIndex        =   14
            Top             =   2340
            Width           =   300
         End
         Begin VB.PictureBox ConCheck 
            AutoSize        =   -1  'True
            BorderStyle     =   0  'None
            Height          =   270
            Index           =   4
            Left            =   2655
            Picture         =   "BacinfMe.frx":0C80
            ScaleHeight     =   270
            ScaleWidth      =   300
            TabIndex        =   13
            Top             =   2340
            Visible         =   0   'False
            Width           =   300
         End
         Begin BACControles.TXTFecha TXTFecha 
            Height          =   255
            Left            =   960
            TabIndex        =   6
            Top             =   1080
            Width           =   1335
            _ExtentX        =   2355
            _ExtentY        =   450
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
            Text            =   "07/09/2001"
         End
         Begin VB.ComboBox Combo1 
            BeginProperty Font 
               Name            =   "Courier New"
               Size            =   9
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   345
            Left            =   180
            Style           =   2  'Dropdown List
            TabIndex        =   3
            Top             =   495
            Width           =   3675
         End
         Begin VB.Label Lbl_Cartera_Normativa 
            AutoSize        =   -1  'True
            Caption         =   "Cartera Normativa"
            BeginProperty Font 
               Name            =   "Times New Roman"
               Size            =   9
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   225
            Left            =   195
            TabIndex        =   17
            Top             =   1575
            Width           =   1485
         End
         Begin VB.Label Etiqueta 
            AutoSize        =   -1  'True
            Caption         =   "Dólares"
            ForeColor       =   &H00800000&
            Height          =   195
            Index           =   9
            Left            =   1725
            TabIndex        =   15
            Top             =   2385
            Width           =   630
            WordWrap        =   -1  'True
         End
         Begin VB.Label lblEtiqueta 
            AutoSize        =   -1  'True
            Caption         =   "Fecha"
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
            Index           =   0
            Left            =   225
            TabIndex        =   5
            Top             =   1050
            Width           =   540
         End
         Begin VB.Label lblEtiqueta 
            AutoSize        =   -1  'True
            Caption         =   "Entidad"
            BeginProperty Font 
               Name            =   "Times New Roman"
               Size            =   9
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   225
            Index           =   1
            Left            =   180
            TabIndex        =   4
            Top             =   270
            Width           =   600
         End
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Height          =   510
      Left            =   60
      TabIndex        =   0
      Top             =   -15
      Width           =   4110
      _ExtentX        =   7250
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Generar Informe a Pantalla"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Imprimir Informe"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Genera Planilla a Exel"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin VB.Frame Frame1 
      Caption         =   "Listados de valorizacion "
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   900
      Left            =   105
      TabIndex        =   18
      Top             =   7230
      Width           =   3975
      Begin VB.PictureBox SinCheck 
         BorderStyle     =   0  'None
         Height          =   330
         Index           =   1
         Left            =   240
         Picture         =   "BacinfMe.frx":0DDA
         ScaleHeight     =   330
         ScaleWidth      =   375
         TabIndex        =   22
         Top             =   330
         Width           =   375
      End
      Begin VB.PictureBox ConCheck 
         BorderStyle     =   0  'None
         Height          =   330
         Index           =   1
         Left            =   1365
         Picture         =   "BacinfMe.frx":0F34
         ScaleHeight     =   330
         ScaleWidth      =   330
         TabIndex        =   21
         Top             =   330
         Visible         =   0   'False
         Width           =   330
      End
      Begin VB.PictureBox SinCheck 
         BorderStyle     =   0  'None
         Height          =   330
         Index           =   5
         Left            =   2160
         Picture         =   "BacinfMe.frx":108E
         ScaleHeight     =   330
         ScaleWidth      =   375
         TabIndex        =   20
         Top             =   360
         Width           =   375
      End
      Begin VB.PictureBox ConCheck 
         BorderStyle     =   0  'None
         Height          =   330
         Index           =   5
         Left            =   3480
         Picture         =   "BacinfMe.frx":11E8
         ScaleHeight     =   330
         ScaleWidth      =   330
         TabIndex        =   19
         Top             =   360
         Visible         =   0   'False
         Width           =   330
      End
      Begin VB.Label Etiqueta 
         AutoSize        =   -1  'True
         Caption         =   "Fin de mes"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   10
         Left            =   705
         TabIndex        =   24
         Top             =   405
         Width           =   1110
      End
      Begin VB.Label Etiqueta 
         AutoSize        =   -1  'True
         Caption         =   "Diaria"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   0
         Left            =   2640
         TabIndex        =   23
         Top             =   360
         Width           =   405
      End
   End
   Begin VB.PictureBox ConCheck 
      BorderStyle     =   0  'None
      Enabled         =   0   'False
      Height          =   315
      Index           =   3
      Left            =   3420
      Picture         =   "BacinfMe.frx":1342
      ScaleHeight     =   315
      ScaleWidth      =   375
      TabIndex        =   10
      Top             =   6900
      Visible         =   0   'False
      Width           =   375
   End
   Begin VB.PictureBox ConCheck 
      BorderStyle     =   0  'None
      Enabled         =   0   'False
      Height          =   330
      Index           =   2
      Left            =   2070
      Picture         =   "BacinfMe.frx":149C
      ScaleHeight     =   330
      ScaleWidth      =   330
      TabIndex        =   9
      Top             =   6900
      Visible         =   0   'False
      Width           =   330
   End
   Begin VB.PictureBox SinCheck 
      BorderStyle     =   0  'None
      Enabled         =   0   'False
      Height          =   330
      Index           =   3
      Left            =   2535
      Picture         =   "BacinfMe.frx":15F6
      ScaleHeight     =   330
      ScaleWidth      =   375
      TabIndex        =   8
      Top             =   6900
      Width           =   375
   End
   Begin VB.PictureBox SinCheck 
      BorderStyle     =   0  'None
      Enabled         =   0   'False
      Height          =   330
      Index           =   2
      Left            =   1335
      Picture         =   "BacinfMe.frx":1750
      ScaleHeight     =   330
      ScaleWidth      =   375
      TabIndex        =   7
      Top             =   6900
      Width           =   375
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   2835
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
            Picture         =   "BacinfMe.frx":18AA
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacinfMe.frx":1BC4
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacinfMe.frx":2018
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacinfMe.frx":2332
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin VB.Label Etiqueta 
      AutoSize        =   -1  'True
      Caption         =   "Permanente"
      Enabled         =   0   'False
      ForeColor       =   &H00800000&
      Height          =   225
      Index           =   7
      Left            =   2910
      TabIndex        =   12
      Top             =   6945
      Width           =   885
      WordWrap        =   -1  'True
   End
   Begin VB.Label Etiqueta 
      AutoSize        =   -1  'True
      Caption         =   "Transable"
      Enabled         =   0   'False
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   8
      Left            =   1725
      TabIndex        =   11
      Top             =   6975
      Width           =   810
      WordWrap        =   -1  'True
   End
End
Attribute VB_Name = "BacInfMercado"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim Sql As String
Dim DATOS()
Dim TCartera As String


Private Sub Cmd_Generar(Donde)
Dim Nombre_Rpt      As String: Nombre_Rpt = ""
Dim TipRep          As String
Dim Fecha           As String
Dim AuxTit          As String
Dim CDolar          As String
Dim DATOS()

On Error GoTo Control:

    Screen.MousePointer = vbHourglass
    
    Sql = "SP_FIN_DE_MES "
    Sql = Sql & "'" & Format(txtFecha.text, "yyyymmdd") & "'"
     
    If Not Bac_Sql_Execute(Sql) Then
        MsgBox "SQL no responde ", 16
        Exit Sub
    End If
    
    Do While Bac_SQL_Fetch(DATOS)
         Sw_Fin_De_Mes = DATOS(1)
    Loop
   
    Fecha = Format(txtFecha.text, feFECHA)

    xentidad = Val(Trim$(Right$(Combo1, 10)))


    If Donde = "Impresora" Then
        BacTrader.bacrpt.Destination = 0
    Else
        BacTrader.bacrpt.Destination = 1
    End If

    Dim Inf%, X%, MArca  As Boolean

    If ConCheck.Item(4).Visible = True Then
       CDolar = "S"
    Else
       CDolar = "N"
    End If
    
    
'=====================================================
' LD1_COR_035 , Tema: Reporte Valorización Anexo 6
' INICIO
'=====================================================
     For i = 0 To ConCheck.Count - 1
      
       If ConCheck.Item(i).Visible = True Then
   
           Select Case i
           
                 Case 7

                     Call Limpiar_Cristal

                     BacTrader.bacrpt.ReportFileName = RptList_Path & "Informe_TasaMercado.RPT"
                     
                     Call PROC_ESTABLECE_UBICACION(BacTrader.bacrpt.RetrieveDataFiles, BacTrader.bacrpt)
                     
                     BacTrader.bacrpt.StoredProcParam(0) = Format(txtFecha.text, "yyyymmdd")
                     BacTrader.bacrpt.Connect = CONECCION
                     BacTrader.bacrpt.Action = 1
   
                 Case 6
    
                     Call Limpiar_Cristal
                     BacTrader.bacrpt.ReportFileName = RptList_Path & "valormerc_fusion.RPT"
                     
                     Call PROC_ESTABLECE_UBICACION(BacTrader.bacrpt.RetrieveDataFiles, BacTrader.bacrpt)
                     
                     BacTrader.bacrpt.StoredProcParam(0) = "BTR"
                     BacTrader.bacrpt.StoredProcParam(1) = Format(txtFecha.text, "yyyymmdd")
                     BacTrader.bacrpt.StoredProcParam(2) = "T"
                     BacTrader.bacrpt.StoredProcParam(3) = "VALORIZACION DE MERCADO "
                     BacTrader.bacrpt.StoredProcParam(4) = "N"
                     BacTrader.bacrpt.Formulas(0) = "fecha ='" & Format(gsBac_Fecp, "dd/mm/yyyy") & "'"
                     BacTrader.bacrpt.Connect = CONECCION
                     BacTrader.bacrpt.Action = 1
   
                   
           End Select
       End If
   
   Next
   
'=====================================================
' LD1_COR_035 , Tema: Reporte Valorización Anexo 6
' FIN
'=====================================================
    
    
    nContador = IIf(Cmb_Cartera_Normativa.ListIndex > 0, 1, Cmb_Cartera_Normativa.ListCount - 1)
        
    For X = 1 To nContador
         
        AuxTit = ""
        TCartera = ""

        TCartera = Trim(Right(Cmb_Cartera_Normativa.List(IIf(nContador = 1, Cmb_Cartera_Normativa.ListIndex, X)), 10))
        AuxTit = Trim(Left(Cmb_Cartera_Normativa.List(IIf(nContador = 1, Cmb_Cartera_Normativa.ListIndex, X)), 50))
               
        If CDolar = "S" Then
           AuxTit = AuxTit & " EN DOLARES E ICP"
        End If
                
        Call Limpiar_Cristal
 
        TipRpt = "VALORIZACION DE MERCADO " & AuxTit
        
        BacTrader.bacrpt.ReportFileName = RptList_Path & "VALORMERC.RPT"
        
        Call PROC_ESTABLECE_UBICACION(BacTrader.bacrpt.RetrieveDataFiles, BacTrader.bacrpt)
        
        BacTrader.bacrpt.StoredProcParam(0) = "BTR"
        BacTrader.bacrpt.StoredProcParam(1) = Fecha
        BacTrader.bacrpt.StoredProcParam(2) = TCartera
        BacTrader.bacrpt.StoredProcParam(3) = TipRpt
        BacTrader.bacrpt.StoredProcParam(4) = CDolar
        BacTrader.bacrpt.Connect = CONECCION
        BacTrader.bacrpt.Action = 1
    Next X



   

                
                    
                    
''''    If ConCheck.Item(5).Visible = True And Sw_Fin_De_Mes <> 1 Then
''''
''''       nContador = IIf(Cmb_Cartera_Normativa.ListIndex > 0, 1, Cmb_Cartera_Normativa.ListCount - 1)
''''
''''        For x = 1 To nContador 'inf
''''
''''            AuxTit = ""
''''            TCartera = ""
''''
''''            TCartera = Trim(Right(Cmb_Cartera_Normativa.List(IIf(nContador = 1, Cmb_Cartera_Normativa.ListIndex, x)), 10))
''''            AuxTit = Trim(Left(Cmb_Cartera_Normativa.List(IIf(nContador = 1, Cmb_Cartera_Normativa.ListIndex, x)), 50))
''''
''''            If CDolar = "S" Then
''''               AuxTit = AuxTit & " EN DOLARES"
''''            End If
''''
''''            Call Limpiar_Cristal
''''
''''            TipRpt = "VALORIZACION DE MERCADO DIARIA " & AuxTit
''''
''''            BacTrader.bacrpt.ReportFileName = RptList_Path & "VALORMERC_DIARIA.RPT"
''''
''''            Call PROC_ESTABLECE_UBICACION(BacTrader.bacrpt.RetrieveDataFiles, BacTrader.bacrpt)
''''
''''            BacTrader.bacrpt.StoredProcParam(0) = "BTR"
''''            BacTrader.bacrpt.StoredProcParam(1) = Fecha
''''            BacTrader.bacrpt.StoredProcParam(2) = TCartera
''''            BacTrader.bacrpt.StoredProcParam(3) = TipRpt
''''            BacTrader.bacrpt.StoredProcParam(4) = CDolar
''''            BacTrader.bacrpt.Connect = CONECCION
''''            BacTrader.bacrpt.Action = 1
''''        Next x
''''    End If

    Screen.MousePointer = vbDefault
    Exit Sub

Control:
    MsgBox "Problemas al generar Listado de Cartera. " & err.Description & ", " & err.Number, vbCritical, "BACTRADER"
    Screen.MousePointer = vbDefault
    
End Sub
Function BacProxHabil(xFecha As String) As String
Dim gsc_fechadma As String
    Dim dFecha As String
    
   dFecha = xFecha
   dFecha = Format(DateAdd("d", 1, dFecha), gsc_fechadma)

   Do While Not BacEsHabil(dFecha)
      dFecha = Format(DateAdd("d", 1, dFecha), gsc_fechadma)

   Loop

   BacProxHabil = dFecha


End Function



Private Sub Cmd_Salir_Click()
Unload Me
End Sub

Private Sub ConCheck_Click(Index As Integer)

SinCheck.Item(Index).Visible = Not SinCheck.Item(Index).Visible
ConCheck.Item(Index).Visible = Not ConCheck.Item(Index).Visible

End Sub



Private Sub Form_Load()
Dim X As Integer
Dim FecNueva As String
Dim Sql As String
    
    Me.Top = 0
    Me.Left = 0
    Me.Icon = BacTrader.Icon


    Screen.MousePointer = vbHourglass
    giAceptar% = False

    Combo1.Clear
'    Sql = "SP_LEER_ENTIDADES"

    If Bac_Sql_Execute("SP_LEER_ENTIDADES") Then
        Combo1.AddItem "TODAS LAS ENTIDADES                                                 "
        Do While Bac_SQL_Fetch(DATOS())
            Combo1.AddItem DATOS(1) & Space(50 + (30 - Len(DATOS(1)))) & Str(DATOS(2))
        Loop
    Else
        MsgBox "Proceso " & Sql & "no existe", vbOKOnly + vbCritical, "Entidades"
        Unload Me
    End If
        
    ' verifica si es fin de mes
    Sql = "SP_FIN_DE_MES "
    Sql = Sql & "'" & Format(txtFecha.text, "yyyymmdd") & "'"
    
    If Not Bac_Sql_Execute(Sql) Then
        MsgBox "SQL no responde ", 16
        Exit Sub
    End If
    
    Do While Bac_SQL_Fetch(DATOS)
        Sw_Fin_De_Mes = DATOS(1)
    Loop
    
    If Month(gsBac_Fecp) <> Month(gsBac_Fecx) Then
        txtFecha.text = Format(DateAdd("d", -1, CDate("01/" + Str(Month(gsBac_Fecx)) + "/" + Str(Year(gsBac_Fecx)))), "dd/mm/yyyy")
    Else
        txtFecha.text = Format(gsBac_Fecp, "dd/mm/yyyy")
    End If
            
        
    Combo1.ListIndex = 0
    
    Call PROC_LLENA_COMBOS(Cmb_Cartera_Normativa, 3, True, GLB_CARTERA_NORMATIVA, GLB_ID_SISTEMA)
    

   Screen.MousePointer = vbDefault


End Sub


Private Sub SinCheck_Click(Index As Integer)
    ConCheck.Item(Index).Left = SinCheck.Item(Index).Left
    SinCheck.Item(Index).Visible = Not SinCheck.Item(Index).Visible
    ConCheck.Item(Index).Visible = Not ConCheck.Item(Index).Visible
End Sub


Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

    Select Case Button.Index
        Case 1
            Call Cmd_Generar("Impresora")
        
        Case 2
            Call Cmd_Generar("Pantalla")
    
        Case 3
            Call Exporta_Excel

        Case 4
            Unload Me

    End Select

End Sub

Function Exporta_Excel()
    Dim Linea       As String
    Dim Arr()
    Dim j           As Double
    Dim i           As Double
    Dim Exc
    Dim Hoja
    Dim S           As Integer
    Dim Sheet
    Dim Ruta        As String
    Dim Crea_xls    As Boolean
    Dim retorno     As Double

    Const Filas_Buffer = 2500 '150

    Screen.MousePointer = vbHourglass

    If MsgBox("¿ Seguro que desea generar la planilla excel para las tasas de mercado ?", vbQuestion + vbYesNo) = vbNo Then
        Screen.MousePointer = vbDefault
        Exit Function
    End If
        

    Ruta = gsBac_DIREXEL & "tasamer" & Format(txtFecha.text, "mmdd") & ".xls" ' NOMBRE 'ruta del .XLS
        
    DoEvents
    
    Sql = "SP_FIN_DE_MES "
    Sql = Sql & "'" & Format(txtFecha.text, "yyyymmdd") & "'"

    If Not Bac_Sql_Execute(Sql) Then
        MsgBox "SQL no responde ", 16
        Exit Function
    End If
    
    Do While Bac_SQL_Fetch(DATOS)
        Sw_Fin_De_Mes = DATOS(1)
    Loop

''''    If Sw_Fin_De_Mes = 1 Then                           'Si
            Sql = "SP_SBIF_LEERMDTM1 " & "'BTR'," & "'" & Format(txtFecha.text, "yyyymmdd") & "'"
''''    Else
''''            Sql = "SP_SBIF_LEERMDTM1_DIARIA " & "'BTR'," & "'" & Format(TXTFecha.Text, "yyyymmdd") & "'"       'No
''''    End If


    If Not Bac_Sql_Execute(Sql) Then MsgBox "No se pudo generar Planilla", vbCritical, gsBac_Version: Screen.MousePointer = vbDefault: Exit Function

    Set Exc = CreateObject("Excel.Application")
    Set Hoja = Exc.Application.Workbooks.Add.Sheets.Add
    Set Sheet = Exc.ActiveSheet
    
    Linea = ""
    
''''    If Sw_Fin_De_Mes = 0 Then
''''        Linea = Linea & "Serie" & vbTab
''''        Linea = Linea & "Emisor" & vbTab
''''        Linea = Linea & "Fecha Vcto" & vbTab
''''        Linea = Linea & "Tasa mercado" & vbTab
''''        Linea = Linea & "Tasa Market" & vbTab
''''        Linea = Linea & "Tasa Market2" & vbTab
''''        Linea = Linea & "Tasa Market3" & vbTab
''''        Linea = Linea & "Rut Emisor" & vbTab
''''        Linea = Linea & "codigo" & vbTab
''''        Linea = Linea & "codigo moneda" & vbTab
''''        Linea = Linea & "valor nominal" & vbTab
''''        Linea = Linea & "rut cartera" & vbTab
''''        Linea = Linea & "fecha compra" & vbTab
''''    Else
        Linea = Linea & "Serie" & vbTab
        Linea = Linea & "Emisor" & vbTab
        Linea = Linea & "Fecha Vcto" & vbTab
        Linea = Linea & "Tasa mercado" & vbTab
        Linea = Linea & "Tasa Market" & vbTab
        Linea = Linea & "Tasa Market2" & vbTab
        Linea = Linea & "Tasa Market3" & vbTab
        Linea = Linea & "Rut Emisor" & vbTab
        Linea = Linea & "codigo" & vbTab
        Linea = Linea & "codigo moneda" & vbTab
        Linea = Linea & "valor nominal" & vbTab
        Linea = Linea & "rut cartera" & vbTab
''''    End If

    Clipboard.Clear
    Clipboard.SetText Linea
    Sheet.Range("A1").Select
    Sheet.Paste
    Linea = ""
    Clipboard.Clear

    i = 1
    
    Do While Bac_SQL_Fetch(Arr())
        If i = 995 Then
            i = i
        End If
    
        For j = 1 To 13
            If (j >= 1 And j < 3) Or (j > 3 And j < 13) Then
                Linea = Linea & BacStrTran(IIf(Trim(Arr(j)) = "", 0, Trim(Arr(j))), ",", ".") & vbTab
            Else
                If j = 3 Then
                    Linea = Linea & Format(IIf(Trim(Arr(j)) = "", "01/01/1900", Trim(Arr(j))), "mm/dd/yyyy") & vbTab
                End If
                
                If j = 6 Then
                    Linea = Linea & BacStrTran(IIf(Trim(Arr(j)) = "", 0, Trim(Arr(j))), ",", ".") & vbTab
                End If
                
'                If Sw_Fin_De_Mes = 0 Then
'                    If J = 13 Then
'                        Linea = Linea & Format(IIf(Trim(Arr(J)) = "", "01/01/1900", Trim(Arr(J))), "mm/dd/yyyy") & vbTab
'                    End If
'                End If
            End If
        Next j
        
        Linea = Linea + vbCrLf
        
        If i Mod Filas_Buffer = 0 Then
            Clipboard.Clear
            Clipboard.SetText Linea
            
            If i = Filas_Buffer Then
                Sheet.Range("A2").Select
            Else
                Sheet.Range("A" & CStr((i + 1) - Filas_Buffer)).Select
            End If
            
            Sheet.Paste
            Linea = ""
        End If

        Crea_xls = True
        i = i + 1
    Loop
    
    Clipboard.Clear
    Clipboard.SetText Linea
    Sheet.Range("A" & CStr((Int(i / Filas_Buffer) * Filas_Buffer) + IIf(i > Filas_Buffer, 1, 2))).Select
    Sheet.Paste
    Linea = ""
    Clipboard.Clear

    Sheet.Range("A1").Select

    Hoja.Application.DisplayAlerts = False
    
    For i = 2 To Hoja.Application.Sheets.Count
        Hoja.Application.Sheets(2).Delete
    Next i

    If Crea_xls Then
        Hoja.SaveAs (Ruta)
    Else
        Hoja.Application.Workbooks.Close
        MousePointer = vbDefault
        MsgBox "No se encontró Información para generar el Excel", vbExclamation, gsBac_Version
        Exit Function
    End If
    
    Hoja.Application.Workbooks.Close
    
    Screen.MousePointer = vbDefault
    MsgBox "El archivo excel con las tasas de mercado ha sido generado con exito", vbInformation, gsBac_Version

    Set Hoja = Nothing
    Set Exc = Nothing
    Set Sheet = Nothing
    
    retorno = Shell(gsBac_Office & "EXCEL.EXE  " & Ruta, vbMaximizedFocus)

    ConCheck_Click 0

End Function

