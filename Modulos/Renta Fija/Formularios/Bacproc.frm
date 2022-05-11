VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form BacProc 
   BorderStyle     =   1  'Fixed Single
   ClientHeight    =   1455
   ClientLeft      =   2475
   ClientTop       =   2955
   ClientWidth     =   4980
   ForeColor       =   &H00C0C0C0&
   Icon            =   "Bacproc.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   1455
   ScaleWidth      =   4980
   Begin Threed.SSPanel Termo 
      Height          =   495
      Left            =   180
      TabIndex        =   3
      Top             =   915
      Width           =   4695
      _Version        =   65536
      _ExtentX        =   8281
      _ExtentY        =   873
      _StockProps     =   15
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
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   5490
      Top             =   1350
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   32
      ImageHeight     =   32
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   2
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacproc.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacproc.frx":075C
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Tool 
      Height          =   570
      Left            =   0
      TabIndex        =   4
      Top             =   30
      Width           =   4875
      _ExtentX        =   8599
      _ExtentY        =   1005
      ButtonWidth     =   1032
      ButtonHeight    =   1005
      AllowCustomize  =   0   'False
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdProcesar"
            Description     =   "Procesar"
            Object.ToolTipText     =   "Procesar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdCancelar"
            Description     =   "Cancelar"
            Object.ToolTipText     =   "Cancelar"
            ImageIndex      =   1
         EndProperty
      EndProperty
   End
   Begin VB.Label Label3 
      AutoSize        =   -1  'True
      Caption         =   "  100%"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   195
      Left            =   4230
      TabIndex        =   2
      Top             =   660
      Width           =   585
   End
   Begin VB.Label Label2 
      AutoSize        =   -1  'True
      Caption         =   "    0%"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   195
      Left            =   -30
      TabIndex        =   1
      Top             =   660
      Width           =   495
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      Caption         =   "   50%"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   195
      Left            =   2160
      TabIndex        =   0
      Top             =   660
      Width           =   540
   End
End
Attribute VB_Name = "BacProc"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'' Historial de Modificaciones
''      Dia 22/04/2005 Por Victor Gonzalez  : Se incorpora la validacion de los feriados Dominago y Sabados
''                                          para el proximo año a la fecha de proceso. Esto para los
''                                          mensajes 298 y 299 de los instrumentos BCX.
''                                          Esta validacion es restrictiva, es decir no puede continuar con el
''                                          Fin de Dia si no estan ingresados todos los feriados Sabados y Domingos del
''                                          proximo año

Option Explicit
Dim cProceso$
Private Sub BacFinDia()
Dim Datos()
Dim cFechoy$
Dim Dias    As Integer
Dim dFecha  As Date
   cFechoy$ = Trim(Str(Month(gsBac_Fecp))) + "/" + Trim(Str(Day(gsBac_Fecp))) + "/" + Trim(Str(Year(gsBac_Fecp)))
   
   Screen.MousePointer = 11
   
   ''========================================================================
   '' VGS 22/04/2005
   ''========================================================================
   Dias = DateDiff("d", gsBac_Fecp, gsBac_Fecx)
   dFecha = DateAdd("d", Dias, gsBac_Fecp)
   If DatePart("d", dFecha) >= 15 And DatePart("m", gsBac_Fecp) = 12 Then
        If Not ValidaFeriadosProximoAno(DatePart("yyyy", gsBac_Fecp) + 1) Then
            Screen.MousePointer = 0
            Exit Sub
        End If

   End If
   ''========================================================================
   
   If miSQL.SQL_Execute("SP_FDIA") <> 0 Then
       Screen.MousePointer = 0
       MsgBox "ERROR : No se pudo ejecutar proceso en el Servidor", vbCritical, "FIN DE DIA"
       Exit Sub
   End If
   
   Screen.MousePointer = 0
   
   If Bac_SQL_Fetch(Datos()) Then
       If Datos(1) = "SI" Then
           MsgBox Datos(2), vbInformation, "FIN DE DIA"
       Else

           MsgBox Datos(2), vbCritical, "FIN DE DIA"
       End If
   End If
          
End Sub
Private Sub BACprocesos()
     Dim Datos(), Sql$
     
     Sql$ = cProceso$
     
     If miSQL.SQL_Execute(Sql$) = 0 Then
     
            DoEvents
            
            If Bac_SQL_Fetch(Datos()) Then
            
              If Datos(1) = "OK" Then
                MsgBox Datos(2), vbInformation, BacProc.Caption
              Else
                MsgBox Datos(2), vbCritical, BacProc.Caption
              End If

            End If
            
     Else
     
        MsgBox "ERROR : No se ha podido ejecutar el Proceso", vbCritical, "PROCESOS"
            
     End If

