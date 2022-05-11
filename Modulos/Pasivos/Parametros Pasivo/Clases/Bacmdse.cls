VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsSerie"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Public secodigo   As Integer  'NUMERIC (03,0) ,
Public semascara  As String   'CHAR    (12)   ,
Public seserie    As String   'CHAR    (12)   ,
Public serutemi   As Long     'NUMERIC (09)   ,
Public sefecemi   As String   'DATETIME       ,
Public sefecven   As String   'DATETIME       ,
Public setasemi   As Currency 'NUMERIC (09,4) ,
Public setera     As Currency 'NUMERIC (09,4) ,
Public sebasemi   As Integer  'NUMERIC (03,0) ,
Public semonemi   As Integer  'NUMERIC (03,0) ,
Public secupones  As Integer  'NUMERIC (03,0) ,
Public sediavcup  As Integer  'NUMERIC (02,0) ,
Public sepervcup  As Integer  'NUMERIC (02,0) ,
Public setipvcup  As String   'CHAR(1)
Public seplazo    As Long     'NUMERIC (06,0) ,
Public setipamor  As Integer  'NUMERIC (01,0) ,
Public senumamor  As Integer  'NUMERIC (03,0)
Public seffijos   As String   'CHAR    (01)
Public sebascup   As Long     'NUMERIC (09,0)
Public sedecs     As Integer  'NUMERIC (02)
Public secorte    As Currency 'NUMERIC (19,4)

Public Function LeerSerie(oSeMascara As String) As Boolean
Dim Sql As String

    LeerSerie = False
    
    'Sql = "EXECUTE sp_seleer '" & oSeMascara & "'"
  
    Envia = Array()
    AddParam Envia, oSeMascara
    If Not Bac_Sql_Execute("sp_seleer", Envia) Then
       Exit Function
    End If
    
    Call Limpiar
    
    Dim Datos()
    
    If Bac_SQL_Fetch(Datos()) Then
       
       secodigo = Val(Datos(1))
       semascara = Trim$(Datos(2))
       seserie = Trim$(Datos(3))
       serutemi = Val(Datos(4))
       sefecemi = Datos(5)
       sefecven = Datos(6)
       setasemi = Val(Datos(7))
       setera = Val(Datos(8))
       sebasemi = Val(Datos(9))
       semonemi = Val(Datos(10))
       secupones = Val(Datos(11))
       sediavcup = Val(Datos(12))
       sepervcup = Val(Datos(13))
       setipvcup = Datos(14)
       seplazo = Val(Datos(15))
       setipamor = Val(Datos(16))
       senumamor = Val(Datos(17))
       seffijos = Datos(18)
       sebascup = Val(Datos(19))
       sedecs = Val(Datos(20))
       secorte = Val(Datos(21))
    
    End If
    
    LeerSerie = True
    
End Function

Private Sub Limpiar()

    secodigo = 0
    semascara = ""
    seserie = ""
    serutemi = 0
    sefecemi = ""
    sefecven = ""
    setasemi = 0
    setera = 0
    sebasemi = 0
    semonemi = 0
    secupones = 0
    sediavcup = 0
    sepervcup = 0
    setipvcup = ""
    seplazo = 0
    setipamor = 0
    senumamor = 0
    seffijos = ""
    sebascup = 0
    sedecs = 0
    secorte = 0

End Sub

