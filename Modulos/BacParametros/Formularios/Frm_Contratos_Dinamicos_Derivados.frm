VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "Msflxgrd.ocx"
Begin VB.Form Frm_Contratos_Dinamicos_Derivados 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Asignacion de contratos y clausulas dinamicas para derivados"
   ClientHeight    =   7140
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   12960
   LinkTopic       =   "Form2"
   MDIChild        =   -1  'True
   ScaleHeight     =   7140
   ScaleWidth      =   12960
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   4200
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
            Picture         =   "Frm_Contratos_Dinamicos_Derivados.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Frm_Contratos_Dinamicos_Derivados.frx":0452
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Frm_Contratos_Dinamicos_Derivados.frx":08A4
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Frm_Contratos_Dinamicos_Derivados.frx":0BBE
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Tbl_Opciones 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   5
      Top             =   0
      Width           =   12960
      _ExtentX        =   22860
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Eliminar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   4
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Cód. Contable"
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
         Height          =   195
         Index           =   1
         Left            =   7095
         TabIndex        =   6
         Top             =   630
         Width           =   1215
      End
   End
   Begin VB.Frame Frame2 
      Caption         =   "Contratos Seleccionados"
      Height          =   6045
      Left            =   0
      TabIndex        =   1
      Top             =   1080
      Width           =   12945
      Begin MSFlexGridLib.MSFlexGrid Grd_Datos 
         Height          =   4860
         Left            =   120
         TabIndex        =   2
         Top             =   270
         Width           =   12735
         _ExtentX        =   22463
         _ExtentY        =   8573
         _Version        =   393216
         Cols            =   3
         FixedCols       =   0
      End
      Begin VB.Label Lbl_Descripcion 
         Alignment       =   2  'Center
         BorderStyle     =   1  'Fixed Single
         Height          =   690
         Left            =   135
         TabIndex        =   7
         Top             =   5175
         Width           =   12690
      End
   End
   Begin VB.Frame Frame1 
      Height          =   645
      Left            =   0
      TabIndex        =   0
      Top             =   435
      Width           =   12945
      Begin VB.ComboBox Cmb_Sistema 
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   840
         Style           =   2  'Dropdown List
         TabIndex        =   4
         Top             =   195
         Width           =   2400
      End
      Begin VB.Label Label1 
         Caption         =   "Sistema"
         Height          =   240
         Left            =   180
         TabIndex        =   3
         Top             =   240
         Width           =   705
      End
   End
End
Attribute VB_Name = "Frm_Contratos_Dinamicos_Derivados"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Dim Datos()
   
Dim MatrizSeleccion()
Dim MatrizContratoFisico()
Dim MatrizClausulas()

Dim Insertados()
Dim nInsertados As Long         'PRD-3166

Dim nContador1    As Integer
Dim nContador2    As Integer
Dim nContador3    As Integer
Dim nContador4    As Integer
Dim nContador5    As Integer
Dim ncontador6    As Integer

Private Const colRutCli = 0
Private Const colCodCli = 1
Private Const colNomCli = 2

Private Const BtnGrabar = 1
Private Const BtnEliminar = 2
Private Const BtnLimpiar = 3
Private Const BtnSalir = 4

Private Sub Proc_Eliminar()

   If Grd_Datos.Rows = 0 Or Grd_Datos.Row = 0 Then
      Exit Sub
   End If
   
   If Grd_Datos.Row = Grd_Datos.Rows - 1 And Grd_Datos.TextMatrix(Grd_Datos.Row, colRutCli) = "" Then
      If Grd_Datos.Rows > 2 And Grd_Datos.Row > 0 Then
            Grd_Datos.RemoveItem (Grd_Datos.Row)
      ElseIf Grd_Datos.Rows = 2 And Grd_Datos.Row = 1 Then
         Grd_Datos.Rows = 1
         Grd_Datos.Cols = 3
      End If
   Else
      If MsgBox("Seguro que desea eliminar el registro", vbQuestion + vbYesNo) = vbYes Then
         'Verificar primero si la fila está vacía, si es así, solo borrarla de la grilla!  PRD-3166
         If FilaVacia(Grd_Datos, Grd_Datos.Row) Then
            Grd_Datos.RemoveItem (Grd_Datos.Row)
            Grd_Datos.SetFocus
            Exit Sub
         End If
         'Fin verificación
      
         Screen.MousePointer = vbHourglass
         
         Envia = Array()
         AddParam Envia, Left(Cmb_Sistema.Text, 3)
         AddParam Envia, Format(Left(Grd_Datos.TextMatrix(Grd_Datos.Row, colRutCli), Len(Trim(Grd_Datos.TextMatrix(Grd_Datos.Row, colRutCli))) - 2), "#0") 'rut sin DV
         AddParam Envia, Int(Grd_Datos.TextMatrix(Grd_Datos.Row, colCodCli))
         
         If Not Bac_Sql_Execute("BACPARAMSUDA.dbo.SP_DEL_CONTRATOS_CLIENTES_DERIVADOS", Envia) Then
            Screen.MousePointer = vbDefault
            MsgBox "Ha ocurrido un error al intenter eliminar contratos parametrizados del cliente"
            Exit Sub
         Else
            If Grd_Datos.Rows > 2 And Grd_Datos.Row > 0 Then
                  Grd_Datos.RemoveItem (Grd_Datos.Row)
            ElseIf Grd_Datos.Rows = 2 And Grd_Datos.Row = 1 Then
               Grd_Datos.Rows = 1
               Grd_Datos.Cols = 3
            End If
         End If
      End If
   End If
   
   Screen.MousePointer = vbDefault
   Grd_Datos.SetFocus
   
