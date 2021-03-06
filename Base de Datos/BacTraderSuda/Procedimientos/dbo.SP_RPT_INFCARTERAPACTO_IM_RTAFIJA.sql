USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RPT_INFCARTERAPACTO_IM_RTAFIJA]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[SP_RPT_INFCARTERAPACTO_IM_RTAFIJA]  
	@Cartera	smallint,
	@Mesa		smallint,
	@tipoOp	char(3)
AS

   SET NOCOUNT ON

   DECLARE @Glosa_Cartera	CHAR(50)
  ,	   @Glosa_Mesa		CHAR(50)

   SELECT  @Glosa_Cartera	= '' 
  ,	   @Glosa_Mesa		= ''


DECLARE  @acfecproc  CHAR (10)     ,  
         @acfecprox  CHAR (10)     ,  
         @uf_hoy     FLOAT         ,  
         @uf_man     FLOAT         ,  
         @ivp_hoy    FLOAT         ,  
         @ivp_man    FLOAT         ,  
         @do_hoy     FLOAT         ,  
         @do_man     FLOAT         ,  
         @da_hoy     FLOAT         ,  
         @da_man     FLOAT         ,  
         @acnomprop  CHAR (40)     ,  
         @rut_empresa CHAR (12)    ,  
         @hora       CHAR (08)
         
 EXECUTE Sp_Base_Del_Informe
           @acfecproc OUTPUT       ,
           @acfecprox OUTPUT       ,
           @uf_hoy  OUTPUT         ,
           @uf_man  OUTPUT         ,
           @ivp_hoy OUTPUT         ,
           @ivp_man OUTPUT         ,
           @do_hoy  OUTPUT         ,
           @do_man  OUTPUT         ,
           @da_hoy  OUTPUT         ,
           @da_man  OUTPUT         ,
           @acnomprop OUTPUT       ,      
           @rut_empresa OUTPUT     ,
           @hora  OUTPUT


   IF @Cartera = '-1' 
      SELECT @Glosa_Cartera = '< TODAS >'
   ELSE
      SELECT @Glosa_Cartera = ISNULL(TBGLOSA,'')
      FROM   VIEW_TABLA_GENERAL_DETALLE
      WHERE  tbcateg	    = '204'
      AND    tbcodigo1	    = CONVERT(CHAR(6),@Cartera)

   IF @Mesa = '-1'
       SELECT @Glosa_Mesa = '< TODAS >'
   ELSE
      SELECT @Glosa_Mesa =  ISNULL(TBGLOSA,'')
      FROM   VIEW_TABLA_GENERAL_DETALLE
      WHERE  tbcateg	    = '245'
      AND    tbcodigo1	    = CONVERT(CHAR(6),@Mesa)


   CREATE TABLE #temp_cartera
		(	NumDocumento		numeric(9,0)	not null default 0	,	--Numero_Documento (car)
			FechaOperacion		datetime	not null default '',
			Correlativo		smallint 	not null default 0	,	--Correlativo (car)
			Tipo_Operacion		varchar(3) 	not null default ''	,	--Tipo_Operacion (car)
			CodCartera		smallint	not null default 0	,	--CodCartera (res), CodCarteraOrigen (car)
			CodMesa			smallint	not null default 0	,	--CodMesa (res), CodMesaOrigen (car)
			Nemotecnico		varchar(12)	not null default ''	,	--Nemotecnico (car)
			Tir_Compra		numeric(19,5)	not null default 0	,	--Tir (car)
			Valor_Tasa_Emision	numeric(19,5)	not null default 0	,	--(car)
			Fecha_Vencimiento	datetime	not null default ''	,	--(car)
			Moneda			numeric(5,0)	not null default ''	,	--(car)
			Valor_Nominal		numeric(19,5)	not null default 0	,	--(car)
			FechaProxCupon		datetime	not null default ''	,	--(car)
			Capital			numeric(19,5)	not null default 0	,	--Valor_Compra (car)
			Proceso			numeric(19,5)	not null default 0	,	--Valor_Presente (car)
			Interes_Diario		float		not null default 0	,	--Intereses (car)(res)
			Reajuste_Diario		float		not null default 0	,	--Reajustes (car)(res)
			Valor_Prox_Proceso	numeric(19,5)	not null default 0	,	--Valor_Presente_prox (res)
			InteresAcum		float		not null default 0	,	--Interes_Acumulado (res)
			ReajusteAcum		float		not null default 0	,	--Reajuste_Acumulado (res)
			titulo			VARCHAR(200)	not null default ' '	,
			NombreMoneda		varchar(10)	Not Null Default ' '	,
			Base			numeric(5,0)	Not Null Default 0	,
			Valor_Compra		numeric(19,5)	not null default 0	,
			Valor_Compra_UM		numeric(19,5)	not null default 0	,
			NombreMesa		varchar(150)	Not Null Default ' '	,
			NombreCartera 		varchar(150)	Not Null Default ' '	,
			GlosaCartera		varchar(150) 	Not Null Default ' '	,
			GlosaMesa		varchar(150)	Not Null Default ' '	,
			uf_hoy			float		Not Null Default 0	,
			uf_man			float		Not Null Default 0	,
			ivp_hoy			float		Not Null Default 0	,
			ivp_man		float		Not Null Default 0	,
			do_hoy			float		Not Null Default 0	,
			da_hoy			float		Not Null Default 0
		)

             
        INSERT INTO 	#temp_cartera
		SELECT 	res.Numero_Documento
	  ,        car.Fecha_Operacion
                ,       res.Correlativo
                ,       res.Tipo_Operacion
                ,	res.CodCartera
                ,       res.CodMesa
                ,       res.Nemotecnico
                ,       res.Tir
                ,	car.Valor_Tasa_Emision      
	  ,	car.Fecha_Vencimiento
	 ,	car.Moneda
	,	car.Valor_Nominal
	,	car.FechaProxCupon
	,	car.Valor_Compra
	,	car.Valor_Presente
	,	res.Intereses
	,	res.Reajustes
	,	res.Valor_Presente_prox
	,	res.Interes_Acumulado
	,	res.Reajuste_Acumulado
		
        ,  isnull((SELECT 'CARTERA ' +CASE @tipoOp WHEN 'CI' THEN 'COMPRAS' WHEN 'VI' THEN 'VENTAS' END+' CON PACTO INTRAMESAS DEL '+CONVERT(CHAR(11),acfecproc,103)+ ' AL '+CONVERT(CHAR(11),acfecprox,103) FROM MDAC),'')
        ,       (select mnnemo from VIEW_moneda where MNCODMON = car.Moneda )
		,	(SELECT mnbase FROM VIEW_MONEDA where MNCODMON = car.Moneda )
