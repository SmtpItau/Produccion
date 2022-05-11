VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form Frm_Cierra_Mesa 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Abrir/Cerrar Mesa"
   ClientHeight    =   1755
   ClientLeft      =   2505
   ClientTop       =   3495
   ClientWidth     =   2955
   ForeColor       =   &H00C0C0C0&
   Icon            =   "Baccieme.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   1755
   ScaleWidth      =   2955
   Begin MSFlexGridLib.MSFlexGrid GridFolioSOMA 
      Height          =   1050
      Left            =   360
      TabIndex        =   7
      Top             =   4200
      Width           =   2415
      _ExtentX        =   4260
      _ExtentY        =   1852
      _Version        =   393216
      Rows            =   1
   End
   Begin MSFlexGridLib.MSFlexGrid GrillaControlSOMA 
      Height          =   1290
      Left            =   360
      TabIndex        =   6
      Top             =   2760
      Width           =   5295
      _ExtentX        =   9340
      _ExtentY        =   2275
      _Version        =   393216
      Cols            =   10
   End
   Begin Threed.SSFrame SSFrame3 
      Height          =   1170
      Left            =   15
      TabIndex        =   4
      Top             =   495
      Width           =   900
      _Version        =   65536
      _ExtentX        =   1587
      _ExtentY        =   2064
      _StockProps     =   14
      ForeColor       =   -2147483630
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin VB.Image Image1 
         Height          =   855
         Index           =   0
         Left            =   15
         Picture         =   "Baccieme.frx":030A
         Stretch         =   -1  'True
         Top             =   225
         Width           =   855
      End
   End
   Begin Threed.SSFrame SSFrame1 
      Height          =   1170
      Left            =   945
      TabIndex        =   0
      Top             =   495
      Width           =   1920
      _Version        =   65536
      _ExtentX        =   3387
      _ExtentY        =   2064
      _StockProps     =   14
      ForeColor       =   -2147483630
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin Threed.SSPanel SSPanel1 
         Height          =   510
         Left            =   150
         TabIndex        =   1
         Top             =   165
         Width           =   1605
         _Version        =   65536
         _ExtentX        =   2822
         _ExtentY        =   900
         _StockProps     =   15
         Caption         =   "Mesa de Dinero"
         ForeColor       =   -2147483630
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BevelOuter      =   0
         Font3D          =   2
      End
      Begin Threed.SSPanel PanelActivo 
         Height          =   330
         Left            =   150
         TabIndex        =   2
         Top             =   690
         Width           =   1605
         _Version        =   65536
         _ExtentX        =   2822
         _ExtentY        =   582
         _StockProps     =   15
         Caption         =   " "
         ForeColor       =   -2147483630
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BevelOuter      =   0
         Font3D          =   2
      End
   End
   Begin Threed.SSPanel SSPanel2 
      Height          =   1260
      Left            =   30
      TabIndex        =   5
      Top             =   480
      Width           =   2940
      _Version        =   65536
      _ExtentX        =   5186
      _ExtentY        =   2222
      _StockProps     =   15
      Caption         =   "SSPanel2"
      BackColor       =   12632256
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Height          =   480
      Left            =   0
      TabIndex        =   3
      Top             =   0
      Width           =   2970
      _ExtentX        =   5239
      _ExtentY        =   847
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   3
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   3975
      Top             =   150
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
            Picture         =   "Baccieme.frx":074C
            Key             =   "Rojo"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Baccieme.frx":0B9E
            Key             =   "Verde"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Baccieme.frx":0FF0
            Key             =   "Salir"
         EndProperty
      EndProperty
   End
   Begin VB.Image Image1 
      BorderStyle     =   1  'Fixed Single
      Height          =   540
      Index           =   1
      Left            =   30
      Picture         =   "Baccieme.frx":130A
      Top             =   1995
      Visible         =   0   'False
      Width           =   540
   End
   Begin VB.Image Image1 
      BorderStyle     =   1  'Fixed Single
      Height          =   540
      Index           =   2
      Left            =   570
      Picture         =   "Baccieme.frx":174C
      Top             =   1995
      Visible         =   0   'False
      Width           =   540
   End
