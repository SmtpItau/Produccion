VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form BacMntPe 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Mantenedor de Periodos"
   ClientHeight    =   4470
   ClientLeft      =   3990
   ClientTop       =   2610
   ClientWidth     =   5325
   Icon            =   "Bacmntpe.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4470
   ScaleWidth      =   5325
   ShowInTaskbar   =   0   'False
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   660
      Top             =   2415
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   2
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmntpe.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmntpe.frx":075C
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin Threed.SSFrame Frame 
      Height          =   3870
      Index           =   0
      Left            =   45
      TabIndex        =   0
      Top             =   540
      Width           =   5220
      _Version        =   65536
      _ExtentX        =   9208
      _ExtentY        =   6826
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
      Begin VB.TextBox txtIngreso 
         BackColor       =   &H00800000&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   330
         Left            =   1950
         TabIndex        =   6
         Top             =   2100
         Visible         =   0   'False
         Width           =   1125
      End
      Begin MSFlexGridLib.MSFlexGrid Table1 
         Height          =   3600
         Left            =   90
         TabIndex        =   5
         Top             =   165
         Width           =   5055
         _ExtentX        =   8916
         _ExtentY        =   6350
         _Version        =   393216
         Cols            =   6
         FixedCols       =   0
         BackColor       =   -2147483644
         ForeColor       =   12582912
         BackColorFixed  =   8421376
         ForeColorFixed  =   16777215
         BackColorBkg    =   -2147483645
         GridLines       =   2
         GridLinesFixed  =   0
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
   Begin Threed.SSFrame Frame 
      Height          =   2055
      Index           =   3
      Left            =   6285
      TabIndex        =   1
      Top             =   105
      Visible         =   0   'False
      Width           =   2715
      _Version        =   65536
      _ExtentX        =   4789
      _ExtentY        =   3625
      _StockProps     =   14
      ShadowStyle     =   1
      Begin VB.PictureBox Grid1 
         BackColor       =   &H00FFFFFF&
         Height          =   780
         Left            =   270
         ScaleHeight     =   720
         ScaleWidth      =   2100
         TabIndex        =   2
         Top             =   300
         Width           =   2160
      End
      Begin VB.Label Label 
         BackColor       =   &H00FFFFFF&
         Caption         =   "Label(1)"
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   1
         Left            =   255
         TabIndex        =   4
         Top             =   1590
         Width           =   1860
      End
      Begin VB.Label Label 
         BackColor       =   &H00800000&
         Caption         =   "Label(0)"
         ForeColor       =   &H00FFFFFF&
         Height          =   285
         Index           =   0
         Left            =   255
         TabIndex        =   3
         Top             =   1245
         Width           =   1860
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   7
      Top             =   0
      Width           =   5325
      _ExtentX        =   9393
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
            Key             =   "Grabar"
            Description     =   "Grabar"
            Object.ToolTipText     =   "Grabar Datos"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Description     =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
End
Attribute VB_Name = "BacMntPe"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit
Sub Dibuja_Grilla()

Table1.TextMatrix(0, 0) = ""
Table1.TextMatrix(0, 1) = "Codigo"
Table1.TextMatrix(0, 2) = "Periodo"
Table1.TextMatrix(0, 3) = "Numero"
Table1.TextMatrix(0, 4) = "Tipo"
Table1.TextMatrix(0, 5) = "Descripcion Periodo"

Table1.RowHeight(0) = 500

Table1.ColAlignment(0) = 0
Table1.ColAlignment(1) = 7
Table1.ColAlignment(2) = 1
Table1.ColAlignment(3) = 7
Table1.ColAlignment(4) = 4
Table1.ColAlignment(5) = 1

Table1.ColWidth(0) = 0
Table1.ColWidth(1) = 800
Table1.ColWidth(2) = 800
Table1.ColWidth(3) = 800
Table1.ColWidth(4) = 500
Table1.ColWidth(5) = 2000

End Sub

Function peGrabar() As Boolean

   Dim sql        As String
   Dim nLin       As Integer

   peGrabar = False

   

   If Not Bac_Sql_Execute("BEGIN TRANSACTION") Then
      Exit Function

   End If

   

   If Not Bac_Sql_Execute("SP_MDPEELIMINAR") Then
      GoTo ErrorGrabar:

   End If

   With Table1
   
      For nLin = 1 To .Rows - 1
         .Row = nLin
         .Col = 1
         If .Text <> "" Then
            Envia = Array()
         
            .Col = 1: AddParam Envia, CDbl(.Text)
            .Col = 2: AddParam Envia, .Text
            .Col = 3: AddParam Envia, CDbl(.Text)
            .Col = 4: AddParam Envia, .Text
            .Col = 5: AddParam Envia, .Text
   
           If Not Bac_Sql_Execute("SP_MDPEGRABAR ", Envia) Then
              GoTo ErrorGrabar:
           End If
                  
           Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                          , gsbac_fecp _
                          , gsBac_IP _
                          , gsBAC_User _
                          , "PCA" _
                          , "OPC_710" _
                          , "01" _
                          , "Grabar, Mantenedor de periodos" _
                          , "PERIODO_TASA_BIDASK" _
                          , " " _
                          , "Grabar, Mantenedor de periodos" & " " & Table1.TextMatrix(nLin, 5))
            
         End If
         
         
      Next nLin

   End With

   

   If Not Bac_Sql_Execute("COMMIT TRANSACTION") Then
      GoTo ErrorGrabar

   End If

   peGrabar = True

   Exit Function

ErrorGrabar:
   
   MsgBox "Problemas al grabar la tabla de periodos", vbCritical, TITSISTEMA
   

   If Not Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
   End If

