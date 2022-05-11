VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Begin VB.Form Interfaz 
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Interfaz"
   ClientHeight    =   4440
   ClientLeft      =   75
   ClientTop       =   2445
   ClientWidth     =   5010
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   4440
   ScaleWidth      =   5010
   Begin Threed.SSPanel SSPanel1 
      Height          =   4170
      Left            =   0
      TabIndex        =   2
      Top             =   0
      Width           =   4950
      _Version        =   65536
      _ExtentX        =   8731
      _ExtentY        =   7355
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
      Begin VB.Data Data1 
         Caption         =   "Data1"
         Connect         =   "dBASE IV;"
         DatabaseName    =   ""
         DefaultCursorType=   0  'DefaultCursor
         DefaultType     =   2  'UseODBC
         Exclusive       =   0   'False
         Height          =   300
         Left            =   3000
         Options         =   0
         ReadOnly        =   0   'False
         RecordsetType   =   1  'Dynaset
         RecordSource    =   ""
         Top             =   0
         Visible         =   0   'False
         Width           =   1935
      End
      Begin VB.Frame Frame1 
         Height          =   615
         Left            =   120
         TabIndex        =   12
         Top             =   3120
         Visible         =   0   'False
         Width           =   4695
         Begin VB.ComboBox cmbMes 
            Height          =   315
            Left            =   690
            Style           =   2  'Dropdown List
            TabIndex        =   14
            Top             =   240
            Width           =   1590
         End
         Begin VB.ComboBox cmbAño 
            Height          =   315
            Left            =   2895
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
            Left            =   240
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
            Left            =   2490
            TabIndex        =   15
            Top             =   330
            Width           =   315
         End
      End
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
         Height          =   3045
         Left            =   135
         TabIndex        =   3
         Top             =   210
         Width           =   4650
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
            Top             =   2280
            Width           =   4320
         End
      End
      Begin Threed.SSCommand SSCommand1 
         Height          =   525
         Left            =   3840
         TabIndex        =   8
         Top             =   3480
         Width           =   990
         _Version        =   65536
         _ExtentX        =   1746
         _ExtentY        =   926
         _StockProps     =   78
         Picture         =   "Interfaz_c8.frx":0000
      End
      Begin MSComctlLib.ProgressBar Prg 
         Height          =   345
         Left            =   120
         TabIndex        =   9
         Top             =   3600
         Visible         =   0   'False
         Width           =   3615
         _ExtentX        =   6376
         _ExtentY        =   609
         _Version        =   393216
         Appearance      =   1
      End
      Begin VB.TextBox Text1 
         Height          =   315
         Left            =   2160
         TabIndex        =   7
         Text            =   "Text1"
         Top             =   1800
         Visible         =   0   'False
         Width           =   1275
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
Attribute VB_Name = "Interfaz"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Dim datos()
Dim folio As Long
Dim NombreArchivo As String
Dim CPrg As Integer 'Contador Barra Progreso
Dim Glosa As String
Dim Numero As Integer
Dim I As Double
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
            I = 1
            
            Screen.MousePointer = 11
             If Dir(NOMBRE) <> "" Then
               Kill NOMBRE
             End If
            p = 1
            Open NOMBRE For Append As #1
           
            Do While Bac_SQL_Fetch(datos())
                
                 Linea = ""
                 Linea = Format(gsBac_Fecp, "yyyymmdd") & "TR" & Ceros(Trim(datos(1)), 9) & Trim(datos(1)) & Trim(datos(6))
                 Linea = Linea & Trim(datos(2)) & ESPACIOS(Trim(datos(2)), 10)
                 Linea = Linea & Ceros(Trim(datos(3)), 3) & Trim(datos(3))
                 
                 Linea = Linea & Ceros(Int(datos(4)), 14) & Int(datos(4))
                 Deci = SacaDecim(Round(CDbl(datos(4)) - Int(datos(4)), 4))
                 Linea = Linea & Trim(Deci) & Ceros(Trim(Deci), 4)
                 
                 
                 Linea = Linea & Trim(datos(5))
                                  
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
            I = 1
            
            Screen.MousePointer = 11
            If Dir(NOMBRE) <> "" Then
               Kill NOMBRE
            End If
            p = 1
            Open NOMBRE For Append As #1
           
            Do While Bac_SQL_Fetch(datos())
                
                  Linea = datos(1)
                  Linea = Linea & datos(2)
                  Linea = Linea & datos(3) & ESPACIOS(Trim(datos(3)), 30)         'Cliente
                  Linea = Linea & datos(4)
                  Linea = Linea & datos(5)
                  Linea = Linea & datos(6) & ESPACIOS(Trim(datos(6)), 30)         'Direccion
                  Linea = Linea & datos(7)
                  Linea = Linea & datos(8)
                  Linea = Linea & datos(9)
                  Linea = Linea & datos(10)

                  If datos(7) = "998" Then
                     Linea = Linea & Ceros(Int(datos(11)), 11) & Int(datos(11))      ' Valor Inicio
                     Deci = SacaDecim(Round(CDbl(datos(11)) - Int(datos(11)), 4))
                     Linea = Linea & Trim(Deci) & Ceros(Trim(Deci), 4)
                  Else
                     Linea = Linea & Ceros(Int(datos(11)), 13) & Int(datos(11))      ' Valor Inicio
                     Deci = SacaDecim(Round(CDbl(datos(11)) - Int(datos(11)), 2))
                     Linea = Linea & Trim(Deci) & Ceros(Trim(Deci), 2)
                  End If

                  If datos(7) = "998" Then
                     Linea = Linea & Ceros(Int(datos(12)), 11) & Int(datos(12))      ' Intereses
                     Deci = SacaDecim(Round(CDbl(datos(12)) - Int(datos(12)), 4))
                     Linea = Linea & Trim(Deci) & Ceros(Trim(Deci), 4)
                  Else
                     Linea = Linea & Ceros(Int(datos(12)), 13) & Int(datos(12))      ' Intereses
                     Deci = SacaDecim(Round(CDbl(datos(12)) - Int(datos(12)), 2))
                     Linea = Linea & Trim(Deci) & Ceros(Trim(Deci), 2)
                  End If

                  If datos(7) = "998" Then
                     Linea = Linea & Ceros(Int(datos(13)), 11) & Int(datos(13))      ' Valor Vcto
                     Deci = SacaDecim(Round(CDbl(datos(13)) - Int(datos(13)), 4))
                     Linea = Linea & Trim(Deci) & Ceros(Trim(Deci), 4)
                  Else
                     Linea = Linea & Ceros(Int(datos(13)), 13) & Int(datos(13))      ' Valor Vcto
                     Deci = SacaDecim(Round(CDbl(datos(13)) - Int(datos(13)), 2))
                     Linea = Linea & Trim(Deci) & Ceros(Trim(Deci), 2)
                  End If

                  Linea = Linea & Ceros(Int(datos(14)), 2) & Int(datos(14))      ' Tasa Pacto
                  Deci = SacaDecim(Round(CDbl(datos(14)) - Int(datos(14)), 2))
                  Linea = Linea & Trim(Deci) & Ceros(Trim(Deci), 2)

                  Linea = Linea & Ceros(Int(datos(15)), 5) & Int(datos(15))      ' Valor UM Inicio
                  Deci = SacaDecim(Round(CDbl(datos(15)) - Int(datos(15)), 2))
                  Linea = Linea & Trim(Deci) & Ceros(Trim(Deci), 2)

                  Linea = Linea & Ceros(Int(datos(16)), 5) & Int(datos(16))       ' Valor UM Vcto
                  Deci = SacaDecim(Round(CDbl(datos(16)) - Int(datos(16)), 2))
                  Linea = Linea & Trim(Deci) & Ceros(Trim(Deci), 2)

                  Linea = Linea & datos(17) ' En Duro
                                                   
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
Dim datos
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

