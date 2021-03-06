USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONSULTASFILTRO_SGRU]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--SP_CONSULTASFILTRO_SGRU 1, 0, 0, 0, 0, 0, 0.0, 0, 20150128, 20150128, 1553, 1111, 1554, 1552 --> DEL DIA
--SP_CONSULTASFILTRO_SGRU 2, 0, 0, 0, 0, 0, 0.0, 0, 20150128, 20150128, 1553, 1111, 1554, 1552 --> HISTORICAS
--SP_CONSULTASFILTRO_SGRU 3, 0, 0, 0, 0, 0, 0.0, 0, 20150128, 20150128, 1553, 1111, 1554, 1552 --> VIGENTES
--SP_CONSULTASFILTRO_SGRU 4, 0, 0, 0, 0, 0, 0.0, 0, 20150128, 20150128, 1553, 1111, 1554, 1552 --> VIGENTES

--SP_CONSULTASFILTRO_SGRU 3, 0, 0, 0, 0, 0, 0.0, 0, 20150128, 20150128, 1553, 1111, 1554, 1552

--SP_CONSULTASFILTRO 3, 0, 0, 0, 0, 0, 0, 1, '20150128', '20150128', '1553', '1111', '1554', '1552'

--SP_CONSULTASFILTRO 3, 0, 0, 0, 0, 0, 0, 3, '20140606', '20150128', '1553', '1111', '1554', '1552'
--SP_CONSULTASFILTRO_SGRU 3, 0, 0, 0, 0, 0, 0, 3, '20140606', '20150128', '1553', '1111', '1554', '1552'

--SP_CONSULTASFILTRO 3, 0, 0, 0, 0, 0, 0.0, 0, 20150128, 20150128, 1553, 1111, 1554, 1552 --> VIGENTES


CREATE PROCEDURE [dbo].[SP_CONSULTASFILTRO_SGRU]
	(   @operacion						NUMERIC(03),
        @tipoper						NUMERIC(03),
        @condicion						NUMERIC(03),
        @orden							NUMERIC(03),
		@codcliente						NUMERIC(09),
		@rutcliente						NUMERIC(09),
		@codmoneda						NUMERIC(09),
		@opcionfecha					NUMERIC(01),
		@fecha1							VARCHAR(08),
		@fecha2							VARCHAR(08),
		@Const_Area_Responsable			CHAR(10)	= '',
		@Const_Cartera_Normativa		CHAR(10)	= '',
		@Const_SubCartera_Normativa		CHAR(10)	= '',
		@Const_Libro					CHAR(10)	= ''
   )
AS
BEGIN

   SET NOCOUNT ON 



CREATE TABLE #TEMP (
			Swap					VARCHAR(30),
			Numero_Operacion		INT,
			Codigo_Cliente			VARCHAR(5),
			Nombrecli				VARCHAR(60),
			Tipo_operacion			VARCHAR(2),
			NombreOp				VARCHAR(30),
			FechaInicio				VARCHAR(10),
			Fechatermino			VARCHAR(10),
			MonedaOperacion			VARCHAR(5),
			NombreMoneda			VARCHAR(30),
			MontoOperacion			NUMERIC(20,4),
			TasaBase				NUMERIC(10,4),
			MontoConversion			NUMERIC(20,4),
			TasaConversion			NUMERIC(10,4),
			Modalidad				VARCHAR(30),
			rutcli					VARCHAR(30),
			Area_Responsable		VARCHAR(30),
			Cartera_Normativa		VARCHAR(30),
			SubCartera_Normativa	VARCHAR(30),
			Libro					VARCHAR(30)
)
--INSERT INTO #TEMP EXECUTE SP_CONSULTASFILTRO 3, 0, 0, 0, 0, 0, 0.0, 0, 20150128, 20150128, 1553, 1111, 1554, 1552

--INSERT INTO #TEMP EXECUTE SP_CONSULTASFILTRO 3, 0, 0, 0, 0, 0, 0, 3, '20140606', '20150128', '1553', '1111', '1554', '1552'

INSERT INTO #TEMP EXECUTE BACSWAPSUDA..SP_CONSULTASFILTRO @operacion	,				
											 @tipoper	,				
											 @condicion	,				
											 @orden		,				
											 @codcliente,					
											 @rutcliente,					
											 @codmoneda	,				
											 @opcionfecha,				
											 @fecha1		,				
											 @fecha2		,				
											 @Const_Area_Responsable,		
											 @Const_Cartera_Normativa,	
											 @Const_SubCartera_Normativa,	
											 @Const_Libro			



--SELECT SWAP, Numero_Operacion, Codigo_Cliente, Nombrecli,Tipo_operacion, NombreOp, FechaInicio, Fechatermino
--, MonedaOperacion, NombreMoneda, MontoOperacion, MontoConversion, TasaConversion, Modalidad, rutcli, Area_Responsable
--, Cartera_Normativa, SubCartera_Normativa, Libro

--FROM #TEMP GROUP BY  SWAP, Numero_Operacion, Codigo_Cliente, Nombrecli,Tipo_operacion, NombreOp, FechaInicio, Fechatermino
--, MonedaOperacion, NombreMoneda, MontoOperacion, MontoConversion, TasaConversion, Modalidad, rutcli, Area_Responsable
--, Cartera_Normativa, SubCartera_Normativa, Libro ORDER BY Numero_Operacion

select SWAP, Numero_Operacion, Codigo_Cliente, Nombrecli,Tipo_operacion, NombreOp, FechaInicio, Fechatermino
, MonedaOperacion, NombreMoneda, MontoOperacion, tasabase, MontoConversion, TasaConversion, Modalidad, rutcli, Area_Responsable
, Cartera_Normativa, SubCartera_Normativa, Libro FROM(
SELECT ROW_NUMBER() OVER (PARTITION BY Numero_Operacion ORDER BY Numero_Operacion) AS RN,  SWAP, Numero_Operacion, Codigo_Cliente, Nombrecli,Tipo_operacion, NombreOp, FechaInicio, Fechatermino
, MonedaOperacion, NombreMoneda, MontoOperacion, tasabase, MontoConversion, TasaConversion, Modalidad, rutcli, Area_Responsable
, Cartera_Normativa, SubCartera_Normativa, Libro FROM #temp) t1 where RN=1 



--SELECT DISTINCT(NUMERO_OPERACION) FROM #TEMP

END
GO
