VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form Frm_Anula_Aprobacion 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Form2"
   ClientHeight    =   4320
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   11880
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   4320
   ScaleWidth      =   11880
   Begin VB.Frame frm_general 
      Height          =   3765
      Left            =   30
      TabIndex        =   0
      Top             =   510
      Width           =   11805
      Begin MSFlexGridLib.MSFlexGrid Grid1 
         Height          =   3495
         Left            =   60
         TabIndex        =   1
         Top             =   180
         Width           =   11670
         _ExtentX        =   20585
         _ExtentY        =   6165
         _Version        =   393216
         RowHeightMin    =   315
         BackColor       =   -2147483644
         BackColorBkg    =   -2147483636
         GridColorFixed  =   16777215
         Enabled         =   -1  'True
         FocusRect       =   0
         GridLines       =   2
         GridLinesFixed  =   0
         SelectionMode   =   1
      End
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   0
      Top             =   -60
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   7
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Frm_Anula_Aprobacion.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Frm_Anula_Aprobacion.frx":031A
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Frm_Anula_Aprobacion.frx":076C
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Frm_Anula_Aprobacion.frx":0BBE
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Frm_Anula_Aprobacion.frx":0D18
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Frm_Anula_Aprobacion.frx":116A
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Frm_Anula_Aprobacion.frx":1484
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   2
      Top             =   0
      Width           =   11880
      _ExtentX        =   20955
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Anular"
            Description     =   "Aprobar"
            Object.ToolTipText     =   "Anular"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Description     =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   6
         EndProperty
      EndProperty
      OLEDropMode     =   1
   End
End
Attribute VB_Name = "Frm_Anula_Aprobacion"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Form_Load()
Me.Icon = BacControlFinanciero.Icon
Me.Caption = "Anulacion de Aprobaciones"
Me.Top = 0
Me.Left = 0

Call Campos_Grid

Call Buscar_Datos

End Sub

Private Sub Campos_Grid()
   
   Titulos1 = Array("       ", "Numero   ", "Operador", "Operador", "Monto ", "Monto  ", "Rut    ", "Codigo ", "Nombre ", "Codigo  ", "Nombre  ", "Moneda   ")
   Titulos2 = Array("Sistema", "Operacion", "Origen  ", "Aprueba ", "Oper. ", "Aprueba", "Cliente", "Cliente", "Cliente", "Producto", "Producto", "Operacion")
     Anchos = Array("800", "1200", "1200", "1200", "1500", "1500", "1000", "0", "2500", "0", "2000", "0")
   
   Call PROC_CARGARGRILLA(Grid1, 400, 300, Anchos, Titulos1, , Titulos2)
   Grid1.Col = 0
   Grid1.Row = Grid1.FixedRows
   Grid1.Rows = Grid1.Rows - 1
   Grid1.Enabled = False
   'Toolbar1.Buttons(1).Enabled = False
End Sub



Private Function InsertarRow(Grid As MSFlexGrid)
    
    Grid1.Rows = Grid1.Rows + 1
    Grid1.Row = Grid1.Rows - 1
    Grid1.Col = 0
    
    Grid1.TextMatrix(Grid1.Row, 0) = ""
    Grid1.TextMatrix(Grid1.Row, 1) = 0
    Grid1.TextMatrix(Grid1.Row, 2) = 0
    Grid1.TextMatrix(Grid1.Row, 3) = 0
    Grid1.TextMatrix(Grid1.Row, 4) = 0
    Grid1.TextMatrix(Grid1.Row, 5) = 0
    Grid1.TextMatrix(Grid1.Row, 6) = 0
    Grid1.TextMatrix(Grid1.Row, 7) = 0
    Grid1.TextMatrix(Grid1.Row, 8) = 0
    Grid1.TextMatrix(Grid1.Row, 9) = 0
    Grid1.TextMatrix(Grid1.Row, 10) = 0
    Grid1.TextMatrix(Grid1.Row, 11) = 0
    
    
   
    SendKeys "{HOME}"

End Function

Private Sub Buscar_Datos()
    Dim I%
    Dim datos()
    
    Envia = Array(gsBAC_Fecp)
   
    If Not Bac_Sql_Execute("SP_CON_APROBACIONES", Envia) Then
       MsgBox "Error en SqlServer", vbCritical, TITSISTEMA
       Exit Sub
       
    End If
    
   
    Do While Bac_SQL_Fetch(datos())
        Grid1.Rows = Grid1.Rows + 1
        Grid1.Row = Grid1.Rows - 1
        Grid1.TextMatrix(Grid1.Row, 0) = datos(1)
        Grid1.TextMatrix(Grid1.Row, 1) = datos(2)
        Grid1.TextMatrix(Grid1.Row, 2) = datos(3)
        Grid1.TextMatrix(Grid1.Row, 3) = datos(4)
        Grid1.TextMatrix(Grid1.Row, 4) = Format(datos(6), Formato_Numero)
        Grid1.TextMatrix(Grid1.Row, 5) = Format(datos(7), Formato_Numero)
        Grid1.TextMatrix(Grid1.Row, 6) = datos(9)
        Grid1.TextMatrix(Grid1.Row, 7) = datos(10)
        Grid1.TextMatrix(Grid1.Row, 8) = datos(11)
        Grid1.TextMatrix(Grid1.Row, 9) = datos(8)
        Grid1.TextMatrix(Grid1.Row, 10) = datos(13)
        Grid1.TextMatrix(Grid1.Row, 11) = datos(12)
    Loop
    
    Grid1.Col = 0
    If Grid1.Row = 1 Then
        MsgBox ("No existen operaciones Aprobadas"), vbInformation + vbOKOnly, "CONTROL FINANCIERO"
        Exit Sub
    End If
    Grid1.Row = Grid1.FixedRows

    Grid1.Enabled = True

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Index
    Case 1
        If Grid1.Row = 1 Then Exit Sub
        If MsgBox("Esta seguro de eliminar operacion " + Str(CDbl(Grid1.TextMatrix(Grid1.Row, 1))), vbYesNo) = vbYes Then
            Call grabar_anulacion
        End If
    Case 2
        Unload Me

End Select
   
End Sub


Private Sub grabar_anulacion()
Dim I As Integer
On Error GoTo Errores
        Screen.MousePointer = 11
        
        Call BacBeginTransaction

        Envia = Array()
        AddParam Envia, Grid1.TextMatrix(Grid1.Row, 0)
        AddParam Envia, CDbl(Grid1.TextMatrix(Grid1.Row, 1))
        AddParam Envia, gsBAC_Fecp
        AddParam Envia, CDbl(Grid1.TextMatrix(Grid1.Row, 6))
        AddParam Envia, CDbl(Grid1.TextMatrix(Grid1.Row, 7))
        AddParam Envia, Grid1.TextMatrix(Grid1.Row, 9)
        AddParam Envia, Grid1.TextMatrix(Grid1.Row, 11)
        
        If Not Bac_Sql_Execute("SP_ANULA_APROBACION", Envia) Then
           MsgBox "No se puede grabar Anulacion", vbCritical, "CONTROL FINANCIERO"
           GoTo Errores
        End If
                
        Call BacCommitTransaction
        MsgBox "Grabacion terminado con Exito", vbOKOnly + vbInformation
        Screen.MousePointer = 0
        
        Call Campos_Grid
        Call Buscar_Datos
        
        Exit Sub
        
Errores:
       Call BacRollBackTransaction
        MsgBox "Grabacion con Problemas", vbCritical
        Exit Sub

End Sub
