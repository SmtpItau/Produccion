VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form Bac_instrumentos_NoSerie 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantenedor de Instrumentos Financieros No Seriados"
   ClientHeight    =   3285
   ClientLeft      =   315
   ClientTop       =   1440
   ClientWidth     =   9945
   ClipControls    =   0   'False
   ControlBox      =   0   'False
   Icon            =   "frm_instrum_NoSerie.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   3285
   ScaleWidth      =   9945
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   9945
      _ExtentX        =   17542
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList2"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   5
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.ToolTipText     =   "Eliminar"
            ImageIndex      =   3
            BeginProperty ButtonMenus {66833FEC-8583-11D1-B16A-00C0F0283628} 
               NumButtonMenus  =   2
               BeginProperty ButtonMenu1 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
               BeginProperty ButtonMenu2 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
            EndProperty
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   6
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   5
            BeginProperty ButtonMenus {66833FEC-8583-11D1-B16A-00C0F0283628} 
               NumButtonMenus  =   1
               BeginProperty ButtonMenu1 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
            EndProperty
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   4
         EndProperty
      EndProperty
      BorderStyle     =   1
      MouseIcon       =   "frm_instrum_NoSerie.frx":030A
      Begin MSComctlLib.ImageList ImageList2 
         Left            =   4800
         Top             =   0
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   22
         ImageHeight     =   22
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   6
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frm_instrum_NoSerie.frx":0624
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frm_instrum_NoSerie.frx":0A76
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frm_instrum_NoSerie.frx":0B88
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frm_instrum_NoSerie.frx":0C9A
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frm_instrum_NoSerie.frx":0FB4
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frm_instrum_NoSerie.frx":12CE
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame frm_instr 
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000D&
      Height          =   870
      Left            =   0
      TabIndex        =   4
      Top             =   420
      Width           =   9945
      Begin VB.ComboBox box_familia 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   1905
         TabIndex        =   16
         Top             =   180
         Width           =   2175
      End
      Begin VB.TextBox txt_descripcion 
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Left            =   1905
         MaxLength       =   50
         TabIndex        =   2
         Top             =   510
         Width           =   6855
      End
      Begin BACControles.TXTFecha txt_fec_vcto 
         Height          =   285
         Left            =   7230
         TabIndex        =   1
         Top             =   180
         Width           =   1530
         _ExtentX        =   2699
         _ExtentY        =   503
         Enabled         =   -1  'True
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "22/11/2001"
      End
      Begin VB.Label Label1 
         Caption         =   "Familia"
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
         Height          =   255
         Left            =   555
         TabIndex        =   6
         Top             =   255
         Width           =   1215
      End
      Begin VB.Label Label2 
         Caption         =   "Fecha Vencimiento"
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
         Height          =   255
         Left            =   5580
         TabIndex        =   5
         Top             =   225
         Width           =   1695
      End
   End
   Begin VB.Frame frm_datos_int 
      Height          =   5925
      Left            =   0
      TabIndex        =   3
      Top             =   1215
      Width           =   9960
      Begin VB.Frame Frame1 
         Caption         =   "Identificación"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   960
         Left            =   45
         TabIndex        =   7
         Top             =   120
         Width           =   9870
         Begin VB.TextBox cbx_serie 
            Height          =   330
            Left            =   660
            TabIndex        =   21
            Top             =   600
            Width           =   2235
         End
         Begin VB.TextBox txt_mercado 
            Height          =   330
            Left            =   3940
            TabIndex        =   20
            Top             =   600
            Width           =   2235
         End
         Begin VB.TextBox txt_bbnumber 
            Height          =   330
            Left            =   7440
            TabIndex        =   19
            Top             =   240
            Width           =   2235
         End
         Begin VB.TextBox txt_cusip 
            Height          =   330
            Left            =   3940
            TabIndex        =   18
            Top             =   240
            Width           =   2235
         End
         Begin VB.TextBox Txt_isin 
            Height          =   330
            Left            =   660
            TabIndex        =   17
            Top             =   240
            Width           =   2235
         End
         Begin VB.Label Label23 
            AutoSize        =   -1  'True
            Caption         =   "Mercado"
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
            Height          =   210
            Left            =   3120
            TabIndex        =   12
            Top             =   615
            Width           =   720
         End
         Begin VB.Label Label22 
            AutoSize        =   -1  'True
            Caption         =   "Serie"
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
            Height          =   210
            Left            =   120
            TabIndex        =   11
            Top             =   615
            Width           =   435
         End
         Begin VB.Label Label7 
            Caption         =   "BB Number"
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
            Height          =   210
            Index           =   4
            Left            =   6360
            TabIndex        =   10
            Top             =   285
            Width           =   1035
         End
         Begin VB.Label Label7 
            Caption         =   "Cusip"
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
            Height          =   195
            Index           =   3
            Left            =   3120
            TabIndex        =   9
            Top             =   300
            Width           =   495
         End
         Begin VB.Label Label7 
            AutoSize        =   -1  'True
            Caption         =   "ISIN"
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
            Height          =   210
            Index           =   2
            Left            =   120
            TabIndex        =   8
            Top             =   300
            Width           =   300
         End
      End
      Begin VB.Frame Frm_D05 
         Caption         =   "Informe D05"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   915
         Left            =   60
         TabIndex        =   13
         Top             =   1080
         Width           =   9855
         Begin VB.ComboBox CmbClasificacion 
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   330
            Left            =   6720
            Style           =   2  'Dropdown List
            TabIndex        =   23
            Top             =   360
            Width           =   2220
         End
         Begin VB.ComboBox CmbAgencia 
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   330
            Left            =   1320
            Style           =   2  'Dropdown List
            TabIndex        =   22
            Top             =   360
            Width           =   3960
         End
         Begin VB.Label Label7 
            AutoSize        =   -1  'True
            Caption         =   "CLASIFICACION"
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
            Height          =   210
            Index           =   6
            Left            =   5340
            TabIndex        =   15
            Top             =   390
            Width           =   1260
         End
         Begin VB.Label Label7 
            AutoSize        =   -1  'True
            Caption         =   "AGENCIA"
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
            Height          =   210
            Index           =   5
            Left            =   480
            TabIndex        =   14
            Top             =   405
            Width           =   720
         End
      End
   End
