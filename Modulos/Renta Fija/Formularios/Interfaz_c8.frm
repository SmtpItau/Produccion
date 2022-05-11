VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.2#0"; "mscomctl.ocx"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "comdlg32.ocx"
Begin VB.Form Interfaz 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Interfaz"
   ClientHeight    =   4680
   ClientLeft      =   3420
   ClientTop       =   2550
   ClientWidth     =   11880
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   4680
   ScaleWidth      =   11880
   Begin VB.Data Data1 
      Caption         =   "Data1"
      Connect         =   "dBASE IV;"
      DatabaseName    =   ""
      DefaultCursorType=   0  'DefaultCursor
      DefaultType     =   2  'UseODBC
      Exclusive       =   0   'False
      Height          =   345
      Left            =   4995
      Options         =   0
      ReadOnly        =   0   'False
      RecordsetType   =   1  'Dynaset
      RecordSource    =   ""
      Top             =   30
      Visible         =   0   'False
      Width           =   1935
   End
   Begin Threed.SSPanel SSPanel1 
      Height          =   4635
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   11775
      _Version        =   65536
      _ExtentX        =   20770
      _ExtentY        =   8176
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
      BorderWidth     =   1
      BevelInner      =   1
      Begin VB.Frame Frame2 
         Caption         =   "Directorio Destino"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   2130
         Left            =   75
         TabIndex        =   1
         Top             =   45
         Width           =   11640
         Begin VB.DriveListBox drive 
            BeginProperty Font 
               Name            =   "Tahoma"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   315
            Left            =   150
            TabIndex        =   4
            Top             =   285
            Visible         =   0   'False
            Width           =   11355
         End
         Begin VB.DirListBox Directorio 
            BeginProperty Font 
               Name            =   "Tahoma"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   315
            Left            =   135
            TabIndex        =   3
            Top             =   615
            Visible         =   0   'False
            Width           =   11370
         End
         Begin VB.TextBox NOMBRE 
            BeginProperty Font 
               Name            =   "Tahoma"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   615
            Left            =   135
            Locked          =   -1  'True
            MultiLine       =   -1  'True
            ScrollBars      =   1  'Horizontal
            TabIndex        =   2
            Top             =   1005
            Width           =   11370
         End
      End
      Begin VB.TextBox Text1 
         Height          =   315
         Left            =   2160
         TabIndex        =   5
         Text            =   "Text1"
         Top             =   1800
         Visible         =   0   'False
         Width           =   1275
      End
      Begin VB.Frame Frame1 
         Height          =   555
         Left            =   75
         TabIndex        =   7
         Top             =   3045
         Visible         =   0   'False
         Width           =   4680
         Begin BACControles.TXTFecha TXTFecha1 
            Height          =   270
            Left            =   1560
            TabIndex        =   14
            Top             =   165
            Width           =   1335
            _ExtentX        =   2355
            _ExtentY        =   476
            Enabled         =   -1  'True
            Enabled         =   -1  'True
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Tahoma"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            MaxDate         =   2958465
            MinDate         =   -328716
            Text            =   "22/09/2008"
         End
         Begin VB.ComboBox cmbMes 
            BeginProperty Font 
               Name            =   "Tahoma"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   315
            Left            =   1530
            Style           =   2  'Dropdown List
            TabIndex        =   9
            Top             =   165
            Width           =   1590
         End
         Begin VB.ComboBox cmbAño 
            BeginProperty Font 
               Name            =   "Tahoma"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   315
            Left            =   3495
            Style           =   2  'Dropdown List
            TabIndex        =   8
            Top             =   165
            Width           =   1185
         End
         Begin VB.Label lblEtiqueta 
            AutoSize        =   -1  'True
            Caption         =   "Fecha Proceso"
            BeginProperty Font 
               Name            =   "Tahoma"
               Size            =   9
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   210
            Index           =   0
            Left            =   120
            TabIndex        =   13
            Top             =   240
            Visible         =   0   'False
            Width           =   1290
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
            Left            =   240
            TabIndex        =   11
            Top             =   255
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
            Left            =   3090
            TabIndex        =   10
            Top             =   255
            Width           =   315
         End
      End
      Begin Threed.SSCommand SSCommand2 
         Height          =   615
         Left            =   6960
         TabIndex        =   16
         Top             =   3720
         Visible         =   0   'False
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   78
         Picture         =   "Interfaz_c8.frx":0000
      End
      Begin Threed.SSCommand SSCommand1 
         Height          =   615
         Left            =   3480
         TabIndex        =   17
         Top             =   3720
         Width           =   975
         _Version        =   65536
         _ExtentX        =   1720
         _ExtentY        =   1085
         _StockProps     =   78
         Picture         =   "Interfaz_c8.frx":0872
      End
      Begin MSComDlg.CommonDialog CommonDialog1 
         Left            =   120
         Top             =   3720
         _ExtentX        =   847
         _ExtentY        =   847
         _Version        =   393216
      End
      Begin VB.Label Label3 
         Caption         =   "Generar Interfaz "
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   180
         Left            =   1320
         TabIndex        =   18
         Top             =   3840
         Width           =   1560
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Cargar Archivo "
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   9
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   210
         Left            =   5160
         TabIndex        =   15
         Top             =   3840
         Visible         =   0   'False
         Width           =   1410
      End
      Begin VB.Label Label2 
         Caption         =   "Creando Informe..."
         ForeColor       =   &H000000FF&
         Height          =   180
         Left            =   120
         TabIndex        =   6
         Top             =   3360
         Visible         =   0   'False
         Width           =   1560
      End
   End
   Begin MSComctlLib.ProgressBar Prg 
      Height          =   345
      Left            =   0
      TabIndex        =   12
      Top             =   4875
      Visible         =   0   'False
      Width           =   3600
      _ExtentX        =   6350
      _ExtentY        =   609
      _Version        =   393216
      Appearance      =   1
   End
End
Attribute VB_Name = "Interfaz"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Dim Datos()
Dim folio As Long
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
Dim objMonedas  As New ClsMonedas


Sub InterfazDeudores_resp()

 Dim Total          As Integer
 Dim totalreg       As Integer
 Dim cDia           As String
 Dim cNomArchivo    As String
 Dim cLine          As String
 Dim NumeroTel      As String
 Dim Rut            As Integer
 Dim dig            As String
 Dim rut1           As Integer
 Dim dig1           As String

 On Error GoTo Herror1
 Total = 0
 totalreg = 0
 cNomArchivo = ""
 cDia = Format(gsBac_Fecp, "ddmmyy")
 cNomArchivo = gsBac_DIRIN & NombreArchivo

 If Not Bac_Sql_Execute("SP_INTERFAZ_DEUDORES_TRADER") Then
    MsgBox "Problemas al leer operaciones", vbCritical, "MENSAJE"
    Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "ERROR Interfaz de Deudores CO15 NO REALIZADA  " & cNomArchivo & err.Number & " Descripción: " & err.Description)
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
   
 Do While Bac_SQL_Fetch(Datos())
        
     If Prg.Max >= 10 Then Prg.Max = Datos(1)
      
     Rut = BacValidaRut((Datos(4)), 0)
     dig = devolver
      
     rut1 = BacValidaRut((Datos(2)), 0)
     dig1 = devolver
      
     cLine = ""
     cLine = cLine & IIf(Datos(2) = "0", Space(15), ESPACIOS_CL(Trim(Str(Datos(2))) + dig1, 15, "D")) & ESPACIOS_CL((Datos(3)), 16, "D") & IIf(Datos(4) = "0", Space(15), ESPACIOS_CL(Trim(Str(Datos(4))) + dig, 15, "D"))
     cLine = cLine & Datos(5) & Datos(6) & Format(saca_punto(Trim(Str(Datos(7))), 2), "00000") & Datos(8)
              
     If Len(cLine) <> 56 Then
            p = p
     End If
     
    totalreg = totalreg + 1
    p = p + 1
    Print #1, cLine
    Prg.Max = p
    Prg.Value = p
    Loop
    
    Close #1
       
    MsgBox "Interfaz de Deudores CO15" & " " & cNomArchivo & "(Cant.Reg. " & totalreg & ")", vbOKOnly, "MENSAJE"
    Prg.Visible = False
    Label2.Visible = False
    Exit Sub
   
Herror1:
  MsgBox "Error: " & err.Number & " Descripción: " & err.Description, vbCritical, "Interfaz"
  Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "ERROR Interfaz de Deudores CO15 NO REALIZADA  " & cNomArchivo & err.Number & " Descripción: " & err.Description)
  Exit Sub



End Sub

Private Sub C14()
        
        Prg.Value = 0
        CPrg = 0
        Label2.Visible = True
        Prg.Visible = True 'Barra
        SQL = ""
        Envia = Array("")
                
        
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
        Envia = Array(cmbAño)
        
        If Not Bac_Sql_Execute("SP_INTCERSII", Envia) Then
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
Dim SW             As Integer
Dim NroFax         As String
Dim NumeroFax      As String
Dim NroTel         As String
Dim NumeroTel      As String
Dim nrocal         As String
Dim nrocalidad     As String
 
On Error GoTo Herror1
    X = 0
    Punto = "."
    cDia = Format(gsBac_Fecp, "YYMMDD")
   cNomArchivo = Directorio.Path & "\" & NombreArchivo
   MousePointer = 11
 
    SQL = "SP_INTERFAZ_CLIENTE"
  
    If Not Bac_Sql_Execute(SQL) Then
        MsgBox "Problemas al ejecutar procedimiento " & SQL, vbCritical, "MENSAJE"
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
        NroTel = Mid$(Datos(11), 1, 7)
        NumeroTel = Format(Val(NroTel), "00000000000")
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
    
    cLine = cLine & Space(40) & Space(40) & ESPACIOS_CL(("9999"), 8, "D") & ESPACIOS_CL(("9999"), 8, "D") & Ceros("", 11) & Space(1) & Space(8) & ESPACIOS_CL((Datos(23)), 8, "D") & ESPACIOS_CL("9999", 8, "D")
    
    cLine = cLine & "0000" & Space(8) & "00" & Space(8) & Space(15) & Space(40) & Space(20) & Space(20)
    
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

Sub InterfazBalance()

    Dim Total          As Integer
    Dim totalreg       As Long
    Dim cDia           As String
    Dim cNomArchivo    As String
    Dim cLine          As String
    Dim NumeroTel      As String

    On Error GoTo Herror1
 
    Total = 0
    totalreg = 0
    cNomArchivo = ""
    cDia = Format(gsBac_Fecp, "ddmmyy")
    cNomArchivo = Directorio.Path & "\" & NombreArchivo
    
    Screen.MousePointer = vbHourglass
    
    If Not Bac_Sql_Execute("SP_INTERFAZ_BALANCE_TRADER") Then
        Screen.MousePointer = vbDefault
        MsgBox "Problemas al leer operaciones", vbCritical, "MENSAJE"
        Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "ERROR Interfaz de Balance BO15 NO REALIZADA  " & cNomArchivo & err.Number & " Descripción: " & err.Description)
        Exit Sub
    End If
  
    CPrg = 0
 
''''    Prg.Visible = True
''''    Prg.Value = 0
    
    Pnl_Progreso.Visible = True
    Pnl_Progreso.FloodPercent = 0
    
    p = 0

    If Dir(cNomArchivo) <> "" Then
       Kill cNomArchivo
    End If
    
    Open cNomArchivo For Output As #1
      
    Do While Bac_SQL_Fetch(Datos())
 
''''    If Prg.Max >= 10 Then Prg.Max = datos(1)
        
        If Datos(13) <> 0 And Datos(15) <> 0 Then
            cLine = ""
            cLine = cLine & ESPACIOS_CL((Datos(2)), 3, "D")
            cLine = cLine & Format(gsBac_Fecp, "yyyymmdd")
            cLine = cLine & ESPACIOS_CL((Datos(3)), 14, "D")
            cLine = cLine & "001"
            cLine = cLine & ESPACIOS_CL((Datos(4)), 4, "D")
            cLine = cLine & ESPACIOS_CL((Datos(5)), 4, "D")
            cLine = cLine & ESPACIOS_CL((Datos(6)), 16, "D")
            cLine = cLine & Space(1)
            cLine = cLine & "M"
            cLine = cLine & ESPACIOS_CL((Datos(7)), 20, "D")
            cLine = cLine & Format(gsBac_Fecp, "yyyymmdd")
            cLine = cLine & ESPACIOS_CL(Datos(9) & (String(16 - Len(Datos(9)), "0")), 20, "D")
            cLine = cLine & Format(Datos(18), "00") & Datos(10)
            cLine = cLine & ESPACIOS_CL((Datos(11)), 3, "D")
            cLine = cLine & Datos(12)
            cLine = cLine & Format(saca_punto(Trim(Str(Datos(13))), 2), "000000000000000000")
            cLine = cLine & Datos(14)
            cLine = cLine & Format(saca_punto(Trim(Str(Datos(15))), 2), "000000000000000000")
            cLine = cLine & Datos(16)
            cLine = cLine & Format(saca_punto(Trim(Str(Datos(13))), 2), "000000000000000000")
            cLine = cLine & "1  "
            cLine = cLine & Space(10)
            
            If Len(cLine) <> 178 Then
               p = p
            End If
            
            p = p + 1
            Print #1, cLine
            

''''            Prg.Max = p
''''            Prg.Value = p
        End If
        
        totalreg = totalreg + 1
        Pnl_Progreso.FloodPercent = (totalreg * 100) / Datos(1)
    Loop
    
    cLine = ""
    totalreg = totalreg + 1
    cLine = cLine & ("99" & Format(gsBac_Fecp, "yyyymmdd") & Format(totalreg, "0000000000")) & Space(158)
    Print #1, cLine
    Close #1
    
    Screen.MousePointer = vbDefault
    MsgBox "La Interfaz de Balance BO15 Ha Sido Generada" & vbCrLf & vbCrLf & "Ubicacion" & vbTab & "= " & cNomArchivo & vbCrLf & "Cant.Reg" & vbTab & "= " & totalreg, vbOKOnly + vbInformation, "INTERFACES(BO15)"
''''    Prg.Visible = False
    Pnl_Progreso.Visible = False
    Label2.Visible = False
    Exit Sub
   
