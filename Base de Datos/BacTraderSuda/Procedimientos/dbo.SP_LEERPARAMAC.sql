USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEERPARAMAC]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LEERPARAMAC]
as 
begin
          select convert(char(10) ,
                 acfecproc,103), 
                 convert(char(10) ,
                 acfecprox,103), 
                 acsw_pd 
          from MDAC
          return 
end


GO
