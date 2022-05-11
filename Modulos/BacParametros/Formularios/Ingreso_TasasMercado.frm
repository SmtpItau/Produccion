VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{316A9483-A459-11D4-9073-005004A524B9}#1.0#0"; "BacControles.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Begin VB.Form Ingreso_TasasMercado 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Ingreso Tasas"
   ClientHeight    =   2145
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   4635
   ClipControls    =   0   'False
   Icon            =   "Ingreso_TasasMercado.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2145
   ScaleWidth      =   4635
   StartUpPosition =   2  'CenterScreen
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   6
      Top             =   0
      Width           =   4635
      _ExtentX        =   8176
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Suprimir"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   4
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   2760
      Top             =   3075
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   4
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Ingreso_TasasMercado.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Ingreso_TasasMercado.frx":075C
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Ingreso_TasasMercado.frx":0BAE
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Ingreso_TasasMercado.frx":0EC8
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin Threed.SSFrame frame1 
      Height          =   1515
      Left            =   30
      TabIndex        =   7
      Top             =   600
      Width           =   4575
      _Version        =   65536
      _ExtentX        =   8070
      _ExtentY        =   2672
      _StockProps     =   14
      Caption         =   "Valores"
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin VB.TextBox TxtDias 
         Alignment       =   1  'Right Justify
         Height          =   315
         Left            =   780
         MaxLength       =   5
         TabIndex        =   1
         Text            =   "0"
         Top             =   300
         Width           =   1215
      End
      Begin VB.TextBox TxtOri 
         Alignment       =   1  'Right Justify
         Height          =   315
         Left            =   3780
         MaxLength       =   3
         TabIndex        =   2
         Text            =   "0"
         Top             =   300
         Width           =   585
      End
      Begin VB.TextBox TxtConv 
         Alignment       =   1  'Right Justify
         Height          =   315
         Left            =   3780
         MaxLength       =   3
         TabIndex        =   4
         Text            =   "0"
         Top             =   660
         Width           =   585
      End
      Begin BacControles.txtNumero NumOffer 
         Height          =   255
         Left            =   780
         TabIndex        =   5
         Top             =   1020
         Width           =   1215
         _ExtentX        =   2143
         _ExtentY        =   450
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         SelStart        =   3
         Text            =   "0.000000"
         CantidadDecimales=   "6"
      End
      Begin BacControles.txtNumero Numbid 
         Height          =   255
         Left            =   780
         TabIndex        =   3
         Top             =   660
         Width           =   1215
         _ExtentX        =   2143
         _ExtentY        =   450
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         SelStart        =   3
         Text            =   "0.000000"
         CantidadDecimales=   "6"
         Max             =   "999999.999999"
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Días"
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
         Left            =   225
         TabIndex        =   12
         Top             =   345
         Width           =   420
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "Bid"
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
         Left            =   225
         TabIndex        =   11
         Top             =   705
         Width           =   285
      End
      Begin VB.Label Label3 
         AutoSize        =   -1  'True
         Caption         =   "Offer"
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
         Left            =   180
         TabIndex        =   10
         Top             =   1065
         Width           =   435
      End
      Begin VB.Label Label5 
         AutoSize        =   -1  'True
         Caption         =   "Base Original"
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
         Left            =   2190
         TabIndex        =   9
         Top             =   345
         Width           =   1140
      End
      Begin VB.Label Label6 
         AutoSize        =   -1  'True
         Caption         =   "Base Conversión"
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
         Left            =   2190
         TabIndex        =   8
         Top             =   705
         Width           =   1440
      End
   End
   Begin VB.PictureBox StatusBar1 
      Align           =   2  'Align Bottom
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   300
      Left            =   0
      ScaleHeight     =   240
      ScaleWidth      =   4575
      TabIndex        =   0
      Top             =   1845
      Width           =   4635
   End
End
Attribute VB_Name = "Ingreso_TasasMercado"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim objTasa As New clsTasaMercado

Dim gDias_Antes&
Dim gDias_Despues&

Private Sub Form_Activate()

    BacControlWindows 12
      
    Screen.MousePointer = 0
       
    Select Case Trim$(Me.Tag)
        
        Case "INSERTA"
              
              
              Toolbar1.Buttons(1).Enabled = True   '- grabar
              Toolbar1.Buttons(2).Enabled = False  '- Eliminar
              Toolbar1.Buttons(3).Enabled = True   '- Limpiar
              Toolbar1.Buttons(4).Enabled = True   '- Salir
              
              Me.Caption = " Inserta Tasas "
                
              TxtDias = Val(objTasa.Dias)
              Numbid.Text = objTasa.Bid
              NumOffer.Text = objTasa.Offer
              TxtOri = Val(objTasa.BaseOri)
              TxtConv = Val(objTasa.BaseConv)
              
              TxtDias.SetFocus
                                
              
        Case "ACTUALIZAR"
        
    '/*/*/*/*/* no necesito dias_antes ni dias_despues */*/*/*/
        
              Toolbar1.Buttons(1).Enabled = True
              Toolbar1.Buttons(2).Enabled = True
              Toolbar1.Buttons(3).Enabled = True
              Toolbar1.Buttons(4).Enabled = True
              
              TxtDias.Enabled = False
              
              Me.Caption = " Actualiza Tasas "
              
              TxtDias = Val(objTasa.Dias)
              Numbid.Text = objTasa.Bid
              NumOffer.Text = objTasa.Offer
              TxtOri = Val(objTasa.BaseOri)
              TxtConv = Val(objTasa.BaseConv)
              If Me.Visible Then
                If TxtDias.Enabled Then
                    TxtDias.SetFocus
                  Else
                    Numbid.SetFocus
                End If
              End If
              
    
   End Select
               ' TxtDias.SetFocus
                SendKeys "{right}"
    
