USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_PAPELES_DISPONIBLES]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_CON_PAPELES_DISPONIBLES]     
			(	@TipoOper  CHAR(10)    
			,	@Cadena_Familia  VARCHAR(500)    
			,	@Cadena_Emisor  VARCHAR(500)    
			,	@Cadena_Moneda  VARCHAR(500)    
			,	@Cod_Libro  CHAR(10)    
			,	@Cod_CarteraSuper CHAR(10)    
			,	@Cod_CarteraFin  CHAR(10)    
			,	@FecModPago		char(10)='' --> VB+- 05/07/2018 se Agrega fecha para control de operacion CN y PM
			)    
AS    
BEGIN    
    
		SET NOCOUNT ON    
    
        DECLARE @dFechaPro   DATETIME    
    
		SELECT @dFechaPro   = acfecproc    
		  FROM MDAC    
    
		SET  @dFechaPro   = ( SELECT  acfecproc   FROM    MDAC)  ;    
		IF @fecModPago ='' SET @fecModPago = CONVERT(CHAR(10),@dFechaPro,103)        
    
		IF LTRIM(RTRIM(@TIPOOPER)) = 'VP' 
		BEGIN    
		  SELECT DISTINCT A.diinstser    
					, B.cpcodigo    
			FROM	MDDI A    
			,		MDCP B    
		   WHERE A.dinominal   > 0     
			 AND A.Estado_Operacion_Linea = ''    
		     AND A.id_libro   = @Cod_Libro    
		     AND A.codigo_carterasuper  = @Cod_CarteraSuper    
		     AND A.ditipcart   = @Cod_CarteraFin    
		     AND cprutcart    = dirutcart    
		     AND cpnumdocu    = dinumdocu    
		     AND cpcorrela   = dicorrela    
		     AND CHARINDEX(RTRIM(LTRIM(A.diserie))  ,@Cadena_Familia) > 0      
		     AND (CHARINDEX(RTRIM(LTRIM(A.digenemi)) ,@Cadena_Emisor ) > 0 OR @Cadena_Emisor = '' )    
		     AND (CHARINDEX(RTRIM(LTRIM(A.dinemmon)) ,@Cadena_Moneda ) > 0 OR @Cadena_Moneda = '' )    
		     --AND     A.Fecha_PagoMañana   <= @dFechaPro       
		       AND A.Fecha_PagoMañana <= CONVERT(DATETIME,@fecModPago ,103)  -- VB
		END    
		ELSE 
		IF LTRIM(RTRIM(@TIPOOPER)) = 'VI' 
		BEGIN    
			SELECT DISTINCT A.diinstser AS 'PAPEL'    
			, B.cpcodigo  AS 'CODIGO'      
			FROM MDDI A    
			, MDCP B    
			WHERE A.dinominal   > 0     
			AND A.Estado_Operacion_Linea = ''    
			AND (A.digenemi   <> 'BCO' OR A.diserie <> 'LCHR')    
			AND CHARINDEX(RTRIM(LTRIM(A.diserie))  ,@Cadena_Familia) > 0      
			AND (CHARINDEX(RTRIM(LTRIM(A.digenemi)) ,@Cadena_Emisor ) > 0 OR @Cadena_Emisor = '' )    
			AND (CHARINDEX(RTRIM(LTRIM(A.dinemmon)) ,@Cadena_Moneda ) > 0 OR @Cadena_Moneda = '' )    
			AND A.id_libro   = @Cod_Libro    
			AND A.codigo_carterasuper  = @Cod_CarteraSuper    
			AND A.ditipcart   = @Cod_CarteraFin    
			AND cprutcart    = A.dirutcart    
			AND cpnumdocu    = A.dinumdocu    
			AND cpcorrela   = A.dicorrela    
			UNION    
			SELECT A.diinstser    
			, B.cicodigo    
			FROM MDDI A    
			, MDCI B    
			WHERE charindex(rtrim(ltrim(a.diserie)),@Cadena_Familia) > 0    
			AND A.dinominal   > 0     
			AND A.Estado_Operacion_Linea = ''     
			AND (A.digenemi   <> 'BCO' OR A.diserie <> 'LCHR')    
			AND CHARINDEX(RTRIM(LTRIM(A.diserie))  ,@Cadena_Familia) > 0      
			AND (CHARINDEX(RTRIM(LTRIM(A.digenemi)) ,@Cadena_Emisor ) > 0 OR @Cadena_Emisor = '' )    
			AND (CHARINDEX(RTRIM(LTRIM(A.dinemmon)) ,@Cadena_Moneda ) > 0 OR @Cadena_Moneda = '' )    
			AND A.id_libro   = @Cod_Libro    
			AND A.codigo_carterasuper  = @Cod_CarteraSuper    
			AND A.ditipcart   = @Cod_CarteraFin    
			AND B.cirutcart    = A.dirutcart    
			AND B.cinumdocu    = A.dinumdocu    
			AND B.cicorrela   = A.dicorrela    
		END    
		SET NOCOUNT OFF    
	
END    

GO
