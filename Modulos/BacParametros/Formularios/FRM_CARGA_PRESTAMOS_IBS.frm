VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Begin VB.Form FRM_CARGA_PRESTAMOS_IBS 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Verifica Préstamos IBS"
   ClientHeight    =   4755
   ClientLeft      =   1875
   ClientTop       =   3015
   ClientWidth     =   8235
   ForeColor       =   &H00800000&
   Icon            =   "FRM_CARGA_PRESTAMOS_IBS.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4755
   ScaleWidth      =   8235
   ShowInTaskbar   =   0   'False
   Begin Threed.SSPanel SSPanelCompara 
      Height          =   615
      Left            =   0
      TabIndex        =   9
      Top             =   3480
      Width           =   8205
      _Version        =   65536
      _ExtentX        =   14473
      _ExtentY        =   1085
      _StockProps     =   15
      BackColor       =   13160660
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   8235
      _ExtentX        =   14526
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
            Key             =   "CmbCarga"
            Description     =   "CARGAR"
            Object.ToolTipText     =   "Cargar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "CmbSalir"
            Description     =   "SALIR"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   4200
      Top             =   0
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
            Picture         =   "FRM_CARGA_PRESTAMOS_IBS.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_CARGA_PRESTAMOS_IBS.frx":11E4
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin Threed.SSPanel Pnl_Progreso 
      Height          =   450
      Index           =   0
      Left            =   0
      TabIndex        =   1
      Top             =   840
      Width           =   8205
      _Version        =   65536
      _ExtentX        =   14473
      _ExtentY        =   794
      _StockProps     =   15
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BevelOuter      =   1
      FloodType       =   1
      FloodColor      =   -2147483646
   End
   Begin Threed.SSPanel Pnl_Progreso 
      Height          =   450
      Index           =   1
      Left            =   0
      TabIndex        =   3
      Top             =   2160
      Width           =   8205
      _Version        =   65536
      _ExtentX        =   14473
      _ExtentY        =   794
      _StockProps     =   15
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BevelOuter      =   1
      FloodType       =   1
      FloodColor      =   -2147483646
   End
   Begin VB.Label Label3 
      Caption         =   "Verifica Relación Préstamos con Cartera Derivados"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   255
      Left            =   120
      TabIndex        =   8
      Top             =   3240
      Width           =   6375
   End
   Begin VB.Label Label2 
      Caption         =   "Archivo Anticipos IBS"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   255
      Left            =   120
      TabIndex        =   7
      Top             =   1920
      Width           =   6615
   End
   Begin VB.Label Label1 
      Caption         =   "Archivo Préstamos IBS"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   255
      Left            =   120
      TabIndex        =   6
      Top             =   600
      Width           =   6615
   End
   Begin VB.Label LblPrestIBS 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   495
      Index           =   2
      Left            =   0
      TabIndex        =   5
      Top             =   4080
      Width           =   8175
   End
   Begin VB.Label LblPrestIBS 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   375
      Index           =   1
      Left            =   0
      TabIndex        =   4
      Top             =   2640
      Width           =   8175
   End
   Begin VB.Label LblPrestIBS 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   375
      Index           =   0
      Left            =   0
      TabIndex        =   2
      Top             =   1320
      Width           =   8175
   End
End
Attribute VB_Name = "FRM_CARGA_PRESTAMOS_IBS"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Sub PROC_CARGA_PRESTAMOS_IBS()
        
        Screen.MousePointer = vbHourglass
        
        If CargaArchivo_PrestamosIBS = False Then
            Exit Sub
        End If
        If CargaArchivo_AnticipoIBS = False Then
            Exit Sub
        End If
        
        If Mensajes_Relacion_PAE = False Then
            Exit Sub
        End If
        
    
        Screen.MousePointer = vbDefault

End Sub


Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

Select Case UCase(Button.Description)
    Case "CARGAR"
        If MsgBox("¿Está seguro Cargar Archivos IBS ?", 36, gsBac_Version) <> 6 Then Exit Sub
           Call PROC_CARGA_PRESTAMOS_IBS
    Case "SALIR"
        Unload Me
