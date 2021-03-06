USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGA_TABLA_CTACTEBCCH]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CARGA_TABLA_CTACTEBCCH]
AS 
BEGIN

   SET NOCOUNT ON

   DECLARE @fc_proceso  DATETIME
   DECLARE @Fecha    DATETIME
   DECLARE @Fecha24  DATETIME
   DECLARE @Fecha48  DATETIME
   DECLARE @Fecha72  DATETIME

   SELECT  @fc_proceso = acfecproc 
   FROM    MDAC

/*   SELECT  @fc_proceso = acfecpro
   FROM    VIEW_MEAC*/


/*   SELECT  @fc_proceso = acfecproc
   FROM    VIEW_MFAC*/




   EXECUTE  sp_valuta_habil @fc_proceso,0,@Fecha output
   EXECUTE  sp_valuta_habil @fc_proceso,1,@Fecha24 output
   EXECUTE  sp_valuta_habil @fc_proceso,2,@Fecha48 output
   EXECUTE  sp_valuta_habil @fc_proceso,3,@Fecha72 output



--  select @Fecha,@Fecha24,@Fecha48,@Fecha72

   /* ** Crea tablas Temporales para los Movimientos ** */

CREATE TABLE #TEMP_CTACTEBCCH
   (   	 fecha 			DATETIME       NOT NULL		
      	,sistema 		CHAR(03)       NOT NULL		
      	,tipo_operacion		CHAR(05)       NOT NULL		
	,numero_operacion 	NUMERIC(9,0)   NOT NULL		
	,tipo_mercado		CHAR(12)       NOT NULL		
	,monto_operacion 	NUMERIC(19,0)  NOT NULL		
	,rut_cliente		NUMERIC(9,0)   NOT NULL		
	,codigo_cliente		NUMERIC(9,0)   NOT NULL		
	,fecha_valuta_Ent	DATETIME       NOT NULL		
	,fecha_valuta_Rec	DATETIME       NOT NULL		
	,for_pag_entre		NUMERIC(5,0)   NOT NULL		
	,glosa_entre		CHAR(30)       NOT NULL		
	,for_pag_recib 		NUMERIC(5,0)   NOT NULL		
	,glosa_recib		CHAR(30)       NOT NULL		
	,estado_Pago_Efect	CHAR(02)       NOT NULL
	,estado_operacion	CHAR(01)       NOT NULL
	,indica_mov_pesos	CHAR(01)       NOT NULL
	,moneda			NUMERIC(5,0)   NOT NULL
	,forma_pago		NUMERIC(5,0)   NOT NULL
	,fecha_efectiva          DATETIME       NOT NULL 
   )

CREATE TABLE #TMPBTR
   (     fecha 			DATETIME       NOT NULL		
      	,sistema 		CHAR(03)       NOT NULL		
      	,tipo_operacion		CHAR(05)       NOT NULL		
	,numero_operacion 	NUMERIC(9,0)   NOT NULL		
	,tipo_mercado		CHAR(12)       NOT NULL		
	,monto_operacion 	NUMERIC(19,0)  NOT NULL		
	,rut_cliente		NUMERIC(9,0)   NOT NULL		
	,codigo_cliente		NUMERIC(9,0)   NOT NULL		
	,fecha_valuta_Ent	DATETIME       NOT NULL		
	,fecha_valuta_Rec	DATETIME       NOT NULL		
	,for_pag_entre		NUMERIC(5,0)   NOT NULL		
	,glosa_entre		CHAR(30)       NOT NULL		
	,for_pag_recib 		NUMERIC(5,0)   NOT NULL		
	,glosa_recib		CHAR(30)       NOT NULL		
	,estado_Pago_Efect	CHAR(02)       NOT NULL
	,estado_operacion	CHAR(01)       NOT NULL
	,indica_mov_pesos	CHAR(01)       NOT NULL
	,moneda			NUMERIC(5,0)   NOT NULL
	,forma_pago		NUMERIC(5,0)   NOT NULL
	,fecha_efectiva         DATETIME       NOT NULL 
   )
   
   /* ** Inserta los movimientos de Forward ** */

