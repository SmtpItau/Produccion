VERSION 5.00
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.3#0"; "comctl32.ocx"
Begin VB.Form BacDevengamiento_Ticket 
   AutoRedraw      =   -1  'True
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Devengamiento o Valorización de Ticket Intra Mesa"
   ClientHeight    =   1455
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   10935
   Icon            =   "BacDevengamiento_Ticket.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   1455
   ScaleWidth      =   10935
   ShowInTaskbar   =   0   'False
   Begin ComctlLib.Toolbar Toolbar2 
      Height          =   480
      Left            =   15
      TabIndex        =   5
      Top             =   0
      Width           =   10830
      _ExtentX        =   19103
      _ExtentY        =   847
      ButtonWidth     =   767
      ButtonHeight    =   741
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   327682
      BeginProperty Buttons {0713E452-850A-101B-AFC0-4210102A8DA7} 
         NumButtons      =   2
         BeginProperty Button1 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Object.ToolTipText     =   "Procesar"
            Object.Tag             =   ""
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Object.ToolTipText     =   "Cancelar y Salir"
            Object.Tag             =   ""
            ImageIndex      =   3
         EndProperty
      EndProperty
   End
   Begin ComctlLib.Toolbar Toolbar1 
      Height          =   660
      Left            =   180
      TabIndex        =   0
      Top             =   4035
      Visible         =   0   'False
      Width           =   8190
      _ExtentX        =   14446
      _ExtentY        =   1164
      ButtonWidth     =   1032
      ButtonHeight    =   1005
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList"
      _Version        =   327682
      BeginProperty Buttons {0713E452-850A-101B-AFC0-4210102A8DA7} 
         NumButtons      =   5
         BeginProperty Button1 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Description     =   "Devengar"
            Object.ToolTipText     =   "Devengar y Valorizar"
            Object.Tag             =   ""
            ImageIndex      =   1
            Style           =   1
         EndProperty
         BeginProperty Button2 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Object.Tag             =   ""
            Style           =   3
            MixedState      =   -1  'True
         EndProperty
         BeginProperty Button3 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Description     =   "Cancela Devengo y Valorización"
            Object.ToolTipText     =   "Cancela Devengo y Valorización"
            Object.Tag             =   ""
            ImageIndex      =   2
         EndProperty
         BeginProperty Button4 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Object.Tag             =   ""
            Style           =   3
            MixedState      =   -1  'True
         EndProperty
         BeginProperty Button5 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Caption         =   "Imprimir"
            Description     =   "Imprimir problemas detectados por Devengamiento"
            Object.ToolTipText     =   "Imprimir problemas detectados por Devengamiento"
            Object.Tag             =   ""
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin VB.Frame Frame1 
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   11.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FF0000&
      Height          =   3075
      Left            =   30
      TabIndex        =   1
      Tag             =   "Procesando ..."
      Top             =   480
      Width           =   10860
      Begin VB.Frame Frame2 
         Caption         =   "Problemas detectados en procesos ..."
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   12
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   -1  'True
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H000000C0&
         Height          =   1935
         Left            =   120
         TabIndex        =   3
         Top             =   1080
         Width           =   10635
         Begin VB.ListBox lstProblemas 
            BeginProperty Font 
               Name            =   "Courier New"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   1320
            ItemData        =   "BacDevengamiento_Ticket.frx":000C
            Left            =   120
            List            =   "BacDevengamiento_Ticket.frx":000E
            TabIndex        =   4
            Top             =   360
            Width           =   10425
         End
      End
      Begin ComctlLib.ProgressBar Barra 
         Height          =   330
         Left            =   75
         TabIndex        =   2
         Top             =   405
         Width           =   10605
         _ExtentX        =   18706
         _ExtentY        =   582
         _Version        =   327682
         BorderStyle     =   1
         Appearance      =   1
      End
   End
   Begin ComctlLib.ImageList ImageList1 
      Left            =   3195
      Top             =   2025
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   327682
      BeginProperty Images {0713E8C2-850A-101B-AFC0-4210102A8DA7} 
         NumListImages   =   3
         BeginProperty ListImage1 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "BacDevengamiento_Ticket.frx":0010
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "BacDevengamiento_Ticket.frx":032A
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "BacDevengamiento_Ticket.frx":0644
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin ComctlLib.ImageList ImageList 
      Left            =   6000
      Top             =   720
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   32
      ImageHeight     =   32
      MaskColor       =   12632256
      _Version        =   327682
      BeginProperty Images {0713E8C2-850A-101B-AFC0-4210102A8DA7} 
         NumListImages   =   3
         BeginProperty ListImage1 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "BacDevengamiento_Ticket.frx":095E
            Key             =   "Aceptar"
            Object.Tag             =   "Aceptar"
         EndProperty
         BeginProperty ListImage2 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "BacDevengamiento_Ticket.frx":0C78
            Key             =   "Cancelar"
            Object.Tag             =   "Cancelar"
         EndProperty
         BeginProperty ListImage3 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "BacDevengamiento_Ticket.frx":0F92
            Key             =   "Imprimir"
            Object.Tag             =   "Imprimir"
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "BacDevengamiento_Ticket"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
'Bitacora de modificaciones
'Fecha: 28/06/2005
'Autor: Alexis Lopez.
'Solicitado por: Cristian Mascareño
'Observaciones: Incluye calculo de saldos C08 para interfaz de flujos.

