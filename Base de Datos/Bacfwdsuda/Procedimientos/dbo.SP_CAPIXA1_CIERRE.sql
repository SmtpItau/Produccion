USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CAPIXA1_CIERRE]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SP_CAPIXA1_CIERRE '20180528',12947634,12947634
CREATE PROCEDURE [dbo].[SP_CAPIXA1_CIERRE]
   (   @dfecha        DATETIME  
   ,   @nrutapo1      FLOAT  
   ,   @nrutapo2      FLOAT  
   )  
AS  
BEGIN  
  
   SET NOCOUNT ON  
   /*=======================================================================*/  
   /*=======================================================================*/  
   DECLARE @cfecha     CHAR(10)  
   DECLARE @nnumope    NUMERIC(8)  
   DECLARE @nvaluf     NUMERIC(10,4)  
   DECLARE @nvalob     NUMERIC(10,4)  
   DECLARE @cnomprop   CHAR(60)  
   DECLARE @cdirprop   CHAR(60)  
   DECLARE @nrutprop   NUMERIC(9)   
   DECLARE @cdigprop   CHAR(1)  
   DECLARE @ncodclie   NUMERIC(4)  
   DECLARE @cfecpro    CHAR(10)  
   DECLARE @ap1nombre  CHAR(40)      
   DECLARE @ap1cargo   CHAR(40)      
   DECLARE @ap1fono    CHAR(15)      
   DECLARE @ap2nombre  CHAR(40)      
   DECLARE @ap2cargo   CHAR(40)      
   DECLARE @ap2fono    CHAR(15)    
   DECLARE @cuenta     float    
   DECLARE @cEmailApo1 CHAR (40)    
  
   -- 21 Oct. 2009  Para calculo prima en dólares  
   DECLARE @DoObs      FLOAT   
   SELECT  @DoObs = 0.0  
  
  
   /*=======================================================================*/   
   /*=======================================================================*/  
   /*=======================================================================*/  
   SELECT      @cfecha = @dfecha, --> CONVERT( CHAR(10), convert(datetime,@dfecha), 103 )  ,  
               @nvaluf = b.vmvalor     ,  
               @nvalob = c.vmvalor     ,  
               @cnomprop = (Select acnomprop from mfac),  
               @cdirprop = (d.acdirprop + 'SANTIAGO')    ,  
               @nrutprop = d.acrutprop    ,  
               @cdigprop = d.acdigprop    ,  
		       @ncodclie = 2                          ,  
               @cfecpro = CONVERT( CHAR(10), d.acfecproc, 103 )   
   FROM        view_valor_moneda b with (nolock) ,  
               view_valor_moneda c with (nolock) ,  
            mfac              d with (nolock)   
   WHERE     b.vmcodigo = 998 AND  
               convert(char(08),b.vmfecha,112)  = @dfecha AND   
               c.vmcodigo = 994 AND  
               convert(char(08),c.vmfecha,112)  = @dfecha     
  
   /*=======================================================================*/  
   /* Selecciona los Apoderados          */   
   /*=======================================================================*/  
  
   SELECT   @ap1nombre  = a.apnombre   ,  
			@ap1cargo   = a.apcargo    ,  
            @ap1fono    = a.apfono    ,  
			@cEmailApo1 = a.apemail  
   FROM     view_cliente_apoderado a with (nolock) ,  
            mfac                   b with (nolock)   
   WHERE    @nrutapo1 = a.aprutapo AND b.acrutprop = a.aprutcli  
  
   SELECT   @ap2nombre = a.apnombre   ,  
			@ap2cargo  = a.apcargo    ,  
            @ap2fono   = a.apfono     
   FROM     view_cliente_apoderado a with (nolock) ,  
            mfac                   b with (nolock)   
   WHERE    @nrutapo2 = a.aprutapo AND b.acrutprop = a.aprutcli  
  
 
     
   -- 21 Oct. 2009  Para calculo prima en dólares  
   SELECT @DoObs = vmvalor    
   FROM  BacParamSuda..Valor_Moneda      
   WHERE vmFecha = @dfecha  
   AND  vmcodigo =994  
  
   SELECT vmfecha, vmcodigo, vmvalor  
   INTO  #VALOR_MONEDA   
   FROM  BacParamSuda..VALOR_MONEDA  
   WHERE vmFecha    = @dfecha  
  
   INSERT INTO #VALOR_MONEDA  
   SELECT @dfecha, 999, 1.0  
  
   INSERT INTO #VALOR_MONEDA  
   SELECT @dfecha, 13, @DoObs  
  
   /*=======================================================================*/  
   /* llena los datos desde la Cartera         */   
   /*=======================================================================*/  
  
    SELECT  'TipOpe'   = a.catipoper    ,  
              'NumOpe'   = a.canumoper    ,  
              'RutCli'   = a.cacodigo     ,  
              'DigCli'   = b.cldv  ,  
              'NomCli'   = b.clnombre     ,  
              'FecIni'   = CONVERT(CHAR(10),a.cafecha  ,103) ,  
              'FecTer'   = CONVERT(CHAR(10),a.cafecvcto,103) ,  
              'CpaCodMon'  = case a.catipoper when 'C' then a.cacodmon1 else a.cacodmon2 End  ,      
              'CpaNemMon'  = case a.catipoper when 'C' then c.mnnemo else d.mnnemo End   ,      
              'CpaMonto'   = case a.catipoper when 'C' then a.camtomon1 else a.camtomon2 End  ,      
              'VtaCodMon'  = case a.catipoper when 'V' then a.cacodmon1 else a.cacodmon2 End  ,      
              'VtaNemMon'  = case a.catipoper when 'V' then c.mnnemo else CASE WHEN a.var_moneda2 > 0 THEN 'CLP' ELSE d.mnnemo END End   ,      
              'VtaMonto'   = case a.catipoper when 'V' then a.camtomon1 else CASE WHEN a.var_moneda2 > 0 THEN a.caequmon2 ELSE a.camtomon2 END End  ,      
              'Modal'    = a.catipmoda    ,   -- select * from mfca  
              'PreFut'   = CASE  WHEN a.cacodpos1 = 3  THEN a.capremon2   
       WHEN a.cacodpos1 = 13 THEN a.capremon2  
       WHEN a.cacodpos1 = 11 THEN a.catipcam  --> CS-AG  
     WHEN a.cacodpos1 = 2  THEN CASE WHEN a.var_moneda2 > 0 THEN a.caprecal ELSE a.catipcam  END  
       ELSE       a.caprecal   
       END, -- caparbcch  
              'PreSpt'   = a.capremon1, --a.precio_spot, --a.caTcSpot     ,  
           'nomprop'  = @cnomprop  ,  
           'dirprop'  = @cdirprop  ,  
           'rutprop'  = @nrutprop  ,  
           'digprop'  = @cdigprop  ,  
           'FecInfo'  = @cfecha  ,  
           'codclie'  = @ncodclie      ,  
           'FecPro'   = @cfecpro       ,  
           'Marca'    = 'I'   ,   
           'Plazo'    = a.caplazo      ,  
              'Apodera1'  = ISNULL( @ap1nombre , '' ) ,  
              'Cargo1'    = ISNULL( @ap1cargo  , '' ) ,  
              'Fono1'     = ISNULL( @ap1fono   , '' ) ,  
              'Apodera2'  = ISNULL( @ap2nombre , '' ) ,  
              'Cargo2'    = ISNULL( @ap2cargo  , '' ) ,  
              'Fono2'     = ISNULL( @ap2fono   , '' ) ,  
              'Contador'        = CONVERT(FLOAT,0.0),  
              'CanPag'          = CONVERT(FLOAT,0.0),  
             'CodPais'         = ISNULL(e.codigo_pais,0)   ,  
              'NomPais'         = ISNULL(e.nombre,'')  ,  
              'EmailApo1'       = @cEmailApo1,  
              'Sector Eco'      = b.CLACTIVIDA,  
              'cod_instru'      = a.caoperrelaspot, --'01'  
              'Prima'           = CONVERT(FLOAT,0.0)   
         INTO  #temp  
    FROM   mfca a with (nolock)  
    INNER JOIN  view_cliente  b with (nolock) ON (a.cacodigo = b.clrut AND a.cacodcli  = b.clcodigo )  
    INNER JOIN  view_moneda   c with (nolock)ON  a.cacodmon1 = c.mncodmon  
    INNER JOIN  view_moneda   d with (nolock)ON  a.cacodmon2 = d.mncodmon  
    RIGHT OUTER JOIN  view_pais  e with (nolock) ON CONVERT(INT,e.codigo_pais ) = b.clpais  
    WHERE a.catipoper IN ('C','V')      
	AND	a.cacodpos1 IN (1, 2, 3, 12, 11,14)  
    AND NOT (a.cacodpos1=1 and var_moneda2<>0) --REQ. 5541   
    AND  NumeroContratoCliente = 0  
    AND a.cafecvcto> @dfecha
	
	 
      INSERT INTO  #temp  
      SELECT  'TipOpe'   = a.catipoper    ,  
              'NumOpe'   = a.canumoper    ,  
              'RutCli'   = a.cacodigo     ,  
              'DigCli'   = b.cldv  ,  
              'NomCli'   = b.clnombre     ,  
              'FecIni'   = CONVERT(CHAR(10),a.cafecha  ,103) ,  
              'FecTer'   = CONVERT(CHAR(10),a.cafecvcto,103) ,  
              'CpaCodMon'  = case a.catipoper when 'C' then a.cacodmon1 else a.cacodmon2 End  ,      
              'CpaNemMon'  = case a.catipoper when 'C' then c.mnnemo else d.mnnemo End   ,      
              'CpaMonto'   = case a.catipoper when 'C' then a.camtomon1 else a.camtomon2 End  ,      
              'VtaCodMon'  = case a.catipoper when 'V' then a.cacodmon1 else a.cacodmon2 End  ,      
              'VtaNemMon'  = case a.catipoper when 'V' then c.mnnemo else CASE WHEN a.var_moneda2 > 0 THEN 'CLP' ELSE d.mnnemo END End   ,      
              'VtaMonto'   = case a.catipoper when 'V' then a.camtomon1 else CASE WHEN a.var_moneda2 > 0 THEN a.caequmon2 ELSE a.camtomon2 END End  ,      