--		,	car.Valor_Compra
--		,	car.Valor_Compra_UM
                ,       ROUND(ISNULL(car.Valor_InicialPacto,0) * ISNULL(VM.VMVALOR,1),0)
                ,       ISNULL(car.Valor_InicialPacto,0)
		,	ISNULL((SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = '245' AND TBCODIGO1 = res.CodMesa),'No Especificado')
		,	ISNULL((SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = '204' AND TBCODIGO1 = res.CodCartera),'No Especificado')
		,	@Glosa_Cartera
		,	@Glosa_Mesa
		,	@uf_hoy
		,	@uf_man
		,	@ivp_hoy
		,	@ivp_man
		,	@do_hoy
		,	@da_hoy
                FROM    tbl_CarTicketRtaFija car
                        LEFT JOIN tbl_resticketrtafija res ON car.Numero_Documento = res.Numero_Documento and car.Correlativo = res.Correlativo 
		        LEFT JOIN view_valor_moneda VM ON  vmcodigo=car.Moneda and vmfecha= car.Fecha_Operacion
               	WHERE  res.tipo_operacion = @tipoOp
               	AND    res.tipo_resultado  = 'DEV'
               	AND    res.CodCartera  NOT IN(334,335)
 	 	AND   (car.CodCarteraOrigen = @Cartera OR @Cartera= -1 )
	 	AND  (car.CodMesaOrigen = @Mesa OR @Mesa = -1 )



	SELECT DISTINCT * FROM #temp_cartera
	ORDER BY NombreMoneda, NumDocumento, Correlativo, nemotecnico

	DROP TABLE #temp_cartera



GO
