VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form BacManPVenc 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantencion Pago Vencimiento"
   ClientHeight    =   4020
   ClientLeft      =   2040
   ClientTop       =   2610
   ClientWidth     =   11910
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   4020
   ScaleWidth      =   11910
   Begin VB.ComboBox cmbPagos 
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
      Left            =   7200
      Style           =   2  'Dropdown List
      TabIndex        =   2
      Top             =   720
      Width           =   2835
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   8760
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
            Picture         =   "BacManPVenc.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacManPVenc.frx":0452
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacManPVenc.frx":08A4
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   11910
      _ExtentX        =   21008
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      DisabledImageList=   "ImageList1"
      HotImageList    =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Description     =   "GRABAR"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmbsalir"
            Description     =   "Salir"
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin MSFlexGridLib.MSFlexGrid Grd 
      Height          =   3375
      Left            =   0
      TabIndex        =   1
      Top             =   600
      Width           =   11880
      _ExtentX        =   20955
      _ExtentY        =   5953
      _Version        =   393216
      Cols            =   7
      FixedCols       =   0
      RowHeightMin    =   280
      BackColor       =   12632256
      ForeColor       =   12582912
      BackColorFixed  =   8421376
      ForeColorFixed  =   16777215
      BackColorBkg    =   12632256
      WordWrap        =   -1  'True
      FocusRect       =   0
      GridLines       =   2
      ScrollBars      =   2
   End
End
Attribute VB_Name = "BacManPVenc"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim Datos()
Dim Fila, Columna, Cont As Double

'llena las cabeceras de la grilla
Sub define_cabeceras()
'inicio bloque with con la grilla
    With Grd
  
        'asigno titulos a las cabeceras
        .TextMatrix(0, 0) = "Operación"
        .TextMatrix(0, 1) = "Tipo Operación"
        .TextMatrix(0, 2) = "Nombre Cliente"
        .TextMatrix(0, 3) = "Forma Pago Vencimiento"
        .TextMatrix(0, 4) = "Codigo"
        .TextMatrix(0, 6) = "Total Operación"
        'defino el alto y ancho de las celdas
        .RowHeight(0) = 300
        .ColWidth(0) = 900
        .ColWidth(1) = 1800
        .ColWidth(2) = 3600
        .ColWidth(3) = 2800
        .ColWidth(4) = 700
        .ColWidth(5) = 0   'Ocluta la Columna de Modificacion S/N
        .ColWidth(6) = 1700
          
        'defino el color para las celdas
        .BackColorFixed = &H808000
        .ForeColorFixed = &HFFFFFF
    
    End With
End Sub
Private Sub cmbPagos_Click()
    Combo_Pagos_Visible False
                
    Modifica_Datos_Grilla
        
End Sub

Private Sub cmbPagos_LostFocus()
    Combo_Pagos_Visible False
End Sub
Private Sub Form_Click()
    Combo_Pagos_Visible False
End Sub

Private Sub Form_Load()
    
    Me.Left = 0
    Me.Top = 0

    cmbPagos.Visible = False
    
    define_cabeceras
    
    Llena_Grilla
    
    Llenar_Combo_Pagos
  

End Sub

Private Sub Grd_Click()
    Combo_Pagos_Visible False
End Sub
Private Sub Grd_DblClick()
               
    If Grd.Col = 3 Then
        
        Fila = Grd.Row
        Columna = Grd.Col
        
        cmbPagos.Left = 6350
        cmbPagos.Top = Grd.CellTop + 600
        Combo_Pagos_Visible True
    
    End If
End Sub

Private Sub Grd_Scroll()
Combo_Pagos_Visible False
End Sub

Private Sub Grd_SelChange()
Combo_Pagos_Visible False
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

'consulto por el boton presionado
Select Case UCase(Button.Description)
    Case "GRABAR"
        Grabar_Grilla
    Case "SALIR"
        Unload Me
    
    End Select
End Sub