--              'VtaNemMon'  = case a.catipoper when 'V' then c.mnnemo else d.mnnemo End   ,      
--              'VtaMonto'   = case a.catipoper when 'V' then a.camtomon1 else a.camtomon2 End  ,      
              'Modal'    = a.catipmoda    ,  
              'PreFut'   = CASE  WHEN a.cacodpos1 = 3  THEN a.capremon2   
     WHEN a.cacodpos1 = 13 THEN a.capremon2  
     WHEN a.cacodpos1 = 11 THEN a.catipcam  --> CS-AG  
     WHEN a.cacodpos1 = 2  THEN CASE WHEN a.var_moneda2 > 0 THEN a.caprecal ELSE a.catipcam  END  
     ELSE       a.caprecal   
      END, -- caparbcch  
              'PreSpt'   = a.capremon1    ,         
           'nomprop'  = @cnomprop  ,  
           'dirprop'  = @cdirprop  ,  
           'rutprop'  = @nrutprop  ,  
           'digprop'  = @cdigprop  ,  
           'FecInfo'  = @cfecha  ,  
           'codclie'  = @ncodclie      ,  
           'FecPro'   = @cfecpro    ,  
             'Marca'    = 'I'    ,   
           'Plazo'    = a.caplazo      ,  
              'Apodera1'  = ISNULL( @ap1nombre , '' ) ,  
              'Cargo1'    = ISNULL( @ap1cargo  , '' ) ,  
              'Fono1'     = ISNULL( @ap1fono   , '' ) ,  
              'Apodera2'  = ISNULL( @ap2nombre , '' ) ,  
              'Cargo2'    = ISNULL( @ap2cargo  , '' ) ,  
              'Fono2'     = ISNULL( @ap2fono   , '' ) ,  
              'Contador'        = 0 ,  
              'CanPag'          = 0 ,  
             'CodPais'         = ISNULL(e.codigo_pais,0)   ,  
              'NomPais'         = ISNULL(e.nombre,'')  ,  
              'EmailApo1'       = @cEmailApo1 ,  
              'Sector Eco'      = b.CLACTIVIDA,  
              'cod_instru'      = '01',  
              'Prima'           = 0.0  
           
  FROM   mfcah a with (nolock)  
  INNER JOIN view_cliente  b with (nolock) ON (a.cacodigo = b.clrut AND a.cacodcli  = b.clcodigo)  
  INNER JOIN view_moneda   c with (nolock) ON  a.cacodmon1 = c.mncodmon  
  INNER JOIN view_moneda   d with (nolock) ON  a.cacodmon2 = d.mncodmon  
  RIGHT OUTER JOIN view_pais  e with (nolock) ON CONVERT(INT,e.codigo_pais) = b.clpais  
  WHERE  a.catipoper IN ('C','V')   
	AND	a.cacodpos1 IN (1,2,3,12,11,14) 
    AND NOT (a.cacodpos1=1 and var_moneda2<>0)                    
    AND  NumeroContratoCliente = 0  
	AND a.cafecvcto > @dfecha

 
   DECLARE @Fecha_ant_Habil DATETIME
   DECLARE @Fecha_Proceso   DATETIME
   SELECT  @Fecha_ant_Habil = acfecante 
        ,  @Fecha_Proceso 	= acfecproc  
   FROM mfac      


