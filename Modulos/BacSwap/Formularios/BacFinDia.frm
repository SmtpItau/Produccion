VERSION 5.00
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.3#0"; "comctl32.ocx"
Begin VB.Form BacFinDia 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Fin de Día"
   ClientHeight    =   4080
   ClientLeft      =   150
   ClientTop       =   435
   ClientWidth     =   5880
   FillStyle       =   0  'Solid
   Icon            =   "BacFinDia.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   4080
   ScaleWidth      =   5880
   Begin ComctlLib.Toolbar Toolbar1 
      Height          =   480
      Left            =   0
      TabIndex        =   21
      Top             =   0
      Width           =   5850
      _ExtentX        =   10319
      _ExtentY        =   847
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
            Object.ToolTipText     =   "Procesar"
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
   End
   Begin VB.CommandButton btnProcesar 
      Caption         =   "&Procesar"
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   9
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   800
      Left            =   3120
      Picture         =   "BacFinDia.frx":0442
      Style           =   1  'Graphical
      TabIndex        =   19
      Top             =   5805
      Visible         =   0   'False
      Width           =   1300
   End
   Begin VB.CommandButton btnSalir 
      Caption         =   "&Salir"
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   9
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   800
      Left            =   4455
      Picture         =   "BacFinDia.frx":0884
      Style           =   1  'Graphical
      TabIndex        =   18
      Top             =   5805
      Visible         =   0   'False
      Width           =   1300
   End
   Begin VB.Frame Frame3 
      Caption         =   "Procesos"
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   11.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   2580
      Left            =   0
      TabIndex        =   2
      Top             =   1455
      Width           =   5865
      Begin VB.PictureBox ConCheck 
         BorderStyle     =   0  'None
         Height          =   330
         Index           =   4
         Left            =   1350
         Picture         =   "BacFinDia.frx":0B8E
         ScaleHeight     =   330
         ScaleWidth      =   330
         TabIndex        =   13
         Top             =   1935
         Width           =   330
      End
      Begin VB.PictureBox ConCheck 
         BorderStyle     =   0  'None
         Height          =   330
         Index           =   3
         Left            =   1350
         Picture         =   "BacFinDia.frx":0CE8
         ScaleHeight     =   330
         ScaleWidth      =   330
         TabIndex        =   12
         Top             =   1530
         Width           =   330
      End
      Begin VB.PictureBox ConCheck 
         BorderStyle     =   0  'None
         Height          =   330
         Index           =   2
         Left            =   1350
         Picture         =   "BacFinDia.frx":0E42
         ScaleHeight     =   330
         ScaleWidth      =   330
         TabIndex        =   11
         Top             =   1125
         Width           =   330
      End
      Begin VB.PictureBox ConCheck 
         BorderStyle     =   0  'None
         Height          =   330
         Index           =   1
         Left            =   1350
         Picture         =   "BacFinDia.frx":0F9C
         ScaleHeight     =   330
         ScaleWidth      =   330
         TabIndex        =   10
         Top             =   720
         Width           =   330
      End
      Begin VB.PictureBox SinCheck 
         BorderStyle     =   0  'None
         Height          =   330
         Index           =   2
         Left            =   1350
         Picture         =   "BacFinDia.frx":10F6
         ScaleHeight     =   330
         ScaleWidth      =   375
         TabIndex        =   9
         Top             =   1125
         Width           =   375
      End
      Begin VB.PictureBox SinCheck 
         BorderStyle     =   0  'None
         Height          =   330
         Index           =   4
         Left            =   1350
         Picture         =   "BacFinDia.frx":1250
         ScaleHeight     =   330
         ScaleWidth      =   375
         TabIndex        =   8
         Top             =   1935
         Width           =   375
      End
      Begin VB.PictureBox SinCheck 
         BorderStyle     =   0  'None
         Height          =   330
         Index           =   3
         Left            =   1350
         Picture         =   "BacFinDia.frx":13AA
         ScaleHeight     =   330
         ScaleWidth      =   375
         TabIndex        =   7
         Top             =   1530
         Width           =   375
      End
      Begin VB.PictureBox SinCheck 
         BorderStyle     =   0  'None
         Height          =   330
         Index           =   1
         Left            =   1350
         Picture         =   "BacFinDia.frx":1504
         ScaleHeight     =   330
         ScaleWidth      =   375
         TabIndex        =   6
         Top             =   720
         Width           =   375
      End
      Begin VB.PictureBox ConCheck 
         BorderStyle     =   0  'None
         Height          =   330
         Index           =   0
         Left            =   1350
         Picture         =   "BacFinDia.frx":165E
         ScaleHeight     =   330
         ScaleWidth      =   330
         TabIndex        =   5
         Top             =   315
         Width           =   330
      End
      Begin VB.PictureBox SinCheck 
         BorderStyle     =   0  'None
         Height          =   330
         Index           =   0
         Left            =   1350
         Picture         =   "BacFinDia.frx":17B8
         ScaleHeight     =   330
         ScaleWidth      =   375
         TabIndex        =   4
         Top             =   360
         Width           =   375
      End
      Begin VB.Label Etiqueta 
         AutoSize        =   -1  'True
         Caption         =   "Actualizando Parámetros"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   225
         Index           =   4
         Left            =   1800
         TabIndex        =   17
         Top             =   1980
         Width           =   1995
      End
      Begin VB.Label Etiqueta 
         AutoSize        =   -1  'True
         Caption         =   "Respaldo de Cartera Log"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   225
         Index           =   3
         Left            =   1800
         TabIndex        =   16
         Top             =   1530
         Width           =   1965
      End
      Begin VB.Label Etiqueta 
         AutoSize        =   -1  'True
         Caption         =   "Respaldo de Cartera Histórica"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   225
         Index           =   2
         Left            =   1800
         TabIndex        =   15
         Top             =   1125
         Width           =   2370
      End
      Begin VB.Label Etiqueta 
         AutoSize        =   -1  'True
         Caption         =   "Respaldo Movimientos Diarios"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   225
         Index           =   1
         Left            =   1800
         TabIndex        =   14
         Top             =   720
         Width           =   2475
      End
      Begin VB.Label Etiqueta 
         AutoSize        =   -1  'True
         Caption         =   "Respaldo Parámetros Generales"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   225
         Index           =   0
         Left            =   1800
         TabIndex        =   3
         Top             =   315
         Width           =   2505
      End
   End
   Begin VB.Frame Frame1 
      Height          =   1050
      Left            =   0
      TabIndex        =   0
      Top             =   405
      Width           =   5865
      Begin ComctlLib.ProgressBar Barra 
         Height          =   285
         Left            =   135
         TabIndex        =   1
         Top             =   585
         Width           =   5610
         _ExtentX        =   9895
         _ExtentY        =   503
         _Version        =   327682
         Appearance      =   1
      End
      Begin VB.Label lblTitulo 
         Alignment       =   2  'Center
         Caption         =   "Label1"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H000000C0&
         Height          =   225
         Left            =   45
         TabIndex        =   20
         Top             =   225
         Width           =   5745
      End
   End
   Begin ComctlLib.ImageList ImageList1 
      Left            =   405
      Top             =   4065
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
            Picture         =   "BacFinDia.frx":1912
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "BacFinDia.frx":1C2C
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "BacFinDia"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim i   As Integer

