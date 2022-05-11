VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "Msflxgrd.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form Bac_Tabla_Desarrollo 
   Caption         =   "Bonos Adquiridos en el Extranjero"
   ClientHeight    =   6450
   ClientLeft      =   435
   ClientTop       =   1005
   ClientWidth     =   11100
   ControlBox      =   0   'False
   Icon            =   "Bac_desarrollo.frx":0000
   LinkTopic       =   "Form1"
   MDIChild        =   -1  'True
   ScaleHeight     =   6450
   ScaleWidth      =   11100
   Begin VB.Frame frm_instr 
      Caption         =   "Instrumento"
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
      Height          =   1470
      Left            =   -15
      TabIndex        =   3
      Top             =   570
      Width           =   11070
      Begin VB.ComboBox box_Nemo 
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
         Left            =   1710
         Style           =   2  'Dropdown List
         TabIndex        =   1
         Top             =   285
         Width           =   3930
      End
      Begin VB.Label lbl_descrip 
         BorderStyle     =   1  'Fixed Single
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
         Height          =   315
         Left            =   1695
         TabIndex        =   6
         Top             =   885
         Width           =   8700
      End
      Begin VB.Label Label3 
         Caption         =   "Descripción"
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
         Left            =   180
         TabIndex        =   5
         Top             =   915
         Width           =   1005
      End
      Begin VB.Label Label2 
         Caption         =   "Nemotécnico"
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
         Height          =   375
         Left            =   150
         TabIndex        =   4
         Top             =   330
         Width           =   1845
      End
   End
   Begin VB.Frame frm_tabla_des 
      Caption         =   "Tabla De Desarrollo"
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
      Height          =   4335
      Left            =   -15
      TabIndex        =   0
      Top             =   2130
      Visible         =   0   'False
      Width           =   11070
      Begin BACControles.TXTNumero txt_Numero 
         Height          =   360
         Left            =   2640
         TabIndex        =   10
         Top             =   2520
         Visible         =   0   'False
         Width           =   3735
         _ExtentX        =   6588
         _ExtentY        =   635
         BackColor       =   12632256
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0.000000"
         Text            =   "0.000000"
         Min             =   "0"
         Max             =   "9999.999999"
         CantidadDecimales=   "6"
         Separator       =   -1  'True
      End
      Begin MSMask.MaskEdBox txt_fecha 
         Height          =   390
         Left            =   1110
         TabIndex        =   8
         Top             =   1275
         Visible         =   0   'False
         Width           =   2835
         _ExtentX        =   5001
         _ExtentY        =   688
         _Version        =   393216
         BackColor       =   -2147483644
         MaxLength       =   10
         Mask            =   "##/##/####"
         PromptChar      =   " "
      End
      Begin VB.TextBox Text1 
         Height          =   285
         Left            =   4605
         TabIndex        =   9
         Text            =   "Text1"
         Top             =   990
         Visible         =   0   'False
         Width           =   2670
      End
      Begin MSFlexGridLib.MSFlexGrid grilla 
         Height          =   4050
         Left            =   75
         TabIndex        =   7
         Top             =   225
         Width           =   10920
         _ExtentX        =   19262
         _ExtentY        =   7144
         _Version        =   393216
         Rows            =   1
         Cols            =   7
         BackColor       =   -2147483644
         ForeColor       =   12582912
         BackColorFixed  =   8421376
         BackColorSel    =   8388608
         ForeColorSel    =   12632256
         BackColorBkg    =   8421376
         GridColor       =   64
         Enabled         =   -1  'True
         HighLight       =   2
         GridLines       =   2
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   9
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MouseIcon       =   "Bac_desarrollo.frx":030A
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   2
      Top             =   0
      Width           =   11100
      _ExtentX        =   19579
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
            ImageIndex      =   4
            BeginProperty ButtonMenus {66833FEC-8583-11D1-B16A-00C0F0283628} 
               NumButtonMenus  =   1
               BeginProperty ButtonMenu1 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
            EndProperty
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.ToolTipText     =   "Ver Tabla"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir De La Tabla"
            ImageIndex      =   5
         EndProperty
      EndProperty
      BorderStyle     =   1
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
            NumListImages   =   5
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bac_desarrollo.frx":075C
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bac_desarrollo.frx":08B6
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bac_desarrollo.frx":0BD0
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bac_desarrollo.frx":1022
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bac_desarrollo.frx":1134
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
End
Attribute VB_Name = "Bac_Tabla_Desarrollo"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim Opcion As String

Dim contenido As String
Dim i    As Integer
Dim amortiza
Dim flujo
Dim intereses
Dim Fecha As String
Dim saldo
'Variables Para Calculo De Tabla De desarrollo

Dim Nom_Nemo As String
Dim tip_tasa As Integer
Dim Num_cupones  As Integer

Dim Periodo As Integer
Dim Afecto_Encaje As String

Dim Tasa_Emis As Double
Dim Fec_vcto

