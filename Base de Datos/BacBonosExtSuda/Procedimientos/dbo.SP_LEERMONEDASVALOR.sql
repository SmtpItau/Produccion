USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEERMONEDASVALOR]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_LEERMONEDASVALOR]
       (
        @ncodigo     NUMERIC(5,0)    , -- Código moneda
        @dfecpro     DATETIME          -- Fecha de Proceso 
       )
AS
BEGIN
   /*=======================================================================*/
   SELECT       mncodmon                                  ,
                mnglosa                                   ,
                mnnemo                                    ,
                mnfactor                                  ,
                mnredondeo                                ,
                mncodbanco                                ,
                mncodsuper                                ,
                mnbase                                    ,
                mnrefusd                                  ,
                mnlocal                                   ,
                mnextranj                                 ,
                'mnvalor'  = ISNULL( vmvalor, 0 )         ,
                mnrefmerc                                 ,
                mningval                                  ,
                mnrrda        				  ,
		'vmptacmp' = isnull(vmptacmp,0)                                  ,
	        vmptavta	
          FROM  VIEW_MONEDA
          LEFT OUTER JOIN VIEW_VALOR_MONEDA
          ON mncodmon  = vmcodigo
          WHERE mncodmon   = @ncodigo                  AND                
                vmfecha    = @dfecpro
   /*=======================================================================*/
  
 RETURN
END

GO