-- select *  from CTACTEBCCH
-- select *  from  view_mfac
-- select *  from  view_mfmo
-- select catipoper ,cafecvcto,cafpagomn,cafpagomx, *  from view_mfca where catipmoda ='c' and cafecha ='20040603'


   INSERT INTO #TEMP_CTACTEBCCH
   SELECT cafecvcto
   ,      'BFW'
   ,	  catipoper
   ,      canumoper
   ,      cacodpos1
   ,      ABS(camtocomp)
   ,      cacodigo
   ,      cacodcli
   ,      isnull(case when (select diasvalor  from view_forma_de_pago  where cafpagomn =codigo) = 1 then @fecha24
	       when (select diasvalor  from view_forma_de_pago  where cafpagomn =codigo) = 2 then @fecha48	
	       when (select diasvalor  from view_forma_de_pago  where cafpagomn =codigo) = 3 then @fecha72
	  else @fecha end, '')
   ,      isnull(case when (select diasvalor  from view_forma_de_pago  where cafpagomx =codigo) = 1 then @fecha24
	       when (select diasvalor  from view_forma_de_pago  where cafpagomx =codigo) = 2 then @fecha48	
	       when (select diasvalor  from view_forma_de_pago  where cafpagomx =codigo) = 3 then @fecha72
	  else @fecha end, '')


--   ,   	  isnull(DATEADD(day, (select diasvalor  from view_forma_de_pago  where cafpagomn =codigo), @fc_proceso),'')
--   ,   	  isnull(DATEADD(day, (select diasvalor  from view_forma_de_pago  where cafpagomx =codigo), @fc_proceso),'')
   , cafpagomn
   ,	  isnull((select glosa from  view_forma_de_pago where codigo =cafpagomn),'')
   ,      cafpagomx
   ,	  isnull((select glosa from  view_forma_de_pago where codigo =cafpagomx),'')
   ,	  ''
   ,	  caestado
   ,	  (case when catipoper ='C' then 'E' else 'I' end)	
   ,      cacodmon2
   ,      isnull(cafpagomn,0)		  	
   ,	  isnull(DATEADD(day, (select diasvalor  from view_forma_de_pago  where cafpagomn =codigo), @fc_proceso) ,0)		  
--   ,	  isnull((case when catipoper ='C' then cafpagomn else cafpagomx end),0)		  
--   ,	  isnull((case when catipoper ='C' then DATEADD(day, (select diasvalor  from view_forma_de_pago  where cafpagomn =codigo), @fc_proceso) else DATEADD(day, (select diasvalor  from view_forma_de_pago  where cafpagomx =codigo), @fc_proceso)end),0)		  









   FROM	  VIEW_MFCA
   WHERE (cacodpos1 = 1 OR cacodpos1 = 3)
--   AND    camtocomp < 0
     AND    cacodmon2 IN(999,998,994) 		
   AND    cafpagomn not IN(11,12,13,14)
   AND    cafecvcto   = @fc_proceso
   AND    caestado <> 'A'
   AND    catipmoda = 'C' 


   /* ** Inserta los movimientos de Spot [ Entregamos ] ** */

--select *  from CTACTEBCCH




   INSERT INTO #TEMP_CTACTEBCCH
   SELECT mofech
   ,      'BCC'
   ,      motipope
   ,	  monumope	
   ,      motipmer
   ,      momonpe
   ,      morutcli
   ,      mocodcli
   ,      movaluta1
   ,      movaluta2
   ,	  moentre
   ,     (select glosa from view_forma_de_pago where codigo=moentre)
   ,      morecib
   ,     (select glosa from view_forma_de_pago where codigo=morecib)
   ,      ''
   ,	  moestatus
   ,	  (case when motipope = 'C' then 'E' else 'I' end) 	
   ,      999   
   ,	 (case when motipope = 'C' then moentre else morecib end)
   ,	 (case when motipope = 'C' then movaluta1 else movaluta2 end)

   FROM	  VIEW_MEMO

   WHERE  motipmer IN('PTAS','EMPR')
   AND    motipope = 'C'  --IN('C','V')
