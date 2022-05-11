VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.2#0"; "mscomctl.ocx"
Object = "{00025600-0000-0000-C000-000000000046}#5.2#0"; "crystl32.ocx"
Object = "{248DD890-BB45-11CF-9ABC-0080C7E7B78D}#1.0#0"; "MSWINSCK.OCX"
Begin VB.MDIForm BAC_INVERSIONES 
   BackColor       =   &H8000000D&
   Caption         =   "Inversiones en el Exterior"
   ClientHeight    =   10320
   ClientLeft      =   915
   ClientTop       =   1110
   ClientWidth     =   12120
   Icon            =   "frm_inversiones.frx":0000
   LinkTopic       =   "MDIForm1"
   LockControls    =   -1  'True
   Picture         =   "frm_inversiones.frx":030A
   WindowState     =   2  'Maximized
   Begin VB.Timer Tmrfecha 
      Left            =   4560
      Top             =   6240
   End
   Begin MSWinsockLib.Winsock NomObjWinIP 
      Left            =   1200
      Top             =   1800
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   393216
   End
   Begin Crystal.CrystalReport BacRpt 
      Left            =   2400
      Top             =   540
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   348160
      PrintFileLinesPerPage=   60
   End
   Begin VB.Timer Timer1 
      Interval        =   1000
      Left            =   10140
      Top             =   6660
   End
   Begin MSComctlLib.StatusBar barraestado 
      Align           =   2  'Align Bottom
      Height          =   330
      Left            =   0
      TabIndex        =   0
      Top             =   9990
      Width           =   12120
      _ExtentX        =   21378
      _ExtentY        =   582
      _Version        =   393216
      BeginProperty Panels {8E3867A5-8586-11D1-B16A-00C0F0283628} 
         NumPanels       =   4
         BeginProperty Panel1 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Alignment       =   1
            Object.Width           =   2646
            MinWidth        =   2646
         EndProperty
         BeginProperty Panel2 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Alignment       =   1
            Object.Width           =   7937
            MinWidth        =   7937
         EndProperty
         BeginProperty Panel3 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Alignment       =   1
            Object.Width           =   7056
            MinWidth        =   7056
         EndProperty
         BeginProperty Panel4 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Style           =   5
            Alignment       =   1
            Object.Width           =   2646
            MinWidth        =   2646
            TextSave        =   "16:30"
         EndProperty
      EndProperty
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
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   0
      Top             =   0
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   32
      ImageHeight     =   32
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   18
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_inversiones.frx":B474C
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_inversiones.frx":B4A66
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_inversiones.frx":B4EB8
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_inversiones.frx":B530A
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_inversiones.frx":B5624
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_inversiones.frx":B593E
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_inversiones.frx":B5D90
            Key             =   ""
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_inversiones.frx":B5EEA
            Key             =   ""
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_inversiones.frx":B633C
            Key             =   ""
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_inversiones.frx":B678E
            Key             =   ""
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_inversiones.frx":B6AA8
            Key             =   ""
         EndProperty
         BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_inversiones.frx":B6DC2
            Key             =   ""
         EndProperty
         BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_inversiones.frx":B6F1C
            Key             =   ""
         EndProperty
         BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_inversiones.frx":B736E
            Key             =   ""
         EndProperty
         BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_inversiones.frx":B77C0
            Key             =   ""
         EndProperty
         BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_inversiones.frx":B7ADA
            Key             =   ""
         EndProperty
         BeginProperty ListImage17 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_inversiones.frx":B7DF4
            Key             =   ""
         EndProperty
         BeginProperty ListImage18 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_inversiones.frx":B810E
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin VB.Menu IniciodeDia 
      Caption         =   "&Inicio de Día"
      Begin VB.Menu Inicio_De_Dia 
         Caption         =   "Inicio De &Dia"
         HelpContextID   =   1
      End
   End
   Begin VB.Menu Front_Office 
      Caption         =   "&Front Office"
      Begin VB.Menu compras 
         Caption         =   "Compras"
         HelpContextID   =   1
      End
      Begin VB.Menu ventas 
         Caption         =   "Ventas"
         HelpContextID   =   1
      End
      Begin VB.Menu Anulacion_de_Operaciones 
         Caption         =   "Anulación de Operaciones"
         HelpContextID   =   1
      End
      Begin VB.Menu reimp_papeletas 
         Caption         =   "Reimpresión de Papeletas"
         HelpContextID   =   1
      End
      Begin VB.Menu Valorizador 
         Caption         =   "Valorizador"
         HelpContextID   =   1
      End
   End
   Begin VB.Menu Back_Office 
      Caption         =   "Back Office"
      Begin VB.Menu Bloqueo_de_Mesa 
         Caption         =   "Bloqueo de Mesa"
         HelpContextID   =   1
      End
      Begin VB.Menu Devengamiento_de_Cartera 
         Caption         =   "Devengamiento de Cartera"
         HelpContextID   =   1
      End
      Begin VB.Menu Tasas_Vigentes 
         Caption         =   "Tasas De Mercado"
         HelpContextID   =   1
      End
      Begin VB.Menu Contabilidad 
         Caption         =   "Contabilidad"
         HelpContextID   =   1
      End
      Begin VB.Menu Fin_De_Dia 
         Caption         =   "Fin De Dia"
         HelpContextID   =   1
      End
      Begin VB.Menu ConsultaDeProcesos 
         Caption         =   "Consulta De Procesos"
         HelpContextID   =   1
      End
   End
   Begin VB.Menu Administracion 
      Caption         =   "&Administracion"
      Begin VB.Menu Emisores 
         Caption         =   "Emisores"
         HelpContextID   =   1
      End
      Begin VB.Menu instrumentos_financieros 
         Caption         =   "Instrumentos Financieros"
         HelpContextID   =   1
         Begin VB.Menu Información_General 
            Caption         =   "Info&rmación General Seriados"
            HelpContextID   =   2
         End
         Begin VB.Menu Información_General_noSerie 
            Caption         =   "Info&rmación General No Seriados"
            HelpContextID   =   2
         End
         Begin VB.Menu Tabla_de_Desarrollo 
            Caption         =   "Ta&bla de Desarrollo"
            HelpContextID   =   2
         End
         Begin VB.Menu Copia_de_Fomulas 
            Caption         =   "Copia de Fomulas"
            HelpContextID   =   2
         End
      End
      Begin VB.Menu Formulas_y_Valorización 
         Caption         =   "Formulas y Valorización"
         HelpContextID   =   1
      End
      Begin VB.Menu Clasificador_Riesgo 
         Caption         =   "Clasificador Riesgo"
         HelpContextID   =   1
      End
      Begin VB.Menu Traspaso_de_Cartera 
         Caption         =   "Traspaso de Cartera"
         HelpContextID   =   1
      End
   End
   Begin VB.Menu Informes 
      Caption         =   "Informes"
      Begin VB.Menu Informe_de_Movimientos 
         Caption         =   "Informe de Movimientos"
         HelpContextID   =   1
         Begin VB.Menu Op_intramesas 
            Caption         =   "Operaciones Intramesas"
            HelpContextID   =   2
         End
         Begin VB.Menu Ventas_del_Dia 
            Caption         =   "Ventas del Dia"
            HelpContextID   =   2
         End
         Begin VB.Menu Compras_del_Dia 
            Caption         =   "Compras del Dia"
            HelpContextID   =   2
         End
         Begin VB.Menu inforeme_de_movimiento_de_valuta 
            Caption         =   "Informe De Movimiento de Valuta"
            HelpContextID   =   2
         End
         Begin VB.Menu informe_de_movimiento 
            Caption         =   "Informe de Movimiento Históricos"
            HelpContextID   =   2
         End
         Begin VB.Menu Informesdeanulacion 
            Caption         =   "Informes de anulación de Operación"
            HelpContextID   =   2
         End
      End
      Begin VB.Menu Informes_de_Cartera 
         Caption         =   "Informes de Cartera"
         HelpContextID   =   1
         Begin VB.Menu Informe_de_Cartera_Vigente 
            Caption         =   "Informe de Cartera Vigente"
            HelpContextID   =   2
         End
         Begin VB.Menu Informe_Cartera_Intramesas 
            Caption         =   "Informe de Cartera Vigente Intramesas"
            HelpContextID   =   2
         End
         Begin VB.Menu Informe_Resumen_Total_De_Cartera 
            Caption         =   "Informe Resumen Total De Cartera"
            HelpContextID   =   2
         End
         Begin VB.Menu InformedeValorizacióndeMercado 
            Caption         =   "Informe de Valorización de Mercado"
            HelpContextID   =   2
         End
         Begin VB.Menu Informe_de_Cartera_De_Valutas_Vigentes 
            Caption         =   "Informe de Cartera De Valutas Vigentes"
            HelpContextID   =   2
         End
         Begin VB.Menu Informe_de_Traspaso_de_Cartera 
            Caption         =   "Informe de Traspaso de Cartera"
            HelpContextID   =   2
         End
      End
      Begin VB.Menu Informe_De_Vencimientos 
         Caption         =   "Informe De Vencimientos"
         HelpContextID   =   1
      End
      Begin VB.Menu informe_de_cartola 
         Caption         =   "Informe de Cartola de Operación"
         HelpContextID   =   1
      End
      Begin VB.Menu Informes_Nomativos 
         Caption         =   "Informes Normativos"
         HelpContextID   =   1
         Visible         =   0   'False
         Begin VB.Menu Deudores_de_Inversiones_Extranjeras 
            Caption         =   "Deudores de Inversiones Extranjeras"
            HelpContextID   =   2
         End
         Begin VB.Menu Compendio_De_Normas 
            Caption         =   "Compendio De Normas"
            HelpContextID   =   2
         End
         Begin VB.Menu Basilea 
            Caption         =   "Basilea"
            HelpContextID   =   2
         End
         Begin VB.Menu Encaje 
            Caption         =   "Encaje"
            HelpContextID   =   2
         End
      End
      Begin VB.Menu Informe_Contable 
         Caption         =   "Informe Contable"
         HelpContextID   =   1
         Begin VB.Menu Informe_Voucher 
            Caption         =   "Informe Voucher"
            HelpContextID   =   2
         End
         Begin VB.Menu Informe_Voucher_Consolidado 
            Caption         =   "Informe Voucher Consolidado"
            HelpContextID   =   2
         End
      End
   End
   Begin VB.Menu Interfaces 
      Caption         =   "Interfaces"
      Begin VB.Menu Interfaz_Cartera 
         Caption         =   "Interfaz Cartera"
         HelpContextID   =   1
      End
      Begin VB.Menu Interfaz_de_Flujos 
         Caption         =   "Interfaz de Flujos"
         HelpContextID   =   1
      End
      Begin VB.Menu Interfaz_P17 
         Caption         =   "Interfaz P17"
         HelpContextID   =   1
      End
      Begin VB.Menu InterfazCapXIIIanexo2 
         Caption         =   "Interfaz Cap.XIII anexo 2"
         HelpContextID   =   1
      End
      Begin VB.Menu InterfazCapXIIIanexo3 
         Caption         =   "Interfaz Cap.XIII anexo 3"
         HelpContextID   =   1
      End
   End
   Begin VB.Menu Salir 
      Caption         =   "Salir"
   End
