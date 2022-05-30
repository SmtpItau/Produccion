VERSION 5.00
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "COMDLG32.OCX"
Object = "{00025600-0000-0000-C000-000000000046}#4.6#0"; "CRYSTL32.OCX"
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.3#0"; "COMCTL32.OCX"
Begin VB.MDIForm BACSwap 
   BackColor       =   &H00C0C0C0&
   Caption         =   "BAC-SWAPS ( Sql Server )"
   ClientHeight    =   6285
   ClientLeft      =   585
   ClientTop       =   1830
   ClientWidth     =   11880
   Icon            =   "BParam.frx":0000
   LinkTopic       =   "BacTrd"
   Picture         =   "BParam.frx":030A
   WindowState     =   2  'Maximized
   Begin MSComDlg.CommonDialog CommonDialog1 
      Left            =   270
      Top             =   1305
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin ComctlLib.StatusBar barSistema 
      Align           =   2  'Align Bottom
      Height          =   375
      Left            =   0
      TabIndex        =   15
      Top             =   5910
      Width           =   11880
      _ExtentX        =   20955
      _ExtentY        =   661
      SimpleText      =   ""
      _Version        =   327682
      BeginProperty Panels {0713E89E-850A-101B-AFC0-4210102A8DA7} 
         NumPanels       =   5
         BeginProperty Panel1 {0713E89F-850A-101B-AFC0-4210102A8DA7} 
            AutoSize        =   1
            Object.Width           =   7894
            MinWidth        =   6174
            Object.Tag             =   ""
         EndProperty
         BeginProperty Panel2 {0713E89F-850A-101B-AFC0-4210102A8DA7} 
            Alignment       =   1
            AutoSize        =   2
            Object.Tag             =   ""
         EndProperty
         BeginProperty Panel3 {0713E89F-850A-101B-AFC0-4210102A8DA7} 
            Alignment       =   1
            AutoSize        =   2
            Object.Tag             =   ""
         EndProperty
         BeginProperty Panel4 {0713E89F-850A-101B-AFC0-4210102A8DA7} 
            Alignment       =   1
            AutoSize        =   1
            Object.Width           =   3837
            MinWidth        =   2117
            Object.Tag             =   ""
         EndProperty
         BeginProperty Panel5 {0713E89F-850A-101B-AFC0-4210102A8DA7} 
            Alignment       =   1
            AutoSize        =   1
            Object.Width           =   3485
            MinWidth        =   1765
            Object.Tag             =   ""
         EndProperty
      EndProperty
   End
   Begin VB.PictureBox PnlTools 
      Align           =   1  'Align Top
      BackColor       =   &H00808000&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H0000FF00&
      Height          =   600
      Left            =   0
      ScaleHeight     =   540
      ScaleWidth      =   11820
      TabIndex        =   0
      Top             =   0
      Width           =   11880
      Begin VB.PictureBox VBSQL1 
         Height          =   420
         Left            =   11295
         ScaleHeight     =   360
         ScaleWidth      =   450
         TabIndex        =   13
         Top             =   90
         Visible         =   0   'False
         Width           =   510
      End
      Begin VB.Timer TmrMsg 
         Interval        =   100
         Left            =   10260
         Top             =   90
      End
      Begin VB.PictureBox cmd 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   8
         Left            =   7035
         ScaleHeight     =   315
         ScaleWidth      =   315
         TabIndex        =   12
         Top             =   105
         Width           =   375
      End
      Begin VB.PictureBox cmd 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   18
         Left            =   8115
         ScaleHeight     =   315
         ScaleWidth      =   315
         TabIndex        =   11
         Top             =   105
         Width           =   375
      End
      Begin VB.PictureBox cmd 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   17
         Left            =   7755
         ScaleHeight     =   315
         ScaleWidth      =   315
         TabIndex        =   10
         Top             =   100
         Width           =   375
      End
      Begin VB.PictureBox cmd 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   16
         Left            =   7395
         ScaleHeight     =   315
         ScaleWidth      =   315
         TabIndex        =   9
         Top             =   100
         Visible         =   0   'False
         Width           =   375
      End
      Begin VB.PictureBox crwBacFwd 
         Height          =   480
         Left            =   10470
         ScaleHeight     =   420
         ScaleWidth      =   1140
         TabIndex        =   14
         Top             =   90
         Width           =   1200
      End
      Begin VB.PictureBox cmd 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   6
         Left            =   2970
         ScaleHeight     =   315
         ScaleWidth      =   315
         TabIndex        =   7
         Tag             =   "2005"
         Top             =   90
         Visible         =   0   'False
         Width           =   375
      End
      Begin VB.PictureBox cmd 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   5
         Left            =   2580
         ScaleHeight     =   315
         ScaleWidth      =   315
         TabIndex        =   6
         Tag             =   "2004"
         Top             =   100
         Visible         =   0   'False
         Width           =   375
      End
      Begin VB.PictureBox cmd 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   4
         Left            =   2205
         ScaleHeight     =   315
         ScaleWidth      =   315
         TabIndex        =   5
         Tag             =   "2003"
         Top             =   100
         Visible         =   0   'False
         Width           =   375
      End
      Begin VB.PictureBox cmd 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   3
         Left            =   1830
         ScaleHeight     =   315
         ScaleWidth      =   315
         TabIndex        =   3
         Tag             =   "2002"
         Top             =   100
         Visible         =   0   'False
         Width           =   375
      End
      Begin VB.PictureBox cmd 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   2
         Left            =   1455
         ScaleHeight     =   315
         ScaleWidth      =   315
         TabIndex        =   2
         Tag             =   "2001"
         Top             =   100
         Visible         =   0   'False
         Width           =   375
      End
      Begin VB.PictureBox cmd 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   7
         Left            =   4740
         ScaleHeight     =   315
         ScaleWidth      =   315
         TabIndex        =   4
         Top             =   100
         Visible         =   0   'False
         Width           =   375
      End
      Begin VB.PictureBox cmd 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   1
         Left            =   495
         ScaleHeight     =   315
         ScaleWidth      =   315
         TabIndex        =   8
         Top             =   100
         Visible         =   0   'False
         Width           =   375
      End
      Begin VB.PictureBox cmd 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   0
         Left            =   180
         ScaleHeight     =   315
         ScaleWidth      =   315
         TabIndex        =   1
         Top             =   675
         Visible         =   0   'False
         Width           =   375
      End
   End
   Begin Crystal.CrystalReport Crystal 
      Left            =   270
      Top             =   855
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   262150
   End
   Begin VB.Menu mnu_10000 
      Caption         =   "Inicio de Día"
      Begin VB.Menu Opc_10100 
         Caption         =   "Parametros Diarios"
         HelpContextID   =   1
      End
   End
   Begin VB.Menu Mnu_20000 
      Caption         =   "Operaciones"
      Begin VB.Menu Opc_20100 
         Caption         =   "Swaps de Tasas"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_20200 
         Caption         =   "Swaps de Monedas"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_20300 
         Caption         =   "Forward Rate Agreements"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_20500 
         Caption         =   "-"
      End
      Begin VB.Menu Opc_20400 
         Caption         =   "Mantención de Operaciones"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_20600 
         Caption         =   "-"
      End
      Begin VB.Menu Opc_20700 
         Caption         =   "Cierre de Mesa"
         HelpContextID   =   1
      End
   End
   Begin VB.Menu Mnu_30000 
      Caption         =   "Consulta"
      Visible         =   0   'False
      Begin VB.Menu Opc_30100 
         Caption         =   "Swaps Vigentes"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_30200 
         Caption         =   "Swaps Vencidos"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_30300 
         Caption         =   "Contratos Swaps"
         HelpContextID   =   1
      End
   End
   Begin VB.Menu Mnu_40000 
      Caption         =   "Informes"
      Begin VB.Menu Opc_40100 
         Caption         =   "al Cliente"
         HelpContextID   =   1
         Begin VB.Menu Opc_40101 
            Caption         =   "Condiciones Generales"
            HelpContextID   =   2
         End
         Begin VB.Menu Opc_40102 
            Caption         =   "Contratos con Empresas"
            HelpContextID   =   2
         End
         Begin VB.Menu Opc_40103 
            Caption         =   "Contratos Interbancarios"
            HelpContextID   =   2
         End
         Begin VB.Menu Opc_40104 
            Caption         =   "Protocolo de Definiciones"
            HelpContextID   =   2
         End
         Begin VB.Menu Opc_40105 
            Caption         =   "-"
         End
         Begin VB.Menu Opc_40106 
            Caption         =   "FAX de confirmación"
            HelpContextID   =   2
            Visible         =   0   'False
         End
         Begin VB.Menu Opc_40107 
            Caption         =   "Avisos de Liquidación"
            HelpContextID   =   2
         End
         Begin VB.Menu Opc_40108 
            Caption         =   "Capítulo VII Anexo 1"
            HelpContextID   =   2
         End
      End
      Begin VB.Menu Opc_40200 
         Caption         =   "Movimientos"
         HelpContextID   =   1
         Begin VB.Menu Opc_40201 
            Caption         =   "Swaps de Tasas"
            HelpContextID   =   2
         End
         Begin VB.Menu Opc_40202 
            Caption         =   "Swaps de Monedas"
            HelpContextID   =   2
         End
         Begin VB.Menu Opc_40203 
            Caption         =   "Forward Rate Agreements"
            HelpContextID   =   2
         End
         Begin VB.Menu Opc_40204 
            Caption         =   "-"
            HelpContextID   =   2
            Visible         =   0   'False
         End
         Begin VB.Menu Opc_40205 
            Caption         =   "Vencimientos del Día"
            HelpContextID   =   2
            Visible         =   0   'False
         End
      End
      Begin VB.Menu Opc_40300 
         Caption         =   "Carteras"
         HelpContextID   =   1
         Begin VB.Menu Opc_40303 
            Caption         =   "Swaps de Tasas"
            HelpContextID   =   2
         End
         Begin VB.Menu Opc_40304 
            Caption         =   "Swaps de Monedas"
            HelpContextID   =   2
         End
         Begin VB.Menu Opc_40301 
            Caption         =   "Forward Rate Agreements"
            HelpContextID   =   2
         End
         Begin VB.Menu Line_x 
            Caption         =   "-"
            HelpContextID   =   2
         End
         Begin VB.Menu Opc_40305 
            Caption         =   "M.T.M. Swaps "
            HelpContextID   =   2
         End
      End
      Begin VB.Menu Opc_40400 
         Caption         =   "Otros Informes"
         HelpContextID   =   1
         Visible         =   0   'False
         Begin VB.Menu Opc_40401 
            Caption         =   "Swaps de Tasas Anulados"
            HelpContextID   =   2
         End
         Begin VB.Menu Opc_40402 
            Caption         =   "Swaps de Monedas Anuladas"
            HelpContextID   =   2
         End
         Begin VB.Menu Opc_40403 
            Caption         =   "Forward Rate Agreements Anulados"
            HelpContextID   =   2
         End
      End
   End
   Begin VB.Menu Mnu_50000 
      Caption         =   "Procesos"
      Begin VB.Menu Opc_50100 
         Caption         =   "Paridades Bid-Ask"
         HelpContextID   =   1
         Visible         =   0   'False
      End
      Begin VB.Menu Opc_50200 
         Caption         =   "Devengamiento y Valorización"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_50300 
         Caption         =   "Contabilidad Automática"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_70101 
         Caption         =   "Interfaz Contable"
         HelpContextID   =   1
         Visible         =   0   'False
      End
   End
   Begin VB.Menu Mnu_70000 
      Caption         =   "Fin de Día"
      Begin VB.Menu Opc_70100 
         Caption         =   "Proceso de Cierre"
         HelpContextID   =   1
      End
   End
