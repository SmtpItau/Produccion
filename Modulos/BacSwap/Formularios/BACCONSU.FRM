VERSION 5.00
Begin VB.Form BacConsultar 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Consulta de Operaciones"
   ClientHeight    =   5070
   ClientLeft      =   990
   ClientTop       =   1470
   ClientWidth     =   11265
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5070
   ScaleWidth      =   11265
   ShowInTaskbar   =   0   'False
   Begin VB.PictureBox Frame 
      Height          =   930
      Index           =   2
      Left            =   105
      ScaleHeight     =   870
      ScaleWidth      =   11040
      TabIndex        =   0
      Top             =   4065
      Width           =   11100
      Begin VB.PictureBox cmdAnticipo 
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   840
         Left            =   6900
         ScaleHeight     =   780
         ScaleWidth      =   1335
         TabIndex        =   14
         Tag             =   "C"
         Top             =   75
         Width           =   1395
      End
      Begin VB.PictureBox cmdEliminar 
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   840
         Left            =   2775
         ScaleHeight     =   780
         ScaleWidth      =   1335
         TabIndex        =   13
         Tag             =   "C"
         Top             =   75
         Width           =   1395
      End
      Begin VB.PictureBox cmdModificar 
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   840
         Left            =   5520
         ScaleHeight     =   780
         ScaleWidth      =   1335
         TabIndex        =   5
         Tag             =   "C"
         Top             =   75
         Width           =   1395
      End
      Begin VB.PictureBox cmdCalzarOperacion 
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   840
         Left            =   4140
         ScaleHeight     =   780
         ScaleWidth      =   1335
         TabIndex        =   4
         Tag             =   "C"
         Top             =   75
         Width           =   1395
      End
      Begin VB.PictureBox cmdFiltrar 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   840
         Left            =   1350
         ScaleHeight     =   780
         ScaleWidth      =   1335
         TabIndex        =   3
         Tag             =   "C"
         Top             =   75
         Width           =   1395
      End
      Begin VB.PictureBox cmdImprimir 
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   840
         Left            =   9675
         ScaleHeight     =   780
         ScaleWidth      =   1335
         TabIndex        =   2
         Tag             =   "C"
         Top             =   75
         Width           =   1395
      End
      Begin VB.PictureBox cmdPapeleta 
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   840
         Left            =   8295
         ScaleHeight     =   780
         ScaleWidth      =   1335
         TabIndex        =   1
         Tag             =   "C"
         Top             =   75
         Width           =   1395
      End
   End
   Begin VB.PictureBox Frame 
      Height          =   2175
      Index           =   3
      Left            =   1845
      ScaleHeight     =   2115
      ScaleWidth      =   3390
      TabIndex        =   6
      Top             =   5160
      Visible         =   0   'False
      Width           =   3450
      Begin VB.PictureBox Grid1 
         BackColor       =   &H00FFFFFF&
         Height          =   885
         Left            =   315
         ScaleHeight     =   825
         ScaleWidth      =   2760
         TabIndex        =   7
         Top             =   645
         Width           =   2820
      End
      Begin VB.Label lblLabel 
         Caption         =   "lblLabel(1)"
         Height          =   345
         Index           =   1
         Left            =   1815
         TabIndex        =   9
         Top             =   300
         Width           =   1305
      End
      Begin VB.Label lblLabel 
         BackColor       =   &H00800000&
         Caption         =   "lblLabel(0)"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   345
         Index           =   0
         Left            =   315
         TabIndex        =   8
         Top             =   240
         Width           =   1305
      End
   End
   Begin VB.PictureBox Frame 
      Height          =   4050
      Index           =   1
      Left            =   105
      ScaleHeight     =   3990
      ScaleWidth      =   11040
      TabIndex        =   10
      Top             =   15
      Width           =   11100
      Begin VB.PictureBox Table1 
         BackColor       =   &H00C0C0C0&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   3375
         Left            =   90
         ScaleHeight     =   3315
         ScaleWidth      =   10845
         TabIndex        =   11
         Top             =   570
         Width           =   10905
      End
      Begin VB.Label Label1 
         Alignment       =   2  'Center
         BackColor       =   &H00C00000&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "Consulta"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   12
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H0000FFFF&
         Height          =   375
         Left            =   105
         TabIndex        =   12
         Top             =   165
         Width           =   10905
      End
   End
