VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form BacMod 
   BorderStyle     =   1  'Fixed Single
   ClientHeight    =   5730
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   6075
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   Moveable        =   0   'False
   ScaleHeight     =   5730
   ScaleWidth      =   6075
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.Frame Frame1 
      Caption         =   "[ Pendiendes de Liquidación ]"
      Height          =   4455
      Left            =   0
      TabIndex        =   7
      Top             =   1200
      Width           =   6015
      Begin MSFlexGridLib.MSFlexGrid Lst_Pendientes 
         Height          =   3975
         Left            =   120
         TabIndex        =   8
         TabStop         =   0   'False
         Top             =   240
         Width           =   5700
         _ExtentX        =   10054
         _ExtentY        =   7011
         _Version        =   393216
         Cols            =   3
         BackColor       =   12632256
         BackColorFixed  =   -2147483646
         ForeColorFixed  =   16777215
         FocusRect       =   0
         GridLines       =   2
         SelectionMode   =   1
         AllowUserResizing=   1
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
   End
   Begin Threed.SSFrame SSFrame1 
      Height          =   690
      Left            =   30
      TabIndex        =   0
      Top             =   510
      Width           =   6030
      _Version        =   65536
      _ExtentX        =   10636
      _ExtentY        =   1217
      _StockProps     =   14
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin VB.TextBox TxtNumDocu 
         Alignment       =   1  'Right Justify
         Height          =   315
         Left            =   2220
         TabIndex        =   1
         Top             =   825
         Width           =   1095
      End
      Begin Threed.SSOption SSOption2 
         Height          =   360
         Left            =   2925
         TabIndex        =   3
         Top             =   255
         Width           =   1125
         _Version        =   65536
         _ExtentX        =   1984
         _ExtentY        =   635
         _StockProps     =   78
         Caption         =   "Pago Total"
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin Threed.SSOption SSOption1 
         Height          =   285
         Left            =   240
         TabIndex        =   2
         Top             =   300
         Width           =   1005
         _Version        =   65536
         _ExtentX        =   1773
         _ExtentY        =   503
         _StockProps     =   78
         Caption         =   "Modificar"
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin Threed.SSOption SSOption3 
         Height          =   285
         Left            =   1395
         TabIndex        =   5
         Top             =   285
         Width           =   1320
         _Version        =   65536
         _ExtentX        =   2328
         _ExtentY        =   503
         _StockProps     =   78
         Caption         =   "Pago Parcial"
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin Threed.SSOption SSOption4 
         Height          =   360
         Left            =   4260
         TabIndex        =   6
         Top             =   240
         Width           =   1125
         _Version        =   65536
         _ExtentX        =   1984
         _ExtentY        =   635
         _StockProps     =   78
         Caption         =   "Anulación"
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   8160
      Top             =   120
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   3
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMod.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMod.frx":0452
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMod.frx":08A4
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   4
      Top             =   0
      Width           =   6075
      _ExtentX        =   10716
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdGrabar"
            Description     =   "ACEPTAR"
            Object.ToolTipText     =   "Grabar Operación"
            ImageIndex      =   1
            BeginProperty ButtonMenus {66833FEC-8583-11D1-B16A-00C0F0283628} 
               NumButtonMenus  =   1
               BeginProperty ButtonMenu1 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
            EndProperty
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmbcancelar"
            Description     =   "CANCELAR"
            Object.ToolTipText     =   "Cancelar"
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
End
Attribute VB_Name = "BacMod"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim valor As Boolean
Dim entra As Boolean

Private Sub Aceptar()

   If Val(TxtNumDocu.Text) = 0 Then
      MsgBox "Debe ingresar el nuemro de la operacion", vbExclamation + vbOKOnly
      Exit Sub
   End If

    If SSOption2.Value = False And _
        SSOption3.Value = False And _
        SSOption4.Value = False Then
        MsgBox "Debe seleccionar alguna accion", vbExclamation + vbOKOnly
        Exit Sub
    End If
    
    
    
   If SSOption1.Value = True Then
