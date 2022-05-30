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
Public TabTD       As New Collection

