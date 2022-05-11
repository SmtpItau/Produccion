VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form FRM_MNT_MOTIVOBLOQUEOS 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantención de Motivos de Bloqueos de Clientes"
   ClientHeight    =   5955
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   6315
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   5955
   ScaleWidth      =   6315
   Begin VB.TextBox txtCodigo 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   210
      TabIndex        =   3
      Top             =   1350
      Width           =   1275
   End
   Begin VB.TextBox txtDetalle 
      Appearance      =   0  'Flat
      BorderStyle     =   0  'None
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
      Left            =   2505
      TabIndex        =   2
      Top             =   1365
      Width           =   2415
   End
   Begin MSFlexGridLib.MSFlexGrid grilla 
      Height          =   5265
      Left            =   30
      TabIndex        =   1
      Top             =   585
      Width           =   6240
      _ExtentX        =   11007
      _ExtentY        =   9287
      _Version        =   393216
      FixedCols       =   0
      BackColorFixed  =   -2147483647
      ForeColorFixed  =   -2147483639
      AllowUserResizing=   2
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   4275
      Top             =   -15
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   9
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MNT_MOTIVOBLOQUEOS.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MNT_MOTIVOBLOQUEOS.frx":0EDA
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MNT_MOTIVOBLOQUEOS.frx":1DB4
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MNT_MOTIVOBLOQUEOS.frx":2C8E
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MNT_MOTIVOBLOQUEOS.frx":3B68
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MNT_MOTIVOBLOQUEOS.frx":4A42
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MNT_MOTIVOBLOQUEOS.frx":591C
            Key             =   ""
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MNT_MOTIVOBLOQUEOS.frx":67F6
            Key             =   ""
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MNT_MOTIVOBLOQUEOS.frx":6B10
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
      Width           =   6315
      _ExtentX        =   11139
      _ExtentY        =   794
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      DisabledImageList=   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   6
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Eliminar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   9
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
End
Attribute VB_Name = "FRM_MNT_MOTIVOBLOQUEOS"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim allMsg As String
Private Sub Form_Load()
    Me.Top = 0
    Me.Left = 0
    Me.Icon = BACSwapParametros.Icon
    Call seteaGrilla(grilla)
    
    txtCodigo.Visible = False
    
    txtDetalle.Visible = False
    Call Buscar
End Sub
Private Sub seteaGrilla(ByVal grilla As MSFlexGrid)
    grilla.WordWrap = True
    grilla.Rows = 2:      grilla.Cols = 4
    grilla.Row = 1:       grilla.Col = 1
    grilla.FixedRows = 1: grilla.FixedCols = 0
    grilla.RowHeight(0) = 280
    grilla.RowHeight(1) = 280
        
    grilla.TextMatrix(0, 0) = "Código":        grilla.ColWidth(0) = 1000:  grilla.TextMatrix(1, 0) = ""
    grilla.TextMatrix(0, 1) = "Descripción":   grilla.ColWidth(1) = 5000:   grilla.TextMatrix(1, 1) = ""
    grilla.TextMatrix(0, 2) = "Estado":   grilla.ColWidth(2) = 0:   grilla.TextMatrix(1, 2) = ""
    grilla.TextMatrix(0, 3) = "Origen":   grilla.ColWidth(3) = 0:   grilla.TextMatrix(1, 3) = ""

End Sub

Private Sub grilla_Click()
    Dim pcol As Long
    Dim fila As Long
    pcol = grilla.Col
    fila = grilla.Row
    If fila = 0 Then
        Exit Sub
    End If
    If pcol = 0 Then
        Exit Sub
    End If
    