Do While Bac_SQL_Fetch(datos)
    
    If Prg.Max >= 10 Then Prg.Max = datos(19)
          
    If Len(datos(14)) > 1 Then
        nrocal = Mid$(datos(14), 1, 1)
        nrocalidad = nrocal
    Else
       nrocalidad = datos(14)
    End If
        
    If Len(datos(11)) > 11 Then
        NroTel = Mid$(datos(11), 1, 7)
        NumeroTel = Format(Val(NroTel), "00000000000")
    Else
       NumeroTel = Format(Val(datos(11)), "00000000000")
    End If
    
    If Len(datos(15)) > 11 Then
        NroFax = Mid$(datos(15), 1, 7)
        NumeroFax = Format(Val(NroFax), "00000000000")
    Else
       NumeroFax = Format(Val(datos(15)), "00000000000")
    End If
    
    If datos(16) = 0 Then
        If datos(1) < 50000000 Then
            datos(16) = "5801"
        Else
            datos(16) = ""
        End If
   End If
    
    cLine = ""
    
    cLine = cLine & ESPACIOS_CL((datos(1)) + datos(2), 15, "D") & Format(datos(3), "00000000") & IIf(datos(4) = "0", Space(8), ESPACIOS_CL(Trim(datos(4)), 8, "D")) & ESPACIOS_CL((datos(5)), 40, "D")
    
    cLine = cLine & ESPACIOS_CL((datos(6)), 20, "D") & ESPACIOS_CL((datos(7)), 20, "D") & ESPACIOS_CL((datos(8)), 40, "D") & Space(40)
    
    cLine = cLine & IIf(datos(9) = "0", Space(8), ESPACIOS_CL((datos(9)), 8, "D")) & IIf(datos(10) = "0", Space(8), ESPACIOS_CL((datos(10)), 8, "D")) & NumeroTel
    
    cLine = cLine & Space(40) & Space(40) & Space(8) & Space(8) & Ceros("", 11) & Space(1) & Space(8) & ESPACIOS_CL((datos(23)), 8, "D") & ESPACIOS_CL("9999", 8, "D")
    
    cLine = cLine & "0000" & Space(8) & "00" & Space(8) & Space(15) & Space(40) & Space(20) & Space(20)
'    If datos(12) = "" Then
'      p = p
'    End If
    cLine = cLine & IIf(datos(12) = "", Space(8), Format(datos(12), "YYYYMMDD")) & IIf(datos(21) = "", Space(8), ESPACIOS_CL((datos(21)), 8, "I")) & ESPACIOS_CL((datos(20)), 1, "D") & Format(Val(datos(13)), "0") & IIf(nrocalidad = "0", Space(8), ESPACIOS_CL((nrocalidad), 8, "D")) & NumeroFax
    
    cLine = cLine & ESPACIOS_CL("MDIN", 8, "D") & ESPACIOS_CL((datos(22)), 8, "D") & ESPACIOS_CL("MDIN", 8, "D") & ESPACIOS_CL((datos(16)), 8, "D") & IIf(datos(17) = "0", Space(8), ESPACIOS_CL((datos(17)), 8, "D")) & Space(8)
    
    cLine = cLine & Space(1) & ESPACIOS_CL((datos(18)), 4, "D") & Space(30) & Space(8) & Space(1) & Ceros("", 11) & Ceros("", 8) & Ceros("", 8) & Ceros("", 8) & Ceros("", 8) & Ceros("", 14)
    
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
 cNomArchivo = gsBac_DIRIN & NombreArchivo
 Screen.MousePointer = 11
 If Not Bac_Sql_Execute("Sp_interfaz_Balance_Trader") Then
 Screen.MousePointer = 0
    MsgBox "Problemas al leer operaciones", vbCritical, "MENSAJE"
    Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "ERROR Interfaz de Balance BO15 NO REALIZADA  " & cNomArchivo & err.Number & " Descripción: " & err.Description)
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
   
 Do While Bac_SQL_Fetch(datos())
 
    If Prg.Max >= 10 Then Prg.Max = datos(1)
      
     cLine = ""
     cLine = cLine & ESPACIOS_CL((datos(2)), 3, "D") & Format(gsBac_Fecp, "yyyymmdd") & ESPACIOS_CL((datos(3)), 14, "D") & "001"
     cLine = cLine & ESPACIOS_CL((datos(4)), 4, "D") & ESPACIOS_CL((datos(5)), 4, "D") & ESPACIOS_CL((datos(6)), 16, "D") & Space(1) & "M"
     cLine = cLine & ESPACIOS_CL((datos(7)), 20, "D") & Format(gsBac_Fecp, "yyyymmdd") & ESPACIOS_CL((datos(9)), 20, "D") & Format(datos(18), "00") & datos(10) & ESPACIOS_CL((datos(11)), 3, "D") & datos(12)
     cLine = cLine & Format(saca_punto(Trim(Str(datos(13))), 2), "000000000000000000") & datos(14) & Format(saca_punto(Trim(Str(datos(15))), 2), "000000000000000000")
     cLine = cLine & datos(16) & Format(saca_punto(Trim(Str(datos(13))), 2), "000000000000000000") & "1  " & Space(10)
     
     If Len(cLine) <> 178 Then
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
    cLine = cLine & ("99" & Format(gsBac_Fecp, "yyyymmdd") & Format(totalreg, "0000000000")) & Space(158)
    Print #1, cLine
    Close #1

    MsgBox "Interfaz de Balance BO15" & " " & cNomArchivo & "(Cant.Reg. " & totalreg & ")", vbOKOnly, "MENSAJE"
    Screen.MousePointer = 0
    Prg.Visible = False
    Label2.Visible = False
    Exit Sub
   
