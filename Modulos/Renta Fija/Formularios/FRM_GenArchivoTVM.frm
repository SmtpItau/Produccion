VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form frmGenArchivoTVM 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Interfaz de Inversiones"
   ClientHeight    =   5235
   ClientLeft      =   45
   ClientTop       =   2160
   ClientWidth     =   11655
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   5235
   ScaleMode       =   0  'User
   ScaleWidth      =   11655
   Begin Threed.SSFrame SSFrame1 
      Height          =   1455
      Left            =   2280
      TabIndex        =   2
      Top             =   2280
      Visible         =   0   'False
      Width           =   6855
      _Version        =   65536
      _ExtentX        =   12091
      _ExtentY        =   2566
      _StockProps     =   14
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Alignment       =   2
      ShadowStyle     =   1
      Begin MSComctlLib.ProgressBar ProgressBar1 
         Height          =   375
         Left            =   1680
         TabIndex        =   3
         Top             =   300
         Width           =   4935
         _ExtentX        =   8705
         _ExtentY        =   661
         _Version        =   393216
         Appearance      =   1
      End
      Begin MSComctlLib.ProgressBar ProgressBar2 
         Height          =   375
         Left            =   1680
         TabIndex        =   6
         Top             =   840
         Width           =   4935
         _ExtentX        =   8705
         _ExtentY        =   661
         _Version        =   393216
         Appearance      =   1
      End
      Begin VB.Label Label2 
         Caption         =   "Archivo Excel"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   240
         TabIndex        =   5
         Top             =   960
         Width           =   1215
      End
      Begin VB.Label Label1 
         Caption         =   "Archivo .TXT"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   0
         TabIndex        =   4
         Top             =   3240
         Width           =   1215
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   600
      Left            =   0
      TabIndex        =   1
      Top             =   0
      Width           =   11655
      _ExtentX        =   20558
      _ExtentY        =   1058
      ButtonWidth     =   1032
      ButtonHeight    =   1005
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Exportar"
            Object.ToolTipText     =   "Exportar a Excel"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Buscar"
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   4320
         Top             =   0
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   32
         ImageHeight     =   32
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   3
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_GenArchivoTVM.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_GenArchivoTVM.frx":0EDA
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_GenArchivoTVM.frx":11F4
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin MSFlexGridLib.MSFlexGrid MsGrdInv 
      Height          =   4215
      Left            =   0
      TabIndex        =   0
      Top             =   1020
      Width           =   11655
      _ExtentX        =   20558
      _ExtentY        =   7435
      _Version        =   393216
      Cols            =   58
      FixedCols       =   0
      BackColor       =   -2147483644
      ForeColor       =   12582912
      BackColorFixed  =   8421376
      ForeColorFixed  =   16777215
      BackColorBkg    =   12632256
      FocusRect       =   0
      GridLines       =   2
   End
   Begin BACControles.TXTFecha txtFecha1 
      Height          =   255
      Left            =   1560
      TabIndex        =   7
      Top             =   720
      Width           =   1335
      _ExtentX        =   2355
      _ExtentY        =   450
      Enabled         =   -1  'True
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
      MaxDate         =   2958465
      MinDate         =   -328716
      Text            =   "24/07/2001"
   End
   Begin VB.Label Label3 
      Caption         =   "Fecha Generacion"
      Height          =   255
      Left            =   120
      TabIndex        =   8
      Top             =   720
      Width           =   1335
   End
End
Attribute VB_Name = "frmGenArchivoTVM"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private dFech2  As Date
Private dFech1  As Date
Private cFecCal As String
Private cruta   As String
Private sNombre As String
Private cruta_II   As String
Private sNombre_II As String

Private aLet(256) As String


Sub pExpCon(GRILLA As MSFlexGrid, Titulo As String)
'   DESCRIPCIÓN         : EXPORTA A PLANILLA EXCEL

