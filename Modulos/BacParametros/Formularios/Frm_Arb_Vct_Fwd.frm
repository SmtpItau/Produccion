VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BACCONTROLES.OCX"
Begin VB.Form Frm_Arb_Vct_Fwd 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Vencimiento de Arbitrajes desde Forward"
   ClientHeight    =   4305
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   8355
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   4305
   ScaleWidth      =   8355
   Begin VB.Frame Frame1 
      Caption         =   "Detalle de Corresponsales"
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
      Height          =   3795
      Left            =   0
      TabIndex        =   1
      Top             =   510
      Width           =   8355
      Begin BACControles.TXTNumero Txt_codigo 
         Height          =   315
         Left            =   5460
         TabIndex        =   4
         Top             =   1170
         Visible         =   0   'False
         Width           =   2535
         _ExtentX        =   4471
         _ExtentY        =   556
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
         Appearance      =   0
         BorderStyle     =   0
         Text            =   "0"
         Text            =   "0"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin VB.ComboBox Cmb_Tipo 
         Appearance      =   0  'Flat
         Height          =   315
         ItemData        =   "Frm_Arb_Vct_Fwd.frx":0000
         Left            =   5430
         List            =   "Frm_Arb_Vct_Fwd.frx":000A
         Style           =   2  'Dropdown List
         TabIndex        =   3
         Top             =   1470
         Visible         =   0   'False
         Width           =   2565
      End
      Begin MSFlexGridLib.MSFlexGrid Grilla 
         Height          =   3555
         Left            =   60
         TabIndex        =   2
         Top             =   180
         Width           =   8265
         _ExtentX        =   14579
         _ExtentY        =   6271
         _Version        =   393216
         Rows            =   14
         Cols            =   4
         FixedCols       =   0
         MergeCells      =   4
         AllowUserResizing=   3
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   480
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   8355
      _ExtentX        =   14737
      _ExtentY        =   847
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   4
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   0
      Top             =   0
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
            Picture         =   "Frm_Arb_Vct_Fwd.frx":001D
            Key             =   "Guardar"
            Object.Tag             =   "1"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Frm_Arb_Vct_Fwd.frx":046F
            Key             =   "Eliminar"
            Object.Tag             =   "2"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Frm_Arb_Vct_Fwd.frx":08C1
            Key             =   "Limpiar"
            Object.Tag             =   "3"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Frm_Arb_Vct_Fwd.frx":0BDB
            Key             =   "Ayuda"
            Object.Tag             =   "4"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Frm_Arb_Vct_Fwd.frx":0EF5
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "Frm_Arb_Vct_Fwd"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Const C_Moneda = 0
Const C_Tipo = 1
Const C_Codigo = 2
Const C_Corresp = 3
Dim i   As Integer
Dim j   As Integer
Dim Sw  As Integer
Dim Sql As String
Dim Datos()
Function Func_Valida_Posicion(Fila As Integer, Col As Integer) As Boolean
 Func_Valida_Posicion = False
With Grilla

Select Case Col
    Case C_Moneda
        If (Trim(.TextMatrix(Fila - 1, C_Moneda)) = "" Or Trim(.TextMatrix(Fila - 1, C_Tipo)) = "" Or Trim(.TextMatrix(Fila - 1, C_Codigo)) = "") Then
            Exit Function
        End If
    Case C_Tipo
        If Trim(.TextMatrix(Fila, C_Moneda)) = "" Then
            Exit Function
        End If
    Case C_Codigo
        If Trim(.TextMatrix(Fila, C_Moneda)) = "" Or Trim(.TextMatrix(Fila, C_Tipo)) = "" Then
            Exit Function
        End If
End Select

End With
Func_Valida_Posicion = True
End Function
Sub Proc_Carga_Grilla()
    i = 1
    Envia = Array()
    If Bac_Sql_Execute("dbo.SP_LISTA_CORRESP_VCTO_ARB_FWD", Envia) Then
    
     Do While Bac_SQL_Fetch(Datos()) = True
     
        Grilla.TextMatrix(i, C_Moneda) = Datos(1)
        Grilla.TextMatrix(i, C_Tipo) = Datos(2)
        Grilla.TextMatrix(i, C_Codigo) = Datos(3)
        Grilla.TextMatrix(i, C_Corresp) = Datos(4)
        
             i = i + 1
        If i = Grilla.Rows Then Grilla.Rows = Grilla.Rows + 1
     Loop
     
    End If








End Sub

Private Sub Cmb_Tipo_KeyPress(KeyAscii As Integer)
With Grilla

Select Case KeyAscii
    Case 27:
             Cmb_Tipo.Visible = False
             .Enabled = True
             .SetFocus
    Case 13:
             .TextMatrix(.Row, C_Tipo) = Cmb_Tipo.Text
             Cmb_Tipo.Visible = False
             .Enabled = True
             .SetFocus
             SendKeys "{RIGHT}"
             
