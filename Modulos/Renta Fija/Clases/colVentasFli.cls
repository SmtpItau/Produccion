VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "colVentasFli"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Public oColVentas          As New Collection

Dim mvarFiltro             As String
Dim mvarTotalOperacion     As Double
Dim mvarTotalOperacionMimi As Double
Dim mvarTotalResultado     As Double
Dim mvarTotalCartera       As Double
Dim mvarInversion          As Double
Dim mvarSeleccionado       As Double
Dim mvarSaldo              As Double
Dim mvarSeleccion          As String   'T: Total o M: Marcados
Dim mvarTotalOriginal      As Double
Dim mvarFechaInicio        As String
Dim mvarFechaVencimiento   As String
Dim mvarPlazo              As Long
Dim mvarValorInicialCLP    As Double
Dim mvarValorFinalCLP      As Double
Dim mvarValorInicialUM     As Double
Dim mvarValorFinalUM       As Double
Dim mvarTipoCambio         As Double
Dim mvarTasaPacto          As Double
Dim mvarBasePacto          As Double
Dim mvarMonedaPacto        As Double
Dim mvarExtranjera         As Integer
Dim mvarRutCliente         As Long
Dim mvarCodCliente         As Long
Dim mvarTotalmargenOP      As Double
Dim mVarCodOrigen          As Integer
Dim mVarCodDestino         As Integer
Dim mVarCodEjecutivo       As String
Dim mvarModificado         As String
Dim mvarMtoModif           As Double


Dim mvarCostofondo         As Double 'LM

Dim nRow                   As Integer
Dim Sql                    As String
Dim Datos()
Dim Modo_Actualizacion     As String

Public Function ChequearDispFechas()
    Dim sMensaje As String
    Dim i As Integer

        For i = 1 To oColVentas.Count
            If oColVentas(i).InstSer <> "" And Format(oColVentas(i).FecProxCupon, "YYYYMMDD") < Format(BacGrabar.FecVenp, "YYYYMMDD") And oColVentas(i).Marca <> " " Then                 'Format(oColVentas(I).FechaSalida, "YYYYMMDD") < Format(mvarFechaVencimiento, "YYYYMMDD") And oColVentas(I).Marca <> " " Then
                sMensaje = sMensaje & Trim(oColVentas(i).InstSer) & ": Fecha de Vencimiento Proximo Cupon Menor a la del pacto" & vbCrLf
            End If
        Next i
        
        If sMensaje = "" Then
            ChequearDispFechas = True
        Else
            MsgBox sMensaje, vbExclamation, "Validación de Plazo"
            ChequearDispFechas = False
        End If
End Function

Public Property Get Descripcion() As String

   Descripcion = "VENTA CON PACTO"

End Property

Public Property Get TipoOperacion() As String
   TipoOperacion = "FLI"

End Property

Public Property Let Filtro(sFiltro As String)

   mvarFiltro = sFiltro

End Property

Public Property Get Filtro() As String

   Filtro = mvarFiltro

End Property

Public Property Get TotalOperacionMimi() As Double

   TotalOperacionMimi = mvarTotalOperacionMimi

End Property

Public Property Let TotalOperacionMimi(TotalOperacionMimi As Double)

   mvarTotalOperacionMimi = TotalOperacionMimi

End Property
Public Property Get TotalOperacion() As Double

   TotalOperacion = mvarTotalOperacion

End Property


Public Property Get TotalCartera() As Double

   TotalCartera = mvarTotalCartera

End Property
Public Property Get MtoModif() As Double

   MtoModif = mvarMtoModif

End Property


Public Property Let Inversion(nInversion As Double)

   mvarInversion = nInversion
   mvarSaldo = mvarSeleccionado - mvarInversion

End Property

Public Property Get Inversion() As Double

   Inversion = mvarInversion

End Property

Public Property Get Seleccionado() As Double

   Seleccionado = mvarSeleccionado

End Property

Public Property Let Saldo(nSaldo As Double)

   mvarSaldo = nSaldo

End Property

Public Property Get Saldo() As Double

   Saldo = mvarInversion - mvarSeleccionado

End Property

Public Property Let Seleccion(sSeleccion As String)            'T: Total o M: Marcados

   mvarSeleccion = sSeleccion

End Property

Public Property Get Seleccion() As String

   Seleccion = mvarSeleccion

End Property


Public Property Get TotalOriginal() As Double

   TotalOriginal = mvarTotalOriginal

End Property

Public Property Get TotalResultado() As Double

   TotalResultado = mvarTotalResultado

End Property

Public Property Let FechaInicio(sFechaInicio As String)

   mvarFechaInicio = sFechaInicio

   Call CalcularProximoDiaHabil

End Property

Public Property Get FechaInicio() As String

   FechaInicio = mvarFechaInicio

End Property

Public Property Let FechaVencimiento(sFechaVencimiento As String)

   mvarFechaVencimiento = sFechaVencimiento

   If mvarFechaInicio <> "" And mvarFechaVencimiento <> "" Then
      mvarPlazo = DateDiff("D", mvarFechaInicio, sFechaVencimiento)

   End If

   Call CalcularPacto

End Property

Public Property Get FechaVencimiento() As String

   FechaVencimiento = mvarFechaVencimiento

End Property
Public Property Let FliModificado(sModificado As String)

   mvarModificado = sModificado

End Property

Public Property Get FliModificado() As String

   FliModificado = mvarModificado

End Property

Public Property Let Plazo(nPlazo As Long)

   Dim nPlazoOld        As Long
   Dim dFecha           As String
   Dim i                As Integer
   Dim sMensaje         As String

   If mvarFechaInicio <> "" And nPlazo <> 0 Then
      dFecha = DateAdd("D", nPlazo, mvarFechaInicio)

      If EsFeriado(CDate(dFecha), "00001") Then
         MsgBox "La Fecha de Vcto. ingresada retorna un día No Hábil; Por favor reingrese", vbCritical, "Feriados"

      Else
         For i = 1 To oColVentas.Count
            If oColVentas(i).InstSer <> "" And Format(oColVentas(i).FechaSalida, "YYYYMMDD") < Format(dFecha, "YYYYMMDD") And oColVentas(i).Marca <> " " Then
               sMensaje = sMensaje & Trim(oColVentas(i).InstSer) & ": Papel con fecha de Disponibilidad menor a la del pacto" & vbCrLf

            End If

         Next i

         If sMensaje = "" Then
            mvarFechaVencimiento = dFecha
            mvarPlazo = nPlazo

         Else
            MsgBox sMensaje, vbExclamation, "Validación de Plazo"

         End If

      End If

   End If

   Call CalcularPacto

End Property

Public Property Get Plazo() As Long

   Plazo = mvarPlazo

End Property

Public Property Get ValorInicialCLP() As Double

   ValorInicialCLP = mvarValorInicialCLP

End Property

Public Property Get ValorFinalCLP() As Double

   ValorFinalCLP = mvarValorFinalCLP

End Property

Public Property Get ValorInicialUM() As Double

   ValorInicialUM = mvarValorInicialUM

End Property

Public Property Get ValorFinalUM() As Double

   ValorFinalUM = mvarValorFinalUM

End Property

Public Property Get TipoCambio() As Double

   TipoCambio = mvarTipoCambio

End Property

Public Property Get Extranjera() As Integer

   Extranjera = mvarExtranjera

