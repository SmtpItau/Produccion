USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TASA_FINAL]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_TASA_FINAL]( @CodigoTasa   INTEGER ,  
                                @CodigoMoneda INTEGER ,
                                @Desde        INTEGER ,
                                @Tasa_Final   FLOAT = 0.0 OUTPUT )
AS
BEGIN
                   
   IF EXISTS (SELECT * FROM mdtasas WHERE codigotasa   = @codigotasa
                                      AND codigomoneda = @codigomoneda
                                      AND desde        = @desde)
   BEGIN
                       
        DECLARE @nTasa       FLOAT,
        	@basOrigen   INTEGER,
        	@basConv     INTEGER

        SELECT  @nTasa       = 0.0,
        	@basOrigen   = 0,
        	@basConv     = 0

	SET ROWCOUNT 1

        SELECT @nTasa = tasa , @basOrigen = base, @basConv = baseconv
          FROM mdtasas
         WHERE codigotasa   = @CodigoTasa
           AND codigomoneda = @CodigoMoneda
           AND desde        = @desde
         ORDER BY desde
        
        SET ROWCOUNT 0
 
    
        DECLARE @a FLOAT,
                @b FLOAT,
                @c FLOAT,
                @d FLOAT,
                @e FLOAT
 
         SELECT @a = 0.0,
                @b = 0.0,
                @c = 0.0,
                @d = 0.0,
                @e = 0.0

       IF @basOrigen <> 365  BEGIN

          IF @basOrigen <> 360  BEGIN
             SELECT @a     = (360. / (@basOrigen*1.) )
             SELECT @nTasa = ( @nTasa * @a * 1. )
          END

          SELECT @a          = @nTasa / 100.
          SELECT @b          = ((@basOrigen * 1.) / (@basConv * 1.))
          SELECT @c          = ((@a * 1.) / (@b * 1.))
          SELECT @d          = POWER( (@c + 1.), @b * 1. )
          SELECT @e          = ((@d * 1.) - 1.) * 100.

          SELECT @Tasa_Final = (@e * 1.) * (365. / 360.)

       END ELSE BEGIN

          SELECT @Tasa_Final = @nTasa * 1.


       END  -- IF base

   END -- IF exists
 
END -- PROCEDURE
GO