--   AND    mocodmon = 'USD'
   AND    mocodcnv = 'CLP'    --mnnemo  --> Moneda Conversion CLP
   AND    moentre not IN(11,12,13,14)
   AND    mofech   = @fc_proceso
   AND    moestatus<>'A'



   /* ** Inserta los movimientos de Spot [ Recibimos ] ** */
     INSERT INTO #TEMP_CTACTEBCCH
   SELECT mofech
   ,      'BCC'
   ,      motipope
   ,	  monumope	
   ,      motipmer
   ,      momonpe
   ,      morutcli
   ,      mocodcli
   ,      movaluta1
   ,      movaluta2
   ,	  morecib
   ,     (select glosa from view_forma_de_pago where codigo=morecib)
   ,      moentre
   ,     (select glosa from view_forma_de_pago where codigo=moentre)
   ,      ''
   ,	  moestatus
   ,	  (case when motipope = 'C' then 'E' else 'I' end) 	
   ,      999   
   ,	 (case when motipope = 'C' then moentre else morecib end)
   ,	 (case when motipope = 'C' then movaluta1 else movaluta2 end)

   FROM	  VIEW_MEMO

   WHERE  motipmer IN('PTAS','EMPR')
   AND    motipope = 'V'  
   AND    mocodmon = 'USD'
   AND    mocodcnv = 'CLP'    --mnnemo  --> Moneda Conversion CLP
   AND    morecib not IN(11,12,13,14)
   AND    mofech   = @fc_proceso
   AND    moestatus<>'A'


   /* ** Inserta los movimientos de Renta Fija [ INTERBANCARIOS , PACTOS ] ** */
   --  se sacan operaciones de renta fija para agruparlas por Nro Operacion
--------------------------------------------------------------------------------------------
--SELECT *  FROM VIEW_MDMO

 INSERT INTO #TMPBTR
 SELECT mofecpro
   ,	'BTR'
   ,    motipoper
   ,    monumoper
   ,    motipoper
   ,    'movpresen' = isnull(case motipoper 
		WHEN 'CI'  THEN  SUM(movpresen)                
		WHEN 'IB'  THEN  SUM(movpresen)
		WHEN 'RC'  THEN  SUM(movalvenp)
		WHEN 'RCA'  THEN  SUM(movalvenp)
		WHEN 'VI'  THEN  SUM(movalvenp)
		WHEN 'RV'  THEN  SUM(movalvenp)
		WHEN 'RVA'  THEN  SUM(movalvenp)
		END,0)
   ,    morutcli
   ,    mocodcli
   ,      isnull(case when (select diasvalor  from view_forma_de_pago  where moforpagi =codigo) = 1 then @fecha24
	       when (select diasvalor  from view_forma_de_pago  where moforpagi =codigo) = 2 then @fecha48	
	       when (select diasvalor  from view_forma_de_pago  where moforpagi =codigo) = 3 then @fecha72
	  else @fecha end, '')
   ,      isnull(case when (select diasvalor  from view_forma_de_pago  where moforpagv =codigo) = 1 then @fecha24
	      when (select diasvalor  from view_forma_de_pago  where moforpagv =codigo) = 2 then @fecha48	
	       when (select diasvalor  from view_forma_de_pago  where moforpagv =codigo) = 3 then @fecha72
	  else @fecha end, '')


