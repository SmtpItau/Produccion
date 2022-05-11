VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form FRM_InterfazD16_17 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Interfaz D"
   ClientHeight    =   3090
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   6705
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   3090
   ScaleWidth      =   6705
   ShowInTaskbar   =   0   'False
   Begin VB.DirListBox Ruta 
      Height          =   1890
      Left            =   2760
      TabIndex        =   6
      Top             =   1080
      Width           =   3855
   End
   Begin VB.Frame Frame2 
      Caption         =   "Generación actual"
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
      Height          =   1095
      Left            =   120
      TabIndex        =   3
      Top             =   1440
      Width           =   2535
      Begin BACControles.TXTNumero txtAno 
         Height          =   255
         Left            =   1440
         TabIndex        =   9
         Top             =   600
         Width           =   615
         _ExtentX        =   1085
         _ExtentY        =   450
         ForeColor       =   8388608
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0"
         Text            =   "0"
         Min             =   "0"
         Max             =   "9999"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
         SelText         =   "0"
         SelLength       =   1
      End
      Begin BACControles.TXTNumero txtMes 
         Height          =   255
         Left            =   480
         TabIndex        =   8
         Top             =   600
         Width           =   495
         _ExtentX        =   873
         _ExtentY        =   450
         ForeColor       =   8388608
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0"
         Text            =   "0"
         Min             =   "01"
         Max             =   "12"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
         SelText         =   "0"
         SelLength       =   1
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "Año"
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
         Height          =   195
         Left            =   1560
         TabIndex        =   5
         Top             =   360
         Width           =   345
      End
      Begin VB.Label Label1 
         Alignment       =   2  'Center
         AutoSize        =   -1  'True
         Caption         =   "Mes"
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
         Height          =   195
         Left            =   480
         TabIndex        =   4
         Top             =   360
         Width           =   360
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   2
      Top             =   0
      Width           =   6705
      _ExtentX        =   11827
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList2"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "limpiar"
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   34
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "generar"
            Object.ToolTipText     =   "Generar Interfaz"
            ImageIndex      =   29
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   48
         EndProperty
      EndProperty
   End
   Begin VB.Frame Frame1 
      Caption         =   "Ultima generación Interfaz"
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
      Height          =   735
      Left            =   120
      TabIndex        =   0
      Top             =   600
      Width           =   2535
      Begin VB.TextBox txtUltimaGeneracion 
         BackColor       =   &H00FFFFFF&
         Enabled         =   0   'False
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
         Height          =   375
         Left            =   720
         TabIndex        =   1
         Top             =   240
         Width           =   1095
      End
   End
   Begin MSComctlLib.ImageList ImageList2 
      Left            =   0
      Top             =   0
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   54
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_InterfazD16_17.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_InterfazD16_17.frx":0EDA
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_InterfazD16_17.frx":1DB4
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_InterfazD16_17.frx":2C8E
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_InterfazD16_17.frx":3B68
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_InterfazD16_17.frx":4A42
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_InterfazD16_17.frx":591C
            Key             =   ""
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_InterfazD16_17.frx":67F6
            Key             =   ""
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_InterfazD16_17.frx":76D0
            Key             =   ""
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_InterfazD16_17.frx":85AA
            Key             =   ""
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_InterfazD16_17.frx":9484
            Key             =   ""
         EndProperty
         BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_InterfazD16_17.frx":979E
            Key             =   ""
         EndProperty
         BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_InterfazD16_17.frx":A678
            Key             =   ""
         EndProperty
         BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_InterfazD16_17.frx":B552
            Key             =   ""
         EndProperty
         BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_InterfazD16_17.frx":C42C
            Key             =   ""
         EndProperty
         BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_InterfazD16_17.frx":D306
            Key             =   ""
         EndProperty
         BeginProperty ListImage17 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_InterfazD16_17.frx":E1E0
            Key             =   ""
         EndProperty
         BeginProperty ListImage18 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_InterfazD16_17.frx":F0BA
            Key             =   ""
         EndProperty
         BeginProperty ListImage19 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_InterfazD16_17.frx":FF94
            Key             =   ""
         EndProperty
         BeginProperty ListImage20 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_InterfazD16_17.frx":103E6
            Key             =   ""
         EndProperty
         BeginProperty ListImage21 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_InterfazD16_17.frx":10838
            Key             =   ""
         EndProperty
         BeginProperty ListImage22 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_InterfazD16_17.frx":10C8A
            Key             =   ""
         EndProperty
         BeginProperty ListImage23 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_InterfazD16_17.frx":11B64
            Key             =   ""
         EndProperty
         BeginProperty ListImage24 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_InterfazD16_17.frx":12A3E
            Key             =   ""
         EndProperty
         BeginProperty ListImage25 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_InterfazD16_17.frx":12E90
            Key             =   ""
         EndProperty
         BeginProperty ListImage26 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_InterfazD16_17.frx":132E2
            Key             =   ""
         EndProperty
         BeginProperty ListImage27 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_InterfazD16_17.frx":13734
            Key             =   ""
         EndProperty
         BeginProperty ListImage28 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_InterfazD16_17.frx":13B86
            Key             =   ""
         EndProperty
         BeginProperty ListImage29 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_InterfazD16_17.frx":14A60
            Key             =   ""
         EndProperty
         BeginProperty ListImage30 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_InterfazD16_17.frx":1593A
            Key             =   ""
         EndProperty
         BeginProperty ListImage31 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_InterfazD16_17.frx":16814
            Key             =   ""
         EndProperty
         BeginProperty ListImage32 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_InterfazD16_17.frx":176EE
            Key             =   ""
         EndProperty
         BeginProperty ListImage33 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_InterfazD16_17.frx":17A08
            Key             =   ""
         EndProperty
         BeginProperty ListImage34 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_InterfazD16_17.frx":188E2
            Key             =   ""
         EndProperty
         BeginProperty ListImage35 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_InterfazD16_17.frx":197BC
            Key             =   ""
         EndProperty
         BeginProperty ListImage36 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_InterfazD16_17.frx":1A696
            Key             =   ""
         EndProperty
         BeginProperty ListImage37 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_InterfazD16_17.frx":1B570
            Key             =   ""
         EndProperty
         BeginProperty ListImage38 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_InterfazD16_17.frx":1C44A
            Key             =   ""
         EndProperty
         BeginProperty ListImage39 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_InterfazD16_17.frx":1D324
            Key             =   ""
         EndProperty
         BeginProperty ListImage40 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_InterfazD16_17.frx":1E1FE
            Key             =   ""
         EndProperty
         BeginProperty ListImage41 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_InterfazD16_17.frx":1F0D8
            Key             =   ""
         EndProperty
         BeginProperty ListImage42 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_InterfazD16_17.frx":1FFB2
            Key             =   ""
         EndProperty
         BeginProperty ListImage43 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_InterfazD16_17.frx":20E8C
            Key             =   ""
         EndProperty
         BeginProperty ListImage44 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_InterfazD16_17.frx":21D66
            Key             =   ""
         EndProperty
         BeginProperty ListImage45 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_InterfazD16_17.frx":22C40
            Key             =   ""
         EndProperty
         BeginProperty ListImage46 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_InterfazD16_17.frx":23B1A
            Key             =   ""
         EndProperty
         BeginProperty ListImage47 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_InterfazD16_17.frx":249F4
            Key             =   ""
         EndProperty
         BeginProperty ListImage48 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_InterfazD16_17.frx":258CE
            Key             =   ""
         EndProperty
         BeginProperty ListImage49 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_InterfazD16_17.frx":25BE8
            Key             =   ""
         EndProperty
         BeginProperty ListImage50 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_InterfazD16_17.frx":26AC2
            Key             =   ""
         EndProperty
         BeginProperty ListImage51 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_InterfazD16_17.frx":2799C
            Key             =   ""
         EndProperty
         BeginProperty ListImage52 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_InterfazD16_17.frx":27CB6
            Key             =   ""
         EndProperty
         BeginProperty ListImage53 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_InterfazD16_17.frx":28B90
            Key             =   ""
         EndProperty
         BeginProperty ListImage54 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_InterfazD16_17.frx":29A6A
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin VB.Label Label3 
      AutoSize        =   -1  'True
      Caption         =   "Seleccione la ruta en donde dejar el archivo"
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
      Height          =   195
      Left            =   2760
      TabIndex        =   7
      Top             =   840
      Width           =   3795
   End
