USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_CARGA_TOTAL_SPOT_FORWARD]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GET_CARGA_TOTAL_SPOT_FORWARD](@Fecha AS DATETIME,@Source AS VARCHAR(3))
AS
BEGIN 

    SET NOCOUNT ON
    DECLARE @TOTALES_SPT AS NUMERIC(15)
    DECLARE @TOTALES_FWD AS NUMERIC(15)
    SET @TOTALES_SPT = 0
    SET @TOTALES_FWD = 0


    SELECT @TOTALES_SPT = COUNT(*) 
    FROM tbl_StdChartered_Spot_Fwd
    WHERE Fecha = @Fecha AND Source = @Source AND PureDealType = 2
        
    SELECT @TOTALES_FWD = COUNT(*) 
    FROM tbl_StdChartered_Spot_Fwd
    WHERE Fecha = @Fecha AND Source = @Source AND PureDealType = 4 

    SELECT 'SPOT'     =  @TOTALES_SPT
           ,'FORWARD' =  @TOTALES_FWD

    SET NOCOUNT OFF

END

GO
