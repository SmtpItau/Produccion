USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACTDOLARFINMES]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[SP_ACTDOLARFINMES]
			( @cfecha	char	(10)	)
as
begin
   set nocount on 

	update	text_arc_ctl_dri
	set	dolarObsFinMes	= isnull(vmvalor , 0 )
	from    view_valor_moneda
	where   vmfecha		= @cfecha
	 and 	vmcodigo	= 994

	select dolarObsFinMes from text_arc_ctl_dri

   set nocount off

   
end

GO
