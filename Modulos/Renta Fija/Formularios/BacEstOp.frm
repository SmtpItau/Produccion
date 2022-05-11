VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form BacEstOp 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Operaciones Pendientes de Aprobación"
   ClientHeight    =   3810
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   9585
   Icon            =   "BacEstOp.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   3810
   ScaleWidth      =   9585
   ShowInTaskbar   =   0   'False
   Begin MSFlexGridLib.MSFlexGrid Grd 
      Height          =   3135
      Left            =   0
      TabIndex        =   0
      Top             =   600
      Width           =   9495
      _ExtentX        =   16748
      _ExtentY        =   5530
      _Version        =   393216
      Cols            =   5
      FixedCols       =   0
      BackColor       =   12632256
      ForeColor       =   12582912
      BackColorFixed  =   8421376
      ForeColorFixed  =   16777215
      BackColorBkg    =   12632256
      FocusRect       =   0
      GridLines       =   2
      ScrollBars      =   2
      AllowUserResizing=   2
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   10920
      Top             =   600
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
            Picture         =   "BacEstOp.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacEstOp.frx":0624
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   4
      Top             =   0
      Width           =   9585
      _ExtentX        =   16907
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
            Key             =   "cmdRefrescar"
            Description     =   "Refrescar"
            Object.ToolTipText     =   "Refrescar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdSalir"
            Description     =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   1
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin VB.Label LblColor3 
      Appearance      =   0  'Flat
      BackColor       =   &H00808000&
      BorderStyle     =   1  'Fixed Single
      Caption         =   "AAA"
      ForeColor       =   &H00FFFF80&
      Height          =   375
      Left            =   3120
      TabIndex        =   3
      Top             =   5880
      Width           =   1335
   End
   Begin VB.Label LblColor2 
      Appearance      =   0  'Flat
      BackColor       =   &H000000FF&
      BorderStyle     =   1  'Fixed Single
      Caption         =   "AAA"
      ForeColor       =   &H00FFFF80&
      Height          =   375
      Left            =   1680
      TabIndex        =   2
      Top             =   5880
      Width           =   1335
   End
   Begin VB.Label LblColor 
      Appearance      =   0  'Flat
      BackColor       =   &H00FF0000&
      BorderStyle     =   1  'Fixed Single
      Caption         =   "AAA"
      ForeColor       =   &H00FFFF80&
      Height          =   375
      Left            =   240
      TabIndex        =   1
      Top             =   5880
      Width           =   1335
   End
End
Attribute VB_Name = "BacEstOp"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub Form_Activate()
 Grd.SetFocus
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case UCase(Button.Description)
   Case "REFRESCAR"
          Call BacCargaGrilla(0)
   Case "SALIR"
      Unload Me

   End Select
End Sub
Private Sub Form_Load()
       
    Call Nombres
               
    Call BacCargaGrilla(0)
       
   
End Sub
Private Sub BacCargaGrilla(nOpcion As Long)
Dim Datos()
    
    If Not Bac_Sql_Execute("SP_LEER_OPERACIONES") Then
        Screen.MousePointer = 0
        MsgBox "No se puede conectar Sql"
        Exit Sub
    End If

    With Grd
        .Redraw = False
        .Rows = 2
        .Row = 1
        .cols = 5
        
        Do While Bac_SQL_Fetch(Datos())
          If Datos(1) <> "OK" Then
                .Row = .Rows - 1
                .TextMatrix(.Row, 0) = IIf(IsNull(Val(Datos(1))), 0, Val(Datos(1)))
                .TextMatrix(.Row, 1) = IIf(IsNull(Datos(2)), "", Datos(2))
'+++fmo 20180718 decimales operaiones en moneda USD
                .TextMatrix(.Row, 2) = IIf(IsNull(Format(CDbl(Datos(3)), "###,###,###.00")), 0, Format(CDbl(Datos(3)), "###,###,###.00"))
'---fmo 20180718 decimales operaiones en moneda USD
                If IsNull(Datos(4)) Then
                    .TextMatrix(.Row, 3) = ""
                Else
                    .TextMatrix(.Row, 3) = IIf(Datos(4) = "R", "RECHAZADA", IIf(Datos(4) = "P", "PENDIENTE", " "))
                End If
                .TextMatrix(.Row, 4) = IIf(IsNull(Datos(5)), "", Datos(5))

'''                .TextMatrix(.Row, 0) = Val(datos(1))
'''                .TextMatrix(.Row, 1) = datos(2)
'''                .TextMatrix(.Row, 2) = Format(CDbl(datos(3)), "###,###,###")
'''                .TextMatrix(.Row, 3) = IIf(datos(4) = "R", "RECHAZADA", IIf(datos(4) = "P", "PENDIENTE", " "))
'''                .TextMatrix(.Row, 4) = datos(5)

                .Rows = .Rows + 1
                
                                
             For z = 0 To .cols - 1
                    .Col = z
                    .CellForeColor = IIf(Datos(4) = "R", vbRed, vbBlue)
             Next z
             
            
         End If
        Loop

        .Rows = .Rows - 1
        .Redraw = True
        .Col = 0
        .Row = 1

        
    End With

    Screen.MousePointer = 0

End Sub
Sub Nombres()

   With Grd
      .cols = 5
      .Rows = 2
      .Row = 0: .Col = 0: .text = "Numero Operación"
      .Row = 0: .Col = 1: .text = "Tipo Operación"
      .Row = 0: .Col = 2: .text = "Total Operación"
      .Row = 0: .Col = 3: .text = "Estado"
      .Row = 0: .Col = 4: .text = "Usuario"

      .RowHeight(0) = 400

      .ColWidth(0) = 1500
      .ColWidth(1) = 2300
      .ColWidth(2) = 2500
      .ColWidth(3) = 1500
      .ColWidth(4) = 1500
      .BackColorFixed = &H808000
      .ForeColorFixed = &HFFFFFF

   End With

End Sub
