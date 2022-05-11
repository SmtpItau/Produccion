VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "comdlg32.ocx"
Begin VB.Form FRM_MNT_DCV_NOTIFICACION 
   Caption         =   "Archivo de Notificación de Procesamiento."
   ClientHeight    =   9480
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   14490
   BeginProperty Font 
      Name            =   "Tahoma"
      Size            =   8.25
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   LinkTopic       =   "Form2"
   LockControls    =   -1  'True
   MDIChild        =   -1  'True
   ScaleHeight     =   9480
   ScaleWidth      =   14490
   Begin VB.Frame FRA_RegDetails 
      Caption         =   "Gegistro Tipo 2 - Registro de Operación"
      Height          =   1560
      Left            =   45
      TabIndex        =   4
      Top             =   7905
      Width           =   14430
      Begin MSFlexGridLib.MSFlexGrid GridDetail 
         Height          =   1305
         Left            =   45
         TabIndex        =   5
         Top             =   210
         Width           =   14280
         _ExtentX        =   25188
         _ExtentY        =   2302
         _Version        =   393216
         Cols            =   4
         FixedCols       =   0
         BackColor       =   -2147483633
         BackColorFixed  =   -2147483646
         ForeColorFixed  =   -2147483639
         BackColorBkg    =   -2147483636
         FocusRect       =   0
         GridLines       =   2
         GridLinesFixed  =   0
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   14490
      _ExtentX        =   25559
      _ExtentY        =   794
      ButtonWidth     =   2064
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
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
            Caption         =   "Open File"
            ImageIndex      =   5
            Style           =   5
            BeginProperty ButtonMenus {66833FEC-8583-11D1-B16A-00C0F0283628} 
               NumButtonMenus  =   5
               BeginProperty ButtonMenu1 {66833FEE-8583-11D1-B16A-00C0F0283628} 
                  Text            =   "Arch. Notificacion"
               EndProperty
               BeginProperty ButtonMenu2 {66833FEE-8583-11D1-B16A-00C0F0283628} 
                  Text            =   "Inf.- Diario (Contratos Vigentes)"
               EndProperty
               BeginProperty ButtonMenu3 {66833FEE-8583-11D1-B16A-00C0F0283628} 
                  Text            =   "Valorización"
               EndProperty
               BeginProperty ButtonMenu4 {66833FEE-8583-11D1-B16A-00C0F0283628} 
                  Text            =   "Inf. Vencimientos"
               EndProperty
               BeginProperty ButtonMenu5 {66833FEE-8583-11D1-B16A-00C0F0283628} 
                  Text            =   "Generación Solicitud"
               EndProperty
            EndProperty
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Cerrar"
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComDlg.CommonDialog Common 
         Left            =   5400
         Top             =   -15
         _ExtentX        =   847
         _ExtentY        =   847
         _Version        =   393216
      End
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   7980
         Top             =   0
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   22
         ImageHeight     =   22
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   5
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_DCV_NOTIFICACION.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_DCV_NOTIFICACION.frx":0EDA
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_DCV_NOTIFICACION.frx":11F4
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_DCV_NOTIFICACION.frx":20CE
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_DCV_NOTIFICACION.frx":2FA8
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame FRA_RegHeader 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1455
      Left            =   30
      TabIndex        =   1
      Top             =   375
      Width           =   14400
      Begin MSFlexGridLib.MSFlexGrid GrillaHead 
         Height          =   1290
         Left            =   45
         TabIndex        =   6
         Top             =   135
         Width           =   14310
         _ExtentX        =   25241
         _ExtentY        =   2275
         _Version        =   393216
         Cols            =   4
         FixedCols       =   0
         BackColor       =   -2147483633
         BackColorFixed  =   -2147483646
         ForeColorFixed  =   -2147483639
         BackColorBkg    =   -2147483636
         FocusRect       =   0
         GridLines       =   2
         GridLinesFixed  =   0
      End
   End
   Begin VB.Frame FRA_RegBody 
      Height          =   6150
      Left            =   30
      TabIndex        =   2
      Top             =   1755
      Width           =   14400
      Begin MSFlexGridLib.MSFlexGrid GrillaBody 
         Height          =   5970
         Left            =   45
         TabIndex        =   3
         Top             =   135
         Width           =   14310
         _ExtentX        =   25241
         _ExtentY        =   10530
         _Version        =   393216
         Cols            =   4
         FixedCols       =   0
         BackColor       =   -2147483633
         BackColorFixed  =   -2147483646
         ForeColorFixed  =   -2147483639
         BackColorBkg    =   -2147483636
         FocusRect       =   0
         GridLines       =   2
         GridLinesFixed  =   0
      End
   End
