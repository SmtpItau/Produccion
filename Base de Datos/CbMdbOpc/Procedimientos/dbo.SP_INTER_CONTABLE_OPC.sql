USE [CbMdbOpc]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTER_CONTABLE_OPC]    Script Date: 16-05-2022 10:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_INTER_CONTABLE_OPC]

AS
BEGIN 

   SET NOCOUNT ON

   DECLARE @iContador   NUMERIC(9)

   SELECT  @iContador       = 0.0
   SELECT  @iContador       = COUNT(1)
   FROM    OpcVOUCHER                   v WITH (NoLock)
           LEFT JOIN OpcDETALLEVOUCHER d ON v.numero_voucher = d.numero_voucher
   ,       OpcionesGeneral
   WHERE   v.fecha_ingreso  = fechaproc
--   AND   ((@iMoneda = 0 AND d.moneda <> 999) 
--      OR  (@iMoneda = 1 AND d.moneda = 999))

   SELECT /*01*/ 'NI05TR'    = '1'
   ,      /*02*/ 'NI05OF'    = '00001'
   ,      /*03*/ 'NI05AR'    = '1'
   ,      /*04*/ 'NI05SEC'   = '00874'
   ,      /*05*/ 'NI05DIA'   = CONVERT(CHAR(2),REPLICATE('0', 2 - LEN(DAY(fechaproc)))   + LTRIM(RTRIM(DAY(fechaproc))))
   ,      /*06*/ 'NI05MES'   = CONVERT(CHAR(2),REPLICATE('0', 2 - LEN(MONTH(fechaproc))) + LTRIM(RTRIM(MONTH(fechaproc))))
   ,      /*07*/ 'NI05AÑO'   = CONVERT(CHAR(2),SUBSTRING(REPLICATE('0', 4 - LEN(YEAR(fechaproc)))  + LTRIM(RTRIM(YEAR(fechaproc))),3,2))
   ,      /*08*/ 'NI05NDO'   = CONVERT(CHAR(6),LTRIM(RTRIM(REPLICATE('0' , 6 - len(SUBSTRING(LTRIM(RTRIM(v.numero_voucher)),1,6))) + SUBSTRING(LTRIM(RTRIM(v.numero_voucher)),1,6))))
   ,      /*09*/ 'NI05DCOP'  = CASE WHEN d.Tipo_Monto = 'D' THEN CONVERT(CHAR(16),LTRIM(RTRIM(ISNULL(d.cuenta,'0'))) + REPLICATE('0', 16 - LEN(ISNULL(d.cuenta,'0'))))
                                    ELSE                         CONVERT(CHAR(16),                                     REPLICATE('0', 16))
                               END
   ,      /*10*/ 'NI05DDIV'  = CASE WHEN d.Tipo_Monto = 'D' AND d.moneda NOT IN(994,998,997,999) THEN CONVERT(CHAR(2),REPLICATE('0',2 - LEN(ISNULL(m.mncodfox,'00'))) + LTRIM(RTRIM(ISNULL(m.mncodfox,'00'))))
                                    ELSE                                                              CONVERT(CHAR(2),REPLICATE('0',2))
                               END
   ,      /*11*/ 'NI05DDBE'  = '5'
   ,      /*12*/ 'NI05DMTO'  = convert( varchar(15) , CASE WHEN d.Tipo_Monto = 'D' THEN CONVERT(CHAR(17),REPLICATE('0', 16 - LEN(LTRIM(RTRIM(CONVERT(NUMERIC(15,2),ISNULL(d.monto,0.0)))))) + REPLACE( LTRIM(RTRIM(CONVERT(NUMERIC(15,2),ISNULL(d.monto,0.0))))
,'.','') )
                                    ELSE                         CONVERT(CHAR(17),REPLICATE('0',13) + '00')
                               END )
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
   ,      /*19*/ 'NI05HMTO'  = convert( varchar(15) , CASE WHEN d.Tipo_Monto = 'H' THEN CONVERT(CHAR(17),REPLICATE('0', 16 - LEN(LTRIM(RTRIM(CONVERT(NUMERIC(15,2),ISNULL(d.monto,0.0)))))) + REPLACE( LTRIM(RTRIM(CONVERT(NUMERIC(15,2),ISNULL(d.monto,0.0))))
,'.','') )
                                    ELSE                         CONVERT(CHAR(17),REPLICATE('0',13) + '00')
                               END )
   ,      /*20*/ 'NI05HCLA'  = REPLICATE('0', 4)
   ,      /*21*/ 'NI05HNOM'  = REPLICATE('0', 8)
   ,      /*22*/ 'NI05HREF'  = CASE WHEN d.Tipo_Monto = 'H' THEN CONVERT(CHAR(10),REPLICATE('0', 10 - LEN(LTRIM(v.numero_voucher))) + LTRIM(v.numero_voucher))
                                    ELSE                         CONVERT(CHAR(10),REPLICATE('0', 10))
                               END
   ,      /*23*/ 'NI05OEMI'  = REPLICATE('0',5)
   ,      /*24*/ 'NI05OREC'  = REPLICATE('0',5)
   ,      /*25*/ 'NI05OFILL' = REPLICATE('0',126)
   ,      /*26*/ 'NI05TICP'  = '00000000000'
--   ,      /*27*/ 'CANTREG'   = @iContador
   FROM   OpcVoucher                   v WITH (NoLock)
          INNER JOIN OpcDetalleVOUCHER d ON v.numero_voucher = d.numero_voucher
          LEFT  JOIN LnkBac.BacParamSuda.dbo.PLAN_DE_CUENTA	 c ON c.cuenta         = d.cuenta
          LEFT  JOIN LnkBac.BacParamSuda.dbo.MONEDA                 m ON m.mncodmon       = convert(integer,d.moneda)
   ,      OpcionesGENERAL
   WHERE  v.fecha_ingreso    = fechaproc

--   AND   ((@iMoneda = 0 AND d.moneda <> 999) OR (@iMoneda = 1 AND d.moneda = 999))
   ORDER BY d.numero_voucher , d.correlativo

END

--select * from sysobjects where name like'%voucher%' and type = 'u'
GO
