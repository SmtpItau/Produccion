VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "clsOperacion"
Attribute VB_Creatable = True
Attribute VB_Exposed = True
Option Explicit

Public nNumOper         As Long     'Número de operación
Public nCodCart         As Long     'Rut Cartera
Public nCodigo          As Long     'Rut Cliente
Public nPosicion1       As Integer  'Posición 1
Public nmoneda1         As Integer  'Moneda 1
Public nMoneda2         As Integer  'Moneda 2
Public cTipOper         As String   'Tipo Operación
Public cTipModa         As String   'Tipo de modalidad
Public cFecha           As String   'Fecha de Operación
Public nTipCamb         As Double   'Tipo de Cambio
Public nMtoMda1         As Double   'Monto Moneda1
Public nEquUSD1         As Double   'Monto Moneda1 Equivalente en USD
Public nEquMda1         As Double   'Monto Moneda1 Equivalente en $
Public nParMda1         As Double   'Paridad Equivalente USD Moneda1
Public nPreMda1         As Double   'Precio Equivalente $ Moneda1
Public nMtoMda2         As Double   'Monto Moneda2
Public nEquUSD2         As Double   'Monto Moneda2 Equivalente en USD
Public nEquMda2         As Double   'Monto Moneda2 Equivalente en $
Public nParMda2         As Double   'Paridad Equivalente USD Moneda2
Public nPreMda2         As Double   'Precio Equivalente $ Moneda2
Public cEstado          As String   'Estado de la Operación (Aprobada/Pendiente/Anulada)
Public cRetiro          As String   'Tipo de Retiro Vienen/Vamos
Public nContraparte     As Long     'Rut Contraparte
Public cObservacion     As String   'Observaciones
Public nSpread          As Double   'Spread
Public nPreCal          As Double   'Precio de Calculo
Public nPlazo           As Integer  'Plazo
Public cFecVcto         As String   'Fecha de Vencimiento
Public cLock            As String   'Operación Tomada por
Public cOperador        As String   'Operador que genero la operación
Public nFPagoMN         As Double   'Formas de Pago MN
Public nFPagoMX         As Double   'Formas de Pago MX
Public nMdaUSD          As Integer  'Moneda Referencial USD
Public nTasaUSD         As Double   'Tasa USD
Public nTasaCon         As Double   'Tasa Contraparte
Public Status           As Boolean
Public nMtoCalzado      As Double   ' Monto Calzado
Public nMtoInMon1       As Double   ' Monto Inicial Moneda1
Public nMtoFiMon1       As Double   ' Monto Final Moneda1
Public nMtoInMon2       As Double   ' Monto Inicial Moneda2
Public nMtoFiMon2       As Double   ' Monto Final Moneda2
Public nEntidad         As Long     ' Entidad
Public nCodCli          As Long     'codigo Cliente