Dim Fec_emi As Date
Dim Fec_Pago As Date
Dim dias_reales As String

Dim base_flujo As Integer
Dim Tasa_Fija As String
'+++COLTES, jcamposd
Dim marcaColtes As Integer
Dim montoEmision As Double
'---COLTES, jcamposd

Function buscar_datos_nemo()
    Dim prueba
    If box_nemo.ListIndex = -1 Then
        MsgBox "No Ha Elejido Ningún Instrumento", vbInformation, gsBac_Version
        Exit Function
    End If
    Toolbar1.Buttons(2).Enabled = True
    Toolbar1.Buttons(3).Enabled = False
    Dim Datos()
    envia = Array()
    AddParam envia, Trim(Mid(box_nemo.Text, 1, 20))
    prueba = Trim(Mid(box_nemo.Text, 23, 10))
    AddParam envia, Trim(Mid(box_nemo.Text, 23, 10))
    If Bac_Sql_Execute("SVC_GEN_AYD_SER", envia) Then
        Do While Bac_SQL_Fetch(Datos)
            Nom_Nemo = Datos(3)
            lbl_descrip.Caption = Datos(3)
            tip_tasa = Datos(5)
            Periodo = Datos(7)
            Num_cupones = Datos(8)
            Fec_vcto = Format(Datos(10), "DD/MM/YYYY")
            Afecto_Encaje = Datos(11)
            Tasa_Emis = CDbl(Datos(12))
            Fec_Pago = Datos(15)
            dias_reales = Datos(16)
            base_flujo = Datos(17)
            Tasa_Fija = Datos(18)
            Fec_emi = Format(Datos(9), "DD/MM/YYYY")
            marcaColtes = Datos(21) '--COLTES, jcamposd 20171207, Si es coltes viene marcado con 1
            montoEmision = Datos(19)
            frm_instr.Enabled = False
        Loop
    End If
End Function

Function Clear_Objetos()
    frm_instr.Enabled = True
    box_nemo.ListIndex = -1
    lbl_descrip.Caption = ""
    frm_tabla_des.Visible = False
    grilla.Rows = 1
    Toolbar1.Buttons(1).Enabled = False
    Toolbar1.Buttons(2).Enabled = False
    Toolbar1.Buttons(3).Enabled = True
    Me.Height = 2475
    box_nemo.SetFocus
    
End Function

Function llena_combo_nemo()
    Dim Datos()
    box_nemo.Clear
    If Bac_Sql_Execute("SVC_GEN_LEE_SER") Then
        Do While Bac_SQL_Fetch(Datos)
            box_nemo.AddItem Datos(2) & Space(20 - Len(Datos(2))) & " (" & Format(Datos(3), "DD/MM/YYYY") & ") "
            box_nemo.ItemData(box_nemo.NewIndex) = Val(Datos(1))
        Loop
    End If
End Function
Function llena_tabla_grilla()
    borrar_tabla
    Dim SQL As String
    Dim res
    Dim Datos()
    Dim i As Integer
    For i = 1 To grilla.Rows - 1
        envia = Array()
        AddParam envia, 2000
        AddParam envia, Trim(Mid(box_nemo.Text, 1, 20))
        AddParam envia, Trim(Mid(box_nemo.Text, 23, 10))
        AddParam envia, i
        AddParam envia, grilla.TextMatrix(i, 2)
        AddParam envia, CDbl(grilla.TextMatrix(i, 3))
        AddParam envia, CDbl(grilla.TextMatrix(i, 4))
        AddParam envia, CDbl(grilla.TextMatrix(i, 5))
        AddParam envia, CDbl(grilla.TextMatrix(i, 6))
        AddParam envia, CDbl(grilla.TextMatrix(i, 7))
        If Bac_Sql_Execute("SVC_TDE_BUS_DAT", envia) Then
            Do While Bac_SQL_Fetch(Datos)
                Exit Function
            Loop
            res = 1
            
        Else
                MsgBox "Problemas Con SQL", vbCritical, gsBac_Version
        End If
    Next
    If res = 1 Then
        MsgBox "Operación Realizada Con Exito", vbInformation, gsBac_Version
        Call Clear_Objetos
    End If
End Function

Sub mostrar_grilla()
    
    grilla.Clear
    grilla.Refresh
    
    Me.Height = 7845
    Me.Width = 11640
    
    dibuja_grilla

End Sub
Sub dibuja_grilla()

    grilla.RowHeight(0) = 400
    grilla.Rows = grilla.FixedRows
    grilla.Cols = 8
    
    grilla.TextMatrix(0, 1) = "Nro."
    grilla.TextMatrix(0, 2) = "Fecha de Vcto."
    grilla.TextMatrix(0, 3) = "Intereses"
    grilla.TextMatrix(0, 4) = "Amortización"
    grilla.TextMatrix(0, 5) = "Flujo"
    grilla.TextMatrix(0, 6) = "Saldo"
    grilla.TextMatrix(0, 7) = "Factor"
    
    grilla.ColWidth(0) = 200
    grilla.ColWidth(1) = 450
    grilla.ColWidth(2) = 1200
    grilla.ColWidth(3) = 1900
    grilla.ColWidth(4) = 1900
    grilla.ColWidth(5) = 1900
    grilla.ColWidth(6) = 1900
    grilla.ColWidth(7) = 1300
    