End
Attribute VB_Name = "BacConsultar"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private clsOperacion    As Object
Public ObjConsulta      As Object

Private Function LeerCalcesOper(nProducto As Integer, nvencimiento As String, nmoneda1 As Integer, wtipooper As String, nNumOper As Long)

   Dim Sql        As String
   Dim Datos()
   Dim varaux     As Long
   Dim varaux1     As Long
   
   LeerCalcesOper = False

   Sql = "EXECUTE sp_leercalcesope " & nProducto & "," & nmoneda1 & ",'" & Format(nvencimiento, "yyyymmdd") & "','" & wtipooper & "'," & nNumOper
   
   If SQL_Execute(Sql) > 0 Then
      MsgBox "Problemas al leer la operación", vbCritical, "MENSAJE"
      Exit Function

   End If
   
   Do While SQL_Fetch(Datos()) = 0
      LeerCalcesOper = True

   Loop

End Function

Private Function ConLeer()

   Dim nColumn          As Integer
   Dim nCols            As Integer

   Select Case ObjConsulta.ConTipo
   
   Case 1
      Table1.LayoutIndex = 1
      Call MOLeerDatos(ObjConsulta.ConSql)
      cmdEliminar.Enabled = True
      'mcdImpContrato.Enabled = True
      cmdPapeleta.Enabled = True
      cmdModificar.Enabled = True
      cmdCalzarOperacion.Enabled = False
      cmdAnticipo.Enabled = False
      nCols = 9

   Case 2
      cmdEliminar.Enabled = False
      cmdModificar.Enabled = False
      'mcdImpContrato.Enabled = True
      cmdPapeleta.Enabled = True
      cmdCalzarOperacion.Enabled = True
      cmdAnticipo.Enabled = False
      cmdAnticipo.Enabled = False
      nCols = 1

   Case 3
      Table1.LayoutIndex = 3
      Call LeerDatosCar(ObjConsulta.ConSql)
      cmdCalzarOperacion.Enabled = True
      'mcdImpContrato.Enabled = True
      cmdPapeleta.Enabled = True
      cmdEliminar.Enabled = False
      cmdModificar.Enabled = True
      cmdAnticipo.Enabled = False
      nCols = 13

   Case 4
      Table1.LayoutIndex = 4
      Call LeerCarVenc(ObjConsulta.ConSql)
      cmdEliminar.Enabled = False
      cmdModificar.Enabled = False
      cmdCalzarOperacion.Enabled = False
      'mcdImpContrato.Enabled = False
      cmdPapeleta.Enabled = False
      cmdAnticipo.Enabled = False
      nCols = 13

   Case 5
      cmdCalzarOperacion.Enabled = False
      'mcdImpContrato.Enabled = False
      cmdPapeleta.Enabled = False
      cmdAnticipo.Enabled = False

   End Select

   cmdImprimir.Enabled = True

   For nColumn = 1 To nCols
      Table1.ColumnCellAttrs(nColumn) = True

   Next nColumn

End Function

Function ConAnularOperacion()

   Dim nOperacion       As Long
   Dim nOpc             As Integer
   Dim Sql              As String
   Dim sEstado          As String

   If Table1.RowIndex = 0 Then
      MsgBox "debe seleccionar operación", vbExclamation, "CONSULTA"
      Exit Function

   End If
   
   Grid1.Row = Table1.RowIndex
   Grid1.Col = 10
   nOperacion = Val(Grid1.Text)

   Grid1.Col = 14
   sEstado = Grid1.Text

   nOpc = MsgBox("¿Esta Seguro?", vbQuestion + vbYesNo, "MENSAJE")

   If nOpc = vbNo Then
      Exit Function

   End If

   Sql = "EXECUTE sp_anularoperacion " & nOperacion

   If SQL_Execute(Sql) <> 0 Then
      MsgBox "Problema al eliminar la operación", vbExclamation, "MENSAJE"

   End If

   Call ConLeer

   Table1.Refresh
   
