VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form BacEmiSwift 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Emision de Mensajes Swift"
   ClientHeight    =   5295
   ClientLeft      =   2340
   ClientTop       =   2265
   ClientWidth     =   8130
   LinkTopic       =   "Form2"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MinButton       =   0   'False
   Moveable        =   0   'False
   ScaleHeight     =   5295
   ScaleWidth      =   8130
   ShowInTaskbar   =   0   'False
   Begin Threed.SSPanel SSPanel2 
      Height          =   4890
      Left            =   30
      TabIndex        =   2
      Top             =   420
      Width           =   8070
      _Version        =   65536
      _ExtentX        =   14235
      _ExtentY        =   8625
      _StockProps     =   15
      Caption         =   "SSPanel2"
      BackColor       =   -2147483638
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin VB.TextBox txtGlosa 
         BackColor       =   &H80000008&
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
         ForeColor       =   &H80000005&
         Height          =   285
         Left            =   2520
         TabIndex        =   4
         Text            =   "Text1"
         Top             =   405
         Visible         =   0   'False
         Width           =   1005
      End
      Begin MSFlexGridLib.MSFlexGrid Grid 
         Height          =   4785
         Left            =   30
         TabIndex        =   3
         ToolTipText     =   "Contenido del Mensaje Swift a Emitir"
         Top             =   45
         Width           =   8010
         _ExtentX        =   14129
         _ExtentY        =   8440
         _Version        =   393216
         Cols            =   20
         FixedCols       =   0
         BackColorFixed  =   -2147483644
         BackColorSel    =   -2147483640
         BackColorBkg    =   -2147483636
         FocusRect       =   0
         FillStyle       =   1
         GridLines       =   2
         GridLinesFixed  =   0
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
   Begin Threed.SSPanel SSPanel1 
      Height          =   585
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   7770
      _Version        =   65536
      _ExtentX        =   13705
      _ExtentY        =   1032
      _StockProps     =   15
      BackColor       =   -2147483638
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BevelOuter      =   0
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   4800
         Top             =   -15
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   22
         ImageHeight     =   22
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   20
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacEmiSwift.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacEmiSwift.frx":0452
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacEmiSwift.frx":0D2C
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacEmiSwift.frx":117E
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacEmiSwift.frx":15D0
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacEmiSwift.frx":1EAA
               Key             =   ""
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacEmiSwift.frx":2784
               Key             =   ""
            EndProperty
            BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacEmiSwift.frx":2BD6
               Key             =   ""
            EndProperty
            BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacEmiSwift.frx":3028
               Key             =   ""
            EndProperty
            BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacEmiSwift.frx":3342
               Key             =   ""
            EndProperty
            BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacEmiSwift.frx":3C1C
               Key             =   ""
            EndProperty
            BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacEmiSwift.frx":3F36
               Key             =   ""
            EndProperty
            BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacEmiSwift.frx":4D88
               Key             =   ""
            EndProperty
            BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacEmiSwift.frx":50A2
               Key             =   ""
            EndProperty
            BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacEmiSwift.frx":53BC
               Key             =   ""
            EndProperty
            BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacEmiSwift.frx":5C96
               Key             =   ""
            EndProperty
            BeginProperty ListImage17 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacEmiSwift.frx":6868
               Key             =   ""
            EndProperty
            BeginProperty ListImage18 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacEmiSwift.frx":6CBA
               Key             =   ""
            EndProperty
            BeginProperty ListImage19 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacEmiSwift.frx":6FD4
               Key             =   ""
            EndProperty
            BeginProperty ListImage20 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacEmiSwift.frx":72EE
               Key             =   ""
            EndProperty
         EndProperty
      End
      Begin MSComctlLib.Toolbar Toolbar1 
         Height          =   480
         Left            =   -90
         TabIndex        =   1
         Top             =   -30
         Width           =   6285
         _ExtentX        =   11086
         _ExtentY        =   847
         ButtonWidth     =   767
         ButtonHeight    =   741
         AllowCustomize  =   0   'False
         Wrappable       =   0   'False
         ImageList       =   "ImageList1"
         _Version        =   393216
         BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
            NumButtons      =   7
            BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Style           =   3
            EndProperty
            BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Key             =   "Guardar"
               Object.ToolTipText     =   "Guardar Formato Swift"
               ImageIndex      =   4
            EndProperty
            BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Enabled         =   0   'False
               Object.Visible         =   0   'False
               Key             =   "Eliminar"
               Object.ToolTipText     =   "Eliminar Swift"
               ImageIndex      =   7
            EndProperty
            BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Key             =   "Imprimir"
               Object.ToolTipText     =   "Imprimir Mensaje Swift"
               ImageIndex      =   10
            EndProperty
            BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Enabled         =   0   'False
               Object.Visible         =   0   'False
               Key             =   "Buscar"
               Object.ToolTipText     =   "Buscar"
               ImageIndex      =   2
            EndProperty
            BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Key             =   "InterfazSwift"
               Object.ToolTipText     =   "Interfaz Swift"
               ImageIndex      =   16
            EndProperty
            BeginProperty Button7 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Key             =   "Cerrar"
               Object.ToolTipText     =   "Cerrar Ventana"
               ImageIndex      =   19
            EndProperty
         EndProperty
      End
   End
