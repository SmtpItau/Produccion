VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form BacAyudaAnular 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Operaciones"
   ClientHeight    =   4260
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   7170
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4260
   ScaleWidth      =   7170
   StartUpPosition =   3  'Windows Default
   Begin MSFlexGridLib.MSFlexGrid MSFlexGrid1 
      Height          =   3705
      Left            =   30
      TabIndex        =   1
      Top             =   540
      Width           =   7095
      _ExtentX        =   12515
      _ExtentY        =   6535
      _Version        =   393216
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Height          =   510
      Left            =   30
      TabIndex        =   0
      Top             =   0
      Width           =   7080
      _ExtentX        =   12488
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmbaceptar"
            Description     =   "ACEPTAR"
            Object.ToolTipText     =   "Aceptar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmbcancelar"
            Description     =   "CANCELAR"
            Object.ToolTipText     =   "Cancelar"
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   1740
      Top             =   630
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
            Picture         =   "BacAyudaAnular.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacAyudaAnular.frx":0452
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "BacAyudaAnular"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub Form_Load()

    Call dibuja_grilla
    

End Sub
Sub dibuja_grilla()

    grilla.Rows = grilla.FixedRows
    grilla.Cols = 10
    grilla.TextMatrix(0, 0) = "Tipo"
    grilla.TextMatrix(0, 1) = "Operación"
    grilla.TextMatrix(0, 2) = "Instrumento"
    grilla.TextMatrix(0, 3) = "Vcto"
    grilla.TextMatrix(0, 4) = "Nominal"
    grilla.TextMatrix(0, 5) = "TIR"
    grilla.TextMatrix(0, 6) = "Moneda"
    grilla.TextMatrix(0, 7) = "Cliente"
    grilla.TextMatrix(0, 8) = ""
    grilla.TextMatrix(0, 9) = ""
    grilla.ColWidth(0) = 1000
    grilla.ColWidth(1) = 2000
    grilla.ColWidth(2) = 1200
    grilla.ColWidth(3) = 2500
    grilla.ColWidth(4) = 1100
    grilla.ColWidth(5) = 1200
    grilla.ColWidth(6) = 2500
    grilla.ColWidth(7) = 1500:    grilla.ColWidth(8) = 2000:    grilla.ColWidth(9) = 0
        
End Sub

Sub BuscaOperaciones()
    
    Dim Sql
    Dim Datos
    Dim i
    
    
    
    grilla.TextMatrix(i, 0) = Datos(11)
    grilla.TextMatrix(i, 1) = Datos(14)
    grilla.TextMatrix(i, 2) = Datos(1)
    grilla.TextMatrix(i, 3) = Format(Datos(2), "DD/MM/YYYY")
    grilla.TextMatrix(i, 4) = Format(CDbl(Datos(3)), "##,###,###,###,##0.0000")
    grilla.TextMatrix(i, 5) = Format(CDbl(Datos(4)), "#0.0000")
    grilla.TextMatrix(i, 6) = Datos(10)
    grilla.TextMatrix(i, 7) = Datos(5)
    'grilla.TextMatrix(i, 8) =
    'grilla.TextMatrix(0, 9) =
                
    

End Sub