End Sub
Sub llena_grilla()
    Dim SQL As String
    Dim Datos()
    Dim OpC
    Dim num As Integer
    num = 0
    Dim cupon As Integer
    Dim Amor_Aux As Double 'Integer
    Dim forma As Integer
    Dim fechas As String
    Dim ncu
    Dim prueba As Integer
    Dim Diferencia
    ncu = 0
    i = 0
    'Grilla.Rows = 1
    
    grilla.Rows = Num_cupones + 1
    If Tasa_Fija = "T" Then
        i = 0
        
        For i = 1 To Num_cupones
            grilla.TextMatrix(i, 1) = i
            grilla.RowHeight(i) = 350
            If i = 1 Then
                grilla.TextMatrix(i, 2) = Format(Fec_Pago, "DD/MM/YYYY")
                fechas = grilla.TextMatrix(i, 2)
                If dias_reales = "T" Then
                    '+++COLTES, jcamposd para los coltes son a 365 el conteo de día
                    If marcaColtes = 1 Then
                        Diferencia = DIAS365(Fec_emi, Fec_Pago)
                        'intereses = (Tasa_Emis / 100) * montoEmision
                        intereses = Round(CDbl(((Tasa_Emis / base_flujo) * Diferencia)), 6)
                    Else
                        Diferencia = DateDiff("D", Fec_emi, Fec_Pago)
                        intereses = Round(CDbl(((Tasa_Emis / base_flujo) * Diferencia)), 6)
                    End If
                Else
                    Diferencia = DateDiff("M", Fec_emi, Fec_Pago) * 30
                    intereses = Round(CDbl(((Tasa_Emis / base_flujo) * Diferencia)), 6)
                End If
                If i = Val(Num_cupones) Then
                    If marcaColtes = 1 Then
                        grilla.TextMatrix(i, 4) = 100 'montoEmision
                    Else
                        grilla.TextMatrix(i, 4) = 100
                    End If
                Else
                    grilla.TextMatrix(i, 4) = 0
                End If
                grilla.TextMatrix(i, 3) = intereses
                amortiza = grilla.TextMatrix(i, 4)
                Amor_Aux = Amor_Aux + amortiza
                grilla.TextMatrix(i, 5) = Format(grilla.TextMatrix(i, 5), "0,0")
                grilla.TextMatrix(i, 5) = intereses + amortiza
                flujo = Format(flujo, "0,0")
                flujo = grilla.TextMatrix(i, 5)
                
                If marcaColtes = 1 Then
                    grilla.TextMatrix(i, 6) = 100 - Amor_Aux 'montoEmision - Amor_Aux
                Else
                    grilla.TextMatrix(i, 6) = 100 - Amor_Aux
                End If
                saldo = grilla.TextMatrix(i, 6)
                grilla.TextMatrix(i, 3) = Format(grilla.TextMatrix(i, 3), "0.000000")
                grilla.TextMatrix(i, 4) = Format(grilla.TextMatrix(i, 4), "0.000000")
                grilla.TextMatrix(i, 5) = Format(grilla.TextMatrix(i, 5), "0.000000")
                grilla.TextMatrix(i, 6) = Format(grilla.TextMatrix(i, 6), "0.000000")
                grilla.TextMatrix(i, 7) = Format(1, "0.000000000")
            Else
                fechas = grilla.TextMatrix(i - 1, 2)
                grilla.TextMatrix(i, 2) = Format(DateAdd("M", Periodo, fechas), "DD/MM/YYYY")
                'fechas = grilla.TextMatrix(I, 2)
                If dias_reales = "T" Then
                    '+++COLTES, jcamposd para los coltes son a 365 el conteo de día
                    If marcaColtes = 1 Then
                        Diferencia = DIAS365(Format(fechas, "DD/MM/YYYY"), Format(grilla.TextMatrix(i, 2), "DD/MM/YYYY"))
                        'intereses = (Tasa_Emis / 100) * montoEmision
                        intereses = Round(CDbl(((Tasa_Emis / base_flujo) * Diferencia)), 6)
                    Else
                        Diferencia = DateDiff("D", fechas, grilla.TextMatrix(i, 2))
                        intereses = Round(CDbl(((Tasa_Emis / base_flujo) * Diferencia)), 6)
                    End If
                    
                Else
                    Diferencia = (DateDiff("m", fechas, grilla.TextMatrix(i, 2)) * 30)
                    intereses = Round(CDbl(((Tasa_Emis / base_flujo) * Diferencia)), 6)
                End If
                If i = Val(Num_cupones) Then
                    If marcaColtes = 1 Then
                        grilla.TextMatrix(i, 4) = 100 'montoEmision
                    Else
                        grilla.TextMatrix(i, 4) = 100
                    End If
                Else
                    grilla.TextMatrix(i, 4) = 0
                End If
                grilla.TextMatrix(i, 3) = intereses
                amortiza = grilla.TextMatrix(i, 4)
                Amor_Aux = Amor_Aux + amortiza
                grilla.TextMatrix(i, 5) = Format(grilla.TextMatrix(ncu, 5), "0,0")
                grilla.TextMatrix(i, 5) = intereses + amortiza
                flujo = Format(flujo, "0,0")
                flujo = grilla.TextMatrix(i, 5)
                If marcaColtes = 1 Then
                    grilla.TextMatrix(i, 6) = 100 - Amor_Aux 'montoEmision - Amor_Aux
                Else
                    grilla.TextMatrix(i, 6) = 100 - Amor_Aux
                End If
                saldo = grilla.TextMatrix(i, 6)
                Fec_vcto = grilla.TextMatrix(i, 2)
                grilla.TextMatrix(i, 3) = Format(grilla.TextMatrix(i, 3), "0.000000")
                grilla.TextMatrix(i, 4) = Format(grilla.TextMatrix(i, 4), "0.000000")
                grilla.TextMatrix(i, 5) = Format(grilla.TextMatrix(i, 5), "0.000000")
                grilla.TextMatrix(i, 6) = Format(grilla.TextMatrix(i, 6), "0.000000")
                grilla.TextMatrix(i, 7) = Format(1, "0.000000000")
            End If
        Next
    Else
        For i = 1 To Num_cupones

            cupon = i
            forma = 360
            ncu = ncu + 1
            grilla.RowHeight(i) = 350
            grilla.TextMatrix(ncu, 3) = 0
            grilla.TextMatrix(ncu, 1) = i
            
            If Periodo = 99 Then
                '99 es para periodo pago unico, por lo que sumaba 99 meses a la fecha, lo que debe ser fecha de termino como pago
                grilla.TextMatrix(ncu, 2) = Format(Fec_vcto, "dd/mm/yyyy")
            Else
                If i = 1 Then
                    grilla.TextMatrix(ncu, 2) = Format(Fec_Pago, "dd/mm/yyyy")
                Else
                    grilla.TextMatrix(ncu, 2) = Format(DateAdd("M", Periodo, Fec_Pago), "dd/mm/yyyy")
                End If
                
            End If
          Fec_Pago = grilla.TextMatrix(ncu, 2) '  Fec_vcto
            If i = Val(Num_cupones) Then
                grilla.TextMatrix(ncu, 4) = 100
            Else
                grilla.TextMatrix(ncu, 4) = 0
            End If
            amortiza = grilla.TextMatrix(ncu, 4)
            Amor_Aux = Amor_Aux + amortiza
            grilla.TextMatrix(ncu, 5) = Format(grilla.TextMatrix(ncu, 5), "0.0")
            grilla.TextMatrix(ncu, 5) = amortiza
            intereses = 0
            flujo = Format(flujo, "0,0")
            flujo = grilla.TextMatrix(ncu, 5)
            grilla.TextMatrix(ncu, 6) = 100 - Amor_Aux
            saldo = grilla.TextMatrix(ncu, 6)
            grilla.TextMatrix(i, 3) = Format(grilla.TextMatrix(i, 3), "0.000000")
            grilla.TextMatrix(i, 4) = Format(grilla.TextMatrix(i, 4), "0.000000")
            grilla.TextMatrix(i, 5) = Format(grilla.TextMatrix(i, 5), "0.000000")
            grilla.TextMatrix(i, 6) = Format(grilla.TextMatrix(i, 6), "0.000000")
            grilla.TextMatrix(i, 7) = Format(1, "0.000000000")
        Next
    End If