End
Attribute VB_Name = "BACSwap"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Function RevisarMensajes()

   Dim Sql           As String
   Dim nForms        As Integer
   Dim Datos()

   Sql = "EXECUTE sp_mdmsgcontarpendientes '" & gsBAC_User & "'"

   If SQL_Execute(Sql) <> 0 Then
      Exit Function

   End If

   Do While SQL_Fetch(Datos()) = 0
      If Val(Datos(1)) > 0 Then
         'MsgBox "Existen Mensajes Nuevos", vbExclamation, "MENSAJES"
         BACSwap.Tag = " " ' PnlMensaje.Caption
        ' PnlMensaje.Caption = "Tiene Mensajes Nuevos"
        ' PnlMensaje.Tag = "MSG"
        ' PnlMensaje.Refresh

         For nForms = 1 To Forms.Count - 1
            If Forms(nForms).Tag = "RECIBIR" Then
               'Call BacRecibir.RecibirLeerTodos
               Exit For

            End If

         Next nForms

      End If

   Loop

   'If PnlMensaje.Tag = "MSG" Then
   '   If PnlMensaje.BackColor = &HC0C0C0 Then
   '      PnlMensaje.BackColor = vbWhite
   '
   '   Else
   '      PnlMensaje.BackColor = &HC0C0C0
   '
   '   End If
      
   'End If

