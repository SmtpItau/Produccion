USE [CbMdbOpc]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRIDDECISIONEJERCICIO]    Script Date: 16-05-2022 10:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_GRIDDECISIONEJERCICIO](   @f1 datetime , @f2 datetime , @CliRut numeric(10), @CliCod numeric(1),  @Usuario Varchar(15) ) AS BEGIN			

     -- INSTRUCCIONES GENERALES DE MANTENCION
     
     --  Sp_GridDecisionEjercicio '20080908', '20090908' , 0, 0, 'MARIAS' 
     --  Sp_GridDecisionEjercicio '20070101', '20070101' , 0, 0, 'MARIAS' 
	 --  Sp_GridDecisionEjercicio '20140818', '20140818' , 0, 0, 'MARIAS' 

     --  MAP 04 Nov. 2009 se muestra estado de ejercicio para las estructuras
     --  debe ser comun a todos por que las decisiones deben ser todas iguales en una estructura.
     --  MAP 12 Nov. 2009 montos recibir y pagar, deben ser desplegados
/* Chuequeo registro vacío 
*/
     
     SET NOCOUNT ON			
     Declare  @Nombre Char(120)
            , @Dv     Char(1)
            , @FechaProceso datetime
			, @MsgMesaCambios VarChar(7)
			, @EstadosCambios VarChar(10)

     SELECT @EstadosCambios = acLogDig FROM lnkBac.BacCamSuda.dbo.meac
	 Select @MsgMesaCambios = case when substring(@EstadosCambios, 6, 1 ) = '1' then 'Cerrada' else 'Abierta' end

     select @FechaProceso = FechaProc from OpcionesGeneral

     -- Sección que genera el registro vacío.
     Select   'Pantalla'        = convert( Varchar(40) , 'DECISION DE EJERCICIO' )
            , 'NumContrato'     = convert( numeric(8)  , 0 )
            , 'CliRut'  	= Convert( numeric(13) , 0 )
            , 'CliCod'          = convert( numeric(5)  , 0 )
            , 'CliDv'           = Convert( varchar(1)  , ''   )
            , 'CliNom'  	   =  Convert( varchar(100), 'NO HAY DATOS' )
            , 'Operador'        = Convert( varchar(15) , '' )
            , 'OpcEstCod'       = Convert( varchar(2)  , '' )
            , 'OpcEstDsc'       = COnvert( Varchar(20) , '' )  
            , 'NumComponente'   = convert( numeric(6)  , 0 )
            , 'NumCajFolio'     = convert( numeric(8)  , 0 )
            , 'MTMImplicito'    = convert( numeric(21,6), 0 )
            , 'PayOffTipCod'        = convert( VarChar(2)  , '' )
            , 'PayOffTipDsc'        = Convert( VarChar(20) , '' )
            , 'CallPut'             = convert( VarChar(5)  , '' )
            , 'CVOpcCod'            = Convert( varchar(3)  , '' )
            , 'CompraVentaOpcDsc'   = Convert( varchar(10)  , '' )
            , 'FechaPagoEjer'       = Convert( datetime    , '' , 112 )
            , 'Mon1Cod'             = convert( numeric(5)  , 0 )
            , 'Mon1Dsc'             = convert( char(35)    , ''  )
            , 'FormaPagoMon1Cod'    = convert( numeric(3)  , 0 )
            , 'FormaPagoMon1Dsc'    = convert( varchar(30)  , '' )
            , 'MontoMon1'           = Convert( numeric(21,6) , 0 )
            , 'Mon2Cod'             = convert( numeric(5)  , 0 )
            , 'Mon2Dsc'             = convert( char(35)    , '' )
            , 'FormaPagoMon2Cod'    = convert( numeric(3)  , 0 )
            , 'FormaPagoMon2Dsc'    = convert( varchar(30)  , '' )
            , 'MontoMon2'           = Convert( numeric(21,6) , 0 )
            , 'ModalidadCod'        = Convert( varchar(1)  , ''  )
            , 'ModalidadDsc'        = Convert( varchar(100) , ''  )
            , 'MdaCompensacionCod'  = Convert( numeric(5)  , 0 )
            , 'MdaCompensacionDsc'  = convert( char(35)    , ''  )
            , 'Strike'              = convert( float, 0.0 )
            , 'EstadoEjercicioCod'  = convert( varchar(2) , '' )
            , 'EstadoEjercicioDsc'  = convert( varchar(30), '' )
            , 'EstadoMotorPagoCod'     = convert( varchar(2) , '' )
            , 'EstadoMotorPagoDsc'  = convert( varchar(20), '' ) 
            , 'Usuario'             = convert( varchar(15), '' )
            , 'MdaRecibirCod'       = convert( numeric(5), 0 )
            , 'MdaRecibirDsc'       = convert( varchar(35), '' )
            , 'FormaPagoRecibirCod' = Convert( numeric(3),  0 )
            , 'FormaPagoRecibirDsc' = convert( varchar(30), '' )
            , 'MontoRecibir'        = convert( numeric( 21, 6), 0 )
            , 'MdaPagarCod'       = convert( numeric(5), 0 )
            , 'MdaPagarDsc'       = convert( varchar(35), '' )
            , 'FormaPagoPagarCod' = Convert( numeric(3), 0 )
            , 'FormaPagoPagarDsc' = convert( varchar(30), '' )
    , 'MontoPagar'        = convert( numeric( 21, 6), 0 )
            , 'Origen'            = convert( varchar(2), '' )     
            INTO #Resultado -- Genera tabla con el registro vacío

            CREATE INDEX INumContrato ON #Resultado(NumContrato,NumComponente ) 
      -- Estrategria
      -- Cargar tabla con los datos Fixing por fecha
      -- mediante update aplicar los datos de:
      -- CaEncContrato, CaDetContrato, CaVenEncContrato y CaVenEncContrato
      -- por ahora tratar de mantener información historica junto con 
      -- la vigente, si el desempeño no mejora separamos la cosa.
 
      Select  Distinct
              'Pantalla'        = convert( Varchar(40) , 'DECISION DE EJERCICIO' )
            , 'NumContrato'     = convert( numeric(8)  , Caj.CaNumContrato )
            , 'CliRut'  	= Convert( numeric(13) , Enc.CaRutCliente )
            , 'CliCod'          = convert( numeric(5)  , Enc.CaCodigo )
            , 'CliDv'           = Convert( varchar(1)  , isnull( Cliente.ClDv, '' )   )
            , 'CliNom'  	= Convert( varchar(100), isnull( substring(Cliente.ClNombre, 1, 100) , 'Cliente no esta en BAC' ) )
            , 'Operador'        = Convert( varchar(15) , Enc.CaOperador )
            , 'OpcEstCod'       = Convert( varchar(2)  , Enc.CaCodEstructura )
            , 'OpcEstDsc'       = COnvert( Varchar(20) , isnull( Estructura.OpcEstDsc, 'Estructura no Existe'  ) )   
            , 'NumComponente'   = convert( numeric(6)  ,  Caj.CaNumEstructura)	/*case when Caj.CaCajModalidad = 'C' and CaVinculacion = 'Estructura'  then 0 else Caj.CaNumEstructura end) */  -- select * from CaDetContrato
            , 'NumCajFolio'     = convert( numeric(8)  ,  Caj.CaCajFolio)		/*case when Caj.CaCajModalidad = 'C' and CaVinculacion = 'Estructura'  then 0 else Caj.CaCajFolio end )*/
            , 'MTMImplicito'    = convert( numeric(21,6), case when Caj.CaCajModalidad = 'C' and CaVinculacion = 'Estructura' then 0 else Caj.CaMtmImplicito end )
            , 'PayOffTipCod'        = convert( VarChar(2)  , Det.CaTipoPayOff ) 
            , 'PayOffTipDsc'        = Convert( VarChar(20) , PayOffTipo.PayOffTipDsc )          
            , 'CallPut'             = convert( VarChar(5)  , case when Caj.CaCajModalidad = 'C' and CaVinculacion = 'Estructura'  then 'Estr.' else Det.CaCallPut end )
            , 'CVOpcCod'            = Convert( varchar(3)  , case when Caj.CaCajModalidad = 'C' and CaVinculacion = 'Estructura'  then 'Estr.' else  Det.CaCVOpc end )
            , 'CompraVentaOpcDsc'   = Convert( varchar(10)  , case when Caj.CaCajModalidad = 'C' and CaVinculacion = 'Estructura'  then 'Estr.' 
                                                                   else Case when Det.CaCVOpc = 'C' then 'Derecho' else 'Obligacion' end 
                                                                   end )
            , 'FechaPagoEjer'       = Convert( datetime    , Det.CaFechaPagoEjer , 112 )
            , 'Mon1Cod'             = convert( numeric(5)  , Caj.CaCajMdaM1 )
            , 'Mon1Dsc'             = convert( char(35)    , isnull( MonedaM1.MnGlosa, 'Moneda M1 no existe' )  )
            , 'FormaPagoMon1Cod'    = convert( numeric(3)  , Caj.CaCajFormaPagoMon1 )
            , 'FormaPagoMon1Dsc'    = convert( varchar(30)  , FPago1.Glosa )
            , 'MontoMon1'           = Convert( numeric(21,6) , case when Caj.CaCajModalidad = 'C' and CaVinculacion = 'Estructura'  then 0 else Caj.CaCajMtoMon1 end)
            , 'Mon2Cod'             = convert( numeric(5)  , Caj.CaCajMdaM2 )
            , 'Mon2Dsc'             = convert( char(35)    , isnull( MonedaM2.MnGlosa, 'Moneda M2 no existe' ) )
            , 'FormaPagoMon2Cod'    = convert( numeric(3)  , Caj.CaCajFormaPagoMon2 )
            , 'FormaPagoMon2Dsc'    = convert( varchar(30)  , FPago2.Glosa )
            , 'MontoMon2'           = Convert( numeric(21,6) , Caj.CaCajMtoMon2 )
            , 'ModalidadCod'        = Convert( varchar(1)  , Caj.CaCajModalidad  )
            , 'ModalidadDsc'        = Convert( varchar(100) , case when Caj.CaCajModalidad  = 'E' then 'Entrega Fis.' else 'Compensación' end  )
            , 'MdaCompensacionCod'  = Convert( numeric(5)  , Det.CaMdaCompensacion ) 
            , 'MdaCompensacionDsc'  = convert( char(35)    , isnull( MdaComp.MnGlosa, 'Moneda Comp. no existe' )  )
            , 'Strike'              = convert( float, case when Caj.CaCajModalidad = 'C' and CaVinculacion = 'Estructura'  then 0 else Det.CaStrike end )
            , 'EstadoEjercicioCod'  = convert( varchar(2) ,  Caj.CaCajEstado  ) 
            , 'EstadoEjercicioDsc'  = convert( varchar(30), '' )
            , 'EstadoMotorPagoCod'  = convert( varchar(2) , Caj.CaCajMotorPago )
            , 'EstadoMotorPagoDsc'  = convert( varchar(20), '' )
            , 'Usuario'             = convert( varchar(15), @Usuario )
            , 'MdaRecibirCod'       = convert( numeric(5), 0 )
            , 'MdaRecibirDsc'       = convert( varchar(35), '' )
            -- Pendiente
            , 'FormaPagoRecibirCod' = Convert( numeric(3), 0 )
            , 'FormaPagoRecibirDsc' = convert( varchar(30), '' )
            , 'MontoRecibir'        = convert( numeric(21,6), 0 )
            , 'MdaPagarCod'       = convert( numeric(5), 0 )
            , 'MdaPagarDsc'       = convert( varchar(35), '' )
            -- Pendiente
            , 'FormaPagoPagarCod' = Convert( numeric(3), 0 )
            , 'FormaPagoPagarDsc' = convert( varchar(30), '' )
            , 'MontoPagar'        = convert( numeric(21,6), 0 )
            , 'Origen'            = convert( varchar(2), Caj.CaCajOrigen )

      into #Caja
      from CaCaja          Caj 
             LEFT JOIN     LnkBac.BacParamSuda.dbo.Moneda MonedaM1   ON MonedaM1.MnCodMon = Caj.CaCajMdaM1
             LEFT JOIN     LnkBac.BacParamSuda.dbo.Moneda MonedaM2   ON MonedaM2.MnCodMon = Caj.CaCajMdaM2
             LEFT JOIN     LnkBac.BacParamSuda.dbo.Forma_De_Pago Fpago1   ON FPago1.Codigo = Caj.CaCajFormaPagoMon1
             LEFT JOIN     LnkBac.BacParamSuda.dbo.Forma_De_Pago Fpago2   ON FPago2.Codigo = Caj.CaCajFormaPagoMon2
           , CaDetContrato  Det
             LEFT JOIN     PayOffTipo               ON PayOffTipo.PayOffTipCod = Det.CaTipoPayOff 
