VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Begin VB.Form FrmCargaArchivoThresHold 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Guarda Archivo por Cliente"
   ClientHeight    =   3525
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   4635
   LinkTopic       =   "Guarda Archivo por Cliente"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3525
   ScaleWidth      =   4635
   StartUpPosition =   2  'CenterScreen
   Begin Threed.SSPanel SSprogress 
      Align           =   2  'Align Bottom
      Height          =   435
      Left            =   0
      TabIndex        =   4
      Top             =   3090
      Width           =   4635
      _Version        =   65536
      _ExtentX        =   8176
      _ExtentY        =   767
      _StockProps     =   15
      ForeColor       =   -2147483634
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
      FloodType       =   1
      FloodColor      =   -2147483635
   End
   Begin VB.DirListBox Dir1 
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   2115
      Left            =   45
      TabIndex        =   2
      Top             =   900
      Width           =   4515
   End
   Begin VB.DriveListBox Drive1 
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
      Left            =   60
      TabIndex        =   1
      Top             =   585
      Width           =   4515
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   4635
      _ExtentX        =   8176
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   3840
         Top             =   30
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
               Picture         =   "FrmCargaArchivoThresHold.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FrmCargaArchivoThresHold.frx":0EDA
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame Frame1 
      Height          =   2655
      Left            =   0
      TabIndex        =   3
      Top             =   435
      Width           =   4635
   End
End
Attribute VB_Name = "FrmCargaArchivoThresHold"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Declare Function ShellExecute Lib "shell32.dll" Alias "ShellExecuteA" (ByVal hWnd As Long, ByVal lpOperation As String, ByVal lpFile As String, ByVal lpParameters As String, ByVal lpDirectory As String, ByVal nShowCmd As Long) As Long
Private Declare Function ShellExecuteForExplore Lib "shell32.dll" Alias "ShellExecuteA" (ByVal hWnd As Long, ByVal lpOperation As String, ByVal lpFile As String, lpParameters As Any, lpDirectory As Any, ByVal nShowCmd As Long) As Long

Private Const ERROR_FILE_NOT_FOUND = 2&
Private Const ERROR_PATH_NOT_FOUND = 3&
Private Const ERROR_BAD_FORMAT = 11&
Private Const SE_ERR_ACCESSDENIED = 5        ' access denied
Private Const SE_ERR_ASSOCINCOMPLETE = 27
Private Const SE_ERR_DDEBUSY = 30
Private Const SE_ERR_DDEFAIL = 29
Private Const SE_ERR_DDETIMEOUT = 28
Private Const SE_ERR_DLLNOTFOUND = 32
Private Const SE_ERR_FNF = 2                ' file not found
Private Const SE_ERR_NOASSOC = 31
Private Const SE_ERR_PNF = 3                ' path not found
Private Const SE_ERR_OOM = 8                ' out of memory
Private Const SE_ERR_SHARE = 26

Private Enum oCartola
   [CLIENTE] = 1
   [EJECUTIVO] = 2
End Enum


Private Sub Boton_Click()
   On Error GoTo ErrorAction
   Dim MiFile  As String

   Let MiFile = ""
   Let Comandos.FileName = "Archivos"
    
   Call Comandos.ShowSave
     
   If Comandos.FileName = "" Then

   End If
Exit Sub
ErrorAction:
    If Err.Number = 32755 Then
    
    Else
      If Err.Number <> 0 Then
         MsgBox "Error en la carga de archivo" & vbCrLf & vbCrLf & Err.Description, vbExclamation, TITSISTEMA
      End If
    End If
End Sub

Private Sub Drive1_Change()
   On Error GoTo Herror

   Dir1.Path = Drive1.Drive

Exit Sub
Herror:
   MsgBox "Error: " & Err.Number & " Descripción: " & Err.Description, vbCritical, "Interfaz"
   Drive1 = "c:\"
   Dir1.Path = "c:\"
End Sub

