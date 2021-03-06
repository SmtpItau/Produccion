USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_CREDITOS_IBS]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_GRABA_CREDITOS_IBS](
	@Numero_Credito Numeric,
	@Rut_Cliente	Numeric,
	@Dv_Cliente		Char(1),
	@Codigo_Cliente int,
	@Nombre_Cliente Varchar(50),
	@Moneda			int,
	@Monto_Capital  float,
	@Fecha_Vencimiento Char(8),
	@Estado			int
)
as
Begin
	if Not exists(select 1 from CREDITOS_IBS Where Numero_Credito = @Numero_Credito) 
	begin
		-- print 'Grabando...'
		insert CREDITOS_IBS 
		values( @Numero_Credito,
		        @Rut_Cliente,
				@Dv_Cliente,
				@Codigo_Cliente,
				@Nombre_Cliente,
				@Moneda,
				@Monto_Capital,
				@Fecha_Vencimiento,
				@Estado
		      )
	end
End
GO
