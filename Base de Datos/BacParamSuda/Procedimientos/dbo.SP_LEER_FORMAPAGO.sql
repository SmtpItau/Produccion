USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_FORMAPAGO]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_LEER_FORMAPAGO]
   (   @Codigo   INTEGER = 0   )
AS
BEGIN

   SET NOCOUNT ON

	if not exists( select 1 from FORMA_DE_PAGO where (Codigo = @codigo or @codigo = 0) )
	begin
	
		SELECT /*01*/ Codigo     
		,      /*02*/ Glosa      
		,      /*03*/ Glosa2     
		,      /*04*/ Perfil     
		,      /*05*/ CodGen     
		,      /*06*/ cc2756     
		,      /*07*/ AfectaCorr 
		,      /*08*/ DiasValor  
		,      /*09*/ NumCheque  
		,      /*10*/ CtaCte
		,      /*11*/ DiasLineas
		,             CodigoBolsa = 0
		FROM   FORMA_DE_PAGO
		WHERE (@codigo = 0 OR @codigo = Codigo)
	   
	end else
	begin
	   SELECT /*01*/ Codigo     
	   ,      /*02*/ Glosa      
	   ,      /*03*/ Glosa2     
	   ,      /*04*/ Perfil     
	   ,      /*05*/ CodGen     
	   ,      /*06*/ cc2756     
	   ,      /*07*/ AfectaCorr 
	   ,      /*08*/ DiasValor  
	   ,      /*09*/ NumCheque  
	   ,      /*10*/ CtaCte
	   ,      /*11*/ DiasLineas
	   ,             CodigoBolsa
	   FROM   FORMA_DE_PAGO
	   WHERE (@codigo = 0 OR @codigo = Codigo)
	end
	
END
GO
