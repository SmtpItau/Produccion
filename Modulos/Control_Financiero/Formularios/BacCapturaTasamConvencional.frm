VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "threed32.ocx"
Begin VB.Form BacCapturaMaxConvencional 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Captura de Interfaz Tasa Maxima Convencional"
   ClientHeight    =   7080
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   8835
   Icon            =   "BacCapturaTasamConvencional.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   7080
   ScaleWidth      =   8835
   Begin Threed.SSFrame SSFrame2 
      Height          =   5850
      Left            =   30
      TabIndex        =   0
      Top             =   480
      Width           =   8745
      _Version        =   65536
      _ExtentX        =   15425
      _ExtentY        =   10319
      _StockProps     =   14
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin VB.ListBox lstProceso 
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000002&
         Height          =   5520
         Left            =   90
         TabIndex        =   1
         Top             =   180
         Width           =   8595
      End
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   6480
      Top             =   90
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
            Picture         =   "BacCapturaTasamConvencional.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacCapturaTasamConvencional.frx":0624
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   2
      Top             =   0
      Width           =   8835
      _ExtentX        =   15584
      _ExtentY        =   794
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Procesar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   1
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
End
Attribute VB_Name = "BacCapturaMaxConvencional"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim asXFecha      As String
Dim Xcantidad   As Double
Dim ASfECHA     As String

Function Valida_Captura_maxima_convencional() As Boolean

Dim cNomArchivo As String
Dim cruta       As String
Dim sret        As String
Dim sFecha      As String
Dim cSection$
Dim i           As Integer
Dim Datos()
On Error GoTo Error_Captura

Valida_Captura_maxima_convencional = False
   
   lstProceso.Clear
   Envia = Array()
   AddParam Envia, 9
   If Not Bac_Sql_Execute("BacParamSuda..sp_BacInterfaces_Archivo_Bcf ", Envia) Then
      Call Func_Mensaje("Problemas al leer la ruta de interfaz de Tasa Maxima Convencional")
      Exit Function
   End If
   If Bac_SQL_Fetch(Datos()) Then
      cNomArchivo = Datos(2)
      cruta = Datos(4)
   End If
   
   cNomArchivo = cruta + cNomArchivo
   i = 0
   
   Open cNomArchivo For Input As #1
   Do While Not EOF(1)
       i = i + 1
       Line Input #1, sret
            asXFecha = Mid(sret, 1, 9)
            asXFecha = Mid(asXFecha, 1, 2) & "/" & Mid(asXFecha, 3, 3) & "/" & Mid(asXFecha, 6, 4)
            asXFecha = Replace(asXFecha, "JAN", "01")
            asXFecha = Replace(asXFecha, "FEB", "02")
            asXFecha = Replace(asXFecha, "MAR", "03")
            asXFecha = Replace(asXFecha, "APR", "04")
            asXFecha = Replace(asXFecha, "MAY", "05")
            asXFecha = Replace(asXFecha, "JUN", "06")
            asXFecha = Replace(asXFecha, "JUL", "07")
            asXFecha = Replace(asXFecha, "AUG", "08")
            asXFecha = Replace(asXFecha, "SEP", "09")
            asXFecha = Replace(asXFecha, "OCT", "10")
            asXFecha = Replace(asXFecha, "NOV", "11")
            asXFecha = Replace(asXFecha, "DEC", "12")
            
            ASfECHA = asXFecha
            Xcantidad = CDbl(Mid(sret, 10, 5))
            'sFecha = FechaSistema
   Loop
   
Close #1

Valida_Captura_maxima_convencional = True
Exit Function
Error_Captura:
Close #1
Call Func_Mensaje(Err.Description)

Valida_Captura_maxima_convencional = False
End Function

Function Captura_maxima_convencional() As Boolean

Dim cNomArchivo As String
Dim cruta       As String
Dim sret        As String
Dim sFecha      As String
Dim cSection$
Dim i           As Integer
Dim Mensaje As String
Dim Datos()
On Error GoTo Error_Captura

