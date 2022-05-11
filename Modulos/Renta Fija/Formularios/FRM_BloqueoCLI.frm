VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.2#0"; "mscomctl.ocx"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "comdlg32.ocx"
Begin VB.Form FRM_BloqueoCLI 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Bloqueo de Clientes"
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
   Begin VB.CommandButton Command1 
      Caption         =   "Captura de Archivo"
      Height          =   615
      Left            =   1920
      TabIndex        =   1
      Top             =   1080
      Width           =   1935
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   0
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
            Key             =   "Generar"
            Object.ToolTipText     =   "Generar Interfaz"
            ImageIndex      =   22
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Cargar"
            Object.ToolTipText     =   "Cargar Cliente"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   48
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.ImageList ImageList2 
      Left            =   5040
      Top             =   600
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
            Picture         =   "FRM_BloqueoCLI.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_BloqueoCLI.frx":0EDA
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_BloqueoCLI.frx":1DB4
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_BloqueoCLI.frx":2C8E
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_BloqueoCLI.frx":3B68
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_BloqueoCLI.frx":4A42
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_BloqueoCLI.frx":591C
            Key             =   ""
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_BloqueoCLI.frx":67F6
            Key             =   ""
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_BloqueoCLI.frx":76D0
            Key             =   ""
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_BloqueoCLI.frx":85AA
            Key             =   ""
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_BloqueoCLI.frx":9484
            Key             =   ""
         EndProperty
         BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_BloqueoCLI.frx":979E
            Key             =   ""
         EndProperty
         BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_BloqueoCLI.frx":A678
            Key             =   ""
         EndProperty
         BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_BloqueoCLI.frx":B552
            Key             =   ""
         EndProperty
         BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_BloqueoCLI.frx":C42C
            Key             =   ""
         EndProperty
         BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_BloqueoCLI.frx":D306
            Key             =   ""
         EndProperty
         BeginProperty ListImage17 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_BloqueoCLI.frx":E1E0
            Key             =   ""
         EndProperty
         BeginProperty ListImage18 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_BloqueoCLI.frx":F0BA
            Key             =   ""
         EndProperty
         BeginProperty ListImage19 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_BloqueoCLI.frx":FF94
            Key             =   ""
         EndProperty
         BeginProperty ListImage20 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_BloqueoCLI.frx":103E6
            Key             =   ""
         EndProperty
         BeginProperty ListImage21 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_BloqueoCLI.frx":10838
            Key             =   ""
         EndProperty
         BeginProperty ListImage22 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_BloqueoCLI.frx":10C8A
            Key             =   ""
         EndProperty
         BeginProperty ListImage23 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_BloqueoCLI.frx":11B64
            Key             =   ""
         EndProperty
         BeginProperty ListImage24 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_BloqueoCLI.frx":12A3E
            Key             =   ""
         EndProperty
         BeginProperty ListImage25 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_BloqueoCLI.frx":12E90
            Key             =   ""
         EndProperty
         BeginProperty ListImage26 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_BloqueoCLI.frx":132E2
            Key             =   ""
         EndProperty
         BeginProperty ListImage27 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_BloqueoCLI.frx":13734
            Key             =   ""
         EndProperty
         BeginProperty ListImage28 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_BloqueoCLI.frx":13B86
            Key             =   ""
         EndProperty
         BeginProperty ListImage29 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_BloqueoCLI.frx":14A60
            Key             =   ""
         EndProperty
         BeginProperty ListImage30 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_BloqueoCLI.frx":1593A
            Key             =   ""
         EndProperty
         BeginProperty ListImage31 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_BloqueoCLI.frx":16814
            Key             =   ""
         EndProperty
         BeginProperty ListImage32 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_BloqueoCLI.frx":176EE
            Key             =   ""
         EndProperty
         BeginProperty ListImage33 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_BloqueoCLI.frx":17A08
            Key             =   ""
         EndProperty
         BeginProperty ListImage34 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_BloqueoCLI.frx":188E2
            Key             =   ""
         EndProperty
         BeginProperty ListImage35 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_BloqueoCLI.frx":197BC
            Key             =   ""
         EndProperty
         BeginProperty ListImage36 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_BloqueoCLI.frx":1A696
            Key             =   ""
         EndProperty
         BeginProperty ListImage37 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_BloqueoCLI.frx":1B570
            Key             =   ""
         EndProperty
         BeginProperty ListImage38 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_BloqueoCLI.frx":1C44A
            Key             =   ""
         EndProperty
         BeginProperty ListImage39 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_BloqueoCLI.frx":1D324
            Key             =   ""
         EndProperty
         BeginProperty ListImage40 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_BloqueoCLI.frx":1E1FE
            Key             =   ""
         EndProperty
         BeginProperty ListImage41 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_BloqueoCLI.frx":1F0D8
            Key             =   ""
         EndProperty
         BeginProperty ListImage42 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_BloqueoCLI.frx":1FFB2
            Key             =   ""
         EndProperty
         BeginProperty ListImage43 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_BloqueoCLI.frx":20E8C
            Key             =   ""
         EndProperty
         BeginProperty ListImage44 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_BloqueoCLI.frx":21D66
            Key             =   ""
         EndProperty
         BeginProperty ListImage45 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_BloqueoCLI.frx":22C40
            Key             =   ""
         EndProperty
         BeginProperty ListImage46 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_BloqueoCLI.frx":23B1A
            Key             =   ""
         EndProperty
         BeginProperty ListImage47 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_BloqueoCLI.frx":249F4
            Key             =   ""
         EndProperty
         BeginProperty ListImage48 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_BloqueoCLI.frx":258CE
            Key             =   ""
         EndProperty
         BeginProperty ListImage49 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_BloqueoCLI.frx":25BE8
            Key             =   ""
         EndProperty
         BeginProperty ListImage50 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_BloqueoCLI.frx":26AC2
            Key             =   ""
         EndProperty
         BeginProperty ListImage51 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_BloqueoCLI.frx":2799C
            Key             =   ""
         EndProperty
         BeginProperty ListImage52 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_BloqueoCLI.frx":27CB6
            Key             =   ""
         EndProperty
         BeginProperty ListImage53 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_BloqueoCLI.frx":28B90
            Key             =   ""
         EndProperty
         BeginProperty ListImage54 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_BloqueoCLI.frx":29A6A
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComDlg.CommonDialog CommonDialog1 
      Left            =   5880
      Top             =   600
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
End
Attribute VB_Name = "FRM_BloqueoCLI"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub Command1_Click()

