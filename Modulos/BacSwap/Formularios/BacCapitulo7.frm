VERSION 5.00
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.3#0"; "Comctl32.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{05BDEB52-1755-11D5-9109-000102BF881D}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacCapituloVII 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Informe Capítulo VII Anexo 4"
   ClientHeight    =   2355
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   6900
   Icon            =   "BacCapitulo7.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   2355
   ScaleWidth      =   6900
   ShowInTaskbar   =   0   'False
   Begin ComctlLib.Toolbar Toolbar1 
      Height          =   510
      Left            =   60
      TabIndex        =   0
      Top             =   0
      Width           =   6825
      _ExtentX        =   12039
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   327682
      BeginProperty Buttons {0713E452-850A-101B-AFC0-4210102A8DA7} 
         NumButtons      =   2
         BeginProperty Button1 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Key             =   ""
            Object.ToolTipText     =   "Imprimir"
            Object.Tag             =   ""
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Key             =   ""
            Object.ToolTipText     =   "Salir"
            Object.Tag             =   ""
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin Threed.SSPanel SSPanel1 
      Height          =   1815
      Left            =   30
      TabIndex        =   1
      Top             =   525
      Width           =   6840
      _Version        =   65536
      _ExtentX        =   12065
      _ExtentY        =   3201
      _StockProps     =   15
      BackColor       =   12632256
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin VB.Frame Frame1 
         BorderStyle     =   0  'None
         Height          =   1725
         Index           =   0
         Left            =   75
         TabIndex        =   2
         Top             =   15
         Width           =   6510
         Begin VB.Frame Frame1 
            BeginProperty Font 
               Name            =   "Times New Roman"
               Size            =   9
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   1200
            Index           =   1
            Left            =   75
            TabIndex        =   6
            Top             =   420
            Width           =   6390
            Begin VB.ComboBox cmbRepBco1 
               BackColor       =   &H00E0E0E0&
               ForeColor       =   &H00800000&
               Height          =   315
               Left            =   1620
               Style           =   2  'Dropdown List
               TabIndex        =   7
               Top             =   765
               Width           =   3075
            End
            Begin VB.Label txtRutRepBco1 
               BackColor       =   &H00E0E0E0&
               BorderStyle     =   1  'Fixed Single
               ForeColor       =   &H00800000&
               Height          =   315
               Left            =   4770
               TabIndex        =   11
               Top             =   765
               Width           =   1140
            End
            Begin VB.Label txtEntidad 
               BackColor       =   &H00E0E0E0&
               BorderStyle     =   1  'Fixed Single
               ForeColor       =   &H00800000&
               Height          =   330
               Left            =   315
               MouseIcon       =   "BacCapitulo7.frx":000C
               TabIndex        =   10
               Top             =   405
               Width           =   5595
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
               ForeColor       =   &H00800000&
               Height          =   225
               Index           =   5
               Left            =   330
               TabIndex        =   9
               Top             =   165
               Width           =   735
            End
            Begin VB.Label lblEtiqueta 
               AutoSize        =   -1  'True
               Caption         =   "Representantes"
               BeginProperty Font 
                  Name            =   "Times New Roman"
                  Size            =   9
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00800000&
               Height          =   225
               Index           =   0
               Left            =   105
               TabIndex        =   8
               Top             =   825
               Width           =   1215
            End
         End
         Begin VB.CommandButton btnSalir 
            Caption         =   "&Salir"
            BeginProperty Font 
               Name            =   "Times New Roman"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   825
            Left            =   5400
            Picture         =   "BacCapitulo7.frx":015E
            Style           =   1  'Graphical
            TabIndex        =   5
            ToolTipText     =   "Salir Pantalla"
            Top             =   2475
            Visible         =   0   'False
            Width           =   1095
         End
         Begin VB.CommandButton btnInforme 
            Caption         =   "&Impresora"
            BeginProperty Font 
               Name            =   "Times New Roman"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   825
            Left            =   4200
            Picture         =   "BacCapitulo7.frx":0468
            Style           =   1  'Graphical
            TabIndex        =   4
            ToolTipText     =   "Informe directo a Impresora"
            Top             =   2475
            Visible         =   0   'False
            Width           =   1080
         End
         Begin BacControles.txtFecha txtFechainf 
            Height          =   285
            Left            =   2520
            TabIndex        =   3
            Top             =   135
            Width           =   1335
            _ExtentX        =   2355
            _ExtentY        =   503
            Text            =   "25/10/2000"
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   8388608
            MinDate         =   -328716
            MaxDate         =   2958465
         End
         Begin VB.Label Label1 
            Caption         =   "Fecha"
            BeginProperty Font 
               Name            =   "Times New Roman"
               Size            =   9
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   255
            Left            =   1905
            TabIndex        =   14
            Top             =   150
            Width           =   555
         End
         Begin VB.Label Label2 
            Caption         =   "Día NO Hábil"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H000000FF&
            Height          =   255
            Left            =   3990
            TabIndex        =   13
            Top             =   135
            Visible         =   0   'False
            Width           =   1665
         End
         Begin VB.Label LBLIMPRE 
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   9.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H000000C0&
            Height          =   495
            Left            =   480
            TabIndex        =   12
            Top             =   2520
            Width           =   3495
         End
      End
   End
   Begin ComctlLib.ImageList ImageList1 
      Left            =   4560
      Top             =   135
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   327682
      BeginProperty Images {0713E8C2-850A-101B-AFC0-4210102A8DA7} 
         NumListImages   =   2
         BeginProperty ListImage1 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "BacCapitulo7.frx":0772
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "BacCapitulo7.frx":0A8C
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "BacCapituloVII"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Function ValidaFechainf()
    
    If Not BacEsHabil(txtFechainf.Text) Then
        txtFechainf.ForeColor = &HC0&
        btnInforme.Enabled = False
        Label2.Visible = True
        
    Else
        txtFechainf.ForeColor = &HC00000
        btnInforme.Enabled = True
        Label2.Visible = False
    End If
    