End Function

Private Sub cmd_Click(Index As Integer)

   On Error GoTo ErrLevel:

   'Click de botones del Toolbar.-
   Select Case Index
   Case 0:
      If gsc_Parametros.cierreMesa = "0" Then
         With ActiveForm
            If .ValidarDatos() Then
               If .clsOperacion.nNumOper = 0 Then
                  'gsc_Operacion.limpiar

               Else
                  'Call gsc_Operacion.CopiarDatos(.clsOperacion)

               End If

               Call ActiveForm.GrabarOperac

               'BacInstrucc.Caption = .Caption
               'BacInstrucc.Tag = .Tag
               'BacInstrucc.Show vbModal%

               'If gsc_Operacion.nNumOper <> 0 Then
               '   If Mid$(ActiveForm.Tag, 5, 1) = "A" Then
               '      ActiveForm.cmpLimpiar
'
'                  Else
'                     Unload ActiveForm
'
'                  End If

'               End If

               'gsc_Operacion.limpiar

            End If

         End With

      Else
         MsgBox "Esta operación no se puede grabar porque ya se realizo el cierre de mesa", vbExclamation, "MENSAJE"

      End If

   Case 1:
      Select Case UCase(ActiveForm.Name)
      Case "BACCONMOVIMIENTO"
         ActiveForm.AnularOperacion
      
      End Select

   Case 2:  Call BacIrfNueVentana("SCAMA")
   Case 3:  Call BacIrfNueVentana("ARBRA")
   Case 4:  Call BacIrfNueVentana("SEINA")
   Case 5:  Call BacIrfNueVentana("SINTA")
   Case 6:  Call BacIrfNueVentana("1446A")
  
   Case 8:  'BacConsultar.Show vbNormal
  
   Case 16:    'Posición Banco
      'BacPosBC.Show vbNormal

   Case 17: 'BACSend.Show vbNormal

   Case 18: 'BacRecibir.Show vbNormal

   Case Else:

   End Select

   
   On Error GoTo 0

   Exit Sub

