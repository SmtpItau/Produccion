VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form BacMntInstSoma 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantenedor Instrumentos Soma"
   ClientHeight    =   3630
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   5145
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3630
   ScaleWidth      =   5145
   Begin VB.ComboBox CmbIntTipSoma 
      Height          =   315
      Left            =   1020
      Style           =   2  'Dropdown List
      TabIndex        =   4
      Top             =   1650
      Visible         =   0   'False
      Width           =   975
   End
   Begin VB.Frame Frame1 
      Height          =   675
      Left            =   60
      TabIndex        =   1
      Top             =   600
      Width           =   4995
      Begin VB.Label Label1 
         Caption         =   "Instrumento:"
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
         Height          =   315
         Left            =   120
         TabIndex        =   3
         Top             =   240
         Width           =   1155
      End
      Begin VB.Label LblEmisor 
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
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
         Height          =   315
         Left            =   1260
         TabIndex        =   2
         Top             =   240
         Width           =   3615
      End
   End
   Begin MSFlexGridLib.MSFlexGrid Grilla 
      Height          =   2115
      Left            =   75
      TabIndex        =   0
      Top             =   1380
      Width           =   4935
      _ExtentX        =   8705
      _ExtentY        =   3731
      _Version        =   393216
      BackColor       =   12632256
      BackColorFixed  =   8388608
      ForeColorFixed  =   16777215
      BackColorSel    =   16744576
      ForeColorSel    =   16777215
      FocusRect       =   0
      GridLines       =   2
      GridLinesFixed  =   0
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   5
      Top             =   0
      Width           =   5145
      _ExtentX        =   9075
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Grabar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Eliminar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   3600
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
               Picture         =   "BacMntInstSoma.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntInstSoma.frx":0EDA
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntInstSoma.frx":11F4
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
End
Attribute VB_Name = "BacMntInstSoma"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub CmbIntTipSoma_KeyDown(KeyCode As Integer, Shift As Integer)
     Select Case KeyCode
        
        Case vbKeyReturn
            With Grilla
                For nContador = 1 To .Rows - 1
                    If Trim(Right(CmbIntTipSoma.Text, 10)) = Trim(.TextMatrix(nContador, 1)) And nContador <> .Row Then
                        MsgBox "Codigo seleccionada ya existe", vbInformation
                        CmbIntTipSoma.Visible = False
                        Exit Sub
                    End If
                Next nContador
               End With
    End Select

End Sub


Private Sub CmbIntTipSoma_KeyPress(KeyAscii As Integer)
    
    Let KeyAscii = Asc(UCase(Chr(KeyAscii)))
   
    If KeyAscii = 27 Then
        CmbIntTipSoma.Visible = False
        If Grilla.Text <> "" And CmbIntTipSoma.Tag <> "" Then
            Grilla.Text = CmbIntTipSoma.Tag
        End If
        KeyAscii = 0
        Exit Sub
    End If
    
    If KeyAscii = 13 Then
        If CmbIntTipSoma.Tag <> CmbIntTipSoma.Text Then
            ' If Fnc_Valida_CodEmisor(CmbIntTipSoma.Text) Then
                Grilla.Text = CmbIntTipSoma.Text
                CmbIntTipSoma.Tag = CmbIntTipSoma.Text
                CmbIntTipSoma.SetFocus
                Toolbar1.Buttons(1).Enabled = True
                Toolbar1.Buttons(2).Enabled = True
            ' End If
        End If
            
        CmbIntTipSoma.Visible = False
        CmbIntTipSoma.Refresh
        Grilla.Refresh
        Grilla.SetFocus
    End If

End Sub

Private Sub Form_Load()

   Me.Height = 4125
   Me.Width = 5265

   Let Grilla.WordWrap = True

   Let Grilla.Rows = 2:      Let Grilla.Cols = 2
   Let Grilla.Row = 1:       Let Grilla.Col = 1
   Let Grilla.FixedRows = 1: Let Grilla.FixedCols = 1

   Let Grilla.TextMatrix(0, 0) = "":          Let Grilla.ColWidth(0) = 500:                              Let Grilla.TextMatrix(1, 0) = ""
   Let Grilla.TextMatrix(0, 1) = "Código":    Let Grilla.ColWidth(1) = 1200:            Let Grilla.TextMatrix(1, Col_NomEmisor) = ""
   
   Toolbar1.Buttons(1).Enabled = False
   Toolbar1.Buttons(2).Enabled = False
  
   Call CargaGrilla
   
   LblEmisor.Caption = BacMntFa.txtFamilia.Text
End Sub


Private Sub grilla_KeyDown(KeyCode As Integer, Shift As Integer)
    Dim Datos()
    
    If Grilla.ColSel <> 1 Then
        Exit Sub
    End If

    Let MousePointer = vbHourglass
    
    If KeyCode = vbKeyReturn Then
            If Grilla.Rows > 1 Then
                Call CargaCombo(CmbIntTipSoma)
                Call PROC_POSI_TEXTO(Grilla, CmbIntTipSoma)
                
                Let CmbIntTipSoma.Visible = True
                Me.CmbIntTipSoma.SetFocus
            End If
            'Let CmbIntTipSoma.Text = Grilla.TextMatrix(Grilla.RowSel, Grilla.ColSel)
            'Call CmbIntTipSoma.SetFocus

    End If
    
    If KeyCode = vbKeyInsert Then
        If Grilla.TextMatrix(Grilla.Row, 1) <> "" Then
            Grilla.Rows = Grilla.Rows + 1
            Grilla.Row = Grilla.Rows - 1
        End If
    End If
    
    If KeyCode = vbKeyDelete Then
         'Validar que no se encuentre enlazado con algun perfil.
         If Grilla.Rows > 2 Then
            Grilla.RemoveItem Grilla.RowSel
            Grilla.Row = Grilla.Rows - 1
         ElseIf Grilla.Rows = 2 Then
            Grilla.Rows = Grilla.Rows - 1
         End If
    End If
    
    Let Me.MousePointer = vbDefault
    
