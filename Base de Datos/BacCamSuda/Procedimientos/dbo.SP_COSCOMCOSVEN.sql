USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_COSCOMCOSVEN]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_COSCOMCOSVEN] 
        (@SW NUMERIC(1)) -- compra 0     venta 1
AS
BEGIN
   IF @SW = 0
 SELECT accoscomp , actcierre FROM MEAC 
   ELSE
   BEGIN
 SELECT accosvent , actcierre FROM MEAC 
   END
END

GO
