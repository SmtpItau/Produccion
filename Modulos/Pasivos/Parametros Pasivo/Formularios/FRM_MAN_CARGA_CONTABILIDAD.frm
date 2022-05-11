VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "threed32.ocx"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "COMDLG32.OCX"
Begin VB.Form FRM_MAN_CARGA_CONTABILIDAD 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Carga de Contabilidad"
   ClientHeight    =   5940
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   5325
   BeginProperty Font 
      Name            =   "Arial"
      Size            =   8.25
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   5940
   ScaleWidth      =   5325
   Begin VB.Frame Frame1 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   5430
      Left            =   60
      TabIndex        =   1
      Top             =   495
      Width           =   5295
      Begin VB.TextBox txt_Errores 
         Height          =   2040
         Left            =   75
         MultiLine       =   -1  'True
         ScrollBars      =   3  'Both
         TabIndex        =   15
         Top             =   3330
         Width           =   5025
      End
      Begin VB.TextBox txt_Ristra 
         Enabled         =   0   'False
         Height          =   315
         Left            =   480
         TabIndex        =   12
         Top             =   2460
         Width           =   4710
      End
      Begin VB.TextBox txt_Concepto 
         Enabled         =   0   'False
         Height          =   315
         Left            =   465
         TabIndex        =   11
         Top             =   510
         Width           =   4710
      End
      Begin VB.CheckBox chk_Ristra 
         Height          =   210
         Left            =   135
         TabIndex        =   10
         Top             =   2505
         Width           =   240
      End
      Begin VB.CheckBox chk_Concepto 
         Height          =   210
         Left            =   135
         TabIndex        =   9
         Top             =   555
         Width           =   240
      End
      Begin VB.CheckBox chk_Operacion 
         Height          =   210
         Left            =   135
         TabIndex        =   8
         Top             =   1200
         Width           =   240
      End
      Begin VB.CheckBox chk_Parametria 
         Height          =   210
         Left            =   150
         TabIndex        =   7
         Top             =   1845
         Width           =   240
      End
      Begin MSComDlg.CommonDialog dlg_Rutas 
         Left            =   4785
         Top             =   2805
         _ExtentX        =   847
         _ExtentY        =   847
         _Version        =   393216
      End
      Begin VB.TextBox txt_Operacion 
         Enabled         =   0   'False
         Height          =   315
         Left            =   480
         TabIndex        =   6
         Top             =   1155
         Width           =   4710
      End
      Begin VB.TextBox txt_Parametria 
         Enabled         =   0   'False
         Height          =   315
         Left            =   495
         TabIndex        =   5
         Top             =   1800
         Width           =   4710
      End
      Begin Threed.SSPanel pnl_Porcentaje_Parametria 
         Height          =   330
         Left            =   45
         TabIndex        =   3
         Top             =   2880
         Width           =   5205
         _Version        =   65536
         _ExtentX        =   9181
         _ExtentY        =   582
         _StockProps     =   15
         BackColor       =   14478830
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BorderWidth     =   1
         BevelOuter      =   1
         BevelInner      =   2
         FloodType       =   1
      End
      Begin VB.Label Label4 
         Caption         =   "Ristras Contables"
         Height          =   285
         Left            =   150
         TabIndex        =   14
         Top             =   2205
         Width           =   1560
      End
      Begin VB.Label Label3 
         Caption         =   "Concepto Contable"
         Height          =   285
         Left            =   150
         TabIndex        =   13
         Top             =   255
         Width           =   2070
      End
      Begin VB.Label Label2 
         Caption         =   "Codigo Operacion Contable"
         Height          =   285
         Left            =   165
         TabIndex        =   4
         Top             =   900
         Width           =   2715
      End
      Begin VB.Label Label1 
         Caption         =   "Parametria"
         Height          =   285
         Left            =   165
         TabIndex        =   2
         Top             =   1545
         Width           =   1560
      End
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   4020
      Top             =   0
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   24
      ImageHeight     =   24
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   7
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MAN_CARGA_CONTABILIDAD.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MAN_CARGA_CONTABILIDAD.frx":0EDA
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MAN_CARGA_CONTABILIDAD.frx":1DB4
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MAN_CARGA_CONTABILIDAD.frx":2C8E
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MAN_CARGA_CONTABILIDAD.frx":2FA8
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MAN_CARGA_CONTABILIDAD.frx":3E82
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MAN_CARGA_CONTABILIDAD.frx":4D5C
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
      Width           =   5325
      _ExtentX        =   9393
      _ExtentY        =   847
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Default"
            Object.ToolTipText     =   "Cargar Interfaz"
            ImageIndex      =   7
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Description     =   "Salir"
            Object.ToolTipText     =   "Cerrar Ventana"
            ImageIndex      =   4
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
End
Attribute VB_Name = "FRM_MAN_CARGA_CONTABILIDAD"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Function FUNC_Actualizar_Contabilidad()
Dim sFile       As String
Dim sProc       As String
Dim sVariable   As String
Dim nTotal      As Long
Dim nContador   As Long
Dim nContador1  As Long
Dim lSw         As Boolean
Dim nErr        As Boolean
Dim sMsg        As String
Dim nErrores    As Long
Dim vArreglo
Dim Primero     As String

