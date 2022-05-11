VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Begin VB.Form Bac_Interfaz 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Interfaz"
   ClientHeight    =   4065
   ClientLeft      =   75
   ClientTop       =   2445
   ClientWidth     =   4755
   ForeColor       =   &H00000000&
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   4065
   ScaleWidth      =   4755
   Begin VB.Data Data1 
      Caption         =   "Data1"
      Connect         =   "dBASE IV;"
      DatabaseName    =   ""
      DefaultCursorType=   0  'DefaultCursor
      DefaultType     =   2  'UseODBC
      Exclusive       =   0   'False
      Height          =   345
      Left            =   5715
      Options         =   0
      ReadOnly        =   0   'False
      RecordsetType   =   1  'Dynaset
      RecordSource    =   ""
      Top             =   -15
      Visible         =   0   'False
      Width           =   1935
   End
   Begin Threed.SSPanel SSPanel1 
      Height          =   4035
      Left            =   0
      TabIndex        =   2
      Top             =   15
      Width           =   4800
      _Version        =   65536
      _ExtentX        =   8467
      _ExtentY        =   7117
      _StockProps     =   15
      ForeColor       =   -2147483633
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
      Begin VB.Frame Frame2 
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
         ForeColor       =   &H8000000D&
         Height          =   2970
         Left            =   120
         TabIndex        =   3
         Top             =   135
         Width           =   4575
         Begin VB.DirListBox Directorio 
            Height          =   1665
            Left            =   120
            TabIndex        =   5
            Top             =   630
            Width           =   4335
         End
         Begin MSFlexGridLib.MSFlexGrid grilla2 
            Height          =   105
            Left            =   8010
            TabIndex        =   11
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
         Begin VB.TextBox NOMBRE 
            Height          =   615
            Left            =   135
            Locked          =   -1  'True
            MultiLine       =   -1  'True
            ScrollBars      =   1  'Horizontal
            TabIndex        =   4
            Top             =   2280
            Width           =   4320
         End
      End
      Begin VB.Frame frmConta 
         Height          =   900
         Left            =   120
         TabIndex        =   17
         Top             =   3060
         Width           =   3735
         Begin VB.PictureBox SinCheck 
            BorderStyle     =   0  'None
            Height          =   330
            Index           =   0
            Left            =   180
            Picture         =   "Bac_Interfaz.frx":0000
            ScaleHeight     =   330
            ScaleWidth      =   375
            TabIndex        =   21
            Top             =   150
            Width           =   375
         End
         Begin VB.PictureBox ConCheck 
            BorderStyle     =   0  'None
            Height          =   270
            Index           =   0
            Left            =   165
            Picture         =   "Bac_Interfaz.frx":015A
            ScaleHeight     =   270
            ScaleWidth      =   330
            TabIndex        =   20
            Top             =   150
            Visible         =   0   'False
            Width           =   330
         End
         Begin VB.PictureBox SinCheck 
            BorderStyle     =   0  'None
            Height          =   270
            Index           =   1
            Left            =   150
            Picture         =   "Bac_Interfaz.frx":02B4
            ScaleHeight     =   270
            ScaleWidth      =   375
            TabIndex        =   19
            Top             =   495
            Width           =   375
         End
         Begin VB.PictureBox ConCheck 
            BorderStyle     =   0  'None
            Height          =   315
            Index           =   1
            Left            =   150
            Picture         =   "Bac_Interfaz.frx":040E
            ScaleHeight     =   315
            ScaleWidth      =   330
            TabIndex        =   18
            Top             =   495
            Visible         =   0   'False
            Width           =   330
         End
         Begin Threed.SSPanel Pnl_Progreso 
            Height          =   750
            Left            =   30
            TabIndex        =   25
            Top             =   90
            Visible         =   0   'False
            Width           =   3660
            _Version        =   65536
            _ExtentX        =   6456
            _ExtentY        =   1323
            _StockProps     =   15
            Caption         =   "SSPanel2"
            ForeColor       =   16777215
            BackColor       =   9476264
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            BevelOuter      =   1
            FloodType       =   1
            FloodColor      =   0
         End
         Begin VB.Label Label3 
            AutoSize        =   -1  'True
            Caption         =   "Interfaz Contable en Moneda Origen"
            Height          =   195
            Left            =   870
            TabIndex        =   23
            Top             =   540
            Width           =   2565
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "Interfaz Contable en Moneda  Peso"
            Height          =   195
            Left            =   885
            TabIndex        =   22
            Top             =   195
            Width           =   2505
         End
      End
      Begin Threed.SSCommand SSCommand1 
         Height          =   660
         Left            =   3855
         TabIndex        =   8
         Top             =   3210
         Width           =   825
         _Version        =   65536
         _ExtentX        =   1455
         _ExtentY        =   1164
         _StockProps     =   78
         ForeColor       =   -2147483630
         Picture         =   "Bac_Interfaz.frx":0568
      End
      Begin VB.Frame Frame1 
         Height          =   615
         Left            =   120
         TabIndex        =   12
         Top             =   3030
         Visible         =   0   'False
         Width           =   3735
         Begin VB.ComboBox cmbMes 
            Height          =   315
            Left            =   465
            Style           =   2  'Dropdown List
            TabIndex        =   14
            Top             =   240
            Width           =   1590
         End
         Begin VB.ComboBox cmbAño 
            Height          =   315
            Left            =   2490
            Style           =   2  'Dropdown List
            TabIndex        =   13
            Top             =   240
            Width           =   1185
         End
         Begin VB.Label lblEtiqueta 
            AutoSize        =   -1  'True
            Caption         =   "Mes"
            BeginProperty Font 
               Name            =   "Times New Roman"
               Size            =   9
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   225
            Index           =   1
            Left            =   60
            TabIndex        =   16
            Top             =   330
            Width           =   330
         End
         Begin VB.Label lblEtiqueta 
            AutoSize        =   -1  'True
            Caption         =   "Año"
            BeginProperty Font 
               Name            =   "Times New Roman"
               Size            =   9
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   225
            Index           =   2
            Left            =   2130
            TabIndex        =   15
            Top             =   330
            Width           =   315
         End
      End
      Begin MSComctlLib.ProgressBar Prg 
         Height          =   345
         Left            =   135
         TabIndex        =   9
         Top             =   3600
         Visible         =   0   'False
         Width           =   3675
         _ExtentX        =   6482
         _ExtentY        =   609
         _Version        =   393216
         Appearance      =   1
      End
      Begin VB.TextBox Text1 
         Height          =   315
         Left            =   3195
         TabIndex        =   7
         Text            =   "Text1"
         Top             =   1725
         Visible         =   0   'False
         Width           =   1275
      End
      Begin BACControles.TXTFecha txt_fec1 
         Height          =   315
         Left            =   1785
         TabIndex        =   24
         Top             =   3285
         Visible         =   0   'False
         Width           =   1380
         _ExtentX        =   2434
         _ExtentY        =   556
         Enabled         =   -1  'True
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "14/12/2001"
      End
      Begin VB.Label Label2 
         Caption         =   "Creando Informe..."
         ForeColor       =   &H000000FF&
         Height          =   180
         Left            =   120
         TabIndex        =   10
         Top             =   3360
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
      Height          =   630
      Left            =   3855
      TabIndex        =   0
      Top             =   4350
      Visible         =   0   'False
      Width           =   1110
      _ExtentX        =   1958
      _ExtentY        =   1111
      _Version        =   393216
   End
End
Attribute VB_Name = "Bac_Interfaz"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Dim Datos()
Dim Folio As Long
Dim NombreArchivo As String
Dim CPrg As Integer 'Contador Barra Progreso
Dim Glosa As String
Dim Numero As Integer
Dim i As Double
Dim p As Double
Dim Linea As String
Public Interfaz As String
Dim Deci As String
Dim Monto As Double

Private Sub C14()
        
        Prg.Value = 0
        CPrg = 0
        Label2.Visible = True
        Prg.Visible = True 'Barra
        Sql = ""
        envia = Array("")
                
        
         If Not Bac_Sql_Execute("SP_INTERFAZ_C14") Then
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
           
            Do While Bac_SQL_Fetch(Datos())
                
                 Linea = ""
                 Linea = Format(gsBac_Fecp, "yyyymmdd") & "TR" & Ceros(Trim(Datos(1)), 9) & Trim(Datos(1)) & Trim(Datos(6))
                 Linea = Linea & Trim(Datos(2)) & ESPACIOS(Trim(Datos(2)), 10)
                 Linea = Linea & Ceros(Trim(Datos(3)), 3) & Trim(Datos(3))
                 
                 Linea = Linea & Ceros(Int(Datos(4)), 14) & Int(Datos(4))
                 Deci = SacaDecim(Round(CDbl(Datos(4)) - Int(Datos(4)), 4))
                 Linea = Linea & Trim(Deci) & Ceros(Trim(Deci), 4)
                 
                 
                 Linea = Linea & Trim(Datos(5))
                                  
                 p = p + 1
                 Print #1, Linea
                 Prg.Max = p
                 BacControlWindows 20
                 Prg.Value = p
            Loop
            Close #1
            Screen.MousePointer = 0
            MsgBox ("Interfaz C14 Generada Correctamente  "), vbInformation, ("BacTrader")
            Prg.Visible = False
            Label2.Visible = False
            
            
