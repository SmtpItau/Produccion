USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DIFDIAS30]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_DIFDIAS30]  
   (   @FechaDesde   DATETIME
   ,   @FechaHasta   DATETIME
--   ,   @Valor        float  = 0.0 output
   ,   @Tipo         Varchar(4) = 'P' -- EUROPEO
   )
AS
BEGIN
   SET NOCOUNT ON

   DECLARE @iDias   INTEGER
   declare @Valor   float
   
   EXECUTE BACBONOSEXTSUDA..SVC_FMU_DIF_D30 @FechaDesde  , @FechaHasta , @iDias OUTPUT ,  @Tipo 
   select @Valor = @iDias
   SELECT @iDias

   
END
-- SP_DIFDIAS30 '20160729', '20170731', 'P' -- EUROPEO
-- SP_DIFDIAS30 '20160729', '20170731', 'PA' -- AMERICANO
-- SP_DIFDIAS30 '20160729', '20170731' -- EUROPEO
GO
