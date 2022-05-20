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
Attribute VB_Exposed = True
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
 
Public Function Grabar() As Boolean

    Grabar = False
    
    Envia = Array(feano, _
            feplaza, _
            feene, _
            fefeb, _
            femar, _
            feabr, _
            femay, _
            fejun, _
            fejul, _
            feago, _
            fesep, _
            feoct, _
            fenov, _
            fedic)
    
    If Not Bac_Sql_Execute("SP_FEGRABAR", Envia) Then
        Exit Function
    End If
    
    Call Limpiar
    Grabar = True
    
End Function


Public Function Leer(idAnn As Integer, IdPlaza As String) As Boolean
 
    Leer = False
    
    Envia = Array(CDbl(idAnn), IdPlaza)
     
    If Not Bac_Sql_Execute("SVA_GEN_FER", Envia) Then
        Exit Function
    End If
    
    Call Limpiar
    
    ReDim datos(14)
    If Bac_SQL_Fetch(datos()) Then
        feano = datos(1)
        feplaza = datos(2)
        feene = datos(3)
        fefeb = datos(4)
        femar = datos(5)
        feabr = datos(6)
        femay = datos(7)
        fejun = datos(8)
        fejul = datos(9)
        feago = datos(10)
        fesep = datos(11)
        feoct = datos(12)
        fenov = datos(13)
        fedic = datos(14)
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




