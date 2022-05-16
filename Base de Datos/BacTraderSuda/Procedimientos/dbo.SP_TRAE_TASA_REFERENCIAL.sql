USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAE_TASA_REFERENCIAL]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_TRAE_TASA_REFERENCIAL]( @nemo CHAR(3)=''										        	
                                          )  
as 
begin

--************************************************************************/
--procedimiento TRAE TASA REFERENCIAL SOMA      						 */
--creado:24-10-2011														 */	
--************************************************************************/
	    select trtasareferencial 
        from   bacparamsuda..tasa_referencia_soma
        WHERE  trserie LIKE @nemo+'%'

END
GO
