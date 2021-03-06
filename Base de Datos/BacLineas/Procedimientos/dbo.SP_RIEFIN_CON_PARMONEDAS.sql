USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_RIEFIN_CON_PARMONEDAS]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_RIEFIN_CON_PARMONEDAS]  
      ( @OPCION   INT  
      , @FechaProceso  DATETIME =''  
      , @FechaAyer     DATETIME =''  
      )  
AS  
BEGIN  
-- SP_RIEFIN_CON_PARMONEDAS 2   
   SET NOCOUNT ON  
 IF @OPCION = 1 -- Carga par de Monedas  
 BEGIN  
  SELECT lcrgrumdacod   
  ,  LCRParMda1  
  ,  LCRParMda2  
  FROM    LCRPARMDAGRUMDA  
 END  
    
  
 IF @OPCION = 2 -- Carga producto asociado al riesgo  
 BEGIN  
  SELECT Producto.Id_Sistema  
     ,  'Codigo_Producto'=  CASE   
          WHEN Codigo_Producto = 'ST' THEN '1'  
          WHEN Codigo_Producto = 'SM' THEN '2'  
          WHEN Codigo_Producto = 'FR' THEN '3'  
          WHEN Codigo_Producto = 'SP' THEN '4'  
         ELSE  Codigo_Producto  
         END  
     ,  Ponderadores.LCRGruMdaCod  
     ,  Ponderadores.LCRPla  
     ,  Ponderadores.LCRPon   
     ,  Ponderadores.Codigo_Riesgo                 
         
  FROM LCRRieParMdaPon  Ponderadores  
  ,  BacParamSuda..Producto Producto  
  WHERE   Producto.Riesgo_Interno = Codigo_Riesgo  
  AND Ponderadores.codigo_riesgo <> 2 --PRD20426
  ORDER BY Id_Sistema  
  ,        Codigo_Producto  
  ,   Codigo_Riesgo  
  ,   Ponderadores.LCRGruMdaCod   
  ,   LCRPla   
 END  
    
 IF @OPCION = 3 -- Carga Valor Moneda  
 BEGIN  
  SELECT vmcodigo  
  ,  vmfecha  
  ,  vmValor  
  INTO #TmpValMda    
  FROM BacParamSuda..VALOR_MONEDA   
        WHERE vmfecha  = @FechaProceso  
          
  DELETE #TmpValMda WHERE vmcodigo = 998 
  
  INSERT INTO #TmpValMda
  SELECT vmcodigo    
  ,  vmfecha    
  ,  vmValor      
  FROM BacParamSuda..VALOR_MONEDA     
        WHERE vmfecha  =  (  select acFecProc from BacTraderSuda..mdac  )
  
  SELECT * FROM #TmpValMda
            
 END  
   
 IF @OPCION = 4 --Carga Moneda Contable  
 BEGIN  
  SELECT  codigo_moneda    
  ,  fecha  
  ,  Tipo_Cambio  
  FROM BacParamSuda..VALOR_MONEDA_CONTABLE   
        WHERE fecha =@FechaAyer  
           
 END  
   
 IF @OPCION =5   
 BEGIN  
   SELECT fechaant  FROM BacSwapSuda..SWAPGENERAL with(nolock)  
 END  
   
 IF @OPCION = 6 -- Carga producto asociado al riesgo  
 BEGIN  
     SELECT Producto.Id_Sistema  
   ,  'Codigo_Producto'=  CASE   
          WHEN Codigo_Producto = 'ST' THEN '1'  
          WHEN Codigo_Producto = 'SM' THEN '2'  
          WHEN Codigo_Producto = 'FR' THEN '3'  
          WHEN Codigo_Producto = 'SP' THEN '4'  
         ELSE  Codigo_Producto  
         END  
  ,  Ponderadores.LCRGruMdaCod  
  ,  Ponderadores.LCRPla  
  ,  Ponderadores.LCRPon   
  ,  Ponderadores.Codigo_Riesgo                 
         
  FROM LCRRieParMdaPon  Ponderadores  
  ,  BacParamSuda..Producto Producto  
  WHERE   Producto.Riesgo_Interno = Codigo_Riesgo
  AND Ponderadores.codigo_riesgo <> 2 --PRD20426  
  ORDER BY Id_Sistema  
  ,   Codigo_Producto  
  ,   Codigo_Riesgo  
  ,   Ponderadores.LCRGruMdaCod   
  ,   LCRPla DESC  
 END  
 IF @OPCION = 7 -- Ponderarores asociados al riesgo moneda  Plazo menor
 BEGIN  
  SELECT Producto.Id_Sistema  
  ,  'Codigo_Producto'=  CASE   
          WHEN Codigo_Producto = 'ST' THEN '1'  
          WHEN Codigo_Producto = 'SM' THEN '2'  
          WHEN Codigo_Producto = 'FR' THEN '3'  
          WHEN Codigo_Producto = 'SP' THEN '4'  
         ELSE  Codigo_Producto  
         END  
  ,  Ponderadores.LCRGruMdaCod  
  ,  Ponderadores.LCRPla  
  ,  Ponderadores.LCRPon   
  ,  Ponderadores.Codigo_Riesgo
  ,  Ponderadores.lcrTipoBID_ASK                    
   
  FROM LCRRieParMdaPon  Ponderadores  
  ,  BacParamSuda..Producto Producto  
  WHERE   Producto.Riesgo_Interno = Codigo_Riesgo  
  AND Ponderadores.codigo_riesgo = 2 --PRD20426
  ORDER BY Id_Sistema  
  ,   Codigo_Producto  
  ,   Codigo_Riesgo  
  ,   Ponderadores.LCRGruMdaCod 
  ,   Ponderadores.lcrTipoBID_ASK  
  ,   LCRPla   
END  

 IF @OPCION = 8 --Ponderarores asociados al riesgo moneda  Plazo Mayor
 BEGIN  
   SELECT Producto.Id_Sistema  
   ,  'Codigo_Producto'=  CASE   
          WHEN Codigo_Producto = 'ST' THEN '1'  
          WHEN Codigo_Producto = 'SM' THEN '2'  
          WHEN Codigo_Producto = 'FR' THEN '3'  
          WHEN Codigo_Producto = 'SP' THEN '4'  
         ELSE  Codigo_Producto  
         END  
  ,  Ponderadores.LCRGruMdaCod  
  ,  Ponderadores.LCRPla  
  ,  Ponderadores.LCRPon   
  ,  Ponderadores.Codigo_Riesgo
  ,  Ponderadores.lcrTipoBID_ASK                 
         
  FROM LCRRieParMdaPon  Ponderadores  
  ,  BacParamSuda..Producto Producto  
  WHERE   Producto.Riesgo_Interno = Codigo_Riesgo  
  AND Ponderadores.codigo_riesgo = 2 --PRD20426
  ORDER BY Id_Sistema  
  ,   Codigo_Producto  
  ,   Codigo_Riesgo  
  ,   Ponderadores.LCRGruMdaCod 
  ,   Ponderadores.lcrTipoBID_ASK    
  ,   LCRPla DESC  
 END  
   
END  
GO
