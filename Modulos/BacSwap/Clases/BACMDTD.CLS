VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "clsTDesarrollo"
Attribute VB_Creatable = True
Attribute VB_Exposed = True
Option Explicit

Public tdmascara  As String
Public tdcupon    As Integer
Public tdfecven   As String
Public tdinteres  As Double
Public tdamort    As Double
Public tdflujo    As Double
Public tdsaldo    As Double

Public tdPeriodo   As Integer
Public tdDecimales As Integer


Public Function Grabar() As Boolean

Dim Sql         As String

   Grabar = False

    Sql = ""
    Sql = "Exec sp_GrabarTDesa "
    Sql = Sql & "'" & tdmascara & "',"
    Sql = Sql & tdcupon & ","
    If Trim$(tdfecven) <> "" Then
       Sql = Sql & "'" & Format(tdfecven, "MM/DD/YYYY") & "',"
    Else
       Sql = Sql & "null,"
    End If
    Sql = Sql & BacStrTran(Trim$(CStr(tdinteres)), ",", ".") & ","
    Sql = Sql & BacStrTran(Trim$(CStr(tdamort)), ",", ".") & ","
    Sql = Sql & BacStrTran(Trim$(CStr(tdflujo)), ",", ".") & ","
    Sql = Sql & BacStrTran(Trim$(CStr(tdsaldo)), ",", ".")
          
    If SQL_Execute(Sql) <> 0 Then
        Exit Function
    End If
   
    Grabar = True

End Function




