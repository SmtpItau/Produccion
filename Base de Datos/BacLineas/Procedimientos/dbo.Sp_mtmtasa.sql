USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_mtmtasa]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






CREATE PROCEDURE [dbo].[Sp_mtmtasa] ( @codigo    NUMERIC ( 3, 0 ),
                              @dfecpro   DATETIME        ,
                              @nplazovto FLOAT
                            )
AS
BEGIN
   SET NOCOUNT ON
   --- declaraciones variables MTM Normal
   DECLARE @ntasa_mtm      FLOAT,
           @ntasamenor_mtm FLOAT,
           @ntasamayor_mtm FLOAT,
           @ndiftasas_mtm  FLOAT,
           @ninterpola_mtm FLOAT
   --- declaraciones variables VAR ( MTM con Desviación Estandar )
   DECLARE @ntasa_var      FLOAT,
           @ntasamenor_var FLOAT,
           @ntasamayor_var FLOAT,
           @ndiftasas_var  FLOAT,
           @ninterpola_var FLOAT
   --- declaraciones variables de plazo, los plazos son los mismos para ambas tasas
   DECLARE @nplazomayor FLOAT,
           @nplazomenor FLOAT,
           @ndifplazo   FLOAT
   SET ROWCOUNT 1
   SELECT   @ntasamenor_mtm = ( tasa_compra + tasa_venta ) / 2,
            @ntasamenor_var = tasa_var                        ,
            @nplazomenor    = plazo
   FROM     tasa_fwd
   WHERE    fecha   = @dfecpro   AND
            codigo  = @codigo    AND
            plazo  <= @nplazovto
   ORDER BY plazo
   DESC
   SELECT   @ntasamayor_mtm = ( tasa_compra + tasa_venta ) / 2,
            @ntasamayor_var = tasa_var                        ,
            @nplazomayor    = plazo
   FROM     tasa_fwd
   WHERE    fecha  = @dfecpro   AND
            codigo = @codigo    AND
            plazo  > @nplazovto
   ORDER BY plazo
   ASC
   SET ROWCOUNT 0
   --
   SELECT @ntasamenor_mtm = ISNULL ( @ntasamenor_mtm, 0 )
   SELECT @ntasamenor_var = ISNULL ( @ntasamenor_var, 0 )
   SELECT @nplazomenor    = ISNULL ( @nplazomenor   , 0 )
   SELECT @ntasamayor_mtm = ISNULL ( @ntasamayor_mtm, 0 )
   SELECT @ntasamayor_var = ISNULL ( @ntasamayor_var, 0 )
   SELECT @nplazomayor    = ISNULL ( @nplazomayor   , 0 )
   --
   IF @nplazovto > @nplazomenor
   BEGIN
      SELECT  @ndiftasas_mtm = @ntasamayor_mtm - @ntasamenor_mtm
      SELECT  @ndiftasas_var = @ntasamayor_var - @ntasamenor_var
      SELECT  @ndifplazo     = @nplazomayor    - @nplazomenor
      EXECUTE sp_div @ndiftasas_mtm, @ndifplazo, @ninterpola_mtm OUTPUT
      EXECUTE sp_div @ndiftasas_var, @ndifplazo, @ninterpola_var OUTPUT
      SELECT  @ntasa_mtm  = @ntasamenor_mtm + ( @ninterpola_mtm * ( @nplazovto - @nplazomenor ) )
      SELECT  @ntasa_var  = @ntasamenor_var + ( @ninterpola_var * ( @nplazovto - @nplazomenor ) )
   END 
   ELSE 
   BEGIN
      SELECT @ntasa_mtm = @ntasamenor_mtm
      SELECT @ntasa_var = @ntasamenor_var
   END
 
   SELECT ROUND ( @ntasa_mtm, 4 ), ROUND ( @ntasa_var, 4 ) 
   SET NOCOUNT OFF        
END






GO
