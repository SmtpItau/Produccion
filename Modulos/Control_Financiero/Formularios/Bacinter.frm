VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BACCONTROLES.OCX"
Begin VB.Form BacInterfaz 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   " Generador de Archivo"
   ClientHeight    =   3945
   ClientLeft      =   3090
   ClientTop       =   2595
   ClientWidth     =   5160
   Icon            =   "Bacinter.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   3945
   ScaleWidth      =   5160
   ShowInTaskbar   =   0   'False
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   3180
      Top             =   1005
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
            Picture         =   "Bacinter.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacinter.frx":075C
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   5
      Top             =   0
      Width           =   5160
      _ExtentX        =   9102
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Aceptar"
            Description     =   "Aceptar"
            Object.ToolTipText     =   "Aceptar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Description     =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin VB.DriveListBox Drive1 
      Height          =   315
      Left            =   105
      TabIndex        =   3
      Top             =   1575
      Width           =   4950
   End
   Begin Threed.SSFrame SSFrame3 
      Height          =   765
      Left            =   0
      TabIndex        =   0
      Top             =   510
      Width           =   5160
      _Version        =   65536
      _ExtentX        =   9102
      _ExtentY        =   1349
      _StockProps     =   14
      Caption         =   "Fecha"
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
      Begin BACControles.TXTFecha TxtFecha 
         Height          =   324
         Left            =   108
         TabIndex        =   4
         Top             =   300
         Width           =   1224
         _ExtentX        =   2170
         _ExtentY        =   582
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "25/10/2000"
      End
      Begin BACControles.TXTFecha txtfechahasta 
         Height          =   330
         Left            =   2280
         TabIndex        =   6
         Top             =   300
         Width           =   1230
         _ExtentX        =   2170
         _ExtentY        =   582
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "25/10/2000"
      End
   End
   Begin Threed.SSFrame SSFrame1 
      Height          =   2700
      Left            =   0
      TabIndex        =   1
      Top             =   1230
      Width           =   5160
      _Version        =   65536
      _ExtentX        =   9102
      _ExtentY        =   4762
      _StockProps     =   14
      Caption         =   "Destino"
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
      Begin VB.DirListBox Dir1 
         Height          =   1890
         Left            =   105
         TabIndex        =   2
         Top             =   675
         Width           =   4950
      End
   End
End
Attribute VB_Name = "BacInterfaz"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim sOpcionSistema As String
Public Interfaz As String

Private Sub Btnimprimir()
   Dim cFecbus As String
   Dim cruta As String
   
   cFecbus = Format(TxtFecha.Text, FeFecha)
   cruta = BacRuta(Dir1.Path)
   Call Genera_Archivo(cFecbus, cruta)
 Unload Me
   
End Sub


Private Sub Drive1_Change()

   On Error GoTo Herror

   Dir1.Path = Drive1

   Exit Sub
    
Herror:
   MsgBox "Error: " & Err.Number & " Descripción: " & Err.Description, vbCritical, "Interfaz"
   Drive1 = "c:\"
   Dir1.Path = "c:\"
   Exit Sub

End Sub

Private Sub Form_Activate()
   Dim dUltDMesAnt  As String
   Dim dFirstDay    As String
   
   sOpcionSistema = ""
   TxtFecha.Text = Format$(gsBAC_Fecp, gsc_FechaDMA)
   txtfechahasta.Text = Format$(gsBAC_Fecp, gsc_FechaDMA)

   If BacInterfaz.Tag = "Interfaz Cap VII" Then
        TxtFecha.Enabled = True
        txtfechahasta.Enabled = False
        sOpcionSistema = "Opc_40113"
        
   
   
   End If
   
   
   
   
   
End Sub

Private Sub Form_Load()
   Me.Top = 0
   Me.Left = 0
   
   
      
