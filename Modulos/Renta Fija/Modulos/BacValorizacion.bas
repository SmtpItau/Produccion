Attribute VB_Name = "Valorizador"
Option Explicit

Dim Sql                    As String
Dim Datos()
Public Sub Valorizacion(ModCal As Integer, objOperacion As Object)

On Error GoTo BacErrorHandler

Dim nEmisor As Double

'Datos de Input
Dim Ent As BacValorizaInput

'Datos de Output
Dim Sal As BacValorizaOutput

Screen.MousePointer = 11

With Ent
   .ModCal = ModCal
 
' If gsBac_TipoCartera = 0 Then
   .FecCal = Format$(gsBac_Fecp, "yyyymmdd")
' Else
'   .FecCal = Format$(gsBac_Feca, "yyyymmdd")
' End If
 
   .Codigo = objOperacion.CodigoInstrumento
   .Mascara = objOperacion.InstSer
   .Nominal = objOperacion.Nominal
   .tir = objOperacion.tir
   .Pvp = objOperacion.Pvp
   .Mt = objOperacion.Mt
   .TasEst = objOperacion.TasEstimada
   .MonEmi = objOperacion.MonEmis
   .fecemi = Format(objOperacion.FecEmis, "yyyymmdd")
   .FecVen = Format(objOperacion.FecVcto, "yyyymmdd")
   .TasEmi = objOperacion.TasEmis
   .BasEmi = objOperacion.BasEmis
   nEmisor = objOperacion.RutEmis
  

End With

If Valorizar_Papel(Ent, Sal) = True Then
   With objOperacion
                 .Nominal = Sal.Nominal
                     .tir = Format$(Sal.tir, "###0.0000")
                     .Pvp = Format$(Sal.Pvp, "###0.0000")
                    .Vpar = Format$(Sal.Vpar, "###0.0000")
                      .Mt = Sal.Mt
                   .Mt100 = Sal.Mt100
                 .Numucup = Sal.Numucup
            .FecProxCupon = Sal.Fecpcup
             .FecUltCupon = Sal.Fecucup
                 .TirMcdo = Sal.tir
                 .PVPMcdo = Sal.Pvp
                  .MTMcdo = Sal.Mt
               .MTMcdo100 = Sal.Mt100
        .DurationMacaulay = Sal.duratmac
      .DurationModificado = Sal.duratmod
              .Convexidad = Sal.convexid
             '.TasEstNew = Sal.TasEstNew
             '.TasEmiNew = Sal.TasEmiNew
      
        If .MtValorizador = 0 Then
           .MtValorizador = Sal.Mt
        End If
        
   End With

End If

Screen.MousePointer = 0

Exit Sub

'-------------------------------------------------------

BacErrorHandler:

Screen.MousePointer = 0

If err <> 0 Then
   MsgBox error(err), vbCritical, "Error"

End If

End Sub

Public Sub ValorizacionVentas(ModCal As Integer, objOperacion As Object)

On Error GoTo BacErrorHandler

Dim nEmisor As Double

'Datos de Input
Dim Ent As BacValorizaInput

'Datos de Output
Dim Sal As BacValorizaOutput

Screen.MousePointer = 11

With Ent

     .ModCal = ModCal
     .FecCal = Format$(gsBac_Fecp, "yyyymmdd")
     .Codigo = objOperacion.CodigoInstrumento
    .Mascara = objOperacion.InstSer
    .Nominal = objOperacion.NominalVenta
        .tir = objOperacion.TirVenta
        .Pvp = objOperacion.VParVenta
         .Mt = objOperacion.ValorVenta
     .TasEst = objOperacion.TasaEstimada
     .MonEmi = objOperacion.MonedaEmision
     .fecemi = Format(objOperacion.FechaEmision, "yyyymmdd")
     .FecVen = Format(objOperacion.FechaVencimiento, "yyyymmdd")
     .TasEmi = objOperacion.TasaEmision
     .BasEmi = objOperacion.BaseEmision
     nEmisor = objOperacion.RutEmisor

 End With

 If Valorizar_Papel(Ent, Sal) = True Then
 
    With objOperacion
    
               .TirVenta = Format$(Sal.tir, "###0.0000")
               .PVPVenta = Format$(Sal.Pvp, "###0.0000")
              .VParVenta = Format$(Sal.Vpar, "###0.0000")
             .ValorVenta = Sal.Mt
          .ValorVenta100 = Sal.Mt100
              .NumUltCup = Sal.Numucup
           .FecProxCupon = Sal.Fecpcup
                .TirMcdo = Sal.tir
                .PVPMcdo = Sal.Pvp
                 .MTMcdo = Sal.Mt
              .MTMcdo100 = Sal.Mt100
       .DurationMacaulay = Sal.duratmac
     .DurationModificado = Sal.duratmod
             .Convexidad = Sal.convexid
   
       If .MtValorizador = 0 Then
          .MtValorizador = Sal.Mt
       End If
   
       
    End With

 End If

