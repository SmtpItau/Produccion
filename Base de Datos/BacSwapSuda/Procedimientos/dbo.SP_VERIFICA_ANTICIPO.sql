USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VERIFICA_ANTICIPO]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[SP_VERIFICA_ANTICIPO]
(
	@numero_operacion numeric(9),
	@FechaAnticipo datetime
)as
begin
	/* 
		verifica la existencia de un anticipo en cartera_unwind
		RSILVA.
	*/
	select distinct estado,FechaAnticipo,numero_operacion from dbo.CARTERA_UNWIND with (nolock)
	where FechaAnticipo = @FechaAnticipo
	and numero_operacion = @numero_operacion
end
GO
