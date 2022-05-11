VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form BacMntFeriados 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantencion de Feriados"
   ClientHeight    =   5985
   ClientLeft      =   45
   ClientTop       =   375
   ClientWidth     =   14880
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5985
   ScaleWidth      =   14880
   Begin VB.ComboBox cboEstado 
      BackColor       =   &H00800000&
      ForeColor       =   &H00FFFFFF&
      Height          =   315
      Left            =   7320
      Style           =   2  'Dropdown List
      TabIndex        =   14
      Top             =   3480
      Width           =   1095
   End
   Begin VB.ComboBox cboReglas 
      BackColor       =   &H00800000&
      ForeColor       =   &H00FFFFFF&
      Height          =   315
      Left            =   7200
      Style           =   2  'Dropdown List
      TabIndex        =   13
      Top             =   2760
      Width           =   1095
   End
   Begin VB.TextBox txtCodPais2 
      Height          =   375
      Left            =   3240
      TabIndex        =   11
      Top             =   3720
      Visible         =   0   'False
      Width           =   1335
   End
   Begin VB.ComboBox cboMes 
      BackColor       =   &H00800000&
      CausesValidation=   0   'False
      ForeColor       =   &H00FFFFFF&
      Height          =   315
      Left            =   5880
      Style           =   2  'Dropdown List
      TabIndex        =   10
      Top             =   2760
      Width           =   1095
   End
   Begin VB.ComboBox cboDia 
      BackColor       =   &H00800000&
      ForeColor       =   &H00FFFFFF&
      Height          =   315
      Left            =   4680
      Style           =   2  'Dropdown List
      TabIndex        =   9
      Top             =   2760
      Width           =   1095
   End
   Begin VB.TextBox txtComentario 
      BackColor       =   &H00800000&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   300
      Left            =   3600
      MaxLength       =   40
      MultiLine       =   -1  'True
      TabIndex        =   8
      Text            =   "BacMntFeriados.frx":0000
      Top             =   2760
      Width           =   960
   End
   Begin VB.TextBox txtDescripcion 
      BackColor       =   &H00800000&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   300
      Left            =   2640
      MaxLength       =   40
      MultiLine       =   -1  'True
      TabIndex        =   7
      Text            =   "BacMntFeriados.frx":0006
      Top             =   2760
      Width           =   960
   End
   Begin VB.TextBox txtNemo 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00800000&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   300
      Left            =   1680
      MaxLength       =   9
      MultiLine       =   -1  'True
      TabIndex        =   6
      Text            =   "BacMntFeriados.frx":000C
      Top             =   2760
      Width           =   960
   End
   Begin Threed.SSFrame SSFrame2 
      Height          =   555
      Left            =   0
      TabIndex        =   0
      Top             =   480
      Width           =   14805
      _Version        =   65536
      _ExtentX        =   26114
      _ExtentY        =   979
      _StockProps     =   14
      ForeColor       =   12632256
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ShadowStyle     =   1
      Begin VB.TextBox txtNomPais 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   4800
         MaxLength       =   200
         MouseIcon       =   "BacMntFeriados.frx":0012
         MousePointer    =   99  'Custom
         TabIndex        =   2
         Top             =   120
         Width           =   5835
      End
      Begin VB.TextBox txtCodPais 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   1440
         MaxLength       =   6
         MouseIcon       =   "BacMntFeriados.frx":031C
         MousePointer    =   99  'Custom
         TabIndex        =   1
         Top             =   120
         Width           =   915
      End
      Begin VB.Label Label1 
         Caption         =   "Nombre País"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   3600
         TabIndex        =   4
         Top             =   210
         Width           =   1095
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Código País"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   195
         Index           =   0
         Left            =   345
         TabIndex        =   3
         Top             =   210
         Width           =   1035
      End
   End
   Begin MSFlexGridLib.MSFlexGrid grilla 
      Height          =   4770
      Left            =   0
      TabIndex        =   5
      Top             =   1080
      Width           =   14820
      _ExtentX        =   26141
      _ExtentY        =   8414
      _Version        =   393216
      FixedCols       =   0
      RowHeightMin    =   315
      BackColor       =   -2147483644
      ForeColor       =   8388608
      BackColorFixed  =   8421376
      ForeColorFixed  =   16777215
      BackColorSel    =   8388608
      ForeColorSel    =   16777215
      BackColorBkg    =   -2147483645
      GridColor       =   16777215
      GridColorFixed  =   16777215
      WordWrap        =   -1  'True
      FocusRect       =   0
      GridLines       =   2
      GridLinesFixed  =   0
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   4860
      Top             =   0
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   4
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMntFeriados.frx":0626
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMntFeriados.frx":0A78
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMntFeriados.frx":0ECA
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMntFeriados.frx":11E4
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   12
      Top             =   0
      Width           =   14880
      _ExtentX        =   26247
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.Visible         =   0   'False
            Object.ToolTipText     =   "Eliminar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   4
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
End
Attribute VB_Name = "BacMntFeriados"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim i As Integer