Herror1:
    Screen.MousePointer = vbDefault
    MsgBox "Error: " & err.Number & " Descripción: " & err.Description, vbCritical, "Interfaz"
    Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "ERROR Interfaz de Balance BO15 NO REALIZADA  " & cNomArchivo & err.Number & " Descripción: " & err.Description)
    Exit Sub

End Sub

Sub InterfazDirecciones()
 Dim Total          As Integer
 Dim totalreg       As Integer
 Dim cDia           As String
 Dim cNomArchivo    As String
 Dim cLine          As String
 Dim NumeroTel      As String

 On Error GoTo Herror1
 Total = 0
 totalreg = 0
 cNomArchivo = ""
 cDia = Format(gsBac_Fecp, "ddmmyy")
 cNomArchivo = Directorio.Path & "\" & NombreArchivo

 If Not Bac_Sql_Execute("SP_INTERFAZ_DIRECCIONES_TRADER") Then
    MsgBox "Problemas al leer operaciones", vbCritical, "MENSAJE"
    Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "ERROR Interfaz de Direccion DD15 NO REALIZADA  " & cNomArchivo & err.Number & " Descripción: " & err.Description)
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
   
 Do While Bac_SQL_Fetch(Datos())
 
    If Len(Datos(10)) > 11 Then
        NroTel = Mid$(Datos(10), 1, 7)
        NumeroTel = Format(Val(NroTel), "00000000000")
    Else
       NumeroTel = Format(Val(Datos(10)), "00000000000")
    End If
   
     If Prg.Max >= 10 Then Prg.Max = Datos(6)
      
     cLine = ""
     cLine = cLine & ESPACIOS_CL(Datos(3) + Datos(4), 15, "D") & ESPACIOS_CL((Datos(1)), 8, "D") & ESPACIOS_CL((Datos(2)), 8, "D")
     cLine = cLine & ESPACIOS_CL((Datos(5)), 16, "D") & ESPACIOS_CL((Datos(7)), 40, "D") & Space(40) & IIf(Datos(9) = "0", Space(8), ESPACIOS_CL((Datos(8)), 8, "D")) & IIf(Datos(9) = "0", Space(8), ESPACIOS_CL((Datos(9)), 8, "2"))
     cLine = cLine & IIf(NumeroTel = 0, "00000000000", NumeroTel) & Format(Datos(11), "YYYYMMDD")
     
         
     If Len(cLine) <> 162 Then
            p = p
     End If
     
    totalreg = totalreg + 1
    p = p + 1
    Print #1, cLine
    Prg.Max = p
    Prg.Value = p
    Loop
    
    Close #1
       
    MsgBox "Interfaz de Direcciones DD15" & " " & cNomArchivo & "(Cant.Reg. " & totalreg & ")", vbOKOnly, "MENSAJE"
    Prg.Visible = False
    Label2.Visible = False
    Exit Sub
   
Herror1:
  MsgBox "Error: " & err.Number & " Descripción: " & err.Description, vbCritical, "Interfaz"
  Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "ERROR Interfaz de Direccion DD15 NO REALIZADA  " & cNomArchivo & err.Number & " Descripción: " & err.Description)
  Exit Sub

End Sub
Sub InterfazDeudores()
 Dim Total          As Integer
 Dim totalreg       As Integer
 Dim cDia           As String
 Dim cNomArchivo    As String
 Dim cLine          As String
 Dim NumeroTel      As String

 On Error GoTo Herror1
 Total = 0
 totalreg = 0
 cNomArchivo = ""
 cDia = Format(gsBac_Fecp, "ddmmyy")
 cNomArchivo = Directorio.Path & "\" & NombreArchivo

 If Not Bac_Sql_Execute("SP_INTERFAZ_DEUDORES_TRADER") Then
    MsgBox "Problemas al leer operaciones", vbCritical, "MENSAJE"
    Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "ERROR Interfaz de Deudores CO15 NO REALIZADA  " & cNomArchivo & err.Number & " Descripción: " & err.Description)
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
   
 Do While Bac_SQL_Fetch(Datos())
 
 If Prg.Max >= 10 Then Prg.Max = Datos(1)
 
     Rut = BacValidaRut((Datos(4)), 0)
     dig = devolver
      
     rut1 = BacValidaRut((Datos(2)), 0)
     dig1 = devolver
      
     cLine = ""
     cLine = cLine & IIf(Datos(2) = "0", Space(15), ESPACIOS_CL(Trim(Str(Datos(2))) + dig1, 15, "D")) & ESPACIOS_CL((Datos(3)), 16, "D") & IIf(Datos(4) = "0", Space(15), ESPACIOS_CL(Trim(Str(Datos(4))) + dig, 15, "D"))
     cLine = cLine & Datos(5) & Datos(6) & Format(saca_punto(Trim(Str(Datos(7))), 2), "00000") & Datos(8)

     

    totalreg = totalreg + 1
    p = p + 1
    Print #1, cLine
    Prg.Max = p
    Prg.Value = p
    Loop
    
    Close #1
       
    MsgBox "Interfaz de Deudores CO15" & " " & cNomArchivo & "(Cant.Reg. " & totalreg & ")", vbOKOnly, "MENSAJE"
    Prg.Visible = False
    Label2.Visible = False
    Exit Sub
   
Herror1:
  MsgBox "Error: " & err.Number & " Descripción: " & err.Description, vbCritical, "Interfaz"
  Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "ERROR Interfaz de Deudores CO15 NO REALIZADA  " & cNomArchivo & err.Number & " Descripción: " & err.Description)
  Exit Sub

End Sub

Sub Interfazflujosmutuos()

 Dim Total          As Integer
 Dim totalreg       As Double
 Dim cDia           As String
 Dim cNomArchivo    As String
 Dim cLine          As String
 Dim NumeroTel      As String

 On Error GoTo Herror1
 Total = 0
 totalreg = 0
 cNomArchivo = ""
 cDia = Format(gsBac_Fecp, "ddmmyy")
 cNomArchivo = Directorio.Path & "\" & NombreArchivo
 Screen.MousePointer = 11
 If Not Bac_Sql_Execute("SP_INTERFAZ_FLUJO_TRADER") Then
    Screen.MousePointer = 0
    MsgBox "Problemas al leer operaciones", vbCritical, "MENSAJE"
    Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "ERROR Interfaz de Flujos FL15 NO REALIZADA  " & cNomArchivo & err.Number & " Descripción: " & err.Description)
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
   
 Do While Bac_SQL_Fetch(Datos())
 
    If Prg.Max >= 10 Then Prg.Max = Datos(1)
      
     cLine = ""
     cLine = cLine & ESPACIOS_CL((Datos(2)), 3, "D") & Format(gsBac_Fecp, "yyyymmdd") & ESPACIOS_CL((Datos(3)), 14, "D")
     cLine = cLine & ESPACIOS_CL((Datos(4)), 3, "D") & ESPACIOS_CL(("MD01"), 16, "D") & ESPACIOS_CL((Datos(6)), 20, "D") & Format(Datos(7), "yyyymmdd")
     cLine = cLine & Format(saca_punto(Trim(Str(Datos(8))), 2), "000000000000000000") & Format(saca_punto(Trim(Str(Datos(9))), 2), "000000000000000000")
     cLine = cLine & Format(saca_punto(Trim(Str(Datos(10))), 2), "000000000000000000") & "1  " & Space(10)
     If Len(cLine) <> 139 Then
            p = p
     End If
     
     totalreg = totalreg + 1
     p = p + 1
     Print #1, cLine
     Prg.Max = p
     Prg.Value = p
     Loop
    
    cLine = ""
    totalreg = totalreg + 1
    cLine = cLine & ("99" & Format(gsBac_Fecp, "yyyymmdd") & Format(totalreg, "0000000000")) & Space(119)
    Print #1, cLine
    Close #1

    MsgBox "Interfaz de Flujos Mutuos FL15" & " " & cNomArchivo & "(Cant.Reg. " & totalreg & ")", vbOKOnly, "MENSAJE"
    Screen.MousePointer = 0
    Prg.Visible = False
    Label2.Visible = False
    Exit Sub
   
Herror1:
  MsgBox "Error: " & err.Number & " Descripción: " & err.Description, vbCritical, "Interfaz"
  Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "ERROR Interfaz de Flujos Mutuos FL15 NO REALIZADA  " & cNomArchivo & err.Number & " Descripción: " & err.Description)
  Exit Sub


End Sub

Public Sub InterfazOperaciones()
    
    Dim Total          As Long
    Dim totalreg       As Long
    Dim cDia           As String
    Dim cNomArchivo    As String
    Dim cLine          As String
    
    On Error GoTo Herror1
 
    Total = 0
    totalreg = 0
    cNomArchivo = ""
    cDia = Format(gsBac_Fecp, "ddmmyy")
    cNomArchivo = Directorio.Path & "\" & NombreArchivo
 
    Screen.MousePointer = vbHourglass
 
    If Not Bac_Sql_Execute("SP_INTERFAZ_OPERACIONES_TRADER") Then
        MsgBox "Problemas al leer operaciones", vbCritical, "MENSAJE"
        Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "ERROR Interfaz de Operaciones OP15  NO REALIZADA  " & cNomArchivo & err.Number & " Descripción: " & err.Description)
        Screen.MousePointer = vbDefault
        Exit Sub
    End If
  
    CPrg = 0
 
''''    Prg.Visible = True
''''    Prg.Value = 0
    Pnl_Progreso.Visible = True
    Pnl_Progreso.FloodPercent = 0
    
    p = 0
    totalreg = 0

    If Dir(cNomArchivo) <> "" Then
        Kill cNomArchivo
    End If

    Open cNomArchivo For Output As #1
  
    Do While Bac_SQL_Fetch(Datos())
   
