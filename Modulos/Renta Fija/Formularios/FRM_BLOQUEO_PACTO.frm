VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "COMDLG32.OCX"
Begin VB.Form FRM_BLOQUEO_PACTO 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Administrador de papeles para bloquear en pactos"
   ClientHeight    =   5850
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   9255
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   5850
   ScaleWidth      =   9255
   Begin VB.Frame Fra_Pactos 
      Caption         =   "Modulo de Bloqueo para Pacto"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FF0000&
      Height          =   5295
      Left            =   90
      TabIndex        =   1
      Top             =   480
      Width           =   9090
      Begin MSFlexGridLib.MSFlexGrid Grd_Datos 
         Height          =   4905
         Left            =   120
         TabIndex        =   2
         Top             =   270
         Width           =   8850
         _ExtentX        =   15610
         _ExtentY        =   8652
         _Version        =   393216
         Cols            =   29
         AllowUserResizing=   2
      End
      Begin MSComDlg.CommonDialog Command 
         Left            =   5355
         Top             =   -330
         _ExtentX        =   847
         _ExtentY        =   847
         _Version        =   393216
      End
   End
   Begin MSComctlLib.ImageList ImageList3 
      Left            =   10080
      Top             =   0
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   6
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_BLOQUEO_PACTO.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_BLOQUEO_PACTO.frx":0EDA
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_BLOQUEO_PACTO.frx":1DB4
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_BLOQUEO_PACTO.frx":2C8E
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_BLOQUEO_PACTO.frx":3B68
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_BLOQUEO_PACTO.frx":4A42
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   9255
      _ExtentX        =   16325
      _ExtentY        =   794
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList3"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Filtro"
            Object.ToolTipText     =   "Filtro"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "CargaExcel"
            Object.ToolTipText     =   "Cargar Excel"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Excel"
            Object.ToolTipText     =   "Exportar a Excel"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   6
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
End
Attribute VB_Name = "FRM_BLOQUEO_PACTO"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False


Public iAceptar               As Boolean
Public CarterasFinancieras    As String
Public CarterasNormativas     As String

Private iCadena As String

Const Cons_Emisor = 0
Const Cons_Serie = 1
Const Cons_Origen = 2
Const Cons_Compra = 3
Const Cons_Correlativo = 4
Const Cons_Ncompra = 5
Const Cons_Nominal = 6
Const Cons_Bloqueado = 7
Const Cons_Tnominal = 8
Const Cons_NenPacto = 9
Const Cons_Cminimo = 10
Const Cons_Tcompra = 11
Const Cons_Cod_CartF = 12
Const Cons_CartFinan = 13
Const Cons_Instrumento = 14
Const Cons_Cod_Libro = 15
Const Cons_Libro = 16
Const Cons_Cod_CartS = 17
Const Cons_CartSuper = 18
Const Cons_Fcompra = 19
Const Cons_Vpresente = 20
Const Cons_Vmercado = 21
Const Cons_DifVmercado = 22
Const Cons_TirMercado = 23
Const Cons_MonEmision = 24
Const Cons_DuraMercado = 25
Const Cons_Convexidad = 26
Const Cons_PerEnCart = 27
Const Cons_PlazoRes = 28


Const xlAutomatic = -4105
Const xlNone = -4142
Const xlDown = -4121
Const xlToRight = -4161

Const xlFillDefault = 0
Const xlContinuous = 1
Const xlThin = 2
Const xlCenter = 3
Const xlDiagonalDown = 5
Const xlDiagonalUp = 6
Const xlEdgeLeft = 7
Const xlEdgeTop = 8
Const xlEdgeBottom = 9
Const xlEdgeRight = 10
Const xlInsideVertical = 11
Const xlInsideHorizontal = 12

    Private Sub Proc_Carga_Excel()
       On Error GoTo ErrorAction
       Dim nArchivo   As String
       Dim nContador  As Long
       Dim Contador As Integer
       Dim nFilas     As Long
       Dim xRiesgo    As String
       Dim xItem      As String
       Dim oValor     As Double
       Dim MiFila     As Integer
       Dim DATOS()
       iCadena = ""
       '--> Variables de Barra de Progreso y Cursor
       Screen.MousePointer = vbHourglass
      
       '--> Inicializa la Pantalla Open File de Windows
       Command.CancelError = True
       Command.Filter = ".xlsx"
       Command.FileName = ""
       Call Command.ShowOpen