End Select

End With
End Sub

Private Sub Form_Load()

    Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                          , gsbac_fecp _
                          , gsBac_IP _
                          , gsBAC_User _
                          , "PCA" _
                          , "OPC_675" _
                          , "07" _
                          , "INGRESO A OPCION MENU" _
                          , "  " _
                          , " " _
                          , " ")

    Me.Icon = BACSwapParametros.Icon
    Call Proc_Limpiar
End Sub

Private Sub Form_Unload(Cancel As Integer)
    Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                          , gsbac_fecp _
                          , gsBac_IP _
                          , gsBAC_User _
                          , "PCA" _
                          , "OPC_675" _
                          , "07" _
                          , "INGRESO A OPCION MENU" _
                          , "  " _
                          , " " _
                          , " ")

End Sub

Private Sub Grilla_DblClick()
With Grilla

If Func_Valida_Posicion(.Row, .Col) = False Then Exit Sub


If .Col = C_Moneda Then
   BacAyuda.Tag = "MDMN"
   BacAyuda.Show 1
   
       If giAceptar% = True Then
          .TextMatrix(.Row, C_Moneda) = gsCodigo$
          SendKeys "{right}"
       End If
       
ElseIf .Col = C_Tipo Then

   Grilla.Enabled = False
   Cmb_Tipo.Top = Grilla.CellTop + Grilla.Top
   Cmb_Tipo.Left = Grilla.CellLeft + Grilla.Left
   Cmb_Tipo.Width = Grilla.CellWidth
   Cmb_Tipo.Visible = True
   Cmb_Tipo.ListIndex = 1
   Cmb_Tipo.SetFocus
   'SendKeys "{RIGHT}"

ElseIf .Col = C_Codigo Then
    If Trim(.TextMatrix(.Row, C_Moneda)) <> "" Then
        PARAMETRO1 = .TextMatrix(.Row, C_Moneda)
        BacAyuda.Tag = "Corresponsal"
        BacAyuda.Show 1
        
        If giAceptar% = True Then
           .TextMatrix(.Row, C_Codigo) = gsCodigo$
           .TextMatrix(.Row, C_Corresp) = gsNombre$
           SendKeys "{Home}"
           SendKeys "{down}"
        End If
    End If
End If


End With
End Sub

Private Sub Grilla_KeyDown(KeyCode As Integer, Shift As Integer)
Select Case KeyCode
    Case 45: 'MsgBox "Insert 45"
                Grilla.Rows = Grilla.Rows + 1
    Case 46: 'MsgBox "Supr 46"
                If (Grilla.Rows - 1) > 1 Then
                    Grilla.RemoveItem (Grilla.Row)
                End If
End Select

End Sub

Private Sub Grilla_KeyPress(KeyAscii As Integer)
With Grilla

If Func_Valida_Posicion(.Row, .Col) = False Then Exit Sub

If .Col = C_Moneda Then
    Grilla.Enabled = False
    Txt_codigo.Top = Grilla.CellTop + Grilla.Top
    Txt_codigo.Left = Grilla.CellLeft + Grilla.Left
    Txt_codigo.Width = Grilla.CellWidth
    Txt_codigo.Height = Grilla.CellHeight
    
    Txt_codigo.Text = 0
    
    If KeyAscii = 13 Then
        If Trim(.TextMatrix(.Row, C_Moneda)) <> "" Then
            Txt_codigo.Text = Trim(.TextMatrix(.Row, C_Moneda))
        End If
    ElseIf IsNumeric(Chr(KeyAscii)) = True Then
        Txt_codigo.Text = Val(Chr(KeyAscii))
    ElseIf IsNumeric(Chr(KeyAscii)) = False Then
        Grilla.Enabled = True
        Exit Sub
    End If
    
    Txt_codigo.Visible = True
    Txt_codigo.SetFocus
    SendKeys "{end}"
    
ElseIf .Col = C_Tipo Then
   Grilla.Enabled = False
   Cmb_Tipo.Top = Grilla.CellTop + Grilla.Top
   Cmb_Tipo.Left = Grilla.CellLeft + Grilla.Left
   Cmb_Tipo.Width = Grilla.CellWidth
   Cmb_Tipo.ListIndex = 1
   Cmb_Tipo.Visible = True
   Cmb_Tipo.SetFocus
   'SendKeys "{RIGHT}"

