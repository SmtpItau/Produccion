USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_MONEDAS]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[SP_LEER_MONEDAS] 
as 
begin
--**********************************************************************/
--procedimiento que retorna monedas comex							   */
--creado:24-05-2011													   */	
--**********************************************************************/
set nocount on 
  select mncodmon,
         mnnemo,
         mnglosa
  from   bacparamsuda..moneda
  where  mntipmon = 2
  and    MNEXTRANJ =1 
 -- AND    MNCODMON =13
order by mnglosa
 
End
GO