Herror1:
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
 cNomArchivo = gsBac_DIRIN & NombreArchivo

 If Not Bac_Sql_Execute("Sp_Interfaz_direcciones_trader") Then
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
   
 Do While Bac_SQL_Fetch(datos())
 
    If Len(datos(10)) > 11 Then
        NroTel = Mid$(datos(10), 1, 7)
        NumeroTel = Format(Val(NroTel), "00000000000")
    Else
       NumeroTel = Format(Val(datos(10)), "00000000000")
    End If
   
     If Prg.Max >= 10 Then Prg.Max = datos(6)
      
     cLine = ""
     cLine = cLine & ESPACIOS_CL(datos(3) + datos(4), 15, "D") & ESPACIOS_CL((datos(1)), 8, "D") & ESPACIOS_CL((datos(2)), 8, "D")
     cLine = cLine & ESPACIOS_CL((datos(5)), 16, "D") & ESPACIOS_CL((datos(7)), 40, "D") & Space(40) & IIf(datos(9) = "0", Space(8), ESPACIOS_CL((datos(8)), 8, "D")) & IIf(datos(9) = "0", Space(8), ESPACIOS_CL((datos(9)), 8, "2"))
     cLine = cLine & IIf(NumeroTel = 0, "00000000000", NumeroTel) & Format(datos(11), "YYYYMMDD")
     
         
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
 cNomArchivo = gsBac_DIRIN & NombreArchivo
 Screen.MousePointer = 11
 If Not Bac_Sql_Execute("Sp_interfaz_Flujo_Trader") Then
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
   
 Do While Bac_SQL_Fetch(datos())
 
    If Prg.Max >= 10 Then Prg.Max = datos(1)
      
     cLine = ""
     cLine = cLine & ESPACIOS_CL((datos(2)), 3, "D") & Format(gsBac_Fecp, "yyyymmdd") & ESPACIOS_CL((datos(3)), 14, "D")
     cLine = cLine & ESPACIOS_CL((datos(4)), 3, "D") & ESPACIOS_CL(("MD01"), 16, "D") & ESPACIOS_CL((datos(6)), 20, "D") & Format(datos(7), "yyyymmdd")
     cLine = cLine & Format(saca_punto(Trim(Str(datos(8))), 2), "000000000000000000") & Format(saca_punto(Trim(Str(datos(9))), 2), "000000000000000000")
     cLine = cLine & Format(saca_punto(Trim(Str(datos(10))), 2), "000000000000000000") & "1  " & Space(10)
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
    
 Dim Total          As Integer
 Dim totalreg       As Integer
 Dim cDia           As String
 Dim cNomArchivo    As String
 Dim cLine          As String
 

 On Error GoTo Herror1
 Total = 0
 totalreg = 0
 cNomArchivo = ""
 cDia = Format(gsBac_Fecp, "ddmmyy")
 cNomArchivo = gsBac_DIRIN & NombreArchivo  '& ".DAT"
 
 Screen.MousePointer = 11
   If Not Bac_Sql_Execute("Sp_Interfaz_operaciones_trader") Then
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
    
  
   Do While Bac_SQL_Fetch(datos())
   
      If Prg.Max >= 10 Then Prg.Max = datos(24)
      
            
     cLine = ""
     cLine = cLine & "CL " & ESPACIOS_CL((datos(1)), 8, "D") & Format(gsBac_Fecp, "YYYYMMDD") & ESPACIOS_CL("OP15", 14, "D")
     
     cLine = cLine & "001" & "1  " & ESPACIOS_CL((datos(2)), 3, "D") & "1" & "MDIR" & ESPACIOS_CL((datos(4)), 4, "D") & ESPACIOS_CL("MD01", 16, "D") & Space(1) & "M"
     
     cLine = cLine & ESPACIOS_CL((datos(1)), 8, "D") & ESPACIOS_CL((datos(28)), 8, "D") & ESPACIOS_CL(datos(5) + datos(6), 12, "D")
     
     cLine = cLine & IIf(datos(7) = 0, Space(10), ESPACIOS_CL(Str(datos(7)), 10, "D")) & ESPACIOS_CL(Trim(Str(datos(8))), 20, "D") & datos(9)
     
     cLine = cLine & datos(10) & Space(8) & "V" & ESPACIOS_CL((datos(11)), 3, "D") & datos(12)
     
     cLine = cLine & Format(saca_punto(Trim(Str(datos(13))), 2), "000000000000000000") & datos(14) & Format(saca_punto(Trim(Str(datos(15))), 2), "000000000000000000") & Ceros("", 18) & datos(16) & Format(saca_punto(Trim(Str(datos(17))), 2), "000000000000000000")
     
     cLine = cLine & datos(29) + Format(saca_punto(Trim(Str(datos(30))), 2), "000000000000000000") & datos(31) & Format(saca_punto(Trim(Str(datos(32))), 2), "000000000000000000")
     
     cLine = cLine & ESPACIOS_CL((datos(18)), 2, "D") + ESPACIOS_CL((datos(33)), 4, "D") & Format(saca_punto(Trim(Str(datos(34))), 2), "0000000000000000") & Ceros("", 16) & datos(45) & Ceros("", 16) & Space(5) & Space(4)
     
     cLine = cLine & Ceros("", 16) & Ceros("", 16) & Ceros("", 16) & datos(25) & "+" & Ceros("", 18) & Format(datos(46), "000") & "00" & "0"
     
     cLine = cLine & "+" & Ceros("", 18) & Space(8) & Space(8) & Space(8) & Space(8) & ESPACIOS_CL((datos(27)), 20, "D")
     
     cLine = cLine & Format(datos(35), "0000") & Ceros("", 4) & Format(datos(36), "0000") & datos(47) & Space(8) & Space(8) & "N" & Space(8) & Space(8) & Space(8)
     
     cLine = cLine & Format(saca_punto(Trim(Str(datos(38))), 2), "000000000000000000") & Ceros("", 18) & Ceros("", 18) & Ceros("", 18) & Ceros("", 18)
     
     cLine = cLine & Format(saca_punto(Trim(Str(datos(39))), 2), "000000000000000000") & Ceros("", 18) & Ceros("", 18) & Space(1) & Format(saca_punto(Trim(Str(datos(20))), 2), "000000000000000000")
     
     cLine = cLine & Format(saca_punto(Trim(Str(datos(21))), 2), "000000000000000000") & datos(40) & Ceros("", 3) & Format(datos(41), "0000") & Ceros("", 18) & Space(1) & Space(1) & Space(1)
     
     cLine = cLine & Format(saca_punto(Trim(Str(datos(23))), 2), "000000000000") & ESPACIOS_CL((datos(42)), 5, "D") & ESPACIOS_CL((datos(43)), 15, "D") & Space(4) & Space(4) & Space(3)
     
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
    cLine = cLine & ("99" & Format(gsBac_Fecp, "yyyymmdd") & Format(totalreg, "0000000000") & Space(766))
    Print #1, cLine
    Close #1
       
    MsgBox "Interfaz de Operaciones BO15 Generada" & " " & cNomArchivo & "(Cant.Reg. " & totalreg & ")", vbOKOnly, "MENSAJE"
    Screen.MousePointer = 0
    Prg.Visible = False
    Label2.Visible = False
    Exit Sub
   
Herror1:
   MsgBox "Error: " & err.Number & " Descripción: " & err.Description, vbCritical, "Interfaz"
   Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "ERROR Interfaz de Operaciones OP15 NO REALIZADA  " & cNomArchivo & err.Number & " Descripción: " & err.Description)
   Exit Sub


End Sub

Sub Clientes()

 Dim cLine          As String
 Dim cNomArchivo    As String
 Dim cDia           As String
 Dim cruta          As String
 Dim datos
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
  