End
Attribute VB_Name = "BAC_INVERSIONES"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Sub DESHABILITA_MENU()
   'Habilita todas los ítemes del menú
   On Error Resume Next
   Dim i%
   For i% = 0 To Me.Controls.Count - 1
      If TypeOf Me.Controls(i%) Is Menu Then
         If Me.Controls(i%).Caption <> "-" And Me.Controls(i%).Caption <> "?" And Me.Controls(i%).Caption <> "Salir" And Me.Controls(i%).Caption <> "Salir del Sistema" Then
'            Me.Controls(I%).Visible = False
         End If
      End If
      If TypeOf Me.Controls(i%) Is CommandButton Then
         Me.Controls(i%).Enabled = False
      End If

    Next i%
End Sub

Sub PROC_GENERA_MENU(Entidad As String)
    Dim Indice          As Integer: Indice = 1
    Dim Primera_Vez     As String: Primera_Vez = "S"
    Dim i%

   For i% = 0 To Me.Controls.Count - 1
        If TypeOf Me.Controls(i%) Is Menu Then
            If Me.Controls(i%).Caption <> "-" And Me.Controls(i%).Caption <> "?" And Me.Controls(i%).Visible And Me.Controls(i%).Caption <> "Salir" Then
                
                envia = Array(Primera_Vez, _
                              Entidad, _
                              CDbl(Indice), _
                              Me.Controls(i%).Caption, _
                              Me.Controls(i%).Name, _
                              Format(Me.Controls(i%).HelpContextID, "0"))
                
                Indice = Indice + 1
                If Not Bac_Sql_Execute("SP_CARGA_GEN_MENU", envia) Then
                    Exit Sub
                End If
                Primera_Vez = "N"
                
            End If
        End If
    Next i%

