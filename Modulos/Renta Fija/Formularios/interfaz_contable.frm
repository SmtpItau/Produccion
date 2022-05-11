VERSION 5.00
Begin VB.Form Interfaz_contable 
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Interfaz"
   ClientHeight    =   4320
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   4935
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   4320
   ScaleWidth      =   4935
   Begin VB.PictureBox SSPanel1 
      Height          =   4290
      Left            =   -15
      ScaleHeight     =   4230
      ScaleWidth      =   4890
      TabIndex        =   2
      Top             =   0
      Width           =   4950
      Begin VB.Frame Frame2 
         BackColor       =   &H00C0C0C0&
         Caption         =   "Directorio Destino"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   3165
         Left            =   135
         TabIndex        =   3
         Top             =   210
         Width           =   4650
         Begin VB.PictureBox grilla2 
            Height          =   105
            Left            =   8010
            ScaleHeight     =   45
            ScaleWidth      =   45
            TabIndex        =   11
            Top             =   2235
            Visible         =   0   'False
            Width           =   105
         End
         Begin VB.DriveListBox drive 
            Height          =   315
            Left            =   150
            TabIndex        =   6
            Top             =   285
            Width           =   4320
         End
         Begin VB.DirListBox Directorio 
            Height          =   1665
            Left            =   135
            TabIndex        =   5
            Top             =   630
            Width           =   4335
         End
         Begin VB.TextBox NOMBRE 
            Height          =   615
            Left            =   135
            Locked          =   -1  'True
            MultiLine       =   -1  'True
            ScrollBars      =   1  'Horizontal
            TabIndex        =   4
            Top             =   2355
            Width           =   4320
         End
      End
      Begin VB.PictureBox SSCommand1 
         Height          =   525
         Left            =   3840
         Picture         =   "interfaz_contable.frx":0000
         ScaleHeight     =   465
         ScaleWidth      =   930
         TabIndex        =   8
         Top             =   3540
         Width           =   990
      End
      Begin VB.PictureBox Prg 
         Height          =   345
         Left            =   195
         ScaleHeight     =   285
         ScaleWidth      =   3555
         TabIndex        =   9
         Top             =   3675
         Visible         =   0   'False
         Width           =   3615
      End
      Begin VB.TextBox Text1 
         Height          =   315
         Left            =   1950
         TabIndex        =   7
         Text            =   "Text1"
         Top             =   3060
         Visible         =   0   'False
         Width           =   1275
      End
      Begin VB.Label Label2 
         Caption         =   "Creando Informe..."
         ForeColor       =   &H000000FF&
         Height          =   180
         Left            =   225
         TabIndex        =   10
         Top             =   3435
         Visible         =   0   'False
         Width           =   1560
      End
   End
   Begin VB.Frame CuadroPrg 
      Height          =   420
      Left            =   3195
      TabIndex        =   1
      Top             =   3330
      Width           =   765
   End
   Begin VB.PictureBox grilla 
      Height          =   210
      Left            =   3855
      ScaleHeight     =   150
      ScaleWidth      =   300
      TabIndex        =   0
      Top             =   3990
      Visible         =   0   'False
      Width           =   360
   End
End
Attribute VB_Name = "Interfaz_contable"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim Datos()
Dim datos1()
Dim datos2()
Dim folio As Long
Dim NombreArchivo As String
Dim CPrg As Integer 'Contador Barra Progreso
Dim Numero As Double
Dim i As Double
Dim p As Double
Dim linea As String
Public Interfaz As String


Function Ceros(Dato As String, Largo As Integer) As String
Dim i%
Dim cero%

cero = (Largo - Len(Dato))
For i = 1 To cero
  Ceros = Ceros + "0"
Next i

End Function
Function ESPACIOS(Dato As String, Largo As Integer) As String

    ESPACIOS = 0
    
    If Len(Dato) <= Largo Then
        ESPACIOS = Space((Largo - Len(Dato)))
    End If

End Function
Private Sub Directorio_Change()
If Right(Directorio.Path, 1) <> "\" Then
 NOMBRE = ""
 NOMBRE = Directorio.Path + "\" + NombreArchivo + ".TXT"
Else
 NOMBRE = ""
 NOMBRE = Directorio.Path + NombreArchivo + ".TXT"
End If

End Sub

Private Sub drive_Change()
Screen.MousePointer = 0
On Error GoTo Error
Directorio.Path = drive.drive
drive.Refresh
Exit Sub

Error:
MsgBox Error(Err), vbExclamation
Directorio.Path = "c:\"
drive.Refresh
Exit Sub
End Sub

Private Sub Form_Load()
Me.Top = 0: Me.Left = 0
If Interfaz = "P17" Then NombreArchivo = "InterfazP17_" & Format(gsBac_Fecp, "yyyymmdd")
If Interfaz = "CONTABLE" Then NombreArchivo = "FILECONT" & Format(gsBac_Fecp, "yyyymmdd")


Directorio.Path = drive.drive
drive.Refresh

