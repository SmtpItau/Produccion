VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form FRM_BLOQUEO_FILTRO 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Filtro Bloqueo Pacto"
   ClientHeight    =   4275
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   7410
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4275
   ScaleWidth      =   7410
   StartUpPosition =   3  'Windows Default
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   5310
      Top             =   75
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   2
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_BLOQUEO_FILTRO.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_BLOQUEO_FILTRO.frx":0EDA
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   7410
      _ExtentX        =   13070
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin MSComctlLib.ListView LstCartFin 
      Height          =   3765
      Left            =   3720
      TabIndex        =   1
      Top             =   525
      Width           =   3660
      _ExtentX        =   6456
      _ExtentY        =   6641
      View            =   3
      MultiSelect     =   -1  'True
      LabelWrap       =   0   'False
      HideSelection   =   -1  'True
      Checkboxes      =   -1  'True
      FullRowSelect   =   -1  'True
      HotTracking     =   -1  'True
      _Version        =   393217
      ForeColor       =   -2147483640
      BackColor       =   -2147483643
      BorderStyle     =   1
      Appearance      =   1
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      NumItems        =   0
   End
   Begin MSComctlLib.ListView LstCartNor 
      Height          =   3765
      Left            =   15
      TabIndex        =   2
      Top             =   510
      Width           =   3705
      _ExtentX        =   6535
      _ExtentY        =   6641
      View            =   3
      MultiSelect     =   -1  'True
      LabelWrap       =   0   'False
      HideSelection   =   -1  'True
      Checkboxes      =   -1  'True
      FullRowSelect   =   -1  'True
      HotTracking     =   -1  'True
      _Version        =   393217
      ForeColor       =   -2147483640
      BackColor       =   -2147483643
      BorderStyle     =   1
      Appearance      =   1
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      NumItems        =   0
   End
End
Attribute VB_Name = "FRM_BLOQUEO_FILTRO"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Const Descripcion = 1
Const Codigo = 2
Private Sub Nombres(ByRef xListado As ListView, ByVal cCaption As String)
   xListado.ColumnHeaders.Clear
   xListado.ColumnHeaders.Add Descripcion, "A", cCaption, 3580
   xListado.ColumnHeaders.Add Codigo, "B", "N° CODIGO", 1
End Sub
Private Function CargaCatera(ByVal iCodigo As Integer, ByRef xListado As ListView) As Boolean
   Dim DATOS()

   Let CargaCatera = False

   Envia = Array()
   AddParam Envia, iCodigo
   If Not Bac_Sql_Execute("SP_LEE_CARTERAS", Envia) Then
      Call MsgBox("Se ha originado un error en la consulta SQL.", vbExclamation, App.Title)
      Exit Function
   End If
   xListado.ListItems.Clear
   Do While Bac_SQL_Fetch(DATOS())
      xListado.ListItems.Add , , DATOS(2)
      xListado.ListItems.Item(xListado.ListItems.Count).ListSubItems.Add , , DATOS(1)
   Loop

   Let CargaCatera = True
End Function
Private Function BuscarCarteras()
   Dim nContador As Long
   
   Let FRM_BLOQUEO_PACTO.CarterasFinancieras = ""
      
   For nContador = 1 To LstCartFin.ListItems.Count
      If LstCartFin.ListItems.Item(nContador).Checked = True Then
         Let FRM_BLOQUEO_PACTO.CarterasFinancieras = FRM_BLOQUEO_PACTO.CarterasFinancieras & "-" & LstCartFin.ListItems(nContador).ListSubItems(1).Text
      End If
   Next nContador
  
   Let FRM_BLOQUEO_PACTO.CarterasNormativas = ""
   For nContador = 1 To LstCartNor.ListItems.Count
      If LstCartNor.ListItems.Item(nContador).Checked = True Then
         Let FRM_BLOQUEO_PACTO.CarterasNormativas = FRM_BLOQUEO_PACTO.CarterasNormativas & "-" & LstCartNor.ListItems(nContador).ListSubItems(1).Text
      End If
   Next nContador

End Function
Private Sub Form_Load()
   Let Me.Icon = BacTrader.Icon
   
   Call Nombres(LstCartNor, "CARTERA NORMATIVA")
   Call Nombres(LstCartFin, "CARTERA FINANCIERA")
   Let FRM_BLOQUEO_PACTO.iAceptar = False
   Call CargaCatera(GLB_CARTERA_NORMATIVA, LstCartNor)
   Call CargaCatera(GLB_CARTERA, LstCartFin)
   
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
     Let FRM_BLOQUEO_PACTO.iAceptar = False

   Select Case Button.Index
      Case 1
         Call BuscarCarteras
         
         If Len(FRM_BLOQUEO_PACTO.CarterasFinancieras) = 0 Or Len(FRM_BLOQUEO_PACTO.CarterasNormativas) = 0 Then
         
            'Call MsgBox("Debe seleccionar al menos un registro por cartera Financiera y Nomativa.", vbExclamation, App.Title)
           ' Let BACFLI.iAceptar = True
           '' Exit Sub
         End If

         Let FRM_BLOQUEO_PACTO.iAceptar = True
         Call Unload(Me)
      Case 2
         Call Unload(Me)
   End Select
End Sub