Do While Bac_SQL_Fetch(datos)

    If Prg.Max >= 10 Then Prg.Max = datos(19)
          
    If Len(datos(14)) > 1 Then
        nrocal = Mid$(datos(14), 1, 1)
        nrocalidad = Format(Val(nrocal), "0")
    Else
       nrocalidad = Format(Val(datos(14)), "0")
    End If
        
    If Len(datos(11)) > 11 Then
        NroTel = Mid$(datos(11), 1, 7)
        NumeroTel = Format(Val(NroTel), "00000000000")
    Else
       NumeroTel = Format(Val(datos(11)), "00000000000")
    End If
    
    If Len(datos(15)) > 11 Then
        NroFax = Mid$(datos(15), 1, 7)
        NumeroFax = Format(Val(NroFax), "00000000000")
    Else
       NumeroFax = Format(Val(datos(15)), "00000000000")
    End If
    
    cLine = ""
    
    cLine = cLine & ESPACIOS(Trim(datos(1)) + datos(2), 15) & datos(3) & ESPACIOS(Trim(datos(4)), 10) & ESPACIOS(Trim(datos(5)), 40)
    cLine = cLine & ESPACIOS(Trim(datos(6)), 20) & ESPACIOS(Trim(datos(7)), 20) & ESPACIOS(Trim(datos(8)), 40)
    cLine = cLine & ESPACIOS(Trim(datos(9)), 4) & ESPACIOS(Trim(datos(10)), 4) & NumeroTel
    cLine = cLine & Space(40) & Space(4) & Space(4) & "00000000000" & Space(1) & Space(8) & Space(1) & "00000000000"
    cLine = cLine & "0000" & "0000" & Space(8) & "00" & Space(1) & Space(15) & Space(40) & Space(20)
    cLine = cLine & Space(20) & Format(datos(12), "ddmmyyyy") & datos(20) & Format(Val(datos(13)), "0") & nrocalidad & NumeroFax
    cLine = cLine & Space(4) & ESPACIOS(Trim(datos(16)), 4) & ESPACIOS(Trim(datos(17)), 4) & Space(4)
    cLine = cLine & Space(1) & ESPACIOS(Trim(datos(18)), 4) & Space(30) & Space(4) & "00000000" & "00000000" & "00000000000000" & Space(1)
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
            I = 1
            
            Screen.MousePointer = 11
             If Dir(NOMBRE) <> "" Then
               Kill NOMBRE
             End If
            p = 1
            Open NOMBRE For Append As #1
           
            Do While Bac_SQL_Fetch(datos())
                
                 Linea = ""
                 Linea = Ceros(Trim(datos(1)), 9) & Trim(datos(1))
                 Linea = Linea & Ceros(Trim(datos(2)), 1) & IIf(IsNull(datos(2)), "", Trim(datos(2)))
                 Linea = Linea & Trim(datos(3)) & ESPACIOS(Trim(datos(3)), 30)
                 Linea = Linea & Trim(datos(4)) & ESPACIOS(Trim(datos(4)), 10) & "D"
                 Linea = Linea & Ceros(Trim(datos(5)), 9) & Trim(datos(5))
                 Linea = Linea & Ceros(Trim(datos(6)), 1) & Trim(datos(6)) & "00000"
                 
                 Linea = Linea & ESPACIOS(Trim(datos(7)), 4) & Trim(datos(7))
                 Linea = Linea & ESPACIOS(Trim(datos(8)), 8) & datos(8)
                 
                 Linea = Linea & Ceros(Int(datos(9)), 14) & Int(datos(9))
                 Linea = Linea & Ceros(Trim(datos(10)), 3) & Trim(datos(10))
                 Linea = Linea & Ceros(Trim(datos(11)), 3) & Trim(datos(11))
                 
                            
                 Linea = Linea & Ceros(Int(datos(12)), 3) & Int(datos(12))
                 Deci = SacaDecim(Round(Format(datos(12), "##0.0000") - Int(datos(12)), 2))
                 Linea = Linea & Mid(Trim(Deci), 1, 2) & Ceros(Trim(Deci), 2) & "00000"
                 
                 Linea = Linea & ESPACIOS(Trim(datos(13)), 8) & Trim(datos(13))
                 Linea = Linea & ESPACIOS(Trim(datos(13)), 8) & Trim(datos(13))
                                                  
                 If Val(datos(20)) < 0 Then
                    Linea = Linea & "-" & Ceros(Int(datos(20)), 14) & Abs(Int(datos(20)))
                 Else
                    Linea = Linea & Ceros(Int(datos(20)), 14) & Int(datos(20))
                 End If
                 
                 Linea = Linea & "01"
                 Linea = Linea & Format(Val(datos(19)), "000")
                 Linea = Linea & Ceros("", 26) & "IF" & "0071" & "002115" & Ceros("", 14)
                 Linea = Linea & Space(43)
                 Monto = Monto + datos(20)
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
 cNomArchivo = gsBac_DIRIN & NombreArchivo  '& ".DAT"
 
 Screen.MousePointer = 11
   If Not Bac_Sql_Execute("Sp_interfaz_Posicion_cliente") Then
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
   
   Do While Bac_SQL_Fetch(datos())
     
     If Prg.Max >= 10 Then Prg.Max = datos(1)
     
     'Suma = 0
     'If datos(7) = "70" Then
     '   Suma = Val(datos(33)) + Val(datos(35)) + Val(datos(36))
     'Else
     '   Suma = Val(datos(33)) + Val(datos(35)) + Val(datos(36))
     'End If
     
     If datos(36) < 0 Then
        EXPUC8 = "-"
     Else
        EXPUC8 = "+"
     End If
     
     cLine = ""
     cLine = cLine & datos(2) & datos(3) & "999" & Ceros((datos(5)), 16) + (datos(5))
     cLine = cLine & Ceros("", 8) & Ceros("", 12) & ESPACIOS_CL((datos(6)), 4, "D") & ESPACIOS_CL((datos(7)), 2, "D") & ESPACIOS_CL((datos(8)), 4, "D") & Ceros((datos(9)), 2) + datos(9)
     cLine = cLine & Ceros("", 9) & Space(4) & Space(4) & "CL  " & Space(4) & Space(4) & IIf(datos(10) = "0", Space(4), ESPACIOS_CL((datos(10)), 4, "D")) & ESPACIOS_CL((datos(11)), 4, "D") & Space(4) & Space(4) & Space(6) & Space(4) & Space(4)
     cLine = cLine & Space(4) & ESPACIOS_CL(EXPUC8, 4, "D") & Space(1) & Space(4) & "BTR " & Ceros("", 12) & ESPACIOS_CL((datos(12)), 35, "D") & Ceros((datos(13)), 2) + (datos(13)) & Ceros((datos(14)), 2) + (datos(14))
     cLine = cLine & Ceros((datos(15)), 4) + (datos(15)) & ESPACIOS_CL((datos(16)), 4, "D") & ESPACIOS_CL((datos(17)), 16, "D") & Ceros("", 12) & ESPACIOS_CL(datos(18) + datos(19), 15, "D")
     cLine = cLine & Space(4) & Ceros("", 6) & datos(20) & Space(1) & Space(4) & Space(4) & Ceros((datos(21)), 2) + (datos(21)) & Ceros((datos(22)), 2) + (datos(22)) & Ceros((datos(23)), 4) + (datos(23))
     cLine = cLine & Ceros((datos(24)), 2) + (datos(24)) & Ceros((datos(25)), 2) + (datos(25)) & Ceros((datos(26)), 4) + (datos(26)) & Ceros("", 2) & Ceros("", 2) & Ceros("", 4) & Ceros("", 3) & Ceros("", 4) & Ceros("", 1)
     cLine = cLine & Format(saca_punto(Trim(Str(datos(27))), 6), "000000000") & Ceros((datos(28)), 4) + (datos(28)) & Format(saca_punto(Trim(Str(datos(29))), 6), "000000000") & Ceros("", 9) & Ceros("", 2) & Ceros("", 2) & Ceros("", 4)
     cLine = cLine & Ceros("", 2) & Ceros("", 2) & Ceros("", 4) & Ceros("", 2) & Ceros("", 2) & Ceros("", 4) & Ceros("", 2) & Ceros("", 2) & Ceros("", 4) & Format(saca_punto(Trim(Str(datos(30))), 2), "000000000000000")
     cLine = cLine & Format(saca_punto(Trim(Str(datos(31))), 2), "000000000000000") & Ceros("", 15) & Ceros("", 15) & Replace(Format(datos(42), "00000.000000"), gsBac_PtoDec, "") & Ceros("", 15) & Ceros("", 15) & Space(4) & Space(4) & Space(4) & Space(4) & Format(saca_punto(Trim(Str(datos(32))), 2), "000000000000000")
     cLine = cLine & Format(saca_punto(Trim(Str(datos(33))), 2), "000000000000000") & Format(saca_punto(Trim(Str(datos(34))), 2), "000000000000000") & Format(saca_punto(Trim(Str(datos(35))), 2), "000000000000000")
     cLine = cLine & Format(saca_punto(Trim(Str(datos(36))), 2), "000000000000000") & Ceros("", 15) & Ceros("", 15) & Ceros("", 15) & Ceros("", 15) & Ceros("", 15) & Ceros("", 15) & Ceros("", 15)
     cLine = cLine & Format(saca_punto(Trim(Str(datos(43))), 2), "000000000000000") & Ceros("", 15) & Ceros("", 15) & Ceros("", 15) & Space(4) & Ceros("", 2) & Ceros("", 2) & Ceros("", 4) & Ceros("", 15) & Ceros("", 15) & Ceros("", 15)
     cLine = cLine & Ceros("", 4) & Ceros("", 4) & Ceros("", 4) & Ceros("", 2) & Ceros("", 2) & Ceros("", 4) & Ceros("", 4) & Ceros("", 4) & Ceros("", 4) & Ceros("", 4) & Ceros("", 2) & Ceros("", 2) & Ceros("", 4) & Space(2)
     cLine = cLine & Space(4) & Ceros("", 9) & Space(15) & Format(saca_punto(Trim(Str(datos(38))), 2), "000000000000000") & Ceros("", 2) & Ceros("", 2) & Ceros("", 4) & datos(39) & "X" & datos(41)
          
         
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
Dim datos()

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
        Do While Bac_SQL_Fetch(datos())
            cLine = cLine & datos(1) & datos(2) & datos(3) & datos(4) & Format(datos(5), "ddmmyy")
            cLine = cLine & Format(datos(6), "000000") & Format(datos(7), "00000") & datos(8) & datos(9)
            cLine = cLine & Format(datos(10), "0000000000000") & "00" & datos(11) & datos(12) & datos(13)
            cLine = cLine & Format(datos(14), "00000") & datos(15) & datos(16) & Format(datos(17), "0000000000000") & "00" & datos(18)
            cLine = cLine & Format(datos(19), "000000") & datos(20)
            cLine = cLine & Format(datos(21), "00") & Format(datos(22), "00") & datos(23) & datos(24) & datos(25) & datos(26) & datos(27) & datos(28)
            cLine = cLine & datos(29) & datos(30) & datos(31) & datos(32) & datos(33) & datos(34) & datos(35) & datos(36) & datos(37) & datos(38) & datos(39) & datos(40)
            cLine = cLine & datos(41) & datos(42) & datos(43) & datos(44)
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

        Do While Bac_SQL_Fetch(datos())
            Linea = datos(1) & Ceros(Trim(datos(2)), 11) & Trim(datos(2))
            Linea = Linea & Ceros(Trim(datos(3)), 13) & Trim(datos(3))
            Linea = Linea & Ceros(Trim(datos(4)), 13) & Trim(datos(4))
            Print #1, Linea
            p = p + 1
            Prg.Max = p
            BacControlWindows 20
            Prg.Value = p
            nTotal1 = nTotal1 + CDbl(datos(2))
            nTotal2 = nTotal2 + CDbl(datos(3))
            nTotal3 = nTotal3 + CDbl(datos(4))
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
            I = 1
            
            Screen.MousePointer = 11
             If Dir(NOMBRE) <> "" Then
               Kill NOMBRE
             End If
            p = 1
            Open NOMBRE For Append As #1
           
            Do While Bac_SQL_Fetch(datos())
                
                 Linea = ""
                 Linea = Ceros(Trim(datos(1)), 10) & Trim(datos(1))
                 Linea = Linea & Trim(datos(2)) & ESPACIOS(Trim(datos(2)), 10)
                 Linea = Linea & Trim(datos(3)) & ESPACIOS(Trim(datos(3)), 8)
                 Linea = Linea & Trim(datos(4)) & ESPACIOS(Trim(datos(4)), 8) & "TR"
                 Linea = Linea & Ceros(Trim(datos(5)), 3) & Trim(datos(5)) & "0"
                 
                 Linea = Linea & Ceros(Int(datos(6)), 17) & Int(datos(6))
                  
                 Linea = Linea & Ceros(Int(datos(7)), 8) & Int(datos(7))
                 Deci = SacaDecim(Round(CDbl(datos(7)) - Int(datos(7)), 2))
                 Linea = Linea & Ceros(Trim(Deci), 2) & Mid(Trim(Deci), 1, 2)
                 
                 Linea = Linea & Ceros(Int(datos(8)), 17) & Int(datos(8))
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
If Interfaz = "D3" Or Interfaz = "P17" Or Interfaz = "CTACTE" Or Interfaz = "CTACTEII" Or Interfaz = "CONTABLE" Or Interfaz = "GESTION" Then
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
On Error GoTo err
Me.Top = 0: Me.Left = 0