''''   If Dir(gsBac_Path_Interfaces, vbDirectory) = "" Then
''''      Dir1.Path = Drive1
''''      gsBac_Path_Interfaces = Drive1
''''   ElseIf BacInterfaz.Interfaz = "Interfaz de Direcciones" Or BacInterfaz.Interfaz = "Interfaz de Posicion" Or BacInterfaz.Interfaz = "Interfaz de Operaciones" Or BacInterfaz.Interfaz = "Interfaz de Derivados" Or BacInterfaz.Interfaz = "Interfaz de Balance" Then
''''      Dir1.Path = gsBac_DIRIBS
''''   Else
''''      Dir1.Path = gsBac_Path_Interfaces 'Drive1
''''   End If

End Sub

Private Sub Form_Unload(Cancel As Integer)
        Call GRABA_LOG_AUDITORIA(sOpcionSistema, "08", "Salida de opción", "", "", "")
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Index
    Case 1      '"Aceptar"
        Call Btnimprimir
    Case 2      '"Salir"
        Unload Me
    End Select
End Sub

Private Sub TxtFecha_Change()

   If TxtFecha.Text = "" Then
      
      TxtFecha.Text = Format$(gsBAC_Fecp, gsc_FechaDMA)
      txtfechahasta.Text = Format$(gsBAC_Fecp, gsc_FechaDMA)

   End If

End Sub

Public Sub Genera_Archivo(cFecha As String, cruta As String)
   
   Dim cLine$
   Dim datos()
   Dim cNomArchivo    As String
   Dim cUsuario       As String
   


On Error GoTo Herror1

   
   Sql = " "
   
   
   cUsuario = MatAtriOpe.Cmb_Usuarios.Text
   
   cNomArchivo = " "
   
   cNomArchivo = cruta & "MATRIZ" & ".CSV"
   
   Envia = Array()
      
      If Mid(Trim(cUsuario), 1, 11) = "<< TODOS >>" Then
        AddParam Envia, " "
      Else
        AddParam Envia, Trim(Mid(cUsuario, InStr(1, cUsuario, "CODIGO") + 1, 70))     ''Len("CODIGO")
      End If
   
      
   If Not Bac_Sql_Execute("SP_MATRIZ_ATRIBUCIONES_OPERADOR", Envia) Then
   
       MsgBox "Problemas al leer datos", vbCritical, "MENSAJE"
       Exit Sub
       
   End If
  
   
   
   cNomArchivo = cruta & "MATRIZ" & ".CSV"
    

   
   If Dir(cNomArchivo) <> "" Then
    Kill cNomArchivo
 End If

   
   Open cNomArchivo For Output As #1
   
   
       cLine = " "                                    '-- Entidad
       cLine = "OPERADOR"                              '-- Nombre Operador
       cLine = cLine & "," & "PRODUCTO"                 '-- Tipo Operación
       cLine = cLine & "," & "MTO. TOTAL OPER."                 '-- Monto Total Asignado
       cLine = cLine & "," & "MTO. MAXIMO DIARIO"                 '-- Monto Acumulado
       cLine = cLine & "," & "MTO. DIARIO ACUM."                 '-- Saldo Disponible
       cLine = cLine & "," & "SALDO DIARIO"
       
    Print #1, cLine
      
   Do While Bac_SQL_Fetch(datos())
       cLine = " "                                    '-- Entidad
       cLine = datos(2)                       '-- Nombre Operador
       cLine = cLine & "," & datos(5)                 '-- Tipo Operación
       cLine = cLine & "," & datos(6)                 '-- Monto Total Asignado
       cLine = cLine & "," & datos(7)                 '-- Monto Acumulado
       cLine = cLine & "," & datos(8)                 '-- Saldo Disponible
       cLine = cLine & "," & datos(9)
       
''''       cLine = cLine & "," & Chr(13) & Chr(10)
             
      
    ''Print #1, , cLine
    
    Print #1, cLine
       
   Loop
   
   Close #1
   
   
   MsgBox "Archivo Generado" & " " & cNomArchivo, vbOKOnly, "MENSAJE"
   Exit Sub
   
Herror1:
   MsgBox "Error: " & Err.Number & " Descripción: " & Err.Description, vbCritical, "Archivo"
   Exit Sub


End Sub



