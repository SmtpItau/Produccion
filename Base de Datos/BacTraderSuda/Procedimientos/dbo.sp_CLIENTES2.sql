USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[sp_CLIENTES2]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_CLIENTES2]

 ( @Cltipcli NUMERIC (5))

AS   

BEGIN

if  @Cltipcli <> 0 

BEGIN

     SET ROWCOUNT 50
     SELECT clrut                         ,  -- 1
            cldv                          ,  -- 2
            clcodigo                      ,  -- 3
            clnombre                        -- 4

		FROM bacparamsuda.dbo.cliente  
		WHERE Cltipcli = @Cltipcli  ORDER BY clnombre
	seT ROWCOUNT 0
END

ELSE IF @Cltipcli = 0 

BEGIN

     SET ROWCOUNT 50

     SELECT clrut                         ,  -- 1
            cldv                          ,  -- 2
            clcodigo                      ,  -- 3
            clnombre                        -- 4
       FROM CLIENTE  ORDER BY clnombre
       SET ROWCOUNT 0
       set nocount off
END
END

-- dbo.sp_HELP CLIENTEs2

--   dbo.sp_CLIENTES2 0

-- select * from cliente

--select * from tipo_cliente
-- Base de Datos --
GO
