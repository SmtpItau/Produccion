VERSION 5.00
Begin VB.Form Bacinidia 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Parámetros Diarios.-"
   ClientHeight    =   4995
   ClientLeft      =   1905
   ClientTop       =   2235
   ClientWidth     =   5595
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4995
   ScaleWidth      =   5595
   Begin VB.PictureBox SSPanel2 
      BackColor       =   &H00C0C0C0&
      Height          =   825
      Left            =   105
      ScaleHeight     =   765
      ScaleWidth      =   5340
      TabIndex        =   1
      Top             =   3975
      Width           =   5400
      Begin VB.PictureBox cmdGrabar 
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
         Height          =   800
         Left            =   3000
         ScaleHeight     =   735
         ScaleWidth      =   1140
         TabIndex        =   3
         Top             =   0
         Width           =   1200
      End
      Begin VB.PictureBox CmdSalir 
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
         Height          =   800
         Left            =   4185
         ScaleHeight     =   735
         ScaleWidth      =   1140
         TabIndex        =   2
         Top             =   0
         Width           =   1200
      End
   End
   Begin VB.PictureBox Frame 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   1065
      Index           =   0
      Left            =   105
      ScaleHeight     =   1005
      ScaleWidth      =   5340
      TabIndex        =   4
      Top             =   105
      Width           =   5400
      Begin VB.PictureBox txtfecprox 
         Enabled         =   0   'False
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
         Left            =   2895
         ScaleHeight     =   255
         ScaleWidth      =   1140
         TabIndex        =   6
         Top             =   345
         Width           =   1200
      End
      Begin VB.PictureBox txtfecpro 
         Enabled         =   0   'False
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
         Left            =   870
         ScaleHeight     =   255
         ScaleWidth      =   1140
         TabIndex        =   5
         Top             =   345
         Width           =   1200
      End
      Begin VB.Label lbl_fecprx 
         Alignment       =   2  'Center
         BackColor       =   &H00C0C0C0&
         BorderStyle     =   1  'Fixed Single
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
         Height          =   285
         Left            =   2895
         TabIndex        =   8
         Top             =   645
         Width           =   1200
      End
      Begin VB.Label Lbl_fecpro 
         Alignment       =   2  'Center
         BackColor       =   &H00C0C0C0&
         BorderStyle     =   1  'Fixed Single
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
         Height          =   285
         Left            =   870
         TabIndex        =   7
         Top             =   645
         Width           =   1200
      End
   End
   Begin VB.PictureBox FrmMonedas 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   2745
      Left            =   105
      ScaleHeight     =   2685
      ScaleWidth      =   5340
      TabIndex        =   9
      Top             =   1155
      Width           =   5400
      Begin VB.PictureBox Table1 
         BackColor       =   &H00C0C0C0&
         ForeColor       =   &H00000000&
         Height          =   2295
         Left            =   105
         ScaleHeight     =   2235
         ScaleWidth      =   5115
         TabIndex        =   10
         Top             =   315
         Width           =   5175
      End
   End
   Begin VB.PictureBox Grid1 
      BackColor       =   &H00FFFFFF&
      Height          =   855
      Left            =   6015
      ScaleHeight     =   795
      ScaleWidth      =   3300
      TabIndex        =   11
      Top             =   435
      Width           =   3360
   End
   Begin VB.PictureBox grilla 
      BackColor       =   &H00FFFFFF&
      Height          =   840
      Left            =   285
      ScaleHeight     =   780
      ScaleWidth      =   4155
      TabIndex        =   0
      Top             =   5565
      Width           =   4215
   End
   Begin VB.Label Label 
      BackColor       =   &H00FFFFFF&
      Caption         =   "Label(1)"
      ForeColor       =   &H00000000&
      Height          =   225
      Index           =   1
      Left            =   6255
      TabIndex        =   13
      Top             =   1890
      Width           =   2205
   End
   Begin VB.Label Label 
      BackColor       =   &H00800000&
      Caption         =   "Label(0)"
      ForeColor       =   &H00FFFFFF&
      Height          =   330
      Index           =   0
      Left            =   6255
      TabIndex        =   12
      Top             =   1455
      Width           =   2205
   End
End
Attribute VB_Name = "Bacinidia"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Function BacChkFechas() As Boolean
 
   BacChkFechas = True
 
   If Not BacChkFecpro() Then
      BacChkFechas = False
      Exit Function

   End If

   If Not BacChkFecprx() Then
      BacChkFechas = False

   End If
 
End Function