End
Attribute VB_Name = "Frm_Cierra_Mesa"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim objCierreMesa As Object
Dim oPathSOMA       As String
Dim cNombreArchSOMA As String
Dim MsgAnulaSOMA    As String
Dim ContinuaCierre  As Boolean
Dim SwErrorArch     As Boolean
Public MiExcel      As Object
Public MiLibro      As Object

Private Sub Form_Load()
   Me.Left = 0
   Me.Top = 0
   Set objCierreMesa = New clsCierraMesa
   Call RefrescarMesa
End Sub
Sub RefrescarMesa()

   With objCierreMesa

      If Not .Lee_Mesa Then MsgBox "Problemas al Realizar Cierre de Mesa", vbCritical, TITSISTEMA

      If .CieMesa = "0" Then

         Frm_Cierra_Mesa.Image1(0).Picture = Frm_Cierra_Mesa.Image1(2).Picture
         Frm_Cierra_Mesa.Toolbar1.Buttons(1).Image = "Rojo"
         Frm_Cierra_Mesa.Toolbar1.Buttons(1).ToolTipText = "Bloquear Mesa"
         Frm_Cierra_Mesa.PanelActivo.Caption = "Activa"
         BacTrader.Opc_80200.Checked = False
        Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Mesa dinero activa " & TitRpt)
      Else

         Frm_Cierra_Mesa.Image1(0).Picture = Frm_Cierra_Mesa.Image1(1).Picture
         Frm_Cierra_Mesa.Toolbar1.Buttons(1).Image = "Verde"
         Frm_Cierra_Mesa.Toolbar1.Buttons(1).ToolTipText = "Desbloquear Mesa"
         Frm_Cierra_Mesa.PanelActivo.Caption = "Bloqueada"
         BacTrader.Opc_80200.Checked = True
        Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Mesa  dinero Bloqueada " & TitRpt)
      End If

   End With

End Sub



Private Sub Form_Unload(Cancel As Integer)

   Set objCierreMesa = Nothing

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   
   Dim SwBloqueo As Integer
   Dim Datos()
   
   With objCierreMesa
   
      Select Case Button.Index
         
         Case Is = 1
            
            .xValor = Not .xValor
            
           xValor = IIf(.xValor = False, "0", "1")
        
           If xValor = True Then
           
           'PRD-6010
           
' Usuario BacOffice solicita eliminar control de carga archivo SOMA al Cierre, por el momento.
           
'           If BacTrader.Opc_80200.Checked = False Then
'
'              Call Control_Carga_SOMA
'
'              If ContinuaCierre = False Then
'                 Exit Sub
'              End If
'           End If
            
            'PRD-6010
           
            If Not Bac_Sql_Execute("SP_BUSCA_OPERACIONES_FLI") Then
               Exit Sub
            End If
            If Bac_SQL_Fetch(Datos()) Then
               If Datos(1) <> 0 Then
                  MsgBox Datos(2), vbCritical
                  Exit Sub
               End If
            End If
        
           End If
            
            If Not .CierreMesa Then
               MsgBox "Problemas con el cierre de mesa.", vbExclamation, TITSISTEMA
               Exit Sub
            
            End If
            
            Call RefrescarMesa
         
         Case Else
            
            Unload Me
      
      End Select
   
   End With

End Sub