Dim Nada As Boolean

Private Sub Devengar()
   Dim i&, t%
   Dim SQL$, Msg$, MsgVal$
   Dim Oper(), DATOS()
   Dim FechaOpeAnt As String
   
   
   Frame1.Caption = "Generando UF Proyectada para Contratos en Moneda UF."
   Call Frame1.Refresh
   Call BacControlWindows(10)
   
   Envia = Array()
   AddParam Envia, gsBAC_Fecp
   If Not Bac_Sql_Execute("SRV_CALCULA_UF_PROYECTADA_TICKET", Envia) Then
      MsgBox "Error de generación" & vbCrLf & vbCrLf & "Se ha generado un error al generar UF Proyectada para contratos en UF.", vbExclamation, App.Title
   End If

   Nada = False
   Screen.MousePointer = vbHourglass
   Toolbar2.Buttons(1).Enabled = False
   
   If Not Bac_Sql_Execute("SELECT numero_operacion FROM TBL_FLJTICKETSWAP GROUP BY numero_operacion ORDER BY numero_operacion") Then
      Screen.MousePointer = vbDefault
      Toolbar2.Buttons(1).Enabled = True
      MsgBox "Problemas al intentar rescatar la cantidad de Operaciones Vigentes", vbCritical, "Devengamiento"
      Exit Sub
   End If
    
   t = 0
   
   Do While Bac_SQL_Fetch(DATOS)
      t = t + 1
      ReDim Preserve Oper(t)
      Oper(t) = Val(DATOS(1))
   Loop
    
   If t = 0 Then
      Screen.MousePointer = vbDefault
      Toolbar2.Buttons(1).Enabled = True
      Nada = True
      
      MsgBox "No existen Operaciones Vigentes", vbCritical, "Devengar"
      
      If (MsgBox("Desea Realizar Devengamiento (Sin Operaciones)", vbYesNo + vbQuestion)) = vbYes Then
         Call gsc_Parametros.CambiaFlags(1, 1)
      End If
      Exit Sub
   End If
    
   '---- Devenga y Valoriza Operaciones
   
   Barra.Max = t
   Barra.Min = 0
   
   Call lstProblemas.Clear
   
   For i = 1 To t
      Msg = ""
      Frame1.Caption = "Procesando Operación N° " & Str(CDbl(Oper(i)))

      Envia = Array()
      AddParam Envia, CDbl(Oper(i))
      
      If Not Bac_Sql_Execute("SP_DEVENGAMIENTO_TICKET", Envia) Then
         Msg = " - Operación no se pudo Devengar. N° " & Oper(i)
      End If
      
      If Bac_SQL_Fetch(DATOS()) Then
         If Val(DATOS(1)) < 0 Then
            Msg = "Operación N° " & Oper(i)
            Msg = Msg & Space(1) & DATOS(2)
         End If
      Else
      End If
'
      Call BacControlWindows(1)
   Next i
       
   Frame1.Caption = "Proceso Finalizado."
   
'   If lstProblemas.ListCount >= 1 Then
'      FrmAvisoValorizacion.Show
'      FrmAvisoValorizacion.ListProblemasValoriza.Clear
'
'      Dim iRegistros As Long
'      For iRegistros = 0 To lstProblemas.ListCount - 1
'         FrmAvisoValorizacion.ListProblemasValoriza.AddItem lstProblemas.List(iRegistros)
'      Next iRegistros
'      Call gsc_Parametros.CambiaFlags(1, 0)
'   Else
      Call gsc_Parametros.CambiaFlags(1, 1)
'   End If
   
   Toolbar2.Buttons(1).Enabled = True
   
End Sub

