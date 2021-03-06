USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MDVMGRABARVALMON]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_MDVMGRABARVALMON]
       (
        @ncodigo     NUMERIC(03,0)   ,
        @nvalor      NUMERIC(18,10)  ,
        @nvalorcmp   NUMERIC(18,10)  ,
        @nvalorvta   NUMERIC(18,10)  ,
        @cfecha      CHAR(10)
       ) 
AS   
BEGIN 
SET NOCOUNT ON
   /*=======================================================================*/
   DECLARE @dfecha      DATETIME
   /*=======================================================================*/
   SELECT @dfecha = CONVERT( DATETIME, @cfecha )
   /*=======================================================================*/
   IF EXISTS(
              SELECT       vmcodigo
                     FROM  VIEW_VALOR_MONEDA 
                     WHERE vmcodigo = @ncodigo  AND
                           vmfecha  = @dfecha
            ) BEGIN
      /*====================================================================*/
      UPDATE       VIEW_VALOR_MONEDA
             SET   vmvalor  = @nvalor                                       ,
                   vmptacmp = @nvalorcmp                                    ,
                   vmptavta = @nvalorvta
             WHERE vmcodigo = @ncodigo    AND
                   vmfecha  = @dfecha 
   /*=======================================================================*/
   END ELSE BEGIN
      /*====================================================================*/
      INSERT INTO VIEW_VALOR_MONEDA( vmcodigo, vmvalor,   vmptacmp,   vmptavta, vmfecha )
                VALUES ( @ncodigo, @nvalor, @nvalorcmp, @nvalorvta, @dfecha )
   END
   /*=======================================================================*/
   SET NOCOUNT OFF
   SELECT 0
END

GO
