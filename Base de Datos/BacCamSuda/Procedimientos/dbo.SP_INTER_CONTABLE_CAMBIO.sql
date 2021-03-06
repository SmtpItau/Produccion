USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTER_CONTABLE_CAMBIO]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_INTER_CONTABLE_CAMBIO]  
AS  
BEGIN   
  
   -- TAG MPNG20060208   
   -- Se genera una tabla temporal con todas las operaciones  
   -- de moneda extranjera distinta de USD, notar que se   
   -- incluyen las del dia y las históricas  
   -- La información de esta tabla temporal se utiliza para  
   -- calcular el Tipo de Cambio para los registros de   
   -- voucher que no sean CLP ni USD.  
   -- TAG MPNG20060209  
   -- Finalmente se decide lo siguiente:  
   -- Se informará el precio de la moneda que se indica   
   -- en el detalle de los voucher de la siguiente manera:  
   -- USD : Precio en que se transó el USD.  
   -- CLP : Precio en que se transó el USD.  
   -- MX (no USD ): Precio, en CLP, en que se transó la moneda  
   -- TAG MPNG20060208   
   -- Se genera una tabla temporal con todas las operaciones  
   -- de moneda extranjera distinta de USD, notar que se   
   -- incluyen las del dia y las históricas  
   -- La información de esta tabla temporal se utiliza para  
   -- calcular el Tipo de Cambio para los registros de   
   -- voucher que no sean CLP ni USD.  
   -- TAG MPNG20060209  
   -- Finalmente se decide lo siguiente:  
   -- Se informará el precio de la moneda que se indica   
   -- en el detalle de los voucher de la siguiente manera:  
   -- USD : Precio en que se transó el USD.  
   -- CLP : Precio en que se transó el USD.  
   -- MX (no USD ): Precio, en CLP, en que se transó la moneda  
  
  
 SET NOCOUNT ON   
  
 SELECT monumope  
 , mocodmon  
 , moparme  
 , mnrrda  
 INTO #MEMO    
 FROM MEMO   
 , VIEW_MONEDA   
 WHERE mnnemo = mocodmon  
 UNION  
 SELECT monumope  
 , mocodmon  
 , moparme  
 , mnrrda  
 FROM MEMOH   
 , VIEW_MONEDA   
 WHERE mnnemo  =  mocodmon  
 AND mocodmon <> 'USD'  
  
 DECLARE @Fecha DATETIME     
   
 SELECT  @Fecha = acfecpro   
 FROM MEAC  
  
/*001*/ SELECT 'TIPOREG' = '1'  
/*002*/ , 'CODOFIC' = '00001'  
/*003*/ , 'AREA'  = '1'  
/*004*/ , 'SECCION' = '00356'  
/*005*/ , 'DIA'  = CASE WHEN LEN(DAY(@Fecha)) = 1 THEN '0' + LTRIM(DAY(@Fecha))  
             ELSE                                 LTRIM(DAY(@Fecha)) END  
/*006*/ , 'mes'  = CASE WHEN LEN(MONTH(@Fecha)) = 1 THEN '0'+ LTRIM(MONTH(@Fecha))  
             ELSE                                  LTRIM(MONTH(@Fecha)) END  
/*007*/ , 'año'  = SUBSTRING(LTRIM(YEAR(@Fecha)),3,2)  
/*008*/ , 'num_voucher' = V.Numero_Voucher  
/*009*/ , 'CUENTADEBE' = CASE WHEN B.Tipo_Monto = 'D' THEN B.Cuenta  
      ELSE                         REPLICATE('0',9) END  
/*010*/ , 'codmoneda' = CASE WHEN b.tipo_monto = 'D' THEN ISNULL((SELECT mncodfox FROM VIEW_MONEDA WHERE mncodmon = b.Valor_Campo),0)  
      ELSE                         '00' END  
/*011*/ , 'DDBE'  = '5'  
/*012*/ , 'MTODEBE' = CASE WHEN B.Tipo_Monto = 'D' THEN B.MONTO    
        ELSE                         REPLICATE('0',15) END  
/*013*/ , 'CLASEDBE' = '0000'  
/*014*/ , 'NOMINATIVODBE' = REPLICATE('0',8)  
/*015*/ , 'REFERENCIADBE' = CASE WHEN B.Tipo_Monto = 'D' THEN V.Numero_Voucher  
      ELSE                         REPLICATE('0',10) END  
/*016*/ , 'CODHABER' = CASE WHEN B.Tipo_Monto = 'H' THEN B.CUENTA  
      ELSE                         REPLICATE('0',9) END  
/*017*/ , 'CODMDHABER' = CASE WHEN b.tipo_monto = 'H' THEN ISNULL((SELECT mncodfox FROM VIEW_MONEDA WHERE mncodmon = b.Valor_Campo),0)  
      ELSE                         '00' END  
/*018*/ , 'HDBE'  = '6'  
/*019*/ , 'MTOHABER' = CASE WHEN B.Tipo_Monto = 'H' THEN B.MONTO  
      ELSE                         REPLICATE('0',15) END  
