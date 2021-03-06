USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_CUENTA_CONTABLE_DOCUMENTOS]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO





CREATE PROCEDURE [dbo].[SP_CUENTA_CONTABLE_DOCUMENTOS]( @nrut_tomador	NUMERIC(9)	,
  					            @ncod_tomador	NUMERIC(9)	,
						    @nForma_de_pago	NUMERIC(3)	,
						    @Cuenta		NUMERIC(9) OUTPUT
						  )
AS
BEGIN
	DECLARE @tipo_cliente_tomador NUMERIC(2)

	SELECT @tipo_cliente_tomador = Cltipcli 
 	  FROM cliente
	 WHERE clrut    = @nrut_tomador 
	   AND clcodigo = @ncod_tomador

     		  --   1   BANCO NACIONAL                                               
		  --   2   BANCO EXTRANJERO                                             
		  --   3   INSTITUCIONES FINANCIERAS                                    
		  --   4   CORREDORES DE BOLSA                                          
		  --   5   INSTITUCIONES DE INVERSIONES                                 
		  --   6   ADMINISTRADORAS DE FONDOS DE P                               
		  --   7   EMPRESAS                                                     
		  --   8   PERSONAS NATURALES                                           
		  --   9   OTROS                                                        

		  --   4   VALE CAMARA
		  --   5   VALE LISTA

	SELECT 	@Cuenta = (CASE WHEN @tipo_cliente_tomador IN (1,2)		AND @nForma_de_pago = 5 THEN 230101680
				WHEN @tipo_cliente_tomador IN (3) 		AND @nForma_de_pago = 5 THEN 230101685
				WHEN @tipo_cliente_tomador IN (5,6,7,8,9,4)	AND @nForma_de_pago = 5 THEN 230101690
				WHEN @tipo_cliente_tomador IN (1,2) 		AND @nForma_de_pago = 4 THEN 230101695
				WHEN @tipo_cliente_tomador IN (3,4) 		AND @nForma_de_pago = 4 THEN 230101696
				ELSE 230101100
			   END)


END

-- SP_CUENTA_CONTABLE_DOCUMENTOS 97042000,1,4















GO
