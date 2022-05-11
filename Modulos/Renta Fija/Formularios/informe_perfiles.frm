VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form informe_perfiles 
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "INFORME PERFILES"
   ClientHeight    =   5460
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   4935
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   5460
   ScaleWidth      =   4935
   Begin Threed.SSPanel SSPanel1 
      Height          =   5445
      Left            =   -15
      TabIndex        =   2
      Top             =   0
      Width           =   4950
      _Version        =   65536
      _ExtentX        =   8731
      _ExtentY        =   9604
      _StockProps     =   15
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BevelInner      =   1
      Begin VB.Frame Frame1 
         BackColor       =   &H00C0C0C0&
         Caption         =   "Salida del Informe"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   645
         Left            =   195
         TabIndex        =   9
         Top             =   810
         Width           =   4590
         Begin VB.OptionButton Option1 
            Caption         =   "IMPRESORA"
            ForeColor       =   &H00404040&
            Height          =   210
            Index           =   0
            Left            =   585
            TabIndex        =   11
            Top             =   330
            Value           =   -1  'True
            Width           =   1335
         End
         Begin VB.OptionButton Option1 
            Caption         =   "ARCHIVO"
            ForeColor       =   &H00404040&
            Height          =   210
            Index           =   1
            Left            =   2130
            TabIndex        =   10
            Top             =   330
            Width           =   1335
         End
      End
      Begin VB.ComboBox Combo1 
         Enabled         =   0   'False
         Height          =   315
         ItemData        =   "informe_perfiles.frx":0000
         Left            =   1590
         List            =   "informe_perfiles.frx":000D
         Style           =   2  'Dropdown List
         TabIndex        =   7
         Top             =   360
         Width           =   1665
      End
      Begin VB.Frame Frame2 
         BackColor       =   &H00C0C0C0&
         Caption         =   "Directorio Destino"
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
         Height          =   3165
         Left            =   165
         TabIndex        =   3
         Top             =   1470
         Width           =   4650
         Begin MSFlexGridLib.MSFlexGrid grilla2 
            Height          =   105
            Left            =   8010
            TabIndex        =   17
            Top             =   2235
            Visible         =   0   'False
            Width           =   105
            _ExtentX        =   185
            _ExtentY        =   185
            _Version        =   393216
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
      Begin Threed.SSCommand SSCommand1 
         Height          =   525
         Left            =   3840
         TabIndex        =   12
         Top             =   4755
         Width           =   990
         _Version        =   65536
         _ExtentX        =   1746
         _ExtentY        =   926
         _StockProps     =   78
         Picture         =   "informe_perfiles.frx":002C
      End
      Begin MSComctlLib.ProgressBar Prg 
         Height          =   345
         Left            =   165
         TabIndex        =   13
         Top             =   4920
         Visible         =   0   'False
         Width           =   3615
         _ExtentX        =   6376
         _ExtentY        =   609
         _Version        =   393216
         Appearance      =   1
      End
      Begin VB.Frame Frame3 
         Height          =   555
         Left            =   165
         TabIndex        =   15
         Top             =   195
         Width           =   4590
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "Sistema"
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
            Left            =   210
            TabIndex        =   16
            Top             =   195
            Width           =   870
         End
      End
      Begin VB.TextBox Text1 
         Height          =   315
         Left            =   2730
         TabIndex        =   8
         Text            =   "Text1"
         Top             =   3285
         Visible         =   0   'False
         Width           =   1275
      End
      Begin VB.Label Label2 
         Caption         =   "Creando Informe..."
         ForeColor       =   &H000000FF&
         Height          =   180
         Left            =   210
         TabIndex        =   14
         Top             =   4650
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
   Begin MSFlexGridLib.MSFlexGrid grilla 
      Height          =   210
      Left            =   3855
      TabIndex        =   0
      Top             =   3990
      Visible         =   0   'False
      Width           =   360
      _ExtentX        =   635
      _ExtentY        =   370
      _Version        =   393216
   End
End
Attribute VB_Name = "informe_perfiles"
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

Function Ceros(Dato As String, Largo As Integer) As String
Dim I%
Dim cero%

cero = (Largo - Len(Dato))
For I = 1 To cero
  Ceros = Ceros + "0"
Next I

End Function
Function ESPACIOS(Dato As String, Largo As Integer) As String

    ESPACIOS = 0
    
    If Len(Dato) <= Largo Then
        ESPACIOS = Space((Largo - Len(Dato)))
    End If