End Select
End Sub
Public Function CargaArchivo_PrestamosIBS()

 Dim oPath                  As String
 Dim cNombreArchivo         As String
 Dim ruta                   As String
 Dim SeparadorCampo         As String
 Dim xLine$
 Dim Prueba    As String
    
 Dim IBS_FecProc      As String
 Dim IBS_NumPrestamo  As Long
 Dim IBS_CodProd      As String
 Dim IBS_CodFam       As String
 Dim IBS_NumDerivado  As Long
 Dim IBS_cTipo        As String
 Dim IBS_Fecini       As String
 Dim IBS_FecVenc      As String
 Dim IBS_Monto        As Double
 Dim IBS_CodTasa      As String
 Dim IBS_TipoTasa     As String
 Dim IBS_TasaCli      As Double
 Dim IBS_Spread       As Double
 Dim IBS_Moneda       As String
 Dim IBS_RuCli        As String
 Dim IBS_cTipoPlazo   As String
 Dim IBS_Plazo        As Long
 Dim IBS_cEstadoOper  As String
 Dim total_registro   As Long
 Dim CantidadRegistros As Long
 Dim LargoRegistro    As Long
 
 CargaArchivo_PrestamosIBS = False
 
   If Right(gsBac_DIRPAE, 1) <> "\" Then
      Let gsBac_DIRPAE = gsBac_DIRPAE & "\"
   End If
   
   Envia = Array()
   AddParam Envia, 1
   If Not Bac_Sql_Execute("BacTraderSuda.dbo.SP_ELIMINA_PRESTAMOS_IBS", Envia) Then
      Let Screen.MousePointer = vbDefault
      Call MsgBox("Se ha generado un error al comparar relación entre el Créditos y el Derivados.", vbExclamation, App.Title)
      Exit Function
   End If

   
   Let cNombreArchivo = "Derelpae_" & Format(gsbac_fecp, "YYYY") & Format(gsbac_fecp, "MM") & Format(gsbac_fecp, "DD") & ".dat"
   Let oPath = gsBac_DIRPAE & cNombreArchivo

   If Dir(oPath) = "" Then
      Let Screen.MousePointer = vbDefault
      Call MsgBox("El archivo requerido para la carga. [" & cNombreArchivo & "]. no se encuentra... Favor Revisar.", vbExclamation, App.Title)
      Exit Function
   End If
   
   
   
    
   total_registro = 0
   

    Let CantidadRegistros = FuncCantRegistros(oPath)
  
    Pnl_Progreso(0).Visible = True
    Pnl_Progreso(0).FloodPercent = 0

   
   
 '-- carga operaciones
 On Error GoTo errOpen
 Open oPath For Input As #1
  
    
 Do While Not EOF(1)
        
        Line Input #1, xLine
        IBS_FecProc = (Mid$(xLine, 1, 8))
        IBS_NumPrestamo = Val(Mid$(xLine, 10, 12))
        IBS_CodProd = (Mid$(xLine, 23, 4))
        IBS_CodFam = (Mid$(xLine, 28, 4))
        IBS_NumDerivado = Val(Mid$(xLine, 33, 12))
        IBS_cTipo = (Mid$(xLine, 46, 1))
        IBS_Fecini = Mid$(xLine, 48, 8)
        IBS_FecVenc = Mid$(xLine, 57, 8)
        IBS_Monto = Val(Mid$(xLine, 66, 17))
        IBS_CodTasa = (Mid$(xLine, 84, 2))
        IBS_TipoTasa = (Mid$(xLine, 87, 35))
        IBS_TasaCli = Val(Mid$(xLine, 123, 10))
        IBS_Spread = Val(Mid$(xLine, 134, 10))
        IBS_Moneda = Mid$(xLine, 145, 3)
        IBS_RuCli = Val(IIf(BacValidaRut(Mid$(xLine, 149, Len(Trim(Mid$(xLine, 149, 15))) - 1), Right(Trim(Mid$(xLine, 149, 15)), 1)) = True, Mid$(xLine, 149, Len(Trim(Mid$(xLine, 149, 15))) - 1), 0))
        IBS_cTipoPlazo = Mid$(xLine, 165, 1)
        IBS_Plazo = Val(Mid$(xLine, 167, 4))
        IBS_cEstadoOper = Mid$(xLine, 172, 30)
        
        LargoRegistro = Len(xLine)
        If LargoRegistro <> 202 Then
             MsgBox "Revisar archivo Préstamos IBS. Largo de registro " & total_registro + 1 & " no corresponde a 202 caracteres.", vbCritical, TITSISTEMA
             Close #1
             Exit Function
        End If
        
        Envia = Array()
            AddParam Envia, IBS_FecProc
            AddParam Envia, IBS_NumPrestamo
            AddParam Envia, IBS_CodProd
            AddParam Envia, IBS_CodFam
            AddParam Envia, IBS_NumDerivado
            AddParam Envia, IBS_cTipo
            AddParam Envia, IBS_Fecini
            AddParam Envia, IBS_FecVenc
            AddParam Envia, CDbl(IBS_Monto)
            AddParam Envia, IBS_CodTasa
            AddParam Envia, IBS_TipoTasa
            AddParam Envia, CDbl(IBS_TasaCli)
            AddParam Envia, CDbl(IBS_Spread)
            AddParam Envia, IBS_Moneda
            AddParam Envia, IBS_RuCli
            AddParam Envia, IBS_cTipoPlazo
            AddParam Envia, IBS_Plazo
            AddParam Envia, IBS_cEstadoOper
            
        If Not Bac_Sql_Execute("BacTraderSuda.dbo.SP_GRABA_PRESTAMOS_IBS", Envia) Then
            MsgBox "No se pudo realizar transferencia de datos Préstamos IBS. Favor Revisar Archivo. ", vbCritical, TITSISTEMA
             Close #1
             Exit Function
        End If
 
       
         
        total_registro = total_registro + 1
        Pnl_Progreso(0).FloodPercent = (total_registro * 100) / CantidadRegistros
        
        If Pnl_Progreso(0).FloodPercent >= 49 Then
            Let Pnl_Progreso(0).FloodColor = vbBlue: Let Pnl_Progreso(0).ForeColor = vbWhite
        Else
            Let Pnl_Progreso(0).FloodColor = vbBlue: Let Pnl_Progreso(0).ForeColor = vbBlack
        End If
        
        If total_registro = CantidadRegistros Then
      
              LblPrestIBS(0).Caption = "Carga Archivo Préstamos IBS OK..."
               BacControlWindows 50
            
          
        End If
        
 Loop

  
    Close #1
    
 CargaArchivo_PrestamosIBS = True
 
