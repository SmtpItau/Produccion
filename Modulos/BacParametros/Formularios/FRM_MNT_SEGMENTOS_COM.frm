VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "comdlg32.ocx"
Begin VB.Form FRM_MNT_SEGMENTOS_COM 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantenedor para Segmentos Comerciales"
   ClientHeight    =   3930
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   12255
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   3930
   ScaleWidth      =   12255
   Begin VB.Frame Frame1 
      Height          =   3270
      Left            =   60
      TabIndex        =   1
      Top             =   585
      Width           =   12150
      Begin VB.ComboBox CmbMetRec 
         Height          =   315
         Left            =   2865
         Style           =   2  'Dropdown List
         TabIndex        =   4
         Top             =   2130
         Width           =   3120
      End
      Begin VB.TextBox TxtDatos 
         Height          =   330
         Left            =   2880
         MaxLength       =   40
         TabIndex        =   3
         Top             =   1665
         Width           =   3120
      End
      Begin MSFlexGridLib.MSFlexGrid Grd_datos 
         Height          =   2940
         Left            =   105
         TabIndex        =   2
         Top             =   180
         Width           =   11940
         _ExtentX        =   21061
         _ExtentY        =   5186
         _Version        =   393216
         Cols            =   6
         FixedCols       =   0
      End
   End
   Begin MSComctlLib.Toolbar Tbl_Opciones 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   12255
      _ExtentX        =   21616
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   5
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Grabar"
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   9
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Eliminar"
            Object.ToolTipText     =   "Eliminar"
            ImageIndex      =   11
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Buscar"
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Limpiar"
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   10
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   6
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComDlg.CommonDialog MiCommand 
         Left            =   2550
         Top             =   15
         _ExtentX        =   847
         _ExtentY        =   847
         _Version        =   393216
      End
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
               Picture         =   "FRM_MNT_SEGMENTOS_COM.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_SEGMENTOS_COM.frx":0EDA
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_SEGMENTOS_COM.frx":1DB4
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_SEGMENTOS_COM.frx":2C8E
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_SEGMENTOS_COM.frx":3B68
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_SEGMENTOS_COM.frx":4A42
               Key             =   ""
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_SEGMENTOS_COM.frx":4D5C
               Key             =   ""
            EndProperty
            BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_SEGMENTOS_COM.frx":5C36
               Key             =   ""
            EndProperty
            BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_SEGMENTOS_COM.frx":6B10
               Key             =   ""
            EndProperty
            BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_SEGMENTOS_COM.frx":6F62
               Key             =   ""
            EndProperty
            BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_SEGMENTOS_COM.frx":727C
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
End
Attribute VB_Name = "FRM_MNT_SEGMENTOS_COM"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Const Cons_CodProd = 0
Const Cons_Nemo = 1
Const Cons_Nom = 2
Const Cons_CodRec = 3
Const Cons_MetRec = 4
Const Cons_DescMet = 5
'PROD-10967
Dim MetRec As String
Dim DescMet As String
Dim CodRec As String



Private Sub Proc_Borrar()
Dim Datos()
With Grd_datos

    If .Rows = 1 Then
        MsgBox "No ha seleccionado registro para Grabar.", vbInformation, TITSISTEMA
        Exit Sub
    End If
    
    If MsgBox("¿ Esta seguro que desea Eliminar los valores.? Registro N°" & Trim(.TextMatrix(.Row, Cons_CodProd)), vbQuestion + vbYesNo, App.Title) = vbNo Then
        Exit Sub
    End If
   
    For nContador = 1 To .Rows - 1
         If Trim(.TextMatrix(nContador, Cons_CodProd)) = "" Or Trim(.TextMatrix(nContador, Cons_Nemo)) = "" _
         Or Trim(.TextMatrix(nContador, Cons_Nom)) = "" Or Trim(.TextMatrix(nContador, Cons_CodRec)) = "" _
         Or Trim(.TextMatrix(nContador, Cons_MetRec)) = "" Or Trim(.TextMatrix(nContador, Cons_DescMet)) = "" Then
                
              MsgBox "Registro incompleto, revisar para Borrar", vbInformation
              Exit Sub
         End If
    Next nContador
        
    
    Envia = Array()
    AddParam Envia, CDbl(2)
    AddParam Envia, CDbl(Trim(.TextMatrix(.Row, Cons_CodProd)))
                       
    If Not Bac_Sql_Execute("SP_DEL_SEGMENTOSCOMERCIALES", Envia) Then
      Let Screen.MousePointer = vbDefault
      Call MsgBox("Error en proceso." & vbCrLf & "No se ha podido iniciar la actualización de la Información.", vbExclamation, App.Title)
      Exit Sub
    End If
    
    Do While Bac_SQL_Fetch(Datos())
        If Trim(Datos(1)) = 15 Then
            MsgBox (Trim(Datos(2))), vbInformation
            Exit Sub
        End If
    Loop
    If .Rows > 2 Then
        .RemoveItem .Row
    Else
        .Clear
    End If
    
    TxtDatos.Visible = False
    CmbMetRec.Visible = False
