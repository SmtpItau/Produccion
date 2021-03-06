USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RPT_CONTROL_CTA_CTE]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_RPT_CONTROL_CTA_CTE]
		(   @sistema 	CHAR(3) = ''   ,
		    @fecha 	CHAR(10)			
		)
AS
BEGIN
   SET NOCOUNT ON
   
   DECLARE @fc_proceso  DATETIME	
   DECLARE @Fecha0    DATETIME
   DECLARE @Fecha24  DATETIME
   DECLARE @Fecha48  DATETIME
   DECLARE @Fecha72  DATETIME
   
    SELECT  @fc_proceso = acfecproc 
    FROM    MDAC

   EXECUTE  sp_valuta_habil @fc_proceso,0,@Fecha0 output
   EXECUTE  sp_valuta_habil @fc_proceso,1,@Fecha24 output
   EXECUTE  sp_valuta_habil @fc_proceso,2,@Fecha48 output
   EXECUTE  sp_valuta_habil @fc_proceso,3,@Fecha72 output


if  @sistema <> ''	
    BEGIN 	
	SELECT 	'fecha'=fecha	,
		'Sistema' =sistema ,
		'tipo_operacion'= tipo_operacion 	,
		'numero_operacion' =numero_operacion,
		'tipo_mercado' =tipo_mercado	,
		'monto_operacion'=monto_operacion ,      
		'rut_cliente'=rut_cliente	,
		'codigo_cliente'=codigo_cliente	,
		'fecha_valuta_Ent'=CASE WHEN sistema ='BCC' AND tipo_operacion = 'V' THEN fecha_valuta_Rec ELSE fecha_valuta_Ent END,    -- fecha_valuta_Ent,
		'fecha_valuta_rec'=CASE WHEN sistema ='BCC' AND tipo_operacion = 'V' THEN fecha_valuta_Ent ELSE fecha_valuta_Rec END,    -- fecha_valuta_Rec,
	        'for_pag_entre'=for_pag_entre	,
		'glosa_entre' =glosa_entre	,
                'for_pag_recib'=for_pag_recib	,
		'glosa_recib' =glosa_recib  	,
		'estado_Pago_Efect'=estado_Pago_Efect	,
		'estado_operacion'=estado_operacion 	,
		'indica_mov_pesos'=indica_mov_pesos	,
		'moneda'=moneda			,
		'forma_pago'=forma_pago		,
		'fecha_efectiva'=fecha_efectiva          ,
		'Entidad'	= (select rcnombre from view_entidad)   ,
		'lbtr'		= CASE WHEN for_pag_entre = 128 THEN a.glosa 
				       WHEN for_pag_entre = 129 THEN a.glosa
				       WHEN for_pag_entre = 130 THEN a.glosa
				  ELSE 'OTROS' END,
		'mto1I'		= case WHEN for_pag_entre = 128 and  indica_mov_pesos= 'I'then monto_operacion else 0	end  ,
		'mto2I'		= case WHEN for_pag_entre = 129 and  indica_mov_pesos= 'I'then monto_operacion else 0	end  ,
		'mto3I'		= case WHEN for_pag_entre = 130 and  indica_mov_pesos= 'I'then monto_operacion else 0	end  ,
		'mto4I'		= case when (CASE WHEN for_pag_entre = 128 THEN a.glosa
				       WHEN for_pag_entre = 129 THEN a.glosa
				       WHEN for_pag_entre = 130 THEN a.glosa
				  ELSE 'OTROS' END)= 'OTROS'  and  indica_mov_pesos= 'I'then monto_operacion else 0	end ,
		'mto1E'		= case WHEN for_pag_entre = 128 and  indica_mov_pesos= 'E'then monto_operacion else 0	end  ,
		'mto2E'		= case WHEN for_pag_entre = 129 and  indica_mov_pesos= 'E'then monto_operacion else 0	end  ,
		'mto3E'		= case WHEN for_pag_entre = 130 and  indica_mov_pesos= 'E'then monto_operacion else 0	end  ,
		'mto4E'		= case when (CASE WHEN for_pag_entre = 128 THEN a.glosa
				       WHEN for_pag_entre = 129 THEN a.glosa
				       WHEN for_pag_entre = 130 THEN a.glosa
				  ELSE 'OTROS' END)= 'OTROS'  and  indica_mov_pesos= 'E'then monto_operacion else 0	end ,
		'FechaA'	= @Fecha0,
		'FechaB'	= @Fecha24,
		'FechaC'	= @Fecha48,
		'FechaD'	= @Fecha72
			  

	FROM  VIEW_CTACTEBCCH ,
   	      View_forma_de_pago a

	WHERE estado_operacion  <> 'A'  AND
	      for_pag_entre =a.codigo	AND
	      sistema	= @sistema	AND
	      fecha	= @fecha	AND
	      fecha_efectiva >= @fecha 	
	

    END
