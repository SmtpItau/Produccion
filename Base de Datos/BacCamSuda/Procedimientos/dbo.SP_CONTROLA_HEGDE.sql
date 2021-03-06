USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONTROLA_HEGDE]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CONTROLA_HEGDE]
AS BEGIN
SET NOCOUNT ON
DECLARE @hedgeactual  NUMERIC(21,04) ,
 @minimohedge NUMERIC(21,04) ,
 @maximohedge NUMERIC(21,04) ,
 @minimo  INTEGER  ,
 @maximo  INTEGER  
SELECT @hedgeactual  = ( achedgeactualfuturo + achedgeactualspot ) ,
 @minimohedge = acminintraday     ,
 @maximohedge = acmaxintraday     
FROM meac
IF @hedgeactual < @minimohedge 
 SELECT @minimo = 1
IF @hedgeactual > @minimohedge 
 SELECT @maximo = 2 
SELECT @minimo , @maximo
SET NOCOUNT OFF
END

GO
