USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MDRCLEERCODIGO]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_MDRCLEERCODIGO]
       (
        @ncodpro NUMERIC(5,0)
       )
AS
BEGIN
   SET NOCOUNT ON 
   /*=======================================================================*/
   SELECT       rcrut     ,
         rcnombre  
          FROM  VIEW_TIPO_CARTERA
          WHERE rcsistema = 'BFW' AND rccodpro = @ncodpro
   ORDER BY rcrut
   /*=======================================================================*/
   
   SET NOCOUNT OFF
END

GO