Private Function Grabar()
On Error GoTo ErrorGrabarRegistros

    For i = 1 To grilla.Rows - 1
    Envia = Array()

        If grilla.TextMatrix(i, 6) = "Nuevo" And (grilla.TextMatrix(i, 0) <> "" Or grilla.Rows = 2) Then
            AddParam Envia, 1000
            If txtCodPais2 = "" Then
                AddParam Envia, txtCodPais
            Else
            AddParam Envia, txtCodPais2
            End If
            AddParam Envia, grilla.TextMatrix(i, 0)
            AddParam Envia, grilla.TextMatrix(i, 1)
            AddParam Envia, grilla.TextMatrix(i, 2)
            AddParam Envia, grilla.TextMatrix(i, 3)
            AddParam Envia, grilla.TextMatrix(i, 4)
                AddParam Envia, grilla.TextMatrix(i, 9)
            AddParam Envia, grilla.TextMatrix(i, 8)
            AddParam Envia, 1
            
            If Not Bac_Sql_Execute("SP_GRABA_FERIADOS", Envia) Then
                Exit Function
            End If
        End If
        
        If grilla.TextMatrix(i, 6) = "Cambio" Then
            AddParam Envia, grilla.TextMatrix(i, 5)
            If txtCodPais2 = "" Then
                AddParam Envia, txtCodPais
            Else
            AddParam Envia, txtCodPais2
            End If
            AddParam Envia, grilla.TextMatrix(i, 0)
            AddParam Envia, grilla.TextMatrix(i, 1)
            AddParam Envia, grilla.TextMatrix(i, 2)
            AddParam Envia, grilla.TextMatrix(i, 3)
            AddParam Envia, grilla.TextMatrix(i, 4)
                AddParam Envia, grilla.TextMatrix(i, 9)
            AddParam Envia, grilla.TextMatrix(i, 8)
            AddParam Envia, 2
            
            If Not Bac_Sql_Execute("SP_GRABA_FERIADOS", Envia) Then
                Exit Function
            End If
        End If
    Next
    
Call MsgBox("Se ha realizado grabado con exito.", vbInformation, App.Title)
Exit Function
ErrorGrabarRegistros:
    Call MsgBox("Se ha generado un error durante la grabación.", vbExclamation, App.Title)
End Function

Public Function LlenaCeros(CadenaX As String, CerosX As Integer, AlineacionX As Integer)
Dim A As Integer

    'Funcion: LlenaCeros ("Texto",NumeroDeCeros, Alineacion)
    'Descripcion: Funcion que formatea una CadenaX agregandole ceros hasta EspaciosX
    '             si los CerosX menor que el Largo de CadenaX, este corta la CadenaX en el
    '             largo de CerosX
    'Opciones Alineacion:
    ' 1 = Izquierda
    ' 2 = Derecha

    Dim Paso    As Integer

    Dim PasoStr As String

    CadenaX = Trim(CadenaX)
    PasoStr = CadenaX

    If Len(CadenaX) < CerosX Then
        Paso = CerosX - Len(PasoStr)

        If AlineacionX = 2 Then

            For A = 1 To Paso
                PasoStr = "0" & PasoStr
            Next A

        Else

            For A = 1 To Paso
                PasoStr = PasoStr & "0"
            Next A

        End If

    Else
        PasoStr = Mid(PasoStr, 1, CerosX)
    End If

    LlenaCeros = PasoStr
End Function

Private Sub cboDia_KeyDown(KeyCode As Integer, Shift As Integer)
   
    If grilla.TextMatrix(grilla.Row, 3) = "" Then
        MsgBox "Debe ingresar primero el mes", vbInformation
    End If
   
    Select Case KeyCode
    
    Case vbKeyReturn
        With grilla
            .TextMatrix(.Row, .Col) = cboDia.Text
            .Enabled = True
            .SetFocus
            .TextMatrix(.Row, 0) = LlenaCeros(cboDia.Text, 2, 2) & "-" & LlenaCeros(cboMes.Text, 2, 2)
            cboDia.Visible = False
        End With
    
    Case vbKeyEscape
        cboDia.Visible = False
        grilla.Enabled = True
        grilla.SetFocus
    End Select
End Sub

