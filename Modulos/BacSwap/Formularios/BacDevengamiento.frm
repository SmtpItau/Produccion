VERSION 5.00
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.3#0"; "COMCTL32.OCX"
Begin VB.Form BacDevengamiento 
   AutoRedraw      =   -1  'True
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Devengamiento o Valorización"
   ClientHeight    =   1455
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   10935
   Icon            =   "BacDevengamiento.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   1455
   ScaleWidth      =   10935
   ShowInTaskbar   =   0   'False
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
            Key             =   ""
            Description     =   "Devengar"
            Object.ToolTipText     =   "Devengar y Valorizar"
            Object.Tag             =   ""
            ImageIndex      =   1
            Style           =   1
         EndProperty
         BeginProperty Button2 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Key             =   ""
            Object.Tag             =   ""
            Style           =   3
            MixedState      =   -1  'True
         EndProperty
         BeginProperty Button3 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Key             =   ""
            Description     =   "Cancela Devengo y Valorización"
            Object.ToolTipText     =   "Cancela Devengo y Valorización"
            Object.Tag             =   ""
            ImageIndex      =   2
         EndProperty
         BeginProperty Button4 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Key             =   ""
            Object.Tag             =   ""
            Style           =   3
            MixedState      =   -1  'True
         EndProperty
         BeginProperty Button5 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Caption         =   "Imprimir"
            Key             =   ""
            Description     =   "Imprimir problemas detectados por Devengamiento"
            Object.ToolTipText     =   "Imprimir problemas detectados por Devengamiento"
            Object.Tag             =   ""
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
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
            Key             =   ""
            Object.ToolTipText     =   "Procesar"
            Object.Tag             =   ""
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Key             =   ""
            Object.ToolTipText     =   "Cancelar y Salir"
            Object.Tag             =   ""
            ImageIndex      =   3
         EndProperty
      EndProperty
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
            ItemData        =   "BacDevengamiento.frx":000C
            Left            =   120
            List            =   "BacDevengamiento.frx":000E
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
            Picture         =   "BacDevengamiento.frx":0010
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "BacDevengamiento.frx":032A
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "BacDevengamiento.frx":0644
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
            Picture         =   "BacDevengamiento.frx":095E
            Key             =   "Aceptar"
            Object.Tag             =   "Aceptar"
         EndProperty
         BeginProperty ListImage2 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "BacDevengamiento.frx":0C78
            Key             =   "Cancelar"
            Object.Tag             =   "Cancelar"
         EndProperty
         BeginProperty ListImage3 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "BacDevengamiento.frx":0F92
            Key             =   "Imprimir"
            Object.Tag             =   "Imprimir"
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "BacDevengamiento"
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
   Dim Oper(), Datos()
   Dim FechaOpeAnt As String
   
   
   Let Frame1.Caption = "Generando UF Proyectada para Contratos en Moneda UF."
   Call Frame1.Refresh
   Call BacControlWindows(10)
   
   Envia = Array()
   AddParam Envia, gsBAC_Fecp
   If Not Bac_Sql_Execute("SRV_CALCULA_UF_PROYECTADA", Envia) Then
      MsgBox "Error de generación" & vbCrLf & vbCrLf & "Se ha generado un error al generar UF Proyectada para contratos en UF.", vbExclamation, App.Title
   End If

   Let Nada = False
   Let Screen.MousePointer = vbHourglass
   Let Toolbar2.Buttons(1).Enabled = False
   
   If Not Bac_Sql_Execute("SELECT numero_operacion FROM CARTERA GROUP BY numero_operacion ORDER BY numero_operacion") Then
      Let Screen.MousePointer = vbDefault
      Let Toolbar2.Buttons(1).Enabled = True
      MsgBox "Problemas al intentar rescatar la cantidad de Operaciones Vigentes", vbCritical, "Devengamiento"
      Exit Sub
   End If
    
   Let t = 0
   
   Do While Bac_SQL_Fetch(Datos)
      Let t = t + 1
      ReDim Preserve Oper(t)
      Let Oper(t) = Val(Datos(1))
   Loop
    
   If t = 0 Then
      Let Screen.MousePointer = vbDefault
      Let Toolbar2.Buttons(1).Enabled = True
      Let Nada = True
      
      MsgBox "No existen Operaciones Vigentes", vbCritical, "Devengar"
      
      If (MsgBox("Desea Realizar Devengamiento (Sin Operaciones)", vbYesNo + vbQuestion)) = vbYes Then
         Call gsc_Parametros.CambiaFlags(1, 1)
      End If
      Exit Sub
   End If
    
   '---- Devenga y Valoriza Operaciones
   
   Let Barra.Max = t
   Let Barra.Min = 0
   
   Call lstProblemas.Clear
   
   For i = 1 To t
