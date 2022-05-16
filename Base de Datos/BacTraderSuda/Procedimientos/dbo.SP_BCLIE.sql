USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BCLIE]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[SP_BCLIE]  
               (@rut NUMERIC (9),
                @cod NUMERIC (9) )
                    
AS
                    
BEGIN
--  SELECT dv,RAZON_SOCIAL  FROM  BACSTOCK..GEN_CLIENTES  
    SELECT cldv,clnombre  FROM  VIEW_CLIENTE  
    WHERE clrut = @rut AND @cod = clcodigo       
END
/*
sp_bclie 12345678,35
select clrut, clcodigo  from bactraderamex..VIEW_CLIENTE
*/

GO