End
Attribute VB_Name = "Bac_instrumentos_NoSerie"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim Dato As String
Dim resrc As String
Dim Sql As String
Dim Base_Tasa As Double
Dim base_flujo As Double
Dim Dias As Double
Dim Limpio
Dim Calculo
Dim Fecha_pagos
Dim objDCartera As New clsDCarteras
Dim objTipCar   As New clsCodigos

Dim DescripFamilia()
Dim NombreFamilia()
Dim ISIN_Pais()
Dim ISIN_Emisor()
Dim ISIN_Instr()
Dim idFamiNoSer As Integer
Dim cNemo As String
Dim CodIDInstrumento As Integer

Private Enum QueCarga
    [Agencias] = 1
    [Clasificadoras] = 2
End Enum
   
Function busca_datos()
    Dim Sql       As String, num
    Dim pl
    Dim datos()
    Dim i         As Double

    
    If DateDiff("d", gsBac_Fecp, txt_fec_vcto.Text) < 1 Then
        MsgBox "Fecha de Vencimiento No debe ser Menor o Igual A La De Operación", vbExclamation, gsBac_Version
        txt_fec_vcto.SetFocus
        Exit Function
    End If
    
    'se debe armar el nemotecnico  que es nombre de familia + fecha yyyymmdd
    
    cNemo = box_familia.Text & Format(txt_fec_vcto.Text, "yyyymmdd")
    
    Call Busca_Identificadores(cNemo)
    
             
End Function

Sub Busca_Identificadores(nemo As String)
    Dim Sql As String
    Dim datos()
    Dim controlMensaje As Boolean

    'Txt_isin.Text = ""
    txt_cusip.Text = ""
    txt_bbnumber.Text = ""
    txt_mercado.Text = ""
    cbx_serie.Text = ""
    CodIDInstrumento = 0
    
    controlMensaje = False

    envia = Array()
    AddParam envia, Trim(nemo)
    If Bac_Sql_Execute("SVC_BUS_IDENT", envia) Then
        Do While Bac_SQL_Fetch(datos)
            If datos(1) = "0" Then
                MsgBox "No Hay Identificadores asignados al instrumento ", vbExclamation, gsBac_Version
                Exit Do
            End If
            
            CodIDInstrumento = datos(1)
            
            If datos(2) <> "" Then
                Txt_isin.Text = datos(2)
            End If
            If datos(3) <> "" Then
                txt_cusip.Text = (datos(3))
            End If
            If datos(4) <> "" Then
                txt_bbnumber.Text = (datos(4))
            End If
            If datos(5) <> "" Then
                txt_mercado.Text = (datos(5))
            End If
            If datos(6) <> "" Then
                cbx_serie.Text = (datos(6))
            End If
            controlMensaje = True
        Loop
    End If
    
    envia = Array()
    AddParam envia, Trim(nemo)
    If Bac_Sql_Execute("SVC_BSQ_CLS_INS", envia) Then
        Do While Bac_SQL_Fetch(datos)
        
            For i = 0 To CmbAgencia.ListCount - 1
                If CmbAgencia.ItemData(i) = Val(datos(1)) Then
                    CmbAgencia.ListIndex = i
                    CmbClasificacion.Text = datos(2)
                    Exit For
                End If
            Next i
        
        Loop
    End If
    

    
    
    If controlMensaje = False Then
        MsgBox "No Hay Identificadores asignados al instrumento ", vbExclamation, gsBac_Version
    End If
    frm_datos_int.Enabled = True