ElseIf .Col = C_Codigo Then
    Grilla.Enabled = False
    Txt_codigo.Top = Grilla.CellTop + Grilla.Top
    Txt_codigo.Left = Grilla.CellLeft + Grilla.Left
    Txt_codigo.Width = Grilla.CellWidth
    Txt_codigo.Height = Grilla.CellHeight
    
    Txt_codigo.Text = 0
    
    If KeyAscii = 13 Then
        If Trim(.TextMatrix(.Row, C_Codigo)) <> "" Then
            Txt_codigo.Text = Trim(.TextMatrix(.Row, C_Codigo))
        End If
    ElseIf IsNumeric(Chr(KeyAscii)) = True Then
        Txt_codigo.Text = Val(Chr(KeyAscii))
    ElseIf IsNumeric(Chr(KeyAscii)) = False Then
        Grilla.Enabled = True
        Exit Sub
    End If
    
    Txt_codigo.Visible = True
    Txt_codigo.SetFocus
    SendKeys "{end}"

End If

End With
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Index
Case 1: Call Proc_Limpiar
Case 2:
        If Func_Grabar() = True Then
            MsgBox "Información Grabada Correctamente", vbInformation
                         
                         Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                                    , gsbac_fecp _
                                    , gsBac_IP _
                                    , gsBAC_User _
                                    , "PCA" _
                                    , "OPC_675" _
                                    , "01" _
                                    , "Grabación de los Corresponsales según Monedas " _
                                    , "Corresponsales Vcto. Arbitraje FWD a SPT" _
                                    , " " _
                                    , " ")
                        
            Call Proc_Limpiar
        End If
Case 3: Unload Me
End Select
End Sub
Sub Proc_Limpiar()

Txt_codigo.Visible = False
Cmb_Tipo.Visible = False
Grilla.Enabled = True
Call Proc_Crea_Grilla
Call Proc_Carga_Grilla
End Sub
Sub Proc_Crea_Grilla()
With Grilla

.Clear
.Rows = 15
.Cols = 4
.TextMatrix(0, C_Moneda) = "Moneda"
.TextMatrix(0, C_Tipo) = "Tipo Operación"
.TextMatrix(0, C_Codigo) = "Codigo Corresponsal"
.TextMatrix(0, C_Corresp) = "Corresponsal"

.ColWidth(C_Moneda) = 930
.ColWidth(C_Tipo) = 1365
.ColWidth(C_Codigo) = 1605
.ColWidth(C_Corresp) = 4005

.RowHeight(0) = 500

.ColAlignment(0) = flexAlignCenterCenter
.ColAlignment(1) = flexAlignCenterCenter
.ColAlignment(2) = flexAlignCenterCenter
.ColAlignment(3) = flexAlignCenterCenter




End With
End Sub

Private Sub Txt_codigo_KeyPress(KeyAscii As Integer)
With Grilla
Select Case KeyAscii

Case 27:    Txt_codigo.Visible = False
            Grilla.Enabled = True
            .SetFocus
Case 13:
            If .Col = C_Moneda Then
                If FUNC_VALIDA_MONEDA(Txt_codigo.Text) = True Then
                    .TextMatrix(.Row, C_Moneda) = Txt_codigo.Text
                    Txt_codigo.Text = 0
                    Txt_codigo.Visible = False
                    Grilla.Enabled = True
                    .SetFocus
                    SendKeys "{right}"
                Else
                    Txt_codigo.SetFocus
                End If
            ElseIf .Col = C_Codigo Then
                If FUNC_VALIDA_CODIGO(.TextMatrix(.Row, C_Moneda), Txt_codigo.Text) = True Then
                    Txt_codigo.Text = 0
                    Txt_codigo.Visible = False
                    Grilla.Enabled = True
                    .SetFocus
                    
                    SendKeys "{Home}"
                    SendKeys "{down}"
                    
                Else
                    Txt_codigo.SetFocus
                    SendKeys "{end}"
                End If
                      
            End If
            
End Select
End With
End Sub

Function FUNC_VALIDA_MONEDA(Moneda As Long) As Boolean

FUNC_VALIDA_MONEDA = False
    
    Envia = Array()
    AddParam Envia, Moneda

    If Bac_Sql_Execute("SP_TRAE_MONEDA ", Envia) Then
    
     If Bac_SQL_Fetch(Datos()) = True Then
     
        If Trim(Datos(1)) = 0 Then
            MsgBox "Moneda no Existe ", vbCritical
            SendKeys "{end}"
            Exit Function
        End If
             
     End If
     
    End If
    
FUNC_VALIDA_MONEDA = True

End Function
Function FUNC_VALIDA_CODIGO(Moneda As Long, Codigo As Long, Optional Fila As Integer) As Boolean