End
Attribute VB_Name = "BacEmiSwift"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim Arreglo(50, 1)
Dim OptLocal            As String
Dim RutCliente          As Double
Dim Mercado             As String
Dim Moneda              As String
Dim Monto               As Double
Dim grabo               As Boolean
Dim NumOper             As Integer
Dim NumRefe             As Long
Dim cSql                As String
Dim x                   As Integer
Dim e                   As Integer
Dim T                   As Integer
Dim largo               As Integer
Dim Cambio              As Variant
Dim inter5              As String
Dim inter4              As String
Dim cabezera            As String
Dim recibim As String
Dim entrega As String
   
Dim PREFORMATO          As Boolean
Dim Swift_numero        As Double
Dim Numero_referencia   As String
Dim Mensaje             As String
Const codigo_mensaje_swift = "MT 202"


Sub titulos()
   With Me.Grid
      .Rows = 2
      .Cols = 20
      .FixedRows = 1
      .FixedCols = 0
      .TextMatrix(0, 0) = ""
      .TextMatrix(0, 1) = "Fec. Opera"
      .TextMatrix(0, 2) = "Fec. Vcto"
      .TextMatrix(0, 3) = "Sistema"
      .TextMatrix(0, 4) = "Mercado"
      .TextMatrix(0, 5) = "Producto"
      .TextMatrix(0, 6) = "Operación"
      .TextMatrix(0, 7) = "Moneda"
      .TextMatrix(0, 8) = "Estado"
      .TextMatrix(0, 9) = "Rut Cliente"
      .TextMatrix(0, 10) = "Cod. Cliente"
      .TextMatrix(0, 11) = "Mensaje"
      .TextMatrix(0, 12) = "Nombre"
      .TextMatrix(0, 13) = "Opción"
      .TextMatrix(0, 14) = "Tipo"
      .TextMatrix(0, 15) = "Correlativo"
      .TextMatrix(0, 16) = "Descripción"
      .TextMatrix(0, 17) = "Cantidad Lineas"
      .TextMatrix(0, 18) = "Impreso"
      .TextMatrix(0, 19) = "Número"
      
      .ColWidth(0) = 1000
      .ColWidth(1) = 1000
      .ColWidth(2) = 1000
      .ColWidth(3) = 1000
      .ColWidth(4) = 1000
      .ColWidth(5) = 1000
      .ColWidth(6) = 1000
      .ColWidth(7) = 1000
      .ColWidth(8) = 1000
      .ColWidth(9) = 1000
      .ColWidth(10) = 1000
      .ColWidth(11) = 1000
      .ColWidth(12) = 1000
      .ColWidth(13) = 1000
      .ColWidth(14) = 1000
      .ColWidth(15) = 1000
      .ColWidth(16) = 6460
      .ColWidth(17) = 1000
      .ColWidth(18) = 1000
      .ColWidth(19) = 1000
      
      .ColAlignment(12) = 4
      .ColAlignment(16) = 1
   
      .RowHeight(0) = 500
  
   End With
