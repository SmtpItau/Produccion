USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONTROLA_OVERNIGHT]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CONTROLA_OVERNIGHT]
AS BEGIN
SET NOCOUNT ON
DECLARE @hedgeactual   NUMERIC(21,04) ,
 @minimoovernight NUMERIC(21,04) ,
 @maximoovernight NUMERIC(21,04) ,
 @minimo   INTEGER  ,
 @maximo   INTEGER  
 SELECT  @hedgeactual   = ( achedgeactualfuturo + achedgeactualspot ) ,
  @minimoovernight = ISNULL(acminovernight,0)    ,
  @maximoovernight = ISNULL(acmaxovernight,0)
 FROM   meac
IF @hedgeactual < @minimoovernight 
 SELECT @minimo = 1
IF @hedgeactual > @maximoovernight 
 SELECT @maximo = 2 
SELECT ISNULL(@minimo,0) , ISNULL(@maximo,0) , @minimoovernight , @maximoovernight
SET NOCOUNT OFF
END

GO
