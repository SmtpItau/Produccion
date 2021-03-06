USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFVOUCHERS]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_INFVOUCHERS]
AS
BEGIN
   SET NOCOUNT ON
SELECT 'acfecproc' = acfecpro,
       'acfecprox' = acfecprx,
       'UF_Hoy'    = CONVERT(FLOAT, 0),
       'UF_Man'    = CONVERT(FLOAT, 0),
       'IVP_Hoy'   = CONVERT(FLOAT, 0),
       'IVP_Man'   = CONVERT(FLOAT, 0),
       'DO_Hoy'    = CONVERT(FLOAT, 0),
       'DO_Man'    = CONVERT(FLOAT, 0),
       'DA_Hoy'    = CONVERT(FLOAT, 0),
       'DA_Man'    = CONVERT(FLOAT, 0),
       'acnomprop' = acnombre,
       'rut_empresa' = RTRIM(CONVERT(CHAR(10),acrut)) + '-' + acdv
  INTO #Parametros
   FROM meac
--SELECT *    FROM meac
-- RESCATA VALOR DE UF -------------------------------------------------------------- 
UPDATE #Parametros SET UF_Hoy  = ISNULL(vmvalor, 0.0) FROM view_valor_moneda WHERE vmfecha = acfecproc AND vmcodigo = 998
UPDATE #Parametros SET UF_Man  = ISNULL(vmvalor, 0.0) FROM view_valor_moneda WHERE vmfecha = acfecprox AND vmcodigo = 998
--RESCATA VALOR DE IVP -------------------------------------------------------------- 
UPDATE #Parametros SET IVP_Hoy = ISNULL(vmvalor, 0.0) FROM view_valor_moneda WHERE vmfecha = acfecproc AND vmcodigo = 997
UPDATE #Parametros SET IVP_Man = ISNULL(vmvalor, 0.0) FROM view_valor_moneda WHERE vmfecha = acfecprox AND vmcodigo = 997
--RESCATA VALOR DE DO  -------------------------------------------------------------- 
UPDATE #Parametros SET DO_Hoy  = ISNULL(vmvalor, 0.0) FROM view_valor_moneda WHERE vmfecha = acfecproc AND vmcodigo = 994
UPDATE #Parametros SET DO_Man  = ISNULL(vmvalor, 0.0) FROM view_valor_moneda WHERE vmfecha = acfecprox AND vmcodigo = 994
--RESCATA VALOR DE DA  -------------------------------------------------------------- 
UPDATE #Parametros SET DA_Hoy  = ISNULL(vmvalor, 0.0) FROM view_valor_moneda WHERE vmfecha = acfecproc AND vmcodigo = 995
UPDATE #Parametros SET DA_Man  = ISNULL(vmvalor, 0.0) FROM view_valor_moneda WHERE vmfecha = acfecprox AND vmcodigo = 995

	/* -->Req.7619 CASS 04-01-2010
	SELECT * FROM bac_cnt_detalle_voucher , bac_cnt_voucher , view_plan_de_cuenta , meac
                  WHERE bac_cnt_detalle_voucher.Numero_Voucher = bac_cnt_voucher.Numero_Voucher 
                    AND view_plan_de_cuenta.Cuenta =* bac_cnt_detalle_voucher.Cuenta
                    AND bac_cnt_voucher.Fecha_Contable = MEAC.acfecpro
	*/

	IF EXISTS( SELECT * FROM bac_cnt_detalle_voucher RIGHT OUTER JOIN view_plan_de_cuenta ON view_plan_de_cuenta.Cuenta = bac_cnt_detalle_voucher.Cuenta
			, bac_cnt_voucher 
			, meac
			WHERE bac_cnt_detalle_voucher.Numero_Voucher = bac_cnt_voucher.Numero_Voucher 
			AND bac_cnt_voucher.Fecha_Contable = MEAC.acfecpro

         ) BEGIN

       -- Vouchers de Operaciones Diarias

       SELECT 'ACFECPROC' = CONVERT(CHAR(10), acfecproc, 103),
              'ACFECPROX' = CONVERT(CHAR(10), acfecprox, 103),
              UF_Hoy,
              UF_Man,
              IVP_Hoy,
              IVP_Man,
              DO_Hoy,
              DO_Man,
              DA_Hoy,
              DA_Man,
              acnomprop,
              rut_empresa,
              'hora' = CONVERT(varchar(10), GETDATE(), 108),
              a.Numero_Voucher   ,
              a.Correlativo      ,
              a.Cuenta,
              a.Tipo_Monto       ,
              a.Monto            ,
              b.glosa  ,
              b.Tipo_Voucher ,
              b.Tipo_Operacion ,
              b.Operacion ,
              'glosi'=SUBSTRING(b.Glosa,1,43)+' '+ CASE  WHEN LEFT(b.Tipo_Operacion,1)='D' THEN  ' ' 
                                                 ELSE ' ' 
                                           END  , -- ( SELECT RTRIM(mnnemo) FROM view_moneda,mfca WHERE cacodmon1=mncodmon AND b.Operacion = canumoper)+'/'+(SELECT mnnemo FROM view_moneda,mfca WHERE cacodmon2=mncodmon AND b.Operacion = canumoper)
              'Rut' = (SELECT acrut    FROM meac)     ,
              'Dv'  = (SELECT acdv     FROM meac)     ,
              'Nom' = (SELECT acnombre FROM meac)     ,
              Descripcion,
              Valor_Campo,
              'Cod_Corresponsal' = RIGHT( '00000000' + CONVERT( VARCHAR(08) , Codigo_Corresponsal ) , 8 ),
              d.morutcli,
              d.monomcli,
              e.cldv,
              d.moticam ,
              'vmorden'  = ISNULL((SELECT vmorden   FROM view_valor_moneda,view_moneda,meac WHERE vmfecha = acfecpro AND vmcodigo = mncodmon AND mnnemo = Valor_Campo),0)
			  --'Logo' = (SELECT Logo FROM BacParamSuda..Contratos_ParametrosGenerales)
         INTO #VOUCHERSDIA
         FROM bac_cnt_detalle_voucher a LEFT OUTER JOIN view_plan_de_cuenta c ON a.Cuenta = c.Cuenta ,
     	      bac_cnt_voucher  b 		,
              #parametros                       ,
              memo                       d      ,
              view_cliente               e
        WHERE a.Numero_Voucher = b.Numero_Voucher AND
	      b.Fecha_Contable = acfecproc        AND
          b.Operacion      = d.monumope       AND
	      b.Operacion      = a.Operacion      AND --NEW
	      a.tipo_operacion = b.tipo_operacion AND --NEW
          (d.morutcli = e.clrut AND d.mocodcli = e.clcodigo)
		 ORDER BY a.Numero_Voucher, 
              a.Correlativo