End Function
Private Sub Combo1_Click()
If Combo1.ListIndex = 0 Then Text1.Text = "BTR"
If Combo1.ListIndex = 1 Then Text1.Text = "BCC"
If Combo1.ListIndex = 2 Then Text1.Text = "BFW"
Call Directorio_Change
End Sub
Private Function archivo()
'On Error GoTo Error
Dim q, x As Integer

        If Dir(NOMBRE) <> "" Then
            Kill NOMBRE
        End If
          
          Open NOMBRE For Append As #1
          Print #1, "                                     INFORME PERFILES CONTABLES  " & UCase(Combo1.Text)
           grilla.Rows = grilla.Rows - 1
           For I = 0 To grilla.Rows - 1
               If I <> 0 Then I = I - 1
                folio = Val(grilla.TextMatrix(I, 0))
                Linea = ""
                Print #1, "----------------------------------------------------------------------------------------------------------------------------------------"
                Print #1, " "
                Print #1, "________________________________________________________________________________________________________________________________________"
                Print #1, " "
                Linea = "Nº Folio : " & Trim(grilla.TextMatrix(I, 0))
                Linea = Linea & ESPACIOS(Trim(grilla.TextMatrix(I, 0)), 3) & Space(2)
                Linea = Linea & "Tipo Voucher : " & Trim(grilla.TextMatrix(I, 1)) & ESPACIOS(Trim(grilla.TextMatrix(I, 1)), 1) & Space(2)
                Linea = Linea & "GLOSA : " & Trim(grilla.TextMatrix(I, 2)) & ESPACIOS(Trim(grilla.TextMatrix(I, 2)), 70) & Space(2)
               ' Linea = Linea & datos(4) & Space(2)
                Print #1, Linea
                Print #1, " "
                Print #1, "________________________________________________________________________________________________________________________________________"
                Print #1, " "
                
                BacControlWindows 20
                    Linea = ""
                    Print #1, Linea
                    Print #1, Linea
                    Print #1, "DETALLE PERFIL Nº" & folio
                    Print #1, "________________________________________________________________________________________________________________________________________"
                    Print #1, "Corr      Campo                    D/H  Fijo   Cuenta         Descripción                            Campo variable"
                    Print #1, "________________________________________________________________________________________________________________________________________"
                    Print #1, "  "
                    Do While Trim(grilla.TextMatrix(I, 0)) = folio
                        Linea = ""
                        Linea = Trim(grilla.TextMatrix(I, 3)) & ESPACIOS(Val(Trim(grilla.TextMatrix(I, 3))), 3) & Space(2)
                        Linea = Linea & Mid(Trim(grilla.TextMatrix(I, 4)), 1, 30) & ESPACIOS(Mid(Trim(grilla.TextMatrix(I, 4)), 1, 30), 30) & Space(2)
                        Linea = Linea & Trim(grilla.TextMatrix(I, 5)) & ESPACIOS(Trim(grilla.TextMatrix(I, 5)), 1) & Space(3)
                        Linea = Linea & Trim(grilla.TextMatrix(I, 6)) & ESPACIOS(Trim(grilla.TextMatrix(I, 6)), 1) & Space(5)
                        Linea = Linea & Trim(grilla.TextMatrix(I, 7)) & ESPACIOS(Trim(grilla.TextMatrix(I, 7)), 12) & Space(2)
                        Linea = Linea & Mid(Trim(grilla.TextMatrix(I, 8)), 1, 35) & ESPACIOS(Mid(Trim(grilla.TextMatrix(I, 8)), 1, 35), 35) & Space(4)
                        Linea = Linea & Mid(Trim(grilla.TextMatrix(I, 9)), 1, 30) & ESPACIOS(Mid(Trim(grilla.TextMatrix(I, 9)), 1, 30), 30) & Space(2)
                        Print #1, Linea
                        I = I + 1
                        If I = grilla.Rows Then Exit Do
                    Loop
                   
                    BacControlWindows 20
                    x = 0
                    Linea = ""
                    Print #1, Linea
                    Print #1, Linea
                    Print #1, "________________________________________________________________________________________________________________________________________"
                    Print #1, ""
                    Print #1, "VARIABLES DEL PERFIL Nº " & folio
                    Print #1, "________________________________________________________________________________________________________________________________________"
                    Print #1, "Corr  Cuenta             Descripción                   Condición"
                    Print #1, "________________________________________________________________________________________________________________________________________"
                    Print #1, "  "
                    For q = 0 To grilla2.Rows - 2
                        If grilla2.TextMatrix(q, 0) = folio Then
                                    Do While grilla2.TextMatrix(q, 0) = folio
                                        Linea = ""
                                        Linea = Trim(grilla2.TextMatrix(q, 1)) & ESPACIOS(Trim(grilla2.TextMatrix(q, 1)), 3) & Space(2)
                                        Linea = Linea & Trim(grilla2.TextMatrix(q, 2)) & ESPACIOS(Trim(grilla2.TextMatrix(q, 2)), 12) & Space(2)
                                        Linea = Linea & Mid(Trim(grilla2.TextMatrix(q, 3)), 1, 30) & ESPACIOS(Mid(Trim(grilla2.TextMatrix(q, 3)), 1, 30), 30) & Space(4)
                                        Linea = Linea & Trim(grilla2.TextMatrix(q, 4)) & ESPACIOS(Trim(grilla2.TextMatrix(q, 4)), 1) & Space(2)
                                        Linea = Linea & Mid(Trim(grilla2.TextMatrix(q, 5)), 1, 30) & ESPACIOS(Mid(Trim(grilla2.TextMatrix(q, 5)), 1, 30), 30) & Space(2)
                                        Print #1, Linea
                                        q = q + 1
                                        If q = grilla2.Rows - 1 Then Exit For
                                        x = 1
                                    Loop
                                    Print #1, ""
                                    Exit For
                       End If
                   Next q
                   If x <> 1 Then
                    Print #1, "NO EXISTEN PERFILES VARIABLES"
                   End If
                   x = 0
                    
                    'BacControlWindows 50
                
                    'Barra Progress
                    CPrg = CPrg + 1
                    Prg.Value = CPrg
                 
           Next I
           Close #1

        Screen.MousePointer = 0
