USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTER_CONTABLE_TRADER_REPROCESO]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[SP_INTER_CONTABLE_TRADER_REPROCESO]
	(	@dFechaProceso	datetime	
	,	@cCuenta		varchar(20)	= ''
	)
AS
BEGIN 

   SET NOCOUNT ON

   DECLARE @iContador   NUMERIC(9)

   SELECT  @iContador       = 0.0
   SELECT  @iContador       = COUNT(1)
   FROM	   BacTraderSuda..BAC_CNT_VOUCHER                   v WITH (NoLock)
           INNER JOIN BacTraderSuda..BAC_CNT_DETALLE_VOUCHER d ON v.numero_voucher = d.numero_voucher
   WHERE   v.fecha_ingreso  = @dFechaProceso
	and	  (d.cuenta			= @cCuenta or @cCuenta = '')
/*
   SELECT /*01*/ 'NI05TR'    = '1'
   ,      /*02*/ 'NI05OF'    = '00001'
   ,      /*03*/ 'NI05AR'    = '1'
   ,      /*04*/ 'NI05SEC'   = '00874'
   ,      /*05*/ 'NI05DIA'   = CONVERT(CHAR(2),REPLICATE('0', 2 - LEN(DAY(@dFechaProceso)))   + LTRIM(RTRIM(DAY(@dFechaProceso))))
   ,      /*06*/ 'NI05MES'   = CONVERT(CHAR(2),REPLICATE('0', 2 - LEN(MONTH(@dFechaProceso))) + LTRIM(RTRIM(MONTH(@dFechaProceso))))
   ,      /*07*/ 'NI05AÑO'   = CONVERT(CHAR(2),SUBSTRING(REPLICATE('0', 4 - LEN(YEAR(@dFechaProceso)))  + LTRIM(RTRIM(YEAR(@dFechaProceso))),3,2))
   ,      /*08*/ 'NI05NDO'   = '000000' -- V.Numero_Voucher -- MAP SUBSTRING(LTRIM(RTRIM(v.numero_voucher)),1,6) Contingencia 22 Junio 2006
   ,      /*09*/ 'NI05DCOP'  = CASE WHEN d.Tipo_Monto = 'D' THEN CONVERT(CHAR(16),LTRIM(RTRIM(ISNULL(d.cuenta,'0'))) + REPLICATE('0', 16 - LEN(ISNULL(d.cuenta,'0'))))
                                    ELSE                         CONVERT(CHAR(16),                                     REPLICATE('0', 16))
                               END
   ,      /*10*/ 'NI05DDIV'  = CASE WHEN d.Tipo_Monto = 'D' AND d.moneda NOT IN(994,998,997,999) THEN CONVERT(CHAR(2),REPLICATE('0',2 - LEN(ISNULL(m.mncodfox,'00'))) + LTRIM(RTRIM(ISNULL(m.mncodfox,'00'))))
                                    ELSE                                                              CONVERT(CHAR(2),REPLICATE('0',2))
                               END
   ,      /*11*/ 'NI05DDBE'  = '5'
   ,      /*12*/ 'NI05DMTO'  = CASE WHEN d.Tipo_Monto = 'D' THEN CONVERT(CHAR(17),REPLICATE('0', 16 - LEN(LTRIM(RTRIM(CONVERT(NUMERIC(15,2),ISNULL(d.monto,0.0)))))) + REPLACE( LTRIM(RTRIM(CONVERT(NUMERIC(15,2),ISNULL(d.monto,0.0)))),'.','') )
                                    ELSE                         CONVERT(CHAR(17),REPLICATE('0',13) + '00')
                               END
   ,      /*13*/ 'NI05DCLA'  = REPLICATE('0', 4)
   ,      /*14*/ 'NI05DNOM'  = REPLICATE('0', 8)
   ,      /*15*/ 'NI05DREF'  = CASE WHEN d.Tipo_Monto = 'D' THEN CONVERT(CHAR(10),REPLICATE('0', 10 - LEN(LTRIM(v.numero_voucher))) + LTRIM(v.numero_voucher))
                                    ELSE                         CONVERT(CHAR(10),REPLICATE('0', 10))
                               END
   ,      /*16*/ 'NI05HCOP'  = CASE WHEN d.Tipo_Monto = 'H' THEN CONVERT(CHAR(16),LTRIM(RTRIM(ISNULL(d.cuenta,'0'))) + REPLICATE('0', 16 - LEN(ISNULL(d.cuenta,'0'))))
                                    ELSE                         CONVERT(CHAR(16),                                     REPLICATE('0', 16))
                               END
   ,      /*17*/ 'NI05HDIV'  = CASE WHEN d.Tipo_Monto = 'H' AND d.moneda NOT IN(994,998,997,999) THEN CONVERT(CHAR(2),REPLICATE('0',2 - LEN(ISNULL(m.mncodfox,'00'))) + LTRIM(RTRIM(ISNULL(m.mncodfox,'00'))))
                                    ELSE                                                              CONVERT(CHAR(2),REPLICATE('0',2))
                               END
   ,      /*18*/ 'NI05HDBE'  = '6'
   ,      /*19*/ 'NI05HMTO'  = CASE WHEN d.Tipo_Monto = 'H' THEN CONVERT(CHAR(17),REPLICATE('0', 16 - LEN(LTRIM(RTRIM(CONVERT(NUMERIC(15,2),ISNULL(d.monto,0.0)))))) + REPLACE( LTRIM(RTRIM(CONVERT(NUMERIC(15,2),ISNULL(d.monto,0.0)))),'.','') )
                                    ELSE                         CONVERT(CHAR(17),REPLICATE('0',13) + '00')
                               END
   ,      /*20*/ 'NI05HCLA'  = REPLICATE('0', 4)
   ,      /*21*/ 'NI05HNOM'  = REPLICATE('0', 8)
   ,      /*22*/ 'NI05HREF'  = CASE WHEN d.Tipo_Monto = 'H' THEN CONVERT(CHAR(10),REPLICATE('0', 10 - LEN(LTRIM(v.numero_voucher))) + LTRIM(v.numero_voucher))
                                    ELSE                         CONVERT(CHAR(10),REPLICATE('0', 10))
                               END
   ,      /*23*/ 'NI05OEMI'  = REPLICATE('0',5)
   ,      /*24*/ 'NI05OREC'  = REPLICATE('0',5)
   ,      /*25*/ 'NI05OFILL' = REPLICATE('0',126)
   ,      /*26*/ 'NI05TICP'  = '00000000000'
   ,      /*27*/ 'CANTREG'   = @iContador
   FROM	  BacTraderSuda..BAC_CNT_VOUCHER                    v WITH (NoLock)
          inner  JOIN BacTraderSuda..BAC_CNT_DETALLE_VOUCHER d ON v.numero_voucher = d.numero_voucher
          LEFT  JOIN BacParamSuda..PLAN_DE_CUENTA			c ON c.cuenta         = d.cuenta
          LEFT  JOIN BacParamSuda..MONEDA                   m ON m.mncodmon       = convert(integer,d.moneda)
   WHERE  v.fecha_ingreso    = @dFechaProceso
   	and	 (d.cuenta			 = @cCuenta or @cCuenta = '')
   ORDER BY d.numero_voucher , d.correlativo