Private Sub Control_Carga_SOMA()
'PRD-6010
Dim nFila  As Long
Dim nResul  As Long
Dim Datos()
Dim Msg As String
Dim nTipoArchSOMA As Long
Dim Mensaje As String
  
  Envia = Array()
  AddParam Envia, 2    'Evento Trae Tipo de Archivo SOMA
  If Not Bac_Sql_Execute("dbo.SP_TRAE_GRABA_TIPO_ARCH_SOMA_ULT_CARGA", Envia) Then
       Let Me.MousePointer = vbDefault
       Call BacRollBackTransaction
       Call MsgBox("Se ha producido un error en la Busqueda de tipo de archivo SOMA.", vbCritical, App.Title)
       Exit Sub
  End If
           
  If Bac_SQL_Fetch(Datos()) Then
    nTipoArchSOMA = Val(Datos(1))
  End If
  
 Let Screen.MousePointer = vbHourglass
           
  If nTipoArchSOMA = 1 Then
     Call CargaArchivo_Soma(GrillaControlSOMA)
  Else
     Call CargaArchivo_Soma_Excel(GrillaControlSOMA)
   
  End If
  
  If SwErrorArch = True Then
      Exit Sub
  End If
  
   Let ContinuaCierre = False
   
      For nFila = 1 To GrillaControlSOMA.Rows - 1
        If GrillaControlSOMA.TextMatrix(nFila, 0) <> "" Then
             Envia = Array()
             AddParam Envia, CDbl(GrillaControlSOMA.TextMatrix(nFila, 7))

             If Not Bac_Sql_Execute("SP_BUSCA_FOLIO_BCCH", Envia) Then
                Call BacRollBackTransaction
                Call MsgBox("Se ha producido un error en la busqueda.", vbExclamation, App.Title)
                Exit Sub
             End If

             If Bac_SQL_Fetch(Datos()) Then
                nResul = Val(Datos(1))
             End If
             
             If nResul = 0 Then
                  Let Msg = Msg & CDbl(GrillaControlSOMA.TextMatrix(nFila, 7)) & "-" & CDbl(GrillaControlSOMA.TextMatrix(nFila, 8)) & vbCrLf
                  Call BACFLI.Grabar_Log_Carga_SOMA("FLI", CDbl(GrillaControlSOMA.TextMatrix(nFila, 7)), CDbl(GrillaControlSOMA.TextMatrix(nFila, 8)), GrillaControlSOMA.TextMatrix(nFila, 0), cNombreArchSOMA, "Cierre Mesa : Folio SOMA aún no ha sido cargado " & CDbl(GrillaControlSOMA.TextMatrix(nFila, 7)) & "-" & CDbl(GrillaControlSOMA.TextMatrix(nFila, 8)), 0, 0)
             End If

         End If
      Next nFila
            
      Call BACFLI.CargaFoliosSOMABac(GridFolioSOMA)
      
       If nTipoArchSOMA = 1 Then
          Call BuscaFolioAnulado(oPathSOMA, cNombreArchSOMA, GridFolioSOMA)
       Else
          Call BuscaFolioAnuladoExcel(oPathSOMA, cNombreArchSOMA, GridFolioSOMA)
       End If
       
       Let Screen.MousePointer = vbDefault
       If Msg = "" And MsgAnulaSOMA = "" Then
          Let Mensaje = " "
       Else
          Let Mensaje = "Los siguientes Folios SOMA aún no han sido cargados : "
       End If
       If MsgBox(Mensaje & vbCrLf & Msg _
              & vbCrLf & MsgAnulaSOMA & vbCrLf & "¿ Desea continuar con proceso de Cierre de Mesa ?", vbYesNo + vbQuestion) = vbYes Then   ''And xValor = False
            Let ContinuaCierre = True
            Exit Sub
       Else
            Let ContinuaCierre = False
       End If
'PRD-6010
End Sub


