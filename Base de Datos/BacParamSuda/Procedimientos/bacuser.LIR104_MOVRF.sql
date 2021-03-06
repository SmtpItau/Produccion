USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [bacuser].[LIR104_MOVRF]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [bacuser].[LIR104_MOVRF](	@FECHA1	DATETIME,	@FECHA2	DATETIME )
AS 
BEGIN	

		DECLARE @Movimientos TABLE 
		(
			[Fecha Operación]			 datetime			--	1
		,	[Código Operación]			 char(20)			--	2
		,	[Glosa Código Operación]	 varchar(50)		--	3
		,	[NemoTécnico]				 Varchar(50)		--	4
		,	[Tipo]						 char(5)			--	5
		,	[Fecha Emisión]				 datetime			--	6
		,	[Serie]						 varchar(50)		--	7
		
		,	[Folio Operación]			 numeric(9)			--	8
		,	[Valor Operación MO]		 numeric(19,4)		--	9
		,	[Valor Operación$]			 numeric(19,4)		--	10
		,	[Capital MO] 				 numeric(19,4)		--	11
		,	[Interesesmo]				 numeric(19,4)		--	12
		
		,	[Fecha Compra]				 datetime			--	13
		
		,	[Folio Compra]				 numeric(9)			--	14
		,	[Valor Compra MO]			 numeric(19,4)		--	15
		,	[Valor Compra $]			 numeric(19,4)		--	16
		,	[Interés $]					 numeric(19,4)		--	17
		,	[Reajuste]					 numeric(19,4)		--	18
		
		,	ctacontableinversión		 varchar(20)		--	19
		,	ctacontableinteres			 varchar(20)		--	20
		,	ctacontablereajuste			 varchar(20)		--	21
		,	ctacontableresultado		 varchar(20)		--	22
		,	cantidaddías				 int				--	23
		)											
		
		
		--INSERT INTO @Movimientos
		SELECT  
		--		MOFECPRO				--AS [FECHA OPERACIÓN]
		--,		MOTIPOPER				--AS [CÓDIGO OPERACIÓN]
		--,		P.DESCRIPCION			--AS [GLOSA CÓDIGO OPERACIÓN]
		--,		INS.INGLOSA				--AS [NEMOTÉCNICO]
		--,		MOTIPOPERO				--AS [TIPO]
		--,		MOFECEMI				--AS [FECHA EMISIÓN]
		--,		MOMASCARA				--AS [SERIE]
		--,		MONUMOPER				--AS [FOLIO OPERACIÓN]

		--,		MONOMINAL				--AS [VALOR OPERACIÓN MO]
		--,		MOVPRESEN				--AS [VALOR OPERACIÓN$]			
		--,		MOCAPITALI				--AS [CAPITAL MO] 
		--,		RSINTERES				--AS [INTERESESMO]
		
		--,		MOFECPRO				--AS [FECHA COMPRA]
		--,		MONUMDOCU				--AS [FOLIO COMPRA]
		--,		RSVALCOMP				--AS [VALORCOMPRAMO]
		--,		RSVALCOMP				--AS [VALORCOMPRA$]
		----,		RSINTERES				--AS INTERESESMO 
		--,		RSINTERES				--AS [INTERÉS$]
		--,		RSREAJUSTE				--AS REAJUSTE
		--,		''--c1.CTACONTABLE			--AS CTACONTABLEINVERSIÓN
		--,		''--c2.CTACONTABLE			--AS CTACONTABLEINTERES
		--,		''--c3.CTACONTABLE			--AS CTACONTABLEREAJUSTE
		--,		''						--AS CTACONTABLERESULTADO
		--,		0						--AS CANTIDADDÍAS
		* into #mov
FROM  

			BACTRADERSUDA.DBO.MDMO  MX
INNER JOIN	BACTRADERSUDA.DBO.MDRS  RS			ON RS.RSNUMOPER=MX.MONUMOPER AND RS.RSCORRELA=MX.MOCORRELA
INNER JOIN	BACPARAMSUDA.DBO.MONEDA MO			ON MO.MNCODMON = MOMONEMI 
INNER JOIN	BACPARAMSUDA.DBO.INSTRUMENTO INS	ON INS.INCODIGO = MOCODIGO 
INNER JOIN  BACPARAMSUDA.DBO.PRODUCTO P			ON P.CODIGO_PRODUCTO=MOTIPOPER AND P.ID_SISTEMA='BTR'
--left  JOIN	bactradersuda..CARTERA_CUENTA	C1	ON C1.numoper=MX.MONUMDOCU AND c1.variable like '%interes%'
--left  JOIN	bactradersuda..CARTERA_CUENTA	C2	ON C2.numoper=MX.MONUMDOCU AND c2.variable like '%reajuste%'
--left  JOIN	bactradersuda..CARTERA_CUENTA	C3	ON C3.numoper=MX.MONUMDOCU AND c3.variable like '%valor_compra%'
WHERE 
			RS.RSFECHA BETWEEN @FECHA1  AND @FECHA2    

/*


Reajuste_papel
valor_compra
valor_tasa_emision
dif_valor_mercado_pos
valor_venta
Interes_papel
dif_valor_mercado_neg

*/


--UPDATE @Movimientos 
--SET [CTACONTABLEINTERES]= (SELECT CTACONTABLE from bactradersuda..CARTERA_CUENTA where variable like '%interes%' and [Folio Operación]	= numoper)

--SELECT * from bactradersuda..CARTERA_CUENTA
SELECT * FROM #mov


END

GO
