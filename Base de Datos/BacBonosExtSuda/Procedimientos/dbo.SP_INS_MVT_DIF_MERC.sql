USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INS_MVT_DIF_MERC]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_INS_MVT_DIF_MERC]
   (   @Fecha		Datetime,	-- Fecha de la operacion.
       @Indicador		Int        		-- 0=Reversa; 1=diario.
   )		
as
BEGIN
   --OBTIENE LA FECHA DE PROCESO CON LA QUE SE MANEJA EL SERVIDOR
   DECLARE @FechaSis datetime
   SELECT  @FechaSis=acfecproc 
   FROM text_arc_ctl_dri 

  IF @Indicador=0  
   Begin
   INSERT INTO TEXT_MVT_DRI_TAS_MERC
  	SELECT @FechaSis
	,	rsrutcart
	,	rsnumoper
	,	rsnumdocu
	,	rscorrelativo
	,	'TM' 
	,	cod_nemo
	,	cod_familia
	,	id_instrum
	,	rsrutcli
	,	rscodcli
	,	rsfecemis
	,	rsfecvcto
	,	rsfecneg
	,	rsmonemi
	,	rsmonpag
	,	0 
	,	rstasemi
	,	rsbasemi
	,	rsrutemis
	,	rsfecpago
	,	rsnominal
	,	rsvppresen
	,	rsvalvenc
	,	0 
	,	0 
	,	rstir
	,	rspvp
	,	0 
	,	rsint_compra
	,	rsprincipal
	,	0 
	,	rsvalcomu
	,	rsinteres
	,	rsreajuste
	,	0 
	,	0 
	,	0 
	,	rsnumucup
	,	rsnumpcup
	,	'' 
	,	mostatreg = CASE	WHEN @indicador  = 0 THEN 'R'
					WHEN @indicador  = 1 THEN ''  END
 	,	''  
	,	basilea
	,	tipo_tasa
	,	encaje
	,	monto_encaje
	,	codigo_carterasuper
	,	Tipo_Cartera_Financiera
	,	sucursal
	,	'' 
	,	'' 
	,	'' 
	,	'' 
	,	'' 
	,	'' 
	,	'' 
	,	corr_cli_nombre
	,	corr_cli_cta
	,	corr_cli_aba
	,	corr_cli_pais
	,	corr_cli_ciud
	,	corr_cli_swift
	,	corr_cli_ref
	,	'' 
	,	operador_banco
	,	calce
	,	'' 
	,	'' 
	,	'' 
	,	0 
	,	0 
	,	''  
	,	rscodemi
	,	rsfecucup
	,	rsfecpcup
	,	''  
	,	'' 
	,	CapitalPeso
	,	InteresPeso
	,	0 
	,	rsvppresen
	,	rsDiferenciaMerc
	,	PorcjeCob 
	FROM    text_rsu 
        	WHERE   rsfecpro = @Fecha
	AND	rsfecpago <= rsfecpro
	AND 	rstipoper='DEV'	
    End
   Else
    Begin
        INSERT INTO TEXT_MVT_DRI_TAS_MERC
  	SELECT @FechaSis
	,	rsrutcart
	,	rsnumoper
	,	rsnumdocu
	,	rscorrelativo
	,	'TM' 
	,	cod_nemo
	,	cod_familia
	,	id_instrum
	,	rsrutcli
	,	rscodcli
	,	rsfecemis
	,	rsfecvcto
	,	rsfecneg
	,	rsmonemi
	,	rsmonpag
	,	0 
	,	rstasemi
	,	rsbasemi
	,	rsrutemis
	,	rsfecpago
	,	rsnominal
	,	rsvppresen
	,	rsvalvenc
	,	0 
	,	0 
	,	rstir
	,	rspvp
	,	0 
	,	rsint_compra
	,	rsprincipal
	,	0 
	,	rsvalcomu
	,	rsinteres
	,	rsreajuste
	,	0 
	,	0 
	,	0 
	,	rsnumucup
	,	rsnumpcup
	,	'' 
	,	mostatreg = CASE WHEN @indicador  = 0 THEN 'R'
		                 	   WHEN @indicador  = 1 THEN ''
	      	            END
 	,	''  
	,	basilea
	,	tipo_tasa
	,	encaje
	,	monto_encaje
	,	codigo_carterasuper
	,	Tipo_Cartera_Financiera
	,	sucursal
	,	'' 
	,	'' 
	,	'' 
	,	'' 
	,	'' 
	,	'' 
	,	'' 
	,	corr_cli_nombre
	,	corr_cli_cta
	,	corr_cli_aba
	,	corr_cli_pais
	,	corr_cli_ciud
	,	corr_cli_swift
	,	corr_cli_ref
	,	'' 
	,	operador_banco
	,	calce
	,	'' 
	,	'' 
	,	'' 
	,	0 
	,	0 
	,	''  
	,	rscodemi
	,	rsfecucup
	,	rsfecpcup
	,	''  
	,	'' 
	,	CapitalPeso
	,	InteresPeso
	,	0 
	,	rsvppresen
	,	rsDiferenciaMerc
	,	PorcjeCob 
	FROM    TEXT_RSU 
       	WHERE rsfecpro =  @Fecha
	AND 	 rstipoper='DEV'	
    End  
END

GO
