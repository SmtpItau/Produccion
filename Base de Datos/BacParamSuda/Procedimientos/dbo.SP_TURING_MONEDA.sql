USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TURING_MONEDA]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SP_TURING_MONEDA 13,''
CREATE PROCEDURE [dbo].[SP_TURING_MONEDA]
						(@moneda NUMERIC(05) ,
						 @Existe  varchar(01) OUTPUT)
AS 
BEGIN TRY
 SET NOCOUNT ON
    
    	if exists(SELECT 1 FROM BacParamSuda..Moneda WHERE mncodmon=@moneda)
           begin
                select @Existe='S'
           end
        else
           begin
                select @Existe='N'
        end
        RETURN 
 SET NOCOUNT OFF
END TRY

BEGIN CATCH
         select @Existe='N'
         RETURN
END CATCH
GO
