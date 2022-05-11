VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "Msflxgrd.ocx"
Begin VB.Form FRM_MNT_CONFIG_MENSAJES 
   Caption         =   "Configuracion de Mesajeria"
   ClientHeight    =   5745
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   7290
   LinkTopic       =   "Form2"
   MDIChild        =   -1  'True
   ScaleHeight     =   5745
   ScaleWidth      =   7290
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   7290
      _ExtentX        =   12859
      _ExtentY        =   794
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar / Actualizar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Cerrar"
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   4245
         Top             =   0
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
               Picture         =   "FRM_MNT_CONFIG_MENSAJES.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_CONFIG_MENSAJES.frx":0EDA
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_CONFIG_MENSAJES.frx":1DB4
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame Frame1 
      Height          =   5355
      Left            =   30
      TabIndex        =   1
      Top             =   375
      Width           =   7245
      Begin MSFlexGridLib.MSFlexGrid GRID 
         Height          =   5025
         Left            =   30
         TabIndex        =   2
         Top             =   120
         Width           =   7185
         _ExtentX        =   12674
         _ExtentY        =   8864
         _Version        =   393216
         FixedCols       =   0
         BackColor       =   -2147483633
         BackColorFixed  =   -2147483646
         ForeColorFixed  =   -2147483639
         BackColorBkg    =   -2147483636
         WordWrap        =   -1  'True
         FocusRect       =   0
         GridLines       =   2
         GridLinesFixed  =   0
         AllowUserResizing=   3
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
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
Attribute VB_Name = "FRM_MNT_CONFIG_MENSAJES"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim nFilas     As Long
Dim nColumnas  As Long

Private Function SETTING_GRID()
   Dim Datos()
   
   Let GRID.Rows = 2:                    Let GRID.Cols = 2
   Let GRID.FixedRows = 1:               Let GRID.FixedCols = 1
   Let GRID.TextMatrix(0, 0) = "Roles":  Let GRID.ColWidth(0) = 1500
   Let GRID.RowHeight(0) = 550

   Envia = Array()
   AddParam Envia, CDbl(0)
   If Not Bac_Sql_Execute("dbo.SP_CONFIGURACION_MENSAJE", Envia) Then
      Call MsgBox("Se ha generado un error en la carga de Roles.", vbExclamation, App.Title)
      Exit Function
   End If
   Let GRID.Rows = 1
   Do While Bac_SQL_Fetch(Datos())
      Let GRID.Rows = GRID.Rows + 1
      Let GRID.TextMatrix(GRID.Rows - 1, 0) = Datos(3) & Space(1000) & Datos(2)
   Loop
   
   Envia = Array()
   AddParam Envia, CDbl(1)
   If Not Bac_Sql_Execute("dbo.SP_CONFIGURACION_MENSAJE", Envia) Then
      Call MsgBox("Se ha generado un error en la carga de Roles.", vbExclamation, App.Title)
      Exit Function
   End If
   Let GRID.Cols = 1
   Do While Bac_SQL_Fetch(Datos())
      Let GRID.Cols = GRID.Cols + 1
      Let GRID.ColWidth(GRID.Cols - 1) = 970
      Let GRID.TextMatrix(0, GRID.Cols - 1) = Datos(3) & Space(1000) & Datos(2)
   Loop
   
   For nFilas = 1 To GRID.Rows - 1
      For nColumnas = 1 To GRID.Cols - 1
         Let GRID.TextMatrix(nFilas, nColumnas) = "NO"
         Let GRID.Row = nFilas
         Let GRID.Col = nColumnas
         Let GRID.CellAlignment = 3
      Next nColumnas
   Next nFilas
   
   Let GRID.Row = 1
   Let GRID.Col = 1
End Function

Private Sub Form_Load()
   Let Me.Top = 0:    Let Me.Left = 0
   Let Me.Icon = BACSwapParametros.Icon
   Let Me.Caption = "Configuración de mensajes por roles."
   
   Let GRID.Redraw = False
   
   Call SETTING_GRID
   Call LOAD_CANGE
   
   Let GRID.Redraw = True
End Sub