''''        If Prg.Max >= 10 Then Prg.Max = Datos(24)
        totalreg = totalreg + 1
            
        cLine = ""
        cLine = cLine & "CL "
        cLine = cLine & ESPACIOS_CL((Datos(1)), 8, "D")
        cLine = cLine & Format(gsBac_Fecp, "YYYYMMDD")
        cLine = cLine & ESPACIOS_CL("OP15", 14, "D")
        cLine = cLine & "001"
        cLine = cLine & "1  "
        cLine = cLine & ESPACIOS_CL((Datos(2)), 3, "D")
        cLine = cLine & "1"
        cLine = cLine & "MDIR"
        cLine = cLine & ESPACIOS_CL((Datos(4)), 4, "D")
        cLine = cLine & ESPACIOS_CL("MD01", 16, "D")
        cLine = cLine & Space(1)
        cLine = cLine & "M"
        cLine = cLine & ESPACIOS_CL((Datos(9)), 8, "D")
        cLine = cLine & ESPACIOS_CL((Datos(28)), 8, "D")
        cLine = cLine & ESPACIOS_CL(Datos(5) + Datos(6), 12, "D")
        cLine = cLine & IIf(Datos(7) = 0, Space(10), ESPACIOS_CL(Str(Datos(7)), 10, "D"))
        cLine = cLine & ESPACIOS_CL(Trim(Str(Datos(8))), 20, "D")
        cLine = cLine & Datos(9)
        cLine = cLine & Datos(10) '20
        cLine = cLine & Space(8)
        cLine = cLine & "V"
        cLine = cLine & ESPACIOS_CL((Datos(11)), 3, "D")
        cLine = cLine & Datos(12)
        cLine = cLine & Format(saca_punto(Trim(Str(Datos(13))), 2), "000000000000000000")
        cLine = cLine & Datos(14)
        cLine = cLine & Format(saca_punto(Trim(Str(Datos(15))), 2), "000000000000000000")
        cLine = cLine & Ceros("", 18)
        cLine = cLine & Datos(16)
        cLine = cLine & Format(saca_punto(Trim(Str(Datos(17))), 2), "000000000000000000")
        cLine = cLine & Datos(29)
        cLine = cLine & Format(saca_punto(Trim(Str(Datos(30))), 2), "000000000000000000")
        cLine = cLine & Datos(31)
        cLine = cLine & Format(saca_punto(Trim(Str(Datos(32))), 2), "000000000000000000")
        cLine = cLine & ESPACIOS_CL((Datos(18)), 2, "D")
        cLine = cLine & ESPACIOS_CL((Datos(33)), 4, "D")
        cLine = cLine & Replace(Format(Datos(34), "00000000.00000000"), gsBac_PtoDec, "")
        cLine = cLine & Ceros("", 16)
        cLine = cLine & Datos(45)
        cLine = cLine & Ceros("", 16) '40
        cLine = cLine & Space(5)
        cLine = cLine & Space(4)
        cLine = cLine & Ceros("", 16)
        cLine = cLine & Ceros("", 16)
        cLine = cLine & Replace(Format(Datos(48), "00000000.00000000"), gsBac_PtoDec, "")   'Ceros("", 16)
        cLine = cLine & Datos(25)
        cLine = cLine & "+"
        cLine = cLine & Ceros("", 18)
        cLine = cLine & Format(Datos(46), "000")
        cLine = cLine & "00" '50
        cLine = cLine & "0"
        cLine = cLine & "+"
        cLine = cLine & Ceros("", 18)
        cLine = cLine & Space(8)
        cLine = cLine & Space(8)
        cLine = cLine & Space(8)
        cLine = cLine & Space(8)
        cLine = cLine & ESPACIOS_CL((Datos(27)), 20, "D")
        cLine = cLine & Format(Datos(35), "0000")
        cLine = cLine & Ceros("", 4) '60
        cLine = cLine & Format(Datos(36), "0000")
        cLine = cLine & Datos(47)
        cLine = cLine & Space(8)
        cLine = cLine & Space(8)
        cLine = cLine & "N"
        cLine = cLine & Space(8)
        
        If Datos(18) = "V" Then
            cLine = cLine & Datos(37)
            cLine = cLine & Datos(28)
        Else
            cLine = cLine & Space(8)
            cLine = cLine & Space(8)
        End If
        
        cLine = cLine & Format(saca_punto(Trim(Str(Datos(38))), 2), "000000000000000000")
        cLine = cLine & Ceros("", 18) '70
        cLine = cLine & Ceros("", 18)
        cLine = cLine & Ceros("", 18)
        cLine = cLine & Ceros("", 18)
        cLine = cLine & Format(saca_punto(Trim(Str(Datos(39))), 2), "000000000000000000")
        cLine = cLine & Ceros("", 18)
        cLine = cLine & Ceros("", 18)
        cLine = cLine & Space(1)
        cLine = cLine & Format(saca_punto(Trim(Str(Datos(20))), 2), "000000000000000000")
        cLine = cLine & Format(saca_punto(Trim(Str(Datos(21))), 2), "000000000000000000")
        cLine = cLine & Datos(40) '80
        cLine = cLine & Ceros("", 3)
        cLine = cLine & Format(Datos(41), "0000")
        cLine = cLine & Ceros("", 18)
        cLine = cLine & Space(1)
        cLine = cLine & IIf(Val(Datos(49)) = 0, Space(1), Datos(49)) '85
        cLine = cLine & Space(1)
        cLine = cLine & Format(saca_punto(Trim(Str(Datos(23))), 2), "000000000000")
        cLine = cLine & ESPACIOS_CL((Datos(42)), 5, "D")
        cLine = cLine & ESPACIOS_CL((Datos(43)), 15, "D")
        cLine = cLine & Space(4)
        cLine = cLine & Space(4)
        cLine = cLine & Space(3)
        cLine = cLine & Ceros("", 16)
        cLine = cLine & Ceros("", 4) '94
             
        '>>>> Agregado con Fecha 18-Agosto-2008.- Cambio Estructura Interfaz Neosoft
        cLine = cLine & Format("0", "000000000000000000") '--> Ceros("0", 19) '--> Monto Mora 4 en Moneda Local (18,2) [90  y -365 Días]
        cLine = cLine & Format("0", "000000000000000000") '--> Ceros("0", 18) '--> Monto Mora 5 en Moneda Local (18,2) [365 y -  3 Años]
        cLine = cLine & Format("0", "000000000000000000") '--> Ceros("0", 18) '--> Monto Mora 6 en Moneda Local (18,2) [3   Años y Mas]
        cLine = cLine & "S"            '--> Indicador Sbif               (1)
        cLine = cLine & Format("0", "000000000000000000") '--> Ceros("0", 18) '--> Otros cobros para Mora       (18,2)
             
        '>>>>> Se Agrega en requerimiento N° 8136
        cLine = cLine & Format("0", "000000000000000000") '--> Monto Mora 2 en Moneda Local (lcy_pdo7_amt)
        cLine = cLine & Format("0", "000000000000000000") '--> Monto Mora 7 en Moneda Local (lcy_pdo8_amt)
        cLine = cLine & Format("0", "000000000000000000") '--> Monto Mora 9 en Moneda Local (lcy_pdo9_amt)
        cLine = cLine & " "                                '--> Origen del Activo            (assets_origin)
        '>>>>> Se Agrega en requerimiento N° 8136

        p = p + 1
        Print #1, cLine
        
        Pnl_Progreso.FloodPercent = ((totalreg * 100) / Datos(24))
    Loop
    
    cLine = ""
    totalreg = totalreg + 1
    
    cLine = cLine & ("99" & Format(gsBac_Fecp, "yyyymmdd") & Format(totalreg, "0000000000") & Space(786))
    
    Print #1, cLine
    Close #1
    Screen.MousePointer = vbDefault
    MsgBox "La Interfaz de Operaciones OP15 Ha Sido Generada" & vbCrLf & vbCrLf & "Ubicacion" & vbTab & "= " & cNomArchivo & vbCrLf & "Cant.Reg" & vbTab & "= " & totalreg, vbOKOnly + vbInformation, "INTERFACES(OP15)"

    Prg.Visible = False
    Label2.Visible = False
    Exit Sub
   
Herror1:
   MsgBox "Error: " & err.Number & " Descripción: " & err.Description, vbCritical, "Interfaz"
   Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "ERROR Interfaz de Operaciones OP15 NO REALIZADA  " & cNomArchivo & err.Number & " Descripción: " & err.Description)
   Exit Sub


End Sub



'Función que quita las comas dependiendo del formato windows
'Al SqlServer no se le puede pasar un valor numérico con comas
Public Function BacStrTran(sCadena$, sFind$, sReplace$) As String
   
   Dim iPos%
   Dim iLen%
         
   If Trim$(sCadena$) = "" Then
      sCadena$ = "0"

   End If
   
   If sFind$ <> sReplace$ Then
   
    iPos% = 1
    
    iLen% = Len(sFind$)
    
    Do While True
       iPos% = InStr(1, sCadena$, sFind$)
       
       If iPos% = 0 Then
          Exit Do
          
       End If
       
       sCadena$ = Mid$(sCadena$, 1, iPos% - 1) + sReplace$ + Mid$(sCadena$, iPos% + iLen%)
    
    Loop
   
   End If
   
   BacStrTran = Trim$(CStr(sCadena$))
    
End Function

Sub Clientes()

 Dim cLine          As String
 Dim cNomArchivo    As String
 Dim cDia           As String
 Dim cruta          As String
 Dim Datos
 Dim Punto          As String
 Dim p              As Long
 Dim Conta          As Integer
 Dim SW             As Integer
 Dim NroFax         As String
 Dim NumeroFax      As String
 Dim NroTel         As String
 Dim NumeroTel      As String
 Dim nrocal         As String
 Dim nrocalidad     As String
 
 On Error GoTo Herror1
 X = 0
 Punto = "."
 cDia = Format(gsBac_Fecp, "YYMMDD")
 cNomArchivo = gsBac_DIRIN & "\" & NombreArchivo '& ".DAT"
 MousePointer = 11
 
 SQL = "SP_INTERFAZ_CLIENTE " & "'T'"
  
 If Not Bac_Sql_Execute(SQL) Then
    MsgBox "Problemas al ejecutar procedimiento " & SQL, vbCritical, "MENSAJE"
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
    SQL = "SP_INTERFAZ_CLIENTE " & "'F'"
      
     If Not Bac_Sql_Execute(SQL) Then
        MsgBox "Problemas al ejecutar procedimiento " & SQL, vbCritical, "MENSAJE"
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
        NroTel = Mid$(Datos(11), 1, 7)
        NumeroTel = Format(Val(NroTel), "00000000000")
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
        SQL = ""
        Envia = Array("")
        
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

Private Sub CTACTEII()
        Monto = 0
        Prg.Value = 0
        CPrg = 0
        Label2.Visible = True
        Prg.Visible = True 'Barra
        SQL = ""
        Envia = Array("")
        
        If Not Bac_Sql_Execute("SP_INTERFAZ_CTACTEII") Then
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
               If UCase(Datos(1)) = "OK" Then
                    Exit Do
                End If
                 Linea = ""
                 Linea = Ceros("", 9) & Ceros("", 5) & Ceros("", 2)
                 Linea = Linea & Format(gsBac_Fecp, "yyyymmdd") & Format(Time, "hhmmss")
                 Linea = Linea & "0071" & "MDT" & Ceros(Trim(Datos(1)), 5) & Trim(Datos(1))
                 Linea = Linea & Ceros("", 4)
                 Linea = Linea & Ceros(Int(Datos(2)), 13) & Int(Datos(2))
                 Deci = SacaDecim(Round(CDbl(Datos(2)) - Int(Datos(2)), 4))
                 Linea = Linea & Mid(Trim(Deci), 1, 4) & Ceros(Trim(Deci), 4)
'                Linea = Linea & Ceros("", 3)
                 Linea = Linea & Format(Val(Datos(7)), "00000000")
                 Linea = Linea & Trim(Datos(3)) & "2" & Ceros("", 12)
                 Linea = Linea & Format(Val(Datos(7)), "00000000")
                 Linea = Linea & Ceros("", 4) & Ceros("", 4) & Space(30)
                 Linea = Linea & ESPACIOS(Trim(Datos(4)), 9) & Trim(Datos(4))
                 Linea = Linea & Space(18)
                 Monto = Monto + Datos(2)
                 p = p + 1
                 Print #1, Linea
                 Prg.Max = p
                 BacControlWindows 20
                 Prg.Value = p
            Loop
            
            Linea = ""
            Linea = String(16, "9") & Format(gsBac_Fecp, "yyyymmdd") & Ceros("", 10) & "MDT"
            Linea = Linea & Ceros("", 9)
            Linea = Linea & Ceros(Int(Monto), 14) & Int(Monto)
            Deci = SacaDecim(Round(CDbl(Monto) - Int(Monto), 4))
            Linea = Linea & Mid(Trim(Deci), 1, 4) & Ceros(Trim(Deci), 4)
            Linea = Linea & Ceros(Trim(p - 1), 8) & Trim(p - 1) & Space(88)
            Print #1, Linea
            Close #1
            Screen.MousePointer = 0
            MsgBox ("Interfaz Cuentas Corrientes II Generada Correctamente  "), vbInformation, ("BacTrader")
            Prg.Visible = False
            Label2.Visible = False
            
            
            
            If Not Enviar_por_ftp(gsBac_DIRIN, "CTACTE.TXT") Then
                 MsgBox "Interfaz " & NOMBRE & "  via FTP no fue traspasada ", vbCritical
            End If
            
         End If

End Sub



Private Sub GESTION()
        Dim Fecha As String
        Prg.Value = 0
        CPrg = 0
        Label2.Visible = True
        Prg.Visible = True 'Barra
        SQL = ""
        Envia = Array()
        Fecha = cmbAño & IIf(cmbMes.ItemData(cmbMes.ListIndex) < 10, "0" & cmbMes.ItemData(cmbMes.ListIndex), cmbMes.ItemData(cmbMes.ListIndex)) & Right(Format(gsBac_Fecp, "yyyymmdd"), 2)
        AddParam Envia, Fecha
        If Not Bac_Sql_Execute("SP_INTERFAZ_GESTION", Envia) Then
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
              If Datos(1) <> "OK" Then
                 Linea = ""
                 Linea = Ceros(Trim(Datos(1)), 9) & Trim(Datos(1))
                 Linea = Linea & Ceros("", 12) & Ceros(Trim(Datos(4)), 12) & Trim(Datos(4))
                 Linea = Linea & Ceros(Trim(Datos(2)), 15) & Trim(Datos(2)) & "00"
                 Linea = Linea & Left(Trim(Datos(1)), 6) & Ceros(Trim(Datos(3)), 6) & Trim(Datos(3))
                 Linea = Linea & Ceros("", 3) & Mid$(Format(gsBac_Fecp, "yyyymmdd"), 1, 6)
                 Linea = Linea & "007110" & Ceros("", 6)
                 Linea = Linea & " " 'ESPACIOS(Trim(datos(5)), 1) & Trim(datos(5))
                 p = p + 1
                 Print #1, Linea
                 Prg.Max = p
                 BacControlWindows 20
                 Prg.Value = p
              End If
            Loop
            Close #1
            Screen.MousePointer = 0
            MsgBox ("Interfaz Gestion Generada Correctamente"), vbInformation, ("BacTrader")
            Prg.Visible = False
            Label2.Visible = False
            
            
If Not Enviar_por_ftp(gsBac_DIRIN, "Mdinges.DAT") Then
                 MsgBox "Interfaz " & NOMBRE & "  via FTP no fue traspasada ", vbCritical
End If
         End If

End Sub

Sub InterfazPosicion()
 
 Dim Total          As Integer
 Dim totalreg       As Integer
 Dim cDia           As String
 Dim cNomArchivo    As String
 Dim cLine          As String
 Dim Suma           As Double
 Dim EXPUC8         As String
 
 On Error GoTo Herror1
 Total = 0
 totalreg = 0
 cNomArchivo = ""
 cDia = Format(gsBac_Fecp, "ddmmyy")
 cNomArchivo = Directorio.Path & "\" & NombreArchivo
 
 Screen.MousePointer = 11
   If Not Bac_Sql_Execute("SP_INTERFAZ_POSICION_CLIENTE") Then
        MsgBox "Problemas al leer operaciones", vbCritical, "MENSAJE"
            Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "ERROR Interfaz Posición del Cliente PC15  NO REALIZADA  " & cNomArchivo & err.Number & " Descripción: " & err.Description)
            Screen.MousePointer = 0
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
   
   Do While Bac_SQL_Fetch(Datos())
     
     If Prg.Max >= 10 Then Prg.Max = Datos(1)
     
     'Suma = 0
     'If datos(7) = "70" Then
     '   Suma = Val(datos(33)) + Val(datos(35)) + Val(datos(36))
     'Else
     '   Suma = Val(datos(33)) + Val(datos(35)) + Val(datos(36))
     'End If
     
     If Datos(36) < 0 Then
        EXPUC8 = "-"
     Else
        EXPUC8 = "+"
     End If
     
     cLine = ""
'     cLine = cLine & datos(2) & datos(3) & "999" & Ceros((datos(5)), 16) + (datos(5))
     cLine = cLine & Datos(2) & Datos(3) & ESPACIOS_CL(Trim(Str(Datos(4))), 3, "I") & Ceros((Datos(5)), 16) + (Datos(5))
     cLine = cLine & Ceros("", 8) & Ceros("", 12) & ESPACIOS_CL((Datos(6)), 4, "D") & ESPACIOS_CL((Datos(7)), 2, "D") & ESPACIOS_CL((Datos(8)), 4, "D") & Ceros((Datos(9)), 2) + Datos(9)
     cLine = cLine & Ceros("", 9) & Space(4) & Space(4) & "CL  " & Space(4) & Space(4) & IIf(Datos(10) = "0", Space(4), ESPACIOS_CL((Datos(10)), 4, "D")) & ESPACIOS_CL((Datos(11)), 4, "D") & Space(4) & Space(4) & Space(6) & Space(4) & Space(4) ''25
     cLine = cLine & Space(4) & ESPACIOS_CL(EXPUC8, 4, "D") & Space(1) & Space(4) & "BTR " & Ceros("", 12) & ESPACIOS_CL((Datos(12)), 35, "D") & Ceros((Datos(13)), 2) + (Datos(13)) & Ceros((Datos(14)), 2) + (Datos(14))
     
     cLine = cLine & Ceros((Datos(15)), 4) + (Datos(15)) & ESPACIOS_CL((Datos(16)), 4, "D") & ESPACIOS_CL((Datos(17)), 16, "D") & Ceros("", 12) & ESPACIOS_CL(Datos(18) + Datos(19), 15, "D")
     cLine = cLine & Space(4) & Ceros("", 6) & Datos(20) & Space(1) & Space(4) & Space(4) & Ceros((Datos(21)), 2) + (Datos(21)) & Ceros((Datos(22)), 2) + (Datos(22)) & Ceros((Datos(23)), 4) + (Datos(23))
     cLine = cLine & Ceros((Datos(24)), 2) + (Datos(24)) & Ceros((Datos(25)), 2) + (Datos(25)) & Ceros((Datos(26)), 4) + (Datos(26)) & Ceros("", 2) & Ceros("", 2) & Ceros("", 4) & Ceros("", 3) & Ceros("", 4) & Ceros("", 1)
     cLine = cLine & Format(saca_punto(Trim(Str(Datos(27))), 6), "000000000") & Ceros((Datos(28)), 4) + (Datos(28)) & Format(saca_punto(Trim(Str(Datos(29))), 6), "000000000") & Ceros("", 9) & Ceros("", 2) & Ceros("", 2) & Ceros("", 4)
     cLine = cLine & Ceros("", 2) & Ceros("", 2) & Ceros("", 4) & Ceros("", 2) & Ceros("", 2) & Ceros("", 4) & Ceros("", 2) & Ceros("", 2) & Ceros("", 4) & Format(saca_punto(Trim(Str(Datos(30))), 2), "000000000000000")
     cLine = cLine & Format(saca_punto(Trim(Str(Datos(31))), 2), "000000000000000") & Ceros("", 15) & Ceros("", 15) & Replace(Format(Datos(42), "00000.000000"), gsBac_PtoDec, "") & Ceros("", 15) & Ceros("", 15) & Space(4) & Space(4) & Space(4) & Space(4) & Format(saca_punto(Trim(Str(Datos(32))), 2), "000000000000000")
     cLine = cLine & Format(saca_punto(Trim(Str(Datos(33))), 2), "000000000000000") & Format(saca_punto(Trim(Str(Datos(34))), 2), "000000000000000") & Format(saca_punto(Trim(Str(Datos(35))), 2), "000000000000000")
     cLine = cLine & Format(saca_punto(Trim(Str(Datos(36))), 2), "000000000000000") & Ceros("", 15) & Ceros("", 15) & Ceros("", 15) & Ceros("", 15) & Ceros("", 15) & Ceros("", 15) & Ceros("", 15)
     cLine = cLine & Format(saca_punto(Trim(Str(Datos(43))), 2), "000000000000000") & Ceros("", 15) & Ceros("", 15) & Ceros("", 15) & Space(4) & Ceros("", 2) & Ceros("", 2) & Ceros("", 4) & Ceros("", 15) & Ceros("", 15) & Ceros("", 15)
     cLine = cLine & Ceros("", 4) & Ceros("", 4) & Ceros("", 4) & Ceros("", 2) & Ceros("", 2) & Ceros("", 4) & Ceros("", 4) & Ceros("", 4) & Ceros("", 4) & Ceros("", 4) & Ceros("", 2) & Ceros("", 2) & Ceros("", 4) & Space(2)
     cLine = cLine & Space(4) & Ceros("", 9) & Space(15) & Format(saca_punto(Trim(Str(Datos(38))), 2), "000000000000000") & Ceros("", 2) & Ceros("", 2) & Ceros("", 4) & Datos(39) & "X" & Datos(41)
          
         
     If Len(cLine) <> 864 Then
            p = p
     End If
     
    totalreg = totalreg + 1
    p = p + 1
    Print #1, cLine
    Prg.Max = p
    Prg.Value = p
    Loop
    Close #1
      
    MsgBox "Interfaz Posición del Cliente PC15  Generada" & " " & cNomArchivo & "(Cant.Reg. " & totalreg & ")", vbOKOnly, "MENSAJE"
    Screen.MousePointer = 0
    Prg.Visible = False
    Label2.Visible = False
    Exit Sub
   
Herror1:
   MsgBox "Error: " & err.Number & " Descripción: " & err.Description, vbCritical, "Interfaz"
   Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "ERROR Interfaz Posición del Cliente PC15  NO REALIZADA  " & cNomArchivo & err.Number & " Descripción: " & err.Description)
   Exit Sub

End Sub
Private Sub RCC()

        Prg.Value = 0
        CPrg = 0
        Label2.Visible = True
        Prg.Visible = True 'Barra
        SQL = ""
        Envia = Array("")
        
        If Not Bac_Sql_Execute("SP_INTERFAZ_RCC") Then
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
                If UCase(Datos(1)) = "OK" Then
                    Exit Do
                End If
                 Linea = Ceros(Trim(Datos(1)), 9) & Trim(Datos(1))
                 Linea = Linea & Ceros(Trim(Datos(2)), 1) & Trim(Datos(2))
                 Linea = Linea & Ceros(Trim(Datos(3)), 10) & Trim(Datos(3))
                 Linea = Linea & Ceros(Trim(Datos(4)), 10) & Trim(Datos(4))
                 Linea = Linea & Format(Val(Datos(5)), "00")
                 Linea = Linea & Ceros(Trim(Datos(6)), 1) & Trim(Datos(6))
                 Linea = Linea & Mid(Datos(7), 3, 6)
                 Linea = Linea & Mid(Datos(8), 3, 6)
                 Linea = Linea & Mid(Datos(9), 3, 6)
                 Linea = Linea & Trim(Datos(10))
                 Linea = Linea & "V"
                 Linea = Linea & Ceros(Int(Datos(11)), 3) & Int(Datos(11))
                 Deci = Mid(SacaDecim(CDbl(Datos(11)) - Int(Datos(11))), 1, 3)
                 Linea = Linea & Mid(Trim(Deci), 1, 3) & Ceros(Left(Trim(Deci), 3), 3)
                 
                 Linea = Linea & Ceros(Int(Datos(12)), 11) & Int(Datos(12))
                 
                 Linea = Linea & Ceros(Int(Datos(13)), 9) & Int(Datos(13))
                 Deci = Mid(SacaDecim(CDbl(Datos(13)) - Int(Datos(13))), 1, 2)
                 Linea = Linea & Mid(Trim(Deci), 1, 2) & Ceros(Trim(Deci), 2)
                 Linea = Linea & "153" & Ceros(Trim(Datos(14)), 5) & Trim(Datos(14))
                 Linea = Linea & Ceros((Datos(15)), 9) & Trim(Datos(15))
                 p = p + 1
                 Print #1, Linea
                 Prg.Max = p
                 BacControlWindows 20
                 Prg.Value = p
            Loop
            Close #1
            Screen.MousePointer = 0
            MsgBox ("Interfaz RCC Generada Correctamente"), vbInformation, ("BacTrader")
            Prg.Visible = False
            Label2.Visible = False
            
            If Not Enviar_por_ftp(gsBac_DIRIN, "RCC.TXT") Then
                 MsgBox "Interfaz " & cNomArchivo & "  via FTP no fue traspasada ", vbCritical
            End If
            
            
         End If

End Sub


Function SacaDecim(Num) As String
Dim Dec As String
Dim Desde As Integer
 
 
Desde = (InStr(1, Num, gsBac_PtoDec) + 1)

If (Desde > 1) Then
    Dec = Mid(Num, Desde, Len(Num))
End If

SacaDecim = IIf(Dec = "", "", Dec)
    

End Function
Private Sub CTACTE()
        Prg.Value = 0
        CPrg = 0
        Label2.Visible = True
        Prg.Visible = True 'Barra
        SQL = ""
        Envia = Array("")
        
        If Not Bac_Sql_Execute("SP_INTERFAZ_CTACTE") Then
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
                 Linea = Format(gsBac_Fecp, "yymmdd") & "0"
                 Linea = Linea & Left(Trim(Datos(1)), 2)
                 Linea = Linea & "00" & Mid(Trim(Datos(1)), 3, 5) & "0" & Right(Trim(Datos(1)), 2)
                 Linea = Linea & Trim(Datos(2)) & ESPACIOS(Trim(Datos(2)), 2) & "18" & "000000"
                 Linea = Linea & Ceros(Trim(Datos(3)), 13) & Trim(Datos(3)) & "00" & "71" & "000000"
                                  
                 p = p + 1
                 Print #1, Linea
                 Prg.Max = p
                 BacControlWindows 20
                 Prg.Value = p
            Loop
            Close #1
            Screen.MousePointer = 0
            MsgBox ("Interfaz Cuentas Corrientes Generada Correctamente"), vbInformation, ("BacTrader")
            Prg.Visible = False
            Label2.Visible = False
            
            If Not Enviar_por_ftp(gsBac_DIRIN, "MDINTCC.DTA") Then
                 MsgBox "Interfaz " & cNomArchivo & "  via FTP no fue traspasada ", vbCritical
            End If
            
         End If

End Sub

Private Sub Contable()

    Dim cNomArchivo   As String
    Dim cDia          As String
    Dim cLine         As String
    Dim Datos()
    Dim iContador     As Long

    On Error GoTo ErrorInterfazContable
   
    Prg.Value = 0
    Prg.Visible = True
    Screen.MousePointer = vbHourglass
   
    '--> Formato del Archivo
    cDia = Mid(Format(gsBac_Fecp, "ddmmyyyy"), 1, 4)
    cNomArchivo = gsBac_DIRCO & "PCTR" & cDia & ".DTA"
    '--> Formato del Archivo
   
    If Not Bac_Sql_Execute("SP_INTER_CONSOLI") Then
        MsgBox "Ha ocurrido un error al intentar genrar la interfaz: " & cNomArchivo, vbCritical, TITSISTEMA
        Screen.MousePointer = vbDefault
        Exit Sub
    End If
    
    cLine = ""
    Do While Bac_SQL_Fetch(Datos())
        iContador = iContador + 1
        
        If iContador = 1 Then
            Prg.Max = Val(Datos(27))
        End If
        
        Prg.Value = Prg.Value + 1
        Me.Refresh
        Call BacControlWindows(1)
      
        cLine = cLine & Datos(1)
        cLine = cLine & Datos(2)
        cLine = cLine & Datos(3)
        cLine = cLine & Datos(4)
        cLine = cLine & Datos(5)
        cLine = cLine & Datos(6)
        cLine = cLine & Datos(7)
        cLine = cLine & Datos(8)
        cLine = cLine & Datos(9)
        cLine = cLine & Datos(10)
        cLine = cLine & Datos(11)
        cLine = cLine & Datos(12)
        cLine = cLine & Datos(13)
        cLine = cLine & Datos(14)
        cLine = cLine & Datos(15)
        cLine = cLine & Datos(16)
        cLine = cLine & Datos(17)
        cLine = cLine & Datos(18)
        cLine = cLine & Datos(19)
        cLine = cLine & Datos(20)
        cLine = cLine & Datos(21)
        cLine = cLine & Datos(22)
        cLine = cLine & Datos(23)
        cLine = cLine & Datos(24)
        cLine = cLine & Datos(25)
        cLine = cLine & Datos(26)
        cLine = cLine + Chr(13) + Chr(10)
    Loop
    
    If Dir(NOMBRE) <> "" Then
        Kill (NOMBRE)
    End If

    Open NOMBRE For Binary Access Write As #1
    Put #1, , cLine
    Close #1
   
    MsgBox "Acción Finalizada." & vbCrLf & vbCrLf & "Archivo Contable Generado.... Favor Revisar", vbInformation, TITSISTEMA
    
    Prg.Value = 0
    Prg.Visible = False
        
    Screen.MousePointer = vbDefault
    
    Exit Sub
    
ErrorInterfazContable:
    Screen.MousePointer = vbDefault
    MsgBox "Acción Cancelada." & vbCrLf & vbCrLf & "El archivo no se ha generado.... Favor reintentar.", vbCritical, TITSISTEMA
End Sub


Function Ceros(Dato As String, Largo As Integer) As String
Dim i%
Dim cero%

cero = (Largo - Len(Dato))
For i = 1 To cero
  Ceros = Ceros + "0"
Next i

End Function
Private Sub D3()
Dim Deci As String


    If Not Bac_Sql_Execute("SP_BUSCADOR_DE_CUENTAS") Then
            Screen.MousePointer = 0
            MsgBox "No se puede generar Interfaz ", vbCritical, Msj
            Exit Sub
    
    End If

    Do While Bac_SQL_Fetch(Datos())
    Loop

        Numero = 0
        Prg.Value = 0
        CPrg = 0
        Label2.Visible = True
        Prg.Visible = True 'Barra
        SQL = ""
        Envia = Array("")
               
        If Not Bac_Sql_Execute("SP_INTERFAZ_MDMO") Then
            Screen.MousePointer = 0
            MsgBox "No se puede generar Interfaz ", vbCritical, Msj
            Close #1
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
               If Datos(1) = "NO" Then
                  MsgBox Datos(2), vbCritical, Me.Caption
                  Screen.MousePointer = 0
                  Close #1
                  Exit Sub
               End If
                
                 Linea = Format(Datos(1), "yyyymmdd")                         'Fecha 9(8)
                 Linea = Linea & Ceros(Trim(Datos(2)), 5) & Datos(2)          'Centro de Costo 9(5)
                 Linea = Linea & Ceros(Trim(Datos(3)), 3) & Datos(3)          'Oficina 9(3)
                 Linea = Linea & Datos(4)                                     'Flag-D3 X(1)
                 Linea = Linea & Ceros(Trim(Datos(5)), 3) & Datos(5)          'Ejecutivo 9(3)
                 Linea = Linea & Format(Val(Mid$(Datos(6), 1, 9)), "000000000") 'Rut Cliente X(10)
                 Linea = Linea & Datos(31)                                    'Rut Cliente X(10)
                 Linea = Linea & Datos(7) & ESPACIOS(Trim(Datos(7)), 40)      'Nombre Cliente X(40)
'                Linea = Linea & Ceros(Trim(datos(8)), 11) & datos(8)         'Operacion 9(11)
                 Linea = Linea & Format(Val(Datos(8)), "000000000")
                 Linea = Linea & Format(Val(Datos(30)), "00")                 'Operacion 9(11)
                 Linea = Linea & Datos(9)                                     'Tipo Cuenta X(1)
                 Linea = Linea & Datos(10)                                    'Cuenta Contable 9(10)
                 Linea = Linea & Ceros(Trim(Datos(11)), 15) & Datos(11)       'Monto Pesos 9(15)
                 Linea = Linea & Datos(12)                                    'Signo X(1)
                 Linea = Linea & Ceros(Int(Datos(13)), 11) & Int(Datos(13))   'Signo 9(11)V9(4)
                 Deci = SacaDecim(Round(CDbl(Datos(13)) - Int(Datos(13)), 4))
                 Linea = Linea & Mid(Trim(Deci), 1, 4) & Ceros(Trim(Deci), 4) 'Decimales Monto Anterior
                 Linea = Linea & Datos(14)                                    'Signo X(1)
                 Linea = Linea & Ceros(Int(Datos(15)), 3) & Int(Datos(15))   'Tasa 9(3)V9(2)
                 Deci = SacaDecim(Round(CDbl(Datos(15)) - Int(Datos(15)), 2))
                 Linea = Linea & Mid(Trim(Deci), 1, 2) & Ceros(Trim(Deci), 2) 'Decimales Monto Anterior
                 Linea = Linea & Ceros(Trim(Datos(16)), 3) & Datos(16)        'Moneda 9(3)
                 Linea = Linea & Ceros(Trim(Datos(17)), 5) & Datos(17)        'Plazo 9(5)
                 Linea = Linea & Datos(18)                                    'Sistema X(2)
                 Linea = Linea & Ceros(Trim(Datos(19)), 2) & Datos(19)        'Numero Lineas 9(2)
                 Linea = Linea & Format(Datos(20), "yyyymmdd")                'Fecha Inicio 9(8)
                 Linea = Linea & Format(Datos(21), "yyyymmdd")                'Fecha Vcto 9(8)
                 Linea = Linea & Ceros(Trim(Datos(22)), 5) & Datos(22)        'Rentabilidad 9(5)
                 Linea = Linea & Ceros(Trim(Datos(23)), 2) & Datos(23)        'Error 9(2)
                 Linea = Linea & Datos(24) & " "                              'Flag Tipo Operacion X(2)
                 Linea = Linea & Datos(25)                                    'Clase Tasa X(1)
                 Linea = Linea & Datos(26)                                    'Base Fluctuacion X(1)
                 Linea = Linea & Datos(27)                                    'Plazo Tasa X(1)
                 Linea = Linea & "00000"                                      'Spread
                 Linea = Linea & "                          "
                 p = p + 1
                 Print #1, Linea
                 Prg.Max = p
                 BacControlWindows 20
                 Prg.Value = p
            Loop
            Close #1
            Screen.MousePointer = 0
            MsgBox ("Interfaz D3 Generada Correctamente  "), vbInformation, ("BacTrader")
            Prg.Visible = False
            Label2.Visible = False
            If Not Enviar_por_ftp(gsBac_DIRIN, "DT3.DTA") Then
                 MsgBox "Interfaz " & NOMBRE & "  via FTP no fue traspasada ", vbCritical
            End If
         End If



End Sub

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

Private Sub P17()
Dim nTotal1 As Double
Dim nTotal2 As Double
Dim nTotal3 As Double

    Envia = Array(Format$(gsBac_Fecp, "yyyymmdd"))
    If Not Bac_Sql_Execute("SP_P17", Envia) Then
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
        SQL = ""
        Envia = Array("")
        If Not Bac_Sql_Execute("SP_INTERFAZ_FLUJO_VCTO") Then
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
    NOMBRE = Directorio.Path + "\" + NombreArchivo
   ' NOMBRE = gsBac_DIRCO + NombreArchivo
 ElseIf Me.Interfaz = "DIRECCIONES" Then
    NOMBRE = Directorio.Path + "\" + NombreArchivo
 ElseIf Me.Interfaz = "BALANCE" Then
    NOMBRE = Directorio.Path + "\" + NombreArchivo
 ElseIf Me.Interfaz = "FLUJOSMUTUOS" Then
    NOMBRE = Directorio.Path + "\" + NombreArchivo
 ElseIf Me.Interfaz = "POSICION" Then
    NOMBRE = Directorio.Path + "\" + NombreArchivo
 ElseIf Me.Interfaz = "DEUDORES" Then
    NOMBRE = Directorio.Path + "\" + NombreArchivo
 ElseIf Me.Interfaz = "ART84" Then
    NOMBRE = Directorio.Path + "\" + NombreArchivo
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
    
    On Error GoTo err
    
    Me.Caption = "Interfaz " & Interfaz
    
    Me.Top = 0: Me.Left = 0
    
    Call objMonedas.LeerMonedas
    
    txtFecha1.text = gsBac_Fecp

'    If Interfaz = "SIM03" Then
'        Me.lblEtiqueta(2).Visible = False
'        Me.cmbAño.Visible = False
'        Me.lblEtiqueta(0).Visible = True
'        Me.txtFecha1.Visible = True
'
'        cDia = Mid(Format(gsBac_Fecp, "ddmmyyyy"), 1, 4)
'        cNomArchivo = "SIM03" & cDia '& ".csv"
'        NombreArchivo = cNomArchivo   ''"MDINTCO"
'    End If



    If Interfaz = "N_C8" Or Interfaz = "C8" Then
        cmbAño.Visible = False
        lblEtiqueta(2).Visible = False
    End If

    Me.Icon = BacTrader.Icon
    
    If Interfaz = "C8" Then
        NombreArchivo = "TRC8C9"
    End If
    
    If Interfaz = "CONTABLE" Then
        cDia = Mid(Format(gsBac_Fecp, "ddmmyyyy"), 1, 4)
        cNomArchivo = "CU" & cDia '& ".DS"
        NombreArchivo = cNomArchivo   ''"MDINTCO"
        SSCommand2.Visible = True
        Label1.Visible = True
        
        cNomArchivo = "RISTAS_BAC_" & cDia '& ".dat"
        NombreArchivo = cNomArchivo   ''"MDINTCO"
        Me.drive.Visible = False
        Me.NOMBRE.Visible = False
    End If
    
    If Interfaz = "CLIENTES" Then
        cDia = Format(gsBac_Fecp, "YYMMDD")
        cNomArchivo = "CL14" & cDia & ".DAT"
        NombreArchivo = cNomArchivo
    End If
    
    If Interfaz = "OPERACIONES" Then
        cDia = Format(gsBac_Fecp, "YYMMDD")
        cNomArchivo = "OP15" & cDia & ".DAT"
        NombreArchivo = cNomArchivo
    End If
    
    If Interfaz = "DIRECCIONES" Then
        cDia = Format(gsBac_Fecp, "YYMMDD")
        cNomArchivo = "DD15" & cDia & ".DAT"
        NombreArchivo = cNomArchivo
    End If
    
    If Interfaz = "BALANCE" Then
        cDia = Format(gsBac_Fecp, "YYMMDD")
        cNomArchivo = "BO15" & cDia & ".DAT"
        NombreArchivo = cNomArchivo
    End If
    
    If Interfaz = "FLUJOSMUTUOS" Then
        cDia = Format(gsBac_Fecp, "YYMMDD")
        cNomArchivo = "FL15" & cDia & ".DAT"
        NombreArchivo = cNomArchivo
    End If
        
    If Interfaz = "POSICION" Then
        cDia = Format(gsBac_Fecp, "YYMMDD")
        cNomArchivo = "PC15" & cDia & ".DAT"
        NombreArchivo = cNomArchivo
    End If
    
    If Interfaz = "DEUDORES" Then
        cDia = Format(gsBac_Fecp, "YYMMDD")
        cNomArchivo = "CO15" & cDia & ".DAT"
        NombreArchivo = cNomArchivo
    End If

    If Interfaz = "CTACTE" Then NombreArchivo = "MDINTCC"
    If Interfaz = "P17" Then NombreArchivo = "P17"
    If Interfaz = "D3" Then NombreArchivo = "D3"

    If Interfaz = "D31" Then
        cDia = Mid(Format(gsBac_Fecp, "mmddyyyy"), 1, 4)
        cNomArchivo = "D31_" & cDia & ".DAT"
        NombreArchivo = cNomArchivo   ''"MDINTCO"''        NombreArchivo = "D31"
    End If
 
    If Interfaz = "ART84" Then
        cDia = Format(gsBac_Fecp, "YYMMDD")
        cNomArchivo = "CMMD" & cDia & ".TXT"
        NombreArchivo = cNomArchivo
    End If

    If Interfaz = "C14" Then NombreArchivo = "TRC14C15"
    If Interfaz = "COLOCACIONES" Then NombreArchivo = "ICOL"
    If Interfaz = "RCC" Then NombreArchivo = "RCC"
    If Interfaz = "VENCIMIENTOS" Then NombreArchivo = "TRFLUJO"
    If Interfaz = "CTACTEII" Then NombreArchivo = "ICTACTE"
    If Interfaz = "ART57" Then NombreArchivo = "ART57"
    If Interfaz = "N_C8" Then NombreArchivo = "Nueva_C8"
    If Interfaz = "CARTERA" Then NombreArchivo = "XFIL" & Mid(Format(gsBac_Fecp, "mmddyyyy"), 1, 4)
    If Interfaz = "FLUJOS" Then NombreArchivo = "XFLU" & Mid(Format(gsBac_Fecp, "mmddyyyy"), 1, 4)
    If Interfaz = "SIGUIR" Then NombreArchivo = "ND15" & Format(gsBac_Fecp, "yymmdd")
     

    If Interfaz = "EXEL" Then
        cmbAño.Enabled = False
        Me.Caption = "Grabar Planilla a Exell"
        NombreArchivo = "Tasamer.xls"    '' otra utilidad con la exportacion a exel
    End If
    
    
'lblEtiqueta(0).Visible = False
'TXTFecha1.Visible = False
          
     If Interfaz = "SIGUIR" Then
          lblEtiqueta(1).Visible = False
          cmbMes.Visible = False
          lblEtiqueta(2).Visible = False
          cmbAño.Visible = False
          lblEtiqueta(0).Visible = True
          txtFecha1.Visible = True
         txtFecha1.MaxDate = gsBac_Fecp
     End If


'    Frame1.Visible = True
    'SSCommand1.Top = 4020
    'Label2.Top = 4440
    'Prg.Top = 4030
    'Me.SSPanel1.Height = 4770
    'Me.Height = 5175
    
    For i = 1990 To 2020
        cmbAño.AddItem i
        cmbAño.ItemData(cmbAño.NewIndex) = i
    Next

    Call bacBuscarCombo(cmbAño, Year(gsBac_Fecp))
    cmbMes.Visible = False
    lblEtiqueta(1).Visible = False

    If Interfaz = "GESTION" Then
        NombreArchivo = "Mdinges"
        Frame1.Visible = True
        SSCommand1.Top = 4020
        Label2.Top = 4440
        Prg.Top = 4030
        Me.SSPanel1.Height = 4770
        Me.Height = 5175
        
        For i = 1990 To 2020
            cmbAño.AddItem i
            cmbAño.ItemData(cmbAño.NewIndex) = i
        Next
        
        Call BacLLenaComboMes(cmbMes)
        Call bacBuscarCombo(cmbAño, Year(gsBac_Fecp))
        Call bacBuscarCombo(cmbMes, Month(gsBac_Fecp))
    End If

    If Interfaz = "CARTERA" Or Interfaz = "FLUJOS" Then
        Prg.Top = 4030
        Me.SSPanel1.Height = 4770
        Me.Height = 5175
    End If
    
    If Mid(NombreArchivo, 1, 3) = "C14" Or Mid(NombreArchivo, 1, 3) = "D31" Or Mid(NombreArchivo, 1, 3) = "XFI" Or Mid(NombreArchivo, 1, 3) = "XFLU" Then
        Directorio.Path = gsBac_DIRCO
    Else
        Directorio.Path = gsBac_DIRIN
    End If

    ''''''''    INTERFAZ IBS  '''''''''''''''''
    If Mid(NombreArchivo, 1, 4) = "CL14" Or Mid(NombreArchivo, 1, 4) = "DD15" Or Mid(NombreArchivo, 1, 4) = "FL15" Or Mid(NombreArchivo, 1, 4) = "OP15" Or Mid(NombreArchivo, 1, 4) = "BO15" Or Mid(NombreArchivo, 1, 4) = "PC15" Or Mid(NombreArchivo, 1, 4) = "CO15" Then
        Directorio.Path = ""
        Directorio.Path = gsBac_DIRIBS
    End If

    drive.Refresh

    Label2.Caption = ""

    Call Directorio_Change

    Exit Sub
    