Private Sub btnProcesar_Click()
Dim m As Integer
Dim Sql  As String
Dim nRetorno
Dim Datos()
Dim cTexto$
Dim lRet As Boolean

If MsgBox("¿Realiza Proceso Fin de Día?", vbQuestion + vbYesNo + vbDefaultButton2, Msj) = vbNo Then Exit Sub

Barra.Min = 0
Barra.Value = Barra.Min
Barra.Max = 5

btnSalir.Enabled = False
btnProcesar.Enabled = False

Sql = "BEGIN TRANSACTION"
    
If MISQL.SQL_Execute(Sql) Then
    Exit Sub
End If

For i = 0 To 4
    
    Sql = ""
    Sql = "SP_FINDIA '"
    Sql = Sql & Format(gsBAC_Fecp, "yyyymmdd") & "',"
    Sql = Sql & Str(i)

    Envia = Array()
    AddParam Envia, (Format(gsBAC_Fecp, "yyyymmdd"))
    AddParam Envia, Str(i)
    
'    If MISQL.SQL_Execute(Sql) = 0 Then
    If Bac_Sql_Execute("SP_FINDIA", Envia) Then
'        If MISQL.SQL_Fetch(DATOS()) = 0 Then
        If Bac_SQL_Fetch(Datos()) Then
             
             lRet = True
             nRetorno = Val(Datos(1))
             Select Case nRetorno
                    Case -211: cTexto$ = "NO pudo Limpiar datos en Cartera Historica"
                    Case -111: cTexto$ = "NO pudo Actualizar datos en Cartera Historica"
                    Case -212: cTexto$ = "NO pudo Limpiar registros en Cartera Log"
                    Case -112: cTexto$ = "NO pudo Actualizar datos en Cartera Log"
                    Case -213: cTexto$ = "NO pudo Limpiar datos en Movimiento Histórico"
                    Case -113: cTexto$ = "NO pudo Actualizar datos Movimiento Histórico"
                    Case -214: cTexto$ = "NO pudo Limpiar datos en Swap General Histórico"
                    Case -114: cTexto$ = "NO pudo Actualizar datos en Swap General Histórico"
                    Case -115: cTexto$ = "NO pudo Actualizar datos en Swap General"
                    Case -300: cTexto$ = "NO pudo Limpiar datos en Cartera Vigente Historica"
                    Case -310: cTexto$ = "NO pudo Actualizar datos en Cartera Vigente Historica"
                    Case -320: cTexto$ = "NO pudo Limpiar los últimos 60 dias de la Cartera Vigente Historica"
                    Case 0: lRet = False
                    Case Else:  cTexto$ = "Problemas NO pudo Actualizar datos" ' lRet = False
             End Select
             
             If lRet Then
                 Sql = "ROLLBACK TRANSACTION"
                If MISQL.SQL_Execute(Sql) <> 0 Then
                    MsgBox "Problemas en el proceso Fin de Día!!", vbCritical, Msj
                    btnSalir.Enabled = True
                    Exit Sub
                End If
                MsgBox cTexto$, vbCritical, Msj
                
            End If
    End If

