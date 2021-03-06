USE [BacParamSuda]
GO
/****** Object:  UserDefinedFunction [dbo].[fx_mesa_operador_ID]    Script Date: 13-05-2022 10:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

		CREATE function [dbo].[fx_mesa_operador_ID]
			(	
				@Usuario	varchar(20)	 
			)	RETURNS		numeric(1,0)
		as
		begin

			declare @cRetorno	numeric(1,0)
				set	@cRetorno	= 0
				
				set	@cRetorno	=	ISNULL((	SELECT	m.Id_Mesa
												FROM	BacParamSuda.dbo.TBL_RELACION_USUARIO_MESA r
														inner join BacParamSuda.dbo.TBL_MESAS m on m.Id_Mesa = r.Id_Mesa
												WHERE	r.id_Usuario	= @Usuario
											),	0)

			return  @cRetorno

		end

GO
