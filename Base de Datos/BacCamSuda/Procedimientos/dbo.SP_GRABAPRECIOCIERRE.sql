USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABAPRECIOCIERRE]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GRABAPRECIOCIERRE]( @precio_cierre NUMERIC(15,04) )
AS
BEGIN
SET NOCOUNT ON
 UPDATE  meac 
 SET acprecie = @precio_cierre
 EXECUTE Sp_Recalc 'USD',  'PTAS', 'C', 0, 0, '' /*REQ.7619 ENVIABA ERROR*/
SET NOCOUNT OFF
END

GO
