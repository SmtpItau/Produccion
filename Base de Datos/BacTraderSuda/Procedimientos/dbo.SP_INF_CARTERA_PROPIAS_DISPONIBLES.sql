USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INF_CARTERA_PROPIAS_DISPONIBLES]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_INF_CARTERA_PROPIAS_DISPONIBLES]	(	
  @orden     CHAR (3)
,	@Cat_Libro CHAR(06))
/* *********************************************************************************/
/* PROCEDIMIENTO   : Sp_Inf_Cartera_Propias_Disponibles                            */
/* BASES DE DATOS  : BacTraderSuda                                                 */
/* PARAM. ENTRADA  :                                                               */
/* PARAM. SALIDA   :                                                               */
/* Descripción     :                                                               */
/* AUTOR           :                                                               */
/* FECHA           :                                                               */
/* *********************************************************************************/
/*                        MODIFICACIONES                                           */
/* *********************************************************************************/
/* Observacion     : Agregar para la etiqueta FMUTUO la tir por dipvpcomp          */
/* AUTOR           : Guillermo Reveco (SONDA SISTEMAS FINANCIEROS)                 */
/* FECHA           : 11/06/2008                                                    */
/* *********************************************************************************/
AS
  BEGIN

 SET NOCOUNT ON

 Declare @FechaProc AS DATETIME
 Declare @pfecha AS CHAR(10)
 DECLARE @Hora AS CHAR(10)
 DECLARE @FUltimaVal AS DATETIME
 declare @acnombre char(20)
 SELECT @FechaProc = acfecproc , @acnombre = acnomprop  FROM MDAC
 
 SELECT @pFecha = CONVERT (CHAR(10),@FechaProc,103)
 SELECT @Hora = CONVERT (CHAR(10),GETDATE(),108)
 -- Cartera de Inversiones 

	SELECT	'numdocu'	= dinumdocu	,
		'correla'	= dicorrela	,
		'serie'		= diinstser	,
--		'tircompra'	= ditircomp,  
		'tircompra'	= CASE WHEN diserie='FMUTUO' THEN dipvpcomp
		              ELSE ditircomp
		              END,
		'CompraInicial'	= dinominal,
		'PosicionCierre'= dinominal,
		'ValorPosicion'	= divptirc,
		'ValorCierre'	= divptirc,
		'plazo'		= DATEDIFF(DAY,@FechaProc, difecsal) ,
		'fecven'	= difecsal,
		'nombre'	= CONVERT(CHAR(70),''),
		'taspact'	= CONVERT(FLOAT,0),
		'tipoper'	= ditipoper,
		'nSerie'	= Diserie,
                'cartera'	= codigo_carterasuper,
		'TasaValoriza'	= CONVERT(FLOAT,0), 
		'Orden'		= @orden,
		'Custodia'	= CONVERT( VARCHAR(15), '' )
	,	'Libro'		= Id_Libro
	,	'Glosa_Libro'	= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @Cat_Libro AND tbcodigo1 = MDDI.id_libro),'') 
	INTO	#PASO  
	FROM	MDDI

 -- Rescate Ultima Fecha de Valorizacion
        SET ROWCOUNT 1

        SELECT	@FUltimaVal	= fecha_valorizacion 
	FROM	VALORIZACION_MERCADO 
	ORDER
	BY	fecha_valorizacion  DESC

        SET ROWCOUNT 0

 UPDATE #PASO
 SET TasaValoriza = tasa_mercado
 FROM valorizacion_mercado
 WHERE fecha_valorizacion = @FUltimaVal
 AND rminstser = serie  

 -- cartera de Compras com pactos
 UPDATE #PASO
 SET	nombre = clnombre,
	taspact = citaspact
 FROM	mdci,
	view_cliente
 WHERE	cinumdocu = numdocu 
 AND	cicorrela= correla
 AND	cirutcli = clrut
 AND	cicodcli = clcodigo 
 AND	tipoper = 'CI'

 SELECT	vinumdocu,
	vicorrela,
	vinominal = SUM(vinominal),
	vivptirv  = SUM(vivptirv)
 INTO	#temp_vi
 FROM	MDVI
 GROUP 
 BY	vinumdocu
 ,	vicorrela

 UPDATE	#PASO
 SET	CompraInicial = CompraInicial + vinominal
 ,	ValorPosicion = ValorPosicion + vivptirv
 FROM	#temp_vi
 WHERE	vinumdocu = numdocu 
        AND  vicorrela = correla

 UPDATE #PASO
 SET Custodia = CASE cpdcv WHEN 'P' THEN 'PROPIA'
                                      WHEN 'C' THEN 'CLIENTE'
                                      WHEN 'D' THEN 'DCV'
                                               ELSE ' '
                           END
 FROM mdcp
 WHERE cpnumdocu = numdocu 
        AND  cpcorrela = correla
 UPDATE #PASO
 SET Custodia = CASE cidcv WHEN 'P' THEN 'PROPIA'
                                      WHEN 'C' THEN 'CLIENTE'
                                      WHEN 'D' THEN 'DCV'
                                               ELSE ' '
                           END
 FROM mdci
 WHERE cinumdocu = numdocu 
        AND  cicorrela = correla

 SELECT	'Serie'		= serie  ,
	'tir'		= SUM(tircompra*ValorPosicion) / SUM(ValorPosicion),
	'CompraInicial'	= SUM(CompraInicial) ,
	'PosicionCierre'= SUM(PosicionCierre) ,
	'ValorPosicion' = SUM(ValorPosicion) ,
	'ValorCierre'	= SUM(ValorCierre) ,
	plazo     ,
	fecven     ,
	nombre     ,
	taspact     ,
	tipoper     ,
	'Glosa'		= CASE	WHEN tipoper = 'CP' THEN 'CARTERA DE INVERSIONES'
				ELSE 'CARTERA DE COMPRAS CON PACTOS' END,
	'FechaReport'	= @pfecha   ,
	'HoraReport'	= @Hora   ,
	nserie     ,
	cartera     ,
	TasaValoriza    ,  
	'orden'		= @orden   ,
	Custodia    ,
	'banco'		= @acnombre
 ,	'Libro'		= ISNULL(Libro,'')
 ,	'Glosa_Libro'	= Case WHEN Glosa_Libro = '' THEN 'No Especificado' 
				ELSE Glosa_Libro END

 FROM	#paso
 WHERE	ValorPosicion > 0
 GROUP 
 BY     Glosa_Libro	,
	Libro		,
	serie		,
	plazo		,
	fecven		,
	nombre		,
	taspact		,
	tipoper		,
	nserie		,
	cartera		,
	TasaValoriza	,
	Custodia
 ORDER 
 BY	Libro,
	case @orden	when 'res' then convert(char (10),plazo) 
			else serie end 
	 
 SET NOCOUNT OFF
END


GO
