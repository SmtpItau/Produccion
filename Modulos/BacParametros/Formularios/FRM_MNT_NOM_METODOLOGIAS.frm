VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "comdlg32.ocx"
Begin VB.Form FRM_MNT_NOM_METODOLOGIAS 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantenedor de Nombres de Metodologias"
   ClientHeight    =   3705
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   6525
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   3705
   ScaleWidth      =   6525
   Begin VB.Frame Frame1 
      Height          =   3135
      Left            =   30
      TabIndex        =   1
      Top             =   525
      Width           =   6450
      Begin VB.TextBox TxtDesMet 
         Height          =   300
         Left            =   1245
         MaxLength       =   30
         TabIndex        =   3
         Top             =   1275
         Width           =   3165
      End
      Begin MSFlexGridLib.MSFlexGrid Grd_datos 
         Height          =   2715
         Left            =   150
         TabIndex        =   2
         Top             =   180
         Width           =   6195
         _ExtentX        =   10927
         _ExtentY        =   4789
         _Version        =   393216
         Cols            =   3
         FixedCols       =   0
      End
   End
   Begin MSComctlLib.Toolbar Tbl_Opciones 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   6525
      _ExtentX        =   11509
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
            Key             =   "Grabar"
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   9
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Buscar"
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Limpiar"
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   10
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   6
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   4365
         Top             =   60
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   22
         ImageHeight     =   22
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   11
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_NOM_METODOLOGIAS.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_NOM_METODOLOGIAS.frx":0EDA
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_NOM_METODOLOGIAS.frx":1DB4
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_NOM_METODOLOGIAS.frx":2C8E
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_NOM_METODOLOGIAS.frx":3B68
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_NOM_METODOLOGIAS.frx":4A42
               Key             =   ""
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_NOM_METODOLOGIAS.frx":4D5C
               Key             =   ""
            EndProperty
            BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_NOM_METODOLOGIAS.frx":5C36
               Key             =   ""
            EndProperty
            BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_NOM_METODOLOGIAS.frx":6B10
               Key             =   ""
            EndProperty
            BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_NOM_METODOLOGIAS.frx":6F62
               Key             =   ""
            EndProperty
            BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_NOM_METODOLOGIAS.frx":727C
               Key             =   ""
            EndProperty
         EndProperty
      End
      Begin MSComDlg.CommonDialog MiCommand 
         Left            =   2550
         Top             =   15
         _ExtentX        =   847
         _ExtentY        =   847
         _Version        =   393216
      End
   End
End
Attribute VB_Name = "FRM_MNT_NOM_METODOLOGIAS"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Const Cons_CodMet = 0
Const Cons_Nemo = 1
Const Cons_DescMet = 2


Private Sub Proc_Grabar()
Dim bRespuesta As Boolean
Dim nContador As Integer
Dim nContador1 As Integer

         
With Grd_datos

    If .Rows = 1 Then
        MsgBox "No ha seleccionado registro para grabar.", vbInformation, TITSISTEMA
        Exit Sub
    End If
    
   If MsgBox("¿ Esta seguro que desea actualizar los valores. ? ", vbQuestion + vbYesNo, App.Title) = vbNo Then
      Exit Sub
   End If
   
   For nContador = 1 To .Rows - 1
        If Trim(.TextMatrix(nContador, Cons_CodMet)) = "" Or Trim(.TextMatrix(nContador, Cons_Nemo)) = "" _
        Or Trim(.TextMatrix(nContador, Cons_DescMet)) = "" Then
               
             MsgBox "Registro incompleto, revizar para grabar", vbInformation

             Exit Sub
        End If
    Next nContador
       
    For nContador1 = 1 To .Rows - 1
        Envia = Array()
        AddParam Envia, CDbl(Trim(.TextMatrix(nContador1, Cons_CodMet)))
          
        If Not Bac_Sql_Execute("SP_DELMETODOLOGIAREC", Envia) Then
           Let Screen.MousePointer = vbDefault
           Call MsgBox("Error en proceso." & vbCrLf & "No se ha podido iniciar la actualización de la Información.", vbExclamation, App.Title)
           Exit Sub
        End If
    Next nContador1
  
         
    For nContador1 = 1 To .Rows - 1
       Envia = Array()
       AddParam Envia, CDbl(Trim(.TextMatrix(nContador1, Cons_CodMet)))
       AddParam Envia, (Trim(.TextMatrix(nContador1, Cons_Nemo)))
       AddParam Envia, (Trim(.TextMatrix(nContador1, Cons_DescMet)))
       
       If Not Bac_Sql_Execute("SP_ACTMETODOLOGIAREC", Envia) Then
            Screen.MousePointer = vbDefault
            Call BacRollBackTransaction
            MsgBox "Ha ocurrido un error al intentar grabar la informacion", vbCritical
            Exit Sub
       End If
    Next nContador1
    
    bRespuesta = Bac_Sql_Execute("COMMIT TRAN")
    Screen.MousePointer = vbDefault
    MsgBox "La informacion ha sido grabada con exito", vbInformation, TITSISTEMA
    Call Proc_NombresGrilla
