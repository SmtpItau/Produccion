USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TCLEECODIGOS1]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_TCLEECODIGOS1]
	(@tccodtab1 NUMERIC (04,0) ) --original CorpBanca NUMERIC(03,0), MODIFICADO PARA FUSIÓN-18-11-2015
AS

BEGIN
	SET NOCOUNT ON

	IF @tccodtab1=1

		SELECT tbcodigo1,
               tbglosa
          FROM VIEW_TABLA_GENERAL_DETALLE
         WHERE tbcateg = @tccodtab1
      ORDER BY tbglosa,tbcodigo1

    ELSE

        SELECT tbcodigo1, 
		       tbglosa
          FROM VIEW_TABLA_GENERAL_DETALLE
         WHERE tbcateg = @tccodtab1
     ORDER BY tbcodigo1


    RETURN

	SET NOCOUNT OFF

END

-- Base de Datos --

GO
