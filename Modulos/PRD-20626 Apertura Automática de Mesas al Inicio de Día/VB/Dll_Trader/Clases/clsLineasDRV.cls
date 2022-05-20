VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsLineasDRV"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
Private Type DV01_Operacion
    Producto()              As String
    Num_Operacion()         As Long
    Matriz()                As Double
    Var()                   As Double
    Rut()                   As Long
    Plazo()                 As Long
End Type



Public Type Cliente_DRV
    Rut                     As Long
    Codigo                  As Integer
    NOMBRE                  As String
    Metodologia             As Long
    Threshold               As Double
End Type
Public Type Datos_Cliente_DRV
    Clie_DRV()              As Cliente_DRV
End Type

Private gsSQL_Server        As String
Private gsBac_LineasDb      As String
Private gsSQL_Login         As String
Private gsSQL_Password      As String

Property Let SQL_Server(ByVal oValor As String)
    gsSQL_Server = oValor
End Property
Property Let Bac_LineasDb(ByVal oValor As String)
    gsBac_LineasDb = oValor
End Property
Property Let SQL_Login(ByVal oValor As String)
    gsSQL_Login = oValor
End Property
Property Let SQL_Password(ByVal oValor As String)
    gsSQL_Password = oValor
End Property


Private Function Proc_Rescata_Clientes_DRV(CLIENTE As Datos_Cliente_DRV, Optional iRut As Long = 0, Optional iCodigo As Long = 0)
    Dim Datos()
    Dim indice As Long
    
    Envia = Array()
    AddParam Envia, iRut
    AddParam Envia, iCodigo
    If Not Bac_Sql_Execute("BacTraderSuda..SP_CON_CLIENTE_DERIVADOS", Envia) Then
      Exit Function
    End If
   
    Do While Bac_SQL_Fetch(Datos())
        ReDim Preserve CLIENTE.Clie_DRV(indice)
        CLIENTE.Clie_DRV(indice).Rut = Datos(1)
        CLIENTE.Clie_DRV(indice).Codigo = Datos(2)
        CLIENTE.Clie_DRV(indice).NOMBRE = Datos(3)
        CLIENTE.Clie_DRV(indice).Metodologia = Datos(4)
        CLIENTE.Clie_DRV(indice).Threshold = Datos(5)
        indice = indice + 1
    Loop
        
End Function


