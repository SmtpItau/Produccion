VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "clsArbFut"
Attribute VB_Creatable = False
Attribute VB_Exposed = False
Option Explicit

Public prcartera    As String
Public prcodmon1    As String
Public prcodmon2    As String
Public prglosa      As String
Public prdecpr      As Integer
Public prdectc      As Integer
Public prbase       As Integer
Public prtippr      As String
Public prtipmod     As String
Public prtipcmb     As String
Public prprmmon1    As String
Public prprmmon2    As String
Public prprogcal    As String
Public prprogdev    As String
'Public prtipcmb     As String
'Public prvalmon1    As Double
'Public prvalmon2    As Double
Public Sub limpiar()
    prcartera = ""
    prcodmon1 = ""
    prcodmon2 = ""
    prglosa = ""
   ' prdecpr = 0
   ' prdectc = 0
    prbase = 0
    prtippr = ""
    prtipmod = ""
   ' prprmmon1 = ""
    prprmmon2 = ""
    prprogcal = ""
    prprogdev = ""
    'prtipcmb = ""
    'prvalmon1 = 0
    'prvalmon2 = 0
          
End Sub

Private Sub Class_Initialize()
        Call limpiar
End Sub



Public Function LeerSegArb(cCodcart As String, cMon1 As Long, cMon2 As String) As Boolean

Dim SQL As String

    LeerSegArb = False
    
    SQL = "exec sp_DatosUnacarterax "
    SQL = SQL & "'" & cCodcart & "',"
    SQL = SQL & cMon1 & ","
    SQL = SQL & "'" & cMon2 + "'"
    'SQL = SQL + "'"  "'"
    
    If SQL_Execute(SQL) <> 0 Then
       Exit Function
    End If
       
    Call limpiar
    
    Dim Datos()
    
    If SQL_Fetch(Datos()) = 0 Then
        prcartera = Datos(1)
        prcodmon1 = Datos(2)
        prcodmon2 = Datos(3)
       ' prglosa = Datos(4)
        prdecpr = Val(Datos(4))
        prdectc = Val(Datos(5))
        'prbase = Val(Datos(6))
        'prtippr = Datos(6)
        prtipmod = Datos(6)
        'prprmmon1 = Datos(10)
        'prprmmon2 = Datos(8)
        prprogcal = Datos(7)
        prprogdev = Datos(8)
        prtipcmb = Datos(9)
        'prvalmon1 = Val(Datos(15))
        'prvalmon2 = Val(Datos(16))
        
    End If
    
    LeerSegArb = True
 
End Function