ErrLevel:


End Sub

Private Sub Command1_Click()

End Sub

Private Sub MDIForm_Activate()

   Dim a As Integer
   Dim Sql As String
   Dim cPict As String
   Dim Datos()

    Screen.MousePointer = 11

    Screen.MousePointer = 0
             
   'Activa el Login a BACSwap.-
   If Not gsBAC_Login Then
   
 ' VB+- Se cambia pantalla de login
      If gsBAC_Login Then
         Screen.MousePointer = 11

         BacControlWindows 100

         PROC_CARGA_PRIVILEGIOS

      Else
         Unload Me
         Exit Sub

      End If

  End If

   If gsc_Parametros.DatosGenerales() Then
      Call AsignaValoresParametros
   Else
      MsgBox "Error en la recuperación de la tabla de parametros.", vbCritical, "MENSAJE"
      Unload Me
      
   End If
   
   barSistema.Panels(1) = " " + gsBAC_Clien
   barSistema.Panels(2) = "User : " + gsBAC_User$
   barSistema.Panels(3) = " " + gsBAC_Fecp
   barSistema.Panels(4) = " Valor U.F : " & gsBAC_ValmonUF
   barSistema.Panels(5) = " Dolar Obs.: " & gsBAC_DolarObs

   Screen.MousePointer = 0