Dim Fila As Integer
Dim objws As Object
Dim Col As Long
Dim Row As Long
Dim Colum As Long
Dim SomeArray() As String

   Call mIniNomCol

   If GRILLA.Visible = False Then Exit Sub
   If GRILLA.Rows <= 1 Then

      Beep
      MsgBox "No hay datos para exportar a Excel", vbCritical, App.ProductName
      Exit Sub
   End If

   On Error GoTo Error
   Fila = 6 ' Fila inicio

   ReDim SomeArray(GRILLA.Rows, 37)

   ' Copia grilla a un arreglo
   nCont = 0
   With GRILLA
      ProgressBar2.Min = 0
      ProgressBar2.Value = 0
      ProgressBar2.Max = .Rows - 1

      For Row = 0 To GRILLA.Rows - 1

         Colum = 0

         For Col = 0 To 36 '.Cols - 1

            If .ColWidth(Col) > 0 And Trim(.TextMatrix(0, Col)) <> "" Then
                If Colum = 8 Then
                    SomeArray(Row, Colum) = Replace(Format(.TextMatrix(Row, Col), "0.00"), ",", ".")
                Else
                    SomeArray(Row, Colum) = .TextMatrix(Row, Col)
                End If
               Colum = Colum + 1
            End If

         Next
         SomeArray(Row, 37) = .TextMatrix(Row, 52)
         
         ProgressBar2.Value = nCont
         nCont = nCont + 1
      Next
   End With

   Screen.MousePointer = vbHourglass
   Set objws = CreateObject("Excel.Application")
   objws.Workbooks.Add

   ' Pega los datos en Excel
   objws.Range(objws.Cells(Fila, 1), objws.Cells(Fila + GRILLA.Rows, Colum + 1)).Value = SomeArray

   With objws
      .Cells.Select
      .Cells.EntireColumn.AutoFit
      .Cells.EntireRow.AutoFit
      .Range("A" & Fila & ":" & aLet(Colum + 1) & Fila).Select
      .Selection.Interior.ColorIndex = 6
      .Range("A1").Select
       .ActiveCell.FormulaR1C1 = Mid$(gsBac_Clien, 1, 30)

       .Range("A2").Select

       .ActiveCell.FormulaR1C1 = "Fecha Exportación: " & Format(Now, "DD/MM/YYYY")
       .Selection.EntireColumn.AutoFit

       .Range("A4").Select

       .ActiveCell.FormulaR1C1 = "Hora Exportación: " & Format(Now, "HH:MM")

       .Range("c2").Select



       .ActiveCell.FormulaR1C1 = Titulo

        If Dir(cruta + sNombre + Format(Me.txtFecha1.text, "yyyymmdd") + ".XLS") <> "" Then
          Kill cruta + sNombre + Format(Me.txtFecha1.text, "yyyymmdd") + ".XLS"
        End If

        .ActiveWorkbook.SaveAs FileName:= _
        (cruta + sNombre + Format(Me.txtFecha1.text, "yyyymmdd") + ".XLS"), FileFormat:= _
        xlNormal, Password:="", WriteResPassword:="", ReadOnlyRecommended:=False _
        , CreateBackup:=False

        .ActiveWorkbook.Close
   End With

   Set objws = Nothing

   Exit Sub

Error:

   Beep

   Screen.MousePointer = vbDefault

   MsgBox "Imposible Realizar Exportación", vbCritical, App.ProductName

   Set objws = Nothing

   Exit Sub

End Sub


Sub pExpCon_II(GRILLA As MSFlexGrid, Titulo As String)


Dim Fila As Integer
Dim objws As Object
Dim Col As Long
Dim Row As Long
Dim Colum As Long
Dim SomeArray() As String

   Call mIniNomCol

   If GRILLA.Visible = False Then Exit Sub
   If GRILLA.Rows <= 1 Then
      Beep
      MsgBox "No hay datos para exportar a Excel", vbCritical, App.ProductName
      Exit Sub
   End If
   On Error GoTo Error
   Fila = 6 ' Fila inicio

   ReDim SomeArray(GRILLA.Rows, 21)

   ' Copia grilla a un arreglo
   nCont = 0
   With GRILLA
      ProgressBar2.Min = 0
      ProgressBar2.Value = 0
      ProgressBar2.Max = .Rows - 1

      For Row = 0 To GRILLA.Rows - 1
         Colum = 0
         For Col = 37 To 57
            If .ColWidth(Col) > 0 And Trim(.TextMatrix(0, Col)) <> "" Then
               SomeArray(Row, Colum) = .TextMatrix(Row, Col)
               Colum = Colum + 1
            End If
         Next
         ProgressBar2.Value = nCont
         nCont = nCont + 1
      Next

   End With

   Screen.MousePointer = vbHourglass
   Set objws = CreateObject("Excel.Application")
   objws.Workbooks.Add


   ' Pega los datos en Excel

   objws.Range(objws.Cells(Fila, 1), objws.Cells(Fila + GRILLA.Rows, Colum)).Value = SomeArray
   With objws
      .Cells.Select
      .Cells.EntireColumn.AutoFit
      .Cells.EntireRow.AutoFit
      .Range("A" & Fila & ":" & aLet(Colum) & Fila).Select
      .Selection.Interior.ColorIndex = 6
      .Range("A1").Select

       .ActiveCell.FormulaR1C1 = Mid$(gsBac_Clien, 1, 30)

       .Range("A2").Select

       .ActiveCell.FormulaR1C1 = "Fecha Exportación: " & Format(Now, "DD/MM/YYYY")
       .Selection.EntireColumn.AutoFit
       .Range("A4").Select
       .ActiveCell.FormulaR1C1 = "Hora Exportación: " & Format(Now, "HH:MM")
       .Range("c2").Select

       .ActiveCell.FormulaR1C1 = Titulo

'       .Visible = True

        If Dir(cruta_II + sNombre_II + Format(Me.txtFecha1.text, "yyyymmdd") + ".XLS") <> "" Then
          Kill cruta_II + sNombre_II + Format(Me.txtFecha1.text, "yyyymmdd") + ".XLS"
        End If

        .ActiveWorkbook.SaveAs FileName:= _
        (cruta_II + sNombre_II + Format(Me.txtFecha1.text, "yyyymmdd") + ".XLS"), FileFormat:= _
        xlNormal, Password:="", WriteResPassword:="", ReadOnlyRecommended:=False _
        , CreateBackup:=False

        .ActiveWorkbook.Close
   End With

   Screen.MousePointer = vbDefault
   MsgBox "Archivos Generados Exitosamente en " + cruta_II, vbInformation, TITSISTEMA
   ProgressBar2.Min = 0
   ProgressBar2.Value = 0
   ProgressBar1.Min = 0
   ProgressBar1.Value = 0

   Set objws = Nothing

   Exit Sub

