USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_EXTRAE_MONEDA]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_EXTRAE_MONEDA] (@mncodmon NUMERIC(3,0))
AS
BEGIN
       SELECT mncodmon     ,  --1
              mnnemo       
  
       FROM  MONEDA
       WHERE
              mnCodMon = @mncodmon
       RETURN
END
GO
