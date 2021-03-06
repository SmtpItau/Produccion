USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONTROL_PROCESOS]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CONTROL_PROCESOS]( @Switch INTEGER )  
AS
BEGIN

     SET NOCOUNT ON

     SELECT CASE @Switch WHEN 1 THEN iniciodia
                         WHEN 2 THEN cierremesa
                         WHEN 3 THEN libor
                         WHEN 4 THEN paridad
                         WHEN 5 THEN tasamtm
                         WHEN 6 THEN tasas
                         WHEN 7 THEN findia
                                ELSE findia END
     FROM SwapGeneral

     SET NOCOUNT OFF
	
END
GO
