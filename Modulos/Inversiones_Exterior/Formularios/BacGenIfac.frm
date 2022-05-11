VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{15EBA0D5-0F67-11D6-A40D-00C04F5AA80A}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacGenIfac 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Generación de Interfaces"
   ClientHeight    =   4560
   ClientLeft      =   855
   ClientTop       =   1620
   ClientWidth     =   4920
   Icon            =   "BacGenIfac.frx":0000
   LinkTopic       =   "Form2"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4560
   ScaleWidth      =   4920
   Begin VB.Frame Frame2 
      Caption         =   "Interfaces"
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   11.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   1380
      Left            =   75
      TabIndex        =   3
      Top             =   3105
      Width           =   4725
      Begin VB.PictureBox Checked 
         BorderStyle     =   0  'None
         Height          =   255
         Index           =   6
         Left            =   300
         Picture         =   "BacGenIfac.frx":030A
         ScaleHeight     =   255
         ScaleWidth      =   330
         TabIndex        =   28
         Top             =   885
         Visible         =   0   'False
         Width           =   330
      End
      Begin VB.PictureBox SinCheck 
         BorderStyle     =   0  'None
         Height          =   255
         Index           =   6
         Left            =   300
         Picture         =   "BacGenIfac.frx":0458
         ScaleHeight     =   255
         ScaleWidth      =   285
         TabIndex        =   27
         Top             =   885
         Width           =   285
      End
      Begin VB.PictureBox Checked 
         Appearance      =   0  'Flat
         BackColor       =   &H80000004&
         BorderStyle     =   0  'None
         ForeColor       =   &H80000008&
         Height          =   255
         Index           =   0
         Left            =   345
         Picture         =   "BacGenIfac.frx":05A6
         ScaleHeight     =   255
         ScaleWidth      =   330
         TabIndex        =   26
         Top             =   3195
         Visible         =   0   'False
         Width           =   330
      End
      Begin VB.PictureBox Checked 
         BorderStyle     =   0  'None
         Height          =   255
         Index           =   1
         Left            =   375
         Picture         =   "BacGenIfac.frx":06F4
         ScaleHeight     =   255
         ScaleWidth      =   330
         TabIndex        =   25
         Top             =   3405
         Visible         =   0   'False
         Width           =   330
      End
      Begin VB.PictureBox Checked 
         BorderStyle     =   0  'None
         Height          =   255
         Index           =   2
         Left            =   435
         Picture         =   "BacGenIfac.frx":0842
         ScaleHeight     =   255
         ScaleWidth      =   330
         TabIndex        =   24
         Top             =   3750
         Visible         =   0   'False
         Width           =   330
      End
      Begin VB.PictureBox Checked 
         BorderStyle     =   0  'None
         Height          =   255
         Index           =   3
         Left            =   300
         Picture         =   "BacGenIfac.frx":0990
         ScaleHeight     =   255
         ScaleWidth      =   330
         TabIndex        =   23
         Top             =   390
         Visible         =   0   'False
         Width           =   330
      End
      Begin VB.PictureBox Checked 
         BorderStyle     =   0  'None
         Height          =   255
         Index           =   4
         Left            =   480
         Picture         =   "BacGenIfac.frx":0ADE
         ScaleHeight     =   255
         ScaleWidth      =   330
         TabIndex        =   22
         Top             =   4155
         Visible         =   0   'False
         Width           =   330
      End
      Begin VB.PictureBox Checked 
         BorderStyle     =   0  'None
         Height          =   255
         Index           =   5
         Left            =   720
         Picture         =   "BacGenIfac.frx":0C2C
         ScaleHeight     =   255
         ScaleWidth      =   330
         TabIndex        =   21
         Top             =   4590
         Visible         =   0   'False
         Width           =   330
      End
      Begin VB.PictureBox SinCheck 
         BorderStyle     =   0  'None
         Height          =   255
         Index           =   5
         Left            =   495
         Picture         =   "BacGenIfac.frx":0D7A
         ScaleHeight     =   255
         ScaleWidth      =   315
         TabIndex        =   15
         Top             =   4620
         Width           =   315
      End
      Begin VB.PictureBox SinCheck 
         BorderStyle     =   0  'None
         Height          =   255
         Index           =   4
         Left            =   225
         Picture         =   "BacGenIfac.frx":0EC8
         ScaleHeight     =   255
         ScaleWidth      =   315
         TabIndex        =   14
         Top             =   4185
         Width           =   315
      End
      Begin VB.PictureBox SinCheck 
         BorderStyle     =   0  'None
         Height          =   255
         Index           =   3
         Left            =   300
         Picture         =   "BacGenIfac.frx":1016
         ScaleHeight     =   255
         ScaleWidth      =   315
         TabIndex        =   13
         Top             =   390
         Width           =   315
      End
      Begin VB.PictureBox SinCheck 
         BorderStyle     =   0  'None
         Height          =   255
         Index           =   2
         Left            =   180
         Picture         =   "BacGenIfac.frx":1164
         ScaleHeight     =   255
         ScaleWidth      =   315
         TabIndex        =   12
         Top             =   3795
         Width           =   315
      End
      Begin VB.PictureBox SinCheck 
         BorderStyle     =   0  'None
         Height          =   255
         Index           =   1
         Left            =   120
         Picture         =   "BacGenIfac.frx":12B2
         ScaleHeight     =   255
         ScaleWidth      =   315
         TabIndex        =   11
         Top             =   3390
         Width           =   315
      End
      Begin VB.PictureBox SinCheck 
         BorderStyle     =   0  'None
         Height          =   255
         Index           =   0
         Left            =   45
         Picture         =   "BacGenIfac.frx":1400
         ScaleHeight     =   255
         ScaleWidth      =   315
         TabIndex        =   10
         Top             =   3195
         Width           =   315
      End
      Begin VB.Label Label3 
         Caption         =   "Interfaz Contable"
         ForeColor       =   &H00800000&
         Height          =   255
         Index           =   6
         Left            =   1000
         TabIndex        =   18
         Tag             =   "Pmddd30.txt"
         Top             =   885
         Width           =   2775
      End
      Begin VB.Label Label3 
         Caption         =   "Interfaz D31"
         ForeColor       =   &H00800000&
         Height          =   255
         Index           =   5
         Left            =   1125
         TabIndex        =   9
         Tag             =   "Pmddd30.txt"
         Top             =   4605
         Width           =   2775
      End
      Begin VB.Label Label3 
         Caption         =   "Interfaces C14 y C15"
         ForeColor       =   &H00800000&
         Height          =   255
         Index           =   4
         Left            =   870
         TabIndex        =   8
         Tag             =   "Interfaz5.txt"
         Top             =   4185
         Width           =   2775
      End
      Begin VB.Label Label3 
         Caption         =   "Interfaces C08 y C09"
         ForeColor       =   &H00800000&
         Height          =   255
         Index           =   3
         Left            =   1000
         TabIndex        =   7
         Tag             =   "Interfaz4.txt"
         Top             =   390
         Width           =   2775
      End
      Begin VB.Label Label3 
         Caption         =   "Interfaz Mensual por Plazos Residuales"
         ForeColor       =   &H00800000&
         Height          =   255
         Index           =   2
         Left            =   825
         TabIndex        =   6
         Top             =   3795
         Width           =   2775
      End
      Begin VB.Label Label3 
         Caption         =   "Interfaz Mensual Control Gral. Créditos"
         ForeColor       =   &H00800000&
         Height          =   255
         Index           =   1
         Left            =   765
         TabIndex        =   5
         Tag             =   "Mensaamm.txt"
         Top             =   3390
         Width           =   2775
      End
      Begin VB.Label Label3 
         Caption         =   "Interfaz Diaria Control Gral. Créditos"
         ForeColor       =   &H00800000&
         Height          =   240
         Index           =   0
         Left            =   690
         TabIndex        =   4
         Tag             =   "CGDC.txt"
         Top             =   3195
         Width           =   2775
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "Destino de Interfaces"
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   2355
      Left            =   75
      TabIndex        =   2
      Top             =   690
      Width           =   4725
      Begin VB.CheckBox Chk_Ruta 
         Caption         =   "Chk_Ruta"
         Height          =   375
         Left            =   120
         TabIndex        =   20
         Top             =   360
         Value           =   1  'Checked
         Width           =   255
      End
      Begin VB.TextBox Txt_Ruta 
         Height          =   285
         Left            =   420
         Locked          =   -1  'True
         TabIndex        =   19
         Text            =   "Txt_Ruta"
         Top             =   345
         Width           =   2595
      End
      Begin VB.DriveListBox Drive1 
         Enabled         =   0   'False
         Height          =   315
         Left            =   120
         TabIndex        =   17
         Top             =   1935
         Width           =   4500
      End
      Begin VB.DirListBox Dir1 
         Enabled         =   0   'False
         Height          =   990
         Left            =   120
         TabIndex        =   16
         Top             =   840
         Width           =   4470
      End
      Begin BacControles.txtFecha txtFecha1 
         Height          =   315
         Left            =   3135
         TabIndex        =   1
         Top             =   315
         Width           =   1395
         _ExtentX        =   2461
         _ExtentY        =   556
         Text            =   "20/06/2001"
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MinDate         =   -328716
         MaxDate         =   2958465
      End
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   3360
      Top             =   0
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   5
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacGenIfac.frx":154E
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacGenIfac.frx":19A0
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacGenIfac.frx":1AFA
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacGenIfac.frx":1F4C
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacGenIfac.frx":2266
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   4920
      _ExtentX        =   8678
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Generar Interfaces"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Generar Planillas"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   4
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
End
Attribute VB_Name = "BacGenIfac"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim Ruta_Local As String