End
Attribute VB_Name = "FRM_MNT_DCV_NOTIFICACION"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Const Grd_FixRow = 0
Private Const Grd_TipReg = 0
Private Const Grd_DatCon = 1
Private Const Grd_CodMen = 2
Private Const Grd_DesMen = 3

Private Const ForReading = 1
Private Const ForWriting = 2
Private Const ForAppending = 3

Enum xDescripRegister
           [Header] = 1
      [Operaciones] = 2
   [Modificaciones] = 3
      [Anulaciones] = 4
          [Control] = 9
End Enum

Dim oFileOpenActive  As CodFileImput


Private Function FuncSettingGrigHead()
   Let GrillaHead.Rows = 2:      Let GrillaHead.Cols = 9
   Let GrillaHead.FixedRows = 1: Let GrillaHead.FixedCols = 0
   
   Let GrillaHead.AllowUserResizing = flexResizeColumns
   
   Let GrillaHead.TextMatrix(0, 0) = "Tipo":             Let GrillaHead.ColWidth(0) = 850
   Let GrillaHead.TextMatrix(0, 1) = "Fecha":            Let GrillaHead.ColWidth(1) = 850
   Let GrillaHead.TextMatrix(0, 2) = "Hora":             Let GrillaHead.ColWidth(2) = 850
   Let GrillaHead.TextMatrix(0, 3) = "Descripción":      Let GrillaHead.ColWidth(3) = 4500
   Let GrillaHead.TextMatrix(0, 4) = "Nombre L.":        Let GrillaHead.ColWidth(4) = 2500
   Let GrillaHead.TextMatrix(0, 5) = "Rut    O.":        Let GrillaHead.ColWidth(5) = 1500
   Let GrillaHead.TextMatrix(0, 6) = "Código O.":        Let GrillaHead.ColWidth(6) = 1200
   Let GrillaHead.TextMatrix(0, 7) = "Rut    D.":        Let GrillaHead.ColWidth(7) = 1500
   Let GrillaHead.TextMatrix(0, 8) = "Código D.":        Let GrillaHead.ColWidth(8) = 1200
   
End Function

Private Function FuncSettingGrid()
   Let Grilla.Rows = 2:        Let Grilla.Cols = 4
   Let Grilla.FixedRows = 1:   Let Grilla.FixedCols = 0

   Let Grilla.TextMatrix(Grd_FixRow, Grd_TipReg) = "Id Reg.":              Let Grilla.ColWidth(Grd_TipReg) = 750:    Let Grilla.ColAlignment(Grd_TipReg) = flexAlignRightCenter
   Let Grilla.TextMatrix(Grd_FixRow, Grd_DatCon) = "Datos Contrato":       Let Grilla.ColWidth(Grd_DatCon) = 7000:   Let Grilla.ColAlignment(Grd_DatCon) = flexAlignLeftCenter
   Let Grilla.TextMatrix(Grd_FixRow, Grd_CodMen) = "Cod. Msg":             Let Grilla.ColWidth(Grd_CodMen) = 1500:   Let Grilla.ColAlignment(Grd_CodMen) = flexAlignRightCenter
   Let Grilla.TextMatrix(Grd_FixRow, Grd_DesMen) = "Descripción Mensaje":  Let Grilla.ColWidth(Grd_DesMen) = 4000:   Let Grilla.ColAlignment(Grd_DesMen) = flexAlignLeftCenter
   Let Grilla.AllowUserResizing = flexResizeColumns
End Function

Private Sub Form_Load()
   Let Me.Top = 0: Let Me.Left = 0
   Let Me.Icon = BACSwapParametros.Icon
   
   Let GrillaHead.Rows = 1:            Let GrillaBody.Rows = 1:         Let GridDetail.Rows = 1
   Let GrillaHead.Enabled = False:     Let GrillaBody.Enabled = False:  Let GridDetail.Enabled = False

   Call FuncSettingGrigHead
End Sub

Private Sub GrillaBody_RowColChange()
   Call GrillaBody_Click
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 4:     Call Unload(Me)
   End Select
End Sub

