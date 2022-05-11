VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "Msflxgrd.ocx"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form FRM_MNT_TIPOS_CAMBIO_CONTABLE 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantenedor de Tipos de Cambio Contable"
   ClientHeight    =   6420
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   6390
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   6420
   ScaleWidth      =   6390
   Begin MSComctlLib.Toolbar TlbHerramientas 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   5
      Top             =   0
      Width           =   6390
      _ExtentX        =   11271
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImlBotones"
      HotImageList    =   "ImlBotones"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   5
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Eliminar"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Cerrar"
            ImageIndex      =   5
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImlBotones 
         Left            =   4410
         Top             =   -90
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
               Picture         =   "FRM_MNT_TIPOS_CAMBIO_CONTABLE.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_TIPOS_CAMBIO_CONTABLE.frx":0EDA
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_TIPOS_CAMBIO_CONTABLE.frx":1DB4
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_TIPOS_CAMBIO_CONTABLE.frx":2C8E
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_TIPOS_CAMBIO_CONTABLE.frx":3B68
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame FrParametros 
      Caption         =   "Fecha"
      ForeColor       =   &H00800000&
      Height          =   1050
      Left            =   0
      TabIndex        =   3
      Top             =   510
      Width           =   6330
      Begin BACControles.TXTFecha Fecha 
         Height          =   255
         Left            =   555
         TabIndex        =   6
         Top             =   435
         Width           =   1575
         _ExtentX        =   2778
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
         Text            =   "05/12/2006"
      End
      Begin VB.Frame FrDuration 
         Caption         =   "Duration"
         ForeColor       =   &H00800000&
         Height          =   825
         Left            =   135
         TabIndex        =   4
         Top             =   1770
         Width           =   5220
      End
   End
   Begin VB.Frame FrPlazos 
      Caption         =   "Valores"
      ForeColor       =   &H00800000&
      Height          =   4815
      Left            =   0
      TabIndex        =   1
      Top             =   1560
      Width           =   6330
      Begin VB.ComboBox Cmb_Moneda 
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
         Left            =   3495
         Style           =   2  'Dropdown List
         TabIndex        =   8
         Top             =   4455
         Visible         =   0   'False
         Width           =   1710
      End
      Begin VB.TextBox Text1 
         Height          =   315
         Left            =   4875
         TabIndex        =   7
         TabStop         =   0   'False
         Top             =   4560
         Visible         =   0   'False
         Width           =   1500
      End
      Begin BACControles.TXTNumero TxnValor 
         Height          =   285
         Left            =   75
         TabIndex        =   2
         Top             =   4485
         Width           =   1665
         _ExtentX        =   2937
         _ExtentY        =   503
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
         Text            =   "0,00"
         Text            =   "0,00"
         Min             =   "1"
         Max             =   "99999"
         CantidadDecimales=   "2"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin MSFlexGridLib.MSFlexGrid GrdTCCambios 
         Height          =   4290
         Left            =   75
         TabIndex        =   0
         Top             =   165
         Width           =   6210
         _ExtentX        =   10954
         _ExtentY        =   7567
         _Version        =   393216
         GridLines       =   2
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Courier New"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
   End
End
Attribute VB_Name = "FRM_MNT_TIPOS_CAMBIO_CONTABLE"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit


Const BtnLimpiar = 1
Const BtnBuscar = 2
Const BtnGrabar = 3
Const BtnEliminar = 4
Const BtnCerrar = 5