txt_Errores.Text = ""

'/* Carga de Concepto Contable desde un BCP separado por ;
'--------------------------------------------------------- */
If chk_Concepto.Value = 1 Then
    
    sFile = txt_Concepto.Text
    lSw = True
    
    If Len(Dir(sFile, vbArchive)) <> 0 And Len(sFile) <> 0 Then
    
        nTotal = 1
        nContador = 1
        Open sFile For Input As #1
        Do While Not EOF(1)
            Line Input #1, sVariable
            nTotal = nTotal + 1
        Loop
        Close #1
        
        pnl_Porcentaje_Parametria.FloodPercent = 1
        Open sFile For Input As #1
        Do While Not EOF(1)
        
            Line Input #1, sVariable
            
            vArreglo = Array()
            Call FUNC_Separa(sVariable, vArreglo)

            'ACRE;ACREEDORES COMPRA FUTURO      ;N;N;1;1;0;1;1;0;0;0;0;0;1;1;0
            Envia = Array()
            AddParam Envia, vArreglo(0)       'concepto contable
            AddParam Envia, vArreglo(1)       'descripcion
            AddParam Envia, IIf(vArreglo(3) = "S", 1, 0)     'inventario
            AddParam Envia, IIf(vArreglo(2) = "S", 1, 0)   'resultado
            AddParam Envia, Val(vArreglo(4))  'switch_producto
            AddParam Envia, Val(vArreglo(5))  'switch_garantia
            AddParam Envia, Val(vArreglo(6))  'switch_tipo_plazo
            AddParam Envia, Val(vArreglo(7))  'switch_financia
            AddParam Envia, Val(vArreglo(8))  'switch_sector
            AddParam Envia, Val(vArreglo(9))  'switch_corresponsal
            AddParam Envia, Val(vArreglo(10)) 'switch_propiedad
            AddParam Envia, Val(vArreglo(11)) 'switch_cuota
            AddParam Envia, Val(vArreglo(12)) 'switch_colocacion
            AddParam Envia, Val(vArreglo(13)) 'switch_recup
            AddParam Envia, Val(vArreglo(14)) 'switch_divisa
            AddParam Envia, Val(vArreglo(15)) 'switch_tipo_moneda
            AddParam Envia, Val(vArreglo(16)) 'referencia
            AddParam Envia, Val(vArreglo(17)) 'switch_codigo_operacion
                                    
                        
            If BAC_SQL_EXECUTE("SP_ACT_CONCEPTO_CONTABLE", Envia) Then
                If BAC_SQL_FETCH(Datos()) Then

                    Call FUNC_Muestra_Msg(Val(Datos(1)), "CARGA CONCEPTO CONTABLE : " & Datos(2), nErrores)
                        
                End If
            End If
            
            nContador = nContador + 1
            pnl_Porcentaje_Parametria.FloodPercent = IIf((nContador * 100) / nTotal > 100, 100, (nContador * 100) / nTotal)
            
        Loop
        Close #1
        pnl_Porcentaje_Parametria.FloodPercent = 100
    Else
        lSw = False
    End If
    
End If

'/* Carga de Codigo de Operacion desde un BCP separado por ;
'----------------------------------------------------------- */
If chk_Operacion.Value = 1 Then
    
    sFile = txt_Operacion.Text
    lSw = True
    
    If Len(Dir(sFile, vbArchive)) <> 0 And Len(sFile) <> 0 Then
    
        nTotal = 1
        nContador = 1
        Open sFile For Input As #1
        Do While Not EOF(1)
            Line Input #1, sVariable
            nTotal = nTotal + 1
        Loop
        Close #1
        
        pnl_Porcentaje_Parametria.FloodPercent = 1
        Open sFile For Input As #1
        Do While Not EOF(1)
        
            Line Input #1, sVariable
            
            vArreglo = Array()
            Call FUNC_Separa(sVariable, vArreglo)
            
            'BFW;1;MOV;AFM;ALTAS FORWARD ACTIVO MX MODIFICACION
            Envia = Array()
            AddParam Envia, vArreglo(0) 'sistema
            AddParam Envia, vArreglo(1) 'producto
            AddParam Envia, vArreglo(2) 'evento bac
            AddParam Envia, vArreglo(3) 'codigo operacion
            AddParam Envia, left(vArreglo(4), 50) 'descripcion

            If BAC_SQL_EXECUTE("SP_ACT_CODIGO_OPERACION_CONTABLE", Envia) Then
                If BAC_SQL_FETCH(Datos()) Then

                    Call FUNC_Muestra_Msg(Val(Datos(1)), "CARGA CODIGO DE OPERACION CONTABLE : " & Datos(2), nErrores)
                        
                End If
            End If
            
            nContador = nContador + 1
            pnl_Porcentaje_Parametria.FloodPercent = IIf((nContador * 100) / nTotal > 100, 100, (nContador * 100) / nTotal)
            
        Loop
        Close #1
        pnl_Porcentaje_Parametria.FloodPercent = 100
    Else
        lSw = False
    End If
    