Sub Llena_Grilla()

    
    If Not Bac_Sql_Execute("SP_TRAE_PV") Then
        MsgBox "Problemas con la transaccion SQL", vbCritical
    End If
          
    Cont = 0
    
    With Grd
                
        Do While Bac_SQL_Fetch(Datos())
            
            .Row = .Rows - 1
            .Col = 0: .Text = Datos(1)
            
                If Datos(2) = "RC" Then
                    
                    .Col = 1: .Text = "ReCompra"
                ElseIf Datos(2) = "RV" Then
                    .Col = 1: .Text = "ReVenta"
                ElseIf Datos(2) = "VC" Then
                    
                    If Datos(7) = "ICAP" Then
                        .Col = 1: .Text = "Vencimiento Captacion"
                    ElseIf Datos(7) = "ICOL" Then
                        .Col = 1: .Text = "Vencimiento Colocacion"
                    Else
                     .Col = 1: .Text = "Vencimiento"
                    End If
                    
                End If
                
            .Col = 2: .Text = Datos(5)
            .Col = 3: .Text = Datos(4)
            .Col = 4: .Text = Datos(6)
            
            'Modificado s/n
            .Col = 5: .Text = "N"
            .Col = 6: .Text = Format(Val(Datos(8)), "###,###0.000")
            '.Col = 6: .Text = Datos(8)
                                   
            .Rows = .Rows + 1
                            
        Loop
         If .Rows <> 2 Then
           .RemoveItem (.Rows)
        End If
    End With
    
    
End Sub

Sub Llenar_Combo_Pagos()

    If Bac_Sql_Execute("select * from view_forma_de_pago") Then
                 
        Do While Bac_SQL_Fetch(Datos())
           
           'FILTRO POR = "N"
           cmbPagos.AddItem Datos(1) & " " & Datos(2)
        
        Loop
    
    Else
       MsgBox "Error al cargar Forma de Pagos.", vbCritical
    End If
       
End Sub
Sub Combo_Pagos_Visible(Valor As Boolean)
    cmbPagos.Visible = Valor
End Sub
Sub Modifica_Datos_Grilla()
Dim Busqueda As String
       
    Busqueda = "SP_BUSCAR_FORMAPAGO " & Trim(Left(cmbPagos.Text, 2))
    
    Grd.TextMatrix(Fila, Columna) = Trim(Mid(cmbPagos.Text, 3, Len(cmbPagos.Text)))
    
With Grd

    If Bac_Sql_Execute(Busqueda) Then
       Do While Bac_SQL_Fetch(Datos())
            .TextMatrix(Fila, 4) = Datos(2)
            
            .Col = 5: .Text = "S"
            
       Loop
    Else
        MsgBox "Error al cargar Forma de Pagos.", vbCritical
    End If

End With

End Sub

Sub Grabar_Grilla()
Dim NumOper, CodForPag As Double
Dim TipOper, NomCli, ForPag As String
Dim Grabar_OP As Boolean

Cont = 0
With Grd

Do Until Cont = Grd.Rows
        
    Select Case .TextMatrix(Cont, 5)
      
        Case "S"
            
            Numoper = .TextMatrix(Cont, 0)
                
                If .TextMatrix(Cont, 1) = "ReCompra" Then
                    TipOper = "RC"
                ElseIf .TextMatrix(Cont, 1) = "Vencimiento Captacion" Or .TextMatrix(Cont, 1) = "Vencimiento Colocacion" Then
                    TipOper = "VC"
                End If
                
            NomCli = .TextMatrix(Cont, 2)
            ForPag = .TextMatrix(Cont, 3)
            CodForPag = .TextMatrix(Cont, 4)
            
            'MsgBox Cont & "   " & NumOper & "   " & TipOper & "   " & NomCli & "   " & ForPag & "   " & CodForPag
            
            Envia = Array()
            AddParam Envia, CDbl(NumOper)
            AddParam Envia, TipOper
            AddParam Envia, CodForPag
                        
            'ejecuta el procedure atravez de la intefaz de bac
            If Bac_Sql_Execute("SP_CAMBIA_FORMA_PV", Envia) Then
            
               Grabar_OP = True
                                
            Else
                               
               Grabar_OP = False
                               
            End If
            
        End Select
    
    Cont = Cont + 1

Loop

 If Grabar_OP Then
    MsgBox "Los datos se Grabaron Exitosamente.", vbOKOnly
 Else
    MsgBox "Error inesperado. No se pudieron grabar los datos, o los datos no fueron modificados.", vbCritical
 End If
 
End With

End Sub
