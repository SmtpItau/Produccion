USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MDRCELIMINACAR]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_MDRCELIMINACAR]
       ( 
        @ncodpro NUMERIC ( 5, 0 ),
        @ncodigo NUMERIC ( 9, 0 )
       )
AS
BEGIN      
SET NOCOUNT ON 
  /*=======================================================================*/
   /*=======================================================================*/
   DELETE FROM mdrc WHERE rcsistema = 'FWD' AND rccodpro =  @ncodpro AND rcrut = @ncodigo
   /*=======================================================================*/
   /*=======================================================================*/
SET NOCOUNT OFF
SELECT 0
END

GO