'      If Val(Me.TxtNumDocu.Text) <> 0 Then
'         entra = True
'         Call Modificacion_operacion(Me.TxtNumDocu.Text, "M")
'         If valor = True Then
'            Modificacion = True
'            Anulacion = False
'            Tipo_Pago_parcial = False
'            Tipo_Pago_total = False
'            gSQL = ""
'            gSQL = gSQL & CDbl(TxtNumDocu.Text)
'            gsNmoper_Fli = CDbl(TxtNumDocu.Text)
'            Unload Me
'            Exit Sub
'         Else
'            Unload Me
'            Exit Sub
'         End If
'      Else
'         MsgBox "Debe Ingresar Nùmero de Operación, para Modificar", vbInformation, gsBac_Version
'         TxtNumDocu.SetFocus
'         SSOption1.Value = False
'         Exit Sub
'      End If
   ElseIf SSOption2.Value = True Then   '--> Correpsonde a pago Total
      entra = False
      Call Modificacion_operacion(Me.TxtNumDocu.Text, "N", "T")
      If valor = True Then
         Modificacion = True
         Anulacion = False
         Tipo_Pago_total = True
         Tipo_Pago_parcial = False
         gSQL = ""
         gSQL = gSQL & CDbl(TxtNumDocu.Text)
         gsNmoper_Fli = CDbl(TxtNumDocu.Text)
         Unload Me
         Exit Sub
      Else
         Unload Me
         Exit Sub
      End If
      


   ElseIf SSOption3.Value = True Then   ' --> Corresponde a Pago Parcial
       entra = False
        Call Modificacion_operacion(Me.TxtNumDocu.Text, "N", "P") '  ---
        If valor = True Then
            Modificacion = True
            Anulacion = False
            Tipo_Pago_total = False
            Tipo_Pago_parcial = True
            gSQL = ""
            gSQL = gSQL & CDbl(TxtNumDocu.Text)
            gsNmoper_Fli = CDbl(TxtNumDocu.Text)
            Unload Me
            Exit Sub
         Else
            Unload Me
            Exit Sub
         End If
         
      ElseIf SSOption4.Value = True Then  ' Corresponde a Anulacion
         entra = True
         Call Modificacion_operacion(Me.TxtNumDocu.Text, "N", "E")
         If valor = True Then
            Call Func_Anular_Datos
            Modificacion = True
            Anulacion = True
            Tipo_Pago_total = False
            Tipo_Pago_parcial = True
            gSQL = ""
            gSQL = gSQL & CDbl(TxtNumDocu.Text)
            gsNmoper_Fli = CDbl(TxtNumDocu.Text)
            
            
            
            
            If gsBac_Lineas = "S" Then
               If Not Lineas_Anular("BTR", Val(NumeroOperacionExceso)) Then
               End If
            End If
            Unload Me
            Exit Sub
         Else
            Unload Me
            Exit Sub
         End If
   End If
End Sub


Private Sub Func_Anular_Datos()
    
    Dim Msg              As String
    Dim dNumdocu#
    Dim I%
    Dim NumctaCte As String
    Dim MontoCta As Double
    Dim Datos()
    
    
     NumeroOperacionExceso = CDbl(TxtNumDocu.Text)
     MousePointer = 11
    
        Sql = "EXECUTE SP_LLAMAPROCESO " & Val(NumeroOperacionExceso) & ",'" & "FLI" & "'," & gsBac_CartRUT & ",'" & "A" & "'"
         
         If miSQL.SQL_Execute(Sql) <> 0 Then
            MsgBox "Problemas con la Liberación de la Operación", vbCritical, gsBac_Version
            Exit Sub
         
         End If
         
         
         If miSQL.SQL_Fetch(Datos()) <> 0 Then
            MsgBox "Error en Liberación", vbCritical, gsBac_Version
            Exit Sub
         End If
         
         If Datos(1) = "NO" Then
            MsgBox Datos(2), vbCritical, vbCritical, gsBac_Version
            Exit Sub
         End If
        

    
        Sql = "EXECUTE bactradersuda.DBO.SP_ANULA_PAPELETAFLI '" & Format(gsBac_Fecp, "yyyymmdd") & "'," & Val(NumeroOperacionExceso)
    
        If miSQL.SQL_Execute(Sql) <> 0 Then
            MsgBox "Problemas con la consulta", vbCritical, gsBac_Version
            valor = False
            giAceptar% = False
            Exit Sub
        End If
        
        'PRD-6010
        Sql = "EXECUTE bactradersuda.dbo.SP_ELIMINA_SOMA '" & Format(gsBac_Fecp, "yyyymmdd") & "'," & Val(NumeroOperacionExceso)
    
        If miSQL.SQL_Execute(Sql) <> 0 Then
            MsgBox "Problemas al eliminar operacion SOMA", vbCritical, gsBac_Version
            valor = False
            giAceptar% = False
            Exit Sub
        End If
        'PRD-6010
        
        
        MsgBox "Operacion " & NumeroOperacionExceso & " Anulada Correctamente", vbInformation, gsBac_Version
    
         Exit Sub
    'Unload Me
    
    
    
End Sub



Private Sub Modificacion_operacion(Numoper As Double, Estado As String, Optional sRevisaEstado As String = "T")
Dim Datos()

    valor = True
    giAceptar% = True
    
    
    
    Envia = Array()
    AddParam Envia, CDbl(Numoper)
    AddParam Envia, sRevisaEstado
    
    If Not Bac_Sql_Execute("SVC_CMP_NUM_OPR", Envia) Then
        Exit Sub
    End If
    
    If Bac_SQL_Fetch(Datos()) Then
        If Datos(1) <> 0 Then
            MsgBox Datos(2), vbExclamation
            Set ControlFinanciero = Nothing
            MousePointer = 0
            valor = False
            giAceptar% = False
            Exit Sub
        End If
    End If
        
    
    
    If entra = True Then
    
        Sql = "EXECUTE SP_BUSCA_PAGOS " & CDbl(Replace(Numoper, ",", "."))
    
        If miSQL.SQL_Execute(Sql) <> 0 Then
            MsgBox "Problemas con la consulta", vbCritical, gsBac_Version
            valor = False
            giAceptar% = False
            Exit Sub
        End If
    
    
        If miSQL.SQL_Fetch(Datos()) <> 0 Then
            MsgBox "Error en consulta", vbCritical, gsBac_Version
            valor = False
            giAceptar% = False
            Exit Sub
        End If
    
        If Datos(1) = 1 Then
            MsgBox Datos(2), vbCritical, gsBac_Version
            MousePointer = 0
            giAceptar% = False
            valor = False
            TxtNumDocu.SetFocus
            Exit Sub
        End If
    End If

