VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "clsmonex"
Attribute VB_Creatable = False
Attribute VB_Exposed = False
Option Explicit

'Public mxvalor         As Double
'Public valor           As Double
'Public mxglosamoneda   As String
'Public mxnemobcch      As String
'Public mxpais          As Long
'Public mxdescrip       As String
'Public mxfactor        As Long

'mfmx : TABLA DE MONEDAS
'-----------------------------------------------
Public mxcodigo         As Long
Public mxglosamoneda    As String
Public mxpais           As Long
Public mxnemobcch       As String
Public mxdescrip        As String
Public mxfactor         As Double

Public mxptacom         As Double
Public mxptaven         As Double
Public mxbid            As Double
Public mxask            As Double
Public msperiodo        As Double
Public Function grabar() As Boolean

   Dim Sql As String

   grabar = False

   Sql = "execute sp_grabamonextfwd "
   Sql = Sql + Str$(mxcodigo) + ","
   Sql = Sql + "'" & mxglosamoneda + "',"
   Sql = Sql + Str$(mxpais) + ","
   Sql = Sql + "'" + mxnemobcch + "',"
   Sql = Sql + "'" + mxdescrip + "',"
   Sql = Sql + Str$(mxfactor)
    
     
   If SQL_Execute(Sql) > 0 Then
      Exit Function

   End If

   Call Limpiar
   grabar = True

End Function

'Trae datos de una moneda a partir del codigo
Public Function LeerPorCodigo(codigo As Long) As Boolean

   Dim Sql           As String
   Dim Datos()

   LeerPorCodigo = False

   Sql = "execute sp_leemonexfwd "
   Sql = Sql & codigo & "," & "'1'" & Chr(10)

   If SQL_Execute(Sql) > 0 Then
      Exit Function

   End If

   Call Limpiar

   If SQL_Fetch(Datos()) = 0 Then
      mxcodigo = Val(Datos(1))
      mxglosamoneda = Datos(2)
      mxdescrip = Datos(3)
      mxfactor = Val(Datos(4))
      mxpais = Val(Datos(5))
      mxnemobcch = Datos(6)

   Else
      LeerPorCodigo = False
      Exit Function

   End If

   LeerPorCodigo = True

End Function

Sub Limpiar()

   mxcodigo = 0
   mxglosamoneda = ""
   mxpais = 0
   mxnemobcch = ""
   mxdescrip = ""
   mxfactor = 0

End Sub

