USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_inserta_Tarifado]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_inserta_Tarifado] (	
	@dFecha 	DATETIME,
	@Moneda		CHAR(4),
	@Grupo		INTEGER,
	@Plazo		INTEGER,
	@Monto		INTEGER,
	@Pizarra	NUMERIC(19,6),
	@Marginal	NUMERIC(19,6),
	@Costo_Fdo	NUMERIC(19,6)
)
AS 
BEGIN  
	INSERT INTO TARIFADO_TASA VALUES (	
		@dFecha,
		@Moneda,
		@Grupo,
		@Plazo,
		@Monto,
		@Pizarra,
		@Marginal,
		@Costo_Fdo
	)

END


GO