ShowOpenAgain:
        If Command.FileName = "" Then
           If MsgBox("Advertencia." & vbCrLf & vbCrLf & "No se ha seleccionado ninguna planilla. " _
           & vbCrLf & vbCrLf & ".... Reintentar ?", vbExclamation + vbRetryCancel, TITSISTEMA) = vbRetry Then
              
              GoTo ShowOpenAgain
           Else
              
              GoTo ErrorAction
           End If
        End If
        Screen.MousePointer = vbHourglass
       '--> Levanta las Variables de entorno de Excel
       Set Miexcell = CreateObject("Excel.Application")
       Set MiLibro = Miexcell.Workbooks.Open(Command.FileName)
       Set MiHoja = Nothing
       Set MiHoja = Miexcell.ActiveSheet
       '--> Levanta las Variables de entorno de Excel
    
       '--> Valida Hojas
       'CDbl(Format((Grd_Datos.TextMatrix(Contador, Cons_Vpresente)), "#,##0.0000"))
        
        MiFila = 1
        '--> Chequea que exista literal Numero Compra en Excel.
        If MiHoja.Cells(MiFila, "D") <> "Numero Compra" Then
            Screen.MousePointer = vbdefaul
            Call MsgBox("Falta columna Numero Compra" & vbCrLf & vbCrLf & err.Description, vbExclamation, App.Title)
            'Cerramos Excel
            MiLibro.Application.Workbooks.Close
            Miexcell.Application.Quit
            Exit Sub
        End If
    
        '--> Chequea que exista literal Correlativo en Excel.
        MiFila = 1
        If MiHoja.Cells(MiFila, "E") <> "Correlativo" Then
            Screen.MousePointer = vbdefaul
            Call MsgBox("Falta columna Correlativo" & vbCrLf & vbCrLf & err.Description, vbExclamation, App.Title)
            'Cerramos Excel
            MiLibro.Application.Workbooks.Close
            Miexcell.Application.Quit
            Exit Sub
        End If
           
        '--> Chequea que exista literal Bloqueo Pacto en Excel.
        MiFila = 1
        If MiHoja.Cells(MiFila, "H") <> "Bloqueo Pacto" Then
            Screen.MousePointer = vbdefaul
            Call MsgBox("Falta columna Bloqueo Pacto" & vbCrLf & vbCrLf & err.Description, vbExclamation, App.Title)
            'Cerramos Excel
            MiLibro.Application.Workbooks.Close
            Miexcell.Application.Quit
            Exit Sub
        End If
          
        '--> Chequea que exista literal Nominal Total en Excel.
        MiFila = 1
        If MiHoja.Cells(MiFila, "I") <> "Nominal Total" Then
            Screen.MousePointer = vbdefaul
            Call MsgBox("Falta columna Nominal Total" & vbCrLf & vbCrLf & err.Description, vbExclamation, App.Title)
            'Cerramos Excel
            MiLibro.Application.Workbooks.Close
            Miexcell.Application.Quit
            Exit Sub
        End If
              
        '--> Chequea que exista literal Corte Minimo en Excel.
        MiFila = 1
        If MiHoja.Cells(MiFila, "K") <> "Corte Minimo" Then
            Screen.MousePointer = vbdefaul
            Call MsgBox("Falta columna Corte Minimo" & vbCrLf & vbCrLf & err.Description, vbExclamation, App.Title)
            'Cerramos Excel
            MiLibro.Application.Workbooks.Close
            Miexcell.Application.Quit
            Exit Sub
        End If
       
               
        '--> Determina el Largo Aprox de la Hoja Seleccionada
        nFilas = MiHoja.Columns.End(xlDown).Row
      
        
       '--> Valida que parametros no sean mayor a Numeric(19,4)
        Contador = 2
        For Contador = 2 To nFilas
            If Format(MiHoja.Cells(Contador, "G"), "#,###,###,###,##0.0000") >= 1E+15 Then
               Screen.MousePointer = vbdefaul
               Call MsgBox("Monto Nominal no tiene formato permitido, N°Compra " & MiHoja.Cells(Contador, "F") _
               & vbCrLf & vbCrLf & err.Description, vbExclamation, App.Title)
                 'Cerramos Excel
                 MiLibro.Application.Workbooks.Close
                 Miexcell.Application.Quit
                 Exit Sub
            End If
        Next Contador
              
        Contador = 2
        For Contador = 2 To nFilas
            If Format(MiHoja.Cells(Contador, "H"), "#,###,###,###,##0.0000") >= 1E+15 Then
               Screen.MousePointer = vbdefaul
               Call MsgBox("Monto en Bloqueo Pacto no tiene formato permitido, N°Compra " & MiHoja.Cells(Contador, "F") _
               & vbCrLf & vbCrLf & err.Description, vbExclamation, App.Title)
                 'Cerramos Excel
                 MiLibro.Application.Workbooks.Close
                 Miexcell.Application.Quit
                 Exit Sub
            End If
        Next Contador
        
        Contador = 2
        For Contador = 2 To nFilas
            If Format(MiHoja.Cells(Contador, "I"), "#,###,###,###,##0.0000") >= 1E+15 Then
               Screen.MousePointer = vbdefaul
               Call MsgBox("Monto en Nominal Total no tiene formato permitido, N°Compra " & MiHoja.Cells(Contador, "F") _
               & vbCrLf & vbCrLf & err.Description, vbExclamation, App.Title)
                 'Cerramos Excel
                 MiLibro.Application.Workbooks.Close
                 Miexcell.Application.Quit
                 Exit Sub
            End If
        Next Contador
        
        Contador = 2
        For Contador = 2 To nFilas
            If Format(MiHoja.Cells(Contador, "K"), "#,###,###,###,##0.0000") >= 1E+15 Then
               Screen.MousePointer = vbdefaul
               Call MsgBox("Monto en Corte Minimo no tiene formato permitido, N°Compra " & MiHoja.Cells(Contador, "F") _
               & vbCrLf & vbCrLf & err.Description, vbExclamation, App.Title)
                 'Cerramos Excel
                 MiLibro.Application.Workbooks.Close
                 Miexcell.Application.Quit
                 Exit Sub
            End If
        Next Contador
        
        Contador = 2
        For Contador = 2 To nFilas
            If Format(MiHoja.Cells(Contador, "D"), "#########0") >= 999999999# Then
               Screen.MousePointer = vbdefaul
               Call MsgBox("Numero Compra no tiene formato permitido, N°Compra " & MiHoja.Cells(Contador, "F") _
               & vbCrLf & vbCrLf & err.Description, vbExclamation, App.Title)
                 'Cerramos Excel
                 MiLibro.Application.Workbooks.Close
                 Miexcell.Application.Quit
                 
                 Exit Sub
            End If
        Next Contador
                                               
         '--> Valida que en la columnas contengan solo numeros
        Contador = 2
        For Contador = 2 To nFilas
            If IsNumeric(MiHoja.Cells(Contador, "D")) = False Then
                Screen.MousePointer = vbdefaul
                Call MsgBox("Numero compra debe ser solo numeros" & vbCrLf & vbCrLf & err.Description, _
                vbExclamation, App.Title)
                'Cerramos Excel
                MiLibro.Application.Workbooks.Close
                Miexcell.Application.Quit
                Exit Sub
            End If
        Next Contador
        
        Contador = 2
        For Contador = 2 To nFilas
            If IsNumeric(MiHoja.Cells(Contador, "G")) = False Then
                Screen.MousePointer = vbdefaul
                Call MsgBox("Nominal debe ser solo numeros" & vbCrLf & vbCrLf & err.Description, vbExclamation, App.Title)
                'Cerramos Excel
                MiLibro.Application.Workbooks.Close
                Miexcell.Application.Quit
                Exit Sub
            End If
        Next Contador
        
        Contador = 2
        For Contador = 2 To nFilas
            If IsNumeric(MiHoja.Cells(Contador, "I")) = False Then
                Screen.MousePointer = vbdefaul
                Call MsgBox("Nominal Total debe ser solo numeros" & vbCrLf & vbCrLf & err.Description, vbExclamation, App.Title)
                'Cerramos Excel
                MiLibro.Application.Workbooks.Close
                Miexcell.Application.Quit
                Exit Sub
            End If
        Next Contador
        
        Contador = 2
        For Contador = 2 To nFilas
            If IsNumeric(MiHoja.Cells(Contador, "K")) = False Then
                Screen.MousePointer = vbdefaul
                Call MsgBox("Nominal Total debe ser solo numeros" & vbCrLf & vbCrLf & err.Description, vbExclamation, App.Title)
                'Cerramos Excel
                MiLibro.Application.Workbooks.Close
                Miexcell.Application.Quit
                Exit Sub
            End If
        Next Contador
        
        Contador = 2
        For Contador = 2 To nFilas
            If (MiHoja.Cells(Contador, "E") >= 1000) Then
                Screen.MousePointer = vbdefaul
                Call MsgBox("Numeros correlativo no corresponden N° " & (MiHoja.Cells(Contador, "F")) & vbCrLf & vbCrLf & err.Description, vbExclamation, App.Title)
                'Cerramos Excel
                MiLibro.Application.Workbooks.Close
                Miexcell.Application.Quit
                Exit Sub
            End If
        Next Contador
            
        '--> Comienza a Recorrer cada una de las filas del Excel y grabla bloqueados
        For nContador = 2 To nFilas
             Envia = Array()
             AddParam Envia, CDbl(MiHoja.Cells(nContador, "D"))          '--> Se Ingresa el parametro N° Documento
             AddParam Envia, CDbl(MiHoja.Cells(nContador, "E"))          '--> Se Ingresa Correlativo
             AddParam Envia, CDbl(MiHoja.Cells(nContador, "H"))          '--> Se Ingresa monto de Bloqueo Pacto
             AddParam Envia, CDbl(MiHoja.Cells(nContador, "K"))
             AddParam Envia, CDbl(MiHoja.Cells(nContador, "G"))
             AddParam Envia, CDbl(MiHoja.Cells(nContador, "I"))
             AddParam Envia, gsBac_User
             AddParam Envia, GLB_ID_SISTEMA
             AddParam Envia, "CP"
             AddParam Envia, (MiHoja.Cells(nContador, "M"))
             AddParam Envia, (MiHoja.Cells(nContador, "R"))

            If Not Bac_Sql_Execute("SP_ACTBLOQUEADO", Envia) Then
                Call MsgBox("Error Lectura" & vbCrLf & vbCrLf _
                & "Se ha originado un error en la carga de la información.", vbExclamation, App.Title)
                MiLibro.Application.Workbooks.Close
                Miexcell.Application.Quit
                Screen.MousePointer = vbDefault
                Exit Sub
            End If

            Do While Bac_SQL_Fetch(DATOS())
                If Trim(DATOS(1)) = -1 Then
                    iCadena = iCadena & vbCrLf & Trim(DATOS(2)) & " Numero Correlativo es " & Trim(DATOS(3)) _
                    & "-" & Trim(DATOS(4)) & vbCrLf
                End If
            Loop
            
         Next nContador
         Screen.MousePointer = vbDefault
         Call MsgBox("Planilla ha sido cargada en forma exitosa", vbInformation, App.Title)   '--> Mensaje
         
         
        Frm_Msg_Planilla_Excel.Show
        Frm_Msg_Planilla_Excel.ssMsgResum.Visible = True
        Frm_Msg_Planilla_Excel.Caption = "Problemas en Planilla Excel"
        Frm_Msg_Planilla_Excel.TxtMsg.Text = "Advertencia: Se detectaron y no se grabaron las siguiente diferencias en bloqueo."
        Frm_Msg_Planilla_Excel.TxtMsg.Text = Frm_Msg_Planilla_Excel.TxtMsg.Text & vbCrLf & iCadena & vbCrLf & MsgInterNoc

        
        Set MiSheet = Nothing
        Set MiHoja = Nothing
        MiLibro.Application.Workbooks.Close
        Miexcell.Application.Quit
        Set MiLibro = Nothing
        Set Miexcell = Nothing
        '--> Cierra las variables de entorno de Windows para Excel
 '________________________________________________________________________________
 '________________________________________________________________________________