End With
End Sub


Private Sub Proc_Buscar()
    Dim Datos()
    Dim nContador1 As Integer
    Dim nContador2 As Integer
  
    If Not Bac_Sql_Execute("SP_CON_SEGMENTOSCOMERCIALES") Then
       Call MsgBox("Problemas al Leer Nombres de Metodologia.", vbCritical, App.Title)
       Exit Sub
    End If
    With Grd_datos
            .Rows = 1
            Do While Bac_SQL_Fetch(Datos())
                    .Rows = .Rows + 1
                    .TextMatrix(.Rows - 1, Cons_CodProd) = Trim(Datos(1))
                    .TextMatrix(.Rows - 1, Cons_Nemo) = Trim(Datos(2))
                    .TextMatrix(.Rows - 1, Cons_Nom) = Trim(Datos(3))
                    .TextMatrix(.Rows - 1, Cons_CodRec) = Trim(Datos(4))
                    
                    
                    For nContador2 = 1 To .Rows - 1
     
                        .Row = nContador2
                        For nContador1 = 0 To CmbMetRec.ListCount - 1
                            If Trim(Mid(CmbMetRec.List(nContador1), 80, 40)) = .TextMatrix(nContador2, Cons_CodRec) Then
                            .TextMatrix(nContador2, Cons_MetRec) = Trim(Left(Me.CmbMetRec.List(nContador1), 20))
                             Exit For
                            End If
                        Next nContador1
                        
                        For nContador1 = 0 To CmbMetRec.ListCount - 1
                            If Trim(Mid(CmbMetRec.List(nContador1), 80, 40)) = .TextMatrix(nContador2, Cons_CodRec) Then
                            .TextMatrix(nContador2, Cons_DescMet) = Trim(Right(Me.CmbMetRec.List(nContador1), 80))
                             Exit For
                            End If
                        Next nContador1
                                                                        
                    Next nContador2
                    
            Loop
            If .Rows = 1 Then
            .AddItem ""
            End If
            If .Rows > 1 Then
                .AllowUserResizing = flexResizeColumns
            Else
                .AllowUserResizing = flexResizeNone
            End If
    End With
    Tbl_Opciones.Buttons("Grabar").Enabled = True
    Tbl_Opciones.Buttons("Eliminar").Enabled = True
    Grd_datos.Enabled = True
    TxtDatos.Visible = False
    CmbMetRec.Visible = False
    
End Sub

Private Sub Proc_Grabar()
Dim bRespuesta As Boolean
Dim nContador As Integer
Dim nContador1 As Integer
Dim nContador2 As Integer
Dim ErrorProc_Grabar As Integer
         
