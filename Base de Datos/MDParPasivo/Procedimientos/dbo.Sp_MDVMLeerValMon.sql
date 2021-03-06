USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_MDVMLeerValMon]    Script Date: 16-05-2022 11:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[Sp_MDVMLeerValMon]
       (
        @ncodigo     NUMERIC(03,0)   , 
        @nmes        INTEGER         ,
        @nano        INTEGER      
       )
AS   
BEGIN

SET NOCOUNT ON    
SET DATEFORMAT dmy

   /*=======================================================================*/
   IF @nmes = 0 BEGIN


      SELECT          	vmcodigo         ,
                      	vmvalor       ,
		      	vmptacmp  ,
			vmptavta  ,
			vmparidad,
			vmposini,
			vmposic,
			vmtotco,
			vmtotve,
                      CONVERT( CHAR(10), vmfecha, 103 ) 
             FROM     VALOR_MONEDA
             WHERE    vmcodigo                   = @ncodigo   AND
                      DATEPART( YEAR, vmfecha )  = @nano 
             ORDER BY vmcodigo, vmfecha

   /*=======================================================================*/
    END IF @nmes > 0 BEGIN



      SELECT            vmcodigo,
                        vmvalor,
                        vmptacmp,
                        vmptavta,
                        CONVERT( CHAR(10), vmfecha, 103 ),
			vmparidad,
			vmposini,
			vmposic,
			vmtotco,
			vmtotve


             FROM     VALOR_MONEDA
             WHERE    vmcodigo                   = @ncodigo AND
                      DATEPART( MONTH, vmfecha ) = @nmes    AND
                      DATEPART( YEAR,  vmfecha ) = @nano
             ORDER BY vmcodigo, vmfecha

   END

  /*=======================================================================*/
   SET NOCOUNT OFF

END



GO