errOpen:
    Exit Function
    
'--PRD-101449
    
End Function


Public Function CargaArchivo_AnticipoIBS()

 Dim oPath                  As String
 Dim cNombreArchivo         As String
 Dim ruta                   As String
 Dim SeparadorCampo         As String
 Dim xLine$
 Dim Prueba    As String
    
 Dim IBS_FecProc      As String
 Dim IBS_NumPrestamo  As Long
 Dim IBS_CodProd      As String
 Dim IBS_CodFam       As String
 Dim IBS_NumDerivado  As Long
 Dim IBS_cTipo        As String
 Dim IBS_cTipoAnti    As String
 Dim IBS_Monto        As Double
 Dim IBS_FecAnti      As String
 Dim IBS_RuCli        As String
 Dim total_registro   As Long
 Dim CantidadRegistros   As Long
 Dim LargoRegistro    As Long
 
 
 CargaArchivo_AnticipoIBS = False
  
   If Right(gsBac_DIRPAE, 1) <> "\" Then
      Let gsBac_DIRPAE = gsBac_DIRPAE & "\"
   End If
   
   
   Let cNombreArchivo = "Derelant_" & Format(gsbac_fecp, "YYYY") & Format(gsbac_fecp, "MM") & Format(gsbac_fecp, "DD") & ".dat"
   Let oPath = gsBac_DIRPAE & cNombreArchivo

   If Dir(oPath) = "" Then
      Call MsgBox("El archivo requerido para la carga. [" & cNombreArchivo & "]. no se encuentra... Favor Revisar.", vbExclamation, App.Title)
      Exit Function
   End If
   
   
   Envia = Array()
   AddParam Envia, 2
   If Not Bac_Sql_Execute("BacTraderSuda.dbo.SP_ELIMINA_PRESTAMOS_IBS", Envia) Then
      Let Screen.MousePointer = vbDefault
      Call MsgBox("Se ha generado un error al comparar relación entre el Créditos y el Derivados.", vbExclamation, App.Title)
      Exit Function
   End If
   
   total_registro = 0
   
   Let CantidadRegistros = FuncCantRegistros(oPath)
  
    Pnl_Progreso(1).Visible = True
    Pnl_Progreso(1).FloodPercent = 0

   
   
 '-- carga operaciones
 On Error GoTo errOpen
 Open oPath For Input As #1
    
 Do While Not EOF(1)
 
        Line Input #1, xLine
        IBS_NumPrestamo = Val(Mid$(xLine, 1, 12))
        IBS_CodProd = (Mid$(xLine, 14, 4))
        IBS_CodFam = (Mid$(xLine, 19, 4))
        IBS_NumDerivado = Val(Mid$(xLine, 24, 12))
        IBS_cTipo = (Mid$(xLine, 37, 1))
        IBS_cTipoAnti = Mid$(xLine, 39, 30)
        IBS_Monto = Val(Mid$(xLine, 70, 17))
        IBS_FecAnti = Mid$(xLine, 88, 8)
        IBS_RuCli = Val(IIf(BacValidaRut(Mid$(xLine, 97, Len(Trim(Mid$(xLine, 97, 15))) - 1), Right(Trim(Mid$(xLine, 97, 15)), 1)) = True, Mid$(xLine, 97, Len(Trim(Mid$(xLine, 97, 15))) - 1), 0))
        
        LargoRegistro = Len(xLine)
        If LargoRegistro <> 112 Then
             MsgBox "Revisar archivo Anticipos IBS. Largo de registro " & total_registro + 1 & " no corresponde a 202 caracteres.", vbCritical, TITSISTEMA
             Close #1
             Exit Function
        End If
        
        
        Envia = Array()
            AddParam Envia, Format(gsbac_fecp, "YYYY") & Format(gsbac_fecp, "MM") & Format(gsbac_fecp, "DD")
            AddParam Envia, IBS_NumPrestamo
            AddParam Envia, IBS_CodProd
            AddParam Envia, IBS_CodFam
            AddParam Envia, IBS_NumDerivado
            AddParam Envia, IBS_cTipo
            AddParam Envia, IBS_cTipoAnti
            AddParam Envia, CDbl(IBS_Monto)
            AddParam Envia, IBS_FecAnti
            AddParam Envia, IBS_RuCli
            
        If Not Bac_Sql_Execute("BacTraderSuda.dbo.SP_GRABA_ANTICIPOS_IBS", Envia) Then
             MsgBox "No se pudo realizar transferencia de datos Anticipos IBS. Favor Revisar Archivo. ", vbCritical, TITSISTEMA
             Close #1
             Exit Function
        End If
 
        total_registro = total_registro + 1
        Pnl_Progreso(1).FloodPercent = (total_registro * 100) / CantidadRegistros
      
        If Pnl_Progreso(1).FloodPercent >= 49 Then
            Let Pnl_Progreso(1).FloodColor = vbBlue: Let Pnl_Progreso(1).ForeColor = vbWhite
        Else
            Let Pnl_Progreso(1).FloodColor = vbBlue: Let Pnl_Progreso(1).ForeColor = vbBlack
        End If
        
        
        If total_registro = CantidadRegistros Then
         
          LblPrestIBS(1).Caption = "Carga Archivo Anticipo Préstamos IBS OK..."
          BacControlWindows 50
           
        End If
        
        
 Loop
 
           
    Close #1
    
    
    CargaArchivo_AnticipoIBS = True