Dim xlApp As EXCEL.Application
Dim xlLibro As EXCEL.Workbook
Dim xlHoja As EXCEL.Worksheet
Dim varMatriz As Variant
Dim lngUltimaFila As Long
Dim i As Integer
Dim nomSp As String
Dim Datos()
Dim nro_bloqueos As Boolean
On Error GoTo ErrorBloqueo

nro_bloqueos = False


    CommonDialog1.CancelError = True
    CommonDialog1.DialogTitle = "Archivos de Rut de Clientes"
    CommonDialog1.Filter = "*.xlsx" '"excels" & "|" & "xlsx" & "|"
    CommonDialog1.FileName = "BLOQUEOS_CLI"
    
    Me.CommonDialog1.ShowOpen

Screen.MousePointer = vbHourglass

'abrir programa Excel
Set xlApp = New EXCEL.Application
'xl.Visible = True

'abrir el archivo Excel
'(archivo en la misma carpeta)
Set xlLibro = xlApp.Workbooks.Open(CommonDialog1.FileName, True, True, , "")
Set xlHoja = xlApp.Worksheets(1)


'2. Si no conoces el rango
lngUltimaFila = xlApp.Columns("A:A").Range("A65536").End(xlUp).Row

varMatriz = xlHoja.Range(xlHoja.Cells(1, 1), xlHoja.Cells(lngUltimaFila, 10))

'utilizamos los datos…
'txtLlamadas.text = varMatriz(10, 3)

For i = 1 To lngUltimaFila
    If varMatriz(i, 1) > 0 Then
        Envia = Array()
        AddParam Envia, Mid(varMatriz(i, 1), 1, InStr(varMatriz(i, 1), "-") - 1)
        AddParam Envia, 1
        AddParam Envia, IIf(varMatriz(i, 2) = "SI", "S", "N")
        nomSp = "SP_UPD_BLOQUEO_CLI"
        If Not Bac_Sql_Execute(nomSp, Envia) Then
            MsgBox "Problemas en el BLOQUEO DEL CLIENTE " + varMatriz(i, 1), vbExclamation, TITSISTEMA
        Else
            nro_bloqueos = True
        End If
    ElseIf i > 1 And varMatriz(i, 1) = "" Then
        Exit For
    End If
Next


'cerramos el archivo Excel
xlLibro.Close 'SaveChanges:=False
xlApp.Quit

If nro_bloqueos Then
   MsgBox "PROCESO TERMINADO, CLIENTES BLOQUEADOS Y DESBLOQUEADOS ", vbInformation, TITSISTEMA
Else
   MsgBox "PROCESO TERMINADO, SIN CLIENTES PROCESADOS ", vbInformation, TITSISTEMA
End If


Screen.MousePointer = vbDefault

