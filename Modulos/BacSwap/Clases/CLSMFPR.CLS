VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "ClsMFPR"
Attribute VB_Creatable = False
Attribute VB_Exposed = False
Option Explicit

Public prcartera  As String
Public prcodmon1  As String
Public prcodmon2 As String
Public prglosa  As String
Public prdecpr  As Integer
Public prdectc  As Integer
Public prbase   As Integer
Public prtippr  As String
Public prtipmod  As String
Public prprmmon1 As String
Public prprmmon2 As String
Public prprogcal As String
Public prprogdev As String
Public prtipcmb As String
Public prvalmon1 As Double
Public prvalmon2 As Double
Public Sub Limpiar()

   prcartera = ""
   prcodmon1 = ""
   prcodmon2 = ""
   prglosa = ""
   prdecpr = 0
   prdectc = 0
   prbase = 0
   prtippr = ""
   prtipmod = ""
   prprmmon1 = ""
   prprmmon2 = ""
   prprogcal = ""
   prprogdev = ""
   prtipcmb = ""
   prvalmon1 = 0
   prvalmon2 = 0
          
End Sub
Public Function LeerSegCmb(cCodcart As String, cMon1 As String, cMon2 As String, Fecp As String) As Boolean

   Dim Sql        As String
   Dim Datos()

   LeerSegCmb = False

   Sql = "EXECUTE sp_datosunacartera "
   Sql = Sql + "'" + cCodcart + "',"
   Sql = Sql + "'" + cMon1 + "',"
   Sql = Sql + "'" + cMon2 + "',"
   Sql = Sql + "'" + Format(Fecp, "YYYYMMDD") + "'"
   
   If SQL_Execute(Sql) > 0 Then
      Exit Function
   End If
      
   Call Limpiar
   
   If SQL_Fetch(Datos()) = 0 Then
      prcartera = Datos(1)
      prcodmon1 = Datos(2)
      prcodmon2 = Datos(3)
      prglosa = Datos(4)
      prdecpr = Val(Datos(5))
      prdectc = Val(Datos(6))
      prbase = Val(Datos(7))
      prtippr = Datos(8)
      prtipmod = Datos(9)
      prprmmon1 = Datos(10)
      prprmmon2 = Datos(11)
      prprogcal = Datos(12)
      prprogdev = Datos(13)
      prtipcmb = Datos(14)
      prvalmon1 = Val(Datos(15))
      prvalmon2 = Val(Datos(16))

   End If
   
   LeerSegCmb = True

End Function
Private Sub Class_Initialize()
   
   Call Limpiar

End Sub