End Sub



Private Sub anul_compra_Click()
        
End Sub

Private Sub Anul_venta_Click()
Dim Frm_Informes As New Bac_Informes
        Bac_Informe = "ANUVEN"
        Frm_Informes.Show
End Sub

Private Sub Anulacion_de_Operaciones_Click()

    If Chequea_ControlProcesos("OP") = True Then
        Bac_Anulacion.Show
    End If

End Sub

Private Sub Basilea_Click()
        Dim Frm_Informes As New Bac_Informes
        Bac_Informe = "INFBAS"
        Frm_Informes.Show
        Frm_Informes.Caption = "Informe de Basilea"
    
End Sub

Private Sub Cambio_de_Unidad_Click()
    Bac_Identificacion.Tag = 1
    Bac_Identificacion.Show 1

End Sub

Private Sub Clasificador_Riesgo_Click()
        Bac_Riesgo.Show
End Sub


Private Sub Compendio_De_Normas_Click()
    Dim Frm_Informes As New Bac_Informes
    Bac_Informe = "INFCOMP"
    Frm_Informes.Show
    Frm_Informes.Caption = "Informe Compendio De Normas"
End Sub

Private Sub Compra_Click()
    If Chequea_ControlProcesos("OP") = True Then
        giSW = "CP"
        Bac_Anulacion.Show
    End If