End Sub



Function Clear_Objetos(Op)
    Limpio = True
    If Op = " " Then


        Toolbar1.Buttons(1).Enabled = False
        Toolbar1.Buttons(2).Enabled = False
        frm_instr.Enabled = True
        box_familia.ListIndex = -1
        txt_descripcion.Enabled = False
        Toolbar1.Buttons(3).Enabled = True
        frm_datos_int.Enabled = False
        txt_fec_vcto.Enabled = True


        Txt_isin.Text = ""
        txt_cusip.Text = ""
        txt_bbnumber.Text = ""
        cbx_serie.Text = ""
        txt_mercado.Text = ""
        
        CmbAgencia.ListIndex = -1
        CmbClasificacion.ListIndex = -1

        Call enable_false
    Else

        Txt_isin.Text = ""
        txt_cusip.Text = ""
        txt_bbnumber.Text = ""
        cbx_serie.Text = ""
        txt_mercado.Text = ""
        
        Toolbar1.Buttons(1).Enabled = False
        Toolbar1.Buttons(2).Enabled = False
        frm_instr.Enabled = True
        box_familia.ListIndex = -1
        txt_descripcion.Enabled = False
        Toolbar1.Buttons(3).Enabled = True
        frm_datos_int.Enabled = False
        
        CmbAgencia.ListIndex = -1
        CmbClasificacion.ListIndex = -1

        Call enable_false
    End If
End Function

Function enable_false()
    frm_datos_int.Enabled = False
End Function

Function enable_true()
    frm_datos_int.Enabled = True
End Function

Function grabar_datos()
   Dim Sql    As String
   Dim p      As Integer
   Dim num    As Double
   Dim rut    As Double
   Dim res
   Dim res1
   Dim datos()


    envia = Array()
    AddParam envia, Trim(cNemo)
    AddParam envia, CmbAgencia.ItemData(CmbAgencia.ListIndex)
    AddParam envia, Trim(CmbClasificacion.List(CmbClasificacion.ListIndex))
    If Bac_Sql_Execute("SVA_GBR_CLS_INS", envia) Then '-->graba clasificacion instrumento
        envia = Array()
        AddParam envia, Trim(cNemo)
        AddParam envia, Trim(Txt_isin.Text)
        AddParam envia, Trim(txt_cusip.Text)
        AddParam envia, Trim(txt_bbnumber.Text)
        AddParam envia, Trim(cbx_serie.Text)
        AddParam envia, Trim(txt_mercado.Text)
        AddParam envia, CodIDInstrumento
 

        'grabo tabla "text_ident"
      If Bac_Sql_Execute("SVA_INS_GRB_DAT_SI", envia) Then
         Do While Bac_SQL_Fetch(datos)
         Loop
         Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "Datos del Instrumento " & txt_descripcion.Text & " se grabaron con éxito.")
         MsgBox "Datos Grabados Con Exito", vbInformation, TITSISTEMA
         Clear_Objetos (" ")
         txt_fec_vcto.Text = Format(gsBac_Fecp, "DD/MM/YYYY")
         Exit Function
      Else
         Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "Problemas al grabar Datos del Instrumento " & txt_descripcion.Text)
         MsgBox "Problemas Con SQL", vbCritical, TITSISTEMA
         Exit Function
      End If
   Else
      Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "Problemas al grabar Datos del Instrumento " & txt_descripcion.Text)
      MsgBox "Problemas Con SQL", vbCritical, TITSISTEMA
      Exit Function
   End If

End Function