Private Sub cboDia_LostFocus()
    cboDia.Visible = False
End Sub

Private Sub cboEstado_KeyDown(KeyCode As Integer, Shift As Integer)
    Select Case KeyCode
    
    Case vbKeyReturn
        With grilla
            .TextMatrix(.Row, .Col) = cboEstado.Text
            .Enabled = True
            .SetFocus
            cboEstado.Visible = False
        End With
    
    Case vbKeyEscape
        cboEstado.Visible = False
        grilla.Enabled = True
        grilla.SetFocus
        
    End Select
End Sub

Private Sub cboEstado_LostFocus()
    cboEstado.Visible = False
End Sub

Private Sub cboMes_KeyDown(KeyCode As Integer, Shift As Integer)
  
    Select Case KeyCode
    
    Case vbKeyReturn

        With grilla
            .TextMatrix(.Row, .Col) = cboMes.Text
            .Enabled = True
            cboMes.Visible = False
            .TextMatrix(.Row, 0) = Mid(.TextMatrix(.Row, 0), 1, 2) & "-" & LlenaCeros(cboMes.Text, 2, 2)
            .SetFocus
        End With
   
    Case vbKeyEscape
        cboMes.Visible = False
        grilla.Enabled = True
        grilla.SetFocus
    End Select

End Sub

Private Sub cboMes_LostFocus()
    cboMes.Visible = False
End Sub

Private Sub cboReglas_KeyDown(KeyCode As Integer, Shift As Integer)
   
    Select Case KeyCode
    
    Case vbKeyReturn
        With grilla
            .TextMatrix(.Row, .Col) = cboReglas.Text
            .Enabled = True
            .SetFocus
            cboReglas.Visible = False
        End With
    
    Case vbKeyEscape
        cboReglas.Visible = False
        grilla.Enabled = True
        grilla.SetFocus
    
    End Select
End Sub

Private Sub cboReglas_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        grilla.TextMatrix(grilla.Row, 9) = Trim(Right(cboReglas.Text, 1))
    End If
End Sub

Private Sub cboReglas_LostFocus()
    cboReglas.Visible = False
End Sub

Private Sub Form_Load()

    Me.Top = 0: Me.Left = 0
    Me.Icon = BACSwapParametros.Icon
    
    Call BacIniciaGrilla(2, 10, 1, 0, False, grilla)
    Limpiar_Grilla
    
    Call APHabilitarControles(False)
    
    grilla.Col = 0
    grilla.Row = grilla.FixedRows
    
    txtNemo.Text = ""
    txtNemo.Visible = False
    txtDescripcion.Text = ""
    txtDescripcion.Visible = False
    txtComentario.Text = ""
    txtComentario.Visible = False
    
    LLena_Combos
    
    cboDia.Visible = False
    cboMes.Visible = False
    cboReglas.Visible = False
    cboEstado.Visible = False
    
End Sub

Public Function Valida_Ingreso(obj As Object) As Boolean

Dim Fila%
Valida_Ingreso = True

grilla.Enabled = True

With obj
  
    For Fila = 1 To .Rows - 1
      
      .Row = Fila
       
      If Trim$(.TextMatrix(.Row, 0)) <> "" And Trim$(.TextMatrix(.Row, 1)) = "" Then
           'Screen.MousePointer = 0
          ' MsgBox "Falta Ingresar el Nombre a Un Operador", 16, gsPARAMS_Version
          
          ' Valida_Ingreso = False
          PROC_POSICIONA_TEXTO grilla, txtNemo
            .Col = 0
           
           Exit Function
       End If
         
   Next Fila
              
End With
        
End Function
Sub Limpiar_Grilla()

   grilla.Clear

   Call CARGAPAR_GRILLA(grilla)
    
End Sub