On Error GoTo 0

'Exit Function
ErrorAction:
   Screen.MousePointer = vbDefault
   If err.Number = 32755 Then
   Else
      If err.Number <> 0 Then
         Call MsgBox("Error en la carga de archivo" & vbCrLf & vbCrLf & err.Description, vbExclamation, App.Title)
         MiLibro.Application.Workbooks.Close
         Miexcell.Application.Quit
      End If
   End If

End Sub

Private Sub Proc_Filtra()
   Dim DATOS()

  
   Me.CarterasFinancieras = ""
   Me.CarterasNormativas = ""
   
   Call FRM_BLOQUEO_FILTRO.Show(vbModal)

   If FRM_BLOQUEO_PACTO.iAceptar = False Then Exit Sub
   Screen.MousePointer = vbHourglass

   Envia = Array()
   AddParam Envia, 1
   AddParam Envia, CarterasFinancieras
   AddParam Envia, CarterasNormativas
   
   If Not Bac_Sql_Execute("SP_CARGACARTERAPARABLOQUEOPACTO", Envia) Then
      Let Screen.MousePointer = vbDefault
      Call MsgBox("Se ha originado un error en la lectura de operaciones." & vbCrLf & vbCrLf & VerSql, vbExclamation, App.Title)
      Exit Sub
   End If
  
   With Grd_Datos
        .Rows = 1
        Do While Bac_SQL_Fetch(DATOS())
            .Rows = .Rows + 1
            .TextMatrix(.Rows - 1, Cons_Emisor) = IIf(IsNull(DATOS(1)), "", (DATOS(1)))
            .TextMatrix(.Rows - 1, Cons_Serie) = IIf(IsNull(DATOS(2)), "", (DATOS(2)))
            .TextMatrix(.Rows - 1, Cons_Origen) = IIf(IsNull(DATOS(3)), "", (DATOS(3)))
            .TextMatrix(.Rows - 1, Cons_Compra) = IIf(IsNull(DATOS(4)), "", (DATOS(4)))
            .TextMatrix(.Rows - 1, Cons_Correlativo) = IIf(IsNull(DATOS(5)), "", (DATOS(5)))
            .TextMatrix(.Rows - 1, Cons_Ncompra) = IIf(IsNull(DATOS(6)), "", (DATOS(6)))
            .TextMatrix(.Rows - 1, Cons_Nominal) = IIf(IsNull(DATOS(7)), 0, Format((DATOS(7)), "#,##0.0000"))
            .TextMatrix(.Rows - 1, Cons_Bloqueado) = IIf(IsNull(DATOS(8)), 0, Format((DATOS(8)), "#,##0.0000"))
            .TextMatrix(.Rows - 1, Cons_Tnominal) = IIf(IsNull(DATOS(9)), "", Format((DATOS(9)), "#,##0.0000"))
            .TextMatrix(.Rows - 1, Cons_NenPacto) = IIf(IsNull(DATOS(10)), 0, Format((DATOS(10)), "#,##0"))
            .TextMatrix(.Rows - 1, Cons_Cminimo) = IIf(IsNull(DATOS(11)), 0, Format((DATOS(11)), "#,##0.0000"))
            .TextMatrix(.Rows - 1, Cons_Tcompra) = IIf(IsNull(DATOS(12)), 0, Format((DATOS(12)), "#,##0.0000"))
            .TextMatrix(.Rows - 1, Cons_Cod_CartF) = IIf(IsNull(DATOS(13)), "", (DATOS(13)))
            .TextMatrix(.Rows - 1, Cons_CartFinan) = IIf(IsNull(DATOS(14)), "", (DATOS(14)))
            .TextMatrix(.Rows - 1, Cons_Instrumento) = IIf(IsNull(DATOS(15)), "", (DATOS(15)))
            .TextMatrix(.Rows - 1, Cons_Cod_Libro) = IIf(IsNull(DATOS(16)), "", (DATOS(16)))
            .TextMatrix(.Rows - 1, Cons_Libro) = IIf(IsNull(DATOS(17)), "", (DATOS(17)))
            .TextMatrix(.Rows - 1, Cons_Cod_CartS) = IIf(IsNull(DATOS(18)), "", (DATOS(18)))
            .TextMatrix(.Rows - 1, Cons_CartSuper) = IIf(IsNull(DATOS(19)), "", (DATOS(19)))
            .TextMatrix(.Rows - 1, Cons_Fcompra) = IIf(IsNull(DATOS(20)), "", (DATOS(20)))
            .TextMatrix(.Rows - 1, Cons_Vpresente) = IIf(IsNull(DATOS(21)), "", Format((DATOS(21)), "#,##0.0000"))
            .TextMatrix(.Rows - 1, Cons_Vmercado) = IIf(IsNull(DATOS(22)), "", Format((DATOS(22)), "#,##0.0000"))
            .TextMatrix(.Rows - 1, Cons_DifVmercado) = IIf(IsNull(DATOS(23)), "", Format((DATOS(23)), "#,##0.0000"))
            .TextMatrix(.Rows - 1, Cons_TirMercado) = IIf(IsNull(DATOS(24)), "", Format((DATOS(24)), "#,##0.0000"))
            .TextMatrix(.Rows - 1, Cons_MonEmision) = IIf(IsNull(DATOS(25)), "", (DATOS(25)))
            .TextMatrix(.Rows - 1, Cons_DuraMercado) = IIf(IsNull(DATOS(26)), "", (DATOS(26)))
            .TextMatrix(.Rows - 1, Cons_Convexidad) = IIf(IsNull(DATOS(27)), "", (DATOS(27)))
            .TextMatrix(.Rows - 1, Cons_PerEnCart) = IIf(IsNull(DATOS(28)), "", (DATOS(28)))
            .TextMatrix(.Rows - 1, Cons_PlazoRes) = IIf(IsNull(DATOS(29)), "", (DATOS(29)))
            .Row = .Rows - 1
        Loop
   End With
   Me.MousePointer = vbDefault