End If


'/* Carga de Parametria desde un BCP separado por ;
'-------------------------------------------------- */
If chk_Parametria.Value = 1 Then
            
    sFile = txt_Parametria.Text
    lSw = True
    Primero = "S"
    
    If Len(Dir(Trim(sFile), vbArchive)) <> 0 And Len(sFile) <> 0 Then
    
        nTotal = 1
        nContador = 1
        Open sFile For Input As #1
        Do While Not EOF(1)
            Line Input #1, sVariable
            nTotal = nTotal + 1
        Loop
        Close #1
        
        pnl_Porcentaje_Parametria.FloodPercent = 1
        Open sFile For Input As #1
        Do While Not EOF(1)
        
            Line Input #1, sVariable
            
            vArreglo = Array()
            Call FUNC_Separa(sVariable, vArreglo)
            
            'BFW;3;AAU;CAPI0;1;D;999;1778;T;CAPI
            Envia = Array()
            'AddParam Envia, vArreglo(0) 'sistema
            'AddParam Envia, vArreglo(1) 'producto
          
            AddParam Envia, vArreglo(0) 'codigo operacion
            AddParam Envia, vArreglo(1) 'concepto programa
            AddParam Envia, CDec(vArreglo(2)) 'secuencia
            AddParam Envia, vArreglo(3) 'tipo cuenta
            AddParam Envia, CDec(vArreglo(4)) 'moneda
            AddParam Envia, vArreglo(5) 'centro de costo
            AddParam Envia, vArreglo(6) 'centro de costo
            AddParam Envia, vArreglo(7) 'concepto contable
            AddParam Envia, Primero
            
            If Len(vArreglo(0)) <> 0 And Len(vArreglo(1)) <> 0 Then
                If BAC_SQL_EXECUTE("SP_ACT_PARAMETRIA", Envia) Then
                    If BAC_SQL_FETCH(Datos()) Then

                        Call FUNC_Muestra_Msg(Val(Datos(1)), "CARGA DE PARAMETRIA : " & Datos(2), nErrores)
                        
                    End If
                End If
            End If
            
            Primero = "N"
            
            nContador = nContador + 1
            pnl_Porcentaje_Parametria.FloodPercent = IIf((nContador * 100) / nTotal > 100, 100, (nContador * 100) / nTotal)
            
        Loop
        Close #1
        pnl_Porcentaje_Parametria.FloodPercent = 100
    Else
        lSw = False
    End If
    
End If

'/* Carga de Ristras Contables desde un BCP separado por ;
'--------------------------------------------------------- */
If chk_Ristra.Value = 1 Then
    
    sFile = txt_Ristra.Text
    lSw = True
    
    If Len(Dir(sFile, vbArchive)) <> 0 And Len(sFile) <> 0 Then
    
        nTotal = 1
        nContador = 1
        Open sFile For Input As #1
        Do While Not EOF(1)
            Line Input #1, sVariable
            nTotal = nTotal + 1
        Loop
        Close #1
        
        pnl_Porcentaje_Parametria.FloodPercent = 1
        Open sFile For Input As #1
        Do While Not EOF(1)
        
            Line Input #1, sVariable
            
            vArreglo = Array()
            Call FUNC_Separa(sVariable, vArreglo)
            
            Envia = Array()
            AddParam Envia, vArreglo(0) 'ristra
            AddParam Envia, vArreglo(1) 'cuenta

            If BAC_SQL_EXECUTE("SP_ACT_RISTRA_CONTABLE", Envia) Then
                If BAC_SQL_FETCH(Datos()) Then

                    Call FUNC_Muestra_Msg(Val(Datos(1)), "CARGA RISTRA CONTABLE : " & Datos(2), nErrores)
                        
                End If
            End If
            
            nContador = nContador + 1
            pnl_Porcentaje_Parametria.FloodPercent = IIf((nContador * 100) / nTotal > 100, 100, (nContador * 100) / nTotal)
            
        Loop
        Close #1
        pnl_Porcentaje_Parametria.FloodPercent = 100
    Else
        lSw = False
    End If
    