'Exit Function
'Error:
'Screen.MousePointer = 0
'MsgBox Err.Description, vbExclamation
'Close #1
End Function
Private Function impresora()

          Printer.Orientation = 2
          Printer.PaperSize = 7
          Printer.FontSize = 8
          Printer.FontName = "Courier New"
          Printer.Print Space(50) & "INFORME PERFILES CONTABLES " & UCase(Combo1.Text)
          Printer.Print "----------------------------------------------------------------------------------------------------------------------------------------"
          grilla.Rows = grilla.Rows - 1
           For I = 0 To grilla.Rows - 1
               If I <> 0 Then I = I - 1
                folio = Val(grilla.TextMatrix(I, 0))
                Linea = ""
                Printer.Print " "
                Printer.Print "________________________________________________________________________________________________________________________________________"
                Printer.Print " "
                Linea = "Nº Folio : " & Trim(grilla.TextMatrix(I, 0))
                Linea = Linea & ESPACIOS(Trim(grilla.TextMatrix(I, 0)), 3) & Space(2)
                Linea = Linea & "Tipo Voucher : " & Trim(grilla.TextMatrix(I, 1)) & ESPACIOS(Trim(grilla.TextMatrix(I, 1)), 1) & Space(2)
                Linea = Linea & "GLOSA : " & Trim(grilla.TextMatrix(I, 2)) & ESPACIOS(Trim(grilla.TextMatrix(I, 2)), 70) & Space(2)
               ' Linea = Linea & datos(4) & Space(2)
                Printer.Print Linea
                Printer.Print " "
                Printer.Print "________________________________________________________________________________________________________________________________________"
                Printer.Print " "
                
                BacControlWindows 20
                    Linea = ""
                    Printer.Print Linea
                    Printer.Print Linea
                    Printer.Print "DETALLE PERFIL Nº" & folio
                    Printer.Print "________________________________________________________________________________________________________________________________________"
                    Printer.Print "Corr      Campo                    D/H  Fijo   Cuenta         Descripción                            Campo variable"
                    Printer.Print "________________________________________________________________________________________________________________________________________"
                    Printer.Print "  "
                    Do While Trim(grilla.TextMatrix(I, 0)) = folio
                        Linea = ""
                        Linea = Trim(grilla.TextMatrix(I, 3)) & ESPACIOS(Val(Trim(grilla.TextMatrix(I, 3))), 3) & Space(2)
                        Linea = Linea & Mid(Trim(grilla.TextMatrix(I, 4)), 1, 30) & ESPACIOS(Mid(Trim(grilla.TextMatrix(I, 4)), 1, 30), 30) & Space(2)
                        Linea = Linea & Trim(grilla.TextMatrix(I, 5)) & ESPACIOS(Trim(grilla.TextMatrix(I, 5)), 1) & Space(3)
                        Linea = Linea & Trim(grilla.TextMatrix(I, 6)) & ESPACIOS(Trim(grilla.TextMatrix(I, 6)), 1) & Space(5)
                        Linea = Linea & Trim(grilla.TextMatrix(I, 7)) & ESPACIOS(Trim(grilla.TextMatrix(I, 7)), 12) & Space(2)
                        Linea = Linea & Mid(Trim(grilla.TextMatrix(I, 8)), 1, 35) & ESPACIOS(Mid(Trim(grilla.TextMatrix(I, 8)), 1, 35), 35) & Space(4)
                        Linea = Linea & Mid(Trim(grilla.TextMatrix(I, 9)), 1, 30) & ESPACIOS(Mid(Trim(grilla.TextMatrix(I, 9)), 1, 30), 30) & Space(2)
                        Printer.Print Linea
                        I = I + 1
                        If I = grilla.Rows Then Exit Do
                    Loop
                   
                    BacControlWindows 20
                    x = 0
                    Linea = ""
                    Printer.Print Linea
                    Printer.Print Linea
                    Printer.Print "________________________________________________________________________________________________________________________________________"
                    Printer.Print ""
                    Printer.Print "VARIABLES DEL PERFIL Nº " & folio
                    Printer.Print "________________________________________________________________________________________________________________________________________"
                    Printer.Print "Corr  Cuenta             Descripción                   Condición"
                    Printer.Print "________________________________________________________________________________________________________________________________________"
                    Printer.Print "  "
                    For q = 0 To grilla2.Rows - 2
                        If grilla2.TextMatrix(q, 0) = folio Then
                                    Do While grilla2.TextMatrix(q, 0) = folio
                                        Linea = ""
                                        Linea = Trim(grilla2.TextMatrix(q, 1)) & ESPACIOS(Trim(grilla2.TextMatrix(q, 1)), 3) & Space(2)
                                        Linea = Linea & Trim(grilla2.TextMatrix(q, 2)) & ESPACIOS(Trim(grilla2.TextMatrix(q, 2)), 12) & Space(2)
                                        Linea = Linea & Mid(Trim(grilla2.TextMatrix(q, 3)), 1, 30) & ESPACIOS(Mid(Trim(grilla2.TextMatrix(q, 3)), 1, 30), 30) & Space(4)
                                        Linea = Linea & Trim(grilla2.TextMatrix(q, 4)) & ESPACIOS(Trim(grilla2.TextMatrix(q, 4)), 1) & Space(2)
                                        Linea = Linea & Mid(Trim(grilla2.TextMatrix(q, 5)), 1, 30) & ESPACIOS(Mid(Trim(grilla2.TextMatrix(q, 5)), 1, 30), 30) & Space(2)
                                        Printer.Print Linea
                                        q = q + 1
                                        If q = grilla2.Rows - 1 Then Exit For
                                        x = 1
                                    Loop
                                    Printer.Print ""
                                    Exit For
                       End If
                   Next q
                   If x <> 1 Then
                    Printer.Print "NO EXISTEN PERFILES VARIABLES"
                   End If
                   x = 0
                    
                    'BacControlWindows 50
                
                    'Barra Progress
                    Printer.NewPage
                    CPrg = CPrg + 1
                    Prg.Value = CPrg
                 
           Next I
           Printer.EndDoc
           Screen.MousePointer = 0
           Printer.EndDoc
     
