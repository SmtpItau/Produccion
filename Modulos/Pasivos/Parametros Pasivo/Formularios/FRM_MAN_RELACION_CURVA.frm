VERSION 5.00
Object = "{1C0489F8-9EFD-423D-887A-315387F18C8F}#1.0#0"; "vsflex8l.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Begin VB.Form FRM_MAN_RELACION_CURVA 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Mantenedor de Relación para Curvas"
   ClientHeight    =   4785
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   10530
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   4785
   ScaleWidth      =   10530
   ShowInTaskbar   =   0   'False
   Begin VB.Frame Frame1 
      Height          =   1065
      Left            =   0
      TabIndex        =   2
      Top             =   510
      Width           =   10545
      Begin VB.ComboBox Cmb_Producto 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   1980
         Style           =   2  'Dropdown List
         TabIndex        =   7
         Top             =   600
         Width           =   3735
      End
      Begin VB.ComboBox Cmb_Sistema 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   1980
         Style           =   2  'Dropdown List
         TabIndex        =   3
         Top             =   120
         Width           =   3750
      End
      Begin VB.Label Label2 
         Caption         =   "Producto"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   75
         TabIndex        =   6
         Top             =   600
         Width           =   1815
      End
      Begin VB.Label Label1 
         Caption         =   "Nombre de Módulo"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   75
         TabIndex        =   4
         Top             =   180
         Width           =   1950
      End
   End
   Begin VSFlex8LCtl.VSFlexGrid Grd_Ingreso 
      Height          =   3180
      Left            =   15
      TabIndex        =   1
      Top             =   1605
      Width           =   10560
      _cx             =   18627
      _cy             =   5609
      Appearance      =   1
      BorderStyle     =   1
      Enabled         =   0   'False
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MousePointer    =   0
      BackColor       =   -2147483644
      ForeColor       =   -2147483635
      BackColorFixed  =   8421376
      ForeColorFixed  =   -2147483634
      BackColorSel    =   -2147483635
      ForeColorSel    =   -2147483634
      BackColorBkg    =   -2147483636
      BackColorAlternate=   -2147483644
      GridColor       =   -2147483633
      GridColorFixed  =   -2147483632
      TreeColor       =   -2147483632
      FloodColor      =   192
      SheetBorder     =   -2147483642
      FocusRect       =   1
      HighLight       =   1
      AllowSelection  =   -1  'True
      AllowBigSelection=   -1  'True
      AllowUserResizing=   0
      SelectionMode   =   0
      GridLines       =   2
      GridLinesFixed  =   0
      GridLineWidth   =   1
      Rows            =   2
      Cols            =   13
      FixedRows       =   2
      FixedCols       =   0
      RowHeightMin    =   0
      RowHeightMax    =   0
      ColWidthMin     =   0
      ColWidthMax     =   0
      ExtendLastCol   =   0   'False
      FormatString    =   $"FRM_MAN_RELACION_CURVA.frx":0000
      ScrollTrack     =   0   'False
      ScrollBars      =   3
      ScrollTips      =   0   'False
      MergeCells      =   0
      MergeCompare    =   0
      AutoResize      =   -1  'True
      AutoSizeMode    =   0
      AutoSearch      =   0
      AutoSearchDelay =   2
      MultiTotals     =   -1  'True
      SubtotalPosition=   1
      OutlineBar      =   0
      OutlineCol      =   0
      Ellipsis        =   0
      ExplorerBar     =   0
      PicturesOver    =   0   'False
      FillStyle       =   0
      RightToLeft     =   0   'False
      PictureType     =   0
      TabBehavior     =   0
      OwnerDraw       =   0
      Editable        =   1
      ShowComboButton =   1
      WordWrap        =   0   'False
      TextStyle       =   0
      TextStyleFixed  =   0
      OleDragMode     =   0
      OleDropMode     =   0
      ComboSearch     =   3
      AutoSizeMouse   =   -1  'True
      FrozenRows      =   0
      FrozenCols      =   0
      AllowUserFreezing=   0
      BackColorFrozen =   0
      ForeColorFrozen =   0
      WallPaperAlignment=   9
      AccessibleName  =   ""
      AccessibleDescription=   ""
      AccessibleValue =   ""
      AccessibleRole  =   24
   End
   Begin MSComctlLib.ImageList Img_Imagen 
      Left            =   3960
      Top             =   1440
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   24
      ImageHeight     =   24
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   6
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MAN_RELACION_CURVA.frx":01B2
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MAN_RELACION_CURVA.frx":108C
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MAN_RELACION_CURVA.frx":1F66
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MAN_RELACION_CURVA.frx":2280
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MAN_RELACION_CURVA.frx":315A
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MAN_RELACION_CURVA.frx":4034
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Tlb_Botones 
      Align           =   1  'Align Top
      Height          =   480
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   10530
      _ExtentX        =   18574
      _ExtentY        =   847
      ButtonWidth     =   820
      ButtonHeight    =   794
      Appearance      =   1
      Style           =   1
      ImageList       =   "Img_Imagen"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   6
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.ToolTipText     =   "Eliminar "
            ImageIndex      =   2
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.ToolTipText     =   "Plazos"
            ImageIndex      =   6
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin VSFlex8LCtl.VSFlexGrid Grd_Plazo_Grabar 
      Height          =   1500
      Left            =   765
      TabIndex        =   5
      Top             =   4335
      Visible         =   0   'False
      Width           =   5250
      _cx             =   9260
      _cy             =   2646
      Appearance      =   1
      BorderStyle     =   1
      Enabled         =   -1  'True
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MousePointer    =   0
      BackColor       =   -2147483633
      ForeColor       =   8388608
      BackColorFixed  =   8421376
      ForeColorFixed  =   16777215
      BackColorSel    =   -2147483635
      ForeColorSel    =   -2147483634
      BackColorBkg    =   -2147483636
      BackColorAlternate=   -2147483633
      GridColor       =   -2147483633
      GridColorFixed  =   -2147483632
      TreeColor       =   -2147483632
      FloodColor      =   192
      SheetBorder     =   -2147483642
      FocusRect       =   1
      HighLight       =   1
      AllowSelection  =   -1  'True
      AllowBigSelection=   -1  'True
      AllowUserResizing=   0
      SelectionMode   =   0
      GridLines       =   2
      GridLinesFixed  =   0
      GridLineWidth   =   1
      Rows            =   2
      Cols            =   4
      FixedRows       =   2
      FixedCols       =   0
      RowHeightMin    =   0
      RowHeightMax    =   0
      ColWidthMin     =   0
      ColWidthMax     =   0
      ExtendLastCol   =   0   'False
      FormatString    =   $"FRM_MAN_RELACION_CURVA.frx":4F0E
      ScrollTrack     =   0   'False
      ScrollBars      =   3
      ScrollTips      =   0   'False
      MergeCells      =   0
      MergeCompare    =   0
      AutoResize      =   -1  'True
      AutoSizeMode    =   0
      AutoSearch      =   0
      AutoSearchDelay =   2
      MultiTotals     =   -1  'True
      SubtotalPosition=   1
      OutlineBar      =   0
      OutlineCol      =   0
      Ellipsis        =   0
      ExplorerBar     =   0
      PicturesOver    =   0   'False
      FillStyle       =   0
      RightToLeft     =   0   'False
      PictureType     =   0
      TabBehavior     =   0
      OwnerDraw       =   0
      Editable        =   1
      ShowComboButton =   1
      WordWrap        =   0   'False
      TextStyle       =   0
      TextStyleFixed  =   0
      OleDragMode     =   0
      OleDropMode     =   0
      ComboSearch     =   3
      AutoSizeMouse   =   -1  'True
      FrozenRows      =   0
      FrozenCols      =   0
      AllowUserFreezing=   0
      BackColorFrozen =   0
      ForeColorFrozen =   0
      WallPaperAlignment=   9
      AccessibleName  =   ""
      AccessibleDescription=   ""
      AccessibleValue =   ""
      AccessibleRole  =   24
   End
