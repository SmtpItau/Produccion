VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "Mscomctl.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "threed32.ocx"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{989C9190-EDF5-45A8-AB6C-98E6EF0384D7}#1.0#0"; "Bac_Controles_Pas.ocx"
Begin VB.Form BacMntTb 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantenedor De Tablas"
   ClientHeight    =   4020
   ClientLeft      =   1755
   ClientTop       =   2130
   ClientWidth     =   9675
   ForeColor       =   &H00C0C0C0&
   Icon            =   "Bacmnttb.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form9"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4020
   ScaleWidth      =   9675
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   9315
      Top             =   45
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
            Picture         =   "Bacmnttb.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmnttb.frx":075E
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmnttb.frx":0BB2
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmnttb.frx":0ECE
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmnttb.frx":11EA
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
      Width           =   9675
      _ExtentX        =   17066
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   5
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
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
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Agregar"
            ImageIndex      =   5
         EndProperty
      EndProperty
   End
   Begin Threed.SSPanel SSPanel1 
      Height          =   3480
      Left            =   45
      TabIndex        =   1
      Top             =   540
      Width           =   9645
      _Version        =   65536
      _ExtentX        =   17013
      _ExtentY        =   6138
      _StockProps     =   15
      Caption         =   "SSPanel1"
      BackColor       =   -2147483644
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin VB.Frame Frame1 
         ForeColor       =   &H00C00000&
         Height          =   825
         Left            =   75
         TabIndex        =   7
         Top             =   45
         Width           =   9420
         Begin VB.TextBox txtDesCategoria 
            Enabled         =   0   'False
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   285
            Left            =   1920
            MaxLength       =   25
            TabIndex        =   9
            Top             =   360
            Width           =   5655
         End
         Begin VB.TextBox txtNCategoria 
            Alignment       =   1  'Right Justify
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   285
            Left            =   240
            MaxLength       =   4
            MouseIcon       =   "Bacmnttb.frx":1506
            MousePointer    =   99  'Custom
            TabIndex        =   8
            Top             =   360
            Width           =   885
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            Caption         =   "Descripción de Tablas"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000007&
            Height          =   210
            Left            =   1920
            TabIndex        =   11
            Top             =   150
            Width           =   1815
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "Nº Categoría"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000007&
            Height          =   210
            Index           =   0
            Left            =   120
            TabIndex        =   10
            Top             =   150
            Width           =   1005
         End
      End
      Begin VB.TextBox Txtcodigo 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00800000&
         BorderStyle     =   0  'None
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
         Height          =   180
         Left            =   5460
         TabIndex        =   5
         Top             =   1995
         Visible         =   0   'False
         Width           =   870
      End
      Begin VB.TextBox TxtGlosa 
         BackColor       =   &H00800000&
         BorderStyle     =   0  'None
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
         Height          =   195
         Left            =   6345
         MaxLength       =   30
         TabIndex        =   3
         Top             =   1635
         Visible         =   0   'False
         Width           =   915
      End
      Begin MSMask.MaskEdBox TxtFecha 
         Height          =   210
         Left            =   5835
         TabIndex        =   2
         Top             =   2790
         Visible         =   0   'False
         Width           =   900
         _ExtentX        =   1588
         _ExtentY        =   370
         _Version        =   393216
         BorderStyle     =   0
         BackColor       =   8388608
         ForeColor       =   16777215
         MaxLength       =   10
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Mask            =   "##/##/####"
         PromptChar      =   "_"
      End
      Begin BACControles.TXTNumero TxtValor 
         Height          =   210
         Left            =   7020
         TabIndex        =   4
         Top             =   2460
         Visible         =   0   'False
         Width           =   870
         _ExtentX        =   1535
         _ExtentY        =   370
         BackColor       =   8388608
         ForeColor       =   16777215
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BorderStyle     =   0
         Text            =   "0"
         Text            =   "0"
         Separator       =   -1  'True
      End
      Begin MSFlexGridLib.MSFlexGrid GRILLA 
         Height          =   2385
         Left            =   60
         TabIndex        =   6
         Top             =   960
         Width           =   9495
         _ExtentX        =   16748
         _ExtentY        =   4207
         _Version        =   393216
         Rows            =   13
         Cols            =   5
         FixedCols       =   0
         BackColor       =   -2147483644
         ForeColor       =   8388608
         BackColorFixed  =   8421376
         ForeColorFixed  =   16777215
         BackColorSel    =   8388608
         ForeColorSel    =   8388608
         BackColorBkg    =   12632256
         GridColor       =   255
         GridLines       =   2
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
   Begin VB.Data DataFox 
      Caption         =   "DataFox"
      Connect         =   "Access"
      DatabaseName    =   ""
      DefaultCursorType=   0  'DefaultCursor
      DefaultType     =   2  'UseODBC
      Exclusive       =   0   'False
      Height          =   300
      Left            =   2160
      Options         =   0
      ReadOnly        =   0   'False
      RecordsetType   =   0  'Table
      RecordSource    =   ""
      Top             =   4260
      Visible         =   0   'False
      Width           =   2055
   End
   Begin VB.Data Data1 
      Caption         =   "Data1"
      Connect         =   "Access"
      DatabaseName    =   ""
      DefaultCursorType=   0  'DefaultCursor
      DefaultType     =   2  'UseODBC
      Exclusive       =   0   'False
      Height          =   300
      Left            =   135
      Options         =   0
      ReadOnly        =   0   'False
      RecordsetType   =   0  'Table
      RecordSource    =   ""
      Top             =   4230
      Visible         =   0   'False
      Width           =   2055
   End
   Begin MSMask.MaskEdBox Msk_fecha_expira 
      Height          =   300
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   1170
      _ExtentX        =   2064
      _ExtentY        =   529
      _Version        =   393216
      ForeColor       =   0
      MaxLength       =   10
      Mask            =   "##/##/####"
      PromptChar      =   " "
   End
