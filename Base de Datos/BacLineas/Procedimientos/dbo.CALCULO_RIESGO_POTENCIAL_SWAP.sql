USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[CALCULO_RIESGO_POTENCIAL_SWAP]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[CALCULO_RIESGO_POTENCIAL_SWAP]
   (   @nNumoper            NUMERIC(9)  
   ,   @cSistema            CHAR(3)  
   ,   @cProducto           CHAR(5)  
   ,   @dFechaProceso       DATETIME  
   ,   @Moneda_Activo       INTEGER  
   ,   @Moneda_Pasivo       INTEGER  
   ,   @C_LCRParMdaGruMda   CHAR(8)  
   ,   @Monto               FLOAT      OUTPUT  
   ,   @Prc                 FLOAT      OUTPUT  
   )   
AS  
BEGIN  
  
   SET NOCOUNT ON  
  
   DECLARE @Codigo_riesgo       INTEGER  -- Ponderadores.Codigo_riesgo  
   DECLARE @Plazo1              FLOAT    -- Ponderadores.LCRPla  
   DECLARE @Plazo2              FLOAT    -- Ponderadores.LCRPla  
   DECLARE @Pon1                FLOAT    -- Ponderadores.LCRPon  
   DECLARE @Pon2                FLOAT    -- Ponderadores.LCRPon  
   DECLARE @InputPlazo          FLOAT    -- Plazo de rescate  
   DECLARE @TipoOperacion		VARCHAR(1)
   DECLARE @TipoBidAsk			VARCHAR(3)

   --> Determina prioridad de monedas, para definir si es Compra o Venta
 
   --> PRD 20426
   DECLARE @mAux				INT

   exec @mAux = SP_OBTENER_PRIORIDAD_MONEDA @Moneda_Activo, @Moneda_Pasivo, 2
   
  

	SET @TipoOperacion = CASE WHEN @mAux = @Moneda_Activo THEN
		'C'
	ELSE 
		'V'
	END
	                     
	SELECT  @Codigo_riesgo =  Riesgo_Interno
	FROM BacparamSuda..PRODUCTO 
	WHERE codigo_producto = @cProducto AND id_sistema = @cSistema
  
  
	SET @TipoBidAsk = CASE			
						WHEN @Codigo_riesgo = 2 THEN CASE				--BFW siempre trae C o V, pero si el riesgo no es 2 son NA
							WHEN @TipoOperacion = 'V' THEN 'BID'
							WHEN @TipoOperacion = 'C' THEN 'ASK'
							ELSE 'NA'
						END
						ELSE 'NA'
					  END

	if @cProducto ='OPT'
	begin
