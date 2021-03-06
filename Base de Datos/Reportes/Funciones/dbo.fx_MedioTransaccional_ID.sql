USE [Reportes]
GO
/****** Object:  UserDefinedFunction [dbo].[fx_MedioTransaccional_ID]    Script Date: 16-05-2022 10:17:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

		CREATE function [dbo].[fx_MedioTransaccional_ID]
			(	
				@codCanalTransaccional	numeric
			)	RETURNS		varchar(3)
		as
		begin

			declare @cRetorno	varchar(3)
				set	@cRetorno	= '0'
				
				set	@cRetorno	= case when @codCanalTransaccional = 1 then ISNULL(	(select tipos_codreporte   
																					FROM [Reportes].[dbo].[TBL_TIPOSFUSION_H]   
																					WHERE id_desctipo = 21
																					  AND id_reporte = 2
																					  AND tipos_codreporte_h = 6),0  )
										when @codCanalTransaccional = 2 then ISNULL(	(select tipos_codreporte   
																					FROM [Reportes].[dbo].[TBL_TIPOSFUSION_H]   
																					WHERE id_desctipo = 21
																					  AND id_reporte = 2
																					  AND tipos_codreporte_h = 1),0  )
										else '0' end

			return  @cRetorno

		end

GO