FUNC_VALIDA_CODIGO = False
    
    Envia = Array()
    AddParam Envia, Moneda
    AddParam Envia, "P"
    AddParam Envia, Codigo
    If Bac_Sql_Execute("SP_MUESTRA_CORRESPONSALES ", Envia) Then
    
     If Bac_SQL_Fetch(Datos()) = True Then
     
     If Fila = 0 Then
        Grilla.TextMatrix(Grilla.Row, C_Codigo) = Datos(1)
        Grilla.TextMatrix(Grilla.Row, C_Corresp) = Datos(2)
     End If
     
     Else
        If Fila = 0 Then
           MsgBox "Codigo de Corresponsal no Existe o no Pertenece a la Moneda ingresada ", vbCritical
           
           Exit Function
        Else
           MsgBox "Codigo de Corresponsal no Existe o no Pertenece a la Moneda ingresada Fila : " & i, vbCritical
           Exit Function

        End If
    End If
     
    End If
    
FUNC_VALIDA_CODIGO = True

End Function
Function Func_Valida_Datos() As Boolean
Func_Valida_Datos = False
With Grilla

'Valida los Datos
For i = 1 To .Rows - 1
  If Trim(.TextMatrix(i, C_Moneda)) <> "" And Trim(.TextMatrix(i, C_Tipo)) <> "" And Trim(.TextMatrix(i, C_Codigo)) <> "" Then
    If Trim(.TextMatrix(i, C_Moneda)) = "" Or Trim(.TextMatrix(i, C_Tipo)) = "" Or Trim(.TextMatrix(i, C_Codigo)) = "" Then
      MsgBox "Datos Incorrectos en la Fila : " & i, vbCritical
       Exit Function
    End If
    
    If FUNC_VALIDA_CODIGO(Trim(.TextMatrix(i, C_Moneda)), Trim(.TextMatrix(i, C_Codigo)), i) = False Then
      Exit Function
    End If
  End If
  
Next i

'Valida Repetición Moneda / Tipo Op.

For i = 1 To .Rows - 1
    For j = i + 1 To .Rows - 1
          If Trim(.TextMatrix(i, C_Moneda)) <> "" And Trim(.TextMatrix(i, C_Tipo)) <> "" And Trim(.TextMatrix(i, C_Codigo)) <> "" Then
            If .TextMatrix(i, C_Moneda) = .TextMatrix(j, C_Moneda) And _
               .TextMatrix(i, C_Tipo) = .TextMatrix(j, C_Tipo) Then
                  MsgBox " Moneda y Tipo de Operación, se repite en la Fila : " & i & " y " & j, vbCritical
                  Exit Function
            End If
          End If
    Next j
Next i

End With
Func_Valida_Datos = True
End Function


Function Func_Grabar() As Boolean

On Error GoTo Error_vb
Func_Grabar = False
Sw = 0
    With Grilla
    
    If Func_Valida_Datos() = False Then Exit Function
    
    Envia = Array()
    
    If MsgBox("¿ Desea Grabar ?", vbInformation + vbYesNo) = vbNo Then Exit Function
    
        If Bac_Sql_Execute("Begin Tran", Envia) Then
            Sw = 1
        End If
    
    Envia = Array()
    If Bac_Sql_Execute("dbo.SP_ELIMINA_CORRESP_VCTO_ARB_FWD", Envia) Then
        If Bac_SQL_Fetch(Datos()) = True Then
             If Datos(1) <> "OK" Then
                GoTo Error_sql
             End If
        Else
             GoTo Error_sql
        End If
    Else
            GoTo Error_sql
    End If

For i = 1 To .Rows - 1
If Trim(.TextMatrix(i, C_Moneda)) <> "" Then

    Envia = Array()
    AddParam Envia, i
    AddParam Envia, .TextMatrix(i, C_Moneda)
    AddParam Envia, .TextMatrix(i, C_Tipo)
    AddParam Envia, .TextMatrix(i, C_Codigo)
     
    If Bac_Sql_Execute("SP_GRABA_CORRESP_VCTO_ARB_FWD", Envia) Then
        If Bac_SQL_Fetch(Datos()) = True Then
                If Datos(1) <> "OK" Then
                   GoTo Error_sql
                End If
        Else
           GoTo Error_sql
        End If
    Else
        GoTo Error_sql
    End If
End If
    
Next
    End With
Func_Grabar = True
    Envia = Array()
      If Bac_Sql_Execute("Commit Tran", Envia) Then
      End If
  

Exit Function

Error_vb:
    If Sw = 1 Then
        Envia = Array()
        If Bac_Sql_Execute("Rollback Tran", Envia) Then
        End If
        MsgBox "Error al Grabar los Corresponsales ", vbCritical
        Exit Function
    Else
        MsgBox "Error : " & Err.Description, vbCritical
        Exit Function
    End If
    
Error_sql:
        Envia = Array()
        If Bac_Sql_Execute("Rollback Tran", Envia) Then
        End If
        MsgBox "Error al Grabar los Corresponsales ", vbCritical
        Exit Function
End Function
