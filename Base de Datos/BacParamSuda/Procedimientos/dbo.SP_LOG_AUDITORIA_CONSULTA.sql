USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LOG_AUDITORIA_CONSULTA]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LOG_AUDITORIA_CONSULTA]
	( 
      		@USUARIO      		CHAR(30), 	--Ej: CAVENDANO 
      		@ID_SISTEMA   		CHAR(30),	--Ej: BCC, BFW, etc 
      		@CODIGO_EVENTO  	CHAR(30),	--Ej: 01, Grabar, ModIFicar, etc
      		@CODIGO_MENU   		CHAR(30),	--Ej: Opc_20620 
      		@FECHADESDE    		CHAR(10),	-- Desde, '20100101a20100726'
      		@FECHAHASTA		CHAR(10)	-- Hasta 20100726
        )
AS 
BEGIN

	Set NOCOUNT ON

	SELECT	USU.nombre		--LA.Usuario
	, 	CASE USU.Bloqueado WHEN 0  THEN 'N'
				   WHEN '' THEN 'N'
				   WHEN 1  THEN 'S'
		END	AS Bloqueado
	,	CONVERT(CHAR(10),LA.FechaProceso,103) AS FechaProceso --SIS.nombre_sistema
	,	LA.HoraProceso		--CONVERT(CHAR(10),LA.FechaProceso,103) AS FechaProceso
	,	SIS.nombre_sistema	--LA.HoraProceso
	,	MEN.nombre_opcion
	,	LA.codigo_evento
	,	EVE.descripcion
	,	LA.DetalleTransac
	,	LA.Terminal --CU.Bloqueado

	FROM	LOG_AUDITORIA	LA	LEFT JOIN SISTEMA_CNT	SIS  
					ON SIS.id_sistema	= LA.Id_Sistema 

					LEFT JOIN LOG_EVENTO	EVE
					ON EVE.codigo_evento	= LA.codigo_evento 
			
					
					LEFT JOIN GEN_MENU	MEN
					ON	MEN.entidad		= LA.Id_Sistema
					AND	SUBSTRING(MEN.nombre_objeto,1,12)	= LA.CodigoMenu

					LEFT JOIN USUARIO		USU
					ON USU.usuario		= LA.Usuario
	
	WHERE	LA.FechaProceso 	BETWEEN  @FECHADESDE AND @FECHAHASTA
	AND	(LA.Id_Sistema		= @ID_SISTEMA	OR @ID_SISTEMA	= 'TODOS')
	AND	(LA.CodigoMenu		= SUBSTRING(@CODIGO_MENU,1,12)	OR @CODIGO_MENU	= 'TODOS')
	AND (LA.Usuario		= @USUARIO	OR @USUARIO	= 'TODOS')
	AND	CHARINDEX(LA.codigo_evento, @CODIGO_EVENTO)> 0

	
	ORDER 
	BY	USU.nombre	
	,	SIS.nombre_sistema
	,	CONVERT(CHAR(10),LA.FechaProceso,112) --LA.FechaProceso
	,	LA.HoraProceso asc


	SET NOCOUNT OFF

END
GO