End Sub

Private Sub Proc_Genera_Fila_Contratos_Grilla(grilla As MSFlexGrid, MatrizContratoFisico(), MatrizClausulas(), MatrizSeleccion(), bUtilizaSeleccionados As Boolean)

   If bUtilizaSeleccionados = True Then
      If UBound(MatrizSeleccion, 2) = 0 Then
         Exit Sub
      End If
   End If

   nContador5 = 3

   With grilla
      For nContador1 = 1 To UBound(MatrizContratoFisico, 2)
         ' SE ARMA CADENA QUE CONTIENE: CODIGO DEL DCTO + 50 ESPACIOS + FISICO/DINAMICO + CODIGO DCTO + 1 ESPACIO + SELECCIONADO S/N
         If .Cols = nContador5 Then
            .Cols = .Cols + 1
         End If
         
         .TextMatrix(.Row, nContador5) = Trim(MatrizContratoFisico(1, nContador1))
         .TextMatrix(.Row, nContador5) = .TextMatrix(.Row, nContador5) & Space(10 - Len(Trim(MatrizContratoFisico(1, nContador1)))) 'completa 10 caracteres con espacios para el codigo anterior
         .TextMatrix(.Row, nContador5) = .TextMatrix(.Row, nContador5) & Space(50)
         .TextMatrix(.Row, nContador5) = .TextMatrix(.Row, nContador5) & "FISICO    "
         .TextMatrix(.Row, nContador5) = .TextMatrix(.Row, nContador5) & Space(10 - Len(Trim(MatrizContratoFisico(1, nContador1)))) 'completa 10 caracteres con espacios para el codigo posterior
         .TextMatrix(.Row, nContador5) = .TextMatrix(.Row, nContador5) & Trim(MatrizContratoFisico(1, nContador1))
         .TextMatrix(.Row, nContador5) = .TextMatrix(.Row, nContador5) & Space(1)
         .TextMatrix(.Row, nContador5) = .TextMatrix(.Row, nContador5) & MatrizContratoFisico(6, nContador1)
         
         .Col = nContador5
         If MatrizContratoFisico(6, nContador1) = "S" Then
            .CellBackColor = vbGreen
            .CellForeColor = vbBlack
         ElseIf MatrizContratoFisico(6, nContador1) = "N" Then
            .CellBackColor = vbRed
            .CellForeColor = vbWhite
         End If
         
         If bUtilizaSeleccionados = True Then
            GoSub Busca_Marcado
         End If
         nContador5 = nContador5 + 1
         
         For nContador2 = 1 To UBound(MatrizClausulas, 2)
            If Trim(MatrizContratoFisico(1, nContador1)) = MatrizClausulas(1, nContador2) Then 'Codigo Documento Fisico
               If .Cols = nContador5 Then
                  .Cols = .Cols + 1
               End If
               
               .TextMatrix(.Row, nContador5) = Trim(MatrizClausulas(2, nContador2))
               .TextMatrix(.Row, nContador5) = .TextMatrix(.Row, nContador5) & Space(10 - Len(Trim(MatrizClausulas(2, nContador2))))
               .TextMatrix(.Row, nContador5) = .TextMatrix(.Row, nContador5) & Space(50)
               .TextMatrix(.Row, nContador5) = .TextMatrix(.Row, nContador5) & "DINAMICO  "
               .TextMatrix(.Row, nContador5) = .TextMatrix(.Row, nContador5) & Space(10 - Len(Trim(MatrizContratoFisico(1, nContador1))))  'Space(10 - Len(Trim(MatrizClausulas(2, nContador2))))
               .TextMatrix(.Row, nContador5) = .TextMatrix(.Row, nContador5) & Trim(MatrizContratoFisico(1, nContador1))                   'Trim(MatrizClausulas(2, nContador2))
               .TextMatrix(.Row, nContador5) = .TextMatrix(.Row, nContador5) & Space(1)
               .TextMatrix(.Row, nContador5) = .TextMatrix(.Row, nContador5) & MatrizClausulas(4, nContador2)
               
               .Col = nContador5
               If MatrizClausulas(4, nContador2) = "S" Then
                  .CellBackColor = vbGreen
                  .CellForeColor = vbBlack
               ElseIf MatrizClausulas(4, nContador2) = "N" Then
                  .CellBackColor = vbRed
                  .CellForeColor = vbWhite
               End If
               
               If bUtilizaSeleccionados = True Then
                  GoSub Busca_Marcado
               End If
               nContador5 = nContador5 + 1
            End If
         Next nContador2
      Next nContador1
            
      Exit Sub
      
      