Public Function CargarDatos() As Boolean

   Dim Sql        As String
   Dim Datos()

   CargarDatos = False

   Sql = "EXECUTE sp_leeroperacion " & nNumOper

   If SQL_Execute(Sql) > 0 Then
      MsgBox "Problemas al leer la operación", vbCritical, "MENSAJE"
      Exit Function

   End If

   Do While SQL_Fetch(Datos()) = 0
      nCodCart = Val(Datos(1))         'Rut Cartera
      nCodigo = Val(Datos(2))          'Rut Cliente
      nPosicion1 = Val(Datos(3))       'Posición 1
      nmoneda1 = Val(Datos(4))         'Moneda 1
      nMoneda2 = Val(Datos(5))         'Moneda 2
      cTipOper = Datos(6)             'Tipo Operación
      cTipModa = Datos(7)             'Tipo de modalidad
      cFecha = Datos(8)               'Fecha de Operación
      nTipCamb = Val(Datos(9))        'Tipo de Cambio
      nMdaUSD = Val(Datos(10))         'Moneda Referencial del USD
      nMtoMda1 = Val(Datos(11))        'Monto Moneda1
      nEquUSD1 = Val(Datos(12))        'Monto Moneda1 Equivalente en USD
      nEquMda1 = Val(Datos(13))        'Monto Moneda1 Equivalente en $
      nParMda1 = Val(Datos(14))        'Paridad Equivalente USD Moneda1
      nPreMda1 = Val(Datos(15))        'Precio Equivalente $ Moneda1
      nMtoMda2 = Val(Datos(16))        'Monto Moneda2
      nEquUSD2 = Val(Datos(17))        'Monto Moneda2 Equivalente en USD
      nEquMda2 = Val(Datos(18))        'Monto Moneda2 Equivalente en $
      nParMda2 = Val(Datos(19))        'Paridad Equivalente USD Moneda2
      nPreMda2 = Val(Datos(20))        'Precio Equivalente $ Moneda2
      cEstado = Datos(21)              'Estado de la Operación (Aprobada/Pendiente/Anulada)
      cRetiro = Datos(22)              'Tipo de Retiro Vienen/Vamos
      nContraparte = Val(Datos(23))    'Rut Contraparte
      cObservacion = Datos(24)         'Observaciones
      nSpread = Val(Datos(25))         'Spread
      nPreCal = Val(Datos(26))         'Precio de Calculo
      nPlazo = Val(Datos(27))          'Plazo
      cFecVcto = Datos(28)             'Fecha de Vencimiento
      cLock = Datos(29)                'Operación Tomada por
      cOperador = Datos(30)            'Operador que genero la operación
      nTasaUSD = Val(Datos(31))        'Tasa USD
      nTasaCon = Val(Datos(32))        'Tasa Contraparte
      nFPagoMN = Val(Datos(33))        'Formas de Pago MN
      nFPagoMX = Val(Datos(34))        'Formas de Pago MX
      nMtoCalzado = Val(Datos(35))     'Monto Calzado
      nMtoInMon1 = Val(Datos(36))      ' Monto Inicial Moneda1
      nMtoFiMon1 = Val(Datos(37))      ' Monto Final Moneda1
      nMtoInMon2 = Val(Datos(38))      ' Monto Inicial Moneda2
      nMtoFiMon2 = Val(Datos(39))      ' Monto Final Moneda2
      nEntidad = Val(Datos(40))        ' Entidad
      nCodCli = Val(Datos(41))         ' Codigo Cliente
   Loop

   CargarDatos = True

End Function

Public Function CopiarDatos(cControl As Object)

   With cControl
      nNumOper = .nNumOper             'Número de operación
      nCodCart = .nCodCart             'Rut Cartera
      nCodigo = .nCodigo               'Rut Cliente
      nPosicion1 = .nPosicion1         'Posición 1
      nmoneda1 = .nmoneda1             'Moneda 1
      nMoneda2 = .nMoneda2             'Moneda 2
      cTipOper = .cTipOper             'Tipo Operación
      cTipModa = .cTipModa             'Tipo de modalidad
      cFecha = .cFecha                 'Fecha de Operación
      nTipCamb = .nTipCamb             'Tipo de Cambio
      nMtoMda1 = .nMtoMda1             'Monto Moneda1
      nEquUSD1 = .nEquUSD1             'Monto Moneda1 Equivalente en USD
      nEquMda1 = .nEquMda1             'Monto Moneda1 Equivalente en $
      nParMda1 = .nParMda1             'Paridad Equivalente USD Moneda1
      nPreMda1 = .nPreMda1             'Precio Equivalente $ Moneda1
      nMtoMda2 = .nMtoMda2             'Monto Moneda2
      nEquUSD2 = .nEquUSD2             'Monto Moneda2 Equivalente en USD
      nEquMda2 = .nEquMda2             'Monto Moneda2 Equivalente en $
      nParMda2 = .nParMda2             'Paridad Equivalente USD Moneda2
      nPreMda2 = .nPreMda2             'Precio Equivalente $ Moneda2
      cEstado = .cEstado               'Estado de la Operación (Aprobada/Pendiente/Anulada)
      cRetiro = .cRetiro               'Tipo de Retiro Vienen/Vamos
      nContraparte = .nContraparte     'Rut Contraparte
      cObservacion = .cObservacion     'Observaciones
      nSpread = .nSpread               'Spread
      nPreCal = .nPreCal               'Precio de Calculo
      nPlazo = .nPlazo                 'Plazo
      cFecVcto = .cFecVcto             'Fecha de Vencimiento
      cLock = .cLock                   'Operación Tomada por
      cOperador = .cOperador           'Operador que genero la operación
      nFPagoMN = .nFPagoMN             'Formas de Pago MN
      nFPagoMX = .nFPagoMX             'Formas de Pago MX
      nMdaUSD = .nMdaUSD               'Moneda Referencial USD
      nTasaUSD = .nTasaUSD             'Tasa USD
      nTasaCon = .nTasaCon             'Tasa Contraparte
      nMtoInMon1 = .nMtoInMon1         ' Monto Inicial Moneda1
      nMtoFiMon1 = .nMtoFiMon1         ' Monto Final Moneda1
      nMtoInMon2 = .nMtoInMon2         ' Monto Inicial Moneda2
      nMtoFiMon2 = .nMtoFiMon2         ' Monto Final Moneda2
      nEntidad = .nEntidad             ' Entidad
      nCodCli = .nCodCli
      
   End With