End Sub

Private Sub compras_Click()
    If Chequea_ControlProcesos("OP") = True Then 'And Chequea_ControlProcesos("CM") = True Then
        Bac_Compras.Show
    End If
End Sub

Private Sub Compras_del_Dia_Click()
        'Dim Frm_Informes As New Bac_Informes
        Bac_Informe = "INFCOM"
        Bac_Informes.Show

End Sub

Private Sub ConsultaDeProcesos_Click()
    Bac_Procesos.Show
End Sub

Private Sub Contabilidad_Click()

    If Chequea_ControlProcesos("CTB") = True Then
        gsRUN_Proceso = "CTB"
        BacProc.Show vbNormal
    End If

End Sub

Private Sub Copia_de_Fomulas_Click()
        Bac_Formulas_Copiar.Show
End Sub

Private Sub Datos_Para_Interfaces_Click()
    Bac_Datos_Interfaces.Show
End Sub

Private Sub Deudores_de_Inversiones_Extranjeras_Click()
    Dim Frm_Informes As New Bac_Informes
        Bac_Informe = "INFD05"
        Frm_Informes.Show
        Frm_Informes.Caption = "Deudores De Inversiones Extranjeras"
End Sub

Private Sub Devengamiento_de_Cartera_Click()

    If Chequea_ControlProcesos("DV") = True Then
        gsRUN_Proceso = "DV"
        BacProc.Show vbNormal
    End If
    
End Sub

Private Sub Emisores_Click()
        Bac_Emisores.Show
End Sub

Private Sub Encaje_Click()
    Dim Frm_Informes As New Bac_Informes
        Bac_Informe = "INFENC"
        Frm_Informes.Show
        Frm_Informes.Caption = "Informe de Encaje"
    
End Sub

Private Sub Formulas_y_Valorización_Click()
        Bac_Formulas.Show
End Sub

Private Sub generador_de_interfaces_Click()
    BacGenIfac.Show
End Sub

Private Sub inforeme_de_movimiento_de_valuta_Click()
        'Dim Frm_Informes As New Bac_Informes
        Bac_Informe = "INFMVA"
        Bac_Informes.Show
End Sub

Private Sub Información_General_Click()
        Bac_instrumentos.Show
End Sub
'+++jcamposd se agrega nueva opción de menú por Bono Brasil
Private Sub Información_General_noSerie_Click()
        Bac_instrumentos_NoSerie.Show
End Sub
'---jcamposd se agrega nueva opción de menú por Bono Brasil

Private Sub Informe_De_Cartera_Click()
    Dim Frm_Informes As New Bac_Informes
    Bac_Informe = "INFCAR"
    Frm_Informes.Show
End Sub

Private Sub Informe_Cartera_Intramesas_Click()
    Bac_InfCarteras_Vigentes.Show
End Sub

Private Sub Informe_de_Cartera_De_Valutas_Vigentes_Click()
    Dim Frm_Informes As New Bac_Informes
    Bac_Informe = "INFVALU"
    Bac_Informes.Show
End Sub

Private Sub Informe_de_Cartera_Vigente_Click()
     Dim Frm_Informes As New Bac_Informes
    Bac_Informe = "INFCARV"
    Bac_Informes.Show
End Sub

Private Sub Informe_de_Detalle_transferenciaPagos_Click()
       
End Sub

Private Sub informe_de_cartola_Click()
    Bac_Cartola.Show
End Sub

Private Sub informe_de_movimiento_Click()
        'Dim Frm_Informes As New Bac_Informes
        Bac_Informe = "INFMOV"
        Bac_Informes.Show
    
End Sub