End
Attribute VB_Name = "FRM_MAN_RELACION_CURVA"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'  Autor          : Pamela Farías
'  Descripción    : Mantención de Relación de Instituciones Financieras
'  Fecha Creación : 03/01/2003
'  Fecha Modificación   : DD/MM/YYYY
'  Modificado Por       : Nombre de la persona que modifica la forma
'  Cambios Realizados   : Explicación de la modificación

Dim nIndice As Integer
Dim nCodigo As Long
Dim cOpcion As String
Dim iContador As Integer
Dim aDatos1()
Dim cSistema As String
Dim cCodigo_producto As String
Dim cTipo_Operacion As String
Dim nCodigo_instrumento As Integer
Dim nCodigo_Moneda As Integer
Dim nCodigo_Moneda2 As Integer
Dim nRut_Emisor As Double
Dim nCodigo_Emisor As Double
Dim iContador_plazos As Integer
Dim Tipo_Evento As String
Dim Area        As String
Dim cArea_Inv   As String
Dim cArea_Btr   As String
Private Function Func_Grabar_Relacion_Curva()

With Grd_Ingreso
   
   If Not BAC_SQL_EXECUTE("BEGIN TRANSACTION") Then GoTo Errores
   
   For iContador = 2 To .Rows - 1

'    If Grd_Ingreso.RowHidden(iContador) = True And Trim(.TextMatrix(iContador, 0)) <> "" Then

        Envia = Array()
        AddParam Envia, Trim(right(Cmb_Sistema.Text, 3))
        AddParam Envia, Trim(right(Cmb_Producto.Text, 4)) '.TextMatrix(iContador, 0)
        AddParam Envia, .TextMatrix(iContador, 1)
        AddParam Envia, Val(.TextMatrix(iContador, 2))
        AddParam Envia, Val(.TextMatrix(iContador, 3))
        AddParam Envia, IIf(Trim(.TextMatrix(iContador, 1)) = "", .TextMatrix(iContador, 3), .TextMatrix(iContador, 4))
        AddParam Envia, Val(.TextMatrix(iContador, 5))
        AddParam Envia, Val(.TextMatrix(iContador, 6))

        If BAC_SQL_EXECUTE("SP_DEL_RELACION_CURVA", Envia) Then

             cOpcion = "03"
             Call LogAuditoria(cOpcion, Opt, Me.Caption, "", "Id_sistema: " & right(Cmb_Sistema.Text, 3) & "Producto:" _
             & Trim(right(Cmb_Producto.Text, 4)) & " Tipo Operacion :" & Trim(Grd_Ingreso.TextMatrix(iContador, 1)) & " Instrumento:" & Trim(Grd_Ingreso.TextMatrix(iContador, 2)) _
             & " Moneda 1 :" & Grd_Ingreso.TextMatrix(iContador, 3) & " Moneda 2 :" & Trim(Grd_Ingreso.TextMatrix(iContador, 4)) & " Rut emisor:" & Trim(Grd_Ingreso.TextMatrix(iContador, 5)) _
             & " Código emisor:" & Trim(Grd_Ingreso.TextMatrix(iContador, 6)) & " Curva " & Trim(Grd_Ingreso.TextMatrix(iContador, 8)))

        Else

            GoTo Errores

        End If

'    End If

   Next iContador


   
   For iContador = 2 To .Rows - 1
   
    If Grd_Ingreso.RowHidden(iContador) = False And Trim(right(Cmb_Producto.Text, 4)) <> "" Then
    
       For iContador_plazos = 2 To Grd_Plazo_Grabar.Rows - 1
       
         If Val(Grd_Plazo_Grabar.TextMatrix(iContador_plazos, 3)) = iContador And Me.Grd_Plazo_Grabar.RowHidden(iContador_plazos) = False Then
         
            Envia = Array()
            AddParam Envia, right(Cmb_Sistema.Text, 3)
            AddParam Envia, Trim(right(Cmb_Producto.Text, 4)) '.TextMatrix(iContador, 0)
            AddParam Envia, .TextMatrix(iContador, 1)
            AddParam Envia, Val(.TextMatrix(iContador, 2))
            AddParam Envia, Val(.TextMatrix(iContador, 3))
            AddParam Envia, IIf(Trim(.TextMatrix(iContador, 1)) = "", .TextMatrix(iContador, 3), .TextMatrix(iContador, 4))
            AddParam Envia, Val(.TextMatrix(iContador, 5))
            AddParam Envia, Val(.TextMatrix(iContador, 6))
            
            AddParam Envia, Trim(Me.Grd_Plazo_Grabar.TextMatrix(iContador_plazos, 2))
            AddParam Envia, CDbl(Trim(Me.Grd_Plazo_Grabar.TextMatrix(iContador_plazos, 0)))
            AddParam Envia, CDbl(Trim(Me.Grd_Plazo_Grabar.TextMatrix(iContador_plazos, 1)))
            AddParam Envia, Mid(IIf(Trim(.TextMatrix(iContador, 9)) = "", " ", Trim(.TextMatrix(iContador, 9))), 1, 1)
            AddParam Envia, Mid(IIf(Trim(.TextMatrix(iContador, 10)) = "", " ", Trim(.TextMatrix(iContador, 10))), 1, 1)
            AddParam Envia, left(Trim(.TextMatrix(iContador, 11)), 1)
            AddParam Envia, Trim(.TextMatrix(iContador, 12))
            If BAC_SQL_EXECUTE("SP_ACT_RELACION_CURVA", Envia) Then
                
               Do While BAC_SQL_FETCH(Datos())
               
                If Datos(1) = "INSERT" Then
                    cOpcion = "01"
                Else
                    cOpcion = "02"
                End If
                
                 Call LogAuditoria(cOpcion, Opt, Me.Caption, "", "Id_sistema: " & right(Cmb_Sistema.Text, 3) & "Producto:" _
                 & Trim(right(Cmb_Producto.Text, 4)) & " Tipo Operacion :" & Trim(Grd_Ingreso.TextMatrix(iContador, 1)) & " Instrumento:" & Trim(Grd_Ingreso.TextMatrix(iContador, 2)) _
                 & " Moneda 1 :" & Grd_Ingreso.TextMatrix(iContador, 3) & " Moneda 2 :" & Trim(Grd_Ingreso.TextMatrix(iContador, 4)) & " Rut emisor:" & Trim(Grd_Ingreso.TextMatrix(iContador, 5)) _
                 & " Código emisor:" & Trim(Grd_Ingreso.TextMatrix(iContador, 6)) & " Curva " & Trim(Grd_Ingreso.TextMatrix(iContador, 8)))
                
               Loop
               
            Else
                GoTo Errores
            End If
            
         End If
        Next iContador_plazos
        
    End If
   Next iContador
    
   If Not BAC_SQL_EXECUTE("COMMIT TRANSACTION") Then GoTo Errores
   MsgBox "Información Grabada Correctamente.", vbOKOnly + vbInformation
  