/*
		REQ.7619 CASS 06-01-2011
          FROM bac_cnt_detalle_voucher a 	,
	      bac_cnt_voucher  b 		,
              view_plan_de_cuenta c 		,
              #parametros                       ,
              memo                       d      ,
              view_cliente               e

        WHERE a.Numero_Voucher = b.Numero_Voucher AND
	      b.Fecha_Contable = acfecproc        AND
          a.Cuenta        *= c.Cuenta         AND 
          b.Operacion      = d.monumope       AND
	      b.Operacion      = a.Operacion      AND --NEW
	      a.tipo_operacion = b.tipo_operacion AND --NEW
          (d.morutcli = e.clrut AND d.mocodcli = e.clcodigo)
		 ORDER BY a.Numero_Voucher, 
              a.Correlativo
*/


--      select * from sp_help bac_cnt_voucher where Numero_Voucher = 29103
--	select * from bac_cnt_detalle_voucher where Numero_Voucher = 29103

        -- Vouchers de Operaciones Historicas
       INSERT INTO #VOUCHERSDIA
       SELECT 'ACFECPROC' = CONVERT(CHAR(10), acfecproc, 103),
              'ACFECPROX' = CONVERT(CHAR(10), acfecprox, 103),
              UF_Hoy,
              UF_Man,
              IVP_Hoy,
              IVP_Man,
              DO_Hoy,
              DO_Man,
              DA_Hoy,
              DA_Man,
              acnomprop,
              rut_empresa,
              'hora' = CONVERT(varchar(10), GETDATE(), 108),
              a.Numero_Voucher   ,
              a.Correlativo      ,
              a.Cuenta,
              a.Tipo_Monto       ,
              a.Monto            ,
              b.glosa  ,
              b.Tipo_Voucher ,
              b.Tipo_Operacion ,
              b.Operacion ,
              SUBSTRING(b.Glosa,1,43)+' '+ CASE  WHEN LEFT(b.Tipo_Operacion,1)='D' THEN  ' ' 
                                                 ELSE ' ' 
                                           END  , -- ( SELECT RTRIM(mnnemo) FROM view_moneda,mfca WHERE cacodmon1=mncodmon AND b.Operacion = canumoper)+'/'+(SELECT mnnemo FROM view_moneda,mfca WHERE cacodmon2=mncodmon AND b.Operacion = canumoper)
              'Rut' = (SELECT acrut    FROM meac)     ,
              'Dv'  = (SELECT acdv     FROM meac)     ,
              'Nom' = (SELECT acnombre FROM meac)     ,
              Descripcion,
              Valor_Campo,
              'Cod_Corresponsal' = RIGHT( '00000000' + CONVERT( VARCHAR(08) , Codigo_Corresponsal ) , 8 ),
              d.morutcli,
              d.monomcli,
              e.cldv,
              d.moticam ,
              'vmorden'   = ISNULL((SELECT vmorden   FROM view_valor_moneda,view_moneda,meac WHERE vmfecha = acfecpro AND vmcodigo = mncodmon AND mnnemo = Valor_Campo),0)
			  --'Logo' = (SELECT Logo FROM BacParamSuda..Contratos_ParametrosGenerales)
        FROM bac_cnt_detalle_voucher a LEFT OUTER JOIN view_plan_de_cuenta c ON a.Cuenta = c.Cuenta ,
     	      bac_cnt_voucher			  b 	,
              #parametros                       ,
              memoh                       d     ,
              view_cliente                e
        WHERE a.Numero_Voucher = b.Numero_Voucher AND
	      b.Fecha_Contable = acfecproc        AND
          b.Operacion      = d.monumope       AND
	      b.Operacion      = a.Operacion      AND --NEW
	      a.tipo_operacion = b.tipo_operacion AND --NEW
          (d.morutcli = e.clrut AND d.mocodcli = e.clcodigo)
		 ORDER BY a.Numero_Voucher, 
              a.Correlativo