Screen.MousePointer = 0

Exit Sub

'-----------------------------------------------------------

BacErrorHandler:

Screen.MousePointer = 0

If err <> 0 Then
    MsgBox error(err), vbCritical, "Error"
End If

End Sub

Public Function Valorizar_Papel(ByRef Ent As BacValorizaInput, ByRef Sal As BacValorizaOutput)

   'Rutina que valoriza tanto para las compras como para las ventas
   On Error GoTo ValorizarError

   Dim nError%

   Valorizar_Papel = False

   Screen.MousePointer = 11

   If Ent.Nominal# = 0 Then
      Screen.MousePointer = 0
      Exit Function
   End If

   If Trim(Ent.Mascara$) = "" Then
      Screen.MousePointer = 0
      Exit Function
   End If

   Sql = "EXECUTE SP_VALORIZAR_CLIENT " & Chr$(10)
   Sql = Sql & Ent.ModCal% & "," & Chr$(10)
   Sql = Sql & "'" & Ent.FecCal$ & "'," & Chr$(10)
   Sql = Sql & Ent.Codigo& & "," & Chr$(10)
   Sql = Sql & "'" & Ent.Mascara$ & "'," & Chr$(10)
   Sql = Sql & BacFormatoSQL(Ent.MonEmi) & "," & Chr$(10)
   Sql = Sql & "'" & Ent.fecemi & "'," & Chr$(10)
   Sql = Sql & "'" & Ent.FecVen & "'," & Chr$(10)
   Sql = Sql & BacFormatoSQL(Ent.TasEmi) & "," & Chr$(10)
   Sql = Sql & BacFormatoSQL(Ent.BasEmi) & "," & Chr$(10)
   Sql = Sql & BacFormatoSQL(Ent.TasEst) & "," & Chr$(10)
   Sql = Sql & BacFormatoSQL(Ent.Nominal) & "," & Chr$(10)
   Sql = Sql & BacFormatoSQL(Ent.tir) & "," & Chr$(10)
   Sql = Sql & BacFormatoSQL(Ent.Pvp) & "," & Chr$(10)
   Sql = Sql & BacFormatoSQL(Ent.Mt)

   If miSQL.SQL_Execute(Sql) <> 0 Then
      GoTo ValorizarError
   End If

   If miSQL.SQL_Fetch(Datos()) = 0 Then
      nError = Val(Datos(1))

      If nError = 0 Then
         Sal.Nominal# = CDbl(Datos(2))
         Sal.tir# = CDbl(Datos(3))
         Sal.Pvp# = CDbl(Datos(4))
         Sal.Mt# = CDbl(Datos(5))
         Sal.MtUM# = CDbl(Datos(6))
         Sal.Mt100# = CDbl(Datos(7))
         Sal.Van# = CDbl(Datos(8))
         Sal.Vpar# = CDbl(Datos(9))
         Sal.Numucup% = CDbl(Datos(10))
         Sal.Fecucup$ = Datos(11)
         Sal.Intucup# = CDbl(Datos(12))
         Sal.Amoucup# = CDbl(Datos(13))
         Sal.Salucup# = CDbl(Datos(14))
         Sal.Numpcup% = CDbl(Datos(15))
         Sal.Fecpcup$ = Datos(16)
         Sal.Intpcup# = CDbl(Datos(17))
         Sal.Amopcup# = CDbl(Datos(18))
         Sal.Salpcup# = CDbl(Datos(19))
         Sal.duratmac# = CDbl(Datos(20))
         Sal.convexid# = CDbl(Datos(21))
         Sal.duratmod# = CDbl(Datos(22))
        ' Sal.TasEmiNew# = CDbl(Datos(24))
        ' Sal.TasEstNew# = CDbl(Datos(25))

         Valorizar_Papel = True

      Else
         Screen.MousePointer = 0
         MsgBox Datos(2), vbExclamation, gsBac_Version
         Exit Function

      End If

   End If

   Screen.MousePointer = 0

   Exit Function

ValorizarError:
   Screen.MousePointer = 0

   If err <> 0 Then
      MsgBox error(err), vbCritical, gsBac_Version
      MsgBox Datos(2), vbCritical, gsBac_Version

   End If

   Exit Function

End Function

