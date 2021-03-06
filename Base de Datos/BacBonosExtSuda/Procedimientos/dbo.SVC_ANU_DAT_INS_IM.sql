USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_ANU_DAT_INS_IM]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[SVC_ANU_DAT_INS_IM] 
(
	@NUMDOCU	numeric(9)
)	
AS
BEGIN
	set nocount on
	declare @fecpro  datetime
	
	select @fecpro = acfecproc from text_arc_ctl_dri

	IF EXISTS(SELECT * FROM MOV_ticketbonext WHERE MONUMOPER = @NUMDOCU and mofecpro = @fecpro AND motipoper IN('CP','VP')) BEGIN
		SELECT	A.ID_INSTRUM	,
		        A.MOFECPAGO     ,
			A.MONOMINAL	,
			A.MOTIR		,
			'CLIENTE' = (SELECT CLNOMBRE FROM VIEW_CLIENTE WHERE MORUTCLI	= CLRUT AND A.MOCODCLI = CLCODIGO),
			MOSTATREG	,
			A.MOFECPRO	,
			B.DESCRIP_FAMILIA,
			MOFECEMI	,
			'MONEDA'=(SELECT MNGLOSA FROM VIEW_moneda WHERE MNCODMON = MOMONEMI),
			CASE a.MOTIPOPER	WHEN 'CP'  THEN 'COMPRA'
					WHEN 'VP'  THEN 'VENTA'
					WHEN 'VVP' THEN 'VENTA'	
					WHEN 'VCP' THEN 'COMPRA'	
					
			END,
			a.MOTIPOPER	,
			mofecpago	,
			a.mocorrelativo
			
		FROM 	MOV_ticketbonext A, text_fml_inm B
		WHERE	@NUMDOCU  = MONUMOPER
		AND	motipoper IN('CP','VP')
		AND 	B.COD_FAMILIA = A.cod_familia
		and 	mofecpro = @fecpro 


	END
	else 
		select 0, 'Esta Operacion No se Puede Anular O No Existe'

	set nocount off
END


GO