If Interfaz = "N_C8" Or Interfaz = "C8" Then
   cmbAño.Visible = False
   lblEtiqueta(2).Visible = False
End If

'Me.Icon = BacTrader.Icon
If Interfaz = "C8" Then NombreArchivo = "TRC8C9"
If Interfaz = "CONTABLE" Then
      cDia = Mid(Format(gsBac_Fecp, "ddmmyyyy"), 1, 4)
     'cNomArchivo = "PCTR" & cDia '& ".DAT"
     cNomArchivo = "CU" & cDia '& ".DS"
     NombreArchivo = cNomArchivo   ''"MDINTCO"
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

If Interfaz = "C14" Then NombreArchivo = "TRC14C15"
If Interfaz = "COLOCACIONES" Then NombreArchivo = "ICOL"
If Interfaz = "RCC" Then NombreArchivo = "RCC"
If Interfaz = "VENCIMIENTOS" Then NombreArchivo = "TRFLUJO"
If Interfaz = "CTACTEII" Then NombreArchivo = "ICTACTE"
If Interfaz = "ART57" Then NombreArchivo = "ART57"
If Interfaz = "N_C8" Then NombreArchivo = "Nueva_C8"
If Interfaz = "CARTERA" Then NombreArchivo = "XFIL" & Mid(Format(gsBac_Fecp, "mmddyyyy"), 1, 4)
If Interfaz = "FLUJOS" Then NombreArchivo = "XFLU" & Mid(Format(gsBac_Fecp, "mmddyyyy"), 1, 4)

