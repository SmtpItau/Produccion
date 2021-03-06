USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_AYU_ANU_IM]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SVC_AYU_ANU_IM]

/*JBH, 02/11/2009
Carga movimientos posibles de anulación de movimientos grabados como Intramesas
*/
AS
	set nocount on
	declare @fecpro datetime
	SELECT @fecpro = acfecproc from text_arc_ctl_dri
	SELECT DISTINCT
	'CLIENTE' = (SELECT CLNOMBRE FROM VIEW_CLIENTE WHERE MORUTCLI	= CLRUT AND A.MOCODCLI = CLCODIGO),
	MOSTATREG,
	A.MOFECPRO,
	CASE a.MOTIPOPER	WHEN 'CP'  THEN 'COMPRA IM'
				WHEN 'VP'  THEN 'VENTA IM'
	END,
	RTRIM(LTRIM(a.MOTIPOPER)) + 'I',
	CONVERT(CHAR(10),mofecpago,103)	,
	a.monumoper,
	a.operacion_relacionada		-- JBH, 17-12-2009
	FROM 	MOV_ticketbonext A
	WHERE	motipoper IN('CP','VP')
	AND 	mofecpro = @fecpro 
	AND     MOSTATREG <> 'A'
	set nocount off


GO