Error:

   Beep

   Screen.MousePointer = vbDefault

   MsgBox "Imposible Realizar Exportación", vbCritical, App.ProductName

   Set objws = Nothing

   Exit Sub

End Sub

Public Sub mIniNomCol()

Dim i As Integer
Dim j As Integer

   For i = 1 To 26
      aLet(i) = Chr(i + 64)
   Next i

   For i = 1 To 9
      For j = 1 To 29
         If (j + (i * 26)) = 257 Then Exit For
         aLet(j + (i * 26)) = aLet(i) & Chr(j + 64)
      Next j
   Next i
End Sub
Private Sub Form_Load()
    Me.txtFecha1.text = gsBac_Fecp
     
    
     Call Conf_Grilla
End Sub

Sub LoadGrilla()
    Screen.MousePointer = 11
    If Month(gsBac_Fecp) <> Month(gsBac_Fecx) Then
        dFech2 = CDate("01/" + Str(Month(gsBac_Fecx)) + "/" + Str(Year(gsBac_Fecx)))
        dFech1 = DateAdd("d", -1, dFech2)
        cFecCal$ = Trim(Str(Day(dFech1))) + "/" + Trim(Str(Month(dFech1))) + "/" + Trim(Str(Year(dFech1)))
    Else
        cFecCal$ = Trim(Str(Day(gsBac_Fecp))) + "/" + Trim(Str(Month(gsBac_Fecp))) + "/" + Trim(Str(Year(gsBac_Fecp)))
    End If

     Call Llena_Grilla
    MsGrdInv.Refresh
    Screen.MousePointer = 0
End Sub
Private Function Llena_Grilla()
    Dim DATOS()

    On Error GoTo Err_Inv
    Envia = Array()
    AddParam Envia, Format(Me.txtFecha1.text, "yyyymmdd")

    If Not Bac_Sql_Execute("SP_INTERFAZ_INVERSIONES", Envia) Then
        MsgBox "Problemas al ejecutar la consulta.", vbInformation, TITSISTEMA
    End If

    MsGrdInv.Rows = MsGrdInv.FixedRows
    Do While Bac_SQL_Fetch(DATOS())
        With MsGrdInv
             .Rows = .Rows + 1
             .TextMatrix(.Rows - 1, 0) = CDate(DATOS(5))
             .TextMatrix(.Rows - 1, 1) = DATOS(6)
             .TextMatrix(.Rows - 1, 2) = DATOS(7)
             .TextMatrix(.Rows - 1, 3) = DATOS(8)
             .TextMatrix(.Rows - 1, 4) = CDate(DATOS(9))
             .TextMatrix(.Rows - 1, 5) = CDate(DATOS(10))
             .TextMatrix(.Rows - 1, 6) = CDate(DATOS(11))
             .TextMatrix(.Rows - 1, 7) = DATOS(12)
             .TextMatrix(.Rows - 1, 8) = DATOS(13)
             .TextMatrix(.Rows - 1, 9) = DATOS(14)
             .TextMatrix(.Rows - 1, 10) = DATOS(15)
             .TextMatrix(.Rows - 1, 11) = DATOS(16)
             .TextMatrix(.Rows - 1, 12) = DATOS(17)
             .TextMatrix(.Rows - 1, 13) = DATOS(18)
             .TextMatrix(.Rows - 1, 14) = DATOS(19)
             .TextMatrix(.Rows - 1, 15) = DATOS(20)
             .TextMatrix(.Rows - 1, 16) = DATOS(21)
             .TextMatrix(.Rows - 1, 17) = DATOS(22)
             .TextMatrix(.Rows - 1, 18) = DATOS(23)
             .TextMatrix(.Rows - 1, 19) = DATOS(24)
             .TextMatrix(.Rows - 1, 20) = " "
             .TextMatrix(.Rows - 1, 21) = "0"
             .TextMatrix(.Rows - 1, 22) = DATOS(25)
             .TextMatrix(.Rows - 1, 23) = DATOS(27)
             .TextMatrix(.Rows - 1, 24) = DATOS(26)
             .TextMatrix(.Rows - 1, 25) = DATOS(28)
             .TextMatrix(.Rows - 1, 26) = DATOS(29)
             .TextMatrix(.Rows - 1, 27) = IIf(IsNull(DATOS(30)), 0, DATOS(30))
             .TextMatrix(.Rows - 1, 28) = DATOS(31)
             .TextMatrix(.Rows - 1, 29) = DATOS(32)
             .TextMatrix(.Rows - 1, 30) = DATOS(33)
             .TextMatrix(.Rows - 1, 31) = DATOS(34)
             .TextMatrix(.Rows - 1, 32) = DATOS(35)
             .TextMatrix(.Rows - 1, 33) = IIf(IsNull(DATOS(36)), 0, DATOS(36))
             .TextMatrix(.Rows - 1, 34) = DATOS(37)
             .TextMatrix(.Rows - 1, 35) = "0"
             .TextMatrix(.Rows - 1, 36) = DATOS(2) & DATOS(39) 'datos(2) & datos(2) & datos(3)
             .TextMatrix(.Rows - 1, 37) = CDate(DATOS(5))
             .TextMatrix(.Rows - 1, 38) = DATOS(55)
             .TextMatrix(.Rows - 1, 39) = DATOS(37)
             .TextMatrix(.Rows - 1, 40) = " "  ' *** fin

             If (UCase(Trim(DATOS(54))) = "N") Then
                .TextMatrix(.Rows - 1, 41) = Space(30)
             Else
                .TextMatrix(.Rows - 1, 41) = "213011005"
             End If

             .TextMatrix(.Rows - 1, 42) = DATOS(2) & DATOS(39)
             .TextMatrix(.Rows - 1, 43) = DATOS(54)
             .TextMatrix(.Rows - 1, 44) = DATOS(56)
             .TextMatrix(.Rows - 1, 45) = "0000"
             .TextMatrix(.Rows - 1, 46) = DATOS(37)
             .TextMatrix(.Rows - 1, 47) = Space(30)
             .TextMatrix(.Rows - 1, 48) = Space(3)
             .TextMatrix(.Rows - 1, 49) = DATOS(18) '
             .TextMatrix(.Rows - 1, 50) = DATOS(12)
             .TextMatrix(.Rows - 1, 51) = DATOS(57)
             .TextMatrix(.Rows - 1, 52) = DATOS(58)
             .TextMatrix(.Rows - 1, 53) = Space(4)
             .TextMatrix(.Rows - 1, 54) = Space(8)
             .TextMatrix(.Rows - 1, 55) = Space(8)
             .TextMatrix(.Rows - 1, 56) = "00000000000.00"
             .TextMatrix(.Rows - 1, 57) = Space(10)

        End With
    Loop
    Exit Function