End
Attribute VB_Name = "BacMntTb"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim OptLocal As String
Dim Agrega As Boolean
Private objMensajesTB   As Object
Dim ModoEdit
Dim Existe              As Boolean

'Sub LimpiarData()
'db.Execute "delete * from TABGEN"
'Data1.Refresh
'End Sub

Private Sub HabilitarControles(Valor)
    txtNCategoria.Enabled = Not Valor
    
    Grilla.Enabled = Valor
    Toolbar1.Buttons(5).Enabled = Valor
    Toolbar1.Buttons(1).Enabled = Valor
    Toolbar1.Buttons(2).Enabled = Valor
    Toolbar1.Buttons(3).Enabled = Valor
       
End Sub

Private Sub Limpiar()
    txtNCategoria.Text = ""
    txtDesCategoria.Text = ""
   ' LimpiarData
End Sub

Private Function ValidaCodigoGrilla() As Integer
Dim Fila As Long

'    ValidaCodigoGrilla = False
'
'     For Fila = 1 To TablaCod.Rows - 1
'         TablaCod.Rows = Fila
'
'
'         If Trim(TablaCod.Text) = "" Then
'            Exit Function
'         End If
'
'
'         If CDBL(TablaCod.Text) = 0 Then
'            Exit Function
'         End If
'
'         If Trim(TablaCod.Text) = 0 Then
'            Exit Function
'         End If
'
'
'         If CDBL(TablaCod.Text) = 0 Then
'            Exit Function
'         End If
'
'
'         If Trim(TablaCod.Text) = 0 Then
'            Exit Function
'         End If
'    Next Fila
   
End Function

Private Sub cmdAgregar_Click()
    
Dim Fila As Integer
Dim Entro As Integer

Entro = 0
txtCodigo = "": txtCodigo.Visible = False


Toolbar1.Buttons(5).Enabled = False

 With Grilla
    
   .Enabled = True
     For Fila = 1 To .Rows - 1
        .Row = Fila
       If Trim(.TextMatrix(.Row, 0)) = "" Then
                 .Col = 0
                 .SetFocus
                 .TextMatrix(.Row, 0) = "" 'codigo
                 .TextMatrix(.Row, 1) = "0" 'tasa
                 .TextMatrix(.Row, 2) = CDate(Date) 'fecha
                 Entro = 1
                 Exit Sub
       End If
    Next Fila
    
    
    If Entro = 0 Then ' no entro
       .Rows = .Rows + 1
       .Col = 0
       .SetFocus
    End If
      
    
 End With
    

    
''    TablaCod.Enabled = True
''
''If Data1.Recordset.RecordCount = 0 Then
''    Data1.Recordset.AddNew
''    Data1.Recordset!tbcodigo = " "
''    Data1.Recordset!tbtasa = 0
''    Data1.Recordset!tbfecha = CDate("01/01/1900")
''    Data1.Recordset!tbvalor = 0
''    Data1.Recordset!tbglosa = " "
''    Data1.Recordset.Update
''    Data1.Refresh
''    Data1.Recordset.MoveLast
''    TablaCod.ColumnIndex = 1
''    TablaCod.SetFocus
''Else
''    Data1.Recordset.MoveLast
''    If Not Data1.Recordset!tbcodigo = " " And Data1.Enabled = True Then
''        Data1.Recordset.AddNew
''        Data1.Recordset!tbcodigo = " "
''        Data1.Recordset!tbtasa = 0
''        Data1.Recordset!tbfecha = CDate("01/01/1900")
''        Data1.Recordset!tbvalor = 0
''        Data1.Recordset!tbglosa = " "
''        Data1.Recordset.Update
''        Data1.Refresh
''        Data1.Recordset.MoveLast
''        TablaCod.ColumnIndex = 1
''        TablaCod.SetFocus
''    End If
''End If
End Sub


Private Sub cmdEliminar_Click()

 txtCodigo = "": txtCodigo.Visible = False

If Trim(Grilla.TextMatrix(Grilla.Row, 0)) = "" Then
       Exit Sub
End If



If MsgBox("Esta Seguro de Eliminar este elemento", 36) = 6 Then
    
    ''If Elimina_Fox Then
        
        If Elimina_Sql Then
             'DB.Execute "delete * from tabgen where tbcodigo = """ & Trim(data1.Recordset!TBCodigo) & """"
             Consulta_Categoria
             MsgBox "Eliminación se realizó con exito", vbInformation
        Else
            MsgBox "Eliminación no se realizó con exito", vbInformation
        End If
        
   '' Else
   ''      MsgBox "Eliminación no se realizó con exito", vbInformation, gsBac_Version
    ''End If
 End If
 
 

'' Data1.Refresh
''If Data1.Recordset.RecordCount = 0 Then
''    TablaCod.Enabled = False
 ''   cmdEliminar.Enabled = False
''End If

End Sub

Function Elimina_Fox() As Boolean
Elimina_Fox = False

On Error GoTo ErrEli
If Buscar_Fox(txtNCategoria.Text, Data1.Recordset!tbcodigo, Data1.Recordset!tbtasa, Data1.Recordset!tbfecha) Then
    DataFox.Recordset.Edit
    DataFox.Recordset!tbcodigo1 = "*" & Mid(DataFox.Recordset!tbcodigo, 1, 3)
    DataFox.Recordset.Update
    DataFox.Recordset.Delete
    Elimina_Fox = True