End Sub

Sub PROC_CARGA_PARAMETROS()
Dim Datos()

If SQL_Execute("SELECT CONVERT(CHAR(10),acfecproc,103), acnomprop,CONVERT(CHAR(10),acfecprox,103),acrutprop,acdigprop,acrutcomi,accomision,aciva FROM MdAc") = 0 Then

   Do While SQL_Fetch(Datos()) = 0
      gsBAC_Fecp = CDate(Datos(1))
      gsBAC_Clien = Datos(2)
'      gsBac_Fecx = CDate(Datos(3))
'      gsBac_RutC = Datos(4)
'      gsBac_DigC = Datos(5)
'      gsBac_RutComi = Val(Datos(6))
'      gsBac_PrComi = Val(Datos (7))
'      gsBac_Iva = Val(Datos(8))
   Loop
   
End If
  
If SQL_Execute("SET ROWCOUNT 1") <> 0 Then Exit Sub
  
If SQL_Execute("SELECT rcrut,rcdv,rcnombre FROM MdRc") = 0 Then

   Do While SQL_Fetch(Datos()) = 0
'      gsBac_CartRUT = Val(Datos(1))
'      gsBac_CartDV = Datos(2)
'      gsBac_CartNOM = Datos(3)
   Loop
   
End If
  
If SQL_Execute("SET ROWCOUNT 0") <> 0 Then Exit Sub
    
End Sub

Sub PROC_CARGA_PRIVILEGIOS()
Dim Datos()
Dim i%
Dim Comando As String


If Trim(gsBAC_User) = "ADMINISTRADOR" Then Exit Sub

' DESHABILITA TODAS LAS OPCIONES DEL MENU

For i% = 0 To Me.Controls.Count - 1

    If TypeOf Me.Controls(i%) Is Menu Then
       
       If Me.Controls(i%).Caption <> "-" And Me.Controls(i%).Caption <> "?" Then
          Me.Controls(i%).Enabled = False
       End If
       
    End If

Next i%

Comando = "EXECUTE " & giSQL_DatabaseCommon & "..sp_busca_privilegios "
Comando = Comando + "'T',"
Comando = Comando + "'FUT',"
Comando = Comando + "'" + gsBac_Tipo_Usuario + "'"

If SQL_Execute(Comando) <> 0 Then Exit Sub

' BUSCA LAS OPCIONES POR TIPO DE USUARIO

Do While SQL_Fetch(Datos) = 0

   For i% = 0 To Me.Controls.Count - 1

       If TypeOf Me.Controls(i%) Is Menu Then
       
          If Trim(Me.Controls(i%).Name) = Trim(Datos(1)) Then
             Me.Controls(i%).Enabled = True
          End If
       
       End If

   Next i%

Loop

' BUSCA LAS OPCIONES POR USUARIO
Comando = "EXECUTE " & giSQL_DatabaseCommon & "..SP_BUSCA_PRIVILEGIOS "
Comando = Comando + "'U',"
Comando = Comando + "'FUT',"
Comando = Comando + "'" + gsBac_Tipo_Usuario + "'"

If SQL_Execute(Comando) <> 0 Then Exit Sub

' BUSCA LAS OPCIONES DEL USUARIO Y LAS HABILITA

Do While SQL_Fetch(Datos) = 0

   For i% = 0 To Me.Controls.Count - 1

       If TypeOf Me.Controls(i%) Is Menu Then
       
          If Trim(Me.Controls(i%).Name) = Trim(Datos(1)) Then
             Me.Controls(i%).Enabled = True
          End If
       
       End If

   Next i%

Loop

End Sub