End Function

Public Function GrabarOperacion() As Boolean

   Dim Sql        As String
   Dim Datos()

   GrabarOperacion = True

   'Concatenación de la instrucción QUERY
   cFecha = Format(cFecha, "YYYYMMDD")
   cFecVcto = Format(cFecVcto, "YYYYMMDD")

   Sql = "EXECUTE sp_grabaroperacion " & vbCrLf
   Sql = Sql & Space(28) & nNumOper & "," & vbCrLf                      'Número Operación
   Sql = Sql & Space(28) & nCodCart & "," & vbCrLf                      'RUT Cartera
   Sql = Sql & Space(28) & nCodigo & "," & vbCrLf                       'RUT Cliente
   Sql = Sql & Space(28) & nPosicion1 & "," & vbCrLf                    'Posición 1
   Sql = Sql & Space(28) & nmoneda1 & "," & vbCrLf                      'Moneda 1
   Sql = Sql & Space(28) & nMoneda2 & "," & vbCrLf                      'Moneda 1
   Sql = Sql & Space(28) & "'" & cTipOper & "'," & vbCrLf               'Tipo Operación
   Sql = Sql & Space(28) & "'" & cTipModa & "'," & vbCrLf               'Tipo de modalidad
   Sql = Sql & Space(28) & "'" & cFecha & "'," & vbCrLf                 'Fecha de Operación
   Sql = Sql & Space(28) & bacTranMontoSql(nTipCamb) & "," & vbCrLf     'Tipo de Cambio
   Sql = Sql & Space(28) & nMdaUSD & "," & vbCrLf                       'Moneda Referencial USD
   Sql = Sql & Space(28) & bacTranMontoSql(nMtoMda1) & "," & vbCrLf     'Monto Mda1
   Sql = Sql & Space(28) & bacTranMontoSql(nEquUSD1) & "," & vbCrLf     'Monto Mda1 Eq. en USD
   Sql = Sql & Space(28) & bacTranMontoSql(nEquMda1) & "," & vbCrLf     'Monto Mda1 Eq. en $
   Sql = Sql & Space(28) & bacTranMontoSql(nMtoMda2) & "," & vbCrLf     'Monto Mda2
   Sql = Sql & Space(28) & bacTranMontoSql(nEquUSD2) & "," & vbCrLf     'Monto Mda2 Eq. en USD
   Sql = Sql & Space(28) & bacTranMontoSql(nEquMda2) & "," & vbCrLf     'Monto Mda2 Eq. en $
   Sql = Sql & Space(28) & bacTranMontoSql(nParMda1) & "," & vbCrLf     'Paridad Eq. USD Mda1
   Sql = Sql & Space(28) & bacTranMontoSql(nPreMda1) & "," & vbCrLf     'Precio Eq. $ Mda1
   Sql = Sql & Space(28) & bacTranMontoSql(nParMda2) & "," & vbCrLf     'Paridad Eq. USD Mda2
   Sql = Sql & Space(28) & bacTranMontoSql(nPreMda2) & "," & vbCrLf     'Precio Eq. $ Mda2
   Sql = Sql & Space(28) & "'" & cEstado & "'," & vbCrLf                'Estado de la Operación
   Sql = Sql & Space(28) & "'" & cRetiro & "'," & vbCrLf                'Tipo de Retiro
   Sql = Sql & Space(28) & nContraparte & "," & vbCrLf                  'Rut Contraparte
   Sql = Sql & Space(28) & "'" & cObservacion & "'," & vbCrLf           'Observaciones
   Sql = Sql & Space(28) & bacTranMontoSql(nSpread) & "," & vbCrLf      'Spread
   Sql = Sql & Space(28) & bacTranMontoSql(nPreCal) & "," & vbCrLf      'Precio de Calculo
   Sql = Sql & Space(28) & nPlazo & "," & vbCrLf                        'Plazo
   Sql = Sql & Space(28) & "'" & cFecVcto & "'," & vbCrLf               'Fecha de Vencimiento
   Sql = Sql & Space(28) & "'" & cLock & "'," & vbCrLf                  'Operación Tomada por
   Sql = Sql & Space(28) & "'" & cOperador & "'," & vbCrLf              'Operador Creador
   Sql = Sql & Space(28) & bacTranMontoSql(nTasaUSD) & "," & vbCrLf     'Tasa USD
   Sql = Sql & Space(28) & bacTranMontoSql(nTasaCon) & "," & vbCrLf     'Tasa Contraparte
   Sql = Sql & Space(28) & nFPagoMN & "," & vbCrLf                      'Forma de Pago MN
   Sql = Sql & Space(28) & nFPagoMX & "," & vbCrLf                      'Forma de Pago MX
   Sql = Sql & Space(28) & bacTranMontoSql(nMtoInMon1) & "," & vbCrLf   'Monto inicial Moneda 1
   Sql = Sql & Space(28) & bacTranMontoSql(nMtoFiMon1) & "," & vbCrLf   'Monto Final Moneda 1
   Sql = Sql & Space(28) & bacTranMontoSql(nMtoInMon2) & "," & vbCrLf   'Monto inicial Moneda 2
   Sql = Sql & Space(28) & bacTranMontoSql(nMtoFiMon2) & "," & vbCrLf   'Monto Final Moneda 2
   Sql = Sql & Space(28) & nEntidad & "," & vbCrLf
   Sql = Sql & Space(28) & nCodCli                       'Codigo Cliente


   'Ejecución de la sentencia de grabación
   If SQL_Execute(Sql) > 0 Then
      MsgBox "Problemas al Grabar", vbCritical, "MENSAJE"
      GrabarOperacion = False

   End If

   'Limpieza del Buffer.
   Do While SQL_Fetch(Datos()) = 0
      nNumOper = Val(Datos(1))
      If Datos(2) = "CC" Then
         MsgBox "Se eliminaron los calces existetes para esta operación", vbExclamation, "GABRAR"

      End If

   Loop