End If
   DataFox.Refresh
   Exit Function
ErrEli:
    If err.Number = 3015 Then
        MsgBox "Error ODBC Windows no se encuentra archivo INF", vbCritical
    Else
        MsgBox "Error :" + err.Description, vbCritical
    End If
    Exit Function
End Function

Function Elimina_Sql() As Boolean

Dim Sql As String

         Elimina_Sql = False

 With Grilla

    Envia = Array()
    AddParam Envia, Trim(txtNCategoria.Text)
    AddParam Envia, .TextMatrix(.Row, 0)

 End With

        If Not BAC_SQL_EXECUTE("sp_eliminatabla ", Envia) Then
            Exit Function
        End If
        
 Elimina_Sql = True

''Sql = ""
''Sql = "execute eliminatabla "
''Sql = Sql & Trim(txtNCategoria.Text) & ","
''Sql = Sql & "'" & Data1.Recordset!tbcodigo & "',"
''Sql = Sql & Data1.Recordset!tbtasa & ","
''Sql = Sql & "'" & Format(Data1.Recordset!tbfecha, "YYYYMMDD") & "'"
''
''
''If SQL_Execute(Sql) <> 0 Then
'' 'MsgBox ("El registro no puedo ser eliminado")
'' 'Exit Sub
'' Elimina_Sql = False
''Else
'' Elimina_Sql = True
''End If


End Function

Function ValidaReg() As Boolean
    
    ValidaReg = True
    If Trim(Data1.Recordset!tbcodigo) = "" Then
        MsgBox "Código no debe estar vacio", vbCritical
        ValidaReg = False
   End If

End Function
Private Sub CmdGrabar_Click()

Dim Termino As Boolean
Dim Sql As String
Dim Datos()
Dim NumReg As Double
Dim Tot As Double

Screen.MousePointer = 11

' If ValidaReg = False Then
'    Screen.MousePointer = 0
'    Exit Sub
' End If


   If Grabar_SQL Then
       Screen.MousePointer = 0
       MsgBox "Operación  se realizó con exito", vbInformation
 
   Else
       Screen.MousePointer = 0
       MsgBox "Operación NO se realizó con exito", vbCritical
    End If
    
  Call TxtVolatil


''If Data1.Recordset.RecordCount <= 0 Then
''    Screen.MousePointer = 0
''    MsgBox "No ha ingresado datos", vbCritical, gsBac_Version
''    Exit Sub
'' End If

''Data1.Recordset.MoveLast
''Tot = Data1.Recordset.RecordCount()
''NumReg = 0
''Data1.Recordset.MoveFirst
''Pnl_Porcentaje.FloodPercent = 0
''Frame2.Visible = True
''Frame2.Refresh

''Do Until Data1.Recordset.EOF
''NumReg = NumReg + 1
 