err:
    MsgBox "Carpeta " & App.Path & "\interfaces" & " No se encuentra", vbCritical
    Directorio.Path = App.Path
    drive.Refresh
End Sub

Private Sub C8()
        Numero = 0
        Prg.Value = 0
        CPrg = 0
        Label2.Visible = True
        Prg.Visible = True 'Barra
        SQL = ""
        Envia = Array("")
        Screen.MousePointer = 11
        'Sql = "SP_INTERFAZ_C8"
        If Not Bac_Sql_Execute("SP_INTERFAZ_C8") Then    'Cambiar SP_INTERFAZ_C8
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

On Error GoTo Error
   
   Deci = "0"
   
    If UCase(Interfaz) = "SIM03" Then
        CommonDialog1.CancelError = True
        CommonDialog1.DialogTitle = "Formulario SIM03"
        CommonDialog1.FileName = "SIM03_" + Format(gsBac_Fecp, "yyyymmdd") + ".csv"
        CommonDialog1.ShowSave
    End If
   
   If UCase(Interfaz) = "C8" Then
      Call C8
   End If
'*************** Nueva interfaz C08 *********************
    If UCase(Interfaz) = "N_C8" Then
      Call N_C08
    End If
'********************************************************
''''   If UCase(Interfaz) = "CONTABLE" Then
''''      Call Contable
''''   End If
''''    Se comenta, ya que interfaz se esta generando automáticamente al realizar la contabilidad
  
  Dim arch_salida As String
  If UCase(Interfaz) = "CONTABLE" Then
      Call Contable_Desacople(arch_salida)
      Me.NOMBRE.Visible = True
      Me.NOMBRE.text = arch_salida
  End If
   
   
   If UCase(Interfaz) = "CTACTE" Then
      Call CTACTE
   End If
   
   If UCase(Interfaz) = "P17" Then
      Call P17
   End If
   
   If UCase(Interfaz) = "D3" Then
      Call D3
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
   If UCase(Interfaz) = "RCC" Then
      Call RCC
   End If
   
    If UCase(Interfaz) = "VENCIMIENTOS" Then
      Call Vencimientos
   End If
   If UCase(Interfaz) = "CTACTEII" Then
      Call CTACTEII
   End If
   
   If UCase(Interfaz) = "GESTION" Then
      Call GESTION
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
      Call InterfazOperaciones
   End If
   
   If UCase(Interfaz) = "DIRECCIONES" Then
      Call InterfazDirecciones
   End If

    If UCase(Interfaz) = "BALANCE" Then
        Call InterfazBalance
    End If

    If UCase(Interfaz) = "FLUJOSMUTUOS" Then
        Call Interfazflujosmutuos
    End If

    If UCase(Interfaz) = "POSICION" Then
        Call InterfazPosicion
    End If
    
    If UCase(Interfaz) = "DEUDORES" Then
        Call InterfazDeudores
    End If
    
    If UCase(Interfaz) = "ART84" Then
        Call InterfazArt84
    End If
    
    If UCase(Interfaz) = "SIGUIR" Then
        Call SIGUIR
    End If

   If UCase(Interfaz) = "SIM03" Then
      Call Modulo_Interfaces.Formulario_SIM03(CommonDialog1.FileName)
   End If

  ' Unload Me