End With

Call Tlb_Botones_ButtonClick(Tlb_botones.Buttons(1))

Exit Function
Errores:

If Not BAC_SQL_EXECUTE("ROLLBACK TRANSACTION") Then
   MsgBox "Error al Reversar la Acción", vbOKOnly + vbCritical
   Exit Function
End If

MsgBox "Información No fue Grabada.", vbOKOnly + vbCritical

End Function

'********************JUANLIZAMA**********************
'Private Function Func_Leer_Relacion_Curva()
'
'Dim aCurva()  As CCurva
'Dim nFila As Double
'
'With Grd_Ingreso
'
'     cCodigo_producto = ""
'     cTipo_Operacion = ""
'     nCodigo_instrumento = 0
'     nCodigo_Moneda = 0
'     nCodigo_Moneda2 = 0
'     nRut_Emisor = 0
'     nCodigo_Emisor = 0
'     Tipo_Evento = ""
'     Area = ""
'
'      Envia = Array()
'      AddParam Envia, Trim(right(Cmb_Sistema.Text, 3))
'      AddParam Envia, Trim(right(Cmb_Producto.Text, 4))
'
'      If BAC_SQL_EXECUTE("SP_CON_RELACION_CURVA", Envia) Then
'        Do While BAC_SQL_FETCH(Datos())
'              If cCodigo_producto <> Datos(2) Or cTipo_Operacion <> Datos(3) Or nCodigo_instrumento <> Datos(4) Or _
'                nCodigo_Moneda <> Datos(5) Or nCodigo_Moneda2 <> Datos(6) Or nRut_Emisor <> Datos(7) Or nCodigo_Emisor = Datos(9) _
'                Or Tipo_Evento <> Datos(13) Or Area <> Datos(16) Then
'
'                .Rows = .Rows + 1
'                .Row = .Rows - 1
'
'                .TextMatrix(.Row, 0) = Datos(2)
'                .TextMatrix(.Row, 1) = Datos(3)
'                .TextMatrix(.Row, 2) = Datos(4)
'                .TextMatrix(.Row, 3) = Datos(5)
'                .TextMatrix(.Row, 4) = IIf(Datos(3) = "" And Datos(2) <> "ST", 0, Datos(6))
'                .TextMatrix(.Row, 5) = Datos(7)
'                .TextMatrix(.Row, 6) = Datos(8)
'                .TextMatrix(.Row, 7) = Datos(9)
'                .TextMatrix(.Row, 8) = "X"
'                If Trim(Datos(13)) = "O" Then
'                  .TextMatrix(.Row, 9) = "OPERACIONES"
'                ElseIf Trim(Datos(13)) = "C" Then
'                  .TextMatrix(.Row, 9) = "CONTROL PRECIO"
'                ElseIf Trim(Datos(13)) = "V" Then
'                  .TextMatrix(.Row, 9) = "VALORIZACION"
'                End If
'                If Trim(Datos(14)) = "S" Then
'                  .TextMatrix(.Row, 10) = "SI"
'                Else
'                  .TextMatrix(.Row, 10) = " "
'                End If
'
'                .TextMatrix(.Row, 11) = IIf(Datos(15) = "T", "TASA", "PLAZO")
'                .TextMatrix(.Row, 12) = Datos(16)
'                cCodigo_producto = Datos(2)
'                cTipo_Operacion = Datos(3)
'                nCodigo_instrumento = Datos(4)
'                nCodigo_Moneda = Datos(5)
'                nCodigo_Moneda2 = Datos(6)
'                nRut_Emisor = Datos(7)
'                nCodigo_Emisor = Datos(8)
'                Tipo_Evento = Datos(13)
'                Area = Datos(16)
'
'                nFila = .Row
'            End If
'
'            With Me.Grd_Plazo_Grabar
'                .Rows = .Rows + 1
'                .Row = .Rows - 1
'                .TextMatrix(.Row, 0) = Datos(11)
'                .TextMatrix(.Row, 1) = Datos(12)
'                .TextMatrix(.Row, 2) = Datos(10)
'                .TextMatrix(.Row, 3) = nFila
'            End With
'
'        Loop
'
'      End If
'
'        .ColComboList(0) = ""
'
'        Envia = Array()
'        AddParam Envia, right(Cmb_Sistema.Text, 3)
'
'        If BAC_SQL_EXECUTE("Sp_Productos_X_Sistema", Envia) Then
'            Do While BAC_SQL_FETCH(Datos())
'               .ColComboList(0) = .ColComboList(0) & "#" & Datos(1) & ";" & Datos(2) & "|"
'            Loop
'        End If
'
'        .ColComboList(2) = ""
'        .ColComboList(1) = ""
'        .ColComboList(4) = ""
'
'            If right(Cmb_Sistema.Text, 3) = "BTR" Or right(Cmb_Sistema.Text, 3) = "INV" Then
'
'               AddParam Envia, 1
'
'               If BAC_SQL_EXECUTE("SP_CON_TRAER_CODIGOS_GESTION", Envia) Then
'
'                 Do While BAC_SQL_FETCH(Datos())
'
'                   If Datos(1) <> 0 Then
'                    .ColComboList(2) = .ColComboList(2) & "#" & Datos(1) & ";" & Datos(2) & "|"
'                   End If
'                 Loop
'
'               End If
'              Grd_Ingreso.ColWidth(11) = 1000
'              Grd_Ingreso.ColWidth(12) = 1200
'            Else
'
'               .ColComboList(1) = .ColComboList(1) & "#" & "C" & ";" & "COMPRA" & "|"
'               .ColComboList(1) = .ColComboList(1) & "#" & "V" & ";" & "VENTA"
'
'               Grd_Ingreso.ColWidth(11) = 0
'               Grd_Ingreso.ColWidth(12) = 0
'                Envia = Array()
'                AddParam Envia, "BTR"
'                AddParam Envia, 4
'
'                If BAC_SQL_EXECUTE("SP_CON_TRAER_CODIGOS_GESTION", Envia) Then
'
'                 Do While BAC_SQL_FETCH(Datos())
'                   Grd_Ingreso.ColComboList(4) = Grd_Ingreso.ColComboList(4) & "#" & Datos(1) & ";" & Datos(2) & "|"
'                 Loop
'                End If
'            End If
'
'            If .Rows = 3 And Not (right(Cmb_Sistema.Text, 3) = "BTR" Or right(Cmb_Sistema.Text, 3) = "INV") Then
'               .Row = 2
'               .TextMatrix(.Row, 2) = 0
'            '   .TextMatrix(.Row, 4) = 0
'               .TextMatrix(.Row, 5) = 0
'               .TextMatrix(.Row, 6) = 0
'               .TextMatrix(.Row, 7) = ""
'
'            End If
'
'
'            .Refresh
'
'
'         Grd_Ingreso.ColComboList(9) = ""
'         Grd_Ingreso.ColComboList(9) = Grd_Ingreso.ColComboList(9) & "VALORIZACION" & "|"
'         Grd_Ingreso.ColComboList(9) = Grd_Ingreso.ColComboList(9) & "CONTROL PRECIO" & "|"
'         Grd_Ingreso.ColComboList(9) = Grd_Ingreso.ColComboList(9) & "OPERACIONES" & "|"
'
'
'        If .Rows < 3 Then
'            .Rows = 3
'            If right(Cmb_Sistema.Text, 3) = "BTR" Or right(Cmb_Sistema.Text, 3) = "INV" Then
'              .TextMatrix(2, 11) = "PLAZO"
'            End If
'        End If
'        .Row = .Rows - 1
'        .Col = 0
'        .Enabled = True
'        .SetFocus
'
'End With
'
'End Function
'****************************************************