'''            If Not Enviar_por_ftp(gsBac_DIRIN, "TRC14C15.TXT") Then
'''                 MsgBox "Interfaz " & cNomArchivo & "  via FTP no fue traspasada ", vbCritical
'''             End If
            
            
         End If




End Sub


Private Sub Art57()
        
        Prg.Value = 0
        CPrg = 0
        Label2.Visible = True
        Prg.Visible = True
        envia = Array(cmbAño)
        
        If Not Bac_Sql_Execute("SP_INTCERSII", envia) Then
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
           
            Do While Bac_SQL_Fetch(Datos())
                
                  Linea = Datos(1)
                  Linea = Linea & Datos(2)
                  Linea = Linea & Datos(3) & ESPACIOS(Trim(Datos(3)), 30)         'Cliente
                  Linea = Linea & Datos(4)
                  Linea = Linea & Datos(5)
                  Linea = Linea & Datos(6) & ESPACIOS(Trim(Datos(6)), 30)         'Direccion
                  Linea = Linea & Datos(7)
                  Linea = Linea & Datos(8)
                  Linea = Linea & Datos(9)
                  Linea = Linea & Datos(10)

                  If Datos(7) = "998" Then
                     Linea = Linea & Ceros(Int(Datos(11)), 11) & Int(Datos(11))      ' Valor Inicio
                     Deci = SacaDecim(Round(CDbl(Datos(11)) - Int(Datos(11)), 4))
                     Linea = Linea & Trim(Deci) & Ceros(Trim(Deci), 4)
                  Else
                     Linea = Linea & Ceros(Int(Datos(11)), 13) & Int(Datos(11))      ' Valor Inicio
                     Deci = SacaDecim(Round(CDbl(Datos(11)) - Int(Datos(11)), 2))
                     Linea = Linea & Trim(Deci) & Ceros(Trim(Deci), 2)
                  End If

                  If Datos(7) = "998" Then
                     Linea = Linea & Ceros(Int(Datos(12)), 11) & Int(Datos(12))      ' Intereses
                     Deci = SacaDecim(Round(CDbl(Datos(12)) - Int(Datos(12)), 4))
                     Linea = Linea & Trim(Deci) & Ceros(Trim(Deci), 4)
                  Else
                     Linea = Linea & Ceros(Int(Datos(12)), 13) & Int(Datos(12))      ' Intereses
                     Deci = SacaDecim(Round(CDbl(Datos(12)) - Int(Datos(12)), 2))
                     Linea = Linea & Trim(Deci) & Ceros(Trim(Deci), 2)
                  End If

                  If Datos(7) = "998" Then
                     Linea = Linea & Ceros(Int(Datos(13)), 11) & Int(Datos(13))      ' Valor Vcto
                     Deci = SacaDecim(Round(CDbl(Datos(13)) - Int(Datos(13)), 4))
                     Linea = Linea & Trim(Deci) & Ceros(Trim(Deci), 4)
                  Else
                     Linea = Linea & Ceros(Int(Datos(13)), 13) & Int(Datos(13))      ' Valor Vcto
                     Deci = SacaDecim(Round(CDbl(Datos(13)) - Int(Datos(13)), 2))
                     Linea = Linea & Trim(Deci) & Ceros(Trim(Deci), 2)
                  End If

                  Linea = Linea & Ceros(Int(Datos(14)), 2) & Int(Datos(14))      ' Tasa Pacto
                  Deci = SacaDecim(Round(CDbl(Datos(14)) - Int(Datos(14)), 2))
                  Linea = Linea & Trim(Deci) & Ceros(Trim(Deci), 2)

                  Linea = Linea & Ceros(Int(Datos(15)), 5) & Int(Datos(15))      ' Valor UM Inicio
                  Deci = SacaDecim(Round(CDbl(Datos(15)) - Int(Datos(15)), 2))
                  Linea = Linea & Trim(Deci) & Ceros(Trim(Deci), 2)

                  Linea = Linea & Ceros(Int(Datos(16)), 5) & Int(Datos(16))       ' Valor UM Vcto
                  Deci = SacaDecim(Round(CDbl(Datos(16)) - Int(Datos(16)), 2))
                  Linea = Linea & Trim(Deci) & Ceros(Trim(Deci), 2)

                  Linea = Linea & Datos(17) ' En Duro
                                                   
                 p = p + 1
                 Print #1, Linea
                 Prg.Max = p
                 BacControlWindows 20
                 Prg.Value = p
            Loop
            Close #1
            Screen.MousePointer = 0
            MsgBox ("Interfaz ART57 Generada Correctamente  "), vbInformation, ("BacTrader")
            Prg.Visible = False
            Label2.Visible = False
            
            
''            If Not Enviar_por_ftp(gsBac_DIRIN, "ART57.TXT") Then
''                             MsgBox "Interfaz " & NOMBRE & "  via FTP no fue traspasada ", vbCritical
''            End If
         End If

         cmbMes.Visible = False
         lblEtiqueta(1).Visible = False

End Sub

Sub CLIENTE1()

Dim cLine          As String
Dim cNomArchivo    As String
Dim cDia           As String
Dim cruta          As String
Dim Datos
Dim Punto          As String
Dim p              As Long
Dim Conta          As Integer
Dim sw             As Integer
Dim NroFax         As String
Dim NumeroFax      As String
Dim nrotel         As String
Dim NumeroTel      As String
Dim nrocal         As String
Dim nrocalidad     As String
 
On Error GoTo Herror1
    X = 0
    Punto = "."
    cDia = Format(gsBac_Fecp, "YYMMDD")
    cNomArchivo = gsBac_DIRIN & "\" & NombreArchivo '& ".DAT"
    MousePointer = 11
 
    Sql = "Sp_interfaz_cliente"
  
    If Not Bac_Sql_Execute(Sql) Then
        MsgBox "Problemas al ejecutar procedimiento " & Sql, vbCritical, "MENSAJE"
        Exit Sub
    End If

    CPrg = 0
 
    Prg.Visible = True
    Prg.Value = 0
    p = 0

    If Dir(cNomArchivo) <> "" Then
        Kill cNomArchivo
    End If

    Open cNomArchivo For Output As #1

Do While Bac_SQL_Fetch(Datos)
    
    If Prg.Max >= 10 Then Prg.Max = Datos(19)
          
    If Len(Datos(14)) > 1 Then
        nrocal = Mid$(Datos(14), 1, 1)
        nrocalidad = nrocal
    Else
       nrocalidad = Datos(14)
    End If
        
    If Len(Datos(11)) > 11 Then
        nrotel = Mid$(Datos(11), 1, 7)
        NumeroTel = Format(Val(nrotel), "00000000000")
    Else
       NumeroTel = Format(Val(Datos(11)), "00000000000")
    End If
    
    If Len(Datos(15)) > 11 Then
        NroFax = Mid$(Datos(15), 1, 7)
        NumeroFax = Format(Val(NroFax), "00000000000")
    Else
       NumeroFax = Format(Val(Datos(15)), "00000000000")
    End If
    
    If Datos(16) = 0 Then
        If Datos(1) < 50000000 Then
            Datos(16) = "5801"
        Else
            Datos(16) = ""
        End If
   End If
    
    cLine = ""
    
    cLine = cLine & ESPACIOS_CL((Datos(1)) + Datos(2), 15, "D") & Format(Datos(3), "00000000") & IIf(Datos(4) = "0", Space(8), ESPACIOS_CL(Trim(Datos(4)), 8, "D")) & ESPACIOS_CL((Datos(5)), 40, "D")
    
    cLine = cLine & ESPACIOS_CL((Datos(6)), 20, "D") & ESPACIOS_CL((Datos(7)), 20, "D") & ESPACIOS_CL((Datos(8)), 40, "D") & Space(40)
    
    cLine = cLine & IIf(Datos(9) = "0", Space(8), ESPACIOS_CL((Datos(9)), 8, "D")) & IIf(Datos(10) = "0", Space(8), ESPACIOS_CL((Datos(10)), 8, "D")) & NumeroTel
    
    cLine = cLine & Space(40) & Space(40) & Space(8) & Space(8) & Ceros("", 11) & Space(1) & Space(8) & ESPACIOS_CL((Datos(23)), 8, "D") & ESPACIOS_CL("9999", 8, "D")
    
    cLine = cLine & "0000" & Space(8) & "00" & Space(8) & Space(15) & Space(40) & Space(20) & Space(20)
'    If datos(12) = "" Then
'      p = p
'    End If
    cLine = cLine & IIf(Datos(12) = "", Space(8), Format(Datos(12), "YYYYMMDD")) & IIf(Datos(21) = "", Space(8), ESPACIOS_CL((Datos(21)), 8, "I")) & ESPACIOS_CL((Datos(20)), 1, "D") & Format(Val(Datos(13)), "0") & IIf(nrocalidad = "0", Space(8), ESPACIOS_CL((nrocalidad), 8, "D")) & NumeroFax
    
    cLine = cLine & ESPACIOS_CL("MDIN", 8, "D") & ESPACIOS_CL((Datos(22)), 8, "D") & ESPACIOS_CL("MDIN", 8, "D") & ESPACIOS_CL((Datos(16)), 8, "D") & IIf(Datos(17) = "0", Space(8), ESPACIOS_CL((Datos(17)), 8, "D")) & Space(8)
    
    cLine = cLine & Space(1) & ESPACIOS_CL((Datos(18)), 4, "D") & Space(30) & Space(8) & Space(1) & Ceros("", 11) & Ceros("", 8) & Ceros("", 8) & Ceros("", 8) & Ceros("", 8) & Ceros("", 14)
    
    cLine = cLine & "6" & Space(40)
                                     
     If Len(cLine) <> 694 Then
            p = p
     End If
     
    p = p + 1
    Print #1, cLine
    Prg.Max = p
    BacControlWindows 20
    Prg.Value = p
Loop
Close #1
Screen.MousePointer = 0
MsgBox "Interfaz de Clientes  Generada" & " " & cNomArchivo & "(Cant.Reg. " & p & ")", vbOKOnly, "MENSAJE"
Prg.Visible = False
Label2.Visible = False
'If Not Enviar_por_ftp(gsBac_DIRIN, "CLIENTE.TXT") Then
    '    MsgBox "Interfaz " & NOMBRE & "  via FTP no fue traspasada ", vbCritical
'End If

   MousePointer = 0
   Exit Sub
   
Herror1:
   MsgBox "Error: " & err.Number & " Descripción: " & err.Description, vbCritical, "Interfaz"
   Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "ERROR Interfaz de Clientes  NO REALIZADA  " & cNomArchivo & err.Number & " Descripción: " & err.Description)
   MousePointer = 0

End Sub

Sub InterfazBalance(NombreArchivo As String)

 Dim total          As Long
 Dim totalreg       As Long
 Dim cDia           As String
 Dim cNomArchivo    As String
 Dim cLine          As String
 Dim nrotel         As String
 Dim NumeroTel      As String
 
 On Error GoTo Herror1
 total = 0
 totalreg = 0
 cNomArchivo = ""
 cDia = Format(gsBac_Fecp, "yymmdd")
 cNomArchivo = NombreArchivo '& ".DAT"

 If Not Bac_Sql_Execute("Sp_interfaz_Balance_Bonos") Then
    MsgBox "Problemas al leer operaciones", vbCritical, "MENSAJE"
    Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "ERROR interfaz  de  Balance  NO REALIZADA  " & cNomArchivo & err.Number & " Descripción: " & err.Description)
    Exit Sub
 End If
  
 If Dir(cNomArchivo) <> "" Then
    Kill cNomArchivo
 End If

   Open cNomArchivo For Output As #1
      
   Do While Bac_SQL_Fetch(Datos())
      
     cLine = ""
     cLine = cLine & BacPad((Datos(2)), 3)
     cLine = cLine & Format(Datos(3), "YYYYMMDD")
     cLine = cLine & BacPad((Datos(4)), 14)
     cLine = cLine & Datos(5)
     cLine = cLine & Datos(6)
     cLine = cLine & Datos(7)
     cLine = cLine & BacPad((Datos(8)), 16)
     cLine = cLine & Space(1)
     cLine = cLine & Datos(10)
     cLine = cLine & BacPad((Datos(11)), 20)
     cLine = cLine & Datos(12)
     cLine = cLine & Datos(14) + String(16 - Len(Datos(14)), "0") + "    "
     cLine = cLine & Datos(13)
     cLine = cLine & Datos(15)
     cLine = cLine & BacPad((Datos(16)), 3)
     cLine = cLine & Datos(17)

     cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(18))), "0000000000000000.00"), gsBac_PtoDec, "") '25
     cLine = cLine & Datos(19)

     cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(20))), "0000000000000000.00"), gsBac_PtoDec, "") '25
     cLine = cLine & Datos(21)

     cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(22))), "0000000000000000.00"), gsBac_PtoDec, "") '25
     cLine = cLine & BacPad((Datos(23)), 3)
     cLine = cLine & BacPad((Datos(24)), 10)
     
     totalreg = totalreg + 1
    
   
    Print #1, cLine
    Loop
    cLine = ""
    totalreg = totalreg + 1
    cLine = cLine & "99" & Format(gsBac_Fecp, "yyyymmdd") & Format(totalreg, "0000000000") & Space(158)
    Print #1, cLine
    Close #1
        
    'MsgBox "Interfaz Generada" & " " & cNomArchivo, vbOKOnly, TITSISTEMA
    
    MsgBox "Ha sido generada la interfaz    : " & cNomArchivo & vbCrLf & "Cantidad de registros           : " & totalreg, vbInformation, "Interfaz de Balance de Operaciones"
    
   Exit Sub
   
Herror1:
   MsgBox "Error: " & err.Number & " Descripción: " & err.Description, vbCritical, "Interfaz"
   Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "ERROR interfaz  de  Balance  NO REALIZADA  " & cNomArchivo & err.Number & " Descripción: " & err.Description)
   Exit Sub

End Sub

Sub InterfazDeudores(NombreArchivo As String)
 Dim total          As Integer
 Dim totalreg       As Integer
 Dim cDia           As String
 Dim cNomArchivo    As String
 Dim cLine          As String
 Dim NumeroTel      As String

 On Error GoTo Herror1
 total = 0
 totalreg = 0
 cNomArchivo = ""
 cDia = Format(gsBac_Fecp, "yymmddy")
  cNomArchivo = NombreArchivo '& ".DAT"

 If Not Bac_Sql_Execute("Sp_Interfaz_deudores_bonos") Then
    MsgBox "Problemas al leer operaciones", vbCritical, "MENSAJE"
    Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "ERROR interfaz  de  Deudores  NO REALIZADA  " & cNomArchivo & err.Number & " Descripción: " & err.Description)
    Exit Sub
 End If
  
 CPrg = 0
 
 'Prg.Visible = True
 'Prg.Value = 0
 p = 0

 If Dir(cNomArchivo) <> "" Then
    Kill cNomArchivo
 End If

 Open cNomArchivo For Output As #1
   
 Do While Bac_SQL_Fetch(Datos())
 
     rut = BacValidaRut((Datos(4)), 0)
     dig = devolver
      
     rut1 = BacValidaRut((Datos(2)), 0)
     dig1 = devolver
      
     cLine = ""
     cLine = cLine & BacPad((Datos(2) + dig1), 15) & BacPad((Datos(3)), 16) & BacPad((Datos(4) + dig), 15)
     cLine = cLine & Datos(5) & Datos(6) & BacStrTran(Format$(Val(bacTranMontoSql(Datos(7))), "000.00"), gsBac_PtoDec, "") & Datos(8)
     'Format(saca_punto(Trim(Str(datos(7))), 2), "00000") & datos(8)

     

    totalreg = totalreg + 1
    Print #1, cLine
    
    Loop
    
    Close #1
       
    MsgBox "Interfaz Generada" & " " & cNomArchivo, vbOKOnly, TITSISTEMA
    'Prg.Visible = False
    'Label2.Visible = False
    Exit Sub
   
Herror1:
  MsgBox "Error: " & err.Number & " Descripción: " & err.Description, vbCritical, "Interfaz"
  Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "ERROR interfaz  de  Deudores  NO REALIZADA  " & cNomArchivo & err.Number & " Descripción: " & err.Description)
  Exit Sub

End Sub

Sub InterfazDirecciones(NombreArchivo As String)
 Dim total          As Integer
 Dim totalreg       As Integer
 Dim cDia           As String
 Dim cNomArchivo    As String
 Dim cLine          As String
 Dim NumeroTel      As String
 Dim nrotel         As String
 On Error GoTo Herror1
     total = 0
     totalreg = 0
     cNomArchivo = ""
  cDia = Format(gsBac_Fecp, "yymmdd")
  cNomArchivo = NombreArchivo '& ".DAT"

 If Not Bac_Sql_Execute("Sp_Interfaz_direcciones_bonos") Then
    MsgBox "Problemas al leer operaciones", vbCritical, "MENSAJE"
    Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "ERROR interfaz  de  Direcciones  NO REALIZADA  " & cNomArchivo & err.Number & " Descripción: " & err.Description)
    Exit Sub
 End If
  
  If Dir(cNomArchivo) <> "" Then
    Kill cNomArchivo
 End If

 Open cNomArchivo For Output As #1
   
 Do While Bac_SQL_Fetch(Datos())
 
    If Len(Datos(10)) > 11 Then
        nrotel = Mid$(Datos(10), 1, 7)
        NumeroTel = Format(Val(nrotel), "00000000000")
    Else
       NumeroTel = Format(Val(Datos(10)), "00000000000")
    End If
   
     cLine = ""
     cLine = cLine & BacPad((Datos(3) + Datos(4)), 15)
     cLine = cLine & BacPad((Datos(1)), 8)
     cLine = cLine & BacPad((Datos(2)), 8)
     cLine = cLine & BacPad((Datos(5)), 16)
     cLine = cLine & BacPad((Datos(7)), 40)
     cLine = cLine & Space(40)
     cLine = cLine & BacPad((Datos(8)), 8)
     cLine = cLine & BacPad((Datos(9)), 8)
     cLine = cLine & IIf(NumeroTel = 0, "00000000000", NumeroTel)
     cLine = cLine & Format(Datos(11), "YYYYMMDD")
         
     If Len(cLine) <> 162 Then
           
     End If
     
    totalreg = totalreg + 1
    Print #1, cLine
    Loop
    
    Close #1
       
    MsgBox "Interfaz Generada" & " " & cNomArchivo, vbOKOnly, TITSISTEMA
    'Label2.Visible = False
    Exit Sub
   
Herror1:
  MsgBox "Error: " & err.Number & " Descripción: " & err.Description, vbCritical, "Interfaz"
  Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "ERROR interfaz  de  Direcciones  NO REALIZADA  " & cNomArchivo & err.Number & " Descripción: " & err.Description)
  Exit Sub

End Sub


Sub InterfazFlujos(NombreArchivo As String)
 Dim total          As Integer
 Dim totalreg       As Integer
 Dim cDia           As String
 Dim cNomArchivo    As String
 Dim cLine          As String
  
 On Error GoTo Herror1
     total = 0
     totalreg = 0
     cNomArchivo = ""
     cDia = Format(gsBac_Fecp, "yymmdd")
     cNomArchivo = NombreArchivo '& ".DAT"
    
     If Not Bac_Sql_Execute("Sp_interfaz_neosoft_flujo") Then
        MsgBox "Problemas al leer operaciones", vbCritical, TITSISTEMA
        Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "ERROR interfaz  de  Flujos  NO REALIZADA  " & cNomArchivo & err.Number & " Descripción: " & err.Description)
        Exit Sub
     End If
      
     If Dir(cNomArchivo) <> "" Then
        Kill cNomArchivo
     End If
    
    'Open cNomArchivo For Binary Access Write As #1
    Open cNomArchivo For Output As #1
      
    Do While Bac_SQL_Fetch(Datos())
        cLine = ""
        cLine = cLine & BacPad((Datos(1)), 3)                                          ' 1
        cLine = cLine & Datos(2)                                                       ' 2
        cLine = cLine & BacPad((Datos(3)), 14)                                         ' 3
        cLine = cLine & Datos(4)                                                       ' 4
        cLine = cLine & BacPad((Datos(5)), 16)                                         ' 5
        cLine = cLine & BacPad((Datos(6)), 20)                                         ' 6
        cLine = cLine & Format((Datos(7)), "YYYYMMDD")                                 ' 7
        cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(8))), "0000000000000000.00"), gsBac_PtoDec, "") '8
        cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(9))), "0000000000000000.00"), gsBac_PtoDec, "") '9
        cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(10))), "0000000000000000.00"), gsBac_PtoDec, "") '10
        cLine = cLine & BacPad((Datos(11)), 3)                                         '11
        cLine = cLine & Space(10) '+ Chr(13) + Chr(10)                                 '12
        totalreg = totalreg + 1
        
        If Len(cLine) <> 139 Then
           totalreg = totalreg
        End If
                
        Print #1, cLine
        'Put #1, , cLine
        
    Loop
    
    cLine = ""
    totalreg = totalreg + 1
    cLine = cLine & "99" & Format(gsBac_Fecp, "yyyymmdd") & Format(totalreg, "0000000000") & Space(119)
    Print #1, cLine
    'Put #1, , cLine
    Close #1
        
    MsgBox "Interfaz Generada" & " " & cNomArchivo, vbOKOnly, TITSISTEMA
    Exit Sub
   
Herror1:
   MsgBox "Error: " & err.Number & " Descripción: " & err.Description, vbCritical, "Interfaz"
   Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "ERROR interfaz  de  Flujos  NO REALIZADA  " & cNomArchivo & err.Number & " Descripción: " & err.Description)
   Exit Sub

End Sub

Public Function InterfazP40() As String
   On Error GoTo ErrOpen
   Dim ofilename  As String
   Dim nRegistros As Long
   Dim nContador  As Long
   Dim Linea      As String
   
   Let ofilename = Directorio.Path & "\ND51" & Format(txt_fec1.Text, "YYMMDD") & ".DAT"
   
   Screen.MousePointer = vbHourglass
   nContador = 1
   Pnl_Progreso.Visible = True
   
   envia = Array()
   AddParam envia, Format(txt_fec1.Text, "yyyymmdd")
   If Not Bac_Sql_Execute("SP_INTERFAZ_P40_BANCO_MX", envia) Then
      Screen.MousePointer = vbDefault
   End If

   If Dir(ofilename) <> "" Then
      Call Kill(ofilename)
   End If

   Open ofilename For Append As #1

   Do While Bac_SQL_Fetch(Datos())
      nRegistros = Datos(37)

      Linea = ""
      Linea = Linea & ESPACIOS_CL(Trim(Datos(1)), 3, "D")                                 '--> Codigo ISO del Pais
      Linea = Linea & ESPACIOS_CL(Trim(Datos(2)), 8, "D")                                 '--> Fecha de la Interfaz
      Linea = Linea & ESPACIOS_CL(Trim(Datos(3)), 14, "D")                                '--> N° de Identificador de la Fuente
      Linea = Linea & ESPACIOS_CL(Trim(Datos(4)), 3, "D")                                 '--> Codigo de la Empresa
      Linea = Linea & ESPACIOS_CL(Trim(Datos(5)), 16, "D")                                '--> Codigo Interno del Producto
      Linea = Linea & ESPACIOS_CL(Trim(Datos(6)), 8, "D")                                 '--> Fecha Contable
      Linea = Linea & ESPACIOS_CL(Trim(Datos(36)), 20, "D")                               '--> Numero de la Operacion
      Linea = Linea & ESPACIOS_CL(Trim(Datos(10)), 12, "D")                               '--> Identificador del Tenedor
      Linea = Linea & ESPACIOS_CL(Trim(Val(Datos(11))), 1, "D")                           '--> Tipo de Registro
      Linea = Linea & ESPACIOS_CL(Trim(Datos(12)), 2, "D")                                '--> Familia de Instrumento
      Linea = Linea & ESPACIOS_CL(Trim(Datos(13)), 1, "D")                                '--> Tipo
      Linea = Linea & ESPACIOS_CL(Trim(Datos(14)), 8, "D")                                '--> Fecha Proximo Corte de Cupon
      Linea = Linea & ESPACIOS_CL(Trim(Datos(15)), 2, "D")                                '--> Derivados Incrustados
      Linea = Linea & Format(saca_punto(Trim(Str(Datos(16))), 4), "000000000000000000")   '--> Nominal Actual
      Linea = Linea & ESPACIOS_CL(Trim(Datos(17)), 4, "D")                                '--> Moneda Reajustable
      Linea = Linea & ESPACIOS_CL(Trim(Datos(18)), 7, "D")                                '--> Tipo Tasa Emision
      Linea = Linea & Format(saca_punto(Trim(Str(Datos(19))), 8), "0000000000000000")     '--> Tera
      Linea = Linea & Format(saca_punto(Trim(Str(Datos(20))), 4), "000000000000000000")   '--> Valor Par
      Linea = Linea & ESPACIOS_CL(Trim(Datos(21)), 7, "D")                                '--> Tipo de Tasa Compra
      Linea = Linea & Trim(Datos(38))                                                     '--> Signo de Tasa de Compra
      Linea = Linea & Format(saca_punto(Trim(Str(Datos(22))), 8), "000000000000000")      '--> Tasa de Compra       ( Cambia Lago de 16 a 15 )
      Linea = Linea & Format(saca_punto(Trim(Str(Datos(23))), 4), "000000000000000000")   '--> Costo de Adquisicion
      Linea = Linea & Format(saca_punto(Trim(Str(Datos(24))), 4), "000000000000000000")   '--> Costo Amortizado
      Linea = Linea & ESPACIOS_CL(Trim(Datos(25)), 7, "D")                                '--> Tipo de tasa de valorizacion
      Linea = Linea & Trim(Datos(39))                                                     '--> Signo de Tasa de Valorizacion
      Linea = Linea & Format(saca_punto(Trim(Str(Datos(26))), 8), "000000000000000")      '--> Tasa de Valorizacion ( Cambia Lago de 16 a 15 )
      Linea = Linea & ESPACIOS_CL(Trim(Datos(27)), 1, "D")                                '--> Tipo de Valorizacion
      Linea = Linea & Format(saca_punto(Trim(Str(Datos(28))), 8), "0000000000000000")     '--> Precio del Instrumento
      
      Linea = Linea & Format(saca_punto(Trim(Str(Datos(29))), 8), "0000000000000000")     '--> Duracion Modificada
      Linea = Linea & Format(saca_punto(Trim(Str(Datos(30))), 8), "0000000000000000")     '--> Convexidad
      Linea = Linea & Format(saca_punto(Trim(Str(Datos(31))), 2), "000000000000000000")   '--> Valor del Deterioro
      Linea = Linea & ESPACIOS_CL(Trim(Datos(32)), 1, "D")                                '--> Condicion del Instrumento
      Linea = Linea & ESPACIOS_CL(Trim(Datos(33)), 8, "D")                                '--> Fecha Inicio Condicion
      Linea = Linea & ESPACIOS_CL(Trim(Datos(34)), 8, "D")                                '--> Fecha Termino Condicion
      Linea = Linea & ESPACIOS_CL(Trim(Datos(35)), 20, "D")                               '--> Nemotecnico del instrumento

      Print #1, Linea

      Pnl_Progreso.FloodPercent = (nContador / nRegistros) * 100 '--> ActualizarBarra(CDbl(p), CDbl(nTotalRegistros))

      nContador = nContador + 1
      Call BacControlWindows(2)
   Loop

   Close #1
   Screen.MousePointer = vbDefault

   MsgBox "Proceso Finalizado" & vbCrLf & vbCrLf & "Interfaz P-40 (Siguir) Generada Correctamente.-", vbInformation, App.Title

   Pnl_Progreso.FloodPercent = 0

   On Error GoTo 0
Exit Function
ErrOpen:
   MsgBox "Proceso Cancelado." & vbCrLf & vbCrLf & "ERROR " & err.Number & " (" & err.Description & ")" & vbCrLf & vbCrLf & "Interfaz P-40. NO Generada.", vbCritical, App.Title
   Close #1
   
   On Error GoTo 0
End Function


Sub InterfazOperaciones(NombreArchivo As String)
    Dim total          As Long
    Dim totalreg       As Long
    Dim cDia           As String
    Dim cNomArchivo    As String
    Dim cLine          As String
    Dim ValorTasa      As Double  '-- MAP 2016-06-17
    Dim ValorTasaStr   As String  '-- MAP 2016-06-17
    

    On Error GoTo Herror1
    
    total = 0
    totalreg = 0
    cNomArchivo = ""
    cDia = Format(gsBac_Fecp, "yymmdd")
    cNomArchivo = NombreArchivo ' & "OP51" & cDia & ".DAT"

    If Not Bac_Sql_Execute("Sp_interfaz_Operaciones_bonos") Then
        MsgBox "Problemas al leer operaciones", vbCritical, "MENSAJE"
        Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "ERROR interfaz  de  Operaciones  NO REALIZADA  " & cNomArchivo & err.Number & " Descripción: " & err.Description)
        Exit Sub
    End If
    
    Pnl_Progreso.Visible = True
    Pnl_Progreso.FloodPercent = 0
    
    If Dir(cNomArchivo) <> "" Then
        Kill cNomArchivo
    End If

    'Open cNomArchivo For Binary Access Write As #1
    Open cNomArchivo For Output As #1
  
    Do While Bac_SQL_Fetch(Datos())
        cLine = ""
        cLine = cLine & BacPad((Datos(1)), 3)               '1
        cLine = cLine & Format((Datos(2)), "YYYYMMDD")      '2
        cLine = cLine & Format((Datos(3)), "YYYYMMDD")      '3
        cLine = cLine & BacPad((Datos(4)), 14)              '4
        cLine = cLine & BacPad((Datos(5)), 3)               '5
        cLine = cLine & BacPad((Datos(6)), 3)               '6
        cLine = cLine & BacPad((Datos(7)), 3)               '7
        cLine = cLine & "1"                                 '8
        cLine = cLine & BacPad((Datos(9)), 4)               '9
        cLine = cLine & BacPad((Datos(10)), 4)              '10
        cLine = cLine & BacPad((Datos(11)), 16)             '11
        cLine = cLine & Space(1)                            '12
        cLine = cLine & "M"                                 '13
        cLine = cLine & Format(Datos(14), "YYYYMMDD")       '14
        cLine = cLine & Format(Datos(15), "YYYYMMDD")       '15
        cLine = cLine & BacPad(Datos(16) + Datos(17), 12)   '16
        cLine = cLine & BacPad((Datos(18)), 10)             '17
        cLine = cLine & BacPad((Datos(19)), 20)             '18
        cLine = cLine & Format(Datos(20), "YYYYMMDD")       '19
        cLine = cLine & Format(Datos(21), "YYYYMMDD")       '20
        cLine = cLine & BacPad((Datos(22)), 8)              '21
        cLine = cLine & Datos(23)                           '22
        cLine = cLine & BacPad((Datos(24)), 3)              '23
        cLine = cLine & Datos(25)                           '24
        cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(26))), "0000000000000000.00"), gsBac_PtoDec, "") '25
        cLine = cLine & Datos(27)                                                           '26
        cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(28))), "0000000000000000.00"), gsBac_PtoDec, "") '27
        cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(29))), "0000000000000000.00"), gsBac_PtoDec, "") '28
        cLine = cLine & Datos(30)                           '29
        cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(31))), "0000000000000000.00"), gsBac_PtoDec, "") '30
        cLine = cLine & Datos(32)                           '31
        cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(33))), "0000000000000000.00"), gsBac_PtoDec, "") '32
        cLine = cLine & Datos(34)                           '33
        cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(35))), "0000000000000000.00"), gsBac_PtoDec, "") '34
        cLine = cLine & BacPad((Datos(36)), 2)              '35
        cLine = cLine & BacPad((Datos(37)), 4)              '36
        Let ValorTasa = Datos(38)
        If ValorTasa < 0 Then
            Let ValorTasa = -ValorTasa
            Let ValorTasaStr = BacStrTran(Format$(Val(bacTranMontoSql(ValorTasa)), "00000000.00000000"), gsBac_PtoDec, "")
            Let ValorTasaStr = "-" & Mid(ValorTasaStr, 1, Len(ValorTasaStr) - 1)
        Else
            Let ValorTasaStr = BacStrTran(Format$(Val(bacTranMontoSql(ValorTasa)), "00000000.00000000"), gsBac_PtoDec, "")
        End If
        cLine = cLine & ValorTasaStr '-- BacStrTran(Format$(Val(bacTranMontoSql(Datos(38))), "00000000.00000000"), gsBac_PtoDec, "") '37
        cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(39))), "00000000.00000000"), gsBac_PtoDec, "") '38
        cLine = cLine & Datos(40)                           '39
        cLine = cLine & Format(Datos(41), "0000000000000000") '40
        cLine = cLine & BacPad((Datos(42)), 5)              '41
        cLine = cLine & BacPad((Datos(43)), 4)              '42
        cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(44))), "00000000.00000000"), gsBac_PtoDec, "") '43
        cLine = cLine & Format(Datos(45), "0000000000000000") '44
        cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(46))), "00000000.00000000"), gsBac_PtoDec, "") ' Format(datos(46), "0000000000000000") '45   - spread de tasa penalidad
        cLine = cLine & Datos(47)                           '46
        cLine = cLine & Datos(48)                           '47
        cLine = cLine & Format(Datos(49), "000000000000000000")    '48
        cLine = cLine & Format(Datos(50), "000")            '49
        cLine = cLine & Format(Datos(51), "00")             '50
        cLine = cLine & Format(Datos(52), "0")              '51
        cLine = cLine & Datos(53)                           '52
        cLine = cLine & Format(Datos(54), "000000000000000000") '53
        cLine = cLine & BacPad((Datos(55)), 8)              '54
        cLine = cLine & BacPad((Datos(56)), 8)              '55
        cLine = cLine & BacPad((Datos(57)), 8)              '56
        cLine = cLine & BacPad((Datos(58)), 8)              '57
        cLine = cLine & BacPad((Datos(59)), 20)             '58
        cLine = cLine & Format(Datos(60), "0000")           '59
        cLine = cLine & Format(Datos(61), "0000")           '60
        cLine = cLine & Format(Datos(62), "0000")           '61
        cLine = cLine & Format(Datos(63), "000")            '62
        cLine = cLine & BacPad((Datos(64)), 8)              '63
        cLine = cLine & BacPad((Datos(65)), 8)              '64
        cLine = cLine & BacPad((Datos(66)), 1)              '65
        cLine = cLine & BacPad((Datos(67)), 8)              '66
        cLine = cLine & BacPad((Datos(68)), 8)              '67
        cLine = cLine & BacPad((Datos(69)), 8)              '68
        cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(70))), "0000000000000000.00"), gsBac_PtoDec, "")    '69
        cLine = cLine & Format(Datos(71), "000000000000000000")    '70
        cLine = cLine & Format(Datos(72), "000000000000000000")    '71
        cLine = cLine & Format(Datos(73), "000000000000000000")    '72
        cLine = cLine & Format(Datos(74), "000000000000000000")   '73
        cLine = cLine & Format(Datos(75), "000000000000000000")   '74
        cLine = cLine & Format(Datos(76), "000000000000000000")   '75
        cLine = cLine & Format(Datos(77), "000000000000000000")   '76
        cLine = cLine & BacPad((Datos(78)), 1)                     '77
        cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(79))), "0000000000000000.00"), gsBac_PtoDec, "")    '78
        cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(80))), "0000000000000000.00"), gsBac_PtoDec, "")    '79
        cLine = cLine & Datos(81)                                 '80
        cLine = cLine & Format(Datos(82), "000")                  '81
        cLine = cLine & Format(Datos(83), "0000")                 '82
        cLine = cLine & Format(Datos(84), "000000000000000000")  '83
        cLine = cLine & BacPad((Datos(85)), 1)                            '84
        cLine = cLine & BacPad((Datos(86)), 1)                            '85
        cLine = cLine & BacPad((Datos(87)), 1)                            '86
        cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(88))), "0000000000.00"), gsBac_PtoDec, "")          '87
        cLine = cLine & BacPad((Datos(89)), 5)                            '88
        cLine = cLine & BacPad((Datos(90)), 15)                           '89
        cLine = cLine & BacPad((Datos(91)), 4)                            '90
        cLine = cLine & BacPad((Datos(92)), 4)                           '91
        cLine = cLine & BacPad((Datos(93)), 3) '+ Chr(13) + Chr(10)         '92
        cLine = cLine & Ceros("", 16)
        cLine = cLine & Ceros("", 4)

        '>>>> Agregado con Fecha 18-Agosto-2008.- Cambio Estructura Interfaz Neosoft
        cLine = cLine & Format("0", "000000000000000000") '--> Ceros("0", 18) '--> 95. Monto Mora 4 en Moneda Local (18,2) [90  y -365 Días]
        cLine = cLine & Format("0", "000000000000000000") '--> Ceros("0", 18) '--> 96. Monto Mora 5 en Moneda Local (18,2) [365 y -  3 Años]
        cLine = cLine & Format("0", "000000000000000000") '--> Ceros("0", 18) '--> 97. Monto Mora 6 en Moneda Local (18,2) [3   Años y Mas]
        cLine = cLine & "S"            '--> 98. Indicador Sbif               (1)
        cLine = cLine & Format("0", "000000000000000000") '--> Ceros("0", 18) '--> 99. Otros cobros para Mora       (18,2)

        totalreg = totalreg + 1
        
        Pnl_Progreso.FloodPercent = (totalreg * 100) / Datos(94)
      
        Print #1, cLine
    Loop
    
    cLine = ""
    totalreg = totalreg + 1
    cLine = cLine & "99" & Format(gsBac_Fecp, "yyyymmdd") & Format(totalreg, "0000000000") & Space(786)
    Print #1, cLine
    Close #1
        
    MsgBox "Ha sido generada la interfaz    : " & cNomArchivo & vbCrLf & "Cantidad de registros           : " & totalreg, vbInformation, "Interfaz de Operaciones"
    Pnl_Progreso.Visible = False
    
    Exit Sub
   
Herror1:
   MsgBox "Error: " & err.Number & " Descripción: " & err.Description, vbCritical, "Interfaz"
   Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "ERROR interfaz  de  operaciones  NO REALIZADA  " & cNomArchivo & err.Number & " Descripción: " & err.Description)
   Exit Sub

End Sub

Sub Clientes()

 Dim cLine          As String
 Dim cNomArchivo    As String
 Dim cDia           As String
 Dim cruta          As String
 Dim Datos
 Dim Punto          As String
 Dim p              As Long
 Dim Conta          As Integer
 Dim sw             As Integer
 Dim NroFax         As String
 Dim NumeroFax      As String
 Dim nrotel         As String
 Dim NumeroTel      As String
 Dim nrocal         As String
 Dim nrocalidad     As String
 
 On Error GoTo Herror1
 X = 0
 Punto = "."
 cDia = Format(gsBac_Fecp, "YYMMDD")
 cNomArchivo = gsBac_DIRIN & "\" & NombreArchivo '& ".DAT"
 MousePointer = 11
 
 Sql = "Sp_interfaz_cliente " & "'T'"
  
 If Not Bac_Sql_Execute(Sql) Then
    MsgBox "Problemas al ejecutar procedimiento " & Sql, vbCritical, "MENSAJE"
   Exit Sub
 End If

  CPrg = 0
 
  Prg.Visible = True
  Prg.Value = 0
  p = 0

 If Dir(cNomArchivo) <> "" Then
   Kill cNomArchivo
 End If

Open cNomArchivo For Output As #1
  
For X = 1 To 2
If X = 2 Then
    Close #1
    cLine = ""
    cNomArchivo = ""
    cNomArchivo = gsBac_DIRIN & "\" & "CL15" & cDia & ".DAT"
    Prg.Value = 0
    p = 0
    NOMBRE = ""
    NOMBRE = cNomArchivo
    If Dir(cNomArchivo) <> "" Then
        Kill cNomArchivo
    End If
    Sql = "Sp_interfaz_cliente " & "'F'"
      
     If Not Bac_Sql_Execute(Sql) Then
        MsgBox "Problemas al ejecutar procedimiento " & Sql, vbCritical, "MENSAJE"
       Exit Sub
    End If
    Open cNomArchivo For Output As #1
 End If
  
Do While Bac_SQL_Fetch(Datos)

    If Prg.Max >= 10 Then Prg.Max = Datos(19)
          
    If Len(Datos(14)) > 1 Then
        nrocal = Mid$(Datos(14), 1, 1)
        nrocalidad = Format(Val(nrocal), "0")
    Else
       nrocalidad = Format(Val(Datos(14)), "0")
    End If
        
    If Len(Datos(11)) > 11 Then
        nrotel = Mid$(Datos(11), 1, 7)
        NumeroTel = Format(Val(nrotel), "00000000000")
    Else
       NumeroTel = Format(Val(Datos(11)), "00000000000")
    End If
    
    If Len(Datos(15)) > 11 Then
        NroFax = Mid$(Datos(15), 1, 7)
        NumeroFax = Format(Val(NroFax), "00000000000")
    Else
       NumeroFax = Format(Val(Datos(15)), "00000000000")
    End If
    
    cLine = ""
    
    cLine = cLine & ESPACIOS(Trim(Datos(1)) + Datos(2), 15) & Datos(3) & ESPACIOS(Trim(Datos(4)), 10) & ESPACIOS(Trim(Datos(5)), 40)
    cLine = cLine & ESPACIOS(Trim(Datos(6)), 20) & ESPACIOS(Trim(Datos(7)), 20) & ESPACIOS(Trim(Datos(8)), 40)
    cLine = cLine & ESPACIOS(Trim(Datos(9)), 4) & ESPACIOS(Trim(Datos(10)), 4) & NumeroTel
    cLine = cLine & Space(40) & Space(4) & Space(4) & "00000000000" & Space(1) & Space(8) & Space(1) & "00000000000"
    cLine = cLine & "0000" & "0000" & Space(8) & "00" & Space(1) & Space(15) & Space(40) & Space(20)
    cLine = cLine & Space(20) & Format(Datos(12), "ddmmyyyy") & Datos(20) & Format(Val(Datos(13)), "0") & nrocalidad & NumeroFax
    cLine = cLine & Space(4) & ESPACIOS(Trim(Datos(16)), 4) & ESPACIOS(Trim(Datos(17)), 4) & Space(4)
    cLine = cLine & Space(1) & ESPACIOS(Trim(Datos(18)), 4) & Space(30) & Space(4) & "00000000" & "00000000" & "00000000000000" & Space(1)
    cLine = cLine & Space(40) & Space(1)
    
    p = p + 1
    
    Prg.Value = p
    Print #1, cLine
Loop
If X = 1 Then
    MsgBox "Interfaz de Clientes  Generada" & " " & cNomArchivo & "(Cant.Reg. " & p & ")", vbOKOnly, "MENSAJE"
Else
    MsgBox "Interfaz de Clientes  Generada" & " " & cNomArchivo & "(Cant.Reg. " & p & ")", vbOKOnly, "MENSAJE"
End If
Next X
Close #1
Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Interfaz de Clientes   Ok" & cNomArchivo)
    
   'If Not Enviar_por_ftp(Directorio.Path, cNomArchivo) Then
  '          MsgBox "interfaz " & cNomArchivo & "  via FTP no fue traspasada ", vbCritical
 '  End If
   
   MousePointer = 0
   Exit Sub
   
Herror1:
   MsgBox "Error: " & err.Number & " Descripción: " & err.Description, vbCritical, "Interfaz"
   Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "ERROR Interfaz de Clientes  NO REALIZADA  " & cNomArchivo & err.Number & " Descripción: " & err.Description)
   MousePointer = 0
   
End Sub


Public Sub Colocaciones()
         Monto = 0
         Prg.Value = 0
        CPrg = 0
        Label2.Visible = True
        Prg.Visible = True 'Barra
        Sql = ""
        envia = Array("")
        
        If Not Bac_Sql_Execute("SP_INTERFAZ_COLOCACIONES") Then
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
           
            Do While Bac_SQL_Fetch(Datos())
                
                 Linea = ""
                 Linea = Ceros(Trim(Datos(1)), 9) & Trim(Datos(1))
                 Linea = Linea & Ceros(Trim(Datos(2)), 1) & IIf(IsNull(Datos(2)), "", Trim(Datos(2)))
                 Linea = Linea & Trim(Datos(3)) & ESPACIOS(Trim(Datos(3)), 30)
                 Linea = Linea & Trim(Datos(4)) & ESPACIOS(Trim(Datos(4)), 10) & "D"
                 Linea = Linea & Ceros(Trim(Datos(5)), 9) & Trim(Datos(5))
                 Linea = Linea & Ceros(Trim(Datos(6)), 1) & Trim(Datos(6)) & "00000"
                 
                 Linea = Linea & ESPACIOS(Trim(Datos(7)), 4) & Trim(Datos(7))
                 Linea = Linea & ESPACIOS(Trim(Datos(8)), 8) & Datos(8)
                 
                 Linea = Linea & Ceros(Int(Datos(9)), 14) & Int(Datos(9))
                 Linea = Linea & Ceros(Trim(Datos(10)), 3) & Trim(Datos(10))
                 Linea = Linea & Ceros(Trim(Datos(11)), 3) & Trim(Datos(11))
                 
                            
                 Linea = Linea & Ceros(Int(Datos(12)), 3) & Int(Datos(12))
                 Deci = SacaDecim(Round(Format(Datos(12), "##0.0000") - Int(Datos(12)), 2))
                 Linea = Linea & Mid(Trim(Deci), 1, 2) & Ceros(Trim(Deci), 2) & "00000"
                 
                 Linea = Linea & ESPACIOS(Trim(Datos(13)), 8) & Trim(Datos(13))
                 Linea = Linea & ESPACIOS(Trim(Datos(13)), 8) & Trim(Datos(13))
                                                  
                 If Val(Datos(20)) < 0 Then
                    Linea = Linea & "-" & Ceros(Int(Datos(20)), 14) & Abs(Int(Datos(20)))
                 Else
                    Linea = Linea & Ceros(Int(Datos(20)), 14) & Int(Datos(20))
                 End If
                 
                 Linea = Linea & "01"
                 Linea = Linea & Format(Val(Datos(19)), "000")
                 Linea = Linea & Ceros("", 26) & "IF" & "0071" & "002115" & Ceros("", 14)
                 Linea = Linea & Space(43)
                 Monto = Monto + Datos(20)
                 p = p + 1
                 Print #1, Linea
                 Prg.Max = p
                 BacControlWindows 20
                 Prg.Value = p
            Loop
            
            Linea = ""
            Linea = Space(206) & "IF" & Format(gsBac_Fecp, "yyyymmdd")
            Linea = Linea & Ceros(Trim(p - 1), 8) & Trim(p - 1)
            Linea = Linea & Ceros(Int(Monto), 14) & Int(Monto)
            
            Print #1, Linea
         
            
            Close #1
            Screen.MousePointer = 0
            MsgBox ("Interfaz Colocaciones Generada Correctamente  "), vbInformation, ("BacTrader")
            Prg.Visible = False
            Label2.Visible = False
            
            
''            If Not Enviar_por_ftp(gsBac_DIRIN, "ICOL.TXT") Then
''                             MsgBox "Interfaz " & cNomArchivo & "  via FTP no fue traspasada ", vbCritical
''            End If
         End If
End Sub




Sub InterfazPosicion(NombreArchivo As String)

 Dim total          As Integer
 Dim totalreg       As Integer
 Dim cDia           As String
 Dim cNomArchivo    As String
 Dim cLine          As String
 Dim nrotel         As String
 Dim NumeroTel      As String
 
 On Error GoTo Herror1
 total = 0
 totalreg = 0
 cNomArchivo = ""
 cDia = Format(gsBac_Fecp, "yymmdd")
 cNomArchivo = NombreArchivo '& "PC51" & cDia & ".DAT"

 If Not Bac_Sql_Execute("Sp_interfaz_Posicion_bonos") Then
    MsgBox "Problemas al leer operaciones", vbCritical, "MENSAJE"
    Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "ERROR interfaz  de  Posición  NO REALIZADA  " & cNomArchivo & err.Number & " Descripción: " & err.Description)
    Exit Sub
 End If
  
 If Dir(cNomArchivo) <> "" Then
    Kill cNomArchivo
 End If

   Open cNomArchivo For Output As #1
      
   Do While Bac_SQL_Fetch(Datos())
       
     cLine = ""
     cLine = cLine & Datos(1)                                   '1
     cLine = cLine & Datos(2)                                   '2
     cLine = cLine & BacPad((Datos(3)), 3)                      '3
     cLine = cLine & Format(Datos(4), "0000000000000000")       '4
     cLine = cLine & Format(0, "00000000")                      '5
     cLine = cLine & Format(0, "000000000000")                  '6
     cLine = cLine & Datos(5)                                   '7
     cLine = cLine & Datos(6)                                   '8
     cLine = cLine & Datos(7)                                   '9
     cLine = cLine & Format(Datos(8), "00")                     '10
     cLine = cLine & Format(0, "000000000")                     '11
     cLine = cLine & Space(4)                                   '12
     cLine = cLine & Space(4)                                   '13
     cLine = cLine & BacPad((Datos(9)), 4)                      '14
     cLine = cLine & Space(4)                                   '15
     cLine = cLine & Space(4)                                   '16
     cLine = cLine & IIf(Datos(10) = 0, Space(4), BacPad((Datos(10)), 4))                  '17
     cLine = cLine & BacPad((Datos(11)), 4)                     '18
     cLine = cLine & Space(4)                                   '19
     cLine = cLine & Space(4)                                   '20
     cLine = cLine & Space(6)                                   '21
     cLine = cLine & Space(4)                                   '22
     cLine = cLine & Space(4)                                   '23
     cLine = cLine & Space(4)                                   '24
     cLine = cLine & BacPad("+", 4)                             '25
     cLine = cLine & Space(1)                                   '26
     cLine = cLine & Space(4)                                   '27
     cLine = cLine & BacPad((Datos(12)), 4)                     '28
     cLine = cLine & Format(0, "000000000000")                  '29
     cLine = cLine & BacPad((Datos(13)), 35)                    '30
     cLine = cLine & Format(Datos(14), "00")                    '31
     cLine = cLine & Format(Datos(15), "00")                    '32
     cLine = cLine & Format(Datos(16), "0000")                  '33
     cLine = cLine & BacPad((Datos(17)), 4)                     '34
     cLine = cLine & BacPad((Datos(18)), 16)    '35
     cLine = cLine & Format(0, "000000000000")                  '36
     cLine = cLine & BacPad(Datos(19) + Datos(20), 15)          '37
     cLine = cLine & Space(4)                                   '38
     cLine = cLine & Format(0, "000000")                        '39
     cLine = cLine & Datos(21)                                  '40
     cLine = cLine & Space(1)                                   '41
     cLine = cLine & Space(4)                                   '42
     cLine = cLine & Space(4)                                   '43
     cLine = cLine & Format(Datos(22), "00")                    '44
     cLine = cLine & Format(Datos(23), "00")                    '45
     cLine = cLine & Format(Datos(24), "0000")                  '46
     cLine = cLine & Format(Datos(25), "00")                    '47
     cLine = cLine & Format(Datos(26), "00")                    '48
     cLine = cLine & Format(Datos(27), "0000")                  '49
     cLine = cLine & Format(0, "00")                            '50
     cLine = cLine & Format(0, "00")                            '51
     cLine = cLine & Format(0, "0000")                          '52
     cLine = cLine & Format(0, "000")                           '53
     cLine = cLine & Format(Datos(28), "0000")                  '54
     cLine = cLine & Datos(29)                                  '55
     cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(30))), "000.000000"), gsBac_PtoDec, "")  '56
     cLine = cLine & Format(Datos(31), "0000")                  '57
     cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(32))), "000.000000"), gsBac_PtoDec, "")  '58
     cLine = cLine & Format(0, "000000000")                     '59
     cLine = cLine & Format(0, "00")                            '60
     cLine = cLine & Format(0, "00")                            '61
     cLine = cLine & Format(0, "0000")                          '62
     cLine = cLine & Format(0, "00")                            '63
     cLine = cLine & Format(0, "00")                            '64
     cLine = cLine & Format(0, "0000")                          '65
     cLine = cLine & Format(0, "00")                            '66
     cLine = cLine & Format(0, "00")                            '67
     cLine = cLine & Format(0, "0000")                          '68
     cLine = cLine & Format(0, "00")                            '69
     cLine = cLine & Format(0, "00")                            '70
     cLine = cLine & Format(0, "0000")                          '71
     'cLine = cLine & Format(saca_punto(Trim(Str(Datos(33))), 2), "000000000000000") '72
     cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(33))), "0000000000000.00"), gsBac_PtoDec, "")
     'cLine = cLine & Format(saca_punto(Trim(Str(Datos(34))), 2), "000000000000000") '73
     cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(34))), "0000000000000.00"), gsBac_PtoDec, "")
     cLine = cLine & Format(0, "000000000000000")               '74
     cLine = cLine & Format(0, "000000000000000")               '75
     'cLine = cLine & Format(saca_punto(Trim(Str(Datos(43))), 6), "00000000000")  '76
     cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(42))), "00000.000000"), gsBac_PtoDec, "")
     cLine = cLine & Format(0, "000000000000000")               '77
     cLine = cLine & Format(0, "000000000000000")               '78
     cLine = cLine & Space(4)                                   '79
     cLine = cLine & Space(4)                                   '80
     cLine = cLine & Space(4)                                   '81
     cLine = cLine & Space(4)                                   '82
     'cLine = cLine & Format(saca_punto(Trim(Str(Datos(35))), 2), "000000000000000") '83
     cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(35))), "0000000000000.00"), gsBac_PtoDec, "")
     'cLine = cLine & Format(saca_punto(Trim(Str(Datos(36))), 2), "000000000000000") '84
     cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(36))), "0000000000000.00"), gsBac_PtoDec, "")
     'cLine = cLine & Format(saca_punto(Trim(Str(Datos(37))), 2), "000000000000000") '85
     cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(37))), "0000000000000.00"), gsBac_PtoDec, "")
     'cLine = cLine & Format(saca_punto(Trim(Str(Datos(38))), 2), "000000000000000") '86
     cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(38))), "0000000000000.00"), gsBac_PtoDec, "")
     'cLine = cLine & Format(saca_punto(Trim(Str(Datos(39))), 2), "000000000000000") '87
     cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(39))), "0000000000000.00"), gsBac_PtoDec, "")
     cLine = cLine & Format(0, "000000000000000")               '88
     cLine = cLine & Format(0, "000000000000000")               '89
     cLine = cLine & Format(0, "000000000000000")               '90
     cLine = cLine & Format(0, "000000000000000")               '91
     cLine = cLine & Format(0, "000000000000000")               '92
     cLine = cLine & Format(0, "000000000000000")               '93
     cLine = cLine & Format(0, "000000000000000")               '94
     'cLine = cLine & Format(saca_punto(Trim(Str(Datos(44))), 2), "000000000000000") '95
     cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(43))), "0000000000000.00"), gsBac_PtoDec, "")
     cLine = cLine & Format(0, "000000000000000")               '96
     cLine = cLine & Format(0, "000000000000000")               '97
     cLine = cLine & Format(0, "000000000000000")               '98
     cLine = cLine & Space(4)                                   '99
     cLine = cLine & Format(0, "00")                            '100
     cLine = cLine & Format(0, "00")                            '101
     cLine = cLine & Format(0, "0000")                          '102
     cLine = cLine & Format(0, "000000000000000")               '103
     cLine = cLine & Format(0, "000000000000000")               '104
     cLine = cLine & Format(0, "000000000000000")               '105
     cLine = cLine & Format(0, "0000")                          '106
     cLine = cLine & Format(0, "0000")                          '107
     cLine = cLine & Format(0, "0000")                          '108
     cLine = cLine & Format(0, "00")                            '109
     cLine = cLine & Format(0, "00")                            '110
     cLine = cLine & Format(0, "0000")                          '111
     cLine = cLine & Format(0, "0000")                          '112
     cLine = cLine & Format(0, "0000")                          '113
     cLine = cLine & Format(0, "0000")                          '114
     cLine = cLine & Format(0, "0000")                          '115
     cLine = cLine & Format(0, "00")                            '116
     cLine = cLine & Format(0, "00")                            '117
     cLine = cLine & Format(0, "0000")                          '118
     cLine = cLine & Space(2)                                   '119
     cLine = cLine & Space(4)                                   '120
     cLine = cLine & Format(0, "000000000")                     '121
     cLine = cLine & Space(15)                                  '122
     cLine = cLine & Format(0, "000000000000000")               '123
     cLine = cLine & Format(0, "00")                            '124
     cLine = cLine & Format(0, "00")                            '125
     cLine = cLine & Format(0, "0000")                          '126
     cLine = cLine & Datos(40)                                  '127
     cLine = cLine & "X"                                        '128
     cLine = cLine & Datos(41)                                  '129
          
     totalreg = totalreg + 1
     If Len(cLine) <> 865 Then
        totalreg = totalreg
     End If
    
    Print #1, cLine
    Loop
    Close #1
        
    MsgBox "Interfaz Generada" & " " & cNomArchivo, vbOKOnly, TITSISTEMA
   Exit Sub
   
Herror1:
   MsgBox "Error: " & err.Number & " Descripción: " & err.Description, vbCritical, "Interfaz"
   Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "ERROR interfaz  de  Posición  NO REALIZADA  " & cNomArchivo & err.Number & " Descripción: " & err.Description)
   Exit Sub

End Sub


Function SacaDecim(num) As String
Dim Dec As String
Dim desde As Integer
 
 
desde = (InStr(1, num, gsBac_PtoDec) + 1)

If (desde > 1) Then
    Dec = Mid(num, desde, Len(num))
End If

SacaDecim = IIf(Dec = "", "", Dec)
    

End Function

Private Sub Contable()
 Dim cDia As String
Dim cNomArchivo As String
Dim cLine  As String
Dim Datos()

Dim Correla As Integer
Dim Numero As Double

Glosa = " "
Prg.Value = 0
CPrg = 0
Label2.Visible = True
Prg.Visible = True 'Barra
     
''************************************************************************************
    ''Archivo PCTR + ("DD+mm+yy").DAT
   
   cDia = Mid(Format(gsBac_Fecp, "ddmmyyyy"), 1, 4)
  cNomArchivo = gsBac_DIRCO & "PCTR" & cDia & ".DTA"
  ' cNomArchivo = gsBac_DIRCO & "CU" & cDia & ".DS"

   If Bac_Sql_Execute("SP_INTER_CONSOLI ") Then  ' INTERFAZ CONTABLE
        cLine = ""
        Do While Bac_SQL_Fetch(Datos())
            cLine = cLine & Datos(1) & Datos(2) & Datos(3) & Datos(4) & Format(Datos(5), "ddmmyy")
            cLine = cLine & Format(Datos(6), "000000") & Format(Datos(7), "00000") & Datos(8) & Datos(9)
            cLine = cLine & Format(Datos(10), "0000000000000") & "00" & Datos(11) & Datos(12) & Datos(13)
            cLine = cLine & Format(Datos(14), "00000") & Datos(15) & Datos(16) & Format(Datos(17), "0000000000000") & "00" & Datos(18)
            cLine = cLine & Format(Datos(19), "000000") & Datos(20)
            cLine = cLine & Format(Datos(21), "00") & Format(Datos(22), "00") & Datos(23) & Datos(24) & Datos(25) & Datos(26) & Datos(27) & Datos(28)
            cLine = cLine & Datos(29) & Datos(30) & Datos(31) & Datos(32) & Datos(33) & Datos(34) & Datos(35) & Datos(36) & Datos(37) & Datos(38) & Datos(39) & Datos(40)
            cLine = cLine & Datos(41) & Datos(42) & Datos(43) & Datos(44)
            cLine = cLine + Chr(13) + Chr(10)
        Loop
        If Dir(NOMBRE) <> "" Then
            Kill NOMBRE
        End If

        Open NOMBRE For Binary Access Write As #1
        Put #1, , cLine
        Close #1


  '      If Not Enviar_por_ftp(gsBac_DIRCO, cNomArchivo) Then
 '           MsgBox "Interfaz " & cNomArchivo & "  via FTP no fue traspasada ", vbCritical
'        End If



 '       If Not Enviar_por_ftp(gsBac_DIRIN, cNomArchivo) Then
 '          MsgBox "Interfaz " & cNomArchivo & "  via FTP no fue traspasada ", vbCritical
 '       End If

''        If Not Enviar_por_ftp(Directorio.Path, cNomArchivo) Then
''            MsgBox "Interfaz " & Directorio.Path & "\" & cNomArchivo & "  via FTP no fue traspasada ", vbCritical
''        End If

      Else
        MsgBox "Interfaz no Generada" & " " & cNomArchivo, vbOKOnly, "MENSAJE"

   End If
            
''  If Not Enviar_por_ftp(gsBac_DIRIN, NOMBRE) Then
''           MsgBox "Interfaz " & cNomArchivo & "  via FTP no fue traspasada ", vbCritical
''  End If
            
End Sub


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
        ESPACIOS = Space((Largo - Len(Dato))) & Dato
    End If

End Function

Function ESPACIOS_CL(Dato As String, Largo As Integer, alineacion As String)

If alineacion = "I" Then
    ESPACIOS_CL = 0
    If Len(Dato) <= Largo Then
        ESPACIOS_CL = Space((Largo - Len(Dato))) & Dato
    End If
Else
    ESPACIOS_CL = 0
    If Len(Dato) <= Largo Then
        ESPACIOS_CL = Dato & Space((Largo - Len(Dato)))
    End If
End If


End Function

'Private Sub P17()
'Dim nTotal1 As Double
'Dim nTotal2 As Double
'Dim nTotal3 As Double
'
'    envia = Array(Format$(gsBac_Fecp, "yyyymmdd"))
'    If Not Bac_Sql_Execute("SP_P17", envia) Then
'        Screen.MousePointer = 0
'        MsgBox "No se puede generar Interfaz ", vbCritical, Msj
'        Exit Sub
'    Else
'        Screen.MousePointer = 11
'        If Dir(NOMBRE) <> "" Then
'            Kill NOMBRE
'        End If
'
'        Open NOMBRE For Append As #1
'        Linea = "1P17" + Format(gsBac_Fecp, "yyyymmdd")
'        Print #1, Linea
'
'        Do While Bac_SQL_Fetch(Datos())
'            Linea = Datos(1) & Ceros(Trim(Datos(2)), 11) & Trim(Datos(2))
'            Linea = Linea & Ceros(Trim(Datos(3)), 13) & Trim(Datos(3))
'            Linea = Linea & Ceros(Trim(Datos(4)), 13) & Trim(Datos(4))
'            Print #1, Linea
'            P = P + 1
'            Prg.Max = P
'            BacControlWindows 20
'            Prg.Value = P
'            nTotal1 = nTotal1 + CDbl(Datos(2))
'            nTotal2 = nTotal2 + CDbl(Datos(3))
'            nTotal3 = nTotal3 + CDbl(Datos(4))
'        Loop
'
'        Linea = "3P17"
'        Linea = Linea & Ceros(Prg.Value, 5) & Prg.Value
'        Linea = Linea & Ceros(Str(nTotal1), 11) & nTotal1
'        Linea = Linea & Ceros(Str(nTotal2), 13) & nTotal2
'        Linea = Linea & Ceros(Str(nTotal3), 13) & nTotal3
'        Print #1, Linea
'
'        Close #1
'        Screen.MousePointer = 0
'        MsgBox (" Interfaz P17 Generada Correctamente  "), vbInformation, ("BacTrader")
'        Prg.Visible = False
'        Label2.Visible = False
'    End If
'End Sub
'

Private Sub P17()
Dim nTotal1 As Double
Dim nTotal2 As Double
Dim nTotal3 As Double

    envia = Array(Format$(gsBac_Fecp, "yyyymmdd"))
    If Not Bac_Sql_Execute("SP_P17", envia) Then
        Screen.MousePointer = 0
        MsgBox "No se puede generar Interfaz ", vbCritical, Msj
        Exit Sub
    Else
        Screen.MousePointer = 11
        If Dir(NOMBRE) <> "" Then
            Kill NOMBRE
        End If

        Open NOMBRE For Append As #1
        Linea = "1P17" + Format(gsBac_Fecp, "yyyymmdd")
        Print #1, Linea

        Do While Bac_SQL_Fetch(Datos())
            Linea = Datos(1) & Ceros(Trim(Datos(2)), 11) & Trim(Datos(2))
            Linea = Linea & Ceros(Trim(Datos(3)), 13) & Trim(Datos(3))
            Linea = Linea & Ceros(Trim(Datos(4)), 13) & Trim(Datos(4))
            Print #1, Linea
            p = p + 1
            Prg.Max = p
            BacControlWindows 20
            Prg.Value = p
            nTotal1 = nTotal1 + CDbl(Datos(2))
            nTotal2 = nTotal2 + CDbl(Datos(3))
            nTotal3 = nTotal3 + CDbl(Datos(4))
        Loop
        
        Linea = "3P17"
        Linea = Linea & Ceros(Prg.Value, 5) & Prg.Value
        Linea = Linea & Ceros(Str(nTotal1), 11) & nTotal1
        Linea = Linea & Ceros(Str(nTotal2), 13) & nTotal2
        Linea = Linea & Ceros(Str(nTotal3), 13) & nTotal3
        Print #1, Linea
        
        Close #1
        Screen.MousePointer = 0
        MsgBox (" Interfaz P17 Generada Correctamente  "), vbInformation, ("BacTrader")
        Prg.Visible = False
        Label2.Visible = False
    End If
End Sub
Private Sub Vencimientos()
        Numero = 0
        Prg.Value = 0
        CPrg = 0
        Label2.Visible = True
        Prg.Visible = True 'Barra
        Sql = ""
        envia = Array("")
        If Not Bac_Sql_Execute("Sp_interfaz_Flujo_Vcto") Then
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
           
            Do While Bac_SQL_Fetch(Datos())
                
                 Linea = ""
                 Linea = Ceros(Trim(Datos(1)), 10) & Trim(Datos(1))
                 Linea = Linea & Trim(Datos(2)) & ESPACIOS(Trim(Datos(2)), 10)
                 Linea = Linea & Trim(Datos(3)) & ESPACIOS(Trim(Datos(3)), 8)
                 Linea = Linea & Trim(Datos(4)) & ESPACIOS(Trim(Datos(4)), 8) & "TR"
                 Linea = Linea & Ceros(Trim(Datos(5)), 3) & Trim(Datos(5)) & "0"
                 
                 Linea = Linea & Ceros(Int(Datos(6)), 17) & Int(Datos(6))
                  
                 Linea = Linea & Ceros(Int(Datos(7)), 8) & Int(Datos(7))
                 Deci = SacaDecim(Round(CDbl(Datos(7)) - Int(Datos(7)), 2))
                 Linea = Linea & Ceros(Trim(Deci), 2) & Mid(Trim(Deci), 1, 2)
                 
                 Linea = Linea & Ceros(Int(Datos(8)), 17) & Int(Datos(8))
                 Linea = Linea & "00000" & "N"
                 p = p + 1
                 Print #1, Linea
                 Prg.Max = p
                 BacControlWindows 20
                 Prg.Value = p
            Loop
            Close #1
            Screen.MousePointer = 0
            MsgBox ("Interfaz Vencimientos de Flujo Generada Correctamente"), vbInformation, ("BacTrader")
            Prg.Visible = False
            Label2.Visible = False
         End If


End Sub

Private Sub Directorio_Change()
If Interfaz = "D3" Or Interfaz = "P17" Or Interfaz = "CTACTE" Or Interfaz = "CTACTEII" Or Interfaz = "GESTION" Then
    If Right(Directorio.Path, 1) <> "\" Then
        NOMBRE = ""
        NOMBRE = Directorio.Path + "\" + NombreArchivo + ".DTA"
    Else
     NOMBRE = ""
     NOMBRE = Directorio.Path + NombreArchivo + ".DTA"
    End If

ElseIf Right(Directorio.Path, 1) <> "\" Then
 NOMBRE = ""
 If Me.Interfaz = "EXEL" Then
    NOMBRE = Directorio.Path + "\" + NombreArchivo
 ElseIf Me.Interfaz = "D31" Then
    NOMBRE = Directorio.Path + "\" + NombreArchivo
   ' NOMBRE = gsBac_DIRCO + NombreArchivo
 ElseIf Me.Interfaz = "CLIENTES" Then
    NOMBRE = Directorio.Path + "\" + NombreArchivo
 ElseIf Me.Interfaz = "OPERACIONES" Then
    NOMBRE = Directorio.Path + "\" + NombreArchivo + ".DAT"
 ElseIf Me.Interfaz = "DIRECCIONES" Then
    NOMBRE = Directorio.Path + "\" + NombreArchivo + ".DAT"
 ElseIf Me.Interfaz = "BALANCES" Then
    NOMBRE = Directorio.Path + "\" + NombreArchivo + ".DAT"
 ElseIf Me.Interfaz = "FLUJOS_NEOSOFT" Then
    NOMBRE = Directorio.Path + "\" + NombreArchivo + ".DAT"
 ElseIf Me.Interfaz = "POSICIONES" Then
    NOMBRE = Directorio.Path + "\" + NombreArchivo + ".DAT"
 ElseIf Me.Interfaz = "RELACIONES" Then
    NOMBRE = Directorio.Path + "\" + NombreArchivo + ".DAT"
 ElseIf Me.Interfaz = "CAPXIIIANEXO2" Then
    NOMBRE = Directorio.Path + "\" + NombreArchivo + ".TXT"
 ElseIf Me.Interfaz = "CAPXIIIANEXO3" Then
    NOMBRE = Directorio.Path + "\" + NombreArchivo + ".TXT"
 ElseIf Me.Interfaz = "CONTABLE" Then
    NOMBRE = Directorio.Path + "\"
 ElseIf Interfaz = "P40" Then
    NOMBRE = Directorio.Path + "\" + NombreArchivo + ".DAT"
 Else
    NOMBRE = Directorio.Path + "\" + NombreArchivo + ".TXT"
 End If
 
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
MsgBox Error(err), vbExclamation
Directorio.Path = "c:\"
drive.Refresh
Exit Sub
End Sub

Private Sub Form_Load()
    Dim cDia            As String
    Dim cPathError      As String

    On Error GoTo err:
    
    Me.Top = 0: Me.Left = 0
    
    Pnl_Progreso.Visible = False
    Pnl_Progreso.FloodShowPct = True
    
    If Interfaz = "P17" Then NombreArchivo = "BXP17"
    
    If Interfaz = "CONTABLE" Then
        cDia = Mid(Format(gsBac_Fecp, "ddmmyyyy"), 1, 4)
        cNomArchivo = "CU" & cDia '& ".DS"
        NombreArchivo = cNomArchivo   ''"MDINTCO"
        lblEtiqueta(2).Visible = False
        cmbAño.Visible = False
        Frame1.Visible = False
        frmConta.Visible = True
    End If

    If Interfaz = "CARTERA" Then NombreArchivo = "BXCA" & Mid(Format(gsBac_Fecp, "mmddyyyy"), 1, 4)
    If Interfaz = "FLUJOS" Then NombreArchivo = "BXFL" & Mid(Format(gsBac_Fecp, "mmddyyyy"), 1, 4)
    If Interfaz = "OPERACIONES" Then NombreArchivo = "OP51" & Format(gsBac_Fecp, "yymmdd")
    If Interfaz = "DIRECCIONES" Then NombreArchivo = "DD51" & Format(gsBac_Fecp, "yymmdd")
    If Interfaz = "POSICIONES" Then NombreArchivo = "PC51" & Format(gsBac_Fecp, "yymmdd")
    If Interfaz = "FLUJOS_NEOSOFT" Then NombreArchivo = "FL51" & Format(gsBac_Fecp, "yymmdd")
    If Interfaz = "RELACIONES" Then NombreArchivo = "CO51" & Format(gsBac_Fecp, "yymmdd")
    If Interfaz = "BALANCES" Then NombreArchivo = "BO51" & Format(gsBac_Fecp, "yymmdd")
    
   If Interfaz = "P40" Then
      txt_fec1.Text = Format(gsBac_Fecp, "DD-MM-YYYY")
      Pnl_Progreso.Visible = True
      txt_fec1.Visible = True
      Label2.Visible = True
      Label2.Caption = "Fecha Datos"
      NombreArchivo = "ND51" & Format(gsBac_Fecp, "yymmdd")
   End If

    

    If Interfaz = "EXEL" Then
        cmbAño.Enabled = False
        Me.Caption = "Grabar Planilla a Exell"
        NombreArchivo = "Tasamer.xls"    '' otra utilidad con la exportacion a exel
    End If
    
    If Interfaz <> "BALANCE" And Interfaz <> "OPERACIONES" Then
        Label2.Top = 4440
        Me.SSPanel1.Height = 4770
        Me.Height = 5175
        Prg.Top = 4030
        Frame1.Visible = True
        frmConta.Visible = False
    End If
    
    For i = 1990 To 2020
        cmbAño.AddItem i
        cmbAño.ItemData(cmbAño.NewIndex) = i
    Next

    Call BacLLenaComboMes(cmbMes)
    Call bacBuscarCombo(cmbAño, Year(gsBac_Fecp))
    Call bacBuscarCombo(cmbMes, Month(gsBac_Fecp))

    If Interfaz = "CAPXIIIANEXO2" Or Interfaz = "CAPXIIIANEXO3" Then
        Frame1.Visible = True
        lblEtiqueta(1).Visible = True
        lblEtiqueta(2).Visible = True
    
        cmbAño.Visible = True
        cmbMes.Visible = True
    
        If Interfaz = "CAPXIIIANEXO2" Then
           NombreArchivo = "CAPXIII_2"
        Else
           NombreArchivo = "CAPXIII_3"
        End If
    Else
        cmbMes.Visible = False
        cmbAño.Visible = False
        lblEtiqueta(1).Visible = False
        lblEtiqueta(2).Visible = False
        
    End If

    If Interfaz = "CARTERA" Or Interfaz = "FLUJOS" Then
        Prg.Top = 4030
        Me.SSPanel1.Height = 4770
        Frame1.Visible = False
        cPathError = gsBac_DIRIN
        Directorio.Path = gsBac_DIRIN 'Directorio.Path = gsBac_DIRCO
        
    ElseIf Interfaz = "CONTABLE" Then
        cPathError = gsBac_DIRINTCONTA
        Directorio.Path = gsBac_DIRINTCONTA
        
    ElseIf Interfaz = "OPERACIONES" Or Interfaz = "DIRECCIONES" Or Interfaz = "POSICIONES" Or Interfaz = "FLUJOS_NEOSOFT" Or Interfaz = "RELACIONES" Or Interfaz = "BALANCES" Then
        cPathError = gsBac_DIRIBS
        Directorio.Path = ""
        Directorio.Path = gsBac_DIRIBS
       
    Else
        cPathError = gsBac_DIRIN
        Directorio.Path = gsBac_DIRIN
       
    End If

    drive.Refresh
    Label2.Caption = ""
    Call Directorio_Change
    
    If cmbAño.Visible = False And cmbMes.Visible = False Then
        Frame1.Visible = False
    End If
    
    SSCommand1.Left = 3855
    SSCommand1.Top = 3210
  
    Me.Height = 4395

    Exit Sub


err:
    MsgBox "No se ha podido acceder a la ruta " + cPathError, vbExclamation, "Error de Acceso"
    Directorio.Path = App.Path
    drive.Refresh


End Sub

Private Sub C8()
        Numero = 0
        Prg.Value = 0
        CPrg = 0
        Label2.Visible = True
        Prg.Visible = True 'Barra
        Sql = ""
        envia = Array("")
        Screen.MousePointer = 11
        'Sql = "Sp_interfaz_C8"
        If Not Bac_Sql_Execute("Sp_interfaz_c8") Then    'Cambiar Sp_interfaz_C8
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
            
            Do While Bac_SQL_Fetch(Datos())
                
                 Linea = ""
                 Linea = Format(DatePart("d", gsBac_Fecp), "00") & "TR" & Ceros(Trim(Datos(1)), 10) & Trim(Datos(1)) ' cuenta
                 Linea = Linea & Ceros(Trim(Datos(2)), 3) & Trim(Datos(2)) ' moneda
                 Linea = Linea & Ceros(Trim(Datos(3)), 1) & Trim(Datos(3)) 'tipo_tasa
                 Linea = Linea & Trim(Datos(4)) & ESPACIOS(Trim(Datos(4)), 8) 'fecven
                 
                 Linea = Linea & Ceros(Int(Datos(5)), 14) & Int(Datos(5)) 'amortizacion
                 Deci = SacaDecim(Round(CDbl(Datos(5)) - Int(Datos(5)), 4))
                 Linea = Linea & Trim(Deci) & Ceros(Trim(Deci), 4)
                      
                                  
                 Linea = Linea & Ceros(Int(Datos(6)), 3) & Int(Datos(6)) 'tir
                 Deci = SacaDecim(Round(CDbl(Datos(6)) - Int(Datos(6)), 4))
                 Linea = Linea & Trim(Deci) & Ceros(Trim(Deci), 4)
                 
                 Linea = Linea & Ceros(Int(Datos(7)), 14) & Int(Datos(7)) 'saldo
                 Deci = SacaDecim(Round(CDbl(Datos(7)) - Int(Datos(7)), 4))
                 Linea = Linea & Trim(Deci) & Ceros(Trim(Deci), 4)
                 
                 
                 
'                Linea = Linea & Trim(Datos(8)) & ESPACIOS(Trim(Datos(8)), 5)
                 Linea = Linea & Format(Val(Datos(8)), "00000") 'inversion
                 Linea = Linea & Trim(Datos(9)) & ESPACIOS(Trim(Datos(9)), 1) 'tipo_cuenta

                 Prg.Value = p
                 p = p + 1
                 Print #1, Linea
                 Prg.Max = Datos(11)
                 BacControlWindows 20
                 
            Loop
            Close #1
            Screen.MousePointer = 0
            MsgBox ("Interfaz C08 Generada Correctamente"), vbInformation, ("BacTrader")
            Prg.Visible = False
            Label2.Visible = False
         End If

End Sub

 

Private Sub SSCommand1_Click()
Dim cDia As String


On Error GoTo Error

    
   Deci = "0"
   If UCase(Interfaz) = "C8" Then
      Call C8
   End If

'********************************************************
''''   If UCase(Interfaz) = "CONTABLE" Then
''''      cDia = Mid(Format(gsBac_Fecp, "ddmmyyyy"), 1, 4)
''''      NombreArchivo = Directorio.Path & "\"
''''      Call InterfazContable(NombreArchivo, cDia)
''''   End If
''''   Se comenta, ya que interfaz se esta generando automáticamente al realizar la contabilidad
   
   If UCase(Interfaz) = "P17" Then
      Call P17
   End If
   
   If UCase(Interfaz) = "CLIENTE" Then
      Call CLIENTE
   End If
   
   If UCase(Interfaz) = "C14" Then
      Call C14
   End If
   If UCase(Interfaz) = "COLOCACIONES" Then
      Call Colocaciones
   End If
   
    If UCase(Interfaz) = "VENCIMIENTOS" Then
      Call Vencimientos
   End If
       
   If UCase(Interfaz) = "ART57" Then
      Call Art57
   End If
   
   If UCase(Interfaz) = "D31" Then
      Call D31
   End If
   
   If UCase(Interfaz) = "CARTERA" Then
      Call Cartera
   End If
   
   If UCase(Interfaz) = "FLUJOS" Then
      Call FLUJOS
   End If
   
   
   If UCase(Interfaz) = "EXEL" Then
      Call Exporta_Excel
   End If
   
   If UCase(Interfaz) = "CLIENTES" Then
      Call CLIENTE1
   End If
   
   If UCase(Interfaz) = "OPERACIONES" Then
      Call InterfazOperaciones(NOMBRE)
   End If
   
   If UCase(Interfaz) = "DIRECCIONES" Then
      Call InterfazDirecciones(NOMBRE)
   End If

    If UCase(Interfaz) = "BALANCES" Then
        Call InterfazBalance(NOMBRE)
    End If

    If UCase(Interfaz) = "FLUJOS_NEOSOFT" Then
        Call InterfazFlujos(NOMBRE)
    End If

    If UCase(Interfaz) = "POSICIONES" Then
        Call InterfazPosicion(NOMBRE)
    End If
    
    If UCase(Interfaz) = "RELACIONES" Then
        Call InterfazDeudores(NOMBRE)
    End If
        
    If UCase(Interfaz) = "CAPXIIIANEXO2" Then
        Call InterfazCapXIIIanexo2(NOMBRE)
    End If
    
    If UCase(Interfaz) = "CAPXIIIANEXO3" Then
        Call InterfazCapXIIIanexo3(NOMBRE)
    End If
        
    If UCase(Interfaz) = "P40" Then
       Call InterfazP40
       Exit Sub
    End If
        
   Unload Me
Exit Sub
Error:
   MsgBox err.Description, err.Number, ("Bactrader")
   Close #1
   Screen.MousePointer = 0

End Sub

Private Sub Cartera()
 Dim cLine As String
 Dim cNomArchivo As String
 Dim cDia As String
 Dim cruta As String
 Dim Datos
 Dim Punto As String
 Dim p, sw As Integer
 Dim Conta As Integer
  Dim sep As String
 
 'On Error GoTo Herror1
 Punto = "."
 
 
 sep = ""
 cDia = Mid(Format(gsBac_Fecp, "ddmmyyyy"), 1, 4)
 
If Right(Directorio.Path, 1) = "\" Then
   NomArchivo = Directorio.Path & NombreArchivo & ".TXT"
Else
   NomArchivo = Directorio.Path & "\" & NombreArchivo & ".TXT"
End If

MousePointer = 11
sw = 0
Sql = "Sp_interfaz_Flujo_bonos"    ' CARTERA
 
If Not Bac_Sql_Execute(Sql) Then
   MsgBox "Problemas al ejecutar procedimiento " & Sql, vbCritical, "MENSAJE"
    Exit Sub
End If

  CPrg = 0
 
  Prg.Visible = True
  Prg.Value = 0
  p = 0
  
  If Dir(NomArchivo) <> "" Then
        Kill NomArchivo
   End If
   Open NomArchivo For Output As #1

 
Do While Bac_SQL_Fetch(Datos)
   If Prg.Max = 100 Then Prg.Max = Datos(51)
    If sw = 0 Then
        cLine = "1                              0000000000000000000000   00" & Format(gsBac_Fecp, "yyyymmdd") & "0000000000000000000000000000000000000000000000000000000000   00000000000000000000000000000000000000000000000000000000000000000000000PCT0000000000   00000000000000000000000000000000000000000000               "
        Print #1, cLine
        sw = 1
    End If
    
   cLine = ""
   cLine = cLine & Datos(1) & sep
   cLine = cLine & Format(Datos(2), "000000000") & Datos(50) & sep
   cLine = cLine & Format(Datos(3), "00000000000000000000") & sep 'identificacion operacion
   cLine = cLine & IIf(Datos(4) = "", "00000", Format(Datos(4), "00000")) & sep ' cta ctble cap
   
   '----
   cLine = cLine & Format(Datos(5), "0000") & sep ' cod partida sbif
   cLine = cLine & Datos(6) & sep                              ' cuenta super
   cLine = cLine & Datos(7) & sep                              ' caalificador
   cLine = cLine & "0" & sep
   cLine = cLine & Format(Datos(5), "0000") & sep ' cod partida sbif     ' cLine = cLine & datos(8) & sep
   '-----
   
  ' cLine = cLine & datos(9) & sep 'tipo colocacion
   cLine = cLine & Datos(10) & sep   'cod prod
   cLine = cLine & Datos(11) & sep    ' tipo cartera
   cLine = cLine & Datos(12) & sep     'tipo cred consumo
   cLine = cLine & Format(Datos(13), "yyyymmdd") & sep   'fecha origen operacion
   cLine = cLine & Format(saca_punto(Str(Datos(14)), 0), "000000000000000") & sep   'monto original peso
    cLine = cLine & Format(saca_punto(Str(Datos(14)), 0), "000000000000000") & sep   'cupo disponible para linea de cred  ' cLine = cLine & Format(datos(15), "000000000000000") & sep
   cLine = cLine & Format(saca_punto(Str(Datos(16)), 4), "000000000000") & sep            ' tipo de cambio
   cLine = cLine & Datos(17) & sep                 ' moneda contable
   cLine = cLine & Datos(17) & sep                 '  moneda reajustabilidad  --  cLine = cLine & Format(datos(18), "00") & sep   'moneda reajustabilidad
   cLine = cLine & Format(Datos(19), "000") & sep  'codigo moneda segun sbif
   cLine = cLine & Format(Datos(20), "000") & sep  'base de calculo tasa interes
   cLine = cLine & Format(saca_punto(Str(Datos(21)), 4), "000000") & sep      'valor tasa efectiva mensual
   cLine = cLine & Datos(22) & sep
   cLine = cLine & Format(saca_punto(Str(Datos(23)), 4), "000000") & sep
   cLine = cLine & Datos(24) & sep
   cLine = cLine & Format(Datos(25), "yyyymmdd") & sep
   cLine = cLine & Format(Datos(26), "yyyymmdd") & sep
   cLine = cLine & Format(Datos(27), "000000000000000") & sep
   cLine = cLine & Datos(28) & sep
   cLine = cLine & Format(Datos(29), "0000") & sep
   cLine = cLine & Datos(30) & sep
   cLine = cLine & Datos(31) & sep & Datos(32) & sep
   cLine = cLine & Datos(33) & sep & Datos(34) & sep ' cod ofi origen op
   cLine = cLine & Datos(35) & sep
   cLine = cLine & Space(3) & sep 'cod ejecutivo
   cLine = cLine & Datos(37) & sep
   cLine = cLine & Format(Datos(38), "yyyymmdd") & sep
   cLine = cLine & Format(Datos(39), "000") & sep
   cLine = cLine & Format(Datos(40), "000") & sep
   cLine = cLine & Format(Datos(41), "00000") & sep
   cLine = cLine & Replace(Format(Datos(42), "000000000000000"), "-", "") & sep
   cLine = cLine & "00000" & sep '  Format(datos(43), "00000") & sep
   cLine = cLine & "000000000000000" & sep  'Replace(Format(datos(42), "000000000000000"), "-", "") & sep
   cLine = cLine & Datos(45) & sep
   cLine = cLine & Datos(46) & sep
   cLine = cLine & Format(Datos(47), "00000") & sep
   
   
   'cLine = cLine & "12001"
   'cLine = cLine & "000000000000000"
   
   If Len(cLine) <> 290 Then
         p = p
   End If
   p = p + 1
   Prg.Value = p
   Print #1, cLine
Loop

cLine = ""


If p > 0 Then
    cLine = "3                              0000000000000000000000   00" & Format(gsBac_Fecp, "yyyymmdd") & "000000000000000" & Format(Datos(49), "000000000000000") & "0000000000000000000000000000   0000000000000000000000000000" & Format(Datos(52), "000000000000000") & "0000000000000000000000000000PCT0000000000   00000000000000000000000000000000000000000000               "
    Print #1, cLine
    
End If

Close #1
 Prg.Value = Prg.Max
MsgBox "Interfaz operaciones  Generada" & " " & cNomArchivo & "(Cant.Reg. " & p & ")", vbOKOnly, "MENSAJE"
Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "Generacion interfaz de  operaciones  " & cNomArchivo)
     
MousePointer = 0
Exit Sub
   
'Herror1:
'   MsgBox "Error: " & err.Number & " Descripción: " & err.Description, vbCritical, "Interfaz"
'   Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "ERROR interfaz de  operaciones  " & cNomArchivo & " " & err.Number & " Descripción: " & err.Description)
'   MousePointer = 0
End Sub
Private Sub FLUJOS()
    Dim cLine       As String
    Dim cNomArchivo As String
    Dim cDia        As String
    Dim cruta       As String
    Dim Punto       As String
    Dim p           As Long
    Dim Conta       As Integer
    Dim sw          As Integer
    Dim sep         As String
    Dim TraeDatos   As Boolean
    Dim Datos
    
 
    On Error GoTo Herror1
    
    Punto = "."
    cDia = Mid(Format(gsBac_Fecp, "ddmmyyyy"), 1, 4)

    If Right(Directorio.Path, 1) = "\" Then
        NomArchivo = Directorio.Path & NombreArchivo & ".TXT"
    Else
        NomArchivo = Directorio.Path & "\" & NombreArchivo & ".TXT"
    End If

    'cNomArchivo = gsBac_DIRIN & "\" & NombreArchivo & ".TXT"
    Screen.MousePointer = vbHourglass
    sw = 0
 
    TraeDatos = False
    
    Sql = "Sp_interfaz_Flujo_Vcto_Bonos"
 
    If Not Bac_Sql_Execute(Sql) Then
        MsgBox "Problemas al ejecutar procedimiento " & Sql, vbCritical, "MENSAJE"
        Exit Sub
    End If
 
    CPrg = 0
 
    Prg.Visible = True
    Prg.Value = 0
    p = 0
    sep = ""
    
    If Dir(NomArchivo) <> "" Then
        Kill NomArchivo
    End If
    
    cLine = ""

    Open NomArchivo For Output As #1
  
        Do While Bac_SQL_Fetch(Datos)
        
            If Prg.Max = 100 Then Prg.Max = Datos(19)

            If sw = 0 Then
                cLine = ""
                cLine = "1" & "00000000000000000000000000000000000000000000000" & Format(gsBac_Fecp, "yyyymmdd") & "0000000000000000000000000000000000000" & Format(0, "000000000000000") & "00000000000000000000000       "
                Print #1, cLine
                sw = 1
            End If

            cLine = ""
            cLine = cLine & Datos(1) & sep
            cLine = cLine & Datos(2) & sep
            cLine = cLine & Datos(3) & sep
            cLine = cLine & IIf(Datos(4) = "", "00000", Format(Datos(4), "00000")) & sep
            cLine = cLine & Format(Datos(5), "00") & sep
            cLine = cLine & Format(Datos(6), "000") & sep
            cLine = cLine & Format(Datos(7), "000") & sep
            cLine = cLine & Datos(8) & sep
            cLine = cLine & Format(Datos(9), "000") & sep
            cLine = cLine & Format(Datos(10), "yyyymmdd") & sep
            cLine = cLine & Format(Datos(11), "000000000000000") & sep
            cLine = cLine & Format(IIf(Val(Datos(12)) < 0, saca_menos2(Val(Datos(12))), Datos(12)), "000000000000000") & sep
            cLine = cLine & Format(Datos(13), "000000000000000") & sep
            cLine = cLine & Format(Datos(14), "000000000000000") & sep
            cLine = cLine & Format(Datos(15), "000000000000000") & sep
            cLine = cLine & Replace(Format(Datos(16), "000.0000"), gsBac_PtoDec, "") & sep
            cLine = cLine & Space(8) & sep     'datos(17)

            If Len(cLine) <> 146 Then
                p = p
            End If
    
            p = p + 1
    
            Prg.Value = p
            Print #1, cLine
            
            TraeDatos = True
        Loop

        If TraeDatos = True Then
            cLine = ""
            cLine = "3                              0000000000000 000" & Format(gsBac_Fecp, "yyyymmdd") & "000000000000000000000000000000000000000000000" & Format(Prg.Max, "000000000000000") & Format(Datos(20), "000000000000000") & "       "
        End If

        Print #1, cLine

    Close #1
    
    MsgBox "Interfaz de Vencimientos Generada" & " " & cNomArchivo & "(Cant.Reg. " & p & ")", vbInformation, "MENSAJE"

    Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "Generacion interfaz de  vencimientos  Ok" & cNomArchivo)
    
    Screen.MousePointer = vbDefault
    Exit Sub
   
Herror1:
   MsgBox "Error: " & err.Number & " Descripción: " & err.Description, vbCritical, "Interfaz"
   Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "ERROR interfaz  de  vencimientos  NO REALIZADA  " & cNomArchivo & err.Number & " Descripción: " & err.Description)
   Screen.MousePointer = vbDefault
End Sub


Private Function saca_menos2(xValor As Variant) As String
Dim xstring As String
Dim Signo As String
xstring = Trim(Str(Abs(xValor)))

For i = Len(xstring) + 1 To 15
If i = 15 Then
  Signo = Signo & Trim("-")
  Else
  Signo = Signo & "0"
  End If
Next

saca_menos2 = Trim(Signo) & Trim(xstring)

End Function
Private Function sac_menos(xValor As Double) As Double
Dim xstring As String
For i = 1 To Len(xValor)
If Mid(xValor, i, 1) = "-" Then
  xstring = xstring & Mid(xValor, i, 1)
  Else
  xstring = xstring & Mid(xValor, i, 1)
End If
Next


End Function


Private Function saca_punto(cValor As String, nDecim As Integer) As String
Dim X As Integer
Dim x1 As Integer
Dim xvar As String
Dim yvar As String
Dim Y As Integer
If Mid(cValor, 1, 1) = "-" Then
    cValor = Mid(cValor, 2, Len(cValor))
End If
For X = 1 To Len(cValor) 'nDecim
    If Mid(cValor, X, 1) = "." Then
      xvar = xvar & "" 'Mid(cValor, x, 1)
      x1 = Len(Mid(cValor, X + 1, Len(cValor)))
     Y = Y - 1
    ElseIf Mid(cValor, X, 1) = " " Then
     xvar = xvar & "0"
    ElseIf Mid(Trim(cValor), X, 1) <> " " Then 'cuando es un valor
    Y = Y + 1
    xvar = xvar & Mid(cValor, X, 1)
    End If
Next

If Len(Trim(cValor)) = 1 Then
 xvar = xvar & "0000"
 saca_punto = xvar
 Exit Function
End If

For x1 = 1 To nDecim - x1
 xvar = xvar & "0"
Next
saca_punto = xvar
'If Len(xvar) < 6 Then
'saca_punto = "0" & xvar'
'ElseIf Len(xvar) > 6 Then
'saca_punto = Mid(xvar, 2, 6)
'End If
End Function

Private Sub D31()
Dim cLine As String
 Dim cNomArchivo As String
 Dim cDia As String
 Dim cruta As String
 Dim Datos
 Dim Punto As String
 On Error GoTo Herror1
 Punto = "."
 cDia = Mid(Format(gsBac_Fecp, "mmddyyyy"), 1, 4)
 cNomArchivo = gsBac_DIRCO & "D31_" & cDia & ".TXT"
 'd31_md
 Sql = "sp_operaciones '" & Format(gsBac_Fecp, "yyyymmdd") & "'"
 
 If Not Bac_Sql_Execute(Sql) Then
    MsgBox "Problemas al leer operaciones", vbCritical, "MENSAJE"
   ' Call GRABA_LOG_AUDITORIA("Opc_60913", "09", "Problemas Procedimiento", "", "", "")
    Exit Sub
 End If
  
 cLine = ""
Do While Bac_SQL_Fetch(Datos)

   cLine = cLine & Format(Datos(1), "000000000") & Datos(2) & Format(Datos(3), "00000000000000000000")
   cLine = cLine & Datos(4) & Format(IIf(Datos(5) = "", "00000", Datos(5)), "00000") & Datos(6) & Format(saca_punto(CDbl(Datos(7)), 2), "000000000000000") & Format(Datos(8), "yyyymmdd")
   cLine = cLine & Format(Datos(9), "yyyymmdd") & Datos(10)
  
   cLine = cLine & Format(saca_punto(CDbl(Datos(11)), 4), "0000000") & Datos(12)
   cLine = cLine & Format(saca_punto(CDbl(Datos(13)), 0), "0000")
   cLine = cLine & Datos(14) & Datos(15) & Datos(16) & Datos(17)
   
   cLine = cLine + Chr(13) + Chr(10)
  
Loop
       
   If Dir(cNomArchivo) <> "" Then
        Kill cNomArchivo
   End If
    
    Open cNomArchivo For Binary Access Write As #1
    Put #1, , cLine
    Close #1
    
    MsgBox "Interfaz Generada" & " " & cNomArchivo, vbOKOnly, "MENSAJE"
    Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Generacion interfaz D31  Ok  " & cNomArchivo)
     
''    If Not Enviar_por_ftp(Directorio.Path, cNomArchivo) Then
''             MsgBox "interfaz " & cNomArchivo & "  via FTP no fue traspasada ", vbCritical
''    End If
    
   Exit Sub
   
Herror1:
   MsgBox "Error: " & err.Number & " Descripción: " & err.Description, vbCritical, "Interfaz"
   
     Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "ERROR interfaz D31  " & cNomArchivo & err.Number & " Descripción: " & err.Description)
End Sub

Private Sub CLIENTE()

         Prg.Value = 0
        CPrg = 0
        Label2.Visible = True
        Prg.Visible = True 'Barra
        Sql = ""
        envia = Array("")
        
        If Not Bac_Sql_Execute("SP_INTERFAZ_CLIENTE") Then
            Screen.MousePointer = 0
            MsgBox "No se puede Generar Interfaz ", vbCritical, Msj
            Exit Sub
        Else
            i = 1
            
            Screen.MousePointer = 11
             If Dir(NOMBRE) <> "" Then
               Kill NOMBRE
             End If
            p = 1
            Open NOMBRE For Append As #1
           
            Do While Bac_SQL_Fetch(Datos())
                
                 Linea = ""
                 Linea = Ceros(Trim(Datos(1)), 10) & Datos(1)
                 Linea = Linea & Trim(Datos(2)) & ESPACIOS(Trim(Datos(2)), 50)
                 Linea = Linea & Format(Val(Datos(3)), "00")
                 Linea = Linea & Format(Val(Datos(4)), "0000")
                 Linea = Linea & "00" & Space(52)
                                  
                 p = p + 1
                 Print #1, Linea
                 Prg.Max = p
                 BacControlWindows 20
                 Prg.Value = p
            Loop
            Close #1
            Screen.MousePointer = 0
            MsgBox ("Interfaz de Clientes Generada Correctamente  "), vbInformation, ("BacTrader")
            Prg.Visible = False
            Label2.Visible = False
             'If Not Enviar_por_ftp(gsBac_DIRIN, "CLIENTE.TXT") Then
             '    MsgBox "Interfaz " & NOMBRE & "  via FTP no fue traspasada ", vbCritical
            'End If
         End If


End Sub

Function Exporta_Excel()
Dim Linea As String
Dim Arr()
Dim j As Double
Dim i As Double
Dim Exc
Dim Hoja
Dim S As Integer
Dim Sheet
Dim ruta As String
Dim crea_xls As Boolean

Const Filas_Buffer = 150

'gsBac_DIREXEL

ruta = NOMBRE 'ruta del .XSL
Screen.MousePointer = 11
DoEvents


Sql = "Sp_Sbif_LeerMdtm1 " & "'BTR'," & "'" & Fecha & "'"

If Not Bac_Sql_Execute(Sql) Then MsgBox "No se pudo generar Planilla", vbCritical, gsBac_Version: Screen.MousePointer = 0: Exit Function

Set Exc = CreateObject("Excel.Application")
Set Hoja = Exc.Application.Workbooks.Add.Sheets.Add
Set Sheet = Exc.ActiveSheet
Linea = ""

Linea = Linea & "Serie" & vbTab
Linea = Linea & "Emisor" & vbTab
Linea = Linea & "Fecha Vcto" & vbTab
Linea = Linea & "Tasa mercado" & vbTab
Linea = Linea & "Tasa Market" & vbTab
Linea = Linea & "Tasa Market2" & vbTab
Linea = Linea & "Tasa Market3" & vbTab
Linea = Linea & "Rut Emisor" & vbTab
Linea = Linea & "codigo" & vbTab
Linea = Linea & "codigo moneda" & vbTab
Linea = Linea & "valor nominal" & vbTab
'Linea = Linea & "Rut Cartera " & vbTab
'Linea = Linea & "valor_mercado"

Clipboard.Clear
Clipboard.SetText Linea
Sheet.Range("A1").Select
Sheet.Paste
Linea = ""
Clipboard.Clear

i = 1
Do While Bac_SQL_Fetch(Arr())

    For j = 1 To 11 '3
        If (j > 2 And j < 6) Or (j > 7 And j < 10) Or (j > 10) And j <> 12 Then
            Linea = Linea & BacStrTran(IIf(Trim(Arr(j)) = "", 0, Trim(Arr(j))), ",", ".") & vbTab
        Else
            If j = 6 Then
             Linea = Linea & BacStrTran(IIf(Trim(Arr(j)) = "", 0, Trim(Arr(j))), ",", ".") & vbTab
             '   Linea = Linea & Format(IIf(Trim(Arr(J)) = "", "01/01/1900", Trim(Arr(J))), "mm/dd/yyyy") & vbTab
            ElseIf j <> 12 Then
                Linea = Linea & IIf(Trim(Arr(j)) = "", "NULL", Trim(Arr(j))) & vbTab
            End If
        End If
    Next j
    Linea = Linea + vbCrLf
    If i Mod Filas_Buffer = 0 Then
        Clipboard.Clear
        Clipboard.SetText Linea
        If i = Filas_Buffer Then
            Sheet.Range("A2").Select
        Else
            Sheet.Range("A" & CStr((i + 1) - Filas_Buffer)).Select
        End If
        Sheet.Paste
        Linea = ""
    End If

    crea_xls = True
    i = i + 1
Loop
Clipboard.Clear
Clipboard.SetText Linea
Sheet.Range("A" & CStr((Int(i / Filas_Buffer) * Filas_Buffer) + IIf(i > Filas_Buffer, 1, 2))).Select
Sheet.Paste
Linea = ""
Clipboard.Clear

Sheet.Range("A1").Select

Hoja.Application.DisplayAlerts = False
For i = 2 To Hoja.Application.Sheets.Count
  Hoja.Application.Sheets(2).Delete
Next i
If crea_xls Then
    Hoja.SaveAs (ruta)
Else
    MsgBox "No se Encontró Información Correspondiente en los registros", vbExclamation, gsBac_Version
End If
Hoja.Application.Workbooks.Close

Screen.MousePointer = 0

Set Hoja = Nothing
Set Exc = Nothing
Set Sheet = Nothing

' ConCheck_Click 3

End Function


Sub InterfazCapXIIIanexo2(NombreArchivo As String)
    Dim total          As Integer
    Dim totalreg       As Integer
    Dim cDia           As String
    Dim cNomArchivo    As String
    Dim cLine          As String

 On Error GoTo Herror1
 
    Screen.MousePointer = 11
          
    total = 0
    totalreg = 0
    cNomArchivo = ""
    cDia = Format(gsBac_Fecp, "yymmdd")
    
    cNomArchivo = NombreArchivo  'gsBac_DIRIN & "\" & "CAPXIII_2" & cDia & ".TXT"
    envia = Array()
    AddParam envia, cmbMes.ListIndex + 1
    AddParam envia, Val(cmbAño.Text)

    If Not Bac_Sql_Execute("Sp_Cap_XIII_anexo2", envia) Then
        Screen.MousePointer = 0
        MsgBox "Problemas al leer operaciones", vbCritical, "MENSAJE"
        Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "ERROR interfaz  Capítulo XIII Anexo 2 NO REALIZADA  " & cNomArchivo & err.Number & " Descripción: " & err.Description)
        Exit Sub
    End If
    
    If Dir(cNomArchivo) <> "" Then
        Kill cNomArchivo
    End If

    'Open cNomArchivo For Binary Access Write As #1
    Open cNomArchivo For Output As #1
  
    Do While Bac_SQL_Fetch(Datos())
        cLine = ""
        cLine = cLine & Format((Datos(1)), "YYYYMMDD") & Chr(59)              '1
        cLine = cLine & BacPad((Datos(2)), 60) & Chr(59)              '2
        cLine = cLine & BacPad((Datos(3)), 50) & Chr(59)              '3
        cLine = cLine & BacPad((Datos(4)), 30) & Chr(59)              '4
        cLine = cLine & BacPad((Datos(5)), 6) & Chr(59)               '5
        cLine = cLine & Format(CDbl(Datos(6)), "0000000000000000.0000") & Chr(59) '6
        cLine = cLine & Format((Datos(7)), "YYYYMMDD") & Chr(59)      '7
        cLine = cLine & Format(CDbl(Datos(8)), "0000000000000000.0000") & Chr(59) '8
        cLine = cLine & Format(CDbl(Datos(9)), "0000000000000000.0000") & Chr(59) '9
'' VGS 11/2004        cLine = cLine & BacPad((datos(10)), 6) & Chr(59)              '10
        cLine = cLine & BacPad("", 6) & Chr(59)              '10
       
        totalreg = totalreg + 1
        If Len(cLine) <> 786 Then
           totalreg = totalreg
        End If
        
        Print #1, cLine
    Loop
    
    cLine = ""
    totalreg = totalreg + 1
    
    Print #1, cLine
    Close #1
    
    Screen.MousePointer = 0
        
    MsgBox "Interfaz Generada" & " " & cNomArchivo, vbInformation, TITSISTEMA
    Exit Sub
   
Herror1:
   Screen.MousePointer = 0
   MsgBox "Error: " & err.Number & " Descripción: " & err.Description, vbCritical, "Interfaz"
   Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "ERROR interfaz  Capítulo XIII Anexo 2 NO REALIZADA  " & cNomArchivo & err.Number & " Descripción: " & err.Description)
   Exit Sub

End Sub
 
Sub InterfazCapXIIIanexo3(NombreArchivo As String)
    Dim total          As Integer
    Dim totalreg       As Integer
    Dim cDia           As String
    Dim cNomArchivo    As String
    Dim cLine          As String

 On Error GoTo Herror1
 
    Screen.MousePointer = 11
          
    total = 0
    totalreg = 0
    cNomArchivo = ""
    cDia = Format(gsBac_Fecp, "yymmdd")
    
    cNomArchivo = NombreArchivo
    envia = Array()
    AddParam envia, cmbMes.ListIndex + 1
    AddParam envia, Val(cmbAño.Text)
      
    If Not Bac_Sql_Execute("Sp_Cap_XIII_anexo3", envia) Then
        Screen.MousePointer = 0
        MsgBox "Problemas al leer operaciones", vbCritical, "MENSAJE"
        Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "ERROR interfaz  Capítulo XIII Anexo 3 NO REALIZADA  " & cNomArchivo & err.Number & " Descripción: " & err.Description)
        Exit Sub
    End If
    
    If Dir(cNomArchivo) <> "" Then
        Kill cNomArchivo
    End If

    'Open cNomArchivo For Binary Access Write As #1
    Open cNomArchivo For Output As #1
  
    Do While Bac_SQL_Fetch(Datos())
        cLine = ""
        cLine = cLine & BacPad((Datos(1)), 40) & Chr(59)
        cLine = cLine & Format(CDbl(Datos(2)), "0000000000000000.0000") & Chr(59)
        cLine = cLine & Format(CDbl(Datos(3)), "0000000000000000.0000") & Chr(59)
        cLine = cLine & Format(CDbl(Datos(4)), "0000000000000000.0000") & Chr(59)
        cLine = cLine & Format(CDbl(Datos(5)), "0000000000000000.0000") & Chr(59)
        cLine = cLine & Format(CDbl(Datos(6)), "0000000000000000.0000") & Chr(59)
        cLine = cLine & Format(CDbl(Datos(7)), "0000000000000000.0000") & Chr(59)
        cLine = cLine & Format(CDbl(Datos(8)), "0000000000000000.0000") & Chr(59)
        cLine = cLine & Format(CDbl(Datos(9)), "0000000000000000.0000") & Chr(59)
        cLine = cLine & Format(CDbl(Datos(10)), "0000000000000000.0000") & Chr(59)
        cLine = cLine & Format(CDbl(Datos(11)), "0000000000000000.0000") & Chr(59)
        
        totalreg = totalreg + 1
        If Len(cLine) <> 250 Then
           totalreg = totalreg
        End If
        
        Print #1, cLine
    Loop
    
    cLine = ""
    totalreg = totalreg + 1
    
    Print #1, cLine
    Close #1
    
    Screen.MousePointer = 0
        
    MsgBox "Interfaz Generada" & " " & cNomArchivo, vbInformation, TITSISTEMA
    Exit Sub
   
Herror1:
   Screen.MousePointer = 0
   MsgBox "Error: " & err.Number & " Descripción: " & err.Description, vbCritical, "Interfaz"
   Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "ERROR interfaz  Capítulo XIII Anexo 2 NO REALIZADA  " & cNomArchivo & err.Number & " Descripción: " & err.Description)
   Exit Sub

End Sub
 

Private Sub txt_fec1_Change()
   If Interfaz = "P40" Then
      NOMBRE.Text = Directorio.Path & "\ND51" & Format(txt_fec1.Text, "YYMMDD") & ".DAT"
   End If
End Sub
