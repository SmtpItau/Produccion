USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONSULTA_LOG_AUDITORIAU]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CONSULTA_LOG_AUDITORIAU](	@ENTIDAD     	CHAR(1),
						@HORAPROCESO    CHAR(8),
						@TERMINAL       CHAR(30),
						@USUARIO     	CHAR(15),
						@ID_SISTEMA  	CHAR(3)
				      		)

AS BEGIN

SET NOCOUNT ON

	DECLARE @SISTEMA VARCHAR(60)
	SELECT @SISTEMA = nombre_sistema FROM SISTEMA_CNT WHERE @ID_SISTEMA = id_sistema

	SELECT 'SISTEMA' = @SISTEMA,
	       'HORA'    = CONVERT(CHAR(8),getdate(),108)
	INTO #TABLAPASO	

	SELECT  Entidad,
		FechaProceso,
		FechaSistema,
		HoraProceso,
		Terminal,
		Usuario,
		Id_Sistema,
		'CodigoMenu' = ISNULL( ( SELECT nombre_opcion FROM gen_menu WHERE id_sistema = gen_menu.entidad AND nombre_objeto = codigomenu ) , 'Opción No Definida' ),
		'Codigo_Evento' = ISNULL( ( SELECT descripcion   FROM log_evento WHERE log_evento.codigo_evento = log_auditoria.Codigo_Evento ) , 'Evento No Definido' ),
		DetalleTransac,
		TablaInvolucrada,
		'ValorAntiguo' =  SUBSTRING(ValorAntiguo,1,255)	,
		'ValorNuevo'   =  SUBSTRING(ValorNuevo,1,255),
                'nombreentidad' = (Select rcnombre from entidad),  
		SISTEMA,
		HORA		
	FROM LOG_AUDITORIA,#TABLAPASO 
	WHERE 	@ENTIDAD     	= Entidad 		AND
		@HORAPROCESO    = HoraProceso		AND
		@TERMINAL       = Terminal		AND
		@USUARIO     	= Usuario		AND
		@ID_SISTEMA  	= Id_Sistema		

SET NOCOUNT OFF

END

/*

 sp_consulta_log_auditoriaU '1','11:07:30','BAC_0159_LABARCA','ADMINISTRA','BFW'
 sp_consulta_log_auditoriaU '1','13:45:05','BAC0159_LABARCA','ADMINISTRA','ADM'

select * from log_auditoria
sp_help log_auditoria
18:31:38    BAC_0259_A      ADMINISTRA  SCF

*/
GO
