VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BACCONTROLES.OCX"
Begin VB.Form FrmInterfazSii 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "INTERFAZ S.I.I"
   ClientHeight    =   3030
   ClientLeft      =   4680
   ClientTop       =   3540
   ClientWidth     =   3885
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   3030
   ScaleWidth      =   3885
   ShowInTaskbar   =   0   'False
   Begin VB.Frame FrmInterfaz 
      Height          =   1320
      Left            =   45
      TabIndex        =   0
      Top             =   1110
      Width           =   3825
      Begin MSComctlLib.ProgressBar Progress 
         Height          =   405
         Left            =   90
         TabIndex        =   6
         Top             =   840
         Width           =   3645
         _ExtentX        =   6429
         _ExtentY        =   714
         _Version        =   393216
         Appearance      =   1
      End
      Begin VB.CheckBox CkInterfazAct 
         Caption         =   "INTERFAZ S.I.I"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   225
         Index           =   0
         Left            =   150
         TabIndex        =   2
         Top             =   210
         Width           =   2595
      End
      Begin VB.CheckBox CkInterfazPas 
         Caption         =   "INTERFAZ S.I.I CLIENTE"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   225
         Index           =   1
         Left            =   150
         TabIndex        =   1
         Top             =   495
         Width           =   2595
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   3
      Top             =   0
      Width           =   3885
      _ExtentX        =   6853
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList2"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Generar Interfaz"
            ImageIndex      =   8
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   5
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin MSComctlLib.ImageList ImageList2 
      Left            =   3150
      Top             =   -120
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   8
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmInterfazSii.frx":0000
            Key             =   "Guardar"
            Object.Tag             =   "1"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmInterfazSii.frx":0452
            Key             =   "Buscar"
            Object.Tag             =   "2"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmInterfazSii.frx":08A4
            Key             =   "Eliminar"
            Object.Tag             =   "3"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmInterfazSii.frx":0CF6
            Key             =   "Limpiar"
            Object.Tag             =   "4"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmInterfazSii.frx":1010
            Key             =   "Ayuda"
            Object.Tag             =   "6"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmInterfazSii.frx":132A
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmInterfazSii.frx":1644
            Key             =   ""
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmInterfazSii.frx":1A96
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin BACControles.TXTNumero txtAno 
      Height          =   345
      Left            =   810
      TabIndex        =   4
      Top             =   630
      Width           =   1035
      _ExtentX        =   1826
      _ExtentY        =   609
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
      Text            =   "0"
      Text            =   "0"
      Min             =   "0"
      Max             =   "9999"
      MarcaTexto      =   -1  'True
   End
   Begin VB.Label Label1 
      Caption         =   "año"
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   180
      TabIndex        =   5
      Top             =   660
      Width           =   435
   End
End
Attribute VB_Name = "FrmInterfazSii"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim Ruta_SII As String
Dim Ruta_CLI As String




Private Sub Form_Load()
   Me.Top = 0
   Me.Left = 0
   Me.Icon = BacTrader.Icon
   Me.Height = 2985
   Me.Width = 3915
   Progress.Value = 0
   
End Sub

Private Sub lblEtiqueta_Click(Index As Integer)

