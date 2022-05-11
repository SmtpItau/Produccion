VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form Bac_Emisores 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Mantenedor De Emisores"
   ClientHeight    =   4650
   ClientLeft      =   855
   ClientTop       =   840
   ClientWidth     =   10185
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   4650
   ScaleWidth      =   10185
   ShowInTaskbar   =   0   'False
   Begin VB.Frame Frame1 
      Caption         =   "Clasificador De Riesgo 2"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00C00000&
      Height          =   1335
      Left            =   30
      TabIndex        =   24
      Top             =   3285
      Width           =   10110
      Begin VB.ComboBox box_Clas2 
         Height          =   315
         Left            =   1260
         Style           =   2  'Dropdown List
         TabIndex        =   7
         Top             =   330
         Width           =   2505
      End
      Begin VB.ComboBox box_tipo_c2 
         Height          =   315
         Left            =   5805
         Style           =   2  'Dropdown List
         TabIndex        =   8
         Top             =   315
         Width           =   2865
      End
      Begin VB.ComboBox box_tipo_l2 
         Height          =   315
         Left            =   5805
         Style           =   2  'Dropdown List
         TabIndex        =   9
         Top             =   765
         Width           =   2880
      End
      Begin VB.Label Label12 
         Caption         =   "Clasificador"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   330
         Left            =   120
         TabIndex        =   10
         Top             =   345
         Width           =   1095
      End
      Begin VB.Label Label11 
         Caption         =   "Corto Plazo"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   330
         Left            =   4500
         TabIndex        =   11
         Top             =   345
         Width           =   1230
      End
      Begin VB.Label Label10 
         Caption         =   "Largo Plazo"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   330
         Left            =   4500
         TabIndex        =   25
         Top             =   780
         Width           =   1125
      End
   End
   Begin VB.Frame Frm_clasi 
      Caption         =   "Clasificador De Riesgo 1"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00C00000&
      Height          =   1335
      Left            =   30
      TabIndex        =   20
      Top             =   1875
      Width           =   10110
      Begin VB.ComboBox box_tipo_l1 
         Height          =   315
         Left            =   5805
         Style           =   2  'Dropdown List
         TabIndex        =   6
         Top             =   765
         Width           =   2880
      End
      Begin VB.ComboBox box_tipo_c1 
         Height          =   315
         Left            =   5805
         Style           =   2  'Dropdown List
         TabIndex        =   5
         Top             =   315
         Width           =   2865
      End
      Begin VB.ComboBox box_Clas1 
         Height          =   315
         Left            =   1260
         Style           =   2  'Dropdown List
         TabIndex        =   4
         Top             =   315
         Width           =   2505
      End
      Begin VB.Label Label9 
         Caption         =   "Largo Plazo"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   330
         Left            =   4500
         TabIndex        =   23
         Top             =   780
         Width           =   1125
      End
      Begin VB.Label Label8 
         Caption         =   "Corto Plazo"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   330
         Left            =   4500
         TabIndex        =   22
         Top             =   345
         Width           =   1230
      End
      Begin VB.Label Label7 
         Caption         =   "Clasificador"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   330
         Left            =   120
         TabIndex        =   21
         Top             =   345
         Width           =   1095
      End
   End
   Begin VB.Frame frm_emi 
      Caption         =   "Descripción Del Emisor"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00C00000&
      Height          =   1170
      Left            =   0
      TabIndex        =   12
      Top             =   675
      Width           =   10125
      Begin BACControles.TXTNumero txt_cod_emi 
         Height          =   315
         Left            =   2640
         TabIndex        =   3
         Top             =   480
         Width           =   735
         _ExtentX        =   1296
         _ExtentY        =   556
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0"
         Text            =   "0"
         Min             =   "0"
         Max             =   "99999"
      End
      Begin BACControles.TXTNumero txt_rut_emi 
         Height          =   315
         Left            =   120
         TabIndex        =   1
         Top             =   480
         Width           =   1575
         _ExtentX        =   2778
         _ExtentY        =   556
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0"
         Text            =   "0"
         Min             =   "0"
         Max             =   "999999999"
      End
      Begin VB.TextBox txt_dv 
         Height          =   315
         Left            =   1995
         MaxLength       =   2
         TabIndex        =   2
         Top             =   480
         Width           =   480
      End
      Begin VB.Label LblEstadoCliente 
         Alignment       =   2  'Center
         Caption         =   "Cliente no se encuentra Vigente"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H000000FF&
         Height          =   255
         Left            =   3570
         TabIndex        =   26
         Top             =   870
         Width           =   6375
      End
      Begin VB.Label Label6 
         Caption         =   "Nombre o Razon Social"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   210
         Left            =   3555
         TabIndex        =   19
         Top             =   210
         Width           =   2160
      End
      Begin VB.Label lbl_nom_emi 
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
         ForeColor       =   &H8000000D&
         Height          =   315
         Left            =   3570
         TabIndex        =   18
         Top             =   510
         Width           =   6390
      End
      Begin VB.Label Label5 
         Caption         =   "Código"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   195
         Left            =   2640
         TabIndex        =   17
         Top             =   225
         Width           =   660
      End
      Begin VB.Label Label4 
         Caption         =   "Dígito"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   270
         Left            =   1965
         TabIndex        =   16
         Top             =   225
         Width           =   660
      End
      Begin VB.Label Label2 
         Alignment       =   2  'Center
         Caption         =   "-"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   285
         Left            =   1740
         TabIndex        =   14
         Top             =   525
         Width           =   270
      End
      Begin VB.Label Label1 
         Caption         =   "Rut"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   285
         Left            =   165
         TabIndex        =   13
         Top             =   225
         Width           =   315
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   660
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   10185
      _ExtentX        =   17965
      _ExtentY        =   1164
      ButtonWidth     =   1032
      ButtonHeight    =   1005
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   9
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   11
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   12
         EndProperty
      EndProperty
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   5730
         Top             =   0
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   32
         ImageHeight     =   32
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   18
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bac_manten_emisores.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bac_manten_emisores.frx":031A
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bac_manten_emisores.frx":076C
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bac_manten_emisores.frx":0BBE
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bac_manten_emisores.frx":0ED8
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bac_manten_emisores.frx":11F2
               Key             =   ""
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bac_manten_emisores.frx":1644
               Key             =   ""
            EndProperty
            BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bac_manten_emisores.frx":179E
               Key             =   ""
            EndProperty
            BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bac_manten_emisores.frx":1BF0
               Key             =   ""
            EndProperty
            BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bac_manten_emisores.frx":2042
               Key             =   ""
            EndProperty
            BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bac_manten_emisores.frx":235C
               Key             =   ""
            EndProperty
            BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bac_manten_emisores.frx":2676
               Key             =   ""
            EndProperty
            BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bac_manten_emisores.frx":27D0
               Key             =   ""
            EndProperty
            BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bac_manten_emisores.frx":2C22
               Key             =   ""
            EndProperty
            BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bac_manten_emisores.frx":3074
               Key             =   ""
            EndProperty
            BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bac_manten_emisores.frx":338E
               Key             =   ""
            EndProperty
            BeginProperty ListImage17 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bac_manten_emisores.frx":36A8
               Key             =   ""
            EndProperty
            BeginProperty ListImage18 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bac_manten_emisores.frx":39C2
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Label Label3 
      Caption         =   "Rut"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000D&
      Height          =   285
      Left            =   0
      TabIndex        =   15
      Top             =   0
      Width           =   315
   End
