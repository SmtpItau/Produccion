USE [BacParamSuda]
GO
/****** Object:  UserDefinedFunction [dbo].[fx_mesa_operador]    Script Date: 13-05-2022 10:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
		CREATE function [dbo].[fx_mesa_operador]
			(	
				@Usuario	varchar(20)	 
			)	RETURNS		varchar(50)
		as
		begin

			declare @cRetorno	varchar(50)
				set	@cRetorno	= 'MESA NO DEFINIDA'
				
				set	@cRetorno	=	ISNULL((	SELECT	m.Descripcion
												FROM	BacParamSuda.dbo.TBL_RELACION_USUARIO_MESA r
														inner join BacParamSuda.dbo.TBL_MESAS m on m.Id_Mesa = r.Id_Mesa
												WHERE	r.id_Usuario	= @Usuario
											),	'MESA NO DEFINIDA')

			return  @cRetorno

		end

GO