Private Function CargaArchivo_Soma(ByRef xGrilla As MSFlexGrid) As Boolean
'PRD-6010
   Dim Sql$, Datos(), xLine$
   Dim nContador  As Long
   Dim nEstado    As Long
   Dim Arreglo()  As String
   Dim x As Long
   Dim ContLinea  As Long
   Dim nNumoper   As Long
   Dim nCorrela   As Long
   Dim nValida    As Long
   Dim nFilas     As Long
   Dim nFilFolio  As Long
   Dim error      As String
   Dim Msg        As String
   Dim sSerie     As String
   Dim nRutEmisor As Double
   
   Dim nResul     As Long
   Dim CantFolioSOMA  As Long
   
   Let error = ""
   Let Msg = ""
   
   Let SwErrorArch = False
   
   ContLinea = 0
   nContador = 0
   
   If Right(gsBac_DIRSOMA, 1) <> "\" Then
      Let gsBac_DIRSOMA = gsBac_DIRSOMA & "\"
   End If
   
   Let cNombreArchSOMA = "Fli" & Format(gsBac_Fecp, "YY") & Format(gsBac_Fecp, "MM") & Format(gsBac_Fecp, "DD") & ".txt"
   Let oPathSOMA = gsBac_DIRSOMA & cNombreArchSOMA

   If Dir(oPathSOMA) = "" Then
      Let Screen.MousePointer = vbDefault
      If MsgBox("El archivo requerido para la carga. [" & cNombreArchSOMA & "]. no se encuentra... Favor Revisar." & "¿ Desea continuar con proceso de Cierre de Mesa ?", vbYesNo + vbQuestion) = vbYes Then
        Let SwErrorArch = True
        Let ContinuaCierre = True
      Else
         Let ContinuaCierre = False
         Let SwErrorArch = True
      End If
      Exit Function
   End If
   
   xGrilla.Clear
   Let xGrilla.Rows = 2
   Let CantFolioSOMA = 0
      
   '-- carga operaciones
    On Error GoTo errOpen
    Open oPathSOMA For Input Access Read Shared As #1
    
    On Error GoTo errRead
        
    Do While Not EOF(1)
    
               
        Line Input #1, xLine
       
       
         Arreglo = Split(xLine, vbTab)
         nEstado = 0
         
         If EOF(1) Then
            If xLine = "" Then
               Exit Do
            End If
         End If
         
            
         If Arreglo(0) = "ID" Then
             ContLinea = 0
         End If
               
         
         ContLinea = ContLinea + 1
        
        If ContLinea = 1 Then
        
                For x = 0 To UBound(Arreglo)
         
                  Select Case nEstado
                    Case 0
                        If Arreglo(x) = "ID" Then
                            nEstado = 1
                        Else
                            GoTo errRead
                        End If
                    Case 1
                        If Arreglo(x) = "Fecha" Then
                            nEstado = 2
                        Else
                            GoTo errRead
                        End If
                    Case 2
                        If Arreglo(x) = "Institucion" Then
                            nEstado = 3
                        Else
                            GoTo errRead
                        End If
                    Case 3
                        If Arreglo(x) = "Monto Nominal" Then
                            Exit For
                        Else
                            GoTo errRead
                        End If
                  End Select
        
                Next x
        
        End If
        
        If ContLinea = 2 Then
             nNumoper = Arreglo(0)

        End If
        
        
        If ContLinea = 3 Then
       
        
                For x = 0 To UBound(Arreglo)
         
                  Select Case nEstado
                    Case 0
                        If Arreglo(x) = "Correlativo" Then
                            nEstado = 1
                            
                        Else
                            GoTo errRead
                        End If
                    Case 1
                        If Arreglo(x) = "Mnemotecnico" Then
                            nEstado = 2
                        Else
                            GoTo errRead
                        End If
                    Case 2
                        If Arreglo(x) = "Monto Nominal" Then
                            nEstado = 3
                        Else
                            GoTo errRead
                        End If
                    Case 3
                        If Arreglo(x) = "Valor Inicial" Then
                            Exit For
                        Else
                            GoTo errRead
                        End If
                  End Select
                  
                  
        
                Next x
        
        
        End If
        
        If ContLinea >= 4 Then
        
            
        
             Envia = Array()
             AddParam Envia, CDbl(nNumoper)
             AddParam Envia, Arreglo(1)
             AddParam Envia, gsBac_User
             AddParam Envia, ""
             AddParam Envia, ""
             AddParam Envia, 0
             AddParam Envia, "FLI"
                            
             If Not Bac_Sql_Execute("SP_VALIDAARCHIVO_BCCH", Envia) Then
                Call BacRollBackTransaction
                Call MsgBox("Se ha producido un error en la busqueda.", vbExclamation, App.Title)
                Exit Function
             End If
                    
             If Bac_SQL_Fetch(Datos()) Then
                nValida = Val(Datos(1))
                sSerie = Datos(2)
                nRutEmisor = Datos(3)
             End If


           If Arreglo(0) <> "" Then ''And nValida = 0 Then
              Let xGrilla.TextMatrix(xGrilla.Rows - 1, 0) = sSerie
              Let xGrilla.TextMatrix(xGrilla.Rows - 1, 1) = Format(CDbl(Arreglo(2)), FDec4Dec)
              Let xGrilla.TextMatrix(xGrilla.Rows - 1, 2) = 0#
              Let xGrilla.TextMatrix(xGrilla.Rows - 1, 3) = 0#
              Let xGrilla.TextMatrix(xGrilla.Rows - 1, 4) = 0
              Let xGrilla.TextMatrix(xGrilla.Rows - 1, 5) = 0#
              Let xGrilla.TextMatrix(xGrilla.Rows - 1, 6) = Format(CDbl(Arreglo(3)), FDec4Dec)
              Let xGrilla.TextMatrix(xGrilla.Rows - 1, 7) = Format(CDbl(nNumoper), FDec0Dec)
              Let xGrilla.TextMatrix(xGrilla.Rows - 1, 8) = Format(CDbl(Arreglo(0)), FDec0Dec)
              Let xGrilla.TextMatrix(xGrilla.Rows - 1, 9) = nRutEmisor
              
              Let xGrilla.Rows = xGrilla.Rows + 1
              
           End If
        End If

          
        
        nContador = nContador + 1

    Loop
    
    
  If Len(error) > 0 Or Len(ErrAnula) > 0 Then
      Call MsgBox("Se han encontrado las siguientes Observaciones:" & vbCrLf & vbCrLf & error & vbCrLf & ErrAnula & vbCrLf, vbExclamation, App.Title)
  End If
           
    Close #1

    Exit Function
    
   
