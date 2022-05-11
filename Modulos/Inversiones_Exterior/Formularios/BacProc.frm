VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form BacProc 
   BorderStyle     =   1  'Fixed Single
   ClientHeight    =   1410
   ClientLeft      =   2025
   ClientTop       =   2835
   ClientWidth     =   7425
   ForeColor       =   &H00C0C0C0&
   Icon            =   "BacProc.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   1410
   ScaleWidth      =   7425
   Begin VB.Frame Frame1 
      Caption         =   "Tipo de Operaciones"
      Height          =   600
      Left            =   1440
      TabIndex        =   2
      Top             =   80
      Width           =   5895
      Begin VB.OptionButton OptIntramesas 
         Caption         =   "Intramesas"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C00000&
         Height          =   255
         Left            =   3240
         TabIndex        =   4
         Top             =   240
         Width           =   2055
      End
      Begin VB.OptionButton optNormales 
         Caption         =   "Normales"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C00000&
         Height          =   255
         Left            =   360
         TabIndex        =   3
         Top             =   240
         Width           =   1575
      End
   End
   Begin MSComctlLib.Toolbar Tool 
      Height          =   570
      Left            =   45
      TabIndex        =   0
      Top             =   105
      Width           =   1395
      _ExtentX        =   2461
      _ExtentY        =   1005
      ButtonWidth     =   1032
      ButtonHeight    =   1005
      AllowCustomize  =   0   'False
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Proceso De Fin De Día"
            ImageIndex      =   13
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   12
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   0
      Top             =   975
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
            Picture         =   "BacProc.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacProc.frx":0624
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacProc.frx":0A76
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacProc.frx":0EC8
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacProc.frx":11E2
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacProc.frx":14FC
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacProc.frx":194E
            Key             =   ""
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacProc.frx":1AA8
            Key             =   ""
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacProc.frx":1EFA
            Key             =   ""
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacProc.frx":234C
            Key             =   ""
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacProc.frx":2666
            Key             =   ""
         EndProperty
         BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacProc.frx":2980
            Key             =   ""
         EndProperty
         BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacProc.frx":2ADA
            Key             =   ""
         EndProperty
         BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacProc.frx":2F2C
            Key             =   ""
         EndProperty
         BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacProc.frx":337E
            Key             =   ""
         EndProperty
         BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacProc.frx":3698
            Key             =   ""
         EndProperty
         BeginProperty ListImage17 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacProc.frx":39B2
            Key             =   ""
         EndProperty
         BeginProperty ListImage18 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacProc.frx":3CCC
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin VB.Label Lbl_Mensaje 
      Alignment       =   2  'Center
      BorderStyle     =   1  'Fixed Single
      Caption         =   "TEXTO DEL PROCESO"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   390
      Left            =   1440
      TabIndex        =   1
      Top             =   800
      Width           =   5865
   End
End
Attribute VB_Name = "BacProc"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit
Dim cProceso$
Private Sub BacFinDia()

    Dim datos()
    Dim cFechoy$
  
  
    Lbl_Mensaje.ForeColor = vbBlue
  
    If Bac_Sql_Execute("SVA_PRC_FIN_DIA") Then
        Do While Bac_SQL_Fetch(DATOS)
        
            If Trim(datos(1)) = "SI" Then
                Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "Proceso Fin de Día realizado correctamente")
                MsgBox "Proceso Concluido Exitosamente", vbInformation, gsBac_Version
                
            End If
            
            Lbl_Mensaje.Caption = datos(2)
            
            Tool.Buttons(1).Enabled = False
        Loop
    Else
        Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "Problemas en Proceso Fin de Día ")
        MsgBox "Problemas al Ejecutar Proceso", vbCritical, gsBac_Version
        Lbl_Mensaje.ForeColor = vbRed
        Lbl_Mensaje.Caption = "ERROR"
    End If
    Call guardar_hora_proceso("fd", Time, gsBac_Fecp)
    Tool.Buttons(1).Enabled = False
          
End Sub


