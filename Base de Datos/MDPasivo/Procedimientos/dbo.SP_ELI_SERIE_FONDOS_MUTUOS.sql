USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_ELI_SERIE_FONDOS_MUTUOS]    Script Date: 16-05-2022 11:18:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_ELI_SERIE_FONDOS_MUTUOS] (
                                  @Serie   Char(12)
                                 )
AS
  BEGIN

  SET DATEFORMAT dmy

	IF  NOT EXISTS(SELECT MOINSTSER FROM view_movimiento_trader where MOCODIGO = 98 AND MOINSTSER=@serie)
	BEGIN

	       	DELETE  FROM FMUTUO_VALOR
		WHERE Serie= @Serie
	
	       	DELETE  FROM FMUTUO_SERIE 
		WHERE Serie= @Serie

	END ELSE
	BEGIN
		SELECT 2,'Serie Fondo Mutuo no se puede Eliminar, Esta Relacionada'
	END

  END







GO