End Function

Public Function GrabarOperacionMFCA() As Boolean

   Dim Sql        As String
   Dim Datos()

   GrabarOperacionMFCA = True

   'Concatenación de la instrucción QUERY
   cFecha = Format(cFecha, "YYYYMMDD")
   cFecVcto = Format(cFecVcto, "YYYYMMDD")

   Sql = "EXECUTE sp_grabaroperacionmfca " & vbCrLf
   Sql = Sql & Space(28) & nNumOper & "," & vbCrLf                      'Número Operación
   Sql = Sql & Space(28) & nCodCart & "," & vbCrLf                      'RUT Cartera
   Sql = Sql & Space(28) & nCodigo & "," & vbCrLf                       'RUT Cliente
   Sql = Sql & Space(28) & nPosicion1 & "," & vbCrLf                    'Posición 1
   Sql = Sql & Space(28) & nmoneda1 & "," & vbCrLf                      'Moneda 1
   Sql = Sql & Space(28) & nMoneda2 & "," & vbCrLf                      'Moneda 1
   Sql = Sql & Space(28) & "'" & cTipOper & "'," & vbCrLf               'Tipo Operación
   Sql = Sql & Space(28) & "'" & cTipModa & "'," & vbCrLf               'Tipo de modalidad
   Sql = Sql & Space(28) & "'" & cFecha & "'," & vbCrLf                 'Fecha de Operación
   Sql = Sql & Space(28) & bacTranMontoSql(nTipCamb) & "," & vbCrLf     'Tipo de Cambio
   Sql = Sql & Space(28) & nMdaUSD & "," & vbCrLf                       'Moneda Referencial USD
   Sql = Sql & Space(28) & bacTranMontoSql(nMtoMda1) & "," & vbCrLf     'Monto Mda1
   Sql = Sql & Space(28) & bacTranMontoSql(nEquUSD1) & "," & vbCrLf     'Monto Mda1 Eq. en USD
   Sql = Sql & Space(28) & bacTranMontoSql(nEquMda1) & "," & vbCrLf     'Monto Mda1 Eq. en $
   Sql = Sql & Space(28) & bacTranMontoSql(nMtoMda2) & "," & vbCrLf     'Monto Mda2
   Sql = Sql & Space(28) & bacTranMontoSql(nEquUSD2) & "," & vbCrLf     'Monto Mda2 Eq. en USD
   Sql = Sql & Space(28) & bacTranMontoSql(nEquMda2) & "," & vbCrLf     'Monto Mda2 Eq. en $
   Sql = Sql & Space(28) & bacTranMontoSql(nParMda1) & "," & vbCrLf     'Paridad Eq. USD Mda1
   Sql = Sql & Space(28) & bacTranMontoSql(nPreMda1) & "," & vbCrLf     'Precio Eq. $ Mda1
   Sql = Sql & Space(28) & bacTranMontoSql(nParMda2) & "," & vbCrLf     'Paridad Eq. USD Mda2
   Sql = Sql & Space(28) & bacTranMontoSql(nPreMda2) & "," & vbCrLf     'Precio Eq. $ Mda2
   Sql = Sql & Space(28) & "'" & cEstado & "'," & vbCrLf                'Estado de la Operación
   Sql = Sql & Space(28) & "'" & cRetiro & "'," & vbCrLf                'Tipo de Retiro
   Sql = Sql & Space(28) & nContraparte & "," & vbCrLf                  'Rut Contraparte
   Sql = Sql & Space(28) & "'" & cObservacion & "'," & vbCrLf           'Observaciones
   Sql = Sql & Space(28) & bacTranMontoSql(nSpread) & "," & vbCrLf      'Spread
   Sql = Sql & Space(28) & bacTranMontoSql(nPreCal) & "," & vbCrLf      'Precio de Calculo
   Sql = Sql & Space(28) & nPlazo & "," & vbCrLf                        'Plazo
   Sql = Sql & Space(28) & "'" & cFecVcto & "'," & vbCrLf               'Fecha de Vencimiento
   Sql = Sql & Space(28) & "'" & cLock & "'," & vbCrLf                  'Operación Tomada por
   Sql = Sql & Space(28) & "'" & cOperador & "'," & vbCrLf              'Operador Creador
   Sql = Sql & Space(28) & bacTranMontoSql(nTasaUSD) & "," & vbCrLf     'Tasa USD
   Sql = Sql & Space(28) & bacTranMontoSql(nTasaCon) & "," & vbCrLf     'Tasa Contraparte
   Sql = Sql & Space(28) & nFPagoMN & "," & vbCrLf                      'Forma de Pago MN
   Sql = Sql & Space(28) & nFPagoMX & "," & vbCrLf                      'Forma de Pago MX
   Sql = Sql & Space(28) & bacTranMontoSql(nMtoInMon1) & "," & vbCrLf   'Monto inicial Moneda 1
   Sql = Sql & Space(28) & bacTranMontoSql(nMtoFiMon1) & "," & vbCrLf   'Monto Final Moneda 1
   Sql = Sql & Space(28) & bacTranMontoSql(nMtoInMon2) & "," & vbCrLf   'Monto inicial Moneda 2
   Sql = Sql & Space(28) & bacTranMontoSql(nMtoFiMon2) & "," & vbCrLf   'Monto Final Moneda 2
   Sql = Sql & Space(28) & nEntidad & "," & vbCrLf                      ' Entidad
   Sql = Sql & Space(28) & nCodCli                                      'Codigo cliente

   'Ejecución de la sentencia de grabación
   If SQL_Execute(Sql) > 0 Then
      MsgBox "Problemas al Grabar", vbCritical, "MENSAJE"
      GrabarOperacionMFCA = False

   End If

   'Limpieza del Buffer.
   Do While SQL_Fetch(Datos()) = 0
      nNumOper = Val(Datos(1))
      If Datos(2) = "CC" Then
         MsgBox "Se eliminaron los calces existetes para esta operación", vbExclamation, "GABRAR"

      End If

   Loop

