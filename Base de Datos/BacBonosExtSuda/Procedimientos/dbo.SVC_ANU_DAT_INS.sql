USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_ANU_DAT_INS]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

Create procedure [dbo].[SVC_ANU_DAT_INS]
(
	@NUMDOCU	NUMERIC(9)
)

AS
BEGIN
	set nocount on
	declare 	@fecpro  datetime
	select @fecpro = acfecproc from text_arc_ctl_dri



	IF EXISTS(SELECT * FROM text_mvt_dri WHERE	MONUMOPER = @NUMDOCU and mofecpro = @fecpro AND	motipoper IN('CP','VP')) BEGIN
		SELECT	A.ID_INSTRUM	,
--			A.MOFECVEN	,
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
			
		FROM 	text_mvt_dri A, text_fml_inm B
		WHERE	@NUMDOCU  = MONUMOPER
		AND	motipoper IN('CP','VP')
		AND 	B.COD_FAMILIA = A.cod_familia
		and 	mofecpro = @fecpro 


	END
	else begin
		if exists(select * from text_ctr_cpr where @NUMDOCU  = MONUMOPER AND motipoper IN('CP','VP')) begin
			SELECT	A.ID_INSTRUM	,
--				A.MOFECVEN	,
                                A.MOFECPAGO     ,
				A.MONOMINAL	,
				A.MOTIR		,
				'CLIENTE' = (SELECT CLNOMBRE FROM VIEW_CLIENTE WHERE MORUTCLI	= CLRUT AND A.MOCODCLI = CLCODIGO),
				MOSTATREG	,
				A.MOFECPRO	,
				B.DESCRIP_FAMILIA,
				a.MOFECEMI	,
				'MONEDA'=(SELECT MNGLOSA FROM VIEW_moneda WHERE MNCODMON = MOMONEMI),
				CASE a.MOTIPOPER	WHEN 'CP'  THEN 'COMPRA'
							WHEN 'VP'  THEN 'VENTA'
				
				
						
				END,
				a.MOTIPOPER	,
				a.mofecpago	,
				a.mocorrelativo
				
			FROM 	text_ctr_cpr A, text_fml_inm B
			WHERE	@NUMDOCU  = MONUMOPER
			AND	motipoper IN('CP','VP')
			AND 	B.COD_FAMILIA = A.cod_familia
		end 
		else begin
			select 0, 'Esta Operacion No se Puede Anular O No Existe'
		end 

	end
	set nocount off
END

GO
