USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTER_CONTABLE]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_INTER_CONTABLE]  
   (   @iMoneda   INTEGER   )  
AS  
BEGIN   
 
   SET NOCOUNT ON  

   DECLARE @iContador   NUMERIC(9)  

   SELECT  @iContador       = 0.0  
   SELECT  @iContador       = COUNT(1)  
   FROM    BacSwapSuda..BAC_CNT_VOUCHER                   v with(nolock)  
           LEFT JOIN BacSwapSuda..BAC_CNT_DETALLE_VOUCHER d with(nolock) ON v.numero_voucher = d.numero_voucher  
   ,       SWAPGENERAL with(nolock)  
   WHERE   v.fecha_ingreso  = fechaproc  

  
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
END     ,      /*20*/ 'NI05HCLA'  = REPLICATE('0', 4)  
   ,      /*21*/ 'NI05HNOM'  = REPLICATE('0', 8)  
   ,      /*22*/ 'NI05HREF'  = CASE WHEN d.Tipo_Monto = 'H' THEN CONVERT(CHAR(10),REPLICATE('0', 10 - LEN(LTRIM(v.numero_voucher))) + LTRIM(v.numero_voucher))  
                                    ELSE                         CONVERT(CHAR(10),REPLICATE('0', 10))  
                               END  
   ,      /*23*/ 'NI05OEMI'  = REPLICATE('0',5)  
   ,      /*24*/ 'NI05OREC'  = REPLICATE('0',5)  
   ,      /*25*/ 'NI05OFILL' = REPLICATE('0',126)  
   ,      /*26*/ 'NI05TICP'  = '00000000000'  
   ,      /*27*/ 'CANTREG'   = @iContador  
   --INTO		#InterfazGL52
   FROM   BacSwapSuda..BAC_CNT_VOUCHER                    v with(nolock)  
          INNER JOIN BacSwapSuda..BAC_CNT_DETALLE_VOUCHER d with(nolock) ON v.numero_voucher = d.numero_voucher  
          LEFT  JOIN BacParamSuda..PLAN_DE_CUENTA   c with(nolock) ON c.cuenta         = d.cuenta  
          LEFT  JOIN BacParamSuda..MONEDA                 m with(nolock) ON m.mncodmon       = convert(integer,d.moneda)  
   ,      SWAPGENERAL with(nolock)  
   WHERE  v.fecha_ingreso    = fechaproc  
	--   AND   ((@iMoneda = 0 AND d.moneda <> 999) OR (@iMoneda = 1 AND d.moneda = 999))  
   ORDER BY d.numero_voucher , d.correlativo  

   /*
   DECLARE	@IndiceGL52 INT
   ,		@FechaEjecucion  datetime
   ,		@Producto	INT

   
   SELECT @IndiceGL52 = 0
   ,	@FechaEjecucion = convert(datetime,CONVERT(varchar(10), GETDATE(), 103),103)
   ,	@Producto  = 52
      
	IF NOT EXISTS(SELECT 1 FROM BacParamSuda.dbo.IndiceRelacionGLIBs WHERE Producto = @Producto  ) BEGIN
		INSERT INTO BacParamSuda.dbo.IndiceRelacionGLIBs (Producto,FechaEjecucion,IndiceGL) VALUES (@Producto,@FechaEjecucion,0)
	END   
      
   IF EXISTS(SELECT 1 FROM BacParamSuda.dbo.IndiceRelacionGLIBs WHERE Producto = @Producto    )  BEGIN
   
   
		DELETE	bacswapsuda.dbo.RelacionGlIbs
		WHERE	Producto	= @Producto 
		AND		FechaEjecucion  = @FechaEjecucion 
		
		
		SELECT  @IndiceGL52 =  IndiceGL  
		FROM	BacParamSuda.dbo.IndiceRelacionGLIBs
		WHERE	Producto = @Producto 
								
		INSERT  bacswapsuda.dbo.RelacionGlIbs
		SELECT	DISTINCT @Producto 
		,		@FechaEjecucion	
		,		convert(int,NI05DREF)
		,		0
		FROM   #InterfazGL52
		WHERE convert(int,NI05DREF) <> 0
		
		
		UPDATE  bacswapsuda.dbo.RelacionGlIbs
		SET		NumeroGL = @IndiceGL52
		,		@IndiceGL52 = @IndiceGL52 + 1	
		WHERE	Producto = @Producto 
		AND		NumeroGl  = 0
		
		
		UPDATE	BacParamSuda.dbo.IndiceRelacionGLIBs
		SET		IndiceGl = @IndiceGL52
		,		FechaEjecucion  = @FechaEjecucion
		WHERE   Producto  = @Producto 
	
	END
			
	----SELECT * FROM BacParamSuda.dbo.IndiceRelacionGLIBs
	----SELECT * FROM  bacswapsuda.dbo.RelacionGlIbs
	----SELECT getdate() AS 'FechaProceso'  ,* INTO  InterfazGL52 FROM  #InterfazGL52


	INSERT into BacSwapSuda.dbo.InterfazContableGL52
	SELECT	@FechaEjecucion
	,		*
	FROM	#InterfazGL52

	UPDATE	#InterfazGL52
	SET		NI05HREF = a.NumeroGL
	FROM	bacswapsuda.dbo.RelacionGlIbs a
	WHERE a.NumeroVoucher = NI05HREF 

	UPDATE	BacSwapSuda.dbo.InterfazContableGL52
	SET		NI05HREF	 = convert(char(10),a.NumeroGL)
	FROM	bacswapsuda.dbo.RelacionGlIbs a
	WHERE	a.FechaEjecucion = @FechaEjecucion
	AND		a.NumeroVoucher  = CONVERT(INT,NI05DREF )

  	SELECT * FROM  #InterfazGL52
    */
  
END  

GO
