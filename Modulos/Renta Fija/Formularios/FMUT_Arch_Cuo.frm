VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "comdlg32.ocx"
Begin VB.Form FMUT_Arch_Cuo 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Archivo Cuotas Fondos Mutuos"
   ClientHeight    =   3855
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   4575
   DrawWidth       =   2
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   NegotiateMenus  =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   3855
   ScaleWidth      =   4575
   Visible         =   0   'False
   Begin VB.CommandButton Command2 
      Caption         =   "Captura Archivo"
      Height          =   495
      Left            =   1080
      TabIndex        =   2
      Top             =   2160
      Width           =   2175
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Generacion Archivo"
      Height          =   495
      Left            =   1080
      TabIndex        =   0
      Top             =   840
      Width           =   2175
   End
   Begin MSComDlg.CommonDialog Cdd_Dialogo 
      Left            =   4080
      Top             =   0
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   3240
      Top             =   0
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   16777215
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   1
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FMUT_Arch_Cuo.frx":0000
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Height          =   510
      Left            =   0
      TabIndex        =   1
      Top             =   0
      Width           =   6165
      _ExtentX        =   10874
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   1
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Description     =   "Salir"
            ImageIndex      =   1
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin MSComctlLib.ProgressBar Progress 
      Height          =   405
      Left            =   360
      TabIndex        =   3
      Top             =   1440
      Width           =   3645
      _ExtentX        =   6429
      _ExtentY        =   714
      _Version        =   393216
      Appearance      =   1
   End
   Begin MSComctlLib.ProgressBar Progress2 
      Height          =   405
      Left            =   360
      TabIndex        =   4
      Top             =   2760
      Width           =   3645
      _ExtentX        =   6429
      _ExtentY        =   714
      _Version        =   393216
      Appearance      =   1
   End
   Begin Threed.SSPanel Pnl_Avance 
      Height          =   405
      Left            =   360
      TabIndex        =   5
      Top             =   0
      Width           =   3675
      _Version        =   65536
      _ExtentX        =   6482
      _ExtentY        =   714
      _StockProps     =   15
      ForeColor       =   -2147483634
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BorderWidth     =   1
      BevelOuter      =   1
      BevelInner      =   2
      RoundedCorners  =   0   'False
      FloodType       =   1
      FloodColor      =   -2147483635
   End