End Sub



Private Sub Form_Load()

    
    'Seteos de la pantalla.-
     Select Case gsRUN_Proceso
     
     Case "TM":
          Me.Caption = "Proceso de Tasa de Mercado."
          cProceso$ = "TM"
     
     Case "DV":
          Me.Caption = "Proceso de Devengamiento"
          cProceso$ = ""
     
     Case "CA":
          Me.Caption = "Proceso de Contabilidad Automática"
          cProceso$ = "SP_CONTABI"
          
     Case "RENT":
          Me.Caption = "Calculo de Rentabilidad"
          cProceso$ = "RENT"

          
     Case "FD":
          Me.Caption = "Proceso de Fin de día"
          cProceso$ = "FD"
          
     Case "SB":
          Me.Caption = "Carga Factores SBIF"
          cProceso$ = "SB"
          
     Case Else
          Unload Me
          
     End Select
     
   ' setear puntero del mouse.-
     Screen.MousePointer = vbDefault

End Sub

Private Sub SSCommand1_Click()

End Sub

Private Sub pctReloj_Click()


End Sub
Sub Procesar()
    
     Screen.MousePointer = 11
     
    Select Case cProceso$
        Case "FD"
            If Chequea_ControlProcesos("FD") Then
               BacFinDia
            End If
            
        Case "RENT"
            Call Calculo_Rentabilidad
            
        Case "TM"
            If miSQL.SQL_Execute("SP_TM") <> 0 Then
                Screen.MousePointer = 0
                MsgBox "No se pudo Ejecutar la Valorización a Tasa de Mercado", vbCritical, "VALORIZACION TASA DE MERCADO"
                Exit Sub
            End If
            MsgBox "Valorización a Tasa de Mercado ha sido ejecutada", 24, "VALORIZACION TASA DE MERCADO"
                    
        Case "SB"
            
            Screen.MousePointer = 3
            Call Cargar_SBIF
            Screen.MousePointer = 0

        Case Else
        
            BACprocesos
            
    End Select
     
    Screen.MousePointer = 0
     
    Unload BacProc

End Sub

Private Sub Tool_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Key
   Case Is = "cmdProcesar": Call Procesar
   Case Is = "cmdCancelar": Unload Me
End Select
End Sub
Private Function ValidaFeriadosProximoAno(nano As Double) As Boolean
Dim Datos()
Dim cMsg    As String
Dim sw      As Boolean

cMsg = "Falta los Feriados de los Siguientes meses del Año " & nano & vbCrLf & vbCrLf
ValidaFeriadosProximoAno = False
sw = True

Envia = Array()
AddParam Envia, nano
If Not Bac_Sql_Execute("SP_VALIDA_FERIADO_NEXT_YEAR", Envia) Then
    MsgBox "Error al Validar Feriados del Proximo Año", vbCritical, "FIN DE DIA"
    Exit Function
Else
    Do While Bac_SQL_Fetch(Datos())
        If Datos(1) = "NO" Then
            Select Case Datos(2)
                Case Is = 0: cMsg = "Debe Ingresar Feriados del Año " & nano & " Completo" & vbCrLf
                Case Is = 1: cMsg = cMsg & "Enero " & vbCrLf
                Case Is = 2: cMsg = cMsg & "Febrero " & vbCrLf
                Case Is = 3: cMsg = cMsg & "Marzo " & vbCrLf
                Case Is = 4: cMsg = cMsg & "Abril " & vbCrLf
                Case Is = 5: cMsg = cMsg & "Mayo " & vbCrLf
                Case Is = 6: cMsg = cMsg & "Junio " & vbCrLf
                Case Is = 7: cMsg = cMsg & "Julio " & vbCrLf
                Case Is = 8: cMsg = cMsg & "Agosto " & vbCrLf
                Case Is = 9: cMsg = cMsg & "Septiembre " & vbCrLf
                Case Is = 10: cMsg = cMsg & "Octubre " & vbCrLf
                Case Is = 11: cMsg = cMsg & "Noviembre " & vbCrLf
                Case Is = 12: cMsg = cMsg & "Diciembre "
            End Select
            SW = False
        End If
    Loop
    
    If Not SW Then
        MsgBox cMsg, vbCritical, "FIN DE DIA"
        Exit Function
    End If

End If
ValidaFeriadosProximoAno = True

End Function

