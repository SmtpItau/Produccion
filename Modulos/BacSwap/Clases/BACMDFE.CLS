VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsFeriado"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'MDFE : TABLA DE FERIADOS
'-----------------------------------------------
Public feano      As Integer  'numeric  4,0
Public feplaza    As String
Public feene      As String
Public fefeb      As String
Public femar      As String
Public feabr      As String
Public femay      As String
Public fejun      As String
Public fejul      As String
Public feago      As String
Public fesep      As String
Public feoct      As String
Public fenov      As String
Public fedic      As String

Public Function Leer(idAnn As Integer, IdPlaza As String) As Boolean

   Dim Sql        As String
   Dim Datos()

   Leer = False

   Sql = ""
   Sql = Sql & "EXECUTE sp_Leer_Feriado " & Chr(10)
   Sql = Sql & idAnn & ", " & Chr(10)
   Sql = Sql & Val(IdPlaza)

   If SQL_Execute(Sql) > 0 Then
      Exit Function
   End If

   Call Limpiar

   If SQL_Fetch(Datos()) = 0 Then
      feano = Datos(1)
      feplaza = Datos(2)
      feene = Datos(3)
      fefeb = Datos(4)
      femar = Datos(5)
      feabr = Datos(6)
      femay = Datos(7)
      fejun = Datos(8)
      fejul = Datos(9)
      feago = Datos(10)
      fesep = Datos(11)
      feoct = Datos(12)
      fenov = Datos(13)
      fedic = Datos(14)

   End If

   Leer = True

End Function

Public Sub Limpiar()

   feano = 0
   feplaza = ""
   feene = ""
   fefeb = ""
   femar = ""
   feabr = ""
   femay = ""
   fejun = ""
   fejul = ""
   feago = ""
   fesep = ""
   feoct = ""
   fenov = ""
   fedic = ""

End Sub
