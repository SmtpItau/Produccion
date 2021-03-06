USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[sp_CLIENTES]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[sp_CLIENTES] 
       (
			@Cltipcli NUMERIC (5),
			@Clsector NUMERIC (5)
       )
as
BEGIN

SET NOCOUNT ON 
if  @Cltipcli <> 0 and @Clsector <> 0 

BEGIN
     SET ROWCOUNT 50
     SELECT clrut                         ,  -- 1
            cldv                          ,  -- 2
            clcodigo                      ,  -- 3
            clnombre                        -- 4
     
       FROM bacparamsuda.dbo.CLIENTE  
	WHERE Cltipcli = @Cltipcli AND 
	      clactivida = @Clsector ORDER BY clnombre

	seT ROWCOUNT 0
END
ELSE IF @Cltipcli = 0 and @Clsector = 0 
BEGIN
     SET ROWCOUNT 50
     SELECT clrut                         ,  -- 1
            cldv                          ,  -- 2
            clcodigo                      ,  -- 3
            clnombre                        -- 4
     
       FROM bacparamsuda.dbo.CLIENTE    ORDER BY clnombre
	seT ROWCOUNT 0
set nocount off
END
ELSE IF @Cltipcli = 0 and @Clsector <> 0 
BEGIN
     SET ROWCOUNT 50
     SELECT clrut                         ,  -- 1
            cldv                          ,  -- 2
            clcodigo                      ,  -- 3
            clnombre                        -- 4
     
       FROM bacparamsuda.dbo.CLIENTE  
       WHERE  clactivida = @Clsector ORDER BY clnombre
	seT ROWCOUNT 0
END
ELSE 
BEGIN
     SET ROWCOUNT 50
     SELECT clrut                         ,  -- 1
            cldv                          ,  -- 2
            clcodigo                      ,  -- 3
            clnombre                        -- 4
     
       FROM bacparamsuda.dbo.CLIENTE  
       WHERE  Cltipcli = @Cltipcli  ORDER BY clnombre 
	seT ROWCOUNT 0
END
set nocount off

END

-- Base de Datos -- 
GO