With Grd_datos

    BacBeginTransaction

    If .Rows = 1 Then
        MsgBox "No ha seleccionado registro para Grabar.", vbInformation, TITSISTEMA
        Call BacRollBackTransaction
        Exit Sub
    End If
    
   If MsgBox("¿ Esta seguro que desea actualizar los valores. ? ", vbQuestion + vbYesNo, App.Title) = vbNo Then
       Call BacRollBackTransaction
      Exit Sub
   End If
   
   For nContador = 1 To .Rows - 1
    
        If Trim(.TextMatrix(nContador, Cons_MetRec)) = "DEFAULT" Then
            MsgBox "Seleccione metodo Rec Distinto a DEFAULT", vbInformation
            
            .Col = Cons_MetRec
            .Row = nContador
            .CellBackColor = vbRed
            .SetFocus
            Call BacRollBackTransaction
            Exit Sub
        
        End If
    
    Next nContador
   
   For nContador = 1 To .Rows - 1
        If Trim(.TextMatrix(nContador, Cons_CodProd)) = "" Or Trim(.TextMatrix(nContador, Cons_Nemo)) = "" _
        Or Trim(.TextMatrix(nContador, Cons_Nom)) = "" Or Trim(.TextMatrix(nContador, Cons_CodRec)) = "" _
        Or Trim(.TextMatrix(nContador, Cons_MetRec)) = "" Or Trim(.TextMatrix(nContador, Cons_DescMet)) = "" Then
               
             MsgBox "Registro incompleto, revisar para grabar", vbInformation
             Call BacRollBackTransaction
             Exit Sub
        End If
    Next nContador
    
    For nContador1 = 1 To .Rows - 2
            For nContador2 = nContador1 + 1 To .Rows - 1
                                
                If Trim(.TextMatrix(nContador1, Cons_CodProd)) = Trim(.TextMatrix(nContador2, Cons_CodProd)) Then

                        Me.CmbMetRec.Visible = False
                        MsgBox "Existe un Registro duplicado", vbInformation
                        Call BacRollBackTransaction
                        Exit Sub
                End If
                    
            Next nContador2
    Next nContador1
       
    For nContador1 = 1 To .Rows - 1
        Envia = Array()
        AddParam Envia, CDbl(1)
        AddParam Envia, CDbl(Trim(.TextMatrix(nContador1, Cons_CodProd)))
          
        If Not Bac_Sql_Execute("SP_DEL_SEGMENTOSCOMERCIALES", Envia) Then
           Let Screen.MousePointer = vbDefault
           Call BacRollBackTransaction
           Call MsgBox("Error en proceso." & vbCrLf & "No se ha podido iniciar la actualización de la Información.", vbExclamation, App.Title)
           Exit Sub
        End If
    Next nContador1
  
         
    For nContador1 = 1 To .Rows - 1
       Envia = Array()
       AddParam Envia, CDbl(Trim(.TextMatrix(nContador1, Cons_CodProd)))
       AddParam Envia, (Trim(.TextMatrix(nContador1, Cons_Nemo)))
       AddParam Envia, (Trim(.TextMatrix(nContador1, Cons_Nom)))
       AddParam Envia, (Trim(.TextMatrix(nContador1, Cons_CodRec)))
       
       If Not Bac_Sql_Execute("SP_ACT_SEGMENTOSCOMERCIALES", Envia) Then
            Screen.MousePointer = vbDefault
            Call BacRollBackTransaction
            MsgBox "Ha ocurrido un error al intentar grabar la informacion", vbCritical
            Exit Sub
       End If
    Next nContador1
    
    'ON ERROR
    On Error Resume Next
        ErrorProc_Grabar = Err.Number
    On Error GoTo 0
    If ErrorProc_Grabar = 0 Then
        Call BacCommitTransaction
    Else
        Call BacRollBackTransaction
    End If
    Screen.MousePointer = vbDefault
    MsgBox "La informacion ha sido grabada con exito", vbInformation, TITSISTEMA
    Call Proc_NombresGrilla
    TxtDatos.Visible = False
    CmbMetRec.Visible = False
End With
Tbl_Opciones.Buttons("Grabar").Enabled = False
Tbl_Opciones.Buttons("Eliminar").Enabled = False
Grd_datos.Enabled = False
End Sub
Private Sub Proc_CargaCmbMetRec()
   Dim Datos()

   If Not Bac_Sql_Execute("SP_CONMETODOLOGIAREC") Then
      Exit Sub
   End If
   Call CmbMetRec.Clear
   Do While Bac_SQL_Fetch(Datos())
      
      Call CmbMetRec.AddItem(Trim(Datos(2)) & Space(80) & Datos(1) & Space(80) & Datos(3) & "")
   Loop
End Sub


Private Sub Proc_NombresGrilla()

  With Grd_datos
    
    .Rows = 2:         .FixedRows = 1
    .Cols = 6:         .FixedCols = 0

    .Font.Name = "Tahoma"
    .Font.Size = 8
    .RowHeightMin = 315
    .TextMatrix(0, Cons_CodProd) = "Cod.Prod."
    .TextMatrix(0, Cons_Nemo) = "Nemo"
    .TextMatrix(0, Cons_Nom) = "Nombre"
    .TextMatrix(0, Cons_CodRec) = "Cod.REC"
    .TextMatrix(0, Cons_MetRec) = "Metodo REC"
    .TextMatrix(0, Cons_DescMet) = "Descripción Metodologia"
         
    .ColWidth(Cons_CodProd) = 1000
    .ColWidth(Cons_Nemo) = 2000
    .ColWidth(Cons_Nom) = 3000
    .ColWidth(Cons_CodRec) = 0
    .ColWidth(Cons_MetRec) = 2000
    .ColWidth(Cons_DescMet) = 3000
    
    .Rows = 1
    .AddItem ""
  End With
End Sub

Private Sub CmbMetRec_KeyDown(KeyCode As Integer, Shift As Integer)
    