End Sub
Private Sub P17()
 
        Prg.Max = 10
        Prg.Value = 0
        CPrg = 0
        Numero = 0
        Label2.Visible = True
        Prg.Visible = True 'Barra
        BacControlWindows 50
        SSCommand1.Tag = Time
        Sql = ""
        Sql = "Sp_interfazp17"
        If miSql.SQL_Execute(Sql) <> 0 Then
            Screen.MousePointer = 0
            MsgBox "No se puede generar Interfaz ", vbCritical, Msj
            Exit Sub
        Else
            i = 1
            
            Screen.MousePointer = 11
             If Dir(NOMBRE) <> "" Then
               Kill NOMBRE
             End If
            p = 1
           Open NOMBRE For Append As #1
           
            Do While miSql.SQL_Fetch(Datos()) = 0
               If p = 1 Then
                 linea = Trim(Datos(1)) & ESPACIOS(Trim(Datos(1)), 3)
                 linea = linea & "P17" & Ceros(Trim(Datos(2)), 2) & Trim(Datos(2))
                 linea = linea & Ceros(Trim(Datos(3)), 2) & Trim(Datos(3))
                 Print #1, linea
               End If
                 linea = ""
                 linea = Ceros(Trim(Datos(4)), 3) & Trim(Datos(4))
                 linea = linea & Ceros(Trim(Datos(5)), 3) & Trim(Datos(5))
                 linea = linea & Ceros(Trim(Datos(6)), 5) & Trim(Datos(6))
                 linea = linea & Ceros(Trim(Datos(7)), 14) & Trim(Datos(7))
                 linea = linea & Ceros(Trim(Datos(8)), 14) & Trim(Datos(8))
                 linea = linea & Ceros(Trim(Datos(9)), 14) & Trim(Datos(9))
                 linea = linea & Ceros(Trim(Datos(10)), 1) & Trim(Datos(10))
                 Print #1, linea
                 p = p + 1
                 Prg.Max = p
                 BacControlWindows 20
                 Prg.Value = p
            Loop
            Close #1
            Screen.MousePointer = 0
            MsgBox ("  INFORME CREADO CON EXITO  "), vbInformation, ("BacTrader")
            Prg.Visible = False
            Label2.Visible = False
         End If
End Sub
Private Sub Contable()
Dim Deci As Double
        Numero = 0
        Prg.Value = 0
        CPrg = 0
        Label2.Visible = True
        Prg.Visible = True 'Barra
        Sql = ""
        Sql = "Sp_interfaz_contable_btr"
        If miSql.SQL_Execute(Sql) <> 0 Then
            Screen.MousePointer = 0
            MsgBox "No se puede generar Interfaz ", vbCritical, Msj
            Exit Sub
        Else
            i = 1
            
            Screen.MousePointer = 11
             If Dir(NOMBRE) <> "" Then
               Kill NOMBRE
             End If
            p = 1
            Open NOMBRE For Append As #1
           
            Do While miSql.SQL_Fetch(Datos()) = 0
                
               If p = 1 Or Numero <> Datos(1) Then
                 linea = "1GIF" & Ceros(Trim(Datos(1)), 5) & Trim(Datos(1))
                 linea = linea & Format(gsBac_Fecp, "yymmdd") & " 1 0 1" & Space(2)
                 linea = linea & Trim(Datos(2)) & ESPACIOS(Trim(Datos(15)), 14) & Trim(Datos(15))
                 linea = linea & ESPACIOS(Trim(Datos(15)), 10) & Ceros(Trim(Datos(16)), 6) & Trim(Datos(16))
                 linea = linea & Ceros(Trim(Datos(3)), 40) & Trim(Datos(3)) & Trim(Datos(4)) & ESPACIOS(Trim(Datos(4)), 9)
                 linea = linea & Trim(Datos(5)) & Trim(Datos(6)) & ESPACIOS(Trim(Datos(6)), 40)
                 linea = linea & Trim(Datos(7)) & ESPACIOS(Trim(Datos(7)), 40)
                 linea = linea & "INVERSION" & Space(6) & "0" & Space(11)
                 Print #1, linea
                 Numero = Datos(1)
               Else
                ' Numero = Datos(1)
               End If
               
                 linea = ""
                 linea = "2GIF" & Ceros(Trim(Datos(1)), 5) & Trim(Datos(1))
                 linea = linea & Ceros(Trim(Datos(8)), 2) & Trim(Datos(8))
                 linea = linea & Ceros(Trim(Datos(9)), 7) & Trim(Datos(9))
                 linea = linea & Ceros(Trim(Datos(10)), 3) & Trim(Datos(10))
                 linea = linea & Trim(Datos(11)) & ESPACIOS(Trim(Datos(11)), 15)
                 linea = linea & Ceros(Trim(Datos(12)), 1) & Trim(Datos(12))
                 Deci = CDbl(Datos(13)) - Int(Datos(13))
                 linea = linea & Ceros(Trim(Datos(13)), 12) & Trim(Datos(13))
                 linea = linea & Ceros(Trim(Deci), 2) & Trim(Deci)
                 linea = linea & Trim(Datos(14)) & ESPACIOS(Trim(Datos(14)), 6)
                 linea = linea & Space(10) & "1" & Space(3) & "0" & Space(3) & "1"
                 linea = linea & Space(137)
                 
                 Print #1, linea
                 p = p + 1
                 Prg.Max = p
                 BacControlWindows 20
                 Prg.Value = p
            Loop
            Close #1
            Screen.MousePointer = 0
            MsgBox ("  INFORME CREADO CON EXITO  "), vbInformation, ("BacTrader")
            Prg.Visible = False
            Label2.Visible = False
         End If

End Sub

Private Sub SSCommand1_Click()

   On Error GoTo Error

   If UCase(Interfaz) = "P17" Then
      Call P17

   End If

   If UCase(Interfaz) = "CONTABLE" Then
      Call Contable

   End If

   Exit Sub

Error:
   MsgBox Err.Description, Err.Number, ("Bactrader")
   Close #1
   Screen.MousePointer = 0

End Sub