End Sub


Private Sub Proc_Genera_Excel()
   On Error GoTo ErrorAction
   Dim Contador  As Long
   Dim cFile      As String
   Dim nFilas     As Long
   Dim MiFila     As Long
   Dim MiSheet    As Object
   Dim Respalda   As Boolean
   Dim DATOS()
   
   If Grd_Datos.Rows = 1 Then
    Call MsgBox("No hay datos para Exportar" & vbCrLf & vbCrLf & err.Description, vbExclamation, App.Title)
    Exit Sub
   End If
  
   Respalda = False
   
   Screen.MousePointer = vbHourglass
   cFile = App.Path & "\BloqueoPactos.xlsx"
   cFile = "BloqueoPactos.xlsx"
   Command.Filter = ".xlsx"
   Command.CancelError = True

   Set Miexcell = CreateObject("Excel.Application")
   Set MiLibro = Miexcell.Application.Workbooks.Add
   Set MiHoja = MiLibro.Sheets.Add
   Set MiSheet = Miexcell.Worksheets(1) '--> MiExcell.ActiveSheet
   MiSheet.Name = "BLOQUEO PACTOS"
   
   Miexcell.DisplayAlerts = False
   Call Miexcell.Worksheets(3).Delete
   Call Miexcell.Worksheets(2).Delete
   Miexcell.DisplayAlerts = True

   Screen.MousePointer = vbHourglass
   Miexcell.Columns("G:G").Select
   Miexcell.Selection.NumberFormat = "#,###,###,###,##0.0000"
   Miexcell.Columns("H:H").Select
   Miexcell.Selection.NumberFormat = "#,###,###,###,##0.0000"
   Miexcell.Columns("I:I").Select
   Miexcell.Selection.NumberFormat = "#,###,###,###,##0.0000"
   Miexcell.Columns("J:J").Select
   Miexcell.Selection.NumberFormat = "#,###,###,###,##0.0000"
   Miexcell.Columns("K:K").Select
   Miexcell.Selection.NumberFormat = "#,###,###,###,##0.0000"
   Miexcell.Columns("L:L").Select
   Miexcell.Selection.NumberFormat = "#,###,###,###,##0.0000"
   Miexcell.Columns("U:U").Select
   Miexcell.Selection.NumberFormat = "#,###,###,###,##0.0000"
   Miexcell.Columns("V:V").Select
   Miexcell.Selection.NumberFormat = "#,###,###,###,##0.0000"
   Miexcell.Columns("W:W").Select
   Miexcell.Selection.NumberFormat = "#,###,###,###,##0.0000"
   Miexcell.Columns("X:X").Select
   Miexcell.Selection.NumberFormat = "#,###,###,###,##0.0000"
   Miexcell.Columns("Z:Z").Select
   Miexcell.Selection.NumberFormat = "#,###,###,###,##0.0000"
   Miexcell.Columns("AA:AA").Select
   Miexcell.Selection.NumberFormat = "#,###,###,###,##0.0000"
    
  
    MiFila = 1
    MiHoja.Cells(MiFila, 1) = "Emisor":              MiHoja.Cells(MiFila, 1).Font.Name = "Tahoma": MiHoja.Cells(MiFila, 1).Font.Size = 8
    MiHoja.Cells(MiFila, 2) = "Serie":               MiHoja.Cells(MiFila, 1).Font.Name = "Tahoma": MiHoja.Cells(MiFila, 1).Font.Size = 8
    MiHoja.Cells(MiFila, 3) = "Origen":              MiHoja.Cells(MiFila, 1).Font.Name = "Tahoma": MiHoja.Cells(MiFila, 1).Font.Size = 8
    MiHoja.Cells(MiFila, 4) = "Numero Compra":       MiHoja.Cells(MiFila, 1).Font.Name = "Tahoma": MiHoja.Cells(MiFila, 1).Font.Size = 8
    MiHoja.Cells(MiFila, 5) = "Correlativo":         MiHoja.Cells(MiFila, 1).Font.Name = "Tahoma": MiHoja.Cells(MiFila, 1).Font.Size = 8
    MiHoja.Cells(MiFila, 6) = "N°Compra":            MiHoja.Cells(MiFila, 1).Font.Name = "Tahoma": MiHoja.Cells(MiFila, 1).Font.Size = 8
    MiHoja.Cells(MiFila, 7) = "Nominal":             MiHoja.Cells(MiFila, 1).Font.Name = "Tahoma": MiHoja.Cells(MiFila, 1).Font.Size = 8
    MiHoja.Cells(MiFila, 8) = "Bloqueo Pacto":       MiHoja.Cells(MiFila, 1).Font.Name = "Tahoma": MiHoja.Cells(MiFila, 1).Font.Size = 8
    MiHoja.Cells(MiFila, 9) = "Nominal Total":       MiHoja.Cells(MiFila, 1).Font.Name = "Tahoma": MiHoja.Cells(MiFila, 1).Font.Size = 8
    MiHoja.Cells(MiFila, 10) = "Nominal en Pacto":   MiHoja.Cells(MiFila, 1).Font.Name = "Tahoma": MiHoja.Cells(MiFila, 1).Font.Size = 8
    MiHoja.Cells(MiFila, 11) = "Corte Minimo":       MiHoja.Cells(MiFila, 1).Font.Name = "Tahoma": MiHoja.Cells(MiFila, 1).Font.Size = 8
    MiHoja.Cells(MiFila, 12) = "Tir de Compra":      MiHoja.Cells(MiFila, 1).Font.Name = "Tahoma": MiHoja.Cells(MiFila, 1).Font.Size = 8
    MiHoja.Cells(MiFila, 13) = "Cod CartF":          MiHoja.Cells(MiFila, 1).Font.Name = "Tahoma": MiHoja.Cells(MiFila, 1).Font.Size = 8
    MiHoja.Cells(MiFila, 14) = "Carteta Fin.":       MiHoja.Cells(MiFila, 1).Font.Name = "Tahoma": MiHoja.Cells(MiFila, 1).Font.Size = 8
    MiHoja.Cells(MiFila, 15) = "Instrumento":        MiHoja.Cells(MiFila, 1).Font.Name = "Tahoma": MiHoja.Cells(MiFila, 1).Font.Size = 8
    MiHoja.Cells(MiFila, 16) = "Cod Libro":          MiHoja.Cells(MiFila, 1).Font.Name = "Tahoma": MiHoja.Cells(MiFila, 1).Font.Size = 8
    MiHoja.Cells(MiFila, 17) = "Libro":              MiHoja.Cells(MiFila, 1).Font.Name = "Tahoma": MiHoja.Cells(MiFila, 1).Font.Size = 8
    MiHoja.Cells(MiFila, 18) = "Cod CartS":          MiHoja.Cells(MiFila, 1).Font.Name = "Tahoma": MiHoja.Cells(MiFila, 1).Font.Size = 8
    MiHoja.Cells(MiFila, 19) = "Cart.Super":         MiHoja.Cells(MiFila, 1).Font.Name = "Tahoma": MiHoja.Cells(MiFila, 1).Font.Size = 8
    MiHoja.Cells(MiFila, 20) = "Fecha Compra":       MiHoja.Cells(MiFila, 1).Font.Name = "Tahoma": MiHoja.Cells(MiFila, 1).Font.Size = 8
    MiHoja.Cells(MiFila, 21) = "Valor Presente":     MiHoja.Cells(MiFila, 1).Font.Name = "Tahoma": MiHoja.Cells(MiFila, 1).Font.Size = 8
    MiHoja.Cells(MiFila, 22) = "Valor Mercado":      MiHoja.Cells(MiFila, 1).Font.Name = "Tahoma": MiHoja.Cells(MiFila, 1).Font.Size = 8
    MiHoja.Cells(MiFila, 23) = "Dif.Valor Merc.":    MiHoja.Cells(MiFila, 1).Font.Name = "Tahoma": MiHoja.Cells(MiFila, 1).Font.Size = 8
    MiHoja.Cells(MiFila, 24) = "Tir de Mercado":     MiHoja.Cells(MiFila, 1).Font.Name = "Tahoma": MiHoja.Cells(MiFila, 1).Font.Size = 8
    MiHoja.Cells(MiFila, 25) = "Moneda Emisión":     MiHoja.Cells(MiFila, 1).Font.Name = "Tahoma": MiHoja.Cells(MiFila, 1).Font.Size = 8
    MiHoja.Cells(MiFila, 26) = "Duración Mod":       MiHoja.Cells(MiFila, 1).Font.Name = "Tahoma": MiHoja.Cells(MiFila, 1).Font.Size = 8
    MiHoja.Cells(MiFila, 27) = "Convexidad":         MiHoja.Cells(MiFila, 1).Font.Name = "Tahoma": MiHoja.Cells(MiFila, 1).Font.Size = 8
    MiHoja.Cells(MiFila, 28) = "Per. en Cart.":      MiHoja.Cells(MiFila, 1).Font.Name = "Tahoma": MiHoja.Cells(MiFila, 1).Font.Size = 8
    MiHoja.Cells(MiFila, 29) = "Plazo Res.":         MiHoja.Cells(MiFila, 1).Font.Name = "Tahoma": MiHoja.Cells(MiFila, 1).Font.Size = 8
   
   
    With MiHoja
            
            'Recorre Lista para Generar Archivo
        
        For Contador = 1 To Grd_Datos.Rows - 1
            Let MiFila = MiFila + 1
            .Cells(MiFila, Cons_Emisor + 1) = Grd_Datos.TextMatrix(Contador, Cons_Emisor)
            .Cells(MiFila, Cons_Serie + 1) = (Grd_Datos.TextMatrix(Contador, Cons_Serie))
            .Cells(MiFila, Cons_Origen + 1) = (Grd_Datos.TextMatrix(Contador, Cons_Origen))
            .Cells(MiFila, Cons_Compra + 1) = (Grd_Datos.TextMatrix(Contador, Cons_Compra))
            .Cells(MiFila, Cons_Correlativo + 1) = (Grd_Datos.TextMatrix(Contador, Cons_Correlativo))
            .Cells(MiFila, Cons_Ncompra + 1) = (Grd_Datos.TextMatrix(Contador, Cons_Ncompra))
            .Cells(MiFila, Cons_Nominal + 1) = CDbl(Format((Grd_Datos.TextMatrix(Contador, Cons_Nominal)), "#,##0.0000"))
            .Cells(MiFila, Cons_Bloqueado + 1) = CDbl(Format((Grd_Datos.TextMatrix(Contador, Cons_Bloqueado)), "#,##0.0000"))
            .Cells(MiFila, Cons_Tnominal + 1) = CDbl(Format((Grd_Datos.TextMatrix(Contador, Cons_Tnominal)), "#,##0.0000"))
            .Cells(MiFila, Cons_NenPacto + 1) = CDbl(Format((Grd_Datos.TextMatrix(Contador, Cons_NenPacto)), "#,##0.0000"))
            .Cells(MiFila, Cons_Cminimo + 1) = CDbl(Format((Grd_Datos.TextMatrix(Contador, Cons_Cminimo)), "#,##0.0000"))
            .Cells(MiFila, Cons_Tcompra + 1) = CDbl(Format((Grd_Datos.TextMatrix(Contador, Cons_Tcompra)), "#,##0.0000"))
            .Cells(MiFila, Cons_Cod_CartF + 1) = (Grd_Datos.TextMatrix(Contador, Cons_Cod_CartF))
            .Cells(MiFila, Cons_CartFinan + 1) = (Grd_Datos.TextMatrix(Contador, Cons_CartFinan))
            .Cells(MiFila, Cons_Instrumento + 1) = (Grd_Datos.TextMatrix(Contador, Cons_Instrumento))
            .Cells(MiFila, Cons_Cod_Libro + 1) = (Grd_Datos.TextMatrix(Contador, Cons_Cod_Libro))
            .Cells(MiFila, Cons_Libro + 1) = (Grd_Datos.TextMatrix(Contador, Cons_Libro))
            .Cells(MiFila, Cons_Cod_CartS + 1) = (Grd_Datos.TextMatrix(Contador, Cons_Cod_CartS))
            .Cells(MiFila, Cons_CartSuper + 1) = (Grd_Datos.TextMatrix(Contador, Cons_CartSuper))
            .Cells(MiFila, Cons_Fcompra + 1) = CDate(Grd_Datos.TextMatrix(Contador, Cons_Fcompra))
            .Cells(MiFila, Cons_Vpresente + 1) = CDbl(Format((Grd_Datos.TextMatrix(Contador, Cons_Vpresente)), "#,##0.0000"))
            .Cells(MiFila, Cons_Vmercado + 1) = CDbl(Format((Grd_Datos.TextMatrix(Contador, Cons_Vmercado)), "#,##0.0000"))
            .Cells(MiFila, Cons_DifVmercado + 1) = CDbl(Format((Grd_Datos.TextMatrix(Contador, Cons_DifVmercado)), "#,##0.0000"))
            .Cells(MiFila, Cons_TirMercado + 1) = CDbl(Format((Grd_Datos.TextMatrix(Contador, Cons_TirMercado)), "#,##0.0000"))
            .Cells(MiFila, Cons_MonEmision + 1) = (Grd_Datos.TextMatrix(Contador, Cons_MonEmision))
            .Cells(MiFila, Cons_DuraMercado + 1) = CDbl(Format((Grd_Datos.TextMatrix(Contador, Cons_DuraMercado)), "#,##0.0000"))
            .Cells(MiFila, Cons_Convexidad + 1) = CDbl(Format((Grd_Datos.TextMatrix(Contador, Cons_Convexidad)), "#,##0.0000"))
            .Cells(MiFila, Cons_PerEnCart + 1) = ((Grd_Datos.TextMatrix(Contador, Cons_PerEnCart)))
            .Cells(MiFila, Cons_PlazoRes + 1) = ((Grd_Datos.TextMatrix(Contador, Cons_PlazoRes)))
        Next Contador
    End With
  
    Miexcell.Range("A1:A1").Select
    Miexcell.Range(Miexcell.Selection, Miexcell.Selection.End(xlDown)).Select
    Miexcell.Range(Miexcell.Selection, Miexcell.Selection.End(xlToRight)).Select
    Miexcell.Selection.Borders(xlDiagonalDown).LineStyle = xlNone
    Miexcell.Selection.Borders(xlDiagonalUp).LineStyle = xlNone
    
    With Miexcell.Selection.Borders(xlEdgeLeft)
        .LineStyle = xlContinuous
        .Weight = xlThin
        .ColorIndex = xlAutomatic
    End With
    With Miexcell.Selection.Borders(xlEdgeTop)
        .LineStyle = xlContinuous
        .Weight = xlThin
        .ColorIndex = xlAutomatic
    End With
    With Miexcell.Selection.Borders(xlEdgeBottom)
        .LineStyle = xlContinuous
        .Weight = xlThin
        .ColorIndex = xlAutomatic
    End With
    With Miexcell.Selection.Borders(xlEdgeRight)
        .LineStyle = xlContinuous
        .Weight = xlThin
        .ColorIndex = xlAutomatic
    End With
    With Miexcell.Selection.Borders(xlInsideVertical)
        .LineStyle = xlContinuous
        .Weight = xlThin
        .ColorIndex = xlAutomatic
    End With
    With Miexcell.Selection.Borders(xlInsideHorizontal)
        .LineStyle = xlContinuous
        .Weight = xlThin
        .ColorIndex = xlAutomatic
    End With
    
  
   Call MiHoja.Range("A1", "A65536").Select
   Call MiHoja.Cells.EntireColumn.AutoFit
   MiHoja.Cells.Font.Name = "Tahoma"
   MiHoja.Cells.Font.Size = 8
   
   Call MiHoja.Range("B1", "B65536").Select
   Call MiHoja.Cells.EntireColumn.AutoFit
   MiHoja.Cells.Font.Name = "Tahoma"
   MiHoja.Cells.Font.Size = 8
   
   Call MiHoja.Range("C1", "C65536").Select
   Call MiHoja.Cells.EntireColumn.AutoFit
   MiHoja.Cells.Font.Name = "Tahoma"
   MiHoja.Cells.Font.Size = 8
   
   Call MiHoja.Range("D1", "D65536").Select
   Call MiHoja.Cells.EntireColumn.AutoFit
   MiHoja.Cells.Font.Name = "Tahoma"
   MiHoja.Cells.Font.Size = 8
   
   Call BacControlWindows(10)
   Screen.MousePointer = vbDefault
   Miexcell.DisplayAlerts = True
   On Error GoTo ErrorAction
   Command.CancelError = True
   Command.FileName = cFile
   
   Call Command.ShowSave
   
  Miexcell.DisplayAlerts = True
  