*/

SELECT	CONVERT(NUMERIC(21,0), Interfaz.NI05DCOP )
	,	sum( CONVERT(NUMERIC(21,0), Interfaz.NI05DMTO ) )
	,	sum( CONVERT(NUMERIC(21,0), Interfaz.NI05HMTO ) )
FROM	(	
		   SELECT /*09*/ 'NI05DCOP'  = CASE WHEN d.Tipo_Monto = 'D' THEN CONVERT(CHAR(16),LTRIM(RTRIM(ISNULL(d.cuenta,'0'))) + REPLICATE('0', 16 - LEN(ISNULL(d.cuenta,'0'))))
											ELSE                         CONVERT(CHAR(16),                                     REPLICATE('0', 16))
									   END
		   ,      /*12*/ 'NI05DMTO'  = CASE WHEN d.Tipo_Monto = 'D' THEN CONVERT(CHAR(17),REPLICATE('0', 16 - LEN(LTRIM(RTRIM(CONVERT(NUMERIC(15,2),ISNULL(d.monto,0.0)))))) + REPLACE( LTRIM(RTRIM(CONVERT(NUMERIC(15,2),ISNULL(d.monto,0.0)))),'.','') )
											ELSE                         CONVERT(CHAR(17),REPLICATE('0',13) + '00')
									   END
		   ,      /*19*/ 'NI05HMTO'  = CASE WHEN d.Tipo_Monto = 'H' THEN CONVERT(CHAR(17),REPLICATE('0', 16 - LEN(LTRIM(RTRIM(CONVERT(NUMERIC(15,2),ISNULL(d.monto,0.0)))))) + REPLACE( LTRIM(RTRIM(CONVERT(NUMERIC(15,2),ISNULL(d.monto,0.0)))),'.','') )
											ELSE                         CONVERT(CHAR(17),REPLICATE('0',13) + '00')
									   END
		   FROM	  BacTraderSuda..BAC_CNT_VOUCHER                    v WITH (NoLock)
				  inner  JOIN BacTraderSuda..BAC_CNT_DETALLE_VOUCHER d ON v.numero_voucher = d.numero_voucher
				  LEFT  JOIN BacParamSuda..PLAN_DE_CUENTA			c ON c.cuenta         = d.cuenta
				  LEFT  JOIN BacParamSuda..MONEDA                   m ON m.mncodmon       = convert(integer,d.moneda)
		   WHERE  v.fecha_ingreso    = @dFechaProceso
   			and	 (d.cuenta			 = @cCuenta or @cCuenta = '')
	   )	Interfaz
group by CONVERT(NUMERIC(21,0), Interfaz.NI05DCOP )

   SET NOCOUNT OFF

END
GO