End Property


Public Property Let TasaPacto(nTasa As Double)

   mvarTasaPacto = nTasa

   Call CalcularPacto

End Property

Public Property Get TasaPacto() As Double

   TasaPacto = mvarTasaPacto

End Property

Public Property Let BasePacto(nBase As Double)

   mvarBasePacto = nBase

End Property

Public Property Get BasePacto() As Double

   BasePacto = mvarBasePacto

End Property

Public Property Let MonedaPacto(nMoneda As Integer)

   mvarMonedaPacto = nMoneda
   
   
   Envia = Array()
   AddParam Envia, mvarMonedaPacto
    
   If Not Bac_Sql_Execute("BACPARAMSUDA..SP_MNLEER", Envia) Then
      Exit Property
   End If

   If Bac_SQL_Fetch(Datos()) Then
      mvarBasePacto = CDbl(Datos(6))
      mvarExtranjera = Val(Datos(14))
   End If

   'Busca el Valor de la moneda
   If mvarMonedaPacto <> 999 Then
      Envia = Array()
      AddParam Envia, IIf(MonedaPacto = 13, 994, mvarMonedaPacto)
      AddParam Envia, mvarFechaInicio
      If Not Bac_Sql_Execute("SP_VMLEERIND", Envia) <> 0 Then
         Exit Property
      End If
   
      If Bac_SQL_Fetch(Datos()) Then
         mvarTipoCambio = CDbl(Datos(1))
      End If

   Else
      mvarTipoCambio = 1

   End If

   Call CalcularPacto

End Property

Public Property Let MonedaPactoMX(nValMoneda As Double)
   mvarTipoCambio = nValMoneda
   Call CalcularPacto
End Property

Public Property Get MonedaPacto() As Integer

   MonedaPacto = mvarMonedaPacto

End Property
Public Property Get MonedaPactoMX() As Double

   MonedaPactoMX = mvarMonedaPacto

End Property

Public Sub CalcularTotalOperacion()

   Dim nCalcular           As Integer
   
   mvarTotalOperacion = 0
   mvarTotalOriginal = 0
   mvarSeleccionado = 0
   mvarTotalResultado = 0
   mvarTotalCartera = 0
   mvarMtoModif = 0

   For nCalcular = 1 To oColVentas.Count
      
      If oColVentas(nCalcular).Marca = "V" Or oColVentas(nCalcular).Marca = "P" Then
         mvarTotalOperacion = mvarTotalOperacion + IIf(oColVentas(nCalcular).MonedaEmision = 13, Round(oColVentas(nCalcular).ValorVenta * gsdolar, 0), oColVentas(nCalcular).ValorVenta)
         mvarTotalOriginal = mvarTotalOriginal + IIf(oColVentas(nCalcular).MonedaEmision = 13, Round(oColVentas(nCalcular).ValorCompra * gsdolar, 0), oColVentas(nCalcular).ValorCompra)
         mvarSeleccionado = mvarSeleccionado + IIf(oColVentas(nCalcular).MonedaEmision = 13, Round(oColVentas(nCalcular).ValorVenta * gsdolar, 0), oColVentas(nCalcular).ValorVenta)
         mvarTotalResultado = mvarTotalResultado + oColVentas(nCalcular).Utilidad
         mvarTotalCartera = mvarTotalCartera + IIf(oColVentas(nCalcular).MonedaEmision = 13, Round(oColVentas(nCalcular).ValorVenta * gsdolar, 0), oColVentas(nCalcular).ValorVenta)

      End If
      
      If oColVentas(nCalcular).FliModificado = "M" Then
         mvarMtoModif = mvarMtoModif + IIf(oColVentas(nCalcular).MonedaEmision = 13, Round(oColVentas(nCalcular).ValorVenta * gsdolar, 0), oColVentas(nCalcular).ValorVenta)
      End If
   Next nCalcular

   If mvarSeleccion = "M" Then
      mvarTotalCartera = mvarSeleccionado

   End If

   mvarSaldo = mvarTotalCartera - mvarSeleccionado

   Call CalcularPacto


End Sub

Public Sub CalcularTotalOperacionMimi()

   Dim nCalcular           As Integer
   
   mvarTotalOperacionMimi = 0

   For nCalcular = 1 To oColVentas.Count

         mvarTotalOperacionMimi = mvarTotalOperacionMimi + IIf(oColVentas(nCalcular).MonedaEmision = 13, Round(oColVentas(nCalcular).ValorVenta * gsdolar, 0), oColVentas(nCalcular).ValorVenta)

   Next nCalcular


End Sub