'  If Dir(Command.FileName) <> "" Then
'      Call Kill(Command.FileName)
'  End If
   Call MiHoja.SaveAs(Command.FileName)
   
   Screen.MousePointer = vbHourglass
  
  
   'Call MiHoja.SaveAs(Command.FileName)
   
   nFilas = MiHoja.Columns.End(xlDown).Row
   Contador = 2
   For Contador = 2 To nFilas
        Miexcell.Range("G" & Contador).Select
        Miexcell.ActiveCell.FormulaR1C1 = "=RC[2]-RC[1]"
   Next Contador
       
 
   If Respalda = False Then
      Call MsgBox("Proceso Finalizado" & vbCrLf & vbCrLf & "Archivo ha sido almacenado en la ruta : " & vbCrLf & Command.FileName, vbInformation, App.Title)
   End If
     
   Miexcell.Visible = True
  
   Set MiSheet = Nothing
   Set MiHoja = Nothing
   Set MiLibro = Nothing
   Set Miexcell = Nothing
   
  'Call MiLibro.Close
   
   Let Screen.MousePointer = vbDefault
   On Error GoTo 0

Exit Sub
ErrorAction:
   Screen.MousePointer = vbDefault
   
 If err.Number = 32755 Then
      Set MiSheet = Nothing
      Set MiHoja = Nothing
     'Call MiLibro.Close
      Set MiLibro = Nothing
      Set Miexcell = Nothing
 Else
   
   If err.Number = 70 Then
            
        Miexcell.Application.DisplayAlerts = False
        'Cerramos Excel
        Call Miexcell.Application.Workbooks.Close
        Miexcell.Application.Quit
        If MsgBox("Error de Escritura..." & vbCrLf & "Archivo se encuentra protegido contra escritura o bien esta en uso ... Reintentar ?", vbQuestion + vbYesNo, App.Title) = vbYes Then
            
            Resume
        Else
            Respalda = True
            'Command.FileName = "C:\Archivos de programa\MiExcel.Xls"
            Exit Sub
            Resume
            Exit Sub
        End If
    End If
       If err.Number = 1004 Then
        If MsgBox("Error de Escritura..." & vbCrLf & "Archivo existe, se encuentra protegido contra escritura o bien esta en uso ... Reintentar ?", vbQuestion + vbYesNo, App.Title) = vbYes Then
            
            Resume
        Else
            Respalda = True
            'Command.FileName = "C:\Archivos de programa\MiExcel.Xls"
            Miexcell.Application.DisplayAlerts = False
            MiLibro.Application.Workbooks.Close
            Miexcell.Application.Quit
            Screen.MousePointer = vbdefaul
            'Resume
            Exit Sub
        End If
             
       End If
      
      If err.Number <> 0 Then
         Call MsgBox("Error en la carga de archivo" & vbCrLf & vbCrLf & err.Description, vbExclamation, App.Title)
         Screen.MousePointer = vbDefault
      End If
   End If

