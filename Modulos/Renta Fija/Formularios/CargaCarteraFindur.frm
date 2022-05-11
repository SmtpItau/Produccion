VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form CargaCarteraFindur 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Carga Cartera Findur"
   ClientHeight    =   1710
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   9510
   Icon            =   "CargaCarteraFindur.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   1710
   ScaleWidth      =   9510
   Begin Threed.SSFrame SSFrame1 
      Height          =   1170
      Left            =   15
      TabIndex        =   0
      Top             =   480
      Width           =   9480
      _Version        =   65536
      _ExtentX        =   16722
      _ExtentY        =   2064
      _StockProps     =   14
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
      Alignment       =   2
      Font3D          =   3
      Begin MSComctlLib.ProgressBar ProgBarCarga 
         Height          =   345
         Left            =   2130
         TabIndex        =   1
         Top             =   1500
         Visible         =   0   'False
         Width           =   6225
         _ExtentX        =   10980
         _ExtentY        =   609
         _Version        =   393216
         Appearance      =   1
         Scrolling       =   1
      End
      Begin MSComctlLib.ProgressBar ProgBarMKPZ 
         Height          =   345
         Left            =   2130
         TabIndex        =   2
         Top             =   480
         Width           =   6225
         _ExtentX        =   10980
         _ExtentY        =   609
         _Version        =   393216
         Appearance      =   1
         Scrolling       =   1
      End
      Begin VB.Label Label1 
         Caption         =   "Archivo Cartera Findur"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Left            =   120
         TabIndex        =   7
         Top             =   510
         Width           =   1950
      End
      Begin VB.Label Label3 
         Caption         =   "Carga Tasas"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   225
         Left            =   120
         TabIndex        =   6
         Top             =   1560
         Visible         =   0   'False
         Width           =   1245
      End
      Begin VB.Label Label4 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   225
         Left            =   8610
         TabIndex        =   5
         Top             =   330
         Width           =   645
      End
      Begin VB.Label Label6 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   8610
         TabIndex        =   3
         Top             =   1590
         Width           =   675
      End
      Begin VB.Label Label5 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   225
         Left            =   8610
         TabIndex        =   4
         Top             =   900
         Width           =   675
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   8
      Top             =   0
      Width           =   9510
      _ExtentX        =   16775
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Procesar Interfaces"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   7050
         Top             =   150
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
               Picture         =   "CargaCarteraFindur.frx":030A
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "CargaCarteraFindur.frx":30D68
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
End
Attribute VB_Name = "CargaCarteraFindur"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'===============================================================================
' LD1-COR-035-Configuración BAC Corpbanca - Tema: Carga Cartera Findur Forward
' INICIO
'===============================================================================
Dim Sql                    As String
Dim DATOS()

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

    Select Case Button.Index
        Case 1 ' Procesar
            ProgBarMKPZ.Value = 0
            Interfaz_Cartera_Findur
        Case 2 ' Salir
            Unload Me
    End Select
    
End Sub

Private Sub Interfaz_Cartera_Findur()
    Dim varFechaProcesoEnduda, varRutaInterfazEndeuda
     Dim cNomArchivo As String
      
    varFechaProcesoEnduda = ""
    varRutaInterfazEndeuda = ""
    If Not Bac_Sql_Execute("BacParamSuda..sp_Busca_InterfazEndudamiento") Then
       MsgBox "Problemas al leer ruta para interfaz de carga cartera Endeudamiento FWD.", vbCritical, TITSISTEMA
       Exit Sub
    End If
      
    If Bac_SQL_Fetch(DATOS()) Then
       varFechaProcesoEnduda = DATOS(1)
       varRutaInterfazEndeuda = DATOS(2)
    End If
    
    cNomArchivo = varRutaInterfazEndeuda
        
    If Dir(cNomArchivo, vbArchive) = "" Then
        MsgBox "Archivo no encontrado " & varRutaInterfazEndeuda, vbCritical, TITSISTEMA
        Exit Sub
    End If
    
       ' Procesar Interfaz
    If Not funCargaInterfaz(varFechaProcesoEnduda, varRutaInterfazEndeuda) Then
       MsgBox "Problemas cargar Interfaz de Limites de Endeudamiento", vbExclamation, gsBac_Version
       'GoTo Label1
    Else
       Call MsgBox("Carga Cartera Findur" & vbCrLf & vbCrLf & "Proceso finalizado correctamente.", vbInformation, TITSISTEMA)
    End If

End Sub

Private Function funCargaInterfaz(varFechaProceso, varRutaInterface)
'------------------------------------------>
    Dim cantreg, Cont, i As Integer
    Dim cNomArchivo As String