End Sub

Private Sub Form_Activate()

    BacControlWindows 100
    'borrar_tabla_paso ("T")
End Sub

Private Sub borrar_tabla_paso(Serie As String)
       
    Envia = Array()
    AddParam Envia, " "
    AddParam Envia, Serie
    AddParam Envia, " "
    AddParam Envia, " "
    AddParam Envia, 0
    AddParam Envia, 0
    AddParam Envia, 0
    AddParam Envia, 0
    AddParam Envia, " "
    AddParam Envia, " "
    AddParam Envia, 0
    AddParam Envia, 0
    AddParam Envia, 0
    AddParam Envia, 0
    AddParam Envia, " "
    AddParam Envia, 0
    AddParam Envia, 0
    AddParam Envia, 1
    AddParam Envia, gsBac_User
    
    If Not Bac_Sql_Execute("SVC_GBR_FLJ_LQZ", Envia) Then
       MsgBox "problemas al RESTAURAR"
       Exit Sub
    End If
       
End Sub

Private Sub Form_Load()

    BacCentrarPantalla Me
    giAceptar% = False
    giLoad% = True
    
    
    Call SET_GRILLA
    Call LOAD_PENDIENTES_FLI
End Sub

Private Sub Lst_Pendientes_Click()
    If Lst_Pendientes.RowSel = 0 Then
        Exit Sub
    Else
       TxtNumDocu.Text = Lst_Pendientes.TextMatrix(Lst_Pendientes.RowSel, 0)
       BACFLI.nMaximoIngreso = Lst_Pendientes.TextMatrix(Lst_Pendientes.RowSel, 1) - Val(Lst_Pendientes.TextMatrix(Lst_Pendientes.RowSel, 2))
    End If
    
End Sub

Private Sub SSOption1_Click(Value As Integer)

  TxtNumDocu.SetFocus

End Sub

Private Sub SSOption2_Click(Value As Integer)
  
   TxtNumDocu.SetFocus
   
End Sub


Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

    Select Case UCase(Button.Description)
    
        Case "ACEPTAR"
            Call Aceptar
    
        Case "CANCELAR"
            Unload Me
            
    End Select

End Sub

Private Sub TxtNumDocu_Change()
TxtNumDocu.Text = Format(BACChBl(TxtNumDocu.Text), "###,###,##0")
TxtNumDocu.SelStart = Len(TxtNumDocu.Text)
End Sub

Private Sub SET_GRILLA()

   Let Lst_Pendientes.Rows = 2:   Let Lst_Pendientes.FixedRows = 1
   Let Lst_Pendientes.Cols = 3:   Let Lst_Pendientes.FixedCols = 0

   Let Lst_Pendientes.TextMatrix(0, 0) = "Num. Operacion":      Let Lst_Pendientes.ColWidth(0) = 1300
   Let Lst_Pendientes.TextMatrix(0, 1) = "Monto Tomado":        Let Lst_Pendientes.ColWidth(1) = 2000
   Let Lst_Pendientes.TextMatrix(0, 2) = "Monto Pagado":        Let Lst_Pendientes.ColWidth(2) = 2000
   Let Lst_Pendientes.Rows = 1

End Sub
Sub LOAD_PENDIENTES_FLI()
   Dim Datos()
      Envia = Array()

      If Not Bac_Sql_Execute("EXECUTE DBO.LST_FLIPENDIENTES", Envia) Then
         Let Screen.MousePointer = vbDefault
         Call MsgBox("Se ha originado un error en la lectura de operaciones." & vbCrLf & vbCrLf & VerSql, vbExclamation, App.Title)
         Exit Sub
      End If
      
      Let Lst_Pendientes.Rows = 1
      
      Do While Bac_SQL_Fetch(Datos())
         Let Lst_Pendientes.Rows = Lst_Pendientes.Rows + 1
         Let Lst_Pendientes.TextMatrix(Lst_Pendientes.Rows - 1, 0) = Datos(1)
         Let Lst_Pendientes.TextMatrix(Lst_Pendientes.Rows - 1, 1) = Format(Datos(2), "#,##0.0000")
         Let Lst_Pendientes.TextMatrix(Lst_Pendientes.Rows - 1, 2) = Format(Datos(3), "#,##0.0000")
      Loop

End Sub