End
Attribute VB_Name = "FMUT_Arch_Cuo"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub Command1_Click()
    On Error GoTo Sale
    Dim T_Str_Dir_Archivo   As String
    Dim i                   As Double
    Dim T_Dbl_MiLinea       As Double
    Dim T_Str_Periodo       As String
    Dim Datos()
    Dim mensaje_sal         As String
    Dim ObjExcel            As New EXCEL.Application  'CreateObject("Excel.Application")
    Dim ObjLibro            As Object
    Dim ObjHoja             As Object
    Dim j                   As Integer
    Dim nom_arch            As String
    
    Screen.MousePointer = 11
    
    ObjExcel.Visible = False
    Set ObjLibro = ObjExcel.Application.Workbooks.Add.Sheets.Add 'ObjExcel.Workbooks.Add
    Set ObjHoja = ObjExcel.ActiveSheet 'ObjExcel.ActiveWorkbook.ActiveSheet
    
   'With ObjHoja
    
   ' ObjHoja.Cells(1, 1) = "Rut Administradora"
   ' ObjHoja.Cells(1, 2) = "Codigo Administradora"
   ' ObjHoja.Cells(1, 3) = "Nombre Administradora"
   ' ObjHoja.Cells(1, 4) = "Instrumento (FMUTUOCLP/FMUTUOUSD)"
   ' ObjHoja.Cells(1, 5) = "Fecha Vencimiento"
   ' ObjHoja.Cells(1, 6) = "Cuotas"
   ' ObjHoja.Cells(1, 7) = "Precio Cuota"
        
    ObjHoja.Cells(1, 1) = "Documento"
    ObjHoja.Cells(1, 2) = "Correlativo"

    ObjHoja.Cells(1, 3) = "Rut Administradora"
    ObjHoja.Cells(1, 4) = "Codigo Administradora"
    ObjHoja.Cells(1, 5) = "Nombre Administradora"
    ObjHoja.Cells(1, 6) = "Instrumento (FMUTUOCLP/FMUTUOUSD)"
    ObjHoja.Cells(1, 7) = "Fecha Vencimiento"
    ObjHoja.Cells(1, 8) = "Cuotas"
    ObjHoja.Cells(1, 9) = "Precio Cuota"
    
    ObjHoja.Cells(1, 10) = "Cliente"
        
    Envia = Array(gsBac_Fecp)
    If Not Bac_Sql_Execute("dbo.SP_CONSULTA_CUOTASFM", Envia) Then
        Exit Sub
    End If
    
    j = 5

    T_Dbl_MiLinea = 2
    
    Do While Bac_SQL_Fetch(Datos())
    
       ' ObjHoja.Cells(T_Dbl_MiLinea, 1) = " " & (Datos(1) & "-" & Datos(2))
       ' ObjHoja.Cells(T_Dbl_MiLinea, 2) = Datos(3)
       ' ObjHoja.Cells(T_Dbl_MiLinea, 3) = Datos(4)
       ' ObjHoja.Cells(T_Dbl_MiLinea, 4) = Datos(5)
       ' ObjHoja.Cells(T_Dbl_MiLinea, 5) = CDate(Datos(6))
       ' ObjHoja.Cells(T_Dbl_MiLinea, 6) = CDbl(Datos(7))

        ObjHoja.Cells(T_Dbl_MiLinea, 1) = Datos(9)
        ObjHoja.Cells(T_Dbl_MiLinea, 2) = Datos(10)
        
        ObjHoja.Cells(T_Dbl_MiLinea, 3) = " " & (Datos(1) & "-" & Datos(2))
        ObjHoja.Cells(T_Dbl_MiLinea, 4) = Datos(3)
        ObjHoja.Cells(T_Dbl_MiLinea, 5) = Datos(4)
        ObjHoja.Cells(T_Dbl_MiLinea, 6) = Datos(5)
        ObjHoja.Cells(T_Dbl_MiLinea, 7) = CDate(Datos(6))
        ObjHoja.Cells(T_Dbl_MiLinea, 8) = CDbl(Datos(7))

        ObjHoja.Cells(T_Dbl_MiLinea, 10) = Datos(11)

        T_Dbl_MiLinea = T_Dbl_MiLinea + 1
            
        Progress.Value = IIf(j > 99, 100, j)
          
        j = j + 1
    Loop

   'End With

    
    T_Str_Dir_Archivo = ArchFM_in ' & Mid(CDate(gsBac_Fecp), 7, 4) & Mid(CDate(gsBac_Fecp), 4, 2) & Mid(CDate(gsBac_Fecp), 1, 2) & "_FMUTUO" & ".xls"
    
    T_Str_Dir_Archivo = Replace(ArchFM_in, "yyyymmdd", Format(CDate(gsBac_Fecp), "yyyymmdd"))
    
    ObjLibro.SaveAs T_Str_Dir_Archivo
    
    Progress.Value = 100
    
    'Cerramos el Archivo
    ObjLibro.Application.Workbooks.Close
    ObjExcel.Quit
    
    Set ObjLibro = Nothing
    Set ObjExcel = Nothing
    Set ObjHoja = Nothing
    
    Screen.MousePointer = Default
    
    MsgBox "Archivo Excels Generado : " & T_Str_Dir_Archivo, vbInformation, gsBac_Version
    Progress.Value = 0
    
    On Error GoTo 0
    
Exit Sub
Sale:
    On Error Resume Next
    
    Set ObjLibro = Nothing
    Set ObjExcel = Nothing
    Set ObjHoja = Nothing
    
    On Error GoTo 0
    Exit Sub
End Sub