'Constante de Grilla GrdTCCambios
Const colCod = 0
Const ColNemo = 1
''''Const ColGlosa = 2
Const ColTipCam = 2
Const ColPorc = 3
Const ColTipCamAnt = 4


' Constantes de retorno de procedimiento SP_BUSCA_DATOS_VALOR_MONEDA_CONTABLE
Const cNemo = 3
Const cGlosa = 4
Const nTipCam = 6
Const nPorc = 7
Const nTipCamAnt = 8



'----------------------------------------------------------------------

Dim nContador   As Long
Dim CmbKey As Integer
Private valant As String
Dim TipCamAyer As Double
Dim PorcAyer As Double
Dim TipCamHoy As Double





Private Sub Cmb_Moneda_Click()
   Text1.Text = ""
   Text1.Text = Cmb_Moneda
   If Verifica_Existencia(Text1.Text) Then
     GrdTCCambios.Text = ""
     MsgBox "Moneda No se Puede Repetir", vbCritical, TITSISTEMA
     GrdTCCambios.RemoveItem (GrdTCCambios.Row)
     cmb_Moneda_KeyPress (27)
     Exit Sub
   Else
     GrdTCCambios.Text = Cmb_Moneda.Text
     '''Cmb_Moneda.Text = ""
     Cmb_Moneda.Visible = False
   End If
    
End Sub