With Grd_datos
    Select Case KeyCode
        Case vbKeyReturn
        
           'PROD-10967                        
           Envia = Array()
           AddParam Envia, .TextMatrix(.Row, Cons_CodProd)  '''Trim(.TextMatrix(nContador1, Cons_CodProd)) '''Trim(Mid(Me.CmbMetRec.Text, 80, 40))
           
           If Not Bac_Sql_Execute("SP_SEG_FAMILIA_FM_SIN_METOD", Envia) Then
              Let Screen.MousePointer = vbDefault
              Call MsgBox("Error en proceso." & vbCrLf & "No se ha podido iniciar la actualización de la Información.", vbExclamation, App.Title)
              Exit Sub
           End If


          Do While Bac_SQL_Fetch(Datos())
             If Trim(Datos(1)) = 1 And (Me.CmbMetRec.ListIndex = 2 Or Me.CmbMetRec.ListIndex = 3 Or Me.CmbMetRec.ListIndex = 5) Then
              .TextMatrix(.Row, Cons_MetRec) = MetRec   'UCase(Trim(Left(Me.CmbMetRec.Text, 20)))
              .TextMatrix(.Row, Cons_DescMet) = DescMet 'UCase(Trim(Right(Me.CmbMetRec.Text, 80)))
              .TextMatrix(.Row, Cons_CodRec) = CodRec   'UCase(Trim(Mid(Me.CmbMetRec.Text, 80, 40)))
               CmbMetRec.Visible = False
               MsgBox "Segmento tiene relación con cliente FFMM sin metodología asignada" & vbCrLf & "No puede asignar metodología correspondiente a Derivados", vbInformation
               Exit Sub
             End If
          Loop
            .TextMatrix(.Row, Cons_MetRec) = UCase(Trim(Left(Me.CmbMetRec.Text, 20)))
            .TextMatrix(.Row, Cons_DescMet) = UCase(Trim(Right(Me.CmbMetRec.Text, 80)))
            .TextMatrix(.Row, Cons_CodRec) = UCase(Trim(Mid(Me.CmbMetRec.Text, 80, 40)))
            CmbMetRec.Visible = False
        Case vbKeyEscape
            CmbMetRec.Visible = False
            .Col = Cons_MetRec
            .SetFocus
    End Select
    
End With

End Sub

Private Sub CmbMetRec_LostFocus()
    CmbMetRec.Visible = False
End Sub

Private Sub Form_Load()
    Call Proc_NombresGrilla
    Call Proc_CargaCmbMetRec
    CmbMetRec.Visible = False
    TxtDatos.Visible = False
    Call Proc_Buscar
End Sub


Private Sub Grd_Datos_DblClick()
Dim nContador1 As Integer

    With Grd_datos
        If .Col <> Cons_MetRec And .Col <> Cons_CodRec And .Col <> Cons_DescMet Then

            If .Col = Cons_CodProd Then
                    TxtDatos.MaxLength = 6
            ElseIf .Col = Cons_Nemo Then
                    TxtDatos.MaxLength = 10
            ElseIf .Col = Cons_Nom Then
                    TxtDatos.MaxLength = 40
            End If
                  
            TxtDatos.Text = (Trim(.TextMatrix(.Row, .Col)))
            TxtDatos.Visible = True
            TxtDatos.Width = .ColWidth(.Col)
            TxtDatos.Left = .Left + .CellLeft
            TxtDatos.Top = .Top + .CellTop
            TxtDatos.SetFocus
            
            If KeyAscii > 47 And KeyAscii < 58 Then Text2.Text = Chr(KeyAscii)
            
            If TxtDatos.Visible = True Then
                Grd_datos.ScrollBars = flexScrollBarVertical = False
            Else
                Grd_datos.ScrollBars = flexScrollBarVertical = True
            End If
                  
        End If
        
        If .Col = Cons_MetRec Then
            If CmbMetRec.ListCount > 0 Then
                For nContador1 = 0 To CmbMetRec.ListCount - 1
                    If Trim(Right(CmbMetRec.List(nContador1), 10)) = Trim(.TextMatrix(.Row, Cons_MetRec)) Then
                        CmbMetRec.ListIndex = nContador1
                        Exit For
                    End If
                Next nContador1
                      
                CmbMetRec.Visible = True
                CmbMetRec.Width = .ColWidth(.Col)
                CmbMetRec.Left = .Left + .CellLeft
                CmbMetRec.Top = .Top + .CellTop
                CmbMetRec.SetFocus
            End If
        End If
        
              'PROD-10967
              MetRec = .TextMatrix(.Row, Cons_MetRec)
              DescMet = .TextMatrix(.Row, Cons_DescMet)
              CodRec = .TextMatrix(.Row, Cons_CodRec)
        
    End With
    
End Sub

