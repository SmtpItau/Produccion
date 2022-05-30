VERSION 5.00
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "comdlg32.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.2#0"; "mscomctl.ocx"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BAC_INFORME_COLATERAL 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Genera Informe de Colateral"
   ClientHeight    =   1470
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   4530
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   1470
   ScaleWidth      =   4530
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   4530
      _ExtentX        =   7990
      _ExtentY        =   794
      ButtonWidth     =   1958
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      Style           =   1
      TextAlignment   =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Generar"
            Key             =   "Generar"
            Object.ToolTipText     =   "Genera una vista previa del informe."
            ImageIndex      =   4
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Caption         =   "Imprimir "
            Key             =   "IMPRIMIR"
            Object.ToolTipText     =   "Envía directamente el informe a la impresora."
            ImageIndex      =   2
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Cerrar "
            Key             =   "CERRAR"
            Object.ToolTipText     =   "Cerrar ventana."
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   4560
         Top             =   0
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   22
         ImageHeight     =   22
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   4
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BAC_INFORME_COLATERAL.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BAC_INFORME_COLATERAL.frx":0EDA
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BAC_INFORME_COLATERAL.frx":1DB4
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BAC_INFORME_COLATERAL.frx":20CE
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame Frame1 
      Height          =   1035
      Left            =   45
      TabIndex        =   1
      Top             =   375
      Width           =   4470
      Begin BACControles.TXTFecha txtFecha 
         Height          =   285
         Left            =   1395
         TabIndex        =   3
         Top             =   225
         Width           =   1515
         _ExtentX        =   2672
         _ExtentY        =   503
         Enabled         =   -1  'True
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "14/08/2006"
      End
      Begin VB.Label lblFecha 
         Alignment       =   2  'Center
         Caption         =   "Miercoles, 21 de Septiembre del 2006"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H000000FF&
         Height          =   285
         Left            =   45
         TabIndex        =   4
         Top             =   630
         Width           =   4155
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Fecha"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Left            =   480
         TabIndex        =   2
         Top             =   255
         Width           =   495
      End
   End
   Begin MSComDlg.CommonDialog CommonDialog1 
      Left            =   4560
      Top             =   600
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
End
Attribute VB_Name = "BAC_INFORME_COLATERAL"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Form_Load()
   Me.Top = 0
   Me.Left = 0
   Me.Icon = BACSwap.Icon
   txtFecha.text = gsBAC_Fecp
   Me.txtFecha.Enabled = False
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case UCase(Button.Key)
      Case Is = "GENERAR"
         Call GeneraInformeColateral(txtFecha.text)
      Case Is = "IMPRIMIR"
         Call GeneraInformeCartera(crptToPrinter, txtFecha.text)
      Case Is = "CERRAR"
         Unload Me
   End Select
End Sub

Private Sub txtFecha_Change()
   lblFecha.Caption = Format(txtFecha.text, "dddd, dd") & " de "
   lblFecha.Caption = lblFecha.Caption & Format(txtFecha.text, "mmmm") & " del "
   lblFecha.Caption = lblFecha.Caption & Format(txtFecha.text, "yyyy")
   
   Toolbar1.Buttons(2).Enabled = True
   Toolbar1.Buttons(3).Enabled = True
   If BacEsHabil(Me.txtFecha.text) = True Then
      lblFecha.ForeColor = &H8000000D
   Else
      Toolbar1.Buttons(2).Enabled = False
      Toolbar1.Buttons(3).Enabled = False
      lblFecha.ForeColor = &HFF&
   End If
End Sub

Private Sub GeneraInformeCartera(iDestino As DestinationConstants, FechaInforme As String)
   On Error GoTo ErrorImpresionCartera
   
   Me.MousePointer = vbHourglass
   
   Call BacLimpiaParamCrw
   BACSwap.Crystal.Destination = iDestino
   BACSwap.Crystal.ReportFileName = gsRPT_Path & "Informe_Cartera_Swap.rpt"
                      '--> Store Procedure : dbo.SP_INFORME_CARTERA_PRODUCTO.sql
   BACSwap.Crystal.WindowTitle = "Informe de Cartera Swap."
   BACSwap.Crystal.StoredProcParam(0) = Format(FechaInforme, "yyyy-mm-dd 00:00:00.000")
   BACSwap.Crystal.StoredProcParam(1) = Mid(Trim(gsBAC_User), 1, 15)
   BACSwap.Crystal.Connect = swConeccion
   BACSwap.Crystal.Action = 1
   
