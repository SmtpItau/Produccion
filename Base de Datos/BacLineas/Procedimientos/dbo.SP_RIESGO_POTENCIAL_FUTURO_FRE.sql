USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_RIESGO_POTENCIAL_FUTURO_FRE]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_RIESGO_POTENCIAL_FUTURO_FRE]
   (   @nNumoper         NUMERIC(10)  
   ,   @cSistema         CHAR(03)  
   ,   @cProducto        CHAR(05)  
   ,   @Tipo_Operacion   CHAR(1)  
   ,   @Capital_Activo   FLOAT  
   ,   @Capital_Pasivo   FLOAT   -- PROD XXXXX Netting para la Corredora  
   ,   @Plazo_Activo     NUMERIC(18,6)  
   ,   @Plazo_Pasivo     NUMERIC(18,6)  
   ,   @Moneda_Activo    NUMERIC(5)  
   ,   @Moneda_Pasivo    NUMERIC(5)  
   ,   @Duration_Activo  FLOAT  
   ,   @Duration_Pasivo  FLOAT  
   ,   @Fecha_Proceso    DATETIME  
   ,   @Monto            FLOAT        OUTPUT  
   ,   @Prc              FLOAT        OUTPUT  
   )  
AS  
BEGIN    
  
   SET NOCOUNT ON   
  
   DECLARE @C_LCRParMdaGruMda CHAR(8)  
  
   DECLARE @Codigo_riesgo     INTEGER  -- Ponderadores.Codigo_riesgo  
   DECLARE @Plazo1            FLOAT    -- Ponderadores.LCRPla  
   DECLARE @Plazo2            FLOAT    -- Ponderadores.LCRPla  
   DECLARE @Pon1              FLOAT    -- Ponderadores.LCRPon  
   DECLARE @Pon2              FLOAT    -- Ponderadores.LCRPon  
   DECLARE @InputPlazo        FLOAT    -- Plazo de rescate
   DECLARE @TipoBidAsk        VARCHAR(3)  
   DECLARE @TipoRiesgo		  INT
  
       declare @fechaProc      datetime  
       SET @fechaProc         = CASE WHEN @cSistema = 'PCS' THEN ( SELECT fechaproc FROM BacSwapSuda.dbo.SWAPGENERAL ) --> with(nolock))  
                                     ELSE                        ( SELECT acfecproc FROM BacFwdSuda.dbo.MFAC         ) --> with(nolock))  
                                END  
  
        declare @dFechaayer     datetime  
       SET @dFechaayer        = CASE WHEN @cSistema = 'PCS' THEN ( SELECT fechaant  FROM BacSwapSuda.dbo.SWAPGENERAL ) --> with(nolock))  
                                     ELSE                        ( SELECT acfecante FROM BacFwdSuda.dbo.MFAC         ) --> with(nolock))  
                                END  
  
  
  
   -- 0. Convertir los pasos en años  
       SET @Plazo_Activo       = @Plazo_Activo / 365.0000000000  
       SET @Plazo_Pasivo       = @Plazo_Pasivo / 365.0000000000  
  
        Select @InputPlazo = case when @Duration_Activo > @Duration_Pasivo then @Duration_Activo else @Duration_Pasivo end   
          
        -- 1. Determinar el par de monedas  
        --    Si el par de monedas de parametro no existe   
        --    se le asociará el par 'MX'  
      SET @c_lcrparmdagrumda = 'MX'  

	SELECT @c_lcrparmdagrumda = lcrgrumdacod   
     FROM LCRPARMDAGRUMDA  
               where LCRParMda1 = @Moneda_Activo  
               and   LCRParMda2 = @Moneda_Pasivo  
  
   SELECT @C_LCRParMdaGruMda = lcrgrumdacod   
     FROM LCRPARMDAGRUMDA  
               where LCRParMda1 = @Moneda_Pasivo  
               and   LCRParMda2 = @Moneda_Activo  
  

  
        -- 2. Corrección del Código de Producto para el caso SWAP  
        if @cSistema = 'PCS' and @cProducto not in ( 'ST', 'SM', 'SP', 'FR' )   
      SET @cProducto = CASE WHEN @cProducto = '1' THEN 'ST'  
                             when @cProducto = '2' then 'SM'  
                             when @cProducto = '3' then 'FR'  
                            WHEN @cProducto = '4' THEN 'SP'  
                       END  
  
   IF @cSistema = 'PCS' AND @cProducto = 'SM'  
   BEGIN  
      EXECUTE dbo.CALCULO_RIESGO_POTENCIAL_SWAP @nNumoper  
                                           ,    @cSistema  
                                           ,    @cProducto  
										   ,    @fechaProc  
                                           ,    @Moneda_Activo  
                                           ,    @Moneda_Pasivo  
                                           ,    @C_LCRParMdaGruMda  
                                           ,    @Monto             OUTPUT  
                                           ,    @prc               OUTPUT  
  
      INSERT INTO dbo.DEBUG_VALORES
      SELECT @cSistema + ' ' + LTRIM(RTRIM( @nNumoper )) + '00@prc Metodologia 2009', @prc, '@Monto', @Monto  
  
      RETURN  
   END  

     
     -- 2. Determinar el ponderador interpolando  
        -- 2.1 Obtención del plazo Menor o Exacto


		SELECT  @Codigo_riesgo =  Riesgo_Interno
		FROM	BacparamSuda.dbo.PRODUCTO with(nolock)
		WHERE	codigo_producto = @cProducto AND id_sistema = @cSistema



		SET @TipoBidAsk = CASE			--PRD20426
							WHEN @Codigo_riesgo = 2 THEN CASE				--BFW siempre trae C o V, pero si el riesgo no es 2 son NA
								WHEN @Tipo_Operacion = 'C' THEN 'ASK'
								WHEN @Tipo_Operacion = 'V' THEN 'BID'
								ELSE 'NA'
							END
							ELSE 'NA'
					      END

		if @cProducto ='OPT'
		begin
		select 'no americano'
		if (select top 1 CaCodEstructura from LnkOpc.CbMdbOpc.dbo.caenccontrato where canumcontrato=@nNumoper) in ( 5 , 8 )
			begin
				select 'americano'
				SET @TipoBidAsk = CASE			
							WHEN @Codigo_riesgo = 2 THEN CASE				
								WHEN @Tipo_Operacion = 'V' THEN 'ASK' --se invierte el sentido para BID y ASK
								WHEN @Tipo_Operacion = 'C' THEN 'BID'
								ELSE 'NA'
							END
							ELSE 'NA'
					      END
			end
		end
		

		