ErrorBloqueo:

'reset variables de los objetos
Set xlHoja = Nothing
Set xlLibro = Nothing
Set xlApp = Nothing
Screen.MousePointer = vbDefault

End Sub

Private Sub Form_Load()
Me.Top = 0
Me.Left = 0
'´ 'Ruta.Path = "C:\"
Dim xD As String

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Index
    Case 1
        Call generar_interfaz_cliente
    Case 2
        Call Command1_Click
    Case 3
        Unload Me
End Select

End Sub
Private Sub Limpiar()
    Ruta.Path = "C:\"
End Sub


Sub generar_interfaz_cliente()

Dim oExcel As Object
Dim oBook As Object
Dim oSheet As Object
Dim Tabla() As Variant

Dim SqlDatos()

Dim NombreArch As String
Dim PathArch As String

On Error GoTo ErrorGenInterCli

Set oExcel = CreateObject("Excel.Application")
Set oBook = oExcel.Workbooks.Add
Set oSheet = oBook.Worksheets(1)

Screen.MousePointer = vbHourglass

    CommonDialog1.CancelError = True
    CommonDialog1.DialogTitle = "Archivos de Rut de Clientes"
    CommonDialog1.Filter = "*.xlsx" '"excels" & "|" & "xlsx" & "|"
    CommonDialog1.FileName = "INFO_CLI.xlsx"
    
    Me.CommonDialog1.ShowSave

'Envia = Array()
'AddParam Envia, 380 ' Interfaz Cliente para el Bloqueo
'If Not Bac_Sql_Execute("sp_BacInterfaces_Archivo", Envia) Then
'        Exit Sub
'End If
'If Bac_SQL_Fetch(SqlDatos()) Then
'    Let NombreArch = SqlDatos(4) + SqlDatos(2) + Format(gsBac_Fecp, "yyyymmdd") + ".xlsx"
'Else
'    Let NombreArch = "C:\Temp\INFOCLI_" + Format(gsBac_Fecp, "yyyymmdd") + ".xlsx"
'End If
'
'
'If Len(Dir(NombreArch)) > 0 Then
'        Call Kill(NombreArch)
'End If

'Create a Recordset from all the records in the Orders table

    Dim objConn As New ADODB.Connection
    Dim objCmd As New ADODB.Command
    Dim objRs As New ADODB.Recordset
  
    objCmd.CommandText = "EXEC SP_LISTA_CLIENTES "
    objCmd.CommandType = adCmdText 'adCmdText 'adCmdStoredProc SP 'adCmdTable Table
    
    objCmd.Parameters.Append objCmd.CreateParameter("@FECHA", adDBTimeStamp, adParamInput, , gsBac_Fecp)
    
    Set objConn = GetNewConnection
    objCmd.ActiveConnection = objConn
  
    ' Execute once and display...
    
    'Ejecuta el procedimiento
    On Error Resume Next
        Set objRs = objCmd.Execute
    On Error GoTo ErrorGenInterCli
   
    
'Create a new workbook in Excel

    'Transfer the data to Excel
    oSheet.Range("A1:J1").Value = Array("Rut_Cliente", "DV_Cliente", "Codigo_Cliente", "Nombre_Contraparte", "Habilitado_Operar", "Origen", "Producto", "Folio_Operacion", "Fecha_Operacion", "usuario")

    oSheet.Range("A2").CopyFromRecordset objRs

    'Save the Workbook and Quit Excel
    
    oBook.SaveAs CommonDialog1.FileName
    oExcel.Quit
    
    Screen.MousePointer = vbDefault
    
    Set oSheet = Nothing
    Set oBook = Nothing
    Set oExcel = Nothing
   
    'clean up
    objRs.Close
    objConn.Close
    Set objRs = Nothing
    Set objConn = Nothing
    Set objCmd = Nothing
    
    
    Exit Sub
  

ErrorGenInterCli:
    
    MsgBox err.Source & "-->" & err.Description, , "Error"

    'clean up
    If objRs.State = adStateOpen Then
        objRs.Close
    End If
  
    If objConn.State = adStateOpen Then
        objConn.Close
    End If
  
    Set objRs = Nothing
    Set objConn = Nothing
    Set objCmd = Nothing
  
'    Call BacParcelaInterfaz.FuncSendMail(iSistema, "ERROR INTERFAZ CLIENTE " & vbCrLf & vbCrLf & err.Source & "-->" & err.Description, "INTERFAZ BLOQUEO DE CLIENTES")
    
    Screen.MousePointer = vbDefault
  
    If err <> 0 Then
        MsgBox err.Source & "-->" & err.Description, , "Error"
    End If

End Sub

