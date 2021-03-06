USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_TpGrabar]    Script Date: 16-05-2022 11:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_TpGrabar]( 			@prcodigo1		NUMERIC(3,0)		,
                              				@prserie1		CHAR(12)		,
                              				@prcupon1  		NUMERIC(3,0)		,
                              				@prpremio1		NUMERIC(9,4)		)
AS
BEGIN

   SET DATEFORMAT dmy
   SET NOCOUNT ON

       IF EXISTS(SELECT prcupon FROM PREMIO WHERE prcodigo = @prcodigo1 AND prserie = @prserie1 AND prcupon = @prcupon1 )
          UPDATE PREMIO SET prcodigo = @prcodigo1  ,
                          prserie  = @prserie1 ,
                          prcupon  = @prcupon1 , 
                          prpremio = @prpremio1 
                          WHERE  prcodigo = @prcodigo1 
                          AND    prserie  = @prserie1
                          AND    prcupon  = @prcupon1 
       ELSE 
           INSERT INTO PREMIO   (   prcodigo,   prserie,   prcupon,   prpremio )
                       VALUES ( @prcodigo1, @prserie1, @prcupon1, @prpremio1 )

IF @@error <> 0 BEGIN
  SELECT 'NO'
  SET NOCOUNT OFF
  RETURN
END

SELECT 'SI'

END 


GO
