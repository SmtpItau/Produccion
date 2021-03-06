USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Validate_Data_Clasificacion]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create procedure [dbo].[Sp_Validate_Data_Clasificacion]
	(	@IdAgencia			int
	,	@Clasificacion		varchar(10)
	)
as
begin

	declare @bEstatus	int
		set @bEstatus	= 0

	if exists( select 1 from	BacBonosextSuda.dbo.Tbl_Clasificacion_Instrumento with(nolock)
						where	Agencia			= @IdAgencia
						and		Clasificacion	= @Clasificacion	)
	begin
		set @bEstatus = 1
	end

	select	Estado			= case	when @bEstatus = 0 then 'True' 
									else					'False'
								end
		,	Descripcion		= case	when @bEstatus = 0 then 'Ok.'
									else					'Existen instrumentos asociados a la clasificación ' + ltrim(rtrim( @Clasificacion ))
								end

end
GO
