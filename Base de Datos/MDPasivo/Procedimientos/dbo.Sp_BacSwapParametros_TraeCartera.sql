USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_BacSwapParametros_TraeCartera]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO




CREATE PROC [dbo].[Sp_BacSwapParametros_TraeCartera]
AS
BEGIN

   SET NOCOUNT ON
   SET DATEFORMAT dmy

   SET ROWCOUNT 1
   
   SELECT 
          rcrut       
         ,rcdv 
         ,rcnombre                                           
 
   FROM ENTIDAD

   SET ROWCOUNT 0

   SET NOCOUNT OFF

END




GO