Private Function CARGAPAR_GRILLA(Grillas As Object)

    With Grillas

        .Enabled = True
        .Row = 0
        .RowHeight(0) = 400
        .CellFontWidth = 4         ' TAMAÑO
        .ColWidth(0) = 1000
        .ColWidth(1) = 3000
        .ColWidth(2) = 1200
        .ColWidth(3) = 1400
        .ColWidth(4) = 4000
        .ColWidth(5) = 0
        .ColWidth(6) = 0
        .ColWidth(7) = 2500
        .ColWidth(8) = 1500
        .ColWidth(9) = 0
         
        .Row = 0

        .Col = 0
        .CellFontBold = True       'RESALSE
        .FixedAlignment(0) = 4
        .Text = "   Nemo "

        .Col = 1
        .CellFontBold = True       'RESALSE
        .FixedAlignment(1) = 4
        .Text = " Descripcion  "
        
        .Col = 2
        .CellFontBold = True       'RESALSE
        .FixedAlignment(2) = 4
        .Text = " Dia Feriado  "
        
        .Col = 3
        .CellFontBold = True       'RESALSE
        .FixedAlignment(3) = 4
        .Text = " Mes Feriado  "
        
        .Col = 4
        .CellFontBold = True       'RESALSE
        .FixedAlignment(4) = 4
        .Text = " Comentario  "
        
        .Col = 5
        .CellFontBold = True       'RESALSE
        .FixedAlignment(5) = 4
        .Text = " FER_ID  "
        
        .Col = 6
        .CellFontBold = True       'RESALSE
        .FixedAlignment(6) = 4
        .Text = " Estado Nuevo-Modificar "
        
        .Col = 7
        .CellFontBold = True       'RESALSE
        .FixedAlignment(7) = 4
        .Text = " Reglas de Ajuste  "
        
        .Col = 8
        .CellFontBold = True       'RESALSE
        .FixedAlignment(8) = 4
        .Text = " Estado  "
        
        .Col = 9
        .CellFontBold = True       'RESALSE
        .FixedAlignment(9) = 4
        .Text = " Codigo Regla  "
    End With

End Function

Private Sub grilla_DblClick()
Dim Filas_Grilla As Integer

    If txtCodPais <> "" Then
        Filas_Grilla = grilla.Rows
        If grilla.Row = Filas_Grilla - 1 And grilla.TextMatrix(grilla.Row, 6) <> "Nuevo" Then
            If grilla.TextMatrix(grilla.Row, 0) <> "" And grilla.TextMatrix(grilla.Row, 1) <> "" And grilla.TextMatrix(grilla.Row, 2) <> "" And grilla.TextMatrix(grilla.Row, 3) <> "" And grilla.TextMatrix(grilla.Row, 7) <> "" And grilla.TextMatrix(grilla.Row, 8) <> "" Then
                grilla.AddItem ""
            
                grilla.Col = 0
                grilla.Row = grilla.Row + 1
                grilla.TextMatrix(grilla.Row, 6) = "Nuevo"
                
            ElseIf Filas_Grilla = 2 Then
                grilla.Col = 0
                grilla.Row = grilla.Row
                grilla.TextMatrix(grilla.Row, 6) = "Nuevo"
            Else
            
                Call grilla_KeyPress(13)
            End If
        Else
            
            Call grilla_KeyPress(13)
        End If
    End If
End Sub

Private Sub grilla_KeyDown(KeyCode As Integer, Shift As Integer)
Dim Filas_Grilla As Integer
   
   If KeyCode = 46 Then
   
     If (grilla.TextMatrix(grilla.Row, 0) = "" Or grilla.TextMatrix(grilla.Row, 1) = "") And grilla.Rows > 2 Then
     
         grilla.RemoveItem (grilla.Row)
         grilla.SetFocus
         Exit Sub
     
     End If
   
     If (grilla.TextMatrix(grilla.Row, 0) = "" Or grilla.TextMatrix(grilla.Row, 1) = "") And grilla.Rows = 2 Then
     
         grilla.Rows = 1
         grilla.Rows = 2
         Exit Sub
     
     End If
   
      'Call Eliminar
   
   End If
   
    If KeyCode = 13 Then
        Filas_Grilla = grilla.Rows
        If grilla.Row = Filas_Grilla - 1 And grilla.TextMatrix(grilla.Row, 6) <> "Cambio" Then
   
           grilla.TextMatrix(grilla.Row, 6) = "Nuevo"
        End If
   
    End If
   
   If KeyCode = 45 Then
   
      If grilla.TextMatrix(grilla.Rows - 1, 0) <> "" And grilla.TextMatrix(grilla.Rows - 1, 0) <> "" Then
      
            Filas_Grilla = grilla.Rows
            If grilla.Row = Filas_Grilla - 1 And grilla.TextMatrix(grilla.Row, 6) <> "Nuevo" Then
                If grilla.TextMatrix(grilla.Row, 0) <> "" And grilla.TextMatrix(grilla.Row, 1) <> "" And grilla.TextMatrix(grilla.Row, 2) <> "" And grilla.TextMatrix(grilla.Row, 3) <> "" And grilla.TextMatrix(grilla.Row, 7) <> "" And grilla.TextMatrix(grilla.Row, 8) <> "" Then
                    grilla.AddItem ""
            
                    grilla.Col = 0
                    grilla.Row = grilla.Row + 1
                    grilla.TextMatrix(grilla.Row, 6) = "Nuevo"
                
                ElseIf Filas_Grilla = 2 Then
                    grilla.Col = 0
                    grilla.Row = grilla.Row
                    grilla.TextMatrix(grilla.Row, 6) = "Nuevo"
                Else
      
                    Call grilla_KeyPress(13)
      End If
   
                grilla.SetFocus
            End If
   End If
   End If
   