errOpen:
    Exit Function
    
errRead:
    Let Screen.MousePointer = vbDefault
    If MsgBox("No se pudo continuar la lectura del archivo. Favor Revisar." & oPathSOMA & vbCrLf & "¿ Desea continuar con proceso de Cierre de Mesa ?", vbYesNo + vbQuestion) = vbYes Then   ''err.Description, vbCritical
        Let SwErrorArch = True
        Let ContinuaCierre = True
        Exit Function
    Else
         Let ContinuaCierre = False
         Let SwErrorArch = True
    End If
    
'PRD-6010
End Function


Private Sub BuscaFolioAnulado(ruta As String, NombreArchivo As String, ByRef xGrilla As MSFlexGrid)
'PRD-6010
Dim xLine
Dim nFilFolio As Long
Dim nResul    As Long
Dim oFile     As String
Dim Msg       As String

Let ErrAnula = ""
Let Msg = ""
Let MsgAnulaSOMA = ""
           
               For nFilFolio = 1 To xGrilla.Rows - 1
                  Open ruta For Input Access Read Shared As #1
                   Do While Not EOF(1)
                   
                    Line Input #1, xLine
                   If xGrilla.TextMatrix(nFilFolio, 0) <> 0 Then
                    If InStr(xLine, xGrilla.TextMatrix(nFilFolio, 0)) = 0 Then
                        Let nResul = nResul + 1
                    Else
                        Let nResul = 0
                        Exit Do
                    End If
                   End If
                   Loop
                   
                   
                    If nResul > 1 Then
                       Let ErrAnula = ErrAnula & " Falta anular operación FLI en BAC con número [" & CDbl(xGrilla.TextMatrix(nFilFolio, 1)) & "], que referencia a folio SOMA[" & CDbl(xGrilla.TextMatrix(nFilFolio, 0)) & "], que ya no existe en archivo [" & NombreArchivo & "]" & vbCrLf
                       Let Msg = "Debe Anular Oparación FLI en BAC [" & CDbl(xGrilla.TextMatrix(nFilFolio, 1)) & "], ya que no existe Folio SOMA [" & CDbl(xGrilla.TextMatrix(nFilFolio, 0)) & "] en Archivo [" & NombreArchivo & "]" & vbCrLf
                       Call BACFLI.Grabar_Log_Carga_SOMA("FLI", CDbl(xGrilla.TextMatrix(nFilFolio, 0)), 0, "", cNombreArchSOMA, "Cierre Mesa : " & Msg, 0, 0)
                       nResul = 0
                    End If
                    
                    Close #1
                    Let MsgAnulaSOMA = MsgAnulaSOMA & Msg
                    
               Next nFilFolio
                   