Private Sub Cmb_Sistemas_Change()

End Sub

Private Sub cmb_Producto_Change()
    
    BacControlWindows 1000
    Grd_Ingreso.ColComboList(0) = ""
    Envia = Array()
    AddParam Envia, Grd_Ingreso.TextMatrix(Row, 0)

    If BAC_SQL_EXECUTE("Sp_Productos_X_Sistema", Envia) Then

        Do While BAC_SQL_FETCH(Datos())

           Grd_Ingreso.ColComboList(0) = Grd_Ingreso.ColComboList(0) & "#" & Datos(1) & ";" & Datos(2) & "|"

        Loop
    End If

    Grd_Ingreso.ColComboList(0) = Mid(Grd_Ingreso.ColComboList(1), 1, Len(Grd_Ingreso.ColComboList(1)) - 1)

    Grd_Ingreso.ColComboList(2) = ""
    Grd_Ingreso.ColComboList(1) = ""

    If Grd_Ingreso.TextMatrix(Row, 0) = "BTR" Or Grd_Ingreso.TextMatrix(Row, 0) = "INV" Then

       Grd_Ingreso.TextMatrix(Row, 2) = ""

       AddParam Envia, 1

       If BAC_SQL_EXECUTE("SP_CON_TRAER_CODIGOS_GESTION", Envia) Then

         Do While BAC_SQL_FETCH(Datos())

           Grd_Ingreso.ColComboList(2) = Grd_Ingreso.ColComboList(2) & "#" & Datos(1) & ";" & Datos(2) & "|"

         Loop

       End If
       Grd_Ingreso.ColWidth(11) = 1000
       Grd_Ingreso.ColWidth(12) = 1000
    Else

       Grd_Ingreso.ColComboList(1) = Grd_Ingreso.ColComboList(1) & "#" & "C" & ";" & "COMPRA" & "|"
       Grd_Ingreso.ColComboList(1) = Grd_Ingreso.ColComboList(1) & "#" & "V" & ";" & "VENTA"
       Grd_Ingreso.TextMatrix(Row, 3) = 0
       Grd_Ingreso.TextMatrix(Row, 6) = 0
       Grd_Ingreso.TextMatrix(Row, 7) = 0
       Grd_Ingreso.TextMatrix(Row, 8) = ""
       Grd_Ingreso.ColWidth(11) = 0
       Grd_Ingreso.ColWidth(12) = 0
    End If
    
    
    Grd_Ingreso.Refresh

End Sub

Private Sub Cmb_Sistema_Change()

'    BacControlWindows 1000
'    Grd_Ingreso.ColComboList(0) = ""
'    Envia = Array()
'    AddParam Envia, Grd_Ingreso.TextMatrix(Row, 0)
'
'    If BAC_SQL_EXECUTE("Sp_Productos_X_Sistema", Envia) Then
'
'        Do While BAC_SQL_FETCH(Datos())
'
'           Grd_Ingreso.ColComboList(0) = Grd_Ingreso.ColComboList(0) & "#" & Datos(1) & ";" & Datos(2) & "|"
'
'        Loop
'    End If
'
'    Grd_Ingreso.ColComboList(0) = Mid(Grd_Ingreso.ColComboList(1), 1, Len(Grd_Ingreso.ColComboList(1)) - 1)
'
'    Grd_Ingreso.ColComboList(2) = ""
'    Grd_Ingreso.ColComboList(1) = ""
'
'    If Grd_Ingreso.TextMatrix(Row, 0) = "BTR" Or Grd_Ingreso.TextMatrix(Row, 0) = "INV" Then
'
'       Grd_Ingreso.TextMatrix(Row, 2) = ""
'
'       AddParam Envia, 1
'
'       If BAC_SQL_EXECUTE("SP_CON_TRAER_CODIGOS_GESTION", Envia) Then
'
'         Do While BAC_SQL_FETCH(Datos())
'
'           Grd_Ingreso.ColComboList(2) = Grd_Ingreso.ColComboList(2) & "#" & Datos(1) & ";" & Datos(2) & "|"
'
'         Loop
'
'       End If
'       Grd_Ingreso.ColWidth(11) = 1000
'       Grd_Ingreso.ColWidth(12) = 1000
'    Else
'
'       Grd_Ingreso.ColComboList(1) = Grd_Ingreso.ColComboList(1) & "#" & "C" & ";" & "COMPRA" & "|"
'       Grd_Ingreso.ColComboList(1) = Grd_Ingreso.ColComboList(1) & "#" & "V" & ";" & "VENTA"
'       Grd_Ingreso.TextMatrix(Row, 3) = 0
'       Grd_Ingreso.TextMatrix(Row, 6) = 0
'       Grd_Ingreso.TextMatrix(Row, 7) = 0
'       Grd_Ingreso.TextMatrix(Row, 8) = ""
'       Grd_Ingreso.ColWidth(11) = 0
'       Grd_Ingreso.ColWidth(12) = 0
'    End If
'    Grd_Ingreso.Refresh


End Sub



Private Sub Form_Activate()
   PROC_CARGA_AYUDA Me, " "
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyF2 And Grd_Ingreso.TextMatrix(Grd_Ingreso.Row, 8) = "X" And Grd_Ingreso.Col <> 7 Then
     KeyCode = 0
     Exit Sub
   End If
   
   nOpcion = 0
   If KeyCode <> vbKeyControl And (Shift = 2 Or (Shift = 0 And (KeyCode = vbKeyReturn Or KeyCode = vbKeyEscape Or (KeyCode >= vbKeyF1 And KeyCode <= vbKeyF12)))) Then
     
        Select Case KeyCode
            Case vbKeyLimpiar:
                            nOpcion = 1
   
            Case vbKeyGrabar:
                            nOpcion = 2
                           
            Case vbKeyBuscar:
                            nOpcion = 3

            Case vbKeyEliminar:
                            nOpcion = 4

            Case vbKeySalir:
                            nOpcion = 5
                      
      End Select

      If nOpcion <> 0 Then
            If Tlb_botones.Buttons(nOpcion).Enabled Then
               Call Tlb_Botones_ButtonClick(Tlb_botones.Buttons(nOpcion))
            End If
            KeyCode = 0
            If nOpcion = 5 Then
                Unload Me
            End If
      End If
      
   End If