End
Attribute VB_Name = "Bac_Emisores"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim sw As String
Function buscar_emisor_riesgo(rut, Dv, cod)
    Dim Datos()
    envia = Array()
    AddParam envia, CDbl(rut)
    AddParam envia, Dv
    AddParam envia, CDbl(cod)
    If Bac_Sql_Execute("SVC_EMI_BUS_DAT", envia) Then
        Do While Bac_SQL_Fetch(Datos)
            For i = 0 To box_Clas1.ListCount - 1
                box_Clas1.ListIndex = i
                If box_Clas1.Text = Datos(1) Then
                    box_Clas1.Enabled = False
                    Exit For
                End If
                box_Clas1.ListIndex = -1
            Next

            For i = 0 To box_Clas2.ListCount - 1
                box_Clas2.ListIndex = i
                If box_Clas2.Text = Datos(2) Then
                    box_Clas2.Enabled = False
                    Exit For
                End If
                box_Clas2.ListIndex = -1
            Next

            Call llena_combo_corto_pargo(box_Clas1.Text, 1)
            Call llena_combo_corto_pargo(box_Clas2.Text, 2)

            For i = 0 To box_tipo_c1.ListCount - 1
                box_tipo_c1.ListIndex = i
                If box_tipo_c1.Text = Datos(4) Then
                    box_tipo_c1.Enabled = False
                    Exit For
                End If
                box_tipo_c1.ListIndex = -1
            Next

            For i = 0 To box_tipo_l1.ListCount - 1
                box_tipo_l1.ListIndex = i
                If box_tipo_l1.Text = Datos(4) Then
                    box_tipo_l1.Enabled = False
                    Exit For
                End If
                box_tipo_l1.ListIndex = -1
            Next
            
            For i = 0 To box_tipo_c2.ListCount - 1
                box_tipo_c2.ListIndex = i
                If box_tipo_c2.Text = Datos(5) Then
                    box_tipo_c2.Enabled = False
                    Exit For
                End If
                box_tipo_c2.ListIndex = -1
            Next

            For i = 0 To box_tipo_l2.ListCount - 1
                box_tipo_l2.ListIndex = i
                If box_tipo_l2.Text = Datos(6) Then
                    box_tipo_l2.Enabled = False
                    Exit For
                End If
                box_tipo_l2.ListIndex = -1
            Next
        Loop
    End If
    box_Clas1.Enabled = True
    box_Clas2.Enabled = True
    box_tipo_c1.Enabled = True
    box_tipo_l1.Enabled = True
    box_tipo_c2.Enabled = True
    box_tipo_l2.Enabled = True
