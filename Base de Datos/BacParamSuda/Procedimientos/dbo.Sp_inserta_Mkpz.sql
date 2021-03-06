USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_inserta_Mkpz]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_inserta_Mkpz] (	
	@dFecha 	DATETIME,
	@nTipo		INTEGER,
	@Moneda		CHAR(4),
	@Vertice	INTEGER,
	@Plazo		INTEGER,
	@Inferir	INTEGER,
	@Superior	INTEGER,
	@Pizarra	NUMERIC(19,4),
	@Marginal	NUMERIC(19,4),
	@Costo_Fdo	NUMERIC(19,4)
)
AS
BEGIN  
	INSERT INTO MKPZ_TASA 
	VALUES (	
		@dFecha,
		@nTipo,
		@Moneda,
		@Vertice,
		@Plazo,
		@Inferir,
		@Superior,
		@Pizarra,
		@Marginal,
		@Costo_Fdo
	)

END


GO
