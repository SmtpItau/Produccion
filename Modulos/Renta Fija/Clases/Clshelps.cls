VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsHelpges"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit
Dim FILAS&, Max&
Public objcodmov    As Object
Public objcodmov1   As Object
Public Coleccion    As New Collection
Public codescri     As String
Public CodTipos     As String
Public codmov       As String
Public CodNum       As String
Public CodOrden     As String
Public COD2756      As String
Public CodAfecta    As String
Public CodMovch     As String
Public CodNumC      As String
Public CodCta       As String
Public Function leemoned(IdNombre As String)
Dim mens1$, Mens2$, Mens3$, IdRow%, Datos()
Dim objBuffer     As Object
   
    leemoned = False
   
'   Sql = "SP_LEEFA " & "'" & IdNombre & "'"
 
    Envia = Array(IdNombre)
    
    If Not Bac_Sql_Execute("SP_LEEFA", Envia) Then
        Exit Function
    End If
        
    Call VaciarColeccion

    Do While Bac_SQL_Fetch(Datos())
        Dim objBuffer1 As New clsHelpges

        Set objBuffer1 = New clsHelpges

        With objBuffer1
            .codescri = Trim(Datos(2))
            .CodTipos = Datos(5)
            .codmov = CDbl(Val(Datos(1)))
            .CodNum = CDbl(Val(Datos(4)))
            .CodOrden = Datos(3)
            .COD2756 = Datos(6)
            .CodAfecta = Datos(7)
            .CodMovch = CDbl(Val(Datos(8)))
            .CodNumC = Datos(9)
            .CodCta = Datos(10)
        End With

        Coleccion.Add objBuffer1

        Set objBuffer1 = Nothing

    Loop
   
    leemoned = True

End Function

Private Sub Class_Initialize()
   
'   Set objcodmov = New clsHelpges

End Sub

Private Sub Class_Terminate()

   Set objcodmov = Nothing
    
End Sub
Public Sub Coleccion2Control(objControl As Object)

   Dim IDGLOSA    As String * 40
   With objControl
      .Clear
      Max = Coleccion.Count
      
      For FILAS = 1 To Max
         IDGLOSA = Coleccion(FILAS).codescri
         .AddItem IDGLOSA
        .ItemData(.NewIndex) = Coleccion(FILAS).CodMovch
      Next FILAS

   End With

End Sub
Public Sub VaciarColeccion()
   Max& = Coleccion.Count
   For FILAS& = 1 To Max&
      Coleccion.Remove 1

   Next FILAS&

End Sub