End Sub

Private Sub Form_Load()

    objTasa.CodMoneda = BacMntTasasMercado.objTasa.CodMoneda
    objTasa.CodTasa = BacMntTasasMercado.objTasa.CodTasa
    objTasa.Dias = BacMntTasasMercado.objTasa.Dias
    objTasa.Bid = BacMntTasasMercado.objTasa.Bid
    objTasa.Offer = BacMntTasasMercado.objTasa.Offer
    objTasa.Tasa = BacMntTasasMercado.objTasa.Tasa
    objTasa.BaseOri = BacMntTasasMercado.objTasa.BaseOri
    objTasa.BaseConv = BacMntTasasMercado.objTasa.BaseConv
    objTasa.TasaFinal = BacMntTasasMercado.objTasa.TasaFinal
    objTasa.TasaZcr = BacMntTasasMercado.objTasa.TasaZcr
    gDias_Antes = BacMntTasasMercado.gDias_Antes
    gDias_Despues = BacMntTasasMercado.gDias_Despues

End Sub


Private Sub NumBid_GotFocus()
    If Val(Numbid.Text) = 0 Then
        Numbid.Text = ""
    End If
End Sub

Private Sub NumBid_KeyPress(KeyAscii As Integer)

    'PROC_FMT_NUMERICO Numbid, 3, 6, KeyAscii, "", gsc_PuntoDecim

    If KeyAscii = 13 Then
        KeyAscii = 0
        SendKeys "{TAB}"
    End If
     
End Sub

Private Sub NumBid_LostFocus()
    Numbid.Text = CDbl(Numbid.Text)
End Sub


Private Sub NumOffer_GotFocus()
    If Val(NumOffer.Text) = 0 Then
        NumOffer.Text = ""
    End If
End Sub

Private Sub NumOffer_KeyPress(KeyAscii As Integer)

    'PROC_FMT_NUMERICO NumOffer, 3, 6, KeyAscii, "", gsc_PuntoDecim

    If KeyAscii = 13 Then
        KeyAscii = 0
        SendKeys "{TAB}"
    End If

End Sub

Private Sub NumOffer_LostFocus()
    NumOffer.Text = CDbl(NumOffer.Text)
End Sub


Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
  Screen.MousePointer = 11

  Select Case Button.Index
    
    Case 1       'Grabar
             
        If Not VALID_GRABA Then
            Screen.MousePointer = 0
            Exit Sub
        End If
          
        objTasa.Dias = Val(TxtDias.Text)
        objTasa.Bid = Numbid.Text
        objTasa.Offer = NumOffer.Text
        objTasa.Tasa = (objTasa.Bid + objTasa.Offer) / 2
        objTasa.BaseOri = Val(TxtOri.Text)
        objTasa.BaseConv = Val(TxtConv.Text)
        objTasa.fecha = gsbac_fecp
                  
        If objTasa.grabar = True Then
            Screen.MousePointer = 0
            MsgBox "Grabación fue Exitosa", 64, Msj
            Unload Me
            Exit Sub
        End If
            'GrabarTasas(Sistema, objTasa.CodMoneda, objTasa.CodTasa) Then PENDIENTE borrar funcion
 
    Case 2       'Eliminar
    Dim aa
    aa = MsgBox("Seguro de Eliminar", vbQuestion + vbYesNo)
    If aa = 6 Then
        If Not VALID_ELIMINA Then
            Screen.MousePointer = 0
            Exit Sub
        End If
        
        If objTasa.Eliminar(objTasa.CodMoneda, objTasa.CodTasa, Val(TxtDias.Text)) Then
            Screen.MousePointer = 0
            Unload Me
            Exit Sub
        End If
    End If
    Case 3      'Limpiar
    
        Numbid.Text = 0
        NumOffer.Text = 0
        TxtOri = "360"
        TxtConv = "360"
        TxtOri.SetFocus
        SendKeys "{right}"
        
        If Trim$(Me.Tag) = "INSERTA" Then
            Toolbar1.Buttons(1).Enabled = False        'GRABA
            TxtDias.Text = "0"
            TxtDias.SetFocus
        End If
             
    Case 4          ' Salir
        Screen.MousePointer = 0
        Unload Me
        Exit Sub