End Sub

Private Sub Form_Activate()
   
   Call cargar_grilla
   
   If PREFORMATO = True Then
      Toolbar1.Buttons(2).Enabled = True
      Toolbar1.Buttons(4).Enabled = False
      Call PreFormatoSwift
   Else
      Toolbar1.Buttons(2).Enabled = False
      Toolbar1.Buttons(4).Enabled = True
   End If
   
   Me.Caption = Me.Caption & Space(10) & Mensaje
   
End Sub

Private Sub Form_Load()
   Me.Icon = BACSwapParametros.Icon
   
   Me.Toolbar1.Buttons(2).Enabled = True
   Me.Toolbar1.Buttons(4).Enabled = False
   
   Call titulos
   'Call Formato_Grilla(Me.Grid)
   
End Sub

Sub cargar_grilla()
   Dim f, x, largo   As Integer
   Dim Hay           As Boolean
   Dim Numero_Opera  As Long
   Dim Datos()

   With BacGenMensaje.GRD_mensajes
        PREFORMATO = False
        Hay = False
        f = 2
     
        Envia = Array()
        AddParam Envia, "MT 202"
        AddParam Envia, CDbl(.TextMatrix(.Row, 3))
        AddParam Envia, Trim(.TextMatrix(.Row, 8))
        If Not Bac_Sql_Execute("Sp_Carga_Movimientos_Detalle", Envia) Then
           MsgBox "Problemas en la carga de Datos", vbExclamation, TITSISTEMA
           Exit Sub
        End If
   End With
   
   With Me.Grid

   Do While Bac_SQL_Fetch(Datos())
      Hay = True
      largo = IIf(Datos(17) = 0, 1, Datos(17))
      
      For x = 1 To CDbl(largo)

         .TextMatrix(.Rows - 1, 0) = Datos(17)
         .TextMatrix(.Rows - 1, 1) = Datos(1)
         .TextMatrix(.Rows - 1, 2) = Datos(2)
         .TextMatrix(.Rows - 1, 3) = Datos(3)
         .TextMatrix(.Rows - 1, 4) = Datos(4)
         .TextMatrix(.Rows - 1, 5) = Datos(5)
         .TextMatrix(.Rows - 1, 6) = Datos(6)
         .TextMatrix(.Rows - 1, 7) = Datos(7)
         .TextMatrix(.Rows - 1, 8) = Datos(8)
         .TextMatrix(.Rows - 1, 9) = Datos(9)
         .TextMatrix(.Rows - 1, 10) = Datos(10)
         .TextMatrix(.Rows - 1, 11) = Datos(11)
         .TextMatrix(.Rows - 1, 12) = Datos(12)
         .TextMatrix(.Rows - 1, 13) = Datos(13)
         .TextMatrix(.Rows - 1, 14) = Datos(14)
         .TextMatrix(.Rows - 1, 15) = IIf(Datos(17) = 0, Datos(16), x)
         .TextMatrix(.Rows - 1, 16) = Space(1) & IIf(Datos(15) = "", "", Datos(15))
         .TextMatrix(.Rows - 1, 17) = Datos(17)
         If Mid(Datos(12), 1, 2) = "32" And Datos(16) = 8 Then
            .TextMatrix(.Rows - 1, 16) = " " & Format(Datos(15), "#,##0.0000")
         End If
         Mensaje = Datos(11)
         If Datos(20) = "N" Then
            PREFORMATO = True
         End If
         .RowHeight(.Rows - 1) = 315
         .Rows = .Rows + 1
      Next x
      
   Loop

   '<< elimina la ultima fila de la grilla que queda siempre en blanco >>
   '<< y deshabilita la toolbar y la grilla en el caso de no tener info. >>
   If .Rows > 2 Then
      .RemoveItem (.Rows)
   ElseIf .Rows = 2 Then
      If .TextMatrix(.Rows - 1, 0) = "" Then
         .Rows = 1
         .Enabled = False
         .FocusRect = flexFocusLight
         Me.Toolbar1.Buttons(2).Enabled = False
         Me.Toolbar1.Buttons(4).Enabled = False
      End If
   End If