--***************************************SWAP**************************************************************  
-- INICIO INGRESOS SWAP

   CREATE TABLE #CARTERA
      (   compra_amortiza          NUMERIC(19,4)   NOT NULL DEFAULT(0.0)  
      ,   compra_interes           NUMERIC(19,4)   NOT NULL DEFAULT(0.0)  
      ,   venta_amortiza           NUMERIC(19,4)   NOT NULL DEFAULT(0.0)  
      ,   venta_interes            NUMERIC(19,4)   NOT NULL DEFAULT(0.0)  
      ,   fecha_inicio             DATETIME     NOT NULL DEFAULT('')  
      ,   tipo_operacion           CHAR(1)      NOT NULL DEFAULT('')  
      ,   tipo_swap                INTEGER      NOT NULL DEFAULT(0)  
      ,	  numero_flujo	           NUMERIC(3)   NOT NULL DEFAULT(0)  
	  ,	  rut_cliente	           NUMERIC(9)   NOT NULL DEFAULT(0)  
	  ,	  Dig_Rut			       CHAR(1)      NOT NULL DEFAULT('')  
      ,	  codigo_cliente	       NUMERIC(9)   NOT NULL DEFAULT(0)  
      ,   Rec_Moneda               NUMERIC(3)   NOT NULL DEFAULT(0)  
      ,   Pag_Moneda               NUMERIC(3)   NOT NULL DEFAULT(0)  
      ,	  Rec_Nemo_Moneda		   CHAR(8)      NOT NULL DEFAULT('')  
      ,	  Pag_Nemo_Moneda		   CHAR(8)      NOT NULL DEFAULT('')  
      ,   fecha_termino            DATETIME     NOT NULL DEFAULT('')  
	  ,	  numero_operacion         NUMERIC(9)   NOT NULL DEFAULT(0)  
      ,   modalidad_pago           CHAR(1)      NOT NULL DEFAULT('')  
      ,   compra_moneda            NUMERIC(3)   NOT NULL DEFAULT(0)  
      ,   venta_moneda             NUMERIC(3)   NOT NULL DEFAULT(0)  
      ,   compra_valor_tasa        NUMERIC(10,6)   NOT NULL DEFAULT(0.0)  
      ,   venta_valor_tasa         NUMERIC(10,6)   NOT NULL DEFAULT(0.0)  
      ,   fecha_cierre             DATETIME     NOT NULL DEFAULT('')  
      ,   compra_saldo             NUMERIC(19,4)   NOT NULL DEFAULT(0.0)
      ,   venta_saldo              NUMERIC(19,4)   NOT NULL DEFAULT(0.0)
      ,   compra_Flujo_adicional   FLOAT        NOT NULL DEFAULT(0.0)  
      ,   venta_Flujo_adicional    FLOAT        NOT NULL DEFAULT(0.0)  
      ,	  SwapCCS_X_Flujo	       NUMERIC(9)   NOT NULL DEFAULT(0)  
      ,   IntercPrincRec           INTEGER      NOT NULL DEFAULT(0)  
      ,   IntercPrincPag           INTEGER      NOT NULL DEFAULT(0)  
      ,   MontoRec                 FLOAT        NOT NULL DEFAULT(0.0)  
      ,   MontoEnt                 FLOAT        NOT NULL DEFAULT(0.0)        
      ,   compra_capital           NUMERIC(19,4)   NOT NULL DEFAULT(0.0)
      ,   venta_capital            NUMERIC(19,4)   NOT NULL DEFAULT(0.0)
      ,   Codigo_Inst              CHAR(3)      NOT NULL DEFAULT('')  
      ,   Estado_Flujo             NUMERIC(1)   NOT NULL DEFAULT(0)

/*
           CONSTRAINT [PK_CARTERA_CNT]   PRIMARY KEY CLUSTERED  
          (   Fecha_Cierre,   Tipo_Swap, Numero_Operacion )   ON [PRIMARY]  
*/
      )--  ON [PRIMARY]   

-- sp_help cartera