Private Sub MDIForm_Load()
Dim Pantalla_Activa$

    Screen.MousePointer = 11
      
    Msj = "Sistema BacSwaps"
    Entidad = "01"
    Sistema = "PCS"
   
    If Trim(Command) = "GENERA_MENU" Then
        PROC_GENERA_MENU BACSwap, App.Path + "\" + Trim(App.EXEName) + ".MNU"
        End
    End If
   
    ' Inicializar DB-Library.-
    Call SQL_Init
    
    ' Parametros de Inicio.-
    If Not BacInit Then
        MsgBox "Problemas en Conección Inicial del Sistema", vbCritical, Msj
        End
    End If
   
    ' Oculta Panel con Botonera
    PnlTools.Visible = False
  
 
    ' VB+ 24/02/2000 Agrego conección al servidor en este instante para que se realice solo una vez
    If Not BAC_Login(gsSQL_Login, gsSQL_Password) Then
        MsgBox "NO EXISTE CONECCION"
        End
    End If
    
    Screen.MousePointer = 0

    ' LOGIN
    Login_Usuario = ""

    Acceso_Usuario.Show 1

    If Trim(Login_Usuario) = "" Then
       SQL_Close
       SQL_Exit
       End
    End If


    PROC_BUSCA_PRIVILEGIOS_USUARIO BACSwap, "PCS"
 

    Pantalla_Activa$ = ""
    BACSwap.WindowState = 2
    Screen.MousePointer = 0
   
   

End Sub


Sub PROC_BUSCA_PRIVILEGIOS_USUARIO(forma_menu As Form, Entidad As String)
Dim i%
Dim Datos()

If Trim(Login_Usuario) = "ADMINISTRADOR" Then End
If Trim(Login_Usuario) = "BAC" Then Exit Sub

' DESHABILITA TODAS LAS OPCIONES DEL MENU

For i% = 0 To forma_menu.Controls.Count - 1
    If TypeOf forma_menu.Controls(i%) Is Menu Then
       If forma_menu.Controls(i%).Caption <> "-" And forma_menu.Controls(i%).Caption <> "?" Then
          forma_menu.Controls(i%).Enabled = False
       End If
    End If
Next i%

' BUSCA LAS OPCIONES DEL USUARIO Y LAS HABILITA

Comando$ = giSQL_DatabaseCommon & "..SP_BUSCA_PRIVILEGIOS "
Comando$ = Comando$ + "'T',"
Comando$ = Comando$ + "'" + Entidad + "',"
Comando$ = Comando$ + "'" + gsBac_Tipo_Usuario + "'"

If SQL_Execute(Comando$) <> 0 Then Exit Sub

Do While SQL_Fetch(Datos()) = 0

   For i% = 0 To forma_menu.Controls.Count - 1

       If TypeOf forma_menu.Controls(i%) Is Menu Then
       
          If Trim(forma_menu.Controls(i%).Name) = Trim(Datos(1)) Then
             forma_menu.Controls(i%).Enabled = True
          End If
       
       End If

   Next i%
Loop

Comando$ = giSQL_DatabaseCommon & "..SP_BUSCA_PRIVILEGIOS "
Comando$ = Comando$ + "'U',"
Comando$ = Comando$ + "'" + Entidad + "',"
Comando$ = Comando$ + "'" + Login_Usuario + "'"

If SQL_Execute(Comando$) <> 0 Then Exit Sub

Do While SQL_Fetch(Datos) = 0

   For i% = 0 To forma_menu.Controls.Count - 1

       If TypeOf forma_menu.Controls(i%) Is Menu Then
          If Trim(forma_menu.Controls(i%).Name) = Trim(Datos(1)) Then
             If Datos(2) = "N" Then
                forma_menu.Controls(i%).Enabled = False
             Else
                forma_menu.Controls(i%).Enabled = True
             End If
          End If
       
       End If

   Next i%
Loop


End Sub



Sub PROC_GENERA_MENU(forma_menu As Form, nombre_archivo As String)
Dim i%
Open nombre_archivo For Output As #1

For i% = 0 To forma_menu.Controls.Count - 1

    If TypeOf forma_menu.Controls(i%) Is Menu Then
       
       If forma_menu.Controls(i%).Caption <> "-" And forma_menu.Controls(i%).Caption <> "?" Then
          Print #1, RELLENA_STRING(Format(forma_menu.Controls(i%).HelpContextID, "0") + forma_menu.Controls(i%).Caption, "D", 70) + RELLENA_STRING(forma_menu.Controls(i%).Name, "D", 20)
       End If
       
    End If

Next i%

Close #1

End Sub