/*
		REQ.7619 CASS 06-01-2011
          FROM bac_cnt_detalle_voucher a ,
              bac_cnt_voucher  b ,
              view_plan_de_cuenta c ,
              #parametros                        ,
              memoh                      d       ,
              view_cliente               e

        WHERE a.Numero_Voucher = b.Numero_Voucher AND
              a.Cuenta        *= c.Cuenta         AND 
              b.Fecha_Contable = acfecproc        AND
              b.Operacion      = d.monumope       AND
	      b.Operacion      = a.Operacion      AND --NEW
	      a.tipo_operacion = b.tipo_operacion AND --NEW
             (d.morutcli = e.clrut AND d.mocodcli = e.clcodigo)
     ORDER BY a.Numero_Voucher, 
              a.Correlativo
*/

     SELECT * FROM #VOUCHERSDIA
 END
   ELSE 
 BEGIN
       SELECT 'ACFECPROC' = CONVERT(CHAR(10), acfecproc, 103),
              'ACFECPROX' = CONVERT(CHAR(10), acfecprox, 103),
              UF_Hoy,
               UF_Man,
              IVP_Hoy,
              IVP_Man,
              DO_Hoy,
              DO_Man,
              DA_Hoy,
              DA_Man,
              acnomprop,
              rut_empresa,
              'hora' = CONVERT(varchar(10), GETDATE(), 108),
              'Numero_Voucher'   = 0 ,
              'Correlativo'      = 0 ,
              'Cuenta'           = '' ,
              'Tipo_Monto'       = '' ,
              'Monto'            = 0 ,
              'Tipo_Voucher'     = '' ,
              'Tipo_Operacion'   = '' ,
              'Operacion'        = '' ,
              'glosa_operacion'  = '' ,
              'Rut'              = 0 ,
              'Dv'               = '' ,
              'Nom'              = '' ,
              'Descripcion'      = '' ,
              'Valor_Campo'      = '' ,
              'Cod_Corresponsal' = '' ,
              'morutcli'         = 0  ,
              'monomcli'         = '' ,
              'cldv'             = '' ,
              'moticam'          = 0  ,
              'vmorden'          = 0  ,
			  'Logo' = (SELECT Logo FROM BacParamSuda..Contratos_ParametrosGenerales)

         FROM 
             #parametros
     END
   SET NOCOUNT OFF
END


GO
