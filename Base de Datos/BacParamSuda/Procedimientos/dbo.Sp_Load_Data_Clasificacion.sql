USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Load_Data_Clasificacion]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[Sp_Load_Data_Clasificacion]
	(	@nItems		int			-->		1. Carga Agencias;	2. Carga Clasificaciones
	,	@nAgencia	int	= 0
	)
as
begin

	set nocount on

	if @nItems = 1
	begin
		select	Id, Agencia
		from	BacParamSuda.dbo.Agencias_Clasificadoras with(nolock)
	end

	if @nItems = 2
	begin
		select	IdAgencia
			,	Id
			,	CortoPlazo
			,	LargoPlazo
			,	Transfronterizo
		from	BacParamSuda.dbo.Clasificaciones_Agencia with(nolock)
		where	IdAgencia	= @nAgencia
		order 
		by		IdAgencia,	Id
	end

end
GO
