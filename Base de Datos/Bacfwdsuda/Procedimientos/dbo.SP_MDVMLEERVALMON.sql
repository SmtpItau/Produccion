USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MDVMLEERVALMON]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_MDVMLEERVALMON]
       (
        @ncodigo     NUMERIC(03,0)   , 
        @nmes        INTEGER         ,
        @nano        INTEGER      
       )
AS   
BEGIN
SET NOCOUNT ON    
   /*=======================================================================*/
   IF @nmes = 0 BEGIN
      SELECT          vmcodigo                                               ,
                      vmvalor                                                ,
                      CONVERT( CHAR(10), vmfecha, 103 ) 
             FROM     VIEW_VALOR_MONEDA
             WHERE    vmcodigo                   = @ncodigo   AND
                      DATEPART( YEAR, vmfecha )  = @nano 
             ORDER BY vmcodigo, vmfecha
   /*=======================================================================*/
    END IF @nmes > 0 BEGIN
      SELECT          vmcodigo,
                      vmvalor,
                      vmptacmp,
                      vmptavta,
                      CONVERT( CHAR(10), vmfecha, 103 )
             FROM     VIEW_VALOR_MONEDA
             WHERE    vmcodigo                   = @ncodigo AND
                      DATEPART( MONTH, vmfecha ) = @nmes    AND
                      DATEPART( YEAR,  vmfecha ) = @nano
             ORDER BY vmcodigo, vmfecha
   END
  /*=======================================================================*/
   SET NOCOUNT OFF
END

GO