End Select

    Screen.MousePointer = 0

End Sub



Private Sub TxtConv_GotFocus()

    If Me.Tag = "ACTUALIZAR" Then
 
         TxtConv.SelStart = 0
         TxtConv.SelLength = Len(TxtConv.Text)
 
    End If



End Sub

Private Sub TxtConv_KeyPress(KeyAscii As Integer)

  BacSoloNumeros KeyAscii
 
  If KeyAscii = 13 And Trim$(TxtConv.Text) <> "" Then
       KeyAscii = 0
       SendKeys "{TAB}"
   End If

End Sub

Private Sub TxtDias_GotFocus()

    If Me.Tag = "ACTUALIZAR" Then
        TxtDias.SelStart = 0
        TxtDias.SelLength = Len(TxtDias.Text)
    End If

End Sub

Private Sub TxtDias_KeyPress(KeyAscii As Integer)

  BacSoloNumeros KeyAscii
  
   If KeyAscii = 13 And Val(TxtDias.Text) = 0 Then
      MsgBox "ERROR : Periodo No puede ser Igual a cero ", 16, gsPARAMS_Version
      TxtDias.SetFocus
  End If
  
    If KeyAscii = 13 And Val(TxtDias.Text) > 0 Then
          
        If Trim$(Me.Tag) = "INSERTA" Then
                  
            If Val(TxtDias.Text) > Val(gDias_Antes) And Val(TxtDias.Text) < Val(gDias_Despues) Then
                 KeyAscii = 0
                 SendKeys "{TAB}"
                 Toolbar1.Buttons(1).Enabled = True
             Else
                 Toolbar1.Buttons(1).Enabled = False
                 If Not (Val(TxtDias.Text) > Val(gDias_Antes)) Then MsgBox " ERROR : Periodo debe ser Mayor al Anterior ", 16, gsPARAMS_Version
                 If Not (Val(TxtDias.Text) < Val(gDias_Despues)) Then MsgBox " ERROR : Periodo debe ser Menor al Posterior ", 16, gsPARAMS_Version
                 TxtDias.SetFocus
                 Exit Sub
            End If
              
        End If
    
    End If
    
        
End Sub

Private Sub TxtDias_LostFocus()
    TxtDias.Text = Val(TxtDias.Text)
End Sub

Private Sub TxtOri_GotFocus()

    If Me.Tag = "ACTUALIZAR" Then
        TxtOri.SelStart = 0
        TxtOri.SelLength = Len(TxtOri.Text)
    End If
 
End Sub

Private Sub TxtOri_KeyPress(KeyAscii As Integer)

  BacSoloNumeros KeyAscii
  
  If KeyAscii = 13 And Trim$(TxtOri.Text) <> "" Then
       KeyAscii = 0
       SendKeys "{TAB}"
   End If
   
End Sub

Public Function VALID_GRABA() As Boolean
              
VALID_GRABA = True
              
             If Val(TxtDias.Text) = 0 Then
                 VALID_GRABA = False
                MsgBox "ERROR : Periodo No puede ser Igual a cero ", 16, gsPARAMS_Version
                TxtDias.SetFocus
                Exit Function
            End If
           
                    
    If Trim$(Me.Tag) = "INSERTA" Then
              
      If Not (Val(TxtDias.Text) > Val(gDias_Antes) And Val(TxtDias.Text) < Val(gDias_Despues)) Then
                 MsgBox "ERROR : Periodo malo ", 16, gsPARAMS_Version
                 VALID_GRABA = False
                 'TxtDias.Text = ""
                 TxtDias.SetFocus
                 Exit Function
      End If
          
           If Trim$(TxtDias.Text) = "" Then
              VALID_GRABA = False
              MsgBox "ERROR : Dias debe tener valor Numerico", 16, gsPARAMS_Version
              TxtDias.SetFocus
              Exit Function
          End If
              
    End If
                       
          If Val(TxtOri.Text) <= 0 Then
              VALID_GRABA = False
              MsgBox "ERROR : Base Ori. ,Debe ser Mayor a Cero ", 16, gsPARAMS_Version
              TxtOri.SetFocus
              Exit Function
          End If
          
          
          If Val(TxtConv.Text) <= 0 Then
             VALID_GRABA = False
             MsgBox "ERROR : Base Conv. ,Debe ser Mayor a Cero ", 16, gsPARAMS_Version
             TxtConv.SetFocus
             Exit Function
          End If

End Function
Public Function VALID_ELIMINA()
Dim a&

    VALID_ELIMINA = False

    If Trim$(TxtDias.Text) <> "" Then VALID_ELIMINA = True

With BacMntTasasMercado.grilla

    For a = 1 To .Rows - 1
    
        .Row = a
        
        If Val(.TextMatrix(.Row, 1)) = Val(TxtDias) Then
            VALID_ELIMINA = True
            Exit Function
        End If
        
    Next a
    
End With
    
End Function