End Function





Private Sub Directorio_Change()
If Right(Directorio.Path, 1) <> "\" Then
 NOMBRE = ""
 NOMBRE = Directorio.Path + "\" + NombreArchivo + "_" + Combo1.Text + ".TXT"
Else
 NOMBRE = ""
 NOMBRE = Directorio.Path + NombreArchivo + "_" + Combo1.Text + ".TXT"
End If

End Sub

Private Sub drive_Change()
Screen.MousePointer = 0
On Error GoTo error
Directorio.Path = drive.drive
drive.Refresh
Exit Sub

error:
MsgBox error(err), vbExclamation
Directorio.Path = "c:\"
drive.Refresh
Exit Sub
End Sub

Private Sub Form_Load()
On Error GoTo error
Me.Top = 0: Me.Left = 0

Combo1.ListIndex = 0
NombreArchivo = "INFORME_PERFILES"
Directorio.Path = App.Path & "\interfaces"
drive.Refresh
Exit Sub

error:
MsgBox "Carpeta " & App.Path & "\interfaces" & "No existe", vbCritical
Directorio.Path = App.Path
End Sub

Private Sub Option1_Click(Index As Integer)
If Option1(1).Value = True Then Frame2.Enabled = True
If Option1(0).Value = True Then Frame2.Enabled = False
End Sub