End Function

Public Sub Limpiar()

   nNumOper = 0            'Número de operación
   nCodCart = 0            'Rut Cartera
   nCodigo = 0             'Rut Cliente
   nPosicion1 = 0          'Posición 1
   nmoneda1 = 0            'Moneda 1
   nMoneda2 = 0            'Moneda 2
   cTipOper = ""           'Tipo Operación
   cTipModa = ""           'Tipo de modalidad
   cFecha = ""             'Fecha de Operación
   nTipCamb = 0            'Tipo de Cambio
   nMtoMda1 = 0            'Monto Moneda1
   nEquUSD1 = 0            'Monto Moneda1 Equivalente en USD
   nEquMda1 = 0            'Monto Moneda1 Equivalente en $
   nParMda1 = 0            'Paridad Equivalente USD Moneda1
   nPreMda1 = 0            'Precio Equivalente $ Moneda1
   nMtoMda2 = 0            'Monto Moneda2
   nEquUSD2 = 0            'Monto Moneda2 Equivalente en USD
   nEquMda2 = 0            'Monto Moneda2 Equivalente en $
   nParMda2 = 0            'Paridad Equivalente USD Moneda2
   nPreMda2 = 0            'Precio Equivalente $ Moneda2
   cEstado = ""            'Estado de la Operación (Aprobada/Pendiente/Anulada)
   cRetiro = ""            'Tipo de Retiro Vienen/Vamos
   nContraparte = 0        'Rut Contraparte
   cObservacion = ""       'Observaciones
   nSpread = 0             'Spread
   nPreCal = 0             'Precio de Calculo
   nPlazo = 0              'Plazo
   cFecVcto = ""           'Fecha de Vencimiento
   cLock = ""              'Operación Tomada por
   cOperador = ""          'Operador que genero la operación
   nFPagoMN = 0            'Formas de Pago MN
   nFPagoMX = 0            'Formas de Pago MX
   nMdaUSD = 0             'Moneda Referencial USD
   nTasaUSD = 0            'Tasa USD
   nTasaCon = 0            'Tasa Contraparte
   nMtoInMon1 = 0          ' Monto Inicial Moneda1
   nMtoFiMon1 = 0          ' Monto Final Moneda1
   nMtoInMon2 = 0          ' Monto Inicial Moneda2
   nMtoFiMon2 = 0          ' Monto Final Moneda2
   nEntidad = 0            ' Entidad
   nCodCli = 0             'Codigo cliente
   