Private Sub Toolbar1_ButtonMenuClick(ByVal ButtonMenu As MSComctlLib.ButtonMenu)

   Let FRA_RegHeader.Enabled = False:  Let GrillaHead.Rows = 1:   Let GrillaHead.Rows = 2
   Let FRA_RegBody.Enabled = False:    Let GrillaBody.Rows = 1
   Let FRA_RegDetails.Enabled = False: Let GridDetail.Rows = 1

   Select Case ButtonMenu.Index
      Case 1: Call FuncOpenFile([01 Archivo de Notificaciones])
      Case 2: Call FuncOpenFile([02_Archivo Diario de Generaciones])
      Case 3: Call FuncOpenFile([03_Valorizacion de Contratos])
      Case 4: Call FuncOpenFile([04_Informe de Vencimientos])
      Case 5: Call FuncOpenFile([05_Informe_Generacion_Solicitud])
   End Select
End Sub

Private Function FuncSettingBodyGrid(ByVal iOption As CodFileImput)
   If iOption = [01 Archivo de Notificaciones] Then
      Let GrillaBody.Rows = 1:  Let GrillaBody.Cols = 4:      Let GridDetail.Cols = 17
   End If
   If iOption = [02_Archivo Diario de Generaciones] Then
      Let GrillaBody.Rows = 1:  Let GrillaBody.Cols = 4:      Let GridDetail.Cols = 17
   End If
   If iOption = [03_Valorizacion de Contratos] Then
      Let GrillaBody.Rows = 1:  Let GrillaBody.Cols = 6:      Let GridDetail.Cols = 21
   End If
   If iOption = [04_Informe de Vencimientos] Then
      Let GrillaBody.Rows = 1:  Let GrillaBody.Cols = 6:      Let GridDetail.Cols = 38
   End If
   If iOption = [05_Informe_Generacion_Solicitud] Then
      Let GrillaBody.Rows = 1:  Let GrillaBody.Cols = 5:      Let GridDetail.Cols = 38
   End If
End Function


Private Function FuncOpenFile(ByVal iFileOpen As CodFileImput)
   On Error GoTo ErrOpenFile
   Dim ClaseInterfaz          As New clsInterfazDCV
   Dim xRegistro              As Variant
   Dim oFileType              As Variant
   Dim nContador              As Long
   
   '-> Metodologia de Apertura de Archivos por FileSystemObjects
   Dim ObjLoadFile             As Variant
   Dim ObjLoadOpenTextFile     As Object

   '->  Determina la cantidad de columnas a contener las grillas --------------
   Call FuncSettingBodyGrid(iFileOpen)
   '->  -----------------------------------------------------------------------

   '-> Abre la Pantalla de Selección de Windows 'Open File' -------------------
Retry:
   '->  Cierre todos los archivos de disco abiertos.
   Call Reset
   '->  Setting de tipo de archivo a Leer
    Let Common.CancelError = True
    Let Common.Filter = "Archivos Planos (*.TXT)|*.TXT|Archivos Planos (*.DAT)|*.DAT"
    Let Common.InitDir = ClaseInterfaz.FuncLoadPathArchivos

   '->  Abre la pantalla se seleccion de Archivos
   Call Common.ShowOpen
   '->  -----------------------------------------------------------------------

   '-> Si el archivo tiene un largo de Cero, se asume que no tiene contenido.
   If FileLen(Common.FileName) = 0 Then
      Let Err.Number = 32755
      GoTo ErrOpenFile
   End If
   

   Call ClaseInterfaz.FuncSavePathDefault(Common.FileName, iFileOpen)
   '-> -----------------------------------------------------------------------

   '-> Apertura del Archivo -------- Se modifica la apertura por new metodo --
   Let StrLoadFileName = Common.FileName
   Set ObjLoadFile = CreateObject("Scripting.FileSystemObject")
   Set ObjLoadOpenTextFile = ObjLoadFile.opentextfile(StrLoadFileName, ForReading)

   '-> Apertura del Archivo ---------Metodo Normal de Apertura ---------------
   'Open Common.FileName For Input As #1 -->

   '-> Inicializa el Puntero
   Let nContador = 0
   '-> Inicializa la cantidad de filas de la Grilla de Cuerpo o Detalle
   Let GrillaBody.Rows = 1

   '-> Control del Final de Arhivo
   Do While Not ObjLoadOpenTextFile.AtEndOfStream
  'Do While Not EOF(1)
  
      '->  Mueve el puntero, para determinar si debe leer cabecera (Grilla Cabecera) o Cuerpo (Grilla Cuerpo)
      Let nContador = nContador + 1
      
      '->  Lee la linea del registro abierto (linea completa) ... línea a línea
     'Line Input #1, xRegistro
      Let xRegistro = ObjLoadOpenTextFile.ReadLine

      If nContador = 1 Then
         '->  Parcela la inetrfaz en su Registro de Control
         Call ClaseInterfaz.FuncParcelaInterfaz(xRegistro, iFileOpen, nContador, GrillaHead)
      Else
         '->  Parcela la inetrfaz en sus Registros de Cuerpo o Contenido, controlando que este tenga caracteres.
         If Len(xRegistro) > 0 Then
            Call ClaseInterfaz.FuncParcelaInterfaz(xRegistro, iFileOpen, nContador, GrillaBody)
         End If
      End If
   Loop
   '-> -----------------------------------------------------------------------


   '-> Cierra el Archivo
   Call ObjLoadOpenTextFile.Close
  'Close #1
   '-> -----------------------------------------------------------------------
   
   Set ObjLoadFile = Nothing
   Set ObjLoadOpenTextFile = Nothing
   
   '-> Mantiene el Codigo del Archivo Abierto para el Control del Detalle [Doble Click]
   Let oFileOpenActive = iFileOpen
   '-> -----------------------------------------------------------------------
  
   '->  Establece el largo de celdas de las grilla ---------------------------
   Call ClaseInterfaz.FuncAutoSizeGrid(GrillaBody, oFileOpenActive)
   '-> -----------------------------------------------------------------------
   
   '-> Cierra la instancia de la Clase de Datos ------------------------------
   Set ClaseInterfaz = Nothing
   '-> -----------------------------------------------------------------------

   '-> Habilita el contenedor de Datos ---------------------------------------
   Let FRA_RegBody.Enabled = True:        Let GrillaBody.Enabled = True
   Let FRA_RegDetails.Enabled = True:     Let GrillaBody.Enabled = True
   '-> -----------------------------------------------------------------------
   
   On Error GoTo 0

