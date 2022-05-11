Attribute VB_Name = "modMDDI"
Option Explicit

Type BacMDDIKeyType
    Rutcart     As Long
    NumDocu     As Double
    Correla     As Integer
    Contador    As Double
End Type

'Variables utilizadas para la consulta de disponibilidad
Global gSQLLib$ 'Libros -->CASS
Global gSQLCar$ 'Cartera -->CASS
Global gSQLCat$ 'Categoria -->CASS
Global gSQLVar$ 'Parte Variable
Global gSQLFam$ 'Familias
Global gSQLEmi$ 'Emisores
Global gSQLMon$ 'Monedas
Global gSQLSer$ 'Series
Global gSQL$
Global gs_Cart As Integer