Function valida_datos()
   Dim datos()
   
   envia = Array()
    
    If Txt_isin.Text = "" Then
        Call MsgBox("Debe ingresar un ISIN.", vbExclamation, App.Title)
        Txt_isin.SetFocus
    ElseIf txt_cusip.Text = "" Then
        Call MsgBox("Debe ingresar un CUSIP.", vbExclamation, App.Title)
        txt_cusip.SetFocus
    ElseIf cbx_serie.Text = "" Then
        Call MsgBox("Debe ingresar una Serie.", vbExclamation, App.Title)
        cbx_serie.SetFocus
    ElseIf txt_mercado.Text = "" Then
        Call MsgBox("Debe ingresar un Mercado.", vbExclamation, App.Title)
        txt_mercado.SetFocus
    ElseIf txt_bbnumber.Text = "" Then
        Call MsgBox("Debe ingresar un BB Number.", vbExclamation, App.Title)
        txt_bbnumber.SetFocus
    ElseIf CmbAgencia.ListIndex = -1 Then
        Call MsgBox("Debe seleccionar una agencia clasificadora de riesgo de instrumentos.", vbExclamation, App.Title)
        CmbAgencia.SetFocus
    ElseIf CmbClasificacion.ListIndex = -1 Then
        Call MsgBox("Debe seleccionar una clasificación de riesgo para el instrumento.", vbExclamation, App.Title)
        CmbClasificacion.SetFocus
    Else
        Toolbar1.Buttons(1).Enabled = True
        Call grabar_datos
    End If
End Function
Private Sub txt_bbnumber_KeyPress(KeyAscii As Integer)
  If KeyAscii = 13 Then
     cbx_serie.SetFocus
   End If
End Sub
Private Sub txt_cusip_KeyPress(KeyAscii As Integer)
  If KeyAscii = 13 Then
     txt_bbnumber.SetFocus
   End If
End Sub

Private Sub txt_descripcion_KeyPress(KeyAscii As Integer)
Select Case KeyAscii
    Case 39
        KeyAscii = 0
        
    Case 13
    Call enable_true
    txt_descripcion.Text = UCase(txt_descripcion.Text)
    Toolbar1.Buttons(1).Enabled = True
    SendKeys "{TAB}"
    frm_instr.Enabled = False
    
    Exit Sub
End Select


KeyAscii = Asc(UCase(Chr(KeyAscii)))

End Sub
Private Sub txt_fec_vcto_KeyPress(KeyAscii As Integer)
Dim paso

Select Case KeyAscii
    Case 13

        Dim Op
        Dim Fecha
        If txt_descripcion.Text <> "" Then
            Fecha = Format(gsBac_Fecp, "DD/MM/YYYY")
            Op = CDbl(DateDiff("D", Fecha, txt_fec_vcto.Text))
            If Op <= 0 Then
                    MsgBox "La Fecha De Vencimiento No Debe Ser  Igual o Menor Que La De Proceso", vbExclamation, gsBac_Version
                    txt_fec_vcto.Text = Format(gsBac_Fecp, "DD/MM/YYYY")
                    Exit Sub
            End If
            SendKeys "{TAB}"
            paso = txt_fec_vcto.Text
            busca_datos
        End If

End Select
End Sub


Private Sub Form_Load()
    Move 0, 0
    Icon = BAC_INVERSIONES.Icon
    
    cIsin = ""
    CodIDInstrumento = 0
    Call llena_combo_familia
    Call Llena_Combo_Clasificadoras(Agencias)
    
    enable_false


    Limpio = True
    Me.txt_fec_vcto.Text = Format(gsBac_Fecp, "DD/MM/YYYY")
         
         
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 1
         Call valida_datos
      Case 2
         If MsgBox("¿ Está seguro de eliminar este registro. ?", vbQuestion + vbYesNo, TITSISTEMA) = vbYes Then
           Call elimina_instrumento_no_serie
         End If
      Case 3
         Call busca_datos
        Toolbar1.Buttons(1).Enabled = True
        Toolbar1.Buttons(2).Enabled = True
      Case 4
         box_familia.ListIndex = -1
         txt_fec_vcto.Text = Format(gsBac_Fecp, "DD/MM/YYYY")
         Call Clear_Objetos(" ")
         Call enable_false
         box_familia.SetFocus
      Case 5
         If Toolbar1.Buttons(1).Value = tbrUnpressed Then
            Unload Me
         End If
   End Select
End Sub

