USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CAP_XIII_ANEXO2]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_CAP_XIII_ANEXO2]
( @Mes NUMERIC(2), @Ano NUMERIC(4) )
AS
BEGIN


CREATE TABLE #TEMP_COMPENDIO(	FEC_INVERSION	DATETIME	NOT NULL DEFAULT ' ' ,
				SECTOR_ECONOM	CHAR(10)	NOT NULL DEFAULT ' ' ,
				TIPO_ADQUIRIDO	CHAR(50)	NOT NULL DEFAULT ' ' ,
				PAIS_INVER	CHAR(30)	NOT NULL DEFAULT ' ' ,
				MONEDA		CHAR(5)		NOT NULL DEFAULT ' ' ,
				MONTO_INVER	NUMERIC(19,4)	NOT NULL DEFAULT 0   ,
				FECHA_RESC	DATETIME	NOT NULL DEFAULT ' ' ,
				CAPITAL		NUMERIC(19,4)	NOT NULL DEFAULT 0   ,
				RESULTADO	NUMERIC(19,4)	NOT NULL DEFAULT 0   ,
				COD_PAIS	NUMERIC(5)	NOT NULL DEFAULT 0   )

SET NOCOUNT ON

/* COMPRAS --------------------------------------------------------------- */
INSERT	INTO #TEMP_COMPENDIO
SELECT 	A.MOFECPRO,
	C.CLACTIVIDA, -- VGS 11/2004 C.CLSECTOR,
	B.DESCRIP_FAMILIA,
	CONVERT(CHAR(30),C.CLCODBAN), -- VGS 11/2004   '',
	CASE	WHEN a.momonemi IN ( 129 , 5 ) THEN 13 ELSE A.MOMONEMI END , --  VGS 11/2004  (SELECT MNSIMBOL FROM VIEW_MONEDA WHERE MNCODMON = A.MOMONEMI),
	CASE	WHEN a.momonemi IN ( 129 , 5 ) THEN (ISNULL(A.MOVALCOMU,0) * (	SELECT	ISNULL( Tipo_cambio, 0 ) 
																			FROM	BacParamSuda..Valor_moneda_contable 
																			WHERE	fecha				= A.MOFECPRO 
																					AND codigo_moneda	= A.MOMONEMI ) ) /  

																		  (	SELECT	ISNULL( Tipo_cambio, 0 ) 
																			FROM	BacParamSuda..Valor_moneda_contable 
																			WHERE	fecha				= A.MOFECPRO 
																					AND codigo_moneda	= 994 )
			ELSE ISNULL(A.MOVALCOMU,0) 
	END ,
	'',
	0.0,
	0.0,
	C.CLPAIS
   FROM TEXT_MVT_DRI A, 
        TEXT_FML_INM B,
        VIEW_CLIENTE C
  WHERE	B.COD_FAMILIA = A.COD_FAMILIA
    AND MONTH(A.MOFECPRO) = @Mes
    AND YEAR(A.MOFECPRO)  = @Ano
    AND A.MOTIPOPER       = 'CP'
    AND A.MOSTATREG      <> 'A'
    AND A.MOFECPRO        = A.MOFECPAGO
    AND A.MORUTCLI        = C.CLRUT
    AND A.MOCODCLI        = C.CLCODIGO
    AND C.CLPAIS         <> 6


/* VENTAS ---------------------------------------------------------------- */

INSERT	INTO #TEMP_COMPENDIO
SELECT 	--(SELECT D.MOFECPRO FROM TEXT_MVT_DRI D WHERE D.MONUMDOCU = A.MONUMDOCU AND D.MOTIPOPER = 'CP' AND D.MOFECPRO = A.MOFECPAGO),  VGS 01/2005
	(SELECT MAX(D.MOFECPRO) FROM TEXT_MVT_DRI D WHERE D.MONUMDOCU = A.MONUMDOCU AND D.MOTIPOPER = 'CP'),
	C.CLACTIVIDA, -- C.CLSECTOR,
	B.DESCRIP_FAMILIA,
	CONVERT(CHAR(30),C.CLCODBAN), -- '',
	CASE	WHEN a.momonemi IN ( 129 , 5 ) THEN 13 ELSE A.MOMONEMI END, --  VGS 11/2004  (SELECT E.MNSIMBOL FROM VIEW_MONEDA E WHERE E.MNCODMON = A.MOMONEMI),
--	ISNULL((SELECT D.MOVALCOMU FROM TEXT_MVT_DRI D WHERE D.MONUMDOCU = A.MONUMDOCU AND D.MOTIPOPER = 'CP' AND D.MOFECPRO = D.MOFECPAGO),0),

	CASE	WHEN a.momonemi IN ( 129 , 5 ) THEN (ISNULL((	SELECT	D.MOVALCOMU 
															FROM	TEXT_MVT_DRI D 
															WHERE	D.MONUMDOCU = A.MONUMDOCU 
																	AND D.MOTIPOPER = 'CP' 
																	AND D.MOFECPRO = D.MOFECPAGO),0) * 
														(	SELECT	ISNULL( Tipo_cambio, 0 ) 
															FROM	BacParamSuda..Valor_moneda_contable 
															WHERE	fecha				= A.MOFECPRO 
																	AND codigo_moneda	= A.MOMONEMI ) ) /  

														(	SELECT	ISNULL( Tipo_cambio, 0 ) 
															FROM	BacParamSuda..Valor_moneda_contable 
															WHERE	fecha				= A.MOFECPRO 
																	AND codigo_moneda	= 994 )
			ELSE ISNULL((SELECT D.MOVALCOMU FROM TEXT_MVT_DRI D WHERE D.MONUMDOCU = A.MONUMDOCU AND D.MOTIPOPER = 'CP' AND D.MOFECPRO = D.MOFECPAGO),0)
	END ,

	A.MOFECPRO,
	ISNULL(A.MOVPRESEN,0),
	ISNULL(A.MOUTILIDAD,0),
	C.CLPAIS
   FROM TEXT_MVT_DRI A, 
        TEXT_FML_INM B,
        VIEW_CLIENTE C
  WHERE	B.COD_FAMILIA = A.COD_FAMILIA
    AND MONTH(A.MOFECPRO) = @Mes
    AND YEAR(A.MOFECPRO)  = @Ano
    AND A.MOTIPOPER       = 'VP'
    AND A.MOSTATREG      <> 'A'
    AND A.MOFECPRO        = A.MOFECPAGO
    AND A.MORUTCLI        = C.CLRUT
    AND A.MOCODCLI        = C.CLCODIGO
    AND C.CLPAIS         <> 6

SELECT FEC_INVERSION,
       SECTOR_ECONOM,
       TIPO_ADQUIRIDO,
       PAIS_INVER,
       MONEDA,
       MONTO_INVER,
       FECHA_RESC,
       CAPITAL,
       RESULTADO,
       COD_PAIS
  FROM #TEMP_COMPENDIO
 ORDER BY FEC_INVERSION
drop table #TEMP_COMPENDIO	
SET NOCOUNT OFF

END
--Sp_Cap_XIII_Anexo2 4,2004
GO
