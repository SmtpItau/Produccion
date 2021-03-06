USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[sp_ver_si_sirve]    Script Date: 16-05-2022 12:48:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[sp_ver_si_sirve] (@cfecpro DATETIME,
				@ntircompo NUMERIC(09,4),
				@nfeccompo DATETIME,
				@Rentabilidad VARCHAR(1),
				@tipo_cartera_financiera CHAR(1),
				@nforpagi NUMERIC (05,0),
				@cinstser CHAR(12),
				@cSerie CHAR(12),
				@cRenta CHAR(1) OUTPUT,
				@nTipoTir CHAR(30) OUTPUT,
				@Sirve CHAR(2) OUTPUT )
AS
BEGIN
   If @nfeccompo = @cFecpro Begin
	SELECT @nTipoTir = 0.0
	If @Rentabilidad = 'H'
  	   SELECT @cRenta = 'H'
	ELSE IF @tipo_cartera_financiera = 'T'
  	   SELECT @cRenta = 'T'
	SELECT @Sirve='SI'
   End
-- If @nforpagi <> 5 AND @nforpagi <> 1 AND @nforpagi <> 8 AND @nforpagi <> 29 AND @nforpagi <> 30   Por los papeles en dolares se saco
   If @nforpagi = 0 or @nforpagi = 4 or @nforpagi = 100 or @nforpagi = 10
      SELECT @Sirve='NO'
   ELSE BEGIN
      If @Rentabilidad = 'H' BEGIN
	SELECT @cRenta = 'H'
	SELECT @nTipoTir = @ntircompo
	SELECT @Sirve='SI'
      END ELSE BEGIN
	  IF (@cSerie = 'PRC' OR @cSerie= 'LCHR') And @tipo_cartera_financiera = 'T' BEGIN
            SELECT @nTipoTir = 0.0  -- ????????????
	    SELECT @cRenta = 'T'
	    SELECT @Sirve='SI'
	  END ELSE BEGIN
             IF @tipo_cartera_financiera = 'T' BEGIN
            	SELECT @nTipoTir = 0.0  -- ????????????
	   	SELECT @cRenta = 'T'
	   	SELECT @Sirve='SI'
	     END
	 END
      END	
   END
END

-- Base de Datos --
GO