End Sub

Private Sub grilla_KeyPress(KeyAscii As Integer)

Dim row_tem%
    
With grilla

    If .Col = 0 Then  'NEMO
           
        If KeyAscii = 13 Or KeyAscii = 8 Or IsNumeric(Chr(KeyAscii)) Then
        
            row_tem = .Row
                
            .Row = row_tem
            .Col = 0
        
            PROC_POSICIONA_TEXTO grilla, txtNemo
            .Enabled = False
            txtNemo.Visible = True
            If IsNumeric(Chr(KeyAscii)) Then
                txtNemo.Text = Chr(KeyAscii)
                SendKeys "{RIGHT}"    'Comienzo Izquierda
            Else
                txtNemo.Text = .TextMatrix(.Row, .Col)
                SendKeys "{END}"
            End If
            If .TextMatrix(.Row, 6) <> "Nuevo" Then
                .TextMatrix(.Row, 6) = "Cambio"
            End If
            txtNemo.SetFocus

        End If
    End If
    
    If .Col = 1 Then    'DESCRIPCION
      
        If KeyAscii > 0 And KeyAscii <> 27 Then
        
            PROC_POSICIONA_TEXTO grilla, txtDescripcion
            .Enabled = False
            txtDescripcion.Visible = True
            If KeyAscii = 13 Then
                txtDescripcion.Text = .TextMatrix(.Row, .Col)
                SendKeys "{END}"     'Comienzo Derecha
            Else
                txtDescripcion.Text = Chr(KeyAscii)
                SendKeys "{RIGHT}"    'Comienzo Izquierda
            End If
            If .TextMatrix(.Row, 6) <> "Nuevo" Then
                .TextMatrix(.Row, 6) = "Cambio"
            End If
            txtDescripcion.SetFocus
        End If
    End If
    
    If .Col = 2 Then     'DIA FERIADO
           
        If KeyAscii = 13 Or KeyAscii = 8 Or IsNumeric(Chr(KeyAscii)) Then
            
            
            If InStr(1, .TextMatrix(.Row, 0), "L") = 0 And InStr(1, .TextMatrix(.Row, 0), "J") = 0 And InStr(1, .TextMatrix(.Row, 0), "U") = 0 And InStr(1, .TextMatrix(.Row, 0), "M") = 0 Then
            
                row_tem = .Row
                    
                .Row = row_tem
                .Col = 2
            
                .Enabled = False
                If IsNumeric(Chr(KeyAscii)) Then
                    SendKeys "{RIGHT}"    'Comienzo Izquierda
                Else
                    SendKeys "{END}"
                End If
                If .TextMatrix(.Row, 6) <> "Nuevo" Then
                    .TextMatrix(.Row, 6) = "Cambio"
                End If
                cboDia.Visible = True
                PROC_POSICIONA_TEXTO grilla, cboDia
                cboDia.SetFocus
            End If
        End If
    End If
    
    If .Col = 3 Then    'MES FERIADO
           
        If KeyAscii = 13 Or KeyAscii = 8 Or IsNumeric(Chr(KeyAscii)) Then
        
            row_tem = .Row
                
            .Row = row_tem
            .Col = 3
        
            PROC_POSICIONA_TEXTO grilla, cboMes
            .Enabled = False
            cboMes.Visible = True
            If IsNumeric(Chr(KeyAscii)) Then
                SendKeys "{RIGHT}"    'Comienzo Izquierda
            Else
                SendKeys "{END}"
            End If
            If .TextMatrix(.Row, 6) <> "Nuevo" Then
                .TextMatrix(.Row, 6) = "Cambio"
            End If
            cboMes.SetFocus
        End If
    End If
        
    If .Col = 4 Then   'COMENTARIO
           
        If KeyAscii > 0 And KeyAscii <> 27 Then
        
            PROC_POSICIONA_TEXTO grilla, txtComentario
            .Enabled = False
            txtComentario.Visible = True
            If KeyAscii = 13 Then
                txtComentario.Text = .TextMatrix(.Row, .Col)
                SendKeys "{END}"     'Comienzo Derecha
            Else
                txtComentario.Text = Chr(KeyAscii)
                SendKeys "{RIGHT}"    'Comienzo Izquierda
            End If
            If .TextMatrix(.Row, 6) <> "Nuevo" Then
                .TextMatrix(.Row, 6) = "Cambio"
            End If
            txtComentario.SetFocus
        End If
    End If
    
    If .Col = 7 Then   'REGLAS
           
        If KeyAscii = 13 Or KeyAscii = 8 Or IsNumeric(Chr(KeyAscii)) Then
            
            row_tem = .Row
                    
            .Row = row_tem
            .Col = 7
            .Enabled = False
            If IsNumeric(Chr(KeyAscii)) Then
                SendKeys "{RIGHT}"    'Comienzo Izquierda
            Else
                SendKeys "{END}"
            End If
            If .TextMatrix(.Row, 6) <> "Nuevo" Then
                .TextMatrix(.Row, 6) = "Cambio"
            End If
            cboReglas.Visible = True
            PROC_POSICIONA_TEXTO grilla, cboReglas
            cboReglas.SetFocus
        End If
    End If
    
    If .Col = 8 Then   'ESTADO
           
        If KeyAscii = 13 Or KeyAscii = 8 Or IsNumeric(Chr(KeyAscii)) Then
            
            row_tem = .Row
                    
            .Row = row_tem
            .Col = 8
            .Enabled = False
            If IsNumeric(Chr(KeyAscii)) Then
                SendKeys "{RIGHT}"    'Comienzo Izquierda
            Else
                SendKeys "{END}"
            End If
            If .TextMatrix(.Row, 6) <> "Nuevo" Then
                .TextMatrix(.Row, 6) = "Cambio"
            End If
            cboEstado.Visible = True
            PROC_POSICIONA_TEXTO grilla, cboEstado
            cboEstado.SetFocus
        End If
    End If
    