'' If ValidaReg() Then
''
''     If Not Grabar_Fox Then
''        Screen.MousePointer = 0
''        MsgBox "Operación no se realizó con exito", vbCritical, gsBac_Version
''        Frame2.Visible = False
''        Exit Sub
''    ElseIf Not Grabar_SQL Then
''       Screen.MousePointer = 0
''      MsgBox "Operación no se realizó con exito", vbCritical, gsBac_Version
''      Frame2.Visible = False
''      Exit Sub
''    End If
''Else
''     Screen.MousePointer = 0
''     TablaCod.SetFocus
''      Exit Sub
''End If
''
''Pnl_Porcentaje.FloodPercent = (NumReg * 100) / Tot
''Data1.Recordset.MoveNext
''Loop
''
''Screen.MousePointer = 0
''Frame2.Visible = False
'' MsgBox " La grabación se realizó correctamente", vbInformation, gsBac_Version
''Consulta_Categoria
'''data1.Recordset.MoveLast
''
''cmdEliminar.Enabled = True

End Sub

Sub Mover_Fox()
    DataFox.Recordset.Fields!tbcateg = CDbl(txtNCategoria.Text)
    DataFox.Recordset.Fields!tbcodigo1 = Trim(Data1.Recordset!tbcodigo)
    DataFox.Recordset.Fields!tbtasa = CDbl(Data1.Recordset!tbtasa)
    DataFox.Recordset.Fields!tbfecha = CDate(Data1.Recordset!tbfecha)
    DataFox.Recordset.Fields!tbvalor = CDbl(Data1.Recordset!tbvalor)
    DataFox.Recordset.Fields!tbglosa = Trim(Data1.Recordset!tbglosa)
    DataFox.Recordset.Fields!Nemo = " "
End Sub


Function Grabar_Fox() As Boolean
On Error GoTo GrabaError
Grabar_Fox = False
 
 
 If Not Buscar_Fox(txtNCategoria.Text, Data1.Recordset!tbcodigo, Data1.Recordset!tbtasa, Data1.Recordset!tbfecha) Then
    DataFox.Recordset.AddNew
Else
    DataFox.Recordset.Edit
End If

Mover_Fox
DataFox.Recordset.Update

Grabar_Fox = True
Exit Function

GrabaError:
    If err.Number = 3015 Then
        MsgBox "Error ODBC Windows no se encuentra archivo INF", vbCritical
    Else
        MsgBox "Error :" + err.Description, vbCritical
    End If
    Grabar_Fox = False
    Exit Function
End Function

Function Buscar_Fox(nCategoria As String, nTabla As String, nTasa As Double, nFecha As String) As Boolean
Dim Buscar As String
 DataFox.Recordset.Index = "MBTABLAS"
 DataFox.Recordset.Seek "=", nCategoria, Trim(nTabla), nTasa, CDate(nFecha)
If DataFox.Recordset.NoMatch Then
     Buscar_Fox = False
Else
    Buscar_Fox = True
End If
End Function

Function Grabar_SQL() As Boolean

Dim Sql As String
Dim Fila As Integer
         
    Grabar_SQL = False
         
With Grilla
    
    For Fila = 1 To .Rows - 1
     
        '.Row = Fila
         If Trim(.TextMatrix(Fila, 0)) <> "" Then
            
            Envia = Array()
            AddParam Envia, Trim(txtNCategoria.Text)
            AddParam Envia, Trim(.TextMatrix(Fila, 0))
            AddParam Envia, CDbl(.TextMatrix(Fila, 1))
            AddParam Envia, Format(.TextMatrix(Fila, 2), "yyyymmdd")
            AddParam Envia, Val(.TextMatrix(Fila, 3))
            AddParam Envia, Trim(.TextMatrix(Fila, 4))
            AddParam Envia, ""
        
                If Not BAC_SQL_EXECUTE("sp_grabaTabla ", Envia) Then
                    Exit Function
                End If
        
        End If
    Next Fila
        
        Grabar_SQL = True
End With


''        Dim Sql As String
''         Sql = ""
''        Sql = "execute grabaTabla "
''        Sql = Sql & Trim(txtNCategoria.Text) & ","
''        Sql = Sql & "'" & Trim(Data1.Recordset!tbcodigo) & "',"
''        Sql = Sql & CDBL(Data1.Recordset!tbtasa) & ","
''        Sql = Sql & "'" & Format(Data1.Recordset!tbfecha, "yyyymmdd") & "',"
''        Sql = Sql & CDBL(Data1.Recordset!tbvalor) & ","
''        Sql = Sql & "'" & Trim(Data1.Recordset!tbglosa) & "',"
''        Sql = Sql & "' '"
''        If SQL_Execute(Sql) <> 0 Then
''            Grabar_SQL = False
''            Exit Function
''        End If
''
''        Grabar_SQL = True
           
End Function

Private Sub cmdlimpiar_Click()
    
With Grilla
    
     .Rows = 2
     Call F_BacLimpiaGrilla(Grilla)
     'Call BacAgrandaGrilla(Grilla, 40)
    .Enabled = False
    Call TxtVolatil
    Call Limpiar
    HabilitarControles False
    txtNCategoria.SetFocus

End With
    
End Sub

Private Sub cmdSalir_Click()
    
    Unload Me
    
End Sub

Private Sub Habilitacontroles(Valor As Integer)

On Error GoTo Label1

    Toolbar1.Buttons(1).Enabled = False
    Toolbar1.Buttons(2).Enabled = False
    Toolbar1.Buttons(5).Enabled = False
    
    
Exit Sub

Label1:
      Call objMensajesTB.BacMsgError
      
End Sub

Private Sub Form_Activate()
   PROC_CARGA_AYUDA Me, " "
   Call CargarParam_Vm(Grilla)
   'call BacAgrandaGrilla(Grilla, 40)
End Sub


Private Sub Form_KeyPress(KeyAscii As Integer)
       
   '     If KeyAscii = 13 Then
   '        SendKeys "{TAB}"
   '     End If
        
End Sub

Private Sub Form_Load()
    OptLocal = Opt
    Me.top = 0
    Me.left = 0
On Error GoTo Label1

    Set objMensajesTB = New ClsMsg
    Call objMensajesTB.Valores
    ''LimpiarData
    
    HabilitarControles False
    Toolbar1.Buttons(5).Tag = "No"
    
    Call LogAuditoria("07", OptLocal, Me.Caption, "", "")
            
    ''Data1.DatabaseName = gsMDB_Path & gsMDB_Database
    ''Data1.RecordSource = "TABGEN"
    ''Data1.Refresh
    
    'TablaCod.ColumnCellAttrs(1) = True
    'TablaCod.ColumnCellAttrs(2) = True
    'TablaCod.ColumnCellAttrs(3) = True
    'TablaCod.ColumnCellAttrs(4) = True
    'TablaCod.ColumnCellAttrs(5) = True
  
    'DataFox.Connect = "FoxPro 2.6"
    'DataFox.DatabaseName = gsFox_Comun
    'DataFox.RecordSource = "MBTABLAS"
    'DataFox.Refresh
    Exit Sub

Label1:
   If err.Number = 3051 Then
    MsgBox "No se puede conectar a tablas generales", vbOKOnly + vbExclamation
  Else
    MsgBox "Error : " & err.Description, vbOKOnly + vbCritical
  End If
  Unload Me
  Exit Sub
End Sub
Private Sub Form_Unload(Cancel As Integer)

   '' LimpiarData
    Set objMensajesTB = Nothing
    
    Call LogAuditoria("08", OptLocal, Me.Caption, "", "")
End Sub

Private Sub TablaCod_FetchAttributes(Status As Integer, Split As Integer, Row As Long, Col As Integer, FgColor As Long, BgColor As Long, FontStyle As Integer)
'   If Col = TablaCod.ColumnIndex And Row = TablaCod.RowIndex Then
'        FgColor = BacToolTip.Color_Dest.ForeColor
'        BgColor = BacToolTip.Color_Dest.BackColor
'    Else
'        FgColor = BacToolTip.Color_Normal.ForeColor
'        BgColor = BacToolTip.Color_Normal.BackColor
 '   End If
End Sub

Private Sub TablaCod_KeyDown(KeyCode As Integer, Shift As Integer)

If KeyCode = 45 Then
            
            cmdAgregar_Click
   End If
End Sub

Private Sub TablaCod_KeyPress(KeyAscii As Integer)

'   If KeyAscii% = vbKeyReturn Then
'        KeyAscii% = 0
'        SendKeys "{RIGHT}"
'
'   ElseIf TablaCod.ColumnIndex = 1 Then 'Codigo
'        BacToUCase KeyAscii
'   ElseIf TablaCod.ColumnIndex = 2 Then 'Tasa
'        KeyAscii = BacPunto(TablaCod, KeyAscii, 3, 6)
'
'   ElseIf TablaCod.ColumnIndex = 3 Then 'Fecha
'        If Not IsNumeric(Chr$(KeyAscii)) And Chr(KeyAscii) <> "/" And (KeyAscii <> 13 And KeyAscii <> 8) Then
'            KeyAscii = 0
'        End If
'   ElseIf TablaCod.ColumnIndex = 4 Then 'Valor
'        KeyAscii = BacPunto(TablaCod, KeyAscii, 10, 4)
'   ElseIf TablaCod.ColumnIndex = 5 Then 'Glosa
'        BacToUCase KeyAscii
'   End If

End Sub

Function Consulta_Categoria() As Boolean

Dim Dato7 As String
Dim Sql As String
Dim Datos()
Dim fecha As String
Dim Hay As Integer
Hay = 0

Existe = False
Consulta_Categoria = False
      
   
   'Sql = "execute sp_mdctleercat " & Trim(txtNCategoria.Text)
   Envia = Array()
   AddParam Envia, Trim(txtNCategoria.Text)
   
   If Not BAC_SQL_EXECUTE("sp_mdctleercat ", Envia) Then
           Exit Function
   End If
   
   If BAC_SQL_FETCH(Datos()) Then
        Hay = 1
        txtDesCategoria.Text = Trim(Datos(2))
  End If
  
  If Hay = 0 Then Exit Function
  
    
    Envia = Array()
    AddParam Envia, Trim(txtNCategoria.Text)
    
    If Not BAC_SQL_EXECUTE("sp_leetabla ", Envia) Then
           Exit Function
    End If
    
  ''  LimpiarData
    
    
 With Grilla
       .Rows = 2
        Call F_BacLimpiaGrilla(Grilla)
    
     Do While BAC_SQL_FETCH(Datos())
        .Row = .Rows - 1
        
        .TextMatrix(.Row, 0) = Trim(Datos(1)) 'CODIGO
        .TextMatrix(.Row, 1) = CDbl(Datos(2))  'TASA
        .TextMatrix(.Row, 2) = Format(Datos(3), "dd/mm/yyyy") 'FECHA
        .TextMatrix(.Row, 3) = CDbl(Datos(4))   'VALOR
        .TextMatrix(.Row, 4) = Trim(Datos(5))
        
    '    If .Row - 1 <> 0 And (Len(.TextMatrix(.Row, 4)) > Len(.TextMatrix(.Row - 1, 4))) Then
    '        .ColWidth(4) = TextWidth(.TextMatrix(.Row, 4)) + 1500
    '       ' .ColAlignment(4) = 2    'IZQUIERDA ABAJO
    '    End If
        
        .Rows = .Rows + 1
         Existe = True
        
        
''        Data1.Recordset.AddNew
''        Data1.Recordset!tbcodigo = Trim(Datos(1))
''        Data1.Recordset!tbtasa = CDBL(Datos(2))
''        Data1.Recordset!tbfecha = Format(Datos(3), "dd/mm/yyyy")
''        Data1.Recordset!tbvalor = CDBL(Datos(4))
''        Data1.Recordset!tbglosa = Trim(Datos(5))
''        'Dato7 = UCase(Trim(Datos(7)))
''        Data1.Recordset.Update
    Loop
      
  ''  Data1.Refresh

    Consulta_Categoria = True

 'Call BacAgrandaGrilla(Grilla, 40)
   
   
''Me.Refresh

End With

End Function


Private Sub TablaCod_Validate(Row As Long, Col As Integer, Value As String, Cancel As Integer)

If Col = 3 Then
    If Not IsDate(Value) Then
        Value = "01/01/1900"
'       Cancel = True
    End If
End If
End Sub

Private Sub Grilla_DblClick()
 Call Grilla_KeyPress(vbKeyReturn)
End Sub

Private Sub Grilla_KeyPress(KeyAscii As Integer)

Call TxtVolatil

With Grilla
   
   If (.Col = 0 Or .Col = 1) Then         '*** CODIGO / TASA
      
      If .Col = 1 And Trim(.TextMatrix(.Row, 0)) = "" Then Exit Sub
      
      If .Rows - 1 = .Row Then .Rows = .Rows + 1
      
         If (KeyAscii = vbKeyReturn Or KeyAscii = 8 Or IsNumeric(Chr(KeyAscii))) Then
            If .Col = 0 Then txtCodigo.MaxLength = 6
            If .Col = 1 Then txtCodigo.MaxLength = 3
            .Enabled = False: txtCodigo.Visible = True
            If IsNumeric(Chr(KeyAscii)) Then
               txtCodigo.Text = Chr(KeyAscii)
               SendKeys "{RIGHT 1}"
            Else
               If .Col = 0 Then txtCodigo.Text = .TextMatrix(.Row, 0)
               If .Col = 1 Then txtCodigo.Text = .TextMatrix(.Row, 1)
            End If
            PROC_POSICIONA_TEXTOX Grilla, txtCodigo
            txtCodigo.SetFocus
            Exit Sub
         End If
   End If
    
   If .Col = 2 Then '******* FECHA
      If Trim$(.TextMatrix(.Row, 0)) = "" Then Exit Sub
      If KeyAscii = vbKeyReturn Then
         .Enabled = False: TxtFecha.Visible = True
         If Trim$(.TextMatrix(.Row, 2)) = "" Then .TextMatrix(.Row, 2) = CDate(Date)
         TxtFecha.Text = Format(.TextMatrix(.Row, 2), "dd/mm/yyyy")
         PROC_POSICIONA_TEXTOX Grilla, TxtFecha
         TxtFecha.SetFocus
         SendKeys "{RIGHT}"
      End If
   End If
    
   If .Col = 3 Then       '************** VALOR
      If Trim$(.TextMatrix(.Row, 0)) = "" Then Exit Sub
      If KeyAscii = vbKeyReturn Then
         .Enabled = False: TxtValor.Visible = True
         If IsNumeric(Chr(KeyAscii)) Then
            TxtValor.Text = Chr(KeyAscii)
         Else
            TxtValor.Text = .TextMatrix(.Row, 3)
         End If
         PROC_POSICIONA_TEXTOX Grilla, TxtValor
         TxtValor.SetFocus
         SendKeys "{RIGHT}"
         
      End If
   End If
    
   If .Col = 4 Then             '******* glosa
      If Trim$(.TextMatrix(.Row, 0)) = "" Then Exit Sub
      If KeyAscii = vbKeyReturn Then
         .Enabled = False
         TxtGlosa.Visible = True
         PROC_POSICIONA_TEXTOX Grilla, TxtGlosa
         TxtGlosa.Text = .TextMatrix(.Row, 4)
         TxtGlosa.SetFocus
         SendKeys "{RIGHT}"
         
      End If
   End If
   
End With
         
End Sub

Sub MoverPuntero()
With Grilla
   If .Col = .Cols - 1 Then
      .Col = 0
      If .Row = .Rows - 1 Then
         .Row = 0: .Col = 0
      Else
         .Row = .Row + 1
         If .Text = "" Then .Row = 1
      End If
   Else
      .Col = .Col + 1
   End If
End With
End Sub



Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Index
    Case 1
        Dim Termino As Boolean
Dim Sql As String
Dim Datos()
Dim NumReg As Double
Dim Tot As Double

Screen.MousePointer = 11

' If ValidaReg = False Then
'    Screen.MousePointer = 0
'    Exit Sub
' End If


   If Grabar_SQL Then
       Screen.MousePointer = 0
       MsgBox "Operación  se realizó con exito", vbInformation
 
   Else
       Screen.MousePointer = 0
       MsgBox "Operación NO se realizó con exito", vbCritical
    End If
    
  Call TxtVolatil
    Case 2
         txtCodigo = "": txtCodigo.Visible = False

If Trim(Grilla.TextMatrix(Grilla.Row, 0)) = "" Then
       Exit Sub
End If



If MsgBox("Esta Seguro de Eliminar este elemento", 36) = 6 Then
    
    ''If Elimina_Fox Then
        
        If Elimina_Sql Then
             'DB.Execute "delete * from tabgen where tbcodigo = """ & Trim(data1.Recordset!TBCodigo) & """"
             Consulta_Categoria
             MsgBox "Eliminación se realizó con exito", vbInformation
        Else
            MsgBox "Eliminación no se realizó con exito", vbInformation
        End If
        
   '' Else
   ''      MsgBox "Eliminación no se realizó con exito", vbInformation, gsBac_Version
    ''End If
 End If
    Case 3
        With Grilla
    
     .Rows = 2
     Call F_BacLimpiaGrilla(Grilla)
     'Call BacAgrandaGrilla(Grilla, 40)
    .Enabled = False
    Call TxtVolatil
    Call Limpiar
    HabilitarControles False
    txtNCategoria.SetFocus

End With
    Case 4
        Unload Me
    Case 5
            Dim Fila As Integer
Dim Entro As Integer

Entro = 0
txtCodigo = "": txtCodigo.Visible = False

Toolbar1.Buttons(5).Enabled = False

 With Grilla
    
   .Enabled = True
     For Fila = 1 To .Rows - 1
        .Row = Fila
       If Trim(.TextMatrix(.Row, 0)) = "" Then
                 .Col = 0
                 .SetFocus
                 .TextMatrix(.Row, 0) = "" 'codigo
                 .TextMatrix(.Row, 1) = "0" 'tasa
                 .TextMatrix(.Row, 2) = CDate(Date) 'fecha
                 Entro = 1
                 Exit Sub
       End If
    Next Fila
    
    
    If Entro = 0 Then ' no entro
       .Rows = .Rows + 1
       .Col = 0
       .SetFocus
    End If
   End With
   Toolbar1.Buttons(3).Enabled = True
End Select
End Sub

Private Sub txtCodigo_KeyPress(KeyAscii As Integer)
With Grilla
   Select Case .Col
      Case 0
      '===============
         If KeyAscii = vbKeyReturn Then
               If Trim$(.TextMatrix(.Row, 0)) <> "" And Trim(.TextMatrix(.Row, 1)) <> "" Then
                  If Trim(txtCodigo.Text) = "" Then
                     MsgBox "No se puede dejar el codigo sin Valor ", vbCritical
                     If Trim$(.TextMatrix(.Row, 0)) <> "" Then
                        txtCodigo.Text = .TextMatrix(.Row, 0)
                        txtCodigo = "": txtCodigo.Visible = False
                        .Enabled = True: .Col = 0
                        .SetFocus: KeyAscii = 0
                        Exit Sub
                     End If
                  End If
               Else
                  If Trim$(txtCodigo.Text) = "" Then
                     .TextMatrix(.Row, 0) = ""
                     txtCodigo = "": txtCodigo.Visible = False
                     .Enabled = True: .Col = 0
                     .SetFocus: KeyAscii = 0
                     Exit Sub
                  End If
               End If
              ' No esta repetido
              If F_BuscaRepetidoGrilla(.Col, Grilla, Trim(Val(.Text))) = False Then
               'If F_BuscaRepetidoGrilla(0, GRILLA, CDBL(Trim(Txtcodigo.Text))) = False Then
                  .TextMatrix(.Row, 0) = txtCodigo.Text
                  txtCodigo = "": txtCodigo.Visible = False
                  .Enabled = True: .Col = 0
                  .SetFocus: KeyAscii = 0
                  If Trim$(.TextMatrix(.Row, 1)) = "" And Trim(.TextMatrix(.Row, 2)) = "" Then
                     .TextMatrix(.Row, 1) = "0" 'tasa
                     .TextMatrix(.Row, 2) = CDate(Date) 'fecha
                  End If
                  Call MoverPuntero
                  Exit Sub
               End If
              ' Esta repetido
                txtCodigo.SetFocus
         ElseIf KeyAscii = vbKeyEscape Then
               ' No ingreso nada o borro and habia algo
               If Trim(txtCodigo.Text) = "" And Trim(.TextMatrix(.Row, 0)) <> "" Then
                  MsgBox "Debe Ingresar Algun Valor ", vbCritical
                  Exit Sub
               End If
               txtCodigo = "": txtCodigo.Visible = False
               .Enabled = True: .Col = 0: .SetFocus
               Exit Sub
        End If
      
      Case 1
      '================
         If KeyAscii = vbKeyReturn Then
            If Trim$(txtCodigo.Text) = "" Then txtCodigo.Text = 0
               .TextMatrix(.Row, 1) = txtCodigo.Text
               txtCodigo = "": txtCodigo.Visible = False
               .Enabled = True
               .Col = 1: .SetFocus
            ElseIf KeyAscii = vbKeyEscape Then
            txtCodigo = "": txtCodigo.Visible = False
            .Enabled = True: .SetFocus
         End If
      Call MoverPuntero
   End Select
        BacCaracterNumerico KeyAscii
        'MsgBox .Col
        
End With
End Sub

Private Sub TxtFecha_KeyPress(KeyAscii As Integer)

TxtFecha.SelLength = 1

With Grilla
   If KeyAscii = vbKeyReturn Then
      If Not IsDate(TxtFecha.Text) Then
         MsgBox "Fecha Invalida.", vbCritical
      Else
         If KeyAscii = vbKeyReturn Then
            .TextMatrix(.Row, 2) = Format(TxtFecha.Text, "dd/mm/yyyy")
            TxtFecha.Visible = False
            .Enabled = True: .Col = 2
            .SetFocus: KeyAscii = 0
            Call MoverPuntero
         ElseIf KeyAscii = vbKeyEscape Then
               If Trim$(TxtFecha.Text) = "" Then TxtFecha.Text = CDate(Date)
               TxtFecha.Visible = False
               .Enabled = True: .Col = 2: .SetFocus
         End If
      End If
   End If
End With



'With GRILLA
'
'         If KeyAscii = vbKeyReturn Then
'            If Trim$(TxtFecha.Text) = "" Then TxtFecha.Text = CDate(Date)
'            .TextMatrix(.Row, 2) = TxtFecha.Text
'             TxtFecha.Visible = False
'            .Enabled = True: .Col = 2
'            .SetFocus: KeyAscii = 0
'
'         ElseIf KeyAscii = vbKeyEscape Then
'            If Trim$(TxtFecha.Text) = "" Then TxtFecha.Text = CDate(Date)
'             TxtFecha.Visible = False
'             .Enabled = True: .Col = 2: .SetFocus
'         End If
'End With

End Sub

Private Sub txtFecha1_KeyPress(KeyAscii As Integer)
'
'With Grilla
'
'    BacCaracterNumerico KeyAscii
'
'            If KeyAscii = vbKeyReturn Then
'
'            '.TextMatrix(.Row, 2) = ""
'
'            If IsDate(Trim(TxtFecha.Text)) Then
'                .TextMatrix(.Row, 2) = Format(CDate(TxtFecha.Text), "dd/mm/yyyy")
'            Else
'               MsgBox "Fecha es Erronea", vbCritical, gsBac_Version
'               Exit Sub
'           End If
'
'               TxtFecha.Visible = False: .Enabled = True
'               .Col = 2: .SetFocus
'               KeyAscii = 0: cmdAgregar.Tag = "No"
'               Exit Sub
'        End If
'             TxtFecha.SetFocus
'
'       If KeyAscii = 27 Then
'             TxtFecha.Text = "": TxtFecha.Visible = False
'            .Enabled = True: .SetFocus
'             cmdAgregar.Tag = "No"
'             Exit Sub
'       End If
'
'  ElseIf .Col = 4 Then
'
'              If KeyAscii = 13 Then
'                .TextMatrix(.Row, 4) = TxtFecha.Text
'                 TxtFecha.Visible = False
'                .Enabled = True
'                .Col = 4
'                .SetFocus
'                 KeyAscii = 0
'              ElseIf KeyAscii = 27 Then
'                 TxtFecha.Text = ""
'                 TxtFecha.Visible = False
'                 .Enabled = True
'                 .SetFocus
'              End If
'
'     End If
'  End If
'  End If
'  End With
'
'
'

End Sub

Private Sub Txtglosa_KeyPress(KeyAscii As Integer)

    With Grilla
   
        If KeyAscii = 13 Then
             .TextMatrix(.Row, 4) = TxtGlosa.Text
              TxtGlosa.Visible = False
             .Enabled = True: .Col = 4
             .SetFocus: KeyAscii = 0
              Toolbar1.Buttons(5).Tag = "No"
              Call MoverPuntero
              Exit Sub
        End If
                          
        If KeyAscii = 27 Then
              TxtGlosa.Text = ""
              TxtGlosa.Visible = False
              .Enabled = True
              .SetFocus
              Toolbar1.Buttons(5).Tag = "No"
              Exit Sub
         End If
     
  End With

End Sub


Sub NCateg()
   BacControlWindows 100
   MiTag = "MDCT"
   BacAyuda.Show 1
   If giAceptar% = True Then
       txtNCategoria.Text = CDbl(gsCodigo$)
       txtDesCategoria.Text = Trim(gsGlosa$)
       HabilitarControles True
       txtNCategoria_LostFocus
   End If
End Sub


Private Sub txtNCategoria_DblClick()
   Call NCateg
End Sub

Private Sub txtNCategoria_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyF3 Then Call NCateg
End Sub

Private Sub txtNCategoria_KeyPress(KeyAscii As Integer)
 

    BacCaracterNumerico KeyAscii
    
    If KeyAscii = 13 Then
       SendKeys "{TAB}"
       Call MoverPuntero
    End If
     
 
 
 ''If KeyAscii% = vbKeyReturn Then
 ''     KeyAscii% = 0
 ''ElseIf Not ((KeyAscii > 47 And KeyAscii < 58) Or KeyAscii = 8) Then
  ''    KeyAscii = 0
 ''End If
     
 ''  BacCaracterNumerico KeyAscii
End Sub

Private Sub txtNCategoria_LostFocus()
  Dim IdNumero     As Integer
   
 With Grilla
 
 If Trim(txtNCategoria.Text) <> "" Then
 
     IdNumero = txtNCategoria.Text
        
    If Consulta_Categoria Then
        If Existe = False Then
            Call HabilitarControles(True)
            .Col = 0: .Row = 1
            .SetFocus
            Toolbar1.Buttons(3).Enabled = False
        Else
            .Enabled = True
            .Col = 0: .Row = 1
            .SetFocus
            Toolbar1.Buttons(3).Enabled = True
            Call HabilitarControles(True)
        End If
   
         
    Else
          Screen.MousePointer = 0
         MsgBox "Esta categoría no existe", vbCritical
          
           Call Limpiar
           Call HabilitarControles(False)
           txtNCategoria.SetFocus
   End If
 
 Screen.MousePointer = 0
 
End If

End With
End Sub

Public Function CargarParam_Vm(Grillas As Object)

With Grillas
          
          .RowHeight(0) = 340
          .CellFontWidth = 4
          .Row = 0
         
         .Col = 0: .FixedAlignment(0) = 4
         .CellFontBold = True
         .TextMatrix(.Row, 0) = "  Codigo "
         .ColWidth(0) = TextWidth(.TextMatrix(.Row, 0)) + 300
         .ColAlignment(0) = 8     ' derecha abajo

         .Col = 1: .FixedAlignment(1) = 4
         .CellFontBold = True
         .TextMatrix(.Row, 1) = "     Tasa     "
         .ColWidth(1) = TextWidth(.TextMatrix(.Row, 1)) + 300
         .ColAlignment(1) = 8

         .Col = 2: .FixedAlignment(2) = 4
         .CellFontBold = True
         .TextMatrix(.Row, 2) = "      Fecha      "
         .ColWidth(2) = TextWidth(.TextMatrix(.Row, 2)) + 300
         .ColAlignment(2) = 8

         .Col = 3: .FixedAlignment(3) = 4
         .CellFontBold = True
         .TextMatrix(.Row, 3) = "        Valor        "
         .ColWidth(3) = TextWidth(.TextMatrix(.Row, 3)) + 300
         .ColAlignment(3) = 8

         .Col = 4: .FixedAlignment(4) = 4
         .CellFontBold = True
         .TextMatrix(.Row, 4) = "                         Glosa                           "
         .ColWidth(4) = TextWidth(.TextMatrix(.Row, 4)) + 1700
         .ColAlignment(4) = 2    'IZQUIERDA ABAJO
         
         
End With

End Function

Private Sub TXTNumerico_KeyPress(KeyAscii As Integer)

End Sub

Private Sub txtNumerico_NumeroInvalido()

End Sub

Private Sub TxtValor_KeyPress(KeyAscii As Integer)

With Grilla
   
   If KeyAscii = 13 Then
      If CDbl(TxtValor) = 0 Then
         .TextMatrix(.Row, 3) = 0
      Else
         .TextMatrix(.Row, 3) = Format(TxtValor, "###,###,###,###.###0")
      End If
   TxtValor.Visible = False
   .Enabled = True: .Col = 3
   .SetFocus: KeyAscii = 0
   Toolbar1.Buttons(5).Tag = "No"
   Call MoverPuntero
   Exit Sub
   End If
   
   If KeyAscii = 27 Then
      TxtValor.Text = ""
      TxtValor.Visible = False
      .Enabled = True
      .SetFocus
      Toolbar1.Buttons(5).Tag = "No"
      Exit Sub
   End If
     
  End With

End Sub

Public Sub TxtVolatil()

Dim algo As String

On Error GoTo ErrEli

  
  txtCodigo.Text = "": txtCodigo.Visible = False
  TxtFecha.PromptInclude = False
  TxtFecha.Text = CDate(Date): TxtFecha.Visible = False
  TxtFecha.PromptInclude = True
  TxtValor.Text = "": TxtValor.Visible = False
  TxtGlosa.Text = "": TxtGlosa.Visible = False
  Exit Sub
ErrEli:
  
     MsgBox "Hay un ERROR menor ", vbCritical
     
     
  
Exit Sub



End Sub