End Sub
Function borrar_tabla()
    Dim SQL As String
    Dim i As Integer
    For i = 1 To Num_cupones
        Dim Datos()
        envia = Array()
        AddParam envia, Trim(Mid(box_nemo.Text, 1, 20))
        AddParam envia, Trim(Mid(box_nemo.Text, 23, 10))
        If Bac_Sql_Execute("SVA_TDE_ELI_DAT", envia) Then
            Do While Bac_SQL_Fetch(Datos)
            Loop
        End If
    Next
End Function


Function buscar_tabla_bonos()
    Dim SQL As Integer
    Dim Datos()
    i = 0
    Toolbar1.Buttons(3).Enabled = False
    grilla.Rows = Num_cupones + 1
    For i = 1 To Num_cupones
        
        envia = Array()
        AddParam envia, 2000
        AddParam envia, Trim(Mid(box_nemo.Text, 1, 20))
        AddParam envia, i
        AddParam envia, Trim(Mid(box_nemo.Text, 23, 10))
        If Bac_Sql_Execute("SVC_TDE_LEE_DAT", envia) Then
            Do While Bac_SQL_Fetch(Datos)
                grilla.RowHeight(i) = 350
                grilla.TextMatrix(i, 1) = Datos(3)
                grilla.TextMatrix(i, 2) = Format(Datos(5), "dd/mm/yyyy")
                'grilla.TextMatrix(I, 3) = CDbl(datos(5))
                'grilla.TextMatrix(I, 4) = datos(6)
                'grilla.TextMatrix(I, 5) = datos(7)
                'grilla.TextMatrix(I, 6) = datos(8)
                grilla.TextMatrix(i, 3) = CDbl(Datos(6))
                grilla.TextMatrix(i, 4) = Datos(7)
                grilla.TextMatrix(i, 5) = Datos(8)
                grilla.TextMatrix(i, 6) = Datos(9)
                grilla.TextMatrix(i, 7) = Datos(10)
                grilla.TextMatrix(i, 3) = Format(grilla.TextMatrix(i, 3), "0.000000")
                grilla.TextMatrix(i, 4) = Format(grilla.TextMatrix(i, 4), "0.000000")
                grilla.TextMatrix(i, 5) = Format(grilla.TextMatrix(i, 5), "0.000000")
                grilla.TextMatrix(i, 6) = Format(grilla.TextMatrix(i, 6), "0.000000")
                grilla.TextMatrix(i, 7) = Format(grilla.TextMatrix(i, 7), "0.000000000")
            Loop
        End If
    Next