errOpen:
    Exit Function
    
'--PRD-101449
    
End Function



Public Function Mensajes_Relacion_PAE()
 Dim MensjDRV  As String
 Dim MensjOPC  As String
 Dim MensjBFW  As String
 Dim MensjPCS  As String
 Dim MensjANT  As String
 Dim Asunto    As String
 Dim Usuario   As String
 Dim Mail      As String
 Dim Cont      As Long
 Dim Firma     As String
 Dim total_registro   As Long
 Dim Reg       As Long
 
 Let MensjBFW = ""
 Let MensjPCS = ""
 
 Mensajes_Relacion_PAE = False
 
 Let Reg = 1
 
 On Error GoTo errOpen
 
   SSPanelCompara.Caption = "Comparando Relacion PAE...."
   BacControlWindows 50
   Envia = Array()
   AddParam Envia, gsbac_fecp
   If Not Bac_Sql_Execute("BacTraderSuda.dbo.SP_COMPARA_RELACION_IBS_DRV", Envia) Then
      Let Screen.MousePointer = vbDefault
      Call MsgBox("Se ha generado un error al comparar relación entre el Créditos y el Derivados.", vbExclamation, App.Title)
      Exit Function
   Else
         SSPanelCompara.Caption = "Comparación de Relacion PAE OK."
         LblPrestIBS(2).Caption = "Se enviará un mail en forma automática con información obtenida. "
      
   End If
                
   Envia = Array()
   AddParam Envia, gsbac_fecp
   If Not Bac_Sql_Execute("BacTraderSuda.dbo.SP_RESCATA_ERRORES_RELACION_IBS_DRV", Envia) Then
      Let Screen.MousePointer = vbDefault
      Call MsgBox("Se ha generado un error al comparar relación entre el Créditos y el Derivados.", vbExclamation, App.Title)
      Exit Function
   End If

   Do While Bac_SQL_Fetch(Datos())
   
      If Datos(1) = -1 Then
          Let Reg = 0
          Exit Do
      End If
 
   
       If Datos(1) = "OPC" Then
         Let MensjOPC = MensjOPC & "" & Datos(4) & vbCrLf & vbTab
       End If