End
Attribute VB_Name = "FRM_InterfazD16_17"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Form_Load()
Me.Top = 0
Me.Left = 0
Ruta.Path = "C:\"
Dim xD As String
Select Case codInterfaz1617
    Case "16"
        xD = "D16"
    Case 17
        xD = "D17"
End Select
Me.Caption = "Interfaz " & xD
txtUltimaGeneracion.Text = UltimoPeriodo()

End Sub
Private Function UltimoPeriodo() As String
Dim Datos()
Dim sp As String
Dim Resp As String
Envia = Array()
sp = "Bacparamsuda..SP_ULTIMOPERIODOINTERFACES1617"
If Not Bac_Sql_Execute(sp) Then
    UltimoPeriodo = ""
    Exit Function
End If
If Bac_SQL_Fetch(Datos()) <> 0 Then
    Resp = Datos(1)
End If
If Resp <> "NO HAY" Then
    Resp = Mid$(Resp, 1, 2) & "-" & Mid$(Resp, 3, 4)
End If
UltimoPeriodo = Resp
End Function
Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

Select Case Button.Index
    Case 1
        Call Limpiar
    Case 2
        Call GenerarInterfaz(codInterfaz)
    Case 3
        Unload Me
End Select
End Sub
Private Sub Limpiar()
    txtMes.Text = ""
    txtAno.Text = ""
    Ruta.Path = "C:\"
