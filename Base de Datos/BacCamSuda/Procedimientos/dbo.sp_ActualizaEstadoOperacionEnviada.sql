USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[sp_ActualizaEstadoOperacionEnviada]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_ActualizaEstadoOperacionEnviada]
		  ( @dcSistema			char(3)
		  , @dnOperacion		numeric(7)
		  , @swEnviada			char 
		  )
as
begin

	update tbXMLOperacion
	   set swEnviada = @swEnviada
	 where dcSistema	= @dcSistema
	   and dnOperacion  = @dnOperacion

end

GO