Public Function Proc_Recalculo_Lineas_DRV(Optional iRut As Long = 0, Optional iCodigo As Long = 0) As Boolean
    Dim CalcRec             As Double
    Dim Det_MsgError        As String
    Dim Contador            As Long
    Dim CliMet_2_5          As Long
    Dim CliMet_3            As Long
    Dim VerificaSim         As String
    Dim Parametros          As Boolean
    Dim iCadena             As String
    Dim Titulo              As String
    Dim CLIENTE             As Datos_Cliente_DRV
    Dim TotClieDRV          As Double
    Dim ErrorTotClieDRV     As Long
    Dim inicio              As Variant
    Dim fin                 As Variant

    Call Proc_Rescata_Clientes_DRV(CLIENTE, iRut, iCodigo)

    On Error Resume Next
    TotClieDRV = UBound(CLIENTE.Clie_DRV)
    ErrorTotClieDRV = Err.Number
    On Error GoTo 0

    If Not ErrorTotClieDRV = 0 Then
        TotClieDRV = -1
    End If

    If TotClieDRV = -1 Then
        Call MsgBox("No hay Clientes con Metodologías Netting. ", vbInformation, App.Title)
        Exit Function
    End If

    Let CliMet_2_5 = 0
    Let CliMet_3 = 0
    
    For Contador = 0 To TotClieDRV
        If CLIENTE.Clie_DRV(Contador).Metodologia = 2 Or CLIENTE.Clie_DRV(Contador).Metodologia = 5 Then
            CliMet_2_5 = CliMet_2_5 + 1
        End If
        If CLIENTE.Clie_DRV(Contador).Metodologia = 3 Then
            CliMet_3 = CliMet_3 + 1
        End If
    Next Contador
    
    Let Parametros = False
    Let iCadena = ""
    Let Titulo = ""
    
    If CliMet_3 >= 1 Then
        Let VerificaSim = "PAR_SIMULACIONES"
        Call Proc_Verifica_Parametros(VerificaSim, Parametros, iCadena)
        If Parametros = True Then
            Call MsgBox(iCadena, vbCritical, "Faltan los siguentes parametros")
            Let Titulo = "Falta Agregar los siguientes parametros: "
            Call BacCalculoRec.Proc_EnviarMail(iCadena, Titulo)
        End If
    Else
        Let VerificaSim = "PAR_DIA"
        Call Proc_Verifica_Parametros(VerificaSim, Parametros, iCadena)
        If Parametros = True Then
            Call MsgBox(iCadena, vbCritical, "Faltan los siguentes parametros")
            Let Titulo = "Falta Agregar los siguientes parametros: "
            Call BacCalculoRec.Proc_EnviarMail(iCadena, Titulo)
            Exit Function
        End If
    End If
    
    Let Det_MsgError = ""
    Let inicio = Now  'PROD-10967
    Call BacCalculoRec.ProcesoRecalculoREC(CLIENTE, Det_MsgError, "General")
    Let fin = Now     'PROD-10967
    MsgBox ("Recalculo Netting demoró " + Format(Minute(fin) * 60 + Second(fin) - Minute(inicio) * 60 - Second(inicio), "######.##") + " Seg.") 'PROD-10967

    Let Titulo = ""
    If Det_MsgError <> "" Then
        Let Titulo = "Se generaron los siguientes Errores en Calculo REC.: "
        Call BacCalculoRec.Proc_EnviarMail(Det_MsgError, Titulo)
    End If
    Screen.MousePointer = vbDefault
End Function


Private Function Proc_Verifica_Parametros(VerificaSim As String, Prametros As Boolean, iCadena As String) As Boolean
    Dim Datos()
    
    Proc_Verifica_Parametros = False
    
    Envia = Array()
    AddParam Envia, VerificaSim ' Indicador accion
    If Not Bac_Sql_Execute("BacLineas..SP_RIEFIN_VERIFICA_PARAMETROS_VAR", Envia) Then
        Exit Function
    Else
        iCadena = ""
        Do While Bac_SQL_Fetch(Datos())
            iCadena = iCadena + (Datos(1)) & ";" & (Datos(2)) & ";" & (Datos(3)) & "  -  " & Chr$(13)
            If iCadena <> "" Then
                Prametros = True
            End If
        Loop
    End If
    Proc_Verifica_Parametros = True
End Function

Private Sub Proc_EnviarMail(Det_MsgError As String, Titulo As String)
    Dim oApp            As Object  ' Objeto Application
    Dim oWorkBook       As Object ' Libro de trabajo
    Dim oSheet          As Object   'Hoja Activ
    Dim Datos()         As Variant
    Dim ProxFHabil      As Date
    Dim iCadena         As String
    
    Envia = Array()
    AddParam Envia, MailCaidaLineas ' Indicador accion

    If Not Bac_Sql_Execute("exec BACPARAMSUDA..SP_LEERENVIOMAIL", Envia) Then
        Call MsgBox("Problemas al Leer Procedimiento. ", vbCritical, App.Title)
    Else
        iCadena = ""
        Do While Bac_SQL_Fetch(Datos())
        iCadena = iCadena + (Datos(5)) & ";"
        Loop
    End If
        
    Dim OutlookApp As Object
    Dim OutlookMail As Object
    Dim Outlookmailitem As Integer
    Dim MailAttach As Integer
    Set OutlookApp = CreateObject("Outlook.Application")
    Set OutlookMail = OutlookApp.CreateItem(Outlookmailitem)
    OutlookMail.To = iCadena
    OutlookMail.Subject = "Problema Lineas del " & Format(CDate(gsBac_Fecp), "DD-MM-YYYY")
    
    OutlookMail.htmlBody = "<HTML><BODY>" & "Estimados.<br/> <br/>" & _
    "&nbsp &nbsp &nbsp &nbsp Adjunto Errores en calculo de lineas del dia. <b>" & gsBac_Fecp & ":</b>" & "<br/> <br/>" & _
    "&nbsp &nbsp &nbsp &nbsp " & Titulo & " <br/> <br/>" & _
    "&nbsp &nbsp &nbsp &nbsp &nbsp &nbsp " & Det_MsgError & " <br/> <br/>" & "<HTML><BODY>"
    
    
    OutlookMail.send 'Para que lo envie sin visualizar      'PROD-10967
    'OutlookMail.Display 'Para que lo pare en la pantalla   'PROD-10967

    Set OutlookApp = Nothing
    Set OutlookMail = Nothing