Busca_Marcado:

   For nContador3 = 1 To UBound(MatrizSeleccion, 2)
      If MatrizSeleccion(1, nContador3) = .TextMatrix(.Row, nRutcli) Then
         For nContador4 = 4 To 30
            If Trim(MatrizSeleccion(nContador4, nContador3)) = "" Or Trim(MatrizSeleccion(nContador4, nContador3)) = "**" Then
               Exit For
            End If
            If Trim(Mid(.TextMatrix(.Row, .Col), 1, 10)) = Trim(Mid(MatrizSeleccion(nContador4, nContador3), 1, 10)) Then
               If Trim(Mid(.TextMatrix(.Row, .Col), 71, 10)) = Trim(Mid(MatrizSeleccion(nContador4, nContador3), 11, 10)) Then
                  .TextMatrix(.Row, .Col) = Trim(Mid(.TextMatrix(.Row, .Col), 1, 81)) + "S"
                  .CellBackColor = vbGreen
                  .CellForeColor = vbBlack
                  Exit For
               End If
            Else
               .TextMatrix(.Row, .Col) = Trim(Mid(.TextMatrix(.Row, .Col), 1, 81)) + "N"
               .CellBackColor = vbRed
               .CellForeColor = vbWhite
            End If
         Next nContador4
      End If
   Next nContador3
   Return
   
   End With
   
      
End Sub


Private Function FuncReplaceSeparador(ByVal oRut As String) As Long
   If InStr(1, oRut, ",") Then
      FuncReplaceSeparador = Replace(oRut, ",", "")
   End If
   If InStr(1, oRut, ".") Then
      FuncReplaceSeparador = Replace(oRut, ".", "")
   End If
End Function

Private Sub Proc_Grabar()
   
    Dim filaGuardar As Long     'PRD-3166.  Guardar las condiciones del cliente ssi es BFW para reporducirlas en PCS en forma automática
    
    filaGuardar = -1
    
   If Grd_Datos.Rows = 0 Or Grd_Datos.Row = 0 Then
      Exit Sub
   End If
   
   If MsgBox("Seguro que desa grabar la informacion.", vbQuestion + vbYesNo) = vbYes Then
   
      Screen.MousePointer = vbHourglass
      
      If Not Bac_Sql_Execute("BEGIN TRANSACTION") Then
         Screen.MousePointer = vbDefault
         MsgBox "Ha ocurrido un error al ejecutar el control de transaccion 'BEGIN TRANSACTION'", vbCritical + vbOKOnly
         Exit Sub
      End If
      
        If Left(Cmb_Sistema.Text, 3) = "BFW" Then
            filaGuardar = Grd_Datos.Row
        End If
      
      Envia = Array()
      AddParam Envia, Left(Cmb_Sistema.Text, 3)
      
      If Not Bac_Sql_Execute("BACPARAMSUDA.dbo.SP_DEL_CONTRATOS_CLIENTES_DERIVADOS", Envia) Then
         If Not Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
            Screen.MousePointer = vbDefault
            MsgBox "Ha ocurrido un error al ejecutar el control de transaccion 'ROLLBACK TRANSACTION'", vbCritical + vbOKOnly
            Exit Sub
         End If
      
         Screen.MousePointer = vbDefault
            MsgBox "Ha ocurrido un error al intentar eliminar contratos parametrizados del cliente"
         Exit Sub
      End If
      
      For nContador1 = 1 To Grd_Datos.Rows - 1
         For nContador2 = 3 To Grd_Datos.Cols - 1
            If Right(Grd_Datos.TextMatrix(nContador1, nContador2), 1) = "S" Then
                 
               Envia = Array()
               AddParam Envia, Left(Cmb_Sistema.Text, 3)
              'AddParam Envia, Format(Left(Grd_datos.TextMatrix(nContador1, colRutCli), Len(Trim(Grd_datos.TextMatrix(nContador1, colRutCli))) - 2), "#0") 'rut sin DV
               AddParam Envia, FuncReplaceSeparador(Mid(Grd_datos.TextMatrix(nContador1, colRutCli), 1, InStr(1, Grd_datos.TextMatrix(nContador1, colRutCli), "-") - 1))
               AddParam Envia, Grd_Datos.TextMatrix(nContador1, colCodCli)
               AddParam Envia, Trim(Mid(Grd_Datos.TextMatrix(nContador1, nContador2), 71, 10)) 'Codigo Dcto Fisico
               AddParam Envia, Trim(Mid(Grd_Datos.TextMatrix(nContador1, nContador2), 1, 10))  'Codigo Dcto
                     
               If Not Bac_Sql_Execute("BACPARAMSUDA.dbo.SP_ACT_CONTRATOS_CLIENTES_DERIVADOS", Envia) Then
                  
                  If Not Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
                     Screen.MousePointer = vbDefault
                     MsgBox "Ha ocurrido un error al ejecutar el control de transaccion 'ROLLBACK TRANSACTION'", vbCritical + vbOKOnly
                     Exit Sub
                  End If
                  
                  Screen.MousePointer = vbDefault
                        MsgBox "Ha ocurrido un error al intentar grabar contratos parametrizados del cliente", vbCritical + vbOKOnly
                  Exit Sub
               End If
            End If
         Next nContador2
      Next nContador1
      
      If Not Bac_Sql_Execute("COMMIT TRANSACTION") Then
         Screen.MousePointer = vbDefault
         MsgBox "Ha ocurrido un error al ejecutar el control de transaccion 'COMMIT TRANSACTION'", vbCritical + vbOKOnly
         Exit Sub
      Else
            'Revisar para procesar en forma automatica para PCS, solo si se seleccionó BFW.  PRD-3166
            If Left(Cmb_Sistema.Text, 3) = "BFW" Then
                If nInsertados > 0 Then
                    If Reprocesar_PCS(Insertados()) = True Then
                        MsgBox "La información fue actualizada con éxito en Swap.", vbInformation + vbOKOnly
                    End If
                End If
            End If
         Screen.MousePointer = vbDefault
            MsgBox "La información fue grabada con éxito", vbInformation + vbOKOnly
         Call Proc_Limpiar
      End If
   
      Screen.MousePointer = vbDefault
   End If
   
