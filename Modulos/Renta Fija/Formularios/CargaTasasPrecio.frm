VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "threed32.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form CargaTasasPrecio 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Carga de Tasas"
   ClientHeight    =   2025
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   9510
   Icon            =   "CargaTasasPrecio.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   2025
   ScaleWidth      =   9510
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   1
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
               Picture         =   "CargaTasasPrecio.frx":030A
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "CargaTasasPrecio.frx":30D68
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin Threed.SSFrame SSFrame1 
      Height          =   1410
      Left            =   15
      TabIndex        =   0
      Top             =   540
      Width           =   9465
      _Version        =   65536
      _ExtentX        =   16695
      _ExtentY        =   2487
      _StockProps     =   14
      Caption         =   "Carga Interfaces de Tasa"
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
         TabIndex        =   7
         Top             =   1500
         Visible         =   0   'False
         Width           =   6225
         _ExtentX        =   10980
         _ExtentY        =   609
         _Version        =   393216
         Appearance      =   1
         Scrolling       =   1
      End
      Begin MSComctlLib.ProgressBar ProgBarTASA 
         Height          =   345
         Left            =   2130
         TabIndex        =   5
         Top             =   870
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
         TabIndex        =   3
         Top             =   240
         Width           =   6225
         _ExtentX        =   10980
         _ExtentY        =   609
         _Version        =   393216
         Appearance      =   1
         Scrolling       =   1
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
         TabIndex        =   10
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
         TabIndex        =   9
         Top             =   960
         Width           =   675
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
         TabIndex        =   8
         Top             =   330
         Width           =   645
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
      Begin VB.Label Label2 
         Caption         =   "Archivo TARIFADO"
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
         TabIndex        =   4
         Top             =   960
         Width           =   1695
      End
      Begin VB.Label Label1 
         Caption         =   "Archivo MKPZ"
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
         TabIndex        =   2
         Top             =   330
         Width           =   1305
      End
   End
End
Attribute VB_Name = "CargaTasasPrecio"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'===============================================================================
' LD1-COR-035-Configuración BAC Corpbanca - Tema: INTERFACES Tarifado y MKPZ
' INICIO
'===============================================================================
Dim swProc As Boolean
Dim swProcTasa As Boolean
Dim swProcDef As Boolean

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

    Select Case Button.Index
        Case 1 ' Procesar
            swProc = False
            swProcTasa = False
            swProcDef = False
            ProgBarMKPZ.Value = 0
            ProgBarTASA.Value = 0
            ProgBarCarga.Value = 0
            Label4.Caption = ""
            Label5.Caption = ""
            Label6.Caption = ""
            
            Proc_carga_MKPZ
            Proc_carga_TARIFADO
            
            If swProc And swProcTasa Then
                MsgBox "Proceso Carga ha Concluido con Exito", vbInformation, TITSISTEMA
            Else
                'MsgBox "Existen Errores en las cargas", vbCritical, TITSISTEMA
                Label6.Caption = "ERROR"
                Label6.Refresh
            End If
        Case 2 ' Salir
            Unload Me
    End Select
    
End Sub

Function Proc_carga_MKPZ()
    
    On Error Resume Next
    
    Dim DATOS()
    Dim cantreg, Cont, i As Integer
    Dim sret As String
    Dim sretDos As String
    Dim cNomArchivo As String
    Dim aDatos()
    
       Envia = Array()
       AddParam Envia, 18
       swProc = False
       
       If Not Bac_Sql_Execute("BacParamSuda.dbo.Sp_BacInterfaces_Archivo_Bcf", Envia) Then
          MsgBox "Problemas al leer interfaz MKPZ de Tasa y Precios", vbCritical, TITSISTEMA
          Exit Function
       End If
          
       If Bac_SQL_Fetch(DATOS()) Then
       
          cNomArchivo = DATOS(2)
          cruta = DATOS(4)
       
       End If
       
        cNomArchivo = cruta + cNomArchivo
        
        If Dir(cNomArchivo, vbArchive) = "" Then
            MsgBox "No existe Archivo MKPZ", vbCritical, TITSISTEMA
            Exit Function
        End If
        
        Fecha = Func_Read_TXT(cNomArchivo, 1, 10)
        
        If CDate(Fecha) <> gsBac_Fecp Then
           MsgBox "La fecha del Archivo " & cNomArchivo & " No coincide con la fecha de proceso", vbCritical, TITSISTEMA
           Label4.Caption = "ERROR"
           Label4.Refresh
           Exit Function
        End If
        
        
        If Not Bac_Sql_Execute("BacParamSuda.dbo.Sp_Borra_Mkpz") Then
           MsgBox "Error al Limpiar MKPZ_TASA", vbCritical, TITSISTEMA
        End If
    
        cantreg = Func_Read_REG(cNomArchivo, 0)
        sretDos = ""
        sret = ""
        Open cNomArchivo For Input As #1
        ProgBarMKPZ.Max = cantreg
        ProgBarMKPZ.Min = 0
        Cont = 0
        
        Do While Not EOF(1)
        
            Line Input #1, sret
            aDatos = ArmaVector(sret, 10)
            Envia = Array()
            
            For i = 1 To UBound(aDatos)
                AddParam Envia, aDatos(i)
            Next i
            
            If Not Bac_Sql_Execute("BacParamSuda.dbo.Sp_inserta_Mkpz", Envia) Then
               MsgBox "Error al Cargar el Registro en MKPZ_TASA", vbCritical, TITSISTEMA
            End If
            
            Cont = Cont + 1
            Label4.Caption = Str(Round((Cont / cantreg) * 100, 0)) + " %"
            Label4.Refresh
            ProgBarMKPZ.Value = Cont
            
        Loop
        
    Close #1
    swProc = True
        