End With
Tbl_Opciones.Buttons("Grabar").Enabled = False
End Sub

Private Sub Proc_NombresGrilla()
    
  With Grd_datos
    
    .Rows = 2:         .FixedRows = 1
    .Cols = 3:         .FixedCols = 0

    .Font.Name = "Tahoma"
    .Font.Size = 8
    .RowHeightMin = 315
    .TextMatrix(0, Cons_CodMet) = "Cod.Met."
    .TextMatrix(0, Cons_Nemo) = "Nemo"
    .TextMatrix(0, Cons_DescMet) = "Descripción Metodología"
         
    .ColWidth(Cons_CodMet) = 1000
    .ColWidth(Cons_Nemo) = 2000
    .ColWidth(Cons_DescMet) = 3000
    
    .Rows = 1
    ''.AddItem ""
  End With
End Sub

Private Sub Proc_Buscar()
    Dim Datos()
    
    If Not Bac_Sql_Execute("SP_CONMETODOLOGIAREC") Then
       Call MsgBox("Problemas al Leer Nombres de Metodologia.", vbCritical, App.Title)
       Exit Sub
    End If
    With Grd_datos
            .Rows = 1
            Do While Bac_SQL_Fetch(Datos())
                    .Rows = .Rows + 1
                    .TextMatrix(.Rows - 1, Cons_CodMet) = Trim(Datos(1))
                    .TextMatrix(.Rows - 1, Cons_Nemo) = Trim(Datos(2))
                    .TextMatrix(.Rows - 1, Cons_DescMet) = Trim(Datos(3))
            Loop
            .Row = 0
            
            If .Rows > 1 Then
                .AllowUserResizing = flexResizeColumns
            Else
                .AllowUserResizing = flexResizeNone
            End If
    End With
    Tbl_Opciones.Buttons("Grabar").Enabled = True
    
End Sub

Private Sub Form_Load()
    TxtDesMet.Visible = False
    Call Proc_NombresGrilla
    Call Proc_Buscar
End Sub

Private Sub Grd_Datos_DblClick()
     If Grd_datos.Enabled = False Then Exit Sub
            
    With Grd_datos
       
        Select Case .Col
            
            Case Cons_DescMet
                 TxtDesMet.Text = Trim(.TextMatrix(.Row, Cons_DescMet))
                 TxtDesMet.Visible = True
                 TxtDesMet.Width = .ColWidth(.Col)
                 TxtDesMet.Left = .Left + .CellLeft
                 TxtDesMet.Top = .Top + .CellTop
                 TxtDesMet.SetFocus
                 
                If KeyAscii > 47 And KeyAscii < 58 Then Text2.Text = Chr(KeyAscii)
                
                If TxtDesMet.Visible = True Then
                    Grd_datos.ScrollBars = flexScrollBarVertical = False
                Else
                    Grd_datos.ScrollBars = flexScrollBarVertical = True
                End If
                      
        End Select
                 
    End With

End Sub


Private Sub Grd_datos_KeyPress(KeyAscii As Integer)
    If Not IsNumeric(Chr(KeyAscii)) And UCase(Chr(KeyAscii)) < "A" And UCase(Chr(KeyAscii)) > "Z" And KeyAscii <> 13 And KeyAscii <> 8 Then
        KeyAscii = 0
    End If
   
    If KeyAscii = 13 Then
        Call Grd_Datos_DblClick
    End If
End Sub


Private Sub Tbl_Opciones_ButtonClick(ByVal Button As MSComctlLib.Button)
     Select Case Button.Key
    
        Case "Grabar"
            Call Proc_Grabar
               
        Case "Buscar"
            
           Call Proc_Buscar
        Case "Limpiar"
            
            Grd_datos.Rows = 1
        Case "Salir"
            Unload Me
            Exit Sub
    End Select
End Sub


Private Sub TxtDesMet_KeyDown(KeyCode As Integer, Shift As Integer)
     Dim nContador As Integer
    Select Case KeyCode
        
        Case vbKeyReturn
            With Grd_datos
                            
                      .TextMatrix(.Row, Cons_DescMet) = Trim(TxtDesMet.Text)
                      TxtDesMet.Visible = False
                      .Col = Cons_DescMet
                      .SetFocus
                                                      
            End With
        Case vbKeyEscape
            TxtDesMet.Visible = False
            Grd_datos.SetFocus
    End Select
End Sub


Private Sub TxtDesMet_LostFocus()
    TxtDesMet.Visible = False
End Sub