End Sub


Private Sub Proc_Leer_Datos_Grilla()
    Dim DATOS() As Variant
    Dim CartF As String
    Grd_Datos.Rows = 1
    Envia = Array()
    AddParam Envia, "CP"
    AddParam Envia, GLB_CARTERA
    AddParam Envia, GLB_ID_SISTEMA
    AddParam Envia, ""
    AddParam Envia, gsBac_User

    If Not Bac_Sql_Execute("SP_CONCARTBOOKEAR", Envia) Then
        Screen.MousePointer = vbDefault
        MsgBox "Ha ocurrido un error al intentar leer la parametrización", vbCritical + vbOKOnly, TITSISTEMA
        Exit Sub
    End If

    With Grd_Datos
        Do While Bac_SQL_Fetch(DATOS())
            CartF = (DATOS(1))
        Loop
    End With
 
     
     Envia = Array()
     AddParam Envia, 2
     AddParam Envia, CartF
     
    If Not Bac_Sql_Execute("SP_CARGACARTERAPARABLOQUEOPACTO", Envia) Then
        Screen.MousePointer = vbDefault
        MsgBox "Ha ocurrido un error al intentar leer la parametrización", vbCritical + vbOKOnly, TITSISTEMA
        Exit Sub
    End If

    With Grd_Datos
        Do While Bac_SQL_Fetch(DATOS())
            .Rows = .Rows + 1
            .TextMatrix(.Rows - 1, Cons_Emisor) = IIf(IsNull(DATOS(1)), "", (DATOS(1)))
            .TextMatrix(.Rows - 1, Cons_Serie) = IIf(IsNull(DATOS(2)), "", (DATOS(2)))
            .TextMatrix(.Rows - 1, Cons_Origen) = IIf(IsNull(DATOS(3)), "", (DATOS(3)))
            .TextMatrix(.Rows - 1, Cons_Compra) = IIf(IsNull(DATOS(4)), "", (DATOS(4)))
            .TextMatrix(.Rows - 1, Cons_Correlativo) = IIf(IsNull(DATOS(5)), "", (DATOS(5)))
            .TextMatrix(.Rows - 1, Cons_Ncompra) = IIf(IsNull(DATOS(6)), "", (DATOS(6)))
            .TextMatrix(.Rows - 1, Cons_Nominal) = IIf(IsNull(DATOS(7)), 0, Format(CDbl(DATOS(7)), "#,##0.0000"))
            .TextMatrix(.Rows - 1, Cons_Bloqueado) = IIf(IsNull(DATOS(8)), 0, Format(CDbl(DATOS(8)), "#,##0.0000"))
            .TextMatrix(.Rows - 1, Cons_Tnominal) = IIf(IsNull(DATOS(9)), "", Format(CDbl(DATOS(9)), "#,##0.0000"))
            .TextMatrix(.Rows - 1, Cons_NenPacto) = IIf(IsNull(DATOS(10)), 0, Format(CDbl(DATOS(10)), "#,##0"))
            .TextMatrix(.Rows - 1, Cons_Cminimo) = IIf(IsNull(DATOS(11)), 0, Format(CDbl(DATOS(11)), "#,##0.0000"))
            .TextMatrix(.Rows - 1, Cons_Tcompra) = IIf(IsNull(DATOS(12)), 0, Format((DATOS(12)), "#,##0.0000"))
            .TextMatrix(.Rows - 1, Cons_Cod_CartF) = IIf(IsNull(DATOS(13)), "", (DATOS(13)))
            .TextMatrix(.Rows - 1, Cons_CartFinan) = IIf(IsNull(DATOS(14)), "", (DATOS(14)))
            .TextMatrix(.Rows - 1, Cons_Instrumento) = IIf(IsNull(DATOS(15)), "", (DATOS(15)))
            .TextMatrix(.Rows - 1, Cons_Cod_Libro) = IIf(IsNull(DATOS(16)), "", (DATOS(16)))
            .TextMatrix(.Rows - 1, Cons_Libro) = IIf(IsNull(DATOS(17)), "", (DATOS(17)))
            .TextMatrix(.Rows - 1, Cons_Cod_CartS) = IIf(IsNull(DATOS(18)), "", (DATOS(18)))
            .TextMatrix(.Rows - 1, Cons_CartSuper) = IIf(IsNull(DATOS(19)), "", (DATOS(19)))
            .TextMatrix(.Rows - 1, Cons_Fcompra) = IIf(IsNull(DATOS(20)), "", (DATOS(20)))
            .TextMatrix(.Rows - 1, Cons_Vpresente) = IIf(IsNull(DATOS(21)), "", Format(CDbl(DATOS(21)), "#,##0.0000"))
            .TextMatrix(.Rows - 1, Cons_Vmercado) = IIf(IsNull(DATOS(22)), "", Format(CDbl(DATOS(22)), "#,##0.0000"))
            .TextMatrix(.Rows - 1, Cons_DifVmercado) = IIf(IsNull(DATOS(23)), "", Format(CDbl(DATOS(23)), "#,##0.0000"))
            .TextMatrix(.Rows - 1, Cons_TirMercado) = IIf(IsNull(DATOS(24)), "", Format((DATOS(24)), "#,##0.0000"))
            .TextMatrix(.Rows - 1, Cons_MonEmision) = IIf(IsNull(DATOS(25)), "", (DATOS(25)))
            .TextMatrix(.Rows - 1, Cons_DuraMercado) = IIf(IsNull(DATOS(26)), "", (DATOS(26)))
            .TextMatrix(.Rows - 1, Cons_Convexidad) = IIf(IsNull(DATOS(27)), "", (DATOS(27)))
            .TextMatrix(.Rows - 1, Cons_PerEnCart) = IIf(IsNull(DATOS(28)), "", (DATOS(28)))
            .TextMatrix(.Rows - 1, Cons_PlazoRes) = IIf(IsNull(DATOS(29)), "", (DATOS(29)))
    
            .Row = .Rows - 1
        Loop
                    
        If .Rows > 1 Then
           .AllowUserResizing = flexResizeColumns
        Else
           .AllowUserResizing = flexResizeNone
        End If
    End With