/*020*/ , 'CLASEHBE' = '0000'  
/*021*/ , 'NOMINATIVOHBE' = '00000000' -- MAP CASE WHEN B.Tipo_Monto = 'H' THEN B.CUENTA  
                                             -- ELSE                         REPLICATE('0',8) END  
/*022*/ , 'REFERENCIAHBE' = CASE WHEN B.Tipo_Monto = 'H' THEN V.Numero_Voucher  
      ELSE                         REPLICATE('0',10) END  
/*023*/ , 'EMISORA' = REPLICATE('0',5)  
/*024*/ , 'RECPTORA' = REPLICATE('0',5)  
/*025*/ , 'CERO'  = REPLICATE('0',126)  
/*026*/ , 'TCCAMBIO'      =  ROUND(V.tipo_cambio  *   
                     ( CASE WHEN b.Valor_Campo NOT IN ( '13', '999' )  THEN ISNULL( ( SELECT CASE WHEN mnrrda = 'D' THEN 1.0 / moparme    
                                                                                                                           ELSE moparme END    
                                                                                              FROM #MEMO  WHERE  monumope = V.Operacion ) , 0 )  
                                                                              ELSE 1.0 END ) -- TAG MPNG20060208 -- TAG MPNG20060209  
                                                             , 4 )    
 -- INTO #InterfazGL53
 FROM BAC_CNT_VOUCHER    V    
  LEFT JOIN BAC_CNT_DETALLE_VOUCHER B ON V.numero_voucher = B.numero_voucher   
                                                          AND V.Operacion = B.Operacion   
                                                          AND V.tipo_operacion = B.tipo_operacion  
  LEFT JOIN BACPARAMSUDA..PLAN_DE_CUENTA C ON B.cuenta  = C.cuenta  
 WHERE V.Fecha_Contable = @Fecha  
 ORDER   
 BY B.Numero_Voucher   
 , B.Correlativo  

    /* 
   DECLARE	@IndiceGL53 INT
   ,		@FechaEjecucion  datetime
   ,	@Producto INT
   
   
   SELECT @IndiceGL53 = 0
   ,	@FechaEjecucion =convert(datetime,CONVERT(varchar(10), GETDATE(), 103),103) ---dateadd(day,1,GETDATE())
   , @Producto = 53
      
	IF NOT EXISTS(SELECT 1 FROM BacParamSuda.dbo.IndiceRelacionGLIBs WHERE Producto = @Producto ) BEGIN
		INSERT INTO BacParamSuda.dbo.IndiceRelacionGLIBs (Producto,FechaEjecucion,IndiceGL) VALUES (@Producto,@FechaEjecucion,0)
	END   
      
   IF EXISTS(SELECT 1 FROM BacParamSuda.dbo.IndiceRelacionGLIBs WHERE Producto = @Producto )  BEGIN
   
   
		DELETE	baccamsuda.dbo.RelacionGlIbs
		WHERE	FechaEjecucion  = @FechaEjecucion 
		
		SELECT  @IndiceGL53 =  IndiceGL  
		FROM	BacParamSuda.dbo.IndiceRelacionGLIBs
		WHERE	Producto = @Producto
						
		INSERT  baccamsuda.dbo.RelacionGlIbs
		SELECT	DISTINCT @Producto
		,		@FechaEjecucion	
		,		convert(int,REFERENCIAHBE)
		,		0
		FROM   #InterfazGL53
		WHERE convert(int,REFERENCIAHBE) <> 0
		
		
		UPDATE  baccamsuda.dbo.RelacionGlIbs
		SET		NumeroGL = @IndiceGL53
		,		@IndiceGL53 = @IndiceGL53 + 1	
		WHERE	Producto = @Producto
		AND		NumeroGl  = 0
		
		
		UPDATE	BacParamSuda.dbo.IndiceRelacionGLIBs
		SET		IndiceGl = @IndiceGL53
		,		FechaEjecucion  = @FechaEjecucion
		WHERE   Producto  = @Producto
	
	END
	
	UPDATE #InterfazGL53
	SET REFERENCIAHBE = a.NumeroGL
	FROM	baccamsuda.dbo.RelacionGlIbs a
	WHERE a.NumeroVoucher = REFERENCIAHBE 


	INSERT into BacCamSuda.dbo.InterfazContableGL53
	SELECT @FechaEjecucion
	,		*
	FROM	#InterfazGL53

	UPDATE	BacCamSuda.dbo.InterfazContableGL53 -- select count(1) from BacCamSuda.dbo.InterfazContableGL53 
	SET		REFERENCIAHBE = a.NumeroGL
	FROM	baccamsuda.dbo.RelacionGlIbs a
	WHERE	a.FechaEjecucion = @FechaEjecucion
	AND		a.NumeroVoucher  = num_voucher 
	

	SELECT * FROM  #InterfazGL53
    */ 
 SET NOCOUNT OFF  
  
END  
GO