'Private Sub Valorizar()
'Dim i&, t%
'Dim SQL$, Msg$
'Dim Oper(), DATOS()
'
'  Nada = False
'
'    '---- Captura Operaciones Vigentes
'    SQL = "SELECT DISTINCT numero_operacion FROM TBL_FLJTICKETSWAP"
'    If MISQL.SQL_Execute(SQL) <> 0 Then
'        Screen.MousePointer = 0
'        MsgBox "Problemas al intentar rescatar la cantidad de Operaciones Vigentes", vbCritical, "Valorización"
'        Exit Sub
'    End If
'
'    t = 0
'    Do While MISQL.SQL_Fetch(DATOS) = 0
'        t = t + 1
'        ReDim Preserve Oper(t)
'        Oper(t) = Val(DATOS(1))
'    Loop
'
'    If t = 0 Then
'       Screen.MousePointer = 0
'       MsgBox "No existen Operaciones Vigentes", vbCritical, "Valorización"
'       Nada = True
'       Exit Sub
'    End If
'
'    '---- Devenga y Valoriza Operaciones
'    Barra.Max = t
'    Barra.Min = 0
'    lstProblemas.Clear
'    For i = 1 To t
'        Barra.Value = i
'        Msg = ""
'        SQL = "EXECUTE SP_VALORIZA_TICKET " & Oper(i)
'
'        Envia = Array()
'        AddParam Envia, CDbl(Oper(i))
'
'
'        If Not Bac_Sql_Execute("SP_VALORIZA_TICKET", Envia) Then
'            Msg = "No se pudo Valorizar Operación # " & Oper(i)
'
'        ElseIf Bac_SQL_Fetch(DATOS()) Then
'            If Val(DATOS(1)) < 0 Then
'
'                Msg = "Operación # " & Oper(i)
'                Msg = Msg & Space(1) & DATOS(2)
'
'            End If
'        End If
'        If Len(Msg) > 0 Then
'            lstProblemas.AddItem Msg
'        End If
'    Next i
'
'End Sub

Private Sub Form_Activate()
  If Me.Tag = "DEV" Then
        Me.Caption = "Devengamiento de Carteras de Ticket Intra Mesa"
    Else
        Me.Caption = "Valorización de Carteras de Ticket Intra Mesa"
    End If
    
    Toolbar1.Buttons(5).Visible = False

End Sub

Private Sub Form_Load()
    Me.Icon = BACSwap.Icon
    Me.Top = 0
    Me.Left = 0
    Nada = False
End Sub


'Private Function FUNC_VALIDA_CURVAS() As Boolean
'   Dim DATOS()
'   Dim cCadena    As String
'   Dim iError     As Integer
'   Dim iContador  As Long
'
'   FUNC_VALIDA_CURVAS = False
'
'   Call lstProblemas.Clear
'   iContador = 0
'
'   Envia = Array()
'   AddParam Envia, Format(gsBAC_Fecp, "yyyymmdd")
'   AddParam Envia, 0
'   If Not Bac_Sql_Execute("SP_VERIFICA_EXISTENCIA_TASAS_TICKET", Envia) Then
'      Exit Function
'   End If
'   Do While Bac_SQL_Fetch(DATOS())
'      iContador = iContador + 1
'   Loop
'
'   If iContador > 0 Then
'      Call BacLimpiaParamCrw
'      BACSwap.Crystal.Destination = crptToWindow
'      BACSwap.Crystal.ReportFileName = gsRPT_Path & "INFORME_ERRORES_CURVAS_TICKET.rpt"
'         '--> Store Procedure : dbo.SP_VERIFICA_EXISTENCIA_TASAS.sql
'      BACSwap.Crystal.WindowTitle = "Informe de Cartera Swap."
'      BACSwap.Crystal.StoredProcParam(0) = Format(gsBAC_Fecp, "yyyy-mm-dd 00:00:00.000")
'      BACSwap.Crystal.StoredProcParam(1) = CDbl(1)
'      BACSwap.Crystal.Connect = swConeccion
'      BACSwap.Crystal.Action = 1
'   Else
'      FUNC_VALIDA_CURVAS = True
'   End If
'
'End Function

Private Sub Toolbar2_ButtonClick(ByVal Button As ComctlLib.Button)
   Dim SQL$, Parametro$

   Screen.MousePointer = vbHourglass

   If ChequeaICPdelDia = False Then
      MsgBox "Acción Cancelada" & vbCrLf & vbCrLf & "No se ha ingresado el Indice Camara Promedio para el Día.", vbExclamation, TITSISTEMA
      Screen.MousePointer = vbDefault

      Exit Sub
   End If


   If Button.Index = 1 Then
      Toolbar1.Buttons(5).Visible = False
      Frame1.Caption = Frame1.Tag
      Frame1.Height = 880: Me.Height = 2150: Call Me.Refresh

      If Me.Tag = "DEV" Then

         Call Devengar

         If lstProblemas.ListCount > 0 Then
            Toolbar1.Buttons(5).Visible = True
            Frame1.Height = 3120:  Me.Height = 4350
            Frame1.Caption = "Problemas con el Devengamiento ..."
         Else
            If Not Nada Then
               Frame1.Caption = "Devengamiento , Ok !!!"
               Me.Barra.Value = 0
            End If
         End If
         Toolbar1.Buttons(1).Value = tbrUnpressed
'      Else
'         Call Valorizar
'         Frame1.Caption = "Valorización Terminada !!!"
'         Me.Barra.Value = 0
'         Toolbar1.Buttons(1).Value = tbrUnpressed
      End If

      Call Me.Refresh
   End If

   If Button.Index = 2 Then
      Screen.MousePointer = 0
      Call Unload(Me)
   End If

   Screen.MousePointer = 0
   
End Sub