End Function

Private Function ImpOpeDia()

   Dim iLin       As Integer
   Dim Sql        As String
   Dim cCristal   As Object

   'Limpieza de la tabla Access
   Sql = "DELETE FROM movprueba;"

   db.Execute Sql

   'Llenado de la tabla Access
   With Grid1
      For iLin = 1 To Grid1.Rows - 1

         .Row = iLin
         
         Sql = ""
         Sql = Sql & "INSERT INTO movprueba VALUES ( "
         .Col = 1:  Sql = Sql & "'" & Trim(.Text) & "', "
         .Col = 2:  Sql = Sql & "'" & Trim(.Text) & "', "
         .Col = 3:  Sql = Sql & "'" & Trim(.Text) & "', "
         .Col = 5:  Sql = Sql & "'" & Trim(.Text) & "', "
         .Col = 6:  Sql = Sql & bacTranMontoSql(CDbl(.Text)) & ", "
         .Col = 7:  Sql = Sql & bacTranMontoSql(CDbl(.Text)) & ", "
         .Col = 8:  Sql = Sql & "'" & Trim(.Text) & "', "
         .Col = 9:  Sql = Sql & bacTranMontoSql(CDbl(.Text)) & ", "
         .Col = 10: Sql = Sql & bacTranMontoSql(CDbl(.Text)) & ", "
         .Col = 17:  Sql = Sql & "'" & Trim(.Text) & "',"
         .Col = 11:  Sql = Sql & "'" & Trim(.Text) & "',"
         .Col = 12:  Sql = Sql & "'" & Trim(.Text) & "',"
         .Col = 13:  Sql = Sql & "'" & Trim(.Text) & "'"

         Sql = Sql & " );"

         db.Execute Sql

      Next iLin

   End With

   Set cCristal = New clsCristal

   'tipo de reporte
   cCristal.ReportType = "MDB"

   'Orden de impresión del reporte
   cCristal.PEN_ImprimirReporte "BACMDIA", "(BacMDia) Movimiento de operaciones del dia " & Format$(gsBAC_Fecp, gsc_FechaDMA)

   Set cCristal = Nothing

End Function

Private Function ImpOpeVig()
   
   Dim iLin       As Integer
   Dim Sql        As String
   Dim cCristal   As New clsCristal

   'Limpieza de la tabla Access
   Sql = "DELETE FROM MovCarVig;"

   db.Execute Sql

   'Llenado de la tabla Access
   With Grid1
      For iLin = 1 To Grid1.Rows - 1

         .Row = iLin
         
         Sql = ""
         Sql = Sql & "INSERT INTO MovCarVig VALUES ( "
         .Col = 1:  Sql = Sql & "'" & Trim(.Text) & "', "
         .Col = 2:  Sql = Sql & "'" & Trim(.Text) & "', "
         .Col = 3:  Sql = Sql & Val(.Text) & ", "
         .Col = 4:  Sql = Sql & "'" & Trim(.Text) & "', "
         .Col = 5:  Sql = Sql & bacTranMontoSql(CDbl(.Text)) & ", "
         .Col = 6:  Sql = Sql & bacTranMontoSql(CDbl(.Text)) & ", "
         .Col = 7:  Sql = Sql & "'" & Trim(.Text) & "', "
         .Col = 8:  Sql = Sql & "'" & Trim(.Text) & "', "
         .Col = 9:  Sql = Sql & bacTranMontoSql(CDbl(.Text)) & ", "
         .Col = 10: Sql = Sql & bacTranMontoSql(CDbl(.Text)) & ", "
         .Col = 11: Sql = Sql & bacTranMontoSql(CDbl(.Text)) & ", "
         .Col = 12: Sql = Sql & "'" & Trim(.Text) & "',"
         .Col = 13: Sql = Sql & "'" & Trim(.Text) & "',"
         .Col = 0:  Sql = Sql & "'" & Trim(.Text) & "',"
         .Col = 14: Sql = Sql & "'" & Trim(.Text) & "',"
         .Col = 15: Sql = Sql & "'" & Trim(.Text) & "'"
         
         Sql = Sql & " );"

         db.Execute Sql

      Next iLin

   End With

   'tipo de reporte
   cCristal.ReportType = "MDB"

   'Orden de impresión del reporte
   cCristal.PEN_ImprimirReporte "BACARVIG", "(Bacarvig) Movimiento de Cartera Vigente " & Format$(gsBAC_Fecp, gsc_FechaDMA)

   Set cCristal = Nothing