Private Sub Informe_de_Traspaso_de_Cartera_Click()
    Dim Frm_Informes As New Bac_Informes
    Bac_Informe = "TRASC"
    Bac_Informes.Show
End Sub

Private Sub Informe_De_Vencimientos_Click()
        Dim Frm_Informes As New Bac_Informes
        Bac_Informe = "VENCI"
        Bac_Informes.Show
End Sub

Private Sub Informe_Resumen_Total_De_Cartera_Click()
    Dim Frm_Informes As New Bac_Informes
    Bac_Informe = "INFRES"
    Bac_Informes.Show
End Sub

Private Sub Informe_Voucher_Click()

    Dim Frm_Informes As New Bac_Informes
    Bac_Informe = "INFVOU"
    Bac_Informes.Show

End Sub

Private Sub Informe_Voucher_Consolidado_Click()

Dim Frm_Informes As New Bac_Informes
    Bac_Informe = "INFVOUCONS"
    Bac_Informes.Show

End Sub

Private Sub InformedeValorizacióndeMercado_Click()
    Dim Frm_Informes As New Bac_Informes
    Bac_Informe = "INFVAL"
    Bac_Informes.Show
End Sub

Private Sub Informesdeanulacion_Click()
        Dim Frm_Informes As New Bac_Informes
        Bac_Informe = "ANUCOM"
        Bac_Informes.Show
End Sub

Private Sub Intefaz_Flujos_Click()
Bac_Interfaz.Interfaz = "FLUJOS"
Bac_Interfaz.Show
End Sub

Private Sub Interfaz_Balance_por_Operación_Click()

   Bac_Interfaz.Interfaz = "BALANCES"
   Bac_Interfaz.Show


End Sub

Private Sub Interfaz_Cartera_Click()

 If Chequea_ControlProcesos("DV") = True Then
   Bac_Interfaz.Interfaz = "CARTERA"
   Bac_Interfaz.Show
End If

End Sub



Private Sub Interfaz_de_Flujos_Click()

If Chequea_ControlProcesos("DV") = True Then
   Bac_Interfaz.Interfaz = "FLUJOS"
   Bac_Interfaz.Show
End If

End Sub

Private Sub Interfaz_de_Flujos_neosoft_Click()

   Bac_Interfaz.Interfaz = "FLUJOS_NEOSOFT"
   Bac_Interfaz.Show

End Sub

Private Sub Interfaz_de_Operaciones_Click()

   Bac_Interfaz.Interfaz = "OPERACIONES"
   Bac_Interfaz.Show


End Sub

Private Sub Interfaz_Direcciones_Click()

   Bac_Interfaz.Interfaz = "DIRECCIONES"
   Bac_Interfaz.Show

End Sub

Private Sub Interfaz_P17_Click()
   
   Bac_Interfaz.Interfaz = "P17"
   Bac_Interfaz.Show

End Sub

Private Sub Interfaz_Posición_del_Cliente_Click()

   Bac_Interfaz.Interfaz = "POSICIONES"
   Bac_Interfaz.Show

End Sub

Private Sub Interfaz_Relación_entre_Deudores_Click()

   Bac_Interfaz.Interfaz = "RELACIONES"
   Bac_Interfaz.Show

End Sub

Private Sub InterfazCapXIIIanexo2_Click()
   
   Bac_Interfaz.Interfaz = "CAPXIIIANEXO2"
   Bac_Interfaz.Show

End Sub

Private Sub InterfazCapXIIIanexo3_Click()

   Bac_Interfaz.Interfaz = "CAPXIIIANEXO3"
   Bac_Interfaz.Show

End Sub