Captura_maxima_convencional = False
   
   lstProceso.Clear
   Envia = Array()
   AddParam Envia, 5
   If Not Bac_Sql_Execute("BacParamSuda..sp_BacInterfaces_Archivo_Bcf ", Envia) Then
      Call Func_Mensaje("Problemas al leer la ruta de interfaz de Tasa Maxima Convencional")
      Exit Function
   End If
   If Bac_SQL_Fetch(Datos()) Then
      cNomArchivo = Datos(2)
      cruta = Datos(4)
   End If
   
   cNomArchivo = cruta + cNomArchivo
        '******************************************************************
        '******************************************************************
        '******************************************************************
        i = 0
        Open cNomArchivo For Input As #1
        Do While Not EOF(1)
            i = i + 1
            Line Input #1, sret
        Loop
        Close #1
        Mensaje = " La fecha enviada por AS/400 es: " & ASfECHA & "," & " la fecha de proceso BAC es: " & FechaSistema & "." & Chr(13) & Chr(13)
        Mensaje = Mensaje & " La cantidad de registros informados en archivo de cabecera son: " & CStr(Xcantidad) & ".  " & Chr(13)
        Mensaje = Mensaje & " La cantidad de registros informados en archivo de detalle son: " & i & Chr(13) & Chr(13)
        Mensaje = Mensaje & " ¿Desea continuar con la captura de los datos.? "
   
        If (MsgBox(Mensaje, vbYesNo + vbQuestion, Me.Caption)) = 6 Then
            Call Func_Mensaje(" ")
            Call Func_Mensaje("Carga aceptada, se continuará con la grabación")
        Else
            Call Func_Mensaje(" ")
            Call Func_Mensaje("Carga rechazada, No se grabaran registos")
            Exit Function
        End If
        '******************************************************************
        '******************************************************************
        '******************************************************************
   
        
        
        If Not Bac_Sql_Execute("BacParamSuda..sp_limpia_tasam_convencional ") Then
            Call Func_Mensaje(" ")
            Call Func_Mensaje("Problemas al limpiar tabla de tasa maxima convencional ")
        
        End If
   
   i = 0
   Open cNomArchivo For Input As #1
   Do While Not EOF(1)
       i = i + 1
       Line Input #1, sret
       
        Envia = Array()
        AddParam Envia, Trim(Mid(sret, 1, 4))
        AddParam Envia, Mid(sret, 5, 6)
        AddParam Envia, Mid(sret, 11, 6)
        AddParam Envia, CDbl(Format((CDbl(Mid(sret, 17, 15)) / 100), "0.00"))
        AddParam Envia, CDbl(Format((CDbl(Mid(sret, 32, 15)) / 100), "0.00"))
        AddParam Envia, CDbl(Format((CDbl(Mid(sret, 47, 15)) / 100000), "0.00000"))
        If Not Bac_Sql_Execute("BacParamSuda..sp_carga_tasam_convencional ", Envia) Then
        
            Call Func_Mensaje(" ")
            Call Func_Mensaje("Problemas al grabar los datos de la fila numero: " & i)
            Call Func_Mensaje("==> Moneda           : " & Trim(Mid(sret, 1, 4)))
            Call Func_Mensaje("==> Plazo Inicial    : " & Format(Mid(sret, 5, 6), "#,##0"))
            Call Func_Mensaje("==> Plazo Final      : " & Format(Mid(sret, 11, 6), "#,##0"))
            Call Func_Mensaje("==> Monto Minimo Uf  : " & Format((CDbl(Mid(sret, 17, 15)) / 100), "#,##0.00"))
            Call Func_Mensaje("==> Monto Maximo Uf  : " & Format((CDbl(Mid(sret, 32, 15)) / 100), "#,##0.00"))
            Call Func_Mensaje("==> Tasa %           : " & Format((CDbl(Mid(sret, 47, 15)) / 100000), "#,##0.0000"))
            
        End If
   Loop
   
Close #1

Captura_maxima_convencional = True
Exit Function
Error_Captura:
Close #1
Call Func_Mensaje(Err.Description)

Captura_maxima_convencional = False
End Function

Private Function Func_Mensaje(sMensaje)

   lstProceso.AddItem sMensaje
   lstProceso.ListIndex = lstProceso.ListCount - 1
   lstProceso.Refresh

End Function

Private Sub Form_Load()
Me.top = 0
Me.Left = 0

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

   Select Case Button.Index()
   Case 1
        Screen.MousePointer = 11

        If Not Valida_Captura_maxima_convencional Then
                 Screen.MousePointer = 0
                Exit Sub
        End If

        If Captura_maxima_convencional Then
             Call Func_Mensaje(" ")
             Call Func_Mensaje("** Proceso de Captura de Interfaz Tasa Maxima Convecional Terminado **")
        Else
             Call Func_Mensaje(" ")
             Call Func_Mensaje("** Proceso de Captura de Interfaz Tasa Maxima Convecional Terminado **")
        End If
         Screen.MousePointer = 0

   Case 2
      Unload Me

   End Select

End Sub