Private Function BAC_Login(sUser$, sPWD$) As Boolean

 BAC_Login = False

 If giSQL_ConnectionMode = 1 Then
      
     If SQL_Open(gsSQL_Server$, gsSQL_Login$, gsSQL_Password$, gsSQL_Database, giSQL_LoginTimeOut, giSQL_QueryTimeOut) <> 0 Then
        Exit Function
    End If
      
 Else
     
     If SQL_Open(gsSQL_Server, sUser$, sPWD$, gsSQL_Database, giSQL_LoginTimeOut, giSQL_QueryTimeOut) <> 0 Then
        Exit Function
     End If
      
 End If
 
 BAC_Login = True
  
 
End Function

Private Sub MDIForm_Unload(Cancel As Integer)

   'Unload BacToolTip

   Call SQL_Close
   Call SQL_Exit

End Sub

Private Sub Opc_10100_Click()
    
    If gsc_Parametros.iniciodia <> 1 Then
        BacInicioDia.Show
    Else
        MsgBox "No Ha Realizado Fin de Día!!", vbExclamation, "Inicio de Día"
    End If

End Sub

Private Sub Opc_20100_Click()
   

    If ChequeaCierreMesa() Then
        swOperSwap = "Ingreso"
        BacIrfNueVentana "SWTAA"
    Else
        MsgBox "Se ha realizado Cierre de Mesa", vbInformation, Msj
    End If
    
End Sub

Private Sub Opc_20200_Click()

    If ChequeaCierreMesa() Then
        BacIrfNueVentana "SWMNA"
    Else
        MsgBox "Se ha realizado Cierre de Mesa", vbInformation, Msj
    End If
    
End Sub

Private Sub Opc_20300_Click()

    If ChequeaCierreMesa() Then
        BacIrfNueVentana "FRANA"
    Else
        MsgBox "Se ha realizado Cierre de Mesa", vbInformation, Msj
    End If

End Sub

Private Sub Opc_20400_Click()

 BacConsultaOper.Show 1

End Sub

Private Sub Opc_20700_Click()
    Call gsc_Parametros.CierredeMesa
End Sub

Private Sub Opc_40101_Click()

    BacContratoInterbancario.Show 1

End Sub

Private Sub Opc_40102_Click()
    
    BacContratoSwap.Tag = "Empresa"
    BacContratoSwap.Show 1

End Sub

Private Sub Opc_40103_Click()

    BacContratoSwap.Show 1

End Sub

Private Sub Opc_40104_Click()

    BacInformeProtocoloDef.Show 1

End Sub

Private Sub Opc_40107_Click()

    BacLiquidacionesSwaps.Show 1
    
End Sub

Private Sub Opc_40108_Click()

    baccapitulovii.Show 1

End Sub

Private Sub Opc_40201_Click()
    
    BacInformes.Tag = "TASAS"
    BacInformes.Show 1

End Sub

Private Sub Opc_40202_Click()

    BacControlWindows 100
    BacInformes.Tag = "MONEDAS"
    BacInformes.Show 1

End Sub

Private Sub Opc_40203_Click()
    
    BacControlWindows 100
    BacMovimientoFRA.Tag = ""
    BacMovimientoFRA.Show

End Sub

Private Sub Opc_40301_Click()

    BacControlWindows 100
    bacCarteraFRA.Tag = ""
    bacCarteraFRA.Show

End Sub

Private Sub Opc_40303_Click()

' Cartera de Swap de Tasas
    BacInformeCartera.Tag = "Tasa"
    BacInformeCartera.Show 1
 
End Sub

Private Sub Opc_40304_Click()
'Cartera de Swap de Moneda
    BacInformeCartera.Tag = "Moneda"
    BacInformeCartera.Show 1

End Sub

Private Sub Opc_40305_Click()

    BacControlWindows 100
    RPTMTM.Show
    
End Sub

Private Sub Opc_50200_Click()

    BacControlWindows 100
    BacDevengamiento.Show

End Sub

Private Sub Opc_50300_Click()

    BacControlWindows 100
    Contabilizacion_Automatica.Show

End Sub