Private Sub MDIForm_Activate()

   Dim a As Integer
   Dim SQL As String
   Dim cPict As String
   Dim Datos()

   Screen.MousePointer = 11

   BAC_INVERSIONES.Caption = "BAC-Invext  ( " + Trim(gsSQL_Server$) + " \ " + Trim(gsSQL_Database) + " )"
 
   If Not gsBac_Login Then
      
        If Not Proc_Carga_Parametros Then
            MsgBox "Error en la recuperación de datos de parámetros.", vbCritical, gsBac_Version
            End
         End If
         Call DESHABILITA_MENU
         
         Screen.MousePointer = 0
    '+++cvegasan 2017.06.05 HOM Ex-Itau funciones de ventana de login
        If giSQL_ConnectionMode <> 3 Then
    '---cvegasan 2017.06.05 HOM Ex-Itau funciones de ventana de login
        Acceso_Usuario.Show 1
    '+++cvegasan 2017.06.05 HOM Ex-Itau funciones de ventana de login
        Else
            If Func_Valida_Login(gsBac_User) = False Then End
        End If
    '---cvegasan 2017.06.05 HOM Ex-Itau funciones de ventana de login
      If gsBac_Login Then
         Screen.MousePointer = 11
         Call PROC_CARGA_PRIVILEGIOS
         Screen.MousePointer = 0
         
      Else
         Unload Me
         Exit Sub
      End If
       '+++cvegasan 2017.06.05 HOM Ex-Itau
        Call GRABA_LOG_AUDITORIA("1", _
                                    Format(gsBac_Fecp, "YYYYMMDD"), _
                                    gsBac_IP, _
                                    gsBac_User, _
                                    "BCC", _
                                    "", _
                                    "05", _
                                    "Ingreso al Sistema", _
                                    "", _
                                    "", _
                                    "")
        '---cvegasan 2017.06.05 HOM Ex-Itau
    End If
 
    Screen.MousePointer = 0
    End Sub
    
Sub MENU_TODOHABILITADO()
   'Habilita todas los ítemes del menú
   Dim i%
   On Error Resume Next
   For i% = 0 To Me.Controls.Count - 1
      If TypeOf Me.Controls(i%) Is Menu Then
         If Me.Controls(i%).Caption <> "-" And Me.Controls(i%).Caption <> "?" And Me.Controls(i%).Caption <> "Salir" And Me.Controls(i%).Caption <> "Salir del Sistema" And Me.Controls(i%).Caption <> "Generador de Interfaces" And Me.Controls(i%).Caption <> "Datos Para Interfaces" Then
            Me.Controls(i%).Visible = True
         End If
      End If
      If TypeOf Me.Controls(i%) Is CommandButton Then
         Me.Controls(i%).Enabled = True
      End If

    Next i%
          
End Sub

    
Sub PROC_CARGA_PRIVILEGIOS()
    Dim Datos()
    Dim i%
    Dim Comando As String

If Trim(gsBac_User) = "ADMINISTRA" Then
    Call MENU_TODOHABILITADO
    Exit Sub
End If

envia = Array()
AddParam envia, "T"
AddParam envia, "BEX"
AddParam envia, gsBac_Tipo_Usuario

If Not Bac_Sql_Execute("SP_BUSCA_PRIVILEGIOS", envia) Then
   Exit Sub
End If

' BUSCA LAS OPCIONES POR TIPO DE USUARIO
Do While Bac_SQL_Fetch(Datos)
   On Error Resume Next
   For i% = 0 To Me.Controls.Count - 1
      If TypeOf Me.Controls(i%) Is Menu Then
         If Trim(Me.Controls(i%).Name) = Trim(Datos(1)) Then
            Me.Controls(i%).Visible = True
         End If
       End If
       If TypeOf Me.Controls(i%) Is CommandButton Then
         If Trim(Me.Controls(i%).Name) = "B" + Trim(Datos(1)) Then
            Me.Controls(i%).Enabled = True
         End If
       End If
   Next i%
Loop

' BUSCA LAS OPCIONES POR USUARIO

envia = Array()
AddParam envia, "U"
AddParam envia, "BEX"
AddParam envia, gsBac_User

If Not Bac_Sql_Execute("SP_BUSCA_PRIVILEGIOS", envia) Then
   Exit Sub
End If

' BUSCA LAS OPCIONES DEL USUARIO Y LAS HABILITA
Do While Bac_SQL_Fetch(Datos)
   On Error Resume Next
   For i% = 0 To Me.Controls.Count - 1
       If TypeOf Me.Controls(i%) Is Menu Then
          If Trim(Me.Controls(i%).Name) = Trim(Datos(1)) Then
            Me.Controls(i%).Visible = IIf(Mid(Datos(2), 1, 1) = "N", False, True)
         End If
       End If
       If TypeOf Me.Controls(i%) Is CommandButton Then
          If Trim(Me.Controls(i%).Name) = "B" + Trim(Datos(1)) Then
            Me.Controls(i%).Enabled = IIf(Mid(Datos(2), 1, 1) = "N", False, True)
         End If
      End If
   Next i%
