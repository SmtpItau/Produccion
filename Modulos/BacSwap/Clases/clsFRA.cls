VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsFRA"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Dim Sql$, Datos()
Dim iError%, sError$

Public Numero_Operacion&

Public Tipo_Operacion$
Public Rut&
Public DV$

Public iCartera%
Public sCartera$

Public iMoneda%     '-- Codigo Moneda
Public sMoneda$     '-- Glosa
Public dMoneda#     '-- Valor

Public Capital#
Public CapitalUSD#
Public CapitalCLP#

Public fecContrato  As Date
Public fecLiquida   As Date
Public fecInicio    As Date
Public fecTermino   As Date

Public iTasa%       '-- Codigo Tasa
Public sTasa$       '-- Glosa
Public dTasa#       '-- Valor Hoy

Public iPeriodo%    '-- Codigo Periodo
Public sPeriodo$    '-- Glosa
Public mPeriodo%    '-- Meses
Public dPeriodo%    '-- Dias

Public TasaContrato#

Public iMPago%      '-- Codigo Moneda de Pago
Public sMPago$      '-- Glosa

Public iFPago%      '-- Codigo Forma de Pago
Public sFPago$      '-- Glosa

Public iEstado%     '-- Codigo Estado
Public sEstado$     '-- Glosa

Public OperadorCliente#     '-- Codigo Operador
Public Observaciones$

Public PlazoFwd&    '-- FecInicio v/s fecTermino
Public CodCliente%
Function Grabar() As Boolean

    Grabar = False
    iError = -1
    sError = "Problemas en conección para Grabar Operación"

    Sql = "SP_GRABAFRA " & Numero_Operacion
    Sql = Sql & ", " & iCartera
    Sql = Sql & ",'" & Tipo_Operacion & "'"
    Sql = Sql & ", " & iMoneda
    Sql = Sql & ", " & CodCliente
    Sql = Sql & ", " & Rut
    Sql = Sql & ", " & Capital
    Sql = Sql & ",'" & FechaYMD(fecContrato) & "'"
    Sql = Sql & ",'" & FechaYMD(fecLiquida) & "'"
    Sql = Sql & ",'" & FechaYMD(fecInicio) & "'"
    Sql = Sql & ",'" & FechaYMD(fecTermino) & "'"
    Sql = Sql & ", " & iTasa
    Sql = Sql & ", " & iPeriodo
    Sql = Sql & ", " & mPeriodo
    Sql = Sql & ", " & BacStrTran((TasaContrato), gsc_PuntoDecim, ".")
    Sql = Sql & ", " & iMPago
    Sql = Sql & ", " & iFPago
    Sql = Sql & ",'" & gsBAC_User & "'"
    Sql = Sql & ", " & OperadorCliente
    Sql = Sql & ",'" & Observaciones & "'"
    Sql = Sql & ",'" & Format(Time, "HH:MM:SS") & "'"
    
    If MISQL.SQL_Execute(Sql) = 0 Then
        If MISQL.SQL_Fetch(Datos) = 0 Then
            iError = Val(Datos(1))
            If iError < 0 Then
                sError = Datos(2)
            Else
                Numero_Operacion = iError
                sError = "Operación " & iError & " se grabo exitosamente!"
            End If
        End If
    
        If iError < 0 Then
            sError = "Problemas al Grabar " & IIf(Numero_Operacion = 0, "Operación", "Modificación") & vbCrLf & sError
        End If
    End If
    
    MsgBox sError, vbInformation + vbOKOnly, "Grabando FRA"
    
    Grabar = Not (iError < 0)

End Function
'-----
' xNumOpe <= 0 = Todas

