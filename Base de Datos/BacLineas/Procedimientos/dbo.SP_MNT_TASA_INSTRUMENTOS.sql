USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_MNT_TASA_INSTRUMENTOS]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_MNT_TASA_INSTRUMENTOS]
		(
			@cFlag		CHAR(01)
		,	@cCodigo	NUMERIC(5)	= 0
		,	@cPlaDesde	NUMERIC(5)	= 0
		,	@cPlaHasta	NUMERIC(5)	= 0
		,	@cPorceMin	float		= 0
		,	@cPorceMax	float	= 0
		,	@cTasaSuper	NUMERIC(9,5)	= 0.0
		)
AS
BEGIN
  SET NOCOUNT ON

	IF @cFlag = 'G'
	  BEGIN
		  INSERT INTO LINEA_TASA_INSTRUMENTOS
		       SELECT @cCodigo
		       ,      @cPlaDesde
		       ,      @cPlaHasta
		       ,      @cPorceMin
		       ,      @cPorceMax
		       ,      @cTasaSuper

		   SELECT '0','Grabacion Correcta'
		   RETURN
	  END

	IF @cFlag = 'B'
	  BEGIN
	      SELECT 'Codigo'      = VI.incodigo 
	      ,      'Serie'       = inserie
	      ,      'PlazoDesde'  = Plazo_Desde
	      ,      'PlazoHasta'  = Plazo_Hasta
	      ,      'PorcentaMin' = Porcentaje_Minimo
	      ,      'PorcentaMax' = Porcentaje_Maximo
	      ,      'TasaSBIF'    = TasaSuper
	      ,      'Seriado'     = inmdse
		 FROM VIEW_INSTRUMENTO           VI
		 ,    LINEA_TASA_INSTRUMENTOS    LI
      	        WHERE VI.InCodigo = LI.InCodigo
		  AND LI.InCodigo = @cCodigo
                ORDER BY Plazo_Desde
		 RETURN
	  END

	IF @cFlag = 'E'
	  BEGIN
		DELETE FROM LINEA_TASA_INSTRUMENTOS
      	              WHERE InCodigo = @cCodigo

	  END

	IF @cFlag = 'C'
	  BEGIN
	      SELECT 'Codigo'      = inglosa
	      ,      'Serie'       = incodigo 
	      ,      'Familia'     = inserie
		 FROM VIEW_INSTRUMENTO
	  END

  SET NOCOUNT OFF
END





GO