Private Sub BacDevengamiento()

    Dim datos()
    Dim cFechoy$
    
    Dim nomSp As String
        
   Dim FechaHoy
   Dim Fechaprox
   Dim FinMesEsp As Boolean
   Dim gsBac_FM As Date
   
   gsBac_FM = CDate("01/" + Str(Month(gsBac_Fecp)) + "/" + Str(Year(gsBac_Fecp)))
   gsBac_FM = DateAdd("m", 1, gsBac_FM)
   gsBac_FM = DateAdd("d", -1, gsBac_FM)
   
   If gsBac_Fecp <> gsBac_FM And gsBac_Fecx > gsBac_FM Then
       FinMesEsp = True
       FechaHoy = gsBac_Fecp
       Fechaprox = gsBac_FM   'cFechoy$
   Else
       FinMesEsp = False
       FechaHoy = gsBac_Fecp
       Fechaprox = gsBac_Fecx
   End If
   
   
'   If Month(gsBac_Fecx) <> Month(gsBac_Fecp) Then
'      cFechoy$ = "01/" & Month(gsBac_Fecx) & "/" & Year(gsBac_Fecx)
'      cFechoy$ = DateAdd("d", -1, cFechoy$)
'
'      FechaHoy = gsBac_Fecp
'      Fechaprox = cFechoy$
'
'      FinMesEsp = True
'   Else
'      FechaHoy = gsBac_Fecp
'      Fechaprox = gsBac_Fecx
'   End If
   
    envia = Array()
    AddParam envia, FechaHoy
    AddParam envia, Fechaprox
    AddParam envia, "N"
    
    Lbl_Mensaje.ForeColor = vbBlue
  
    If optNormales.Value = True Then
        nomSp = "SVA_PRC_DEV_CAR"
    Else
        nomSp = "SVA_PRC_DEV_CAR_IM"
    End If
  
    If Bac_Sql_Execute(nomSp, envia) Then
        Do While Bac_SQL_Fetch(datos)
        
            If Trim(datos(1)) = "SI" Then
                Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "Proceso de Devengamiento realizado correctamente")
                MsgBox "Proceso Concluido Exitosamente", vbInformation, gsBac_Version
                
            End If
            
            Lbl_Mensaje.Caption = datos(2)

        Loop
    Else
        Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "Problemas en Proceso de Devengamiento")
        MsgBox "Problemas al Ejecutar Proceso", vbCritical, gsBac_Version
        Lbl_Mensaje.ForeColor = vbRed
        Lbl_Mensaje.Caption = "ERROR"

    End If
    
    Call guardar_hora_proceso("dv", Time, gsBac_Fecp)
    
    If FinMesEsp Then
      
          envia = Array()
          AddParam envia, Fechaprox
          AddParam envia, gsBac_Fecx
          AddParam envia, "S"
    
          Lbl_Mensaje.ForeColor = vbBlue
          If optNormales.Value = True Then
                nomSp = "SVA_PRC_DEV_CAR"
          Else
                nomSp = "SVA_PRC_DEV_CAR_IM"
          End If
        
          If Bac_Sql_Execute(nomSp, envia) Then
              Do While Bac_SQL_Fetch(datos)
              
                  If Trim(datos(1)) = "SI" Then
                      Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "Proceso de Devengamiento realizado correctamente")
                      MsgBox "Proceso Concluido Exitosamente", vbInformation, gsBac_Version
                      
                  End If
                  
                  Lbl_Mensaje.Caption = datos(2)
      
              Loop
          Else
              Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "Problemas en Proceso de Devengamiento")
              MsgBox "Problemas al Ejecutar Proceso", vbCritical, gsBac_Version
              Lbl_Mensaje.ForeColor = vbRed
              Lbl_Mensaje.Caption = "ERROR"
      
          End If
          Call guardar_hora_proceso("dv", Time, gsBac_Fecp)
            
      
      
      
    End If
    
    
    Tool.Buttons(1).Enabled = False
          