Exit Function
ErrOpenFile:

   Let FRA_RegDetails.Enabled = False:     Let GrillaBody.Enabled = False

   If Err.Number = 5 Then
      Call MsgBox("E-Error " & vbCrLf & vbCrLf & Err.Description, vbExclamation, Err.Number & " - " & App.Title)
   End If

  '-> Error N° 32755, tiene como origen la cancelación manual desde la ventana de seleccion de archivos de Windows.
   If Err.Number = 32755 Then
      Exit Function
   End If

   '->  Cualquier error no controlado
   Call MsgBox("E-Error " & vbCrLf & vbCrLf & Err.Description, vbExclamation, Err.Number & " - " & App.Title)

   '-> Cierra la clase de Datos
   Set ClaseInterfaz = Nothing
   Set ObjLoadFile = Nothing
   Set ObjLoadOpenTextFile = Nothing

   On Error GoTo 0
End Function

Private Sub GrillaBody_Click()
   On Error GoTo Error
   Dim MiClase    As New clsInterfazDCV
   Dim iRetistro  As Long
   Dim vRegistro  As Variant
   
   Let iRetistro = GrillaBody.TextMatrix(GrillaBody.RowSel, 0)
   Let vRegistro = GrillaBody.TextMatrix(GrillaBody.RowSel, 1)
   
   Call MiClase.FuncShowDetaill(GrillaBody, GridDetail, oFileOpenActive)
   
   Let Me.FRA_RegDetails.Enabled = True:     Let GridDetail.Enabled = True
   
   Set MiClase = Nothing
Exit Sub
Error:
   Set MiClase = Nothing
   Call MsgBox("E - Error" & vbCrLf & vbCrLf & Err.Description, vbExclamation, App.Title)
End Sub


Private Sub Form_Resize()
   On Error Resume Next

   Let FRA_RegHeader.Left = 15:           Let FRA_RegHeader.Width = Width - 150:    Let GrillaHead.Width = FRA_RegHeader.Width - 120
   Let FRA_RegBody.Left = 15:             Let FRA_RegBody.Width = Width - 150:      Let GrillaBody.Width = FRA_RegBody.Width - 120
   Let FRA_RegDetails.Left = 15:          Let FRA_RegDetails.Width = Width - 150:   Let GridDetail.Width = FRA_RegDetails.Width - 120


   Let FRA_RegDetails.Top = Me.Height - 2200
   Let FRA_RegBody.Height = Me.Height - (Toolbar1.Height + FRA_RegHeader.Height + FRA_RegDetails.Height) - 600
   Let GrillaBody.Height = FRA_RegBody.Height - 250
   
    On Error GoTo 0
End Sub

