VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "clsTDesarrollos"
Attribute VB_Creatable = True
Attribute VB_Exposed = True
Option Explicit
Public objDesarrollo As Object
Public objColeccion  As New Collection
Private Function BacDivision(IdDivi1 As Double, IdDivi2 As Double) As Double

    If IdDivi1 = 0 Or IdDivi2 = 0 Then
       BacDivision = 0
    Else
       BacDivision = (IdDivi1 / IdDivi2)
    End If

End Function

Private Function BacStrTran(sCadena$, sFind$, sReplace$) As String
         
         Dim iPos%
         Dim iLen%
         
         iPos% = 1
         iLen% = Len(sFind$)
         Do While True
             iPos% = InStr(1, sCadena$, sFind$)
             If iPos% = 0 Then
                     Exit Do
             End If
             sCadena$ = Mid$(sCadena$, 1, iPos% - 1) + sReplace$ + Mid$(sCadena$, iPos% + iLen%)
         Loop
         BacStrTran = sCadena$
         
End Function


Public Function CalculaTDesarrollo()

Dim SQL        As String
Dim sGatos     As String
Dim cDato      As String
Dim cFecha     As String
Dim inte       As Double
Dim cupo       As Integer
Dim namo       As Integer
Dim pvcu       As Integer
Dim nDec       As Integer

Dim num_amo    As Double
Dim n          As Double
Dim F          As Double
Dim ntp        As Double
Dim flujo      As Double
Dim aux_s      As Double
Dim aux_cupo   As Double
Dim aux_inte   As Double
Dim aux_amo    As Double
Dim aux_fluj   As Double

   
   '-- Asigno Valores de Parametros a variables de Procedimiento
   '-- =========================================================
   cDato = objDesarrollo.tdmascara
   cFecha = objDesarrollo.tdfecven
   inte = objDesarrollo.tdinteres
   cupo = objDesarrollo.tdcupon
   namo = objDesarrollo.tdamort
   pvcu = objDesarrollo.tdPeriodo
   nDec = objDesarrollo.tdDecimales
   
   sGatos$ = "###,###,###,###"
    
   If nDec > 0 Then
      sGatos$ = sGatos$ & "." & String$(nDec, "0")
   End If
   'programación en si
   '-- ==========================================================

   num_amo = cupo - namo
   
   n = BacDivision(CDbl(pvcu), 12)

   ntp = (((1 + BacDivision(inte, 100)) ^ n) - 1) * 100

   If num_amo = 0 Then
      'flujo = 100 * ntp / 100 * (1 + ntp / 100) ^ cupo / ((1 + ntp / 100) ^ cupo - 1)
      flujo = BacDivision((1 + ntp / 100) ^ cupo, ((1 + ntp / 100) ^ cupo - 1))
      flujo = 100 * BacDivision(ntp, 100) * flujo
   Else
      'flujo = 100 * ntp / 100 * (1 + ntp / 100) ^ namo / ((1 + ntp / 100) ^ namo - 1)
      flujo = (1 + ntp / 100) ^ namo / ((1 + ntp / 100) ^ namo - 1)
      flujo = 100 * BacDivision(ntp, 100) * flujo
   End If

   
   If nDec > 0 Then
      flujo = Format$(flujo, sGatos)
   End If
   
   aux_s = 100

   F = 0


   Call VaciarColeccion
   
   '-- Inicio Ciclo de Formulas para posteriormente grabarlas en la tabla de desarrollo
   '-- ================================================================================
   For F = 1 To cupo
       aux_cupo = F
       aux_inte = ((BacDivision(ntp, 100)) * aux_s)
       
       If nDec > 0 Then
          aux_inte = Format(aux_inte, sGatos)
       End If
       
       If F = cupo Then
          aux_amo = aux_s
          aux_fluj = (aux_amo) + (aux_inte)
       End If
       
       If F <> cupo Then
          If namo = cupo Then
             aux_fluj = flujo
             aux_amo = (flujo) - (aux_inte)
          End If
 
          If namo <> cupo Then
             If F <= num_amo Then
                aux_amo = 0
                aux_fluj = aux_inte
             End If
             If F > num_amo Then
                aux_fluj = flujo
                aux_amo = (flujo) - (aux_inte)
             End If
          End If
       End If
      
       aux_s = (aux_s) - (aux_amo)

       
       ' Generamos cálculos para la tabla de desarrollo
       '--------------------------------------------------
       Dim oTdesarrollo As New clsTDesarrollo
           oTdesarrollo.tdmascara = cDato
           If Trim$(cFecha) <> "" Then
              oTdesarrollo.tdfecven = DateAdd("m", aux_cupo * pvcu, cFecha)
           End If
           oTdesarrollo.tdcupon = aux_cupo
           oTdesarrollo.tdinteres = aux_inte
           oTdesarrollo.tdamort = aux_amo
           oTdesarrollo.tdflujo = aux_fluj
           oTdesarrollo.tdsaldo = aux_s
       objColeccion.Add oTdesarrollo
       Set oTdesarrollo = Nothing

   Next F
  
  
   