End With

   If Hay = False Then
      MsgBox "No se Encontro Clasificación pare Mensaje Swift ... ", vbInformation, TITSISTEMA
      Mensaje = ""
      Unload Me
   End If

End Sub

Private Sub Grid_KeyPress(KeyAscii As Integer)
   Select Case KeyAscii
      Case Is <> 27
      
         Select Case Me.Grid.ColSel
            Case 16
               Call PROC_POSI_TEXTO(Me.Grid, Me.txtGlosa)
               If vbKeyReturn = KeyAscii Then
                  Me.txtGlosa.Text = Me.Grid.TextMatrix(Me.Grid.RowSel, Me.Grid.ColSel)
               Else
                  Me.txtGlosa.Text = UCase(Chr(KeyAscii))
               End If
                  
               Toolbar1.Buttons(2).Enabled = True
               Toolbar1.Buttons(4).Enabled = False
      
               Me.txtGlosa.SelStart = Len(Me.txtGlosa)
               Me.txtGlosa.Visible = True
               Me.txtGlosa.SetFocus
         End Select
      
   End Select
End Sub

Private Sub Grid_RowColChange()
   Me.txtGlosa.Visible = False
   Me.Grid.SetFocus
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case UCase(Button.Key)
      Case Is = UCase("guardar")
         If guardar = False Then
            MsgBox "Problemas en la Grabacion de los Datos", vbExclamation, TITSISTEMA
         Else
            grabo = True
            Me.Toolbar1.Buttons(2).Enabled = False
            Me.Toolbar1.Buttons(4).Enabled = True
         End If

      Case Is = UCase("Imprimir")
         If grabo = False And Toolbar1.Buttons(2).Enabled = True Then
            MsgBox "Debe Guardar los Datos antes de Imprimir..", vbInformation, TITSISTEMA
         Else
            Call Reporte
         End If
      Case Is = UCase("Eliminar")
      Case Is = UCase("Buscar")
      Case Is = UCase("InterfazSwift")
         Call GeneraInterfazSwift
      Case Is = UCase("Cerrar")
         Unload Me
   End Select
End Sub

Function GeneraInterfazSwift()
Dim Datos()
Dim cNomArchivo As String
Dim cRuta As String

   Envia = Array()
   AddParam Envia, 4
   AddParam Envia, "BCC"
   AddParam Envia, "PTAS"
   If Not Bac_Sql_Execute("Sp_BacInterfaces_Archivo", Envia) Then
      Screen.MousePointer = 0
      MsgBox "Problemas al buscar la" & Chr(13) & "ruta de acceso de la interfaz", vbCritical, TITSISTEMA
      Exit Function
   Else
      If Bac_SQL_Fetch(Datos()) Then
         cNomArchivo = Datos(2)
         If Right(Datos(4), 1) <> "\" Then
            cRuta = Datos(4) & "\"
         Else
            cRuta = Datos(4)
         End If
      End If
   End If

        Numero_referencia = CDbl(BacGenMensaje.GRD_mensajes.TextMatrix(BacGenMensaje.GRD_mensajes.Row, 3))
        Envia = Array()
        AddParam Envia, Numero_referencia
        AddParam Envia, Numero_referencia
        AddParam Envia, Trim(Grid.TextMatrix(Grid.Row, 11))
        If Not Bac_Sql_Execute("Sp_Genera_Interfaz_Swift ", Envia) Then
           MsgBox "Problemas en la carga de Datos", vbExclamation, TITSISTEMA
           Exit Function
        End If

         x = 0
         Do While Bac_SQL_Fetch(Datos())
            x = x + 1
            Arreglo(x, 1) = Datos(1)
         Loop
         
         cNomArchivo = cRuta & cNomArchivo & Trim(Str(Numero_referencia)) & ".msg"
         Open cNomArchivo For Output As #1

         cabezera = "0000" & "    " & "SWI" & "                                                                 {1:F01XXXX          }{2:I" & Mid(Mensaje, 4, 3) & "XXXXN}{4:"

         Call Largos

         cabezera = "{1:F01BADECLRMAXXX0000000000}{2:I" & Mid(Mensaje, 4, 3) & recibim & "XXXXN3}{4:"

         Print #1, cabezera

   Call Detalle

   Print #1, inter5

   Close #1

   MsgBox "Interfaz SWIFT ha sido generada satisfactoriamente", vbInformation, TITSISTEMA
   

   Envia = Array()
   AddParam Envia, Trim(BacGenMensaje.GRD_mensajes.TextMatrix(BacGenMensaje.GRD_mensajes.Row, 8))
   AddParam Envia, CDbl(BacGenMensaje.GRD_mensajes.TextMatrix(BacGenMensaje.GRD_mensajes.Row, 3))
   If Not Bac_Sql_Execute("sp_btr_cambia_estado_lbtr", Envia) Then
       MsgBox "Error al actualizar MDLBTR", vbExclamation
       Exit Function
   End If
     
   
