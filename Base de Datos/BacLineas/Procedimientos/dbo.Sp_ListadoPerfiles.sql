USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_ListadoPerfiles]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






CREATE PROCEDURE [dbo].[Sp_ListadoPerfiles]
AS
BEGIN

	SET NOCOUNT ON
	
	CREATE TABLE #TEMPORAL1(sistema 		CHAR(20)	,				
				movimiento 		CHAR(20)	,
				operacion		CHAR(20)	,	
				folio_perfil		FLOAT	,
				glosa_perfil		CHAR(70)	,				
				codigo_instrumento	CHAR(10)	,
				glosa_instrumento	CHAR(40)	,
				codigo_moneda		CHAR(8)		,
				glosa_moneda		CHAR(35)	,				
				codigo_campo		FLOAT	,
				tipo_movimiento_cuenta  CHAR(1)		,
				perfil_fijo		CHAR(1)		,
				codigo_cuenta		CHAR(20)	,
				correlativo_perfil	FLOAT	,
				codigo_campo_variable	FLOAT	,
				descripcion_campo	CHAR(60)	,
				descripcion		CHAR(70)	,
				hora			CHAR(8)		,
				valor_dato		CHAR(30)	,
				codigo_cuenta_variable  CHAR(20)	,
				descripcion_campo_variable CHAR(60)	,
				descripcion_cuenta_variable CHAR(70)	,
				sistema2 		CHAR(20)	)				


	INSERT INTO #TEMPORAL1
	SELECT			
		ISNULL((SELECT nombre_sistema FROM SISTEMA_CNT WHERE SISTEMA_CNT.id_sistema = PERFIL_CNT.id_sistema),''),
		LEFT(ISNULL((SELECT glosa_movimiento FROM MOVIMIENTO_CNT WHERE MOVIMIENTO_CNT.tipo_movimiento = PERFIL_CNT.tipo_movimiento AND MOVIMIENTO_CNT.tipo_operacion = PERFIL_CNT.tipo_operacion AND PERFIL_CNT.id_sistema = MOVIMIENTO_CNT.id_sistema ),''),20),
		LEFT(ISNULL((SELECT glosa_operacion FROM MOVIMIENTO_CNT WHERE MOVIMIENTO_CNT.tipo_operacion = PERFIL_CNT.tipo_operacion AND MOVIMIENTO_CNT.tipo_movimiento = PERFIL_CNT.tipo_movimiento AND MOVIMIENTO_CNT.id_sistema = PERFIL_CNT.id_sistema),''),20),
		ISNULL(PERFIL_DETALLE_CNT.folio_perfil,0),
		ISNULL(PERFIL_CNT.glosa_perfil,'') ,
		ISNULL(PERFIL_CNT.codigo_instrumento ,''),
		ISNULL((SELECT inglosa FROM INSTRUMENTO WHERE PERFIL_CNT.codigo_instrumento = inserie),''), 
		ISNULL(CASE 	WHEN PERFIL_CNT.id_sistema = 'BFW' THEN (SELECT mnnemo FROM MONEDA WHERE CONVERT(INTEGER,codigo_instrumento) = mncodmon) 
							WHEN PERFIL_CNT.id_sistema = 'BCC' THEN ''
							WHEN PERFIL_CNT.id_sistema = 'PCS' THEN (SELECT mnnemo FROM MONEDA WHERE CONVERT(INTEGER,codigo_instrumento) = mncodmon) 
							ELSE (SELECT mnnemo FROM MONEDA WHERE CONVERT(INTEGER,moneda_instrumento) = mncodmon) 
		  	        END , '' ) ,
		ISNULL(CASE	WHEN PERFIL_CNT.id_sistema = 'BFW' THEN (SELECT mnglosa FROM MONEDA WHERE CONVERT(INTEGER,codigo_instrumento) = mncodmon)
							WHEN PERFIL_CNT.id_sistema = 'BCC' THEN ''
							WHEN PERFIL_CNT.id_sistema = 'PCS' THEN (SELECT mnnemo FROM MONEDA WHERE CONVERT(INTEGER,codigo_instrumento) = mncodmon) 
							ELSE (SELECT mnglosa FROM MONEDA WHERE moneda_instrumento = mncodmon)
				END , '' ) ,	
		ISNULL(PERFIL_DETALLE_CNT.codigo_campo,0),
		ISNULL(tipo_movimiento_cuenta,''),
		ISNULL(perfil_fijo,''),
		CASE
					WHEN ISNULL(PERFIL_DETALLE_CNT.codigo_cuenta,'') = "0" THEN ""
					ELSE ISNULL(PERFIL_DETALLE_CNT.codigo_cuenta,'')
				  END,
		ISNULL(PERFIL_DETALLE_CNT.correlativo_perfil,0),
		ISNULL(codigo_campo_variable,0),
		ISNULL(e.descripcion_campo,''),
		CASE 
					WHEN ISNULL(PLAN_DE_CUENTA.descripcion,'')="" AND ISNULL(perfil_fijo,'')= "S" THEN "No Existe"
					WHEN ISNULL(PLAN_DE_CUENTA.descripcion,'')="" AND ISNULL(perfil_fijo,'')= "N" THEN "PERFIL VARIABLE " + ISNULL((SELECT UPPER(descripcion_campo) FROM CAMPO_CNT d WHERE d.codigo_campo = codigo_campo_variable AND d.tipo_administracion_campo = "V" AND d.id_sistema = PERFIL_CNT.id_sistema AND d.tipo_operacion = PERFIL_CNT.tipo_operacion),'')
			 	ELSE ISNULL(PLAN_DE_CUENTA.descripcion,'')
			 	END,
		CONVERT(VARCHAR(10),GETDATE(),108),
		" " ,
		" " ,
		ISNULL((SELECT descripcion_campo FROM CAMPO_CNT d WHERE d.codigo_campo = codigo_campo_variable AND d.tipo_administracion_campo = "V" AND d.id_sistema = PERFIL_CNT.id_sistema AND d.tipo_operacion = PERFIL_CNT.tipo_operacion),''),
		" "	,
		ISNULL((SELECT nombre_sistema FROM SISTEMA_CNT WHERE SISTEMA_CNT.id_sistema = PERFIL_CNT.id_sistema),'')
	FROM 	PERFIL_DETALLE_CNT, 
		PERFIL_CNT,
		CAMPO_CNT e,
		PLAN_DE_CUENTA
	WHERE 	PERFIL_DETALLE_CNT.folio_perfil 		= PERFIL_CNT.folio_perfil			
		AND e.tipo_operacion 	       			= PERFIL_CNT.tipo_operacion
		AND e.codigo_campo         	       		= PERFIL_DETALLE_CNT.codigo_campo
		AND PLAN_DE_CUENTA.cuenta           		=* rtrim(ltrim(PERFIL_DETALLE_CNT.codigo_cuenta))


	-- ORDER BY sistema,PERFIL_DETALLE_CNT.folio_perfil,PERFIL_DETALLE_CNT.Correlativo_perfil

	ORDER BY PERFIL_DETALLE_CNT.Correlativo_perfil

	INSERT INTO #TEMPORAL1 SELECT ISNULL((SELECT nombre_sistema FROM SISTEMA_CNT WHERE SISTEMA_CNT.id_sistema = b.id_sistema),''),
	       			      LEFT(ISNULL((SELECT glosa_movimiento FROM MOVIMIENTO_CNT WHERE MOVIMIENTO_CNT.tipo_movimiento = b.tipo_movimiento AND MOVIMIENTO_CNT.tipo_operacion = b.tipo_operacion AND b.id_sistema = MOVIMIENTO_CNT.id_sistema ),''),20),
			       	      LEFT(ISNULL((SELECT glosa_operacion FROM MOVIMIENTO_CNT WHERE MOVIMIENTO_CNT.tipo_operacion = b.tipo_operacion AND MOVIMIENTO_CNT.tipo_movimiento = b.tipo_movimiento AND MOVIMIENTO_CNT.id_sistema = b.id_sistema),''),20),
			    	      ISNULL(a.folio_perfil,0),
			   	      ISNULL(b.glosa_perfil,'') ,
				      ISNULL(b.codigo_instrumento ,''),
				      ISNULL((SELECT inglosa FROM INSTRUMENTO WHERE b.codigo_instrumento = inserie),''), 	
				      ISNULL(CASE 	WHEN b.id_sistema = 'BFW' THEN (SELECT mnnemo FROM MONEDA WHERE CONVERT(INTEGER,codigo_instrumento) = mncodmon) 
							WHEN b.id_sistema = 'BCC' THEN ''
							WHEN b.id_sistema = 'PCS' THEN (SELECT mnnemo FROM MONEDA WHERE CONVERT(INTEGER,codigo_instrumento) = mncodmon) 
							ELSE (SELECT mnnemo FROM MONEDA WHERE CONVERT(INTEGER,moneda_instrumento) = mncodmon) 
		  	        			END , '' ) ,
		 	              ISNULL(CASE	WHEN b.id_sistema = 'BFW' THEN (SELECT mnglosa FROM MONEDA WHERE CONVERT(INTEGER,codigo_instrumento) = mncodmon)
							WHEN b.id_sistema = 'BCC' THEN ''
							WHEN b.id_sistema = 'PCS' THEN (SELECT mnnemo FROM MONEDA WHERE CONVERT(INTEGER,codigo_instrumento) = mncodmon) 
							ELSE (SELECT mnglosa FROM MONEDA WHERE moneda_instrumento = mncodmon)
							END , '' ) ,						      
					0,
					" ",
					" ",
					" ",
					a.correlativo_perfil,
					0,
					" ",
					" ",
					" ",
					valor_dato_campo,
					a.codigo_cuenta ,
					" ",
					isnull(descripcion,"No Existe"),
					ISNULL((SELECT nombre_sistema FROM SISTEMA_CNT WHERE SISTEMA_CNT.id_sistema = b.id_sistema),'')	

				 from perfil_variable_cnt a,
				      Plan_de_cuenta, 
				      perfil_cnt b 
				 where a.folio_perfil = b.folio_perfil 
				       and plan_de_cuenta.cuenta =* rtrim(ltrim(a.codigo_cuenta))

	SELECT * FROM #TEMPORAL1 c order by c.correlativo_perfil

	SET NOCOUNT OFF

END



-- SELECT * FROM PERFIL_CNT
-- SELECT * FROM PERFIL_DETALLE_CNT
-- SELECT * FROM PERFIL_VARIABLE_CNT
-- SELECT * FROM CAMPO_CNT codigo_campo_variable
-- sp_autoriza_ejecutar 'bacuser'





GO