Private Sub Form_Load()
   Me.Icon = BacControlFinanciero.Icon
   Me.top = 0: Me.Left = 0
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 1
         Call GenerarInterfaz 'Dir1.Path
      Case 2
         Unload Me
   End Select
End Sub

Public Sub GenerarInterfaz()
   On Error GoTo BacErrorHandler
   Dim nRegistros             As Long
   Dim nContador              As Long
   Dim Datos()
   Dim HTML                   As String
   Dim StyleMsoNormalTable    As String
   Dim Titulos                As String
   Dim I                      As Integer
   Dim cNombreCli             As String
   Dim HTMLTABLE              As String
   Dim StyleSaltoPagina       As String
   Dim SaltoPagina            As String
   Dim Encabezado             As String
   Dim NewEncabezado          As String
   Dim NomArchivo             As String
   Dim NomLogo                As String
   Dim PathLogo               As String
   Dim cProdCli               As String
   Dim TablaProdCliente       As String
   Dim NewProdCli             As String
   Dim StyleMsoNormalTable2   As String
   Dim TitulosSWAP            As String
   Dim TablaProdClienteSWAP   As String
   Dim IniHTML                As String
   Dim TopMHTML               As String
   Dim PieMHTML               As String
   Dim iContador              As Long
   Dim iRegistros             As Long
   Dim oTipoCartola           As oCartola
   
   Let oTipoCartola = FRM_CON_THRESHOLD.cmbreporte.ListIndex
   
   Let PathLogo = gsRPT_Path '--> gsRPT_PathBCC
   Let NomLogo = "Logo.jpg"
        
   TopMHTML = LeeMHTML(PathLogo & "Img\" & "Top_Imagen.txt")
        
   Envia = Array()
   AddParam Envia, Trim(Right(FRM_CON_THRESHOLD.cmbSistema.List(FRM_CON_THRESHOLD.cmbSistema.ListIndex), 3))
   AddParam Envia, Trim(Right(FRM_CON_THRESHOLD.cmbpro.List(FRM_CON_THRESHOLD.cmbpro.ListIndex), 2))
   AddParam Envia, Format(FRM_CON_THRESHOLD.txt_fecha.Text, "yyyymmdd")
   AddParam Envia, CDbl(FRM_CON_THRESHOLD.TXTRut.Text)
   AddParam Envia, CDbl(FRM_CON_THRESHOLD.TxtCodCli.Text)
   AddParam Envia, gsBAC_User
   AddParam Envia, FRM_CON_THRESHOLD.cmbreporte.ListIndex
   If Not Bac_Sql_Execute("SP_CARTOLA_CLIENTE", Envia) Then
      Screen.MousePointer = vbDefault
      MsgBox "Error en SqlServer", vbCritical, TITSISTEMA
      Exit Sub
   End If
        
   StyleMsoNormalTable = "Table.MsoNormalTable" & " {mso-style-name:Tabla normal;" & " mso-tstyle-rowband-size:0;" & " mso-tstyle-colband-size:0;" & _
                         " mso-style-noshow:yes;" & " mso-style-priority:99;" & " mso-style-qformat:yes;" & " mso-style-parent:'';" & _
                         " mso-padding-alt:0cm 1.4pt 0cm 1.4pt;" & " mso-para-margin:0cm;" & " mso-para-margin-bottom:.0001pt;" & " mso-pagination:widow-orphan;" & _
                         " font-size:8.0pt;" & " font-family:Arial Narrow;}"

   StyleMsoNormalTable2 = "Table.MsoNormalTable2" & " {mso-style-name:Tabla normal;" & " mso-tstyle-rowband-size:0;" & " mso-tstyle-colband-size:0;" & _
                          " mso-style-noshow:yes;" & " mso-style-priority:99;" & " mso-style-qformat:yes;" & " mso-style-parent:'';" & _
                          " mso-padding-alt:0cm 1.4pt 0cm 1.4pt;" & " mso-para-margin:0cm;" & " mso-para-margin-bottom:.0001pt;" & _
                          " mso-pagination:widow-orphan;" & " font-size:9.0pt;" & " font-family:Arial Narrow;}"


   SaltoPagina = "<SPAN><BR CLEAR=ALL STYLE='MSO-SPECIAL-CHARACTER:LINE-BREAK;PAGE-BREAK-BEFORE:ALWAYS'></SPAN>"
                    
                    
   Encabezado = "<TABLE ALIGN =3DCENTER width=3D640 class=3DMsoNormalTable2 BORDER=3D0 CELLSPACING=3D0 CELLPADDING=3D0>" & "<TR BGCOLOR=3D#000000>" & _
                "<TD WIDTH=3D640><img src=3D'dsfsdf_image001.jpg' width=3D'640' HEIGHT=3D'56' alt='Logo'/></TD>" & _
                "</TR>" & _
                "<TR><TD WIDTH=3D640>Cartola de Derivados al " & Format(Date, "dd-mm-yyyy") & "</TD></TR>" & "<TR><TD WIDTH=640><HR></TD></TR>" & _
                "<TR><TD WIDTH=3D640>Señor(es)</TD></TR>" & _
                "<TR><TD WIDTH=3D640>#cNomCli#</TD></TR>" & _
                "<TR><TD WIDTH=3D640>#cDirCli#</TD></TR>" & _
                "<TR><TD WIDTH=3D640><HR></TD></TR>" & _
                "<TR><TD WIDTH=3D640>Cartera Forward</TD></TR>" & _
                "<TR><TD WIDTH=3D640>&nbsp;</TD></TR>" & _
                "</TABLE>"

                            
        '0 "Reporte Movimientos ThresHold (Forward y Swap)"
        '1 "Reporte Cartera Cliente"    -->No tiene Mtm
        '2 "Reporte Cartera Ejecutivo"
    
   Titulos = "<TR BGCOLOR=3D#000000>" & "<TD width=3D50>N°</TD>" & "<TD width=3D50>Operación</TD>" & _
             "<TD width=3D100>Fecha Inicio</TD>" & "<TD width=3D100>Fecha<BR>Vencimiento</TD>" & "<TD width=3D70>Pzo.Residual</TD>" & _
             "<TD width=3D70>Nocional</TD>" & "<TD width=3D70>Monto<br>Final</TD>" & "<TD width=3D70>Precio Futuro</TD>" & _
             "<TD width=3D70>Modalidad de <br>Pago</TD>" & "#TitColMtm#" & "</TR>"

   TitulosSWAP = "<TR BGCOLOR=3D#000000>" & "<TD width=3D50>N°</TD>" & "<TD width=3D50>Flujo</TD>" & _
                 "<TD width=3D100>Fecha Inicio</TD>" & "<TD width=3D100>Fecha<BR>Vencimiento</TD>" & "<TD width=3D70>Próximo<BR>Vecimiento</TD>" & _
                 "<TD width=3D70>Nocional</TD>" & "<TD width=3D70>Tasas</TD>" & "#TitColMtmSwap#" & "</TR>"

   TablaProdCliente = "<TABLE ALIGN =3DCENTER class=3DMsoNormalTable width=3D640>" & "<TR COLSPAN=10><TD WIDTH=3D640><HR></TD></TR>" & _
                        "<TR COLSPAN=10><TD WIDTH=3D640>#ProdCli#</TD></TR>" & "</TABLE>"

   TablaProdClienteSWAP = "<TABLE ALIGN =3DCENTER class=3DMsoNormalTable width=3D640>" & "<TR COLSPAN=7><TD WIDTH=3D640><HR></TD></TR>" & _
                        "<TR COLSPAN=7><TD WIDTH=3D640>#ProdCli#</TD></TR>" & "</TABLE>"


   IniHTML = TopMHTML & "<HTML>" & "<HEAD>" & "<STYLE>" & StyleMsoNormalTable & StyleMsoNormalTable2 & _
                        "</STYLE>" & "</HEAD><BODY><DIV>"

   HTMLTABLE = "<TABLE ALIGN =3DCENTER width=3D640 class=3DMsoNormalTable BORDER=3D1 CELLSPACING=3D0 CELLPADDING=3D0 >"

   PieMHTML = LeeMHTML(PathLogo & "Img\" & "Pie_Imagen.txt")
        
   I = 1
   Let iContador = 1
        
   Do While Bac_SQL_Fetch(Datos())
      If iContador = 1 Then
         iRegistros = Datos(30)
      End If
            
      'Cuando es el primer registro
      If Trim(cNombreCli) = "" Then
         
         NewEncabezado = Replace(Encabezado, "#cNomCli#", Datos(5))
         NewEncabezado = Replace(NewEncabezado, "#cDirCli#", Datos(19))
         HTML = IniHTML & NewEncabezado
      End If
      
      'Cuando cambia el cliente
      If cNombreCli <> Datos(5) And Trim(cNombreCli) <> "" Then
         NewEncabezado = Replace(Encabezado, "#cNomCli#", Datos(5))
         NewEncabezado = Replace(NewEncabezado, "#cDirCli#", Datos(19))
         Let HTML = HTML & "</TABLE>" '& SaltoPagina & NewEncabezado
         Let HTML = HTML & "</TABLE></DIV></BODY></HTML>" & PieMHTML
         
         If oTipoCartola = EJECUTIVO Then
            Call ImprimeDocumento(HTML, Dir1.Path, Datos(31) & " - " & cNombreCli & ".DOC")
         Else
            Call ImprimeDocumento(HTML, Dir1.Path, cNombreCli & ".DOC")
         End If
         
         
         
         Let HTML = IniHTML & NewEncabezado
      End If
            
      If Trim(cProdCli) = "" Then
         If Trim(Datos(2)) = "PCS" Then
            NewProdCli = Replace(TablaProdClienteSWAP, "#ProdCli#", Datos(17))
            HTML = HTML & "</TABLE><BR>" & NewProdCli & HTMLTABLE & IIf(FRM_CON_THRESHOLD.cmbreporte.ListIndex = 1, Replace(TitulosSWAP, "#TitColMtmSwap#", ""), Replace(TitulosSWAP, "#TitColMtmSwap#", "<TD width=3D100>Mark to Market<br>pesos</TD>"))
         Else
            NewProdCli = Replace(TablaProdCliente, "#ProdCli#", Datos(17))
            HTML = HTML & "</TABLE><BR>" & NewProdCli & HTMLTABLE & IIf(FRM_CON_THRESHOLD.cmbreporte.ListIndex = 1, Replace(Titulos, "#TitColMtm#", ""), Replace(Titulos, "#TitColMtm#", "<TD width=3D100>Mark to Market<br>pesos</TD>"))
         End If
      End If
            
      'Cuando la moneda
      If Trim(cProdCli) <> Datos(16) And Trim(cProdCli) <> "" Then
         If Trim(Datos(2)) = "PCS" Then
            NewProdCli = Replace(TablaProdClienteSWAP, "#ProdCli#", Datos(17))
            HTML = HTML & "</TABLE><BR>" & NewProdCli & HTMLTABLE & IIf(FRM_CON_THRESHOLD.cmbreporte.ListIndex = 1, Replace(TitulosSWAP, "#TitColMtmSwap#", ""), Replace(TitulosSWAP, "#TitColMtmSwap#", "<TD width=3D100>Mark to Market<br>pesos</TD>"))
         Else
            NewProdCli = Replace(TablaProdCliente, "#ProdCli#", Datos(17))
            HTML = HTML & "</TABLE><BR>" & NewProdCli & HTMLTABLE & IIf(FRM_CON_THRESHOLD.cmbreporte.ListIndex = 1, Replace(Titulos, "#TitColMtm#", ""), Replace(Titulos, "#TitColMtm#", "<TD width=3D100>Mark to Market<br>pesos</TD>"))
         End If
         I = 1
      End If

      If Trim(Datos(2)) = "BFW" Then
         HTML = HTML & "<TR>"
         HTML = HTML & "<TD align=3Dright width=3D50 " & StyleTD & ">" & I & "</TD>"
         HTML = HTML & "<TD align=3Dright width=3D50 " & StyleTD & ">" & Datos(6) & "</TD>"
         HTML = HTML & "<TD align=3Dcenter width=3D100 " & StyleTD & ">" & Datos(9) & "</TD>"
         HTML = HTML & "<TD align=3Dcenter width=3D100 " & StyleTD & ">" & Datos(10) & "</TD>"
         HTML = HTML & "<TD align=3Dright width=3D70 " & StyleTD & ">" & Datos(11) & "</TD>"
         HTML = HTML & "<TD align=3Dright width=3D70 " & StyleTD & ">" & Format(Datos(12), FDecimal) & "</TD>"
         HTML = HTML & "<TD align=3Dright width=3D70 " & StyleTD & ">" & Format(Datos(13), FDecimal) & "</TD>"
         HTML = HTML & "<TD align=3Dright width=3D70 " & StyleTD & ">" & Format(Datos(14), FDecimal) & "</TD>"
         HTML = HTML & "<TD align=3Dleft width=3D70 " & StyleTD & ">" & Datos(18) & "</TD>"
         HTML = HTML & IIf(FRM_CON_THRESHOLD.cmbreporte.ListIndex = 1, "", "<TD align=3Dright width=3D70 " & StyleTD & ">" & Format(Datos(15), FEntero) & "</TD>")
         HTML = HTML & "</TR>"
      Else
         HTML = HTML & "<TR>"
         HTML = HTML & "<TD align=3Dright width=3D50 " & StyleTD & ">" & I & "</TD>"
         HTML = HTML & "<TD align=3Dright width=3D50 " & StyleTD & ">" & Datos(24) & "</TD>"
         HTML = HTML & "<TD align=3Dcenter width=3D100 " & StyleTD & ">" & Datos(25) & "</TD>"
         HTML = HTML & "<TD align=3Dcenter width=3D100 " & StyleTD & ">" & Datos(26) & "</TD>"
         HTML = HTML & "<TD align=3Dright width=3D70 " & StyleTD & ">" & Datos(27) & "</TD>"
         HTML = HTML & "<TD align=3Dright width=3D70 " & StyleTD & ">" & Format(Datos(28), FEntero) & "</TD>"
         HTML = HTML & "<TD align=3Dright width=3D70 " & StyleTD & ">" & Format(Datos(29), FDecimal) & "</TD>"
         HTML = HTML & IIf(FRM_CON_THRESHOLD.cmbreporte.ListIndex = 1, "", "<TD align=3Dright width=3D70 " & StyleTD & "> " & Format(Datos(15), FEntero) & " </TD>")
         HTML = HTML & "</TR>"
      End If

      cProdCli = Datos(16)
      cNombreCli = Datos(5)
      I = I + 1

      SSprogress.FloodPercent = ((iContador * 100#) / iRegistros)
      iContador = iContador + 1
   Loop
        
   Let HTML = HTML & "</TABLE>"
   Let HTML = HTML & "</TABLE></DIV></BODY></HTML>" & PieMHTML
       
   Call ImprimeDocumento(HTML, Dir1.Path, cNombreCli & ".DOC")
   
   MsgBox "La documentación quedó almacenada en " & Dir1.Path, vbInformation, TITSISTEMA
   Unload Me

Exit Sub
BacErrorHandler:
   Resume
   BacLogFile "Error Interfaz Cartera Clientes  " & Err.Description$
   Call MsgBox("Error Interfaz Cartera Clientes  " & Err.Description$, vbExclamation, App.Title)
End Sub

Public Function LeeMHTML(NomArchivo As String)
        Dim HFile%
        Dim tmpPieMHTML As String
        Dim PieMHTML As String
        Let COdImage = ""
        
        HFile% = FreeFile
       
        Open NomArchivo For Input As #HFile%
        PieMHTML = ""
        
        Do While Not EOF(HFile)

            Line Input #HFile, tmpPieMHTML
            PieMHTML = PieMHTML & tmpPieMHTML & vbCrLf
        Loop
        
        LeeMHTML = PieMHTML
        
        Close #HFile%

End Function



Public Sub ImprimeDocumento(DocumentoHtml As String, PathArchivo As String, NomArchivo As String)
        
        Dim cArchivo  As String
        Dim HFile%
        
        NomArchivo = Replace(NomArchivo, "/", "-")
        
        
        cArchivo = PathArchivo & "\" & NomArchivo
        
        HFile% = FreeFile
   
        Open cArchivo For Append Access Write Shared As #HFile%
        
        Write #HFile%, DocumentoHtml & sLogEvent$
        
        Close #HFile%
   
End Sub

Public Function ShellEx( _
        ByVal sFile As String, _
        Optional ByVal eShowCmd As EShellShowConstants = essSW_SHOWDEFAULT, _
        Optional ByVal sParameters As String = "", _
        Optional ByVal sDefaultDir As String = "", _
        Optional sOperation As String = "open", _
        Optional Owner As Long = 0 _
    ) As Boolean
Dim lR As Long
Dim lErr As Long, sErr As Long
    If (InStr(UCase$(sFile), ".EXE") <> 0) Then
        eShowCmd = 0
    End If
    On Error Resume Next
    If (sParameters = "") And (sDefaultDir = "") Then
        lR = ShellExecuteForExplore(Owner, sOperation, sFile, 0, 0, essSW_SHOWNORMAL)
    Else
        lR = ShellExecute(Owner, sOperation, sFile, sParameters, sDefaultDir, eShowCmd)
    End If
    If (lR < 0) Or (lR > 32) Then
        ShellEx = True
    Else
        ' raise an appropriate error:
        lErr = vbObjectError + 1048 + lR
        Select Case lR
        Case 0
            lErr = 7: sErr = "Out of memory"
        Case ERROR_FILE_NOT_FOUND
            lErr = 53: sErr = "File not found"
        Case ERROR_PATH_NOT_FOUND
            lErr = 76: sErr = "Path not found"
        Case ERROR_BAD_FORMAT
            sErr = "The executable file is invalid or corrupt"
        Case SE_ERR_ACCESSDENIED
            lErr = 75: sErr = "Path/file access error"
        Case SE_ERR_ASSOCINCOMPLETE
            sErr = "This file type does not have a valid file association."
        Case SE_ERR_DDEBUSY
            lErr = 285: sErr = "The file could not be opened because the target application is busy. Please try again in a moment."
        Case SE_ERR_DDEFAIL
            lErr = 285: sErr = "The file could not be opened because the DDE transaction failed. Please try again in a moment."
        Case SE_ERR_DDETIMEOUT
            lErr = 286: sErr = "The file could not be opened due to time out. Please try again in a moment."
        Case SE_ERR_DLLNOTFOUND
            lErr = 48: sErr = "The specified dynamic-link library was not found."
        Case SE_ERR_FNF
            lErr = 53: sErr = "File not found"
        Case SE_ERR_NOASSOC
            sErr = "No application is associated with this file type."
        Case SE_ERR_OOM
            lErr = 7: sErr = "Out of memory"
        Case SE_ERR_PNF
            lErr = 76: sErr = "Path not found"
        Case SE_ERR_SHARE
            lErr = 75: sErr = "A sharing violation occurred."
        Case Else
            sErr = "An error occurred occurred whilst trying to open or print the selected file."
        End Select
                
        Err.Raise lErr, , App.EXEName & ".GShell", sErr
        ShellEx = False
    End If

End Function