If Interfaz = "EXEL" Then
  cmbAño.Enabled = False
  'drive = "\\bactrader\desbactrad\Ajuste valor mercado"
  'NOMBRE.Text = gsBac_DIREXEL
  'Directorio.Path = gsBac_DIREXEL
  'drive.Enabled = False
 ' Directorio.Enabled = False
 
  Me.Caption = "Grabar Planilla a Exell"
  NombreArchivo = "Tasamer.xls"    '' otra utilidad con la exportacion a exel
End If


Frame1.Visible = True
    SSCommand1.Top = 4020
    Label2.Top = 4440
    Prg.Top = 4030
    Me.SSPanel1.Height = 4770
    Me.Height = 5175
    For I = 1990 To 2020
        cmbAño.AddItem I
        cmbAño.ItemData(cmbAño.NewIndex) = I
    Next
'    Call BacLLenaComboMes(cmbMes)
    Call bacBuscarCombo(cmbAño, Year(gsBac_Fecp))
'    Call bacBuscarCombo(cmbMes, Month(gsBac_Fecp))
    cmbMes.Visible = False
    lblEtiqueta(1).Visible = False
'End If

If Interfaz = "GESTION" Then
    NombreArchivo = "Mdinges"
    Frame1.Visible = True
    SSCommand1.Top = 4020
    Label2.Top = 4440
    Prg.Top = 4030
    Me.SSPanel1.Height = 4770
    Me.Height = 5175
    For I = 1990 To 2020
        cmbAño.AddItem I
        cmbAño.ItemData(cmbAño.NewIndex) = I
    Next
    
    Call BacLLenaComboMes(cmbMes)
    Call bacBuscarCombo(cmbAño, Year(gsBac_Fecp))
    Call bacBuscarCombo(cmbMes, Month(gsBac_Fecp))
    
End If
'Directorio.Path = App.Path & "\interfaces"
'If Me.Interfaz = "EXEL" Then
'Directorio.Path = gsBac_DIREXEL'
'Else
'End If

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
        Sql = ""
        envia = Array("")
        Screen.MousePointer = 11
        'Sql = "Sp_interfaz_C8"
        If Not Bac_Sql_Execute("Sp_interfaz_c8") Then    'Cambiar Sp_interfaz_C8
            Screen.MousePointer = 0
            MsgBox "No se puede generar Interfaz ", vbCritical, Msj
            Exit Sub
        Else
            I = 1
            
            Screen.MousePointer = 11
             If Dir(NOMBRE) <> "" Then
               Kill NOMBRE
             End If
            p = 1
            Open NOMBRE For Append As #1
            
            Do While Bac_SQL_Fetch(datos())
                
                 Linea = ""
                 Linea = Format(DatePart("d", gsBac_Fecp), "00") & "TR" & Ceros(Trim(datos(1)), 10) & Trim(datos(1)) ' cuenta
                 Linea = Linea & Ceros(Trim(datos(2)), 3) & Trim(datos(2)) ' moneda
                 Linea = Linea & Ceros(Trim(datos(3)), 1) & Trim(datos(3)) 'tipo_tasa
                 Linea = Linea & Trim(datos(4)) & ESPACIOS(Trim(datos(4)), 8) 'fecven
                 
                 Linea = Linea & Ceros(Int(datos(5)), 14) & Int(datos(5)) 'amortizacion
                 Deci = SacaDecim(Round(CDbl(datos(5)) - Int(datos(5)), 4))
                 Linea = Linea & Trim(Deci) & Ceros(Trim(Deci), 4)
                      
                                  
                 Linea = Linea & Ceros(Int(datos(6)), 3) & Int(datos(6)) 'tir
                 Deci = SacaDecim(Round(CDbl(datos(6)) - Int(datos(6)), 4))
                 Linea = Linea & Trim(Deci) & Ceros(Trim(Deci), 4)
                 
                 Linea = Linea & Ceros(Int(datos(7)), 14) & Int(datos(7)) 'saldo
                 Deci = SacaDecim(Round(CDbl(datos(7)) - Int(datos(7)), 4))
                 Linea = Linea & Trim(Deci) & Ceros(Trim(Deci), 4)
                 
                 
                 
'                Linea = Linea & Trim(Datos(8)) & ESPACIOS(Trim(Datos(8)), 5)
                 Linea = Linea & Format(Val(datos(8)), "00000") 'inversion
                 Linea = Linea & Trim(datos(9)) & ESPACIOS(Trim(datos(9)), 1) 'tipo_cuenta

                 Prg.Value = p
                 p = p + 1
                 Print #1, Linea
                 Prg.Max = datos(11)
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

On Error GoTo error

    
   Deci = "0"
   If UCase(Interfaz) = "C8" Then
      Call C8
   End If

'********************************************************
   If UCase(Interfaz) = "CONTABLE" Then
      Call InterfazContable
   End If
   
   
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
    
    
   Unload Me
Exit Sub
error:
   MsgBox err.Description, err.Number, ("Bactrader")
   Close #1
   Screen.MousePointer = 0

End Sub

Private Sub Cartera()
 Dim cLine As String
 Dim cNomArchivo As String
 Dim cDia As String
 Dim cruta As String
 Dim datos
 Dim Punto As String
 Dim p, SW As Integer
 Dim Conta As Integer
 On Error GoTo Herror1
 Punto = "."
 cDia = Mid(Format(gsBac_Fecp, "ddmmyyyy"), 1, 4)
 cNomArchivo = gsBac_DIRCO & NombreArchivo & ".TXT"
 MousePointer = 11
