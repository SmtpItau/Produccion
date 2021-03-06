USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_LCR_VRAZONABLE_NEGATIVO]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_LCR_VRAZONABLE_NEGATIVO]
   (   @dFecha         DATETIME
   ,   @Sistema        CHAR(3)
   ,   @NumOperacion   NUMERIC(9)
   ,   @MontoSubTotal  FLOAT
   ,   @MontoUtilidad  FLOAT
   ,   @MontoFinal     FLOAT   OUTPUT
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @iPorcentaje        FLOAT
       SET @iPorcentaje        = 3.0

   DECLARE @vRazonableNegativo FLOAT
   DECLARE @nNocionalActivo    NUMERIC(21,4)
   DECLARE @iPlazoResidual     FLOAT
   DECLARE @iPlazoContrato     FLOAT
   DECLARE @nFactor            FLOAT
   DECLARE @nVector_A          FLOAT
   DECLARE @nVector_B          FLOAT
   DECLARE @iNegativo          INTEGER

   DECLARE @Fecha_Cierre       DATETIME
       SET @Fecha_Cierre       = @Dfecha

	--===========================================================================--
	--> Para determinar si la operación fue generada en Chile o en NY --
	DECLARE @EsOperacionNY as varchar(2)
	set @EsOperacionNY = 'No'
	IF exists (select 1 from BacSwapNY..cartera where numero_operacion = @NumOperacion)
				set @EsOperacionNY = 'Si'

		IF exists (select 1 from BacFWDNY..cartera where canumoper = @NumOperacion)
				set @EsOperacionNY = 'Si'
	--===========================================================================--



   IF @Sistema = 'PCS'
   BEGIN
			IF @EsOperacionNY = 'No'
				begin	

					 SET @vRazonableNegativo = 0
				  SELECT @vRazonableNegativo = ISNULL(CASE WHEN MAX(Valor_RazonableCLP) < 0.0 THEN MAX(Valor_RazonableCLP) 
														   ELSE                                    0.0 
													  END, 0.0)
				  FROM   BacSwapSuda..CARTERA
				  WHERE  numero_operacion    = @NumOperacion
				  AND   (estado_flujo        = 1 AND fecha_termino > @dFecha
					  or estado_flujo        = 2 AND fecha_termino = @dFecha)

				  SELECT @nNocionalActivo    = ISNULL((compra_amortiza + compra_saldo + Compra_Flujo_Adicional), 0) * ISNULL(vmvalor,1.0)
				  ,      @iPlazoResidual     = DATEDIFF(DAY, @dFecha, fecha_termino)
				  ,      @iPlazoContrato     = DATEDIFF(DAY, fecha_inicio, fecha_termino)
				  ,      @Fecha_Cierre       = fecha_cierre
				  FROM   BacSwapSuda..CARTERA
						 LEFT JOIN BacParamSuda..VALOR_MONEDA ON vmfecha = @dFecha AND vmcodigo = CASE WHEN compra_moneda = 13 THEN 994 ELSE compra_moneda END
				  WHERE  numero_operacion    = @NumOperacion
				  AND    tipo_flujo          = 1
				  AND   (estado_flujo        = 1 AND fecha_termino > @dFecha
					  or estado_flujo        = 2 AND fecha_termino = @dFecha)
			END
			IF @EsOperacionNY = 'Si'
				begin	

					 SET @vRazonableNegativo = 0
				  SELECT @vRazonableNegativo = ISNULL(CASE WHEN MAX(Valor_RazonableCLP) < 0.0 THEN MAX(Valor_RazonableCLP) 
														   ELSE                                    0.0 
													  END, 0.0)
				  FROM   BacSwapNY..CARTERA
				  WHERE  numero_operacion    = @NumOperacion
				  AND   (estado_flujo        = 1 AND fecha_termino > @dFecha
					  or estado_flujo        = 2 AND fecha_termino = @dFecha)

				  SELECT @nNocionalActivo    = ISNULL((compra_amortiza + compra_saldo + Compra_Flujo_Adicional), 0) * ISNULL(vmvalor,1.0)
				  ,      @iPlazoResidual     = DATEDIFF(DAY, @dFecha, fecha_termino)
				  ,      @iPlazoContrato     = DATEDIFF(DAY, fecha_inicio, fecha_termino)
				  ,      @Fecha_Cierre       = fecha_cierre
				  FROM   BacSwapNY..CARTERA
						 LEFT JOIN BacParamSuda..VALOR_MONEDA ON vmfecha = @dFecha AND vmcodigo = CASE WHEN compra_moneda = 13 THEN 994 ELSE compra_moneda END
				  WHERE  numero_operacion    = @NumOperacion
				  AND    tipo_flujo          = 1
				  AND   (estado_flujo        = 1 AND fecha_termino > @dFecha
					  or estado_flujo        = 2 AND fecha_termino = @dFecha)
			END

   END

   IF @Sistema = 'BFW'
   BEGIN
		IF @EsOperacionNY = 'No'
				begin	

			  SET     @vRazonableNegativo = 0
			  SELECT  @vRazonableNegativo = ISNULL(CASE WHEN fRes_Obtenido < 0 THEN fRes_Obtenido ELSE 0.0 END,0.0)
			  ,       @nNocionalActivo    = ISNULL(camtomon1,0.0) * ISNULL(vmvalor,1.0)
			  ,       @iPlazoResidual     = DATEDIFF(DAY,@dFecha,cafecvcto)
			  ,       @iPlazoContrato     = DATEDIFF(DAY,cafecha,cafecvcto)
			  ,       @Fecha_Cierre       = cafecha
			  FROM    BacFwdSuda..MFCA
					  LEFT JOIN BacParamSuda..VALOR_MONEDA ON vmfecha = @dFecha AND vmcodigo = CASE WHEN cacodmon1 = 13 THEN 994 ELSE cacodmon1 END
			  WHERE   canumoper           = @NumOperacion
			  AND     cafecha             < @dFecha
		END

		IF @EsOperacionNY = 'Si'
			begin	

			  SET     @vRazonableNegativo = 0
			  SELECT  @vRazonableNegativo = ISNULL(CASE WHEN fRes_Obtenido < 0 THEN fRes_Obtenido ELSE 0.0 END,0.0)
			  ,       @nNocionalActivo    = ISNULL(camtomon1,0.0) * ISNULL(vmvalor,1.0)
			  ,       @iPlazoResidual     = DATEDIFF(DAY,@dFecha,cafecvcto)
			  ,       @iPlazoContrato     = DATEDIFF(DAY,cafecha,cafecvcto)
			  ,       @Fecha_Cierre       = cafecha
			  FROM    BacFWDNY..MFCA
					  LEFT JOIN BacParamSuda..VALOR_MONEDA ON vmfecha = @dFecha AND vmcodigo = CASE WHEN cacodmon1 = 13 THEN 994 ELSE cacodmon1 END
			  WHERE   canumoper           = @NumOperacion
			  AND     cafecha             < @dFecha
		END

   END

   IF @vRazonableNegativo >= 0 or @Fecha_Cierre = @dFecha 
   BEGIN
      IF @Fecha_Cierre   = @dFecha   
         SET @MontoUtilidad      = 0

      SET @MontoFinal    = @MontoSubTotal + @MontoUtilidad

   END ELSE
   BEGIN
      IF @Fecha_Cierre   = @dFecha   
         SET @vRazonableNegativo = 0

      SET @MontoFinal    = @MontoSubTotal + @vRazonableNegativo
      IF @MontoFinal < 0 
         SET @MontoFinal = 0
   END

END

GO