Private Sub Opc_70100_Click()

    If gsc_Parametros.cierreMesa = "1" Then
        BacFinDia.Show

    Else
       MsgBox "No se ha realizado el cierre de mesa", vbExclamation, "Fin de Día"
    End If
    
End Sub

Private Sub Opc_70101_Click()

    BacControlWindows 100
    INTERFAZ_CONTABLE.Show
    
End Sub

'---------------------------------------------------------------
' Nota1.-
' La rutina originalmente usaba la API WindowFormPoint,pero solo
' devuelve el handler de ventanas activas. Se tiene la alternativa
' de usar ChildWindowFromPoint que devuelve el handler para activas,
' no activas e INVISIBLES, pero requiere el uso de la API
' ScreenToClient que convierte coordenas de la pantalla al
' "area cliente".
' JM
'
'--------------------------------------------------------------------
' el código es:
'
'  ScreenToClient BACSwap.hWnd, lpPoint
'  curhWnd = ChildWindowFromPoint(PnlTools.hWnd, lpPoint.Y, lpPoint.X)
'
' que reemplaza a:
'
' curhWnd = WindowFromPoint( lpPoint.Y, lpPoint.X )
'
'---------------------------------------------------------------------
Private Sub TmrMsg_Timer()

   Dim lpPoint As POINTAPI
   Dim curhWnd As Integer

   Static LasthWnd As Integer
    
   TmrMsg.Interval = 0
   Exit Sub

   If GetActiveWindow() = BACSwap.hWnd Then

      Call GetCursorPos(lpPoint)
  
      curhWnd = WindowFromPoint(lpPoint.Y, lpPoint.X)
  
      If curhWnd <> LasthWnd Then
      
         TmrMsg.Interval = 1
         LasthWnd = curhWnd
         Select Case curhWnd
      
         Case cmd(0).hWnd: DisplayHelp (cmd(0).Tag)
         Case cmd(1).hWnd: DisplayHelp (cmd(1).Tag)
         Case cmd(2).hWnd: DisplayHelp (cmd(2).Tag)
         Case cmd(3).hWnd: DisplayHelp (cmd(3).Tag)
         Case cmd(4).hWnd: DisplayHelp (cmd(4).Tag)
         Case cmd(5).hWnd: DisplayHelp (cmd(5).Tag)
         Case cmd(6).hWnd: DisplayHelp (cmd(6).Tag)
         Case Else:
            DisplayHelp ""
            TmrMsg.Interval = 100
         End Select

      End If

'      Call gsc_Parametros.DatosGenerales

      If gsc_Parametros.cierreMesa = "1" Then
         Opc_20700.Checked = True

      Else
         Opc_20700.Checked = False
      End If

      Call RevisarMensajes

   End If

End Sub

Private Sub DisplayHelp(Help$)

  Dim lpPoint As POINTAPI
  Dim ret As Integer

  If Len(Help$) > 0 Then

     
      'BacToolTip.Hide
      'BacToolTip.Label1.Caption = Trim$(Help$)

      'Call GetCursorPos(lpPoint)

      'BacToolTip.Top = (lpPoint.Y + 18) * Screen.TwipsPerPixelY
      'BacToolTip.Left = (lpPoint.x - 2) * Screen.TwipsPerPixelY
      'BacToolTip.Width = BacToolTip.Label1.Width + (6 * Screen.TwipsPerPixelX)
      'BacToolTip.Height = BacToolTip.Label1.Height + (4 * Screen.TwipsPerPixelY)
      'BacToolTip.ZOrder

      'ret = ShowWindow(BacToolTip.hWnd, SW_SHOWNOACTIVATE)

  Else
      'BacToolTip.Hide
  End If

End Sub

Private Sub Vbsql1_Error(SqlConn As Integer, Severity As Integer, ErrorNum As Integer, ErrorStr As String, RetCode As Integer)

  BacLogFile "VBSQL = " & SqlConn & "-" & Severity & "-" & ErrorNum & "-" & ErrorStr & "-" & RetCode

End Sub

Private Sub VBSQL1_Message(SqlConn As Integer, Message As Long, State As Integer, Severity As Integer, MsgStr As String)
'MsgBox MsgStr
End Sub