End Sub


Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
    Case 1
        txtAno.Text = 0
        CkInterfazAct(0).Value = 0
        CkInterfazPas(1).Value = 0
        Progress.Value = 0
    Case 2
       If Trim(txtAno.Text) < 1982 Or Trim(txtAno.Text) > 2030 Then
         MsgBox "El año a buscar no es valido", vbInformation, TITSISTEMA
         txtAno.SetFocus
         Exit Sub
       End If
              
       If CkInterfazAct(0).Value = 0 And CkInterfazPas(1).Value = 0 Then
            MsgBox "Deve Seleccionar un tipo de Interfaz", vbInformation, TITSISTEMA
            Exit Sub
       End If

       Ruta_SII = ""
       Ruta_CLI = ""
       
       If CkInterfazAct(0).Value = 1 Then
       Progress.Value = 0
          Call PROC_INTERFAZ_SII("INT_SII")
       'Progress.Value = 100
       End If
       If CkInterfazPas(1).Value = 1 Then
       Progress.Value = 0
          Call PROC_INTERFAZ_SII("INT_CLI")
       'Progress.Value = 100
       End If
       
       Mensaje = "Generacion(S.I.I) en Forma Correcta " & Chr(13) & Chr(13)
       Mensaje = Mensaje & IIf(Ruta_SII <> "", "INTERFAZ S.I.I. EN                 " & Ruta_SII & Chr(13), "")
       Mensaje = Mensaje & IIf(Ruta_CLI <> "", "INTERFAZ S.I.I. CLIENTE EN " & Ruta_CLI, "")
       
       If Ruta_SII = "" And Ruta_CLI = "" Then
       Else
            MsgBox Mensaje, vbInformation, TITSISTEMA
       End If
    
    Case 3
       Unload Me
   End Select
End Sub

Private Function PROC_INTERFAZ_SII(TipoInterfaz As String)
On Error GoTo Error_vb
   Dim cNomArchivo          As String
   Dim cLinea               As String
   Dim cRegistro            As String
   Dim cSql                 As String
   Dim i                    As Long
   Dim datos()
   
   
   cLinea = ""
   cNomArchivo = ""
   
   If TipoInterfaz = "INT_SII" Then
      cNomArchivo = gsBac_DIRIN & "INTERFAZ_SII" & Trim(txtAno.Text) & ".TXT"
      Ruta_SII = gsBac_DIRIN & "INTERFAZ_SII" & Trim(txtAno.Text) & ".TXT"
   ElseIf TipoInterfaz = "INT_CLI" Then
      cNomArchivo = gsBac_DIRIN & "INTERFAZ_SIICLI" & Trim(txtAno.Text) & ".TXT"
      Ruta_CLI = gsBac_DIRIN & "INTERFAZ_SIICLI" & Trim(txtAno.Text) & ".TXT"
   End If
   
   If Dir(cNomArchivo) <> "" Then
      Kill cNomArchivo
   End If
   
   i = 1