Private Sub Grd_Datos_KeyDown(KeyCode As Integer, Shift As Integer)
     With Grd_datos
        Select Case KeyCode
            Case vbKeyInsert ''Inserta

                If CmbMetRec.Visible <> True Then
                 
                    CmbMetRec.Visible = False
                    If .TextMatrix(.Rows - 1, Cons_CodProd) <> "" And _
                       .TextMatrix(.Rows - 1, Cons_Nemo) <> "" And _
                       .TextMatrix(.Rows - 1, Cons_Nom) <> "" And _
                       .TextMatrix(.Rows - 1, Cons_CodRec) <> "" And _
                       .TextMatrix(.Rows - 1, Cons_MetRec) <> "" And _
                       .TextMatrix(.Rows - 1, Cons_DescMet) <> "" Then
                       .AddItem ""
                       
                       
                    Else
                        MsgBox "Debe Completar Valores para Insertar Registro.", vbInformation, App.Title
                        .SetFocus
                         Exit Sub
                    End If
                End If
            Case vbKeyDelete 'Elimina
            
                If .TextMatrix(.Rows - 1, Cons_CodProd) = "" And _
                       .TextMatrix(.Rows - 1, Cons_Nemo) = "" And _
                       .TextMatrix(.Rows - 1, Cons_Nom) = "" And _
                       .TextMatrix(.Rows - 1, Cons_CodRec) = "" And _
                       .TextMatrix(.Rows - 1, Cons_MetRec) = "" And _
                       .TextMatrix(.Rows - 1, Cons_DescMet) = "" Then
                       
                       .RemoveItem .Rows
                        Exit Sub
                End If
                
                If CmbMetRec.Visible <> True Then
                    If .Rows > 2 Then
                        Call Proc_Borrar
                        
                    Else
                        Call Proc_Borrar
                       .TextMatrix(.Rows - 1, Cons_CodProd) = ""
                       .TextMatrix(.Rows - 1, Cons_Nemo) = ""
                       .TextMatrix(.Rows - 1, Cons_Nom) = ""
                       .TextMatrix(.Rows - 1, Cons_CodRec) = ""
                       .TextMatrix(.Rows - 1, Cons_MetRec) = ""
                       .TextMatrix(.Rows - 1, Cons_DescMet) = ""
                    End If
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
        Case "Eliminar"
            
           Call Proc_Borrar
        Case "Limpiar"
            
            Grd_datos.Rows = 1
            Grd_datos.AddItem ""
            Tbl_Opciones.Buttons("Grabar").Enabled = False
            Tbl_Opciones.Buttons("Eliminar").Enabled = False
            Grd_datos.Enabled = False
            TxtDatos.Visible = False
            CmbMetRec.Visible = False
        Case "Salir"
            Unload Me
            Exit Sub
    End Select
End Sub

Private Sub TxtDatos_KeyDown(KeyCode As Integer, Shift As Integer)
    With Grd_datos
   
        Select Case KeyCode
            
            Case vbKeyReturn
              
                Select Case .Col
                
                    Case Cons_CodProd
                        .TextMatrix(.Row, Cons_CodProd) = Trim(TxtDatos.Text)
                        TxtDatos.Visible = False
                        .Col = Cons_CodProd
                        .SetFocus
                    Case Cons_Nemo
                        .TextMatrix(.Row, Cons_Nemo) = UCase(Trim(TxtDatos.Text))
                        TxtDatos.Visible = False
                        .Col = Cons_Nemo
                        .SetFocus
                    Case Cons_Nom
                        .TextMatrix(.Row, Cons_Nom) = UCase(Trim(TxtDatos.Text))
                        TxtDatos.Visible = False
                        Col = Cons_Nom
                        .SetFocus
                    Case Cons_DescMet
                        .TextMatrix(.Row, Cons_DescMet) = UCase(Trim(TxtDatos.Text))
                        TxtDatos.Visible = False
                        Col = Cons_DescMet
                        .SetFocus
                        
                          
                          
                End Select
                
            Case vbKeyEscape
                    CmbMetRec.Visible = False
                    TxtDatos.Visible = False
                    Grd_datos.SetFocus
        End Select

                 
    End With
End Sub


Private Sub TxtDatos_KeyPress(KeyAscii As Integer)

    With Grd_datos
           
        If .Col = Cons_CodProd Then
                       
            Cadena = "0123456789" + Chr(8)  'chr(8) = delete, es decir admitimos borrar
            If InStr(Cadena, Chr(KeyAscii)) = 0 Then
                KeyAscii = 0
            End If
        
        End If
         
    End With
End Sub


Private Sub TxtDatos_LostFocus()
    TxtDatos.Visible = False
End Sub

