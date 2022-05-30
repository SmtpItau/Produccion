VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "ClsRecupInter"
Attribute VB_Creatable = True
Attribute VB_Exposed = True
Option Explicit

Public Tipoper     As String
Public FecIni        As String
Public Plazo         As String
Public FecVen     As String
Public moneda   As String
Public Base         As String
Public Valor         As String
Public MtoInicial   As String
Public Interes       As String
Public MtoFinal    As String
Public RutCar      As String
Public DigVeri      As String
Public NomCar    As String
Public TipCar       As String
Public Forpai        As String
Public Forpav       As String
Public Tipret         As String
Public Tippag       As String
Public RutCli        As String
Public DigCli        As String
Public NomCli     As String

Public Function AnulaInter(sNumoper As String) As Integer
Dim SQL As String
Dim Datos()

AnulaInter = 0
SQL = "Execute Sp_AnulaInterbancario "
SQL = SQL + sNumoper

If SQL_Execute(SQL) <> 0 Then
                    AnulaInter = 1
                    Exit Function
End If

Call LimpiaClase

End Function

Public Function BuscaDatos(sNumoper As String) As Integer
Dim SQL As String
Dim Datos()

BuscaDatos = 0
SQL = "Execute Sp_BuscaInterbancario "
SQL = SQL + sNumoper

If SQL_Execute(SQL) <> 0 Then
                    BuscaDatos = 1
                    Exit Function
End If

Call LimpiaClase

Do While SQL_Fetch(Datos()) = 0
            Tipoper = Datos(1)
            If Tipoper = "0" Then
                    BuscaDatos = 3
                    Exit Function
            ElseIf Tipoper = "1" Then
                    BuscaDatos = 4
                    Exit Function
            End If
            FecIni = Datos(2)
            Plazo = Datos(3)
            FecVen = Datos(4)
            moneda = Datos(5)
            Base = Datos(6)
            Valor = Val(Datos(7))
            MtoInicial = Val(Datos(8))
            Interes = Val(Datos(9))
            MtoFinal = Val(Datos(10))
            RutCar = Datos(11)
            DigVeri = Datos(12)
            NomCar = Datos(13)
            TipCar = Datos(14)
            Forpai = Datos(15)
            Forpav = Datos(16)
            Tipret = Datos(17)
            Tippag = Datos(18)
            RutCli = Datos(19)
            DigCli = Datos(20)
            NomCli = Datos(21)
Loop

End Function

Public Sub LimpiaClase()
            Tipoper = ""
            FecIni = ""
            Plazo = ""
            FecVen = ""
            moneda = ""
            Base = ""
            Valor = ""
            MtoInicial = ""
            Interes = ""
            MtoFinal = ""
            RutCar = ""
            DigVeri = ""
            NomCar = ""
            TipCar = ""
            Forpai = ""
            Forpav = ""
            Tipret = ""
            Tippag = ""
            RutCli = ""
            DigCli = ""
            NomCli = ""
End Sub


