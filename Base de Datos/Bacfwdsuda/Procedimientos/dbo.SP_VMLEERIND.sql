USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VMLEERIND]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_VMLEERIND]
       (
        @ncodigo     NUMERIC(03,0)   , 
        @dFecha      DATETIME
       )
AS   
BEGIN
   SET NOCOUNT ON
   SELECT   vmvalor ,
            vmptacmp ,
     vmptavta
      FROM  VIEW_VALOR_MONEDA
     WHERE  vmcodigo = @ncodigo   AND
            vmfecha  = @dfecha
   SET NOCOUNT OFF
END

GO