End Sub


Private Sub Proc_SeteaGrilla()
 Dim nContador  As Long
   With Grd_Datos
      .ColWidth(Cons_Emisor) = 0
      .ColWidth(Cons_Serie) = 1200
      .ColWidth(Cons_Origen) = 0
      .ColWidth(Cons_Compra) = 0
      .ColWidth(Cons_Correlativo) = 0
      .ColWidth(Cons_Ncompra) = 1000
      .ColWidth(Cons_Nominal) = 1800
      .ColWidth(Cons_Bloqueado) = 1800
      .ColWidth(Cons_Tnominal) = 0
      .ColWidth(Cons_NenPacto) = 0
      .ColWidth(Cons_Cminimo) = 0
      .ColWidth(Cons_Tcompra) = 1200
      .ColWidth(Cons_Cod_CartF) = 0
      .ColWidth(Cons_CartFinan) = 1800
      .ColWidth(Cons_Instrumento) = 0
      .ColWidth(Cons_Cod_Libro) = 0
      .ColWidth(Cons_Libro) = 0
      .ColWidth(Cons_Cod_CartS) = 0
      .ColWidth(Cons_CartSuper) = 0
      .ColWidth(Cons_Fcompra) = 0
      .ColWidth(Cons_Vpresente) = 0
      .ColWidth(Cons_Vmercado) = 0
      .ColWidth(Cons_DifVmercado) = 0
      .ColWidth(Cons_TirMercado) = 0
      .ColWidth(Cons_MonEmision) = 0
      .ColWidth(Cons_DuraMercado) = 0
      .ColWidth(Cons_Convexidad) = 0
      .ColWidth(Cons_PerEnCart) = 0
      .ColWidth(Cons_PlazoRes) = 0
      
      
      .TextMatrix(0, Cons_Emisor) = "Emisor"
      .TextMatrix(0, Cons_Serie) = "Serie"
      .TextMatrix(0, Cons_Origen) = "Origen"
      .TextMatrix(0, Cons_Compra) = "Numero Compra"
      .TextMatrix(0, Cons_Correlativo) = "Correlativo"
      .TextMatrix(0, Cons_Ncompra) = "Compra"
      .TextMatrix(0, Cons_Nominal) = "Nominal"
      .TextMatrix(0, Cons_Bloqueado) = "Bloqueado"
      .TextMatrix(0, Cons_Tnominal) = "Total Nominal"
      .TextMatrix(0, Cons_NenPacto) = "Nom en Pacto"
      .TextMatrix(0, Cons_Cminimo) = "Corte Minimo"
      .TextMatrix(0, Cons_Tcompra) = "Tir de Compra"
      .TextMatrix(0, Cons_Cod_CartF) = "Cod CartF"
      .TextMatrix(0, Cons_CartFinan) = "Cart. Financiera"
      .TextMatrix(0, Cons_Instrumento) = "Instrumento"
      .TextMatrix(0, Cons_Cod_Libro) = "Cod Libro"
      .TextMatrix(0, Cons_Libro) = "Libro"
      .TextMatrix(0, Cons_Cod_CartS) = "Cod CartS"
      .TextMatrix(0, Cons_CartSuper) = "Cart. Super"
      .TextMatrix(0, Cons_Fcompra) = "Fecha Compra"
      .TextMatrix(0, Cons_Vpresente) = "Valor Presente"
      .TextMatrix(0, Cons_Vmercado) = "Valor Mercado"
      .TextMatrix(0, Cons_DifVmercado) = "Dif.Val Mercado"
      .TextMatrix(0, Cons_TirMercado) = "Tir de Mercado"
      .TextMatrix(0, Cons_MonEmision) = "Moneda Emisión"
      .TextMatrix(0, Cons_DuraMercado) = "Duración Mod"
      .TextMatrix(0, Cons_Convexidad) = "Convexidad"
      .TextMatrix(0, Cons_PerEnCart) = "Per.en Cartera"
      .TextMatrix(0, Cons_PlazoRes) = "Plazo Res."
      
      
      
        .RowHeight(0) = 600
        
        For nContador = 0 To .cols - 1
            .Row = 0
            .Col = nContador
            .TextStyle = TextStyleHeader
            .CellAlignment = flexAlignCenterCenter
            .WordWrap = True
        Next nContador
        
   End With

End Sub
    
Private Sub Form_Load()
    Me.Icon = BacTrader.Icon
    Me.Move 1, 1
    
'    If BacTrader.Opc_60105 Then
'        Me.Toolbar1.Buttons(2).Enabled = False
'    End If
    
    
    Grd_Datos.Rows = 2
    Grd_Datos.FixedRows = 1
    Grd_Datos.Rows = 1
    
    Call Proc_SeteaGrilla
    Call Proc_Leer_Datos_Grilla
    
    
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
    Select Case (Button.Key)
        Case "Filtro"
            Call Proc_Filtra
             
             If Grd_Datos.Rows > 1 Then
                Grd_Datos.AllowUserResizing = flexResizeColumns
             Else
                Grd_Datos.AllowUserResizing = flexResizeNone
             End If
        
        Case "CargaExcel"
        
            Call Proc_Carga_Excel
            Call Proc_Leer_Datos_Grilla
        Case "Excel"
            Call Proc_Genera_Excel
         
        Case "Salir"
           Unload Me
           Exit Sub
    End Select
End Sub