Private Sub cmb_Moneda_KeyPress(KeyAscii As Integer)


    If KeyAscii = 27 Then
         
         Cmb_Moneda.Visible = False
         ''''GrdTCCambios.Text = Cmb_Moneda.Tag
         'Grid.Col = 2
         GrdTCCambios.SetFocus
    
    End If
    
    If KeyAscii = 13 Then
    On Error GoTo fin
        'cmb_Moneda.Tag = Grid.Text
        GrdTCCambios.Text = Cmb_Moneda.Text
        Cmb_Moneda.Visible = False
        GrdTCCambios.SetFocus
    
    End If
    
fin:
End Sub

Private Sub cmb_Moneda_LostFocus()

    Cmb_Moneda.Visible = False

End Sub

Private Sub cmb_Moneda1_Change()

End Sub

Private Sub Fecha_Change()
 If Fecha.Text > gsbac_fecp Then
        MsgBox "Fecha no debe ser mayor a la fecha de proceso", vbExclamation, TITSISTEMA
        Fecha.Text = gsbac_fecp
 End If
End Sub

Private Sub Form_Load()
    
    Me.Icon = BACSwapParametros.Icon
          
      Call PROC_LLENA_COMBOS2(Cmb_Moneda, 8, False, "", "2", "3")
      Fecha.Text = gsbac_fecp
      Call Proc_Limpiar
      Call Proc_Buscar


End Sub


Private Sub Proc_Grabar()

    Screen.MousePointer = vbHourglass
    
    With GrdTCCambios
    
        For nContador = 1 To .Rows - 1
        
            If .TextMatrix(nContador, ColTipCam) = "" Then
                Screen.MousePointer = vbDefault
                MsgBox "Debe completar datos antes de grabar", vbExclamation, TITSISTEMA
                .Row = nContador
                .Col = ColTipCam
                Exit Sub
            End If
            
            If nContador > 1 Then
                'If (CDbl(.TextMatrix(nContador, ColGlosa)) <= CDbl(.TextMatrix(nContador - 1, ColTipCam)) Or CDbl(.TextMatrix(nContador, ColGlosa)) >= CDbl(.TextMatrix(nContador, ColTipCam))) Then
                '    Screen.MousePointer = vbDefault
                '    MsgBox "Existen plazos incongruentes, favor de rectifique los plazos ante de grabar", vbExclamation, TITSISTEMA
                '    .Row = nContador
                '    .Col = ColTipCam
                '    .SetFocus
                '    Exit Sub
                'End If
            End If
            
        Next nContador
    End With
    
    If Not Bac_Sql_Execute("BEGIN TRANSACTION") Then
        Screen.MousePointer = vbDefault
        MsgBox "Ha ocurrido un error al intentar grabar los plazos - BEGIN TRANSACTION", vbCritical, TITSISTEMA
        Exit Sub
    End If
        
    Envia = Array()
    AddParam Envia, Fecha.Text
        
    If Not Bac_Sql_Execute("SP_DEL_DATOS_VALOR_MONEDA_CONTABLE", Envia) Then
        Call Bac_Sql_Execute("ROLLBACK TRANSACTION")
        Screen.MousePointer = vbDefault
        MsgBox "Ha ocurrido un error al intentar grabar los plazos (1)", vbCritical, TITSISTEMA
        Exit Sub
    End If
'*************************

       With GrdTCCambios
       
           For nContador = 1 To .Rows - 1
              Envia = Array()
              AddParam Envia, (Fecha.Text)
              AddParam Envia, Trim(Left(.TextMatrix(nContador, ColNemo), 5))

                If Not Bac_Sql_Execute("SP_TRAE_TC_AYER", Envia) Then
                    Screen.MousePointer = vbDefault
                    MsgBox "Ha ocurrido un error al intentar recuperar los factores de ponderacion", vbCritical, TITSISTEMA
                    Exit Sub
                Else
                
                  
                    Do While Bac_SQL_Fetch(Datos())
                        With GrdTCCambios
                            '.Rows = .Rows + 1
                            '.Row = .Rows - 1
                            .RowHeight(.Rows - 1) = 330
                             TipCamAyer = Datos(1)
                             PorcAyer = Datos(2)
                             TipCamHoy = Datos(1)
                             
                             If CDbl(TipCamAyer) = 0 Then
                               TipCamAyer = 1
                             End If

                             If Abs(CDbl(100 - (.TextMatrix(nContador, ColTipCam) / CDbl(TipCamAyer)) * 100)) > PorcAyer And ((.TextMatrix(nContador, ColTipCam)) <> 0) Then
                                
                                   Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                                                           , gsbac_fecp _
                                                           , gsBac_IP _
                                                           , gsBAC_User _
                                                           , "PCA" _
                                                           , "OPC_902" _
                                                           , " " _
                                                           , "T/C EXCEDE PORCENTAJE DE VARIACION" _
                                                           , "VALOR_MONEDA_CONTABLE" _
                                                           , "MONEDA: " & .TextMatrix(nContador, ColNemo) & " TIPO CAMBIO: " & valant _
                                                           , "MONEDA: " & .TextMatrix(nContador, ColNemo) & " TIPO CAMBIO: " & .TextMatrix(nContador, ColTipCam))

                                 
                             End If
                       End With
                      Loop
                    End If
                    
         Next nContador
       End With


'*************************
    
    
    
    With GrdTCCambios
    
       For nContador = 1 To .Rows - 1
            Envia = Array()
            AddParam Envia, Fecha.Text
            AddParam Envia, Left(.TextMatrix(nContador, ColNemo), 5)
''''            AddParam Envia, .TextMatrix(nContador, ColGlosa)
            AddParam Envia, CDbl(.TextMatrix(nContador, ColTipCam))
        
            If Not Bac_Sql_Execute("SP_ACT_DATOS_VALOR_MONEDA_CONTABLE", Envia) Then
                Call Bac_Sql_Execute("ROLLBACK TRANSACTION")
                Screen.MousePointer = vbDefault
                MsgBox "Ha ocurrido un error al intentar grabar los Tipos de Cambio", vbCritical, TITSISTEMA
                Exit Sub
            End If
        Next nContador
        
    End With
    
    
    Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                          , gsbac_fecp _
                          , gsBac_IP _
                          , gsBAC_User _
                          , "PCA" _
                          , "OPC_902" _
                          , "01" _
                          , "Grabar" _
                          , "Tipo_Cambio_Contables" _
                          , " " _
                          , " ")
        
    If Not Bac_Sql_Execute("COMMIT TRANSACTION") Then
        Screen.MousePointer = vbDefault
        MsgBox "Ha ocurrido un error al intentar grabar los Tipos de Cambio - COMMIT TRANSACTION", vbCritical, TITSISTEMA
        Exit Sub
    End If
    
        
    Screen.MousePointer = vbDefault
    MsgBox "Los Tipos de Cambio han sido grabado con exito", vbInformation, TITSISTEMA
   ' Proc_Limpiar

End Sub


