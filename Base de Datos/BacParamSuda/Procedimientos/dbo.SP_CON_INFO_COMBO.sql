USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_INFO_COMBO]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
      
CREATE PROCEDURE [dbo].[SP_CON_INFO_COMBO] (     
     @opcion      INT     = 0  ,      
     @Parametro1  CHAR(06)= '' ,  
     @Parametro2  CHAR(06)= '' ,  
     @Parametro3  CHAR(06)= '' ,  
     @Parametro4  CHAR(06)= '' ,  
     @Parametro5  CHAR(06)= '' )  
AS  
BEGIN  
  
SET NOCOUNT ON  
  
 IF @OPCION = 1 BEGIN   
  SELECT  tbcateg   
  , tbcodigo1   
  , tbtasa   
  , tbfecha                       
  , tbvalor                
  , tbglosa                                              
  , nemo         
  FROM TABLA_GENERAL_DETALLE   
  WHERE tbcateg  = @Parametro1  
  AND (tbcodigo1 = @Parametro2 OR @Parametro2= '')  
  ORDER   
  BY  tbcodigo1  
 END  
  
 IF @OPCION = 2 BEGIN   
  SELECT rcsistema   
  , rcrut     
  , RCCODPRO   
  , rcdv   
  , rcnumcorr     
  , rcnombre  
  FROM TIPO_CARTERA  
  WHERE  rcsistema = @Parametro1  
  AND  (RCCODPRO = CONVERT(INT,@Parametro2) OR @Parametro2 = '')  
  AND (rcrut  = CONVERT(INT,@Parametro3) OR @Parametro3 = '')  
 END  
  
 IF @OPCION = 3 BEGIN   
  SELECT  A.tbcateg   
  , A.tbcodigo1   
  , A.tbtasa   
  , A.tbfecha                       
  , A.tbvalor                
  , A.tbglosa                                              
  , A.nemo         
  FROM TABLA_GENERAL_DETALLE  A  
  , TABLA_GENERAL_DETALLE  B  
  , TABLA_GENERAL_DETALLE  C  
  WHERE A.tbcateg  = @Parametro1  
  AND B.tbcateg  = @Parametro2  
  AND C.tbcateg  = @Parametro3  
  AND A.tbcodigo1  = C.tbcodigo1  
  AND B.tbcodigo1  = C.tbglosa  
  AND (B.tbcodigo1  = @Parametro4 OR @Parametro4 = '')  
  ORDER   
  BY  A.tbcodigo1  
 END  
  
  
 IF @OPCION = 4 BEGIN  
   
  SELECT ''  
  , RPL_IDLIBRO   
  , ''  
  , ''  
  , ''  
  , TBGLOSA  
  FROM TBL_RELACION_PRODUCTO_LIBRO  
  , TABLA_GENERAL_DETALLE  
  WHERE RPL_IDSISTEMA = @Parametro1  
  AND RPL_IDPRODUCTO = @Parametro2  
  AND (RPL_IDLIBRO = @Parametro3 OR @Parametro3 = '')  
  AND TBCATEG  = @Parametro4  
  AND TBCODIGO1 = RPL_IDLIBRO  
 END  
  
 IF @OPCION = 5 BEGIN  
  
  SELECT ''  
  , RLC_IDCARTERASUPER  
  , ''  
  , ''  
  , ''  
  , TBGLOSA  
  FROM TBL_RELACION_LIBRO_CARTERASUPER  
  , TABLA_GENERAL_DETALLE  
  WHERE RLC_IDSISTEMA  = @Parametro1  
  AND RLC_IDPRODUCTO  = @Parametro2  
  AND RLC_IDLIBRO  = @Parametro3   
  AND (RLC_IDCARTERASUPER = @Parametro4 OR @Parametro4 = '')  
  AND TBCATEG   = @Parametro5  
  AND TBCODIGO1 = RLC_IDCARTERASUPER  
 END  
  
    IF @OPCION = 6 BEGIN -- PERIODICIDAD INTERFAZ    
        SELECT tbcateg       
        ,      tbcodigo1       
        ,      tbtasa       
        ,      tbfecha                           
        ,      tbvalor                    
        ,      tbglosa                                                  
        ,      nemo             
        FROM   TABLA_GENERAL_DETALLE       
        WHERE  tbcateg    = CONVERT(NUMERIC(4,0), @Parametro1)    
        ORDER       
        BY     CONVERT(INT,TBCODIGO1)      
    END      
      
        IF @OPCION = 8 BEGIN -- CODIGO Y NOMBRE DE MONEDAS  
  SELECT ''  
  , mncodmon   
  , ''  
  , ''  
  , ''  
  , LTRIM(RTRIM(mnnemo)) + SPACE(8-LEN(mnnemo)) + LTRIM(RTRIM(mnglosa))  
  FROM BACPARAMSUDA..MONEDA  
  WHERE (mncodmon = CONVERT(INT,@Parametro1) OR @Parametro1 = '')  
  AND mntipmon IN (@Parametro1, @Parametro2, @Parametro3, @Parametro4, @Parametro5)  
  AND     mncodmon  <> 13  
  ORDER  
  BY mnnemo  
 END  
  
 IF @OPCION = 9 BEGIN   
  
  -- sp_con_info_combo 9, 'CP', 'BTR', '204', '', ''  
  SELECT rcsistema   
  , rcrut     
  , RCCODPRO   
  , rcdv   
  , rcnumcorr     
  , tbglosa --rcnombre  
  FROM TIPO_CARTERA  
  , TABLA_GENERAL_DETALLE  
  WHERE  (RCCODPRO  = @Parametro1 OR @Parametro1 = '')  
  AND  rcsistema  = @Parametro3  
  AND (rcrut   = CONVERT(INT,@Parametro4) OR @Parametro4 = '')  
  AND (tbcateg  = @Parametro2 OR @Parametro2 = '')  
  AND tbcodigo1  = LTRIM(RTRIM(CONVERT(CHAR,rcrut)))  
END  
 SET NOCOUNT OFF  
  
END
GO
