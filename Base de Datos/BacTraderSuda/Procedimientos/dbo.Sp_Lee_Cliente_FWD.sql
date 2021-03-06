USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Lee_Cliente_FWD]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[Sp_Lee_Cliente_FWD] 
       (
				 @nrutcli     NUMERIC(9),   
			  	 @ndigito     CHAR   (1),
				 @ncodcli     NUMERIC(9),
				 @Cltipcli    numeric(5), 
				 @Clsector    numeric(5)
       )
as
BEGIN

SET NOCOUNT ON 
if  @Cltipcli <> 0 and @Clsector <> 0 
begin
          SELECT clrut                                ,  --1
                 cldv                                 ,  --2
                 clcodigo                             ,  --3
                 clnombre                               --4
          FROM  CLIENTE
	  WHERE clrut    = @nrutcli AND
	        (cldv    = @ndigito  or  @ndigito = 0) AND
        	clcodigo = @ncodcli AND
		Cltipcli = @Cltipcli AND
		clactivida = @Clsector
end
else if @Cltipcli = 0 and @Clsector = 0 
begin
          SELECT clrut                                ,  --1
                 cldv                                 ,  --2
                 clcodigo                             ,  --3
                 clnombre                               --4
          FROM  bacparamsuda.dbo.CLIENTE
	  WHERE clrut    = @nrutcli AND
	        (cldv    = @ndigito  or  @ndigito = 0) AND
        	clcodigo = @ncodcli 
end

else if @Cltipcli = 0 and @Clsector <> 0 
begin
          SELECT clrut                                ,  --1
                 cldv                                 ,  --2
                 clcodigo                             ,  --3
                 clnombre                               --4
          FROM  bacparamsuda.dbo.CLIENTE
	  WHERE clrut    = @nrutcli AND
	        (cldv    = @ndigito  or  @ndigito = 0) AND
        	clcodigo = @ncodcli AND
		clactivida = @Clsector
end 
else 
begin
          SELECT clrut                                ,  --1
                 cldv                                 ,  --2
                 clcodigo                             ,  --3
                 clnombre                               --4
          FROM  bacparamsuda.dbo.CLIENTE
	  WHERE clrut    = @nrutcli AND
	        (cldv    = @ndigito  or  @ndigito = 0) AND
        	clcodigo = @ncodcli AND
		Cltipcli = @Cltipcli 

end
SET NOCOUNT OFF
END

-- Base de Datos --
GO