--   ,   	isnull(DATEADD(day, (select diasvalor  from view_forma_de_pago  where moforpagi =codigo), @fc_proceso),'')
--   ,   	isnull(DATEADD(day, (select diasvalor  from view_forma_de_pago  where moforpagv =codigo), @fc_proceso),'')
   ,    moforpagi
   ,	isnull((select glosa from  view_forma_de_pago where codigo = moforpagi),'')
   ,	moforpagv
   ,	isnull((select glosa from  view_forma_de_pago where codigo = moforpagv),'')
   ,	''	
   ,	mostatreg
   ,	(case when moinstser ='ICAP' then 'I' 
	      when motipoper ='VI'   then 'I'
	else 'E' end)
   ,    momonpact -- momonemi
   ,	isnull((case when moinstser ='ICAP' then moforpagi 
		     when motipoper ='ICOL'   then moforpagi 
		     when motipoper ='VI'   then moforpagi 
		     when motipoper ='CI'   then moforpagi 
		else moforpagv end),0)		  
   ,	isnull((case when moinstser ='ICAP' then DATEADD(day, (select diasvalor  from view_forma_de_pago  where moforpagi =codigo), @fc_proceso) 
                     when motipoper ='ICOL' then DATEADD(day, (select diasvalor  from view_forma_de_pago  where moforpagi =codigo), @fc_proceso)
                     when motipoper ='VI' then DATEADD(day, (select diasvalor  from view_forma_de_pago  where moforpagi =codigo), @fc_proceso)
                     when motipoper ='CI' then DATEADD(day, (select diasvalor  from view_forma_de_pago  where moforpagi =codigo), @fc_proceso)
		else DATEADD(day, (select diasvalor  from view_forma_de_pago  where moforpagv =codigo), @fc_proceso)end),0)		  

   FROM	  MDMO
   WHERE (motipoper IN('CI','RC','RCA','VI','RV','RVA')
      OR  moinstser IN ('ICAP','ICOL'))
      AND momonpact IN(999,998,994) 	
      AND mofecpro = @fc_proceso
      AND mostatreg<>'A'

   GROUP BY mofecpro , motipoper , monumoper
	   ,morutcli , mocodcli	 , moforpagi , moforpagv, mostatreg, moinstser, momonpact
   	   ,momonemi 





   /* ** Inserta los movimientos de Renta Fija [ CARTERA PROPIA ] ** */
   INSERT INTO #TMPBTR
   SELECT mofecpro	
   ,	  'BTR'
   ,      motipoper	
   ,      monumoper	
   ,      motipoper	
   ,      'movpresen' =isnull( SUM(movpresen),0)
   ,      morutcli	
   ,      mocodcli	
   ,      isnull(case when (select diasvalor  from view_forma_de_pago  where moforpagi =codigo) = 1 then @fecha24
	       when (select diasvalor  from view_forma_de_pago  where moforpagi =codigo) = 2 then @fecha48	
	       when (select diasvalor  from view_forma_de_pago  where moforpagi =codigo) = 3 then @fecha72
	  else @fecha end, '')
   ,      isnull(case when (select diasvalor  from view_forma_de_pago  where moforpagv =codigo) = 1 then @fecha24
	       when (select diasvalor  from view_forma_de_pago  where moforpagv =codigo) = 2 then @fecha48	
	       when (select diasvalor  from view_forma_de_pago  where moforpagv =codigo) = 3 then @fecha72
	  else @fecha end, '')

--   ,   	isnull(DATEADD(day, (select diasvalor  from view_forma_de_pago  where moforpagi =codigo), @fc_proceso),'')
--   ,   	isnull(DATEADD(day, (select diasvalor  from view_forma_de_pago  where moforpagv =codigo), @fc_proceso),'')
   ,    moforpagi
   ,	isnull((select glosa from  view_forma_de_pago where codigo = moforpagi),'')
   ,	moforpagv
   ,	isnull((select glosa from  view_forma_de_pago where codigo = moforpagv),'')
   ,	''
   ,	mostatreg
   ,	(case when motipoper ='CP' then 'E' else 'I' end)		
   ,   momonpact	
  ,	isnull(moforpagi ,0)		  
   ,	isnull(DATEADD(day, (select diasvalor  from view_forma_de_pago  where moforpagi =codigo), @fc_proceso) ,0)		  
--   ,	isnull((case when motipoper ='CP' then moforpagi else moforpagv end),0)		  
--   ,	isnull((case when motipoper ='CP' then DATEADD(day, (select diasvalor  from view_forma_de_pago  where moforpagi =codigo), '20040603') else DATEADD(day, (select diasvalor  from view_forma_de_pago  where moforpagv =codigo), @fc_proceso)end),0)		  

   FROM	  MDMO
   WHERE  motipoper IN('CP','VP')	
   AND    mofecpro = @fc_proceso
   AND    mostatreg<>'A'
   AND    momonemi in (999,994,998)		
   GROUP BY mofecpro , motipoper , monumoper
   ,        morutcli , mocodcli	 , moforpagi ,moforpagv, mostatreg, momonpact
   ORDER BY monumoper

   UPDATE #TMPBTR 
   SET  tipo_mercado = moinstser
   FROM	  #TMPBTR  AS a
   ,      MDMO	   AS b
   WHERE  b.monumoper = a.numero_operacion 
   AND    b.moinstser IN('ICOL','ICAP')




   /* ** Inserta los movimientos de Renta Fija [ VCTOS. ] ** */
   -- se agregan recompras
   INSERT INTO #TMPBTR
   SELECT rsfecha		
   ,	  'BTR'	
   ,      rsinstser	
   ,      rsnumoper	
   ,      rsinstser	
   ,      isnull(SUM(rsvppresenx),0)	
   ,      rsrutcli	
   , rscodcli	

   ,      isnull(case when (select diasvalor  from view_forma_de_pago  where rsforpagi =codigo) = 1 then @fecha24
	       when (select diasvalor  from view_forma_de_pago  where rsforpagi =codigo) = 2 then @fecha48	
	       when (select diasvalor  from view_forma_de_pago  where rsforpagi =codigo) = 3 then @fecha72
	  else @fecha end, '')
   ,      isnull(case when (select diasvalor  from view_forma_de_pago  where rsforpagv =codigo) = 1 then @fecha24
	       when (select diasvalor  from view_forma_de_pago  where rsforpagv =codigo) = 2 then @fecha48	
	       when (select diasvalor  from view_forma_de_pago  where rsforpagv =codigo) = 3 then @fecha72
	  else @fecha end, '')