Err_Inv:
        MsgBox err.Description, vbCritical, TITSISTEMA
        
End Function

Sub Conf_Grilla()

    With MsGrdInv
        .TextMatrix(0, 0) = "Fecha"
        .TextMatrix(0, 1) = "Cod. Orig."
        .TextMatrix(0, 2) = "Cod. Papel"
        .TextMatrix(0, 3) = "Cod.EmpSinc"
        .TextMatrix(0, 4) = "Fec.Emision"
        .TextMatrix(0, 5) = "Fec.Ope."
        .TextMatrix(0, 6) = "Fec.Vcto."
        .TextMatrix(0, 7) = "Index"
        .TextMatrix(0, 8) = "Tasa Emi."
        .TextMatrix(0, 9) = "Nom. Emi."
        .TextMatrix(0, 10) = "Cod.EmiSinc"
        .TextMatrix(0, 11) = "Rut. Emi."
        .TextMatrix(0, 12) = "Cal. Jur."
        .TextMatrix(0, 13) = "Pais"
        .TextMatrix(0, 14) = "Cartera"
        .TextMatrix(0, 15) = "Val. Comp."
        .TextMatrix(0, 16) = "Custo.Ppal"
        .TextMatrix(0, 17) = "Custo.Juros"
        .TextMatrix(0, 18) = "Cosif"
        .TextMatrix(0, 19) = "Cosif Ger"
        .TextMatrix(0, 20) = "Conta Sinc"
        .TextMatrix(0, 21) = "Perda Perm."
        .TextMatrix(0, 22) = "Val. Mercado"
        .TextMatrix(0, 23) = "PDT"
        .TextMatrix(0, 24) = "PVT"
        .TextMatrix(0, 25) = "Int. Año"
        .TextMatrix(0, 26) = "Reaj. Año"
        .TextMatrix(0, 27) = "Dif. Mcdo. Año"
        .TextMatrix(0, 28) = "Val. Comp. Año"
        .TextMatrix(0, 29) = "Val. Venta"
        .TextMatrix(0, 30) = "Int x Vta"
        .TextMatrix(0, 31) = "Uti/Perd x Vta"
        .TextMatrix(0, 32) = "Mda. Orig."
        .TextMatrix(0, 33) = "Observación"
        .TextMatrix(0, 34) = "Cod. Bolsa"
        .TextMatrix(0, 35) = "Nivel"
        .TextMatrix(0, 36) = "N.Docto"

        .ColWidth(37) = 1500
        .TextMatrix(0, 37) = "Fecha Referencia"

        .ColWidth(38) = 1500
        .TextMatrix(0, 38) = "Codigo Producto"

        .ColWidth(39) = 1800
        .TextMatrix(0, 39) = "Nemotécnico"

        .ColWidth(40) = 2000
        .TextMatrix(0, 40) = "Tipo Operación"

        .ColWidth(41) = 2500
        .TextMatrix(0, 41) = "Cosif Pendiente de Liquidacion"

        .ColWidth(42) = 1300
        .TextMatrix(0, 42) = "Cod.Operacion"

        .ColWidth(43) = 1300
        .TextMatrix(0, 43) = "Pendiente Pago"

        .TextMatrix(0, 44) = "Monto Pago"
        .TextMatrix(0, 45) = "Agencia"

        .ColWidth(46) = 1800
        .TextMatrix(0, 46) = "Nemotécnico"

        .ColWidth(47) = 2500
        .TextMatrix(0, 47) = "CGI da Camara de Compensación"

        .TextMatrix(0, 48) = "Ind.Clase"
        .TextMatrix(0, 49) = "Cod.Pais"

        .ColWidth(50) = 1500
        .TextMatrix(0, 50) = "Cod.Moneda"

        .ColWidth(51) = 2000
        .TextMatrix(0, 51) = "Cod.Contraparte"

        .ColWidth(52) = 1500
        .TextMatrix(0, 52) = "Frecuencia Cupon"

        .ColWidth(53) = 2000
        .TextMatrix(0, 53) = "Posición Embutida"

        .TextMatrix(0, 54) = "Data Inicio"
        .TextMatrix(0, 55) = "Data Final"

        .ColWidth(56) = 1500
        .TextMatrix(0, 56) = "Strike"

        .ColWidth(57) = 1500
        .TextMatrix(0, 57) = "Mesa Gestion"


    End With