-- POR HACER: cambiar a BDOpciones.BacParamMoneda
             LEFT JOIN     LnkBac.BacParamSuda.dbo.Moneda MdaComp   ON MdaComp.MnCodMon = Det.CaMdaCompensacion
             , CaEncContrato Enc
                LEFT JOIN BacParamSudaCliente Cliente    ON Cliente.ClRut = Enc.CaRutCliente and Cliente.ClCodigo = Enc.CaCodigo 
                LEFT JOIN OpcionEstructura    Estructura ON Estructura.OpcEstCod = Enc.CaCodEstructura
      where  CaCajFecPago >= @f1 and CaCajFecPago <= @f2  
         and Det.CaNumContrato = Caj.CaNumContrato
         and Det.CaNumEstructura = Caj.CaNumEstructura 
         and Enc.CaNumContrato = Det.CaNumContrato
         and Caj.CaCajOrigen = 'PV'
         and (     Enc.CaRutCliente = @CliRut and Enc.CaCodigo = @CliCod 
               or  @CliRut = 0 and @CliCod = 0  )

      declare @HayEntregaFisica  VarChar(1)
	  select @HayEntregaFisica = 'N'
	  select @HayEntregaFisica = 'S' from #Caja C where C.ModalidadCod = 'E' 

      IF exists( select (1) from #Caja ) and (    @MsgMesaCambios = 'Abierta' and @HayEntregaFisica = 'S'
	                                           or @HayEntregaFisica = 'N' )  BEGIN
          update #Caja 
             set  MTMImplicito       = ( select sum( CaCajMtoMon1 ) from CaCaja where #Caja.NumContrato = CaCaja.CaNumcontrato )
              ,  EstadoEjercicioDsc = case when EstadoEjercicioCod = 'NE' then 'No hay' 
                                           when EstadoEjercicioCod = 'E'  then 'Ejercido'
                                           when EstadoEjercicioCod = 'N'  then 'No Ejercido'               -- MAP 03 Noviembre 2009
                                           when EstadoEjercicioCod = 'P'  then 'Decisión Pendiente'
                                           else 'Estructura Compensada'
                                      end
                                      -- Motor de pagos es solo informativo
              ,  EstadoMotorPagoDsc = case when EstadoMotorPagoCod = 'P'  then 'Pendiente' 
                   when EstadoMotorPagoCod = 'G'  
                                           then 'Generado en BAC' 
                                      when EstadoMotorPagoCod = 'NE' 
                                           then 'No hay' 
                                      else 'ERROR' 
                                      end
                                      -- Se puede fijar si la fecha fijacion es futura 
                                      -- y  CaCaja esta con estado 'P' o no existe 
              ,  MdaRecibirCod      = case when ModalidadCod = 'C' then 
                                           case when MontoMon1 > 0 then Mon1Cod else 0 end
                                      else 
                                           case when MontoMon1 > 0 then Mon1Cod else Mon2Cod end
                                    end                                      
              ,  MdaRecibirDsc      = case when ModalidadCod = 'C' then 
                                           case when MontoMon1 > 0 then Mon1Dsc else 'N/A' end
                                      else 
                                           case when MontoMon1 > 0 then Mon1Dsc else Mon2Dsc end
                                      end
              -- PENDIENTE
              , FormaPagoRecibirCod = case when ModalidadCod = 'C' then
                                           case when MontoMon1 > 0 then FormaPagoMon1Cod else 0 end
                                      else
                                           case when MontoMon1 > 0 Then FormaPagoMon1Cod else FormaPagoMon2Cod end
                                      end
              , FormaPagoRecibirDsc = case when ModalidadCod = 'C' then
                                           case when MontoMon1 > 0 then FormaPagoMon1Dsc else 'N/A' end
                                      else
                                           Case when MontoMon1 > 0 then FormaPagoMon1Dsc else FormaPagoMon2Dsc end
                                      end
              , MontoRecibir        = case when ModalidadCod = 'C' then 
                                           case when MontoMon1 > 0 then MontoMon1 else 0 end
                                      else 
                                           case when MontoMon1 > 0 then MontoMon1 else MontoMon2 end
                                      end
              , MdaPagarCod         = case when ModalidadCod = 'C' then 
                                           case when MontoMon1 < 0 then Mon1Cod else 0 end
                                      else 
                                           case when MontoMon1 < 0 then Mon1Cod else Mon2Cod end
                                      end
              , MdaPagarDsc         = case when ModalidadCod = 'C' then 
                                           case when MontoMon1 < 0 then Mon1Dsc else 'N/A' end
                                      else 
                                           case when MontoMon1 < 0 then Mon1Dsc else Mon2Dsc end
                                      end
                -- PENDIENTE
              , FormaPagoPagarCod   = case when ModalidadCod = 'C' then 
                                           case when MontoMon1 < 0 then FormaPagoMon1Cod else 0 end
                                      else
                                           case when MontoMon1 < 0 then FormaPagoMon1Cod else FormaPagoMon2Cod end
                                      end 
              , FormaPagoPagarDsc   = case when ModalidadCod = 'C' then 
                                           case when MontoMon1 < 0 then FormaPagoMon1Dsc else 'N/A' end
                                      else
                                           case when MontoMon1 < 0 then FormaPagoMon1Dsc else FormaPagoMon2Dsc end
                                      end
              , MontoPagar          = -case when ModalidadCod = 'C' then 
                         case when MontoMon1 < 0 then MontoMon1 else 0 end
                                      else 
                                           case when MontoMon1 < 0 then MontoMon1 else MontoMon2 end
                                      end 
          update #Caja
          set Montorecibir = case when ModalidadCod = 'C' then 
                                         case when MTMImplicito > 0 then MTMImplicito else 0.0 end
                               else 0.0 end
            , MontoPagar = case when ModalidadCod = 'C' then 
                                         case when MTMImplicito < 0 then -MTMImplicito else 0.0 end
                               else 0.0 end

          select * 
               from #Caja order by NumCOntrato, NumComponente
     
      END
      ELSE
	     Begin
			update #Resultado
				set CliNom = case when  @MsgMesaCambios = 'Cerrada' and @HayEntregaFisica = 'S' then
				                 '** ERROR Abrir mesa en BACCAMBIOS por favor ***'
				             else CliNom end
				  , ModalidadDsc = case when  @MsgMesaCambios = 'Cerrada' and @HayEntregaFisica = 'S' then
				                 '** ERROR Abrir mesa en BACCAMBIOS por favor ***'
				             else CliNom end
			-- Se despliega el registro Sin Datos.
			select * from   #Resultado        			
		 end
END
GO