End Sub
Private Function Reprocesar_PCS(lista()) As Boolean
    Dim rutcli As Long
    Dim codcli As Integer
    Dim CodDctoPrinc As String
    Dim CodDcto As String
    Dim Contador As Long
    Dim Fila As Long
    Dim I As Long
    Dim modoError As String
    Dim cErrores As Long
    For I = 1 To UBound(lista())
        Fila = lista(I)
        modoError = ""
        If Not GrabaPCS(Fila, modoError) Then
            cErrores = cErrores + 1
            Select Case modoError
                Case "BEGINTRAN"
                    MsgBox "Ha ocurrido un error al ejecutar el control de transaccion 'BEGIN TRANSACTION'", vbCritical + vbOKOnly
                Case "ROLLBACK"
                    MsgBox "Ha ocurrido un error al ejecutar el control de transaccion 'ROLLBACK TRANSACTION'", vbCritical + vbOKOnly
                Case "ELIMINAR"
                    MsgBox "Ha ocurrido un error al intentar eliminar contratos parametrizados del cliente", vbCritical + vbOKOnly
                Case "COMMIT"
                    MsgBox "Ha ocurrido un error al ejecutar el control de transaccion 'COMMIT TRANSACTION'", vbCritical + vbOKOnly
            End Select
        End If
    Next I
            
        
'    rutcli = Left(Grd_Datos.TextMatrix(fila, colRutCli), Len(Trim(Grd_Datos.TextMatrix(fila, colRutCli))) - 2)
'    codcli = Grd_Datos.TextMatrix(fila, colCodCli)
'
'    Screen.MousePointer = vbHourglass
'
'    If Not Bac_Sql_Execute("BEGIN TRANSACTION") Then
'        Screen.MousePointer = vbDefault
'        MsgBox "Ha ocurrido un error al ejecutar el control de transaccion 'BEGIN TRANSACTION'", vbCritical + vbOKOnly
'        Reprocesar_PCS = False
'        Exit Function
'    End If
'
'    Envia = Array()
'    AddParam Envia, "PCS"
'    AddParam Envia, rutcli
'    AddParam Envia, codcli
'
'    If Not Bac_Sql_Execute("BACPARAMSUDA.dbo.SP_DEL_CONTRATOS_CLIENTES_DERIVADOS", Envia) Then
'        If Not Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
'            Screen.MousePointer = vbDefault
'            MsgBox "Ha ocurrido un error al ejecutar el control de transaccion 'ROLLBACK TRANSACTION'", vbCritical + vbOKOnly
'            Reprocesar_PCS = False
'            Exit Function
'        End If
'        Screen.MousePointer = vbDefault
'        MsgBox "Ha ocurrido un error al intentar eliminar contratos parametrizados del cliente"
'        Reprocesar_PCS = False
'        Exit Function
'    End If
'    For Contador = 3 To Grd_Datos.Cols - 1
'        If Right(Grd_Datos.TextMatrix(fila, Contador), 1) = "S" Then
'
'            Envia = Array()
'            AddParam Envia, "PCS"
'            AddParam Envia, Format(Left(Grd_Datos.TextMatrix(fila, colRutCli), Len(Trim(Grd_Datos.TextMatrix(fila, colRutCli))) - 2), "#0") 'rut sin DV
'            AddParam Envia, Grd_Datos.TextMatrix(fila, colCodCli)
'            AddParam Envia, Trim(Mid(Grd_Datos.TextMatrix(fila, Contador), 71, 10)) 'Codigo Dcto Fisico
'            AddParam Envia, Trim(Mid(Grd_Datos.TextMatrix(fila, Contador), 1, 10))  'Codigo Dcto
'
'            If Not Bac_Sql_Execute("BACPARAMSUDA.dbo.SP_ACT_CONTRATOS_CLIENTES_DERIVADOS", Envia) Then
'
'                If Not Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
'                    Screen.MousePointer = vbDefault
'                    MsgBox "Ha ocurrido un error al ejecutar el control de transaccion 'ROLLBACK TRANSACTION'", vbCritical + vbOKOnly
'                    Reprocesar_PCS = False
'                    Exit Function
'                End If
'
'                Screen.MousePointer = vbDefault
'                MsgBox "Ha ocurrido un error al intentar grabar contratos parametrizados del cliente", vbCritical + vbOKOnly
'                Reprocesar_PCS = False
'                Exit Function
'            End If
'        End If
'    Next Contador
'
'    If Not Bac_Sql_Execute("COMMIT TRANSACTION") Then
'        Screen.MousePointer = vbDefault
'        MsgBox "Ha ocurrido un error al ejecutar el control de transaccion 'COMMIT TRANSACTION'", vbCritical + vbOKOnly
'        Reprocesar_PCS = False
'        Exit Function
'    Else
'        Screen.MousePointer = vbDefault
'        MsgBox "La informacion fue grabada con exito", vbInformation + vbOKOnly
'    End If

    If cErrores = 0 Then
        Reprocesar_PCS = True
        
    Else
        Reprocesar_PCS = False
    End If
    Screen.MousePointer = vbDefault
    