End Function

Function ver_tabla()
    If box_nemo.ListIndex = -1 Then
        MsgBox "No Ha Seleccionado Ningun Instrumento", vbInformation, gsBac_Version
        Exit Function
    End If
    Dim Datos()
    envia = Array()
    AddParam envia, 2000
    AddParam envia, Trim(Mid(box_nemo.Text, 1, 20))
    AddParam envia, Trim(Mid(box_nemo.Text, 23, 10))
    If Bac_Sql_Execute("SVC_TDE_VER_DAT", envia) Then
        Do While Bac_SQL_Fetch(Datos)
        Loop
    End If
    If Datos(1) = 1 Then
        Opcion = MsgBox("Tabla Ya Existe ¿ Generar Nuevamente ?", vbQuestion + vbYesNo, gsBac_Version)
        If Opcion = vbYes Then
            frm_tabla_des.Visible = True
            Toolbar1.Buttons(1).Enabled = True
            Toolbar1.Buttons(3).Enabled = False
            Toolbar1.Buttons(2).Enabled = False
            llena_grilla
            posiciona_formulario
            Me.Height = 7000
        Else
            Toolbar1.Buttons(1).Enabled = True
            frm_tabla_des.Visible = True
            Toolbar1.Buttons(2).Enabled = False
            Toolbar1.Buttons(3).Enabled = False
            buscar_tabla_bonos
            posiciona_formulario
            Me.Height = 7000
        End If
    Else
        Opcion = MsgBox("Tabla No Existe ¿ Desea Generarla ?", vbQuestion + vbYesNo, gsBac_Version)
        If Opcion = vbYes Then
            Toolbar1.Buttons(1).Enabled = True
            Toolbar1.Buttons(2).Enabled = False
            frm_tabla_des.Visible = True
            Call llena_grilla
            Toolbar1.Buttons(3).Enabled = False
            posiciona_formulario
            Me.Height = 7000
            '7845
        Else
            Exit Function
        End If
    End If
End Function

Private Sub Form_Load()
    Move 0, 0
    dibuja_grilla
    mostrar_grilla
    Me.Height = 2700
'    Me.Width = 1220
'   Me.Height = 7845
    Me.Width = 11640
    'posiciona_formulario
    llena_combo_nemo
    Fec_vcto = Format(Fec_vcto, "DD/MM/YYYY")
End Sub

Sub posiciona_formulario()

'    Dim I As Long
'    Dim j As Long
'    grilla.Visible = True
'    If Num_cupones <= 10 Then
'
'         I = grilla.Rows
'         j = grilla.RowHeight(0) = 70
'         Me.frm_tabla_des.Height = grilla.Height + 450
'         Me.Height = Me.frm_tabla_des.Height + 2460
'         Me.Width = Me.frm_tabla_des.Width + 550
'     Else
'         grilla.Height = 10695
'
'         Me.Height = 11325
'         'Me.Width = 7665
'         frm_tabla_des.Height = 10935
'         frm_tabla_des.Width = 6615
'
'     End If

End Sub

