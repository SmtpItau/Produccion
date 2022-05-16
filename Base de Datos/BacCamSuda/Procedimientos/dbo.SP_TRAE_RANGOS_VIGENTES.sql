USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAE_RANGOS_VIGENTES]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_TRAE_RANGOS_VIGENTES]( @fecha  char(8))
as 
begin

--************************************************************************/
--procedimiento trae rangos vigentes para USD							 */
--creado:11-07-2011														 */	
--************************************************************************/
	select *from costos_comex where fecha =@fecha and codmoneda =13
END
GO