End Function

Public Function GrabarDesarrollo() As Boolean
Dim SQL        As String
Dim F          As Long

   GrabarDesarrollo = False
    
   If SM_Execute("BEGIN TRANSACTION") <> 0 Then
      Exit Function
   End If

   For F = 1 To objColeccion.Count
        objDesarrollo.tdmascara = objColeccion(F).tdmascara
        objDesarrollo.tdcupon = objColeccion(F).tdcupon
        objDesarrollo.tdfecven = objColeccion(F).tdfecven
        objDesarrollo.tdinteres = objColeccion(F).tdinteres
        objDesarrollo.tdamort = objColeccion(F).tdamort
        objDesarrollo.tdflujo = objColeccion(F).tdflujo
        objDesarrollo.tdsaldo = objColeccion(F).tdsaldo
               
        SQL = ""
        SQL = "Exec Sp_GrabarTDesa "
        SQL = SQL & "'" & objDesarrollo.tdmascara & "',"
        SQL = SQL & objDesarrollo.tdcupon & ","
        If Trim$(objDesarrollo.tdfecven) <> "" Then
           SQL = SQL & "'" & Format(objDesarrollo.tdfecven, "MM/DD/YYYY") & "',"
        End If
        SQL = SQL & BacStrTran(Trim$(CStr(objDesarrollo.tdinteres)), ",", ".") & ","
        SQL = SQL & BacStrTran(Trim$(CStr(objDesarrollo.tdamort)), ",", ".") & ","
        SQL = SQL & BacStrTran(Trim$(CStr(objDesarrollo.tdflujo)), ",", ".") & ","
        SQL = SQL & BacStrTran(Trim$(CStr(objDesarrollo.tdsaldo)), ",", ".")
          
        If SM_Execute(SQL) <> 0 Then
           If SM_Execute("ROLLBACK TRANSACTION") <> 0 Then
              Exit Function
           End If
           Exit For
        End If
   Next F
   
   If SM_Execute("COMMIT TRANSACTION") <> 0 Then
      Exit Function
   End If
   
   GrabarDesarrollo = True

End Function


Public Function LeerDesarrollo(IdMascara As String) As Boolean
Dim SQL As String

    LeerDesarrollo = False
    
    SQL = "Exec Sp_TdLeer '" & IdMascara & "'"
     
    If SM_Execute(SQL) <> 0 Then
       Exit Function
    End If
    
    Dim Datos()
    
    Call VaciarColeccion
    
    Do While SM_Fetch(Datos()) = 0
       Dim oTdesarrollo As New clsTDesarrollo
           oTdesarrollo.tdmascara = Datos(1)
           oTdesarrollo.tdcupon = Datos(2)
           oTdesarrollo.tdfecven = Datos(3)
           oTdesarrollo.tdinteres = Val(Datos(4))
           oTdesarrollo.tdamort = Val(Datos(5))
           oTdesarrollo.tdflujo = Val(Datos(6))
           oTdesarrollo.tdsaldo = Val(Datos(7))
       objColeccion.Add oTdesarrollo
       Set oTdesarrollo = Nothing
    Loop
    
    LeerDesarrollo = True
    
End Function



Private Sub VaciarColeccion()
Dim Filas As Long
          
          For Filas = 1 To objColeccion.Count
                   objColeccion.Remove 1
          Next Filas
          
End Sub

Private Sub Class_Initialize()
       Set objDesarrollo = New clsTDesarrollo
End Sub


Private Sub Class_Terminate()
        Set objDesarrollo = Nothing
End Sub


