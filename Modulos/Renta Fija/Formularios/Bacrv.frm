VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form BacRvta 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Procesos diarios automaticos"
   ClientHeight    =   2475
   ClientLeft      =   1965
   ClientTop       =   1950
   ClientWidth     =   5205
   ForeColor       =   &H00C0C0C0&
   Icon            =   "Bacrv.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   2475
   ScaleWidth      =   5205
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   6
      Top             =   0
      Width           =   5205
      _ExtentX        =   9181
      _ExtentY        =   794
      ButtonWidth     =   767
      ButtonHeight    =   741
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmbaceptar"
            Description     =   "ACEPTAR"
            Object.ToolTipText     =   "Aceptar"
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
      Left            =   3765
      Top             =   3450
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
            Picture         =   "Bacrv.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacrv.frx":075C
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin Threed.SSFrame FrmDia 
      Height          =   1875
      Left            =   60
      TabIndex        =   5
      Top             =   450
      Width           =   5055
      _Version        =   65536
      _ExtentX        =   8916
      _ExtentY        =   3307
      _StockProps     =   14
      ForeColor       =   4194304
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Font3D          =   3
      Enabled         =   0   'False
      Begin Threed.SSCheck ChkVenCap 
         Height          =   315
         Left            =   300
         TabIndex        =   4
         Top             =   1320
         Width           =   4005
         _Version        =   65536
         _ExtentX        =   7064
         _ExtentY        =   556
         _StockProps     =   78
         Caption         =   "       Vencimiento de Captaciones "
         ForeColor       =   0
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Font3D          =   4
      End
      Begin Threed.SSCheck ChkRc 
         Height          =   315
         Left            =   300
         TabIndex        =   2
         Top             =   375
         Width           =   4005
         _Version        =   65536
         _ExtentX        =   7064
         _ExtentY        =   556
         _StockProps     =   78
         Caption         =   "       Recompras Automáticas"
         ForeColor       =   0
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Font3D          =   4
      End
      Begin Threed.SSCheck Chkrv 
         Height          =   315
         Left            =   300
         TabIndex        =   3
         Top             =   885
         Width           =   4005
         _Version        =   65536
         _ExtentX        =   7064
         _ExtentY        =   556
         _StockProps     =   78
         Caption         =   "       Reventas Automáticas"
         ForeColor       =   0
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Font3D          =   4
      End
   End
   Begin Threed.SSCommand Cmdsalir 
      Height          =   450
      Left            =   1365
      TabIndex        =   1
      Top             =   3105
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
   Begin Threed.SSCommand Cmdaceptar 
      Height          =   450
      Left            =   60
      TabIndex        =   0
      Top             =   3045
      Width           =   1200
      _Version        =   65536
      _ExtentX        =   2117
      _ExtentY        =   794
      _StockProps     =   78
      Caption         =   "&Aceptar"
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
Attribute VB_Name = "BacRvta"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Function funcActualizaLimites() As Boolean
Dim cSql As String
Dim Datos()


    funcActualizaLimites = False
    Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Inicio de proceso de Actualización de Limites")
    
    If Datos(1) <> "SI" Then
        MsgBox Datos(2), vbCritical, gsBac_Version
        Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, (Datos(2)))
        Exit Function
    End If
    
    Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Actualización de limites realizado satisfactoriamente")
    
    funcActualizaLimites = True

End Function

Function funcActualizaTesoreria() As Boolean
Dim Datos()
Dim cSql         As String

    funcActualizaTesoreria = False


    Screen.MousePointer = vbHourglass

       
  ' VB+ 06/03/2000 Se deben registran en tesorería estas operaciones
  ' ========================================================================
    cSql = "EXECUTE SP_GRABAVCTO_TESORERIA "
    
    Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Inicio de proceso de actualización de tesorería")

    If miSQL.SQL_Execute(cSql) <> 0 Then
        Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "proceso de actualización de tesorería falló")
        Exit Function
    End If
    
    If miSQL.SQL_Fetch(Datos()) <> 0 Then
        MsgBox "Problemas con respuesta de proceso " & cSql, vbCritical, gsBac_Version
        Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "proceso de actualización de tesorería falló")
        Exit Function
    End If
    
    Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, (Datos(2)))
    
    If Datos(1) = "NO" Then
        Screen.MousePointer = vbDefault
        MsgBox Datos(2), vbCritical, gsBac_Version
        Exit Function
    Else
        MsgBox Datos(2), vbInformation, gsBac_Version
    End If
    
  ' ========================================================================
  ' VB- 06/03/2000
   
    
    funcActualizaTesoreria = True
    Screen.MousePointer = vbDefault

End Function







' ==================================================================
Function funcProcesaRecompras() As Boolean
' ==================================================================
'   Función     :   funcProcesaRecompras
'   Objetivo    :   Realiza el proceso de recompras automaticas
' ==================================================================
Dim Datos()
Dim cSql         As String


    funcProcesaRecompras = False
    
    cSql = "EXECUTE SP_LLAMARC " & "'" & gsBac_User & "','" & gsBac_Term & "'"
    
    Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Inicio de proceso de recompras automaticas")
    
    Screen.MousePointer = vbHourglass

    If miSQL.SQL_Execute(cSql) <> 0 Then
        Screen.MousePointer = vbDefault
        Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Proceso de recompras automaticas falló ")
        Exit Function
    End If
    
    If miSQL.SQL_Fetch(Datos()) <> 0 Then
        MsgBox "Problemas con respuesta de proceso " & cSql, vbCritical, gsBac_Version
        Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Proceso de recompras automaticas falló ")
        Exit Function
    End If
    
    Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, (Datos(2)))
    
    If Datos(1) = "NO" Then
        Screen.MousePointer = vbDefault
        MsgBox Datos(2), vbCritical, gsBac_Version
        Exit Function
    Else
        MsgBox Datos(2), vbInformation, gsBac_Version
    End If
    
    funcProcesaRecompras = True
    Screen.MousePointer = vbDefault