End Sub
Private Sub BacContabilidad()

    Dim datos()
    Dim cFechaConta$
    Dim cFechoy$
    Dim FechaContaFinMes
    Dim FinMesEsp As Boolean
    Dim cDia As String
    Dim NombreArchivo As String
    
    cDia = Format(gsBac_Fecp, "yymmdd")
    NombreArchivo = gsBac_DIRCONTA
   
   FinMesEsp = False
   
   'cFechaConta$ = gsBac_Fecp
   If Month(gsBac_Fecx) <> Month(gsBac_Fecp) Then
      cFechoy$ = "01/" & Month(gsBac_Fecx) & "/" & Year(gsBac_Fecx)
      cFechoy$ = DateAdd("d", -1, cFechoy$)
      FechaContaFinMes = cFechoy$
      
      FinMesEsp = True
      Lbl_Mensaje.Caption = "Proceso Contable Fin de Mes..."
   Else
      Lbl_Mensaje.Caption = "Proceso Contable..."
   End If
   Lbl_Mensaje.ForeColor = vbBlue
   BacControlWindows 500
   
   
    envia = Array()
    AddParam envia, gsBac_Fecp
    
  
  
    If Bac_Sql_Execute("SP_CONTABILIZACION", envia) Then
        Do While Bac_SQL_Fetch(DATOS)
        
            If Trim(datos(1)) = "SI" Then
                Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "Proceso Contable realizado correctamente")
                If Not FinMesEsp Then
                  MsgBox "Proceso Contable Finalizado Exitosamente", vbInformation, gsBac_Version
                  Lbl_Mensaje.Caption = "PROCESO OK!!!"
               End If
            Else
                    Lbl_Mensaje.Caption = datos(1)
                    Exit Sub
            End If
            
        Loop
    Else
        Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "Problemas en Proceso Contable")
        MsgBox "Problemas al Ejecutar Proceso Contable", vbCritical, gsBac_Version
        Lbl_Mensaje.ForeColor = vbRed
        Lbl_Mensaje.Caption = "ERROR"
        Exit Sub
    End If
    
    If FinMesEsp Then
      envia = Array()
    AddParam envia, FechaContaFinMes
    
    Lbl_Mensaje.ForeColor = vbBlue
  
    If Bac_Sql_Execute("SP_CONTABILIZACION", envia) Then
      Do While Bac_SQL_Fetch(DATOS)
        
            If Trim(datos(1)) = "SI" Then
               Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "Proceso Contable Fin de Mes realizado correctamente")
               MsgBox "Proceso Contable Fin de Mes Finalizado Exitosamente", vbInformation, gsBac_Version
               Lbl_Mensaje.Caption = "PROCESO OK!!!"
            Else
               Lbl_Mensaje.Caption = datos(1)
               Exit Sub
            End If
            
         Loop
         Else
            Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "Problemas en Proceso Contable")
            MsgBox "Problemas al Ejecutar Proceso Contable", vbCritical, gsBac_Version
            Lbl_Mensaje.ForeColor = vbRed
            Lbl_Mensaje.Caption = "ERROR"
         
         End If
    End If
 
  
      Call InterfazContable(NombreArchivo, cDia)
       
    Call guardar_hora_proceso("CTB", Time, gsBac_Fecp)
    Tool.Buttons(1).Enabled = False
          
End Sub

Sub Procesar()
    
    Screen.MousePointer = 11
     
    Select Case cProceso$
        Case "FD"
               BacFinDia
            
        Case "DV"
               BacDevengamiento
               
        Case "CTB"
                BacContabilidad
    End Select
     
    Screen.MousePointer = 0

End Sub

Private Sub Form_Load()
    Move 0, 0

    cProceso = gsRUN_Proceso
    Lbl_Mensaje.Caption = ""
   
    Select Case cProceso
        Case "FD"
            Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "Ingreso a Pantalla Proceso Fin de Día")
            Me.Caption = "Fin de Dia"
            Tool.Buttons(1).ToolTipText = "Proceso de Inicio de Día"
        Case "DV"
            Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "Ingreso a Pantalla Proceso Devengo")
            Me.Caption = "Devengamiento de Cartera"
            Tool.Buttons(1).ToolTipText = "Proceso de Devengamiento"
            optNormales.Value = False
            OptIntramesas.Value = False
         Case "CTB"
            Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "Ingreso a Pantalla Proceso Contable")
            Me.Caption = "Contabilidad"
            Tool.Buttons(1).ToolTipText = "Proceso Contable"
    End Select
    
    
End Sub


Private Sub Form_Unload(Cancel As Integer)

    Select Case cProceso
        Case "FD"
            Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "Salida de Pantalla Proceso Fin de Día")
            
        Case "DV"
            Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "Salida de Pantalla Proceso Devengo")
            
         Case "CTB"
            Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "Salida de Pantalla Proceso Contable")
            
    End Select




End Sub

Private Sub Tool_ButtonClick(ByVal Button As MSComctlLib.Button)
    Select Case Button.Index
        Case 1
            If optNormales.Value = False And OptIntramesas.Value = False Then
                MsgBox "No ha seleccionado el Tipo de Operación!", vbExclamation, gsBac_Version
                Exit Sub
            End If
            Call Procesar
            
        Case 2
            Unload Me
            
    End Select
    
End Sub


