USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABAR_TASASMONEDAS]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_GRABAR_TASASMONEDAS]( @codmon    INTEGER ,
                                         @codtasa   INTEGER ,
                                         @fecha     CHAR(8) ,
                                         @tasa      FLOAT   ,
                                         @periodo   INTEGER )
AS   
BEGIN
     IF EXISTS (SELECT * FROM moneda_tasa WHERE codmon  = @codmon
                                               AND codtasa = @codtasa
                                               AND fecha   = @fecha
                                               AND periodo = @periodo )
     BEGIN 
          UPDATE moneda_tasa
             SET tasa    = @tasa
           WHERE codmon  = @codmon
             AND codtasa = @codtasa
             AND fecha   = @fecha
             AND periodo = @periodo
          IF @@ERROR <> 0  BEGIN
             SELECT -1, 'ERROR no se puede Actualizar Valor de Tasa'
             RETURN 1
          END
     END ELSE BEGIN
          INSERT INTO moneda_tasa( sistema  ,
                                      codmon   ,
                                      codtasa  ,
                                      fecha    ,
                                      tasa     ,
                                      tasacap  ,
                                      tasacol  ,
                                      periodo  )
                             VALUES( 'PCS'  ,
                                     @codmon   ,
                                     @codtasa  ,
                                     @fecha    ,
                                     @tasa     ,
                                     0         ,
                                     0         ,
                                     @periodo  )
          IF @@ERROR <> 0  BEGIN
             SELECT -1, 'ERROR no se puede Agregar Valor de Tasa para Moneda'
             RETURN 1
          END
     END
END  -- PROCEDURE
GO
