USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BROKERGRABAR]    Script Date: 13-05-2022 10:30:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_BROKERGRABAR]
       (
        @nrut     NUMERIC(9,0)   ,
        @cdv      CHAR(1)        ,
        @cnombre  CHAR(40) 
       )
AS 
BEGIN
SET NOCOUNT ON
   IF EXISTS( SELECT 1
              FROM   MFBROKER
              WHERE  brokrut    = @nrut   AND
                     brokdv     = @cdv     AND
                     broknombre = @cnombre
            ) BEGIN
       UPDATE MFBROKER
       SET    broknombre = @cnombre
       WHERE  brokrut = @nrut AND
              brokdv  = @cdv
          
   END
   ELSE BEGIN
      INSERT INTO MFBROKER ( brokrut   ,
                             brokdv    ,
                             broknombre
                           )
      VALUES               ( @nrut      ,
                             @cdv       ,
                             @cnombre
                            )
   END
SET NOCOUNT OfF
SELECT 0
END

GO