SW = 1
 Data1.DatabaseName = gsPath_Dbf
 Data1.RecordSource = "XFILMMDD.DBF"
 Data1.Refresh
 Data1.Recordset.MoveFirst
 
 Do While Not Data1.Recordset.EOF()
       Sql = " sp_llena_flujo_cartera "
      Sql = Sql & "'" & Data1.Recordset!CRUT & "'"
      Sql = Sql & ",'" & Data1.Recordset!CREF & "'"
      Sql = Sql & ",'" & Data1.Recordset!NCOPE1 & "'"
      Sql = Sql & ",'" & Data1.Recordset!NCSUP & "'"
      Sql = Sql & ",'" & Data1.Recordset!NCTAS & "'"
      Sql = Sql & ",'" & Data1.Recordset!NSCTA & "'"
      Sql = Sql & ",'" & Data1.Recordset!NCALI & "'"
      Sql = Sql & ",'" & Data1.Recordset!NTIPC & "'"
      Sql = Sql & ",'" & Data1.Recordset!NCPRO & "'"
      Sql = Sql & ",'" & Data1.Recordset!CTCAR & "'"
      Sql = Sql & ",'" & Data1.Recordset!NTCRE & "'"
      Sql = Sql & ",'" & Data1.Recordset!DFOTO & "'"
      Sql = Sql & ",'" & Data1.Recordset!NVORI & "'"
      Sql = Sql & ",'" & Data1.Recordset!NCUPO & "'"
      Sql = Sql & ",'" & Data1.Recordset!NVATC & "'"
      Sql = Sql & ",'" & Data1.Recordset!CCMON & "'"
      Sql = Sql & ",'" & Data1.Recordset!CCMOR & "'"
      Sql = Sql & ",'" & Data1.Recordset!NMONE & "'"
      Sql = Sql & ",'" & Data1.Recordset!nBase & "'"
      Sql = Sql & ",'" & Data1.Recordset!NTASA1 & "'"
      Sql = Sql & ",'" & Data1.Recordset!CTTAS & "'"
      Sql = Sql & ",'" & Data1.Recordset!NTCOM & "'"
      Sql = Sql & ",'" & Data1.Recordset!NTCOF & "'"
      Sql = Sql & ",'" & Data1.Recordset!DFEXT & "'"
      Sql = Sql & ",'" & Data1.Recordset!DFVEN & "'"
      Sql = Sql & ",'" & Data1.Recordset!NCAPI & "'"
      Sql = Sql & ",'" & Data1.Recordset!NPCRB & "'"
      Sql = Sql & ",'" & Data1.Recordset!NPZOP & "'"
      Sql = Sql & ",'" & Data1.Recordset!NNCUA & "'"
      Sql = Sql & ",'" & Data1.Recordset!NMCUA & "'"
      Sql = Sql & ",'" & Data1.Recordset!NMATR & "'"
      Sql = Sql & ",'" & Data1.Recordset!NISIS & "'"
      Sql = Sql & ",'" & Data1.Recordset!NOFIO & "'"
      Sql = Sql & ",'" & Data1.Recordset!NOFCO & "'"
      Sql = Sql & ",' ' " 'Data1.Recordset!NCEJE
      Sql = Sql & ",'" & Data1.Recordset!NCCOS & "'"
      Sql = Sql & ",'" & Data1.Recordset!DFTAS & "'"
      Sql = Sql & ",'" & Data1.Recordset!DIFERE & "'"
      Sql = Sql & ",'" & Data1.Recordset!NNCUP & "'"
      Sql = Sql & ",'" & Data1.Recordset!NCOPI & "'"
      Sql = Sql & ",'" & Data1.Recordset!NINTE1 & "'"
      Sql = Sql & ",'" & Data1.Recordset!NCOPR & "'"
      Sql = Sql & ",'" & Data1.Recordset!NREAJ & "'"
      Sql = Sql & ",'" & Data1.Recordset!CCJUD & "'"
      Sql = Sql & ",'" & Data1.Recordset!cInfo & "'"
      Sql = Sql & ",'" & Data1.Recordset!CRELL & "'"
      Sql = Sql & "," & SW
  If Not Bac_Sql_Execute(Sql) Then
      MsgBox "Problemas al ejecutar procedimiento para la Generacion interfaz de  operaciones  " & Sql, vbCritical, "MENSAJE"
      Exit Sub
  End If
  Data1.Recordset.MoveNext
 Sql = ""
 SW = 0
 Loop
 Data1.Recordset.Close
 
 Sql = "Sp_interfaz_Flujo"    ' CARTERA
 
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

 
Do While Bac_SQL_Fetch(datos)
   If Prg.Max = 100 Then Prg.Max = datos(49)
    If SW = 0 Then
        cLine = "1                              0000000000000000000000   00" & Format(gsBac_Fecp, "yyyymmdd") & "0000000000000000000000000000000000000000000000000000000000   00000000000000000000000000000000000000000000000000000000000000000000000PCT0000000000   00000000000000000000000000000000000000000000000000000000000"
        Print #1, cLine
        SW = 1
    End If
    
   cLine = ""
   cLine = cLine & datos(1) & Format(datos(2), "0000000000") & Format(datos(3), "00000000000000000000")
   cLine = cLine & IIf(datos(4) = "", "00000", Format(datos(4), "00000")) & Format(datos(5), "0000") & datos(6) & datos(7) & datos(8) & datos(9)
   cLine = cLine & datos(10) & datos(11) & datos(12) & Format(datos(13), "yyyymmdd") & Format(saca_punto(Str(datos(14)), 0), "000000000000000")
   cLine = cLine & Format(datos(15), "000000000000000") & Format(saca_punto(Str(datos(16)), 4), "000000000000") & datos(17)
   cLine = cLine & Format(datos(18), "00") & Format(datos(19), "000") & Format(datos(20), "000") & Format(saca_punto(Str(datos(21)), 4), "000000") & datos(22)
   cLine = cLine & Format(saca_punto(Str(datos(23)), 4), "000000") & datos(24) & Format(datos(25), "yyyymmdd") & Format(datos(26), "yyyymmdd")
   cLine = cLine & Format(datos(27), "000000000000000") & datos(28) & Format(datos(29), "0000")
   cLine = cLine & datos(30) & datos(31) & datos(32) & datos(33) & datos(34) & datos(35) & Space(3) & datos(37)
   cLine = cLine & Format(datos(38), "yyyymmdd") & Format(datos(39), "000") & Format(datos(40), "000")
   cLine = cLine & Format(datos(41), "00000") & IIf(Val(datos(42)) < 0, saca_menos2(Format(datos(42), "000000000000000")), Format(datos(42), "000000000000000"))
   cLine = cLine & Format(datos(43), "00000") & IIf(Val(datos(44)) < 0, saca_menos2(Format(datos(44), "000000000000000")), Format(datos(44), "000000000000000")) & datos(45)
   cLine = cLine & datos(46) & Format(datos(47), "00000") '& "0000000000"
   
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
cLine = "3                              0000000000000000000000   00" & Format(gsBac_Fecp, "yyyymmdd") & "000000000000000" & Format(datos(49), "000000000000000") & "0000000000000000000000000000   0000000000000000000000000000" & Format(datos(51), "000000000000000") & "0000000000000000000000000000PCT0000000000   00000000000000000000000000000000000000000000000000000000000"

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
 Dim datos
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
 Data1.DatabaseName = gsPath_Dbf
 Data1.RecordSource = "Xflummdd.dbf"
 Data1.Refresh
 Data1.Recordset.MoveFirst

 Do While Not Data1.Recordset.EOF()
      Sql = "sp_llena_xflu_vencimientos"
      Sql = Sql & "'" & Data1.Recordset!nRut & "'"
      Sql = Sql & ",'" & Data1.Recordset!nREF & "'"
      Sql = Sql & ",'" & Data1.Recordset!NCOPE2 & "'"
      Sql = Sql & ",'" & Data1.Recordset!nCorr & "'"
      Sql = Sql & ",'" & Data1.Recordset!nCua & "'"
      Sql = Sql & ",'" & Data1.Recordset!nNtoc & "'"
      Sql = Sql & ",'" & Data1.Recordset!nSepa & "'"
      Sql = Sql & ",'" & Data1.Recordset!nSep & "'"
      Sql = Sql & ",'" & Data1.Recordset!nFven & "'"
      Sql = Sql & ",'" & Data1.Recordset!nVamo & "'"
      Sql = Sql & ",'" & Data1.Recordset!nInte & "'"
      Sql = Sql & ",'" & Data1.Recordset!nComi & "'"
      Sql = Sql & ",'" & Data1.Recordset!nVcuo & "'"
      Sql = Sql & ",'" & Data1.Recordset!nSvca & "'"
      Sql = Sql & ",'" & Data1.Recordset!nTasa & "'"
      Sql = Sql & ",'" & Data1.Recordset!nRell & "'"
      Sql = Sql & ", " & SW
    If Not Bac_Sql_Execute(Sql) Then
        MsgBox "Problemas al ejecutar procedimiento para la interfaz Xflu" & Sql, vbCritical, "MENSAJE"
        Exit Sub
    End If
    Data1.Recordset.MoveNext
    Sql = ""
    SW = 0
 Loop
 Data1.Recordset.Close
 
 
 Sql = "Sp_interfaz_Flujo_Vcto_2"
 If Not Bac_Sql_Execute(Sql) Then
    MsgBox "Problemas al ejecutar procedimiento " & Sql, vbCritical, "MENSAJE"
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
  
