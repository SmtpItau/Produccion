USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VERIFICA_PVMD]    Script Date: 16-05-2022 12:48:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_VERIFICA_PVMD]
                  ( @serie  CHAR(10),
             @tir    FLOAT,
      @fecha  DATETIME )
AS BEGIN
set nocount on
   DECLARE @cota_sup    NUMERIC (19,02) ,
        @cota_inf    NUMERIC (19,02) ,
        @porcentaje  NUMERIC (19,02)
 
         EXECUTE Sp_Verifica_Mdpv  @serie, 
     @tir, 
     @fecha,
      @cota_sup   OUTPUT, 
     @cota_inf OUTPUT, 
     @porcentaje OUTPUT 
 SELECT  @cota_sup    , 
  @cota_inf , 
  @porcentaje
set nocount off
end

GO