End Sub

Private Sub Form_Load()
Call Func_Llenar_Combos
Grd_Ingreso.ColHidden(8) = True
Me.Icon = BAC_Parametros.Icon
Me.top = 0
Me.left = 0
End Sub

Private Function Func_Llenar_Combos()

Grd_Ingreso.ColComboList(0) = ""

Envia = Array()
AddParam Envia, ""
AddParam Envia, 8
    
If BAC_SQL_EXECUTE("SP_CON_TRAER_CODIGOS_GESTION", Envia) Then
        
 Do While BAC_SQL_FETCH(Datos())
 
  If Datos(3) = "S" And Datos(4) = "N" And Datos(5) = "S" Then
   Cmb_Sistema.AddItem Datos(2) & Space(100) & Datos(1)
  End If
       
 Loop

End If
Cmb_Sistema.ListIndex = 0
Grd_Ingreso.ColComboList(3) = ""
Grd_Ingreso.ColComboList(4) = ""
Grd_Ingreso.ColComboList(9) = ""

 Grd_Ingreso.ColComboList(9) = Grd_Ingreso.ColComboList(9) & "VALORIZACION" & "|"
 Grd_Ingreso.ColComboList(9) = Grd_Ingreso.ColComboList(9) & "CONTROL PRECIO" & "|"
 Grd_Ingreso.ColComboList(9) = Grd_Ingreso.ColComboList(9) & "OPERACIONES" & "|"

 Grd_Ingreso.ColComboList(10) = Grd_Ingreso.ColComboList(10) & "  " & "|"
 Grd_Ingreso.ColComboList(10) = Grd_Ingreso.ColComboList(10) & "SI" & "|"
 
 Grd_Ingreso.ColComboList(11) = Grd_Ingreso.ColComboList(11) & "  " & "|"
 Grd_Ingreso.ColComboList(11) = Grd_Ingreso.ColComboList(11) & "TASA" & "|"
 
 
Envia = Array()
AddParam Envia, "BTR"
AddParam Envia, 4
    
If BAC_SQL_EXECUTE("SP_CON_TRAER_CODIGOS_GESTION", Envia) Then
        
 Do While BAC_SQL_FETCH(Datos())
   Grd_Ingreso.ColComboList(3) = Grd_Ingreso.ColComboList(3) & "#" & Datos(1) & ";" & Datos(2) & "|"
 Loop
End If

Envia = Array()
If BAC_SQL_EXECUTE("Sp_Leer_Area_Producto") Then
        
Do While BAC_SQL_FETCH(Datos())
   If Datos(5) = 1 Then
    cArea_Btr = Datos(1)
   End If
   
   If Datos(6) = 1 Then
    cArea_Inv = Datos(1)
   End If
   
   Grd_Ingreso.ColComboList(12) = Grd_Ingreso.ColComboList(12) & "#" & Datos(1) & ";" & Datos(1) & "|"
Loop
   
   

End If



End Function

Private Sub Grd_Ingreso_AfterEdit(ByVal Row As Long, ByVal Col As Long)

If Col = 5 Then
    Grd_Ingreso.TextMatrix(Row, Col) = Val(Grd_Ingreso.TextMatrix(Grd_Ingreso.Row, Col))
End If

If Grd_Ingreso.Col = 5 Then
   If Not Func_Leer_Emisor(Val(Grd_Ingreso.TextMatrix(Row, 5))) Then
    MsgBox "Emisor, no Existe", vbOKOnly + vbInformation
    Grd_Ingreso.TextMatrix(Row, 5) = 0
    Grd_Ingreso.TextMatrix(Row, 6) = 0
    Grd_Ingreso.TextMatrix(Row, 7) = ""
    Grd_Ingreso.Col = 5
    Grd_Ingreso.SetFocus
   End If
End If


 If Grd_Ingreso.Col = 9 And Grd_Ingreso.TextMatrix(Row, Col) = "VALORIZACION" Then
    Grd_Ingreso.TextMatrix(Row, 12) = "N/A"
'Else
 ' If (Right(Cmb_Sistema.Text, 3) = "BTR" Or Right(Cmb_Sistema.Text, 3) = "INV") And Grd_Ingreso.Col = 9 And (Grd_Ingreso.TextMatrix(Row, 12) = "N/A" Or Trim(Grd_Ingreso.TextMatrix(Row, 12)) = "") Then
 '   Grd_Ingreso.TextMatrix(Row, 12) = IIf(Right(Cmb_Sistema.Text, 3) = "BTR", cArea_Btr, cArea_Inv)
 ' End If
End If


If Not FUNC_VALIDAR_REPETIDOS Then
    MsgBox "Registro Repetidos,Modificar", vbInformation
End If
End Sub

Private Function FUNC_VALIDAR_REPETIDOS() As Boolean
Dim nContador, i As Integer
Dim Fila As Integer

FUNC_VALIDAR_REPETIDOS = True

With Grd_Ingreso

Fila = .Row

For i = 2 To .Rows - 1
 If .RowHidden(i) = False Then
    .Row = i
    
    For nContador = 2 To .Rows - 1
     If nContador <> .Row And .RowHidden(nContador) = False Then
       If right(Cmb_Sistema.Text, 3) = "BTR" Or right(Cmb_Sistema.Text, 3) = "INV" Then
      
         If (Trim(.TextMatrix(nContador, 0)) = Trim(.TextMatrix(.Row, 0)) _
         And Val(Trim(.TextMatrix(nContador, 3))) = Val(Trim(.TextMatrix(.Row, 3))) _
         And Val(Trim(.TextMatrix(nContador, 2))) = Val(Trim(.TextMatrix(.Row, 2))) _
         And Val(Trim(.TextMatrix(nContador, 5))) = Val(Trim(.TextMatrix(.Row, 5))) _
         And Val(Trim(.TextMatrix(nContador, 6))) = Val(Trim(.TextMatrix(.Row, 6))) _
         And Trim(.TextMatrix(nContador, 12)) = Trim(.TextMatrix(.Row, 12)) _
         And Trim(.TextMatrix(nContador, 9)) = Trim(.TextMatrix(.Row, 9))) _
         And .RowHidden(nContador) = False Then
            
            
            FUNC_VALIDAR_REPETIDOS = False
            Exit Function
            
         End If
      Else
         If (Trim(.TextMatrix(nContador, 0)) = Trim(.TextMatrix(.Row, 0)) And Trim(.TextMatrix(nContador, 1)) = Trim(.TextMatrix(.Row, 1)) _
         And Val(Trim(.TextMatrix(nContador, 3))) = Val(Trim(.TextMatrix(.Row, 3))) And Val(Trim(.TextMatrix(nContador, 4))) = Val(Trim(.TextMatrix(.Row, 4))) _
         And Trim(.TextMatrix(nContador, 9)) = Trim(.TextMatrix(.Row, 9))) And .RowHidden(nContador) = False Then
         
            FUNC_VALIDAR_REPETIDOS = False
            Exit Function
         End If
      End If
    End If
      
    Next nContador
 End If