End Sub



Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

Select Case Button.Key
    Case "Exportar"
        SSFrame1.Visible = True
        BacControlWindows 50
        Call GeneraPlano
        Call pExpCon(MsGrdInv, "INTERFAZ DE INVERSIONES AL " + Format(cFecCal$, "DD/MM/YYYY"))
        Call pExpCon_II(MsGrdInv, "INTERFAZ DE INVERSIONES AL " + Format(cFecCal$, "DD/MM/YYYY"))
        SSFrame1.Visible = False
    Case "Buscar"
        Call LoadGrilla
        
    Case "Salir"
        Unload Me
End Select

End Sub

Private Sub GeneraPlano()
Dim Comando$
Dim DATOS()
Dim sPath


Dim i       As Integer

Comando$ = "Sp_BacInterfaces_Archivo 15"

On Error GoTo Err_Gen

If Bac_Sql_Execute(Comando$) Then
    If Bac_SQL_Fetch(DATOS()) Then
        If DATOS(1) = "" Then
            MsgBox "Ruta de Interfaz no Definida... Se generara de todas maneras en el disco local C:\", vbInformation, TITSISTEMA
            sPath = "c:\"
            sNombre = "ITATVM" + Format(cFecCal$, "yyyymmdd") + ".txt"
        Else
            sPath = DATOS(4)
            sNombre = DATOS(2)
        End If
    Else
        MsgBox "Ruta de Interfaz no Definida... Se generara de todas maneras en el disco local C:\", vbInformation, TITSISTEMA
        sPath = "c:\"
        sNombre = "ITATVM" + Format(cFecCal$, "yyyymmdd") + ".txt"
    End If
Else
    MsgBox "Problema al Obtener ruta interfaces"
    Exit Sub
End If

cruta = sPath
ProgressBar1.Min = 0
ProgressBar1.Value = 0

nCont = 0
nombre_arch = cruta + sNombre + Format(Me.txtFecha1.text, "yyyymmdd") + ".txt"
Open nombre_arch For Output As #1

With MsGrdInv
ProgressBar1.Max = .Rows - 1