Private Function BacChkFecpro() As Boolean

   If BacEsHabil(txtfecpro.Text) = True Then
      Lbl_fecpro.ForeColor = &H0&
      Lbl_fecpro.Caption = BacDiaSem(txtfecpro.Text)
      BacChkFecpro = True

   Else
      Lbl_fecpro.ForeColor = &HFF&
      Lbl_fecpro.Caption = BacDiaSem(txtfecpro.Text)
      MsgBox "Fecha proceso ingresada no es Día Hábil", vbOKOnly, "Parámetros Diarios"
      BacChkFecpro = False

   End If

End Function

Private Function BacChkFecprx() As Boolean

   If DateDiff("d", CDate(txtfecpro.Text), CDate(txtfecprox.Text)) <= 0 Then
      MsgBox "Fecha próximo proceso menor o igual a la de proceso?", vbOKOnly, "Parámetros diarios"
      BacChkFecprx = False
      Exit Function

   End If
        
   If BacEsHabil(txtfecprox.Text) = True Then
      lbl_fecprx.ForeColor = &H0&
      lbl_fecprx.Caption = BacDiaSem(txtfecprox.Text)
      BacChkFecprx = True

   Else
      lbl_fecprx.ForeColor = &HFF&
      lbl_fecprx.Caption = BacDiaSem(txtfecprox.Text)
      MsgBox "Fecha próximo proceso ingresada no es Día Hábil", vbOKOnly, "Parámetros Diarios"
      BacChkFecprx = False

   End If

End Function

Public Function BacGrabaRParamAc(cfecpro As String, cfecprox As String) As Integer

   Dim Sql        As String
   Dim grabar     As Integer
   Dim ICodigo    As Integer
   Dim dValor     As Double
   Dim Fila       As Integer
   Dim segcam     As Integer
   Dim arbitr     As Integer
   Dim seginf     As Integer
   Dim opsint     As Integer
   Dim opmccs     As Integer
       
   BacGrabaRParamAc = False
   
   'Inicia una Transacción
   '----------------------
     
   
   Sql = "BEGIN TRANSACTION"

   If SQL_Execute(Sql) > 0 Then
      grabar = 1
      Exit Function

   End If
   
     
   'Grabación de Parametros en tabla de Control( MDAC )
   '---------------------------------------------------
   Sql = "EXECUTE sp_mdaciniciodia "
   Sql = Sql & "'" & Format(cfecpro, "YYYYMMDD") & "',"
   Sql = Sql & "'" & Format(cfecprox, "YYYYMMDD") & "'"
   
   If SQL_Execute(Sql) > 0 Then

      Sql = "ROLLBACK TRANSACTION"
 
      If SQL_Execute(Sql) > 0 Then
         grabar = 2
         Exit Function
      End If
      
      grabar = 2
      MsgBox "Problemas en Fechas de Inicio de Día", vbCritical, "Inicio de Día ERROR"
      Exit Function
      
   End If
   
   'Graba todos los elementos de la colección a la tabla de monedas ( Mdvm )
   '------------------------------------------------------------------------
   With grilla
      For Fila = 1 To .Rows - 1
         .Row = Fila
         .Col = 4: ICodigo = .Text
         .Col = 2: dValor = .Text

         Sql = "EXECUTE sp_mdvmgrabar " & vbCrLf
         Sql = Sql & ICodigo & ", " & vbCrLf
         Sql = Sql & bacTranMontoSql(dValor) & ", " & vbCrLf
         Sql = Sql & "0, " & vbCrLf
         Sql = Sql & "0, " & vbCrLf
         Sql = Sql & "'" & Format(txtfecpro.Text, "YYYYMMDD") & "'"

         If SQL_Execute(Sql) > 0 Then
            Sql = "ROLLBACK TRANSACTION"

            If SQL_Execute(Sql) > 0 Then
               grabar = 4
               Exit Function

            End If
            
            MsgBox "Problemas al Cargar Monedas", vbCritical, "Inicio de Día ERROR"
            Exit Function

         End If

      Next Fila

   End With

   'Traspaso de Vencimientos y Actualizaciones ( Mfcav , Mfcah )
   '------------------------------------------------------------
   Sql = "EXECUTE sp_traspasooperaciones "
   
   If SQL_Execute(Sql) > 0 Then

      Sql = "ROLLBACK TRANSACTION"
 
      If SQL_Execute(Sql) > 0 Then
         grabar = 5
         Exit Function
      End If
       
      grabar = 5
      MsgBox "Problemas al Traspasar Operaciones", vbCritical, "Inicio de Día ERROR"
      Exit Function
      
   End If
      
   Dim Datos()
   Dim sCadena As String
   
   If SQL_Fetch(Datos()) = 0 Then
      segcam = Val(Datos(1))
      arbitr = Val(Datos(2))
      seginf = Val(Datos(3))
      opsint = Val(Datos(4))
      opmccs = Val(Datos(5))
   
   End If
 
   'Respaldo de Posiciones del dia ( Actualizaciones a Archivos Historicos )
   '------------------------------------------------------------------------
   'lo borre PRM
   
   
   'Si no Hubo Error Compromete la Transacción
   '------------------------------------------
   Sql = "COMMIT TRANSACTION"

   If SQL_Execute(Sql) > 0 Then
      grabar = 7
      Exit Function
   
   End If

   sCadena = "Proceso Inicio de día Existoso" & vbCrLf & vbCrLf
   sCadena = sCadena & "(" & segcam & ") Seguro de Cambio" & vbCrLf
   sCadena = sCadena & "(" & arbitr & ") Arbitrajes " & vbCrLf
   sCadena = sCadena & "(" & seginf & ") Seguro de Inflación" & vbCrLf
   sCadena = sCadena & "(" & opsint & ") Operaciones Sinteticas" & vbCrLf
   sCadena = sCadena & "(" & opmccs & ") Operaciones 1446" & vbCrLf
   
   MsgBox sCadena, vbInformation, "TRASPASO DE VENCIMIENTOS"

   BacGrabaRParamAc = True
   
