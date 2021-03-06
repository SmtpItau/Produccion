USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TURING_FWDPRODUCTO]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_TURING_FWDPRODUCTO]
						(@producto as NUMERIC(02),
						 @Existe   as varchar(01) OUTPUT)
AS 
BEGIN TRY
 SET NOCOUNT ON
    
    	if exists(SELECT 1 FROM BacParamSuda..PRODUCTO WHERE id_sistema = 'BFW' and codigo_producto=@producto)
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
         -- que se trague la caida
         select @Existe = 'N'  
         RETURN
END CATCH

GO
