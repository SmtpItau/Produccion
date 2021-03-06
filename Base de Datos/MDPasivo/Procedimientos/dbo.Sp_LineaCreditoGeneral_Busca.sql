USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_LineaCreditoGeneral_Busca]    Script Date: 16-05-2022 11:18:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_LineaCreditoGeneral_Busca]
						(
						@rut_cli NUMERIC(09)		,
						@codigo  NUMERIC(09)
						)
AS BEGIN
SET NOCOUNT ON
SET DATEFORMAT dmy

	SELECT	'SUPERRUT'		= STR(c.clrut) + '-' + c.cldv		,
		c.clnombre		,
		a.rut_cliente		,
		a.codigo_cliente	,
		b.fechaasignacion	,
		b.fechavencimiento	,
		b.fechafincontrato	,
		b.bloqueado		,
		b.totalasignado		,
		b.totalocupado		,
		b.totaldisponible	,
		b.totalexceso		,
		b.totaltraspaso		,
 		b.totalrecibido		,
		b.rutcasamatriz		,
		b.codigocasamatriz	,
		a.codigo_grupo		,
		a.fechaasignacion	,
		a.fechavencimiento	,
		a.fechafincontrato	,
		a.realizatraspaso	,
		a.bloqueado		,
		a.compartido		,
		a.controlaplazo		,
		a.totalasignado		,
		a.totalocupado		,
		a.totaldisponible	,
		a.totalexceso		,
		a.totaltraspaso		,
		a.totalrecibido		,
		a.sinriesgoasignado	,
		a.sinriesgoocupado	,
		a.sinriesgodisponible	,
		a.sinriesgoexceso	,
		a.conriesgoasignado	,
		a.conriesgoocupado	,
		a.conriesgodisponible	,
		a.conriesgoexceso
	FROM	LINEA_SISTEMA	 as a
	INNER JOIN LINEA_GENERAL as b ON
		a.rut_cliente	= b.rut_cliente	AND
		a.rut_cliente	= @rut_cli 
	INNER JOIN CLIENTE	as c ON
		c.clrut		= @rut_cli	AND
		c.clcodigo	= @codigo	AND
		b.codigo_cliente = c.clcodigo	AND
		a.codigo_cliente = c.clcodigo

SET NOCOUNT OFF
END



GO
