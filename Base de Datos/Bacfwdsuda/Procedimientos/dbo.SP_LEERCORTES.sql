USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEERCORTES]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LEERCORTES]   ( @nNumOpe  NUMERIC ( 10, 0 ) )
AS
BEGIN
   SELECT corcorrela                              ,
          CONVERT ( CHAR ( 10 ), corfecvcto, 103 ),
          corprecio
   FROM   cortes
   WHERE  cornumoper = @nNumOpe
END

GO
