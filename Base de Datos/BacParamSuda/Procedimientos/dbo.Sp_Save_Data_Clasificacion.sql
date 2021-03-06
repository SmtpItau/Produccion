USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Save_Data_Clasificacion]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[Sp_Save_Data_Clasificacion]
	(	@nAccion			int				-->	1 = Borra Tabla;	2 = Graba Linea a Linea
	,	@IdAgencia			int				= 0
	,	@Id					int				= 0
	,	@CortoPlazo			varchar(10)		= ''
	,	@LargoPlazo			varchar(10)		= ''
	,	@Transfronterizo	char(2)			= ''
	)
as
begin

	set nocount on

	if @nAccion	= 1
	begin
		delete	from	dbo.Clasificaciones_Agencia 
				where	IdAgencia	= @IdAgencia
	end

	if @nAccion	= 2
	begin
		insert	into dbo.Clasificaciones_Agencia
		select	IdAgencia			= @IdAgencia
			,	Id					= @Id
			,	CortoPlazo			= @CortoPlazo
			,	LargoPlazo			= @LargoPlazo
			,	Transfronterizo		= @Transfronterizo
	end

end
GO