End Function

Private Sub MOLeerDatos(Sql As String)

   Dim Datos()

   If SQL_Execute(Sql) > 0 Then
      MsgBox "Problemas al leer las operaciones del Día", vbCritical, "MENSAJE"
      Exit Sub

   End If

   Grid1.Rows = 1

   Do While SQL_Fetch(Datos()) = 0

      With Grid1

         .Rows = .Rows + 1
         .Row = .Rows - 1

         .Col = 0
         .Text = Val(Datos(10))
         
         .Col = 1                '  Tipo de Producto
         .Text = Datos(1)

         .Col = 2                '   Tipo operación
         Select Case Datos(2)
         Case "C"
            .Text = "Compra"

         Case "V"
            .Text = "Venta"

         Case "O"
            .Text = "Colocación"

         Case "A"
            .Text = "Captación"

         End Select

         .Col = 3                   'Cliente
         .Text = Datos(3)

         .Col = 4                   'Fecha de Vencimiento
         .Text = Format(Datos(4), "ddd, " + gsc_FechaDMA)

         .Col = 5                   'Nemo Moneda 1
         .Text = Datos(5)

         .Col = 6                   'Monto Moneda 1
         .Text = Val(Datos(6))

         .Col = 7                   'Precio Futuro
         .Text = Val(Datos(7))

         .Col = 8                   'Nemo Moneda 2
         .Text = Datos(8)

         .Col = 9                   'Monto Moneda 2
         .Text = Val(Datos(9))

         .Col = 10                  ' Numero de Operación
         .Text = Val(Datos(11))

         .Col = 11                  'Nombre del Propietario
         .Text = Datos(12)

         .Col = 12                  'Direccion del Propietario
         .Text = Datos(13)

         .Col = 13                  'Fecha de Proceso
         .Text = Datos(14)
     
         .Col = 14                  'Estado de la Operación
         .Text = Datos(15)

         .Col = 15                  'Indicador de Bloqueo
         .Text = Datos(16)

         .Col = 16
         .Text = Datos(10)          'Posición Operación
         
         .Col = 17
         .Text = Datos(4)           'Fecha de Vencimiento


      End With

   Loop

   Table1.Rows = Grid1.Rows - 1

End Sub

Sub LeerDatosCar(Sql As String)

   Dim nPosicion     As Integer
   Dim nMoneda       As Integer
   Dim nRut          As Long
   Dim nOperacion    As Long
   Dim sTipOper      As String
   Dim sPlaResi      As Integer
   Dim Datos()

   If SQL_Execute(Sql) > 0 Then
      MsgBox "Error en la lectura de las operaciones vigentes", vbExclamation, "MENSAJE"
      Exit Sub

   End If

   With Grid1
      .Cols = 19
      .Rows = 1

      Do While SQL_Fetch(Datos()) = 0

         .Rows = .Rows + 1
         .Row = .Rows - 1

         .Col = 0
         .Text = Datos(9)

         .Col = 1                                  ' producto
         .Text = Datos(7)
         
         .Col = 2                                  'Tipo operación
         Select Case Datos(3)
         Case "C"
            .Text = "Compra"

         Case "V"
            .Text = "Venta"

         Case "O"
            .Text = "Colocación"

         Case "A"
            .Text = "Captación"

         End Select
         
         .Col = 3                                  ' Nro Operacion
         .Text = Val(Datos(1))

         .Col = 4                                  ' Fecha Operacion
         .Text = Format(Datos(8), "ddd, " + gsc_FechaDMA)

         .Col = 5                                  ' Plazo
         .Text = Val(Datos(10))
         
         .Col = 6                                  ' Plazo Residual
         sPlaResi = DateDiff("D", Datos(9), Datos(4))
         .Text = sPlaResi

         .Col = 7                                  ' Fecha de Vencimiento
         .Text = Format(Datos(4), "ddd, " + gsc_FechaDMA)
         
         .Col = 8                                  ' Nemotecnico Moneda Origen
         .Text = Datos(11)

          .Col = 9                                  ' Monto Origen
         .Text = Val(Datos(6))
         
         .Col = 10                                 ' Precio
         .Text = Val(Datos(12))

         .Col = 11                                 ' Monto Conversion
         .Text = Val(Datos(13))
         
         .Col = 12                                 ' Moneda Coversion
         .Text = Datos(5)
         
         .Col = 13                                 ' Nombre Cliente
         .Text = Datos(2)

         .Col = 14                                 ' Nombre Propietario
         .Text = Datos(14)

         .Col = 15                                 ' Direccion Propietario
         .Text = Datos(15)

         .Col = 16                                 ' Código de Posición
         .Text = Val(Datos(16))

         .Col = 17
         .Text = Val(Datos(19))                     ' Código Moneda Origen

         .Col = 18                                  ' Fecha de Vencimiento
         .Text = Datos(4)

      Loop

      Table1.Rows = Grid1.Rows - 1

   End With
   
