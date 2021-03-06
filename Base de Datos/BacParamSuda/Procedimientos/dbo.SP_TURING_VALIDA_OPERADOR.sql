USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TURING_VALIDA_OPERADOR]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_TURING_VALIDA_OPERADOR]
						(@usuario as varchar(20),
                         @Existe   as varchar(01) OUTPUT)
AS 
BEGIN
 Begin Try
	 SET NOCOUNT ON

		if exists(SELECT 1 FROM BacParamSuda..usuario WHERE usuario=@usuario )
			   begin
					select @Existe='S'
			   end
			else
			   begin
					select @Existe='N'
			   end	 
        RETURN 
	 SET NOCOUNT OFF
     return
 End Try
 Begin Catch
    select @Existe='N'
    RETURN
 End Catch
END
GO
