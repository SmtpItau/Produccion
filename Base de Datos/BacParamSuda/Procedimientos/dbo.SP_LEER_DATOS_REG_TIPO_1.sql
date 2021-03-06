USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_DATOS_REG_TIPO_1]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LEER_DATOS_REG_TIPO_1]
AS
BEGIN

   SET NOCOUNT ON

   SELECT Rutbanco   = CONVERT(CHAR(10), REPLICATE('0', 10 - LEN( LTRIM(RTRIM( rcrut )) 
                     + LTRIM(RTRIM( rcdv  )))) 
                     + LTRIM(RTRIM( rcrut )) 
                     + LTRIM(RTRIM( rcdv  )))
      ,   Codbanco   = CONVERT(CHAR(05), REPLICATE('0', 5 - LEN( LTRIM(RTRIM(CodDcv)))) 
                     + LTRIM(RTRIM( CodDcv )))
      ,   rutdcv     = '0966661402'
      ,   coddcv     = '22001'
   FROM   BacParamSuda.dbo.ENTIDAD with(nolock)
          INNER JOIN BACPARAMSUDA..SINACOFI with(nolock) ON clrut = rcrut 
          INNER JOIN BacParamSuda.dbo.TBL_CODIGO_CLIENTE_DCV with(nolock) ON rutcliente = rcrut

END

GO
