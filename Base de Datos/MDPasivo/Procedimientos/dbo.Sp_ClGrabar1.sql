USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_ClGrabar1]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Sp_ClGrabar1]
			       (	
				@clrut		NUMERIC		(09,0)	,
				@cldv		CHAR		(01)	,
				@clcodigo	NUMERIC		(09,0)	,
				@clnombre	CHAR		(70)	,
				@clgeneric	CHAR		(05)	,
				@cldirecc	CHAR		(40)	,
				@clcomuna	NUMERIC		( 8)	,
				@clregion	NUMERIC		( 5)	,
				@cltipcli	NUMERIC		( 5)    ,
				@clfecingr	DATETIME		,
				@clctacte	CHAR		(15)	,
				@clfono 	CHAR		(20)	,
				@clfax		CHAR		(20)    ,
				@clapelpa	CHAR		(20)    ,
				@clapelma	CHAR		(20)    ,
				@clnomb1	CHAR		(15)    ,
	            @clnomb2	CHAR		(15)    ,
				@clciudad	NUMERIC		( 8)    ,
				@clmercado	NUMERIC		( 5)    ,
				@clpais 	NUMERIC		( 5)    ,
				@clcalidad      NUMERIC		( 5)    ,
				@clchips	CHAR		(20)    ,
				@claba   	CHAR		(20)    ,
				@clswift	CHAR		(20)    ,
				@clctausd	CHAR		(20)    ,
				@climplic	CHAR		(20)    ,
                                @clopcion       CHAR            ( 2)    ,
				@clrelaciongb   NUMERIC         ( 2)    ,
				@clcatego       NUMERIC         ( 2)    ,
				@clsector       NUMERIC         ( 3)    ,
				@clclsbif       CHAR            ( 2)    ,
				@clactivida     NUMERIC         ( 3)    ,
				@cltipemp       CHAR            ( 2)    ,
				@clrelbco       NUMERIC         ( 2)    ,
				@clpoder        CHAR            ( 2)    ,
				@clfirma        CHAR            ( 2)    ,
				@clinfosoc      CHAR            ( 2)    ,
				@clart85        CHAR            ( 2)    ,
                                @rut_grupo      NUMERIC         (10)    ,
				@clcodfox       NUMERIC         ( 7)    ,
				@clcodinst      NUMERIC         ( 3)    ,
				@clcodban       NUMERIC         ( 5)    ,
				@cloficinas     CHAR            ( 1)    ,
				@clcriesgo      CHAR            (10)	,
                                @codigo_otc     CHAR            (10)	,     
                                @bloqueado      CHAR            (1) 	,
                                @clvalidalinea  CHAR            (1) 	,
				@cldec85        CHAR            (1)	,
				@CodNif         VARCHAR         (10)	
)
AS
BEGIN

        SET NOCOUNT ON
        SET DATEFORMAT dmy

	--SELECT @CLSWIFT = ISNULL(CODIGO_PAIS_SUPER,0) FROM PAIS WHERE CODIGO_PAIS = @CLSWIFT

	/*
	09/11/2004 jspp 
	Validación para que el codigo NIF no sea asignado a mas de una entidad Emisora, 
	campo para interfaz Contabilidad a España
       */
	--IF EXISTS(SELECT codnif FROM CLIENTE WHERE LTRIM(RTRIM(codnif)) = @codnif and codnif<>' '
	--					   AND clrut    <> @clrut
     	--  					   AND cldv     <> @cldv )
        --  BEGIN   
	--	  SET NOCOUNT OFF
        --          SELECT "NO"
        --          RETURN
        --  END

	IF EXISTS(SELECT clrut FROM CLIENTE WHERE clrut    = @clrut 
					   AND cldv     = @cldv 
                                           AND clcodigo = @clcodigo) BEGIN

		UPDATE	CLIENTE
		SET		clrut  	      = @clrut		,
				clcodigo      = @clcodigo 	,
				clnombre      = @clnombre 	,
				clgeneric     = @clgeneric	,
				cldirecc      = @cldirecc	,
				clcomuna      = @clcomuna 	,
				clregion      = @clregion	,
				cltipcli      = @cltipcli 	,
				clfecingr     = @clfecingr	,
				clctacte      = @clctacte	,
				clfono        = @clfono		,
				clfax	      = @clfax		,
				clapelpa      = @clapelpa	,
				clapelma      = @clapelma	,
				clnomb1	      = @clnomb1   	,
				clnomb2	      = @clnomb2   	,
				clciudad      = @clciudad	,
				clmercado     = @clmercado	,
				clpais 	      = @clpais		,
				clcalidadjuridica = @clcalidad	,
				clchips       = @clchips	,
				claba         = @claba  	,
				clswift       = @clswift	,
				clctausd      = @clctausd	,
				climplic      = @climplic	,
                                clopcion      = @clopcion  	,
				clrelacion    = @clrelaciongb	,
				clcatego      = @clcatego  	,
				clsector      = @clsector  	,
				clclsbif      = @clclsbif  	,
				clactivida    = @clactivida	,
				cltipemp      = @cltipemp  	,
				relbco        = @clrelbco  	,
				poder         = @clpoder   	,
				firma         = @clfirma   	,
				infosoc       = @clinfosoc 	,
				art85         = @clart85   	,
				dec85         = @cldec85   	,
				rut_grupo     = @Rut_Grupo 	,
                                clcodfox      = @clcodfox  	,
				cod_inst      = @clcodinst 	,
				clcodban      = @clcodban  	,
				clvalidalinea = @clvalidalinea	, --(CASE WHEN @clrelaciongb = 3 THEN'S' ELSE 'N' END),਍ഀ
				oficinas      = @cloficinas 	,
		                clclaries     = @clcriesgo 	,
                                codigo_otc    = @codigo_otc	,
                                bloqueado     = @bloqueado	,
				CodNif	      = @CodNif		  -- 09/11/2004 jspp Interfaz Contabilida a España਍ഀ



			WHERE	 clrut = @clrut AND cldv = @cldv AND clcodigo = @clcodigo

	END ELSE BEGIN
		INSERT CLIENTE
				(clrut  	,
				cldv		,
				clcodigo	,
				clnombre	,
				clgeneric	,
				cldirecc	,
				clcomuna	,
				clregion	,
				cltipcli	,
				clfecingr	,
				clctacte	,
				clfono 		,
				clfax		,
				clapelpa	,
				clapelma	,
				clnomb1	        ,
				clnomb2	        ,
				clciudad	,
				clmercado	,
				clpais 		,
				clcalidadjuridica,
				clchips		,
				claba   	,
				clswift		,
				clctausd	,
				climplic	,
                                clopcion        ,
				clrelacion      ,
				clcatego        ,
				clsector        ,
				clclsbif        ,
				clactivida      ,
				cltipemp        ,
				relbco          ,
				poder           ,
				firma           ,
				infosoc         ,				art85           ,
				dec85           ,
				rut_grupo       ,
				clcodfox	,
				cod_inst        ,
				clcodban        ,
                                clvalidalinea   ,
				oficinas	,
                                clclaries	,
                                codigo_otc	,
                                bloqueado  	,
				CodNif	       	
				)                   

		VALUES		(
				@clrut 		,
				@cldv		,
				@clcodigo	,
				@clnombre	,
      				@clgeneric	,
				@cldirecc	,
				@clcomuna	,
				@clregion	,
				@cltipcli	,
				@clfecingr	,
				@clctacte	,
				@clfono 	,
				@clfax		,
				@clapelpa	,
				@clapelma	,
				@clnomb1        ,
				@clnomb2	,
				@clciudad	,
				@clmercado	,
				@clpais	 	,
				@clcalidad 	,
				@clchips	,
				@claba   	,
				@clswift	,
				@clctausd	,
				@climplic	,
                                @clopcion       ,
				@clrelaciongb   ,
				@clcatego       ,
				@clsector       ,
				@clclsbif       ,
				@clactivida     ,
				@cltipemp       ,
				@clrelbco       ,
				@clpoder        ,
				@clfirma        ,
				@clinfosoc      ,
				@clart85        ,
				@cldec85        ,
				@rut_grupo      ,
				@clcodfox	,
				@clcodinst      ,
				@clcodban       ,
				@clvalidalinea 	,--(CASE WHEN @clrelaciongb = 3 THEN'S' ELSE 'N' END),਍ഀ
				@cloficinas     ,
				@clcriesgo	,
                                @codigo_otc	,
                                @bloqueado	,
				@CodNif
				)

       END
   SET NOCOUNT OFF
   SELECT 'OK'
END



GO
