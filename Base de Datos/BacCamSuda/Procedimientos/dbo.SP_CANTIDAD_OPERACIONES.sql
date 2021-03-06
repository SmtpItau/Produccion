USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CANTIDAD_OPERACIONES]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_CANTIDAD_OPERACIONES]( @cTipOpe    CHAR(1),
                                          @Mercado    CHAR(4) )
AS BEGIN
SET NOCOUNT ON
 Declare @nTot  integer
 
 IF @cTipOpe = 'C' OR @cTipOpe = 'V'
  BEGIN
  SELECT @nTot = Count(*) FROM memo WHERE motipope=@cTipOpe AND motipmer=@Mercado
 END
 ELSE IF @cTipOpe = 'T'
  BEGIN
  SELECT @nTot = Count(*) FROM memo WHERE motipmer=@Mercado
             END
        ELSE IF @cTipOpe = 'A' 
  BEGIN
  SELECT @nTot = Count(*) FROM memo WHERE motipmer=@Mercado AND moestatus='A'
             END
        ELSE IF @cTipOpe = 'M'
  BEGIN
  SELECT @nTot = Count(*) FROM memo WHERE motipmer=@Mercado AND moestatus='M'
             END
 SELECT @nTot  
SET NOCOUNT OFF
END




GO
