VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Begin VB.Form FrmCargaArchivo 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Carga de Archivo SAFP"
   ClientHeight    =   2985
   ClientLeft      =   4470
   ClientTop       =   4575
   ClientWidth     =   5700
   Icon            =   "FrmCargaArchivo.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   2985
   ScaleWidth      =   5700
   Begin VB.Frame Frame1 
      Height          =   1725
      Left            =   60
      TabIndex        =   3
      Top             =   540
      Width           =   5685
      Begin VB.FileListBox File_SAFP 
         Height          =   1455
         Left            =   2820
         Pattern         =   "*.txt"
         TabIndex        =   6
         Top             =   180
         Width           =   2655
      End
      Begin VB.DriveListBox Drive_SAFP 
         Height          =   315
         Left            =   180
         TabIndex        =   5
         Top             =   210
         Width           =   2595
      End
      Begin VB.DirListBox Dir_SAFP 
         Height          =   990
         Left            =   180
         TabIndex        =   4
         Top             =   600
         Width           =   2595
      End
   End
   Begin VB.Frame FrmCarga 
      Height          =   765
      Left            =   30
      TabIndex        =   1
      Top             =   2220
      Width           =   5685
      Begin Threed.SSPanel pnl_Porcentaje_Parametria 
         Height          =   510
         Left            =   60
         TabIndex        =   2
         Top             =   180
         Width           =   5565
         _Version        =   65536
         _ExtentX        =   9816
         _ExtentY        =   900
         _StockProps     =   15
         BackColor       =   -2147483644
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BorderWidth     =   1
         BevelOuter      =   1
         BevelInner      =   2
         FloodType       =   1
      End
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   6810
      Top             =   450
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   24
      ImageHeight     =   24
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   7
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmCargaArchivo.frx":000C
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmCargaArchivo.frx":0EE6
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmCargaArchivo.frx":1DC0
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmCargaArchivo.frx":2C9A
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmCargaArchivo.frx":2FB4
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmCargaArchivo.frx":3E8E
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmCargaArchivo.frx":4D68
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Tlb_Botones 
      Align           =   1  'Align Top
      Height          =   480
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   5700
      _ExtentX        =   10054
      _ExtentY        =   847
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Default"
            Object.ToolTipText     =   "Cargar Interfaz"
            ImageIndex      =   7
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Description     =   "Salir"
            Object.ToolTipText     =   "Cerrar Ventana"
            ImageIndex      =   4
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
End
Attribute VB_Name = "FrmCargaArchivo"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub Dir_SAFP_Change()
File_SAFP.Path = Dir_SAFP.Path
End Sub

Private Sub Drive_SAFP_Change()
Dir_SAFP.Path = Drive_SAFP.Drive
File_SAFP.Path = Dir_SAFP.Path
End Sub

Private Sub Form_Load()
   Me.Top = 0
   Me.Left = 0
   Me.Icon = Acceso_Usuario.Icon
End Sub

Private Sub Tlb_botones_ButtonClick(ByVal Button As MSComctlLib.Button)
  Select Case Button.Index
    Case 1
        Call PROC_CARGA_ARCHIVO
    Case 2
        Unload Me
  End Select
End Sub

Private Function PROC_CARGA_ARCHIVO()

Dim sFile       As String
Dim sProc       As String
Dim sVariable   As String
Dim nTotal      As Long
Dim nContador   As Long
Dim nContador1  As Long
Dim vArreglo

    If File_SAFP.FileName = "" Then
        MsgBox "Debe Eligir El Archivo a Cargar !!!", vbCritical
        Exit Function
    Else
        sFile = File_SAFP.Path & "\" & File_SAFP.FileName
    End If
      Envia = Array()
      AddParam Envia, "E"
      
      If Not Bac_Sql_Execute("SP_GRABA_ARCHIVO_SUPER", Envia) Then
         MsgBox "Problemas con la grabacion", vbCritical, TITSISTEMA
         Exit Function
      End If
    
    If Len(Dir(Trim(sFile), vbArchive)) <> 0 And Len(sFile) <> 0 Then
    
        nTotal = 1
        nContador = 1
        Open sFile For Input As #1
        Do While Not EOF(1)
            Line Input #1, sVariable
            nTotal = nTotal + 1
        Loop
        Close #1
        
        pnl_Porcentaje_Parametria.FloodPercent = 1
        Open sFile For Input As #1
        Do While Not EOF(1)
        
            Line Input #1, sVariable
            
            vArreglo = Array()
            Call PROC_FUN_SEPARAR(sVariable, vArreglo)
            
            Envia = Array()
            AddParam Envia, "G"
            AddParam Envia, vArreglo(0)
            AddParam Envia, vArreglo(1)
            AddParam Envia, vArreglo(2)
            AddParam Envia, CDbl(vArreglo(3))
            AddParam Envia, CDbl(vArreglo(4))
            AddParam Envia, CDbl(vArreglo(5))
            AddParam Envia, CDbl(vArreglo(6))
            AddParam Envia, vArreglo(7)
            
            If Not Bac_Sql_Execute("SP_GRABA_ARCHIVO_SUPER", Envia) Then
               MsgBox "Problemas con la grabacion", vbCritical, TITSISTEMA
               Exit Function
            End If
            
            nContador = nContador + 1
            pnl_Porcentaje_Parametria.FloodPercent = IIf((nContador * 100) / nTotal > 100, 100, (nContador * 100) / nTotal)
            
        Loop
        Close #1
        MsgBox "Grabacion de Archivo SBIF Correcta", vbInformation, TITSISTEMA
        pnl_Porcentaje_Parametria.FloodPercent = 100
    End If
    
End Function

Function PROC_FUN_SEPARAR(sChar As String, ByRef vArreglo As Variant) As Variant

Dim sVar                As String
Dim nContador           As Long

sVar = sChar
nContador = 1

Do While Len(sVar) > 0
   
    ReDim Preserve vArreglo(nContador)
   
    If PROC_FUNC_AT(";", sVar) <> 0 Then
        vArreglo(UBound(vArreglo) - 1) = Left(sVar, PROC_FUNC_AT(";", sVar) - 1)
        sVar = Mid(sVar, PROC_FUNC_AT(";", sVar) + 1)
    Else
        vArreglo(UBound(vArreglo) - 1) = sVar
        sVar = ""
    End If
    
    nContador = nContador + 1
    
Loop

End Function

Function PROC_FUNC_AT(sChar As String, sVariable As String) As Long
Dim nContador   As Long

PROC_FUNC_AT = 0

For nContador = 1 To Len(sVariable)
    If Mid(sVariable, nContador, 1) = sChar Then
        PROC_FUNC_AT = nContador
        Exit For
    End If
Next

End Function