--			if (select top 1 CaCodEstructura from LnkOpc.CbMdbOpc.dbo.caenccontrato where canumcontrato=@nNumoper) in ( 5 , 8 )
			begin
				SET @TipoBidAsk = CASE			
							WHEN @Codigo_riesgo = 2 THEN CASE				
								WHEN @TipoOperacion = 'V' THEN 'ASK' --se invierte el sentido para BID y ASK
								WHEN @TipoOperacion = 'C' THEN 'BID'
								ELSE 'NA'
							END
							ELSE 'NA'
					      END
			end
	end


   DECLARE @dFechaayer     datetime   
       SET @dFechaayer          = CASE WHEN @cSistema = 'PCS' THEN ( SELECT fechaant  FROM BacSwapSuda..SWAPGENERAL with(nolock))  
                                       ELSE                        ( SELECT acfecante FROM BacFwdSuda..MFAC         with(nolock))   
                                  END  
  
   -->     Define el tipo de flujo a leer  
   DECLARE @nTipoFlujo          INTEGER  
       SET @nTipoFlujo          = 1 --> CASE WHEN @Moneda_Activo = 13 THEN 2 ELSE 1 END  
  

	-->  Para determinar si la operación fue generada en Chile o en NY **/--
	DECLARE @EsOperacionNY as varchar(2)
	set @EsOperacionNY = 'No'
	 IF exists (select 1 from BacSwapNY..cartera where numero_operacion = @nNumoper)
				set @EsOperacionNY = 'Si'
  

 DECLARE @nMinFlujo           INTEGER  
 DECLARE @nMaxFlujo           INTEGER 
 DECLARE @Capital_Activo      NUMERIC(21,4)  

  IF @EsOperacionNY = 'No' 
  begin
   -->     Lee el Menor Flujo para recorrer la operacion en orden  
		   --DECLARE @nMinFlujo           INTEGER  
       SET @nMinFlujo           = (SELECT MIN(numero_flujo) FROM BacSwapSuda.dbo.CARTERA with(nolock)  
                                    WHERE numero_operacion = @nNumoper and tipo_flujo = @nTipoFlujo)  
  
   -->     Lee el Mayor Flujo para recorrer la operacion en orden  
		   --DECLARE @nMaxFlujo           INTEGER  
       SET @nMaxFlujo           = (SELECT MAX(numero_flujo) FROM BacSwapSuda.dbo.CARTERA with(nolock)  
                                    WHERE numero_operacion = @nNumoper and tipo_flujo = @nTipoFlujo)  
  
   -->     Lee el Capital de la pata activa vigente. (Primer Flujo)  
		   ---DECLARE @Capital_Activo      NUMERIC(21,4)  
       SET @Capital_Activo      = (SELECT compra_capital FROM BacSwapSuda.dbo.CARTERA with(nolock)  
                                    WHERE numero_operacion = @nNumoper AND tipo_flujo = 1 AND numero_flujo = @nMinFlujo)  
  END

   IF @EsOperacionNY = 'Si' 
  begin
		   -->     Lee el Menor Flujo para recorrer la operacion en orden  
		   --DECLARE @nMinFlujo           INTEGER  
			   SET @nMinFlujo           = (SELECT MIN(numero_flujo) FROM BacSwapNY.dbo.CARTERA with(nolock)  
											WHERE numero_operacion = @nNumoper and tipo_flujo = @nTipoFlujo)  
  
		   -->     Lee el Mayor Flujo para recorrer la operacion en orden  
		   --DECLARE @nMaxFlujo           INTEGER  
			   SET @nMaxFlujo           = (SELECT MAX(numero_flujo) FROM BacSwapNY.dbo.CARTERA with(nolock)  
											WHERE numero_operacion = @nNumoper and tipo_flujo = @nTipoFlujo)  
  
		   -->     Lee el Capital de la pata activa vigente. (Primer Flujo)  
		   ---DECLARE @Capital_Activo      NUMERIC(21,4)  
			   SET @Capital_Activo      = (SELECT compra_capital FROM BacSwapNY.dbo.CARTERA with(nolock)  
											WHERE numero_operacion = @nNumoper AND tipo_flujo = 1 AND numero_flujo = @nMinFlujo)  
  END


  
   DECLARE @Factor              FLOAT  
       SET @Factor              = 0.0  
  
   DECLARE @nMO_C08             FLOAT  
       SET @nMO_C08             = 0.0  
  
   DECLARE @C_08                FLOAT  
       SET @C_08                = 0.0  
  
   WHILE @nMaxFlujo >= @nMinFlujo  
   BEGIN  
  
      -->    Setea las variables para evitar null  
      SET    @Plazo1   = null  
      SET    @Pon1     = null  
      SET    @Plazo2   = null  
      SET    @Pon2     = null  
  

	 IF @EsOperacionNY = 'No'  
	 BEGIN
      -->     Lee el plazo por el cual buscara ponderadores por flujo  
      SELECT  @InputPlazo            = DATEDIFF(DAY, @dFechaProceso, fechaliquidacion) / 365.0000000000
      ,       @nMO_C08               = CASE WHEN @nTipoFlujo = 1 THEN activo_mo_c08 + compra_flujo_adicional + CASE WHEN IntercPrinc = 1 THEN compra_amortiza ELSE 0 END  
                                            ELSE                      pasivo_mo_c08 + venta_flujo_adicional  + CASE WHEN IntercPrinc = 1 THEN venta_amortiza  ELSE 0 END  
                                       END  
      FROM    BacSwapSuda.dbo.CARTERA   
      WHERE   numero_operacion       = @nNumoper  
      AND     tipo_flujo             = @nTipoFlujo  
      AND     numero_flujo           = @nMinFlujo  
	 END

	IF @EsOperacionNY = 'Si'  
	 BEGIN
			  -->     Lee el plazo por el cual buscara ponderadores por flujo  
			  SELECT  @InputPlazo            = DATEDIFF(DAY, @dFechaProceso, fechaliquidacion) / 365.0000000000
			  ,       @nMO_C08               = CASE WHEN @nTipoFlujo = 1 THEN activo_mo_c08 + compra_flujo_adicional + CASE WHEN IntercPrinc = 1 THEN compra_amortiza ELSE 0 END  
													ELSE                      pasivo_mo_c08 + venta_flujo_adicional  + CASE WHEN IntercPrinc = 1 THEN venta_amortiza  ELSE 0 END  
											   END  
			  FROM    BacSwapNY.dbo.CARTERA   
			  WHERE   numero_operacion       = @nNumoper  
			  AND     tipo_flujo             = @nTipoFlujo  
			  AND     numero_flujo           = @nMinFlujo  
	 END


  
      -->     Obtiene el Plazo Menor de la matriz de ponderadores  
      SELECT  @Plazo1                = Pond.LCRPla  
      ,       @Pon1                  = Pond.LCRPon  
      FROM    BacLineas.dbo.LCRRIEPARMDAPON     Pond with(nolock)  
              INNER JOIN BacParamSuda..PRODUCTO Prod with(nolock) ON Prod.id_sistema      = @cSistema  
                                                                 AND Prod.codigo_producto = @cProducto  
																 AND Prod.riesgo_interno  = Pond.codigo_riesgo  
      WHERE   Pond.lcrgrumdacod      = @C_LCRParMdaGruMda  
      AND     Pond.lcrpla           <= @InputPlazo  
      AND	  Pond.lcrTipoBID_ASK    = @TipoBidAsk
      ORDER BY Prod.codigo_producto, Pond.codigo_riesgo, Pond.lcrgrumdacod, Pond.lcrpla  
  
      -->     Obtiene el Plazo Mayor de la matriz de ponderadores  
      SELECT  @Plazo2                 = Pond.LCRPla  
      ,       @Pon2                   = Pond.LCRPon  
      FROM    BacLineas.dbo.LCRRIEPARMDAPON     Pond with(nolock)  
              INNER JOIN BacParamSuda..PRODUCTO Prod with(nolock) ON Prod.Id_Sistema      = @cSistema  
                                                                 AND Prod.Codigo_Producto = @cProducto  
                                                                 AND Prod.Riesgo_Interno  = Pond.Codigo_Riesgo  
      WHERE   Pond.LCRGruMdaCod       = @C_LCRParMdaGruMda   
      AND     Pond.LCRPla             > @InputPlazo
      AND	  Pond.lcrTipoBID_ASK     = @TipoBidAsk  
      ORDER BY Prod.codigo_producto, Pond.codigo_riesgo, Pond.lcrgrumdacod, Pond.lcrpla DESC  
      
      --> Define Extremos  
      SET @prc = NULL  
  
      IF @Plazo2 IS NULL  
         SET @prc = @Pon1   
  
      IF @Plazo1 IS NULL  
         SET @prc = @Pon2   
  
      IF @prc IS NULL   
      BEGIN  
	     --SET @prc = @pon1 + (@pon2 - @pon1) * (@InputPlazo - @Plazo1) / (@Plazo2 - @Plazo1)   --ORIGINAL
         SET @prc = @pon1 + (@InputPlazo - @Plazo1) * (@Pon2 - @Pon1) / (@Plazo2 - @Plazo1)		--MODIFICADO PRD20426
         SET @prc = ISNULL(@prc, 0)  
      END  
  
      SET @Factor = @Factor + (@nMO_C08 * @prc)  
      SET @nMinFlujo = @nMinFlujo + 1  
   END  
  
   IF @Capital_Activo = 0  
   BEGIN  
      SET @Prc   = @Prc  
   END ELSE  
   BEGIN  
      SET @Prc   = (1 / @Capital_Activo) * @Factor  
   END  
  
   DECLARE @nValorMoneda   FLOAT  
       SET @nValorMoneda   = isnull((SELECT isnull(vmvalor, 1.0) FROM BacParamSuda.dbo.VALOR_MONEDA  
                                            WHERE vmfecha  = @dFechaProceso  
                                              and vmcodigo = CASE WHEN @Moneda_Activo = 13 THEN 994 ELSE @Moneda_Activo END ), 1.0)  
  
   IF @Moneda_Activo <> 998  
   BEGIN  
      SET @nValorMoneda   = isnull((SELECT isnull(Tipo_Cambio, 1.0)  FROM bacparamsuda.dbo.VALOR_MONEDA_CONTABLE  
                                    WHERE Fecha         = @dFechaayer  
                                      and Codigo_Moneda = CASE WHEN @Moneda_Activo = 13 THEN 994 ELSE @Moneda_Activo END ), 1.0)  
   END  
  
   SET @Monto = @Capital_Activo * @nValorMoneda * @Prc  
   SET @Prc   = @Prc * 100  
  
END  

GO