Exit Sub

Error:
    Select Case err
    Case 32755 '  Dialog Cancelled
        MsgBox "Sin eleccion de archivo"
    Case Else
        MsgBox err.Source & "-->" & err.Description, , "Acción Cancelada." & vbCrLf & vbCrLf & "El archivo no se ha generado.... Favor reintentar.", vbCritical, TITSISTEMA
    End Select
   
   
   Screen.MousePointer = vbDefault

End Sub

Private Sub Cartera()
 Dim cLine As String
 Dim cNomArchivo As String
 Dim cDia As String
 Dim cruta As String
 Dim Datos
 Dim Punto As String
 Dim p, SW As Integer
 Dim Conta As Integer
 'On Error GoTo Herror1
 Punto = "."
 cDia = Mid(Format(gsBac_Fecp, "ddmmyyyy"), 1, 4)
 cNomArchivo = gsBac_DIRCO & NombreArchivo & ".TXT"
 MousePointer = 11
SW = 1
 
 SW = 0
 
 SQL = "SP_INTERFAZ_FLUJO"    ' CARTERA
 
If Not Bac_Sql_Execute(SQL) Then
   MsgBox "Problemas al ejecutar procedimiento " & SQL, vbCritical, "MENSAJE"
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
   If Prg.Max = 100 Then Prg.Max = Datos(49)
    If SW = 0 Then
        cLine = "1                              0000000000000000000000   00" & Format(gsBac_Fecp, "yyyymmdd") & "0000000000000000000000000000000000000000000000000000000000   00000000000000000000000000000000000000000000000000000000000000000000000PCT0000000000   00000000000000000000000000000000000000000000000000000000000"
        Print #1, cLine
        SW = 1
    End If
    
   cLine = ""
   cLine = cLine & Datos(1) & Format(Datos(2), "0000000000") & Format(Datos(3), "00000000000000000000")
   cLine = cLine & IIf(Datos(4) = "", "00000", Format(Datos(4), "00000")) & Format(Datos(5), "0000") & Datos(6) & Datos(7) & Datos(8) & Datos(9)
   cLine = cLine & Datos(10) & Datos(11) & Datos(12) & Format(Datos(13), "yyyymmdd") & Format(saca_punto(Str(Datos(14)), 0), "000000000000000")
   cLine = cLine & Format(Datos(15), "000000000000000") & Format(saca_punto(Str(Datos(16)), 4), "000000000000") & Datos(17)
   cLine = cLine & Format(Datos(18), "00") & Format(Datos(19), "000") & Format(Datos(20), "000") & Format(saca_punto(Str(Datos(21)), 4), "000000") & Datos(22)
   cLine = cLine & Format(saca_punto(Str(Datos(23)), 4), "000000") & Datos(24) & Format(Datos(25), "yyyymmdd") & Format(Datos(26), "yyyymmdd")
   cLine = cLine & Format(Datos(27), "000000000000000") & Datos(28) & Format(Datos(29), "0000")
   cLine = cLine & Datos(30) & Datos(31) & Datos(32) & Datos(33) & Datos(34) & Datos(35) & Space(3) & Datos(37)
   cLine = cLine & Format(Datos(38), "yyyymmdd") & Format(Datos(39), "000") & Format(Datos(40), "000")
   
   If CDbl(Datos(42)) >= 0 Then
      cLine = cLine & Format(Datos(41), "00000") & Replace(Format(Datos(42), "000000000000000"), "-", "")
   Else
      cLine = cLine & Format(Datos(41), "00000") & Format(Datos(42), "00000000000000")
   End If
   
   If CDbl(Datos(44)) < 0 Then
       
       cLine = cLine & Format(Datos(43), "00000") & Format(Datos(44), "00000000000000") & Datos(45)
      
   Else
      cLine = cLine & Format(Datos(43), "00000") & Replace(Format(Datos(44), "000000000000000"), "-", "") & Datos(45)
   End If
   
   cLine = cLine & Datos(46) & Format(Datos(47), "00000")
   ' & "0000000000"
   
   If Len(cLine) <> 290 Then
         p = p
   End If
   p = p + 1
   Prg.Value = p
   Print #1, cLine
