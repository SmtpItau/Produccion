USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCAOPERACIONESDAP]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_BUSCAOPERACIONESDAP]
	(	@Moneda		INT			= 0
	,	@FechaVcto  CHAR(8)		= ''
	)
AS
BEGIN

	SET NOCOUNT ON

	SELECT	DISTINCT
			Numero		= CONVERT(CHAR(10),  numero_operacion)
		,	cliente		= CONVERT(CHAR(40), substring(cliente.Nombre,1,40))
		,	RutCliente	= CONVERT(CHAR(15), cliente.RutFull)
		,   Tasa		= CAST(tasa AS CHAR(10))
		,   montoFinal	= CAST(CONVERT(CHAR(25),CAST(CAST(monto_final AS NUMERIC(21,2)) AS CHAR(25))) as CHAR(25))
		
	FROM	GEN_CAPTACION with(nolock)
			left join
			(	select	clrut
					,	cldv
					,	clcodigo
					,	Nombre	= substring(clnombre, 1, 40)
					,	RutFull = ltrim(rtrim( clrut )) + '-' + ltrim(rtrim( cldv ))
				from	bacparamsuda.dbo.CLIENTE with(nolock)
			)	cliente	On	cliente.clrut		= rut_cliente 
						and cliente.clcodigo	= codigo_rut
	WHERE	fecha_operacion		< ( select acfecproc from bactradersuda.dbo.MDAC with(nolock) )
	AND		fecha_vencimiento	> ( select acfecproc from bactradersuda.dbo.MDAC with(nolock) )
	AND		monto_inicio		> 0
	AND		tipo_operacion		= 'CAP'
	AND		Estado				IN('', 'V')
	AND tipo_deposito			= 'F' --+++jcamposd solo disponibilizar tipo de depositos fijo
	AND tipo_emision			= 2 --+++solo disponibilizar tipo de emisión DCV


	AND	(	moneda				= @Moneda 
		or	@Moneda				= 0
		)

	AND	(	fecha_vencimiento	= @FechaVcto
		or	@FechaVcto			= ''
		)

END
GO
