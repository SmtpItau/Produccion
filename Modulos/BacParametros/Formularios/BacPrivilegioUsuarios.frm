VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "comdlg32.ocx"
Begin VB.Form BacPrivilegioUsuarios 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Privilegios de Usuario"
   ClientHeight    =   3060
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   6240
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   3060
   ScaleWidth      =   6240
   Begin MSComDlg.CommonDialog Commando 
      Left            =   2160
      Top             =   3120
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin VB.Frame Frame1 
      Caption         =   "Privilegio de Usuario"
      Height          =   1935
      Left            =   240
      TabIndex        =   0
      Top             =   840
      Width           =   5655
      Begin VB.OptionButton OptTodo 
         Caption         =   "Todos"
         Height          =   255
         Left            =   4080
         TabIndex        =   4
         Top             =   480
         Width           =   1095
      End
      Begin VB.OptionButton OptBloqueado 
         Caption         =   "Bloqueados"
         Height          =   255
         Left            =   2400
         TabIndex        =   3
         Top             =   480
         Width           =   1215
      End
      Begin VB.OptionButton OptActivo 
         Caption         =   "Activos"
         Height          =   255
         Left            =   960
         TabIndex        =   2
         Top             =   480
         Width           =   1095
      End
      Begin VB.ComboBox Cmb_Usuarios 
         Height          =   315
         Left            =   600
         TabIndex        =   1
         Text            =   "Combo1"
         Top             =   1080
         Width           =   4575
      End
   End
   Begin MSComctlLib.ImageList ImageList2 
      Left            =   5520
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
            Picture         =   "BacPrivilegioUsuarios.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacPrivilegioUsuarios.frx":031A
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacPrivilegioUsuarios.frx":11DC
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacPrivilegioUsuarios.frx":14F6
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   5
      Top             =   0
      Width           =   6240
      _ExtentX        =   11007
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList2"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Imprimir"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Excel"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   4
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
End
Attribute VB_Name = "BacPrivilegioUsuarios"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Const nColIDUsu = "A"
Const nColNombreUsu = "B"
Const nColSistema = "C"
Const nColMenu = "D"
Const nColOpMenu = "E"
Const nColBloqueado = "F"

Private Sub Cmb_Usuarios_Click()
    Dim Usuario As String
     
    Usuario = Trim(Right(Cmb_Usuarios.Text, 20))
Cmb_Usuarios.SelStart = 0
            SendKeys "{Home}"
'            SendKeys "{right}"
      
End Sub

Private Sub Form_Load()
     Cmb_Usuarios.Clear
     If Not Bac_Sql_Execute("SP_FILTRO_LOG_AUDITORIA USUARIO,''") Then
        MsgBox "Problemas al Cargar Opciones para la Consulta.", vbInformation, TITSISTEMA
    Else
        'Cmb_Usuarios.AddItem "TODOS" & Space(80)
        Do While Bac_SQL_Fetch(Datos())
                Cmb_Usuarios.AddItem Datos(2) + Space(80) + Datos(1)
                
        Loop
        
    End If
End Sub





Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)


    Select Case Button.Index
        
        Case 1
'            Limpiar_Controles
'            LLena_Combos
               Cmb_Usuarios.Refresh
               Cmb_Usuarios.Clear
            'Toolbar1.Buttons(3).Enabled = False
               Ordenado = ""
            
        Case 2
            'Ejecuta_Consulta
               If Cmb_Usuarios.ListIndex = -1 Then
                  MsgBox "Debe Seleccionar un usuario", vbExclamation
                  Exit Sub
               End If
               If OptBloqueado.Value = False And OptActivo.Value = False And OptTodo.Value = False Then
                  MsgBox "Debe Seleccionar un Criterio: 'Activo, Bloqueado o Todos'", vbExclamation
               
                  Cmb_Usuarios.SelStart = 0
                  SendKeys "{Home}"
               Exit Sub
               
               End If
            
            Proc_Imprimir_PrivilegioUsuario