End Function

Function Proc_carga_TARIFADO()

On Error Resume Next

Dim DATOS()
Dim cantreg, Cont, i As Integer
Dim sretDos As String
Dim cNomArchivo As String
Dim aDatos()
   Envia = Array()
   AddParam Envia, 19
   swProcTasa = False
   If Not Bac_Sql_Execute("BacParamSuda.dbo.Sp_BacInterfaces_Archivo_Bcf", Envia) Then
      MsgBox "Problemas al leer interfaz TARIFADO de Tasa y Precios", vbCritical, TITSISTEMA
      Exit Function
   End If
      
   If Bac_SQL_Fetch(DATOS()) Then
   
      cNomArchivo = DATOS(2)
      cruta = DATOS(4)
   
   End If
   
    cNomArchivo = cruta + cNomArchivo
    
    If Dir(cNomArchivo, vbArchive) = "" Then
        MsgBox "No existe Archivo TASA.TXT", vbCritical, TITSISTEMA
        Exit Function
    End If
    
    Fecha = Func_Read_TXT(cNomArchivo, 1, 10)
    
    If CDate(Fecha) <> gsBac_Fecp Then
       MsgBox "La fecha del Archivo " & cNomArchivo & " No coincide con la fecha de proceso", vbCritical, TITSISTEMA
       Label5.Caption = "ERROR"
       Label5.Refresh
       Exit Function
    End If
    
    If Not Bac_Sql_Execute("BacParamSuda.dbo.Sp_Borra_tarifado") Then
       MsgBox "Error al Limpiar TARIFADO_TASA", vbCritical, TITSISTEMA
    End If

    cantreg = Func_Read_REG(cNomArchivo, 0)
    sretDos = ""
    Open cNomArchivo For Input As #1
    ProgBarTASA.Max = cantreg
    ProgBarTASA.Min = 0
    Cont = 0
    
    Do While Not EOF(1)
    
        Line Input #1, sretDos
        aDatos = ArmaVector(sretDos, 8)
        Envia = Array()
        
        For i = 1 To UBound(aDatos)
            AddParam Envia, aDatos(i)
        Next i
        
        If Not Bac_Sql_Execute("BacParamSuda.dbo.Sp_inserta_Tarifado", Envia) Then
           MsgBox "Error al Cargar el Registro en TARIFADO_TASA", vbCritical, TITSISTEMA
        End If
        
        Cont = Cont + 1
        Label5.Caption = Str(Round((Cont / cantreg) * 100, 0)) + " %"
        Label5.Refresh
        ProgBarTASA.Value = Cont
        
    Loop
    
    Close #1
    swProcTasa = True
    
End Function

Function Proc_Carga_Tasas()
  swProcDef = False
  ProgBarCarga.Max = 100
  ProgBarCarga.Min = 0
  ProgBarCarga.Value = 50
  Label6.Caption = Str(Round((50 / 100) * 100, 0)) + " %"
  Label6.Refresh
  If Not Bac_Sql_Execute("Sp_inserta_Tasas_Definitivas") Then
     MsgBox "Error al Cargar el Tasa definitivas", vbCritical, TITSISTEMA
  End If
  Label6.Caption = Str(Round((100 / 100) * 100, 0)) + " %"
  Label6.Refresh
  ProgBarCarga.Value = 100
  swProcDef = True
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

Function ArmaVector(cLinea As String, nColumnas As Integer) As Variant
Dim aV()
Dim i As Integer
Dim C As Variant
i = 1
Do While i <= nColumnas
    C = Mid(cLinea, 1, IIf(InStr(1, cLinea, ",") <> 0, InStr(1, cLinea, ",") - 1, Len(cLinea)))
    If IsNumeric(C) Or C = "" Then
       If C = "" Then
          C = 0
       Else
          C = CDbl(C)
       End If
    End If
    ReDim Preserve aV(i)
    aV(i) = C
    cLinea = IIf(InStr(1, cLinea, ",") <> 0, Mid(cLinea, InStr(1, cLinea, ",") + 1), "")
    i = i + 1
Loop
ArmaVector = aV
End Function

Function Func_Read_TXT(sFilename As String, inicio As Integer, Fin As Integer) As String
'Lee el archivo de texto
    Dim sret As String
    Dim text
    Open sFilename For Input As #100
    Line Input #100, sret
    text = sret
    Close #100
    Func_Read_TXT = Mid(text, inicio, Fin)
End Function

'===============================================================================
' LD1-COR-035-Configuración BAC Corpbanca - Tema: INTERFACES Tarifado y MKPZ
' FIN
'===============================================================================
