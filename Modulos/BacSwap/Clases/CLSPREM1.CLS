VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "clsPremios"
Attribute VB_Creatable = True
Attribute VB_Exposed = True
Option Explicit
Public objTPremio   As Object
Public objColeccion As New Collection
Public Function GrabarPremio() As Boolean
Dim SQL As String
Dim Fila As Long

 GrabarPremio = False
        
        SQL = ""
        SQL = "EXEC Sp_TPGrabar  " & Chr(10)
        SQL = SQL & objTPremio.prcodi & ","
        SQL = SQL & "'" & objTPremio.prserie & "',"
        SQL = SQL & objTPremio.prcupon & ","
        SQL = SQL & BacStrTran(Trim$(CStr(objTPremio.prpremio)), ",", ".")
        If SM_Execute(SQL) <> 0 Then
           Exit Function
        End If
  
  GrabarPremio = True
  
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

Public Function LeerPremio(Idcodi As Integer, idserie As String) As Boolean
Dim SQL As String

    LeerPremio = False
    
    SQL = "Exec Sp_TPLeer " & Idcodi & ",'" & idserie & "'"
     
    If SM_Execute(SQL) <> 0 Then
       Exit Function
    End If
    
    Dim Datos()
    
    Call VaciarColeccion
    
    Do While SM_Fetch(Datos()) = 0
       Dim oTPremio As New clsPremio
           oTPremio.prcodi = Val(Datos(1))
           oTPremio.prserie = Datos(2)
           oTPremio.prcupon = Val(Datos(3))
           oTPremio.prpremio = Val(Datos(4))
       objColeccion.Add oTPremio
       Set oTPremio = Nothing
    Loop
    
    LeerPremio = True
    
End Function

Public Sub VaciarColeccion()
Dim Filas As Long
Dim Max   As Long

          Max = objColeccion.Count
          
          For Filas = 1 To Max
                   objColeccion.Remove 1
          Next Filas
          
End Sub




Private Sub Class_Initialize()
 
 Set objTPremio = New clsPremio
 
End Sub


Private Sub Class_Terminate()
 
 Set objTPremio = Nothing

End Sub


