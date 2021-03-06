USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVA_INS_ELI_REG]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[SVA_INS_ELI_REG] 
(
        @cod_familia	NUMERIC		  (5),
	@cod_nemo	CHAR		(20) ,
	@fecha_vcto	DATETIME	     
)	
AS 
BEGIN

	IF exists( select * from text_rsu where cod_familia = @cod_familia and cod_nemo = @cod_nemo and rsfecvcto = @fecha_vcto )
	BEGIN
		SELECT 'NO', 'Existe Información Relacionado con este instrumento'
		RETURN

	END


	IF exists( select * from text_mvt_dri where cod_familia = @cod_familia and cod_nemo = @cod_nemo and mofecven = @fecha_vcto )
	BEGIN
		SELECT 'NO', 'Existe Información Relacionado con este instrumento'
		RETURN

	END


	IF exists( select * from text_ctr_cpr where cod_familia = @cod_familia and cod_nemo = @cod_nemo and mofecven = @fecha_vcto )
	BEGIN
		SELECT 'NO', 'Existe Información Relacionado con este instrumento'
		RETURN

	END



	DELETE text_frm WHERE 	cod_familia = @cod_familia 	AND
				cod_nemo    = @cod_nemo	AND
                                fecha_vcto  = @fecha_vcto


	DELETE TEXT_DSA WHERE	cod_familia = @cod_familia 	AND
				cod_nemo    = @cod_nemo	AND
                                fecha_vcto  = @fecha_vcto

	DELETE TEXT_SER	 WHERE   cod_familia = @cod_familia 	AND
				 cod_nemo    = @cod_nemo	AND
				 fecha_vcto  = @fecha_vcto



END


--select * from text_series
--select * from text_frm
--Sp_invex_valorizador '20010131', 'P', 2, 2000, 'CELARAUC FIXED', '20050915', 7, 6.95, 6.95, 0, '360', 0, 1000000, 0, 0, 0, 0, 0, '20010131', '19971003', '20050915', '18991230', '18991230', '20010131', 0, 0, 0

--  select * from text_rsu 

GO
