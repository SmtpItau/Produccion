VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form BacDescTGen 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Descripcion de Tablas Generales"
   ClientHeight    =   2250
   ClientLeft      =   45
   ClientTop       =   375
   ClientWidth     =   6780
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   2250
   ScaleWidth      =   6780
   Begin MSFlexGridLib.MSFlexGrid grilla 
      Height          =   2250
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   6780
      _ExtentX        =   11959
      _ExtentY        =   3969
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
End
Attribute VB_Name = "BacDescTGen"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public ValorCambiado As Integer

Private Sub Form_Load()
Dim Valor As Integer
Dim i As Integer
    
    i = 1
    Valor = BacMntTb.Grid.TextMatrix(BacMntTb.Grid.Row, 3)
    
    Call BacIniciaGrilla(2, 3, 1, 0, False, grilla)
    Limpiar_Grilla
    
    If Not Bac_Sql_Execute("SP_BUSCA_GENERAL_DETALLE") Then
        Exit Sub
    End If

    Do While Bac_SQL_Fetch(Datos())
        grilla.Rows = i + 1
        grilla.Row = i
        
        If Valor = Datos(2) Then
            grilla.Col = 0
            grilla.CellBackColor = &H800000
            grilla.CellForeColor = &H8000000F
            grilla.Col = 1
            grilla.CellBackColor = &H800000
            grilla.CellForeColor = &H8000000F
            grilla.Col = 2
            grilla.CellBackColor = &H800000
            grilla.CellForeColor = &H8000000F
            
        End If
            
        grilla.TextMatrix(i, 0) = Datos(2)
        grilla.TextMatrix(i, 1) = Datos(7)
        grilla.TextMatrix(i, 2) = Datos(6)
      
        i = i + 1
    Loop
    
    grilla.Row = Valor
    grilla.Col = 0

End Sub

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
        .ColWidth(1) = 1500
        .ColWidth(2) = 4000
         
        .Row = 0

        .Col = 0
        .CellFontBold = True       'RESALSE
        .FixedAlignment(0) = 4
        .Text = "   Codigo "

        .Col = 1
        .CellFontBold = True       'RESALSE
        .FixedAlignment(1) = 4
        .Text = " Descripcion  "
        
        .Col = 2
        .CellFontBold = True       'RESALSE
        .FixedAlignment(2) = 4
        .Text = " Glosa  "
        
    End With

End Function

Private Sub grilla_DblClick()
    ValorCambiado = grilla.TextMatrix(grilla.Row, 0)
    BacMntTb.CambiaGeneralDetalle
    Unload Me
End Sub