End Function



Private Sub BacLeeParamPd(Fechapro As String, Grd As Grid)

   Dim Sql          As String
   Dim Datos()
           
   'Buscamos Registros en Tabla de Valores de Monedas
   '-------------------------------------------------
   Sql = ""
   Sql = "Exec Sp_mdvmleer " & "'" & Fechapro & "'"
                                  
   If SQL_Execute(Sql) > 0 Then
      Exit Sub

   End If

   Grd.Rows = 1

   Do While SQL_Fetch(Datos()) = 0
      Grd.Rows = Grd.Rows + 1
      Grd.Row = Grd.Rows - 1
      Grd.Col = 1: Grd.Text = Datos(2)
      Grd.Col = 2: Grd.Text = Val(Datos(3))
      Grd.Col = 4: Grd.Text = Val(Datos(1))

   Loop
        
End Sub
Private Function BacLeerParamAc(ByRef cfecpro As String, ByRef cfecprox As String, ByRef cSW_PD As String) As Boolean
Dim Sql As String
Dim Datos()

    'LEEMOS REGISTRO EN LA TABLA MDAC
    '----------------------------------------
    Sql = ""
    Sql = "Exec Sp_LeerParamAcfwd " 'OJO DMV

    If SQL_Execute(Sql) > 0 Then
       MsgBox "Parametros diarios no pueden ser Leidos", 48, "Parametros Diarios"
       Exit Function
    End If
        
    BacLeerParamAc = False
    ' Recuperar Fecha proceso, Fecha Proximo proceso,sw_pd
    ' ----------------------------------------------------
    If SQL_Fetch(Datos()) = 0 Then
        cfecpro = CStr(Datos(1))
        cfecprox = CStr(Datos(2))
        gsBAC_acswpd = CStr(Datos(3))
        
        BacLeerParamAc = True
    End If
    
End Function
Private Sub buscar_Click()

   Dim Fila As Long
   Dim cfecpro As String
   Dim cfecprox As String


   cfecpro$ = CStr(txtfecpro.Text)
   cfecprox$ = CStr(txtfecprox.Text)

    
   If BacChkFechas() = False Then
      Exit Sub
   End If
       
        
   Call BacLeeParamPd(Format(CStr(txtfecpro.Text), "YYYYMMDD"), grilla)
    
   If grilla.Rows = 1 Then
      Exit Sub
   End If
       
   txtfecpro.Enabled = False
   txtfecprox.Enabled = False
   
    
End Sub

Sub CargarInicioDia()
   
   Dim Fila          As Long
   Dim cfecpro       As String
   Dim cfecprox      As String

   If BacChkFechas() = False Then
      Exit Sub
    
   End If
       
   Call BacLeeParamPd(Format(CStr(txtfecpro.Text), "YYYYMMDD"), grilla)
   If grilla.Rows = 1 Then
      Exit Sub

   End If
    
   Table1.Rows = grilla.Rows - 1
   Table1.Refresh
   Table1.SetFocus
       
   txtfecpro.Enabled = False
   txtfecprox.Enabled = False
   
   cmdGrabar.Enabled = True
   

End Sub

Private Sub CmdGrabar_Click()

   Dim iRow             As Long
   Dim cCodigo          As Integer
   Dim nValor           As Double
   Dim actualizacion    As Boolean
   Dim objValoresMoneda As Object
   Dim IdOpcion         As Integer

   actualizacion = False

   If BacChkFechas() = False Then
      MsgBox "Error en Fecha de proceso o Fecha de próximo proceso"
      Exit Sub

   End If

   'ACTUALIZAMOS REGISTRO EN LA TABLA MFAC
   '----------------------------------------
   IdOpcion = BacGrabaRParamAc(txtfecpro.Text, txtfecprox.Text)

   gsBAC_Fecp = txtfecpro.Text
   BACForward.PnlFecha.Caption = Format(gsBAC_Fecp, gsc_FechaDMA)

   Call gsc_Parametros.DatosGenerales

   Unload Me