select 'ini',@C_LCRParMdaGruMda,@InputPlazo,@TipoBidAsk

        Select   @Plazo1 = Ponderadores.LCRPla  
        , @Pon1   = Ponderadores.LCRPon
               from    LCRRieParMdaPon  Ponderadores  
                     , BacParamSuda..Producto Producto
               where     Producto.Riesgo_Interno = @Codigo_riesgo  
	             and Ponderadores.codigo_riesgo = Producto.Riesgo_Interno  -- MAP 09-Sep-2014 Error desde siempre !!!
                     and Producto.Id_Sistema     = @cSistema  
                     and Codigo_Producto         = (CASE WHEN @cProducto = '14' THEN '1' ELSE @cProducto END)  
                     and Ponderadores.LCRGruMdaCod = @C_LCRParMdaGruMda   
                     and Ponderadores.LCRPla <= @InputPlazo
		     and Ponderadores.lcrTipoBID_ASK = @TipoBidAsk  --PRD20426
        order by Codigo_Producto, Codigo_Riesgo, Ponderadores.LCRGruMdaCod, LCRPla  


        Select   'Plazo1',Ponderadores.LCRPla,Ponderadores.LCRPon,*
               from    LCRRieParMdaPon  Ponderadores  
                     , BacParamSuda..Producto Producto
               where     Producto.Riesgo_Interno = @Codigo_riesgo  
	             and Ponderadores.codigo_riesgo = Producto.Riesgo_Interno  -- MAP 09-Sep-2014 Error desde siempre !!!
                     and Producto.Id_Sistema     = @cSistema  
                     and Codigo_Producto         = (CASE WHEN @cProducto = '14' THEN '1' ELSE @cProducto END)  
                     and Ponderadores.LCRGruMdaCod = @C_LCRParMdaGruMda   
                     and Ponderadores.LCRPla <= @InputPlazo
		     and Ponderadores.lcrTipoBID_ASK = @TipoBidAsk  --PRD20426
        order by Codigo_Producto, Codigo_Riesgo, Ponderadores.LCRGruMdaCod, Ponderadores.LCRPla  

  
        -- 2.2 Obtención del plazo Mayor  
        Select   @Plazo2 = Ponderadores.LCRPla  
               , @Pon2   = Ponderadores.LCRPon                  
               from    LCRRieParMdaPon  Ponderadores  
                     , BacParamSuda..Producto Producto  
               where     Producto.Riesgo_Interno = Codigo_Riesgo  
			   and Ponderadores.codigo_riesgo = Producto.Riesgo_Interno  -- MAP 09-Sep-2014 Error desde siempre !!!
                     and Producto.Id_Sistema     = @cSistema  
                     and Codigo_Producto         = (CASE WHEN @cProducto = '14' THEN '1' ELSE @cProducto END)  
                     and Ponderadores.LCRGruMdaCod = @C_LCRParMdaGruMda   
                     and Ponderadores.LCRPla > @InputPlazo  
		     and Ponderadores.lcrTipoBID_ASK = @TipoBidAsk --PRD20426
        order by Codigo_Producto, Codigo_Riesgo, Ponderadores.LCRGruMdaCod, LCRPla desc  

        Select   'Plazo2',Ponderadores.LCRPla,Ponderadores.LCRPon,*
               from    LCRRieParMdaPon  Ponderadores  
                     , BacParamSuda..Producto Producto  
               where     Producto.Riesgo_Interno = Codigo_Riesgo  
			   and Ponderadores.codigo_riesgo = Producto.Riesgo_Interno  -- MAP 09-Sep-2014 Error desde siempre !!!
                     and Producto.Id_Sistema     = @cSistema  
                     and Codigo_Producto         = (CASE WHEN @cProducto = '14' THEN '1' ELSE @cProducto END)  
                     and Ponderadores.LCRGruMdaCod = @C_LCRParMdaGruMda   
                     and Ponderadores.LCRPla > @InputPlazo  
		     and Ponderadores.lcrTipoBID_ASK = @TipoBidAsk --PRD20426
        order by Codigo_Producto, Codigo_Riesgo, Ponderadores.LCRGruMdaCod, Ponderadores.LCRPla desc  

