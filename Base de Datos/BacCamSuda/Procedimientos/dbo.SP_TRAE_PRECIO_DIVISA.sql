USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAE_PRECIO_DIVISA]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- ======================================================================
-- Author		:	ASVG
-- Create date	:	20110926
-- Description	:	Procedimiento para obtener los datos asociados a los segmentos de IBS.
-- Test Case	:		 
--
--		SELECT * FROM COSTOS_COMEX_IBS
--		DECLARE @rv numeric(18,4)
--		EXEC @rv = SP_TRAE_PRECIO_DIVISA 'VENTA', 18, 13,'GEMP'
--		PRINT @rv 
--
--		DECLARE @rv numeric(18,4)
--		EXEC @rv = SP_TRAE_PRECIO_DIVISA 'COMPRA', 25, 13,'BEMP'
--		PRINT @rv 
-- ======================================================================
CREATE PROCEDURE [dbo].[SP_TRAE_PRECIO_DIVISA]
	(
		@tipo_operacion char(6), --'COMPRA' o 'VENTA'
		@monto_operacion numeric(18,4),
		@codigo_moneda numeric(5,0) = 13, --Default USD (=13) extensible a futuro.
		@nemo VARCHAR(6) = '' --Clasificación de Empresas
	)
AS
BEGIN

SET NOCOUNT ON;

	--para retornar
	DECLARE @precio AS numeric(18,4);
	SET @precio = 0;

	--ASVG_20110906 Tipos heredados de SP_COSTO_COMEX_IBS
	DECLARE @fecha AS CHAR(8)
	SET @fecha = CONVERT(CHAR(8), (SELECT acfecpro FROM dbo.MEAC), 112)

	DECLARE @CompVenta AS CHAR(1)
	SET @CompVenta = '' --ASVG Lógica de puntas Bid/Ask mala, operación viene del sitio Web.
	IF @tipo_operacion = 'COMPRA' SET @CompVenta = 'V'
	IF @tipo_operacion = 'VENTA' SET @CompVenta = 'C'

	DECLARE @Tabla	TABLE (
							Fecha datetime,
							NEMO_Segmento varchar(6),
							GLOSA_Segmento varchar(50),
							CODMONEDA numeric(5,0),
							MONTOMAX numeric(18,4),
							SpreadTrading numeric(18,4),
							SpreadComercial numeric(18,4),
							Desde numeric(18,4),
							Hasta numeric(18,4)
						  )

	--exec SP_COSTOS_COMEX_IBS 'V','20111007',1,'GGEE',13
	INSERT INTO @Tabla EXEC SP_COSTOS_COMEX_IBS @CompVenta,@fecha,@monto_operacion,@nemo,@codigo_moneda

	select @precio = count(*) from @Tabla

	IF @precio <= 0
		BEGIN
			SELECT 0;
			RETURN 0;
		END


	IF @CompVenta = 'V'
		BEGIN
			SET @precio = (SELECT MAX(Costo_Venta)
				FROM
					COSTOS_COMEX 
				WHERE
						Fecha = @fecha
					AND	CodMoneda = @codigo_moneda
				group by CodMoneda)

			SELECT @precio + SpreadComercial + SpreadTrading FROM @Tabla
			RETURN
		END
	ELSE
	IF @CompVenta = 'C'
		BEGIN
			SET @precio = (SELECT MIN(Costo_Compra)
				FROM
					COSTOS_COMEX
				WHERE
						Fecha = @fecha
					AND	CodMoneda = @codigo_moneda
				group by CodMoneda)

			SELECT @precio - SpreadComercial - SpreadTrading FROM @Tabla
			RETURN
		END
	ELSE

		RETURN 0;
END
GO