Loop
End Sub
'Function BAC_Login(sUser$, sPWD$) As Boolean
'
'    BAC_Login = False
'
'    miSQL.Servername = gsSQL_Server$
'    miSQL.HostName = gsBac_Term
'    miSQL.Application = "INVERSIONES EXTERIOR"
'    miSQL.ConnectionMode = 2
'    miSQL.DatabaseName = gsSQL_Database
'    miSQL.Login = sUser$
'    miSQL.Password = sPWD$
'    miSQL.LoginTimeout = giSQL_LoginTimeOut
'    miSQL.QueryTimeout = giSQL_QueryTimeOut
'
'    If miSQL.SQL_Coneccion() = False Then
'        Call miSQL.SQL_Close
'        Exit Function
'    End If
'
'    BAC_Login = True
'
'End Function
Private Function BAC_Login(sUser$, sPWD$) As Boolean
   
'      BAC_Login = False
'
'      If giSQL_ConnectionMode = 1 Then
'         SQL_Setup gsSQL_Server$, gsSQL_Login$, gsSQL_Password$, gsSQL_Database, gsBac_User, gsBac_Term, giSQL_LoginTimeOut, giSQL_QueryTimeOut
'      Else
'         SQL_Setup gsSQL_Server$, sUser$, sPWD$, gsSQL_Database, gsBac_User, gsBac_Term, giSQL_LoginTimeOut, giSQL_QueryTimeOut
'      End If
'
'      If miSQL.SQL_Coneccion() = False Then
'         Exit Function
'      End If
'
'      BAC_Login = True

   BAC_Login = False
'+++cvegasan 2017.06.05 HOM Ex-Itau
   If giSQL_ConnectionMode = 3 Then
        gsBac_User = UCase(Trim(Environ("username")))
        gsBac_Term = Trim(Environ("userdomain"))
        miSQL.Login = gsBac_User
   End If
'---cvegasan 2017.06.05 HOM Ex-Itau

   miSQL.Servername = gsSQL_Server$
   miSQL.HostName = gsBac_Term
   miSQL.Application = "INVERSIONES EXTERIOR"
   miSQL.ConnectionMode = giSQL_ConnectionMode
   miSQL.DatabaseName = gsSQL_Database
   gsBac_IP = BAC_INVERSIONES.NomObjWinIP.LocalIP
   
 
   If giSQL_ConnectionMode = 1 Then
      miSQL.Login = gsSQL_Login$
      miSQL.Password = gsSQL_Password$
        gsBac_User = UCase(Trim(Environ("username")))
        gsBac_Term = Trim(Environ("ComputerName"))
   ElseIf giSQL_ConnectionMode = 2 Then
      miSQL.Login = sUser$
      miSQL.Password = sPWD$
 
   End If
 
'   If giSQL_ConnectionMode = 1 Then
'      miSQL.Login = gsSQL_Login$
'      miSQL.Password = gsSQL_Password$
'
'   ElseIf giSQL_ConnectionMode = 2 Then
'      miSQL.Login = sUser$
'      miSQL.Password = sPWD$
'
'   End If
 
   miSQL.LoginTimeout = giSQL_LoginTimeOut
   miSQL.QueryTimeout = giSQL_QueryTimeOut
 
   If miSQL.SQL_Coneccion() = False Then
       BAC_Login = False
       Exit Function

   End If

    BAC_Login = True
 

End Function

Private Sub MDIForm_Load()

   Screen.MousePointer = 11
   
   If App.PrevInstance Then
      Screen.MousePointer = 0
      MsgBox "Sistema Esta Cargado en Memoria.", vbExclamation, gsBac_Version
      End
   End If
   
'  If Not Valida_Configuracion_Regional() Then End
   
   Call BacInit    ' Parametros de Inicio.-

   Tmrfecha.Enabled = True
   Tmrfecha.Interval = gsBac_Timer

gsSQL_Login = Func_Read_INI("usuario", "usuario", App.Path & "\Bac-Sistemas.INI")
gsSQL_Password = Func_Read_INI("usuario", "password", App.Path & "\Bac-Sistemas.INI")
CONECCION = "DSN=SQL_INVEX;UID="
CONECCION = CONECCION & gsSQL_Login
CONECCION = CONECCION & ";PWD="
CONECCION = CONECCION & gsSQL_Password
CONECCION = CONECCION & ";DSQ=BACBONOSEXTsuda"
   
    If Not BAC_Login(gsSQL_Login, gsSQL_Password) Then
      Screen.MousePointer = 0
      MsgBox "Problemas de Comunicación con el Servidor SQL", vbCritical, TITSISTEMA
      End
   End If
     
     
     If Mid(Command, 1, 11) = "GENERA_MENU" Then
      PROC_GENERA_MENU "BEX"
      Call miSQL.SQL_Close
      Screen.MousePointer = 0
      End
   End If
   
   Screen.MousePointer = 0
  
 
End Sub

