USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTA_CORRESP_VCTO_ARB_FWD]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LISTA_CORRESP_VCTO_ARB_FWD]
AS  
BEGIN  
  
	SET NOCOUNT ON  

	SELECT	comoneda			= arb.comoneda
      ,		cotipo_op			= CASE WHEN arb.cotipo_op = 'V' THEN 'VENTA' ELSE 'COMPRA' END  
      ,		cod_corresponsal	= Corres.cod_corresponsal  
      ,		nombre				= Corres.nombre
	FROM	ARB_FWD_CORRESPONSAL arb with(nolock)
			INNER JOIN (select	codigo_moneda
							,	cod_corresponsal
							,	codigo_contable = case when ltrim(rtrim( codigo_contable )) = '' then 0 else codigo_contable end
							,	nombre
						from	BacParamSuda.dbo.Corresponsal with(nolock)
						where	rut_cliente		= ( select acrutprop from bactradersuda.dbo.mdac with(nolock) )
						and		codigo_cliente	= 1
						)		Corres	On	Corres.codigo_moneda	= arb.comoneda
										and	Corres.cod_corresponsal	= arb.cocorrela
										and Corres.codigo_contable	= arb.cocodigo_contable

END
GO