--   ,   	isnull(DATEADD(day, (select diasvalor  from view_forma_de_pago  where rsforpagi =codigo), @fc_proceso),'')
--   ,   	isnull(DATEADD(day, (select diasvalor  from view_forma_de_pago  where rsforpagv =codigo), @fc_proceso),'')
   ,    rsforpagi
   ,	isnull((select glosa from  view_forma_de_pago where codigo = rsforpagi),'')
   ,	rsforpagv
   ,	isnull((select glosa from  view_forma_de_pago where codigo = rsforpagv),'')
   ,	''
   ,	''
   ,	(case when rsinstser ='ICOL' then 'I' else 'E' end)
   ,    rsmonpact  
   ,	isnull(rsforpagv ,0)		     
   ,	isnull(DATEADD(day, (select diasvalor  from view_forma_de_pago  where rsforpagv =codigo), @fc_proceso),0)		  

--   ,	isnull((case when rsinstser ='ICAP' then rsforpagi else rsforpagv end),0)		     
--   ,	isnull((case when rsinstser ='ICAP' then DATEADD(day, (select diasvalor  from view_forma_de_pago  where rsforpagi =codigo), @fc_proceso) 
--  		else DATEADD(day, (select diasvalor  from view_forma_de_pago  where rsforpagv =codigo), @fc_proceso)end),0)		  
-- select * from mdrs where rsnumoper =43700 and rstipoper ='vc' and rsfecha ='20040802'
   FROM   MDRS


   WHERE  rsinstser  in ('ICAP','ICOL')
          AND  rstipoper  = 'VC'
	  AND  rsmonpact  IN(999,998,994) 
          AND  rsfecha    = @fc_proceso
   GROUP BY rsfecha  , rsinstser , rstipoper , rsnumoper
   ,        rsrutcli , rscodcli	, rsforpagi , rsforpagv , rsmonpact
   ,        rsmonemi , rsfecinip



   /* ** Inserta los movimientos de Renta Fija [ VCTOS.CUPON ] ** */
   -- se agregan recompras


   INSERT INTO #TMPBTR
   SELECT rsfecha		
   ,	  'BTR'	
   ,      rstipoper	
   ,      rsnumoper	
   ,      rstipoper
   ,      isnull(SUM(rsvppresenx),0)	
   ,      rsrutcli	
   , rscodcli	

   ,      isnull(case when (select diasvalor  from view_forma_de_pago  where rsforpagi =codigo) = 1 then @fecha24
	       when (select diasvalor  from view_forma_de_pago  where rsforpagi =codigo) = 2 then @fecha48	
	       when (select diasvalor  from view_forma_de_pago  where rsforpagi =codigo) = 3 then @fecha72
	  else @fecha end, '')
 ,     isnull(case when (select diasvalor  from view_forma_de_pago  where rsforpagv =codigo) = 1 then @fecha24
	       when (select diasvalor  from view_forma_de_pago  where rsforpagv =codigo) = 2 then @fecha48	
	       when (select diasvalor  from view_forma_de_pago  where rsforpagv =codigo) = 3 then @fecha72
	  else @fecha end, '')

--   ,   	isnull(DATEADD(day, (select diasvalor  from view_forma_de_pago  where rsforpagi =codigo), @fc_proceso),'')
--   ,   	isnull(DATEADD(day, (select diasvalor  from view_forma_de_pago  where rsforpagv =codigo), @fc_proceso),'')
   ,    129
   ,	isnull((select glosa from  view_forma_de_pago where codigo = 129),'')
   ,	129
   ,	isnull((select glosa from  view_forma_de_pago where codigo = 129),'')
   ,	''
   ,	''
   ,	(case when rsinstser ='CP' then 'I' else 'E' 	end)
   ,    rsmonpact  
   ,	129	 --isnull(rsforpagv ,0)		     
   ,	isnull(DATEADD(day, (select diasvalor  from view_forma_de_pago  where 129 =codigo), @fc_proceso),0)		  