End Sub

Private Sub text1_Change()

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
      Select Case Button.Index
            Case 1
                  Call Grabar
            Case 2
                  Call grilla_KeyDown(46, 0)
            Case 3
                  Unload Me
            
      End Select
End Sub

Private Sub Grabar()
    Dim Datos()
    Dim I As Integer
    
    Call BacBeginTransaction
    
    Envia = Array()
    AddParam Envia, BacMntFa.txtCodFam.Text 'BacMntFa.txtSerie.Text
    AddParam Envia, ""
    AddParam Envia, 3
   
    sql = "BACParamSuda.dbo.SP_MANTENEDOR_INSTRUMENTOSSOMA "

    If Not Bac_Sql_Execute(sql, Envia) Then
       MsgBox "Ha ocurrido un Error al Validar Codigo de Emisor", vbInformation, App.Title
       Call BacRollBackTransaction
       Exit Sub
    End If

    For I = 1 To Grilla.Rows - 1
    
       If Trim(Grilla.TextMatrix(I, 1)) = "" Then
            MsgBox "Código se encuentra en blanco.", vbInformation, App.Title
            Call BacRollBackTransaction
            Exit Sub
       End If
       
       Envia = Array()
       AddParam Envia, BacMntFa.txtCodFam.Text 'BacMntFa.txtSerie.Text
       AddParam Envia, Grilla.TextMatrix(I, 1)
       AddParam Envia, 4
      
       sql = "BACParamSuda.dbo.SP_MANTENEDOR_INSTRUMENTOSSOMA "
   
       If Not Bac_Sql_Execute(sql, Envia) Then
            MsgBox "Ha ocurrido un Error al Guardar los datos", vbInformation, App.Title
            Call BacRollBackTransaction
            Exit Sub
       End If

    Next

    Call BacCommitTransaction
    MsgBox "Se han grabado exitosamente los datos."
    
End Sub


Public Function CargaGrilla() As Boolean

    Dim Datos()
    Dim nFilas As Integer
    
    CargaGrilla = False
    
    nFilas = 1
    Envia = Array()
    AddParam Envia, BacMntFa.txtCodFam.Text ' BacMntFa.txtSerie.Text
    AddParam Envia, 0
    AddParam Envia, 1
    
    sql = "BACParamSuda.dbo.SP_MANTENEDOR_INSTRUMENTOSSOMA "

    If Not Bac_Sql_Execute(sql, Envia) Then
      MsgBox "Ha ocurrido un error al leer tabla Instrumentos_soma", vbInformation, App.Title
      Exit Function
    End If
   
    Let Grilla.Rows = 1
    Let Grilla.Redraw = False
    Let nFilas = 1
    
    Do While Bac_SQL_Fetch(Datos())
         Let Grilla.Rows = Grilla.Rows + 1
         Let Grilla.TextMatrix(Grilla.Rows - 1, 1) = Datos(2)
         nFilas = nFilas + 1
         Toolbar1.Buttons(1).Enabled = True
         Toolbar1.Buttons(2).Enabled = True
    Loop
    
    Let Grilla.Redraw = True
    CargaGrilla = True
    
End Function

'Public Function Fnc_Valida_CodEmisor(CodEmisor As String) As Boolean
'
'    Dim Datos()
'
'    Let Fnc_Valida_CodEmisor = False
'
'    Envia = Array()
'    AddParam Envia, CLng(BacMntEm.txtRut)
'    AddParam Envia, CStr(CodEmisor)
'    AddParam Envia, 1
'
'    sql = "BACParamSuda.dbo.SP_MANTENEDOR_EMISORCODIGOS "
'
'    If Not Bac_Sql_Execute(sql, Envia) Then
'       MsgBox "Ha ocurrido un Error al Validar Codigo de Emisor", vbInformation, App.Title
'       Exit Function
'    End If
'
'    Do While Bac_SQL_Fetch(Datos())
'         If Datos(1) = -1 Then
'            MsgBox Datos(2), vbInformation, App.Title
'            Exit Function
'         End If
'    Loop
'
'
'    Let Fnc_Valida_CodEmisor = True
'
'End Function
'

Public Function CargaCombo(OBJCOMBO As Object) As Boolean
    Dim Datos()
    
    CargaCombo = False

    OBJCOMBO.Clear
    
    Envia = Array()
    AddParam Envia, 0
    AddParam Envia, ""
    AddParam Envia, 2
    sql = "BACParamSuda.dbo.SP_MANTENEDOR_INSTRUMENTOSSOMA "

    If Not Bac_Sql_Execute(sql, Envia) Then
      MsgBox "Ha ocurrido un error al leer Tabla de Instrimentos Soma", vbInformation, App.Title
      Exit Function
    End If
    
    Do While Bac_SQL_Fetch(Datos())
            OBJCOMBO.AddItem Trim(Datos(2))
            OBJCOMBO.ItemData(OBJCOMBO.NewIndex) = Val(Datos(1))
            CargaCombo = True
    Loop
    
    If Not CargaCombo Then
        OBJCOMBO.AddItem "< No hay Datos >"
    End If
    
    OBJCOMBO.Enabled = CargaCombo
    
End Function