'    envia = Array()
'    AddParam envia, box_Clas1.Text
'    AddParam envia, box_Clas2.Text
'    If Bac_Sql_Execute("Sp_invex_buscar_clasificacion_riesgo", envia) Then
'        Do While Bac_SQL_Fetch(datos)
'            txt_corto.Text = datos(1)
'            txt_largo.Text = datos(2)
'        Loop
'    End If
End Function

Function Clear_Objetos()
    LblEstadoCliente.Caption = ""
    txt_rut_emi.Text = " "
    txt_dv.Text = " "
    txt_cod_emi.Text = " "
    lbl_nom_emi.Caption = " "
    box_tipo_c1.ListIndex = -1
    box_tipo_l1.ListIndex = -1
    box_tipo_c2.ListIndex = -1
    box_tipo_l2.ListIndex = -1
    
    box_Clas1.ListIndex = -1
    box_Clas2.ListIndex = -1
    Toolbar1.Buttons(1).Enabled = False
    box_Clas1.Enabled = False
    box_Clas2.Enabled = False
    txt_rut_emi.Enabled = True
    txt_dv.Enabled = True
    txt_cod_emi.Enabled = True

    sw = 0
End Function

Function grabar_datos()
    Dim Datos()
    envia = Array()
    AddParam envia, CDbl(txt_rut_emi.Text)
    AddParam envia, txt_dv.Text
    AddParam envia, CDbl(txt_cod_emi.Text)
    AddParam envia, lbl_nom_emi.Caption
    AddParam envia, box_Clas1.Text
    AddParam envia, box_Clas2.Text
    AddParam envia, box_tipo_c1.Text
    AddParam envia, box_tipo_l1.Text
    AddParam envia, box_tipo_c2.Text
    AddParam envia, box_tipo_l2.Text
    If Bac_Sql_Execute("SVA_EMI_GRB_DAT", envia) Then
        Do While Bac_SQL_Fetch(Datos)
        Loop
        Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "Datos Emisor " & lbl_nom_emi.Caption & ", rut #" & txt_rut_emi.Text & " grabados con exito")
        MsgBox "Datos Grabados Con Exito", vbInformation, gsBac_Version
    Else
        Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "Problemas Grbar datos Emisor " & lbl_nom_emi.Caption & ", rut #" & txt_rut_emi.Text)
    End If
    
