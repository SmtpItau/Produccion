USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_ELI_MOD_SRE_PSS]    Script Date: 16-05-2022 12:48:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SVC_ELI_MOD_SRE_PSS]
				(@noperacion	NUMERIC	(10,0)		,
				 @rutcart	NUMERIC	(09,0)		,
                                 @serie         CHAR(20) = ''	         )
AS
-- Autor		: 
-- Objetivo		: Eliminacion de serie en tabla modificacion
-- Fecha de Creacion	: 16-03-2004
-- Modificaciones	: 
-- Primera Modificacion	: 16-03-2004
-- Segunda Modificacion	: 16-03-2004
-- Antecedentes Generales : 
BEGIN

SET NOCOUNT ON

   DELETE FROM FLJ_LQZ_MOD WHERE (Instrumento = @serie or @serie = '') 

SET NOCOUNT OFF

END

GO