For i = 1 To .Rows - 1
    sString = ""
    sString = sString & .TextMatrix(i, 0)  ' Fecha
    sString = sString & .TextMatrix(i, 1)
    sString = sString & RELLENA_STRING(.TextMatrix(i, 2), "D", 60)
    sString = sString & .TextMatrix(i, 3)
    sString = sString & .TextMatrix(i, 4)
    sString = sString & .TextMatrix(i, 5)
    sString = sString & .TextMatrix(i, 6)
    sString = sString & RELLENA_STRING(.TextMatrix(i, 7), "D", 20)
    sString = sString & Replace(IIf(CDbl(.TextMatrix(i, 8)) < 0, Format(CDbl(.TextMatrix(i, 8)), "0000.0000"), Format(CDbl(.TextMatrix(i, 8)), "00000.0000")), ",", ".")
    sString = sString & RELLENA_STRING(.TextMatrix(i, 9), "D", 35)
    sString = sString & .TextMatrix(i, 10)
    sString = sString & RELLENA_STRING(.TextMatrix(i, 11), "I", 14)
    sString = sString & .TextMatrix(i, 12)
    sString = sString & RELLENA_STRING(.TextMatrix(i, 13), "D", 30)
    sString = sString & .TextMatrix(i, 14)
    sString = sString & Replace(IIf(CDbl(.TextMatrix(i, 15)) < 0, Format(CDbl(.TextMatrix(i, 15)), "000000000000000.00"), Format(CDbl(.TextMatrix(i, 15)), "0000000000000000.00")), ",", ".")
    sString = sString & Replace(IIf(CDbl(.TextMatrix(i, 16)) < 0, Format(CDbl(.TextMatrix(i, 16)), "000000000000000.00"), Format(CDbl(.TextMatrix(i, 16)), "0000000000000000.00")), ",", ".")
    sString = sString & Replace(IIf(CDbl(.TextMatrix(i, 17)) < 0, Format(CDbl(.TextMatrix(i, 17)), "000000000000000.00"), Format(CDbl(.TextMatrix(i, 17)), "0000000000000000.00")), ",", ".")
    sString = sString & RELLENA_STRING(.TextMatrix(i, 18), "D", 8)
    sString = sString & RELLENA_STRING(.TextMatrix(i, 19), "D", 4)
    sString = sString & RELLENA_STRING(.TextMatrix(i, 20), "D", 14)
    sString = sString & Replace(IIf(CDbl(.TextMatrix(i, 21)) < 0, Format(CDbl(.TextMatrix(i, 21)), "000000000000000.00"), Format(CDbl(.TextMatrix(i, 21)), "0000000000000000.00")), ",", ".")
    sString = sString & Replace(IIf(CDbl(.TextMatrix(i, 22)) < 0, Format(CDbl(.TextMatrix(i, 22)), "000000000000000.00"), Format(CDbl(.TextMatrix(i, 22)), "0000000000000000.00")), ",", ".")
    sString = sString & Replace(IIf(CDbl(.TextMatrix(i, 23)) < 0, Format(CDbl(.TextMatrix(i, 23)), "000000000000000.00"), Format(CDbl(.TextMatrix(i, 23)), "0000000000000000.00")), ",", ".")
    sString = sString & Replace(IIf(CDbl(.TextMatrix(i, 24)) < 0, Format(CDbl(.TextMatrix(i, 24)), "000000000000000.00"), Format(CDbl(.TextMatrix(i, 24)), "0000000000000000.00")), ",", ".")
    sString = sString & Replace(IIf(CDbl(.TextMatrix(i, 25)) < 0, Format(CDbl(.TextMatrix(i, 25)), "000000000000000.00"), Format(CDbl(.TextMatrix(i, 25)), "0000000000000000.00")), ",", ".")
    sString = sString & Replace(IIf(CDbl(.TextMatrix(i, 26)) < 0, Format(CDbl(.TextMatrix(i, 26)), "000000000000000.00"), Format(CDbl(.TextMatrix(i, 26)), "0000000000000000.00")), ",", ".")
    sString = sString & Replace(IIf(CDbl(.TextMatrix(i, 27)) < 0, Format(CDbl(.TextMatrix(i, 27)), "000000000000000.00"), Format(CDbl(.TextMatrix(i, 27)), "0000000000000000.00")), ",", ".")
    sString = sString & Replace(IIf(CDbl(.TextMatrix(i, 28)) < 0, Format(CDbl(.TextMatrix(i, 28)), "000000000000000.00"), Format(CDbl(.TextMatrix(i, 28)), "0000000000000000.00")), ",", ".")
    sString = sString & Replace(IIf(CDbl(.TextMatrix(i, 29)) < 0, Format(CDbl(.TextMatrix(i, 29)), "000000000000000.00"), Format(CDbl(.TextMatrix(i, 29)), "0000000000000000.00")), ",", ".")
    sString = sString & Replace(IIf(CDbl(.TextMatrix(i, 30)) < 0, Format(CDbl(.TextMatrix(i, 30)), "000000000000000.00"), Format(CDbl(.TextMatrix(i, 30)), "0000000000000000.00")), ",", ".")
    sString = sString & Replace(IIf(CDbl(.TextMatrix(i, 31)) < 0, Format(CDbl(.TextMatrix(i, 31)), "000000000000000.00"), Format(CDbl(.TextMatrix(i, 31)), "0000000000000000.00")), ",", ".")
    sString = sString & RELLENA_STRING(.TextMatrix(i, 32), "D", 30)
    sString = sString & RELLENA_STRING(.TextMatrix(i, 33), "D", 100)
    sString = sString & RELLENA_STRING("", "D", 60)
    sString = sString & RELLENA_STRING(.TextMatrix(i, 34), "D", 20)
    sString = sString & "0"
    sString = sString & RELLENA_STRING(.TextMatrix(i, 36), "D", 15)
    sString = sString & RELLENA_STRING(.TextMatrix(i, 52), "D", 20)
    Print #1, sString
    nCont = nCont + 1
    ProgressBar1.Value = nCont
Next i
End With

Close #1



'*******************  GENERA BASILEA II txt ***************************
Comando$ = "Sp_BacInterfaces_Archivo 352"           '152 ASIGNADA EN INTERFAZ A SIGIR

On Error GoTo Err_Gen

If Bac_Sql_Execute(Comando$) Then
    If Bac_SQL_Fetch(DATOS()) Then
        If DATOS(1) = "" Then
            MsgBox "Ruta de Interfaz no Definida... Se generara de todas maneras en el disco local C:\", vbInformation, TITSISTEMA
            sPath = "c:\"
            sNombre_II = "430BSL" + Format(cFecCal$, "yyyymmdd") + ".txt"
        Else
            sPath = DATOS(4)
            sNombre_II = DATOS(2)
        End If
    Else
        MsgBox "Ruta de Interfaz no Definida... Se generara de todas maneras en el disco local C:\", vbInformation, TITSISTEMA
        sPath = "c:\"
        sNombre_II = "430BSL" '+ Format(cFeccal$, "yyyymmdd") + ".txt"
    End If
Else
    MsgBox "Problema al Obtener ruta interfaces"
    Exit Sub
End If

cruta_II = sPath
ProgressBar1.Min = 0
ProgressBar1.Value = 0

nCont = 0
nombre_arch = cruta_II + sNombre_II + Format(Me.txtFecha1.text, "yyyymmdd") + ".txt"
Open nombre_arch For Output As #1