Else
    Sql = "ROLLBACK TRANSACTION"
    If MISQL.SQL_Execute(Sql) <> 0 Then
        MsgBox "Problemas en el proceso Fin de Día!!", vbCritical, Msj
        btnSalir.Enabled = True
        Exit Sub
    End If

    MsgBox "Problemas en el proceso Fin de Día", vbCritical, Msj
    btnSalir.Enabled = True
    Exit Sub
            
End If

    ConCheck(i).Visible = True
    SinCheck(i).Visible = False
    Etiqueta(i).FontBold = True
    Barra.Value = Barra.Value + 1
    
    For m = 1 To 1000
        DoEvents
    Next
    
Next

' ' Ejecucion de Procedimiento Carga de BacMetrics
'   ' -------------------------------------
'   If Not Bac_Sql_Execute("sp_interfaz_bacmetrics_fwd") Then
'
'      If Not Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
'         ComFinDia = False
'         Exit Function
'      End If
'
'      ComFinDia = False
'
'      Exit Function
'
'   End If

Sql = "COMMIT TRANSACTION"
If MISQL.SQL_Execute(Sql) <> 0 Then
    MsgBox "PROBLEMAS AL FINALIZAR PROCESO FIN DE DIA!!!", vbCritical, Msj
    btnSalir.Enabled = True
    Exit Sub
Else

    MsgBox " Proceso Fin de Día se realizó Correctamente!", vbInformation, Msj
   
    'PRD-5521 --> llamada a sp para Chequeo de consistencia de tabla de relación
    '             entre operaciones y garantías constituídas
    Call ChequeaRelacionOperGtia
    'fin PRD-5521
   
    If gsc_Parametros.DatosGenerales() Then
        Call AsignaValoresParametros
    Else
        MsgBox "Error en la recuperación de la tabla de parámetros.", vbCritical, Msj
    End If
   
End If

    btnSalir.Enabled = True

End Sub

Private Function ChequeaRelacionOperGtia() As Boolean
Dim nomSp As String
    Envia = Array()
    ChequeaRelacionOperGtia = True

    nomSp = "Bacparamsuda..SP_CHKRELACION_OPER_GARANTIAS"
    AddParam Envia, "PCS"
    If Not Bac_Sql_Execute(nomSp, Envia) Then
        ChequeaRelacionOperGtia = False
        Exit Function
    End If
    ChequeaRelacionOperGtia = True
End Function

Private Sub btnSalir_Click()
    Unload Me
End Sub

Private Sub Form_Load()
    Me.Icon = BACSwap.Icon

    lblTitulo.Caption = "Proceso Fin de Día correspondiente a " & gsBAC_Fecp

    Me.Top = (Screen.Height / 2) - (Me.Height / 2)
    Me.Left = (Screen.Width / 2) - (Me.Width / 2)

    For i = 0 To 4
        ConCheck(i).Visible = False
        SinCheck(i).Visible = True
    Next

    Barra.Min = 0
    Barra.Value = Barra.Min
    Barra.Max = 5
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As ComctlLib.Button)
    Select Case Button.Index
       Case 1
          Call btnProcesar_Click
       Case 2
          Unload Me
    End Select
End Sub
