USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[CONTRATO_ObtieneTipoContrato]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--CONTRATO_ObtieneTipoContrato 97947000, 1
--CONTRATO_ObtieneTipoContrato 96530900, 4

CREATE PROCEDURE [dbo].[CONTRATO_ObtieneTipoContrato]
(
		@Rut_Cliente numeric(11)
	,	@Cod_Cliente numeric(10)
)

as
begin set nocount on

		select	Cliente.cltipcli
			,	TipoCliente.tbglosa
			,	Cliente.clnombre
			,	TipoContrato = case when Cliente.cltipcli in(1,2) then 'BANCO' else 'NO BANCO' end
		from	BacParamSuda.dbo.cliente Cliente	with(nolock)
				left join (	select	tbcodigo1
								,	tbglosa 
							from	BacParamSuda.dbo.tabla_general_detalle with(nolock)
							where	tbcateg = 72
							)	TipoCliente On TipoCliente.tbcodigo1 = Cliente.cltipcli
		where	Cliente.clrut = @Rut_Cliente and Cliente.clcodigo = @Cod_Cliente
		order 
		by		Cliente.cltipcli
			,	Cliente.clnombre

end
GO