''''      Let Barra.Value = i
      
      Let Msg = ""
      Let Frame1.Caption = "Procesando Operación N° " & Str(CDbl(Oper(i)))

      '-->   Devenganmiento Operación por Operación
      Envia = Array()
      AddParam Envia, CDbl(Oper(i))
      
      If Not Bac_Sql_Execute("SP_DEVENGAMIENTO", Envia) Then
         Let Msg = " - Operación no se pudo Devengar. N° " & Oper(i)
      End If
      
      If Bac_SQL_Fetch(Datos()) Then
         If Val(Datos(1)) < 0 Then
            Let Msg = "Operación N° " & Oper(i)
            Let Msg = Msg & Space(1) & Datos(2)
         End If
      End If
      
      If Len(Msg) > 0 Then
         Call lstProblemas.AddItem(Msg)
      End If

      '-->   ActivoPasivo_C08 Operación por Operación
      Envia = Array()
      AddParam Envia, Format(gsBAC_Fecp, "yyyymmdd")
      AddParam Envia, CDbl(Oper(i))
      
      If Not Bac_Sql_Execute("SP_CALCULO_ACTPAS_C08", Envia) Then
         MsgBox "Problemas al actualizar saldos Activos y Pasivos C08", vbCritical, gsBAC_Version
         Exit Sub
      End If
      
      If Bac_SQL_Fetch(Datos()) Then
         If Datos(1) <> 1 Then
            MsgVal = "Problemas en Valorización con Operación # " & Datos(2)
            MsgVal = MsgVal & Space(1) & Datos(5)
         End If
         If Len(MsgVal) > 0 Then
            lstProblemas.AddItem MsgVal
         End If
      End If

      Barra.Value = i

      Call BacControlWindows(1)
   Next i
       
   Let Frame1.Caption = "Proceso Finalizado."
   
   If lstProblemas.ListCount >= 1 Then
      FrmAvisoValorizacion.Show
      FrmAvisoValorizacion.ListProblemasValoriza.Clear
      
      Dim iRegistros As Long
      For iRegistros = 0 To lstProblemas.ListCount - 1
         FrmAvisoValorizacion.ListProblemasValoriza.AddItem lstProblemas.List(iRegistros)
      Next iRegistros
      Call gsc_Parametros.CambiaFlags(1, 0)
   Else
      Call gsc_Parametros.CambiaFlags(1, 1)
   End If
   
    ''''   Let Barra.Value = 100
   Let Toolbar2.Buttons(1).Enabled = True
   
End Sub
Private Sub Valorizar()
Dim i&, t%
Dim SQL$, Msg$
Dim Oper(), Datos()

  Nada = False

    '---- Captura Operaciones Vigentes
    SQL = "SELECT DISTINCT numero_operacion FROM cartera"
    If MISQL.SQL_Execute(SQL) <> 0 Then
        Screen.MousePointer = 0
        MsgBox "Problemas al intentar rescatar la cantidad de Operaciones Vigentes", vbCritical, "Valorización"
        Exit Sub
    End If
    
    t = 0
    Do While MISQL.SQL_Fetch(Datos) = 0
        t = t + 1
        ReDim Preserve Oper(t)
        Oper(t) = Val(Datos(1))
    Loop
    
    If t = 0 Then
       Screen.MousePointer = 0
       MsgBox "No existen Operaciones Vigentes", vbCritical, "Valorización"
       Nada = True
       Exit Sub
    End If
    
    '---- Devenga y Valoriza Operaciones
    Barra.Max = t
    Barra.Min = 0
    lstProblemas.Clear
    For i = 1 To t
        Barra.Value = i
        Msg = ""
        SQL = "EXECUTE SP_VALORIZA " & Oper(i)
        
        Envia = Array()
        AddParam Envia, CDbl(Oper(i))
        

        If Not Bac_Sql_Execute("SP_VALORIZA", Envia) Then
            Msg = "No se pudo Valorizar Operación # " & Oper(i)

        ElseIf Bac_SQL_Fetch(Datos()) Then
            If Val(Datos(1)) < 0 Then

                Msg = "Operación # " & Oper(i)
                Msg = Msg & Space(1) & Datos(2)

            End If
        End If
        If Len(Msg) > 0 Then
            lstProblemas.AddItem Msg
        End If
    Next i