Private Sub Proc_Buscar()

    Dim Datos()

    Screen.MousePointer = vbHourglass
    
    Envia = Array()
    AddParam Envia, (Fecha.Text)
    
        
    If Not Bac_Sql_Execute("SP_BUSCA_DATOS_VALOR_MONEDA_CONTABLE", Envia) Then
        Screen.MousePointer = vbDefault
        MsgBox "Ha ocurrido un error al intentar recuperar los factores de ponderacion", vbCritical, TITSISTEMA
        Exit Sub
    Else
        Do While Bac_SQL_Fetch(Datos())
            With GrdTCCambios
                .Rows = .Rows + 1
                .Row = .Rows - 1
                .RowHeight(.Rows - 1) = 330
                
                .TextMatrix(.Row, ColNemo) = Datos(cNemo) + Space(8 - Len(Trim(Datos(cNemo)))) + Trim(Datos(cGlosa))
                .TextMatrix(.Row, ColTipCam) = BacFormatoMonto(Datos(nTipCam), 2)
                .TextMatrix(.Row, ColPorc) = Datos(nPorc)
                .TextMatrix(.Row, ColTipCamAnt) = Datos(nTipCamAnt)
                
             'Call Valida_Tipo_Cambio(TextMatrix(.Row, ColNemo), .TextMatrix(.Row, ColTipCam).TextMatrix(.Row, ColPorc))
                
            End With
        Loop
        
        FrParametros.Enabled = False
        FrPlazos.Enabled = True
       '' GrdTCCambios.SetFocus
        
        TlbHerramientas.Buttons(BtnBuscar).Enabled = False
        TlbHerramientas.Buttons(BtnGrabar).Enabled = True
        If GrdTCCambios.Rows > 1 Then TlbHerramientas.Buttons(BtnEliminar).Enabled = True
    End If
    
    Screen.MousePointer = vbDefault

End Sub


Private Sub GrdTCCambios_DblClick()

    With GrdTCCambios
        ''''If .Rows > 1 And .Col <> ColTipCam Then
        
            If .Col = ColTipCam Then
                Call PROC_POSICIONA_TEXTO(GrdTCCambios, TxnValor)
                TxnValor.Text = .TextMatrix(.Row, .Col)
                TxnValor.Visible = True
                TxnValor.MarcaTexto = True
                TxnValor.SetFocus
            End If
        ''''End If
        
        ''''If .Rows > 1 And .Col <> ColGlosa Then
        
            If .Col = ColNemo Then
                Call PROC_POSICIONA_TEXTO(GrdTCCambios, Cmb_Moneda)
                Cmb_Moneda.Visible = True
                Cmb_Moneda.SetFocus
            End If
        ''''End If
    End With

End Sub


Private Sub GrdTCCambios_KeyDown(KeyCode As Integer, Shift As Integer)

    Dim nFilaOld    As Long
    Dim nMayor      As Long
    
    If KeyCode = vbKeyInsert Then
        With GrdTCCambios
        
            If .TextMatrix(.Rows - 1, ColTipCam) = "" Or .TextMatrix(.Rows - 1, ColNemo) = "" Then
                Screen.MousePointer = vbDefault
                MsgBox "Debe completar datos antes de insertar otra linea", vbExclamation, TITSISTEMA
                .SetFocus
                KeyCode = 0
                .Col = ColTipCam
                Exit Sub
            End If
        
            .Rows = .Rows + 1
            .RowHeight(.Rows - 1) = 330
                
        End With
    End If
    
    If KeyCode = vbKeyDelete Then
        With GrdTCCambios
            If .Row > 1 Then
                .RemoveItem (.Row)
            End If
        End With
    End If
    
    If KeyCode = vbKeyReturn Then
        With GrdTCCambios
            If .Row > 0 And .Col = ColTipCam Then
                Call PROC_POSICIONA_TEXTO(GrdTCCambios, TxnValor)
                TxnValor.Visible = True
                TxnValor.Text = .Text
                TxnValor.MarcaTexto = True
                TxnValor.SetFocus
            End If
        End With
    End If
    
    


End Sub