End With
End Sub


Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
    Dim texto As String

    Select Case Button.Index
        Case 1
        
            If grilla.TextMatrix(grilla.Row, 0) = "" Then
                MsgBox "Debe ingresar columna Nemo", vbInformation
                Exit Sub
            End If
            
            If grilla.TextMatrix(grilla.Row, 1) = "" Then
                MsgBox "Debe ingresar columna Descripcion", vbInformation
                Exit Sub
            End If
            
            If grilla.TextMatrix(grilla.Row, 2) = "" Then
                MsgBox "Debe ingresar columna Dia Feriado", vbInformation
                Exit Sub
            End If
            
            If grilla.TextMatrix(grilla.Row, 3) = "" Then
                MsgBox "Debe ingresar columna Mes Feriado", vbInformation
                Exit Sub
            End If
            
            If grilla.TextMatrix(grilla.Row, 7) = "" Then
                MsgBox "Debe ingresar columna Reglas de Ajuste", vbInformation
                Exit Sub
            End If
            
            If grilla.TextMatrix(grilla.Row, 8) = "" Then
                MsgBox "Debe ingresar columna Estado", vbInformation
                Exit Sub
            End If
        
            Call Grabar
            Call Limpiar
            txtCodPais.SetFocus
        Case 3
            Call Limpiar
            Call APHabilitarControles(False)
            txtCodPais.SetFocus
        Case 4
            Unload Me
    End Select
End Sub

Function APHabilitarControles(Valor As Boolean)

   txtCodPais.Enabled = Not Valor
   txtNomPais.Enabled = Not Valor
   Toolbar1.Buttons(1).Enabled = Valor
   Toolbar1.Buttons(2).Enabled = Valor

End Function

Private Sub Limpiar()
    txtCodPais.Text = ""
    txtNomPais.Text = ""
    
    txtCodPais.Enabled = True
    txtNomPais.Enabled = True
    
    txtNemo.Text = ""
    txtNemo.Visible = False
    txtDescripcion.Text = ""
    txtDescripcion.Visible = False
    txtComentario.Text = ""
    txtComentario.Visible = False
    
    cboDia.Visible = False
    cboMes.Visible = False
    cboReglas.Visible = False
    cboEstado.Visible = False
    
    Call BacIniciaGrilla(2, 10, 1, 0, False, grilla)
    Limpiar_Grilla
    'Call Habilitacontroles(False)
End Sub

Private Sub txtcodpais_DblClick()
    auxilio = 100
    Call codigopais
    If txtCodPais.Enabled = True Then
        txtCodPais.SetFocus
    End If
    
    Call APHabilitarControles(True)
    
    txtCodPais.Enabled = False
    txtNomPais.Enabled = False
End Sub

Sub codigopais()
    On Error GoTo ErrorCodigoPais
    MousePointer = 11
    
    BacAyuda.Tag = "FERIADOS"
    BacAyuda.Show 1
    
    MousePointer = 0

