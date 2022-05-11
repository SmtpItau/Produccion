VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "Mscomctl.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "threed32.ocx"
Object = "{989C9190-EDF5-45A8-AB6C-98E6EF0384D7}#1.0#0"; "Bac_Controles_Pas.ocx"
Begin VB.Form Compactacion 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Compactación de Historicos"
   ClientHeight    =   6810
   ClientLeft      =   2535
   ClientTop       =   2115
   ClientWidth     =   7140
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form2"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   6810
   ScaleWidth      =   7140
   Begin MSComctlLib.ListView LstCompactacion 
      Height          =   1740
      Left            =   0
      TabIndex        =   10
      Top             =   5070
      Width           =   7140
      _ExtentX        =   12594
      _ExtentY        =   3069
      View            =   3
      LabelEdit       =   1
      LabelWrap       =   -1  'True
      HideSelection   =   -1  'True
      FullRowSelect   =   -1  'True
      _Version        =   393217
      ForeColor       =   -2147483640
      BackColor       =   -2147483643
      BorderStyle     =   1
      Appearance      =   1
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      NumItems        =   0
   End
   Begin Threed.SSPanel SSPanel1 
      Height          =   300
      Left            =   45
      TabIndex        =   4
      Top             =   4755
      Width           =   7050
      _Version        =   65536
      _ExtentX        =   12435
      _ExtentY        =   529
      _StockProps     =   15
      Caption         =   "SSPanel1"
      ForeColor       =   -2147483639
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
      FloodType       =   1
      FloodColor      =   -2147483646
      Begin VB.Label Label2 
         BackStyle       =   0  'Transparent
         ForeColor       =   &H80000009&
         Height          =   240
         Left            =   120
         TabIndex        =   7
         Top             =   45
         Width           =   4575
      End
   End
   Begin Threed.SSFrame SSFrame1 
      Height          =   690
      Left            =   15
      TabIndex        =   2
      Top             =   525
      Width           =   7110
      _Version        =   65536
      _ExtentX        =   12541
      _ExtentY        =   1217
      _StockProps     =   14
      Caption         =   "Fechas de Compactación "
      ForeColor       =   -2147483641
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Font3D          =   3
      Begin BACControles.TXTFecha TXTFecha2 
         Height          =   315
         Left            =   4035
         TabIndex        =   6
         Top             =   300
         Width           =   1380
         _ExtentX        =   2434
         _ExtentY        =   556
         Enabled         =   -1  'True
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
         MaxDate         =   402133
         MinDate         =   18264
         Text            =   "14/05/2002"
      End
      Begin BACControles.TXTFecha TXTFecha1 
         Height          =   315
         Left            =   1305
         TabIndex        =   5
         Top             =   300
         Width           =   1380
         _ExtentX        =   2434
         _ExtentY        =   556
         Enabled         =   -1  'True
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
         MaxDate         =   402133
         MinDate         =   18264
         Text            =   "14/05/2002"
      End
      Begin VB.Label Label4 
         Caption         =   "Fecha Fin"
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
         Height          =   315
         Left            =   3150
         TabIndex        =   9
         Top             =   345
         Width           =   1455
      End
      Begin VB.Label Label3 
         Caption         =   "Fecha Inicio"
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
         Height          =   315
         Left            =   120
         TabIndex        =   8
         Top             =   330
         Width           =   1530
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   480
      Left            =   0
      TabIndex        =   1
      Top             =   0
      Width           =   7140
      _ExtentX        =   12594
      _ExtentY        =   847
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Compactar"
            Description     =   "Compactar"
            Object.ToolTipText     =   "Compactar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Carga"
            Object.ToolTipText     =   "Carga Interfaz"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Description     =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   4605
         Top             =   30
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   24
         ImageHeight     =   24
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   3
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Compactacion.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Compactacion.frx":0EDA
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Compactacion.frx":1DB4
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin MSComctlLib.TreeView TreeCompactacion 
      Height          =   3480
      Left            =   15
      TabIndex        =   0
      Top             =   1215
      Width           =   7110
      _ExtentX        =   12541
      _ExtentY        =   6138
      _Version        =   393217
      LabelEdit       =   1
      LineStyle       =   1
      Style           =   7
      Checkboxes      =   -1  'True
      Appearance      =   1
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
   Begin VB.Label Label1 
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      Height          =   345
      Left            =   15
      TabIndex        =   3
      Top             =   4725
      Width           =   7110
   End
