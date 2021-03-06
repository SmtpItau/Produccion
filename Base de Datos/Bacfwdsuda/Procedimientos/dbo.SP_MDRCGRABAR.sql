USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MDRCGRABAR]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_MDRCGRABAR]
       (
        @ncodpro  NUMERIC(5,0)   ,
        @nrut     NUMERIC(9,0)   ,
        @cnombre  CHAR(40) 
       )
AS 
BEGIN
SET NOCOUNT ON
   /*=======================================================================*/
   /*=======================================================================*/
   select '1'
   IF EXISTS(
              SELECT       rcnombre
                     FROM  VIEW_TIPO_CARTERA
                     WHERE rcsistema = 'FWD'      AND
                           rccodpro  = @ncodpro   AND
                           rcrut     = @nrut
            ) BEGIN
      /*====================================================================*/
      /*====================================================================*/
      select '2'
      UPDATE       VIEW_TIPO_CARTERA
             SET   rcnombre = @cnombre
             WHERE rcsistema = 'FWD'      AND
                   rccodpro  = @ncodpro   AND
                   rcrut     = @nrut
          
   END ELSE BEGIN
      /*====================================================================*/
      /*====================================================================*/
      select '3'
      INSERT INTO VIEW_TIPO_CARTERA (
                          rcsistema  ,
                          rccodpro   ,
                          rcrut      , 
                          rcdv       ,
                          rcnombre   ,
                          rcnumcorr
                         )
             VALUES      ( 
                          'FWD'      ,  -- Forward
                          @ncodpro   ,
                          @nrut      ,
                          ''         ,
                          @cnombre   ,
                          0
                         )
   END
   /*=======================================================================*/
   /*=======================================================================*/
   
SET NOCOUNT OFF
SELECT 0
END

GO
