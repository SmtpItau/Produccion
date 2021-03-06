USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TDGENERAR]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_TDGENERAR]
                                 (      @SEmascara   CHAR(12)  ,
                                        @sefecha     DATETIME        ,
                                        @setera      NUMERIC (9,4)   , 
                                        @secupones   NUMERIC (3,0)  ,
                                        @senumamor   NUMERIC (3,0)   ,
                                        @sepervcup   NUMERIC (2,0)   ,
                                        @nDecimales  INTEGER         )
AS
BEGIN
set nocount on
   -- Declaro Variables
   -- =============================================
--   DECLARE @semascara   CHAR(12)
   DECLARE @cDato      CHAR(10) 
   DECLARE @cFecha     DATETIME
   DECLARE @inte       NUMERIC (9,4)  
   DECLARE @cupo       NUMERIC (3,0)  
   DECLARE @namo       NUMERIC (3,0)  
   DECLARE @pvcu       NUMERIC (2,0)  
   DECLARE @nDec       INTEGER  
   DECLARE @num_amo    INTEGER  
   DECLARE @n          NUMERIC (19,6) 
   DECLARE @f          INTEGER  
   DECLARE @ntp        NUMERIC (19,6) 
   DECLARE @flujo      NUMERIC (19,6) 
   DECLARE @aux_s      NUMERIC (19,6) 
   DECLARE @aux_cupo   INTEGER
   DECLARE @aux_inte   NUMERIC (19,6) 
   DECLARE @aux_amo    NUMERIC (19,6) 
   DECLARE @aux_fluj   NUMERIC (19,6) 
   -- Fin de Declaraci=n de variables
   -- =========================================================
   -- Asigno Valores de Parametros a variables de Procedimiento
   -- =========================================================
   SELECT @cDato = @semascara     
   SELECT @cFecha= @sefecha
   SELECT @inte  = @setera
   SELECT @cupo  = @secupones
   SELECT @namo  = @senumamor
   SELECT @pvcu  = @sepervcup
   SELECT @nDec  = @nDecimales 
   -- F=rmulas
   -- ===========================================================
 
   SELECT @num_amo = @cupo - @namo
   SELECT @n = (@pvcu / 12.0)
   SELECT @ntp =  (POWER ((1.0 + @inte / 100.0), @n) - 1.0) * 100.0
print @num_amo
   IF @num_amo = 0.0 
      if @ntp > 0
        SELECT @flujo = (100.0 * @ntp / 100.0) * POWER((1.0 + @ntp / 100.0), @cupo)  / ( POWER((1.0 + @ntp / 100.0), @cupo ) - 1.0 )
       else 
        SELECT @flujo = 0
   ELSE
      if @ntp > 0
        SELECT @flujo = (100.0 * @ntp / 100.0) * POWER((1.0 + @ntp / 100.0), @namo)  / ( POWER((1.0 + @ntp / 100.0), @namo ) - 1.0 )
         else
       SELECT @flujo = 0
   SELECT @flujo = ROUND(@flujo, @nDec)
   SELECT @aux_s = 100.0
   SELECT @f = 0
   SELECT 'mascara'   = SPACE(12)        ,
          'fecha'     = SPACE(10)        ,
          'cupon'     = 0                ,
          'interes'   = CONVERT(NUMERIC (19,6),0), 
          'amort'     = CONVERT(NUMERIC (19,6),0), 
          'flujo'     = CONVERT(NUMERIC (19,6),0), 
          'saldo'     = CONVERT(NUMERIC (19,6),0)  
   INTO  #TEMP
   DELETE FROM #TEMP  
   -- Inicio Ciclo de F=rmulas para posteriormente grabarlas en la tabla de desarrollo
   -- ================================================================================
   WHILE @f <>  @cupo
     BEGIN    
         SELECT @f = @f + 1
        
         SELECT @aux_cupo = @f
         SELECT @aux_inte = ROUND(((@ntp / 100.0) * @aux_s), @nDec)  
         IF @f = @cupo
                 BEGIN
                     SELECT @aux_amo  = @aux_s
                     SELECT @aux_fluj = (@aux_amo) + (@aux_inte)
                 END
         ELSE                                                       
                 IF @namo = @cupo
                    BEGIN 
                       SELECT @aux_fluj = @flujo
                       SELECT @aux_amo  = (@flujo) - (@aux_inte)
                    END
                 ELSE                                               
                    IF @f <= @num_amo
                       BEGIN
                          SELECT  @aux_amo = 0.0
                          SELECT  @aux_fluj = @aux_inte
                       END
    ELSE                                                          
          BEGIN
                          SELECT @aux_fluj  = @flujo
                          SELECT @aux_amo   = (@flujo) - (@aux_inte)
                       END
                                                                
         SELECT @aux_s = ( @aux_s ) - ( @aux_amo )
         IF @sefecha <> ''
            BEGIN
               SELECT @cFecha = DATEADD(Month, @aux_cupo * @pvcu, @sefecha)
            END
         IF @sefecha = '' SELECT @cFecha = NULL
       -- grabamos en la tabla de desarrollo
       -- ====================================================
   
       INSERT INTO #TEMP  (    mascara,                         fecha,     cupon,   interes,    amort,     flujo,  saldo )
                   VALUES ( @semascara, CONVERT(CHAR(10),@cFecha,101), @aux_cupo, @aux_inte, @aux_amo, @aux_fluj, @aux_s )
     END
     --   Fin de Ciclo y de grabaci=n
     -- ===============================================================================
     SELECT mascara ,
            'fecha' = CONVERT(CHAR(10),fecha,103),
            cupon   ,
            interes ,
            amort   ,
            flujo   ,
            saldo
     FROM #TEMP
set nocount off
RETURN
END

GO