End Sub

Sub LeerCarVenc(Sql As String)

   Dim sPlaResi      As Integer
   Dim Datos()

   If SQL_Execute(Sql) > 0 Then
      MsgBox "Error en la lectura de las operaciones vigentes", vbExclamation, "MENSAJE"
      Exit Sub

   End If

   With Grid1
      .Rows = 1

      Do While SQL_Fetch(Datos()) = 0

         .Rows = .Rows + 1
         .Row = .Rows - 1

         .Col = 0
         .Text = Datos(9)

         .Col = 1                                  ' producto
         .Text = Datos(7)
         
         .Col = 2                                  'Tipo operación

         Select Case Datos(3)
         Case "C"
            .Text = "Compra"

         Case "V"
            .Text = "Venta"

         Case "O"
            .Text = "Colocación"

         Case "A"
            .Text = "Captación"

         End Select
         
         .Col = 3
         .Text = Val(Datos(1))                     ' Nro Operacion

         .Col = 4                                  ' Fecha Operacion
         .Text = Format(Datos(8), "ddd, " + gsc_FechaDMA)

         .Col = 5                                  ' Plazo
         .Text = Val(Datos(10))
         
         .Col = 6                                  ' Plazo Residual
         sPlaResi = DateDiff("D", Datos(9), Datos(4))
         .Text = sPlaResi

         .Col = 7                                  ' Fecha de Vencimiento
         .Text = Format(Datos(4), "ddd, " + gsc_FechaDMA)
         
         .Col = 8                                  ' Moneda Origen
         .Text = Datos(11)

         .Col = 9                                  ' Monto Origen
         .Text = Val(Datos(6))
         
         .Col = 10                                  ' Precio
         .Text = Val(Datos(12))

         .Col = 11                                  ' Moneda Coversion
         .Text = Datos(5)
         
         .Col = 12                                  ' Monto Conversion
         .Text = Val(Datos(13))
         
         .Col = 13                                  ' Nombre Cliente
         .Text = Datos(2)

         .Col = 14                                  ' Nombre Propietario
         .Text = Datos(14)

         .Col = 15                                  ' Direccion Propietario
         .Text = Datos(15)

      Loop

      Table1.Rows = Grid1.Rows - 1

   End With
   
End Sub