End Sub
Private Sub grilla_KeyDown(KeyCode As Integer, Shift As Integer)
    Dim ultFila As Long
    Dim pcol As Long
    Dim fila As Long
    Dim ultcod As Long
    Dim codMotivo As Long
    Dim motivo As String
    pcol = grilla.Col
    fila = grilla.Row

    If KeyCode = vbKeyInsert Then
        ultFila = grilla.Row
        'Revisar si la fila anterior está vacía.  Si no lo está, insertar.
        If FilaVacia(ultFila) Then
            Exit Sub
        End If
        'Revisar si la última fila está vacía...
        If FilaVacia(grilla.Rows - 1) Then
            Exit Sub
        End If
        ultcod = CLng(grilla.TextMatrix(ultFila, 0))
        grilla.Rows = grilla.Rows + 1
        grilla.RowHeight(grilla.Rows - 1) = 280
        grilla.Row = grilla.Rows - 1
        grilla.TextMatrix(grilla.Row, 2) = "I"
        Exit Sub
    End If
    If KeyCode = vbKeyReturn Then
        If Trim(grilla.TextMatrix(grilla.Row, 0)) <> "" Then
            codMotivo = CLng(grilla.TextMatrix(grilla.Row, 0))
            If codMotivo = 0 Then
                'Motivo por defecto no se puede editar
                Exit Sub
            End If
        End If
        
        '-----Corregido 18-11-2011-------------
        '¿El dato viene de la tabla?
        If grilla.TextMatrix(grilla.Row, 3) = "*" Then
            'Si viene de la tabla --> está actualizando, o sea, "U"
            grilla.TextMatrix(grilla.Row, 2) = "U"
        Else    ' Es un caso nuevo
            grilla.TextMatrix(grilla.Row, 2) = "I"
        End If
        '-----Fin Corregido 18-11-2011-------------

        If pcol = 0 Then
        'Si grilla.TextMatrix(fila,3) = "*" --> viene de la tabla, no permitir editar
            If grilla.TextMatrix(fila, 3) <> "*" Then
                txtCodigo.Text = grilla.TextMatrix(fila, pcol)
                txtCodigo.Visible = True
                txtCodigo.SetFocus
            End If
        Else
            txtDetalle.Text = grilla.TextMatrix(fila, pcol)
        txtDetalle.Visible = True
        txtDetalle.SetFocus
        End If
        Exit Sub
    End If
    If KeyCode = vbKeyDelete Then
        If Trim(grilla.TextMatrix(grilla.Row, 0)) = "" Then
            Exit Sub
        End If
        codMotivo = CLng(grilla.TextMatrix(grilla.Row, 0))
        If codMotivo = 0 Then
            MsgBox "El motivo por defecto no se puede eliminar!", vbExclamation
            Exit Sub
        End If
        motivo = grilla.TextMatrix(grilla.Row, 1)
        Msg = "¿Confirma la eliminación del motivo?" & vbCrLf & "[" & motivo & "]"
        If MsgBox(Msg, vbYesNo) = vbYes Then
            grilla.TextMatrix(grilla.Row, 2) = "D"
            grilla.RowHeight(grilla.Row) = 0
        End If
    End If
End Sub
Private Function FilaVacia(ByVal fila As Long) As Boolean
FilaVacia = False
If grilla.TextMatrix(fila, 0) = "" And grilla.TextMatrix(fila, 1) = "" Then
    FilaVacia = True
End If
End Function

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
    Select Case Button.Index
        Case 1
            Call LimpiarGrilla
        Case 2
            Call Buscar
        Case 3
            Call Borrar
        Case 4
            Call Grabar
        Case 5
            Unload Me
    End Select
End Sub
Private Function Borrar() As Boolean
    Dim ulFila As Long
    Dim Msg As String
    Dim motivo As String
    Dim codMotivo As Long
    If txtDetalle.Visible = True Then
        txtDetalle.Visible = False
    End If
    'Ver si la fila es "borrable"
    If grilla.Row = 0 Then
        Borrar = False
        Exit Function
    End If
    ulFila = grilla.Rows - 1
    If grilla.Row = ulFila And FilaVacia(ulFila) Then
        Borrar = False
        Exit Function
    End If
    If Trim(grilla.TextMatrix(grilla.Row, 0)) = "" Then
        Borrar = False
        Exit Function
    End If
    codMotivo = CLng(grilla.TextMatrix(grilla.Row, 0))
    motivo = grilla.TextMatrix(grilla.Row, 1)
    If codMotivo = 0 Then
        MsgBox "El motivo por defecto no se puede eliminar!", vbExclamation
        Borrar = False
        Exit Function
    End If
    Msg = "¿Confirma la eliminación del motivo?" & vbCrLf & "[" & motivo & "]"
    If MsgBox(Msg, vbYesNo) = vbYes Then
        grilla.TextMatrix(grilla.Row, 2) = "D"
        grilla.RowHeight(grilla.Row) = 0
    End If
    Borrar = True
