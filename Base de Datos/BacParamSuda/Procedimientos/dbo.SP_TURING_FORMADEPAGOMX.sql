USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TURING_FORMADEPAGOMX]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_TURING_FORMADEPAGOMX]
						(@FPmx as NUMERIC(05),
						 @Existe   as varchar(01) OUTPUT)
AS 
BEGIN
 Begin try
	 SET NOCOUNT ON
	    
    		if exists(SELECT 1 FROM BacParamSuda..Forma_de_Pago WHERE Codigo=@FPmx)
			   begin
					select @Existe='S'
			   end
			else
			   begin
					select @Existe='N'
			end 
	 SET NOCOUNT OFF
     return
 End Try
 Begin Catch
	select @Existe='N'
    return	
 End Catch
END
GO
