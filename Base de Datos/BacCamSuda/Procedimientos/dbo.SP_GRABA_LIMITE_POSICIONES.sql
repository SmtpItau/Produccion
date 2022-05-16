USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_LIMITE_POSICIONES]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[SP_GRABA_LIMITE_POSICIONES]  (@intmin numeric (15,2),
      @intmax numeric (15,2),
      @overmin numeric (15,2),
      @overmax numeric (15,2))
as
begin
   Update meac  set ACMININTRADAY = @intmin, ACMAXINTRADAY = @intmax, ACMINOVERNIGHT = @overmin, ACMAXOVERNIGHT = @overmax
end

GO
