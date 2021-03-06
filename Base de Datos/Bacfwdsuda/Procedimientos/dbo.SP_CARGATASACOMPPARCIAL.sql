USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGATASACOMPPARCIAL]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CARGATASACOMPPARCIAL](  @cfecha   DATETIME )
AS
BEGIN
SET NOCOUNT ON

      DECLARE @FechaAnt as datetime

      SELECT @FechaAnt = acfecante FROM mfac
	-- select * from mfac
	SELECT 	'NumOpe'  = a.canumoper 			,
           	'Cliente' = ISNULL(b.clnombre, '' ) 		,
           	'TipOper' = a.catipoper 			,          
           	'FecIni'  = CONVERT(CHAR(10) , a.cafecha ,103)  ,
           	'FecVen'  = CONVERT(CHAR(10) , a.cafecvcto,103) ,
           	'MtoMex'  = a.camtomon1 			,
           	'MtoCnv'  = a.camtomon2 			,
           	'Liquid'  = ABS(c.corsaldo)			,
           	'Tasa'    = c.cortastab				,
		'Numero'  = c.corcorrela
   	--RQ 7619
       FROM     mfca a	LEFT OUTER JOIN view_cliente  b ON  a.cacodigo  = b.clrut,
	    	cortes		c       
	--WHERE   a.cacodigo  *= b.clrut     AND 
       WHERE    a.cacodpos1  = 7              AND
		( a.canumoper  	= c.cornumoper	AND	
		--CONVERT(CHAR(08), c.corfecvcto,112) = CONVERT(CHAR(08),@cfecha,112) )
               c.corfecvcto > @FechaAnt  AND
                CONVERT(CHAR(08), c.corfecvcto,112) <= CONVERT(CHAR(08),@cfecha,112) )
               and corestado = 0


	SET NOCOUNT OFF

END


/*
select corestado , corfecvcto, *
FROM    mfca 		a	,
           	    	cortes		c       
	WHERE   a.cacodpos1  = 7           AND
		 a.canumoper  	= c.cornumoper	AND	
		--CONVERT(CHAR(08), c.corfecvcto,112) = CONVERT(CHAR(08),@cfecha,112) )
                 c.corfecvcto <= '20031117' 
               and c.corfecvcto> '20031114' 
                 and corestado = 0

*/

-- dbo.Sp_CargaTasaCompParcial '20010430'
-- select * from cortes WHERE corfecvcto = '20031115'
-- select * from mfca

GO
