USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_CALCULO_LCR]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Object:  Stored Procedure dbo.SP_CALCULO_LCR    Script Date: 09-02-2011 17:50:50 ******/
CREATE Procedure [dbo].[SP_CALCULO_LCR]( 
                     @Sistema          char(3)
                   , @Numero_operacion numeric(10) -- NUmero de Operacion
                 ) As
Begin
-- sp_Calculo_LCR 'PCS', 81 -- con avr positivo
-- sp_Calculo_LCR 'BFW', 19402
-- sp_Calculo_LCR 'BFW', 20964

    SET NOCOUNT ON
    declare @cProducto  char(05)
    declare @Capital_A  float
    declare @Capital_P  float
    declare @Plazo_A    NUMERIC(18,6)       
    declare @Plazo_P    NUMERIC(18,6)       
    declare @Moneda_A   NUMERIC(5)    
    declare @Moneda_P   NUMERIC(5)    
    declare @Duration_A FLOAT         
    declare @Duration_P FLOAT         
    declare @dFecPro    datetime
    declare @SubTotal   Float
    declare @TotalGeneral float

    declare @LargoObservacion_Lineas integer
    declare @Observacion_Lineas      char(255)
    declare @Observacion_Grabacion   char(200)

    declare @vRazonable  Float

    declare @fechaCierre datetime

    -- Tomar una fecha de proceso 
    select @dFecPro = acfecproc from bactradersuda..mdac


    declare @Serie_Valor char(12)
    declare @Tipo_Oper   char(1)
    declare @M_Durat     float

    IF @Sistema = 'PCS'   Begin
        select @Tipo_Oper = 'C'

        SELECT 
        @FechaCierre = fecha_Cierre, 
        @cProducto   = rtrim( ltrim( convert(char(05), tipo_Swap ) ) ) ,
        @Capital_A   = compra_capital + compra_flujo_adicional  ,
        @Plazo_A     = (CASE  WHEN Compra_codigo_tasa  = 0 -- Tasa Fija
          THEN  DATEDIFF(d,@dFecPro,fecha_Termino)
          ELSE  DATEDIFF(d,@dFecPro,fecha_vence_Flujo)
          END),     
        @Moneda_A    = compra_moneda,     
        @Duration_A  = vDurMacaulActivo
                  FROM BACSWAPSUDA..cartera
                 WHERE numero_operacion = @Numero_operacion
                   and Tipo_flujo  = 1
                   AND Estado_Flujo = 1
               
        SELECT @Capital_P   = venta_capital + venta_flujo_adicional,  
        @Plazo_P     = (CASE  WHEN Venta_codigo_tasa  = 0
          THEN  DATEDIFF(d,@dFecPro,fecha_termino)
          ELSE  DATEDIFF(d,@dFecPro,fecha_vence_flujo)
          END),   
        @Moneda_P    = venta_moneda,
        @Duration_P  = vDurMacaulPasivo
                  FROM BACSWAPSUDA..cartera
                   WHERE numero_operacion = @Numero_operacion
                     and Tipo_flujo  = 2
                     AND Estado_Flujo = 1

        select @vRazonable = 0		
        SELECT @vRazonable= Valor_RazonableCLP 
           FROM   BacSwapSuda..CARTERA
           WHERE  numero_operacion    = @Numero_operacion
           AND   (    estado_flujo = 1 and fecha_termino > @dFecPro   -- Vigente , Ojo !!!!, hay un error en el proceso
           or estado_flujo = 2 and fecha_termino = @dFecPro )