End Sub

Public Function CargarDatosMFCA() As Boolean

   Dim Sql        As String
   Dim Datos()

   CargarDatosMFCA = False

   Sql = "EXECUTE sp_leeroperacioncar " & nNumOper

   If SQL_Execute(Sql) > 0 Then
      MsgBox "Problemas al leer la operación", vbCritical, "MENSAJE"
      Exit Function

   End If

   Do While SQL_Fetch(Datos()) = 0
      nCodCart = Val(Datos(1))         'Rut Cartera
      nCodigo = Val(Datos(2))          'Rut Cliente
      nPosicion1 = Val(Datos(3))       'Posición 1
      nmoneda1 = Val(Datos(4))         'Moneda 1
      nMoneda2 = Val(Datos(5))         'Moneda 2
      cTipOper = Datos(6)              'Tipo Operación
      cTipModa = Datos(7)              'Tipo de modalidad
      cFecha = Datos(8)                'Fecha de Operación
      nTipCamb = Val(Datos(9))         'Tipo de Cambio
      nMdaUSD = Val(Datos(10))         'Moneda Referencial del USD
      nMtoMda1 = Val(Datos(11))        'Monto Moneda1
      nEquUSD1 = Val(Datos(12))        'Monto Moneda1 Equivalente en USD
      nEquMda1 = Val(Datos(13))        'Monto Moneda1 Equivalente en $
      nParMda1 = Val(Datos(14))        'Paridad Equivalente USD Moneda1
      nPreMda1 = Val(Datos(15))        'Precio Equivalente $ Moneda1
      nMtoMda2 = Val(Datos(16))        'Monto Moneda2
      nEquUSD2 = Val(Datos(17))        'Monto Moneda2 Equivalente en USD
      nEquMda2 = Val(Datos(18))        'Monto Moneda2 Equivalente en $
      nParMda2 = Val(Datos(19))        'Paridad Equivalente USD Moneda2
      nPreMda2 = Val(Datos(20))        'Precio Equivalente $ Moneda2
      cEstado = Datos(21)              'Estado de la Operación (Aprobada/Pendiente/Anulada)
      cRetiro = Datos(22)              'Tipo de Retiro Vienen/Vamos
      nContraparte = Val(Datos(23))    'Rut Contraparte
      cObservacion = Datos(24)         'Observaciones
      nSpread = Val(Datos(25))         'Spread
      nPreCal = Val(Datos(26))         'Precio de Calculo
      nPlazo = Val(Datos(27))          'Plazo
      cFecVcto = Datos(28)             'Fecha de Vencimiento
      cOperador = Datos(29)            'Operador que genero la operación
      nTasaUSD = Val(Datos(30))        'Tasa USD
      nTasaCon = Val(Datos(31))        'Tasa Contraparte
      nFPagoMN = Val(Datos(32))        'Formas de Pago MN
      nFPagoMX = Val(Datos(33))        'Formas de Pago MX
      nMtoCalzado = Val(Datos(34))     'Monto Calzado
      nMtoInMon1 = Val(Datos(35))      ' Monto Inicial Moneda1
      nMtoFiMon1 = Val(Datos(36))      ' Monto Final Moneda1
      nMtoInMon2 = Val(Datos(37))      ' Monto Inicial Moneda2
      nMtoFiMon2 = Val(Datos(38))      ' Monto Final Moneda2
      cLock = ""
      nEntidad = Val(Datos(39))        ' Entidad
      nCodCli = Val(Datos(40))         ' Codigo

   Loop
   

   CargarDatosMFCA = True
   