Loop

'''cLine = ""
'''cLine = "3" & "0000000000" & "00000000000000000000000000000000000000000000000" & Format(gsBac_Fecp, "yyyymmdd") & "0000000000000000" & Format(datos(48), "000000000000000") & "0000000000000000000000000000000000000000000000000000000000"
'''cLine = cLine & "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"  '100
'''cLine = cLine & "0000000000000000000000000000000000" '

cLine = ""
cLine = "3                              0000000000000000000000   00" & Format(gsBac_Fecp, "yyyymmdd") & "000000000000000" & Format(Datos(49), "000000000000000") & "0000000000000000000000000000   0000000000000000000000000000" & Format(Datos(51), "000000000000000") & "0000000000000000000000000000PCT0000000000   00000000000000000000000000000000000000000000000000000000000"

Print #1, cLine

Close #1
    
 MsgBox "Interfaz operaciones  Generada" & " " & cNomArchivo & "(Cant.Reg. " & p & ")", vbOKOnly, "MENSAJE"
     Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Generacion interfaz de  operaciones  " & cNomArchivo)
     
'''  If Not Enviar_por_ftp(Directorio.Path, cNomArchivo) Then
'''             MsgBox "interfaz " & cNomArchivo & "  via FTP no fue traspasada ", vbCritical
'''  End If
   MousePointer = 0
   Exit Sub
   
Herror1:
   MsgBox "Error: " & err.Number & " Descripción: " & err.Description, vbCritical, "Interfaz"
   Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "ERROR interfaz de  operaciones  " & cNomArchivo & err.Number & " Descripción: " & err.Description)
   MousePointer = 0
End Sub
Private Sub FLUJOS()
 Dim cLine As String
 Dim cNomArchivo As String
 Dim cDia As String
 Dim cruta As String
 Dim Datos
 Dim Punto As String
 Dim p As Long
 Dim Conta As Integer
 Dim SW As Integer
 On Error GoTo Herror1
 Punto = "."
 cDia = Mid(Format(gsBac_Fecp, "ddmmyyyy"), 1, 4)
 cNomArchivo = gsBac_DIRCO & NombreArchivo & ".TXT"
 MousePointer = 11
 SW = 1
 
' Data1.DatabaseName = gsPath_Dbf
' Data1.RecordSource = "Xflummdd.dbf"
' Data1.Refresh
' Data1.Recordset.MoveFirst
'
' Do While Not Data1.Recordset.EOF()
'      Sql = "SP_LLENA_XFLU_VENCIMIENTOS"
'      Sql = Sql & "'" & Data1.Recordset!nRut & "'"
'      Sql = Sql & ",'" & Data1.Recordset!nREF & "'"
'      Sql = Sql & ",'" & Data1.Recordset!NCOPE2 & "'"
'      Sql = Sql & ",'" & Data1.Recordset!nCorr & "'"
'      Sql = Sql & ",'" & Data1.Recordset!nCua & "'"
'      Sql = Sql & ",'" & Data1.Recordset!nNtoc & "'"
'      Sql = Sql & ",'" & Data1.Recordset!nSepa & "'"
'      Sql = Sql & ",'" & Data1.Recordset!nSep & "'"
'      Sql = Sql & ",'" & Data1.Recordset!nFven & "'"
'      Sql = Sql & ",'" & Data1.Recordset!nVamo & "'"
'      Sql = Sql & ",'" & Data1.Recordset!nInte & "'"
'      Sql = Sql & ",'" & Data1.Recordset!nComi & "'"
'      Sql = Sql & ",'" & Data1.Recordset!nVcuo & "'"
'      Sql = Sql & ",'" & Data1.Recordset!nSvca & "'"
'      Sql = Sql & ",'" & Data1.Recordset!nTasa & "'"
'      Sql = Sql & ",'" & Data1.Recordset!nRell & "'"
'      Sql = Sql & ", " & SW
'    If Not Bac_Sql_Execute(Sql) Then
'        MsgBox "Problemas al ejecutar procedimiento para la interfaz Xflu" & Sql, vbCritical, "MENSAJE"
'        Exit Sub
'    End If
'    Data1.Recordset.MoveNext
'    Sql = ""
'    SW = 0
' Loop
' Data1.Recordset.Close
    
    SW = 0
 
 SQL = "SP_INTERFAZ_FLUJO_VCTO_2"
 If Not Bac_Sql_Execute(SQL) Then
    MsgBox "Problemas al ejecutar procedimiento " & SQL, vbCritical, "MENSAJE"
    Exit Sub
 End If
' Debug.Print p, Time$
  CPrg = 0
 
  Prg.Visible = True
  Prg.Value = 0
  p = 0

 If Dir(cNomArchivo) <> "" Then
   Kill cNomArchivo
 End If

Open cNomArchivo For Output As #1
  
Do While Bac_SQL_Fetch(Datos)
    If Prg.Max = 100 Then Prg.Max = Datos(19)

    If SW = 0 Then
        cLine = ""
        cLine = "1" & "00000000000000000000000000000000000000000000000" & Format(gsBac_Fecp, "yyyymmdd") & "0000000000000000000000000000000000000" & Format(0, "000000000000000") & "000000000000000000000000000000"
        Print #1, cLine
        SW = 1
    End If

    cLine = ""
    cLine = cLine & Datos(1) & Datos(2) & Datos(3) & IIf(Datos(4) = "", "00000", Format(Datos(4), "00000"))
    cLine = cLine & Format(Datos(5), "00") & Format(Datos(6), "000") & Format(Datos(7), "000") & Datos(8) & Format(Datos(9), "000")
    cLine = cLine & Format(Datos(10), "yyyymmdd") & Format(Datos(11), "000000000000000") & Format(IIf(Val(Datos(12)) < 0, saca_menos2(Val(Datos(12))), Datos(12)), "000000000000000")
    cLine = cLine & Format(Datos(13), "000000000000000") & Format(Datos(14), "000000000000000")
    cLine = cLine & Format(Datos(15), "000000000000000") & Replace(Format(Datos(16), "000.0000"), gsBac_PtoDec, "") & Space(8) 'datos(17)
    
If Len(cLine) <> 146 Then
    p = p
 End If
    
    p = p + 1
    
    Prg.Value = p
    Print #1, cLine
Loop

cLine = ""
cLine = "3                              0000000000000 000" & Format(gsBac_Fecp, "yyyymmdd") & "000000000000000000000000000000000000000000000" & Format(Prg.Max, "000000000000000") & Format(Datos(20), "000000000000000") & "0000000"
'cLine = "3" & Space(30) & "0000000000000" & Space(1) & Format(gsBac_Fecp, "yyyymmdd") & "00000000000000000000000000000000000000000000000000000000" & Format(datos(19), "000000000000000") & Format(datos(20), "000000000000000") & "0000000"
Print #1, cLine


Close #1
    
MsgBox "Interfaz de vencimientos  Generada" & " " & cNomArchivo & "(Cant.Reg. " & p & ")", vbOKOnly, "MENSAJE"

Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Generacion interfaz de  vencimientos  Ok" & cNomArchivo)
    
'''   If Not Enviar_por_ftp(Directorio.Path, cNomArchivo) Then
'''            MsgBox "interfaz " & cNomArchivo & "  via FTP no fue traspasada ", vbCritical
'''   End If
   
   MousePointer = 0
   Exit Sub
   