Private Sub grilla_KeyPress(KeyAscii As Integer)
   If KeyAscii > 47 Or KeyAscii = 13 Or KeyAscii = 45 Then
        Toolbar1.Buttons(1).Enabled = True
        'text1.Top = grilla.CellTop + grilla.Top
        'text1.Left = grilla.CellLeft + grilla.Left
        'text1.Height = grilla.CellHeight + 20
        'text1.Width = grilla.CellWidth
        '
        txt_Numero.Max = "9999.999999"
        txt_Numero.CantidadDecimales = 6
        
        txt_Numero.Top = grilla.CellTop + grilla.Top
        txt_Numero.Left = grilla.CellLeft + grilla.Left
        txt_Numero.Height = grilla.CellHeight + 20
        txt_Numero.Width = grilla.CellWidth
        '
        txt_fecha.Top = grilla.CellTop + grilla.Top
        txt_fecha.Left = grilla.CellLeft + grilla.Left
        txt_fecha.Height = grilla.CellHeight + 20
        txt_fecha.Width = grilla.CellWidth

        If grilla.Col = 2 And KeyAscii > (KeyAscii > 46 Or KeyAscii < 58) Then
            txt_fecha.Visible = True
            contenido = grilla.TextMatrix(grilla.row, 2)
            txt_fecha.Visible = True
            txt_fecha.Text = "  /  /    "
            If KeyAscii <> 13 Then
                txt_fecha.Text = UCase(Chr(KeyAscii)) & " /  /    "
            End If
            txt_fecha.SetFocus
        End If

        If grilla.Col = 3 And (KeyAscii > 44 Or KeyAscii < 58) Then
            txt_Numero.Text = 0
            contenido = grilla.TextMatrix(grilla.row, 3)
            txt_Numero.Visible = True
            If KeyAscii <> 13 Then
               txt_Numero.Text = Val(UCase(Chr(KeyAscii)))
               txt_Numero.SelStart = 1
            Else
               txt_Numero.Text = CDbl(contenido)
            End If
            txt_Numero.SetFocus

        End If
        If grilla.Col = 4 And (KeyAscii > 44 Or KeyAscii < 58) Then
            txt_Numero.Text = 0
            contenido = grilla.TextMatrix(grilla.row, 4)
            txt_Numero.Visible = True

            If KeyAscii <> 13 And KeyAscii <> 45 Then
                txt_Numero.Text = Val(UCase(Chr(KeyAscii)))
                txt_Numero.SelStart = 1
            Else
                txt_Numero.Text = CDbl(contenido)
            End If
            txt_Numero.SetFocus

        End If
        
        If grilla.Col = 7 And (KeyAscii > 44 Or KeyAscii < 58) Then
            txt_Numero.Max = "9999.999999999"
            txt_Numero.CantidadDecimales = 9
            txt_Numero.Text = 0
            contenido = grilla.TextMatrix(grilla.row, 7)
            txt_Numero.Visible = True

            If KeyAscii <> 13 And KeyAscii <> 45 Then
                txt_Numero.Text = Val(UCase(Chr(KeyAscii)))
                txt_Numero.SelStart = 1
            Else
                txt_Numero.Text = Format(CDbl(contenido), "0.000000000")
            End If
            txt_Numero.SetFocus

        End If
    End If
End Sub

Private Sub Text1_KeyPress(KeyAscii As Integer)
    Dim Amor_Aux
    Amor_Aux = 0
        If grilla.Col = 3 Then
            Text1.Visible = False
            If IsNumeric(Text1.Text) Then
                grilla.TextMatrix(grilla.row, 3) = Text1.Text
                grilla.TextMatrix(grilla.row, 5) = Format(grilla.TextMatrix(grilla.row, 5), "0.0000")
                grilla.TextMatrix(grilla.row, 5) = CDbl(grilla.TextMatrix(grilla.row, 3)) + CDbl(grilla.TextMatrix(grilla.row, 4))
          
            Else
                MsgBox "Monto No Válido !", vbExclamation, gsBac_Version
                Text1.Text = ""
                grilla.SetFocus
'                Text1.SetFocus
            End If
        End If
        If grilla.Col = 4 Then
            Text1.Visible = False
            If IsNumeric(Text1.Text) Then
                grilla.TextMatrix(grilla.row, 4) = Text1.Text
                Dim i As Integer
                For i = 1 To Num_cupones
                    grilla.TextMatrix(grilla.row, 5) = Format(grilla.TextMatrix(grilla.row, 5), "0.0")
                    grilla.TextMatrix(grilla.row, 5) = CDbl(grilla.TextMatrix(grilla.row, 3)) + CDbl(grilla.TextMatrix(grilla.row, 4))
                    Amor_Aux = Amor_Aux + grilla.TextMatrix(i, 4)
                    grilla.TextMatrix(i, 6) = 100 - Amor_Aux
                Next
          Else
                MsgBox "Monto No Válido !", vbExclamation, gsBac_Version
                Text1.Text = ""
                grilla.SetFocus
            End If
        End If

    If KeyAscii = 13 And Text1.Text = "" Then
                If grilla.Col = 2 Then
                Text1.Visible = False
                grilla.TextMatrix(grilla.row, 2) = contenido
                Text1.Text = ""
                contenido = ""
            End If
            If grilla.Col = 3 Then
                Text1.Visible = False
                grilla.TextMatrix(grilla.row, 3) = contenido
                Text1.Text = ""
                contenido = ""
            End If
            If grilla.Col = 4 Then
                Text1.Visible = False
                grilla.TextMatrix(grilla.row, 4) = contenido
                Text1.Text = ""
                contenido = ""
            End If
    End If
    If KeyAscii = 27 Then
            If grilla.Col = 2 Then
                Text1.Visible = False
                grilla.TextMatrix(grilla.row, 2) = contenido
                Text1.Text = ""
                contenido = ""
            End If
            If grilla.Col = 3 Then
                Text1.Visible = False
                grilla.TextMatrix(grilla.row, 3) = contenido
                Text1.Text = ""
                contenido = ""
            End If
            If grilla.Col = 4 Then
                Text1.Visible = False
                grilla.TextMatrix(grilla.row, 4) = contenido
                Text1.Text = ""
                contenido = ""
            End If
    End If