With MsGrdInv
ProgressBar1.Max = .Rows - 1

For i = 1 To .Rows - 1
    sString = ""
    sString = sString & .TextMatrix(i, 37) '1
    sString = sString & RELLENA_STRING(.TextMatrix(i, 38), "D", 12) '2
    sString = sString & RELLENA_STRING(.TextMatrix(i, 39), "D", 45) '3
    sString = sString & RELLENA_STRING(.TextMatrix(i, 40), "D", 1)  '4
    sString = sString & RELLENA_STRING(.TextMatrix(i, 41), "D", 30) '5
    sString = sString & RELLENA_STRING(.TextMatrix(i, 42), "D", 45) '6
    sString = sString & RELLENA_STRING(.TextMatrix(i, 43), "D", 1)  '7
    sString = sString & Replace(IIf(CDbl(.TextMatrix(i, 44)) < 0, Format(CDbl(.TextMatrix(i, 44)), "00000000000000000.00"), Format(CDbl(.TextMatrix(i, 44)), "00000000000000000.00")), ",", ".") '8
    sString = sString & .TextMatrix(i, 45) '9
    sString = sString & RELLENA_STRING(.TextMatrix(i, 46), "D", 12) '10
    sString = sString & RELLENA_STRING(.TextMatrix(i, 47), "D", 30) 'RELLENA_STRING("", "D", 30) '11
    sString = sString & RELLENA_STRING(.TextMatrix(i, 48), "D", 3) 'RELLENA_STRING("", "D", 3) '12
    sString = sString & .TextMatrix(i, 49) '13
    sString = sString & .TextMatrix(i, 50) 'RELLENA_STRING(.TextMatrix(I, 32), "D", 3) '14
    sString = sString & RELLENA_STRING(.TextMatrix(i, 51), "D", 30) '15
    sString = sString & RELLENA_STRING(.TextMatrix(i, 52), "D", 25) '16
    sString = sString & RELLENA_STRING(.TextMatrix(i, 53), "D", 4)  'RELLENA_STRING("", "D", 4) '17
    sString = sString & RELLENA_STRING(.TextMatrix(i, 54), "D", 8)  'RELLENA_STRING("", "D", 8) '18
    sString = sString & RELLENA_STRING(.TextMatrix(i, 55), "D", 8)  'RELLENA_STRING("", "D", 8) '19
    sString = sString & .TextMatrix(i, 56) '"00000000000.0000000" '20
    sString = sString & RELLENA_STRING(.TextMatrix(i, 57), "D", 10) 'RELLENA_STRING("", "D", 10) '21
    sString = sString & RELLENA_STRING(.TextMatrix(i, 36), "D", 15)
    

    Print #1, sString
    nCont = nCont + 1
    ProgressBar1.Value = nCont
Next i
End With

Close #1

'*****************  FIN BASILEA II  ****************************

Exit Sub

Err_Gen:
    If err.Number = 55 Then
        Close #1
    End If
    MsgBox err.Description, vbCritical, TITSISTEMA
    
End Sub