End Function
Private Function Buscar() As Boolean
    Dim Datos()
    Dim I As Long
    Dim nomSp As String
    nomSp = "BacParamsuda.dbo.SP_MNT_MOTIVOS_BLOQUEOCLIENTES"
    Envia = Array()
    AddParam Envia, 0
    AddParam Envia, ""
    AddParam Envia, "L"
    If Not Bac_Sql_Execute(nomSp, Envia) Then
        Buscar = False
        Exit Function
    End If
    'Limpiar grilla
    Call LimpiarGrilla
    I = 1
    Do While Bac_SQL_Fetch(Datos())
        With grilla
            .TextMatrix(I, 0) = Datos(1)
            .TextMatrix(I, 1) = Datos(2)
            .TextMatrix(I, 2) = ""
            .TextMatrix(I, 3) = "*" 'Origen: BD
            .Rows = .Rows + 1
            I = I + 1
            .RowHeight(I) = 280
        End With
    Loop
    Buscar = True
    
End Function
Private Function Grabar() As Boolean
    'SP_MNT_MOTIVOS_BLOQUEOCLIENTES
    Dim I As Long
    Dim xIns As Long
    Dim xAct As Long
    Dim xEli As Long
    Dim Msg As String
    xIns = 0
    xAct = 0
    xEli = 0
    Msg = ""
    Dim modo As String
    With grilla
        If .Rows = 2 And FilaVacia(1) Then
            MsgBox "No hay datos para grabar!", vbExclamation, "Validación de Grabación"
            Grabar = False
            Exit Function
        End If
        For I = 1 To .Rows - 1
            modo = .TextMatrix(I, 2)
            Select Case modo
                Case "I"
                    If Insertar(grilla, i) = True Then
                        xIns = xIns + 1
                    End If
                Case "U"
                    If Actualizar(grilla, i) = True Then
                        xAct = xAct + 1
                    End If
                Case "D"
                    If Eliminar(grilla, i) = True Then
                        xEli = xEli + 1
                    End If
            End Select
        Next I
    End With
    'Limpiar grilla
    If Len(allMsg) > 0 Then
        MsgBox "Se han producido los siguientes errores: " & vbCrLf & allMsg, vbExclamation, "Errores de Grabación"
        Call LimpiarGrilla
        Call Buscar
        Grabar = False
        Exit Function
    End If
    If xIns = 0 And xAct = 0 And xEli = 0 Then
        MsgBox "No se realizaron modificaciones para grabar!", vbExclamation, "Validación de Grabación"
        Grabar = False
        Exit Function
    End If
    If xIns > 0 Then
        If xIns = 1 Then
            Msg = "- Se grabó " & CStr(xIns) & " nuevo motivo."
        Else
            Msg = "- Se grabaron " & CStr(xIns) & " nuevos motivos."
        End If
    End If
    If xAct > 0 Then
        If xAct = 1 Then
            If Msg = "" Then
                Msg = "- Se actualizó " & CStr(xAct) & " motivo."
            Else
                Msg = Msg & vbCrLf & "- Se actualizó " & CStr(xAct) & " motivo."
            End If
        Else
            If Msg = "" Then
                Msg = "- Se actualizaron " & CStr(xAct) & " motivos."
            Else
                Msg = Msg & vbCrLf & "- Se actualizaron " & CStr(xAct) & " motivos."
    End If
        End If
    End If
    If xEli > 0 Then
        If xEli = 1 Then
            If Msg = "" Then
                Msg = "- Se eliminó " & CStr(xEli) & " motivo."
            Else
                Msg = Msg & vbCrLf & "- Se eliminó " & CStr(xEli) & " motivo."
            End If
        Else
            If Msg = "" Then
                Msg = "- Se eliminaron " & CStr(xEli) & " motivos."
            Else
                Msg = Msg & vbCrLf & "- Se eliminaron " & CStr(xEli) & " motivos."
            End If
        End If
    End If
    MsgBox "La grabación se ha realizado en forma exitosa según el siguiente detalle:" & vbCrLf & Msg, vbInformation, "Grabación de Datos"
    Call LimpiarGrilla
    Call Buscar
    Grabar = True
