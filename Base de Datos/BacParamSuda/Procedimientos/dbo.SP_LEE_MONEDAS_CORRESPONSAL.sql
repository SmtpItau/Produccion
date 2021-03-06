USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEE_MONEDAS_CORRESPONSAL]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LEE_MONEDAS_CORRESPONSAL]  
 ( @MiTag  VARCHAR(20) )  
AS  
BEGIN  
  
 SET NOCOUNT ON  
 DECLARE @MiCodigoSwifth VARCHAR(20)  
/*  
     SET @MiCodigoSwifth = CASE WHEN @MiTag = 'BARCLAYS' THEN 'BARCGB5G'  
             WHEN @MiTag = 'STANDARD' THEN 'SCBLUS33'  
             WHEN @MiTag = 'CITIBANK' THEN 'CITIUS33'  
             ELSE          ''   
            END  
*/  
  
    SELECT @MiCodigoSwifth = isnull(CodigoSwifth,'') from BacParamSuda.dbo.sinacofi where Terminal = @MiTag  
 IF @MiCodigoSwifth = ''  
 BEGIN  
  SELECT -1, 'no se ha encontrado el Codigo Swift del cliente.', ''  
  RETURN  
 END  
  
  
 SELECT DISTINCT codigo_moneda, mnnemo, mnglosa  
   FROM BacParamSuda.dbo.CORRESPONSAL   
  INNER JOIN BacParamSuda.dbo.MONEDA ON mncodmon = codigo_moneda  
         WHERE codigo_swift = @MiCodigoSwifth  
  
END  
GO
