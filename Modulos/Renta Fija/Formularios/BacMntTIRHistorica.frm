VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "Msflxgrd.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form BacMntTirHistorica 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantenedor de Tir Historica"
   ClientHeight    =   5505
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   11325
   Icon            =   "BacMntTIRHistorica.frx":0000
   LinkTopic       =   "Form2"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   5505
   ScaleWidth      =   11325
   Begin VB.ComboBox cmbTipo 
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
      ItemData        =   "BacMntTIRHistorica.frx":030A
      Left            =   4080
      List            =   "BacMntTIRHistorica.frx":030C
      Style           =   2  'Dropdown List
      TabIndex        =   2
      Top             =   840
      Visible         =   0   'False
      Width           =   1455
   End
   Begin MSFlexGridLib.MSFlexGrid Grd 
      Height          =   4875
      Left            =   90
      TabIndex        =   1
      Top             =   495
      Width           =   11145
      _ExtentX        =   19659
      _ExtentY        =   8599
      _Version        =   393216
      Cols            =   14
      FixedCols       =   0
      RowHeightMin    =   310
      BackColor       =   -2147483644
      ForeColor       =   12582912
      BackColorFixed  =   8421376
      ForeColorFixed  =   16777215
      BackColorBkg    =   12632256
      GridLines       =   2
      AllowUserResizing=   1
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   6120
      Top             =   120
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
            Picture         =   "BacMntTIRHistorica.frx":030E
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMntTIRHistorica.frx":076A
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   11325
      _ExtentX        =   19976
      _ExtentY        =   794
      ButtonWidth     =   767
      ButtonHeight    =   741
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
End
Attribute VB_Name = "BacMntTirHistorica"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim Fila, COLU, Rut_Cli, Num_Doc, correla As Integer
Dim Tipo_Renta, sql_TIR As String

Private Sub cmbTipo_Click()

   With Grd
      If cmbTipo.text <> Empty Then
         .TextMatrix(.Row, .Col) = cmbTipo.text
         .TextMatrix(.Row, 13) = "C"
      End If
   End With

   Grd.SetFocus

End Sub

Private Sub cmbTipo_KeyPress(KeyAscii As Integer)


   If KeyAscii = 27 Then
      KeyAscii = 0
      Grd.SetFocus
   End If


   If KeyAscii = 13 Then
      KeyAscii = 0

      With Grd
         If cmbTipo.text <> Empty Then
            .TextMatrix(.Row, .Col) = cmbTipo.text
            .TextMatrix(.Row, 13) = "C"
         End If
      End With

      Grd.SetFocus

   End If


End Sub

Private Sub cmbTipo_LostFocus()

   cmbTipo.Visible = False

End Sub

Private Sub Form_Load()
    Define_Cabecera
    Me.Top = 0
    Me.Left = 0
    Ejecuta_Consulta
    cmbTipo.AddItem "MEDIA INTERBANCARIA"
    cmbTipo.AddItem "TIR HISTORICA"
End Sub

Private Sub Grd_DblClick()

   Dim X As Integer

   With Grd

       If .Col = 7 Then
       
           
           cmbTipo.Width = .CellWidth
           cmbTipo.Left = .CellLeft + 100
           cmbTipo.Top = .CellTop + 480

           cmbTipo.ListIndex = -1

           For X = 0 To cmbTipo.ListCount - 1
               If cmbTipo.List(X) = Grd.TextMatrix(Grd.Row, Grd.Col) Then
                  cmbTipo.ListIndex = X
                  Exit For
               End If
           Next


           cmbTipo.Visible = True
           
           cmbTipo.SetFocus


       Else
           cmbTipo.Visible = False
           
       End If
   
   End With


End Sub

Private Sub Grd_KeyPress(KeyAscii As Integer)


   Dim X As Integer


   If KeyAscii = 13 Then

      With Grd
   
          If .Col = 7 Then
          
              
              cmbTipo.Width = .CellWidth
              cmbTipo.Left = .CellLeft + 100
              cmbTipo.Top = .CellTop + 480
   
              cmbTipo.ListIndex = -1
   
              For X = 0 To cmbTipo.ListCount - 1
                  If cmbTipo.List(X) = Grd.TextMatrix(Grd.Row, Grd.Col) Then
                     cmbTipo.ListIndex = X
                     Exit For
                  End If
              Next

              cmbTipo.Visible = True
              
              cmbTipo.SetFocus
   
   
   
          Else
              cmbTipo.Visible = False
              
          End If
      
      End With
   
   End If

End Sub

Private Sub Grd_Scroll()
    cmbTipo.Visible = False
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Index
    
    Case 1
        Grabar_Grilla
    Case 2
        Unload Me
        
End Select

End Sub

Sub Define_Cabecera()