INSERT INTO #CARTERA
SELECT  DISTINCT compra_amortiza      = 0.0
      ,   compra_interes              = 0.0
      ,   venta_amortiza              = 0.0
      ,   venta_interes               = 0.0
      ,   fecha_inicio                = fecha_inicio
      ,   tipo_operacion              = tipo_operacion
      ,   tipo_swap                   = tipo_swap
      ,   numero_flujo				  = numero_flujo
      ,   rut_cliente                 = rut_cliente
      ,   Dig_Rut			          = Cldv
      ,   codigo_cliente              = codigo_cliente
      ,   Rec_Moneda			      = 0
      ,   Pag_Moneda                  = 0
      ,   Rec_Nemo_Moneda		      = ''
      ,   Pag_Nemo_Moneda             = ''
      ,   fecha_termino               = fecha_termino
      ,   numero_operacion            = numero_operacion 
      ,   modalidad_pago              = modalidad_pago
      ,   compra_moneda               = 0
      ,   venta_moneda                = 0
      ,   compra_valor_tasa           = 0.0
      ,   venta_valor_tasa            = 0.0
      ,   fecha_cierre                = fecha_cierre
      ,   compra_saldo                = 0.0
      ,   venta_saldo                 = 0.0
      ,   Compra_Flujo_Adicional      = 0.0
      ,   Venta_Flujo_Adicional       = 0.0
      ,   SwapCCS_X_Flujo             = 0
      ,   IntercPrincRec              = 0
      ,   IntercPrincPag              = 0
      ,   MontoRec                    = 0.0
      ,   MontoEnt                    = 0.0
      ,   compra_capital              = 0.0
      ,   venta_capital               = 0.0
      ,   Codigo_Inst                 = '08'      
      ,   Estado_Flujo		          = estado_flujo
   FROM   bacswapsuda.dbo.cartera with (nolock)
          LEFT JOIN BacParamSuda..CLIENTE with (nolock)   ON clrut = rut_cliente AND clcodigo = codigo_cliente
          LEFT JOIN BacParamSuda..MONEDA  m with (nolock) ON m.mncodmon = compra_moneda
   WHERE estado_flujo			<> 2 -- Excluir los flujos vencidos cuyos Valores Razonables son distintos y duplican los movimientos    
		 AND fecha_termino > @dfecha
--		     fecha_cierre           =  @dfecha --  @cfecha

-- SELECT '#CARTERA_CER', * FROM #CARTERA 

   INSERT  INTO  #CARTERA
   SELECT  DISTINCT 
          compra_amortiza             = a.compra_amortiza
      ,   compra_interes              = a.compra_interes
      ,   venta_amortiza              = 0.0
      ,   venta_interes               = 0.0
      ,   fecha_inicio                = fecha_inicio
      ,   tipo_operacion              = tipo_operacion
      ,   tipo_swap                   = tipo_swap
      ,   numero_flujo				  = 0
      ,   rut_cliente                 = rut_cliente
      ,   Dig_Rut			          = Cldv
      ,   codigo_cliente              = codigo_cliente
      ,   Rec_Moneda			      = a.recibimos_moneda
      ,   Pag_Moneda                  = 0
      ,   Rec_Nemo_Moneda		      = Rec.mnnemo
      ,   Pag_Nemo_Moneda             = ''
      ,   fecha_termino               = fecha_termino
      ,   numero_operacion            = a.numero_operacion
      ,   modalidad_pago              = modalidad_pago
      ,   compra_moneda               = a.compra_moneda
      ,   venta_moneda                = 0
      ,   compra_valor_tasa           = a.compra_valor_tasa
      ,   venta_valor_tasa            = 0.0
      ,   fecha_cierre                = fecha_cierre
      ,   compra_saldo                = a.compra_saldo
      ,   venta_saldo                 = 0.0
      ,   Compra_Flujo_Adicional      = a.Compra_Flujo_Adicional
      ,   Venta_Flujo_Adicional       = 0.0
      ,   SwapCCS_X_Flujo             = 0
      ,   IntercPrincRec              = a.IntercPrinc
      ,   IntercPrincPag              = 0
      ,   MontoRec                    = convert(numeric(21,4), a.compra_saldo + a.compra_amortiza )
      ,   MontoEnt                    = 0.0
      ,   compra_capital              = a.compra_capital
      ,   venta_capital               = 0.0
      ,   Codigo_Inst                 = '07'   
      ,   Estado_Flujo                = a.estado_flujo
   
   FROM  bacswapsuda.dbo.cartera  a with (nolock)
         inner join bacparamsuda.dbo.cliente cli with (nolock) on cli.clrut             = rut_cliente and cli.clcodigo = codigo_cliente
         inner join bacparamsuda.dbo.moneda  Rec with (nolock) on Rec.mncodmon          = a.recibimos_moneda
   WHERE  a.tipo_flujo             = 1
    AND   a.estado_flujo		   = 1
    AND   a.tipo_swap              = 2
    AND   a.fecha_termino > @dfecha
--  a.fecha_cierre           = @dfecha   --  @cfecha

   UPDATE #CARTERA
   SET    venta_amortiza              = a.venta_amortiza
      ,   venta_interes               = a.venta_interes
      ,   Pag_Moneda                  = a.pagamos_moneda
      ,   Pag_Nemo_Moneda             = Pag.mnnemo
      ,   venta_moneda                = a.venta_moneda
      ,   venta_valor_tasa            = a.venta_valor_tasa
      ,   venta_saldo                 = a.venta_saldo
      ,   Venta_Flujo_Adicional       = a.Venta_Flujo_Adicional
      ,   IntercPrincPag              = a.IntercPrinc
      ,   MontoEnt                    = convert(numeric(21,4), a.venta_saldo  + a.venta_amortiza )      
      ,   venta_capital               = a.venta_capital
   FROM  bacswapsuda.dbo.cartera  a with (nolock)
         inner join bacparamsuda.dbo.cliente cli with (nolock) on cli.clrut             = rut_cliente and cli.clcodigo = codigo_cliente
         inner join bacparamsuda.dbo.moneda  Pag with (nolock) on Pag.mncodmon          = a.Pagamos_moneda 
   WHERE #CARTERA.numero_operacion = a.numero_operacion   
   AND   #CARTERA.numero_flujo     = 0        
   AND   a.tipo_flujo              = 2
   AND   a.tipo_swap               = 2