'<------------------------------------------
    Dim varFile, varLineaLeida
    Dim sistema, Producto, Numero_de_operacion, Monto, Rut_Contraparte, Codigo_Cliente, Monto_Garantias
    Dim Tipo_de_operacion, Tipo_negocio, Tipo_porcentaje, Fecha_vencimiento, MTM_proyectado
    varFile = FreeFile
    
'------------------------------------------>
    cNomArchivo = varRutaInterface
    cantreg = Func_Read_REG(cNomArchivo, 0)
    sretDos = ""
    sret = ""
'<------------------------------------------
           
    Open varRutaInterface For Input As #varFile
    
'------------------------------------------>
    ProgBarMKPZ.Max = cantreg
    ProgBarMKPZ.Min = 0
    Cont = 0
'<------------------------------------------
    
    Envia = Array()
    AddParam Envia, Format(varFechaProceso, "yyyy/mm/dd")
    If Not Bac_Sql_Execute("BacParamSuda.dbo.Sp_BorraMfca_findur", Envia) Then
          MsgBox "Error al Limpiar mfca_findur", vbCritical, TITSISTEMA
    End If

    
    Do While Not EOF(varFile)
        
        Line Input #varFile, varLineaLeida
        
        sistema = Mid(varLineaLeida, 1, 3)
        Producto = Mid(varLineaLeida, 4, 4)
        Numero_de_operacion = Mid(varLineaLeida, 8, 10)
        Monto = Mid(varLineaLeida, 18, 13) & "." & Mid(varLineaLeida, 31, 4)
        Rut_Contraparte = Left(Trim(Mid(varLineaLeida, 35, 15)), 8)
        Codigo_Cliente = Mid(varLineaLeida, 50, 5)
        Monto_Garantias = Mid(varLineaLeida, 55, 13) & "." & Mid(varLineaLeida, 68, 4)
        Tipo_de_operacion = Mid(varLineaLeida, 72, 3)
        Tipo_negocio = Mid(varLineaLeida, 75, 5)
        Tipo_porcentaje = Mid(varLineaLeida, 80, 5)
        Fecha_vencimiento = DateSerial(Mid(varLineaLeida, 91, 4), Mid(varLineaLeida, 88, 2), Mid(varLineaLeida, 85, 2))
        
        MTM_proyectado = EliminaCerosIzquierda(Mid(varLineaLeida, 95, 13))
        MTM_proyectado = MTM_proyectado & "." & Mid(varLineaLeida, 108, 4)
        MTM_proyectado = Replace(MTM_proyectado, ",", ".")

        Envia = Array()
        AddParam Envia, Format(varFechaProceso, "yyyy/mm/dd")
        AddParam Envia, CStr(sistema)
        AddParam Envia, CStr(Producto)
        AddParam Envia, CStr(Numero_de_operacion)
        AddParam Envia, CDbl(Replace(Monto, ",", ".")) ', "#,##0.###0")
        AddParam Envia, CStr(Rut_Contraparte)
        AddParam Envia, CStr(Codigo_Cliente)
        AddParam Envia, CDbl(Replace(Monto_Garantias, ",", "."))
        AddParam Envia, CStr(Tipo_de_operacion)
        AddParam Envia, CStr(Tipo_negocio)
        AddParam Envia, CStr(Tipo_porcentaje)
        AddParam Envia, Format(Fecha_vencimiento, "yyyy/mm/dd")
        AddParam Envia, MTM_proyectado
        
        
        If Bac_Sql_Execute("BacParamSuda..Sp_Grbmfca_findur", Envia) Then
            funCargaInterfaz = True
        Else
            funCargaInterfaz = False
        End If
            
'------------------------------------------>
        Cont = Cont + 1
        Label4.Caption = Str(Round((Cont / cantreg) * 100, 0)) + " %"
        Label4.Refresh
        ProgBarMKPZ.Value = Cont
'<------------------------------------------
    Loop
    Close
    funCargaInterfaz = True
End Function


Private Function EliminaCerosIzquierda(ByVal strValor As String)

    Dim Con, Campo
    Con = 0
    Campo = "0"
    
    Do While Campo = "0"
        Con = Con + 1
        Campo = Mid(strValor, Con, 1)
    Loop
    
    EliminaCerosIzquierda = Mid(strValor, Con, Len(strValor) - Con + 1)
    
End Function


Function Func_Read_REG(sFilename As String, registros1) As Integer
'Lee cantidad de registros
    Dim sret As String
    Dim text
    Dim Count
    Count = 0
    Open sFilename For Input As #1 'registros1
        Do While Not EOF(1) 'registros1)
              Line Input #1, sret '#registros1, sret
              Count = Count + 1
        Loop
    Close #1 '#registros1
    Func_Read_REG = Count
End Function


'===============================================================================
' LD1-COR-035-Configuración BAC Corpbanca - Tema: Carga Cartera Findur Forward
' FIN
'===============================================================================
