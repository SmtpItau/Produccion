USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_OBTIENE_MONEDA_POR_MNEMO]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[SP_OBTIENE_MONEDA_POR_MNEMO]  
@MNEMO AS VARCHAR(5)  
AS  
SELECT mncodmon FROM MONEDA m  
WHERE MNNEMO = @MNEMO  
GO