End Function
Private Function GrabaPCS(ByVal Fila As Long, ByRef tipoError As String) As Boolean
    Dim rutcli As Long
    Dim codcli As Integer
    Dim CodDctoPrinc As String
    Dim CodDcto As String
    Dim Contador As Long
        
    If fila > (Grd_datos.Rows - Grd_datos.FixedRows) Then
      Exit Function
    End If
    
    rutcli = Left(Grd_Datos.TextMatrix(Fila, colRutCli), Len(Trim(Grd_Datos.TextMatrix(Fila, colRutCli))) - 2)
    
    
    codcli = Grd_Datos.TextMatrix(Fila, colCodCli)
    
    Screen.MousePointer = vbHourglass
      
    If Not Bac_Sql_Execute("BEGIN TRANSACTION") Then
        Screen.MousePointer = vbDefault
        'MsgBox "Ha ocurrido un error al ejecutar el control de transaccion 'BEGIN TRANSACTION'", vbCritical + vbOKOnly
        tipoError = "BEGINTRAN"
        GrabaPCS = False
        Exit Function
    End If
    
    Envia = Array()
    AddParam Envia, "PCS"
    AddParam Envia, rutcli
    AddParam Envia, codcli
        
    If Not Bac_Sql_Execute("BACPARAMSUDA.dbo.SP_DEL_CONTRATOS_CLIENTES_DERIVADOS", Envia) Then
        If Not Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
            Screen.MousePointer = vbDefault
            tipoError = "ROLLBACK"
            'MsgBox "Ha ocurrido un error al ejecutar el control de transaccion 'ROLLBACK TRANSACTION'", vbCritical + vbOKOnly
            GrabaPCS = False
            Exit Function
        End If
        Screen.MousePointer = vbDefault
        tipoError = "ELIMINAR"
        'MsgBox "Ha ocurrido un error al intentar eliminar contratos parametrizados del cliente"
        GrabaPCS = False
        Exit Function
    End If
    For Contador = 3 To Grd_Datos.Cols - 1
        If Right(Grd_Datos.TextMatrix(Fila, Contador), 1) = "S" Then

            Envia = Array()
            AddParam Envia, "PCS"
            AddParam Envia, Format(Left(Grd_Datos.TextMatrix(Fila, colRutCli), Len(Trim(Grd_Datos.TextMatrix(Fila, colRutCli))) - 2), "#0") 'rut sin DV
            AddParam Envia, Grd_Datos.TextMatrix(Fila, colCodCli)
            AddParam Envia, Trim(Mid(Grd_Datos.TextMatrix(Fila, Contador), 71, 10)) 'Codigo Dcto Fisico
            AddParam Envia, Trim(Mid(Grd_Datos.TextMatrix(Fila, Contador), 1, 10))  'Codigo Dcto
            
            If Not Bac_Sql_Execute("BACPARAMSUDA.dbo.SP_ACT_CONTRATOS_CLIENTES_DERIVADOS", Envia) Then
            
                If Not Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
                    Screen.MousePointer = vbDefault
                    tipoError = "ROLLBACK"
                    'MsgBox "Ha ocurrido un error al ejecutar el control de transaccion 'ROLLBACK TRANSACTION'", vbCritical + vbOKOnly
                    GrabaPCS = False
                    Exit Function
                End If
                
                Screen.MousePointer = vbDefault
                'MsgBox "Ha ocurrido un error al intentar grabar contratos parametrizados del cliente", vbCritical + vbOKOnly
                tipoError = "ELIMINAR"
                GrabaPCS = False
                Exit Function
            End If
        End If
    Next Contador

    If Not Bac_Sql_Execute("COMMIT TRANSACTION") Then
        Screen.MousePointer = vbDefault
        'MsgBox "Ha ocurrido un error al ejecutar el control de transaccion 'COMMIT TRANSACTION'", vbCritical + vbOKOnly
        tipoError = "COMMIT"
        GrabaPCS = False
        Exit Function
    Else
        Screen.MousePointer = vbDefault
        'MsgBox "La informacion fue grabada con exito", vbInformation + vbOKOnly
    End If
    Screen.MousePointer = vbDefault
    GrabaPCS = True

End Function
Private Sub Proc_Limpiar()

   Screen.MousePointer = vbDefault

   If Me.Visible = True Then
      Cmb_Sistema.ListIndex = -1
   End If
   
   Cmb_Sistema.Enabled = True
   
   Grd_Datos.Rows = 1
   Grd_Datos.Cols = 3
   Grd_Datos.TextMatrix(0, 0) = "Rut Cliente"
   Grd_Datos.TextMatrix(0, 1) = "Cod."
   Grd_Datos.TextMatrix(0, 2) = "Nombre Cliente"
   
   Grd_Datos.ColWidth(0) = 1100
   Grd_Datos.ColWidth(1) = 500
   Grd_Datos.ColWidth(2) = 2500
   
   Tbl_Opciones.Buttons(BtnGrabar).Enabled = False
   Tbl_Opciones.Buttons(BtnEliminar).Enabled = False

End Sub

