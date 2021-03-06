USE [BacTraderSuda]
GO
/****** Object:  UserDefinedFunction [dbo].[Fx_ReplicaId]    Script Date: 13-05-2022 11:19:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create function [dbo].[Fx_ReplicaId]
	(	@nId			numeric(9)
	,	@nPuntero		numeric(9)
	)	returns			numeric(9)
as
begin

	declare @xId		numeric(9)
		set @xId		= @nId + ( @nPuntero - 1)

	return @xId

end
GO