Public Sub CalcularPacto()


    Dim iRow          As Integer
    Dim ValIni_aux    As Double
    Dim ValFin_Aux    As Double
    Dim ValFinPacto   As Double
    Dim nRegVenta     As Integer
    Dim nRegAux       As Integer
    Dim decimales     As Integer

    decimales = 0

   Select Case mvarMonedaPacto
      Case 999:   decimales = 0
      Case 994:   decimales = 2
      Case 998:   decimales = 4
      Case Else:  decimales = 2
   End Select

    mvarValorInicialCLP = mvarTotalOperacion
    If mvarTotalOperacion = 0 Or mvarTipoCambio = 0 Then
        mvarValorInicialUM = 0
    Else
        If mvarTipoCambio = 1 Then
              mvarValorInicialUM = Round(mvarTotalOperacion, 0)
        Else
              mvarValorInicialUM = Round(mvarTotalOperacion / mvarTipoCambio, decimales) 'OJO
        End If
    End If
    mvarValorFinalCLP = 0
    mvarValorFinalUM = 0
    mvarValorInicialUM = 0
    mvarTotalmargenOP = 0

   If mvarBasePacto = 0 Or mvarMonedaPacto = 0 Or mvarTipoCambio = 0 Then
      Exit Sub
   End If

   ValIni_aux = 0
   ValFin_Aux = 0
   ValFinPacto = 0
   nRegVenta = 0
   nRegAux = 0

   For iRow = 1 To oColVentas.Count
      With oColVentas(iRow)
         If oColVentas(iRow).Marca = "V" Or oColVentas(iRow).Marca = "P" Then
            nRegVenta = nRegVenta + 1
           If mvarTipoCambio <> 1 Then

            If .MonedaEmision = 13 And mvarMonedaPacto = 13 Then
                    ValIni_aux = ValIni_aux + Round((.ValorVenta / 1), 2)
                   
                Else
                    If (.MonedaEmision = 13 Or .MonedaEmision = 142 Or .MonedaEmision = 72) And (mvarMonedaPacto = 998 Or mvarMonedaPacto = 994 Or mvarMonedaPacto = 142 Or mvarMonedaPacto = 72) Then
                       ValIni_aux = ValIni_aux + Round((.ValorVenta * gsdolar / mvarTipoCambio), decimales)
                    Else
                       ValIni_aux = ValIni_aux + Round((.ValorVenta / mvarTipoCambio), decimales)
                     End If
                End If
            Else ' la varibale gsdolar se debe reemplazar por una variable global de t/c segun moneda de emision
                If .MonedaEmision = 13 And mvarMonedaPacto = 999 Then
                    ValIni_aux = ValIni_aux + Round((.ValorVenta * gsdolar), 0)
                Else
                    If (.MonedaEmision = 13 Or .MonedaEmision = 142 Or .MonedaEmision = 72) And (mvarMonedaPacto = 998 Or mvarMonedaPacto = 994 Or mvarMonedaPacto = 142 Or mvarMonedaPacto = 72) Then
                       ValIni_aux = ValIni_aux + Round((.ValorVenta * gsdolar / mvarTipoCambio), decimales)
                    Else
                       ValIni_aux = ValIni_aux + Round((.ValorVenta / mvarTipoCambio), decimales)
                    End If
               End If
            End If
         End If
      End With
   Next iRow

   If mvarTipoCambio = 1 Then
        ValFinPacto = Round(ValIni_aux * (((mvarTasaPacto / (mvarBasePacto * 100#)) * mvarPlazo) + 1), 0)
   Else
        ValFinPacto = Round(ValIni_aux * (((mvarTasaPacto / (mvarBasePacto * 100#)) * mvarPlazo) + 1), decimales)
   End If

   For iRow = 1 To oColVentas.Count
      With oColVentas(iRow)
         If oColVentas(iRow).Marca = "V" Or oColVentas(iRow).Marca = "P" Then
            nRegAux = nRegAux + 1

            If mvarTipoCambio = 1 Then 'ESTO ES CUANDO ES PESOSD
               .ValorInicioPactoUM = IIf(.MonedaEmision = 13 Or .MonedaEmision = 142 Or .MonedaEmision = 72, Round(.ValorVenta * gsdolar / mvarTipoCambio, decimales), Round(.ValorVenta / mvarTipoCambio, decimales)) 'Round(.ValorVenta / mvarTipoCambio, 0)
               .ValorFinalPactoUM = Round(.ValorInicioPactoUM * (((mvarTasaPacto / (mvarBasePacto * 100#)) * mvarPlazo) + 1), 0)
               .ValorInicioPactoCLP = .ValorInicioPactoUM
               
            ElseIf mvarMonedaPacto = 998 Or mvarMonedaPacto = 994 Or mvarMonedaPacto = 997 Or mvarMonedaPacto = 995 Then
                .ValorInicioPactoUM = IIf(.MonedaEmision = 13 Or .MonedaEmision = 142 Or .MonedaEmision = 72, Round(.ValorVenta * gsdolar / mvarTipoCambio, decimales), Round(.ValorVenta / mvarTipoCambio, decimales)) 'Round(.ValorVenta / mvarTipoCambio, decimales)
                .ValorFinalPactoUM = Round(.ValorInicioPactoUM * (((mvarTasaPacto / (mvarBasePacto * 100#)) * mvarPlazo) + 1), decimales)
                .ValorInicioPactoCLP = IIf(.MonedaEmision = 13 Or .MonedaEmision = 142 Or .MonedaEmision = 72, Round(.ValorVenta * gsdolar, 0), Round(.ValorVenta, 0)) '.ValorVenta
                
            Else  'duda
                .ValorInicioPactoUM = IIf(.MonedaEmision = 13 Or .MonedaEmision = 142 Or .MonedaEmision = 72, Round(.ValorVenta * gsdolar / mvarTipoCambio, decimales), Round(.ValorVenta / mvarTipoCambio, decimales))
                .ValorFinalPactoUM = Round(.ValorInicioPactoUM * (((mvarTasaPacto / (mvarBasePacto * 100#)) * mvarPlazo) + 1), decimales)
                .ValorInicioPactoCLP = .ValorInicioPactoUM

            End If

            If nRegAux = nRegVenta Then
                .ValorFinalPactoUM = ValFinPacto - ValFin_Aux
            End If

            ValFin_Aux = ValFin_Aux + .ValorFinalPactoUM


            mvarValorFinalCLP = mvarValorFinalCLP + (.ValorFinalPactoUM * mvarTipoCambio)
            mvarValorFinalUM = mvarValorFinalUM + .ValorFinalPactoUM
            mvarValorInicialUM = mvarValorInicialUM + .ValorInicioPactoUM

         End If

      End With

   Next iRow
   mvarTotalmargenOP = Round(mvarValorInicialCLP * (Round((mvarPlazo / 365), 4) / (1 + mvarTasaPacto / 100)) * 0.0001, 0)

End Sub

Public Sub NuevoItem()
   Dim objBuffer        As Object
   Set objBuffer = New estVentasFli
   Call oColVentas.Add(objBuffer)
   Set objBuffer = Nothing

End Sub

Public Sub BorrarItem(nPos As Integer)

   oColVentas.Remove nPos

   Call CalcularTotalOperacion

   If oColVentas.Count = 0 Then
      NuevoItem

   End If

End Sub

Public Sub Valorizar(Modal As Integer, nRow As Integer)

   Call ValorizacionVentas(Modal, oColVentas(nRow))
   Call CalcularTotalOperacion

End Sub
Public Sub ValidarInstrumento(sInstSer As String, nRow As Integer)
   Call Chequear_Instrumento(sInstSer, oColVentas(nRow))

End Sub

Public Function ValidarVenta(iRow As Integer) As Boolean
   ValidarVenta = True

   If oColVentas(iRow).InstSer <> "" And Format(oColVentas(iRow).FechaSalida, "YYYYMMDD") < Format(FechaVencimiento, "YYYYMMDD") Then
      MsgBox Trim(oColVentas(iRow).InstSer) & ": Papel con fecha de Disponibilidad menor a la del pacto", vbExclamation, "Validación de la venta"
      ValidarVenta = False

   End If

End Function

Public Function ValidarDatos() As Boolean

   Dim i          As Integer
   Dim sMensaje   As String

   ValidarDatos = False

   sMensaje = ""

  For i = 1 To oColVentas.Count
      If oColVentas(i).InstSer <> "" And Format(oColVentas(i).FecProxCupon, "YYYYMMDD") < Format(FechaVencimiento, "YYYYMMDD") And (oColVentas(i).Marca = "P" Or oColVentas(i).Marca = "V") Then
         sMensaje = sMensaje & Trim(oColVentas(i).InstSer) & ": Fecha de Vencimiento Proximo Cupon Menor a la del pacto" & vbCrLf
      End If
  Next i

   If sMensaje = "" Then
      ValidarDatos = True
   Else
      If (MsgBox(sMensaje & vbCrLf & "Desea Continuar la Operacion? ", vbExclamation + vbYesNo, "Validación de Datos")) = vbYes Then
             gsBac_FecProxC = True
             ValidarDatos = True
       End If
   End If


End Function

Public Sub BorraTodo()

   Dim iitem         As Integer

   For iitem = oColVentas.Count To 1 Step -1
      If oColVentas(iitem).Marca = "V" Or oColVentas(iitem).Marca = "P" Or oColVentas(iitem).Marca = "C" Then
         oColVentas(iitem).Marca = " "

      End If

      oColVentas.Remove iitem

   Next iitem

   Call CalcularTotalOperacion

End Sub

Public Sub Restaurar(nRow As Integer)

   Envia = Array()
   AddParam Envia, oColVentas(nRow).RutCartera
   AddParam Envia, oColVentas(nRow).NumeroDocumento
   AddParam Envia, oColVentas(nRow).Correlativo
   AddParam Envia, oColVentas(nRow).NominalCompra
   AddParam Envia, oColVentas(nRow).Ventana
   AddParam Envia, gsBac_User

   If Not Bac_Sql_Execute("SP_VERBLOQUEO", Envia) Then
      Exit Sub
   End If

   Do While Bac_SQL_Fetch(Datos())
      Select Case Datos(1)
      Case "SI"
         MsgBox "Instrumento está seleccionado en otra ventana", vbInformation, "Bloqueo de Papeles"
         Exit Sub
      End Select
                     
   Loop

   oColVentas(nRow).Marca = " "

   Call CalcularTotalOperacion

End Sub

Public Sub MarcaPapel(nRow As Integer, nVentana As Long)

   
   If Disponibilidad(nRow, nVentana, Modificacion) Then
       oColVentas(nRow).Marca = "V"
       Call CalcularTotalOperacion
    End If
End Sub


Function Disponibilidad(nRow As Integer, nVentana As Long, Optional Modificado As Boolean)

   Disponibilidad = False

   If IsMissing(Modificado) Then
    Modificado = False
   End If

   Envia = Array()
   AddParam Envia, oColVentas(nRow).RutCartera
   AddParam Envia, oColVentas(nRow).NumeroDocumento
   AddParam Envia, oColVentas(nRow).Correlativo
   AddParam Envia, oColVentas(nRow).NominalCompra
   AddParam Envia, oColVentas(nRow).Ventana
   AddParam Envia, gsBac_User

   If Not Bac_Sql_Execute("SP_VERDISPON", Envia) Then
      MsgBox "Problemas al Verificar si el papel esta disponible", vbExclamation, "Venta Con Pacto"
      Exit Function
   End If

   Do While Bac_SQL_Fetch(Datos())
      If Datos(1) = "SI" Then
      ElseIf Datos(1) = "RT" And EstadoFli = False Then
         MsgBox "Instrumento se Encuentra en Reserva Tecnica", vbInformation, gsBac_Version
         
         Exit Function
         
      ElseIf Datos(1) = "VE" And Modificado = False Then
         MsgBox "Instrumento fue Vendido de Cartera", vbInformation, gsBac_Version
         Exit Function

      ElseIf Datos(1) = "MD" Then
   
         If Modificacion = False Then
         Call ModificarValores(nRow, Datos())
         End If
      End If

   Loop
   
   If (oColVentas(nRow).CodigoInstrumento = 4 Or oColVentas(nRow).CodigoInstrumento = 6 Or oColVentas(nRow).CodigoInstrumento = 7 Or oColVentas(nRow).CodigoInstrumento = 300) And DateDiff("D", gsBac_Fecp, CDate(oColVentas(nRow).FecProxCupon)) < 91 Then
'        MsgBox "Instrumento es un Elegible", vbInformation, gsBac_Version
   End If

   Disponibilidad = True
End Function

Public Function ContarMarcados() As Integer

   Dim iCont            As Integer
   Dim iPapeles         As Integer

   iCont = 0

   For iPapeles = 1 To oColVentas.Count
      If oColVentas(iPapeles).Marca = "V" Or oColVentas(iPapeles).Marca = "P" Then
         iCont = iCont + 1

      End If

   Next iPapeles

   ContarMarcados = iCont

End Function

Public Sub Actualiza_Tasa(nRow As Integer, nTir As Double)
   oColVentas(nRow).TirCompra = nTir
End Sub

Public Sub ActualizarDatos(nRow As Integer, nVentana As Long, vDatos As Variant, Optional Modo_Act As String)

   oColVentas(nRow).Ventana = nVentana
   oColVentas(nRow).RutCartera = Val(vDatos(4))
   oColVentas(nRow).TipoCartera = Val(vDatos(5))
   oColVentas(nRow).NumeroDocumento = Val(vDatos(6))
   oColVentas(nRow).Correlativo = Val(vDatos(7))
   oColVentas(nRow).TipoOperacion = vDatos(10)
   oColVentas(nRow).Serie = vDatos(11)
   oColVentas(nRow).InstSer = vDatos(12)
   oColVentas(nRow).NemoEmisor = vDatos(13)
   oColVentas(nRow).NemoMoneda = vDatos(14)
   oColVentas(nRow).NominalCompra = CDbl(vDatos(15))
   oColVentas(nRow).TirCompra = CDbl(vDatos(16))
   oColVentas(nRow).PVPCompra = CDbl(vDatos(17))
   oColVentas(nRow).ValorCompra = CDbl(vDatos(18))
   oColVentas(nRow).VParVenta = 0#
   oColVentas(nRow).ValorVenta100 = 0#
   oColVentas(nRow).PVPMcdo = CDbl(vDatos(19))
   oColVentas(nRow).TirMcdo = CDbl(vDatos(20))
   oColVentas(nRow).MTMcdo = CDbl(vDatos(22))
   oColVentas(nRow).FechaSalida = vDatos(24)
   oColVentas(nRow).NumUltCup = Val(vDatos(25))
 ' Datos necesarios para la valorización
   oColVentas(nRow).CodigoInstrumento = Val(vDatos(32))
   oColVentas(nRow).Mascara = vDatos(33)
   oColVentas(nRow).TasaEstimada = CDbl(vDatos(34))
   ' Datos de Emision
   oColVentas(nRow).RutEmisor = Val(IIf(IsNull(vDatos(35)), 0, vDatos(35)))
   oColVentas(nRow).MonedaEmision = Val(IIf(IsNull(vDatos(36)), 0, vDatos(36)))
   oColVentas(nRow).TasaEmision = CDbl(IIf(IsNull(vDatos(37)), 0, vDatos(37)))
   oColVentas(nRow).BaseEmision = Val(IIf(IsNull(vDatos(38)), 0, vDatos(38)))
   oColVentas(nRow).FechaEmision = vDatos(39)
   oColVentas(nRow).FechaVencimiento = vDatos(40)
   oColVentas(nRow).FecProxCupon = vDatos(41)
   If Tipo_Pago_total = True Then
      oColVentas(nRow).Marca = IIf(vDatos(42) = "", ".", "V")
   Else
      oColVentas(nRow).Marca = IIf(vDatos(42) = "", ".", vDatos(42))
   End If
   
   oColVentas(nRow).DiasDisponibles = Val(vDatos(43))
   oColVentas(nRow).CustodiaOrig = vDatos(44)

   Select Case Trim(vDatos(44))
      Case "C"
         oColVentas(nRow).CustodiaOrig = "CLIENTE"
      Case "D"
         oColVentas(nRow).CustodiaOrig = "DCV"
      Case Else
         oColVentas(nRow).CustodiaOrig = "FISICA"
   End Select

   oColVentas(nRow).seriado = vDatos(45)
   oColVentas(nRow).Convexidad = vDatos(46)
   oColVentas(nRow).DurationMacaulay = vDatos(47)
   oColVentas(nRow).DurationModificado = vDatos(48)
   oColVentas(nRow).CarteraSuper = IIf(IsNull(vDatos(49)), "", vDatos(49))
   oColVentas(nRow).ClaveDCV = vDatos(50)
   
   If UBound(vDatos) > 50 Then ' se rescata Nuevos Campos
      oColVentas(nRow).Margen = vDatos(51)
      oColVentas(nRow).ValorInicial = vDatos(52)
   End If
   If TipoCarga = "A" Then
      oColVentas(nRow).Corr_SOMA = Correlativo_SOMA
      oColVentas(nRow).NumOper_SOMA = NumOper_SOMA
   End If

End Sub

Private Sub ModificarValores(nRow As Integer, vDatos() As Variant)

   With oColVentas(nRow)
      .NominalCompra = Val(vDatos(15))
      .TirCompra = Val(vDatos(16))
      .PVPCompra = Val(vDatos(17))
      .VParCompra = 0#
      .ValorCompra = Val(vDatos(18))
      .NominalVenta = Val(vDatos(15))
      .TirVenta = Val(vDatos(16))
      .PVPVenta = Val(vDatos(17))
      .VParVenta = 0#
      .ValorVenta = Val(vDatos(18))
      .PVPMcdo = Val(vDatos(19))
      .TirMcdo = Val(vDatos(20))
      .MTMcdo = Val(vDatos(22))
   End With

End Sub

Private Sub CalcularProximoDiaHabil()

   Dim nSw              As Integer
   Dim nCont            As Integer

   mvarFechaVencimiento = DateAdd("D", 1, mvarFechaInicio)

   nCont = 0

   Do While nSw = 0
      If EsFeriado(CDate(mvarFechaVencimiento), "00001") Then
         nCont = nCont + 1
         mvarFechaVencimiento = Format$(DateAdd("d", 1, mvarFechaVencimiento), "dd/mm/yyyy")
      Else
         nSw = 1
      End If
   Loop
   mvarPlazo = DateDiff("D", mvarFechaInicio, mvarFechaVencimiento)
End Sub

Function RecalcularPapelesPagos(nTotal As Double, Nemotecnico As String, nTotalOrig As Double) As Boolean
   Dim iitem         As Integer
   Dim nTotalOper    As Double
   Dim nFactor       As Double
   Dim nDiferencia   As Double
   Dim nUltReg       As Integer
   
   RecalcularPapelesPagos = False
 
   nDiferencia = nTotal - nTotalOrig
   nTotalOper = nTotalOrig

   If nTotalOper = 0 Then
      Exit Function
   End If

   mvarTotalOperacion = 0
   nUltReg = 0

   For iitem = 1 To oColVentas.Count
      If oColVentas(iitem).Marca = "V" Or oColVentas(iitem).Marca = "P" Then
         If oColVentas(iitem).FliModificado = "M" Then
            nFactor = oColVentas(iitem).ValorVenta / nTotalOper
            oColVentas(iitem).ValorVenta = Round(oColVentas(iitem).ValorVenta + (nDiferencia * nFactor), 0)
            Call Valorizar(3, iitem)
            nUltReg = iitem
         End If

      End If

   Next iitem

   RecalcularPapelesPagos = True
End Function

Public Sub AsignaCortes(nRow As Integer, oControl As Object)

   Dim iitem         As Integer
   Dim dCortes       As Double

   dCortes = 0

   With oColVentas(nRow)
      Call oControl.RemoveTodo(1)

      For iitem = 1 To .oColCortes.Count
         oControl.NuevoItem
         oControl.oColCortes(iitem).MtoCort = .oColCortes(iitem).MtoCort
         oControl.oColCortes(iitem).CantCortD = .oColCortes(iitem).CantCortD
         oControl.oColCortes(iitem).CantCortV = .oColCortes(iitem).CantCortV

         If oControl.oColCortes(iitem).CantCortV > 0 Then
            dCortes = dCortes + oControl.oColCortes(iitem).MtoCort * oControl.oColCortes(iitem).CantCortV

         End If

      Next iitem

   End With

   oControl.Serie = oColVentas(nRow).InstSer
   oControl.Moneda = oColVentas(nRow).NemoMoneda
   oControl.NominalOper = oColVentas(nRow).NominalCompra
   oControl.TipOper = TipoOperacion
'   oControl.Nominal = dCortes


End Sub

Public Sub GrabarCortes(nRow As Integer, oControl As Object)

   Dim iitem         As Integer
   Dim objBuffer     As New estCortes
   Dim nNominal      As Double

   With oColVentas(nRow)
      For iitem = .oColCortes.Count To 1 Step -1
         .oColCortes.Remove iitem

      Next iitem

      nNominal = 0

      For iitem = 1 To oControl.oColCortes.Count
         Set objBuffer = New estCortes

         objBuffer.MtoCort = oControl.oColCortes(iitem).MtoCort
         objBuffer.CantCortD = oControl.oColCortes(iitem).CantCortD
         objBuffer.CantCortV = oControl.oColCortes(iitem).CantCortV

         nNominal = nNominal + objBuffer.MtoCort * objBuffer.CantCortV

         .oColCortes.Add objBuffer

      Next iitem

      .NominalVenta = nNominal

   End With

   Set objBuffer = Nothing

End Sub
Public Function Grabar(objdatosoperacion As colOperaciones) As Boolean
   On Error GoTo GrabarTxError

   Dim dTipoCambio988         As Double
   Dim FlagTx                 As Boolean
   Dim dNumdocu               As Double
   Dim iCorrela               As Integer
   Dim xCorrela               As Integer
   Dim hcorrela               As Integer
   Dim iCortes                As Integer
   Dim Datos()
   Dim iCountVentas           As Integer
   Dim Icopias                As Integer
   Dim cExcesoOP              As String
   Dim sMensajeLineaOP        As String
   Dim nMontoMargenOpSaldo    As Double
   Dim nMontoMargenOpPapel    As Double
   Dim Mensaje_Lin     As String
   Dim Mensaje_Lim     As String

   Mensaje_Lin = ""
   Mensaje_Lim = ""
         
   Grabar = False
   Cargo = False

   FlagTx = False
   If Not Bac_Sql_Execute("BEGIN TRANSACTION") Then
       GoTo GrabarTxError:
   End If
   FlagTx = True

   If Modificacion = True Then
        dNumdocu = gsNmoper_Fli
   Else
        If Not Bac_Sql_Execute("SP_OPMDAC") Then
            GoTo GrabarTxError:
        End If
        If Bac_SQL_Fetch(Datos()) Then
            dNumdocu = Val(Datos(1))
        End If
    End If
    
   If BacGrabar.TipOper = "FLI" Then
    'NOTA el FLI no consume línea IDD solo graba flujo en caso de reparo operacion
      If Modificacion = True And Tipo_Pago_parcial = False And Tipo_Pago_total = False Then
         Call Func_Anular_Datos(gsNmoper_Fli, "M")
         If gsBac_Lineas = "S" Then
               If Not Lineas_Anular("BTR", dNumdocu) Then
               End If
         End If
      End If
   End If
   
'------------------------------
iCountVentas = 0
For iCorrela = 1 To oColVentas.Count
   If Trim$(oColVentas(iCorrela).InstSer) <> "" And _
           (oColVentas(iCorrela).Marca = "P" Or _
            oColVentas(iCorrela).Marca = "V") Then
      iCountVentas = iCountVentas + 1
   End If
Next

'---------------------------------------
   xCorrela = 0
   ' Para cada linea de compra llamo al SP_GRABARVI

   For iCorrela = 1 To oColVentas.Count
      With oColVentas(iCorrela)
         
         If Trim$(.InstSer) <> "" And (.Marca = "P" Or .Marca = "V") Then
            xCorrela = xCorrela + 1
         If xCorrela = iCountVentas Then
            nMontoMargenOpPapel = nMontoMargenOpSaldo
         Else
            nMontoMargenOpPapel = Round((.ValorVenta / TotalOperacion) * TotalMargenOP, 0)
            nMontoMargenOpSaldo = nMontoMargenOpSaldo - nMontoMargenOpPapel
         End If

                Envia = Array()
                AddParam Envia, dNumdocu
                AddParam Envia, objdatosoperacion.Rutcart
                AddParam Envia, Val(objdatosoperacion.TipCart)
            
               AddParam Envia, oColVentas(iCorrela).NumeroDocumento
               AddParam Envia, oColVentas(iCorrela).Correlativo
               AddParam Envia, oColVentas(iCorrela).NominalVenta
               AddParam Envia, oColVentas(iCorrela).TirVenta
               AddParam Envia, oColVentas(iCorrela).PVPVenta
               AddParam Envia, oColVentas(iCorrela).ValorVenta
               AddParam Envia, oColVentas(iCorrela).ValorVenta100
               AddParam Envia, oColVentas(iCorrela).TasaEstimada
               AddParam Envia, oColVentas(iCorrela).VParVenta
               AddParam Envia, oColVentas(iCorrela).NumUltCup
            
                AddParam Envia, objdatosoperacion.RutCliente
                AddParam Envia, objdatosoperacion.CodCliente
                AddParam Envia, objdatosoperacion.custodia
                AddParam Envia, objdatosoperacion.ForPagoIni
                AddParam Envia, objdatosoperacion.ForPagoVcto
                AddParam Envia, objdatosoperacion.VamosVienen
                AddParam Envia, gsUsuario
                AddParam Envia, gsBac_Term
            
               'Datos del Pacto
                AddParam Envia, Format(FechaVencimiento, "YYYYMMDD")
                AddParam Envia, MonedaPacto
                AddParam Envia, TasaPacto
                AddParam Envia, BasePacto
            AddParam Envia, oColVentas(iCorrela).ValorInicioPactoCLP
            AddParam Envia, oColVentas(iCorrela).ValorFinalPactoUM
            
            '----------------------------------------------
            AddParam Envia, oColVentas(iCorrela).InstSer
            AddParam Envia, oColVentas(iCorrela).RutEmisor
            AddParam Envia, oColVentas(iCorrela).MonedaEmision
            AddParam Envia, Format(oColVentas(iCorrela).FechaEmision, "YYYYMMDD")
            AddParam Envia, Format(oColVentas(iCorrela).FechaVencimiento, "YYYYMMDD")
            AddParam Envia, xCorrela
            AddParam Envia, Format(oColVentas(iCorrela).FecProxCupon, "YYYYMMDD")
            AddParam Envia, oColVentas(iCorrela).Convexidad
            AddParam Envia, oColVentas(iCorrela).DurationModificado
            AddParam Envia, oColVentas(iCorrela).DurationMacaulay
            AddParam Envia, oColVentas(iCorrela).custodia
            AddParam Envia, oColVentas(iCorrela).ClaveDCV
            AddParam Envia, 0                               ' dTPFE dTotLim_PFE
            AddParam Envia, 0                               ' dTCCE dTotLim_CCE
            AddParam Envia, oColVentas(iCorrela).CarteraSuper
            AddParam Envia, objdatosoperacion.TipCart
            AddParam Envia, objdatosoperacion.Mercado
            AddParam Envia, objdatosoperacion.Sucursal
            AddParam Envia, objdatosoperacion.AreaResponsable
            AddParam Envia, objdatosoperacion.Fecha_PagoMañana
            AddParam Envia, objdatosoperacion.Laminas
            AddParam Envia, objdatosoperacion.Tipo_Inversion
            AddParam Envia, objdatosoperacion.CtaCteInicio
            AddParam Envia, objdatosoperacion.SucInicio
            AddParam Envia, objdatosoperacion.CtaCteFinal
            AddParam Envia, objdatosoperacion.SucFinal
            AddParam Envia, objdatosoperacion.Observ
            AddParam Envia, oColVentas(iCorrela).DiasDisponibles
            AddParam Envia, oColVentas(iCorrela).Margen
            AddParam Envia, oColVentas(iCorrela).ValorInicial
            If TipoCarga = "A" Then
               AddParam Envia, oColVentas(iCorrela).Corr_SOMA
               AddParam Envia, oColVentas(iCorrela).NumOper_SOMA
            End If
                If Not Bac_Sql_Execute("SP_GRABARFLI", Envia) Then
                    GoTo GrabarTxError:
                End If
            
                For iCortes = 1 To .oColCortes.Count
                     Sql = "EXECUTE SP_VTCORTESPARCIAL " & Chr(10)
                     Sql = Sql & .RutCartera & "," & Chr(10)
                     Sql = Sql & .NumeroDocumento & "," & Chr(10)
                     Sql = Sql & .Correlativo & "," & Chr(10)
                     Sql = Sql & dNumdocu & "," & Chr(10)
                     Sql = Sql & BacFormatoSQL(.oColCortes(iCortes).CantCortV) & "," & Chr(10)
                     Sql = Sql & BacFormatoSQL(.oColCortes(iCortes).MtoCort)
                     If miSQL.SQL_Execute(Sql) <> 0 Then
                        GoTo GrabarTxError
                     End If
                Next iCortes
    
         End If
      End With
    Next iCorrela

'-----------------------------------------
  If gsBac_Lineas = "S" Then
        Dim Mensaje     As String

        Mensaje = ""
        xCorrela = 0
   
        For iCorrela = 1 To oColVentas.Count
            With oColVentas(iCorrela)
        
            If Trim$(.InstSer) <> "" And (.Marca = "P" Or .Marca = "V") Then
               xCorrela = xCorrela + 1
               
                Envia = Array()
                AddParam Envia, dNumdocu
                AddParam Envia, .NumeroDocumento
                AddParam Envia, .Correlativo
                AddParam Envia, xCorrela
                AddParam Envia, objdatosoperacion.RutCliente
                AddParam Envia, objdatosoperacion.CodCliente
                AddParam Envia, gsUsuario
                AddParam Envia, gsBac_Fecp
                AddParam Envia, Format(.FechaVencimiento, "YYYYMMDD")
                AddParam Envia, Round(.ValorVenta, 0)
                
               If Not Bac_Sql_Execute("SP_LINEAS_FLI", Envia) Then
                   GoTo GrabarTxError:
               End If
            
            End If

            End With

        Next iCorrela
                     
        
    End If
    
  
'-----------------------------------------

   
    If Not Bac_Sql_Execute("COMMIT TRANSACTION") Then
        GoTo GrabarTxError:
    End If
  
 
' --- Impresiones ---

  '   Call ImprimePapeleta(objdatosoperacion.Rutcart, Str(dNumdocu), TipoOperacion, "N", objdatosoperacion.RutCliente)
  
  '---- imprimir contrato ----
  '  Busca Numero de Copias

   MsgBox "Operación fue grabada con éxito " & vbCrLf & vbCrLf & "Número de Operación: " & dNumdocu, vbInformation, gsBac_Version

   Grabar = True

   On Error GoTo 0

   Exit Function

GrabarTxError:
   MsgBox "NO SE COMPLETO LA GRABACION DE FLI CON EXITO", 48, "MENSAJE"
   Grabar = False

   If FlagTx = True Then
      If Not Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
         MsgBox "No se pudo realizar devolución de transacción inicializada", vbCritical, gsBac_Version
      End If

   End If

   On Error GoTo 0

   Exit Function

End Function

   Public Function GRABAR_PAGOS(objdatosoperacion As colOperaciones, Numoper As Double) As Boolean
 
   On Error GoTo GrabarTxError

   Dim dTipoCambio988         As Double
   Dim FlagTx                 As Boolean
   Dim dNumdocu               As Integer
   Dim iCorrela               As Integer
   Dim xCorrela               As Integer
   Dim iCortes                As Integer
   Dim Datos()
   Dim iCountVentas           As Integer
   Dim Icopias                As Integer
   Dim cExcesoOP              As String
   Dim sMensajeLineaOP        As String
   Dim nMontoMargenOpSaldo    As Double
   Dim nMontoMargenOpPapel    As Double
   Dim NumeroDocumento        As Double
   Dim Correlativo            As Double

   
   GRABAR_PAGOS = False
   
   FlagTx = False

      Envia = Array()
   AddParam Envia, CDbl(Numoper)
   If Not Bac_Sql_Execute("SP_BUSCA_NUM_OPER_PAGOS", Envia) Then
       GoTo GrabarTxError:
   End If
    If Bac_SQL_Fetch(Datos()) Then
        dNumdocu = Val(Datos(1))
    End If
   
iCountVentas = 0

For iCorrela = 1 To oColVentas.Count
   If Trim$(oColVentas(iCorrela).InstSer) <> "" And _
           (oColVentas(iCorrela).Marca = "P" Or _
            oColVentas(iCorrela).Marca = "V") Then
      iCountVentas = iCountVentas + 1
   End If
   Next iCorrela

'----------------------------------
'Graba en Tabla de Pagos
'----------------------------------
xCorrela = 0
   For iCorrela = 1 To oColVentas.Count
      With oColVentas(iCorrela)
      
      If Trim$(oColVentas(iCorrela).InstSer) <> "" And _
           (oColVentas(iCorrela).Marca = "P" Or _
            oColVentas(iCorrela).Marca = "V") Then
   
         ' Verifica que el registro esté con datos
            xCorrela = xCorrela + 1
            
            Envia = Array()
            AddParam Envia, objdatosoperacion.Rutcart
            AddParam Envia, Numoper
            AddParam Envia, oColVentas(iCorrela).NumeroDocumento
            AddParam Envia, oColVentas(iCorrela).Correlativo
            AddParam Envia, dNumdocu
            AddParam Envia, oColVentas(iCorrela).NominalVenta
            AddParam Envia, oColVentas(iCorrela).ValorVenta
            AddParam Envia, gsUsuario
            AddParam Envia, gsBac_Term
            AddParam Envia, oColVentas(iCorrela).InstSer
            If Tipo_Pago_total = True Then
               AddParam Envia, "S"
            Else
                AddParam Envia, IIf((oColVentas(iCorrela).Marca = "P" Or oColVentas(iCorrela).Marca = "V"), "S", "P")
            End If
            AddParam Envia, oColVentas(iCorrela).TirVenta
            AddParam Envia, oColVentas(iCorrela).PVPVenta
            If Not Bac_Sql_Execute("SP_GRABARPAGOS", Envia) Then
               GoTo GrabarTxError:
            End If
            
            For iCortes = 1 To oColVentas(iCorrela).oColCortes.Count
                    Sql = ""
                    Sql = "EXECUTE SP_VTCORTESPARCIAL_PAGOSFLI " & Chr(10)
                    Sql = Sql & .RutCartera & "," & Chr(10)
                    Sql = Sql & .NumeroDocumento & "," & Chr(10)
                    Sql = Sql & .Correlativo & "," & Chr(10)
                    Sql = Sql & Numoper & "," & Chr(10)
                    Sql = Sql & BacFormatoSQL(.oColCortes(iCortes).CantCortV) & "," & Chr(10)
                    Sql = Sql & BacFormatoSQL(.oColCortes(iCortes).MtoCort) & "," & Chr(10)
                    If Tipo_Pago_total = True Then
                      Sql = Sql & "P" & "," & Chr(10)
                    Else
                  Sql = Sql & IIf((oColVentas(iCorrela).Marca = "P" Or oColVentas(iCorrela).Marca = "V"), "S", "P") & "," & Chr(10)
                    End If
                    Sql = Sql & dNumdocu
                    If miSQL.SQL_Execute(Sql) <> 0 Then
                       GoTo GrabarTxError
                    End If
                Next iCortes
      End If
      End With
    Next iCorrela

   xCorrela = 0
   
   For iCorrela = 1 To oColVentas.Count
      With oColVentas(iCorrela)
         If Trim$(oColVentas(iCorrela).InstSer) <> "" And (oColVentas(iCorrela).Marca = "P" Or oColVentas(iCorrela).Marca = "V") Then
            xCorrela = xCorrela + 1
            If xCorrela = iCountVentas Then
               nMontoMargenOpPapel = nMontoMargenOpSaldo
            Else
               nMontoMargenOpPapel = Round((.ValorVenta / TotalOperacion) * TotalMargenOP, 0)
               nMontoMargenOpSaldo = nMontoMargenOpSaldo - nMontoMargenOpPapel
            End If

            Envia = Array()
            AddParam Envia, Val(Numoper)
            AddParam Envia, objdatosoperacion.Rutcart
            AddParam Envia, Val(objdatosoperacion.TipCart)
            AddParam Envia, .NumeroDocumento
            AddParam Envia, .Correlativo
            AddParam Envia, .NominalVenta
            AddParam Envia, .TirVenta
            AddParam Envia, .PVPVenta
            AddParam Envia, .ValorVenta
            AddParam Envia, .ValorVenta100
            AddParam Envia, .TasaEstimada
            AddParam Envia, .VParVenta
            AddParam Envia, .NumUltCup
            AddParam Envia, objdatosoperacion.RutCliente
            AddParam Envia, objdatosoperacion.CodCliente
            AddParam Envia, objdatosoperacion.custodia
            AddParam Envia, objdatosoperacion.ForPagoIni
            AddParam Envia, objdatosoperacion.ForPagoVcto
            AddParam Envia, objdatosoperacion.VamosVienen
            AddParam Envia, gsUsuario
            AddParam Envia, gsBac_Term
            'Datos del Pacto
            AddParam Envia, Format(FechaVencimiento, "YYYYMMDD")
            AddParam Envia, MonedaPacto
            AddParam Envia, TasaPacto
            AddParam Envia, BasePacto
            AddParam Envia, .ValorInicioPactoCLP
            AddParam Envia, .ValorFinalPactoUM
            '----------------------------------------------
            AddParam Envia, .InstSer
            AddParam Envia, .RutEmisor
            AddParam Envia, .MonedaEmision
            AddParam Envia, Format(.FechaEmision, "YYYYMMDD")
            AddParam Envia, Format(.FechaVencimiento, "YYYYMMDD")
            AddParam Envia, xCorrela
            AddParam Envia, Format(.FecProxCupon, "YYYYMMDD")
            AddParam Envia, .Convexidad
            AddParam Envia, .DurationModificado
            AddParam Envia, .DurationMacaulay
            AddParam Envia, .custodia
            AddParam Envia, oColVentas(iCorrela).ClaveDCV
            AddParam Envia, 0                               ' dTPFE dTotLim_PFE
            AddParam Envia, 0                               ' dTCCE dTotLim_CCE
            AddParam Envia, .CarteraSuper
            AddParam Envia, ""
            AddParam Envia, objdatosoperacion.Mercado
            AddParam Envia, objdatosoperacion.Sucursal
            AddParam Envia, objdatosoperacion.AreaResponsable
            AddParam Envia, objdatosoperacion.Fecha_PagoMañana
            AddParam Envia, objdatosoperacion.Laminas
            AddParam Envia, objdatosoperacion.Tipo_Inversion
            AddParam Envia, objdatosoperacion.CtaCteInicio
            AddParam Envia, objdatosoperacion.SucInicio
            AddParam Envia, objdatosoperacion.CtaCteFinal
            AddParam Envia, objdatosoperacion.SucFinal
            AddParam Envia, objdatosoperacion.Observ
            If Not Bac_Sql_Execute("SP_GRABARFLI_PAGOS_II", Envia) Then
               GoTo GrabarTxError:
            End If
            For iCortes = 1 To oColVentas(iCorrela).oColCortes.Count
                Sql = "EXECUTE SP_VTCORTESPARCIAL_PAGOS " & Chr(10)
                Sql = Sql & .RutCartera & "," & Chr(10)
                Sql = Sql & .NumeroDocumento & "," & Chr(10)
                Sql = Sql & .Correlativo & "," & Chr(10)
                Sql = Sql & Val(Numoper) & "," & Chr(10)
                Sql = Sql & BacFormatoSQL(.oColCortes(iCortes).CantCortV) & "," & Chr(10)
                Sql = Sql & BacFormatoSQL(.oColCortes(iCortes).MtoCort) '
                If miSQL.SQL_Execute(Sql) <> 0 Then
                   GoTo GrabarTxError
                End If
            Next iCortes
         End If
      End With
    Next iCorrela

   MsgBox "Operación fue grabada con éxito " & vbCrLf & vbCrLf & "Número de Operación: " & Numoper & "   Número de Pago :" & dNumdocu, vbInformation, gsBac_Version

   GRABAR_PAGOS = True

   On Error GoTo 0

   Exit Function

GrabarTxError:
        MsgBox "Se ha producido un problema en la grabación de la operación FLI: " & err.Description & ". Comunique al Administrador. ", vbCritical, gsBac_Version


   If FlagTx = True Then
      If Not Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
         MsgBox "No se pudo realizar devolución de transacción inicializada", vbCritical, gsBac_Version
      End If

   End If

   On Error GoTo 0

   Exit Function

 
 End Function

Private Sub Func_Anular_Datos(Numero As Double, Estado As String)
   
    Dim Msg              As String
    Dim dNumdocu#
    Dim i%
    Dim NumctaCte As String
    Dim MontoCta As Double
    Dim Datos()
    Dim Sql
    
   Screen.MousePointer = 11
     
    dNumdocu# = gsNmoper_Fli
    NumeroOperacionExceso = dNumdocu#
       
                          
    Sql = "EXECUTE SP_LLAMAPROCESO " & Val(NumeroOperacionExceso) & ",'" & BacGrabar.TipOper & "'," & gsBac_CartRUT & ",'" & "M" & "'"
    
    If miSQL.SQL_Execute(Sql) <> 0 Then
       MsgBox "Problemas con la lectura de la clasificación de riesgos", vbCritical, gsBac_Version
       Exit Sub
    
    End If


    If miSQL.SQL_Fetch(Datos()) <> 0 Then
       MsgBox "Error en anulación", vbCritical, gsBac_Version
       Exit Sub
    End If
    
    If Datos(1) = "NO" Then
       MsgBox Datos(2), vbCritical, vbCritical, gsBac_Version
       Exit Sub
    End If
    
    If Estado = "A" Then
       MsgBox "Operacion " & NumeroOperacionExceso & " Anulada Correctamente", vbInformation, gsBac_Version
    End If
      
End Sub
Public Property Let CodCliente(nCodCliente As Long)

   mvarCodCliente = nCodCliente

End Property

Public Property Get CodCliente() As Long

   CodCliente = mvarCodCliente

End Property

Public Property Let RutCliente(nRutCliente As Long)
   mvarRutCliente = nRutCliente
End Property

Public Property Get RutCliente() As Long
   RutCliente = mvarRutCliente
End Property

Public Property Get TotalMargenOP() As Double

   TotalMargenOP = mvarTotalmargenOP

End Property

Private Sub Class_Terminate()

   Call BorraTodo

End Sub

Public Function calcularCostoFondo(strFechaProceso As String, Intdias As Integer, intCodMonedaCompra As Integer) As String

    Sql = "SP_CALCULA_COSTOFONDO '" & strFechaProceso & "'," & Intdias & "," & intCodMonedaCompra & ""
    If Not Bac_Sql_Execute(Sql) Then
        mvarCostofondo = 0
        MsgBox "Imposible calcular el costo de fondo", vbCritical, gsBac_Version
    Else
        Do While Bac_SQL_Fetch(Datos())
            mvarCostofondo = Datos(1)
            calcularCostoFondo = Datos(1)
'            gblCostoFondoInicial = mvarCostofondo
            
        Loop
    End If

End Function

Public Property Get costoFondo() As String

    costoFondo = mvarCostofondo 'gblCostoFondoInicial

End Property

Public Property Let costoFondo(lngCostoFondoVentasconPacto As String)

    mvarCostofondo = lngCostoFondoVentasconPacto

End Property

Public Property Let CodOrigen(nCodOrigen As Integer)

   mVarCodOrigen = nCodOrigen

End Property

Public Property Let CodEjecutivo(nCodEjecutivo As String)

   mVarCodEjecutivo = nCodEjecutivo

End Property

Public Property Get CodOrigen() As Integer

   CodOrigen = mVarCodOrigen

End Property

Public Property Get CodEjecutivo() As String

   CodEjecutivo = mVarCodEjecutivo

End Property


Public Property Let CodDestino(nCodDestino As Integer)

   mVarCodDestino = nCodDestino

End Property

Public Property Get CodDestino() As Integer
   
   CodDestino = mVarCodDestino

End Property

Public Sub RecalcularPapeles(nTotal As Double)

   Dim iitem         As Integer
   Dim nTotalOper    As Double
   Dim nFactor       As Double
   Dim nDiferencia   As Double
   Dim nUltReg       As Integer

   nDiferencia = nTotal - mvarTotalOperacion
   nTotalOper = mvarTotalOperacion

   If nTotalOper = 0 Then
      Exit Sub
   End If

   mvarTotalOperacion = 0
   nUltReg = 0

   For iitem = 1 To oColVentas.Count
      If oColVentas(iitem).Marca = "V" Or oColVentas(iitem).Marca = "P" Then
         nFactor = oColVentas(iitem).ValorVenta / nTotalOper
         oColVentas(iitem).ValorVenta = Round(oColVentas(iitem).ValorVenta + (nDiferencia * nFactor), 0)
         Call Valorizar(3, iitem)
         nUltReg = iitem

      End If

   Next iitem

   If mvarTotalOperacion <> nTotal And nUltReg > 0 Then
      oColVentas(nUltReg).ValorVenta = oColVentas(nUltReg).ValorVenta + (nTotal - mvarTotalOperacion)

      Call Valorizar(3, nUltReg)

   End If

End Sub