End Function

Function llena_combo_clasificador()
    Dim Datos()
    box_Clas1.Clear
    box_Clas2.Clear
    If Bac_Sql_Execute("SVC_EMI_COD_RSG") Then
        Do While Bac_SQL_Fetch(Datos)
                box_Clas1.AddItem Datos(1)
                box_Clas2.AddItem Datos(1)
        Loop
    End If
    
End Function

Function llena_combo_corto_pargo(Clas, cod)
    
    Dim Datos()
    If cod = 1 Then
        box_tipo_c1.Clear
        box_tipo_l1.Clear
    Else
        box_tipo_c2.Clear
        box_tipo_l2.Clear
    End If
    envia = Array()
    AddParam envia, Clas
    If Bac_Sql_Execute("SVC_EMI_CLF_RSG", envia) Then
        Do While Bac_SQL_Fetch(Datos)
            If cod = 1 Then
                box_tipo_c1.AddItem Datos(1)
                box_tipo_l1.AddItem Datos(1)
            Else
                box_tipo_c2.AddItem Datos(1)
                box_tipo_l2.AddItem Datos(1)
            End If
        Loop
    End If
End Function


Function valida_datos()
    valida_datos = True
    If box_Clas1.ListIndex = -1 Then
        MsgBox "Ingrese Clasificador 1", vbExclamation, gsBac_Version
        valida_datos = False
        box_Clas1.SetFocus
        Exit Function
    ElseIf box_Clas2.ListIndex = -1 Then
        MsgBox "Ingrese Clasificador 2", vbExclamation, gsBac_Version
        valida_datos = False
        box_Clas2.SetFocus
        Exit Function
    ElseIf box_tipo_c1.ListIndex = -1 Then
        MsgBox "Ingrese Tipo de Clasificación", vbExclamation, gsBac_Version
        valida_datos = False
        box_tipo_c1.SetFocus
        Exit Function
    ElseIf box_tipo_l1.ListIndex = -1 Then
        MsgBox "Ingrese Tipo de Clasificación", vbExclamation, gsBac_Version
        valida_datos = False
        box_tipo_l1.SetFocus
        Exit Function
    ElseIf box_tipo_c2.ListIndex = -1 Then
        MsgBox "Ingrese Tipo de Clasificación", vbExclamation, gsBac_Version
        valida_datos = False
        box_tipo_c2.SetFocus
        Exit Function
    ElseIf box_tipo_l2.ListIndex = -1 Then
        MsgBox "Ingrese Tipo de Clasificación", vbExclamation, gsBac_Version
        valida_datos = False
        box_tipo_l2.SetFocus
        Exit Function
    End If
End Function

Private Sub box_Clas1_Click()
    Call llena_combo_corto_pargo(box_Clas1.Text, 1)
End Sub

Private Sub box_Clas2_Click()
    Call llena_combo_corto_pargo(box_Clas2.Text, 2)
End Sub


Private Sub Form_Load()
    Move 0, 0
    Me.Icon = BAC_INVERSIONES.Icon
    Clear_Objetos
    Call llena_combo_clasificador
    
    sw = 0
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
    Select Case Button.Index
        Case 1
            If valida_datos Then
                Call grabar_datos
                Call Clear_Objetos
            End If
            
        Case 2
            Clear_Objetos
        Case 3
            Unload Me
        End Select
End Sub

Private Sub txt_clasi_DblClick()
    BacAyuda.Tag = "RIESGO"
    BacAyuda.Show 1
    If giAceptar% = True Then
        txt_Clasi.Text = gsrut$
        txt_Clasi.Enabled = True
        Call buscar_rieago(txt_Clasi.Text)
    End If