'            If GRD.TextMatrix(1, 1) <> Empty Then Toolbar1.Buttons(3).Enabled = True
'
'            Toolbar1.Buttons(1).Enabled = True
                    
        Case 3
               If Cmb_Usuarios.ListIndex = -1 Then
                  MsgBox "Debe Seleccionar un usuario", vbExclamation
                  Exit Sub
               End If
               If OptBloqueado.Value = False And OptActivo.Value = False And OptTodo.Value = False Then
                  MsgBox "Debe Seleccionar un Criterio: 'Activo, Bloqueado o Todos'", vbExclamation
               Exit Sub
               End If
             Call GeneraExcell
        Case 4
          Unload Me
          
    
    End Select

End Sub

Private Sub GeneraExcell()
On Error GoTo ErrorGeneracion
Dim habilitado As String

    Dim sCadena As String
    Dim nContador   As Integer
    Dim iContador        As Long
    Dim Archivo          As String
    Dim Estado           As String
    Dim Datos()
   
   Dim MiExcell         As New Excel.Application
   Dim MiLibro          As New Excel.Workbook
   Dim MiHoja           As New Excel.Worksheet
''''   Dim MiSheet          As Object
       
    Commando.DialogTitle = "Genera Archivo Excel"
    Commando.InitDir = "C:\"
    Commando.FileName = ""
    Commando.Flags = cdlOFNLongNames
    Commando.DefaultExt = "xlsx"
    Commando.Filter = "Libro Excel 2007|*.xlsx |Libro Excel 97-2003|*.xls|"
    Commando.CancelError = True
    Commando.ShowSave
  
   If Dir(Commando.FileName) <> "" Then
      Call Kill(Commando.FileName)
   End If
   
    Screen.MousePointer = vbHourglass
   
    Set MiExcell = CreateObject("Excel.Application")
    Set MiLibro = MiExcell.Application.Workbooks.Add
    Set MiHoja = MiExcell.ActiveSheet ''''MiLibro.Sheets.Add