End Sub
Private Function GenerarInterfaz(ByVal codInt As String) As Boolean
Dim omes As String
Dim Ano As String
Dim salida As String
Dim nmes As String, nano As String
Dim factor1 As Long, factor2 As Long
On Error GoTo falla
If CDbl(txtMes.Text) < 1 Or CDbl(txtMes.Text) > 12 Then
    MsgBox "El mes es inválido!", vbExclamation, TITSISTEMA
    GenerarInterfaz = False
    Exit Function
End If
If CDbl(txtAno.Text) < 2009 Then
    MsgBox "El año es inválido!", vbExclamation, TITSISTEMA
    GenerarInterfaz = False
    Exit Function
End If
If txtUltimaGeneracion.Text <> "NO HAY" Then
    omes = Mid$(txtUltimaGeneracion.Text, 1, 2)
    oano = Mid$(txtUltimaGeneracion.Text, 4, 4)
    factor1 = CDbl(oano) + CDbl(omes)
    factor2 = CDbl(txtAno.Text) + CDbl(txtMes.Text)
    If factor2 < factor1 Then
        MsgBox "El nuevo período no puede ser inferior al último generado!", vbInformation, TITSISTEMA
        GenerarInterfaz = False
        Exit Function
    End If
End If
nmes = Format(CDbl(txtMes.Text), "00")
nano = Format(CDbl(txtAno.Text), "0000")

Dim I As Long
Dim Datos()
Dim nomSp As String
Dim primerreg As String
Dim nomfile As String
Dim nomarchivo As String
Dim REGISTRO As String
Envia = Array()
AddParam Envia, CDbl(nmes)
AddParam Envia, CDbl(nano)
AddParam Envia, "1"
Select Case codInterfaz1617
    Case "16"
        nomSp = "Bacparamsuda..SP_INTERFACE_D16"
    Case "17"
        nomSp = "Bacparamsuda..SP_INTERFACE_D17"
End Select
nomarchivo = Ruta.Path
If Mid$(nomarchivo, Len(nomarchivo), 1) <> "\" Then
    nomarchivo = nomarchivo & "\"
End If
If Not Bac_Sql_Execute(nomSp, Envia) Then
    GenerarInterfaz = False
    Exit Function
End If
Do While Bac_SQL_Fetch(Datos())
        'El primer registro con el nombre del archivo
        primerreg = Datos(1)
        nomarchivo = nomarchivo & primerreg & ".txt"
Loop

Envia = Array()
AddParam Envia, CDbl(nmes)
AddParam Envia, CDbl(nano)
AddParam Envia, "T"
Select Case codInterfaz1617
    Case "16"
        nomSp = "Bacparamsuda..SP_INTERFACE_D16"
    Case "17"
        nomSp = "Bacparamsuda..SP_INTERFACE_D17"
End Select
If Not Bac_Sql_Execute(nomSp, Envia) Then
    GenerarInterfaz = False
    Exit Function
End If
Open (nomarchivo) For Output As #1
Print #1, primerreg
REGISTRO = ""
Do While Bac_SQL_Fetch(Datos())
        For I = 1 To 9
            REGISTRO = REGISTRO & Replace(Datos(I), ".", " ")
        Next I
        Print #1, REGISTRO
        REGISTRO = ""
Loop
Close #1
GenerarInterfaz = True
MsgBox "La interfaz D" & codInterfaz1617 & " se ha generado exitosamente!", vbInformation, TITSISTEMA

'Actualizar tabla de parametros
salida = ""
Envia = Array()
AddParam Envia, nmes
AddParam Envia, nano
nomSp = "Bacparamsuda..SP_ACTUALIZAULTPERINTERFACES"
If Bac_Sql_Execute(nomSp, Envia) Then
    If Bac_SQL_Fetch(Datos()) <> 0 Then
        salida = Datos(1)
    End If
End If
If salida = "ERROR" Then
    MsgBox "Se ha producido un error al actualizar la tabla de Parámetros de Garantías!", vbExclamation, TITSISTEMA
End If
Exit Function
falla:
    MsgBox "Se ha producido un error al generar la interfaz D" & codInterfaz1617 & ": " & err.Description, vbExclamation, TITSISTEMA
End Function