End Function

Function Largos()
Dim lens       As Integer
Dim aux        As String
Dim lendatos   As Integer
Dim Datos()
Dim AUX1       As Integer
Dim cMonto     As String
Dim Sw         As Integer

largo = 0
e = 0
   
For T = 1 To x

      Sw = 0
      Envia = Array()
      AddParam Envia, CDbl(BacGenMensaje.GRD_mensajes.TextMatrix(BacGenMensaje.GRD_mensajes.Row, 3))
      AddParam Envia, CDbl(BacGenMensaje.GRD_mensajes.TextMatrix(BacGenMensaje.GRD_mensajes.Row, 3))
      AddParam Envia, Trim(Grid.TextMatrix(Grid.Row, 11))
      AddParam Envia, Trim(Grid.TextMatrix(Grid.Row, 3))
      AddParam Envia, Arreglo(T, 1)
      If Not Bac_Sql_Execute("Sp_Trae_Descripcion_Swift  ", Envia) Then
         MsgBox "Problemas en la carga de Datos", vbExclamation, TITSISTEMA
         Exit Function
      End If
      Debug.Print VerSql
      
      Do While Bac_SQL_Fetch(Datos())
         lendatos = Len(Datos(1))
         Cambio = Mid(Datos(1), 2, lendatos)
      
       If Sw = 0 Then
          aux = ""
          If BuscarLetraSwift(Arreglo(T, 1)) = True Then
             aux = ":" & Arreglo(T, 1) & ":"
          Else
             aux = Arreglo(T, 1) & ":"
          End If
                    
          aux = aux & Cambio
          largo = largo + Len(aux) + 2
          Sw = 1
       Else
          If Val(Cambio) <> 0 Then
            If Arreglo(T, 1) = "32A" Then
               Cambio = CambioPuntuacion(CStr(Cambio))
               largo = largo + Len(Cambio) + 2
            Else
               Call CambiaFormato(Trim(Cambio))
               largo = largo + Len(Cambio) + 2
            End If
          Else
            largo = largo + Len(Cambio) + 2
          End If
          
       End If
    Loop
   
Next T

inter5 = "-}"

AUX1 = Len(recibim) + Len(entrega)
lens = Len(cabezera) + AUX1 '+ Len(inter5)
largo = largo + lens + 2
largo = largo - 6
End Function

Private Function CambioPuntuacion(cValor As String) As String
   Dim x             As String
   Dim cNuevoValor   As String
   Dim cCadena       As String
   Dim xx            As Integer
   
   cNuevoValor = BacCtrlTransMonto(cValor)
   cCadena = ""
   For xx = 1 To Len(cNuevoValor)
       
       If Mid(cNuevoValor, xx, 1) = "," Then
          cCadena = cCadena & ",0"
          Exit For
       End If
       If Mid(cNuevoValor, xx, 1) <> "." Then
         
         cCadena = cCadena + Mid(cNuevoValor, xx, 1)
         
       End If
   Next xx

   CambioPuntuacion = cCadena

