USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONSULTA_LOG_AUDITORIA]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CONSULTA_LOG_AUDITORIA](	@ENTIDAD     	CHAR(30),
							@USUARIO     	CHAR(30),
							@ID_SISTEMA  	CHAR(30),
							@TERMINAL   	CHAR(30),
							@CODIGO_EVENTO  CHAR(30),
							@CODIGOMENU  	CHAR(30),
							@FECHA   	CHAR(17),
							@ORDEN   	CHAR(30)
				    			)

AS 
BEGIN

	SET NOCOUNT ON
	DECLARE @FECHAINICIO  DATETIME 
	DECLARE @FECHATERMINO DATETIME 
	DECLARE @TIPOORDEN    CHAR(1)
	DECLARE @TIPOFECHA    CHAR(15)
	DECLARE @exec         CHAR(255)

	IF @FECHA <> ''
	 BEGIN
		SET  @FECHAINICIO = CONVERT(DATETIME,SUBSTRING(@FECHA,1,8))
		SET  @FECHATERMINO= CONVERT(DATETIME,SUBSTRING(@FECHA,10,17))
		SET  @TIPOORDEN   = SUBSTRING(@FECHA,9,1)
	END

	IF @orden = 'usuario'
		SELECT @exec = 'SELECT * FROM #tmp_log ORDER BY usuario'
	ELSE
	IF @orden = 'id_sistema'
		SELECT @exec = 'SELECT * FROM #tmp_log ORDER BY id_sistema'
	ELSE
	IF @orden = 'fechasistema'
		SELECT @exec = 'SELECT * FROM #tmp_log ORDER BY fechasistema'
	ELSE
	IF @orden = 'fechaproceso'
		SELECT @exec = 'SELECT * FROM #tmp_log ORDER BY fechaproceso'
            
	SELECT	Entidad					,
		'FechaProceso' = CONVERT(CHAR(10), FechaProceso,103)	,
		'FechaSistema' = CONVERT(CHAR(10), FechaSistema,103)	,
		HoraProceso				,
		Terminal				,
		Usuario					,
		Id_Sistema				,
		CodigoMenu				,
		Codigo_Evento				,
		DetalleTransac				,
		TablaInvolucrada			,			
		'ValorAntiguo' = SUBSTRING(ValorAntiguo,1,255)	,
		'nombreentidad' = (Select rcnombre from entidad),
		'ValorNuevo'   = SUBSTRING(ValorNuevo,1,255)	,
		'Fecha' = CONVERT(CHAR(8),getdate(),108) 		,
		'Opcion_Menu' = ISNULL( ( SELECT nombre_opcion FROM gen_menu WHERE id_sistema = gen_menu.entidad AND nombre_objeto = codigomenu ) , 'Opción No Definida' ),
		'Evento_Log'  = ISNULL( ( SELECT descripcion   FROM log_evento WHERE log_evento.codigo_evento = log_auditoria.Codigo_Evento ) , 'Evento No Definido' )
	INTO    #tmp_log
	FROM 	log_auditoria 
	WHERE   (entidad 	= @ENTIDAD       OR @Entidad 	    = '') AND
		(usuario 	= @USUARIO       OR @usuario 	    = '') AND
		(id_sistema 	= @ID_SISTEMA    OR @id_sistema     = '') AND
		(terminal 	= @TERMINAL      OR @terminal       = '') AND
		(codigo_evento  = @CODIGO_EVENTO OR @codigo_evento  = '') AND
		(codigomenu 	= @CODIGOMENU    OR @codigomenu     = '') AND
                (fechaproceso  >= @FECHAINICIO   AND  
		 fechaproceso  <= @FECHATERMINO )

	EXECUTE (@EXEC)

	SET NOCOUNT OFF

END 

-- sp_consulta_log_auditoria '1','','BFW','','','','20020101a20020116','fechasistema'
-- sp_consulta_log_auditoria '1','','BFW','','','','20020110p20020110','id_sistema'
-- sp_help log_auditoria

GO
