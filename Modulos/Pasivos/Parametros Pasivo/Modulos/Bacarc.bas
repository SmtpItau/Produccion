Attribute VB_Name = "BacArc"
Global Nomfin  As String * 30
Global CODI
Global codipag
Global Cifecha As String * 10
Global Impues  As Double

Dim Sql$
Dim Datos()

Type MDBfield
    Name As String
    Type As String
    Size As Double
End Type

Public Function Bacllenat(Texto1 As Variant, Lontext%, Deci%) As String
  Dim Ct$, Cp$, Cl$, Cq$, i%
  Cq = ""
 If IsNumeric(Texto1) Then
  If Deci <> 0 Then
   Cp = Trim(Str(InStr(1, Texto1, ".")))
   Ct = Trim(Mid(Texto1, 1, Val(Cp)))
   Cl = Trim(Str(Val(Mid(Texto1, Val(Cp) + 1, Deci - 1))))
    For i = 1 To Deci - IIf(Cl = "0", 0, Len(Cl)) - 1
     Cq = Cq + "0"
    Next i
    Cl = IIf(Cl = "0", Cq, Cl + Cq)
   Bacllenat = Ct + IIf(Deci <> 0, Cl, "")
  End If
       Cq = ""
      If Deci = 0 Then Bacllenat = Val(Str(Texto1))
    For i = 1 To Lontext - Len(Bacllenat)
      Cq = Cq + "0"
    Next i
     Bacllenat = Cq + Bacllenat
 Else
   Ct = Trim(Texto1)
   If Lontext - Len(Ct) > 0 Then
    Bacllenat = Trim(Texto1) + Space(Lontext - Len(Ct))
   Else
   Bacllenat = Mid(Ct, 1, 30)
   End If
 End If
End Function

Public Function mdbCrea_Tabla(strTable$) As Boolean
Dim arrStr()
'Dim tbl As Table
Dim fds As Fields
Dim fld As Field

    mdbCrea_Tabla = False
    
    strTable = UCase(Trim(strTable))
    Select Case strTable
    Case strTable = "PLANILLA"
        ReDim arrStr(100, 3)
        arrStr(1, 1) = ""
    Case Else
        MsgBox "No Existe procedimiento para crear Tabla : " & strTable, vbInformation
        Exit Function
    End Select

    mdbCrea_Tabla = True
    
End Function