Private Sub SSCommand1_Click()
On Error GoTo error
Dim I As Double
        Prg.Max = 10
        Prg.Value = 0
        CPrg = 0
        Numero = 0
        Label2.Visible = True
        Prg.Visible = True 'Barra
        BacControlWindows 50
        SSCommand1.Tag = Time
        Sql = ""
        grilla.Cols = 11
        grilla.Rows = 1
        grilla2.Cols = 6
        grilla2.Rows = 1
        grilla2.FixedRows = 0
        grilla2.FixedCols = 0
        grilla.FixedRows = 0
        grilla.FixedCols = 0
        Envia = Array()
        AddParam Envia, Text1.Text
        If Not Bac_Sql_Execute("SP_INFORME_PERFILES4", Envia) <> 0 Then
            Screen.MousePointer = 0
            MsgBox "No se puede generar Interfaz ", vbCritical, Msj
            Exit Sub
        Else
            I = 1
            Screen.MousePointer = 11
            
            Do While Bac_SQL_Fetch(datos1())
                 Numero = datos1(11)
                 grilla.TextMatrix(grilla.Row, 0) = Val(datos1(1))
                 grilla.TextMatrix(grilla.Row, 1) = datos1(2)
                 grilla.TextMatrix(grilla.Row, 2) = datos1(3)
                 grilla.TextMatrix(grilla.Row, 3) = datos1(4)
                 grilla.TextMatrix(grilla.Row, 4) = datos1(5)
                 grilla.TextMatrix(grilla.Row, 5) = datos1(6)
                 grilla.TextMatrix(grilla.Row, 6) = datos1(7)
                 grilla.TextMatrix(grilla.Row, 7) = datos1(8)
                 grilla.TextMatrix(grilla.Row, 8) = datos1(9)
                 grilla.TextMatrix(grilla.Row, 9) = datos1(10)
                 grilla.Rows = grilla.Rows + 1
                 grilla.Row = grilla.Row + 1
            Loop
        'Label2.Visible = True
        Prg.Max = Numero + 1
        BacControlWindows 20
        Prg.Value = 1

        Envia = Array()
        AddParam Envia, Text1.Text
        
        If Not Bac_Sql_Execute("SP_INFORME_VARIABLES", Envia) <> 0 Then
            Screen.MousePointer = 0
            MsgBox "No se puede generar Interfaz ", vbCritical, Msj
            Exit Sub
        Else
            I = 1
            Screen.MousePointer = 11
            
            Do While Bac_SQL_Fetch(datos1())
                 grilla2.TextMatrix(grilla2.Row, 0) = Val(datos1(1))
                 grilla2.TextMatrix(grilla2.Row, 1) = datos1(2)
                 grilla2.TextMatrix(grilla2.Row, 2) = datos1(3)
                 grilla2.TextMatrix(grilla2.Row, 3) = datos1(4)
                 grilla2.TextMatrix(grilla2.Row, 4) = datos1(5)
                 grilla2.TextMatrix(grilla2.Row, 5) = datos1(6)
                 grilla2.Rows = grilla2.Rows + 1
                 grilla2.Row = grilla2.Row + 1
            Loop
                        
         End If
            If Option1(0).Value = True Then
                Call impresora
            Else
                Call archivo
            End If
            MsgBox ("  INFORME CREADO CON EXITO  "), vbInformation, ("BacTrader")
            Prg.Visible = False
            Label2.Visible = False
        
         End If
Exit Sub

error:
MsgBox err.Description, err.Number, ("Bactrader")
Screen.MousePointer = 0
End Sub