Next i
End With


End Function

Private Function FUNC_VALIDA_BLANCOS() As Boolean

With Grd_Ingreso
   
      For nContador = 2 To .Rows - 1
      
      If right(Cmb_Sistema.Text, 3) = "BTR" Or right(Cmb_Sistema.Text, 3) = "INV" Then
      
         If (Val(Trim(.TextMatrix(nContador, 3))) = 0 _
         Or IIf(Replace("CI,VI,CIX,VIX,IB,ICOL,ICAP", Trim(.TextMatrix(nContador, 0)), "") <> "CI,VI,CIX,VIX,IB,ICOL,ICAP", False, Val(Trim(.TextMatrix(nContador, 2))) = 0) _
         Or IIf(Replace("CI,VI,CIX,VIX,IB,ICOL,ICAP", Trim(.TextMatrix(nContador, 0)), "") <> "CI,VI,CIX,VIX,IB,ICOL,ICAP", False, Val(Trim(.TextMatrix(nContador, 5))) = 0) _
         Or IIf(Replace("CI,VI,CIX,VIX,IB,ICOL,ICAP", Trim(.TextMatrix(nContador, 0)), "") <> "CI,VI,CIX,VIX,IB,ICOL,ICAP", False, Val(Trim(.TextMatrix(nContador, 6))) = 0) _
         Or Trim(.TextMatrix(nContador, 11)) = "" Or (Trim(.TextMatrix(nContador, 12)) = "" Or (Trim(.TextMatrix(nContador, 12)) = "N/A" _
         And Grd_Ingreso.TextMatrix(nContador, 9) = "VALORIZACION"))) And .RowHidden(nContador) = False Then
         
            FUNC_VALIDA_BLANCOS = False
            Exit Function
            
         End If
      Else
         If (Trim(.TextMatrix(nContador, 1)) = "" _
         Or Val(Trim(.TextMatrix(nContador, 3))) = 0 Or Val(Trim(.TextMatrix(nContador, 4))) = 0 _
         ) And Trim(Grd_Ingreso.TextMatrix(nContador, 0)) <> "ST" And .RowHidden(nContador) = False Then
         
            FUNC_VALIDA_BLANCOS = False
            Exit Function
            
         ElseIf (Val(Trim(.TextMatrix(nContador, 3))) = 0 Or Val(Trim(.TextMatrix(nContador, 4))) = 0 _
         ) And Trim(Grd_Ingreso.TextMatrix(nContador, 0)) = "ST" And Trim(Grd_Ingreso.TextMatrix(Grd_Ingreso.Row, 0)) <> "ST" And .RowHidden(nContador) = False Then
         
            FUNC_VALIDA_BLANCOS = False
            Exit Function
         
         End If
      End If
         
      Next nContador
      
      FUNC_VALIDA_BLANCOS = True
      
End With

End Function

Private Function FUNC_VALIDA_BLANCO() As Boolean

With Grd_Ingreso
   
      nContador = .Row
      
      If right(Cmb_Sistema.Text, 3) = "BTR" Or right(Cmb_Sistema.Text, 3) = "INV" Then
      
'         If (Trim(.TextMatrix(nContador, 0)) = "" Or Val(Trim(.TextMatrix(nContador, 2))) = 0 _
'         Or Val(Trim(.TextMatrix(nContador, 3))) = 0 _
'         Or Val(Trim(.TextMatrix(nContador, 5))) = 0 Or Val(Trim(.TextMatrix(nContador, 6))) = 0 _
'         Or Trim(.TextMatrix(nContador, 8)) = "") And .RowHidden(nContador) = False Then
'
        If (Trim(right(Cmb_Producto.Text, 4)) = "" Or Val(Trim(.TextMatrix(nContador, 3))) = 0 _
         Or IIf(Replace("CI,VI,CIX,VIX,IB,ICOL,ICAP", Trim(.TextMatrix(nContador, 0)), "") <> "CI,VI,CIX,VIX,IB,ICOL,ICAP", False, Val(Trim(.TextMatrix(nContador, 2))) = 0) _
         Or IIf(Replace("CI,VI,CIX,VIX,IB,ICOL,ICAP", Trim(.TextMatrix(nContador, 0)), "") <> "CI,VI,CIX,VIX,IB,ICOL,ICAP", False, Val(Trim(.TextMatrix(nContador, 5))) = 0) _
         Or IIf(Replace("CI,VI,CIX,VIX,IB,ICOL,ICAP", Trim(.TextMatrix(nContador, 0)), "") <> "CI,VI,CIX,VIX,IB,ICOL,ICAP", False, Val(Trim(.TextMatrix(nContador, 6))) = 0) _
         Or Trim(.TextMatrix(nContador, 11)) = "" Or (Trim(.TextMatrix(nContador, 12)) = "" Or (Trim(.TextMatrix(nContador, 12)) = "N/A" _
         And Grd_Ingreso.TextMatrix(nContador, 9) = "VALORIZACION"))) Then
         
            FUNC_VALIDA_BLANCO = False
            Exit Function
         End If
      Else
         If (Trim(right(Cmb_Producto.Text, 4)) = "" Or Trim(.TextMatrix(nContador, 1)) = "" _
         Or Val(Trim(.TextMatrix(nContador, 3))) = 0 Or Val(Trim(.TextMatrix(nContador, 4))) = 0 _
         Or Trim(.TextMatrix(nContador, 8)) = "") And Trim(Grd_Ingreso.TextMatrix(Grd_Ingreso.Row, 0)) <> "ST" And .RowHidden(nContador) = False Then
         
            FUNC_VALIDA_BLANCO = False
            Exit Function
            
         ElseIf (Trim(right(Cmb_Producto.Text, 4)) = "" _
         Or Val(Trim(.TextMatrix(nContador, 3))) = 0 Or Val(Trim(.TextMatrix(nContador, 4))) = 0 _
         Or Trim(.TextMatrix(nContador, 8)) = "") And Trim(Grd_Ingreso.TextMatrix(Grd_Ingreso.Row, 0)) = "ST" And .RowHidden(nContador) = False Then
         
            FUNC_VALIDA_BLANCO = False
            Exit Function
         End If
      End If
         
      
      
      FUNC_VALIDA_BLANCO = True
      
End With

End Function

Private Function Func_Leer_Emisor(iRut As Double) As Boolean

    Func_Leer_Emisor = False
    Envia = Array()
    AddParam Envia, iRut

    If Not BAC_SQL_EXECUTE("sp_trae_emisor", Envia) Then Exit Function
    If Not BAC_SQL_FETCH(Datos()) Then Exit Function
           Grd_Ingreso.TextMatrix(Grd_Ingreso.Row, 6) = Val(Datos(1))
           Grd_Ingreso.TextMatrix(Grd_Ingreso.Row, 7) = Datos(4)
       
    Func_Leer_Emisor = True
End Function

Private Sub Grd_Ingreso_BeforeEdit(ByVal Row As Long, ByVal Col As Long, Cancel As Boolean)