End Sub

Private Sub Form_Activate()
  If Me.Tag = "DEV" Then
        Me.Caption = "Devengamiento de Carteras"
    Else
        Me.Caption = "Valorización de Carteras"
    End If
    
    Toolbar1.Buttons(5).Visible = False

End Sub

Private Sub Form_Load()
Me.Icon = BACSwap.Icon
  Nada = False
  
End Sub

'Private Sub Toolbar1_ButtonClick(ByVal Button As ComctlLib.Button)
'
'Dim Sql$, Parametro$
'
'    Screen.MousePointer = 11
'
'    Call BacLimpiaParamCrw
'
'    If Button.Index = 1 Then
'        Toolbar1.Buttons(5).Visible = False
'        Frame1.Caption = Frame1.Tag
'        Frame1.Height = 880
'        Me.Height = 2150
'        Me.Refresh
'        If Me.Tag = "DEV" Then
'            Call Devengar
'            If lstProblemas.ListCount > 0 Then
'                Toolbar1.Buttons(5).Visible = True
'                Frame1.Height = 3120
'                Me.Height = 4350
'                Frame1.Caption = "Problemas con el Devengamiento ..."
'            Else
'                 If Not Nada Then
'                     Frame1.Caption = "Devengamiento , Ok !!!"
'                     Me.Barra.Value = 0
'                 End If
'            End If
'            Toolbar1.Buttons(1).Value = tbrUnpressed
'        Else
'
'            Call Valorizar
'
'            If lstProblemas.ListCount > 0 Then
'                Toolbar1.Buttons(5).Visible = True
'                Frame1.Height = 3120
'                Me.Height = 4350
'                Frame1.Caption = "Problemas con Valorización ..."
'            Else
'                If Not Nada Then
'                   Frame1.Caption = "Valorización , Ok !!!"
'                   Me.Barra.Value = 0
'                End If
'            End If
'            Toolbar1.Buttons(1).Value = tbrUnpressed
'        End If
'        Me.Refresh
'
'    ElseIf Button.Index = 2 Then
'        Screen.MousePointer = 0
'        Unload Me
'
'    ElseIf Button.Index = 5 Then
'       Sql = "DELETE FROM ERRORES "
'
'        If MISQL.SQL_Execute(Sql) <> 0 Then
'             Screen.MousePointer = 0
'             MsgBox "Problemas al Borrar Tabla Errores ", vbCritical
'            Exit Sub
'        End If
'
'          lstProblemas.ListIndex = -1
'          Do
'            lstProblemas.ListIndex = lstProblemas.ListIndex + 1
'            Parametro = lstProblemas.List(lstProblemas.ListIndex)
'
'            Sql = ""
'            Sql = "Insert Into ERRORES (MENSAJE) Values('" & Parametro & "' )"
'
'            If MISQL.SQL_Execute(Sql) <> 0 Then
'               Screen.MousePointer = 0
'               MsgBox "Problemas al Imprimir", vbCritical
'               Exit Sub
'            End If
'
'          Loop Until lstProblemas.ListIndex + 1 = lstProblemas.ListCount
'            With BACSwap.Crystal
'             .ReportFileName = gsRPT_Path & "ERRORES.rpt"
'             .PrintFileName = gsRPT_Path & "ERRORES.rpt"
'             .Destination = crptToPrinter
'             .Connect = swConeccion
'             .DataFiles(0) = "Errores"
'             .Action = 1
'
'          End With
'
'    End If
'
'   Screen.MousePointer = 0
'
' End Sub
'

