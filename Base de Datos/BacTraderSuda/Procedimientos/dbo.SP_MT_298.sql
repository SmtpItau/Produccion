USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MT_298]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_MT_298]( @Sistema VARCHAR(4)  ,
                                @Numero  NUMERIC(10) )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @Rutprop	   NUMERIC(10) 	
   ,       @Moneda	   CHAR(4)
   ,       @nemotecnico	   VARCHAR(800)
   ,       @contador	   INTEGER
   ,       @cantidad	   INTEGER
   ,       @custodia	   VARCHAR(200)
   ,       @LBTR           DATETIME
   ,       @LBTR24         DATETIME
   ,       @LBTR48         DATETIME
   ,       @fc_proceso     DATETIME

   SELECT  @Rutprop       = acrutprop
   ,       @fc_proceso    = acfecproc  
   FROM    MDAC

   EXECUTE SP_BUSCA_FECHA_HABIL @fc_proceso, 0 , @lbtr   OUTPUT
   EXECUTE SP_BUSCA_FECHA_HABIL @fc_proceso, 1 , @lbtr24 OUTPUT
   EXECUTE SP_BUSCA_FECHA_HABIL @lbtr24    , 1 , @lbtr48 OUTPUT

   IF @Sistema = 'BTR'
   BEGIN  
      SELECT @Moneda   = MON.mnnemo
      FROM   MDMO        MOV
      ,      VIEW_MONEDA MON
      WHERE  monumoper = @Numero
      AND    mncodmon  = CASE WHEN motipoper IN('IB','CI','VI') THEN momonpact ELSE momonemi END
   END

   SELECT  @cantidad    = COUNT(1) 
   FROM    MDMO 
   WHERE   monumoper    = @Numero

   SELECT  @contador    = 1
   SELECT  @nemotecnico = ''
   SELECT  @custodia    = ''

   DECLARE @cSerie      CHAR(20)
   ,       @cMoneda     CHAR(3)
   ,       @iCont       INTEGER

   WHILE @contador <= @cantidad
   BEGIN

      SET ROWCOUNT @contador

      SELECT @cSerie   = moinstser
      ,      @cMoneda  = 0 /*ISNULL( CASE WHEN moseriado = 'S' THEN ( SELECT DISTINCT semonemi FROM BacParamSuda..SERIE   WHERE seserie = moinstser )
                              WHEN moseriado = 'S' THEN ( SELECT DISTINCT nsmonemi FROM BacParamSuda..NOSERIE WHERE nsserie = moinstser )
                         END , 0) */
      FROM   MDMO
      WHERE  monumoper = @Numero 
      AND    @contador = CASE WHEN motipoper IN('VP','VI') THEN mocorvent ELSE mocorrela END

      SELECT @cMoneda  = mnnemo  FROM BacParamSuda..MONEDA WHERE mncodmon = CONVERT(INTEGER,@cMoneda)

      
      SELECT @nemotecnico = @nemotecnico
                          + CONVERT(CHAR(31),CONVERT(CHAR(10),LTRIM(RTRIM(moinstser))) + 
		     ' '  + CONVERT(CHAR(3),LTRIM(RTRIM(@cMoneda))) + 
		     ' '  + CONVERT(CHAR(16),LTRIM(RTRIM(monominal)) + 
			    REPLICATE('',16-LEN(LTRIM(RTRIM(monominal))))) + '-')
      FROM   MDMO
      WHERE  monumoper    = @Numero 
      AND    @contador    = CASE WHEN motipoper IN('VP','VI') THEN mocorvent ELSE mocorrela END

      SELECT @custodia    = @custodia 
                          + CASE WHEN @custodia = ''  THEN '' ELSE '-' END 
                          + CASE WHEN modcv     = 'D' THEN 'DCV/'+ LTRIM(RTRIM(moclave_dcv))  
                                 WHEN modcv     = 'P' THEN 'PROPIA' 
                                 ELSE                      'CLIENTE' 
                            END
      FROM    MDMO
      WHERE   monumoper   = @Numero 
      AND     @contador   = CASE WHEN motipoper IN('VP','VI') THEN mocorvent ELSE mocorrela END

      SET ROWCOUNT 0

      SELECT @iCont    = @iCont + 1

      IF @iCont = 2 SELECT @iCont = 0

      SELECT @contador = @contador + 1
   END


   SELECT 'Banco_emisor'    = CONVERT(CHAR(10),LTRIM(RTRIM(acnomprop)))
   ,      'codswift_emi'    = ISNULL(min(cor.codigo_swift),'')
   ,      'Banco_receptor'  = isnull(min(cli.clnombre),'')
   ,      'codswift_recep'  = isnull(min(corcli.codigo_swift),'')
   ,      'ref_transaccion' = CASE WHEN mo.motipoper = 'IB' THEN LTRIM(RTRIM(Substring(@nemotecnico,1,10))) + ' ' + CONVERT(CHAR(10),mo.monumoper)
                                   WHEN mo.motipoper = 'CP' THEN 'CMN'  + ' ' + CONVERT(CHAR(10),mo.monumoper)
                                   WHEN mo.motipoper = 'VP' THEN 'VMN'  + ' ' + CONVERT(CHAR(10),mo.monumoper)
                                   WHEN mo.motipoper = 'CI' THEN 'CPAC' + ' ' + CONVERT(CHAR(10),mo.monumoper)
                                   WHEN mo.motipoper = 'VI' THEN 'VPAC' + ' ' + CONVERT(CHAR(10),mo.monumoper)
                             END
   ,      'moneda_prestamo' = min(mon.mnnemo)
   ,      'moneda_pagos'    = min(mon.mnnemo)
   ,      'capital'         = CASE WHEN mo.motipoper = 'CP' THEN SUM(mo.mocapitali) ELSE SUM(mo.movalinip)END
   ,      'interes'         = SUM(mo.movalvenp) - SUM(mo.movalinip)
   ,      'monto a pagar'   = SUM(mo.movalvenp)
   ,      'tasa'            = mo.motaspact
   ,      'fecha_inicio'    = CONVERT(CHAR(10),mo.mofecpro,103)
   ,      'fecha_valor'     = CASE WHEN min(fpag.diasvalor) = 0 THEN CONVERT(CHAR(10),@lbtr,103)
                                   WHEN min(fpag.diasvalor) = 1 THEN CONVERT(CHAR(10),@lbtr24,103)
                                   WHEN min(fpag.diasvalor) = 2 THEN CONVERT(CHAR(10),@lbtr48,103)
                                   ELSE                              CONVERT(CHAR(10),mo.mofecpro,103)
                              END
   ,      'Hora'            = CONVERT(CHAR(5),GETDATE(),108)
   ,      'personas'        = ISNULL(min(usuar.nombre),'')
   ,      'renuncia'        = 'S'
   ,      'Fecha_Impresion' = CONVERT(CHAR(10),GETDATE(),103)
   ,      'Hora_Impresion'  = CONVERT(CHAR(5),GETDATE(),108)
   ,      'titulo'          = CASE WHEN mo.motipoper = 'IB' THEN (CASE WHEN SUBSTRING(@nemotecnico, 1 , 4) = 'ICAP' THEN 'INTERBANCARIO DE CAPTACION (Renta Fija)'ELSE 'INTERBANCARIO DE COLOCACION (Renta Fija)' END)
                                   WHEN mo.motipoper = 'CP' THEN 'COMPRA MONEDA NACIONAL (Renta Fija)'
                                   WHEN mo.motipoper = 'VP' THEN 'VENTA MONEDA NACIONAL (Renta Fija)'
                                   WHEN mo.motipoper = 'CI' THEN 'COMPRA CON PACTO (Renta Fija)'
                                   WHEN mo.motipoper = 'VI' THEN 'VENTA CON PACTO (Renta Fija)'
			      END
   ,      'sistema_pago'    = CONVERT(varCHAR(20),min(fpag.glosa))
   ,      'nemotecnico'	    = SUBSTRING(@nemotecnico,1  ,31) + ' ' + SUBSTRING(@nemotecnico,32 ,31)
   ,      'nemotecnico1'    = SUBSTRING(@nemotecnico,63 ,31) + ' ' + SUBSTRING(@nemotecnico,94,31)
   ,      'nemotecnico2'    = SUBSTRING(@nemotecnico,125,31) + ' ' + SUBSTRING(@nemotecnico,156,31)
   ,      'nemotecnico3'    = SUBSTRING(@nemotecnico,187,31) + ' ' + SUBSTRING(@nemotecnico,218,31)
   ,      'nemotecnico4'    = SUBSTRING(@nemotecnico,249,31) + ' ' + SUBSTRING(@nemotecnico,280,31)
   ,      'nemotecnico5'    = SUBSTRING(@nemotecnico,311,31) + ' ' + SUBSTRING(@nemotecnico,342,31)
   ,      'nemotecnico6'    = SUBSTRING(@nemotecnico,373,31) + ' ' + SUBSTRING(@nemotecnico,404,31)
   ,      'nemotecnico7'    = SUBSTRING(@nemotecnico,435,31) + ' ' + SUBSTRING(@nemotecnico,466,31)
   ,      'nemotecnico8'    = SUBSTRING(@nemotecnico,497,31) + ' ' + SUBSTRING(@nemotecnico,528,31)
   ,      'nemotecnico9'    = SUBSTRING(@nemotecnico,559,31) + ' ' + SUBSTRING(@nemotecnico,590,31)
   ,      'nemotecnico10'   = SUBSTRING(@nemotecnico,621,31) + ' ' + SUBSTRING(@nemotecnico,652,31)
   ,      'nemotecnico11'   = SUBSTRING(@nemotecnico,683,31) + ' ' + SUBSTRING(@nemotecnico,714,31)
   ,      'nemotecnico12'   = SUBSTRING(@nemotecnico,745,31) + ' ' + SUBSTRING(@nemotecnico,776,31)
   ,      'nemotecnico13'   = SUBSTRING(@nemotecnico,807,31) + ' ' + SUBSTRING(@nemotecnico,838,31)
   ,      'numero_operacion'= mo.monumoper
   ,      'custodia'	    = CASE WHEN mo.motipoper = 'VP' THEN ' ' ELSE @custodia END
   ,      'tasa_descuento'  = CONVERT(FLOAT,0)
   ,      'valor_descuento' = CONVERT(FLOAT,0)
   ,      'nominal'	    = SUM(mo.monominal)
   ,      'valor_venta'	    = SUM(mo.movalven)
   ,      'fecha_venta'	    = CONVERT(CHAR(10),mo.mofecpro,103)
   ,      'valor_final'     = ROUND( SUM(mo.movalvenp),4)
   ,      'valor_inicio'    = ROUND( SUM(mo.movalinip) / ISNULL(MIN(vmvalor),1.0) ,4)
   ,      'fecha_vcto'      = CONVERT(CHAR(10),mo.mofecvenp,103)
   ,      'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
   FROM   MDMO mo
          LEFT JOIN BacparamSuda..CLIENTE       cli    ON cli.clrut          = mo.morutcli AND cli.clcodigo         = mo.mocodcli
          LEFT JOIN BacParamSuda..CORRESPONSAL  corcli ON corcli.rut_cliente = mo.morutcli AND corcli.codigo_moneda = 999
          LEFT JOIN BacParamSuda..MONEDA        mon    ON mon.mncodmon       = CASE WHEN mo.motipoper IN('IB','CI','VI')        THEN mo.momonpact ELSE mo.momonemi  END
          LEFT JOIN BacParamSuda..FORMA_DE_PAGO fpag   ON fpag.codigo        = CASE WHEN mo.motipoper IN('RC','RV','RCA','RVA') THEN mo.moforpagv ELSE mo.moforpagi END
          LEFT JOIN BacParamSuda..USUARIO       usuar  ON usuar.usuario      = mo.mousuario
          LEFT JOIN BacParamSuda..VALOR_MONEDA  vmon   ON vmon.vmcodigo      = mon.mncodmon AND vmon.vmfecha       = CASE WHEN mo.motipoper IN('IB','CI','VI') THEN mo.mofecinip ELSE mo.fecha_compra_original END

   ,      MDAC
          LEFT JOIN BacParamSuda..CORRESPONSAL  cor    ON cor.rut_cliente    = acrutprop   AND cor.codigo_moneda   = 999
   WHERE  monumoper         = @Numero
   AND   (moinstser        IN('ICAP','ICOL') 
       OR motipoper        IN('CP','VI','CI','VP')
         )
   GROUP BY acnomprop
         ,  mo.motipoper
         ,  mo.monumoper
         ,  mo.morutcli
         ,  mo.mocodcli
         ,  mo.mofecinip
         ,  mo.mofecvenp
         ,  mo.motaspact
         ,  mo.mousuario
         ,  mo.moforpagi
         ,  mo.moforpagv
         ,  mo.mofecpro
         ,  mo.momonpact          



END   /* FIN PROCEDIMIENTO */

GO
