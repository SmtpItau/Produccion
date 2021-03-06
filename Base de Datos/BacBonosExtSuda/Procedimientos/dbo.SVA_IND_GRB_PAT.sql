USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVA_IND_GRB_PAT]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SVA_IND_GRB_PAT]
			(@cfecproc	char	(10)	,
                         @cfecprox	char	(10)   )
as
begin

   /* dbo.SVA_IND_GRB_PAT '20160420', '20160421' */
   -- Hay que pasarlo de todas maneras.

   set nocount on 
   -- select 'Comentado avance de fechas y updae matriz para probar '
   
	update	text_arc_ctl_dri
	set	acfecante	= acfecproc				,
		acfecproc	= convert(datetime,@cfecproc,101)	,
		acfecprox	= convert(datetime,@cfecprox,101)	,
		acsw_pd		= '1'					,
--		acsw_cm		= '0'					,
		acsw_fd		= '0'
    
	UPDATE 	BACLINEAS..matriz_atribucion_instrumento 
	SET	Acumulado_Diario = 0
--	SELECT * FROM BACLINEAS..matriz_atribucion_instrumento 
	WHERE 	Id_Sistema = 'BEX'
	

	if exists( select 1 from bacparamsuda.dbo.valor_moneda where vmcodigo = 700 and vmfecha = @cfecproc )
      delete bacparamsuda.dbo.valor_moneda where vmcodigo = 700 and vmfecha = @cfecproc
   
    declare @fecAux datetime = bacparamsuda.dbo.fx_regla_feriados_internacionales(@cfecproc, ';220' )
    declare @FechaProcesoFeriadoBrasilero varchar(1) = 'N'
    set @FechaProcesoFeriadoBrasilero = case when @fecAux <> @cfecproc then 'S' else 'N' end
 
    declare @DiaHabilanteriorBrasil datetime = bacparamsuda.dbo.fx_AGREGA_N_DIAS_HABILES( @cfecproc, -1, ';220;' )
	-- select 'debug' , '@DiaHabilanteriorBrasil' = @DiaHabilanteriorBrasil

    insert into BacParamSuda.dbo.VALOR_MONEDA (	vmcodigo,	vmvalor,	vmfecha		)
		   select 	vmcodigo
	  	       ,	vmvalor  = case when @FechaProcesoFeriadoBrasilero = 'S' then 0.0 else vmvalor end
		       ,	vmfecha  = @cfecproc
		from BacParamSuda.dbo.VALOR_MONEDA where vmcodigo = 700 
		and vmfecha = @DiaHabilanteriorBrasil
		

   set nocount off
   SELECT 'OK'
   
end
GO