End If

If nErrores > 0 Then
    MsgBox "La carga de informacion arrojo " & Str(nErrores) & " error(es)..", vbExclamation
Else
    If lSw Then
        MsgBox "Carga de Archivos completada..", vbInformation
    Else
        MsgBox "Carga no se ha realizado en forma correcta...", vbExclamation
    End If
End If

End Function

Function FUNC_AT(sChar As String, sVariable As String) As Long
Dim nContador   As Long

FUNC_AT = 0

For nContador = 1 To Len(sVariable)
    If Mid(sVariable, nContador, 1) = sChar Then
        FUNC_AT = nContador
        Exit For
    End If
Next

End Function

Function FUNC_Muestra_Msg(nError As Long, sMsg As String, ByRef nErrores As Long)

If nError = -1 Then
    txt_Errores.Text = txt_Errores.Text & sMsg & Chr(13) & Chr(10)
    nErrores = nErrores + 1
    DoEvents
End If

End Function

Function FUNC_Separa(sChar As String, ByRef vArreglo As Variant) As Variant
Dim sVar                As String
Dim nContador           As Long

sVar = sChar
nContador = 1

Do While Len(sVar) > 0
   
    ReDim Preserve vArreglo(nContador)
   
    If FUNC_AT(";", sVar) <> 0 Then
        vArreglo(UBound(vArreglo) - 1) = left(sVar, FUNC_AT(";", sVar) - 1)
        sVar = Mid(sVar, FUNC_AT(";", sVar) + 1)
    Else
        vArreglo(UBound(vArreglo) - 1) = sVar
        sVar = ""
    End If
    
    nContador = nContador + 1
    
Loop

End Function

Private Sub Check1_Click()

End Sub

Private Sub chk_Concepto_Click()

    txt_Concepto.Enabled = (chk_Concepto.Value = 1)

End Sub


Private Sub chk_Operacion_Click()

    txt_Operacion.Enabled = (chk_Operacion.Value = 1)

End Sub

Private Sub chk_Parametria_Click()

txt_Parametria.Enabled = (chk_Parametria.Value = 1)

End Sub


Private Sub chk_Ristra_Click()

txt_Ristra.Enabled = (chk_Ristra.Value = 1)

End Sub

Private Sub Form_Activate()
    PROC_CARGA_AYUDA Me, " "
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
Dim opcion As Integer

If KeyCode <> vbKeyControl And (Shift = 2 Or (Shift = 0 And (KeyCode = vbKeyReturn Or KeyCode = vbKeyEscape Or (KeyCode >= vbKeyF1 And KeyCode <= vbKeyF12)))) Then

opcion = 0
   Select Case KeyCode

         Case vbKeyProcesar
               opcion = 1
         
         Case vbKeySalir
               opcion = 2
   End Select

   If opcion <> 0 Then
      If Tlb_Botones.Buttons(opcion).Enabled Then
         Call Tlb_Botones_ButtonClick(Tlb_Botones.Buttons(opcion))
      End If

   End If

End If


End Sub

Private Sub Form_Load()

Set Me.Icon = BAC_Parametros.Icon
Me.top = 0
Me.left = 0

End Sub


Private Sub Tlb_Botones_ButtonClick(ByVal Button As MSComctlLib.Button)

Select Case Button.Index
    Case 1
        Call FUNC_Actualizar_Contabilidad
        
    Case 2
        Unload Me
End Select

End Sub





Private Sub txt_Concepto_DblClick()
    
    dlg_Rutas.Action = 1
    If Len(dlg_Rutas.FileName) <> 0 Then
        txt_Concepto.Text = dlg_Rutas.FileName
    End If

End Sub


Private Sub txt_Operacion_DblClick()

    dlg_Rutas.Action = 1
    If Len(dlg_Rutas.FileName) <> 0 Then
        txt_Operacion.Text = dlg_Rutas.FileName
    End If
    
End Sub


Private Sub txt_Parametria_DblClick()

    dlg_Rutas.Action = 1
    If Len(dlg_Rutas.FileName) <> 0 Then
        txt_Parametria.Text = dlg_Rutas.FileName
    End If

End Sub



Private Sub txt_Ristra_DblClick()
    
    dlg_Rutas.Action = 1
    If Len(dlg_Rutas.FileName) <> 0 Then
        txt_Ristra.Text = dlg_Rutas.FileName
    End If

End Sub