Private Function FUNC_VALIDA_CURVAS() As Boolean
   Dim Datos()
   Dim cCadena    As String
   Dim iError     As Integer
   Dim iContador  As Long
   
   Let FUNC_VALIDA_CURVAS = False
   
   Call lstProblemas.Clear
   Let iContador = 0
   
   Envia = Array()
   AddParam Envia, Format(gsBAC_Fecp, "yyyymmdd")
   AddParam Envia, 0
   If Not Bac_Sql_Execute("SP_VERIFICA_EXISTENCIA_TASAS", Envia) Then
      Exit Function
   End If
   Do While Bac_SQL_Fetch(Datos())
      Let iContador = iContador + 1
   Loop

   If iContador > 0 Then
      Call BacLimpiaParamCrw
      Let BACSwap.Crystal.Destination = crptToWindow
      Let BACSwap.Crystal.ReportFileName = gsRPT_Path & "INFORME_ERRORES_CURVAS.rpt"
         '--> Store Procedure : dbo.SP_VERIFICA_EXISTENCIA_TASAS.sql
      Let BACSwap.Crystal.WindowTitle = "Informe de Cartera Swap."
      Let BACSwap.Crystal.StoredProcParam(0) = Format(gsBAC_Fecp, "yyyy-mm-dd 00:00:00.000")
      Let BACSwap.Crystal.StoredProcParam(1) = CDbl(1)
      Let BACSwap.Crystal.Connect = swConeccion
      Let BACSwap.Crystal.Action = 1
   Else
      Let FUNC_VALIDA_CURVAS = True
   End If

End Function

Private Sub Toolbar2_ButtonClick(ByVal Button As ComctlLib.Button)
   Dim SQL$, Parametro$

   Let Screen.MousePointer = vbHourglass

   If ChequeaICPdelDia = False Then
      MsgBox "Acción Cancelada" & vbCrLf & vbCrLf & "No se ha ingresado el Indice Camara Promedio para el Día.", vbExclamation, TITSISTEMA
      Exit Sub
   End If

   Call BacLimpiaParamCrw

   If Button.Index = 1 Then
      Let Toolbar1.Buttons(5).Visible = False
      Let Frame1.Caption = Frame1.Tag
      Let Frame1.Height = 880: Let Me.Height = 2150: Call Me.Refresh

      If Me.Tag = "DEV" Then
      
         If Not Puede_devengar_SN Then
            Let Screen.MousePointer = 0
            Exit Sub
         End If
      
      
         If FUNC_VALIDA_CURVAS = False Then
            Let Screen.MousePointer = vbDefault
            Exit Sub
         End If

         Call Devengar

         If lstProblemas.ListCount > 0 Then
            Let Toolbar1.Buttons(5).Visible = True
            Let Frame1.Height = 3120:  Let Me.Height = 4350
            Let Frame1.Caption = "Problemas con el Devengamiento ..."
         Else
            If Not Nada Then
               Let Frame1.Caption = "Devengamiento , Ok !!!"
               Let Me.Barra.Value = 0
            End If
         End If
         Let Toolbar1.Buttons(1).Value = tbrUnpressed
      Else
         Call Valorizar
         Let Frame1.Caption = "Valorización Terminada !!!"
         Let Me.Barra.Value = 0
         Let Toolbar1.Buttons(1).Value = tbrUnpressed
      End If

      Call Me.Refresh
   End If

   If Button.Index = 2 Then
      Let Screen.MousePointer = 0
      Call Unload(Me)
   End If

   If Button.Index = 5 Then
      Let SQL = "DELETE FROM ERRORES "
      If MISQL.SQL_Execute(SQL) <> 0 Then
         Let Screen.MousePointer = 0
         Call MsgBox("Problemas al Borrar Tabla Errores ", vbCritical)
         Exit Sub
      End If

      Let lstProblemas.ListIndex = -1

      Do
         Let lstProblemas.ListIndex = lstProblemas.ListIndex + 1
         Let Parametro = lstProblemas.List(lstProblemas.ListIndex)
         Let SQL = ""
         Let SQL = "Insert Into ERRORES (MENSAJE) Values('" & Parametro & "' )"

         If MISQL.SQL_Execute(SQL) <> 0 Then
            Let Screen.MousePointer = 0
            Call MsgBox("Problemas al Imprimir", vbCritical)
            Exit Sub
         End If
      Loop Until lstProblemas.ListIndex + 1 = lstProblemas.ListCount

      Let BACSwap.Crystal.ReportFileName = gsRPT_Path & "ERRORES.rpt"
      Let BACSwap.Crystal.PrintFileName = gsRPT_Path & "ERRORES.rpt"
      Let BACSwap.Crystal.Destination = crptToPrinter
      Let BACSwap.Crystal.Connect = swConeccion
      Let BACSwap.Crystal.DataFiles(0) = "Errores"
      Let BACSwap.Crystal.Action = 1
   End If
   Let Screen.MousePointer = 0
   
End Sub

