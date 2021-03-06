USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_HEDGE_CARGA_CAMPOMX]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_HEDGE_CARGA_CAMPOMX]    @sistema 	 CHAR(1)
     , @cacodpos1   CHAR(1)  
     , @catipoper   CHAR(1)  
     , @cTipoValor  CHAR(1)   
     , @mnnemo1   CHAR(3) = ''  
     , @mnnemo2   CHAR(3) = ''  
     , @fechaconsulta CHAR(8) = ''  
     , @nombrecampo   CHAR(20) = ''  
     , @groupcampo    CHAR(20) = ''  
AS  
BEGIN  
 DECLARE @cfecha    CHAR(8)  
 DECLARE @vcampo    VARCHAR(100)  
 DECLARE @vsql      VARCHAR(2000)  
 DECLARE @vSistema  VARCHAR(50)  
 DECLARE @vProducto VARCHAR(50)  
   
 ---CREATE TABLE #MONEDASMX (CODIGO CHAR(4),VALOR FLOAT,DESCRIPCION CHAR (15))  
 SET @cfecha = LTRIM(RTRIM(@fechaconsulta))  
  
	-->Se otiene el nombre del campo a utilizar
 SELECT @vcampo = MANT.Variable    
 FROM TBL_HEDGE_MANT MANT WITH(NOLOCK)  
 WHERE MANT.cod_origen  = @sistema  
   AND MANT.tipo_valor  = @ctipovalor  
   AND MANT.tipo_ope    = @catipoper  
   AND MANT.moneda  <> 'USD'  
   AND MANT.imputacion  <> 'A'  
 GROUP BY MANT.Variable  
  
 IF @vcampo IS NULL  
 BEGIN    
  SELECT @vSistema = tbglosa FROM BacParamSuda.dbo.tabla_general_detalle WITH(NOLOCK) WHERE tbcateg = 8601 and tbcodigo1 = @sistema  
  SELECT @vProducto = descripción FROM tbl_hedge_producto WITH(NOLOCK) WHERE Codigo_Origen = @sistema AND Codigo = @cacodpos1  
  
  SELECT -1 , 'Error no se encuentra campo en mantenedor de criterios. '  
       +' Sistema:'      + LTRIM(RTRIM(@vSistema))  
       +',Producto:'     + LTRIM(RTRIM(@vProducto))  
       +',Tipo Valor:'   + CASE WHEN @ctipovalor = 'A' THEN 'ACTIVO'   
           WHEN @ctipovalor = 'P' THEN 'PASIVO'  
             END  
       +',Tipo Operac.:' + CASE WHEN @catipoper = 'C' THEN 'COMPRA'   
           WHEN @catipoper = 'V' THEN 'VENTA'  
              END  
       +',Moneda:'       + CASE WHEN @mnnemo1 <> '' THEN  @mnnemo1 ELSE @mnnemo2 END  
   
 END  
  
 IF @sistema = 1  
 BEGIN  
  SET @vsql = (' INSERT INTO #MONEDASMX  SELECT mnnemo1,(SUM(' + LTRIM(RTRIM(@vcampo)) + ')) AS suma, '''+LTRIM(RTRIM(@nombrecampo))+'''    
  FROM TBL_HEDGE_FWD WITH(NOLOCK)   
  WHERE catipoper =''' + @catipoper + '''   
  AND mnnemo1 <> ''USD''       
  AND cacodpos1   = '+ @cacodpos1+ CASE WHEN @fechaconsulta <> '' THEN ' AND cafecvcto = ''' + LTRIM(RTRIM(@fechaconsulta)) + ''' OR '''+LTRIM(RTRIM(@fechaconsulta)) +'''='''' ' ELSE '' END +' GROUP BY '+@groupcampo+'')  
 END   
  
 IF (@sistema = 2 )  
 BEGIN  
/*  
  SET @vsql = (' INSERT INTO #MONEDASMX  SELECT CASE WHEN '+@groupcampo+' =13 THEN ''USD'' END AS mnnemo1 ,(SUM(' + LTRIM(RTRIM(@vcampo)) + ')) AS suma, '''+LTRIM(RTRIM(@nombrecampo))+'''  
  FROM TBL_HEDGE_SWAP WITH(NOLOCK)   
  WHERE tipo_operacion =''' + @catipoper + '''   
  AND '+@groupcampo+' = 13   
  GROUP BY '+@groupcampo+'')  
*/  

SELECT 	*, CASE WHEN compra_moneda = 0 THEN venta_moneda
		WHEN venta_moneda  = 0 THEN compra_moneda END AS Nemo_Moneda
INTO  	#TBL_HEDGE_SWAP_RESP  
  FROM TBL_HEDGE_SWAP WITH(NOLOCK)   


		SET @vsql = ('INSERT INTO #MONEDASMX  SELECT LTRIM(RTRIM(B.NEMO_MONEDA)) 
	        AS mnnemo1,(SUM(' + LTRIM(RTRIM(@vcampo)) + ')) AS suma, '''+LTRIM(RTRIM(@nombrecampo))+'''
		FROM #TBL_HEDGE_SWAP_RESP A,tbl_hedge_monedas B
		WHERE A.Nemo_Moneda= B.CODIGO_MONEDA AND tipo_operacion =''' + @catipoper + ''' 
		AND '+@groupcampo+' NOT IN (0, 999,998) GROUP BY B.NEMO_MONEDA,'+@groupcampo+'')

  
 END   
  
  EXECUTE (@vsql)   
END  

GO