End Function

Function BuscarLetraSwift(nValor As Variant) As Boolean
Dim cLargo As Long
Dim x      As Integer
   
   BuscarLetraSwift = True
   cLargo = Len(nValor)
   
   If Not IsNumeric(Mid(nValor, 1, 1)) Then
      BuscarLetraSwift = False
   End If

End Function


Function Detalle()
Dim lendatos As Integer
Dim Datos()
Dim Sw As Integer
Dim Interfaz_Lbtr As String

Cambio = ""
e = 0

For T = 1 To x
   Sw = 0
   
      Envia = Array()
      AddParam Envia, CDbl(BacGenMensaje.GRD_mensajes.TextMatrix(BacGenMensaje.GRD_mensajes.Row, 3))
      AddParam Envia, CDbl(BacGenMensaje.GRD_mensajes.TextMatrix(BacGenMensaje.GRD_mensajes.Row, 3))
      AddParam Envia, Trim(Grid.TextMatrix(Grid.Row, 11))
      AddParam Envia, Trim(Grid.TextMatrix(Grid.Row, 3))
      AddParam Envia, Arreglo(T, 1)
      If Not Bac_Sql_Execute("Sp_Trae_Descripcion_Swift  ", Envia) Then
         MsgBox "Problemas en la carga de Datos", vbExclamation, TITSISTEMA
         Exit Function
      End If
      Debug.Print VerSql
      Do While Bac_SQL_Fetch(Datos())
         lendatos = Len(Datos(1))
         Cambio = Datos(1)
       
         If Sw = 0 Then
              If BuscarLetraSwift(Arreglo(T, 1)) = True Then
                 Interfaz_Lbtr = ":" & Arreglo(T, 1) & ":"
              Else
                 Interfaz_Lbtr = Arreglo(T, 1) & ":"
              End If
               
               Interfaz_Lbtr = Interfaz_Lbtr & Cambio
               Print #1, Interfaz_Lbtr
               Sw = 1
         Else
              If Val(Cambio) <> 0 Then
                   If Arreglo(T, 1) = "32A" Then
                      Cambio = CambioPuntuacion(CStr(Cambio))
                   Else
                      Call CambiaFormato(Trim(Cambio))
                   End If
                
                   Interfaz_Lbtr = Cambio
                   Print #1, Interfaz_Lbtr
              Else
                   Interfaz_Lbtr = Cambio
                   Print #1, Interfaz_Lbtr
              End If
         End If
    Loop
   
Next T
      
End Function


Function CambiaFormato(Valor As Variant)
Dim LenValor      As Integer
Dim nNuevoValor   As Variant

nNuevoValor = BacCtrlTransMonto(Valor)

LenValor = Len(Valor)
Cambio = ""

For e = 1 To LenValor
   If Mid(Valor, e, 1) = "," Then
      
   ElseIf Mid(Valor, e, 1) = "." Then
       e = LenValor
   Else
      Cambio = Cambio + Mid(Valor, e, 1)
   End If
Next e

Cambio = Cambio & ",0"

End Function

Function SacaSiglo()
Dim LenValor As Integer
   
   LenValor = Len(Cambio)
   Cambio = Mid(Cambio, 3, LenValor)

End Function

Private Sub txtglosa_KeyDown(KeyCode As Integer, Shift As Integer)
   Select Case KeyCode
      Case vbKeyReturn
         Me.Grid.TextMatrix(Me.Grid.RowSel, Me.Grid.ColSel) = Me.txtGlosa.Text
         Me.txtGlosa.Visible = False
         Me.Grid.SetFocus
      Case 27
         Me.txtGlosa.Visible = False
         Me.Grid.SetFocus
   End Select
End Sub

Private Sub txtGlosa_KeyPress(KeyAscii As Integer)
   KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub

