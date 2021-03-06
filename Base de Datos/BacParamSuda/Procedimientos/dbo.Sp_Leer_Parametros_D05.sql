USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Leer_Parametros_D05]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_Leer_Parametros_D05]
	(	@iConsultar			int	= 0
	,	@iFiltraAgencia		int	= 0
	)	
	-->	1. : Clasificadoras; 2. : Clasificaciones
AS
BEGIN

	set nocount on
	
	if @iConsultar = 1
	begin
		select	Id
			,	Agencia
		from	BacParamSuda.dbo.Agencias_Clasificadoras
		order 
		by		Id desc
	end

	if @iConsultar = 2
	begin
		select	Id			= Clasificacion.Id
			,	Mostrar_BEX	= Clasificacion.LargoPlazo
			,	Nombre		= Agencias.Agencia
			,	CortoPlazo	= Clasificacion.CortoPlazo
			,	LargoPlazo	= Clasificacion.LargoPlazo
		from	dbo.Clasificaciones_Agencia Clasificacion
				inner join (	select	Id, Agencia
								from	BacParamSuda.dbo.Agencias_Clasificadoras
								where	(	@iFiltraAgencia	=	Id
										or	@iFiltraAgencia	=	0
										)
							)	Agencias	On Agencias.Id	= Clasificacion.IdAgencia
		order
		by		Agencias.Id

	end

END
GO