Private Function NombreHoja(lsPath As String) As String
    
    'declaro variables...
    Dim liPosicion As Integer
    
    'posicion parte en 0
    liPosicion = 0
    
    'busco el ultimo slach
    Do Until InStr((liPosicion + 1), lsPath, "\") = 0
    
       liPosicion = InStr((liPosicion + 1), lsPath, "\")
    
    Loop

    'devuelvo nombnre para archivo...
    NombreHoja = IIf(liPosicion = 0, "Hoja1", Mid(lsPath, liPosicion + 1))
    
End Function
Function Interfaz_c08_c09(Destino As Boolean)

    Dim datos()
    NombreArchivo = IIf(Destino = False, IIf(Chk_Ruta.Value, Ruta_Interfaces & "InterfazC09.txt", Ruta_Local & "InterfazC09.txt"), IIf(Chk_Ruta.Value, Ruta_Interfaces & "InterfazC09.xls", Ruta_Local & "InterfazC09.xls"))
    
        
    If Dir(NombreArchivo) <> "" Then
        Kill NombreArchivo
    End If
    
    Open NombreArchivo For Output As #1
    
    Screen.MousePointer = vbHourglass
    
    envia = Array()
    AddParam envia, 9
    AddParam envia, txtFecha1.Text
    
    If Not Bac_Sql_Execute("Svc_Itf_C08_C09", envia) Then
        MsgBox "No se ha podido concluir la operacion", vbCritical, gsBac_Version
        Screen.MousePointer = vbDefault
    End If
        
    If Destino = False Then
    
        Do While Bac_SQL_Fetch(datos())
        
            Linea = ""
            Linea = Linea + Trim(datos(1))                         '1     1-3
            Linea = Linea + Ceros(Trim(datos(2)), 1) + datos(2)    '2      4-4
            Linea = Linea + Ceros(Trim(datos(3)), 4) + datos(3)    '3      5-8
            Linea = Linea + Ceros(Trim(datos(4)), 2) + datos(4)    '4      9-10
            Linea = Linea + Ceros(Trim(datos(5)), 3) + datos(5)    '5      11-13
            Linea = Linea + Ceros(Trim(datos(6)), 14) + datos(6)   '6      14-27
            Linea = Linea + Ceros(Trim(datos(7)), 14) + datos(7)   '7      28-41
            Linea = Linea + Ceros(Trim(datos(8)), 14) + datos(8)   '8      42-55
            Linea = Linea + Ceros(Trim(datos(9)), 1) + datos(9)    '9      56-56
            Linea = Linea + datos(10)          '10     57-64

            
            Print #1, Linea
            
        Loop
    
    Else
    
        Do While Bac_SQL_Fetch(datos())
        
            
            Linea = ""
            Linea = Linea + datos(1) + Chr(9)
            Linea = Linea + datos(2) + Chr(9)
            Linea = Linea + datos(3) + Chr(9)
            Linea = Linea + datos(4) + Chr(9)
            Linea = Linea + datos(5) + Chr(9)
            Linea = Linea + datos(6) + Chr(9)
            Linea = Linea + datos(7) + Chr(9)
            Linea = Linea + datos(8) + Chr(9)
            Linea = Linea + datos(9) + Chr(9)
            Linea = Linea + datos(10) + Chr(9)
            
            
            Print #1, Linea
            
        Loop
        
    End If
    
    Close #1
    
    NombreArchivo = IIf(Destino = False, IIf(Chk_Ruta.Value, Ruta_Interfaces & "InterfazC08.txt", Ruta_Local & "InterfazC08.txt"), IIf(Chk_Ruta.Value, Ruta_Interfaces & "InterfazC08.xls", Ruta_Local & "InterfazC08.xls"))
    
    If Dir(NombreArchivo) <> "" Then
        Kill NombreArchivo
    End If
    
    Open NombreArchivo For Output As #1
    
    envia = Array()
    AddParam envia, 8
    AddParam envia, txtFecha1.Text
    
    If Not Bac_Sql_Execute("Svc_Itf_C08_C09", envia) Then
        MsgBox "No se ha podido concluir la operacion", vbCritical, gsBac_Version
        Screen.MousePointer = vbDefault
    End If
    
    If Destino = False Then

        Do While Bac_SQL_Fetch(datos())
        
            Linea = ""
            Linea = Linea + Trim(datos(1))
            Linea = Linea + Ceros(Trim(datos(2)), 1) + datos(2)
            Linea = Linea + Ceros(Trim(datos(3)), 4) + datos(3)
            Linea = Linea + Ceros(Trim(datos(4)), 2) + datos(4)
            Linea = Linea + Ceros(Trim(datos(5)), 1) + datos(5)
            Linea = Linea + Ceros(Trim(datos(6)), 14) + datos(6)
            Linea = Linea + Ceros(Trim(datos(7)), 14) + datos(7)
            Linea = Linea + Ceros(Trim(datos(8)), 14) + datos(8)
            Linea = Linea + Ceros(Trim(datos(9)), 1) + datos(9)
        '    Linea = Linea + Ceros(Trim(datos(10)), 5) + datos(10)
            Linea = Linea + datos(10)

            Print #1, Linea
            
        Loop
    Else
    
        Do While Bac_SQL_Fetch(datos())
          
            Linea = ""
            Linea = Linea + datos(1) + Chr(9)
            Linea = Linea + datos(2) + Chr(9)
            Linea = Linea + datos(3) + Chr(9)
            Linea = Linea + datos(4) + Chr(9)
            Linea = Linea + datos(5) + Chr(9)
            Linea = Linea + datos(6) + Chr(9)
            Linea = Linea + datos(7) + Chr(9)
            Linea = Linea + datos(8) + Chr(9)
            Linea = Linea + datos(9) + Chr(9)
            Linea = Linea + datos(10) + Chr(9)
            Linea = Linea + datos(11) + Chr(9)
            Print #1, Linea
            
        Loop
    
    End If
    Close #1
    
    Screen.MousePointer = vbDefault
    Checked(3).Visible = False

    Call rerpotes_c08c09
    MsgBox "Interfaces C08 y C09 Generadas", vbInformation, gsBac_Version
    
End Function

Sub interfaz_contable()
        
    'dimensiono variables
    Dim ls_registros As String
    Dim ls_totales As String
    Dim datos()

    Dim Fec_Aux As String
    
    Screen.MousePointer = vbHourglass
    
    Data1.Refresh
    
    If Data1.Recordset.RecordCount > 0 Then
        Data1.Recordset.MoveFirst
        Do While Not Data1.Recordset.EOF
            Data1.Recordset.Edit
            Data1.Recordset("mocartera") = "888"
            Data1.Recordset.Update
            Data1.Recordset.MoveNext
        Loop
    End If
    
    Data2.Refresh
    If Data2.Recordset.RecordCount > 0 Then
        Data2.Recordset.MoveFirst
        Do While Not Data2.Recordset.EOF
            Data2.Recordset.Edit
            Data2.Recordset("rscartera") = "888"
            Data2.Recordset.Update
            Data2.Recordset.MoveNext
        Loop
    End If
    
        Data3.Refresh

    If Data3.Recordset.RecordCount > 0 Then
        Data3.Recordset.MoveFirst
        Do While Not Data3.Recordset.EOF
            Data3.Recordset.Edit
       '    Fec_Aux = SumaHabil(txtFecha1.Text, -1)
            Data3.Recordset("acfecant") = Format(Fec_Aux, "dd/mm/yyyy")
            Data3.Recordset("acfecproc") = Format(txtFecha1.Text, "dd/mm/yyyy")
            'Fec_Aux = SumaHabil(txtFecha1.Text, 1)
            Data3.Recordset("acfecpxpr") = Format(Fec_Aux, "dd/mm/yyyy")
            Data3.Recordset.Update
            Data3.Recordset.MoveNext
        Loop
    End If
    Data3.Recordset.Close
    
    envia = Array(txtFecha1.Text)
    
    'llamo al primer procedimiento
    If Not Bac_Sql_Execute("sp_interfaz_contable_mdmo ", envia()) Then
    
        'aviso al usuario
        MsgBox "Se ha producido un error mientras se generaba interfaz", vbCritical, gsBac_Version
        
        Screen.MousePointer = vbDefault

        Exit Sub
        
    End If
    
    
    'genero txt
    NombreArchivo = IIf(Chk_Ruta.Value, Ruta_Interfaces & "mdd0mov0.txt", Ruta_Local & "mdd0mov0.txt")
    
    'valido existencia de archivo
    If Dir(NombreArchivo) <> "" Then
    
        
        Kill NombreArchivo
    
    End If

    Open NombreArchivo For Output As #1
    
    Do While Bac_SQL_Fetch(datos())
        
        Linea = ""
        
        'genero linea de texto
        Linea = Linea & Trim(datos(1))
        Linea = Linea & Espacios(Trim(datos(2)), 3) & Trim(datos(2))
        Linea = Linea & Ceros(Trim(datos(3)), 6) & Trim(datos(3))
        Linea = Linea & Ceros(Trim(datos(4)), 6) & Trim(datos(4))
        Linea = Linea & Ceros(Trim(datos(5)), 3) & Trim(datos(5))
        Linea = Linea & Espacios(Trim(datos(6)), 10) & Trim(datos(6))
        Linea = Linea & Ceros(Trim(datos(7)), 8) & Trim(datos(7))
        Linea = Linea & Ceros(Trim(datos(8)), 3) & Trim(datos(8))
        Linea = Linea & Trim(datos(9))
        Linea = Linea & Trim(datos(10))
        Linea = Linea & Trim(datos(11))
        Linea = Linea & Trim(datos(12))
        Linea = Linea & Trim(datos(13))
        Linea = Linea & Ceros(Trim(datos(14)), 18) & Trim(datos(14))
        Linea = Linea & Ceros(Trim(datos(15)), 18) & Trim(datos(15))
        Linea = Linea & Trim(datos(16))
        Linea = Linea & Ceros(Trim(datos(17)), 9) & Trim(datos(17))
        Linea = Linea & Ceros(Trim(datos(18)), 7) & Trim(datos(18))
        Linea = Linea & Trim(datos(19))
        Linea = Linea & Ceros(Trim(datos(20)), 18) & Trim(datos(20))
        Linea = Linea & Trim(datos(21))
        Linea = Linea & Trim(datos(22))
        Linea = Linea & Trim(datos(23))
        Linea = Linea & Trim(datos(24))
        Linea = Linea & Ceros(Trim(datos(25)), 9) & Trim(datos(25))
        Linea = Linea & Ceros(Trim(datos(26)), 7) & Trim(datos(26))
        Linea = Linea & Trim(datos(27))
        Linea = Linea & Trim(datos(28))
        Linea = Linea & Ceros(Trim(datos(29)), 18) & Trim(datos(29))
        Linea = Linea & Trim(datos(30))
        Linea = Linea & Ceros(Trim(datos(31)), 9) & Trim(datos(31))
        Linea = Linea & Ceros(Trim(datos(32)), 7) & Trim(datos(32))
        Linea = Linea & Trim(datos(33))
        Linea = Linea & Trim(datos(34))
        Linea = Linea & Trim(datos(35))
        Linea = Linea & Trim(datos(36))
        Linea = Linea & Ceros(Trim(datos(37)), 18) & Trim(datos(37))
        Linea = Linea & Trim(datos(38))
        Linea = Linea & Trim(datos(39))
        Linea = Linea & Ceros(Trim(datos(40)), 3) & Trim(datos(40))
        Linea = Linea & Trim(datos(41))
        Linea = Linea & Trim(datos(42))
        Linea = Linea & Trim(datos(43))
        Linea = Linea & Espacios(Trim(datos(44)), 3) & Trim(datos(44))
        Linea = Linea & Trim(datos(45))
        Linea = Linea & Trim(datos(46))
        Linea = Linea & datos(47)
        Linea = Linea & datos(48)
        Linea = Linea & datos(49)
        Linea = Linea & datos(50)
        Linea = Linea & Ceros(Trim(datos(51)), 3) & Trim(datos(51))
        Linea = Linea & datos(52)
        Linea = Linea & datos(53)
        Linea = Linea & datos(54)
        Linea = Linea & datos(55)
        Linea = Linea & datos(56)
        Linea = Linea & datos(57)
        Linea = Linea & datos(58)
        Linea = Linea & Ceros(Trim(datos(59)), 5) & Trim(datos(59))
        Linea = Linea & datos(61)
        Linea = Linea & datos(62)
        Linea = Linea & datos(63)
        Linea = Linea & datos(64)
        Linea = Linea & Ceros(Trim(datos(65)), 18) & Trim(datos(65))
        Linea = Linea & Ceros(Trim(datos(66)), 18) & Trim(datos(66))
        Linea = Linea & datos(67)
        Linea = Linea & datos(68)
        Linea = Linea & datos(69)
        Linea = Linea & datos(70)
        Linea = Linea & datos(71)
        Linea = Linea & datos(72)
        Linea = Linea & datos(73)
        Linea = Linea & datos(74)
        Linea = Linea & datos(75)
        Linea = Linea & datos(76)
        Linea = Linea & datos(77)
        Linea = Linea & datos(78)
        Linea = Linea & datos(79)
        Linea = Linea & Ceros(Trim(datos(80)), 18) & Trim(datos(80))
        Linea = Linea & Ceros(Trim(datos(81)), 18) & Trim(datos(81))
        Linea = Linea & Ceros(Trim(datos(82)), 18) & Trim(datos(82))
        Linea = Linea & datos(83)
        Linea = Linea & datos(84)
        Linea = Linea & Ceros(Trim(datos(85)), 18) & Trim(datos(85))
        Linea = Linea & Ceros(Trim(datos(86)), 18) & Trim(datos(86))
        Linea = Linea & datos(87)
        Linea = Linea & datos(88)
        Linea = Linea & datos(89)
        Linea = Linea & datos(90)
        Linea = Linea & datos(91)
        Linea = Linea & datos(92)
        Linea = Linea & datos(93)
        Linea = Linea & datos(94)
        Linea = Linea & datos(95)
        Linea = Linea & datos(96)
        Linea = Linea & datos(97)
        Linea = Linea & datos(98)
        Linea = Linea & datos(99)
        Linea = Linea & datos(100)
        Linea = Linea & datos(101)
        Linea = Linea & datos(102)
        Linea = Linea & datos(103)
        Linea = Linea & datos(104)
        Linea = Linea & datos(105)
                   
        ls_registros = datos(108)
'        ls_totales = datos(109)
        cuenta = cuenta + 1
        
        Print #1, Linea 'Ceros(Trim(cuenta), 4) & cuenta & "**" & linea & "**"
        
        
        
        Data1.Recordset.AddNew
        Data1.Recordset("moentidad") = datos(1)
        Data1.Recordset("mocartera") = datos(2)
        Data1.Recordset("monumdocu") = datos(3)
        Data1.Recordset("monumoper") = datos(4)
        Data1.Recordset("mocorrela") = datos(5)
        Data1.Recordset("moinstser") = datos(6)
        If IsDate(datos(7)) Then Data1.Recordset("mofecemis") = datos(7) Else Data1.Recordset("mofecemis") = CDate(datos(7))
        Data1.Recordset("momonemis") = datos(8)
        If Len(datos(9)) = 0 Then Data1.Recordset("morutemis") = 0 Else Data1.Recordset("morutemis") = datos(9)
        Data1.Recordset("motasemis") = datos(10)
        Data1.Recordset("mobtsemis") = datos(11)
        If IsDate(datos(12)) Then Data1.Recordset("mofecvcto") = datos(12) Else Data1.Recordset("mofecvcto") = CDate(datos(12))
        If IsDate(datos(13)) Then Data1.Recordset("mofecpcup") = datos(13) Else Data1.Recordset("mofecpcup") = CDate(datos(13))
        Data1.Recordset("monominal") = datos(14)
        Data1.Recordset("monominalp") = datos(15)
        Data1.Recordset("movalvenc") = datos(16)
        Data1.Recordset("morutclic") = datos(17)
        Data1.Recordset("mocodclic") = datos(18)
        If IsDate(datos(19)) Then Data1.Recordset("mofeccomp") = datos(19) Else Data1.Recordset("mofeccomp") = CDate(datos(19))
        Data1.Recordset("movalcomp") = datos(20)
        Data1.Recordset("motircomp") = datos(21)
        Data1.Recordset("mobtscomp") = datos(22)
        Data1.Recordset("movalcomu") = datos(23)
        If IsDate(datos(24)) Then Data1.Recordset("mofecvend") = datos(24) Else Data1.Recordset("mofecvend") = CDate(datos(24))
        Data1.Recordset("morutcliv") = datos(25)
        Data1.Recordset("mocodcliv") = datos(26)
        Data1.Recordset("motirvent") = datos(27)
        Data1.Recordset("mobtrvent") = datos(28)
        Data1.Recordset("movalvenp") = datos(29)
        Data1.Recordset("movalvenu") = datos(30)
        Data1.Recordset("morutclip") = datos(31)
        Data1.Recordset("mocodclip") = datos(32)
        If IsDate(datos(33)) Then Data1.Recordset("mofecinip") = datos(33) Else Data1.Recordset("mofecinip") = CDate(datos(33))
        If IsDate(datos(34)) Then Data1.Recordset("mofecvtop") = datos(34) Else Data1.Recordset("mofecvtop") = CDate(datos(34))
        Data1.Recordset("movalinip") = datos(35)
        Data1.Recordset("movalvtop") = datos(36)
        Data1.Recordset("movalfinp") = datos(37)
        Data1.Recordset("motaspact") = datos(38)
        Data1.Recordset("mobtspact") = datos(39)
        Data1.Recordset("momonpact") = datos(40)
        Data1.Recordset("moforppct") = datos(41)
        Data1.Recordset("moretdocp") = datos(42)
        Data1.Recordset("mocomprom") = datos(43)
        Data1.Recordset("motipoper") = datos(44)
        If IsDate(datos(45)) Then Data1.Recordset("mofecha") = datos(45) Else Data1.Recordset("mofecha") = CDate(datos(45))
        If IsDate(datos(46)) Then Data1.Recordset("mohora") = datos(46) Else Data1.Recordset("mohora") = CDate(datos(46))
        Data1.Recordset("moterminl") = datos(47)
        Data1.Recordset("mooperadr") = datos(48)
        Data1.Recordset("moemisor") = datos(49)
        Data1.Recordset("mocodcalc") = datos(50)
        Data1.Recordset("moforpago") = datos(51)    'formas de pago
        Data1.Recordset("moindcust") = datos(52)
        Data1.Recordset("moretdocu") = datos(53)
        Data1.Recordset("movalgar") = datos(54)
        Data1.Recordset("movaptecum") = datos(55)
        Data1.Recordset("movaptevum") = datos(56)
        Data1.Recordset("momercado") = datos(57)
        Data1.Recordset("moprcvpar") = datos(58)
        Data1.Recordset("mocodi") = datos(59)
        Data1.Recordset("moresintpp") = datos(60)
        Data1.Recordset("moresintpn") = datos(61)
        Data1.Recordset("movaparum") = datos(62)
        Data1.Recordset("movalparp") = datos(63)
        Data1.Recordset("moreajus") = datos(64)
        Data1.Recordset("mointdvfp") = datos(65)
        Data1.Recordset("moreadvfp") = datos(66)
        Data1.Recordset("movalparcp") = datos(67)
        Data1.Recordset("moindvtfx") = datos(68)
        Data1.Recordset("moredvtfx") = datos(69)
        Data1.Recordset("movpar114") = datos(70)
        Data1.Recordset("moredv114") = datos(71)
        Data1.Recordset("modifeprep") = datos(72)
        Data1.Recordset("modifepren") = datos(73)
        Data1.Recordset("moinst") = datos(74)       'serie instrumento
        Data1.Recordset("motipcli") = datos(75)
        Data1.Recordset("mocond_ci") = datos(76)
        Data1.Recordset("mocond_vi") = datos(77)
        Data1.Recordset("mocomquien") = datos(78)
        Data1.Recordset("mocodsuc") = datos(79)
        Data1.Recordset("movpresen") = datos(80)
        Data1.Recordset("moutixvent") = datos(81)
        Data1.Recordset("moperxvent") = datos(82)
        Data1.Recordset("moindpac") = datos(83)
        Data1.Recordset("morutcli") = datos(84)
        Data1.Recordset("mointpact") = datos(85)
        Data1.Recordset("moreapact") = datos(86)
        Data1.Recordset("mocodcap") = datos(87)
        Data1.Recordset("modifmcdop") = datos(88)
        Data1.Recordset("modifmcdon") = datos(89)
        Data1.Recordset("moel_hayer") = datos(90)
        Data1.Recordset("moel_hoy") = datos(91)
        Data1.Recordset("modifrapp") = datos(92)
        Data1.Recordset("modifrapn") = datos(93)
        Data1.Recordset("mocorr96") = datos(94)
        Data1.Recordset("momonvtop") = datos(95)
        Data1.Recordset("momonvcto") = datos(96)
        Data1.Recordset("mopaghoy") = datos(97)
        If IsDate(datos(98)) Then Data1.Recordset("mopagfec") = datos(98) Else Data1.Recordset("mopagfec") = CDate(datos(98))
        Data1.Recordset("mopago_hm") = (datos(99))
        If IsDate(datos(100)) Then Data1.Recordset("mofeccont") = datos(100) Else Data1.Recordset("mofeccont") = CDate(datos(100))
        Data1.Recordset("modcv") = datos(101)
        Data1.Recordset("modias") = datos(102)
        Data1.Recordset("moestatus") = datos(103)
        Data1.Recordset("motc_sbif") = datos(104)
        Data1.Recordset("mocodpla") = datos(105)
        Data1.Recordset("mocodplapd") = datos(108)


        Data1.Recordset.Update
                      
    Loop
    Data1.Recordset.Close
    Close #1
        
    'genero archivo de control
    NombreArchivo = IIf(Chk_Ruta.Value, Ruta_Interfaces & "mddimov0.txt", Ruta_Local & "mddimov0.txt")
    
    Open NombreArchivo For Output As #1
    
    Print #1, Ceros(ls_registros, 6) & ls_registros & Ceros(ls_totales, 18) & ls_totales
        
    Close #1
    
    'envia = Array(SumaHabil(txtFecha1.Text, -1))
    
    'llamo al primer procedimiento
    If Not Bac_Sql_Execute("sp_interfaz_contable_mdrs ", envia()) Then
    
        'aviso al usuario
        MsgBox "Se ha producido un error mientras se generaba interfaz", vbCritical, gsBac_Version
        
        Screen.MousePointer = vbDefault
        
        Exit Sub
        
    End If
    
    'genero txt
    NombreArchivo = IIf(Chk_Ruta.Value, Ruta_Interfaces & "mddcdev0.txt", Ruta_Local & "mddcdev0.txt")
    
    'valido existencia de archivo
    If Dir(NombreArchivo) <> "" Then
        
        Kill NombreArchivo
    
    End If

    Open NombreArchivo For Output As #1
    
    Do While Bac_SQL_Fetch(datos())
        
        Linea = ""
        
        'genero linea de texto
        Linea = Linea & Trim(datos(1))
        Linea = Linea & Espacios(Trim(datos(2)), 3) & Trim(datos(2))
        Linea = Linea & Ceros(Trim(datos(3)), 6) & Trim(datos(3))
        Linea = Linea & Ceros(Trim(datos(4)), 6) & Trim(datos(4))
        Linea = Linea & Ceros(Trim(datos(5)), 3) & Trim(datos(5))
        Linea = Linea & Espacios(Trim(datos(6)), 10) & Trim(datos(6))
        Linea = Linea & Ceros(Trim(datos(7)), 8) & Trim(datos(7))
        Linea = Linea & Ceros(Trim(datos(8)), 3) & Trim(datos(8))
        Linea = Linea & Trim(datos(9))
        Linea = Linea & Trim(datos(10))
        Linea = Linea & Trim(datos(11))
        Linea = Linea & Trim(datos(12))
        Linea = Linea & Trim(datos(13))
        Linea = Linea & Ceros(Trim(datos(14)), 18) & Trim(datos(14))
        Linea = Linea & Ceros(Trim(datos(15)), 18) & Trim(datos(15))
        Linea = Linea & Trim(datos(16))
        Linea = Linea & Ceros(Trim(datos(17)), 9) & Trim(datos(17))
        Linea = Linea & Ceros(Trim(datos(18)), 7) & Trim(datos(18))
        Linea = Linea & Trim(datos(19))
        Linea = Linea & Ceros(Trim(datos(20)), 18) & Trim(datos(20))
        Linea = Linea & Trim(datos(21))
        Linea = Linea & Trim(datos(22))
        Linea = Linea & Trim(datos(23))
        Linea = Linea & Trim(datos(24))
        Linea = Linea & Ceros(Trim(datos(25)), 9) & Trim(datos(25))
        Linea = Linea & Ceros(Trim(datos(26)), 7) & Trim(datos(26))
        Linea = Linea & Trim(datos(27))
        Linea = Linea & Trim(datos(28))
        Linea = Linea & Ceros(Trim(datos(29)), 18) & Trim(datos(29))
        Linea = Linea & Trim(datos(30))
        Linea = Linea & Ceros(Trim(datos(31)), 9) & Trim(datos(31))
        Linea = Linea & Ceros(Trim(datos(32)), 7) & Trim(datos(32))
        Linea = Linea & Trim(datos(33))
        Linea = Linea & Trim(datos(34))
        Linea = Linea & Trim(datos(35))
        Linea = Linea & Trim(datos(36))
        Linea = Linea & Ceros(Trim(datos(37)), 18) & Trim(datos(37))
        Linea = Linea & Trim(datos(38))
        Linea = Linea & Trim(datos(39))
        Linea = Linea & Ceros(Trim(datos(40)), 3) & Trim(datos(40))
        Linea = Linea & Trim(datos(41))
        Linea = Linea & Trim(datos(42))
        Linea = Linea & Trim(datos(43))
        Linea = Linea & Espacios(Trim(datos(44)), 3) & Trim(datos(44))
        Linea = Linea & Trim(datos(45))
        Linea = Linea & Trim(datos(46))
        Linea = Linea & datos(47)
        Linea = Linea & datos(48)
        Linea = Linea & datos(49)
        Linea = Linea & datos(50)
        Linea = Linea & Ceros(Trim(datos(51)), 3) & Trim(datos(51))
        Linea = Linea & datos(52)
        Linea = Linea & datos(53)
        Linea = Linea & datos(54)
        Linea = Linea & datos(55)
        Linea = Linea & datos(56)
        Linea = Linea & datos(57)
        Linea = Linea & datos(58)
        Linea = Linea & Ceros(Trim(datos(59)), 5) & Trim(datos(59))
        Linea = Linea & datos(61)
        Linea = Linea & datos(62)
        Linea = Linea & datos(63)
        Linea = Linea & datos(64)
        Linea = Linea & Ceros(Trim(datos(65)), 18) & Trim(datos(65))
        Linea = Linea & Ceros(Trim(datos(66)), 18) & Trim(datos(66))
        Linea = Linea & datos(67)
        Linea = Linea & datos(68)
        Linea = Linea & datos(69)
        Linea = Linea & datos(70)
        ls_registros = datos(71)
        ls_totales = IIf(IsNull(datos(72)), "", datos(72))
        
        cuenta = cuenta + 1
        
        Print #1, Ceros(Trim(cuenta), 4) & cuenta & "**" & Linea & "**"
        
        
        Data2.Recordset.AddNew

        Data2.Recordset("rsentidad") = datos(1)
        Data2.Recordset("rscartera") = datos(2)
        Data2.Recordset("rsnumdocu") = datos(3)
        Data2.Recordset("rsnumoper") = datos(4)
        Data2.Recordset("rscorrela") = datos(5)
        Data2.Recordset("rsinstser") = datos(6)
        Data2.Recordset("rsinst") = datos(7)
        Data2.Recordset("rstipoper") = datos(8)
        Data2.Recordset("rsmonemis") = datos(9)
        If IsDate(datos(10)) Then Data2.Recordset("rsfeccalc") = datos(10) Else Data2.Recordset("rsfeccalc") = CDate(datos(10))
        Data2.Recordset("rsnominal") = datos(11)
        Data2.Recordset("rsvalprep") = datos(12)
        Data2.Recordset("rsvalparu") = datos(13)
        Data2.Recordset("rsvalparp") = datos(14)
        Data2.Recordset("rsdifprcpp") = datos(15)
        Data2.Recordset("rsdifprcpn") = datos(16)
        Data2.Recordset("rsinterspp") = datos(17)
        Data2.Recordset("rsinterspn") = datos(18)
        Data2.Recordset("rsreajuspp") = datos(19)
        Data2.Recordset("rsreajuspn") = datos(20)
        Data2.Recordset("rsresintp") = datos(21)
        Data2.Recordset("rscomtotl") = datos(22)
        Data2.Recordset("rscomigan") = datos(23)
        Data2.Recordset("rscomipag") = datos(24)
        Data2.Recordset("rsrut") = datos(25)
        Data2.Recordset("rsmoneda") = datos(26)
        Data2.Recordset("rsvalcomp") = datos(27)
        Data2.Recordset("rsvalvenp") = datos(28)
        Data2.Recordset("rsvalpacp") = datos(29)
        Data2.Recordset("rsvlprupp") = datos(30)
        Data2.Recordset("rsvlprppp") = datos(31)
        Data2.Recordset("rsvlpsppp") = datos(32)
        Data2.Recordset("rsdfprpppp") = datos(33)
        Data2.Recordset("rsdfprpppn") = datos(34)
        Data2.Recordset("rsvalgar") = datos(35)
        If IsDate(datos(36)) Then Data2.Recordset("rsfecpxpr") = datos(36) Else Data2.Recordset("rsfecpxpr") = CDate(datos(36))
        Data2.Recordset("rscodinst") = datos(37)
        Data2.Recordset("rsindvtfp") = datos(38)
        Data2.Recordset("rsindvtfx") = datos(39)
        Data2.Recordset("rsredvtfp") = datos(40)
        Data2.Recordset("rsredvtfx") = datos(41)
        Data2.Recordset("rsvalparcp") = datos(42)
        Data2.Recordset("rsindpac") = datos(43)
        Data2.Recordset("rstintcupu") = datos(44)
        Data2.Recordset("rstintcupp") = datos(45)
        Data2.Recordset("rstamocupu") = datos(46)
        Data2.Recordset("rstamocupp") = datos(47)
        Data2.Recordset("rsintcapcu") = datos(48)
        Data2.Recordset("rsintdevcu") = datos(49)
        Data2.Recordset("rssalamocu") = datos(50)
        Data2.Recordset("rsamohiscu") = datos(51)
        Data2.Recordset("rsreahiscu") = datos(52)
        Data2.Recordset("rscomquien") = datos(53)
        Data2.Recordset("rscond_ci") = datos(54)
        Data2.Recordset("rscond_vi") = datos(55)
        Data2.Recordset("rscodsuc") = datos(56)
        Data2.Recordset("rsflujo") = datos(57)
        If IsDate(datos(58)) Then Data2.Recordset("rsfeccont") = datos(58) Else Data2.Recordset("rsfeccont") = CDate(datos(58))
        Data2.Recordset("rsint_acum") = datos(59)
        Data2.Recordset("rsrea_acum") = datos(60)
        Data2.Recordset("rscapital") = datos(61)
        Data2.Recordset("rsflujoum") = datos(62)
        Data2.Recordset("interspp_a") = datos(63)
        Data2.Recordset("interspn_a") = datos(64)
        Data2.Recordset("reajuspp_a") = datos(65)
        Data2.Recordset("reajuspn_a") = datos(66)
        Data2.Recordset("rsrutemis") = datos(67)
        Data2.Recordset("rsestatus") = datos(68)
        Data2.Recordset("rstc_sbif") = datos(69)
        Data2.Recordset("rscodpla") = datos(70)
        Data2.Recordset("rscodplapd") = datos(71)
        'Data2.Recordset("rstipcart") = datos(72)

        Data2.Recordset.Update
        
    Loop
    Data2.Recordset.Close
    Close #1
        
    'genero archivo de control
    NombreArchivo = IIf(Chk_Ruta.Value, Ruta_Interfaces & "mddidev0.txt", Ruta_Local & "mddidev0.txt")
    
    Open NombreArchivo For Output As #1
    
    Print #1, Ceros(ls_registros, 6) & ls_registros & Ceros(ls_totales, 18) & ls_totales
        
    Close #1
    
    Screen.MousePointer = vbDefault
    

End Sub

Function rerpotes_c08c09()
        Screen.MousePointer = 11
        BAC_INVERSIONES.BacRpt.ReportFileName = RptList_Path & "Informe_Interfazc08.rpt"
        BAC_INVERSIONES.BacRpt.WindowTitle = "C08"
        BAC_INVERSIONES.BacRpt.StoredProcParam(0) = 8
        BAC_INVERSIONES.BacRpt.StoredProcParam(1) = Format(txtFecha1.Text, "YYYYMMDD")
        BAC_INVERSIONES.BacRpt.Destination = crptToWindow
        BAC_INVERSIONES.BacRpt.Connect = CONECCION
        BAC_INVERSIONES.BacRpt.Action = 1
        Call limpiar_cristal

        BAC_INVERSIONES.BacRpt.ReportFileName = RptList_Path & "Informe_Interfazc09.rpt"
        BAC_INVERSIONES.BacRpt.WindowTitle = "C09"
        BAC_INVERSIONES.BacRpt.StoredProcParam(0) = 9
        BAC_INVERSIONES.BacRpt.StoredProcParam(1) = Format(txtFecha1.Text, "YYYYMMDD")
        BAC_INVERSIONES.BacRpt.Destination = crptToWindow
        BAC_INVERSIONES.BacRpt.Connect = CONECCION
        BAC_INVERSIONES.BacRpt.Action = 1
        Call limpiar_cristal
        Screen.MousePointer = 0
End Function

Private Sub Checked_Click(Index As Integer)
  Checked(Index).Visible = False
End Sub

Private Sub Chk_Ruta_Click()
    Dir1.Enabled = (Chk_Ruta.Value - 1) * -1
    Drive1.Enabled = (Chk_Ruta.Value - 1) * -1
End Sub

Private Sub Drive1_Change()
On Error GoTo Control
Dir1.Path = Drive1.Drive
Exit Sub
Control: MsgBox "Acceso Denegado", vbCritical + vbOKOnly, gsBac_Version: Drive1.Drive = "C"
End Sub


Private Sub Form_Load()
 Move 0, 0
 Me.Icon = BAC_INVERSIONES.Icon
 Screen.MousePointer = 0
 
 giAceptar% = False
 
 Drive1.Drive = "c:\"
 Txt_Ruta.Text = Ruta_Interfaces
 
 txtFecha1.Text = Format(gsBac_Fecp, "DD/MM/YYYY")

 
End Sub

Private Sub Label3_Click(Index As Integer)
  Checked(Index).Visible = Not Checked(Index).Visible
End Sub

Private Sub SinCheck_Click(Index As Integer)
  Checked(Index).Visible = True
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
'i = Len("BIE00123201300000010619952000000000000000000000000000010000020011127")
 
  Select Case Button.Index

    Case 1
        Call Gen_Interfaces(False)

        MsgBox "Interfaces Generadas en forma Correcta", vbInformation, gsBac_Version
    Case 2
'      Call Gen_Interfaces(True)
        MsgBox "Interfaces Generadas en forma Correcta", vbInformation, gsBac_Version

    Case 3
      Unload Me

  End Select

End Sub

Public Sub Gen_Interfaces(Sw_xls As Boolean)

'On Error GoTo Error

Dim Arr()
Dim Campos()
Dim Indice As Integer
Dim NombreArchivo As String
Dim Numero As Double
Dim p As Double
Dim Ind As Double    ' Para las distintas interfaces
Dim Linea As String  ' Para insertar línea de texto en el archivo
Dim Proc As String   ' Para el nombre del Sp
Dim Crea As Boolean
Dim crea_xls As Boolean
Dim ArchivoXls As String


Dim Exc     ' Crea la clase para objetos de Excel

Dim Hoja    ' Hoja Excel

Dim I As Integer
Dim Aux As String

Archivo_C14 = IIf(Chk_Ruta.Value, Ruta_Interfaces & "C14.txt", Dir1.Path & "C14.txt")
Archivo_C14_Xls = IIf(Chk_Ruta.Value, Ruta_Interfaces & "C14.xls", Dir1.Path & "C14.xls")
Archivo_C15 = IIf(Chk_Ruta.Value, Ruta_Interfaces & "C15.txt", Ruta_Local & "C15.txt")
Archivo_C15_Xls = IIf(Chk_Ruta.Value, Ruta_Interfaces & "C15.xls", Ruta_Local & "C15.xls")


Crea = False
crea_xls = False
Ruta_Local = IIf(Len(Dir1.Path) > 3, Dir1.Path & "\", Dir1.Path)
For Ind = 0 To Checked.Count - 1
If Checked(Ind).Visible Then
  Numero = 0
  CPrg = 0
  NombreArchivo = IIf(Chk_Ruta.Value, Ruta_Interfaces & Label3(Ind).Tag, Ruta_Local & Label3(Ind).Tag)    ' el tag contiene el nombre para el archivo plano
  Select Case Ind
    Case 0
      Proc = "sp_interfaz_0096"
      envia = Array(txtFecha1.Text)   ' Traspasar parametros para el sp
      
      If Not Sw_xls Then
      
      If Not Bac_Sql_Execute(Proc, envia) Then
         Screen.MousePointer = 0
         MsgBox "No se puede generar Interfaz '" & Label3(Ind).Tag & "'", vbCritical, gsBac_Version

      Else
         Screen.MousePointer = 11
         p = 1
         If Dir(NombreArchivo) <> "" Then
               Kill NombreArchivo
         End If
         Open NombreArchivo For Append As #1
         
         
         Do While Bac_SQL_Fetch(Arr())
'       If miSQL.SQL_Fetch(Arr()) <> 0 Then Screen.MousePointer = 0: Close #1: MsgBox "Falla fetch", vbCritical, gsBac_Version: Exit Sub
'       End If
        If Trim(Arr(1)) = "No hay Datos" Then MsgBox Trim(Arr(1)) & Chr(10) & "Revise Fecha                ", vbCritical, gsBac_Version: Screen.MousePointer = 0: Close #1: Exit Do
        If Trim(Arr(25)) = 0 Then
            Linea = ""                        'usar las funciones de str según especificaciones de interfaces     jlc
            Linea = Ceros(Trim(Arr(1)), 9) & Trim(Arr(1))
            Linea = Linea & Trim(Arr(2))
            Linea = Linea & Ceros(Trim(Arr(3)), 3) & Trim(Arr(3))
            Linea = Linea & Espacios(Trim(Arr(4)), 4) & Trim(Arr(4))
            Linea = Linea & Ceros(Trim(Arr(5)), 6) & Trim(Arr(5))
            Linea = Linea & Ceros(Trim(Arr(6)), 2) & Trim(Arr(6))
            Linea = Linea & Espacios(Trim(Arr(7)), 1) & Trim(Arr(7))
            Linea = Linea & Ceros(Trim(Arr(8)), 3) & Trim(Arr(8))
            Linea = Linea & Ceros(Trim(Arr(9)), 2) & Trim(Arr(9))
            Linea = Linea & Ceros(Trim(Arr(10)), 9) & Trim(Arr(10))
            Linea = Linea & Ceros(Trim(Arr(11)), 9) & Trim(Arr(11))
            Linea = Linea & Mid(Trim(Arr(12)), 1, 2) & Mid(Trim(Arr(12)), 4, 2) & Mid(Trim(Arr(12)), 9, 2)
            Linea = Linea & Mid(Trim(Arr(13)), 1, 2) & Mid(Trim(Arr(13)), 4, 2) & Mid(Trim(Arr(13)), 9, 2)
            Linea = Linea & Ceros(Trim(Arr(14)), 13) & Trim(Arr(14))
            Linea = Linea & Espacios(Trim(Arr(15)), 4) & Trim(Arr(15))
            Linea = Linea & Espacios(Trim(Arr(16)), 1) & Trim(Arr(16))
            Linea = Linea & Espacios(Trim(Arr(17)), 1) & Trim(Arr(17))
            Linea = Linea & Ceros(Trim(Arr(18)), 13) & Trim(Arr(18))
            Linea = Linea & Ceros(Trim(Arr(19)), 13) & Trim(Arr(19))
            Crea = True
            p = p + 1
            Print #1, Linea
            
         End If
         Loop
         Close #1
         Screen.MousePointer = 0
         If Crea Then   '***
            'MsgBox ("  INFORME " & Label3(Ind).Tag & " CREADO CON EXITO  "), vbInformation, gsBac_Version
            Call limpiar_cristal
        
            bactrader.BacRpt.Destination = 1
            bactrader.BacRpt.ReportFileName = RptList_Path & "cgdc.rpt"
            bactrader.BacRpt.StoredProcParam(0) = Format(txtFecha1.Text, "yyyy-mm-dd") & " 00:00:00.000"
            bactrader.BacRpt.Connect = CONECCION
            bactrader.BacRpt.Action = 1
            Crea = False
         Else
            MsgBox "Interfaz '" & Label3(Ind).Tag & "'" & Chr(10) & "No contiene datos", vbCritical, gsBac_Version
         End If
      End If
      
      End If
      
      If Sw_xls Then
      NombreArchivo = IIf(Chk_Ruta.Value, Ruta_Interfaces & "cgdc.xls", Ruta_Local & "cgdc.xls")
      If Dir(NombreArchivo) <> "" Then
        Kill NombreArchivo
      End If

      Set Exc = CreateObject("excel.application")
      Set Hoja = Exc.Application.workbooks.Add.sheets.Add
      Hoja.Name = Label3(Ind).Tag

'      Open NombreArchivo For Append As #1
      If Not Bac_Sql_Execute(Proc, envia) Then MsgBox "Error al generar interfaz " & Label3(Ind).Tag, vbCritical, gsBac_Version

      If Trae_Nom_Campos("interfaz_0096", Linea) Then
        For I = 1 To Len(Linea)
            If InStr(Linea, Chr(9)) > 1 Then Aux = Mid(Linea, 1, InStr(Linea, Chr(9)) - 1)
            Linea = Mid(Linea, InStr(Linea, Chr(9)) + 1)
            Hoja.Application.Visible = False
            Hoja.Cells(1, I).Value = Aux
            If Len(Linea) = 0 Then Exit For
        Next I
      ' Open NombreArchivo For Append As #1
      ' Print #1, Linea
      End If
      I = 2
      Do While Bac_SQL_Fetch(Arr())
      If Trim(Arr(1)) = "No hay Datos" Then MsgBox Trim(Arr(1)) & Chr(10), vbCritical, gsBac_Version: Screen.MousePointer = 0: Close #1: Exit Sub
        If Trim(Arr(25)) = 0 Then
            Hoja.Cells(I, 1).Value = BacStrTran(Trim(Arr(1)), ",", ".")
            Hoja.Cells(I, 2).Value = BacStrTran(Trim(Arr(2)), ",", ".")
            Hoja.Cells(I, 3).Value = BacStrTran(Trim(Arr(3)), ",", ".")
            Hoja.Cells(I, 4).Value = BacStrTran(Trim(Arr(4)), ",", ".")
            Hoja.Cells(I, 5).Value = BacStrTran(Trim(Arr(5)), ",", ".")
            Hoja.Cells(I, 6).Value = BacStrTran(Trim(Arr(6)), ",", ".")
            Hoja.Cells(I, 7).Value = BacStrTran(Trim(Arr(7)), ",", ".")
            Hoja.Cells(I, 8).Value = BacStrTran(Trim(Arr(8)), ",", ".")
            Hoja.Cells(I, 9).Value = BacStrTran(Trim(Arr(9)), ",", ".")
            Hoja.Cells(I, 10).Value = BacStrTran(Trim(Arr(10)), ",", ".")
            Hoja.Cells(I, 11).Value = BacStrTran(Trim(Arr(11)), ",", ".")
            Hoja.Cells(I, 12).Value = BacStrTran(Trim(Arr(12)), ",", ".")
            Hoja.Cells(I, 13).Value = BacStrTran(Trim(Arr(13)), ",", ".")
            Hoja.Cells(I, 14).Value = BacStrTran(Trim(Arr(14)), ",", ".")
            Hoja.Cells(I, 15).Value = BacStrTran(Trim(Arr(15)), ",", ".")
            Hoja.Cells(I, 16).Value = BacStrTran(Trim(Arr(16)), ",", ".")
            Hoja.Cells(I, 17).Value = BacStrTran(Trim(Arr(17)), ",", ".")
            Hoja.Cells(I, 18).Value = BacStrTran(Trim(Arr(18)), ",", ".")
            Hoja.Cells(I, 19).Value = BacStrTran(Trim(Arr(19)), ",", ".")
            crea_xls = True
            I = I + 1
       '     Print #1, Linea
            
         End If
      Loop
      Hoja.Application.DisplayAlerts = False
      For I = 2 To Hoja.Application.sheets.Count
        Hoja.Application.sheets(2).Delete
      Next I
      If crea_xls Then Hoja.SaveAs (NombreArchivo)
      Hoja.Application.workbooks.Close

      Set Hoja = Nothing
      Set Exc = Nothing

      'Close #1
      End If
'0  ok
    Checked(0).Visible = False '****
    Case 1
      
      ' Mensual control general creditos
      
      Dim nominter As String
      envia = Array()
      nominter = "Resi" + Mid(txtFecha1.Text, 9, 2) + Mid(txtFecha1.Text, 4, 2) + ".txt"
      Proc = "sp_invex_interfaz_control_gral_creditos"
      AddParam envia, txtFecha1.Text    ' Traspasar parametros para el sp
      NombreArchivo = IIf(Chk_Ruta.Value, Ruta_Interfaces & nominter, Ruta_Local & nominter)
      If Not Bac_Sql_Execute(Proc, envia) Then
         Screen.MousePointer = 0
         MsgBox "No se puede generar Interfaz '" & nominter & "'", vbCritical, gsBac_Version

      Else
         Screen.MousePointer = 11
         p = 1
         
         If Sw_xls Then
         
         NombreArchivo = IIf(Chk_Ruta.Value, Ruta_Interfaces & "Resi" & Mid(txtFecha1.Text, 9, 2) & Mid(txtFecha1.Text, 4, 2) & ".xls", Ruta_Local & "Resi" & Mid(txtFecha1.Text, 9, 2) & Mid(txtFecha1.Text, 4, 2) & ".xls")
         
         If Dir(NombreArchivo) <> "" Then Kill NombreArchivo
         
         Set Exc = CreateObject("excel.application")
         Set Hoja = Exc.Application.workbooks.Add.sheets.Add
         
         'asigno nombre a la hoja
         Hoja.Name = NombreHoja(NombreArchivo)
         
         If Trae_Nom_Campos("int0060", Linea, "sw") Then
            For I = 1 To Len(Linea)
                If InStr(Linea, Chr(9)) > 1 Then Aux = Mid(Linea, 1, InStr(Linea, Chr(9)) - 1)
                Linea = Mid(Linea, InStr(Linea, Chr(9)) + 1)
                Hoja.Cells(1, I).Value = Aux
                If Len(Linea) = 0 Then Exit For
            Next I
         End If
         
         If Not Bac_Sql_Execute(Proc, envia) Then MsgBox "Error al generar" & Mid(NombreArchivo, 4, 8), vbCritical, gsBac_Version
         I = 2
         Do While Bac_SQL_Fetch(Arr())
            
            If Trim(Arr(1)) = "Interfaz CGDC sin Datos" Then MsgBox Trim(Arr(1)) & Chr(10) & "Revise Fecha                ", vbCritical, gsBac_Version: Screen.MousePointer = 0: Close #1
         
            Linea = ""
            If Trim(Arr(42)) = 0 Then
                Hoja.Cells(I, 1).Value = BacStrTran(Trim(Arr(1)), ",", ".")
                Hoja.Cells(I, 2).Value = BacStrTran(Trim(Arr(2)), ",", ".")
                Hoja.Cells(I, 3).Value = BacStrTran(Trim(Arr(3)), ",", ".")
                Hoja.Cells(I, 4).Value = BacStrTran(Trim(Arr(4)), ",", ".")
                Hoja.Cells(I, 5).Value = BacStrTran(Trim(Arr(5)), ",", ".")
                Hoja.Cells(I, 6).Value = BacStrTran(Trim(Arr(6)), ",", ".")
                Hoja.Cells(I, 7).Value = BacStrTran(Trim(Arr(7)), ",", ".")
                Hoja.Cells(I, 8).Value = BacStrTran(Trim(Arr(8)), ",", ".")
                Hoja.Cells(I, 9).Value = BacStrTran(Trim(Arr(9)), ",", ".")
                Hoja.Cells(I, 10).Value = BacStrTran(Trim(Arr(10)), ",", ".")
                Hoja.Cells(I, 11).Value = BacStrTran(Trim(Arr(11)), ",", ".")
                Hoja.Cells(I, 12).Value = BacStrTran(Trim(Arr(12)), ",", ".")
                Hoja.Cells(I, 13).Value = BacStrTran(Trim(Arr(13)), ",", ".")
                Hoja.Cells(I, 14).Value = BacStrTran(Trim(Arr(14)), ",", ".")
                Hoja.Cells(I, 15).Value = BacStrTran(Trim(Arr(15)), ",", ".")
                Hoja.Cells(I, 16).Value = BacStrTran(Trim(Arr(16)), ",", ".")
                Hoja.Cells(I, 17).Value = BacStrTran(Trim(Arr(17)), ",", ".")
                Hoja.Cells(I, 18).Value = BacStrTran(Trim(Arr(18)), ",", ".")
                Hoja.Cells(I, 19).Value = BacStrTran(Trim(Arr(19)), ",", ".")
                Hoja.Cells(I, 20).Value = BacStrTran(Trim(Arr(20)), ",", ".")
                Hoja.Cells(I, 21).Value = BacStrTran(Trim(Arr(21)), ",", ".")
                Hoja.Cells(I, 22).Value = BacStrTran(Trim(Arr(22)), ",", ".")
                Hoja.Cells(I, 23).Value = BacStrTran(Trim(Arr(23)), ",", ".")
                Hoja.Cells(I, 24).Value = BacStrTran(Trim(Arr(24)), ",", ".")
                Hoja.Cells(I, 25).Value = BacStrTran(Trim(Arr(25)), ",", ".")
                Hoja.Cells(I, 26).Value = BacStrTran(Trim(Arr(26)), ",", ".")
                Hoja.Cells(I, 27).Value = BacStrTran(Trim(Arr(27)), ",", ".")
                Hoja.Cells(I, 28).Value = BacStrTran(Trim(Arr(28)), ",", ".")
                Hoja.Cells(I, 29).Value = BacStrTran(Trim(Arr(29)), ",", ".")
                Hoja.Cells(I, 30).Value = BacStrTran(Trim(Arr(30)), ",", ".")
                Hoja.Cells(I, 31).Value = BacStrTran(Trim(Arr(31)), ",", ".")
                Hoja.Cells(I, 32).Value = BacStrTran(Trim(Arr(32)), ",", ".")
                Hoja.Cells(I, 33).Value = BacStrTran(Trim(Arr(33)), ",", ".")
                Hoja.Cells(I, 34).Value = BacStrTran(Trim(Arr(34)), ",", ".")
                Hoja.Cells(I, 35).Value = BacStrTran(Trim(Arr(35)), ",", ".")
                Hoja.Cells(I, 36).Value = BacStrTran(Trim(Arr(36)), ",", ".")
                Hoja.Cells(I, 37).Value = BacStrTran(Trim(Arr(37)), ",", ".")
                Hoja.Cells(I, 38).Value = BacStrTran(Trim(Arr(38)), ",", ".")
                Hoja.Cells(I, 39).Value = BacStrTran(Trim(Arr(39)), ",", ".")
                Hoja.Cells(I, 40).Value = BacStrTran(Trim(Arr(40)), ",", ".")
                Hoja.Cells(I, 41).Value = BacStrTran(Trim(Arr(41)), ",", ".")
'                Linea = Linea & Trim(Arr(1)) & Chr(9)
                I = I + 1
                crea_xls = True
'                Print #1, Linea

            End If
            
         Loop
         Hoja.Application.DisplayAlerts = False
         For I = 2 To Hoja.Application.sheets.Count
            Hoja.Application.sheets(2).Delete
         Next I
         If crea_xls Then Hoja.SaveAs (NombreArchivo)
         Hoja.Application.workbooks.Close

         
         Set Hoja = Nothing
         Set Exc = Nothing
         
 '        Close #1
         Screen.MousePointer = 0
         'If crea_xls = True Then
         '  MsgBox "Archivo " & "Resi" + Mid(txtFecha1.Text, 9, 2) + Mid(txtFecha1.Text, 4, 2) + ".xls" & " creado con exito", vbInformation, gsBac_Version
         'Else
         '    MsgBox "Error al crear Archivo " & Mid(NombreArchivo, 4, 8), vbCritical, gsBac_Version
         'End If
         
         
         End If
         
         If Dir(NombreArchivo) <> "" Then
               Kill NombreArchivo
         End If
         Open NombreArchivo For Append As #1
         Do While Bac_SQL_Fetch(Arr())
         If Trim(Arr(1)) = "no hay datos" Then MsgBox Trim(Arr(1)) & Chr(10) & "Revise Fecha                ", vbCritical, gsBac_Version: Screen.MousePointer = 0: Close #1: Exit Sub
         
            Linea = ""                        'usar las funciones de str según especificaciones de interfaces     jlc
            If Trim(Arr(42)) = 0 Then
            Linea = Ceros(Trim(Arr(1)), 9) & Trim(Arr(1))
            Linea = Linea & Trim(Arr(2))
            Linea = Linea & Ceros(Trim(Arr(3)), 3) & Trim(Arr(3))
            Linea = Linea & Ceros(Trim(Arr(4)), 3) & Trim(Arr(4))
            Linea = Linea & Espacios(Trim(Arr(5)), 4) & Trim(Arr(5))
            Linea = Linea & Ceros(Trim(Arr(6)), 6) & Trim(Arr(6))
            Linea = Linea & Espacios(Trim(Arr(7)), 14) & Trim(Arr(7))
            Linea = Linea & Trim(Arr(8))
            Linea = Linea & Ceros(Trim(Arr(9)), 4) & Trim(Arr(9))
            Linea = Linea & Trim(Arr(10))
            Linea = Linea & Trim(Arr(11))
            Linea = Linea & Mid(Trim(Arr(12)), 1, 2) & Mid(Trim(Arr(12)), 4, 2) & Mid(Trim(Arr(12)), 9, 2)
            Linea = Linea & Ceros(Trim(Arr(13)), 15) & Trim(Arr(13))
            Linea = Linea & Ceros(Trim(Arr(14)), 3) & Trim(Arr(14))
            paso = Mid(Trim(Arr(15)), 1, 1) & Mid(Trim(Arr(15)), 3, 4)
            paso = "00" & paso
            Linea = Linea & paso
            Linea = Linea & Mid(Trim(Arr(16)), 1, 2) & Mid(Trim(Arr(16)), 4, 2) & Mid(Trim(Arr(16)), 9, 2)
            Linea = Linea & Ceros(Trim(Arr(17)), 6) & Trim(Arr(17))
            Linea = Linea & Mid(Trim(Arr(18)), 1, 2) & Mid(Trim(Arr(18)), 4, 2) & Mid(Trim(Arr(18)), 9, 2)
            Linea = Linea & Ceros(Trim(Arr(19)), 13) & Trim(Arr(19))
            Linea = Linea & Ceros(Trim(Arr(20)), 4) & Trim(Arr(20))
            Linea = Linea & Ceros(Trim(Arr(21)), 3) & Trim(Arr(21))
            Linea = Linea & Ceros(Trim(Arr(22)), 3) & Trim(Arr(22))
            Linea = Linea & Ceros(Trim(Arr(23)), 15) & Trim(Arr(23))
            Linea = Linea & Trim(Arr(24))
            Linea = Linea & Ceros(Trim(Arr(25)), 15) & Trim(Arr(25))
            Linea = Linea & Ceros(Trim(Arr(26)), 15) & Trim(Arr(26))
            Linea = Linea & Ceros(Trim(Arr(27)), 15) & Trim(Arr(27))
            Linea = Linea & Ceros(Trim(Arr(28)), 15) & Trim(Arr(28))
            Linea = Linea & Ceros(Trim(Arr(29)), 13) & Trim(Arr(29))
            Linea = Linea & Ceros(Trim(Arr(30)), 13) & Trim(Arr(30))
            Linea = Linea & Ceros(Trim(Arr(31)), 13) & Trim(Arr(31))
            Linea = Linea & Ceros(Trim(Arr(32)), 13) & Trim(Arr(32))
            Linea = Linea & Ceros(Trim(Arr(33)), 13) & Trim(Arr(33))
            Linea = Linea & Ceros(Trim(Arr(34)), 13) & Trim(Arr(34))
            Linea = Linea & Ceros(Trim(Arr(35)), 13) & Trim(Arr(35))
            Linea = Linea & Ceros(Trim(Arr(36)), 13) & Trim(Arr(36))
            Linea = Linea & Ceros(Trim(Arr(37)), 13) & Trim(Arr(37))
            Linea = Linea & Ceros(Trim(Arr(38)), 9) & Trim(Arr(38))
            Linea = Linea & Ceros(Trim(Arr(39)), 9) & Trim(Arr(39))
            Linea = Linea & Ceros(Trim(Arr(40)), 9) & Trim(Arr(40))
            Linea = Linea & Espacios(Trim(Arr(41)), 9) & Trim(Arr(41))
            p = p + 1
            Crea = True
            Print #1, Linea

            End If
            
                
         Loop
         Close #1
         Screen.MousePointer = 0
         If Crea Then
            'MsgBox ("  INFORME " & nominter & " CREADO CON EXITO  "), vbInformation, gsBac_Version
            Call limpiar_cristal
            BAC_INVERSIONES.BacRpt.Destination = 1
            BAC_INVERSIONES.BacRpt.ReportFileName = RptList_Path & "interfaz_0060.rpt"
            BAC_INVERSIONES.BacRpt.StoredProcParam(0) = Format(txtFecha1.Text, "yyyy-mm-dd") & " 00:00:00.000"
            BAC_INVERSIONES.BacRpt.Connect = CONECCION
            BAC_INVERSIONES.BacRpt.Action = 1
            Crea = False
         Else
            MsgBox "Interfaz '" & nominter & "'" & Chr(10) & "No contiene datos", vbCritical, gsBac_Version
         End If
      End If
      Checked(1).Visible = False
    Case 2
      
      ' Mensual por plazos residuales
      
      
      Proc = "sp_interfaz_0070"
      envia = Array(txtFecha1.Text)    ' Traspasar parametros para el sp
      
      If Sw_xls Then
      
      p = 1
      NombreArchivo = IIf(Chk_Ruta.Value, Ruta_Interfaces & "mddsalre.xls", Ruta_Local & "mddsalre.xls")
      
      If Dir(NombreArchivo) <> "" Then
               Kill NombreArchivo
      End If
      
      Set Exc = CreateObject("excel.application")
      Set Hoja = Exc.Application.workbooks.Add.sheets.Add
      Hoja.Name = "mddsalre"

      If Trae_Nom_Campos("interfaz_0070", Linea) Then
        For I = 1 To Len(Linea)
            If InStr(Linea, Chr(9)) > 1 Then Aux = Mid(Linea, 1, InStr(Linea, Chr(9)) - 1)
            Linea = Mid(Linea, InStr(Linea, Chr(9)) + 1)
            Hoja.Cells(I, S).Value = Aux
            If Len(Linea) = 0 Then Exit For
        Next I
      End If
      
         If Not Bac_Sql_Execute(Proc, envia) Then MsgBox "Error al generar archivo " & NombreArchivo, vbCritical, gsBac_Version: Exit Sub
         I = 2
         Do While Bac_SQL_Fetch(Arr())
           If Trim(Arr(1)) = "No hay Datos" Then MsgBox Trim(Arr(1)) & Chr(10) & "Revise Fecha                ", vbCritical, gsBac_Version: Screen.MousePointer = 0: Close #1: Exit Sub
            Hoja.Cells(I, 1).Value = BacStrTran(Trim(Arr(1)), ",", ".")
            Hoja.Cells(I, 2).Value = BacStrTran(Trim(Arr(2)), ",", ".")
            Hoja.Cells(I, 3).Value = BacStrTran(Trim(Arr(3)), ",", ".")
            Hoja.Cells(I, 4).Value = BacStrTran(Trim(Arr(4)), ",", ".")
            Hoja.Cells(I, 5).Value = BacStrTran(Trim(Arr(5)), ",", ".")
            Hoja.Cells(I, 6).Value = BacStrTran(Trim(Arr(6)), ",", ".")
            Hoja.Cells(I, 7).Value = BacStrTran(Trim(Arr(7)), ",", ".")
            Hoja.Cells(I, 8).Value = BacStrTran(Trim(Arr(8)), ",", ".")
            Hoja.Cells(I, 9).Value = BacStrTran(Trim(Arr(9)), ",", ".")
            Hoja.Cells(I, 10).Value = BacStrTran(Trim(Arr(10)), ",", ".")
            Hoja.Cells(I, 11).Value = BacStrTran(Trim(Arr(11)), ",", ".")
            Hoja.Cells(I, 12).Value = BacStrTran(Trim(Arr(12)), ",", ".")
            Hoja.Cells(I, 13).Value = BacStrTran(Trim(Arr(13)), ",", ".")
            Hoja.Cells(I, 14).Value = BacStrTran(Trim(Arr(14)), ",", ".")
            Hoja.Cells(I, 15).Value = BacStrTran(Trim(Arr(15)), ",", ".")
            Hoja.Cells(I, 16).Value = BacStrTran(Trim(Arr(16)), ",", ".")
'           Linea = Linea & Trim(Arr(10)) & Chr(9)
'           If IsNull(Arr(11)) Then Arr(11) = 0
'           Linea = Linea & Trim(Arr(11)) & Chr(9)
'           Linea = Linea & Trim(Arr(11))
            crea_xls = True
            I = I + 1
'           Print #1, Linea

         Loop
'         Close #1
         Hoja.Application.DisplayAlerts = False
         For I = 2 To Hoja.Application.sheets.Count
            Hoja.Application.sheets(2).Delete
         Next I
         If crea_xls Then Hoja.SaveAs (NombreArchivo)
         Hoja.Application.workbooks.Close

         Set Hoja = Nothing
         Set Exc = Nothing
         
         Screen.MousePointer = 0
            'If crea_xls Then
            ' MsgBox "Archivo " & NombreArchivo & " Creado con exito", vbInformation, gsBac_Version
            ' Else
            ' MsgBox "Error al crear Archivo " & NombreArchivo, vbInformation, gsBac_Version
            'End If
         
      End If
      
      
      If Not Sw_xls Then
      
      NombreArchivo = IIf(Chk_Ruta.Value, Ruta_Interfaces & "mddsalre.txt", Ruta_Local & "mddsalre.txt")
      Label3(Ind).Tag = "mddsalre.txt"
      
      If Not Bac_Sql_Execute(Proc, envia) Then
         Screen.MousePointer = 0
         MsgBox "No se puede generar Interfaz '" & Label3(Ind).Tag & "'", vbCritical, gsBac_Version
      Else
         Screen.MousePointer = 11
         p = 1
         If Dir(NombreArchivo) <> "" Then
               Kill NombreArchivo
         End If
         Open NombreArchivo For Append As #1
         Do While Bac_SQL_Fetch(Arr())
           If Trim(Arr(1)) = "No hay Datos" Then MsgBox Trim(Arr(1)) & Chr(10) & "Revise Fecha                ", vbCritical, gsBac_Version: Screen.MousePointer = 0: Close #1: Exit Sub
            Linea = ""                        'usar las funciones de str según especificaciones de interfaces     jlc
            Linea = Ceros(Trim(Arr(1)), 9) & Trim(Arr(1))
            Linea = Linea & Trim(Arr(2))
            Linea = Linea & Ceros(Trim(Arr(3)), 3) & Trim(Arr(3))
            Linea = Linea & Ceros(Trim(Arr(4)), 3) & Trim(Arr(4))
            Linea = Linea & Trim(Arr(5))
            Linea = Linea & Ceros(Trim(Arr(6)), 6) & Trim(Arr(6))
            Linea = Linea & Ceros(Trim(Arr(7)), 3) & Trim(Arr(7))
            Linea = Linea & Trim(Arr(8))
            If IsNull(Arr(9)) Then Arr(9) = 0
            Linea = Linea & Ceros(Trim(Arr(9)), 4) & Trim(Arr(9))
            Linea = Linea & Trim(Arr(10))
            If IsNull(Arr(11)) Then Arr(11) = 0
            Linea = Linea & Ceros(Trim(Arr(11)), 15) & Trim(Arr(11))
            Linea = Linea & Ceros(Trim(Arr(11)), 15) & Trim(Arr(11))
            Linea = Linea & Ceros(Trim(Arr(11)), 15) & Trim(Arr(11))
            Linea = Linea & Ceros(Trim(Arr(11)), 15) & Trim(Arr(11))
            Linea = Linea & Ceros(Trim(Arr(11)), 15) & Trim(Arr(11))
            Linea = Linea & Ceros(Trim(Arr(11)), 15) & Trim(Arr(11))
            Linea = Linea & Ceros(Trim(Arr(11)), 15) & Trim(Arr(11))
            Crea = True
            p = p + 1
            Print #1, Linea

         Loop
         
         Close #1
         Screen.MousePointer = 0
         
         If Crea Then
            'MsgBox ("  INFORME " & Label3(Ind).Tag & " CREADO CON EXITO  "), vbInformation, gsBac_Version
            Call limpiar_cristal
        
            bactrader.BacRpt.Destination = 1
            bactrader.BacRpt.ReportFileName = RptList_Path & "resiaamm.rpt"
            bactrader.BacRpt.StoredProcParam(0) = Format(txtFecha1.Text, "yyyy-mm-dd") & " 00:00:00.000"
            bactrader.BacRpt.Connect = CONECCION
            bactrader.BacRpt.Action = 1
            Crea = False
         Else
            MsgBox "Interfaz '" & Label3(Ind).Tag & "'" & Chr(10) & "No contiene datos", vbCritical, gsBac_Version
         End If
      End If
      End If
      
    Checked(2).Visible = False
    
    Case 3
        Call Interfaz_c08_c09(Sw_xls)
      
     
    Case 4
      
      'C14 y C15
      
      Proc = "sp_interfaz_c14"
      
      Archivo_C14 = IIf(Chk_Ruta.Value, Ruta_Interfaces & "C14.txt", Dir1.Path & "C14.txt")
      Archivo_C14_Xls = IIf(Chk_Ruta.Value, Ruta_Interfaces & "C14.xls", Dir1.Path & "C14.xls")
      Archivo_C15 = IIf(Chk_Ruta.Value, Ruta_Interfaces & "C15.txt", Ruta_Local & "C15.txt")
      Archivo_C15_Xls = IIf(Chk_Ruta.Value, Ruta_Interfaces & "C15.xls", Ruta_Local & "C15.xls")
      
      envia = Array(txtFecha1.Text)   ' Traspasar parametros para el sp
      
      If Not Bac_Sql_Execute(Proc, envia) Then
         Screen.MousePointer = 0
         MsgBox "No se puede generar Interfaz C14", vbCritical, gsBac_Version
    
      Else
         Screen.MousePointer = 11
      End If
         If Sw_xls Then
           If Dir(Archivo_C14_Xls) <> "" Then
             Kill Archivo_C14_Xls
           End If
           
           Set Exc = CreateObject("excel.application")
           Set Hoja = Exc.Application.workbooks.Add.sheets.Add
           Hoja.Name = Mid(NombreArchivo, 4, 8)
      
           If Trae_Nom_Campos("intc14", Linea, "filler") Then
              For I = 1 To Len(Linea)
                If InStr(Linea, Chr(9)) > 1 Then Aux = Mid(Linea, 1, InStr(Linea, Chr(9)) - 1)
                Linea = Mid(Linea, InStr(Linea, Chr(9)) + 1)
                Hoja.Cells(1, I).Value = Aux
                If Len(Linea) = 0 Then Exit For
              Next I
           End If
           I = 2
           If Bac_Sql_Execute(Proc, envia) Then Archivo_C14 = Archivo_C14
                  Do While Bac_SQL_Fetch(Arr())
                   If Trim(Arr(1)) = "No Hay Datos" Then MsgBox Trim(Arr(1)) & Chr(10) & "Revise Fecha                ", vbCritical, gsBac_Version: Screen.MousePointer = 0: Close #2: Exit Sub
                   If Trim(Arr(16)) = "Interfaz" Then
                   Hoja.Cells(I, 1).Value = BacStrTran(Trim(Arr(1)), ",", ".")
                   Hoja.Cells(I, 2).Value = BacStrTran(Trim(Arr(2)), ",", ".")
                   Hoja.Cells(I, 3).Value = BacStrTran(Trim(Arr(3)), ",", ".")
                   Hoja.Cells(I, 4).Value = BacStrTran(Trim(Arr(4)), ",", ".")
                   Hoja.Cells(I, 5).Value = BacStrTran(Trim(Arr(5)), ",", ".")
                   Hoja.Cells(I, 6).Value = BacStrTran(Trim(Arr(6)), ",", ".")
                   Hoja.Cells(I, 7).Value = BacStrTran(Trim(Arr(7)), ",", ".")
                   Hoja.Cells(I, 8).Value = BacStrTran(Trim(Arr(8)), ",", ".")
                   Hoja.Cells(I, 9).Value = BacStrTran(Trim(Arr(9)), ",", ".")
                   Hoja.Cells(I, 10).Value = BacStrTran(Trim(Arr(10)), ",", ".")
                   Hoja.Cells(I, 11).Value = BacStrTran(Trim(Arr(11)), ",", ".")
                   Hoja.Cells(I, 12).Value = BacStrTran(Trim(Arr(12)), ",", ".")
                   Hoja.Cells(I, 13).Value = BacStrTran(Trim(Arr(13)), ",", ".")
                   Hoja.Cells(I, 15).Value = BacStrTran(Trim(Arr(15)), ",", ".")
'                  Linea = Linea & Trim(Arr(15)) & Chr(9)
                  crea_xls = True
                  I = I + 1
'                  Print #1, Linea

                  End If
                  Loop
           
        Else
        
        Crea = interfaz_c14(Archivo_C14)
        
        End If
        
        If Sw_xls Then
               
            Hoja.Application.DisplayAlerts = False
            For I = 2 To Hoja.Application.sheets.Count
            
                Hoja.Application.sheets(2).Delete
            Next I
            
            If crea_xls Then Hoja.SaveAs (Archivo_C14_Xls)
        
            Hoja.Application.workbooks.Close

            Set Hoja = Nothing
            Set Exc = Nothing
        End If
'        Close #1
        
        'If crea_xls = True Then MsgBox "Archivo C14.xls creado con exito", vbInformation, gsBac_Version: Screen.MousePointer = 0
                
        If Crea Then   '***
            'MsgBox ("  Interfaz C14 CREADA CON EXITO  "), vbInformation, gsBac_Version
            Call limpiar_cristal
        
            BAC_INVERSIONES.BacRpt.Destination = 1
            BAC_INVERSIONES.BacRpt.ReportFileName = RptList_Path & "interfaz c14.rpt"
            'BacTrader.bacrpt.StoredProcParam(0) = Format(txtFecha1.Text, "yyyy-mm-dd") & " 00:00:00.000"
            BAC_INVERSIONES.BacRpt.Connect = CONECCION
            BAC_INVERSIONES.BacRpt.Action = 1
            
        Else
            If Not Sw_xls Then
               ' MsgBox "Interfaz C14" & Chr(10) & "No contiene datos", vbCritical, gsBac_Version
            End If
        End If
      
         'inicio interfaz C15
    Proc = "sp_interfaz_c15"
    envia = Array(txtFecha1.Text, 2)  ' Traspasar parametros para el sp
    If Not Bac_Sql_Execute(Proc, envia) Then
      Screen.MousePointer = 0
      MsgBox "No se puede generar Interfaz C15", vbCritical, gsBac_Version
    Else
      Screen.MousePointer = 11
      p = 1
    If Sw_xls Then
      If Dir(Archivo_C15_Xls) <> "" Then
        Kill Archivo_C15_Xls
      End If
      Set Exc = CreateObject("excel.application")
      Set Hoja = Exc.Application.workbooks.Add.sheets.Add
      Hoja.Name = Mid(NombreArchivo, 4, 8)
      
      If Trae_Nom_Campos("interfaz_c15", Linea, "titulo") Then
        For I = 1 To Len(Linea)
            If InStr(Linea, Chr(9)) > 1 Then Aux = Mid(Linea, 1, InStr(Linea, Chr(9)) - 1)
            Linea = Mid(Linea, InStr(Linea, Chr(9)) + 1)
            Hoja.Cells(1, I).Value = Aux
            If Len(Linea) = 0 Then Exit For
        Next I
      End If
      envia = Array(txtFecha1.Text, 2)
      If Bac_Sql_Execute(Proc, envia) Then Archivo_C15 = Archivo_C15
      I = 2
      Do While Bac_SQL_Fetch(Arr())
        If Trim(Arr(1)) = "No Hay Datos" Then MsgBox Trim(Arr(1)) & Chr(10) & "Revise Fecha                ", vbCritical, gsBac_Version: Screen.MousePointer = 0: Close #2: Exit Sub
        Hoja.Cells(I, 1).Value = BacStrTran(Trim(Arr(1)), ",", ".")
        Hoja.Cells(I, 2).Value = BacStrTran(Trim(Arr(2)), ",", ".")
        Hoja.Cells(I, 3).Value = BacStrTran(Trim(Arr(3)), ",", ".")
        Hoja.Cells(I, 4).Value = BacStrTran(Trim(Arr(4)), ",", ".")
        Hoja.Cells(I, 5).Value = BacStrTran(Trim(Arr(5)), ",", ".")
        Hoja.Cells(I, 6).Value = BacStrTran(Trim(Arr(6)), ",", ".")
        Hoja.Cells(I, 7).Value = BacStrTran(Trim(Arr(7)), ",", ".")
        Hoja.Cells(I, 8).Value = BacStrTran(Trim(Arr(8)), ",", ".")
        Hoja.Cells(I, 9).Value = BacStrTran(Trim(Arr(9)), ",", ".")
        Hoja.Cells(I, 10).Value = BacStrTran(Trim(Arr(10)), ",", ".")
        Hoja.Cells(I, 11).Value = BacStrTran(Trim(Arr(11)), ",", ".")
        Hoja.Cells(I, 12).Value = BacStrTran(Trim(Arr(12)), ",", ".")
        Hoja.Cells(I, 13).Value = BacStrTran(Trim(Arr(13)), ",", ".")
        Hoja.Cells(I, 14).Value = BacStrTran(Trim(Arr(14)), ",", ".")
'        Linea = Linea & Trim(Arr(14))
        Crea = True
        I = I + 1
'        Print #2, Linea

      Loop
      
      Hoja.Application.DisplayAlerts = False
      For I = 2 To Hoja.Application.sheets.Count
        Hoja.Application.sheets(2).Delete
      Next I
      Hoja.SaveAs (Archivo_C15_Xls)
      Hoja.Application.workbooks.Close

      Set Hoja = Nothing
      Set Exc = Nothing

'      Close #2
    End If
      
      Screen.MousePointer = 11
    If Not Sw_xls Then
      p = 1
      If Dir(Archivo_C15) <> "" Then
        Kill Archivo_C15
      End If
      envia = Array(txtFecha1.Text, 2)
      If Bac_Sql_Execute(Proc, envia) Then Archivo_C15 = Archivo_C15
      Open Archivo_C15 For Append As #1
      Do While Bac_SQL_Fetch(Arr())
        If Trim(Arr(1)) = "No Hay Datos" Then MsgBox Trim(Arr(1)) & Chr(10) & "Revise Fecha                ", vbCritical, gsBac_Version: Screen.MousePointer = 0: Close #2: Exit Sub
        Linea = ""                        'usar las funciones de str según especificaciones de interfaces     jlc
        Linea = Linea & Ceros(Trim(Arr(2)), 1) & Trim(Arr(2))
        Linea = Linea & Ceros(Trim(Arr(3)), 3) & Trim(Arr(3))
        Linea = Linea & Ceros(Trim(Arr(4)), 1) & Trim(Arr(4))
        Linea = Linea & Ceros(Trim(Arr(5)), 1) & Trim(Arr(5))
        Linea = Linea & Ceros(Trim(Arr(6)), 14) & Trim(Arr(6))
        Linea = Linea & Ceros(Trim(Arr(7)), 14) & Trim(Arr(7))
        Linea = Linea & Ceros(Trim(Arr(8)), 14) & Trim(Arr(8))
        Linea = Linea & Ceros(Trim(Arr(9)), 14) & Trim(Arr(9))
        Linea = Linea & Ceros(Trim(Arr(10)), 14) & Trim(Arr(10))
        Linea = Linea & Ceros(Trim(Arr(11)), 14) & Trim(Arr(11))
        Linea = Linea & Ceros(Trim(Arr(12)), 14) & Trim(Arr(12))
        Linea = Linea & Ceros(Trim(Arr(13)), 14) & Trim(Arr(13))
        Linea = Linea & Ceros(Trim(Arr(14)), 14) & Trim(Arr(14))
        Crea = True
        p = p + 1
        Print #1, Linea

      Loop
      Close #1
      Screen.MousePointer = 0
    End If
      If Crea Then   '***
        'If Sw_xls Then MsgBox " Planilla de Interfaz C15 Generada ", vbInformation, gsBac_Version
        If Not Sw_xls Then
           ' MsgBox ("  Interfaz C15 CREADA CON EXITO  "), vbInformation, gsBac_Version
            Call limpiar_cristal
            BAC_INVERSIONES.BacRpt.Destination = 1
            BAC_INVERSIONES.BacRpt.ReportFileName = RptList_Path & "interfaz_c15.rpt"
            BAC_INVERSIONES.BacRpt.StoredProcParam(0) = Format(txtFecha1.Text, "yyyy-mm-dd") & " 00:00:00.000"
            BAC_INVERSIONES.BacRpt.StoredProcParam(1) = 1
            BAC_INVERSIONES.BacRpt.Connect = CONECCION
            BAC_INVERSIONES.BacRpt.Action = 1
        End If
        Crea = False
      Else
        MsgBox "Interfaz C15" & Chr(10) & "No contiene datos", vbCritical, gsBac_Version
      End If
    
         
         




  End If
   Checked(4).Visible = False
    Case 5
      
 'D30
 
      Proc = "sp_interfaz_d31"
      envia = Array(txtFecha1.Text, gsBac_Fecx)   ' Traspasar parametros para el sp
      
    
      
      If Not Bac_Sql_Execute(Proc, envia) Then
         Screen.MousePointer = 0
         MsgBox "No se puede generar Interfaz '" & Label3(Ind).Tag & "'", vbCritical, gsBac_Version

      Else
         If Dir(NombreArchivo) <> "" Then
               Kill NombreArchivo
         End If
        
         If Sw_xls Then
            NombreArchivo = Ruta_Local & "pmddd30.xls"
            If Dir(NombreArchivo) <> "" Then
                Kill NombreArchivo
            End If
                
            Set Exc = CreateObject("excel.application")
            Set Hoja = Exc.Application.workbooks.Add.sheets.Add
'            Hoja.Name =
            
'            Open NombreArchivo For Append As #1
            
               
            If Trae_Nom_Campos("intd30", Linea, "filler") Then
                For I = 1 To Len(Linea)
                    If InStr(Linea, Chr(9)) > 1 Then Aux = Mid(Linea, 1, InStr(Linea, Chr(9)) - 1)
                    Linea = Mid(Linea, InStr(Linea, Chr(9)) + 1)
                    Hoja.Cells(1, I).Value = Aux
                    If Len(Linea) = 0 Then Exit For
                Next I
            End If
            If Bac_Sql_Execute(Proc, envia) Then Crea = False
            I = 2
            Do While Bac_SQL_Fetch(Arr())
                If Trim(Arr(1)) = "no hay datos" Then MsgBox Trim(Arr(1)) & Chr(10) & "Revise Fecha                ", vbCritical, gsBac_Version: Screen.MousePointer = 0: Close #1: Exit Sub
                Hoja.Cells(I, 1).Value = BacStrTran(Trim(Arr(1)), ",", ".")
                Hoja.Cells(I, 2).Value = BacStrTran(Trim(Arr(2)), ",", ".")
                Hoja.Cells(I, 3).Value = BacStrTran(Trim(Arr(3)), ",", ".")
                Hoja.Cells(I, 4).Value = BacStrTran(Trim(Arr(4)), ",", ".")
                Hoja.Cells(I, 5).Value = BacStrTran(Trim(Arr(5)), ",", ".")
                Hoja.Cells(I, 6).Value = BacStrTran(Trim(Arr(6)), ",", ".")
                Hoja.Cells(I, 7).Value = BacStrTran(Trim(Arr(7)), ",", ".")
                Hoja.Cells(I, 8).Value = BacStrTran(Trim(Arr(8)), ",", ".")
                Hoja.Cells(I, 9).Value = BacStrTran(Trim(Arr(9)), ",", ".")
                Hoja.Cells(I, 10).Value = BacStrTran(Trim(Arr(10)), ",", ".")
                Hoja.Cells(I, 11).Value = BacStrTran(Trim(Arr(11)), ",", ".")
                Hoja.Cells(I, 12).Value = BacStrTran(Trim(Arr(12)), ",", ".")
                Hoja.Cells(I, 13).Value = BacStrTran(Trim(Arr(13)), ",", ".")
                Hoja.Cells(I, 14).Value = BacStrTran(Trim(Arr(14)), ",", ".")
                Hoja.Cells(I, 15).Value = BacStrTran(Trim(Arr(15)), ",", ".")
                Hoja.Cells(I, 16).Value = BacStrTran(Trim(Arr(16)), ",", ".")
                Hoja.Cells(I, 17).Value = BacStrTran(Trim(Arr(17)), ",", ".")
                Hoja.Cells(I, 18).Value = BacStrTran(Trim(Arr(18)), ",", ".")
                Hoja.Cells(I, 19).Value = BacStrTran(Trim(Arr(19)), ",", ".")
                Hoja.Cells(I, 20).Value = BacStrTran(Trim(Arr(20)), ",", ".")
                Hoja.Cells(I, 21).Value = BacStrTran(Trim(Arr(21)), ",", ".")
                Hoja.Cells(I, 22).Value = BacStrTran(Trim(Arr(22)), ",", ".")
                Hoja.Cells(I, 23).Value = BacStrTran(Trim(Arr(23)), ",", ".")
                Hoja.Cells(I, 24).Value = BacStrTran(Trim(Arr(24)), ",", ".")
                Hoja.Cells(I, 25).Value = BacStrTran(Trim(Arr(25)), ",", ".")
                Hoja.Cells(I, 26).Value = BacStrTran(Trim(Arr(26)), ",", ".")
                Hoja.Cells(I, 27).Value = BacStrTran(Trim(Arr(27)), ",", ".")
                I = I + 1
                Crea = True

            Loop
            Hoja.Application.DisplayAlerts = False
            For I = 2 To Hoja.Application.sheets.Count
                Hoja.Application.sheets(2).Delete
            Next I
            Hoja.Name = "INTD30"
             If Crea Then Hoja.SaveAs (NombreArchivo)
            Hoja.Application.workbooks.Close

            Set Hoja = Nothing
            Set Exc = Nothing
            
          '  If Crea Then
          '      MsgBox "Archivo pmddd30.xls creado con exito", vbInformation, gsBac_Version
          '  Else
          '      MsgBox "Error al generar archivo pmddd30.xls", vbCritical, gsBac_Version
          '  End If
          
            Screen.MousePointer = 0
'            Close #1

         End If
         
         Screen.MousePointer = 11
         p = 1
         
         If Not Sw_xls Then
         
         Open NombreArchivo For Append As #1
         
         Do While Bac_SQL_Fetch(Arr())
            If Trim(Arr(1)) = "no hay datos" Then MsgBox Trim(Arr(1)) & Chr(10) & "Revise Fecha                ", vbCritical, gsBac_Version: Screen.MousePointer = 0: Close #1: Exit Sub
            Linea = ""

            Linea = Linea & Trim(Arr(1))
            Linea = Linea & Trim(Arr(2))
            Linea = Linea & Trim(Arr(3))
            Linea = Linea & Mid(Trim(Arr(4)), 7, 4) & Mid(Trim(Arr(4)), 4, 2) & Mid(Trim(Arr(4)), 1, 2)
            Linea = Linea & Ceros(Trim(Arr(5)), 9) & Trim(Arr(5))
            Linea = Linea & Ceros(Trim(Arr(6)), 9) & Trim(Arr(6))
            Linea = Linea & Trim(Arr(7))
            Linea = Linea & Trim(Arr(8))
            Linea = Linea & Trim(Arr(9))
            Linea = Linea & Ceros(Trim(Arr(10)), 2) & Trim(Arr(10))
            Linea = Linea & Ceros(Trim(Arr(11)), 2) & Trim(Arr(11))
            Linea = Linea & Ceros(Trim(Arr(12)), 3) & Trim(Arr(12))
            Linea = Linea & Trim(Arr(13))
            Linea = Linea & Ceros(Trim(Arr(26)), 11) & Trim(Arr(26))
            Linea = Linea & Ceros(Trim(Arr(27)), 3) & Trim(Arr(27))
            Linea = Linea & Mid(Trim(Arr(15)), 7, 4) & Mid(Trim(Arr(15)), 4, 2) & Mid(Trim(Arr(15)), 1, 2)
            Linea = Linea & Ceros(Trim(Arr(16)), 14) & Trim(Arr(16))
            paso = BacStrTran(Format(Val(Arr(17)), "000.00"), ",", "")
            Linea = Linea & paso
            Linea = Linea & Trim(Arr(18))
            Linea = Linea & Ceros(Trim(Arr(19)), 13) & Trim(Arr(19))
            Linea = Linea & Trim(Arr(20))
            Linea = Linea & Trim(Arr(21))
            Linea = Linea & Trim(Arr(22))
            Linea = Linea & Ceros(Trim(Arr(23)), 5) & Trim(Arr(23))
            Linea = Linea & Mid(Trim(Arr(24)), 7, 4) & Mid(Trim(Arr(24)), 4, 2) & Mid(Trim(Arr(24)), 1, 2)
            Linea = Linea & Espacios(Trim(Arr(25)), 12) & Trim(Arr(25))

            p = p + 1
            Crea = True
            Print #1, Linea

         Loop
         
         Proc = "sp_interfaz_d31_resumen"
      
         If Not Bac_Sql_Execute(Proc) Then
             Close #1
             Screen.MousePointer = 0
             MsgBox "No se puede generar Interfaz '" & Label3(Ind).Tag & "'", vbCritical, gsBac_Version
             Exit Sub
         End If

         
         Do While Bac_SQL_Fetch(Arr())
            Linea = ""
            Linea = Linea & Trim(Arr(1))
            Linea = Linea & Trim(Arr(2))
            Linea = Linea & Trim(Arr(3))
            Linea = Linea & Mid(Trim(Arr(4)), 7, 4) & Mid(Trim(Arr(4)), 4, 2) & Mid(Trim(Arr(4)), 1, 2)
            Linea = Linea & Ceros(Trim(Arr(5)), 6) & Trim(Arr(5))
            Linea = Linea & Ceros(Trim(Arr(6)), 15) & Trim(Arr(6))
            Linea = Linea & Ceros(Trim(Arr(7)), 6) & Trim(Arr(7))
            Linea = Linea & Ceros(Trim(Arr(8)), 15) & Trim(Arr(8))
            Linea = Linea & Space(72)
            p = p + 1
            Crea = True
            Print #1, Linea

         Loop

         
         Close #1
         Screen.MousePointer = 0
         If Crea Then   '***
            'MsgBox ("  INFORME " & Label3(Ind).Tag & " CREADO CON EXITO  "), vbInformation, gsBac_Version
            Call limpiar_cristal
        
            BAC_INVERSIONES.BacRpt.Destination = 1
            BAC_INVERSIONES.BacRpt.ReportFileName = RptList_Path & "d30_d31.rpt"
            BAC_INVERSIONES.BacRpt.StoredProcParam(0) = Format(txtFecha1.Text, "yyyy-mm-dd") & " 00:00:00.000"
            BAC_INVERSIONES.BacRpt.StoredProcParam(1) = Format(gsBac_Fecx, "yyyy-mm-dd") & " 00:00:00.000"
            BAC_INVERSIONES.BacRpt.Connect = CONECCION
            BAC_INVERSIONES.BacRpt.Action = 1
            Crea = False
         Else
            MsgBox "Interfaz '" & Label3(Ind).Tag & "'" & Chr(10) & "No contiene datos", vbCritical, gsBac_Version
         End If
         
      End If
      End If
      
     Checked(5).Visible = False
     
    Case 6
        
        Call interfaz_contable
        
    End Select
End If
Next Ind

Screen.MousePointer = 0
Checked(6).Visible = False
Exit Sub

Error:
    If Err.Number = 75 Then
        MsgBox "Problemas de Acceso a Archivo", vbCritical, gsBac_Version
    Else
        MsgBox "Error : " & Err.Number & vbCrLf & "Descripción : " & Err.Description, vbCritical, gsBac_Version
    End If
    Screen.MousePointer = 0
    Close #1

End Sub



Function interfaz_c14(nomarch)
Dim Arr()
Dim Crea As Boolean
Dim txtsql As String
Dim p As Integer
Dim Linea As String
Crea = False


p = 1
         If Dir(nomarch) <> "" Then
               Kill nomarch
         End If
         txtsql = "sp_select_intc14"
        Call Bac_Sql_Execute(txtsql)
         
         Open nomarch For Append As #1
         Do While Bac_SQL_Fetch(Arr())
            If Trim(Arr(1)) = "No Hay Datos" Then MsgBox Trim(Arr(1)) & Chr(10) & "Revise Fecha                ", vbCritical, gsBac_Version: Screen.MousePointer = 0: Close #1: Crea = False
            If Trim(Arr(16)) = "Interfaz" Then
            Linea = ""               'usar las funciones de str según especificaciones de interfaces     jlc
            Linea = Ceros(Trim(Arr(1)), 2) & Trim(Arr(1))
            Linea = Linea & Ceros(Trim(Arr(2)), 14) & Trim(Arr(2))
            Linea = Linea & Ceros(Trim(Arr(3)), 3) & Trim(Arr(3))
            Linea = Linea & Trim(Arr(4))
            Linea = Linea & Trim(Arr(5))
            Linea = Linea & Ceros(Trim(Arr(6)), 14) & Trim(Arr(6))
            Linea = Linea & Ceros(Trim(Arr(7)), 14) & Trim(Arr(7))
            Linea = Linea & Ceros(Trim(Arr(8)), 14) & Trim(Arr(8))
            If IsNull(Arr(9)) Then Arr(9) = ""
            Linea = Linea & Ceros(Trim(Arr(9)), 14) & Trim(Arr(9))
            Linea = Linea & Ceros(Trim(Arr(10)), 14) & Trim(Arr(10))
            Linea = Linea & Ceros(Trim(Arr(11)), 14) & Trim(Arr(11))
            Linea = Linea & Ceros(Trim(Arr(12)), 14) & Trim(Arr(12))
            Linea = Linea & Ceros(Trim(Arr(13)), 14) & Trim(Arr(13))
            Linea = Linea & Espacios(Trim(Arr(14)), 1) & Trim(Arr(14))
            Crea = True
            p = p + 1
            Print #1, Linea

            End If
            
            
            
         Loop
         Close #1
         Screen.MousePointer = 0
         interfaz_c14 = Crea
         
End Function