''''   Set MiSheet = MiExcell.ActiveSheet
   
    MiLibro.Worksheets(1).Name = "Informe - Privilegio Usuarios"
    MiLibro.Worksheets(2).Delete
   'MiLibro.Worksheets(3).Delete
    

    If OptActivo.Value = True Then habilitado = "S"
    If OptBloqueado.Value = True Then habilitado = "N"
    If OptTodo.Value = True Then habilitado = "TODOS"
    
    iContador = 1
    
    MiHoja.Cells(iContador, nColIDUsu) = "ID Usuario"
    MiHoja.Cells(iContador, nColNombreUsu) = "Nombre"
    MiHoja.Cells(iContador, nColSistema) = "Sistema"                               '--> TipoOperacion
    MiHoja.Cells(iContador, nColMenu) = "Menu"
    MiHoja.Cells(iContador, nColOpMenu) = "Opción Menu"
    MiHoja.Cells(iContador, nColBloqueado) = "Activo"
    
    Envia = Array()
   
    AddParam Envia, habilitado
    AddParam Envia, Trim(Right(Cmb_Usuarios.Text, 20))                'Usuario

   
    If Not Bac_Sql_Execute("dbo.SP_PRIVILEGIO_MENU_USUARIO", Envia) Then
       Exit Sub
    End If
    
    Do While Bac_SQL_Fetch(Datos())
        iContador = iContador + 1
        MiHoja.Cells(iContador, nColIDUsu) = Datos(1)
        MiHoja.Cells(iContador, nColNombreUsu) = Datos(2)
        MiHoja.Cells(iContador, nColSistema) = Datos(3)
        MiHoja.Cells(iContador, nColMenu) = Datos(4)
        MiHoja.Cells(iContador, nColOpMenu) = Datos(5)
        MiHoja.Cells(iContador, nColBloqueado) = Datos(6)
                                       

    Loop
   
    MiHoja.Range("A1").Select
    MiHoja.Range(MiExcell.Selection, MiExcell.Selection.End(xlToRight)).Select
       
    MiExcell.Selection.Interior.ColorIndex = 1
    MiExcell.Selection.Interior.Pattern = xlSolid
    MiExcell.Selection.Font.ColorIndex = 2
   
    MiHoja.Range(MiExcell.Selection, MiExcell.Selection.End(xlDown)).Select
    MiExcell.Selection.Borders(xlDiagonalDown).LineStyle = xlNone
    MiExcell.Selection.Borders(xlDiagonalUp).LineStyle = xlNone
   
   
   
   With MiExcell.Selection.Borders(xlEdgeLeft)
       .LineStyle = xlContinuous
       .ColorIndex = 0
       .Weight = xlThin
   End With
   With MiExcell.Selection.Borders(xlEdgeTop)
       .LineStyle = xlContinuous
       .ColorIndex = 0
       .Weight = xlThin
   End With
   With MiExcell.Selection.Borders(xlEdgeBottom)
       .LineStyle = xlContinuous
       .ColorIndex = 0
       .Weight = xlThin
   End With
   With MiExcell.Selection.Borders(xlEdgeRight)
       .LineStyle = xlContinuous
       .ColorIndex = 0
       .Weight = xlThin
   End With
   With MiExcell.Selection.Borders(xlInsideVertical)
       .LineStyle = xlContinuous
       .ColorIndex = 0
       .Weight = xlThin
   End With
   With MiExcell.Selection.Borders(xlInsideHorizontal)
       .LineStyle = xlContinuous
       .ColorIndex = 0
       .Weight = xlThin
   End With
   
''''   For nContador = 3 To nUltFila Step 2
''''      MiHoja.Range("A" + Trim(CStr(nContador)) + ":M" + Trim(CStr(nContador))).Select
''''      MiExcell.Selection.Interior.ColorIndex = 15
''''      MiExcell.Selection.Interior.Pattern = xlSolid
''''   Next nContador

    MiHoja.Cells.Select
    MiHoja.Cells.EntireColumn.AutoFit
    MiHoja.Cells(1, 1).Select
  
    MiHoja.SaveAs (Commando.FileName)
    MiHoja.Application.Workbooks.Close
    MiExcell.Application.Workbooks.Close
   
    Set MiExcell = Nothing
    Set MiLibro = Nothing
    Set MiHoja = Nothing
   
    Screen.MousePointer = vbDefault

Exit Sub

ErrorGeneracion:
    Screen.MousePointer = vbDefault
    
    If Err.Number = 32755 Then
        Exit Sub
    Else
        MsgBox "Error en generación de planilla" & vbCrLf & vbCrLf & Err.Description, vbExclamation, TITSISTEMA
    End If
End Sub

Private Sub Proc_Imprimir_PrivilegioUsuario()
Dim habilitado As String

   On Error GoTo Control:

   'Selecciona_Eventos

    
    If OptActivo.Value = True Then habilitado = "S"
    If OptBloqueado.Value = True Then habilitado = "N"
    If OptTodo.Value = True Then habilitado = "TODOS"
    
   Screen.MousePointer = vbHourglass
   
   Call limpiar_cristal
   
   BACSwapParametros.BACParam.Destination = crptToWindow
   BACSwapParametros.BACParam.ReportFileName = gsRPT_Path & "BacPrivilegioUsuario.RPT"
   BACSwapParametros.BACParam.StoredProcParam(0) = habilitado
   BACSwapParametros.BACParam.StoredProcParam(1) = Trim(Right(Cmb_Usuarios.Text, 20))                'Tipo Usuario
   
   BACSwapParametros.BACParam.WindowTitle = "INFORME PRIVILEGIO USUARIO"
   BACSwapParametros.BACParam.WindowState = crptMaximized
   BACSwapParametros.BACParam.Connect = SwConeccion
   BACSwapParametros.BACParam.Action = 1
   
   Screen.MousePointer = vbDefault
   Exit Sub
   
Control:
   MsgBox "Problemas al generar Listado. " & Err.Description & ", " & Err.Number, vbCritical, "BACPARAMETROS"
   Screen.MousePointer = vbDefault

End Sub

