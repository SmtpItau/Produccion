USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEERMEDIA]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LEERMEDIA] ( @dfechainicial DATETIME          ,
                                @dfechafinal   DATETIME          ,
                                @ncodigo       NUMERIC ( 05, 00 ),
                                @nplazo        NUMERIC ( 05, 00 ),
                                @nmedia        FLOAT
                              )
AS
BEGIN
   DECLARE @npuntofwd           AS FLOAT
   DECLARE @ndesviacionestandar AS FLOAT
   SET NOCOUNT ON
   SELECT ISNULL ( AVG ( punto_fwd ), 0 )             ,
          SUM ( POWER( ( punto_fwd - @nmedia ) , 2 ) )
   FROM   view_tasa_fwd
   WHERE  fecha  >= @dfechainicial AND
          fecha  <= @dfechafinal   AND
          codigo  = @ncodigo       AND
          plazo   = @nplazo
   SET NOCOUNT OFF
END

GO
