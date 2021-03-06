USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VPTEDESCUENTO]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_VPTEDESCUENTO]( 
                                   @Monto     FLOAT ,
                                   @Tasa      FLOAT ,
                                   @Dias      FLOAT ,
                                   @VPresente FLOAT OUTPUT )
WITH RECOMPILE
AS
BEGIN

     SELECT @VPresente = @Monto  / POWER( (@Tasa / 100.) + 1. , @Dias / 365. ) 

END -- PROCEDURE

GO