-- DETALLE 

   UPDATE #CARTERA
   SET    compra_amortiza             = a.compra_amortiza
      ,   compra_interes              = a.compra_interes
      ,   Rec_Moneda			        = a.recibimos_moneda
      ,   Rec_Nemo_Moneda		        = Rec.mnnemo
      ,   compra_moneda                 = a.compra_moneda
      ,   compra_valor_tasa             = a.compra_valor_tasa
      ,   compra_saldo                  = a.compra_saldo
      ,   Compra_Flujo_Adicional        = a.Compra_Flujo_Adicional
      ,   IntercPrincRec                = a.IntercPrinc
      ,   MontoRec                      = convert(numeric(21,4), a.Compra_Flujo_Adicional + (a.compra_amortiza * a.IntercPrinc) + a.compra_interes )
      ,   compra_capital                = a.compra_capital      
   FROM  bacswapsuda.dbo.cartera  a  with (nolock)
         inner join bacparamsuda.dbo.cliente cli with (nolock) on cli.clrut             = rut_cliente and cli.clcodigo = codigo_cliente
         inner join bacparamsuda.dbo.moneda  Rec with (nolock) on Rec.mncodmon          = a.recibimos_moneda
   WHERE #CARTERA.numero_operacion       = a.numero_operacion
   AND   #CARTERA.numero_flujo = a.numero_flujo        
   AND   a.tipo_flujo             = 1
   AND   a.tipo_swap              = 2
  

   UPDATE #CARTERA
   SET    venta_amortiza              = a.venta_amortiza
      ,   venta_interes               = a.venta_interes
      ,   Pag_Moneda                  = a.pagamos_moneda
      ,   Pag_Nemo_Moneda             = Pag.mnnemo
      ,   venta_moneda                = a.venta_moneda
      ,   venta_valor_tasa            = a.venta_valor_tasa
      ,   venta_saldo                 = a.venta_saldo
      ,   Venta_Flujo_Adicional       = a.Venta_Flujo_Adicional
      ,   IntercPrincPag              = a.IntercPrinc
      ,   MontoEnt                    = convert(numeric(21,4), a.venta_Flujo_Adicional  + (a.venta_amortiza  * a.IntercPrinc) + a.venta_interes  )
      ,   venta_capital               = a.venta_capital
      ,   Codigo_Inst                      = '08'    
   FROM  bacswapsuda.dbo.cartera  a
         inner join bacparamsuda.dbo.cliente cli with (nolock) on cli.clrut             = rut_cliente and cli.clcodigo = codigo_cliente
         inner join bacparamsuda.dbo.moneda  Pag with (nolock) on Pag.mncodmon          = a.Pagamos_moneda 
   WHERE #CARTERA.numero_operacion       = a.numero_operacion
   AND   #CARTERA.numero_flujo = a.numero_flujo       
   AND   a.tipo_flujo             = 2
   AND   a.tipo_swap              = 2


 INSERT INTO  #temp  
 SELECT 
    'TipOpe' = tipo_Operacion 
  , 'NumOpe' = RTRIM(CONVERT(CHAR(5), numero_operacion )) + RTRIM(CONVERT(CHAR(5), numero_flujo ))
  , 'RutCli' = Rut_Cliente   
  , 'DigCli' = Dig_Rut  
  , 'NomCli' = b.Clnombre
  , 'FecIni' = fecha_inicio  -- CONVERT(CHAR(10),fecha_inicio,103)  
  , 'FecTer' = Fecha_Termino -- CONVERT(CHAR(10),Fecha_Termino,103)  
  , 'CpaCodMon' = Rec_Moneda 
  , 'CpaNemMon' = Rec_Nemo_Moneda   
  , 'CpaMonto'  = MontoRec  
  , 'VtaCodMon' = Pag_Moneda  
  , 'VtaNemMon' = Pag_Nemo_Moneda  
  , 'VtaMonto' = MontoEnt  
  , 'Modal'     = modalidad_pago  
  , 'PreFut' = case when tipo_swap in ( 1, 4) 
                                        then compra_valor_tasa 
                                   -- MN x MX
                                   when compra_moneda in ( 998, 999 ) and venta_moneda not in ( 998, 999 ) 
               then compra_capital / venta_capital
                                   -- MX x MN
                                   when Venta_moneda in ( 998, 999 ) and compra_moneda not in ( 998, 999 )  
                                        then venta_capital / compra_capital
                                   -- MN x MN
                                   when compra_moneda in ( 999 )
                                        then compra_capital / venta_capital
                                   when venta_moneda in ( 999 )
       then venta_capital / compra_capital
                                   -- MX x USD
				   when compra_moneda not in ( 13 )  and  venta_moneda in ( 13 )
                                        then compra_capital / venta_capital
                                   -- USD x MX
                                   when venta_moneda  not in ( 13 )  and  compra_moneda in  ( 13 )
                                        then compra_capital / venta_capital 
                                   -- MX x MX
                                   else compra_capital / venta_capital
                              end 
        , 'PreSpt'   = 0.0   
        , 'nomprop'  = @cnomprop   
        , 'dirprop'  = @cdirprop    
        , 'rutprop'  = @nrutprop    
        , 'digprop'  = @cdigprop    
        , 'FecInfo'  = @cfecha
        , 'codclie'  = @ncodclie    
        , 'FecPro'   = CONVERT(CHAR(10),@cfecpro,103)     
        , 'Marca'    = 'I'
        , 'Plazo'    = DATEDIFF(DD,fecha_inicio, Fecha_Termino)  
        , 'Apodera1' = ISNULL( @ap1nombre , '' )   
        , 'Cargo1'   = ISNULL( @ap1cargo  , '' )   
        , 'Fono1'    = ISNULL( @ap1fono   , '' )   
        , 'Apodera2' = ISNULL( @ap2nombre , '' )   
        , 'Cargo2'   = ISNULL( @ap2cargo  , '' )   
        , 'Fono2'    = ISNULL( @ap2fono   , '' )   
		, 'Contador' = 0
		, 'CanPag'   = 0 
		, 'CodPais'  = ISNULL(f.codigo_pais,0)  
        , 'NomPais'  = ISNULL(f.nombre,'')    
        , 'EmailApo1'= @cEmailApo1   
        , 'Sector Eco' = b.CLACTIVIDA  
        , 'cod_instru' = Codigo_Inst 
        , 'Prima'     = 0.0     
   FROM #CARTERA 
   INNER JOIN view_cliente b with (nolock) ON  (Rut_Cliente = b.clrut AND Codigo_Cliente = b.clcodigo  )   
   RIGHT OUTER JOIN view_pais  f with (nolock) ON CONVERT(INT,f.codigo_pais ) = b.clpais  
   INNER JOIN bacparamsuda.dbo.moneda  mco with (nolock) on mco.mncodmon          = compra_moneda
   INNER JOIN bacparamsuda.dbo.moneda  mvt with (nolock) on mvt.mncodmon          = venta_moneda
   WHERE NOT(MontoRec = 0 AND MontoEnt =	0)
	AND  ( (b.clpais         <> 6)
         or (b.clpais         = 6 and (mco.mnextranj = 1 or mvt.mnextranj = 1)) )   
   order by  numero_operacion,  numero_flujo