With Grd

    
    .FixedCols = 5
    .RowHeight(0) = 300
    .BackColorFixed = &H808000
    .ForeColorFixed = &HFFFFFF
    
    .ColWidth(0) = 0
    .ColWidth(1) = 0
    .ColWidth(2) = 0
    .ColWidth(3) = 0
    .ColWidth(4) = 1500
    .ColWidth(5) = 0
    .ColWidth(6) = 0
    .ColWidth(7) = 2500
    .ColWidth(8) = 2000
    .ColWidth(9) = 0
    .ColWidth(10) = 0
    .ColWidth(11) = 1500
    .ColWidth(12) = 3000
    .ColWidth(13) = 0
             
    .TextMatrix(0, 0) = "" 'RUTCAT
    .TextMatrix(0, 1) = "" 'RUTCLI
    .TextMatrix(0, 2) = "Nombre Cliente" 'NOMCLI
    
    .TextMatrix(0, 3) = "" 'NumDocu
    .TextMatrix(0, 4) = "Tipo Instrumento" 'Serie
    .TextMatrix(0, 5) = "" 'CONTRATO
    
    .TextMatrix(0, 6) = "" 'TIPOCARTERA
    .TextMatrix(0, 7) = "Tipo Renta" 'TIPORENTA
    .TextMatrix(0, 8) = "Nominal" 'Nominal
    .TextMatrix(0, 9) = "" 'SERIADO
    .TextMatrix(0, 10) = "" 'Correla
    
    .TextMatrix(0, 11) = "Rut Emisor" 'RUTEMISOR
    .TextMatrix(0, 12) = "Nombre Emisor"  'EMISOR


End With

End Sub

Sub Ejecuta_Consulta()
Dim Resultados()
Dim sql_Consulta As String

On Error GoTo Error_Consulta

sql_Consulta = "SP_TRAE_TIR_HISTORICA"
If Not Bac_Sql_Execute("SP_TRAE_TIR_HISTORICA") Then
    MsgBox "Problemas al ejecutar la consulta SQL.", vbInformation, TITSISTEMA
Else

Grd.Rows = Grd.FixedRows

Do While Bac_SQL_Fetch(Resultados())

    With Grd
            .Rows = .Rows + 1
            .Row = .Rows - 1
            
            .Col = 0: .text = Resultados(1)
            .Col = 1: .text = Resultados(2)
            .Col = 2: .text = Resultados(3)
            .Col = 3: .text = Resultados(4)
            .Col = 4: .text = Resultados(5)
            
            .Col = 5: .text = Resultados(6)
            .Col = 6: .text = Resultados(7)
            
            If UCase(Resultados(8)) = "H" Then
                .Col = 7: .text = "TIR HISTORICA"
            ElseIf UCase(Resultados(8)) = "I" Then
                .Col = 7: .text = "MEDIA INTERBANCARIA"
            End If
            
            .Col = 8: .text = Format(Resultados(9), "#,##0.0000")
            
            .Col = 9: .text = Resultados(10)
            .Col = 10: .text = Resultados(11)
            .Col = 11: .text = Format(Resultados(12), "#,##0")
            .Col = 12: .text = Resultados(13)
                      

    End With

Loop

End If

Exit Sub

Error_Consulta:
        MsgBox err.Description: Exit Sub

End Sub

Sub Grabar_Grilla()
   Dim sw_Graba As Boolean
   Dim Cuenta_Col As Integer
   
   On Error GoTo Err_Graba_Tir
   
   sw_Graba = True
   
   With Grd
   
      Cuenta_Col = 1

      Do
      
         If UCase(.TextMatrix(Cuenta_Col, 13)) = "C" Then
             
            Rut_Cli = .TextMatrix(Cuenta_Col, 1)
            Num_Doc = .TextMatrix(Cuenta_Col, 3)
            correla = .TextMatrix(Cuenta_Col, 10)
            
            If UCase(.TextMatrix(Cuenta_Col, 7)) = "MEDIA INTERBANCARIA" Then
                Tipo_Renta = "I"
            ElseIf UCase(.TextMatrix(Cuenta_Col, 7)) = "TIR HISTORICA" Then
                Tipo_Renta = "H"
            End If
            
            sql_TIR = "SP_GRABA_TIR_HISTORICA " & _
                            "'" & Rut_Cli & "'" & "," & _
                            "'" & Num_Doc & "'" & "," & _
                            "'" & correla & "'" & "," & _
                            "'" & Tipo_Renta & "'"
                           
            If Not Bac_Sql_Execute(sql_TIR) Then
               sw_Graba = False
               Exit Do
            End If
         
         End If
         Cuenta_Col = Cuenta_Col + 1
         
      Loop Until Cuenta_Col = Grd.Rows
   
   End With
       
   If sw_Graba Then
       MsgBox "Información Grabada correctamente", vbInformation, TITSISTEMA
   Else
       MsgBox "No se pudo Grabar Información", vbCritical, TITSISTEMA
   End If
       
   
   Exit Sub
   
Err_Graba_Tir:

        MsgBox err.Description, vbCritical, TITSISTEMA
        Exit Sub
        
End Sub
