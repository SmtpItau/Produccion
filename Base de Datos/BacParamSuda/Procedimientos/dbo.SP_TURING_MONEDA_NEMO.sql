USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TURING_MONEDA_NEMO]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_TURING_MONEDA_NEMO]
						(@nemo as char(09),
						 @Existe   as varchar(01) OUTPUT)
AS 
BEGIN
 SET NOCOUNT ON
    
    	if exists(SELECT 1 FROM BacParamSuda..Moneda WHERE mnnemo=@nemo)
           begin
                select @Existe='S'
           end
        else
           begin
                select @Existe='N'
        end 
 SET NOCOUNT OFF
END
GO
