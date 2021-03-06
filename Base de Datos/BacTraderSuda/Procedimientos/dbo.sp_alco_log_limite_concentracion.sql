USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[sp_alco_log_limite_concentracion]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
create proc [dbo].[sp_alco_log_limite_concentracion]
(		@codigo_limite        	numeric(9) ,	-- 1
		@descripcion_limite   	char(30)   , 	-- 2
		@numero_operacion     	numeric(9) ,	-- 3
		@tipo_operacion 		char(10)   ,	-- 4
		@serie        	     	char(12)   ,	-- 5
		@monto_operacion		float	   ,    -- 6
		@monto_linea   			float	   ,    -- 7
		@exceso         		float	   ,    -- 8
		@plazo            		numeric(9) ,    -- 9
		@trader            		char(30)   ,    -- 10
		@trader_autorizador		char(30)   ,    -- 11
		@rut_cliente 			numeric(9) ,	-- 12
		@codigo_cliente			numeric(9) 
)	-- 13
as 
begin
	
	/* LD1-COR-035 FUSION CORPBANCA - ITAU --> VALIDACION ALCO**/
	/***********************************************************************/

	declare @fecha_proc datetime
	select @fecha_proc = acfecproc from mdac

	insert into view_control_limites_generales 
	(
			codigo_tipo_limite   	,
			codigo_limite        	,
			descripcion_limite   	, 	
			numero_operacion     	,
			tipo_operacion 	     	,
			serie        	     	,
			monto_operacion		,
			monto_linea   		,
			exceso         		,
			fecha_exceso    	,
			plazo            	,
			trader            	,
			trader_autorizador 	,
			rut_cliente 		,
			codigo_cliente		)
	values	(	1			, ---> codigo tipo limite ''limites alco''
			@codigo_limite        	,
			@descripcion_limite   	, 	
			@numero_operacion     	,
			@tipo_operacion 	,
			@serie        	     	,
			@monto_operacion	,
			@monto_linea   		,
			@exceso         	,
			@fecha_proc	    	,
			@plazo            	,
			@trader            	,
			@trader_autorizador 	,
			@rut_cliente 		,
			@codigo_cliente		)
end


GO