Do While Bac_SQL_Fetch(datos)
    If Prg.Max = 100 Then Prg.Max = datos(19)

    If SW = 0 Then
        cLine = ""
        cLine = "1" & "00000000000000000000000000000000000000000000000" & Format(gsBac_Fecp, "yyyymmdd") & "0000000000000000000000000000000000000" & Format(0, "000000000000000") & "000000000000000000000000000000"
        Print #1, cLine
        SW = 1
    End If

    cLine = ""
    cLine = cLine & datos(1) & datos(2) & datos(3) & IIf(datos(4) = "", "00000", Format(datos(4), "00000"))
    cLine = cLine & Format(datos(5), "00") & Format(datos(6), "000") & Format(datos(7), "000") & datos(8) & Format(datos(9), "000")
    cLine = cLine & Format(datos(10), "yyyymmdd") & Format(datos(11), "000000000000000") & Format(IIf(Val(datos(12)) < 0, saca_menos2(Val(datos(12))), datos(12)), "000000000000000")
    cLine = cLine & Format(datos(13), "000000000000000") & Format(datos(14), "000000000000000")
    cLine = cLine & Format(datos(15), "000000000000000") & Format(saca_punto(Str(datos(16)), 4), "0000000") & Space(8) 'datos(17)
    
If Len(cLine) <> 146 Then
    p = p
 End If
    
    p = p + 1
    
    Prg.Value = p
    Print #1, cLine
Loop

cLine = ""
cLine = "3                              0000000000000 000" & Format(gsBac_Fecp, "yyyymmdd") & "000000000000000000000000000000000000000000000" & Format(Prg.Max, "000000000000000") & Format(datos(20), "000000000000000") & "0000000"
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

For I = Len(xstring) + 1 To 15
If I = 15 Then
  Signo = Signo & Trim("-")
  Else
  Signo = Signo & "0"
  End If
Next

saca_menos2 = Trim(Signo) & Trim(xstring)

End Function
Private Function sac_menos(xValor As Double) As Double
Dim xstring As String
For I = 1 To Len(xValor)
If Mid(xValor, I, 1) = "-" Then
  xstring = xstring & Mid(xValor, I, 1)
  Else
  xstring = xstring & Mid(xValor, I, 1)
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
 Dim datos
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
Do While Bac_SQL_Fetch(datos)

   cLine = cLine & Format(datos(1), "000000000") & datos(2) & Format(datos(3), "00000000000000000000")
   cLine = cLine & datos(4) & Format(IIf(datos(5) = "", "00000", datos(5)), "00000") & datos(6) & Format(saca_punto(CDbl(datos(7)), 2), "000000000000000") & Format(datos(8), "yyyymmdd")
   cLine = cLine & Format(datos(9), "yyyymmdd") & datos(10)
  
   cLine = cLine & Format(saca_punto(CDbl(datos(11)), 4), "0000000") & datos(12)
   cLine = cLine & Format(saca_punto(CDbl(datos(13)), 0), "0000")
   cLine = cLine & datos(14) & datos(15) & datos(16) & datos(17)
   
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
            I = 1
            
            Screen.MousePointer = 11
             If Dir(NOMBRE) <> "" Then
               Kill NOMBRE
             End If
            p = 1
            Open NOMBRE For Append As #1
           
            Do While Bac_SQL_Fetch(datos())
                
                 Linea = ""
                 Linea = Ceros(Trim(datos(1)), 10) & datos(1)
                 Linea = Linea & Trim(datos(2)) & ESPACIOS(Trim(datos(2)), 50)
                 Linea = Linea & Format(Val(datos(3)), "00")
                 Linea = Linea & Format(Val(datos(4)), "0000")
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
Dim J As Double
Dim I As Double
Dim Exc
Dim Hoja
Dim S As Integer
Dim Sheet
Dim ruta As String
Dim Crea_xls As Boolean

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

I = 1
Do While Bac_SQL_Fetch(Arr())

    For J = 1 To 11 '3
        If (J > 2 And J < 6) Or (J > 7 And J < 10) Or (J > 10) And J <> 12 Then
            Linea = Linea & BacStrTran(IIf(Trim(Arr(J)) = "", 0, Trim(Arr(J))), ",", ".") & vbTab
        Else
            If J = 6 Then
             Linea = Linea & BacStrTran(IIf(Trim(Arr(J)) = "", 0, Trim(Arr(J))), ",", ".") & vbTab
             '   Linea = Linea & Format(IIf(Trim(Arr(J)) = "", "01/01/1900", Trim(Arr(J))), "mm/dd/yyyy") & vbTab
            ElseIf J <> 12 Then
                Linea = Linea & IIf(Trim(Arr(J)) = "", "NULL", Trim(Arr(J))) & vbTab
            End If
        End If
    Next J
    Linea = Linea + vbCrLf
    If I Mod Filas_Buffer = 0 Then
        Clipboard.Clear
        Clipboard.SetText Linea
        If I = Filas_Buffer Then
            Sheet.Range("A2").Select
        Else
            Sheet.Range("A" & CStr((I + 1) - Filas_Buffer)).Select
        End If
        Sheet.Paste
        Linea = ""
    End If

    Crea_xls = True
    I = I + 1
Loop
Clipboard.Clear
Clipboard.SetText Linea
Sheet.Range("A" & CStr((Int(I / Filas_Buffer) * Filas_Buffer) + IIf(I > Filas_Buffer, 1, 2))).Select
Sheet.Paste
Linea = ""
Clipboard.Clear

Sheet.Range("A1").Select

Hoja.Application.DisplayAlerts = False
For I = 2 To Hoja.Application.Sheets.Count
  Hoja.Application.Sheets(2).Delete
Next I
If Crea_xls Then
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


 