Private Sub Form_Resize()
   On Error Resume Next
   Frame1.Width = Me.Width - 150
   GRID.Width = Frame1.Width - 150
   
   Frame1.Height = Me.Height - 900
   GRID.Height = Frame1.Height - 450
   On Error GoTo 0
End Sub

Private Function LOAD_CANGE()
   Dim Datos()
   Dim nRol    As Long
   Dim nEvento As Long
   Dim nEstado As Integer

   For nFilas = 1 To GRID.Rows - 1
      
      Let nRol = Val(Trim(Right(GRID.TextMatrix(nFilas, 0), 20)))
      
      For nColumnas = 1 To GRID.Cols - 1

         Let nEvento = Val(Trim(Right(GRID.TextMatrix(0, nColumnas), 20)))
         
         Envia = Array()
         AddParam Envia, CDbl(4)
         AddParam Envia, nRol
         AddParam Envia, nEvento
         If Not Bac_Sql_Execute("dbo.SP_CONFIGURACION_MENSAJE", Envia) Then
            Exit Function
         End If
         If Bac_SQL_Fetch(Datos()) Then
            Let GRID.TextMatrix(nFilas, nColumnas) = Datos(1)
         End If
         
      Next nColumnas
   Next nFilas

End Function

Private Function SAVE_CHANGE()
   Dim Datos()
   Dim nRol    As Long
   Dim nEvento As Long
   Dim nEstado As Integer
   
   Let Screen.MousePointer = vbHourglass
   
   If Not BacBeginTransaction Then
      Let Screen.MousePointer = vbDefault
      Call MsgBox("Se ha generado un error en la apertura de la transacción.", vbExclamation, App.Title)
      Exit Function
   End If
   
   
   Let GRID.Redraw = False

   For nFilas = 1 To GRID.Rows - 1
      
      Let nRol = Val(Trim(Right(GRID.TextMatrix(nFilas, 0), 20)))
      
      For nColumnas = 1 To GRID.Cols - 1

         Let nEvento = Val(Trim(Right(GRID.TextMatrix(0, nColumnas), 20)))
         Let nEstado = IIf(GRID.TextMatrix(nFilas, nColumnas) = "SI", 1, 0)
         
         Envia = Array()
         AddParam Envia, CDbl(3)
         AddParam Envia, nRol
         AddParam Envia, nEvento
         AddParam Envia, nEstado
         If Not Bac_Sql_Execute("dbo.SP_CONFIGURACION_MENSAJE", Envia) Then
            GoTo Error
         End If
         
      Next nColumnas
   Next nFilas
   
   If Not BacCommitTransaction Then
      Let Screen.MousePointer = vbDefault
      Call MsgBox("Se ha generado un error en la confirmación de la transacción.", vbExclamation, App.Title)
      Exit Function
   End If

   Let Screen.MousePointer = vbDefault
   Let GRID.Redraw = False
  
   Call MsgBox("se ha completado la actualización de los datos.", vbInformation, App.Title)
   
Exit Function
Error:

   If Not BacRollBackTransaction Then
      Let Screen.MousePointer = vbDefault
      Call MsgBox("Se ha generado un error en la cancelación de la transacción.", vbExclamation, App.Title)
      Exit Function
   End If
   Let GRID.Redraw = False
   
   Let Screen.MousePointer = vbDefault
   Call MsgBox("Ha ocurrido un error en la actualización de los datos.", vbExclamation, App.Title)
   
End Function

Private Sub GRID_DblClick()
   If GRID.TextMatrix(GRID.RowSel, GRID.ColSel) = "NO" Then
      Let GRID.TextMatrix(GRID.RowSel, GRID.ColSel) = "SI"
   Else
      Let GRID.TextMatrix(GRID.RowSel, GRID.ColSel) = "NO"
   End If
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 2
         Let GRID.Redraw = False
         Call SETTING_GRID
         Call LOAD_CANGE
         Let GRID.Redraw = True
      Case 3

         Call SAVE_CHANGE
         
         Let GRID.Redraw = False
         Call SETTING_GRID
         Call LOAD_CANGE
         Let GRID.Redraw = True
         
      Case 4
         Call Unload(Me)
   End Select
End Sub
