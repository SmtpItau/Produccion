VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form FRM_FILTRO_CARTERA 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Filtro Cartera disponible"
   ClientHeight    =   4365
   ClientLeft      =   2805
   ClientTop       =   5415
   ClientWidth     =   7530
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4365
   ScaleWidth      =   7530
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
            Picture         =   "FRM_FILTRO_CARTERA.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_FILTRO_CARTERA.frx":0EDA
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
      Width           =   7530
      _ExtentX        =   13282
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
   Begin VB.Frame Frame1 
      Height          =   3900
      Left            =   30
      TabIndex        =   1
      Top             =   435
      Width           =   7485
      Begin MSComctlLib.ListView LstCartFin 
         Height          =   3735
         Left            =   30
         TabIndex        =   2
         Top             =   120
         Width           =   3645
         _ExtentX        =   6429
         _ExtentY        =   6588
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
         Height          =   3735
         Left            =   3705
         TabIndex        =   3
         Top             =   120
         Width           =   3705
         _ExtentX        =   6535
         _ExtentY        =   6588
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
End
Attribute VB_Name = "FRM_FILTRO_CARTERA"
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


Private Sub Form_Load()
   
   Call Nombres(LstCartFin, "CARTERA NORMATIVA")
   Call Nombres(LstCartNor, "CARTERA FINANCIERA")
   
   
   Call CargaCatera(1111, LstCartFin)
   Call CargaCatera(204, LstCartNor)
End Sub

Private Function CargaCatera(ByVal iCodigo As Integer, ByRef xListado As ListView) As Boolean
   Dim Datos()

   Let CargaCatera = False

   Envia = Array()
   AddParam Envia, iCodigo
   If Not Bac_Sql_Execute("bactradersuda.dbo.SP_LEE_CARTERAS", Envia) Then
      Call MsgBox("Se ha originado un error en la consulta SQL.", vbExclamation, App.Title)
      Exit Function
   End If
   
   xListado.ListItems.Clear
   Do While Bac_SQL_Fetch(Datos())
      xListado.ListItems.Add , , Datos(2)
      xListado.ListItems.Item(xListado.ListItems.Count).ListSubItems.Add , , Datos(1)
   Loop

   Let CargaCatera = True
End Function

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   

   Select Case Button.Index
      Case 1
         Call BuscarCarteras
         
         
         Call Unload(Me)
      Case 2
         Call Unload(Me)
   End Select

End Sub


Private Function BuscarCarteras()
   Dim nContador As Long
   
    Dim origen As Integer
    If Me.Tag = "FRM_MNT_GARANTIAS_OTORGADAS" Then
       Let FRM_MNT_GARANTIAS_OTORGADAS.CarterasFinancieras = ""
      
         For nContador = 1 To LstCartFin.ListItems.Count
            If LstCartFin.ListItems.Item(nContador).Checked = True Then
               Let FRM_MNT_GARANTIAS_OTORGADAS.CarterasFinancieras = FRM_MNT_GARANTIAS_OTORGADAS.CarterasFinancieras & "-" & LstCartFin.ListItems(nContador).ListSubItems(1).Text
            End If
         Next nContador
        
         Let FRM_MNT_GARANTIAS_OTORGADAS.CarterasNormativas = ""
         
         For nContador = 1 To LstCartNor.ListItems.Count
            If LstCartNor.ListItems.Item(nContador).Checked = True Then
               Let FRM_MNT_GARANTIAS_OTORGADAS.CarterasNormativas = FRM_MNT_GARANTIAS_OTORGADAS.CarterasNormativas & "-" & LstCartNor.ListItems(nContador).ListSubItems(1).Text
            End If
         Next nContador

    
    ElseIf Me.Tag = "FRM_INTERCAMBIA_GTIASO" Then
         For nContador = 1 To LstCartFin.ListItems.Count
            If LstCartFin.ListItems.Item(nContador).Checked = True Then
               Let FRM_INTERCAMBIA_GTIASO.CarterasFinancieras = FRM_INTERCAMBIA_GTIASO.CarterasFinancieras & "-" & LstCartFin.ListItems(nContador).ListSubItems(1).Text
            End If
         Next nContador
        
         Let FRM_INTERCAMBIA_GTIASO.CarterasNormativas = ""
         
         For nContador = 1 To LstCartNor.ListItems.Count
            If LstCartNor.ListItems.Item(nContador).Checked = True Then
               Let FRM_INTERCAMBIA_GTIASO.CarterasNormativas = FRM_INTERCAMBIA_GTIASO.CarterasNormativas & "-" & LstCartNor.ListItems(nContador).ListSubItems(1).Text
            End If
         Next nContador
    
    End If
   
   

End Function