'PRD-6010
End Sub

Public Function CargaArchivo_Soma_Excel(ByRef xGrilla As MSFlexGrid) As Boolean
'PRD-6010
   Dim oFile      As String
   Dim MiHoja     As Object
   Dim nFilas     As Long
   Dim nContador  As Long
   Dim nSwith     As Boolean
      
   Dim CantFolioSOMA As Long
   Dim ContLinea     As Long
   Dim x             As Long
   Dim nEstado       As Long
   Dim Datos()
   Dim Msg           As String
   Dim error         As String
   Dim nNumoper      As Long
   Dim nValida       As Long
   Dim sSerie        As String
   Dim nRutEmisor    As Double
   
   If Right(gsBac_DIRSOMA, 1) <> "\" Then
      Let gsBac_DIRSOMA = gsBac_DIRSOMA & "\"
   End If
   
   Let SwErrorArch = False
   Let cNombreArchSOMA = "Fli" & Format(gsBac_Fecp, "YY") & Format(gsBac_Fecp, "MM") & Format(gsBac_Fecp, "DD") & ".xlsx"
   Let oPathSOMA = gsBac_DIRSOMA & cNombreArchSOMA

   If Dir(oPathSOMA) = "" Then
      Let Screen.MousePointer = vbDefault
      If MsgBox("El archivo requerido para la carga. [" & cNombreArchSOMA & "]. no se encuentra... Favor Revisar." & "¿ Desea continuar con proceso de Cierre de Mesa ?", vbYesNo + vbQuestion) = vbYes Then
        Let SwErrorArch = True
        Let ContinuaCierre = True
      Else
         Let ContinuaCierre = False
         Let SwErrorArch = True
      End If
      Exit Function
   End If
    
   Let error = ""
   Let Msg = ""
  

   ContLinea = 0
   nContador = 0
   
   xGrilla.Clear

   Let xGrilla.Rows = 2
   Let xGrilla.Redraw = False

   Let CantFolioSOMA = 0

   Let nFilas = 50

   Set MiExcel = CreateObject("Excel.Application")
   Set MiLibro = MiExcel.Workbooks.Open(oPathSOMA)

   Set MiHoja = Nothing
   Set MiHoja = MiLibro.Worksheets("FLI")

   
   On Error GoTo errRead

   For nContador = 2 To nFilas

      Let nEstado = 0
      
      
      If (UCase(MiHoja.Cells(nContador - 1, "A")) <> UCase("")) Then ' if para celda ""
      
         If (UCase(MiHoja.Cells(nContador - 1, "A")) = UCase("ID")) Then
             ContLinea = 0
         End If
               
         
         ContLinea = ContLinea + 1
        
        If ContLinea = 1 Then

                For x = 0 To 3

                  Select Case nEstado
                    Case 0
                        If (UCase(MiHoja.Cells(nContador - 1, "A")) = UCase("ID")) Then
                            nEstado = 1
                        Else
                            GoTo errRead
                        End If
                    Case 1
                        If (UCase(MiHoja.Cells(nContador - 1, "B")) = UCase("Fecha")) Then
                            nEstado = 2
                        Else
                            GoTo errRead
                        End If
                    Case 2
                        If (UCase(MiHoja.Cells(nContador - 1, "C")) = UCase("Institucion")) Then
                            nEstado = 3
                        Else
                            GoTo errRead
                        End If
                    Case 3
                        If (UCase(MiHoja.Cells(nContador - 1, "D")) = UCase("Monto Nominal")) Then
                            Exit For
                        Else
                            GoTo errRead
                        End If
                  End Select

                Next x

        End If
        
        
        If ContLinea = 2 Then
             nNumoper = UCase(MiHoja.Cells(nContador - 1, "A"))

        End If
        
        
        If ContLinea = 3 Then


                For x = 0 To 3

                  Select Case nEstado
                    Case 0
                        If (UCase(MiHoja.Cells(nContador - 1, "A")) = UCase("Correlativo")) Then
                            nEstado = 1

                        Else
                            GoTo errRead
                        End If
                    Case 1
                        If (UCase(MiHoja.Cells(nContador - 1, "B")) = UCase("Mnemotecnico")) Then
                            nEstado = 2
                        Else
                            GoTo errRead
                        End If
                    Case 2
                        If (UCase(MiHoja.Cells(nContador - 1, "C")) = UCase("Monto Nominal")) Then
                            nEstado = 3
                        Else
                            GoTo errRead
                        End If
                    Case 3
                        If (UCase(MiHoja.Cells(nContador - 1, "D")) = UCase("Valor Inicial")) Then
                            Exit For
                        Else
                            GoTo errRead
                        End If
                  End Select



                Next x


        End If
        

        If ContLinea >= 4 Then

             Envia = Array()
             AddParam Envia, CDbl(nNumoper)
             AddParam Envia, UCase(MiHoja.Cells(nContador - 1, "B"))
             AddParam Envia, gsBac_User
             AddParam Envia, ""
             AddParam Envia, ""
             AddParam Envia, 0
             AddParam Envia, "FLI"

             If Not Bac_Sql_Execute("SP_VALIDAARCHIVO_BCCH", Envia) Then
                Call BacRollBackTransaction
                Call MsgBox("Se ha producido un error en la busqueda.", vbExclamation, App.Title)
                Exit Function
             End If

             If Bac_SQL_Fetch(Datos()) Then
                nValida = Val(Datos(1))
                sSerie = Datos(2)
                nRutEmisor = Datos(3)
             End If


           If UCase(MiHoja.Cells(nContador - 1, "A")) <> "" Then  ''And nValida = 0
              Let xGrilla.TextMatrix(xGrilla.Rows - 1, 0) = sSerie
              Let xGrilla.TextMatrix(xGrilla.Rows - 1, 1) = Format(CDbl(UCase(MiHoja.Cells(nContador - 1, "C"))), FDec4Dec)
              Let xGrilla.TextMatrix(xGrilla.Rows - 1, 2) = 0#
              Let xGrilla.TextMatrix(xGrilla.Rows - 1, 3) = 0#
              Let xGrilla.TextMatrix(xGrilla.Rows - 1, 4) = 0
              Let xGrilla.TextMatrix(xGrilla.Rows - 1, 5) = 0#
              Let xGrilla.TextMatrix(xGrilla.Rows - 1, 6) = Format(CDbl(UCase(MiHoja.Cells(nContador - 1, "D"))), FDec4Dec)
              Let xGrilla.TextMatrix(xGrilla.Rows - 1, 7) = Format(CDbl(nNumoper), FDec0Dec)
              Let xGrilla.TextMatrix(xGrilla.Rows - 1, 8) = Format(CDbl(UCase(MiHoja.Cells(nContador - 1, "A"))), FDec0Dec)
              Let xGrilla.TextMatrix(xGrilla.Rows - 1, 9) = nRutEmisor

              Let xGrilla.Rows = xGrilla.Rows + 1


           End If


        End If

        

        
    End If   ' if para celda ""
              
   Next nContador
   
   If Len(error) > 0 Or Len(ErrAnula) > 0 Then
      Call MsgBox("Se han encontrado las siguientes Observaciones:" & vbCrLf & vbCrLf & error & vbCrLf & ErrAnula & vbCrLf, vbExclamation, App.Title)
   End If
   
   
   Set MiHoja = Nothing
   Call MiLibro.Close
   Set MiExcel = Nothing
   
   Let xGrilla.Redraw = True
   
   Exit Function
   
