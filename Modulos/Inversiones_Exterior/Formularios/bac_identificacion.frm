VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form Bac_Identificacion 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Identificación Del Operador"
   ClientHeight    =   2340
   ClientLeft      =   1605
   ClientTop       =   4650
   ClientWidth     =   6630
   ClipControls    =   0   'False
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2340
   ScaleWidth      =   6630
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.Frame Frame2 
      Caption         =   "Unidad"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00404040&
      Height          =   705
      Left            =   75
      TabIndex        =   5
      Top             =   1470
      Width           =   6465
      Begin VB.ComboBox box_unidad 
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
         Left            =   45
         Style           =   2  'Dropdown List
         TabIndex        =   2
         Top             =   225
         Width           =   5340
      End
      Begin VB.TextBox txt_unidad 
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
         Left            =   5475
         MaxLength       =   4
         TabIndex        =   3
         Top             =   225
         Width           =   765
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "Identificación Operador"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00404040&
      Height          =   720
      Left            =   75
      TabIndex        =   4
      Top             =   750
      Width           =   6480
      Begin VB.TextBox txt_nom_ope 
         BackColor       =   &H8000000E&
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
         Left            =   1410
         TabIndex        =   1
         Top             =   240
         Width           =   4875
      End
      Begin VB.Label Label1 
         Caption         =   "Nombre"
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
         Left            =   210
         TabIndex        =   6
         Top             =   285
         Width           =   1365
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   660
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   6630
      _ExtentX        =   11695
      _ExtentY        =   1164
      ButtonWidth     =   1032
      ButtonHeight    =   1005
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Aceptar"
            ImageIndex      =   13
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir Del Sistema"
            ImageIndex      =   12
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   11400
      Top             =   840
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
            Picture         =   "bac_identificacion.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_identificacion.frx":031A
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_identificacion.frx":076C
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_identificacion.frx":0BBE
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_identificacion.frx":0ED8
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_identificacion.frx":11F2
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_identificacion.frx":1644
            Key             =   ""
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_identificacion.frx":179E
            Key             =   ""
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_identificacion.frx":1BF0
            Key             =   ""
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_identificacion.frx":2042
            Key             =   ""
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_identificacion.frx":235C
            Key             =   ""
         EndProperty
         BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_identificacion.frx":2676
            Key             =   ""
         EndProperty
         BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_identificacion.frx":27D0
            Key             =   ""
         EndProperty
         BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_identificacion.frx":2C22
            Key             =   ""
         EndProperty
         BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_identificacion.frx":3074
            Key             =   ""
         EndProperty
         BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_identificacion.frx":338E
            Key             =   ""
         EndProperty
         BeginProperty ListImage17 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_identificacion.frx":36A8
            Key             =   ""
         EndProperty
         BeginProperty ListImage18 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_identificacion.frx":39C2
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "Bac_Identificacion"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim Aceptar
Private Sub box_unidad_Click()

    'si la posicion del combo es valida...
    If box_unidad.ListIndex <> -1 Then

        'muestro el codigo de unidad...
        txt_unidad.Text = Format(box_unidad.ItemData(box_unidad.ListIndex), "0000")
    End If
End Sub


Private Sub Form_Load()

    'asigno icono a la ventana...
    Me.Icon = BAC_INVERSIONES.Icon
    
    'lleno combo con las sucursales...
    Call Llena_Combo_Unidades

    'muestro el nombre del operador...
'   txt_nom_ope.Text = Bac_Usr_nom
    txt_nom_ope.Text = gsBac_User

    'busco el codigo de sucursal en el combo...
    For I = 0 To box_unidad.ListCount - 1

        'box_unidad.ListIndex = I
        'si el codigo de sucursal es igual al codigo sucursal del usuario ....
        If box_unidad.ItemData(I) = Bac_Usr_ofi Then
            
            'posiciono el combo...
            box_unidad.ListIndex = I

            'termino el ciclo
            Exit For
        End If

        'siempre tomo la posicion en blanco si no encuentra codigo sucursal del usuario...
        box_unidad.ListIndex = -1
    Next

    Aceptar = True
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
    
    'capturo la selecccion del usuario...
    Select Case Button.Index
        Case 1
            Bac_Usr_ofi = Val(txt_unidad.Text)
            Bac_Usr_nom = txt_nom_ope.Text
            If Aceptar = False Then
                MsgBox "Unidad No Existe", vbExclamation, gsBac_Version
                Exit Sub
            End If
            If Bac_Usr_nom = "" Then
                MsgBox "Ingrese Nombre Del Operador", vbCritical, gsBac_Version
                Exit Sub
            End If
            
'           MsgBox "Datos De La Unidad Asignados con Exito", vbInformation, Me.Caption
            Unload Me
        Case 2

            'si la marca de la ventana esta en salir...
            If Bac_Identificacion.Tag = "1" Then

                'cierro la ventana...
                Unload Me
            Else
            
                'termino la aplicacion...
                End
            End If
            
        End Select

End Sub
Function Llena_Combo_Unidades()

    'declaracion de variables locales...
    Dim datos()

    'limpio el combo...
    box_unidad.Clear

    'recupero las sucursales...
    If Bac_Sql_Execute("SVC_GEN_BUS_UNI") Then

        'recorro los datos devueltos por el sp...
        Do While Bac_SQL_Fetch(datos)

            'agrego registro al combo...
            box_unidad.AddItem datos(2)
            box_unidad.ItemData(box_unidad.NewIndex) = Val(datos(1))
        Loop
    End If
End Function

Private Sub txt_nom_ope_KeyPress(KeyAscii As Integer)
    KeyAscii = Asc(UCase(Chr(KeyAscii)))
    If KeyAscii = 13 Then
            Bac_Usr_ofi = Val(txt_unidad.Text)
            Bac_Usr_nom = txt_nom_ope.Text
            If Aceptar = False Then
                MsgBox "Unidad No Existe", vbExclamation, gsBac_Version
                Exit Sub
            End If
            If Bac_Usr_nom = "" Then
                MsgBox "Ingrese Nombre Del Operador", vbCritical, gsBac_Version
                Exit Sub
            End If
        Unload Me
    End If
End Sub


Private Sub txt_unidad_KeyPress(KeyAscii As Integer)
    
    'declaracion de variables locales...
    Dim k As Integer
    Dim I As Integer
    Dim sw As Boolean
    
    sw = False
    
    k = KeyAscii
    
    If (k > 47 And k < 58) Or k = 13 Or k = 8 Then
    
    If k = 13 Then
    
        For I = 0 To Me.box_unidad.ListCount - 1
        If IsNumeric(Me.txt_unidad.Text) Then
            If Me.box_unidad.ItemData(I) = Me.txt_unidad.Text Then
                Me.box_unidad.ListIndex = I
                Aceptar = True
                Exit For
            End If
        Else
                Me.box_unidad.ListIndex = -1
                Me.txt_unidad.Text = " "
       End If
        Aceptar = False
        Next I
        If Aceptar = False Then
            MsgBox "Unidad No Existe", vbExclamation, gsBac_Version
        End If
    End If
    
    Else
    
    k = 0
    Exit Sub
    
    End If

End Sub