else
     BEGIN
	  SELECT 'fecha'=fecha	,
		'Sistema' =sistema ,
		'tipo_operacion'= tipo_operacion 	,
		'numero_operacion' =numero_operacion,
		'tipo_mercado' =tipo_mercado	,
		'monto_operacion'=monto_operacion ,      
		'rut_cliente'=rut_cliente	,
		'codigo_cliente'=codigo_cliente	,
		'fecha_valuta_Ent'=CASE WHEN sistema ='BCC' AND tipo_operacion = 'V' THEN fecha_valuta_Rec ELSE fecha_valuta_Ent END,  -- fecha_valuta_Ent,
		'fecha_valuta_rec'=CASE WHEN sistema ='BCC' AND tipo_operacion = 'V' THEN fecha_valuta_Ent ELSE fecha_valuta_Rec END,  -- fecha_valuta_Rec,
	        'for_pag_entre'=for_pag_entre	,
		'glosa_entre' =glosa_entre	,
 'for_pag_recib'=for_pag_recib	,
		'glosa_recib' =glosa_recib  	,
		'estado_Pago_Efect'=estado_Pago_Efect	,
		'estado_operacion'=estado_operacion 	,
		'indica_mov_pesos'=indica_mov_pesos	,
		'moneda'=moneda			,
		'forma_pago'=forma_pago		,
		'fecha_efectiva'=fecha_efectiva          ,
		'Entidad'	= (select rcnombre from view_entidad)   ,
		'lbtr'		= CASE WHEN for_pag_entre = 128 THEN a.glosa
				       WHEN for_pag_entre = 129 THEN a.glosa
				       WHEN for_pag_entre = 130 THEN a.glosa
				  ELSE 'OTROS' END,
		'mto1I'		= case WHEN for_pag_entre = 128 and  indica_mov_pesos= 'I'then monto_operacion else 0	end  ,
		'mto2I'		= case WHEN for_pag_entre = 129 and  indica_mov_pesos= 'I'then monto_operacion else 0	end  ,
		'mto3I'		= case WHEN for_pag_entre = 130 and  indica_mov_pesos= 'I'then monto_operacion else 0	end  ,
		'mto4I'		= case when (CASE WHEN for_pag_entre = 128 THEN a.glosa
				       WHEN for_pag_entre = 129 THEN a.glosa
				       WHEN for_pag_entre = 130 THEN a.glosa
				  ELSE 'OTROS' END)= 'OTROS'  and  indica_mov_pesos= 'I'then monto_operacion else 0	end  ,
		'mto1E'		= case WHEN for_pag_entre = 128 and  indica_mov_pesos= 'E'then monto_operacion else 0	end  ,
		'mto2E'		= case WHEN for_pag_entre = 129 and  indica_mov_pesos= 'E'then monto_operacion else 0	end  ,
		'mto3E'		= case WHEN for_pag_entre = 130 and  indica_mov_pesos= 'E'then monto_operacion else 0	end  ,
		'mto4E'		= case when (CASE WHEN for_pag_entre = 128 THEN a.glosa
				       WHEN for_pag_entre = 129 THEN a.glosa
				       WHEN for_pag_entre = 130 THEN a.glosa
				  ELSE 'OTROS' END)= 'OTROS'  and  indica_mov_pesos= 'E'then monto_operacion else 0	end ,
                'FechaA'	= @Fecha0,
		'FechaB'	= @Fecha24,
		'FechaC'	= @Fecha48,
		'FechaD'	= @Fecha72


	FROM  VIEW_CTACTEBCCH ,
   	      View_forma_de_pago a

	WHERE estado_operacion  <> 'A'  AND
	      for_pag_entre =a.codigo	AND
	      fecha   = @fecha		AND
	      fecha_efectiva >= @fecha 	


    END	


END

   SET NOCOUNT OFF

GO