End Sub

Private Sub cmdSalir_Click()
            Unload Me
            
End Sub

Private Sub Form_Activate()

   Screen.MousePointer = 0
   
   If Me.Tag <> "" Then
      Unload Me
      Exit Sub

   End If
  
   Lbl_fecpro.Caption = BacDiaSem(txtfecpro.Text)
   lbl_fecprx.Caption = BacDiaSem(txtfecprox.Text)

   Call CargarInicioDia

End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)
        If KeyAscii% = vbKeyReturn Then
                KeyAscii% = 0
                SendKeys$ "{TAB}"
        End If

End Sub

Private Sub Form_Load()

   Dim iCol       As Integer
   Dim Sql        As String
   Dim Datos()

   'Lee Parametros.-
   '------------------------
   With Table1
      For iCol = 1 To 2
         .ColumnCellAttrs(iCol) = True

      Next iCol

   End With

   Table1.Rows = grilla.Rows - 1
   Me.Tag = ""

   If gsc_Parametros.DatosGenerales() = False Then
      MsgBox "Error en Lectura de parametros diarios .-", 16, "Bac Forward"
      Unload Me

   End If

   Me.Tag = ""

   '********************************************************
   '* Seteo de la fecha de inicio
   '********************************************************
   txtfecpro.Separator = Asc(gsc_FechaSeparador)
   txtfecprox.Separator = Asc(gsc_FechaSeparador)

   If gsc_Parametros.ACsw_fd = "1" Then
      txtfecpro.Text = Format(gsc_Parametros.ACfecprox, gsc_FechaDMA)

   Else
       txtfecpro.Text = Format(gsc_Parametros.ACfecproc, gsc_FechaDMA)

   End If

   'VERIFICACION DE DIA HABIL PARA FECHA PROXIMA
   '--------------------------------------------
   txtfecprox.Text = Format(BacProxHabil(txtfecpro.Text), gsc_FechaDMA)

   cmdGrabar.Enabled = False

   Exit Sub
  
End Sub


Private Sub Limpiar_Click()
'  cmdbuscar.Enabled = True
  txtfecpro.Enabled = True
  txtfecprox.Enabled = True
'  TxtFecPro.Text = cfecpro
'  TxtFecProx.Text = cfecprox
  lbl_fecprx.Caption = ""
  Lbl_fecpro.Caption = ""
  grilla.Rows = 1

  
End Sub


Private Sub Table1_Fetch(Row As Long, Col As Integer, Value As String)

   With grilla
      .Row = Row
      .Col = Col

      Value = .Text

   End With

End Sub

Private Sub Table1_FetchAttributes(Status As Integer, Split As Integer, Row As Long, Col As Integer, FgColor As Long, BgColor As Long, FontStyle As Integer)

   If Status And GFS_CURCELL Then
      FgColor = Label(0).ForeColor
      BgColor = Label(0).BackColor

   End If

End Sub

Private Sub Table1_KeyPress(KeyAscii As Integer)

   If Not IsNumeric(Chr(KeyAscii)) And Chr(KeyAscii) <> "." And Chr(KeyAscii) <> "," Then
      KeyAscii = 0
      
   Else
         Call bacKeyPress(KeyAscii)
         
   End If
   
End Sub

Private Sub Table1_Validate(Row As Long, Col As Integer, Value As String, Cancel As Integer)
  With grilla
      .Row = Row
      .Col = Col
      .Text = Value

  End With

End Sub

Private Sub TxtFecPro_KeyPress(KeyAscii As Integer)

   If KeyAscii = 13 Then
      SendKeys "{tab}"

   End If

End Sub

Private Sub TxtFecPro_LostFocus()

   lbl_fecprx.ForeColor = &H0&
        
   If Trim$(txtfecpro.Tag) = "" Then
      txtfecpro.Tag = txtfecpro.Text
   
   End If

  ' cmdbuscar.Enabled = True

   Lbl_fecpro.Caption = BacDiaSem(txtfecpro.Text)

End Sub

Private Sub TxtFecProx_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then
        SendKeys "{tab}"
   End If
End Sub

Private Sub TxtFecProx_LostFocus()
        lbl_fecprx.ForeColor = &H0&
        lbl_fecprx.Caption = BacDiaSem(txtfecprox.Text)
      '  cmdbuscar.SetFocus
End Sub