If Col <> 8 And Grd_Ingreso.TextMatrix(Row, 8) = "X" Then
    'Cancel = True
End If

If Col = 2 And right(Cmb_Sistema.Text, 3) = "BTR" And _
   (Trim(Grd_Ingreso.TextMatrix(Grd_Ingreso.Row, 0)) = "VI" Or _
   Trim(Grd_Ingreso.TextMatrix(Grd_Ingreso.Row, 0)) = "CI" Or _
   Trim(Grd_Ingreso.TextMatrix(Grd_Ingreso.Row, 0)) = "CIX" Or _
   Trim(Grd_Ingreso.TextMatrix(Grd_Ingreso.Row, 0)) = "VIX" Or _
   Trim(Grd_Ingreso.TextMatrix(Grd_Ingreso.Row, 0)) = "IB") Then
    
   Cancel = True
    
End If

If Col = 1 And right(Cmb_Sistema.Text, 3) = "SWP" And Trim(Grd_Ingreso.TextMatrix(Grd_Ingreso.Row, 0)) = "ST" Then
    Cancel = True
End If

If Col = 5 And right(Cmb_Sistema.Text, 3) = "BTR" And _
   (Trim(Grd_Ingreso.TextMatrix(Grd_Ingreso.Row, 0)) = "VI" Or _
   Trim(Grd_Ingreso.TextMatrix(Grd_Ingreso.Row, 0)) = "CI" Or _
   Trim(Grd_Ingreso.TextMatrix(Grd_Ingreso.Row, 0)) = "CIX" Or _
   Trim(Grd_Ingreso.TextMatrix(Grd_Ingreso.Row, 0)) = "VIX" Or _
   Trim(Grd_Ingreso.TextMatrix(Grd_Ingreso.Row, 0)) = "IB") Then

   Cancel = True
    
End If

If Grd_Ingreso.Col = 12 And Grd_Ingreso.TextMatrix(Row, 9) <> "VALORIZACION" Then
    Grd_Ingreso.TextMatrix(Row, 12) = "N/A"
    Cancel = True
End If

End Sub

Private Sub Grd_Ingreso_DblClick()
    Call Tlb_Botones_ButtonClick(Tlb_botones.Buttons(5))

End Sub

Private Sub Grd_Ingreso_KeyDown(KeyCode As Integer, Shift As Integer)

With Grd_Ingreso

    Select Case KeyCode
 
     Case vbKeyInsert
       If FUNC_VALIDA_BLANCOS Then
         .Rows = .Rows + 1
         .Row = .Rows - 1
         .TextMatrix(.Row, 11) = "PLAZO"
         .TopRow = .Row
         .Col = 0
         .Refresh
       Else
         MsgBox "Hay registros en Blanco o falta un dato", vbOKOnly + vbInformation
         .SetFocus
       End If
     Case vbKeyDelete
     
     If .Row <> 0 Then
      
        If Not FUNC_VALIDA_BLANCO Then
          .RemoveItem (.Row)
        Else
          .RowHidden(.Row) = True
        End If
        
        If FUNC_VALIDAR_UNA_FILA Then
                  .Rows = .Rows + 1
                  .Row = .Rows - 1
                  .TextMatrix(.Row, 11) = "PLAZO"
                  .Col = 0
        Else
                  KeyCode = 40
        End If
           
                 .SetFocus
        
        
     End If
    Case vbKeyF3
       
        If Grd_Ingreso.Col = 5 And (right(Cmb_Sistema.Text, 3) = "BTR" Or right(Cmb_Sistema.Text, 3) = "INV") Then

            MiTag = "MDEM"
            BacAyuda.Show 1
            
            If giAceptar% = True Then
               Grd_Ingreso.TextMatrix(Grd_Ingreso.Row, 5) = gsCodigo$
               Grd_Ingreso.TextMatrix(Grd_Ingreso.Row, 6) = gsrut$
               Grd_Ingreso.TextMatrix(Grd_Ingreso.Row, 7) = gsDescripcion$
            End If
   
        End If
    End Select
    
End With

End Sub


Private Function FUNC_VALIDAR_UNA_FILA() As Boolean

FUNC_VALIDAR_UNA_FILA = False

nCodigo = 2
nIndice = 0

For nIndice = 2 To Grd_Ingreso.Rows - 1
   If Grd_Ingreso.RowHidden(nIndice) = True Then
         nCodigo = nCodigo + 1
   End If
Next nIndice

If nCodigo = nIndice Then

   FUNC_VALIDAR_UNA_FILA = True
End If

End Function


Private Sub Grd_Ingreso_KeyDownEdit(ByVal Row As Long, ByVal Col As Long, KeyCode As Integer, ByVal Shift As Integer)
If KeyCode = vbKeyReturn Then

       
       If (Grd_Ingreso.Col + 1 = 13 And (right(Cmb_Sistema.Text, 3) = "BTR" Or right(Cmb_Sistema.Text, 3) = "INV")) Or (Grd_Ingreso.Col + 1 = 11 And (right(Cmb_Sistema.Text, 3) <> "BTR" And right(Cmb_Sistema.Text, 3) <> "INV")) Then
         Grd_Ingreso.Col = 0
         Grd_Ingreso.LeftCol = Grd_Ingreso.Col
       Else
        If (Grd_Ingreso.Col = 0 Or Grd_Ingreso.Col = 3) And (right(Cmb_Sistema.Text, 3) = "BTR" Or right(Cmb_Sistema.Text, 3) = "INV") Then
           Grd_Ingreso.Col = Grd_Ingreso.Col + 2
        ElseIf Grd_Ingreso.Col = 5 And (right(Cmb_Sistema.Text, 3) = "BTR" Or right(Cmb_Sistema.Text, 3) = "INV") Then
           Grd_Ingreso.Col = Grd_Ingreso.Col + 3
           Grd_Ingreso.LeftCol = Grd_Ingreso.Col
        ElseIf Grd_Ingreso.Col = 1 And (right(Cmb_Sistema.Text, 3) <> "BTR" And right(Cmb_Sistema.Text, 3) <> "INV") Then
           Grd_Ingreso.Col = Grd_Ingreso.Col + 2
        ElseIf Grd_Ingreso.Col = 4 And (right(Cmb_Sistema.Text, 3) <> "BTR" And right(Cmb_Sistema.Text, 3) <> "INV") Then
            Grd_Ingreso.Col = 8
            Grd_Ingreso.LeftCol = Grd_Ingreso.Col
        Else
           Grd_Ingreso.Col = Grd_Ingreso.Col + 1
        End If
       End If
        
        Grd_Ingreso.SetFocus
End If
End Sub

Private Sub Grd_Ingreso_KeyPress(KeyAscii As Integer)

If Grd_Ingreso.TextMatrix(Grd_Ingreso.Row, 8) = "X" And Grd_Ingreso.Col <> 7 Then
    KeyAscii = 0
    Exit Sub
End If

If Grd_Ingreso.Col = 6 Or Grd_Ingreso.Col = 7 Then
     KeyAscii = 0
     Grd_Ingreso.EditMaxLength = 0
     Exit Sub
End If

