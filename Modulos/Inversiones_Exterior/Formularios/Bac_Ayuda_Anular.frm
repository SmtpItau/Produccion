VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form Bac_Ayuda_Anular 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Operaciones a Anular"
   ClientHeight    =   4260
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   6270
   ClipControls    =   0   'False
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4260
   ScaleWidth      =   6270
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   Begin MSFlexGridLib.MSFlexGrid Grilla 
      Height          =   3705
      Left            =   30
      TabIndex        =   1
      Top             =   540
      Width           =   6225
      _ExtentX        =   10980
      _ExtentY        =   6535
      _Version        =   393216
      FixedCols       =   0
      BackColor       =   14737632
      BackColorFixed  =   8421376
      ForeColorFixed  =   16777215
      BackColorBkg    =   8421376
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Height          =   510
      Left            =   30
      TabIndex        =   0
      Top             =   0
      Width           =   6210
      _ExtentX        =   10954
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
            Key             =   "cmbaceptar"
            Description     =   "ACEPTAR"
            Object.ToolTipText     =   "Aceptar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmbcancelar"
            Description     =   "CANCELAR"
            Object.ToolTipText     =   "Cancelar"
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   1740
      Top             =   630
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
            Picture         =   "Bac_Ayuda_Anular.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bac_Ayuda_Anular.frx":0452
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "Bac_Ayuda_Anular"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub Form_Load()
    Dim tipoOpe As String
    tipoOpe = opcion_filtrado
    If Trim(tipoOpe) = "" Then
        MsgBox "No ha seleccionado el Tipo de Operación!", vbExclamation, gsBac_Version
        Unload Me
        Exit Sub
    End If

    Call dibuja_grilla
    Select Case tipoOpe
        Case "I"
            Call BuscaOperacionesIntraMesas
        Case "N"
    Call BuscaOperaciones
    End Select
'    Call BuscaOperaciones
'    Call BuscaOperacionesIntraMesas

End Sub
Sub dibuja_grilla()

    grilla.Rows = grilla.FixedRows
    grilla.Cols = 6    '10 JBH, 17-12-2009
    grilla.TextMatrix(0, 0) = "Tipo"
    grilla.TextMatrix(0, 1) = "Operación"
    grilla.TextMatrix(0, 2) = "Cliente"
    grilla.TextMatrix(0, 3) = "Fecha Pago" '
    grilla.ColWidth(0) = 1000
    grilla.ColWidth(1) = 1000
    grilla.ColWidth(2) = 2800
    grilla.ColWidth(3) = 1000
    grilla.ColWidth(4) = 0
    
    grilla.ColWidth(5) = 0
'    grilla.ColWidth(6) = 0
'    grilla.ColWidth(7) = 0
'    grilla.ColWidth(8) = 0
'    grilla.ColWidth(9) = 0
        
End Sub

Sub BuscaOperaciones()
    
    Dim Sql
    Dim Datos
    Dim i
    
    If Bac_Sql_Execute("SVC_AYU_ANU") Then
    
        Do While Bac_SQL_Fetch(Datos)
            grilla.Rows = grilla.Rows + 1
            grilla.TextMatrix(grilla.Rows - 1, 0) = Datos(4)
            grilla.TextMatrix(grilla.Rows - 1, 1) = Datos(7)
            
            grilla.TextMatrix(grilla.Rows - 1, 2) = Datos(1)
            
            grilla.TextMatrix(grilla.Rows - 1, 3) = Format(Datos(6), "DD/MM/YYYY")
            
            
            
            'Grilla.TextMatrix(Grilla.Rows - 1, 4) = Format(CDbl(Datos(3)), "##,###,###,###,##0.0000")
            'Grilla.TextMatrix(Grilla.Rows - 1, 5) = Format(CDbl(Datos(4)), "#0.0000")
            'Grilla.TextMatrix(Grilla.Rows - 1, 6) = Datos(10)
            'Grilla.TextMatrix(Grilla.Rows - 1, 7) = Datos(5)
            'grilla.TextMatrix(grilla.Rows - 1, 8) =
            'grilla.TextMatrix(0, 9) =
                        
        Loop
        
    End If

End Sub
Sub BuscaOperacionesIntraMesas()
'
'JBH, Obtiene lista de operaciones Intramesas anulables
'
    Dim Sql
    Dim datos
    Dim i
    
    If Bac_Sql_Execute("SVC_AYU_ANU_IM") Then
    
        Do While Bac_SQL_Fetch(datos)
            Grilla.Rows = Grilla.Rows + 1
            Grilla.TextMatrix(Grilla.Rows - 1, 0) = datos(4)
            Grilla.TextMatrix(Grilla.Rows - 1, 1) = datos(7)
            
            'JBH, 01-12-2009
            If IsNull(datos(1)) Then
                grilla.TextMatrix(grilla.Rows - 1, 2) = ""
            Else
            Grilla.TextMatrix(Grilla.Rows - 1, 2) = datos(1)
            End If
            
            'grilla.TextMatrix(grilla.Rows - 1, 2) = datos(1)
            'JBH, fin
            
            Grilla.TextMatrix(Grilla.Rows - 1, 3) = Format(datos(6), "DD/MM/YYYY")
            
            'Operacion Relacionada, JBH, 17-12-2009
            grilla.TextMatrix(grilla.Rows - 1, 5) = datos(8) 'JBH, 17-12-2009
                        
        Loop
        
    End If

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

    Select Case Button.Index
        Case 1
            If grilla.Row = 0 Then Exit Sub
            
            giAceptar% = True
            Num_Docu = grilla.TextMatrix(grilla.Row, 1)
            
            'JBH, 17-12-2009, SOLO PARA OPERACIONES INTRAMESAS
            If opcion_filtrado = "I" Then
                Num_Relac = grilla.TextMatrix(grilla.row, 5)
            End If
            'fin JBH
            
            Unload Me
            
        Case 2
            giAceptar% = False  'JBH, 04-12-2009
            Unload Me
    
    End Select
    

End Sub