Private Sub GeneraPlano2()
'Dim Comando$
'Dim datos()
'Dim sPath
'
'
'Dim I       As Integer
'
'Comando$ = "Sp_BacInterfaces_Archivo 351" 'Basilea
'
'On Error GoTo Err_Gen
'
'If Bac_Sql_Execute(Comando$) Then
'    If Bac_SQL_Fetch(datos()) Then
'        If datos(1) = "" Then
'            MsgBox "Ruta de Interfaz no Definida... Se generara de todas maneras en el disco local C:\", vbInformation, TITSISTEMA
'            sPath = "c:\"
'            sNombre = "ITABSL" + Format(cFeccal$, "yyyymmdd") + ".txt"
'        Else
'            sPath = datos(4)
'            sNombre = datos(2)
'        End If
'    Else
'        MsgBox "Ruta de Interfaz no Definida... Se generara de todas maneras en el disco local C:\", vbInformation, TITSISTEMA
'        sPath = "c:\"
'        sNombre = "ITABSL" + Format(cFeccal$, "yyyymmdd") + ".txt"
'    End If
'Else
'    MsgBox "Problema al Obtener ruta interfaces"
'    Exit Sub
'End If
'
'cruta = sPath
'ProgressBar1.Min = 0
'ProgressBar1.Value = 0
'
'nCont = 0
'nombre_arch = cruta + sNombre + Format(cFeccal$, "yyyymmdd") + ".txt"
'Open nombre_arch For Output As #1
'
'With MsGrdInv
'ProgressBar1.Max = .Rows - 1
'
'For I = 1 To .Rows - 1
'    sString = ""
'    sString = sString & .TextMatrix(I, 0)  ' Fecha
'    sString = sString & .TextMatrix(I, 1)
'    sString = sString & RELLENA_STRING(.TextMatrix(I, 2), "D", 60)
'    sString = sString & .TextMatrix(I, 3)
'    sString = sString & .TextMatrix(I, 4)
'    sString = sString & .TextMatrix(I, 5)
'    sString = sString & .TextMatrix(I, 6)
'    sString = sString & RELLENA_STRING(.TextMatrix(I, 7), "D", 20)
'    sString = sString & IIf(CDbl(.TextMatrix(I, 8)) < 0, Format(CDbl(.TextMatrix(I, 8)), "0000.0000"), Format(CDbl(.TextMatrix(I, 8)), "00000.0000"))
'    sString = sString & RELLENA_STRING(.TextMatrix(I, 9), "D", 35)
'    sString = sString & .TextMatrix(I, 10)
'    sString = sString & RELLENA_STRING(.TextMatrix(I, 11), "I", 14)
'    sString = sString & .TextMatrix(I, 12)
'    sString = sString & RELLENA_STRING(.TextMatrix(I, 13), "D", 30)
'    sString = sString & .TextMatrix(I, 14)
'    sString = sString & IIf(CDbl(.TextMatrix(I, 15)) < 0, Format(CDbl(.TextMatrix(I, 15)), "000000000000000.00"), Format(CDbl(.TextMatrix(I, 15)), "0000000000000000.00"))
'    sString = sString & IIf(CDbl(.TextMatrix(I, 16)) < 0, Format(CDbl(.TextMatrix(I, 16)), "000000000000000.00"), Format(CDbl(.TextMatrix(I, 16)), "0000000000000000.00"))
'    sString = sString & IIf(CDbl(.TextMatrix(I, 17)) < 0, Format(CDbl(.TextMatrix(I, 17)), "000000000000000.00"), Format(CDbl(.TextMatrix(I, 17)), "0000000000000000.00"))
'    sString = sString & RELLENA_STRING(.TextMatrix(I, 18), "D", 8)
'    sString = sString & RELLENA_STRING(.TextMatrix(I, 19), "D", 4)
'    sString = sString & RELLENA_STRING(.TextMatrix(I, 20), "D", 14)
'    sString = sString & IIf(CDbl(.TextMatrix(I, 21)) < 0, Format(CDbl(.TextMatrix(I, 21)), "000000000000000.00"), Format(CDbl(.TextMatrix(I, 21)), "0000000000000000.00"))
'    sString = sString & IIf(CDbl(.TextMatrix(I, 22)) < 0, Format(CDbl(.TextMatrix(I, 22)), "000000000000000.00"), Format(CDbl(.TextMatrix(I, 22)), "0000000000000000.00"))
'    sString = sString & IIf(CDbl(.TextMatrix(I, 23)) < 0, Format(CDbl(.TextMatrix(I, 23)), "000000000000000.00"), Format(CDbl(.TextMatrix(I, 23)), "0000000000000000.00"))
'    sString = sString & IIf(CDbl(.TextMatrix(I, 24)) < 0, Format(CDbl(.TextMatrix(I, 24)), "000000000000000.00"), Format(CDbl(.TextMatrix(I, 24)), "0000000000000000.00"))
'    sString = sString & IIf(CDbl(.TextMatrix(I, 25)) < 0, Format(CDbl(.TextMatrix(I, 25)), "000000000000000.00"), Format(CDbl(.TextMatrix(I, 25)), "0000000000000000.00"))
'    sString = sString & IIf(CDbl(.TextMatrix(I, 26)) < 0, Format(CDbl(.TextMatrix(I, 26)), "000000000000000.00"), Format(CDbl(.TextMatrix(I, 26)), "0000000000000000.00"))
'    sString = sString & IIf(CDbl(.TextMatrix(I, 27)) < 0, Format(CDbl(.TextMatrix(I, 27)), "000000000000000.00"), Format(CDbl(.TextMatrix(I, 27)), "0000000000000000.00"))
'    sString = sString & IIf(CDbl(.TextMatrix(I, 28)) < 0, Format(CDbl(.TextMatrix(I, 28)), "000000000000000.00"), Format(CDbl(.TextMatrix(I, 28)), "0000000000000000.00"))
'    sString = sString & IIf(CDbl(.TextMatrix(I, 29)) < 0, Format(CDbl(.TextMatrix(I, 29)), "000000000000000.00"), Format(CDbl(.TextMatrix(I, 29)), "0000000000000000.00"))
'    sString = sString & IIf(CDbl(.TextMatrix(I, 30)) < 0, Format(CDbl(.TextMatrix(I, 30)), "000000000000000.00"), Format(CDbl(.TextMatrix(I, 30)), "0000000000000000.00"))
'    sString = sString & IIf(CDbl(.TextMatrix(I, 31)) < 0, Format(CDbl(.TextMatrix(I, 31)), "000000000000000.00"), Format(CDbl(.TextMatrix(I, 31)), "0000000000000000.00"))
'    sString = sString & RELLENA_STRING(.TextMatrix(I, 32), "D", 30)
'    sString = sString & RELLENA_STRING(.TextMatrix(I, 33), "D", 100)
'    sString = sString & RELLENA_STRING("", "D", 60)
'    sString = sString & RELLENA_STRING(.TextMatrix(I, 34), "D", 20)
'    sString = sString & RELLENA_STRING(.TextMatrix(I, 35), "D", 15)
'
'    Print #1, sString
'    nCont = nCont + 1
'    ProgressBar1.Value = nCont
'Next I
'End With
'
'Close #1
'
'Exit Sub
'
'Err_Gen:
'    If err.Number = 55 Then
'        Close #1
'    End If
'    MsgBox err.Description, vbCritical, TITSISTEMA

End Sub