Private Sub Command2_Click()
   On Error GoTo Sale
    Dim T_Row_Excel         As Integer
    Dim ObjExcel            As Object
    Dim ObjLibro            As Object
    Dim T_Str_Hoja          As String
    Dim T_Int_Celda         As Integer
    Dim T_Ins_Mes_Inicial   As String
    Dim T_Str_FechaInicial  As Date
    Dim j                   As Integer
    Dim ireg                As Integer
    Dim ireg0               As Integer
    Dim T_Str_Dir_Archivo   As String
    Dim mensaje_sal         As String
    Dim iRut                As Long
    Dim iCodigo             As Long
    Dim cInstrumento        As String
    Dim dFecha              As Date
    Dim nCuotas             As Double
    Dim nPrecio             As Double
    Dim iCodigoCliente      As Integer
    
    Dim nDocumento          As Long
    Dim nCorrelativo        As Long

    T_Str_Dir_Archivo = ArchFM_out
    T_Str_Dir_Archivo = Replace(ArchFM_out, "yyyymmdd", Format(CDate(gsBac_Fecp), "yyyymmdd"))

    If Dir(T_Str_Dir_Archivo) = "" Then
        MsgBox "No Existe archivo: " & T_Str_Dir_Archivo, 64, Me.Caption
        Exit Sub
    Else
        If UCase(Mid(T_Str_Dir_Archivo, (Len(T_Str_Dir_Archivo) - 3), 4)) <> ".XLS" Then
            MsgBox "El Archivo Seleccionado no corresponde a un Archivo Excel", 64, Me.Caption
            Exit Sub
        Else
            Screen.MousePointer = 11

            On Error GoTo ErrorExcel
            Set ObjExcel = CreateObject("Excel.Application")
            Set ObjLibro = ObjExcel.Workbooks.Open(T_Str_Dir_Archivo)
            
            ireg = 0
            ireg0 = 0
            j = 5

            If Not Bac_Sql_Execute("BEGIN TRANSACTION") Then
                GoTo BacErrorHandler
            End If

            For T_Int_Celda = 2 To T_Row_Excel + 10000

               'If ObjLibro.Worksheets(1).Cells(T_Int_Celda, 1) = "" Then
                If ObjLibro.Worksheets(1).Cells(T_Int_Celda, 3) = "" Then
                    Exit For
                End If

               ' Let iRut = Left(ObjLibro.Worksheets(1).Cells(T_Int_Celda, 1), Len(ObjLibro.Worksheets(1).Cells(T_Int_Celda, 1)) - 2)
               ' Let iCodigo = ObjLibro.Worksheets(1).Cells(T_Int_Celda, 2)
               ' Let cInstrumento = ObjLibro.Worksheets(1).Cells(T_Int_Celda, 4)
               ' Let dFecha = ObjLibro.Worksheets(1).Cells(T_Int_Celda, 5)
               ' Let nCuotas = CDbl(ObjLibro.Worksheets(1).Cells(T_Int_Celda, 6))
               ' Let nPrecio = CDbl(ObjLibro.Worksheets(1).Cells(T_Int_Celda, 7))
               ' Let iCodigoCliente = ObjLibro.Worksheets(1).Cells(T_Int_Celda, 2)


                    Let nDocumento = ObjLibro.Worksheets(1).Cells(T_Int_Celda, 1)
                  Let nCorrelativo = ObjLibro.Worksheets(1).Cells(T_Int_Celda, 2)

                          Let iRut = Left(ObjLibro.Worksheets(1).Cells(T_Int_Celda, 3), Len(ObjLibro.Worksheets(1).Cells(T_Int_Celda, 3)) - 2)
                       Let iCodigo = ObjLibro.Worksheets(1).Cells(T_Int_Celda, 4)
                  Let cInstrumento = ObjLibro.Worksheets(1).Cells(T_Int_Celda, 6)
                        Let dFecha = ObjLibro.Worksheets(1).Cells(T_Int_Celda, 7)
                       Let nCuotas = CDbl(ObjLibro.Worksheets(1).Cells(T_Int_Celda, 8))
                       Let nPrecio = CDbl(ObjLibro.Worksheets(1).Cells(T_Int_Celda, 9))
                Let iCodigoCliente = ObjLibro.Worksheets(1).Cells(T_Int_Celda, 4)


               'If Val(ObjLibro.Worksheets(1).Cells(T_Int_Celda, 7)) = 0 Then
                If Val(ObjLibro.Worksheets(1).Cells(T_Int_Celda, 8)) = 0 Then
                    ireg0 = ireg0 + 1
                End If

                Envia = Array()
                AddParam Envia, iRut         '--> ObjLibro.Worksheets(1).Cells(T_Int_Celda, 1)
                AddParam Envia, iCodigo      '--> ObjLibro.Worksheets(1).Cells(T_Int_Celda, 2)
                AddParam Envia, cInstrumento '--> ObjLibro.Worksheets(1).Cells(T_Int_Celda, 4)
                AddParam Envia, dFecha       '--> ObjLibro.Worksheets(1).Cells(T_Int_Celda, 5)
                AddParam Envia, nCuotas      '--> CDbl(ObjLibro.Worksheets(1).Cells(T_Int_Celda, 6))
                AddParam Envia, nPrecio      '--> CDbl(ObjLibro.Worksheets(1).Cells(T_Int_Celda, 7))
                AddParam Envia, iCodigoCliente

                AddParam Envia, nDocumento
                AddParam Envia, nCorrelativo
                
                If Not Bac_Sql_Execute("SP_GRABAR_PRECIO_CUO_FM", Envia) Then
                    MsgBox "Problemas al tratar de cargar Archivo Excel", 64, Me.Caption
                    Exit Sub
                Else
                    ireg = ireg + 1
                End If
                Progress2.Value = IIf(j > 99, 100, j)
                j = j + 1
            Next

            Progress2.Value = 100

            If ireg0 = ireg And ireg0 > 0 Then
                MsgBox "Captura no Realizada Fondos sin Precios, proceso de valorizacion no podrá realizarse", 64, Me.Caption
                GoTo BacErrorHandler
            Else
                If ireg0 > 0 Then
                    If MsgBox("Captura Realizada Fondos sin Precios, desea continuar", vbQuestion + vbYesNo, gsBac_Version) <> vbYes Then
                        GoTo BacErrorHandler
                    End If
                End If
            End If
            
            mensaje_sal = ""
            mensaje_sal = mensaje_sal & "Registros Cargados con exito " & Chr(10) & Chr(13)
            mensaje_sal = mensaje_sal & Chr(10) & Chr(13)
            mensaje_sal = mensaje_sal & "Cantidad de registros cargados : " & ireg & Chr(10) & Chr(13)
            mensaje_sal = mensaje_sal & Chr(10) & Chr(13)
            mensaje_sal = mensaje_sal & "Cantidad de registros Precio = 0.0 : " & ireg0 & Chr(10) & Chr(13)
            MsgBox mensaje_sal, vbInformation, gsBac_Version
            Progress2.Value = 0
            
            If Not Bac_Sql_Execute("COMMIT TRANSACTION") Then
                GoTo BacErrorHandler
            End If
            
            'Cerramos el Archivo
            ObjLibro.Close
            ObjExcel.Quit
            Set ObjExcel = Nothing
            'Fin Proceso

        End If
    End If
    
    
    Screen.MousePointer = Default
    Exit Sub
    