--select '@vRazonable', @vRazonable
    end
    ELSE  -- Forward
    Begin
        select @vRazonable = 0
	SELECT	@vRazonable = fRes_Obtenido 
	FROM    BacFwdSuda..MFCA
	WHERE   canumoper          = @Numero_operacion
	AND     cafecha            < @dFecPro         

  
        SELECT 
                    @Serie_Valor = caserie,
                    @Tipo_Oper   = catipoper,
                    @Capital_A   = (CASE catipoper WHEN 'C' 
                                       THEN camtomon1 
                                       ELSE ( case when cacodpos1 = 10 then caequusd1 else  camtomon2 end )
                                    END ),
                    @Capital_P   = (CASE catipoper WHEN 'C' 
                                       THEN ( case when cacodpos1 = 10 then caequusd1 else  camtomon2 end ) 
                                       ELSE camtomon1
                                    END ),     
                    --@Plazo_A     = DATEDIFF(D,@dFecPro,cafecEfectiva),     
                    @Plazo_A     =(CASE WHEN DATEDIFF(D,@dFecPro,cafecEfectiva) < 0 
                                        THEN 0
                                        ELSE DATEDIFF(D,@dFecPro,cafecEfectiva)
                                    END  ) ,      
                    --@Plazo_P     = DATEDIFF(D,@dFecPro,cafecEfectiva),     
                    @Plazo_P     = ( CASE WHEN  DATEDIFF(D,@dFecPro,cafecEfectiva) < 0   THEN 0 
                     ELSE DATEDIFF(D,@dFecPro,cafecEfectiva)
                                         END), 
                    @Moneda_A    = (CASE catipoper WHEN 'C' 
                                      THEN CaCodMon1 
                                       ELSE CaCodMon2 
                                    END ),     
                    @Moneda_P    = (CASE catipoper WHEN 'C' 
                                       THEN CaCodMon2 
                                       ELSE CaCodMon1 
                                    END ),
                     --@Duration_A  = ROUND(DATEDIFF(D,@dFecPro,cafecEfectiva) / 365.0 ,4) ,     
                     @Duration_A  = (CASE WHEN DATEDIFF(D,@dFecPro,cafecEfectiva) < 0 
                                          THEN 0 
                                           ELSE ROUND(DATEDIFF(D,@dFecPro,cafecEfectiva) / 365.0 ,4)
                                     END  ),
                     -- @Duration_P  = ROUND(DATEDIFF(D,@dFecPro,cafecEfectiva) / 365.0 , 4),
                     @Duration_P  = (CASE WHEN  DATEDIFF(D,@dFecPro,cafecEfectiva) < 0 
                                          THEN 0
                                          ELSE ROUND(DATEDIFF(D,@dFecPro,cafecEfectiva) / 365.0 , 4)
                                     END ),

                     @cProducto = cacodpos1 ,
                     @M_Durat       = catasfwdcmp

                FROM BACFWDSUDA..MFCA
               WHERE canumoper = @Numero_operacion

	       IF @M_Durat =0 AND  @cProducto =10
                  Execute SP_BUSCA_DURATION  @Serie_Valor  ,   --Papel 
                                           @dFecPro  ,
                                           @M_Durat   OUTPUT


  		SELECT @M_Durat  =(CASE WHEN  @cProducto =10 
					THEN @M_Durat  
					ELSE @Duration_A    -- Procedimiento no esta apto para T-LOCK
				   END)


               -- SELECT ' @M_Durat' , @M_Durat
               SELECT @Duration_A  =(CASE catipoper WHEN 'C' 
                                       THEN @M_Durat 
                                       ELSE @Duration_A
                                    END ) ,     
                      @Duration_P  = (CASE catipoper WHEN 'C' 
                                       THEN @Duration_p
                                       ELSE @M_Durat
                                    END )
                 FROM  BACFWDSUDA..MFCA
                WHERE canumoper = @Numero_operacion
                  AND cacodpos1 IN(10,11)
        END 

        EXEC BacLineas..SP_IMPUTACION_LCR_DERIVADOS @Numero_operacion, 
                                                 @Sistema ,
                                                 @cProducto,
                                                 @Tipo_Oper,
                                                 @Capital_A,  
                                                 @Capital_P,
                                                 @Plazo_A,
                                                 @Plazo_P,
                                                 @Moneda_A,
                                                 @Moneda_P,
                                                 @Duration_A,
                                                 @Duration_P,
                                                 @dFecPro, 
                                                 @SubTotal output 	

                -- select 'debug', '@SubTotal', @SubTotal

 
    

        EXECUTE BacLineas..SP_LCR_VRAZONABLE_NEGATIVO @dFecPro, @Sistema, @Numero_operacion, @SubTotal, @vRazonable, @TotalGeneral OUTPUT

        declare @NoCalculo char(20)
        select  @NoCalculo = ''
        --if null( @TotalGeneral )
        --select  @NoCalculo = ' Falló Cálculo LCR ' 
        if @TotalGeneral is null
            select  @NoCalculo = ' Falló Cálculo LCR ' 

--        select  @TotalGeneral = isnull( @TotalGeneral, 0 )

	 Select Numero_operacion = @Numero_operacion, 
                Modulo           =  @Sistema,
                Producto         =  @cProducto,
                Tipo_OP          = @Tipo_Oper,
                Capital_Activo   = @Capital_A + 0.0000001,  
                Capital_Pasivo   = @Capital_P + 0.0000001,
                Plazo_Activo     = @Plazo_A   + 0.0000001,
                Plazo_Pasivo     = @Plazo_P   + 0.0000001,
                Moneda_Activa    = @Moneda_A  + 0.0000001,
                Moneda_Pasiva    = @Moneda_P  + 0.0000001,
                Duration_Activa  = @Duration_A + 0.0000001,
                Duration_Pasiva  = @Duration_P + 0.0000001,
                AddOn            = @SubTotal   + 0.0000001, 
                vRazonable      = @vRazonable  + 0.0000001,
                Total_Final      = @TotalGeneral + 0.0000001 

	SET NOCOUNT OFF       

End

GO