Sub Reporte()
   On Error GoTo Err_Print
   
   Call limpiar_cristal
   
   BACSwapParametros.BACParam.ReportFileName = gsRPT_Path & "Mensajes_Swift_LBtr.Rpt"
'   Call Proc_Establece_Ubicacion(BacTrader.BacRpt)
   BACSwapParametros.BACParam.Connect = SwConeccion
   BACSwapParametros.BACParam.Destination = crptToWindow   '= crptToPrinter
   BACSwapParametros.BACParam.WindowTitle = " MENSAJES SWIFT "
   'BACSwapParametros.BACParam.StoredProcParam(0) = gsBAC_User
   'BACSwapParametros.BACParam.StoredProcParam(1) = CDbl(BacGenMensaje.GRD_mensajes.TextMatrix(BacGenMensaje.GRD_mensajes.Row, 3))
   BACSwapParametros.BACParam.StoredProcParam(0) = CDbl(BacGenMensaje.GRD_mensajes.TextMatrix(BacGenMensaje.GRD_mensajes.Row, 3))
   'BACSwapParametros.BACParam.StoredProcParam(3) = Trim(BacGenMensaje.GRD_mensajes.TextMatrix(BacGenMensaje.GRD_mensajes.Row, 8))
   BACSwapParametros.BACParam.Action = 1
   'BacTrader.TmrMsg.Enabled = True
 
          
   On Error GoTo 0
   Exit Sub
   
Err_Print:
   MsgBox BACSwapParametros.BACParam.ReportFileName & ", " & Err.Description, vbInformation, TITSISTEMA
End Sub

Function guardar() As Boolean
   '<< graba movimientos detalle >>
   Dim Datos()
   Dim Id_Sistema              As String
   Dim Correlativo             As Double
   Dim Descripcion             As String
   Dim Estado_Graba            As Boolean
   Dim x                       As Integer
   Dim Contador                As Integer
   Dim Valor_Nuevo As String
   Dim Numero_Operacion       As Double
   Dim numero_Swif
   
   Contador = 2
   guardar = False
   
   If Not BacBeginTransaction() Then
      Exit Function
   End If
   
   With BacGenMensaje.GRD_mensajes
      Id_Sistema = Trim(.TextMatrix(.Row, 8))
      Numero_Operacion = CDbl(.TextMatrix(.Row, 3))
      numero_Swif = Numero_Operacion
   End With

   With Me.Grid
      For x = 1 To .Rows - 1
            Descripcion = .TextMatrix(x, 16) ' & Space(10) & "X"
            If x = 1 Then
               Envia = Array()
               AddParam Envia, Id_Sistema
               AddParam Envia, Numero_Operacion
               AddParam Envia, numero_Swif
               AddParam Envia, .TextMatrix(x, 11) 'codigo_mensaje_swift
               AddParam Envia, .TextMatrix(x, 12) 'Campo Nombre
               AddParam Envia, .TextMatrix(x, 13) 'Campo Opcion
               AddParam Envia, .TextMatrix(x, 14) 'Campo Tipo
               AddParam Envia, .TextMatrix(x, 15) 'correlativo
               AddParam Envia, Descripcion
               AddParam Envia, 1
               If Not Bac_Sql_Execute("SP_GRABA_SWIFT_MOVIMIENTO_DETALLE ", Envia) Then
                  Call BacRollBackTransaction
                  MsgBox "Problemas en la Grabación", vbExclamation, TITSISTEMA
               End If
            End If
            
            Envia = Array()
            AddParam Envia, Id_Sistema
            AddParam Envia, Numero_Operacion
            AddParam Envia, numero_Swif
            AddParam Envia, .TextMatrix(x, 11) 'codigo_mensaje_swift
            AddParam Envia, .TextMatrix(x, 12) 'Campo Nombre
            AddParam Envia, .TextMatrix(x, 13) 'Campo Opcion
            AddParam Envia, .TextMatrix(x, 14) 'Campo Tipo
            AddParam Envia, .TextMatrix(x, 15) 'correlativo
            AddParam Envia, Descripcion
            AddParam Envia, 2
            If Not Bac_Sql_Execute("SP_GRABA_SWIFT_MOVIMIENTO_DETALLE ", Envia) Then
               Call BacRollBackTransaction
               MsgBox "Problemas en la Grabación", vbExclamation, TITSISTEMA
               Exit Function
            End If
            If Bac_SQL_Fetch(Datos()) Then
               If Datos(1) = -1 Then
                  Call BacRollBackTransaction
                  Exit Function
               End If
         End If
      Next x
   End With
   
   Call BacCommitTransaction
   guardar = True