Function llena_combo_familia()
    Dim datos()

    
    box_familia.Clear
    
    DescripFamilia = Array()
    NombreFamilia = Array()
    ISIN_Pais = Array()
    ISIN_Emisor = Array()
    ISIN_Instr = Array()
    

    idFamiNoSer = 1
    
    If Bac_Sql_Execute("SVC_GEN_FAM_INS") Then
        Do While Bac_SQL_Fetch(datos)
            If datos(10) <> "S" Then
                ReDim Preserve DescripFamilia(idFamiNoSer)
                ReDim Preserve NombreFamilia(idFamiNoSer)
                ReDim Preserve ISIN_Pais(idFamiNoSer)
                ReDim Preserve ISIN_Emisor(idFamiNoSer)
                ReDim Preserve ISIN_Instr(idFamiNoSer)

                
                box_familia.AddItem datos(2)
                box_familia.ItemData(box_familia.NewIndex) = Val(datos(1))
                NombreFamilia(idFamiNoSer) = datos(2)
                DescripFamilia(idFamiNoSer) = datos(3)
                ISIN_Pais(idFamiNoSer) = datos(13)
                ISIN_Emisor(idFamiNoSer) = datos(14)
                ISIN_Instr(idFamiNoSer) = datos(15)
                
                idFamiNoSer = idFamiNoSer + 1
            End If
        Loop
    End If
End Function
Private Sub box_familia_Click()

Dim busqueda As Integer

    If box_familia.ListIndex = -1 Then
        Exit Sub
    End If
    
    For busqueda = 1 To (idFamiNoSer - 1)
       If NombreFamilia(busqueda) = box_familia.Text Then
                                
            txt_descripcion.Text = DescripFamilia(busqueda)
            Txt_isin.Text = Trim(ISIN_Pais(busqueda)) & Trim(ISIN_Emisor(busqueda)) & Trim(ISIN_Instr(busqueda))
        End If
    Next
    

End Sub

Private Function Llena_Combo_Clasificadoras(ByVal nValor As QueCarga)
    On Error GoTo ErrorCarga
    Dim datos()
    Dim TieneDatos  As Boolean
    
    Let TieneDatos = False
    
    If nValor = Agencias Then
        Let CmbAgencia.Enabled = False:             Call CmbAgencia.Clear
        Let CmbClasificacion.Enabled = False:       Call CmbClasificacion.Clear
    End If
    If nValor = Clasificadoras Then
        Let CmbClasificacion.Enabled = False:       Call CmbClasificacion.Clear
        If CmbAgencia.ListIndex = -1 Then
            Exit Function
        End If
    End If

    envia = Array()
    AddParam envia, CDbl(nValor)
    If nValor = Agencias Then
        AddParam envia, CDbl(0)
    Else
        AddParam envia, CDbl(CmbAgencia.ItemData(CmbAgencia.ListIndex))
    End If
    
    If Not Bac_Sql_Execute("BacParamSuda.dbo.Sp_Leer_Parametros_D05", envia) Then
        Exit Function
    End If
    Do While Bac_SQL_Fetch(datos())
        If nValor = Agencias Then
            Call CmbAgencia.AddItem(datos(2)):          Let CmbAgencia.ItemData(CmbAgencia.NewIndex) = datos(1)
        End If
        If nValor = Clasificadoras Then
            Call CmbClasificacion.AddItem(datos(2)):    Let CmbClasificacion.ItemData(CmbClasificacion.NewIndex) = datos(1)
        End If
        Let TieneDatos = True
    Loop

    If nValor = Agencias Then
        Let CmbAgencia.Enabled = True
        If TieneDatos = True Then
            Let CmbAgencia.ListIndex = -1
        End If
    Else
        Let CmbClasificacion.Enabled = True
        If TieneDatos = True Then
            Let CmbClasificacion.ListIndex = 0
        End If
    End If
    
    On Error GoTo 0
Exit Function
ErrorCarga:

    If nValor = Agencias Then
        Call MsgBox("No se han cargado las Agencias de clasificación.", vbExclamation, App.Title)
    Else
        Call MsgBox("No se han cargado las clasificaciones de riesgo.", vbExclamation, App.Title)
    End If

    On Error GoTo 0
End Function
Private Sub CmbAgencia_Click()
    Call Llena_Combo_Clasificadoras(Clasificadoras)
End Sub
Function elimina_instrumento_no_serie()
    Dim Sql As String
    Dim datos()
    envia = Array()
    AddParam envia, box_familia.ItemData(box_familia.ListIndex)
    AddParam envia, Trim(cNemo)

    If Bac_Sql_Execute("SVA_ELI_INS_NO_SER", envia) Then
        Do While Bac_SQL_Fetch(datos)
            If datos(1) = "NO" Then
                MsgBox datos(2), vbExclamation, gsBac_Version
                Exit Function
            End If

        Loop

        Call Clear_Objetos("S")
        Call Clear_Objetos(" ")
        Call enable_false
        txt_fec_vcto.Text = Format(gsBac_Fecp, "DD/MM/YYYY")

    Else
        MsgBox "Error al Eliminar Instrumento", vbExclamation, gsBac_Version
    End If

End Function

