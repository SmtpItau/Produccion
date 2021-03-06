USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MID_InicioProceso_NY]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create Procedure [dbo].[SP_MID_InicioProceso_NY]
	(	@IdEstado	Int		)
as
begin

	if @IdEstado = 1
		update	BacParamSuda.dbo.MID_Control_InicioNY
		set		HoraInicio	=	convert(char(10), GetDate(),108)
		,		Estado		=	@IdEstado

	if @IdEstado > 1
		update	BacParamSuda.dbo.MID_Control_InicioNY
		set		HoraTermino	=	convert(char(10), GetDate(),108)
		,		Estado		=	@IdEstado
		,		Fecha		=	acfecproc
		,		FechaProx	=	acfecprox
		from	BacFwdNy.dbo.mfac with(nolock)

end

GO