Private Sub Cmb_Sistema_Click()

   Dim cRutCli                As String
   Dim cCodCli                As String
   Dim bDefault               As String
         
   '**********************************************************************************************************************
   '************************************** CLIENTES CON CONTRATOS YA PARAMETRIZADOS **************************************
   '**********************************************************************************************************************
   
   Erase MatrizSeleccion
   Erase MatrizContratoFisico
   Erase MatrizClausulas
     
   Erase Insertados     'PRD-3166
   nInsertados = 0
     
     
   
   If Cmb_Sistema.ListIndex = -1 Then
      Exit Sub
   End If
   
   Screen.MousePointer = vbHourglass
  'Me.Grd_datos.Redraw = False
   
   Envia = Array()
   AddParam Envia, Trim(Left(Cmb_Sistema.Text, 3))
   AddParam Envia, 0
   AddParam Envia, 0

   If Not Bac_Sql_Execute("BACPARAMSUDA.dbo.SP_CON_CLIENTE_CONTRATO_DERIVADOS", Envia) Then
      Screen.MousePointer = vbDefault
      Me.Grd_datos.Redraw = True
      MsgBox "Ha ocurrido un error al intenter recuperar los datos de los clientes con contratos parametrizados"
      Exit Sub
   End If
  
   ReDim Preserve MatrizSeleccion(30, 1)
   
   For nContador1 = 1 To 30
      MatrizSeleccion(nContador1, 1) = "**"
   Next nContador1
   
   cRutCli = ""
   cCodCli = ""
   
   nContador1 = 1
   nContador2 = 3 'Recorre Columnas
   
   Do While Bac_SQL_Fetch(Datos())
   
      If (cRutCli = (Trim(Datos(1)) & "-" & Trim(Datos(6))) And cCodCli = Trim(Datos(2))) Or cRutCli = "" Then
         nContador2 = nContador2 + 1
      Else
         nContador1 = UBound(MatrizSeleccion, 2) + 1
         nContador2 = 4
      End If
      
      ReDim Preserve MatrizSeleccion(30, nContador1)
      
      MatrizSeleccion(1, nContador1) = Format(Trim(Datos(1)), "#,##0") & "-" & Trim(Datos(6))      ' RUT CLIENTE y DV
      MatrizSeleccion(2, nContador1) = Trim(Datos(2))                                              ' CODIGO CLIENTE
      MatrizSeleccion(3, nContador1) = Trim(Datos(7))                                              ' NOMBRE CLIENTE
      MatrizSeleccion(nContador2, nContador1) = Trim(Datos(5)) _
                                              & (Space(10 - Len(Trim(Datos(5))))) _
                                              & Trim(Datos(4)) _
                                              & (Space(10 - Len(Trim(Datos(4)))))                  ' CODIGO DCTO + CODIGO DCTO FISICO
      cRutCli = Trim(Datos(1)) & "-" & Trim(Datos(6))
      cCodCli = Trim(Datos(2))
   Loop
   
   DoEvents
   DoEvents
   DoEvents
   
   '*********************************************************************************************************************
   '************************************************* CONTRATOS FISICOS *************************************************
   '*********************************************************************************************************************
   
   Envia = Array()
   AddParam Envia, Trim(Left(Cmb_Sistema.Text, 3))
   
   If Not Bac_Sql_Execute("BACPARAMSUDA.dbo.SP_CON_CONTRATOS_FISICOS_DERIVADOS", Envia) Then
      Screen.MousePointer = vbDefault
      Me.Grd_datos.Redraw = True
      MsgBox "Ha ocurrido un error al intenter rescatar los contratos", vbCritical + vbOKOnly
      Exit Sub
   End If
   
   nContador1 = 0
     
   'Se dan vuelta los indices debido a que el comando redim preserve no deja incrementar filas.... solo incrementa columnas
   Do While Bac_SQL_Fetch(Datos())
      nContador1 = nContador1 + 1
      ReDim Preserve MatrizContratoFisico(6, nContador1)
      
      MatrizContratoFisico(1, nContador1) = Trim(Datos(1))  ' CODIGO DCTO
      MatrizContratoFisico(2, nContador1) = Trim(Datos(2))  ' DESCRIPCION DCTO
      MatrizContratoFisico(3, nContador1) = Trim(Datos(3))  ' UBICACION DCTO
      MatrizContratoFisico(4, nContador1) = Trim(Datos(4))  ' NOMBRE DCTO
      MatrizContratoFisico(5, nContador1) = Datos(5)        ' INDICE ORDEN
      
      If Left(Cmb_Sistema.Text, 3) = "PCS" Then
         bDefault = IIf(Datos(6) = "", "N", Datos(6))    'DEFAULT SWAP
      Else
         bDefault = IIf(Datos(7) = "", "N", Datos(7))    'DEFAULT FORWARD
      End If
      
      MatrizContratoFisico(6, nContador1) = bDefault
   Loop
   
   If UBound(MatrizContratoFisico, 2) = 0 Then
      Screen.MousePointer = vbDefault
      Me.Grd_datos.Redraw = True
      MsgBox "No se han encontrado los documentos Basicos para su impresion, por favor revisar", vbOKOnly + vbExclamation
      Exit Sub
   End If
   
   DoEvents
   DoEvents
   DoEvents
   
   '***********************************************************************************************************************
   '*********************************************** CLAUSULAS PARAMETRICAS ************************************************
   '***********************************************************************************************************************
   
   Envia = Array()
   AddParam Envia, Left(Cmb_Sistema.Text, 3)
   
   If Not Bac_Sql_Execute("SP_CON_CLAUSULA_CONTRATO_DINAMICO", Envia) Then
      Screen.MousePointer = vbDefault
      Me.Grd_datos.Redraw = True
      MsgBox "Ha ocurrido un error al rescatar las clausulas dinamicas", vbCritical + vbOKOnly
      Exit Sub
   End If
   
   nContador1 = 0
  
   Do While Bac_SQL_Fetch(Datos())
      nContador1 = nContador1 + 1
      ReDim Preserve MatrizClausulas(4, nContador1)
                
      MatrizClausulas(1, nContador1) = Trim(Datos(2)) 'Codigo Contrato Fisico
      MatrizClausulas(2, nContador1) = Trim(Datos(3)) 'Codigo Clausula
      MatrizClausulas(3, nContador1) = Trim(Datos(4)) 'Glosa
      MatrizClausulas(4, nContador1) = Trim(Datos(8)) 'Default S/N
   Loop
   
   DoEvents
   DoEvents
   DoEvents
   
   If UBound(MatrizSeleccion) > 0 Then
      For ncontador6 = 1 To UBound(MatrizSeleccion, 2)
         If MatrizSeleccion(1, ncontador6) = "**" Then
            Exit For
         End If
         
         Grd_Datos.Rows = Grd_Datos.Rows + 1
         Grd_Datos.Row = Grd_Datos.Rows - 1
         Grd_Datos.TextMatrix(Grd_Datos.Row, colRutCli) = MatrizSeleccion(1, ncontador6)
         Grd_Datos.TextMatrix(Grd_Datos.Row, colCodCli) = MatrizSeleccion(2, ncontador6)
         Grd_Datos.TextMatrix(Grd_Datos.Row, colNomCli) = MatrizSeleccion(3, ncontador6)
         
         Call Proc_Genera_Fila_Contratos_Grilla(Grd_Datos, MatrizContratoFisico(), MatrizClausulas, MatrizSeleccion, True)
      
      Next ncontador6
   End If

   If Left(Cmb_Sistema.Text, 3) = "BFW" Then
        ReDim Insertados(0)     'PRD-3166
        nInsertados = 0
   End If


   Tbl_Opciones.Buttons(BtnGrabar).Enabled = True
   Tbl_Opciones.Buttons(BtnEliminar).Enabled = True
   Cmb_Sistema.Enabled = False

   Me.Grd_datos.Redraw = True
   Screen.MousePointer = vbDefault