Herror1:
   MsgBox "Error: " & err.Number & " Descripción: " & err.Description, vbCritical, "Interfaz"
   Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "ERROR interfaz  de  vencimientos  NO REALIZADA  " & cNomArchivo & err.Number & " Descripción: " & err.Description)
   MousePointer = 0
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
Dim y As Integer
If Mid(cValor, 1, 1) = "-" Then
    cValor = Mid(cValor, 2, Len(cValor))
End If
For X = 1 To Len(cValor) 'nDecim
    If Mid(cValor, X, 1) = "." Then
      xvar = xvar & "" 'Mid(cValor, x, 1)
      x1 = Len(Mid(cValor, X + 1, Len(cValor)))
     y = y - 1
    ElseIf Mid(cValor, X, 1) = " " Then
     xvar = xvar & "0"
    ElseIf Mid(Trim(cValor), X, 1) <> " " Then 'cuando es un valor
    y = y + 1
    xvar = xvar & Mid(cValor, X, 1)
    End If
Next

If Len(Trim(cValor)) = 1 Then
 xvar = xvar & "00"  ''"0000"
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
 SQL = "SP_OPERACIONES '" & Format(gsBac_Fecp, "yyyymmdd") & "'"
 
 If Not Bac_Sql_Execute(SQL) Then
    MsgBox "Problemas al leer operaciones", vbCritical, "MENSAJE"
   ' Call GRABA_LOG_AUDITORIA("Opc_60913", "09", "Problemas Procedimiento", "", "", "")
    Exit Sub
 End If
  
 cLine = ""
Do While Bac_SQL_Fetch(Datos)

   cLine = cLine & Format(Datos(1), "000000000") & Datos(2) & Format(Datos(3), "00000000000000000000")
   cLine = cLine & Datos(4) & Format(IIf(Datos(5) = "", "00000", Datos(5)), "00000") & Datos(6) & Format(saca_punto(CDbl(Datos(7)), 2), "000000000000000") & Format(Datos(8), "yyyymmdd")
   cLine = cLine & Format(Datos(9), "yyyymmdd") & Datos(10)
  
  
  cLine = cLine & Replace(Format(Datos(11), "000.0000"), gsBac_PtoDec, "") & Datos(12)
  'cLine = cLine & Format(saca_punto(CDbl(datos(11)), 4), "0000000") & datos(12)
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
        SQL = ""
        Envia = Array("")
        
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

Public Sub N_C08()
Numero = 0
        Prg.Value = 0
        CPrg = 0
        Label2.Visible = True
        Prg.Visible = True 'Barra
        SQL = ""
        Envia = Array("")
        Screen.MousePointer = 11
    
        If Not Bac_Sql_Execute("SP_INTERFAZ_C8_NUEVA") Then
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
                 Linea = Format(DatePart("d", gsBac_Fecp), "00") & "TR" & Ceros(Trim(Datos(1)), 10) & Trim(Datos(1))
                 Linea = Linea & Ceros(Trim(Datos(2)), 3) & Trim(Datos(2))
                 Linea = Linea & Ceros(Trim(Datos(3)), 1) & Trim(Datos(3))
                 Linea = Linea & Trim(Datos(4)) & ESPACIOS(Trim(Datos(4)), 8)
                 
                 Linea = Linea & Ceros(Int(Datos(5)), 14) & Int(Datos(5))
                 Deci = SacaDecim(Round(CDbl(Datos(5)) - Int(Datos(5)), 4))
                 Linea = Linea & Trim(Deci) & Ceros(Trim(Deci), 4)
                                                   
                 Linea = Linea & Ceros(Int(Datos(6)), 3) & Int(Datos(6))
                 Deci = SacaDecim(Round(CDbl(Datos(6)) - Int(Datos(6)), 4))
                 Linea = Linea & Trim(Deci) & Ceros(Trim(Deci), 4)
                 
                 Linea = Linea & Ceros(Int(Datos(7)), 14) & Int(Datos(7))
                 Deci = SacaDecim(Round(CDbl(Datos(7)) - Int(Datos(7)), 4))
                 Linea = Linea & Trim(Deci) & Ceros(Trim(Deci), 4)
                 
                 Linea = Linea & Format(Val(Datos(8)), "00000")
                 Linea = Linea & Trim(Datos(9)) & ESPACIOS(Trim(Datos(9)), 1)
                 
                 Prg.Value = p
                 p = p + 1
                 Print #1, Linea
                 Prg.Max = Datos(11)
                 BacControlWindows 20
                 
            Loop
            Close #1
            Screen.MousePointer = 0
            MsgBox ("Interfaz Generada Correctamente"), vbInformation, ("BacTrader")
            Prg.Visible = False
            Label2.Visible = False
            
            
            If Not Enviar_por_ftp(gsBac_DIRIN, "Nueva_C8.TXT") Then
                 MsgBox "Interfaz " & NOMBRE & "  via FTP no fue traspasada ", vbCritical
            End If
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
Dim Ruta As String
Dim Crea_xls As Boolean

Const Filas_Buffer = 150

'gsBac_DIREXEL

Ruta = NOMBRE 'ruta del .XSL
Screen.MousePointer = 11
DoEvents


SQL = "SP_SBIF_LEERMDTM1 " & "'BTR'," & "'" & Fecha & "'"

If Not Bac_Sql_Execute(SQL) Then MsgBox "No se pudo generar Planilla", vbCritical, gsBac_Version: Screen.MousePointer = 0: Exit Function

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

    Crea_xls = True
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
If Crea_xls Then
    Hoja.SaveAs (Ruta)
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


 
Private Sub InterfazArt84()