--***************************************SWAP**************************************************************  

  
--***************************************OPCIONES**************************************************************  
  
-- INGRESOS  
  
 SELECT  'TipOpe'     = A.CaCVEstructura  
       , 'NumOpe'     = A.CaNumContrato  
       , 'RutCli'     = ISNULL( CASE WHEN D.clpais = 6 then A.CaRutCliente else D.clrutcliexterno END , 0 )  
       , 'DigCli'     = ISNULL( CASE WHEN D.clpais = 6 then D.cldv         else D.cldvcliexterno  END , 0 )  
       , 'NomCli'     = D.clnombre  
       , 'FecIni'     = CONVERT(CHAR(10), B.CaFechaInicioOpc,103)     
       , 'FecTer'     = CONVERT(CHAR(10), B.CaFechaPagoEjer,103)   
       , 'CodMdaRec'  = CASE WHEN (B.CaCVOpc = 'C' AND  B.CaCallPut = 'Call') OR (B.CaCVOpc = 'V' AND  B.CaCallPut = 'Put')  
                                    THEN B.CaCodMon1  
                                    ELSE B.CaCodMon2  
                END  
       , 'NemMonRec'  = CASE WHEN (B.CaCVOpc = 'C' AND  B.CaCallPut = 'Call') OR (B.CaCVOpc = 'V' AND  B.CaCallPut = 'Put')  
                             THEN E.mnnemo  
                                    ELSE F.mnnemo  
                         END  
       , 'MtoRecibe'  = CASE WHEN (B.CaCVOpc = 'C' AND  B.CaCallPut = 'Call') OR (B.CaCVOpc = 'V' AND  B.CaCallPut = 'Put')  
                           THEN B.CaMontoMon1  
                                   ELSE B.CaMontoMon2  
                         END  
       , 'CodMdaEnt'  = CASE WHEN (B.CaCVOpc = 'C' AND  B.CaCallPut = 'Put') OR (B.CaCVOpc = 'V' AND  B.CaCallPut = 'Call')  
                                    THEN B.CaCodMon1  
                                    ELSE B.CaCodMon2   
                         END  
       , 'NemMonEnt'  = CASE WHEN (B.CaCVOpc = 'C' AND  B.CaCallPut = 'Put') OR (B.CaCVOpc = 'V' AND  B.CaCallPut = 'Call')  
                                    THEN E.mnnemo  
                                    ELSE F.mnnemo  
                         END  
       , 'MtoEntrega' = CASE WHEN (B.CaCVOpc = 'C' AND  B.CaCallPut = 'Put') OR (B.CaCVOpc = 'V' AND  B.CaCallPut = 'Call')  
                                   THEN B.CaMontoMon1  
                                   ELSE B.CaMontoMon2   
                         END       
       , 'Modal'      = B.CaModalidad  
       , 'PreFut'     = B.CaStrike  
       , 'PreSpt'     = B.CaStrike  
       , 'nomprop'    = @cnomprop  
       , 'dirprop'    = @cdirprop  
       , 'rutprop'    = @nrutprop  
       , 'digprop'    = @cdigprop  
       , 'FecInfo'    = @cfecha  
       , 'Codcli'     = @ncodclie        
       , 'FecPro'     = @cfecPro  
       , 'Marca'      = 'I'  
       , 'Plazo'      = DATEDIFF(DD,B.CaFechaInicioOpc, B.CaFechaPagoEjer)  
       , 'Apodera1'   = ISNULL( @ap1nombre , '' )  
       , 'Cargo1'     = ISNULL( @ap1cargo  , '' )  
       , 'Fono1'      = ISNULL( @ap1fono   , '' )  
       , 'Apodera2'   = ISNULL( @ap2nombre , '' )  
       , 'Cargo2'     = ISNULL( @ap2cargo  , '' )  
       , 'Fono2'      = ISNULL( @ap2fono   , '' )  
       , 'Contador'   = 0  
       , 'CanPag'     = 0  
       , 'CodPais'    = ISNULL(G.codigo_pais,0)  
       , 'NomPais'    = ISNULL(G.nombre,'')  
       , 'EmailApo1'  = @cEmailApo1  
       , 'Sector'     = D.CLACTIVIDA  
       , 'cod_instru' = (CASE WHEN B.CaCallPut = 'Call' THEN '03' ELSE '04' END)  
       , 'Prima'      = ROUND((H.vmvalor * B.CaPrimaInicialDet / @DoObs),4)  
       , 'CodPagPrima'= A.CaCodMonPagPrima 
 INTO #TEMP_OPC  
   
 FROM CbMdbOpc.dbo.CaResEncContrato A --CbMdbOpc.dbo.CaEncContrato A  
  INNER JOIN CbMdbOpc.dbo.CaResDetContrato B/*CbMdbOpc.dbo.CaDetContrato B*/ ON A.CaNumContrato =  B.CaNumContrato   
  INNER JOIN VIEW_CLIENTE   D with (nolock) ON (A.CaRutCliente  = D.clrut and A.CaCodigo = D.clcodigo )  
  INNER JOIN VIEW_MONEDA    E with (nolock) ON  B.CaCodMon1     = E.mncodmon    
  INNER JOIN VIEW_MONEDA    F with (nolock) ON  B.CaCodMon2     = F.mncodmon   
  RIGHT OUTER JOIN VIEW_PAIS  G with (nolock) ON  CONVERT(INT,G.codigo_pais) = D.clpais  
  INNER JOIN  #VALOR_MONEDA H ON A.CaCodMonPagPrima  = H.vmcodigo  
 WHERE A.CaTipoTransaccion <> 'ANULA'  
 AND   A.CaEstado <> 'C'  
 and b.CaFechaVcto>@dfecha
 and a.CaEncFechaRespaldo = @dfecha
 and b.CaDetFechaRespaldo = @dfecha
 --@dfecha         = CONVERT(CHAR(8),A.CaFechaContrato,112)  
  
  
  
