USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_AYU_ANU]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[SVC_AYU_ANU] 
AS
BEGIN
	set nocount on

	declare 	@fecpro  datetime

	SELECT @fecpro = acfecproc from text_arc_ctl_dri

	SELECT DISTINCT
		--A.ID_INSTRUM	,
		--CONVERT(CHAR(10),A.MOFECVEN,103),
		--A.MONOMINAL	,
		--A.MOTIR		,
		'CLIENTE' = (SELECT CLNOMBRE FROM VIEW_CLIENTE WHERE MORUTCLI	= CLRUT AND A.MOCODCLI = CLCODIGO),
		MOSTATREG	,
		A.MOFECPRO	,
		--B.DESCRIP_FAMILIA,
		--MOFECEMI	,
		--'MONEDA'=(SELECT MNGLOSA FROM VIEW_moneda WHERE MNCODMON = MOMONEMI),
		CASE a.MOTIPOPER	
                            WHEN 'CP'  THEN 'COMPRA'
			    WHEN 'VP'  THEN 'VENTA'
			END,
		a.MOTIPOPER	,
		CONVERT(CHAR(10),mofecpago,103)	,
		a.monumoper			
		FROM 	text_mvt_dri A  --, text_fml_inm B
		WHERE	motipoper IN('CP','VP')
--		AND 	B.COD_FAMILIA = A.cod_familia
		and 	mofecpro = @fecpro 
		AND     MOSTATREG <> 'A'

	set nocount off
END
				
GO