End Sub


Private Sub Text1_LostFocus()
    Text1.Text = ""
    Text1.Visible = False
End Sub
Private Sub Text1_GotFocus()
   If grilla.Col = 2 Then
        Text1.SelStart = Len(Text1)
   ElseIf grilla.Col = 3 Then
        Text1.SelStart = Len(Text1)
   ElseIf grilla.Col = 4 Then
        Text1.SelStart = Len(Text1)
   End If
End Sub
Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
    Select Case Button.Index
    Case 1
        Call llena_tabla_grilla
    Case 2
        Call ver_tabla
    Case 3
        Call buscar_datos_nemo
    Case 4
        Call Clear_Objetos
    Case 5
        Unload Me
    End Select
End Sub
Private Sub txt_fecha_GotFocus()
    
    txt_fecha.SelStart = 0
End Sub
Private Sub txt_fecha_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 And txt_fecha.Text <> "  /  /    " Then
        grilla.SetFocus
        If grilla.Col = 2 Then
            If IsDate(txt_fecha.Text) Then
                txt_fecha.Visible = False
                grilla.TextMatrix(grilla.row, 2) = txt_fecha.Text
            Else
                txt_fecha.Text = "  /  /    "
                txt_fecha.SetFocus
            End If
        End If
    End If
    If KeyAscii = 13 And txt_fecha.Text = " / /    " Then
            If grilla.Col = 2 Then
                txt_fecha.Visible = False
                grilla.TextMatrix(grilla.row, 2) = contenido
                txt_fecha.Text = "  /  /    "
                contenido = ""
            End If
    End If
    If KeyAscii = 27 Then
            If grilla.Col = 2 Then
                txt_fecha.Visible = False
                grilla.TextMatrix(grilla.row, 2) = contenido
                txt_fecha.Text = "  /  /    "
                contenido = ""
            End If
    End If
End Sub
Private Sub txt_numeros_GotFocus()
   If grilla.Col = 3 Then
        txt_Numero.SelStart = Len(txt_Numero)
   ElseIf grilla.Col = 4 Then
        txt_Numero.SelStart = Len(txt_Numero)
   End If
End Sub

Private Sub txt_numeros_KeyPress(KeyAscii As Integer)
    Dim Amor_Aux
    Amor_Aux = 0
    If KeyAscii = 13 And txt_Numero.Text <> "" Then
        grilla.SetFocus
        If grilla.Col = 3 Then
            txt_Numero.Visible = False
            grilla.TextMatrix(grilla.row, 3) = txt_Numero.Text
            grilla.TextMatrix(grilla.row, 5) = Format(grilla.TextMatrix(grilla.row, 5), "0.0000")
            grilla.TextMatrix(grilla.row, 5) = CDbl(grilla.TextMatrix(grilla.row, 3)) + CDbl(grilla.TextMatrix(grilla.row, 4))
        End If
        If grilla.Col = 4 Then
            txt_Numero.Visible = False
            grilla.TextMatrix(grilla.row, 4) = txt_Numero.Text
            Dim i As Integer
            For i = 1 To Num_cupones
                    grilla.TextMatrix(grilla.row, 5) = Format(grilla.TextMatrix(grilla.row, 5), "0.0")
                    grilla.TextMatrix(grilla.row, 5) = CDbl(grilla.TextMatrix(grilla.row, 3)) + CDbl(grilla.TextMatrix(grilla.row, 4))
                    Amor_Aux = Amor_Aux + grilla.TextMatrix(i, 4)
                    grilla.TextMatrix(i, 6) = 100 - Amor_Aux
            Next
        End If
    End If
    If KeyAscii = 13 And txt_Numero.Text = 0 Then
            If grilla.Col = 3 Then
                txt_Numero.Visible = False
                grilla.TextMatrix(grilla.row, 3) = contenido
                txt_Numero.Text = 0
                contenido = ""
            End If
            If grilla.Col = 4 Then
                txt_Numero.Visible = False
                grilla.TextMatrix(grilla.row, 4) = contenido
                txt_Numero.Text = 0
                contenido = ""
            End If
    End If
    If KeyAscii = 27 Then
            If grilla.Col = 3 Then
                txt_Numero.Visible = False
                grilla.TextMatrix(grilla.row, 3) = contenido
                txt_Numero.Text = 0
                contenido = ""
            End If
            If grilla.Col = 4 Then
                txt_Numero.Visible = False
                grilla.TextMatrix(grilla.row, 4) = contenido
                txt_Numero.Text = 0
                contenido = ""
            End If
    End If