Dim Total          As Integer
 Dim totalreg       As Integer
 Dim cDia           As String
 Dim cNomArchivo    As String
 Dim cLine          As String
 


    If Not Bac_Sql_Execute("SP_CONTROLA_DEVENGOS") Then
        MsgBox "Problemas al leer Información", vbCritical, "MENSAJE"
        Screen.MousePointer = 0
        Exit Sub
    Else
    
        Do While Bac_SQL_Fetch(Datos())
                 
             If Datos(2) = 0 Then
                MsgBox "Se debe realizar Devengo para Módulo de " & Datos(3), vbCritical, "MENSAJE"
                Exit Sub
             End If
                
        Loop
        

        
        
    End If
    
 On Error GoTo Herror1
 Total = 0
 totalreg = 0
 cNomArchivo = ""
 cDia = Format(gsBac_Fecp, "ddmmyy")
 cNomArchivo = Directorio.Path & "\" & NombreArchivo
 
 Screen.MousePointer = 11
   If Not Bac_Sql_Execute("SP_INTERFAZ_ARTICULO84") Then
        MsgBox "Problemas al leer operaciones", vbCritical, "MENSAJE"
            Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "ERROR Interfaz de Operaciones OP15  NO REALIZADA  " & cNomArchivo & err.Number & " Descripción: " & err.Description)
            Screen.MousePointer = 0
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
    
  
   Do While Bac_SQL_Fetch(Datos())
                 
     cLine = ""
     cLine = cLine & ESPACIOS_CL((Datos(1)), 15, "D")
     cLine = cLine & ESPACIOS_CL((Datos(2)), 10, "D")
     cLine = cLine & ESPACIOS_CL((Datos(3)), 10, "D")
     cLine = cLine & Datos(4)
     cLine = cLine & Datos(5)
     
     If Len(cLine) <> 786 Then
            p = p
     End If
     
    totalreg = totalreg + 1
    p = p + 1
    Print #1, cLine
    Prg.Max = p
    Prg.Value = p
    Loop
    
    cLine = ""
    totalreg = totalreg + 1
    ''cLine = cLine & ("99" & Format(gsBac_Fecp, "yyyymmdd") & Format(totalreg, "0000000000") & Space(766))
    Print #1, cLine
    Close #1
       
    MsgBox "Interfaz Artículo 84 Generada" & " " & cNomArchivo & "(Cant.Reg. " & totalreg & ")", vbOKOnly, "MENSAJE"
    Screen.MousePointer = 0
    Prg.Visible = False
    Label2.Visible = False
    Exit Sub
   
Herror1:
   MsgBox "Error: " & err.Number & " Descripción: " & err.Description, vbCritical, "Interfaz"
   Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "ERROR Interfaz de Operaciones OP15 NO REALIZADA  " & cNomArchivo & err.Number & " Descripción: " & err.Description)
   Exit Sub
End Sub

Private Sub SIGUIR()
   On Error GoTo ErrorEscrituraP40
   Dim SQL              As String
   Dim nTotalRegistros  As Long
   
   Screen.MousePointer = vbHourglass
   Label2.Visible = True
   Pnl_Progreso.Visible = True 'Barra
   
   CPrg = 0
   i = 1
   p = 1
   
   NOMBRE = Directorio.Path & "\ND15" & Format(txtFecha1.text, "YYMMDD") & ".DAT"
   
   Envia = Array()
   AddParam Envia, Format(txtFecha1.text, "yyyymmdd")
   If Not Bac_Sql_Execute("SP_INTERFAZ_P40_BANCO", Envia) Then
      Screen.MousePointer = vbDefault
      MsgBox "ERROR Procedimiento... " & vbCrLf & "No se puede Generar Interfaz ", vbCritical, App.Title
      On Error GoTo 0
      Exit Sub
   End If

   If Dir(NOMBRE) <> "" Then
      Call Kill(NOMBRE)
   End If

   Open NOMBRE For Append As #1

   Do While Bac_SQL_Fetch(Datos())
      nTotalRegistros = Datos(37)
      
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
      Linea = Linea & ESPACIOS_CL(Trim(Datos(35)), 20, "D")
      
      Print #1, Linea
      
      Pnl_Progreso.FloodPercent = (p / nTotalRegistros) * 100 '--> ActualizarBarra(CDbl(p), CDbl(nTotalRegistros))
      
      p = p + 1
      Call BacControlWindows(2)
   Loop
      
   Close #1
   Screen.MousePointer = vbDefault
   MsgBox "Interfaz Siguir Generada Correctamente  ", vbInformation, App.Title
   Prg.Visible = False
   Label2.Visible = False

   On Error GoTo 0
      
Exit Sub
ErrorEscrituraP40:
   MsgBox "Error en Proceso de generación" & vbCrLf & vbCrLf & err.Description, vbExclamation, App.Title
   On Error GoTo 0
End Sub

Sub generar_salida_plano(nombre_arch As String)

   On Error GoTo Importar_Excel
   
   Dim xlApp        As EXCEL.Application
   Dim xlBook       As EXCEL.Workbook
   Dim xlSheet      As EXCEL.Worksheet
   Dim iRow         As Integer
   Dim xRow         As Integer
   Dim Linea        As String

   Dim Numero_Voucher  As Double
   Dim Centro_Contable As String
   Dim Correlativo     As String
   Dim Cuenta          As String
   Dim Tipo_Monto      As String
   Dim Monto           As Double
   Dim Monto_cnv       As Double
   Dim Moneda          As Integer
   Dim sNombre_salida  As String
   Dim i               As Integer
   Dim moneda_cod      As Integer
   Dim moneda_des      As String
   Dim Mensaje         As String

   Set xlApp = CreateObject("Excel.Application")
   Set xlBook = xlApp.Workbooks.Open(nombre_arch)
   Set xlSheet = xlBook.Worksheets(1)
   
    Envia = Array()
    AddParam Envia, 381 ' Interfaz Contable
    If Not Bac_Sql_Execute("sp_BacInterfaces_Archivo", Envia) Then
        Exit Sub
    End If
    If Bac_SQL_Fetch(Datos()) Then
        Let sNombre_salida = Datos(4) + Datos(2) + Format(gsBac_Fecp, "yymmdd") + ""
    Else
        Let sNombre_salida = gsBac_DIRCONTA & "BAC_RISTAS_" & Format(gsBac_Fecp, "yyyymmdd") & ".DAT"
    End If
   
'   cDia = Mid(Format(gsBac_Fecp, "ddmmyyyy"), 1, 4)
'   sNombre_salida = gsBac_DIRCONTA & "RISTAS_BAC_" & Format(gsBac_Fecp, "yyyymmdd") & ".DAT"

'   Open sNombre_salida For Output As #1
   Open sNombre_salida For Append As #1
    
    
      nTotalReg = xlSheet.Columns.End(xlDown).Row - 1
      nRegAct = 0
      
      For xRow = 1 To xlSheet.Columns.End(xlDown).Row - 1
         
         
         Linea = ""
               
         Numero_Voucher = Func_Leer_Celda(xlSheet, "A" & LTrim(Str(1 + xRow)))
         Centro_Contable = Func_Leer_Celda(xlSheet, "B" & LTrim(Str(1 + xRow)))
         If Centro_Contable <> "Origen  [5600]" And Centro_Contable <> "Destino [2230]" Then
            Mensaje = "no existe campo ORIGEN CENTRO CONTABLE"
            GoTo Importar_Excel:
         End If
         
         Correlativo = Func_Leer_Celda(xlSheet, "C" & LTrim(Str(1 + xRow)))
         Cuenta = Func_Leer_Celda(xlSheet, "D" & LTrim(Str(1 + xRow)))
         Tipo_Monto = Func_Leer_Celda(xlSheet, "E" & LTrim(Str(1 + xRow)))
         If Tipo_Monto <> "H" And Tipo_Monto <> "D" Then
            Mensaje = "no existe campo TIPO DE MONTO"
            GoTo Importar_Excel:
         End If
         
         Monto = Func_Leer_Celda(xlSheet, "F" & LTrim(Str(1 + xRow)))
         Moneda = Func_Leer_Celda(xlSheet, "G" & LTrim(Str(1 + xRow)))
         
         For i = 1 To 51
            If objMonedas.coleccion(i).mncodmon = Moneda Then
               moneda_cod = objMonedas.coleccion(i).mncodmon
               moneda_des = objMonedas.coleccion(i).mnnemo
               Exit For
            End If
         Next i
         
         If Moneda = 999 Then
            Monto_cnv = Monto * 1
         ElseIf Moneda = 998 Then
            Monto_cnv = Monto * gsValor_UF
         ElseIf Moneda = 994 Then
            Monto_cnv = Monto * gsValor_DO
         Else
            Monto_cnv = Monto * FUNC_BUSCA_VALOR_MONEDA(Moneda, Format(gsBac_Fecp, "DD/MM/YYYY"))
         End If

         Linea = Linea & "0039888" & Format(gsBac_Fecp, "yyyymmdd") & Format(gsBac_Fecp, "yyyymmdd") & Space(6)
         If Centro_Contable = "Origen  [5600]" Then
         Linea = Linea & "560056005600" 'origen -- destino
         Else
         Linea = Linea & "223022302230" 'origen -- destino
         End If
         If Tipo_Monto = "D" Then
         Linea = Linea & "00000010000000" 'debe
         Else
         Linea = Linea & "00000000000001" 'debe
         End If
         If Moneda = 999 Then
             If Tipo_Monto = "D" Then
                Linea = Linea & Replace(Format(Monto, "0000000000000.00"), ".", "") & "000000000000000" & "000000000000000000000000000000"
             Else
                Linea = Linea & "000000000000000" & Replace(Format(Monto, "0000000000000.00"), ".", "") & "000000000000000000000000000000"
             End If
         Else
             If Tipo_Monto = "D" Then
                Linea = Linea & Replace(Format(Monto_cnv, "0000000000000.00"), ".", "") & "000000000000000"
                Linea = Linea & Replace(Format(Monto, "0000000000000.00"), ".", "") & "000000000000000"
             Else
                Linea = Linea & "000000000000000" & Replace(Format(Monto_cnv, "0000000000000.00"), ".", "")
                Linea = Linea & "000000000000000" & Replace(Format(Monto, "0000000000000.00"), ".", "")
             End If
         End If
         Linea = Linea & Space(13) & "000" & Space(15)
         
         If Centro_Contable = "Origen  [5600]" Then
         Linea = Linea & "ASIENTO  P/ DEJAR SALDO 0 5600"
         Else
         Linea = Linea & "ASIENDO  P/ MOVER SALDO A 2230"
         End If
         
         Linea = Linea & "DEAL:00000000" & Space(5) & "888" & Space(3) & "COLIVI"
         If Moneda = 999 Then
             Linea = Linea & "CLP "
         ElseIf Moneda = 13 Then
             Linea = Linea & "USD "
         ElseIf Moneda = 998 Then
             Linea = Linea & "UF  "
         Else
             Linea = Linea & Mid(moneda_des & " ", 1, 4)
         End If
         Linea = Linea & Space(5) & "0" & "0000000000000" & Space(17)
         Linea = Linea & Cuenta
         
         If moneda_des = "CLP" Then
             Linea = Linea & "0" & Space(194)
         Else
             Linea = Linea & "2" & Space(194)
         End If
         
         Print #1, Linea
      Next xRow
   
   Close #1
   
   MsgBox "Acción Finalizada." & vbCrLf & vbCrLf & "Archivo Contable Generado.... Favor Revisar" & vbCrLf & vbCrLf & sNombre_salida, vbInformation, TITSISTEMA
   
   xlBook.Close
   xlApp.Visible = False
   xlApp.Quit

   Set xlApp = Nothing
   Set xlBook = Nothing
   Set xlSheet = Nothing

    Exit Sub

Importar_Excel:
    MsgBox "error " & Mensaje & err.Description
   xlBook.Close
   xlApp.Visible = False
   xlApp.Quit

   Set xlApp = Nothing
   Set xlBook = Nothing
   Set xlSheet = Nothing
   
   Close #1
    
End Sub
Private Function Func_Leer_Celda(objSheet As Object, sCelda As String) As Variant  'Double
   Dim nColumna      As Integer
   Dim nFila         As Integer
   
   nColumna = Asc(Mid$(UCase(sCelda), 1, 1)) - 64
   nFila = Val(Trim(Mid$(sCelda, 2, 5)))
   
   If nColumna = 2 Or nColumna = 4 Or nColumna = 5 Then
      Func_Leer_Celda = objSheet.Cells(nFila, nColumna)
   Else
      Func_Leer_Celda = CDbl(objSheet.Cells(nFila, nColumna))
   End If

End Function

Private Sub SSCommand2_Click()
   On Error GoTo Error

    CommonDialog1.CancelError = True
    CommonDialog1.DialogTitle = "Archivos de Rut de Clientes"
    CommonDialog1.Filter = "*.xlsx" '"excels" & "|" & "xlsx" & "|"
    CommonDialog1.FileName = "CONTABLE"
    
    Me.CommonDialog1.ShowOpen
    If Me.CommonDialog1.CancelError Then
        Call generar_salida_plano(CommonDialog1.FileName)
    End If

Exit Sub
Error:
    MsgBox "NO se selecciono archivo...", vbInformation, TITSISTEMA
End Sub