errRead:
    Let Screen.MousePointer = vbDefault
    If MsgBox("No se pudo continuar la lectura del archivo. Favor Revisar." & oPathSOMA & vbCrLf & "¿ Desea continuar con proceso de Cierre de Mesa ?", vbYesNo + vbQuestion) = vbYes Then   ''err.Description, vbCritical
        Let SwErrorArch = True
        Let ContinuaCierre = True
        Exit Function
    Else
         Let ContinuaCierre = False
         Let SwErrorArch = True
    End If

   
'PRD-6010
End Function


Public Sub BuscaFolioAnuladoExcel(ruta As String, NombreArchivo As String, ByRef xGrilla As MSFlexGrid)
'PRD-6010
Dim xLine
Dim nFilFolio As Long
Dim nResul    As Long
Dim oFile     As String
Dim Msg       As String
Dim oPath     As String
Dim MiHoja    As Object
Dim nContador As Long
Dim nFilas    As Long
Dim ContLinea As Long
Dim x         As Long
Dim nEstado   As Long
Dim nNumoper  As Long
Let ErrAnula = ""
Let Msg = ""


   If Dir(ruta) = "" Then
      Call MsgBox("El archivo requerido para la carga. [" & NombreArchivo & "]. no se encuentra... Favor Revisar.", vbExclamation, App.Title)
      Exit Sub
   End If

   Let nFilas = 50
   Set MiExcel = CreateObject("Excel.Application")
   Set MiLibro = MiExcel.Workbooks.Open(ruta)

   Set MiHoja = Nothing
   Set MiHoja = MiLibro.Worksheets("FLI")

   

       For nFilFolio = 1 To xGrilla.Rows - 1
           
              For nContador = 2 To nFilas
              
               If UCase(MiHoja.Cells(nContador - 1, "A")) <> UCase("") Then
                  If xGrilla.TextMatrix(nFilFolio, 0) <> 0 Then
                    If InStr(UCase(MiHoja.Cells(nContador - 1, "A")), xGrilla.TextMatrix(nFilFolio, 0)) = 0 Then
                        Let nResul = nResul + 1
                    Else
                        Let nResul = 0
                        Exit For
                    End If
               End If
               End If
              
              Next nContador
              
                    If nResul > 1 Then
                       Let ErrAnula = ErrAnula & " Falta anular operación FLI en BAC con número [" & CDbl(xGrilla.TextMatrix(nFilFolio, 1)) & "], que referencia a folio SOMA[" & CDbl(xGrilla.TextMatrix(nFilFolio, 0)) & "], que ya no existe en archivo [" & NombreArchivo & "]" & vbCrLf
                       Let Msg = "Debe Anular Oparación FLI en BAC [" & CDbl(xGrilla.TextMatrix(nFilFolio, 1)) & "], ya que no existe Folio SOMA en Archivo"
                       Call BACFLI.Grabar_Log_Carga_SOMA("FLI", CDbl(xGrilla.TextMatrix(nFilFolio, 0)), 0, "", cNombreArchSOMA, "Cierre Mesa : " & Msg, 0, 0)
                       nResul = 0
                    End If
                           
      Next nFilFolio
      Set MiHoja = Nothing
      Call MiLibro.Close
      Set MiExcel = Nothing

 'PRD-6010
End Sub