Private Sub GrdTCCambios_KeyPress(KeyAscii As Integer)

    If KeyAscii >= vbKey0 And KeyAscii <= vbKey9 And GrdTCCambios.Col = ColTipCam Then
        TxnValor.Text = 0
        Call PROC_POSICIONA_TEXTO(GrdTCCambios, TxnValor)
        TxnValor.Visible = True
        TxnValor.Text = Chr(KeyAscii)
        TxnValor.MarcaTexto = False
        TxnValor.SelStart = 1
        TxnValor.SetFocus
    End If

End Sub


Private Sub TlbHerramientas_ButtonClick(ByVal Button As MSComctlLib.Button)

    Select Case Button.Index
    
        Case BtnLimpiar
            Call Proc_Limpiar
        
        Case BtnBuscar
            Call Proc_Buscar
            
        Case BtnGrabar
            Call Proc_Grabar
            
        Case BtnEliminar
            Call Proc_Eliminar
            
        Case BtnCerrar
            Unload Me
    
    End Select
    
End Sub


Private Sub Proc_Eliminar()

    Screen.MousePointer = vbDefault
    
    If MsgBox("Esta seguro de eliminar los plazos de esste sistema", vbQuestion + vbYesNo, TITSISTEMA) = vbNo Then
        Exit Sub
    End If

    Screen.MousePointer = vbHourglass
    
    If Not Bac_Sql_Execute("BEGIN TRANSACTION") Then
        Screen.MousePointer = vbDefault
        MsgBox "Ha ocurrido un error al intentar eliminar plazos (1)", vbCritical, TITSISTEMA
        Exit Sub
    End If
    
    Envia = Array()
    AddParam Envia, Fecha.Text
    
        
    If Not Bac_Sql_Execute("SP_DEL_DATOS_VALOR_MONEDA_CONTABLE", Envia) Then
        Call Bac_Sql_Execute("ROLLBACK TRANSACTION")
        Screen.MousePointer = vbDefault
        MsgBox "Ha ocurrido un error al intentar eliminar los Tipos de Cambio", vbCritical, TITSISTEMA
        Exit Sub
    End If
    
    If Not Bac_Sql_Execute("COMMIT TRANSACTION") Then
        Screen.MousePointer = vbDefault
        MsgBox "Ha ocurrido un error al intentar eliminar los Tipos de Cambio", vbCritical, TITSISTEMA
        Exit Sub
    End If
    
    Screen.MousePointer = vbDefault
    
    MsgBox "Los Tipo de Cambio Para La Fecha " + Fecha.Text + " Han Sido Eliminada Con Exito", vbInformation, TITSISTEMA
    Proc_Limpiar

End Sub


Private Sub Proc_Limpiar()

    With GrdTCCambios
        .Rows = 1
        .Cols = 5
            
        .TextMatrix(0, ColNemo) = "MONEDA"