-- VENCIDAS  
  
    INSERT INTO  #TEMP_OPC  
 SELECT  'TipOpe'     = A.CaCVEstructura  
       , 'NumOpe'     = A.CaNumContrato  
       , 'RutCli'     = ISNULL( CASE WHEN D.clpais = 6 then A.CaRutCliente else D.clrutcliexterno END , 0 )  
       , 'DigCli'     = ISNULL( CASE WHEN D.clpais = 6 then D.cldv         else D.cldvcliexterno  END , 0 )  
       , 'NomCli'     = D.clnombre  
       , 'FecIni'     = CONVERT(CHAR(10), B.CaFechaInicioOpc,103)     
       , 'FecTer'     = CONVERT(CHAR(10), B.CaFechaPagoEjer,103)   
       , 'CodMdaRec'  = CASE WHEN (B.CaCVOpc = 'C' AND  B.CaCallPut = 'Call') OR (B.CaCVOpc = 'V' AND  B.CaCallPut = 'Put')  
                                    THEN B.CaCodMon1  
                              ELSE B.CaCodMon2  
                         END  
       , 'NemMonRec'  = CASE WHEN (B.CaCVOpc = 'C' AND  B.CaCallPut = 'Call') OR (B.CaCVOpc = 'V' AND  B.CaCallPut = 'Put')  
                             THEN E.mnnemo  
                                    ELSE F.mnnemo  
                         END  
       , 'MtoRecibe'  = CASE WHEN (B.CaCVOpc = 'C' AND  B.CaCallPut = 'Call') OR (B.CaCVOpc = 'V' AND  B.CaCallPut = 'Put')  
                                   THEN B.CaMontoMon1  
                                   ELSE B.CaMontoMon2  
                         END  
       , 'CodMdaEnt'  = CASE WHEN (B.CaCVOpc = 'C' AND  B.CaCallPut = 'Put') OR (B.CaCVOpc = 'V' AND  B.CaCallPut = 'Call')  
                                    THEN B.CaCodMon1  
                                    ELSE B.CaCodMon2   
                         END  
       , 'NemMonEnt'  = CASE WHEN (B.CaCVOpc = 'C' AND  B.CaCallPut = 'Put') OR (B.CaCVOpc = 'V' AND  B.CaCallPut = 'Call')  
                                    THEN E.mnnemo  
                                    ELSE F.mnnemo  
                         END  
       , 'MtoEntrega' = CASE WHEN (B.CaCVOpc = 'C' AND  B.CaCallPut = 'Put') OR (B.CaCVOpc = 'V' AND  B.CaCallPut = 'Call')  
                                   THEN B.CaMontoMon1  
                                   ELSE B.CaMontoMon2   
                         END       
       , 'Modal'      = B.CaModalidad  
       , 'PreFut'     = B.CaStrike  
       , 'PreSpt'     = B.CaStrike  
       , 'nomprop'    = @cnomprop  
       , 'dirprop'    = @cdirprop  
       , 'rutprop'    = @nrutprop  
       , 'digprop'    = @cdigprop  
       , 'FecInfo'    = @cfecha  
       , 'Codcli'     = @ncodclie        
       , 'FecPro'     = @cfecPro  
       , 'Marca'      = 'I'  
       , 'Plazo'      = DATEDIFF(DD,B.CaFechaInicioOpc, B.CaFechaPagoEjer)  
       , 'Apodera1'   = ISNULL( @ap1nombre , '' )  
       , 'Cargo1'     = ISNULL( @ap1cargo  , '' )  
       , 'Fono1'      = ISNULL( @ap1fono   , '' )  
       , 'Apodera2'   = ISNULL( @ap2nombre , '' )  
       , 'Cargo2'     = ISNULL( @ap2cargo  , '' )  
       , 'Fono2'      = ISNULL( @ap2fono   , '' )  
       , 'Contador'   = 0  
       , 'CanPag'     = 0  
       , 'CodPais'    = ISNULL(G.codigo_pais,0)  
       , 'NomPais'    = ISNULL(G.nombre,'')  
       , 'EmailApo1'  = @cEmailApo1  
       , 'Sector'     = D.CLACTIVIDA  
       , 'cod_instru' = (CASE WHEN B.CaCallPut = 'Call' THEN '03' ELSE '04' END)  
       , 'Prima'      = ROUND((H.vmvalor * B.CaPrimaInicialDet / @DoObs),4)  
       , 'CodPagPrima'= A.CaCodMonPagPrima 
   
 FROM  CbMdbOpc.dbo.CaVenEncContrato A   
  INNER JOIN  CbMdbOpc.dbo.CaVenDetContrato B ON A.CaNumContrato =  B.CaNumContrato   
  INNER JOIN  VIEW_CLIENTE D with (nolock) ON (A.CaRutCliente  = D.clrut and A.CaCodigo = D.clcodigo )  
  INNER JOIN  VIEW_MONEDA  E with (nolock) ON  B.CaCodMon1     = E.mncodmon  
  INNER JOIN  VIEW_MONEDA  F with (nolock) ON  B.CaCodMon2     = F.mncodmon   
  RIGHT OUTER JOIN VIEW_PAIS    G with (nolock) ON CONVERT(INT,G.codigo_pais) = D.clpais   
  INNER JOIN  #VALOR_MONEDA H ON  A.CaCodMonPagPrima  = H.vmcodigo  
 WHERE A.CaTipoTransaccion <> 'ANULA'  
 AND  A.CaEstado <> 'C'  
 and b.CaFechaVcto>@dfecha
 and 1=2