End Function

Sub PeLeer()

   Dim sql        As String
   Dim Datos()


   

   If Not Bac_Sql_Execute("SP_MDPELEER ") Then
      MsgBox "Problemas al leer los periodos", vbCritical, TITSISTEMA

   End If

   With Table1

      .Rows = 1

      Do While Bac_SQL_Fetch(Datos())

         .Rows = .Rows + 1
         .Row = .Rows - 1

         .Col = 1: .Text = CDbl(Datos(1))
         .Col = 2: .Text = Datos(2)
         .Col = 3: .Text = Datos(3)
         .Col = 4: .Text = Datos(4)
         .Col = 5: .Text = Datos(5)

      Loop

   End With

End Sub

Private Sub cmdGrabar_Click()

   If peGrabar() Then
      MsgBox "Se grabaron los datos OK.", vbInformation, TITSISTEMA

   End If

End Sub

Private Sub cmdSalir_Click()

   Unload Me

End Sub


Private Sub Form_Load()
    Me.Top = 0
    Me.Left = 0
    
    Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                          , gsbac_fecp _
                          , gsBac_IP _
                          , gsBAC_User _
                          , "PCA" _
                          , "OPC_710" _
                          , "07" _
                          , "INGRESO A OPCION MENU" _
                          , "VALOR_MONEDA" _
                          , " " _
                          , " ")
    
   Dim nCol          As Integer

   Call BacSetMinBox(Me)
   
   Dibuja_Grilla

   Call PeLeer

End Sub
Private Sub Table1_Click()
    Call PintaCelda(Table1)
End Sub

Private Sub Table1_GotFocus()
    Call PintaCelda(Table1)
End Sub

Private Sub Table1_LeaveCell()
    Call CellPintaCelda(Table1)
End Sub

Private Sub Table1_SelChange()
    Call PintaCelda(Table1)
End Sub
Private Sub Table1_KeyDown(KeyCode As Integer, Shift As Integer)

   Dim bOk        As Boolean
   Dim nOk        As Integer
   Dim cPeriodo   As String
     

   Select Case KeyCode
   Case vbKeyInsert And Label(1).Caption <> "E"
      Table1.Rows = Table1.Rows + 1
      Table1.Row = Table1.Rows - 1

   Case vbKeyDelete And Table1.Row = (Table1.Rows - 1)

      'Validar que no se encuentre enlazado con algun perfil.
      If Table1.Rows > 2 Then
         Table1.RemoveItem Table1.Row
         Table1.Row = Table1.Rows - 1

      Else
         'Grid1.Rows = 1
         Table1.Rows = 2

      End If

   End Select

End Sub

Private Sub Table1_KeyPress(KeyAscii As Integer)

If Not IsNumeric(Chr(KeyAscii)) And Not (UCase(Chr(KeyAscii)) >= "A" And UCase(Chr(KeyAscii)) <= "Z") Then
   KeyAscii = 0
   Exit Sub
End If

Select Case Table1.Col

   Case 1, 3
   
      If Not IsNumeric(Chr(KeyAscii)) Then
          KeyAscii = 0
      End If
      
      txtIngreso.Text = ""
      
      PROC_POSICIONA_TEXTO Table1, txtIngreso
      
      txtIngreso.Text = Chr(KeyAscii)
      txtIngreso.Visible = True
      txtIngreso.SetFocus
      
      SendKeys "{END}"

   

   Case Else
   
      If UCase(Chr(KeyAscii)) >= "A" And UCase(Chr(KeyAscii)) <= "Z" And KeyAscii <> 13 And KeyAscii <> 8 Then
       KeyAscii = 0
      End If

      txtIngreso.Text = ""
      
      PROC_POSICIONA_TEXTO Table1, txtIngreso
      
      txtIngreso.Text = Chr(KeyAscii)
      txtIngreso.Visible = True
      txtIngreso.SetFocus
      
      SendKeys "{END}"
 

End Select

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Index
    Case 1      '"Grabar"
       If peGrabar() Then
          MsgBox "Se grabraron los datos OK.", vbInformation, TITSISTEMA
       End If
    Case 2      '"Salir"
        Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                          , gsbac_fecp _
                          , gsBac_IP _
                          , gsBAC_User _
                          , "PCA" _
                          , "OPC_710" _
                          , "01" _
                          , "SALIR DE OPCION MENU" _
                          , " " _
                          , " " _
                          , " ")
        Unload Me
    End Select
End Sub

Private Sub txtIngreso_KeyPress(KeyAscii As Integer)
If KeyAscii = 27 Then
    
    txtIngreso.Visible = False
    
    Table1.SetFocus
     
End If

If Table1.Col = 1 Or Table1.Col = 3 Then
 txtIngreso.MaxLength = 5
 KeyAscii = BacPunto(txtIngreso, KeyAscii, 5, 0)
ElseIf Table1.Col = 2 Then
  txtIngreso.MaxLength = 3
  KeyAscii = Asc(UCase(Chr(KeyAscii)))
ElseIf Table1.Col = 4 Then
  txtIngreso.MaxLength = 3
  KeyAscii = Asc(UCase(Chr(KeyAscii)))
ElseIf Table1.Col = 5 Then
  txtIngreso.MaxLength = 20
  KeyAscii = Asc(UCase(Chr(KeyAscii)))
End If

If KeyAscii = 13 Then

    If Trim(txtIngreso.Text) = "" Then Exit Sub
   
    Table1.Text = txtIngreso.Text
    
    txtIngreso.Visible = False
    
    Table1.SetFocus
    
End If

End Sub
