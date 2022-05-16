USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAE_HAIRCUT_SOMA]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_TRAE_HAIRCUT_SOMA]( @nemo CHAR(3)=''										        	
                                          )  
as 
begin

--************************************************************************/
--procedimiento TRAE HAIRCUT SOMA      						 */
--creado:24-10-2011														 */	
--************************************************************************/
	    select hchaircut 
        from   bacparamsuda..HAIRCUT_SOMA
        WHERE  hctipoper = @nemo

END
GO
