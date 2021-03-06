USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABARCORTES]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_GRABARCORTES]( @nnumoper      NUMERIC ( 10 )		,
                                   @ncorrelativo  NUMERIC ( 10 )	,
                                   @dfecvctocorte DATETIME      	,                                        
                                   @nprecio       FLOAT			,
				   @base	  NUMERIC(4)
                                 )
AS
BEGIN
   SET NOCOUNT ON
   INSERT INTO cortes ( cornumoper,
                        corcorrela,
                        corprecio ,
                        corfecvcto,
                        corestado ,
			corbase
                      )
   VALUES             ( @nnumoper    	,
                        @ncorrelativo	,
                        @nprecio     	,
                        @dfecvctocorte	,
                        0		,
			@base
                      )
   SELECT 0
   SET NOCOUNT OFF

END


GO
