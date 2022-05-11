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

Dim Sql$, DATOS(), i&

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

    Leer = False
    Envia = Array()
    AddParam Envia, idAnn
    AddParam Envia, Val(IdPlaza)
    
    If Not Bac_Sql_Execute("SP_LEER_FERIADO ", Envia) Then
        Exit Function
    End If
    
    Call Limpiar
    
    If Bac_SQL_Fetch(DATOS()) Then
        feano = DATOS(1)
        feplaza = DATOS(2)
        feene = DATOS(3)
        fefeb = DATOS(4)
        femar = DATOS(5)
        feabr = DATOS(6)
        femay = DATOS(7)
        fejun = DATOS(8)
        fejul = DATOS(9)
        feago = DATOS(10)
        fesep = DATOS(11)
        feoct = DATOS(12)
        fenov = DATOS(13)
        fedic = DATOS(14)
        Leer = True
    End If

End Function

Public Function grabar() As Boolean
Dim ruta

    'ruta = giSQL_DatabaseCommon & ".." & "sp_Grabar_Feriado "
    Envia = Array()
    AddParam Envia, feano
    AddParam Envia, feplaza
    AddParam Envia, feene
    AddParam Envia, fefeb
    AddParam Envia, femar
    AddParam Envia, feabr
    AddParam Envia, femay
    AddParam Envia, fejun
    AddParam Envia, fejul
    AddParam Envia, feago
    AddParam Envia, fesep
    AddParam Envia, feoct
    AddParam Envia, fenov
    AddParam Envia, fedic
    

    Grabar = (Bac_Sql_Execute("SP_GRABAR_FERIADO", Envia))
    
    If Bac_SQL_Fetch(DATOS()) Then
        If Val(DATOS(1)) < 0 Then
            MsgBox DATOS(2), vbCritical, TITSISTEMA
            grabar = False
            Exit Function
        End If
    End If

  grabar = True

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