End
Attribute VB_Name = "Compactacion"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim OptLocal As String
Dim Fecha1     As Date
Dim Fecha2     As Date
Dim Control_Fecha As Boolean

Private Sub Form_Activate()
   PROC_CARGA_AYUDA Me, ""
End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)

   Select Case KeyAscii
   Case vbKeyProcesar
      If Toolbar1.Buttons(1).Enabled Then
         Call Toolbar1_ButtonClick(Toolbar1.Buttons(1))

      End If

   Case vbKeyGeneraInterfaz
      If Toolbar1.Buttons(2).Enabled Then
         Call Toolbar1_ButtonClick(Toolbar1.Buttons(2))

      End If

   Case vbKeySalir
      Unload Me

   End Select

End Sub

Private Sub Form_Load()
   OptLocal = Opt
   Me.top = 0
   Me.left = 0
   Me.Icon = Menu_Principal.Icon
   Control_Fecha = True

   Call CargaNodo

   With LstCompactacion
      .ColumnHeaders.Add 1, "T", "TABLA", 2000
      .ColumnHeaders.Add 2, "M", 3000
      .ColumnHeaders.Add 3, "N", "NOMBRE", 2000
   End With
   
   Call LogAuditoria("07", OptLocal, Me.Caption, "", "")

End Sub

Private Sub CargaNodo()
Dim Datos()
Dim ClaveNodo  As String

   If Not BAC_SQL_EXECUTE("Sp_Compactacion_Datos") Then
      MsgBox "Problemas Ejecutando Consulta", vbCritical
   End If

   ClaveNodo = ""

   With TreeCompactacion

      While BAC_SQL_FETCH(Datos())
         
         Fecha1 = Datos(6)
         Fecha2 = Datos(7)
         
         If ClaveNodo <> Datos(1) + Datos(3) Then
         
            .Nodes.Add , , Datos(1) + Datos(3), Datos(3)
            ClaveNodo = Datos(1) + Datos(3)
            
         End If
         
         .Nodes.Add Datos(1) + Datos(3), 4, Datos(1) + Datos(2), Datos(2)
   
      Wend

   End With


   TXTFecha1.Text = Fecha1
   TXTFecha2.Text = Fecha2

End Sub

Private Sub Form_Unload(Cancel As Integer)
   Call LogAuditoria("08", OptLocal, Me.Caption, "", "")
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

   Select Case UCase(Button.Key)
   Case "COMPACTAR"
      
            Call Limpiar
      
            If ValidaFechas(TXTFecha1.Text, TXTFecha2.Text) Then
                        
               If MsgBox("¿Seguro de querer Compactar la Información?", vbYesNo + vbInformation) = vbYes Then
                     
                  Toolbar1.Buttons(1).Enabled = False
                  Toolbar1.Buttons(2).Enabled = False
                  
                  Call GeneraCompactacion
                  
                  Toolbar1.Buttons(1).Enabled = True
                  Toolbar1.Buttons(2).Enabled = True
                  
               End If
            
            End If

   Case "CARGA"
      Call Limpiar
      Toolbar1.Buttons(1).Enabled = False
      Toolbar1.Buttons(2).Enabled = False
      
      Call CargaCompactacion
      Toolbar1.Buttons(1).Enabled = True
      Toolbar1.Buttons(2).Enabled = True

   Case "SALIR"
            Unload Me
            Exit Sub
   
   End Select
   
End Sub

Private Sub TreeCompactacion_MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single)
On Error Resume Next
   
   Dim I As Long
   For I = 1 To TreeCompactacion.Nodes.Count
   
      If TreeCompactacion.Nodes(I).Children > 0 And Not TreeCompactacion.Nodes(I).Checked Then
      
         DesCheketNodos TreeCompactacion.Nodes(I), (I), TreeCompactacion.Nodes(I).Children, True
      
      End If
   
   Next
   