''''        .TextMatrix(0, ColGlosa) = "GLOSA"
        .TextMatrix(0, ColTipCam) = "TIPO CAMBIO"
        .TextMatrix(0, ColPorc) = "PORC VAR"
        .TextMatrix(0, ColTipCamAnt) = "TIPO CAMBIO ANT"
        
        .FixedCols = 1
        
        .BackColorFixed = ColorVerde
        .ForeColorFixed = ColorGris
        
        .RowHeight(0) = 330
        .ColAlignment(0) = 4
        
        .ColWidth(ColNemo) = 3000 '1100
        .ColWidth(ColTipCam) = 1300
        .ColWidth(ColPorc) = 0
        .ColWidth(ColTipCamAnt) = 0
        
    End With

    
    TxnValor.Visible = False
    FrParametros.Enabled = True
    FrPlazos.Enabled = False
    
    TlbHerramientas.Buttons(BtnBuscar).Enabled = True
    TlbHerramientas.Buttons(BtnGrabar).Enabled = False
    TlbHerramientas.Buttons(BtnEliminar).Enabled = False

End Sub

Private Sub TxnValor_GotFocus()
  valant = GrdTCCambios.TextMatrix(GrdTCCambios.Row, ColTipCam)
 ' TxnValor.SelStart = 0
 ' TxnValor.SelLength = Len(TxnValor.Text)
End Sub

Private Sub TxnValor_KeyDown(KeyCode As Integer, Shift As Integer)
Dim dartos()
'Dim TipCamAyer As Double
'Dim PorcAyer As Double
'Dim TipCamHoy As Double


    If KeyCode = vbKeyEscape Then
        TxnValor.Visible = False
        GrdTCCambios.SetFocus
    End If
    
    
    If KeyCode = vbKeyReturn Then
        With GrdTCCambios
           'For nContador = 1 To .Rows - 1
              Envia = Array()
              AddParam Envia, (Fecha.Text)
              AddParam Envia, Trim(Left(.TextMatrix(.Row, ColNemo), 5))

                If Not Bac_Sql_Execute("SP_TRAE_TC_AYER", Envia) Then
                    Screen.MousePointer = vbDefault
                    MsgBox "Ha ocurrido un error al intentar recuperar los factores de ponderacion", vbCritical, TITSISTEMA
                    Exit Sub
                Else
                    Do While Bac_SQL_Fetch(Datos())
                        With GrdTCCambios
                            '.Rows = .Rows + 1
                            '.Row = .Rows - 1
                            .RowHeight(.Rows - 1) = 330
                             TipCamAyer = Datos(1)
                             PorcAyer = Datos(2)
                             TipCamHoy = Datos(1)
                             
                             If CDbl(TipCamAyer) = 0 Then
                               TipCamAyer = 1
                             End If

                             If Abs(CDbl(100 - (CDbl(TxnValor.Text) / CDbl(TipCamAyer)) * 100)) > PorcAyer Then  '''Or CDbl(100 - (TipCamAyer / CDbl(TxnValor.Text)) * 100) < (PorcAyer * -1) Then
                                
                                 If CDbl(TipCamAyer) = 1 Then
                                   TxnValor.Text = 0
                                 Else
                                   Screen.MousePointer = vbDefault
                                   MsgBox "Tipo de cambio excede Porcentaje de Variación", vbCritical, TITSISTEMA
''''                               TxnValor.Text = ""
''''                               TxnValor.Text = valant

''''                                   Call Grabar_Log_AUDITORIA(giBAC_Entidad _
''''                                                           , gsbac_fecp _
''''                                                           , gsBAC_Term _
''''                                                           , gsBAC_User _
''''                                                           , "PCA" _
''''                                                           , "OPC_902" _
''''                                                           , " " _
''''                                                           , "T/C EXCEDE PORCENTAJE DE VARIACION" _
''''                                                           , "VALOR_MONEDA_CONTABLE" _
''''                                                           , "MONEDA: " & .TextMatrix(.Row, ColNemo) & " TIPO CAMBIO: " & valant _
''''                                                           , "MONEDA: " & .TextMatrix(.Row, ColNemo) & " TIPO CAMBIO: " & TxnValor.Text)
                                                           
                           
                                 End If
                                 
                                .TextMatrix(.Row, ColTipCam) = TxnValor.Text
                                TxnValor.Visible = False
                                Exit Sub
                             End If

                        End With
                    Loop
               End If

             'Next nContador
             .TextMatrix(.Row, ColTipCam) = TxnValor.Text
            TxnValor.Visible = False
            GrdTCCambios.SetFocus
          End With
    
        
        
       
    End If


End Sub




Function Verifica_Existencia(Moneda As String) As Boolean
Dim i As Long


    Verifica_Existencia = False
    
    
    
    For i = 1 To GrdTCCambios.Rows - 2
    

        If Trim(Mid(GrdTCCambios.TextMatrix(i, 1), 1, 5)) = Trim(Mid(Moneda, 1, 5)) Then
           
               
                Verifica_Existencia = True
                Exit Function

                   
        End If
    
    Next i

End Function