Exit Sub
ErrorCodigoPais:
    MsgBox Err.Description, vbExclamation, TITSISTEMA
End Sub

Private Sub txtcodpais_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then

        sql = "SELECT nombre FROM PAIS where codigo_pais='" & txtCodPais & "'"
        If MISQL.SQL_Execute(sql) <> 0 Then
            MsgBox "No se pudo realizar Consulta de Datos", vbInformation + vbOKOnly, TITSISTEMA
        End If
        Do While MISQL.SQL_Fetch(Datos()) = 0
            txtNomPais.Text = Datos(1)
        Loop
         
        i = 1
        Envia = Array()
            
        AddParam Envia, txtCodPais.Text
            
        If Not Bac_Sql_Execute("SP_BUSCA_FERIADOS", Envia) Then
            Exit Sub
        End If
        
        Do While Bac_SQL_Fetch(Datos())
            grilla.Rows = i + 1
            grilla.Row = i
            grilla.TextMatrix(i, 0) = Datos(1)
            grilla.TextMatrix(i, 1) = Datos(2)
            grilla.TextMatrix(i, 2) = Datos(3)
            grilla.TextMatrix(i, 3) = Datos(4)
            grilla.TextMatrix(i, 4) = Datos(5)
            grilla.TextMatrix(i, 5) = Datos(6)
            grilla.TextMatrix(i, 6) = "Cambio"
            grilla.TextMatrix(i, 7) = Datos(7)
            grilla.TextMatrix(i, 8) = Datos(8)
            grilla.TextMatrix(i, 9) = Datos(9)
            i = i + 1
        Loop
        
        Call APHabilitarControles(True)
    
        txtCodPais.Enabled = False
        txtNomPais.Enabled = False
    
    End If
End Sub

Private Sub txtComentario_KeyPress(KeyAscii As Integer)
 With grilla
  
  KeyAscii = Asc(Chr$(KeyAscii))
  
    If KeyAscii = 13 Then
               
          '.ColAlignment(1) = 2
          .TextMatrix(.Row, .Col) = txtComentario.Text
           txtComentario.Text = ""
           .Enabled = True
           txtComentario.Visible = False
          .SetFocus
      End If
   
   
     If KeyAscii = 27 Then
           txtComentario.Text = ""
           txtComentario.Visible = False
           .Enabled = True
          .SetFocus
     End If
     
 End With
End Sub


Private Sub txtComentario_LostFocus()
    txtComentario_KeyPress 27
End Sub


Private Sub txtDescripcion_KeyPress(KeyAscii As Integer)
    With grilla
  
        KeyAscii = Asc(Chr$(KeyAscii))
  
        If KeyAscii = 13 Then
               
            '.ColAlignment(1) = 2
            .TextMatrix(.Row, .Col) = txtDescripcion.Text
            txtDescripcion.Text = ""
            .Enabled = True
            txtDescripcion.Visible = False
            .SetFocus
        End If
   
   
        If KeyAscii = 27 Then
            txtDescripcion.Text = ""
            txtDescripcion.Visible = False
            .Enabled = True
            .SetFocus
        End If
     
    End With
End Sub

Private Sub TxtDescripcion_LostFocus()

   txtDescripcion_KeyPress 27
End Sub