End Function
Private Function LimpiarGrilla() As Boolean
    Dim I As Long
    allMsg = ""
    For I = grilla.Rows - 1 To 2 Step -1
        grilla.RemoveItem (I)
    Next I
    grilla.Rows = grilla.FixedRows
    Call seteaGrilla(grilla)
    LimpiarGrilla = True
End Function
Private Function Insertar(ByVal grilla As MSFlexGrid, ByVal fila As Long) As Boolean
    Dim nomSp As String
    Dim xmsg As Long
    Dim errMsg As String
    If Trim(grilla.TextMatrix(fila, 0)) = "" Then
        Insertar = False
        Exit Function
    End If
    Dim Datos()
    Envia = Array()
    nomSp = "BacParamsuda.dbo.SP_MNT_MOTIVOS_BLOQUEOCLIENTES"
    AddParam Envia, CLng(grilla.TextMatrix(fila, 0))
    AddParam Envia, grilla.TextMatrix(fila, 1)
    AddParam Envia, "I"
    If Not Bac_Sql_Execute(nomSp, Envia) Then
        Insertar = False
        Exit Function
    End If
    xmsg = 0
    errMsg = ""
    Do While Bac_SQL_Fetch(Datos())
        xmsg = xmsg + 1
        If Datos(1) = -1 Then
            errMsg = Datos(2)
            allMsg = allMsg & "- " & errMsg & "[" & CStr(grilla.TextMatrix(fila, 0)) & "-" & grilla.TextMatrix(fila, 1) & " ]" & vbCrLf
        End If
    Loop
    Insertar = True
End Function
Private Function Actualizar(ByVal grilla As MSFlexGrid, ByVal fila As Long) As Boolean
    Dim nomSp As String
    Dim xmsg As Long
    Dim errMsg As String
    Dim Datos()
    Envia = Array()
    nomSp = "BacParamsuda.dbo.SP_MNT_MOTIVOS_BLOQUEOCLIENTES"
    AddParam Envia, CLng(grilla.TextMatrix(fila, 0))
    AddParam Envia, grilla.TextMatrix(fila, 1)
    AddParam Envia, "U"
    If Not Bac_Sql_Execute(nomSp, Envia) Then
        Actualizar = False
        Exit Function
    End If
    xmsg = 0
    errMsg = ""
    Do While Bac_SQL_Fetch(Datos())
        xmsg = xmsg + 1
        If Datos(1) = -1 Then
            errMsg = Datos(2)
            allMsg = allMsg & "- " & errMsg & "[" & CStr(grilla.TextMatrix(fila, 0)) & "-" & grilla.TextMatrix(fila, 1) & " ]" & vbCrLf
        End If
    Loop
    
    Actualizar = True
End Function
Private Function Eliminar(ByVal grilla As MSFlexGrid, ByVal fila As Long) As Boolean
    Dim nomSp As String
    Dim xmsg As Long
    Dim errMsg As String
    Dim Datos()
    Envia = Array()
    nomSp = "BacParamsuda.dbo.SP_MNT_MOTIVOS_BLOQUEOCLIENTES"
    AddParam Envia, CLng(grilla.TextMatrix(fila, 0))
    AddParam Envia, grilla.TextMatrix(fila, 1)
    AddParam Envia, "D"
    If Not Bac_Sql_Execute(nomSp, Envia) Then
        Eliminar = False
        Exit Function
    End If
    xmsg = 0
    errMsg = ""
    Do While Bac_SQL_Fetch(Datos())
        xmsg = xmsg + 1
        If Datos(1) = -1 Then
            errMsg = Datos(2)
            allMsg = allMsg & "- " & errMsg & "[" & CStr(grilla.TextMatrix(fila, 0)) & "-" & grilla.TextMatrix(fila, 1) & " ]" & vbCrLf
        End If
    Loop

    Eliminar = True

