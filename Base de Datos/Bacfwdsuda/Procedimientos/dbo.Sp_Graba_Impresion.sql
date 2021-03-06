USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Graba_Impresion]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--BacFwdSuda.DBO.Sp_Graba_Impresion 'OPC', 2725, 'rfuentes', '20141016'


CREATE procedure [dbo].[Sp_Graba_Impresion]

	(	@Modulo			char(5)

	,	@Folio			numeric(9)

	,	@Usuario		varchar(15)

	,	@dFechaContrato	datetime

	)

as

begin



	set nocount on



	declare @dFechaProceso	datetime

		set @dFechaProceso	= ( select	Control.Fecha

								from	(			select Fecha = acfecproc from BacFwdSuda.dbo.Mfac			with(nolock) where 'BFW' = @Modulo

											union	select Fecha = fechaproc from BacSwapSuda.dbo.SwapGeneral	with(nolock) where 'PCS' = @Modulo OR 'OPC' = @Modulo

										)	Control

								)



	if not exists( select 1 from dbo.Tbl_Impresion_Fax	where	Modulo			= upper(@Modulo)

														and		Folio			= @Folio

														and		Usuario			= upper(@Usuario)

														and		FechaProceso	= @dFechaProceso 

														and		Fecha			= convert(char(10), GetDate(), 112)

														and		Hora			= convert(char(10), GetDate(), 108)

				)

	begin

		insert into dbo.Tbl_Impresion_Fax

		select	Modulo			= upper(@Modulo)

		,		Folio			= @Folio

		,		Usuario			= upper(@Usuario)

		,		FechaProceso	= @dFechaProceso

		,		Fecha			= convert(char(10), GetDate(), 112)

		,		Hora			= convert(char(10), GetDate(), 108)

		,		FechaContrato	= @dFechaContrato

		,		Modifica		= 0

		,		FechaModifica	= @dFechaProceso

	end



end

GO