End Sub


Private Sub txt_fecha_LostFocus()
    txt_fecha.Text = "  /  /    "
    txt_fecha.Visible = False
End Sub

Private Sub txt_Numero_GotFocus()
'txt_Numero.SelStart = Len(txt_Numero.Text)
End Sub

Private Sub txt_Numero_KeyPress(KeyAscii As Integer)
    Dim Amor_Aux
    Amor_Aux = 0
    If KeyAscii = 13 Then
        grilla.SetFocus
        If grilla.Col = 3 Then
            txt_Numero.Visible = False
            grilla.TextMatrix(grilla.row, 3) = txt_Numero.Text
            grilla.TextMatrix(grilla.row, 5) = Format(grilla.TextMatrix(grilla.row, 5), "0.0000")
            grilla.TextMatrix(grilla.row, 5) = CDbl(grilla.TextMatrix(grilla.row, 3)) + CDbl(grilla.TextMatrix(grilla.row, 4))
        End If
        If grilla.Col = 4 Then
            txt_Numero.Visible = False
            grilla.TextMatrix(grilla.row, 4) = txt_Numero.Text
            Dim i As Integer
            For i = 1 To Num_cupones
                    grilla.TextMatrix(grilla.row, 5) = Format(grilla.TextMatrix(grilla.row, 5), "0.0")
                    grilla.TextMatrix(grilla.row, 5) = CDbl(grilla.TextMatrix(grilla.row, 3)) + CDbl(grilla.TextMatrix(grilla.row, 4))
                    Amor_Aux = Amor_Aux + grilla.TextMatrix(i, 4)
                    grilla.TextMatrix(i, 6) = 100 - Amor_Aux
            Next
        End If
        If grilla.Col = 7 Then
            txt_Numero.Visible = False
            grilla.TextMatrix(grilla.row, 7) = txt_Numero.Text
            'grilla.TextMatrix(grilla.Row, 5) = Format(grilla.TextMatrix(grilla.Row, 5), "0.0000")
            'grilla.TextMatrix(grilla.Row, 5) = CDbl(grilla.TextMatrix(grilla.Row, 3)) + CDbl(grilla.TextMatrix(grilla.Row, 4))
        End If
        
    End If
    If KeyAscii = 13 Then
            If grilla.Col = 3 Then
                txt_Numero.Visible = False
                'grilla.TextMatrix(grilla.Row, 3) = contenido
                txt_Numero.Text = 0
                contenido = 0
            End If
            If grilla.Col = 4 Then
                txt_Numero.Visible = False
'                grilla.TextMatrix(grilla.Row, 4) = contenido
                txt_Numero.Text = 0
                contenido = 0
            End If
            If grilla.Col = 7 Then
                txt_Numero.Visible = False
                'grilla.TextMatrix(grilla.Row, 3) = contenido
                txt_Numero.Text = 0
                contenido = 0
            End If
            
    End If
    If KeyAscii = 27 Then
            If grilla.Col = 3 Then
                txt_Numero.Visible = False
                grilla.TextMatrix(grilla.row, 3) = contenido
                txt_Numero.Text = 0
                contenido = 0
            End If
            If grilla.Col = 4 Then
                txt_Numero.Visible = False
                grilla.TextMatrix(grilla.row, 4) = contenido
                txt_Numero.Text = 0
                contenido = 0
            End If
            If grilla.Col = 7 Then
                txt_Numero.Visible = False
                grilla.TextMatrix(grilla.row, 7) = contenido
                txt_Numero.Text = 0
                contenido = 0
            End If
    
    End If
End Sub

Private Sub txt_Numero_LostFocus()
    txt_Numero.Text = 0
    txt_Numero.Visible = False
    Dim i
    i = i + 1
    For i = 1 To grilla.Rows - 1
        grilla.TextMatrix(i, 3) = Format(grilla.TextMatrix(i, 3), "0.000000")
        grilla.TextMatrix(i, 4) = Format(grilla.TextMatrix(i, 4), "0.000000")
        grilla.TextMatrix(i, 5) = Format(grilla.TextMatrix(i, 5), "0.000000")
        grilla.TextMatrix(i, 6) = Format(grilla.TextMatrix(i, 6), "0.000000")
    Next
End Sub