End Function

Private Sub btnInforme_Click()
Dim i%

    On Error GoTo errores:
    
    Screen.MousePointer = 11
    
    Call BacLimpiaParamCrw
    
    For i = 1 To 2
        
        With BACSwap.Crystal
            
            .ReportFileName = gsRPT_Path & "BacCapituloVII.rpt"
            .WindowTitle = "CAPITULO VII ANEXO 4"
            .Destination = crptToPrinter
            .StoredProcParam(0) = Format(txtFechainf.Text, "YYYYMMDD") ' FECHA CIERRE
            .StoredProcParam(1) = txtRutRepBco1.Tag  ' RUT APODERADO
            .StoredProcParam(2) = gsBAC_Rut 'RUT BANCO
            
            If i = 1 Then
               .StoredProcParam(3) = "I"   ' INGRESO
            Else
               .StoredProcParam(3) = "M"   ' MODIFICACION
            End If
            
            .Connect = swConeccion
            .Action = 1
        
        End With
    Next
    
    LBLIMPRE.Caption = "Informe enviado a Impresora!!"
    
        For m = 1 To 100000
              DoEvents
        Next
    
    LBLIMPRE.Caption = ""
    Screen.MousePointer = 0
    
    Exit Sub

errores:
        Screen.MousePointer = 0
        MsgBox Error(Err), vbExclamation
Exit Sub

End Sub

Private Sub btnSalir_Click()
Unload Me
End Sub

Private Sub cmbRepBco1_Click()
                
        If cmbRepBco1.ListIndex <> -1 Then
          txtRutRepBco1.Tag = cmbRepBco1.ItemData(cmbRepBco1.ListIndex)
          txtRutRepBco1.Tag = txtRutRepBco1.Tag & "-" & Trim(Right(cmbRepBco1.List(cmbRepBco1.ListIndex), 10))
          txtRutRepBco1.Caption = txtRutRepBco1.Tag
       End If
       
End Sub


Private Sub Form_Activate()
Dim objCliente As New clsCliente

    txtFechainf.MaxDate = gsBAC_Fecp
    
    txtFechainf.Text = gsBAC_Fecp
    
    txtEntidad = gsBAC_Clien

    cmbRepBco1.Clear
    
    If objCliente.CargaApoderados(cmbRepBco1, Val(gsBAC_Rut), Val(gsBAC_Codigo)) Then
        cmbRepBco1.ListIndex = 0
     
    Else
        btnInforme.Enabled = False
        MsgBox "Entidad No tiene Representantes ingresados", vbCritical, Msj
    End If
    
    Set objCliente = Nothing

End Sub

Private Sub Form_Load()
Me.Icon = BACSwap.Icon
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As ComctlLib.Button)
Select Case Button.Index
  Case 1
     Dim i%

     On Error GoTo errores:
    
     Screen.MousePointer = 11
    
     Call BacLimpiaParamCrw
    
     For i = 1 To 2
        
        With BACSwap.Crystal
            
            .ReportFileName = gsRPT_Path & "BacCapituloVII.rpt"
            .WindowTitle = "CAPITULO VII ANEXO 4"
            .Destination = crptToPrinter
            .StoredProcParam(0) = Format(txtFechainf.Text, "YYYYMMDD") ' FECHA CIERRE
            .StoredProcParam(1) = Mid(txtRutRepBco1.Tag, 1, Len(txtRutRepBco1.Tag) - 2) ' RUT APODERADO
            .StoredProcParam(2) = gsBAC_Rut 'RUT BANCO
            
            If i = 1 Then
               .StoredProcParam(3) = "I"   ' INGRESO
            Else
               .StoredProcParam(3) = "M"   ' MODIFICACION
            End If
            
            .Connect = swConeccion
            .Action = 1
        
        End With
     Next
    
     LBLIMPRE.Caption = "Informe enviado a Impresora!!"
    
        For m = 1 To 100000
              DoEvents
        Next
    
     LBLIMPRE.Caption = ""
     Screen.MousePointer = 0
    
    Exit Sub

errores:
        Screen.MousePointer = 0
        MsgBox Error(Err), vbExclamation
Exit Sub
Case 2
   Unload Me
End Select
End Sub

Private Sub txtFechainf_Change()
Call ValidaFechainf
End Sub

Private Sub txtFechainf_LostFocus()
    
    If txtFechainf.Text > gsBAC_Fecp Then
        MsgBox "Fecha no puede ser mayor a fecha de proceso!", vbInformation, Msj
        txtFechainf.Text = gsBAC_Fecp
        txtFechainf.SetFocus
        Exit Sub
    End If
    
End Sub