If (right(Cmb_Sistema.Text, 3) = "BTR" Or right(Cmb_Sistema.Text, 3) = "INV") And (Grd_Ingreso.Col = 1 Or Grd_Ingreso.Col = 4) Then
     KeyAscii = 0
     Grd_Ingreso.EditMaxLength = 0
ElseIf Not (right(Cmb_Sistema.Text, 3) = "BTR" Or right(Cmb_Sistema.Text, 3) = "INV") Then
    If Grd_Ingreso.Col = 2 Or Grd_Ingreso.Col = 5 Then
        KeyAscii = 0
        Grd_Ingreso.EditMaxLength = 0
    End If
End If
End Sub

Private Sub Grd_Plazos_Click()

End Sub

Private Sub Tlb_Botones_ButtonClick(ByVal Button As MSComctlLib.Button)

Select Case Button.Index
Case 1
    
     Tlb_botones.Buttons(3).Enabled = True
     Tlb_botones.Buttons(4).Enabled = False
     Tlb_botones.Buttons(5).Enabled = False
     Tlb_botones.Buttons(2).Enabled = False
     Grd_Ingreso.Rows = 3
     Grd_Ingreso.RemoveItem (2)
     Grd_Ingreso.Rows = 2
     Grd_Plazo_Grabar.Rows = 3
     Grd_Plazo_Grabar.RemoveItem (2)
     Grd_Plazo_Grabar.Rows = 2
     Grd_Ingreso.Enabled = False
     Cmb_Sistema.Enabled = True
     Cmb_Producto.Enabled = True
     PROC_NOCULTA_COL
     
Case 2

    If Not FUNC_VALIDAR_REPETIDOS Then
     MsgBox "Registros Repetidos,Modificar o Eliminar", vbInformation
     Exit Sub
    End If

    If FUNC_VALIDA_BLANCOS Then
     If FUNC_VALIDAR_PLAZOS Then
       Call Func_Grabar_Relacion_Curva
     Else
       MsgBox "Debe ingresar Rango de Plazos  ", vbInformation
     End If
     
    Else
      MsgBox "Faltan Datos para la Grabación", vbInformation
      Grd_Ingreso.SetFocus
    End If
   
Case 3
     
      If Trim(right(Cmb_Producto.Text, 10)) = "" Then
        MsgBox "Debe Ingresar Producto", vbInformation
        Cmb_Producto.SetFocus
      Exit Sub
      End If
      
     Cmb_Sistema.Enabled = False
     Cmb_Producto.Enabled = False
     
'**************JUANLIZAMA****************
'     Call Func_Leer_Relacion_Curva
'****************************************
     Tlb_botones.Buttons(3).Enabled = False
     Tlb_botones.Buttons(2).Enabled = True
     Tlb_botones.Buttons(4).Enabled = True
     Tlb_botones.Buttons(5).Enabled = True
     PROC_OCULTAR_COL
     
Case 4

 If MsgBox("¿ Seguro de Eliminar Todos los Registros del Sistema " & left(Cmb_Sistema.Text, 30) & "?", vbYesNo + vbInformation) = vbYes Then
    Call Func_Eliminar_Sistema
 End If

Case 5
    FRM_PLAZO.cTipo = IIf(left(Grd_Ingreso.TextMatrix(Grd_Ingreso.Row, 11), 1) = "T", "T", "P")
    FRM_PLAZO.nGrupo = Grd_Ingreso.Row
   FRM_PLAZO.Show vbModal
    
Case 6
    Unload Me
End Select
End Sub


Private Function FUNC_VALIDAR_PLAZOS() As Boolean
Dim nSw As Integer
FUNC_VALIDAR_PLAZOS = False
nSw = 1

For iContador = 2 To Me.Grd_Ingreso.Rows - 1
   
   For iContador_plazos = 2 To Grd_Plazo_Grabar.Rows - 1
   
         If Val(Grd_Plazo_Grabar.TextMatrix(iContador_plazos, 3)) = iContador And Me.Grd_Plazo_Grabar.RowHidden(iContador_plazos) = False Then
            nSw = nSw + 1
            Exit For
         End If
   Next iContador_plazos

Next iContador
If nSw = Me.Grd_Ingreso.Rows - 1 Then
    FUNC_VALIDAR_PLAZOS = True
End If
End Function

Private Function Func_Eliminar_Sistema()

        Envia = Array()
        AddParam Envia, right(Cmb_Sistema.Text, 3)
        If BAC_SQL_EXECUTE("SP_DEL_RELACION_CURVA_SISTEMA", Envia) Then
        
             cOpcion = "03"
             Call LogAuditoria(cOpcion, Opt, Me.Caption, "", "Id_sistema: " & right(Cmb_Sistema.Text, 3))
             MsgBox "Información Eliminada Correctamente.", vbOKOnly + vbInformation
 
        Else
             MsgBox "Información No fue Eliminada.", vbOKOnly + vbCritical
        End If
        Call Tlb_Botones_ButtonClick(Tlb_botones.Buttons(1))
     
End Function

Private Sub Cmb_Sistema_Click()
   PROC_CARGA_PRODUCTOS Trim(right(Cmb_Sistema.Text, 5))
End Sub

Sub PROC_CARGA_PRODUCTOS(cID_Sistema As String)
   Envia = Array()
   AddParam Envia, cID_Sistema
   If Not BAC_SQL_EXECUTE("Sp_Productos_X_Sistema", Envia) Then Exit Sub
   Cmb_Producto.Clear
   Do While BAC_SQL_FETCH(Datos())
      Cmb_Producto.AddItem Datos(2) & Space(100) & Datos(1)
   Loop

End Sub

Sub PROC_OCULTAR_COL()
    ' SE OCULTA EL PRODUCTO
    Grd_Ingreso.ColHidden(0) = True
    
    If Grd_Ingreso.TextMatrix(Grd_Ingreso.Row, 8) = "X" Then
        Grd_Ingreso.ColHidden(7) = True
    End If
    
    '  If Grd_Ingreso.Col = 6 Or Grd_Ingreso.Col = 7 Then
    '        KeyAscii = 0
    '       Grd_Ingreso.EditMaxLength = 0
    '      Exit Sub
    ' End If
    
    If (right(Cmb_Sistema.Text, 3) = "BTR" Or right(Cmb_Sistema.Text, 3) = "INV") Then
         Grd_Ingreso.ColHidden(1) = True
         Grd_Ingreso.ColHidden(4) = True
         
    ElseIf Not (right(Cmb_Sistema.Text, 3) = "BTR" Or right(Cmb_Sistema.Text, 3) = "INV") Then
         'Grd_Ingreso.ColHidden(2) = True
         'Grd_Ingreso.ColHidden(5) = True
    End If

End Sub



Sub PROC_NOCULTA_COL()
    Grd_Ingreso.ColHidden(0) = True
    Grd_Ingreso.ColHidden(7) = False
    Grd_Ingreso.ColHidden(1) = False
    Grd_Ingreso.ColHidden(4) = False
    Grd_Ingreso.ColHidden(2) = False
    Grd_Ingreso.ColHidden(5) = False
    Grd_Ingreso.Refresh
End Sub


