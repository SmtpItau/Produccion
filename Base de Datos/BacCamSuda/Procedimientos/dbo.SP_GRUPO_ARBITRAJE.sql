USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRUPO_ARBITRAJE]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GRUPO_ARBITRAJE]( @recibimos_swift NUMERIC (5)
                                    ,@movaluta1       DATETIME
                                    ,@mocodmon        CHAR    (3)
                                    ,@morutcli        NUMERIC (9))
AS
BEGIN
    SET NOCOUNT ON
    
    DECLARE @moneda  CHAR(3)
           ,@monto   NUMERIC(19,4)
           ,@paridad CHAR(20)
    
    CREATE TABLE #detalle_swift (
                [MONEDA]   [char]   (    3) NULL DEFAULT('')
           ,[MONTO]    [numeric](19, 4) NULL DEFAULT(0)
          ,[PARIDAD]  [numeric](19, 8) NULL DEFAULT(0),)
    SELECT @moneda  =  CASE motipope WHEN 'C' THEN mocodmon
                                    ELSE mocodcnv
                      END
          ,@monto   = CASE motipope WHEN 'C' THEN momonmo
                                    ELSE moussme
                      END
          ,@Paridad = CONVERT(CHAR(20),moparme)
      FROM MEMO 
     WHERE swift_recibimos = @recibimos_swift AND 
           movaluta1       = @movaluta1       AND
           mocodmon        = @mocodmon        AND
           morutcli        = @morutcli
    INSERT #detalle_swift(moneda,monto,paridad)
                  VALUES(@moneda,@monto,@paridad)
    SELECT * FROM #detalle_swift
     
    SET NOCOUNT OFF
END

GO
