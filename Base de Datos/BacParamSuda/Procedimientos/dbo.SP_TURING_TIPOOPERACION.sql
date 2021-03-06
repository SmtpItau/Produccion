USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TURING_TIPOOPERACION]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_TURING_TIPOOPERACION]
						(@tipo_operacion  as varchar(01),
						 @Existe   as varchar(01) OUTPUT)
AS 
BEGIN TRY
 SET NOCOUNT ON
    
    	if @tipo_operacion = 'C' or @tipo_operacion = 'V' 
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
         Select  @Existe='N'
         RETURN
     END CATCH
GO
