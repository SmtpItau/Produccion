VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.2#0"; "mscomctl.ocx"
Begin VB.Form Contabilizacion_Automatica 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Contabilización Automática"
   ClientHeight    =   1575
   ClientLeft      =   1875
   ClientTop       =   3015
   ClientWidth     =   5085
   Icon            =   "Con_auto.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   1575
   ScaleWidth      =   5085
   ShowInTaskbar   =   0   'False
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   2
      Top             =   0
      Width           =   5085
      _ExtentX        =   8969
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmbcontab"
            Description     =   "CONTABILIZAR"
            Object.ToolTipText     =   "Contabilizar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmbsalir"
            Description     =   "SALIR"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   4620
      Top             =   1905
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   2
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Con_auto.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Con_auto.frx":075C
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin Threed.SSPanel SSPanel5 
      Height          =   1050
      Left            =   15
      TabIndex        =   0
      Top             =   525
      Width           =   5055
      _Version        =   65536
      _ExtentX        =   8916
      _ExtentY        =   1852
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
      Begin MSComctlLib.ProgressBar Barra 
         DragMode        =   1  'Automatic
         Height          =   360
         Left            =   105
         TabIndex        =   5
         Top             =   450
         Visible         =   0   'False
         Width           =   4830
         _ExtentX        =   8520
         _ExtentY        =   635
         _Version        =   393216
         Appearance      =   0
         Min             =   1
         Max             =   10000
         Scrolling       =   1
      End
      Begin VB.Label Lbl_Msg 
         Alignment       =   2  'Center
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C00000&
         Height          =   690
         Left            =   75
         TabIndex        =   1
         Top             =   150
         Width           =   4890
      End
   End
   Begin Threed.SSCommand Cmd_Aceptar 
      Height          =   450
      Left            =   60
      TabIndex        =   3
      Top             =   2805
      Width           =   1200
      _Version        =   65536
      _ExtentX        =   2117
      _ExtentY        =   794
      _StockProps     =   78
      Caption         =   "&Contabilizar"
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
   End
   Begin Threed.SSCommand Cmd_Cancelar 
      Height          =   450
      Left            =   1290
      TabIndex        =   4
      Top             =   2805
      Width           =   1200
      _Version        =   65536
      _ExtentX        =   2117
      _ExtentY        =   794
      _StockProps     =   78
      Caption         =   "&Salir"
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
   End
End
Attribute VB_Name = "Contabilizacion_Automatica"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim gsBac_FM             As Date

Sub PROC_CONTABILIZA()
Dim Datos()
Dim Comando$
Dim cLine As String
Dim cNomArchivo As String
Dim cDia As String
Dim total_haber As Double
Dim total_debe As Double
Dim total_registro As Double
Dim SW As Integer

    Screen.MousePointer = vbHourglass

    SW = 0
    Lbl_Msg.Caption = "Contabilizando...Por favor espere..."
    Lbl_Msg.Refresh
    
    
    If Not Bac_Sql_Execute("SP_BUSCADOR_DE_CUENTAS") Then
        MsgBox "Proceso de actualizacion de cuenta contables no realizado, No afecta la contabilidad", vbCritical
    End If

    Envia = Array(Format(gsBac_Fecp, "yyyymmdd"))

    If Not Bac_Sql_Execute("SP_CONTABILIZACION", Envia) Then
        Lbl_Msg.Caption = "Proceso NO Realizado"
        Screen.MousePointer = 0
        Exit Sub
    End If

    Do While Bac_SQL_Fetch(Datos())
        If Datos(1) <> "SI" Then
            Lbl_Msg.Caption = "NO"
            SW = 1   ' no realiza intefaz
            Screen.MousePointer = vbDefault
        End If
    Loop

    If Lbl_Msg.Caption = "NO" Then
        Lbl_Msg.Caption = "Proceso NO Terminado."
        Envia = Array(Format(gsBac_Fecp, "yyyymmdd"))

        If Not Bac_Sql_Execute("SP_CONTAERROR", Envia) Then
            Lbl_Msg.Caption = "Error en Control de Errores"
            Screen.MousePointer = vbDefault
            Exit Sub
        End If

        Do While Bac_SQL_Fetch(Datos())
            If Not IsNull(Datos(1)) Then
                MsgBox Datos(1), 16, Me.Caption
            End If
        Loop
    End If

    Valor_antiguo = " "
    Valor_antiguo = "Fecha de Contabilización =" & gsBac_Fecp
   
   '************************************************'
   '****** GENERANDO INTERFAZ CONTABLE TRADER ******'
   '********** Modificación 14 Junio 2006 **********'