Private Sub cmdAnticipo_Click()

   Dim iCodPoscion         As Integer
   Dim nCodPosicion        As Integer
   Dim sFecha              As String
   Dim Sql                 As String

   If Table1.RowIndex = 0 Then
      Exit Sub

   End If

   With Grid1
      .Row = Table1.RowIndex
      .Col = 3:   gsc_Operacion.nNumOper = Val(.Text)
      .Col = 4:   sFecha = Mid$(.Text, 6, 10)
      .Col = 16:  nCodPosicion = Val(.Text)
     
   End With

   If sFecha = gsBAC_Fecp Then
      gsc_Operacion.limpiar
      MsgBox "No se puede anticipar esta operacion", vbExclamation, "Anticipar"
      Exit Sub

   End If

   Select Case nCodPosicion
   Case 1         'Seguro de Cambios
      Call BacIrfNueVentana("SCAA")

   Case 2         'Arbitrajes
 '     Call BacIrfNueVentana("ARBA")

   Case 3         'Seguro de Inflación
  '    Call BacIrfNueVentana("SEIA")

   Case 4         'Sinteticos
      'Call BacIrfNueVentana("SINTM")

   Case 5         'Operaciones 1446
      'Call BacIrfNueVentana("1446M")

   End Select

End Sub

Private Sub cmdCalzarOperacion_Click()

   Dim iCodPoscion         As Integer
   Dim nCodPosicion        As Integer
   Dim sEstado             As String
   Dim sLock               As String
   Dim Sql                 As String
   Dim sTipOper            As String
   Dim sTitulo             As String
   Dim sFecha              As String
   Dim nMoneda             As Integer
   If Table1.RowIndex = 0 Then
      Exit Sub

   End If

   Select Case ObjConsulta.ConTipo
   
   Case 1                   ' Movimiento
   
      With Grid1
         .Row = Table1.RowIndex
         .Col = 0:   nCodPosicion = Val(.Text)
         .Col = 2:   sTipOper = .Text

         .Col = 10:  gsc_Operacion.nNumOper = Val(.Text)

         .Col = 14:  sEstado = .Text

         .Col = 15:  sLock = .Text

      End With

      If sEstado = "A" Then
         MsgBox "Operación se encuentra anulada", vbExclamation, "MENSAJE"
         Exit Sub

      End If
      
      If nCodPosicion = 2 Then   'Arbitrajes no se calzan
         MsgBox "Operaciones de Arbitrajes no se Pueden Calzar", vbInformation, "MENSAJE"
         Exit Sub

      End If

      If gsc_Operacion.CargarDatos Then

         If gsc_Operacion.cLock = "" Then

            Select Case nCodPosicion
            Case OP_SEGCAMBIO: sTitulo = "Seguro de Cambio"
            Case OP_ARBITRAJE: sTitulo = "Arbitraje"
            Case OP_SEGINFLAC: sTitulo = "Seguro de Inflación"
            Case OP_SINTETICO: sTitulo = "Sinteticos"
            Case OP_OPERA1446: sTitulo = "Operaciones 1446"
            End Select

            BacCalceOper.Caption = "Calce de Operaciones (" & sTitulo & " Nro. " & gsc_Operacion.nNumOper & " " & sTipOper & ")"
            BacCalceOper.Table2.LayoutIndex = 1
            BacCalceOper.Show vbModal%

            Call ConLeer

            Table1.Refresh

         Else
            MsgBox "Operación se encuentra tomada por el usuario " & gsc_Operacion.cLock, vbInformation, "MENSAJE"

         End If

      End If

   Case 3     ' Vigentes
   
      With Grid1
         .Row = Table1.RowIndex
         .Col = 16:   nCodPosicion = Val(.Text)
         .Col = 2:   sTipOper = .Text

         .Col = 3:  gsc_Operacion.nNumOper = Val(.Text)