ErrorExcel:
    MsgBox "Problemas con el Archivo Excel. Verifique que el Archivo sea correcto, tenga 1 Hoja llamada 'Creditos' y que la Información sea Correcta y luego vuelva a Intentar", 64
    ObjLibro.Close
    ObjExcel.Quit
    Set ObjExcel = Nothing
    Screen.MousePointer = Default
    Exit Sub
Sale:
    Screen.MousePointer = Default
    ObjLibro.Close
    ObjExcel.Quit
    Set ObjExcel = Nothing
    Exit Sub

BacErrorHandler:
    If Not Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
            MsgBox " NO SE PUDO REALIZAR ROLLBACK", vbExclamation, gsBac_Version
    End If
    ObjLibro.Close
    ObjExcel.Quit
    Set ObjExcel = Nothing
    Screen.MousePointer = Default
    
    Exit Sub
    
End Sub

Private Sub Form_Load()
   
   Me.Top = 0: Me.Left = 0
   Screen.MousePointer = vbHourglass
   
   Toolbar1.Buttons(1).Visible = True
   Toolbar1.Buttons(1).Enabled = True
   
   Screen.MousePointer = 0

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

   Select Case UCase(Button.Description)
   Case "ANULAR"
 '     Call Func_Anular

   Case "LIMPIAR"
  '    Call Func_Limpiar_Pantalla

   Case "SALIR"
      Unload Me

   End Select

End Sub