--@dfecha = CONVERT(CHAR(8),A.CaFechaContrato,112)  



 INSERT INTO  #temp            
 SELECT    TipOpe   
  , NumOpe   
  , RutCli   
  , DigCli  
  , NomCli  
  , FecIni  
  , FecTer  
  , CodMdaRec  
  , NemMonRec  
  , MtoRecibe  
  , CodMdaEnt  
  , NemMonEnt  
  , MtoEntrega  
  , Modal  
  , PreFut  
  , PreSpt   
  , nomprop  
  , dirprop  
  , rutprop  
  , digprop  
  , FecInfo   
  , Codcli  
  , FecPro  
  , Marca  
  , Plazo   
  , Apodera1  
  , Cargo1  
  , Fono1  
  , Apodera2  
  , Cargo2  
  , Fono2  
  , Contador  
  , CanPag  
  , CodPais  
  , NomPais  
  , EmailApo1  
  , Sector  
  , cod_instru  
        , Prima   
        FROM #TEMP_OPC  
  
 
--***************************************OPCIONES**************************************************************  

    
    Select @cuenta = 1    
    While (1=1) Begin  
       If not Exists (Select 1 from #temp Where contador=0 ) Begin  
          Break   
       End  
       Set Rowcount 15  
       Update #temp set contador=@cuenta Where Contador =0  
       Set Rowcount 0  
       Select @cuenta =@cuenta +1  
     END  
    UPDATE #temp set CanPag=@cuenta -1  


    IF NOT EXISTS( SELECT 1 FROM #temp )   
 INSERT INTO  #temp            
 SELECT  'TipOpe'   = ' ',  
   'NumOpe'   = 0,  
   'RutCli'   = 0,  
   'DigCli'   = 0,  
   'NomCli'   = ' ',  
   'FecIni'   = @cfecha ,  
   'FecTer'   = ' '  ,  
   'CpaCodMon'     = 0  ,       
   'CpaNemMon'     = ' '  ,  
   'CpaMonto'      = 0 ,  
   'VtaCodMon'     = 0 ,  
   'VtaNemMon'     = ' ' ,  
   'VtaMonto'      = 0 ,  
   'Modal'    = ' '  ,  
   'PreFut'   = 0 ,  
   'PreSpt'   = 0 ,  
   'nomprop'  = @cnomprop  ,  
   'dirprop'  = @cdirprop  ,  
   'rutprop'  = @nrutprop  ,  
   'digprop'  = @cdigprop  ,  
   'FecInfo'  = @cfecha  ,  
   'codclie'  = @ncodclie      ,  
   'FecPro'   = @cfecpro    ,  
   'Marca'    = ' '    ,   
   'Plazo'    = 0,  
   'Apodera1'  = ISNULL( @ap1nombre , '' ) ,  
   'Cargo1'    = ISNULL( @ap1cargo  , '' ) ,  
   'Fono1'     = ISNULL( @ap1fono   , '' ) ,  
   'Apodera2'  = ISNULL( @ap2nombre , '' ) ,  
   'Cargo2'    = ISNULL( @ap2cargo  , '' ) ,  
   'Fono2'     = ISNULL( @ap2fono   , '' ) ,  
   'Contador'      = 0 ,  
   'CanPag'        = 0 ,  
   'CodPais'       = 0 ,  
   'NomPais'       = ' ' ,  
   'EmailApo1'     = @cEmailApo1 ,  
   'Sector Eco'    = 0,  
   'cod_instru'    = '01',  
   'Prima'         = 0.0    

-- INI COMDER
IF EXISTS(SELECT 1 FROM BDBOMESA.dbo.COMDER_RelacionMarcaComder a, #temp b WHERE a.nReNumOper = b.NumOpe AND a.iReNovacion = 1 AND a.vReEstado = 'V' AND a.dReFecha = @dfecha )
BEGIN
	UPDATE #temp
	SET	NOMCLI	= b.Clnombre
		,DIGCLI	= b.Cldv
		,RUTCLI	= b.Clrut
		--,SectorEco = b.clactivida
   FROM		BDBOMESA.dbo.COMDER_RelacionMarcaComder a, VIEW_CLIENTE b  
   WHERE	a.nReNumOper = #temp.NumOpe
   AND		#temp.RUTCLI = (select acRutComder from MFAC)  
   AND		(a.nReRutCliente = b.clrut and a.nReCodCliente=b.clcodigo )
   AND		a.iReNovacion = 1 
   AND		a.vReEstado = 'V' 
   AND		a.dReFecha = @dfecha
END
-- FIN COMDER


--  SELECT *, 
--	       'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales), 
--		   'RutEntidad' = (SELECT RutEntidad FROM BacParamSuda..Contratos_ParametrosGenerales),
--		   'DigitoVerificador' = (SELECT DigitoVerificador FROM BacParamSuda..Contratos_ParametrosGenerales)
--	  FROM #temp  

	SELECT	
		RutCli			as RutCliente
,		DigCli			as Digito
,		NomCli			as NombreCliente
,		[Sector Eco]	as SectorEco
,		CodPais			as Cod_Pais
,		NomPais			as Nombre_Pais
,		NumOpe			as Numero_Contrato
,		FecIni			as Fecha_inicio
,		FecTer			as Fecha_vcto
,		Plazo			as Plazo
,		Modal			as Modalidad
,		TipOpe			as Tipo_operacion
,		CpaCodMon		as Cod_Moneda_Cmp
,		CpaNemMon		as Nem_Moneda_Cmp
,		CpaMonto		as Mto_compra
,		VtaCodMon		as Cod_Moneda_Vta
,		VtaNemMon		as Nem_Moneda_Vta
,		VtaMonto		as Mto_venta
,		Prima			as Prima_Total
,		PreFut			as Precio_Futuro
,		PreSpt			as Precio_Spot
--,		cod_instru		
	  FROM #temp  
  
  
 END

GO