If TipoInterfaz = "INT_SII" Then
Screen.MousePointer = 11
    Envia = Array()
    AddParam Envia, Trim(txtAno.Text)
    AddParam Envia, TipoInterfaz
    If Not Bac_Sql_Execute("SP_INTERFAZ_SII ", Envia) Then
      MsgBox "Problemas al Generar Información para Interfaz S.I.I", vbCritical, TITSISTEMA
      Screen.MousePointer = 0
      Ruta_SII = "": Ruta_CLI = ""
      Close #1
      Exit Function
   End If
   
   Open cNomArchivo For Output As #1
   
   Do While Bac_SQL_Fetch(datos())
      cLinea = ""
      cLinea = cLinea + Format((datos(1)), "00000000")
      cLinea = cLinea + ESPACIOS_CL((datos(2)), 1, "D")
      cLinea = cLinea + Format((datos(3)), "00000")
      cLinea = cLinea + Format((datos(4)), "00")
      cLinea = cLinea + Format((datos(5)), "YYYYMMDD")
      cLinea = cLinea + Format((datos(6)), "YYYYMMDD")
      cLinea = cLinea + Replace(Format((datos(7)), "00000000000000"), ",", "")
      cLinea = cLinea + Replace(Format((datos(8)), "00000000000000"), ",", "")
      cLinea = cLinea + Replace(Format((datos(9)), "000000000000"), "-", "")
      cLinea = cLinea + IIf(Format((DATOS(9)), "000000000000") >= 0, "+", "-") 'VB Se corrige dato para que aparezca el signo positivo u negativo
      If Len(datos(10)) > 11 Then
      cLinea = cLinea + Mid$(Format(saca_punto(Trim(Str(datos(10))), 0), "00000000000"), 1, 11)
      Else
      cLinea = cLinea + Format(saca_punto(Trim(Str(datos(10))), 0), "00000000000")
      End If
      
      cLinea = cLinea + Space(46)
      Print #1, cLinea
      
      Progress.Value = IIf(i > 99, 100, i)
      i = i + 1
   Loop
   Close #1
   Progress.Value = 100
 
 ElseIf TipoInterfaz = "INT_CLI" Then
   
   Screen.MousePointer = 11
   Progress.Value = 0
   
    Envia = Array()
    AddParam Envia, Trim(txtAno.Text)
    AddParam Envia, TipoInterfaz
    If Not Bac_Sql_Execute("SP_INTERFAZ_SII ", Envia) Then
      MsgBox "Problemas al Generar Información para Interfaz S.I.I de Cliente", vbCritical, TITSISTEMA
      Screen.MousePointer = 0
      Ruta_SII = "": Ruta_CLI = ""
      Close #1
      Exit Function
   End If
   
   Open cNomArchivo For Output As #1
   
   Do While Bac_SQL_Fetch(datos())
      cLinea = ""
      cLinea = cLinea + Format((datos(1)), "00000000")
      cLinea = cLinea + ESPACIOS_CL((datos(2)), 1, "D")
      cLinea = cLinea + ESPACIOS_CL((datos(3)), 35, "D")     'Format((Datos(3)), "                                   ")
      cLinea = cLinea + ESPACIOS_CL((datos(4)), 29, "D")     'Format((Datos(4)), "                             ")
      cLinea = cLinea + ESPACIOS_CL((datos(5)), 20, "D")     'Format((Datos(5)), "                    ")
      cLinea = cLinea + (datos(6))
      cLinea = cLinea + Replace(Format((datos(7)), "00000000000"), ",", "")
      cLinea = cLinea + Format((datos(8)), "00000000")
      cLinea = cLinea + Format((datos(9)), "000000")
      cLinea = cLinea + ESPACIOS_CL((datos(10)), 9, "D")    'Format((Datos(10)), "         ")
      Print #1, cLinea
      Progress.Value = IIf(i > 99, 100, i)
      i = i + 1

   Loop
   Close #1
   Progress.Value = 100
 End If
 Screen.MousePointer = 0
 Exit Function
 
Error_vb:
If err.Number = 76 Then
MsgBox "Error : " & err.Description & " " & gsBac_DIRIN, vbExclamation, TITSISTEMA
Ruta_SII = "": Ruta_CLI = ""
Screen.MousePointer = 0
Else
 MsgBox "Error : " & err.Description, vbExclamation, TITSISTEMA
 Ruta_SII = "": Ruta_CLI = ""
 Screen.MousePointer = 0
End If
  
End Function

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

Public Function bacTranMontoSql(nMonto As Variant) As String
Dim sCadena       As String
Dim iPosicion     As Integer
Dim sFormato      As String

   bacTranMontoSql = "0.0"

   sCadena = CStr(nMonto)

   iPosicion = InStr(1, sCadena, gsc_PuntoDecim)

   If iPosicion = 0 Then
      bacTranMontoSql = sCadena

   Else
      bacTranMontoSql = Mid$(sCadena, 1, iPosicion - 1) + "." + Mid$(sCadena, iPosicion + 1)

   End If

End Function


Private Function saca_punto(cValor As String, nDecim As Integer) As String
Dim x As Integer
Dim x1 As Integer
Dim xvar As String
Dim yvar As String
Dim Y As Integer
If Mid(cValor, 1, 1) = "-" Then
    cValor = Mid(cValor, 2, Len(cValor))
End If
For x = 1 To Len(cValor) 'nDecim
    If Mid(cValor, x, 1) = "." Then
      xvar = xvar & "" 'Mid(cValor, x, 1)
      x1 = Len(Mid(cValor, x + 1, Len(cValor)))
     Y = Y - 1
    ElseIf Mid(cValor, x, 1) = " " Then
     xvar = xvar & "0"
    ElseIf Mid(Trim(cValor), x, 1) <> " " Then 'cuando es un valor
    Y = Y + 1
    xvar = xvar & Mid(cValor, x, 1)
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

