USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_MDPV]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LEER_MDPV]
as
begin
        select   pvcodigo    , 
   pvserie     ,
          pvporcentaje 
 from   VIEW_PORCENTAJE_VARIACION
 order by pvserie
 end
 


GO