SELECT 'OJO',@Plazo2,@Plazo1
  
        -- 2.3 Detección de extremos  
   SET @prc = NULL  
  
   IF @Plazo2 IS NULL    -- último plazo superior  
      SET @prc =  @Pon1   
  
   IF @Plazo1 IS NULL    -- primer plazo inferior
      SET @prc = @Pon2   

   IF @prc IS NULL       -- Condicion de Interpolación
   BEGIN                 
    --SET @prc = @pon1 + (@pon2 - @pon1) * (@InputPlazo - @Plazo1) / (@Plazo2 - @Plazo1)   --ORIGINAL
      SET @prc = @pon1 + (@InputPlazo - @Plazo1) * (@Pon2 - @Pon1) / (@Plazo2 - @Plazo1)   --MODIFICADO
      SET @prc = ISNULL(@prc, 0)  
   END  
  
   DECLARE @nValorMoneda   FLOAT  
       SET @nValorMoneda   = ISNULL((SELECT vmvalor FROM BacParamSuda.dbo.VALOR_MONEDA with(nolock)
                                      WHERE vmfecha  = @fechaProc  
                                        AND vmcodigo = CASE WHEN @Moneda_activo = 13 THEN 994 ELSE @Moneda_activo END), 1.0)  
    
   IF @Moneda_activo <> 998  
   BEGIN  
      SET @nValorMoneda = ISNULL(( SELECT Tipo_Cambio FROM BacParamSuda.dbo.VALOR_MONEDA_CONTABLE with(nolock)
                                                     WHERE fecha         = @dFechaayer  
                                                       AND codigo_moneda = CASE WHEN @Moneda_activo = 13 THEN 994 ELSE @Moneda_activo END), 1.0)  
	END

SELECT  @Monto,@prc,@nValorMoneda
 
   SET @Monto = @Capital_Activo * @nValorMoneda * @prc  
   SET @prc   = @prc * 100.0

SELECT  @Monto,@prc

   INSERT INTO dbo.DEBUG_VALORES   
        SELECT @cSistema + ' ' + LTRIM(RTRIM( @nNumoper )) + '00@prc Metodologia 2009', @prc, '@Monto', @Monto     
  
END
GO