Private Sub txtNemo_KeyPress(KeyAscii As Integer)
Dim xDiaNemo

 With grilla
 
    If grilla.TextMatrix(grilla.Row, 3) = "" Then
        MsgBox "Debe ingresar primero el mes", vbInformation
           txtNemo.Text = ""
           txtNemo.Visible = False
           .Enabled = True
          .SetFocus
    End If
    
    KeyAscii = Asc(UCase$(Chr$(KeyAscii)))
  
    If (KeyAscii >= 48 And KeyAscii <= 57) Or KeyAscii = 13 Or KeyAscii = 27 Or KeyAscii = 8 Or KeyAscii = 45 Or KeyAscii = 74 Or KeyAscii = 76 Or KeyAscii = 85 Then
    Else
         KeyAscii = 0
    End If
 
 
   If KeyAscii = 13 Then
        
        If bacBuscaRepetidoGrilla(0, grilla, Trim(txtNemo.Text)) = False Then
            
          If Trim$(txtNemo) = "" Then
            .TextMatrix(.Row, 0) = ""
            .TextMatrix(.Row, 1) = ""
          End If
            
            '.ColAlignment(0) = 8
            .TextMatrix(.Row, 0) = ""
            .TextMatrix(.Row, 0) = Trim(txtNemo.Text)
            If InStr(1, .TextMatrix(.Row, 0), "L") <> 0 <> 0 Or InStr(1, .TextMatrix(.Row, 0), "J") <> 0 Or InStr(1, .TextMatrix(.Row, 0), "U") <> 0 Or InStr(1, .TextMatrix(.Row, 0), "M") <> 0 Then
                If Mid(.TextMatrix(.Row, 0), 1, 1) = "0" Then
                    .TextMatrix(.Row, 2) = Mid(.TextMatrix(.Row, 0), 2, 1)
                ElseIf InStr(1, .TextMatrix(.Row, 0), "J") <> 0 Or InStr(1, .TextMatrix(.Row, 0), "L") <> 0 Or InStr(1, .TextMatrix(.Row, 0), "U") <> 0 Or InStr(1, .TextMatrix(.Row, 0), "M") <> 0 Then
                    .TextMatrix(.Row, 2) = 0
                Else
                    .TextMatrix(.Row, 2) = Mid(.TextMatrix(.Row, 0), 1, 2)
                End If
                .Row = .Row
                .Col = 0
            End If
             txtNemo.Visible = False
            .Enabled = True
            .Col = 0
            .SetFocus
            
            If .TextMatrix(.Row, 0) <> "" Then
                If InStr(.TextMatrix(.Row, 0), "U") = 0 And InStr(.TextMatrix(.Row, 0), "J") = 0 And InStr(.TextMatrix(.Row, 0), "L") = 0 And InStr(.TextMatrix(.Row, 0), "M") = 0 Then
                    If Dias_Del_Mes(.TextMatrix(.Row, 0)) = False Then
                        MsgBox "La fecha ingresada es incorrecta", vbInformation
                        .TextMatrix(.Row, 0) = Mid(.TextMatrix(.Row, 0), 3, 3)
                    End If
                End If
            End If
            
            Exit Sub
        Else
             KeyAscii = 0
             Exit Sub
        End If
        
    End If
   
   
     If KeyAscii = 27 Then
           txtNemo.Text = ""
           txtNemo.Visible = False
           .Enabled = True
          .SetFocus
     End If
     
 End With
End Sub


Private Sub txtNemo_LostFocus()

   txtNemo_KeyPress 27
End Sub

Private Sub LLena_Combos()
    
    For i = 1 To 31
        cboDia.AddItem i
    Next
    cboDia.ListIndex = 0
    
    For i = 1 To 12
        cboMes.AddItem i
    Next
    cboMes.ListIndex = 0

    If Not Bac_Sql_Execute("SP_BUSCA_REGLAS_FERIADOS") Then
        Exit Sub
    End If

    Do While Bac_SQL_Fetch(Datos())
        
        cboReglas.AddItem Datos(2) & "                                                                                                                              " & Datos(1)
    
    Loop

    cboEstado.AddItem "Activo"
    cboEstado.AddItem "Desactivado"

End Sub

Private Function Dias_Del_Mes(DiaMes As String) As Boolean
Dim Mes As Integer
Dim Dia As Integer

Dias_Del_Mes = True

Dia = Mid(DiaMes, 1, 2)
Mes = Mid(DiaMes, 4, 2)

If Mes > 12 Or Mes = 0 Then
    MsgBox ("El mes es incorrecto"), vbInformation
    Mes = 1
End If

Select Case Mes
Case 1
    If Dia > 31 Or Dia = 0 Then
        Dias_Del_Mes = False
    End If
Case 2
    If Dia > 29 Or Dia = 0 Then
        Dias_Del_Mes = False
    End If
Case 3
    If Dia > 31 Or Dia = 0 Then
        Dias_Del_Mes = False
    End If
Case 4
    If Dia > 30 Or Dia = 0 Then
        Dias_Del_Mes = False
    End If
Case 5
    If Dia > 31 Or Dia = 0 Then
        Dias_Del_Mes = False
    End If
Case 6
    If Dia > 30 Or Dia = 0 Then
        Dias_Del_Mes = False
    End If
Case 7
    If Dia > 31 Or Dia = 0 Then
        Dias_Del_Mes = False
    End If
Case 8
    If Dia > 30 Or Dia = 0 Then
        Dias_Del_Mes = False
    End If
Case 9
    If Dia > 31 Or Dia = 0 Then
        Dias_Del_Mes = False
    End If
Case 10
    If Dia > 30 Or Dia = 0 Then
        Dias_Del_Mes = False
    End If
Case 11
    If Dia > 31 Or Dia = 0 Then
        Dias_Del_Mes = False
    End If
Case 12
    If Dia > 30 Or Dia = 0 Then
        Dias_Del_Mes = True
    End If
End Select

End Function