'         .Col = 14:  sEstado = .Text

         .Col = 15:  sLock = .Text

         .Col = 17: nMoneda = Val(.Text)

         .Col = 18: sFecha = .Text

      End With
      
      If nCodPosicion = 2 Then   'Arbitrajes no se calzan
         MsgBox "Operaciones de Arbitrajes no se Pueden Calzar", vbInformation, "MENSAJE"
         Exit Sub
             
      End If

      If gsc_Operacion.CargarDatosMFCA Then
         If gsc_Operacion.cLock = "" Then

            If gsc_Operacion.TomarOperacion(gsc_Operacion.nNumOper, gsBAC_User) Then
               Select Case nCodPosicion
               Case OP_SEGCAMBIO: sTitulo = "Seguro de Cambio"
               Case OP_ARBITRAJE: sTitulo = "Arbitraje"
               Case OP_SEGINFLAC: sTitulo = "Seguro de Inflación"
               Case OP_SINTETICO: sTitulo = "Sinteticos"
               Case OP_OPERA1446: sTitulo = "Operaciones 1446"
               End Select

              If LeerCalcesOper(nCodPosicion, sFecha, nMoneda, sTipOper, gsc_Operacion.nNumOper) = False Then
                 MsgBox "No hay Calces para esta Operación", vbCritical, "MENSAJE"

              Else
                  BacCalceOper.Caption = "Calce de Operaciones (" & sTitulo & " Nro. " & gsc_Operacion.nNumOper & " " & sTipOper & ")"
                  BacCalceOper.Table2.LayoutIndex = 1
                  BacCalceOper.Show vbModal%

              End If

            End If

            Call ConLeer

            Table1.Refresh

         Else
            MsgBox "Operación se encuentra tomada por el usuario " & gsc_Operacion.cLock, vbInformation, "MENSAJE"

         End If

      End If

   Case Else
      MsgBox "No se puede realizar este proceso.", vbInformation, "MENSAJE"

   End Select


End Sub

Private Sub cmdEliminar_Click()

   If Table1.RowIndex = 0 Then
      Exit Sub

   End If

   Select Case ObjConsulta.ConTipo
   Case 1
      Call ConAnularOperacion

   Case Else
      MsgBox "No se puede realizar este proceso.", vbInformation, "MENSAJE"

   End Select

End Sub

Private Sub cmdFiltrar_Click()

   Dim Sql        As String
   Dim sNivel     As String

   BacFiltrosConsultas.Show vbModal%

   If ObjConsulta.ConTipo <> 0 Then
      Label1.Caption = ObjConsulta.ConTitulo

   End If

   Call ConLeer

   Table1.Refresh

End Sub

Private Sub cmdImprimir_Click()
      
  Select Case ObjConsulta.ConTipo
  Case 1
     Call ImpOpeDia
         
  Case 3
      Call ImpOpeVig
      
  End Select


End Sub

Private Sub cmdModificar_Click()

   Dim iCodPoscion         As Integer
   Dim nCodPosicion        As Integer
   Dim sEstado             As String
   Dim sLock               As String
   Dim Sql                 As String

   If Table1.RowIndex = 0 Then
      Exit Sub

   End If

   Select Case ObjConsulta.ConTipo
   Case 1                                               'Modificaciones de Operaciones del Día
   
      With Grid1
         .Row = Table1.RowIndex
         .Col = 0:   nCodPosicion = Val(.Text)

         .Col = 10:  gsc_Operacion.nNumOper = Val(.Text)

         .Col = 14:  sEstado = .Text

         .Col = 15:  sLock = .Text

      End With

      If sEstado = "A" Then
         MsgBox "Operación se encuentra anulada", vbExclamation, "MENSAJE"
         Exit Sub

      End If

      If gsc_Operacion.CargarDatos Then
         If gsc_Operacion.cLock = "" Then

            If gsc_Operacion.TomarOperacion(gsc_Operacion.nNumOper, gsBAC_User) Then
               Select Case nCodPosicion
               Case OP_SEGCAMBIO: Call BacIrfNueVentana("SCAMM")
               Case OP_ARBITRAJE: Call BacIrfNueVentana("ARBRM")
               Case OP_SEGINFLAC: Call BacIrfNueVentana("SEINM")
               Case OP_SINTETICO: Call BacIrfNueVentana("SINTM")
               Case OP_OPERA1446: Call BacIrfNueVentana("1446M")
               End Select

            End If

            Call ConLeer

            Table1.Refresh

         Else
            MsgBox "Operación se encuentra tomada por el usuario " & gsc_Operacion.cLock, vbInformation, "MENSAJE"

         End If

      End If

   Case 3                                               'Modificar Operaciones Vigentes
   
      With Grid1
         .Row = Table1.RowIndex
         .Col = 16:   nCodPosicion = Val(.Text)

         .Col = 3:  gsc_Operacion.nNumOper = Val(.Text)

         .Col = 14:  sEstado = .Text

         .Col = 15:  sLock = .Text

      End With

      If sEstado = "A" Then
         MsgBox "Operación se encuentra anulada", vbExclamation, "MENSAJE"
         Exit Sub

      End If

      If gsc_Operacion.CargarDatosMFCA Then
         If gsc_Operacion.cLock = "" Then