End Function



' ==================================================================
Function funcProcesaReventas() As Boolean
' ==================================================================
'   Función     :   funcProcesaReventas
'   Objetivo    :   Realiza el proceso de recompras automaticas
' ==================================================================
Dim Datos()
Dim cSql         As String


    funcProcesaReventas = False
    
    cSql = "EXECUTE SP_LLAMARV " & "'" & gsBac_User & "','" & gsBac_Term & "'"
    
    Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Inicio de proceso de reventas automaticas")
    
    Screen.MousePointer = vbHourglass

    If miSQL.SQL_Execute(cSql) <> 0 Then
    
        Screen.MousePointer = vbDefault
        Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Proceso de reventas automaticas falló ")
        Exit Function
    End If
    
    If miSQL.SQL_Fetch(Datos()) <> 0 Then
        Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Proceso de recompras automaticas falló ")
        MsgBox "Problemas con respuesta de proceso " & cSql, vbCritical, gsBac_Version
        Exit Function
    End If
    
    Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, (Datos(2)))
    
    If Datos(1) = "NO" Then
        Screen.MousePointer = vbDefault
        MsgBox Datos(2), vbCritical, gsBac_Version
        Exit Function
    Else
        MsgBox Datos(2), vbInformation, gsBac_Version
    End If
    
    funcProcesaReventas = True
    Screen.MousePointer = vbDefault

End Function




' ==================================================================
Function funcProcesaVencCaptaciones() As Boolean
' ==================================================================
'   Función     :   funcProcesaVencCaptaciones
'   Objetivo    :   Realiza el proceso de vencimientos de captaciones
' ==================================================================
Dim Datos()

    funcProcesaVencCaptaciones = False
    
'    Sql = "EXECUTE SP_PROCESAVENCIMIENTOS " & "'" & gsBac_User & "','" & gsBac_Term & "'"

    Envia = Array(gsBac_User, gsBac_Term)
    
    Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Inicio de proceso de vencimientos de captaciones")
       
    Screen.MousePointer = vbHourglass

    If Not Bac_Sql_Execute("SP_PROCESAVENCIMIENTOS", Envia) Then
        Screen.MousePointer = vbDefault
        Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Proceso de vencimientos de captaciones falló ")
        Exit Function
    End If
    
    If Bac_SQL_Fetch(Datos()) Then
        MsgBox "Problemas con respuesta de proceso " & Sql, vbCritical, gsBac_Version
        Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Proceso de vencimientos de captaciones falló ")
        Exit Function
    End If
    
    Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, (Datos(2)))
    
    If Datos(1) = "NO" Then
        Screen.MousePointer = vbDefault
        MsgBox Datos(2), vbCritical, gsBac_Version
        Exit Function
    Else
        MsgBox Datos(2), vbInformation, gsBac_Version
    End If
    
    funcProcesaVencCaptaciones = True
    Screen.MousePointer = vbDefault

End Function





Private Sub cmdAceptar_Click()
'Dim datos()
'Dim cSql As String
'
'
'    If Not ChkRc.Value Then
'        If Not funcProcesaRecompras Then Exit Sub
'        ChkRc.Value = True
'        FrmDia.Refresh
'    End If
'
'    If Not Chkrv.Value Then
'        If Not funcProcesaReventas Then Exit Sub
'        Chkrv.Value = True
'        FrmDia.Refresh
'    End If
'
'    If Not ChkVenCap.Value Then
'        If Not funcProcesaVencCaptaciones Then Exit Sub
'        ChkVenCap.Value = True
'        FrmDia.Refresh
'    End If
'
''    If Not ChkActTes.Value Then
''        If Not funcActualizaTesoreria Then Exit Sub
''        ChkActTes.Value = True
''        FrmDia.Refresh
''    End If
'
'    'If Not ChkLimites.Value Then
'    '    If Not funcActualizaLimites Then Exit Sub
'    '    ChkLimites.Value = True
'    '    FrmDia.Refresh
'    'End If
'
'   Cmdaceptar.Enabled = False
'   MsgBox "Procesos de iniciales automaticos finalizados correctamente", vbInformation, gsBac_Version
   
End Sub


Private Sub cmdSalir_Click()
'        Unload Me
End Sub



Private Sub Form_Load()

    Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Ingreso a Procesos de vencimientos Automaticos")
    
End Sub


Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case UCase(Button.Description)
Case "ACEPTAR"
    Dim Datos()
    Dim cSql As String
    If Not ChkRc.Value Then
        If Not funcProcesaRecompras Then Exit Sub
        ChkRc.Value = True
        FrmDia.Refresh
    End If
    
    If Not Chkrv.Value Then
        If Not funcProcesaReventas Then Exit Sub
        Chkrv.Value = True
        FrmDia.Refresh
    End If
    
    If Not ChkVenCap.Value Then
        If Not funcProcesaVencCaptaciones Then Exit Sub
        ChkVenCap.Value = True
        FrmDia.Refresh
    End If
    
   Toolbar1.Buttons(2).Enabled = False
   'Cmdaceptar.Enabled = False
   MsgBox "Procesos de iniciales automaticos finalizados correctamente", vbInformation, gsBac_Version
   
Case "SALIR"
   Unload Me
        
End Select
End Sub
