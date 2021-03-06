USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[sp_MDRCLeerCodigo]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[sp_MDRCLeerCodigo] 
       (
        @ncodpro    	CHAR(5),
        @Id_Sistema 	CHAR(3),
		@CodCartSbif	NUMERIC(10)
       )
as
BEGIN

SET NOCOUNT ON 
   /*=======================================================================*/
   /*=======================================================================*/
   /*
   Bitacora de modificaciones
   Autor		:	Victor Gonzalez S.
   Fono/Anexo		:	6860196  -  0196
   Solicitado por	:	Cristian Bravo G. / Bnejamin Levy 
   Fecha		:	24/03/2006
   Descripcion		:	Se incorpora el filtro la cartera SBIF para la normativa Circular 3345
*/

	SELECT  rcrut     
		,	rcnombre	 
	FROM	BacParamSuda.dbo.TIPO_CARTERA 
    WHERE	rcsistema		= @Id_Sistema 
	AND		rccodpro		= @ncodpro 
	AND		rcCarteraSbif	= @CodCartSbif
	ORDER 
	BY		rcrut
   
END
-- Base de Datos --
GO