End Sub



Private Function ProcesoRecalculoREC(CLIENTE As Datos_Cliente_DRV, ByRef MsgError As String, TipoCalculo As String) As Double
    Dim Conexion                            As ADODB.Connection
    Dim iRut                                As Long
    Dim iCodigo                             As Long
    Dim RecMet5                             As Double
   'Variable para medir el tiempo de calculo
    'Inicia Variables
    Dim Matriz_DV01                         As DV01_Operacion
    Dim Exp_Max                             As Negociacion
    Dim Valdatos                            As Procesos
    Dim AddOn                               As Datos_AddOn
    Dim Valorizacion                        As Double
    Dim Cartera                             As Negociacion
    Dim expom                               As Exposicion_Maxima
    Dim Datos(MaxNumero_Simulaciones)       As Datos_Mercado
    Dim MCovar()                            As Double
    Dim largo_vector                        As Long
    Dim AddON90d                            As Double
    Dim ExposicionMaxima                    As Double
    Dim Total_AddOn                         As Double
    Dim Valor_Mercado                       As Long
    Dim ClienteTieneDerivados               As Boolean
    Dim ErrorGeneral                        As Long
    Dim Threshold                           As Double
    Dim Metodologia                         As Integer
    Dim fCodigo                             As Long
    Dim fRut                                As Long
    Dim fCliente                            As String
    Dim Mensaje                             As String
    Dim ConsideraCliente                    As Boolean
    Dim ValidarRec                          As Boolean
    Dim Tiempo                              As Date
    
    Let Tiempo = Time

    Let fRut = 0
    Let fCodigo = 0
    Let fCliente = ""
    Let Metodologia = 0
    Let Threshold = 0
    Screen.MousePointer = vbHourglass
    
   'Rescata informacion desde las bases de datos

    Inicia_Conexion

   'Ingresa la fecha de proceso, OK Migracion to BAC
    Datos(0).Fecha = gsBAC_FecConFin
    Let Valorizacion = 0
    Let AddON90d = 0
    Let Total_AddOn = 0
    Let ExposicionMaxima = 0
    Let RecMet5 = 0
      
    'Case por Metodologia para dar claridad al código
    
    'Carga en memoria clientes DRV.
    'Proc_Rescata_Clientes_DRV CLIENTE
    
    Dim TotClieDRV As Double
    Dim ErrorTotClieDRV As Long
    Dim Contador As Long
    
    On Error Resume Next
        TotClieDRV = UBound(CLIENTE.Clie_DRV)
        ErrorTotClieDRV = Err.Number
    On Error GoTo 0
    If Not ErrorTotClieDRV = 0 Then
        TotClieDRV = -1
    End If
    
    'Se pone en duro la metodologia 3 para que busque todos los datos
    
    If TipoCalculo = "General" Then
          Numero_Simulaciones = Rescata_Simulaciones(Cartera, Valdatos, 3 _
                                                  , Threshold, fRut, fCodigo, fCliente)
    Else
          Numero_Simulaciones = 2
    End If

    Rescata_Datos_Mercado Datos, Numero_Simulaciones, Valdatos
    
    If Valdatos.ErrorcargaDatos = True Then
        MsgError = "Error: " & Valdatos.ErrorNumero & " - " & Valdatos.ErrorDescripcion
        Exit Function
    End If
    
    Crea_Vector_Simplificado Datos
    
    
    If TipoCalculo = "General" Then
        Calcula_Covarianza Datos, MCovar, largo_vector, Valdatos
       Call Graba_Matriz_Covarianza_SQL(MCovar, Datos, Datos(0).Fecha, Valdatos)     '-- Demora 3 minutos !!!
    Else
        Call Carga_Completa_Matriz_Covarianza_SQL(MCovar, Valdatos, largo_vector)  'Un segundo !!! se ejecutó aca para verificar carga despues dejar con if imposible
    End If
    
    For Contador = 0 To TotClieDRV
       
        'Let Largo_Vector = 0
        Erase Matriz_DV01.Matriz
        Erase Matriz_DV01.Num_Operacion
        Erase Matriz_DV01.Producto
        Erase Matriz_DV01.Rut
        Erase Matriz_DV01.Plazo
        Erase Matriz_DV01.Var
        Erase Cartera.CalcRec
        
        Erase Exp_Max.CalcRec
        Erase Exp_Max.Cartera_Fwd
        Erase Exp_Max.Cartera_Fwd_RF
        Erase Exp_Max.Cartera_Opcion
        Erase Exp_Max.Cartera_Swap

        Erase AddOn.AddOn_Operaciones
        Erase expom.Exp_Max

       ' Erase MCovar

        Erase Cartera.Total_Exp_maxima
        Erase Cartera.Fecha_Exp_Max
        Erase Cartera.Val_Mercado   'PROD-10967
        
        Let Valorizacion = 0
        Let AddON90d = 0
        Let Total_AddOn = 0
        Let ExposicionMaxima = 0
        Let Total_AddOn = 0
        Let RecMet5 = 0
        Let ProcesoRecalculoREC = 0

        
        Let fRut = CLIENTE.Clie_DRV(Contador).Rut
        Let fCodigo = CLIENTE.Clie_DRV(Contador).Codigo
        Let fCliente = CLIENTE.Clie_DRV(Contador).NOMBRE
        Let Metodologia = CLIENTE.Clie_DRV(Contador).Metodologia
        Let Threshold = CLIENTE.Clie_DRV(Contador).Threshold
        
        Let ConsideraCliente = True
        
        '*************************************************
        ' Metodologia 2
        '*************************************************
       
        
        If Metodologia = 2 Then
        
            Numero_Simulaciones = Rescata_Simulaciones(Cartera, Valdatos, Metodologia _
                                                  , Threshold, fRut, fCodigo, fCliente)
            
            'Datos de mercado
            'Rescata_Datos_Mercado DATOS, Numero_Simulaciones, Valdatos
            
            'Importa la cartera
            Rescata_Cartera_Trading Datos(0), Cartera, Valdatos, largo_vector, fRut, fCodigo
            
            
            If EjecutaBtnREC = True Then
                MsgError = ""
                If Valdatos.ErrorNumero <> 0 Then
                    Call MsgBox("Se ha originado un error al tratar de leer Datos ." _
                    & Valdatos.ErrorSP & Valdatos.ErrorDescripcion, vbInformation, App.Title)
                    
                    MsgError = Valdatos.ErrorSP & "Error en SP:" & Valdatos.ErrorDescripcion
                    ProcesoRecalculoREC = 0
                    ValidarRec = False
                    Exit Function
                End If
            Else
                If Valdatos.ErrorNumero <> 0 Then
                    MsgError = Valdatos.ErrorSP & "Error en SP:" & Valdatos.ErrorDescripcion
                    ProcesoRecalculoREC = 0
                    ValidarRec = False
                    Exit Function
                End If
            End If
                        
             'Se verifica si hay o no cartera vigente
            ClienteTieneDerivados = HayCartera(Cartera)
    
           
            If ClienteTieneDerivados Then
                Valoriza_Cartera_Trading Cartera, Datos(0), Datos(0).Fecha
                Valorizacion = MTMCarteraTotal(Cartera)
                Total_AddOn = AddOn_Al_Vencimiento(Cartera, AddOn, Datos(0).Fecha, Metodologia)
                Calc_Cons_Resul_MaxExp Datos(0).Fecha, Cartera, expom, fRut, fCodigo
                ExposicionMaxima = Cartera.Exposicion_Maxima
            End If
        
        End If  'Metodologia 2
   
        '*************************************************
        ' Metodologia 3
        '*************************************************
        If Metodologia = 3 Then
                         
            Numero_Simulaciones = Rescata_Simulaciones(Cartera, Valdatos, Metodologia _
                                                  , Threshold, fRut, fCodigo, fCliente)
            
            
            'Datos de mercado
            'Rescata_Datos_Mercado DATOS, Numero_Simulaciones, Valdatos
            
            'Importa la cartera y la valoriza al dia mas reciente
            Rescata_Cartera_Trading Datos(0), Cartera, Valdatos, largo_vector, fRut, fCodigo
           
            
            If EjecutaBtnREC = True Then
                MsgError = ""
                If Valdatos.ErrorNumero <> 0 Then
                    Call MsgBox("Se ha originado un error al tratar de leer Datos ." _
                    & Valdatos.ErrorSP & Valdatos.ErrorDescripcion, vbInformation, App.Title)
        
                    MsgError = Valdatos.ErrorSP & "Error en SP:" & Valdatos.ErrorDescripcion
                    ProcesoRecalculoREC = 0
                    ValidarRec = False
                    Exit Function
                End If
            Else
                If Valdatos.ErrorNumero <> 0 Then
                    MsgError = Valdatos.ErrorSP & "Error en SP:" & Valdatos.ErrorDescripcion
                    ProcesoRecalculoREC = 0
                    ValidarRec = False
                    Exit Function
                End If
            End If
        
               
            'Se verifica si hay o no cartera vigente
            ClienteTieneDerivados = HayCartera(Cartera)
    
    
            If ClienteTieneDerivados Then
            
                Valoriza_Cartera_Trading Cartera, Datos(0), Datos(0).Fecha
            
                'Calcula la covarianza
                 'Crea_Vector_Simplificado DATOS
                 'Calcula_Covarianza DATOS, MCovar, Largo_Vector, Valdatos
            
                If EjecutaBtnREC = True Then
                    MsgError = ""
                    If Valdatos.ErrorNumero <> 0 Then
                        Call MsgBox("Se ha originado un error. " _
                        & Valdatos.ErrorDescripcion, vbInformation, App.Title)
                        
                        MsgError = "Error en." & Valdatos.ErrorDescripcion
                        ProcesoRecalculoREC = 0
                        ValidarRec = False
                        Exit Function
                    End If
                Else
                    If Valdatos.ErrorNumero <> 0 Then
                        MsgError = "Error en:" & Valdatos.ErrorDescripcion
                        ProcesoRecalculoREC = 0
                        ValidarRec = False
                        Exit Function
                    End If
                End If
                

            
                Calcula_DV01_Principal Cartera, Datos(0), Valdatos
                
                Calcula_VaR Cartera, MCovar, largo_vector, Datos(0).Fecha, Matriz_DV01, fRut, fCodigo, TipoCalculo
                AddON90d = Var(Matriz_DV01)
        
                Valorizacion = MTMCarteraTotal(Cartera) 'terminado
                       
                Calc_Cons_Resul_MaxExp Datos(0).Fecha, Cartera, expom, fRut, fCodigo
                
                ExposicionMaxima = Cartera.Exposicion_Maxima
    
            End If 'ClienteTieneDerivados
        End If  'Metodologia 3
               
        '*************************************************
        ' Metodologia 5
        '*************************************************
        If Metodologia = 5 Then
        
            Numero_Simulaciones = Rescata_Simulaciones(Cartera, Valdatos, Metodologia _
                                                  , Threshold, fRut, fCodigo, fCliente)
            'Datos de mercado
            'Rescata_Datos_Mercado DATOS, Numero_Simulaciones, Valdatos
            
            'Importa la cartera y la valoriza al dia mas reciente
            Rescata_Cartera_Trading Datos(0), Cartera, Valdatos, largo_vector, fRut, fCodigo
        
            
            'Se verifica si hay o no cartera vigente
            ClienteTieneDerivados = HayCartera(Cartera)
       
            If EjecutaBtnREC = True Then
                MsgError = ""
                If Valdatos.ErrorNumero <> 0 Then
                    Call MsgBox("Se ha originado un error al tratar de leer Datos ." _
                    & Valdatos.ErrorSP & Valdatos.ErrorDescripcion, vbInformation, App.Title)
                    
                    MsgError = Valdatos.ErrorSP & "Error en SP:" & Valdatos.ErrorDescripcion
                    ProcesoRecalculoREC = 0
                    ValidarRec = False
                    Exit Function
                End If
            Else
                If Valdatos.ErrorNumero <> 0 Then
                    MsgError = Valdatos.ErrorSP & "Error en SP:" & Valdatos.ErrorDescripcion
                    ProcesoRecalculoREC = 0
                    ValidarRec = False
                    Exit Function
                End If
            End If
            
            If ClienteTieneDerivados Then
       
                Valoriza_Cartera_Trading Cartera, Datos(0), Datos(0).Fecha
        
                'Esto no es necesario para la metodologia 5
                'pero es para mostrar los MTM en pantalla
                 Calc_Cons_Resul_MaxExp Datos(0).Fecha, Cartera, expom, fRut, fCodigo
                
                 Call CalculaValorMercado(Cartera)
                     
                 Call AddOn_Al_Vencimiento(Cartera, AddOn, Datos(0).Fecha, Metodologia)
                    
                 RecMet5 = Func_CalculoRecMetologia5(Cartera)
    
            End If
    
        End If  'Metodologia 5
        
        'PROD-10967
        Calcula_REC Datos(0).Fecha, Cartera, Cartera.CalcRec _
                                           , Valorizacion _
                                           , AddON90d _
                                           , Total_AddOn _
                                           , ExposicionMaxima _
                                           , Threshold, Metodologia _
                                           , RecMet5, Valdatos, fRut, fCodigo, fCliente
              
        ProcesoRecalculoREC = Cartera.CalcRec(0).Consumo_Linea
        
        
        'Graba Proceso Rec en tabla TBL_RIEFIN_General_REC
        'If EjecutaBtnREC = False Then 'PROD-10967
           Calcula_REC_SQL Datos(0).Fecha, Cartera, Cartera.CalcRec _
                                          , Valorizacion _
                                          , AddON90d _
                                          , Total_AddOn _
                                          , ExposicionMaxima _
                                          , Threshold, Metodologia _
                                          , Valdatos _
                                          , fRut, fCodigo, fCliente
        'End If 'NO se debe condicionar la grabación 'PROD-10967
    
        If BacBeginTransaction() Then
        
              If Not Lineas_ChequearGrabarRecalculoDRV("BFW", CDbl(1), 1, 1, 0 _
                                      , CDbl(fRut), CDbl(fCodigo), 1 _
                                      , 1, (CDate(gsBac_Fecp) + 9999), 0, 0, (CDate(gsBac_Fecp)) _
                                      , 0, "N", CDbl(999), " ", 0, 0, 0 _
                                      , (CDate(gsBac_Fecp)), 0, CDbl(0), 0, 0, "", ProcesoRecalculoREC _
                                      , Metodologia) Then 'PROD-10967
                  Call BacRollBackTransaction
                  MsgBox "Problemas en Procedimientos"
                  Exit Function
              End If

              Mensaje = Mensaje & Lineas_Chequear("BFW", CDbl(1), 1, " ", "", "")
            
              If Mensaje <> "" Then
                  MsgBox "Error al Chequear Lineas : " + Chr(10) + Chr(13) + Chr(10) + Chr(13) + Mensaje, vbCritical
                  Call BacRollBackTransaction
                  Exit Function
              End If
              
        
              If Not Lineas_GrbOperacion("BFW", CDbl(1), 1, CDbl(1), " ", 0, 0) Then
                  Call BacRollBackTransaction
                  MsgBox "Problemas en Procedimientos"
                  'GrabarOperacion = False
                  Exit Function
              End If
              Call BacCommitTransaction
        End If
    
    Next Contador

End Function


