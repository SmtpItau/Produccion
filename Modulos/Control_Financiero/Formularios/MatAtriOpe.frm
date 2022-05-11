VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form MatAtriOpe 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Matriz Atribución por Operador"
   ClientHeight    =   4695
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   11415
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   4695
   ScaleWidth      =   11415
   ShowInTaskbar   =   0   'False
   Begin VB.Frame Frame1 
      Height          =   735
      Left            =   0
      TabIndex        =   1
      Top             =   480
      Width           =   11370
      Begin VB.ComboBox Cmb_Usuarios 
         ForeColor       =   &H80000002&
         Height          =   315
         Left            =   1845
         Style           =   2  'Dropdown List
         TabIndex        =   2
         Top             =   240
         Width           =   3015
      End
      Begin VB.Label Lbl_Usuario 
         Caption         =   "Operador"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000002&
         Height          =   240
         Left            =   240
         TabIndex        =   3
         Top             =   285
         Width           =   1215
      End
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   4560
      Top             =   0
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   24
      ImageHeight     =   24
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   3
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "MatAtriOpe.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "MatAtriOpe.frx":0EDA
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "MatAtriOpe.frx":132E
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   480
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   11415
      _ExtentX        =   20135
      _ExtentY        =   847
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   1
            BeginProperty ButtonMenus {66833FEC-8583-11D1-B16A-00C0F0283628} 
               NumButtonMenus  =   1
               BeginProperty ButtonMenu1 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
            EndProperty
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Generar Archivo"
            ImageIndex      =   2
            BeginProperty ButtonMenus {66833FEC-8583-11D1-B16A-00C0F0283628} 
               NumButtonMenus  =   8
               BeginProperty ButtonMenu1 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
               BeginProperty ButtonMenu2 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
               BeginProperty ButtonMenu3 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
               BeginProperty ButtonMenu4 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
               BeginProperty ButtonMenu5 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
               BeginProperty ButtonMenu6 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
               BeginProperty ButtonMenu7 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
               BeginProperty ButtonMenu8 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
            EndProperty
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
      MouseIcon       =   "MatAtriOpe.frx":1648
      OLEDropMode     =   1
   End
   Begin MSFlexGridLib.MSFlexGrid Grilla 
      Height          =   3330
      Left            =   0
      TabIndex        =   4
      TabStop         =   0   'False
      Top             =   1320
      Width           =   11370
      _ExtentX        =   20055
      _ExtentY        =   5874
      _Version        =   393216
      BackColor       =   -2147483644
      ForeColor       =   8388608
      BackColorFixed  =   8421376
      ForeColorFixed  =   16777215
      BackColorSel    =   8388608
      ForeColorSel    =   16777215
      GridColor       =   16777215
      ScrollTrack     =   -1  'True
      FocusRect       =   0
      HighLight       =   2
      GridLines       =   2
      GridLinesFixed  =   0
      SelectionMode   =   1
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
End
Attribute VB_Name = "MatAtriOpe"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub Cmb_Usuarios_GotFocus()

   ''' Cmb_Usuarios.AddItem " << TODOS >> " + Space(70) + "CODIGO" + Space(5) + ""
    Cmb_Usuarios.Tag = Cmb_Usuarios.ListIndex
End Sub

Private Sub Dir1_Change()

End Sub

Private Sub Form_Load()
    Call carga_combo
    Call dibuja_grilla
    Call carga_grilla
End Sub

Private Sub carga_combo()

Dim datos()
     If Not Bac_Sql_Execute("SP_BACMATRIZATRIBUCIONES_LEEGENUSUARIO") Then
        Exit Sub
    End If
    Cmb_Usuarios.AddItem " << TODOS >> " + Space(70) + "CODIGO" + Space(5) + ""
    Do While Bac_SQL_Fetch(datos())
       If datos(3) = "TRADER" Or datos(3) = "SUPERVISOR" Then
        Cmb_Usuarios.AddItem (datos(1) & Space(100) & datos(2))
       End If
    Loop

End Sub

Private Sub dibuja_grilla()

        With Grilla
    
        .Rows = 3
        .Cols = 7
        .FixedCols = 0
        .FixedRows = 2
        
        .TextMatrix(0, 0) = "Nombre"
        .TextMatrix(1, 0) = "Operador"
        
        .TextMatrix(0, 1) = "Tipo"
        .TextMatrix(1, 1) = "Operación"
        
        .TextMatrix(0, 2) = "Mto.Total Asig"
        .TextMatrix(1, 2) = "Operación"
        
        .TextMatrix(0, 3) = "Monto Maximo"
        .TextMatrix(1, 3) = "Diario"
        
        .TextMatrix(0, 4) = "Monto Diario"
        .TextMatrix(1, 4) = "Acumulado"
        
        .TextMatrix(0, 5) = "Saldo Diario"
        .TextMatrix(1, 5) = "Disponible"
        
        .TextMatrix(0, 6) = "Operador"
        .TextMatrix(1, 6) = ""
      
        .ColWidth(0) = 3000
        .ColWidth(1) = 2000
        .ColWidth(2) = 1500
        .ColWidth(3) = 1500
        .ColWidth(4) = 1500
        .ColWidth(5) = 1500
        .ColWidth(6) = 0
        
        .RowHeightMin = 370
        .Rows = .FixedRows
        .Enabled = False
        Call Formato_Grilla(Grilla)
       .FocusRect = flexFocusLight

    End With
    


End Sub

Private Sub carga_grilla()


On Error Resume Next
   Dim datos()
   Dim PosicionActual As Long
   Dim Indice        As Long
   
   
      Call dibuja_grilla
      
      
      
      Envia = Array()
      
      If Mid(Trim(Cmb_Usuarios), 1, 11) = "<< TODOS >>" Then
        AddParam Envia, " "
      Else
        AddParam Envia, Trim(Mid(Cmb_Usuarios, InStr(1, Cmb_Usuarios, "CODIGO") + 1, 70))   ''Len("CODIGO")
      End If

      If Not Bac_Sql_Execute("SP_MATRIZ_ATRIBUCIONES_OPERADOR", Envia) Then
          MsgBox "Problemas en la Consulta", vbExclamation, TITSISTEMA
          Exit Sub
      End If
    
     With Grilla
     
            .Redraw = False
            .Rows = .FixedRows

        Do While Bac_SQL_Fetch(datos())
            .Rows = .Rows + 1
      
            
           .TextMatrix(.Rows - 1, 0) = datos(2)                         'Identificacion sistema
           .TextMatrix(.Rows - 1, 1) = datos(5)                         'Producto
           .TextMatrix(.Rows - 1, 2) = Format(datos(6), FEntero)                         ''Format(datos(4), FEntero)         'Numoper
           .TextMatrix(.Rows - 1, 3) = Format(datos(7), FEntero)                         'Monto total
           .TextMatrix(.Rows - 1, 4) = Format(datos(8), FEntero)                         'Monto Acum
           .TextMatrix(.Rows - 1, 5) = Format(datos(9), FEntero)                         'Saldo
           .TextMatrix(.Rows - 1, 6) = datos(1)                         'Operador

         
      Loop
      
        
            .Redraw = True
            .Row = .FixedRows
            .Col = 1
            .Enabled = True
            .FocusRect = flexFocusNone
            
            Sw_Sel = 0
            Grilla.Col = 0
      
    End With
    
    
End Sub

Private Sub Grilla_Click()
        Sw_Sel = 1
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
     Select Case Button.Index

            Case 1
            
                    Call carga_grilla
                    
            Case 2
                    BacInterfaz.Show
                    'Call Genera_Archivo
                 
            Case 3
            
                   Unload Me
    
     End Select

End Sub