End Sub


Private Sub Form_Load()

   Me.Icon = BACSwapParametros.Icon
   Cmb_Sistema.AddItem "BFW - FORWARD"
   Cmb_Sistema.AddItem "PCS - SWAP"
   
   Proc_Limpiar
   
   
End Sub




Private Sub Grd_Datos_Click()

   If Grd_Datos.Col > 2 Then
      If Trim(Mid(Grd_Datos.Text, 61, 10)) = "FISICO" Then
         For nContador1 = 1 To UBound(MatrizContratoFisico, 2)
            If MatrizContratoFisico(1, nContador1) = Trim(Mid(Grd_Datos.TextMatrix(Grd_Datos.Row, Grd_Datos.Col), 1, 10)) Then
               Lbl_Descripcion.Caption = MatrizContratoFisico(2, nContador1)
               Exit For
            End If
         Next nContador1
      ElseIf Trim(Mid(Grd_Datos.Text, 61, 10)) = "DINAMICO" Then
         For nContador1 = 1 To UBound(MatrizClausulas, 2)
            If MatrizClausulas(2, nContador1) = Trim(Mid(Grd_Datos.TextMatrix(Grd_Datos.Row, Grd_Datos.Col), 1, 10)) _
               And MatrizClausulas(1, nContador1) = Trim(Mid(Grd_Datos.TextMatrix(Grd_Datos.Row, Grd_Datos.Col), 71, 10)) Then
               
               Lbl_Descripcion.Caption = MatrizClausulas(3, nContador1)
               Exit For
            End If
         Next nContador1
      Else
         Lbl_Descripcion.Caption = ""
      End If
   End If
End Sub