End Function

Function TomarOperacion(nNumOper As Long, sUsuario As String) As Boolean

   Dim Sql           As String
   Dim Datos()

   TomarOperacion = False

   Sql = "EXECUTE sp_tomaroperacion " & nNumOper & ", '"
   Sql = Sql & sUsuario & "'"

   If SQL_Execute(Sql) <> 0 Then
      MsgBox "Problemas al tomar la operación", vbCritical, "MENSAJE"
      Exit Function

   End If

   Do While SQL_Fetch(Datos()) = 0
   Loop

   TomarOperacion = True

End Function

Public Function Carga() As Boolean

   Dim Sql        As String
   Dim Datos()

   Carga = True

   'Concatenación de la instrucción QUERY
   cFecha = Format(cFecha, "YYYYMMDD")
   cFecVcto = Format(cFecVcto, "YYYYMMDD")

   Sql = "EXECUTE sp_carga " & vbCrLf
   Sql = Sql & Space(28) & nNumOper & "," & vbCrLf                      'Número Operación
   Sql = Sql & Space(28) & nCodCart & "," & vbCrLf                      'RUT Cartera
   Sql = Sql & Space(28) & nCodigo & "," & vbCrLf                       'RUT Cliente
   Sql = Sql & Space(28) & nPosicion1 & "," & vbCrLf                    'Posición 1
   Sql = Sql & Space(28) & nmoneda1 & "," & vbCrLf                      'Moneda 1
   Sql = Sql & Space(28) & nMoneda2 & "," & vbCrLf                      'Moneda 1
   Sql = Sql & Space(28) & "'" & cTipOper & "'," & vbCrLf               'Tipo Operación
   Sql = Sql & Space(28) & "'" & cTipModa & "'," & vbCrLf               'Tipo de modalidad
   Sql = Sql & Space(28) & "'" & cFecha & "'," & vbCrLf                 'Fecha de Operación
   Sql = Sql & Space(28) & bacTranMontoSql(nTipCamb) & "," & vbCrLf     'Tipo de Cambio
   Sql = Sql & Space(28) & nMdaUSD & "," & vbCrLf                       'Moneda Referencial USD
   Sql = Sql & Space(28) & bacTranMontoSql(nMtoMda1) & "," & vbCrLf     'Monto Mda1
   Sql = Sql & Space(28) & bacTranMontoSql(nEquUSD1) & "," & vbCrLf     'Monto Mda1 Eq. en USD
   Sql = Sql & Space(28) & bacTranMontoSql(nEquMda1) & "," & vbCrLf     'Monto Mda1 Eq. en $
   Sql = Sql & Space(28) & bacTranMontoSql(nMtoMda2) & "," & vbCrLf     'Monto Mda2
   Sql = Sql & Space(28) & bacTranMontoSql(nEquUSD2) & "," & vbCrLf     'Monto Mda2 Eq. en USD
   Sql = Sql & Space(28) & bacTranMontoSql(nEquMda2) & "," & vbCrLf     'Monto Mda2 Eq. en $
   Sql = Sql & Space(28) & bacTranMontoSql(nParMda1) & "," & vbCrLf     'Paridad Eq. USD Mda1
   Sql = Sql & Space(28) & bacTranMontoSql(nPreMda1) & "," & vbCrLf     'Precio Eq. $ Mda1
   Sql = Sql & Space(28) & bacTranMontoSql(nParMda2) & "," & vbCrLf     'Paridad Eq. USD Mda2
   Sql = Sql & Space(28) & bacTranMontoSql(nPreMda2) & "," & vbCrLf     'Precio Eq. $ Mda2
   Sql = Sql & Space(28) & "'" & cEstado & "'," & vbCrLf                'Estado de la Operación
   Sql = Sql & Space(28) & "'" & cRetiro & "'," & vbCrLf                'Tipo de Retiro
   Sql = Sql & Space(28) & nContraparte & "," & vbCrLf                  'Rut Contraparte
   Sql = Sql & Space(28) & "'" & cObservacion & "'," & vbCrLf           'Observaciones
   Sql = Sql & Space(28) & bacTranMontoSql(nSpread) & "," & vbCrLf      'Spread
   Sql = Sql & Space(28) & bacTranMontoSql(nPreCal) & "," & vbCrLf      'Precio de Calculo
   Sql = Sql & Space(28) & nPlazo & "," & vbCrLf                        'Plazo
   Sql = Sql & Space(28) & "'" & cFecVcto & "'," & vbCrLf               'Fecha de Vencimiento
   Sql = Sql & Space(28) & "'" & cLock & "'," & vbCrLf                  'Operación Tomada por
   Sql = Sql & Space(28) & "'" & cOperador & "'," & vbCrLf              'Operador Creador
   Sql = Sql & Space(28) & bacTranMontoSql(nTasaUSD) & "," & vbCrLf     'Tasa USD
   Sql = Sql & Space(28) & bacTranMontoSql(nTasaCon) & "," & vbCrLf     'Tasa Contraparte
   Sql = Sql & Space(28) & nFPagoMN & "," & vbCrLf                      'Forma de Pago MN
   Sql = Sql & Space(28) & nFPagoMX & "," & vbCrLf                      'Forma de Pago MX
   Sql = Sql & Space(28) & bacTranMontoSql(nMtoInMon1) & "," & vbCrLf   'Monto inicial Moneda 1
   Sql = Sql & Space(28) & bacTranMontoSql(nMtoFiMon1) & "," & vbCrLf   'Monto Final Moneda 1
   Sql = Sql & Space(28) & bacTranMontoSql(nMtoInMon2) & "," & vbCrLf   'Monto inicial Moneda 2
   Sql = Sql & Space(28) & bacTranMontoSql(nMtoFiMon2) & "," & vbCrLf   'Monto Final Moneda 2
   Sql = Sql & Space(28) & bacTranMontoSql(nCodCli)                   'Codigo Cliente

   'Ejecución de la sentencia de grabación
   If SQL_Execute(Sql) > 0 Then
      MsgBox "Problemas al Grabar", vbCritical, "MENSAJE"
      Carga = False

   End If

   'Limpieza del Buffer.
   Do While SQL_Fetch(Datos()) = 0
      nNumOper = Val(Datos(1))
      If Datos(2) = "CC" Then
         MsgBox "Se eliminaron los calces existetes para esta operación", vbExclamation, "GABRAR"

      End If

   Loop

End Function