End Function

Sub PreFormatoSwift()
   Dim xCampo        As String
   Dim xCampo_AUX    As String
   Dim Correlativo   As Integer
   Dim xRut          As Double
   Dim xMoneda       As String
   Dim xMensaje      As String
   Dim xMonto        As Double
   Dim xF_Vcto       As String
   Dim xF_Proc       As String
   Dim xNumOpe       As String
   Dim x             As Integer
   Dim Y             As Integer
   Dim Datos()
   Dim Contador      As Integer
   Dim Entro         As Boolean
   Dim iMonedaPeso   As Boolean
   iMonedaPeso = False
   Correlativo = 0
   xCampo_AUX = ""
   xCampo = ""

      For x = 1 To Me.Grid.Rows - 1
         With Me.Grid
             If x = 1 Then
               xCampo_AUX = .TextMatrix(x, 12)
               xCampo = xCampo_AUX
             Else
               xCampo = .TextMatrix(x, 12)
             End If
             
             If xCampo = xCampo_AUX Then
               Correlativo = Correlativo + 1
             Else
               xCampo_AUX = xCampo
               Correlativo = 1
             End If
         End With

   With BacGenMensaje.GRD_mensajes
         Dim Mercado As String
         
            Envia = Array()
            AddParam Envia, CDbl(.TextMatrix(.Row, 3))                 ' MONUMOPE
            AddParam Envia, .TextMatrix(.Row, 8)                       ' ID_SISTEMA
            AddParam Envia, "MT 202"
            AddParam Envia, Val(Correlativo)                           ' CORRELATIVO
            AddParam Envia, xCampo
         If Not Bac_Sql_Execute("Sp_Trae_PreFormato_Swift ", Envia) Then
            MsgBox "Problemas en la Generación de Mensajes Swift"
            Exit Sub
         End If
         
        ' Debug.Print VerSql
         If Bac_SQL_Fetch(Datos()) Then
            If Datos(1) = -1 Then
               MsgBox Datos(2), vbInformation, Me.Caption
               Toolbar1.Buttons(1).Enabled = False
               Toolbar1.Buttons(2).Enabled = False
               Toolbar1.Buttons(3).Enabled = False
               Toolbar1.Buttons(4).Enabled = False
               Toolbar1.Buttons(5).Enabled = False
               Toolbar1.Buttons(6).Enabled = False
               Exit Sub
            End If
            
            If (Mid(xCampo, 1, 2) = "32" And Val(Correlativo) = 3) Or (Mid(xCampo, 1, 2) = "33" And Val(Correlativo) = 2) Then
               If iMonedaPeso = True And xCampo = "32A" And Val(Correlativo) = 3 Then
                  Me.Grid.TextMatrix(x, 16) = Space(1) + Format(Datos(1), "#,##")
               Else
                  Me.Grid.TextMatrix(x, 16) = Space(1) + Format(Datos(1), "#,##0.0000")
               End If
            Else
               If xCampo = "32A" And Val(Correlativo) = 2 And Datos(1) = "CLP" Then
                  iMonedaPeso = True
               End If
               Me.Grid.TextMatrix(x, 16) = Space(1) + CStr(Datos(1))
            End If
            If (Mid(xCampo, 1, 3) = "71F" And Val(Correlativo) = 1) Or (Mid(xCampo, 1, 3) = "71G" And Val(Correlativo) = 1) Then
               Me.Grid.TextMatrix(x, 16) = Space(1) + Format(Datos(1), "#,##0.0000")
            End If
         End If
     End With
   Next x
End Sub