''''       If Datos(1) = "BFW" Then
''''         Let MensjBFW = MensjBFW & "" & Datos(4) & vbCrLf & vbTab
''''       End If
''''       If Datos(1) = "PCS" Then
''''               Let MensjPCS = MensjPCS & "" & Datos(4) & vbCrLf & vbTab
''''       End If
''''       If Datos(1) = "ANT" Then
''''            Let MensjANT = MensjANT & "" & Datos(4) & vbCrLf & vbTab
''''       End If
       
       Let Firma = Datos(6)
   Loop
   
       If MensjOPC <> "" Then
           Let MensjOPC = " Para préstamos relacionados con Opciones se obtiene la siguiente información :" & vbCrLf & vbCrLf & vbTab & MensjOPC & vbCrLf & vbTab
       End If
                     
''''        If MensjBFW <> "" Then
''''           Let MensjBFW = " Para préstamos relacionados con Forward se obtiene la siguiente información :" & vbCrLf & vbCrLf & vbTab & MensjBFW & vbCrLf & vbTab
''''        End If
''''
''''        If MensjPCS <> "" Then
''''           Let MensjPCS = " Para préstamos relacionados con Swap se obtiene la siguiente información :" & vbCrLf & vbCrLf & vbTab & MensjPCS & vbCrLf & vbTab
''''        End If
''''
''''       If MensjANT <> "" Then
''''           Let MensjANT = " Los siguientes préstamos son antiguos :" & vbCrLf & vbCrLf & vbTab & MensjANT & vbCrLf & vbTab
''''       End If

       
        If Reg = 0 Then
           Let MensjDRV = MensjDRV & " No existe información de carga de archivo. "
        Else
        Let MensjDRV = MensjDRV & MensjOPC & vbCrLf & vbTab & MensjBFW & vbCrLf & vbTab & MensjPCS & vbCrLf & vbTab & MensjANT
        End If
        

         If Not Bac_Sql_Execute("BacTraderSuda.dbo.SP_ENVIOMAILPAE") Then
             Call MsgBox("Problemas al Leer Procedimiento. ", vbCritical, App.Title)
             
         Else
             
             Let Cont = 0
             Do While Bac_SQL_Fetch(Datos())
               Usuario = Usuario & (Datos(1)) & ";"
               Mail = Mail & (Datos(2)) & ";"
               Cont = Cont + 1
                
             Loop
         End If
         
         If Cont > 1 Then
              Let Usuario = "Estimados  "
         Else
              Let Usuario = "Estimado  " & Usuario
         End If
        
        If MensjDRV <> "" Then
          Let Asunto = "Información de Carga Archivo PAE"
          Call SendMail(Usuario, Mail, MensjDRV, Firma, Asunto)
        End If
        
      
 Mensajes_Relacion_PAE = True
 
errOpen:
    Exit Function

End Function

Private Function SendMail(ByVal Contacto As String, ByVal Email As String, ByVal Mensaje As String, ByVal Firma As String, ByVal Subjt As String)
   On Error Resume Next
   Dim Enviar      As Object
   Dim ObjCorreo   As Object

   Set ObjCorreo = CreateObject("Outlook.Application")
   Set Enviar = ObjCorreo.CreateItem(0)

   Enviar.To = Email
   Enviar.cc = ""
   Enviar.Subject = Subjt
   Enviar.Body = Contacto & "," & vbCrLf & vbCrLf & vbTab & Mensaje & vbCrLf & vbCrLf & "Atte." & vbCrLf & Firma     '' "Estimado " &
   Enviar.Importance = 1
   ''Enviar.Display
   Enviar.Send
   

   Set ObjCorreo = Nothing
   Set Enviar = Nothing

   On Error GoTo 0
End Function

Private Function FuncCantRegistros(ByVal cFilename As String) As Long
   Dim Filas      As String
   Dim nContador  As Long
   Dim cLinea           As String
   
   Let Filas = FreeFile
   Let nContador = 0

   Open cFilename For Input As #Filas

   If EOF(Filas) = True Then
      Let FuncCantRegistros = nContador
   End If

   Do Until EOF(Filas)
      Let nContador = nContador + 1
      Line Input #Filas, cLinea
   Loop

   Close #Filas

   Let FuncCantRegistros = nContador
End Function
