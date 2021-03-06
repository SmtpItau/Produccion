USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TURING_FORMADEPAGOMN]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_TURING_FORMADEPAGOMN]
						(@FPmn as NUMERIC(05),
						 @Existe   as varchar(01) OUTPUT)
AS 
BEGIN
 Begin try
	 SET NOCOUNT ON
	    
    		if exists(SELECT 1 FROM BacParamSuda..Forma_de_Pago WHERE Codigo=@FPmn)
			   begin
					select @Existe='S'
			   end
			else
			   begin
					select @Existe='N'
			   end 
	 SET NOCOUNT OFF
     RETURN
 End try
 Begin Catch
      select @Existe='N'
      RETURN
 End Catch

END

--if exists(SELECT 1 FROM BacParamSuda..Forma_de_Pago WHERE Codigo=1999)
--			   begin
--					select 'S'
--			   end
--					else
--			   begin
--					select 'N'
--			   end 
--	
GO