Function LeerANT(xNumOpe&, xEstado%) As Boolean

    LeerANT = False

    SQL = "SP_OPERACIONESFRA " & xNumOpe ' & ", " & xEstado
        
    If MISQL.SQL_Execute(Sql) = 0 Then
        If MISQL.SQL_Fetch(Datos) = 0 Then
            Numero_Operacion = Val(Datos(1))
            iCartera = Val(Datos(2))
            Tipo_Operacion = Datos(4)
            iMoneda = Val(Datos(13))
            Capital = BacStrTran((Datos(15)), ".", gsc_PuntoDecim)
            CapitalUSD = BacStrTran((Datos(15)), ".", gsc_PuntoDecim)
            CapitalCLP = BacStrTran((Datos(15)), ".", gsc_PuntoDecim)
            fecContrato = Datos(10)
            fecLiquida = Datos(12)
            fecInicio = Datos(11)
            fecTermino = Datos(26)
            iTasa = Val(Datos(16))
            iPeriodo = Val(Datos(19))
            mPeriodo = Val(Datos(19))
            TasaContrato = BacStrTran((Datos(18)), ".", gsc_PuntoDecim)
            iFPago = Val(Datos(21))
            Rut = Val(Datos(7))
            DV = Val(Datos(8))
            LeerANT = True
        End If
    Else
        Exit Function
    End If
    
    If iError > 0 Then
        sError = "Operación"
    End If
    
    
End Function


Function Leer(xNumOpe&, xEstado%) As Boolean

    Leer = False

    SQL = "SP_OPERACIONESFRA " & xNumOpe ' & ", " & xEstado
        
    If MISQL.SQL_Execute(Sql) = 0 Then
        If MISQL.SQL_Fetch(Datos) = 0 Then
            Numero_Operacion = Val(Datos(1))
            iCartera = Val(Datos(2))
            sCartera = Datos(3)
            Tipo_Operacion = Datos(4)
            'sTipo_Operacion = Datos(5)
            CodCliente = Val(Datos(6))
            Rut = Val(Datos(7))
            DV = Datos(8)
            'Nombre = Datos(9)
            fecContrato = Datos(10)
            fecInicio = Datos(11)
            fecTermino = Datos(12)
            fecLiquida = Datos(13)
            PlazoFwd = DateDiff("d", fecInicio, fecTermino)
            iMoneda = Val(Datos(14))
            sMoneda = Datos(15)
            Capital = CDbl(Datos(16))
            CapitalUSD = CDbl(Datos(16))
            CapitalCLP = CDbl(Datos(16))
            iTasa = Val(Datos(17))
            sTasa = Datos(18)
            Datos(19) = BacStrTran((Datos(19)), ".", gsc_PuntoDecim)
            TasaContrato = CDbl(Datos(19))
            iPeriodo = Val(Datos(20))
            sPeriodo = Datos(21)
            dPeriodo = Val(Datos(22))
            mPeriodo = Val(Datos(23))
            iFPago = Val(Datos(24))
            sFPago = Datos(25)
            'sTrader = Datos(26)
            'sEstado = Datos(27)
            OperadorCliente = Datos(29)
            iMPago = Val(Datos(30))
            Leer = True
        End If
    Else
        Exit Function
    End If
    
    If iError > 0 Then
        sError = "Operación"
    End If
    
    
End Function


Sub Limpiar()
 
    Numero_Operacion = 0
    Tipo_Operacion = ""
    Rut = 0
    DV = ""
    
    iCartera = 0
    sCartera = ""
    
    iMoneda = 0
    sMoneda = ""
    dMoneda = 0#
    
    Capital = 0#
    CapitalUSD = 0#
    CapitalCLP = 0#
    
    fecContrato = gsBAC_Fecp
    fecLiquida = gsBAC_Fecp
    fecInicio = gsBAC_Fecp
    fecTermino = gsBAC_Fecp
    
    iTasa = 0
    sTasa = ""
    dTasa = 0#
    
    iPeriodo = 0    '-- Codigo
    sPeriodo = ""    '-- Glosa
    mPeriodo = 0    '-- Meses
    
    TasaContrato = 0#
    
    iMPago = 0      '-- Codigo
    sMPago = ""     '-- Glosa
    
    iFPago = 0      '-- Codigo
    sFPago = ""     '-- Glosa
    
    iEstado = 0
    sEstado = Glosas("GRABAR", Val(iEstado))
    
    Observaciones = ""

End Sub