--   ,	isnull((case when rsinstser ='ICAP' then rsforpagi else rsforpagv end),0)		     
--   ,	isnull((case when rsinstser ='ICAP' then DATEADD(day, (select diasvalor  from view_forma_de_pago  where rsforpagi =codigo), @fc_proceso) 
--  		else DATEADD(day, (select diasvalor  from view_forma_de_pago  where rsforpagv =codigo), @fc_proceso)end),0)		  

   FROM   MDRS


   WHERE       rstipoper  = 'VC'
	  AND  rstipopero IN ('CP','VI') 
	  AND  rscartera IN (111,114) 
	  AND  rsmonemi  IN(999,998,994) 
          AND  rsfecha    = @fc_proceso
   GROUP BY rsfecha  , rsinstser , rstipoper , rsnumoper
   ,        rsrutcli , rscodcli	, rsforpagi , rsforpagv , rsmonpact
   ,        rsmonemi , rsfecinip









   /* ** Traspasa operaciones para generar operaciones LBTR ** */
   --  se ingresan a tablas temporal para pasar luego a CTACTEBCCH
   INSERT INTO #TEMP_CTACTEBCCH
   SELECT fecha
   ,      sistema
   ,      tipo_operacion
   ,      numero_operacion
   ,      tipo_mercado
   ,      sum(monto_operacion)
   ,      rut_cliente
   ,      codigo_cliente
   ,	  fecha_valuta_Ent	
   ,	  fecha_valuta_Rec
   ,	  for_pag_entre
   , 	  glosa_entre
   ,	  for_pag_recib
   , 	  glosa_recib
   ,	  estado_Pago_Efect
   ,	  estado_operacion
   ,	  indica_mov_pesos
   ,	  moneda
   ,	  forma_pago
   ,	  fecha_efectiva

   FROM	  #TMPBTR
	  	
   group by  fecha
   ,      sistema
   ,      tipo_operacion
   ,      numero_operacion
   ,      tipo_mercado
   ,      rut_cliente
   ,      codigo_cliente
   ,	  fecha_valuta_Ent	
   ,	  fecha_valuta_Rec
   ,	  for_pag_entre
   , 	  glosa_entre
   ,	  for_pag_recib
   , 	  glosa_recib
   ,	  estado_Pago_Efect
   ,	  estado_operacion
   ,	  indica_mov_pesos
   ,	  moneda
   ,	  forma_pago
   ,	  fecha_efectiva






   DELETE #TEMP_CTACTEBCCH
   FROM	  #TEMP_CTACTEBCCH       a
   ,      VIEW_CTACTEBCCH        b
   WHERE  a.fecha	     = a.fecha
   AND    a.sistema	     = b.sistema
   AND    a.tipo_operacion   = b.tipo_operacion
   AND    a.numero_operacion = b.numero_operacion


--------------------------------------------------------------------------------------------

   /* ** Traspasa operaciones para generar operaciones CTACTEBCCH** */   





   INSERT INTO VIEW_CTACTEBCCH
   SELECT fecha 			
      	,sistema 		
      	,tipo_operacion
	,numero_operacion 	
	,tipo_mercado		
	,monto_operacion 	
	,rut_cliente		
	,codigo_cliente		
	,fecha_valuta_Ent	
	,fecha_valuta_Rec	
	,for_pag_entre		
	,glosa_entre		
	,for_pag_recib 		
	,glosa_recib		
	,estado_Pago_Efect	
	,estado_operacion	
	,indica_mov_pesos	
	,moneda			
	,forma_pago		
	,fecha_efectiva         
   FROM   #TEMP_CTACTEBCCH
   ORDER BY sistema , numero_operacion



   SET NOCOUNT OFF

END

-- SELECT *  FROM VIEW_CTACTEBCCH where sistema ='bcc'
-- SELECT *  FROM VIEW_MFCA WHERE  CAFECVCTO ='20040611'
-- SELECT *  FROM  MDAC
--  select * from sp_help CTACTEBCCH
-- select * from view_forma_de_pago
-- select * from mdrs where rsfecha ='20040802'


GO