End Sub
Function buscar_rieago(Glosa)
    Dim Datos()
    envia = Array()
    AddParam envia, Glosa
    If Bac_Sql_Execute("SVC_RSG_BUS_COD", envia) Then
        Do While Bac_SQL_Fetch(Datos)
            If Datos(1) = "1" Then
                txt_corto.Text = Datos(2)
                txt_largo.Text = Datos(3)
                txt_corto.Enabled = False
                txt_largo.Enabled = False
                
                
            Else
                MsgBox "No Existe Esta Clasificación De Riego", vbExclamation, gsBac_Version
                txt_Clasi.Text = " "
            End If
        Loop
    End If

End Function

Private Sub txt_cod_emi_KeyPress(KeyAscii As Integer)

If KeyAscii = 13 Then
    txt_cod_emi_LostFocus
End If

End Sub


Private Sub txt_cod_emi_LostFocus()
    Call buscar_emisores(txt_rut_emi.Text, txt_dv.Text, txt_cod_emi.Text)
End Sub
Function buscar_emisores(rut, Dv, cod)
    If CDbl(txt_rut_emi.Text) = 0 Then
        Exit Function
    ElseIf txt_dv.Text = " " Then
        Exit Function
    ElseIf CDbl(txt_cod_emi.Text) = 0 Then
        Exit Function
    End If
    Dim Datos()
    envia = Array()
    AddParam envia, CDbl(rut)
    AddParam envia, Dv
    AddParam envia, CDbl(cod)
    If Bac_Sql_Execute("SVC_EMI_VAL_DAT", envia) Then
        Do While Bac_SQL_Fetch(Datos)
            If Datos(1) = "1" Then
                lbl_nom_emi.Caption = Datos(2)
                Toolbar1.Buttons(1).Enabled = True
                txt_rut_emi.Enabled = False
                txt_dv.Enabled = False
                txt_cod_emi.Enabled = False
                box_Clas1.Enabled = True
                Call buscar_emisor_riesgo(txt_rut_emi.Text, txt_dv.Text, txt_cod_emi.Text)
            Else
                MsgBox "Cliente No Existe, Debe Ingresarlo en Sistena Parametros", vbExclamation, gsBac_Version
                Clear_Objetos
            End If
            
            If datos(3) = "N" Then
               Toolbar1.Buttons(1).Enabled = False
               LblEstadoCliente.Caption = "Cliente No Se encuentra Vigente"
               Exit Function
            End If
        
        Loop
    End If
    
End Function

Private Sub txt_dv_KeyPress(KeyAscii As Integer)
 
 If KeyAscii = 13 Then
    txt_cod_emi.SetFocus
 Else
    KeyAscii = Asc(UCase(Chr(KeyAscii)))
 End If

End Sub

Private Sub txt_rut_emi_Change()
    lbl_nom_emi.Caption = " "
    txt_dv.Text = " "
    txt_cod_emi.Text = " "
End Sub

Private Sub txt_rut_emi_DblClick()
    BacAyuda.Tag = "EMISOR" ' "MDCL"
    BacAyuda.Show 1
    If giAceptar% = True Then
        txt_rut_emi.Text = CDbl(Trim(Mid(gsrut$, 44, 9)))
        txt_dv.Text = Trim(Mid(gsrut$, 56, 1))
        txt_cod_emi.Text = CDbl(Trim(Mid(gsrut$, 58, 1)))
        lbl_nom_emi.Caption = Trim(Mid(gsrut$, 1, 40))
        Call buscar_emisor_riesgo(txt_rut_emi.Text, txt_dv.Text, txt_cod_emi.Text)
        Toolbar1.Buttons(1).Enabled = True
        txt_rut_emi.Enabled = False
        txt_dv.Enabled = False
        txt_cod_emi.Enabled = False
        box_Clas1.Enabled = True

    End If
End Sub

Private Sub txt_rut_emi_KeyPress(KeyAscii As Integer)

If KeyAscii = 13 Then
 txt_dv.SetFocus
End If

End Sub


