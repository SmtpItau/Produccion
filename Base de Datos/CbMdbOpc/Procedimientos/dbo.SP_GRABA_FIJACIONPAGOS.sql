USE [CbMdbOpc]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_FIJACIONPAGOS]    Script Date: 16-05-2022 10:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_GRABA_FIJACIONPAGOS]    

       (    

         @Usuario     VARCHAR(15)    

       )    

AS    

BEGIN       

     -- MAP 17 de Septiembre    

     -- No se graba correctamente la forma de pago de Compensacion.    

    

     -- MAP 08 Octubre    

     -- Dado que no se valoriza al vencimiento se debe forzar el AVR     

     -- a ser igual al MTM implícito.    

     -- Calcula vencimiento con moneda compensacion (falla para USD)    

    

     -- MAP 14 Octubre se corrigen los decimales de la compensacion    

     -- MAP 12 Nov. Todas las decisiones deben quedar pendientes    

     -- Esto, junto con el cambio de decision sobre la estructura     

     -- completa hara que naturalmente las pantallas muestren    

     -- una linea por contrato a menos que sean entregas fisicas.  

  

     -- MAP 20130227 Liquidacion Forwards Asiático Entrada Salida (13) y Forward Asiático Entrada  

     -- 1. Se ajusta proceso para que soporte operaciones que calculan Strike con fijaciones y puntos  

     -- 2. Se elimina la posibilidad de modificar las fechas de fijación  

     -- 3. Generará liquidación si la fecha de proceso es igual a la fecha de vencimiento.  

     -- 4. Solo las liquidaciones con EF se eliminarán en caso de tener MTM implícito igual a cero.  

     -- Sp_Graba_FijacionPagos 'LGUERRA'-- Prueba Interna  

    

     SET NOCOUNT ON        

    

     CREATE TABLE #TMP_RESULTADO (    

         [Usuario][Varchar](15) not NULL,      

         [NumContrato][numeric](8) not NULL ,    

         [NumEstructura][numeric](8) not NULL ,    

         [NumFijacion][numeric](8) not NULL ,    

         [FechaFijacion][datetime] not NULL,    

         [Valor][float] not NULL ,    

         Id           INTEGER identity(1,1) )    

     ON [PRIMARY]    

      

     INSERT INTO #TMP_RESULTADO    

     SELECT     

            Usuario             

         ,  NumContrato     

         ,  NumEstructura     

         ,  NumFijacion     

         ,  FechaFijacion    

         ,  Valor     

     FROM   PRE_FIJACION     

  

      DECLARE @iReg   NUMERIC(9)    

         SET @iReg   = ( SELECT MAX( id ) FROM #TMP_RESULTADO )    

      DECLARE @Cont   NUMERIC(9)    

         SET @Cont   = ( SELECT MIN( id ) FROM #TMP_RESULTADO )    

      DECLARE @iRec   INTEGER    

         SET @iRec   = 0       

    

      Declare @Strike        float    

      Declare @FijacionValor numeric(18,4)     

      Declare @ForPag1      numeric(3)    

      Declare @ForPag2      numeric(3)    

      Declare @CodMon1      numeric(5)    

      Declare @CodMon2      numeric(5)    

      Declare @Modalidad    Char(1)    

      Declare @MtoMon1      numeric(21,6)    

      Declare @MtoMon2      numeric(21,6)    

      Declare @NumContrato    numeric(8)    

      Declare @NumEstructura  numeric(6)    

      Declare @NumFijacion    numeric(6)    

      Declare @PayOff         varchar(2)    

      Declare @FechaUltFijacion  datetime    

      Declare @FechaFijacion     datetime    

      Declare @FechaFijacionAnt  datetime    

      Declare @FolioCaja         numeric(8)    

      Declare @FechaPago         datetime    

      Declare @FD1               float    

      Declare @FD2               float    

      Declare @CaCajFolio        Numeric(8)    

      Declare @Subyacente        VarChar(5)    

      Declare @CV                VarChar(1)    

      Declare @CallPut           Varchar(5)    

      Declare @MTMImplicito      float    

      Declare @FechaProceso      Datetime    

      Declare @Msg               VarChar(80)    

      Declare @MTMMinimo         float    

      Declare @NewFecFijacion    Datetime    

      Declare @MdaCompensacion   numeric(5)    

      Declare @ValorMdaCompensacion float     

      -- MAP 14 Octubre Decimales de la compensacion.    

      Declare @Decimales         numeric(5)    

      Declare @MTMImplicitoML    numeric(10)   

  

      -- MAP 20130227  

      Declare @CodEstructura        varchar(10)    

      Declare @Puntos               float        

      Declare @CVEstructura         varchar(1)  

      Declare @LiquidaComoForward   varchar(1)  

      Declare @CaCajMtoMon1         numeric(21,6)  

      Declare @CaCajMtoMon2         numeric(21,6)  

      Declare @FechaLiquidacion     datetime  

        -- MAP 20130227    

    

      CREATE TABLE #CaCaja (    

         [CaNumContrato][NUMERIC](8) not NULL,    

         [CaNumEstructura][NUMERIC](6) not NULL,    

         [CaCajFolio][NUMERIC](8) not NULL )    

      ON [PRIMARY]    

          

      ALTER TABLE #CaCaja ADD     

      PRIMARY KEY  CLUSTERED     

      (    

      [CaNumContrato],    

      [CaNumEstructura],    

      [CaCajFolio]     

      ) WITH  FILLFACTOR = 90  ON [PRIMARY]     

    

      select @FechaProceso = fechaproc     

          ,  @MTMMinimo    = 10 * 1000.0 -- MTMMinimoParaEjercer, PENDIENTE: parametrizar,     

         from OpcionesGeneral    

    

  --ASVG_20130403 Contingencia en producción, deja fijaciones en 0 y altera MtM.  

     ---- MAP 20130227  

     ---- Se insertarán operaciones que no estén   

     ---- incluidas en la table de PREFIJACION fijación  

     ---- pero que sí tienen que liquidar hoy  

     --Insert into #TMP_RESULTADO  

     --Select  Usuario       = @Usuario  

     --     ,  NumContrato   = Det.CaNumContrato   

     --     ,  NumEstructura = Det.CaNumEstructura     

     --     ,  NumFijacion   = 0                -- Solo para que pague  

     --     ,  FechaFijacion = @FechaProceso   

     --     ,  Valor         = 0                -- Solo para que pague  

     -- FROM   CaDetContrato Det  

     --      , CaEncContrato Enc  

     -- where     Enc.CaNumContrato = Det.CaNumContrato  

     --       and Enc.CaEstado <> 'C'  

     --       and Enc.CaNumContrato not in ( Select NumContrato from PRE_FIJACION )   

     ---- MAP 20130227  

     Select @iReg = count(1) from #TMP_RESULTADO  

  

  

      -- Inicio Integridad transaccional    

      -- Begin Tran    

      

      WHILE @iReg >= @Cont    

      BEGIN    

   SELECT    

                @Strike = Det.CaStrike    

               ,@FijacionValor = ValFix.Valor    

               ,@NewFecFijacion = ValFix.FechaFijacion    

               ,@ForPag1 = case when Det.CaModalidad = 'C' then Det.CaFormaPagoComp  else Det.CaFormaPagoMon1 end  -- 17 de Septiembre    

               ,@ForPag2 = Det.CaFormaPagoMon2    

               ,@CodMon1 = case when Det.CaModalidad = 'C' then Det.CaMdaCompensacion else Det.CaCodMon1 end    

               ,@CodMon2 = case when Det.CaModalidad = 'C' then 0 else Det.CaCodMon2 end    

               ,@Modalidad = Det.CaModalidad    

               ,@MtoMon1 = Det.CaMontoMon1     

               ,@MtoMon2 = Det.CaMontoMon2  --select * from cadetContrato    

               ,@NumContrato = Det.CaNumContrato    

               ,@NumEstructura = Det.CaNumEstructura    

               ,@NumFijacion = Fix.CaFixNumero    

               ,@PayOff = Det.CaTipoPayOff    

               ,@FechaUltFijacion = Det.CaFechaFijacion    

               ,@FechaFijacion = Fix.CaFixFecha    

               ,@FechaPago     = Det.CaFechaPagoEjer    

               ,@FD1 = Det.CaWf_mon1    

               ,@FD2 = Det.CaWf_mon2    

               ,@Subyacente = Det.CaSubyacente    

               ,@CV         = Det.CaCVOpc    

               ,@CallPut    = Det.CaCallPut     

               ,@MdaCompensacion = Det.CaMdaCompensacion    

               -- MAP 20130227  

               ,@CodEstructura       = Enc.CaCodEstructura  

               ,@Puntos              = isnull( Det.CaPorcStrike , 0 )                 

               ,@CVEstructura        = Enc.CaCVEstructura  

               ,@LiquidaComoForward  = isnull( Estruc.OpcLiquidaComoForward, 'N' )  

               ,@FechaLiquidacion    = Det.CaFechaVcto  

               -- MAP 20130227  

  

    FROM   #TMP_RESULTADO ValFix    

         ,      CaDetContrato  Det    

         ,      CaEncContrato  Enc   

         ,      OpcionEstructura Estruc  

         ,      CaFixing       Fix    

            

         WHERE  Id    = @Cont    

         and Enc.CaNumContrato   = Det.CaNumContrato  

         and Enc.CaCodEstructura = Estruc.OpcEstCod  

         and Det.CaNumContrato   = ValFix.NumContrato    

         and Det.CaNumEstructura = ValFix.NumEstructura    

         and Fix.CaNumContrato   = ValFix.NumContrato     

         and Fix.CaNumEstructura = ValFix.NumEstructura    

         and ( Fix.CaFixNumero     = ValFix.NumFijacion  or ValFix.NumFijacion = 0 ) -- MAP 20130227  

    

--         select 'debug', * from #TMP_RESULTADO where id = @Cont    

--         select 'debug', '@Cont', @Cont  

    

         IF @@ERROR <> 0    

         BEGIN    

            select @msg = convert( varchar(80) ,  'Sp_Graba_FijacionPagos, lectura PRE_FIJACION' )    

            Goto ErrorProceso    

         END   

  

         -- MAP 20130418     

         -- Pantalla no registra moneda compensación  

         -- si no hay moneda para compensar se asume  

         -- CLP y por lo tanto solo se ajustará la pata   

         -- CLP de los Forward Acotados con Entrega Física  

         Select @CodMon1 = case when @CodMon1 = 0 then 999 else @CodMon1 end  

  

         

-- MAP 20130227     

--        -- Update de Fecha Fijacion si cumple     

--        -- los siguientes requisitos: fecha anterior a la fecha de proceso    

--        -- y la fecha original no es igual a la fecha de proceso    

--        -- Esto ultimo porque habria que investigar los disparos     

--        -- a Spot.    

--        if @NewFecFijacion <> @FechaFijacion begin    

--           -- Valida fecha Original    

--           -- Fecha fijacion original es anterior o     

--           -- igual a la fecha de proceso ? y no es asitiaca    

--    

--           -- NO se puede fijar el pasado a menos que se asiatica    

--           if @FechaFijacion <= @FechaProceso  and @PayOff  <> '02'     

--           begin    

--              select @Msg = convert( varchar(80) ,  'Fecha Fijacion original Pasada, Proceso Completo no realizado' )    

--              Goto ErrorProceso    

--           end    

--               

--           if @PayOff  = '02'     

--           begin    

--              if @FechaUltFijacion <= @FechaProceso     

--              begin    

--                 select @Msg = convert( varchar(80) ,  'Ultima Fecha Fijacion original Pasada, Proceso Completo no realizado' )    

--                 Goto ErrorProceso    

--              end    

--           end    

--           -- Nueva fecha es anterior o igual     

--           -- a la fecha de proceso ? y no es asitica    

--           if @NewFecFijacion <= @FechaProceso and  @PayOff  <> '02'      

--           begin    

--              select @Msg = convert( varchar(80) ,  'Nueva Fecha Fijacion Pasada, Proceso Completo no realizado' )    

--              Goto ErrorProceso    

--           end    

--    

--           if @PayOff  = '02'     

--           begin    

--              if @NewFecFijacion >= @FechaUltFijacion      

--              begin    

--                 select @Msg = convert( varchar(80) ,  'Nueva Fijacion Supera ultima fecha de fijacion Proceso Completo no realizado' )    

--                 Goto ErrorProceso    

--              end    

--           end    

--           -- PENDIENTE:     

--           -- Validar que no exista otro registro con la misma fecha    

--           -- rescatar valor de fijacion?, solo si es Asiatico     

--           -- y anterior a la fecha de proceso.    

--    

--            -- Finalmente Update de Fecha de Fijación    

--           Update CaFixing    

--              set CaFixFecha = @NewFecFijacion      

--           where  CaNumCOntrato   = @NumContrato     

--              and CaNumEstructura = @NumEstructura     

--              and CaFixNumero     = @NumFijacion       

--           IF @@ERROR <> 0    

--           BEGIN    

--              select @Msg = convert( varchar(80) ,  'Sp_Graba_FijacionPagos, Update CaFechaFixing' )    

--              Goto ErrorProceso    

--        END          

--           -- Si es la ultima fijacion de una asiatica    

--           -- o no es asiatica         

--           if @PayOff  <> '02' or ( @FechaUltFijacion = @NewFecFijacion and @PayOff  = '02' )    

--           begin    

--              -- Update de Fecha de Fijación en Det Contrato,    

--              Update CaDetContrato     

--                 set CaFechaFijacion = @NewFecFijacion      

--              where  CaNumCOntrato   = @NumContrato     

-- and CaNumEstructura = @NumEstructura     

--           end    

--    

--        End    

    

    

         -- Update de Fijación    

         Update CaFixing    

              set CaFijacion  = @FijacionValor     

               ,  CaFixEstado = ( Case when @FechaProceso >= CaFixFecha then  'F' else '' end )    

         where  CaNumCOntrato   = @NumContrato     

            and CaNumEstructura = @NumEstructura     

            and CaFixNumero     = @NumFijacion       

         IF @@ERROR <> 0    

         BEGIN    

            select @Msg = convert( varchar(80) ,  'Sp_Graba_FijacionPagos, Update CaFijacion' )    

            Goto ErrorProceso    

         END    

  

-- MAP 20130227           

--         if @PayOff  = '02' and @FechaUltFijacion > @FechaFijacion -- Asiático y NO es la ultima fijacion    

--         BEGIN                

--            GOTO ProximaOperacion    

--         END   

-- MAP 20130227           



         if @FechaLiquidacion <> @FechaProceso -- Asiático y solo entró a fijar    

         BEGIN                

            GOTO ProximaOperacion    

         END    

  

         -- Calculo del MTM Implícito    

         Select @MTMImplicito = 0    

         if @Subyacente in ( 'FX' ) Begin    

            if @PayOff  = '02'   Begin -- Asiatica, se debe calcular @FijacionValor con los pesos de Fijaciones    

                if @LiquidaComoForward <> 'S' Begin  

                   select @FijacionValor = sum( CaPesoFij * CaFijacion / 100.0 )     

                       from cafixing where CaNumCOntrato   = @NumContrato     

                                           and CaNumEstructura = @NumEstructura     

                   select @FijacionValor = ROUND( @FijacionValor, 2 /*Case when @CodMon1 in ( 13, 142 ) then 2 else 4 end */ )    

                End  

                Else  

                Begin    

                   -- MAP 20130227    

                   select @Strike        = 0  

                   select @Strike        = ROUND( sum( CaPesoFij * CaFijacion / 100.0 ) , 2 ) --PRD_18409

                       from cafixing  where CaNumCOntrato   = @NumContrato     

                                           and CaNumEstructura = @NumEstructura     

                                           and CaPesoFij < 0                 

  

                   select @Strike = abs( @Strike - @Puntos )  

  

                   select @FijacionValor = sum( CaPesoFij * CaFijacion / 100.0 )     

                       from cafixing where CaNumCOntrato   = @NumContrato     

                                           and CaNumEstructura = @NumEstructura     

                                           and CaPesoFij >= 0  

  

                   select @FijacionValor = round( @FijacionValor, 2 /*Case when @CodMon1 in ( 13, 142   ) then 2 else 4 end */ )    

                End                           

            end    

            -- Calculo de Compensación como si   

            -- fueran opciones.     

            if @CV = 'C' and  @CallPut = 'Call'  begin     

               select @MTMImplicito = ( @FijacionValor - @Strike ) * @MtoMon1      

               select @MTMImplicito = case when @MTMImplicito > 0 then @MTMImplicito else 0 end     

            end    

            if @CV = 'C' and  @CallPut = 'Put'  begin     

               select @MTMImplicito = ( @Strike - @FijacionValor ) * @MtoMon1      

               select @MTMImplicito = case when @MTMImplicito > 0 then @MTMImplicito else 0 end     

            end         

            if @CV = 'V' and  @CallPut = 'Call'  begin     

               select @MTMImplicito = ( @Strike - @FijacionValor ) * @MtoMon1      

               select @MTMImplicito = case when @MTMImplicito < 0 then @MTMImplicito else 0 end     

            end    

            if @CV = 'V' and  @CallPut = 'Put'  begin     

               select @MTMImplicito = ( @FijacionValor - @Strike ) * @MtoMon1      

               select @MTMImplicito = case when @MTMImplicito < 0 then @MTMImplicito else 0 end     

            end  

            -- MAP 20130227     

            if @LiquidaComoForward = 'S'  

            begin                  

                select @MTMImplicito = ( @FijacionValor - @Strike ) * @MtoMon1   

                                     *   Case when @CVEstructura = 'C' then 1.0 else -1.0 end     

  

                --select 'Debug @NumContrato',@NumContrato, '@MTMImplicito', @MTMImplicito, '@FijacionValor', @FijacionValor, '@Strike', @Strike, '@MtoMon1', @MtoMon1  

            end   

            -- MAP 20130227  

  

         end -- Calculo MTM Implícito para FX, cambiará según subyacente    

    

         select @ValorMdaCompensacion = isnull( ( select vmvalor from BacParamSudaVALOR_MONEDA     

                   where vmcodigo = ( Case when @MdaCompensacion = 13 then 994 else @MdaCompensacion end )    

                                                       and vmfecha = @FechaProceso ) , 1 )      

         

         select @MTMImplicitoML =  @MTMImplicito    

         select @MTMImplicito = @MTMImplicito / @ValorMdaCompensacion     

         --select 'debug', '@MdaCompensacion', @MdaCompensacion, '@ValorMdaCompensacion', @ValorMdaCompensacion   

         select @Decimales = 0    

         select @Decimales = mndecimal from lnkbac.BacparamSuda.dbo.Moneda  where mncodmon = @MdaCompensacion    

    

         select @MTMImplicito = round( @MTMImplicito, @Decimales )      

  

         delete CaCaja    

             where CaNumContrato = @NumContrato    

             and    CaNumEstructura = @NumEstructura      

             and    CaCajOrigen     = 'PV'    

    

         -- Generando Folio de Caja    

         INSERT INTO #CaCaja      

         select CaNumCOntrato, CaNumEstructura, CaCajFolio from CaCaja CajVig    

         where   CajVig.CaNumContrato = @NumContrato    

           and CajVig.CaNumEstructura = @NumEstructura    

         union select CaNumContrato, CaNumEstructura, CaCajFolio from CaVenCaja   CajVen        

         where   CajVen.CaNumContrato = @NumContrato    

             and CajVen.CaNumEstructura = @NumEstructura    

             

         select @CaCajFolio = 0    

         select @CaCajFolio = isnull(  max( CaCajFolio ) , 0 )    

             from #CaCaja     

             where  CaNumContrato = @NumContrato    

             and    CaNumEstructura = @NumEstructura     

         select @CaCajFolio = @CaCajFolio + 1    

    

         -- MAP 20130227  

         -- Establecer Monto 1 y Monto 2 del Pago  

         if @LiquidaComoForward = 'S'  

         Begin  

             Select @CaCajMtoMon1    = Case when @Modalidad = 'C' then   

                                                 @MTMImplicito   

                                       else    

                                           case when @CVEstructura = 'C' then  @MtoMon1    

                                           else  -@MtoMon1  end  

                                       end  

             Select @CaCajMtoMon2    = Case when @Modalidad = 'C' then   

                                                  0   

                         else    

                                           case when @CVEstructura = 'C' then -@MtoMon2    

                                           else +@MtoMon2 end                                           

                                       end  

         end  

         else  

         Begin  

             Select @CaCajMtoMon1    = Case when @Modalidad = 'C' then @MTMImplicito else    

                                           case when @CV = 'C' and  @CallPut = 'Call' then  @MtoMon1    

                                           when @CV = 'C' and  @CallPut = 'Put'  then -@MtoMon1    

                                                when @CV = 'V' and  @CallPut = 'Call' then -@MtoMon1    

                             when @CV = 'V' and  @CallPut = 'Put'  then  @MtoMon1 end    

                                           end   

             Select @CaCajMtoMon2    = Case when @Modalidad = 'C' then 0 else    

                                           case when @CV = 'C' and  @CallPut = 'Call' then -@MtoMon2    

                                            when @CV = 'C' and  @CallPut = 'Put'  then  @MtoMon2    

                                                when @CV = 'V' and  @CallPut = 'Call' then  @MtoMon2    

                                                when @CV = 'V' and  @CallPut = 'Put'  then +@MtoMon2 end    

                                           end    

         End  

         -- MAP 20130227    

    

    

         Insert into CaCaja  -- select * from CaCAja             

              Select CaNumContrato   = @NumContrato    

                   , CaNumEstructura = @NumEstructura    

                   , CaCajFolio      = @CaCajFolio    

                   , CaCajFechaGen   = @FechaProceso    

                   , CaCajFecPago    = @FechaPago    

                   , CaCajFDeMon1    = @FD1    

                   , CaCajMtoMon1    = @CaCajMtoMon1    

                   , CaCajFDeMon2    = @FD2    

                   , CaCajMtoMon2    = @CaCajMtoMon2    

                   -- Decicion automática de ejercer    

                   -- Pantalla para ejercer puede cambiar     

                   -- la decición de las entregas físicas    

                   -- MAP 06 de Octubre    

                   -- 1. Todo lo Menor en terminos absolutos a MTMMinimo quedará pendiente    

                   -- 2. Si la modalidad es entrega fisica se deja pendiente.    

    

                   -- Elizabeth Cerda Castillo, 12 Nov. : todo debe quedar pendiente de toma de decision.          

                   , CaCajEstado     = 'P' /* Case when  abs( @MTMImplicitoML ) - abs( @MTMMinimo ) >= 0     

                                                  and @Modalidad <> 'E'    

                                                  then   -- Operacion sera ejercida     

                                                       'E'      

                                -- Operacion quedara pendiente:     

                                                         -- MTM menores o son Entregas Fisicas.     

                                                  else case when @MTMImplicito = 0 then 'N' else 'P' end end    

                                             */     

                   , CaMTMImplicito  = @MTMImplicitoML -- @MTMImplicito  PRD Cont. EF  

                   , CaCajFormaPagoMon1 = @ForPag1    

                   , CaCajFormaPagoMon2 = @ForPag2    

                   , CaCajMdaM1         = @CodMon1    

                   , CaCajMdaM2         = @CodMon2    

                   , CaCajOrigen        = 'PV'        

                   , CaCajMotorPago     = 'P'    

                   , CaCajModalidad     = @Modalidad    

                   , CaCajFechaPagMon1  = @FechaPago    -- Debiera calcular valutas !!!    

                   , CaCajFechaPagMon2  = @FechaPago    

    

    

         IF @@ERROR <> 0    

         BEGIN    

            select @Msg = convert( varchar(80) ,  'Sp_Graba_FijacionPagos, Insert CaCaja' )    

            Goto ErrorProceso    

         END    

    

      -- MAP 08 Octubre    

         update CaDetContrato    

               set   CaVrDet = CaMTMImplicito  -- Está en CLP POR HACER dividir    

                   , CaVrDetML = CaMTMImplicito     

               from CaCaja Caj    

               where   Caj.CaNumContrato = CaDetContrato.CaNumContrato    

                   and Caj.CaNumEstructura = CaDetContrato.CaNumEstructura                       

                   and CaFechaPagoEjer <= @FechaProceso    

                      

    

ProximaOperacion:    

         SET @Cont = @Cont + 1    

      END    

    

FinProceso:    

  

      -- AJUSTES DE LOS MOVIMIENTOS DE CAJA DE CONTRATOS MIXTOS EN MODALIDAD  

      -- CONTRATO MIXTO GENERARÁ SIEMPRE UNA SOLA ENTREGA FISICA JUNTANDO  

      -- EL MONTO COMPENSADO EN LOS USD O EN LOS CLP.  

  

   -- 1. Eliminar todos los registros con MTM implícito igual a cero (ojo con los Forward Americano)        

      --delete CaCaja where CaMTMImplicito = 0 and CaNumContrato in ( select NumContrato from PRE_FIJACION )                                                                                           

      --             and CaCajOrigen <> 'PP'  

      -- No se eliminarán nunca mas los registros de caja pues se afecta  

      -- la contabilidad que rebaja la prima de la cartera  

  

      IF @@ERROR <> 0  

      BEGIN  

         select @Msg = convert( varchar(80) ,  'Sp_Graba_FijacionPagos, Delete CaCaja' )  

         Goto ErrorProceso  

      END  

  

           -- 2. Ajustar los montos de los registros de Entrega Física para que incluyan la compensación adjunta.        

      Select  CaNumContrato                             

           ,  Mixto = 0  

        into #ContratosMixtos  

        from CaCaja  

      where caCajModalidad = 'C'  

       

      update  #ContratosMixtos   

          set Mixto = 1  

        from CaCaja where CaCajModalidad = 'E' and #ContratosMixtos.CaNumCOntrato = CaCaja.CanumCOntrato  

  

      delete #ContratosMixtos where Mixto = 0  

  

      -- 3. Ajustar el registro de Caja de los contratos mixtos   

       update CaCaja  

         Set  

               CaCajMtoMon1   =  CaCajMtoMon1 + isnull( ( select sum( CaCajMtoMon1 )   

                                                   from CaCaja Caj   

                                                     where Caj.CanumContrato = CaCaja.CaNumContrato and  

                                                           Caj.CaCajModalidad = 'C' and  

                                                           Caj.CaCajMdaM1 <> 999 ) -- Compensa USD  

                                                          , 0 )  

                

             , CaCajMtoMon2   =  CaCajMtoMon2 + isnull( ( select sum( CaCajMtoMon1 )   

                                                   from CaCaja Caj   

                                                     where Caj.CanumContrato = CaCaja.CaNumContrato and  

                                                           Caj.CaCajModalidad = 'C' and  

                                                           Caj.CaCajMdaM1 = 999 ) -- Compensa CLP  

                                                          , 0 )  

             , CaMTMImplicito =  CaMTMImplicito +  isnull( ( select sum( CaCajMtoMon1 )             -- PRD XXXX

                                                   from CaCaja Caj   

                                                     where Caj.CanumContrato = CaCaja.CaNumContrato and  

                                                           Caj.CaCajModalidad = 'C' and  

                                                           Caj.CaCajMdaM1 = 999 ) -- Compensa CLP  

                                                          , 0 )  

       where CaNumContrato in ( select CaNumCOntrato from #ContratosMixtos )  

            and CaCaja.CaCajModalidad = 'E'  

            and CaCaja.CaMTMImplicito <> 0  -- MAP 20130620

  

      -- 3. Eliminar el registro de compensación de una operación mixta.  

      --    Dado que en este caso no hay prima no hay problemas  

      --    Caso Forward Acotado por Entrega Física.

      delete CaCaja where CaCajModalidad = 'C' and CaNumContrato in ( select CaNumCOntrato from #ContratosMixtos )  

  

  

      delete PRE_FIJACION    

      IF @@ERROR <> 0    

      BEGIN    

         select @Msg = convert( varchar(80) ,  'Sp_Graba_FijacionPagos, Delete Pre_Fijacion' )    

         Goto ErrorProceso    

      END    

  

  

      -- Commit    

      DROP TABLE #TMP_RESULTADO    

      Select Resultado = convert( Varchar(2) , 'OK' ), Mensaje = Convert( varchar(80), 'PROCESO GRABA FIJACION Y PAGOS OK' )    

      return    

ErrorProceso:    

      Select Resultado = convert( Varchar(2) , 'ER' ), Mensaje = Convert( varchar(80), @Msg )    

      -- Rollback     

      return    

END

    
GO