Private Sub Bloqueo_de_Mesa_Click()

    If Chequea_ControlProcesos("CM") Then
        Frm_Cierra_Mesa.Show              'vbNormal%
    End If
        
End Sub

Private Sub Fin_De_Dia_Click()

    If Chequea_ControlProcesos("FD") = True Then
        gsRUN_Proceso = "FD"
'        BacProc.Show vbNormal
        FRM_PROC_FDIA.Show
    End If
    
End Sub

Private Sub Inicio_De_Dia_Click()
    If Chequea_ControlProcesos("ID") = True Then
        BacIniDia.Show
    End If
End Sub

Private Sub MDIForm_Unload(Cancel As Integer)

    If MsgBox("¿Esta Seguro que desea salir de BacInversiones?", vbQuestion + vbYesNo, "Inversion Exterior") = vbNo Then
        Cancel = 1
        Exit Sub
    End If

End Sub

Private Sub nterfaz_Contable_Click()

''''    If Chequea_ControlProcesos("CTB") = True Then
''''        Bac_Interfaz.Interfaz = "CONTABLE"
''''        Bac_Interfaz.Show
''''    End If

''''    Se comenta, ya que interfaz se esta generando automáticamente al realizar la contabilidad
End Sub

Private Sub Op_intramesas_Click()
'Operaciones Intramesas
    Bac_Informes_Intramesas.Show
End Sub

Private Sub OpcInterfazP40_Click()
    Let Bac_Interfaz.Interfaz = "P40"
   Call Bac_Interfaz.Show
End Sub

Private Sub reimp_papeletas_Click()

    Bac_Reimp_papeletas.Show
End Sub

Private Sub Riesgo_País_Click()

'        Bac_entidad.Show
'        Bac_entidad.Caption = "Riesgo País"

End Sub

Private Sub Salir_Click()

'    If MsgBox("Seguro de Salir del Sistema", vbYesNo + vbQuestion, gsBac_Version) = vbYes Then
        Unload Me
'    End If
End Sub

Private Sub Tabla_de_Desarrollo_Click()
        Bac_Tabla_Desarrollo.Show
End Sub

Private Sub Tasas_Vigentes_Click()
    If Chequea_ControlProcesos("TM") = True Then
         Bac_Valorizacion_Mercado.Show
    End If
    'Bac_Valorizacion_Mercado.Show
End Sub


Private Sub Tmrfecha_Timer()
Static Intervalo As Long
Intervalo = Intervalo + Tmrfecha.Interval
    If Intervalo > gsBac_Timer_Adicional Then
    Intervalo = 0
        If Not Proc_Valida_Fecha Then
            End
        End If
    End If
End Sub

Private Sub Traspaso_de_Cartera_Click()
    If Chequea_ControlProcesos("TC") Then
        Bac_Traspaso_de_Cartera.Show
    End If
End Sub

Private Sub ven_ta_Click()
    giSW = "VP"
    Bac_Reimp_papeletas.Show
End Sub

Private Sub Valorizador_Click()
    Bac_Valorizador.Show
End Sub

Private Sub Venta_Click()
    If Chequea_ControlProcesos("OP") = True Then
        giSW = "VP"
        Bac_Anulacion.Show
    End If
End Sub

Private Sub ventas_Click()
    If Chequea_ControlProcesos("OP") = True Then
        'Bac_Ventas_Filtro.Show
        BacIrfNueVentana "VP"
    End If
End Sub


Private Sub Ventas_del_Dia_Click()
        'Dim Frm_Informes As New Bac_Informes
        Bac_Informe = "INFVEN"
        Bac_Informes.Show
End Sub

Sub Informe_Compras_del_dia(Param)
    
    BAC_INVERSIONES.BacRpt.ReportFileName = RptList_Path & "INFORME_COMPRAS.RPT"
    BAC_INVERSIONES.BacRpt.WindowTitle = "Compras del Dia"
    BAC_INVERSIONES.BacRpt.StoredProcParam(0) = Param
    BAC_INVERSIONES.BacRpt.Connect = CONECCION
    BAC_INVERSIONES.BacRpt.Action = 1
     Screen.MousePointer = 0
    Call limpiar_cristal

End Sub

Sub limpiar_cristal()
Dim i As Integer
   For i = 0 To 20
        BAC_INVERSIONES.BacRpt.StoredProcParam(i) = ""
        BAC_INVERSIONES.BacRpt.Formulas(i) = ""
   Next i
   
   BAC_INVERSIONES.BacRpt.WindowTitle = ""

End Sub