End Sub

Private Sub TreeCompactacion_NodeCheck(ByVal Node As MSComctlLib.Node)
Dim I       As Integer

On Error Resume Next

   With TreeCompactacion
      
      If Node.Checked Then
      
         CheketNodos Node
      
      End If

      If Not Node.Checked Then
      
         DesCheketNodos Node, Node.Index, Node.Children, True
      
      End If
   
   End With

End Sub

Sub DesCheketNodos(Node As MSComctlLib.Node, Index As Integer, Hijos As Integer, FirsTime As Boolean)

   If Hijos > 0 Then

      For Index = Index To Index + Hijos
      
         If Not FirsTime Then
      
            Print TreeCompactacion.Nodes.item(Index).Parent
                     
         End If
      
         TreeCompactacion.Nodes.item(Index).Checked = False
         
         If TreeCompactacion.Nodes.item(Index).Children > 0 Then
         
            DesCheketNodos TreeCompactacion.Nodes.item(Index).Child, Index + 1, TreeCompactacion.Nodes.item(Index).Children, False
         
         End If
      
      Next Index

   End If
   
End Sub

Sub CheketNodos(Node As MSComctlLib.Node)

    Node.Parent.Checked = True
    CheketNodos Node.Parent

End Sub

Private Sub txtFecha1_Change()
   
   TXTFecha1.Text = (CDate(TXTFecha1.Text) - DatePart("D", TXTFecha1.Text)) + 1

End Sub

Private Sub TXTFecha2_Change()
    
   If Control_Fecha Then
    
       Control_Fecha = False
       TXTFecha2.Text = CDate(CDate(DateAdd("M", 1, TXTFecha2.Text)) - DatePart("D", TXTFecha2.Text))
       Control_Fecha = True
   End If
   
End Sub

Function ValidaFechas(xFecha1, xFecha2 As Date) As Boolean

   ValidaFechas = False

   If CDate(xFecha1) > CDate(xFecha2) Then
      MsgBox "La Fecha de Inicio no puede ser Mayor a la Fecha Final", vbInformation
      Exit Function
   End If

   If DateDiff("M", xFecha2, gsbac_fecp) < 12 Then
      MsgBox "El Rango Minimo para Compactar es de 12 meses hacia atras", vbInformation
      Exit Function
   End If

   ValidaFechas = True

End Function

Sub GeneraCompactacion()
Dim I, x    As Integer

   With TreeCompactacion
   
      For I = 1 To .Nodes.Count
   
         If .Nodes.item(I).Checked And .Nodes.item(I).Children = 0 Then
         
            Call GeneraArchivo(.Nodes.item(I).Text, TXTFecha1.Text, TXTFecha2.Text)
         
         End If
      
      Next I
   
   End With

End Sub

Sub GeneraArchivo(Tabla As String, Fecha1, Fecha2 As Date)
Dim Datos()
Dim Cadena        As String
Dim I             As Integer
Dim Max           As Long
Dim Registros     As Long
Dim NombreArchivo As String

