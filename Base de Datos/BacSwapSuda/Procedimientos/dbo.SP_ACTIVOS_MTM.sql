USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACTIVOS_MTM]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--SP_ACTIVOS_MTM '20110328', 579

--SP_ACTIVOS_MTM '17-09-2013', 579

CREATE PROCEDURE [dbo].[SP_ACTIVOS_MTM]	
(
		@dFecha		VARCHAR(10) --DATETIME
	,	@NumOper	INT
)
AS
BEGIN

SET NOCOUNT ON


	  --Variables formato fecha		  	    	    
	    DECLARE @dia			VARCHAR(02)   
		DECLARE @mes			VARCHAR(02)
        DECLARE @año			VARCHAR(04)
		DECLARE @fecha_Contrato VARCHAR(08)

		 /*Format fecha contrato*************************************************************/

--declare @dFecha as varchar(10)
--set @dFecha = '17-09-2013'

   SELECT @dia  = SUBSTRING(@dFecha,1,2)
   select @mes  = SUBSTRING(@dFecha,4,2)
   SELECT @año	= SUBSTRING(@dFecha,7,4) 

    SELECT @fecha_Contrato = @año + @mes + @dia

	set @dFecha = @fecha_Contrato
	
	select	--tipo_flujo
 	 	--,	numero_operacion
 	    	'Fecha_Fijacion'				=	Fecha_Inicio_Flujo
 	    ,	'Fecha_Inicio'					=	Fecha_Inicio_Flujo
 	    ,	'Fecha_Vencimiento'				=	Fecha_Vence_Flujo
      	,	'Fecha_Pago'					=	Fecha_Vence_Flujo	
      	,	'Saldo_Residual_activo'			=	compra_amortiza + compra_saldo
      	,	'Intercambio_Nocional'			=	'SI'
      	,	'Postpounding'					=	'NO'
      	,	'TasaActivo'					=	compra_Valor_tasa
		,	'Spread'						=	0
 		,	'Flujo_ACTIVO_valor_presente'	=	Activo_FlujoCLP
	from	BacSwapSuda.dbo.Carterares  
			inner join BacParamSuda.dbo.Cliente ON clrut = rut_cliente and clcodigo = codigo_cliente
	where	Fecha_Proceso    =    @dFecha
	and		numero_operacion IN (@NumOper)
	AND		tipo_flujo = 1
	
END

GO