'--- Homologado el 08-09-2008 ---
   Call BacLimpiaParamCrw
   BACSwap.Crystal.Destination = iDestino
   BACSwap.Crystal.ReportFileName = gsRPT_Path & "Cartera_Cuenta_rpt.rpt"
                      '--> Store Procedure : dbo.Sp_Cartera_Cuenta.sql
   BACSwap.Crystal.WindowTitle = "Informe Cartera Cuenta Swap."
   BACSwap.Crystal.StoredProcParam(0) = Format(FechaInforme, "yyyy-mm-dd 00:00:00.000")
   BACSwap.Crystal.StoredProcParam(1) = Mid(Trim(gsBAC_User), 1, 15)
   BACSwap.Crystal.Connect = swConeccion
   BACSwap.Crystal.Action = 1
'--- Homologado el 08-09-2008 ---
   
   Me.MousePointer = vbDefault
   On Error GoTo 0
Exit Sub
ErrorImpresionCartera:
   Me.MousePointer = vbDefault
   MsgBox "Acción Abortada." & vbCrLf & vbCrLf & "Error al imprimir Error : " & vbCrLf & BACSwap.Crystal.LastErrorString, vbExclamation, TITSISTEMA
   On Error GoTo 0
End Sub

Private Sub GeneraInformeColateral(FechaInforme As String)
Dim oExcel As Object
Dim oBook As Object
Dim oSheet As Object
Dim Tabla() As Variant

Dim SqlDatos()

Dim NombreArch As String
Dim PathArch As String

On Error GoTo ErrorGenInterColateral

Set oExcel = CreateObject("Excel.Application")
Set oBook = oExcel.Workbooks.Add
Set oSheet = oBook.Worksheets.Add

    Screen.MousePointer = vbHourglass

    CommonDialog1.CancelError = True
    CommonDialog1.DialogTitle = "Archivos de Rut de Clientes"
    CommonDialog1.Filter = "*.xlsx" '"excels" & "|" & "xlsx" & "|"
    CommonDialog1.FileName = "INFO_COLATERAL.xlsx"
    
    Me.CommonDialog1.ShowSave


'Create a Recordset from all the records in the Orders table

    Dim objConn As New ADODB.Connection
    Dim objCmd As New ADODB.Command
    Dim objRs As New ADODB.Recordset
    
    Set objConn = GetNewConnection
    objCmd.ActiveConnection = objConn
  
    objCmd.CommandText = "EXEC SP_INFO_COLATERAL_SWAP "
    objCmd.CommandType = adCmdText 'adCmdText 'adCmdStoredProc SP 'adCmdTable Table
    objCmd.Parameters.Append objCmd.CreateParameter("@FECHA", adDBTimeStamp, adParamInput, , gsBAC_Fecp)
  
    ' Execute once and display...
    
    'Ejecuta el procedimiento
    On Error Resume Next
        Set objRs = objCmd.Execute
    On Error GoTo ErrorGenInterColateral
   
    
'Create a new workbook in Excel
    'Transfer the data to Excel
    Set oSheet = oBook.Worksheets(1) '--> MiExcell.ActiveSheet
    oSheet.Name = "Swap"
    oSheet.Range("A1:L1").Value = Array("numero_operacion", "numero_flujo", "tipo_swap", "Producto", "rut_cliente", "codigo_cliente", "nombre", "colateral_cli", "Tipo_Flujo", "fecha_inicio_flujo", "fecha_vence_flujo", "colateral_ope")
    oSheet.Range("A2").CopyFromRecordset objRs


    objCmd.CommandText = "EXEC SP_INFO_COLATERAL_FWD "
    objCmd.CommandType = adCmdText 'adCmdText 'adCmdStoredProc SP 'adCmdTable Table
    objCmd.Parameters.Append objCmd.CreateParameter("@FECHA", adDBTimeStamp, adParamInput, , gsBAC_Fecp)

  
    ' Execute once and display...
    'Ejecuta el procedimiento
    On Error Resume Next
        Set objRs = objCmd.Execute
    On Error GoTo ErrorGenInterColateral

    
    Set oSheet = oBook.Worksheets(2) '--> MiExcell.ActiveSheet
    oSheet.Name = "Forward"
    oSheet.Range("A1:K1").Value = Array("NumeroOperacion", "CodigoPosicion", "producto", "rut", "cod", "nombre", "colateral_cli", "TipoOperacion", "FechaOperacion", "FechaVencimiento", "colateral_ope")
    oSheet.Range("A2").CopyFromRecordset objRs
    
    'Save the Workbook and Quit Excel
    oBook.SaveAs CommonDialog1.FileName
    oExcel.Quit
    
    MsgBox "Fin Generacion Archivo", vbInformation, TITSISTEMA
    
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
  

ErrorGenInterColateral:
    
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
        MsgBox err.Source & "-->" & err.Description, vbExclamation, TITSISTEMA
    End If


End Sub