'            If gsc_Operacion.TomarOperacion(gsc_Operacion.nNumOper, gsBAC_User) Then
               Select Case nCodPosicion
               Case OP_SEGCAMBIO: Call BacIrfNueVentana("SCAMC")
               Case OP_ARBITRAJE: Call BacIrfNueVentana("ARBRC")
               Case OP_SEGINFLAC: Call BacIrfNueVentana("SEINC")
               Case OP_SINTETICO: Call BacIrfNueVentana("SINTC")
               Case OP_OPERA1446: Call BacIrfNueVentana("1446C")
               End Select

'            End If

            Call ConLeer

            Table1.Refresh

         Else
            MsgBox "Operación se encuentra tomada por el usuario " & gsc_Operacion.cLock, vbInformation, "MENSAJE"

         End If

      End If

   Case Else
      MsgBox "No se puede realizar este proceso.", vbInformation, "MENSAJE"

   End Select

End Sub

Private Sub cmdPapeleta_Click()

   Dim nOperacion          As Long

   If Table1.RowIndex < 1 Then
      MsgBox "Seleccioné una operación", vbInformation, "MENSAJE"
      Exit Sub

   End If

   With Grid1
      .Row = Table1.RowIndex
      Select Case ObjConsulta.ConTipo
      Case 1
         .Col = 10:  gsc_Operacion.nNumOper = Val(.Text)
      Case 3
         .Col = 3:  gsc_Operacion.nNumOper = Val(.Text)
      End Select
      
   End With
   
   Call ImprimirPapeleta(gsc_Operacion.nNumOper, ObjConsulta.ConTipo)

   gsc_Operacion.limpiar

End Sub

Private Sub Form_Load()
   
   Dim nColumn          As Integer

   Call BacSetMinBox(Me)

   Set ObjConsulta = New clsConsulta
   Set clsOperacion = New clsOperacion

   Me.Top = 0
   Me.Left = 0

   cmdEliminar.Enabled = False
   cmdModificar.Enabled = False

End Sub

Private Sub Form_Unload(Cancel As Integer)

   Set ObjConsulta = Nothing
   Set clsOperacion = Nothing

End Sub


Private Sub Table1_Fetch(Row As Long, Col As Integer, Value As String)

   With Grid1
      .Col = Col
      .Row = Row
      Value = .Text

   End With

End Sub

Private Sub Table1_FetchAttributes(Status As Integer, Split As Integer, Row As Long, Col As Integer, FgColor As Long, BgColor As Long, FontStyle As Integer)

   With Grid1
      Select Case ObjConsulta.ConTipo
      Case 1
         .Row = Row
         .Col = 2
         If .Text = "Compra" Or .Text = "Colocación" Then
            FgColor = vbBlue

         Else
            FgColor = vbRed
      
         End If

         .Row = Row
         .Col = 14
         If .Text = "A" Then
            FgColor = vbBlack

         End If

         FontStyle = 2

      Case 3
         .Row = Row
         .Col = 2
         If .Text = "Compra" Or .Text = "Colocación" Then
            FgColor = vbBlue

         Else
            FgColor = vbRed
      
         End If

         FontStyle = 2

      Case 4
         .Row = Row
         .Col = 2
         If .Text = "Compra" Or .Text = "Colocación" Then
            FgColor = vbBlue

         Else
            FgColor = vbRed
      
         End If

         FontStyle = 2

      End Select
      
   End With

   If Col = Table1.ColumnIndex And Row = Table1.RowIndex Then
      BgColor = &HC0FFFF     '&H808080
      Exit Sub

   End If
   
   If Row = Table1.RowIndex Then
      FgColor = vbWhite  'lblLabel(0).ForeColor
      BgColor = vbBlack   '&HC0C0C0     'lblLabel(0).BackColor
      Exit Sub

   End If

End Sub