Private Sub Grd_Datos_DblClick()

   Dim nColumnaAnterior As Integer

   If Grd_Datos.Col = colRutCli And Grd_Datos.Rows > 1 And Grd_Datos.TextMatrix(Grd_Datos.Row, Grd_Datos.Col) = "" Then
      BacControlWindows 100
 '     BacAyuda.Tag = "MDCL"
 '     BacAyuda.Show 1
 '     Arm se implementa nuevo formulario de ayuda
      BacAyudaCliente.Tag = "MDCL"
      BacAyudaCliente.Show 1
      If giAceptar = True Then
         If Grd_Datos.Rows > 2 Then
            For nContador1 = 1 To Grd_Datos.Rows - 1
               If Grd_Datos.TextMatrix(nContador1, colRutCli) = Format(gsrut$, "#,##0") & "-" & gsDigito$ And Grd_Datos.TextMatrix(nContador1, colCodCli) = gsCodigo Then
                  Screen.MousePointer = vbDefault
                  MsgBox "Cliente ya existe con contratos asignados", vbExclamation + vbOKOnly
                  Exit Sub
               End If
            Next nContador1
         End If
         
         Envia = Array()
         AddParam Envia, CDbl(gsrut$)
         AddParam Envia, gsDigito$
         AddParam Envia, CDbl(gsCodigo)
         
         If Not Bac_Sql_Execute("SP_MDCLLEERRUT", Envia) Then
            Screen.MousePointer = vbDefault
            MsgBox "Ha ocurrido un error al validar la informacion del cliente", vbCritical + vbOKOnly
            Exit Sub
         Else
            If Bac_SQL_Fetch(Datos()) Then
               If Trim(Datos(73)) <> "S" Then 'Marca si es contrato nuevo
                  Screen.MousePointer = vbDefault
                  MsgBox "Este cliente no puede utilizar contratos dinamicos, esto debido a que aun se encuentra utilizando la configuracion para los contratos antiguos", vbExclamation + vbOKOnly
                  Exit Sub
               End If
            End If
         End If
      
         Grd_Datos.TextMatrix(Grd_Datos.Row, colRutCli) = Format(gsrut$, "#,##0") & "-" & gsDigito$
         Grd_Datos.TextMatrix(Grd_Datos.Row, colCodCli) = gsValor$ 'gsCodigo
         Grd_Datos.TextMatrix(Grd_Datos.Row, colNomCli) = Trim(gsNombre$)
         
         Call Proc_Genera_Fila_Contratos_Grilla(Grd_Datos, MatrizContratoFisico(), MatrizClausulas, MatrizSeleccion, False)
         Exit Sub
      End If
   End If
   
   If Grd_Datos.Col > 2 Then
      If Right(Grd_Datos.Text, 1) = "N" Then
         If Trim(Mid(Grd_Datos.Text, 61, 10)) = "DINAMICO" Then
            For nContador = 3 To Grd_Datos.Cols - 1
               If Trim(Mid(Grd_Datos.TextMatrix(Grd_Datos.Row, nContador), 1, 10)) = Trim(Mid(Grd_Datos.TextMatrix(Grd_Datos.Row, Grd_Datos.ColSel), 71, 10)) Then
                  If Right(Grd_Datos.TextMatrix(Grd_Datos.Row, nContador), 1) = "N" Then
                     Screen.MousePointer = vbDefault
                     MsgBox "Antes de seleccionar una clausula dinamica debe seleccionar el documento fisico al cual se encuentra asociado", vbExclamation + vbOKOnly
                     Exit Sub
                  End If
               End If
            Next nContador
         End If
         Grd_Datos.Text = Mid(Grd_Datos.Text, 1, Len(Grd_Datos.Text) - 1) & "S"
         Grd_Datos.CellBackColor = vbGreen
         Grd_Datos.CellForeColor = vbBlack
      ElseIf Right(Grd_Datos.Text, 1) = "S" Then
         If Trim(Mid(Grd_Datos.Text, 61, 10)) = "FISICO" Then
            For nContador = Grd_Datos.ColSel + 1 To Grd_Datos.Cols - 1
               If Trim(Mid(Grd_Datos.TextMatrix(Grd_Datos.Row, nContador), 71, 10)) = Trim(Mid(Grd_Datos.TextMatrix(Grd_Datos.Row, Grd_Datos.ColSel), 1, 10)) Then
                  If Right(Grd_Datos.TextMatrix(Grd_Datos.Row, nContador), 1) = "S" Then
                     Grd_Datos.TextMatrix(Grd_Datos.Row, nContador) = Mid(Grd_Datos.TextMatrix(Grd_Datos.Row, nContador), 1, Len(Grd_Datos.TextMatrix(Grd_Datos.Row, nContador)) - 1) & "N"
                     nColumnaAnterior = Grd_Datos.ColSel
                     Grd_Datos.Col = nContador
                     Grd_Datos.CellBackColor = vbRed
                     Grd_Datos.CellForeColor = vbWhite
                     Grd_Datos.Col = nColumnaAnterior
                  End If
               End If
            Next nContador
         End If
         
         Grd_Datos.Text = Mid(Grd_Datos.Text, 1, Len(Grd_Datos.Text) - 1) & "N"
         Grd_Datos.CellBackColor = vbRed
         Grd_Datos.CellForeColor = vbWhite
      End If
   End If
   
End Sub

Private Sub Grd_Datos_KeyDown(KeyCode As Integer, Shift As Integer)

   Dim van As Long
   
   If KeyCode = vbKeyInsert Then
      Grd_Datos.Rows = Grd_Datos.Rows + 1
      
      'Guardar las filas solo para Forward.  PRD-3166
      If Left(Cmb_Sistema.Text, 3) = "BFW" Then
        van = nInsertados
        ReDim Preserve Insertados(van + 1)
        Insertados(van + 1) = Grd_Datos.Rows - 1
        nInsertados = nInsertados + 1
      End If
      
      Grd_Datos.Col = 1
      Grd_Datos.Row = Grd_Datos.Rows - 1
      Call Grd_Datos_DblClick
   End If
   
   If KeyCode = vbKeyDelete Then
      Call Proc_Eliminar
      
   End If

End Sub


Private Sub Grd_Datos_LostFocus()

   Lbl_Descripcion.Caption = ""

End Sub

Private Sub Tbl_Opciones_ButtonClick(ByVal Button As MSComctlLib.Button)

   Select Case Button.Index
      Case BtnLimpiar
         Proc_Limpiar
      
      Case BtnGrabar
         Proc_Grabar
      
      Case BtnEliminar
         Proc_Eliminar
      
      Case BtnSalir
         Unload Me

   End Select

End Sub