On Error GoTo ErrorGeneracion:
   
   NombreArchivo = Tabla & IIf(Len(CStr(DatePart("M", TXTFecha1.Text))) > 1, CStr(DatePart("M", TXTFecha1.Text)), "0" & CStr(DatePart("M", TXTFecha1.Text))) & CStr(DatePart("YYYY", TXTFecha1.Text)) & "-" _
   & IIf(Len(CStr(DatePart("M", TXTFecha2.Text))) > 1, CStr(DatePart("M", TXTFecha2.Text)), "0" & CStr(DatePart("M", TXTFecha2.Text))) & CStr(DatePart("YYYY", TXTFecha2.Text)) & ".txt"
   
   SSPanel1.FloodPercent = 0
   
   If Not BAC_SQL_EXECUTE("Sp_BacInterfaces_Archivo", Array("999")) Then
      MsgBox "Problemas Ejecutando Consulta", vbCritical
      Exit Sub
   End If
   
   If BAC_SQL_FETCH(Datos()) Then
   
      NombreArchivo = Datos(4) & IIf(right(Datos(4), 1) = "\", "", "\") & NombreArchivo
   
   End If
   
   
   Envia = Array()
   AddParam Envia, Tabla
   AddParam Envia, Fecha1
   AddParam Envia, Fecha2

   If Not BAC_SQL_EXECUTE("Sp_Genera_Compactacion", Envia) Then
      MsgBox "Problemas Ejecutando Consulta", vbCritical
      Exit Sub
   End If
   
   Label2.Caption = Tabla & " ...."
   
   Max = 0
   
   If Dir(NombreArchivo) <> "" Then
      Kill NombreArchivo
   End If
   
   Open NombreArchivo For Binary Access Write As #1
   
   While BAC_SQL_FETCH(Datos())
         
      Max = Datos(1)
   
      Cadena = ""
   
      For I = 2 To UBound(Datos())
      
         If IsFecha(Datos(I)) Then
            Datos(I) = Format(Datos(I), "yyyy-mm-dd 00:00:00.000")
         
         End If
      
         Cadena = Cadena & Trim(Datos(I)) & ";"
   
      Next I
      
      Cadena = Mid(Cadena, 1, Len(Cadena) - 1) + vbCrLf
      
      Cadena = Replace(Cadena, ",", ".")
      
      Put #1, , Cadena
         
      Registros = Registros + 1
   
      SSPanel1.FloodPercent = (Registros * 100) / Max
   
   Wend
   
   Close #1
   
   If Max = 0 Then
      LstCompactacion.ListItems.Add 1, Tabla, Tabla
      LstCompactacion.ListItems.item(1).ListSubItems.Add 1, , "NO EXISTE INFORMACION"
      LstCompactacion.ListItems.item(1).ListSubItems.Add 2, , NombreArchivo
      
   Else
      LstCompactacion.ListItems.Add 1, Tabla, Tabla
      LstCompactacion.ListItems.item(1).ListSubItems.Add 1, , "GENERADA"
      LstCompactacion.ListItems.item(1).ListSubItems.Add 2, , NombreArchivo
         
   End If
   
   
   SSPanel1.FloodPercent = 0
   Label2.Caption = ""
   
   DoEvents
   
Exit Sub
ErrorGeneracion:
      LstCompactacion.ListItems.Add 1, Tabla + Tabla, Tabla
      LstCompactacion.ListItems.item(1).ListSubItems.Add 1, , "PROBLEMAS " & Err.Description
      LstCompactacion.ListItems.item(1).ListSubItems.Add 2, , NombreArchivo
      SSPanel1.FloodPercent = 0
      Label2.Caption = ""
      Close #1
   
End Sub

Sub Limpiar()
   
   LstCompactacion.ListItems.Clear

End Sub

Sub CargaCompactacion()
Dim I, x    As Integer

   LstCompactacion.ListItems.Clear

   With TreeCompactacion
   
      For I = 1 To .Nodes.Count
   
         If .Nodes.item(I).Checked And .Nodes.item(I).Children = 0 Then
         
            Call CargaArchivo(.Nodes.item(I).Text, TXTFecha1.Text, TXTFecha2.Text)
         
         End If
      
      Next I
   
   End With

End Sub

Sub CargaArchivo(Tabla As String, Fecha1, Fecha2 As Date)
Dim Datos()
Dim Cadena         As String
Dim I              As Integer
Dim Max            As Long
Dim Registros      As Long
Dim NombreArchivo  As String
Dim Existe         As Boolean
Dim Linea          As String
Dim Reg            As Long
Dim gsc_PuntoDecim As String

On Error GoTo ErrorCarga:
   
   Existe = False
   
   gsc_PuntoDecim = Mid$(Format(0#, "0.0"), 2, 1)
   
   Label2.Caption = Tabla & " ...."
   
   NombreArchivo = Tabla & IIf(Len(CStr(DatePart("M", TXTFecha1.Text))) > 1, CStr(DatePart("M", TXTFecha1.Text)), "0" & CStr(DatePart("M", TXTFecha1.Text))) & CStr(DatePart("YYYY", TXTFecha1.Text)) & "-" _
   & IIf(Len(CStr(DatePart("M", TXTFecha2.Text))) > 1, CStr(DatePart("M", TXTFecha2.Text)), "0" & CStr(DatePart("M", TXTFecha2.Text))) & CStr(DatePart("YYYY", TXTFecha2.Text)) & ".txt"
   
   SSPanel1.FloodPercent = 0
   
   If Not BAC_SQL_EXECUTE("Sp_BacInterfaces_Archivo", Array("999")) Then
      MsgBox "Problemas Ejecutando Consulta", vbCritical
      Exit Sub
   End If
   
   If BAC_SQL_FETCH(Datos()) Then
   
      NombreArchivo = Datos(4) & IIf(right(Datos(4), 1) = "\", "", "\") & NombreArchivo
   
   End If

   If Dir(NombreArchivo) <> "" Then
      Existe = True
   
   Else
      
      LstCompactacion.ListItems.Add 1, Tabla + Tabla, Tabla
      LstCompactacion.ListItems.item(1).ListSubItems.Add 1, , "ARCHIVO NO EXISTE " & Err.Description
      LstCompactacion.ListItems.item(1).ListSubItems.Add 2, , NombreArchivo
      Exit Sub
   
   End If

   Registros = 0
   Max = 0

   Open NombreArchivo For Input As #1
   
      Do While Not EOF(1)
      
         Line Input #1, Linea
         Max = Max + 1
      
      Loop
   
   Close #1

   SSPanel1.FloodPercent = 0

   Open NombreArchivo For Input As #1
   
      Do While Not EOF(1)
      
         Line Input #1, Linea
         Datos = Array()
   
         Linea = Replace(Linea, ".", gsc_PuntoDecim)
   
         While Linea <> ""
   
            Reg = UBound(Datos) + 1
            ReDim Preserve Datos(Reg)
            
            If Linea = ";" Then
               Datos(Reg) = ""
               Linea = ""
            End If
            If InStr(2, Linea, ";") = 0 And Linea <> "" Then
               Datos(Reg) = Mid(Linea, 2, Len(Linea))
               Linea = ""
            End If
            
            
            If Linea <> "" Then
            
                  If Reg = 0 Then
                     Datos(Reg) = Mid(Linea, 1, InStr(1, Linea, ";"))
                     Datos(Reg) = Replace(Datos(Reg), ";", "")
                     Linea = Mid(Linea, Len(Mid(Linea, 1, InStr(1, Linea, ";"))), Len(Linea))
                  
                  Else
                           
                     If Len(Linea) = 2 And Linea = ";;" Then
                        Datos(Reg) = Mid(Linea, 2, InStr(2, Linea, ";") - 1)
                        Datos(Reg) = Replace(Datos(Reg), ";", "")
                        Linea = ";"
                     
                     Else
                     
                        Datos(Reg) = Mid(Linea, 2, InStr(2, Linea, ";") - 1)
                        Datos(Reg) = Replace(Datos(Reg), ";", "")
                        If InStr(2, Linea, ";") = Len(Linea) Then
                           Linea = Mid(Linea, Len(Mid(Linea, 2, InStr(2, Linea, ";"))) + 1, Len(Linea))
                        
                        Else
                           Linea = Mid(Linea, Len(Mid(Linea, 2, InStr(2, Linea, ";"))), Len(Linea))
                        
                        End If
                     
                     End If
                  
                  End If
            End If
               
            If IsNumeric(Datos(Reg)) Then
               
               If Len(Datos(Reg)) > 1 And left(Datos(Reg), 1) = "0" Then
                  
                  Datos(Reg) = Datos(Reg)
               
               Else
               
                  Datos(Reg) = CStr(Datos(Reg))
            
               End If
            End If
            
         Wend
   
         Cadena = FormatoArreglo(Datos())
      
         'Envia = Array()
         'AddParam Envia,CStr(Cadena)
         'AddParam Envia, Tabla
      
         If Not BAC_SQL_EXECUTE("Sp_Graba_Compactacion """ & CStr(Cadena) & """,'" & Tabla & "'") Then
            LstCompactacion.ListItems.Add 1, Tabla + Tabla, Tabla
            LstCompactacion.ListItems.item(1).ListSubItems.Add 1, , "PROBLEMAS EN GRABACION"
            LstCompactacion.ListItems.item(1).ListSubItems.Add 2, , NombreArchivo
            SSPanel1.FloodPercent = 0
            Label2.Caption = ""
            Close #1
            Exit Sub
         
         End If
      
         Registros = Registros + 1
         SSPanel1.FloodPercent = (Registros * 100) / Max
   
      Loop
   
   Close #1

   SSPanel1.FloodPercent = 0

   If Max = 0 Then
   
      LstCompactacion.ListItems.Add 1, Tabla + Tabla, Tabla
      LstCompactacion.ListItems.item(1).ListSubItems.Add 1, , "ARCHIVO SIN INFORMACION"
      LstCompactacion.ListItems.item(1).ListSubItems.Add 2, , NombreArchivo
   
   Else
   
      LstCompactacion.ListItems.Add 1, Tabla + Tabla, Tabla
      LstCompactacion.ListItems.item(1).ListSubItems.Add 1, , "CARGADO CORRECTAMENTE"
      LstCompactacion.ListItems.item(1).ListSubItems.Add 2, , NombreArchivo
   
   End If


   Label2.Caption = ""
   DoEvents



Exit Sub
ErrorCarga:
      LstCompactacion.ListItems.Add 1, Tabla + Tabla, Tabla
      LstCompactacion.ListItems.item(1).ListSubItems.Add 1, , "PROBLEMAS " & Err.Description
      LstCompactacion.ListItems.item(1).ListSubItems.Add 2, , NombreArchivo
      SSPanel1.FloodPercent = 0
      Label2.Caption = ""
      Close #1

End Sub


Public Function FormatoArreglo(Arreglo As Variant) As String
   Dim I As Integer
   Dim Conta As Integer, Mc
   Dim Sql As String
   Dim J As Integer
   On Error GoTo ErroresFuncion

   gsc_PuntoDecim = Mid$(Format(0#, "0.0"), 2, 1)
   
   
   Conta = UBound(Arreglo)
            
   For I = 0 To Conta

      If InStr(1, Trim(Arreglo(I)), "00:00:00,000") > 0 Then
          Arreglo(I) = Format(Replace(Arreglo(I), "00:00:00,000", ""), "yyyymmdd")
      End If

      
      If TypeName(Arreglo(I)) = "String" Then
      
         If IsDate(Arreglo(I)) And IsFecha(Arreglo(I)) Then
         
            Sql = Sql & " '" & Format(Arreglo(I), feFECHA) & "',"
            
         Else
            J = 1
            Do While J <> 0
               J = InStr(1, Arreglo(I), "'")
               If J > 0 Then
                  Arreglo(I) = Mid(Arreglo(I), 1, J - 1) & Chr(34) & Mid(Arreglo(I), J + 1)
               End If
            Loop
            
            Sql = Sql & " '" & Arreglo(I) & "',"
            
         End If
         
         
      ElseIf TypeName(Arreglo(I)) = "Date" Then
         
         Sql = Sql & " '" & Format(Arreglo(I), feFECHA) & "',"
            
      Else
         
         If gsc_PuntoDecim = "," Then
            
            Mc = InStr(1, Arreglo(I), ",")
            
            If Mc > 0 Then
                
                Arreglo(I) = Mid(Arreglo(I), 1, Mc - 1) & "." & Mid(Arreglo(I), Mc + 1)
            
            End If
         
         End If
         
         Sql = Sql & " " & Arreglo(I) & ","

      End If
      
   Next I
      
   If Conta > -1 Then
      
      Sql = Mid(Sql, 1, Len(Sql) - 1)
      
   End If
      
   FormatoArreglo = Sql
      
   Exit Function

ErroresFuncion:
   
   If Err.Number = 9 Then
      
      Conta = -1
      Resume Next
   
   Else
      
      MsgBox Err.Description, , Err.Number
      
   End If

End Function