'    If SW = 0 Then
'
'        Lbl_Msg.Caption = "Generando Interfaz Contable..."
'
'        If Trim(gsBac_DIRCONTA) = "" Then
'            Screen.MousePointer = vbDefault
'            Lbl_Msg.Caption = "Interfaz Contable No Generada..."
'            MsgBox "No se ha especificado una PATH para generar la interfaz contable" + vbCrLf + vbCrLf + "Por favor comuniquese con el administrador de sistema", vbExclamation, "INTERFAZ CONTABLE"
'            Exit Sub
'        End If
'
'        cDia = Format(gsBac_Fecp, "yymmdd")
'        cNomArchivo = gsBac_DIRCONTA & "GL15" & cDia & ".DAT"
'
'        total_registro = 0
'        total_haber = 0
'        total_debe = 0
'
'        Barra.Visible = True
'        Barra.Min = 0
'        Barra.Value = 0
'
'        If Bac_Sql_Execute("SP_INTER_CONTABLE_TRADER") Then
'            If Dir(cNomArchivo) <> "" Then
'                Kill cNomArchivo
'            End If
'
'            Open cNomArchivo For Output As #1
'
'            Do While Bac_SQL_Fetch(Datos())
'                BacControlWindows 12
'
'                total_registro = total_registro + 1
'                total_debe = total_debe + CDbl(Datos(12))
'                total_haber = total_haber + CDbl(Datos(19))
'
'                If total_registro = 1 Then
'                   Barra.Max = Val(Datos(27))
'                End If
'
'                Barra.Value = Barra.Value + 1
'
'                cLine = ""
'                cLine = cLine & Datos(1)
'                cLine = cLine & Datos(2)
'                cLine = cLine & Datos(3)
'                cLine = cLine & Datos(4)
'                cLine = cLine & Datos(5)
'                cLine = cLine & Datos(6)
'                cLine = cLine & Datos(7)
'                cLine = cLine & Datos(8)
'                cLine = cLine & Datos(9)
'                cLine = cLine & Datos(10)
'                cLine = cLine & Datos(11)
'                cLine = cLine & Datos(12)
'                cLine = cLine & Datos(13)
'                cLine = cLine & Datos(14)
'                cLine = cLine & Datos(15)
'                cLine = cLine & Datos(16)
'                cLine = cLine & Datos(17)
'                cLine = cLine & Datos(18)
'                cLine = cLine & Datos(19)
'                cLine = cLine & Datos(20)
'                cLine = cLine & Datos(21)
'                cLine = cLine & Datos(22)
'                cLine = cLine & Datos(23)
'                cLine = cLine & Datos(24)
'                cLine = cLine & Datos(25)
'                cLine = cLine & Datos(26)
'
'                Print #1, cLine
'            Loop
'
'            Close #1
'
'            If Round(total_debe, 4) <> Round(total_haber, 4) Then
'                MsgBox "El archivo " & cNomArchivo & " Descuadrado", vbCritical
'            End If
'
'''''            If Not Enviar_por_ftp(gsBac_DIRCONTA, cNomArchivo) Then
'''''                MsgBox "Interfaz " & cNomArchivo & "  via FTP no fue traspasada ", vbCritical
'''''            End If
'        Else
'            MsgBox "Ha ocurrido un error al intentar generar la interfaz " & " " & cNomArchivo, vbOKOnly + vbCritical, "MENSAJE"
'        End If
'
'        Barra.Value = 0
'        Barra.Visible = False
'        Lbl_Msg.Caption = "¡ Proceso Terminado Correctamente. !"
'
'
'        ''************************************************************************************
'        '' Archivo CO + (YY+DD+MM).
'        cDia = Format(gsBac_Fecp, "yyddmm")
'        cNomArchivo = gsBac_DIRCONTA & "CO" & cDia
'
'        cLine = ""
'        cLine = Format(gsBac_Fecp, "yyyymmdd") & Format(total_registro, "0000000") & Format(total_debe, "0000000000000000") & Format(total_haber, "0000000000000000")
'
'        If Dir(cNomArchivo) <> "" Then
'            Kill cNomArchivo
'        End If
'
'        Open cNomArchivo For Binary Access Write As #1
'        Put #1, , cLine
'        Close #1
'
'    End If
    
    
    
    If SW = 0 Then

        Lbl_Msg.Caption = "Generando Interfaz Contable..."
        cDia = Format(gsBac_Fecp, "yymmdd")
        cNomArchivo = gsBac_DIRCONTA & "GL15" & cDia & ".DAT"
        If Dir(cNomArchivo) <> "" Then
            Kill cNomArchivo
        End If
        Open cNomArchivo For Output As #1
        Close #1
        cNomArchivo = gsBac_DIRCONTA & "CO" & cDia
        If Dir(cNomArchivo) <> "" Then
            Kill cNomArchivo
        End If
        Open cNomArchivo For Binary Access Write As #1
        Close #1
    
        cNomArchivo = gsBac_DIRCONTA & "GL50" & cDia & ".DAT"
        If Dir(cNomArchivo) <> "" Then
            Kill cNomArchivo
        End If
        Open cNomArchivo For Output As #1
        Close #1
        
        cNomArchivo = gsBac_DIRCONTA & "GL51" & cDia & ".DAT"
        If Dir(cNomArchivo) <> "" Then
            Kill cNomArchivo
        End If
        Open cNomArchivo For Output As #1
        Close #1
    
        cNomArchivo = gsBac_DIRCONTA & "GL52" & cDia & ".DAT"
        If Dir(cNomArchivo) <> "" Then
            Kill cNomArchivo
        End If
        Open cNomArchivo For Output As #1
        Close #1
    
    
        Call Contable_Desacople(cNomArchivo)
    
    End If
    
    Call GRABA_LOG_AUDITORIA(1, gsBac_Fecp, gsBac_IP, gsBac_User, _
         "BTR", "Opc_40100", "01", "Contabilidad", "bac_cnt_contabiliza", Valor_antiguo, " ")
    
    Screen.MousePointer = vbDefault

End Sub

Private Sub Cmd_Aceptar_Click()

'If MsgBox("Seguro de Contabilizar ?", 36, gsBac_Version) <> 6 Then Exit Sub
'
'PROC_CONTABILIZA

End Sub


Private Sub Cmd_cancelar_Click()

'Unload Me

End Sub
Sub Trampa()
Dim i%, ii%, iii%

   Screen.MousePointer = 11
   Lbl_Msg.Caption = "Contabilizando..."
   BacControlWindows 100
   Lbl_Msg.Refresh
   Barra.Visible = True
   For i% = 1 To 10000
      For ii% = 1 To 1000
         If i = 7000 Then
            For iii% = 0 To 10000
               
            Next iii%
            'i% = 9000
         End If
      Next ii%
   Barra.Value = i
   Next i

   Lbl_Msg.Caption = "Perfil contable no definidos" & Chr(10) _
   & "Contabilización no Terminada..."
   Barra.Visible = False
   Screen.MousePointer = 0
End Sub

Private Sub Form_Activate()
Dim Datos()



    gsBac_FM = CDate("01/" + Str(Month(gsBac_Fecp)) + "/" + Str(Year(gsBac_Fecp)))
    gsBac_FM = DateAdd("m", 1, gsBac_FM)
    gsBac_FM = DateAdd("d", -1, gsBac_FM)


If gsBac_Fecp <> gsBac_FM And gsBac_Fecx > gsBac_FM Then

 If Bac_Sql_Execute("SP_CHKFECHASDEVENGAMIENTO") Then
        Do While Bac_SQL_Fetch(Datos())
            swDevengo = Datos(7)
            If Datos(7) <> "1" Or Datos(8) <> "1" Or Datos(9) <> "1" Or Datos(10) <> "1" Then
                MsgBox "Fin de mes Especial Debe devengar antes de Contabilizar", vbCritical
                Unload Me
            End If
        Loop
 End If
End If


End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

Select Case UCase(Button.Description)
    Case "CONTABILIZAR"
        If MsgBox("Seguro de Contabilizar ?", 36, gsBac_Version) <> 6 Then Exit Sub
        'Call Trampa
        Call PROC_CONTABILIZA
    Case "SALIR"
        Unload Me
End Select
End Sub