End Function



Private Sub txtcodigo_GotFocus()
    If grilla.Col = 0 Then
        Call PROC_POSI_TEXTO(grilla, txtCodigo)
    End If
End Sub

Private Sub txtCodigo_KeyDown(KeyCode As Integer, Shift As Integer)
    Dim ultcod As Long
    If KeyCode = vbKeyReturn Then
        If Not IsNumeric(txtCodigo.Text) Then
            MsgBox "Solo se permiten números en este campo!", vbExclamation, "Validación de Datos"
            txtCodigo.Visible = False
            Exit Sub
        End If
        'Validar que el código digitado ya no esté en la grilla...
        If CodigoYaExiste(txtCodigo.Text, grilla.Row) Then
            MsgBox "El Código ingresado ya existe en la tabla!", vbExclamation, "Validación de Datos"
            txtCodigo.Visible = False
            Exit Sub
        End If
        grilla.TextMatrix(grilla.Row, grilla.Col) = txtCodigo.Text
        txtCodigo.Visible = False
        SendKeys "{TAB}"
    End If

End Sub

Private Sub txtDetalle_GotFocus()
    If grilla.Col = 1 Then
        Call PROC_POSI_TEXTO(grilla, txtDetalle)
    End If
End Sub
Private Function CodigoYaExiste(ByVal bcod As String, ByVal fila As Long) As Boolean
    'Valida si el código ingresado ya está en la grilla
    'en la búsqueda se excluye la fila del código a probar...
    Dim i As Long
    Dim yaExiste As Boolean
    yaExiste = False
    For i = 1 To grilla.Rows - 1
        If i <> fila Then
            If Trim(grilla.TextMatrix(i, 0)) = Trim(bcod) Then
                yaExiste = True
                Exit For
            End If
        End If
    Next i
    CodigoYaExiste = yaExiste
End Function
Private Sub txtDetalle_KeyDown(KeyCode As Integer, Shift As Integer)
    Dim ultcod As Long
    If KeyCode = vbKeyReturn Then
        If grilla.Col = 0 Then
            Exit Sub
        End If
        grilla.TextMatrix(grilla.Row, grilla.Col) = txtDetalle.Text
        txtDetalle.Visible = False
        If grilla.TextMatrix(grilla.Row, 2) = "I" Then
            'Generar nuevo código solo si no hay un código ingresado
            If Trim(grilla.TextMatrix(grilla.Row, 0)) = "" Then
            ultcod = UltimoCodigo()
            grilla.TextMatrix(grilla.Row, 0) = ultcod + 1
        End If
        End If
        If grilla.TextMatrix(grilla.Row, 2) = "U" Then
            If grilla.TextMatrix(grilla.Row, 0) = "" Then
                ultcod = UltimoCodigo()
                grilla.TextMatrix(grilla.Row, 0) = ultcod + 1
                grilla.TextMatrix(grilla.Row, 2) = "I"
            End If
        End If
        SendKeys "{TAB}"
    End If
End Sub
Private Function UltimoCodigo() As Long
    Dim I As Long
    Dim mayorCod As Long
    Dim codActual As Long
    UltimoCodigo = 0
    mayorCod = 0
    For I = 1 To grilla.Rows - 1
        If grilla.TextMatrix(I, 0) <> "" Then
            codActual = CLng(grilla.TextMatrix(i, 0))
            If codActual > mayorCod Then
                mayorCod = codActual
            End If
        End If
    Next I
    UltimoCodigo = mayorCod
End Function

